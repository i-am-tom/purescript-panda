module Panda.Builders.HTML
  ( module Collection

  , a
  , a'
  , a'_
  , a_
  , abbr
  , abbr'
  , abbr'_
  , abbr_
  , acronym
  , acronym'
  , acronym'_
  , acronym_
  , address
  , address'
  , address'_
  , address_
  , applet
  , applet'
  , applet'_
  , applet_
  , area
  , area_
  , article
  , article'
  , article'_
  , article_
  , aside
  , aside'
  , aside'_
  , aside_
  , audio
  , audio'
  , audio'_
  , audio_
  , b
  , b'
  , b'_
  , b_
  , base
  , base_
  , basefont
  , basefont'
  , basefont'_
  , basefont_
  , bdi
  , bdi'
  , bdi'_
  , bdi_
  , bdo
  , bdo'
  , bdo'_
  , bdo_
  , big
  , big'
  , big'_
  , big_
  , blockquote
  , blockquote'
  , blockquote'_
  , blockquote_
  , br
  , br_
  , button
  , button'
  , button'_
  , button_
  , canvas
  , canvas'
  , canvas'_
  , canvas_
  , caption
  , caption'
  , caption'_
  , caption_
  , center
  , center'
  , center'_
  , center_
  , cite
  , cite'
  , cite'_
  , cite_
  , code
  , code'
  , code'_
  , code_
  , col
  , col_
  , colgroup
  , colgroup'
  , colgroup'_
  , colgroup_
  , command
  , command_
  , datalist
  , datalist'
  , datalist'_
  , datalist_
  , dd
  , dd'
  , dd'_
  , dd_
  , del
  , del'
  , del'_
  , del_
  , details
  , details'
  , details'_
  , details_
  , dfn
  , dfn'
  , dfn'_
  , dfn_
  , dialog
  , dialog'
  , dialog'_
  , dialog_
  , dir
  , dir'
  , dir'_
  , dir_
  , div
  , div'
  , div'_
  , div_
  , dl
  , dl'
  , dl'_
  , dl_
  , dt
  , dt'
  , dt'_
  , dt_
  , em
  , em'
  , em'_
  , em_
  , embed
  , embed_
  , fieldset
  , fieldset'
  , fieldset'_
  , fieldset_
  , figcaption
  , figcaption'
  , figcaption'_
  , figcaption_
  , figure
  , figure'
  , figure'_
  , figure_
  , font
  , font'
  , font'_
  , font_
  , footer
  , footer'
  , footer'_
  , footer_
  , form
  , form'
  , form'_
  , form_
  , frame
  , frame'
  , frame'_
  , frame_
  , frameset
  , frameset'
  , frameset'_
  , frameset_
  , h1
  , h1'
  , h1'_
  , h1_
  , head
  , head'
  , head'_
  , head_
  , header
  , header'
  , header'_
  , header_
  , hr
  , hr_
  , i
  , i'
  , i'_
  , i_
  , iframe
  , iframe'
  , iframe'_
  , iframe_
  , img
  , img_
  , input
  , input_
  , ins
  , ins'
  , ins'_
  , ins_
  , kbd
  , kbd'
  , kbd'_
  , kbd_
  , keygen
  , keygen_
  , label
  , label'
  , label'_
  , label_
  , legend
  , legend'
  , legend'_
  , legend_
  , li
  , li'
  , li'_
  , li_
  , main
  , main'
  , main'_
  , main_
  , map
  , map'
  , map'_
  , map_
  , mark
  , mark'
  , mark'_
  , mark_
  , menu
  , menu'
  , menu'_
  , menu_
  , menuitem
  , menuitem_
  , meter
  , meter'
  , meter'_
  , meter_
  , nav
  , nav'
  , nav'_
  , nav_
  , noframes
  , noframes'
  , noframes'_
  , noframes_
  , noscript
  , noscript'
  , noscript'_
  , noscript_
  , object
  , object'
  , object'_
  , object_
  , ol
  , ol'
  , ol'_
  , ol_
  , optgroup
  , optgroup'
  , optgroup'_
  , optgroup_
  , option
  , option'
  , option'_
  , option_
  , output
  , output'
  , output'_
  , output_
  , p
  , p'
  , p'_
  , p_
  , param
  , param_
  , picture
  , picture'
  , picture'_
  , picture_
  , pre
  , pre'
  , pre'_
  , pre_
  , progress
  , progress'
  , progress'_
  , progress_
  , q
  , q'
  , q'_
  , q_
  , rp
  , rp'
  , rp'_
  , rp_
  , rt
  , rt'
  , rt'_
  , rt_
  , ruby
  , ruby'
  , ruby'_
  , ruby_
  , s
  , s'
  , s'_
  , s_
  , samp
  , samp'
  , samp'_
  , samp_
  , script
  , script'
  , script'_
  , script_
  , section
  , section'
  , section'_
  , section_
  , select
  , select'
  , select'_
  , select_
  , small
  , small'
  , small'_
  , small_
  , source
  , source_
  , span
  , span'
  , span'_
  , span_
  , strike
  , strike'
  , strike'_
  , strike_
  , strong
  , strong'
  , strong'_
  , strong_
  , style
  , style'
  , style'_
  , style_
  , sub
  , sub'
  , sub'_
  , sub_
  , summary
  , summary'
  , summary'_
  , summary_
  , sup
  , sup'
  , sup'_
  , sup_
  , table
  , table'
  , table'_
  , table_
  , tbody
  , tbody'
  , tbody'_
  , tbody_
  , td
  , td'
  , td'_
  , td_
  , template
  , template'
  , template'_
  , template_
  , text
  , textarea
  , textarea'
  , textarea'_
  , textarea_
  , tfoot
  , tfoot'
  , tfoot'_
  , tfoot_
  , th
  , th'
  , th'_
  , th_
  , thead
  , thead'
  , thead'_
  , thead_
  , time
  , time'
  , time'_
  , time_
  , title
  , title'
  , title'_
  , title_
  , tr
  , tr'
  , tr'_
  , tr_
  , track
  , track_
  , tt
  , tt'
  , tt'_
  , tt_
  , u
  , u'
  , u'_
  , u_
  , ul
  , ul'
  , ul'_
  , ul_
  , var
  , var'
  , var'_
  , var_
  , video
  , video'
  , video'_
  , video_
  , wbr
  , wbr_
  ) where

import Panda.Internal.Types           as Types
import Panda.Builders.HTML.Collection as Collection

-- | A fully-polymorphic component (and therefore either an element or text).

type Element
  = ∀ input message state
  . Array (Types.Property input message state)
  → Array (Types.HTML input message state)
  → Types.HTML input message state

-- | A fully-polymorphic component with no properties.

type ElementNoProperties
  = ∀ input message state
  . Array (Types.HTML input message state)
  → Types.HTML input message state

-- | A fully-polymorphic component with no children.

type SelfClosingElement
  = ∀ input message state
  . Array (Types.Property input message state)
  → Types.HTML input message state

-- | A fully-polymorphic component with no children or properties.

type SelfClosingElementNoProperties
  = ∀ input message state
  . Types.HTML input message state

-- | A fully-polymorphic container component.

type Collection
  = ∀ input message state
  . Array (Types.Property input message state)
  → ( { input ∷ input, state ∷ state }
    → Array (Types.HTMLUpdate input message state)
    )
  → Types.HTML input message state

-- | A fully-polymorphic container component with no properties.

type CollectionNoProperties
  = ∀ input message state
  . ( { input ∷ input, state ∷ state }
    → Array (Types.HTMLUpdate input message state)
    )
  → Types.HTML input message state

-- | Make an element from its component parts.

make ∷ String → Element
make tagName properties children
  = Types.Element
      { tagName
      , properties
      , children
      }

-- | Make a "collection" element from some container. These are collections in
-- | the Panda sense - element containers that are open to incremental updates.

collection ∷ String → Collection
collection tagName properties watcher
  = Types.Collection
      { tagName
      , properties
      , watcher
      }

{- Here we go... -}

a ∷ Element
a = make "a"

a' ∷ Collection
a' = collection "a"

a'_ ∷ CollectionNoProperties
a'_ = a' []

a_ ∷ ElementNoProperties
a_ = a []

abbr ∷ Element
abbr = make "abbr"

abbr' ∷ Collection
abbr' = collection "abbr"

abbr'_ ∷ CollectionNoProperties
abbr'_ = abbr' []

abbr_ ∷ ElementNoProperties
abbr_ = abbr []

acronym ∷ Element
acronym = make "acronym"

acronym' ∷ Collection
acronym' = collection "acronym"

acronym'_ ∷ CollectionNoProperties
acronym'_ = acronym' []

acronym_ ∷ ElementNoProperties
acronym_ = acronym []

address ∷ Element
address = make "address"

address' ∷ Collection
address' = collection "address"

address'_ ∷ CollectionNoProperties
address'_ = address' []

address_ ∷ ElementNoProperties
address_ = address []

applet ∷ Element
applet = make "applet"

applet' ∷ Collection
applet' = collection "applet"

applet'_ ∷ CollectionNoProperties
applet'_ = applet' []

applet_ ∷ ElementNoProperties
applet_ = applet []

area ∷ SelfClosingElement
area props = make "area" props []

area_ ∷ SelfClosingElementNoProperties
area_ = area []

article ∷ Element
article = make "article"

article' ∷ Collection
article' = collection "article"

article'_ ∷ CollectionNoProperties
article'_ = article' []

article_ ∷ ElementNoProperties
article_ = article []

aside ∷ Element
aside = make "aside"

aside' ∷ Collection
aside' = collection "aside"

aside'_ ∷ CollectionNoProperties
aside'_ = aside' []

aside_ ∷ ElementNoProperties
aside_ = aside []

audio ∷ Element
audio = make "audio"

audio' ∷ Collection
audio' = collection "audio"

audio'_ ∷ CollectionNoProperties
audio'_ = audio' []

audio_ ∷ ElementNoProperties
audio_ = audio []

b ∷ Element
b = make "b"

b' ∷ Collection
b' = collection "b"

b'_ ∷ CollectionNoProperties
b'_ = b' []

b_ ∷ ElementNoProperties
b_ = b []

base ∷ SelfClosingElement
base props = make "base" props []

base_ ∷ SelfClosingElementNoProperties
base_ = base []

basefont ∷ Element
basefont = make "basefont"

basefont' ∷ Collection
basefont' = collection "basefont"

basefont'_ ∷ CollectionNoProperties
basefont'_ = basefont' []

basefont_ ∷ ElementNoProperties
basefont_ = basefont []

bdi ∷ Element
bdi = make "bdi"

bdi' ∷ Collection
bdi' = collection "bdi"

bdi'_ ∷ CollectionNoProperties
bdi'_ = bdi' []

bdi_ ∷ ElementNoProperties
bdi_ = bdi []

bdo ∷ Element
bdo = make "bdo"

bdo' ∷ Collection
bdo' = collection "bdo"

bdo'_ ∷ CollectionNoProperties
bdo'_ = bdo' []

bdo_ ∷ ElementNoProperties
bdo_ = bdo []

big ∷ Element
big = make "big"

big' ∷ Collection
big' = collection "big"

big'_ ∷ CollectionNoProperties
big'_ = big' []

big_ ∷ ElementNoProperties
big_ = big []

blockquote ∷ Element
blockquote = make "blockquote"

blockquote' ∷ Collection
blockquote' = collection "blockquote"

blockquote'_ ∷ CollectionNoProperties
blockquote'_ = blockquote' []

blockquote_ ∷ ElementNoProperties
blockquote_ = make "blockquote" []

br ∷ SelfClosingElement
br props = make "br" props []

br_ ∷ SelfClosingElementNoProperties
br_ = br []

button ∷ Element
button = make "button"

button' ∷ Collection
button' = collection "button"

button'_ ∷ CollectionNoProperties
button'_ = button' []

button_ ∷ ElementNoProperties
button_ = button []

canvas ∷ Element
canvas = make "canvas"

canvas' ∷ Collection
canvas' = collection "canvas"

canvas'_ ∷ CollectionNoProperties
canvas'_ = canvas' []

canvas_ ∷ ElementNoProperties
canvas_ = canvas []

caption ∷ Element
caption = make "caption"

caption' ∷ Collection
caption' = collection "caption"

caption'_ ∷ CollectionNoProperties
caption'_ = caption' []

caption_ ∷ ElementNoProperties
caption_ = caption []

center ∷ Element
center = make "center"

center' ∷ Collection
center' = collection "center"

center'_ ∷ CollectionNoProperties
center'_ = center' []

center_ ∷ ElementNoProperties
center_ = center []

cite ∷ Element
cite = make "cite"

cite' ∷ Collection
cite' = collection "cite"

cite'_ ∷ CollectionNoProperties
cite'_ = cite' []

cite_ ∷ ElementNoProperties
cite_ = cite []

code ∷ Element
code = make "code"

code' ∷ Collection
code' = collection "code"

code'_ ∷ CollectionNoProperties
code'_ = code' []

code_ ∷ ElementNoProperties
code_ = code []

col ∷ SelfClosingElement
col props = make "col" props []

col_ ∷ SelfClosingElementNoProperties
col_ = col []

colgroup ∷ Element
colgroup = make "colgroup"

colgroup' ∷ Collection
colgroup' = collection "colgroup"

colgroup'_ ∷ CollectionNoProperties
colgroup'_ = colgroup' []

colgroup_ ∷ ElementNoProperties
colgroup_ = colgroup []

command ∷ SelfClosingElement
command props = make "command" props []

command_ ∷ SelfClosingElementNoProperties
command_ = command []

datalist ∷ Element
datalist = make "datalist"

datalist' ∷ Collection
datalist' = collection "datalist"

datalist'_ ∷ CollectionNoProperties
datalist'_ = datalist' []

datalist_ ∷ ElementNoProperties
datalist_ = datalist []

dd ∷ Element
dd = make "dd"

dd' ∷ Collection
dd' = collection "dd"

dd'_ ∷ CollectionNoProperties
dd'_ = dd' []

dd_ ∷ ElementNoProperties
dd_ = dd []

del ∷ Element
del = make "del"

del' ∷ Collection
del' = collection "del"

del'_ ∷ CollectionNoProperties
del'_ = del' []

del_ ∷ ElementNoProperties
del_ = del []

details ∷ Element
details = make "details"

details' ∷ Collection
details' = collection "details"

details'_ ∷ CollectionNoProperties
details'_ = details' []

details_ ∷ ElementNoProperties
details_ = details []

dfn ∷ Element
dfn = make "dfn"

dfn' ∷ Collection
dfn' = collection "dfn"

dfn'_ ∷ CollectionNoProperties
dfn'_ = dfn' []

dfn_ ∷ ElementNoProperties
dfn_ = dfn []

dialog ∷ Element
dialog = make "dialog"

dialog' ∷ Collection
dialog' = collection "dialog"

dialog'_ ∷ CollectionNoProperties
dialog'_ = dialog' []

dialog_ ∷ ElementNoProperties
dialog_ = dialog []

dir ∷ Element
dir = make "dir"

dir' ∷ Collection
dir' = collection "dir"

dir'_ ∷ CollectionNoProperties
dir'_ = dir' []

dir_ ∷ ElementNoProperties
dir_ = dir []

div ∷ Element
div = make "div"

div' ∷ Collection
div' = collection "div"

div'_ ∷ CollectionNoProperties
div'_ = div' []

div_ ∷ ElementNoProperties
div_ = div []

dl ∷ Element
dl = make "dl"

dl' ∷ Collection
dl' = collection "dl"

dl'_ ∷ CollectionNoProperties
dl'_ = dl' []

dl_ ∷ ElementNoProperties
dl_ = dl []

dt ∷ Element
dt = make "dt"

dt' ∷ Collection
dt' = collection "dt"

dt'_ ∷ CollectionNoProperties
dt'_ = dt' []

dt_ ∷ ElementNoProperties
dt_ = dt []

em ∷ Element
em = make "em"

em' ∷ Collection
em' = collection "em"

em'_ ∷ CollectionNoProperties
em'_ = em' []

em_ ∷ ElementNoProperties
em_ = em []

embed ∷ SelfClosingElement
embed props = make "embed" props []

embed_ ∷ SelfClosingElementNoProperties
embed_ = embed []

fieldset ∷ Element
fieldset = make "fieldset"

fieldset' ∷ Collection
fieldset' = collection "fieldset"

fieldset'_ ∷ CollectionNoProperties
fieldset'_ = fieldset' []

fieldset_ ∷ ElementNoProperties
fieldset_ = fieldset []

figcaption ∷ Element
figcaption = make "figcaption"

figcaption' ∷ Collection
figcaption' = collection "figcaption"

figcaption'_ ∷ CollectionNoProperties
figcaption'_ = figcaption' []

figcaption_ ∷ ElementNoProperties
figcaption_ = figcaption []

figure ∷ Element
figure = make "figure"

figure' ∷ Collection
figure' = collection "figure"

figure'_ ∷ CollectionNoProperties
figure'_ = figure' []

figure_ ∷ ElementNoProperties
figure_ = figure []

font ∷ Element
font = make "font"

font' ∷ Collection
font' = collection "font"

font'_ ∷ CollectionNoProperties
font'_ = font' []

font_ ∷ ElementNoProperties
font_ = font []

footer ∷ Element
footer = make "footer"

footer' ∷ Collection
footer' = collection "footer"

footer'_ ∷ CollectionNoProperties
footer'_ = footer' []

footer_ ∷ ElementNoProperties
footer_ = footer []

form ∷ Element
form = make "form"

form' ∷ Collection
form' = collection "form"

form'_ ∷ CollectionNoProperties
form'_ = form' []

form_ ∷ ElementNoProperties
form_ = form []

frame ∷ Element
frame = make "frame"

frame' ∷ Collection
frame' = collection "frame"

frame'_ ∷ CollectionNoProperties
frame'_ = frame' []

frame_ ∷ ElementNoProperties
frame_ = frame []

frameset ∷ Element
frameset = make "frameset"

frameset' ∷ Collection
frameset' = collection "frameset"

frameset'_ ∷ CollectionNoProperties
frameset'_ = frameset' []

frameset_ ∷ ElementNoProperties
frameset_ = frameset []

h1 ∷ Element
h1 = make "h1"

h1' ∷ Collection
h1' = collection "h1"

h1'_ ∷ CollectionNoProperties
h1'_ = h1' []

h1_ ∷ ElementNoProperties
h1_ = h1 []

head ∷ Element
head = make "head"

head' ∷ Collection
head' = collection "head"

head'_ ∷ CollectionNoProperties
head'_ = head' []

head_ ∷ ElementNoProperties
head_ = head []

header ∷ Element
header = make "header"

header' ∷ Collection
header' = collection "header"

header'_ ∷ CollectionNoProperties
header'_ = header' []

header_ ∷ ElementNoProperties
header_ = header []

hr ∷ SelfClosingElement
hr props = make "hr" props []

hr_ ∷ SelfClosingElementNoProperties
hr_ = hr []

i ∷ Element
i = make "i"

i' ∷ Collection
i' = collection "i"

i'_ ∷ CollectionNoProperties
i'_ = i' []

i_ ∷ ElementNoProperties
i_ = i []

iframe ∷ Element
iframe = make "iframe"

iframe' ∷ Collection
iframe' = collection "iframe"

iframe'_ ∷ CollectionNoProperties
iframe'_ = iframe' []

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

ins' ∷ Collection
ins' = collection "ins"

ins'_ ∷ CollectionNoProperties
ins'_ = ins' []

ins_ ∷ ElementNoProperties
ins_ = ins []

kbd ∷ Element
kbd = make "kbd"

kbd' ∷ Collection
kbd' = collection "kbd"

kbd'_ ∷ CollectionNoProperties
kbd'_ = kbd' []

kbd_ ∷ ElementNoProperties
kbd_ = kbd []

keygen ∷ SelfClosingElement
keygen props = make "keygen" props []

keygen_ ∷ SelfClosingElementNoProperties
keygen_ = keygen []

label ∷ Element
label = make "label"

label' ∷ Collection
label' = collection "label"

label'_ ∷ CollectionNoProperties
label'_ = label' []

label_ ∷ ElementNoProperties
label_ = label []

legend ∷ Element
legend = make "legend"

legend' ∷ Collection
legend' = collection "legend"

legend'_ ∷ CollectionNoProperties
legend'_ = legend' []

legend_ ∷ ElementNoProperties
legend_ = legend []

li ∷ Element
li = make "li"

li' ∷ Collection
li' = collection "li"

li'_ ∷ CollectionNoProperties
li'_ = li' []

li_ ∷ ElementNoProperties
li_ = li []

main ∷ Element
main = make "main"

main' ∷ Collection
main' = collection "main"

main'_ ∷ CollectionNoProperties
main'_ = main' []

main_ ∷ ElementNoProperties
main_ = main []

map ∷ Element
map = make "map"

map' ∷ Collection
map' = collection "map"

map'_ ∷ CollectionNoProperties
map'_ = map' []

map_ ∷ ElementNoProperties
map_ = map []

mark ∷ Element
mark = make "mark"

mark' ∷ Collection
mark' = collection "mark"

mark'_ ∷ CollectionNoProperties
mark'_ = mark' []

mark_ ∷ ElementNoProperties
mark_ = mark []

menu ∷ Element
menu = make "menu"

menu' ∷ Collection
menu' = collection "menu"

menu'_ ∷ CollectionNoProperties
menu'_ = menu' []

menu_ ∷ ElementNoProperties
menu_ = menu []

menuitem ∷ SelfClosingElement
menuitem props = make "menuitem" props []

menuitem_ ∷ SelfClosingElementNoProperties
menuitem_ = menuitem []

meter ∷ Element
meter = make "meter"

meter' ∷ Collection
meter' = collection "meter"

meter'_ ∷ CollectionNoProperties
meter'_ = meter' []

meter_ ∷ ElementNoProperties
meter_ = meter []

nav ∷ Element
nav = make "nav"

nav' ∷ Collection
nav' = collection "nav"

nav'_ ∷ CollectionNoProperties
nav'_ = nav' []

nav_ ∷ ElementNoProperties
nav_ = nav []

noframes ∷ Element
noframes = make "noframes"

noframes' ∷ Collection
noframes' = collection "noframes"

noframes'_ ∷ CollectionNoProperties
noframes'_ = noframes' []

noframes_ ∷ ElementNoProperties
noframes_ = noframes []

noscript ∷ Element
noscript = make "noscript"

noscript' ∷ Collection
noscript' = collection "noscript"

noscript'_ ∷ CollectionNoProperties
noscript'_ = noscript' []

noscript_ ∷ ElementNoProperties
noscript_ = noscript []

object ∷ Element
object = make "object"

object' ∷ Collection
object' = collection "object"

object'_ ∷ CollectionNoProperties
object'_ = object' []

object_ ∷ ElementNoProperties
object_ = object []

ol ∷ Element
ol = make "ol"

ol' ∷ Collection
ol' = collection "ol"

ol'_ ∷ CollectionNoProperties
ol'_ = ol' []

ol_ ∷ ElementNoProperties
ol_ = ol []

optgroup ∷ Element
optgroup = make "optgroup"

optgroup' ∷ Collection
optgroup' = collection "optgroup"

optgroup'_ ∷ CollectionNoProperties
optgroup'_ = optgroup' []

optgroup_ ∷ ElementNoProperties
optgroup_ = optgroup []

option ∷ Element
option = make "option"

option' ∷ Collection
option' = collection "option"

option'_ ∷ CollectionNoProperties
option'_ = option' []

option_ ∷ ElementNoProperties
option_ = option []

output ∷ Element
output = make "output"

output' ∷ Collection
output' = collection "output"

output'_ ∷ CollectionNoProperties
output'_ = output' []

output_ ∷ ElementNoProperties
output_ = output []

p ∷ Element
p = make "p"

p' ∷ Collection
p' = collection "p"

p'_ ∷ CollectionNoProperties
p'_ = p' []

p_ ∷ ElementNoProperties
p_ = p []

param ∷ SelfClosingElement
param props = make "param" props []

param_ ∷ SelfClosingElementNoProperties
param_ = param []

picture ∷ Element
picture = make "picture"

picture' ∷ Collection
picture' = collection "picture"

picture'_ ∷ CollectionNoProperties
picture'_ = picture' []

picture_ ∷ ElementNoProperties
picture_ = picture []

pre ∷ Element
pre = make "pre"

pre' ∷ Collection
pre' = collection "pre"

pre'_ ∷ CollectionNoProperties
pre'_ = pre' []

pre_ ∷ ElementNoProperties
pre_ = pre []

progress ∷ Element
progress = make "progress"

progress' ∷ Collection
progress' = collection "progress"

progress'_ ∷ CollectionNoProperties
progress'_ = progress' []

progress_ ∷ ElementNoProperties
progress_ = progress []

q ∷ Element
q = make "q"

q' ∷ Collection
q' = collection "q"

q'_ ∷ CollectionNoProperties
q'_ = q' []

q_ ∷ ElementNoProperties
q_ = q []

rp ∷ Element
rp = make "rp"

rp' ∷ Collection
rp' = collection "rp"

rp'_ ∷ CollectionNoProperties
rp'_ = rp' []

rp_ ∷ ElementNoProperties
rp_ = rp []

rt ∷ Element
rt = make "rt"

rt' ∷ Collection
rt' = collection "rt"

rt'_ ∷ CollectionNoProperties
rt'_ = rt' []

rt_ ∷ ElementNoProperties
rt_ = rt []

ruby ∷ Element
ruby = make "ruby"

ruby' ∷ Collection
ruby' = collection "ruby"

ruby'_ ∷ CollectionNoProperties
ruby'_ = ruby' []

ruby_ ∷ ElementNoProperties
ruby_ = ruby []

s ∷ Element
s = make "s"

s' ∷ Collection
s' = collection "s"

s'_ ∷ CollectionNoProperties
s'_ = s' []

s_ ∷ ElementNoProperties
s_ = s []

samp ∷ Element
samp = make "samp"

samp' ∷ Collection
samp' = collection "samp"

samp'_ ∷ CollectionNoProperties
samp'_ = samp' []

samp_ ∷ ElementNoProperties
samp_ = samp []

script ∷ Element
script = make "script"

script' ∷ Collection
script' = collection "script"

script'_ ∷ CollectionNoProperties
script'_ = script' []

script_ ∷ ElementNoProperties
script_ = script []

section ∷ Element
section = make "section"

section' ∷ Collection
section' = collection "section"

section'_ ∷ CollectionNoProperties
section'_ = section' []

section_ ∷ ElementNoProperties
section_ = section []

select ∷ Element
select = make "select"

select' ∷ Collection
select' = collection "select"

select'_ ∷ CollectionNoProperties
select'_ = select' []

select_ ∷ ElementNoProperties
select_ = select []

small ∷ Element
small = make "small"

small' ∷ Collection
small' = collection "small"

small'_ ∷ CollectionNoProperties
small'_ = small' []

small_ ∷ ElementNoProperties
small_ = small []

source ∷ SelfClosingElement
source props = make "source" props []

source_ ∷ SelfClosingElementNoProperties
source_ = source []

span ∷ Element
span = make "span"

span' ∷ Collection
span' = collection "span"

span'_ ∷ CollectionNoProperties
span'_ = span' []

span_ ∷ ElementNoProperties
span_ = span []

strike ∷ Element
strike = make "strike"

strike' ∷ Collection
strike' = collection "strike"

strike'_ ∷ CollectionNoProperties
strike'_ = strike' []

strike_ ∷ ElementNoProperties
strike_ = strike []

strong ∷ Element
strong = make "strong"

strong' ∷ Collection
strong' = collection "strong"

strong'_ ∷ CollectionNoProperties
strong'_ = strong' []

strong_ ∷ ElementNoProperties
strong_ = strong []

style ∷ Element
style = make "style"

style' ∷ Collection
style' = collection "style"

style'_ ∷ CollectionNoProperties
style'_ = style' []

style_ ∷ ElementNoProperties
style_ = style []

sub ∷ Element
sub = make "sub"

sub' ∷ Collection
sub' = collection "sub"

sub'_ ∷ CollectionNoProperties
sub'_ = sub' []

sub_ ∷ ElementNoProperties
sub_ = sub []

summary ∷ Element
summary = make "summary"

summary' ∷ Collection
summary' = collection "summary"

summary'_ ∷ CollectionNoProperties
summary'_ = summary' []

summary_ ∷ ElementNoProperties
summary_ = summary []

sup ∷ Element
sup = make "sup"

sup' ∷ Collection
sup' = collection "sup"

sup'_ ∷ CollectionNoProperties
sup'_ = sup' []

sup_ ∷ ElementNoProperties
sup_ = sup []

table ∷ Element
table = make "table"

table' ∷ Collection
table' = collection "table"

table'_ ∷ CollectionNoProperties
table'_ = table' []

table_ ∷ ElementNoProperties
table_ = table []

tbody ∷ Element
tbody = make "tbody"

tbody' ∷ Collection
tbody' = collection "tbody"

tbody'_ ∷ CollectionNoProperties
tbody'_ = tbody' []

tbody_ ∷ ElementNoProperties
tbody_ = tbody []

td ∷ Element
td = make "td"

td' ∷ Collection
td' = collection "td"

td'_ ∷ CollectionNoProperties
td'_ = td' []

td_ ∷ ElementNoProperties
td_ = td []

template ∷ Element
template = make "template"

template' ∷ Collection
template' = collection "template"

template'_ ∷ CollectionNoProperties
template'_ = template' []

template_ ∷ ElementNoProperties
template_ = template []

text
  ∷ ∀ input message state
  . String
  → Types.HTML input message state
text
  = Types.Text

textarea ∷ Element
textarea = make "textarea"

textarea' ∷ Collection
textarea' = collection "textarea"

textarea'_ ∷ CollectionNoProperties
textarea'_ = textarea' []

textarea_ ∷ ElementNoProperties
textarea_ = textarea []

tfoot ∷ Element
tfoot = make "tfoot"

tfoot' ∷ Collection
tfoot' = collection "tfoot"

tfoot'_ ∷ CollectionNoProperties
tfoot'_ = tfoot' []

tfoot_ ∷ ElementNoProperties
tfoot_ = tfoot []

th ∷ Element
th = make "th"

th' ∷ Collection
th' = collection "th"

th'_ ∷ CollectionNoProperties
th'_ = th' []

th_ ∷ ElementNoProperties
th_ = th []

thead ∷ Element
thead = make "thead"

thead' ∷ Collection
thead' = collection "thead"

thead'_ ∷ CollectionNoProperties
thead'_ = thead' []

thead_ ∷ ElementNoProperties
thead_ = thead []

time ∷ Element
time = make "time"

time' ∷ Collection
time' = collection "time"

time'_ ∷ CollectionNoProperties
time'_ = time' []

time_ ∷ ElementNoProperties
time_ = time []

title ∷ Element
title = make "title"

title' ∷ Collection
title' = collection "title"

title'_ ∷ CollectionNoProperties
title'_ = title' []

title_ ∷ ElementNoProperties
title_ = title []

tr ∷ Element
tr = make "tr"

tr' ∷ Collection
tr' = collection "tr"

tr'_ ∷ CollectionNoProperties
tr'_ = tr' []

tr_ ∷ ElementNoProperties
tr_ = tr []

track ∷ SelfClosingElement
track props = make "track" props []

track_ ∷ SelfClosingElementNoProperties
track_ = track []

tt ∷ Element
tt = make "tt"

tt' ∷ Collection
tt' = collection "tt"

tt'_ ∷ CollectionNoProperties
tt'_ = tt' []

tt_ ∷ ElementNoProperties
tt_ = tt []

u ∷ Element
u = make "u"

u' ∷ Collection
u' = collection "u"

u'_ ∷ CollectionNoProperties
u'_ = u' []

u_ ∷ ElementNoProperties
u_ = u []

ul ∷ Element
ul = make "ul"

ul' ∷ Collection
ul' = collection "ul"

ul'_ ∷ CollectionNoProperties
ul'_ = ul' []

ul_ ∷ ElementNoProperties
ul_ = ul []

var ∷ Element
var = make "var"

var' ∷ Collection
var' = collection "var"

var'_ ∷ CollectionNoProperties
var'_ = var' []

var_ ∷ ElementNoProperties
var_ = var []

video ∷ Element
video = make "video"

video' ∷ Collection
video' = collection "video"

video'_ ∷ CollectionNoProperties
video'_ = video' []

video_ ∷ ElementNoProperties
video_ = video []

wbr ∷ SelfClosingElement
wbr props = make "wbr" props []

wbr_ ∷ SelfClosingElementNoProperties
wbr_ = wbr []
