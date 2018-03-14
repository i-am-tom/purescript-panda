module Panda.HTML.Elements where

import Panda.Internal.Types as Types

import Prelude (($))

type StaticElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event

type DynamicElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → ( { update ∷ update, state ∷ state }
    → Types.ShouldUpdate
        ( Array (Types.ComponentUpdate eff update state event)
        )
    )
  → Types.Component eff update state event

type SelfClosingElement
  = ∀ eff update state event
  . Array (Types.Property update state event)
  → Types.Component eff update state event

type StaticElementWithoutProperties
  = ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event

type DynamicElementWithoutProperties
  = ∀ eff update state event
  . ( { update ∷ update, state ∷ state }
    → Types.ShouldUpdate
        ( Array (Types.ComponentUpdate eff update state event)
        )
    )
  → Types.Component eff update state event

make
  ∷ String
  → StaticElement
make tagName properties children
  = Types.CElement
  $ Types.ComponentElement
      { properties
      , children: Types.StaticChildren children
      , tagName
      }

make'
  ∷ String
  → DynamicElement
make' tagName properties listener
  = Types.CElement
  $ Types.ComponentElement
      { properties
      , children: Types.DynamicChildren listener
      , tagName
      }

a ∷ StaticElement
a = make "a"

a' ∷ DynamicElement
a' = make' "a"

a_ ∷ StaticElementWithoutProperties
a_ = a []

a'_ ∷ DynamicElementWithoutProperties
a'_ = a' []

abbr ∷ StaticElement
abbr = make "abbr"

abbr' ∷ DynamicElement
abbr' = make' "abbr"

abbr_ ∷ StaticElementWithoutProperties
abbr_ = abbr []

acronym ∷ StaticElement
acronym = make "acronym"

acronym' ∷ DynamicElement
acronym' = make' "acronym"

acronym_ ∷ StaticElementWithoutProperties
acronym_ = acronym []

acronym'_ ∷ DynamicElementWithoutProperties
acronym'_ = acronym' []

address ∷ StaticElement
address = make "address"

address' ∷ DynamicElement
address' = make' "address"

address_ ∷ StaticElementWithoutProperties
address_ = address []

address'_ ∷ DynamicElementWithoutProperties
address'_ = address' []

applet ∷ StaticElement
applet = make "applet"

applet' ∷ DynamicElement
applet' = make' "applet"

applet_ ∷ StaticElementWithoutProperties
applet_ = applet []

applet'_ ∷ DynamicElementWithoutProperties
applet'_ = applet' []

area ∷ SelfClosingElement
area props = make "area" props []

article ∷ StaticElement
article = make "article"

article' ∷ DynamicElement
article' = make' "article"

article_ ∷ StaticElementWithoutProperties
article_ = article []

article'_ ∷ DynamicElementWithoutProperties
article'_ = article' []

aside ∷ StaticElement
aside = make "aside"

aside' ∷ DynamicElement
aside' = make' "aside"

aside_ ∷ StaticElementWithoutProperties
aside_ = aside []

aside'_ ∷ DynamicElementWithoutProperties
aside'_ = aside' []

audio ∷ StaticElement
audio = make "audio"

audio' ∷ DynamicElement
audio' = make' "audio"

audio_ ∷ StaticElementWithoutProperties
audio_ = audio []

audio'_ ∷ DynamicElementWithoutProperties
audio'_ = audio' []

b ∷ StaticElement
b = make "b"

b' ∷ DynamicElement
b' = make' "b"

b_ ∷ StaticElementWithoutProperties
b_ = b []

b'_ ∷ DynamicElementWithoutProperties
b'_ = b' []

base ∷ SelfClosingElement
base props = make "base" props []

basefont ∷ StaticElement
basefont = make "basefont"

basefont' ∷ DynamicElement
basefont' = make' "basefont"

basefont_ ∷ StaticElementWithoutProperties
basefont_ = basefont []

basefont'_ ∷ DynamicElementWithoutProperties
basefont'_ = basefont' []

bdi ∷ StaticElement
bdi = make "bdi"

bdi' ∷ DynamicElement
bdi' = make' "bdi"

bdi_ ∷ StaticElementWithoutProperties
bdi_ = bdi []

bdi'_ ∷ DynamicElementWithoutProperties
bdi'_ = bdi' []

bdo ∷ StaticElement
bdo = make "bdo"

bdo' ∷ DynamicElement
bdo' = make' "bdo"

bdo_ ∷ StaticElementWithoutProperties
bdo_ = bdo []

bdo'_ ∷ DynamicElementWithoutProperties
bdo'_ = bdo' []

big ∷ StaticElement
big = make "big"

big' ∷ DynamicElement
big' = make' "big"

big_ ∷ StaticElementWithoutProperties
big_ = big []

big'_ ∷ DynamicElementWithoutProperties
big'_ = big' []

blockquote ∷ StaticElement
blockquote = make "blockquote"

blockquote' ∷ DynamicElement
blockquote' = make' "blockquote"

blockquote_ ∷ StaticElementWithoutProperties
blockquote_ = blockquote []

blockquote'_ ∷ DynamicElementWithoutProperties
blockquote'_ = blockquote' []

br ∷ SelfClosingElement
br props = make "br" props []

button ∷ StaticElement
button = make "button"

button' ∷ DynamicElement
button' = make' "button"

button_ ∷ StaticElementWithoutProperties
button_ = button []

button'_ ∷ DynamicElementWithoutProperties
button'_ = button' []

canvas ∷ StaticElement
canvas = make "canvas"

canvas' ∷ DynamicElement
canvas' = make' "canvas"

canvas_ ∷ StaticElementWithoutProperties
canvas_ = canvas []

canvas'_ ∷ DynamicElementWithoutProperties
canvas'_ = canvas' []

caption ∷ StaticElement
caption = make "caption"

caption' ∷ DynamicElement
caption' = make' "caption"

caption_ ∷ StaticElementWithoutProperties
caption_ = caption []

caption'_ ∷ DynamicElementWithoutProperties
caption'_ = caption' []

center ∷ StaticElement
center = make "center"

center' ∷ DynamicElement
center' = make' "center"

center_ ∷ StaticElementWithoutProperties
center_ = center []

cite ∷ StaticElement
cite = make "cite"

cite' ∷ DynamicElement
cite' = make' "cite"

cite_ ∷ StaticElementWithoutProperties
cite_ = cite []

cite'_ ∷ DynamicElementWithoutProperties
cite'_ = cite' []

code ∷ StaticElement
code = make "code"

code' ∷ DynamicElement
code' = make' "code"

code_ ∷ StaticElementWithoutProperties
code_ = code []

col ∷ SelfClosingElement
col props = make "col" props []

colgroup ∷ StaticElement
colgroup = make "colgroup"

colgroup' ∷ DynamicElement
colgroup' = make' "colgroup"

colgroup_ ∷ StaticElementWithoutProperties
colgroup_ = colgroup []

colgroup'_ ∷ DynamicElementWithoutProperties
colgroup'_ = colgroup' []

command ∷ SelfClosingElement
command props = make "command" props []

datalist ∷ StaticElement
datalist = make "datalist"

datalist' ∷ DynamicElement
datalist' = make' "datalist"

datalist_ ∷ StaticElementWithoutProperties
datalist_ = datalist []

datalist'_ ∷ DynamicElementWithoutProperties
datalist'_ = datalist' []

dd ∷ StaticElement
dd = make "dd"

dd' ∷ DynamicElement
dd' = make' "dd"

dd_ ∷ StaticElementWithoutProperties
dd_ = dd []

dd'_ ∷ DynamicElementWithoutProperties
dd'_ = dd' []

del ∷ StaticElement
del = make "del"

del' ∷ DynamicElement
del' = make' "del"

del_ ∷ StaticElementWithoutProperties
del_ = del []

del'_ ∷ DynamicElementWithoutProperties
del'_ = del' []

details ∷ StaticElement
details = make "details"

details' ∷ DynamicElement
details' = make' "details"

details_ ∷ StaticElementWithoutProperties
details_ = details []

details'_ ∷ DynamicElementWithoutProperties
details'_ = details' []

dfn ∷ StaticElement
dfn = make "dfn"

dfn' ∷ DynamicElement
dfn' = make' "dfn"

dfn_ ∷ StaticElementWithoutProperties
dfn_ = dfn []

dfn'_ ∷ DynamicElementWithoutProperties
dfn'_ = dfn' []

dialog ∷ StaticElement
dialog = make "dialog"

dialog' ∷ DynamicElement
dialog' = make' "dialog"

dialog_ ∷ StaticElementWithoutProperties
dialog_ = dialog []

dialog'_ ∷ DynamicElementWithoutProperties
dialog'_ = dialog' []

dir ∷ StaticElement
dir = make "dir"

dir' ∷ DynamicElement
dir' = make' "dir"

dir_ ∷ StaticElementWithoutProperties
dir_ = dir []

dir'_ ∷ DynamicElementWithoutProperties
dir'_ = dir' []

div ∷ StaticElement
div = make "div"

div' ∷ DynamicElement
div' = make' "div"

div_ ∷ StaticElementWithoutProperties
div_ = div []

div'_ ∷ DynamicElementWithoutProperties
div'_ = div' []

dl ∷ StaticElement
dl = make "dl"

dl' ∷ DynamicElement
dl' = make' "dl"

dl_ ∷ StaticElementWithoutProperties
dl_ = dl []

dl'_ ∷ DynamicElementWithoutProperties
dl'_ = dl' []

dt ∷ StaticElement
dt = make "dt"

dt' ∷ DynamicElement
dt' = make' "dt"

dt_ ∷ StaticElementWithoutProperties
dt_ = dt []

dt'_ ∷ DynamicElementWithoutProperties
dt'_ = dt' []

em ∷ StaticElement
em = make "em"

em' ∷ DynamicElement
em' = make' "em"

em_ ∷ StaticElementWithoutProperties
em_ = em []

em'_ ∷ DynamicElementWithoutProperties
em'_ = em' []

embed ∷ SelfClosingElement
embed props = make "embed" props []

fieldset ∷ StaticElement
fieldset = make "fieldset"

fieldset' ∷ DynamicElement
fieldset' = make' "fieldset"

fieldset_ ∷ StaticElementWithoutProperties
fieldset_ = fieldset []

fieldset'_ ∷ DynamicElementWithoutProperties
fieldset'_ = fieldset' []

figcaption ∷ StaticElement
figcaption = make "figcaption"

figcaption' ∷ DynamicElement
figcaption' = make' "figcaption"

figcaption_ ∷ StaticElementWithoutProperties
figcaption_ = figcaption []

figcaption'_ ∷ DynamicElementWithoutProperties
figcaption'_ = figcaption' []

figure ∷ StaticElement
figure = make "figure"

figure' ∷ DynamicElement
figure' = make' "figure"

figure_ ∷ StaticElementWithoutProperties
figure_ = figure []

figure'_ ∷ DynamicElementWithoutProperties
figure'_ = figure' []

font ∷ StaticElement
font = make "font"

font' ∷ DynamicElement
font' = make' "font"

font_ ∷ StaticElementWithoutProperties
font_ = font []

font'_ ∷ DynamicElementWithoutProperties
font'_ = font' []

footer ∷ StaticElement
footer = make "footer"

footer' ∷ DynamicElement
footer' = make' "footer"

footer_ ∷ StaticElementWithoutProperties
footer_ = footer []

footer'_ ∷ DynamicElementWithoutProperties
footer'_ = footer' []

form ∷ StaticElement
form = make "form"

form' ∷ DynamicElement
form' = make' "form"

form_ ∷ StaticElementWithoutProperties
form_ = form []

form'_ ∷ DynamicElementWithoutProperties
form'_ = form' []

frame ∷ StaticElement
frame = make "frame"

frame' ∷ DynamicElement
frame' = make' "frame"

frame_ ∷ StaticElementWithoutProperties
frame_ = frame []

frame'_ ∷ DynamicElementWithoutProperties
frame'_ = frame' []

frameset ∷ StaticElement
frameset = make "frameset"

frameset' ∷ DynamicElement
frameset' = make' "frameset"

frameset_ ∷ StaticElementWithoutProperties
frameset_ = frameset []

frameset'_ ∷ DynamicElementWithoutProperties
frameset'_ = frameset' []

h1 ∷ StaticElement
h1 = make "h1"

h1' ∷ DynamicElement
h1' = make' "h1"

h1_ ∷ StaticElementWithoutProperties
h1_ = h1 []

h1'_ ∷ DynamicElementWithoutProperties
h1'_ = h1' []

head ∷ StaticElement
head = make "head"

head' ∷ DynamicElement
head' = make' "head"

head_ ∷ StaticElementWithoutProperties
head_ = head []

head'_ ∷ DynamicElementWithoutProperties
head'_ = head' []

header ∷ StaticElement
header = make "header"

header' ∷ DynamicElement
header' = make' "header"

header_ ∷ StaticElementWithoutProperties
header_ = header []

header'_ ∷ DynamicElementWithoutProperties
header'_ = header' []

hr ∷ SelfClosingElement
hr props = make "hr" props []

html ∷ StaticElement
html = make "html"

html' ∷ DynamicElement
html' = make' "html"

html_ ∷ StaticElementWithoutProperties
html_ = html []

html'_ ∷ DynamicElementWithoutProperties
html'_ = html' []

i ∷ StaticElement
i = make "i"

i' ∷ DynamicElement
i' = make' "i"

i_ ∷ StaticElementWithoutProperties
i_ = i []

i'_ ∷ DynamicElementWithoutProperties
i'_ = i' []

iframe ∷ StaticElement
iframe = make "iframe"

iframe' ∷ DynamicElement
iframe' = make' "iframe"

iframe_ ∷ StaticElementWithoutProperties
iframe_ = iframe []

iframe'_ ∷ DynamicElementWithoutProperties
iframe'_ = iframe' []

img ∷ SelfClosingElement
img props = make "img" props []

input ∷ SelfClosingElement
input props = make "input" props []

ins ∷ StaticElement
ins = make "ins"

ins' ∷ DynamicElement
ins' = make' "ins"

ins_ ∷ StaticElementWithoutProperties
ins_ = ins []

ins'_ ∷ DynamicElementWithoutProperties
ins'_ = ins' []

kbd ∷ StaticElement
kbd = make "kbd"

kbd' ∷ DynamicElement
kbd' = make' "kbd"

kbd_ ∷ StaticElementWithoutProperties
kbd_ = kbd []

kbd'_ ∷ DynamicElementWithoutProperties
kbd'_ = kbd' []

keygen ∷ SelfClosingElement
keygen props = make "kbd" props []

label ∷ StaticElement
label = make "label"

label' ∷ DynamicElement
label' = make' "label"

label_ ∷ StaticElementWithoutProperties
label_ = label []

label'_ ∷ DynamicElementWithoutProperties
label'_ = label' []

legend ∷ StaticElement
legend = make "legend"

legend' ∷ DynamicElement
legend' = make' "legend"

legend_ ∷ StaticElementWithoutProperties
legend_ = legend []

legend'_ ∷ DynamicElementWithoutProperties
legend'_ = legend' []

li ∷ StaticElement
li = make "li"

li' ∷ DynamicElement
li' = make' "li"

li_ ∷ StaticElementWithoutProperties
li_ = li []

li'_ ∷ DynamicElementWithoutProperties
li'_ = li' []

link ∷ SelfClosingElement
link props = make "link" props []

main ∷ StaticElement
main = make "main"

main' ∷ DynamicElement
main' = make' "main"

main_ ∷ StaticElementWithoutProperties
main_ = main []

main'_ ∷ DynamicElementWithoutProperties
main'_ = main' []

map ∷ StaticElement
map = make "map"

map' ∷ DynamicElement
map' = make' "map"

map_ ∷ StaticElementWithoutProperties
map_ = map []

map'_ ∷ DynamicElementWithoutProperties
map'_ = map' []

mark ∷ StaticElement
mark = make "mark"

mark' ∷ DynamicElement
mark' = make' "mark"

mark_ ∷ StaticElementWithoutProperties
mark_ = mark []

mark'_ ∷ DynamicElementWithoutProperties
mark'_ = mark' []

menu ∷ StaticElement
menu = make "menu"

menu' ∷ DynamicElement
menu' = make' "menu"

menu_ ∷ StaticElementWithoutProperties
menu_ = menu []

menu'_ ∷ DynamicElementWithoutProperties
menu'_ = menu' []

menuitem ∷ SelfClosingElement
menuitem props = make "menuitem" props []

meta ∷ SelfClosingElement
meta props = make "meta" props []

meter ∷ StaticElement
meter = make "meter"

meter' ∷ DynamicElement
meter' = make' "meter"

meter_ ∷ StaticElementWithoutProperties
meter_ = meter []

meter'_ ∷ DynamicElementWithoutProperties
meter'_ = meter' []

nav ∷ StaticElement
nav = make "nav"

nav' ∷ DynamicElement
nav' = make' "nav"

nav_ ∷ StaticElementWithoutProperties
nav_ = nav []

nav'_ ∷ DynamicElementWithoutProperties
nav'_ = nav' []

noframes ∷ StaticElement
noframes = make "noframes"

noframes' ∷ DynamicElement
noframes' = make' "noframes"

noframes_ ∷ StaticElementWithoutProperties
noframes_ = noframes []

noframes'_ ∷ DynamicElementWithoutProperties
noframes'_ = noframes' []

noscript ∷ StaticElement
noscript = make "noscript"

noscript' ∷ DynamicElement
noscript' = make' "noscript"

noscript_ ∷ StaticElementWithoutProperties
noscript_ = noscript []

noscript'_ ∷ DynamicElementWithoutProperties
noscript'_ = noscript' []

object ∷ StaticElement
object = make "object"

object' ∷ DynamicElement
object' = make' "object"

object_ ∷ StaticElementWithoutProperties
object_ = object []

object'_ ∷ DynamicElementWithoutProperties
object'_ = object' []

ol ∷ StaticElement
ol = make "ol"

ol' ∷ DynamicElement
ol' = make' "ol"

ol_ ∷ StaticElementWithoutProperties
ol_ = ol []

ol'_ ∷ DynamicElementWithoutProperties
ol'_ = ol' []

optgroup ∷ StaticElement
optgroup = make "optgroup"

optgroup' ∷ DynamicElement
optgroup' = make' "optgroup"

optgroup_ ∷ StaticElementWithoutProperties
optgroup_ = optgroup []

optgroup'_ ∷ DynamicElementWithoutProperties
optgroup'_ = optgroup' []

option ∷ StaticElement
option = make "option"

option' ∷ DynamicElement
option' = make' "option"

option_ ∷ StaticElementWithoutProperties
option_ = option []

option'_ ∷ DynamicElementWithoutProperties
option'_ = option' []

output ∷ StaticElement
output = make "output"

output' ∷ DynamicElement
output' = make' "output"

output_ ∷ StaticElementWithoutProperties
output_ = output []

output'_ ∷ DynamicElementWithoutProperties
output'_ = output' []

p ∷ StaticElement
p = make "p"

p' ∷ DynamicElement
p' = make' "p"

p_ ∷ StaticElementWithoutProperties
p_ = p []

p'_ ∷ DynamicElementWithoutProperties
p'_ = p' []

param ∷ SelfClosingElement
param props = make "param" props []

picture ∷ StaticElement
picture = make "picture"

picture' ∷ DynamicElement
picture' = make' "picture"

picture_ ∷ StaticElementWithoutProperties
picture_ = picture []

picture'_ ∷ DynamicElementWithoutProperties
picture'_ = picture' []

pre ∷ StaticElement
pre = make "pre"

pre' ∷ DynamicElement
pre' = make' "pre"

pre_ ∷ StaticElementWithoutProperties
pre_ = pre []

pre'_ ∷ DynamicElementWithoutProperties
pre'_ = pre' []

progress ∷ StaticElement
progress = make "progress"

progress' ∷ DynamicElement
progress' = make' "progress"

progress_ ∷ StaticElementWithoutProperties
progress_ = progress []

progress'_ ∷ DynamicElementWithoutProperties
progress'_ = progress' []

q ∷ StaticElement
q = make "q"

q' ∷ DynamicElement
q' = make' "q"

q_ ∷ StaticElementWithoutProperties
q_ = q []

q'_ ∷ DynamicElementWithoutProperties
q'_ = q' []

rp ∷ StaticElement
rp = make "rp"

rp' ∷ DynamicElement
rp' = make' "rp"

rp_ ∷ StaticElementWithoutProperties
rp_ = rp []

rp'_ ∷ DynamicElementWithoutProperties
rp'_ = rp' []

rt ∷ StaticElement
rt = make "rt"

rt' ∷ DynamicElement
rt' = make' "rt"

rt_ ∷ StaticElementWithoutProperties
rt_ = rt []

rt'_ ∷ DynamicElementWithoutProperties
rt'_ = rt' []

ruby ∷ StaticElement
ruby = make "ruby"

ruby' ∷ DynamicElement
ruby' = make' "ruby"

ruby_ ∷ StaticElementWithoutProperties
ruby_ = ruby []

ruby'_ ∷ DynamicElementWithoutProperties
ruby'_ = ruby' []

s ∷ StaticElement
s = make "s"

s' ∷ DynamicElement
s' = make' "s"

s_ ∷ StaticElementWithoutProperties
s_ = s []

s'_ ∷ DynamicElementWithoutProperties
s'_ = s' []

samp ∷ StaticElement
samp = make "samp"

samp' ∷ DynamicElement
samp' = make' "samp"

samp_ ∷ StaticElementWithoutProperties
samp_ = samp []

samp'_ ∷ DynamicElementWithoutProperties
samp'_ = samp' []

script ∷ StaticElement
script = make "script"

script' ∷ DynamicElement
script' = make' "script"

script_ ∷ StaticElementWithoutProperties
script_ = script []

script'_ ∷ DynamicElementWithoutProperties
script'_ = script' []

section ∷ StaticElement
section = make "section"

section' ∷ DynamicElement
section' = make' "section"

section_ ∷ StaticElementWithoutProperties
section_ = section []

section'_ ∷ DynamicElementWithoutProperties
section'_ = section' []

select ∷ StaticElement
select = make "select"

select' ∷ DynamicElement
select' = make' "select"

select_ ∷ StaticElementWithoutProperties
select_ = select []

select'_ ∷ DynamicElementWithoutProperties
select'_ = select' []

small ∷ StaticElement
small = make "small"

small' ∷ DynamicElement
small' = make' "small"

small_ ∷ StaticElementWithoutProperties
small_ = small []

small'_ ∷ DynamicElementWithoutProperties
small'_ = small' []

source ∷ SelfClosingElement
source props = make "source" props []

span ∷ StaticElement
span = make "span"

span' ∷ DynamicElement
span' = make' "span"

span_ ∷ StaticElementWithoutProperties
span_ = span []

span'_ ∷ DynamicElementWithoutProperties
span'_ = span' []

strike ∷ StaticElement
strike = make "strike"

strike' ∷ DynamicElement
strike' = make' "strike"

strike_ ∷ StaticElementWithoutProperties
strike_ = strike []

strike'_ ∷ DynamicElementWithoutProperties
strike'_ = strike' []

strong ∷ StaticElement
strong = make "strong"

strong' ∷ DynamicElement
strong' = make' "strong"

strong_ ∷ StaticElementWithoutProperties
strong_ = strong []

strong'_ ∷ DynamicElementWithoutProperties
strong'_ = strong' []

style ∷ StaticElement
style = make "style"

style' ∷ DynamicElement
style' = make' "style"

style_ ∷ StaticElementWithoutProperties
style_ = style []

style'_ ∷ DynamicElementWithoutProperties
style'_ = style' []

sub ∷ StaticElement
sub = make "sub"

sub' ∷ DynamicElement
sub' = make' "sub"

sub_ ∷ StaticElementWithoutProperties
sub_ = sub []

sub'_ ∷ DynamicElementWithoutProperties
sub'_ = sub' []

summary ∷ StaticElement
summary = make "summary"

summary' ∷ DynamicElement
summary' = make' "summary"

summary_ ∷ StaticElementWithoutProperties
summary_ = summary []

summary'_ ∷ DynamicElementWithoutProperties
summary'_ = summary' []

sup ∷ StaticElement
sup = make "sup"

sup' ∷ DynamicElement
sup' = make' "sup"

sup_ ∷ StaticElementWithoutProperties
sup_ = sup []

sup'_ ∷ DynamicElementWithoutProperties
sup'_ = sup' []

table ∷ StaticElement
table = make "table"

table' ∷ DynamicElement
table' = make' "table"

table_ ∷ StaticElementWithoutProperties
table_ = table []

table'_ ∷ DynamicElementWithoutProperties
table'_ = table' []

tbody ∷ StaticElement
tbody = make "tbody"

tbody' ∷ DynamicElement
tbody' = make' "tbody"

tbody_ ∷ StaticElementWithoutProperties
tbody_ = tbody []

tbody'_ ∷ DynamicElementWithoutProperties
tbody'_ = tbody' []

td ∷ StaticElement
td = make "td"

td' ∷ DynamicElement
td' = make' "td"

td_ ∷ StaticElementWithoutProperties
td_ = td []

td'_ ∷ DynamicElementWithoutProperties
td'_ = td' []

template ∷ StaticElement
template = make "template"

template' ∷ DynamicElement
template' = make' "template"

template_ ∷ StaticElementWithoutProperties
template_ = template []

template'_ ∷ DynamicElementWithoutProperties
template'_ = template' []

text
  ∷ ∀ eff update state event
  . String
  → Types.Component eff update state event
text
  = Types.CText

textarea ∷ StaticElement
textarea = make "textarea"

textarea' ∷ DynamicElement
textarea' = make' "textarea"

textarea_ ∷ StaticElementWithoutProperties
textarea_ = textarea []

textarea'_ ∷ DynamicElementWithoutProperties
textarea'_ = textarea' []

tfoot ∷ StaticElement
tfoot = make "tfoot"

tfoot' ∷ DynamicElement
tfoot' = make' "tfoot"

tfoot_ ∷ StaticElementWithoutProperties
tfoot_ = tfoot []

tfoot'_ ∷ DynamicElementWithoutProperties
tfoot'_ = tfoot' []

th ∷ StaticElement
th = make "th"

th' ∷ DynamicElement
th' = make' "th"

th_ ∷ StaticElementWithoutProperties
th_ = th []

th'_ ∷ DynamicElementWithoutProperties
th'_ = th' []

thead ∷ StaticElement
thead = make "thead"

thead' ∷ DynamicElement
thead' = make' "thead"

thead_ ∷ StaticElementWithoutProperties
thead_ = thead []

thead'_ ∷ DynamicElementWithoutProperties
thead'_ = thead' []

time ∷ StaticElement
time = make "time"

time' ∷ DynamicElement
time' = make' "time"

time_ ∷ StaticElementWithoutProperties
time_ = time []

time'_ ∷ DynamicElementWithoutProperties
time'_ = time' []

title ∷ StaticElement
title = make "title"

title' ∷ DynamicElement
title' = make' "title"

title_ ∷ StaticElementWithoutProperties
title_ = title []

title'_ ∷ DynamicElementWithoutProperties
title'_ = title' []

tr ∷ StaticElement
tr = make "tr"

tr' ∷ DynamicElement
tr' = make' "tr"

tr_ ∷ StaticElementWithoutProperties
tr_ = tr []

tr'_ ∷ DynamicElementWithoutProperties
tr'_ = tr' []

track ∷ SelfClosingElement
track props = make "track" props []

tt ∷ StaticElement
tt = make "tt"

tt' ∷ DynamicElement
tt' = make' "tt"

tt_ ∷ StaticElementWithoutProperties
tt_ = tt []

tt'_ ∷ DynamicElementWithoutProperties
tt'_ = tt' []

u ∷ StaticElement
u = make "u"

u' ∷ DynamicElement
u' = make' "u"

u_ ∷ StaticElementWithoutProperties
u_ = u []

u'_ ∷ DynamicElementWithoutProperties
u'_ = u' []

ul ∷ StaticElement
ul = make "ul"

ul' ∷ DynamicElement
ul' = make' "ul"

ul_ ∷ StaticElementWithoutProperties
ul_ = ul []

ul'_ ∷ DynamicElementWithoutProperties
ul'_ = ul' []

var ∷ StaticElement
var = make "var"

var' ∷ DynamicElement
var' = make' "var"

var_ ∷ StaticElementWithoutProperties
var_ = var []

var'_ ∷ DynamicElementWithoutProperties
var'_ = var' []

video ∷ StaticElement
video = make "video"

video' ∷ DynamicElement
video' = make' "video"

video_ ∷ StaticElementWithoutProperties
video_ = video []

video'_ ∷ DynamicElementWithoutProperties
video'_ = video' []

wbr ∷ SelfClosingElement
wbr props = make "wbr" props []
