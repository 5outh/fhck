fhck 1.0
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
How to use:

Windows:

`build/windows/fhck.exe <brainfuck source filename>`

ex: `build/windows/fhck.exe sample.b`

Alternatively, you can pass the program a string representing a brainfuck program using the `-i` argument:

ex: `build/windows/fhck.exe -i ",[>,]<[<]>[.>]"`

On UNIX/Linux/Mac OSX (Requires GHC) (Note: I have not tested this):

`ghc --make src/fhck.hs`

`./src/fhck <brainfuck source filename>`

ex: `./fhck sample.b`

Or, interactively:

ex: `./fhck ",[>,]<[<]>[.>]"`

TODO:
Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)