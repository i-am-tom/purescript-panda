module Panda
  ( module ExportedTypes
  , runApplicationInBody
  ) where

import Effect            (Effect)
import Data.Maybe        (Maybe)
import Data.Traversable  (traverse)
import Panda.Bootstrap   (bootstrap)
import Panda.Internal    (App, FX, Updater) as ExportedTypes
import Panda.Internal    (App, EventSystem, FX)

import Panda.Prelude

-- | A little convenient alias to make your signatures shorter. Note that it is
-- | only an alias, so it wlil be expanded in error messages. IF that _does_
-- | happen, chances are that your types for `update`, `state`, and `event` are
-- | wrong.

type Updater update state event
  = (( state → { update ∷ update, state ∷ state }) → Effect Unit)
  → { event ∷ event, state ∷ state }
  → Effect Unit

-- | Run a Panda application inside the <body> tag, effectively taking over the
-- | entire page. If this _isn't_ what you want to do, `runApplicationInNode`
-- | is a better choice. The result of this is an event system, which allows
-- | you to push information into the Panda application from outside.

runApplicationInBody
  ∷ ∀ update state event
  . App update state event
  → Effect (Maybe (EventSystem update state event))

runApplicationInBody configuration = do
  body
    ← effToEffect
    ∘ map DOM.htmlElementToNode
    $ DOM.window >>= DOM.document >>= DOM.body

  traverse (runApplicationInNode configuration) body

-- | Run a Panda application inside a given DOM node. The result of this is an
-- | event system, which allows you to push information into the Panda
-- | application from outside.

runApplicationInNode
  ∷ ∀ eff update state event
  . App update state event
  → DOM.Node
  → Effect (EventSystem update state event)

runApplicationInNode configuration parent = do
  document
    ← effToEffect
    ∘ map DOM.htmlDocumentToDocument
    $ DOM.window >>= DOM.document

  { system, node } ← bootstrap document configuration
  effToEffect $ DOM.appendChild node parent $> system

