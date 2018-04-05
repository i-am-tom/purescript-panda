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
import Panda.Internal            as I
import Panda.Render.Property     as Property
import Partial.Unsafe            (unsafePartial)

import Prelude

-- | Given a component, and a function for bootstrapping any delegate
-- | applications that may exist within the tree, render the DOM node, and set
-- | up the event system.
render
  ∷ ∀ eff update state event
  . ( ∀ update' state' event'
      . I.Application (I.FX eff) update' state' event'
      → Eff (I.FX eff)
          { element ∷ DOM.Node
          , system ∷ I.EventSystem (I.FX eff) update' state' event'
          }
    )
  → DOM.Document
  → I.Component (I.FX eff) update state event
  → Eff (I.FX eff)
      { element ∷ DOM.Node
      , system ∷ I.EventSystem (I.FX eff) update state event
      }

render bootstrap document
  = case _ of
      I.ComponentText text → do
        element ← DOM.createTextNode text document

        pure
          { element: DOM.textToNode element
          , system: mempty
          }

      I.ComponentDelegate delegateE →
        delegateE # I.runComponentDelegateX
          \{ delegate, focus } →
              bootstrap delegate <#> \{ element, system } →
                case system of
                  I.StaticSystem →
                    { element
                    , system: I.StaticSystem
                    }

                  I.DynamicSystem system' →
                    { element
                    , system: I.DynamicSystem $ system'
                        { events = filterMap focus.event system'.events
                        , handleUpdate = \{ state, update } →
                            for_ (focus.update update) \subupdate →
                              system'.handleUpdate
                                { update: subupdate
                                , state:  focus.state state
                                }
                        }
                    }

      I.ComponentElement component → do
        tag            ← DOM.createElement component.tagName document
        propertySystem ← Property.render tag component.properties

        let node = DOM.elementToNode tag

        elementSystem ← case component.children of
          I.StaticChildren children →
            children # foldMap \child → do
              { element, system } ← render bootstrap document child

              _ ← DOM.appendChild element node
              pure system

          I.DynamicChildren listener → do
            eventSystems ← Ref.newRef mempty
            { event: childEvents, push: pushChildEvent } ← FRP.create

            pure $ I.DynamicSystem
              { cancel: Ref.readRef eventSystems >>= foldMap I.cancelEventSystem
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

                    let
                      indexAndSystem = do
                        index  ← hasNewItem
                        system ← Array.index updatedSystems index

                        pure { index, system }

                    case indexAndSystem of
                      Just { index, system: I.DynamicSystem system } → do
                        canceller ← FRP.subscribe system.events pushChildEvent

                        let
                          updated
                            = I.DynamicSystem $ system
                                { cancel = do
                                    system.cancel
                                    canceller
                                }

                        Ref.writeRef eventSystems
                          $ unsafePartial fromJust
                          $ Array.insertAt index updated updatedSystems

                      _ →
                        Ref.writeRef eventSystems updatedSystems

                  systems ← Ref.readRef eventSystems
                  for_ systems (I.handleUpdateWithEventSystem update)

              , events: childEvents
              }

        pure
          { element: node
          , system:  elementSystem <> propertySystem
          }
