module Panda.Property
  ( module Builders
  , module ExportedTypes
  ) where

-- | This file exports the property API for Panda applications. Everything that
-- | is accessible under the `PP` namespace comes from this file as an import
-- | by proxy.

import Panda.Builders.Properties as Builders
import Panda.Internal
         ( Producer (..)
         , Property (..)
         )
  as ExportedTypes
