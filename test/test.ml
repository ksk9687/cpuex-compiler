let rec loop _ =
	let x = read_int () in (* read_byte *)
	write x;
	loop ()
in loop ()
