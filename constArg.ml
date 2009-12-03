open KNormal

let constArgs = ref M.empty

let str = function
  | Int(i) -> string_of_int i
  | Float(f) -> string_of_float f
  | ExtArray(a) -> a
  | Var(_) | Unit -> "None"
  | _ -> assert false

let mem x env =
  try (match M.find x env with Unit | Int(_) | Float(_) | ExtArray(_) -> true | _ -> false)
  with Not_found -> false

let rec setConstArgs env = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) ->
      setConstArgs env e1;
      setConstArgs env e2
  | Let((x, t), e1, e2) ->
      setConstArgs env e1;
      setConstArgs (M.add x e1 env) e2
  | LetRec({ name = (x, _); args = ys; body = e1 }, e2) ->
      let zs = fv e1 in
      constArgs := M.add x (List.map (fun (y, _) -> if S.mem y zs then (0, Unit) else (3, Var(y))) ys) !constArgs;
      setConstArgs env e1;
      setConstArgs env e2
  | App(x, ys) ->
      let zs = M.find x !constArgs in
      let zs = List.map2
                 (fun y (n, z) ->
                    if n = 3 then (3, z)
                    else if mem y env then
                      let y' = M.find y env in
                      if n = 0 || n = 1 && y' = z then (1, y') else (2, z)
                    else (2, z)
                 ) ys zs in
      constArgs := M.add x zs !constArgs
  | LetTuple(_, _, e) ->
      setConstArgs env e
  | _ -> ()

let rec g = function
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g e1, g e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g e1, g e2)
  | Let((x, t), e1, e2) -> Let((x, t), g e1, g e2)
  | LetRec({ name = (x, Type.Fun(ts, t)); args = ys; body = e1 }, e2) ->
      let (ys', e1') = List.fold_right2
                 (fun y (n, v) (ys, e) ->
                    if n = 1 || n = 3 then (Format.eprintf "Const: %s->%s=%s@." x (fst y) (str v); (ys, Let(y, v, e)))
                    else (y :: ys, e))
                 ys (M.find x !constArgs) ([], e1) in
      (*if ys' <> ys then Format.eprintf "%s@." (Type.string_of_t (Type.Fun(List.map snd ys', t)));*)
      LetRec({ name = (x, Type.Fun(List.map snd ys', t)); args = ys'; body = g e1' }, g e2)
  | App(x, ys) ->
      App(x, List.fold_right2 (fun y (n, _) ys -> if n = 1 || n = 3 then ys else y :: ys) ys (M.find x !constArgs) [])
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g e)
  | e -> e

let f x =
  constArgs := M.empty;
  setConstArgs M.empty x;
  g x
