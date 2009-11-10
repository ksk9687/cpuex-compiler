type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | SLL of t * int
  | FNeg of t
  | FInv of t
  | FAdd of t * t
  | FSub of t * t
  | FMul of t * t
  | Eq of t * t
  | LE of t * t
  | If of t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of t * t list
  | Tuple of t list
  | LetTuple of (Id.t * Type.t) list * t * t
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

(*
let rec string_t indent = function
  | Unit -> "Unit"
  | Bool (b)   -> indent ^ "Bool(" ^ (string_of_bool b) ^ ")\n"
  | Int (i)    -> indent ^ "Int(" ^ (string_of_int i) ^ ")\n"
  | Float (f)  -> indent ^ "Float(" ^ (string_of_float f) ^ ")\n"
  | Not (t)    -> indent ^ "Not\n" ^ string_t (indent ^ "  ") t
  | Neg (t)    -> indent ^ "Neg\n" ^ string_t (indent ^ "  ") t
  | Add (t,u)  ->
      indent ^ "Add\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | Sub (t,u)  -> 
      indent ^ "Sub\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | FNeg (t)   -> indent ^ "FNeg\n" ^ string_t (indent ^ "  ") t
  | FAdd (t,u) -> 
      indent ^ "FAdd\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | FSub (t,u) -> 
      indent ^ "FSub\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | FMul (t,u) -> 
      indent ^ "FMul\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | FDiv (t,u) -> 
      indent ^ "FDiv\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | Eq (t,u)   -> 
      indent ^ "Eq\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | LE (t,u)   -> 
      indent ^ "LE\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | If (t,u,v) ->
      indent ^ "If\n" ^ (string_t (indent ^ "  ") t)
      ^ (string_t (indent ^ "  ") u) ^ (string_t (indent ^ "  ") v)
  | Let ((i,t),u,v) ->
      indent ^ "Let\n" ^ indent ^ "  " ^ i ^ " : " ^ (Type.string_of_t t)
      ^ "\n" ^ (string_t (indent ^ "  ") u)
      ^ indent ^ "In\n"  ^ (string_t (indent ^ "  ") v)
  | Var (i) -> indent ^ "Var(" ^ i ^ ")\n"
  | LetRec (fundef, t) ->
      indent ^ "LetRec\n"
      ^ string_fundef (indent ^ "  ") fundef
      ^ indent ^ "In\n"  ^ (string_t (indent ^ "  ") t)
  | App (t, list) ->
      indent ^ "App\n"  ^ (string_t (indent ^ "  ") t)
      ^ List.fold_left (fun x y -> x ^ (string_t (indent ^ "  ") y)) "" list
  | Tuple (list) ->
      indent ^ "Tuple\n"
      ^ List.fold_left (fun x y -> x ^ (string_t (indent ^ "  ") y)) "" list
  | LetTuple (list, u, v) ->
      indent ^ "Let\n" ^ indent ^ "  Tuple\n"
      ^ List.fold_left (fun x (i,y) -> x ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t y) ^"\n")
  "" list
      ^ (string_t (indent ^ "  ") u)
      ^ "In\n"  ^ (string_t (indent ^ "  ") v)
  | Array (t,u) ->
      indent ^ "Array\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | Get (t,u) ->
      indent ^ "Get\n" ^ (string_t (indent ^ "  ") t) ^ (string_t (indent ^ "  ") u)
  | Put (t,u,v) ->
      indent ^ "Put\n" ^ (string_t (indent ^ "  ") t)
      ^ (string_t (indent ^ "  ") u) ^ (string_t (indent ^ "  ") v)

and string_fundef indent {name = (i,t); args = list; body = b} =
  indent ^ "Fun\n"
  ^ indent ^ "  Name\n" ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t t) ^ "\n"
  ^ indent ^ "  Args\n"
  ^ List.fold_left (fun x (i,y) -> x ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t y) ^"\n") "" list
  ^ indent ^ "  Body\n"
  ^ (string_t (indent ^ "    ") b)

let rec string t = (* Syntax.tを出力 *)
  print_string (string_t "" t);;
*)
