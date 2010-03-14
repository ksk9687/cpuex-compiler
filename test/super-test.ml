let rec init n =
  if n = 96 then ()
  else (
    a.(n) <- create_array 96 0;
    b.(n) <- create_array 96 0.0;
    init (n + 1)
  )
in
let rec separater n =
  if n = 16 then ()
  else (
    write2 32;
    separater (n + 1)
  )
in
let rec wait _ =
  let rec wait_rec x y z num =
    if x = 0 then b.(0).(0) <- num;
    else if y = 100 then wait_rec (x + 1) 0 0 num
    else if z = 100 then wait_rec x (y + 1) 0 num
    else wait_rec x y (z + 1) (num +. 1.0)
  in
  let _ = wait_rec 0 0 0 0.0 in
  ()
in
let rec iotest _ =
  let rec read_rec n m =
    if m = 96 then ()
    else if n = 96 then (
      wait ();
      read_rec 0 (m + 1)
    ) else (
      a.(n).(m) <- read ();
      read_rec (n + 1) m
    )
  in
  read_rec 0 0;
  let rec write2_rec n m =
    if m = 96 then ()
    else if n = 96 then (
      wait ();
      write2_rec 0 (m + 1)
    ) else (
      write2 a.(n).(m);
      if n + 1 < 96 then a.(n + 1).(m) <- a.(n + 1).(m) + n
      else ();
      write2_rec (n + 1) m
    )
  in
  write2_rec 0 0
in
let rec itoftest _ =
  let rec itof_rec n m =
    if m = 96 then ()
    else if n = 96 then (
      wait ();
      itof_rec 0 (m + 1)
    ) else (
      let x = a.(n).(m) in
      let y = a.(if n = 0 then 95 else (n - 1)).(m) in
      let z = a.(n).(if m = 0 then 95 else (m - 1)) in
      let x = float_of_int x in
      let y = float_of_int y in
      let z = float_of_int z in
      let d = int_of_float (x *. y /. z) in
      let d = if d <= 0 then 1 else d in
      write2 d;
      a.(n).(m) <- d;
      itof_rec (n + 1) m
    )
  in
  itof_rec 0 0
in
let rec fputest _ =
  let rec fpu_rec n =
    if n = 96 then ()
    else
      let x = sin ((float_of_int n) /. 96.0) in
      write2 (int_of_float (x *. 100.0));
      fpu_rec (n + 1)
  in
  fpu_rec 0
in
let rec loadtest _ =
  let rec load_rec n m sum =
    if m = 96 then sum
    else if n = 96 then (
      write2 sum;
      load_rec 0 (m + 1) sum
    ) else (
      load_rec (n + 1) m (sum + a.(n).(m) + a.(0).(0) + a.(1).(1) + a.(2).(2))
    )
  in
  load_rec 0 0 0
in
let _ =
  init 0;
  iotest ();
  separater 0;
  itoftest ();
  separater 0;
  fputest ();
  separater 0;
  loadtest ();
in 0
