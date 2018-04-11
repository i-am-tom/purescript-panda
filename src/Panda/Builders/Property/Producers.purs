module Panda.Builders.Property.Producers
  ( onBlur
  , onBlur_
  , onChange
  , onChange_
  , onChange'
  , onClick
  , onClick_
  , onDoubleClick
  , onDoubleClick_
  , onDrag
  , onDrag_
  , onDragEnd
  , onDragEnd_
  , onDragEnter
  , onDragEnter_
  , onDragLeave
  , onDragLeave_
  , onDragOver
  , onDragOver_
  , onDragStart
  , onDragStart_
  , onDrop
  , onDrop_
  , onError
  , onError_
  , onFocus
  , onFocus_
  , onInput
  , onInput_
  , onInput'
  , onKeyDown
  , onKeyDown_
  , onKeyDown'
  , onKeyPress
  , onKeyPress_
  , onKeyPress'
  , onKeyUp
  , onKeyUp_
  , onKeyUp'
  , onMouseDown
  , onMouseDown_
  , onMouseEnter
  , onMouseEnter_
  , onMouseLeave
  , onMouseLeave_
  , onMouseMove
  , onMouseMove_
  , onMouseOver
  , onMouseOver_
  , onMouseOut
  , onMouseOut_
  , onMouseUp
  , onMouseUp_
  , onScroll
  , onScroll_
  , onSubmit
  , onSubmit_
  , onTransitionEnd
  , onTransitionEnd_
  ) where

import Control.Monad.Except (runExcept)
import DOM.Event.Types      (Event, FocusEvent, KeyboardEvent, MouseEvent) as DOM
import DOM.HTML.Event.Types (DragEvent, ErrorEvent) as DOM
import Data.Either          (either)
import Data.Foreign         (readInt, readString, toForeign) as F
import Data.Foreign.Index   (readProp) as F
import Data.Identity        (Identity(..))
import Data.Maybe           (Maybe(..))
import Panda.Internal       as I
import Unsafe.Coerce        (unsafeCoerce)

import Prelude

-- | Given an event, get the value of the target element using the foreign
-- | interface.

targetValue
  ∷ ∀ output
  . (String → Maybe output)
  → DOM.Event
  → Maybe output

targetValue handler ev
  = either (\_ → Nothing) handler (runExcept result)
  where
    result
        = F.readProp "target" (F.toForeign ev)
      >>= F.readProp "value"
      >>= F.readString

-- | Given a keyboard event, get the keycode of the relevant key using the
-- | foreign interface.

keyCode
  ∷ ∀ event
  . (Int → Maybe event)
  → DOM.Event
  → Maybe event

keyCode handler ev
  = either (\_ → Nothing) handler (runExcept result)
  where
    result
        = F.readProp "keyCode" (F.toForeign ev)
      >>= F.readInt

-- | A regular producer takes a DOM event and translates it into some
-- | user-given event type.

type Producer input
  = ∀ update state event
  . (input → Maybe event)
  → I.Property update state event

-- | Make a maybe-event-firing producer.

makeProducer
  ∷ ∀ input
  . I.Producer
  → Producer input

makeProducer key onEvent
  = I.StaticProperty $ I.Producer
      { key
      , onEvent: Identity (onEvent <<< unsafeCoerce)
      }

-- | A `Producer_` is like a `Producer`, but there's no `Maybe` - all events
-- | are guaranteed to raise events within the `Application`.

type Producer_ input
  = ∀ update state event
  . (input → event)
  → I.Property update state event

-- | Make a `Producer_` value.

makeProducer_
  ∷ ∀ input
  . I.Producer
  → Producer_ input

makeProducer_ key onEvent
  = makeProducer key (Just <<< onEvent)

onBlur ∷ Producer DOM.FocusEvent
onBlur = makeProducer I.OnBlur

onBlur_ ∷ Producer_ DOM.FocusEvent
onBlur_ = makeProducer_ I.OnBlur

onChange ∷ Producer DOM.Event
onChange = makeProducer I.OnChange

onChange' ∷ Producer String
onChange' = makeProducer I.OnChange <<< targetValue

onChange_ ∷ Producer_ String
onChange_ = makeProducer_ I.OnChange

onClick ∷ Producer DOM.MouseEvent
onClick = makeProducer I.OnClick

onClick_ ∷ Producer_ DOM.MouseEvent
onClick_ = makeProducer_ I.OnClick

onDoubleClick ∷ Producer DOM.MouseEvent
onDoubleClick = makeProducer I.OnDoubleClick

onDoubleClick_ ∷ Producer_ DOM.MouseEvent
onDoubleClick_ = makeProducer_ I.OnDoubleClick

onDrag ∷ Producer DOM.DragEvent
onDrag = makeProducer I.OnDrag

onDrag_ ∷ Producer_ DOM.DragEvent
onDrag_ = makeProducer_ I.OnDrag

onDragEnd ∷ Producer DOM.DragEvent
onDragEnd = makeProducer I.OnDragEnd

onDragEnd_ ∷ Producer_ DOM.DragEvent
onDragEnd_ = makeProducer_ I.OnDragEnd

onDragEnter ∷ Producer DOM.DragEvent
onDragEnter = makeProducer I.OnDragEnter

onDragEnter_ ∷ Producer_ DOM.DragEvent
onDragEnter_ = makeProducer_ I.OnDragEnter

onDragLeave ∷ Producer DOM.DragEvent
onDragLeave = makeProducer I.OnDragLeave

onDragLeave_ ∷ Producer_ DOM.DragEvent
onDragLeave_ = makeProducer_ I.OnDragLeave

onDragOver ∷ Producer DOM.DragEvent
onDragOver = makeProducer I.OnDragLeave

onDragOver_ ∷ Producer_ DOM.DragEvent
onDragOver_ = makeProducer_ I.OnDragLeave

onDragStart ∷ Producer DOM.DragEvent
onDragStart = makeProducer I.OnDragStart

onDragStart_ ∷ Producer_ DOM.DragEvent
onDragStart_ = makeProducer_ I.OnDragStart

onDrop ∷ Producer DOM.DragEvent
onDrop = makeProducer I.OnDrop

onDrop_ ∷ Producer_ DOM.DragEvent
onDrop_ = makeProducer_ I.OnDrop

onError ∷ Producer DOM.ErrorEvent
onError = makeProducer I.OnError

onError_ ∷ Producer_ DOM.ErrorEvent
onError_ = makeProducer_ I.OnError

onFocus ∷ Producer DOM.FocusEvent
onFocus = makeProducer I.OnFocus

onFocus_ ∷ Producer_ DOM.FocusEvent
onFocus_ = makeProducer_ I.OnFocus

onInput ∷ Producer DOM.Event
onInput = makeProducer I.OnFocus

onInput_ ∷ Producer_ DOM.Event
onInput_ = makeProducer_ I.OnFocus

onInput' ∷ Producer String
onInput' = makeProducer I.OnFocus <<< targetValue

onKeyDown ∷ Producer DOM.KeyboardEvent
onKeyDown = makeProducer I.OnKeyDown

onKeyDown_ ∷ Producer_ DOM.KeyboardEvent
onKeyDown_ = makeProducer_ I.OnKeyDown

onKeyDown' ∷ Producer Int
onKeyDown' = makeProducer I.OnKeyDown <<< keyCode

onKeyPress ∷ Producer DOM.KeyboardEvent
onKeyPress = makeProducer I.OnKeyPress

onKeyPress_ ∷ Producer_ DOM.KeyboardEvent
onKeyPress_ = makeProducer_ I.OnKeyPress

onKeyPress' ∷ Producer Int
onKeyPress' = makeProducer I.OnKeyPress <<< keyCode

onKeyUp ∷ Producer DOM.KeyboardEvent
onKeyUp = makeProducer I.OnKeyUp

onKeyUp_ ∷ Producer_ DOM.KeyboardEvent
onKeyUp_ = makeProducer_ I.OnKeyUp

onKeyUp' ∷ Producer Int
onKeyUp' = makeProducer I.OnKeyUp <<< keyCode

onMouseDown ∷ Producer DOM.MouseEvent
onMouseDown = makeProducer I.OnMouseDown

onMouseDown_ ∷ Producer_ DOM.MouseEvent
onMouseDown_ = makeProducer_ I.OnMouseDown

onMouseEnter ∷ Producer DOM.MouseEvent
onMouseEnter = makeProducer I.OnMouseEnter

onMouseEnter_ ∷ Producer_ DOM.MouseEvent
onMouseEnter_ = makeProducer_ I.OnMouseEnter

onMouseLeave ∷ Producer DOM.MouseEvent
onMouseLeave = makeProducer I.OnMouseLeave

onMouseLeave_ ∷ Producer_ DOM.MouseEvent
onMouseLeave_ = makeProducer_ I.OnMouseLeave

onMouseMove ∷ Producer DOM.MouseEvent
onMouseMove = makeProducer I.OnMouseMove

onMouseMove_ ∷ Producer_ DOM.MouseEvent
onMouseMove_ = makeProducer_ I.OnMouseMove

onMouseOver ∷ Producer DOM.MouseEvent
onMouseOver = makeProducer I.OnMouseOver

onMouseOver_ ∷ Producer_ DOM.MouseEvent
onMouseOver_ = makeProducer_ I.OnMouseOver

onMouseOut ∷ Producer DOM.MouseEvent
onMouseOut = makeProducer I.OnMouseOut

onMouseOut_ ∷ Producer_ DOM.MouseEvent
onMouseOut_ = makeProducer_ I.OnMouseOut

onMouseUp ∷ Producer DOM.MouseEvent
onMouseUp = makeProducer I.OnMouseUp

onMouseUp_ ∷ Producer_ DOM.MouseEvent
onMouseUp_ = makeProducer_ I.OnMouseUp

onScroll ∷ Producer DOM.Event
onScroll = makeProducer I.OnScroll

onScroll_ ∷ Producer_ DOM.Event
onScroll_ = makeProducer_ I.OnScroll

onSubmit ∷ Producer DOM.Event
onSubmit = makeProducer I.OnSubmit

onSubmit_ ∷ Producer_ DOM.Event
onSubmit_ = makeProducer_ I.OnSubmit

onTransitionEnd ∷ Producer DOM.Event
onTransitionEnd = makeProducer I.OnTransitionEnd

onTransitionEnd_ ∷ Producer_ DOM.Event
onTransitionEnd_ = makeProducer_ I.OnTransitionEnd
