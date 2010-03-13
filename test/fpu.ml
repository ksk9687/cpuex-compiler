let rec set a =
  a.(0) <- 1.0
in

let _ =
  let n = (int_of_float (float_of_int 55)) in
  if n <> 55 then
    ledout 1
  else
    let a = int_of_float (fabs (float_of_int (-1))) in
    if a <> 1 then
      ledout 2
    else
      let a = create_array 1 0.0 in
      let _ = set a in
      let a = int_of_float a.(0) in
      if a <> 1 then
        ledout 3
      else
        ledout 4
in 0
