let rec sigma n =
	if n = 0 then 0.0
	else (sigma (n - 1)) +. (float_of_int n) *. (float_of_int n)
in
write (int_of_float (sigma 5))
