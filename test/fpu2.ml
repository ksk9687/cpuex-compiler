let rec loop n =
  if n = 1000 then loop 0
  else
    let m = float_of_int n in
    if (n + n) <> int_of_float (m *. 2.0 +. 0.1) then
      ledout 1
    else if (n + 3) <> int_of_float (m +. 3.0 +. 0.1) then
      ledout 2
    else if (1100 - n) <> int_of_float (1100.0 -. m +. 0.1) then
      ledout 3
    else if n <> int_of_float ((sqrt m) *. (sqrt m) +. 0.1) then
      ledout 4
    else if n <> int_of_float (fabs((fneg m) -. 1.0) -. 1.0 +. 0.1) then
      ledout 5
    else if n = 0 then
      loop (n + 1)
    else if n <> int_of_float (1.0 /. (1.0 /. m) +. 0.1) then
      ledout 6
    else
      loop (n + 1)
in
ledout 0;
loop 0
