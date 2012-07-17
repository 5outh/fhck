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
Alternatively, interactively from a string argument:
<pre>
$ build/windows/fhck.exe -i ",[>,]<[<]>[.>]"
</pre>
On UNIX/Linux/Mac OSX (Interactivity is not working at the moment):
<pre>
$ build/windows/fhck sample.b
</pre>

PS: sample.b and the provided string argument are both programs that take a line of text and echo it back.

TODO:

Fix interactivity in Linux

Figure out how to treat standard input properly (Currently \n is treated as \NUL for the purposes of gathering user input, which I do not think is correct.)
