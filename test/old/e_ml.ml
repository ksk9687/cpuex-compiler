(* debug_float *)

let rec fabs x =
  if x < 0.0 then -. x
  else x
in
let ans = 2.71828 in
let err = 0.00001 in
let rec fact n =
  if n <= 1.5 then 1.0
  else n *. (fact (n -. 1.0))
in
let rec e n =
  if n < -0.5 then 0.0
  else (1.0 /. (fact n)) +. (e (n -. 1.0))
in
let out = (e 20.0) in
  if (fabs (out -. ans)) <= err then
    write 48
  else
    write 49
