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

data Chars = Chars { curData :: [Int],
					 curIndex :: Int
				   }
			 deriving (Show)

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

doIOMapping :: Operator -> Chars -> IO Chars
doIOMapping op cs = case op of
					Dot -> put cs
					Comma -> get cs

doMapping :: Operator -> Chars -> Chars
doMapping op cs = case op of
					Plus 	-> add cs
					Minus 	-> subt cs
					RShift 	-> rShift cs
					LShift 	-> lShift cs
	
add :: Chars -> Chars
add cs = Chars replacement idx
	where
		(dats, idx) = (curData cs, curIndex cs)
		(x,y:xs) = splitAt idx dats
		replacement = x ++ (succ y) : xs 

subt :: Chars  -> Chars
subt cs = Chars replacement idx
	where
		(dats, idx) = (curData cs, curIndex cs)
		(x,y:xs) = splitAt idx dats
		replacement = x ++ (pred y) : xs 

rShift :: Chars  -> Chars
rShift cs = Chars dats $ succ idx
	where (dats, idx) = (curData cs, curIndex cs)

lShift :: Chars  -> Chars
lShift cs = Chars dats $ pred idx
	where (dats, idx) = (curData cs, curIndex cs)

put :: Chars  -> IO Chars
put cs = do
		let (dats, idx) = (curData cs, curIndex cs)	
		putChar $ chr (dats !! idx)
		return cs
		
		
get :: Chars -> IO Chars
get cs = do
		char <- getChar
		let (dats, idx) = (curData cs, curIndex cs)
		let (x,y:xs) = splitAt idx dats
		let replacement = x ++ (ord char) : xs
		return $ Chars replacement idx
		
process :: STree -> Chars -> IO ()
process [] 		 cs		= return ()
process (op:ops) cs 	= return ()
					
main = do
	let line = ",."
	--line <- getLine
	let instructions = extractE . parse $ line
	process instructions (Chars (replicate 3000 0) 1500 )
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