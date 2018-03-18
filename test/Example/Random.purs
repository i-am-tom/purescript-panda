module Test.Example.Random where

import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Random (RANDOM, randomInt)
import Control.Plus             (empty)
import Data.Maybe               (Maybe(..))

import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

data Event        = RollTheDice
type NumberRolled = Maybe Int

type FX eff
  = ( random :: RANDOM
    | P.FX eff
    )

main :: forall eff. Eff (FX eff) Unit
main
  = void $ P.runApplication
      { view: PH.div_
          [ PH.div'_ $ PH.renderMaybe _.update \value ->
              PH.text (show value)

          , PH.button
              [ PP.onClick \_ -> Just RollTheDice
              ]

              [ PH.text "Roll the dice!"
              ]
          ]

      , subscription: empty
      , initial: { update: Nothing, state: unit }
      , update: \dispatch _ -> do
          value <- randomInt 0 6

          dispatch \_ ->
            { update: Just value
            , state:  unit
            }
      }
