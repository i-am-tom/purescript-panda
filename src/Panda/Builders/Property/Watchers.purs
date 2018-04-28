module Panda.Builders.Property.Watchers where

import Panda.Internal.Types as Types

watch
  ∷ ∀ update state event
  . ( { update ∷ update, state ∷ state }
    → Types.ShouldUpdate (Types.Property update state event)
    )
  → Types.Property update state event

watch listener
  = Types.Dynamic listener

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
