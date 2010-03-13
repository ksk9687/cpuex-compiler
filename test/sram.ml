let rec init n a b =
  if n = 1000 then ()
  else (
    a.(n) <- n;
    b.(n) <- (float_of_int n);
    init (n + 1) a b
  )
in
let rec loop n a b =
  if n = 1000 then loop 0 a b
  else if a.(n) <> n then ledout 1
  else if b.(n) <> float_of_int n then ledout 2
  else loop (n + 1) a b
in
let a = create_array 1000 0 in
let b = create_array 1000 0.0 in
ledout 0;
init 0 a b;
loop 0 a b
