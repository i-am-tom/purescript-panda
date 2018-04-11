module Panda.Internal.Property where

import DOM.Event.Types       (Event) as DOM
import Data.Generic.Rep      (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Identity         (Identity)
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

-- | A property (parameterised by some functor) is either a static key/value
-- | pair, or a function that is given a DOM event and produces some event-type
-- | output.

data PropertyF f update state event
  = Fixed    { key ∷ String,   value   ∷ f String }
  | Producer { key ∷ Producer, onEvent ∷ f (DOM.Event → Maybe event) }

-- | Should we update? Or shall we just leave things as they are?
data ShouldUpdate a = Ignore | Rerender a

-- | How should we update? Should we set a value or remove whatever's there?
data PropertyUpdate a = Set a | Delete

-- | A _dynamic_ property is one whose value depends on the state of the
-- | application at the current time.

newtype DynamicF update state a
  = DynamicF
      ( { state ∷ state, update ∷ update }
      → ShouldUpdate (PropertyUpdate a)
      )

-- | An actual property is either static (parameterised by identity) or dynamic
-- | (parameterised by a function from an update/state pair), which means that
-- | it can respond to changes in the model.

data Property update state event

  = StaticProperty (PropertyF Identity update state event)

  | DynamicProperty (PropertyF (DynamicF update state) update state event)
