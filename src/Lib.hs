--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Lib
--

module Lib (
    euclidianRange,
    createList,
    spliter,
    getTuple,
    compute,
    randomCentroid
) where

import System.Random

deleteN :: [((Int, Int), (Int, Int, Int))] -> Int -> [((Int, Int), (Int, Int, Int))]
deleteN list n = mappend (take n list) (drop (n + 1) list)

euclidianRange :: (Int, Int, Int) -> (Int, Int, Int) -> Float
euclidianRange (x1, y1, z1) (x2, y2, z2) = sqrt ((fromIntegral (x1 - x2) ^ 2) + (fromIntegral (y1 - y2) ^ 2) + (fromIntegral (z1 - z2) ^ 2))

spliter :: String -> [String]
spliter [] = [""]
spliter (c:cs)
    | c == ',' = "" : rest
    | c == '(' = "" : rest
    | c == ')' = "" : rest
    | otherwise = (c : head rest) : tail rest
    where rest = spliter cs

getTuple :: String -> ((Int, Int), (Int, Int, Int))
getTuple s = ((read (t !! 1), read (t !! 2)), (read (t !! 4), read (t !! 5), read (t !! 6)))
    where t = spliter s

createList :: [String] -> [((Int, Int), (Int, Int, Int))]
createList [] = []
createList (x : xs) = (getTuple x) : createList xs

compute :: [((Int, Int), (Int, Int, Int))] -> IO ()
compute list = return ()

printList :: [((Int, Int), (Int, Int, Int))] -> Int -> IO ()
printList list nb = print (list, nb)

randomCentroid :: [((Int, Int), (Int, Int, Int))] -> Int -> StdGen ->[(Int, Int, Int)] -> [(Int, Int, Int)]
randomCentroid _ 0 _ returnList = returnList
randomCentroid list nTimes seed returnList = do
    let (randomNumber, gen) = randomR (0, (length list) - 1 :: Int) seed
    randomCentroid (deleteN list randomNumber) (nTimes - 1) seed (returnList ++ [snd (list !! randomNumber)])