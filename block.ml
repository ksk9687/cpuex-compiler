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

let string_of_imm = function
  | C(i) -> string_of_int i
  | L(l) -> l

let string_of_flg = function
  | Asm.Non -> ""
  | Asm.Abs -> "_a"
  | Asm.Neg -> "_n"

let string_of_mask = function
  | BL -> "bl"
  | BE -> "be"
  | BLE -> "ble"
  | BGE -> "bge"
  | BNE -> "bne"
  | BG -> "bg"

let string_of_cmp = function
  | Cmp(mask, x, y) -> Printf.sprintf "\t%-8s%s, %s" (string_of_mask mask) x y
  | Cmpi(mask, x, i) -> Printf.sprintf "\t%-8s%s, %d" (string_of_mask mask) x i

let string_of_exp = function
  | Li(i, d) -> Printf.sprintf "\t%-8s%s, %s" "li" (string_of_imm i) d
  | Addi(s, i, d) -> Printf.sprintf "\t%-8s%s, %s, %s" "add" s (string_of_imm i) d
  | Mov(s, d) -> Printf.sprintf "\t%-8s%s, %s" "mov" s d
  | Add(s, t, d) -> Printf.sprintf "\t%-8s%s, %s, %s" "add" s t d
  | Sub(s, t, d) -> Printf.sprintf "\t%-8s%s, %s, %s" "sub" s t d
  | Call(x, ra) ->
      if ra = Asm.reg_ra then Printf.sprintf "\t%-8s%s" "call" x
      else Printf.sprintf "\t%-8s%s, %s" "jal" x ra
  | FAdd(flg, s, t, d) -> Printf.sprintf "\t%-8s%s, %s, %s" ("fadd" ^ (string_of_flg flg)) s t d
  | FSub(flg, s, t, d) -> Printf.sprintf "\t%-8s%s, %s, %s" ("fsub" ^ (string_of_flg flg)) s t d
  | FMul(flg, s, t, d) -> Printf.sprintf "\t%-8s%s, %s, %s" ("fmul" ^ (string_of_flg flg)) s t d
  | FInv(flg, s, d) -> Printf.sprintf "\t%-8s%s, %s" ("finv" ^ (string_of_flg flg)) s d
  | FSqrt(flg, s, d) -> Printf.sprintf "\t%-8s%s, %s" ("fsqrt" ^ (string_of_flg flg)) s d
  | FAbs(s, d) -> Printf.sprintf "\t%-8s%s, %s" "fabs" s d
  | FNeg(s, d) -> Printf.sprintf "\t%-8s%s, %s" "fneg" s d
  | Load(s, i, d) when s = Asm.reg_i0 -> Printf.sprintf "\t%-8s[%s], %s" "load" (string_of_imm i) d
  | Load(s, C(i), d) when i < 0 -> Printf.sprintf "\t%-8s[%s - %d], %s" "load" s (-i) d
  | Load(s, L(l), d) -> Printf.sprintf "\t%-8s[%s + %s], %s" "load" l s d
  | Load(s, i, d) -> Printf.sprintf "\t%-8s[%s + %s], %s" "load" s (string_of_imm i) d
  | Loadr(s, t, d) -> Printf.sprintf "\t%-8s[%s + %s], %s" "load" s t d
  | Store(s, t, i) when t = Asm.reg_i0 -> Printf.sprintf "\t%-8s%s, [%s]" "store" s (string_of_imm i)
  | Store(s, t, C(i)) when i < 0 -> Printf.sprintf "\t%-8s%s, [%s - %d]" "store" s t (-i)
  | Store(s, t, L(l)) -> Printf.sprintf "\t%-8s%s, [%s + %s]" "store" s l t
  | Store(s, t, i) -> Printf.sprintf "\t%-8s%s, [%s + %s]" "store" s t (string_of_imm i)

let neg_mask = function
  | BL -> BGE
  | BE -> BNE
  | BLE -> BG
  | BGE -> BL
  | BNE -> BE
  | BG -> BLE

let neg = function
  | Cmp(mask, x, y) -> Cmp(neg_mask mask, x, y)
  | Cmpi(mask, x, i) -> Cmpi(neg_mask mask, x, i)

let cmp mask x y =
  match mask with
    | BL -> x < y
    | BE -> x = y
    | BLE -> x <= y
    | BGE -> x >= y
    | BNE -> x <> y
    | BG -> x > y

let getRead' = function
  | Cmp(_, x, y) -> S.of_list [x; y]
  | Cmpi(_, x, _) -> S.of_list [x]

let getRead = function
  | Li _ -> S.empty
  | Addi(x, _, _) | Mov(x, _) | FInv(_, x, _) | FSqrt(_, x, _) | FAbs(x, _) | FNeg(x, _) -> S.of_list [x]
  | Add(x, y, _) | Sub(x, y, _) | FAdd(_, x, y, _) | FSub(_, x, y, _) | FMul(_, x, y, _) | Store(x, y, _) -> S.of_list [x; y]
  | Load(x, _, y) -> S.of_list [x; y; "memory"]
  | Loadr(x, y, z) -> S.of_list [x; y; z; "memory"]
  | Call(x, _) -> S.of_list (Asm.get_arg_regs x)

let getWrite = function
  | Li(_, x) | Addi(_, _, x) | Mov(_, x) | Add(_, _, x) | Sub(_, _, x) |
    FAdd(_, _, _, x) | FSub(_, _, _, x) | FMul(_, _, _, x) | FInv(_, _, x) | FSqrt(_, _, x) |
    FAbs(_, x) | FNeg(_, x) | Load(_, _, x) | Loadr(_, _, x) -> S.of_list [x]
  | Store _ -> S.of_list ["memory"]
  | Call(x, ra) -> S.add ra (Asm.get_use_regs x)

let inCount = ref M.empty

let rec count b =
  if not (M.mem b.label !inCount) then (
    inCount := M.add b.label 1 !inCount;
    match b.last with
      | Cont(b1) -> count b1
      | CmpJmp(_, b1, b2) ->
          count b1;
          count b2
      | _ -> ()
  ) else (
    inCount := M.add b.label ((M.find b.label !inCount) + 1) !inCount
  )

let setCount b =
  inCount := M.empty;
  count b

let fvs = ref M.empty
let ret_reg = ref Asm.reg_tmp

let rec fv' last = function
  | [] -> (
      match last with
        | Ret _ -> S.of_list [!ret_reg]
        | Jmp(x) -> S.of_list (Asm.get_arg_regs x)
        | CmpJmp(cmp, b1, b2) -> S.union (getRead' cmp) (S.union (fv b1) (fv b2))
        | Cont(b1) -> fv b1
      )
  | (_, exp) :: exps ->
      S.union (getRead exp) (S.diff (fv' last exps) (getWrite exp))
and fv b =
  if M.mem b.label !fvs then
    M.find b.label !fvs
  else
    let rs = fv' b.last b.exps in
    fvs := M.add b.label rs !fvs;
    rs

let initFV x =
  ret_reg := Asm.get_ret_reg x;
  fvs := M.empty

let rec seq b1 b2 =
  let _ = match b1.last with
    | Ret("") ->
        if b2.label = "" then
          (b1.exps <- b1.exps @ b2.exps;
          b1.last <- b2.last)
        else
          b1.last <- Cont(b2)
    | Cont(b3) | CmpJmp(_, b3, _) -> ignore(seq b3 b2)
	  | _ -> assert false in
  b1

let exp s exp = { exps = [s, exp]; last = Ret(""); label = "" }

let reg_ra = ref Asm.reg_ra
let need_ra = ref true

let nop () = { exps = []; last = Ret(""); label = "" }
let ret () = { exps = []; last = Ret(!reg_ra); label = "" }

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

let offset x =
  let xs = locate x in
  if xs = [] then (Format.eprintf "Error: %s@." x; List.iter (fun s -> Format.eprintf "%s@." s) !stackmap; assert false)
  else (List.hd xs) + (if !need_ra then 1 else 0)

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

let rec hasNonTailCall tail = function
  | Asm.Ans(exp) -> hasNonTailCall' tail exp
  | Asm.Let(_, exp, e) -> hasNonTailCall' false exp || hasNonTailCall tail e
  | Asm.Forget _ -> assert false
and hasNonTailCall' tail = function
  | Asm.CallDir _ -> not tail
  | Asm.If(_, e1, e2) ->
      if tail then (hasNonTailCall tail e1) && (hasNonTailCall tail e2)
      else (hasNonTailCall tail e1) || (hasNonTailCall tail e2)
  | _ -> false

let rec notHasNonTailCall tail = function
  | Asm.Ans(exp) -> notHasNonTailCall' tail exp
  | Asm.Let(_, exp, e) -> notHasNonTailCall' false exp && notHasNonTailCall tail e
  | Asm.Forget _ -> assert false
and notHasNonTailCall' tail = function
  | Asm.CallDir _ -> tail
  | Asm.If(_, e1, e2) ->
      (notHasNonTailCall tail e1) && (notHasNonTailCall tail e2)
  | _ -> true

let rec calcStack stack = function
  | Asm.Ans(exp) -> calcStack' stack exp
  | Asm.Let(_, exp, e) -> calcStack (calcStack' stack exp) e
  | Asm.Forget _ -> assert false
and calcStack' stack = function
  | Asm.Save(_, x) ->
      if not (List.mem x stack) then x :: stack
      else stack
  | Asm.If(_, e1, e2) ->
      calcStack (calcStack stack e1) e2
  | _ -> stack

type dest = Tail | NonTail of Id.t

let rec g saved (dest, e) =
  let tail = (match dest with Tail -> true | _ -> false) in
  let b1, saved' =
    if !stacksize > 0 && (not saved) && hasNonTailCall tail e then
      let cont2 = Id.genid "cont" in
      let b1 =
        if !need_ra then exp ".count stack_store_ra\n" (Store(!reg_ra, Asm.reg_sp, C(- !stacksize)))
        else nop () in
      let b2 = exp ".count stack_move\n" (Addi(Asm.reg_sp, C(- !stacksize), Asm.reg_sp)) in
	    (seq b1 b2, true)
    else if !stacksize > 0 && saved && tail && notHasNonTailCall tail e then
      let cont2 = Id.genid "cont" in
      let b1 =
        if !need_ra then exp ".count stack_load_ra\n" (Load(Asm.reg_sp, C(0), !reg_ra))
        else nop () in
	    let b2 = exp ".count stack_move\n" (Addi(Asm.reg_sp, C(!stacksize), Asm.reg_sp)) in
	    (seq b1 b2, false)
    else
      (nop (), saved)
  in
  match e with
  | Asm.Ans(exp) ->
      seq b1 (g' saved' (dest, exp))
  | Asm.Let((x, t), exp, e) ->
      let b2 = g' saved' (NonTail(x), exp) in
      let b3 = g saved' (dest, e) in
      seq b1 (seq b2 b3)
  | Asm.Forget _ -> assert false
and g' saved = function
  | NonTail(_), Asm.Nop -> nop ()
  | NonTail(x), Asm.Set(i) when i < 0 -> exp "" (Addi(Asm.reg_i0, C(i), x))
  | NonTail(x), Asm.Set(i) -> exp "" (Li(C(i), x))
  | NonTail(x), Asm.SetL(l) -> exp "" (Li(L(l), x))
  | NonTail(x), (Asm.Mov(y) | Asm.FMov(y)) when x = y -> nop ()
  | NonTail(x), (Asm.Mov(y) | Asm.FMov(y)) -> exp "" (Mov(y, x))
  | NonTail(x), Asm.Add(y, Asm.C(z)) -> exp "" (Addi(y, C(z), x))
  | NonTail(x), Asm.Add(y, Asm.V(z)) -> exp "" (Add(y, z, x))
  | NonTail(x), Asm.Sub(y, Asm.C(z)) -> exp "" (Addi(y, C(-z), x))
  | NonTail(x), Asm.Sub(y, Asm.V(z)) -> exp "" (Sub(y, z, x))
  | NonTail(x), Asm.Ld(Asm.V(y), Asm.V(z)) -> exp "" (Loadr(y, z, x))
  | NonTail(x), (Asm.Ld(Asm.V(y), Asm.C(z)) | Asm.Ld(Asm.C(z), Asm.V(y))) -> exp "" (Load(y, C(z), x))
  | NonTail(x), (Asm.Ld(Asm.V(y), Asm.L(z)) | Asm.Ld(Asm.L(z), Asm.V(y))) -> exp "" (Load(y, L(z), x))
  | NonTail(x), (Asm.Ld(Asm.L(y), Asm.C(z)) | Asm.Ld(Asm.C(z), Asm.L(y))) -> exp "" (Load(Asm.reg_i0, L(Printf.sprintf "%s + %d" y z), x))
  | NonTail(x), Asm.Ld _ -> assert false
  | NonTail(_), Asm.St(x, Asm.V(y), Asm.V(z)) ->
      seq (exp ".count storer\n" (Add(y, z, Asm.reg_tmp))) (exp "" (Store(x, Asm.reg_tmp, C(0))))
  | NonTail(_), (Asm.St(x, Asm.V(y), Asm.C(z)) | Asm.St(x, Asm.C(z), Asm.V(y))) -> exp "" (Store(x, y, C(z)))
  | NonTail(_), (Asm.St(x, Asm.V(y), Asm.L(z)) | Asm.St(x, Asm.L(z), Asm.V(y))) -> exp "" (Store(x, y, L(z)))
  | NonTail(_), (Asm.St(x, Asm.L(y), Asm.C(z)) | Asm.St(x, Asm.C(z), Asm.L(y))) -> exp "" (Store(x, Asm.reg_i0, L(Printf.sprintf "%s + %d" y z)))
  | NonTail(x), Asm.FNeg(y) -> exp "" (FNeg(y, x))
  | NonTail(x), Asm.FInv(y, f) -> exp "" (FInv(f, y, x))
  | NonTail(x), Asm.FSqrt(y, f) -> exp "" (FSqrt(f, y, x))
  | NonTail(x), Asm.FAbs(y) -> exp "" (FAbs(y, x))
  | NonTail(x), Asm.FAdd(y, z, f) -> exp "" (FAdd(f, y, z, x))
  | NonTail(x), Asm.FSub(y, z, f) -> exp "" (FSub(f, y, z, x))
  | NonTail(x), Asm.FMul(y, z, f) -> exp "" (FMul(f, y, z, x))
  | NonTail(x), Asm.LdFL(l) -> exp ".count load_float\n" (Load(Asm.reg_i0, L(l), x))
  | NonTail(_), Asm.Save(x, y) when List.mem x Asm.allregs && not (S.mem y !stackset) ->
      save y;
      exp ".count stack_store\n" (Store(x, Asm.reg_sp, C(offset y - (if saved then 0 else !stacksize))))
  | NonTail(_), Asm.Save(x, y) -> assert (S.mem y !stackset); nop ()
  | NonTail(x), Asm.Restore(y) ->
      assert (List.mem x Asm.allregs);
      exp ".count stack_load\n" (Load(Asm.reg_sp, C(offset y - (if saved then 0 else !stacksize)), x))
  | dest, Asm.If(Asm.Eq(x, Asm.V(y)), e1, e2) ->
      g'_if saved dest (Cmp(BE, x, y)) e1 e2
  | dest, Asm.If(Asm.Eq(x, Asm.C(y)), e1, e2) ->
      g'_if saved dest (Cmpi(BE, x, y)) e1 e2
  | dest, Asm.If(Asm.LE(x, Asm.V(y)), e1, e2) ->
      g'_if saved dest (Cmp(BLE, x, y)) e1 e2
  | dest, Asm.If(Asm.LE(x, Asm.C(y)), e1, e2) ->
      g'_if saved dest (Cmpi(BLE, x, y)) e1 e2
  | dest, Asm.If(Asm.GE(x, Asm.V(y)), e1, e2) ->
      g'_if saved dest (Cmp(BGE, x, y)) e1 e2
  | dest, Asm.If(Asm.GE(x, Asm.C(y)), e1, e2) ->
      g'_if saved dest (Cmpi(BGE, x, y)) e1 e2
  | dest, Asm.If(Asm.FEq(x, y), e1, e2) ->
      g'_if saved dest (Cmp(BE, x, y)) e1 e2
  | dest, Asm.If(Asm.FLE(x, y), e1, e2) ->
      g'_if saved dest (Cmp(BLE, x, y)) e1 e2
  | Tail, Asm.CallDir(x, ys) ->
      seq (g'_args ys (Asm.get_arg_regs x)) { exps = []; last = Jmp(x); label = "" }
  | NonTail(a), Asm.CallDir(x, ys) ->
      let b = g'_args ys (Asm.get_arg_regs x) in
      let ra = Asm.get_reg_ra x in
      let b = seq b (exp "" (Call(x, ra))) in
      let r = Asm.get_ret_reg x in
      if List.mem a Asm.allregs && a <> r then seq b (exp ".count move_ret\n" (Mov(r, a)))
      else b
  | Tail, exp ->
      seq (g' saved (NonTail(!ret_reg), exp)) (ret ())
  | _ -> assert false
and g'_if saved dest cmp e1 e2 =
    let id = Id.genid "" in
    let mask = match cmp with Cmp(mask, _, _) -> mask | Cmpi(mask, _, _) -> mask in
    let stackset_back = !stackset in
    let b1 = g saved (dest, e1) in
    b1.label <- (string_of_mask mask) ^ id;
    let stackset1 = !stackset in
    stackset := stackset_back;
    let b2 = g saved (dest, e2) in
    b2.label <- (string_of_mask (neg_mask mask)) ^ id;
    let stackset2 = !stackset in
    match dest with
      | Tail ->
          { exps = []; last = CmpJmp(cmp, b1, b2); label = "" }
      | _ ->
			    stackset := S.inter stackset1 stackset2;
          let cont = { exps = []; last = Ret(""); label = "cont" ^ id} in
			    { exps = []; last = CmpJmp(cmp, seq b1 cont, seq b2 cont); label = "" }
and g'_args ys rs =
  let yrs = List.combine ys rs in
  List.fold_right
    (fun (y, r) b -> seq (exp ".count move_args\n" (Mov(y, r))) b
    ) (shuffle Asm.reg_tmp yrs) (nop ())

let h x e =
  ret_reg := Asm.get_ret_reg x;
  reg_ra := Asm.get_reg_ra x;
  need_ra := (M.find x !Asm.fundata).Asm.need_ra;
  stacksize := List.length (calcStack [] e) + (if !need_ra then 1 else 0);
  stackset := S.empty;
  stackmap := [];
  let b = g false (Tail, e) in
  b.label <- x;
  b

let f (Asm.Prog(data, funs, e)) =
  Format.eprintf "generating assembly...@.";
  Prog(data, List.map (fun f -> (f.Asm.name, h f.Asm.name f.Asm.body)) (funs @ [e]))
