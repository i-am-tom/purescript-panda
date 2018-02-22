module Panda.HTML
  ( module Panda.HTML.Elements
  , module Panda.HTML.Watchers

  , delegate
  ) where

import Data.Maybe           (Maybe)
import Panda.HTML.Elements
import Panda.HTML.Watchers
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
