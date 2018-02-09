module Panda.Property where

import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import DOM.Event.EventTarget (addEventListener, eventListener) as DOM
import DOM.Event.Types (EventType) as DOM
import DOM.HTML.Event.EventTypes (click) as DOM.Events
import DOM.Node.Element (removeAttribute, setAttribute) as DOM
import DOM.Node.Types (Element, elementToEventTarget) as DOM
import Data.Foldable (sequence_)
import Data.Lazy (force)
import FRP.Event (Event, subscribe) as FRP
import FRP.Event.Class (withLast) as FRP
import Panda.Event (create) as FRP
import Panda.Internal.Types as Types

import Prelude

producerToString
  ∷ Types.Producer
  → String

producerToString
  = case _ of
      Types.OnClick → "click"

producerToEventType
  ∷ Types.Producer
  → DOM.EventType

producerToEventType
  = case _ of
      Types.OnClick → DOM.Events.click

attach
  ∷ ∀ event
  . { key ∷ Types.Producer
    , event ∷ event
    }
  → DOM.Element
  → Eff _
      { key ∷ String
      , events ∷ FRP.Event event
      }

attach { key, event } element = do
  { push, event: events } ← FRP.create
  let name = producerToString key

  DOM.addEventListener
    (producerToEventType key)
    (DOM.eventListener \_ → push event)
    false
    (DOM.elementToEventTarget element)

  pure
      { key: name
      , events
      }

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
        { key, events } ← attach trigger element

        pure
          { cancel: DOM.removeAttribute key element
          , events
          , handleUpdate: \_ → pure unit
          }
