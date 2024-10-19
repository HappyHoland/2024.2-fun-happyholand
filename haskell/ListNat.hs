module ListNat where

import Prelude hiding (Num(..), List(..), sum, product, (^), exp, map, (==), pred, reverse, filter, even, odd)
import List
import Nat
import Typeclasses
import Bool (ifThenElse)
import NatRel
import EvOd


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

range :: Nat -> Nat -> List Nat
range n m = ifThenElse (n `leq` m) 
                (ifThenElse (n == m)
                    (m :> Nil)
                    (n :> range (S n) m)) 
                (n :> range (pred n) m)

evens :: List Nat -> List Nat
evens = filter even

odds :: List Nat -> List Nat
odds = filter odd