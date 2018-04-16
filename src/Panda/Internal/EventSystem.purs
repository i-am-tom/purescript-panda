module Panda.Internal.EventSystem
  ( EventSystem (..)
  ) where

import Effect (Effect)
import Control.Alt       ((<|>))
import FRP.Event         (Event) as FRP

import Panda.Prelude

newtype EventSystem update state event
  = EventSystem
      { cancel       ∷ Effect Unit
      , events       ∷ FRP.Event event
      , handleUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Effect Unit
      }

instance semigroupEventSystem
    ∷ Semigroup (EventSystem update state event) where
  append (EventSystem this) (EventSystem that)
    = EventSystem
        { events: this.events <|> that.events
        , cancel: this.cancel *> that.cancel
        , handleUpdate: \update → do
            this.handleUpdate update
            that.handleUpdate update
        }

