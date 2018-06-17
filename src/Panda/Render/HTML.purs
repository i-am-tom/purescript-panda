module Panda.Render.HTML where

import Data.Array                   as Array
import Data.Filterable              (filterMap)
import Data.Foldable                (traverse_)
import Data.Maybe                   (Maybe(..), fromJust)
import Data.Traversable             (for, traverse)
import Effect                       (Effect, foreachE)
import Effect.Ref                   as Ref
import FRP.Event                    (Event, create, subscribe) as FRP
import Panda.Incremental.Collection (execute)
import Panda.Internal.Types         as Types
import Panda.Render.Property        as Property
import Partial.Unsafe               (unsafePartial)
import Web.DOM.Document             (Document, createTextNode, createElement) as Web
import Web.DOM.Element              as Web.Element
import Web.DOM.Internal.Types       (Node) as Web
import Web.DOM.Node                 (appendChild) as Web
import Web.DOM.Text                 as Web.Text

import Prelude

render
  ∷ ∀ input message state
  . Web.Document
  → ( ∀ subinput suboutput submessage substate
    . Types.Component subinput suboutput submessage substate
    → Effect
        { node    ∷ Web.Node
        , events  ∷ FRP.Event suboutput
        , update  ∷ subinput → Effect Unit
        , destroy ∷ Effect Unit
        }
    )
  → Types.HTML input message state
  → Effect
      { node   ∷ Web.Node
      , system ∷ Types.EventSystem input message state
      }

render document bootstrap = case _ of
  Types.Text text → do
    node ← Web.createTextNode text document

    pure
      { node: Web.Text.toNode node
      , system: Types.emptySystem
      }

  Types.Element { tagName, properties, children } → do
    element ← Web.createElement tagName document
    let parentNode = Web.Element.toNode element

    propertySystems ← traverse (Property.render element) properties
    let propertySystem = Types.foldSystems propertySystems

    renderedChildren ← for children (render document bootstrap)

    childSystems ← for renderedChildren \{ system, node } → do
      _ ← Web.appendChild node parentNode
      pure system

    let childSystem = Types.foldSystems childSystems

    pure
      { node: parentNode
      , system: Types.combineSystems propertySystem childSystem
      }

  Types.Collection { tagName, properties, watcher } → do
    parent ← render document bootstrap
      (Types.Element { tagName, properties, children: [] })

    childSystems ← Ref.new []
    childEvents  ← FRP.create

    let
      childSystem
        = { cancel: Ref.read childSystems >>= traverse_ _.cancel
          , events: childEvents.event
          , handleUpdate: \update → do
              foreachE (watcher update) \instruction → do
                systems ← Ref.read childSystems

                { hasNewItem, systems: updatedSystems } ←
                    execute
                      { parent: parent.node
                      , render: render document bootstrap
                      , systems
                      , update: instruction
                      }

                let
                  indexAndSystem = do
                    index  ← hasNewItem
                    system ← Array.index updatedSystems index

                    pure { index, system }

                case indexAndSystem of
                  Just { index, system } → do
                    canceller ← FRP.subscribe system.events childEvents.push

                    let
                      updated
                        = system
                            { cancel = do
                                system.cancel
                                canceller
                            }

                      systems'
                        = unsafePartial
                        $ fromJust
                        $ Array.insertAt index updated updatedSystems

                    Ref.write systems' childSystems

                  _ →
                    Ref.write updatedSystems childSystems

              Ref.read childSystems >>= traverse_ \{ handleUpdate } →
                handleUpdate update
          }

    pure parent { system = Types.combineSystems parent.system childSystem }

  Types.Delegate delegate →
    delegate # Types.runHTMLDelegateX
      \(Types.HTMLDelegate { focus, application }) → do
        system ← bootstrap application

        pure
          { node: system.node
          , system:
              { events: filterMap focus.output system.events
              , handleUpdate: \{ state, input } →
                  case focus.input input of
                    Just subupdate →
                      system.update subupdate

                    Nothing →
                      pure unit
              , cancel: system.destroy
              }
          }
