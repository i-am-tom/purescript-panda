module Panda.HTML
  ( module Builders
  , module Exports

  , delegate
  ) where

import Data.Maybe           (Maybe)
import Panda.Internal.Types as Types

import Prelude

-- | Exports from the PH namespace.

import Panda.Builders.HTML  as Builders
import Panda.Internal.Types (HTML(..), HTMLUpdate) as Exports

-- | Embed an application into a component, allowing for it to exist in a
-- | larger application. This also gives us the opportunity to filter out
-- | events and updates in which we're not so interested.

delegate
  ∷ ∀ input message state subinput suboutput submessage substate
  . { input  ∷ input     → Maybe subinput
    , output ∷ suboutput → Maybe message
    }
  → Types.Component subinput suboutput submessage substate
  → Types.HTML input message state

delegate focus application
  = Types.Delegate
  $ Types.mkHTMLDelegateX
  $ Types.HTMLDelegate { application, focus }
