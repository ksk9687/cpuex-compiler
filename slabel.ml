open Asm

let rec g env = function
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), SetL(l), e) ->
      let e' = g (M.add x l env) e in
      if List.mem x (fv e') then Let((x, t), SetL(l), e') else
       e'
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function
  | Ld(x', V(y)) when M.mem y env -> g' env (Ld(x', L(M.find y env)))
  | Ld(V(x), y') when M.mem x env -> g' env (Ld(L(M.find x env), y'))
  | St(x, y', V(z)) when M.mem z env -> g' env (St(x, y', L(M.find z env)))
  | St(x, V(y), z') when M.mem y env -> g' env (St(x, L(M.find y env), z'))
  | e -> apply (g env) e

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(fundata, global, data, fundefs, e)) =
  Prog(fundata, global, data, List.map h fundefs, g M.empty e)
