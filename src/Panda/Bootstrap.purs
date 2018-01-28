module Panda.Bootstrap where

import Panda.Internal.Types (Application, Component(..), ComponentDelegate(..), ComponentStatic(..), ComponentWatcher(..))
import Util.Exists2 (runExists2)
import Control.Alt ((<|>))
import Control.Apply (lift2)
import Control.Monad.Eff (Eff)
import Control.Plus (empty)
import Data.Lens.Getter (view)
import Data.Lens.Lens (cloneLens)
import DOM (DOM)
import DOM.Node.Document (createDocumentFragment, createElement, createTextNode)
import DOM.Node.Node (appendChild)
import DOM.Node.Types (Document, Node, documentFragmentToNode, elementToNode, textToNode)
import Data.Foldable (foldr)
import Data.Monoid (mempty)
import Data.Record (insert)
import Data.Symbol (SProxy(..))
import FRP.Event (Event) as FRP
import Unsafe.Coerce (unsafeCoerce)

import Prelude

bootstrap
  ∷ ∀ eff update state event
  . Document
  → Application update state event
  → Eff (dom ∷ DOM | eff)
      { events   ∷ FRP.Event event
      , element  ∷ Node
      , onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff eff Unit
      }

bootstrap document { view, subscription, update }
  = render document view >>= \{ element, events, onUpdate } →
      pure
        { onUpdate: undefined
        , events:   undefined
        , element
        }


render
  ∷ ∀ update state event eff
  . Document
  → Component update state event
  → Eff (dom ∷ DOM | eff)
      { onUpdate
          ∷ { update ∷ update
            , state  ∷ state
            }
          → Eff eff Unit
      , events   ∷ FRP.Event event
      , element  ∷ Node
      }

render document
  = case _ of
      CText text → do
        element ← createTextNode text document

        pure
          { onUpdate: const (pure unit)
          , events:   empty
          , element:  textToNode element
          }

      CStatic (ComponentStatic { children, properties, tagName }) → do
        parent ← createElement tagName document

        let
          prepare child = do
            { onUpdate, events, element } ← render document child

            _ ← appendChild element (elementToNode parent)
            pure { onUpdate, events }

          aggregate
            = lift2 \this that →
                { onUpdate: lift2 (lift2 append) this.onUpdate that.onUpdate
                , events:   this.events <|> that.events
                }

          initial
            = pure
                { onUpdate: pure (pure mempty)
                , events:   empty
                }

        map (insert (SProxy ∷ SProxy "element") (elementToNode parent))
            (foldr aggregate initial (map prepare children))

      CDelegate delegateE →
        let
          process = runExists2 \(ComponentDelegate { delegate, focus }) → do
            { events, element, onUpdate } ← bootstrap document delegate

            let
              update' = cloneLens focus.update
              state'  = cloneLens focus.state

            pure
              { onUpdate: \{ state, update } →
                  onUpdate
                    { update: view update' update
                    , state:  view state'  state
                    }
              , events
              , element
              }

        in process delegateE

      CWatcher (ComponentWatcher listener) → do
        fragment ← map documentFragmentToNode
                     (createDocumentFragment document)

        pure
          { onUpdate: undefined
          , events:   undefined
          , element:  fragment
          }

undefined ∷ ∀ a. a
undefined = unsafeCoerce unit

