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
  | MovR of Id.t * Id.t
  | FMovR of Id.t * Id.t
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  | CallDir of Id.l * Id.t list
  | Save of Id.t * Id.t
  | Restore of Id.t
type fundef = { name : Id.l; args : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.t list * Id.t) M.t * (Id.t * Type.t) list * (Id.l * float) list * fundef list * t

let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let niregs = 50
let nfregs = 18
let nfl = 20
let nigl = 9
let nfgl = 25
let iregs = Array.init niregs (fun i -> Printf.sprintf "$i%d" (i + 1))
let fregs = Array.init nfregs (fun i -> Printf.sprintf "$f%d" (i + 1))
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
let reg_fls = Array.to_list (Array.init nfl (fun i -> Printf.sprintf "$fc%d" i))
let reg_igls = Array.to_list (Array.init nigl (fun i -> Printf.sprintf "$ig%d" i))
let reg_fgls = Array.to_list (Array.init nfgl (fun i -> Printf.sprintf "$fg%d" i))

let output_header oc =
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $i%d\n.define $i%d orz\n" r n n; (n + 1)
    ) (1 + niregs) reg_igls in
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $f%d\n.define $f%d orz\n" r n n; (n + 1)
    ) (1 + nfregs) reg_fls in
  let _ = List.fold_left
    (fun n r -> Printf.fprintf oc ".define %s $f%d\n.define $f%d orz\n" r n n; (n + 1)
    ) (1 + nfregs + nfl) reg_fgls in
  ()

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
  | FAdd(x, y, _) | FSub(x, y, _) | FMul(x, y, _) | MovR(x, y) | FMovR(x, y) -> [x; y]
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
  | MovR(x, y) -> MovR(f x, f y)
  | FMovR(x, y) -> FMovR(f x, f y)
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

let replace env x =
  if M.mem x env then M.find x env
  else x
