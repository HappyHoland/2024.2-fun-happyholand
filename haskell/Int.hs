module Int where

import Prelude hiding 
  ( Num(..), max, min, (^), quot, rem, gcd, lcm, 
   div, exp, succ, Int)
import Typeclasses
import Nat

data Int where
    Int :: (Bool, Nat) -> Int

inv :: Int -> Int
inv (Int (n, m))
    | not n = Int (True, m)
    | otherwise = Int (False, m)

iszero :: Int -> Bool
iszero (Int (_, O)) = True
iszero (Int (_, _)) = False

instance Eq Int where
    Int (n, o) == Int (m, p)
        | o == O && p == O = True
        | n == m && o == p = True
        | otherwise = False

instance Show Int where
    show (Int (_, O)) = show O
    show (Int (True, n)) = show n
    show (Int (False, m)) = "-" ++ show m 

instance Additive Int where
    Int (s, n) + Int (r, m)
        | s == r = Int (s, n + m)
        | n <= m = Int (r, abs n m)
        | otherwise = Int (s, abs n m)
    
    zero = Int (True, O)

instance Multiplicative Int where
    Int (s, n) * Int (s', m) = Int (s == s', n * m)

    one = Int (True, S O)

