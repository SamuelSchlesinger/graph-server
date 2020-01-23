module Main where

import Network.Wai.Handler.Warp
import Application

main :: IO ()
main = run 8080 =<< app
