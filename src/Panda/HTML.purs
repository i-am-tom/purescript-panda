module Panda.HTML
  ( module Builders
  , module Exports
  ) where

import Panda.Builders.Components as Builders
import Panda.Internal.Types      (Component (..), ComponentUpdate) as Exports
import Panda.Internal.Types      as Types

import Panda.Prelude

--delegate
--  ∷ ∀ update subupdate state substate event subevent
--  . { update ∷ update   → Maybe subupdate
--    , state  ∷ state    → substate
--    , event  ∷ subevent → Maybe event
--    }
--  → Types.Application subupdate substate subevent
--  → Types.Component update state event
--
--delegate focus application
--  = Types.Delegate ∘ Types.mkComponentDelegateX
--  $ Types.ComponentDelegate { application, focus }
