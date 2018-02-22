module Panda.HTML.Elements where

import Panda.Internal.Types as Types
import Prelude              (($))

type StaticElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event

type StaticElementWithoutProperties
  = ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event

make
  ∷ String
  → StaticElement
make tagName properties children
  = Types.CStatic
      $ Types.ComponentStatic
          { properties
          , children
          , tagName
          }

a ∷ StaticElement
a = make "a"

a_ ∷ StaticElementWithoutProperties
a_ = a []

abbr ∷ StaticElement
abbr = make "abbr"

abbr_ ∷ StaticElementWithoutProperties
abbr_ = abbr []

acronym ∷ StaticElement
acronym = make "acronym"

acronym_ ∷ StaticElementWithoutProperties
acronym_ = acronym []

address ∷ StaticElement
address = make "address"

address_ ∷ StaticElementWithoutProperties
address_ = address []

applet ∷ StaticElement
applet = make "applet"

applet_ ∷ StaticElementWithoutProperties
applet_ = applet []

area ∷ StaticElement
area = make "area"

area_ ∷ StaticElementWithoutProperties
area_ = area []

article ∷ StaticElement
article = make "article"

article_ ∷ StaticElementWithoutProperties
article_ = article []

aside ∷ StaticElement
aside = make "aside"

aside_ ∷ StaticElementWithoutProperties
aside_ = aside []

audio ∷ StaticElement
audio = make "audio"

audio_ ∷ StaticElementWithoutProperties
audio_ = audio []

b ∷ StaticElement
b = make "b"

b_ ∷ StaticElementWithoutProperties
b_ = b []

base ∷ StaticElement
base = make "base"

base_ ∷ StaticElementWithoutProperties
base_ = base []

basefont ∷ StaticElement
basefont = make "basefont"

basefont_ ∷ StaticElementWithoutProperties
basefont_ = basefont []

bdi ∷ StaticElement
bdi = make "bdi"

bdi_ ∷ StaticElementWithoutProperties
bdi_ = bdi []

bdo ∷ StaticElement
bdo = make "bdo"

bdo_ ∷ StaticElementWithoutProperties
bdo_ = bdo []

big ∷ StaticElement
big = make "big"

big_ ∷ StaticElementWithoutProperties
big_ = big []

blockquote ∷ StaticElement
blockquote = make "blockquote"

blockquote_ ∷ StaticElementWithoutProperties
blockquote_ = blockquote []

body ∷ StaticElement
body = make "body"

body_ ∷ StaticElementWithoutProperties
body_ = body []

br ∷ StaticElement
br = make "br"

br_ ∷ StaticElementWithoutProperties
br_ = br []

button ∷ StaticElement
button = make "button"

button_ ∷ StaticElementWithoutProperties
button_ = button []

canvas ∷ StaticElement
canvas = make "canvas"

canvas_ ∷ StaticElementWithoutProperties
canvas_ = canvas []

caption ∷ StaticElement
caption = make "caption"

caption_ ∷ StaticElementWithoutProperties
caption_ = caption []

center ∷ StaticElement
center = make "center"

center_ ∷ StaticElementWithoutProperties
center_ = center []

cite ∷ StaticElement
cite = make "cite"

cite_ ∷ StaticElementWithoutProperties
cite_ = cite []

code ∷ StaticElement
code = make "code"

code_ ∷ StaticElementWithoutProperties
code_ = code []

col ∷ StaticElement
col = make "col"

col_ ∷ StaticElementWithoutProperties
col_ = col []

colgroup ∷ StaticElement
colgroup = make "colgroup"

colgroup_ ∷ StaticElementWithoutProperties
colgroup_ = colgroup []

datalist ∷ StaticElement
datalist = make "datalist"

datalist_ ∷ StaticElementWithoutProperties
datalist_ = datalist []

dd ∷ StaticElement
dd = make "dd"

dd_ ∷ StaticElementWithoutProperties
dd_ = dd []

del ∷ StaticElement
del = make "del"

del_ ∷ StaticElementWithoutProperties
del_ = del []

details ∷ StaticElement
details = make "details"

details_ ∷ StaticElementWithoutProperties
details_ = details []

dfn ∷ StaticElement
dfn = make "dfn"

dfn_ ∷ StaticElementWithoutProperties
dfn_ = dfn []

dialog ∷ StaticElement
dialog = make "dialog"

dialog_ ∷ StaticElementWithoutProperties
dialog_ = dialog []

dir ∷ StaticElement
dir = make "dir"

dir_ ∷ StaticElementWithoutProperties
dir_ = dir []

div ∷ StaticElement
div = make "div"

div_ ∷ StaticElementWithoutProperties
div_ = div []

dl ∷ StaticElement
dl = make "dl"

dl_ ∷ StaticElementWithoutProperties
dl_ = dl []

dt ∷ StaticElement
dt = make "dt"

dt_ ∷ StaticElementWithoutProperties
dt_ = dt []

em ∷ StaticElement
em = make "em"

em_ ∷ StaticElementWithoutProperties
em_ = em []

embed ∷ StaticElement
embed = make "embed"

embed_ ∷ StaticElementWithoutProperties
embed_ = embed []

fieldset ∷ StaticElement
fieldset = make "fieldset"

fieldset_ ∷ StaticElementWithoutProperties
fieldset_ = fieldset []

figcaption ∷ StaticElement
figcaption = make "figcaption"

figcaption_ ∷ StaticElementWithoutProperties
figcaption_ = figcaption []

figure ∷ StaticElement
figure = make "figure"

figure_ ∷ StaticElementWithoutProperties
figure_ = figure []

font ∷ StaticElement
font = make "font"

font_ ∷ StaticElementWithoutProperties
font_ = font []

footer ∷ StaticElement
footer = make "footer"

footer_ ∷ StaticElementWithoutProperties
footer_ = footer []

form ∷ StaticElement
form = make "form"

form_ ∷ StaticElementWithoutProperties
form_ = form []

frame ∷ StaticElement
frame = make "frame"

frame_ ∷ StaticElementWithoutProperties
frame_ = frame []

frameset ∷ StaticElement
frameset = make "frameset"

frameset_ ∷ StaticElementWithoutProperties
frameset_ = frameset []

h1 ∷ StaticElement
h1 = make "h1"

h1_ ∷ StaticElementWithoutProperties
h1_ = h1 []

head ∷ StaticElement
head = make "head"

head_ ∷ StaticElementWithoutProperties
head_ = head []

header ∷ StaticElement
header = make "header"

header_ ∷ StaticElementWithoutProperties
header_ = header []

hr ∷ StaticElement
hr = make "hr"

hr_ ∷ StaticElementWithoutProperties
hr_ = hr []

html ∷ StaticElement
html = make "html"

html_ ∷ StaticElementWithoutProperties
html_ = html []

i ∷ StaticElement
i = make "i"

i_ ∷ StaticElementWithoutProperties
i_ = i []

iframe ∷ StaticElement
iframe = make "iframe"

iframe_ ∷ StaticElementWithoutProperties
iframe_ = iframe []

img ∷ StaticElement
img = make "img"

img_ ∷ StaticElementWithoutProperties
img_ = img []

input ∷ StaticElement
input = make "input"

input_ ∷ StaticElementWithoutProperties
input_ = input []

ins ∷ StaticElement
ins = make "ins"

ins_ ∷ StaticElementWithoutProperties
ins_ = ins []

kbd ∷ StaticElement
kbd = make "kbd"

kbd_ ∷ StaticElementWithoutProperties
kbd_ = kbd []

label ∷ StaticElement
label = make "label"

label_ ∷ StaticElementWithoutProperties
label_ = label []

legend ∷ StaticElement
legend = make "legend"

legend_ ∷ StaticElementWithoutProperties
legend_ = legend []

li ∷ StaticElement
li = make "li"

li_ ∷ StaticElementWithoutProperties
li_ = li []

link ∷ StaticElement
link = make "link"

link_ ∷ StaticElementWithoutProperties
link_ = link []

main ∷ StaticElement
main = make "main"

main_ ∷ StaticElementWithoutProperties
main_ = main []

map ∷ StaticElement
map = make "map"

map_ ∷ StaticElementWithoutProperties
map_ = map []

mark ∷ StaticElement
mark = make "mark"

mark_ ∷ StaticElementWithoutProperties
mark_ = mark []

menu ∷ StaticElement
menu = make "menu"

menu_ ∷ StaticElementWithoutProperties
menu_ = menu []

menuitem ∷ StaticElement
menuitem = make "menuitem"

menuitem_ ∷ StaticElementWithoutProperties
menuitem_ = menuitem []

meta ∷ StaticElement
meta = make "meta"

meta_ ∷ StaticElementWithoutProperties
meta_ = meta []

meter ∷ StaticElement
meter = make "meter"

meter_ ∷ StaticElementWithoutProperties
meter_ = meter []

nav ∷ StaticElement
nav = make "nav"

nav_ ∷ StaticElementWithoutProperties
nav_ = nav []

noframes ∷ StaticElement
noframes = make "noframes"

noframes_ ∷ StaticElementWithoutProperties
noframes_ = noframes []

noscript ∷ StaticElement
noscript = make "noscript"

noscript_ ∷ StaticElementWithoutProperties
noscript_ = noscript []

object ∷ StaticElement
object = make "object"

object_ ∷ StaticElementWithoutProperties
object_ = object []

ol ∷ StaticElement
ol = make "ol"

ol_ ∷ StaticElementWithoutProperties
ol_ = ol []

optgroup ∷ StaticElement
optgroup = make "optgroup"

optgroup_ ∷ StaticElementWithoutProperties
optgroup_ = optgroup []

option ∷ StaticElement
option = make "option"

option_ ∷ StaticElementWithoutProperties
option_ = option []

output ∷ StaticElement
output = make "output"

output_ ∷ StaticElementWithoutProperties
output_ = output []

p ∷ StaticElement
p = make "p"

p_ ∷ StaticElementWithoutProperties
p_ = p []

param ∷ StaticElement
param = make "param"

param_ ∷ StaticElementWithoutProperties
param_ = param []

picture ∷ StaticElement
picture = make "picture"

picture_ ∷ StaticElementWithoutProperties
picture_ = picture []

pre ∷ StaticElement
pre = make "pre"

pre_ ∷ StaticElementWithoutProperties
pre_ = pre []

progress ∷ StaticElement
progress = make "progress"

progress_ ∷ StaticElementWithoutProperties
progress_ = progress []

q ∷ StaticElement
q = make "q"

q_ ∷ StaticElementWithoutProperties
q_ = q []

rp ∷ StaticElement
rp = make "rp"

rp_ ∷ StaticElementWithoutProperties
rp_ = rp []

rt ∷ StaticElement
rt = make "rt"

rt_ ∷ StaticElementWithoutProperties
rt_ = rt []

ruby ∷ StaticElement
ruby = make "ruby"

ruby_ ∷ StaticElementWithoutProperties
ruby_ = ruby []

s ∷ StaticElement
s = make "s"

s_ ∷ StaticElementWithoutProperties
s_ = s []

samp ∷ StaticElement
samp = make "samp"

samp_ ∷ StaticElementWithoutProperties
samp_ = samp []

script ∷ StaticElement
script = make "script"

script_ ∷ StaticElementWithoutProperties
script_ = script []

section ∷ StaticElement
section = make "section"

section_ ∷ StaticElementWithoutProperties
section_ = section []

select ∷ StaticElement
select = make "select"

select_ ∷ StaticElementWithoutProperties
select_ = select []

small ∷ StaticElement
small = make "small"

small_ ∷ StaticElementWithoutProperties
small_ = small []

source ∷ StaticElement
source = make "source"

source_ ∷ StaticElementWithoutProperties
source_ = source []

span ∷ StaticElement
span = make "span"

span_ ∷ StaticElementWithoutProperties
span_ = span []

strike ∷ StaticElement
strike = make "strike"

strike_ ∷ StaticElementWithoutProperties
strike_ = strike []

strong ∷ StaticElement
strong = make "strong"

strong_ ∷ StaticElementWithoutProperties
strong_ = strong []

style ∷ StaticElement
style = make "style"

style_ ∷ StaticElementWithoutProperties
style_ = style []

sub ∷ StaticElement
sub = make "sub"

sub_ ∷ StaticElementWithoutProperties
sub_ = sub []

summary ∷ StaticElement
summary = make "summary"

summary_ ∷ StaticElementWithoutProperties
summary_ = summary []

sup ∷ StaticElement
sup = make "sup"

sup_ ∷ StaticElementWithoutProperties
sup_ = sup []

table ∷ StaticElement
table = make "table"

table_ ∷ StaticElementWithoutProperties
table_ = table []

tbody ∷ StaticElement
tbody = make "tbody"

tbody_ ∷ StaticElementWithoutProperties
tbody_ = tbody []

td ∷ StaticElement
td = make "td"

td_ ∷ StaticElementWithoutProperties
td_ = td []

template ∷ StaticElement
template = make "template"

template_ ∷ StaticElementWithoutProperties
template_ = template []

text
  ∷ ∀ eff update state event
  . String
  → Types.Component eff update state event
text
  = Types.CText

textarea ∷ StaticElement
textarea = make "textarea"

textarea_ ∷ StaticElementWithoutProperties
textarea_ = textarea []

tfoot ∷ StaticElement
tfoot = make "tfoot"

tfoot_ ∷ StaticElementWithoutProperties
tfoot_ = tfoot []

th ∷ StaticElement
th = make "th"

th_ ∷ StaticElementWithoutProperties
th_ = th []

thead ∷ StaticElement
thead = make "thead"

thead_ ∷ StaticElementWithoutProperties
thead_ = thead []

time ∷ StaticElement
time = make "time"

time_ ∷ StaticElementWithoutProperties
time_ = time []

title ∷ StaticElement
title = make "title"

title_ ∷ StaticElementWithoutProperties
title_ = title []

tr ∷ StaticElement
tr = make "tr"

tr_ ∷ StaticElementWithoutProperties
tr_ = tr []

track ∷ StaticElement
track = make "track"

track_ ∷ StaticElementWithoutProperties
track_ = track []

tt ∷ StaticElement
tt = make "tt"

tt_ ∷ StaticElementWithoutProperties
tt_ = tt []

u ∷ StaticElement
u = make "u"

u_ ∷ StaticElementWithoutProperties
u_ = u []

ul ∷ StaticElement
ul = make "ul"

ul_ ∷ StaticElementWithoutProperties
ul_ = ul []

var ∷ StaticElement
var = make "var"

var_ ∷ StaticElementWithoutProperties
var_ = var []

video ∷ StaticElement
video = make "video"

video_ ∷ StaticElementWithoutProperties
video_ = video []

wbr ∷ StaticElement
wbr = make "wbr"

wbr_ ∷ StaticElementWithoutProperties
wbr_ = wbr []
