module Panda.Render.Property where

import Control.Monad.Eff          (Eff)
import Control.Plus               (empty)
import Control.Monad.Eff.Ref      as Ref
import DOM (DOM)
import DOM.Event.EventTarget      (addEventListener, eventListener, removeEventListener) as DOM
import DOM.Event.Types            (Event, EventType) as DOM
import DOM.HTML.Event.EventTypes  as DOM.Events
import DOM.Node.Element           (removeAttribute, setAttribute) as DOM
import DOM.Node.Types             (Element, elementToEventTarget) as DOM
import Data.String                (drop, toLower)
import Effect                     (Effect)
import FRP.Event                  (create) as FRP
import Panda.Internal.Types       as Types

import Panda.Prelude

-- | The producers can be converted into `EventType`, allowing for use in event
-- | listeners.

producerToEventType ∷ Types.Producer → DOM.EventType
producerToEventType = case _ of
  Types.OnBlur          → DOM.Events.blur
  Types.OnChange        → DOM.Events.change
  Types.OnClick         → DOM.Events.click
  Types.OnDoubleClick   → DOM.Events.dblclick
  Types.OnDrag          → DOM.Events.drag
  Types.OnDragEnd       → DOM.Events.dragend
  Types.OnDragEnter     → DOM.Events.dragenter
  Types.OnDragLeave     → DOM.Events.dragleave
  Types.OnDragOver      → DOM.Events.dragover
  Types.OnDragStart     → DOM.Events.dragstart
  Types.OnDrop          → DOM.Events.drop
  Types.OnError         → DOM.Events.error
  Types.OnFocus         → DOM.Events.focus
  Types.OnInput         → DOM.Events.input
  Types.OnKeyDown       → DOM.Events.keydown
  Types.OnKeyPress      → DOM.Events.keypress
  Types.OnKeyUp         → DOM.Events.keyup
  Types.OnMouseDown     → DOM.Events.mousedown
  Types.OnMouseEnter    → DOM.Events.mouseenter
  Types.OnMouseLeave    → DOM.Events.mouseleave
  Types.OnMouseMove     → DOM.Events.mousemove
  Types.OnMouseOut      → DOM.Events.mouseout
  Types.OnMouseOver     → DOM.Events.mouseover
  Types.OnMouseUp       → DOM.Events.mouseup
  Types.OnScroll        → DOM.Events.scroll
  Types.OnSubmit        → DOM.Events.submit
  Types.OnTransitionEnd → DOM.Events.transitionend

-- | Convert a producer to the string passed to `addEventListener` and
-- | `removeEventListener`.

producerToString ∷ Types.Producer → String
producerToString
  = toLower ∘ drop 2 ∘ show

-- | Effectfully add an event listener to a DOM node.

addEventListener
  ∷ ∀ eff
  . Types.Producer
  → DOM.Element
  → (DOM.Event → Eff (dom ∷ DOM | eff) Unit)
  → Effect Unit

addEventListener producer element listener
  = effToEffect $ DOM.addEventListener eType eListener false eTarget
  where
    eType     = producerToEventType producer
    eListener = DOM.eventListener listener
    eTarget   = DOM.elementToEventTarget element

-- | Effectfully remove an event listener from a DOM node.

removeEventListener
  ∷ ∀ eff
  . Types.Producer
  → DOM.Element
  → (DOM.Event → Eff (dom ∷ DOM | eff) Unit)
  → Effect Unit

removeEventListener producer element listener
  = effToEffect $ DOM.removeEventListener eType eListener false eTarget
  where
    eType     = producerToEventType producer
    eListener = DOM.eventListener listener
    eTarget   = DOM.elementToEventTarget element

-- | Render a fixed static property to an element.

renderStaticFixed
  ∷ ∀ update state event
  . DOM.Element
  → String
  → String
  → Effect (Maybe (Types.EventSystem update state event))
renderStaticFixed element key value = do
  effToEffect (DOM.setAttribute key value element)

  pure ∘ Just $ Types.EventSystem
    { cancel: effToEffect (DOM.removeAttribute key element)
    , events: empty
    , handleUpdate: \_ → pure unit
    }

-- | Render a fixed event-producing property from an element.

renderStaticProducer
  ∷ ∀ update state event
  . DOM.Element
  → Types.Producer
  → (DOM.Event → Maybe event)
  → Effect (Maybe (Types.EventSystem update state event))

renderStaticProducer element key onEvent = do
  { push, event } ← effToEffect FRP.create

  let handler = traverse_ push ∘ onEvent
  addEventListener key element handler

  pure ∘ Just $ Types.EventSystem
    { cancel: removeEventListener key element handler
    , events: event
    , handleUpdate: \_ → pure unit
    }

-- | Render a dynamic property that both produces events and listens for
-- | environmental changes.

renderDynamic
  ∷ ∀ update state event
  . DOM.Element
  → ( { update ∷ update, state ∷ state }
    → Types.ShouldUpdate (Types.Property update state event)
    )
  → Effect (Maybe (Types.EventSystem update state event))

renderDynamic element watcher = do
  { event: producerEvents, push: registerProducerEvent }
    ← effToEffect FRP.create

  propertyRef ← effToEffect $ Ref.newRef Nothing

  pure ∘ Just $ Types.EventSystem
    { cancel: do
        current ← effToEffect (Ref.readRef propertyRef)

        for_ current \(Types.EventSystem { cancel }) →
          cancel

    , events: producerEvents
    , handleUpdate: \update → do
        let
          clearListener
              = effToEffect (Ref.readRef propertyRef)
            >>= traverse_ \(Types.EventSystem { cancel }) →
                  cancel

        case watcher update of
          Types.Ignore →
            pure unit

          Types.Clear →
            clearListener

          Types.SetTo nextProperty → do
            clearListener

            property ← render element nextProperty
            effToEffect (Ref.writeRef propertyRef property)
    }

render
  ∷ ∀ update state event
  . DOM.Element
  → Types.Property update state event
  → Effect (Maybe (Types.EventSystem update state event))

render element = case _ of
  Types.Fixed { key, value } →
    renderStaticFixed element key value

  Types.Producer { key, onEvent } →
    renderStaticProducer element key onEvent

  Types.Dynamic watcher →
    renderDynamic element watcher
