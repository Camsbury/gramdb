{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
--------------------------------------------------------------------------------
-- |
-- Module: GramDB.Type
-- Description: The heart of the GramDB library.
-- Maintainers: Cameron Kingsbury <camsbury7@gmail.com>
-- Maturity: Draft
--
--
--------------------------------------------------------------------------------
module GramDB.Type
  ( module GramDB.Type
  ) where
--------------------------------------------------------------------------------
import Prelude
--------------------------------------------------------------------------------
import GramDB.Orphans ()
--------------------------------------------------------------------------------
import qualified Data.UUID as UUID
--------------------------------------------------------------------------------
import Data.Store (Store)
import Data.UUID (UUID)
--------------------------------------------------------------------------------
import Control.Lens
  ( makeFieldsNoPrefix
  )
--------------------------------------------------------------------------------

type ConstraintID = UUID
type SchemaID = UUID
type VertexID = UUID

data Scalar
  = ScalarInt Int
  | ScalarText Text
  | ScalarDouble Double
  | ScalarBool Bool
  deriving stock (Eq, Show, Ord, Generic)
  deriving anyclass (Store)

data Property = Property
  { _propertyID    :: SchemaID
  , _vertexID      :: VertexID
  , _propertyValue :: Scalar
  } deriving stock (Eq, Show, Ord, Generic)
    deriving anyclass (Store)

data Relation = Relation
  { _relationID :: SchemaID
  , _sourceID   :: VertexID
  , _targetID   :: VertexID
  } deriving stock (Eq, Show, Ord, Generic)
    deriving anyclass (Store)

data Cardinality
  = OneToOne
  | OneToAlwaysOne
  | OneToMany
  deriving stock (Eq, Show, Ord, Generic, Enum, Bounded)
  deriving anyclass (Store)

data CardinalityMapping = CardinalityMapping
  { _schemaID    :: SchemaID
  , _cardinality :: Cardinality
  } deriving stock (Eq, Show, Ord, Generic)
    deriving anyclass (Store)

data ClassConstraint = ClassConstraint
  { _constraintID  :: ConstraintID
  , _cardinalities :: Set CardinalityMapping
  } deriving stock (Eq, Show, Ord, Generic)
    deriving anyclass (Store)

data Gram = Gram
  { _properties       :: Set Property
  , _relations        :: Set Relation
  , _classConstraints :: Set ClassConstraint
  } deriving stock (Eq, Show, Ord, Generic)
    deriving anyclass (Store)

makeFieldsNoPrefix ''Property
makeFieldsNoPrefix ''Relation
makeFieldsNoPrefix ''CardinalityMapping
makeFieldsNoPrefix ''ClassConstraint
makeFieldsNoPrefix ''Gram
