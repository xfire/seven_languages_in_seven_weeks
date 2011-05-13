breakString :: Int -> String -> [String]
breakString n xs = map unwords $ (chunks n) $ words xs
    where chunks n = takeWhile (not . null) . map (take n) . iterate (drop n)

addLineNumbers :: [String] -> [String]
addLineNumbers = zipWith (\a b -> (show a) ++ ": " ++ b) [1..]

justifyLeft :: Int -> [String] -> [String]
justifyLeft n s = map f s
    where f s = (replicate len ' ') ++ s
          len = n - (length s)

justifyRight :: Int -> [String] -> [String]
justifyRight n s = map f s
    where f s = s ++ (replicate len ' ')
          len = n - (length s)

justify :: Int -> [String] -> [String]
justify n = map (fixlen . jtfy)
    where fixlen = fixToLong . fixToSmall 
          fixToSmall s = s ++ (replicate (n - (length s)) ' ')
          fixToLong s = drop ((length s) - n) s

          jtfy s = (spaces s) ++ s ++ (spaces s)
          spaces s = replicate (len s) ' '
          len s = round (((n' s) - (l' s)) / 2)
          n' s = fromIntegral n
          l' s = fromIntegral (length s)
