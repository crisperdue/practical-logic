(* ========================================================================= *)
(* Initialize theorem proving example code.                                  *)
(*                                                                           *)
(* Copyright (c) 2003-2007, John Harrison. (See "LICENSE.txt" for details.)  *)
(* ========================================================================= *)

Sys.interactive := false;;

#use "topfind";;
#require "num";;
#require "str";;
#require "camlp5";;
#load "camlp5o.cma";;
#load "Quotexpander.cmo";;

#load "atp_batch.cmo";;
open Atp_batch;;

#use "printers.ml";;
let parse_fml = default_parser;;
let parse_term = secondary_parser;;

#use "inittop.ml";;

Sys.interactive := true;;
