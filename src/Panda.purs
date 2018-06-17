module Panda
  ( module ExportedTypes
  , runApplicationInBody
  ) where

import Data.Maybe             (Maybe(..), maybe)
import Data.Traversable       (traverse)
import Effect                 (Effect)
import FRP.Event              (Event) as FRP
import Panda.Bootstrap        (bootstrap)
import Panda.Internal.Types   (Component, Updater, ShouldUpdate(..)) as ExportedTypes
import Web.DOM.Internal.Types (Node) as Web
import Web.DOM.Node           (appendChild) as Web
import Web.HTML               (window) as Web
import Web.HTML.HTMLDocument  (body, toDocument) as Web
import Web.HTML.HTMLElement   (toNode) as Web
import Web.HTML.Window        (document) as Web

import Prelude

-- | When a component has been rendered, the following controlls will be
-- | returned. 

type Controller input output
  = { destroy ∷ Effect Unit
    , events  ∷ FRP.Event output
    , update  ∷ input → Effect Unit
    }

-- | Run an application on the `body` element of the page. For most serious use
-- | cases, this is probably a bit more than you want: as with React, it's
-- | generally advised that you attach your application to an element _within_
-- | the DOM.

runApplicationInBody
  ∷ ∀ input output message state
  . ExportedTypes.Component input output message state
  → Effect (Maybe (Controller input output))

runApplicationInBody configuration
  = Web.window >>= Web.document >>= Web.body >>= case _ of
      Just body → do
        controller ← runApplicationInNode configuration (Web.toNode body)
        pure (Just controller)

      Nothing →
        pure Nothing

-- | Run an application within a particular node. Using `ref` within React, we
-- | can embed a Panda application within a React structure, and use some basic
-- | tricks to wire it up to a higher-up event system.

runApplicationInNode
  ∷ ∀ input output message state
  . ExportedTypes.Component input output message state
  → Web.Node
  → Effect (Controller input output)

runApplicationInNode configuration parent = do
  document ← Web.window >>= Web.document
  let document' = Web.toDocument document

  { destroy, events, update, node }
      ← bootstrap document' configuration

  _ ← Web.appendChild node parent
  pure { destroy, events, update }

