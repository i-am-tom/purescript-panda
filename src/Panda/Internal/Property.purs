module Panda.Internal.Property where

import Data.Either           (Either)
import DOM.Event.Types       (Event) as DOM
import Data.Algebra.Map      as Algebra.Map
import Data.Generic.Rep      (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe            (Maybe)
import Data.String           (drop, toLower)

import Prelude

-- | All the possible event producers within the Panda DSL.
data Producer
  = OnBlur
  | OnChange
  | OnClick
  | OnDoubleClick
  | OnDrag
  | OnDragEnd
  | OnDragEnter
  | OnDragLeave
  | OnDragOver
  | OnDragStart
  | OnDrop
  | OnError
  | OnFocus
  | OnInput
  | OnKeyDown
  | OnKeyPress
  | OnKeyUp
  | OnMouseDown
  | OnMouseEnter
  | OnMouseLeave
  | OnMouseMove
  | OnMouseOver
  | OnMouseOut
  | OnMouseUp
  | OnScroll
  | OnSubmit
  | OnTransitionEnd

derive instance eqProducer      ∷ Eq Producer
derive instance genericProducer ∷ Generic Producer _
derive instance ordProducer     ∷ Ord Producer

instance showProducer ∷ Show Producer where
  show = genericShow

-- | Given a Producer, return the string that identifies it when adding an
-- | event handler. This is also the string we use for the attribute when we
-- | attach it to the DOM. Dirty hack, internally.
producerToString ∷ Producer → String
producerToString = toLower <<< drop 2 <<< show

-- | A property update acts either on an event handler, or a static property.
type PropertyUpdate event
  = Either
      (Algebra.Map.Update Producer (DOM.Event → Maybe event))
      (Algebra.Map.Update String String)

-- | Properties are either static key/value pairs, listeners for DOM updates
-- | (that can then change the properties on an element), or producers of
-- | events (that then bubble up to the `update` function).
data Property event
  = PropertyFixed
      { key   ∷ String
      , value ∷ String
      }

  | PropertyProducer
      { key     ∷ Producer
      , onEvent ∷ DOM.Event → Maybe event
      }

-- | When we actually refer to sets of properties, they're either a fixed set
-- | of static properties, or a dynamic set dependent on some predicate.
data Properties update state event
  = StaticProperties (Array (Property event))

  | DynamicProperties
      ( { update ∷ update
        , state ∷ state
        }
      → Array (PropertyUpdate event)
      )

