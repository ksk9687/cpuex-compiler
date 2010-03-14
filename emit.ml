open Block

let used = ref S.empty

let miss = ref 0
let pc = ref 0

let get b =
  try M.find b.label !inCount
  with Not_found -> 0

let decr b =
  inCount := M.add b.label ((get b) - 1) !inCount

let deg b =
  match b.last with
    | CmpJmp(_, b1, b2) -> (get b1) + (get b2)
    | Cont(b1) -> (get b1)
    | _ -> 0

(*
let rec g' oc prev = function
  | [] -> ()
  | (s, exp) :: exps ->
      Printf.fprintf oc "%s%s\n" s (string_of_exp exp);
      incr pc;
      g' oc (getUnit exp) exps
*)

let rec g' oc prev = function
  | [] -> ()
  | (s, exp) :: exps when !pc mod 2 = 0 ->
      Printf.fprintf oc "%s%s\n" s (string_of_exp exp);
      incr pc;
      g' oc (getUnit exp) exps
  | es ->
      let exps = getFirst S.empty S.empty es in
      let exps = List.filter (fun (_, exp) -> (getUnit exp) <> prev) exps in
      let (s, exp) = List.hd (if exps = [] then (incr miss; es) else exps) in
      Printf.fprintf oc "%s%s\n" s (string_of_exp exp);
      incr pc;
      g' oc (getUnit exp) (removeFirst (s, exp) es)

let rec g oc b =
  assert (b.label <> "");
  (if (S.mem b.label !used) then (Format.eprintf "Error: %s, %d@." b.label (M.find b.label !inCount); assert false));
  used := S.add b.label !used;
  Printf.fprintf oc "%s:\n" b.label;
  g' oc JMP b.exps;
  match b.last with
    | Ret(ra) ->
        if ra = Asm.reg_ra then Printf.fprintf oc "\t%-8s\n" "ret"
        else Printf.fprintf oc "\t%-8s%s\n" "jr" ra;
        incr pc
    | Jmp(x) ->
        Printf.fprintf oc "\t%-8s%s\n" "b" x;
        incr pc
    | CmpJmp(cmp, ({ exps = []; last = Jmp(x) } as b1), b2) ->
          decr b1;
          decr b2;
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) x;
          incr pc;
          if (get b2) = 0 then (
            g oc b2
          ) else (
            Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b2.label;
            incr pc
          )
    | CmpJmp(cmp, b1, ({ exps = []; last = Jmp(x) } as b2)) ->
          decr b1;
          decr b2;
          Printf.fprintf oc "%s, %s\n" (string_of_cmp (neg cmp)) x;
          incr pc;
          if (get b1) = 0 then (
            g oc b1
          ) else (
            Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b1.label;
            incr pc
          )
    | CmpJmp(cmp, b1, b2) ->
        decr b1;
        decr b2;
        if (get b1) = 0 && ((get b2) > 0 || (deg b1) > (deg b2)) then (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp (neg cmp)) b2.label;
          incr pc;
          g oc b1;
          if (get b2) = 0 && not (S.mem b2.label !used) then g oc b2;
        ) else if (get b2) = 0 then (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) b1.label;
          incr pc;
          g oc b2;
          if (get b1) = 0 && not (S.mem b1.label !used) then g oc b1;
        ) else (
          Printf.fprintf oc "%s, %s\n" (string_of_cmp cmp) b1.label;
          incr pc;
          Printf.fprintf oc ".count dual_jmp\n\t%-8s%s\n" "b" b2.label;
          incr pc
        )
    | Cont(b1) ->
        decr b1;
        if (get b1) = 0 then g oc b1
        else (
          Printf.fprintf oc ".count b_cont\n\t%-8s%s\n" "b" b1.label;
          incr pc
        )

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
  if not !Id.lib then Asm.output_header oc;
  Printf.fprintf oc "#.align 2\n";
  pc := 0;
  miss := 0;
  List.iter
    (fun (x, d) -> if d <> 0.0 then Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d
    ) data;
  List.iter (h oc) (if !Id.lib then (List.rev (List.tl (List.rev fundefs))) else fundefs);
  Format.eprintf "MissCount: %d@.Size: %d@." !miss !pc

