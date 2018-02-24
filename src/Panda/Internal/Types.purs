module Panda.Internal.Types where

import Control.Alt               ((<|>))
import Control.Monad.Eff         (Eff)
import Control.Plus              (empty)
import DOM                       (DOM)
import FRP                       (FRP)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Monoid               (class Monoid, mempty)
import DOM.Event.Types           (Event) as DOM
import Data.Lazy                 (Lazy)
import Data.Maybe                (Maybe)
import FRP.Event                 (Event) as FRP
import Util.Exists               (Exists3)

import Prelude

-- | All the effects that occur as a result of Panda! We'll just use this for
-- the global signature until the effect row goes...
type FX eff
  = ( dom ∷ DOM
    , console ∷ CONSOLE
    , frp ∷ FRP
    | eff
    )

-- | A canceller cancels somem event handler.
type Canceller eff
  = Eff eff Unit

-- | Sum type of all sensible event handlers that can be applied to elements.
-- Full disclosure: I stole this list from Nate Faubion's purescript-spork
-- library.
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

---

-- | A static property is just key => value, and can't do anything clever. This
-- should be used whenever you want to use a property that won't be affectted
-- by state changes or events.
newtype PropertyStatic
  = PropertyStatic
      { key   ∷ String
      , value ∷ String
      }

-- | A watcher property can vary depending on the state and most recent update,
-- which allows properties to respond to events. `interest` is a flag that
-- allows a property to say whether it is going to do anything useful (and
-- whether it's worth calling the `renderer`), though this may be ignored (e.g.
-- during initial render).
newtype PropertyWatcher update state event
  = PropertyWatcher
      { key ∷ String
      , listener ∷
          { update ∷ update
          , state  ∷ state
          }
        → { interest ∷ Boolean
          , renderer ∷ Lazy (Maybe String)
          }
      }

-- | A producer is a property that... well, produces events! These properties
-- are indexed by `Producer` values. Using the producer helpers will do you a
-- lot of favours, as the event has already been coerced to the type
-- appropriate to that particular DOM action.
newtype PropertyProducer event
  = PropertyProducer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

-- | A property is just one of the above things: a static property, a property
-- that depends on some events, or a property that produces events.
data Property update state event
  = PStatic    PropertyStatic
  | PWatcher  (PropertyWatcher  update state event)
  | PProducer (PropertyProducer              event)

---

-- | A static component is one that has properties and potentially houses other
-- components. These are the things you _actually_ render to the DOM, and that
-- get converted to HTML elements. Note that the children of a static component
-- can absolutely be dynamic, and it can even have dynamic properties. All this
-- represents is an HTML element.
newtype ComponentStatic eff update state event
  = ComponentStatic
      { children   ∷ Array (Component eff update state event)
      , properties ∷ Array (Property      update state event)
      , tagName    ∷ String
      }

-- | A watcher component is one that varies according to the state and updates
-- in the application loop. Because a re-render is a destructive process, it is
-- recommended that, the more common the watcher's interest, the lower in the
-- component tree it should occur. If an event is likely to be fired every
-- second and that will cause the re-rendering of the entire tree, performance
-- won't be great. Similarly to the `PropertyWatcher`, the `interest` flag is
-- an indication to the renderer: it may be ignored, as is the case in the
-- initial render.
newtype ComponentWatcher eff update state event
  = ComponentWatcher
      ( { update ∷ update
        , state  ∷ state
        }
      → { interest ∷ Boolean
        , renderer ∷ Lazy (Component eff update state event)
        }
      )

-- Applications can be nested arbitrarily, with the proviso that there is some
-- way to translate from "parent" to "child". The actual types of the child are
-- existential, and are thus not carried up the tree: "as long as you can tell
-- me how to convert updates and states for the child, and then 'unconvert'
-- events from the child, I can embed this application".
newtype ComponentDelegate eff update state event subupdate substate subevent
  = ComponentDelegate
      { delegate ∷ Application eff subupdate substate subevent
      , focus
          ∷ { update ∷ update   → Maybe subupdate
            , state  ∷ state    → substate
            , event  ∷ subevent → event
            }
      }


-- | A component is either a "static" element, a watcher, a delegate, or text.
data Component eff update state event
  = CStatic            (ComponentStatic   eff update state event)
  | CWatcher           (ComponentWatcher  eff update state event)
  | CDelegate (Exists3 (ComponentDelegate eff update state event))
  | CText String

---

newtype EventSystem eff update state event
  = EventSystem
      { cancel       ∷ Canceller eff
      , events       ∷ FRP.Event event
      , handleUpdate ∷ update → Canceller eff
      }

instance semigroupEventSystem ∷ Semigroup (EventSystem f u s e) where
  append (EventSystem this) (EventSystem that)
    = EventSystem
        { events: this.events <|> that.events
        , cancel: this.cancel *> that.cancel
        , handleUpdate: this.handleUpdate <> that.handleUpdate
        }

instance monoidEventSystem ∷ Monoid (EventSystem f u s e) where
  mempty
    = EventSystem
        { events: empty
        , cancel: mempty
        , handleUpdate: mempty
        }

-- | A specification for a contained Panda application: it must have a view
-- (what are we going to display?), a subscription (what events are we going to
-- generate and/or be interested in?) and an update method (how are we going to
-- interpret those **events** into **updates** for the DOM?) The `update` type
-- is quite noisy, but it boils down to a function that can dispatch _updates_,
-- and a primary event.
type Application eff update state event
  = { view         ∷ Component eff update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update       ∷ ((state → { update ∷ update, state ∷ state }) → Eff eff Unit)
                   → { event ∷ event, state ∷ state }
                   → Eff eff Unit
    }

