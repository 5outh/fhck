import Data.Char
import Data.Either
import Data.Map (member, fromList)
import System.Environment (getArgs)
import Text.ParserCombinators.Parsec hiding (parse)
import Control.Applicative hiding ((<|>), many)
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.State
import Data.Maybe (fromMaybe, fromJust)

data Operator =   Plus
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

extractE :: Either String STree -> STree
extractE (Right t) = t

parse :: String -> Either String STree
parse str = parse' str [] []
  where parse' :: String -> STree -> [STree] -> Either String STree
        parse' [] ctx [] = Right (reverse ctx)
        parse' [] _  _ = Left "unclosed []"
        parse' (']':_) _ [] = Left "unexpected ]"
        parse' (c:cs) ctx stack
          | mapped c = parse' cs (op:ctx) stack
          | c == '[' = parse' cs [] (ctx:stack)
          | c == ']' = parse' cs (Bracket (reverse ctx):s) tack
          | otherwise = parse' cs ctx stack
            where (s:tack) = stack
                  op = fromJust $ lookup c mappings
                  mapped c = member c $ fromList mappings

mappings :: [(Char, Operator)]
mappings = zip "+-><.," [Plus, Minus, RShift, LShift, Dot, Comma]

rShift :: Chars -> Chars
rShift (xs, x, (y:ys)) = (x:xs, y, ys)

lShift :: Chars -> Chars
lShift (x:xs, y, ys) = (xs, x, y:ys)

add :: Chars -> Chars
add (a, b, c) = (a, succ b, c)

subt :: Chars -> Chars
subt (a, b, c) =(a, pred b, c)

putOp :: StateT Chars IO ()
putOp = do
  (_, b, _) <- get
  lift $ putChar $ chr b

getOp :: StateT Chars IO ()
getOp= do
  char <- lift getChar
  (a, b, c) <- get
  let repl = if char == '\n' then 0 else ord char
  put (a, repl, c)

loop :: STree -> StateT Chars IO ()
loop ops = do
  (_, b, _) <- get
  case b of
    0 -> return ()
    _ -> do
      process ops
      loop    ops

process :: STree -> StateT Chars IO ()
process ops =  forM_ ops $ \op -> case op of
        Plus        -> modify add
        Minus       -> modify subt
        RShift      -> modify rShift
        LShift      -> modify lShift
        Dot         -> putOp
        Comma       -> getOp
        Bracket xs  -> loop xs

main :: IO ()
main = do
  args <- getArgs
  input <- case args of
    ["-i", s]  -> return s
    [f] -> readFile f
    []  -> error "Please provide a filepath or use the -i option."
  let instructions = extractE . parse $ input
  runStateT (process instructions) makeChars
  return ()