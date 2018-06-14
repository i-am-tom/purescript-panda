module Panda.Render.Property where

import Control.Plus              (empty)
import Data.Foldable             (traverse_)
import Data.Maybe                (Maybe(..))
import Data.String               (drop, toLower)
import Effect                    (Effect)
import Effect.Ref                as Ref
import FRP.Event                 (create, subscribe) as FRP
import Panda.Internal.Types      as Types
import Web.DOM.Element           (removeAttribute, setAttribute, toEventTarget) as Web
import Web.DOM.Internal.Types    (Element) as Web
import Web.Event.Event           (Event, EventType) as Web
import Web.Event.EventTarget     (eventListener, addEventListener, removeEventListener) as Web

import Web.UIEvent.MouseEvent.EventTypes    (click, dblclick, mousedown, mouseenter, mouseleave, mousemove, mouseout, mouseover, mouseup) as Web.Events
import Web.UIEvent.KeyboardEvent.EventTypes (keydown, keyup) as Web.Events
import Web.HTML.Event.EventTypes            (blur, change, error, focus, input, submit) as Web.Events
import Web.HTML.Event.DragEvent.EventTypes  (drag, dragend, dragenter, dragleave, dragover, dragstart, drop) as Web.Events

import Prelude

producerToEventType ∷ Types.Producer → Web.EventType
producerToEventType = case _ of
  Types.OnBlur          → Web.Events.blur
  Types.OnChange        → Web.Events.change
  Types.OnClick         → Web.Events.click
  Types.OnDoubleClick   → Web.Events.dblclick
  Types.OnDrag          → Web.Events.drag
  Types.OnDragEnd       → Web.Events.dragend
  Types.OnDragEnter     → Web.Events.dragenter
  Types.OnDragLeave     → Web.Events.dragleave
  Types.OnDragOver      → Web.Events.dragover
  Types.OnDragStart     → Web.Events.dragstart
  Types.OnDrop          → Web.Events.drop
  Types.OnError         → Web.Events.error
  Types.OnFocus         → Web.Events.focus
  Types.OnInput         → Web.Events.input
  Types.OnKeyDown       → Web.Events.keydown
  Types.OnKeyUp         → Web.Events.keyup
  Types.OnMouseDown     → Web.Events.mousedown
  Types.OnMouseEnter    → Web.Events.mouseenter
  Types.OnMouseLeave    → Web.Events.mouseleave
  Types.OnMouseMove     → Web.Events.mousemove
  Types.OnMouseOut      → Web.Events.mouseout
  Types.OnMouseOver     → Web.Events.mouseover
  Types.OnMouseUp       → Web.Events.mouseup
  Types.OnSubmit        → Web.Events.submit

renderStaticFixed
  ∷ ∀ input message state
  . Web.Element
  → String
  → String
  → Effect (Types.EventSystem input message state)

renderStaticFixed element key value = do
  Web.setAttribute key value element

  pure
    { cancel: Web.removeAttribute key element
    , events: empty
    , handleUpdate: \_ → pure unit
    }

renderStaticProducer
  ∷ ∀ input message state
  . Web.Element
  → Types.Producer
  → (Web.Event → Maybe message)
  → Effect (Types.EventSystem input message state)

renderStaticProducer element key onEvent = do
  { push, event: events } ← FRP.create

  let handler = traverse_ push <<< onEvent
      eTarget = Web.toEventTarget element
      eType   = producerToEventType key

  eListener <- Web.eventListener handler
  Web.addEventListener eType eListener false eTarget

  pure
    { cancel: Web.removeEventListener eType eListener false eTarget
    , events
    , handleUpdate: \_ → pure unit
    }

renderDynamic
  ∷ ∀ input message state
  . Web.Element
  → ( { input ∷ input, state ∷ state }
    → Types.ShouldUpdate (Types.Property input message state)
    )
  → Effect (Types.EventSystem input message state)

renderDynamic element watcher = do
  subproducer ← FRP.create
  propertyRef ← Ref.new Nothing

  pure
    { cancel: Ref.read propertyRef >>= case _ of
        Just { cancel } → cancel
        Nothing         → pure unit

    , events: subproducer.event
    , handleUpdate: \input → do
        let
          clearListener = Ref.read propertyRef >>= case _ of
            Just { cancel } → do
              Ref.write Nothing propertyRef
              cancel

            Nothing → pure unit

        case watcher input of
          Types.Ignore → pure unit
          Types.Clear  → clearListener

          Types.SetTo nextProperty → do
            property ← render element nextProperty
            clearListener

            canceller ← FRP.subscribe property.events subproducer.push

            let
              system' = Just property
                { cancel = do
                    property.cancel
                    canceller
                }

            Ref.write system' propertyRef
    }

render
  ∷ ∀ input message state
  . Web.Element
  → Types.Property input message state
  → Effect (Types.EventSystem input message state)

render element = case _ of
  Types.Fixed { key, value } → do
    renderStaticFixed element key value

  Types.Producer { key, onEvent } → do
    renderStaticProducer element key onEvent

  Types.Dynamic watcher → do
    renderDynamic element watcher
