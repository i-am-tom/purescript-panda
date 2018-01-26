module Panda.HTML where


--render
--  ∷ ∀ update state event eff
--  . Application update state event
--  → Eff { listener ∷ update → Eff eff Unit
--        , events   ∷ Event event
--        , element  ∷ Element
--        }
--
--render
--  = case _ of
--      CText text →
--        createTextNode text
--
--      CDelegate delegate →
--        delegate # runExists2 \{ delegate, focus: { update, state } } →
--
--      CWatcher listener
--      CStatic { children, properties, tagName } → 

