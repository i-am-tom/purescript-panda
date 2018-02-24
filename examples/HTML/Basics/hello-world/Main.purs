module Main where

import Panda      (renderApplication)
import Panda.HTML (text)
import Prelude

main ∷ Eff _ Unit
main
  = renderApplication
      { view: text "Hello, world!"
      , update: \_ → unit
      , subscription: zero
      }

