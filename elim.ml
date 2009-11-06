open KNormal

let noeffectfun =
  S.of_list
    ["create_array"; "sqrt"; "fabs"; "floor"; "float_of_int"; "int_of_float"; "div2"]

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

let rec g env = function (* 不要定義削除ルーチン本体 (caml2html: elim_f) *)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let((x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = g env e1 in
      let e2' = g env e2 in
      if effect env e1' || S.mem x (fv e2') then Let((x, t), e1', e2') else (
(*      Format.eprintf "eliminating variable %s@." x;*)
       e2')
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let e1' = g env e1 in
      let env' = if effect_fun x env e1' then env else S.add x env in
      let e2' = g env' e2 in
      if S.mem x (fv e2') then
	LetRec({ name = (x, t); args = yts; body = e1' }, e2')
      else (
(*	Format.eprintf "eliminating function %s@." x; *)
	 e2')
  | LetTuple(xts, y, e) ->
      let xs = List.map fst xts in
      let e' = g env e in
      let live = fv e' in
      if List.exists (fun x -> S.mem x live) xs then LetTuple(xts, y, e') else
      (Format.eprintf "eliminating variables %s@." (Id.pp_list xs);
       e')
  | e -> e

let f = g S.empty
