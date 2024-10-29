module Nat where

import Prelude hiding 
  ( Num(..), max, min, (^), quot, rem, gcd, lcm, 
   div, exp, succ)
import Typeclasses

data Nat where
    O :: Nat
    S :: Nat -> Nat
    deriving (Eq)

instance Show Nat where
  show O = "o"
  show (S n) = "s" ++ show n 

instance Ord Nat where
  O <= _ = True
  _ <= O = False
  S n <= S m = n <= m 

instance Additive Nat where
  (+) = plus
  zero = O

plus :: Nat -> Nat -> Nat
n `plus` O = n
n `plus` S m = S (n `plus` m)

instance Multiplicative Nat where
  (*) = times
  one = S O

times :: Nat -> Nat -> Nat
n `times` O = O
n `times` S m = n + (n `times` m)

instance Exponentiative Nat where
  (^) = exp

exp :: Nat -> Nat -> Nat
n `exp` O = S O
n `exp` (S m) = n * (n `exp` m)

double :: Nat -> Nat
double = uncurry (+) . diag

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

succ :: Nat -> Nat
succ = S

diag :: Nat -> (Nat, Nat)
diag n = (n,n)

square :: Nat -> Nat
square = uncurry (*) . diag

abs :: Nat -> Nat -> Nat
O `abs` n = n
n `abs` O = n
S n `abs` S m = n `abs` m

-- abbrevs (syntactic sugar)
o, so, sso, ssso :: Nat
o    = O
so   = S o
sso  = S so
ssso = S sso
sssso= S ssso

