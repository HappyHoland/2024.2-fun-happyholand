module ExMaybe where

-- Do not alter this import!
import Prelude hiding ( maybe, Maybe(..) )
import qualified Data.Maybe as M
import Distribution.Simple.Utils (safeHead)

data Maybe a = Nothing | Just a
    deriving (Show, Eq, Ord)

catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (Nothing:cs) = catMaybes cs
catMaybes (Just a : cs) = a : catMaybes cs

fromJust :: Maybe a -> a
fromJust (Just x) = x 

fromMaybe :: a -> Maybe a -> a
fromMaybe x Nothing = x
fromMaybe _ (Just x) = x

isJust :: Maybe a -> Bool
isJust Nothing = False
isJust _ = True

isNothing :: Maybe a -> Bool
isNothing = not . isJust

mapMaybe :: (a -> b) -> (Maybe a -> Maybe b)
mapMaybe f Nothing = Nothing
mapMaybe f (Just a) = Just (f a)

justMap :: (a -> Maybe b) -> [a] -> [b]
justMap f = catMaybes . map f

maybe :: b -> (a -> b) -> Maybe a -> b
maybe b f = fromMaybe b . mapMaybe f

maybeToList :: Maybe a -> [a]
maybeToList x = catMaybes [x]

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:xs) = Just x

tryToModifyWith :: [Maybe (a -> a)] -> [a] -> [a]
tryToModifyWith [] xs = xs
tryToModifyWith _ [] = []
tryToModifyWith (f:fs) (x:xs) = fromMaybe id f x : tryToModifyWith fs xs 

