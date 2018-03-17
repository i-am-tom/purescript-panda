module Test.Example.HelloWorld where

-- About as simple as you can get! This application simply prints "Hello?", and
-- that's it. Nothing is producing events, and nothing is watching for them.

-- We're going to need a few imports:

import Control.Monad.Eff (Eff)

-- We use `empty` to describe an event stream with no events in it. We'll use
-- this to say that we're not interested in external events.
import Control.Plus (empty)

import Prelude (Unit, unit, pure, void)

import Panda          as P
import Panda.HTML     (text)

main :: forall eff. Eff (P.FX eff) Unit
main
  = void
      ( P.runApplication
        { view: text "Hello?"
        , subscription: empty -- We don't care about any external events!
        , initial: { update: unit, state: unit }

          -- As there are no events going on, we don't really care about
          -- updating anything. This function says just that: we don't care
          -- about any events, nor do we care about creating updates.
        , update: \_ _ -> pure unit
        }
      )
