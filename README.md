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

<pre>$ build/windows/fhck.exe -i ",[>,]"</pre>

On UNIX/Linux/Mac OSX:

<pre>
$ build/windows/fhck sample.b
</pre>

PS: sample.b and the provided string argument are both programs that take a line of text and echo it back.

*TODO:*
* Error handling
* Monadic parsing
