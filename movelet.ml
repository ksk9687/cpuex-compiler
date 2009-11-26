open KNormal

(* elimを改造して、let式の位置の最適化を行った *)

let noeffectfun =
  S.of_list
    ["sqrt"; "fneg"; "fabs"; "floor"; "float_of_int"; "int_of_float"]

let rec effect env = function (* 副作用の有無 (caml2html: elim_effect) *)
  | Let(_, e1, e2) | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) -> effect env e1 || effect env e2
  | LetRec({name=(x,_);body=e1}, e2) ->
      if effect_fun x env e1 then effect env e2 else effect (S.add x env) e2
  | LetTuple(_, _, e) -> effect env e
  | App (x,_) -> not (S.mem x env)
  | ExtFunApp (x,_) -> not (S.mem x noeffectfun)
  | Put _  -> true
  | _ -> false
and effect_fun id env exp =
  if effect (S.add id env) exp then
    effect env exp
  else false

(* let x を削除 *)
let rec remove x = function
  | Let ((x',t),e1,e2)  -> if x = x' then remove x e2 else Let ((x',t),remove x e1,remove x e2)
  | IfEq (y,z,e1,e2) -> IfEq (y,z,remove x e1,remove x e2)
  | IfLE (y,z,e1,e2) -> IfLE (y,z,remove x e1,remove x e2)
  | LetRec ({body = e1} as fundef, e2) ->
      LetRec ({fundef with body = remove x e1}, remove x e2)
  | LetTuple (xts, y, e) -> LetTuple (xts, y, remove x e)
  | e -> e

(* xsのlet式を追加 *)
let rec insert env xs e =
  let xs', e' =
    S.fold
      (fun x (xs',e2) ->
	 try let (t,e1) = M.find x env in
	   (S.union (fv e1) xs'), Let((x,t), e1, remove x e2)
	 with Not_found -> xs', e2)
      xs (S.empty,e) in
    if e = e' then e'
    else insert env xs' e'

(* 定義される変数の集合を返す *)
let rec find = function
  | Let ((x,t),e1,e2)  -> S.add x (S.union (find e1) (find e2))
  | IfEq (_,_,e1,e2) | IfLE (_,_,e1,e2) | LetRec ({body = e1} , e2) ->
      S.union (find e1) (find e2)
  | LetTuple (_,_, e) -> find e
  | e -> S.empty


let rec g env letenv = function
  | IfEq(x, y, e1, e2) ->
      let e1' = g env letenv e1 in
      let e2' = g env letenv e2 in
      let xs = S.add x (S.add y (*S.empty*) (S.inter (find e1') (find e2'))) in
	insert letenv xs (IfEq(x, y, e1', e2'))
  | IfLE(x, y, e1, e2) ->
      let e1' = g env letenv e1 in
      let e2' = g env letenv e2 in
      let xs = S.add x (S.add y (*S.empty*) (S.inter (find e1') (find e2'))) in
	insert letenv xs (IfLE(x, y, e1', e2'))
  | Let((x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = (*g env M.empty*) e1 in
	if effect env e1' then
	  insert letenv (fv e1') (Let((x,t), e1', g env letenv e2))
	else g env (M.add x (t,e1) letenv) e2
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let env' =
	if effect_fun x env e1 then env	else S.add x env in
      let e1' = g env' M.empty e1 in
      let e2' = g env' letenv e2 in
      let xs = fv e1 in
      if S.mem x (fv e2') then
	let e = LetRec({ name = (x, t); args = yts; body = e1' }, e2') in
	  insert letenv xs e
      else (
(*	Format.eprintf "eliminating function %s@." x; *)
	e2')
  | LetTuple(xts, y, e) ->
      let e' = g env letenv e in
      let live = fv e' in
      let xs = List.map fst xts in
	if List.exists (fun x -> S.mem x live) xs then
	  insert letenv (fv (LetTuple(xts, y, e'))) (LetTuple(xts, y, e'))
	else
	  (
     (*Format.eprintf "eliminating variables %s@." (Id.pp_list xs);*)
	   insert letenv (fv e') e')
  | e ->
      insert letenv (fv e) e


let f  =  g S.empty M.empty

