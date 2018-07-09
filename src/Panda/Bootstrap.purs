module Panda.Bootstrap
  ( bootstrap
  ) where

import Control.Alt            ((<|>))
import Data.Maybe             (maybe)
import Effect.Ref             as Ref
import Web.DOM.Internal.Types (Node) as Web
import Web.DOM.Document       (Document) as Web
import Effect                 (Effect)
import FRP.Event              as FRP
import Panda.Internal.Types   as Types
import Panda.Render.HTML      as HTML

import Prelude

-- | "Bootstrap" a component by rendering it to a DOM node, and producing its
-- | "Controller" set. This produces all the functions needed to interact with
-- | a Panda component - we can `input` updates to control it, listen for
-- | outgoing `events`, and even `destroy` the component entirely.

bootstrap
  ∷ ∀ input output message state
  . Web.Document
  → Types.Component input output message state
  → Effect
      { node    ∷ Web.Node
      , update  ∷ input → Effect Unit
      , events  ∷ FRP.Event output
      , destroy ∷ Effect Unit
      }

bootstrap document { view, subscription, initial, update } = do
  result@{ system, node } ← HTML.render document (bootstrap document) view

  stateRef ← Ref.new initial.state
  external ← FRP.create

  let
    events ∷ FRP.Event message
    events = subscription <|> system.events

  cancel ← FRP.subscribe events \message → do
    state ← Ref.read stateRef

    -- When a "message" is raised by the body, we call the supplied update
    -- function with an "emitter" (to trigger external events), a "dispatcher"
    -- (to update internal state and view), and the message in question, along
    -- with the state at that moment.
    { message, state } # update external.push \callback → do
      mostRecentState ← Ref.read stateRef

      let new@{ state } = callback mostRecentState
      Ref.write new.state stateRef

      new.input # maybe (pure unit) \input →
        system.handleUpdate { input, state }

  system.handleUpdate initial

  pure
    { node
    , update: \input → do
        state ← Ref.read stateRef -- Is this a hack?
        system.handleUpdate { input, state }

    , events: external.event
    , destroy: do
        system.cancel
        cancel
    }
