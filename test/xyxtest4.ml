let rec wait _ =
  let rec wait_rec x y z num =
    if x = 1000 then ledout 0
    else if y = 1000 then wait_rec (x + 1) 0 0 num
    else if z = 1000 then wait_rec x (y + 1) 0 num
    else wait_rec x y (z + 1) (num +. 1.0)
  in
  let _ = wait_rec 0 0 0 0.0 in
  ()
in wait ()
