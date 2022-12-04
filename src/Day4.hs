module Main where

import Data.Bifunctor (bimap)

main :: IO ()
main = do
    input <- readFile "inputs/day4.txt"
    let parsed = parseInput input
    putStrLn $ "Day 4, Part 1: " ++ show (part1 parsed)
    putStrLn $ "Day 4, Part 2: " ++ show (part2 parsed)

part1 :: [((Int, Int), (Int, Int))] -> Int
part1 =
    length . filter (\(a, b) -> a `fullyContains` b || b `fullyContains` a)

part2 :: [((Int, Int), (Int, Int))] -> Int
part2 =
    length . filter (uncurry overlap)

overlap :: (Int, Int) -> (Int, Int) -> Bool
overlap (a, b) (c, d) = a <= c && c <= b || c <= a && a <= d

fullyContains :: (Int, Int) -> (Int, Int) -> Bool
(a, b) `fullyContains` (c, d) = a <= c && b >= d

parseInput :: String -> [((Int, Int), (Int, Int))]
parseInput =
    map
        ( bimap (bimap read read . splitAtChar '-') (bimap read read . splitAtChar '-')
            . splitAtChar ','
        )
        . lines

splitAtChar :: Char -> String -> (String, String)
splitAtChar c s = (takeWhile (/= c) s, drop 1 $ dropWhile (/= c) s)
