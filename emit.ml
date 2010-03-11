open Block

let used = ref S.empty

let get b =
  try M.find b.label !inCount
  with Not_found -> 0

let decr b =
  inCount := M.add b.label ((get b) - 1) !inCount

let rec g oc b =
  assert (b.label <> "");
  (if (S.mem b.label !used) then (Format.eprintf "Error: %s, %d@." b.label (M.find b.label !inCount); assert false));
  used := S.add b.label !used;
  Printf.fprintf oc "%s:\n" b.label;
  List.iter
    (fun (s, exp) ->
      Printf.fprintf oc "%s%s\n" s (string_of_exp exp)
    ) b.exps;
  match b.last with
    | Ret(ra) ->
        if ra = Asm.reg_ra then Printf.fprintf oc "\t%-8s\n" "ret"
        else Printf.fprintf oc "\t%-8s%s\n" "jr" ra
    | Jmp(x) ->
        Printf.fprintf oc "\t%-8s%s\n" "b" x
    | CmpJmp(cmp, ({ exps = []; last = Jmp(x) } as b1), b2) ->
          decr b1;
          decr b2;
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) x;
          if (get b2) = 0 then (
            g oc b2
          ) else (
            Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b2.label
          )
    | CmpJmp(cmp, b1, ({ exps = []; last = Jmp(x) } as b2)) ->
          decr b1;
          decr b2;
          Printf.fprintf oc "%s, %s\n" (string_of_cmp (neg cmp)) x;
          if (get b1) = 0 then (
            g oc b1
          ) else (
            Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b1.label
          )
    | CmpJmp(cmp, b1, b2) ->
        decr b1;
        decr b2;
        if (get b1) = 0 then (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp (neg cmp)) b2.label;
          g oc b1;
          if (get b2) = 0 && not (S.mem b2.label !used) then g oc b2;
        ) else if (get b2) = 0 then (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) b1.label;
          g oc b2;
          if (get b1) = 0 && not (S.mem b1.label !used) then g oc b1;
        ) else (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) b1.label;
          Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b2.label
        )
    | Cont(b1) ->
        decr b1;
        if (get b1) = 0 then g oc b1
        else Printf.fprintf oc ".count b_cont\n\t%-8s%s\n" "b" b1.label

let h oc (x, b) =
  let name = Id.name x in
  Asm.output_fun_header oc x name;
  Printf.fprintf oc ".begin %s\n" name;
  used := S.empty;
  inCount := M.empty;
  setCount b;
  used := S.empty;
  g oc b;
(*  Format.eprintf "%s: %d@." x (S.cardinal !used); *)
  Printf.fprintf oc ".end %s\n" name

let f oc (Prog(data, fundefs)) =
  Asm.output_header oc;
  List.iter
    (fun (x, d) -> if d <> 0.0 then Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d)
    data;
  List.iter (h oc) fundefs
