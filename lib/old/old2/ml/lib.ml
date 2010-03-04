(*
let cordic_n = 25
let sqrt_n = 50
let pi = 3.14159265358979
let pi2 = pi *. 2.0
let pih = pi *. 0.5
let atan_table = Array.make cordic_n 0.0
let rsqrt_table = Array.make sqrt_n 0.0
let rref = ref 1.0

let init_atan =
  let rec init_rec i d =
    if i = cordic_n then ()
    else (
      atan_table.(i) <- atan d;
      rref := !rref *. cos(atan_table.(i));
      init_rec (i + 1) (d /. 2.0)
    )
  in init_rec 0 1.0

let r = !rref

let init_rsqrt =
  let rec init_rec i p =
    if i = sqrt_n then ()
    else begin
      rsqrt_table.(i) <- 1.0 /. (sqrt p);
      init_rec (i + 1) (p *. 2.0)
    end;
  in
    init_rec 0 1.0
*)

let cordic_n = 25
let sqrt_n = 50
let pi = 3.14159265358979
let pi2 = 6.28318530717958
let pih = 1.570796326794895
let atan_table =
[|0.785398163397448279; 0.463647609000806094; 0.244978663126864143;
  0.124354994546761438; 0.06241880999595735; 0.0312398334302682774;
  0.0156237286204768313; 0.00781234106010111114; 0.00390623013196697176;
  0.00195312251647881876; 0.000976562189559319459; 0.00048828121119489829;
  0.000244140620149361771; 0.000122070311893670208; 6.10351561742087726e-05;
  3.05175781155260957e-05; 1.52587890613157615e-05; 7.62939453110197e-06;
  3.81469726560649614e-06; 1.90734863281018696e-06; 9.53674316405960844e-07;
  4.76837158203088842e-07; 2.38418579101557974e-07; 1.19209289550780681e-07;
  5.96046447753905522e-08|]
let rsqrt_table =
[|1.; 0.707106781186547462; 0.5; 0.353553390593273731; 0.25;
  0.176776695296636865; 0.125; 0.0883883476483184327; 0.0625;
  0.0441941738241592164; 0.03125; 0.0220970869120796082; 0.015625;
  0.0110485434560398041; 0.0078125; 0.00552427172801990204; 0.00390625;
  0.00276213586400995102; 0.001953125; 0.00138106793200497551; 0.0009765625;
  0.000690533966002487756; 0.00048828125; 0.000345266983001243878;
  0.000244140625; 0.000172633491500621939; 0.0001220703125;
  8.63167457503109694e-05; 6.103515625e-05; 4.31583728751554847e-05;
  3.0517578125e-05; 2.15791864375777424e-05; 1.52587890625e-05;
  1.07895932187888712e-05; 7.62939453125e-06; 5.39479660939443559e-06;
  3.814697265625e-06; 2.6973983046972178e-06; 1.9073486328125e-06;
  1.3486991523486089e-06; 9.5367431640625e-07; 6.74349576174304449e-07;
  4.76837158203125e-07; 3.37174788087152224e-07; 2.384185791015625e-07;
  1.68587394043576112e-07; 1.1920928955078125e-07; 8.42936970217880561e-08;
  5.9604644775390625e-08; 4.21468485108940281e-08|]
let r = 0.607252935008881778


(* ここまで準備 *)
(*
cordic。aは[0, pi/2]の範囲におさめとく。
*.0.5 はつまりはシフト演算なので、fadd, fsub, shift, tablelookup だけで出来る。らしい。
*)
let rec cordic_sin a =
  let rec cordic_rec i x y z p =
    if i = cordic_n then y
    else
      if a > z then
	cordic_rec (i + 1) (x -. p *. y) (y +. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec (i + 1) (x +. p *. y) (y -. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec 0 r 0.0 0.0 1.0

let rec cordic_cos a =
  let rec cordic_rec i x y z p =
    if i = cordic_n then x
    else
      if a > z then
	cordic_rec (i + 1) (x -. p *. y) (y +. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec (i + 1) (x +. p *. y) (y -. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec 0 r 0.0 0.0 1.0

let rec cordic_atan a =
  let rec cordic_rec i x y z p =
    if i = cordic_n then z
    else
      if y > 0.0 then
	cordic_rec (i + 1) (x +. p *. y) (y -. p *. x) (z +. atan_table.(i)) (p *. 0.5)
      else
	cordic_rec (i + 1) (x -. p *. y) (y +. p *. x) (z -. atan_table.(i)) (p *. 0.5)
  in cordic_rec 0 1.0 a 0.0 1.0

let rec mysin a =
  if a < 0.0 then mysin (a -. (floor (a /. pi2)) *. pi2)
  else if a < pih then cordic_sin a
  else if a < pi then cordic_sin (pi -. a)
  else if a < pi2 then -. mysin (pi2 -. a)
  else mysin (a -. (floor (a /. pi2)) *. pi2)

let rec mycos a =
  if a < 0.0 then mycos (a -. (floor (a /. pi2)) *. pi2)
  else if a < pih then cordic_cos a
  else if a < pi then -. cordic_cos (pi -. a)
  else if a < pi2 then mycos (pi2 -. a)
  else mycos (a -. (floor (a /. pi2)) *. pi2)

let rec myatan a =
  cordic_atan a

(*
sqrt
平方根よーわからん。
*)
(* 初期値探してくる。一番近い1/sqrt(a)のaを2で割りまくって探すみたいなてきとうさ *)
let rec get_sqrt_init a =
  let rec get_sqrt_init_rec a m =
    if m = sqrt_n - 1 || a < 2.0 then rsqrt_table.(m)
    else get_sqrt_init_rec (a /. 2.0) (m + 1)
  in get_sqrt_init_rec a 0

let rec mysqrt a =
  if a < 1.0 then
    let x = a in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
      let x = 0.5 *. (x +. a /. x) in
	x
  else
    let x = get_sqrt_init a in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
    let x = 0.5 *. x *. (3.0 -. a *. x *. x) in
      x *. a
