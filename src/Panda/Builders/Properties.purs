module Panda.Builders.Properties
  ( module ExportedTypes
  , module Producers
  , module Watchers

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

import Panda.Internal.Types as Types
import Panda.Internal.Types (Properties(..), Property(..), PropertyUpdate(..)) as ExportedTypes
import Panda.Builders.Property.Producers as Producers
import Panda.Builders.Property.Watchers as Watchers

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
