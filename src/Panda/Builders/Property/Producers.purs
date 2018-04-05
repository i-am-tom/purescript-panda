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
import Data.Maybe           (Maybe(..))
import Panda.Internal       as Types
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

type Producer input
  = ∀ event
  . (input → Maybe event)
  → Types.Property event

makeProducer
  ∷ ∀ input
  . Types.Producer
  → Producer input

makeProducer key onEvent
  = Types.PropertyProducer
      { key
      , onEvent: onEvent <<< unsafeCoerce
      }

type Producer_ input
  = ∀ event
  . (input → event)
  → Types.Property event

makeProducer_
  ∷ ∀ input
  . Types.Producer
  → Producer_ input

makeProducer_ key onEvent
  = makeProducer key (Just <<< onEvent)

onBlur ∷ Producer DOM.FocusEvent
onBlur = makeProducer Types.OnBlur

onBlur_ ∷ Producer_ DOM.FocusEvent
onBlur_ = makeProducer_ Types.OnBlur

onChange ∷ Producer DOM.Event
onChange = makeProducer Types.OnChange

onChange' ∷ Producer String
onChange' = makeProducer Types.OnChange <<< targetValue

onChange_ ∷ Producer_ String
onChange_ = makeProducer_ Types.OnChange

onClick ∷ Producer DOM.MouseEvent
onClick = makeProducer Types.OnClick

onClick_ ∷ Producer_ DOM.MouseEvent
onClick_ = makeProducer_ Types.OnClick

onDoubleClick ∷ Producer DOM.MouseEvent
onDoubleClick = makeProducer Types.OnDoubleClick

onDoubleClick_ ∷ Producer_ DOM.MouseEvent
onDoubleClick_ = makeProducer_ Types.OnDoubleClick

onDrag ∷ Producer DOM.DragEvent
onDrag = makeProducer Types.OnDrag

onDrag_ ∷ Producer_ DOM.DragEvent
onDrag_ = makeProducer_ Types.OnDrag

onDragEnd ∷ Producer DOM.DragEvent
onDragEnd = makeProducer Types.OnDragEnd

onDragEnd_ ∷ Producer_ DOM.DragEvent
onDragEnd_ = makeProducer_ Types.OnDragEnd

onDragEnter ∷ Producer DOM.DragEvent
onDragEnter = makeProducer Types.OnDragEnter

onDragEnter_ ∷ Producer_ DOM.DragEvent
onDragEnter_ = makeProducer_ Types.OnDragEnter

onDragLeave ∷ Producer DOM.DragEvent
onDragLeave = makeProducer Types.OnDragLeave

onDragLeave_ ∷ Producer_ DOM.DragEvent
onDragLeave_ = makeProducer_ Types.OnDragLeave

onDragOver ∷ Producer DOM.DragEvent
onDragOver = makeProducer Types.OnDragLeave

onDragOver_ ∷ Producer_ DOM.DragEvent
onDragOver_ = makeProducer_ Types.OnDragLeave

onDragStart ∷ Producer DOM.DragEvent
onDragStart = makeProducer Types.OnDragStart

onDragStart_ ∷ Producer_ DOM.DragEvent
onDragStart_ = makeProducer_ Types.OnDragStart

onDrop ∷ Producer DOM.DragEvent
onDrop = makeProducer Types.OnDrop

onDrop_ ∷ Producer_ DOM.DragEvent
onDrop_ = makeProducer_ Types.OnDrop

onError ∷ Producer DOM.ErrorEvent
onError = makeProducer Types.OnError

onError_ ∷ Producer_ DOM.ErrorEvent
onError_ = makeProducer_ Types.OnError

onFocus ∷ Producer DOM.FocusEvent
onFocus = makeProducer Types.OnFocus

onFocus_ ∷ Producer_ DOM.FocusEvent
onFocus_ = makeProducer_ Types.OnFocus

onInput ∷ Producer DOM.Event
onInput = makeProducer Types.OnFocus

onInput_ ∷ Producer_ DOM.Event
onInput_ = makeProducer_ Types.OnFocus

onInput' ∷ Producer String
onInput' = makeProducer Types.OnFocus <<< targetValue

onKeyDown ∷ Producer DOM.KeyboardEvent
onKeyDown = makeProducer Types.OnKeyDown

onKeyDown_ ∷ Producer_ DOM.KeyboardEvent
onKeyDown_ = makeProducer_ Types.OnKeyDown

onKeyDown' ∷ Producer Int
onKeyDown' = makeProducer Types.OnKeyDown <<< keyCode

onKeyPress ∷ Producer DOM.KeyboardEvent
onKeyPress = makeProducer Types.OnKeyPress

onKeyPress_ ∷ Producer_ DOM.KeyboardEvent
onKeyPress_ = makeProducer_ Types.OnKeyPress

onKeyPress' ∷ Producer Int
onKeyPress' = makeProducer Types.OnKeyPress <<< keyCode

onKeyUp ∷ Producer DOM.KeyboardEvent
onKeyUp = makeProducer Types.OnKeyUp

onKeyUp_ ∷ Producer_ DOM.KeyboardEvent
onKeyUp_ = makeProducer_ Types.OnKeyUp

onKeyUp' ∷ Producer Int
onKeyUp' = makeProducer Types.OnKeyUp <<< keyCode

onMouseDown ∷ Producer DOM.MouseEvent
onMouseDown = makeProducer Types.OnMouseDown

onMouseDown_ ∷ Producer_ DOM.MouseEvent
onMouseDown_ = makeProducer_ Types.OnMouseDown

onMouseEnter ∷ Producer DOM.MouseEvent
onMouseEnter = makeProducer Types.OnMouseEnter

onMouseEnter_ ∷ Producer_ DOM.MouseEvent
onMouseEnter_ = makeProducer_ Types.OnMouseEnter

onMouseLeave ∷ Producer DOM.MouseEvent
onMouseLeave = makeProducer Types.OnMouseLeave

onMouseLeave_ ∷ Producer_ DOM.MouseEvent
onMouseLeave_ = makeProducer_ Types.OnMouseLeave

onMouseMove ∷ Producer DOM.MouseEvent
onMouseMove = makeProducer Types.OnMouseMove

onMouseMove_ ∷ Producer_ DOM.MouseEvent
onMouseMove_ = makeProducer_ Types.OnMouseMove

onMouseOver ∷ Producer DOM.MouseEvent
onMouseOver = makeProducer Types.OnMouseOver

onMouseOver_ ∷ Producer_ DOM.MouseEvent
onMouseOver_ = makeProducer_ Types.OnMouseOver

onMouseOut ∷ Producer DOM.MouseEvent
onMouseOut = makeProducer Types.OnMouseOut

onMouseOut_ ∷ Producer_ DOM.MouseEvent
onMouseOut_ = makeProducer_ Types.OnMouseOut

onMouseUp ∷ Producer DOM.MouseEvent
onMouseUp = makeProducer Types.OnMouseUp

onMouseUp_ ∷ Producer_ DOM.MouseEvent
onMouseUp_ = makeProducer_ Types.OnMouseUp

onScroll ∷ Producer DOM.Event
onScroll = makeProducer Types.OnScroll

onScroll_ ∷ Producer_ DOM.Event
onScroll_ = makeProducer_ Types.OnScroll

onSubmit ∷ Producer DOM.Event
onSubmit = makeProducer Types.OnSubmit

onSubmit_ ∷ Producer_ DOM.Event
onSubmit_ = makeProducer_ Types.OnSubmit

onTransitionEnd ∷ Producer DOM.Event
onTransitionEnd = makeProducer Types.OnTransitionEnd

onTransitionEnd_ ∷ Producer_ DOM.Event
onTransitionEnd_ = makeProducer_ Types.OnTransitionEnd
