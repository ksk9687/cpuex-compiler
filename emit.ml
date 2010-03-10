open Scalar

let rec g oc cont = function
  | End -> ()
  | Ret(asm, _) -> Printf.fprintf oc "%s" asm
  | Jmp(s, label) -> Printf.fprintf oc "%s\t%-8s%s\n" s "b" label
  | Call(asm, e, _) | Seq(Exp(asm, _, _, _), e) ->
      Printf.fprintf oc "%s" asm;
      g oc cont e
  | If(cmp, b, bn, e1, e2, e3, rs) ->
      let cont' = seq e3 cont in
      let id = Id.genid "" in
      match cont', e1, e2 with
        | _, Jmp(s, label), _ ->
            assert (cont' = End);
            Format.eprintf "CondJmp\n";
            Printf.fprintf oc "%s\t%-8s%s, %s\n" s b cmp label;
            g oc cont' e2
        | _, _, Jmp(s, label) ->
            assert (cont' = End);
            Format.eprintf "CondJmp\n";
            Printf.fprintf oc "%s\t%-8s%s, %s\n" s bn cmp label;
            g oc cont' e1
        | End, _, _ ->
            let b_else = b ^ "_else" ^ id in
            let b_then = b ^ "_then" ^ id in
             Printf.fprintf oc "\t%-8s%s, %s\n" bn cmp b_else;
            Printf.fprintf oc "%s:\n" b_then;
            g oc cont' e1;
            Printf.fprintf oc "%s:\n" b_else;
            g oc cont' e2
        | Jmp(_, label), End, _ ->
            let bn_then = bn ^ "_then" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" b cmp label;
            Printf.fprintf oc "%s:\n" bn_then;
            g oc cont' e2;
            g oc cont e3
        | Jmp(_, label), _, End ->
            let b_then = b ^ "_then" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" bn cmp label;
            Printf.fprintf oc "%s:\n" b_then;
            g oc cont' e1;
            g oc cont e3
        | _, End, _ ->
            let bn_then = bn ^ "_then" ^ id in
            let bn_cont = bn ^ "_cont" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" b cmp bn_cont;
            Printf.fprintf oc "%s:\n" bn_then;
            g oc cont' e2;
            Printf.fprintf oc "%s:\n" bn_cont;
            g oc cont e3
        | _, _, End ->
            let b_then = b ^ "_then" ^ id in
            let b_cont = b ^ "_cont" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" bn cmp b_cont;
            Printf.fprintf oc "%s:\n" b_then;
            g oc cont' e1;
            Printf.fprintf oc "%s:\n" b_cont;
            g oc cont e3
        | Jmp _ as jmp, _, _ ->
            let b_then = b ^ "_then" ^ id in
            let b_else = b ^ "_else" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" bn cmp b_else;
            Printf.fprintf oc "%s:\n" b_then;
            g oc cont' (seq e1 jmp);
            Printf.fprintf oc "%s:\n" b_else;
            g oc cont' e2;
            g oc cont e3
        | _ ->
            let b_then = b ^ "_then" ^ id in
            let b_else = b ^ "_else" ^ id in
            let b_cont = b ^ "_cont" ^ id in
            Printf.fprintf oc "\t%-8s%s, %s\n" bn cmp b_else;
            Printf.fprintf oc "%s:\n" b_then;
            g oc cont' (seq e1 (Jmp(".count b_cont\n", b_cont)));
            Printf.fprintf oc "%s:\n" b_else;
            g oc cont' e2;
            Printf.fprintf oc "%s:\n" b_cont;
            g oc cont e3

let h oc x e =
  let name = Id.name x in
  Asm.output_fun_header oc x name;
  Printf.fprintf oc ".begin %s\n" name;
  Printf.fprintf oc "%s:\n" x;
  g oc End e;
  Printf.fprintf oc ".end %s\n" name

let f oc (Prog(data, fundefs, e)) =
  Asm.output_header oc;
  List.iter
    (fun (x, d) -> if d <> 0.0 then Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d)
    data;
  List.iter (fun (x, e) -> h oc x e) fundefs;
  h oc "ext_main" e
