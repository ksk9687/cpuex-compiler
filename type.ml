type t = (* MinCaml�η���ɽ������ǡ����� (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* ���������ѿ����� *)

let rec string_of_t = function (* Type.t��ʸ������Ѵ� *)
  | Unit -> "Unit"
  | Bool -> "Bool"
  | Int -> "Int"
  | Float -> "Float"
  | Fun (args, t) ->
      "Fun : "
      ^ (List.fold_left (fun x y -> x ^ " " ^ (string_of_t y)) "" args)
      ^ " -> " ^ (string_of_t t)
  | Tuple (head :: rest) ->
      (List.fold_left (fun x y -> x ^ " " ^ (string_of_t y)) (string_of_t head) rest)
  | Array (t) -> (string_of_t t) ^ " Array"
  | Var (top) -> (
      match !top with 
			| None -> "None"
			| Some t -> string_of_t t
			)
	| _ -> assert false
