{- HLINT ignore "Reduce duplication" -}
--------------------------------------------------------------------------------
module GramDBTest where
--------------------------------------------------------------------------------
import Test.Prelude
import Test.Support
--------------------------------------------------------------------------------
import GramDB
--------------------------------------------------------------------------------

main :: IO ()
main
  = defaultMain
  . localOption (HedgehogTestLimit $ Just 5)
  $ testGroup "GramDB round trips"
  [
  ]

