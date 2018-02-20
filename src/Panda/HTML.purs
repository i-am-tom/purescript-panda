module Panda.HTML where

import Panda.Internal.Types as Types
import Prelude

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

text
  ∷ ∀ eff update state event
  . String
  → Types.Component eff update state event
text string
  = Types.CText string

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
