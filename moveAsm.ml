open Scalar

let getRead = function
  | Exp(_, read, _) -> read

let getWrite = function
  | Exp(_, _, write) -> write

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let rec getFirst reads writes = function
  | Seq(Exp(asm, read, write) as exp, e) when not (List.mem "all" write) ->
      if (inter (reads @ writes) write) <> [] || (inter writes read) <> [] then getFirst (read@reads) (write@writes) e
      else exp :: (getFirst (read@reads) (write@writes) e)
  | _ -> []

let rec remove exp = function
  | Seq(exp', e) when exp' = exp -> e
  | Seq(exp', e) -> Seq(exp', remove exp e)
  | _ -> assert false

let rec g = function
  | End | Ret _ | Jmp _ as e -> e
  | Call(s, e) -> Call(s, g e)
  | Seq(Exp(asm, _, _) as exp, e) -> Seq(exp, g e)
  | If(b, bn, e1, e2, e3) ->
      let exps = inter (getFirst ["cond"] [] e1) (getFirst ["cond"] [] e2) in
      if e1 = End && e2 = End then
        ((*Format.eprintf "RemoveJmp@.";*) g e3)
      else if exps <> [] then
        let exp = List.hd exps in
        ((*Format.eprintf "MoveFirst@.";*) Seq(exp, g (If(b, bn, remove exp e1, remove exp e2, e3))))
      else
        If(b, bn, g e1, g e2, g e3)

let rec schedule write = function
  | End | Ret _ | Jmp _ as e -> e
  | Call(s, e) -> Call(s, schedule [] e)
  | If(b, bn, e1, e2, e3) -> If(b, bn, schedule [] e1, schedule [] e2, schedule [] e3)
  | Seq(exp, e) -> Seq(exp, schedule [] e)

let rec h e =
  let e' = g e in
  if e' = e then schedule [] e'
  else h e

let f (Prog(data, fundefs, e)) =
  let fundefs = List.map (fun (f, e) -> (f, h e)) fundefs in
  let e = h e in
  Prog(data, fundefs, e)
