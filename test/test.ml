let rec f x = 1 in

let _ =
  let x = f () in
  let y =
    if f () < 0 then (g () + 1)
    else x in
  ledout (x + y)
in ()
