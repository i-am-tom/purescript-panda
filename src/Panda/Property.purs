module Panda.Property
  ( module Panda.Property
  , module Watchers
  , module ExportedTypes

  , onBlur
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

  , accept
  , action
  , align
  , alt
  , async
  , autocomplete
  , autofocus
  , autoplay
  , bgcolor
  , border
  , buffered
  , challenge
  , charset
  , checked
  , cite
  , className
  , code
  , codebase
  , color
  , cols
  , colspan
  , content
  , contextmenu
  , controls
  , coords
  , crossorigin
  , data_
  , datetime
  , default
  , defer
  , dirname
  , disabled
  , download
  , enctype
  , for
  , form
  , formaction
  , headers
  , height
  , high
  , href
  , hreflang
  , http
  , icon
  , integrity
  , ismap
  , keytype
  , kind
  , label
  , language
  , list
  , loop
  , low
  , manifest
  , max
  , maxlength
  , minlength
  , media
  , method
  , min
  , multiple
  , muted
  , name
  , novalidate
  , open
  , optimum
  , pattern
  , ping
  , placeholder
  , poster
  , preload
  , radiogroup
  , readonly
  , rel
  , required
  , reversed
  , rows
  , rowspan
  , sandbox
  , scope
  , scoped
  , seamless
  , selected
  , shape
  , size
  , sizes
  , span
  , src
  , srcdoc
  , srclang
  , srcset
  , start
  , step
  , summary
  , target
  , type_
  , usemap
  , value
  , width
  ) where

import Control.Monad.Except (runExcept)
import DOM.Event.Types (Event, FocusEvent, KeyboardEvent, MouseEvent) as DOM
import DOM.HTML.Event.Types (DragEvent, ErrorEvent) as DOM
import Data.Either (either)
import Data.Foreign (readInt, readString, toForeign) as F
import Data.Foreign.Index (readProp) as F
import Data.Maybe (Maybe(..))
import Panda.Internal.Types as Types
import Panda.Internal.Types (Properties(..), Property(..), PropertyUpdate(..)) as ExportedTypes
import Panda.Property.Watchers as Watchers
import Unsafe.Coerce (unsafeCoerce)

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

-- | This type is used to hide this nonsense from the user.
type StaticProperty = ∀ event. Types.Property event

-- | Make a property.
make ∷ String → String → StaticProperty
make key setting
  = Types.PropertyFixed
      { key
      , value: setting
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
className = make "class"

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
