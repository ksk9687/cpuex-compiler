type t = string

let lib = ref false

let rec pp_list = function
  | [] -> ""
  | [x] -> x
  | x :: xs -> x ^ " " ^ pp_list xs

let counter = ref 0
let genid s =
  incr counter;
  let s =
    try String.sub s 0 (String.index s '.')
    with Not_found -> s in
  if !lib then Printf.sprintf "%s._%d" s !counter
  else Printf.sprintf "%s.%d" s !counter

let rec id_of_typ = function
  | Type.Unit -> "u"
  | Type.Bool -> "b"
  | Type.Int -> "i"
  | Type.Float -> "d"
  | Type.Fun _ -> "f"
  | Type.Tuple _ -> "t"
  | Type.Array _ -> "a" 
  | Type.Var _ -> assert false
let gentmp typ =
  genid ("T" ^ (id_of_typ typ))

let name s =
  try String.sub s 0 (String.index s '.')
  with Not_found ->
    if Util.startWith s "ext_" then String.sub s 4 ((String.length s) - 4)
    else s
