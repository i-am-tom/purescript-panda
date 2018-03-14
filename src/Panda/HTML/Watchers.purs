module Panda.HTML.Watchers where

import Panda.Internal.Types as Types

type Renderer eff update state event
  = { state ∷ state, update ∷ update }
  → Array (Types.ComponentUpdate eff update state event)
-- 
-- watch
--   ∷ ∀ eff update state event
--   . ( { state  ∷ state
--       , update ∷ update
--       }
--     → Types.ShouldUpdate
--         ( Array (Types.ComponentUpdate eff update state event)
--         )
--     )
--   → Types.Component eff update state event
-- watch listener
--   = Types.CWatcher (Types.ComponentWatcher listener)
-- 
-- watchAny
--   ∷ ∀ eff update state event
--   . Renderer eff update state event
--   → Types.Component eff update state event
-- watchAny renderer
--   = watch \update →
--       Types.Rerender (renderer update)
-- 
-- watchFor
--   ∷ ∀ eff update state event
--   . Eq update
--   ⇒ update
--   → Renderer eff update state event
--   → Types.Component eff update state event
-- watchFor search renderer
--   = watch \change →
--       if change.update == search
--         then Types.Rerender (renderer change)
--         else Types.Ignore
-- 
-- watchSet
--   ∷ ∀ eff update state event
--   . Array
--       { match    ∷ update → Boolean
--       , renderer ∷ Renderer eff update state event
--       }
--   → Types.Component eff update state event
-- watchSet routes
--   = watch \change →
--       case find (\{ match } → match change.update) routes of
--         Just { renderer } →
--           Types.Rerender (renderer change)
-- 
--         Nothing →
--           Types.Ignore
-- 
-- watchWhen
--   ∷ ∀ eff update state event
--   . ({ state ∷ state, update ∷ update } → Boolean)
--   → Renderer eff update state event
--   → Types.Component eff update state event
-- watchWhen predicate renderer
--   = watch \change →
--       if predicate change
--         then Types.Rerender (renderer change)
--         else Types.Ignore
