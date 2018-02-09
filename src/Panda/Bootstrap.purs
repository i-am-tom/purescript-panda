module Panda.Bootstrap where

import Control.Alt ((<|>))
import Control.Apply (lift2)
import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import DOM.Node.Document (createDocumentFragment, createElement, createTextNode) as DOM
import DOM.Node.Node (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types (Document, Node, documentFragmentToNode, elementToNode, textToNode) as DOM
import Data.Foldable (foldr, sequence_, traverse_)
import Data.Lazy (force)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import FRP.Event (Event, subscribe) as FRP
import FRP.Event.Class (mapAccum, withLast) as FRP
import Panda.Event (create) as FRP
import Panda.Internal.Types as Types
import Panda.Property as Property
import Util.Exists (runExists3)

import Prelude

bootstrap
  ∷ ∀ update state event
  . DOM.Document
  → Types.Application update state event
  → Eff _
      { cancel ∷ Types.Canceller _
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Types.Canceller _
      }

bootstrap document { view, subscription, update } = do
  renderedPage ← render document view

  let
    loop event previousState = Tuple (Just next.state) next
      where next = update (map { state: _, event } previousState)

    updates = FRP.mapAccum loop renderedPage.events Nothing

  cancelApplication
    ← FRP.subscribe updates renderedPage.handleUpdate

  pure renderedPage
    { cancel = renderedPage.cancel
            *> cancelApplication
    }

render
  ∷ ∀ update state event
  . DOM.Document
  → Types.Component update state event
  → Eff _
      { cancel ∷ Types.Canceller _
      , events ∷ FRP.Event event
      , element ∷ DOM.Node
      , handleUpdate
          ∷ { update ∷ update
            , state ∷ state
            }
          → Eff _ Unit
      }

render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document

        pure
          { cancel: pure unit
          , element: DOM.textToNode element
          , events: empty
          , handleUpdate: \_ → pure unit
          }

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        parent ← DOM.createElement tagName document
        traverse_ (Property.render parent) properties

        let
          prepare child = do
            { cancel, events, element, handleUpdate }
                ← render document child

            _ ← DOM.appendChild element (DOM.elementToNode parent)
            pure { cancel, events, handleUpdate }

          combineEventSystems
            = lift2 \this that →
                { handleUpdate: \update → do
                    this.handleUpdate update
                    that.handleUpdate update

                , events: this.events <|> that.events
                , cancel: this.cancel *> that.cancel
                }

          initial
            = pure
                { cancel: pure unit
                , events: empty
                , handleUpdate: \_ → pure unit
                }

        aggregated
          ← foldr combineEventSystems initial (map prepare children)

        pure
          { cancel: aggregated.cancel
          , element: DOM.elementToNode parent
          , events: aggregated.events
          , handleUpdate: aggregated.handleUpdate
          }

      Types.CDelegate delegateE →
        let
          process = runExists3 \(Types.ComponentDelegate { delegate, focus }) → do
            { cancel, events, element, handleUpdate }
                ← bootstrap document delegate

            pure
              { cancel
              , events: map focus.event events
              , element
              , handleUpdate: \{ state, update } →
                  case focus.update update of
                    Just subupdate →
                      handleUpdate
                        { update: subupdate
                        , state:  focus.state state
                        }

                    Nothing →
                      pure unit
              }

        in process delegateE

      Types.CWatcher (Types.ComponentWatcher listener) → do
        fragment ← map DOM.documentFragmentToNode
                     (DOM.createDocumentFragment document)

        { event: output,     push: toOutput }          ← FRP.create
        { event: cancellers, push: registerCanceller } ← FRP.create

        cancelWatcher ← FRP.subscribe (FRP.withLast cancellers) \{ last } →
          sequence_ last

        pure
          { cancel: registerCanceller (pure unit) *> cancelWatcher
          , events: output
          , element: fragment
          , handleUpdate: \update → do
              let { interest, renderer } = listener update

              when interest do
                { cancel, element, events, handleUpdate }
                    ← render document (force renderer)

                firstChild ← DOM.firstChild fragment

                case firstChild of
                  Just elem → do
                    _ ← DOM.removeChild elem fragment
                    pure unit

                  Nothing →
                    pure unit

                _ ← DOM.appendChild element fragment

                cancelEvents ← FRP.subscribe events toOutput
                registerCanceller (cancel *> cancelEvents)
          }

