module Types (
  Operator(Minus, Plus, RShift, LShift, Dot, Comma, Bracket),
  STree,
  Chars,
  makeChars)
where

data Operator = Plus
  | Minus
  | RShift 
  | LShift
  | Dot
  | Comma
  | Bracket STree
    deriving (Show, Eq)

type STree = [Operator]

type Chars = ([Int], Int, [Int])

makeChars :: Chars 
makeChars = (repeat 0, 0, repeat 0)
