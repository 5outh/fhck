fhck
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
A working first version is up now!


On windows:

`build/fhck.exe`

Then, enter a `brainfuck` program, and it will run.


On other OS's (Requires GHC) (Note: I have not tested this):


`ghc --make src/fhck.hs`

`./src/fhck`

enter `brainfuck`, etc.

TODO:

Read brainfuck program from file

Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)