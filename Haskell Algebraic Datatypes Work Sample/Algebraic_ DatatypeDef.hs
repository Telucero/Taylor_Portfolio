module HW6Defs where

----------------------------------------------------------------------
--  Algebraic Datatypes for HW 6 (CIS 252: Fall 2019)
----------------------------------------------------------------------

-- items that can be held by heroes
data Item =  Silver | Gold | Potion | Shield Integer 
                                    | Weapon Integer
             deriving (Show)

-- abilities for mages
data Ability = Wealth | Health | None
             deriving (Show)

-- styles for warriors
data Style = Archer | Swordster | Brute
             deriving (Show)

-- the heroes themselves
data Hero = Mage Integer Ability Item
          | Warrior Style [Item]
            deriving (Show)

