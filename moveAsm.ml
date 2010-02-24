open Scalar

let delay =
  List.fold_left
    (fun m (n,list) ->
       List.fold_left (fun m x -> M.add x n m) m list)
    M.empty
    [(0,["store";"mov"]);
     (1,["li";"add";"addi";"sub";"subi";"sll";"cmp";"cmpi";"fcmp";"fabs";"fneg";"read";"write"]);
     (2,["load";"loadr"]);
     (3,[]);
     (4,["fadd";"fsub";"fmul";"finv";"fsqrt"])]

let getDelay exp =
  let Exp(_, inst, _, _) = exp in
  try
    M.find inst delay
  with Not_found -> print_string inst; assert false

let getRead = function
  | Exp(_, _, read, _) -> read

let getWrite = function
  | Exp(_, _, _, write) -> write

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let rec getFirst reads writes = function
  | Seq(Exp(_, _, read, write) as exp, e) ->
      if (inter (reads @ writes) write) <> [] || (inter writes read) <> [] then getFirst (read@reads) (write@writes) e
      else exp :: (getFirst (read@reads) (write@writes) e)
  | _ -> []

let rec remove exp = function
  | Seq(exp', e) when exp' = exp -> e
  | Seq(exp', e) -> Seq(exp', remove exp e)
  | _ -> assert false

let rec addLast e = function
  | End -> e
  | Call(s, e') -> Call(s, addLast e e')
  | Seq(exp, e') -> Seq(exp, addLast e e')
  | If(b, bn, e1, e2, e3) -> If(b, bn, e1, e2, addLast e e3)
  | _ -> assert false

let rec g = function
  | End | Ret _ | Jmp _ as e -> e
  | Call(s, e) -> Call(s, g e)
  | Seq(Exp(asm, _, _, _) as exp, e) -> Seq(exp, g e)
  | If(b, bn, e1, e2, e3) ->
      let exps = inter (getFirst ["cond"] [] e1) (getFirst ["cond"] [] e2) in
      if e1 = End && e2 = End then
        ((*Format.eprintf "RemoveJmp@.";*) g e3)
      else if exps <> [] then
        let exp = List.hd exps in
        ((*Format.eprintf "MoveFirst@.";*) Seq(exp, g (If(b, bn, remove exp e1, remove exp e2, e3))))
      else
        If(b, bn, g e1, g e2, g e3)
        (*
        (*let exps = getFirst [] [] e3 in*)
        let exps = getFirst ["cond"] [] e3 in
        if exps <> [] then
          let exp = List.hd exps in
          g (If (b, bn, addLast (Seq(exp, End)) e1, addLast (Seq(exp, End)) e2, remove exp e3))
        else
          If(b, bn, g e1, g e2, g e3)
        (*
        match e3 with
          | Call(s, e) -> g (If(b, bn, addLast (Call(s, End)) e1, addLast (Call(s, End)) e2, e))
          | Seq(exp, e) -> g (If (b, bn, addLast (Seq(exp, End)) e1, addLast (Seq(exp, End)) e2, remove exp e3))
          | e3 -> If(b, bn, g e1, g e2, g e3)
        *)*)

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let miss = ref 0

let rec schedule awrite = function
  | End | Ret _ | Jmp _ as e -> e
  | Call(s, e) -> Call(s, schedule [] e)
  | If(b, bn, e1, e2, e3) -> If(b, bn, schedule (aging awrite) e1, schedule (aging awrite) e2, schedule [] e3)
  | Seq(exp, e) as es ->
      let awrite = aging awrite in
      let write = List.fold_left (fun x (_, y) -> y @ x) [] awrite in
      let exps = getFirst [] write es in
      if exps <> [] then
        let exp = List.hd exps in
        Seq(exp, schedule ((getDelay exp, getWrite exp) :: awrite) (remove exp es))
      else
        (incr miss; schedule awrite es)

let rec h e =
  let e' = g e in
  if e' = e then e(*schedule [] e'*)
  else h e'

let f (Prog(data, fundefs, e)) =
  miss := 0;
  let fundefs = List.map (fun (f, e) -> (f, h e)) fundefs in
  let e = h e in
  Format.eprintf "MissCount: %d@." !miss;
  Prog(data, fundefs, e)
