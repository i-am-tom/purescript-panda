module Main where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Data.Monoid       (mempty)

import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

data Event
  = Increment
  | Decrement

main ∷ ∀ eff. Eff (P.FX eff) Unit
main
  = void $ P.runApplication
      { view: PH.div_
          [ PH.button
              [ PP.onClick \_ → Decrement
              ]

              [ PH.text "-"
              ]

          , PH.watchAny \{ state } →
              PH.text (show state)

          , PH.button
              [ PP.onClick \_ → Increment
              ]

              [ PH.text "+"
              ]
          ]

      , subscription: empty
      , initial:
          { update: unit
          , state: 0
          }

      , update: \dispatch { event } →
          dispatch \state → case event of
            Increment →
              { state: state + 1
              , update: unit
              }

            Decrement →
              { state: state - 1
              , update: unit
              }
      }

--  = void $ P.runApplication
--      { view: PH.ul
--          [ PP.className "grocery-list"
--          ]
--
--          $ ingredients <#> \ingredient →
--              PH.li_ [ PH.text ingredient ]
--      , subscription: empty
--      , initial:
--          { update: unit
--          , state: unit
--          }
--      , update: mempty
--      }
--  where
--    ingredients
--      = [ "Pamplemousse"
--        , "Ananas"
--        , "Jus d'orange"
--        , "Boeuf"
--        , "Soupe du jour"
--        , "Camembert"
--        , "Jacques Cousteau"
--        , "Baguette"
--        ]

--  = void $ P.runApplication
--      { view: PH.text "Hello, World!"
--      , subscription: empty
--      , initial:
--          { update: unit
--          , state: unit
--          }
--      , update: mempty
--      }
