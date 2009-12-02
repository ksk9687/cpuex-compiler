type t =
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None)

let rec string_of_t = function
	| Unit -> "Unit"
	| Bool -> "Bool"
	| Int -> "Int"
	| Float -> "Float"
	| Fun(ts, t) -> String.concat " -> " (List.map string_of_t (ts@[t]))
	| Tuple(ts) -> "(" ^ (String.concat " * " (List.map string_of_t ts)) ^ ")"
	| Array(t) -> (string_of_t t) ^ " array"
	| Var(t') ->
		match !t' with
			| None -> "None"
			| Some(t) -> string_of_t t
