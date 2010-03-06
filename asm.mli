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
type prog = Prog of (Id.t list * Id.t) M.t * (Id.t * Type.t) list * (Id.l * float) list * fundef list * t

val seq : exp * t -> t

val iregs : Id.t array
val fregs : Id.t array
val alliregs : Id.t list
val allfregs : Id.t list
val allregs : Id.t list
val reg_ra : Id.t
val reg_tmp : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val reg_i0 : Id.t
val reg_f0 : Id.t
val is_reg : Id.t -> bool
val reg_fls : Id.t list
val reg_igls : Id.t list
val reg_fgls : Id.t list
val output_header : out_channel -> unit

val fv' : exp -> Id.t list
val fv : t -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t
val applyId : (Id.t -> Id.t) -> exp -> exp
val apply : (t -> t) -> exp -> exp
val apply2 : (t -> t) -> (exp -> exp) -> t -> t
val replace : M.key M.t -> M.key -> M.key
