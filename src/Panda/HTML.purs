module Panda.HTML
  ( module Builders
  , module ExportedTypes

  , delegate
  ) where

import Data.Maybe     (Maybe)
import Panda.Internal as I

import Panda.Builders.Components as Builders
import Panda.Internal
         ( Component (..)
         , ComponentUpdate
         )
  as ExportedTypes

delegate
  ∷ ∀ eff update subupdate state substate event subevent
  . { update ∷ update   → Maybe subupdate
    , state  ∷ state    → substate
    , event  ∷ subevent → Maybe event
    }
  → I.App eff subupdate substate subevent
  → I.Component eff update state event

delegate focus application
  = I.ComponentDelegate
      ( I.mkComponentDelegateX
          { delegate: application
          , focus
          }
      )
