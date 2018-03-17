module Test.Example.Buttons where

import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import Data.Maybe (Maybe(Just))

import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

-- This is our event type. Right now, not particularly interesting.
data Event = Increment | Decrement

-- Here, we have to care what state is - it has to be an integer - and we are
-- specifically throwing `Event`-type events, so these types are fixed.
-- However, we're still not too picky about the effects we use, nor the type of
-- update (as we'll just be ignoring the actual value).
view
  :: forall eff update
   . P.Component eff update Int Event
view
  = PH.div_
      [ PH.button
          [ PP.onClick \_ -> Just Decrement
          ]

          [ PH.text "-"
          ]

      , PH.span'_ $ PH.renderAlways \{ state } ->
          PH.text (show state)

      , PH.button
          [ PP.onClick \_ -> Just Increment
          ]

          [ PH.text "+"
          ]
      ]


main :: forall eff. Eff (P.FX eff) Unit
main
  = void
      ( P.runApplication
        { view
        , subscription: empty
        , initial:
            { update: unit
            , state:  0
            }

        , update: \dispatch { event } ->
            let
              dispatch' f
                = dispatch \state ->
                    { update: unit
                    , state: f state
                    }

            in case event of
              Increment -> dispatch' (_ + 1)
              Decrement -> dispatch' (_ - 1)
        }
      )
