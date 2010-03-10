open Block

(*
let delay =
  List.fold_left
    (fun m (n,list) ->
       List.fold_left (fun m x -> M.add x n m) m list)
    M.empty
(*    [(0,["store";"mov";"li";"add";"addi";"sub";"subi";"sll";"cmp";"cmpi";"fcmp";"fabs";"fneg"]);
     (1,["load";"loadr";"read";"write"]);
     (2,["fadd";"fsub";"fmul";"finv";"fsqrt"])]*)
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

let addMax x y xs =
  if M.mem x xs then M.add x (max (M.find x xs) y) xs
  else M.add x y xs

let rec getCritical time = function
  | Seq(exp, e) ->
      let t = List.fold_left
        (fun t r ->
          if M.mem r time then max t (M.find r time)
          else t
        ) 0 (getRead exp) in
      let d = t + (getDelay exp) + 1 in
      let time = List.fold_left
        (fun time r -> addMax r d time
        ) time (getWrite exp) in
      max t (getCritical time e)
  | _ -> 0

let rec addLast e = function
  | End -> e
  | Call(s, e', ra) -> Call(s, addLast e e', ra)
  | Seq(exp, e') -> Seq(exp, addLast e e')
  | CmpJmp(cmp, b, bn, e1, e2, e3, rs) -> CmpJmp(cmp, b, bn, e1, e2, addLast e e3, rs)
  | _ -> assert false

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let miss = ref 0

let rec schedule awrite = function
  | End | Ret _ | Jmp _ as e -> e
  | Call(s, e, ra) -> Call(s, schedule [] e, ra)
  | CmpJmp(cmp, b, bn, e1, e2, e3, rs) -> CmpJmp(cmp, b, bn, schedule [] e1, schedule [] e2, schedule [] e3, rs)
  | Seq(exp, e) as es ->
      let awrite = aging awrite in
      let write = List.fold_left (fun x (_, y) -> y @ x) [] awrite in
      let exps = getFirst [] write es in
      if exps <> [] then
        let time = List.fold_left
          (fun time (t, rs) -> List.fold_left
            (fun time r -> addMax r t time
            ) time rs
          ) M.empty awrite in
        let ts = List.map
          (fun exp ->
            let t = getDelay exp in
            let time = List.fold_left
              (fun time r -> addMax r t time
              ) time (getWrite exp) in
            (getCritical time (remove exp es), exp)
          ) exps in
        let (_, exp) = List.fold_left
          (fun (t, exp) (t', exp') ->
            if t > t' then (t', exp')
            else (t, exp)
          ) (List.hd ts) (List.tl ts) in
        Seq(exp, schedule ((getDelay exp, getWrite exp) :: awrite) (remove exp es))
      else
        (incr miss; schedule awrite es)

*)

let getRead' = function
  | Cmp(_, x, y) -> [x; y]
  | Cmpi(_, x, _) -> [x]

let getRead = function
  | Li _ | Call _ -> []
  | Addi(x, _, _) | Mov(x, _) | FInv(_, x, _) | FSqrt(_, x, _) | FAbs(x, _) | FNeg(x, _) -> [x]
  | Add(x, y, _) | Sub(x, y, _) | FAdd(_, x, y, _) | FSub(_, x, y, _) | FMul(_, x, y, _) | Store(x, y, _) -> [x; y]
  | Load(x, _, y) -> [x; y; "memory"]
  | Loadr(x, y, z) -> [x; y; z; "memory"]

let getWrite = function
  | Li(_, x) | Addi(_, _, x) | Mov(_, x) | Add(_, _, x) | Sub(_, _, x) | Call(_, x) |
    FAdd(_, _, _, x) | FSub(_, _, _, x) | FMul(_, _, _, x) | FInv(_, _, x) | FSqrt(_, _, x) |
    FAbs(_, x) | FNeg(_, x) | Load(_, _, x) | Loadr(_, _, x) -> [x]
  | Store _ -> ["memory"]

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

let rec removeFirst exp = function
  | exp' :: exps when exp' = exp -> exps
  | exp' :: exps -> exp' :: removeFirst exp exps
  | _ -> assert false

let rec getFirst reads writes = function
  | (_, Call _) :: _  | [] -> []
  | (s, exp) :: exps ->
      let read = getRead exp in
      let write = getWrite exp in
      if (inter (reads @ writes) write) <> [] || (inter writes read) <> [] then
        getFirst (read @ reads) (write @ writes) exps
      else
        (s, exp) :: (getFirst (read @ reads) (write @ writes)) exps

let getBlockID b =
  let str = match b.last with
    | Ret(ra) -> "ret_" ^ ra
    | Jmp(x) -> "jmp_" ^ x
    | CmpJmp(cmp, b1, b2) -> "cmpjmp_" ^ (string_of_cmp cmp) ^ "_" ^ b1.label ^ "_" ^ b2.label
    | Cont(b1) -> "cont_" ^ b1.label in
  (b.exps, str)

(*
let rec same exps1 exps2 =
  if exps1 = [] && exps2 = [] then true
  else
	  let exps = inter (getFirst [] [] exps1) (getFirst [] [] exps2) in
	  if exps = [] then false
    else
      let exp = List.hd exps in
      same (removeFirst exp exps1) (removeFirst exp exps2)

let rec find (exps, str) = function
  | [] -> raise Not_found
  | ((exps', str'), b) :: bs when str = str' && (List.length exps) = (List.length exps') && same exps exps' -> b
  | b' :: bs -> find (exps, str) bs
*)

let removeCmpJmp env b =
  b

let change = ref false
let memo = ref M.empty
let blocks = ref []

let rec g b =
  if M.mem b.label !memo then
    M.find b.label !memo
  else try
(*    let b' = find (getBlockID b) !blocks in *)
    let b' = List.assoc (getBlockID b) !blocks in
    change := true;
    memo := M.add b.label b' !memo;
    b'
  with Not_found ->
    let b' =
      match b.exps, b.last with
        | _, Cont(b1) ->
            change := true;
            b.exps <- b.exps @ b1.exps;
            b.last <- b1.last;
            b
        | _, CmpJmp(_, b1, b2) when b1.label = b2.label ->
            change := true;
            b.exps <- b.exps @ b1.exps;
            b.last <- b1.last;
            b
        | _, CmpJmp(cmp, b1, b2) when (get b1) = 1 && (get b2) = 1 ->
            let rs = getRead' cmp in
            let exps = inter (getFirst rs [] b1.exps) (getFirst rs [] b2.exps) in
            if exps <> [] then (
              change := true;
              let exp = List.hd exps in
              b.exps <- b.exps @ [exp];
              b1.exps <- removeFirst exp b1.exps;
              b2.exps <- removeFirst exp b2.exps
            );
            b.last <- CmpJmp(cmp, g b1, g b2);
            b
        | _, CmpJmp(cmp, b1, b2) ->
            b.last <- CmpJmp(cmp, g b1, g b2);
            b
        | _ -> b in
    memo := M.add b.label b' !memo;
    blocks := (getBlockID b', b') :: !blocks;
    b'

let rec h b =
  change := false;
  setCount b;
  memo := M.empty;
  blocks := [];
  let b = g b in
  if !change then h b
  else b

let f (Prog(data, fundefs)) =
  let fundefs = List.map (fun (f, b) -> (f, h b)) fundefs in
  Prog(data, fundefs)
