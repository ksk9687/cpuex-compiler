(* translation into SPARC assembly with infinite number of virtual registers *)

open Asm

let data = ref [] (* 浮動小数の定数テーブル (caml2html: virtual_data) *)

let classify xts ini add =
  List.fold_left
    (fun acc (x, t) ->
      match t with
      | Type.Unit -> acc
      | _ -> add acc x t)
    ini
    xts

let separate xts =
  classify
    xts
    []
    (fun yts x _ -> (yts @ [x]))

let expand xts ini add =
  classify
    xts
    ini
    (fun (offset, acc) x t ->
      (offset + 1, add x t offset acc))

let rec g env = function (* 式の仮想マシンコード生成 (caml2html: virtual_g) *)
  | Closure.Unit -> Ans(Nop)
  | Closure.Int(i) -> Ans(Set(i))
  | Closure.Float(d) ->
      let l =
        try
          (* すでに定数テーブルにあったら再利用 *)
          let (l, _) = List.find (fun (_, d') -> d = d') !data in
          l
        with Not_found ->
          let l = Id.L(Id.genid "f") in
          data := (l, d) :: !data;
          l
      in
      Ans(Ld(L(l), C(0))) (* ラベルから直接ロード *)
(*      let x = Id.genid "l" in
      Let((x, Type.Int), SetL(l), Ans(LdF(x, C(0))))*)
  | Closure.Neg(x) -> Ans(Neg(x))
  | Closure.Add(x, y) -> Ans(Add(x, V(y)))
  | Closure.Sub(x, y) -> Ans(Sub(x, V(y)))
  | Closure.SLL(x, i) -> Ans(SLL(x, i))
  | Closure.FNeg(x) -> Ans(FNeg(x))
  | Closure.FSqrt(x) -> Ans(FSqrt(x))
  | Closure.FAbs(x) -> Ans(FAbs(x))
  | Closure.FAdd(x, y) -> Ans(FAdd(x, y))
  | Closure.FSub(x, y) -> Ans(FSub(x, y))
  | Closure.FMul(x, y) -> Ans(FMul(x, y))
  | Closure.FDiv(x, y) -> Ans(FDiv(x, y))
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
  | Closure.MakeCls((x, t), { Closure.entry = l; Closure.actual_fv = ys }, e2) -> (* クロージャの生成 (caml2html: virtual_makecls) *)
      (* Closureのアドレスをセットしてから、自由変数の値をストア *)
      let e2' = g (M.add x t env) e2 in
      let offset, store_fv =
        expand
          (List.map (fun y -> (y, M.find y env)) ys)
          (1, e2')
          (fun y _ offset store_fv -> seq(St(y, V(x), C(offset)), store_fv)) in
      Let((x, t), Mov(reg_hp),
          Let((reg_hp, Type.Int), Add(reg_hp, C(offset)),
              let z = Id.genid "l" in
              Let((z, Type.Int), SetL(l),
                  seq(St(z, V(x), C(0)),
                      store_fv))))
  | Closure.AppCls(x, ys) ->
      let xts = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(CallCls(x, xts))
  | Closure.AppDir(Id.L(x), ys) ->
      let xts = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(CallDir(Id.L(x), xts))
  | Closure.Tuple(xs) -> (* 組の生成 (caml2html: virtual_tuple) *)
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
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            Let((x, t), Ld(V(y), C(offset)), load)) in
      load
  | Closure.Get(x, y) -> (* 配列の読み出し (caml2html: virtual_get) *)
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(_) -> Ans(Ld(V(x), V(y)))
      | _ -> assert false)
  | Closure.Put(x, y, z) ->
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(Nop)
      | Type.Array(_) -> Ans(St(z, V(x), V(y)))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> Ans(SetL(Id.L("min_caml_" ^ x)))

(* 関数の仮想マシンコード生成 (caml2html: virtual_h) *)
let h { Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts; Closure.body = e } =
  let xts = separate yts in
  let (offset, load) =
    expand
      zts
      (1, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
      (fun z t offset load -> Let((z, t), Ld(V(reg_cl), C(offset)), load)) in
  match t with
  | Type.Fun(_, t2) ->
      { name = Id.L(x); args = xts; body = load; ret = t2 }
  | _ -> assert false

(* プログラム全体の仮想マシンコード生成 (caml2html: virtual_f) *)
let f (Closure.Prog(fundefs, e)) =
  data := [];
  let fundefs = List.map h fundefs in
  let e = g M.empty e in
  Prog(!data, fundefs, e)
