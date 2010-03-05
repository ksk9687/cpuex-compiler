open Asm

(* SetLがなく、定数インデックスアクセスのみならレジスタ上に配置可能 *)
(* Putがなければそのレジスタをそのまま使用可能 *)
(* Putがある場合は別のレジスタに退避して使う *)
(* とりあえず関数呼び出しがあったらPutありとした *)

let gtable = ref []
let glbl = ref []

let getInnerType t i = match t with
    | Type.Array(t) -> t
    | Type.Tuple(ts) -> List.nth ts i
    | _ -> assert false

let rec rem l env = M.add l [] env
let rec inc' i env' =
  if List.mem_assoc i env' then
    (i, (List.assoc i env') + 1) :: (List.remove_assoc i env')
  else (i, 1) :: env'
let rec inc l i env =
  if M.mem l env then
    if (M.find l env) = [] then env
    else M.add l (inc' i (M.find l env)) env
  else M.add l [(i, 1)] env
let rec count env = function
  | Ans(exp) -> count' env exp
  | Let(_, exp, e) -> count (count' env exp) e
  | Forget(_, e) -> count env e
and count' env = function
  | SetL(Id.L(l)) | Ld(L(Id.L(l)), V(_)) -> rem l env
  | Ld(L(Id.L(l)), C(i)) -> inc l i env
  | Ld(L(Id.L(l)), _) -> rem l env
  | St(_, L(Id.L(l)), C(i)) -> inc l i env
  | St(_, L(Id.L(l)), _) -> rem l env
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

let rec hasPut l i = function
  | Ans(exp) -> hasPut' l i exp
  | Let(_, exp, e) -> (hasPut' l i exp) || (hasPut l i e)
  | Forget(_, e) -> hasPut l i e
and hasPut' l i = function
  | St(_, L(l'), C(i')) when l' = l && i' = i -> true
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
  | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) -> (hasPut l i e1) || (hasPut l i e2)
  | CallDir _ -> true
  | _ -> false

let rec g env = function
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), Ld(L(l), C(i)), e) when List.mem_assoc (l, i) !gtable ->
      (* これ除去するとまずいがレイトレは動く
      if hasPut l i e then
        Let((x, t), Mov(List.assoc (l, i) !gtable), g env e)
      else *)
        g (M.add x (List.assoc (l, i) !gtable) env) e 
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function
  | Ld(L(l), C(i)) when List.mem_assoc (l, i) !gtable ->
      let Id.L(s) = l in
      if (getInnerType (List.assoc s !glbl) i) = Type.Float then FMov(List.assoc (l, i) !gtable)
      else Mov(List.assoc (l, i) !gtable)
  | St(x, L(l), C(i)) when List.mem_assoc (l, i) !gtable ->
      let Id.L(s) = l in
      if (getInnerType (List.assoc s !glbl) i) = Type.Float then FMovR(replace x env, List.assoc (l, i) !gtable)
      else MovR(replace x env, List.assoc (l, i) !gtable)
  | Mov(x) -> Mov(replace x env)
  | FMov(x) -> FMov(replace x env)
  | Neg(x) -> Neg(replace x env)
  | Add(x, y') -> Add(replace x env, replace' y' env)
  | Sub(x, y') -> Sub(replace x env, replace' y' env)
  | Ld(x', y') -> Ld(replace' x' env, replace' y' env)
  | St(x, y', z') -> St(replace x env, replace' y' env, replace' z' env)
  | FNeg(x) -> FNeg(replace x env)
  | FInv(x) -> FInv(replace x env)
  | FSqrt(x) -> FSqrt(replace x env)
  | FAbs(x) -> FAbs(replace x env)
  | FAdd(x, y) -> FAdd(replace x env, replace y env)
  | FSub(x, y) -> FSub(replace x env, replace y env)
  | FMul(x, y) -> FMul(replace x env, replace y env)
  | MovR(x, y) -> MovR(replace x env, replace y env)
  | FMovR(x, y) -> FMovR(replace x env, replace y env)
  | IfEq(x, y', e1, e2) -> IfEq(replace x env, replace' y' env, g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(replace x env, replace' y' env, g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(replace x env, replace' y' env, g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(replace x env, replace y env, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(replace x env, replace y env, g env e1, g env e2)
  | CallDir(l, ys) -> CallDir(l, List.map (fun y -> replace y env) ys)
  | e -> e

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f (Prog(fundata, global, data, fundefs, e)) =
  glbl := global;
  let counts = List.fold_left (fun env { name = l; args = xs; body = e; ret = t} -> count env e) M.empty fundefs in
  let counts = count counts e in
  let gls = M.fold (fun l env' ls -> List.fold_left (fun ls (i, n) -> (l, i, n) :: ls) ls env') counts [] in
  let gls = List.sort (fun (_, _, n1) (_, _, n2) -> n2 - n1) gls in
  let _  = List.fold_left
    (fun (ni, nf) (l, i, _) ->
      if not (List.mem_assoc l global) then
        (*let _ = Format.eprintf "orz: %s@." l in*)
        (ni, nf)
      else
	      let t = getInnerType (List.assoc l global) i in
	      match t with
	        | Type.Float ->
	            if nf >= List.length reg_fgls then (ni, nf)
	            else
	              let reg = List.nth reg_fgls nf in
	                Format.eprintf "Allocate %s.(%d) -> %s@." (String.sub l 9 ((String.length l) - 9)) i reg;
	                gtable := ((Id.L(l), i), reg) :: !gtable;
	                (ni, nf + 1)
	        | _ ->
	            if ni >= List.length reg_igls then (ni, nf)
	            else
	              let reg = List.nth reg_igls ni in
	                Format.eprintf "Allocate %s.(%d) -> %s@." (String.sub l 9 ((String.length l) - 9)) i reg;
	                gtable := ((Id.L(l), i), reg) :: !gtable;
	                (ni + 1, nf)
    )
    (0, 0) gls
  in
  Prog(fundata, global, data, List.map h fundefs,
        List.fold_left
          (fun e ((l, i), reg) ->
            let Id.L(s) = l in
            Let((reg, getInnerType (List.assoc s global) i), Ld(L(l), C(i)), e)
          ) (g M.empty e) !gtable)
