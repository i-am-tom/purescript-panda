module Main where

import Panda.HTML     (li, text, ul)
import Panda.Property (class_)

shopping
  ∷ Array String
shopping
  = [ "Pamplemousse"
    , "Ananas"
    , "Jus d'orange"
    , "Boeuf"
    , "Soupe du jour"
    , "Camembert"
    , "Jacques Cousteau"
    , "Baguette"
    ]

view
  = ul
      [ class_ "grocery-list"
      ]

      (map (\x → li_ [ text x ]) shopping)

main
  = renderApplication
      _ { view = view }
