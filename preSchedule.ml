open Asm

let getDelay = function
  | Set _ | SetL _ | Neg _ | Add _ | Sub _ | SLL _ | FNeg _ | FAbs _ -> 1
  | Ld _ | LdFL _ -> 2
  | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> 4
  | _ -> 0

let getRead exp = fv' exp

let getWrite (id, t) = [id]

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let noEffect = function
  | IfEq _ | IfLE _ | IfGE _ | IfFEq _ | IfFLE _ | CallDir _ | St _ -> false
  | _ -> true

let rec getFirst reads writes = function
  | Let(id, exp, e) when noEffect exp || reads = [] && writes = [] ->
      let read = getRead exp in
      let write = getWrite id in
      if (inter (reads @ writes) write) <> [] || (inter writes read) <> [] then getFirst (read@reads) (write@writes) e
      else (id, exp) :: (getFirst (read@reads) (write@writes) e)
  | _ -> []

let rec remove id = function
  | Let(id', exp, e) when id' = id -> e
  | Let(id', exp, e) -> Let(id', exp, remove id e)
  | _ -> assert false

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let miss = ref 0

let rec g awrite = function
  | Ans(IfEq(x, y', e1, e2)) -> Ans(IfEq(x, y', g [] e1, g [] e2))
  | Ans(IfLE(x, y', e1, e2)) -> Ans(IfLE(x, y', g [] e1, g [] e2))
  | Ans(IfGE(x, y', e1, e2)) -> Ans(IfGE(x, y', g [] e1, g [] e2))
  | Ans(IfFEq(x, y, e1, e2)) -> Ans(IfFEq(x, y, g [] e1, g [] e2))
  | Ans(IfFLE(x, y, e1, e2)) -> Ans(IfFLE(x, y, g [] e1, g [] e2))
  | Ans _ as e -> e
  | Forget(x, e) -> Forget(x, g awrite e)
  | Let(id, IfEq(x, y', e1, e2), e) -> Let(id, IfEq(x, y', g [] e1, g [] e2), g [] e)
  | Let(id, IfLE(x, y', e1, e2), e) -> Let(id, IfLE(x, y', g [] e1, g [] e2), g [] e)
  | Let(id, IfGE(x, y', e1, e2), e) -> Let(id, IfGE(x, y', g [] e1, g [] e2), g [] e)
  | Let(id, IfFEq(x, y, e1, e2), e) -> Let(id, IfFEq(x, y, g [] e1, g [] e2), g [] e)
  | Let(id, IfFLE(x, y, e1, e2), e) -> Let(id, IfFLE(x, y, g [] e1, g [] e2), g [] e)
  | e ->
		  let awrite = aging awrite in
		  let write = List.fold_left (fun x (_, y) -> y @ x) [] awrite in
		  let exps = getFirst [] write e in
		  if exps <> [] then
		    let (id, exp) = List.hd exps in
		    Let(id, exp, g ((getDelay exp, getWrite id) :: awrite)(remove id e))
		  else
		    (incr miss; g awrite e)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g [] e; ret = t }

let f (Prog(data, fundefs, e)) =
  miss := 0;
  let fundefs = List.map h fundefs in
  let e = g [] e in
  Format.eprintf "MissCount: %d@." !miss;
  Prog(data, fundefs, e)
