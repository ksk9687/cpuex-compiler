(*let rec fib n = if n <= 1 then n else (fib (n - 1)) + (fib (n - 2)) in debug_int (fib 10)*)
(*let x = a.(0) + 1 in debug_int (x + 1); debug_int (x)*)
(*let x = a.(0) in let y = a.(0) in x + y*)
(*let x = a.(0) + b.(0) in let y = a.(0) + b.(0) in x + y*)
(*let z = 2.0 in let x = floor z in let y = floor z in debug_int (x + y)*)
(*let z = 1 in let x = create_array z z in let y = create_array z z in x.(0) <- 2; debug_int (y.(0))*)
(*let rec f _ = 1 in let z = 2 in let x = f z in let y = f z in debug_int (x + y)*)
let rec make_adder x =
  let rec adder y = x + y in
  adder in
debug_int ((make_adder 3) 7)

