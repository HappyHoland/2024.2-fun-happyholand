import Fun.Nat

inductive list (a: Type)
  | nil: list a
  | cons: a -> list a -> list a

def length (l: list a): nat :=
  match l with
  | .nil => .O
  | .cons _ xs => .S (length xs)

def concat (l l': list a): list a :=
  match l with
  | .nil => l'
  | .cons x xs => .cons x (concat xs l')

def reverse (l: list a): list a :=
  match l with
  | .nil => .nil
  | .cons x xs => concat (reverse xs) (.cons x .nil)

def map (f: a -> b) (l: list a): list b :=
  match l with
  | .nil => .nil
  | .cons x xs => .cons (f x) (map f xs)

def filter (p: a -> Bool) (l: list a): list a :=
  match l with
  | .nil => .nil
  | .cons x xs => if p x
                  then .cons x (filter p xs)
                  else filter p xs

def fold (i: a) (op: a -> a -> a) (l: list a): a :=
  match l with
  | .nil => i
  | .cons x xs => op x (fold i op xs)

def sum (l: list nat): nat := fold .O add l

def product (l: list nat): nat := fold (.S (.O)) mul l

def Concat (l: list (list a)): list a := fold .nil concat l

def take (n: nat) (l: list a): list a :=
  match l with
  | .nil => .nil
  | .cons x xs =>
    match n with
    | .O => .nil
    | .S m => .cons x (take m xs)

def drop (n: nat) (l: list a): list a :=
  match l with
  | .nil => .nil
  | .cons _ xs =>
    match n with
    | .O => l
    | .S m => drop m xs

def insertSort (n: nat) (l: list nat): list nat :=
  match l with
  | .nil => .cons n .nil
  | .cons x xs => if leq n x
                  then .cons n (.cons x xs)
                  else .cons x (insertSort n xs)

def sort (l: list nat): list nat :=
  match l with
  | .nil => .nil
  | .cons x xs => insertSort x (sort xs)
