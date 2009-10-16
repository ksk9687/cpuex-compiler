open Asm

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
let offset x = List.hd (locate x)
let stacksize () = (List.length !stackmap + 1)

let pp_id_or_imm = function
  | V(x) -> x
  | C(i) -> string_of_int i

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

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g oc = function (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | dest, Ans(exp) -> g' oc (dest, exp)
  | dest, Let((x, t), exp, e) ->
      g' oc (NonTail(x), exp);
      g oc (dest, e)
  | _, Forget _ -> assert false
and g' oc = function (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  | NonTail(_), Nop -> ()
  | NonTail(x), Set(i) -> Printf.fprintf oc "\t%-8s%d, %s\n" "li" i x
  | NonTail(x), SetL(Id.L(y)) -> Printf.fprintf oc "\t%-8s%s, %s\n" "li" y x
  | NonTail(x), Mov(y) when x = y -> ()
  | NonTail(x), Mov(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "mov" y x
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "neg" y x
  | NonTail(x), Add(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "add" y (pp_id_or_imm z') x
  | NonTail(x), Sub(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "sub" y (pp_id_or_imm z') x
	| NonTail(x), SLL(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "sll" y (pp_id_or_imm z') x
	| NonTail(x), SRL(y, z') -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "srl" y (pp_id_or_imm z') x
  | NonTail(x), Ld(y, V(z)) ->
			g' oc (NonTail(reg_asm), Add(y, V(z)));
			g' oc (NonTail(x), Ld(reg_asm, C(0)))
  | NonTail(x), Ld(y, C(z)) -> Printf.fprintf oc "\t%-8s%d(%s), %s\n" "load" z y x
  | NonTail(r), St(x, y, V(z)) ->
			g' oc (NonTail(reg_asm), Add(y, V(z)));
			g' oc (NonTail(r), St(x, reg_asm, C(0)))
  | NonTail(_), St(x, y, C(z)) -> Printf.fprintf oc "\t%-8s%s, %d(%s)\n" "store" x z y
  | NonTail(x), FMov(y) when x = y -> ()
  | NonTail(x), FMov(y) -> g' oc (NonTail(x), Mov(y))
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\t%-8s%s, %s\n" "fneg" y x
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fadd" y z x
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fsub" y z x
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fmul" y z x
  | NonTail(x), FDiv(y, z) ->
			Printf.fprintf oc "\t%-8s%s, %s\n" "finv" z reg_fasm;
			g' oc (NonTail(x), FMul(y, reg_fasm))
  | NonTail(x), LdF(y, z') -> g' oc (NonTail(x), Ld(y, z'))
  | NonTail(r), StF(x, y, z') -> g' oc (NonTail(r), St(x, y, z'))
  | NonTail(_), Comment(s) -> Printf.fprintf oc "\t# %s\n" s
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(r), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
			g' oc (NonTail(r), St(x, reg_sp, C(offset y)))
  | NonTail(r), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      savef y;
			g' oc (NonTail(r), StF(x, reg_sp, C(offset y)))
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
			g' oc (NonTail(x), Ld(reg_sp, C(offset y)))
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
			g' oc (NonTail(x), LdF(reg_sp, C(offset y)))
  (* 末尾だったら計算結果を第一レジスタにセットしてret (caml2html: emit_tailret) *)
  | Tail, (Nop | St _ | StF _ | Comment _ | Save _ as exp) ->
      g' oc (NonTail(Id.gentmp Type.Unit), exp);
      Printf.fprintf oc "\tret\n"
  | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ | SLL _ | SRL _ | Ld _ as exp) ->
      g' oc (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tret\n"
  | Tail, (FMov _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | LdF _  as exp) ->
      g' oc (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tret\n"
  | Tail, (Restore(x) as exp) ->
			(if List.mem x allregs then g' oc (NonTail(regs.(0)), exp)
			else g' oc (NonTail(fregs.(0)), exp));
      Printf.fprintf oc "\tret\n"
  | Tail, IfEq(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_tail_if oc e1 e2 "be" "bne"
  | Tail, IfEq(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfEq(x, V(reg_asm), e1, e2))
  | Tail, IfLE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_tail_if oc e1 e2 "ble" "bg"
  | Tail, IfLE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfLE(x, V(reg_asm), e1, e2))
  | Tail, IfGE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_tail_if oc e1 e2 "bge" "bl"
  | Tail, IfGE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfGE(x, V(reg_asm), e1, e2))
  | Tail, IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fcmp" x y reg_asm;
      g'_tail_if oc e1 e2 "be" "bne"
  | Tail, IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fcmp" x y reg_asm;
      g'_tail_if oc e1 e2 "ble" "bg"
  | NonTail(z), IfEq(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "be" "bne"
  | NonTail(z), IfEq(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfEq(x, V(reg_asm), e1, e2))
  | NonTail(z), IfLE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "bg"
  | NonTail(z), IfLE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfLE(x, V(reg_asm), e1, e2))
  | NonTail(z), IfGE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "cmp" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "bl"
  | NonTail(z), IfGE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfGE(x, V(reg_asm), e1, e2))
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fcmp" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "be" "bne"
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      Printf.fprintf oc "\t%-8s%s, %s, %s\n" "fcmp" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "bg"
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs;
			g' oc (NonTail(reg_sw), Ld(reg_cl, C(0)));
      Printf.fprintf oc "\t%-8s%s\n" "jr" reg_sw
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs;
      Printf.fprintf oc "\t%-8s%s\n" "b" x
  | NonTail(a), CallCls(x, ys, zs) ->
      g'_args oc [(x, reg_cl)] ys zs;
      let ss = stacksize () in
			g' oc (NonTail(a), St(reg_ra, reg_sp, C(ss - 1)));
			g' oc (NonTail(reg_sw), Ld(reg_cl, C(0)));
			let ra = Id.genid ("cls") in
			g' oc (NonTail(reg_ra), SetL(Id.L(ra)));
			g' oc (NonTail(reg_sp), Add(reg_sp, C(ss)));
      Printf.fprintf oc "\t%-8s%s\n" "jr" reg_sw;
			Printf.fprintf oc "%s:\n" ra;
			g' oc (NonTail(reg_sp), Sub(reg_sp, C(ss)));
			g' oc (NonTail(reg_ra), Ld(reg_sp, C(ss - 1)));
      if List.mem a allregs && a <> regs.(0) then
				g' oc (NonTail(a), Mov(regs.(0)))
      else if List.mem a allfregs && a <> fregs.(0) then
				g' oc (NonTail(a), FMov(fregs.(0)))
  | NonTail(a), CallDir(Id.L(x), ys, zs) ->
      g'_args oc [] ys zs;
      let ss = stacksize () in
			g' oc (NonTail(a), St(reg_ra, reg_sp, C(ss - 1)));
			g' oc (NonTail(reg_sp), Add(reg_sp, C(ss)));
      Printf.fprintf oc "\t%-8s%s\n" "jal" x;
			g' oc (NonTail(reg_sp), Sub(reg_sp, C(ss)));
			g' oc (NonTail(reg_ra), Ld(reg_sp, C(ss - 1)));
      if List.mem a allregs && a <> regs.(0) then
				g' oc (NonTail(regs.(0)), Mov(a))
      else if List.mem a allfregs && a <> fregs.(0) then
				g' oc (NonTail(fregs.(0)), FMov(a))
and g'_tail_if oc e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  Printf.fprintf oc "\t%-8s%s, %s\n" bn reg_asm b_else;
  let stackset_back = !stackset in
  g oc (Tail, e1);
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (Tail, e2)
and g'_non_tail_if oc dest e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\t%-8s%s, %s\n" bn reg_asm b_else;
  let stackset_back = !stackset in
  g oc (dest, e1);
  let stackset1 = !stackset in
  Printf.fprintf oc "\t%-8s%s\n" "b" b_cont;
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (dest, e2);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys zs =
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> g' oc (NonTail(r), Mov(y)))
    (shuffle reg_sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> g' oc (NonTail(fr), FMov(z)))
    (shuffle reg_fsw zfrs)

let h oc { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)

let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(reg_asm), e);
  Printf.fprintf oc "\thalt\n";
  List.iter (fun fundef -> h oc fundef) fundefs;
  List.iter
    (fun (Id.L(x), d) -> Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d)
    data
