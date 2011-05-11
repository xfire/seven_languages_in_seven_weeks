primes :: [Int]
primes = sieve [2..]
    where sieve (p:xs) = p : [x | x <- xs, x `rem` p /= 0]
