open Asm

let is_const r = List.mem r reg_fcs || r = reg_i0 || r = reg_f0

(* 0: ok, 1: hasPut, 2: orz *)
let rec check x y = function
  | Ans(exp) -> check' x y exp
  | Let((y', _), exp, e) ->
      let a = max (if y' = y then 1 else 0) (check' x y exp) in
      if a = 2 || (a = 1 && List.mem x (fv e)) then 2
      else check x y e
  | Forget(_, e) -> check x y e
and check' x y = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      max (check x y e1) (check x y e2)
  | CallDir _ -> 0 (* TODO *)
  | _ -> 0

let rec getPut x = function
  | Ans(exp) -> getPut' x exp
  | Let((y, _), (Mov(x') | FMov(x')), e) when x' = x ->
      S.add y (getPut x e)
  | Let(_, exp, e) ->
      S.union (getPut' x exp) (getPut x e)
  | Forget(_, e) -> getPut x e
and getPut' x = function
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      S.inter (getPut x e1) (getPut x e2)
  | _ -> S.empty

let rec g env = function
  | Let((x, t), exp, e) ->
      let exp = g' env exp in
      let ys = getPut x e in
      let ys = S.filter (fun y -> (check x y e) < 2) ys in
      if (not (is_reg x)) && (not (S.is_empty ys)) then
        let y = S.choose ys in
        Let((y, t), exp, g (M.add x y env) e)
      else (match exp with
        | Mov(y) | FMov(y) ->
          if x = y then g env e
          else if not (is_reg x) then
            if not (List.mem x (fv e)) then
              g env e
            else if (not (is_reg y)) || is_const y then
              g (M.add x y env) e
            else if y = reg_hp then
              Let((x, t), exp, g env e)
            else if List.mem y reg_igs || List.mem y reg_fgs then
              if (check x y e) == 2 then
                Let((x, t), exp, g env e)
              else
                g (M.add x y env) e
            else
              (Format.eprintf "let %s = %s@." x y; assert false)
          else if (List.mem x reg_igs || List.mem x reg_fgs) then
            Let((x, t), exp, g env e)
          else
            (Format.eprintf "let %s = %s@." x y; assert false)
        | exp -> Let((x, t), exp, g env e)
      )
  | e -> apply2 (g env) (g' env) e
and g' env = function
  | exp -> apply (g env) (applyId (replace env) exp)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f' (Prog(data, fundefs, e)) =
  Prog(data, List.map h fundefs, g M.empty e)

let rec f e =
  let e' = f' e in
  if e' = e then e
  else f e'
