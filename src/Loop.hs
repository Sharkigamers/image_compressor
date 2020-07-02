--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Loop
--

module Loop (
    loop,
    isValidCentroid
) where

import Lib
import Algorithm

isValidCentroid :: [(Int, Int, Int)] -> [(Int, Int, Int)] -> Float -> Bool
isValidCentroid [] _ _ = True
isValidCentroid _ [] _ = True
isValidCentroid (old:olds) (new:news) limit
    | euclidianRange old new < limit = False
    | otherwise = isValidCentroid olds news limit

loop :: [(Int, Int, Int)] -> [((Int, Int), (Int, Int, Int))] -> Float -> ([(Int, Int, Int)], [((Int, Int, Int), Int)])
loop centroids pixels limit = do
    let cluster = fillClusters centroids pixels [] 0
    let newCentroids = calculateNewCentroids pixels centroids [] cluster
    if ((isValidCentroid centroids newCentroids limit) == False) then (newCentroids, (fillClusters newCentroids pixels [] 0))
    else loop newCentroids pixels limit
