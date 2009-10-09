open SparcAsm

let rec g env = function (* 命令列の13bit即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), Set(i), e) when (-32768 <= i) && (i < 32768) ->
      (* Format.eprintf "found simm13 %s = %d@." x i; *)
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then Let((x, t), Set(i), e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function (* 各命令の13bit即値最適化 (caml2html: simm13_gprime) *)
  | Add(x, y) when M.mem y env -> Addi(x, (M.find y env))
  | Add(x, y) when M.mem x env -> Addi(y, (M.find x env))
  | Sub(x, y) when M.mem y env -> Addi(x, -(M.find y env))
(*  | LdDF(x, y) when M.mem y env -> LdDF(x, (M.find y env))
  | StDF(x, y, z) when M.mem z env -> StDF(x, y, (M.find z env))
  | IfEq(x, y, e1, e2) when M.mem y env -> IfEq(x, (M.find y env), g env e1, g env e2)
  | IfLE(x, y, e1, e2) when M.mem y env -> IfLE(x, (M.find y env), g env e1, g env e2)
  | IfGE(x, y, e1, e2) when M.mem y env -> IfGE(x, (M.find y env), g env e1, g env e2)
  | IfEq(x, y, e1, e2) when M.mem x env -> IfEq(y, (M.find x env), g env e1, g env e2)
  | IfLE(x, y, e1, e2) when M.mem x env -> IfGE(y, (M.find x env), g env e1, g env e2)
  | IfGE(x, y, e1, e2) when M.mem x env -> IfLE(y, (M.find x env), g env e1, g env e2) *)
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, g env e1, g env e2)
  | e -> e

let h { name = l; args = xs; fargs = ys; body = e; ret = t } = (* トップレベル関数の13bit即値最適化 *)
  { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* プログラム全体の13bit即値最適化 *)
  Prog(data, List.map h fundefs, g M.empty e)
