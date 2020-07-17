# Code from John Harrison's book

John Harrison's remarkable "Handbook of Practical Logic and Automated Reasoning",
comes with OCaml code implementing and demonstrating many of the ideas presented there.
Unfortunately the web page and code distribution for them are considerably behind the
current OCaml language and tooling.

This repository was created to help people like myself, who are not very familiar with
OCaml or its toolset, to use Harrison's sample code with recent versionss of OCaml
and tools.

The material here started with exactly the tar file referenced on Harrison's resource page
https://www.cl.cam.ac.uk/~jrh13/atp/index.html.  It has been updated slightly to work with much
more recent versions of OCaml and OCaml tools, some of the supporting functionality
has been extended, and minor errors have been corrected.  The instructions here for
installing and setting up OCaml and tools are new.

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

After this you can invoke the OCaml command line by running ```ocaml``` or
alternatively ```utop```, which has numerous conveniences for interactive use.

Running the system "make" command as ```make inittop.ml``` or equivalently just ```make```,
will set up everything you need to run most of the sample files.

Those examples become available in the "samples" subdirectory,
and you can run any file of examples with 

```
#use "x-<name>.ml";;
```

The files intro.ml and prop.ml are a little different.  To run one of these enter:

```
#use "intro.ml";;
```
or
```
#use "prop.ml";;
```

on your OCaml command line.  In this case rerun OCaml before attempting to run other samples.


The ```Makefile``` comments have more details on what is available.
