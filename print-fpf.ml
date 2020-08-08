(* Extra stuff for finite partial functions *)

let list_iter_sep eltfn sepfn ls =
  match ls with
  | [] -> ()
  | head :: tail ->
      eltfn head;
      List.iter (fun x -> sepfn(); eltfn x) tail;;

(* Nicely print a finite partial function, using Format. *)
let print_func fpf =
  let p = Format.print_string in
  let ob = Format.open_box in
  let hb = Format.open_hbox in
  let sp = Format.print_space in
  let cut = Format.print_cut in
  let cl = Format.close_box in
  let str s = p "\""; p (String.escaped s); p "\"" in
  let semi() = p ";"; sp() in
  let pr_item (key, term) =
    ob 1;
    hb(); p "("; str key; p ","; sp(); cl(); cut();
    printert term; p ")";
    cl(); in
  ob 1; p "["; list_iter_sep pr_item semi (graph fpf); p "]"; cl();;

#install_printer print_func;;


(* Experimental test code *)

let read_whole_file filename =
  let ch = open_in filename in
  let s = really_input_string ch (in_channel_length ch) in
  close_in ch;
  s;;

let func_data = read_whole_file "print-fpf.ml";;

let words = Str.split (Str.regexp "[^a-zA-Z]+") func_data;;

let test1() =
  let p2 x =
    Format.open_box(1);
    Format.print_string x;
    Format.print_space();
    Format.print_string x;
    Format.close_box() in
  Format.open_box(1);
  list_iter_sep p2 Format.print_space words;
  Format.close_box();;

let test2() =
  let p = print_string in
  let box = open_box in
  let sp = print_space in
  let br = print_break 2 in
  let xob = close_box in
  box 2;
  p "if"; sp(); p "life is good asdf adsf asdf asdf"; br (-2); p "then"; sp();
(*  box 2; p "we are all asdfadsf"; sp();
    p "asdfasdfasdf frabjous"; xob(); br (-2); *)
  p "we are"; br (-2);
  p "otherwise"; sp();
  box 2; p "we are not qwerqwerqwer frabjous"; xob();
  br (-2); p "endif";;
