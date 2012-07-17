fhck 1.0
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
Usage:

Windows:
$ build/windows/fhck.exe <brainfuck_file_path>
$ build/windows/fhck.exe sample.b

Alternatively, interactively from a String argument:

$ build/windows/fhck.exe -i ",[>,]<[<]>[.>]"

On UNIX/Linux/Mac OSX (Requires GHC) (Note: I have not tested this):

`ghc --make src/fhck.hs`

`./src/fhck <brainfuck source filename>`

ex: `./fhck sample.b`

Or, interactively:

ex: `./fhck ",[>,]<[<]>[.>]"`

TODO:
Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)