module Test.Main where

import Control.Monad.Eff
import Control.Monad.Eff.Random (RANDOM)
import Data.Foldable (sequence_)
import Prelude (Unit)

import Panda as P

import Test.Example.DataTable as DataTable

type FX eff
  = ( random :: RANDOM
    | P.FX eff
    )

examples :: forall eff. Array (Eff (FX eff) Unit)
examples
  = [ DataTable.main
    ]

main ∷ forall eff. Eff (FX eff) Unit
main = sequence_ examples
