module Panda.Internal.EventSystem
  ( EventSystem (..)
  , cancelEventSystem
  , foldEventSystem
  , handleUpdateWithEventSystem
  ) where

import Control.Alt       ((<|>))
import Control.Monad.Eff (Eff, kind Effect)
import Data.Monoid       (class Monoid)
import FRP.Event         (Event) as FRP

import Prelude

-- | An event system defines the update/event mechanism for a particular
-- | component. When we update the DOM, we must remember to cancel outgoing
-- | elements, and register new update handlers.

data EventSystem eff update state event
  = DynamicSystem
      { cancel       ∷ Eff eff Unit
      , events       ∷ FRP.Event event
      , handleUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff eff Unit
      }

  | StaticSystem -- There's no event system required!

-- | Given an event system, run the second argument on its contents if dynamic,
-- | else just return the first value.

foldEventSystem
  ∷ ∀ eff update state event result
  . result
  → ( { cancel       ∷ Eff eff Unit
      , events       ∷ FRP.Event event
      , handleUpdate ∷ { update ∷ update, state ∷ state } → Eff eff Unit
      }
    → result
    )
  → EventSystem eff update state event
  → result

foldEventSystem static handleDynamic
  = case _ of
      StaticSystem         → static
      DynamicSystem system → handleDynamic system

-- | Given an applicative context, do something effectful to a **dynamic**
-- | system, and do nothing with a static one.

runA
  ∷ ∀ f eff update state event
  . Applicative f
  ⇒ ( { cancel       ∷ Eff eff Unit
      , events       ∷ FRP.Event event
      , handleUpdate ∷ { update ∷ update, state ∷ state } → Eff eff Unit
      }
    → f Unit
    )
  → EventSystem eff update state event
  → f Unit
runA = foldEventSystem (pure unit)

-- | Cancel an event system. This is a no-op on static systems.

cancelEventSystem
  ∷ ∀ eff update state event
  . EventSystem eff update state event
  → Eff eff Unit
cancelEventSystem
  = runA _.cancel

-- | Handle an update with this event handler. Static handlers will do nothing,
-- | whereas dynamic handlers have the option to respond to an update.

handleUpdateWithEventSystem
  ∷ ∀ eff update state event
  . { update ∷ update, state ∷ state }
  → EventSystem eff update state event
  → Eff eff Unit
handleUpdateWithEventSystem update
  = runA \{ handleUpdate } →
      handleUpdate update

-- | Event systems can be combined by merging their event streams and
-- | concatenating their handlers/cancellers. Nothing hugely exciting.
-- |
instance semigroupEventSystem
    ∷ Semigroup (EventSystem eff update state event) where
  append (DynamicSystem this) (DynamicSystem that)
    = DynamicSystem
        { events: this.events <|> that.events
        , cancel: this.cancel *> that.cancel
        , handleUpdate: this.handleUpdate <> that.handleUpdate
        }

  append (DynamicSystem this) _    = DynamicSystem this
  append  _                   that = that

-- | The identity event system is static, and is hence ignored by any `<>`
-- | operation.

instance monoidEventSystem
    ∷ Monoid (EventSystem eff update state event) where
  mempty = StaticSystem

