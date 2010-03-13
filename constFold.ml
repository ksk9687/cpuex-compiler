open KNormal

let off = ref false

let memi x env =
  try (match M.find x env with Int(_) -> true | _ -> false)
  with Not_found -> false
let memf x env =
  try (match M.find x env with Float(_) -> true | _ -> false)
  with Not_found -> false
let memt x env =
  try (match M.find x env with Tuple(_) -> true | _ -> false)
  with Not_found -> false

let findi x env = (match M.find x env with Int(i) -> i | _ -> raise Not_found)
let findf x env = (match M.find x env with Float(d) -> d | _ -> raise Not_found)
let findt x env = (match M.find x env with Tuple(ys) -> ys | _ -> raise Not_found)

let fabs x = if x < 0.0 then -.x else x


type fexpi = Muli of Id.t * float | Addi of Id.t * float | Subi of float * Id.t

let memfmul x env =
  try (match M.find x env with Muli _ -> true | _ -> false)
  with Not_found -> false
let memfadd x env =
  try (match M.find x env with Addi _ -> true | _ -> false)
  with Not_found -> false
let memfsub x env =
  try (match M.find x env with Subi _ -> true | _ -> false)
  with Not_found -> false

let findfmul x env = (match M.find x env with Muli(x,y) -> x,y | _ -> raise Not_found)
let findfadd x env = (match M.find x env with Addi(x,y) -> x,y | _ -> raise Not_found)
let findfsub x env = (match M.find x env with Subi(x,y) -> x,y | _ -> raise Not_found)



let rec g env fenv = function
  | Var(x) when memi x env -> Int(findi x env)
(*| Var(x) when memf x env -> Float(findf x env) *)
(*| Var(x) when memt x env -> Tuple(findt x env) *)
  | Neg(x) when memi x env -> Int(-(findi x env))
  | Add(x, y) when memi x env && memi y env -> Int(findi x env + findi y env)
  | Add(x, y) when memi x env && M.find x env = Int(0) -> g env fenv (Var (y))
  | Add(x, y) when memi y env && M.find y env = Int(0) -> g env fenv (Var (x))
  | Sub(x, y) when memi x env && memi y env -> Int(findi x env - findi y env)
  | Sub(x, y) when memi y env && M.find y env = Int(0) -> g env fenv (Var (y))
  | Sub(x, y) when memi x env && M.find x env = Int(0) -> g env fenv (Neg (y))
  | SLL(x, y) when memi x env && y >= 0 -> Int((findi x env) lsl y)
  | SLL(x, y) when memi x env -> Int((findi x env) asr -y)
  | FNeg(x) when memf x env -> Float(-.(findf x env))
  | FInv(x) when memf x env -> Float(1. /. (findf x env))
  | FAdd(x, y) when memf x env && memf y env -> Float(findf x env +. findf y env)
  | FAdd(x, y) when memf x env && M.find x env = Float (0.) -> g env fenv (Var(y))
  | FAdd(x, y) when memf y env && M.find y env = Float (0.) -> g env fenv (Var(x))
  | FAdd(x, y) when memf x env && memfadd y fenv  ->
      let z,f = findfadd y fenv in
      let x' = Id.gentmp Type.Float in
      Let((x', Type.Float), Float(findf x env +. f), FAdd(x', z))
  | FAdd(x, y) when memf y env && memfadd x fenv  ->
      let z,f = findfadd x fenv in
      let y' = Id.gentmp Type.Float in
      Let((y', Type.Float), Float(findf y env +. f), FAdd(y', z))
  | FAdd(x, y) when memf x env && memfsub y fenv  ->
      let f,z = findfsub y fenv in
      let x' = Id.gentmp Type.Float in
      Let((x', Type.Float), Float(findf x env +. f), FSub(x', z))
  | FAdd(x, y) when memf y env && memfsub x fenv  ->
      let f,z = findfsub x fenv in
      let y' = Id.gentmp Type.Float in
      Let((y', Type.Float), Float(findf y env +. f), FSub(y', z))
  | FSub(x, y) when memf x env && memf y env -> Float(findf x env -. findf y env)
  | FSub(x, y) when memf x env && M.find x env = Float (0.) -> g env fenv (FNeg (y))
  | FSub(x, y) when memf y env && M.find y env = Float (0.) -> g env fenv (Var (x))
  | FSub(x, y) when memf x env && memfadd y fenv  -> (* x - (z + f) = (x - f) - z *)
      let z,f = findfadd y fenv in
      let x' = Id.gentmp Type.Float in
      Let((x', Type.Float), Float(findf x env -. f), FSub(x', z))
  | FSub(x, y) when memf y env && memfadd x fenv  -> (* (z + f) - y = z + (f - y) *)
      let z,f = findfadd x fenv in
      let y' = Id.gentmp Type.Float in
      Let((y', Type.Float), Float(f -. findf y env), FAdd(z, y'))
  | FSub(x, y) when memf x env && memfsub y fenv  -> (* x - (f - z) = (x - f) + z *)
      let f,z = findfsub y fenv in
      let x' = Id.gentmp Type.Float in
      Let((x', Type.Float), Float(findf x env -. f), FAdd(x', z))
  | FSub(x, y) when memf y env && memfsub x fenv  -> (* (f - z) - y = (f - y) - z *)
      let f,z = findfsub x fenv in
      let y' = Id.gentmp Type.Float in
      Let((y', Type.Float), Float(f -. findf y env), FSub(y', z))
  | FMul(x, y) when memf x env && memf y env -> Float(findf x env *. findf y env)
  | FMul(x, y) when memf x env && M.find x env = Float (1.) -> g env fenv (Var (y))
  | FMul(x, y) when memf y env && M.find y env = Float (1.) -> g env fenv (Var (x))
  | FMul(x, y) when memf x env && M.find x env = Float (-1.) -> g env fenv (FNeg (y))
  | FMul(x, y) when memf y env && M.find y env = Float (-1.) -> g env fenv (FNeg (x))
  | FMul(x, y) when memf x env && M.find x env = Float (0.) -> Float (0.)
  | FMul(x, y) when memf y env && M.find y env = Float (0.) -> Float (0.)
  | FMul(x, y) when memf x env && memfmul y fenv  ->
      let z,f = findfmul y fenv in
      let x' = Id.gentmp Type.Float in
      Let((x', Type.Float), Float(findf x env *. f), FMul(x', z))
  | FMul(x, y) when memf y env && memfmul x fenv  ->
      let z,f = findfmul x fenv in
      let y' = Id.gentmp Type.Float in
      Let((y', Type.Float), Float(findf y env *. f), FMul(y', z))
  | IfEq(x, y, e1, e2) when memi x env && memi y env -> if findi x env = findi y env then g env fenv e1 else g env fenv e2
  | IfEq(x, y, e1, e2) when memf x env && memf y env -> if findf x env = findf y env then g env fenv e1 else g env fenv e2
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env fenv e1, g env fenv e2)
  | IfLE(x, y, e1, e2) when memi x env && memi y env -> if findi x env <= findi y env then g env fenv e1 else g env fenv e2
  | IfLE(x, y, e1, e2) when memf x env && memf y env -> if findf x env <= findf y env then g env fenv e1 else g env fenv e2
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env fenv e1, g env fenv e2)
  | Let((x, t), e1, e2) ->
      let e1' = g env fenv e1 in
      let fenv' = 
        (match e1' with
          | FAdd (y, z) when memf y env -> M.add x (Addi(z, findf y env)) fenv
          | FAdd (y, z) when memf z env -> M.add x (Addi(y, findf z env)) fenv
          | FSub (y, z) when memf y env -> M.add x (Subi(findf y env, z)) fenv
          | FSub (y, z) when memf z env -> M.add x (Addi(y, -. findf z env)) fenv
          | FMul (y, z) when memf y env -> M.add x (Muli(z, findf y env)) fenv
          | FMul (y, z) when memf z env -> M.add x (Muli(y, findf z env)) fenv
          | _ -> fenv) in
      let e2' = g (M.add x e1' env) fenv' e2 in
      Let((x, t), e1', e2')
  | LetRec({ name = x; args = ys; body = e1 }, e2) ->
      LetRec({ name = x; args = ys; body = g env fenv e1 }, g env fenv e2)
  | LetTuple(xts, y, e) when memt y env ->
      List.fold_left2
        (fun e' xt z -> Let(xt, Var(z), e')
        ) (g env fenv e) xts (findt y env)
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env fenv e)
  | ExtFunApp(x, [y]) when x = "float_of_int" & memi y env ->
      Float(float_of_int (findi y env))
  | ExtFunApp(x, [y]) when x = "int_of_float" & memf y env ->
      Int(int_of_float (findf y env))
  | ExtFunApp(x, [y]) when x = "atan" & memf y env ->
      Float(atan (findf y env))
  | ExtFunApp(x, [y]) when x = "sin" & memf y env ->
      Float(sin (findf y env))
  | ExtFunApp(x, [y]) when x = "cos" & memf y env ->
      Float(cos (findf y env))
  | ExtFunApp(x, [y]) when x = "sqrt" & memf y env ->
      Float(sqrt (findf y env))
  | ExtFunApp(x, [y]) when x = "fneg" & memf y env ->
      Float(-. (findf y env))
  | ExtFunApp(x, [y]) when x = "fabs" & memf y env ->
      Float(fabs (findf y env))
  | ExtFunApp(x, [y]) when x = "floor" & memf y env ->
      Float(floor (findf y env))
  | e -> e

let f e =
  if !off then e
  else g M.empty M.empty e
