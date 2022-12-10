module Main where

import Data.Bifunctor (Bifunctor (bimap))

main :: IO ()
main = do
    input <- readFile "inputs/day2.txt"
    let numbers = lines input
    putStrLn $ "Day 02, Part 1: " ++ show (part1 numbers)
    putStrLn $ "Day 02, Part 2: " ++ show (part2 numbers)

part1 :: [String] -> Int
part1 ns =
    sum scores
  where
    scores = map (uncurry score) conv
    score opponent me = shapeScore me + outcome opponent me
    conv = map (bimap charToHand charToHand) spl
    spl = map (\l -> (head l, l !! 2)) ns

part2 :: [String] -> Int
part2 ns =
    sum scores
  where
    scores = map (uncurry score) conv
    score opponent instruction =
        shapeScore decision + instructionToScore instruction
      where
        decision = decide opponent instruction
    conv = map (bimap charToHand charToInstruction) spl
    spl = map (\l -> (head l, l !! 2)) ns

data Hand
    = Rock
    | Paper
    | Scissors
    deriving (Show, Eq)

charToHand :: Char -> Hand
charToHand 'A' = Rock
charToHand 'B' = Paper
charToHand 'C' = Scissors
charToHand 'X' = Rock
charToHand 'Y' = Paper
charToHand 'Z' = Scissors

draw :: Hand -> Hand
draw h = h

win :: Hand -> Hand
win Rock = Paper
win Paper = Scissors
win Scissors = Rock

lose :: Hand -> Hand
lose Rock = Scissors
lose Paper = Rock
lose Scissors = Paper

beats :: Hand -> Hand -> Bool
Rock `beats` Scissors = True
Paper `beats` Rock = True
Scissors `beats` Paper = True
_ `beats` _ = False

outcome :: Hand -> Hand -> Int
outcome opponent me
    | opponent `beats` me = 0
    | me `beats` opponent = 6
    | otherwise = 3

shapeScore :: Hand -> Int
shapeScore Rock = 1
shapeScore Paper = 2
shapeScore Scissors = 3

data Instruction
    = Lose
    | Draw
    | Win
    deriving (Show, Eq)

decide :: Hand -> Instruction -> Hand
decide opponent Lose = lose opponent
decide opponent Draw = draw opponent
decide opponent Win = win opponent

charToInstruction :: Char -> Instruction
charToInstruction 'X' = Lose
charToInstruction 'Y' = Draw
charToInstruction 'Z' = Win

instructionToScore :: Instruction -> Int
instructionToScore Lose = 0
instructionToScore Draw = 3
instructionToScore Win = 6