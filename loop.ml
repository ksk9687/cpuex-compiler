open KNormal
(* 関数ごとに使う関数の集合をつくる *)
let rec appmap id env = 
  let env' = M.add id S.empty env in
    appmap' id env'
and appmap' id env = function
  | App (x,_) ->
      (try
	 let s' = S.add x (M.find id env) in
	   M.add id s' env
       with Not_found -> env)
  | IfEq (_,_,e1,e2) | IfLE (_,_,e1,e2) | Let (_,e1,e2) ->
      appmap' id (appmap' id env e1) e2
  | LetTuple (_,_,e) ->
      appmap' id env e
  | LetRec ({name=(id',_);body=e1},e2) ->
      appmap' id (appmap id' env e1) e2
  | _ -> env

let print env =
  M.iter
    (fun key x ->
       Format.eprintf " %s : " key;
       S.iter (Format.eprintf "%s ") x;
       Format.eprintf "@.")
    env

let rec level x n = (* 関数ごとにレベルを表示 *)
  let leafs =  
    M.fold
      (fun key x b -> if S.equal S.empty x then S.add key b else b)
      x S.empty
  in
    Format.eprintf "level %d leafs...@." n;
    S.iter (Format.eprintf "  %s@.") leafs;
  let loops =
    M.fold
      (fun key x b -> if S.mem key x then S.add key b else b)
      x S.empty
  in
    Format.eprintf "level %d loops...@." n;
    S.iter (Format.eprintf "  %s@.") loops;
    let x' = S.fold M.remove leafs x in
    let x' = M.map (fun x -> S.diff x leafs) x' in
    let x' = S.fold M.remove loops x' in
    let x' = M.map (fun x -> S.diff x loops) x' in
      if x = x' or M.empty = x' then print x
      else level x' (n+1)


(* Closure.f と iter の間などに挟むと、ループ(とついでにリーフ関数)を検出してくれる *)
let f x=
  let m = appmap (Id.genid "main") M.empty x in
    (* print m; *)
  let looplist =
    M.fold
      (fun key x b -> if S.mem key x then (key :: b) else b)
      m [] in
    Format.eprintf "loops...@.";
    List.iter (Format.eprintf " %s@.") looplist;
  let leaflist =
    M.fold
      (fun key x b -> if S.equal S.empty x then (key :: b) else b)
      m [] in
    Format.eprintf "leafs...@.";
    List.iter (Format.eprintf " %s@.") leaflist;
    level m 0;
    x
