module ExFunctor where

import Prelude hiding ( fmap , (<$) )
import Distribution.Simple.Utils (xargs)

class Funktor f where
  fmap :: (a -> b) -> f a -> f b

  (<$) :: b        -> f a -> f b
  (<$) = fmap . const

newtype Flip f a b = Flip (f b a)

instance Funktor [] where
    fmap = map

instance Funktor Maybe where
    fmap f Nothing = Nothing
    fmap f (Just x) = Just (f x)

-- what about Either?

instance Funktor (Either a) where
    fmap f (Left x) = Left x
    fmap f (Right x) = Right (f x) 

instance Funktor (Flip Either a) where
    fmap f (Flip (Left x)) = Flip (Left (f x))
    fmap f (Flip (Right x)) = Flip (Right x)

-- what about pairs?

data Pair a b where
  Pair :: a -> b -> Pair a b 

instance Funktor (Pair a) where
    fmap f (Pair a b) = Pair a (f b) 

instance Funktor (Flip Pair a) where
    fmap f (Flip (Pair b a)) = Flip (Pair (f b) a)

-- what about functions?

instance Funktor ((->) a) where 
    fmap f g = f . g

-- what about Trees?



-- ...define Functor instances of as many * -> * things as you can think of!

