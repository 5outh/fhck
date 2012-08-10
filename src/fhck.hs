import Data.Char
import Data.Either
import Data.Map(member, fromList)
import System(getArgs)

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

makeChars :: IO Chars 
makeChars = return (repeat 0, 0, repeat 0)
			 
extractM :: Maybe Operator -> Operator
extractM (Just x) = x

extractE :: Either String STree -> STree
extractE (Right t) = t

parse :: [Char] -> Either String STree
parse str = parse' str [] []
  where parse' :: [Char] -> STree -> [STree] -> Either String STree
        parse' [] ctx [] = Right (reverse ctx)
        parse' [] ctx _ = Left "unclosed []"
        parse' (']':cs) _ [] = Left "unexpected ]"
        parse' (c:cs) ctx stack
			| mapped c = parse' cs (op:ctx) stack
			| c == '[' = parse' cs [] (ctx:stack)
			| c == ']' = parse' cs (Bracket (reverse ctx):s) tack
			| otherwise = parse' cs ctx stack
				where 
					(s:tack) = stack
					op = extractM $ lookup c mappings
					mapped c = member c $ fromList mappings


mappings :: [(Char, Operator)]
mappings = zip "+-><.," [Plus, Minus, RShift, LShift, Dot, Comma]
			 
rShift :: Chars -> IO Chars
rShift (xs, x, (y:ys)) = return (x:xs, y, ys)

lShift :: Chars -> IO Chars
lShift (x:xs, y, ys) = return (xs, x, y:ys)
			
add :: Chars -> IO Chars
add (a, b, c) = return (a, succ b, c)

subt :: Chars -> IO Chars
subt (a, b, c) = return (a, pred b, c)

put :: Chars  -> IO Chars
put (a, b, c) = do
	putChar $ chr b
	return (a, b, c)

get :: Chars -> IO Chars
get (a, b, c) = do
		char <- getChar
		let repl = if char == '\n' then 0 else ord char
		return (a, repl, c)

loop :: STree -> Chars -> IO Chars
loop ops cs@(a, b, c) = case b of
			0 -> return cs
			_ -> do
			newChars <- process ops $ return cs
			loop ops newChars
		
process :: STree -> IO Chars ->  IO Chars
process [] 		 cs	=  cs
process (op:ops) cs =  do
	chars <- cs
	let newChars = case op of
			Plus 		-> add 			chars
			Minus 		-> subt 		chars
			RShift 		-> rShift 		chars
			LShift 		-> lShift 		chars
			Dot 		-> put 			chars
			Comma	   	-> get			chars
			Bracket xs 	-> loop xs 		chars
	process ops newChars
	
main = do
	args <- getArgs
	if length args == 0 then do
		putStrLn "Please provide a filepath or use the -i option."
	else do
	input <- case head args of
			 "-i" 	-> return (head $ tail args)
			 _    	-> readFile $ head args
	let instructions = extractE . parse $ input
	let chars = makeChars
	process instructions chars
	return ()