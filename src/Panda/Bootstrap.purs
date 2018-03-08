module Panda.Bootstrap where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    (Ref, newRef, readRef, writeRef) as Ref
import Control.Plus             (empty)
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild, removeChild) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Foldable            (fold, sequence_)
import Data.Maybe               (Maybe(..))
import Data.Monoid              (mempty)
import Data.Traversable         (traverse)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, withLast, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types

import Prelude

-- | Set up and kick off a Panda application. This creates the element tree,
-- | and ties the update handler to the event stream.
bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → DOM.Node
  → Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

bootstrap document parent { initial, subscription, update, view } = do
  (Types.EventSystem renderedPage) ← render document parent view
  deltas                           ← FRP.create

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

  pure (Types.EventSystem (renderedPage { cancel = cancel }))

-- | Render the "view" of an application. This is the function that actually
-- | produces the DOM elements, and any rendering of a delegate will call
-- | `bootstrap`. This is also where the event handlers and cancellers are
-- | computed.
render
  ∷ ∀ eff update state event
  . DOM.Document
  → DOM.Node
  → Types.Component (Types.FX eff) update state event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)
render document parent
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document
        let elementNode = DOM.textToNode element

        _ ← DOM.appendChild elementNode parent

        pure
          ( Types.EventSystem
              { cancel: do
                  _ ← DOM.removeChild elementNode parent
                  pure unit
              , events: empty
              , handleUpdate: mempty
              }
          )

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        static        ← DOM.createElement tagName document
        renderedProps ← traverse (Property.render static) properties

        let staticNode = DOM.elementToNode static
        prepared ← traverse (render document staticNode) children

        let (Types.EventSystem aggregated) = fold (prepared <> renderedProps)
        _ ← DOM.appendChild staticNode parent

        pure
          ( Types.EventSystem
              { cancel: do
                  _ ← DOM.removeChild staticNode parent
                  aggregated.cancel

              , events: aggregated.events
              , handleUpdate: aggregated.handleUpdate
              }
          )

      Types.CDelegate delegateE →
        let
          process
            = Types.runComponentDelegateX
                \(Types.ComponentDelegate { delegate, focus }) → do
                  (Types.EventSystem { cancel, events, handleUpdate })
                      ← bootstrap document parent delegate

                  pure
                    ( Types.EventSystem
                        { cancel
                        , events: map focus.event events
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
                    )

        in process delegateE

      Types.CWatcher (Types.ComponentWatcher listener) → do
        { event: output,     push: toOutput } ← FRP.create
        lastWatcher'sCanceller                ← Ref.newRef (pure unit)

        let
          updater update = do
            case listener update of
              Types.Rerender rerender → do
                case rerender of
                  Types.Update spec → do
                    (Types.EventSystem { cancel, events, handleUpdate })
                        ← render document parent spec

                    cancelEvents  ← FRP.subscribe events toOutput
                    lastCanceller ← Ref.readRef lastWatcher'sCanceller

                    lastCanceller -- Run the cancel event!
                    Ref.writeRef lastWatcher'sCanceller (cancel *> cancelEvents)

                  Types.Remove →
                    pure unit

              Types.Ignore →
                pure unit

        pure
          ( Types.EventSystem
              { cancel: do
                  lastCanceller ← Ref.readRef lastWatcher'sCanceller
                  lastCanceller -- Run the last watcher.
              , events: output
              , handleUpdate: updater
              }
          )
