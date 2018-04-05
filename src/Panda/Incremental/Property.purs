module Panda.Incremental.Property
  ( execute
  ) where

import Control.Monad.Eff    (Eff)
import DOM.Node.Element     (removeAttribute) as DOM
import DOM.Node.Types       (Element) as DOM
import Data.Algebra.Map     as Algebra
import Data.Either          (Either(..))
import Data.Foldable        (for_)
import Data.Map             as Map
import Data.Maybe           (Maybe(..))
import Panda.Internal       as I

import Prelude

-- | The system for properties is slightly more complicated as we distinguish
-- | between those who _produce events_ and those who don't. For this reason,
-- | our map has a sum type as a key.
type PropertySystem eff update state event
  = Map.Map
      (Either I.Producer String)
      (I.EventSystem eff update state event)

-- | Given an element, and a set of update instructions, perform the update and
-- | reconfigure the event systems.
execute
  ∷ ∀ eff update state event
  . { element  ∷ DOM.Element
    , systems  ∷ PropertySystem (I.FX eff) update state event
    , render   ∷ I.Property event
               → Eff (I.FX eff)
                   ( I.EventSystem (I.FX eff) update state event
                   )
    , update   ∷ I.PropertyUpdate event
    }
  → Eff (I.FX eff)
      { systems ∷ PropertySystem (I.FX eff) update state event
      , hasNewItem ∷ Maybe (Either I.Producer String)
      }

execute { element, systems, render, update }
  = case update of
      Left producer →
        case producer of
          Algebra.Add key onEvent → do
            system ← render (I.PropertyProducer { key, onEvent })

            pure
              { systems: Map.insert (Left key) system systems
              , hasNewItem: Just (Left key)
              }

          Algebra.Delete key → do
            DOM.removeAttribute (I.producerToString key) element

            case Map.lookup (Left key) systems of
              Just (I.DynamicSystem { cancel }) →
                cancel

              _ →
                pure unit

            pure
              { systems: Map.delete (Left key) systems
              , hasNewItem: Nothing
              }

          Algebra.Empty → do
            for_ systems case _ of
              I.DynamicSystem { cancel } →
                cancel

              I.StaticSystem →
                pure unit

            pure
              { systems: Map.empty
              , hasNewItem: Nothing
              }

          Algebra.Rename from to → do
            case Map.lookup (Left to) systems of
              Just (I.DynamicSystem { cancel }) →
                cancel

              _ →
                pure unit

            pure case Map.lookup (Left from) systems of
              Just system →
                { systems: Map.insert (Left to) system
                    $ Map.delete (Left from) systems

                , hasNewItem: Nothing
                }

              Nothing →
                { systems
                , hasNewItem: Nothing
                }

          Algebra.Swap this that → do
            -- TODO: implement
            pure { systems, hasNewItem: Nothing }

      Right static →
        case static of
          Algebra.Add key value → do
            system ← render (I.PropertyFixed { key, value })

            pure
              { systems: Map.insert (Right key) system systems
              , hasNewItem: Just (Right key)
              }

          Algebra.Delete key → do
            case Map.lookup (Right key) systems of
              Just (I.DynamicSystem { cancel }) →
                cancel

              _ →
                pure unit

            pure
              { systems: Map.delete (Right key) systems
              , hasNewItem: Nothing
              }

          Algebra.Empty → do
            for_ systems case _ of
              I.DynamicSystem { cancel } →
                cancel

              I.StaticSystem →
                pure unit

            pure
              { systems: Map.empty
              , hasNewItem: Nothing
              }

          Algebra.Rename from to →
            pure { systems, hasNewItem: Nothing }

          Algebra.Swap this that →
            pure { systems, hasNewItem: Nothing }
