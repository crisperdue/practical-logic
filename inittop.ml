(* ========================================================================= *)
(* Initialize theorem proving example code.                                  *)
(*                                                                           *)
(* Copyright (c) 2003-2007, John Harrison. (See "LICENSE.txt" for details.)  *)
(* ========================================================================= *)

Sys.interactive := false;;

#use "topfind";;
#require "num";;
#require "camlp5";;
#load "camlp5o.cma";;
#load "atp_batch.cmo";;
#load "Quotexpander.cmo";;

open Atp_batch;;

Sys.interactive := true;;
