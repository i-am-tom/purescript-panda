module Panda.Render.Property
  ( render
  ) where

import Control.Monad.Eff          (Eff)
import Control.Monad.Eff.Ref      as Ref
import DOM.Event.EventTarget      (addEventListener, eventListener, removeEventListener, EventListener) as DOM
import DOM.Event.Types            (Event, EventType) as DOM
import DOM.HTML.Event.EventTypes  as DOM.Events
import DOM.Node.Element           (setAttribute) as DOM
import DOM.Node.Types             (Element, elementToEventTarget) as DOM
import Data.Filterable            (filtered)
import Data.Foldable              (foldMap, for_, traverse_)
import Data.Map                   as Map
import Data.Maybe                 (Maybe(..))
import FRP.Event                  (Event, create, subscribe) as FRP
import Panda.Incremental.Property (execute)
import Panda.Internal             as Types

import Prelude

-- | Convert a Producer into a regular DOM event. This is used to produce an
-- | EventTarget.
producerToEventType ∷ Types.Producer → DOM.EventType
producerToEventType
  = case _ of
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
      Types.OnMouseOver     → DOM.Events.mouseover
      Types.OnMouseOut      → DOM.Events.mouseout
      Types.OnMouseUp       → DOM.Events.mouseup
      Types.OnScroll        → DOM.Events.scroll
      Types.OnSubmit        → DOM.Events.submit
      Types.OnTransitionEnd → DOM.Events.transitionend

-- | Add an event listener to a DOM element. The return result is an `Event`
-- | that can be watched for events firing from this node, as well as the `key`
-- | string that was used to register the event.
attach
  ∷ ∀ eff event
  . { key     ∷ Types.Producer
    , onEvent ∷ DOM.Event → event
    }
  → DOM.Element
  → Eff (Types.FX eff)
      { listener ∷ DOM.EventListener (Types.FX eff)
      , events ∷ FRP.Event event
      }

attach { key, onEvent } element = do
  { push, event: events } ← FRP.create

  let
    eventTarget = DOM.elementToEventTarget element
    eventType   = producerToEventType key
    listener    = DOM.eventListener (push <<< onEvent)

  DOM.addEventListener eventType listener false eventTarget
  pure { listener, events }

-- | Render a Property on a DOM element. This also initialises any `Watcher`
-- | components, and sets up their event handlers and cancellers.
render'
  ∷ ∀ eff update state event
  . DOM.Element
  → Types.Property event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

render' element
  = case _ of
      Types.PropertyFixed { key, value } → do
        DOM.setAttribute key value element
        pure Types.StaticSystem

      Types.PropertyProducer trigger → do
        { listener, events } ← attach trigger element

        let
          eventTarget = DOM.elementToEventTarget element
          eventType   = producerToEventType trigger.key

        pure $ Types.DynamicSystem
          { cancel: DOM.removeEventListener
              eventType listener false eventTarget
          , events: filtered events
          , handleUpdate: \_ → pure unit
          }

-- | Render a set of properties (static or dynamic) onto an element, and
-- | prepare the event system.
render
  ∷ ∀ eff update state event
  . DOM.Element
  → Types.Properties update state event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

render element
  = case _ of
      Types.StaticProperties properties →
        foldMap (render' element) properties

      Types.DynamicProperties listener → do
        eventSystems                               ← Ref.newRef Map.empty
        { event: events, push: pushPropertyEvent } ← FRP.create

        pure $ Types.DynamicSystem
          { cancel: do
              systems ← Ref.readRef eventSystems

              for_ systems case _ of
                Types.DynamicSystem { cancel } →
                  cancel

                _ →
                  pure unit

          , events

          , handleUpdate: listener >>> traverse_ \instruction → do
              systems ← Ref.readRef eventSystems

              { hasNewItem, systems: updatedSystems } ←
                  execute
                    { element
                    , systems
                    , render: render' element
                    , update: instruction
                    }

              case hasNewItem of
                Nothing →
                  Ref.writeRef
                    eventSystems
                    updatedSystems

                Just index →
                  case Map.lookup index updatedSystems of
                    Just (Types.DynamicSystem system) → do
                      canceller ←
                        FRP.subscribe
                          system.events
                          pushPropertyEvent

                      let
                        updated
                          = Types.DynamicSystem $ system
                              { cancel = do
                                  system.cancel
                                  canceller
                              }

                      Ref.writeRef eventSystems
                        $ Map.insert index updated updatedSystems

                    _ →
                      pure unit
          }
