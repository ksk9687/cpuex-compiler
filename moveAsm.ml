open Block

let off = ref false

let inter xs ys =
  List.fold_left (fun zs x -> if List.mem x ys then x :: zs else zs) [] xs

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
        | Mov(s, d) when M.mem s env -> M.add d (M.find s env) env
        | Call _ -> M.empty
        | exp -> S.fold (fun r env -> M.remove r env) (getWrite exp) env in
      let (env, exps) = g' last env exps in
      (env, (s, exp) :: exps)

let rec g env b =
  if (M.find b.label !inCount) <> 1 && not (M.is_empty env) then
    let (env, exps) = g' b.last env b.exps in
    match b.last with
	    | CmpJmp(Cmpi(mask, x, i), b1, b2) when M.mem x env ->
	        change := true;
	        let j = M.find x env in
	        if cmp mask j i then (
            { exps = exps @ b1.exps; last = b1.last; label = Id.genid b.label }
	        ) else (
            { exps = exps @ b2.exps; last = b2.last; label = Id.genid b.label }
	        )
      | _ -> g M.empty b
  else if M.mem b.label !memo then
    M.find b.label !memo
  else
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
    let id = getBlockID b' in
    try
      (* let b' = find (getBlockID b) !blocks in *)
      let b' = List.assoc id !blocks in
      change := true;
      memo := M.add b.label b' !memo;
      b'
    with Not_found ->
      memo := M.add b.label b' !memo;
      blocks := (id, b') :: !blocks;
      b'

let miss = ref 0

let getDelay = function
  | Li _ | Addi _ | Add _ | Sub _ -> 1
  | Load _ | Loadr _ -> 2
  | FAdd _ | FSub _ | FMul _ -> 2
  | FInv _ | FSqrt _ -> 3
  | _ -> 0

let addMax x y xs =
  if M.mem x xs then M.add x (max (M.find x xs) y) xs
  else M.add x y xs

let rec getCritical time = function
  | [] | (_, Call _) :: _ -> 0
  | (_, exp) :: exps ->
      let t = S.fold
        (fun r t ->
          if M.mem r time then max t (M.find r time)
          else t
        ) (getRead exp) 0 in
      let d = t + (getDelay exp) + 1 in
      let time = S.fold
        (fun r time -> addMax r d time
        ) (getWrite exp) time in
      max t (getCritical time exps)

let aging write =
  let write' = List.map (fun (x, y) -> (x - 1, y)) write in
  List.filter (fun (x, _) -> x >= 0) write'

let rec schedule' awrite = function
  | [] -> []
  | (s, Call(x, ra)) :: exps -> (s, Call(x, ra)) :: (schedule' [] exps)
  | es ->
      let awrite = aging awrite in
      let write = List.fold_left (fun write (_, y) -> S.union y write) S.empty awrite in
      let exps = getFirst S.empty write es in
      if exps <> [] then
        let time = List.fold_left
          (fun time (t, rs) -> S.fold
            (fun r time -> addMax r t time
            ) rs time
          ) M.empty awrite in
        let ts = List.map
          (fun (s, exp) ->
            let t = getDelay exp in
            let time = S.fold
              (fun r time -> addMax r t time
              ) (getWrite exp) time in
            (getCritical time (removeFirst (s, exp) es), (s, exp))
          ) exps in
        let (_, (s, exp)) = List.fold_left
          (fun (t, exp) (t', exp') ->
            if t > t' then (t', exp')
            else (t, exp)
          ) (List.hd ts) (List.tl ts) in
        (s, exp) :: (schedule' ((getDelay exp, getWrite exp) :: awrite) (removeFirst (s, exp) es))
      else
        (incr miss; schedule' awrite es)

let rec schedule b =
  if not (M.mem b.label !memo) then (
    memo := M.add b.label b !memo;
	  b.exps <- schedule' [] b.exps;
	  match b.last with
	    | CmpJmp(_, b1, b2) ->
	        schedule b1;
	        schedule b2
	    | Cont(b1) -> schedule b1
	    | _ -> ()
  )

let rec h b =
  change := false;
  setCount b;
  initFV b.label;
  memo := M.empty;
  blocks := [];
  let b = g M.empty b in
  if !change then h b
  else (
    memo := M.empty;
    schedule b; b
  )

let f (Prog(data, fundefs)) =
  if !off then Prog(data, fundefs)
  else (
    miss := 0;
    let e = Prog(data, List.map (fun (f, b) -> (f, h b)) fundefs) in
 	  Format.eprintf "MissCount: %d@." !miss;
    e
  )
