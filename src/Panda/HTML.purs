module Panda.HTML
  ( module Elements
  , module Watchers

  , delegate
  ) where

import Data.Maybe           (Maybe)
import Panda.HTML.Elements  as Elements
import Panda.HTML.Watchers  as Watchers
import Panda.Internal.Types as Types
import Prelude              (($))
import Util.Exists          (mkExists3)

delegate
  ∷ ∀ eff update update' state state' event event'
  . { update ∷ update → Maybe update'
    , state  ∷ state → state'
    , event ∷ event' → event
    }
  → Types.Application eff update' state' event'
  → Types.Component eff update state event
delegate focus application
  = Types.CDelegate
      $ mkExists3
          $ Types.ComponentDelegate
              { delegate: application
              , focus
              }
