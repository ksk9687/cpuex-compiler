open Asm

let ftable = ref []

let rec count env = function
  | Ans(exp) -> count' env exp
  | Let(_, exp, e) -> count (count' env exp) e
  | Forget(_, e) -> count env e
and count' env = function
  | LdFL(l) when M.mem l env ->
      let n = M.find l env in
      M.add l (n + 1) env
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      count (count env e1) e2
  | _ -> env

let rec g e = apply2 g g' e
and g' = function
  | LdFL(l) when List.mem_assoc l !ftable -> FMov(List.assoc l !ftable)
  | exp -> apply g exp

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g e; ret = t }

let f (Prog(data, fundefs, e)) =
  let counts = List.fold_left (fun env (l, _) -> M.add l 0 env) M.empty data in
  let counts = List.fold_left (fun env { name = l; args = xs; body = e; ret = t} -> count env e) counts fundefs in
  let counts = count counts e.body in
  let fls = List.sort (fun (a, _) (b, _) -> (M.find b counts) - (M.find a counts)) data in
  let _  = List.fold_left
    (fun n (l, f) ->
        if f <> 0.0 && n >= List.length reg_fcs then n
        else
          let (reg, n') = if f = 0.0 then (reg_f0, n) else (List.nth reg_fcs n, n + 1) in
          Format.eprintf "Allocate %f -> %s@." f reg;
          ftable := (l, reg) :: !ftable;
          n'
    )
    0 fls
  in
  let fundefs = List.map h fundefs in
  let e = h e in
  let body = List.fold_left
	  (fun e (l, reg) -> if reg = reg_f0 then e else Let((reg, Type.Float), Ld(L(l), C(0)), e)
    ) e.body !ftable in
  Prog(data, fundefs, { e with body = body })
