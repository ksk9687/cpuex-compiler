open KNormal

let off = ref false

let rec g = function
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g e1, g e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g e1, g e2)
  | Let(xt, e1, e2) ->
      let rec insert = function
        | Let(yt, e3, e4) -> Let(yt, e3, insert e4)
        | LetRec(fundefs, e) -> LetRec(fundefs, insert e)
        | LetTuple(yts, z, e) -> LetTuple(yts, z, insert e)
        | e -> Let(xt, e, g e2) in
      insert (g e1)
  | LetRec({ name = xt; args = yts; body = e1 }, e2) ->
      LetRec({ name = xt; args = yts; body = g e1 }, g e2)
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g e)
  | e -> e

let f e =
  if !off then e
  else g e
