module Panda.Bootstrap
  ( bootstrap
  , render
  ) where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    as Ref
import Control.Monad.Rec.Class  (Step(..), tailRecM)
import Data.Array               (cons, deleteAt, index, insertAt, snoc, uncons, unsnoc) as Array
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild, childNodes, insertBefore, removeChild) as DOM
import DOM.Node.NodeList        (toArray) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Filterable          (filterMap)
import Data.Foldable            (foldMap, traverse_)
import Data.Maybe               (Maybe(..))
import Data.Monoid              (mempty)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types

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

  deltas ← FRP.create

  let
    -- The current state of the application.
    states' ∷ FRP.Event { state ∷ state, update ∷ update }
    states' = FRP.fold (\delta { state } → delta state) deltas.event initial

    states ∷ FRP.Event { state ∷ state, update ∷ update }
    states = pure initial <|> states'

    events ∷ FRP.Event event
    events = subscription <|> system.events

    loop
      ∷ event
      → { state ∷ state, update ∷ update }
      → { state ∷ state, event  ∷ event  }
    loop event { state }
      = { event, state }

    prepared ∷ FRP.Event { event ∷ event, state ∷ state }
    prepared = FRP.sampleOn states (map loop events)

  cancelRenderer    ← FRP.subscribe states system.handleUpdate
  cancelApplication ← FRP.subscribe prepared (update deltas.push)

  pure
    { element
    , system: Types.EventSystem
        $ system
            { cancel = do
                system.cancel
                cancelRenderer
                cancelApplication
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
          Types.StaticChildren children → do
            children # foldMap \child → do
              { element, system } ← render document child

              _ ← DOM.appendChild element node
              pure system

          Types.DynamicChildren listener → do
            { event: output, push: toOutput } ← FRP.create
            eventSystems                      ← Ref.newRef mempty

            pure $ Types.EventSystem
              { cancel: do
                  systems ← Ref.readRef eventSystems

                  systems # foldMap \(Types.EventSystem { cancel }) →
                    cancel

              , handleUpdate: \update →
                  listener update # tailRecM \instructions →
                    case (Array.uncons instructions) of
                      Nothing →
                        pure (Done unit)

                      Just { head, tail } → do
                        systems ← Ref.readRef eventSystems

                        updatedSystems ← execute document node systems head
                        Ref.writeRef eventSystems updatedSystems

                        pure (Loop tail)

              , events: output
              }

        pure
          { element: node
          , system:  elementSystem <> propertySystem
          }

-- | Given an element, and a set of update instructions, perform the update and
-- | reconfigure the event systems.
execute
  ∷ ∀ eff update state event
  . DOM.Document
  → DOM.Node
  → Array (Types.EventSystem (Types.FX eff) update state event)
  → Types.ComponentUpdate (Types.FX eff) update state event
  → Eff (Types.FX eff)
      ( Array
          ( Types.EventSystem (Types.FX eff) update state event
          )
      )

execute document parent systems (Types.ComponentUpdate update) = do
  children ← DOM.childNodes parent >>= DOM.toArray

  case update of
      Types.ArrayDeleteAt index → do
        let
          result = { updated: _, element: _, system: _ }
            <$> Array.deleteAt index systems
            <*> Array.index children index
            <*> Array.index systems  index

        case result of
          Just { updated, element, system: Types.EventSystem system } → do
            _ ← DOM.removeChild element parent
            system.cancel

            pure updated

          _ →
            pure systems

      Types.ArrayEmpty → do
        systems # traverse_ \(Types.EventSystem { cancel }) →
          cancel

        children # traverse_ \node → do
          _ ← DOM.removeChild node parent
          pure unit

        pure []

      Types.ArrayInsertAt index spec → do
        { element, system } ← render document spec

        let
          updated = { systems': _, child: _ }
            <$> Array.insertAt index system systems
            <*> Array.index children index

        case updated of
          Just { systems', child } → do
            _ ← DOM.insertBefore child element parent
            pure systems'

          Nothing →
            pure systems

      Types.ArrayMove from to → do
        let
          elements
            = { source: _, target: _ }
                <$> Array.index children from
                <*> Array.index children to

          systems' = do
            system ← Array.index systems from
            tmp    ← Array.deleteAt from systems

            let
              insertIndex
                = if from < to
                    then to - 1
                    else to

            Array.insertAt insertIndex system tmp

          plan
            = { elements: _, systems: _ }
                <$> elements
                <*> systems'

        case plan of
          Just moves → do
            -- This will remove it from the old location, too :)
            _ ← DOM.insertBefore
                  moves.elements.source
                  moves.elements.target
                  parent

            pure moves.systems

          Nothing →
            pure systems

      Types.ArrayPop → do
        let
          result = { elements: _, eventSystems: _ }
            <$> Array.unsnoc children
            <*> Array.unsnoc systems

        case result of
          Just { elements, eventSystems } → do
            let
              Types.EventSystem system
                = eventSystems.last

            system.cancel
            _ ← DOM.removeChild elements.last parent

            pure eventSystems.init

          Nothing →
            pure systems

      Types.ArrayPush spec → do
        { element, system } ← render document spec

        _ ← DOM.appendChild element parent
        pure (Array.snoc systems system)

      Types.ArrayShift → do
        let
          result = { elements: _, eventSystems: _ }
            <$> Array.uncons children
            <*> Array.uncons systems

        case result of
          Just { elements, eventSystems } → do
            let
              Types.EventSystem system
                = eventSystems.head

            system.cancel
            _ ← DOM.removeChild elements.head parent

            pure eventSystems.tail

          Nothing →
            pure systems

      Types.ArrayUnshift spec → do
        let
          command
            = case Array.uncons children of
                Nothing       → DOM.appendChild
                Just { head } → (_ `DOM.insertBefore` head)

        { element, system } ← render document spec
        _ ← command element parent

        pure (Array.cons system systems)
