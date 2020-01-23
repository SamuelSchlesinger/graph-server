import Graph

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

line :: Int -> Graph
line n = (n, [1]) : [(i, [i + 1]) | i <- [1..n - 1]]

shortestPathInLineIsLine :: Int -> Bool
shortestPathInLineIsLine n = case shortestPath 1 n (line n) of
  Just xs -> xs == [1..n]
  Nothing -> False

tests :: Bool
tests = and [allConnectedInCompleteGraph n 
          && allComponentsInCompleteGraphAreFull n 
          && shortestPathInLineIsLine n 
          | n <- [1..20]]

main :: IO ()
main = if tests then return () else error "dang"
