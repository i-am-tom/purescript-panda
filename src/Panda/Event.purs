module Panda.Event where

import Control.Monad.Eff (Eff)
import FRP (FRP)
import FRP.Event (Event) as FRP
import Prelude (Unit)

foreign import create
  ∷ ∀ eff a
  . Eff (frp ∷ FRP | eff)
      { event ∷ FRP.Event a
      , push  ∷ a → Eff (frp ∷ FRP | eff) Unit
      }
