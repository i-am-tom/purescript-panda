module Panda.Application where

-- There are problems to be had with cyclical dependencies. In an effort to
-- avoid them, this file declares all the relevant types in one go.

import Data.Lens    (Lens')
import FRP.Event    (Event)
import Util.Exists2 (Exists2)


-- Configuration for a Panda application. These three values encompass
-- everything required for a Panda application to be fully functioning.

type Application event state
  = ∀ action

  . { -- A view is the generated output. Certain components within it can be
      -- configured to listen for a particular event and, with that and the
      -- state, update themselves. Moreover, UI events can trigger _actions_,
      view ∷ state → Component event state action

      -- A UI can be affected by an event (which itself can be the combination
      -- of many events) that occurs according to some side-effects.
    , subscription ∷ Event event

      -- When a UI action occurs, this function produces the UI update event.
    , update ∷ state → action → { event ∷ event, state ∷ state }

    }


-- A regular element - one with nothing interesting going on - is just a tag
-- name, some properties, and any children underneath. Of course, not all
-- elements will have children.

type Element event state action
  = { tagName    ∷ String
    , properties ∷ Array (Property action)
    , children   ∷ Array (Component event state action)
    }


-- A watcher is a component that is dependent on some event predicate. When the
-- predicate passes, the render function is called with the current state to
-- determine what needs to be done with the DOM element. It's quite nifty.

type Watcher event state action
  = { interest ∷ event → Boolean
    , renderer ∷ state → Component event state action
    }


-- A delegate is a "sub-application" within our larger tree. This is pretty
-- neat because we can write applications that focus on specific parts of our
-- data, and then compose them together to deal with larger structures.

newtype Delegate' event state subevent substate
  = Delegate'
      { focus
          ∷ { state ∷ Lens' state subevent
            , event ∷ Lens' event subevent
            }

      , delegate ∷ Application subevent substate
      }


type Delegate event state = Exists2 (Delegate' event state)


-- A component is just the stuff from above. :)

data Component event state action
  = Element  (Element  event state action)
  | Watcher  (Watcher  event state action)
  | Delegate (Delegate event state)


-- TODO: expand this out _a lot_.

type Property action
  = { key ∷ String
    , value ∷ String
    }


-- Neat little fold.

component
  ∷ ∀ eff event state action result
  . (Element   event state action → result) 
  → (Watcher   event state action → result)
  → (Delegate  event state        → result)
  →  Component event state action
  → result

component element watcher delegate
  = case _ of
      Element  value → element  value
      Watcher  value → watcher  value
      Delegate value → delegate value

