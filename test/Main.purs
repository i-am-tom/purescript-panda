module Test.Main where

import Control.Monad.Eff
import Control.Monad.Eff.Random (RANDOM)
import Data.Foldable (sequence_)
import Prelude (Unit)

import Panda as P

import Test.Example.DataTable as DataTable

examples :: forall eff. Array (Eff _ Unit)
examples
  = [ DataTable.main
    ]

main ∷ Eff _ Unit
main = sequence_ examples
