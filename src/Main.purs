module Main where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Data.Maybe        (Maybe(..))
import Panda             as P
import Panda.HTML        as PH
import Panda.Property    as PP
import Prelude


data NumberPickerEvent
  = NumberPickerIncrement
  | NumberPickerDecrement


view
  ∷ ∀ eff
  . P.Component eff Unit Int NumberPickerEvent
view
  = PH.div_
      [ PH.button
          [ PP.onClick \_ → NumberPickerDecrement
          ]

          [ PH.text "-"
          ]

      , PH.watchAny \{ state } →
          PH.text (show state)

      , PH.button
          [ PP.onClick \_ → NumberPickerIncrement
          ]

          [ PH.text "+"
          ]
      ]


update
  ∷ ∀ eff
  . Maybe { event ∷ NumberPickerEvent, state ∷ Int }
  → Eff eff { update ∷ Unit, state ∷ Int }
update
  = case _ of
      Just { event, state } →
        pure
          { update: unit
          , state: case event of
              NumberPickerIncrement → state + 1
              NumberPickerDecrement → state - 1
          }

      Nothing →
        pure
          { update: unit
          , state: 0
          }


main
  ∷ Eff _ Unit
main
  = P.runApplication
      { view
      , update
      , subscription: empty
      }

