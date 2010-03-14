(* OCaml 処理系を使って簡単なテストを行う *)

let true_sin = sin in
let rec fabs x = if x < 0.0 then -. x else x in
  


let rec sin x =
  let rec tan x = (* -pi/4 <= x <= pi/4 *)
    let rec tan_sub i xx y =
      if i < 2.5 then y
      else tan_sub (i -. 2.) xx (xx /. (i -. y))
    in
      x /. (1. -. (tan_sub 9. (x *. x) 0.0))
  in
  let pi = 3.14159265358979323846264 in
  let pi2 = pi *. 2.0 in
  let pih = pi *. 0.5 in
  let s1 = if x > 0.0 then true else false in
  let x0 = fabs x in
  let x1 = x0 -. pi2 *. (floor (x0 /. pi2)) in
  let s2 = if x1 > pi then not s1 else s1 in
  let x2 = if x1 > pi then pi2 -. x1 else x1 in
  let x3 = if x2 > pih then pi -. x2 else x2 in
  let t = tan (x3 *. 0.5) in
    (if s2 then 1.0 else -.1.0) *. (2. *. t /. (1. +. t *. t))
in
let rec cos x = sin (1.570796326794895 -. x)
in


  
let hoge x =
  print_endline (string_of_float (sin x));
  print_endline (string_of_float (true_sin x))
in
  (*
  hoge 1.0
  *)


  
let pi = 3.14159265358979323846264 in
let err a b = fabs (a -. b) /. (max (fabs a) (fabs b)) in
let max2 (e1, x1) (e2, x2) = if e1 > e2 then (e1, x1) else (e2, x2) in
let gen1 () = (Random.float (pi *. 2.0)) in
let gen2 () = (Random.float 100.) in
let rec check f n = 
  let rec sub n ex = 
    if n == 0 then ex
    else
      let x = f () in
      let (a, b) = (sin x, true_sin x) in
        sub (n - 1) (max2 ((err a b), x) ex)
  in
    sub n (-1.0, 0.0)
in
let (e, x) = 
  max2 (check gen1 1000000) (check gen2 0)
in
  print_endline ("maximum relative error = " ^ (string_of_float e));
  print_endline ("where x = " ^ (string_of_float x));;



(*
let rec tan x =
  let rec tan_sub i xx =
    if i > 10.5 then 0.
    else xx /. (i -. (tan_sub (i +. 2.) xx)) 
  in
    x /. (1. -. (tan_sub 3. (x *. x)))
in
let rec sin x =
  let pi = 3.14159265358979323846264 in
  let pi2 = pi *. 2.0 in
  let pih = pi *. 0.5 in
  let rec sin_sub x = (* TODO *)
    let pi2 = pi *. 2.0 in
    if x > pi2 then sin_sub (x -. pi2)
    else x
  in
  let s1 = if x > 0.0 then true else false in
  let x1 = sin_sub (fabs x) in (* [0, 2pi) *)
  let s2 = if x1 > pi then not s1 else s1 in
  let x2 = if x1 > pi then pi2 -. x1 else x1 in
  let x3 = if x2 > pih then pi -. x2 else x2 in
  let t = tan (x3 *. 0.5) in
    (if s2 then 1.0 else -.1.0) *. (2. *. t /. (1. +. t *. t))
in
let rec cos x = sin (1.570796326794895 -. x)
in
  0
*)
