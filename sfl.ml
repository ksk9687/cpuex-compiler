open Asm

let ftable = ref []

let rec count env = function
  | Ans(exp) -> count' env exp
  | Let(_, exp, e) -> count (count' env exp) e
  | Forget(_, e) -> count env e
and count' env = function
  | LdFL(Id.L(l)) when M.mem l env ->
      let n = M.find l env in
      M.add l (n + 1) env
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) 
  | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> count (count env e1) e2
  | _ -> env

let replace x env =
  if M.mem x env then M.find x env
  else x

let replace' x' env =
  match x' with
    | V(x) when M.mem x env -> V(M.find x env)
    | x' -> x'

let rec g env = function
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), LdFL(l), e) when List.mem_assoc l !ftable ->
      g (M.add x (List.assoc l !ftable) env) e
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function
  | LdFL(l) when List.mem_assoc l !ftable -> Mov(List.assoc l !ftable)
  | Mov(x) -> Mov(replace x env)
  | Neg(x) -> Neg(replace x env)
  | Add(x, y') -> Add(replace x env, replace' y' env)
  | Sub(x, y') -> Sub(replace x env, replace' y' env)
  | SLL(x, i) -> SLL(replace x env, i)
  | Ld(x', y') -> Ld(replace' x' env, replace' y' env)
  | St(x, y', z') -> St(replace x env, replace' y' env, replace' z' env)
  | FNeg(x) -> FNeg(replace x env)
  | FInv(x) -> FInv(replace x env)
  | FSqrt(x) -> FSqrt(replace x env)
  | FAbs(x) -> FAbs(replace x env)
  | FAdd(x, y) -> FAdd(replace x env, replace y env)
  | FSub(x, y) -> FSub(replace x env, replace y env)
  | FMul(x, y) -> FMul(replace x env, replace y env)
  | IfEq(x, y', e1, e2) -> IfEq(replace x env, replace' y' env, g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(replace x env, replace' y' env, g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(replace x env, replace' y' env, g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(replace x env, replace y env, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(replace x env, replace y env, g env e1, g env e2)
  | CallCls(x, ys) -> CallCls(replace x env, List.map (fun y -> replace y env) ys)
  | CallDir(l, ys) -> CallDir(l, List.map (fun y -> replace y env) ys)
  | e -> e

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(data, fundefs, e)) =
	let counts = List.fold_left (fun env (Id.L(l), _) -> M.add l 0 env) M.empty data in
	let counts = List.fold_left (fun env { name = l; args = xs; body = e; ret = t} -> count env e) counts fundefs in
	let counts = count counts e in
	let fls = List.sort (fun (Id.L(a), _) (Id.L(b), _) -> (M.find b counts) - (M.find a counts)) data in
	let _  = List.fold_left
	  (fun n (l, f) ->
	      if f <> 0.0 && n >= List.length reg_fls then n
	      else
	        let (reg, n') = if f = 0.0 then (reg_zero, n) else (List.nth reg_fls n, n + 1) in
	        Format.eprintf "Allocate %f -> %s@." f reg;
          ftable := (l, reg) :: !ftable;
          n'
	  )
	  0 fls
	in
	Prog(data, List.map h fundefs,
        List.fold_left
          (fun e (l, reg) -> if reg = reg_zero then e else Let((reg, Type.Float), Ld(L(l), C(0)), e))
          (g M.empty e)
          !ftable)
