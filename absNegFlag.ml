open Asm

let off = ref false

let rec check x = function
  | Ans(exp) -> check' x exp
  | Let(_, exp, e) ->
      let ok1, flg1 = check' x exp in
      let ok2, flg2 = check x e in
      if ok1 && ok2 && (flg1 = flg2 || flg1 = Non || flg2 = Non) then (true, flg1)
      else (false, Non)
  | Forget(_, e) -> check x e
and check' x = function
  | FAbs(x') when x = x' -> (true, Abs)
  | FNeg(x') when x = x' -> (true, Neg)
  | exp when List.mem x (fv' exp) -> (false, Non)
  | If(_, e1, e2) ->
      let ok1, flg1 = check x e1 in
      let ok2, flg2 = check x e2 in
      if ok1 && ok2 && (flg1 = flg2 || flg1 = Non || flg2 = Non) then (true, flg1)
      else (false, Non)
  | e -> (true, Non)

let rec checkFPU = function
  | Ans(exp) -> checkFPU' exp
  | Let(_, _, e) | Forget(_, e) -> checkFPU e
and checkFPU' = function
  | FMov _ | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> true
  | If(_, e1, e2) ->
      (checkFPU e1) && (checkFPU e2)
  | _ -> false

let rec g flg set env = function
  | Ans(exp) -> Ans(g' flg set env exp)
  | Let((x, t), (FAbs(y) | FNeg(y)), e) when S.mem y set -> g flg set (M.add x y env) e
  | Let((x, t), exp, e) when checkFPU' exp ->
      let (_, flg') = check x e in
      if flg' = Non then Let((x, t), g' Non set env exp, g flg set env e)
      else Let((x, t), g' flg' set env exp, g flg (S.add x set) env e)
  | Let(xt, exp, e) -> Let(xt, g' flg set env exp, g flg set env e)
  | Forget(x, e) -> Forget(x, g flg set env e)
and g' flg set env = function
  | FMov(x) when flg = Abs -> FAbs(x)
  | FMov(x) when flg = Neg -> FNeg(x)
  | FAbs(x) | FNeg(x) when S.mem x set -> FMov(x)
  | FInv(x, _) -> FInv(replace env x, flg)
  | FSqrt(x, _) -> FSqrt(replace env x, flg)
  | FAdd(x, y, _) -> FAdd(replace env x, replace env y, flg)
  | FSub(x, y, _) -> FSub(replace env x, replace env y, flg)
  | FMul(x, y, _) -> FMul(replace env x, replace env y, flg)
  | e -> apply (g flg set env) (applyId (replace env) e)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g Non S.empty M.empty e; ret = t }

let f (Prog(data, fundefs, e)) =
  if !off then Prog(data, fundefs, e)
  else Prog(data, List.map h fundefs, h e)
