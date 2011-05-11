everyN :: Int -> Int -> [Int]
everyN n x = [x, (x + n)..]

everyThird = everyN 3
everyFifth = everyN 5

everyEight :: Int -> Int -> [Int]
everyEight x y = zipWith (+) (everyThird x) (everyFifth y)
