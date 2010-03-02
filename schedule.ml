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

let miss = ref 0

type id = string
type tree = Node of id * (int * tree) list


let find x m =
  try M.find x m with Not_found -> []


let rec makeinst env cont list =
  let list' = makeinst' env [] list in
    List.fold_right
      (fun node cont ->
         match node with
           | None -> miss := !miss+1; cont
           | Some(_,exp) -> Seq(exp,cont))
            list' cont
and makeinst' env instlist = function
  | [] -> instlist
  | (id,_) :: tl ->
      let exp, ch = M.find id env in
      let ch' = List.map (function (d,Node(id,_)) -> (id,d))  ch in
      makeinst' env (addinst (id,exp) ch' 0 instlist) tl
and addinst idexp ch d = function
  | [] ->
      if ch != [] then assert false
      else if d <= 0 then [Some idexp]
      else None :: addinst idexp ch (d-1) []
  | None :: tl ->
      if ch = [] && d <= 0 then Some(idexp) :: tl
      else None :: addinst idexp ch (d-1) tl
  | Some(id, exp') :: tl ->
      if List.mem_assoc id ch then
        let d' = max (List.assoc id ch) (d - 1) in
        let ch' = List.remove_assoc id ch in
          Some(id, exp') :: addinst idexp ch' d' tl
      else
        Some(id, exp') :: addinst idexp ch (d-1) tl

let rec merge list = function
  | [] -> list
  | (id, d) :: tl ->
      if List.mem_assoc id list then
        let d' = List.assoc id list in
          merge ((id, max d d') :: List.remove_assoc id list) tl
      else merge ((id, d) :: list) tl

let getinst (Exp(inst, _, _, _), _) = inst

let rec h env root cont =
  let list = List.map (tolist 0) root in
  let list = List.fold_left merge [] list in
  let list = List.sort (fun (_, d) (_, d') -> d' - d) list in
  makeinst env cont list
and tolist d = function Node(id, ch) ->
  let list = List.fold_left (fun list (d', n) -> merge list (tolist (d + d' + 1) n)) [] ch in
  merge list [(id, d)]


let sort_and_merge list =
  let rec sub s = function
    | [] -> []
    | (_, Node(id, _)) as hd :: tl ->
			  if S.mem id s then sub s tl
			  else hd :: sub (S.add id s) tl
  in
    sub S.empty (List.sort (fun (d, _) (d', _) -> d' - d) list)


let rec g e =
  maketree M.empty M.empty M.empty [] 0 e
and maketree wenv renv eenv root n =  function
  | End | Ret _ | Jmp _ as e -> h eenv root e
  | Call(s, e) -> h eenv root (Call(s, g e))
  | If(b, bn, e1, e2, e3) ->
      h eenv root (If(b, bn, g e1, g e2, g e3))
  | Seq(Exp(inst,_,reads,writes) as exp, e) ->
      let id = string_of_int n in
      let raw = List.fold_left (fun list r -> (find r wenv) @ list) [] reads in
      let raw' = List.map (function Node(id,_) as n -> getDelay (fst (M.find id eenv)), n) raw in
      let war = List.fold_left (fun list w -> (find w renv) @ list) [] writes in
      let war' = List.map (fun n -> 1, n) war in
      let waw = List.fold_left (fun list w -> (find w wenv) @ list) [] writes in
      let waw' = List.map
        (fun n -> 1, n)
        (* (function Node(id,_) as n -> (max ((getDelay (fst (M.find id eenv))) - getDelay exp + 1) 1 , n)) *)
        waw in
          let children' = sort_and_merge (raw' @ war' @ waw') in
          let node = Node(id, children') in
          let children = List.map (function (_, Node(id, _)) -> id) children' in
          let root = node :: List.filter (function Node(id, _) -> not(List.mem id children)) root in
          let renv' = List.fold_left (fun env r -> M.add r (node :: find r env) env) renv reads in
          let wenv' = List.fold_left (fun env w -> M.add w [node] env) wenv writes in
          let renv' = List.fold_left (fun env w -> M.remove w env) renv' writes in
          let eenv' = M.add id (exp, children')eenv in
      maketree wenv' renv' eenv' root (n + 1) e


let f' (Prog(data, fundefs, e)) =
  miss := 0;
  let fundefs' = List.map (fun (id, e) -> id, g e) fundefs in
  let e = g e in
  Format.eprintf "miss: %d@." !miss;
  Prog(data, fundefs', e)

let f x = x
