open Asm

let off = ref false

let memi x env =
  try match M.find x env with
    | Set(i) -> true
    | _ -> false
  with Not_found -> false

let memi_s x env =
  try match M.find x env with
    | Set(i) when -128 <= i && i < 128 -> true
    | _ -> false
  with Not_found -> false

let meml x env =
  try match M.find x env with
    | SetL(l) -> true
    | _ -> false
  with Not_found -> false

let memaddi x env =
  try match M.find x env with
    | Add(y, C(i)) -> true
    | _ -> false
  with Not_found -> false

let memaddl x env =
  try match M.find x env with
    | Add(y, L(l)) -> true
    | _ -> false
  with Not_found -> false

let memadd x env =
  try match M.find x env with
    | Add(x, y') -> true
    | _ -> false
  with Not_found -> false

let findi x env =
  match M.find x env with
    | Set(i) -> i
    | _ -> raise Not_found

let findl x env =
  match M.find x env with
    | SetL(l) -> l
    | _ -> raise Not_found

let findaddi x env =
  match M.find x env with
    | Add(y, C(i)) -> (y, i)
    | _ -> raise Not_found

let findaddl x env =
  match M.find x env with
    | Add(y, L(l)) -> (y, l)
    | _ -> raise Not_found

let findadd x env =
  match M.find x env with
    | Add(x, y') -> (x, y')
    | _ -> raise Not_found

let replace env = function
  | V(x) when memi x env -> C(findi x env)
  | V(x) when meml x env -> L(findl x env)
  | x' -> x'

let rec g env = function
  | Let((x, t), exp, e) when (M.mem x env || is_reg x) ->
      Let((x, t), g' env exp, g env e)
  | Let((x, t), exp, e) ->
      let exp' = g' env exp in
      if exp' <> exp then
        g env (Let((x, t), exp', e))
      else
	      let e' = g (M.add x exp' env) e in
	      if (match exp' with Set _ | SetL _ -> false | _ -> true) || (List.mem x (fv e')) then
	        Let((x, t), exp', e')
	      else
          e'
  | e -> apply2 (g env) (g' env) e
and g' env = function
  | Mov(x) when memi x env -> Set(findi x env)
  | Mov(x) when meml x env -> SetL(findl x env)
  | Add(x, C(y)) when memi x env -> Set((findi x env) + y)
  | Add(x, C(y)) when meml x env -> SetL(Printf.sprintf "%%{%s + %d}" (findl x env) y)
  | Add(x, L(y)) when memi x env -> SetL(Printf.sprintf "%%{%s + %d}" y (findi x env))
  | Add(x, V(y)) when memi x env -> Add(y, C(findi x env))
  | Add(x, V(y)) when meml x env -> Add(y, L(findl x env))
  | Add(x, C(y)) when memaddi x env ->
      let (x, i) = findaddi x env in
      Add(x, C(i + y))
  | Add(x, C(y)) when memaddl x env ->
      let (x, l) = findaddl x env in
      Add(x, L(Printf.sprintf "%%{%s + %d}" l y))
  | Add(x, L(y)) when memaddi x env ->
      let (x, i) = findaddi x env in
      Add(x, L(Printf.sprintf "%%{%s + %d}" y i))
  | Add(x, C(0)) | Sub(x, C(0)) -> Mov(x)
  | Add(x, y') -> Add(x, replace env y')
  | Sub(x, C(y)) when memaddi x env ->
      let (x, i) = findaddi x env in
      Add(x, C(i - y))
  | Sub(x, C(y)) when memaddl x env ->
      let (x, l) = findaddl x env in
      Add(x, L(Printf.sprintf "%%{%s - %d}" l y))
  | Sub(x, y') -> Sub(x, replace env y')
  | Ld(V(x), C(y)) | Ld(C(y), V(x)) when memaddi x env ->
      let (x, i) = findaddi x env in
      Ld(V(x), C(i + y))
  | Ld(V(x), C(y)) | Ld(C(y), V(x)) when memaddl x env ->
      let (x, l) = findaddl x env in
      Ld(V(x), L(Printf.sprintf "%%{%s + %d}" l y))
  | Ld(V(x), L(y)) | Ld(L(y), V(x)) when memaddi x env ->
      let (x, i) = findaddi x env in
      Ld(V(x), L(Printf.sprintf "%%{%s + %d}" y i))
  | Ld(V(x), C(0)) | Ld(C(0), V(x)) when memadd x env ->
      let (x, y') = findadd x env in
      Ld(V(x), y')
  | Ld(x', y') -> Ld(replace env x', replace env y')
  | St(z, V(x), C(y)) | St(z, C(y), V(x)) when memaddi x env ->
      let (x, i) = findaddi x env in
      St(z, V(x), C(i + y))
  | St(z, V(x), C(y)) | St(z, C(y), V(x)) when memaddl x env ->
      let (x, l) = findaddl x env in
      St(z, V(x), L(Printf.sprintf "%%{%s + %d}" l y))
  | St(z, V(x), L(y)) | St(z, L(y), V(x)) when memaddi x env ->
      let (x, i) = findaddi x env in
      St(z, V(x), L(Printf.sprintf "%%{%s + %d}" y i))
  | St(z, V(x), C(0)) | St(z, C(0), V(x)) when memadd x env ->
      let (x, y') = findadd x env in
      St(z, V(x), y')
  | St(z, x', y') -> St(z, replace env x', replace env y')
  | If(Eq(x, V(y)), e1, e2) when memi_s y env -> If(Eq(x, C(findi y env)), g env e1, g env e2)
  | If(LE(x, V(y)), e1, e2) when memi_s y env -> If(LE(x, C(findi y env)), g env e1, g env e2)
  | If(GE(x, V(y)), e1, e2) when memi_s y env -> If(GE(x, C(findi y env)), g env e1, g env e2)
  | If(Eq(x, V(y)), e1, e2) when memi_s x env -> If(Eq(y, C(findi x env)), g env e1, g env e2)
  | If(LE(x, V(y)), e1, e2) when memi_s x env -> If(GE(y, C(findi x env)), g env e1, g env e2)
  | If(GE(x, V(y)), e1, e2) when memi_s x env -> If(LE(y, C(findi x env)), g env e1, g env e2)
  | exp -> apply (g env) exp

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g M.empty e; ret = t }

let f' (Prog(data, fundefs, e)) =
  Prog(data, List.map h fundefs, h e)

let rec f e =
  if !off then e
  else
	  let e' = f' e in
	  if e' = e then e
	  else f e'
