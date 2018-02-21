module Panda.HTML.Watchers where

import Data.Lazy            (defer)
import Data.Maybe           (Maybe)
import Panda.Internal.Types as Types
import Prelude              (($))

watchAny
  ∷ ∀ update state event
  . ( { state ∷ state, update ∷ update }
    → Types.Component _ update state event
    )
  → Types.Component _ update state event
watchAny renderer
  = Types.CWatcher
      $ Types.ComponentWatcher \update →
          { interest: true
          , renderer: defer \_ → renderer update
          }
