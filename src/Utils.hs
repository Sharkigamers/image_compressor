--
-- EPITECH PROJECT, 2020
-- ImageCompressor
-- File description:
-- Utils
--

module Utils(
    help
) where

help :: IO ()
help = do
    putStrLn ("USAGE: ./imageCompressor n e IN\n")
    putStrLn ("\tn\tnumber of colors in the final image")
    putStrLn ("\te\tconvergence limit")
    putStrLn ("\tIN\tpath to the file containing the colors of the pixels")
