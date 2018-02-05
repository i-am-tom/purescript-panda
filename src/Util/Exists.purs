module Util.Exists
  ( Exists3
  , mkExists3
  , runExists3
  ) where

import Unsafe.Coerce (unsafeCoerce)

foreign import data Exists3 ∷ (Type → Type → Type → Type) → Type

mkExists3 ∷ ∀ f a b c. f a b c → Exists3 f
mkExists3 = unsafeCoerce

runExists3 ∷ ∀ f r. (∀ x y z. f x y z → r) → Exists3 f → r
runExists3 = unsafeCoerce

