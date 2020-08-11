(* ========================================================================= *)
(* Unification for first order terms.                                        *)
(*                                                                           *)
(* Copyright (c) 2003-2007, John Harrison. (See "LICENSE.txt" for details.)  *)
(* ========================================================================= *)

let rec istriv env x t =
  match t with
    Var y -> y = x or defined env y & istriv env x (apply env y)
  | Fn(f,args) -> exists (istriv env x) args & failwith "cyclic";;

(* ------------------------------------------------------------------------- *)
(* Main unification procedure                                                *)
(* ------------------------------------------------------------------------- *)

let rec unify env eqs =
  match eqs with
    [] -> env
  | (Fn(f,fargs),Fn(g,gargs))::oth ->
        if f = g & length fargs = length gargs
        then unify env (zip fargs gargs @ oth)
        else failwith "impossible unification"
  | (Var x,t)::oth | (t,Var x)::oth ->
        if defined env x then unify env ((apply env x,t)::oth)
        else unify (if istriv env x t then env else (x|->t) env) oth;;

(* ------------------------------------------------------------------------- *)
(* Solve to obtain a single instantiation.                                   *)
(* ------------------------------------------------------------------------- *)

let rec solve env =
  let env' = mapf (tsubst env) env in
  if env' = env then env else solve env';;

(* ------------------------------------------------------------------------- *)
(* Unification reaching a final solved form (often this isn't needed).       *)
(* ------------------------------------------------------------------------- *)

let fullunify eqs = solve (unify undefined eqs);;

(* ------------------------------------------------------------------------- *)
(* Examples.                                                                 *)
(* ------------------------------------------------------------------------- *)

let unify_and_apply eqs =
  let i = fullunify eqs in
  let apply (t1,t2) = tsubst i t1,tsubst i t2 in
  map apply eqs;;

START_INTERACTIVE;;
unify_and_apply [<<|f(x,g(y))|>>,<<|f(f(z),w)|>>];;

unify_and_apply [<<|f(x,y)|>>,<<|f(y,x)|>>];;

(****  unify_and_apply [<<|f(x,g(y))|>>,<<|f(y,x)|>>];; *****)

unify_and_apply [<<|x_0|>>,<<|f(x_1,x_1)|>>;
                 <<|x_1|>>,<<|f(x_2,x_2)|>>;
                 <<|x_2|>>,<<|f(x_3,x_3)|>>];;

let cyclic() = "cyclic" |=> parse_term "0";;

fullunify [parse_term "x", parse_term "x"];;

fullunify [parse_term "p(X,Y)", parse_term "p(Y,X)"];;

(* Makes solve do some work. *)
fullunify [parse_term "p(x,x)", parse_term "p(y,0)"];;

try fullunify [parse_term "p(x,x)", parse_term "p(y,f(y))"]
with Failure _ ->  cyclic();;

fullunify [parse_term "p(X,Y,2)", parse_term "p(Y,X,X)"];;

try fullunify [parse_term "Q(a, x, f(x))", parse_term "Q(2, y, y)"]
with Failure _ -> cyclic();;

fullunify [parse_term "Q(x, y, z)", parse_term "Q(u, h(v, v), u)"];;

fullunify [parse_term "q(p(X,Y),p(Y,X))", parse_term "q(Z,Z)"];;

(* This one gives "solve" some work to do. *)
let expander = [
  (parse_term "x"),(parse_term "f(y,y)");
  (parse_term "y"),(parse_term "f(z,z)");
  (parse_term "z"),(parse_term "f(w,w)")];;

unify undefined expander;;

fullunify expander;;
END_INTERACTIVE;;
