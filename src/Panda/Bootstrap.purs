module Panda.Bootstrap
  ( bootstrap
  ) where

import Control.Alt           ((<|>))
import Control.Monad.Eff     (Eff)
import Control.Monad.Eff.Ref as Ref
import DOM.Node.Types        (Document, Node) as DOM
import FRP.Event             (Event, subscribe) as FRP
import Panda.Internal        as I
import Panda.Render.Element  as Element

import Prelude

-- | Given an application, produce the DOM element and the system of events
-- | around it. This function is called internally by `runApplicationInNode`.

bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → I.App (I.FX eff) update state event
  → Eff (I.FX eff)
      { node   ∷ DOM.Node
      , system ∷ I.EventSystem (I.FX eff) update state event
      }

bootstrap document app = do
  -- Firstly, render the application to get an element and system.
  result ← Element.render (bootstrap document) document app.view

  -- We now have a couple things to do: we need to tie the outgoing events and
  -- `subscription` streams together, then pipe that into `update`, and finally
  -- augment the canceller to take care of cleaning this up.

  result.system # I.foldEventSystem (pure result) \system → do
    stateRef ← Ref.newRef app.initial.state

    let
      events ∷ FRP.Event event
      events = app.subscription <|> system.events

    cancel ← FRP.subscribe events \event → do
      state ← Ref.readRef stateRef

      { event, state } # app.update \callback → do
        mostRecentState ← Ref.readRef stateRef
        let new@{ state } = callback mostRecentState

        Ref.writeRef stateRef state
        system.handleUpdate new

    system.handleUpdate app.initial

    pure $ result
      { system = I.DynamicSystem $ system
          { cancel = do
              system.cancel
              cancel
          }
      }
