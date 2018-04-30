module Panda.Render.Component where

import Control.Monad.Eff.Ref        as Ref
import DOM.Node.Document            (createElement, createTextNode) as DOM
import DOM.Node.Node                (appendChild) as DOM
import DOM.Node.Types               (Document, Node, elementToNode, textToNode) as DOM
import Data.Array                   as Array
import Data.Filterable              (filterMap)
import Data.Foldable                (fold)
import Data.Maybe                   (fromJust)
import Effect                       (Effect)
import FRP.Event                    (create, subscribe) as FRP
import Panda.Incremental.Collection (execute)
import Panda.Internal.Types         as Types
import Panda.Render.Property        as Property
import Partial.Unsafe               (unsafePartial)

import Panda.Prelude

-- | Given a DOM document and a bootstrapping function, render a component to
-- | a DOM node, along with the corresponding event system.

render
  ∷ ∀ update state event
  . DOM.Document
  → ( ∀ update' state' event'
    . Types.Application update' state' event'
    → Effect
        { node   ∷ DOM.Node
        , system ∷ Maybe (Types.EventSystem update' state' event')
        }
    )
  → Types.Component update state event
  → Effect
      { node   ∷ DOM.Node
      , system ∷ Maybe (Types.EventSystem update state event)
      }

render document bootstrap = case _ of
  Types.Text text → do
    node      ← effToEffect (DOM.createTextNode text document)

    pure { node: DOM.textToNode node, system: Nothing }

  Types.Element { tagName, properties, children } → do
    element ← effToEffect $ DOM.createElement tagName document
    let parentNode = DOM.elementToNode element

    -- Attach all the properties to the newly-created element.
    -- TODO: s/map fold $ traverse/foldMap/ once Effect is Monoid.

    propertySystem
      ← map fold
      ∘ traverse (Property.render element)
      $ properties

    -- Set up all the children's systems and nodes...

    renderedChildren
      ← traverse (render document bootstrap)
      $ children

    -- TODO: s/map fold $ for/flip foldMap/ once Effect is Monoid.

    childrenSystem ← map fold $ for renderedChildren \{ node, system } →
        effToEffect $ DOM.appendChild node parentNode $> system

    pure
      { node: parentNode
      , system: propertySystem <> childrenSystem
      }

  Types.Collection { tagName, properties, watcher } → do
    element ← effToEffect $ DOM.createElement tagName document
    let parent = DOM.elementToNode element

    eventSystems ← effToEffect (Ref.newRef [])
    { event: childEvents, push: pushChildEvent } ← effToEffect FRP.create

    propertySystem
      ← map fold
      ∘ traverse (Property.render element)
      $ properties

    let
      childSystem
        = Just $ Types.EventSystem
            { cancel: do
                systems ← effToEffect (Ref.readRef eventSystems)

                for_ systems $ traverse \(Types.EventSystem { cancel }) →
                  cancel

            , handleUpdate: \update → do
                for_ (watcher update) \instruction → do
                  systems ← effToEffect (Ref.readRef eventSystems)

                  { hasNewItem, systems: updatedSystems } ←
                      execute
                        { parent
                        , systems
                        , render: render document bootstrap
                        , update: instruction
                        }

                  let
                    indexAndSystem = do
                      index  ← hasNewItem
                      system ← Array.index updatedSystems index

                      pure { index, system }

                  case indexAndSystem of
                    Just { index, system: Just (Types.EventSystem system) } → do
                      canceller ← effToEffect ∘ map effToEffect
                        $ FRP.subscribe system.events pushChildEvent

                      let
                        updated
                          = Just ∘ Types.EventSystem $ system
                              { cancel = do
                                  system.cancel
                                  canceller
                              }

                      effToEffect
                        $ Ref.writeRef eventSystems
                        $ unsafePartial fromJust
                        $ Array.insertAt index updated updatedSystems

                    _ →
                      effToEffect (Ref.writeRef eventSystems updatedSystems)

                systems ← effToEffect (Ref.readRef eventSystems)

                for_ systems $ traverse_ \(Types.EventSystem { handleUpdate }) →
                  handleUpdate update

            , events: childEvents
            }

    pure
      { node: parent
      , system: childSystem <> propertySystem
      }

  Types.Delegate delegate →
    delegate # Types.runComponentDelegateX
      \(Types.ComponentDelegate { focus, application }) → do
        { node, system } ← bootstrap application

        pure case system of
          Just (Types.EventSystem system') →
            { node
            , system: Just ∘ Types.EventSystem $ system'
                { events = filterMap focus.event system'.events
                , handleUpdate = \{ state, update } →
                    case focus.update update of
                      Just subupdate →
                        system'.handleUpdate
                          { update: subupdate
                          , state:  focus.state state
                          }

                      Nothing →
                        pure unit
                }
            }

          Nothing →
            { node
            , system: Nothing
            }

