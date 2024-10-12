module Bool where

import Prelude hiding (Bool(..))

data Bool where
    False :: Bool
    True :: Bool
  deriving (Eq, Show)

band :: Bool -> Bool -> Bool
True `band` True = True
_ `band` _ = False

bor :: Bool -> Bool -> Bool
False `bor` False = False
_ `bor` _ = True

bnot :: Bool -> Bool
bnot True = False
bnot False = True

ifThenElse :: Bool -> a -> a -> a
ifThenElse True x _ = x
ifThenElse False _ x = x

