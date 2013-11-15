module Types (
  Operator(..),
  CommandF(..),
  STree,
  Chars,
  makeChars,
  toOp)
where

import Data.Maybe(fromJust)
import Control.Monad.Free

data Operator = Plus
  | Minus
  | RShift 
  | LShift
  | Dot
  | Comma
  | Bracket STree
    deriving (Show, Eq)

data CommandF a = Plus' a 
  | Minus' a 
  | RShift' a 
  | LShift' a 
  | Dot' a 
  | Comma' a 
  | Bracket' (CommandF a)
  | End
    deriving (Show, Eq)
    
type STree = [Operator]

type Chars = ([Int], Int, [Int])

makeChars :: Chars 
makeChars = (repeat 0, 0, repeat 0)

toOp c = fromJust $ lookup c mappings
  where mappings = zip "+-><.," [Plus, Minus, RShift, LShift, Dot, Comma]
  
instance Functor CommandF where
  fmap f End           = End
  fmap f (Plus' a)     = Plus'  $ f a
  fmap f (Minus' a)    = Minus' $ f a
  fmap f (RShift' a)   = RShift' $ f a 
  fmap f (Dot' a)      = Dot'  $ f a
  fmap f (Comma' a)    = Comma' $ f a
  fmap f (Bracket' c) = Bracket' $ fmap f c