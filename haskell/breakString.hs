breakString :: Int -> String -> [String]
breakString n xs = map unwords $ (chunks n) $ words xs
    where chunks n = takeWhile (not . null) . map (take n) . iterate (drop n)

breakStringLN n xs = zipWith (\a b -> (show a) ++ ": " ++ b) [1..] (breakString n xs)
