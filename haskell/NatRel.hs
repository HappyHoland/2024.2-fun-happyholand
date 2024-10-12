module NatRel where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div)
import Bool
import Nat

(==) :: Nat -> Nat -> Bool
S n == S m = n == m
O == O = True
_ == _ = False

(<=) :: Nat -> Nat -> Bool
O <= n = True
n <= O = False
S n <= S m = n <= m