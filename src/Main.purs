module Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (log)
import Panda.Bootstrap (bootstrap)
import DOM.HTML (window)
import DOM.HTML.Window (document)
import DOM.HTML.Document (body)
import Data.Foldable (traverse_)

main :: Eff _ Unit
main = window >>= document >>= body >>= traverse_ \b -> do
  pure unit

