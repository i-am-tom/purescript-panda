module Panda where

import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Console (log)
import Data.Maybe                (Maybe(..))
import DOM.HTML                  (window) as DOM
import DOM.HTML.Document         (body) as DOM
import DOM.HTML.Types            (htmlDocumentToDocument, htmlElementToNode) as DOM
import DOM.HTML.Window           (document) as DOM
import DOM.Node.Node             (appendChild) as DOM
import Panda.Bootstrap           (bootstrap)
import Panda.Internal.Types      as Types
import Prelude

runApplication
  ∷ ∀ update state event
  . Types.Application update state event
  → Eff _ Unit

runApplication configuration = do
  window ← DOM.window
  document ← DOM.document window
  bodyish ← DOM.body document

  { cancel, events, element, handleUpdate }
      ← bootstrap
          (DOM.htmlDocumentToDocument document)
          configuration

  case bodyish of
    Just body →
      void $ DOM.appendChild element (DOM.htmlElementToNode body)
    Nothing →
      log "Eep"
