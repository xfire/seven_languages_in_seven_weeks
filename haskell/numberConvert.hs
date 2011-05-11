{- convert "$2,345,678.99" -}
convert :: String -> Double
convert = read . cleanUp
    where cleanUp = remove ','
                  . trimLeft '$'
                  . trimLeft ' '
          trimLeft c = dropWhile (== c)
          remove c = filter (/= c)
