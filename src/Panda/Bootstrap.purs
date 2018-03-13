module Panda.Bootstrap
  ( bootstrap
  , render
  ) where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    (modifyRef', newRef, readRef, Ref) as Ref
import Control.Monad.Rec.Class  (Step(..), tailRecM)
import Control.Plus             (empty)
import Data.Array               as Array
import DOM.Node.Document        (createDocumentFragment, createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild, removeChild) as DOM
import DOM.Node.Types           (Document, Node, documentFragmentToNode, elementToNode, textToNode) as DOM
import Data.Foldable            (fold, for_)
import Data.Maybe               (Maybe(..))
import Data.Monoid              (mempty)
import Data.Traversable         (traverse)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types

import Prelude

execute
  ∷ ∀ eff update state event
  . DOM.Node
  → DOM.Document
  → Ref.Ref (Array (Types.EventSystem (Types.FX eff) update state event))
  → (event → Eff (Types.FX eff) Unit)
  → Types.ComponentUpdate (Types.FX eff) update state event
  → Eff (Types.FX eff) Unit
execute parent document ref output (Types.ComponentUpdate instruction)
  = case instruction of
      Types.ArrayDeleteAt index → do
        cleanup ← Ref.modifyRef' ref \systems →
          case Array.deleteAt index systems, systems Array.!! index of
            Just updated, Just (Types.EventSystem { cancel }) →
              { state: updated, value: cancel }

            _, _ →
              { state: systems, value: pure unit }

        cleanup

      Types.ArrayEmpty → do
        cleanup ← Ref.modifyRef' ref \systems →
          { state: []
          , value: for_ systems \(Types.EventSystem { cancel }) →
              cancel
          }

        cleanup

      Types.ArrayInsertAt index spec → do
        fragment ← DOM.createDocumentFragment document
        let fragment' = DOM.documentFragmentToNode fragment

        Types.EventSystem system ← render document fragment' spec
        cancelEventListener      ← FRP.subscribe system.events output

        let
          cancel' = do
            system.cancel
            cancelEventListener

          system'
            = Types.EventSystem
                ( system { cancel = cancel' }
                )

        action ← Ref.modifyRef' ref \systems →
          if Array.null systems
            then
              { state: [system']
              , value: do
                  _ ← DOM.appendChild fragment' parent
                  pure unit
              }

            else
              { state: Array.cons system' systems
              , value: pure unit --do
--                  children      ← DOM.childNodes fragment'
--                  maybePrevious ← DOM.item index children
--
--                  case maybePrevious of
--                    Just previous → do
--                      _ ← DOM.insertBefore fragment' previous parent
--                      pure unit
--
--                    _ →
--                      pure unit
              }

        action

      Types.ArrayPop → do
        action ← Ref.modifyRef' ref \systems →
          case Array.unsnoc systems of
            Just { init, last: Types.EventSystem { cancel } } →
              { state: init, value: cancel }

            Nothing →
              { state: [], value: pure unit }

        action

      Types.ArrayPush component →
        pure unit

      Types.ArrayShift → do
        action ← Ref.modifyRef' ref \systems →
          case Array.uncons systems of
            Just { head: Types.EventSystem { cancel }, tail } →
              { state: tail, value: cancel }

            Nothing →
              { state: [], value: pure unit }

        action

      Types.ArrayUnshift component → do
        pure unit

-- | Set up and kick off a Panda application. This creates the element tree,
-- | and ties the update handler to the event stream.
bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → DOM.Node
  → Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

bootstrap document parent { initial, subscription, update, view } = do
  Types.EventSystem renderedPage ← render document parent view
  deltas                         ← FRP.create

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
        let element' = DOM.textToNode element

        _ ← DOM.appendChild element' parent

        pure
          ( Types.EventSystem
              { cancel: do
                  _ ← DOM.removeChild element' parent
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
        { event: output, push: toOutput } ← FRP.create
        eventSystems                      ← Ref.newRef mempty

        pure
          ( Types.EventSystem
              { cancel: do
                  systems ← Ref.readRef eventSystems
                  for_ systems \(Types.EventSystem { cancel }) →
                    cancel

              , events: output
              , handleUpdate: \update → do
                  case listener update of
                    Types.Rerender rerender → do
                      let
                        updateCancellers instructions
                          = case Array.uncons instructions of
                              Nothing →
                                pure (Done unit)

                              Just { head, tail } → do
                                systems' ← execute parent document
                                  eventSystems toOutput head
                                pure (Loop tail)

                      systems ← Ref.readRef eventSystems
                      tailRecM updateCancellers rerender

                    Types.Ignore →
                      pure unit

                  final ← Ref.readRef eventSystems
                  for_ final \(Types.EventSystem { handleUpdate }) →
                    handleUpdate update
              }
          )
