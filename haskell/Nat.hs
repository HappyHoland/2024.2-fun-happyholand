module Nat where

import Prelude hiding ( Num(..) )

data Nat where
    O :: Nat
    S :: Nat -> Nat
  deriving (Eq, Show)

(+) :: Nat -> Nat -> Nat
n + O = n
n + S m = S (n + m)

(*) :: Nat -> Nat -> Nat
n * O = O
n * S m = n + (n * m)

(°) :: Nat -> Nat -> Nat
n ° O = S O
n ° (S m) = n * (n ° m)

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

leq :: Nat -> Nat -> Bool
leq O n = True
leq (S n) O = False
leq (S n) (S m) = leq n m


-- abbrevs (syntactic sugar)
o, so, sso, ssso :: Nat
o    = O
so   = S o
sso  = S so
ssso = S sso

