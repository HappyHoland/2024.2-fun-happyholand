module Typeclasses where

class Additive a where
    (+) :: a -> a -> a
    zero :: a

class Multiplicative a where
    (*) :: a -> a -> a
    one :: a

class Multiplicative a => Exponentiative a where
    (^) :: a -> a -> a