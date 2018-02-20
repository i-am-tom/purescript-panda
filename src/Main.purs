module Main where

import Control.Monad.Eff    (Eff)
import Data.Lazy            (defer)
import Data.Maybe           (Maybe(..))
import FRP.Event.Time       (interval) as FRP
import Panda                (runApplication)
import Panda.HTML           (text)
import Panda.Internal.Types as Types
import Prelude

main ∷ Eff _ Unit
main
  = runApplication
      { view: Types.CWatcher
          $ Types.ComponentWatcher
              case _ of
                Just { state } →
                  { interest: true
                  , renderer: defer \_ → text $ show state
                  }

                Nothing →
                  { interest: false
                  , renderer: defer \_ → text "0"
                  }

      , update: case _ of
          Just { event: time } →
            pure { update: unit, state: time }
          Nothing →
            pure { update: unit, state: 0 }

      , subscription: FRP.interval 1000
      }


