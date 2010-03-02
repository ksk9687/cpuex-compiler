open Asm

let getDelay = function
  | Set _ | SetL _ | Neg _ | Add _ | Sub _ | SLL _ | FNeg _ | FAbs _ -> 1
  | Ld _ | LdFL _ -> 2
  | FInv _ | FSqrt _ | FAdd _ | FSub _ | FMul _ -> 4
  | _ -> 0

let getRead exp = fv' exp

let getWrite (id, t) = id

let get x xs =
  if M.mem x xs then M.find x xs
  else 0

let rec g' adds muls level = function
  | Ans(IfEq(x, y, e1, e2)) -> [], Ans(IfEq(x, y, g e1, g e2))
  | Ans(IfLE(x, y, e1, e2)) -> [], Ans(IfLE(x, y, g e1, g e2))
  | Ans(IfGE(x, y, e1, e2)) -> [], Ans(IfGE(x, y, g e1, g e2))
  | Ans(IfFEq(x, y, e1, e2)) -> [], Ans(IfFEq(x, y, g e1, g e2))
  | Ans(IfFLE(x, y, e1, e2)) -> [], Ans(IfFLE(x, y, g e1, g e2))
  | Ans(FMul(a, b)) ->
      if M.mem a muls && (let (c, d) = M.find a muls in (get c level) > (get d level) && (get c level) > (get b level)) then
        let (c, d) = M.find a muls in
        [a], Let((a, Type.Float), FMul(b, d), Ans(FMul(a, c)))
      else if M.mem a muls && (let (c, d) = M.find a muls in (get d level) > (get b level)) then
        let (c, d) = M.find a muls in
        [a], Let((a, Type.Float), FMul(b, c), Ans(FMul(a, d)))
      else if M.mem b muls && (let (c, d) = M.find b muls in (get c level) > (get d level) && (get c level) > (get a level)) then
        let (c, d) = M.find b muls in
        [b], Let((b, Type.Float), FMul(a, d), Ans(FMul(b, c)))
      else if M.mem b muls && (let (c, d) = M.find b muls in (get d level) > (get a level)) then
        let (c, d) = M.find b muls in
        [b], Let((b, Type.Float), FMul(a, c), Ans(FMul(b, d)))
      else [], Ans(FMul(a, b))
  | Ans(FAdd(a, b)) ->
      if M.mem a adds && (let (c, d) = M.find a adds in (get c level) > (get d level) && (get c level) > (get b level)) then
        let (c, d) = M.find a adds in
        [a], Let((a, Type.Float), FAdd(b, d), Ans(FAdd(a, c)))
      else if M.mem a adds && (let (c, d) = M.find a adds in (get d level) > (get b level)) then
        let (c, d) = M.find a adds in
        [a], Let((a, Type.Float), FAdd(b, c), Ans(FAdd(a, d)))
      else if M.mem b adds && (let (c, d) = M.find b adds in (get c level) > (get d level) && (get c level) > (get a level)) then
        let (c, d) = M.find b adds in
        [b], Let((b, Type.Float), FAdd(a, d), Ans(FAdd(b, c)))
      else if M.mem b adds && (let (c, d) = M.find b adds in (get d level) > (get a level)) then
        let (c, d) = M.find b adds in
        [b], Let((b, Type.Float), FAdd(a, c), Ans(FAdd(b, d)))
      else [], Ans(FAdd(a, b))
  | Ans(exp) -> [], Ans(exp)
  | Let(id, IfEq(x, y, e1, e2), e) -> [], Let(id, IfEq(x, y, g e1, g e2), g e)
  | Let(id, IfLE(x, y, e1, e2), e) -> [], Let(id, IfLE(x, y, g e1, g e2), g e)
  | Let(id, IfGE(x, y, e1, e2), e) -> [], Let(id, IfGE(x, y, g e1, g e2), g e)
  | Let(id, IfFEq(x, y, e1, e2), e) -> [], Let(id, IfFEq(x, y, g e1, g e2), g e)
  | Let(id, IfFLE(x, y, e1, e2), e) -> [], Let(id, IfFLE(x, y, g e1, g e2), g e)
  | Let(id, FMul(a, b), e) ->
      let vs = fv e in
      if (not (List.mem a vs)) && M.mem a muls && (let (c, d) = M.find a muls in (get c level) > (get d level) && (get c level) > (get b level)) then
        let (c, d) = M.find a muls in
        [a], Let((a, Type.Float), FMul(b, d), Let(id, FMul(a, c), g e))
      else if (not (List.mem a vs)) && M.mem a muls && (let (c, d) = M.find a muls in (get d level) > (get b level)) then
        let (c, d) = M.find a muls in
        [a], Let((a, Type.Float), FMul(b, c), Let(id, FMul(a, d), g e))
      else if (not (List.mem b vs)) && M.mem b muls && (let (c, d) = M.find b muls in (get c level) > (get d level) && (get c level) > (get a level)) then
        let (c, d) = M.find b muls in
        [b], Let((b, Type.Float), FMul(a, d), Let(id, FMul(b, c), g e))
      else if (not (List.mem b vs)) && M.mem b muls && (let (c, d) = M.find b muls in (get d level) > (get a level)) then
        let (c, d) = M.find b muls in
        [b], Let((b, Type.Float), FMul(a, c), Let(id, FMul(b, d), g e))
      else
        let muls = M.remove a (M.remove b muls) in
        let muls = M.add (getWrite id) (a, b) muls in
	      let v = max (get a level) (get b level) in
	      let level = M.add (getWrite id) (v + (getDelay (FMul(a, b)))) level in
        let (ids, e) = g' adds muls level e in
        let id' = getWrite id in
        if List.mem id' ids then
          (Format.eprintf "Balancing Mul@."; List.filter (fun a -> a <> id') ids, e)
        else
          ids, Let(id, FMul(a, b), e)
  | Let(id, FAdd(a, b), e) ->
      let vs = fv e in
      if (not (List.mem a vs)) && M.mem a adds && (let (c, d) = M.find a adds in (get c level) > (get d level) && (get c level) > (get b level)) then
        let (c, d) = M.find a adds in
        [a], Let((a, Type.Float), FAdd(b, d), Let(id, FAdd(a, c), g e))
      else if (not (List.mem a vs)) && M.mem a adds && (let (c, d) = M.find a adds in (get d level) > (get b level)) then
        let (c, d) = M.find a adds in
        [a], Let((a, Type.Float), FAdd(b, c), Let(id, FAdd(a, d), g e))
      else if (not (List.mem b vs)) && M.mem b adds && (let (c, d) = M.find b adds in (get c level) > (get d level) && (get c level) > (get a level)) then
        let (c, d) = M.find b adds in
        [b], Let((b, Type.Float), FAdd(a, d), Let(id, FAdd(b, c), g e))
      else if (not (List.mem b vs)) && M.mem b adds && (let (c, d) = M.find b adds in (get d level) > (get a level)) then
        let (c, d) = M.find b adds in
        [b], Let((b, Type.Float), FAdd(a, c), Let(id, FAdd(b, d), g e))
      else
        let adds = M.remove a (M.remove b adds) in
        let adds = M.add (getWrite id) (a, b) adds in
	      let v = max (get a level) (get b level) in
	      let level = M.add (getWrite id) (v + (getDelay (FAdd(a, b)))) level in
        let (ids, e) = g' adds muls level e in
        let id' = getWrite id in
        if List.mem id' ids then
          (Format.eprintf "Balancing Add@."; List.filter (fun a -> a <> id') ids, e)
        else
          ids, Let(id, FAdd(a, b), e)
  | Let(id, exp, e) ->
      let muls = List.fold_right (fun x muls -> M.remove x muls) (getRead exp) muls in
      let v = List.fold_left (fun a id -> max a (get id level)) 0 (getRead exp) in
      let level = M.add (getWrite id) (v + (getDelay exp)) level in
      let (ids, e) = g' adds muls level e in
      ids, Let(id, exp, e)
  | Forget _ -> assert false
and g e =
  let (ids, e) = g' M.empty M.empty M.empty e in (assert (ids = []); e)

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g e; ret = t }

let f' (Prog(data, fundefs, e)) =
  let fundefs = List.map h fundefs in
  let e = g e in
  Prog(data, fundefs, e)

let f e = e
