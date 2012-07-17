fhck 1.0
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
Usage:

Windows:

<pre>
$ build/windows/fhck.exe <brainfuck_file_path>
$ build/windows/fhck.exe sample.b
</pre>
Alternatively, interactively from a String argument:
<pre>
$ build/windows/fhck.exe -i ",[>,]<[<]>[.>]"
</pre>
On UNIX/Linux/Mac OSX (Requires GHC) (Note: I have not tested this):
<pre>
$ ghc --make src/fhck.hs
$ ./src/fhck <brainfuck_file_path>
$ ./fhck sample.b
</pre>
Or, interactively:
<pre>
$ ./fhck ",[>,]<[<]>[.>]"
</pre>
TODO:

Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)