module Main where

import Control.Monad.Eff    (Eff)
import Data.Maybe           (Maybe(..))
import FRP.Event.Time       (interval) as FRP
import Panda                (runApplication)
import Panda.HTML           (text, watchAny)
import Prelude

main ∷ Eff _ Unit
main
  = runApplication
      { view: watchAny \update →
          text case update of
            Just { state } → show state
            Nothing        → "0"

      , update: case _ of
          Just { event: time } →
            pure { update: unit, state: time }
          Nothing →
            pure { update: unit, state: 0 }

      , subscription: FRP.interval 100
      }


