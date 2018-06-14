module Panda.Incremental.Collection where

import Data.Algebra.Array     as Algebra
import Data.Array             as Array
import Data.Foldable          (traverse_)
import Data.Maybe             (Maybe(..))
import Effect                 (Effect)
import Panda.Internal.Types   as Types
import Web.DOM.Internal.Types (Node) as Web
import Web.DOM.Node           (appendChild, childNodes, insertBefore, lastChild, removeChild) as Web
import Web.DOM.NodeList       (item, toArray) as Web

import Prelude

-- | Just to make the signature a little less grizzly, a `Renderer` is anything
-- | with the signature of our `render` function in the directory above.

type Renderer input message state
  = Types.HTML input message state
  → Effect
      { node   ∷ Web.Node
      , system ∷ Types.EventSystem input message state
      }

-- | Given a container element, a set of event systems, and an incremental
-- | update set to perform, carry out the actions and render any added nodes.

execute
  ∷ ∀ input message state
  . { parent   ∷ Web.Node
    , systems  ∷ Array (Types.EventSystem input message state)
    , render   ∷ Renderer input message state
    , update   ∷ Types.HTMLUpdate input message state
    }
  → Effect
      { systems    ∷ Array (Types.EventSystem input message state)
      , hasNewItem ∷ Maybe Int
      }

execute { parent, systems, render, update } = case update of
  Algebra.Empty → do
    Web.childNodes parent >>= Web.toArray >>= traverse_ \child →
      Web.removeChild child parent

    pure { systems: [], hasNewItem: Nothing }

  -- Remove the last element from the collection.
  Algebra.Pop → do
    final ← Web.lastChild parent

    case final, Array.unsnoc systems of
      Just element, Just { init, last } → do
        _ ← Web.removeChild element parent
        last.cancel

        pure { systems: init, hasNewItem: Nothing }

      _, _ → pure { systems, hasNewItem: Nothing }

  -- Remove the first element from the collection.
  Algebra.Shift → do
    execute
      { parent
      , systems
      , render
      , update: Algebra.DeleteAt 0
      }

  -- Delete an element at a particular index.
  Algebra.DeleteAt index → do
    Web.childNodes parent
      >>= Web.item index
      >>= traverse_ (_ `Web.removeChild` parent)

    case Array.index systems index, Array.deleteAt index systems of
      Just system, Just updated → do
        system.cancel

        pure
          { systems: updated
          , hasNewItem: Nothing
          }

      _, _ →
        pure
          { systems
          , hasNewItem: Nothing
          }

  -- Insert an element at a particular index.
  Algebra.InsertAt index spec → do
    { system, node } ← render spec
    atIndex ← Web.childNodes parent >>= Web.item index

    _ ← case atIndex of
      Just reference →
        Web.insertBefore reference node parent

      Nothing →
        Web.appendChild node parent

    pure case Array.insertAt index system systems of
      Just updated → { systems: updated, hasNewItem: Just index }
      Nothing      → { systems,          hasNewItem: Nothing    }

  -- Append an element to the collection.
  Algebra.Push spec → do
    execute
      { parent
      , systems
      , render
      , update: Algebra.InsertAt (Array.length systems) spec
      }

  -- Prepend an element to the collection.
  Algebra.Unshift spec →
    execute
      { parent
      , systems
      , render
      , update: Algebra.InsertAt 0 spec
      }

  -- Move a node from one index to another, such that it ends up on the
  -- specified index (rather than where that index _was_ before the move).
  Algebra.Move from to → do
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

    sourceElement ← Web.childNodes parent >>= Web.item from

    case referenceIndex, updatedSystems of
      Just index, Just updated → do
        referenceElement ← Web.childNodes parent >>= Web.item index

        case sourceElement of
          Just source → do
            _ ← case referenceElement of
              Just reference →
                Web.insertBefore source reference parent

              _ →
                Web.appendChild source parent

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

  -- Swap the nodes at two given indices.
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
