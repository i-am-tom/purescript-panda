module Util.Exists2
  ( Exists2
  , mkExists2
  , runExists2
  ) where

import Unsafe.Coerce (unsafeCoerce)

foreign import data Exists2 ∷ (Type → Type → Type) → Type

mkExists2 ∷ ∀ f a b. f a b → Exists2 f
mkExists2 = unsafeCoerce

runExists2 ∷ ∀ f r. (∀ x y. f x y → r) → Exists2 f → r
runExists2 = unsafeCoerce

