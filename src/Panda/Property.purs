module Panda.Property where

import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import DOM.Event.EventTarget (addEventListener, eventListener, removeEventListener, EventListener) as DOM
import DOM.Event.Types (EventType) as DOM
import DOM.HTML.Event.EventTypes (click) as DOM.Events
import DOM.Node.Element (removeAttribute, setAttribute) as DOM
import DOM.Node.Types (Element, elementToEventTarget) as DOM
import Data.Foldable (sequence_, traverse_)
import Data.Lazy (force)
import Data.Maybe (Maybe, isNothing)
import FRP.Event (Event, create, subscribe) as FRP
import FRP.Event.Class (withLast) as FRP
import Panda.Internal.Types as Types

import Prelude

-- | Given a Producer, return the string that identifies it when adding an
-- event handler.
producerToString
  ∷ Types.Producer
  → String

producerToString
  = case _ of
      Types.OnClick → "click"

-- | Convert a Producer into a regular DOM event.
producerToEventType
  ∷ Types.Producer
  → DOM.EventType

producerToEventType
  = case _ of
      Types.OnClick → DOM.Events.click

-- | Add an event listener to a DOM element. The return result is an `Event`
-- that can be watched for events firing from this node, as well as the `key`
-- string that was used to register the event.
attach
  ∷ ∀ event
  . { key ∷ Types.Producer
    , event ∷ event
    }
  → DOM.Element
  → Eff _
      { listener ∷ DOM.EventListener _
      , events ∷ FRP.Event event
      }

attach { key, event } element = do
  { push, event: events } ← FRP.create
  let name = producerToString key
      listener = DOM.eventListener \_ → push event

  DOM.addEventListener
    (producerToEventType key)
    listener
    false
    (DOM.elementToEventTarget element)

  pure
      { listener
      , events
      }

-- | Render a Property on a DOM element. This also initialises any
-- `Watcher`-style listeners.
render
  ∷ ∀ update state event
  . DOM.Element
  → Types.Property update state event
  → Eff _
      { cancel ∷ Types.Canceller _
      , events ∷ FRP.Event event
      , handleUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff _ Unit
      }

render element
  = case _ of
      Types.PStatic (Types.PropertyStatic { key, value }) → do
        DOM.setAttribute key value element

        pure
          { cancel: pure unit
          , events: empty
          , handleUpdate: \_ → pure unit
          }

      Types.PWatcher (Types.PropertyWatcher { key, listener }) → do
        { event: output,     push: toOutput }          ← FRP.create
        { event: cancellers, push: registerCanceller } ← FRP.create

        cancelIteration ← FRP.subscribe (FRP.withLast cancellers) \{ last } →
          sequence_ last

        pure
          { cancel: registerCanceller (pure unit) *> cancelIteration
          , events: output
          , handleUpdate: \update → do
              let { interest, renderer } = listener update

              when interest do
                { cancel, events, handleUpdate }
                    ← render element (force renderer)

                cancelChild ← FRP.subscribe events toOutput
                registerCanceller (cancel *> cancelChild)
          }

      Types.PProducer (Types.PropertyProducer trigger) → do
        { listener, events } ← attach trigger element

        pure
          { cancel: DOM.removeEventListener
              (producerToEventType trigger.key)
              listener
              false
              (DOM.elementToEventTarget element)
          , events
          , handleUpdate: \_ → pure unit
          }
