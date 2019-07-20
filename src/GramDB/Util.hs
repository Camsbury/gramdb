--------------------------------------------------------------------------------
-- |
-- Module: GramDB.Util
-- Description: The most shareable components of the GramDB library.
-- Maintainers: Cameron Kingsbury <camsbury7@gmail.com>
-- Maturity: Draft
--
--
--------------------------------------------------------------------------------
module GramDB.Util
  ( module GramDB.Util
  ) where
--------------------------------------------------------------------------------
import Prelude
--------------------------------------------------------------------------------
import GramDB.Type
--------------------------------------------------------------------------------
import Hedgehog (Gen, Range)
import Data.UUID (UUID)
import Data.UUID.Types.Internal (fromWords)
--------------------------------------------------------------------------------
import qualified Hedgehog.Gen   as Gen
import qualified Hedgehog.Range as Range
--------------------------------------------------------------------------------
-- All purpose


-- | Generator for a 'UUID'
genUUID :: Gen UUID
genUUID
  =   fromWords
  <$> Gen.word32 Range.linearBounded
  <*> Gen.word32 Range.linearBounded
  <*> Gen.word32 Range.linearBounded
  <*> Gen.word32 Range.linearBounded


-- | Constructs a reasonable range
reasonableRange :: Range Int
reasonableRange = Range.linearFrom 0 (-10) 10


--------------------------------------------------------------------------------
-- Gram Generators

-- | Generator for a 'ScalarInt'
genScalarInt :: Gen Scalar
genScalarInt
  = ScalarInt <$> Gen.int Range.linearBounded


-- | Generator for a 'ScalarText'
genScalarText :: Gen Scalar
genScalarText
  = ScalarText <$> Gen.text reasonableRange Gen.ascii


-- | Generator for a 'ScalarDouble'
genScalarDouble :: Gen Scalar
genScalarDouble
  = fmap ScalarDouble
  . Gen.double
  $ Range.linearFracFrom 0 (-1e6) 1e6


-- | Generator for a 'ScalarBool'
genScalarBool :: Gen Scalar
genScalarBool
  = ScalarBool <$> Gen.bool


-- | Generator for a 'Scalar'
genScalar :: Gen Scalar
genScalar
  = Gen.choice
  [ genScalarInt
  , genScalarText
  , genScalarDouble
  , genScalarBool
  ]


-- | Generator for a 'Property'
genProperty :: Gen Property
genProperty
  =   Property
  <$> genUUID
  <*> genUUID
  <*> genScalar


-- | Generator for a 'Relation'
genRelation :: Gen Relation
genRelation
  =   Relation
  <$> genUUID
  <*> genUUID
  <*> genUUID


-- | Generator for a 'CardinalityMapping'
genCardinalityMapping :: Gen CardinalityMapping
genCardinalityMapping
  =   CardinalityMapping
  <$> genUUID
  <*> Gen.enumBounded


-- | Generator for a 'ClassConstraint'
genClassConstraint :: Gen ClassConstraint
genClassConstraint
  =   ClassConstraint
  <$> genUUID
  <*> Gen.set reasonableRange genCardinalityMapping


-- | Generator for a 'Gram'
genGram :: Gen Gram
genGram
  =   Gram
  <$> Gen.set reasonableRange genProperty
  <*> Gen.set reasonableRange genRelation
  <*> Gen.set reasonableRange genClassConstraint
