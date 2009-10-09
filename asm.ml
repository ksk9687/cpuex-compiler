(* ksk assembly with a few virtual instructions *)

type id_or_imm = V of Id.t | C of int
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
  | Ld of Id.t * id_or_imm
  | St of Id.t * Id.t * id_or_imm
  | FMov of Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | LdF of Id.t * id_or_imm
  | StF of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t (* 左右対称ではないので必要 *)
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
  | Restore of Id.t (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
type fundef = { name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
(* プログラム全体 = 浮動小数定数テーブル + トップレベル関数 + メインの式 (caml2html: sparcasm_prog) *)
type prog = Prog of (Id.l * float) list * fundef list * t

let flet(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs = Array.init 12 (fun i -> Printf.sprintf "$r%d" (i + 2))
let fregs = Array.init 13 (fun i -> Printf.sprintf "$r%d" (i + 16))
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
(* こいつらもregAllocのレジスタ割り当てで使われる？？ *)
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_sp = "$r0" (* stack pointer *)
let reg_hp = "$r1" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_ra = "$r31" (* return address *)
let reg_asm = "$r15" (* for assembler *)
let reg_fasm = "$r30" (* for assembler *)
let reg_zero = "$r14" (* 0 *)
let reg_fzero = "$r29" (* 0.0 *)
let is_reg x = (x.[0] = '$')

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp cont = function
  | Nop | Set(_) | SetL(_) | Comment(_) | Restore(_) -> cont
  | Mov(x) | Neg(x) | FMov(x) | FNeg(x) | Save(x, _) -> x :: cont
  | Add(x, y') | Sub(x, y') | Ld(x, y') | LdF(x, y') -> x :: fv_id_or_imm y' @ cont
  | St(x, y, z') | StF(x, y, z') -> x :: y :: fv_id_or_imm z' @ cont
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> x :: y :: cont
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv cont e1 @ fv cont e2) (* uniq here just for efficiency *)
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv cont e1 @ fv cont e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs @ cont
  | CallDir(_, ys, zs) -> ys @ zs @ cont
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
