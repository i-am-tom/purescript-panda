module Test.Main where

import Control.Monad.Eff
import Control.Monad.Eff.Random (RANDOM)
import Data.Foldable (sequence_)
import Prelude (Unit)

import Panda as P

-- These examples are all direct ports of those found at `elm-lang.org`. Shout-
-- out to Evan for this wonderful set!
import Test.Example.HelloWorld    as HelloWorld
import Test.Example.UnorderedList as UnorderedList
import Test.Example.Buttons       as Buttons
import Test.Example.Field         as Field
import Test.Example.Form          as Form
import Test.Example.Random        as Random

type FX eff
  = ( random :: RANDOM
    | P.FX eff
    )

examples :: forall eff. Array (Eff (FX eff) Unit)
examples
  = [ HelloWorld.main
    , UnorderedList.main
    , Buttons.main
    , Field.main
    , Form.main
    , Random.main
    ]

main ∷ forall eff. Eff (FX eff) Unit
main = sequence_ examples
