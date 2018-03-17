module Test.Example.Form where

import Control.Monad.Eff (Eff)
import Control.Plus      (empty)
import Data.Maybe        (Maybe(..))
import Prelude

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

type Model
  = { name          :: String
    , password      :: String
    , passwordAgain :: String
    }

initial :: { state :: Model, update :: Maybe Boolean }
initial
  = { state:
        { name:          ""
        , password:      ""
        , passwordAgain: ""
        }

    , update: Nothing
    }

data Event
  = NameChanged          String
  | PasswordChanged      String
  | PasswordAgainChanged String

-- Have passwords changed?
type Update = Maybe Boolean

-- | Here's a more interesting example of an updater: the state doesn't store
-- | whether the two passwords are equal (not that this is a particularly heavy
-- | calculation to perform, but this is a contrived example). However, we
-- | really want to perform it within our view, because we're mixing view
-- | logic with business logic. So, we use the update channel to inform the
-- | of which message to show.
updater :: forall eff. P.Updater eff (Maybe Boolean) Model Event
updater dispatch { event, state }
  = case event of
      NameChanged name ->
        dispatch \_ ->
          { update: Nothing
          , state: state { name = name }
          }

      PasswordChanged password -> do
        dispatch \_ ->
          { update: Just (state.passwordAgain == password)
          , state: state { password = password }
          }

      PasswordAgainChanged passwordAgain -> do
        dispatch \_ ->
          { update: Just (state.password == passwordAgain)
          , state: state { passwordAgain = passwordAgain }
          }

view :: forall eff. P.Component eff Update Model Event
view
  = PH.div_
      [ PH.input
          [ PP.type_ "text"
          , PP.placeholder "Name"
          , PP.onInput \name ->
              Just (NameChanged name)
          ]

      , PH.input
          [ PP.type_ "password"
          , PP.placeholder "Password"
          , PP.onInput \password ->
              Just (PasswordChanged password)
          ]

      , PH.input
          [ PP.type_ "password"
          , PP.placeholder "Re-enter password"
          , PP.onInput \passwordAgain ->
              Just (PasswordAgainChanged passwordAgain)
          ]

      -- `renderMaybe` means that a rerender only triggers when we decide we're
      -- interested, and we can then have access to the result we calculated.
      -- In our case, the calculation is "what's in the update field?", but
      -- this can be as complicated as you'd like.
      , PH.span'_ $ PH.renderMaybe _.update \result ->
          PH.div
            [ PP.className if result then "good" else "bad"
            ]

            [ PH.text if result
                then "OK"
                else "Passwords do not match!"
            ]
      ]

main :: forall eff. Eff (P.FX eff) Unit
main
  = void $ P.runApplication
      { view
      , subscription: empty
      , initial
      , update: updater
      }
