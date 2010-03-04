let pi = 3.14159265358979323846264 in
let rec atan x =
  let (sgn, x) = 
    if x > 1.0 then (1, 1.0 /. x)
    else if x < -1.0 then (-1, 1.0 /. x)
    else (0, x)
  in
  let rec sub i =
    if i >= 12.0 then 0.0
    else (i *. i *. x *. x) /. (2.0 *. i +. 1.0 +. (sub (i +. 1.0))) 
  in
  let a = sub 1.0 in
    if sgn > 0 then pi /. 2.0 -. x /. (1.0 +. a)
    else if sgn < 0 then -. pi /. 2.0 -. x /. (1.0 +. a)
    else x /. (1.0 +. a)
in
  a atan

  (*
  let err = 1.0E-8 in
  let fabs x =
    if x > 0.0 then x
    else -. x
  in
  let chk a b =
    fabs (a -. b) <= (max (fabs a) (fabs b)) *. err
  in    
  let rec sub n =
    if n == 0 then ()
    else
      let x = 1.0 /. (Random.float 100000.0) in
      let (a, b) = (atan x, myatan x) in
        assert (chk a b);
        (*
        print_endline (string_of_float a);
        print_endline (string_of_float b);
        *)
        sub (n - 1)
  in
    sub 100000;;
  *)

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
