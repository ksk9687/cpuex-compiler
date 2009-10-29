(* 浮動小数基本演算 *)
let rec fless a b = (a < b) in
let rec fispos a = (a > 0.0) in
let rec fisneg a = (a < 0.0) in
let rec fiszero a = (a = 0.0) in
let rec fhalf a = a *. 0.5 in
let rec fsqr a = a *. a in
let rec fneg a = -. a in

(* 算術関数 *)
let rec cordic_sin a =
  let rec cordic_rec a i x y z p =
    if i = 25 then y
    else
      if a > z then
	cordic_rec a (i + 1) (x -. p *. y) (y +. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec a (i + 1) (x +. p *. y) (y -. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec a 0 0.607252935008881778 0.0 0.0 1.0
in
let rec cordic_cos a =
  let rec cordic_rec a i x y z p =
    if i = 25 then x
    else
      if a > z then
	cordic_rec a (i + 1) (x -. p *. y) (y +. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec a (i + 1) (x +. p *. y) (y -. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec a 0 0.607252935008881778 0.0 0.0 1.0
in
let rec cordic_atan a =
  let rec cordic_rec i x y z p =
    if i = 25 then z
    else
      if y > 0.0 then
	cordic_rec (i + 1) (x +. p *. y) (y -. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec (i + 1) (x -. p *. y) (y +. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec 0 1.0 a 0.0 1.0
in
let rec sin a =
  if a < 0.0 then -. sin (-. a)
  else if a < 1.570796326794895 then cordic_sin a
  else if a < 3.14159265358979 then cordic_sin (3.14159265358979 -. a)
  else if a < 6.28318530717958 then -. sin (6.28318530717958 -. a)
  else sin (a -. 6.28318530717958)
in
let rec cos a =
  if a < 0.0 then cos (-. a)
  else if a < 1.570796326794895 then cordic_cos a
  else if a < 3.14159265358979 then -. cordic_cos (3.14159265358979 -. a)
  else if a < 6.28318530717958 then cos (6.28318530717958 -. a)
  else cos (a -. 6.28318530717958)
in

let rec atan a =
  cordic_atan a
in
