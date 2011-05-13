data Pos t = Pos t deriving (Show)

{- ---------------------------------------------- -}
stagger (Pos d) = Pos (d + 2)
crawl (Pos d) = Pos (d + 1)

rtn x = x
x >>== f = f x

treasureMap :: (Num a) => a -> Pos a
treasureMap p = (Pos p) >>==
                stagger >>==
                stagger >>==
                crawl >>==
                rtn


{- ---------------------------------------------- -}

instance Monad Pos where
    return x = Pos x
    (Pos x) >>= f = f x

stagger' :: (Num a) => a -> Pos a
stagger' d = return (d + 2)

crawl' :: (Num a) => a -> Pos a
crawl' d = return (d + 1)

treasureMap' :: (Num a) => a -> Pos a
treasureMap' p = (Pos p) >>= stagger' >>= stagger' >>= crawl'

treasureMap'' :: (Num a) => a -> Pos a
treasureMap'' pos = do
    p <- Pos pos
    p' <- stagger' p
    p'' <- stagger' p'
    crawl' p''
