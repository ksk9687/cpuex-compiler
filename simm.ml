open Asm

let off = ref false

let replace env = function
  | V(x) when M.mem x env -> C(M.find x env)
  | x' -> x'

let check lb ub env x =
  if M.mem x env then
    let y = M.find x env in
    lb <= y && y < ub
  else
    false

let rec g env = function
  | Let((x, t), Set(i), e) ->
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then Let((x, t), Set(i), e')
      else e'
  | e -> apply2 (g env) (g' env) e
and g' env = function
  | Add(x, V(y)) when M.mem y env -> Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env -> Sub(x, C(M.find y env))
  | Ld(x', y') -> Ld(replace env x', replace env y')
  | St(x, y', z') -> St(x, replace env y', replace env z')
  | If(Eq(x, V(y)), e1, e2) when check (-128) 128 env y -> If(Eq(x, C(M.find y env)), g env e1, g env e2)
  | If(LE(x, V(y)), e1, e2) when check (-128) 128 env y -> If(LE(x, C(M.find y env)), g env e1, g env e2)
  | If(GE(x, V(y)), e1, e2) when check (-128) 128 env y -> If(GE(x, C(M.find y env)), g env e1, g env e2)
  | If(Eq(x, V(y)), e1, e2) when check (-128) 128 env x -> If(Eq(y, C(M.find x env)), g env e1, g env e2)
  | If(LE(x, V(y)), e1, e2) when check (-128) 128 env x -> If(GE(y, C(M.find x env)), g env e1, g env e2)
  | If(GE(x, V(y)), e1, e2) when check (-128) 128 env x -> If(LE(y, C(M.find x env)), g env e1, g env e2)
  | exp -> apply (g env) exp

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) =
  if !off then Prog(data, fundefs, e)
  else Prog(data, List.map h fundefs, h e)
