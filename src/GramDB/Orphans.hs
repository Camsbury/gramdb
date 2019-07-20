{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
--------------------------------------------------------------------------------
-- |
-- Module: GramDB.Orphans
-- Description: Where typeclass orphans are held
-- Maintainers: Cameron Kingsbury <camsbury7@gmail.com>
-- Maturity: Draft
--
--
--------------------------------------------------------------------------------
module GramDB.Orphans
  ( module GramDB.Orphans
  ) where
--------------------------------------------------------------------------------
import Prelude
--------------------------------------------------------------------------------
import Data.Store (Store)
import Data.UUID.Types.Internal (UUID(..))
--------------------------------------------------------------------------------

deriving instance Generic UUID
instance Store UUID
