module Panda.Property
  ( module Panda.Property
  , module Watchers
  ) where

import Control.Monad.Except    (runExcept)
import DOM.Event.Types         (Event, FocusEvent, InputEvent, KeyboardEvent, MouseEvent, TouchEvent, WheelEvent) as DOM
import DOM.HTML.Event.Types    (DragEvent, ErrorEvent) as DOM
import Data.Either             (either)
import Data.Foreign            (readString, toForeign) as F
import Data.Foreign.Index      (readProp) as F
import Data.Maybe              (Maybe(..))
import Panda.Internal.Types    as Types
import Panda.Property.Watchers as Watchers
import Unsafe.Coerce           (unsafeCoerce)

import Prelude

-- | Event conversions

eventToDragEvent ∷ DOM.Event → DOM.DragEvent
eventToDragEvent = unsafeCoerce

eventToErrorEvent ∷ DOM.Event → DOM.ErrorEvent
eventToErrorEvent = unsafeCoerce

eventToFocusEvent ∷ DOM.Event → DOM.FocusEvent
eventToFocusEvent = unsafeCoerce

eventToInputEvent ∷ DOM.Event → DOM.InputEvent
eventToInputEvent = unsafeCoerce

eventToKeyboardEvent ∷ DOM.Event → DOM.KeyboardEvent
eventToKeyboardEvent = unsafeCoerce

eventToMouseEvent ∷ DOM.Event → DOM.MouseEvent
eventToMouseEvent = unsafeCoerce

eventToTouchEvent ∷ DOM.Event → DOM.TouchEvent
eventToTouchEvent = unsafeCoerce

eventToWheelEvent ∷ DOM.Event → DOM.WheelEvent
eventToWheelEvent = unsafeCoerce

-- | Event producers
type Producer input
  = ∀ update state event
  . (input → Maybe event)
  → Types.Property update state event

-- | Make a producer with the given handler.
makeProducer'
  ∷ ∀ update state event
  . Types.Producer
  → (DOM.Event → Maybe event)
  → Types.Property update state event
makeProducer' key onEvent
  = Types.PropertyProducer
      { key
      , onEvent
      }

-- | Specifically build a producer of a given input type.
makeProducer
  ∷ ∀ input
  . Types.Producer
  → (DOM.Event → input)
  → Producer input
makeProducer key conversion onEvent
  = makeProducer' key \ev →
      onEvent (conversion ev)

-- | Get the value of the target DOM element.
targetValue
  ∷ ∀ event
  . (String → Maybe event)
  → DOM.Event
  → Maybe event
targetValue handler ev
  = either (\_ → Nothing) handler
      ( runExcept do
          let ev' = F.toForeign ev

          target' ← F.readProp "target" ev'
          value'  ← F.readProp "value" target'

          F.readString value'
      )

onAbort ∷ Producer DOM.Event
onAbort = makeProducer Types.OnAbort id

onBlur ∷ Producer DOM.FocusEvent
onBlur = makeProducer Types.OnBlur eventToFocusEvent

onChange ∷ Producer String
onChange handler = makeProducer' Types.OnChange (targetValue handler)

onChange' ∷ Producer DOM.Event
onChange' = makeProducer Types.OnChange id

onClick ∷ Producer DOM.MouseEvent
onClick = makeProducer Types.OnClick eventToMouseEvent

onContextMenu ∷ Producer DOM.MouseEvent
onContextMenu = makeProducer Types.OnContextMenu eventToMouseEvent

onDoubleClick ∷ Producer DOM.MouseEvent
onDoubleClick = makeProducer Types.OnDoubleClick eventToMouseEvent

onDrag ∷ Producer DOM.DragEvent
onDrag = makeProducer Types.OnDrag eventToDragEvent

onDragEnd ∷ Producer DOM.DragEvent
onDragEnd = makeProducer Types.OnDragEnd eventToDragEvent

onDragEnter ∷ Producer DOM.DragEvent
onDragEnter = makeProducer Types.OnDragEnter eventToDragEvent

onDragExit ∷ Producer DOM.DragEvent
onDragExit = makeProducer Types.OnDragExit eventToDragEvent

onDragLeave ∷ Producer DOM.DragEvent
onDragLeave = makeProducer Types.OnDragLeave eventToDragEvent

onDragOver ∷ Producer DOM.DragEvent
onDragOver = makeProducer Types.OnDragOver eventToDragEvent

onDragStart ∷ Producer DOM.DragEvent
onDragStart = makeProducer Types.OnDragStart eventToDragEvent

onDrop ∷ Producer DOM.DragEvent
onDrop = makeProducer Types.OnDrop eventToDragEvent

onError ∷ Producer DOM.ErrorEvent
onError = makeProducer Types.OnError eventToErrorEvent

onFocus ∷ Producer DOM.FocusEvent
onFocus = makeProducer Types.OnFocus eventToFocusEvent

onFocusIn ∷ Producer DOM.FocusEvent
onFocusIn = makeProducer Types.OnFocusIn eventToFocusEvent

onFocusOut ∷ Producer DOM.FocusEvent
onFocusOut = makeProducer Types.OnFocusOut eventToFocusEvent

onInput ∷ Producer String
onInput handler = makeProducer' Types.OnInput (targetValue handler)

onInput' ∷ Producer DOM.Event
onInput' = makeProducer Types.OnInput id

onInvalid ∷ Producer DOM.Event
onInvalid = makeProducer Types.OnInvalid id

onKeyDown ∷ Producer String
onKeyDown handler = makeProducer' Types.OnKeyDown (targetValue handler)

onKeyDown' ∷ Producer DOM.KeyboardEvent
onKeyDown' = makeProducer Types.OnKeyDown eventToKeyboardEvent

onKeyPress ∷ Producer String
onKeyPress handler = makeProducer' Types.OnKeyPress (targetValue handler)

onKeyPress' ∷ Producer DOM.KeyboardEvent
onKeyPress' = makeProducer Types.OnKeyPress eventToKeyboardEvent

onKeyUp ∷ Producer String
onKeyUp handler = makeProducer' Types.OnKeyUp (targetValue handler)

onKeyUp' ∷ Producer DOM.KeyboardEvent
onKeyUp' = makeProducer Types.OnKeyUp eventToKeyboardEvent

onLoad ∷ Producer DOM.Event
onLoad = makeProducer Types.OnLoad id

onMouseDown ∷ Producer DOM.MouseEvent
onMouseDown = makeProducer Types.OnMouseDown eventToMouseEvent

onMouseEnter ∷ Producer DOM.MouseEvent
onMouseEnter = makeProducer Types.OnMouseEnter eventToMouseEvent

onMouseLeave ∷ Producer DOM.MouseEvent
onMouseLeave = makeProducer Types.OnMouseLeave eventToMouseEvent

onMouseMove ∷ Producer DOM.MouseEvent
onMouseMove = makeProducer Types.OnMouseMove eventToMouseEvent

onMouseOver ∷ Producer DOM.MouseEvent
onMouseOver = makeProducer Types.OnMouseOver eventToMouseEvent

onMouseOut ∷ Producer DOM.MouseEvent
onMouseOut = makeProducer Types.OnMouseOut eventToMouseEvent

onMouseUp ∷ Producer DOM.MouseEvent
onMouseUp = makeProducer Types.OnMouseUp eventToMouseEvent

onReset ∷ Producer DOM.Event
onReset = makeProducer Types.OnReset id

onScroll ∷ Producer DOM.Event
onScroll = makeProducer Types.OnScroll id

onSelect ∷ Producer String
onSelect handler = makeProducer' Types.OnSelect (targetValue handler)

onSelect' ∷ Producer DOM.Event
onSelect' = makeProducer Types.OnSelect id

onSubmit ∷ Producer DOM.Event
onSubmit = makeProducer Types.OnSubmit id

onTransitionEnd ∷ Producer DOM.Event
onTransitionEnd = makeProducer Types.OnTransitionEnd id

-- | Static properties are those whose `update state event` triple can be
-- | anything.
type StaticProperty
  = ∀ update state event
  . Types.Property update state event

make ∷ String → String → StaticProperty
make key value'
  = Types.PropertyStatic
      { key
      , value: value'
      }

accept ∷ String → StaticProperty
accept = make "accept"

action ∷ String → StaticProperty
action = make "action"

align ∷ String → StaticProperty
align = make "align"

alt ∷ String → StaticProperty
alt = make "alt"

async ∷ String → StaticProperty
async = make "async"

autocomplete ∷ String → StaticProperty
autocomplete = make "autocomplete"

autofocus ∷ String → StaticProperty
autofocus = make "autofocus"

autoplay ∷ String → StaticProperty
autoplay = make "autoplay"

bgcolor ∷ String → StaticProperty
bgcolor = make "bgcolor"

border ∷ String → StaticProperty
border = make "border"

buffered ∷ String → StaticProperty
buffered = make "buffered"

challenge ∷ String → StaticProperty
challenge = make "challenge"

charset ∷ String → StaticProperty
charset = make "charset"

checked ∷ String → StaticProperty
checked = make "checked"

cite ∷ String → StaticProperty
cite = make "cite"

className ∷ String → StaticProperty
className = make "className"

code ∷ String → StaticProperty
code = make "code"

codebase ∷ String → StaticProperty
codebase = make "codebase"

color ∷ String → StaticProperty
color = make "color"

cols ∷ String → StaticProperty
cols = make "cols"

colspan ∷ String → StaticProperty
colspan = make "colspan"

content ∷ String → StaticProperty
content = make "content"

contextmenu ∷ String → StaticProperty
contextmenu = make "contextmenu"

controls ∷ String → StaticProperty
controls = make "controls"

coords ∷ String → StaticProperty
coords = make "coords"

crossorigin ∷ String → StaticProperty
crossorigin = make "crossorigin"

data_ ∷ String → StaticProperty
data_ = make "data_"

datetime ∷ String → StaticProperty
datetime = make "datetime"

default ∷ String → StaticProperty
default = make "default"

defer ∷ String → StaticProperty
defer = make "defer"

dirname ∷ String → StaticProperty
dirname = make "dirname"

disabled ∷ String → StaticProperty
disabled = make "disabled"

download ∷ String → StaticProperty
download = make "download"

enctype ∷ String → StaticProperty
enctype = make "enctype"

for ∷ String → StaticProperty
for = make "for"

form ∷ String → StaticProperty
form = make "form"

formaction ∷ String → StaticProperty
formaction = make "formaction"

headers ∷ String → StaticProperty
headers = make "headers"

height ∷ String → StaticProperty
height = make "height"

high ∷ String → StaticProperty
high = make "high"

href ∷ String → StaticProperty
href = make "href"

hreflang ∷ String → StaticProperty
hreflang = make "hreflang"

http ∷ String → StaticProperty
http = make "http"

icon ∷ String → StaticProperty
icon = make "icon"

integrity ∷ String → StaticProperty
integrity = make "integrity"

ismap ∷ String → StaticProperty
ismap = make "ismap"

keytype ∷ String → StaticProperty
keytype = make "keytype"

kind ∷ String → StaticProperty
kind = make "kind"

label ∷ String → StaticProperty
label = make "label"

language ∷ String → StaticProperty
language = make "language"

list ∷ String → StaticProperty
list = make "list"

loop ∷ String → StaticProperty
loop = make "loop"

low ∷ String → StaticProperty
low = make "low"

manifest ∷ String → StaticProperty
manifest = make "manifest"

max ∷ String → StaticProperty
max = make "max"

maxlength ∷ String → StaticProperty
maxlength = make "maxlength"

minlength ∷ String → StaticProperty
minlength = make "minlength"

media ∷ String → StaticProperty
media = make "media"

method ∷ String → StaticProperty
method = make "method"

min ∷ String → StaticProperty
min = make "min"

multiple ∷ String → StaticProperty
multiple = make "multiple"

muted ∷ String → StaticProperty
muted = make "muted"

name ∷ String → StaticProperty
name = make "name"

novalidate ∷ String → StaticProperty
novalidate = make "novalidate"

open ∷ String → StaticProperty
open = make "open"

optimum ∷ String → StaticProperty
optimum = make "optimum"

pattern ∷ String → StaticProperty
pattern = make "pattern"

ping ∷ String → StaticProperty
ping = make "ping"

placeholder ∷ String → StaticProperty
placeholder = make "placeholder"

poster ∷ String → StaticProperty
poster = make "poster"

preload ∷ String → StaticProperty
preload = make "preload"

radiogroup ∷ String → StaticProperty
radiogroup = make "radiogroup"

readonly ∷ String → StaticProperty
readonly = make "readonly"

rel ∷ String → StaticProperty
rel = make "rel"

required ∷ String → StaticProperty
required = make "required"

reversed ∷ String → StaticProperty
reversed = make "reversed"

rows ∷ String → StaticProperty
rows = make "rows"

rowspan ∷ String → StaticProperty
rowspan = make "rowspan"

sandbox ∷ String → StaticProperty
sandbox = make "sandbox"

scope ∷ String → StaticProperty
scope = make "scope"

scoped ∷ String → StaticProperty
scoped = make "scoped"

seamless ∷ String → StaticProperty
seamless = make "seamless"

selected ∷ String → StaticProperty
selected = make "selected"

shape ∷ String → StaticProperty
shape = make "shape"

size ∷ String → StaticProperty
size = make "size"

sizes ∷ String → StaticProperty
sizes = make "sizes"

span ∷ String → StaticProperty
span = make "span"

src ∷ String → StaticProperty
src = make "src"

srcdoc ∷ String → StaticProperty
srcdoc = make "srcdoc"

srclang ∷ String → StaticProperty
srclang = make "srclang"

srcset ∷ String → StaticProperty
srcset = make "srcset"

start ∷ String → StaticProperty
start = make "start"

step ∷ String → StaticProperty
step = make "step"

summary ∷ String → StaticProperty
summary = make "summary"

target ∷ String → StaticProperty
target = make "target"

type_ ∷ String → StaticProperty
type_ = make "type"

usemap ∷ String → StaticProperty
usemap = make "usemap"

value ∷ String → StaticProperty
value = make "value"

width ∷ String → StaticProperty
width = make "width"

wrap ∷ String → StaticProperty
wrap = make "wrap"
