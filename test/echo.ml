let rec loop _ =
	let x = read () in
	write x;
	loop ()
in loop ()
