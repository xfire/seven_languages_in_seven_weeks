qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = (qsort lower) ++ [x] ++ (qsort upper)
    where lower = filter (< x) xs
          upper = filter (>= x) xs
