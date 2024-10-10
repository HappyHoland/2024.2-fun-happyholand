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
n ° O = so
n ° (S m) = n * (n ° m)

double :: Nat -> Nat
double = (*) sso

pred :: Nat -> Nat
pred O = O
pred (S n) = n



-- abbrevs (syntactic sugar)
o, so, sso, ssso :: Nat
o    = O
so   = S o
sso  = S so
ssso = S sso

