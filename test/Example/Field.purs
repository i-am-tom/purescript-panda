module Test.Example.Field where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Data.Maybe        (Maybe(Just))
import Data.String       (toUpper)

import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

newtype TextEvent
  = TextEvent String

view
  :: forall eff update
   . P.Component eff update String TextEvent
view
  = PH.div_
      [ PH.input
          [ PP.onInput \text ->
              Just (TextEvent text)
          , PP.placeholder "Text to shout"
          ]

      , PH.span'_ $ PH.renderAlways' PH.text
      ]

main :: forall eff. Eff (P.FX eff) Unit
main
  = void
      ( P.runApplication
        { view
        , subscription: empty
        , initial:
            { update: unit
            , state:  ""
            }

        , update: \dispatch { event: TextEvent string } ->
            dispatch \_ ->
              { state: toUpper string
              , update: unit
              }
        }
      )
