module Panda where

--import Panda.Event          as Event
--import Panda.HTML           as HTML
--import Panda.Internal.Types as Types

--import Data.Monoid.Endo     (Endo)


--runAppIn
--  ∷ ∀ update state event
--  . Endo (Application update state event)
--  → Element
--  → Eff (dom ∷ DOM, frp ∷ FRP | eff) Unit
--
--runAppIn element (Endo configurer)
--  = HTML.renderTo element view >>= \{ listener, events } →
--      Event.subscribe listener (Event.loop update subscription events)
--
--  where
--    { view, subscription, update }
--      = configurer
--          { view:         fragment []
--          , subscription: zero
--          , update:       mempty
--          }

