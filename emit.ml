open Scalar

let name s =
  try String.sub s 0 (String.index s '.')
  with Not_found -> s

let rec g oc cont = function
  | End -> ()
  | Ret(asm) -> Printf.fprintf oc "%s" asm
  | Jmp(s, label) -> Printf.fprintf oc "%s\t%-8s%s\n" s "b" label
  | Call(asm, e) | Seq(Exp(asm, _, _, _), e) ->
      Printf.fprintf oc "%s" asm;
      g oc cont e
  | If(b, bn, e1, e2, e3) ->
      let cont' = seq e3 cont in
      let id = Id.genid "" in
      match cont', e1, e2 with
        | _, Jmp(s, label), _ ->
            assert (cont' = End);
            Format.eprintf "CondJmp\n";
            Printf.fprintf oc "%s\t%-8s%s\n" s b label;
            g oc cont' e2
        | _, _, Jmp(s, label) ->
            assert (cont' = End);
            Format.eprintf "CondJmp\n";
            Printf.fprintf oc "%s\t%-8s%s\n" s bn label;
            g oc cont' e1
        | End, _, _ ->
				    let b_else = b ^ "_else" ^ id in
            let b_then = b ^ "_then" ^ id in
			 	    Printf.fprintf oc "\t%-8s%s\n" bn b_else;
				    Printf.fprintf oc "%s:\n" b_then;
				    g oc cont' e1;
				    Printf.fprintf oc "%s:\n" b_else;
				    g oc cont' e2
        | Jmp(_, label), End, _ ->
            let bn_then = bn ^ "_then" ^ id in
		        Printf.fprintf oc "\t%-8s%s\n" b label;
		        Printf.fprintf oc "%s:\n" bn_then;
		        g oc cont' e2;
				    g oc cont e3
        | Jmp(_, label), _, End ->
            let b_then = b ^ "_then" ^ id in
		        Printf.fprintf oc "\t%-8s%s\n" bn label;
		        Printf.fprintf oc "%s:\n" b_then;
		        g oc cont' e1;
				    g oc cont e3
        | _, End, _ ->
            let bn_then = bn ^ "_then" ^ id in
				    let bn_cont = bn ^ "_cont" ^ id in
		        Printf.fprintf oc "\t%-8s%s\n" b bn_cont;
		        Printf.fprintf oc "%s:\n" bn_then;
		        g oc cont' e2;
		        Printf.fprintf oc "%s:\n" bn_cont;
				    g oc cont e3
        | _, _, End ->
            let b_then = b ^ "_then" ^ id in
				    let b_cont = b ^ "_cont" ^ id in
		        Printf.fprintf oc "\t%-8s%s\n" bn b_cont;
		        Printf.fprintf oc "%s:\n" b_then;
		        g oc cont' e1;
		        Printf.fprintf oc "%s:\n" b_cont;
				    g oc cont e3
        | Jmp _ as jmp, _, _ ->
				    let b_then = b ^ "_then" ^ id in
				    let b_else = b ^ "_else" ^ id in
			 	    Printf.fprintf oc "\t%-8s%s\n" bn b_else;
				    Printf.fprintf oc "%s:\n" b_then;
				    g oc cont' (seq e1 jmp);
				    Printf.fprintf oc "%s:\n" b_else;
				    g oc cont' e2;
			      g oc cont e3
        | _ ->
				    let b_then = b ^ "_then" ^ id in
				    let b_else = b ^ "_else" ^ id in
			      let b_cont = b ^ "_cont" ^ id in
			 	    Printf.fprintf oc "\t%-8s%s\n" bn b_else;
				    Printf.fprintf oc "%s:\n" b_then;
				    g oc cont' (seq e1 (Jmp(".count b_cont\n", b_cont)));
				    Printf.fprintf oc "%s:\n" b_else;
				    g oc cont' e2;
			      Printf.fprintf oc "%s:\n" b_cont;
			      g oc cont e3

let h oc name x e =
  Printf.fprintf oc "\n######################################################################\n";
  Printf.fprintf oc ".begin %s\n" name;
  Printf.fprintf oc "%s:\n" x;
  g oc End e;
  Printf.fprintf oc ".end %s\n" name

let f oc (Prog(data, fundefs, e)) =
  List.iter
    (fun (Id.L(x), d) -> if d <> 0.0 then Printf.fprintf oc "%s:\t%-8s%.10E\n" x ".float" d)
    data;
  List.iter (fun (Id.L(x), e) -> h oc (name x) x e) fundefs;
  h oc "main" "min_caml_main" e
