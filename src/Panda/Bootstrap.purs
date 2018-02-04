module Panda.Bootstrap where

import Control.Alt ((<|>))
import Control.Apply (lift2)
import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import DOM (DOM)
import DOM.Node.Document (createDocumentFragment, createElement, createTextNode) as DOM
import DOM.Node.Node (appendChild, firstChild, removeChild) as DOM
import DOM.Node.Types (Document, Node, documentFragmentToNode, elementToNode, textToNode) as DOM
import Data.Foldable (foldr)
import Data.Lazy (force)
import Data.Lens.Getter (view)
import Data.Lens.Lens (cloneLens)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple(..))
import FRP (FRP)
import FRP.Event (Event, subscribe) as FRP
import FRP.Event.Class (mapAccum) as FRP
import Panda.Event (create) as FRP
import Panda.Internal.Types as Types
import Unsafe.Coerce (unsafeCoerce)
import Util.Exists (runExists3)

import Prelude

bootstrap
  ∷ ∀ update state event
  . DOM.Document
  → Types.Application update state event
  → Eff (dom :: DOM, frp :: FRP | _)
      { events   ∷ FRP.Event event
      , element  ∷ DOM.Node
      , onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff _ (Eff _ Unit)
      }

bootstrap document { view, subscription, update }
  = render document view >>= \{ element, events, onUpdate } → do
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

      cancel ← FRP.subscribe (FRP.mapAccum loop events Nothing) onUpdate 

      pure
        { onUpdate: \update → do
            push update
            pure (pure unit)

        , events: events
        , element
        }

render
  ∷ ∀ update state event
  . DOM.Document
  → Types.Component update state event
  → Eff (dom ∷ DOM, frp :: FRP | _)
      { onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff _ (Eff _ Unit)
      , events   ∷ FRP.Event event
      , element  ∷ DOM.Node
      }

render document
  = case _ of
      Types.CText text → do
        element ← DOM.createTextNode text document

        pure
          { onUpdate: \_ → pure (pure unit)
          , events:   empty
          , element:  DOM.textToNode element
          }

      Types.CStatic (Types.ComponentStatic { children, properties, tagName }) → do
        parent ← DOM.createElement tagName document

        let
          prepare child = do
            { onUpdate, events, element } ← render document child

            _ ← DOM.appendChild element (DOM.elementToNode parent)
            pure { onUpdate, events }

          aggregate
            = lift2 \this that →
                { onUpdate: \update → do
                    this' <- this.onUpdate update
                    that' <- that.onUpdate update

                    pure (this' *> that')
                    
                , events: this.events
                      <|> that.events
                }

          initial
            = pure
                { onUpdate: \_ → pure (pure unit)
                , events:   empty
                }

        aggregated <- foldr aggregate initial (map prepare children)

        pure
          { onUpdate: aggregated.onUpdate
          , events:   aggregated.events
          , element:  DOM.elementToNode parent
          }

      Types.CDelegate delegateE →
        let
          process = runExists3 \(Types.ComponentDelegate { delegate, focus }) → do
            { events, element, onUpdate } ← bootstrap document delegate

            let state' = cloneLens focus.state

            pure
              { onUpdate: \{ state, update } →
                  case focus.update update of
                    Just subupdate ->
                      onUpdate
                        { update: subupdate
                        , state:  view state' state
                        }

                    Nothing →
                      pure (pure unit)

              , events: map focus.event events
              , element
              }

        in process delegateE

      Types.CWatcher (Types.ComponentWatcher listener) → do
        fragment ← map DOM.documentFragmentToNode
                     (DOM.createDocumentFragment document)

        { event: output, push: toOutput } ← FRP.create

        pure
          { onUpdate: \update → do
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

                  FRP.subscribe events toOutput

                else pure (pure unit)

          , events:  output
          , element: fragment
          }

