import IO

main = do
	hSetBuffering h NoBuffering
	getChar >>= putChar 
	main