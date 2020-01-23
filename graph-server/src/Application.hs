module Application where

import Server
import API
import Servant
import Control.Concurrent.STM
import Control.Monad.Reader
import Network.Wai.Middleware.RequestLogger

app :: IO Application
app = logStdoutDev <$> do
  graphVar <- newTVarIO []
  return $ serve (Proxy @API) (hoistServer (Proxy @API) (flip runReaderT graphVar) server)
