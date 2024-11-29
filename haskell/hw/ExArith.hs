module ExArith where

data ArEx = Atom Integer
          | Plus ArEx ArEx
          | Times ArEx ArEx
          | Neg ArEx
  deriving (Eq, Show)

-- pretty printer
pretty :: ArEx -> String
pretty (Atom x) = show x
pretty (Plus e e') = "(" ++ pretty e ++ " + " ++ pretty e' ++ ")" 
pretty (Times e e') = "(" ++ pretty e ++ " * " ++ pretty e' ++ ")" 
pretty (Neg e) = "-" ++ pretty e

-- example expressions
ex1 = (Atom 23) `Plus` (Atom 2)
ex2 = (Atom 7) `Times` ((Atom 7) `Plus` ((Atom 2) `Times` (Atom 8)))
ex3 = Times ex1 ex2
ex4 = Neg $ ex3 `Plus` ex1
ex5 = (Neg ex1) `Times` (Neg ex4)

-- eval evaluates an expression and returns its value
eval :: ArEx -> Integer
eval (Atom x) = x
eval (Plus e e') = eval e + eval e'
eval (Times e e') = eval e * eval e'
eval (Neg e) = - (eval e)

-- step should make only 1 step of calculation on a given ArEx
step :: ArEx -> ArEx
step (Atom x) = Atom x
step (Plus (Atom x) (Atom y)) = Atom (x + y)
step (Plus (Atom i) e) = Plus (Atom i) (step e)
step (Plus e e') = Plus (step e) e'
step (Times (Atom x) (Atom y)) = Atom (x * y)
step (Times (Atom i) e) = Times (Atom i) (step e)
step (Times e e') = Times (step e) e'
step (Neg (Atom x)) = Atom (-x)
step (Neg e) = Neg (step e)



