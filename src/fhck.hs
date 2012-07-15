import Data.Char
import Data.Either
import Data.Map(member, fromList)

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

makeChars :: [Int] -> IO Chars 
makeChars xs = return dats'
	where 
		  dats = splitAt (length xs `div` 2) xs
		  dats' = (fst dats, x, xs)
			where (x:xs) = snd dats
			 
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
rShift (xs, x, (y:ys)) = return (xs ++ [x], y, ys)

lShift :: Chars -> IO Chars
lShift (xs, y, ys) = return (xs', x, y:ys)
	where (xs', x) = (init xs, last xs)
			
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
		return (a, ord char, c)

process :: STree -> IO Chars ->  IO Chars
process [] 		 cs	=  cs
process (op:ops) cs =  do
	chars <- cs
	let newChars = case op of
				Plus 	-> add 		chars
				Minus 	-> subt 	chars
				RShift 	-> rShift 	chars
				LShift 	-> lShift 	chars
				Dot 	-> put 		chars
				Comma	-> get		chars
	process ops newChars
	
	
main = do
	line <- getLine
	let instructions = extractE . parse $ line
	let chars = makeChars (replicate 30 0)
	process instructions chars

{-
	main =
		list <- Chars 30000 0s
			foldl process _ STree
				where process acc x = do
					x ->
						if io action
						io <- alkdjsfka
						call back on io
						else
						let nonIO = ajkhdskfjhaf
						call back on nonIO
						do corresponding process of x to Chars until no Operations left
						eventually return ()
				
			process :: Chars -> STree , recursive
		start on 15000th and follow instructions
		+ = increment
		- = decrement
		> = move to next
		< = move to previous
		, = getChar
		. = putChar
		[] = while loop =
			do inner stuff until current node = 0
			when that happens, break out and continue
		when complete, exit
-}