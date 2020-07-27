(* Initializations specifically for UTop *)

#utop_prompt_simple;;

(* UTop.set_show_box false *)

(* Set up automatic camlp4 quotation expansion. *)
(* Uses the environment variable "EDITOR", or vi. *)
UTop.set_external_editor "./qx";;

print_endline "Enter Control-X Control-E to expand any camlp5 quotations";;
print_endline "(e.g. <<x = y ==> y = x>>), or to invoke external editor.";;
