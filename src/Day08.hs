module Main where

import Data.Char (digitToInt)
import Data.List (transpose)

main :: IO ()
main = do
    input <- readFile "inputs/day8.txt"
    let parsed = parse input
    putStrLn $ "Day 08, Part 1: " ++ show (part1 parsed)
    putStrLn $ "Day 08, Part 2: " ++ show (part2 parsed)

parse :: String -> [[Int]]
parse = map (map digitToInt) . lines

part1 :: [[Int]] -> Int
part1 parsed =
    length
        . filter (== True)
        . concatMap (uncurry (zipWith (||)))
        $ zip rows (transpose cols)
  where
    rows = map (\(x : xs) -> visible ([], x, xs)) parsed
    cols = map (\(x : xs) -> visible ([], x, xs)) (transpose parsed)

part2 :: [[Int]] -> Int
part2 parsed =
    maximum
        . concatMap (uncurry (zipWith (*)))
        $ zip rows (transpose cols)
  where
    rows = map (\(x : xs) -> score ([], x, xs)) parsed
    cols = map (\(x : xs) -> score ([], x, xs)) (transpose parsed)

visible :: ([Int], Int, [Int]) -> [Bool]
visible (_, _, []) =
    [True]
visible ([], n, x : xs) =
    True : visible ([n], x, xs)
visible (xs, n, ys@(yh : yr)) =
    (n > maximum xs || n > maximum ys)
        : visible (n : xs, yh, yr)

score :: ([Int], Int, [Int]) -> [Int]
score (_, _, []) =
    [0]
score ([], n, x : xs) =
    0 : score ([n], x, xs)
score (xs, n, ys@(yh : yr)) =
    (visibleNum n xs * visibleNum n ys) : score (n : xs, yh, yr)

visibleNum :: Int -> [Int] -> Int
visibleNum n l =
    if len == length l
        then len
        else len + 1
  where
    len =
        length
            . takeWhile (< n)
            $ l