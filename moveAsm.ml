open Scalar

let rec size = function
  | End -> 0
  | Seq(_, e) -> 1 + (size e)
  | If(_, _, e1, e2, e3) -> 2 + (size e1) + (size e2) + (size e3)

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

let rec g cont = function
  | End -> End
  | Seq(Exp(asm, _, _) as exp, e) ->
      Seq(exp, g cont e)
  | If(b, bn, e1, e2, e3) ->
      let cont' = seq e3 cont in
      let exps = inter (getFirst ["cond"] [] e1) (getFirst ["cond"] [] e2) in
      if e1 = End && e2 = End then
        (Format.eprintf "RemoveJmp@."; g cont e3)
      else if exps <> [] then
        let exp = List.hd exps in
        (Format.eprintf "MoveFirst@."; Seq(exp, g cont (If(b, bn, remove exp e1, remove exp e2, e3))))
      else if cont' <> End && (size cont') <= 5 then
        (Format.eprintf "MoveCont %d@." (size cont'); If(b, bn, g End (seq e1 cont'), g End (seq e2 cont'), End))
      else
        If(b, bn, g cont' e1, g cont' e2, g cont e3)

let rec f (Prog(data, fundefs, e)) =
  let fundefs' = List.map (fun (x, e) -> (x, g End e)) fundefs in
  let e' = g End e in
  if fundefs' = fundefs && e = e' then (Prog(data, fundefs, e))
  else f (Prog(data, fundefs', e'))
