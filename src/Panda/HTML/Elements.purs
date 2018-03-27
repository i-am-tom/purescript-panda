module Panda.HTML.Elements where

import Panda.Internal.Types as Types

type Element
  = ∀ eff update state event
  . Types.Properties     update state event
  → Types.Children   eff update state event
  → Types.Component  eff update state event

type StaticElement
  = ∀ eff update state event
  . Array (Types.Property                   event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event

type ElementNoProperties
  = ∀ eff update state event
  . Types.Children  eff update state event
  → Types.Component eff update state event

type StaticElementNoProperties
  = ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event

type ElementSelfClosing
  = ∀ eff update state event
  . Types.Properties update state event
  → Types.Component eff update state event

type StaticElementSelfClosing
  = ∀ eff update state event
  . Array (Types.Property event)
  → Types.Component eff update state event

type StaticElementSelfClosingNoProperties
  = ∀ eff update state event
  . Types.Component eff update state event


make' ∷ String → Element
make' tagName properties children
  = Types.ComponentElement
      { tagName
      , properties
      , children
      }

make ∷ String → StaticElement
make tagName properties children
  = make' tagName
      (Types.StaticProperties properties)
      (Types.StaticChildren children)

make'_ ∷ String → ElementNoProperties
make'_ tagName children
  = make' tagName (Types.StaticProperties []) children

make_ ∷ String → StaticElementNoProperties
make_ tagName children
  = make tagName [] children

a ∷ StaticElement
a = make "a"

a' ∷ Element
a' = make' "a"

a_ ∷ StaticElementNoProperties
a_ = a []

a'_ ∷ ElementNoProperties
a'_ = a' (Types.StaticProperties [])

abbr ∷ StaticElement
abbr = make "abbr"

abbr' ∷ Element
abbr' = make' "abbr"

abbr_ ∷ StaticElementNoProperties
abbr_ = abbr []

abbr'_ ∷ ElementNoProperties
abbr'_ = abbr' (Types.StaticProperties [])

acronym ∷ StaticElement
acronym = make "acronym"

acronym' ∷ Element
acronym' = make' "acronym"

acronym_ ∷ StaticElementNoProperties
acronym_ = acronym []

acronym'_ ∷ ElementNoProperties
acronym'_ = acronym' (Types.StaticProperties [])

address ∷ StaticElement
address = make "address"

address' ∷ Element
address' = make' "address"

address_ ∷ StaticElementNoProperties
address_ = address []

address'_ ∷ ElementNoProperties
address'_ = address' (Types.StaticProperties [])

applet ∷ StaticElement
applet = make "applet"

applet' ∷ Element
applet' = make' "applet"

applet_ ∷ StaticElementNoProperties
applet_ = applet []

applet'_ ∷ ElementNoProperties
applet'_ = applet' (Types.StaticProperties [])

area ∷ StaticElementSelfClosing
area props = make "area" props []

area' ∷ ElementSelfClosing
area' props = make' "area" props (Types.StaticChildren [])

area_ ∷ StaticElementSelfClosingNoProperties
area_ = area []

article ∷ StaticElement
article = make "article"

article' ∷ Element
article' = make' "article"

article_ ∷ StaticElementNoProperties
article_ = article []

article'_ ∷ ElementNoProperties
article'_ = article' (Types.StaticProperties [])

aside ∷ StaticElement
aside = make "aside"

aside' ∷ Element
aside' = make' "aside"

aside_ ∷ StaticElementNoProperties
aside_ = aside []

aside'_ ∷ ElementNoProperties
aside'_ = aside' (Types.StaticProperties [])

audio ∷ StaticElement
audio = make "audio"

audio' ∷ Element
audio' = make' "audio"

audio_ ∷ StaticElementNoProperties
audio_ = audio []

audio'_ ∷ ElementNoProperties
audio'_ = audio' (Types.StaticProperties [])

b ∷ StaticElement
b = make "b"

b' ∷ Element
b' = make' "b"

b_ ∷ StaticElementNoProperties
b_ = b []

b'_ ∷ ElementNoProperties
b'_ = b' (Types.StaticProperties [])

base ∷ StaticElementSelfClosing
base props = make "base" props []

base' ∷ ElementSelfClosing
base' props = make' "base" props (Types.StaticChildren [])

base_ ∷ StaticElementSelfClosingNoProperties
base_ = base []

basefont ∷ StaticElement
basefont = make "basefont"

basefont' ∷ Element
basefont' = make' "basefont"

basefont_ ∷ StaticElementNoProperties
basefont_ = basefont []

basefont'_ ∷ ElementNoProperties
basefont'_ = basefont' (Types.StaticProperties [])

bdi ∷ StaticElement
bdi = make "bdi"

bdi' ∷ Element
bdi' = make' "bdi"

bdi_ ∷ StaticElementNoProperties
bdi_ = bdi []

bdi'_ ∷ ElementNoProperties
bdi'_ = bdi' (Types.StaticProperties [])

bdo ∷ StaticElement
bdo = make "bdo"

bdo' ∷ Element
bdo' = make' "bdo"

bdo_ ∷ StaticElementNoProperties
bdo_ = bdo []

bdo'_ ∷ ElementNoProperties
bdo'_ = bdo' (Types.StaticProperties [])

big ∷ StaticElement
big = make "big"

big' ∷ Element
big' = make' "big"

big_ ∷ StaticElementNoProperties
big_ = big []

big'_ ∷ ElementNoProperties
big'_ = big' (Types.StaticProperties [])

blockquote ∷ StaticElement
blockquote = make "blockquote"

blockquote' ∷ Element
blockquote' = make' "blockquote"

blockquote_ ∷ StaticElementNoProperties
blockquote_ = blockquote []

blockquote'_ ∷ ElementNoProperties
blockquote'_ = blockquote' (Types.StaticProperties [])

br ∷ StaticElementSelfClosing
br props = make "br" props []

br' ∷ ElementSelfClosing
br' props = make' "br" props (Types.StaticChildren [])

br_ ∷ StaticElementSelfClosingNoProperties
br_ = br []

button ∷ StaticElement
button = make "button"

button' ∷ Element
button' = make' "button"

button_ ∷ StaticElementNoProperties
button_ = button []

button'_ ∷ ElementNoProperties
button'_ = button' (Types.StaticProperties [])

canvas ∷ StaticElement
canvas = make "canvas"

canvas' ∷ Element
canvas' = make' "canvas"

canvas_ ∷ StaticElementNoProperties
canvas_ = canvas []

canvas'_ ∷ ElementNoProperties
canvas'_ = canvas' (Types.StaticProperties [])

caption ∷ StaticElement
caption = make "caption"

caption' ∷ Element
caption' = make' "caption"

caption_ ∷ StaticElementNoProperties
caption_ = caption []

caption'_ ∷ ElementNoProperties
caption'_ = caption' (Types.StaticProperties [])

center ∷ StaticElement
center = make "center"

center' ∷ Element
center' = make' "center"

center_ ∷ StaticElementNoProperties
center_ = center []

cite ∷ StaticElement
cite = make "cite"

cite' ∷ Element
cite' = make' "cite"

cite_ ∷ StaticElementNoProperties
cite_ = cite []

cite'_ ∷ ElementNoProperties
cite'_ = cite' (Types.StaticProperties [])

code ∷ StaticElement
code = make "code"

code' ∷ Element
code' = make' "code"

code_ ∷ StaticElementNoProperties
code_ = code []

col ∷ StaticElementSelfClosing
col props = make "col" props []

col' ∷ ElementSelfClosing
col' props = make' "col" props (Types.StaticChildren [])

col_ ∷ StaticElementSelfClosingNoProperties
col_ = col []

colgroup ∷ StaticElement
colgroup = make "colgroup"

colgroup' ∷ Element
colgroup' = make' "colgroup"

colgroup_ ∷ StaticElementNoProperties
colgroup_ = colgroup []

colgroup'_ ∷ ElementNoProperties
colgroup'_ = colgroup' (Types.StaticProperties [])

command ∷ StaticElementSelfClosing
command props = make "command" props []

command' ∷ ElementSelfClosing
command' props = make' "command" props (Types.StaticChildren [])

command_ ∷ StaticElementSelfClosingNoProperties
command_ = command []

datalist ∷ StaticElement
datalist = make "datalist"

datalist' ∷ Element
datalist' = make' "datalist"

datalist_ ∷ StaticElementNoProperties
datalist_ = datalist []

datalist'_ ∷ ElementNoProperties
datalist'_ = datalist' (Types.StaticProperties [])

dd ∷ StaticElement
dd = make "dd"

dd' ∷ Element
dd' = make' "dd"

dd_ ∷ StaticElementNoProperties
dd_ = dd []

dd'_ ∷ ElementNoProperties
dd'_ = dd' (Types.StaticProperties [])

del ∷ StaticElement
del = make "del"

del' ∷ Element
del' = make' "del"

del_ ∷ StaticElementNoProperties
del_ = del []

del'_ ∷ ElementNoProperties
del'_ = del' (Types.StaticProperties [])

details ∷ StaticElement
details = make "details"

details' ∷ Element
details' = make' "details"

details_ ∷ StaticElementNoProperties
details_ = details []

details'_ ∷ ElementNoProperties
details'_ = details' (Types.StaticProperties [])

dfn ∷ StaticElement
dfn = make "dfn"

dfn' ∷ Element
dfn' = make' "dfn"

dfn_ ∷ StaticElementNoProperties
dfn_ = dfn []

dfn'_ ∷ ElementNoProperties
dfn'_ = dfn' (Types.StaticProperties [])

dialog ∷ StaticElement
dialog = make "dialog"

dialog' ∷ Element
dialog' = make' "dialog"

dialog_ ∷ StaticElementNoProperties
dialog_ = dialog []

dialog'_ ∷ ElementNoProperties
dialog'_ = dialog' (Types.StaticProperties [])

dir ∷ StaticElement
dir = make "dir"

dir' ∷ Element
dir' = make' "dir"

dir_ ∷ StaticElementNoProperties
dir_ = dir []

dir'_ ∷ ElementNoProperties
dir'_ = dir' (Types.StaticProperties [])

div ∷ StaticElement
div = make "div"

div' ∷ Element
div' = make' "div"

div_ ∷ StaticElementNoProperties
div_ = div []

div'_ ∷ ElementNoProperties
div'_ = div' (Types.StaticProperties [])

dl ∷ StaticElement
dl = make "dl"

dl' ∷ Element
dl' = make' "dl"

dl_ ∷ StaticElementNoProperties
dl_ = dl []

dl'_ ∷ ElementNoProperties
dl'_ = dl' (Types.StaticProperties [])

dt ∷ StaticElement
dt = make "dt"

dt' ∷ Element
dt' = make' "dt"

dt_ ∷ StaticElementNoProperties
dt_ = dt []

dt'_ ∷ ElementNoProperties
dt'_ = dt' (Types.StaticProperties [])

em ∷ StaticElement
em = make "em"

em' ∷ Element
em' = make' "em"

em_ ∷ StaticElementNoProperties
em_ = em []

em'_ ∷ ElementNoProperties
em'_ = em' (Types.StaticProperties [])

embed ∷ StaticElementSelfClosing
embed props = make "embed" props []

embed' ∷ ElementSelfClosing
embed' props = make' "embed" props (Types.StaticChildren [])

embed_ ∷ StaticElementSelfClosingNoProperties
embed_ = embed []

fieldset ∷ StaticElement
fieldset = make "fieldset"

fieldset' ∷ Element
fieldset' = make' "fieldset"

fieldset_ ∷ StaticElementNoProperties
fieldset_ = fieldset []

fieldset'_ ∷ ElementNoProperties
fieldset'_ = fieldset' (Types.StaticProperties [])

figcaption ∷ StaticElement
figcaption = make "figcaption"

figcaption' ∷ Element
figcaption' = make' "figcaption"

figcaption_ ∷ StaticElementNoProperties
figcaption_ = figcaption []

figcaption'_ ∷ ElementNoProperties
figcaption'_ = figcaption' (Types.StaticProperties [])

figure ∷ StaticElement
figure = make "figure"

figure' ∷ Element
figure' = make' "figure"

figure_ ∷ StaticElementNoProperties
figure_ = figure []

figure'_ ∷ ElementNoProperties
figure'_ = figure' (Types.StaticProperties [])

font ∷ StaticElement
font = make "font"

font' ∷ Element
font' = make' "font"

font_ ∷ StaticElementNoProperties
font_ = font []

font'_ ∷ ElementNoProperties
font'_ = font' (Types.StaticProperties [])

footer ∷ StaticElement
footer = make "footer"

footer' ∷ Element
footer' = make' "footer"

footer_ ∷ StaticElementNoProperties
footer_ = footer []

footer'_ ∷ ElementNoProperties
footer'_ = footer' (Types.StaticProperties [])

form ∷ StaticElement
form = make "form"

form' ∷ Element
form' = make' "form"

form_ ∷ StaticElementNoProperties
form_ = form []

form'_ ∷ ElementNoProperties
form'_ = form' (Types.StaticProperties [])

frame ∷ StaticElement
frame = make "frame"

frame' ∷ Element
frame' = make' "frame"

frame_ ∷ StaticElementNoProperties
frame_ = frame []

frame'_ ∷ ElementNoProperties
frame'_ = frame' (Types.StaticProperties [])

frameset ∷ StaticElement
frameset = make "frameset"

frameset' ∷ Element
frameset' = make' "frameset"

frameset_ ∷ StaticElementNoProperties
frameset_ = frameset []

frameset'_ ∷ ElementNoProperties
frameset'_ = frameset' (Types.StaticProperties [])

h1 ∷ StaticElement
h1 = make "h1"

h1' ∷ Element
h1' = make' "h1"

h1_ ∷ StaticElementNoProperties
h1_ = h1 []

h1'_ ∷ ElementNoProperties
h1'_ = h1' (Types.StaticProperties [])

head ∷ StaticElement
head = make "head"

head' ∷ Element
head' = make' "head"

head_ ∷ StaticElementNoProperties
head_ = head []

head'_ ∷ ElementNoProperties
head'_ = head' (Types.StaticProperties [])

header ∷ StaticElement
header = make "header"

header' ∷ Element
header' = make' "header"

header_ ∷ StaticElementNoProperties
header_ = header []

header'_ ∷ ElementNoProperties
header'_ = header' (Types.StaticProperties [])

hr ∷ StaticElementSelfClosing
hr props = make "hr" props []

hr' ∷ ElementSelfClosing
hr' props = make' "hr" props (Types.StaticChildren [])

hr_ ∷ StaticElementSelfClosingNoProperties
hr_ = hr []

i ∷ StaticElement
i = make "i"

i' ∷ Element
i' = make' "i"

i_ ∷ StaticElementNoProperties
i_ = i []

i'_ ∷ ElementNoProperties
i'_ = i' (Types.StaticProperties [])

iframe ∷ StaticElement
iframe = make "iframe"

iframe' ∷ Element
iframe' = make' "iframe"

iframe_ ∷ StaticElementNoProperties
iframe_ = iframe []

iframe'_ ∷ ElementNoProperties
iframe'_ = iframe' (Types.StaticProperties [])

img ∷ StaticElementSelfClosing
img props = make "img" props []

img' ∷ ElementSelfClosing
img' props = make' "img" props (Types.StaticChildren [])

img_ ∷ StaticElementSelfClosingNoProperties
img_ = img []

input ∷ StaticElementSelfClosing
input props = make "input" props []

input' ∷ ElementSelfClosing
input' props = make' "input" props (Types.StaticChildren [])

input_ ∷ StaticElementSelfClosingNoProperties
input_ = input []

ins ∷ StaticElement
ins = make "ins"

ins' ∷ Element
ins' = make' "ins"

ins_ ∷ StaticElementNoProperties
ins_ = ins []

ins'_ ∷ ElementNoProperties
ins'_ = ins' (Types.StaticProperties [])

kbd ∷ StaticElement
kbd = make "kbd"

kbd' ∷ Element
kbd' = make' "kbd"

kbd_ ∷ StaticElementNoProperties
kbd_ = kbd []

kbd'_ ∷ ElementNoProperties
kbd'_ = kbd' (Types.StaticProperties [])

keygen ∷ StaticElementSelfClosing
keygen props = make "kbd" props []

keygen' ∷ ElementSelfClosing
keygen' props = make' "kbd" props (Types.StaticChildren [])

keygen_ ∷ StaticElementSelfClosingNoProperties
keygen_ = keygen []

label ∷ StaticElement
label = make "label"

label' ∷ Element
label' = make' "label"

label_ ∷ StaticElementNoProperties
label_ = label []

label'_ ∷ ElementNoProperties
label'_ = label' (Types.StaticProperties [])

legend ∷ StaticElement
legend = make "legend"

legend' ∷ Element
legend' = make' "legend"

legend_ ∷ StaticElementNoProperties
legend_ = legend []

legend'_ ∷ ElementNoProperties
legend'_ = legend' (Types.StaticProperties [])

li ∷ StaticElement
li = make "li"

li' ∷ Element
li' = make' "li"

li_ ∷ StaticElementNoProperties
li_ = li []

li'_ ∷ ElementNoProperties
li'_ = li' (Types.StaticProperties [])

main ∷ StaticElement
main = make "main"

main' ∷ Element
main' = make' "main"

main_ ∷ StaticElementNoProperties
main_ = main []

main'_ ∷ ElementNoProperties
main'_ = main' (Types.StaticProperties [])

map ∷ StaticElement
map = make "map"

map' ∷ Element
map' = make' "map"

map_ ∷ StaticElementNoProperties
map_ = map []

map'_ ∷ ElementNoProperties
map'_ = map' (Types.StaticProperties [])

mark ∷ StaticElement
mark = make "mark"

mark' ∷ Element
mark' = make' "mark"

mark_ ∷ StaticElementNoProperties
mark_ = mark []

mark'_ ∷ ElementNoProperties
mark'_ = mark' (Types.StaticProperties [])

menu ∷ StaticElement
menu = make "menu"

menu' ∷ Element
menu' = make' "menu"

menu_ ∷ StaticElementNoProperties
menu_ = menu []

menu'_ ∷ ElementNoProperties
menu'_ = menu' (Types.StaticProperties [])

menuitem ∷ StaticElementSelfClosing
menuitem props = make "menuitem" props []

menuitem' ∷ ElementSelfClosing
menuitem' props = make' "menuitem" props (Types.StaticChildren [])

menuitem_ ∷ StaticElementSelfClosingNoProperties
menuitem_ = menuitem []

meter ∷ StaticElement
meter = make "meter"

meter' ∷ Element
meter' = make' "meter"

meter_ ∷ StaticElementNoProperties
meter_ = meter []

meter'_ ∷ ElementNoProperties
meter'_ = meter' (Types.StaticProperties [])

nav ∷ StaticElement
nav = make "nav"

nav' ∷ Element
nav' = make' "nav"

nav_ ∷ StaticElementNoProperties
nav_ = nav []

nav'_ ∷ ElementNoProperties
nav'_ = nav' (Types.StaticProperties [])

noframes ∷ StaticElement
noframes = make "noframes"

noframes' ∷ Element
noframes' = make' "noframes"

noframes_ ∷ StaticElementNoProperties
noframes_ = noframes []

noframes'_ ∷ ElementNoProperties
noframes'_ = noframes' (Types.StaticProperties [])

noscript ∷ StaticElement
noscript = make "noscript"

noscript' ∷ Element
noscript' = make' "noscript"

noscript_ ∷ StaticElementNoProperties
noscript_ = noscript []

noscript'_ ∷ ElementNoProperties
noscript'_ = noscript' (Types.StaticProperties [])

object ∷ StaticElement
object = make "object"

object' ∷ Element
object' = make' "object"

object_ ∷ StaticElementNoProperties
object_ = object []

object'_ ∷ ElementNoProperties
object'_ = object' (Types.StaticProperties [])

ol ∷ StaticElement
ol = make "ol"

ol' ∷ Element
ol' = make' "ol"

ol_ ∷ StaticElementNoProperties
ol_ = ol []

ol'_ ∷ ElementNoProperties
ol'_ = ol' (Types.StaticProperties [])

optgroup ∷ StaticElement
optgroup = make "optgroup"

optgroup' ∷ Element
optgroup' = make' "optgroup"

optgroup_ ∷ StaticElementNoProperties
optgroup_ = optgroup []

optgroup'_ ∷ ElementNoProperties
optgroup'_ = optgroup' (Types.StaticProperties [])

option ∷ StaticElement
option = make "option"

option' ∷ Element
option' = make' "option"

option_ ∷ StaticElementNoProperties
option_ = option []

option'_ ∷ ElementNoProperties
option'_ = option' (Types.StaticProperties [])

output ∷ StaticElement
output = make "output"

output' ∷ Element
output' = make' "output"

output_ ∷ StaticElementNoProperties
output_ = output []

output'_ ∷ ElementNoProperties
output'_ = output' (Types.StaticProperties [])

p ∷ StaticElement
p = make "p"

p' ∷ Element
p' = make' "p"

p_ ∷ StaticElementNoProperties
p_ = p []

p'_ ∷ ElementNoProperties
p'_ = p' (Types.StaticProperties [])

param ∷ StaticElementSelfClosing
param props = make "param" props []

param' ∷ ElementSelfClosing
param' props = make' "param" props (Types.StaticChildren [])

param_ ∷ StaticElementSelfClosingNoProperties
param_ = param []

picture ∷ StaticElement
picture = make "picture"

picture' ∷ Element
picture' = make' "picture"

picture_ ∷ StaticElementNoProperties
picture_ = picture []

picture'_ ∷ ElementNoProperties
picture'_ = picture' (Types.StaticProperties [])

pre ∷ StaticElement
pre = make "pre"

pre' ∷ Element
pre' = make' "pre"

pre_ ∷ StaticElementNoProperties
pre_ = pre []

pre'_ ∷ ElementNoProperties
pre'_ = pre' (Types.StaticProperties [])

progress ∷ StaticElement
progress = make "progress"

progress' ∷ Element
progress' = make' "progress"

progress_ ∷ StaticElementNoProperties
progress_ = progress []

progress'_ ∷ ElementNoProperties
progress'_ = progress' (Types.StaticProperties [])

q ∷ StaticElement
q = make "q"

q' ∷ Element
q' = make' "q"

q_ ∷ StaticElementNoProperties
q_ = q []

q'_ ∷ ElementNoProperties
q'_ = q' (Types.StaticProperties [])

rp ∷ StaticElement
rp = make "rp"

rp' ∷ Element
rp' = make' "rp"

rp_ ∷ StaticElementNoProperties
rp_ = rp []

rp'_ ∷ ElementNoProperties
rp'_ = rp' (Types.StaticProperties [])

rt ∷ StaticElement
rt = make "rt"

rt' ∷ Element
rt' = make' "rt"

rt_ ∷ StaticElementNoProperties
rt_ = rt []

rt'_ ∷ ElementNoProperties
rt'_ = rt' (Types.StaticProperties [])

ruby ∷ StaticElement
ruby = make "ruby"

ruby' ∷ Element
ruby' = make' "ruby"

ruby_ ∷ StaticElementNoProperties
ruby_ = ruby []

ruby'_ ∷ ElementNoProperties
ruby'_ = ruby' (Types.StaticProperties [])

s ∷ StaticElement
s = make "s"

s' ∷ Element
s' = make' "s"

s_ ∷ StaticElementNoProperties
s_ = s []

s'_ ∷ ElementNoProperties
s'_ = s' (Types.StaticProperties [])

samp ∷ StaticElement
samp = make "samp"

samp' ∷ Element
samp' = make' "samp"

samp_ ∷ StaticElementNoProperties
samp_ = samp []

samp'_ ∷ ElementNoProperties
samp'_ = samp' (Types.StaticProperties [])

script ∷ StaticElement
script = make "script"

script' ∷ Element
script' = make' "script"

script_ ∷ StaticElementNoProperties
script_ = script []

script'_ ∷ ElementNoProperties
script'_ = script' (Types.StaticProperties [])

section ∷ StaticElement
section = make "section"

section' ∷ Element
section' = make' "section"

section_ ∷ StaticElementNoProperties
section_ = section []

section'_ ∷ ElementNoProperties
section'_ = section' (Types.StaticProperties [])

select ∷ StaticElement
select = make "select"

select' ∷ Element
select' = make' "select"

select_ ∷ StaticElementNoProperties
select_ = select []

select'_ ∷ ElementNoProperties
select'_ = select' (Types.StaticProperties [])

small ∷ StaticElement
small = make "small"

small' ∷ Element
small' = make' "small"

small_ ∷ StaticElementNoProperties
small_ = small []

small'_ ∷ ElementNoProperties
small'_ = small' (Types.StaticProperties [])

source ∷ StaticElementSelfClosing
source props = make "source" props []

source' ∷ ElementSelfClosing
source' props = make' "source" props (Types.StaticChildren [])

source_ ∷ StaticElementSelfClosingNoProperties
source_ = source []

span ∷ StaticElement
span = make "span"

span' ∷ Element
span' = make' "span"

span_ ∷ StaticElementNoProperties
span_ = span []

span'_ ∷ ElementNoProperties
span'_ = span' (Types.StaticProperties [])

strike ∷ StaticElement
strike = make "strike"

strike' ∷ Element
strike' = make' "strike"

strike_ ∷ StaticElementNoProperties
strike_ = strike []

strike'_ ∷ ElementNoProperties
strike'_ = strike' (Types.StaticProperties [])

strong ∷ StaticElement
strong = make "strong"

strong' ∷ Element
strong' = make' "strong"

strong_ ∷ StaticElementNoProperties
strong_ = strong []

strong'_ ∷ ElementNoProperties
strong'_ = strong' (Types.StaticProperties [])

style ∷ StaticElement
style = make "style"

style' ∷ Element
style' = make' "style"

style_ ∷ StaticElementNoProperties
style_ = style []

style'_ ∷ ElementNoProperties
style'_ = style' (Types.StaticProperties [])

sub ∷ StaticElement
sub = make "sub"

sub' ∷ Element
sub' = make' "sub"

sub_ ∷ StaticElementNoProperties
sub_ = sub []

sub'_ ∷ ElementNoProperties
sub'_ = sub' (Types.StaticProperties [])

summary ∷ StaticElement
summary = make "summary"

summary' ∷ Element
summary' = make' "summary"

summary_ ∷ StaticElementNoProperties
summary_ = summary []

summary'_ ∷ ElementNoProperties
summary'_ = summary' (Types.StaticProperties [])

sup ∷ StaticElement
sup = make "sup"

sup' ∷ Element
sup' = make' "sup"

sup_ ∷ StaticElementNoProperties
sup_ = sup []

sup'_ ∷ ElementNoProperties
sup'_ = sup' (Types.StaticProperties [])

table ∷ StaticElement
table = make "table"

table' ∷ Element
table' = make' "table"

table_ ∷ StaticElementNoProperties
table_ = table []

table'_ ∷ ElementNoProperties
table'_ = table' (Types.StaticProperties [])

tbody ∷ StaticElement
tbody = make "tbody"

tbody' ∷ Element
tbody' = make' "tbody"

tbody_ ∷ StaticElementNoProperties
tbody_ = tbody []

tbody'_ ∷ ElementNoProperties
tbody'_ = tbody' (Types.StaticProperties [])

td ∷ StaticElement
td = make "td"

td' ∷ Element
td' = make' "td"

td_ ∷ StaticElementNoProperties
td_ = td []

td'_ ∷ ElementNoProperties
td'_ = td' (Types.StaticProperties [])

template ∷ StaticElement
template = make "template"

template' ∷ Element
template' = make' "template"

template_ ∷ StaticElementNoProperties
template_ = template []

template'_ ∷ ElementNoProperties
template'_ = template' (Types.StaticProperties [])

text
  ∷ ∀ eff update state event
  . String
  → Types.Component eff update state event
text
  = Types.CText

textarea ∷ StaticElement
textarea = make "textarea"

textarea' ∷ Element
textarea' = make' "textarea"

textarea_ ∷ StaticElementNoProperties
textarea_ = textarea []

textarea'_ ∷ ElementNoProperties
textarea'_ = textarea' (Types.StaticProperties [])

tfoot ∷ StaticElement
tfoot = make "tfoot"

tfoot' ∷ Element
tfoot' = make' "tfoot"

tfoot_ ∷ StaticElementNoProperties
tfoot_ = tfoot []

tfoot'_ ∷ ElementNoProperties
tfoot'_ = tfoot' (Types.StaticProperties [])

th ∷ StaticElement
th = make "th"

th' ∷ Element
th' = make' "th"

th_ ∷ StaticElementNoProperties
th_ = th []

th'_ ∷ ElementNoProperties
th'_ = th' (Types.StaticProperties [])

thead ∷ StaticElement
thead = make "thead"

thead' ∷ Element
thead' = make' "thead"

thead_ ∷ StaticElementNoProperties
thead_ = thead []

thead'_ ∷ ElementNoProperties
thead'_ = thead' (Types.StaticProperties [])

time ∷ StaticElement
time = make "time"

time' ∷ Element
time' = make' "time"

time_ ∷ StaticElementNoProperties
time_ = time []

time'_ ∷ ElementNoProperties
time'_ = time' (Types.StaticProperties [])

title ∷ StaticElement
title = make "title"

title' ∷ Element
title' = make' "title"

title_ ∷ StaticElementNoProperties
title_ = title []

title'_ ∷ ElementNoProperties
title'_ = title' (Types.StaticProperties [])

tr ∷ StaticElement
tr = make "tr"

tr' ∷ Element
tr' = make' "tr"

tr_ ∷ StaticElementNoProperties
tr_ = tr []

tr'_ ∷ ElementNoProperties
tr'_ = tr' (Types.StaticProperties [])

track ∷ StaticElementSelfClosing
track props = make "track" props []

track' ∷ ElementSelfClosing
track' props = make' "track" props (Types.StaticChildren [])

track_ ∷ StaticElementSelfClosingNoProperties
track_ = track []

tt ∷ StaticElement
tt = make "tt"

tt' ∷ Element
tt' = make' "tt"

tt_ ∷ StaticElementNoProperties
tt_ = tt []

tt'_ ∷ ElementNoProperties
tt'_ = tt' (Types.StaticProperties [])

u ∷ StaticElement
u = make "u"

u' ∷ Element
u' = make' "u"

u_ ∷ StaticElementNoProperties
u_ = u []

u'_ ∷ ElementNoProperties
u'_ = u' (Types.StaticProperties [])

ul ∷ StaticElement
ul = make "ul"

ul' ∷ Element
ul' = make' "ul"

ul_ ∷ StaticElementNoProperties
ul_ = ul []

ul'_ ∷ ElementNoProperties
ul'_ = ul' (Types.StaticProperties [])

var ∷ StaticElement
var = make "var"

var' ∷ Element
var' = make' "var"

var_ ∷ StaticElementNoProperties
var_ = var []

var'_ ∷ ElementNoProperties
var'_ = var' (Types.StaticProperties [])

video ∷ StaticElement
video = make "video"

video' ∷ Element
video' = make' "video"

video_ ∷ StaticElementNoProperties
video_ = video []

video'_ ∷ ElementNoProperties
video'_ = video' (Types.StaticProperties [])

wbr ∷ StaticElementSelfClosing
wbr props = make "wbr" props []

wbr' ∷ ElementSelfClosing
wbr' props = make' "wbr" props (Types.StaticChildren [])

wbr_ ∷ StaticElementSelfClosingNoProperties
wbr_ = wbr []
