module Panda.Prelude
  ( module Prelude
  , module Exports

  , (∘)

  , effToEffect
  , effectToEff
  ) where

import Control.Monad.Eff (Eff)
import Effect            (Effect)
import Unsafe.Coerce     (unsafeCoerce)

import Data.Foldable    (for_, traverse_) as Exports
import Data.Traversable (for, traverse) as Exports
import Data.Maybe       (Maybe(..), fromMaybe, maybe) as Exports
import Debug.Trace      (spy) as Exports

import Prelude

-- | Really, we should do this with `liftEff`, but that introduces extra
-- | dictionaries, which this function will avoid.

effToEffect ∷ ∀ eff. Eff eff ~> Effect
effToEffect
  = unsafeCoerce

-- | We also occasionally need to go _back_ to `Eff` for things like FRP
-- | subscriptions with libraries that haven't switched yet. When 0.12 comes,
-- | there will be plenty of code to delete :)

effectToEff ∷ ∀ eff. Effect ~> Eff eff
effectToEff
  = unsafeCoerce

-- | Unicode composition. `:iabbrev` is magic.

infixr 9 compose as ∘
