module Nat where

import Prelude hiding ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem)
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

(==) :: Nat -> Nat -> Bool
S n == S m = n == m
O == O = True
_ == _ = False

(<=) :: Nat -> Nat -> Bool
O <= n = True
n <= O = False
S n <= S m = n <= m

monus :: Nat -> Nat -> Nat
monus (S n) (S m) = monus n m
monus n _ = n

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
gcd (S n) (S m) = 
gcd n O = n
gcd O n = n 


-- abbrevs (syntactic sugar)
o, so, sso, ssso :: Nat
o    = O
so   = S o
sso  = S so
ssso = S sso

