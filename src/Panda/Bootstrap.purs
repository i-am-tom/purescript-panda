module Panda.Bootstrap where

import Control.Alt              ((<|>))
import Control.Apply            (lift2)
import Control.Monad.Eff        (Eff)
import Control.Plus             (empty)
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Filterable          (filtered)
import Data.Foldable            (foldr, sequence_)
import Data.Lazy                (force)
import Data.Maybe               (Maybe(..))
import Data.Traversable         (sequence, traverse)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, withLast, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types
import Prelude                  ((<>), (*>), Unit, bind, discard, id, map, pure, unit, when)
import Util.Exists              (runExists3)
import Debug.Trace              (spy)

-- | Set up and kick off a Panda application. This creates the element tree,
-- and ties the update handler to the event stream.
bootstrap
  ∷ ∀ update state event
  . DOM.Document
  → Types.Application _ update state event
  → Eff _
      { cancel ∷ Types.Canceller _
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Types.Canceller _
      }

bootstrap document { initial, subscription, update, view } = do
  renderedPage ← render document view

  states     ← FRP.create
  cancellers ← FRP.create

  let
    dispatcher
      ∷ { state ∷ state, update ∷ update }
      → Eff _ Unit
    dispatcher decision = do
      states.push decision.state
      cancellers.push (renderedPage.handleUpdate (spy {decision}).decision)

    events ∷ FRP.Event event
    events = subscription <|> renderedPage.events

    sampler :: event -> state -> Types.Canceller _
    sampler event state
      = update dispatcher (spy { event, state })

    unitUpdates :: FRP.Event (Eff _ Unit)
    unitUpdates
      = FRP.sampleOn
          (states.event <|> pure initial.state)
          (map sampler events)

  cancelCancellers <- FRP.subscribe (FRP.withLast cancellers.event) \{ last } ->
    sequence_ last

  cancelApplication <- FRP.subscribe (unitUpdates <|> pure (dispatcher initial)) id

  dispatcher initial

  pure
    ( renderedPage
        { cancel = cancellers.push (pure unit) *> cancelCancellers -- 
        }
    )

-- | Render the "view" of an application. This is the function that actually
-- produces the DOM elements, and any rendering of a delegate will call
-- `bootstrap`. This is also where the event handlers and cancellers are
-- computed.

render
  ∷ ∀ update state event
  . DOM.Document
  → Types.Component _ update state event
  → Eff _
      { cancel ∷ Types.Canceller _
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Eff _ Unit
      }

render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document

        pure
          { cancel: pure unit
          , element: DOM.textToNode element
          , events: empty
          , handleUpdate: \_ → pure unit
          }

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        parent ← DOM.createElement tagName document
        renderedProps ← traverse (Property.render parent) properties

        let
          prepare child = do
            { cancel, events, element, handleUpdate }
                ← render document child

            _ ← DOM.appendChild element (DOM.elementToNode parent)
            pure { cancel, events, handleUpdate }

          -- TODO: monoidalise this.
          combineEventSystems
            = lift2 \this that →
                { handleUpdate: \update → do
                    this.handleUpdate update
                    that.handleUpdate update

                , events: this.events <|> that.events
                , cancel: this.cancel *> that.cancel
                }

          initial
            = pure
                { cancel: pure unit
                , events: empty
                , handleUpdate: \_ → pure unit
                }

          combinables
            =  map prepare children
            <> map pure renderedProps

        aggregated
          ← foldr combineEventSystems initial combinables

        pure
          { cancel: aggregated.cancel
          , element: DOM.elementToNode parent
          , events: aggregated.events
          , handleUpdate: aggregated.handleUpdate
          }

      Types.CDelegate delegateE →
        let
          process
            = runExists3 \(Types.ComponentDelegate { delegate, focus }) → do
                { cancel, events, element, handleUpdate }
                    ← bootstrap document delegate

                pure
                  { cancel
                  , events: map focus.event events
                  , element
                  , handleUpdate: \{ state, update } →
                      case focus.update update of
                        Just subupdate →
                          handleUpdate
                            { update: subupdate
                            , state:  focus.state state
                            }

                        Nothing →
                          pure unit
                  }

        in process delegateE

      Types.CWatcher (Types.ComponentWatcher listener) → do
        -- TODO: don't create an element for a watcher.
        parent ← map DOM.elementToNode (DOM.createElement "div" document)

        { event: output,     push: toOutput }          ← FRP.create
        { event: cancellers, push: registerCanceller } ← FRP.create

        cancelWatcher ← FRP.subscribe (FRP.withLast cancellers) \{ last } →
          sequence_ last

        let
          updater update = do
            let { interest, renderer } = listener update

            when interest do
              { cancel, element, events, handleUpdate }
                  ← render document (force renderer)

              firstChild ← DOM.firstChild parent

              case firstChild of
                Just elem → do
                  _ ← DOM.removeChild elem parent
                  pure unit

                Nothing →
                  pure unit

              _ ← DOM.appendChild element parent

              cancelEvents ← FRP.subscribe events toOutput
              registerCanceller (cancel *> cancelEvents)

        pure
          { cancel: registerCanceller (pure unit) *> cancelWatcher
          , events: output
          , element: parent
          , handleUpdate: updater
          }

