module Typeclasses where

class Add a where
    (+) :: a -> a -> a
    zero :: a

class Mult a where
    (*) :: a -> a -> a
    one :: a

class Mult a => Pow a where
    (^) :: a -> a -> a