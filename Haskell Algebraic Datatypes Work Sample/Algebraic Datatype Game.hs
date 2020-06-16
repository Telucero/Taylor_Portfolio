--Taylor Lucero
--tlucero@syr.edu
import Algebraic_DatatypeDef

--defining the set variables
mage1, mage2, mage3, fighter1, fighter2, fighter3, fighter4 :: Hero
mage1 = Mage 2 Health Potion
mage2 = Mage 4 Wealth Silver
mage3 = Mage 7 None (Shield 5)
fighter1 = Warrior Brute []
fighter2 = Warrior Brute [Gold, Gold, Silver, Weapon 6, Weapon 3]
fighter3 = Warrior Archer [Potion, Potion, Potion, Silver, Silver, Gold]
fighter4 = Warrior Swordster [ Shield 3 , Shield 4, Weapon 2, Potion, Silver, Silver, Gold, Gold, Gold]

isMoney :: Item -> Bool
isMoney Silver = True
isMoney Gold = True
isMoney _ = False

cost :: Item -> Integer
cost Potion = 3
cost Silver = 1
cost Gold = 3
cost (Shield n) = 2*n
cost (Weapon n) = 1+ 2*n

baseOffense :: Hero -> Integer
baseOffense (Mage x _ _) = x 
baseOffense (Warrior Archer _) = 2
baseOffense (Warrior Swordster _) = 3
baseOffense (Warrior Brute _) = 5

wealth :: Hero -> Integer
wealth (Mage _ _ Gold) = 3
wealth (Mage _ _ Silver) =1
wealth (Mage _ _ _) = 0
wealth (Warrior _ x) = sum [ cost c | c <- x, isMoney c ]

canBuy :: Hero -> Item -> Bool
canBuy (Mage _ Wealth x) k = isMoney x
canBuy (Mage _ _ x ) k
       |cost x > cost k = True
       |otherwise = False
canBuy (Warrior y x) k
       |wealth (Warrior y x) > cost k = True
       |otherwise = False

        
boostShields :: Integer -> Hero -> Hero
boostShields k (Mage x y (Shield n) ) = Mage x y (Shield (n+k))
boostShields k (Mage x y z) = Mage x y z
boostShields k (Warrior y []) =  Warrior y []
boostShields k (Warrior y (x:xs)) = Warrior y ([boost d  k | d <-(x:xs)])
             where
             boost :: Item -> Integer -> Item
             boost (Shield n) k = Shield (n+k)
             boost x k = x
                         
heroPower :: Hero -> Integer
heroPower (Mage x _ _) = x
heroPower (Warrior y x) = baseOffense (Warrior y x) + sum [ addWeapons c | c <- x, isWeapon c ]
          where isWeapon :: Item -> Bool
                isWeapon (Weapon n) = True
                isWeapon _ = False
                addWeapons :: Item -> Integer
                addWeapons (Weapon n) = n
                
goldBrutes :: [Hero] -> Integer
goldBrutes (x)  = toInteger( length[ x | c <- x, isGBrute c])
           where isGBrute :: Hero -> Bool
                 isGBrute (Warrior Brute a) = hasGold[v| v <-a, isMoney v && cost v ==3]
                 isGBrute (Warrior _ _) = False
                 isGBrute (Mage _ _ _) = False
                 hasGold:: [Item] -> Bool
                 hasGold (x:xs) = isMoney x
                 hasGold [] = False
                 
                 
                 
                 
                
                          
                  
                 
                 
                    


       