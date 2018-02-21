module Panda.HTML.Elements where

import Panda.Internal.Types as Types
import Prelude              (($))

a
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
a properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "a"
        }

a_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
a_
  = a []

abbr
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
abbr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "abbr"
        }

abbr_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
abbr_
  = abbr []

acronym
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
acronym properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "acronym"
        }

acronym_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
acronym_
  = acronym []

address
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
address properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "address"
        }

address_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
address_
  = address []

applet
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
applet properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "applet"
        }

applet_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
applet_
  = applet []

area
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
area properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "area"
        }

area_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
area_
  = area []

article
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
article properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "article"
        }

article_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
article_
  = article []

aside
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
aside properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "aside"
        }

aside_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
aside_
  = aside []

audio
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
audio properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "audio"
        }

audio_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
audio_
  = audio []

b
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
b properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "b"
        }

b_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
b_
  = b []

base
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
base properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "base"
        }

base_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
base_
  = base []

basefont
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
basefont properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "basefont"
        }

basefont_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
basefont_
  = basefont []

bdi
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
bdi properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "bdi"
        }

bdi_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
bdi_
  = bdi []

bdo
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
bdo properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "bdo"
        }

bdo_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
bdo_
  = bdo []

big
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
big properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "big"
        }

big_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
big_
  = big []

blockquote
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
blockquote properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "blockquote"
        }

blockquote_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
blockquote_
  = blockquote []

body
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
body properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "body"
        }

body_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
body_
  = body []

br
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
br properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "br"
        }

br_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
br_
  = br []

button
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
button properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "button"
        }

button_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
button_
  = button []

canvas
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
canvas properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "canvas"
        }

canvas_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
canvas_
  = canvas []

caption
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
caption properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "caption"
        }

caption_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
caption_
  = caption []

center
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
center properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "center"
        }

center_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
center_
  = center []

cite
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
cite properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "cite"
        }

cite_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
cite_
  = cite []

code
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
code properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "code"
        }

code_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
code_
  = code []

col
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
col properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "col"
        }

col_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
col_
  = col []

colgroup
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
colgroup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "colgroup"
        }

colgroup_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
colgroup_
  = colgroup []

datalist
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
datalist properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "datalist"
        }

datalist_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
datalist_
  = datalist []

dd
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dd properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dd"
        }

dd_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dd_
  = dd []

del
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
del properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "del"
        }

del_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
del_
  = del []

details
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
details properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "details"
        }

details_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
details_
  = details []

dfn
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dfn properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dfn"
        }

dfn_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dfn_
  = dfn []

dialog
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dialog properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dialog"
        }

dialog_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dialog_
  = dialog []

dir
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dir properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dir"
        }

dir_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dir_
  = dir []

div
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
div properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "div"
        }

div_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
div_
  = div []

dl
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dl properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dl"
        }

dl_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dl_
  = dl []

dt
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
dt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dt"
        }

dt_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
dt_
  = dt []

em
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
em properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "em"
        }

em_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
em_
  = em []

embed
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
embed properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "embed"
        }

embed_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
embed_
  = embed []

fieldset
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
fieldset properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "fieldset"
        }

fieldset_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
fieldset_
  = fieldset []

figcaption
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
figcaption properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "figcaption"
        }

figcaption_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
figcaption_
  = figcaption []

figure
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
figure properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "figure"
        }

figure_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
figure_
  = figure []

font
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
font properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "font"
        }

font_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
font_
  = font []

footer
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
footer properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "footer"
        }

footer_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
footer_
  = footer []

form
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
form properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "form"
        }

form_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
form_
  = form []

fragment
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
fragment children
  = Types.CStatic $
      Types.ComponentStatic
        { properties: []
        , children
        , tagName: "fragment"
        }

frame
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
frame properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "frame"
        }

frame_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
frame_
  = frame []

frameset
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
frameset properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "frameset"
        }

frameset_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
frameset_
  = frameset []

h1
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
h1 properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "h1"
        }

h1_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
h1_
  = h1 []

head
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
head properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "head"
        }

head_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
head_
  = head []

header
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
header properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "header"
        }

header_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
header_
  = header []

hr
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
hr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "hr"
        }

hr_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
hr_
  = hr []

html
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
html properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "html"
        }

html_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
html_
  = html []

i
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
i properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "i"
        }

i_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
i_
  = i []

iframe
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
iframe properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "iframe"
        }

iframe_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
iframe_
  = iframe []

img
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
img properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "img"
        }

img_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
img_
  = img []

input
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
input properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "input"
        }

input_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
input_
  = input []

ins
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
ins properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ins"
        }

ins_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
ins_
  = ins []

kbd
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
kbd properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "kbd"
        }

kbd_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
kbd_
  = kbd []

label
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
label properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "label"
        }

label_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
label_
  = label []

legend
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
legend properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "legend"
        }

legend_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
legend_
  = legend []

li
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
li properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "li"
        }

li_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
li_
  = li []

link
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
link properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "link"
        }

link_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
link_
  = link []

main
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
main properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "main"
        }

main_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
main_
  = main []

map
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
map properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "map"
        }

map_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
map_
  = map []

mark
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
mark properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "mark"
        }

mark_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
mark_
  = mark []

menu
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
menu properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "menu"
        }

menu_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
menu_
  = menu []

menuitem
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
menuitem properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "menuitem"
        }

menuitem_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
menuitem_
  = menuitem []

meta
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
meta properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "meta"
        }

meta_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
meta_
  = meta []

meter
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
meter properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "meter"
        }

meter_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
meter_
  = meter []

nav
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
nav properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "nav"
        }

nav_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
nav_
  = nav []

noframes
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
noframes properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "noframes"
        }

noframes_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
noframes_
  = noframes []

noscript
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
noscript properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "noscript"
        }

noscript_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
noscript_
  = noscript []

object
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
object properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "object"
        }

object_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
object_
  = object []

ol
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
ol properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ol"
        }

ol_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
ol_
  = ol []

optgroup
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
optgroup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "optgroup"
        }

optgroup_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
optgroup_
  = optgroup []

option
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
option properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "option"
        }

option_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
option_
  = option []

output
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
output properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "output"
        }

output_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
output_
  = output []

p
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
p properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "p"
        }

p_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
p_
  = p []

param
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
param properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "param"
        }

param_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
param_
  = param []

picture
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
picture properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "picture"
        }

picture_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
picture_
  = picture []

pre
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
pre properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "pre"
        }

pre_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
pre_
  = pre []

progress
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
progress properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "progress"
        }

progress_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
progress_
  = progress []

q
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
q properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "q"
        }

q_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
q_
  = q []

rp
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
rp properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "rp"
        }

rp_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
rp_
  = rp []

rt
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
rt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "rt"
        }

rt_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
rt_
  = rt []

ruby
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
ruby properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ruby"
        }

ruby_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
ruby_
  = ruby []

s
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
s properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "s"
        }

s_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
s_
  = s []

samp
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
samp properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "samp"
        }

samp_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
samp_
  = samp []

script
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
script properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "script"
        }

script_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
script_
  = script []

section
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
section properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "section"
        }

section_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
section_
  = section []

select
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
select properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "select"
        }

select_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
select_
  = select []

small
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
small properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "small"
        }

small_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
small_
  = small []

source
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
source properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "source"
        }

source_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
source_
  = source []

span
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
span properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "span"
        }

span_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
span_
  = span []

strike
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
strike properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "strike"
        }

strike_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
strike_
  = strike []

strong
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
strong properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "strong"
        }

strong_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
strong_
  = strong []

style
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
style properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "style"
        }

style_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
style_
  = style []

sub
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
sub properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "sub"
        }

sub_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
sub_
  = sub []

summary
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
summary properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "summary"
        }

summary_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
summary_
  = summary []

sup
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
sup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "sup"
        }

sup_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
sup_
  = sup []

table
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
table properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "table"
        }

table_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
table_
  = table []

tbody
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
tbody properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tbody"
        }

tbody_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
tbody_
  = tbody []

td
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
td properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "td"
        }

td_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
td_
  = td []

template
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
template properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "template"
        }

template_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
template_
  = template []

text
  ∷ ∀ eff update state event
  . String
  → Types.Component eff update state event
text
  = Types.CText

textarea
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
textarea properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "textarea"
        }

textarea_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
textarea_
  = textarea []

tfoot
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
tfoot properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tfoot"
        }

tfoot_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
tfoot_
  = tfoot []

th
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
th properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "th"
        }

th_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
th_
  = th []

thead
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
thead properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "thead"
        }

thead_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
thead_
  = thead []

time
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
time properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "time"
        }

time_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
time_
  = time []

title
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
title properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "title"
        }

title_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
title_
  = title []

tr
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
tr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tr"
        }

tr_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
tr_
  = tr []

track
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
track properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "track"
        }

track_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
track_
  = track []

tt
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
tt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tt"
        }

tt_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
tt_
  = tt []

u
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
u properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "u"
        }

u_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
u_
  = u []

ul
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
ul properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ul"
        }

ul_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
ul_
  = ul []

var
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
var properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "var"
        }

var_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
var_
  = var []

video
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
video properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "video"
        }

video_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
video_
  = video []

wbr
  ∷ ∀ eff update state event
  . Array (Types.Property update state event)
  → Array (Types.Component eff update state event)
  → Types.Component eff update state event
wbr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "wbr"
        }

wbr_
  ∷ ∀ eff update state event
  . Array (Types.Component eff update state event)
  → Types.Component eff update state event
wbr_
  = wbr []
