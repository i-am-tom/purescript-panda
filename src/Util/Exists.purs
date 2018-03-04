module Util.Exists
  ( Exists3
  , mkExists3
  , runExists3
  ) where

import Unsafe.Coerce (unsafeCoerce)

-- | The `Exists3` data type is just like `Exists`, except for the fact that it
-- | "houses" three existentials.  For more complete documentation, see the
-- | [Data.Exists](`https://pursuit.purescript.org/packages/purescript-exists)
-- | package.
foreign import data Exists3 ∷ (Type → Type → Type → Type) → Type

-- | Existentialise three type variables.
mkExists3 ∷ ∀ f a b c. f a b c → Exists3 f
mkExists3 = unsafeCoerce

-- | Remove the existential. Note that, when we do this, we have _no idea_ what
-- | the types of these variables are, so we have to handle them with a
-- | function that will work for _all_ types.
runExists3 ∷ ∀ f r. (∀ x y z. f x y z → r) → Exists3 f → r
runExists3 = unsafeCoerce

