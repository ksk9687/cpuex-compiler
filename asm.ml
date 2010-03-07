type id_or_imm = V of Id.t | C of int | L of Id.l
type flg = Non | Abs | Neg
type t =
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t
and exp =
  | Nop
  | Set of int
  | SetL of Id.l
  | Mov of Id.t
  | FMov of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | Ld of id_or_imm * id_or_imm
  | St of Id.t * id_or_imm * id_or_imm
  | FNeg of Id.t
  | FInv of Id.t * flg
  | FSqrt of Id.t * flg
  | FAbs of Id.t
  | FAdd of Id.t * Id.t * flg
  | FSub of Id.t * Id.t * flg
  | FMul of Id.t * Id.t * flg
  | LdFL of Id.l
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  | CallDir of Id.l * Id.t list
  | Save of Id.t * Id.t
  | Restore of Id.t
type fundef = { name : Id.l; args : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

type fundata = { arg_regs : Id.t list; ret_reg : Id.t; reg_ra : Id.t; use_regs : S.t }

let fundata = ref M.empty
let builtInFuns = M.add_list
  [("ext_floor", { arg_regs = ["$f2"]; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$f1"; "$f2"; "$f3"] });
   ("ext_float_of_int", { arg_regs = ["$i2"]; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$i2"; "$i3"; "$i4"; "$f1"; "$f2"; "$f3"] });
   ("ext_int_of_float", { arg_regs = ["$f2"]; ret_reg = "$i1"; reg_ra = "$ra"; use_regs = S.of_list ["$i1"; "$i2"; "$i3"; "$f2"; "$f3"] });
   ("ext_read_int", { arg_regs = []; ret_reg = "$i1"; reg_ra = "$ra"; use_regs = S.of_list ["$i1"; "$i2"; "$i3"; "$i4"; "$i5"] });
   ("ext_read_float", { arg_regs = []; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$i1"; "$i2"; "$i3"; "$i4"; "$i5"; "$f1"] });
   ("ext_write", { arg_regs = ["$i2"]; ret_reg = "$dummy"; reg_ra = "$ra"; use_regs = S.of_list ["$i2"] });
   ("ext_create_array_int", { arg_regs = ["$i2"; "$i3"]; ret_reg = "$i1"; reg_ra = "$ra"; use_regs = S.of_list ["$i1"; "$i2"; "$i3"] });
   ("ext_create_array_float", { arg_regs = ["$i2"; "$f2"]; ret_reg = "$i1"; reg_ra = "$ra"; use_regs = S.of_list ["$i1"; "$i2"; "$i3"; "$f2"] });
   ("ext_atan", { arg_regs = ["$f2"]; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$i2"; "$f1"; "$f2"; "$f3"; "$f4"; "$f5"] });
   ("ext_sin", { arg_regs = ["$f2"]; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$i2"; "$f1"; "$f2"; "$f3"; "$f4"; "$f5"; "$f6"; "$f7"] });
   ("ext_cos", { arg_regs = ["$f2"]; ret_reg = "$f1"; reg_ra = "$ra"; use_regs = S.of_list ["$i2"; "$f1"; "$f2"; "$f3"; "$f4"; "$f5"; "$f6"; "$f7"; "$f8"] });
  ] M.empty

let get_arg_regs x = (M.find x !fundata).arg_regs
let get_ret_reg x = (M.find x !fundata).ret_reg
let get_reg_ra x = (M.find x !fundata).reg_ra
let get_use_regs x = (M.find x !fundata).use_regs

let typedata = ref M.empty (* TODO *)

let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let niregs = 54
let nfregs = 18
let nig = 5
let nfg = 25
let nfc = 20
let iregs = Array.init niregs (fun i -> Printf.sprintf "$i%d" (i + 1))
let fregs = Array.init nfregs (fun i -> Printf.sprintf "$f%d" (i + 1))
let alliregs = Array.to_list iregs
let allfregs = Array.to_list fregs
let reg_ra = "$ra"
let reg_tmp = "$tmp"
let reg_sp = "$sp"
let reg_hp = "$hp"
let reg_i0 = "$i0"
let reg_f0 = "$f0"
let is_reg x = (x.[0] = '$')
let reg_igs = Array.to_list (Array.init nig (fun i -> Printf.sprintf "$ig%d" i))
let reg_fgs = Array.to_list (Array.init nfg (fun i -> Printf.sprintf "$fg%d" i))
let reg_fcs = Array.to_list (Array.init nfc (fun i -> Printf.sprintf "$fc%d" i))
let allregs = alliregs @ allfregs @ reg_igs @ reg_fgs

let output_header oc =
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $i%d\n.define $i%d orz\n" r n n; (n + 1)
    ) (1 + niregs) reg_igs in
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $f%d\n.define $f%d orz\n" r n n; (n + 1)
    ) (1 + nfregs) reg_fgs in
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $f%d\n.define $f%d orz\n" r n n; (n + 1)
    ) (1 + nfregs + nfg) reg_fcs in
  ()

let output_fun_header oc x name =
  if M.mem x !fundata then
	  let data = M.find x !fundata in
    let rec out rs use =
      let add str s t =
        let st = if s = t then s else s ^ " - " ^ t in
        if s = "" then str
        else if str = "" then st
        else str ^ ", " ^ st
      in
      let (str, s, t) = List.fold_left
	      (fun (str, s, t) r ->
          if not (S.mem r use) then (add str s t, "", "")
          else if s = "" then (str, r, r)
          else (str, s, r)
	      ) ("", "", "") rs
      in add str s t
    in
	  Printf.fprintf oc "\n######################################################################\n";
	  Printf.fprintf oc "# %s%s(%s)\n" (if data.ret_reg = "$dummy" then "" else data.ret_reg ^ " = ") name (String.concat ", " data.arg_regs);
	  Printf.fprintf oc "# $ra = %s\n" data.reg_ra;
	  Printf.fprintf oc "# [%s]\n" (out alliregs data.use_regs);
	  Printf.fprintf oc "# [%s]\n" (out allfregs data.use_regs);
	  Printf.fprintf oc "# [%s]\n" (out reg_igs data.use_regs);
	  Printf.fprintf oc "# [%s]\n" (out reg_fgs data.use_regs);
	  Printf.fprintf oc "######################################################################\n"
  else
   (Printf.fprintf oc "\n######################################################################\n";
	  Printf.fprintf oc "# %s\n" name;
	  Printf.fprintf oc "######################################################################\n")

let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys
let rec cat xs ys env =
  match xs with
    | [] -> ys
    | x :: xs when S.mem x env -> cat xs ys env
    | x :: xs -> x :: (cat xs ys (S.add x env))
let fv_id_or_imm x' = match x' with V(x) -> [x] | _ -> []
let rec fv' = function
  | Nop | Set _ | SetL _ | Restore _ | LdFL _ -> []
  | Mov(x) | FMov(x) | FNeg(x) |FInv(x, _) | FSqrt(x, _) | FAbs(x) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') -> x :: fv_id_or_imm y'
  | Ld(x', y') -> fv_id_or_imm x' @ fv_id_or_imm y'
  | St(x, y', z') -> x :: fv_id_or_imm y' @ fv_id_or_imm z'
  | FAdd(x, y, _) | FSub(x, y, _) | FMul(x, y, _) -> [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> x :: fv_id_or_imm y'
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> [x; y]
  | CallDir(_, ys) -> ys
let rec fv_exp env cont e =
  let xs = fv' e in
  match e with
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2)
    | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
        cat xs (fv env (fv env cont e2) e1) env
    | _ -> cat xs cont env
and fv env cont = function
  | Ans(exp) -> fv_exp env cont exp
  | Let((x, t), exp, e) ->
      let cont' = fv (S.add x env) cont e in
      fv_exp env cont' exp
  | Forget(x, e) -> fv (S.add x env) cont e
let fv e = remove_and_uniq S.empty (fv S.empty [] e)

let rec concat e1 xt e2 =
  match e1 with
  | Ans(exp) -> Let(xt, exp, e2)
  | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)
  | Forget(y, e1') -> Forget(y, concat e1' xt e2)

let applyId f exp =
  let f' = function V(x) -> V(f x) | c -> c in
  match exp with
  | Mov(x) -> Mov(f x)
  | FMov(x) -> FMov(f x)
  | Add(x, y') -> Add(f x, f' y')
  | Sub(x, y') -> Sub(f x, f' y')
  | Ld(x', y') -> Ld(f' x', f' y')
  | St(x, y', z') -> St(f x, f' y', f' z')
  | FNeg(x) -> FNeg(f x)
  | FInv(x, flg) -> FInv(f x, flg)
  | FSqrt(x, flg) -> FSqrt(f x, flg)
  | FAbs(x) -> FAbs(f x)
  | FAdd(x, y, flg) -> FAdd(f x, f y, flg)
  | FSub(x, y, flg) -> FSub(f x, f y, flg)
  | FMul(x, y, flg) -> FMul(f x, f y, flg)
  | IfEq(x, y', e1, e2) -> IfEq(f x, f' y', e1, e2)
  | IfLE(x, y', e1, e2) -> IfLE(f x, f' y', e1, e2)
  | IfGE(x, y', e1, e2) -> IfGE(f x, f' y', e1, e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(f x, f y, e1, e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(f x, f y, e1, e2)
  | CallDir(x, ys) -> CallDir(x, List.map f ys)
  | Save(x, y) -> Save(f x, f y)
  | Restore(x) -> Restore(x)
  | exp -> exp

let apply f = function
  | IfEq(x, y', e1, e2) -> IfEq(x, y', f e1, f e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', f e1, f e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', f e1, f e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, f e1, f e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, f e1, f e2)
  | exp -> exp

let apply2 f f' = function
  | Ans(exp) -> Ans(f' exp)
  | Let(xt, exp, e) -> Let(xt, f' exp, f e)
  | Forget(x, e) -> Forget(x, f e)

let replace env x =
  if M.mem x env then M.find x env
  else x
