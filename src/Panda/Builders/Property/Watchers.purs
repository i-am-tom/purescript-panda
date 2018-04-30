module Panda.Builders.Property.Watchers where

import Panda.Internal.Types as Types

-- | Watch for changes in state and update accordingly. Note that adding a
-- | property will remove any previously-set properties, so it is advised that
-- | you use independent `watch` values for each property that is dynamic.

watch
  ∷ ∀ update state event
  . ( { update ∷ update, state ∷ state }
    → Types.ShouldUpdate (Types.Property update state event)
    )
  → Types.Property update state event

watch listener
  = Types.Dynamic listener

-- | Given a predicate on the state and update, this function will recompute a
-- | value whenever the predicate yields true.

when
  ∷ ∀ update state event
  . ({ update ∷ update, state ∷ state } → Boolean)
  → ({ update ∷ update, state ∷ state } → Types.Property update state event)
  → Types.Property update state event

when predicate build
  = Types.Dynamic \update →
      if predicate update
        then Types.SetTo (build update)
        else Types.Ignore
