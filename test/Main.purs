module Test.Main where

import Effect
import Data.Foldable (sequence_)
import Prelude (Unit)

import Test.Example.DataTable as DataTable

examples :: Array (Effect Unit)
examples
  = [ DataTable.main
    ]

main ∷ Effect Unit
main = sequence_ examples
