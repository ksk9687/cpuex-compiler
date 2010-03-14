f._177:	.float  1.5707963268E+00
f._176:	.float  6.2831853072E+00
f._175:	.float  1.5915494309E-01
f._174:	.float  3.1415926536E+00
f._173:	.float  9.0000000000E+00
f._172:	.float  2.5000000000E+00
f._171:	.float  -1.5707963268E+00
f._170:	.float  1.5707963268E+00
f._169:	.float  -1.0000000000E+00
f._167:	.float  1.1000000000E+01
f._166:	.float  2.0000000000E+00
f._165:	.float  1.0000000000E+00
f._164:	.float  5.0000000000E-01

######################################################################
# $f1 = atan_sub($f2, $f3, $f4)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f6]
# []
# []
# []
######################################################################
.align 2
.begin atan_sub
ext_atan_sub:
.count load_float
	load    [f._164], $f5
	ble     $f5, $f2, ble._182
bg._182:
	mov     $f4, $f1
	ret     
ble._182:
.count load_float
	load    [f._166], $f1
	fmul    $f2, $f2, $f6
.count load_float
	load    [f._165], $f5
	fmul    $f1, $f2, $f1
	fsub    $f2, $f5, $f2
	fmul    $f6, $f3, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f4, $f1
	finv    $f1, $f1
	fmul    $f6, $f1, $f4
	b       ext_atan_sub
.end atan_sub

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin atan
ext_atan:
.count stack_store_ra
	store   $ra, [$sp - 2]
.count stack_move
	add     $sp, -2, $sp
	fabs    $f2, $f3
.count stack_store
	store   $f2, [$sp + 1]
.count load_float
	load    [f._165], $f7
.count move_args
	mov     $f0, $f4
.count load_float
	load    [f._167], $f1
	ble     $f3, $f7, ble._184
bg._184:
	finv    $f2, $f2
	mov     $f2, $f8
	fmul    $f8, $f8, $f3
.count move_args
	mov     $f1, $f2
	call    ext_atan_sub
	fadd    $f7, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f8, $f1, $f1
	ble     $f2, $f7, ble._186
.count dual_jmp
	b       bg._186
ble._184:
	mov     $f2, $f8
	fmul    $f8, $f8, $f3
.count move_args
	mov     $f1, $f2
	call    ext_atan_sub
	fadd    $f7, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f8, $f1, $f1
	bg      $f2, $f7, bg._186
ble._186:
.count load_float
	load    [f._169], $f3
	ble     $f3, $f2, bge._189
bg._187:
	add     $i0, -1, $i1
	bg      $i1, 0, bg._186
ble._188:
	bge     $i1, 0, bge._189
bl._189:
.count load_float
	load    [f._171], $f2
	fsub    $f2, $f1, $f1
	ret     
bge._189:
	ret     
bg._186:
.count load_float
	load    [f._170], $f2
	fsub    $f2, $f1, $f1
	ret     
.end atan

######################################################################
# $f1 = tan_sub($f2, $f3, $f4)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f5]
# []
# []
# []
######################################################################
.align 2
.begin tan_sub
ext_tan_sub:
.count load_float
	load    [f._172], $f5
	ble     $f5, $f2, ble._190
bg._190:
	mov     $f4, $f1
	ret     
ble._190:
	fsub    $f2, $f4, $f1
.count load_float
	load    [f._166], $f4
	fsub    $f2, $f4, $f2
	finv    $f1, $f1
	fmul    $f3, $f1, $f4
	b       ext_tan_sub
.end tan_sub

######################################################################
# $f1 = tan($f2)
# $ra = $ra
# []
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.align 2
.begin tan
ext_tan:
.count stack_store_ra
	store   $ra, [$sp - 2]
.count stack_move
	add     $sp, -2, $sp
	fmul    $f2, $f2, $f3
.count stack_store
	store   $f2, [$sp + 1]
.count load_float
	load    [f._173], $f1
.count move_args
	mov     $f0, $f4
.count load_float
	load    [f._165], $f6
.count move_args
	mov     $f1, $f2
	call    ext_tan_sub
	fsub    $f6, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	ret     
.end tan

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin sin
ext_sin:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
.count load_float
	load    [f._174], $f4
	fabs    $f2, $f5
.count load_float
	load    [f._175], $f1
	ble     $f2, $f0, ble._194
bg._194:
	li      1, $i1
	fmul    $f5, $f1, $f2
	call    ext_floor
.count load_float
	load    [f._176], $f2
	fmul    $f2, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f4, ble._195
.count dual_jmp
	b       bg._195
ble._194:
	li      0, $i1
	fmul    $f5, $f1, $f2
	call    ext_floor
.count load_float
	load    [f._176], $f2
	fmul    $f2, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f4, ble._195
bg._195:
.count load_float
	load    [f._170], $f5
	be      $i1, 0, be._196
.count dual_jmp
	b       bne._196
ble._195:
.count load_float
	load    [f._170], $f5
	be      $i1, 0, bne._196
be._196:
.count load_float
	load    [f._165], $f7
.count load_float
	load    [f._166], $f8
.count load_float
	load    [f._164], $f3
	ble     $f1, $f4, ble._198
.count dual_jmp
	b       bg._198
bne._196:
.count load_float
	load    [f._169], $f7
.count load_float
	load    [f._166], $f8
.count load_float
	load    [f._164], $f3
	ble     $f1, $f4, ble._198
bg._198:
	fsub    $f2, $f1, $f1
	ble     $f1, $f5, ble._199
.count dual_jmp
	b       bg._199
ble._198:
	ble     $f1, $f5, ble._199
bg._199:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f3, $f2
	call    ext_tan
	fmul    $f1, $f1, $f2
.count stack_load_ra
	load    [$sp + 0], $ra
.count load_float
	load    [f._165], $f3
.count stack_move
	add     $sp, 1, $sp
	fmul    $f8, $f1, $f1
	fadd    $f3, $f2, $f2
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	fmul    $f7, $f1, $f1
	ret     
ble._199:
	fmul    $f1, $f3, $f2
	call    ext_tan
	fmul    $f1, $f1, $f2
.count stack_load_ra
	load    [$sp + 0], $ra
.count load_float
	load    [f._165], $f3
.count stack_move
	add     $sp, 1, $sp
	fmul    $f8, $f1, $f1
	fadd    $f3, $f2, $f2
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	fmul    $f7, $f1, $f1
	ret     
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin cos
ext_cos:
.count load_float
	load    [f._177], $f1
	fsub    $f1, $f2, $f2
	b       ext_sin
.end cos
