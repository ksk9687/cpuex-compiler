open Asm

let rec fn f n =
  if n > 1 then (fun x -> (fn f (n-1)) (f x))
  else f

let safe_regs =
  let regs = ((fn List.tl 10) alliregs) @ ((fn List.tl 10) allfregs) in
  ref
    (List.fold_left
       (fun map (id,regs) -> M.add ("min_caml_" ^ id) (S.of_list regs) map) 
      M.empty
        [("floor", ["$4";"$5";"$6";"$7";"$8";"$9";"$10"]@regs);
         ("float_of_int", ["$8";"$9";"$10"]@regs);
         ("int_of_float", ["$9";"$10"]@regs);
         ("create_array", ["$4";"$5";"$6";"$7";"$8";"$9";"$10"]@regs);
         ("read_int", ["$3";"$4";"$5";"$6";"$7";"$8";"$9";"$10"]@regs);
         ("read_float", ["$3";"$4";"$5";"$6";"$7";"$8";"$9";"$10"]@regs);
         ("write", ["$1";"$3";"$4";"$5";"$6";"$7";"$8";"$9";"$10"]@regs);
         ("sin", regs); ("cos", regs); ("atan", regs)])

let get_safe_regs x =
  try M.find x !safe_regs
  with Not_found -> S.empty

let fundefs = ref M.empty

let get_arg_regs x = (M.find x !fundefs).arg_regs

let rec target' src (dest, t) = function
  | Mov(x) when x = src && is_reg dest ->
      assert (t <> Type.Unit);
      false, [dest]
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
  | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      let c1, rs1 = target src (dest, t) e1 in
      let c2, rs2 = target src (dest, t) e2 in
      c1 && c2, rs1 @ rs2
  | CallDir(Id.L(x), ys) ->
      true, (target_args src (get_arg_regs x) ys @
         S.elements (get_safe_regs x))
  | _ -> false, []
and target src dest = function
  | Ans(exp) -> target' src dest exp
  | Let(xt, exp, e) ->
      let c1, rs1 = target' src xt exp in
      let c2, rs2 = target src dest e in
        c2, rs1 @ rs2
  | Forget(_, e) -> target src dest e
and target_args src regs = function
  | [] -> []
  | y :: ys when src = y -> (List.hd regs) :: target_args src (List.tl regs) ys
  | _ :: ys -> target_args src (List.tl regs) ys

type alloc_result =
  | Alloc of Id.t
  | Spill of Id.t
let rec alloc dest cont regenv x t =
  assert (not (M.mem x regenv));
  let all =
    match t with
    | Type.Unit -> ["$dummy"]
    | Type.Float -> allfregs
    | _ -> alliregs in
  if all = ["$dummy"] then Alloc("$dummy") else
  if is_reg x then Alloc(x) else
  let free = fv cont in
  try
    let (c, prefer) = target x dest cont in
    let live =
      List.fold_left
        (fun live y ->
          if is_reg y then S.add y live else
          try S.add (M.find y regenv) live
          with Not_found -> live)
        S.empty
        free in
    let r =
      List.find
      (fun r -> not (S.mem r live))
        (prefer @ all) in
    Alloc(r)
  with Not_found ->
    Format.eprintf "register allocation failed for %s@." x;
    let y =
      List.find
        (fun y ->
          not (is_reg y) &&
          try List.mem (M.find y regenv) all
          with Not_found -> false)
        (List.rev free) in
    Format.eprintf "spilling %s from %s@." y (M.find y regenv);
    Spill(y)

let add x r regenv =
  if is_reg x then (assert (x = r); regenv) else
  M.add x r regenv

type g_result =
  | NoSpill of t * Id.t M.t
  | ToSpill of t * Id.t list

exception NoReg of Id.t * Type.t
let find x t regenv =
  if is_reg x then x else
  try M.find x regenv
  with Not_found -> raise (NoReg(x, t))
let find' x' regenv =
  match x' with
  | V(x) -> V(find x Type.Int regenv)
  | c -> c
let forget_list xs e =
  List.fold_left
    (fun e x -> Forget(x, e))
    e
    xs
let insert_forget xs exp t =
  let a = Id.gentmp t in
  let m =
    match t with
    | Type.Unit -> Nop
    | _ -> Mov(a) in
  ToSpill(Let((a, t), exp, forget_list xs (Ans(m))), xs)

let rec g dest cont regenv = function
  | Ans(exp) -> g'_and_restore dest cont regenv exp
  | Let((x, t) as xt, exp, e) ->
      assert (not (M.mem x regenv));
      let cont' = concat e dest cont in
      (match g'_and_restore xt cont' regenv exp with
      | ToSpill(e1, ys) -> ToSpill(concat e1 xt e, ys)
      | NoSpill(e1', regenv1) ->
          (match alloc dest cont' regenv1 x t with
          | Spill(y) -> ToSpill(Let(xt, exp, Forget(y, e)), [y])
          | Alloc(r) ->
              match g dest cont (add x r regenv1) e with
              | ToSpill(e2, ys) when List.mem x ys ->
                  let x_saved = Let(xt, exp, seq(Save(x, x), e2)) in
                  (match List.filter (fun y -> y <> x) ys with
                    | [] -> g dest cont regenv x_saved
                    | ys_left -> ToSpill(x_saved, ys_left))
              | ToSpill(e2, ys) -> ToSpill(Let(xt, exp, e2), ys)
              | NoSpill(e2', regenv2) -> NoSpill(concat e1' (r, t) e2', regenv2)))
  | Forget(x, e) ->
      (match g dest cont (M.remove x regenv) e with
      | ToSpill(e1, ys) ->
          let x_forgotten = Forget(x, e1) in
          (match List.filter (fun y -> y <> x) ys with
          | [] -> g dest cont regenv x_forgotten
          | ys_left -> ToSpill(x_forgotten, ys_left))
      | NoSpill(e1', regenv1) -> NoSpill(e1', regenv1))
and g'_and_restore dest cont regenv exp =
  try g' dest cont regenv exp
  with NoReg(x, t) ->
    ((* Format.eprintf "restoring %s@." x; *)
     g dest cont regenv (Let((x, t), Restore(x), Ans(exp))))
and g' dest cont regenv = function
  | Nop | Set _ | SetL _ | LdFL _ | Restore _ as exp -> NoSpill(Ans(exp), regenv)
  | Mov(x) -> NoSpill(Ans(Mov(find x Type.Int regenv)), regenv)
  | Neg(x) -> NoSpill(Ans(Neg(find x Type.Int regenv)), regenv)
  | Add(x, y') -> NoSpill(Ans(Add(find x Type.Int regenv, find' y' regenv)), regenv)
  | Sub(x, y') -> NoSpill(Ans(Sub(find x Type.Int regenv, find' y' regenv)), regenv)
  | SLL(x, i) -> NoSpill(Ans(SLL(find x Type.Int regenv, i)), regenv)
  | Ld(x', y') -> NoSpill(Ans(Ld(find' x' regenv, find' y' regenv)), regenv)
  | St(x, y', z') -> NoSpill(Ans(St(find x Type.Int regenv, find' y' regenv, find' z' regenv)), regenv)
  | FNeg(x) -> NoSpill(Ans(FNeg(find x Type.Float regenv)), regenv)
  | FInv(x) -> NoSpill(Ans(FInv(find x Type.Float regenv)), regenv)
  | FSqrt(x) -> NoSpill(Ans(FSqrt(find x Type.Float regenv)), regenv)
  | FAbs(x) -> NoSpill(Ans(FAbs(find x Type.Float regenv)), regenv)
  | FAdd(x, y) -> NoSpill(Ans(FAdd(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | FSub(x, y) -> NoSpill(Ans(FSub(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | FMul(x, y) -> NoSpill(Ans(FMul(find x Type.Float regenv, find y Type.Float regenv)), regenv)
  | MovR(x, y) -> NoSpill(Ans(MovR(find x Type.Int regenv, find y Type.Int regenv)), regenv)
  | IfEq(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfEq(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfLE(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfLE(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfGE(x, y', e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfGE(find x Type.Int regenv, find' y' regenv, e1', e2')) e1 e2
  | IfFEq(x, y, e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfFEq(find x Type.Float regenv, find y Type.Float regenv, e1', e2')) e1 e2
  | IfFLE(x, y, e1, e2) as exp -> g'_if dest cont regenv exp (fun e1' e2' -> IfFLE(find x Type.Float regenv, find y Type.Float regenv, e1', e2')) e1 e2
  | CallDir(Id.L(x), ys) as exp -> g'_call x dest cont regenv exp (fun ys -> CallDir(Id.L(x), ys)) ys
  | Save(x, y) ->
      assert (x = y);
      assert (not (is_reg x));
      try NoSpill(Ans(Save(M.find x regenv, x)), regenv)
      with Not_found -> NoSpill(Ans(Nop), regenv)
and g'_if dest cont regenv exp constr e1 e2 =
  let (e1', regenv1) = g_repeat dest cont regenv e1 in
  let (e2', regenv2) = g_repeat dest cont regenv e2 in
  let regenv' =
    List.fold_left
      (fun regenv' x ->
        try
          if is_reg x then regenv' else
          let r1 = M.find x regenv1 in
          let r2 = M.find x regenv2 in
          if r1 <> r2 then regenv' else
          M.add x r1 regenv'
        with Not_found -> regenv')
      M.empty
      (fv cont) in
  match
    List.filter
      (fun x -> not (is_reg x) && x <> fst dest && not (M.mem x regenv'))
      (fv cont)
  with [] -> NoSpill(Ans(constr e1' e2'), regenv')
  | xs -> insert_forget xs exp (snd dest)
and g'_call id dest cont regenv exp constr ys =
  match
    List.filter
      (fun x ->
   not (is_reg x || x = fst dest || (M.mem x regenv && S.mem (M.find x regenv) (get_safe_regs id))))
      (fv cont)
  with [] -> NoSpill(Ans(constr
                           (List.map (fun y -> find y Type.Int regenv) ys)),
                     regenv)
  | xs -> insert_forget xs exp (snd dest)
and g_repeat dest cont regenv e =
    match g dest cont regenv e with
    | NoSpill(e', regenv') -> (e', regenv')
    | ToSpill(e, xs) ->
        g_repeat dest cont regenv
          (List.fold_left
             (fun e x -> seq(Save(x, x), e))
             e
             xs)

let rec set_safe_regs_t env = function
  | Ans (e) -> set_safe_regs_exp env e
  | Let ((x, _), e, t) -> set_safe_regs_t (set_safe_regs_exp (S.remove x env) e) t
  | Forget (x, t) -> set_safe_regs_t (S.remove x env) t
and set_safe_regs_exp env = function
  | CallDir (Id.L(x), _) ->
      S.inter (get_safe_regs x) env
  | IfEq (_, _, t1, t2) | IfLE (_, _, t1, t2) | IfGE (_, _, t1, t2)
  | IfFEq (_, _, t1, t2) | IfFLE (_, _, t1, t2) ->
      S.inter (set_safe_regs_t env t1) (set_safe_regs_t env t2)
  | _ -> env
let rec set_safe_regs   { name = Id.L(x); args = args; arg_regs = arg_regs; body = e; ret = t; ret_reg = ret_reg } =
  let env = S.of_list allregs in
  let env = S.diff env (S.of_list arg_regs) in
  let env = S.remove ret_reg env in
  safe_regs := M.add x env !safe_regs;
  let env = set_safe_regs_t env e in
    List.iter (fun x -> Format.eprintf "%s" (if S.mem x env then "o" else "x")) allregs;
    Format.eprintf "@.";
    safe_regs := M.add x env !safe_regs

let h { name = Id.L(x); args = xs; arg_regs = rs; body = e; ret = t; ret_reg = r } =
  Format.eprintf "Allocating: %s@." x;
  let regenv = List.fold_left2
    (fun env x r -> M.add x r env
    ) M.empty xs rs in
  let (e', regenv') = g_repeat (r, t) (Ans(Mov(r))) regenv e in
  let func = { name = Id.L(x); args = rs; arg_regs = rs; body = e'; ret = t; ret_reg = r } in
  set_safe_regs func;
  func

let f (Prog(global, data, funs, e)) =
  Format.eprintf "register allocation: may take some time (up to a few minutes, depending on the size of functions)@.";
  fundefs := List.fold_left
    (fun fundefs f -> let Id.L(s) = f.name in M.add s f fundefs
    ) M.empty funs;
  let funs' = List.map h funs in
  let e', regenv' = g_repeat (Id.gentmp Type.Unit, Type.Unit) (Ans(Nop)) M.empty e in
  Prog(global, data, funs', e')
