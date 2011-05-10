import Data.List

colors = ["Red", "Green", "Blue"]
states = ["Alabama", "Mississippi", "Georgia", "Tennessee", "Florida"]

-- return true if state a is neighbor of state b
neighbor :: String -> String -> Bool
neighbor a b = neighbor' a b || neighbor' b a
    where neighbor' "Mississippi" "Tennessee" = True
          neighbor' "Mississippi" "Alabama" = True
          neighbor' "Alabama" "Tennessee" = True
          neighbor' "Alabama" "Georgia" = True
          neighbor' "Alabama" "Florida" = True
          neighbor' "Georgia" "Florida" = True
          neighbor' "Georgia" "Tennessee" = True
          neighbor' _ _ = False

-- return all colors which are not occupied by an neighbor state
freeColors :: [(String, String)] -> String -> [String]
freeColors states state = colors \\ occupiedColors
    where neighbor' (s, _) = neighbor s state
          occupiedColors = map snd $ filter neighbor' states

mapColors :: [String] -> [(String, String)]
mapColors = foldl f []
    where f result state = (state, freeColor result state) : result
          freeColor r s = head $ freeColors r s

-- test in ghci:
--   *Main> mapColors states
