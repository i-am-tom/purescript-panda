module Panda.Internal.Component where

import Data.Maybe                 (Maybe)
import Data.Algebra.Array         as Algebra.Array
import Panda.Internal.Application (Application)
import Panda.Internal.Property    (Property)

-- | Components are the units with which we build up a view.
data Component eff update state event

  -- | A `Collection` is a set of elements than can be affected incrementally
  -- | by using an array algebra.
  = ComponentCollection
      { tagName ∷ String
      , properties ∷ Array (Property update state event)
      , handler
          ∷ { state ∷ state, update ∷ update }
          → Array (ComponentUpdate eff update state event)
      }

  -- | A delegate allows one application to be embedded within another and thus
  -- | encapsulate an event loop.
  | ComponentDelegate (ComponentDelegateX eff update state event)

  -- | A regular element is exactly analogous to an HTML element.
  | ComponentElement
      { tagName    ∷ String
      , properties ∷ Array (Property update state event)
      , children   ∷ Array (Component eff update state event)
      }

  -- | Plain text.
  | ComponentText String

-- | The update algebra for Panda components.
type ComponentUpdate eff update state event
  = Algebra.Array.Update (Component eff update state event)

-- | Component delegates allow us to reuse applications within larger
-- | applications, provided that we can wire up the two event systems.
type ComponentDelegate eff update state event update' state' event'
  = { delegate ∷ Application Component eff update' state' event'
    , focus
        ∷ { update ∷ update → Maybe update'
          , state  ∷ state  → state'
          , event  ∷ event' → Maybe event
          }
    }

-- | An existentialised component delegate is the same as a component delegate,
-- | but we stop caring about the subupdate/substate/subevent at the
-- | type-level. This is fine to do, as `focus` still gives us a way to get to
-- | and from the subtypes.
newtype ComponentDelegateX eff update state event
  = ComponentDelegateX
      ( ∀ result
      . ( ∀ update' state' event'
        . ComponentDelegate eff
            update  state  event
            update' state' event'
        → result
        )
      → result
      )

-- | Existentialise an application delegate for embedding within a component.
mkApplicationDelegateX
  ∷ ∀ eff update state event update' state' event'
  . ComponentDelegate eff update state event update' state' event'
  → ComponentDelegateX eff update state event
mkApplicationDelegateX delegate
  = ComponentDelegateX \f → f delegate

-- | Retrieve an application delegate from an existentialised delegate, using
-- | the functions within `focus` to wire up the two applications.
runComponentDelegateX
  ∷ ∀ eff update state event result
  . ( ∀ update' state' event'
      . ComponentDelegate eff
          update  state  event
          update' state' event'
      → result
    )
  → ComponentDelegateX eff update state event
  → result

runComponentDelegateX run (ComponentDelegateX delegateX)
  = delegateX run
