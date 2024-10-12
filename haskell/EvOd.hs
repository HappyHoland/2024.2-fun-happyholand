module EvOd where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div, even)
import Bool
import Nat

even :: Nat -> Bool
even O = True
even (S n) = bnot (even n)

odd :: Nat -> Bool
odd n = bnot (even n)