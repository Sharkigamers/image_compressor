--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Error
--

module Error(
    errorGest
) where

import Data.Maybe
import Text.Read

checkInteger :: String -> Maybe Int
checkInteger element = readMaybe element :: Maybe Int

checkFloat :: String -> Maybe Float
checkFloat element = readMaybe element :: Maybe Float

errorGest :: [String] -> Bool
errorGest args
    | length (args) /= 3 = False
    | checkInteger (args !! 0) == Nothing = False
    | checkFloat (args !! 1) == Nothing = False
    | otherwise = True