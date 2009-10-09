(* SPARC assembly with a few virtual instructions *)

type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t (* Spillされた変数を、自由変数の計算から除外するための仮想命令 (caml2html: sparcasm_forget) *)
and exp = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  | Nop
  | Set of int
  | SetL of Id.l
  | Mov of Id.t
  | Add of Id.t * Id.t
  | Addi of Id.t * int
  | Sub of Id.t * Id.t
  | Ld of Id.t * int
  | St of Id.t * Id.t * int
  | FMovD of Id.t
  | FAddD of Id.t * Id.t
  | FSubD of Id.t * Id.t
  | FMulD of Id.t * Id.t
  | FDivD of Id.t * Id.t
  | LdDF of Id.t * int
  | StDF of Id.t * Id.t * int
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | IfGE of Id.t * Id.t * t * t (* 左右対称ではないので必要 *)
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

let fletd(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs =  Array.init 15 (fun i -> Printf.sprintf "$r%d" (i+2))
let fregs = Array.init 14 (fun i -> Printf.sprintf "$r%d" (i+17))
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_sp = "$r0" (* stack pointer *)
let reg_hp = "$r1" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_ra = "$r31" (* return address *)
let is_reg x = (x.[0] = '$')
(* 倍精度用なので必要無し *)
(*
let co_freg_table =
  let ht = Hashtbl.create 16 in
  for i = 0 to 15 do
    Hashtbl.add
      ht
      (Printf.sprintf "%%f%d" (i * 2))
      (Printf.sprintf "%%f%d" (i * 2 + 1))
  done;pp
  ht
let co_freg freg = Hashtbl.find co_freg_table freg (* "companion" freg *)
*)

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let rec fv_exp cont = function
  | Nop | Set(_) | SetL(_) | Comment(_) | Restore(_) -> cont
  | Mov(x) | FMovD(x) | Save(x, _) | Addi(x, _) | Ld(x, _) | LdDF(x, _) -> x :: cont
  | Add(x, y') | Sub(x, y') | St(x, y', _) | StDF(x, y', _) -> x :: y' :: cont
  | FAddD(x, y) | FSubD(x, y) | FMulD(x, y) | FDivD(x, y) -> x :: y :: cont
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> x :: y' :: remove_and_uniq S.empty (fv cont e1 @ fv cont e2) (* uniq here just for efficiency *)
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

let align i = i(* (if i mod 8 = 0 then i else i + 4) *)
