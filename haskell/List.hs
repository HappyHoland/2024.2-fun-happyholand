module List where

import Prelude hiding 
    ( Num(..), max, min, (^), Bool(..), (==), (<=),
     quot, rem, gcd, lcm, div, even, List(..),
      length, sum, product, concat, repeat)
import Nat
import Typeclasses

data List a where
    Empty :: List a
    Cons :: a -> List a -> List a
    deriving (Eq, Show)

length :: List a -> Nat
length Empty = O
length (Cons x xs) = S (length xs)

index :: List a -> Nat -> a
index Empty n = error "index out of range"
index (Cons x xs) O = x
index (Cons x xs) (S n) = index xs n

concat :: List a -> List a -> List a
concat Empty l = l
concat (Cons x xs) l = Cons x (concat xs l)

repeat :: Nat -> a -> List a
repeat O x = Empty
repeat (S n) x = Cons x (repeat n x)

stretch :: Nat -> List a -> List a
stretch _ Empty = Empty
stretch n (Cons x xs) = concat (repeat n x) (stretch n xs)

sum :: Add a => List a -> a
sum Empty = zero
sum (Cons x xs) = x + sum xs

product :: Mult a => List a -> a
product Empty = one
product (Cons x xs) = x * product xs

scalarOpL :: (a -> a -> a) -> a -> List a -> List a
scalarOpL op x Empty = Empty
scalarOpL op x (Cons y ys) = Cons (op x y) (scalarOpL op x ys) 

scalarOpR :: (a -> a -> a) -> a -> List a -> List a
scalarOpR op x Empty = Empty
scalarOpR op x (Cons y ys) = Cons (op y x) (scalarOpR op x ys) 

pwOp :: (a -> a -> a) -> List a -> List a -> List a
pwOp op _ Empty = Empty
pwOp op Empty _ = Empty
pwOp op (Cons x xs) (Cons y ys) = Cons (op x y) (pwOp op xs ys)



