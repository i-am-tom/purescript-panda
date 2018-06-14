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
  , onSubmit
  , onSubmit_
  ) where

import Control.Monad.Except      (runExcept)
import Data.Maybe                (Maybe(..))
import Data.Either               (either)
import Foreign                   (readInt, readString, unsafeToForeign) as F
import Foreign.Index             (readProp) as F
import Panda.Internal.Types      as Types
import Unsafe.Coerce             (unsafeCoerce)
import Web.Event.Internal.Types  (Event) as Web
import Web.HTML.Event.DragEvent  (DragEvent) as Web
import Web.HTML.Event.ErrorEvent (ErrorEvent) as Web
import Web.UIEvent.FocusEvent    (FocusEvent) as Web
import Web.UIEvent.KeyboardEvent (KeyboardEvent) as Web
import Web.UIEvent.MouseEvent    (MouseEvent) as Web

import Prelude

-- | Given an event, get the value of the target element, if available, using
-- | the foreign interface.

targetValue
  ∷ ∀ message
  . (String → Maybe message)
  → Web.Event
  → Maybe message

targetValue handler ev
  = either (\_ → Nothing) handler (runExcept result)
  where
    result
        = F.readProp "target" (F.unsafeToForeign ev)
      >>= F.readProp "value"
      >>= F.readString

-- | Get a keycode, if available, from some event.

keyCode
  ∷ ∀ message
  . (Int → Maybe message)
  → Web.Event
  → Maybe message

keyCode handler ev
  = either (\_ → Nothing) handler (runExcept result)
  where
    result
        = F.readProp "keyCode" (F.unsafeToForeign ev)
      >>= F.readInt

type Producer middle
  = ∀ input message state
  . (middle → Maybe message)
  → Types.Property input message state

-- | Make a maybe-event-firing producer.

makeProducer
  ∷ ∀ message
  . Types.Producer
  → Producer message

makeProducer key onEvent
  = Types.Producer
      { key
      , onEvent: onEvent <<< unsafeCoerce
      }

type Producer_ middle
  = ∀ input message state
  . (middle → message)
  → Types.Property input message state

-- | Make a `Producer_` value.

makeProducer_
  ∷ ∀ message
  . Types.Producer
  → Producer_ message

makeProducer_ key onEvent
  = makeProducer key (Just <<< onEvent)

onBlur ∷ Producer Web.FocusEvent
onBlur = makeProducer Types.OnBlur

onBlur_ ∷ Producer_ Web.FocusEvent
onBlur_ = makeProducer_ Types.OnBlur

onChange ∷ Producer Web.Event
onChange = makeProducer Types.OnChange

onChange' ∷ Producer String
onChange' = makeProducer Types.OnInput <<< targetValue

onChange_ ∷ Producer_ String
onChange_ = makeProducer_ Types.OnChange

onClick ∷ Producer Web.MouseEvent
onClick = makeProducer Types.OnClick

onClick_ ∷ Producer_ Web.MouseEvent
onClick_ = makeProducer_ Types.OnClick

onDoubleClick ∷ Producer Web.MouseEvent
onDoubleClick = makeProducer Types.OnDoubleClick

onDoubleClick_ ∷ Producer_ Web.MouseEvent
onDoubleClick_ = makeProducer_ Types.OnDoubleClick

onDrag ∷ Producer Web.DragEvent
onDrag = makeProducer Types.OnDrag

onDrag_ ∷ Producer_ Web.DragEvent
onDrag_ = makeProducer_ Types.OnDrag

onDragEnd ∷ Producer Web.DragEvent
onDragEnd = makeProducer Types.OnDragEnd

onDragEnd_ ∷ Producer_ Web.DragEvent
onDragEnd_ = makeProducer_ Types.OnDragEnd

onDragEnter ∷ Producer Web.DragEvent
onDragEnter = makeProducer Types.OnDragEnter

onDragEnter_ ∷ Producer_ Web.DragEvent
onDragEnter_ = makeProducer_ Types.OnDragEnter

onDragLeave ∷ Producer Web.DragEvent
onDragLeave = makeProducer Types.OnDragLeave

onDragLeave_ ∷ Producer_ Web.DragEvent
onDragLeave_ = makeProducer_ Types.OnDragLeave

onDragOver ∷ Producer Web.DragEvent
onDragOver = makeProducer Types.OnDragLeave

onDragOver_ ∷ Producer_ Web.DragEvent
onDragOver_ = makeProducer_ Types.OnDragLeave

onDragStart ∷ Producer Web.DragEvent
onDragStart = makeProducer Types.OnDragStart

onDragStart_ ∷ Producer_ Web.DragEvent
onDragStart_ = makeProducer_ Types.OnDragStart

onDrop ∷ Producer Web.DragEvent
onDrop = makeProducer Types.OnDrop

onDrop_ ∷ Producer_ Web.DragEvent
onDrop_ = makeProducer_ Types.OnDrop

onError ∷ Producer Web.ErrorEvent
onError = makeProducer Types.OnError

onError_ ∷ Producer_ Web.ErrorEvent
onError_ = makeProducer_ Types.OnError

onFocus ∷ Producer Web.FocusEvent
onFocus = makeProducer Types.OnFocus

onFocus_ ∷ Producer_ Web.FocusEvent
onFocus_ = makeProducer_ Types.OnFocus

onInput ∷ Producer Web.Event
onInput = makeProducer Types.OnInput

onInput_ ∷ Producer_ Web.Event
onInput_ = makeProducer_ Types.OnInput

onInput' ∷ Producer String
onInput' = makeProducer Types.OnInput <<< targetValue

onKeyDown ∷ Producer Web.KeyboardEvent
onKeyDown = makeProducer Types.OnKeyDown

onKeyDown_ ∷ Producer_ Web.KeyboardEvent
onKeyDown_ = makeProducer_ Types.OnKeyDown

onKeyDown' ∷ Producer Int
onKeyDown' = makeProducer Types.OnKeyDown <<< keyCode

onKeyUp ∷ Producer Web.KeyboardEvent
onKeyUp = makeProducer Types.OnKeyUp

onKeyUp_ ∷ Producer_ Web.KeyboardEvent
onKeyUp_ = makeProducer_ Types.OnKeyUp

onKeyUp' ∷ Producer Int
onKeyUp' = makeProducer Types.OnKeyUp <<< keyCode

onMouseDown ∷ Producer Web.MouseEvent
onMouseDown = makeProducer Types.OnMouseDown

onMouseDown_ ∷ Producer_ Web.MouseEvent
onMouseDown_ = makeProducer_ Types.OnMouseDown

onMouseEnter ∷ Producer Web.MouseEvent
onMouseEnter = makeProducer Types.OnMouseEnter

onMouseEnter_ ∷ Producer_ Web.MouseEvent
onMouseEnter_ = makeProducer_ Types.OnMouseEnter

onMouseLeave ∷ Producer Web.MouseEvent
onMouseLeave = makeProducer Types.OnMouseLeave

onMouseLeave_ ∷ Producer_ Web.MouseEvent
onMouseLeave_ = makeProducer_ Types.OnMouseLeave

onMouseMove ∷ Producer Web.MouseEvent
onMouseMove = makeProducer Types.OnMouseMove

onMouseMove_ ∷ Producer_ Web.MouseEvent
onMouseMove_ = makeProducer_ Types.OnMouseMove

onMouseOver ∷ Producer Web.MouseEvent
onMouseOver = makeProducer Types.OnMouseOver

onMouseOver_ ∷ Producer_ Web.MouseEvent
onMouseOver_ = makeProducer_ Types.OnMouseOver

onMouseOut ∷ Producer Web.MouseEvent
onMouseOut = makeProducer Types.OnMouseOut

onMouseOut_ ∷ Producer_ Web.MouseEvent
onMouseOut_ = makeProducer_ Types.OnMouseOut

onMouseUp ∷ Producer Web.MouseEvent
onMouseUp = makeProducer Types.OnMouseUp

onMouseUp_ ∷ Producer_ Web.MouseEvent
onMouseUp_ = makeProducer_ Types.OnMouseUp

onSubmit ∷ Producer Web.Event
onSubmit = makeProducer Types.OnSubmit

onSubmit_ ∷ Producer_ Web.Event
onSubmit_ = makeProducer_ Types.OnSubmit
