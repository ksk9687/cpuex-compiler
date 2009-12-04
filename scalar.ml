open Asm

type t =
  | End
  | Seq of exp * t
  | If of string * string * t * t * t
and exp = Exp of string * string list * string list (* asm, read, write *)
type prog = Prog of (Id.l * float) list * (Id.l * t) list * t

let rec seq e1 e2 =
  match e1 with
    | End -> e2
    | Seq(e1', e2') -> Seq(e1', seq e2' e2)
    | If(b, bn, e1', e2', e3') -> If(b, bn, e1', e2', seq e3' e2)

let reg = function
  | V(x) -> [x]
  | _ -> []

let pp_id_or_imm = function
  | V(x) -> x
  | C(i) -> string_of_int i
  | L(Id.L(l)) -> l

let ret = Seq(Exp(Printf.sprintf "\tret\n", [], ["all"]), End)
let cmp x y' = Seq(Exp(Printf.sprintf "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y'), x :: (reg y'), ["cond"]), End)
let fcmp x y = Seq(Exp(Printf.sprintf "\t%-8s%s, %s\n" "fcmp" x y, [x; y], ["cond"]), End)

let stacksize = ref 0
let stackset = ref S.empty
let stackmap = ref []
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
(*let offset x = (List.hd (locate x)) + 1*)
let offset x =
  let xs = locate x in
  if xs = [] then (Format.eprintf "Error: %s@." x; List.iter (fun s -> Format.eprintf "%s@." s) !stackmap; assert false)
  else (List.hd xs) + 1

let name s =
  try String.sub s 0 (String.index s '.')
  with Not_found -> s

let rec shuffle sw xys =
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] ->
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

let rec hasNonTailCall tail = function (* 非末尾関数呼び出しがあるか *)
  | Ans(exp) -> hasNonTailCall' tail exp
  | Let(_, exp, e) -> hasNonTailCall' false exp || hasNonTailCall tail e
  | Forget _ -> assert false
and hasNonTailCall' tail = function
  | CallCls _ | CallDir _ -> not tail
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) |
    IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      if tail then (hasNonTailCall tail e1) && (hasNonTailCall tail e2) (* 末尾の場合は必ずあるか *)
      else (hasNonTailCall tail e1) || (hasNonTailCall tail e2) (* 末尾でない場合はあるかもしれないか *)
  | _ -> false

let rec notHasNonTailCall tail = function (* 非末尾関数呼び出しが絶対にないか *)
  | Ans(exp) -> notHasNonTailCall' tail exp
  | Let(_, exp, e) -> notHasNonTailCall' false exp && notHasNonTailCall tail e
  | Forget _ -> assert false
and notHasNonTailCall' tail = function
  | CallCls _ | CallDir _ -> tail
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) |
    IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      (notHasNonTailCall tail e1) && (notHasNonTailCall tail e2)
  | _ -> true

let rec calcStack stack = function
  | Ans(exp) -> calcStack' stack exp
  | Let(_, exp, e) -> calcStack (calcStack' stack exp) e
  | Forget _ -> assert false
and calcStack' stack = function
  | Save(_, x) ->
      if not (List.mem x stack) then x :: stack
      else stack
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) |
    IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      calcStack (calcStack stack e1) e2
  | _ -> stack

type dest = Tail | NonTail of Id.t
let rec g saved (dest, e) =
  let tail = (match dest with Tail -> true | _ -> false) in
  let e1, saved' =
    if (not saved) && hasNonTailCall tail e then
      let e1 = g' saved ".count stack_move\n" (NonTail(reg_sp), Sub(reg_sp, C(!stacksize))) in
      let e2 = g' saved ".count stack_store\n" (NonTail(reg_tmp), St(reg_ra, V(reg_sp), C(0))) in
      (seq e1 e2, true)
    else if saved && tail && notHasNonTailCall tail e then
      let e1 = g' saved ".count stack_load\n" (NonTail(reg_ra), Ld(V(reg_sp), C(0))) in
      let e2 = g' saved ".count stack_move\n" (NonTail(reg_sp), Add(reg_sp, C(!stacksize))) in
      (seq e1 e2, false)
    else
      (End, saved)
  in
  match e with
  | Ans(exp) -> seq e1 (g' saved' "" (dest, exp))
  | Let((x, t), exp, e) ->
      let e2 = g' saved' "" (NonTail(x), exp) in
      let e3 = (g saved' (dest, e)) in
      (seq e1 (seq e2 e3))
  | Forget _ -> assert false
and g' saved s = function
  | NonTail(_), Nop -> End
  | NonTail(x), Set(i) when i < 0 -> g' saved s (NonTail(x), Add(reg_zero, C(i)))
  | NonTail(x), Set(i) -> Seq(Exp(Printf.sprintf "%s\t%-8s%d, %s\n" s "li" i x, [], [x]), End)
  | NonTail(x), SetL(Id.L(y)) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "li" y x, [], [x]), End)
  | NonTail(x), Mov(y) when x = y -> End
  | NonTail(x), Mov(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "mov" y x, [y], [x]), End)
  | NonTail(x), Neg(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "neg" y x, [y], [x]), End)
  | NonTail(x), Add(y, z') -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s, %s\n" s "add" y (pp_id_or_imm z') x, y :: (reg z'), [x]), End)
  | NonTail(x), Sub(y, z') -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s, %s\n" s "sub" y (pp_id_or_imm z') x, y :: (reg z'), [x]), End)
  | NonTail(x), SLL(y, i) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %d, %s\n" s "sll" y i x, [y], [x]), End)
  | NonTail(x), Ld(y', C(z)) when z < 0 -> Seq(Exp(Printf.sprintf "%s\t%-8s[%s - %d], %s\n" s "load" (pp_id_or_imm y') (-z) x, "memory" :: (reg y'), [x]), End)
  | NonTail(x), Ld(y', z') -> Seq(Exp(Printf.sprintf "%s\t%-8s[%s + %s], %s\n" s "load" (pp_id_or_imm y') (pp_id_or_imm z') x, "memory" :: (reg y')@(reg z'), [x]), End)
  | NonTail(r), St(x, V(y), V(z)) ->
      seq (g' saved (s ^ ".count storer\n") (NonTail(reg_tmp), Add(y, V(z)))) (g' saved "" (NonTail(r), St(x, V(reg_tmp), C(0))))
  | NonTail(_), St(x, y', C(z)) when z < 0 -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, [%s - %d]\n" s "store" x (pp_id_or_imm y') (-z), x :: (reg y'), ["memory"]), End)
  | NonTail(_), St(x, y', z') -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, [%s + %s]\n" s "store" x (pp_id_or_imm y') (pp_id_or_imm z'), x :: (reg y')@(reg z'), ["memory"]), End)
  | NonTail(x), FNeg(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "fneg" y x, [y], [x]), End)
  | NonTail(x), FInv(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "finv" y x, [y], [x]), End)
  | NonTail(x), FSqrt(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "fsqrt" y x, [y], [x]), End)
  | NonTail(x), FAbs(y) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s\n" s "fabs" y x, [y], [x]), End)
  | NonTail(x), FAdd(y, z) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s, %s\n" s "fadd" y z x, [y; z], [x]), End)
  | NonTail(x), FSub(y, z) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s, %s\n" s "fsub" y z x, [y; z], [x]), End)
  | NonTail(x), FMul(y, z) -> Seq(Exp(Printf.sprintf "%s\t%-8s%s, %s, %s\n" s "fmul" y z x, [y; z], [x]), End)
  | NonTail(x), LdFL(Id.L(l)) -> Seq(Exp(Printf.sprintf "%s\t%-8s[%s], %s\n" (s ^ ".count load_float\n") "load" l x, [], [x]), End)
  | NonTail(_), MovR(x, y) -> g' saved (s ^ ".count move_float\n") (NonTail(y), Mov(x))
  | NonTail(r), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      g' saved (s ^ ".count stack_store\n") (NonTail(r), St(x, V(reg_sp), C(offset y - (if saved then 0 else !stacksize))))
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); End
  | NonTail(x), Restore(y) ->
      assert (List.mem x allregs);
      g' saved (s ^ ".count stack_load\n") (NonTail(x), Ld(V(reg_sp), C(offset y - (if saved then 0 else !stacksize))))
  | Tail, (Nop | St _ | MovR _ | Save _ as exp) ->
      seq (g' saved s (NonTail(Id.gentmp Type.Unit), exp)) ret
  | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ | SLL _ | Ld _ |
           FNeg _ | FInv _ | FSqrt _ | FAbs _ | FAdd _ | FSub _ | FMul _ | LdFL _ as exp) ->
      seq (g' saved s (NonTail(regs.(0)), exp)) ret
  | Tail, (Restore(x) as exp) ->
      seq (g' saved s (NonTail(regs.(0)), exp)) ret
  | Tail, IfEq(x, y', e1, e2) ->
      seq (cmp x y') (g'_tail_if saved e1 e2 "be" "bne")
  | Tail, IfLE(x, y', e1, e2) ->
      seq (cmp x y') (g'_tail_if saved e1 e2 "ble" "bg")
  | Tail, IfGE(x, y', e1, e2) ->
      seq (cmp x y') (g'_tail_if saved e1 e2 "bge" "bl")
  | Tail, IfFEq(x, y, e1, e2) ->
      seq (fcmp x y) (g'_tail_if saved e1 e2 "be" "bne")
  | Tail, IfFLE(x, y, e1, e2) ->
      seq (fcmp x y) (g'_tail_if saved e1 e2 "ble" "bg")
  | NonTail(z), IfEq(x, y', e1, e2) ->
      seq (cmp x y') (g'_non_tail_if saved (NonTail(z)) e1 e2 "be" "bne")
  | NonTail(z), IfLE(x, y', e1, e2) ->
      seq (cmp x y') (g'_non_tail_if saved (NonTail(z)) e1 e2 "ble" "bg")
  | NonTail(z), IfGE(x, y', e1, e2) ->
      seq (cmp x y') (g'_non_tail_if saved (NonTail(z)) e1 e2 "bge" "bl")
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      seq (fcmp x y) (g'_non_tail_if saved (NonTail(z)) e1 e2 "be" "bne")
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      seq (fcmp x y) (g'_non_tail_if saved (NonTail(z)) e1 e2 "ble" "bg")
  | Tail, CallCls(x, ys) ->
      let e = g'_args [(x, reg_cl)] ys in
      let e = seq e (g' saved ".count closure\n" (NonTail(reg_tmp), Ld(V(reg_cl), C(0)))) in
      seq e (Seq(Exp(Printf.sprintf "%s\t%-8s%s\n" s "jr" reg_tmp, [], ["all"]), End))
  | Tail, CallDir(Id.L(x), ys) ->
      let e = g'_args [] ys in
      seq e (Seq(Exp(Printf.sprintf "%s\t%-8s%s\n" s "b" x, [], ["all"]), End))
  | NonTail(a), CallCls(x, ys) ->
      let e = g'_args [(x, reg_cl)] ys in
      let e = seq e (g' saved ".count closure\n" (NonTail(reg_tmp), Ld(V(reg_cl), C(0)))) in
      let ra = Id.genid ("cls") in
      let e = seq e (g' saved "" (NonTail(reg_ra), SetL(Id.L(ra)))) in
      let e = seq e (Seq(Exp(Printf.sprintf "%s\t%-8s%s\n" s "jr" reg_tmp, [], ["all"; "cond"]), End)) in
      let e = seq e (Seq(Exp(Printf.sprintf "%s:\n" ra, [], ["all"]), End)) in
      if List.mem a allregs && a <> regs.(0) then seq e (g' saved ".count move_ret\n" (NonTail(a), Mov(regs.(0))))
      else e
  | NonTail(a), CallDir(Id.L(x), ys) ->
      let e = g'_args [] ys in
      let e = seq e (Seq(Exp(Printf.sprintf "%s\t%-8s%s\n" s "jal" x, [], ["all"; "cond"]), End)) in
      if List.mem a allregs && a <> regs.(0) then seq e (g' saved ".count move_ret\n" (NonTail(a), Mov(regs.(0))))
      else e
and g'_tail_if saved e1 e2 b bn =
    let stackset_back = !stackset in
    let e1 = g saved (Tail, e1) in
    stackset := stackset_back;
    let e2 = g saved (Tail, e2) in
    If(b, bn, e1, e2, End)
and g'_non_tail_if saved dest e1 e2 b bn =
    let stackset_back = !stackset in
    let e1 = g saved (dest, e1) in
    let stackset1 = !stackset in
    stackset := stackset_back;
    let e2 = g saved (dest, e2) in
    let stackset2 = !stackset in
    stackset := S.inter stackset1 stackset2;
    If(b, bn, e1, e2, End)
and g'_args x_reg_cl ys =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (1, x_reg_cl)
      ys in
  List.fold_right
    (fun (y, r) e -> seq (g' true ".count move_args\n" (NonTail(r), Mov(y))) e)
    (shuffle reg_tmp yrs) End

let h e =
  stacksize := List.length (calcStack [] e) + 1;
  stackset := S.empty;
  stackmap := [];
  g false (Tail, e)

let f (Asm.Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Prog(data, List.map (fun {name = x; body = e} -> (x, h e)) fundefs, h e)
