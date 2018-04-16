module Panda.Internal.Property where

import Data.Identity              (Identity(..))
import Control.Monad.Eff.Ref      as Ref
import Control.Plus               (empty)
import DOM.Event.EventTarget      (addEventListener, eventListener, removeEventListener) as DOM
import DOM.Event.Types            (Event, EventType) as DOM
import DOM.HTML.Event.EventTypes  as DOM.Events
import DOM.Node.Element           (removeAttribute, setAttribute) as DOM
import DOM.Node.Types (elementToEventTarget) as DOM
import Data.Foldable              (traverse_)
import Data.Generic.Rep           (class Generic)
import Data.Generic.Rep.Show      (genericShow)
import Data.Maybe                 (Maybe(..))
import Data.String                (drop, toLower)
import FRP.Event                  (create) as FRP
import Panda.Internal.Common      (class Property)
import Panda.Internal.EventSystem (EventSystem(..))

import Panda.Prelude

-- | All possible "event producers" within the application. These are used as
-- | keys for producer properties.

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

-- | The producers can be converted into `EventType`, allowing for use in event
-- | listeners.

producerToEventType ∷ Producer → DOM.EventType
producerToEventType = case _ of
  OnBlur          → DOM.Events.blur
  OnChange        → DOM.Events.change
  OnClick         → DOM.Events.click
  OnDoubleClick   → DOM.Events.dblclick
  OnDrag          → DOM.Events.drag
  OnDragEnd       → DOM.Events.dragend
  OnDragEnter     → DOM.Events.dragenter
  OnDragLeave     → DOM.Events.dragleave
  OnDragOver      → DOM.Events.dragover
  OnDragStart     → DOM.Events.dragstart
  OnDrop          → DOM.Events.drop
  OnError         → DOM.Events.error
  OnFocus         → DOM.Events.focus
  OnInput         → DOM.Events.input
  OnKeyDown       → DOM.Events.keydown
  OnKeyPress      → DOM.Events.keypress
  OnKeyUp         → DOM.Events.keyup
  OnMouseDown     → DOM.Events.mousedown
  OnMouseEnter    → DOM.Events.mouseenter
  OnMouseLeave    → DOM.Events.mouseleave
  OnMouseMove     → DOM.Events.mousemove
  OnMouseOut      → DOM.Events.mouseout
  OnMouseOver     → DOM.Events.mouseover
  OnMouseUp       → DOM.Events.mouseup
  OnScroll        → DOM.Events.scroll
  OnSubmit        → DOM.Events.submit
  OnTransitionEnd → DOM.Events.transitionend

derive instance eqProducer      ∷ Eq Producer
derive instance genericProducer ∷ Generic Producer _
derive instance ordProducer     ∷ Ord Producer

instance showProducer ∷ Show Producer where
  show = genericShow

-- | Convert a producer to the string passed to `addEventListener` and
-- | `removeEventListener`.

producerToString ∷ Producer → String
producerToString
  = toLower ∘ drop 2 ∘ show

-- | Should a property update? Unlike components, property updates aren't
-- | incremental, simply because they're really cheap (you'll never have an
-- | infinite list of components, for example). This "algebra" defines
-- | everything we can therefore do: add, delete, or nothing.

data ShouldUpdate a
  = Clear
  | Ignore
  | SetTo a

-- | A property is a key/value pair with respect to some `Type → Type`
-- | constructor.

newtype Property f key value
  = Property { key ∷ key, value ∷ f value }

-- | The `Type → Type` constructor for properties watching for updates is
-- | `Watching update state`, which really just wraps everything in a
-- | `ShouldUpdate`-yielding function.

newtype Watching update state a
  = Watching ({ update ∷ update, state ∷ state } → ShouldUpdate a)

-- | A static fixed property neither produces events, nor listens for updates.

instance staticFixedProperty
    ∷ Property (Property Identity String String) u s e where

  renderProperty element (Property { key, value: Identity value })
    = effToEffect $ DOM.setAttribute key value element $> Nothing

-- | A static producer property doesn't listen for updates, but does produce
-- | events according to some event handler.

instance staticProducerProperty
    ∷ Property (Property Identity Producer (DOM.Event → Maybe e)) u s e where

  renderProperty element (Property { key, value: Identity value }) = do
    { push: propagateEvent, event: producerEvents } ← effToEffect FRP.create

    let
      eventTarget
        = DOM.elementToEventTarget element

      eventType
        = producerToEventType key

      handleEvent
        = DOM.eventListener
        $ traverse_ propagateEvent
        ∘ value

    effToEffect $ DOM.addEventListener eventType handleEvent false eventTarget

    pure ∘ Just $ EventSystem
      { cancel: pure unit
      , events: producerEvents
      , handleUpdate: \_ → pure unit
      }

-- | A dynamic "fixed" property is one that doesn't produce events, but _can_
-- | be affected by environment.

instance dynamicFixedProperty
    ∷ Property (Property (Watching u s) String String) u s e where

  renderProperty element (Property { key, value: Watching watcher })
    = effToEffect ∘ pure ∘ Just $ EventSystem
        { cancel: effToEffect (DOM.removeAttribute key element)
        , events: empty
        , handleUpdate: \update →
            effToEffect case watcher update of
              Ignore →
                pure unit

              SetTo value →
                DOM.setAttribute key value element

              Clear →
                DOM.removeAttribute key element
        }

-- | Dynamic properties are identical to static properties, except the value is
-- | wrapped in a function from state and update. In other words, values of
-- | dynamic properties can be determined by their environment.

instance dynamicProducerProperty
    ∷ Property (Property (Watching u s) Producer (DOM.Event → Maybe e)) u s e where

  renderProperty element (Property { key, value: Watching watcher }) = do
    { push: propagateEvent, event: producedEvents } ← effToEffect FRP.create
    currentHandler ← effToEffect $ Ref.newRef (DOM.eventListener \_ → pure unit)

    let
      eventTarget
        = DOM.elementToEventTarget element

      eventType
        = producerToEventType key

      cancelEventListener = effToEffect do
        handler ← Ref.readRef currentHandler
        DOM.removeEventListener eventType handler false eventTarget

    pure $ Just $ EventSystem
      { cancel: cancelEventListener
      , events: producedEvents
      , handleUpdate: \update →
          case (watcher update) of
            Ignore →
              pure unit

            Clear →
              cancelEventListener

            SetTo replacement → do
              cancelEventListener

              let
                handler
                  = DOM.eventListener
                  $ replacement >>> traverse_ propagateEvent

              effToEffect
                $ DOM.addEventListener (producerToEventType key) handler
                    false (DOM.elementToEventTarget element)
      }
