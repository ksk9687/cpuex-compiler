open KNormal

let off = ref false

exception Orz

let check i x ys =
  let (_, r) = List.fold_left (fun (j, b) y -> (j + 1, b && (i = j || y <> x))) (0, true) ys in
  r

let rec checkTuple f j x = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) ->
      checkTuple f j x e1 || checkTuple f j x e2
  | LetRec({ name = (x, _); args = ys; body = e1 }, e2) ->
      checkTuple f j x e2
  | LetTuple(_, x', _) when x' = x -> true
  | LetTuple(_, _, e) -> checkTuple f j x e
  | Var(x') when x = x' -> raise Orz
  | App(f', xs) when (f' <> f || not (check j x xs)) && List.mem x xs -> raise Orz
  | ExtFunApp(_, xs) when List.mem x xs -> raise Orz
  | _ -> false

let rec checkArray f j x env = function
  | Let((y, _), Int(i), e) ->
      checkArray f j x (M.add y i env) e
  | Let((y, _), Var(z), e) when M.mem z env ->
      checkArray f j x (M.add y (M.find z env) env) e
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) ->
      (checkArray f j x env e1) @ (checkArray f j x env e2)
  | LetRec({ name = (x, _); args = ys; body = e1 }, e2) ->
      checkArray f j x env e2
  | LetTuple(_, _, e) -> checkArray f j x env e
  | Get(x', i) when x' = x && M.mem i env -> [M.find i env]
  | Get(x', _) when x' = x -> raise Orz
  | Put(x', _, _) when x' = x -> raise Orz
  | Var(x') when x = x' -> raise Orz
  | App(f', xs) when (f' <> f || not (check j x xs)) && List.mem x xs -> raise Orz
  | ExtFunApp(_, xs) when List.mem x xs -> raise Orz
  | _ -> []

let rec g load tuple array const = function
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g load tuple array const e1, g load tuple array const e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g load tuple array const e1, g load tuple array const e2)
  | Let((x, t), Int(i), e) -> Let((x, t), Int(i), g load tuple array (M.add x i const) e)
  | Let(xt, e1, e2) -> Let(xt, g load tuple array const e1, g load tuple array const e2)
  | LetRec({ name = (x, Type.Fun(at, rt)); args = ys; body = e1 }, e2) ->
      let (ld, tu, ar, args, _) =
        List.fold_right
          (fun (y, t) (ld, tu, ar, args, j) ->
            try (
            match t with
              | Type.Tuple(ts) when checkTuple x j y e1 ->
                  Format.eprintf "LoadArgs: %s: %s@." x y;
                  let (_, vs) = List.fold_left
                    (fun (i, vs) t ->
                      (i + 1, vs @ [Id.genid (Printf.sprintf "%s(%d)" (Id.name y) i)])
                    ) (0, []) ts in
                  let ld' = fun y (lets, args) ->
                    let vs = List.map (fun t -> Id.genid ("<" ^ (Id.name y) ^ ">")) ts in
                    ((fun e -> LetTuple(List.combine vs ts, y, lets e)), vs @ args) in
                  (ld' :: ld, M.add y vs tu, ar, (List.combine vs ts) @ args, j - 1)
              | Type.Array(t', _) ->
                  let ids = List.sort (fun a b -> a - b) (Util.unique (checkArray x j y M.empty e1)) in
                  if (List.length ids) > 0 then Format.eprintf "LoadArgs: %s: %s[%s]@." x y (String.concat ", " (List.map (fun i -> string_of_int i) ids));
                  let (ld', vs, args) = List.fold_right
                    (fun i (ld, vs, args) ->
                      let v = Id.genid (Printf.sprintf "%s[%d]" (Id.name y) i) in
                      let ld' = fun y (lets, args) ->
                        let v = Id.genid (Printf.sprintf "%s[%d]" (Id.name y) i) in
                        let (lets, args) = ld y (lets, args) in
                        let j = Id.gentmp Type.Int in
                        ((fun e -> Let((j, Type.Int), Int(i), Let((v, t'), Get(y, j), lets e))), v :: args) in
                      (ld', (i, v) :: vs, (v, t') :: args)
                    ) ids ((fun y (lets, args) -> (lets, args)), [], args) in
                  (ld' :: ld, tu, M.add y vs ar, args, j - 1)
              | _ -> ((fun y (lets, args) -> (lets, y :: args)) :: ld, tu, ar, (y, t) :: args, j - 1)
            ) with Orz -> ((fun y (lets, args) -> (lets, y :: args)) :: ld, tu, ar, (y, t) :: args, j - 1)
          ) ys ([], M.empty, M.empty, [], (List.length ys) - 1) in
      let load = M.add x ld load in
      if args <> ys then (
	      Format.eprintf "%s: %s@." x (String.concat ", " (List.map fst ys));
	      Format.eprintf "%s: %s@." x (String.concat ", " (List.map fst args))
      );
      LetRec({ name = (x, Type.Fun(List.map snd args, rt)); args = args; body = g load tu ar M.empty e1 }, g load tuple array const e2)
  | App(x, ys) when M.mem x load ->
      let (lets, args) = List.fold_right2
        (fun ld y (lets, args) -> ld y (lets, args)
        ) (M.find x load) ys ((fun e -> e), []) in
      let e = lets (App("", args)) in
      let e = g load tuple array const e in
      let rec ch = function
        | App(_, args) -> App(x, args)
        | Let(xt, e1, e2) -> Let(xt, e1, ch e2)
        | LetTuple(xts, y, e) -> LetTuple(xts, y, ch e)
        | _ -> assert false in
      ch e
  | Get(x, y) ->
      (try Var(List.assoc (M.find y const) (M.find x array))
      with Not_found -> Get(x, y))
  | LetTuple(xts, y, e) ->
      (try
        let ys = M.find y tuple in
        List.fold_right2
          (fun xt y e ->
            Let(xt, Var(y), e)
          ) xts ys (g load tuple array const e)
      with Not_found -> LetTuple(xts, y, g load tuple array const e))
  | e -> e

let rec f e =
  if !off then e
  else g M.empty M.empty M.empty M.empty e
