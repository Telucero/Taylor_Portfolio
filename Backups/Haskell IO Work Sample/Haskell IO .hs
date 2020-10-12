--Taylor Lucero
--tlucero@syr.edu
import Data.Char


getInteger :: IO Integer
getInteger = do line <- getLine
                return (read line :: Integer)

getFloat :: IO Float
getFloat = do line <- getLine
              return (read line :: Float)


greet :: IO Int
greet = do
      putStrLn " Aloha, what's your name?"
      name <- getLine
      putStrLn (" Hello," ++ name ++ "!")
      return (length name)



shoutVertical :: String -> IO ()
shoutVertical [] = return ()
shoutVertical (c:cs) = do putStrLn (map toUpper [c])
                          shoutVertical cs                          

guess :: Integer -> IO Int
guess num = do putStr "Please, guess a number:"
               n <- getInteger
               if n == num
                  then return 1
                  else do putStr "Nope, try again."
                          x <- guess num
                          return (x + 1)


nonzeroes :: IO [Integer]
nonzeroes =  do num <- getInteger
                if num == 0
                   then return []
                   else do x <- nonzeroes
                           return (num:x)
                          

calcSum :: IO (Float, Float)
calcSum = do x <- getFloat
             if x == (-1)
                then return (0,0)
                else do (a,b)<- calcSum
                        return (a+1,x+b)

             
            
                

                        
                               
                           


            
      

      


