module Panda.Builders.Element.Watchers
  ( renderAlways
  , renderAlways'
  , renderOnlyWhen
  , renderWhen

  , sort
  , sortBy
  , sortWith
  ) where

import Data.Algebra.Array as Algebra
import Data.Array         as Array
import Data.Function      (on)
import Data.Maybe         (Maybe(..), fromJust)
import Panda.Internal     (Children(..),  Component, ComponentUpdate)
import Partial.Unsafe     (unsafePartial)

import Prelude

{-

BASIC COMBINATORS

These are functions to simplify Watcher code for the case where only a single
child is used and totally re-rendered under all applicable conditions. These
are enough to give you parity with React-like frameworks, but are much less fun
than the greater possibilities :)

-}

-- | Create the update algebra for a given single child. All it really does is
-- | clear the children, and then append the given child. A long-winded
-- | rerender.
render'
  ∷ ∀ eff update state event
  . Component eff update state event
  → Array (ComponentUpdate eff update state event)

render' component
  = [ Algebra.Empty
    , Algebra.Push component
    ]

-- | Regardless of the update, re-render this child. **NB** that this is
-- | probably a bad idea within a larger application, as it will probably
-- | equate to a lot of unnecessary re-render. Consider embedding such an
-- | element within a delegate and filtering updates to improve performance.
renderAlways
  ∷ ∀ eff update state event
  . ( { update ∷ update, state ∷ state }
    → Component eff update state event
    )
  → Children eff update state event

renderAlways renderer
  = DynamicChildren (render' <<< renderer)

-- | Regardless of the update, re-render with no interest in what the update
-- | was. Again, this will be a real performance-killer in larger applications,
-- | so use it with caution. Beyond very simple cases, it's usually a sign that
-- | something needs rethinking.
renderAlways'
  ∷ ∀ eff update state event
  . (state → Component eff update state event)
  → Children eff update state event

renderAlways' renderer
  = renderAlways (renderer <<< _.state)

-- | Given an update and state, maybe produce a value. If a value _is_
-- | produced, use this value to render a component. As with the other render
-- | methods, this will trigger a full re-render.
renderWhen
  ∷ ∀ eff update state event value
  . ( { update ∷ update, state ∷ state }
    → Maybe value
    )
  → (value → Component eff update state event)
  → Children eff update state event

renderWhen predicate renderer
  = DynamicChildren \update →
      case predicate update of
        Just details →
          render' (renderer details)

        Nothing →
          []

-- | Like `renderWhen`, but a `Nothing` value will remove the child from the
-- | DOM, rather than simply not updating it.
renderOnlyWhen
  ∷ ∀ eff update state event value
  . ( { update ∷ update, state ∷ state }
    → Maybe value
    )
  → (value → Component eff update state event)
  → Children eff update state event

renderOnlyWhen predicate renderer
  = DynamicChildren \update →
      case predicate update of
        Just details →
          render' (renderer details)

        Nothing →
          [ Algebra.Empty
          ]

{-

DSL HELPERS

These functions generate sets of DSL instructions to perform common tasks.
Typically, these should be used within the `update` function to generate both
the updated state _and_ the view instructions, which can then be passed back to
the DOM via an update.

-}

filter
  ∷ ∀ eff update state event focus
  . (focus → Boolean)
  → Array focus
  → { state ∷ Array focus
    , moves ∷ Array (ComponentUpdate eff update state event)
    }

filter predicate focus
  = { state: Array.filter predicate focus
    , moves: Algebra.filter predicate focus
    }

sortBy
  ∷ ∀ eff update state event focus
  . (focus → focus → Ordering)
  → Array focus
  → { state ∷ Array focus
    , moves ∷ Array (ComponentUpdate eff update state event)
    }

sortBy comparison focus
  = { state: unsafePartial fromJust (Algebra.interpret focus instructions)
    , moves: instructions
    }
  where
    instructions
      ∷ ∀ anything
      . Array (Algebra.Update anything)
    instructions
      = Algebra.sortBy comparison focus

    sorted
      = Algebra.interpret focus instructions

sortWith
  ∷ ∀ eff update state event focus sortableType
  . Ord sortableType
  ⇒ (focus → sortableType)
  → Array focus
  → { state ∷ Array focus
    , moves ∷ Array (ComponentUpdate eff update state event)
    }

sortWith comparison
  = sortBy (compare `on` comparison)

sort
  ∷ ∀ eff update state event focus
  . Ord focus
  ⇒ Array focus
  → { state ∷ Array focus
    , moves ∷ Array (ComponentUpdate eff update state event)
    }

sort
  = sortBy compare
