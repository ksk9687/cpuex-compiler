open Asm

(* for register coalescing *)
(* [XXX] Callがあったら、そこから先は無意味というか逆効果なので追わない。
         そのために「Callがあったかどうか」を返り値の第1要素に含める。 *)
let rec target' src (dest, t) = function
  | Mov(x) when x = src && is_reg dest ->
      assert (t <> Type.Unit);
      assert (t <> Type.Float);
      false, [dest]
  | FMov(x) when x = src && is_reg dest ->
      assert (t = Type.Float);
      false, [dest]
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
  | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      let c1, rs1 = target src (dest, t) e1 in
      let c2, rs2 = target src (dest, t) e2 in
      c1 && c2, rs1 @ rs2
  | CallCls(x, ys, zs) ->
      true, (target_args src regs 0 ys @
	     target_args src fregs 0 zs @
             if x = src then [reg_cl] else [])
  | CallDir(_, ys, zs) ->
      true, (target_args src regs 0 ys @
	     target_args src fregs 0 zs)
  | _ -> false, []
and target src dest = function (* register targeting (caml2html: regalloc_target) *)
  | Ans(exp) -> target' src dest exp
  | Let(xt, exp, e) ->
      let c1, rs1 = target' src xt exp in
      if c1 then true, rs1 else
      let c2, rs2 = target src dest e in
      c2, rs1 @ rs2
  | Forget(_, e) -> target src dest e
and target_args src all n = function (* auxiliary function for Call *)
  | [] -> []
  | y :: ys when src = y -> all.(n) :: target_args src all (n + 1) ys
  | _ :: ys -> target_args src all (n + 1) ys

type alloc_result = (* allocにおいてspillingがあったかどうかを表すデータ型 *)
  | Alloc of Id.t (* allocated register *)
  | Spill of Id.t (* spilled variable *)
let rec alloc dest cont regenv x t =
  (* allocate a register or spill a variable *)
  assert (not (M.mem x regenv));
  let all =
    match t with
    | Type.Unit -> ["%g0"] (* dummy *)
    | Type.Float -> allfregs
    | _ -> allregs in
  if all = ["%g0"] then Alloc("%g0") else (* [XX] ad hoc optimization *)
  if is_reg x then Alloc(x) else
  let free = fv cont in
  try
    let (c, prefer) = target x dest cont in
    let live = (* 生きているレジスタ *)
      List.fold_left
        (fun live y ->
	  if is_reg y then S.add y live else
          try S.add (M.find y regenv) live
          with Not_found -> live)
        S.empty
        free in
    let r = (* そうでないレジスタを探す *)
      List.find
        (fun r -> not (S.mem r live))
        (prefer @ all) in
    (* Format.eprintf "allocated %s to %s@." x r; *)
    Alloc(r)
  with Not_found ->
    Format.eprintf "register allocation failed for %s@." x;
    let y = (* 型の合うレジスタ変数を探す *)
      List.find
        (fun y ->
	  not (is_reg y) &&
          try List.mem (M.find y regenv) all
          with Not_found -> false)
        (List.rev free) in
    Format.eprintf "spilling %s from %s@." y (M.find y regenv);
    Spill(y)

(* auxiliary function for g and g'_and_restore *)
let add x r regenv =
  if is_reg x then (assert (x = r); regenv) else
  M.add x r regenv

type g_result = (* gやg'においてspillingがあったかどうかを表すデータ型 (caml2html: regalloc_result) *)
  | NoSpill of t * Id.t M.t (* new regenv *)
  | ToSpill of t * Id.t list (* spilled variables *)

(* auxiliary functions for g' *)
exception NoReg of Id.t * Type.t
let find x t regenv =
  if is_reg x then x else
  try M.find x regenv
  with Not_found -> raise (NoReg(x, t))
let find' x' regenv =
  match x' with
  | V(x) -> V(find x Type.Int regenv)
  | c -> c
let forget_list xs e =
  List.fold_left
    (fun e x -> Forget(x, e))
    e
    xs
let insert_forget xs exp t =
  let a = Id.gentmp t in
  let m =
    match t with
    | Type.Unit -> Nop
    | Type.Float -> FMov(a)
    | _ -> Mov(a) in
  ToSpill(Let((a, t), exp, forget_list xs (Ans(m))), xs)

let rec g dest cont regenv = function (* 命令列のレジスタ割り当て (caml2html: regalloc_g) *)
  | Ans(exp) -> g'_and_restore dest cont regenv exp
  | Let((x, t) as xt, exp, e) ->
      assert (not (M.mem x regenv));
      let cont' = concat e dest cont in
      (match g'_and_restore xt cont' regenv exp with
      | ToSpill(e1, ys) -> ToSpill(concat e1 xt e, ys)
      | NoSpill(e1', regenv1) ->
	  (match alloc dest cont' regenv1 x t with
	  | Spill(y) -> ToSpill(Let(xt, exp, Forget(y, e)), [y])
	  | Alloc(r) ->
	      match g dest cont (add x r regenv1) e with
	      | ToSpill(e2, ys) when List.mem x ys ->
		  let x_saved = Let(xt, exp, seq(Save(x, x), e2)) in
		  (match List.filter (fun y -> y <> x) ys with
		  | [] -> g dest cont regenv x_saved
		  | ys_left -> ToSpill(x_saved, ys_left))
	      | ToSpill(e2, ys) -> ToSpill(Let(xt, exp, e2), ys)
	      | NoSpill(e2', regenv2) -> NoSpill(concat e1' (r, t) e2', regenv2)))
  | Forget(x, e) ->
      (match g dest cont (M.remove x regenv) e with
      | ToSpill(e1, ys) ->
	  let x_forgotten = Forget(x, e1) in
	  (match List.filter (fun y -> y <> x) ys with
	  | [] -> g dest cont regenv x_forgotten
	  | ys_left -> ToSpill(x_forgotten, ys_left))
      | NoSpill(e1', regenv1) -> NoSpill(e1', regenv1))
and g'_and_restore dest cont regenv exp = (* 使用される変数をスタックからレジスタへRestore (caml2html: regalloc_unspill) *)
  try g' dest cont regenv exp
  with NoReg(x, t) ->
    ((* Format.eprintf "restoring %s@." x; *)
     g dest cont regenv (Let((x, t), Restore(x), Ans(exp))))
and g' dest cont regenv = function (* 各命令のレジスタ割り当て (caml2html: regalloc_gprime) *)
  | Nop | Set _ | SetL _ | LdFL _ | Comment _ | Restore _ as exp -> NoSpill(Ans(exp), regenv)
  | Mov(x) -> NoSpill(Ans(Mov(find x Type.Int regenv)), regenv)
  | Neg(x) -> NoSpill(Ans(Neg(find x Type.Int regenv)), regenv)
  | Add(x, y') -> NoSpill(Ans(Add(find x Type.Int regenv, find' y' regenv)), regenv)
  | Sub(x, y') -> NoSpill(Ans(Sub(find x Type.Int regenv, find' y' regenv)), regenv)
  | SLL(x, y') -> NoSpill(Ans(SLL(find x Type.Int regenv, find' y' regenv)), regenv)
  | SRL(x, y') -> NoSpill(Ans(SRL(find x Type.Int regenv, find' y' regenv)), regenv)
  | Ld(x, y') -> NoSpill(Ans(Ld(find x Type.Int regenv, find' y' regenv)), regenv)
  | St(x, y, z') -> NoSpill(Ans(St(find x Type.Int regenv, find y Type.Int regenv, find' z' regenv)), regenv)
  | FMov(x) -> NoSpill(Ans(FMov(find x Type.Float regenv)), regenv)
  | FNeg(x) -> NoSpill(Ans(FNeg(find x Type.Float regenv)), regenv)
  | FAdd(x, y) -> NoSpill(Ans(FAdd(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | FSub(x, y) -> NoSpill(Ans(FSub(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | FMul(x, y) -> NoSpill(Ans(FMul(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | FDiv(x, y) -> NoSpill(Ans(FDiv(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | LdF(x, y') -> NoSpill(Ans(LdF(find x Type.Int regenv, find' y' regenv)), regenv)
  | StF(x, y, z') -> NoSpill(Ans(StF(find x Type.Float regenv, find y Type.Int regenv, find' z' regenv)), regenv)
  | IfEq(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfEq(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfLE(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfLE(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfGE(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfGE(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfFEq(x, y, e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfFEq(find x Type.Float regenv, find y Type.Float regenv, e1', e2')) e1 e2
  | IfFLE(x, y, e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfFLE(find x Type.Float regenv, find y Type.Float regenv, e1', e2')) e1 e2
  | CallCls(x, ys, zs) as exp -> g'_call dest cont regenv exp (fun ys zs -> CallCls(find x Type.Int regenv, ys, zs)) ys zs
  | CallDir(l, ys, zs) as exp -> g'_call dest cont regenv exp (fun ys zs -> CallDir(l, ys, zs)) ys zs
  | Save(x, y) ->
      assert (x = y);
      assert (not (is_reg x));
      try NoSpill(Ans(Save(M.find x regenv, x)), regenv)
      with Not_found -> NoSpill(Ans(Nop), regenv) (* must have already been saved *)
and g'_if dest cont regenv exp constr e1 e2 = (* ifのレジスタ割り当て (caml2html: regalloc_if) *)
  let (e1', regenv1) = g_repeat dest cont regenv e1 in
  let (e2', regenv2) = g_repeat dest cont regenv e2 in
  let regenv' = (* 両方に共通のレジスタ変数だけ利用 *)
    List.fold_left
      (fun regenv' x ->
        try
	  if is_reg x then regenv' else
          let r1 = M.find x regenv1 in
          let r2 = M.find x regenv2 in
          if r1 <> r2 then regenv' else
	  M.add x r1 regenv'
        with Not_found -> regenv')
      M.empty
      (fv cont) in
  match
    List.filter
      (fun x -> not (is_reg x) && x <> fst dest && not (M.mem x regenv'))
      (fv cont)
  with [] -> NoSpill(Ans(constr e1' e2'), regenv')
  | xs -> insert_forget xs exp (snd dest) (* そうでない変数は分岐以前にセーブ *)
and g'_call dest cont regenv exp constr ys zs = (* 関数呼び出しのレジスタ割り当て (caml2html: regalloc_call) *)
  match
    List.filter (* セーブすべきレジスタ変数を探す *)
      (fun x -> not (is_reg x) && x <> fst dest)
      (fv cont)
  with [] -> NoSpill(Ans(constr
			   (List.map (fun y -> find y Type.Int regenv) ys)
			   (List.map (fun z -> find z Type.Float regenv) zs)),
		     M.empty)
  | xs -> insert_forget xs exp (snd dest)
and g_repeat dest cont regenv e = (* Spillがなくなるまでgを繰り返す (caml2html: regalloc_repeat) *)
    match g dest cont regenv e with
    | NoSpill(e', regenv') -> (e', regenv')
    | ToSpill(e, xs) ->
	g_repeat dest cont regenv
	  (List.fold_left
	     (fun e x -> seq(Save(x, x), e))
	     e
	     xs)

let h { name = Id.L(x); args = ys; fargs = zs; body = e; ret = t } = (* 関数のレジスタ割り当て (caml2html: regalloc_h) *)
  let regenv = M.add x reg_cl M.empty in
  let (i, arg_regs, regenv) =
    List.fold_left
      (fun (i, arg_regs, regenv) y ->
        let r = regs.(i) in
        (i + 1,
	 arg_regs @ [r],
	 (assert (not (is_reg y));
	  M.add y r regenv)))
      (0, [], regenv)
      ys in
  let (d, farg_regs, regenv) =
    List.fold_left
      (fun (d, farg_regs, regenv) z ->
        let fr = fregs.(d) in
        (d + 1,
	 farg_regs @ [fr],
	 (assert (not (is_reg z));
	  M.add z fr regenv)))
      (0, [], regenv)
      zs in
  let a =
    match t with
    | Type.Unit -> Id.gentmp Type.Unit
    | Type.Float -> fregs.(0)
    | _ -> regs.(0) in
  let (e', regenv') = g_repeat (a, t) (Ans(Mov(a))) regenv e in
  { name = Id.L(x); args = arg_regs; fargs = farg_regs; body = e'; ret = t }

let f (Prog(data, fundefs, e)) = (* プログラム全体のレジスタ割り当て (caml2html: regalloc_f) *)
  Format.eprintf "register allocation: may take some time (up to a few minutes, depending on the size of functions)@.";
  let fundefs' = List.map h fundefs in
  let e', regenv' = g_repeat (Id.gentmp Type.Unit, Type.Unit) (Ans(Nop)) M.empty e in
  Prog(data, fundefs', e')
