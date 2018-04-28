module Panda.Incremental.Collection where

import DOM.Node.Node             (appendChild, childNodes, insertBefore, lastChild, removeChild) as DOM
import DOM.Node.NodeList         (item, toArray) as DOM
import DOM.Node.Types            (Node) as DOM
import Data.Algebra.Array        as Algebra
import Data.Array                as Array
import Effect                    (Effect)
import Panda.Internal.Types      as Types

import Panda.Prelude

type Renderer update state event
  = Types.Component update state event
  → Effect
      { node   ∷ DOM.Node
      , system ∷ Maybe (Types.EventSystem update state event)
      }

execute
  ∷ ∀ update state event
  . { parent   ∷ DOM.Node
    , systems  ∷ Array (Maybe (Types.EventSystem update state event))
    , render   ∷ Renderer update state event
    , update   ∷ Types.ComponentUpdate update state event
    }
  → Effect
      { systems ∷ Array (Maybe (Types.EventSystem update state event))
      , hasNewItem ∷ Maybe Int
      }

execute { parent, systems, render, update } = case update of
  Algebra.Empty → effToEffect do
    DOM.childNodes parent
      >>= DOM.toArray
      >>= traverse_ (_ `DOM.removeChild` parent)

    pure { systems: [], hasNewItem: Nothing }

  Algebra.Pop → do
    final ← effToEffect (DOM.lastChild parent)

    case final, Array.unsnoc systems of
      Just element, Just { init, last } → do
        _ ← effToEffect (DOM.removeChild element parent)
        traverse_ Types.cancel last

        pure { systems: init, hasNewItem: Nothing }

      _, _ → pure { systems, hasNewItem: Nothing }

  Algebra.Shift → do
    execute
      { parent
      , systems
      , render
      , update: Algebra.DeleteAt 0
      }

  Algebra.DeleteAt index → do
    effToEffect
        $ DOM.childNodes parent
      >>= DOM.item index
      >>= traverse_ (_ `DOM.removeChild` parent)

    case Array.index systems index, Array.deleteAt index systems of
      Just system, Just updated → do
        traverse_ Types.cancel system
          $> { systems: updated
             , hasNewItem: Nothing
             }

      _, _ →
        pure { hasNewItem: Nothing, systems }

  Algebra.InsertAt index spec → do
    { system, node } ← render spec
    atIndex ← effToEffect (DOM.childNodes parent >>= DOM.item index)

    _ ← effToEffect case atIndex of
      Just reference →
        DOM.insertBefore reference node parent

      Nothing →
        DOM.appendChild node parent

    pure case Array.insertAt index system systems of
      Just updated → { systems: updated, hasNewItem: Just index }
      Nothing      → { systems,          hasNewItem: Nothing    }

  Algebra.Push spec → do
    execute
      { parent
      , systems
      , render
      , update: Algebra.InsertAt (Array.length systems) spec
      }

  Algebra.Unshift spec →
    execute
      { parent
      , systems
      , render
      , update: Algebra.InsertAt 0 spec
      }

  Algebra.Move from to → effToEffect do
    let
      referenceIndex
        = case compare from to of
            LT → Just (to + 1)
            EQ → Nothing
            GT → Just to

      updatedSystems = do
        system ← Array.index systems from
        tmp ← Array.deleteAt from systems

        Array.insertAt to system systems

    sourceElement ← DOM.childNodes parent >>= DOM.item from

    case referenceIndex, updatedSystems of
      Just index, Just updated → do
        referenceElement ← DOM.childNodes parent >>= DOM.item index

        case sourceElement of
          Just source → do
            _ ← case referenceElement of
              Just reference →
                DOM.insertBefore source reference parent

              _ →
                DOM.appendChild source parent

            pure
              { hasNewItem: Nothing
              , systems: updated
              }

          _ →
            pure
              { hasNewItem: Nothing
              , systems
              }

      _, _ →
        pure
          { hasNewItem: Nothing
          , systems
          }

  Algebra.Swap from to → do
    { systems: updated } ← execute
      { parent
      , systems
      , render
      , update: Algebra.Move from to
      }

    let
      to' = if from < to
        then to - 1
        else to + 1

    execute
      { parent
      , systems: updated
      , render
      , update: Algebra.Move to' from
      }
