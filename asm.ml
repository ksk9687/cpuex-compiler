(* ksk assembly with a few virtual instructions *)

type id_or_imm = V of Id.t | C of int | L of Id.l
type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t (* Spillされた変数を、自由変数の計算から除外するための仮想命令 (caml2html: sparcasm_forget) *)
and exp = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
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
  | FSqrt of Id.t
  | FAbs of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | LdFL of Id.l
  | MovR of Id.t * Id.t
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t (* 左右対称ではないので必要 *)
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list
  | CallDir of Id.l * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
  | Restore of Id.t (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
type fundef = { name : Id.l; args : Id.t list; body : t; ret : Type.t }
(* プログラム全体 = 浮動小数定数テーブル + トップレベル関数 + メインの式 (caml2html: sparcasm_prog) *)
type prog = Prog of (Id.l * float) list * fundef list * t

let flet(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs = Array.init 19 (fun i -> Printf.sprintf "$%d" (i + 1))
let allregs = Array.to_list regs
(* reg_clをregsから取り除くとバグるぽい *)
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_tmp = "$tmp" (* temporary for swap *)
let reg_sp = "$sp" (* stack pointer *)
let reg_hp = "$hp" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_ra = "$ra" (* return address *)
let reg_zero = "$zero" (* 0 *)
let is_reg x = (x.[0] = '$')
let reg_fls = Array.to_list (Array.init 20 (fun i -> Printf.sprintf "$%d" (i + 20)))
let reg_gls = Array.to_list (Array.init 20 (fun i -> Printf.sprintf "$%d" (i + 40)))

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp cont = function
  | Nop | Set _ | SetL _ | Comment _ | Restore _ | LdFL _ -> cont
  | Mov(x) | Neg(x) | FNeg(x) | FSqrt(x) | FAbs(x) | SLL(x, _) | Save(x, _) -> x :: cont
  | Add(x, y') | Sub(x, y') -> x :: fv_id_or_imm y' @ cont
  | Ld(x', y') -> fv_id_or_imm x' @ fv_id_or_imm y' @ cont
  | St(x, y', z') -> x :: fv_id_or_imm y' @ fv_id_or_imm z' @ cont
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | MovR(x, y) -> x :: y :: cont
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv cont e1 @ fv cont e2) (* uniq here just for efficiency *)
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv cont e1 @ fv cont e2) (* uniq here just for efficiency *)
  | CallCls(x, ys) -> x :: ys @ cont
  | CallDir(_, ys) -> ys @ cont
and fv cont = function
  | Ans(exp) -> fv_exp cont exp
  | Let((x, t), exp, e) ->
      let cont' = remove_and_uniq (S.singleton x) (fv cont e) in
      fv_exp cont' exp
  | Forget(x, e) -> remove_and_uniq (S.singleton x) (fv cont e) (* Spillされた変数は、自由変数の計算から除外 (caml2html: sparcasm_exclude) *)
    (* (if y = z then (forget x; ...) else (forget x; ...)); x + x
       のような場合のために、継続の自由変数contを引数とする *)
let fv e = remove_and_uniq S.empty (fv [] e)

let rec concat e1 xt e2 =
  match e1 with
  | Ans(exp) -> Let(xt, exp, e2)
  | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)
  | Forget(y, e1') -> Forget(y, concat e1' xt e2)
