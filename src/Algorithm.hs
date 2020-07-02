--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Algorithm
--

module Algorithm (
    checkBestCentroid,
    fillClusters,
    calculateNewCentroids
) where

import Lib

type Cluster = [((Int, Int, Int), Int)]
type Centroid = (Int, Int, Int)
type ColorPixel = (Int, Int, Int)
type Pixel = ((Int, Int), ColorPixel)

checkBestCentroid :: [Centroid] -> Pixel -> Int -> Float -> Int -> Int
checkBestCentroid [] _ _ _ best = best
checkBestCentroid (centroid:centroids) pixels i dist best = do
    let range = euclidianRange centroid (snd pixels)
    if (dist == -1) then checkBestCentroid centroids pixels (i + 1) range i
    else if (range < dist) then checkBestCentroid centroids pixels (i + 1) range i
    else checkBestCentroid centroids pixels (i + 1) dist best

fillClusters :: [Centroid] -> [Pixel] -> Cluster -> Int -> Cluster
fillClusters _ [] cluster _ = cluster
fillClusters centroids (pixel:pixels) cluster i = do
    let wichBestCentroid = checkBestCentroid centroids pixel 0 (-1) (-1)
    fillClusters centroids pixels (cluster ++ [(centroids!!wichBestCentroid, i)]) (i + 1)

sumCentroids :: Centroid -> ColorPixel -> Centroid
sumCentroids centroid pixel = ((let (x,_,_) = centroid in x) + (let (x,_,_) = pixel in x), (let (_,x,_) = centroid in x) + (let (_,x,_) = pixel in x), (let (_,_,x) = centroid in x) + (let (_,_,x) = pixel in x))

gravityPoint :: [Pixel] -> Centroid -> Centroid -> Cluster -> Int -> Centroid
gravityPoint _ _ newCentroids [] 0 = (fromIntegral(round(fromIntegral(let (x,_,_) = newCentroids in x) / fromIntegral(1))), fromIntegral(round(fromIntegral(let (_,x,_) = newCentroids in x) / fromIntegral(1))), fromIntegral(round(fromIntegral(let (_,_,x) = newCentroids in x) / fromIntegral(1))))
gravityPoint _ _ newCentroids [] i = (fromIntegral(round(fromIntegral(let (x,_,_) = newCentroids in x) / fromIntegral(i))), fromIntegral(round(fromIntegral(let (_,x,_) = newCentroids in x) / fromIntegral(i))), fromIntegral(round(fromIntegral(let (_,_,x) = newCentroids in x) / fromIntegral(i))))
gravityPoint pixels centroid newCentroids (cluster:clusters) i
    | (fst cluster) == centroid = gravityPoint pixels centroid (sumCentroids newCentroids (snd(pixels!!(snd cluster)))) clusters (i + 1)
    | otherwise = gravityPoint pixels centroid newCentroids clusters i


calculateNewCentroids :: [Pixel] -> [Centroid] -> [Centroid] -> Cluster -> [Centroid]
calculateNewCentroids _ [] newCentroids _ = newCentroids
calculateNewCentroids pixel (centroid:centroids) newCentroids cluster = calculateNewCentroids pixel centroids (newCentroids ++ [(gravityPoint pixel centroid (0,0,0) cluster 0)]) cluster
