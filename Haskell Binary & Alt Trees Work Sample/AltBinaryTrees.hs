atrmodule AltBinaryTrees where

----------------------------------------------------------------------
--
--   The following definition does the following:
--
--       (1) Creates a family of datatypes of the form AltTree a
--              Examples:  AltTree Int, AltTree Bool, AltTree [Float], etc.
--
--       (2) Creates the (polymorphic!) constructor functions:
--               Leaf :: a -> AltTree a 
--               One :: a -> AltTree a -> AltTree a 
--               Two :: a -> AltTree a -> AltTree a -> AltTree a
--
--           Example:
--                (Leaf 13) :: AltTree Int
--                (One 'M' (Leaf 'y')) :: AltTree Char
--                (Two "aloha" (Leaf "hi") (Leaf "bye")) :: AltTree String
--
--       (4) Adds each type of form  AltTree a to the Show class
----------------------------------------------------------------------

data AltTree a = Leaf a
               | One a (AltTree a)
               | Two a (AltTree a) (AltTree a)
               deriving (Show)



----------------------------------------------------------------------
-- Some sample trees
----------------------------------------------------------------------

--
-- atree1:         7
--

atree1 :: AltTree Int
atree1 = Leaf 7

--
-- atree2:         8
--                / \
--               13  20
--               |
--               12
--

atree2 :: AltTree Int
atree2 = Two 8 (One 13 (Leaf 12))
               (Leaf 20)



--
-- atree3:         100
--                 / \
--               75   120
--              / \     |
--            65   82  147
--                 |    / \
--                 78 134  153
--

atree3 :: AltTree Int
atree3 = Two 100  (Two 75 (Leaf 65)
                          (One 82 (Leaf 78)))
                  (One 120 (Two 147 (Leaf 134) (Leaf 153)))


--
-- atree4:      "here's"
--               / \
--             "a" "string"
--              |
--            "tree"
--

atree4 :: AltTree String
atree4 = Two "here's" (One "a" (Leaf "tree"))
                      (Leaf "string")


--
--
-- atree5:         100
--                / \
--              75   120
--             /  \   
--           65    82 
--                /  \
--               78  134  
--
--    A full tree, but not perfect

atree5 :: AltTree Int
atree5 = Two 100 (Two 75 (Leaf 65)
                         (Two 82 (Leaf 78) (Leaf 134)))
                 (Leaf 120)
