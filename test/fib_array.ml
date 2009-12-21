let fib = create_array 11 0 in
fib.(1) <- 1;
let rec loop fib n =
	if n = 11 then ()
	else
		(fib.(n) <- fib.(n - 1) + fib.(n - 2);
		loop fib (n + 1))
in loop fib 2;
write (fib.(10))
