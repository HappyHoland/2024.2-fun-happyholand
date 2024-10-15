module EvOd where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div, even, odd)
import Bool
import Nat
import Comp

even :: Nat -> Bool
even O = True
even (S n) = bnot (even n)

odd :: Nat -> Bool
odd = bnot ° even

