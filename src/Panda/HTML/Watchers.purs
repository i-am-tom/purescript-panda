module Panda.HTML.Watchers where

import Data.Lazy            (defer)
import Panda.Internal.Types as Types

watchAny
  ∷ ∀ eff update state event
  . ( { state ∷ state, update ∷ update }
    → Types.Component eff update state event
    )
  → Types.Component eff update state event
watchAny renderer
  = Types.CWatcher
      ( Types.ComponentWatcher \update →
          { interest: true
          , renderer: defer \_ → renderer update
          }
      )
