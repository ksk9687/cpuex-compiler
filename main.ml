let limit = ref 100

let opts = [Movelet.f; ConstArg.f; ConstFold.f; Cse.f; ConstArray.f; Inline.f; Assoc.f; BetaTuple.f; Beta.f]

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
      (Block.f
        (RegAlloc.f
          (PreSchedule.f
            (AbsNegFlag.f
              (Beta2.f
                (Sglobal.f
                  (Sfl.f
                    (ConstFold2.f
                      (Virtual.f
                        (Closure.f
                          (iter !limit
                            (Expand.f
                              (Alpha.f
                                (KNormal.f
	                                (BuiltIn.f
	                                  (Typing.f
	                                    (Parser.exp Lexer.token l))))))))))))))))))

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
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
     ("-noExpand", Arg.Unit(fun () -> Expand.off := true), "");
     ("-noMovelet", Arg.Unit(fun () -> Movelet.off := true), "");
     ("-noConstArg", Arg.Unit(fun () -> ConstArg.off := true), "");
     ("-noConstFold", Arg.Unit(fun () -> ConstFold.off := true), "");
     ("-noCse", Arg.Unit(fun () -> Cse.off := true), "");
     ("-noConstArray", Arg.Unit(fun () -> ConstArray.off := true), "");
     ("-noInline", Arg.Unit(fun () -> Inline.off := true), "");
     ("-noAssoc", Arg.Unit(fun () -> Assoc.off := true), "");
     ("-noBetaTuple", Arg.Unit(fun () -> BetaTuple.off := true), "");
     ("-noBeta", Arg.Unit(fun () -> Beta.off := true), "");
     ("-noChangeArgs", Arg.Unit(fun () -> Asm.off := true), "");
     ("-noSfl", Arg.Unit(fun () -> Sfl.off := true), "");
     ("-noSglobal", Arg.Unit(fun () -> Sglobal.off := true), "");
     ("-noConstFold2", Arg.Unit(fun () -> ConstFold2.off := true), "");
     ("-noBeta2", Arg.Unit(fun () -> Beta2.off := true), "");
     ("-noAbsNegFlag", Arg.Unit(fun () -> AbsNegFlag.off := true), "");
     ("-noPreSchedule", Arg.Unit(fun () -> PreSchedule.off := true), "");
     ("-noMoveAsm", Arg.Unit(fun () -> MoveAsm.off := true), "");
     ("-lib", Arg.Unit(fun () -> Id.lib := true; Asm.off := true; Sfl.off := true; Sglobal.off := true), "");
    ]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-inline_cont m] [-iter n] [-noHoge] [-lib] ...filenames without \".ml\"..." Sys.argv.(0));
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
