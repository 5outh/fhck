import Data.Char

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
		
fix :: Chars -> Chars
fix (a, b, c) = (a, 100, c)