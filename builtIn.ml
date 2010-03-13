open Syntax

let builtInEnv = M.add_list [
  ("fless", Type.Fun([Type.Float; Type.Float], Type.Bool));
  ("fispos", Type.Fun([Type.Float], Type.Bool));
  ("fisneg", Type.Fun([Type.Float], Type.Bool));
  ("fiszero", Type.Fun([Type.Float], Type.Bool));
  ("fabs", Type.Fun([Type.Float], Type.Float));
  ("sqrt", Type.Fun([Type.Float], Type.Float));
  ("floor", Type.Fun([Type.Float], Type.Float));
  ("float_of_int", Type.Fun([Type.Int], Type.Float));
  ("int_of_float", Type.Fun([Type.Float], Type.Int));
  ("read_int", Type.Fun([Type.Unit], Type.Int));
  ("read_float", Type.Fun([Type.Unit], Type.Float));
  ("write", Type.Fun([Type.Int], Type.Unit));
  ("atan", Type.Fun([Type.Float], Type.Float));
  ("sin", Type.Fun([Type.Float], Type.Float));
  ("cos", Type.Fun([Type.Float], Type.Float));
] M.empty

let rec f = function
  | App(Var("fless"), [e1; e2]) ->
      Not(LE(e2, e1))
  | App(Var("fispos"), [e]) ->
      Not(LE(e, Float(0.0)))
  | App(Var("fisneg"), [e]) ->
      Not(LE(Float(0.0), e))
  | App(Var("fiszero"), [e]) ->
      Eq(e, Float(0.0))
  | Not(t) -> Not(f t)
  | Neg(t) -> Neg(f t)
  | Add(t1, t2) -> Add(f t1, f t2)
  | Sub(t1, t2) -> Sub(f t1, f t2)
  | SLL(t, i) -> SLL(f t, i)
  | FNeg(t) -> FNeg(f t)
  | FInv(t) -> FInv(f t)
  | FAdd(t1, t2) -> FAdd(f t1, f t2)
  | FSub(t1, t2) -> FSub(f t1, f t2)
  | FMul(t1, t2) -> FMul(f t1, f t2)
  | Eq(t1, t2) -> Eq(f t1, f t2)
  | LE(t1, t2) -> LE(f t1, f t2)
  | If(t1, t2, t3) -> If(f t1, f t2, f t3)
  | Let(v, t1, t2) -> Let(v, f t1, f t2)
  | LetRec({ name = v; args = a; body = t1}, t2) -> LetRec({ name = v; args = a; body = f t1}, f t2)
  | App(t1, ts) -> App(f t1, List.map f ts)
  | Tuple(ts) -> Tuple(List.map f ts)
  | LetTuple(vs, t1, t2) -> LetTuple(vs, f t1, f t2)
  | Array(t1, t2) -> Array(f t1, f t2)
  | Get(t1, t2) -> Get(f t1, f t2)
  | Put(t1, t2, t3) -> Put(f t1, f t2, f t3)
  | e -> e
