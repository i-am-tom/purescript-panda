module Panda
  ( module ExportedTypes
  , runApplicationInBody
  ) where

import Control.Monad.Eff (Eff)
import DOM.HTML          (window) as DOM
import DOM.HTML.Document (body) as DOM
import DOM.HTML.Types    (htmlDocumentToDocument, htmlElementToNode) as DOM
import DOM.HTML.Window   (document) as DOM
import DOM.Node.Node     (appendChild) as DOM
import DOM.Node.Types    (Node) as DOM
import Data.Maybe        (Maybe)
import Data.Traversable  (traverse)
import Panda.Bootstrap   (bootstrap)
import Panda.Internal    (App, Component, FX, Updater) as ExportedTypes
import Panda.Internal    (App, EventSystem, FX)

import Prelude


-- | Run a Panda application. This takes a Panda application and appends it to
-- | the `document.body`, effectively commandeering the entire page. If this
-- | _isn't_ what you want, chances are you're after `runApplicationInNode`,
-- | which will allow you to embed a Panda application inside the given node.
-- | Note that this function returns a `Maybe`, depending on the presence of
-- | `body`, so this result should be checked to determine whether
-- | instantiation was successful.

runApplicationInBody
  ∷ ∀ eff update state event
  . App (FX eff) update state event
  → Eff (FX eff)
      ( Maybe (EventSystem (FX eff) update state event)
      )

runApplicationInBody configuration = do
  window   ← DOM.window
  document ← DOM.document window
  body     ← DOM.body document

  traverse (runApplicationInNode configuration)
    (map DOM.htmlElementToNode body)


-- | Run a Panda application inside a given node. The result of doing this is
-- | an event system, which gives you control over cancelling an application,
-- | inspecting any events that it produces, and pushing updates directly into
-- | the application.

runApplicationInNode
  ∷ ∀ eff update state event
  . App (FX eff) update state event
  → DOM.Node
  → Eff (FX eff)
      ( EventSystem (FX eff) update state event
      )

runApplicationInNode configuration parent = do
  window   ← DOM.window
  document ← DOM.document window

  let document' = DOM.htmlDocumentToDocument document
  { system, node } ← bootstrap document' configuration

  DOM.appendChild node parent $> system

