open KNormal

let threshold = ref 0
let threshold2 = ref 0

let noInline = ["write"; "read_int"; "read_float"; "create_array_int"; "create_array_float"]

let counts = ref M.empty

let rec count depth = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) ->
      count depth e1;
      count depth e2
  | LetRec({ body = e1 }, e2) ->
     	count (depth + 1) e1;
      count depth e2
  | LetTuple(_, _, e) ->
      count depth e
  | App(x, _) ->
      let n = try M.find x !counts with Not_found -> 0 in
      counts := M.add x (n + depth) !counts
  | _ -> ()

let rec size = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) | LetRec({ body = e1 }, e2) ->
      1 + size e1 + size e2
  | LetTuple(_, _, e) -> 1 + size e
(*  | ExtFunApp(x, _) when List.mem x noInline -> 1000 *)
  | App _ | ExtFunApp _ -> 10
  | _ -> 1

let rec hasIO io = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) | LetRec({ body = e1 }, e2) ->
      hasIO io e1 || hasIO io e2
  | LetTuple(_, _, e) -> hasIO io e
  | ExtFunApp(x, _) when List.mem x noInline -> true
  | App(x, _) -> S.mem x io
  | _ -> false

let rec seq dest e1 e2 =
  match e1 with
    | Let(xt, e1', e2') -> Let(xt, e1', seq dest e2' e2)
    | LetRec(f, e2') -> LetRec(f, seq dest e2' e2)
    | LetTuple(xts, y, e2') -> LetTuple(xts, y, seq dest e2' e2)
    | e -> Let(dest, e, e2)

let rec g io env = function
  | Let(xt, IfEq(x, y, e1, e2), cont) when size cont < !threshold2 ->
      (*Format.eprintf "InlineCont %d@." (size cont);*)
      IfEq(x, y, seq xt e1 cont, Alpha.g M.empty (seq xt e2 cont))
      (*IfEq(x, y, seq xt e1 cont, seq xt e2 cont)*)
  | Let(xt, IfLE(x, y, e1, e2), cont) when size cont < !threshold2 ->
      (*Format.eprintf "InlineCont %d@." (size cont);*)
      IfLE(x, y, seq xt e1 cont, Alpha.g M.empty (seq xt e2 cont))
      (*IfLE(x, y, seq xt e1 cont, seq xt e2 cont)*)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g io env e1, g io env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g io env e1, g io env e2)
  | Let(xt, e1, e2) -> Let(xt, g io env e1, g io env e2)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let count = try M.find x !counts with Not_found -> 100 in
      let env =
        if (!threshold = 0 || count > 1 || S.mem x (fv e1)) && (hasIO io e1 || size e1 > !threshold * (if S.mem x (fv e1) then 1 else 2)) then env
        else M.add x (yts, e1) env in
      let io = if hasIO io e1 then S.add x io else io in
      LetRec({ name = (x, t); args = yts; body = g io env e1}, g io env e2)
  | App(x, ys) when M.mem x env ->
      let (zs, e) = M.find x env in
(*      Format.eprintf "inlining %s@." x;*)
      let env' = List.fold_left2
        (fun env' (z, t) y -> M.add z y env'
        ) M.empty zs ys in
      Alpha.g env' e
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g io env e)
  | e -> e

let f e =
  Format.eprintf "Before: %d@." (size e);
  counts := M.empty;
  count 1 e;
  let e = g S.empty M.empty e in
  Format.eprintf "After : %d@." (size e);
  e
