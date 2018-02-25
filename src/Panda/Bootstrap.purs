module Panda.Bootstrap where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Plus             (empty)
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Foldable            (fold, for_, sequence_)
import Data.Lazy                (force)
import Data.Maybe               (Maybe(..))
import Data.Monoid              (mempty)
import Data.Traversable         (for, traverse)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, withLast, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types
import Util.Exists              (runExists3)

import Prelude

-- | Set up and kick off a Panda application. This creates the element tree,
-- and ties the update handler to the event stream.
bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { cancel ∷ Types.Canceller (Types.FX eff)
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Types.Canceller (Types.FX eff)
      }

bootstrap document { initial, subscription, update, view } = do
  renderedPage ← render document view
  deltas       ← FRP.create

  let
    -- | Iterations of state as updates are applied. The most recent value is
    -- the current state.
    states' ∷ FRP.Event { state ∷ state, update ∷ update }
    states' = FRP.fold (\delta { state } → delta state) deltas.event initial

    -- | Same as states', but will default to the initial state until the first
    -- delta has been provided.
    states ∷ FRP.Event { state ∷ state, update ∷ update }
    states = pure initial <|> states'

    -- | Events, either internal or external.
    events ∷ FRP.Event event
    events = subscription <|> renderedPage.events

    -- | Given the most up-to-date state and the event, produce an input for an
    -- application's `update` function.
    loop
      ∷ event
      → { state ∷ state, update ∷ update }
      → { state ∷ state, event  ∷ event  }
    loop event { state }
      = { event, state }

    -- | The stream of events that trigger the application's `update` function.
    prepared ∷ FRP.Event { event ∷ event, state ∷ state }
    prepared = FRP.sampleOn states (map loop events)

  cancelRenderer    ← FRP.subscribe states renderedPage.handleUpdate
  cancelApplication ← FRP.subscribe prepared (update deltas.push)

  let cancel = renderedPage.cancel    -- Cancel the listener tree
                 *> cancelRenderer    -- Cancel the render loop
                 *> cancelApplication -- Cancel the dispatch loop

  pure (renderedPage { cancel = cancel })

-- | Render the "view" of an application. This is the function that actually
-- produces the DOM elements, and any rendering of a delegate will call
-- `bootstrap`. This is also where the event handlers and cancellers are
-- computed.
render
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Component (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { cancel ∷ Types.Canceller (Types.FX eff)
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Eff (Types.FX eff) Unit
      }

render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document

        pure
          { cancel: mempty
          , element: DOM.textToNode element
          , events: empty
          , handleUpdate: mempty
          }

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        parent ← DOM.createElement tagName document
        renderedProps ← traverse (Property.render parent) properties

        prepared ← for children \child → do
          { cancel, events, element, handleUpdate }
              ← render document child

          _ ← DOM.appendChild element (DOM.elementToNode parent)
          pure (Types.EventSystem { cancel, events, handleUpdate })

        let (Types.EventSystem aggregated)
              = fold (prepared <> renderedProps)

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
            let possibleUpdate = listener update

            for_ possibleUpdate \component → do
              { cancel, element, events, handleUpdate }
                  ← render document component

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

