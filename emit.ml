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
  | NonTail(x), Set(i) -> Printf.fprintf oc "\tset\t%s %d\n" x i
  | NonTail(x), SetL(Id.L(y)) -> Printf.fprintf oc "\tset\t%s %s\n" x y
  | NonTail(x), Mov(y) when x = y -> ()
  | NonTail(x), Mov(y) -> Printf.fprintf oc "\taddi\t%s %s %d\n" y x 0
  | NonTail(x), Neg(y) -> Printf.fprintf oc "\tsub\t%s %s %s\n" reg_zero y x
  | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s %s %s\n" y z x
	| NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s %s %d\n" y x z
  | NonTail(x), Sub(y, V(z)) -> Printf.fprintf oc "\tsub\t%s %s %s\n" y z x
  | NonTail(x), Sub(y, C(z)) -> Printf.fprintf oc "\taddi\t%s %s %d\n" y x (-z)
  | NonTail(x), Ld(y, V(z)) ->
			g' oc (NonTail(reg_asm), Add(y, V(z)));
			g' oc (NonTail(x), Ld(reg_asm, C(0)))
  | NonTail(x), Ld(y, C(z)) -> Printf.fprintf oc "\tload\t%s %s %d\n" y x z
  | NonTail(r), St(x, y, V(z)) ->
			g' oc (NonTail(reg_asm), Add(y, V(z)));
			g' oc (NonTail(r), St(x, reg_asm, C(0)))
  | NonTail(_), St(x, y, C(z)) -> Printf.fprintf oc "\tstore\t%s %s %d\n" y x z
  | NonTail(x), FMov(y) when x = y -> ()
  | NonTail(x), FMov(y) -> g' oc (NonTail(x), Mov(y))
  | NonTail(x), FNeg(y) -> Printf.fprintf oc "\tsub\t%s %s %s\n" reg_fzero y x
  | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s %s %s\n" y z x
  | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s %s %s\n" y z x
  | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s %s %s\n" y z x
  | NonTail(x), FDiv(y, z) ->
			Printf.fprintf oc "\tfinv\t %s %s\n" reg_fasm z;
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
      Printf.fprintf oc "\tjr\t%s\n" reg_ra
  | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ | Ld _ as exp) ->
      g' oc (NonTail(regs.(0)), exp);
      Printf.fprintf oc "\tjr\t%s\n" reg_ra
  | Tail, (FMov _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | LdF _  as exp) ->
      g' oc (NonTail(fregs.(0)), exp);
      Printf.fprintf oc "\tjr\t%s\n" reg_ra
  | Tail, (Restore(x) as exp) ->
			(if List.mem x allregs then g' oc (NonTail(regs.(0)), exp)
			else g' oc (NonTail(fregs.(0)), exp));
      Printf.fprintf oc "\tjr\t%s\n" reg_ra
  | Tail, IfEq(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_tail_if oc e1 e2 "be" "0b010"
  | Tail, IfEq(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfEq(x, V(reg_asm), e1, e2))
  | Tail, IfLE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_tail_if oc e1 e2 "ble" "0b011"
  | Tail, IfLE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfLE(x, V(reg_asm), e1, e2))
  | Tail, IfGE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_tail_if oc e1 e2 "bge" "0b110"
  | Tail, IfGE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (Tail, IfGE(x, V(reg_asm), e1, e2))
  | Tail, IfFEq(x, y, e1, e2) -> g' oc (Tail, IfEq(x, V(y), e1, e2))
  | Tail, IfFLE(x, y, e1, e2) -> g' oc (Tail, IfLE(x, V(y), e1, e2))
  | NonTail(z), IfEq(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "be" "0b010"
  | NonTail(z), IfEq(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfEq(x, V(reg_asm), e1, e2))
  | NonTail(z), IfLE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "ble" "0b011"
  | NonTail(z), IfLE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfLE(x, V(reg_asm), e1, e2))
  | NonTail(z), IfGE(x, V(y), e1, e2) ->
      Printf.fprintf oc "\tcmp\t%s %s %s\n" x y reg_asm;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "bge" "0b110"
  | NonTail(z), IfGE(x, C(y), e1, e2) ->
			g' oc (NonTail(reg_asm), Set(y));
			g' oc (NonTail(z), IfGE(x, V(reg_asm), e1, e2))
  | NonTail(z), IfFEq(x, y, e1, e2) -> g' oc (NonTail(z), IfEq(x, V(y), e1, e2))
  | NonTail(z), IfFLE(x, y, e1, e2) -> g' oc (NonTail(z), IfLE(x, V(y), e1, e2))
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs;
			g' oc (NonTail(reg_sw), Ld(reg_cl, C(0)));
      Printf.fprintf oc "\tjr\t%s\n" reg_sw
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs;
      Printf.fprintf oc "\tjmp\t%s 0 %s\n" reg_asm x
  | NonTail(a), CallCls(x, ys, zs) ->
      g'_args oc [(x, reg_cl)] ys zs;
      let ss = stacksize () in
			g' oc (NonTail(a), St(reg_ra, reg_sp, C(ss - 1)));
			g' oc (NonTail(reg_sw), Ld(reg_cl, C(0)));
			let ra = Id.genid ("cls") in
			g' oc (NonTail(reg_ra), SetL(Id.L(ra)));
			g' oc (NonTail(reg_sp), Add(reg_sp, C(ss)));
      Printf.fprintf oc "\tjr\t%s\n" reg_sw;
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
      Printf.fprintf oc "\tjal\t%s\n" x;
			g' oc (NonTail(reg_sp), Sub(reg_sp, C(ss)));
			g' oc (NonTail(reg_ra), Ld(reg_sp, C(ss - 1)));
      if List.mem a allregs && a <> regs.(0) then
				Printf.fprintf oc "\tmov\t%s, %s\n" regs.(0) a
      else if List.mem a allfregs && a <> fregs.(0) then
				Printf.fprintf oc "\tfmovs\t%s, %s\n" fregs.(0) a
and g'_tail_if oc e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  Printf.fprintf oc "\tjmp\t%s %s %s\n" reg_asm bn b_else;
  let stackset_back = !stackset in
  g oc (Tail, e1);
  Printf.fprintf oc "%s:\n" b_else;
  stackset := stackset_back;
  g oc (Tail, e2)
and g'_non_tail_if oc dest e1 e2 b bn =
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  Printf.fprintf oc "\tjmp\t%s %s %s\n" reg_asm bn b_else;
  let stackset_back = !stackset in
  g oc (dest, e1);
  let stackset1 = !stackset in
  Printf.fprintf oc "\tjmp\t%s 0 %s\n" reg_asm b_cont;
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
  List.iter
    (fun (Id.L(x), d) -> Printf.fprintf oc "%s:\t raw %.10E\n" x d)
    data;
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc "min_caml_start:\n";
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(reg_asm), e);
  Printf.fprintf oc "\thalt\n";
