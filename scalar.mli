type t =
  | End
  | Ret of string
  | Jmp of string * string
  | Call of string * t
  | Seq of exp * t
  | If of string * string * t * t * t
and exp = Exp of string * string list * string list (* asm, read, write *)
type prog = Prog of (Id.l * float) list * (Id.l * t) list * t

val seq : t -> t -> t
val f : Asm.prog -> prog
