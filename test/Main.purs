module Test.Main where

import Test.Example.SignUp as SignUp

import Control.Plus       (empty)
import Data.Maybe         (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect             (Effect)
import Effect.Aff         (Aff, delay, runAff)

import Panda      as P
import Panda.HTML as PH

import Prelude

-- | Because we want to respond to events from the signup form, we need to have
-- | internal message representation for our top-level application. As it
-- | stands, we only care about login attempts.

data Message
  = MakeLoginAttempt
      ( ( SignUp.State
        → Aff (Array SignUp.Error)
        )
      → Aff Unit
      )

-- | We export from the SignUp module as a delegate, so when we embed the html
-- | elsewhere, we only really need to say how to convert our inputs into its
-- | inputs, and its inputs into our messages. These are the only channels for
-- | communication between a delegate and its parent.

view
  ∷ ∀ input
  . PH.HTML input Message Unit

view
  = SignUp.application
      { input: \_ → Nothing
      , output: case _ of
          SignUp.LoginAttempted handle ->
            Just (MakeLoginAttempt handle)
      }

-- | At the top level, we've nothing to emit here (because we don't have some
-- | containing listener such as React). All we do is dispatch updates to the
-- | SignUp form, which we can fake for the demo.

update
  ∷ ∀ input output
  . P.Updater input output Message Unit

update _ dispatch { message: MakeLoginAttempt handle }
  = void
  $ runAff mempty
  $ handle \state → do
      delay (Milliseconds 2000.0)

      pure
        [ SignUp.InvalidPassword
        ]

-- | At the top-level, we build an application just like any other, but then
-- | `runApplication` within some container (in this case, the body).

main ∷ Effect Unit
main
  = void
  $ P.runApplicationInBody
  $ { view
    , update
    , subscription: empty
    , initial:
        { input: SignUp.ResetForm
        , state: unit
        }
    }
