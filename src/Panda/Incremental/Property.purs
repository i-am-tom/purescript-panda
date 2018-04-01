module Panda.Incremental.Property
  ( execute
  ) where

import Control.Monad.Eff    (Eff)
import DOM.Node.Element     (removeAttribute) as DOM
import DOM.Node.Types       (Element) as DOM
import Data.Map             as Map
import Data.Maybe           (Maybe(..))
import Data.String          (drop, toLower)
import Panda.Internal.Types as Types

import Prelude

type PropertySystem eff update state event
  = Map.Map String (Types.EventSystem eff update state event)

propertyToAttribute
  ∷ ∀ event
  . Types.Property event
  → String
propertyToAttribute
  = case _ of
      Types.PropertyProducer { key } → producerToString  key
      Types.PropertyFixed { key }    → key

-- | Given an element, and a set of update instructions, perform the update and
-- | reconfigure the event systems.
execute
  ∷ ∀ eff update state event
  . { element  ∷ DOM.Element
    , systems  ∷ PropertySystem (Types.FX eff) update state event
    , render   ∷ Types.Property event
               → Eff (Types.FX eff)
                   ( Types.EventSystem (Types.FX eff) update state event
                   )
    , update   ∷ Types.PropertyUpdate event
    }
  → Eff (Types.FX eff)
      { systems ∷ PropertySystem (Types.FX eff) update state event
      , hasNewItem ∷ Maybe String
      }

execute { element, systems, render, update } = do
  case update of
    Types.PropertyAdd property → do
      let attribute = propertyToAttribute property
      system ← render property

      pure
        { systems: Map.insert attribute system systems
        , hasNewItem: Just attribute
        }

    Types.PropertyDelete key → do
      DOM.removeAttribute  key element

      pure
        { systems: Map.delete key systems
        , hasNewItem: Nothing
        }

-- | Given a Producer, return the string that identifies it when adding an
-- | event handler. This is also the string we use for the attribute when we
-- | attach it to the DOM.
producerToString ∷ Types.Producer → String
producerToString -- Dirty hack: drop the "On"!
    = toLower
  <<< drop 2
  <<< show
