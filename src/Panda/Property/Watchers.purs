module Panda.Property.Watchers where

import Data.Foldable        (find)
import Data.Maybe           (Maybe(..))
import Panda.Internal.Types as Types

import Prelude

type Renderer update state event
  = { state ∷ state, update ∷ update }
  → Array Types.PropertyUpdate

-- | General constructor for property watches. Kind of the "advanced mode" -
-- | use the other functions if possible.
watch
  ∷ ∀ update state event
  . ( { state  ∷ state
      , update ∷ update
      }
    → Types.ShouldUpdate (Array Types.PropertyUpdate)
    )
  → Types.Property update state event
watch listener = Types.PWatcher (Types.PropertyWatcher listener)

-- | Run a property update regardless of the update that is detected. For
-- | larger applications, this will happen very regularly, so be careful with
-- | this...
watchAny
  ∷ ∀ update state event
  . Renderer update state event
  → Types.Property update state event
watchAny renderer
  = watch \update → Types.Rerender (renderer update)

-- | Watch for a particular update.
watchFor
  ∷ ∀ update state event
  . Eq update
  ⇒ update
  → Renderer update state event
  → Types.Property update state event
watchFor search renderer
  = watch \change →
      if change.update == search
        then Types.Rerender (renderer change)
        else Types.Ignore

-- | Given a set of predicate/render pairs, update the property accordingly
-- whenever one of the predicates is matched. Note that this is like a `case`:
-- only the first match will be considered. If none matches, no update will be
-- applied.
watchSet
  ∷ ∀ update state event
  . Array
      { match    ∷ update → Boolean
      , renderer ∷ Renderer update state event
      }
  → Types.Property update state event
watchSet routes
  = watch \change →
      let get
            ∷ ∀ r. Array { match ∷ update → Boolean | r }
            → Maybe { match ∷ update → Boolean | r }
          get = find \{ match } → match change.update

          render
            ∷ ∀ r. { renderer ∷ Renderer update state event | r }
            → Array Types.PropertyUpdate
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
  . ({ state ∷ state, update ∷ update } → Boolean)
  → Renderer update state event
  → Types.Property update state event
watchWhen predicate renderer
  = watch \change →
      if predicate change
        then Types.Rerender (renderer change)
        else Types.Ignore
