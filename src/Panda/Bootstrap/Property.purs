module Panda.Bootstrap.Property
  ( render
  ) where

import Control.Monad.Eff         (Eff)
import Control.Plus              (empty)
import DOM.Event.EventTarget     (addEventListener, eventListener, removeEventListener, EventListener) as DOM
import DOM.Event.Types           (Event, EventType) as DOM
import DOM.HTML.Event.EventTypes as DOM.Events
import DOM.Node.Element          (removeAttribute, setAttribute) as DOM
import DOM.Node.Types            (Element, elementToEventTarget) as DOM
import Data.Filterable           (filtered)
import Data.Foldable             (for_, sequence_)
import Data.Maybe                (Maybe(..))
import Data.Monoid               (mempty)
import FRP.Event                 (Event, create, subscribe) as FRP
import FRP.Event.Class           (withLast) as FRP
import Panda.Internal.Types      as Types

import Prelude

-- | Given a Producer, return the string that identifies it when adding an
-- event handler. This is also the string we use for the attribute when we
-- attach it to the DOM.
producerToString ∷ Types.Producer → String
producerToString
  = case _ of
      Types.OnAbort         → "abort"
      Types.OnBlur          → "blur"
      Types.OnChange        → "change"
      Types.OnClick         → "click"
      Types.OnContextMenu   → "contextmenu"
      Types.OnDoubleClick   → "dblclick"
      Types.OnDrag          → "drag"
      Types.OnDragEnd       → "dragend"
      Types.OnDragEnter     → "dragenter"
      Types.OnDragExit      → "dragexit"
      Types.OnDragLeave     → "dragleave"
      Types.OnDragOver      → "dragover"
      Types.OnDragStart     → "dragstart"
      Types.OnDrop          → "drop"
      Types.OnError         → "error"
      Types.OnFocus         → "focus"
      Types.OnFocusIn       → "focusin"
      Types.OnFocusOut      → "focusout"
      Types.OnInput         → "input"
      Types.OnInvalid       → "invalid"
      Types.OnKeyDown       → "keydown"
      Types.OnKeyPress      → "keypress"
      Types.OnKeyUp         → "keyup"
      Types.OnLoad          → "load"
      Types.OnMouseDown     → "mousedown"
      Types.OnMouseEnter    → "mouseenter"
      Types.OnMouseLeave    → "mouseleave"
      Types.OnMouseMove     → "mousemove"
      Types.OnMouseOver     → "mouseover"
      Types.OnMouseOut      → "mouseout"
      Types.OnMouseUp       → "mouseup"
      Types.OnReset         → "reset"
      Types.OnScroll        → "scroll"
      Types.OnSelect        → "select"
      Types.OnSubmit        → "submit"
      Types.OnTransitionEnd → "transitionend"

-- | Convert a Producer into a regular DOM event. This is used to produce an
-- EventTarget.
producerToEventType ∷ Types.Producer → DOM.EventType
producerToEventType
  = case _ of
      Types.OnAbort         → DOM.Events.abort
      Types.OnBlur          → DOM.Events.blur
      Types.OnChange        → DOM.Events.change
      Types.OnClick         → DOM.Events.click
      Types.OnContextMenu   → DOM.Events.contextmenu
      Types.OnDoubleClick   → DOM.Events.dblclick
      Types.OnDrag          → DOM.Events.drag
      Types.OnDragEnd       → DOM.Events.dragend
      Types.OnDragEnter     → DOM.Events.dragenter
      Types.OnDragExit      → DOM.Events.dragexit
      Types.OnDragLeave     → DOM.Events.dragleave
      Types.OnDragOver      → DOM.Events.dragover
      Types.OnDragStart     → DOM.Events.dragstart
      Types.OnDrop          → DOM.Events.drop
      Types.OnError         → DOM.Events.error
      Types.OnFocus         → DOM.Events.focus
      Types.OnFocusIn       → DOM.Events.focusin
      Types.OnFocusOut      → DOM.Events.focusout
      Types.OnInput         → DOM.Events.input
      Types.OnInvalid       → DOM.Events.invalid
      Types.OnKeyDown       → DOM.Events.keydown
      Types.OnKeyPress      → DOM.Events.keypress
      Types.OnKeyUp         → DOM.Events.keyup
      Types.OnLoad          → DOM.Events.load
      Types.OnMouseDown     → DOM.Events.mousedown
      Types.OnMouseEnter    → DOM.Events.mouseenter
      Types.OnMouseLeave    → DOM.Events.mouseleave
      Types.OnMouseMove     → DOM.Events.mousemove
      Types.OnMouseOver     → DOM.Events.mouseover
      Types.OnMouseOut      → DOM.Events.mouseout
      Types.OnMouseUp       → DOM.Events.mouseup
      Types.OnReset         → DOM.Events.reset
      Types.OnScroll        → DOM.Events.scroll
      Types.OnSelect        → DOM.Events.select
      Types.OnSubmit        → DOM.Events.submit
      Types.OnTransitionEnd → DOM.Events.transitionend

-- | Add an event listener to a DOM element. The return result is an `Event`
-- that can be watched for events firing from this node, as well as the `key`
-- string that was used to register the event.
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
    listener    = DOM.eventListener \e → push (onEvent e)

  DOM.addEventListener eventType listener false eventTarget
  pure { listener, events }

-- | Render a Property on a DOM element. This also initialises any `Watcher`
-- components, and sets up their event handlers and cancellers.
render
  ∷ ∀ eff update state event
  . DOM.Element
  → Types.Property update state event
  → Eff (Types.FX eff) (Types.EventSystem (Types.FX eff) update state event)

render element
  = case _ of
      Types.PStatic (Types.PropertyStatic { key, value }) → do
        DOM.setAttribute key value element

        pure
          ( Types.EventSystem
              { cancel: mempty
              , events: empty
              , handleUpdate: mempty
              }
          )

      Types.PWatcher (Types.PropertyWatcher { key, listener }) → do
        { event: output,     push: toOutput }          ← FRP.create
        { event: cancellers, push: registerCanceller } ← FRP.create

        cancelIteration ← FRP.subscribe (FRP.withLast cancellers) \{ last } →
          sequence_ last

        pure
          ( Types.EventSystem
              { cancel: registerCanceller (pure unit) *> cancelIteration
              , events: output
              , handleUpdate: \update → do
                  let renderer = listener update

                  case renderer of
                    Types.Rerender update →
                      case update of
                        Types.Update value →
                          DOM.setAttribute key value element

                        Types.Remove →
                          DOM.removeAttribute key element
                    Types.Ignore →
                      pure unit
              }
          )

      Types.PProducer (Types.PropertyProducer trigger) → do
        { listener, events } ← attach trigger element

        let
          eventTarget = DOM.elementToEventTarget element
          eventType   = producerToEventType trigger.key

        pure
          ( Types.EventSystem
              { cancel: DOM.removeEventListener
                  eventType listener false eventTarget
              , events: filtered events
              , handleUpdate: \_ → pure unit
              }
          )
