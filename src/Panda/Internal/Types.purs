module Panda.Internal.Types where

import Data.Lazy    (Lazy)
import Data.Lens    (ALens')
import FRP.Event    (Event)
import Util.Exists2 (Exists2)


type PropertyStatic
  = { key   ∷ String
    , value ∷ String
    }


type PropertyWatcher update state event
  = { update ∷ update
    , state  ∷ state
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


newtype ComponentStatic update state event
  = ComponentStatic
      { children   ∷ Array (Component update state event)
      , properties ∷ Array (Property  update state event)
      , tagName    ∷ String
      }


newtype ComponentWatcher update state event
  = ComponentWatcher
      ( { update ∷ update
        , state  ∷ state
        }
      → { interest ∷ Boolean
        , renderer ∷ Lazy (Component update state event)
        }
      )


newtype ComponentDelegate update state event subupdate substate
  = ComponentDelegate
      { delegate ∷ Application subupdate substate event
      , focus
          ∷ { update ∷ ALens' update subupdate
            , state  ∷ ALens' state substate
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

