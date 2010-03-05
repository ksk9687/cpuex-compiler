type t =
  | End
  | Ret of string
  | Jmp of string * string
  | Call of string * t
  | Seq of exp * t
  | If of string * string * string * t * t * t * string list (* cmp, b, bn, then, else, cont, read *)
and exp = Exp of string * string * string list * string list (* asm, instr, read, write *)
type prog = Prog of (Id.l * float) list * (Id.l * t) list * t

val seq : t -> t -> t
val f : Asm.prog -> prog
