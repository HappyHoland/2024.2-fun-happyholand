module List where

import Prelude hiding 
    ( Num(..), max, min, (^), Bool(..), (==), (<=),
     quot, rem, gcd, lcm, div, even, List(..),
      length, sum, product, concat, repeat, map, filter, reverse)
import Nat
import Typeclasses
import Bool (Bool, ifThenElse)
import Data.Sequence (Seq(Empty))

data List a where
    Nil :: List a
    (:>) :: a -> List a -> List a
    deriving (Eq, Show)

length :: List a -> Nat
length Nil = O
length (x :> xs) = S (length xs)

index :: List a -> Nat -> a
index Nil n = error "index out of range"
index (x :> xs) O = x
index (x :> xs) (S n) = index xs n

concat :: List a -> List a -> List a
concat Nil l = l
concat (x :> xs) l = x :> concat xs l

repeat :: Nat -> a -> List a
repeat O x = Nil
repeat (S n) x = x :> repeat n x

stretch :: Nat -> List a -> List a
stretch _ Nil = Nil
stretch n (x :> xs) = concat (repeat n x) (stretch n xs)

sum :: Additive a => List a -> a
sum Nil = zero
sum (x :> xs) = x + sum xs

product :: Multiplicative a => List a -> a
product Nil = one
product (x :> xs) = x * product xs

map :: (a -> b) -> List a -> List b
map f Nil = Nil
map f (x :> xs) = f x :> map f xs

pwOp :: (a -> b -> c) -> List a -> List b -> List c
pwOp op _ Nil = Nil
pwOp op Nil _ = Nil
pwOp op (x :> xs) (y :> ys) = op x y :> pwOp op xs ys

filter :: (a -> Bool) -> List a -> List a
filter p Nil = Nil
filter p (x :> xs) = ifThenElse (p x) (x :> filter p xs) (filter p xs)

reverse :: List a -> List a
reverse Nil = Nil
reverse (x :> xs) = concat (reverse xs) (x :> Nil) 