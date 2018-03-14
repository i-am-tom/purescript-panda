module Panda.HTML
  ( module Elements
  , module Watchers

  , delegate
  ) where

import Data.Maybe           (Maybe)
import Panda.HTML.Elements  as Elements
import Panda.HTML.Watchers  as Watchers
import Panda.Internal.Types as Types

delegate
  ∷ ∀ eff update subupdate state substate event subevent
  . { update ∷ update   → Maybe subupdate
    , state  ∷ state    → substate
    , event  ∷ subevent → event
    }
  → Types.Application eff subupdate substate subevent
  → Types.Component eff update state event
delegate focus application
  = Types.CDelegate
      ( Types.mkComponentDelegateX
          ( Types.ComponentDelegate
              { delegate: application
              , focus
              }
          )
      )
