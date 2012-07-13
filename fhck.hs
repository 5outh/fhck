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

operationMappings :: [(Operator, f)]
operationMappings = zip [Plus, Minus, RShift, LShift, Dot, Comma] [add, subt, rShift, lShift, put, get]

add = undefined
subt = undefined
rShift = undefined
lShift = undefined
put = undefined
get = undefined  

process :: Chars -> STree -> IO ()
process (Chars dat idx) (op:ops) = return ()
					
main = do
	line <- getLine
	process (Chars { curData = (replicate 3000 0), curIndex = 1500 }) (extractE . parse $ line)
	putStrLn . show.  extractE . parse $ line

{-
	main =
		create list of 30000 0's
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