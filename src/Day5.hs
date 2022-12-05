module Main where

import Data.Char (isDigit)
import Data.List (transpose)
import Data.Maybe (catMaybes)
import Text.Read (readMaybe)

main :: IO ()
main = do
    input <- readFile "inputs/day5.txt"
    let parsed = parseInput input
    putStrLn $ "Day 5, Part 1: " ++ show (part1 parsed)
    putStrLn $ "Day 5, Part 2: " ++ show (part2 parsed)

type State = ([[Char]], [(Int, Int, Int)])

part2 :: State -> [Char]
part2 (crs, []) = map head . filter (/= []) $ crs
part2 (crs, (n, f, t) : is) = part2 (go crs n f t, is)
  where
    go crs n i j =
        crs''
      where
        crs'' = xs' ++ [as ++ cs'] ++ ys'
        (xs', cs' : ys') = splitAt (j - 1) crs'
        crs' = xs ++ [bs] ++ ys
        (as, bs) = splitAt n cs
        (xs, cs : ys) = splitAt (i - 1) crs

part1 :: State -> [Char]
part1 (crs, []) = map head . filter (/= []) $ crs
part1 (crs, (n, f, t) : is)
    | n > 1 = part1 (go crs f t, (n - 1, f, t) : is)
    | n == 1 = part1 (go crs f t, is)
  where
    go crs i j =
        crs''
      where
        crs'' = xs' ++ [c : cs'] ++ ys'
        (xs', cs' : ys') = splitAt (j - 1) crs'
        crs' = xs ++ [cs] ++ ys
        (xs, (c : cs) : ys) = splitAt (i - 1) crs

parseInput :: String -> State
parseInput =
    ( \(crs, _, is) ->
        ( map catMaybes
            . transpose
            . map parseCrateLine
            $ crs
        , map parseInstructionLine is
        )
    )
        . splitInput
        . lines

parseInstructionLine :: String -> (Int, Int, Int)
parseInstructionLine =
    (\[a, b, c] -> (a, b, c)) . go . words
  where
    go [] = []
    go (w : ws) =
        case readMaybe w :: Maybe Int of
            Just i -> i : go ws
            Nothing -> go ws

parseCrateLine :: String -> [Maybe Char]
parseCrateLine [] = []
parseCrateLine s = parseCrate s : parseCrateLine (drop 4 s)

parseCrate :: [Char] -> Maybe Char
parseCrate ('[' : y : ']' : xs) = Just y
parseCrate (_ : _ : _ : xs) = Nothing

splitInput :: [String] -> ([String], String, [String])
splitInput [] = ([], [], [])
splitInput ("" : xs) = ([], [], xs)
splitInput (l@(_ : c : _) : xs)
    | isDigit c = (crs, l, is)
    | otherwise = (l : crs, ns, is)
  where
    (crs, ns, is) = splitInput xs
