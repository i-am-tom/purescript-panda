module Test.Example.Form where

import Panda          as P
import Panda.HTML     as PH
import Panda.Property as PP

import Effect.Aff (Aff)
import Effect.Aff as Aff

import Control.Plus       (empty)
import Data.Maybe         (Maybe(..), maybe)
import Data.Time.Duration (Milliseconds(..))
import Prelude

type TextInputProperties'
  = { className :: String
    , buffer    :: Milliseconds
    }

defaultProperties' :: TextInputProperties'
defaultProperties'
  = { className: ""
    , buffer: Milliseconds 0.0
    }

newtype TextInputProperties
  = TextInputProperties TextInputProperties'

data TextInputEvent
  = TextInputUpdated String
  | TextInputFocused
  | TextInputBlurred
  | TextInputBufferReset

newtype TextInputUpdate
  = UpdateTextInputContents String

textInput (TextInputProperties properties)
  = { view:
        PH.label
          [ PP.className properties.className
          ]

          [ PH.input
              [ PP.className $ properties.className <> "__field"
              , PP.onChange' $ pure <<< TextInputUpdated
              , PP.onBlur    \_ -> Just TextInputBlurred
              , PP.onFocus   \_ -> Just TextInputFocused
              ]
          ]

    , initial:
        { state: pure unit
        , update: UpdateTextInputContents ""
        }

    , update: \emit dispatch { event, state: buffer } ->
        case event of
          TextInputUpdated contents -> do
            _ <- buffer # maybe (pure unit) identity--Aff.killFiber

            dispatch \_ ->
              { update: Nothing
              , state: Aff.delay properties.buffer {-*>
                  liftEffect (emit (TextInputUpdateComplete contents))-}
              }

          unbufferedEvent ->
            emit unbufferedEvent
  }

mkTextInput endo
  = textInput
  $ TextInputProperties
  $ endo defaultProperties'
