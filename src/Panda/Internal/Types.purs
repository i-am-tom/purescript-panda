module Panda.Internal.Types where

import Control.Monad.Eff (Eff)
import Data.Lazy (Lazy)
import Data.Maybe (Maybe)
import FRP.Event (Event) as FRP
import Util.Exists (Exists3)

import Prelude

type Canceller eff = Eff eff Unit

data Producer
  = OnClick

newtype PropertyStatic
  = PropertyStatic
      { key   ∷ String
      , value ∷ String
      }

newtype PropertyWatcher update state event
  = PropertyWatcher
  { key ∷ String
  , listener ∷
      { update ∷ update
      , state  ∷ state
      }
    → { interest ∷ Boolean
      , renderer ∷ Lazy (Property update state event)
      }
  }

newtype PropertyProducer event
  = PropertyProducer
      { key   ∷ Producer
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


newtype ComponentDelegate update state event subupdate substate subevent
  = ComponentDelegate
      { delegate ∷ Application subupdate substate subevent
      , focus
          ∷ { update ∷ update → Maybe subupdate
            , state  ∷ state → substate
            , event  ∷ subevent → event
            }
      }


data Component update state event
  = CStatic            (ComponentStatic   update state event)
  | CWatcher           (ComponentWatcher  update state event)
  | CDelegate (Exists3 (ComponentDelegate update state event))
  | CText String


type Application update state event
  = { view         ∷ Component update state event
    , subscription ∷ FRP.Event event
    , update       ∷ Maybe { state ∷ state, event ∷ event }
                   → { update ∷ update, state ∷ state }
    }

