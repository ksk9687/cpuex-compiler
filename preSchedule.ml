open Asm

let off = ref false

let miss = ref 0

let str_id_or_imm = function
  | C(i) -> Format.sprintf "%d" i
  | V(id) -> Format.sprintf "%s" id
  | L(l) -> Format.sprintf "%s" l
let rec str = function
  | Ans(exp) -> Format.printf "Ans "; str' exp
  | Let((id, _), exp, e) -> Format.printf "Let %s = " id; str' exp; str e
  | _ -> assert false
and str' = function
  | Nop -> Format.printf "Nop@."
  | Set(i) -> Format.printf "%d@." i
  | SetL(s) -> Format.printf "%s@." s
  | Mov(s) | FMov(s) -> Format.printf "%s@." s
  | Add(a, b) -> Format.printf "%s + %s@." a (str_id_or_imm b)
  | Sub(a, b) -> Format.printf "%s - %s@." a (str_id_or_imm b)
  | Ld(a, b) -> Format.printf "[%s + %s]@." (str_id_or_imm a) (str_id_or_imm b)
  | St(a, b, c) -> Format.printf "[%s + %s] = %s@." (str_id_or_imm b) (str_id_or_imm c) a
  | FNeg(a) -> Format.printf "-.%s@." a
  | FInv(a, _) -> Format.printf "1/%s@." a
  | FSqrt(a, _) -> Format.printf "sqrt(%s)@." a
  | FAbs(a) -> Format.printf "|%s|@." a
  | FAdd(a, b, _) -> Format.printf "%s +. %s@." a b
  | FSub(a, b, _) -> Format.printf "%s -. %s@." a b
  | FMul(a, b, _) -> Format.printf "%s *. %s@." a b
  | LdFL(a) -> Format.printf "[%s]@." a
  | If(cmp, e1, e2) -> Format.printf "if@.then@."; str e1; Format.printf "else@."; str e2
  | CallDir(a, _) -> Format.printf "call %s@." a
  | _ -> assert false

let getDelay = function
  | Set _ | SetL _ | Add _ | Sub _ | FNeg _ | FAbs _ -> 1
  | Ld _ | LdFL _ -> 2
  | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> 4
  | _ -> 0

let getRead exp =
  match exp with
    | Ld _ -> "memory" :: fv' exp
    | exp -> fv' exp

let getWrite (id, t) = function
  | St _ -> ["memory"]
  | _ -> [id]

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let addMax x y xs =
  if M.mem x xs then M.add x (max (M.find x xs) y) xs
  else M.add x y xs

let rec getFirst reads writes = function
  | Let(id, exp, e) -> (
      match exp with
        | If _ | CallDir _ -> []
        | exp ->
            let read = getRead exp in
            let write = getWrite id exp in
            if (inter (reads @ writes) write) <> [] || (inter writes read) <> [] then
              getFirst (read @ reads) (write @ writes) e
            else (id, exp) :: (getFirst (read @ reads) (write @ writes) e)
    )
  | Ans(exp) -> []
  | _ -> assert false

let rec getCritical time = function
  | Let(id, exp, e) -> (
      match exp with
        | If _ | CallDir _ -> 0
        | exp ->
            let t = List.fold_left
              (fun t r ->
                if M.mem r time then max t (M.find r time)
                else t
              ) 0 (getRead exp) in
            let d = t + (getDelay exp) + 1 in
            let time = List.fold_left
              (fun time r -> addMax r d time
              ) time (getWrite id exp) in
            max t (getCritical time e)
    )
  | Ans(exp) ->
      List.fold_left
        (fun t r ->
          if M.mem r time then max t (M.find r time)
          else t
        ) 0 (getRead exp)
  | _ -> assert false

let rec remove id exp = function
  | Let(id', exp', e) when id' = id -> (assert (exp = exp'); e)
  | Let(id', exp', e) -> Let(id', exp', remove id exp e)
  | _ -> assert false

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let rec g awrite e =
  let awrite = aging awrite in
  let write = List.fold_left (fun x (_, y) -> y @ x) [] awrite in
  match e with
    | Ans(exp) -> (
        match exp with
          | If(cmp, e1, e2) -> Ans(If(cmp, g [] e1, g [] e2))
          | exp -> Ans(exp)
      )
    | Let(id, If(cmp, e1, e2), e3) ->
        Let(id, If(cmp, g [] e1, g [] e2), g [] e3)
    | Let(id, CallDir(x, ys), e) ->
        Let(id, CallDir(x, ys), g [] e)
    | e ->
        let exps = getFirst [] write e in
        if exps <> [] then
          let time = List.fold_left
            (fun time (t, rs) -> List.fold_left
              (fun time r -> addMax r t time
              ) time rs
            ) M.empty awrite in
          let ts = List.map
            (fun (id, exp) ->
              let t = getDelay exp in
              let time = List.fold_left
                (fun time r -> addMax r t time
                ) time (getWrite id exp) in
              (getCritical time (remove id exp e), id, exp)
            ) exps in
          let (_, id, exp) = List.fold_left
            (fun (d, id, exp) (d', id', exp') ->
              if d > d' then (d', id', exp')
              else (d, id, exp)
            ) (List.hd ts) (List.tl ts) in
          Let(id, exp, g ((getDelay exp, getWrite id exp) :: awrite) (remove id exp e))
        else
          (incr miss; g awrite e)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g [] e; ret = t }
(*  let e' = g [] e in
  Format.printf "@.%s@." l;
  str e';
  { name = l; args = xs; body = e'; ret = t }*)

let rec f (Prog(data, fundefs, e)) =
  if !off then (Prog(data, fundefs, e))
  else (
	  miss := 0;
	  let fundefs = List.map h fundefs in
	  let e = h e in
	  Format.eprintf "MissCount: %d@." !miss;
	  Prog(data, fundefs, e)
  )
