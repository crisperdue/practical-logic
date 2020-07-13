# jrh-atp

John Harrison's wonderful book, "Handbook of Practical Logic and Automated Reasoning",
comes with OCaml code implementing and demonstrating many of the ideas presented there.
Unfortunately the web page and code distribution for them are considrably out of date.

The material here started with exactly the tar file referenced on Harrison's resource page
https://www.cl.cam.ac.uk/~jrh13/atp/index.html.  It has been updated to work with much
more recent versions of OCaml and OCaml tools, some of the supporting functionality
has been extended, and minor errors have been corrected.

To set up OCaml for use with this repository, get a version of OCaml 4.x.  This has
been tested with version 4.10.0, installed with OPAM in a Unix (Mac OS) environment using

```
sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)
```

as described at https://opam.ocaml.org/doc/Install.html, followed by

```
opam init
eval (opam env)
```

I added the ```eval (opam env)``` line to my ~/.bashrc to ensure that appropriate
environment variables are set up each time I run bash.

You will need opam packages "num" and "ocamlp5" to use this code.
The build procedure in the Makefile uses the "ocamlfind" package,
and many users find the "utop" package very helpful for interactive
development.  You can install all of this with:

```
opam install num ocamlp5 ocamlfind utop
```

on your command line.

If you run ```ocaml``` directly, you may want to give the command ```#use "topfind";;```
as your first interactive command.

Alternatively you can invoke the OCaml command line by running ```utop```, which
has "topfind" preloaded along with numerous convenience features for interactive use.

Running the "make" command as ```make inittop.ml``` or equivalently just ```make```,
will set up some useful components.  With this done, you can give the command
```#use "inittop.ml";;``` at the OCaml command line to load in all but the interactive
examples in Harrison's code.  Those become available in the "samples" subdirectory,
and you can run any one of them with ```#use "x-<name>.ml";;```.

The ```Makefile``` comments have more details on what is available.
