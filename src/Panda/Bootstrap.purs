module Panda.Bootstrap
  ( bootstrap
  ) where

import Control.Alt                ((<|>))
import Control.Monad.Eff.Ref      as Ref
import DOM.Node.Types             (Node) as DOM
import Effect                     (Effect)
import FRP.Event                  (Event, subscribe) as FRP
import Panda.Internal.Types       as Types
import Panda.Render.Component     as Component

import Panda.Prelude

-- | Given a Panda application, bootstrap the entire thing, wiring up the event
-- | systems as appropriate, and return the possibly-generated event system
-- | along with the node to be attached to the DOM.

bootstrap
  ∷ ∀ update state event
  . Types.Application update state event
  → Effect
      { node   ∷ DOM.Node
      , system ∷ Maybe (Types.EventSystem update state event)
      }

bootstrap app = do
  result ← Component.render bootstrap app.view

  case result.system of
    Nothing →
      -- Applications that are either totally static (_or_ produce events
      -- without reading updates) don't need any sort of event system.
      pure
        { node: result.node
        , system: Nothing
        }

    Just (Types.EventSystem system) → do
       -- We could do this with a stream (and originally did!), but it's much
       -- more performant to model that stream with a mutable reference.
      stateRef ← effToEffect (Ref.newRef app.initial.state)

      let
        events ∷ FRP.Event event
        events = app.subscription <|> system.events

      cancel ← effToEffect $ FRP.subscribe events \event → effectToEff do
        state ← effToEffect (Ref.readRef stateRef)

        -- Every time an event is raised in the front end, that can trigger any
        -- number of updates from the app's `update` function. So, we supply
        -- that function with a callback that pipes each generated update
        -- through `handleUpdate` in the event system.
        { event, state } # app.update \callback → do
          mostRecentState ← effToEffect (Ref.readRef stateRef)
          let new@{ state } = callback mostRecentState

          effToEffect (Ref.writeRef stateRef state)
          system.handleUpdate new

      system.handleUpdate app.initial

      pure $ result
        { system = Just ∘ Types.EventSystem $ system
            { cancel = do
                system.cancel
                effToEffect cancel
            }
        }
