open Block

let off = ref false

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
      if (not (S.is_empty (S.inter (S.union reads writes) write))) ||
         (not (S.is_empty (S.inter writes read))) then
        getFirst (S.union read reads) (S.union write writes) exps
      else
        (s, exp) :: (getFirst (S.union read reads) (S.union write writes)) exps

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
	  let exps = inter (getFirst S.empty S.empty exps1) (getFirst S.empty S.empty exps2) in
	  if exps = [] then false
    else
      let exp = List.hd exps in
      same (removeFirst exp exps1) (removeFirst exp exps2)

let rec find (exps, str) = function
  | [] -> raise Not_found
  | ((exps', str'), b) :: bs when str = str' && (List.length exps) = (List.length exps') && same exps exps' -> b
  | b' :: bs -> find (exps, str) bs
*)

let change = ref false
let memo = ref M.empty
let blocks = ref []

let noEffect exp =
  S.subset (getWrite exp) (S.of_list (Asm.alliregs @ Asm.allfregs))

let rec g' last env = function
  | [] -> (env, [])
  | (s, exp) :: exps when noEffect exp && S.is_empty (S.inter (getWrite exp) (fv' last exps)) ->
      change := true;
      g' last env exps
  | (s, exp) :: exps ->
      let env = match exp with
			  | Li(C(i), d) -> M.add d i env
        | Call _ -> M.empty
        | exp -> S.fold (fun r env -> M.remove r env) (getWrite exp) env in
      let (env, exps) = g' last env exps in
      (env, (s, exp) :: exps)

let rec g env b =
  if M.mem b.label !memo then
    M.find b.label !memo
  else try
(*    let b' = find (getBlockID b) !blocks in *)
    let b' = List.assoc (getBlockID b) !blocks in
    change := true;
    memo := M.add b.label b' !memo;
    b'
  with Not_found ->
    let env = if (M.find b.label !inCount) = 1 then env else M.empty in
    let (env, exps) = g' b.last env b.exps in
    b.exps <- exps;
    let b' =
      match b.last with
        | Cont(b1) ->
            change := true;
            b.exps <- b.exps @ b1.exps;
            b.last <- b1.last;
            b
        | CmpJmp(_, b1, b2) when b1.label = b2.label ->
            change := true;
            b.exps <- b.exps @ b1.exps;
            b.last <- b1.last;
            b
        | CmpJmp(cmp, b1, b2) when (M.find b1.label !inCount) = 1 && List.exists
                                     (fun (_, exp) ->
                                       noEffect exp && S.is_empty (S.inter (getWrite exp) (fv b2))
                                     ) (getFirst (getRead' cmp) S.empty (List.rev b.exps)) ->
            change := true;
            let exp = List.find
              (fun (_, exp) ->
                noEffect exp && S.is_empty (S.inter (getWrite exp) (fv b2))
              ) (getFirst (getRead' cmp) S.empty (List.rev b.exps)) in
            b.exps <- List.rev (removeFirst exp (List.rev b.exps));
            b1.exps <- exp :: b1.exps;
            b
        | CmpJmp(cmp, b1, b2) when (M.find b2.label !inCount) = 1 && List.exists
                                     (fun (_, exp) ->
                                       noEffect exp && S.is_empty (S.inter (getWrite exp) (fv b1))
                                     ) (getFirst (getRead' cmp) S.empty (List.rev b.exps)) ->
            change := true;
            let exp = List.find
              (fun (_, exp) ->
                noEffect exp && S.is_empty (S.inter (getWrite exp) (fv b1))
              ) (getFirst (getRead' cmp) S.empty (List.rev b.exps)) in
            b.exps <- List.rev (removeFirst exp (List.rev b.exps));
            b2.exps <- exp :: b2.exps;
            b
        | CmpJmp(Cmpi(mask, x, i), b1, b2) when M.mem x env ->
            change := true;
            let j = M.find x env in
            if cmp mask j i then (
              b.exps <- b.exps @ b1.exps;
              b.last <- b1.last;
              b
            ) else (
              b.exps <- b.exps @ b2.exps;
              b.last <- b2.last;
              b
            )
        | CmpJmp(cmp, b1, b2) when (M.find b1.label !inCount) = 1 && (M.find b2.label !inCount) = 1 ->
            let rs = getRead' cmp in
            let exps = inter (getFirst rs S.empty b1.exps) (getFirst rs S.empty b2.exps) in
            if exps <> [] then (
              change := true;
              let exp = List.hd exps in
              b.exps <- b.exps @ [exp];
              b1.exps <- removeFirst exp b1.exps;
              b2.exps <- removeFirst exp b2.exps
            );
            b.last <- CmpJmp(cmp, g env b1, g env b2);
            b
        | CmpJmp(cmp, b1, b2) ->
            b.last <- CmpJmp(cmp, g env b1, g env b2);
            b
        | _ -> b in
    memo := M.add b.label b' !memo;
    blocks := (getBlockID b', b') :: !blocks;
    b'

let rec h b =
  change := false;
  setCount b;
  initFV b.label;
  memo := M.empty;
  blocks := [];
  let b = g M.empty b in
  if !change then h b
  else b

let f (Prog(data, fundefs)) =
  if !off then Prog(data, fundefs)
  else Prog(data, List.map (fun (f, b) -> (f, h b)) fundefs)
