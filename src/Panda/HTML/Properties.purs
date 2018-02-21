module Panda.HTML.Properties where

import Data.Maybe           (Maybe(..))
import DOM.Event.Types      (Event) as DOM
import Panda.Internal.Types as Types
import Prelude              (($), (<<<))

onClick
  ∷ ∀ update state event
  . (DOM.Event → event)
  → Types.Property update state event
onClick onEvent
  = Types.PProducer
      $ Types.PropertyProducer
          { key: Types.OnClick
          , onEvent: Just <<< onEvent
          }

