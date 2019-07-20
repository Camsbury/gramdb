--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
module Test.Support
  ( withTestDatabase
  ) where
--------------------------------------------------------------------------------
import Test.Prelude
--------------------------------------------------------------------------------
import GramDB
--------------------------------------------------------------------------------

-- | Helper for creating unique test ids
testState :: MVar Int
{-# NOINLINE testState #-}
testState = unsafePerformIO $ newMVar 0

-- | Create a unique ident for the test
newTestState :: MonadIO m => m Int
newTestState = liftIO $ modifyMVar testState (\x -> pure (succ x, x))

-- | Create a database name for the test
mkTestDatabase :: Int -> String
mkTestDatabase state = "testDatabase" <> show state <> ".db"

-- | Create a database from a 'FilePath'
initDatabase :: FilePath -> IO ()
initDatabase = undefined

-- | Run a test with its own DB!
withTestDatabase
  :: GramM a -> IO a
withTestDatabase = undefined
