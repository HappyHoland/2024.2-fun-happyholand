{-# LANGUAGE GADTs #-}

module ExList where

import Prelude
    ( Char , String , Int , Integer , Double , Float , Bool(..)
    , Num(..) , Integral(..) , Enum(..) , Ord(..) , Eq(..)
    , not , (&&) , (||)
    , (.) , ($)
    , flip , curry , uncurry
    , otherwise , error , undefined
    )
import qualified Prelude   as P
import qualified Data.List as L
import qualified Data.Char as C
import Distribution.Simple.Utils (xargs)

{- import qualified ... as ... ?

To use a function from a qualified import
you need to prefix its name with its alias and a dot:
P.head   C.toUpper   etc.

I import these for you to test the original functions on ghci:

ghci> :t C.toUpper
C.toUpper :: Char -> Char

You MUST NOT use ANY of these in your code

-}


{- Our lists vs Haskell lists

Our definition:

data List a where
  Nil  :: List a
  Cons :: a -> List a -> List a

Here we use Haskell's built-in lists and associated syntactic sugar.
It is as if it was defined like this:

    data [a] = [] | (x : xs)

or like this:

    data [a] where
      []  :: [a]
      (:) :: a -> [a] -> [a]

write [a]       for our List a
write []        for our List
write []        for our Nil
write (x : xs)  for our Cons x xs
write [u,v]     for our u `Cons` (v `Cons` Nil)

-}

head :: [a] -> a
head [] = error "no head on empty list"
head (x : xs) = x

tail :: [a] -> [a]
tail [] = error "no tail on empty list"
tail (x : xs) = xs

null :: [a] -> Bool
null [] = True
null (x : xs) = True

length :: Integral i => [a] -> i
length [] = 0
length (x : xs) = 1 + length xs

sum :: Num a => [a] -> a
sum [] = 0
sum (x : xs) = x + sum xs

product :: Num a => [a] -> a
product [] = 1
product (x : xs) = x * product xs

reverse :: [a] -> [a]
reverse [] = []
reverse (x : xs) = reverse xs ++ [x]

(++) :: [a] -> [a] -> [a]
[] ++ xs = xs
(x : xs) ++ ys = x : (xs ++ ys)  

-- right-associative for performance!
-- (what?!)
infixr 5 ++

-- (snoc is cons written backwards)
snoc :: a -> [a] -> [a]
snoc x xs = xs ++ [x]

(<:) :: [a] -> a -> [a]
(<:) = flip snoc

-- different implementation of (++)
(+++) :: [a] -> [a] -> [a]
xs +++ []     = xs
xs +++ [y]    = xs <: y
xs +++ (y:ys) = (xs +++ [y]) +++ ys

-- left-associative for performance!
-- (hmm??)
infixl 5 +++

-- minimum :: Ord a => [a] -> a
minimum :: Ord a => [a] -> a
minimum [] = error "empty list"
minimum (x : xs)
  | x <= min = x
  | otherwise = min
  where min = minimum xs

-- maximum :: Ord a => [a] -> a
maximum :: Ord a => [a] -> a
maximum [] = error "empty list"
maximum (x : xs)
  | x >= max = x
  | otherwise = max
  where max = maximum xs

-- take
take :: Integral i => i -> [a] -> [a]
take 0 xs = []
take i [] = []
take i (x : xs) = x : take (i-1) xs

-- drop
drop :: Integral i => i -> [a] -> [a]
drop 0 xs = xs
drop i [] = []
drop i (x : xs) = drop (i-1) xs

-- takeWhile
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p [] = []
takeWhile p (x : xs)
  | p x = x : takeWhile p xs
  | otherwise = []

-- dropWhile
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile p [] = []
dropWhile p (x : xs)
  | p x = dropWhile p xs
  | otherwise = x : xs

-- tails
tails :: [a] -> [[a]]
tails [] = [[]]
tails (x : xs) = tail (x : xs) : tails xs

-- init
init :: [a] -> [a]
init [] = error "empty list"
init [x] = []
init (x : xs) = x : init xs

-- inits
inits :: [a] -> [[a]]
inits [] = [[]]
inits (x : xs) = inits xs <: init (x : xs)

-- subsequences
subsequences :: [a] -> [[a]]
subsequences [] = [[]]
subsequences (x : xs) = subsequences xs ++ map (++ [x]) (subsequences xs)

-- any
any :: (a -> Bool) -> [a] -> Bool
any p [] = False
any p (x : xs) = p x || any p xs

-- all
all :: (a -> Bool) -> [a] -> Bool
all p [] = True
all p (x : xs) = p x && all p xs

-- and
and :: [Bool] -> Bool
and = all (==True)  

-- or
or :: [Bool] -> Bool
or = any (==True)

-- concat

-- elem using the funciton 'any' above

-- elem': same as elem but elementary definition
-- (without using other functions except (==))

-- (!!)

filter :: (a -> Bool) -> [a] -> [a]
filter p [] = []
filter p (x : xs)
  | p x = x : filter p xs
  | otherwise = filter p xs

map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x : xs) = f x : map f xs

-- cycle
-- repeat
-- replicateake

-- isPrefixOf
-- isInfixOf
-- isSuffixOf

-- zip
-- zipWith

-- intercalate
-- nub

-- splitAt
-- what is the problem with the following?:
-- splitAt n xs  =  (take n xs, drop n xs)

-- break

-- lines
-- words
-- unlines
-- unwords

-- transpose

-- checks if the letters of a phrase form a palindrome (see below for examples)
palindrome :: String -> Bool
palindrome xs
  | xs == reverse xs = True
  | otherwise = False

{-

Examples of palindromes:

"Madam, I'm Adam"
"Step on no pets."
"Mr. Owl ate my metal worm."
"Was it a car or a cat I saw?"
"Doc, note I dissent.  A fast never prevents a fatness.  I diet on cod."

-}

