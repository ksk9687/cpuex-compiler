type t = (* MinCamlの型を表現するデータ型 (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* 新しい型変数を作る *)

let rec string_of_t = function (* Type.tを文字列に変換 *)
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
