module Graph where

import Data.List
type Graph = [(Int, [Int])]

connected :: Int -> Int -> Graph -> Bool
connected i j graph = i == j || case lookup i graph of
  Just iadj -> or (fmap (\i' -> connected i' j (filter ((/= i) . fst) graph)) iadj)
  _ -> False

component :: Int -> Graph -> [Int]
component i graph = case lookup i graph of
  Just iadj -> nub $ i : (iadj >>= flip component (filter ((/= i) . fst) graph))
  _ -> [i]

createVertex :: Graph -> (Int, Graph)
createVertex graph = (m, (m, []) : graph) where
  m = maximum (fst <$> graph) + 1 

createEdge :: Int -> Int -> Graph -> Graph
createEdge i j graph = case lookup j graph of
  Just _ -> (\(i', i'adj) -> if i' == i then (i', j : i'adj) else (i', i'adj)) <$> graph
  _ -> graph

neighbors :: Int -> Graph -> [Int]
neighbors i graph = maybe [] id (lookup i graph)
