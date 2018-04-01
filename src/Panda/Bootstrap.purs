module Panda.Bootstrap
  ( bootstrap
  ) where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    as Ref
import DOM.Node.Types           (Document, Node) as DOM
import FRP.Event                (Event, subscribe) as FRP
import Panda.Internal.Types     as Types
import Panda.Render.Element     as Element

import Prelude

-- | Given an application, produce the DOM element and the system of events
-- | around it. This is mutually recursive with the `render` function.
bootstrap
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Application (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { element ∷ DOM.Node
      , system ∷ Types.EventSystem (Types.FX eff) update state event
      }

bootstrap document { initial, subscription, update, view } = do
  { element, system: Types.EventSystem system }
      ← Element.render (bootstrap document) document view

  stateRef ← Ref.newRef initial.state

  let
    events ∷ FRP.Event event
    events = subscription <|> system.events

  cancel ← FRP.subscribe events \event → do
    state ← Ref.readRef stateRef

    { event, state } # update \callback → do
      mostRecentState ← Ref.readRef stateRef
      let new@{ state } = callback mostRecentState

      Ref.writeRef stateRef state
      system.handleUpdate new

  system.handleUpdate initial

  pure
    { element
    , system: Types.EventSystem
        $ system
            { cancel = do
                system.cancel
                cancel
            }
    }

