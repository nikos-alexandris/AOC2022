module Main where

import Data.List (unfoldr)

main :: IO ()
main = do
    input <- readFile "inputs/day10.txt"
    let parsed = parseInput input
    putStrLn $ "Day 10, Part 1: " ++ show (part1 parsed)
    putStrLn "Day 10, Part 2: "
    mapM_ putStrLn $ part2 parsed

data Instr
    = Noop
    | Addx Int
    deriving (Show)

part1 :: [Instr] -> Int
part1 =
    sum . go 20 . flip run (1, 1)
  where
    go _ [] = []
    go n ((c, x) : ss) =
        if c == n
            then x * n : go (n + 40) ss
            else go n ss

part2 :: [Instr] -> [[Char]]
part2 is =
    zipWith (curry (\((r, f), c) -> f r c)) (zip [0 ..] (repeat go)) chunks
  where
    go :: Int -> [(Int, Int)] -> [Char]
    go _ [] = []
    go r ((c, x) : ss) =
        ( if c == x + 40 * r || c == x + 40 * r + 1 || c == x + 40 * r + 2
            then '#'
            else '.'
        )
            : go r ss
    chunks = chunksOf 40 states
    states = run is (1, 1)

run :: [Instr] -> (Int, Int) -> [(Int, Int)]
run [] _ =
    []
run (Noop : is) s@(c, x) =
    s : run is (c + 1, x)
run (Addx n : is) s@(c, x) =
    s : (c + 1, x) : run is (c + 2, x + n)

parseInput :: String -> [Instr]
parseInput =
    map parseLine . lines

parseLine :: String -> Instr
parseLine line =
    case words line of
        ["addx", x] -> Addx (read x)
        ["noop"] -> Noop

chunksOf :: Int -> [a] -> [[a]]
chunksOf n =
    takeWhile (not . null)
        . unfoldr (Just . splitAt n)