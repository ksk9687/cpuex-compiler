f._164:	.float  6.2831853072E+00
f._163:	.float  3.1415926536E+00
f._162:	.float  1.5707963268E+00
f._161:	.float  6.0725293501E-01
f._160:	.float  1.0000000000E+00
f._159:	.float  5.0000000000E-01
f._158:	.float  0.0000000000E+00

######################################################################
# $f1 = cordic_atan_rec($i2, $f2, $f3, $f4, $f5)
# $ra = $ra
# [$i1 - $i2]
# [$f1 - $f5]
# []
# []
# []
######################################################################
.begin cordic_atan_rec
ext_cordic_atan_rec:
	bne     $i2, 25, bne._165
be._165:
	mov     $f4, $f1
	ret     
bne._165:
.count load_float
	load    [f._158], $f1
	add     $i2, 1, $i1
	bg      $f3, $f1, bg._166
ble._166:
	fmul    $f5, $f3, $f1
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fsub    $f4, $f2, $f4
.count load_float
	load    [f._159], $f2
	fmul    $f5, $f2, $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f1, $f2
	b       ext_cordic_atan_rec
bg._166:
	fmul    $f5, $f3, $f1
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fadd    $f4, $f2, $f4
.count load_float
	load    [f._159], $f2
	fmul    $f5, $f2, $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f1, $f2
	b       ext_cordic_atan_rec
.end cordic_atan_rec

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i1 - $i2]
# [$f1 - $f5]
# []
# []
# []
######################################################################
.begin atan
ext_atan:
	li      0, $i2
.count load_float
	load    [f._160], $f1
.count load_float
	load    [f._158], $f4
.count load_float
	load    [f._160], $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f1, $f2
	b       ext_cordic_atan_rec
.end atan

######################################################################
# $f1 = cordic_sin_rec($f2, $i2, $f3, $f4, $f5, $f6)
# $ra = $ra
# [$i1 - $i2]
# [$f1, $f3 - $f6]
# []
# []
# []
######################################################################
.begin cordic_sin_rec
ext_cordic_sin_rec:
	bne     $i2, 25, bne._167
be._167:
	mov     $f4, $f1
	ret     
bne._167:
	fmul    $f6, $f4, $f1
	add     $i2, 1, $i1
	bg      $f2, $f5, bg._168
ble._168:
	fadd    $f3, $f1, $f1
	fmul    $f6, $f3, $f3
	fsub    $f4, $f3, $f4
	load    [ext_atan_table + $i2], $f3
	fsub    $f5, $f3, $f5
.count load_float
	load    [f._159], $f3
	fmul    $f6, $f3, $f6
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f1, $f3
	b       ext_cordic_sin_rec
bg._168:
	fsub    $f3, $f1, $f1
	fmul    $f6, $f3, $f3
	fadd    $f4, $f3, $f4
	load    [ext_atan_table + $i2], $f3
	fadd    $f5, $f3, $f5
.count load_float
	load    [f._159], $f3
	fmul    $f6, $f3, $f6
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f1, $f3
	b       ext_cordic_sin_rec
.end cordic_sin_rec

######################################################################
# $f1 = cordic_sin($f2)
# $ra = $ra
# [$i1 - $i2]
# [$f1, $f3 - $f6]
# []
# []
# []
######################################################################
.begin cordic_sin
ext_cordic_sin:
	li      0, $i2
.count load_float
	load    [f._161], $f3
.count load_float
	load    [f._158], $f4
.count load_float
	load    [f._158], $f5
.count load_float
	load    [f._160], $f6
	b       ext_cordic_sin_rec
.end cordic_sin

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i1 - $i2]
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.begin sin
ext_sin:
.count load_float
	load    [f._158], $f1
	bg      $f1, $f2, bg._169
ble._169:
.count load_float
	load    [f._162], $f1
	bg      $f1, $f2, ext_cordic_sin
ble._170:
.count load_float
	load    [f._163], $f1
	bg      $f1, $f2, bg._171
ble._171:
.count load_float
	load    [f._164], $f1
	bg      $f1, $f2, bg._172
ble._172:
.count load_float
	load    [f._164], $f1
	fsub    $f2, $f1, $f2
	b       ext_sin
bg._172:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
.count load_float
	load    [f._164], $f1
	fsub    $f1, $f2, $f2
	call    ext_sin
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret     
bg._171:
.count load_float
	load    [f._163], $f1
	fsub    $f1, $f2, $f2
	b       ext_cordic_sin
bg._169:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
	fneg    $f2, $f2
	call    ext_sin
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret     
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i1 - $i2]
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.begin cos
ext_cos:
.count load_float
	load    [f._162], $f1
	fsub    $f1, $f2, $f2
	b       ext_sin
.end cos
