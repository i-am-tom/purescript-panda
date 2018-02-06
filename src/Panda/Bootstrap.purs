module Panda.Bootstrap where

import Control.Alt ((<|>))
import Control.Apply (lift2)
import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import DOM.Node.Document (createDocumentFragment, createElement, createTextNode) as DOM
import DOM.Node.Node (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types (Document, Node, documentFragmentToNode, elementToNode, textToNode) as DOM
import Data.Foldable (foldr, sequence_)
import Data.Lazy (force)
import Data.Lens.Getter (view)
import Data.Lens.Lens (cloneLens)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import FRP.Event (Event, subscribe) as FRP
import FRP.Event.Class (mapAccum, withLast) as FRP
import Panda.Event (create) as FRP
import Panda.Internal.Types as Types
import Util.Exists (runExists3)

import Prelude

bootstrap
  ∷ ∀ update state event
  . DOM.Document
  → Types.Application update state event
  → Eff _
      { cancel   ∷ Eff _ Unit
      , events   ∷ FRP.Event event
      , element  ∷ DOM.Node
      , onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff _ (Eff _ Unit)
      }

bootstrap document { view, subscription, update }
  = render document view >>= \{ element, events, onUpdate, cancel } → do
      { event: updates, push } ← FRP.create

      let
        loop next state
          = Tuple
              (Just step.state)
              { state:  step.state
              , update: step.update
              }
          where
            step = update state next

      cancelMe ← FRP.subscribe (FRP.mapAccum loop events Nothing) onUpdate

      pure
        { onUpdate: \update' → do
            push update'
            pure cancel

        , cancel: cancelMe
        , events: events
        , element
        }

render
  ∷ ∀ update state event
  . DOM.Document
  → Types.Component update state event
  → Eff _
      { cancel   ∷ Eff _ Unit
      , events   ∷ FRP.Event event
      , element  ∷ DOM.Node
      , onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff _ (Eff _ Unit)
      }

render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document

        pure
          { cancel:   pure unit
          , element:  DOM.textToNode element
          , events:   empty
          , onUpdate: \_ → pure (pure unit)
          }

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        parent ← DOM.createElement tagName document

        let
          prepare child = do
            { cancel, events, element, onUpdate } ← render document child

            _ ← DOM.appendChild element (DOM.elementToNode parent)
            pure { cancel, events, onUpdate }

          aggregate
            = lift2 \this that →
                { onUpdate: \update → do
                    this' <- this.onUpdate update
                    that' <- that.onUpdate update

                    pure (this' *> that')

                , events: this.events
                      <|> that.events

                , cancel: this.cancel *> that.cancel
                }

          initial
            = pure
                { cancel:   pure unit
                , events:   empty
                , onUpdate: \_ → pure (pure unit)
                }

        aggregated <- foldr aggregate initial (map prepare children)

        pure
          { cancel:   aggregated.cancel
          , element:  DOM.elementToNode parent
          , events:   aggregated.events
          , onUpdate: aggregated.onUpdate
          }

      Types.CDelegate delegateE →
        let
          process = runExists3 \(Types.ComponentDelegate { delegate, focus }) → do
            { cancel, events, element, onUpdate } ← bootstrap document delegate

            let state' = cloneLens focus.state

            pure
              { cancel
              , events: map focus.event events
              , element
              , onUpdate: \{ state, update } →
                  case focus.update update of
                    Just subupdate ->
                      onUpdate
                        { update: subupdate
                        , state:  view state' state
                        }

                    Nothing →
                      pure (pure unit)
              }

        in process delegateE

      Types.CWatcher (Types.ComponentWatcher listener) → do
        fragment ← map DOM.documentFragmentToNode
                     (DOM.createDocumentFragment document)

        { event: output,     push: toOutput } ← FRP.create
        { event: cancellers, push: registerCanceller } ← FRP.create

        cancelWatcher ← FRP.subscribe (FRP.withLast cancellers) \{ last } ->
          sequence_ last

        pure
          { cancel: cancelWatcher
          , events:  output
          , element: fragment
          , onUpdate: \update → do
              let { interest, renderer } = listener update

              if interest
                then do
                  { onUpdate, events, element }
                      ← render document (force renderer)

                  firstChild ← DOM.firstChild fragment

                  case firstChild of
                    Just elem -> do
                      _ ← DOM.removeChild elem fragment
                      pure unit

                    Nothing ->
                      pure unit

                  _ ← DOM.appendChild element fragment

                  canceller <- FRP.subscribe events toOutput
                  registerCanceller canceller

                  pure canceller

                else pure (pure unit)
          }

