open Asm

let rec g env = function (* 命令列のラベルアクセス最適化 *)
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), SetL(l), e) ->
      let e' = g (M.add x l env) e in
      if List.mem x (fv e') then Let((x, t), SetL(l), e') else
       e'
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function (* 各命令の即値最適化 *)
  | Ld(x', V(y)) when M.mem y env -> g' env (Ld(x', L(M.find y env)))
  | Ld(V(x), y') when M.mem x env -> g' env (Ld(L(M.find x env), y'))
  | St(x, y', V(z)) when M.mem z env -> g' env (St(x, y', L(M.find z env)))
  | St(x, V(y), z') when M.mem y env -> g' env (St(x, L(M.find y env), z'))
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, g env e1, g env e2)
  | e -> e

let h { name = l; args = xs; body = e; ret = t } = (* トップレベル関数の即値最適化 *)
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) = (* プログラム全体の即値最適化 *)
  Prog(data, List.map h fundefs, g M.empty e)
