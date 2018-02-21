module Main where

import Control.Monad.Eff    (Eff)
import Control.Plus         (empty)
import Data.Maybe           (Maybe(..))
import Panda                (runApplication)
import Panda.HTML           as PH
import Prelude

data NumberPickerEvent
  = NumberPickerIncrement
  | NumberPickerDecrement

main ∷ Eff _ Unit
main
  = runApplication
      { view:
          PH.div_
            [ PH.button
                [ PH.onClick NumberPickerIncrement
                ]

                [ PH.text "-"
                ]

            , PH.watchAny \{ state } →
                PH.text (show state)

            , PH.button
                [ PH.onClick NumberPickerDecrement
                ]

                [ PH.text "+"
                ]
            ]

      , update: case _ of
          Just { event, state } →
            pure
              { update: unit
              , state: case event of
                  NumberPickerIncrement → state + 1
                  NumberPickerDecrement → state - 1
              }

          Nothing →
            pure { update: unit, state: 0 }

      , subscription: empty
      }


