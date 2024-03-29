type t =
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | SLL of Id.t * int
  | FNeg of Id.t
  | FInv of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t * Type.t
  | ExtFunApp of Id.t * Id.t list
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec fv = function
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) | FInv(x) | SLL(x, _) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2) | IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let zs = S.diff (fv e1) (S.of_list (List.map fst yts)) in
      S.diff (S.union zs (fv e2)) (S.singleton x)
  | App(x, ys) -> S.of_list (x :: ys)
  | Tuple(xs) | ExtFunApp(_, xs) -> S.of_list xs
  | Put(x, y, z) -> S.of_list [x; y; z]
  | LetTuple(xs, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xs)))

let insert_let (e, t) k =
  match e with
  | Var(x) -> k x
  | _ ->
      let x = Id.gentmp t in
      let e', t' = k x in
      Let((x, t), e, e'), t'

let rec g env = function
  | Syntax.Unit -> Unit, Type.Unit
  | Syntax.Bool(b) -> Int(if b then 1 else 0), Type.Int
  | Syntax.Int(i) -> Int(i), Type.Int
  | Syntax.Float(d) -> Float(d), Type.Float
  | Syntax.Not(e) -> g env (Syntax.If(e, Syntax.Bool(false), Syntax.Bool(true)))
  | Syntax.Neg(e) ->
      insert_let (g env e)
        (fun x -> Neg(x), Type.Int)
  | Syntax.Add(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Add(x, y), Type.Int))
  | Syntax.Sub(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> Sub(x, y), Type.Int))
  | Syntax.SLL(e, i) ->
      insert_let (g env e)
        (fun x -> SLL(x, i), Type.Int)
  | Syntax.FNeg(e) ->
      insert_let (g env e)
        (fun x -> FNeg(x), Type.Float)
  | Syntax.FInv(e) ->
      insert_let (g env e)
        (fun x -> FInv(x), Type.Float)
  | Syntax.FAdd(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FAdd(x, y), Type.Float))
  | Syntax.FSub(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FSub(x, y), Type.Float))
  | Syntax.FMul(e1, e2) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> FMul(x, y), Type.Float))
  | Syntax.Eq _ | Syntax.LE _ as cmp ->
      g env (Syntax.If(cmp, Syntax.Bool(true), Syntax.Bool(false)))
  | Syntax.If(Syntax.Not(e1), e2, e3) -> g env (Syntax.If(e1, e3, e2))
  | Syntax.If(Syntax.Eq(e1, e2), e3, e4) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfEq(x, y, e3', e4'), t3))
  | Syntax.If(Syntax.LE(e1, e2), e3, e4) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y ->
              let e3', t3 = g env e3 in
              let e4', t4 = g env e4 in
              IfLE(x, y, e3', e4'), t3))
  | Syntax.If(e1, e2, e3) -> g env (Syntax.If(Syntax.Eq(e1, Syntax.Bool(false)), e3, e2))
  | Syntax.Let((x, t), e1, e2) ->
      let e1', t1 = g env e1 in
      let e2', t2 = g (M.add x t env) e2 in
      Let((x, t), e1', e2'), t2
  | Syntax.Var(x) when M.mem x env -> Var(x), M.find x env
  | Syntax.Var(x) ->
      (match M.find x !Typing.extenv with
      | Type.Array _ | Type.Tuple _ as t -> ExtArray(x, t), t
      | _ -> failwith (Printf.sprintf "external variable %s does not have an array type" x))
  | Syntax.LetRec({ Syntax.name = (x, t); Syntax.args = yts; Syntax.body = e1 }, e2) ->
      let env' = M.add x t env in
      let e2', t2 = g env' e2 in
      let e1', t1 = g (M.add_list yts env') e1 in
      LetRec({ name = (x, t); args = yts; body = e1' }, e2'), t2
  | Syntax.App(Syntax.Var(f), e2s) when not (M.mem f env) ->
      (match M.find f !Typing.extenv with
      | Type.Fun(_, t) ->
          let rec bind xs = function
            | [] -> ExtFunApp(f, xs), t
            | e2 :: e2s ->
                insert_let (g env e2)
                  (fun x -> bind (xs @ [x]) e2s) in
          bind [] e2s
      | _ -> assert false)
  | Syntax.App(e1, e2s) ->
      (match g env e1 with
      | _, Type.Fun(_, t) as g_e1 ->
          insert_let g_e1
            (fun f ->
              let rec bind xs = function
                | [] -> App(f, xs), t
                | e2 :: e2s ->
                    insert_let (g env e2)
                      (fun x -> bind (xs @ [x]) e2s) in
              bind [] e2s)
      | _ -> assert false)
  | Syntax.Tuple(es) ->
      let rec bind xs ts = function
        | [] -> Tuple(xs), Type.Tuple(ts)
        | e :: es ->
            let _, t as g_e = g env e in
            insert_let g_e
              (fun x -> bind (xs @ [x]) (ts @ [t]) es) in
      bind [] [] es
  | Syntax.LetTuple(xts, e1, e2) ->
      insert_let (g env e1)
        (fun y ->
          let e2', t2 = g (M.add_list xts env) e2 in
          LetTuple(xts, y, e2'), t2)
  | Syntax.Array(e1, e2) ->
      insert_let (g env e1)
        (fun x ->
          let _, t2 as g_e2 = g env e2 in
          insert_let g_e2
            (fun y ->
              ExtFunApp("create_array" ^ (if t2 = Type.Float then "_float" else "_int"), [x; y]), Type.Array(t2, Type.Variable)))
  | Syntax.Get(e1, e2) ->
      (match g env e1 with
      |        _, Type.Array(t, _) as g_e1 ->
          insert_let g_e1
            (fun x -> insert_let (g env e2)
                (fun y -> Get(x, y), t))
      | _ -> assert false)
  | Syntax.Put(e1, e2, e3) ->
      insert_let (g env e1)
        (fun x -> insert_let (g env e2)
            (fun y -> insert_let (g env e3)
                (fun z -> Put(x, y, z), Type.Unit)))

let f e = fst (g M.empty e)

let rec string_t indent knormal =
  let indent = indent ^ "  " in
  match knormal with
    | Unit -> indent ^ "Unit\n"
    | Int (i) -> indent ^ "Int(" ^ (string_of_int i) ^ ")\n"
    | Float (f) -> indent ^ "Float(" ^ (string_of_float f) ^ ")\n"
    | Neg (i) -> indent ^ "- " ^ i ^ "\n"
    | Add (i,j) -> indent ^ i ^ " + " ^ j ^ "\n"
    | Sub (i,j) -> indent ^ i ^ " - " ^ j ^ "\n"
    | SLL (i,j) -> indent ^ i ^ " << " ^ (string_of_int j) ^ "\n"
    | FNeg (i) -> indent ^ "- " ^ i ^ "\n"
    | FInv (i) -> indent ^ "1.0 / " ^ i ^ "\n"
    | FAdd (i,j) -> indent ^ i ^ " +. " ^ j ^ "\n"
    | FSub (i,j) -> indent ^ i ^ " -. " ^ j ^ "\n"
    | FMul (i,j) -> indent ^ i ^ " *. " ^ j ^ "\n"
    | IfEq (i,j,t,u) ->
        indent ^ "If " ^ i ^ "=" ^ j ^ "\n"
        ^ (string_t indent t) ^ (string_t indent u)
    | IfLE (i,j,t,u) ->
        indent ^ "If " ^ i ^ "<=" ^ j ^ "\n"
        ^ (string_t indent t) ^ (string_t indent u)
    | Let ((i,t),u,v) ->
        indent ^ i ^ " : " ^ (Type.string_of_t t) ^ (string_t "" u) ^ (string_t indent v)
    | Var (i) -> indent ^ "Var(" ^ i ^ ")\n"
    | App (i, list) ->
        indent ^ i ^ "("
        ^ (List.fold_left (fun x y -> x ^ " " ^ y) "" list)
        ^ " )\n"
    | Tuple (list) ->
        indent ^ "Tuple("
        ^ (List.fold_left (fun x y -> x ^ " " ^ y) "" list)
        ^ " )\n"
    | LetTuple (list, i, t) ->
        indent ^ "Let\n" ^ indent ^ "  Tuple\n"
        ^ (List.fold_left (fun x (i,y) -> x ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t y) ^"\n") "" list)
        ^ indent ^ "  " ^ i ^ "\n"
        ^ indent ^ "In\n"  ^ (string_t indent t)
    | Get (i,j) ->
        indent ^ i ^ ".(" ^ j ^ ")\n"
    | Put (i,j,k) ->
        indent ^ i ^ ".(" ^ j ^ ") <- " ^ k ^ "\n"
    | ExtArray (i, _) -> indent ^ "ExtArray(" ^ i ^ ")\n"
    | ExtFunApp (i, list) ->
        indent ^ i ^ "("
        ^ (List.fold_left (fun x y -> x ^ " " ^ y) "" list)
        ^ " )\n"
    | LetRec (fundef, t) ->
        indent ^ "LetRec\n" 
        ^ (string_fundef indent fundef)
        ^ indent ^ "In\n" ^ string_t indent t

and string_fundef indent {name = (i,t); args = list; body = b} =
  let indent = indent ^ "  " in
  indent ^ "Fun\n"
  ^ indent ^ "  Name\n" ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t t) ^ "\n"
  ^ indent ^ "  Args\n"
  ^ List.fold_left (fun x (i,y) -> x ^ indent ^ "    " ^ i ^ " : " ^ (Type.string_of_t y) ^"\n") "" list
  ^ indent ^ "  Body\n"
  ^ (string_t (indent ^ "  ") b)

let string t =
  Format.eprintf "%s@." (string_t "" t); t
