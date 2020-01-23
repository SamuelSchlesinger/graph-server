module Application where

import API
import Control.Concurrent.STM
import Control.Monad.Reader
import Network.Wai.Middleware.RequestLogger
import Servant
import Server

app :: IO Application
app = logStdoutDev <$> do
  graphVar <- newTVarIO []
  return $ serve (Proxy @API) (hoistServer (Proxy @API) (flip runReaderT graphVar) server)
