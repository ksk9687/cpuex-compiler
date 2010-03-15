type len =
  | Variable
  | Const of int
  | LVar of len option ref

let genlen () = LVar(ref None)

type t =
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t
  | Tuple of t list
  | Array of t * len
  | Var of t option ref

let gentyp () = Var(ref None)

let rec string_of_len = function
  | Variable -> ""
  | Const(i) -> string_of_int i
  | LVar({ contents = Some(i) }) -> "_" ^ (string_of_len i)
  | _ -> "?"

let rec string_of_t = function
	| Unit -> "unit"
	| Bool -> "bool"
	| Int -> "int"
	| Float -> "float"
	| Fun(ts, t) -> String.concat " -> " (List.map string_of_t (ts @ [t]))
	| Tuple(ts) -> "(" ^ (String.concat ", " (List.map string_of_t ts)) ^ ")"
	| Array(t, i) -> (string_of_t t) ^ "[" ^ (string_of_len i) ^ "]"
	| Var(t') ->
		match !t' with
			| None -> "None"
			| Some(t) -> string_of_t t

let rec remove_len len = function
  | Fun(t1s, t2) -> Fun(List.map (remove_len false) t1s, (remove_len false) t2)
  | Tuple(ts) -> Tuple(List.map (remove_len false) ts)
  | Array(t, i) -> Array(remove_len true t, if len then Variable else i)
  | t -> t
