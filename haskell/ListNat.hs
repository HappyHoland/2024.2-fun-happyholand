module ListNat where

import Prelude hiding (Num(..), List(..), sum, product, (^), exp, map)
import List
import Nat
import Typeclasses

addNat :: Nat -> List Nat -> List Nat
addNat n = map (+n)

mulNat :: Nat -> List Nat -> List Nat
mulNat n = map (*n)

expNat :: Nat -> List Nat -> List Nat
expNat n = map (n^) 

powNat :: Nat -> List Nat -> List Nat
powNat n = map (^n)

pwAdd :: List Nat -> List Nat -> List Nat
pwAdd = pwOp plus

pwMul :: List Nat -> List Nat -> List Nat
pwMul = pwOp times

pwExp :: List Nat -> List Nat -> List Nat
pwExp = pwOp exp

countdown :: Nat -> List Nat
countdown O = O :> Nil
countdown (S n) = S n :> countdown n