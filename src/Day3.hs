module Main where

import Data.Bifunctor (Bifunctor (bimap))
import Data.Char (ord)
import Data.Set (Set)
import Data.Set qualified as Set

main :: IO ()
main = do
    input <- readFile "inputs/day3.txt"
    let sacks = lines input
    putStrLn $ "Day 3, Part 1: " ++ show (part1 sacks)
    putStrLn $ "Day 3, Part 2: " ++ show (part2 sacks)

part1 :: [String] -> Int
part1 sacks =
    sum scores
  where
    scores = map score same
    same = map (Set.elemAt 0 . uncurry Set.intersection) sliced'
    sliced' = map (bimap Set.fromList Set.fromList) sliced
    sliced = map splitMiddle sacks

part2 :: [String] -> Int
part2 sacks =
    sum scores
  where
    scores = map score badges
    badges =
        map
            ( \(x, y, z) ->
                Set.elemAt
                    0
                    ( Set.fromList x `Set.intersection` Set.fromList y `Set.intersection` Set.fromList z
                    )
            )
            grouped
    grouped = map (\[x, y, z] -> (x, y, z)) (chunksOf 3 sacks)

score :: Char -> Int
score c
    | c `elem` ['a' .. 'z'] = ord c - ord 'a' + 1
    | c `elem` ['A' .. 'Z'] = ord c - ord 'A' + (ord 'Z' - ord 'A') + 2
    | otherwise = 0

splitMiddle :: [a] -> ([a], [a])
splitMiddle xs = splitAt (length xs `div` 2) xs

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)
