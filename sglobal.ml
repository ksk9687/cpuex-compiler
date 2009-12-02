open Asm

(* SetLがなく、定数インデックスアクセスのみならレジスタ上に配置可能 *)
(* Putがなければそのレジスタをそのまま使用可能 *)
(* Putがある場合は別のレジスタに退避して使う *)
(* とりあえず関数呼び出しがあったらPutありとした *)

let gtable = ref []

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
  | CallCls _ | CallDir _ -> true
  | _ -> false

let rec g env = function
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), Ld(L(l), C(i)), e) when List.mem_assoc (l, i) !gtable ->
(*      if hasPut l i e then
        Let((x, t), Mov(List.assoc (l, i) !gtable), g env e)
      else*)
      (* これだとまずいがレイトレは動く *)
        g (M.add x (List.assoc (l, i) !gtable) env) e
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
  | Forget(x, e) -> Forget(x, g env e)
and g' env = function
  | Ld(L(l), C(i)) when List.mem_assoc (l, i) !gtable -> Mov(List.assoc (l, i) !gtable)
  | St(x, L(l), C(i)) when List.mem_assoc (l, i) !gtable -> MovR(x, List.assoc (l, i) !gtable)
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
	let counts = List.fold_left (fun env { name = l; args = xs; body = e; ret = t} -> count env e) M.empty fundefs in
	let counts = count counts e in
  let gls = M.fold (fun l env' ls -> List.fold_left (fun ls (i, n) -> (l, i, n) :: ls) ls env') counts [] in
  let gls = List.sort (fun (_, _, n1) (_, _, n2) -> n2 - n1) gls in
  let _  = List.fold_left
	  (fun n (l, i, _) ->
	      if n >= List.length reg_gls then n
	      else
	        let reg = List.nth reg_gls n in
	        Format.eprintf "Allocate %s.(%d) -> %s@." l i reg;
          gtable := ((Id.L(l), i), reg) :: !gtable;
          n + 1
	  )
	  0 gls
  in
	Prog(data, List.map h fundefs,
        List.fold_left
          (fun e ((l, i), reg) -> Let((reg, Type.Int), Ld(L(l), C(i)), e))
          (g M.empty e)
          !gtable)
