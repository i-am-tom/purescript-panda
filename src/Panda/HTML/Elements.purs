module Panda.HTML.Elements where

import Panda.Internal.Types as Types

-- | A regular element.
type Element
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Types.Children eff update state event
  → Types.Component eff update state event

-- | An element whose immediate children definitely don't respond to updates.
type StaticElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event

-- | An element that, according to the HTML spec, is not a container.
type SelfClosingElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Types.Component eff update state event

-- | A non-container element that has no custom properties.
type SelfClosingElementWithoutProperties
  = ∀ eff update state event
  . Types.Component eff update state event

-- | An element with no specified properties.
type ElementWithoutProperties
  = ∀ eff update state event
  . Types.Children eff update state event
  → Types.Component eff update state event

-- | An element with no specified properties and fixed children.
type StaticElementWithoutProperties
  = ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event

make ∷ String → StaticElement
make tagName properties children
  = Types.ComponentElement
      { properties
      , children: Types.StaticChildren children
      , tagName
      }

make' :: String → Element
make' tagName properties listener
  = Types.ComponentElement
      { properties
      , children: listener
      , tagName
      }

a ∷ StaticElement
a = make "a"

a' :: Element
a' = make' "a"

a_ :: StaticElementWithoutProperties
a_ = a []

a'_ :: ElementWithoutProperties
a'_ = a' []

abbr ∷ StaticElement
abbr = make "abbr"

abbr' ∷ Element
abbr' = make' "abbr"

abbr_ ∷ StaticElementWithoutProperties
abbr_ = abbr []

abbr'_ ∷ ElementWithoutProperties
abbr'_ = abbr' []

acronym ∷ StaticElement
acronym = make "acronym"

acronym' ∷ Element
acronym' = make' "acronym"

acronym_ ∷ StaticElementWithoutProperties
acronym_ = acronym []

acronym'_ ∷ ElementWithoutProperties
acronym'_ = acronym' []

address ∷ StaticElement
address = make "address"

address' ∷ Element
address' = make' "address"

address_ ∷ StaticElementWithoutProperties
address_ = address []

address'_ ∷ ElementWithoutProperties
address'_ = address' []

applet ∷ StaticElement
applet = make "applet"

applet' ∷ Element
applet' = make' "applet"

applet_ ∷ StaticElementWithoutProperties
applet_ = applet []

applet'_ ∷ ElementWithoutProperties
applet'_ = applet' []

area ∷ SelfClosingElement
area props = make "area" props []

area_ ∷ SelfClosingElementWithoutProperties
area_ = area []

article ∷ StaticElement
article = make "article"

article' ∷ Element
article' = make' "article"

article_ ∷ StaticElementWithoutProperties
article_ = article []

article'_ ∷ ElementWithoutProperties
article'_ = article' []

aside ∷ StaticElement
aside = make "aside"

aside' ∷ Element
aside' = make' "aside"

aside_ ∷ StaticElementWithoutProperties
aside_ = aside []

aside'_ ∷ ElementWithoutProperties
aside'_ = aside' []

audio ∷ StaticElement
audio = make "audio"

audio' ∷ Element
audio' = make' "audio"

audio_ ∷ StaticElementWithoutProperties
audio_ = audio []

audio'_ ∷ ElementWithoutProperties
audio'_ = audio' []

b ∷ StaticElement
b = make "b"

b' ∷ Element
b' = make' "b"

b_ ∷ StaticElementWithoutProperties
b_ = b []

b'_ ∷ ElementWithoutProperties
b'_ = b' []

base ∷ SelfClosingElement
base props = make "base" props []

base_ ∷ SelfClosingElementWithoutProperties
base_ = base []

basefont ∷ StaticElement
basefont = make "basefont"

basefont' ∷ Element
basefont' = make' "basefont"

basefont_ ∷ StaticElementWithoutProperties
basefont_ = basefont []

basefont'_ ∷ ElementWithoutProperties
basefont'_ = basefont' []

bdi ∷ StaticElement
bdi = make "bdi"

bdi' ∷ Element
bdi' = make' "bdi"

bdi_ ∷ StaticElementWithoutProperties
bdi_ = bdi []

bdi'_ ∷ ElementWithoutProperties
bdi'_ = bdi' []

bdo ∷ StaticElement
bdo = make "bdo"

bdo' ∷ Element
bdo' = make' "bdo"

bdo_ ∷ StaticElementWithoutProperties
bdo_ = bdo []

bdo'_ ∷ ElementWithoutProperties
bdo'_ = bdo' []

big ∷ StaticElement
big = make "big"

big' ∷ Element
big' = make' "big"

big_ ∷ StaticElementWithoutProperties
big_ = big []

big'_ ∷ ElementWithoutProperties
big'_ = big' []

blockquote ∷ StaticElement
blockquote = make "blockquote"

blockquote' ∷ Element
blockquote' = make' "blockquote"

blockquote_ ∷ StaticElementWithoutProperties
blockquote_ = blockquote []

blockquote'_ ∷ ElementWithoutProperties
blockquote'_ = blockquote' []

br ∷ SelfClosingElement
br props = make "br" props []

br_ ∷ SelfClosingElementWithoutProperties
br_ = br []

button ∷ StaticElement
button = make "button"

button' ∷ Element
button' = make' "button"

button_ ∷ StaticElementWithoutProperties
button_ = button []

button'_ ∷ ElementWithoutProperties
button'_ = button' []

canvas ∷ StaticElement
canvas = make "canvas"

canvas' ∷ Element
canvas' = make' "canvas"

canvas_ ∷ StaticElementWithoutProperties
canvas_ = canvas []

canvas'_ ∷ ElementWithoutProperties
canvas'_ = canvas' []

caption ∷ StaticElement
caption = make "caption"

caption' ∷ Element
caption' = make' "caption"

caption_ ∷ StaticElementWithoutProperties
caption_ = caption []

caption'_ ∷ ElementWithoutProperties
caption'_ = caption' []

center ∷ StaticElement
center = make "center"

center' ∷ Element
center' = make' "center"

center_ ∷ StaticElementWithoutProperties
center_ = center []

cite ∷ StaticElement
cite = make "cite"

cite' ∷ Element
cite' = make' "cite"

cite_ ∷ StaticElementWithoutProperties
cite_ = cite []

cite'_ ∷ ElementWithoutProperties
cite'_ = cite' []

code ∷ StaticElement
code = make "code"

code' ∷ Element
code' = make' "code"

code_ ∷ StaticElementWithoutProperties
code_ = code []

col ∷ SelfClosingElement
col props = make "col" props []

col_ ∷ SelfClosingElementWithoutProperties
col_ = col []

colgroup ∷ StaticElement
colgroup = make "colgroup"

colgroup' ∷ Element
colgroup' = make' "colgroup"

colgroup_ ∷ StaticElementWithoutProperties
colgroup_ = colgroup []

colgroup'_ ∷ ElementWithoutProperties
colgroup'_ = colgroup' []

command ∷ SelfClosingElement
command props = make "command" props []

command_ ∷ SelfClosingElementWithoutProperties
command_ = command []

datalist ∷ StaticElement
datalist = make "datalist"

datalist' ∷ Element
datalist' = make' "datalist"

datalist_ ∷ StaticElementWithoutProperties
datalist_ = datalist []

datalist'_ ∷ ElementWithoutProperties
datalist'_ = datalist' []

dd ∷ StaticElement
dd = make "dd"

dd' ∷ Element
dd' = make' "dd"

dd_ ∷ StaticElementWithoutProperties
dd_ = dd []

dd'_ ∷ ElementWithoutProperties
dd'_ = dd' []

del ∷ StaticElement
del = make "del"

del' ∷ Element
del' = make' "del"

del_ ∷ StaticElementWithoutProperties
del_ = del []

del'_ ∷ ElementWithoutProperties
del'_ = del' []

details ∷ StaticElement
details = make "details"

details' ∷ Element
details' = make' "details"

details_ ∷ StaticElementWithoutProperties
details_ = details []

details'_ ∷ ElementWithoutProperties
details'_ = details' []

dfn ∷ StaticElement
dfn = make "dfn"

dfn' ∷ Element
dfn' = make' "dfn"

dfn_ ∷ StaticElementWithoutProperties
dfn_ = dfn []

dfn'_ ∷ ElementWithoutProperties
dfn'_ = dfn' []

dialog ∷ StaticElement
dialog = make "dialog"

dialog' ∷ Element
dialog' = make' "dialog"

dialog_ ∷ StaticElementWithoutProperties
dialog_ = dialog []

dialog'_ ∷ ElementWithoutProperties
dialog'_ = dialog' []

dir ∷ StaticElement
dir = make "dir"

dir' ∷ Element
dir' = make' "dir"

dir_ ∷ StaticElementWithoutProperties
dir_ = dir []

dir'_ ∷ ElementWithoutProperties
dir'_ = dir' []

div ∷ StaticElement
div = make "div"

div' ∷ Element
div' = make' "div"

div_ ∷ StaticElementWithoutProperties
div_ = div []

div'_ ∷ ElementWithoutProperties
div'_ = div' []

dl ∷ StaticElement
dl = make "dl"

dl' ∷ Element
dl' = make' "dl"

dl_ ∷ StaticElementWithoutProperties
dl_ = dl []

dl'_ ∷ ElementWithoutProperties
dl'_ = dl' []

dt ∷ StaticElement
dt = make "dt"

dt' ∷ Element
dt' = make' "dt"

dt_ ∷ StaticElementWithoutProperties
dt_ = dt []

dt'_ ∷ ElementWithoutProperties
dt'_ = dt' []

em ∷ StaticElement
em = make "em"

em' ∷ Element
em' = make' "em"

em_ ∷ StaticElementWithoutProperties
em_ = em []

em'_ ∷ ElementWithoutProperties
em'_ = em' []

embed ∷ SelfClosingElement
embed props = make "embed" props []

embed_ ∷ SelfClosingElementWithoutProperties
embed_ = embed []

fieldset ∷ StaticElement
fieldset = make "fieldset"

fieldset' ∷ Element
fieldset' = make' "fieldset"

fieldset_ ∷ StaticElementWithoutProperties
fieldset_ = fieldset []

fieldset'_ ∷ ElementWithoutProperties
fieldset'_ = fieldset' []

figcaption ∷ StaticElement
figcaption = make "figcaption"

figcaption' ∷ Element
figcaption' = make' "figcaption"

figcaption_ ∷ StaticElementWithoutProperties
figcaption_ = figcaption []

figcaption'_ ∷ ElementWithoutProperties
figcaption'_ = figcaption' []

figure ∷ StaticElement
figure = make "figure"

figure' ∷ Element
figure' = make' "figure"

figure_ ∷ StaticElementWithoutProperties
figure_ = figure []

figure'_ ∷ ElementWithoutProperties
figure'_ = figure' []

font ∷ StaticElement
font = make "font"

font' ∷ Element
font' = make' "font"

font_ ∷ StaticElementWithoutProperties
font_ = font []

font'_ ∷ ElementWithoutProperties
font'_ = font' []

footer ∷ StaticElement
footer = make "footer"

footer' ∷ Element
footer' = make' "footer"

footer_ ∷ StaticElementWithoutProperties
footer_ = footer []

footer'_ ∷ ElementWithoutProperties
footer'_ = footer' []

form ∷ StaticElement
form = make "form"

form' ∷ Element
form' = make' "form"

form_ ∷ StaticElementWithoutProperties
form_ = form []

form'_ ∷ ElementWithoutProperties
form'_ = form' []

frame ∷ StaticElement
frame = make "frame"

frame' ∷ Element
frame' = make' "frame"

frame_ ∷ StaticElementWithoutProperties
frame_ = frame []

frame'_ ∷ ElementWithoutProperties
frame'_ = frame' []

frameset ∷ StaticElement
frameset = make "frameset"

frameset' ∷ Element
frameset' = make' "frameset"

frameset_ ∷ StaticElementWithoutProperties
frameset_ = frameset []

frameset'_ ∷ ElementWithoutProperties
frameset'_ = frameset' []

h1 ∷ StaticElement
h1 = make "h1"

h1' ∷ Element
h1' = make' "h1"

h1_ ∷ StaticElementWithoutProperties
h1_ = h1 []

h1'_ ∷ ElementWithoutProperties
h1'_ = h1' []

head ∷ StaticElement
head = make "head"

head' ∷ Element
head' = make' "head"

head_ ∷ StaticElementWithoutProperties
head_ = head []

head'_ ∷ ElementWithoutProperties
head'_ = head' []

header ∷ StaticElement
header = make "header"

header' ∷ Element
header' = make' "header"

header_ ∷ StaticElementWithoutProperties
header_ = header []

header'_ ∷ ElementWithoutProperties
header'_ = header' []

hr ∷ SelfClosingElement
hr props = make "hr" props []

hr_ ∷ SelfClosingElementWithoutProperties
hr_ = hr []

i ∷ StaticElement
i = make "i"

i' ∷ Element
i' = make' "i"

i_ ∷ StaticElementWithoutProperties
i_ = i []

i'_ ∷ ElementWithoutProperties
i'_ = i' []

iframe ∷ StaticElement
iframe = make "iframe"

iframe' ∷ Element
iframe' = make' "iframe"

iframe_ ∷ StaticElementWithoutProperties
iframe_ = iframe []

iframe'_ ∷ ElementWithoutProperties
iframe'_ = iframe' []

img ∷ SelfClosingElement
img props = make "img" props []

img_ ∷ SelfClosingElementWithoutProperties
img_ = img []

input ∷ SelfClosingElement
input props = make "input" props []

input_ ∷ SelfClosingElementWithoutProperties
input_ = input []

ins ∷ StaticElement
ins = make "ins"

ins' ∷ Element
ins' = make' "ins"

ins_ ∷ StaticElementWithoutProperties
ins_ = ins []

ins'_ ∷ ElementWithoutProperties
ins'_ = ins' []

kbd ∷ StaticElement
kbd = make "kbd"

kbd' ∷ Element
kbd' = make' "kbd"

kbd_ ∷ StaticElementWithoutProperties
kbd_ = kbd []

kbd'_ ∷ ElementWithoutProperties
kbd'_ = kbd' []

keygen ∷ SelfClosingElement
keygen props = make "kbd" props []

keygen_ ∷ SelfClosingElementWithoutProperties
keygen_ = keygen []

label ∷ StaticElement
label = make "label"

label' ∷ Element
label' = make' "label"

label_ ∷ StaticElementWithoutProperties
label_ = label []

label'_ ∷ ElementWithoutProperties
label'_ = label' []

legend ∷ StaticElement
legend = make "legend"

legend' ∷ Element
legend' = make' "legend"

legend_ ∷ StaticElementWithoutProperties
legend_ = legend []

legend'_ ∷ ElementWithoutProperties
legend'_ = legend' []

li ∷ StaticElement
li = make "li"

li' ∷ Element
li' = make' "li"

li_ ∷ StaticElementWithoutProperties
li_ = li []

li'_ ∷ ElementWithoutProperties
li'_ = li' []

link ∷ SelfClosingElement
link props = make "link" props []

link_ ∷ SelfClosingElementWithoutProperties
link_ = link []

main ∷ StaticElement
main = make "main"

main' ∷ Element
main' = make' "main"

main_ ∷ StaticElementWithoutProperties
main_ = main []

main'_ ∷ ElementWithoutProperties
main'_ = main' []

map ∷ StaticElement
map = make "map"

map' ∷ Element
map' = make' "map"

map_ ∷ StaticElementWithoutProperties
map_ = map []

map'_ ∷ ElementWithoutProperties
map'_ = map' []

mark ∷ StaticElement
mark = make "mark"

mark' ∷ Element
mark' = make' "mark"

mark_ ∷ StaticElementWithoutProperties
mark_ = mark []

mark'_ ∷ ElementWithoutProperties
mark'_ = mark' []

menu ∷ StaticElement
menu = make "menu"

menu' ∷ Element
menu' = make' "menu"

menu_ ∷ StaticElementWithoutProperties
menu_ = menu []

menu'_ ∷ ElementWithoutProperties
menu'_ = menu' []

menuitem ∷ SelfClosingElement
menuitem props = make "menuitem" props []

menuitem_ ∷ SelfClosingElementWithoutProperties
menuitem_ = menuitem []

meta ∷ SelfClosingElement
meta props = make "meta" props []

meta_ ∷ SelfClosingElementWithoutProperties
meta_ = meta []

meter ∷ StaticElement
meter = make "meter"

meter' ∷ Element
meter' = make' "meter"

meter_ ∷ StaticElementWithoutProperties
meter_ = meter []

meter'_ ∷ ElementWithoutProperties
meter'_ = meter' []

nav ∷ StaticElement
nav = make "nav"

nav' ∷ Element
nav' = make' "nav"

nav_ ∷ StaticElementWithoutProperties
nav_ = nav []

nav'_ ∷ ElementWithoutProperties
nav'_ = nav' []

noframes ∷ StaticElement
noframes = make "noframes"

noframes' ∷ Element
noframes' = make' "noframes"

noframes_ ∷ StaticElementWithoutProperties
noframes_ = noframes []

noframes'_ ∷ ElementWithoutProperties
noframes'_ = noframes' []

noscript ∷ StaticElement
noscript = make "noscript"

noscript' ∷ Element
noscript' = make' "noscript"

noscript_ ∷ StaticElementWithoutProperties
noscript_ = noscript []

noscript'_ ∷ ElementWithoutProperties
noscript'_ = noscript' []

object ∷ StaticElement
object = make "object"

object' ∷ Element
object' = make' "object"

object_ ∷ StaticElementWithoutProperties
object_ = object []

object'_ ∷ ElementWithoutProperties
object'_ = object' []

ol ∷ StaticElement
ol = make "ol"

ol' ∷ Element
ol' = make' "ol"

ol_ ∷ StaticElementWithoutProperties
ol_ = ol []

ol'_ ∷ ElementWithoutProperties
ol'_ = ol' []

optgroup ∷ StaticElement
optgroup = make "optgroup"

optgroup' ∷ Element
optgroup' = make' "optgroup"

optgroup_ ∷ StaticElementWithoutProperties
optgroup_ = optgroup []

optgroup'_ ∷ ElementWithoutProperties
optgroup'_ = optgroup' []

option ∷ StaticElement
option = make "option"

option' ∷ Element
option' = make' "option"

option_ ∷ StaticElementWithoutProperties
option_ = option []

option'_ ∷ ElementWithoutProperties
option'_ = option' []

output ∷ StaticElement
output = make "output"

output' ∷ Element
output' = make' "output"

output_ ∷ StaticElementWithoutProperties
output_ = output []

output'_ ∷ ElementWithoutProperties
output'_ = output' []

p ∷ StaticElement
p = make "p"

p' ∷ Element
p' = make' "p"

p_ ∷ StaticElementWithoutProperties
p_ = p []

p'_ ∷ ElementWithoutProperties
p'_ = p' []

param ∷ SelfClosingElement
param props = make "param" props []

param_ ∷ SelfClosingElementWithoutProperties
param_ = param []

picture ∷ StaticElement
picture = make "picture"

picture' ∷ Element
picture' = make' "picture"

picture_ ∷ StaticElementWithoutProperties
picture_ = picture []

picture'_ ∷ ElementWithoutProperties
picture'_ = picture' []

pre ∷ StaticElement
pre = make "pre"

pre' ∷ Element
pre' = make' "pre"

pre_ ∷ StaticElementWithoutProperties
pre_ = pre []

pre'_ ∷ ElementWithoutProperties
pre'_ = pre' []

progress ∷ StaticElement
progress = make "progress"

progress' ∷ Element
progress' = make' "progress"

progress_ ∷ StaticElementWithoutProperties
progress_ = progress []

progress'_ ∷ ElementWithoutProperties
progress'_ = progress' []

q ∷ StaticElement
q = make "q"

q' ∷ Element
q' = make' "q"

q_ ∷ StaticElementWithoutProperties
q_ = q []

q'_ ∷ ElementWithoutProperties
q'_ = q' []

rp ∷ StaticElement
rp = make "rp"

rp' ∷ Element
rp' = make' "rp"

rp_ ∷ StaticElementWithoutProperties
rp_ = rp []

rp'_ ∷ ElementWithoutProperties
rp'_ = rp' []

rt ∷ StaticElement
rt = make "rt"

rt' ∷ Element
rt' = make' "rt"

rt_ ∷ StaticElementWithoutProperties
rt_ = rt []

rt'_ ∷ ElementWithoutProperties
rt'_ = rt' []

ruby ∷ StaticElement
ruby = make "ruby"

ruby' ∷ Element
ruby' = make' "ruby"

ruby_ ∷ StaticElementWithoutProperties
ruby_ = ruby []

ruby'_ ∷ ElementWithoutProperties
ruby'_ = ruby' []

s ∷ StaticElement
s = make "s"

s' ∷ Element
s' = make' "s"

s_ ∷ StaticElementWithoutProperties
s_ = s []

s'_ ∷ ElementWithoutProperties
s'_ = s' []

samp ∷ StaticElement
samp = make "samp"

samp' ∷ Element
samp' = make' "samp"

samp_ ∷ StaticElementWithoutProperties
samp_ = samp []

samp'_ ∷ ElementWithoutProperties
samp'_ = samp' []

script ∷ StaticElement
script = make "script"

script' ∷ Element
script' = make' "script"

script_ ∷ StaticElementWithoutProperties
script_ = script []

script'_ ∷ ElementWithoutProperties
script'_ = script' []

section ∷ StaticElement
section = make "section"

section' ∷ Element
section' = make' "section"

section_ ∷ StaticElementWithoutProperties
section_ = section []

section'_ ∷ ElementWithoutProperties
section'_ = section' []

select ∷ StaticElement
select = make "select"

select' ∷ Element
select' = make' "select"

select_ ∷ StaticElementWithoutProperties
select_ = select []

select'_ ∷ ElementWithoutProperties
select'_ = select' []

small ∷ StaticElement
small = make "small"

small' ∷ Element
small' = make' "small"

small_ ∷ StaticElementWithoutProperties
small_ = small []

small'_ ∷ ElementWithoutProperties
small'_ = small' []

source ∷ SelfClosingElement
source props = make "source" props []

source_ ∷ SelfClosingElementWithoutProperties
source_ = source []

span ∷ StaticElement
span = make "span"

span' ∷ Element
span' = make' "span"

span_ ∷ StaticElementWithoutProperties
span_ = span []

span'_ ∷ ElementWithoutProperties
span'_ = span' []

strike ∷ StaticElement
strike = make "strike"

strike' ∷ Element
strike' = make' "strike"

strike_ ∷ StaticElementWithoutProperties
strike_ = strike []

strike'_ ∷ ElementWithoutProperties
strike'_ = strike' []

strong ∷ StaticElement
strong = make "strong"

strong' ∷ Element
strong' = make' "strong"

strong_ ∷ StaticElementWithoutProperties
strong_ = strong []

strong'_ ∷ ElementWithoutProperties
strong'_ = strong' []

style ∷ StaticElement
style = make "style"

style' ∷ Element
style' = make' "style"

style_ ∷ StaticElementWithoutProperties
style_ = style []

style'_ ∷ ElementWithoutProperties
style'_ = style' []

sub ∷ StaticElement
sub = make "sub"

sub' ∷ Element
sub' = make' "sub"

sub_ ∷ StaticElementWithoutProperties
sub_ = sub []

sub'_ ∷ ElementWithoutProperties
sub'_ = sub' []

summary ∷ StaticElement
summary = make "summary"

summary' ∷ Element
summary' = make' "summary"

summary_ ∷ StaticElementWithoutProperties
summary_ = summary []

summary'_ ∷ ElementWithoutProperties
summary'_ = summary' []

sup ∷ StaticElement
sup = make "sup"

sup' ∷ Element
sup' = make' "sup"

sup_ ∷ StaticElementWithoutProperties
sup_ = sup []

sup'_ ∷ ElementWithoutProperties
sup'_ = sup' []

table ∷ StaticElement
table = make "table"

table' ∷ Element
table' = make' "table"

table_ ∷ StaticElementWithoutProperties
table_ = table []

table'_ ∷ ElementWithoutProperties
table'_ = table' []

tbody ∷ StaticElement
tbody = make "tbody"

tbody' ∷ Element
tbody' = make' "tbody"

tbody_ ∷ StaticElementWithoutProperties
tbody_ = tbody []

tbody'_ ∷ ElementWithoutProperties
tbody'_ = tbody' []

td ∷ StaticElement
td = make "td"

td' ∷ Element
td' = make' "td"

td_ ∷ StaticElementWithoutProperties
td_ = td []

td'_ ∷ ElementWithoutProperties
td'_ = td' []

template ∷ StaticElement
template = make "template"

template' ∷ Element
template' = make' "template"

template_ ∷ StaticElementWithoutProperties
template_ = template []

template'_ ∷ ElementWithoutProperties
template'_ = template' []

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

textarea_ ∷ StaticElementWithoutProperties
textarea_ = textarea []

textarea'_ ∷ ElementWithoutProperties
textarea'_ = textarea' []

tfoot ∷ StaticElement
tfoot = make "tfoot"

tfoot' ∷ Element
tfoot' = make' "tfoot"

tfoot_ ∷ StaticElementWithoutProperties
tfoot_ = tfoot []

tfoot'_ ∷ ElementWithoutProperties
tfoot'_ = tfoot' []

th ∷ StaticElement
th = make "th"

th' ∷ Element
th' = make' "th"

th_ ∷ StaticElementWithoutProperties
th_ = th []

th'_ ∷ ElementWithoutProperties
th'_ = th' []

thead ∷ StaticElement
thead = make "thead"

thead' ∷ Element
thead' = make' "thead"

thead_ ∷ StaticElementWithoutProperties
thead_ = thead []

thead'_ ∷ ElementWithoutProperties
thead'_ = thead' []

time ∷ StaticElement
time = make "time"

time' ∷ Element
time' = make' "time"

time_ ∷ StaticElementWithoutProperties
time_ = time []

time'_ ∷ ElementWithoutProperties
time'_ = time' []

title ∷ StaticElement
title = make "title"

title' ∷ Element
title' = make' "title"

title_ ∷ StaticElementWithoutProperties
title_ = title []

title'_ ∷ ElementWithoutProperties
title'_ = title' []

tr ∷ StaticElement
tr = make "tr"

tr' ∷ Element
tr' = make' "tr"

tr_ ∷ StaticElementWithoutProperties
tr_ = tr []

tr'_ ∷ ElementWithoutProperties
tr'_ = tr' []

track ∷ SelfClosingElement
track props = make "track" props []

track_ ∷ SelfClosingElementWithoutProperties
track_ = track []

tt ∷ StaticElement
tt = make "tt"

tt' ∷ Element
tt' = make' "tt"

tt_ ∷ StaticElementWithoutProperties
tt_ = tt []

tt'_ ∷ ElementWithoutProperties
tt'_ = tt' []

u ∷ StaticElement
u = make "u"

u' ∷ Element
u' = make' "u"

u_ ∷ StaticElementWithoutProperties
u_ = u []

u'_ ∷ ElementWithoutProperties
u'_ = u' []

ul ∷ StaticElement
ul = make "ul"

ul' ∷ Element
ul' = make' "ul"

ul_ ∷ StaticElementWithoutProperties
ul_ = ul []

ul'_ ∷ ElementWithoutProperties
ul'_ = ul' []

var ∷ StaticElement
var = make "var"

var' ∷ Element
var' = make' "var"

var_ ∷ StaticElementWithoutProperties
var_ = var []

var'_ ∷ ElementWithoutProperties
var'_ = var' []

video ∷ StaticElement
video = make "video"

video' ∷ Element
video' = make' "video"

video_ ∷ StaticElementWithoutProperties
video_ = video []

video'_ ∷ ElementWithoutProperties
video'_ = video' []

wbr ∷ SelfClosingElement
wbr props = make "wbr" props []

wbr_ ∷ SelfClosingElementWithoutProperties
wbr_ = wbr []
