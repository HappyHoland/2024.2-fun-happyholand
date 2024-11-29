module ExArithV where
import Distribution.Simple.Utils (xargs)

-- modify ExArith to allow for variables

-- decide how to represent Assignments:
type Assignment = String -> ArExV

data ArExV where
    Atom :: Int -> ArExV
    Var :: String -> ArExV
    Plus :: ArExV -> ArExV -> ArExV
    Times :: ArExV -> ArExV -> ArExV
    Neg :: ArExV -> ArExV
    deriving (Eq)

-- pretty printer
pretty :: ArExV -> String
pretty (Atom x) = show x
pretty (Var s) = s
pretty (Plus e e') = pretty e ++ " + " ++ pretty e' 

-- eval evaluates an expression and returns its value
-- eval :: ?
eval :: ArExV -> (String -> Int) -> Int
eval (Atom x) _ = x
eval (Var s) f = f s
eval (Plus e e') f = eval e f + eval e' f
eval (Times e e') f = eval e f * eval e' f
eval (Neg e) f = - (eval e f) 

