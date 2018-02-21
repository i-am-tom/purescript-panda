module Panda.Bootstrap where

import Control.Alt          ((<|>))
import Control.Apply        (lift2)
import Control.Monad.Eff    (Eff)
import Control.Plus         (empty)
import DOM.Node.Document    (createElement, createTextNode) as DOM
import DOM.Node.Node        (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types       (Document, Node, elementToNode, textToNode) as DOM
import Data.Filterable      (filtered)
import Data.Foldable        (foldr, sequence_)
import Data.Traversable     (traverse)
import Data.Lazy            (force)
import Data.Maybe           (Maybe(..))
import Data.Traversable     (sequence)
import FRP.Event            (Event, create, subscribe) as FRP
import FRP.Event.Class      (fold, withLast) as FRP
import Panda.Internal.Types as Types
import Panda.Property       as Property
import Util.Exists          (runExists3)

import Prelude

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

bootstrap document { view, subscription, update } = do
  renderedPage ← render document view

  initUpdateState <- update Nothing

  let
    prepare
      ∷ event
      → Maybe state
      → Eff _
          { update ∷ update
          , state ∷ state
          }
    prepare event state
      = update (map { state: _, event } state)

    events
      ∷ FRP.Event event
    events
      = subscription <|> renderedPage.events

    -- Compute an update and new state based on an event.
    loop
      ∷ (Maybe state → Eff _ { update ∷ update, state ∷ state })
      → Maybe (Eff _ { update ∷ update, state ∷ state })
      → Maybe (Eff _ { update ∷ update, state ∷ state })
    loop updater previous
      = Just do
          last ← sequence previous
          updater (map _.state last)

    updates
      ∷ FRP.Event (Eff _ { update ∷ update, state ∷ state })
    updates
      = filtered (FRP.fold loop (map prepare events) (Just (pure initUpdateState)))

    handleUpdate
      ∷ Eff _ { update ∷ update, state ∷ state }
      → Types.Canceller _
    handleUpdate update'
      = update' >>= renderedPage.handleUpdate

  cancelApplication ← FRP.subscribe updates handleUpdate

  pure renderedPage
    { cancel
        = renderedPage.cancel *> cancelApplication
    }

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
        renderedProps <- traverse (Property.render parent) properties

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

        aggregated
          ← foldr combineEventSystems initial (map prepare children <> (pure <$> renderedProps))

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

