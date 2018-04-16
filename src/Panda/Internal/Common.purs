module Panda.Internal.Common where

import DOM.Node.Types             (Element, Node) as DOM
import Effect                     (Effect)
import Data.Maybe                 (Maybe)
import FRP.Event                  (Event) as FRP
import Panda.Internal.EventSystem (EventSystem)
import Unsafe.Coerce              (unsafeCoerce)

import Panda.Prelude

-- | A Panda application looks very similar to an Elm application: you provide
-- | a `view`, a `subscription` to any external events, an `initial` state and
-- | update, and an `update` function for dispatching updates. The signature
-- | looks a little ugly, but it's essentially a `dispatch` function and
-- | whatever event originally triggered the `update` call, along with the
-- | state at that moment in time. `dispatch` takes a callback that will
-- | receive the state at _that_ current moment in time. Why? For operations
-- | involving AJAX, for example, this allows us to be more intelligent about
-- | incremental updates because we can see how state has changed since we
-- | began.

type Application update state event
  = { view         ∷ ComponentX update state event
    , subscription ∷ FRP.Event event
    , initial      ∷ { update ∷ update, state ∷ state }
    , update
        ∷ ((state → { update ∷ update, state ∷ state }) → Effect Unit)
          → { event ∷ event, state ∷ state }
          → Effect Unit
    }

-- | Convenience type for annotations. Anything that "bootstraps" an
-- | application.

type Bootstrapper update state event
  = ∀ update' state' event'
  . Application update' state' event'
  → Effect
      { node   ∷ DOM.Node
      , system ∷ Maybe (EventSystem update' state' event')
      }

-- | The class of components in Panda is anything that can be rendered into a
-- | DOM node that may or may not produce events.

class Component component update state event where
  renderComponent
    ∷ Bootstrapper update state event
    → component
    → Effect
        { node   ∷ DOM.Node
        , system ∷ Maybe (EventSystem update state event)
        }

-- | In order to write things in our DSL, we need to turn all our components
-- | into objects of the same type. To do this, we make the type of component
-- | existential.

foreign import data ComponentX ∷ Type → Type → Type → Type

-- | This is an unfortunate bit of ugliness due to the lack of ConstraintKinds
-- | and GADTs. What we do is render the component, and then unsafely coerce
-- | that into our ComponentX type. What we'd _like_ to do is coerce the actual
-- | component, along with its rendering dictionary, and then unpack it on the
-- | other side. Alas, no luck :(

existentialiseComponent
  ∷ ∀ component update state event
  . Component component update state event
  ⇒ component
  → ComponentX update state event

existentialiseComponent component
  = unsafeCoerce \(bootstrap ∷ ∀ u s e. Bootstrapper u s e) →
      renderComponent bootstrap component
        ∷ Effect
            { node ∷ DOM.Node
            , system ∷ Maybe (EventSystem update state event)
            }

-- | "Unexistentialise" a component. Again, this is an ugly implementation:
-- | because we can't carry the dictionary, we render the component (or, at
-- | least, produce the `Eff` to do so) on the way in, and unsafely coerce
-- | that on the way out.

renderComponentX
  ∷ ∀ update state event
  . Bootstrapper update state event
  → ComponentX update state event
  → Effect
      { node ∷ DOM.Node
      , system ∷ Maybe (EventSystem update state event)
      }

renderComponentX
  = unsafeCoerce

-- | The class of Panda properties can, given an element, effectfully produce
-- | an event system. This usually means either setting some properties on that
-- | element, or listening for updates to do so later.

class Property property update state event where
  renderProperty
    ∷ DOM.Element
    → property
    → Effect (Maybe (EventSystem update state event))

-- | In identical form to `ComponentX`, the only way we can write an array of
-- | properties is if they're all the same type. So, we existentialise the
-- | properties, leaving us with only the ability to render.

foreign import data PropertyX ∷ Type → Type → Type → Type

-- | Again, a dirty implementation detail: we're not really "existentialising"
-- | the component - just storing its render function. This allows us to render
-- | from an existential without dealing with all the dictionary issues.

existentialiseProperty
  ∷ ∀ property update state event
  . Property property update state event
  ⇒ property
  → PropertyX update state event

existentialiseProperty property
  = unsafeCoerce \element →
      renderProperty element property
        ∷ Effect (Maybe (EventSystem update state event))

-- | An existential property can be rendered by "unexistentialising" the
-- | property. We hide the middle step because we had to do the work on the way
-- | in: existential properties are actually coerced render functions.

renderPropertyX
  ∷ ∀ update state event
  . DOM.Element
  → PropertyX update state event
  → Effect (Maybe (EventSystem update state event))

renderPropertyX element propertyX
  = unsafeCoerce propertyX
  $ element
