module List where

import Prelude hiding 
    ( Num(..), max, min, (^), Bool(..), (==), (<=),
     quot, rem, gcd, lcm, div, even, List(..),
      length, sum, product, (++), repeat)
import Nat

data List a where
    Empty :: List a
    Cons :: a -> List a -> List a
    deriving (Eq, Show)

length :: List a -> Nat
length Empty = O
length (Cons x xs) = S (length xs)

sum :: List Nat -> Nat
sum Empty = O
sum (Cons x xs) = x + sum xs

index :: List a -> Nat -> a
index Empty n = error "index out of range"
index (Cons x xs) O = x
index (Cons x xs) (S n) = index xs n

product :: List Nat -> Nat
product Empty = S O
product (Cons x xs) = x * product xs

addNat :: Nat -> List Nat -> List Nat
addNat n Empty = Empty
addNat n (Cons x xs) = Cons (n + x) (addNat n xs)

mulNat :: Nat -> List Nat -> List Nat
mulNat n Empty = Empty
mulNat n (Cons x xs) = Cons (n * x) (mulNat n xs)

expNat :: Nat -> List Nat -> List Nat
expNat n Empty = Empty
expNat n (Cons x xs) = Cons (n ^ x) (expNat n xs)

powNat :: Nat -> List Nat -> List Nat
powNat n Empty = Empty
powNat n (Cons x xs) = Cons (x ^ n) (expNat n xs)

pwAdd :: List Nat -> List Nat -> List Nat
pwAdd _ Empty = Empty
pwAdd Empty _ = Empty
pwAdd (Cons x xs) (Cons y ys) = Cons (x + y) (pwAdd xs ys)

pwMul :: List Nat -> List Nat -> List Nat
pwMul _ Empty = Empty
pwMul Empty _ = Empty
pwMul (Cons x xs) (Cons y ys) = Cons (x * y) (pwMul xs ys)

pwExp :: List Nat -> List Nat -> List Nat
pwExp _ Empty = Empty
pwExp Empty _ = Empty
pwExp (Cons x xs) (Cons y ys) = Cons (x ^ y) (pwExp xs ys)

(++) :: List a -> List a -> List a
Empty ++ l = l
Cons x xs ++ l = Cons x (xs ++ l)

repeat :: Nat -> a -> List a
repeat O x = Empty
repeat (S n) x = Cons x (repeat n x)

stretch :: Nat -> List Nat -> List Nat
stretch n Empty = Empty
stretch n (Cons x xs) = repeat n x ++ stretch n xs

countdown :: Nat -> List Nat
countdown O = Cons O Empty
countdown (S n) = Cons (S n) (countdown n)

