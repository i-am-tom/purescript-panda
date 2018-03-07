module Panda
  ( module ExportedTypes
  , runApplication
  ) where

import Control.Monad.Eff         (Eff)
import DOM.HTML                  (window) as DOM
import DOM.HTML.Document         (body) as DOM
import DOM.HTML.Types            (htmlDocumentToDocument, htmlElementToNode) as DOM
import DOM.HTML.Window           (document) as DOM
import DOM.Node.Types            (Node) as DOM
import Data.Maybe                (Maybe)
import Data.Traversable          (for)
import Panda.Bootstrap           (bootstrap)
import Panda.Internal.Types      (Application, Component, FX, Property, Modification(..), ShouldUpdate(..)) as ExportedTypes
import Panda.Internal.Types      as Types

import Prelude

-- | Run a Panda application. This takes a Panda application and appends it to
-- | the `document.body`, effectively commandeering the entire page. If this
-- | _isn't_ what you want, chances are that you're after `runApplicationIn`,
-- | which will allow you to embed a Panda application inside the DOM. Note
-- | that this function returns a `Maybe`, depending on the presence of `body`,
-- | so this result should be checked to determine whether instantiation was
-- | successful.
runApplication
  ∷ ∀ eff update state event
  . Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff)
      (Maybe (Types.EventSystem (Types.FX eff) update state event))

runApplication configuration = do
  window   ← DOM.window
  document ← DOM.document window
  body     ← DOM.body document

  for body \element →
    runApplicationIn
      configuration
      (DOM.htmlElementToNode element)

-- | Run a Panda application inside a given element. The result of doing this
-- | is an event system, which gives you control over cancelling an
-- | application, inspecting any events that it produces, and pushing updates
-- | directly into the application.
runApplicationIn
  ∷ ∀ eff update state event
  . Types.Application (Types.FX eff) update state event
  → DOM.Node
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)
runApplicationIn configuration node = do
  window   ← DOM.window
  document ← DOM.document window

  bootstrap (DOM.htmlDocumentToDocument document) node configuration

