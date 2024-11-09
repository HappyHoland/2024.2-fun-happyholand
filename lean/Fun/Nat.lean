inductive nat
  | O: nat
  | S: nat -> nat

def add (n m : nat): nat :=
  match m with
  | .O => n
  | .S _m => .S (add n _m)

def mul (n m: nat): nat :=
  match m with
  | .O => .O
  | .S _m => add n (mul n _m)

def leq (n m: nat): Bool :=
  match n with
  | .O => True
  | .S _n =>
    match m with
    | .O => False
    | .S _m => leq _n _m
