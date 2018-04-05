module Panda.Incremental.Element where

import Control.Monad.Eff    (Eff)
import Data.Array           as Array
import Data.Algebra.Array   as Algebra
import DOM.Node.Node        (appendChild, childNodes, insertBefore, removeChild) as DOM
import DOM.Node.NodeList    (toArray) as DOM
import DOM.Node.Types       (Node) as DOM
import Data.Foldable        (for_)
import Data.Maybe           (Maybe(..))
import Panda.Internal       as Types

import Prelude

type Renderer eff update state event
  = Types.Component eff update state event
  → Eff eff
      { element ∷ DOM.Node
      , system  ∷ Types.EventSystem eff update state event
      }

-- | Given an element, and a set of update instructions, perform the update and
-- | reconfigure the event systems.
execute
  ∷ ∀ eff update state event
  . { parent   ∷ DOM.Node
    , systems  ∷ Array (Types.EventSystem (Types.FX eff) update state event)
    , render   ∷ Renderer (Types.FX eff) update state event
    , update   ∷ Types.ComponentUpdate (Types.FX eff) update state event
    }
  → Eff (Types.FX eff)
      { systems ∷ Array
          ( Types.EventSystem (Types.FX eff) update state event
          )
      , hasNewItem ∷ Maybe Int
      }

execute { parent, systems, render, update } = do
  children ← DOM.childNodes parent >>= DOM.toArray

  case update of
      -- Delete an element from the DOM and execute its cancellers.
      Algebra.DeleteAt index → do
        let
          result = { updated: _, element: _, system: _ }
            <$> Array.deleteAt index systems
            <*> Array.index children index
            <*> Array.index systems  index

        case result of
          Just { updated, element, system } → do
            _ ← DOM.removeChild element parent

            case system of
              Types.DynamicSystem { cancel } →
                cancel

              Types.StaticSystem →
                pure unit

            pure
              { systems: updated
              , hasNewItem: Nothing
              }

          _ →
            pure
              { systems
              , hasNewItem: Nothing
              }

      -- Remove all the children from the DOM node and run all the cancellers.
      Algebra.Empty → do
        for_ systems case _ of
          Types.DynamicSystem { cancel } →
            cancel

          Types.StaticSystem →
            pure unit

        for_ children \node → do
          _ ← DOM.removeChild node parent
          pure unit

        pure
          { systems: []
          , hasNewItem: Nothing
          }

      -- Insert an element at a given index and initialise its cancellers.
      Algebra.InsertAt index spec → do
        { element, system }
            ← render spec

        let
          updated = { systems: _, child: _ }
            <$> Array.insertAt index system systems
            <*> Array.index children index

        case updated of
          Just { systems: systems', child } → do
            _ ← DOM.insertBefore child element parent

            pure { systems: systems', hasNewItem: Just index }

          Nothing →
            pure { systems, hasNewItem: Nothing }

      -- Move an element from one position to another. To be explicit, this
      -- takes the element at `from`, and places it _before_ the element at
      -- `to + 1`. If no element `to + 1` exists, this is an `append`.
      Algebra.Move from to → do
        let
          moveSystem = do
            system ← Array.index systems from

            tmp ← Array.deleteAt from systems
            Array.insertAt to system tmp

          moveElement = do
            element ← Array.index children from

            if to == Array.length children
              then pure (DOM.appendChild element parent)
              else do
                target ← Array.index children to
                pure (DOM.insertBefore element target parent)

          plan
            = { systems: _, action: _ }
                <$> moveSystem
                <*> moveElement

        case plan of
          Just result → do
            _ ← result.action
            pure
              { systems: result.systems
              , hasNewItem: Nothing
              }

          Nothing →
            pure
              { systems
              , hasNewItem: Nothing
              }

      -- Remove the last child element.
      Algebra.Pop → do
        let
          result = { elements: _, eventSystems: _ }
            <$> Array.unsnoc children
            <*> Array.unsnoc systems

        case result of
          Just { elements, eventSystems } → do
            case eventSystems.last of
              Types.DynamicSystem { cancel } →
                cancel

              Types.StaticSystem →
                pure unit

            _ ← DOM.removeChild elements.last parent

            pure
              { systems: eventSystems.init
              , hasNewItem: Nothing
              }

          Nothing →
            pure
              { systems
              , hasNewItem: Nothing
              }

      -- Add a child element to the end of the children.
      Algebra.Push spec → do
        { element, system } ← render spec

        _ ← DOM.appendChild element parent
        pure
          { systems: Array.snoc systems system
          , hasNewItem: Just (Array.length systems)
          }

      -- Remove the first child.
      Algebra.Shift → do
        let
          result = { elements: _, eventSystems: _ }
            <$> Array.uncons children
            <*> Array.uncons systems

        case result of
          Just { elements, eventSystems } → do
            case eventSystems.head of
              Types.DynamicSystem { cancel } →
                cancel

              Types.StaticSystem →
                pure unit

            _ ← DOM.removeChild elements.head parent

            pure
              { systems: eventSystems.tail
              , hasNewItem: Nothing
              }

          Nothing →
            pure
              { systems
              , hasNewItem: Nothing
              }

      -- Prepend a child to the list.
      Algebra.Unshift spec → do
        let
          command
            = case Array.uncons children of
                Nothing       → DOM.appendChild
                Just { head } → (_ `DOM.insertBefore` head)

        { element, system } ← render spec
        _ ← command element parent

        pure
          { systems: Array.cons system systems
          , hasNewItem: Just 0
          }

      Algebra.Swap this that → do
        case compare this that of
          GT →
            execute
              { parent
              , systems
              , render
              , update: Algebra.Swap that this
              }

          EQ →
            pure { systems, hasNewItem: Nothing }

          LT → do
            { systems: tmp } ← execute
              { parent
              , systems
              , render
              , update: Algebra.Move this that
              }

            execute
              { parent
              , systems: tmp
              , render
              , update: Algebra.Move that this
              }
