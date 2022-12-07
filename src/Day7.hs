module Main where

import Data.List (isPrefixOf)

main :: IO ()
main = do
    input <- readFile "inputs/day7.txt"
    let parsed = map parseLine (lines input)
    let fs = snd $ buildFs (drop 1 parsed) (Directory "/" [])
    let dirSizes = getDirSizes fs
    putStrLn $ "Day 7, Part 1: " ++ show (part1 dirSizes)
    putStrLn $ "Day 7, Part 2: " ++ show (part2 dirSizes)

data File
    = File String Int
    | Directory String [File]
    deriving (Show)

data Line
    = CD String
    | LS
    | DIR String
    | FILE Int String
    deriving (Show)

part1 :: [Int] -> Int
part1 = sum . filter (<= 100_000)

part2 :: [Int] -> Int
part2 (r : ds) = minimum . filter (>= spaceToFree) $ ds
  where
    spaceToFree = 30_000_000 - currFreeSpace
    currFreeSpace = 70_000_000 - r

getDirSizes :: File -> [Int]
getDirSizes (File _ _) = []
getDirSizes d@(Directory _ files) =
    getFileSize d : concatMap getDirSizes files

getFileSize :: File -> Int
getFileSize (File _ fsize) = fsize
getFileSize (Directory _ files) = sum . map getFileSize $ files

buildFs :: [Line] -> File -> ([Line], File)
buildFs [] fs = ([], fs)
buildFs (LS : lns) d@(Directory name files) =
    buildFs lns d
buildFs (DIR dir : lns) d@(Directory name files) =
    buildFs lns d
buildFs ((FILE fname fsize) : lns) d@(Directory name files) =
    buildFs lns (Directory name (File fsize fname : files))
buildFs (CD dir : lns) d@(Directory name files)
    | dir == ".." = (lns, d)
    | otherwise = buildFs lns' (Directory name (fs : files))
  where
    (lns', fs) = buildFs lns (Directory dir [])

parseLine :: String -> Line
parseLine s
    | "$ cd " `isPrefixOf` s = CD (drop 5 s)
    | "$ ls" == s = LS
    | "dir " `isPrefixOf` s = DIR (drop 4 s)
    | otherwise = FILE (read size) name
  where
    [size, name] = words s
