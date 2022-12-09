module Main where

import Data.List (scanl')
import Data.Set qualified as Set

main :: IO ()
main = do
    input <- readFile "inputs/day9.txt"
    let parsed = parseInput input
    putStrLn $ "Day 9, Part 1: " ++ show (part1 parsed)
    putStrLn $ "Day 9, Part 2: " ++ show (part2 parsed)

data Move
    = U
    | D
    | R
    | L
    deriving (Show)

part1 :: [Move] -> Int
part1 moves =
    Set.size . Set.fromList $ tailPositions
  where
    tailPositions = scanl' (flip moveTail) (0, 0) headPositions
    headPositions = scanl' (flip moveHead) (0, 0) moves

part2 :: [Move] -> Int
part2 moves =
    Set.size . Set.fromList . (!! 9) $ tailsPositions
  where
    tailsPositions = iterate (scanl' (flip moveTail) (0, 0)) headPositions
    headPositions = scanl' (flip moveHead) (0, 0) moves

moveHead :: Move -> (Int, Int) -> (Int, Int)
moveHead U (x, y) =
    (x, y + 1)
moveHead D (x, y) =
    (x, y - 1)
moveHead R (x, y) =
    (x + 1, y)
moveHead L (x, y) =
    (x - 1, y)

moveTail :: (Int, Int) -> (Int, Int) -> (Int, Int)
moveTail (hx, hy) (tx, ty)
    | abs dx <= 1 && abs dy <= 1 =
        (tx, ty)
    | otherwise =
        (tx + signum dx, ty + signum dy)
  where
    dx = hx - tx
    dy = hy - ty

parseInput :: String -> [Move]
parseInput =
    concatMap parseMove . lines

parseMove :: String -> [Move]
parseMove (x : ' ' : xs) =
    case x of
        'U' -> replicate (read xs) U
        'D' -> replicate (read xs) D
        'R' -> replicate (read xs) R
        'L' -> replicate (read xs) L