	li      9, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     fib.10
	sub     $sp, 1, $sp
	load    0($sp), $ra
	mov     $1, $27
	store   $27, 0($sp)
	li      8, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     fib.10
	sub     $sp, 2, $sp
	load    1($sp), $ra
	mov     $1, $27
	load    0($sp), $26
	add     $26, $27, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_write
	sub     $sp, 2, $sp
	load    1($sp), $ra
	halt
fib.10:
	li      1, $tmp
	cmp     $1, $tmp, $tmp
	bg      $tmp, ble_else.67
	ret
ble_else.67:
	store   $1, 0($sp)
	sub     $1, 1, $27
	li      1, $tmp
	cmp     $27, $tmp, $tmp
	bg      $tmp, ble_else.68
	b       ble_cont.69
ble_else.68:
	store   $27, 1($sp)
	sub     $27, 1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     fib.10
	sub     $sp, 3, $sp
	load    2($sp), $ra
	mov     $1, $27
	store   $27, 2($sp)
	load    1($sp), $27
	sub     $27, 2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     fib.10
	sub     $sp, 4, $sp
	load    3($sp), $ra
	mov     $1, $27
	load    2($sp), $26
	add     $26, $27, $27
ble_cont.69:
	store   $27, 3($sp)
	load    0($sp), $27
	sub     $27, 2, $27
	li      1, $tmp
	cmp     $27, $tmp, $tmp
	bg      $tmp, ble_else.70
	b       ble_cont.71
ble_else.70:
	store   $27, 4($sp)
	sub     $27, 1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     fib.10
	sub     $sp, 6, $sp
	load    5($sp), $ra
	mov     $1, $27
	store   $27, 5($sp)
	load    4($sp), $27
	sub     $27, 2, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     fib.10
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $1, $27
	load    5($sp), $26
	add     $26, $27, $27
ble_cont.71:
	load    3($sp), $26
	add     $26, $27, $1
	ret
