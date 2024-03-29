(* let _ = Random.self_init () *)

let shuffle xs =
  List.fold_left
    (fun xs x ->
      let n = Random.int ((List.length xs) + 1) in
      if n = (List.length xs) then x :: xs
      else
	      let (_, xs) = List.fold_left
	        (fun (n, xs) y ->
	          if n = 0 then (n - 1, y :: x :: xs)
            else (n - 1, y :: xs)
	        ) (n, []) xs in
        xs
    ) [] xs

let startWith s t =
  (String.length s) >= (String.length t) && (String.sub s 0 (String.length t)) = t

let unique list =
  List.fold_left (fun list a -> if List.mem a list then list else list @ [a]) [] list
