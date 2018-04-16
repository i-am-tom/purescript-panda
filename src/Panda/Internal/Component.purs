module Panda.Internal.Component
  ( Collection
  , ComponentUpdate
  , Delegate
  , Element
  , Text
  ) where

import DOM.Node.Document     (createElement, createTextNode) as DOM
import DOM.Node.Node         (appendChild) as DOM
import DOM.Node.Types        (elementToNode, textToNode) as DOM
import Data.Algebra.Array    as Algebra.Array
import Data.Foldable         (fold)
import Data.Maybe            (Maybe(..))
import Data.Traversable      (for, traverse)
import Panda.Internal.Common as Common

import Panda.Prelude

-- | Regular text can be inserted into the DOM as a text node.

newtype Text
  = Text String

instance componentText ∷ Common.Component Text update state event where
  renderComponent _ (Text text) = do
    document' ← document
    node      ← effToEffect (DOM.createTextNode text document')

    pure { node: DOM.textToNode node, system: Nothing }

-- | Delegate applications can be mounted as components to allow composition of
-- | applications in larger settings.

newtype Delegate update state event
  = Delegate
      ( ∀ subupdate substate subevent
      . { delegate ∷ Common.Application subupdate substate subevent
        , focus
            ∷ { update ∷    update → Maybe subupdate
              , state  ∷    state  →       substate
              , event  ∷ subevent  → Maybe event
              }
        }
      )

--instance componentDelegate
--    ∷ Component (Delegate update state event) update state event where
--  renderComponent bootstrap (Delegate { delegate, focus })
--    = bootstrap delegate <#> \{ node, system } →
--        case system of
--          Nothing →
--            { node, system: Nothing }
--
--          Just (EventSystem subsystem) →
--            { node
--            , system: Just $ EventSystem subsystem
--                { events = filterMap focus.event subsystem.events
--
--                , handleUpdate = \{ state, update } →
--                    case focus.update update of
--                      Nothing →
--                        pure unit
--
--                      Just subupdate →
--                        subsystem.handleUpdate
--                          { update: subupdate
--                          , state:  focus.state state
--                          }
--                }
--            }


-- | When a Panda component wants to alter its child elements dynamically, it
-- | does so by way of an incremental `ComponentUpdate` algebra. This specifies
-- | a set of possible operations and, in cases of expanding the child list,
-- | the specifications for those new children.

type ComponentUpdate update state event
  = Algebra.Array.Update (Common.ComponentX update state event)

-- | A "Collection" is a node whose children can be updated incrementally using
-- | the ComponentUpdate algebra. It's otherwise the same as an Element, but
-- | note that an element's children are largely fixed.

newtype Collection update state event
  = Collection
      { tagName ∷ String
      , properties ∷ Array (Common.PropertyX update state event)
      , handler
          ∷ { state ∷ state, update ∷ update }
          → Array (ComponentUpdate update state event)
      }

-- | An "element" is pretty much exactly what it means in the DOM spec: it's an
-- | HTML element with some properties and some children. All its magic will
-- | come from its properties and children, either of which may be dynamic.

newtype Element update state event
  = Element
      { tagName    ∷ String
      , properties ∷ Array (Common.PropertyX update state event)
      , children   ∷ Array (Common.ComponentX update state event)
      }

instance componentElement
    ∷ Common.Component (Element update state event) update state event where
  renderComponent bootstrap (Element { tagName, properties, children }) = do
    document' ← document

    element ← effToEffect $ DOM.createElement tagName document'
    let parentNode = DOM.elementToNode element

    -- Attach all the properties to the newly-created element.
    -- TODO: s/map fold $ traverse/foldMap/ once Effect is Monoid.

    propertySystem
      ← map fold
      ∘ traverse (Common.renderPropertyX element)
      $ properties

    -- Set up all the children's systems and nodes...

    renderedChildren
      ← traverse (Common.renderComponentX bootstrap)
      $ children

    -- TODO: s/map fold $ for/flip foldMap/ once Effect is Monoid.

    childrenSystem ← map fold $ for renderedChildren \{ node, system } →
      effToEffect $ DOM.appendChild node parentNode $> system

    pure
      { node: parentNode
      , system: propertySystem <> childrenSystem
      }
