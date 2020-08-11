(* ========================================================================= *)
(* Load just alist-based unification into the top level.                     *)
(* ========================================================================= *)

Sys.interactive := false;;

#use "topfind";;
#require "num";;
#require "str";;
#require "camlp5";;
#load "camlp5o.cma";;
#load "Quotexpander.cmo";;

type dummy_interactive = START_INTERACTIVE | END_INTERACTIVE;;

#warnings "-3";;    (* Suppress deprecation warnings due to old-style code. *)

#use "initialization.ml";;
#use "lib.ml";;              (* Utility functions                            *)
#use "alist.ml";;
#use "intro.ml";;            (* Trivial example from the introduction        *)
#use "formulas.ml";;
#use "prop.ml";;             (* Basic propositional logic stuff              *)
#use "fol.ml";;

let parse_fml = default_parser;;
let parse_term = secondary_parser;;

#use "inittop.ml";;

Sys.interactive := true;;
