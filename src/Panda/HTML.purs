module Panda.HTML where

--renderTo
--  ∷ ∀ event state action eff
--  . Element
--  → Component event state action
--  → { listener ∷ event → Eff eff Unit
--    , onEvent  ∷ Event action
--    }
--
--renderTo mount document = do
--  { element, listener, onEvent } ← build document
--  (appendChild `on` elementToNode) element document
--
--  pure { listener, onEvent }


--readFrom
--  ∷ ∀ event eff
--  . Element
--  → { listener ∷ event → Eff eff Unit
--    , onEvent  ∷ Event.Event Foreign
--    }

