open KNormal
(* customized version of Map *)

let no_effect_fun = ref S.empty

module CM =(* CSE用のMap KNormal.tをkeyとする *)
  Map.Make
    (struct
      type t = KNormal.t
      let compare = compare
    end)
include CM

let find x env =
(*  if CM.mem x env then 
     Format.eprintf "common subexpression elimination @." ;*)
  try CM.find x env with Not_found -> x

let rec hasapp = function
  | App _ | ExtFunApp _ -> true
  | IfEq (_, _, e1, e2) | IfLE (_, _, e1, e2) | Let (_, e1, e2)
      -> (hasapp e1 || hasapp e2)
  | LetTuple (_, _, e) -> hasapp e
  | _ -> false

let rec g env = function
  | Unit | Float _ | Int _ | Neg _ | Add _ | Sub _ | SLL _ | App _
  | FNeg _ | FAdd _ | FSub _ | FMul _ | FInv _ |  Get _ | ExtArray _ as e
      -> (find e env)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let((x, t), e1, e2) ->
      let e1' = g env e1 in
      let e2' =
        if hasapp e1' then
	        if Movelet.effect !no_effect_fun e1' then g CM.empty e2
	        else g (CM.add e1' (Var(x)) CM.empty) e2
        else g (CM.add e1' (Var(x)) env) e2
      in
      Let((x, t), e1', e2')
  | LetRec({ name = xt; args = yts; body = e1 }, e2) ->
      if not (Movelet.effect_fun (fst xt) !no_effect_fun e1) then
	      no_effect_fun := S.add (fst xt) !no_effect_fun;
      LetRec({ name = xt; args = yts; body = g CM.empty e1 }, g env e2)
  | e -> e

let f x =
  no_effect_fun := S.empty;
  g CM.empty x
(*  string (g CM.empty (string x))*)
