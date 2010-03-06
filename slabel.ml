open Asm

let replace env = function
  | V(x) when M.mem x env -> L(M.find x env)
  | x' -> x'

let rec g env = function
  | Let((x, t), SetL(l), e) ->
      let e' = g (M.add x l env) e in
      if List.mem x (fv e') then Let((x, t), SetL(l), e')
      else e'
  | e -> apply2 (g env) (g' env) e
and g' env = function
  | Ld(x', y') -> Ld(replace env x', replace env y')
  | St(x, y', z') -> St(x, replace env y', replace env z')
  | exp -> apply (g env) exp

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(fundata, global, data, fundefs, e)) =
  Prog(fundata, global, data, List.map h fundefs, g M.empty e)
