module Server where

import Servant
import API
import Graph
import Control.Monad.Reader
import Control.Concurrent.STM

server :: ServerT API (ReaderT (TVar Graph) Handler)
server = (dispatchEdge :<|> dispatchNode) :<|> (dispatchConnected :<|> dispatchNeighbors :<|> dispatchComponent) where
  dispatchEdge (i, j) = do
    graphVar <- ask
    liftIO $ atomically $ do
      modifyTVar graphVar (createEdge i j)
  dispatchNode = do
    graphVar <- ask
    liftIO $ atomically $ do
      graph <- readTVar graphVar
      let (i, graph') = createVertex graph
      writeTVar graphVar graph'
      return i
  dispatchConnected (i, j) = do
    graphVar <- ask
    liftIO $ atomically $ do
      graph <- readTVar graphVar
      return $ connected i j graph
  dispatchNeighbors i = do
    graphVar <- ask
    liftIO $ atomically $ do
      graph <- readTVar graphVar
      return $ neighbors i graph
  dispatchComponent i = do
    graphVar <- ask
    liftIO $ atomically $ do
      graph <- readTVar graphVar
      return $ component i graph
