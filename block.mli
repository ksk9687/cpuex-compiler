type imm = C of int | L of Id.t
type flg = Asm.flg
type mask = BL | BE | BLE | BGE | BNE | BG
type cmp =
  | Cmp of mask * Id.t * Id.t
  | Cmpi of mask * Id.t * int
type exp =
  | Li of imm * Id.t
  | Addi of Id.t * imm * Id.t
  | Mov of Id.t * Id.t
  | Add of Id.t * Id.t * Id.t
  | Sub of Id.t * Id.t * Id.t
  | Call of Id.t * Id.t
  | FAdd of flg * Id.t * Id.t * Id.t
  | FSub of flg * Id.t * Id.t * Id.t
  | FMul of flg * Id.t * Id.t * Id.t
  | FInv of flg * Id.t * Id.t
  | FSqrt of flg * Id.t * Id.t
  | FAbs of Id.t * Id.t
  | FNeg of Id.t * Id.t
  | Load of Id.t * imm * Id.t
  | Loadr of Id.t * Id.t * Id.t
  | Store of Id.t * Id.t * imm
type last =
  | Ret of Id.t
  | Jmp of Id.t
  | CmpJmp of cmp * block * block
  | Cont of block
and block = { mutable exps : (string * exp) list; mutable last : last; mutable label : string }
type prog = Prog of (Id.t * float) list * (Id.t * block) list

val string_of_imm : imm -> string
val string_of_flg : flg -> string
val string_of_mask : mask -> string
val string_of_cmp : cmp -> string
val string_of_exp : exp -> string
val neg_mask : mask -> mask
val neg : cmp -> cmp
val cmp : mask -> 'a -> 'a -> bool

val getRead' : cmp -> S.t
val getRead : exp -> S.t
val getWrite : exp -> S.t

val inCount : int M.t ref
val setCount : block -> unit
val fv' : last -> (string * exp) list -> S.t
val fv : block -> S.t
val initFV : Id.t -> unit

val f : Asm.prog -> prog
