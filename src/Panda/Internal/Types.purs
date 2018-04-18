module Panda.Internal.Types where

import Control.Alternative   ((<|>))
import DOM.Event.Types       (Event) as DOM
import Data.Algebra.Array    as Algebra.Array
import Data.Generic.Rep      (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Effect                (Effect)
import FRP.Event             (Event) as FRP
import Unsafe.Coerce         (unsafeCoerce)

import Panda.Prelude

-- | A Panda application looks very similar to an Elm application: you provide
-- | a `view`, a `subscription` to any external events, an `initial` state and
-- | update, and an `update` function for dispatching updates. The signature
-- | looks a little ugly, but it's essentially a `dispatch` function and
-- | whatever event originally triggered the `update` call, along with the
-- | state at that moment in time. `dispatch` takes a callback that will
-- | receive the state at _that_ current moment in time. Why? For operations
-- | involving AJAX, for example, this allows us to be more intelligent about
-- | incremental updates because we can see how state has changed since we
-- | began.

type Application update state event
  = { view         ∷ Component update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update
        ∷ ((state → { update ∷ update, state ∷ state }) → Effect Unit)
          → { event ∷ event, state ∷ state }
          → Effect Unit
    }

-- | Updates to a collection are done via this incremental algebra, which
-- | reifies all the regular mutating array operations.

type ComponentUpdate update state event
  = Algebra.Array.Update (Component update state event)

-- | A component in the Panda DSL, which is either text, a static element (with
-- | more components as children), or an incrementally-updated collection of
-- | components.

data Component update state event

  = Element
      { tagName    ∷ String
      , properties ∷ Array (Property update state event)
      , children   ∷ Array (Component update state event)
      }

  | Collection
      { tagName    ∷ String
      , properties ∷ Array (Property update state event)
      , watcher
          ∷ { update ∷ update, state ∷ state }
          → Array (ComponentUpdate update state event)
      }

  | Text String

  | Delegate (ComponentDelegateX update state event)

newtype ComponentDelegate update state event subupdate substate subevent
  = ComponentDelegate
      { focus
          ∷ { state  ∷ state    → substate
            , update ∷ update   → Maybe subupdate
            , event  ∷ subevent → Maybe event
            }

      , application ∷ Application subupdate substate subevent
      }

foreign import data ComponentDelegateX ∷ Type → Type → Type → Type

-- | Existentialise a component delelgate.

mkComponentDelegateX
  ∷ ∀ update state event subupdate substate subevent
  . ComponentDelegate update state event subupdate substate subevent
  → ComponentDelegateX update state event

mkComponentDelegateX
  = unsafeCoerce

-- | Unpack an existential component delegate.

runComponentDelegateX
  ∷ ∀ update state event result
  . ( ∀ subupdate substate subevent
    . ComponentDelegate update state event subupdate substate subevent
    → result
    )
  → ComponentDelegateX update state event
  → result

runComponentDelegateX f
  = f ∘ unsafeCoerce

-- | A property is either a fixed key/value pair, an event type and
-- | corresponding handler, or a dynamic producer of properties.

data Property update state event

  = Fixed
      { key   ∷ String
      , value ∷ String
      }

  | Producer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

  | Dynamic
      ( { update ∷ update, state ∷ state }
      → ShouldUpdate (Property update state event)
      )

-- | Whenever we call our dynamic property watcher, the watcher can choose
-- | whether it cares about the current environment, whether it wants to add a
-- | new property, or delete all those that it has touched.

data ShouldUpdate a
  = Clear
  | Ignore
  | SetTo a

-- | A sum of all the event hooks that can be used within Panda.

data Producer
  = OnBlur
  | OnChange
  | OnClick
  | OnDoubleClick
  | OnDrag
  | OnDragEnd
  | OnDragEnter
  | OnDragLeave
  | OnDragOver
  | OnDragStart
  | OnDrop
  | OnError
  | OnFocus
  | OnInput
  | OnKeyDown
  | OnKeyPress
  | OnKeyUp
  | OnMouseDown
  | OnMouseEnter
  | OnMouseLeave
  | OnMouseMove
  | OnMouseOver
  | OnMouseOut
  | OnMouseUp
  | OnScroll
  | OnSubmit
  | OnTransitionEnd

derive instance eqProducer      ∷ Eq Producer
derive instance genericProducer ∷ Generic Producer _
derive instance ordProducer     ∷ Ord Producer

instance showProducer ∷ Show Producer where
  show = genericShow

-- | An event system defines the ways in which an element can interact with its
-- | environment.

newtype EventSystem update state event
  = EventSystem
      { cancel ∷ Effect Unit
      , events ∷ FRP.Event event
      , handleUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Effect Unit
      }

-- | TODO: Monoid instance for Effect.

instance semigroupEventSystem
    ∷ Semigroup (EventSystem update state event) where
  append (EventSystem this) (EventSystem that)
    = EventSystem
        { events: this.events <|> that.events
        , cancel: this.cancel *> that.cancel
        , handleUpdate: this.handleUpdate *> that.handleUpdate
        }
