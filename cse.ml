open KNormal
(* customized version of Map *)

module M =
  Map.Make
    (struct
      type t = KNormal.t
      let compare = compare
    end)
include M

let find x env =
  (* if M.mem x env then 
     Format.eprintf "common subexpression elimination @." ;*)
  try M.find x env with Not_found -> x

let rec hasapp = function
  | App _ | ExtFunApp _ -> true
  | IfEq (_,_,e1,e2) | IfLE (_,_,e1,e2) | Let (_,e1,e2) 
      -> (hasapp e1 || hasapp e2)
  | LetTuple (_,_,e) -> hasapp e
  | _ -> false


let rec g env = function
  | Float (_) (*| Int (_)*) | Neg(_) | Add(_, _) | Sub(_, _) | SLL(_, _) | SRL(_, _)
  | FNeg(_) | FAdd(_, _) | FSub(_, _) | FMul(_, _) | FDiv(_, _) as e
      -> (find e env)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let((x, t), e1, e2) ->
      let e1' = g env e1 in
      let e2' =
	if hasapp e1' then g M.empty e2
	else g (M.add e1' (Var(x)) env) e2
      in
	Let((x, t), e1', e2')
  | LetRec({ name = xt; args = yts; body = e1 }, e2) ->
      LetRec({ name = xt; args = yts; body = g M.empty e1 }, g env e2)
  | e -> e

let f = g M.empty
