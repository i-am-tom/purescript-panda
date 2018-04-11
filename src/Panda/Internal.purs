module Panda.Internal
  ( module Application
  , module Component
  , module EventSystem
  , module Property

  , App
  ) where

-- | All common internal machinery for the Panda application that is shared
-- | between modules.

import Panda.Internal.Application as Application
import Panda.Internal.Component   as Component
import Panda.Internal.EventSystem as EventSystem
import Panda.Internal.Property    as Property

-- | To avoid problems with mutual recursion,the `Application` type takes a
-- | `Component` type constructor as a parameter. That's ugly for end users, so
-- | the `App` synonym does this plumbing for us, and no one needs to see any
-- | of that :)

type App eff update state event
  = Application.Application Component.Component eff update state event
