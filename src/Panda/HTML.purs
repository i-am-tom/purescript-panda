module Panda.HTML
  ( module Builders
  , module Exports
  ) where

import Panda.Builders.Components as Builders
import Panda.Internal.Types      (Component (..), ComponentUpdate) as Exports
import Panda.Internal.Types      as Types

import Panda.Prelude

-- | Embed an application into a component, allowing for it to exist in a
-- | larger application. This also gives us the opportunity to filter out
-- | events and updates in which we're not so interested.

delegate
  ∷ ∀ update subupdate state substate event subevent
  . { update ∷ update   → Maybe subupdate
    , state  ∷ state    → substate
    , event  ∷ subevent → Maybe event
    }
  → Types.Application subupdate substate subevent
  → Types.Component update state event

delegate focus application
  = Types.Delegate
  ∘ Types.mkComponentDelegateX
  $ Types.ComponentDelegate { application, focus }
