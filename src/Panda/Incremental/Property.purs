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
import Panda.Internal.Types as Types

import Prelude

type PropertySystem eff update state event
  = Map.Map
      (Either Types.Producer String)
      (Types.EventSystem eff update state event)

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
      , hasNewItem ∷ Maybe (Either Types.Producer String)
      }

execute { element, systems, render, update }
  = case update of
      Left producer →
        case producer of
          Algebra.Add key onEvent → do
            system ← render (Types.PropertyProducer { key, onEvent })

            pure
              { systems: Map.insert (Left key) system systems
              , hasNewItem: Just (Left key)
              }

          Algebra.Delete key → do
            DOM.removeAttribute (Types.producerToString key) element

            case Map.lookup (Left key) systems of
              Just (Types.DynamicSystem { cancel }) →
                cancel

              _ →
                pure unit

            pure
              { systems: Map.delete (Left key) systems
              , hasNewItem: Nothing
              }

          Algebra.Empty → do
            for_ systems case _ of
              Types.DynamicSystem { cancel } →
                cancel

              Types.StaticSystem →
                pure unit

            pure
              { systems: Map.empty
              , hasNewItem: Nothing
              }

          Algebra.Rename from to → do
            case Map.lookup (Left to) systems of
              Just (Types.DynamicSystem { cancel }) →
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
            system ← render (Types.PropertyFixed { key, value })

            pure
              { systems: Map.insert (Right key) system systems
              , hasNewItem: Just (Right key)
              }

          Algebra.Delete key → do
            case Map.lookup (Right key) systems of
              Just (Types.DynamicSystem { cancel }) →
                cancel

              _ →
                pure unit

            pure
              { systems: Map.delete (Right key) systems
              , hasNewItem: Nothing
              }

          Algebra.Empty → do
            for_ systems case _ of
              Types.DynamicSystem { cancel } →
                cancel

              Types.StaticSystem →
                pure unit

            pure
              { systems: Map.empty
              , hasNewItem: Nothing
              }

          Algebra.Rename from to →
            pure { systems, hasNewItem: Nothing }

          Algebra.Swap this that →
            pure { systems, hasNewItem: Nothing }
