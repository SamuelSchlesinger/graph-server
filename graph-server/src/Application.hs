module Application where

import Server
import API
import Servant
import Control.Concurrent.STM
import Control.Monad.Reader

app :: IO Application
app = do
  graphVar <- newTVarIO []
  return $ serve (Proxy @API) (hoistServer (Proxy @API) (flip runReaderT graphVar) server)
