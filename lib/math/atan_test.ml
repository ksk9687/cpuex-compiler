(* OCaml 処理系を使って簡単なテストを行う *)

let rec true_atan = atan in
let rec fabs x = if x < 0.0 then -. x else x in



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
  


let err a b = fabs (a -. b) /. (max (fabs a) (fabs b)) in
let max2 (e1, x1) (e2, x2) = if e1 > e2 then (e1, x1) else (e2, x2) in
let gen1 () = 1.0 /. (Random.float 100000.0) in
let gen2 () = exp ((Random.float 100.0) -. 50.0) in
let gen3 () = (Random.float 5.0) -. 2.5 in
let rec check f n = 
  let rec sub n ex = 
    if n == 0 then ex
    else
      let x = f () in
      let (a, b) = (atan x, true_atan x) in
        sub (n - 1) (max2 ((err a b), x) ex)
  in
    sub n (-1.0, 0.0)
in
let (e, x) = 
  max2
    (check gen3 1000000)
    (max2 (check gen1 1000000) (check gen2 1000000)) 
in
  print_endline ("maximum relative error = " ^ (string_of_float e));
  print_endline ("where x = " ^ (string_of_float x));;



(*
/***********************************************************
	atan.c -- 逆三角関数
***********************************************************/
#define N  24  /* 本文参照 */
#define PI 3.14159265358979323846264
long double latan(long double x)  /* アークタンジェント */
{
	int i, sgn;
	long double a;

	if      (x >  1) {  sgn =  1;  x = 1 / x;  }
	else if (x < -1) {  sgn = -1;  x = 1 / x;  }
	else                sgn =  0;
	a = 0;
	for (i = N; i >= 1; i--)
		a = (i * i * x * x) / (2 * i + 1 + a);
	if (sgn > 0) return  PI / 2 - x / (1 + a);
	if (sgn < 0) return -PI / 2 - x / (1 + a);
	/* else */   return           x / (1 + a);
}
*)
