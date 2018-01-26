module Panda.Bootstrap where

import Control.Monad.Eff (Eff)
import FRP.Event         (Event) as FRP

bootstrap
  ∷ ∀ eff update state event
  . Application update state event
  → Eff { onUpdate ∷ update → Eff eff Unit
        , events   ∷ FRP.Event event
        , element  ∷ Element
        }

bootstrap { view, subscription, update }
  = render view >>= \{ element, events, onUpdate } →
      { onUpdate: undefined
      , events:   undefined
      , element:  undefined
      }


render
  ∷ ∀ update state event eff
  . Application update state event
  → Eff { onUpdate ∷ update → Eff eff Unit
        , events   ∷ Event event
        , element  ∷ Element
        }

render
  = case _ of
      CText text →
        { onUpdate: const (pure unit)
        , events:   zero
        , element:  createTextNode text
        }

      CStatic { children, properties, tagName } →
        { onUpdate: undefined
        , events:   undefined
        , element:  undefined
        }

      CDelegate delegate →
        delegate # runExists2 \{ delegate, focus: { update, state } } →
          { onUpdate: undefined
          , events:   undefined
          , element:  undefined
          }

      CWatcher listener →
        { onUpdate: undefined
        , events:   undefined
        , element:  undefined
        }

undefined ∷ ∀ a. a
undefined = unsafeCoerce unit

