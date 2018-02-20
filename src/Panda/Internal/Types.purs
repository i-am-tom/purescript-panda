module Panda.Internal.Types where

import Control.Monad.Eff (Eff)
import Data.Lazy (Lazy)
import Data.Maybe (Maybe)
import FRP.Event (Event) as FRP
import Util.Exists (Exists3)

import Prelude

-- | Convenience synonym (sorry @jusrin00!)
type Canceller eff = Eff eff Unit

-- | Sum type of all sensible event handlers that can be applied to elements.
data Producer
  = OnClick

-- | A static property is just key => value, and can't do anything clever.
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
      , renderer ∷ Lazy (Property update state event)
      }
  }

-- | A producer is a property that... well, produces events! These properties
-- are indexed by `Producer` values. @TODO: allow for different information
-- within different `Producer` constructors.
newtype PropertyProducer event
  = PropertyProducer
      { key   ∷ Producer
      , event ∷ event
      }

-- | A property is just one of the above things: a static property, a property
-- that depends on some events, or a property that produces events.
data Property update state event
  = PStatic    PropertyStatic
  | PWatcher  (PropertyWatcher  update state event)
  | PProducer (PropertyProducer              event)

---

-- | A static component is one that has properties and potentially houses other
-- components. These are the things you _actually_ render to the DOM, and get
-- converted to HTML elements. Note that the children of a static component can
-- absolutely be dynamic, and it can even have dynamic properties. All this
-- represents is an HTML element.
newtype ComponentStatic eff update state event
  = ComponentStatic
      { children   ∷ Array (Component eff update state event)
      , properties ∷ Array (Property      update state event)
      , tagName    ∷ String
      }

-- | A watcher component is one that varies according to the state and updates
-- in the application loop. Because a re-render is a destructive process, it is
-- recommended that the more common the watcher's interest, the lower in the
-- component tree it should occur. If an event is likely to be fired every
-- second and that will cause the re-rendering of the entire tree, performance
-- won't be great. Similarly to the `PropertyWatcher`, the `interest` flag is
-- an indication to the renderer: it may be ignored, as is the case in the
-- initial render.
newtype ComponentWatcher eff update state event
  = ComponentWatcher
      ( Maybe
          { update ∷ update
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
          ∷ { update ∷ update → Maybe subupdate
            , state  ∷ state → substate
            , event  ∷ subevent → event
            }
      }


-- | A component is either a "static" element, a watcher, a delegate, or a text
-- element. @TODO: add `CFragment`.
data Component eff update state event
  = CStatic            (ComponentStatic   eff update state event)
  | CWatcher           (ComponentWatcher  eff update state event)
  | CDelegate (Exists3 (ComponentDelegate eff update state event))
  | CText String


-- | A specification for a contained Panda application: it must have a view
-- (what are we going to display?), a subscription (what events are we going to
-- generate and/or be interested in?) and an update method (how are we going to
-- interpret those events into updates for the DOM?)
type Application eff update state event
  = { view         ∷ Component eff update state event
    , subscription ∷ FRP.Event event
    , update       ∷ Maybe { state ∷ state, event ∷ event }
                   → Eff eff { update ∷ update, state ∷ state }
    }

