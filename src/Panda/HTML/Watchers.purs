module Panda.HTML.Watchers
  ( renderAlways
  , renderAlways'
  , renderMaybe
  ) where

import Data.Maybe           (Maybe(..))
import Panda.Internal.Types as Types

import Prelude ((<<<), ($))

-- | Create the update algebra for a given single child. All it really does is
-- | clear the children, and then append the given child. A long-winded
-- | rerender.
render'
  ∷ ∀ eff update state event
  . Types.Component eff update state event
  → Array (Types.ComponentUpdate eff update state event)

render' component
  = [ Types.ComponentUpdate $ Types.ArrayEmpty
    , Types.ComponentUpdate $ Types.ArrayPush component
    ]

-- | Regardless of the update, re-render this child. **NB** that this is
-- | probably a bad idea within a larger application, as it will probably
-- | equate to a lot of unnecessary re-render. Consider embedding such an
-- | element within a delegate and filtering updates to improve performance.
renderAlways
  ∷ ∀ eff update state event
  . ( { update ∷ update, state ∷ state }
    → Types.Component eff update state event
    )
  → Types.Children eff update state event

renderAlways renderer
  = Types.DynamicChildren (render' <<< renderer)

-- | Regardless of the update, re-render with no interest in what the update
-- | was. Again, this will be a real performance-killer in larger applications,
-- | so use it with caution. Beyond very simple cases, it's usually a sign that
-- | something needs rethinking.
renderAlways'
  ∷ ∀ eff update state event
  . (state → Types.Component eff update state event)
  → Types.Children eff update state event

renderAlways' renderer
  = renderAlways (renderer <<< _.state)

-- | Given an update and state, maybe produce a value. If a value _is_
-- | produced, use this value to render a component. As with the other render
-- | methods, this will trigger a full re-render.
renderMaybe
  ∷ forall eff update state event value
  . ( { update ∷ update, state ∷ state }
    → Maybe value
    )
  → (value → Types.Component eff update state event)
  → Types.Children eff update state event

renderMaybe predicate renderer
  = Types.DynamicChildren \update →
      case predicate update of
        Just details →
          render' (renderer details)

        Nothing →
          []

