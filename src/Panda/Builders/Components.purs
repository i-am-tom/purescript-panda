module Panda.Builders.Elements
  ( module Panda.Builders.Elements

  , a
  , a_
  , abbr
  , abbr_
  , acronym
  , acronym_
  , address
  , address_
  , applet
  , applet_
  , article
  , article_
  , aside
  , aside_
  , audio
  , audio_
  , b
  , b_
  , basefont
  , basefont_
  , bdi
  , bdi_
  , bdo
  , bdo_
  , big
  , big_
  , blockquote
  , blockquote_
  , button
  , button_
  , canvas
  , canvas_
  , caption
  , caption_
  , center
  , center_
  , cite
  , cite_
  , code
  , code_
  , colgroup
  , colgroup_
  , datalist
  , datalist_
  , dd
  , dd_
  , del
  , del_
  , details
  , details_
  , dfn
  , dfn_
  , dialog
  , dialog_
  , dir
  , dir_
  , div
  , div_
  , dl
  , dl_
  , dt
  , dt_
  , em
  , em_
  , fieldset
  , fieldset_
  , figcaption
  , figcaption_
  , figure
  , figure_
  , font
  , font_
  , footer
  , footer_
  , form
  , form_
  , frame
  , frame_
  , frameset
  , frameset_
  , h1
  , h1_
  , head
  , head_
  , header
  , header_
  , i
  , i_
  , iframe
  , iframe_
  , ins
  , ins_
  , kbd
  , kbd_
  , label
  , label_
  , legend
  , legend_
  , li
  , li_
  , main
  , main_
  , map
  , map_
  , mark
  , mark_
  , menu
  , menu_
  , meter
  , meter_
  , nav
  , nav_
  , noframes
  , noframes_
  , noscript
  , noscript_
  , object
  , object_
  , ol
  , ol_
  , optgroup
  , optgroup_
  , option
  , option_
  , output
  , output_
  , p
  , p_
  , picture
  , picture_
  , pre
  , pre_
  , progress
  , progress_
  , q
  , q_
  , rp
  , rp_
  , rt
  , rt_
  , ruby
  , ruby_
  , s
  , s_
  , samp
  , samp_
  , script
  , script_
  , section
  , section_
  , select
  , select_
  , small
  , small_
  , span
  , span_
  , strike
  , strike_
  , strong
  , strong_
  , style
  , style_
  , sub
  , sub_
  , summary
  , summary_
  , sup
  , sup_
  , table
  , table_
  , tbody
  , tbody_
  , td
  , td_
  , template
  , template_
  , text
  , textarea
  , textarea_
  , tfoot
  , tfoot_
  , th
  , th_
  , thead
  , thead_
  , time
  , time_
  , title
  , title_
  , tr
  , tr_
  , tt
  , tt_
  , u
  , u_
  , ul
  , ul_
  , var
  , var_
  , video
  , video_
  ) where

import Panda.Internal as I

-- | A fully-polymorphic component (and therefore either an element or text).

type Element
  = ∀ eff update state event
  . Array (I.Property update state event)
  → Array (I.Component eff update state event)
  → I.Component eff update state event

-- | A fully-polymorphic component with no properties.

type ElementNoProperties
  = ∀ eff update state event
  . Array (I.Component eff update state event)
  → I.Component eff update state event

-- | A fully-polymorphic component with no children.

type SelfClosingElement
  = ∀ eff update state event
  . Array (I.Property update state event)
  → I.Component eff update state event

-- | A fully-polymorphic component with no children or properties.

type SelfClosingElementNoProperties
  = ∀ eff update state event
  . I.Component eff update state event

-- | Make an element from its component parts.

make ∷ String → Element
make tagName properties children
  = I.ComponentElement
      { tagName
      , properties
      , children
      }

{- Here we go... -}

a ∷ Element
a = make "a"

a_ ∷ ElementNoProperties
a_ = a []

abbr ∷ Element
abbr = make "abbr"

abbr_ ∷ ElementNoProperties
abbr_ = abbr []

acronym ∷ Element
acronym = make "acronym"

acronym_ ∷ ElementNoProperties
acronym_ = acronym []

address ∷ Element
address = make "address"

address_ ∷ ElementNoProperties
address_ = address []

applet ∷ Element
applet = make "applet"

applet_ ∷ ElementNoProperties
applet_ = applet []

area ∷ SelfClosingElement
area props = make "area" props []

area_ ∷ SelfClosingElementNoProperties
area_ = area []

article ∷ Element
article = make "article"

article_ ∷ ElementNoProperties
article_ = article []

aside ∷ Element
aside = make "aside"

aside_ ∷ ElementNoProperties
aside_ = aside []

audio ∷ Element
audio = make "audio"

audio_ ∷ ElementNoProperties
audio_ = audio []

b ∷ Element
b = make "b"

b_ ∷ ElementNoProperties
b_ = b []

base ∷ SelfClosingElement
base props = make "base" props []

base_ ∷ SelfClosingElementNoProperties
base_ = base []

basefont ∷ Element
basefont = make "basefont"

basefont_ ∷ ElementNoProperties
basefont_ = basefont []

bdi ∷ Element
bdi = make "bdi"

bdi_ ∷ ElementNoProperties
bdi_ = bdi []

bdo ∷ Element
bdo = make "bdo"

bdo_ ∷ ElementNoProperties
bdo_ = bdo []

big ∷ Element
big = make "big"

big_ ∷ ElementNoProperties
big_ = big []

blockquote ∷ Element
blockquote = make "blockquote"

blockquote_ ∷ ElementNoProperties
blockquote_ = make "blockquote" []

br ∷ SelfClosingElement
br props = make "br" props []

br_ ∷ SelfClosingElementNoProperties
br_ = br []

button ∷ Element
button = make "button"

button_ ∷ ElementNoProperties
button_ = button []

canvas ∷ Element
canvas = make "canvas"

canvas_ ∷ ElementNoProperties
canvas_ = canvas []

caption ∷ Element
caption = make "caption"

caption_ ∷ ElementNoProperties
caption_ = caption []

center ∷ Element
center = make "center"

center_ ∷ ElementNoProperties
center_ = center []

cite ∷ Element
cite = make "cite"

cite_ ∷ ElementNoProperties
cite_ = cite []

code ∷ Element
code = make "code"

code_ ∷ ElementNoProperties
code_ = code []

col ∷ SelfClosingElement
col props = make "col" props []

col_ ∷ SelfClosingElementNoProperties
col_ = col []

colgroup ∷ Element
colgroup = make "colgroup"

colgroup_ ∷ ElementNoProperties
colgroup_ = colgroup []

command ∷ SelfClosingElement
command props = make "command" props []

command_ ∷ SelfClosingElementNoProperties
command_ = command []

datalist ∷ Element
datalist = make "datalist"

datalist_ ∷ ElementNoProperties
datalist_ = datalist []

dd ∷ Element
dd = make "dd"

dd_ ∷ ElementNoProperties
dd_ = dd []

del ∷ Element
del = make "del"

del_ ∷ ElementNoProperties
del_ = del []

details ∷ Element
details = make "details"

details_ ∷ ElementNoProperties
details_ = details []

dfn ∷ Element
dfn = make "dfn"

dfn_ ∷ ElementNoProperties
dfn_ = dfn []

dialog ∷ Element
dialog = make "dialog"

dialog_ ∷ ElementNoProperties
dialog_ = dialog []

dir ∷ Element
dir = make "dir"

dir_ ∷ ElementNoProperties
dir_ = dir []

div ∷ Element
div = make "div"

div_ ∷ ElementNoProperties
div_ = div []

dl ∷ Element
dl = make "dl"

dl_ ∷ ElementNoProperties
dl_ = dl []

dt ∷ Element
dt = make "dt"

dt_ ∷ ElementNoProperties
dt_ = dt []

em ∷ Element
em = make "em"

em_ ∷ ElementNoProperties
em_ = em []

embed ∷ SelfClosingElement
embed props = make "embed" props []

embed_ ∷ SelfClosingElementNoProperties
embed_ = embed []

fieldset ∷ Element
fieldset = make "fieldset"

fieldset_ ∷ ElementNoProperties
fieldset_ = fieldset []

figcaption ∷ Element
figcaption = make "figcaption"

figcaption_ ∷ ElementNoProperties
figcaption_ = figcaption []

figure ∷ Element
figure = make "figure"

figure_ ∷ ElementNoProperties
figure_ = figure []

font ∷ Element
font = make "font"

font_ ∷ ElementNoProperties
font_ = font []

footer ∷ Element
footer = make "footer"

footer_ ∷ ElementNoProperties
footer_ = footer []

form ∷ Element
form = make "form"

form_ ∷ ElementNoProperties
form_ = form []

frame ∷ Element
frame = make "frame"

frame_ ∷ ElementNoProperties
frame_ = frame []

frameset ∷ Element
frameset = make "frameset"

frameset_ ∷ ElementNoProperties
frameset_ = frameset []

h1 ∷ Element
h1 = make "h1"

h1_ ∷ ElementNoProperties
h1_ = h1 []

head ∷ Element
head = make "head"

head_ ∷ ElementNoProperties
head_ = head []

header ∷ Element
header = make "header"

header_ ∷ ElementNoProperties
header_ = header []

hr ∷ SelfClosingElement
hr props = make "hr" props []

hr_ ∷ SelfClosingElementNoProperties
hr_ = hr []

i ∷ Element
i = make "i"

i_ ∷ ElementNoProperties
i_ = i []

iframe ∷ Element
iframe = make "iframe"

iframe_ ∷ ElementNoProperties
iframe_ = iframe []

img ∷ SelfClosingElement
img props = make "img" props []

img_ ∷ SelfClosingElementNoProperties
img_ = img []

input ∷ SelfClosingElement
input props = make "input" props []

input_ ∷ SelfClosingElementNoProperties
input_ = input []

ins ∷ Element
ins = make "ins"

ins_ ∷ ElementNoProperties
ins_ = ins []

kbd ∷ Element
kbd = make "kbd"

kbd_ ∷ ElementNoProperties
kbd_ = kbd []

keygen ∷ SelfClosingElement
keygen props = make "keygen" props []

keygen_ ∷ SelfClosingElementNoProperties
keygen_ = keygen []

label ∷ Element
label = make "label"

label_ ∷ ElementNoProperties
label_ = label []

legend ∷ Element
legend = make "legend"

legend_ ∷ ElementNoProperties
legend_ = legend []

li ∷ Element
li = make "li"

li_ ∷ ElementNoProperties
li_ = li []

main ∷ Element
main = make "main"

main_ ∷ ElementNoProperties
main_ = main []

map ∷ Element
map = make "map"

map_ ∷ ElementNoProperties
map_ = map []

mark ∷ Element
mark = make "mark"

mark_ ∷ ElementNoProperties
mark_ = mark []

menu ∷ Element
menu = make "menu"

menu_ ∷ ElementNoProperties
menu_ = menu []

menuitem ∷ SelfClosingElement
menuitem props = make "menuitem" props []

menuitem_ ∷ SelfClosingElementNoProperties
menuitem_ = menuitem []

meter ∷ Element
meter = make "meter"

meter_ ∷ ElementNoProperties
meter_ = meter []

nav ∷ Element
nav = make "nav"

nav_ ∷ ElementNoProperties
nav_ = nav []

noframes ∷ Element
noframes = make "noframes"

noframes_ ∷ ElementNoProperties
noframes_ = noframes []

noscript ∷ Element
noscript = make "noscript"

noscript_ ∷ ElementNoProperties
noscript_ = noscript []

object ∷ Element
object = make "object"

object_ ∷ ElementNoProperties
object_ = object []

ol ∷ Element
ol = make "ol"

ol_ ∷ ElementNoProperties
ol_ = ol []

optgroup ∷ Element
optgroup = make "optgroup"

optgroup_ ∷ ElementNoProperties
optgroup_ = optgroup []

option ∷ Element
option = make "option"

option_ ∷ ElementNoProperties
option_ = option []

output ∷ Element
output = make "output"

output_ ∷ ElementNoProperties
output_ = output []

p ∷ Element
p = make "p"

p_ ∷ ElementNoProperties
p_ = p []

param ∷ SelfClosingElement
param props = make "param" props []

param_ ∷ SelfClosingElementNoProperties
param_ = param []

picture ∷ Element
picture = make "picture"

picture_ ∷ ElementNoProperties
picture_ = picture []

pre ∷ Element
pre = make "pre"

pre_ ∷ ElementNoProperties
pre_ = pre []

progress ∷ Element
progress = make "progress"

progress_ ∷ ElementNoProperties
progress_ = progress []

q ∷ Element
q = make "q"

q_ ∷ ElementNoProperties
q_ = q []

rp ∷ Element
rp = make "rp"

rp_ ∷ ElementNoProperties
rp_ = rp []

rt ∷ Element
rt = make "rt"

rt_ ∷ ElementNoProperties
rt_ = rt []

ruby ∷ Element
ruby = make "ruby"

ruby_ ∷ ElementNoProperties
ruby_ = ruby []

s ∷ Element
s = make "s"

s_ ∷ ElementNoProperties
s_ = s []

samp ∷ Element
samp = make "samp"

samp_ ∷ ElementNoProperties
samp_ = samp []

script ∷ Element
script = make "script"

script_ ∷ ElementNoProperties
script_ = script []

section ∷ Element
section = make "section"

section_ ∷ ElementNoProperties
section_ = section []

select ∷ Element
select = make "select"

select_ ∷ ElementNoProperties
select_ = select []

small ∷ Element
small = make "small"

small_ ∷ ElementNoProperties
small_ = small []

source ∷ SelfClosingElement
source props = make "source" props []

source_ ∷ SelfClosingElementNoProperties
source_ = source []

span ∷ Element
span = make "span"

span_ ∷ ElementNoProperties
span_ = span []

strike ∷ Element
strike = make "strike"

strike_ ∷ ElementNoProperties
strike_ = strike []

strong ∷ Element
strong = make "strong"

strong_ ∷ ElementNoProperties
strong_ = strong []

style ∷ Element
style = make "style"

style_ ∷ ElementNoProperties
style_ = style []

sub ∷ Element
sub = make "sub"

sub_ ∷ ElementNoProperties
sub_ = sub []

summary ∷ Element
summary = make "summary"

summary_ ∷ ElementNoProperties
summary_ = summary []

sup ∷ Element
sup = make "sup"

sup_ ∷ ElementNoProperties
sup_ = sup []

table ∷ Element
table = make "table"

table_ ∷ ElementNoProperties
table_ = table []

tbody ∷ Element
tbody = make "tbody"

tbody_ ∷ ElementNoProperties
tbody_ = tbody []

td ∷ Element
td = make "td"

td_ ∷ ElementNoProperties
td_ = td []

template ∷ Element
template = make "template"

template_ ∷ ElementNoProperties
template_ = template []

text
  ∷ ∀ eff update state event
  . String
  → I.Component eff update state event
text
  = I.ComponentText

textarea ∷ Element
textarea = make "textarea"

textarea_ ∷ ElementNoProperties
textarea_ = textarea []

tfoot ∷ Element
tfoot = make "tfoot"

tfoot_ ∷ ElementNoProperties
tfoot_ = tfoot []

th ∷ Element
th = make "th"

th_ ∷ ElementNoProperties
th_ = th []

thead ∷ Element
thead = make "thead"

thead_ ∷ ElementNoProperties
thead_ = thead []

time ∷ Element
time = make "time"

time_ ∷ ElementNoProperties
time_ = time []

title ∷ Element
title = make "title"

title_ ∷ ElementNoProperties
title_ = title []

tr ∷ Element
tr = make "tr"

tr_ ∷ ElementNoProperties
tr_ = tr []

track ∷ SelfClosingElement
track props = make "track" props []

track_ ∷ SelfClosingElementNoProperties
track_ = track []

tt ∷ Element
tt = make "tt"

tt_ ∷ ElementNoProperties
tt_ = tt []

u ∷ Element
u = make "u"

u_ ∷ ElementNoProperties
u_ = u []

ul ∷ Element
ul = make "ul"

ul_ ∷ ElementNoProperties
ul_ = ul []

var ∷ Element
var = make "var"

var_ ∷ ElementNoProperties
var_ = var []

video ∷ Element
video = make "video"

video_ ∷ ElementNoProperties
video_ = video []

wbr ∷ SelfClosingElement
wbr props = make "wbr" props []

wbr_ ∷ SelfClosingElementNoProperties
wbr_ = wbr []
