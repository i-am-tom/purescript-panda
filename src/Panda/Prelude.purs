module Panda.Prelude
  ( module Prelude

  , (∘)

  , document
  , effToEffect
  , effectToEff
  ) where

import Control.Monad.Eff (Eff)
import DOM.HTML          (window) as DOM
import DOM.HTML.Window   (document) as DOM
import DOM.HTML.Types    (htmlDocumentToDocument)
import DOM.Node.Types    (Document)
import Effect            (Effect)
import Unsafe.Coerce     (unsafeCoerce)

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

-- | Get the `document` object from the DOM. This happens often enough that
-- | this felt morally defensible.

document ∷ Effect Document

document
  = effToEffect
  ∘ map htmlDocumentToDocument
  $ DOM.window >>= DOM.document

-- | Unicode composition. `:iabbrev` is magic.

infixr 9 compose as ∘
