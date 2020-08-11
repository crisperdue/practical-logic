(* ========================================================================= *)
(* Setup and utilities for setting up interactive top level                  *)
(*                                                                           *)
(* ========================================================================= *)

(* Allow lines containing START_INTERACTIVE. *)
type dummy_interactive = START_INTERACTIVE | END_INTERACTIVE;;

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
    directive_use "utop-prefs.ml";;

#directory "samples";;  
