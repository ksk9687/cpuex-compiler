open KNormal
(* customized version of Map *)

let no_effect_fun = ref S.empty

module CM =(* CSE用のMap KNormal.tをkeyとする *)
  Map.Make
    (struct
      type t = KNormal.t
      let compare = compare
    end)
include CM

(* 式と番号の対応関係 *)
let tagenv = ref CM.empty

let tag = ref 0

let newtag () =
  tag := !tag + 1;
  string_of_int !tag


(* 式に対して番号を返す *)

let rec number e = 
  let find key =
    try CM.find key !tagenv
    with Not_found ->
      let tag = newtag() in
	(tagenv := CM.add key tag !tagenv; tag) in
  let v x = (* 変数の番号 *)
    find (Var(x)) in
  match e with
    | Unit | Int(_) | Float(_) -> find e
    | Neg(x) -> find (Neg(v x))
    | Add(x, y) ->
	let x = v x in
	let y = v y in
	  if x < y then find (Add(x, y))
	  else find (Add(y, x))
    | Sub(x, y) -> find (Sub(v x, v y))
    | SLL(x, i) -> find (SLL(v x, i))
    | FNeg(x) -> find (FNeg(v x))
    | FInv(x) -> find (FInv(v x))
    | FAdd(x, y) ->
	let x = v x in
	let y = v y in
	  if x < y then find (FAdd(x, y))
	  else find (FAdd(y, x))
    | FSub(x, y) -> find (FSub(v x, v y))
    | FMul(x, y) ->
	let x = v x in
	let y = v y in
	  if x < y then find (FMul(x, y))
	  else find (FMul(y, x))
    | IfEq(x, y, e1, e2) ->
	find (IfEq(v x, v y, 
		   Var(number e1),
		   Var(number e2)))
    | IfLE(x, y, e1, e2) ->
	find (IfLE(v x, v y,
		   Var(number e1),
		   Var(number e2)))
    | Var(x) -> v x
    | App(x, ys) ->
	if S.mem x !no_effect_fun then
	  find (App(v x, List.map (fun y -> v y) ys))
	else newtag()
    | Tuple(xs) -> find (Tuple(List.map (fun x -> v x) xs))
    | ExtArray(x) -> find (ExtArray(v x))
    | ExtFunApp(x, ys) ->
	if S.mem x !no_effect_fun then
	  find (ExtFunApp(v x, List.map (fun y -> v y) ys))
	else newtag()
    | Let((x, t), e1, e2) ->
	let num = number e1 in
	  tagenv := CM.add (Var(x)) num !tagenv;
	  number e2
    | LetTuple (xts, y, e) ->
	ignore (List.fold_left
		  (fun num (x,_) -> tagenv := CM.add (Var(x)) (y ^ string_of_int num) !tagenv; num + 1)
		   0
		   xts); (* y という Tuple に対して n 番目の要素を "yn" と番号づけする *)
	number e
    | Get(x,y) -> find (Get (v x, v y))
    | _ -> newtag() (* Get,Put *)




let rec hasapp = function
  | App _ | ExtFunApp _ -> true
  | IfEq (_, _, e1, e2) | IfLE (_, _, e1, e2) | Let (_, e1, e2)
      -> (hasapp e1 || hasapp e2)
  | LetTuple (_, _, e) -> hasapp e
  | _ -> false


(* Putや関数適用があった場合、以前までのGetに対する番号づけを削除 *)
let remove_get () =
  tagenv := CM.fold (fun x _ env -> match x with Get _ -> CM.remove x env | _ -> env) !tagenv !tagenv
      
let remove_extarray env =
  CM.fold (fun key tag a -> match key with ExtArray _ -> M.remove tag a | _ -> a) !tagenv env

let find e env =
  try Var(M.find (number e) env)
  with Not_found -> e


let rec g env = function
  | Unit | Float _ | Int _ | Neg _ | Add _ | Sub _ | SLL _ | Var _ | Tuple _
  | FNeg _ | FAdd _ | FSub _ | FMul _ | FInv _ |  Get _ | ExtArray _ as e ->
      find e env
  | App _ | ExtFunApp _ as e -> remove_get(); find e env
  | Put _ as e -> remove_get() ; e
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let((x, t), e1, e2) ->
      let e1' = g env e1 in
      let num = number e1' in
      let env' = remove_extarray env in
      tagenv := CM.add (Var(x)) num !tagenv;
      let e2' =
	if hasapp e1' then
	  if Movelet.effect !no_effect_fun e1' then g env' e2
	  else g ((M.add num x) env') e2
        else g ((M.add num x) env) e2
      in
      Let((x, t), e1', e2')
  | LetRec({ name = xt; args = yts; body = e1 }, e2) ->
      if not (Movelet.effect_fun (fst xt) !no_effect_fun e1) then
	      no_effect_fun := S.add (fst xt) !no_effect_fun;
      LetRec({ name = xt; args = yts; body = g M.empty e1 }, g env e2)
  | LetTuple (xts, y, e) ->
      ignore (List.fold_left
		(fun num (x,_) -> tagenv := CM.add (Var(x)) (y ^ string_of_int num) !tagenv; num + 1)
		0
		xts); (* y という Tuple に対して n 番目の要素を "yn" と番号づけする *)
      LetTuple (xts, y, g env e)

let f x =
  no_effect_fun := Movelet.noeffectfun;
  g M.empty x

