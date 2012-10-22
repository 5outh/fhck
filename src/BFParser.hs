module BFParser (parseBF) where

import Text.ParserCombinators.Parsec
import Data.Maybe(fromJust)
import Types

parseBF :: String -> Either ParseError [Operator]
parseBF = parse ops "(unknown)"

ops :: GenParser Char st [Operator]
ops = many $ bracket <|> operator

operator :: GenParser Char st Operator
operator = do
  many $ noneOf "+-<>.,[]"
  a <- oneOf "+-<>.,"
  return (toOp a)
    where toOp c = fromJust $ lookup c mappings
          mappings = zip 
                     "+-><.," 
                     [Plus, Minus, RShift, LShift, Dot, Comma]

bracket :: GenParser Char st Operator
bracket = do
  char '['
  a <- many operator
  char ']'
  return (Bracket a)