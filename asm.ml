type id_or_imm = V of Id.t | C of int | L of Id.l
type t =
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t
and exp =
  | Nop
  | Set of int
  | SetL of Id.l
  | Mov of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | SLL of Id.t * int
  | Ld of id_or_imm * id_or_imm
  | St of Id.t * id_or_imm * id_or_imm
  | FNeg of Id.t
  | FInv of Id.t
  | FSqrt of Id.t
  | FAbs of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | LdFL of Id.l
  | MovR of Id.t * Id.t
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  | CallDir of Id.l * Id.t list
  | Save of Id.t * Id.t
  | Restore of Id.t
type fundef = { name : Id.l; args : Id.t list; arg_regs : Id.t list; body : t; ret : Type.t; ret_reg : Id.t }
type prog = Prog of (Id.t * Type.t) list * (Id.l * float) list * fundef list * t

let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let niregs = 40
let nfregs = 35
let nfl = 9
let nigl = 19
let nfgl = 19
let iregs = Array.init niregs (fun i -> Printf.sprintf "$i%d" (i + 1))
let fregs = Array.init niregs (fun i -> Printf.sprintf "$f%d" (i + 1))
let alliregs = Array.to_list iregs
let allfregs = Array.to_list fregs
let allregs = alliregs @ allfregs
let reg_ra = "$ra"
let reg_tmp = "$tmp"
let reg_sp = "$sp"
let reg_hp = "$hp"
let reg_i0 = "$i0"
let reg_f0 = "$f0"
let is_reg x = (x.[0] = '$')
let reg_fls = Array.to_list (Array.init nfl (fun i -> Printf.sprintf "$f%d" (i + 1 + nfregs)))
let reg_igls = Array.to_list (Array.init nigl (fun i -> Printf.sprintf "$i%d" (i + 1 + niregs)))
let reg_fgls = Array.to_list (Array.init nfgl (fun i -> Printf.sprintf "$f%d" (i + 1 + nfregs + nfl)))

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
  | Mov(x) | Neg(x) | FNeg(x) |FInv(x) | FSqrt(x) | FAbs(x) | SLL(x, _) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') -> x :: fv_id_or_imm y'
  | Ld(x', y') -> fv_id_or_imm x' @ fv_id_or_imm y'
  | St(x, y', z') -> x :: fv_id_or_imm y' @ fv_id_or_imm z'
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | MovR(x, y) -> [x; y]
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
