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
      . I.App (I.FX eff) update' state' event'
      → Eff (I.FX eff)
          { node   ∷ DOM.Node
          , system ∷ I.EventSystem (I.FX eff) update' state' event'
          }
    )
  → DOM.Document
  → I.Component (I.FX eff) update state event
  → Eff (I.FX eff)
      { node   ∷ DOM.Node
      , system ∷ I.EventSystem (I.FX eff) update state event
      }

render bootstrap document
  = case _ of
      I.ComponentText text → do
        element ← DOM.createTextNode text document

        pure
          { node: DOM.textToNode element
          , system: I.StaticSystem
          }

      I.ComponentDelegate delegateE →
        delegateE # I.runComponentDelegateX
          \{ delegate, focus } →
              bootstrap delegate <#> \{ node, system } →
                case system of
                  I.StaticSystem →
                    { node
                    , system: I.StaticSystem
                    }

                  I.DynamicSystem system' →
                    { node
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
        { node, propertySystem }
            ← makeEmptyDOMNode component.tagName component.properties

        elementSystem ← component.children # foldMap \child → do
          { node: childNode, system } ← render bootstrap document child

          _ ← DOM.appendChild childNode node
          pure system

        pure
          { node
          , system: elementSystem <> propertySystem
          }

      I.ComponentCollection component → do
        { event: childEvents, push: pushChildEvent } ← FRP.create
        eventSystems ← Ref.newRef mempty

        { node: parent, propertySystem }
            ← makeEmptyDOMNode component.tagName component.properties

        pure
          { node: parent
          , system: I.DynamicSystem
              { cancel: Ref.readRef eventSystems
                  >>= foldMap I.cancelEventSystem

              , handleUpdate: \update → do
                  for_ (component.handler update) \instruction → do
                    systems ← Ref.readRef eventSystems

                    { hasNewItem, systems: updatedSystems } ←
                        execute
                          { parent: parent
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
          }

  where
    makeEmptyDOMNode
      ∷ ∀ eff' update' state' event'
      . String
      → Array (I.Property update' state' event')
      → Eff (I.FX eff')
          { node           ∷ DOM.Node
          , propertySystem ∷ I.EventSystem (I.FX eff') update' state' event'
          }

    makeEmptyDOMNode name properties = do
      tag            ← DOM.createElement name document
      propertySystem ← foldMap (Property.render tag) properties

      pure
        { node:           DOM.elementToNode tag
        , propertySystem: propertySystem
        }
