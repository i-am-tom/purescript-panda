module Test.Example.SignUp where

import Control.Plus       (empty)
import Data.Algebra.Array as A
import Data.Foldable      (traverse_)
import Data.Maybe         (Maybe(..))
import Effect.Aff         (Aff)
import Effect.Class       (liftEffect)

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

import Prelude

-- | Inputs. These are commands that will in some way influence the DOM
-- | presentation.

data Input
  = ResetForm
  | SetLoadingState Boolean
  | SucceedLogin
  | ShowError Error

-- | Outputs. These are events that can be raised by the sign-up form.
-- | Currently, the only interesting one is to perform a login attempt and
-- | report back in order to update the DOM.

data Output
  = LoginAttempted
      ( ( State
        → Aff (Array Error)
        )
      → Aff Unit
      )

-- | Messages. These are internal events that are raised to the `update`
-- | which can decide whether to push updates _down_ to the DOM and/or push
-- | events _up_ to the parent.

data Message
  = UpdateEmail String
  | UpdatePassword String
  | SubmitForm P.Event

-- | Errors that can happen within thi signup page.

data Error
  = UnknownEmail
  | InvalidPassword

-- | This is what our state looks like.

type State
  = { username ∷ String
    , password ∷ String
    }

-- | Handle some sort of message.

update ∷ P.Updater Input Output Message State
update emit dispatch { message, state } = case message of

  UpdateEmail username →
    dispatch \_ →
      { input: Nothing
      , state: state
          { username = username
          }
      }

  UpdatePassword password →
    dispatch \_ →
      { input: Nothing
      , state: state
          { password = password
          }
      }

  SubmitForm event → do
    P.preventDefault event

    emit $ LoginAttempted \handleLogin → do
      let
        isLoading flag
          = liftEffect $ dispatch
              { input: Just (SetLoadingState flag)
              , state: _
              }

      isLoading true
      errors ← handleLogin state
      isLoading false

      liftEffect $ errors # traverse_ \err →
        dispatch
          { input: Just (ShowError err)
          , state: _
          }

-- | The specification for how we want the DOM to look.

view ∷ PH.HTML Input Message State
view
  = PH.form
      [ PP.className "SignUp__form"
      , PP.onSubmit (Just <<< SubmitForm)
      ]

      [ PH.label
          [ PP.className "SignUp__label"
          ]

          [ PH.text "Email address"
          , PH.input
              [ PP.placeholder "tom.harding+panda-sign-up@habito.com"
              , PP.accesskey 'u'
              , PP.autocomplete "username"
              , PP.onInput' (Just <<< UpdateEmail)
              , PP.required true
              , PP.type_ "text"
              , modifyClassWhen "SignUp__email" \{ input } →
                  case input of
                    ShowError UnknownEmail → Just "error"
                    _                      → Nothing
              ]

          , fieldError \{ input, state } →
              case input of
                ShowError UnknownEmail →
                  Just "Hmm, are you sure we've met?"

                _ →
                  Nothing
          ]

      , PH.label
          [ PP.className "SignUp__label"
          ]

          [ PH.text "Password"
          , PH.input
              [ PP.placeholder "super-secret-password"
              , PP.accesskey 'p'
              , PP.autocomplete "new-password"
              , PP.onInput' (Just <<< UpdatePassword)
              , PP.required true
              , PP.type_ "password"
              , modifyClassWhen "SignUp__password" \{ input } →
                  case input of
                    ShowError UnknownEmail → Just "error"
                    _                      → Nothing
              ]

          , fieldError \{ input, state } →
              case input of
                ShowError InvalidPassword →
                  Just "That's not how I remember it..."

                _ →
                  Nothing
          ]

      , PH.input
          [ PP.className "SignUp__submit"
          , PP.type_ "submit"
          , PP.value "Sign Up"

          , PP.watch \{ input } →
              case input of
                SetLoadingState flag →
                  PP.SetTo $ PP.value if flag
                    then "Loading..."
                    else "Sign Up"

                _ →
                  PP.Ignore

          , PP.watch \{ input } →
              case input of
                SetLoadingState true →
                  PP.SetTo (PP.disabled true)

                SetLoadingState false →
                  PP.Clear

                _ →
                  PP.Ignore
          ]
      ]

-- | Create a property watcher that responds according to the given check to
-- | determine how to modify the class name of the element to which it is
-- | attached. This is some BEM hackery, should probably exist in a library.

modifyClassWhen
  ∷ String
  → ( { input ∷ Input
      , state ∷ State
      }
    → Maybe String
    )
  → PP.Property Input Message State

modifyClassWhen baseName check
  = PP.watch \instruction →
      PP.SetTo $ PP.className case check instruction of
        Just modifier → baseName <> " " <> modifier
        _             → baseName

-- | Should we show the error for this field? Again, this basic incremental
-- | logic should be pushed back into library code.

fieldError
  ∷ ( { input ∷ Input
      , state ∷ State
      }
    → Maybe String
    )
  → PH.HTML Input Message State

fieldError handle
  = PH.span'
      [ PP.className "SignUp__error"
      ]

      \raised →
        case handle raised of
          Nothing →
            [ A.Empty ]

          Just xs →
            [ A.Empty
            , A.Push (PH.text xs)
            ]

-- | The "application" for our signup form.

application
  ∷ ∀ input message state
  . { input  ∷ input → Maybe Input
    , output ∷ Output → Maybe message
    }
  → PH.HTML input message state

application focus
  = PH.delegate focus
      { subscription: empty
      , update
      , view
      , initial:
          { input: ResetForm
          , state: mempty
          }
      }

