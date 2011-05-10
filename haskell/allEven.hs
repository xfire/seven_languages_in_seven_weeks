allEven :: [Int] -> Bool
allEven = all even

allEven' :: [Int] -> Bool
allEven' = foldl f True
    where f acc v = if (not . even $ v) then False else acc

allEven'' :: [Int] -> Bool
allEven'' [] = True
allEven'' (x:xs) = if (not . even $ x) then False else allEven'' xs

allEven''' :: [Int] -> Bool
allEven''' [] = True
allEven''' (x:xs)
    | even x = allEven''' xs
    | otherwise = False

allEven'''' :: [Int] -> Bool
allEven'''' = null . filter (not . even)
