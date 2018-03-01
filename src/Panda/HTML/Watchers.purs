module Panda.HTML.Watchers where

import Data.Foldable        (find)
import Data.Maybe           (Maybe(..))
import Panda.Internal.Types as Types

import Prelude

-- | The shape of a user-supplied renderer. This will most likely be supplied
-- by the user.
type Renderer eff update state event
  = { state ∷ state, update ∷ update }
  → Types.Modification (Types.Component eff update state event)

-- | Build a general-purpose watcher. This could be seen as the "advanced"
-- watcher, because all the other functions are much easier to use.
watch
  ∷ ∀ eff update state event
  . ( { state  ∷ state
      , update ∷ update
      }
    → Types.ShouldUpdate
        ( Types.Modification
            ( Types.Component eff update state event
            )
        )
    )
  → Types.Component eff update state event
watch listener
  = Types.CWatcher (Types.ComponentWatcher listener)

-- | Update whenever any event is encountered. In most situations, this isn't
-- going to be what you want to do, as it's computationally expensive to
-- re-render the node continually. However, for very simple (sub)applications,
-- where every possible event is of interest, this might save you a line or two
-- of code.
watchAny
  ∷ ∀ eff update state event
  . Renderer eff update state event
  → Types.Component eff update state event
watchAny renderer
  = watch \update →
      Types.Rerender (renderer update)

-- | Watch for a particular update.
watchFor
  ∷ ∀ eff update state event
  . Eq update
  ⇒ update
  → Renderer eff update state event
  → Types.Component eff update state event
watchFor search renderer
  = watch \change →
      if change.update == search
        then Types.Rerender (renderer change)
        else Types.Ignore

-- | Watch for a set of actions. This could be seen as a "router" of sorts,
-- save for the fact that there can be no fallback (as it would be triggered on
-- every occurrence of any event).
watchSet
  ∷ ∀ eff update state event
  . Array
      { match    ∷ update → Boolean
      , renderer ∷ Renderer eff update state event
      }
  → Types.Component eff update state event
watchSet routes
  = watch \change →
      case find (\{ match } → match change.update) routes of
        Just { renderer } →
          Types.Rerender (renderer change)

        Nothing →
          Types.Ignore

-- | Update something based on whether a particular predicate is satisfied.
watchWhen
  ∷ ∀ eff update state event
  . ({ state ∷ state, update ∷ update } → Boolean)
  → Renderer eff update state event
  → Types.Component eff update state event
watchWhen predicate renderer
  = watch \change →
      if predicate change
        then Types.Rerender (renderer change)
        else Types.Ignore
