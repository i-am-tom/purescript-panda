module Panda
  ( module ExportedTypes
  , runApplicationInBody

  , Updater
  ) where

import DOM.HTML                   (window) as DOM
import DOM.HTML.Document          (body) as DOM
import DOM.HTML.Types             (htmlDocumentToDocument, htmlElementToNode) as DOM
import DOM.HTML.Window            (document) as DOM
import DOM.Node.Node              (appendChild) as DOM
import DOM.Node.Types             (Node) as DOM
import Effect                     (Effect)
import Panda.Bootstrap            (bootstrap)
import Panda.Internal.Types       as Types
import Panda.Internal.Types       (Application, ShouldUpdate(..)) as ExportedTypes

import Panda.Prelude

-- | A little convenient alias to make your signatures shorter. Note that it is
-- | only an alias, so it will be expanded in error messages. If that _does_
-- | happen, chances are that one or more of your types for `update`, `state`,
-- | and `event` are wrong.

type Updater update state event
  = ((state → { update ∷ update, state ∷ state }) → Effect Unit)
  → { event ∷ event, state ∷ state }
  → Effect Unit

-- | Run a Panda application inside the <body> tag, effectively taking over the
-- | entire page. If this _isn't_ what you want to do, `runApplicationInNode`
-- | is a better choice. The result of this is an event system, which allows
-- | you to push information into the Panda application from outside.

runApplicationInBody
  ∷ ∀ update state event
  . Types.Application update state event
  → Effect (Maybe (Types.EventSystem update state event))

runApplicationInBody configuration = do
  body ← effToEffect $ DOM.window >>= DOM.document >>= DOM.body

  body # maybe (pure Nothing)
    ( runApplicationInNode configuration
    ∘ DOM.htmlElementToNode
    )

-- | Run a Panda application inside a given DOM node. The result of this is an
-- | event system, which allows you to push information into the Panda
-- | application from outside.

runApplicationInNode
  ∷ ∀ update state event
  . Types.Application update state event
  → DOM.Node
  → Effect (Maybe (Types.EventSystem update state event))

runApplicationInNode configuration parent = do
  document ← effToEffect (DOM.window >>= DOM.document)
  let document' = DOM.htmlDocumentToDocument document
  { system, node } ← bootstrap document' configuration

  effToEffect (DOM.appendChild node parent) $> system

