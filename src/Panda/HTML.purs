module Panda.HTML where

import Panda.Internal.Types as Types
import Prelude

a
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
a properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "a"
        }

abbr
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
abbr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "abbr"
        }

acronym
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
acronym properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "acronym"
        }

address
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
address properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "address"
        }

applet
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
applet properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "applet"
        }

area
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
area properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "area"
        }

article
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
article properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "article"
        }

aside
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
aside properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "aside"
        }

audio
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
audio properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "audio"
        }

b
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
b properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "b"
        }

base
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
base properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "base"
        }

basefont
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
basefont properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "basefont"
        }

bdi
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
bdi properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "bdi"
        }

bdo
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
bdo properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "bdo"
        }

big
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
big properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "big"
        }

blockquote
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
blockquote properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "blockquote"
        }

body
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
body properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "body"
        }

br
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
br properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "br"
        }

button
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
button properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "button"
        }

canvas
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
canvas properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "canvas"
        }

caption
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
caption properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "caption"
        }

center
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
center properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "center"
        }

cite
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
cite properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "cite"
        }

code
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
code properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "code"
        }

col
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
col properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "col"
        }

colgroup
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
colgroup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "colgroup"
        }

datalist
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
datalist properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "datalist"
        }

dd
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dd properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dd"
        }

del
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
del properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "del"
        }

details
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
details properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "details"
        }

dfn
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dfn properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dfn"
        }

dialog
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dialog properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dialog"
        }

dir
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dir properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dir"
        }

div
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
div properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "div"
        }

dl
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dl properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dl"
        }

dt
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
dt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "dt"
        }

em
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
em properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "em"
        }

embed
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
embed properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "embed"
        }

fieldset
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
fieldset properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "fieldset"
        }

figcaption
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
figcaption properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "figcaption"
        }

figure
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
figure properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "figure"
        }

font
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
font properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "font"
        }

footer
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
footer properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "footer"
        }

form
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
form properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "form"
        }

fragment
  ∷ ∀ update state event
  . Array (Types.Component update state event)
  → Types.Component update state event
fragment children
  = Types.CStatic $
      Types.ComponentStatic
        { properties: []
        , children
        , tagName: "fragment"
        }

frame
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
frame properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "frame"
        }

frameset
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
frameset properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "frameset"
        }

h1
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
h1 properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "h1"
        }

head
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
head properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "head"
        }

header
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
header properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "header"
        }

hr
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
hr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "hr"
        }

html
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
html properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "html"
        }

i
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
i properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "i"
        }

iframe
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
iframe properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "iframe"
        }

img
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
img properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "img"
        }

input
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
input properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "input"
        }

ins
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
ins properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ins"
        }

kbd
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
kbd properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "kbd"
        }

label
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
label properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "label"
        }

legend
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
legend properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "legend"
        }

li
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
li properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "li"
        }

link
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
link properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "link"
        }

main
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
main properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "main"
        }

map
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
map properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "map"
        }

mark
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
mark properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "mark"
        }

menu
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
menu properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "menu"
        }

menuitem
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
menuitem properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "menuitem"
        }

meta
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
meta properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "meta"
        }

meter
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
meter properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "meter"
        }

nav
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
nav properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "nav"
        }

noframes
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
noframes properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "noframes"
        }

noscript
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
noscript properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "noscript"
        }

object
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
object properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "object"
        }

ol
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
ol properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ol"
        }

optgroup
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
optgroup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "optgroup"
        }

option
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
option properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "option"
        }

output
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
output properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "output"
        }

p
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
p properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "p"
        }

param
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
param properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "param"
        }

picture
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
picture properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "picture"
        }

pre
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
pre properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "pre"
        }

progress
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
progress properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "progress"
        }

q
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
q properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "q"
        }

rp
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
rp properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "rp"
        }

rt
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
rt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "rt"
        }

ruby
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
ruby properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ruby"
        }

s
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
s properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "s"
        }

samp
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
samp properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "samp"
        }

script
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
script properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "script"
        }

section
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
section properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "section"
        }

select
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
select properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "select"
        }

small
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
small properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "small"
        }

source
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
source properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "source"
        }

span
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
span properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "span"
        }

strike
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
strike properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "strike"
        }

strong
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
strong properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "strong"
        }

style
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
style properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "style"
        }

sub
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
sub properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "sub"
        }

summary
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
summary properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "summary"
        }

sup
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
sup properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "sup"
        }

table
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
table properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "table"
        }

tbody
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
tbody properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tbody"
        }

td
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
td properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "td"
        }

template
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
template properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "template"
        }

text
  ∷ ∀ update state event
  . String
  → Types.Component update state event
text string
  = Types.CText string

textarea
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
textarea properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "textarea"
        }

tfoot
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
tfoot properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tfoot"
        }

th
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
th properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "th"
        }

thead
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
thead properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "thead"
        }

time
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
time properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "time"
        }

title
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
title properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "title"
        }

tr
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
tr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tr"
        }

track
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
track properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "track"
        }

tt
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
tt properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "tt"
        }

u
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
u properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "u"
        }

ul
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
ul properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "ul"
        }

var
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
var properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "var"
        }

video
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
video properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "video"
        }

wbr
  ∷ ∀ update state event
  . Array (Types.Property update state event)
  → Array (Types.Component update state event)
  → Types.Component update state event
wbr properties children
  = Types.CStatic $
      Types.ComponentStatic
        { properties
        , children
        , tagName: "wbr"
        }
