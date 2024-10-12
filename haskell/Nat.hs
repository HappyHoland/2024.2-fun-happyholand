module Nat where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div)
import Bool

data Nat where
    O :: Nat
    S :: Nat -> Nat
  deriving (Show)

(+) :: Nat -> Nat -> Nat
n + O = n
n + S m = S (n + m)

(*) :: Nat -> Nat -> Nat
n * O = O
n * S m = n + (n * m)

(^) :: Nat -> Nat -> Nat
n ^ O = S O
n ^ (S m) = n * (n ^ m)

double :: Nat -> Nat
double = (*) sso

pred :: Nat -> Nat
pred O = O
pred (S n) = n

fact :: Nat -> Nat
fact O = S O
fact (S n) = S n * fact n 

fib :: Nat -> Nat
fib (S (S n)) = fib (S n) + fib n
fib n = n

min :: Nat -> Nat -> Nat
min O n = O
min n O = O
min (S n) (S m) = S (min n m)

max :: Nat -> Nat -> Nat
max O n = n
max n O = n
max (S n) (S m) = S (max n m)

monus :: Nat -> Nat -> Nat
monus (S n) (S m) = monus n m
monus n _ = n

-- abbrevs (syntactic sugar)
o, so, sso, ssso :: Nat
o    = O
so   = S o
sso  = S so
ssso = S sso

