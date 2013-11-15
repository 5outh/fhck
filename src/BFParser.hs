module BFParser (parseBF) where

import Text.ParserCombinators.Parsec
import Control.Applicative hiding((<|>), many)
import Types

parseBF :: String -> Either ParseError STree
parseBF = parse ops "(unknown)"
  where ops       = many (bracket <|> operator) <?> "operations"
        operator  = toOp <$> ( (many $ noneOf "+-<>.,[]") *> oneOf "+-<>.,") <?> "operator"
        bracket   = Bracket  <$> (char '[' *> ops <* char ']') <?> "bracket"