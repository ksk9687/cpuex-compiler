let limit = ref 1000

let opts = [Movelet.f; ConstArg.f; ConstFold.f; Cse.f; Inline.f; Assoc.f; Beta.f]

let rec iter n e =
  Format.eprintf "iteration %d@." n;
  if n = 0 then e
  else
    let e' = List.fold_right (fun f e -> f e) opts e in
    if e = e' then e
    else iter (n - 1) e'

let lexbuf outchan l =
  Id.counter := 0;
  Typing.extenv := M.empty;
  Emit.f outchan
    (MoveAsm.f
      (Scalar.f
        (RegAlloc.f
          (AbsNegFlag.f
	          (Sglobal.f
	            (PreSchedule.f
	              (Sfl.f
	                (Slabel.f
	                  (Simm.f
	                    (Virtual.f
	                      (Closure.f
	                        (iter !limit
	                          (Alpha.f
	                            (KNormal.f
	                              (BuiltIn.f
	                                (Typing.f
	                                  (Parser.exp Lexer.token l)))))))))))))))))

let string s = lexbuf stdout (Lexing.from_string s)

let file f =
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  try
    lexbuf outchan (Lexing.from_channel inchan);
    close_in inchan;
    close_out outchan;
  with e -> (close_in inchan; close_out outchan; raise e)

let () =
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-inline_cont", Arg.Int(fun i -> Inline.threshold2 := i), "maximum size of continuations inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated")]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-inline_cont m] [-iter n] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files

(* report1 *)
(*
let test_k_lexbuf l =
  Id.counter := 0;
  Typing.extenv := M.empty;
                (iter !limit
                   (Alpha.f
                      (KNormal.f
                         (Typing.f
                            (Parser.exp Lexer.token l)))))

let test_k s = KNormal.string (test_k_lexbuf (Lexing.from_string s))

let test_s_lexbuf l =
  Typing.extenv := M.empty;
                         (Typing.f
                            (Parser.exp Lexer.token l))
let test_s s = Syntax.string (test_s_lexbuf (Lexing.from_string s))
*)
