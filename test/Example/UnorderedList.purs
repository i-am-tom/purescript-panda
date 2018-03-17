module Test.Example.UnorderedList where

import Control.Monad.Eff (Eff)
import Control.Plus (empty)

import Prelude (($), Unit, unit, pure, void)

-- Let's get a bit more creative, and introduce some common tags.
import Panda          as P
import Panda.HTML     (ul, li_, text)
import Panda.Property (className)

-- Note the type here: we say that this component will work _for all_ effects,
-- update, state, and event types. It is totally polymorphic!
view :: forall eff update state event. P.Component eff update state event
view
  = ul -- Without an underscore suffix, tags expect a list of properties as
       -- well. Here, we're only supplying a class name.
      [ className "grocery-list"
      ]

      [ li_ [ text "Pamplemousse"     ]
      , li_ [ text "Ananas"           ]
      , li_ [ text "Jus d'orange"     ]
      , li_ [ text "Boeuf"            ]
      , li_ [ text "Soupe du jour"    ]
      , li_ [ text "Camembert"        ]
      , li_ [ text "Jacques Cousteau" ]
      , li_ [ text "Baguette"         ]
      ]

main :: forall eff. Eff (P.FX eff) Unit
main
  = void $ P.runApplication
      { view
      , subscription: empty
      , initial: { update: unit, state: unit }
      , update: \_ _ -> pure unit
      }
