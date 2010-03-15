open Asm

let off = ref false

let gtable = ref []

let rec getInnerType t i = match t with
    | Type.Array(t, _) -> t
    | Type.Tuple(ts) ->
        let (size, ps) = Expand.get t in
        assert (i < size);
        List.fold_left2
          (fun t (s, len, ex) t' ->
            if s <= i && i < s + len then
              if ex then t'
              else getInnerType t' (i - s)
            else t
        ) Type.Unit ps ts
    | _ -> assert false

let rec rem l env = M.add l [] env
let rec inc' i env' =
  if List.mem_assoc i env' then
    (i, (List.assoc i env') + 1) :: (List.remove_assoc i env')
  else (i, 1) :: env'
let rec inc l i env =
  if M.mem l env then
    if (M.find l env) = [] then env
    else M.add l (inc' i (M.find l env)) env
  else M.add l [(i, 1)] env
let rec count env = function
  | Ans(exp) -> count' env exp
  | Let(_, exp, e) -> count (count' env exp) e
  | Forget(_, e) -> count env e
and count' env = function
  | Ld(L(l), C(i)) | St(_, L(l), C(i)) -> inc l i env
  | SetL(l) | Ld(L(l), _) | St(_, L(l), _) -> rem l env
  | If(_, e1, e2) ->
      count (count env e1) e2
  | _ -> env

let rec g = function
  | Ans(St(x, L(l), C(i))) when List.mem_assoc (l, i) !gtable ->
      let t = getInnerType (M.find l !Typing.extenv) i in
      if t = Type.Float then
        Let((List.assoc (l, i) !gtable, t), FMov(x), Ans(Nop))
      else
        Let((List.assoc (l, i) !gtable, t), Mov(x), Ans(Nop))
  | Let(_, St(x, L(l), C(i)), e) when List.mem_assoc (l, i) !gtable ->
      let t = getInnerType (M.find l !Typing.extenv) i in
      if t = Type.Float then
        Let((List.assoc (l, i) !gtable, t), FMov(x), g e)
      else
        Let((List.assoc (l, i) !gtable, t), Mov(x), g e)
  | e -> apply2 g g' e
and g' = function
  | Ld(L(l), C(i)) when List.mem_assoc (l, i) !gtable ->
      let reg = List.assoc (l, i) !gtable in
  if (getInnerType (M.find l !Typing.extenv) i) = Type.Float then
    if is_freg reg then FMov(reg)
    else Mov(reg)
  else Mov(reg)
  | exp -> apply g exp

let h { name = l; args = xs; body = e; ret = t } =
  { name = l; args = xs; body = g e; ret = t }

let f (Prog(data, fundefs, e)) =
  if !off then Prog(data, fundefs, e)
  else
    let counts = List.fold_left (fun env { name = l; args = xs; body = e; ret = t} -> count env e) M.empty fundefs in
    let counts = count counts e.body in
    let gls = M.fold (fun l env' ls -> List.fold_left (fun ls (i, n) -> (l, i, n) :: ls) ls env') counts [] in
    let gls = List.sort (fun (_, _, n1) (_, _, n2) -> n2 - n1) gls in
    let _  = List.fold_left
      (fun (ni, nf, nfi) (l, i, _) ->
        if not (M.mem l !Typing.extenv) then
          (* let _ = Format.eprintf "orz: %s@." l in (* float *) *)
          (ni, nf, nfi)
        else
          let t = getInnerType (M.find l !Typing.extenv) i in
          match t with
            | Type.Float ->
                if nf >= List.length reg_fgs then
                  if nfi >= List.length reg_figs then
                    (ni, nf, nfi)
                  else
                    let reg = List.nth reg_figs nfi in
                    Format.eprintf "Allocate %s.(%d) -> %s@." (String.sub l 4 ((String.length l) - 4)) i reg;
                    gtable := ((l, i), reg) :: !gtable;
                    (ni, nf, nfi + 1)
                  else
                    let reg = List.nth reg_fgs nf in
                    Format.eprintf "Allocate %s.(%d) -> %s@." (String.sub l 4 ((String.length l) - 4)) i reg;
                    gtable := ((l, i), reg) :: !gtable;
                    (ni, nf + 1, nfi)
            | _ ->
                if ni >= List.length reg_igs then (ni, nf, nfi)
                else
                  let reg = List.nth reg_igs ni in
                    Format.eprintf "Allocate %s.(%d) -> %s@." (String.sub l 4 ((String.length l) - 4)) i reg;
                    gtable := ((l, i), reg) :: !gtable;
                    (ni + 1, nf, nfi)
      )
      (0, 0, 0) gls
    in
    let fundefs = List.map h fundefs in
    let e = h e in
    let body = List.fold_left
      (fun e ((l, i), reg) ->
        Let((reg, getInnerType (M.find l !Typing.extenv) i), Ld(L(l), C(i)), e)
      ) e.body !gtable in
    Prog(data, List.map h fundefs, { e with body = body })
