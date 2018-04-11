module Panda.Render.Property
  ( render
  ) where

import Control.Monad.Eff         (Eff)
import Control.Monad.Eff.Ref     as Ref
import Control.Plus              (empty)
import DOM.Event.EventTarget     (addEventListener, eventListener, removeEventListener, EventListener) as DOM
import DOM.Event.Types           (Event, EventType) as DOM
import DOM.HTML.Event.EventTypes as DOM.Events
import DOM.Node.Element          (removeAttribute, setAttribute) as DOM
import DOM.Node.Types            (Element, elementToEventTarget) as DOM
import Data.Foldable             (traverse_)
import Data.Identity             (Identity(..))
import Data.Maybe                (Maybe(..))
import Data.Monoid               (mempty)
import FRP.Event                 (Event, create) as FRP
import Panda.Internal            as I

import Prelude

-- | Convert a Producer into a regular DOM event. This is used to produce an
-- | EventTarget.

producerToEventType ∷ I.Producer → DOM.EventType
producerToEventType
  = case _ of
      I.OnBlur          → DOM.Events.blur
      I.OnChange        → DOM.Events.change
      I.OnClick         → DOM.Events.click
      I.OnDoubleClick   → DOM.Events.dblclick
      I.OnDrag          → DOM.Events.drag
      I.OnDragEnd       → DOM.Events.dragend
      I.OnDragEnter     → DOM.Events.dragenter
      I.OnDragLeave     → DOM.Events.dragleave
      I.OnDragOver      → DOM.Events.dragover
      I.OnDragStart     → DOM.Events.dragstart
      I.OnDrop          → DOM.Events.drop
      I.OnError         → DOM.Events.error
      I.OnFocus         → DOM.Events.focus
      I.OnInput         → DOM.Events.input
      I.OnKeyDown       → DOM.Events.keydown
      I.OnKeyPress      → DOM.Events.keypress
      I.OnKeyUp         → DOM.Events.keyup
      I.OnMouseDown     → DOM.Events.mousedown
      I.OnMouseEnter    → DOM.Events.mouseenter
      I.OnMouseLeave    → DOM.Events.mouseleave
      I.OnMouseMove     → DOM.Events.mousemove
      I.OnMouseOver     → DOM.Events.mouseover
      I.OnMouseOut      → DOM.Events.mouseout
      I.OnMouseUp       → DOM.Events.mouseup
      I.OnScroll        → DOM.Events.scroll
      I.OnSubmit        → DOM.Events.submit
      I.OnTransitionEnd → DOM.Events.transitionend

-- | Add an event listener to a DOM element. The return result is an `Event`
-- | that can be watched for events firing from this node, as well as the `key`
-- | string that was used to register the event.

attach
  ∷ ∀ eff event
  . { key     ∷ I.Producer
    , onEvent ∷ DOM.Event → event
    }
  → DOM.Element
  → Eff (I.FX eff)
      { listener ∷ DOM.EventListener (I.FX eff)
      , events   ∷ FRP.Event event
      }

attach { key, onEvent } element = do
  { push, event: events } ← FRP.create

  let
    eventTarget = DOM.elementToEventTarget element
    eventType   = producerToEventType key
    listener    = DOM.eventListener (push <<< onEvent)

  DOM.addEventListener eventType listener false eventTarget
  pure { listener, events }

-- | Render a set of properties (static or dynamic) onto an element, and
-- | prepare the event system.

render
  ∷ ∀ eff update state event
  . DOM.Element
  → I.Property update state event
  → Eff (I.FX eff)
      ( I.EventSystem
          (I.FX eff)
          update state event
      )

render element
  = case _ of
      I.StaticProperty property →
        case property of
          I.Fixed { key, value: Identity value } →
            DOM.setAttribute key value element $> I.StaticSystem

          I.Producer { key, onEvent: Identity transformer } → do
            { push: propagateEvent, event: producerEvents } ← FRP.create

            DOM.addEventListener
              (producerToEventType key)
              (producerFunctionToEventListener transformer propagateEvent)
              false
              (DOM.elementToEventTarget element)

            pure $ I.DynamicSystem
              { cancel: mempty
              , events: producerEvents
              , handleUpdate: mempty
              }

      I.DynamicProperty property →
        case property of
          I.Fixed { key, value: I.DynamicF listener } →
            pure $ I.DynamicSystem
              { cancel: DOM.removeAttribute key element
              , events: empty
              , handleUpdate: listener >>> case _ of
                  Nothing    → DOM.removeAttribute key element
                  Just value → DOM.setAttribute key value element
              }

          I.Producer { key, onEvent: I.DynamicF listener } → do
            { push: propagateEvent, event: events } ← FRP.create
            currentHandler ← Ref.newRef (DOM.eventListener \_ → pure unit)

            pure $ I.DynamicSystem
              { cancel: cancelEventListener key currentHandler
              , events
              , handleUpdate: listener >>> case _ of
                  Just replacement → do
                    cancelEventListener key currentHandler

                    let
                      handler
                        = DOM.eventListener
                        $ replacement >>> traverse_ propagateEvent

                    DOM.addEventListener (producerToEventType key) handler
                      false (DOM.elementToEventTarget element)

                  Nothing →
                    cancelEventListener key currentHandler
              }
  where
    producerFunctionToEventListener
      ∷ ∀ eff'
      . (DOM.Event → Maybe event)
      → (event → Eff (I.FX eff') Unit)
      → DOM.EventListener (I.FX eff')

    producerFunctionToEventListener onEvent registerEvent
      = DOM.eventListener $ onEvent >>> traverse_ registerEvent

    cancelEventListener
      ∷ ∀ eff'
      . I.Producer
      → Ref.Ref (DOM.EventListener (I.FX eff'))
      → Eff (I.FX eff') Unit

    cancelEventListener key ref = do
      handler ← Ref.readRef ref

      DOM.removeEventListener
        (producerToEventType key)
        handler
        false
        (DOM.elementToEventTarget element)
