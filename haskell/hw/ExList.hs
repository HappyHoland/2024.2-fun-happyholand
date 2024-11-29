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
import Data.ByteString (isSuffixOf)

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

foldr :: b -> (a -> b -> b) -> [a] -> b
foldr i op [] = i
foldr i op (x : xs) = x `op` foldr i op xs

sum :: Num a => [a] -> a
sum = foldr 0 (+)

product :: Num a => [a] -> a
product = foldr 1 (*)

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
any p = foldr False ((||) . p)
-- all
all :: (a -> Bool) -> [a] -> Bool
all p = foldr True ((&&) . p)

-- and
and :: [Bool] -> Bool
and = all (==True)  

-- or
or :: [Bool] -> Bool
or = any (==True)

-- concat
concat :: [[a]] -> [a]
concat = foldr [] (++) 

-- elem using the funciton 'any' above
elem :: Eq a => a -> [a] -> Bool
elem x = any (==x)

-- elem': same as elem but elementary definition
-- (without using other functions except (==))
elem' :: Eq a => a -> [a] -> Bool
elem' x [] = False
elem' x (y : ys)
  | x == y = True
  | otherwise = elem' x ys

-- (!!)
(!!) :: [a] -> Int -> a
[] !! i = error "out of bounds"
(x : xs) !! 0 = x
(x : xs) !! i = xs !! (i-1) 

filter :: (a -> Bool) -> [a] -> [a]
filter p [] = []
filter p (x : xs)
  | p x = x : filter p xs
  | otherwise = filter p xs

map :: (a -> b) -> [a] -> [b]
map f [] = []
map f (x : xs) = f x : map f xs

-- cycle
cycle :: [a] -> [a]
cycle [] = error "empty list"
cycle xs = xs ++ cycle xs

-- repeat
repeat :: a -> [a]
repeat x = x : repeat x

-- replicate
replicate :: Int -> a -> [a]
replicate i x 
  | i <= 0 = []
  | otherwise = x : replicate (i-1) x

-- isPrefixOf
isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (x : xs) (y : ys) = x == y && isPrefixOf xs ys

-- isInfixOf
isInfixOf :: Eq a => [a] -> [a] -> Bool
isInfixOf [] _ = True
isInfixOf _ [] = False
isInfixOf (x : xs) (y : ys)
  | (x : xs) `isPrefixOf` (y : ys) = True
  | otherwise = isInfixOf (x: xs) ys

-- isSuffixOf
isSuffixOf :: Eq a => [a] -> [a] -> Bool
isSuffixOf xs ys = reverse xs `isPrefixOf` reverse ys

-- zip
zip :: [a] -> [b] -> [(a,b)]
zip _ [] = []
zip [] _ = []
zip (x : xs) (y : ys) = (x, y) : zip xs ys

-- zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith f _ [] = []
zipWith f [] _ = []
zipWith f (x : xs) (y : ys) = f x y : zipWith f xs ys

-- intercalate
intercalate :: [a] -> [[a]] -> [a]
intercalate _ [] = []
intercalate xs (y : ys) = y ++ xs ++ intercalate xs ys

-- nub
nub :: Eq a => [a] -> [a]
nub [] = []
nub (x : xs) = x : nub (filter (/= x) xs)

-- splitAt
-- what is the problem with the following?:
-- splitAt n xs  =  (take n xs, drop n xs)
splitAt :: Integral i => i -> [a] -> ([a], [a])
splitAt n xs = (take n xs, drop n xs)

-- break
break :: (a -> Bool) -> [a] -> ([a], [a])
break p xs = (takeWhile (not . p) xs, dropWhile (not . p) xs)

-- lines
lines :: String -> [String]
lines "" = []
lines (c : cs)
  | c == '\n' = lines cs
  | otherwise = takeWhile (/='\n') (c : cs) : lines (dropWhile (/='\n') (c : cs))

-- words
words :: String -> [String]
words "" = []
words (c : cs)
  | c == ' ' = lines cs
  | otherwise = takeWhile (/=' ') (c : cs) : words (dropWhile (/=' ') (c : cs))

-- unlines
unlines :: [String] -> String
unlines = intercalate "\n"

-- unwords
unwords :: [String] -> String
unwords = intercalate " "

fst :: (a, a) -> a
fst (x,y) = x

snd :: (a, a) -> a
snd (x,y) = y

-- transpose
transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([] : xs) = transpose xs
transpose xs = let hds = map (take 1) xs
                   tls = map (drop 1) xs
                   in concat hds : transpose tls

toUpper :: Char -> Char
toUpper char 
  | char == 'a' || char == 'A' = 'A'
  | char == 'b' || char == 'B' = 'B'
  | char == 'c' || char == 'C' = 'C'
  | char == 'd' || char == 'D' = 'D'
  | char == 'e' || char == 'E' = 'E'
  | char == 'f' || char == 'F' = 'F'
  | char == 'g' || char == 'G' = 'G'
  | char == 'h' || char == 'H' = 'H'
  | char == 'i' || char == 'I' = 'I'
  | char == 'j' || char == 'j' = 'J'
  | char == 'k' || char == 'K' = 'K'
  | char == 'l' || char == 'L' = 'L'
  | char == 'm' || char == 'M' = 'M'
  | char == 'o' || char == 'O' = 'O'
  | char == 'p' || char == 'P' = 'P'
  | char == 'q' || char == 'Q' = 'Q'
  | char == 'r' || char == 'R' = 'R'
  | char == 's' || char == 'S' = 'S'
  | char == 't' || char == 'T' = 'T'
  | char == 'w' || char == 'W' = 'W'
  | char == 'x' || char == 'X' = 'X'
  | char == 'y' || char == 'Y' = 'Y'
  | char == 'z' || char == 'Z' = 'Z'
  | otherwise = char

alphabetical :: Char -> Bool
alphabetical = (`elem` "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

-- checks if the letters of a phrase form a palindrome (see below for examples)
palindrome :: String -> Bool
palindrome xs 
  | reverse chars == chars = True
  | otherwise = False
  where chars = (map toUpper . filter alphabetical) xs

{-

Examples of palindromes:

"Madam, I'm Adam"
"Step on no pets."
"Mr. Owl ate my metal worm."
"Was it a car or a cat I saw?"
"Doc, note I dissent.  A fast never prevents a fatness.  I diet on cod."

-}

