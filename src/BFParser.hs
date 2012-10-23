module BFParser (parseBF) where

import Text.ParserCombinators.Parsec
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

bracket :: GenParser Char st Operator
bracket = do
  char '['
  a <- ops
  char ']'
  return (Bracket a)