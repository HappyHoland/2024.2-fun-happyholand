module NatRel where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div)
import Bool
import Nat

(==) :: Nat -> Nat -> Bool
S n == S m = n == m
O == O = True
_ == _ = False

leq :: Nat -> Nat -> Bool
O `leq` n = True
n `leq` O = False
S n `leq` S m = n `leq` m