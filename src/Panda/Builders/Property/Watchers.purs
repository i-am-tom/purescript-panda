module Panda.Builders.Property.Watchers
  ( class PropertyPairing
  , buildWatcher

  , renderWhen
  ) where

import DOM.Event.Types (Event) as DOM
import Data.Maybe      (Maybe)
import Panda.Internal  as I

import Prelude

-- | Unfortunate consequence of user-friendliness: we need to express a
-- | relationship between different types of key and value. This would be no
-- | big deal in Haskell, but PureScript doesn't yet inline away dictionaries.

class PropertyPairing key value event | key → value where
  buildWatcher
    ∷ ∀ update state
    . key
    → ({ update ∷ update, state ∷ state } → I.ShouldUpdate value)
    → I.Property update state event

instance propertyPairingFixed ∷ PropertyPairing String String event where
  buildWatcher key updater
    = I.DynamicProperty $ I.Fixed
        { key
        , value: I.DynamicF updater
        }

instance propertyPairingProducer
    ∷ PropertyPairing I.Producer (DOM.Event → Maybe event) event where
  buildWatcher key updater
    = I.DynamicProperty $ I.Producer
        { key
        , onEvent: I.DynamicF updater
        }

-- | Watchers

renderWhen
  ∷ ∀ update state event key value
  . PropertyPairing key value event
  ⇒ key
  → ({ update ∷ update, state ∷ state } → Boolean)
  → value
  → I.Property update state event

renderWhen key predicate value
  = buildWatcher key \update →
      if predicate update
        then I.Rerender (I.Set value)
        else I.Rerender I.Delete
