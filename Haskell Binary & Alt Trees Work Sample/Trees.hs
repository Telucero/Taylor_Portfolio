--Taylor Lucero

import BinaryTrees
import AltBinaryTrees


height :: BTree a -> Int
height Empty  = (-1)
height (BNode a x y)  = 1 + max (height x) (height y)


multTree :: Int -> BTree Int -> BTree Int
multTree _ Empty = Empty
multTree n (BNode a x y) = BNode (a*n) (multTree n x) (multTree n y) 


interiors :: BTree a -> [a]
interiors Empty = []
interiors (BNode a Empty Empty) = [] 
interiors (BNode a l r) = a: (interiors l ++ interiors r)

          
full :: BTree a -> Bool
full (BNode _ Empty Empty) = True
full (BNode _ Empty _) = False
full (BNode _ _ Empty) = False
full (BNode a x y) = (full x) && (full y)


heightA :: AltTree a -> Int
heightA (Leaf a) = 0
heightA (One a l)  =  1 + (heightA l)
heightA (Two a l r) = 1 + max (heightA l) (heightA r)


multTreeA :: Int -> AltTree Int -> AltTree Int
multTreeA n (Leaf a) = Leaf (a*n)
multTreeA n (One a l) = One (a*n) (multTreeA n l)
multTreeA n (Two a l r) = Two (a*n) (multTreeA n l) (multTreeA n r)


interiorsA :: AltTree a -> [a]
interiorsA (Leaf a) = []
interiorsA (One a l) = a : (interiorsA l)
interiorsA (Two a l r) = a : (interiorsA l) ++ (interiorsA r)


fullA :: AltTree a -> Bool
fullA (Leaf a) = True
fullA (One a l) = False 
fullA (Two a l r) = True && (fullA l) && (fullA r)


convert :: AltTree a -> BTree a
convert (Leaf a) = (BNode a) (Empty) (Empty)
convert (One a l) = (BNode a) (convert l) (Empty)
convert (Two a l r) = (BNode a) (convert l) (convert r)


makeComplete :: Int -> BTree Int
makeComplete n = makeTree n 1
makeTree :: Int -> Int -> BTree Int
makeTree n v
         | v > n = Empty
         | otherwise = BNode v ( makeTree n (2*v) ) (makeTree n (2*v+1))

