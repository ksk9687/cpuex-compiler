type closure = { entry : Id.t; actual_fv : Id.t list }
type t =
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | FNeg of Id.t
  | FInv of Id.t
  | FSqrt of Id.t
  | FAbs of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | AppDir of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
type fundef = { name : Id.t * Type.t;
                args : (Id.t * Type.t) list;
                body : t }
type prog = Prog of fundef list * t

let rec fv = function
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) | FSqrt(x) | FAbs(x) | FInv(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2)| IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | AppDir(_, xs) | Tuple(xs) -> S.of_list xs
  | LetTuple(xts, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xts)))
  | Put(x, y, z) -> S.of_list [x; y; z]

let toplevel = ref []

let rec sll x i =
  assert (i >= 0);
  if i = 0 then Var(x)
  else if i = 1 then Add(x, x)
  else
    let y = Id.genid x in
    Let((y, Type.Int), sll x (i - 1), Add(y, y))

let rec g env known = function
  | KNormal.Unit -> Unit
  | KNormal.Int(i) -> Int(i)
  | KNormal.Float(d) -> Float(d)
  | KNormal.Neg(x) -> Neg(x)
  | KNormal.Add(x, y) -> Add(x, y)
  | KNormal.Sub(x, y) -> Sub(x, y)
  | KNormal.SLL(x, i) -> sll x i
  | KNormal.FNeg(x) -> FNeg(x)
  | KNormal.FInv(x) -> FInv(x)
  | KNormal.FAdd(x, y) -> FAdd(x, y)
  | KNormal.FSub(x, y) -> FSub(x, y)
  | KNormal.FMul(x, y) -> FMul(x, y)
  | KNormal.IfEq(x, y, e1, e2) -> IfEq(x, y, g env known e1, g env known e2)
  | KNormal.IfLE(x, y, e1, e2) -> IfLE(x, y, g env known e1, g env known e2)
  | KNormal.Let((x, t), e1, e2) -> Let((x, t), g env known e1, g (M.add x t env) known e2)
  | KNormal.Var(x) -> Var(x)
  | KNormal.LetRec({ KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }, e2) ->
      let env' = M.add x t env in
      let known' = S.add x known in
      let e1' = g (M.add_list yts env') known' e1 in
      let zs = S.diff (fv e1') (S.of_list (List.map fst yts)) in
      if not (S.is_empty zs) then
        (Format.eprintf "free variable(s) %s found in function %s@." (Id.pp_list (S.elements zs)) x;
         Format.eprintf "function %s cannot be directly applied in fact@." x;
         assert false);
      toplevel := { name = (x, t); args = yts; body = e1' } :: !toplevel;
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then
        assert false
      else (
(*        Format.eprintf "eliminating closure(s) %s@." x;*)
         e2')
  | KNormal.App(x, ys) when S.mem x known ->
(*      Format.eprintf "directly applying %s@." x;*)
      AppDir(x, ys)
  | KNormal.App(f, xs) -> assert false
  | KNormal.Tuple(xs) -> Tuple(xs)
  | KNormal.LetTuple(xts, y, e) -> LetTuple(xts, y, g (M.add_list xts env) known e)
  | KNormal.Get(x, y) -> Get(x, y)
  | KNormal.Put(x, y, z) -> Put(x, y, z)
  | KNormal.ExtArray(x, t) ->
      ExtArray("ext_" ^ x)
  | KNormal.ExtFunApp(x, ys) ->
      match x with
        | "sqrt" -> FSqrt(List.hd ys)
        | "fabs" -> FAbs(List.hd ys)
        | _ -> AppDir("ext_" ^ x, ys)

let f e =
  toplevel := [];
  Typing.extenv := M.fold (fun x t map -> M.add ("ext_" ^ x) t map) !Typing.extenv M.empty;
  let e' = g M.empty S.empty e in
  Prog(List.rev !toplevel, e')
