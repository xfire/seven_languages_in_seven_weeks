data HashMap k v = HashMap k v (HashMap k v)
                 | EmptyMap
                 deriving (Show)

mapFromList :: [(k, v)] -> HashMap k v
mapFromList [] = EmptyMap
mapFromList (x:xs) = HashMap (fst x) (snd x) (mapFromList xs)

getValue :: (Eq k) => k -> HashMap k v -> Maybe v
getValue _ EmptyMap = Nothing
getValue k (HashMap k' v m)
    | k == k' = Just v
    | otherwise = getValue k m


type NestedHashMapL3 k v = HashMap k (HashMap k (HashMap k v))

nestedHashMapL3 :: NestedHashMapL3 String Int
nestedHashMapL3 = mapFromList [("foo", l1a), ("bar", l1b)]
    where l1a = mapFromList [("a", l1aa), ("b", EmptyMap), ("c", l1ac)]
          l1b = mapFromList [("a", l1ba)]
          l1aa = mapFromList [("1", 23)]
          l1ac = mapFromList [("2", 42)]
          l1ba = mapFromList [("3", 99)]

getNestedValueL3 :: (Eq a) => a -> a -> a -> NestedHashMapL3 a b -> Maybe b
getNestedValueL3 k k' k'' m = do
    m' <- getValue k m
    m'' <- getValue k' m'
    getValue k'' m''
