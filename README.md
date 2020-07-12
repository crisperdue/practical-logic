# jrh-atp

Code resources for John Harrison's "Handbook of Practical Logic and Automated Reasoning".
The material here started with exactly the tar file referenced on Harrison's resource page
https://www.cl.cam.ac.uk/~jrh13/atp/index.html.  It has been updated to work with much
more recent versions of OCaml and OCaml tools, and some of the convenience functionality
has been extended.

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

I added the ```eval (opam env)``` line to ~/.bashrc to ensure that appropriate
environment variables are set up in my bash shell.

You will need opam packages "num" and "ocamlp5" to use this code.
The build procedure in the Makefile uses the "ocamlfind" package,
and many users find the "utop" package very helpful for interactive
development.  You can install all of this with:

```
opam install num ocamlp5 ocamlfind utop
```

on your command line.

The ```Makefile``` comments have more details on what is available.
