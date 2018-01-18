module Panda where


-- The Elm architecture, reimagined without a virtual DOM.


-- An endomorphism.

type Endo a = a → a


---


-- Given a config and a mounting point, we can produce a view that is wired to
-- the subscription.

--runAppIn
--  ∷ ∀ eff
--  . Endo (Config eff)
--  → Element
--  → Eff (dom ∷ DOM | eff) Unit
--
--runAppIn element configurer
--  = HTML.renderTo element (view initialState) >>= \{ listener, onEvent } →
--      Event.subscribe listener (subscription <|> map update onEvent)
--
--  where
--    { view, subscription, update, initialState }
--      = configurer
--          { view:         fragment []
--          , subscription: zero
--          , update:       \_ _ → mempty
--          , init:         unit
--          }


---


-- We can wire up the entire body!

--runApp
--  ∷ ∀ eff
--  . Endo (Config eff)
--  → Eff (dom ∷ DOM | eff) Unit
--
--runApp configurer = do
--  document ← DOM.document
--  body ← DOM.body
--
--  maybe
--    (runAppIn configurer)
--    (Console.error "Couldn't find the DOM!")
--    body


---


-- We don't really need to write much purescript at all...

--type ForeignConfig eff
--  = ∀ event state
--  . { subscription ∷ Event event eff
--    , update       ∷ state → Foreign → event
--    }


--runAppOn
--  ∷ Endo (ForeignConfig eff)
--  → Element
--  → Eff (dom ∷ DOM | eff) Unit

--runAppOn configurer element
--  = HTML.readFrom element >>= \{ listener, onEvent } →
--      animate listener (subscription <|> map update onEvent)

--  where
--    { subscription, update }
--        = configurer defaultConfiguration
