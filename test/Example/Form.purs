module Test.Example.Form where

import Data.HTTP.Method as HTTP
import Data.Maybe       (Maybe(..))
import Data.String      (joinWith)

import Panda.HTML     as PH
import Panda.Property as PP

import Prelude

data FormEvent
  = FormOnBlur
  | FormOnChange
  | FormOnFocus
  | FormOnInput
  | FormOnSubmit

type FormProperties' input message
  = { autocomplete ∷ Boolean
    , classes      ∷ Array String
    , enctype      ∷ PP.FormEncodingType
    , method       ∷ HTTP.Method
    , name         ∷ String
    , novalidate   ∷ Boolean
    , onEvent      ∷ FormEvent → Maybe message
    , target       ∷ PP.Target
    }

newtype FormProperties input message
  = FormProperties (FormProperties' input message)

form'
  ∷ ∀ input message state
  . FormProperties input message
  → Array (PH.HTML input message state)
  → PH.HTML input message state

form' (FormProperties properties) children
  = PH.form
      [ PP.autocomplete properties.autocomplete
      , PP.className (joinWith " " properties.classes)
      , PP.enctype properties.enctype
      , PP.method properties.method
      , PP.name properties.name
      , PP.novalidate properties.novalidate
      , PP.target properties.target

      , PP.onBlur        \_ → properties.onEvent FormOnBlur
      , PP.onChange      \_ → properties.onEvent FormOnChange
      , PP.onFocus       \_ → properties.onEvent FormOnFocus
      , PP.onInput       \_ → properties.onEvent FormOnInput
      , PP.onSubmit      \_ → properties.onEvent FormOnSubmit
      ]

      children

initialProperties ∷ ∀ input message. FormProperties' input message
initialProperties
  = { autocomplete: false
    , classes: []
    , enctype: PP.XWWWFormUrlEncoded
    , method: HTTP.GET
    , name: ""
    , novalidate: false
    , target: PP.Self

    , onEvent: \_ → Nothing
    }

form
  ∷ ∀ input message state
  . ( FormProperties' input message
    → FormProperties' input message
    )
  → Array (PH.HTML input message state)
  → PH.HTML input message state

form endo
  = form' properties
  where
    properties
      = FormProperties
      $ endo initialProperties
