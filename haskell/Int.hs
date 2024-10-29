module Int where

import Prelude hiding 
  ( Num(..), max, min, (^), quot, rem, gcd, lcm, 
   div, exp, succ, Int)
import Typeclasses
import Nat
import EvOd

data Int where
    Int :: (Nat, Nat) -> Int


inv :: Int -> Int
inv (Int (n, m))
    | n == O = Int (S O, m)
    | otherwise = Int (O, m)

iszero :: Int -> Bool
iszero (Int (_, O)) = True
iszero (Int (_, _)) = False

instance Eq Int where
    Int (n, o) == Int (m, p)
        | o == O && p == O = True
        | n == m && o == p = True
        | n >= S O && m >= S O && o == p = True
        | otherwise = False

instance Show Int where
    show (Int (_, O)) = show O
    show (Int (O, n)) = show n
    show (Int (S n, m)) = "-" ++ show m 

instance Additive Int where
    Int (s, n) + Int (r, m)
        | iszero (Int (r,m)) = Int (s, n)
        | s == r = Int (s, n + m)
        | n <= m = Int (r, abs n m)
        | otherwise = Int (s, abs n m)
    
    zero = Int (O, O)

instance Multiplicative Int where
    Int (s, n) * Int (r, m)
        | iszero (Int (r,m)) = zero
        | s == r = Int (O, n * m)
        | otherwise = Int (S O, n * m)

    one = Int (O, S O)

