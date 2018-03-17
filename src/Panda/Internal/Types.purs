module Panda.Internal.Types where

import Control.Alt           ((<|>))
import Control.Monad.Eff     (Eff, kind Effect)
import Control.Monad.Eff.Ref (REF)
import Control.Plus          (empty)
import DOM                   (DOM)
import DOM.Event.Types       (Event) as DOM
import Data.Maybe            (Maybe)
import Data.Monoid           (class Monoid, mempty)
import FRP                   (FRP)
import FRP.Event             (Event) as FRP
import Unsafe.Coerce         (unsafeCoerce)

import Prelude ((<>), (*>), class Semigroup, Unit)

-- | An algebra for array updates. We use this to describe the ways in which we
-- | would like to update the DOM.
data ArrayUpdate value
  = ArrayDeleteAt Int
  | ArrayEmpty
  | ArrayInsertAt Int value
  | ArrayPop
  | ArrayPush value
  | ArrayShift
  | ArrayUnshift value

-- | Components are updated using the array algebra, but specialised to
-- | component values.
newtype ComponentUpdate eff update state event
  = ComponentUpdate (ArrayUpdate (Component eff update state event))

-- | An algebra for map updates.
data MapUpdate value
  = MapInsert String value
  | MapDelete String

-- | Properties are updated using the map algebra specialised to strings.
newtype PropertyUpdate
  = PropertyUpdate (MapUpdate String)

-- | The effects that are used within Panda.
type FX eff
  = ( dom ∷ DOM
    , frp ∷ FRP
    , ref ∷ REF
    | eff
    )

-- | All the possible event producers.
data Producer
  = OnAbort
  | OnBlur
  | OnChange
  | OnContextMenu
  | OnClick
  | OnDoubleClick
  | OnDrag
  | OnDragEnd
  | OnDragEnter
  | OnDragExit
  | OnDragLeave
  | OnDragOver
  | OnDragStart
  | OnDrop
  | OnError
  | OnFocus
  | OnFocusIn
  | OnFocusOut
  | OnInput
  | OnInvalid
  | OnKeyDown
  | OnKeyPress
  | OnKeyUp
  | OnLoad
  | OnMouseDown
  | OnMouseEnter
  | OnMouseLeave
  | OnMouseMove
  | OnMouseOver
  | OnMouseOut
  | OnMouseUp
  | OnReset
  | OnScroll
  | OnSelect
  | OnSubmit
  | OnTransitionEnd

-- | Properties are either static key/value pairs, listeners for DOM updates
-- | (that can then change the properties on an element), or producers of
-- | events (that then bubble up to the `update` function).
data Property update state event

  = PropertyStatic
      { key   ∷ String
      , value ∷ String
      }

  | PropertyWatcher
      ( { update ∷ update
        , state ∷ state
        }
      → (Array PropertyUpdate)
      )

  | PropertyProducer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

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
      , properties ∷ Array (Property update state event)
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

-- | An event system defines the update/event mechanism for a particular
-- | component. When we update the DOM, we must remember to cancel outgoing
-- | elements, and register new update handlers.
newtype EventSystem eff update state event
  = EventSystem
      { cancel       ∷ Eff eff Unit
      , events       ∷ FRP.Event event
      , handleUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff eff Unit
      }

instance semigroupEventSystem
    ∷ Semigroup (EventSystem eff update state event) where
  append (EventSystem this) (EventSystem that)
    = EventSystem
        { events: this.events <|> that.events
        , cancel: this.cancel *> that.cancel
        , handleUpdate: this.handleUpdate <> that.handleUpdate
        }

instance monoidEventSystem
    ∷ Monoid (EventSystem eff update state event) where
  mempty
    = EventSystem
        { events: empty
        , cancel: mempty
        , handleUpdate: mempty
        }

-- | Convenience synonym for defining the type of updaters within a Panda
-- | application.
type Updater eff update state event
  = ((state → { update ∷ update, state ∷ state }) → Eff eff Unit)
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

