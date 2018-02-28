module Main where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Data.Array        as Array
import Data.Maybe        (Maybe(..))
import Data.Monoid       (mempty)
import Data.String       (fromCharArray, toCharArray)

import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

---

main ∷ ∀ eff. Eff (P.FX eff) Unit
main = counter2

---

data Counter2Events
  = Increment
  | Decrement

counter2 ∷ ∀ eff. Eff (P.FX eff) Unit
counter2
  = void $ P.runApplication
      { view: PH.div_
          [ PH.button
              [ PP.onClick \_ → Just Decrement
              ]

              [ PH.text "-"
              ]

          , PH.watchAny \{ state } →
              Just (PH.text (show state))

          , PH.watchAny \{ update, state } →
              map PH.text if state > 0 && update
                then Just ":)"
                else if state < 0
                  then Nothing
                  else Just ":("

          , PH.button
              [ PP.onClick \_ → Just Increment
              ]

              [ PH.text "+"
              ]
          ]

      , subscription: empty
      , initial:
          { update: true
          , state: 0
          }

      , update: \dispatch { event } →
          dispatch \state → case event of
            Increment →
              { state: state + 1
              , update: true
              }

            Decrement →
              { state: state - 1
              , update: false
              }
      }

---

newtype TextChangeEvent
  = TextChange String

reverseString ∷ ∀ eff. Eff (P.FX eff) Unit
reverseString
  = void $ P.runApplication
      { view: PH.div_
          [ PH.input
              [ PP.onInput \ev → Just (TextChange ev)
              ]

          , PH.watchAny \{ state } →
              Just (PH.text (reverse state))
          ]
      , subscription: empty
      , initial:
          { update: unit
          , state: ""
          }
      , update: \dispatcher { event: TextChange value } →
          void $ dispatcher \state →
            { update: unit
            , state: value
            }
      }
  where
    reverse
        = fromCharArray
      <<< Array.reverse
      <<< toCharArray

---

data CounterEvents
  = CounterDecrement
  | CounterIncrement

counter ∷ ∀ eff. Eff (P.FX eff) Unit
counter
  = void $ P.runApplication
      { view: PH.div_
          [ PH.button
              [ PP.onClick \_ → Just CounterDecrement
              ]

              [ PH.text "-"
              ]

          , PH.watchAny \{ state } →
              Just (PH.text (show state))

          , PH.button
              [ PP.onClick \_ → Just CounterIncrement
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
            CounterIncrement →
              { state: state + 1
              , update: unit
              }

            CounterDecrement →
              { state: state - 1
              , update: unit
              }
      }

---

groceryList ∷ ∀ eff. Eff (P.FX eff) Unit
groceryList
  = void $ P.runApplication
      { view: PH.ul
          [ PP.className "grocery-list"
          ]

          $ ingredients <#> \ingredient →
              PH.li_ [ PH.text ingredient ]
      , subscription: empty
      , initial:
          { update: unit
          , state: unit
          }
      , update: mempty
      }
  where
    ingredients
      = [ "Pamplemousse"
        , "Ananas"
        , "Jus d'orange"
        , "Boeuf"
        , "Soupe du jour"
        , "Camembert"
        , "Jacques Cousteau"
        , "Baguette"
        ]

---

helloWorld ∷ ∀ eff. Eff (P.FX eff) Unit
helloWorld
  = void $ P.runApplication
      { view: PH.text "Hello, World!"
      , subscription: empty
      , initial:
          { update: unit
          , state: unit
          }
      , update: mempty
      }
