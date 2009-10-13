
let iter = 10000
let max = 0.1
let eps = 1.0e-7

let debug = false

let check a b =
  let sub = a -. b in
    if sub < -.eps then false
    else if sub <= eps then true
    else false

let _ =
  Format.printf "random in (%e, %e)\n" (-. max /. 2.0) (max /. 2.0);
  Format.printf "eps = %e\n\n" eps;

  Random.init (int_of_float(Unix.time()));
  let win = ref 0 in
  let lose = ref 0 in
    Format.printf "sin test...\n";
    for i = 1 to iter do
      let a = (Random.float max) -. (max /. 2.0) in
      let x = Lib.mysin a in
      let y = sin a in
	if check x y then win := !win + 1
	else begin
	  lose := !lose + 1;
	  (if debug then Format.printf "a = %03.8f, sin = %03.8f, mysin = %03.8f\n" a y x)
	end
    done;
    Format.printf "iter = %d, win = %d, lose = %d\n\n" iter !win !lose;
    win := 0;
    lose := 0;
    Format.printf "cos test...\n";
    for i = 1 to iter do
      let a = (Random.float max) -. (max /. 2.0) in
      let x = Lib.mycos a in
      let y = cos a in
	if check x y then win := !win + 1
	else begin
	  lose := !lose + 1;
	  (if debug then Format.printf "a = %03.8f, cos = %03.8f, mycos = %03.8f\n" a y x)
	end
    done;
    Format.printf "iter = %d, win = %d, lose = %d\n\n" iter !win !lose;
    win := 0;
    lose := 0;
    Format.printf "atan test...\n";
    for i = 1 to iter do
      let a = (Random.float max) -. (max /. 2.0) in
      let x = Lib.myatan a in
      let y = atan a in
	if check x y then win := !win + 1
	else begin
	  lose := !lose + 1;
	  (if debug then Format.printf "a = %03.8f, atan = %03.8f, myatan = %03.8f\n" a y x)
	end
    done;
    Format.printf "iter = %d, win = %d, lose = %d\n\n" iter !win !lose;
    win := 0;
    lose := 0;
    Format.printf "sqrt test...\n";
    for i = 1 to iter do
      let a = (Random.float max) in
      let x = Lib.mysqrt a in
      let y = sqrt a in
	if check x y then win := !win + 1
	else begin
	  lose := !lose + 1;
	  (if debug then Format.printf "a = %03.8f, sqrt = %03.8f, mysqrt = %03.8f\n" a y x)
	end
    done;
    Format.printf "iter = %d, win = %d, lose = %d\n\n" iter !win !lose;

      
