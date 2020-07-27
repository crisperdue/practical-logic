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
#load "Quotexpander.cmo";;

#load "atp_batch.cmo";;
open Atp_batch;;

let parse_fml = default_parser;;
let parse_term = secondary_parser;;

(* Allow lines containing START_INTERACTIVE. *)
type dummy_interactive = START_INTERACTIVE | END_INTERACTIVE;;

#use "printers.ml";;
#directory "samples";;  

(* Runs the action of a directive with no arguments *)
let run_directive name =
  match (Hashtbl.find Toploop.directive_table name) with
  | Toploop.Directive_none fn -> fn()
  | _ -> failwith "Directive needs args";;

(* Runs the #use directive *)
let directive_use filename =
  match (Hashtbl.find Toploop.directive_table "use") with
  | Toploop.Directive_string fn -> fn filename
  | _ -> failwith "#use directive needs filename";;

(* Runs an expression from a string, appending ";;" *)
let eval code =
  let as_buf = Lexing.from_string (code ^ ";;") in
  let parsed = !Toploop.parse_toplevel_phrase as_buf in
  try
    ignore (Toploop.execute_phrase false Format.std_formatter parsed);
    true
  with | _ -> false;;

if Findlib.is_recorded_package "utop" then
  if Sys.file_exists "utop-prefs.ml" then
    directive_use "utop-prefs.ml";

Sys.interactive := true;;
