module API where

import Servant

type API = "insert" :> ("edge" :> ReqBody '[JSON] (Int, Int) :> Post '[JSON] ()
                   :<|> "node" :> Post '[JSON] Int)
      :<|> "query"  :> ("connected" :> ReqBody '[JSON] (Int, Int) :> Get '[JSON] Bool
                   :<|> "neighbors" :> ReqBody '[JSON] Int :> Get '[JSON] [Int]
                   :<|> "component" :> ReqBody '[JSON] Int :> Get '[JSON] [Int])
