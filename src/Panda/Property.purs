module Panda.Property
  ( module Panda.Property
  , module Watchers
  ) where

import Control.Monad.Except    (runExcept)
import Data.Algebra.Map        as Algebra
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

          targetProp ← F.readProp "target" ev'
          valueProp  ← F.readProp "value" targetProp

          F.readString valueProp
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

-- | Properties are a weird combination of HTML attributes and node properties.
-- | This type is used to hide this nonsense from the user.
type StaticProperty
  = ∀ update state event
  . Types.Property update state event

make ∷ String → String → StaticProperty
make key setting
  = Types.PropertyStatic
      { key
      , value: setting
      }

type Property update state
  = ∀ event
  . Types.Property update state event

type DynamicValue update state
  = { update ∷ update
    , state  ∷ state
    }
  → Maybe String

make'
  ∷ ∀ update state
  . String
  → DynamicValue update state
  → Property update state
make' key listener
  = Types.PropertyWatcher \info →
      [ case listener info of
          Just setting →
            Algebra.Add key setting

          Nothing →
            Algebra.Delete key
      ]

accept ∷ String → StaticProperty
accept = make "accept"

accept' ∷ ∀ update state. DynamicValue update state → Property update state
accept' = make' "accept"

action ∷ String → StaticProperty
action = make "action"

action' ∷ ∀ update state. DynamicValue update state → Property update state
action' = make' "action"

align ∷ String → StaticProperty
align = make "align"

align' ∷ ∀ update state. DynamicValue update state → Property update state
align' = make' "align"

alt ∷ String → StaticProperty
alt = make "alt"

alt' ∷ ∀ update state. DynamicValue update state → Property update state
alt' = make' "alt"

async ∷ String → StaticProperty
async = make "async"

async' ∷ ∀ update state. DynamicValue update state → Property update state
async' = make' "async"

autocomplete ∷ String → StaticProperty
autocomplete = make "autocomplete"

autocomplete' ∷ ∀ update state. DynamicValue update state → Property update state
autocomplete' = make' "autocomplete"

autofocus ∷ String → StaticProperty
autofocus = make "autofocus"

autofocus' ∷ ∀ update state. DynamicValue update state → Property update state
autofocus' = make' "autofocus"

autoplay ∷ String → StaticProperty
autoplay = make "autoplay"

autoplay' ∷ ∀ update state. DynamicValue update state → Property update state
autoplay' = make' "autoplay"

bgcolor ∷ String → StaticProperty
bgcolor = make "bgcolor"

bgcolor' ∷ ∀ update state. DynamicValue update state → Property update state
bgcolor' = make' "bgcolor"

border ∷ String → StaticProperty
border = make "border"

border' ∷ ∀ update state. DynamicValue update state → Property update state
border' = make' "border"

buffered ∷ String → StaticProperty
buffered = make "buffered"

buffered' ∷ ∀ update state. DynamicValue update state → Property update state
buffered' = make' "buffered"

challenge ∷ String → StaticProperty
challenge = make "challenge"

challenge' ∷ ∀ update state. DynamicValue update state → Property update state
challenge' = make' "challenge"

charset ∷ String → StaticProperty
charset = make "charset"

charset' ∷ ∀ update state. DynamicValue update state → Property update state
charset' = make' "charset"

checked ∷ String → StaticProperty
checked = make "checked"

checked' ∷ ∀ update state. DynamicValue update state → Property update state
checked' = make' "checked"

cite ∷ String → StaticProperty
cite = make "cite"

cite' ∷ ∀ update state. DynamicValue update state → Property update state
cite' = make' "cite"

className ∷ String → StaticProperty
className = make "className"

className' ∷ ∀ update state. DynamicValue update state → Property update state
className' = make' "className"

code ∷ String → StaticProperty
code = make "code"

code' ∷ ∀ update state. DynamicValue update state → Property update state
code' = make' "code"

codebase ∷ String → StaticProperty
codebase = make "codebase"

codebase' ∷ ∀ update state. DynamicValue update state → Property update state
codebase' = make' "codebase"

color ∷ String → StaticProperty
color = make "color"

color' ∷ ∀ update state. DynamicValue update state → Property update state
color' = make' "color"

cols ∷ String → StaticProperty
cols = make "cols"

cols' ∷ ∀ update state. DynamicValue update state → Property update state
cols' = make' "cols"

colspan ∷ String → StaticProperty
colspan = make "colspan"

colspan' ∷ ∀ update state. DynamicValue update state → Property update state
colspan' = make' "colspan"

content ∷ String → StaticProperty
content = make "content"

content' ∷ ∀ update state. DynamicValue update state → Property update state
content' = make' "content"

contextmenu ∷ String → StaticProperty
contextmenu = make "contextmenu"

contextmenu' ∷ ∀ update state. DynamicValue update state → Property update state
contextmenu' = make' "contextmenu"

controls ∷ String → StaticProperty
controls = make "controls"

controls' ∷ ∀ update state. DynamicValue update state → Property update state
controls' = make' "controls"

coords ∷ String → StaticProperty
coords = make "coords"

coords' ∷ ∀ update state. DynamicValue update state → Property update state
coords' = make' "coords"

crossorigin ∷ String → StaticProperty
crossorigin = make "crossorigin"

crossorigin' ∷ ∀ update state. DynamicValue update state → Property update state
crossorigin' = make' "crossorigin"

data_ ∷ String → StaticProperty
data_ = make "data_"

data_' ∷ ∀ update state. DynamicValue update state → Property update state
data_' = make' "data_"

datetime ∷ String → StaticProperty
datetime = make "datetime"

datetime' ∷ ∀ update state. DynamicValue update state → Property update state
datetime' = make' "datetime"

default ∷ String → StaticProperty
default = make "default"

default' ∷ ∀ update state. DynamicValue update state → Property update state
default' = make' "default"

defer ∷ String → StaticProperty
defer = make "defer"

defer' ∷ ∀ update state. DynamicValue update state → Property update state
defer' = make' "defer"

dirname ∷ String → StaticProperty
dirname = make "dirname"

dirname' ∷ ∀ update state. DynamicValue update state → Property update state
dirname' = make' "dirname"

disabled ∷ String → StaticProperty
disabled = make "disabled"

disabled' ∷ ∀ update state. DynamicValue update state → Property update state
disabled' = make' "disabled"

download ∷ String → StaticProperty
download = make "download"

download' ∷ ∀ update state. DynamicValue update state → Property update state
download' = make' "download"

enctype ∷ String → StaticProperty
enctype = make "enctype"

enctype' ∷ ∀ update state. DynamicValue update state → Property update state
enctype' = make' "enctype"

for ∷ String → StaticProperty
for = make "for"

for' ∷ ∀ update state. DynamicValue update state → Property update state
for' = make' "for"

form ∷ String → StaticProperty
form = make "form"

form' ∷ ∀ update state. DynamicValue update state → Property update state
form' = make' "form"

formaction ∷ String → StaticProperty
formaction = make "formaction"

formaction' ∷ ∀ update state. DynamicValue update state → Property update state
formaction' = make' "formaction"

headers ∷ String → StaticProperty
headers = make "headers"

headers' ∷ ∀ update state. DynamicValue update state → Property update state
headers' = make' "headers"

height ∷ String → StaticProperty
height = make "height"

height' ∷ ∀ update state. DynamicValue update state → Property update state
height' = make' "height"

high ∷ String → StaticProperty
high = make "high"

high' ∷ ∀ update state. DynamicValue update state → Property update state
high' = make' "high"

href ∷ String → StaticProperty
href = make "href"

href' ∷ ∀ update state. DynamicValue update state → Property update state
href' = make' "href"

hreflang ∷ String → StaticProperty
hreflang = make "hreflang"

hreflang' ∷ ∀ update state. DynamicValue update state → Property update state
hreflang' = make' "hreflang"

http ∷ String → StaticProperty
http = make "http"

http' ∷ ∀ update state. DynamicValue update state → Property update state
http' = make' "http"

icon ∷ String → StaticProperty
icon = make "icon"

icon' ∷ ∀ update state. DynamicValue update state → Property update state
icon' = make' "icon"

integrity ∷ String → StaticProperty
integrity = make "integrity"

integrity' ∷ ∀ update state. DynamicValue update state → Property update state
integrity' = make' "integrity"

ismap ∷ String → StaticProperty
ismap = make "ismap"

ismap' ∷ ∀ update state. DynamicValue update state → Property update state
ismap' = make' "ismap"

keytype ∷ String → StaticProperty
keytype = make "keytype"

keytype' ∷ ∀ update state. DynamicValue update state → Property update state
keytype' = make' "keytype"

kind ∷ String → StaticProperty
kind = make "kind"

kind' ∷ ∀ update state. DynamicValue update state → Property update state
kind' = make' "kind"

label ∷ String → StaticProperty
label = make "label"

label' ∷ ∀ update state. DynamicValue update state → Property update state
label' = make' "label"

language ∷ String → StaticProperty
language = make "language"

language' ∷ ∀ update state. DynamicValue update state → Property update state
language' = make' "language"

list ∷ String → StaticProperty
list = make "list"

list' ∷ ∀ update state. DynamicValue update state → Property update state
list' = make' "list"

loop ∷ String → StaticProperty
loop = make "loop"

loop' ∷ ∀ update state. DynamicValue update state → Property update state
loop' = make' "loop"

low ∷ String → StaticProperty
low = make "low"

low' ∷ ∀ update state. DynamicValue update state → Property update state
low' = make' "low"

manifest ∷ String → StaticProperty
manifest = make "manifest"

manifest' ∷ ∀ update state. DynamicValue update state → Property update state
manifest' = make' "manifest"

max ∷ String → StaticProperty
max = make "max"

max' ∷ ∀ update state. DynamicValue update state → Property update state
max' = make' "max"

maxlength ∷ String → StaticProperty
maxlength = make "maxlength"

maxlength' ∷ ∀ update state. DynamicValue update state → Property update state
maxlength' = make' "maxlength"

minlength ∷ String → StaticProperty
minlength = make "minlength"

minlength' ∷ ∀ update state. DynamicValue update state → Property update state
minlength' = make' "minlength"

media ∷ String → StaticProperty
media = make "media"

media' ∷ ∀ update state. DynamicValue update state → Property update state
media' = make' "media"

method ∷ String → StaticProperty
method = make "method"

method' ∷ ∀ update state. DynamicValue update state → Property update state
method' = make' "method"

min ∷ String → StaticProperty
min = make "min"

min' ∷ ∀ update state. DynamicValue update state → Property update state
min' = make' "min"

multiple ∷ String → StaticProperty
multiple = make "multiple"

multiple' ∷ ∀ update state. DynamicValue update state → Property update state
multiple' = make' "multiple"

muted ∷ String → StaticProperty
muted = make "muted"

muted' ∷ ∀ update state. DynamicValue update state → Property update state
muted' = make' "muted"

name ∷ String → StaticProperty
name = make "name"

name' ∷ ∀ update state. DynamicValue update state → Property update state
name' = make' "name"

novalidate ∷ String → StaticProperty
novalidate = make "novalidate"

novalidate' ∷ ∀ update state. DynamicValue update state → Property update state
novalidate' = make' "novalidate"

open ∷ String → StaticProperty
open = make "open"

open' ∷ ∀ update state. DynamicValue update state → Property update state
open' = make' "open"

optimum ∷ String → StaticProperty
optimum = make "optimum"

optimum' ∷ ∀ update state. DynamicValue update state → Property update state
optimum' = make' "optimum"

pattern ∷ String → StaticProperty
pattern = make "pattern"

pattern' ∷ ∀ update state. DynamicValue update state → Property update state
pattern' = make' "pattern"

ping ∷ String → StaticProperty
ping = make "ping"

ping' ∷ ∀ update state. DynamicValue update state → Property update state
ping' = make' "ping"

placeholder ∷ String → StaticProperty
placeholder = make "placeholder"

placeholder' ∷ ∀ update state. DynamicValue update state → Property update state
placeholder' = make' "placeholder"

poster ∷ String → StaticProperty
poster = make "poster"

poster' ∷ ∀ update state. DynamicValue update state → Property update state
poster' = make' "poster"

preload ∷ String → StaticProperty
preload = make "preload"

preload' ∷ ∀ update state. DynamicValue update state → Property update state
preload' = make' "preload"

radiogroup ∷ String → StaticProperty
radiogroup = make "radiogroup"

radiogroup' ∷ ∀ update state. DynamicValue update state → Property update state
radiogroup' = make' "radiogroup"

readonly ∷ String → StaticProperty
readonly = make "readonly"

readonly' ∷ ∀ update state. DynamicValue update state → Property update state
readonly' = make' "readonly"

rel ∷ String → StaticProperty
rel = make "rel"

rel' ∷ ∀ update state. DynamicValue update state → Property update state
rel' = make' "rel"

required ∷ String → StaticProperty
required = make "required"

required' ∷ ∀ update state. DynamicValue update state → Property update state
required' = make' "required"

reversed ∷ String → StaticProperty
reversed = make "reversed"

reversed' ∷ ∀ update state. DynamicValue update state → Property update state
reversed' = make' "reversed"

rows ∷ String → StaticProperty
rows = make "rows"

rows' ∷ ∀ update state. DynamicValue update state → Property update state
rows' = make' "rows"

rowspan ∷ String → StaticProperty
rowspan = make "rowspan"

rowspan' ∷ ∀ update state. DynamicValue update state → Property update state
rowspan' = make' "rowspan"

sandbox ∷ String → StaticProperty
sandbox = make "sandbox"

sandbox' ∷ ∀ update state. DynamicValue update state → Property update state
sandbox' = make' "sandbox"

scope ∷ String → StaticProperty
scope = make "scope"

scope' ∷ ∀ update state. DynamicValue update state → Property update state
scope' = make' "scope"

scoped ∷ String → StaticProperty
scoped = make "scoped"

scoped' ∷ ∀ update state. DynamicValue update state → Property update state
scoped' = make' "scoped"

seamless ∷ String → StaticProperty
seamless = make "seamless"

seamless' ∷ ∀ update state. DynamicValue update state → Property update state
seamless' = make' "seamless"

selected ∷ String → StaticProperty
selected = make "selected"

selected' ∷ ∀ update state. DynamicValue update state → Property update state
selected' = make' "selected"

shape ∷ String → StaticProperty
shape = make "shape"

shape' ∷ ∀ update state. DynamicValue update state → Property update state
shape' = make' "shape"

size ∷ String → StaticProperty
size = make "size"

size' ∷ ∀ update state. DynamicValue update state → Property update state
size' = make' "size"

sizes ∷ String → StaticProperty
sizes = make "sizes"

sizes' ∷ ∀ update state. DynamicValue update state → Property update state
sizes' = make' "sizes"

span ∷ String → StaticProperty
span = make "span"

span' ∷ ∀ update state. DynamicValue update state → Property update state
span' = make' "span"

src ∷ String → StaticProperty
src = make "src"

src' ∷ ∀ update state. DynamicValue update state → Property update state
src' = make' "src"

srcdoc ∷ String → StaticProperty
srcdoc = make "srcdoc"

srcdoc' ∷ ∀ update state. DynamicValue update state → Property update state
srcdoc' = make' "srcdoc"

srclang ∷ String → StaticProperty
srclang = make "srclang"

srclang' ∷ ∀ update state. DynamicValue update state → Property update state
srclang' = make' "srclang"

srcset ∷ String → StaticProperty
srcset = make "srcset"

srcset' ∷ ∀ update state. DynamicValue update state → Property update state
srcset' = make' "srcset"

start ∷ String → StaticProperty
start = make "start"

start' ∷ ∀ update state. DynamicValue update state → Property update state
start' = make' "start"

step ∷ String → StaticProperty
step = make "step"

step' ∷ ∀ update state. DynamicValue update state → Property update state
step' = make' "step"

summary ∷ String → StaticProperty
summary = make "summary"

summary' ∷ ∀ update state. DynamicValue update state → Property update state
summary' = make' "summary"

target ∷ String → StaticProperty
target = make "target"

target' ∷ ∀ update state. DynamicValue update state → Property update state
target' = make' "target"

type_ ∷ String → StaticProperty
type_ = make "type"

type_' ∷ ∀ update state. DynamicValue update state → Property update state
type_' = make' "type"

usemap ∷ String → StaticProperty
usemap = make "usemap"

usemap' ∷ ∀ update state. DynamicValue update state → Property update state
usemap' = make' "usemap"

value ∷ String → StaticProperty
value = make "value"

value' ∷ ∀ update state. DynamicValue update state → Property update state
value' = make' "value"

width ∷ String → StaticProperty
width = make "width"

width' ∷ ∀ update state. DynamicValue update state → Property update state
width' = make' "width"

wrap ∷ String → StaticProperty
wrap = make "wrap"

wrap' ∷ ∀ update state. DynamicValue update state → Property update state
wrap' = make' "wrap"
