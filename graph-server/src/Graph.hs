module Graph where

import Data.List
import Data.Maybe

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
  m = foldr max (-1) (fst <$> graph) + 1

createEdge :: Int -> Int -> Graph -> Graph
createEdge i j graph = case lookup j graph of
  Just _ -> (\(i', i'adj) -> if i' == i then (i', j : i'adj) else (i', i'adj)) <$> graph
  _ -> graph

neighbors :: Int -> Graph -> [Int]
neighbors i graph = maybe [] id (lookup i graph)

shortestPath :: Int -> Int -> Graph -> Maybe [Int]
shortestPath i j graph | i == j = Just [i]
                       | otherwise = case lookup i graph of
  Just iadj -> case catMaybes $ map (\i' -> (i :) <$> shortestPath i' j (filter ((/= i) . fst) graph)) iadj of
                 [] -> Nothing
                 xs -> Just $ minimumBy (\x y -> compare (length x) (length y)) xs
  Nothing -> Nothing
