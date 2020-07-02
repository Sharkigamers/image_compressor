--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Main
--

module Main where

import System.Environment
import System.Exit
import System.Random

import Lib
import Utils
import Error
import Loop
import Algorithm
import Display

exitFail = exitWith (ExitFailure 84)

main :: IO ()
main = do
    args <- getArgs
    if (errorGest (args) == False) then exitFail
    else do
        if (length (args) == 1 && (args !! 0) == "-h") then help
        else do
            content <- readFile $ (args !! 2)
            seed <- newStdGen
            let list = createList (lines content)
            let centroids = randomCentroid list (read (args!!0)) seed []
            let result = loop centroids list (read (args!!1) :: Float)
            displayResult (fst result) list (snd result)

