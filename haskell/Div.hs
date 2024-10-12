module Div where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div)
import Bool
import Nat
import NatRel

quot :: Nat -> Nat -> Nat
quot _ O = error "dividing by zero"
quot n m = ifThenElse (m <= n) (S (quot (monus n m) m)) O

rem :: Nat -> Nat -> Nat
rem _ O = error "dividing by zero"
rem n m = ifThenElse (m <= n) (rem (monus n m) m) n

div :: (Nat, Nat) -> (Nat, Nat)
div (n, O) = error "dividing by zero"
div (n, m) = (quot n m, rem n m)

gcd :: Nat -> Nat -> Nat
gcd O O = error "undefined"
gcd (S n) (S m) = gcd (min (S n) (S m)) (rem (max (S n) (S m)) (min (S n) (S m)))
gcd n m = max n m

lcm :: Nat -> Nat -> Nat
lcm (S n) (S m) = quot (S n * S m) (gcd (S n) (S m))
lcm _ _ = O