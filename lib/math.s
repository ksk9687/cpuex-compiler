#######################################################################
#
# 		↓　ここから math.s
#
######################################################################

.align 2
f._171:	.float  1.5707963268E+00
f._170:	.float  5.0000000000E-01
f._169:	.float  6.2831853072E+00
f._168:	.float  1.5915494309E-01
f._167:	.float  3.1415926536E+00
f._166:	.float  3.0000000000E+00
f._165:	.float  1.0500000000E+01
f._164:	.float  -1.5707963268E+00
f._163:	.float  1.5707963268E+00
f._162:	.float  -1.0000000000E+00
f._160:	.float  1.0000000000E+00
f._159:	.float  2.0000000000E+00
f._158:	.float  1.1500000000E+01

.begin atan
######################################################################
# $f1 = atan_sub($f2, $f3)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f5]
# []
# []
# [$ra]
######################################################################
ext_atan_sub:
.count load_float
	load    [f._158], $f1
	ble     $f1, $f2, ble._182
bg._182:
.count stack_store_ra
	store   $ra, [$sp - 3]
.count stack_move
	add     $sp, -3, $sp
.count load_float
	load    [f._159], $f1
	fmul    $f2, $f2, $f4
	fmul    $f1, $f2, $f1
.count load_float
	load    [f._160], $f5
	fadd    $f2, $f5, $f2
	fmul    $f4, $f3, $f4
	fadd    $f1, $f5, $f1
.count stack_store
	store   $f4, [$sp + 1]
.count stack_store
	store   $f1, [$sp + 2]
	call    ext_atan_sub
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 1], $f2
	fadd    $f2, $f1, $f1
.count stack_load
	load    [$sp - 2], $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	ret     
ble._182:
	mov     $f0, $f1
	ret     

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
ext_atan:
.count stack_store_ra
	store   $ra, [$sp - 2]
.count stack_move
	add     $sp, -2, $sp
	fabs    $f2, $f1
.count stack_store
	store   $f2, [$sp + 1]
.count load_float
	load    [f._160], $f6
	ble     $f1, $f6, ble._186
bg._186:
	finv    $f2, $f1
.count move_args
	mov     $f6, $f2
	mov     $f1, $f7
	fmul    $f7, $f7, $f3
	call    ext_atan_sub
	fadd    $f6, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f7, $f1, $f1
	ble     $f2, $f6, ble._188
.count dual_jmp
	b       bg._188
ble._186:
	mov     $f2, $f7
	fmul    $f7, $f7, $f3
.count move_args
	mov     $f6, $f2
	call    ext_atan_sub
	fadd    $f6, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f7, $f1, $f1
	bg      $f2, $f6, bg._188
ble._188:
.count load_float
	load    [f._162], $f3
	ble     $f3, $f2, bge._191
bg._189:
	add     $i0, -1, $i1
	bg      $i1, 0, bg._188
ble._190:
	bge     $i1, 0, bge._191
bl._191:
.count load_float
	load    [f._164], $f2
	fsub    $f2, $f1, $f1
	ret     
bge._191:
	ret     
bg._188:
.count load_float
	load    [f._163], $f2
	fsub    $f2, $f1, $f1
	ret     
.end atan

.begin sin
######################################################################
# $f1 = tan_sub($f2, $f3)
# $ra = $ra
# []
# [$f1 - $f2, $f4]
# []
# []
# [$ra]
######################################################################
ext_tan_sub:
.count load_float
	load    [f._165], $f4
	ble     $f2, $f4, ble._192
bg._192:
	mov     $f0, $f1
	ret     
ble._192:
.count stack_store_ra
	store   $ra, [$sp - 3]
.count stack_move
	add     $sp, -3, $sp
.count stack_store
	store   $f3, [$sp + 1]
.count stack_store
	store   $f2, [$sp + 2]
.count load_float
	load    [f._159], $f1
	fadd    $f2, $f1, $f2
	call    ext_tan_sub
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 1], $f2
	fsub    $f2, $f1, $f1
.count stack_load
	load    [$sp - 2], $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	ret

######################################################################
# $f1 = tan($f2)
# $ra = $ra
# []
# [$f1 - $f5]
# []
# []
# [$ra]
######################################################################
ext_tan:
.count stack_store_ra
	store   $ra, [$sp - 2]
.count stack_move
	add     $sp, -2, $sp
	fmul    $f2, $f2, $f3
.count stack_store
	store   $f2, [$sp + 1]
.count load_float
	load    [f._166], $f1
.count load_float
	load    [f._160], $f5
.count move_args
	mov     $f1, $f2
	call    ext_tan_sub
	fsub    $f5, $f1, $f1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	ret     

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
ext_sin:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
.count load_float
	load    [f._167], $f4
	fabs    $f2, $f5
.count load_float
	load    [f._168], $f1
	ble     $f2, $f0, ble._198
bg._198:
	li      1, $i1
	fmul    $f5, $f1, $f2
	call    ext_floor
.count load_float
	load    [f._169], $f2
	fmul    $f2, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f4, ble._199
.count dual_jmp
	b       bg._199
ble._198:
	li      0, $i1
	fmul    $f5, $f1, $f2
	call    ext_floor
.count load_float
	load    [f._169], $f2
	fmul    $f2, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f4, ble._199
bg._199:
.count load_float
	load    [f._163], $f5
	be      $i1, 0, be._200
.count dual_jmp
	b       bne._200
ble._199:
.count load_float
	load    [f._163], $f5
	be      $i1, 0, bne._200
be._200:
.count load_float
	load    [f._160], $f6
.count load_float
	load    [f._159], $f7
.count load_float
	load    [f._170], $f3
	ble     $f1, $f4, ble._202
.count dual_jmp
	b       bg._202
bne._200:
.count load_float
	load    [f._162], $f6
.count load_float
	load    [f._159], $f7
.count load_float
	load    [f._170], $f3
	ble     $f1, $f4, ble._202
bg._202:
	fsub    $f2, $f1, $f1
	ble     $f1, $f5, ble._203
.count dual_jmp
	b       bg._203
ble._202:
	ble     $f1, $f5, ble._203
bg._203:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f3, $f2
	call    ext_tan
	fmul    $f1, $f1, $f2
.count stack_load_ra
	load    [$sp + 0], $ra
.count load_float
	load    [f._160], $f3
.count stack_move
	add     $sp, 1, $sp
	fmul    $f7, $f1, $f1
	fadd    $f3, $f2, $f2
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	fmul    $f6, $f1, $f1
	ret     
ble._203:
	fmul    $f1, $f3, $f2
	call    ext_tan
	fmul    $f1, $f1, $f2
.count stack_load_ra
	load    [$sp + 0], $ra
.count load_float
	load    [f._160], $f3
.count stack_move
	add     $sp, 1, $sp
	fmul    $f7, $f1, $f1
	fadd    $f3, $f2, $f2
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	fmul    $f6, $f1, $f1
	ret     
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
.begin cos
ext_cos:
.count load_float
	load    [f._171], $f1
	fsub    $f1, $f2, $f2
	b       ext_sin
.end cos

######################################################################
#
# 		↑　ここまで math.s
#
######################################################################
