module Panda.Bootstrap
  ( bootstrap
  , render
  ) where

import Control.Alt              ((<|>))
import Control.Monad.Eff        (Eff)
import Control.Monad.Eff.Ref    as Ref
import Control.Monad.Rec.Class  (Step(..), tailRecM)
import Data.Array               (uncons)
import DOM.Node.Document        (createElement, createTextNode) as DOM
import DOM.Node.Node            (appendChild) as DOM
import DOM.Node.Types           (Document, Node, elementToNode, textToNode) as DOM
import Data.Foldable            (foldMap)
import Data.Maybe               (Maybe(..))
import Data.Monoid              (mempty)
import FRP.Event                (Event, create, subscribe) as FRP
import FRP.Event.Class          (fold, sampleOn) as FRP
import Panda.Bootstrap.Property as Property
import Panda.Internal.Types     as Types

import Prelude

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
      ← render document view

  deltas ← FRP.create

  let
    states' ∷ FRP.Event { state ∷ state, update ∷ update }
    states' = FRP.fold (\delta { state } → delta state) deltas.event initial

    states ∷ FRP.Event { state ∷ state, update ∷ update }
    states = pure initial <|> states'

    events ∷ FRP.Event event
    events = subscription <|> system.events

    loop
      ∷ event
      → { state ∷ state, update ∷ update }
      → { state ∷ state, event  ∷ event  }
    loop event { state }
      = { event, state }

    prepared ∷ FRP.Event { event ∷ event, state ∷ state }
    prepared = FRP.sampleOn states (map loop events)

  cancelRenderer    ← FRP.subscribe states system.handleUpdate
  cancelApplication ← FRP.subscribe prepared (update deltas.push)

  pure
    { element
    , system: Types.EventSystem
        $ system
            { cancel = do
                system.cancel
                cancelRenderer
                cancelApplication
            }
    }

render
  ∷ ∀ eff update state event
  . DOM.Document
  → Types.Component (Types.FX eff) update state event
  → Eff (Types.FX eff)
      { element ∷ DOM.Node
      , system ∷ Types.EventSystem (Types.FX eff) update state event
      }
render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document
        let element' = DOM.textToNode element

        pure
          { element: element'
          , system: mempty
          }

      Types.CDelegate delegateE →
        delegateE # Types.runComponentDelegateX
          \(Types.ComponentDelegate { delegate, focus }) → do
              { element, system: Types.EventSystem system }
                  ← bootstrap document delegate

              pure
                { element
                , system: Types.EventSystem $ system
                    { events = map focus.event system.events
                    , handleUpdate = \{ state, update } →
                        case focus.update update of
                          Just subupdate →
                            system.handleUpdate
                              { update: subupdate
                              , state:  focus.state state
                              }

                          Nothing →
                            pure unit
                    }
                }

      Types.CElement (Types.ComponentElement component) → do
        tag             ← DOM.createElement component.tagName document
        propertySystem  ← foldMap (Property.render tag) component.properties

        let node = DOM.elementToNode tag

        elementSystem ← case component.children of
          Types.StaticChildren children → do
            children # foldMap \child → do
              { element, system } ← render document child

              _ ← DOM.appendChild element node
              pure system

          Types.DynamicChildren listener → do
            { event: output, push: toOutput } ← FRP.create
            eventSystems                      ← Ref.newRef mempty

            pure $ Types.EventSystem
              { cancel: do
                  systems ← Ref.readRef eventSystems

                  systems # foldMap \(Types.EventSystem { cancel }) →
                    cancel

              , handleUpdate: \update →
                  case listener update of
                    Types.Rerender rerender → do
                      rerender # tailRecM \instructions →
                        case (uncons instructions) of
                          Nothing →
                            pure (Done unit)

                          Just { head, tail } → do
                            systems ← Ref.readRef eventSystems
                            _ ← pure (systems ∷ Array (Types.EventSystem (Types.FX eff) update state event))

                            Ref.writeRef eventSystems systems

                            pure (Loop tail)

                    Types.Ignore →
                      pure unit

              , events: output
              }

        pure
          { element: node
          , system:  elementSystem <> propertySystem
          }
