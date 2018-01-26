module Panda.Internal.Types where

import Data.Lens    (APrism')
import FRP.Event    (Event)
import Util.Exists2 (Exists2)


type PropertyStatic
  = { key   ∷ String
    , value ∷ String
    }


type PropertyWatcher update state event
  = { update :: update
    , state  :: state
    }
  → { interest ∷ Boolean
    , render ∷ Lazy (Property update state event)
    }


type PropertyProducer event
  = { key   ∷ String
    , event ∷ event
    }


data Property update state event
  = PStatic    PropertyStatic
  | PWatcher  (PropertyWatcher  update state event)
  | PProducer (PropertyProducer              event)


type ComponentStatic update state event
  = { children   ∷ Array (Component update state event)
    , properties ∷ Array (Property  update state event)
    , tagName    ∷ String
    }


type ComponentWatcher update state event
  = { update ∷ update
    , state  ∷ state
    }
  → { interest ∷ Boolean
    , renderer ∷ Lazy (Component update state event)
    }


type ComponentDelegate update state event subupdate substate
  = { delegate ∷ Application subupdate substate event
    , focus
        ∷ { update ∷ APrism' update subupdate
          , state  ∷ APrism' state substate
          }
    }


data Component update state event
  = CStatic            (ComponentStatic   update state event)
  | CWatcher           (ComponentWatcher  update state event)
  | CDelegate (Exists2 (ComponentDelegate update state event))
  | CText String


type Application update state event
  = { view         ∷ Component update state event
    , subscription ∷ Event event
    , update       ∷ state → event → { update ∷ update, state ∷ state }
    }

