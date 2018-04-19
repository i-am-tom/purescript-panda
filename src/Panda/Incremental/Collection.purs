module Panda.Incremental.Collection where

import DOM.Node.Node              (appendChild, childNodes, insertBefore, removeChild) as DOM
import DOM.Node.NodeList          (toArray) as DOM
import DOM.Node.Types             (Node) as DOM
import Data.Algebra.Array         as Algebra
import Data.Array                 as Array
import Effect                     (Effect)
import Panda.Internal.Types       as Types

import Panda.Prelude

-- | The type of a renderer from Component DSL to HTML. Note that, as a
-- | byproduct, this also produces the event system for wiring up the node.

type Renderer update state event
  = Types.Component update state event
  → Effect
      { node   ∷ DOM.Node
      , system ∷ Maybe (Types.EventSystem update state event)
      }

-- | This is a pretty ugly type, so we'll use this synonym. An incremental step
-- | (effectfully) produces an updated set of systems, and optionally an index
-- | xfor some "new" item to be reviewed.

type ExecutionResult update state event
  = Effect
      ( Maybe
          { systems    ∷ Array (Maybe (Types.EventSystem update state event))
          , hasNewItem ∷ Maybe Int
          }
      )

-- | Delete the node at the given index, and cancel any event system that might
-- | have been established.

deleteAt
  ∷ ∀ update state event
  . Int
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

deleteAt index parent children systems = do
  let
    result = { updated: _, element: _, system: _ }
      <$> Array.deleteAt index systems
      <*> Array.index children index
      <*> Array.index systems  index

  for result \{ updated, element, system } → do
    _ ← effToEffect (DOM.removeChild element parent)

    for_ system \(Types.EventSystem { cancel }) →
      cancel

    pure
      { systems: updated
      , hasNewItem: Nothing
      }

-- | Remove all elements from within this collection, and cancel all the event
-- | systems contained within.

empty
  ∷ ∀ update state event
  . DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

empty parent children systems =
  traverse_ (traverse_ \(Types.EventSystem { cancel }) → cancel) systems
    *> for_ children (effToEffect ∘ (_ `DOM.removeChild` parent))
    $> Just { systems: [], hasNewItem: Nothing }

-- | Insert the given component at the given index, rendering the element to
-- | HTML and wiring the event system accordingly.

insertAt
  ∷ ∀ update state event
  . Int
  → Types.Component update state event
  → Renderer update state event
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

insertAt index spec render parent children systems = do
  { node, system } ← render spec

  let
    updated = { systems: _, child: _ }
      <$> Array.insertAt index system systems
      <*> Array.index children index

  for updated \{ systems: systems', child } → do
    _ ← effToEffect (DOM.insertBefore child node parent)
    pure { systems: systems', hasNewItem: Just index }

move
  ∷ ∀ update state event
  . Int
  → Int
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

move from to parent children systems = do
  let
    moveSystem = do
      system ← Array.index systems from

      tmp ← Array.deleteAt from systems
      Array.insertAt to system tmp

    moveElement = do
      element ← Array.index children from

      if to == Array.length children
        then pure (effToEffect (DOM.appendChild element parent))
        else do
          target ← Array.index children to
          pure (effToEffect (DOM.insertBefore element target parent))

    plan
      = { systems: _, action: _ }
          <$> moveSystem
          <*> moveElement

  for plan \result → do
    _ ← result.action

    pure
      { systems: result.systems
      , hasNewItem: Nothing
      }

-- | Remove the last thing from the collection, and cancel its event system.

pop
  ∷ ∀ update state event
  . DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

pop parent children systems = do
  let
    result = { elements: _, eventSystems: _ }
      <$> Array.unsnoc children
      <*> Array.unsnoc systems

  for result \{ elements, eventSystems } → do
    for_ eventSystems.last \(Types.EventSystem { cancel }) →
      cancel

    _ ← effToEffect (DOM.removeChild elements.last parent)

    pure
      { systems: eventSystems.init
      , hasNewItem: Nothing
      }

-- | Add a given component to the end of the collection, rendering it and
-- | wiring up its event system.

push
  ∷ ∀ update state event
  . Types.Component update state event
  → Renderer update state event
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

push spec render parent children systems = do
  { node, system } ← render spec

  _ ← effToEffect (DOM.appendChild (spy node) (spy parent))

  pure $ Just
    { systems: Array.snoc systems system
    , hasNewItem: Just (Array.length systems)
    }

-- | Remove the first element from the collection and cancel its event system.

shift
  ∷ ∀ update state event
  . DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

shift parent children systems = do
  let
    result = { elements: _, eventSystems: _ }
      <$> Array.uncons children
      <*> Array.uncons systems

  for result \{ elements, eventSystems } → do
    for_ eventSystems.head \(Types.EventSystem { cancel }) →
      cancel

    _ ← effToEffect (DOM.removeChild elements.head parent)

    pure
      { systems: eventSystems.tail
      , hasNewItem: Nothing
      }

-- | Swap two elements in the collection.

swap
  ∷ ∀ update state event
  . Int
  → Int
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

swap this that parent children systems = do
  case compare this that of
    GT →
      swap that this parent children systems

    EQ →
      pure Nothing

    LT → do
      partial ← move this that parent children systems

      map join $ for partial \{ systems: tmp } →
        move that this parent children tmp

-- | Add an element at the beginning of the collection.

unshift
  ∷ ∀ update state event
  . Types.Component update state event
  → Renderer update state event
  → DOM.Node
  → Array DOM.Node
  → Array (Maybe (Types.EventSystem update state event))
  → ExecutionResult update state event

unshift spec render parent children systems = do
  { node, system } ← render spec

  _ ← effToEffect case Array.uncons children of
    Just { head } → DOM.insertBefore node head parent
    Nothing       → DOM.appendChild node parent

  pure $ Just
    { systems: Array.cons system systems
    , hasNewItem: Just 0
    }

-- | Given an element, and a set of update instructions, perform the update and
-- | reconfigure the event systems.

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

execute { parent, systems, render, update } = do
  children ← effToEffect $ DOM.childNodes parent >>= DOM.toArray

  result ← case update of
    Algebra.DeleteAt index →
      deleteAt index parent children systems

    Algebra.Empty →
      empty parent children systems

    Algebra.InsertAt index spec →
      insertAt index spec render parent children systems

    Algebra.Move from to →
      move from to parent children systems

    Algebra.Pop →
      pop parent children systems

    Algebra.Push spec →
      push spec render parent children systems

    Algebra.Shift →
      shift parent children systems

    Algebra.Swap this that →
      swap this that parent children systems

    Algebra.Unshift spec →
      unshift spec render parent children systems

  pure (fromMaybe { systems, hasNewItem: Nothing } result)
