module Main where

import Control.Monad.Eff    (Eff)
import Control.Plus         (empty)
import Data.Maybe           (Maybe(..))
import FRP.Event.Time       (interval) as FRP
import Panda                (runApplication)
import Panda.HTML           as PH
import Panda.Internal.Types
import Prelude

main ∷ Eff _ Unit
main
  = runApplication
      { view:
          PH.button
            [ PProducer (PropertyProducer
                { key: OnClick
                , event: (_ + 1)
                })
            ]

            [ PH.watchAny \{state} →
                PH.text (show state)
            ]

      , update: case _ of
          Just { event: f, state } →
            pure { update: unit, state: f state }

          Nothing →
            pure { update: unit, state: 0 }

      , subscription: empty
      }


