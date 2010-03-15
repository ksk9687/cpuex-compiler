let rec fib n =
	if n <= 1 then n
	else (fib (n - 1)) + (fib (n - 2))
in 

let rec loop _ =
	let x = read_int () in
	write (fib x);
in loop ()
