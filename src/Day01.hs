module Main where

import Data.List (sortBy)

main :: IO ()
main = do
    input <- readFile "inputs/day1.txt"
    let numbers = lines input
    putStrLn $ "Day 01, Part 1: " ++ show (part1 numbers)
    putStrLn $ "Day 01, Part 2: " ++ show (part2 numbers)

part1 :: [String] -> Int
part1 =
    maximum
        . map (sum . map read)
        . splitBy ""

part2 :: [String] -> Int
part2 =
    sum
        . take 3
        . sortBy (flip compare)
        . map (sum . map read)
        . splitBy ""

splitBy :: Eq a => a -> [a] -> [[a]]
splitBy _ [] = []
splitBy x xs =
    first : case rest of
        [] -> []
        (_ : xs') -> splitBy x xs'
  where
    (first, rest) = break (== x) xs
