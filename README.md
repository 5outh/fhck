fhck
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
A working first version is up now!


On windows:

`build/windows/fhck.exe <brainfuck source filename>`


On UNIX/Linux/Mac OSX (Requires GHC) (Note: I have not tested this):

`ghc --make src/fhck.hs`

`./src/fhck <brainfuck source filename>`

TODO:
Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)