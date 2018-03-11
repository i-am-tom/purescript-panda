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

-- | Should we update at all? Or is the DOM fine as it is?
data ShouldUpdate a
  = Rerender a
  | Ignore

-- | Array updates as an algebra.
data ArrayUpdate value
  = ArrayInsertAt Int value
  | ArrayDeleteAt Int

-- | The only type we're interested in is `Component`!
newtype ComponentUpdate eff update state event
  = ComponentUpdate (ArrayUpdate (Component eff update state event))

-- | Object updates as an algebra.
data ObjectUpdate key value
  = ObjectInsert key value
  | ObjectDelete key

-- | Property updates are object updates specialised to strings.
newtype PropertyUpdate
  = PropertyUpdate (ObjectUpdate String String)

-- | All the effects that occur as a result of Panda! We'll just use this for
-- | the global signature until the effect row goes...
type FX eff
  = ( dom ∷ DOM
    , frp ∷ FRP
    , ref ∷ REF
    | eff
    )

-- | Sum type of all sensible event handlers that can be applied to elements.
-- | Full disclosure: I stole this list from Nate Faubion's wonderful
-- | [purescript-spork](https://pursuit.purescript.org/packages/purescript-spork/)
-- | library.
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

-- | A static property is just key => value, and can't do anything clever. This
-- | should be used whenever you want to use a property that won't be affectted
-- | by state changes or events.
newtype PropertyStatic
  = PropertyStatic
      { key   ∷ String
      , value ∷ String
      }

-- | A `Watcher` property can vary depending on the state and most recent
-- | update, which allows properties to respond to events. Given an update, a
-- | `Watcher` can `Maybe` decide to update the value. This update is either
-- | `Just` the string to which the property should be set, or that it should
-- | be set to `Nothing` (hence the double-`Maybe`).
newtype PropertyWatcher update state
  = PropertyWatcher
      ( { update ∷ update, state ∷ state }
      → ShouldUpdate (Array PropertyUpdate)
      )

-- | A producer is a property that... well, produces events! These properties
-- | are indexed by `Producer` values. Using the producer helpers will do you a
-- | lot of favours, as the event has already been coerced to the type
-- | appropriate to that particular DOM action. A particular DOM event can be
-- | ignored if `onEvent` returns a `Nothing`.
newtype PropertyProducer event
  = PropertyProducer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

-- | A property is just one of the above things: a static property, a property
-- | that depends on some events, or a property that produces events.
data Property update state event
  = PStatic    PropertyStatic
  | PWatcher  (PropertyWatcher  update state)
  | PProducer (PropertyProducer              event)

-- | A static component is one that has properties and potentially houses other
-- | components. These are the things you _actually_ render to the DOM, and
-- | that get converted to HTML elements. Note that the children of a static
-- | component can absolutely be dynamic, and it can even have dynamic
-- | properties. All this represents is an HTML element.
newtype ComponentStatic eff update state event
  = ComponentStatic
      { children   ∷ Array (Component eff update state event)
      , properties ∷ Array (Property      update state event)
      , tagName    ∷ String
      }

-- | A watcher component is one that varies according to the state and updates
-- | in the application loop. Because a re-render is a destructive process, it
-- | is recommended that, the more common the watcher's interest, the lower in
-- | the component tree it should occur. If an event is likely to be fired
-- | every second and that will cause the re-rendering of the entire tree,
-- | performance won't be great.
newtype ComponentWatcher eff update state event
  = ComponentWatcher
      ( { update ∷ update
        , state  ∷ state
        }
      → ShouldUpdate (Array (ComponentUpdate eff update state event))
      )

-- | Applications can be nested arbitrarily, with the proviso that there is
-- | some way to translate from "parent" to "child". The actual types of the
-- | child are existential, and are thus not carried up the tree: "as long as
-- | you can tell me how to convert updates and states for the child, and then
-- | 'unconvert' events from the child, I can embed this application".
newtype ComponentDelegate eff update state event subupdate substate subevent
  = ComponentDelegate
      { delegate ∷ Application eff subupdate substate subevent
      , focus
          ∷ { update ∷ update   → Maybe subupdate
            , state  ∷ state    → substate
            , event  ∷ subevent → event
            }
      }

-- | A component delegate with the "subtypes" existentialised. This means we
-- | don't have to worry about carrying it up the tree.
foreign import data ComponentDelegateX
  ∷ # Effect → Type → Type → Type → Type

-- | Existentialise the "subtypes" in a component delegate.
mkComponentDelegateX
  ∷ ∀ eff update state event subupdate substate subevent
  . ComponentDelegate eff update state event subupdate substate subevent
  → ComponentDelegateX eff update state event
mkComponentDelegateX
  = unsafeCoerce

-- | Un-existentialise a delegate, and deal with the "subtypes".
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

-- | A component is either a "static" element, a watcher, a delegate, or text.
data Component eff update state event
  = CStatic   (ComponentStatic    eff update state event)
  | CWatcher  (ComponentWatcher   eff update state event)
  | CDelegate (ComponentDelegateX eff update state event)
  | CText String

-- | When `Component` or `Property` structures are rendered, an element is
-- | created, along with a system for handling events. This structure houses
-- | that system as a monoid, so that they can be combined more easily.
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

-- | To create a Panda application, you must specify a view, a controller, and
-- | an initial state (as well as the initial update that will fire on render).
-- | `subscription` allows you to subscribe to external events (but can be
-- | ignored using `Control.Plus.empty`. `update` takes a `dispatch` function
-- | forupdates, and the event that triggered it in the first place. Note the
-- | `dispatch` function takes a _function_ from state - this function
-- | guarantees that your modifications will be applied to the most recent
-- | state. This is helpful when your `update` function gets asynchronous.
type Application eff update state event
  = { view         ∷ Component eff update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update       ∷ ((state → { update ∷ update, state ∷ state }) → Eff eff Unit)
                   → { event ∷ event, state ∷ state }
                   → Eff eff Unit
    }

