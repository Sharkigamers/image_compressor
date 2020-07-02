--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Display
--

module Display (
    displayResult,
    displayCluster
) where

-- cluster :: [((Int, Int), (Int, Int, Int))] -> Int -> (Int, Int, Int) -> (Int, Int, Int)
-- cluster [] len result = (fromIntegral(round(fromIntegral(let (x,_,_) = result in x) / fromIntegral(len))), fromIntegral(round(fromIntegral(let (_,x,_) = result in x) / fromIntegral(len))), fromIntegral(round(fromIntegral(let (_,_,x) = result in x) / fromIntegral(len))))
-- cluster (list:lists) len result = cluster lists len ((let (x,_,_) = (snd list) in x) + (let (x,_,_) = result in x), (let (_,x,_) = (snd list) in x) + (let (_,x,_) = result in x), (let (_,_,x) = (snd list) in x) + (let (_,_,x) = result in x))

-- clusterContent :: [((Int, Int), (Int, Int, Int))] -> IO ()
-- clusterContent [] = return ()
-- clusterContent (list:lists) = do
--     putStr("(" ++ show (let (x,_) = fst list in x) ++ "," ++ show (let (_,x) = fst list in x) ++ ") ")
--     print (snd list)
--     clusterContent lists

displayCluster :: (Int, Int, Int) -> [((Int, Int), (Int, Int, Int))] -> [((Int, Int, Int), Int)] -> IO()
displayCluster _ _ [] = return ()
displayCluster centroid pixel (cluster:clusters) = do
    if (centroid == (fst cluster)) then do
        putStr("(" ++ show (let (x,_) = fst (pixel!!(snd cluster)) in x) ++ "," ++ show (let (_,x) = fst (pixel!!(snd cluster)) in x) ++ ") ")
        print(snd (pixel!!(snd cluster)))
        displayCluster centroid pixel clusters
    else displayCluster centroid pixel clusters

displayResult :: [(Int, Int, Int)] -> [((Int, Int), (Int, Int, Int))] -> [((Int, Int, Int), Int)] -> IO()
displayResult [] _ _ = return ()
displayResult (centroid:centroids) pixels cluster = do
    putStrLn ("--")
    print(centroid)
    putStrLn ("-")
    displayCluster centroid pixels cluster
    displayResult centroids pixels cluster
