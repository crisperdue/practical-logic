(* Association list implementation of finite partial functions *)
(* This does not support testing equality.                     *)

(* ------------------------------------------------------------------------- *)
(* Undefined function.                                                       *)
(* ------------------------------------------------------------------------- *)

let undefined = [];;

let mapf f al =
  map (fun (k, v) -> (k, f v)) al;;

(* ------------------------------------------------------------------------- *)
(* Mapping to sorted-list representation of the graph, domain and range.     *)
(* ------------------------------------------------------------------------- *)

let graph f = setify f;;

let dom f = setify (map fst f);;

let ran f = setify (map snd f);;

(* ------------------------------------------------------------------------- *)
(* Application.                                                              *)
(* ------------------------------------------------------------------------- *)

let rec applyd f d k =
  match f with
  | (x,y)::t -> if x = k then y else applyd t d k
  | [] -> d k;;

let apply f = applyd f (fun x -> failwith "apply");;

let tryapplyd f a d = applyd f (fun x -> d) a;;

let tryapplyl f x = tryapplyd f x [];;

let defined f x = try apply f x; true with Failure _ -> false;;

(* ------------------------------------------------------------------------- *)
(* Undefinition.                                                             *)
(* ------------------------------------------------------------------------- *)

(* Returns the tail of the list whose head has key equal to k; else [] *)
let rec assoc_tail k lis =
  match lis with
  | [] -> []
  | (k1, _)::tail -> if k1 = k then lis else assoc_tail k tail;;

let rec undefine k lis =
  (* Assumes that "tail" is a non-empty structural tail of super,
     returning a list like super, but omitting the head of the tail. *)
  let rec omit tail super =
    if tail == super then tl tail
    else hd super :: omit tail (tl super) in
  let tail = assoc_tail k lis in
  if tail = [] then lis
  else omit tail lis;;

(* ------------------------------------------------------------------------- *)
(* Redefinition and combination.                                             *)
(* ------------------------------------------------------------------------- *)

let (|->) x y = fun oth -> (x, y)::oth;;

(* ------------------------------------------------------------------------- *)
(* Special case of point function.                                           *)
(* ------------------------------------------------------------------------- *)

let (|=>) = fun x y -> (x |-> y) undefined;;

(* ------------------------------------------------------------------------- *)
(* Idiom for a mapping zipping domain and range lists.                       *)
(* ------------------------------------------------------------------------- *)

let fpf xs ys = itlist2 (|->) xs ys undefined;;

(* ------------------------------------------------------------------------- *)
(* Grab an arbitrary element.                                                *)
(* ------------------------------------------------------------------------- *)

let rec choose t =
  match t with
  | hd::_ -> hd
  | _ -> failwith "choose: completely undefined function";;

