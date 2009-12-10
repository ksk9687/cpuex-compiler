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
type fundef = { name : Id.l; args : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.l * float) list * fundef list * t

val seq : exp * t -> t

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
val reg_gls : Id.t list

val fv' : exp -> Id.t list
val fv : t -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t
