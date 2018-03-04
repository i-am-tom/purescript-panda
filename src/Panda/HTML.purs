module Panda.HTML
  ( module Elements
  , module Watchers

  , delegate
  ) where

import Data.Maybe           (Maybe)
import Panda.HTML.Elements  as Elements
import Panda.HTML.Watchers  as Watchers
import Panda.Internal.Types as Types
import Util.Exists          (mkExists3)

-- | Create a delegate application. Applications can be nested inside other,
-- | larger applications providing that a translation from the update / state /
-- | event types of the inner application to the outer application (this
-- | translation is called a `focus`, as the subapplication can be seen as a
-- | `focus` on one particular part of the wider state.).
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
      ( mkExists3
          ( Types.ComponentDelegate
              { delegate: application
              , focus
              }
          )
      )
