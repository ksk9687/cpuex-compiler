let rec atan x =
  let pi = 3.14159265358979323846264 in
  let sgn =
    if x > 1.0 then 1
    else if x < -1.0 then -1
    else 0
  in
  let x =
    if (fabs x) > 1.0 then 1.0 /. x
    else x
  in
  let rec atan_sub i xx =
    if i >= 11.5 then 0.0
    else (i *. i *. xx) /. (2.0 *. i +. 1.0 +. (atan_sub (i +. 1.0) xx))
  in
  let a = atan_sub 1.0 (x *. x) in
  let b = x /. (1.0 +. a) in
    if sgn > 0 then pi /. 2.0 -. b
    else if sgn < 0 then -. pi /. 2.0 -. b
    else b
in
let rec sin x =
  let rec tan x = (* -pi/4 <= x <= pi/4 *)
    let rec tan_sub i xx =
      if i > 10.5 then 0.
      else xx /. (i -. (tan_sub (i +. 2.) xx)) 
    in
      x /. (1. -. (tan_sub 3. (x *. x)))
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
  0

