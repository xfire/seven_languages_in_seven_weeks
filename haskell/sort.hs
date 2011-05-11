import Data.List

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = (qsort lower) ++ [x] ++ (qsort upper)
    where lower = filter (< x) xs
          upper = filter (>= x) xs

-- qsortBy (\a b -> if (a < b) then LT else GT) [44,2,12,51,9,31,25]
qsortBy :: (a -> a -> Ordering) -> [a] -> [a]
qsortBy _ [] = []
qsortBy f (x:xs) = (qsortBy f lower) ++ [x] ++ (qsortBy f upper)
    where lower = filter lt xs
          upper = filter gt xs
          lt a = (f a x) == LT
          gt a = (f a x) == GT
