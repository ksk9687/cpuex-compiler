open Asm

let is_const r = List.mem r reg_fcs || r = reg_i0 || r = reg_f0

let rec getAllPut env = function
  | Ans(exp) -> getAllPut' env exp
  | Let((y, _), exp, e) ->
      S.add y (S.union (getAllPut' env exp) (getAllPut env e))
  | Forget(y, e) -> S.add y (getAllPut env e)
and getAllPut' env = function
  | If(_, e1, e2) ->
      S.union (getAllPut env e1) (getAllPut env e2)
  | CallDir(x, _) when M.mem x env -> M.find x env
  | _ -> S.empty

let rec setPut fundefs env =
  let env' = List.fold_left
    (fun env f ->
      M.add f.name (getAllPut env f.body) env
    ) env fundefs in
  let same = M.fold (fun x set same -> same && M.mem x env && S.equal set (M.find x env)) env' true in
  if same then env
  else setPut fundefs env'

(* 0: ok, 1: hasPut, 2: orz *)
let rec check puts x y = function
  | Ans(exp) -> check' puts x y exp
  | Let((y', _), exp, e) ->
      let a = max (if y' = y then 1 else 0) (check' puts x y exp) in
      if a = 2 || (a = 1 && List.mem x (fv e)) then 2
      else check puts x y e
  | Forget(_, e) -> check puts x y e
and check' puts x y = function
  | If(_, e1, e2) ->
      max (check puts x y e1) (check puts x y e2)
  | CallDir(f, _) when M.mem f puts && S.mem y (M.find f puts) -> 1
  | CallDir _ -> 0
  | _ -> 0

let rec getPut x = function
  | Ans(exp) -> getPut' x exp
  | Let((y, _), (Mov(x') | FMov(x')), e) when x' = x ->
      S.add y (getPut x e)
  | Let(_, exp, e) ->
      S.union (getPut' x exp) (getPut x e)
  | Forget(_, e) -> getPut x e
and getPut' x = function
  | If(_, e1, e2) ->
      S.inter (getPut x e1) (getPut x e2)
  | _ -> S.empty

let rec g puts env = function
  | Let((x, t), exp, e) ->
      let exp = g' puts env exp in
      let ys = getPut x e in
      let ys = S.filter (fun y -> (check puts x y e) < 2) ys in
      if (not (is_reg x)) && (not (S.is_empty ys)) then
        let y = S.choose ys in
        Let((y, t), exp, g puts (M.add x y env) e)
      else (match exp with
        | Mov(y) | FMov(y) ->
          if x = y then g puts env e
          else if not (is_reg x) then
            if not (List.mem x (fv e)) then
              g puts env e
            else if (not (is_reg y)) || is_const y then
              g puts (M.add x y env) e
            else if y = reg_hp then
              Let((x, t), exp, g puts env e)
            else if List.mem y reg_igs || List.mem y reg_fgs then
              if (check puts x y e) == 2 then
                Let((x, t), exp, g puts env e)
              else
                g puts (M.add x y env) e
            else
              (Format.eprintf "let %s = %s@." x y; assert false)
          else if (List.mem x reg_igs || List.mem x reg_fgs) then
            Let((x, t), exp, g puts env e)
          else
            (Format.eprintf "let %s = %s@." x y; assert false)
        | exp -> Let((x, t), exp, g puts env e)
      )
  | e -> apply2 (g puts env) (g' puts env) e
and g' puts env = function
  | exp -> apply (g puts env) (applyId (replace env) exp)

let h puts { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g puts M.empty e; ret = t }

let f' (Prog(data, fundefs, e)) =
  let puts = setPut fundefs M.empty in
  Prog(data, List.map (h puts) fundefs, h puts e)

let rec f e =
  let e' = f' e in
  if e' = e then e
  else f e'
