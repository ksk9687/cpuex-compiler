open KNormal

let off = ref false

let expandEnv = ref []

let rec init ts =
  let (size, ps) = List.fold_left
    (fun (p, ps) t ->
      match t with
        | _ -> (p + 1, ps @ [p, 1, false])
    ) (0, []) ts in
  (size, ps)

let get t =
  try List.assoc t !expandEnv
  with Not_found ->
    Format.eprintf "Expand: %s@." (Type.string_of_t t);
    match t with
      | Type.Tuple(ts) ->
          let v = init ts in
          expandEnv := (t, v) :: !expandEnv;
          v
      | _ -> assert false

let rec expand ts =
  let (size, ps) = List.fold_left
    (fun (p, ps) t ->
      match t with
        | Type.Array(_, Type.Const(i)) -> (p + i, ps @ [p, i, true])
        | Type.Tuple(ts) ->
            if not (List.mem_assoc t !expandEnv) then
              expandEnv := (t, expand ts) :: !expandEnv;
            let (size, _) = List.assoc t !expandEnv in
            (p + size, ps @ [p, size, true])
        | _ -> (p + 1, ps @ [p, 1, false])
    ) (0, []) ts in
  (size, ps)

let rec check env = function
  | Let((x, t), e1, e2) ->
      check env e1;
      check (M.add x t env) e2
  | LetRec({ name = (x, t); args = xts; body = e1 }, e2) ->
(*      Format.eprintf "%s: %s@." x (Type.string_of_t t);*)
      check (M.add_list xts env) e1;
      check (M.add x t env) e2
  | Tuple(xs) ->
      let ts = List.map (fun x -> M.find x env) xs in
      let t = Type.remove_len true (Type.Tuple(ts)) in
      if not (List.mem_assoc t !expandEnv) then (
        if !off then
          expandEnv := (t, init ts) :: !expandEnv
        else
          expandEnv := (t, expand ts) :: !expandEnv
      )
  | LetTuple(xts, y, e) ->
      let t = Type.remove_len true (M.find y env) in
      (match t with
        | Type.Tuple(ts) when not (List.mem_assoc t !expandEnv) ->
            if !off then
              expandEnv := (t, init ts) :: !expandEnv
            else
              expandEnv := (t, expand ts) :: !expandEnv;
        | _ -> ());
      check (M.add_list xts env) e
  | _ -> ()

let f e =
  M.iter
    (fun x t -> if not (M.mem x BuiltIn.builtInEnv) then
      Format.eprintf "%s: %s@." x (Type.string_of_t t)
    ) !Typing.extenv;
  expandEnv := [];
  check M.empty e;
  List.iter
    (fun (t, (_, ps)) ->
      let ss = List.map
        (fun (p, n, b) ->
          if b then Format.sprintf "%d-%d" p (p + n - 1)
          else Format.sprintf "%d" p
        ) ps in
      Format.eprintf "%s: [%s]@." (Type.string_of_t t) (String.concat ", " ss)
    ) !expandEnv;
  e

