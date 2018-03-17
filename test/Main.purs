module Test.Main where

import Control.Monad.Eff
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

examples :: forall eff. Array (Eff (P.FX eff) Unit)
examples
  = [ HelloWorld.main
    , UnorderedList.main
    , Buttons.main
    , Field.main
    , Form.main
    ]

main ∷ forall eff. Eff (P.FX eff) Unit
main = sequence_ examples
