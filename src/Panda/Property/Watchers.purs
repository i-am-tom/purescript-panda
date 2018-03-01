module Panda.Property.Watchers where

import Data.Foldable        (find)
import Data.Maybe           (Maybe(..), maybe)
import Panda.Internal.Types as Types

import Prelude

type Renderer update state event
  = { state ∷ state, update ∷ update }
  → Types.Modification String

-- | General constructor for property watches. Kind of the "advanced mode" -
-- use the other functions if possible.
watch
  ∷ ∀ update state event
  . String
  → ( { state  ∷ state
      , update ∷ update
      }
    → Types.ShouldUpdate (Types.Modification String)
    )
  → Types.Property update state event
watch key listener = Types.PWatcher (Types.PropertyWatcher { key, listener })

-- | Run a property update regardless of the update that is detected. For
-- larger applications, this will happen very regularly, so be careful with
-- this...
watchAny
  ∷ ∀ update state event
  . String
  → Renderer update state event
  → Types.Property update state event
watchAny key renderer
  = watch key \update → Types.Rerender (renderer update)

-- | Watch for a particular update.
watchFor
  ∷ ∀ update state event
  . Eq update
  ⇒ String
  → update
  → Renderer update state event
  → Types.Property update state event
watchFor key search renderer
  = watch key \change →
      if change.update == search
        then Types.Rerender (renderer change)
        else Types.Ignore

-- | Given a set of predicate/render pairs, update the property accordingly
-- whenever one of the predicates is matched. Note that this is like a `case`:
-- only the first match will be considered. If none matches, no update will be
-- applied.
watchSet
  ∷ ∀ update state event
  . String
  → Array
      { match    ∷ update → Boolean
      , renderer ∷ Renderer update state event
      }
  → Types.Property update state event
watchSet key routes
  = watch key \change →
      let get
            ∷ ∀ r. Array { match ∷ update → Boolean | r }
            → Maybe { match ∷ update → Boolean | r }
          get = find \{ match } → match change.update

          render
            ∷ ∀ r. { renderer ∷ Renderer update state event | r }
            → Types.Modification String
          render { renderer } = renderer change
      in
        case get routes of
          Just routes' →
            Types.Rerender (render routes')
          Nothing →
            Types.Ignore

-- | Update a property whenever a predicate is satisfied.
watchWhen
  ∷ ∀ update state event
  . String
  → ({ state ∷ state, update ∷ update } → Boolean)
  → Renderer update state event
  → Types.Property update state event
watchWhen key predicate renderer
  = watch key \change →
      if predicate change
        then Types.Rerender (renderer change)
        else Types.Ignore
