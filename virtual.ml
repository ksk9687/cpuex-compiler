open Asm

let data = ref []

let expand xts ini add =
  List.fold_left
    (fun acc (x, t) ->
      match t with
      | Type.Unit -> acc
      | _ -> (fun (offset, acc) x t -> (offset + 1, add x t offset acc)) acc x t)
    ini
    xts

let rec g env = function
  | Closure.Unit -> Ans(Nop)
  | Closure.Int(i) -> Ans(Set(i))
  | Closure.Float(d) ->
      let l =
        try
          let (l, _) = List.find (fun (_, d') -> d = d') !data in
          l
        with Not_found ->
          let l = Id.L(Id.genid "f") in
          data := (l, d) :: !data;
          l
      in
      Ans(LdFL(l))
  | Closure.Neg(x) -> Ans(Sub(reg_i0, V(x)))
  | Closure.Add(x, y) -> Ans(Add(x, V(y)))
  | Closure.Sub(x, y) -> Ans(Sub(x, V(y)))
  | Closure.FNeg(x) -> Ans(FNeg(x))
  | Closure.FInv(x) -> Ans(FInv(x, Non))
  | Closure.FSqrt(x) -> Ans(FSqrt(x, Non))
  | Closure.FAbs(x) -> Ans(FAbs(x))
  | Closure.FAdd(x, y) -> Ans(FAdd(x, y, Non))
  | Closure.FSub(x, y) -> Ans(FSub(x, y, Non))
  | Closure.FMul(x, y) -> Ans(FMul(x, y, Non))
  | Closure.IfEq(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(IfEq(x, V(y), g env e1, g env e2))
      | Type.Float -> Ans(IfFEq(x, y, g env e1, g env e2))
      | _ -> failwith "equality supported only for bool, int, and float")
  | Closure.IfLE(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(IfLE(x, V(y), g env e1, g env e2))
      | Type.Float -> Ans(IfFLE(x, y, g env e1, g env e2))
      | _ -> failwith "inequality supported only for bool, int and float")
  | Closure.Let((x, t1), e1, e2) ->
      let e1' = g env e1 in
      let e2' = g (M.add x t1 env) e2 in
      concat e1' (x, t1) e2'
  | Closure.Var(x) ->
      (match M.find x env with
      | Type.Unit -> Ans(Nop)
      | _ -> Ans(Mov(x)))
  | Closure.AppDir(Id.L(x), ys) ->
      let xs = List.fold_left
        (fun ys x -> match M.find x env with
          | Type.Unit -> ys
          | _ -> ys @ [x]
        ) [] ys in
      Ans(CallDir(Id.L(x), xs))
  | Closure.Tuple(xs) ->
      let y = Id.genid "t" in
      let (offset, store) =
        expand
          (List.map (fun x -> (x, M.find x env)) xs)
          (0, Ans(Mov(y)))
          (fun x _ offset store -> seq(St(x, V(y), C(offset)), store)) in
      Let((y, Type.Tuple(List.map (fun x -> M.find x env) xs)), Mov(reg_hp),
          Let((reg_hp, Type.Int), Add(reg_hp, C(offset)),
              store))
  | Closure.LetTuple(xts, y, e2) ->
      let s = Closure.fv e2 in
      let (offset, load) =
        expand
          xts
          (0, g (M.add_list xts env) e2)
          (fun x t offset load ->
            if not (S.mem x s) then load else
            Let((x, t), Ld(V(y), C(offset)), load)) in
      load
  | Closure.Get(x, y) ->
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(_) -> Ans(Ld(V(x), V(y)))
      | _ -> assert false)
  | Closure.Put(x, y, z) ->
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(_) -> Ans(St(z, V(x), V(y)))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> Ans(SetL(Id.L(x)))

let h { Closure.name = (Id.L(x), t); Closure.args = yts; Closure.body = e } =
  let (_, _, xs, rs) = List.fold_left
    (fun (iregs, fregs, xs, rs) (x, t) -> match t with
      | Type.Unit -> (iregs, fregs, xs, rs)
      | Type.Float -> (iregs, List.tl fregs, xs @ [x], rs @ [List.hd fregs])
      | _ -> (List.tl iregs, fregs, xs @ [x], rs @ [List.hd iregs])
    ) (List.tl alliregs, List.tl allfregs, [], []) yts in
  match t with
  | Type.Fun(_, t2) ->
      let ret_reg = (match t2 with
        | Type.Unit -> "$dummy"
        | Type.Float -> List.hd allfregs
        | _ -> List.hd alliregs
      ) in
      fundata := M.add x { arg_regs = rs; ret_reg = ret_reg; reg_ra = "$ra"; use_regs = S.of_list allregs; need_ra = true } !fundata;
      { name = Id.L(x); args = xs; body = g (M.add x t (M.add_list yts M.empty)) e; ret = t2 }
  | _ -> assert false

let rec get_calls tail set = function
  | Ans(exp) -> get_calls' tail set exp
  | Let(_, exp, e) -> get_calls' false (get_calls tail set e) exp
  | Forget _ -> assert false
and get_calls' tail (same, diff) = function
  | CallDir(Id.L(x), _) when tail -> (S.add x same, diff)
  | CallDir(Id.L(x), _) -> (same, S.add x diff)
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      get_calls tail (get_calls tail (same, diff) e2) e1
  | _ -> (same, diff)

let connect x set sets =
  let set = (S.union (M.find x sets) set) in
  let set = S.fold
    (fun y set -> S.union (M.find y sets) set
    ) set set in
  M.mapi (fun y set' -> if S.mem y set then set else set') (M.add x set sets)

let rec pow diffs =
  let diffs2 = M.map (fun diff -> S.fold (fun x diff -> S.union (M.find x diffs) diff) diff diff) diffs in
  let same = M.fold (fun x diff same -> same && S.equal diff (M.find x diffs)) diffs2 true in
  if same then diffs
  else pow diffs2

let set_data' sames calls diffs (Id.L(x)) e =
  let (same, diff) = get_calls true (S.empty, S.empty) e in
  Format.eprintf "%s@.Tail: %s@.NonTail: %s@.@." x (String.concat ", " (S.elements same)) (String.concat ", " (S.elements diff));
  (connect x same sames, M.add x (S.add x (S.union same diff)) calls, M.add x diff diffs)
let set_data fundefs e =
  let sames = M.mapi (fun x _ -> S.singleton x) !fundata in
  let diffs = M.mapi (fun x _ -> S.empty) !fundata in
  let (sames, calls, diffs) = List.fold_left
    (fun (sames, calls, diffs) f -> set_data' sames calls diffs f.name f.body
    ) (set_data' sames diffs diffs e.name e.body) fundefs in
  let calls = pow calls in
  let diffs = M.map (fun call -> S.fold (fun x diff -> S.union (M.find x diffs) diff) call S.empty) calls in
(*
  let diffs = M.mapi
    (fun y _ -> S.fold (fun z diff -> S.union (M.find z diffs) diff) (M.find y sames) S.empty
    ) diffs in
  M.iter (fun x same -> Format.eprintf "%s: %s@." x (String.concat ", " (S.elements same))) sames;
  M.iter (fun x diff -> Format.eprintf "%s: %s@." x (String.concat ", " (S.elements diff))) diffs;
*)
  let fixed = M.fold
    (fun x _ fixed ->
      if List.exists (fun f -> f.name = Id.L(x)) fundefs then fixed
      else S.add x fixed
    ) !fundata S.empty in
  let _ = List.fold_left
    (fun fixed { name = Id.L(x) } ->
      let data = M.find x !fundata in
      let fs = S.filter (fun y -> S.mem y fixed) (M.find x sames) in
      let reg_ra =
        if S.is_empty fs then
          if S.mem x (M.find x diffs) then reg_ra
          else
	          try List.find (fun r -> not (S.exists (fun y -> r = get_reg_ra y) (M.find x diffs))) reg_ras
	          with Not_found -> reg_ra
        else
          let y = S.choose fs in
          get_reg_ra y in
      fundata := M.add x { data with reg_ra = reg_ra } !fundata;
      S.add x fixed
    ) fixed fundefs in
  List.iter
    (fun { name = Id.L(x) } ->
      let data = M.find x !fundata in
      if not (S.exists (fun y -> data.reg_ra = get_reg_ra y) (M.find x diffs)) then
        fundata := M.add x { data with need_ra = false } !fundata
    ) fundefs

let f (Closure.Prog(fundefs, e)) =
  data := [];
  fundata := builtInFuns;
  M.iter (fun x t -> match t with
      | Type.Fun(ts, y) when not (M.mem x !fundata) ->
          Format.eprintf "ExtFunction: %s@." (Id.name x);
          let args = List.map (fun t -> ("", t)) ts in
          let _ = h { Closure.name = (Id.L(x), t); Closure.args = args; Closure.body = Closure.Unit } in
          ()
      | _ -> ()
    ) !Typing.extenv;
  let fundefs = List.map h fundefs in
  let e = h { Closure.name = (Id.L("ext_main"), Type.Fun([], Type.Int)); Closure.args = []; Closure.body = e } in
  set_data fundefs e;
  Prog(!data, fundefs, e)
