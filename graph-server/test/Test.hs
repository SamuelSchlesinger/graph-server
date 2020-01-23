import Graph

import Control.Exception
import Data.List

complete :: Int -> Graph
complete n = [ (i, filter (/= i) [1..n]) | i <- [1..n] ]

allConnectedInCompleteGraph :: Int -> Bool
allConnectedInCompleteGraph n = and $ do
  i <- [1..n]
  j <- [1..n]
  pure (connected i j (complete n))

allComponentsInCompleteGraphAreFull :: Int -> Bool
allComponentsInCompleteGraphAreFull n = and $ do
  i <- [1..n]
  pure (sort (component i (complete n)) == [1..n])

tests :: Bool
tests = and [allConnectedInCompleteGraph n && allComponentsInCompleteGraphAreFull n | n <- [1..500]]

main :: IO ()
main = assert tests $ pure ()
