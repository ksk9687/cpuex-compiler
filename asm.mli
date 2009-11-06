type id_or_imm = V of Id.t | C of int | L of Id.l
type t =
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t (* virtual instruction *)
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
  | FSqrt of Id.t
  | FAbs of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | LdFL of Id.l
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list
  | CallDir of Id.l * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 *)
  | Restore of Id.t (* スタック変数から値を復元 *)
type fundef = { name : Id.l; args : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

val flet : Id.t * exp * t -> t (* shorthand of Let for float *)
val seq : exp * t -> t (* shorthand of Let for unit *)

val regs : Id.t array
val allregs : Id.t list
val reg_cl : Id.t
val reg_tmp : Id.t
val reg_ra : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val reg_zero : Id.t
val is_reg : Id.t -> bool
val reg_fls : Id.t list

val fv : t -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t
