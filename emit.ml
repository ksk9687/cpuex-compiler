open Asm

let stacksize = ref 0
let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
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
let offset x = (List.hd (locate x)) + 1

let pp_id_or_imm = function
  | V(x) -> x
  | C(i) -> string_of_int i
  | L(Id.L(l)) -> l

let name s =
  try String.sub s 0 (String.index s '.')
  with Not_found -> s

(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  (* find acyclic moves *)
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

let check_args ys =
  let _, res =
    List.fold_left
      (fun (i, res) y -> (i + 1, res && y = regs.(i)))
      (1, true)
      ys
  in res

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

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g oc saved (dest, e) =  (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  let tail = (match dest with Tail -> true | _ -> false) in
  let saved' =
    if (not saved) && hasNonTailCall tail e then
      (g' oc saved (NonTail(reg_sp), Sub(reg_sp, C(!stacksize)));
       g' oc saved (NonTail(reg_tmp), St(reg_ra, V(reg_sp), C(0)));
       true)
    else if saved && tail && notHasNonTailCall tail e then
      (g' oc saved (NonTail(reg_ra), Ld(V(reg_sp), C(0)));
       g' oc saved (NonTail(reg_sp), Add(reg_sp, C(!stacksize)));
       false)
    else
      saved
  in
  match e with
  | Ans(exp) -> g' oc saved' (dest, exp)
  | Let((x, t), exp, e) ->
      g' oc saved' (NonTail(x), exp);
      g oc saved' (dest, e)
  | Forget _ -> assert false
and g' oc saved = function (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> () (*Printf.fprintf oc "\tnop\n"*)
(* liは符号拡張しない… *)
  | NonTail(x), Set(i) when i < 0 -> g' oc saved (NonTail(x), Add(reg_zero, C(i)))
  | NonTail(x), Set(i) -> Printf.fprintf oc "\t%-8s%d, %s\n" "li" i x
  | NonTail(x), SetL(Id.L(y)) -> Printf.fprintf oc "\t%-8s%s, %s\n" "li" y x
  | NonTail(x), Mov(y) when x = y -> ()
  | NonTail(x), Mov(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "mov" y x
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "neg" y x
  | NonTail(x), Add(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "add" y (pp_id_or_imm z') x
  | NonTail(x), Sub(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "sub" y (pp_id_or_imm z') x
  | NonTail(x), SLL(y, i) -> Printf.fprintf oc "\t%-8s%s, %d, %s\n" "sll" y i x
  | NonTail(x), Ld(y', C(z)) when z < 0 -> Printf.fprintf oc "\t%-8s[%s - %d], %s\n" "load" (pp_id_or_imm y') (-z) x
  | NonTail(x), Ld(y', z') -> Printf.fprintf oc "\t%-8s[%s + %s], %s\n" "load" (pp_id_or_imm y') (pp_id_or_imm z') x
  | NonTail(r), St(x, V(y), V(z)) ->
      g' oc saved (NonTail(reg_tmp), Add(y, V(z)));
      g' oc saved (NonTail(r), St(x, V(reg_tmp), C(0)))
  | NonTail(_), St(x, y', C(z)) when z < 0 -> Printf.fprintf oc "\t%-8s%s, [%s - %d]\n" "store" x (pp_id_or_imm y') (-z)
  | NonTail(_), St(x, y', z') -> Printf.fprintf oc "\t%-8s%s, [%s + %s]\n" "store" x (pp_id_or_imm y') (pp_id_or_imm z')
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "fneg" y x
  | NonTail(x), FInv(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "finv" y x
  | NonTail(x), FSqrt(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "fsqrt" y x
  | NonTail(x), FAbs(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "fabs" y x
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fadd" y z x
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fsub" y z x
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fmul" y z x
  | NonTail(x), LdFL(Id.L(l)) -> Printf.fprintf oc "\t%-8s[%s], %s\n" "load" l x
  | NonTail(_), MovR(x, y) -> g' oc saved (NonTail(y), Mov(x))
  | NonTail(_), Comment(s) -> Printf.fprintf oc "\t# %s\n" s
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(r), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      g' oc saved (NonTail(r), St(x, V(reg_sp), C(offset y - (if saved then 0 else !stacksize))))
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) ->
      assert (List.mem x allregs);
      g' oc saved (NonTail(x), Ld(V(reg_sp), C(offset y - (if saved then 0 else !stacksize))))
  (* 末尾だったら計算結果を第一レジスタにセットしてret (caml2html: emit_tailret) *)
  | Tail, (Nop | St _ | MovR _ | Comment _ | Save _ as exp) ->
      g' oc saved (NonTail(Id.gentmp Type.Unit), exp);
      Printf.fprintf oc "\tret\n"
  | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ | SLL _ | Ld _ |
           FNeg _ | FInv _ | FSqrt _ | FAbs _ | FAdd _ | FSub _ | FMul _ | LdFL _ as exp) ->
      g' oc saved (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tret\n"
  | Tail, (Restore(x) as exp) ->
      (if List.mem x allregs then g' oc saved (NonTail(regs.(0)), exp)
      else g' oc saved (NonTail(regs.(0)), exp));
      Printf.fprintf oc "\tret\n"
  | Tail, IfEq(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_tail_if oc saved e1 e2 "be" "bne"
  | Tail, IfLE(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_tail_if oc saved e1 e2 "ble" "bg"
  | Tail, IfGE(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_tail_if oc saved e1 e2 "bge" "bl"
  | Tail, IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "fcmp" x y;
      g'_tail_if oc saved e1 e2 "be" "bne"
  | Tail, IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "fcmp" x y;
      g'_tail_if oc saved e1 e2 "ble" "bg"
  | NonTail(z), IfEq(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_non_tail_if oc saved (NonTail(z)) e1 e2 "be" "bne"
  | NonTail(z), IfLE(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_non_tail_if oc saved (NonTail(z)) e1 e2 "ble" "bg"
  | NonTail(z), IfGE(x, y', e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "cmp" x (pp_id_or_imm y');
      g'_non_tail_if oc saved (NonTail(z)) e1 e2 "bge" "bl"
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "fcmp" x y;
      g'_non_tail_if oc saved (NonTail(z)) e1 e2 "be" "bne"
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s\n" "fcmp" x y;
      g'_non_tail_if oc saved (NonTail(z)) e1 e2 "ble" "bg"
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys;
      g' oc saved (NonTail(reg_tmp), Ld(V(reg_cl), C(0)));
      Printf.fprintf oc "\t%-8s%s\n" "jr" reg_tmp
  | Tail, CallDir(Id.L(x), ys) -> (* 末尾呼び出し *)
      g'_args oc [] ys;
      Printf.fprintf oc "\t%-8s%s\n" "b" x
  | NonTail(a), CallCls(x, ys) ->
      g'_args oc [(x, reg_cl)] ys;
      g' oc saved (NonTail(reg_tmp), Ld(V(reg_cl), C(0)));
      let ra = Id.genid ("cls") in
      g' oc saved (NonTail(reg_ra), SetL(Id.L(ra)));
      Printf.fprintf oc "\t%-8s%s\n" "jr" reg_tmp;
      Printf.fprintf oc "%s:\n" ra;
      if List.mem a allregs && a <> regs.(0) then
        g' oc saved (NonTail(a), Mov(regs.(0)))
  | NonTail(a), CallDir(Id.L(x), ys) ->
      g'_args oc [] ys;
      Printf.fprintf oc "\t%-8s%s\n" "jal" x;
      if List.mem a allregs && a <> regs.(0) then
      g' oc saved (NonTail(a), Mov(regs.(0)))
and g'_tail_if oc saved e1 e2 b bn =
  match e1, e2 with
    | Ans(CallDir(Id.L(x), ys)), _ when check_args ys ->
        Format.eprintf "hoge@.";
        Printf.fprintf oc "\t%-8s%s\n" b x;
        g oc saved (Tail, e2)
    | _, Ans(CallDir(Id.L(x), ys)) when check_args ys ->
        Format.eprintf "hoge@.";
        Printf.fprintf oc "\t%-8s%s\n" bn x;
        g oc saved (Tail, e1)
    | _ ->
        let b_else = Id.genid (b ^ "_else") in
        Printf.fprintf oc "\t%-8s%s\n" bn b_else;
        let stackset_back = !stackset in
        g oc saved (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc saved (Tail, e2)
and g'_non_tail_if oc saved dest e1 e2 b bn =
  match e1, e2 with
    | Ans(Nop), _ ->
        let b_skip = Id.genid (b ^ "_skip") in
        Printf.fprintf oc "\t%-8s%s\n" b b_skip;
        let stackset_back = !stackset in
        g oc saved (dest, e2);
        Printf.fprintf oc "%s:\n" b_skip;
        stackset := stackset_back
    | _, Ans(Nop) ->
        let bn_skip = Id.genid (bn ^ "_skip") in
        Printf.fprintf oc "\t%-8s%s\n" bn bn_skip;
        let stackset_back = !stackset in
        g oc saved (dest, e1);
        Printf.fprintf oc "%s:\n" bn_skip;
        stackset := stackset_back
    | _ ->
        let b_else = Id.genid (b ^ "_else") in
        let b_cont = Id.genid (b ^ "_cont") in
        Printf.fprintf oc "\t%-8s%s\n" bn b_else;
        let stackset_back = !stackset in
        g oc saved (dest, e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\t%-8s%s\n" "b" b_cont;
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc saved (dest, e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (1, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> g' oc true (NonTail(r), Mov(y)))
    (shuffle reg_tmp yrs)

let h oc { name = Id.L(x); args = _; body = e; ret = _ } =
  Printf.fprintf oc "\n######################################################################\n";
  Printf.fprintf oc ".begin %s\n" (name x);
  Printf.fprintf oc "%s:\n" x;
  stacksize := List.length (calcStack [] e) + 1;
  stackset := S.empty;
  stackmap := [];
  g oc false (Tail, e);
  Printf.fprintf oc ".end %s\n" (name x)

let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  List.iter
    (fun (Id.L(x), d) -> if d <> 0.0 then Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d)
    data;
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc "\n######################################################################\n";
  Printf.fprintf oc ".begin start\n";
  Printf.fprintf oc "min_caml_start:\n";
  stacksize := List.length (calcStack [] e) + 1;
  stackset := S.empty;
  stackmap := [];
  g oc false (NonTail(reg_tmp), e);
  Printf.fprintf oc "\thalt\n";
  Printf.fprintf oc ".end start\n"
