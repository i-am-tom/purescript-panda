module Panda.HTML
  ( module Elements
  , module ExportedTypes

  , delegate
  ) where

import Data.Maybe              (Maybe)
import Panda.Builders.Elements as Elements
import Panda.Internal.Types    as Types
import Panda.Internal.Types
         ( Children  (..)
         , Component (..)
         , ComponentUpdate
         )
  as ExportedTypes

-- | Wrap an application within a component such that it can be embedded within
-- | a larger application.
delegate
  ∷ ∀ eff update subupdate state substate event subevent
  . { update ∷ update   → Maybe subupdate
    , state  ∷ state    → substate
    , event  ∷ subevent → Maybe event
    }
  → Types.Application eff subupdate substate subevent
  → Types.Component eff update state event

delegate focus application
  = Types.ComponentDelegate
      ( Types.mkComponentDelegateX
          { delegate: application
          , focus
          }
      )
