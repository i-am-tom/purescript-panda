module Panda.Builders.Property.Watchers where

import Panda.Internal.Types as Types

import Panda.Prelude

when
  ∷ ∀ update state event
  . ( { update ∷ update, state ∷ state } → Boolean)
  → ( { update ∷ update, state ∷ state }
    → Types.Property update state event
    )
  → Types.Property update state event

when predicate listener
  = Types.Dynamic
  ∘ map Types.SetTo
  $ listener
