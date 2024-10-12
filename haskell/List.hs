module List where

import Prelude hiding 
    ( Num(..), max, min, (^), Bool(..), (==), (<=), quot, rem, gcd, lcm, div, even, List(..), length, sum)
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

