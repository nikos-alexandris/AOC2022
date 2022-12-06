module Main where

import Data.List (nub)

main :: IO ()
main = do
    input <- readFile "inputs/day6.txt"
    putStrLn $ "Day 6, Part 1: " ++ show (part1 input)
    putStrLn $ "Day 6, Part 2: " ++ show (part2 input)

part1 :: [Char] -> Int
part1 = (+ 4) . length . takeWhile ((/= 4) . length . nub) . windowed 4

part2 :: [Char] -> Int
part2 = (+ 14) . length . takeWhile ((/= 14) . length . nub) . windowed 14

windowed :: Int -> [a] -> [[a]]
windowed n xs
    | length xs < n = []
    | otherwise = take n xs : windowed n (tail xs)
