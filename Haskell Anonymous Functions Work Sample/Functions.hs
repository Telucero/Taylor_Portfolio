--Taylor Lucero
--tlucero@syr.edu
import Data.Char


places :: Eq a => a -> [a] -> [Integer]
places x ys = map fst (filter (\(n,c) -> x == c) ( zip [1..] ys ))

equa10n :: Eq b => (a -> b) -> (a -> b) -> [a] -> Bool
equa10n f g vals = null (filter (\x -> f(x)/=g(x) )  vals)

histogram :: [Integer] -> String
histogram xs = concat (map f xs)
          where
          f :: Integer -> String
          f x = ['*' | y <- [1..x]] ++ "\n"

isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = ins x (isort xs)
 where
  ins y [] = [y]
  ins y (z:zs)
      |y <= z = y:z:zs
      |otherwise = z: (ins y zs)

 
mysort :: (a -> a -> Bool) -> [a] -> [a]
mysort _ [] = []
mysort p (x:xs) = ins x (mysort p xs) 
      where
       ins y [] = [y]
       ins y (z:zs)
           |p y z = y:z:zs
           |otherwise = z:(ins y zs)


zeroes ::( Integer -> Integer) -> Integer -> [Integer]
zeroes f limit = [ v | v <- [0..limit], f(v)==0  ]


-- pig latin : Words that start with a vowel (a e i o u) simply have way appended to the end of the word

-- words that start with a consonant have all consonants letters up to the first vowel removed and ay is appended to the end of the word.

translate :: String -> String
translate (c:cs)
          | null front =  (c:cs) ++ "way"
          | otherwise = back ++ front  ++ "ay"
          where
                isConsonant :: Char -> Bool
                isConsonant c = not (elem (toLower c) "aeiou")
                (front, back) = (takeWhile isConsonant (c:cs) , dropWhile isConsonant (c:cs)  )

--Words : creates an array of string from the original one, white space characters serving as separators
--Unwords : creates a string from an array of strings, it inserts space characters between original strings [strings] -> strings
-- translate
-- map


pigLatin :: String -> String
pigLatin cs = unwords (map translate (words cs))









