module Comp where

comp :: (a -> b) -> (b -> c) -> a -> c
comp f g x = g (f x)

(°) :: (b -> c) -> (a -> b) -> (a -> c)
f ° g = comp g f