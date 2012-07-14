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

makeChars :: [Int] -> Chars 
makeChars xs = dats'
	where 
		  dats = splitAt (length xs `div` 2) xs
		  dats' = (fst dats, x, xs)
			where (x:xs) = snd dats

rShift :: Chars -> Chars
rShift (xs, x, (y:ys)) = (xs ++ [x], y, ys)

lShift :: Chars -> Chars
lShift (xs, y, ys) = (xs', x, y:ys)
	where (xs', x) = (init xs, last xs)
			
add :: Chars -> Chars
add (a, b, c) = (a, succ b, c)

subt :: Chars -> Chars
subt (a, b, c) = (a, pred b, c)

put :: Chars  -> IO ()
put (a, b, c) = putChar $ chr b

get :: Chars -> IO Chars
get (a, b, c) = do
		char <- getChar
		return (a, ord char, c)
			 
extractM :: Maybe Operator -> Operator
extractM (Just x) = x

extractE :: Either String STree -> STree
extractE (Right t) = t

mappings :: [(Char, Operator)]
mappings = zip "+-><.," [Plus, Minus, RShift, LShift, Dot, Comma]
			 
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

-- handle IO actions

doMapping :: Operator -> Chars -> Chars
doMapping op cs = case op of
					Plus 	-> add cs
					Minus 	-> subt cs
					RShift 	-> rShift cs
					LShift 	-> lShift cs
		
process :: STree -> Chars ->  IO ()
process [] 		 cs		= return ()
process (op:ops) cs 	= return ()
	
main = do
	let line = ",."
	let instructions = extractE . parse $ line
	let a = makeChars (replicate 3000 0)
	putStrLn . show $ instructions

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