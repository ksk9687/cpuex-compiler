open Asm

(*
let str_id_or_imm = function
  | C(i) -> Format.sprintf "%d" i
  | V(id) -> Format.sprintf "%s" id
  | L(Id.L(l)) -> Format.sprintf "%s" l
let rec str = function
  | Ans(exp) -> Format.printf "Ans "; str' exp
  | Let((id, _), exp, e) -> Format.printf "Let %s = " id; str' exp; str e
  | _ -> assert false
and str' = function
  | Nop -> Format.printf "Nop@."
  | Set(i) -> Format.printf "%d@." i
  | SetL(Id.L(s)) -> Format.printf "%s@." s
  | Mov(s) -> Format.printf "%s@." s
  | Neg(s) -> Format.printf "-%s@." s
  | Add(a, b) -> Format.printf "%s + %s@." a (str_id_or_imm b)
  | Sub(a, b) -> Format.printf "%s - %s@." a (str_id_or_imm b)
  | Ld(a, b) -> Format.printf "[%s + %s]@." (str_id_or_imm a) (str_id_or_imm b)
  | St(a, b, c) -> Format.printf "[%s + %s] = %s@." (str_id_or_imm b) (str_id_or_imm c) a
  | FNeg(a) -> Format.printf "-.%s@." a
  | FInv(a) -> Format.printf "1/%s@." a
  | FSqrt(a) -> Format.printf "sqrt(%s)@." a
  | FAbs(a) -> Format.printf "|%s|@." a
  | FAdd(a, b) -> Format.printf "%s +. %s@." a b
  | FSub(a, b) -> Format.printf "%s -. %s@." a b
  | FMul(a, b) -> Format.printf "%s *. %s@." a b
  | LdFL(Id.L(a)) -> Format.printf "[%s]@." a
  | MovR(a, b) -> Format.printf "%s = %s@." a b
  | IfEq(a, b, e1, e2) -> Format.printf "%s = %s@.then@." a (str_id_or_imm b); str e1; Format.printf "else@."; str e2
  | IfLE(a, b, e1, e2) -> Format.printf "%s <= %s@.then@." a (str_id_or_imm b); str e1; Format.printf "else@."; str e2
  | IfGE(a, b, e1, e2) -> Format.printf "%s >= %s@.then@." a (str_id_or_imm b); str e1; Format.printf "else@."; str e2
  | IfFEq(a, b, e1, e2) -> Format.printf "%s =. %s@.then@." a b; str e1; Format.printf "else@."; str e2
  | IfFLE(a, b, e1, e2) -> Format.printf "%s <=. %s@.then@." a b; str e1; Format.printf "else@."; str e2
  | CallDir(Id.L(a), _) -> Format.printf "call %s@." a
  | _ -> assert false
*)
let getDelay = function
  | Set _ | SetL _ | Add _ | Sub _ | FNeg _ | FAbs _ -> 1
  | Ld _ | LdFL _ -> 2
  | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> 4
  | _ -> 0
(*
let getDelay = function
  | Set _ | SetL _ | Neg _ | Add _ | Sub _ | SLL _ | FNeg _ | FAbs _ -> 0
  | Ld _ | LdFL _ -> 1
  | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> 2
  | _ -> 0
*)
let getRead exp = fv' exp

let getWrite (id, t) = [id]

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let addMax x y xs =
  if M.mem x xs then M.add x (max (M.find x xs) y) xs
  else M.add x y xs

let rec noEffect = function
  | CallDir _ | St _ -> false
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
      (noEffect' e1) && (noEffect' e2)
  | _ -> true
and noEffect' = function
  | Let(_, exp, e) -> (noEffect exp) && (noEffect' e)
  | Ans(exp) -> noEffect exp
  | _ -> assert false

let rec getFirst depth st ld writes = function
  | Let(id, exp, e) -> (
      match exp with
        | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
            let write = getWrite id in
            let exps = (getFirst (depth + 1) st true writes e1) @ (getFirst (depth + 1) st true writes e2) in
            if noEffect exp then (getFirst depth st ld (write@writes) e) @ exps
            else exps
        | CallDir _ -> []
        | St _ when ld -> []
        | Ld _ when st -> []
        | exp ->
            let read = getRead exp in
            let write = getWrite id in
            let st = (match exp with St _ -> true | _ -> st) in
            let ld = (match exp with Ld _ -> true | _ -> ld) in
            if (inter writes read) <> [] then getFirst depth st ld (write@writes) e
            else (depth, id, exp) :: (getFirst depth st ld (write@writes) e)
    )
  | Ans(exp) -> (
      match exp with
        | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | IfGE(_, _, e1, e2) | IfFEq(_, _, e1, e2) | IfFLE(_, _, e1, e2) ->
            (getFirst (depth + 1) st true writes e1) @ (getFirst (depth + 1) st true writes e2)
        | _ -> []
    )
  | _ -> assert false

let rec getCritical time = function
  | Let(id, exp, e) -> (
      match exp with
        | IfEq _ | IfLE _ | IfGE _ | IfFEq _ | IfFLE _ ->
            List.fold_left
              (fun t r ->
                if M.mem r time then max t (M.find r time)
                else t
              ) 0 (getRead exp)
        | CallDir _ -> 0
        | exp ->
            let t = List.fold_left
              (fun t r ->
                if M.mem r time then max t (M.find r time)
                else t
              ) 0 (getRead exp) in
            let d = t + (getDelay exp) + 1 in
            let time = List.fold_left
              (fun time r -> addMax r d time
              ) time (getWrite id) in
            max t (getCritical time e)
    )
  | Ans(exp) -> (
      match exp with
        | exp ->
            List.fold_left
              (fun t r ->
                if M.mem r time then max t (M.find r time)
                else t
              ) 0 (getRead exp)
    )
  | _ -> assert false

let rec remove id exp = function
  | Let(id', exp', e) when id' = id -> (assert (exp = exp'); e)
  | Let(id', IfEq(x, y, e1, e2), e) -> Let(id', IfEq(x, y, remove id exp e1, remove id exp e2), remove id exp e)
  | Let(id', IfLE(x, y, e1, e2), e) -> Let(id', IfLE(x, y, remove id exp e1, remove id exp e2), remove id exp e)
  | Let(id', IfGE(x, y, e1, e2), e) -> Let(id', IfGE(x, y, remove id exp e1, remove id exp e2), remove id exp e)
  | Let(id', IfFEq(x, y, e1, e2), e) -> Let(id', IfFEq(x, y, remove id exp e1, remove id exp e2), remove id exp e)
  | Let(id', IfFLE(x, y, e1, e2), e) -> Let(id', IfFLE(x, y, remove id exp e1, remove id exp e2), remove id exp e)
  | Let(id', exp', e) -> Let(id', exp', remove id exp e)
  | Ans(IfEq(x, y, e1, e2)) -> Ans(IfEq(x, y, remove id exp e1, remove id exp e2))
  | Ans(IfLE(x, y, e1, e2)) -> Ans(IfLE(x, y, remove id exp e1, remove id exp e2))
  | Ans(IfGE(x, y, e1, e2)) -> Ans(IfGE(x, y, remove id exp e1, remove id exp e2))
  | Ans(IfFEq(x, y, e1, e2)) -> Ans(IfFEq(x, y, remove id exp e1, remove id exp e2))
  | Ans(IfFLE(x, y, e1, e2)) -> Ans(IfFLE(x, y, remove id exp e1, remove id exp e2))
  | e -> e

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let miss = ref 0

let rec g awrite e =
  let awrite = aging awrite in
  let write = List.fold_left (fun x (_, y) -> y @ x) [] awrite in
  match e with
    | Ans(exp) when (inter write (getRead exp) = []) -> ((*!!!!*)
        match exp with
          | IfEq(x, y, e1, e2) -> Ans(IfEq(x, y, g [] e1, g [] e2))
          | IfLE(x, y, e1, e2) -> Ans(IfLE(x, y, g [] e1, g [] e2))
          | IfGE(x, y, e1, e2) -> Ans(IfGE(x, y, g [] e1, g [] e2))
          | IfFEq(x, y, e1, e2) -> Ans(IfFEq(x, y, g [] e1, g [] e2))
          | IfFLE(x, y, e1, e2) -> Ans(IfFLE(x, y, g [] e1, g [] e2))
          | exp -> Ans(exp)
      )
    | Let(id, exp, e) when (inter write (getRead exp) = []) -> (
        match exp with
          | IfEq(x, y, e1, e2) -> Let(id, IfEq(x, y, g [] e1, g [] e2), g [] e)
          | IfLE(x, y, e1, e2) -> Let(id, IfLE(x, y, g [] e1, g [] e2), g [] e)
          | IfGE(x, y, e1, e2) -> Let(id, IfGE(x, y, g [] e1, g [] e2), g [] e)
          | IfFEq(x, y, e1, e2) -> Let(id, IfFEq(x, y, g [] e1, g [] e2), g [] e)
          | IfFLE(x, y, e1, e2) -> Let(id, IfFLE(x, y, g [] e1, g [] e2), g [] e)
          | exp -> Let(id, exp, g ((getDelay exp, getWrite id) :: awrite) e)
      )
    | e ->
        let exps = getFirst 0 false false write e in
        if exps <> [] then
          let time = List.fold_left
            (fun time (t, rs) -> List.fold_left
              (fun time r -> addMax r t time
              ) time rs
            ) M.empty awrite in
          let ts = List.map
            (fun (d, id, exp) ->
              let t = getDelay exp in
              let time = List.fold_left
                (fun time r -> addMax r t time
                ) time (getWrite id) in
              ((getCritical time (remove id exp e), d), id, exp)
            ) exps in
          let (_, id, exp) = List.fold_left
            (fun (d, id, exp) (d', id', exp') ->
              if d > d' then (d', id', exp')
              else (d, id, exp)
            ) (List.hd ts) (List.tl ts) in
          Let(id, exp, g ((getDelay exp, getWrite id) :: awrite) (remove id exp e))
        else
          (incr miss; g awrite e)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g [] e; ret = t }

let f' (Prog(fundata, global, data, fundefs, e)) =
  miss := 0;
  let fundefs = List.map h fundefs in
  let e = g [] e in
  Format.eprintf "MissCount: %d@." !miss;
  Prog(fundata, global, data, fundefs, e)

let rec f e =
  let e' = f' e in
  if e = e' then e
  else f e'

let f e = e
