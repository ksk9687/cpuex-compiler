open Asm

(* スコア式にしてみたが上手くいかないｏｒｚ *)

let fixed = ref S.empty

let rec target' src (dest, t) live env = function
  | (Mov(x) | FMov(x)) when is_reg dest && M.mem dest env ->
      if x = src then
        if (M.find dest env) >= 0 then M.add dest ((M.find dest env) + 10) env
        else env
      else M.add dest (-30) env
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      let env1 = target src (dest, t) live env e1 in
      let env2 = target src (dest, t) live env e2 in
      if not (live || List.mem src (fv e1)) then env2
      else if not (live || List.mem src (fv e2)) then env1
      else M.mapi (fun x score -> (score + (M.find x env2))) env1
  | CallDir(Id.L(x), ys) ->
      let arg_regs = get_arg_regs x in
      let env = List.fold_left2
        (fun env y r ->
          if M.mem r env then
            if y = src then
              if (M.find r env) >= 0 then M.add r ((M.find r env) + 10) env
              else env
            else M.add r (-30) env
          else env
        ) env ys arg_regs in
      if live then
        let use_regs = get_use_regs x in
        M.mapi (fun x score -> if S.mem x use_regs then -20 else score) env
      else env
  | _ -> env
and target src dest live env = function
  | Ans(exp) -> target' src dest live env exp
  | Let(xt, exp, e) when live || List.mem src (fv e) ->
      let env = target src dest live env e in
      target' src xt true env exp
  | Let(xt, exp, e) ->
      target' src xt false env exp
  | Forget(_, e) -> target src dest live env e

let rec target_call = function
  | CallDir(Id.L(x), _) -> [get_ret_reg x]
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      (target_call' e1) @ (target_call' e2)
  | _ -> []
and target_call' = function
  | Ans(exp) -> target_call exp
  | Let(_, _, e) | Forget(_, e) -> target_call' e

type alloc_result =
  | Alloc of Id.t
  | Spill of Id.t
let rec alloc dest cont exp regenv x t =
  assert (not (M.mem x regenv));
  let all =
    match t with
    | Type.Unit -> []
    | Type.Float -> allfregs
    | _ -> alliregs in
  if all = [] then Alloc("$dummy")
  else if is_reg x then Alloc(x)
  else
    let free = fv cont in
    try
      let score = List.fold_left (fun env r -> M.add r 0 env) M.empty all in
      let score = target x dest false score cont in
      let score = List.fold_left (fun env r -> M.add r ((M.find r env) + 10) env) score (target_call exp) in
      let prefer = List.stable_sort
        (fun r1 r2 -> (M.find r2 score) - (M.find r1 score)
        ) all in
      let live = List.fold_left
        (fun live y ->
          if M.mem y regenv then S.add (M.find y regenv) live
          else live
        ) S.empty free in
      let r = List.find
        (fun r -> List.mem r all && not (S.mem r live)
        ) prefer in
      (*Format.eprintf "%s: %d@." r (M.find r score);*)
      Alloc(r)
    with Not_found ->
      Format.eprintf "register allocation failed for %s@." x;
      let y = List.find
        (fun y -> not (is_reg y) && M.mem y regenv && List.mem (M.find y regenv) all
        ) (List.rev free) in
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
    (fun e x -> Forget(x, e)
    ) e xs
let insert_forget xs exp t =
  Format.eprintf "Stack: %s@." (String.concat ", " xs);
  let a = Id.gentmp t in
  let m = match t with
    | Type.Unit -> Nop
    | Type.Float -> FMov(a)
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
          (match alloc dest cont' exp regenv1 x t with
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
  | FMov(x) -> NoSpill(Ans(FMov(find x Type.Float regenv)), regenv)
  | Add(x, y') -> NoSpill(Ans(Add(find x Type.Int regenv, find' y' regenv)), regenv)
  | Sub(x, y') -> NoSpill(Ans(Sub(find x Type.Int regenv, find' y' regenv)), regenv)
  | Ld(x', y') -> NoSpill(Ans(Ld(find' x' regenv, find' y' regenv)), regenv)
  | St(x, y', z') -> NoSpill(Ans(St(find x Type.Int regenv, find' y' regenv, find' z' regenv)), regenv)
  | FNeg(x) -> NoSpill(Ans(FNeg(find x Type.Float regenv)), regenv)
  | FInv(x, flg) -> NoSpill(Ans(FInv(find x Type.Float regenv, flg)), regenv)
  | FSqrt(x, flg) -> NoSpill(Ans(FSqrt(find x Type.Float regenv, flg)), regenv)
  | FAbs(x) -> NoSpill(Ans(FAbs(find x Type.Float regenv)), regenv)
  | FAdd(x, y, flg) -> NoSpill(Ans(FAdd(find x Type.Float regenv, find y Type.Float regenv, flg)), regenv)
  | FSub(x, y, flg) -> NoSpill(Ans(FSub(find x Type.Float regenv, find y Type.Float regenv, flg)), regenv)
  | FMul(x, y, flg) -> NoSpill(Ans(FMul(find x Type.Float regenv, find y Type.Float regenv, flg)), regenv)
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
  let regenv' = List.fold_left
    (fun regenv' x ->
      try
        if is_reg x then regenv'
        else
          let r1 = M.find x regenv1 in
          let r2 = M.find x regenv2 in
          if r1 <> r2 then regenv'
          else M.add x r1 regenv'
      with Not_found -> regenv'
    ) M.empty (fv cont) in
  let xs = List.filter
    (fun x -> not (is_reg x) && x <> fst dest && not (M.mem x regenv')
    ) (fv cont) in
  match xs with
    | [] -> NoSpill(Ans(constr e1' e2'), regenv')
    | xs -> insert_forget xs exp (snd dest)
and g'_call id dest cont regenv exp constr ys =
  let xs = List.filter
    (fun x ->
      if is_reg x || x = fst dest then false
      else if not (M.mem x regenv) then false (* ??? *)
      else
        let r = M.find x regenv in
        S.mem r (get_use_regs id)
    ) (fv cont)	in
  match xs with
    | [] ->
        let ys = List.map2
          (fun y r ->
            let t =
              if List.mem r alliregs then Type.Int
              else if List.mem r allfregs then Type.Float
              else assert false in
            find y t regenv
          ) ys (get_arg_regs id) in
        NoSpill(Ans(constr ys), regenv)
    | xs -> insert_forget xs exp (snd dest)
and g_repeat dest cont regenv e =
  match g dest cont regenv e with
    | NoSpill(e', regenv') -> (e', regenv')
    | ToSpill(e, xs) ->
        g_repeat dest cont regenv
          (List.fold_left
             (fun e x -> seq(Save(x, x), e)
          ) e xs)

let rec get_use_regs env = function
  | Ans (e) -> get_use_regs' env e
  | Let ((x, _), e, t) -> get_use_regs (get_use_regs' (S.add x env) e) t
  | Forget (x, t) -> get_use_regs (S.add x env) t
and get_use_regs' env = function
  | CallDir (Id.L(x), _) ->
      fixed := S.add x !fixed;
      S.union (Asm.get_use_regs x) env
  | IfEq (_, _, e1, e2) | IfLE (_, _, e1, e2) | IfGE (_, _, e1, e2)	| IfFEq (_, _, e1, e2) | IfFLE (_, _, e1, e2) ->
      S.union (get_use_regs env e1) (get_use_regs env e2)
  | _ -> env

let h { name = Id.L(x); args = xs; body = e; ret = t } =
  if not (S.mem x !fixed) then
    let data = M.find x !fundata in
    let (arg_regs, _) = List.fold_left2
      (fun (arg_regs, regenv) x r ->
        let typ = if List.mem r alliregs then Type.Int else Type.Float in
        match (alloc (data.ret_reg, t) e Nop regenv x typ) with
          | Alloc(r) -> (arg_regs @ [r], M.add x r regenv)
          | _ -> assert false
      ) ([], M.empty) xs data.arg_regs in
    let data = { arg_regs = arg_regs; ret_reg = data.ret_reg; reg_ra = data.reg_ra; use_regs = data.use_regs } in
    fundata := M.add x data !fundata
  else ();
  let data = M.find x !fundata in
  Format.eprintf "%s%s(%s)@." (if t = Type.Unit then "" else data.ret_reg ^ " = ") (Id.name x) (String.concat ", " data.arg_regs);
  Format.eprintf "$ra = %s@." data.reg_ra;
  let regenv = List.fold_left2
    (fun env x r -> M.add x r env
    ) M.empty xs data.arg_regs in
  let ret = if t = Type.Float then FMov(get_ret_reg x) else Mov(data.ret_reg) in
  let (e, _) = g_repeat (data.ret_reg, t) (Ans(ret)) regenv e in
  let data = { arg_regs = data.arg_regs; ret_reg = data.ret_reg; reg_ra = data.reg_ra; use_regs = S.empty } in
  fundata := M.add x data !fundata;
  let env = get_use_regs (S.add data.ret_reg (S.of_list (data.arg_regs))) e in
  let data = { arg_regs = data.arg_regs; ret_reg = data.ret_reg; reg_ra = data.reg_ra; use_regs = env } in
  fundata := M.add x data !fundata;
  List.iter (fun x -> Format.eprintf "%s" (if S.mem x env then "x" else "o")) alliregs;
  Format.eprintf "@.";
  List.iter (fun x -> Format.eprintf "%s" (if S.mem x env then "x" else "o")) allfregs;
  Format.eprintf "@.";
  List.iter (fun x -> Format.eprintf "%s" (if S.mem x env then "x" else "o")) reg_igs;
  Format.eprintf "@.";
  List.iter (fun x -> Format.eprintf "%s" (if S.mem x env then "x" else "o")) reg_fgs;
  Format.eprintf "@.";
  { name = Id.L(x); args = data.arg_regs; body = e; ret = t }
  
let f (Prog(data, funs, e)) =
  Format.eprintf "register allocation: may take some time (up to a few minutes, depending on the size of functions)@.";
  let funs' = List.map h funs in
  let e', regenv' = g_repeat (Id.gentmp Type.Unit, Type.Unit) (Ans(Nop)) M.empty e in
  Prog(data, funs', e')
