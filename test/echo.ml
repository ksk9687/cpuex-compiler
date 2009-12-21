let rec loop _ =
	let x = read_int () in (* read_byte *)
	if x <= 255 then
		let _ = write x in
		loop ()
	else ()
in loop ()
