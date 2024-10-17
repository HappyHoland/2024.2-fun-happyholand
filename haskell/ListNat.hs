module ListNat where

import Prelude hiding (Num(..), List(..), sum, product, (^), exp)
import List
import Nat
import Typeclasses

addNat :: Nat -> List Nat -> List Nat
addNat = scalarOpL plus

mulNat :: Nat -> List Nat -> List Nat
mulNat = scalarOpL times

expNat :: Nat -> List Nat -> List Nat
expNat = scalarOpL exp

powNat :: Nat -> List Nat -> List Nat
powNat = scalarOpR exp

pwAdd :: List Nat -> List Nat -> List Nat
pwAdd = pwOp plus

pwMul :: List Nat -> List Nat -> List Nat
pwMul = pwOp times

pwExp :: List Nat -> List Nat -> List Nat
pwExp = pwOp exp

countdown :: Nat -> List Nat
countdown O = Cons O Empty
countdown (S n) = Cons (S n) (countdown n)