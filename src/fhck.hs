import Data.Char
import Data.Either
import System.Environment (getArgs)
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.State
import Control.Monad.Free
import Control.Monad.Identity
import BFParser
import Types

extractE :: Either a b -> b
extractE (Right t) = t
extractE (Left  t) = error "There was some issue extracting."

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
  lift . putChar $ chr b

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
  let instructions = extractE . parseBF $ input
  runStateT (process instructions) makeChars
  return ()