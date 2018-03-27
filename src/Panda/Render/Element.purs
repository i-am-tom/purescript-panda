module Panda.Render.Element where

import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Ref     as Ref
import DOM.Node.Document         (createElement, createTextNode) as DOM
import DOM.Node.Node             (appendChild) as DOM
import DOM.Node.Types            (Document, Node, elementToNode, textToNode) as DOM
import Data.Array                as Array
import Data.Filterable           (filterMap)
import Data.Foldable             (foldMap, for_)
import Data.Maybe                (Maybe(..), fromJust)
import Data.Monoid               (mempty)
import FRP.Event                 (create, subscribe) as FRP
import Panda.Incremental.Element (execute)
import Panda.Internal.Types      as Types
import Panda.Render.Property     as Property
import Partial.Unsafe            (unsafePartial)

import Prelude

-- | Given a component, render the DOM node, and set up the event system.
render
  ∷ ∀ eff update state event
  . ( ∀ update' state' event'
      . Types.Application (Types.FX eff) update' state' event'
      → Eff (Types.FX eff)
          { element ∷ DOM.Node
          , system ∷ Types.EventSystem (Types.FX eff) update' state' event'
          }
    )
  → DOM.Document
  → Types.Component (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { element ∷ DOM.Node
      , system ∷ Types.EventSystem (Types.FX eff) update state event
      }
render bootstrap document
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
                  ← bootstrap delegate

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
        propertySystem  ← Property.render tag component.properties

        let node = DOM.elementToNode tag

        elementSystem ← case component.children of
          Types.StaticChildren children →
            children # foldMap \child → do
              { element, system } ← render bootstrap document child

              _ ← DOM.appendChild element node
              pure system

          Types.DynamicChildren listener → do
            eventSystems ← Ref.newRef mempty
            { event: childEvents, push: pushChildEvent } ← FRP.create

            pure $ Types.EventSystem
              { cancel: Ref.readRef eventSystems
                  >>= foldMap \(Types.EventSystem { cancel }) →
                        cancel

              , handleUpdate: \update → do
                  for_ (listener update) \instruction → do
                    systems ← Ref.readRef eventSystems

                    { hasNewItem, systems: updatedSystems } ←
                        execute
                          { parent: node
                          , systems
                          , render: render bootstrap document
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

                  systems ← Ref.readRef eventSystems
                  for_ systems (Types.handleUpdate update)

              , events: childEvents
              }

        pure
          { element: node
          , system:  elementSystem <> propertySystem
          }
