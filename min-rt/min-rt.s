######################################################################
#
# 		↓　ここから macro.s
#
######################################################################

#レジスタ名置き換え
.define $hp $i63
.define $sp $i62
.define $tmp $i61
.define $ra $i60
.define $i63 orz
.define $i62 orz
.define $i61 orz
.define $i60 orz

#標準命令
.define { li %Imm, %iReg } { li %1 %2 }
.define { add %iReg, %Imm, %iReg } { addi %1 %2 %3 }
.define { sub %iReg, %Imm, %iReg } { subi %1 %2 %3 }
.define { mov %iReg, %iReg } { mov %1 %2 }
.define { add %iReg, %iReg, %iReg } { add %1 %2 %3 }
.define { sub %iReg, %iReg, %iReg } { sub %1 %2 %3 }
.define { cmpjmp %Imm, %iReg, %iReg, %Imm } { cmpjmp %1 %2 %3 %4 }
.define { cmpjmp %Imm, %iReg, %Imm, %Imm } { cmpijmp %1 %2 %3 %4 }
.define { cmpjmp %Imm, %fReg, %fReg, %Imm } { fcmpjmp %1 %2 %3 %4 }
.define { jal %Imm, %iReg } { jal %1 %2 }
.define { fadd %fReg, %fReg, %fReg } { fadd 0 %1 %2 %3 }
.define { fsub %fReg, %fReg, %fReg } { fsub 0 %1 %2 %3 }
.define { fmul %fReg, %fReg, %fReg } { fmul 0 %1 %2 %3 }
.define { finv %fReg, %fReg } { finv 0 %1 %2 }
.define { fsqrt %fReg, %fReg } { fsqrt 0 %1 %2 }
.define { mov %fReg, %fReg } { fmov 0 %1 %2 }
.define { fadd_a %fReg, %fReg, %fReg } { fadd 2 %1 %2 %3 }
.define { fsub_a %fReg, %fReg, %fReg } { fsub 2 %1 %2 %3 }
.define { fmul_a %fReg, %fReg, %fReg } { fmul 2 %1 %2 %3 }
.define { finv_a %fReg, %fReg } { finv 2 %1 %2 }
.define { fsqrt_a %fReg, %fReg } { fsqrt 2 %1 %2 }
.define { fabs %fReg, %fReg } { fmov 2 %1 %2 }
.define { fadd_n %fReg, %fReg, %fReg } { fadd 1 %1 %2 %3 }
.define { fsub_n %fReg, %fReg, %fReg } { fsub 1 %1 %2 %3 }
.define { fmul_n %fReg, %fReg, %fReg } { fmul 1 %1 %2 %3 }
.define { finv_n %fReg, %fReg } { finv 1 %1 %2 }
.define { fsqrt_n %fReg, %fReg } { fsqrt 1 %1 %2 }
.define { fneg %fReg, %fReg } { fmov 1 %1 %2 }
.define { load [%iReg + %Imm], %iReg } { load %1 %2 %3 }
.define { load [%iReg + %iReg], %iReg } { loadr %1 %2 %3 }
.define { store %iReg, [%iReg + %Imm] } { store %2 %3 %1 }
.define { store_inst %iReg, %iReg } { store_inst %2 %1 }
.define { load [%iReg + %Imm], %fReg } { fload %1 %2 %3 }
.define { load [%iReg + %iReg], %fReg } { floadr %1 %2 %3 }
.define { store %fReg, [%iReg + %Imm] } { fstore %2 %3 %1 }
.define { mov %iReg, %fReg } { imovf %1 %2 }
.define { mov %fReg, %iReg } { fmovi %1 %2 }
.define { write %iReg, %iReg } { write %1 %2 }
.define { ledout %iReg, %iReg } { ledout %1 %2 }
.define { ledout %Imm, %iReg } { ledouti %1 %2 }

#疑似命令
.define { add %iReg, -%Imm, %iReg } { sub %1, %2, %3 }
.define { sub %iReg, -%Imm, %iReg } { add %1, %2, %3 }
.define { sll %iReg, %iReg } { add %1, %1, %2 }
.define { neg %iReg, %iReg } { sub $i0, %1, %2 }
.define { b %Imm } { cmpjmp 0, $i0, 0, %1 }
.define { be %s, %s, %Imm } { cmpjmp 5, %1, %2, %3 }
.define { bne %s, %s, %Imm } { cmpjmp 2, %1, %2, %3 }
.define { bl %s, %s, %Imm } { cmpjmp 6, %1, %2, %3 }
.define { ble %s, %s, %Imm } { cmpjmp 4, %1, %2, %3 }
.define { bg %s, %s, %Imm } { cmpjmp 3, %1, %2, %3 }
.define { bge %s, %s, %Imm } { cmpjmp 1, %1, %2, %3 }
.define { be %s, %Imm, %Imm } { cmpjmp 5, %1, %2, %3 }
.define { bne %s, %Imm, %Imm } { cmpjmp 2, %1, %2, %3 }
.define { bl %s, %Imm, %Imm } { cmpjmp 6, %1, %2, %3 }
.define { ble %s, %Imm, %Imm } { cmpjmp 4, %1, %2, %3 }
.define { bg %s, %Imm, %Imm } { cmpjmp 3, %1, %2, %3 }
.define { bge %s, %Imm, %Imm } { cmpjmp 1, %1, %2, %3 }
.define { load [%iReg - %Imm], %s } { load [%1 + -%2], %3}
.define { load [%iReg], %s } { load [%1 + 0], %2 }
.define { load [%Imm], %s } { load [$i0 + %1], %2 }
.define { load [%Imm + %iReg], %s } { load [%2 + %1], %3 }
.define { load [%Imm + %Imm], %s } { load [%{ %1 + %2 }], %3 }
.define { load [%Imm - %Imm], %s } { load [%{ %1 - %2 }], %3 }
.define { store %s, [%iReg - %Imm] } { store %1, [%2 + -%3] }
.define { store %s, [%iReg] } { store %1, [%2 + 0] }
.define { store %s, [%Imm] } { store %1, [$i0 + %2] }
.define { store %s, [%Imm + %iReg] } { store %1, [%3 + %2] }
.define { store %s, [%Imm + %Imm] } { store %1, [%{ %2 + %3 }] }
.define { store %s, [%Imm - %Imm] } { store %1, [%{ %2 - %3 }] }
.define { halt } { b %pc }
.define { call %Imm } { jal %1, $ra }
.define { ret } { jr $ra }

#スタックとヒープの初期化($hp=0x2000,$sp=0x20000)
	li      0, $i0
	mov     $i0, $f0
	li      0x2000, $hp
	sll     $hp, $sp
	sll     $sp, $sp
	sll     $sp, $sp
	sll     $sp, $sp
	call    ext_main
	halt

######################################################################
#
# 		↑　ここまで macro.s
#
######################################################################
#######################################################################
#
# 		↓　ここから lib_asm.s
#
######################################################################

FLOOR_ONE:
	.float 1.0
FLOOR_MONE:
	.float -1.0
FLOAT_MAGICI:
	.int 8388608
FLOAT_MAGICF:
	.float 8388608.0
FLOAT_MAGICFHX:
	.int 1258291200			# 0x4b000000

######################################################################
# $f1 = floor($f2)
# $ra = $ra
# []
# [$f1 - $f3]
######################################################################
.begin floor
ext_floor:
	mov $f2, $f1
	bge $f1, $f0, FLOOR_POSITIVE
	fneg $f1, $f1
	mov $ra, $tmp
	call FLOOR_POSITIVE
	load [FLOOR_MONE], $f2
	fsub $f2, $f1, $f1
	jr $tmp
FLOOR_POSITIVE:
	load [FLOAT_MAGICF], $f3
	ble $f1, $f3, FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	mov $f1, $f2
	fadd $f1, $f3, $f1
	fsub $f1, $f3, $f1
	ble $f1, $f2, FLOOR_RET
	load [FLOOR_ONE], $f2
	fsub $f1, $f2, $f1
FLOOR_RET:
	ret
.end floor

######################################################################
# $f1 = float_of_int($i2)
# $ra = $ra
# [$i2 - $i4]
# [$f1 - $f3]
######################################################################
.begin float_of_int
ext_float_of_int:
	bge $i2, 0, ITOF_MAIN
	neg $i2, $i2
	mov $ra, $tmp
	call ITOF_MAIN
	fneg $f1, $f1
	jr $tmp
ITOF_MAIN:
	load [FLOAT_MAGICF], $f2
	load [FLOAT_MAGICFHX], $i3
	load [FLOAT_MAGICI], $i4
	bge $i2, $i4, ITOF_BIG
	add $i2, $i3, $i2
	mov $i2, $f1
	fsub $f1, $f2, $f1
	ret
ITOF_BIG:
	mov $f0, $f3
ITOF_LOOP:
	sub $i2, $i4, $i2
	fadd $f3, $f2, $f3
	bge $i2, $i4, ITOF_LOOP
	add $i2, $i3, $i2
	mov $i2, $f1
	fsub $f1, $f2, $f1
	fadd $f1, $f3, $f1
	ret
.end float_of_int

######################################################################
# $i1 = int_of_float($f2)
# $ra = $ra
# [$i1 - $i3]
# [$f2 - $f3]
######################################################################
.begin int_of_float
ext_int_of_float:
	bge $f2, $f0, FTOI_MAIN
	fneg $f2, $f2
	mov $ra, $tmp
	call FTOI_MAIN
	neg $i1, $i1
	jr $tmp
FTOI_MAIN:
	load [FLOAT_MAGICF], $f3
	load [FLOAT_MAGICFHX], $i2
	bge $f2, $f3, FTOI_BIG
	fadd $f2, $f3, $f2
	mov $f2, $i1
	sub $i1, $i2, $i1
	ret
FTOI_BIG:
	load [FLOAT_MAGICI], $i3
	li 0, $i1
FTOI_LOOP:
	fsub $f2, $f3, $f2
	add $i1, $i3, $i1
	bge $f2, $f3, FTOI_LOOP
	fadd $f2, $f3, $f2
	mov $f2, $i3
	sub $i3, $i2, $i3
	add $i3, $i1, $i1
	ret
.end int_of_float

######################################################################
# $i1 = read_int()
# $ra = $ra
# [$i1 - $i5]
# []
######################################################################
.begin read
ext_read_int:
	li 0, $i1
	li 0, $i3
	li 255, $i5
read_int_loop:
	read $i2
	bg $i2, $i5, read_int_loop
	li 0, $i4
sll_loop:
	add $i4, 1, $i4
	sll $i1, $i1
	bl $i4, 8, sll_loop
	add $i3, 1, $i3
	add $i1, $i2, $i1
	bl $i3, 4, read_int_loop
	ret

######################################################################
# $f1 = read_float()
# $ra = $ra
# [$i1 - $i5]
# [$f1]
######################################################################
ext_read_float:
	mov $ra, $tmp
	call ext_read_int
	mov $i1, $f1
	jr $tmp
.end read

######################################################################
# write($i2)
# $ra = $ra
# []
# []
######################################################################
.begin write
ext_write:
	write $i2, $tmp
	bg $tmp, 0, ext_write
	ret
.end write

######################################################################
# $i1 = create_array_int($i2, $i3)
# $ra = $ra
# [$i1 - $i2]
# []
######################################################################
.begin create_array
ext_create_array_int:
	mov $i2, $i1
	add $i2, $hp, $i2
	mov $hp, $i1
create_array_loop:
	store $i3, [$hp]
	add $hp, 1, $hp
	bl $hp, $i2, create_array_loop
	ret

######################################################################
# $i1 = create_array_float($i2, $f2)
# $ra = $ra
# [$i1 - $i3]
# []
######################################################################
ext_create_array_float:
	mov $f2, $i3
	jal ext_create_array_int $tmp
.end create_array

######################################################################
#
# 		↑　ここまで lib_asm.s
#
######################################################################
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
ext_n_objects:
	.skip	1
ext_objects:
	.skip	60
ext_screen:
	.skip	3
ext_viewpoint:
	.skip	3
ext_light:
	.skip	3
ext_beam:
	.skip	1
ext_and_net:
	.skip	50
ext_or_net:
	.skip	1
ext_solver_dist:
	.skip	1
ext_intsec_rectside:
	.skip	1
ext_tmin:
	.skip	1
ext_intersection_point:
	.skip	3
ext_intersected_object_id:
	.skip	1
ext_nvector:
	.skip	3
ext_texture_color:
	.skip	3
ext_diffuse_ray:
	.skip	3
ext_rgb:
	.skip	3
ext_image_size:
	.skip	2
ext_image_center:
	.skip	2
ext_scan_pitch:
	.skip	1
ext_startp:
	.skip	3
ext_startp_fast:
	.skip	3
ext_screenx_dir:
	.skip	3
ext_screeny_dir:
	.skip	3
ext_screenz_dir:
	.skip	3
ext_ptrace_dirvec:
	.skip	3
ext_dirvecs:
	.skip	5
ext_light_dirvec:
	.skip	3
	.int	light_dirvec_consts
light_dirvec_consts:
	.skip	60
ext_reflections:
	.skip	180
ext_n_reflections:
	.skip	1
.define $ig0 $i46
.define $i46 orz
.define $ig1 $i47
.define $i47 orz
.define $ig2 $i48
.define $i48 orz
.define $ig3 $i49
.define $i49 orz
.define $ig4 $i50
.define $i50 orz
.define $fg0 $f22
.define $f22 orz
.define $fg1 $f23
.define $f23 orz
.define $fg2 $f24
.define $f24 orz
.define $fg3 $f25
.define $f25 orz
.define $fg4 $f26
.define $f26 orz
.define $fg5 $f27
.define $f27 orz
.define $fg6 $f28
.define $f28 orz
.define $fg7 $f29
.define $f29 orz
.define $fg8 $f30
.define $f30 orz
.define $fg9 $f31
.define $f31 orz
.define $fg10 $f32
.define $f32 orz
.define $fg11 $f33
.define $f33 orz
.define $fg12 $f34
.define $f34 orz
.define $fg13 $f35
.define $f35 orz
.define $fg14 $f36
.define $f36 orz
.define $fg15 $f37
.define $f37 orz
.define $fg16 $f38
.define $f38 orz
.define $fg17 $f39
.define $f39 orz
.define $fg18 $f40
.define $f40 orz
.define $fg19 $f41
.define $f41 orz
.define $fg20 $f42
.define $f42 orz
.define $fg21 $f43
.define $f43 orz
.define $fc0 $f44
.define $f44 orz
.define $fc1 $f45
.define $f45 orz
.define $fc2 $f46
.define $f46 orz
.define $fc3 $f47
.define $f47 orz
.define $fc4 $f48
.define $f48 orz
.define $fc5 $f49
.define $f49 orz
.define $fc6 $f50
.define $f50 orz
.define $fc7 $f51
.define $f51 orz
.define $fc8 $f52
.define $f52 orz
.define $fc9 $f53
.define $f53 orz
.define $fc10 $f54
.define $f54 orz
.define $fc11 $f55
.define $f55 orz
.define $fc12 $f56
.define $f56 orz
.define $fc13 $f57
.define $f57 orz
.define $fc14 $f58
.define $f58 orz
.define $fc15 $f59
.define $f59 orz
.define $fc16 $f60
.define $f60 orz
.define $fc17 $f61
.define $f61 orz
.define $fc18 $f62
.define $f62 orz
.define $fc19 $f63
.define $f63 orz
.define $ra1 $i51
.define $i51 orz
.define $ra2 $i52
.define $i52 orz
.define $ra3 $i53
.define $i53 orz
.define $ra4 $i54
.define $i54 orz
.define $ra5 $i55
.define $i55 orz
.define $ra6 $i56
.define $i56 orz
.define $ra7 $i57
.define $i57 orz
.define $ra8 $i58
.define $i58 orz
.define $ra9 $i59
.define $i59 orz
f.22102:	.float  -6.4000000000E+01
f.22101:	.float  -2.0000000000E+02
f.22100:	.float  2.0000000000E+02
f.22080:	.float  -5.0000000000E-01
f.22079:	.float  7.0000000000E-01
f.22078:	.float  -3.0000000000E-01
f.22077:	.float  -1.0000000000E-01
f.22076:	.float  9.0000000000E-01
f.22075:	.float  2.0000000000E-01
f.22005:	.float  1.5000000000E+02
f.22004:	.float  -1.5000000000E+02
f.22003:	.float  6.6666666667E-03
f.22002:	.float  -6.6666666667E-03
f.22001:	.float  -2.0000000000E+00
f.22000:	.float  3.9062500000E-03
f.21999:	.float  2.5600000000E+02
f.21998:	.float  1.0000000000E+08
f.21997:	.float  1.0000000000E+09
f.21996:	.float  1.0000000000E+01
f.21995:	.float  2.0000000000E+01
f.21994:	.float  5.0000000000E-02
f.21993:	.float  2.5000000000E-01
f.21992:	.float  2.5500000000E+02
f.21991:	.float  1.0000000000E-01
f.21990:	.float  8.5000000000E+02
f.21989:	.float  1.5000000000E-01
f.21988:	.float  9.5492964444E+00
f.21987:	.float  3.1830988148E-01
f.21986:	.float  3.1415927000E+00
f.21985:	.float  3.0000000000E+01
f.21984:	.float  1.5000000000E+01
f.21983:	.float  1.0000000000E-04
f.21982:	.float  -1.0000000000E-01
f.21981:	.float  1.0000000000E-02
f.21980:	.float  -2.0000000000E-01
f.21979:	.float  5.0000000000E-01
f.21978:	.float  1.0000000000E+00
f.21977:	.float  -1.0000000000E+00
f.21976:	.float  2.0000000000E+00
f.21933:	.float  1.7453293000E-02

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i5, $i7 - $i15]
# [$f1 - $f21]
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_nth_object
read_nth_object.2719:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	be      $i7, -1, be.22113
bne.22113:
	call    ext_read_int
.count move_ret
	mov     $i1, $i8
	call    ext_read_int
.count move_ret
	mov     $i1, $i9
	call    ext_read_int
.count move_ret
	mov     $i1, $i10
.count move_args
	mov     $f0, $f2
	li      3, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	call    ext_read_float
	store   $f1, [$i11 + 0]
	call    ext_read_float
	store   $f1, [$i11 + 1]
	call    ext_read_float
	store   $f1, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	call    ext_read_float
	store   $f1, [$i12 + 0]
	call    ext_read_float
	store   $f1, [$i12 + 1]
	call    ext_read_float
	store   $f1, [$i12 + 2]
	call    ext_read_float
.count move_ret
	mov     $f1, $f3
	li      2, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	call    ext_read_float
	store   $f1, [$i13 + 0]
	call    ext_read_float
	store   $f1, [$i13 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	call    ext_read_float
	store   $f1, [$i14 + 0]
	call    ext_read_float
	store   $f1, [$i14 + 1]
	call    ext_read_float
	store   $f1, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i15
	be      $i10, 0, be.22114
bne.22114:
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	li      4, $i2
.count move_args
	mov     $f0, $f2
	store   $f1, [$i15 + 2]
	call    ext_create_array_float
	ble     $f0, $f3, ble.22115
.count dual_jmp
	b       bg.22115
be.22114:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	ble     $f0, $f3, ble.22115
bg.22115:
	li      1, $i2
	be      $i8, 2, be.22116
.count dual_jmp
	b       bne.22116
ble.22115:
	li      0, $i2
	be      $i8, 2, be.22116
bne.22116:
	mov     $hp, $i4
	mov     $i2, $i3
	store   $i7, [$i4 + 0]
	add     $hp, 23, $hp
	store   $i8, [$i4 + 1]
	store   $i9, [$i4 + 2]
	store   $i10, [$i4 + 3]
	load    [$i11 + 0], $i5
	store   $i5, [$i4 + 4]
	load    [$i11 + 1], $i5
	store   $i5, [$i4 + 5]
	load    [$i11 + 2], $i5
	add     $i4, 4, $i11
	store   $i5, [$i4 + 6]
	load    [$i12 + 0], $i5
	store   $i5, [$i4 + 7]
	load    [$i12 + 1], $i5
	store   $i5, [$i4 + 8]
	load    [$i12 + 2], $i5
	store   $i5, [$i4 + 9]
	store   $i3, [$i4 + 10]
	load    [$i13 + 0], $i3
	store   $i3, [$i4 + 11]
	load    [$i13 + 1], $i3
	store   $i3, [$i4 + 12]
	load    [$i14 + 0], $i3
	store   $i3, [$i4 + 13]
	load    [$i14 + 1], $i3
	store   $i3, [$i4 + 14]
	load    [$i14 + 2], $i3
	store   $i3, [$i4 + 15]
	load    [$i15 + 0], $i3
	store   $i3, [$i4 + 16]
	load    [$i15 + 1], $i3
	store   $i3, [$i4 + 17]
	load    [$i15 + 2], $i3
	add     $i4, 16, $i15
	store   $i3, [$i4 + 18]
	load    [$i1 + 0], $i3
	store   $i3, [$i4 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i4 + 20]
	load    [$i1 + 2], $i3
	add     $i4, 19, $i1
	store   $i3, [$i4 + 21]
	store   $i1, [$i4 + 22]
	store   $i4, [ext_objects + $i6]
	be      $i8, 3, be.22117
.count dual_jmp
	b       bne.22117
be.22116:
	mov     $hp, $i4
	store   $i7, [$i4 + 0]
	li      1, $i3
	store   $i8, [$i4 + 1]
	add     $hp, 23, $hp
	store   $i9, [$i4 + 2]
	store   $i10, [$i4 + 3]
	load    [$i11 + 0], $i5
	store   $i5, [$i4 + 4]
	load    [$i11 + 1], $i5
	store   $i5, [$i4 + 5]
	load    [$i11 + 2], $i5
	add     $i4, 4, $i11
	store   $i5, [$i4 + 6]
	load    [$i12 + 0], $i5
	store   $i5, [$i4 + 7]
	load    [$i12 + 1], $i5
	store   $i5, [$i4 + 8]
	load    [$i12 + 2], $i5
	store   $i5, [$i4 + 9]
	store   $i3, [$i4 + 10]
	load    [$i13 + 0], $i3
	store   $i3, [$i4 + 11]
	load    [$i13 + 1], $i3
	store   $i3, [$i4 + 12]
	load    [$i14 + 0], $i3
	store   $i3, [$i4 + 13]
	load    [$i14 + 1], $i3
	store   $i3, [$i4 + 14]
	load    [$i14 + 2], $i3
	store   $i3, [$i4 + 15]
	load    [$i15 + 0], $i3
	store   $i3, [$i4 + 16]
	load    [$i15 + 1], $i3
	store   $i3, [$i4 + 17]
	load    [$i15 + 2], $i3
	add     $i4, 16, $i15
	store   $i3, [$i4 + 18]
	load    [$i1 + 0], $i3
	store   $i3, [$i4 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i4 + 20]
	load    [$i1 + 2], $i3
	add     $i4, 19, $i1
	store   $i3, [$i4 + 21]
	store   $i1, [$i4 + 22]
	store   $i4, [ext_objects + $i6]
	bne     $i8, 3, bne.22117
be.22117:
	load    [$i11 + 0], $f1
	be      $f1, $f0, be.22119
bne.22118:
	bne     $f1, $f0, bne.22119
be.22119:
	mov     $f0, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22121
bne.22119:
	ble     $f1, $f0, ble.22120
bg.22120:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22121
ble.22120:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22122
bne.22121:
	bne     $f1, $f0, bne.22122
be.22122:
	mov     $f0, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22125
.count dual_jmp
	b       bne.22124
bne.22122:
	ble     $f1, $f0, ble.22123
bg.22123:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22125
.count dual_jmp
	b       bne.22124
ble.22123:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22125
bne.22124:
	bne     $f1, $f0, bne.22125
be.22125:
	mov     $f0, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
bne.22125:
	ble     $f1, $f0, ble.22126
bg.22126:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
ble.22126:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
bne.22117:
	be      $i8, 2, be.22128
bne.22128:
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
be.22128:
	load    [$i11 + 0], $f1
	load    [$i11 + 1], $f2
	fmul    $f1, $f1, $f3
	load    [$i11 + 2], $f4
	fmul    $f2, $f2, $f2
	fmul    $f4, $f4, $f4
	fadd    $f3, $f2, $f2
	fadd    $f2, $f4, $f2
	fsqrt   $f2, $f2
	be      $i2, 0, be.22129
bne.22129:
	be      $f2, $f0, be.22130
bne.22783:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
be.22129:
	be      $f2, $f0, be.22130
bne.22784:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
be.22130:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
bne.22133:
	load    [$i15 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
	load    [$i15 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	load    [$i15 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f10
	load    [$i15 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f11
	load    [$i15 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f12
	load    [$i15 + 2], $f2
	call    ext_sin
	fmul    $f9, $f11, $f2
	load    [$i11 + 0], $f4
	fmul    $f10, $f12, $f3
	load    [$i11 + 1], $f6
	fmul    $f10, $f1, $f5
	load    [$i11 + 2], $f16
	fneg    $f11, $f7
	li      1, $i1
	fmul    $f3, $f3, $f13
	fmul    $f7, $f7, $f14
	fmul    $f5, $f5, $f15
	fmul    $f2, $f12, $f17
	fmul    $f4, $f13, $f13
	fmul    $f16, $f14, $f14
	fmul    $f6, $f15, $f15
	fmul    $f8, $f1, $f18
	fmul    $f2, $f1, $f2
	fmul    $f8, $f12, $f19
	fmul    $f8, $f11, $f11
	fadd    $f13, $f15, $f13
	fsub    $f17, $f18, $f15
	fmul    $f9, $f10, $f17
	fadd    $f2, $f19, $f2
	fmul    $f11, $f12, $f18
	fadd    $f13, $f14, $f13
	store   $f13, [$i11 + 0]
	fmul    $f15, $f15, $f14
	fmul    $f17, $f17, $f19
	fmul    $f2, $f2, $f20
	fmul    $f9, $f1, $f21
	fmul    $f4, $f14, $f13
	fmul    $f16, $f19, $f14
	fmul    $f6, $f20, $f19
	fadd    $f18, $f21, $f18
	fmul    $f11, $f1, $f1
	fmul    $f9, $f12, $f9
	fmul    $f8, $f10, $f8
	fadd    $f13, $f19, $f10
	fmul    $f18, $f18, $f11
	fmul    $f4, $f15, $f12
	fsub    $f1, $f9, $f1
	fmul    $f8, $f8, $f9
	fadd    $f10, $f14, $f10
	store   $f10, [$i11 + 1]
	fmul    $f4, $f11, $f11
	fmul    $f12, $f18, $f12
	fmul    $f1, $f1, $f13
	fmul    $f16, $f9, $f9
	fmul    $f6, $f2, $f10
	fmul    $f16, $f17, $f14
	fmul    $f6, $f13, $f13
	fmul    $f4, $f3, $f3
	fmul    $f6, $f5, $f4
	fmul    $f10, $f1, $f5
	fmul    $f14, $f8, $f6
	fadd    $f11, $f13, $f10
	fmul    $f3, $f18, $f11
	fmul    $f4, $f1, $f1
	fadd    $f12, $f5, $f5
	fmul    $f16, $f7, $f7
	fadd    $f10, $f9, $f9
	store   $f9, [$i11 + 2]
	fmul    $f3, $f15, $f3
	fmul    $f4, $f2, $f2
	fadd    $f5, $f6, $f4
	fadd    $f11, $f1, $f1
	fmul    $f7, $f8, $f5
	fadd    $f3, $f2, $f2
	fmul    $f7, $f17, $f3
	fmul    $fc7, $f4, $f4
	fadd    $f1, $f5, $f1
	store   $f4, [$i15 + 0]
	fadd    $f2, $f3, $f2
	fmul    $fc7, $f1, $f1
	fmul    $fc7, $f2, $f2
	store   $f1, [$i15 + 1]
	store   $f2, [$i15 + 2]
	jr      $ra1
be.22133:
	li      1, $i1
	jr      $ra1
be.22113:
	li      0, $i1
	jr      $ra1
.end read_nth_object

######################################################################
# read_object($i6)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f21]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin read_object
read_object.2721:
	bge     $i6, 60, bge.22134
bl.22134:
	jal     read_nth_object.2719, $ra1
	be      $i1, 0, be.22135
bne.22135:
	add     $i6, 1, $i6
	b       read_object.2721
be.22135:
	mov     $i6, $ig0
	jr      $ra2
bge.22134:
	jr      $ra2
.end read_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
	store   $ra, [$sp - 3]
.count stack_move
	add     $sp, -3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	be      $i1, -1, be.22137
bne.22137:
.count stack_store
	store   $i1, [$sp + 2]
.count stack_load
	load    [$sp + 1], $i1
	add     $i1, 1, $i1
	call    read_net_item.2725
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i2
.count stack_load
	load    [$sp - 1], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret     
be.22137:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	add     $i0, -1, $i3
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	b       ext_create_array_int
.end read_net_item

######################################################################
# $i1 = read_or_network($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_or_network
read_or_network.2727:
.count stack_store_ra
	store   $ra, [$sp - 3]
.count stack_move
	add     $sp, -3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	be      $i2, -1, be.22141
bne.22141:
.count stack_store
	store   $i1, [$sp + 2]
.count stack_load
	load    [$sp + 1], $i1
	add     $i1, 1, $i1
	call    read_or_network.2727
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i2
.count stack_load
	load    [$sp - 1], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret     
be.22141:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count move_args
	mov     $i1, $i3
.count stack_load
	load    [$sp - 2], $i2
	add     $i2, 1, $i2
	b       ext_create_array_int
.end read_or_network

######################################################################
# read_and_network($i6)
# $ra = $ra1
# [$i1 - $i6]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_and_network
read_and_network.2729:
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	be      $i2, -1, be.22144
bne.22144:
	add     $i6, 1, $i2
	store   $i1, [ext_and_net + $i6]
.count move_args
	mov     $i2, $i6
	b       read_and_network.2729
be.22144:
	jr      $ra1
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1, $i3 - $i4]
# [$f1 - $f16]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver
solver.2773:
	load    [ext_objects + $i1], $i1
	load    [$i2 + 0], $f4
	load    [$i1 + 1], $i3
	load    [$i1 + 9], $f1
	load    [$i1 + 8], $f2
	fsub    $fg19, $f1, $f1
	load    [$i1 + 7], $f3
	fsub    $fg18, $f2, $f2
	fsub    $fg17, $f3, $f3
	bne     $i3, 1, bne.22145
be.22145:
	be      $f4, $f0, ble.22152
bne.22146:
	load    [$i1 + 5], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 10], $i3
	load    [$i1 + 4], $f7
	ble     $f0, $f4, ble.22147
bg.22147:
	be      $i3, 0, be.22148
.count dual_jmp
	b       bne.22785
ble.22147:
	be      $i3, 0, bne.22785
be.22148:
	fsub    $f7, $f3, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
.count dual_jmp
	b       bg.22151
bne.22785:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
bg.22151:
	load    [$i2 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f6, $f5, bg.22152
ble.22152:
	load    [$i2 + 1], $f4
	be      $f4, $f0, ble.22160
bne.22154:
	load    [$i1 + 6], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 10], $i3
	load    [$i1 + 5], $f7
	ble     $f0, $f4, ble.22155
bg.22155:
	be      $i3, 0, be.22156
.count dual_jmp
	b       bne.22788
ble.22155:
	be      $i3, 0, bne.22788
be.22156:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, ble.22160
.count dual_jmp
	b       bg.22159
bne.22788:
	fneg    $f7, $f7
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, ble.22160
bg.22159:
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f3, $f5
	bg      $f6, $f5, bg.22160
ble.22160:
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.22176
bne.22162:
	load    [$i1 + 10], $i3
	load    [$i1 + 4], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 6], $f7
	ble     $f0, $f4, ble.22163
bg.22163:
	finv    $f4, $f4
	be      $i3, 0, be.22164
.count dual_jmp
	b       bne.22791
ble.22163:
	finv    $f4, $f4
	be      $i3, 0, bne.22791
be.22164:
	fsub    $f7, $f1, $f1
	fmul    $f1, $f4, $f1
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f5, $f3, ble.22176
.count dual_jmp
	b       bg.22167
bne.22791:
	fneg    $f7, $f7
	fsub    $f7, $f1, $f1
	fmul    $f1, $f4, $f1
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f5, $f3, ble.22176
bg.22167:
	load    [$i2 + 1], $f3
	load    [$i1 + 5], $f4
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	ble     $f4, $f2, ble.22176
bg.22168:
	mov     $f1, $fg0
	li      3, $i1
	ret     
bg.22160:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bg.22152:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22145:
	bne     $i3, 2, bne.22169
be.22169:
	load    [$i1 + 4], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 1], $f6
	load    [$i1 + 5], $f7
	load    [$i2 + 2], $f8
	fmul    $f6, $f7, $f6
	load    [$i1 + 6], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f6, $f4
	fadd    $f4, $f8, $f4
	ble     $f4, $f0, ble.22176
bg.22170:
	fmul    $f5, $f3, $f3
	fmul    $f7, $f2, $f2
	li      1, $i1
	fmul    $f9, $f1, $f1
	finv    $f4, $f4
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f4, $fg0
	ret     
bne.22169:
	load    [$i2 + 1], $f5
	fmul    $f4, $f4, $f7
	load    [$i1 + 3], $i4
	fmul    $f5, $f5, $f8
	load    [$i2 + 2], $f6
	fmul    $f6, $f6, $f11
	load    [$i1 + 4], $f9
	fmul    $f7, $f9, $f7
	load    [$i1 + 5], $f10
	fmul    $f8, $f10, $f8
	load    [$i1 + 6], $f12
	fmul    $f11, $f12, $f11
	fadd    $f7, $f8, $f7
	fadd    $f7, $f11, $f7
	be      $i4, 0, be.22171
bne.22171:
	fmul    $f5, $f6, $f8
	load    [$i1 + 16], $f11
	fmul    $f6, $f4, $f13
	load    [$i1 + 17], $f14
	fmul    $f4, $f5, $f15
	fmul    $f8, $f11, $f8
	load    [$i1 + 18], $f11
	fmul    $f13, $f14, $f13
	fmul    $f15, $f11, $f11
	fadd    $f7, $f8, $f7
	fadd    $f7, $f13, $f7
	fadd    $f7, $f11, $f7
	be      $f7, $f0, ble.22176
.count dual_jmp
	b       bne.22172
be.22171:
	be      $f7, $f0, ble.22176
bne.22172:
	fmul    $f4, $f3, $f8
	fmul    $f5, $f2, $f11
	fmul    $f6, $f1, $f13
	fmul    $f8, $f9, $f8
	fmul    $f11, $f10, $f11
	fmul    $f13, $f12, $f13
	fadd    $f8, $f11, $f8
	fadd    $f8, $f13, $f8
	be      $i4, 0, be.22173
bne.22173:
	fmul    $f6, $f2, $f11
	fmul    $f5, $f1, $f13
	load    [$i1 + 16], $f14
	fmul    $f4, $f1, $f15
	load    [$i1 + 17], $f16
	fmul    $f6, $f3, $f6
	fadd    $f11, $f13, $f11
	fmul    $f4, $f2, $f4
	load    [$i1 + 18], $f13
	fmul    $f5, $f3, $f5
	fadd    $f15, $f6, $f6
	fmul    $f11, $f14, $f11
	fadd    $f4, $f5, $f4
	fmul    $f6, $f16, $f5
	fmul    $f3, $f3, $f6
	fmul    $f4, $f13, $f4
	fadd    $f11, $f5, $f5
	fmul    $f1, $f1, $f11
	fmul    $f6, $f9, $f6
	fadd    $f5, $f4, $f4
	fmul    $f11, $f12, $f9
	fmul    $f4, $fc3, $f4
	fadd    $f8, $f4, $f4
	fmul    $f2, $f2, $f8
	fmul    $f4, $f4, $f5
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fadd    $f6, $f9, $f6
	be      $i4, 0, be.22174
.count dual_jmp
	b       bne.22174
be.22173:
	mov     $f8, $f4
	fmul    $f4, $f4, $f5
	fmul    $f3, $f3, $f6
	fmul    $f2, $f2, $f8
	fmul    $f1, $f1, $f11
	fmul    $f6, $f9, $f6
	fmul    $f8, $f10, $f8
	fmul    $f11, $f12, $f9
	fadd    $f6, $f8, $f6
	fadd    $f6, $f9, $f6
	be      $i4, 0, be.22174
bne.22174:
	fmul    $f2, $f1, $f8
	load    [$i1 + 16], $f9
	fmul    $f1, $f3, $f1
	load    [$i1 + 17], $f10
	fmul    $f3, $f2, $f2
	fmul    $f8, $f9, $f3
	load    [$i1 + 18], $f8
	fmul    $f1, $f10, $f1
	fmul    $f2, $f8, $f2
	fadd    $f6, $f3, $f3
	fadd    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	be      $i3, 3, be.22175
.count dual_jmp
	b       bne.22175
be.22174:
	mov     $f6, $f1
	be      $i3, 3, be.22175
bne.22175:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22176
.count dual_jmp
	b       bg.22176
be.22175:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22176
bg.22176:
	load    [$i1 + 10], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	be      $i1, 0, be.22177
bne.22177:
	fsub    $f1, $f4, $f1
	li      1, $i1
	fmul    $f1, $f2, $fg0
	ret     
be.22177:
	fneg    $f1, $f1
	li      1, $i1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ret     
ble.22176:
	li      0, $i1
	ret     
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f11]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver_fast
solver_fast.2796:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i3
	load    [ext_intersection_point + 2], $f1
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f3
	load    [$i2 + 8], $f4
	load    [ext_intersection_point + 0], $f5
	fsub    $f3, $f4, $f3
	load    [$i2 + 7], $f6
	fsub    $f5, $f6, $f2
	load    [$i3 + $i1], $i1
	load    [$i1 + 0], $f4
	bne     $i4, 1, bne.22178
be.22178:
	fsub    $f4, $f2, $f4
	load    [$i2 + 5], $f5
	load    [$i1 + 1], $f7
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, be.22181
bg.22179:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22181
bg.22180:
	load    [$i1 + 1], $f6
	bne     $f6, $f0, bne.22181
be.22181:
	load    [$i1 + 2], $f4
	fsub    $f4, $f3, $f4
	load    [$i2 + 4], $f6
	load    [%{ext_light_dirvec + 0} + 0], $f7
	load    [$i1 + 3], $f8
	fmul    $f4, $f8, $f4
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f2, $f7
	ble     $f6, $f7, be.22185
bg.22183:
	load    [%{ext_light_dirvec + 0} + 2], $f7
	load    [$i2 + 6], $f8
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f8, $f7, be.22185
bg.22184:
	load    [$i1 + 3], $f7
	bne     $f7, $f0, bne.22185
be.22185:
	load    [$i1 + 4], $f4
	fsub    $f4, $f1, $f1
	load    [%{ext_light_dirvec + 0} + 0], $f7
	load    [$i1 + 5], $f8
	fmul    $f1, $f8, $f1
	fmul    $f1, $f7, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f6, $f2, ble.22195
bg.22187:
	load    [%{ext_light_dirvec + 0} + 1], $f2
	fmul    $f1, $f2, $f2
	fadd_a  $f2, $f3, $f2
	ble     $f5, $f2, ble.22195
bg.22188:
	load    [$i1 + 5], $f2
	be      $f2, $f0, ble.22195
bne.22189:
	mov     $f1, $fg0
	li      3, $i1
	ret     
bne.22185:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bne.22181:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22178:
	be      $i4, 2, be.22190
bne.22190:
	be      $f4, $f0, ble.22195
bne.22192:
	load    [$i2 + 3], $i3
	load    [$i1 + 1], $f5
	fmul    $f5, $f2, $f5
	load    [$i1 + 2], $f6
	fmul    $f6, $f3, $f6
	load    [$i1 + 3], $f7
	fmul    $f7, $f1, $f7
	fmul    $f2, $f2, $f8
	load    [$i2 + 4], $f10
	fmul    $f3, $f3, $f9
	load    [$i2 + 5], $f11
	fadd    $f5, $f6, $f5
	fmul    $f8, $f10, $f6
	fmul    $f9, $f11, $f8
	load    [$i2 + 6], $f10
	fmul    $f1, $f1, $f9
	fadd    $f5, $f7, $f5
	fadd    $f6, $f8, $f6
	fmul    $f9, $f10, $f7
	fmul    $f5, $f5, $f8
	fadd    $f6, $f7, $f6
	be      $i3, 0, be.22193
bne.22193:
	fmul    $f3, $f1, $f7
	load    [$i2 + 16], $f9
	fmul    $f1, $f2, $f1
	load    [$i2 + 17], $f10
	fmul    $f2, $f3, $f2
	fmul    $f7, $f9, $f3
	load    [$i2 + 18], $f7
	fmul    $f1, $f10, $f1
	fmul    $f2, $f7, $f2
	fadd    $f6, $f3, $f3
	fadd    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	be      $i4, 3, be.22194
.count dual_jmp
	b       bne.22194
be.22193:
	mov     $f6, $f1
	be      $i4, 3, be.22194
bne.22194:
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, ble.22195
.count dual_jmp
	b       bg.22195
be.22194:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, ble.22195
bg.22195:
	load    [$i2 + 10], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	be      $i2, 0, be.22196
bne.22196:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
be.22196:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
be.22190:
	ble     $f0, $f4, ble.22195
bg.22191:
	load    [$i1 + 1], $f4
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 3], $f6
	fmul    $f5, $f3, $f3
	fmul    $f6, $f1, $f1
	li      1, $i1
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $fg0
	ret     
ble.22195:
	li      0, $i1
	ret     
.end solver_fast

######################################################################
# $i1 = solver_fast2($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f8]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver_fast2
solver_fast2.2814:
	load    [ext_objects + $i1], $i3
	load    [$i2 + 3], $i4
	load    [$i3 + 1], $i5
	load    [$i3 + 19], $f1
	load    [$i3 + 20], $f2
	load    [$i3 + 21], $f3
	load    [$i4 + $i1], $i1
	bne     $i5, 1, bne.22197
be.22197:
	load    [$i1 + 0], $f4
	fsub    $f4, $f1, $f4
	load    [$i3 + 5], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, be.22200
bg.22198:
	load    [$i2 + 2], $f6
	load    [$i3 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22200
bg.22199:
	load    [$i1 + 1], $f6
	bne     $f6, $f0, bne.22200
be.22200:
	load    [$i1 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i3 + 4], $f6
	load    [$i2 + 0], $f7
	load    [$i1 + 3], $f8
	fmul    $f4, $f8, $f4
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f6, $f7, be.22204
bg.22202:
	load    [$i2 + 2], $f7
	load    [$i3 + 6], $f8
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f8, $f7, be.22204
bg.22203:
	load    [$i1 + 3], $f7
	bne     $f7, $f0, bne.22204
be.22204:
	load    [$i1 + 4], $f4
	fsub    $f4, $f3, $f3
	load    [$i2 + 0], $f7
	load    [$i1 + 5], $f8
	fmul    $f3, $f8, $f3
	fmul    $f3, $f7, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f6, $f1, ble.22212
bg.22206:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f5, $f1, ble.22212
bg.22207:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.22212
bne.22208:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.22204:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bne.22200:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22197:
	be      $i5, 2, be.22209
bne.22209:
	load    [$i1 + 0], $f4
	be      $f4, $f0, ble.22212
bne.22211:
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f1
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f2
	load    [$i1 + 3], $f7
	fmul    $f7, $f3, $f3
	load    [$i3 + 22], $f5
	fadd    $f1, $f2, $f1
	fmul    $f4, $f5, $f2
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f3
	fsub    $f3, $f2, $f2
	ble     $f2, $f0, ble.22212
bg.22212:
	load    [$i3 + 10], $i2
	load    [$i1 + 4], $f3
	li      1, $i1
	fsqrt   $f2, $f2
	be      $i2, 0, be.22213
bne.22213:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22213:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22209:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, ble.22212
bg.22210:
	load    [$i3 + 22], $f2
	li      1, $i1
	fmul    $f1, $f2, $fg0
	ret     
ble.22212:
	li      0, $i1
	ret     
.end solver_fast2

######################################################################
# $i1 = setup_rect_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f2]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_rect_table
setup_rect_table.2817:
	li      6, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i4 + 0], $f1
	bne     $f1, $f0, bne.22214
be.22214:
	store   $f0, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22219
.count dual_jmp
	b       bne.22219
bne.22214:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22215
bg.22215:
	load    [$i5 + 4], $f1
	be      $i2, 0, be.22216
.count dual_jmp
	b       bne.22794
ble.22215:
	load    [$i5 + 4], $f1
	be      $i2, 0, bne.22794
be.22216:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22219
.count dual_jmp
	b       bne.22219
bne.22794:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	bne     $f1, $f0, bne.22219
be.22219:
	store   $f0, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
.count dual_jmp
	b       bne.22224
bne.22219:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22220
bg.22220:
	load    [$i5 + 5], $f1
	be      $i2, 0, be.22221
.count dual_jmp
	b       bne.22797
ble.22220:
	load    [$i5 + 5], $f1
	be      $i2, 0, bne.22797
be.22221:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
.count dual_jmp
	b       bne.22224
bne.22797:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
bne.22224:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22225
bg.22225:
	load    [$i5 + 6], $f1
	be      $i2, 0, be.22226
.count dual_jmp
	b       bne.22800
ble.22225:
	load    [$i5 + 6], $f1
	be      $i2, 0, bne.22800
be.22226:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
bne.22800:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be.22224:
	store   $f0, [$i1 + 5]
	jr      $ra1
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f4]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_surface_table
setup_surface_table.2820:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i4 + 0], $f1
	load    [$i5 + 4], $f2
	fmul    $f1, $f2, $f1
	load    [$i4 + 1], $f3
	load    [$i5 + 5], $f4
	load    [$i4 + 2], $f2
	fmul    $f3, $f4, $f3
	load    [$i5 + 6], $f4
	fmul    $f2, $f4, $f2
	fadd    $f1, $f3, $f1
	fadd    $f1, $f2, $f1
	ble     $f1, $f0, ble.22229
bg.22229:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i5 + 4], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i5 + 5], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i5 + 6], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	jr      $ra1
ble.22229:
	store   $f0, [$i1 + 0]
	jr      $ra1
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_second_table
setup_second_table.2823:
	li      5, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i5 + 3], $i2
	load    [$i4 + 0], $f1
	fmul    $f1, $f1, $f4
	load    [$i4 + 1], $f2
	fmul    $f2, $f2, $f5
	load    [$i4 + 2], $f3
	fmul    $f3, $f3, $f8
	load    [$i5 + 4], $f6
	fmul    $f4, $f6, $f4
	load    [$i5 + 5], $f7
	fmul    $f5, $f7, $f5
	load    [$i5 + 6], $f6
	fmul    $f8, $f6, $f6
	fadd    $f4, $f5, $f4
	fadd    $f4, $f6, $f4
	be      $i2, 0, be.22230
bne.22230:
	fmul    $f2, $f3, $f5
	load    [$i5 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i5 + 17], $f7
	fmul    $f1, $f2, $f1
	fmul    $f5, $f6, $f2
	load    [$i5 + 18], $f5
	fmul    $f3, $f7, $f3
	fmul    $f1, $f5, $f1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 2], $f2
	load    [$i5 + 6], $f3
	load    [$i4 + 1], $f4
	fmul    $f2, $f3, $f3
	load    [$i5 + 5], $f5
	fmul    $f4, $f5, $f5
	load    [$i4 + 0], $f6
	fneg    $f3, $f3
	load    [$i5 + 4], $f7
	fmul_n  $f6, $f7, $f6
	fneg    $f5, $f5
	be      $i2, 0, be.22231
.count dual_jmp
	b       bne.22231
be.22230:
	mov     $f4, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 2], $f2
	load    [$i5 + 6], $f3
	fmul    $f2, $f3, $f3
	load    [$i4 + 1], $f4
	fneg    $f3, $f3
	load    [$i5 + 5], $f5
	fmul    $f4, $f5, $f5
	load    [$i4 + 0], $f6
	fneg    $f5, $f5
	load    [$i5 + 4], $f7
	fmul_n  $f6, $f7, $f6
	be      $i2, 0, be.22231
bne.22231:
	load    [$i5 + 17], $f7
	load    [$i5 + 18], $f8
	fmul    $f2, $f7, $f2
	fmul    $f4, $f8, $f4
	fadd    $f2, $f4, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 1]
	load    [$i4 + 2], $f2
	load    [$i5 + 16], $f4
	fmul    $f2, $f4, $f2
	load    [$i4 + 0], $f6
	fmul    $f6, $f8, $f6
	fadd    $f2, $f6, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f5, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i4 + 1], $f2
	fmul    $f2, $f4, $f2
	load    [$i4 + 0], $f5
	fmul    $f5, $f7, $f4
	fadd    $f2, $f4, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f3, $f2, $f2
	store   $f2, [$i1 + 3]
	be      $f1, $f0, be.22233
.count dual_jmp
	b       bne.22233
be.22231:
	store   $f6, [$i1 + 1]
	store   $f5, [$i1 + 2]
	store   $f3, [$i1 + 3]
	be      $f1, $f0, be.22233
bne.22233:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
be.22233:
	jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i4, $i6)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i6, 0, bl.22234
bge.22234:
	load    [ext_objects + $i6], $i5
	load    [$i4 + 3], $i7
	load    [$i5 + 1], $i1
	be      $i1, 1, be.22235
bne.22235:
	be      $i1, 2, be.22236
bne.22236:
	jal     setup_second_table.2823, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
be.22236:
	jal     setup_surface_table.2820, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
be.22235:
	jal     setup_rect_table.2817, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
bl.22234:
	jr      $ra2
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i4)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
	add     $ig0, -1, $i6
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1, $i3 - $i5]
# [$f1 - $f8]
# []
# []
# []
######################################################################
.align 2
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bl.22237
bge.22237:
	load    [ext_objects + $i1], $i3
	load    [$i2 + 0], $f1
	load    [$i3 + 7], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 19]
	load    [$i2 + 1], $f1
	load    [$i3 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 20]
	load    [$i2 + 2], $f1
	load    [$i3 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 21]
	load    [$i3 + 1], $i4
	be      $i4, 2, be.22238
bne.22238:
	ble     $i4, 2, ble.22239
bg.22239:
	load    [$i3 + 3], $i5
	load    [$i3 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i3 + 20], $f2
	fmul    $f2, $f2, $f5
	load    [$i3 + 21], $f3
	fmul    $f3, $f3, $f8
	load    [$i3 + 4], $f6
	fmul    $f4, $f6, $f4
	load    [$i3 + 5], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 6], $f6
	fmul    $f8, $f6, $f6
	fadd    $f4, $f5, $f4
	fadd    $f4, $f6, $f4
	be      $i5, 0, be.22240
bne.22240:
	fmul    $f2, $f3, $f5
	load    [$i3 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i3 + 17], $f7
	fmul    $f1, $f2, $f1
	fmul    $f5, $f6, $f2
	load    [$i3 + 18], $f5
	fmul    $f3, $f7, $f3
	fmul    $f1, $f5, $f1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	be      $i4, 3, be.22241
.count dual_jmp
	b       bne.22241
be.22240:
	mov     $f4, $f1
	be      $i4, 3, be.22241
bne.22241:
	add     $i1, -1, $i1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
be.22241:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
ble.22239:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
be.22238:
	load    [$i3 + 4], $f1
	add     $i1, -1, $i1
	load    [$i3 + 19], $f2
	fmul    $f1, $f2, $f1
	load    [$i3 + 5], $f3
	load    [$i3 + 20], $f4
	load    [$i3 + 6], $f2
	fmul    $f3, $f4, $f3
	load    [$i3 + 21], $f4
	fmul    $f2, $f4, $f2
	fadd    $f1, $f3, $f1
	fadd    $f1, $f2, $f1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
bl.22237:
	ret     
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i6]
# [$f1, $f5 - $f11]
# []
# []
# []
######################################################################
.align 2
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
bne.22242:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 9], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22243
be.22243:
	load    [$i2 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22246
bg.22244:
	load    [$i2 + 5], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, bg.22246
ble.22246:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22258
bg.22246:
	load    [$i2 + 6], $f1
	fabs    $f6, $f5
	load    [$i2 + 10], $i2
	ble     $f1, $f5, ble.22248
bg.22248:
	be      $i2, 0, be.22258
.count dual_jmp
	b       bne.22258
ble.22248:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22258
bne.22243:
	be      $i4, 2, be.22250
bne.22250:
	load    [$i2 + 10], $i5
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $f9
	fmul    $f5, $f5, $f8
	load    [$i2 + 5], $f10
	fmul    $f6, $f6, $f11
	load    [$i2 + 3], $i6
	fmul    $f7, $f9, $f7
	load    [$i2 + 6], $f9
	fmul    $f8, $f10, $f8
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i6, 0, be.22254
bne.22254:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f1, $f5, $f1
	fmul    $f8, $f9, $f5
	load    [$i2 + 18], $f8
	fmul    $f6, $f10, $f6
	fmul    $f1, $f8, $f1
	fadd    $f7, $f5, $f5
	fadd    $f5, $f6, $f5
	fadd    $f5, $f1, $f1
	be      $i4, 3, be.22255
.count dual_jmp
	b       bne.22255
be.22254:
	mov     $f7, $f1
	be      $i4, 3, be.22255
bne.22255:
	ble     $f0, $f1, ble.22256
.count dual_jmp
	b       bg.22256
be.22255:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22256
bg.22256:
	be      $i5, 0, be.22258
.count dual_jmp
	b       bne.22258
ble.22256:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22258
be.22250:
	load    [$i2 + 10], $i4
	load    [$i2 + 4], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f6, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.22251
bg.22251:
	be      $i4, 0, be.22258
.count dual_jmp
	b       bne.22258
ble.22251:
	be      $i4, 0, bne.22258
be.22258:
	add     $i1, 1, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22296
bne.22260:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 7], $f1
	load    [$i2 + 8], $f5
	fsub    $f2, $f1, $f1
	load    [$i2 + 9], $f6
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22261
be.22261:
	load    [$i2 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22264
bg.22262:
	load    [$i2 + 5], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, bg.22264
ble.22264:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22276
bg.22264:
	load    [$i2 + 6], $f1
	fabs    $f6, $f5
	load    [$i2 + 10], $i2
	ble     $f1, $f5, ble.22266
bg.22266:
	be      $i2, 0, be.22276
.count dual_jmp
	b       bne.22258
ble.22266:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22276
bne.22261:
	be      $i4, 2, be.22268
bne.22268:
	load    [$i2 + 10], $i5
	fmul    $f1, $f1, $f7
	load    [$i2 + 3], $i6
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $f9
	fmul    $f6, $f6, $f11
	load    [$i2 + 5], $f10
	fmul    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	load    [$i2 + 6], $f9
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i6, 0, be.22272
bne.22272:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f1, $f5, $f1
	fmul    $f8, $f9, $f5
	load    [$i2 + 18], $f8
	fmul    $f6, $f10, $f6
	fmul    $f1, $f8, $f1
	fadd    $f7, $f5, $f5
	fadd    $f5, $f6, $f5
	fadd    $f5, $f1, $f1
	be      $i4, 3, be.22273
.count dual_jmp
	b       bne.22273
be.22272:
	mov     $f7, $f1
	be      $i4, 3, be.22273
bne.22273:
	ble     $f0, $f1, ble.22274
.count dual_jmp
	b       bg.22274
be.22273:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22274
bg.22274:
	be      $i5, 0, be.22276
.count dual_jmp
	b       bne.22258
ble.22274:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22276
be.22268:
	load    [$i2 + 10], $i4
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f7, $f1, $f1
	load    [$i2 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f6, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.22269
bg.22269:
	be      $i4, 0, be.22276
.count dual_jmp
	b       bne.22258
ble.22269:
	be      $i4, 0, bne.22258
be.22276:
	add     $i1, 2, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22296
bne.22278:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 9], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22279
be.22279:
	load    [$i2 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22282
bg.22280:
	load    [$i2 + 5], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, bg.22282
ble.22282:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22294
bg.22282:
	load    [$i2 + 6], $f1
	fabs    $f6, $f5
	load    [$i2 + 10], $i2
	ble     $f1, $f5, ble.22284
bg.22284:
	be      $i2, 0, be.22294
.count dual_jmp
	b       bne.22258
ble.22284:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22294
bne.22279:
	be      $i4, 2, be.22286
bne.22286:
	load    [$i2 + 10], $i5
	load    [$i2 + 3], $i6
	fmul    $f1, $f1, $f7
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $f9
	load    [$i2 + 5], $f10
	fmul    $f6, $f6, $f11
	fmul    $f7, $f9, $f7
	load    [$i2 + 6], $f9
	fmul    $f8, $f10, $f8
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i6, 0, be.22290
bne.22290:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f1, $f5, $f1
	fmul    $f8, $f9, $f5
	load    [$i2 + 18], $f8
	fmul    $f6, $f10, $f6
	fmul    $f1, $f8, $f1
	fadd    $f7, $f5, $f5
	fadd    $f5, $f6, $f5
	fadd    $f5, $f1, $f1
	be      $i4, 3, be.22291
.count dual_jmp
	b       bne.22291
be.22290:
	mov     $f7, $f1
	be      $i4, 3, be.22291
bne.22291:
	ble     $f0, $f1, ble.22292
.count dual_jmp
	b       bg.22292
be.22291:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22292
bg.22292:
	be      $i5, 0, be.22294
.count dual_jmp
	b       bne.22258
ble.22292:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22294
be.22286:
	load    [$i2 + 10], $i4
	load    [$i2 + 4], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f6, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.22287
bg.22287:
	be      $i4, 0, be.22294
.count dual_jmp
	b       bne.22258
ble.22287:
	be      $i4, 0, bne.22258
be.22294:
	add     $i1, 3, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22296
bne.22296:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f1
	load    [$i2 + 8], $f5
	fsub    $f4, $f1, $f1
	load    [$i2 + 7], $f6
	fsub    $f3, $f5, $f5
	fsub    $f2, $f6, $f6
	bne     $i4, 1, bne.22297
be.22297:
	load    [$i2 + 4], $f7
	fabs    $f6, $f6
	ble     $f7, $f6, ble.22299
bg.22298:
	load    [$i2 + 5], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, bg.22299
ble.22299:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22312
bg.22299:
	load    [$i2 + 6], $f5
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f5, $f1, ble.22300
bg.22300:
	be      $i2, 0, be.22312
.count dual_jmp
	b       bne.22258
ble.22300:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22312
bne.22297:
	be      $i4, 2, be.22304
bne.22304:
	load    [$i2 + 10], $i5
	fmul    $f6, $f6, $f7
	load    [$i2 + 3], $i6
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $f9
	fmul    $f1, $f1, $f11
	load    [$i2 + 5], $f10
	fmul    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	load    [$i2 + 6], $f9
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i6, 0, be.22308
bne.22308:
	fmul    $f5, $f1, $f8
	load    [$i2 + 16], $f9
	fmul    $f1, $f6, $f1
	load    [$i2 + 17], $f10
	fmul    $f6, $f5, $f5
	fmul    $f8, $f9, $f6
	load    [$i2 + 18], $f8
	fmul    $f1, $f10, $f1
	fmul    $f5, $f8, $f5
	fadd    $f7, $f6, $f6
	fadd    $f6, $f1, $f1
	fadd    $f1, $f5, $f1
	be      $i4, 3, be.22309
.count dual_jmp
	b       bne.22309
be.22308:
	mov     $f7, $f1
	be      $i4, 3, be.22309
bne.22309:
	ble     $f0, $f1, ble.22310
.count dual_jmp
	b       bg.22310
be.22309:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22310
bg.22310:
	be      $i5, 0, be.22312
.count dual_jmp
	b       bne.22258
ble.22310:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22312
be.22304:
	load    [$i2 + 10], $i4
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f7, $f6, $f6
	load    [$i2 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f1, $f1
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	ble     $f0, $f1, ble.22305
bg.22305:
	be      $i4, 0, be.22312
.count dual_jmp
	b       bne.22258
ble.22305:
	be      $i4, 0, bne.22258
be.22312:
	add     $i1, 4, $i1
	b       check_all_inside.2856
bne.22258:
	li      0, $i1
	ret     
be.22296:
	li      1, $i1
	ret     
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i7, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra]
######################################################################
.align 2
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i7], $i1
	be      $i1, -1, be.22336
bne.22313:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i4
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 1], $i5
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f3
	load    [$i2 + 8], $f4
	load    [ext_intersection_point + 2], $f2
	fsub    $f3, $f4, $f3
	load    [$i2 + 9], $f5
	fsub    $f2, $f5, $f2
	load    [$i4 + $i1], $i4
	load    [$i4 + 0], $f4
	bne     $i5, 1, bne.22314
be.22314:
	fsub    $f4, $f1, $f4
	load    [$i2 + 5], $f5
	load    [$i4 + 1], $f7
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, be.22317
bg.22315:
	load    [%{ext_light_dirvec + 0} + 2], $f5
	load    [$i2 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, be.22317
bg.22316:
	load    [$i4 + 1], $f5
	bne     $f5, $f0, bne.22317
be.22317:
	load    [$i4 + 2], $f4
	fsub    $f4, $f3, $f4
	load    [$i2 + 4], $f5
	load    [%{ext_light_dirvec + 0} + 0], $f6
	load    [$i4 + 3], $f7
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22321
bg.22319:
	load    [%{ext_light_dirvec + 0} + 2], $f5
	load    [$i2 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, be.22321
bg.22320:
	load    [$i4 + 3], $f5
	be      $f5, $f0, be.22321
bne.22317:
	mov     $f4, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
be.22321:
	load    [$i4 + 4], $f4
	fsub    $f4, $f2, $f2
	load    [$i2 + 4], $f5
	load    [%{ext_light_dirvec + 0} + 0], $f6
	load    [$i4 + 5], $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22334
bg.22323:
	load    [%{ext_light_dirvec + 0} + 1], $f1
	load    [$i2 + 5], $f4
	fmul    $f2, $f1, $f1
	fadd_a  $f1, $f3, $f1
	ble     $f4, $f1, ble.22334
bg.22324:
	load    [$i4 + 5], $f1
	be      $f1, $f0, ble.22334
bne.22325:
	mov     $f2, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
bne.22314:
	be      $i5, 2, be.22326
bne.22326:
	be      $f4, $f0, ble.22334
bne.22328:
	load    [$i4 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f3, $f6
	load    [$i4 + 3], $f7
	fmul    $f7, $f2, $f7
	fmul    $f1, $f1, $f8
	load    [$i2 + 4], $f10
	fmul    $f3, $f3, $f9
	load    [$i2 + 5], $f11
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i6
	fmul    $f8, $f10, $f6
	load    [$i2 + 6], $f10
	fmul    $f9, $f11, $f8
	fmul    $f2, $f2, $f9
	fadd    $f5, $f7, $f5
	fadd    $f6, $f8, $f6
	fmul    $f9, $f10, $f7
	fmul    $f5, $f5, $f8
	fadd    $f6, $f7, $f6
	be      $i6, 0, be.22329
bne.22329:
	fmul    $f3, $f2, $f7
	load    [$i2 + 16], $f9
	fmul    $f2, $f1, $f2
	load    [$i2 + 17], $f10
	fmul    $f1, $f3, $f1
	fmul    $f7, $f9, $f3
	load    [$i2 + 18], $f7
	fmul    $f2, $f10, $f2
	fmul    $f1, $f7, $f1
	fadd    $f6, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	be      $i5, 3, be.22330
.count dual_jmp
	b       bne.22330
be.22329:
	mov     $f6, $f1
	be      $i5, 3, be.22330
bne.22330:
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, ble.22334
.count dual_jmp
	b       bg.22331
be.22330:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, ble.22334
bg.22331:
	load    [$i2 + 10], $i2
	fsqrt   $f1, $f1
	load    [$i4 + 4], $f2
	be      $i2, 0, be.22332
bne.22332:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
be.22332:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
be.22326:
	ble     $f0, $f4, ble.22334
bg.22327:
	load    [$i4 + 1], $f4
	load    [$i4 + 2], $f5
	fmul    $f4, $f1, $f1
	load    [$i4 + 3], $f6
	fmul    $f5, $f3, $f3
	fmul    $f6, $f2, $f2
	fadd    $f1, $f3, $f1
	fadd    $f1, $f2, $fg0
.count load_float
	load    [f.21980], $f1
	bg      $f1, $fg0, bg.22334
ble.22334:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22353
be.22336:
	li      0, $i1
	jr      $ra1
bg.22334:
	load    [$i3 + 0], $i1
	be      $i1, -1, bne.22355
bne.22337:
	fadd    $fg0, $fc11, $f1
	load    [ext_objects + $i1], $i1
	load    [ext_intersection_point + 0], $f2
	fmul    $fg14, $f1, $f5
	load    [ext_intersection_point + 1], $f3
	fmul    $fg12, $f1, $f7
	load    [$i1 + 1], $i2
	fmul    $fg13, $f1, $f1
	load    [$i1 + 7], $f4
	fadd    $f5, $f2, $f2
	load    [$i1 + 8], $f6
	fadd    $f7, $f3, $f3
	load    [$i1 + 9], $f8
	fsub    $f2, $f4, $f4
	load    [ext_intersection_point + 2], $f9
	fadd    $f1, $f9, $f1
	fsub    $f3, $f6, $f5
	fsub    $f1, $f8, $f6
	bne     $i2, 1, bne.22338
be.22338:
	load    [$i1 + 4], $f7
	fabs    $f4, $f4
	ble     $f7, $f4, ble.22341
bg.22339:
	load    [$i1 + 5], $f4
	fabs    $f5, $f5
	bg      $f4, $f5, bg.22341
ble.22341:
	load    [$i1 + 10], $i1
	be      $i1, 0, bne.22353
.count dual_jmp
	b       be.22353
bg.22341:
	load    [$i1 + 6], $f4
	fabs    $f6, $f5
	load    [$i1 + 10], $i1
	ble     $f4, $f5, ble.22343
bg.22343:
	be      $i1, 0, be.22353
.count dual_jmp
	b       bne.22353
ble.22343:
	be      $i1, 0, bne.22353
.count dual_jmp
	b       be.22353
bne.22338:
	be      $i2, 2, be.22345
bne.22345:
	load    [$i1 + 10], $i4
	fmul    $f4, $f4, $f7
	load    [$i1 + 4], $f9
	fmul    $f5, $f5, $f8
	load    [$i1 + 5], $f10
	fmul    $f6, $f6, $f11
	load    [$i1 + 3], $i5
	fmul    $f7, $f9, $f7
	load    [$i1 + 6], $f9
	fmul    $f8, $f10, $f8
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i5, 0, be.22349
bne.22349:
	fmul    $f5, $f6, $f8
	load    [$i1 + 16], $f9
	fmul    $f6, $f4, $f6
	load    [$i1 + 17], $f10
	fmul    $f4, $f5, $f4
	fmul    $f8, $f9, $f5
	load    [$i1 + 18], $f8
	fmul    $f6, $f10, $f6
	fmul    $f4, $f8, $f4
	fadd    $f7, $f5, $f5
	fadd    $f5, $f6, $f5
	fadd    $f5, $f4, $f4
	be      $i2, 3, be.22350
.count dual_jmp
	b       bne.22350
be.22349:
	mov     $f7, $f4
	be      $i2, 3, be.22350
bne.22350:
	ble     $f0, $f4, ble.22351
.count dual_jmp
	b       bg.22351
be.22350:
	fsub    $f4, $fc0, $f4
	ble     $f0, $f4, ble.22351
bg.22351:
	be      $i4, 0, be.22353
.count dual_jmp
	b       bne.22353
ble.22351:
	be      $i4, 0, bne.22353
.count dual_jmp
	b       be.22353
be.22345:
	load    [$i1 + 10], $i2
	load    [$i1 + 4], $f7
	fmul    $f7, $f4, $f4
	load    [$i1 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i1 + 6], $f9
	fmul    $f9, $f6, $f6
	fadd    $f4, $f5, $f4
	fadd    $f4, $f6, $f4
	ble     $f0, $f4, ble.22346
bg.22346:
	be      $i2, 0, be.22353
.count dual_jmp
	b       bne.22353
ble.22346:
	be      $i2, 0, bne.22353
be.22353:
	li      1, $i1
.count move_args
	mov     $f1, $f4
	call    check_all_inside.2856
	be      $i1, 0, bne.22353
bne.22355:
	li      1, $i1
	jr      $ra1
bne.22353:
	add     $i7, 1, $i7
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i8, $i9)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.align 2
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i9 + $i8], $i1
	be      $i1, -1, be.22370
bne.22356:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22357:
	add     $i8, 1, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22358:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22359:
	add     $i8, 2, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22360:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22361:
	add     $i8, 3, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22362:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22363:
	add     $i8, 4, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22364:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22365:
	add     $i8, 5, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22366:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22367:
	add     $i8, 6, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22368:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22369:
	add     $i8, 7, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22370
bne.22370:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	be      $i1, 0, be.22371
bne.22357:
	li      1, $i1
	jr      $ra2
be.22371:
	add     $i8, 8, $i8
	b       shadow_check_one_or_group.2865
be.22370:
	li      0, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i10, $i11)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.align 2
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i11 + $i10], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22429
bne.22372:
	be      $i1, 99, bne.22396
bne.22373:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i3
	load    [ext_intersection_point + 0], $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i2 + 7], $f3
	fsub    $f1, $f3, $f1
	load    [$i2 + 8], $f4
	fsub    $f2, $f4, $f2
	load    [ext_intersection_point + 2], $f5
	load    [$i2 + 9], $f3
	load    [$i3 + $i1], $i1
	fsub    $f5, $f3, $f3
	load    [$i2 + 1], $i4
	load    [$i1 + 0], $f4
	bne     $i4, 1, bne.22374
be.22374:
	fsub    $f4, $f1, $f4
	load    [$i2 + 5], $f5
	load    [$i1 + 1], $f7
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, be.22377
bg.22375:
	load    [%{ext_light_dirvec + 0} + 2], $f5
	load    [$i2 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, be.22377
bg.22376:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.22377
be.22377:
	load    [$i1 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i2 + 4], $f5
	load    [%{ext_light_dirvec + 0} + 0], $f6
	load    [$i1 + 3], $f7
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22381
bg.22379:
	load    [%{ext_light_dirvec + 0} + 2], $f5
	load    [$i2 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, be.22381
bg.22380:
	load    [$i1 + 3], $f5
	be      $f5, $f0, be.22381
bne.22377:
	mov     $f4, $fg0
	ble     $fc4, $fg0, be.22428
.count dual_jmp
	b       bg.22394
be.22381:
	load    [$i1 + 4], $f4
	load    [$i2 + 4], $f5
	fsub    $f4, $f3, $f3
	load    [%{ext_light_dirvec + 0} + 0], $f6
	load    [$i1 + 5], $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, be.22428
bg.22383:
	load    [%{ext_light_dirvec + 0} + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i2 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, be.22428
bg.22384:
	load    [$i1 + 5], $f1
	be      $f1, $f0, be.22428
bne.22385:
	mov     $f3, $fg0
	ble     $fc4, $fg0, be.22428
.count dual_jmp
	b       bg.22394
bne.22374:
	be      $i4, 2, be.22386
bne.22386:
	be      $f4, $f0, be.22428
bne.22388:
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f7, $f3, $f7
	fmul    $f1, $f1, $f8
	load    [$i2 + 4], $f10
	fmul    $f2, $f2, $f9
	load    [$i2 + 5], $f11
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i3
	fmul    $f8, $f10, $f6
	load    [$i2 + 6], $f10
	fmul    $f9, $f11, $f8
	fmul    $f3, $f3, $f9
	fadd    $f5, $f7, $f5
	fadd    $f6, $f8, $f6
	fmul    $f9, $f10, $f7
	fmul    $f5, $f5, $f8
	fadd    $f6, $f7, $f6
	be      $i3, 0, be.22389
bne.22389:
	fmul    $f2, $f3, $f7
	load    [$i2 + 16], $f9
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f10
	fmul    $f1, $f2, $f1
	fmul    $f7, $f9, $f2
	load    [$i2 + 18], $f7
	fmul    $f3, $f10, $f3
	fmul    $f1, $f7, $f1
	fadd    $f6, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	be      $i4, 3, be.22390
.count dual_jmp
	b       bne.22390
be.22389:
	mov     $f6, $f1
	be      $i4, 3, be.22390
bne.22390:
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, be.22428
.count dual_jmp
	b       bg.22391
be.22390:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f8, $f1, $f1
	ble     $f1, $f0, be.22428
bg.22391:
	load    [$i2 + 10], $i2
	fsqrt   $f1, $f1
	load    [$i1 + 4], $f2
	be      $i2, 0, be.22392
bne.22392:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc4, $fg0, be.22428
.count dual_jmp
	b       bg.22394
be.22392:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc4, $fg0, be.22428
.count dual_jmp
	b       bg.22394
be.22386:
	ble     $f0, $f4, be.22428
bg.22387:
	load    [$i1 + 1], $f4
	load    [$i1 + 2], $f5
	fmul    $f4, $f1, $f1
	load    [$i1 + 3], $f6
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $fg0
	ble     $fc4, $fg0, be.22428
bg.22394:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22428
bne.22395:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22396
be.22396:
	li      2, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22428
bne.22396:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22428
bne.22414:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22415:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22428
bne.22416:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22417:
	load    [$i9 + 3], $i1
	be      $i1, -1, be.22428
bne.22418:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22419:
	load    [$i9 + 4], $i1
	be      $i1, -1, be.22428
bne.22420:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22421:
	load    [$i9 + 5], $i1
	be      $i1, -1, be.22428
bne.22422:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22423:
	load    [$i9 + 6], $i1
	be      $i1, -1, be.22428
bne.22424:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22425:
	load    [$i9 + 7], $i1
	be      $i1, -1, be.22428
bne.22426:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22427:
	li      8, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22410
be.22428:
	add     $i10, 1, $i1
	load    [$i11 + $i1], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22429
bne.22429:
	be      $i1, 99, bne.22434
bne.22430:
	call    solver_fast.2796
	be      $i1, 0, be.22413
bne.22431:
	ble     $fc4, $fg0, be.22413
bg.22432:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22413
bne.22433:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22434
be.22434:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22413
bne.22435:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22434
be.22436:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22413
bne.22434:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22413
bne.22439:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22410:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22413
bne.22411:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22412:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22413
bne.22410:
	li      1, $i1
	jr      $ra3
be.22413:
	add     $i10, 2, $i10
	b       shadow_check_one_or_matrix.2868
be.22429:
	li      0, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i7], $i9
	be      $i9, -1, be.22479
bne.22444:
	load    [ext_objects + $i9], $i1
	load    [$i8 + 0], $f4
	load    [$i1 + 1], $i2
	load    [$i1 + 7], $f1
	load    [$i1 + 8], $f2
	fsub    $fg17, $f1, $f1
	load    [$i1 + 9], $f3
	fsub    $fg18, $f2, $f2
	fsub    $fg19, $f3, $f3
	bne     $i2, 1, bne.22445
be.22445:
	be      $f4, $f0, ble.22452
bne.22446:
	load    [$i1 + 10], $i2
	load    [$i1 + 4], $f5
	ble     $f0, $f4, ble.22447
bg.22447:
	be      $i2, 0, be.22448
.count dual_jmp
	b       bne.22803
ble.22447:
	be      $i2, 0, bne.22803
be.22448:
	fsub    $f5, $f1, $f5
	finv    $f4, $f4
	load    [$i1 + 5], $f6
	load    [$i8 + 1], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.22452
.count dual_jmp
	b       bg.22451
bne.22803:
	fneg    $f5, $f5
	load    [$i1 + 5], $f6
	fsub    $f5, $f1, $f5
	load    [$i8 + 1], $f7
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.22452
bg.22451:
	load    [$i8 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.22452
bg.22452:
	mov     $f4, $fg0
	li      1, $i10
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
ble.22452:
	load    [$i8 + 1], $f4
	be      $f4, $f0, ble.22460
bne.22454:
	load    [$i1 + 10], $i2
	load    [$i1 + 5], $f5
	ble     $f0, $f4, ble.22455
bg.22455:
	be      $i2, 0, be.22456
.count dual_jmp
	b       bne.22806
ble.22455:
	be      $i2, 0, bne.22806
be.22456:
	fsub    $f5, $f2, $f5
	load    [$i1 + 6], $f6
	finv    $f4, $f4
	load    [$i8 + 2], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.22460
.count dual_jmp
	b       bg.22459
bne.22806:
	fneg    $f5, $f5
	fsub    $f5, $f2, $f5
	load    [$i1 + 6], $f6
	finv    $f4, $f4
	load    [$i8 + 2], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.22460
bg.22459:
	load    [$i8 + 0], $f5
	fmul    $f4, $f5, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.22460
bg.22460:
	mov     $f4, $fg0
	li      2, $i10
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
ble.22460:
	load    [$i8 + 2], $f4
	be      $f4, $f0, ble.22476
bne.22462:
	load    [$i1 + 4], $f5
	load    [$i8 + 0], $f6
	load    [$i1 + 10], $i2
	load    [$i1 + 6], $f7
	ble     $f0, $f4, ble.22463
bg.22463:
	be      $i2, 0, be.22464
.count dual_jmp
	b       bne.22809
ble.22463:
	be      $i2, 0, bne.22809
be.22464:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
.count dual_jmp
	b       bg.22467
bne.22809:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
bg.22467:
	load    [$i8 + 1], $f1
	load    [$i1 + 5], $f4
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22476
bg.22468:
	mov     $f3, $fg0
	li      3, $i10
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bne.22445:
	bne     $i2, 2, bne.22469
be.22469:
	load    [$i1 + 4], $f5
	load    [$i8 + 1], $f6
	fmul    $f4, $f5, $f4
	load    [$i1 + 5], $f7
	fmul    $f6, $f7, $f6
	load    [$i8 + 2], $f8
	fadd    $f4, $f6, $f4
	load    [$i1 + 6], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	ble     $f4, $f0, ble.22476
bg.22470:
	fmul    $f5, $f1, $f1
	li      1, $i10
	fmul    $f7, $f2, $f2
	fmul    $f9, $f3, $f3
	finv    $f4, $f4
	fadd    $f1, $f2, $f1
	fadd_n  $f1, $f3, $f1
	fmul    $f1, $f4, $fg0
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bne.22469:
	load    [$i8 + 1], $f5
	fmul    $f4, $f4, $f7
	load    [$i1 + 3], $i4
	fmul    $f5, $f5, $f8
	load    [$i8 + 2], $f6
	fmul    $f6, $f6, $f11
	load    [$i1 + 4], $f9
	fmul    $f7, $f9, $f7
	load    [$i1 + 5], $f10
	fmul    $f8, $f10, $f8
	load    [$i1 + 6], $f12
	fmul    $f11, $f12, $f11
	fadd    $f7, $f8, $f7
	fadd    $f7, $f11, $f7
	be      $i4, 0, be.22471
bne.22471:
	fmul    $f5, $f6, $f8
	load    [$i1 + 16], $f11
	fmul    $f6, $f4, $f13
	load    [$i1 + 17], $f14
	fmul    $f4, $f5, $f15
	fmul    $f8, $f11, $f8
	load    [$i1 + 18], $f11
	fmul    $f13, $f14, $f13
	fmul    $f15, $f11, $f11
	fadd    $f7, $f8, $f7
	fadd    $f7, $f13, $f7
	fadd    $f7, $f11, $f7
	be      $f7, $f0, ble.22476
.count dual_jmp
	b       bne.22472
be.22471:
	be      $f7, $f0, ble.22476
bne.22472:
	fmul    $f4, $f1, $f8
	fmul    $f5, $f2, $f11
	fmul    $f6, $f3, $f13
	fmul    $f8, $f9, $f8
	fmul    $f11, $f10, $f11
	fmul    $f13, $f12, $f13
	fadd    $f8, $f11, $f8
	fadd    $f8, $f13, $f8
	be      $i4, 0, be.22473
bne.22473:
	fmul    $f6, $f2, $f11
	fmul    $f5, $f3, $f13
	load    [$i1 + 16], $f14
	fmul    $f4, $f3, $f15
	load    [$i1 + 17], $f16
	fmul    $f6, $f1, $f6
	fadd    $f11, $f13, $f11
	fmul    $f4, $f2, $f4
	load    [$i1 + 18], $f13
	fmul    $f5, $f1, $f5
	fadd    $f15, $f6, $f6
	fmul    $f11, $f14, $f11
	fadd    $f4, $f5, $f4
	fmul    $f6, $f16, $f5
	fmul    $f1, $f1, $f6
	fmul    $f4, $f13, $f4
	fadd    $f11, $f5, $f5
	fmul    $f3, $f3, $f11
	fmul    $f6, $f9, $f6
	fadd    $f5, $f4, $f4
	fmul    $f11, $f12, $f9
	fmul    $f4, $fc3, $f4
	fadd    $f8, $f4, $f4
	fmul    $f2, $f2, $f8
	fmul    $f4, $f4, $f5
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fadd    $f6, $f9, $f6
	be      $i4, 0, be.22474
.count dual_jmp
	b       bne.22474
be.22473:
	mov     $f8, $f4
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f2, $f2, $f8
	fmul    $f3, $f3, $f11
	fmul    $f6, $f9, $f6
	fmul    $f8, $f10, $f8
	fmul    $f11, $f12, $f9
	fadd    $f6, $f8, $f6
	fadd    $f6, $f9, $f6
	be      $i4, 0, be.22474
bne.22474:
	fmul    $f2, $f3, $f8
	load    [$i1 + 16], $f9
	fmul    $f3, $f1, $f3
	load    [$i1 + 17], $f10
	fmul    $f1, $f2, $f1
	fmul    $f8, $f9, $f2
	load    [$i1 + 18], $f8
	fmul    $f3, $f10, $f3
	fmul    $f1, $f8, $f1
	fadd    $f6, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	be      $i2, 3, be.22475
.count dual_jmp
	b       bne.22475
be.22474:
	mov     $f6, $f1
	be      $i2, 3, be.22475
bne.22475:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22476
.count dual_jmp
	b       bg.22476
be.22475:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.22476
ble.22476:
	load    [ext_objects + $i9], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22479
be.22479:
	jr      $ra1
bg.22476:
	load    [$i1 + 10], $i1
	fsqrt   $f1, $f1
	li      1, $i10
	finv    $f7, $f2
	be      $i1, 0, be.22477
bne.22477:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
be.22477:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22479
bg.22480:
	ble     $fg7, $fg0, bne.22479
bg.22481:
	fadd    $fg0, $fc11, $f12
	li      0, $i1
	load    [$i8 + 0], $f1
	fmul    $f1, $f12, $f1
	load    [$i8 + 1], $f2
	fmul    $f2, $f12, $f2
	load    [$i8 + 2], $f3
	fmul    $f3, $f12, $f3
	fadd    $f1, $fg17, $f13
	fadd    $f2, $fg18, $f14
	fadd    $f3, $fg19, $f4
.count move_args
	mov     $f13, $f2
.count move_args
	mov     $f14, $f3
	call    check_all_inside.2856
	add     $i7, 1, $i7
	be      $i1, 0, solve_each_element.2871
bne.22482:
	mov     $f12, $fg7
	store   $f13, [ext_intersection_point + 0]
	store   $f14, [ext_intersection_point + 1]
	mov     $i9, $ig3
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig2
	b       solve_each_element.2871
bne.22479:
	add     $i7, 1, $i7
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i12 + $i11], $i1
	be      $i1, -1, be.22490
bne.22483:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 1, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22484:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 2, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22485:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 3, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22486:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 4, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22487:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 5, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22488:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 6, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22489:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 7, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22490
bne.22490:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i11, 8, $i11
	b       solve_one_or_network.2875
be.22490:
	jr      $ra2
.end solve_one_or_network

######################################################################
# trace_or_matrix($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i14 + $i13], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22499
bne.22491:
	bne     $i1, 99, bne.22492
be.22492:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22498
bne.22493:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22498
bne.22494:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, be.22498
bne.22495:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, be.22498
bne.22496:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 5], $i1
	be      $i1, -1, be.22498
bne.22497:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 6], $i1
	be      $i1, -1, be.22498
bne.22498:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      7, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22499
.count dual_jmp
	b       bne.22499
be.22498:
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22499
bne.22499:
	be      $i1, 99, be.22500
bne.22500:
.count move_args
	mov     $i8, $i2
	call    solver.2773
	be      $i1, 0, ble.22506
bne.22505:
	ble     $fg7, $fg0, ble.22506
bg.22506:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
be.22500:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22506
bne.22501:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22506
bne.22502:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22506
bne.22503:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22506
bne.22504:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      5, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
ble.22506:
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
be.22499:
	jr      $ra3
bne.22492:
.count move_args
	mov     $i8, $i2
	call    solver.2773
	be      $i1, 0, ble.22508
bne.22507:
	ble     $fg7, $fg0, ble.22508
bg.22508:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 1, $i13
	b       trace_or_matrix.2879
ble.22508:
	add     $i13, 1, $i13
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i7], $i9
	be      $i9, -1, be.22528
bne.22509:
	load    [ext_objects + $i9], $i1
	load    [$i8 + 3], $i2
	load    [$i1 + 1], $i4
	load    [$i1 + 19], $f1
	load    [$i1 + 20], $f2
	load    [$i1 + 21], $f3
	load    [$i2 + $i9], $i2
	bne     $i4, 1, bne.22510
be.22510:
	load    [$i2 + 0], $f4
	fsub    $f4, $f1, $f4
	load    [$i1 + 5], $f5
	load    [$i8 + 1], $f6
	load    [$i2 + 1], $f7
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, be.22513
bg.22511:
	load    [$i8 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, be.22513
bg.22512:
	load    [$i2 + 1], $f5
	be      $f5, $f0, be.22513
bne.22513:
	mov     $f4, $fg0
	li      1, $i10
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
be.22513:
	load    [$i2 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i1 + 4], $f5
	load    [$i8 + 0], $f6
	load    [$i2 + 3], $f7
	fmul    $f4, $f7, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22517
bg.22515:
	load    [$i8 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, be.22517
bg.22516:
	load    [$i2 + 3], $f5
	be      $f5, $f0, be.22517
bne.22517:
	mov     $f4, $fg0
	li      2, $i10
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
be.22517:
	load    [$i2 + 4], $f4
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f5
	load    [$i8 + 0], $f6
	load    [$i2 + 5], $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22525
bg.22519:
	load    [$i8 + 1], $f1
	load    [$i1 + 5], $f4
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22525
bg.22520:
	load    [$i2 + 5], $f1
	be      $f1, $f0, ble.22525
bne.22521:
	mov     $f3, $fg0
	li      3, $i10
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22510:
	be      $i4, 2, be.22522
bne.22522:
	load    [$i2 + 0], $f4
	be      $f4, $f0, ble.22525
bne.22524:
	load    [$i2 + 1], $f5
	load    [$i2 + 2], $f6
	fmul    $f5, $f1, $f1
	load    [$i2 + 3], $f7
	fmul    $f6, $f2, $f2
	fmul    $f7, $f3, $f3
	load    [$i1 + 22], $f5
	fadd    $f1, $f2, $f1
	fmul    $f4, $f5, $f2
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f3
	fsub    $f3, $f2, $f2
	ble     $f2, $f0, ble.22525
bg.22525:
	load    [$i1 + 10], $i1
	li      1, $i10
	load    [$i2 + 4], $f3
	fsqrt   $f2, $f2
	be      $i1, 0, be.22526
bne.22526:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
be.22526:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
be.22522:
	load    [$i2 + 0], $f1
	ble     $f0, $f1, ble.22525
bg.22523:
	load    [$i1 + 22], $f2
	li      1, $i10
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22528
bg.22529:
	ble     $fg7, $fg0, bne.22528
bg.22530:
	fadd    $fg0, $fc11, $f12
	li      0, $i1
	load    [$i8 + 0], $f1
	fmul    $f1, $f12, $f1
	load    [$i8 + 1], $f2
	fmul    $f2, $f12, $f2
	load    [$i8 + 2], $f3
	fmul    $f3, $f12, $f3
	fadd    $f1, $fg8, $f13
	fadd    $f2, $fg9, $f14
	fadd    $f3, $fg10, $f4
.count move_args
	mov     $f13, $f2
.count move_args
	mov     $f14, $f3
	call    check_all_inside.2856
	add     $i7, 1, $i7
	be      $i1, 0, solve_each_element_fast.2885
bne.22531:
	mov     $f12, $fg7
	store   $f13, [ext_intersection_point + 0]
	store   $f14, [ext_intersection_point + 1]
	mov     $i9, $ig3
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig2
	b       solve_each_element_fast.2885
ble.22525:
	load    [ext_objects + $i9], $i1
	load    [$i1 + 10], $i1
	be      $i1, 0, be.22528
bne.22528:
	add     $i7, 1, $i7
	b       solve_each_element_fast.2885
be.22528:
	jr      $ra1
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i12 + $i11], $i1
	be      $i1, -1, be.22539
bne.22532:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 1, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22533:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 2, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22534:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 3, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22535:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 4, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22536:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 5, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22537:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 6, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22538:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 7, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22539
bne.22539:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 8, $i11
	b       solve_one_or_network_fast.2889
be.22539:
	jr      $ra2
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i14 + $i13], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22548
bne.22540:
	bne     $i1, 99, bne.22541
be.22541:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22547
bne.22542:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22547
bne.22543:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, be.22547
bne.22544:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, be.22547
bne.22545:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 5], $i1
	be      $i1, -1, be.22547
bne.22546:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 6], $i1
	be      $i1, -1, be.22547
bne.22547:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22548
.count dual_jmp
	b       bne.22548
be.22547:
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22548
bne.22548:
	be      $i1, 99, be.22549
bne.22549:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22555
bne.22554:
	ble     $fg7, $fg0, ble.22555
bg.22555:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
be.22549:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22555
bne.22550:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22555
bne.22551:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22555
bne.22552:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22555
bne.22553:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
ble.22555:
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
be.22548:
	jr      $ra3
bne.22541:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22557
bne.22556:
	ble     $fg7, $fg0, ble.22557
bg.22557:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 1, $i13
	b       trace_or_matrix_fast.2893
ble.22557:
	add     $i13, 1, $i13
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i2)
# $ra = $ra1
# [$i1]
# [$f1 - $f11]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.align 2
.begin utexture
utexture.2908:
	load    [$i2 + 0], $i1
	load    [$i2 + 13], $fg16
	load    [$i2 + 14], $fg11
	load    [$i2 + 15], $fg15
	be      $i1, 1, be.22558
bne.22558:
	be      $i1, 2, be.22563
bne.22563:
	be      $i1, 3, be.22564
bne.22564:
	bne     $i1, 4, bne.22565
be.22565:
.count load_float
	load    [f.21983], $f8
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [$i2 + 4], $f3
	fsqrt   $f3, $f2
	load    [ext_intersection_point + 2], $f4
	fmul    $f1, $f2, $f9
	load    [$i2 + 9], $f3
	fsub    $f4, $f3, $f3
	load    [$i2 + 6], $f5
	fsqrt   $f5, $f1
	fabs    $f9, $f2
	fmul    $f3, $f1, $f10
	ble     $f8, $f2, ble.22566
bg.22566:
	mov     $fc14, $f11
	fmul    $f9, $f9, $f1
	load    [ext_intersection_point + 1], $f3
	fmul    $f10, $f10, $f2
	load    [$i2 + 8], $f4
	load    [$i2 + 5], $f5
	fadd    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsqrt   $f5, $f3
	fabs    $f1, $f4
	fmul    $f2, $f3, $f2
	ble     $f8, $f4, ble.22567
.count dual_jmp
	b       bg.22567
ble.22566:
	finv    $f9, $f1
	fmul_a  $f10, $f1, $f2
	call    ext_atan
	fmul    $fc13, $f1, $f11
	fmul    $f9, $f9, $f1
	load    [ext_intersection_point + 1], $f3
	fmul    $f10, $f10, $f2
	load    [$i2 + 8], $f4
	load    [$i2 + 5], $f5
	fadd    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsqrt   $f5, $f3
	fabs    $f1, $f4
	fmul    $f2, $f3, $f2
	ble     $f8, $f4, ble.22567
bg.22567:
	mov     $fc14, $f4
.count load_float
	load    [f.21989], $f5
.count move_args
	mov     $f11, $f2
	call    ext_floor
	fsub    $f11, $f1, $f1
.count move_args
	mov     $f4, $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f5
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f0, $f1, ble.22568
.count dual_jmp
	b       bg.22568
ble.22567:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
	fmul    $fc13, $f1, $f4
.count load_float
	load    [f.21989], $f5
.count move_args
	mov     $f11, $f2
	call    ext_floor
	fsub    $f11, $f1, $f1
.count move_args
	mov     $f4, $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f5
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f0, $f1, ble.22568
bg.22568:
	mov     $f0, $fg15
	jr      $ra1
ble.22568:
.count load_float
	load    [f.21990], $f2
	fmul    $f2, $f1, $fg15
	jr      $ra1
bne.22565:
	jr      $ra1
be.22564:
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 2], $f3
	fmul    $f1, $f1, $f1
	load    [$i2 + 9], $f4
	fsub    $f3, $f4, $f2
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc6, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
.count load_float
	load    [f.21986], $f2
	fmul    $f1, $f2, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	fsub    $fc0, $f1, $f2
	fmul    $f1, $fc5, $fg11
	fmul    $f2, $fc5, $fg15
	jr      $ra1
be.22563:
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.21993], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fsub    $fc0, $f1, $f2
	fmul    $fc5, $f1, $fg16
	fmul    $fc5, $f2, $fg11
	jr      $ra1
be.22558:
.count load_float
	load    [f.21994], $f4
	load    [ext_intersection_point + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.21995], $f6
	fmul    $f1, $f6, $f1
.count load_float
	load    [f.21996], $f7
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 0], $f2
	load    [$i2 + 7], $f3
	fsub    $f2, $f3, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	ble     $f7, $f1, ble.22559
bg.22559:
	ble     $f7, $f5, ble.22813
.count dual_jmp
	b       bg.22812
ble.22559:
	ble     $f7, $f5, bg.22812
ble.22813:
	mov     $f0, $fg11
	jr      $ra1
bg.22812:
	mov     $fc5, $fg11
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i15, $f15, $f16, $i16)
# $ra = $ra4
# [$i1 - $i15, $i17]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_reflections
trace_reflections.2915:
	bl      $i15, 0, bl.22569
bge.22569:
	load    [$ig1 + 0], $i12
	load    [ext_reflections + $i15], $i17
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22570
be.22570:
	ble     $fg7, $fc4, bne.22581
.count dual_jmp
	b       bg.22578
bne.22570:
	add     $i17, 1, $i8
	be      $i1, 99, be.22571
bne.22571:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22577
bne.22576:
	ble     $fg7, $fg0, ble.22577
bg.22577:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22581
.count dual_jmp
	b       bg.22578
be.22571:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22577
bne.22572:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22577
bne.22573:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22577
bne.22574:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22577
bne.22575:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22581
.count dual_jmp
	b       bg.22578
ble.22577:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22581
bg.22578:
	ble     $fc9, $fg7, bne.22581
bg.22579:
	add     $ig3, $ig3, $i1
	load    [$i17 + 0], $i2
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
	bne     $i1, $i2, bne.22581
be.22581:
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22581
be.22582:
	load    [$i17 + 5], $f1
	fmul    $f1, $f15, $f4
	load    [ext_nvector + 0], $f2
	load    [$i17 + 1], $f3
	load    [ext_nvector + 1], $f5
	fmul    $f2, $f3, $f2
	load    [$i17 + 2], $f6
	fmul    $f5, $f6, $f5
	load    [ext_nvector + 2], $f7
	fadd    $f2, $f5, $f2
	load    [$i17 + 3], $f8
	fmul    $f7, $f8, $f7
	fadd    $f2, $f7, $f2
	fmul    $f4, $f2, $f2
	ble     $f2, $f0, ble.22583
bg.22583:
	fmul    $f2, $fg16, $f4
	fmul    $f2, $fg11, $f5
	fmul    $f2, $fg15, $f2
	fadd    $fg4, $f4, $fg4
	load    [$i16 + 1], $f4
	fadd    $fg5, $f5, $fg5
	load    [$i16 + 2], $f5
	fadd    $fg6, $f2, $fg6
	load    [$i16 + 0], $f2
	fmul    $f2, $f3, $f2
	fmul    $f4, $f6, $f3
	fmul    $f5, $f8, $f4
	fadd    $f2, $f3, $f2
	fadd    $f2, $f4, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22581
.count dual_jmp
	b       bg.22584
ble.22583:
	load    [$i16 + 0], $f2
	fmul    $f2, $f3, $f2
	load    [$i16 + 1], $f4
	fmul    $f4, $f6, $f3
	load    [$i16 + 2], $f5
	fmul    $f5, $f8, $f4
	fadd    $f2, $f3, $f2
	fadd    $f2, $f4, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22581
bg.22584:
	fmul    $f1, $f1, $f1
	add     $i15, -1, $i15
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
bne.22581:
	add     $i15, -1, $i15
	b       trace_reflections.2915
bl.22569:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i18, $f17, $i16, $i19, $f18)
# $ra = $ra5
# [$i1 - $i15, $i17 - $i18, $i20 - $i21]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.align 2
.begin trace_ray
trace_ray.2920:
	bg      $i18, 4, bg.22585
ble.22585:
	load    [$ig1 + 0], $i12
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22586
be.22586:
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22595
.count dual_jmp
	b       bg.22594
bne.22586:
	be      $i1, 99, be.22587
bne.22587:
.count move_args
	mov     $i16, $i2
	call    solver.2773
.count move_args
	mov     $i16, $i8
	be      $i1, 0, ble.22593
bne.22592:
	ble     $fg7, $fg0, ble.22593
bg.22593:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
.count move_args
	mov     $i16, $i8
	jal     trace_or_matrix.2879, $ra3
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22595
.count dual_jmp
	b       bg.22594
be.22587:
	load    [$i12 + 1], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22593
bne.22588:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22593
bne.22589:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22593
bne.22590:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22593
bne.22591:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      5, $i11
.count move_args
	mov     $i16, $i8
	jal     solve_one_or_network.2875, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
.count move_args
	mov     $i16, $i8
	jal     trace_or_matrix.2879, $ra3
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22595
.count dual_jmp
	b       bg.22594
ble.22593:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix.2879, $ra3
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22595
bg.22594:
	bg      $fc9, $fg7, bg.22595
ble.22595:
	add     $i0, -1, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	be      $i18, 0, bg.22585
bne.22597:
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	fmul    $f1, $fg14, $f1
	load    [$i16 + 2], $f3
	fmul    $f2, $fg12, $f2
	fmul    $f3, $fg13, $f3
	fadd    $f1, $f2, $f1
	fadd_n  $f1, $f3, $f1
	ble     $f1, $f0, bg.22585
bg.22598:
	fmul    $f1, $f1, $f2
	load    [ext_beam + 0], $f3
	fmul    $f2, $f1, $f1
	fmul    $f1, $f17, $f1
	fmul    $f1, $f3, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
bg.22595:
	load    [ext_objects + $ig3], $i21
	load    [$i21 + 1], $i1
	be      $i1, 1, be.22599
bne.22599:
	load    [$i21 + 4], $f1
	bne     $i1, 2, bne.22602
be.22602:
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i21 + 5], $f1
.count move_args
	mov     $i21, $i2
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i21 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22602:
	load    [$i21 + 3], $i1
	load    [ext_intersection_point + 0], $f2
	load    [$i21 + 7], $f3
	load    [$i21 + 5], $f4
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 1], $f5
	fmul    $f2, $f1, $f1
	load    [$i21 + 8], $f3
	fsub    $f5, $f3, $f3
	load    [$i21 + 6], $f6
	fmul    $f3, $f4, $f4
	load    [ext_intersection_point + 2], $f7
	load    [$i21 + 9], $f8
	fsub    $f7, $f8, $f5
	fmul    $f5, $f6, $f6
	be      $i1, 0, be.22603
bne.22603:
	load    [$i21 + 18], $f7
	load    [$i21 + 17], $f8
	fmul    $f3, $f7, $f7
	fmul    $f5, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i21 + 18], $f1
	load    [$i21 + 16], $f7
	fmul    $f2, $f1, $f1
	fmul    $f5, $f7, $f5
	fadd    $f1, $f5, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i21 + 17], $f1
	load    [$i21 + 16], $f4
	fmul    $f2, $f1, $f1
	fmul    $f3, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f6, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f3
	load    [$i21 + 10], $i1
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 2], $f4
	fmul    $f4, $f4, $f4
	fadd    $f3, $f2, $f2
	fadd    $f2, $f4, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22604
.count dual_jmp
	b       bne.22604
be.22603:
	store   $f1, [ext_nvector + 0]
	store   $f4, [ext_nvector + 1]
	store   $f6, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	fmul    $f1, $f1, $f3
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [$i21 + 10], $i1
	fadd    $f3, $f2, $f2
	load    [ext_nvector + 2], $f4
	fmul    $f4, $f4, $f4
	fadd    $f2, $f4, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22604
be.22604:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
.count move_args
	mov     $i21, $i2
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22604:
.count move_args
	mov     $i21, $i2
	be      $i1, 0, be.22605
bne.22605:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
be.22605:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
be.22599:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
.count move_args
	mov     $i21, $i2
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	load    [$i16 + $i1], $f1
	bne     $f1, $f0, bne.22600
be.22600:
	store   $f0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22600:
	ble     $f1, $f0, ble.22601
bg.22601:
	store   $fc15, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
.count dual_jmp
	b       bg.22606
ble.22601:
	store   $fc0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f17, $f15
	ble     $fc3, $f1, ble.22606
bg.22606:
	li      0, $i1
.count storer
	add     $i3, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.22001], $f2
	load    [$i16 + 0], $f3
	fmul    $f3, $f1, $f6
	load    [$i16 + 1], $f4
	load    [ext_nvector + 1], $f5
	load    [$i16 + 2], $f7
	fmul    $f4, $f5, $f4
	load    [ext_nvector + 2], $f5
	fmul    $f7, $f5, $f5
	fadd    $f6, $f4, $f4
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i16 + 1], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 1]
	load    [ext_nvector + 2], $f1
	load    [$i16 + 2], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 2]
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22607
.count dual_jmp
	b       bne.22607
ble.22606:
	li      1, $i1
.count storer
	add     $i3, $i18, $tmp
	add     $i19, 18, $i2
	store   $i1, [$tmp + 0]
	load    [$i2 + $i18], $i1
	add     $i19, 29, $i3
.count load_float
	load    [f.22000], $f1
	fmul    $f1, $f15, $f1
	store   $fg16, [$i1 + 0]
	store   $fg11, [$i1 + 1]
	store   $fg15, [$i1 + 2]
	load    [$i2 + $i18], $i1
	load    [$i1 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i1 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i3 + $i18], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.22001], $f2
	load    [$i16 + 0], $f3
	fmul    $f3, $f1, $f6
	load    [$i16 + 1], $f4
	load    [ext_nvector + 1], $f5
	load    [$i16 + 2], $f7
	fmul    $f4, $f5, $f4
	load    [ext_nvector + 2], $f5
	fmul    $f7, $f5, $f5
	fadd    $f6, $f4, $f4
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i16 + 1], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 1]
	load    [ext_nvector + 2], $f1
	load    [$i16 + 2], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 2]
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22607
bne.22607:
	be      $i1, 99, bne.22612
bne.22608:
	call    solver_fast.2796
	be      $i1, 0, be.22621
bne.22609:
	ble     $fc4, $fg0, be.22621
bg.22610:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22621
bne.22611:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22612
be.22612:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22621
bne.22613:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22612
be.22614:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22621
bne.22612:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22621
bne.22617:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22618
be.22618:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22621
bne.22619:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22618
be.22620:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22621
bne.22618:
	load    [$i21 + 12], $f1
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	fmul    $f17, $f1, $f16
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f17, $fc6, bg.22585
.count dual_jmp
	b       bg.22625
be.22621:
	li      1, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i21 + 12], $f1
	fmul    $f17, $f1, $f16
	bne     $i1, 0, bne.22622
be.22622:
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $fg12, $f2
	fmul    $f3, $fg13, $f3
	load    [$i16 + 0], $f4
	load    [$i16 + 1], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f6
	fmul    $f4, $fg14, $f2
	fmul    $f5, $fg12, $f4
	fmul    $f6, $fg13, $f5
	fadd_n  $f1, $f3, $f1
	fadd    $f2, $f4, $f2
	fmul    $f1, $f15, $f1
	fadd_n  $f2, $f5, $f2
	ble     $f1, $f0, ble.22623
.count dual_jmp
	b       bg.22623
be.22607:
	load    [$i21 + 12], $f1
	fmul    $f17, $f1, $f16
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $fg13, $f3
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [$i16 + 0], $f4
	fadd    $f1, $f2, $f1
	load    [$i16 + 1], $f5
	fmul    $f4, $fg14, $f2
	load    [$i16 + 2], $f6
	fmul    $f5, $fg12, $f4
	fmul    $f6, $fg13, $f5
	fadd_n  $f1, $f3, $f1
	fadd    $f2, $f4, $f2
	fmul    $f1, $f15, $f1
	fadd_n  $f2, $f5, $f2
	ble     $f1, $f0, ble.22623
bg.22623:
	fmul    $f1, $fg16, $f3
	fmul    $f1, $fg11, $f4
	fmul    $f1, $fg15, $f1
	fadd    $fg4, $f3, $fg4
	fadd    $fg5, $f4, $fg5
	fadd    $fg6, $f1, $fg6
	ble     $f2, $f0, bne.22622
.count dual_jmp
	b       bg.22624
ble.22623:
	ble     $f2, $f0, bne.22622
bg.22624:
	fmul    $f2, $f2, $f1
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	fmul    $f1, $f1, $f1
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	call    setup_startp_constants.2831
	add     $ig4, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f17, $fc6, bg.22585
.count dual_jmp
	b       bg.22625
bne.22622:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	add     $ig0, -1, $i1
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	call    setup_startp_constants.2831
	add     $ig4, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f17, $fc6, bg.22585
bg.22625:
	bge     $i18, 4, bge.22626
bl.22626:
	add     $i18, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i20, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i21 + 2], $i1
	be      $i1, 2, be.22627
.count dual_jmp
	b       bg.22585
bge.22626:
	load    [$i21 + 2], $i1
	be      $i1, 2, be.22627
bg.22585:
	jr      $ra5
be.22627:
	load    [$i21 + 11], $f1
	fadd    $f18, $fg7, $f18
	add     $i18, 1, $i18
	fsub    $fc0, $f1, $f1
	fmul    $f17, $f1, $f17
	b       trace_ray.2920
.end trace_ray

######################################################################
# trace_diffuse_ray($i8, $f15)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	load    [$ig1 + 0], $i12
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22628
be.22628:
	ble     $fg7, $fc4, bne.22657
.count dual_jmp
	b       bg.22636
bne.22628:
	be      $i1, 99, be.22629
bne.22629:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22635
bne.22634:
	ble     $fg7, $fg0, ble.22635
bg.22635:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22657
.count dual_jmp
	b       bg.22636
be.22629:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22635
bne.22630:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22635
bne.22631:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22635
bne.22632:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22635
bne.22633:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22657
.count dual_jmp
	b       bg.22636
ble.22635:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22657
bg.22636:
	ble     $fc9, $fg7, bne.22657
bg.22637:
	load    [ext_objects + $ig3], $i12
	load    [$i12 + 1], $i1
	be      $i1, 1, be.22639
bne.22639:
	load    [$i12 + 4], $f1
	bne     $i1, 2, bne.22642
be.22642:
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
.count move_args
	mov     $i12, $i2
	load    [$i12 + 5], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i12 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22642:
	load    [$i12 + 3], $i1
	load    [ext_intersection_point + 0], $f2
	load    [$i12 + 7], $f3
	load    [$i12 + 5], $f4
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 1], $f5
	fmul    $f2, $f1, $f1
	load    [$i12 + 8], $f3
	fsub    $f5, $f3, $f3
	load    [$i12 + 6], $f6
	fmul    $f3, $f4, $f4
	load    [ext_intersection_point + 2], $f7
	load    [$i12 + 9], $f8
	fsub    $f7, $f8, $f5
	fmul    $f5, $f6, $f6
	be      $i1, 0, be.22643
bne.22643:
	load    [$i12 + 18], $f7
	load    [$i12 + 17], $f8
	fmul    $f3, $f7, $f7
	fmul    $f5, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i12 + 18], $f1
	load    [$i12 + 16], $f7
	fmul    $f2, $f1, $f1
	fmul    $f5, $f7, $f5
	fadd    $f1, $f5, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i12 + 17], $f1
	load    [$i12 + 16], $f4
	fmul    $f2, $f1, $f1
	fmul    $f3, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f6, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f3
	load    [$i12 + 10], $i1
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 2], $f4
	fmul    $f4, $f4, $f4
	fadd    $f3, $f2, $f2
	fadd    $f2, $f4, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22644
.count dual_jmp
	b       bne.22644
be.22643:
	store   $f1, [ext_nvector + 0]
	store   $f4, [ext_nvector + 1]
	store   $f6, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	fmul    $f1, $f1, $f3
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [$i12 + 10], $i1
	fadd    $f3, $f2, $f2
	load    [ext_nvector + 2], $f4
	fmul    $f4, $f4, $f4
	fadd    $f2, $f4, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22644
be.22644:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
.count move_args
	mov     $i12, $i2
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22644:
.count move_args
	mov     $i12, $i2
	be      $i1, 0, be.22645
bne.22645:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
be.22645:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
be.22639:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
.count move_args
	mov     $i12, $i2
	store   $f0, [ext_nvector + 2]
	load    [$i8 + $i1], $f1
	bne     $f1, $f0, bne.22640
be.22640:
	store   $f0, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22640:
	ble     $f1, $f0, ble.22641
bg.22641:
	store   $fc15, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
ble.22641:
	store   $fc0, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22661
bne.22646:
	be      $i1, 99, bne.22651
bne.22647:
	call    solver_fast.2796
	be      $i1, 0, be.22660
bne.22648:
	ble     $fc4, $fg0, be.22660
bg.22649:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22660
bne.22650:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22651
be.22651:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22660
bne.22652:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22651
be.22653:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22660
bne.22651:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22660
bne.22656:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22657
be.22657:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22660
bne.22658:
	li      0, $i7
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22657
be.22659:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22657
be.22660:
	li      1, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22657
be.22661:
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $fg12, $f2
	fmul    $f3, $fg13, $f3
	fadd    $f1, $f2, $f1
	load    [$i12 + 11], $f2
	fadd_n  $f1, $f3, $f1
	ble     $f1, $f0, ble.22662
bg.22662:
	fmul    $f15, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fmul    $f1, $fg11, $f3
	fmul    $f1, $fg15, $f1
	fadd    $fg1, $f2, $fg1
	fadd    $fg2, $f3, $fg2
	fadd    $fg3, $f1, $fg3
	jr      $ra4
ble.22662:
	mov     $f0, $f1
	fmul    $f15, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fmul    $f1, $fg11, $f3
	fmul    $f1, $fg15, $f1
	fadd    $fg1, $f2, $fg1
	fadd    $fg2, $f3, $fg2
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bne.22657:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i15, $i16, $i17)
# $ra = $ra5
# [$i1 - $i14, $i17]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.align 2
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i17, 0, bl.22663
bge.22663:
	load    [$i15 + $i17], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22664
bg.22664:
	add     $i17, 1, $i1
	fmul    $f1, $fc2, $f15
	load    [$i15 + $i1], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	bge     $i17, 0, bge.22667
.count dual_jmp
	b       bl.22663
ble.22664:
	fmul    $f1, $fc1, $f15
	load    [$i15 + $i17], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	bl      $i17, 0, bl.22663
bge.22667:
	load    [$i15 + $i17], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22668
bg.22668:
	add     $i17, 1, $i1
	fmul    $f1, $fc2, $f15
	load    [$i15 + $i1], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	b       iter_trace_diffuse_rays.2929
ble.22668:
	fmul    $f1, $fc1, $f15
	load    [$i15 + $i17], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	b       iter_trace_diffuse_rays.2929
bl.22663:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i18, $i19)
# $ra = $ra6
# [$i1 - $i17, $i20 - $i21]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	add     $i18, 23, $i1
	load    [$i1 + $i19], $i1
	add     $i18, 29, $i2
	load    [$i2 + $i19], $i16
	add     $i18, 3, $i3
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i3 + $i19], $i20
	load    [$i18 + 28], $i21
	bne     $i21, 0, bne.22669
be.22669:
	be      $i21, 1, be.22671
.count dual_jmp
	b       bne.22671
bne.22669:
	load    [ext_dirvecs + 0], $i15
	load    [$i20 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i20 + 1], $fg9
.count move_args
	mov     $i20, $i2
	load    [$i20 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22670
bg.22670:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 1, be.22671
.count dual_jmp
	b       bne.22671
ble.22670:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 1, bne.22671
be.22671:
	be      $i21, 2, be.22673
.count dual_jmp
	b       bne.22673
bne.22671:
	load    [ext_dirvecs + 1], $i15
	add     $ig0, -1, $i1
	load    [$i20 + 0], $fg8
.count move_args
	mov     $i20, $i2
	load    [$i20 + 1], $fg9
	load    [$i20 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22672
bg.22672:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 2, be.22673
.count dual_jmp
	b       bne.22673
ble.22672:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 2, bne.22673
be.22673:
	be      $i21, 3, be.22675
.count dual_jmp
	b       bne.22675
bne.22673:
	load    [ext_dirvecs + 2], $i15
	load    [$i20 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i20 + 1], $fg9
.count move_args
	mov     $i20, $i2
	load    [$i20 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22674
bg.22674:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 3, be.22675
.count dual_jmp
	b       bne.22675
ble.22674:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 3, bne.22675
be.22675:
	be      $i21, 4, be.22677
.count dual_jmp
	b       bne.22677
bne.22675:
	load    [ext_dirvecs + 3], $i15
	add     $ig0, -1, $i1
	load    [$i20 + 0], $fg8
.count move_args
	mov     $i20, $i2
	load    [$i20 + 1], $fg9
	load    [$i20 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22676
bg.22676:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 4, be.22677
.count dual_jmp
	b       bne.22677
ble.22676:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 4, be.22677
bne.22677:
	load    [ext_dirvecs + 4], $i15
	load    [$i20 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i20 + 1], $fg9
.count move_args
	mov     $i20, $i2
	load    [$i20 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22678
bg.22678:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 18, $i1
	load    [$i1 + $i19], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg2, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	jr      $ra6
ble.22678:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 18, $i1
	load    [$i1 + $i19], $i1
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg1, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg2, $f2
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	jr      $ra6
be.22677:
	add     $i18, 18, $i1
	load    [$i1 + $i19], $i1
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg1, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg2, $f2
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	jr      $ra6
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i18, $i22)
# $ra = $ra7
# [$i1 - $i17, $i19 - $i23]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i22, 4, bg.22679
ble.22679:
	add     $i18, 8, $i19
	load    [$i19 + $i22], $i1
	bl      $i1, 0, bg.22679
bge.22680:
	add     $i18, 13, $i20
	load    [$i20 + $i22], $i1
	bne     $i1, 0, bne.22681
be.22681:
	add     $i22, 1, $i1
	bg      $i1, 4, bg.22679
ble.22682:
	load    [$i19 + $i1], $i2
	bl      $i2, 0, bg.22679
bge.22683:
	load    [$i20 + $i1], $i2
	be      $i2, 0, be.22697
bne.22684:
.count move_args
	mov     $i1, $i19
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
bne.22681:
	add     $i18, 23, $i1
	add     $i18, 29, $i2
	load    [$i1 + $i22], $i1
	add     $i18, 3, $i3
	load    [$i2 + $i22], $i16
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i3 + $i22], $i21
	load    [$i18 + 28], $i23
	bne     $i23, 0, bne.22685
be.22685:
	be      $i23, 1, be.22687
.count dual_jmp
	b       bne.22687
bne.22685:
	load    [ext_dirvecs + 0], $i15
	add     $ig0, -1, $i1
	load    [$i21 + 0], $fg8
.count move_args
	mov     $i21, $i2
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22686
bg.22686:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i23, 1, be.22687
.count dual_jmp
	b       bne.22687
ble.22686:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i23, 1, bne.22687
be.22687:
	be      $i23, 2, be.22689
.count dual_jmp
	b       bne.22689
bne.22687:
	load    [ext_dirvecs + 1], $i15
	load    [$i21 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i21 + 1], $fg9
.count move_args
	mov     $i21, $i2
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22688
bg.22688:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i23, 2, be.22689
.count dual_jmp
	b       bne.22689
ble.22688:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i23, 2, bne.22689
be.22689:
	be      $i23, 3, be.22691
.count dual_jmp
	b       bne.22691
bne.22689:
	load    [ext_dirvecs + 2], $i15
	add     $ig0, -1, $i1
	load    [$i21 + 0], $fg8
.count move_args
	mov     $i21, $i2
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22690
bg.22690:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i23, 3, be.22691
.count dual_jmp
	b       bne.22691
ble.22690:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i23, 3, bne.22691
be.22691:
	be      $i23, 4, be.22693
.count dual_jmp
	b       bne.22693
bne.22691:
	load    [ext_dirvecs + 3], $i15
	load    [$i21 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i21 + 1], $fg9
.count move_args
	mov     $i21, $i2
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22692
bg.22692:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i23, 4, be.22693
.count dual_jmp
	b       bne.22693
ble.22692:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i23, 4, bne.22693
be.22693:
	add     $i18, 18, $i1
	load    [$i1 + $i22], $i1
	add     $i22, 1, $i2
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg1, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg2, $f2
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	ble     $i2, 4, ble.22695
.count dual_jmp
	b       bg.22679
bne.22693:
	load    [ext_dirvecs + 4], $i15
	add     $ig0, -1, $i1
	load    [$i21 + 0], $fg8
.count move_args
	mov     $i21, $i2
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 2], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22694
bg.22694:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 18, $i1
	add     $i22, 1, $i2
	load    [$i1 + $i22], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg2, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	ble     $i2, 4, ble.22695
.count dual_jmp
	b       bg.22679
ble.22694:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 18, $i1
	load    [$i1 + $i22], $i1
	add     $i22, 1, $i2
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg1, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg2, $f2
	fmul    $f3, $fg3, $f3
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	bg      $i2, 4, bg.22679
ble.22695:
	load    [$i19 + $i2], $i1
	bl      $i1, 0, bg.22679
bge.22696:
	load    [$i20 + $i2], $i1
	be      $i1, 0, be.22697
bne.22697:
.count move_args
	mov     $i2, $i19
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
be.22697:
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
bg.22679:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i19)
# $ra = $ra7
# [$i1 - $i23]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i19, 4, bg.22698
ble.22698:
	load    [$i4 + $i2], $i1
	add     $i1, 8, $i6
	load    [$i6 + $i19], $i6
	bl      $i6, 0, bg.22698
bge.22699:
	load    [$i3 + $i2], $i7
	add     $i7, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22700
be.22700:
	load    [$i5 + $i2], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22700
be.22701:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22700
be.22702:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	be      $i8, $i6, be.22703
bne.22700:
	bg      $i19, 4, bg.22698
ble.22705:
	load    [$i4 + $i2], $i18
	add     $i18, 8, $i1
	load    [$i1 + $i19], $i1
	bl      $i1, 0, bg.22698
bge.22706:
	add     $i18, 13, $i1
	load    [$i1 + $i19], $i1
	be      $i1, 0, be.22707
bne.22707:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i19, 1, $i22
	b       do_without_neighbors.2951
be.22707:
	add     $i19, 1, $i22
	b       do_without_neighbors.2951
bg.22698:
	jr      $ra7
be.22703:
	add     $i1, 13, $i1
	load    [$i1 + $i19], $i1
	be      $i1, 0, be.22708
bne.22708:
	add     $i2, -1, $i1
	load    [$i4 + $i1], $i1
	add     $i7, 23, $i6
	load    [$i6 + $i19], $i6
	load    [$i4 + $i2], $i7
	add     $i1, 23, $i1
	load    [$i6 + 0], $fg1
	load    [$i1 + $i19], $i1
	load    [$i6 + 1], $fg2
	load    [$i6 + 2], $fg3
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f2
	fadd    $fg2, $f2, $fg2
	load    [$i1 + 2], $f3
	fadd    $fg3, $f3, $fg3
	add     $i7, 23, $i1
	load    [$i1 + $i19], $i1
	add     $i2, 1, $i6
	load    [$i4 + $i6], $i6
	load    [$i5 + $i2], $i7
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 2], $f3
	add     $i6, 23, $i1
	load    [$i1 + $i19], $i1
	fadd    $fg2, $f2, $fg2
	fadd    $fg3, $f3, $fg3
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 2], $f3
	add     $i7, 23, $i1
	fadd    $fg2, $f2, $fg2
	load    [$i1 + $i19], $i1
	fadd    $fg3, $f3, $fg3
	load    [$i4 + $i2], $i6
	add     $i19, 1, $i7
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 2], $f3
	add     $i6, 18, $i1
	load    [$i1 + $i19], $i1
	fadd    $fg2, $f2, $fg2
	fadd    $fg3, $f3, $fg3
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg1, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg2, $f2
	fmul    $f3, $fg3, $f3
.count move_args
	mov     $i7, $i19
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	b       try_exploit_neighbors.2967
be.22708:
	add     $i19, 1, $i19
	b       try_exploit_neighbors.2967
.end try_exploit_neighbors

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
# [$ra]
######################################################################
.align 2
.begin write_rgb_element
write_rgb_element.2976:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
	li      255, $i4
	call    ext_int_of_float
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bg      $i1, $i4, bg.22711
ble.22711:
	bge     $i1, 0, bge.22712
bl.22712:
	li      0, $i2
	b       ext_write
bge.22712:
.count move_args
	mov     $i1, $i2
	b       ext_write
bg.22711:
	li      255, $i2
	b       ext_write
.end write_rgb_element

######################################################################
# write_rgb()
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
# [$ra]
######################################################################
.align 2
.begin write_rgb
write_rgb.2978:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
.count move_args
	mov     $fg4, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg5, $f2
	call    write_rgb_element.2976
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
.count move_args
	mov     $fg6, $f2
	b       write_rgb_element.2976
.end write_rgb

######################################################################
# pretrace_diffuse_rays($i18, $i19)
# $ra = $ra6
# [$i1 - $i17, $i19 - $i25]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i19, 4, bg.22715
ble.22715:
	add     $i18, 8, $i20
	load    [$i20 + $i19], $i1
	bl      $i1, 0, bg.22715
bge.22716:
	add     $i18, 13, $i21
	load    [$i21 + $i19], $i1
	bne     $i1, 0, bne.22717
be.22717:
	add     $i19, 1, $i22
	bg      $i22, 4, bg.22715
ble.22718:
	load    [$i20 + $i22], $i1
	bl      $i1, 0, bg.22715
bge.22719:
	load    [$i21 + $i22], $i1
	be      $i1, 0, be.22725
bne.22720:
	add     $i18, 3, $i1
	mov     $f0, $fg1
	load    [$i1 + $i22], $i2
	mov     $f0, $fg2
	add     $i18, 29, $i6
	mov     $f0, $fg3
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	add     $ig0, -1, $i1
	load    [$i2 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i18 + 28], $i1
	load    [$i6 + $i22], $i16
	load    [ext_dirvecs + $i1], $i15
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f3
	load    [$i1 + 0], $f4
	load    [$i1 + 1], $f5
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f6
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22721
bg.22721:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 23, $i1
	add     $i19, 2, $i19
	load    [$i1 + $i22], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
ble.22721:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 23, $i1
	add     $i19, 2, $i19
	load    [$i1 + $i22], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
bne.22717:
	add     $i18, 3, $i22
	mov     $f0, $fg1
	load    [$i22 + $i19], $i2
	mov     $f0, $fg2
	mov     $f0, $fg3
	add     $i18, 29, $i23
	load    [$i2 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i18 + 28], $i1
	load    [$i23 + $i19], $i16
	load    [ext_dirvecs + $i1], $i15
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 2], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22722
bg.22722:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 23, $i24
	load    [$i24 + $i19], $i1
	add     $i19, 1, $i25
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	ble     $i25, 4, ble.22723
.count dual_jmp
	b       bg.22715
ble.22722:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i18, 23, $i24
	add     $i19, 1, $i25
	load    [$i24 + $i19], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	bg      $i25, 4, bg.22715
ble.22723:
	load    [$i20 + $i25], $i1
	bl      $i1, 0, bg.22715
bge.22724:
	load    [$i21 + $i25], $i1
	be      $i1, 0, be.22725
bne.22725:
	load    [$i22 + $i25], $i2
	mov     $f0, $fg1
	mov     $f0, $fg2
	load    [$i2 + 0], $fg8
	mov     $f0, $fg3
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i18 + 28], $i1
	load    [$i23 + $i25], $i16
	load    [ext_dirvecs + $i1], $i15
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 2], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22726
bg.22726:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i24 + $i25], $i1
	add     $i19, 2, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
ble.22726:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i24 + $i25], $i1
	add     $i19, 2, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
be.22725:
	add     $i19, 2, $i19
	b       pretrace_diffuse_rays.2980
bg.22715:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i26, $i27, $i28, $f19, $f20, $f21)
# $ra = $ra7
# [$i1 - $i25, $i27 - $i28]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.align 2
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i27, 0, bl.22727
bge.22727:
	load    [ext_screenx_dir + 0], $f4
	add     $i27, -64, $i2
	call    ext_float_of_int
	fmul    $f1, $f4, $f2
	li      0, $i18
.count move_args
	mov     $f0, $f18
	li      ext_ptrace_dirvec, $i16
.count move_args
	mov     $fc0, $f17
	fadd    $f2, $f19, $f2
	mov     $f0, $fg6
	store   $f2, [ext_ptrace_dirvec + 0]
	mov     $f0, $fg5
	store   $f20, [ext_ptrace_dirvec + 1]
	mov     $f0, $fg4
	load    [ext_screenx_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $f21, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_ptrace_dirvec + 0], $f1
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f1, $f1, $f4
	load    [ext_ptrace_dirvec + 2], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22728
bne.22728:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_viewpoint + 0], $fg17
	load    [ext_viewpoint + 1], $fg18
	load    [ext_viewpoint + 2], $fg19
	load    [$i26 + $i27], $i19
	jal     trace_ray.2920, $ra5
	load    [$i26 + $i27], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i26 + $i27], $i1
	store   $i28, [$i1 + 28]
	load    [$i26 + $i27], $i18
	load    [$i18 + 8], $i1
	bge     $i1, 0, bge.22729
.count dual_jmp
	b       bl.22729
be.22728:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_viewpoint + 0], $fg17
	load    [ext_viewpoint + 1], $fg18
	load    [ext_viewpoint + 2], $fg19
	load    [$i26 + $i27], $i19
	jal     trace_ray.2920, $ra5
	load    [$i26 + $i27], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i26 + $i27], $i1
	store   $i28, [$i1 + 28]
	load    [$i26 + $i27], $i18
	load    [$i18 + 8], $i1
	bge     $i1, 0, bge.22729
bl.22729:
	add     $i28, 1, $i1
	add     $i27, -1, $i27
	bge     $i1, 5, bge.22732
.count dual_jmp
	b       bl.22732
bge.22729:
	load    [$i18 + 13], $i1
	bne     $i1, 0, bne.22730
be.22730:
	li      1, $i19
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, 1, $i1
	add     $i27, -1, $i27
	bge     $i1, 5, bge.22732
.count dual_jmp
	b       bl.22732
bne.22730:
	load    [$i18 + 28], $i1
	mov     $f0, $fg1
	load    [$i18 + 3], $i2
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [ext_dirvecs + $i1], $i15
	load    [$i18 + 29], $i16
	add     $ig0, -1, $i1
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 0], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 0], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f4, $f2, $f2
	load    [$i16 + 2], $f3
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.22731
bg.22731:
	fmul    $f1, $fc2, $f15
	load    [$i15 + 119], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i18 + 23], $i1
	li      1, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, 1, $i1
	add     $i27, -1, $i27
	bge     $i1, 5, bge.22732
.count dual_jmp
	b       bl.22732
ble.22731:
	fmul    $f1, $fc1, $f15
	load    [$i15 + 118], $i8
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i18 + 23], $i1
	li      1, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, 1, $i1
	add     $i27, -1, $i27
	bge     $i1, 5, bge.22732
bl.22732:
.count move_args
	mov     $i1, $i28
	b       pretrace_pixels.2983
bge.22732:
	add     $i28, -4, $i28
	b       pretrace_pixels.2983
bl.22727:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i24, $i25, $i26, $i27, $i28)
# $ra = $ra8
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.align 2
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	ble     $i1, $i24, ble.22733
bg.22733:
	load    [$i27 + $i24], $i1
	li      128, $i2
	add     $i25, 1, $i3
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	ble     $i2, $i3, ble.22736
bg.22734:
	ble     $i25, 0, ble.22736
bg.22735:
	li      128, $i1
	add     $i24, 1, $i2
	ble     $i1, $i2, ble.22736
bg.22736:
	li      0, $i19
	ble     $i24, 0, bne.22742
bg.22737:
	load    [$i27 + $i24], $i1
	load    [$i1 + 8], $i2
	bl      $i2, 0, bl.22741
bge.22741:
	load    [$i26 + $i24], $i3
	load    [$i3 + 8], $i4
	bne     $i4, $i2, bne.22742
be.22742:
	load    [$i28 + $i24], $i4
	load    [$i4 + 8], $i4
	bne     $i4, $i2, bne.22742
be.22743:
	add     $i24, -1, $i4
	load    [$i27 + $i4], $i4
	load    [$i4 + 8], $i4
	bne     $i4, $i2, bne.22742
be.22744:
	add     $i24, 1, $i4
	load    [$i27 + $i4], $i4
	load    [$i4 + 8], $i4
	be      $i4, $i2, be.22745
bne.22742:
	load    [$i27 + $i24], $i18
	load    [$i18 + 8], $i1
	bge     $i1, 0, bge.22747
.count dual_jmp
	b       bl.22741
be.22745:
	load    [$i1 + 13], $i1
.count move_args
	mov     $i28, $i5
.count move_args
	mov     $i27, $i4
	li      1, $i19
	be      $i1, 0, be.22749
bne.22749:
	add     $i24, -1, $i1
	load    [$i3 + 23], $i2
	load    [$i27 + $i1], $i1
	load    [$i27 + $i24], $i3
	load    [$i2 + 0], $fg1
	load    [$i1 + 23], $i1
	load    [$i2 + 1], $fg2
	load    [$i2 + 2], $fg3
	add     $i24, 1, $i2
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f2
	fadd    $fg2, $f2, $fg2
	load    [$i1 + 2], $f3
	fadd    $fg3, $f3, $fg3
	load    [$i3 + 23], $i1
	load    [$i28 + $i24], $i3
	load    [$i27 + $i2], $i2
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 2], $f3
	fadd    $fg2, $f2, $fg2
	load    [$i2 + 23], $i1
	fadd    $fg3, $f3, $fg3
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f2
	fadd    $fg2, $f2, $fg2
	load    [$i1 + 2], $f3
	fadd    $fg3, $f3, $fg3
	load    [$i3 + 23], $i1
.count move_args
	mov     $i26, $i3
	load    [$i27 + $i24], $i2
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 2], $f3
	fadd    $fg2, $f2, $fg2
	load    [$i2 + 18], $i1
	fadd    $fg3, $f3, $fg3
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg2, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg3, $f3
.count move_args
	mov     $i24, $i2
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f2, $fg5
	fadd    $fg6, $f3, $fg6
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
be.22749:
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
ble.22736:
	load    [$i27 + $i24], $i18
	li      0, $i19
	load    [$i18 + 8], $i1
	bl      $i1, 0, bl.22741
bge.22747:
	load    [$i18 + 13], $i1
	be      $i1, 0, be.22748
bne.22748:
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i22
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
be.22748:
	li      1, $i22
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
bl.22741:
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
ble.22733:
	jr      $ra8
.end scan_pixel

######################################################################
# scan_line($i29, $i30, $i31, $i32, $i33)
# $ra = $ra9
# [$i1 - $i33]
# [$f1 - $f21]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.align 2
.begin scan_line
scan_line.3000:
	li      128, $i1
	ble     $i1, $i29, ble.22750
bg.22750:
	bge     $i29, 127, bge.22751
bl.22751:
	add     $i29, -63, $i2
	call    ext_float_of_int
	load    [ext_screeny_dir + 0], $f2
	load    [ext_screeny_dir + 1], $f3
	fmul    $f1, $f2, $f2
	load    [ext_screeny_dir + 2], $f4
	fmul    $f1, $f3, $f3
	fmul    $f1, $f4, $f1
	load    [ext_screenz_dir + 2], $f4
	li      127, $i27
	fadd    $f2, $fg20, $f19
	fadd    $f3, $fg21, $f20
.count move_args
	mov     $i32, $i26
	fadd    $f1, $f4, $f21
.count move_args
	mov     $i33, $i28
	jal     pretrace_pixels.2983, $ra7
	li      0, $i24
.count move_args
	mov     $i29, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
.count move_args
	mov     $i32, $i28
	jal     scan_pixel.2994, $ra8
	add     $i33, 2, $i1
	add     $i29, 1, $i29
	bge     $i1, 5, bge.22752
.count dual_jmp
	b       bl.22752
bge.22751:
	li      0, $i24
.count move_args
	mov     $i29, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
.count move_args
	mov     $i32, $i28
	jal     scan_pixel.2994, $ra8
	add     $i33, 2, $i1
	add     $i29, 1, $i29
	bge     $i1, 5, bge.22752
bl.22752:
.count move_args
	mov     $i30, $tmp
.count move_args
	mov     $i1, $i33
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $i32, $i31
.count move_args
	mov     $tmp, $i32
	b       scan_line.3000
bge.22752:
.count move_args
	mov     $i30, $tmp
	add     $i33, -3, $i33
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $i32, $i31
.count move_args
	mov     $tmp, $i32
	b       scan_line.3000
ble.22750:
	jr      $ra9
.end scan_line

######################################################################
# $i1 = create_float5x3array()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
# [$ra]
######################################################################
.align 2
.begin create_float5x3array
create_float5x3array.3006:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count move_args
	mov     $f0, $f2
	li      3, $i2
	call    ext_create_array_float
	store   $i1, [$i4 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i4 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i4 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i4 + 4]
	mov     $i4, $i1
	jr      $ra1
.end create_float5x3array

######################################################################
# $i1 = create_pixel()
# $ra = $ra2
# [$i1 - $i11]
# [$f2]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin create_pixel
create_pixel.3008:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i5
	jal     create_float5x3array.3006, $ra1
.count move_ret
	mov     $i1, $i6
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	jal     create_float5x3array.3006, $ra1
.count move_ret
	mov     $i1, $i9
	jal     create_float5x3array.3006, $ra1
.count move_ret
	mov     $i1, $i10
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	jal     create_float5x3array.3006, $ra1
	load    [$i5 + 0], $i2
	mov     $hp, $i3
	store   $i2, [$i3 + 0]
	add     $hp, 34, $hp
	load    [$i5 + 1], $i2
	store   $i2, [$i3 + 1]
	load    [$i5 + 2], $i2
	store   $i2, [$i3 + 2]
	load    [$i6 + 0], $i2
	store   $i2, [$i3 + 3]
	load    [$i6 + 1], $i2
	store   $i2, [$i3 + 4]
	load    [$i6 + 2], $i2
	store   $i2, [$i3 + 5]
	load    [$i6 + 3], $i2
	store   $i2, [$i3 + 6]
	load    [$i6 + 4], $i2
	store   $i2, [$i3 + 7]
	load    [$i7 + 0], $i2
	store   $i2, [$i3 + 8]
	load    [$i7 + 1], $i2
	store   $i2, [$i3 + 9]
	load    [$i7 + 2], $i2
	store   $i2, [$i3 + 10]
	load    [$i7 + 3], $i2
	store   $i2, [$i3 + 11]
	load    [$i7 + 4], $i2
	store   $i2, [$i3 + 12]
	load    [$i8 + 0], $i2
	store   $i2, [$i3 + 13]
	load    [$i8 + 1], $i2
	store   $i2, [$i3 + 14]
	load    [$i8 + 2], $i2
	store   $i2, [$i3 + 15]
	load    [$i8 + 3], $i2
	store   $i2, [$i3 + 16]
	load    [$i8 + 4], $i2
	store   $i2, [$i3 + 17]
	load    [$i9 + 0], $i2
	store   $i2, [$i3 + 18]
	load    [$i9 + 1], $i2
	store   $i2, [$i3 + 19]
	load    [$i9 + 2], $i2
	store   $i2, [$i3 + 20]
	load    [$i9 + 3], $i2
	store   $i2, [$i3 + 21]
	load    [$i9 + 4], $i2
	store   $i2, [$i3 + 22]
	load    [$i10 + 0], $i2
	store   $i2, [$i3 + 23]
	load    [$i10 + 1], $i2
	store   $i2, [$i3 + 24]
	load    [$i10 + 2], $i2
	store   $i2, [$i3 + 25]
	load    [$i10 + 3], $i2
	store   $i2, [$i3 + 26]
	load    [$i10 + 4], $i2
	store   $i2, [$i3 + 27]
	load    [$i11 + 0], $i2
	store   $i2, [$i3 + 28]
	load    [$i1 + 0], $i2
	store   $i2, [$i3 + 29]
	load    [$i1 + 1], $i2
	store   $i2, [$i3 + 30]
	load    [$i1 + 2], $i2
	store   $i2, [$i3 + 31]
	load    [$i1 + 3], $i2
	add     $i3, 29, $i1
	store   $i2, [$i3 + 32]
	store   $i1, [$i3 + 33]
	mov     $i3, $i1
	jr      $ra2
.end create_pixel

######################################################################
# $i1 = init_line_elements($i12, $i13)
# $ra = $ra3
# [$i1 - $i11, $i13]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_line_elements
init_line_elements.3010:
	bge     $i13, 0, bge.22753
bl.22753:
	mov     $i12, $i1
	jr      $ra3
bge.22753:
	jal     create_pixel.3008, $ra2
	add     $i13, -1, $i2
.count storer
	add     $i12, $i13, $tmp
.count move_args
	mov     $i2, $i13
	store   $i1, [$tmp + 0]
	b       init_line_elements.3010
.end init_line_elements

######################################################################
# $i1 = create_pixelline()
# $ra = $ra3
# [$i1 - $i13]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin create_pixelline
create_pixelline.3013:
	jal     create_pixel.3008, $ra2
	li      128, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	li      126, $i13
.count move_args
	mov     $i1, $i12
	b       init_line_elements.3010
.end create_pixelline

######################################################################
# calc_dirvec($i2, $f1, $f2, $f8, $f9, $i3, $i4)
# $ra = $ra1
# [$i1 - $i7]
# [$f1 - $f7, $f10 - $f13]
# []
# []
# [$ra]
######################################################################
.align 2
.begin calc_dirvec
calc_dirvec.3020:
	bge     $i2, 5, bge.22754
bl.22754:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc6, $f1
	fsqrt   $f1, $f10
	finv    $f10, $f2
	call    ext_atan
	fmul    $f1, $f8, $f11
.count move_args
	mov     $f11, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f12
.count move_args
	mov     $f11, $f2
	call    ext_cos
	finv    $f1, $f1
	fmul    $f12, $f1, $f1
	fmul    $f1, $f10, $f10
	fmul    $f10, $f10, $f1
	fadd    $f1, $fc6, $f1
	fsqrt   $f1, $f11
	finv    $f11, $f2
	call    ext_atan
	fmul    $f1, $f9, $f12
.count move_args
	mov     $f12, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f13
.count move_args
	mov     $f12, $f2
	call    ext_cos
	finv    $f1, $f1
	add     $i2, 1, $i2
	fmul    $f13, $f1, $f1
	fmul    $f1, $f11, $f2
.count move_args
	mov     $f10, $f1
	b       calc_dirvec.3020
bge.22754:
	load    [ext_dirvecs + $i3], $i1
	fmul    $f1, $f1, $f3
	fmul    $f2, $f2, $f4
	load    [$i1 + $i4], $i2
	add     $i4, 40, $i3
	fadd    $f3, $f4, $f3
	add     $i4, 80, $i5
	fadd    $f3, $fc0, $f3
	add     $i4, 1, $i6
	fsqrt   $f3, $f3
	add     $i4, 41, $i7
	finv    $f3, $f3
	add     $i4, 81, $i4
	fmul    $f1, $f3, $f1
	fmul    $f2, $f3, $f2
	store   $f1, [$i2 + 0]
	fneg    $f3, $f4
	store   $f2, [$i2 + 1]
	store   $f3, [$i2 + 2]
	fneg    $f2, $f5
	load    [$i1 + $i3], $i2
	fneg    $f1, $f6
	store   $f1, [$i2 + 0]
	store   $f3, [$i2 + 1]
	store   $f5, [$i2 + 2]
	load    [$i1 + $i5], $i2
	store   $f3, [$i2 + 0]
	store   $f6, [$i2 + 1]
	store   $f5, [$i2 + 2]
	load    [$i1 + $i6], $i2
	store   $f6, [$i2 + 0]
	store   $f5, [$i2 + 1]
	store   $f4, [$i2 + 2]
	load    [$i1 + $i7], $i2
	store   $f6, [$i2 + 0]
	store   $f4, [$i2 + 1]
	store   $f2, [$i2 + 2]
	load    [$i1 + $i4], $i1
	store   $f4, [$i1 + 0]
	store   $f1, [$i1 + 1]
	store   $f2, [$i1 + 2]
	jr      $ra1
.end calc_dirvec

######################################################################
# calc_dirvecs($i8, $f9, $i9, $i10)
# $ra = $ra2
# [$i1 - $i9, $i11]
# [$f1 - $f8, $f10 - $f14]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i8, 0, bl.22755
bge.22755:
	li      0, $i1
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f14, $fc8, $f8
	jal     calc_dirvec.3020, $ra1
	add     $i10, 2, $i11
	fadd    $f14, $fc6, $f8
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bl      $i8, 0, bl.22755
bge.22756:
	add     $i9, 1, $i1
.count move_args
	mov     $i8, $i2
	bge     $i1, 5, bge.22757
bl.22757:
	mov     $i1, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f14, $fc8, $f8
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f14, $fc6, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bge     $i8, 0, bge.22758
.count dual_jmp
	b       bl.22755
bge.22757:
	add     $i9, -4, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
	fsub    $f14, $fc8, $f8
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f14, $fc6, $f8
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bl      $i8, 0, bl.22755
bge.22758:
	li      0, $i1
	add     $i9, 1, $i2
	bge     $i2, 5, bge.22759
bl.22759:
	mov     $i2, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f14, $fc8, $f8
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f14, $fc6, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bge     $i8, 0, bge.22760
.count dual_jmp
	b       bl.22755
bge.22759:
	add     $i9, -4, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
	fsub    $f14, $fc8, $f8
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f14, $fc6, $f8
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bl      $i8, 0, bl.22755
bge.22760:
	add     $i9, 1, $i1
.count move_args
	mov     $i8, $i2
	bge     $i1, 5, bge.22761
bl.22761:
	mov     $i1, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f14, $fc8, $f8
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f14, $fc6, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i9, 1, $i1
	add     $i8, -1, $i8
	bge     $i1, 5, bge.22762
.count dual_jmp
	b       bl.22762
bge.22761:
	add     $i9, -4, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f14, $fc8, $f8
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f14, $fc6, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i9, 1, $i1
	add     $i8, -1, $i8
	bge     $i1, 5, bge.22762
bl.22762:
.count move_args
	mov     $i1, $i9
	b       calc_dirvecs.3028
bge.22762:
	add     $i9, -4, $i9
	b       calc_dirvecs.3028
bl.22755:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i12, $i13, $i14)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f17]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i12, 0, bl.22763
bge.22763:
	li      0, $i1
.count load_float
	load    [f.22077], $f15
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f8
.count move_args
	mov     $i13, $i3
	fsub    $f1, $fc8, $f9
.count move_args
	mov     $i14, $i4
.count move_args
	mov     $f0, $f1
	jal     calc_dirvec.3020, $ra1
	add     $i14, 2, $i8
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc8, $f8
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22078], $f16
	li      0, $i2
	add     $i13, 1, $i1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i14, $i4
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f16, $f8
	bge     $i1, 5, bge.22764
bl.22764:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22079], $f17
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f17, $f8
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22765
.count dual_jmp
	b       bl.22765
bge.22764:
	add     $i13, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22079], $f17
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f17, $f8
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22765
bl.22765:
	mov     $i1, $i9
	li      0, $i2
.count load_float
	load    [f.22080], $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i14, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc3, $f8
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22766
.count dual_jmp
	b       bl.22766
bge.22765:
	add     $i9, -4, $i9
.count load_float
	load    [f.22080], $f8
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i14, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $fc3, $f8
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22766
bl.22766:
	mov     $i1, $i9
.count move_args
	mov     $i14, $i10
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	bge     $i12, 0, bge.22767
.count dual_jmp
	b       bl.22763
bge.22766:
	add     $i9, -4, $i9
.count move_args
	mov     $i14, $i10
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	bl      $i12, 0, bl.22763
bge.22767:
	li      0, $i1
	add     $i13, 2, $i2
	add     $i14, 4, $i10
	bge     $i2, 5, bge.22768
bl.22768:
	mov     $i2, $i13
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $f15, $f8
.count move_args
	mov     $i10, $i4
	fsub    $f1, $fc8, $f9
.count move_args
	mov     $f0, $f1
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	add     $i14, 6, $i8
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $fc8, $f8
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i13, 1, $i1
	bge     $i1, 5, bge.22769
.count dual_jmp
	b       bl.22769
bge.22768:
	add     $i13, -3, $i13
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f8
.count move_args
	mov     $i13, $i3
	fsub    $f1, $fc8, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f1
	jal     calc_dirvec.3020, $ra1
	add     $i14, 6, $i8
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc8, $f8
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i13, 1, $i1
	bge     $i1, 5, bge.22769
bl.22769:
	mov     $i1, $i9
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f8
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f17, $f8
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22770
.count dual_jmp
	b       bl.22770
bge.22769:
	add     $i13, -4, $i9
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f16, $f8
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f17, $f8
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22770
bl.22770:
	mov     $i1, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i13, 2, $i1
	add     $i12, -1, $i12
	bge     $i1, 5, bge.22771
.count dual_jmp
	b       bl.22771
bge.22770:
	add     $i9, -4, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i13, 2, $i1
	add     $i12, -1, $i12
	bge     $i1, 5, bge.22771
bl.22771:
	add     $i14, 8, $i14
.count move_args
	mov     $i1, $i13
	b       calc_dirvec_rows.3033
bge.22771:
	add     $i13, -3, $i13
	add     $i14, 8, $i14
	b       calc_dirvec_rows.3033
bl.22763:
	jr      $ra3
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
# [$ra]
######################################################################
.align 2
.begin create_dirvec
create_dirvec.3037:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
	load    [$i3 + 0], $i2
	mov     $hp, $i4
	add     $hp, 4, $hp
	store   $i2, [$i4 + 0]
	load    [$i3 + 1], $i2
	store   $i2, [$i4 + 1]
	load    [$i3 + 2], $i2
	store   $i2, [$i4 + 2]
	store   $i1, [$i4 + 3]
	mov     $i4, $i1
	jr      $ra1
.end create_dirvec

######################################################################
# create_dirvec_elements($i5, $i6)
# $ra = $ra2
# [$i1 - $i4, $i6]
# [$f2]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bge     $i6, 0, bge.22772
bl.22772:
	jr      $ra2
bge.22772:
	jal     create_dirvec.3037, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       create_dirvec_elements.3039
.end create_dirvec_elements

######################################################################
# create_dirvecs($i7)
# $ra = $ra3
# [$i1 - $i7]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin create_dirvecs
create_dirvecs.3042:
	bge     $i7, 0, bge.22773
bl.22773:
	jr      $ra3
bge.22773:
	jal     create_dirvec.3037, $ra1
	li      120, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i7]
	li      118, $i6
	load    [ext_dirvecs + $i7], $i5
	jal     create_dirvec_elements.3039, $ra2
	add     $i7, -1, $i7
	b       create_dirvecs.3042
.end create_dirvecs

######################################################################
# init_dirvec_constants($i8, $i9)
# $ra = $ra3
# [$i1 - $i7, $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bge     $i9, 0, bge.22774
bl.22774:
	jr      $ra3
bge.22774:
	load    [$i8 + $i9], $i4
	jal     setup_dirvec_constants.2829, $ra2
	add     $i9, -1, $i9
	b       init_dirvec_constants.3044
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i10)
# $ra = $ra4
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin init_vecset_constants
init_vecset_constants.3047:
	bge     $i10, 0, bge.22775
bl.22775:
	jr      $ra4
bge.22775:
	load    [ext_dirvecs + $i10], $i8
	li      119, $i9
	jal     init_dirvec_constants.3044, $ra3
	add     $i10, -1, $i10
	b       init_vecset_constants.3047
.end init_vecset_constants

######################################################################
# add_reflection($i8, $i9, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin add_reflection
add_reflection.3051:
	jal     create_dirvec.3037, $ra1
.count move_ret
	mov     $i1, $i4
	store   $f1, [$i4 + 0]
	store   $f3, [$i4 + 1]
	store   $f4, [$i4 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	mov     $hp, $i1
	store   $i9, [$i1 + 0]
	load    [$i4 + 0], $i2
	add     $hp, 6, $hp
	store   $i2, [$i1 + 1]
	load    [$i4 + 1], $i2
	store   $i2, [$i1 + 2]
	load    [$i4 + 2], $i2
	store   $i2, [$i1 + 3]
	load    [$i4 + 3], $i2
	store   $i2, [$i1 + 4]
	store   $f9, [$i1 + 5]
	store   $i1, [ext_reflections + $i8]
	jr      $ra3
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i33]
# [$f1 - $f21]
# [$ig0 - $ig4]
# [$fg0 - $fg21]
# [$ra - $ra9]
######################################################################
.align 2
.begin main
ext_main:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
	load    [ext_solver_dist + 0], $fg0
	load    [ext_diffuse_ray + 0], $fg1
	load    [ext_diffuse_ray + 1], $fg2
	load    [ext_diffuse_ray + 2], $fg3
	load    [ext_rgb + 0], $fg4
	load    [ext_rgb + 1], $fg5
	load    [ext_rgb + 2], $fg6
	load    [ext_n_objects + 0], $ig0
	load    [ext_tmin + 0], $fg7
	load    [ext_startp_fast + 0], $fg8
	load    [ext_startp_fast + 1], $fg9
	load    [ext_startp_fast + 2], $fg10
	load    [ext_texture_color + 1], $fg11
	load    [ext_light + 1], $fg12
	load    [ext_light + 2], $fg13
	load    [ext_light + 0], $fg14
	load    [ext_texture_color + 2], $fg15
	load    [ext_or_net + 0], $ig1
	load    [ext_intsec_rectside + 0], $ig2
	load    [ext_texture_color + 0], $fg16
	load    [ext_intersected_object_id + 0], $ig3
	load    [ext_n_reflections + 0], $ig4
	load    [ext_startp + 0], $fg17
	load    [ext_startp + 1], $fg18
	load    [ext_startp + 2], $fg19
	load    [ext_screenz_dir + 0], $fg20
	load    [ext_screenz_dir + 1], $fg21
	load    [f.21978 + 0], $fc0
	load    [f.22003 + 0], $fc1
	load    [f.22002 + 0], $fc2
	load    [f.21979 + 0], $fc3
	load    [f.21982 + 0], $fc4
	load    [f.21992 + 0], $fc5
	load    [f.21991 + 0], $fc6
	load    [f.21976 + 0], $fc7
	load    [f.22076 + 0], $fc8
	load    [f.21998 + 0], $fc9
	load    [f.21997 + 0], $fc10
	load    [f.21981 + 0], $fc11
	load    [f.22075 + 0], $fc12
	load    [f.21988 + 0], $fc13
	load    [f.21984 + 0], $fc14
	load    [f.21977 + 0], $fc15
	load    [f.21933 + 0], $fc16
	load    [f.22102 + 0], $fc17
	load    [f.22101 + 0], $fc18
	load    [f.22100 + 0], $fc19
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i30
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i26
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i32
	call    ext_read_float
	store   $f1, [ext_screen + 0]
	call    ext_read_float
	store   $f1, [ext_screen + 1]
	call    ext_read_float
	store   $f1, [ext_screen + 2]
	call    ext_read_float
	fmul    $f1, $fc16, $f8
.count move_args
	mov     $f8, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f9
.count move_args
	mov     $f8, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f8
	call    ext_read_float
	fmul    $f1, $fc16, $f10
.count move_args
	mov     $f10, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
.count move_args
	mov     $f10, $f2
	call    ext_sin
	fmul    $f9, $f11, $f2
	fmul    $f9, $f1, $f3
	fmul    $f8, $fc18, $fg21
	fneg    $f8, $f4
	fneg    $f1, $f5
	fmul    $f2, $fc19, $f2
	fmul    $f3, $fc19, $fg20
	store   $f2, [ext_screenz_dir + 2]
	fmul    $f4, $f1, $f1
	store   $f11, [ext_screenx_dir + 0]
	fmul    $f4, $f11, $f3
	store   $f5, [ext_screenx_dir + 2]
	fneg    $f9, $f4
	store   $f1, [ext_screeny_dir + 0]
	store   $f4, [ext_screeny_dir + 1]
	store   $f3, [ext_screeny_dir + 2]
	load    [ext_screen + 0], $f1
	fsub    $f1, $fg20, $f1
	store   $f1, [ext_viewpoint + 0]
	load    [ext_screen + 1], $f1
	fsub    $f1, $fg21, $f1
	store   $f1, [ext_viewpoint + 1]
	load    [ext_screen + 2], $f1
	load    [ext_screenz_dir + 2], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [ext_viewpoint + 2]
	call    ext_read_int
	call    ext_read_float
	fmul    $f1, $fc16, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
	fneg    $f1, $fg12
	call    ext_read_float
.count move_ret
	mov     $f1, $f9
.count move_args
	mov     $f8, $f2
	call    ext_cos
	fmul    $f9, $fc16, $f9
.count move_ret
	mov     $f1, $f8
.count move_args
	mov     $f9, $f2
	call    ext_sin
	fmul    $f8, $f1, $fg14
.count move_args
	mov     $f9, $f2
	call    ext_cos
	fmul    $f8, $f1, $fg13
	call    ext_read_float
	store   $f1, [ext_beam + 0]
	li      0, $i6
	jal     read_object.2721, $ra2
	li      0, $i6
	jal     read_and_network.2729, $ra1
	li      0, $i1
	call    read_or_network.2727
.count move_ret
	mov     $i1, $ig1
	li      80, $i2
	call    ext_write
	li      54, $i2
	call    ext_write
	li      10, $i2
	call    ext_write
	li      49, $i2
	call    ext_write
	li      50, $i2
	call    ext_write
	li      56, $i2
	call    ext_write
	li      32, $i2
	call    ext_write
	li      49, $i2
	call    ext_write
	li      50, $i2
	call    ext_write
	li      56, $i2
	call    ext_write
	li      32, $i2
	call    ext_write
	li      50, $i2
	call    ext_write
	li      53, $i2
	call    ext_write
	li      53, $i2
	call    ext_write
	li      10, $i2
	call    ext_write
	li      4, $i7
	jal     create_dirvecs.3042, $ra3
.count move_args
	mov     $fc8, $f9
	li      0, $i9
	li      0, $i10
	li      4, $i8
	jal     calc_dirvecs.3028, $ra2
	li      8, $i12
	li      2, $i13
	li      4, $i14
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i10
	jal     init_vecset_constants.3047, $ra4
	li      ext_light_dirvec, $i4
	store   $fg14, [%{ext_light_dirvec + 0} + 0]
	store   $fg12, [%{ext_light_dirvec + 0} + 1]
	store   $fg13, [%{ext_light_dirvec + 0} + 2]
	jal     setup_dirvec_constants.2829, $ra2
	add     $ig0, -1, $i1
	bl      $i1, 0, bl.22777
bge.22777:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.22777
be.22778:
	load    [$i2 + 11], $f1
	ble     $fc0, $f1, bl.22777
bg.22779:
	load    [$i2 + 1], $i3
	be      $i3, 1, be.22780
bne.22780:
	be      $i3, 2, be.22781
bl.22777:
	li      127, $i27
	li      0, $i28
	load    [ext_screeny_dir + 0], $f1
	load    [ext_screeny_dir + 1], $f2
	fmul    $fc17, $f1, $f1
	load    [ext_screeny_dir + 2], $f3
	fmul    $fc17, $f2, $f2
	fmul    $fc17, $f3, $f3
	load    [ext_screenz_dir + 2], $f4
	fadd    $f1, $fg20, $f19
	fadd    $f2, $fg21, $f20
	fadd    $f3, $f4, $f21
	jal     pretrace_pixels.2983, $ra7
	li      0, $i29
	li      2, $i33
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
be.22781:
	load    [$i2 + 4], $f2
	fmul    $fc7, $f2, $f5
	load    [$i2 + 5], $f3
	fmul    $fg14, $f2, $f2
	load    [$i2 + 6], $f4
	fmul    $fg12, $f3, $f6
	fmul    $fg13, $f4, $f7
	add     $i1, $i1, $i1
	fmul    $fc7, $f3, $f3
.count move_args
	mov     $ig4, $i8
	fmul    $fc7, $f4, $f4
	add     $i1, $i1, $i1
	fsub    $fc0, $f1, $f9
	add     $i1, 1, $i9
	fadd    $f2, $f6, $f1
	fadd    $f1, $f7, $f1
	fmul    $f5, $f1, $f2
	fmul    $f3, $f1, $f3
	fmul    $f4, $f1, $f1
	fsub    $f2, $fg14, $f2
	fsub    $f3, $fg12, $f3
	fsub    $f1, $fg13, $f4
.count move_args
	mov     $f2, $f1
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $ig4
	load    [ext_screeny_dir + 0], $f1
	li      127, $i27
	load    [ext_screeny_dir + 1], $f2
	li      0, $i28
	load    [ext_screeny_dir + 2], $f3
	fmul    $fc17, $f1, $f1
	load    [ext_screenz_dir + 2], $f4
	fmul    $fc17, $f2, $f2
	fmul    $fc17, $f3, $f3
	fadd    $f1, $fg20, $f19
	fadd    $f2, $fg21, $f20
	fadd    $f3, $f4, $f21
	jal     pretrace_pixels.2983, $ra7
	li      0, $i29
	li      2, $i33
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
be.22780:
	add     $i1, $i1, $i1
	load    [$i2 + 11], $f1
	add     $i1, $i1, $i10
	fneg    $fg12, $f10
	fneg    $fg13, $f11
	add     $i10, 1, $i9
	fsub    $fc0, $f1, $f9
.count move_args
	mov     $ig4, $i8
.count move_args
	mov     $fg14, $f1
.count move_args
	mov     $f10, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
	fneg    $fg14, $f12
	add     $ig4, 1, $i8
	add     $i10, 2, $i9
.count move_args
	mov     $f12, $f1
.count move_args
	mov     $fg12, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
.count move_args
	mov     $f12, $f1
	add     $ig4, 2, $i8
.count move_args
	mov     $f10, $f3
	add     $i10, 3, $i9
.count move_args
	mov     $fg13, $f4
	jal     add_reflection.3051, $ra3
	load    [ext_screeny_dir + 0], $f1
	add     $ig4, 3, $ig4
	load    [ext_screeny_dir + 1], $f2
	li      127, $i27
	load    [ext_screeny_dir + 2], $f3
	li      0, $i28
	fmul    $fc17, $f1, $f1
	fmul    $fc17, $f2, $f2
	load    [ext_screenz_dir + 2], $f4
	fmul    $fc17, $f3, $f3
	fadd    $f1, $fg20, $f19
	fadd    $f2, $fg21, $f20
	fadd    $f3, $f4, $f21
	jal     pretrace_pixels.2983, $ra7
	li      0, $i29
	li      2, $i33
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
.end main
