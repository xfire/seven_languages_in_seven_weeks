reverse' :: [a] -> [a]
reverse' = foldl (flip (:)) []

reverse'' :: [a] -> [a]
reverse'' [] = []
reverse'' (x:xs) = (reverse xs) ++ [x]
