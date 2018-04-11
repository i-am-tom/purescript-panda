module Panda.HTML
  ( module Builders
  , module ExportedTypes

  , delegate
  ) where

import Data.Maybe     (Maybe)
import Panda.Internal as Types

-- | The user API for producing _components_, usually imported under the `PH`
-- | (`Panda.HTML`) namespace for consistency with other front end PureScript
-- | frameworks such as Halogen.

import Panda.Builders.Components as Builders
import Panda.Internal
         ( Children
         , Component
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
