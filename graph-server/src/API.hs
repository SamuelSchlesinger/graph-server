module API where

import Servant

type API = "insert" :> ("edge" :> ReqBody '[JSON] (Int, Int) :> Post '[JSON] ()
                   :<|> "node" :> Post '[JSON] Int)
      :<|> "query" :> ("connected" :> ReqBody '[JSON] (Int, Int) :> Post '[JSON] Bool
                  :<|> "neighbors" :> ReqBody '[JSON] Int :> Post '[JSON] [Int]
                  :<|> "component" :> ReqBody '[JSON] Int :> Post '[JSON] [Int])
      :<|> "snapshot" :> Get '[JSON] [(Int, [Int])]
