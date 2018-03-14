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

import Prelude

data ShouldUpdate a
  = Rerender a
  | Ignore

data ArrayUpdate value
  = ArrayDeleteAt Int
  | ArrayEmpty
  | ArrayInsertAt Int value
  | ArrayPop
  | ArrayPush value
  | ArrayShift
  | ArrayUnshift value

newtype ComponentUpdate eff update state event
  = ComponentUpdate (ArrayUpdate (Component eff update state event))

data MapUpdate value
  = MapInsert String value
  | MapDelete String

newtype PropertyUpdate
  = PropertyUpdate (MapUpdate String)

type FX eff
  = ( dom ∷ DOM
    , frp ∷ FRP
    , ref ∷ REF
    | eff
    )

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

newtype PropertyStatic
  = PropertyStatic
      { key   ∷ String
      , value ∷ String
      }

newtype PropertyWatcher update state
  = PropertyWatcher
      ( { update ∷ update, state ∷ state }
      → ShouldUpdate (Array PropertyUpdate)
      )

newtype PropertyProducer event
  = PropertyProducer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

data Property update state event
  = PStatic    PropertyStatic
  | PWatcher  (PropertyWatcher  update state)
  | PProducer (PropertyProducer              event)

data Children eff update state event
  = StaticChildren
      ( Array (Component eff update state event)
      )

  | DynamicChildren
      ( { update ∷ update
        , state  ∷ state
        }
      → ShouldUpdate (Array (ComponentUpdate eff update state event))
      )

newtype ComponentElement eff update state event
  = ComponentElement
      { children   ∷ Children eff update state event
      , properties ∷ Array (Property update state event)
      , tagName    ∷ String
      }

newtype ComponentDelegate eff update state event subupdate substate subevent
  = ComponentDelegate
      { delegate ∷ Application eff subupdate substate subevent
      , focus
          ∷ { update ∷ update   → Maybe subupdate
            , state  ∷ state    → substate
            , event  ∷ subevent → event
            }
      }

foreign import data ComponentDelegateX
  ∷ # Effect → Type → Type → Type → Type

mkComponentDelegateX
  ∷ ∀ eff update state event subupdate substate subevent
  . ComponentDelegate eff update state event subupdate substate subevent
  → ComponentDelegateX eff update state event
mkComponentDelegateX
  = unsafeCoerce

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

data Component eff update state event
  = CElement  (ComponentElement   eff update state event)
  | CDelegate (ComponentDelegateX eff update state event)
  | CText String

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

type Application eff update state event
  = { view         ∷ Component eff update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update       ∷ ((state → { update ∷ update, state ∷ state }) → Eff eff Unit)
                   → { event ∷ event, state ∷ state }
                   → Eff eff Unit
    }

