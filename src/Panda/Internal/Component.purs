module Panda.Internal.Component where

import Panda.Internal.Property (Properties)
import Control.Monad.Eff       (Eff, kind Effect)
import Control.Monad.Eff.Ref   (REF)
import DOM                     (DOM)
import Data.Algebra.Array      as Algebra.Array
import Data.Maybe              (Maybe)
import FRP                     (FRP)
import FRP.Event               (Event) as FRP
import Unsafe.Coerce           (unsafeCoerce)

import Prelude

-- | The effects that are used within Panda's execution cycle.
type FX eff = ( dom ∷ DOM, frp ∷ FRP, ref ∷ REF | eff )

type ComponentUpdate eff update state event
  = Algebra.Array.Update (Component eff update state event)

-- | Children on elements can either be static (not looking for events), or
-- | dynamic. Note that the children of static children can be dynamic!
data Children eff update state event
  = StaticChildren
      ( Array (Component eff update state event)
      )

  | DynamicChildren
      ( { update ∷ update
        , state  ∷ state
        }
      → (Array (ComponentUpdate eff update state event))
      )

-- | A component is either a delegate (embedded sub-application), element
-- | (with properties and children and an HTML representation), or just some
-- | text.
data Component eff update state event
  = ComponentDelegate (ComponentDelegateX eff update state event)

  | ComponentElement
      { children   ∷ Children eff update state event
      , properties ∷ Properties update state event
      , tagName    ∷ String
      }

  | CText String

-- | Component delegates allow us to reuse applications within larger
-- | applications, provided that we can wire up the two event systems. Note
-- | the possible leak here: in certain cases, we _can_ isolate a
-- | sub-application as a black box within a larger application by ignoring all
-- | incoming updates and outgoing events.
type ComponentDelegate eff update state event subupdate substate subevent
  = { delegate ∷ Application eff subupdate substate subevent
    , focus
        ∷ { update ∷ update   → Maybe subupdate
          , state  ∷ state    → substate
          , event  ∷ subevent → Maybe event
          }
    }

-- | In practice, we don't really care what the types are within a
-- | sub-application, as long as we have an appropriate mapping to and from the
-- | parent types. So, we can existentialise these inner types.
foreign import data ComponentDelegateX
  ∷ # Effect → Type → Type → Type → Type

-- | Make an existential component delegate.
mkComponentDelegateX
  ∷ ∀ eff update state event subupdate substate subevent
  . ComponentDelegate eff update state event subupdate substate subevent
  → ComponentDelegateX eff update state event
mkComponentDelegateX
  = unsafeCoerce

-- | Retrieve a component delegate from an existentialised delegate, using the
-- | functions within `focus` to wire up the two applications.
runComponentDelegateX
  ∷ ∀ eff update state event result
  . ( ∀ subupdate substate subevent
      . ComponentDelegate eff update state event subupdate substate subevent
      → result
    )
  → ComponentDelegateX eff update state event
  → result
runComponentDelegateX
  = unsafeCoerce

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
type Application eff update state event
  = { view         ∷ Component eff update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update       ∷ Updater eff update state event
    }

