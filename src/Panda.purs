module Panda
  ( module ExportedTypes
  , runApplication
  ) where

import Control.Monad.Eff    (Eff)
import DOM.HTML             (window)
import DOM.HTML.Document    (body)
import DOM.HTML.Types       (htmlDocumentToDocument, htmlElementToNode)
import DOM.HTML.Window      (document)
import DOM.Node.Node        (appendChild)
import DOM.Node.Types       (Node)
import Data.Maybe           (Maybe)
import Data.Traversable     (traverse)
import Panda.Bootstrap      (bootstrap)
import Panda.Internal.Types (Application, FX, Updater) as ExportedTypes
import Panda.Internal.Types as Types

import Prelude

-- | Run a Panda application. This takes a Panda application and appends it to
-- | the `document.body`, effectively commandeering the entire page. If this
-- | _isn't_ what you want, chances are that you're after `runApplicationIn`,
-- | which will allow you to embed a Panda application inside the  Note that
-- | this function returns a `Maybe`, depending on the presence of `body`, so
-- | this result should be checked to determine whether instantiation was
-- | successful.
runApplication
  ∷ ∀ eff update state event
  . Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff)
      (Maybe (Types.EventSystem (Types.FX eff) update state event))

runApplication configuration
    = window
  >>= document
  >>= body
  >>= traverse (runApplicationIn configuration <<< htmlElementToNode)

-- | Run a Panda application inside a given element. The result of doing this
-- | is an event system, which gives you control over cancelling an
-- | application, inspecting any events that it produces, and pushing updates
-- | directly into the application.
runApplicationIn
  ∷ ∀ eff update state event
  . Types.Application (Types.FX eff) update state event
  → Node
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

runApplicationIn configuration node
    = window
  >>= document
  >>= htmlDocumentToDocument
  >>> (_ `bootstrap` configuration)
  >>= \{ system, element } → appendChild element node $> system

