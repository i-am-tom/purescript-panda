module Panda.Internal.Application where

import Control.Monad.Eff       (Eff, kind Effect)
import Control.Monad.Eff.Ref   (REF)
import DOM                     (DOM)
import FRP                     (FRP)
import FRP.Event               (Event) as FRP

import Prelude

-- | The effects that are used within Panda's execution cycle.
type FX eff = ( dom ∷ DOM, frp ∷ FRP, ref ∷ REF | eff )

-- | Convenience synonym for defining the type of updaters within a Panda
-- | application.
type Updater eff update state event
  = ( ( state
      → { update ∷ update, state ∷ state }
      )
    → Eff eff Unit
    )
  → { event ∷ event, state ∷ state }
  → Eff eff Unit

-- | A Panda application is a view (written in the component DSL) that is
-- | interpreted into an element (to be attached to the DOM), an event stream
-- | (that is merged with the subscription) that feeds into the update
-- | function, that update function (which produces updates for the view), and
-- | intiial state and update.
type Application component eff update state event
  = { view         ∷ component eff update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update       ∷ Updater eff update state event
    }

