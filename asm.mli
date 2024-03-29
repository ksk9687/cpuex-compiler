val off : bool ref
type id_or_imm = V of Id.t | C of int | L of Id.t
type flg = Non | Abs | Neg
type cmp =
  | Eq of Id.t * id_or_imm
  | LE of Id.t * id_or_imm
  | GE of Id.t * id_or_imm
  | FEq of Id.t * Id.t
  | FLE of Id.t * Id.t
type t =
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
  | Forget of Id.t * t
and exp =
  | Nop
  | Set of int
  | SetL of Id.t
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
  | LdFL of Id.t
  | If of cmp * t * t
  | CallDir of Id.t * Id.t list
  | Save of Id.t * Id.t
  | Restore of Id.t
type fundef = { name : Id.t; args : Id.t list; body : t; ret : Type.t }
type prog = Prog of (Id.t * float) list * fundef list * fundef

type fundata = { arg_regs : Id.t list; ret_reg : Id.t; reg_ra : Id.t; use_regs : S.t; need_ra : bool }

val fundata : fundata M.t ref
val builtInFuns : fundata M.t
val get_arg_regs : Id.t -> Id.t list
val get_ret_reg : Id.t -> Id.t
val get_reg_ra : Id.t -> Id.t
val get_use_regs : Id.t -> S.t

val seq : exp * t -> t

val alliregs : Id.t list
val allfregs : Id.t list
val reg_tmp : Id.t
val reg_ra : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val reg_i0 : Id.t
val reg_f0 : Id.t
val is_reg : Id.t -> bool
val reg_igs : Id.t list
val reg_fgs : Id.t list
val reg_figs : Id.t list
val reg_fcs : Id.t list
val reg_ras : Id.t list
val allregs : Id.t list
val is_ireg : Id.t -> bool
val is_freg : Id.t -> bool
val output_header : out_channel -> unit
val output_fun_header : out_channel -> Id.t -> Id.t -> unit

val fv' : exp -> Id.t list
val fv : t -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t
val applyId : (Id.t -> Id.t) -> exp -> exp
val apply : (t -> t) -> exp -> exp
val apply2 : (t -> t) -> (exp -> exp) -> t -> t
val replace : M.key M.t -> M.key -> M.key
