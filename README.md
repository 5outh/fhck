fhck
====

Brainfuck interpreter written in Haskell

Author: Benjamin Kovach

----
Usage:


Windows:

<pre>
$ build/windows/fhck.exe brainfuck_file_path
$ build/windows/fhck.exe sample.b
</pre>

Alternatively, interactively from a string argument:

<pre>$ build/windows/fhck.exe -i ",[>,]"</pre>

On UNIX/Linux/Mac OSX:

<pre>
$ build/linux/fhck sample.b
</pre>

PS: sample.b is a program that takes a line of text and echoes it back.
