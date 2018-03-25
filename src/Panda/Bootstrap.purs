module Panda.Bootstrap
  ( bootstrap
  , render
  ) where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    as Ref
import Data.Array               as Array
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Filterable          (filterMap)
import Data.Foldable            (foldMap, traverse_)
import Data.Maybe               (Maybe(..), fromJust)
import Data.Monoid              (mempty)
import FRP.Event                (Event, create, subscribe) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Incremental.HTML   (execute)
import Panda.Internal.Types     as Types
import Partial.Unsafe           (unsafePartial)

import Prelude

-- | Given an application, produce the DOM element and the system of events
-- | around it. This is mutually recursive with the `render` function.
bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { element ∷ DOM.Node
      , system ∷ Types.EventSystem (Types.FX eff) update state event
      }

bootstrap document { initial, subscription, update, view } = do
  { element, system: Types.EventSystem system }
      ← render document view

  stateRef ← Ref.newRef initial.state

  let
    events ∷ FRP.Event event
    events = subscription <|> system.events

  cancel ← FRP.subscribe events \event → do
    state ← Ref.readRef stateRef

    { event, state } # update \callback → do
      mostRecentState ← Ref.readRef stateRef
      let new@{ state } = callback mostRecentState

      Ref.writeRef stateRef state
      system.handleUpdate new

  system.handleUpdate initial

  pure
    { element
    , system: Types.EventSystem
        $ system
            { cancel = do
                system.cancel
                cancel
            }
    }

-- | Given a component, render the DOM node, and set up the event system.
render
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Component (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { element ∷ DOM.Node
      , system ∷ Types.EventSystem (Types.FX eff) update state event
      }
render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document
        let element' = DOM.textToNode element

        pure
          { element: element'
          , system: mempty
          }

      Types.ComponentDelegate delegateE →
        delegateE # Types.runComponentDelegateX
          \({ delegate, focus }) → do
              { element, system: Types.EventSystem system }
                  ← bootstrap document delegate

              pure
                { element
                , system: Types.EventSystem $ system
                    { events = filterMap focus.event system.events
                    , handleUpdate = \{ state, update } →
                        case focus.update update of
                          Just subupdate →
                            system.handleUpdate
                              { update: subupdate
                              , state:  focus.state state
                              }

                          Nothing →
                            pure unit
                    }
                }

      Types.ComponentElement component → do
        tag             ← DOM.createElement component.tagName document
        propertySystem  ← foldMap (Property.render tag) component.properties

        let node = DOM.elementToNode tag

        elementSystem ← case component.children of
          Types.StaticChildren children →
            children # foldMap \child → do
              { element, system } ← render document child

              _ ← DOM.appendChild element node
              pure system

          Types.DynamicChildren listener → do
            eventSystems ← Ref.newRef mempty
            { event: childEvents, push: pushChildEvent } ← FRP.create

            pure $ Types.EventSystem
              { cancel: Ref.readRef eventSystems
                  >>= foldMap \(Types.EventSystem { cancel }) →
                        cancel

              , handleUpdate: listener >>> traverse_ \instruction → do
                  systems ← Ref.readRef eventSystems

                  { hasNewItem, systems: updatedSystems } ←
                      execute
                        { document
                        , parent: node
                        , systems
                        , render
                        , update: instruction
                        }

                  case hasNewItem of
                    Nothing →
                      Ref.writeRef eventSystems updatedSystems

                    Just index → do
                      let
                        Types.EventSystem system
                          = unsafePartial fromJust
                            $ Array.index updatedSystems index

                      canceller ←
                        FRP.subscribe
                          system.events
                          pushChildEvent

                      let
                        updated
                          = Types.EventSystem
                          $ system { cancel = system.cancel <> canceller }

                      Ref.writeRef eventSystems
                        $ unsafePartial fromJust
                        $ Array.insertAt index updated updatedSystems

              , events: childEvents
              }

        pure
          { element: node
          , system:  elementSystem <> propertySystem
          }
