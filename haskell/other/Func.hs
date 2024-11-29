module Func where

import Prelude hiding (flip)

comp :: (b -> c) -> (a -> b) -> a -> c
comp f g x = f (g x)

(◦) :: (b -> c) -> (a -> b) -> (a -> c)
(◦) = comp

flip :: (a -> b -> c) -> b -> a -> c
flip f x y = f y x

dcomp :: (a -> b) -> (b -> c) -> a -> c
dcomp = flip comp