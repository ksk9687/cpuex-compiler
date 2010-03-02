open KNormal

let threshold = ref 0
let threshold2 = ref 0

let rec size = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2)
  | Let(_, e1, e2) | LetRec({ body = e1 }, e2) -> 1 + size e1 + size e2
  | LetTuple(_, _, e) -> 1 + size e
  | App _ | ExtFunApp _ -> 10
  | _ -> 1

let rec seq dest e1 e2 =
  match e1 with
    | Let(xt, e1', e2') -> Let(xt, e1', seq dest e2' e2)
    | LetRec(f, e2') -> LetRec(f, seq dest e2' e2)
    | LetTuple(xts, y, e2') -> LetTuple(xts, y, seq dest e2' e2)
    | e -> Let(dest, e, e2)

let rec g env = function
  | Let(xt, IfEq(x, y, e1, e2), cont) when size cont < !threshold2 ->
      (*Format.eprintf "InlineCont %d@." (size cont);*)
      IfEq(x, y, seq xt e1 cont, Alpha.g M.empty (seq xt e2 cont))
      (*IfEq(x, y, seq xt e1 cont, seq xt e2 cont)*)
  | Let(xt, IfLE(x, y, e1, e2), cont) when size cont < !threshold2 ->
      (*Format.eprintf "InlineCont %d@." (size cont);*)
      IfLE(x, y, seq xt e1 cont, Alpha.g M.empty (seq xt e2 cont))
      (*IfLE(x, y, seq xt e1 cont, seq xt e2 cont)*)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let(xt, e1, e2) -> Let(xt, g env e1, g env e2)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let env = if size e1 > !threshold * (if S.mem x (fv e1) then 1 else 2) then env else M.add x (yts, e1) env in
      LetRec({ name = (x, t); args = yts; body = g env e1}, g env e2)
  | App(x, ys) when M.mem x env ->
      let (zs, e) = M.find x env in
(*      Format.eprintf "inlining %s@." x;*)
      let env' =
        List.fold_left2
          (fun env' (z, t) y -> M.add z y env')
          M.empty
          zs
          ys in
      Alpha.g env' e
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env e)
  | e -> e

let f e =
  Format.eprintf "Before: %d@." (size e);
  let e = g M.empty e in
  Format.eprintf "After : %d@." (size e);
  e
