open Scalar

let name s =
  try String.sub s 0 (String.index s '.')
  with Not_found -> s

let rec g oc cont = function
  | End -> ()
  | Seq(Exp(asm, _, _), e) ->
      Printf.fprintf oc "%s" asm;
      g oc cont e
  | If(b, bn, e1, e2, e3) ->
      let cont' = seq e3 cont in
      if cont' = End then
		    let b_else = Id.genid (b ^ "_else") in
	 	    Printf.fprintf oc "\t%-8s%s\n" bn b_else;
		    g oc cont' e1;
		    Printf.fprintf oc "%s:\n" b_else;
		    g oc cont' e2
      else if e1 = End then
		    let b_skip = Id.genid (b ^ "_skip") in
		        Printf.fprintf oc "\t%-8s%s\n" b b_skip;
		        g oc cont' e2;
		        Printf.fprintf oc "%s:\n" b_skip;
		    g oc cont e3
      else if e2 = End then
		    let bn_skip = Id.genid (bn ^ "_skip") in
		        Printf.fprintf oc "\t%-8s%s\n" bn bn_skip;
		        g oc cont' e1;
		        Printf.fprintf oc "%s:\n" bn_skip;
		    g oc cont e3
      else
		    let b_else = Id.genid (b ^ "_else") in
	      let b_cont = Id.genid (b ^ "_cont") in
	 	    Printf.fprintf oc "\t%-8s%s\n" bn b_else;
		    g oc cont' e1;
	      Printf.fprintf oc "\t%-8s%s\n" "b" b_cont;
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
