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
######################################################################
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
FLOAT_HALF:
	.float 0.5

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
FLOOR_NEGATIVE:
	fneg $f1, $f1
	load [FLOAT_MAGICF], $f3
	ble $f1, $f3, FLOOR_NEGATIVE_MAIN
	fneg $f1, $f1
	ret
FLOOR_NEGATIVE_MAIN:
	fadd $f1, $f3, $f1
	fsub $f1, $f3, $f1
	fneg $f2, $f2
	ble $f2, $f1, FLOOR_RET2
	fadd $f1, $f3, $f1
	load [FLOOR_ONE], $f2
	fadd $f1, $f2, $f1
	fsub $f1, $f3, $f1
	fneg $f1, $f1
	ret
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
FLOOR_RET2:
	fneg $f1, $f1
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
	load [FLOAT_HALF], $f3
	fadd $f2, $f3, $f2
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
######################################################################
#
# 		↓　ここから math.s
#
######################################################################

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
.define $ig0 $i33
.define $i33 orz
.define $ig1 $i34
.define $i34 orz
.define $ig2 $i35
.define $i35 orz
.define $ig3 $i36
.define $i36 orz
.define $ig4 $i37
.define $i37 orz
.define $fig0 $i38
.define $i38 orz
.define $fig1 $i39
.define $i39 orz
.define $fig2 $i40
.define $i40 orz
.define $fig3 $i41
.define $i41 orz
.define $fig4 $i42
.define $i42 orz
.define $fig5 $i43
.define $i43 orz
.define $fig6 $i44
.define $i44 orz
.define $fig7 $i45
.define $i45 orz
.define $fig8 $i46
.define $i46 orz
.define $fig9 $i47
.define $i47 orz
.define $fig10 $i48
.define $i48 orz
.define $fig11 $i49
.define $i49 orz
.define $fig12 $i50
.define $i50 orz
.define $fig13 $i51
.define $i51 orz
.define $fig14 $i52
.define $i52 orz
.define $fg0 $f27
.define $f27 orz
.define $fg1 $f28
.define $f28 orz
.define $fg2 $f29
.define $f29 orz
.define $fg3 $f30
.define $f30 orz
.define $fg4 $f31
.define $f31 orz
.define $fg5 $f32
.define $f32 orz
.define $fg6 $f33
.define $f33 orz
.define $fg7 $f34
.define $f34 orz
.define $fg8 $f35
.define $f35 orz
.define $fg9 $f36
.define $f36 orz
.define $fg10 $f37
.define $f37 orz
.define $fg11 $f38
.define $f38 orz
.define $fg12 $f39
.define $f39 orz
.define $fg13 $f40
.define $f40 orz
.define $fg14 $f41
.define $f41 orz
.define $fg15 $f42
.define $f42 orz
.define $fg16 $f43
.define $f43 orz
.define $fg17 $f44
.define $f44 orz
.define $fg18 $f45
.define $f45 orz
.define $fg19 $f46
.define $f46 orz
.define $fc0 $f47
.define $f47 orz
.define $fc1 $f48
.define $f48 orz
.define $fc2 $f49
.define $f49 orz
.define $fc3 $f50
.define $f50 orz
.define $fc4 $f51
.define $f51 orz
.define $fc5 $f52
.define $f52 orz
.define $fc6 $f53
.define $f53 orz
.define $fc7 $f54
.define $f54 orz
.define $fc8 $f55
.define $f55 orz
.define $fc9 $f56
.define $f56 orz
.define $fc10 $f57
.define $f57 orz
.define $fc11 $f58
.define $f58 orz
.define $fc12 $f59
.define $f59 orz
.define $fc13 $f60
.define $f60 orz
.define $fc14 $f61
.define $f61 orz
.define $fc15 $f62
.define $f62 orz
.define $fc16 $f63
.define $f63 orz
.define $ra1 $i53
.define $i53 orz
.define $ra2 $i54
.define $i54 orz
.define $ra3 $i55
.define $i55 orz
.define $ra4 $i56
.define $i56 orz
.define $ra5 $i57
.define $i57 orz
.define $ra6 $i58
.define $i58 orz
.define $ra7 $i59
.define $i59 orz
f.28102:	.float  -6.4000000000E+01
f.28101:	.float  -2.0000000000E+02
f.28100:	.float  2.0000000000E+02
f.28080:	.float  -5.0000000000E-01
f.28079:	.float  7.0000000000E-01
f.28078:	.float  -3.0000000000E-01
f.28077:	.float  -1.0000000000E-01
f.28076:	.float  9.0000000000E-01
f.28075:	.float  2.0000000000E-01
f.28005:	.float  6.6666666667E-03
f.28004:	.float  1.5000000000E+02
f.28003:	.float  -6.6666666667E-03
f.28002:	.float  -1.5000000000E+02
f.28001:	.float  -2.0000000000E+00
f.28000:	.float  3.9062500000E-03
f.27999:	.float  2.5600000000E+02
f.27998:	.float  2.0000000000E+01
f.27997:	.float  5.0000000000E-02
f.27996:	.float  2.5000000000E-01
f.27995:	.float  1.0000000000E-01
f.27994:	.float  1.0000000000E+01
f.27993:	.float  8.5000000000E+02
f.27992:	.float  3.3333333333E+00
f.27991:	.float  3.0000000000E-01
f.27990:	.float  2.5500000000E+02
f.27989:	.float  1.5000000000E-01
f.27988:	.float  9.5492964444E+00
f.27987:	.float  3.1830988148E-01
f.27986:	.float  3.1415927000E+00
f.27985:	.float  3.0000000000E+01
f.27984:	.float  1.5000000000E+01
f.27983:	.float  1.0000000000E-04
f.27982:	.float  1.0000000000E+08
f.27981:	.float  1.0000000000E+09
f.27980:	.float  -1.0000000000E-01
f.27979:	.float  1.0000000000E-02
f.27978:	.float  -2.0000000000E-01
f.27977:	.float  5.0000000000E-01
f.27976:	.float  2.0000000000E+00
f.27975:	.float  1.0000000000E+00
f.27974:	.float  -1.0000000000E+00
f.27931:	.float  1.7453293000E-02

######################################################################
# read_object($i6)
# $ra = $ra1
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_object
read_object.2721:
	bge     $i6, 60, bge.28113
bl.28113:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	be      $i7, -1, be.28114
bne.28114:
	call    ext_read_int
.count move_ret
	mov     $i1, $i8
	call    ext_read_int
.count move_ret
	mov     $i1, $i9
	call    ext_read_int
.count move_args
	mov     $f0, $f2
.count move_ret
	mov     $i1, $i10
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
.count move_args
	mov     $f0, $f2
	li      2, $i2
	ble     $f0, $f1, ble.28115
bg.28115:
	li      1, $i13
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	call    ext_read_float
	store   $f1, [$i14 + 0]
	call    ext_read_float
	store   $f1, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i15
	call    ext_read_float
	store   $f1, [$i15 + 0]
	call    ext_read_float
	store   $f1, [$i15 + 1]
	call    ext_read_float
	store   $f1, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i16
	be      $i10, 0, be.28116
.count dual_jmp
	b       bne.28116
ble.28115:
	li      0, $i13
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	call    ext_read_float
	store   $f1, [$i14 + 0]
	call    ext_read_float
	store   $f1, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i15
	call    ext_read_float
	store   $f1, [$i15 + 0]
	call    ext_read_float
	store   $f1, [$i15 + 1]
	call    ext_read_float
	store   $f1, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i16
	be      $i10, 0, be.28116
bne.28116:
	call    ext_read_float
.count load_float
	load    [f.27931], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i16 + 0]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i16 + 1]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i16 + 2]
	be      $i8, 2, be.28117
.count dual_jmp
	b       bne.28117
be.28116:
	be      $i8, 2, be.28117
bne.28117:
	mov     $i13, $i4
.count move_args
	mov     $f0, $f2
	li      4, $i2
	call    ext_create_array_float
	mov     $hp, $i2
	store   $i7, [$i2 + 0]
	add     $hp, 23, $hp
	store   $i8, [$i2 + 1]
	store   $i9, [$i2 + 2]
	store   $i10, [$i2 + 3]
	load    [$i11 + 0], $i3
	store   $i3, [$i2 + 4]
	load    [$i11 + 1], $i3
	store   $i3, [$i2 + 5]
	load    [$i11 + 2], $i3
	add     $i2, 4, $i11
	store   $i3, [$i2 + 6]
	load    [$i12 + 0], $i3
	store   $i3, [$i2 + 7]
	load    [$i12 + 1], $i3
	store   $i3, [$i2 + 8]
	load    [$i12 + 2], $i3
	store   $i3, [$i2 + 9]
	store   $i4, [$i2 + 10]
	load    [$i14 + 0], $i3
	store   $i3, [$i2 + 11]
	load    [$i14 + 1], $i3
	store   $i3, [$i2 + 12]
	load    [$i15 + 0], $i3
	store   $i3, [$i2 + 13]
	load    [$i15 + 1], $i3
	store   $i3, [$i2 + 14]
	load    [$i15 + 2], $i3
	store   $i3, [$i2 + 15]
	load    [$i16 + 0], $i3
	store   $i3, [$i2 + 16]
	load    [$i16 + 1], $i3
	store   $i3, [$i2 + 17]
	load    [$i16 + 2], $i3
	add     $i2, 16, $i16
	store   $i3, [$i2 + 18]
	load    [$i1 + 0], $i3
	store   $i3, [$i2 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i2 + 20]
	load    [$i1 + 2], $i3
	add     $i2, 19, $i1
	store   $i3, [$i2 + 21]
	store   $i1, [$i2 + 22]
	store   $i2, [ext_objects + $i6]
	be      $i8, 3, be.28118
.count dual_jmp
	b       bne.28118
be.28117:
	li      1, $i4
.count move_args
	mov     $f0, $f2
	li      4, $i2
	call    ext_create_array_float
	mov     $hp, $i2
	store   $i7, [$i2 + 0]
	add     $hp, 23, $hp
	store   $i8, [$i2 + 1]
	store   $i9, [$i2 + 2]
	store   $i10, [$i2 + 3]
	load    [$i11 + 0], $i3
	store   $i3, [$i2 + 4]
	load    [$i11 + 1], $i3
	store   $i3, [$i2 + 5]
	load    [$i11 + 2], $i3
	add     $i2, 4, $i11
	store   $i3, [$i2 + 6]
	load    [$i12 + 0], $i3
	store   $i3, [$i2 + 7]
	load    [$i12 + 1], $i3
	store   $i3, [$i2 + 8]
	load    [$i12 + 2], $i3
	store   $i3, [$i2 + 9]
	store   $i4, [$i2 + 10]
	load    [$i14 + 0], $i3
	store   $i3, [$i2 + 11]
	load    [$i14 + 1], $i3
	store   $i3, [$i2 + 12]
	load    [$i15 + 0], $i3
	store   $i3, [$i2 + 13]
	load    [$i15 + 1], $i3
	store   $i3, [$i2 + 14]
	load    [$i15 + 2], $i3
	store   $i3, [$i2 + 15]
	load    [$i16 + 0], $i3
	store   $i3, [$i2 + 16]
	load    [$i16 + 1], $i3
	store   $i3, [$i2 + 17]
	load    [$i16 + 2], $i3
	add     $i2, 16, $i16
	store   $i3, [$i2 + 18]
	load    [$i1 + 0], $i3
	store   $i3, [$i2 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i2 + 20]
	load    [$i1 + 2], $i3
	add     $i2, 19, $i1
	store   $i3, [$i2 + 21]
	store   $i1, [$i2 + 22]
	store   $i2, [ext_objects + $i6]
	be      $i8, 3, be.28118
bne.28118:
	be      $i8, 2, be.28128
bne.28128:
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
be.28128:
	load    [$i11 + 2], $f3
	fmul    $f3, $f3, $f3
	load    [$i11 + 1], $f2
	fmul    $f2, $f2, $f2
	load    [$i11 + 0], $f1
	fmul    $f1, $f1, $f4
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $i13, 0, be.28129
bne.28129:
	be      $f2, $f0, be.28130
bne.28721:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
be.28129:
	be      $f2, $f0, be.28130
bne.28722:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
be.28130:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
be.28118:
	load    [$i11 + 0], $f1
	bne     $f1, $f0, bne.28119
be.28119:
	mov     $f0, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.28122
.count dual_jmp
	b       bne.28122
bne.28119:
	bne     $f1, $f0, bne.28120
be.28120:
	fmul    $f1, $f1, $f1
	mov     $f0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.28122
.count dual_jmp
	b       bne.28122
bne.28120:
	ble     $f1, $f0, ble.28121
bg.28121:
	fmul    $f1, $f1, $f1
	mov     $fc0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.28122
.count dual_jmp
	b       bne.28122
ble.28121:
	fmul    $f1, $f1, $f1
	mov     $fc6, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	bne     $f1, $f0, bne.28122
be.28122:
	mov     $f0, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.28125
.count dual_jmp
	b       bne.28125
bne.28122:
	bne     $f1, $f0, bne.28123
be.28123:
	fmul    $f1, $f1, $f1
	mov     $f0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.28125
.count dual_jmp
	b       bne.28125
bne.28123:
	ble     $f1, $f0, ble.28124
bg.28124:
	fmul    $f1, $f1, $f1
	mov     $fc0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.28125
.count dual_jmp
	b       bne.28125
ble.28124:
	fmul    $f1, $f1, $f1
	mov     $fc6, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	bne     $f1, $f0, bne.28125
be.28125:
	mov     $f0, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
bne.28125:
	bne     $f1, $f0, bne.28126
be.28126:
	fmul    $f1, $f1, $f1
	mov     $f0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
bne.28126:
	ble     $f1, $f0, ble.28127
bg.28127:
	fmul    $f1, $f1, $f1
	mov     $fc0, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
.count dual_jmp
	b       bne.28132
ble.28127:
	fmul    $f1, $f1, $f1
	mov     $fc6, $f2
	finv    $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.28132
bne.28132:
	load    [$i16 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f9
	load    [$i16 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i16 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
	load    [$i16 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f12
	load    [$i16 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f13
	load    [$i16 + 2], $f2
	call    ext_sin
	fmul    $f10, $f12, $f2
	add     $i6, 1, $i6
	fmul    $f11, $f13, $f3
	fmul    $f9, $f1, $f4
	fmul    $f2, $f13, $f5
	fmul    $f9, $f12, $f6
	fmul    $f10, $f1, $f7
	fsub    $f5, $f4, $f4
	fmul    $f6, $f13, $f5
	fmul    $f11, $f1, $f8
	fmul    $f2, $f1, $f2
	fmul    $f9, $f13, $f14
	fadd    $f5, $f7, $f5
	fmul    $f6, $f1, $f1
	fadd    $f2, $f14, $f2
	fmul    $f10, $f13, $f6
	fneg    $f12, $f7
	load    [$i11 + 2], $f12
	fmul    $f10, $f11, $f10
	fsub    $f1, $f6, $f1
	fmul    $f9, $f11, $f6
	load    [$i11 + 0], $f9
	load    [$i11 + 1], $f11
	fmul    $f3, $f3, $f13
	fmul    $f8, $f8, $f14
	fmul    $f7, $f7, $f15
	fmul    $f9, $f13, $f13
	fmul    $f11, $f14, $f14
	fmul    $f12, $f15, $f15
	fmul    $f4, $f4, $f16
	fadd    $f13, $f14, $f13
	fmul    $f2, $f2, $f14
	fmul    $f9, $f16, $f16
	fadd    $f13, $f15, $f13
	fmul    $f11, $f14, $f14
	store   $f13, [$i11 + 0]
	fmul    $f10, $f10, $f15
	fadd    $f16, $f14, $f13
	fmul    $f12, $f15, $f14
	fmul    $f5, $f5, $f15
	fmul    $f1, $f1, $f16
	fadd    $f13, $f14, $f13
	fmul    $f9, $f15, $f14
	store   $f13, [$i11 + 1]
	fmul    $f11, $f16, $f15
	fmul    $f6, $f6, $f13
	fadd    $f14, $f15, $f14
.count load_float
	load    [f.27976], $f15
	fmul    $f12, $f13, $f13
	fmul    $f9, $f4, $f16
	fmul    $f11, $f2, $f17
	fadd    $f14, $f13, $f13
	fmul    $f16, $f5, $f14
	store   $f13, [$i11 + 2]
	fmul    $f17, $f1, $f16
	fmul    $f12, $f10, $f13
	fadd    $f14, $f16, $f14
	fmul    $f9, $f3, $f3
	fmul    $f11, $f8, $f8
	fmul    $f13, $f6, $f9
	fmul    $f3, $f5, $f5
	fmul    $f8, $f1, $f1
	fadd    $f14, $f9, $f9
	fmul    $f12, $f7, $f7
	fadd    $f5, $f1, $f1
	fmul    $f15, $f9, $f5
	fmul    $f7, $f6, $f6
	store   $f5, [$i16 + 0]
	fmul    $f3, $f4, $f3
	fmul    $f8, $f2, $f2
	fadd    $f1, $f6, $f1
	fadd    $f3, $f2, $f2
	fmul    $f7, $f10, $f3
	fmul    $f15, $f1, $f1
	fadd    $f2, $f3, $f2
	store   $f1, [$i16 + 1]
	fmul    $f15, $f2, $f1
	store   $f1, [$i16 + 2]
	b       read_object.2721
be.28132:
	add     $i6, 1, $i6
	b       read_object.2721
be.28114:
	mov     $i6, $ig0
	jr      $ra1
bge.28113:
	jr      $ra1
.end read_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
# []
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
	be      $i1, -1, be.28135
bne.28135:
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
be.28135:
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
	be      $i2, -1, be.28139
bne.28139:
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
be.28139:
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
# []
# [$ra]
######################################################################
.align 2
.begin read_and_network
read_and_network.2729:
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	be      $i2, -1, be.28142
bne.28142:
	add     $i6, 1, $i2
	store   $i1, [ext_and_net + $i6]
.count move_args
	mov     $i2, $i6
	b       read_and_network.2729
be.28142:
	jr      $ra1
.end read_and_network

######################################################################
# iter_setup_dirvec_constants($f1, $f3, $f4, $i4, $i5)
# $ra = $ra1
# [$i1 - $i3, $i5 - $i6]
# [$f2, $f5 - $f11]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i5, 0, bl.28143
bge.28143:
	load    [ext_objects + $i5], $i6
.count move_args
	mov     $f0, $f2
	load    [$i6 + 1], $i1
	be      $i1, 1, be.28144
bne.28144:
	be      $i1, 2, be.28160
bne.28160:
	li      5, $i2
	call    ext_create_array_float
	fmul    $f1, $f1, $f2
	load    [$i6 + 4], $f5
	fmul    $f3, $f3, $f6
	load    [$i6 + 5], $f7
	fmul    $f2, $f5, $f2
	load    [$i6 + 6], $f9
	fmul    $f4, $f4, $f8
	load    [$i6 + 3], $i2
	fmul    $f6, $f7, $f6
	fadd    $f2, $f6, $f2
	fmul    $f8, $f9, $f6
	fmul_n  $f1, $f5, $f5
	fadd    $f2, $f6, $f2
	be      $i2, 0, be.28162
bne.28162:
	fmul    $f3, $f4, $f6
	load    [$i6 + 16], $f8
	fmul    $f4, $f1, $f10
	load    [$i6 + 17], $f11
	fmul    $f6, $f8, $f6
	fmul    $f1, $f3, $f8
	fmul    $f10, $f11, $f10
	fadd    $f2, $f6, $f2
	load    [$i6 + 18], $f6
	fadd    $f2, $f10, $f2
	fmul    $f8, $f6, $f6
	fadd    $f2, $f6, $f2
	fmul_n  $f3, $f7, $f6
	store   $f2, [$i1 + 0]
	fmul_n  $f4, $f9, $f7
	be      $i2, 0, be.28163
.count dual_jmp
	b       bne.28163
be.28162:
	fmul_n  $f3, $f7, $f6
	fmul_n  $f4, $f9, $f7
	store   $f2, [$i1 + 0]
	be      $i2, 0, be.28163
bne.28163:
	load    [$i6 + 17], $f8
	load    [$i6 + 18], $f9
	fmul    $f4, $f8, $f8
	fmul    $f3, $f9, $f9
	fadd    $f8, $f9, $f8
	fmul    $f8, $fc2, $f8
	fsub    $f5, $f8, $f5
	store   $f5, [$i1 + 1]
	load    [$i6 + 16], $f5
	load    [$i6 + 18], $f8
	fmul    $f4, $f5, $f5
	fmul    $f1, $f8, $f8
	fadd    $f5, $f8, $f5
	fmul    $f5, $fc2, $f5
	fsub    $f6, $f5, $f5
	store   $f5, [$i1 + 2]
	load    [$i6 + 16], $f5
	load    [$i6 + 17], $f6
	fmul    $f3, $f5, $f5
	fmul    $f1, $f6, $f6
	fadd    $f5, $f6, $f5
	fmul    $f5, $fc2, $f5
	fsub    $f7, $f5, $f5
	store   $f5, [$i1 + 3]
	be      $f2, $f0, be.28164
.count dual_jmp
	b       bne.28164
be.28163:
	store   $f5, [$i1 + 1]
	store   $f6, [$i1 + 2]
	store   $f7, [$i1 + 3]
	be      $f2, $f0, be.28164
bne.28164:
	finv    $f2, $f2
.count storer
	add     $i4, $i5, $tmp
	store   $f2, [$i1 + 4]
	add     $i5, -1, $i5
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be.28164:
.count storer
	add     $i4, $i5, $tmp
	add     $i5, -1, $i5
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be.28160:
	li      4, $i2
	call    ext_create_array_float
	load    [$i6 + 4], $f2
	load    [$i6 + 5], $f5
	fmul    $f1, $f2, $f2
	load    [$i6 + 6], $f6
	fmul    $f3, $f5, $f5
	fmul    $f4, $f6, $f6
.count storer
	add     $i4, $i5, $tmp
	fadd    $f2, $f5, $f2
	add     $i5, -1, $i5
	fadd    $f2, $f6, $f2
	ble     $f2, $f0, ble.28161
bg.28161:
	finv    $f2, $f2
	fneg    $f2, $f5
	store   $f5, [$i1 + 0]
	load    [$i6 + 4], $f5
	fmul_n  $f5, $f2, $f5
	store   $f5, [$i1 + 1]
	load    [$i6 + 5], $f5
	fmul_n  $f5, $f2, $f5
	store   $f5, [$i1 + 2]
	load    [$i6 + 6], $f5
	fmul_n  $f5, $f2, $f2
	store   $f2, [$i1 + 3]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
ble.28161:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be.28144:
	li      6, $i2
	call    ext_create_array_float
	bne     $f1, $f0, bne.28145
be.28145:
	store   $f0, [$i1 + 1]
	be      $f3, $f0, be.28150
.count dual_jmp
	b       bne.28150
bne.28145:
	load    [$i6 + 10], $i2
	load    [$i6 + 4], $f2
	finv    $f1, $f5
	ble     $f0, $f1, ble.28146
bg.28146:
	be      $i2, 0, be.28147
.count dual_jmp
	b       bne.28723
ble.28146:
	be      $i2, 0, bne.28723
be.28147:
	store   $f2, [$i1 + 0]
	store   $f5, [$i1 + 1]
	be      $f3, $f0, be.28150
.count dual_jmp
	b       bne.28150
bne.28723:
	fneg    $f2, $f2
	store   $f2, [$i1 + 0]
	store   $f5, [$i1 + 1]
	bne     $f3, $f0, bne.28150
be.28150:
	store   $f0, [$i1 + 3]
	be      $f4, $f0, be.28155
.count dual_jmp
	b       bne.28155
bne.28150:
	load    [$i6 + 10], $i2
	load    [$i6 + 5], $f2
	finv    $f3, $f5
	ble     $f0, $f3, ble.28151
bg.28151:
	be      $i2, 0, be.28152
.count dual_jmp
	b       bne.28726
ble.28151:
	be      $i2, 0, bne.28726
be.28152:
	store   $f2, [$i1 + 2]
	store   $f5, [$i1 + 3]
	be      $f4, $f0, be.28155
.count dual_jmp
	b       bne.28155
bne.28726:
	fneg    $f2, $f2
	store   $f2, [$i1 + 2]
	store   $f5, [$i1 + 3]
	be      $f4, $f0, be.28155
bne.28155:
	load    [$i6 + 10], $i2
	finv    $f4, $f5
	load    [$i6 + 6], $f2
.count storer
	add     $i4, $i5, $tmp
	ble     $f0, $f4, ble.28156
bg.28156:
	be      $i2, 0, be.28157
.count dual_jmp
	b       bne.28729
ble.28156:
	be      $i2, 0, bne.28729
be.28157:
	store   $f2, [$i1 + 4]
	add     $i5, -1, $i5
	store   $f5, [$i1 + 5]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bne.28729:
	fneg    $f2, $f2
	store   $f2, [$i1 + 4]
	add     $i5, -1, $i5
	store   $f5, [$i1 + 5]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be.28155:
.count storer
	add     $i4, $i5, $tmp
	store   $f0, [$i1 + 5]
	add     $i5, -1, $i5
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bl.28143:
	jr      $ra1
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($f1, $f3, $f4, $i4)
# $ra = $ra1
# [$i1 - $i3, $i5 - $i6]
# [$f2, $f5 - $f11]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
	add     $ig0, -1, $i5
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($f2, $f3, $f4, $i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1, $f5 - $f10]
# []
# []
# []
# []
######################################################################
.align 2
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bl.28165
bge.28165:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	store   $f1, [$i2 + 19]
	load    [$i2 + 8], $f1
	fsub    $f3, $f1, $f1
	store   $f1, [$i2 + 20]
	load    [$i2 + 9], $f1
	fsub    $f4, $f1, $f1
	store   $f1, [$i2 + 21]
	load    [$i2 + 1], $i3
	bne     $i3, 2, bne.28166
be.28166:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f5
	add     $i1, -1, $i1
	load    [$i2 + 21], $f6
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f7, $f1, $f1
	load    [$i2 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f6, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	store   $f1, [$i2 + 22]
	bge     $i1, 0, bge.28170
.count dual_jmp
	b       bl.28165
bne.28166:
	bg      $i3, 2, bg.28167
ble.28167:
	add     $i1, -1, $i1
	bge     $i1, 0, bge.28170
.count dual_jmp
	b       bl.28165
bg.28167:
	load    [$i2 + 19], $f1
	fmul    $f1, $f1, $f7
	load    [$i2 + 20], $f5
	fmul    $f5, $f5, $f9
	load    [$i2 + 21], $f6
	load    [$i2 + 4], $f8
	load    [$i2 + 5], $f10
	fmul    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i2 + 3], $i4
	fmul    $f9, $f10, $f9
	load    [$i2 + 6], $f10
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i4, 0, be.28168
bne.28168:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i2 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i3, 3, be.28169
.count dual_jmp
	b       bne.28169
be.28168:
	mov     $f7, $f1
	be      $i3, 3, be.28169
bne.28169:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	bge     $i1, 0, bge.28170
.count dual_jmp
	b       bl.28165
be.28169:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	bl      $i1, 0, bl.28165
bge.28170:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	store   $f1, [$i2 + 19]
	load    [$i2 + 8], $f1
	fsub    $f3, $f1, $f1
	store   $f1, [$i2 + 20]
	load    [$i2 + 9], $f1
	fsub    $f4, $f1, $f1
	store   $f1, [$i2 + 21]
	load    [$i2 + 1], $i3
	be      $i3, 2, be.28171
bne.28171:
	ble     $i3, 2, ble.28172
bg.28172:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f5
	fmul    $f1, $f1, $f7
	load    [$i2 + 21], $f6
	fmul    $f5, $f5, $f9
	load    [$i2 + 4], $f8
	fmul    $f7, $f8, $f7
	load    [$i2 + 5], $f10
	fmul    $f6, $f6, $f8
	fmul    $f9, $f10, $f9
	load    [$i2 + 6], $f10
	load    [$i2 + 3], $i4
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i4, 0, be.28173
bne.28173:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i2 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i3, 3, be.28174
.count dual_jmp
	b       bne.28174
be.28173:
	mov     $f7, $f1
	be      $i3, 3, be.28174
bne.28174:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
be.28174:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	b       setup_startp_constants.2831
ble.28172:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
be.28171:
	load    [$i2 + 19], $f1
	add     $i1, -1, $i1
	load    [$i2 + 20], $f5
	load    [$i2 + 21], $f6
	load    [$i2 + 4], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f6, $f6
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	store   $f1, [$i2 + 22]
	b       setup_startp_constants.2831
bl.28165:
	ret     
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i5]
# [$f1, $f5 - $f10]
# []
# []
# []
# []
######################################################################
.align 2
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.28194
bne.28175:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 9], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.28176
be.28176:
	load    [$i2 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.28178
bg.28177:
	load    [$i2 + 5], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, bg.28178
ble.28178:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.28735
.count dual_jmp
	b       be.28190
bg.28178:
	load    [$i2 + 6], $f1
	fabs    $f6, $f5
	load    [$i2 + 10], $i2
	ble     $f1, $f5, ble.28189
.count dual_jmp
	b       bg.28189
bne.28176:
	bne     $i4, 2, bne.28182
be.28182:
	load    [$i2 + 4], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f6, $f6
	load    [$i2 + 10], $i2
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.28189
.count dual_jmp
	b       bg.28189
bne.28182:
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $f8
	fmul    $f5, $f5, $f9
	load    [$i2 + 5], $f10
	fmul    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i2 + 3], $i5
	fmul    $f9, $f10, $f9
	load    [$i2 + 6], $f10
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i5, 0, be.28187
bne.28187:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i2 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i4, 3, be.28188
.count dual_jmp
	b       bne.28188
be.28187:
	mov     $f7, $f1
	be      $i4, 3, be.28188
bne.28188:
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.28189
.count dual_jmp
	b       bg.28189
be.28188:
	fsub    $f1, $fc0, $f1
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.28189
bg.28189:
	be      $i2, 0, be.28190
.count dual_jmp
	b       bne.28735
ble.28189:
	be      $i2, 0, bne.28735
be.28190:
	add     $i1, 1, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.28194
bne.28194:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 7], $f1
	fsub    $f2, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 9], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.28195
be.28195:
	load    [$i2 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.28197
bg.28196:
	load    [$i2 + 5], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.28197
bg.28197:
	load    [$i2 + 6], $f1
	fabs    $f6, $f5
	load    [$i2 + 10], $i2
	ble     $f1, $f5, ble.28208
.count dual_jmp
	b       bg.28208
ble.28197:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.28735
.count dual_jmp
	b       be.28209
bne.28195:
	bne     $i4, 2, bne.28201
be.28201:
	load    [$i2 + 4], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f6, $f6
	load    [$i2 + 10], $i2
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.28208
.count dual_jmp
	b       bg.28208
bne.28201:
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $f8
	fmul    $f5, $f5, $f9
	load    [$i2 + 5], $f10
	fmul    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i2 + 3], $i5
	fmul    $f9, $f10, $f9
	load    [$i2 + 6], $f10
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i5, 0, be.28206
bne.28206:
	fmul    $f5, $f6, $f8
	load    [$i2 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i2 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i2 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i4, 3, be.28207
.count dual_jmp
	b       bne.28207
be.28206:
	mov     $f7, $f1
	be      $i4, 3, be.28207
bne.28207:
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.28208
.count dual_jmp
	b       bg.28208
be.28207:
	fsub    $f1, $fc0, $f1
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.28208
bg.28208:
	be      $i2, 0, be.28209
.count dual_jmp
	b       bne.28735
ble.28208:
	be      $i2, 0, bne.28735
be.28209:
	add     $i1, 2, $i1
	b       check_all_inside.2856
bne.28735:
	li      0, $i1
	ret     
be.28194:
	li      1, $i1
	ret     
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i6, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra]
######################################################################
.align 2
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i6], $i1
	be      $i1, -1, be.28237
bne.28213:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i4
	load    [$i2 + 1], $i5
	load    [$i2 + 7], $f1
	load    [$i2 + 8], $f2
	fsub    $fg1, $f1, $f1
	load    [$i2 + 9], $f3
	fsub    $fg3, $f2, $f2
	load    [$i4 + $i1], $i4
	fsub    $fg2, $f3, $f3
	load    [$i4 + 0], $f4
	bne     $i5, 1, bne.28214
be.28214:
	load    [$i4 + 1], $f5
	fsub    $f4, $f1, $f4
	load    [$i2 + 5], $f6
	fmul    $f4, $f5, $f4
	load    [%{ext_light_dirvec + 0} + 1], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f2, $f7
	ble     $f6, $f7, be.28217
bg.28215:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28217
bg.28216:
	bne     $f5, $f0, bne.28217
be.28217:
	load    [$i4 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i4 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f6
	load    [%{ext_light_dirvec + 0} + 0], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f6, $f7, be.28221
bg.28219:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28221
bg.28220:
	be      $f5, $f0, be.28221
bne.28217:
	mov     $f4, $fg0
.count load_float
	load    [f.27978], $f1
	ble     $f1, $fg0, ble.28235
.count dual_jmp
	b       bg.28235
be.28221:
	load    [$i4 + 4], $f4
	load    [$i4 + 5], $f5
	fsub    $f4, $f3, $f3
	load    [$i2 + 4], $f6
	fmul    $f3, $f5, $f3
	load    [%{ext_light_dirvec + 0} + 0], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f6, $f1, ble.28235
bg.28223:
	load    [%{ext_light_dirvec + 0} + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i2 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.28235
bg.28224:
	be      $f5, $f0, ble.28235
bne.28225:
	mov     $f3, $fg0
.count load_float
	load    [f.27978], $f1
	ble     $f1, $fg0, ble.28235
.count dual_jmp
	b       bg.28235
bne.28214:
	be      $i5, 2, be.28227
bne.28227:
	be      $f4, $f0, ble.28235
bne.28229:
	load    [$i4 + 2], $f6
	fmul    $f6, $f2, $f6
	load    [$i4 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i4 + 3], $f7
	fmul    $f7, $f3, $f7
	fmul    $f1, $f1, $f8
	load    [$i2 + 5], $f10
	fadd    $f5, $f6, $f5
	load    [$i2 + 4], $f6
	fmul    $f2, $f2, $f9
	load    [$i2 + 3], $i7
	fadd    $f5, $f7, $f5
	fmul    $f8, $f6, $f6
	fmul    $f9, $f10, $f7
	load    [$i2 + 6], $f9
	fmul    $f3, $f3, $f8
	fadd    $f6, $f7, $f6
	fmul    $f8, $f9, $f7
	fadd    $f6, $f7, $f6
	be      $i7, 0, be.28230
bne.28230:
	fmul    $f2, $f3, $f7
	load    [$i2 + 16], $f8
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f9
	fmul    $f7, $f8, $f7
	fmul    $f1, $f2, $f1
	fmul    $f3, $f9, $f2
	fadd    $f6, $f7, $f3
	load    [$i2 + 18], $f6
	fadd    $f3, $f2, $f2
	fmul    $f1, $f6, $f1
	fadd    $f2, $f1, $f1
	be      $i5, 3, be.28231
.count dual_jmp
	b       bne.28231
be.28230:
	mov     $f6, $f1
	be      $i5, 3, be.28231
bne.28231:
	fmul    $f5, $f5, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, ble.28235
.count dual_jmp
	b       bg.28232
be.28231:
	fsub    $f1, $fc0, $f1
	fmul    $f5, $f5, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, ble.28235
bg.28232:
	load    [$i2 + 10], $i2
	load    [$i4 + 4], $f2
	fsqrt   $f1, $f1
	be      $i2, 0, be.28233
bne.28233:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.27978], $f1
	ble     $f1, $fg0, ble.28235
.count dual_jmp
	b       bg.28235
be.28233:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.27978], $f1
	ble     $f1, $fg0, ble.28235
.count dual_jmp
	b       bg.28235
be.28227:
	ble     $f0, $f4, ble.28235
bg.28228:
	load    [$i4 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i4 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i4 + 3], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $fg0
.count load_float
	load    [f.27978], $f1
	bg      $f1, $fg0, bg.28235
ble.28235:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.28747
be.28237:
	li      0, $i1
	jr      $ra1
bg.28235:
	load    [$i3 + 0], $i1
	be      $i1, -1, bne.28257
bne.28238:
.count load_float
	load    [f.27979], $f1
	load    [ext_objects + $i1], $i1
	fadd    $fg0, $f1, $f1
	load    [$i1 + 8], $f5
	fmul    $fg16, $f1, $f2
	load    [$i1 + 9], $f6
	fmul    $fg14, $f1, $f3
	fmul    $fg15, $f1, $f1
	load    [$i1 + 1], $i2
	fadd    $f2, $fg1, $f2
	fadd    $f3, $fg3, $f3
	fadd    $f1, $fg2, $f4
	load    [$i1 + 7], $f1
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	fsub    $f2, $f1, $f1
	bne     $i2, 1, bne.28239
be.28239:
	load    [$i1 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.28241
bg.28240:
	load    [$i1 + 5], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.28241
bg.28241:
	load    [$i1 + 6], $f1
	fabs    $f6, $f5
	load    [$i1 + 10], $i1
	ble     $f1, $f5, ble.28252
.count dual_jmp
	b       bg.28252
ble.28241:
	load    [$i1 + 10], $i1
	be      $i1, 0, bne.28747
.count dual_jmp
	b       be.28253
bne.28239:
	bne     $i2, 2, bne.28245
be.28245:
	load    [$i1 + 4], $f7
	load    [$i1 + 5], $f8
	fmul    $f7, $f1, $f1
	load    [$i1 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f6, $f6
	load    [$i1 + 10], $i1
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.28252
.count dual_jmp
	b       bg.28252
bne.28245:
	fmul    $f1, $f1, $f7
	load    [$i1 + 4], $f8
	fmul    $f5, $f5, $f9
	load    [$i1 + 5], $f10
	fmul    $f7, $f8, $f7
	load    [$i1 + 3], $i4
	fmul    $f6, $f6, $f8
	fmul    $f9, $f10, $f9
	load    [$i1 + 6], $f10
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i4, 0, be.28250
bne.28250:
	fmul    $f5, $f6, $f8
	load    [$i1 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i1 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i1 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i2, 3, be.28251
.count dual_jmp
	b       bne.28251
be.28250:
	mov     $f7, $f1
	be      $i2, 3, be.28251
bne.28251:
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28252
.count dual_jmp
	b       bg.28252
be.28251:
	fsub    $f1, $fc0, $f1
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28252
bg.28252:
	be      $i1, 0, be.28253
.count dual_jmp
	b       bne.28747
ble.28252:
	be      $i1, 0, bne.28747
be.28253:
	li      1, $i1
	call    check_all_inside.2856
	be      $i1, 0, bne.28747
bne.28257:
	li      1, $i1
	jr      $ra1
bne.28747:
	add     $i6, 1, $i6
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i8, $i9)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i9 + $i8], $i1
	be      $i1, -1, be.28272
bne.28258:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28259:
	add     $i8, 1, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28260:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28261:
	add     $i8, 2, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28262:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28263:
	add     $i8, 3, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28264:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28265:
	add     $i8, 4, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28266:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28267:
	add     $i8, 5, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28268:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28269:
	add     $i8, 6, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28270:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28259
be.28271:
	add     $i8, 7, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.28272
bne.28272:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	be      $i1, 0, be.28273
bne.28259:
	li      1, $i1
	jr      $ra2
be.28273:
	add     $i8, 8, $i8
	b       shadow_check_one_or_group.2865
be.28272:
	li      0, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i10, $i11)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i11 + $i10], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.28274
bne.28274:
	be      $i1, 99, bne.28299
bne.28275:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i3
	load    [$i2 + 7], $f1
	fsub    $fg1, $f1, $f1
	load    [$i2 + 8], $f2
	fsub    $fg3, $f2, $f2
	load    [$i2 + 9], $f3
	fsub    $fg2, $f3, $f3
	load    [$i3 + $i1], $i1
	load    [$i2 + 1], $i3
	load    [$i1 + 0], $f4
	bne     $i3, 1, bne.28276
be.28276:
	load    [$i1 + 1], $f5
	fsub    $f4, $f1, $f4
	load    [$i2 + 5], $f6
	fmul    $f4, $f5, $f4
	load    [%{ext_light_dirvec + 0} + 1], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f2, $f7
	ble     $f6, $f7, be.28279
bg.28277:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28279
bg.28278:
	bne     $f5, $f0, bne.28279
be.28279:
	load    [$i1 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i1 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f6
	load    [%{ext_light_dirvec + 0} + 0], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f6, $f7, be.28283
bg.28281:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28283
bg.28282:
	be      $f5, $f0, be.28283
bne.28279:
	mov     $f4, $fg0
	ble     $fc7, $fg0, be.28328
.count dual_jmp
	b       bg.28297
be.28283:
	load    [$i1 + 4], $f4
	fsub    $f4, $f3, $f3
	load    [$i1 + 5], $f5
	fmul    $f3, $f5, $f3
	load    [$i2 + 4], $f6
	load    [%{ext_light_dirvec + 0} + 0], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f6, $f1, be.28328
bg.28285:
	load    [%{ext_light_dirvec + 0} + 1], $f1
	load    [$i2 + 5], $f4
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, be.28328
bg.28286:
	be      $f5, $f0, be.28328
bne.28287:
	mov     $f3, $fg0
	ble     $fc7, $fg0, be.28328
.count dual_jmp
	b       bg.28297
bne.28276:
	be      $i3, 2, be.28289
bne.28289:
	be      $f4, $f0, be.28328
bne.28291:
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f6
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i1 + 3], $f7
	fmul    $f7, $f3, $f7
	fmul    $f1, $f1, $f8
	load    [$i2 + 5], $f10
	fadd    $f5, $f6, $f5
	load    [$i2 + 4], $f6
	fmul    $f2, $f2, $f9
	load    [$i2 + 3], $i4
	fadd    $f5, $f7, $f5
	fmul    $f8, $f6, $f6
	fmul    $f9, $f10, $f7
	load    [$i2 + 6], $f9
	fmul    $f3, $f3, $f8
	fadd    $f6, $f7, $f6
	fmul    $f8, $f9, $f7
	fadd    $f6, $f7, $f6
	be      $i4, 0, be.28292
bne.28292:
	fmul    $f2, $f3, $f7
	load    [$i2 + 16], $f8
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f9
	fmul    $f7, $f8, $f7
	fmul    $f1, $f2, $f1
	fmul    $f3, $f9, $f2
	fadd    $f6, $f7, $f3
	load    [$i2 + 18], $f6
	fadd    $f3, $f2, $f2
	fmul    $f1, $f6, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28293
.count dual_jmp
	b       bne.28293
be.28292:
	mov     $f6, $f1
	be      $i3, 3, be.28293
bne.28293:
	fmul    $f5, $f5, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, be.28328
.count dual_jmp
	b       bg.28294
be.28293:
	fsub    $f1, $fc0, $f1
	fmul    $f5, $f5, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, be.28328
bg.28294:
	load    [$i2 + 10], $i2
	load    [$i1 + 4], $f2
	fsqrt   $f1, $f1
	be      $i2, 0, be.28295
bne.28295:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.28328
.count dual_jmp
	b       bg.28297
be.28295:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.28328
.count dual_jmp
	b       bg.28297
be.28289:
	ble     $f0, $f4, be.28328
bg.28290:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 3], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $fg0
	ble     $fc7, $fg0, be.28328
bg.28297:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.28328
bne.28298:
	load    [ext_and_net + $i1], $i3
	li      0, $i6
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28299:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.28328
bne.28300:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28301:
	load    [$i9 + 3], $i1
	be      $i1, -1, be.28328
bne.28302:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28303:
	load    [$i9 + 4], $i1
	be      $i1, -1, be.28328
bne.28304:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28305:
	load    [$i9 + 5], $i1
	be      $i1, -1, be.28328
bne.28306:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28307:
	load    [$i9 + 6], $i1
	be      $i1, -1, be.28328
bne.28308:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28309:
	load    [$i9 + 7], $i1
	be      $i1, -1, be.28328
bne.28310:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28299
be.28311:
	li      8, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.28328
bne.28299:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.28328
bne.28314:
	load    [ext_and_net + $i1], $i3
	li      0, $i6
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28315:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.28328
bne.28316:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28317:
	load    [$i9 + 3], $i1
	be      $i1, -1, be.28328
bne.28318:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28319:
	load    [$i9 + 4], $i1
	be      $i1, -1, be.28328
bne.28320:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28321:
	load    [$i9 + 5], $i1
	be      $i1, -1, be.28328
bne.28322:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28323:
	load    [$i9 + 6], $i1
	be      $i1, -1, be.28328
bne.28324:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28325:
	load    [$i9 + 7], $i1
	be      $i1, -1, be.28328
bne.28326:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.28315
be.28327:
	li      8, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.28328
bne.28315:
	li      1, $i1
	jr      $ra3
be.28328:
	add     $i10, 1, $i10
	b       shadow_check_one_or_matrix.2868
be.28274:
	li      0, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i6, $i3, $f11, $f12, $f13)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra]
######################################################################
.align 2
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i6], $i7
	be      $i7, -1, be.28365
bne.28329:
	load    [ext_objects + $i7], $i1
	mov     $fig0, $f1
	mov     $fig1, $f2
	load    [$i1 + 1], $i2
	load    [$i1 + 7], $f3
	fsub    $f1, $f3, $f1
	load    [$i1 + 8], $f4
	fsub    $f2, $f4, $f2
	load    [$i1 + 9], $f5
	mov     $fig2, $f3
	fsub    $f3, $f5, $f3
	bne     $i2, 1, bne.28330
be.28330:
	be      $f11, $f0, ble.28337
bne.28331:
	load    [$i1 + 10], $i2
	load    [$i1 + 4], $f4
	ble     $f0, $f11, ble.28332
bg.28332:
	be      $i2, 0, be.28333
.count dual_jmp
	b       bne.28750
ble.28332:
	be      $i2, 0, bne.28750
be.28333:
	finv    $f11, $f5
	fsub    $f4, $f1, $f4
	load    [$i1 + 5], $f6
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.28337
.count dual_jmp
	b       bg.28336
bne.28750:
	fneg    $f4, $f4
	finv    $f11, $f5
	load    [$i1 + 5], $f6
	fsub    $f4, $f1, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.28337
bg.28336:
	fmul    $f4, $f13, $f5
	load    [$i1 + 6], $f6
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.28337
bg.28337:
	mov     $f4, $fg0
	li      1, $i8
	ble     $fg0, $f0, bne.28762
.count dual_jmp
	b       bg.28366
ble.28337:
	be      $f12, $f0, ble.28345
bne.28339:
	load    [$i1 + 10], $i2
	load    [$i1 + 5], $f4
	ble     $f0, $f12, ble.28340
bg.28340:
	be      $i2, 0, be.28341
.count dual_jmp
	b       bne.28753
ble.28340:
	be      $i2, 0, bne.28753
be.28341:
	finv    $f12, $f5
	load    [$i1 + 6], $f6
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f13, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.28345
.count dual_jmp
	b       bg.28344
bne.28753:
	fneg    $f4, $f4
	load    [$i1 + 6], $f6
	finv    $f12, $f5
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f13, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.28345
bg.28344:
	fmul    $f4, $f11, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.28345
bg.28345:
	mov     $f4, $fg0
	li      2, $i8
	ble     $fg0, $f0, bne.28762
.count dual_jmp
	b       bg.28366
ble.28345:
	be      $f13, $f0, ble.28362
bne.28347:
	load    [$i1 + 10], $i2
	load    [$i1 + 6], $f4
	ble     $f0, $f13, ble.28348
bg.28348:
	be      $i2, 0, be.28349
.count dual_jmp
	b       bne.28759
ble.28348:
	be      $i2, 0, bne.28759
be.28349:
	finv    $f13, $f5
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f4
	fmul    $f3, $f5, $f3
	fmul    $f3, $f11, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.28362
.count dual_jmp
	b       bg.28352
bne.28759:
	fneg    $f4, $f4
	finv    $f13, $f5
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f4
	fmul    $f3, $f5, $f3
	fmul    $f3, $f11, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.28362
bg.28352:
	fmul    $f3, $f12, $f1
	load    [$i1 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.28362
bg.28353:
	mov     $f3, $fg0
	li      3, $i8
	ble     $fg0, $f0, bne.28762
.count dual_jmp
	b       bg.28366
bne.28330:
	bne     $i2, 2, bne.28355
be.28355:
	load    [$i1 + 4], $f4
	fmul    $f11, $f4, $f7
	load    [$i1 + 5], $f5
	fmul    $f12, $f5, $f8
	load    [$i1 + 6], $f6
	fmul    $f13, $f6, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	ble     $f7, $f0, ble.28362
bg.28356:
	fmul    $f4, $f1, $f1
	fmul    $f5, $f2, $f2
	li      1, $i8
	fmul    $f6, $f3, $f3
	finv    $f7, $f4
	fadd    $f1, $f2, $f1
	fadd_n  $f1, $f3, $f1
	fmul    $f1, $f4, $fg0
	ble     $fg0, $f0, bne.28762
.count dual_jmp
	b       bg.28366
bne.28355:
	fmul    $f11, $f11, $f4
	load    [$i1 + 4], $f5
	fmul    $f12, $f12, $f6
	load    [$i1 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f13, $f13, $f8
	load    [$i1 + 6], $f9
	fmul    $f6, $f7, $f6
	load    [$i1 + 3], $i4
	fadd    $f4, $f6, $f4
	fmul    $f8, $f9, $f6
	fadd    $f4, $f6, $f4
	be      $i4, 0, be.28357
bne.28357:
	fmul    $f12, $f13, $f6
	load    [$i1 + 16], $f8
	fmul    $f13, $f11, $f10
	load    [$i1 + 17], $f14
	fmul    $f6, $f8, $f6
	fmul    $f11, $f12, $f8
	fmul    $f10, $f14, $f10
	fadd    $f4, $f6, $f4
	load    [$i1 + 18], $f6
	fadd    $f4, $f10, $f4
	fmul    $f8, $f6, $f6
	fadd    $f4, $f6, $f4
	be      $f4, $f0, ble.28362
.count dual_jmp
	b       bne.28358
be.28357:
	be      $f4, $f0, ble.28362
bne.28358:
	fmul    $f11, $f1, $f6
	fmul    $f12, $f2, $f8
	fmul    $f13, $f3, $f10
	fmul    $f6, $f5, $f6
	fmul    $f8, $f7, $f8
	fmul    $f10, $f9, $f10
	fadd    $f6, $f8, $f6
	fadd    $f6, $f10, $f6
	be      $i4, 0, be.28359
bne.28359:
	fmul    $f13, $f2, $f8
	load    [$i1 + 16], $f14
	fmul    $f12, $f3, $f10
	fmul    $f11, $f3, $f15
	fmul    $f13, $f1, $f16
	fadd    $f8, $f10, $f8
	load    [$i1 + 17], $f10
	fadd    $f15, $f16, $f15
	fmul    $f8, $f14, $f8
	fmul    $f11, $f2, $f14
	fmul    $f12, $f1, $f16
	fmul    $f15, $f10, $f10
	load    [$i1 + 18], $f15
	fadd    $f14, $f16, $f14
	fadd    $f8, $f10, $f8
	fmul    $f14, $f15, $f10
	fmul    $f3, $f3, $f14
	fadd    $f8, $f10, $f8
	fmul    $f2, $f2, $f10
	fmul    $f8, $fc2, $f8
	fmul    $f10, $f7, $f7
	fadd    $f6, $f8, $f6
	fmul    $f1, $f1, $f8
	fmul    $f8, $f5, $f5
	fmul    $f14, $f9, $f8
	fadd    $f5, $f7, $f5
	fadd    $f5, $f8, $f5
	be      $i4, 0, be.28360
.count dual_jmp
	b       bne.28360
be.28359:
	fmul    $f1, $f1, $f8
	fmul    $f2, $f2, $f10
	fmul    $f3, $f3, $f14
	fmul    $f8, $f5, $f5
	fmul    $f10, $f7, $f7
	fmul    $f14, $f9, $f8
	fadd    $f5, $f7, $f5
	fadd    $f5, $f8, $f5
	be      $i4, 0, be.28360
bne.28360:
	fmul    $f2, $f3, $f7
	load    [$i1 + 16], $f8
	fmul    $f3, $f1, $f3
	load    [$i1 + 17], $f9
	fmul    $f7, $f8, $f7
	fmul    $f1, $f2, $f1
	fmul    $f3, $f9, $f2
	fadd    $f5, $f7, $f3
	load    [$i1 + 18], $f5
	fadd    $f3, $f2, $f2
	fmul    $f1, $f5, $f1
	fadd    $f2, $f1, $f1
	be      $i2, 3, be.28361
.count dual_jmp
	b       bne.28361
be.28360:
	mov     $f5, $f1
	be      $i2, 3, be.28361
bne.28361:
	fmul    $f6, $f6, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, ble.28362
.count dual_jmp
	b       bg.28362
be.28361:
	fsub    $f1, $fc0, $f1
	fmul    $f6, $f6, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	bg      $f1, $f0, bg.28362
ble.28362:
	load    [ext_objects + $i7], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.28762
be.28365:
	jr      $ra1
bg.28362:
	fsqrt   $f1, $f1
	load    [$i1 + 10], $i1
	li      1, $i8
	finv    $f4, $f2
	be      $i1, 0, be.28363
bne.28363:
	fsub    $f1, $f6, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.28762
.count dual_jmp
	b       bg.28366
be.28363:
	fneg    $f1, $f1
	fsub    $f1, $f6, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.28762
bg.28366:
	ble     $fg11, $fg0, bne.28762
bg.28367:
.count load_float
	load    [f.27979], $f1
	fadd    $fg0, $f1, $f14
	mov     $fig0, $f2
	fmul    $f11, $f14, $f4
	mov     $fig1, $f3
	fmul    $f12, $f14, $f5
	mov     $fig2, $f1
	fmul    $f13, $f14, $f6
	load    [$i3 + 0], $i1
	fadd    $f4, $f2, $f2
	fadd    $f5, $f3, $f3
	fadd    $f6, $f1, $f4
	be      $i1, -1, bne.28387
bne.28368:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 7], $f1
	fsub    $f2, $f1, $f1
	load    [$i1 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i1 + 9], $f6
	fsub    $f4, $f6, $f6
	load    [$i1 + 1], $i2
	bne     $i2, 1, bne.28369
be.28369:
	load    [$i1 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.28371
bg.28370:
	load    [$i1 + 5], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.28371
bg.28371:
	load    [$i1 + 6], $f1
	fabs    $f6, $f5
	load    [$i1 + 10], $i1
	ble     $f1, $f5, ble.28382
.count dual_jmp
	b       bg.28382
ble.28371:
	load    [$i1 + 10], $i1
	be      $i1, 0, bne.28762
.count dual_jmp
	b       be.28383
bne.28369:
	bne     $i2, 2, bne.28375
be.28375:
	load    [$i1 + 4], $f7
	load    [$i1 + 5], $f8
	fmul    $f7, $f1, $f1
	load    [$i1 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f6, $f6
	load    [$i1 + 10], $i1
	fadd    $f1, $f5, $f1
	fadd    $f1, $f6, $f1
	ble     $f0, $f1, ble.28382
.count dual_jmp
	b       bg.28382
bne.28375:
	fmul    $f1, $f1, $f7
	load    [$i1 + 4], $f8
	fmul    $f5, $f5, $f9
	load    [$i1 + 5], $f10
	fmul    $f7, $f8, $f7
	load    [$i1 + 3], $i4
	fmul    $f6, $f6, $f8
	fmul    $f9, $f10, $f9
	load    [$i1 + 6], $f10
	fadd    $f7, $f9, $f7
	fmul    $f8, $f10, $f8
	fadd    $f7, $f8, $f7
	be      $i4, 0, be.28380
bne.28380:
	fmul    $f5, $f6, $f8
	load    [$i1 + 16], $f9
	fmul    $f6, $f1, $f6
	load    [$i1 + 17], $f10
	fmul    $f8, $f9, $f8
	fmul    $f1, $f5, $f1
	fmul    $f6, $f10, $f5
	fadd    $f7, $f8, $f6
	load    [$i1 + 18], $f7
	fadd    $f6, $f5, $f5
	fmul    $f1, $f7, $f1
	fadd    $f5, $f1, $f1
	be      $i2, 3, be.28381
.count dual_jmp
	b       bne.28381
be.28380:
	mov     $f7, $f1
	be      $i2, 3, be.28381
bne.28381:
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28382
.count dual_jmp
	b       bg.28382
be.28381:
	fsub    $f1, $fc0, $f1
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28382
bg.28382:
	be      $i1, 0, be.28383
.count dual_jmp
	b       bne.28762
ble.28382:
	be      $i1, 0, bne.28762
be.28383:
	li      1, $i1
	call    check_all_inside.2856
	be      $i1, 0, bne.28762
bne.28387:
	mov     $f14, $fg11
	mov     $f2, $fg1
	mov     $i7, $ig3
	mov     $f3, $fg3
	mov     $i8, $ig2
	mov     $f4, $fg2
	add     $i6, 1, $i6
	b       solve_each_element.2871
bne.28762:
	add     $i6, 1, $i6
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i9, $i10, $f11, $f12, $f13)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.28395
bne.28388:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 1, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28389:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 2, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28390:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 3, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28391:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 4, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28392:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 5, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28393:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 6, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28394:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 7, $i1
	load    [$i10 + $i1], $i1
	be      $i1, -1, be.28395
bne.28395:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i9, 8, $i9
	b       solve_one_or_network.2875
be.28395:
	jr      $ra2
.end solve_one_or_network

######################################################################
# trace_or_matrix($i11, $i12, $f11, $f12, $f13)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.28396
bne.28396:
	be      $i1, 99, bg.28440
bne.28397:
	load    [ext_objects + $i1], $i1
	mov     $fig0, $f1
	mov     $fig1, $f2
	load    [$i1 + 7], $f3
	load    [$i1 + 8], $f4
	fsub    $f1, $f3, $f1
	load    [$i1 + 9], $f5
	fsub    $f2, $f4, $f2
	mov     $fig2, $f3
	fsub    $f3, $f5, $f3
	load    [$i1 + 1], $i2
	bne     $i2, 1, bne.28405
be.28405:
	be      $f11, $f0, ble.28412
bne.28406:
	load    [$i1 + 10], $i2
	load    [$i1 + 4], $f4
	ble     $f0, $f11, ble.28407
bg.28407:
	be      $i2, 0, be.28408
.count dual_jmp
	b       bne.28765
ble.28407:
	be      $i2, 0, bne.28765
be.28408:
	finv    $f11, $f5
	fsub    $f4, $f1, $f4
	load    [$i1 + 5], $f6
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.28412
.count dual_jmp
	b       bg.28411
bne.28765:
	fneg    $f4, $f4
	finv    $f11, $f5
	load    [$i1 + 5], $f6
	fsub    $f4, $f1, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.28412
bg.28411:
	fmul    $f4, $f13, $f5
	load    [$i1 + 6], $f6
	fadd_a  $f5, $f3, $f5
	bg      $f6, $f5, bg.28412
ble.28412:
	be      $f12, $f0, ble.28420
bne.28414:
	load    [$i1 + 10], $i2
	load    [$i1 + 5], $f4
	ble     $f0, $f12, ble.28415
bg.28415:
	be      $i2, 0, be.28416
.count dual_jmp
	b       bne.28768
ble.28415:
	be      $i2, 0, bne.28768
be.28416:
	finv    $f12, $f5
	load    [$i1 + 6], $f6
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f13, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.28420
.count dual_jmp
	b       bg.28419
bne.28768:
	fneg    $f4, $f4
	load    [$i1 + 6], $f6
	finv    $f12, $f5
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	fmul    $f4, $f13, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.28420
bg.28419:
	fmul    $f4, $f11, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.28420
bg.28412:
	mov     $f4, $fg0
	ble     $fg11, $fg0, be.28447
.count dual_jmp
	b       bg.28440
ble.28420:
	be      $f13, $f0, be.28447
bne.28422:
	load    [$i1 + 10], $i2
	load    [$i1 + 6], $f4
	ble     $f0, $f13, ble.28423
bg.28423:
	be      $i2, 0, be.28424
.count dual_jmp
	b       bne.28771
ble.28423:
	be      $i2, 0, bne.28771
be.28424:
	finv    $f13, $f5
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f4
	fmul    $f3, $f5, $f3
	fmul    $f3, $f11, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.28447
.count dual_jmp
	b       bg.28427
bne.28771:
	fneg    $f4, $f4
	finv    $f13, $f5
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f4
	fmul    $f3, $f5, $f3
	fmul    $f3, $f11, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.28447
bg.28427:
	fmul    $f3, $f12, $f1
	load    [$i1 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, be.28447
bg.28428:
	mov     $f3, $fg0
	ble     $fg11, $fg0, be.28447
.count dual_jmp
	b       bg.28440
bne.28405:
	bne     $i2, 2, bne.28430
be.28430:
	load    [$i1 + 4], $f4
	fmul    $f11, $f4, $f7
	load    [$i1 + 5], $f5
	fmul    $f12, $f5, $f8
	load    [$i1 + 6], $f6
	fmul    $f13, $f6, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	ble     $f7, $f0, be.28447
bg.28431:
	fmul    $f4, $f1, $f1
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	finv    $f7, $f4
	fadd    $f1, $f2, $f1
	fadd_n  $f1, $f3, $f1
	fmul    $f1, $f4, $fg0
	ble     $fg11, $fg0, be.28447
.count dual_jmp
	b       bg.28440
bne.28430:
	fmul    $f11, $f11, $f4
	load    [$i1 + 4], $f5
	fmul    $f12, $f12, $f6
	load    [$i1 + 5], $f7
	fmul    $f4, $f5, $f4
	load    [$i1 + 6], $f9
	fmul    $f13, $f13, $f8
	load    [$i1 + 3], $i3
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	fmul    $f8, $f9, $f6
	fadd    $f4, $f6, $f4
	be      $i3, 0, be.28432
bne.28432:
	fmul    $f12, $f13, $f6
	load    [$i1 + 16], $f8
	fmul    $f13, $f11, $f10
	load    [$i1 + 17], $f14
	fmul    $f6, $f8, $f6
	fmul    $f11, $f12, $f8
	fmul    $f10, $f14, $f10
	fadd    $f4, $f6, $f4
	load    [$i1 + 18], $f6
	fadd    $f4, $f10, $f4
	fmul    $f8, $f6, $f6
	fadd    $f4, $f6, $f4
	be      $f4, $f0, be.28447
.count dual_jmp
	b       bne.28433
be.28432:
	be      $f4, $f0, be.28447
bne.28433:
	fmul    $f11, $f1, $f6
	fmul    $f12, $f2, $f8
	fmul    $f13, $f3, $f10
	fmul    $f6, $f5, $f6
	fmul    $f8, $f7, $f8
	fmul    $f10, $f9, $f10
	fadd    $f6, $f8, $f6
	fadd    $f6, $f10, $f6
	be      $i3, 0, be.28434
bne.28434:
	fmul    $f13, $f2, $f8
	fmul    $f12, $f3, $f10
	load    [$i1 + 16], $f14
	fmul    $f11, $f3, $f15
	fmul    $f13, $f1, $f16
	fadd    $f8, $f10, $f8
	load    [$i1 + 17], $f10
	fadd    $f15, $f16, $f15
	fmul    $f8, $f14, $f8
	fmul    $f11, $f2, $f14
	fmul    $f12, $f1, $f16
	fmul    $f15, $f10, $f10
	load    [$i1 + 18], $f15
	fadd    $f14, $f16, $f14
	fadd    $f8, $f10, $f8
	fmul    $f14, $f15, $f10
	fmul    $f3, $f3, $f14
	fadd    $f8, $f10, $f8
	fmul    $f2, $f2, $f10
	fmul    $f8, $fc2, $f8
	fmul    $f10, $f7, $f7
	fadd    $f6, $f8, $f6
	fmul    $f1, $f1, $f8
	fmul    $f8, $f5, $f5
	fmul    $f14, $f9, $f8
	fadd    $f5, $f7, $f5
	fadd    $f5, $f8, $f5
	be      $i3, 0, be.28435
.count dual_jmp
	b       bne.28435
be.28434:
	fmul    $f1, $f1, $f8
	fmul    $f2, $f2, $f10
	fmul    $f3, $f3, $f14
	fmul    $f8, $f5, $f5
	fmul    $f10, $f7, $f7
	fmul    $f14, $f9, $f8
	fadd    $f5, $f7, $f5
	fadd    $f5, $f8, $f5
	be      $i3, 0, be.28435
bne.28435:
	fmul    $f2, $f3, $f7
	load    [$i1 + 16], $f8
	fmul    $f3, $f1, $f3
	load    [$i1 + 17], $f9
	fmul    $f7, $f8, $f7
	fmul    $f1, $f2, $f1
	fmul    $f3, $f9, $f2
	fadd    $f5, $f7, $f3
	load    [$i1 + 18], $f5
	fadd    $f3, $f2, $f2
	fmul    $f1, $f5, $f1
	fadd    $f2, $f1, $f1
	be      $i2, 3, be.28436
.count dual_jmp
	b       bne.28436
be.28435:
	mov     $f5, $f1
	be      $i2, 3, be.28436
bne.28436:
	fmul    $f6, $f6, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, be.28447
.count dual_jmp
	b       bg.28437
be.28436:
	fsub    $f1, $fc0, $f1
	fmul    $f6, $f6, $f2
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	ble     $f1, $f0, be.28447
bg.28437:
	fsqrt   $f1, $f1
	load    [$i1 + 10], $i1
	finv    $f4, $f2
	be      $i1, 0, be.28438
bne.28438:
	fsub    $f1, $f6, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg11, $fg0, be.28447
.count dual_jmp
	b       bg.28440
be.28438:
	fneg    $f1, $f1
	fsub    $f1, $f6, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg11, $fg0, be.28447
bg.28440:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.28447
bne.28441:
	load    [ext_and_net + $i1], $i3
	li      0, $i6
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 2], $i1
	be      $i1, -1, be.28447
bne.28442:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 3], $i1
	be      $i1, -1, be.28447
bne.28443:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 4], $i1
	be      $i1, -1, be.28447
bne.28444:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 5], $i1
	be      $i1, -1, be.28447
bne.28445:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 6], $i1
	be      $i1, -1, be.28447
bne.28446:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i10 + 7], $i1
	be      $i1, -1, be.28447
bne.28447:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      8, $i9
	jal     solve_one_or_network.2875, $ra2
	add     $i11, 1, $i11
	b       trace_or_matrix.2879
be.28447:
	add     $i11, 1, $i11
	b       trace_or_matrix.2879
be.28396:
	jr      $ra3
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i6, $i3, $f11, $f12, $f13, $i7)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i6, $i8 - $i9]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra]
######################################################################
.align 2
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i6], $i8
	be      $i8, -1, be.28468
bne.28448:
	load    [ext_objects + $i8], $i1
	load    [$i7 + $i8], $i2
	load    [$i1 + 1], $i4
	load    [$i1 + 19], $f1
	load    [$i1 + 20], $f2
	load    [$i1 + 21], $f3
	bne     $i4, 1, bne.28449
be.28449:
	load    [$i2 + 0], $f4
	load    [$i2 + 1], $f5
	fsub    $f4, $f1, $f4
	load    [$i1 + 5], $f6
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f7
	fadd_a  $f7, $f2, $f7
	ble     $f6, $f7, be.28452
bg.28450:
	fmul    $f4, $f13, $f6
	load    [$i1 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28452
bg.28451:
	be      $f5, $f0, be.28452
bne.28452:
	mov     $f4, $fg0
	li      1, $i9
	ble     $fg0, $f0, bne.28777
.count dual_jmp
	b       bg.28469
be.28452:
	load    [$i2 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i2 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i1 + 4], $f6
	fmul    $f4, $f11, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f6, $f7, be.28456
bg.28454:
	fmul    $f4, $f13, $f6
	load    [$i1 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28456
bg.28455:
	be      $f5, $f0, be.28456
bne.28456:
	mov     $f4, $fg0
	li      2, $i9
	ble     $fg0, $f0, bne.28777
.count dual_jmp
	b       bg.28469
be.28456:
	load    [$i2 + 4], $f4
	load    [$i2 + 5], $f5
	fsub    $f4, $f3, $f3
	load    [$i1 + 4], $f6
	fmul    $f3, $f5, $f3
	fmul    $f3, $f11, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f6, $f1, ble.28465
bg.28458:
	fmul    $f3, $f12, $f1
	load    [$i1 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.28465
bg.28459:
	be      $f5, $f0, ble.28465
bne.28460:
	mov     $f3, $fg0
	li      3, $i9
	ble     $fg0, $f0, bne.28777
.count dual_jmp
	b       bg.28469
bne.28449:
	be      $i4, 2, be.28462
bne.28462:
	load    [$i2 + 0], $f4
	be      $f4, $f0, ble.28465
bne.28464:
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
	ble     $f2, $f0, ble.28465
bg.28465:
	load    [$i1 + 10], $i1
	li      1, $i9
	load    [$i2 + 4], $f3
	fsqrt   $f2, $f2
	be      $i1, 0, be.28466
bne.28466:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.28777
.count dual_jmp
	b       bg.28469
be.28466:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.28777
.count dual_jmp
	b       bg.28469
be.28462:
	load    [$i2 + 0], $f1
	ble     $f0, $f1, ble.28465
bg.28463:
	load    [$i1 + 22], $f2
	li      1, $i9
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.28777
bg.28469:
	ble     $fg11, $fg0, bne.28777
bg.28470:
.count load_float
	load    [f.27979], $f1
	fadd    $fg0, $f1, $f14
	load    [$i3 + 0], $i1
	fmul    $f11, $f14, $f1
	fmul    $f12, $f14, $f2
	fmul    $f13, $f14, $f3
	fadd    $f1, $fg17, $f15
	fadd    $f2, $fg18, $f16
	fadd    $f3, $fg19, $f4
	be      $i1, -1, bne.28490
bne.28471:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 7], $f1
	load    [$i1 + 8], $f2
	fsub    $f15, $f1, $f1
	load    [$i1 + 9], $f3
	fsub    $f16, $f2, $f2
	fsub    $f4, $f3, $f3
	load    [$i1 + 1], $i2
	bne     $i2, 1, bne.28472
be.28472:
	load    [$i1 + 4], $f5
	fabs    $f1, $f1
	ble     $f5, $f1, ble.28474
bg.28473:
	load    [$i1 + 5], $f1
	fabs    $f2, $f2
	ble     $f1, $f2, ble.28474
bg.28474:
	load    [$i1 + 6], $f1
	fabs    $f3, $f2
	load    [$i1 + 10], $i1
	ble     $f1, $f2, ble.28485
.count dual_jmp
	b       bg.28485
ble.28474:
	load    [$i1 + 10], $i1
	be      $i1, 0, bne.28777
.count dual_jmp
	b       be.28486
bne.28472:
	bne     $i2, 2, bne.28478
be.28478:
	load    [$i1 + 4], $f5
	fmul    $f5, $f1, $f1
	load    [$i1 + 5], $f6
	fmul    $f6, $f2, $f2
	load    [$i1 + 6], $f7
	fmul    $f7, $f3, $f3
	load    [$i1 + 10], $i1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.28485
.count dual_jmp
	b       bg.28485
bne.28478:
	fmul    $f1, $f1, $f5
	load    [$i1 + 4], $f6
	fmul    $f2, $f2, $f7
	load    [$i1 + 5], $f8
	fmul    $f5, $f6, $f5
	fmul    $f3, $f3, $f6
	load    [$i1 + 3], $i4
	fmul    $f7, $f8, $f7
	load    [$i1 + 6], $f8
	fadd    $f5, $f7, $f5
	fmul    $f6, $f8, $f6
	fadd    $f5, $f6, $f5
	be      $i4, 0, be.28483
bne.28483:
	fmul    $f2, $f3, $f6
	load    [$i1 + 16], $f7
	fmul    $f3, $f1, $f3
	load    [$i1 + 17], $f8
	fmul    $f6, $f7, $f6
	fmul    $f1, $f2, $f1
	fmul    $f3, $f8, $f2
	fadd    $f5, $f6, $f3
	load    [$i1 + 18], $f5
	fadd    $f3, $f2, $f2
	fmul    $f1, $f5, $f1
	fadd    $f2, $f1, $f1
	be      $i2, 3, be.28484
.count dual_jmp
	b       bne.28484
be.28483:
	mov     $f5, $f1
	be      $i2, 3, be.28484
bne.28484:
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28485
.count dual_jmp
	b       bg.28485
be.28484:
	fsub    $f1, $fc0, $f1
	load    [$i1 + 10], $i1
	ble     $f0, $f1, ble.28485
bg.28485:
	be      $i1, 0, be.28486
.count dual_jmp
	b       bne.28777
ble.28485:
	be      $i1, 0, bne.28777
be.28486:
	li      1, $i1
.count move_args
	mov     $f15, $f2
.count move_args
	mov     $f16, $f3
	call    check_all_inside.2856
	be      $i1, 0, bne.28777
bne.28490:
	mov     $f14, $fg11
	mov     $i8, $ig3
	mov     $f15, $fg1
	mov     $i9, $ig2
	mov     $f16, $fg3
	add     $i6, 1, $i6
	mov     $f4, $fg2
	b       solve_each_element_fast.2885
ble.28465:
	load    [ext_objects + $i8], $i1
	load    [$i1 + 10], $i1
	be      $i1, 0, be.28468
bne.28777:
	add     $i6, 1, $i6
	b       solve_each_element_fast.2885
be.28468:
	jr      $ra1
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i10, $i11, $f11, $f12, $f13, $i7)
# $ra = $ra2
# [$i1 - $i6, $i8 - $i10]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.28498
bne.28491:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 1, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28492:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 2, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28493:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 3, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28494:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 4, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28495:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 5, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28496:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 6, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28497:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 7, $i1
	load    [$i11 + $i1], $i1
	be      $i1, -1, be.28498
bne.28498:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i10, 8, $i10
	b       solve_one_or_network_fast.2889
be.28498:
	jr      $ra2
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i12, $i13, $f11, $f12, $f13, $i7)
# $ra = $ra3
# [$i1 - $i6, $i8 - $i12]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i13 + $i12], $i11
	load    [$i11 + 0], $i1
	be      $i1, -1, be.28499
bne.28499:
	be      $i1, 99, bg.28527
bne.28500:
	load    [ext_objects + $i1], $i2
	load    [$i7 + $i1], $i1
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	load    [$i2 + 21], $f3
	load    [$i2 + 1], $i3
	bne     $i3, 1, bne.28508
be.28508:
	load    [$i1 + 0], $f4
	load    [$i1 + 1], $f5
	fsub    $f4, $f1, $f4
	load    [$i2 + 5], $f6
	fmul    $f4, $f5, $f4
	fmul    $f4, $f12, $f7
	fadd_a  $f7, $f2, $f7
	ble     $f6, $f7, be.28511
bg.28509:
	fmul    $f4, $f13, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28511
bg.28510:
	bne     $f5, $f0, bne.28511
be.28511:
	load    [$i1 + 2], $f4
	fsub    $f4, $f2, $f4
	load    [$i1 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f6
	fmul    $f4, $f11, $f7
	fadd_a  $f7, $f1, $f7
	ble     $f6, $f7, be.28515
bg.28513:
	fmul    $f4, $f13, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.28515
bg.28514:
	be      $f5, $f0, be.28515
bne.28511:
	mov     $f4, $fg0
	ble     $fg11, $fg0, be.28534
.count dual_jmp
	b       bg.28527
be.28515:
	load    [$i1 + 4], $f4
	fsub    $f4, $f3, $f3
	load    [$i1 + 5], $f5
	fmul    $f3, $f5, $f3
	load    [$i2 + 4], $f6
	fmul    $f3, $f11, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f6, $f1, be.28534
bg.28517:
	fmul    $f3, $f12, $f1
	load    [$i2 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, be.28534
bg.28518:
	be      $f5, $f0, be.28534
bne.28519:
	mov     $f3, $fg0
	ble     $fg11, $fg0, be.28534
.count dual_jmp
	b       bg.28527
bne.28508:
	be      $i3, 2, be.28521
bne.28521:
	load    [$i1 + 0], $f4
	be      $f4, $f0, be.28534
bne.28523:
	load    [$i1 + 1], $f5
	load    [$i1 + 2], $f6
	fmul    $f5, $f1, $f1
	load    [$i1 + 3], $f7
	fmul    $f6, $f2, $f2
	fmul    $f7, $f3, $f3
	load    [$i2 + 22], $f5
	fadd    $f1, $f2, $f1
	fmul    $f4, $f5, $f2
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f3
	fsub    $f3, $f2, $f2
	ble     $f2, $f0, be.28534
bg.28524:
	load    [$i2 + 10], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	be      $i2, 0, be.28525
bne.28525:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg11, $fg0, be.28534
.count dual_jmp
	b       bg.28527
be.28525:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg11, $fg0, be.28534
.count dual_jmp
	b       bg.28527
be.28521:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, be.28534
bg.28522:
	load    [$i2 + 22], $f2
	fmul    $f1, $f2, $fg0
	ble     $fg11, $fg0, be.28534
bg.28527:
	load    [$i11 + 1], $i1
	be      $i1, -1, be.28534
bne.28528:
	load    [ext_and_net + $i1], $i3
	li      0, $i6
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 2], $i1
	be      $i1, -1, be.28534
bne.28529:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 3], $i1
	be      $i1, -1, be.28534
bne.28530:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 4], $i1
	be      $i1, -1, be.28534
bne.28531:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 5], $i1
	be      $i1, -1, be.28534
bne.28532:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 6], $i1
	be      $i1, -1, be.28534
bne.28533:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i11 + 7], $i1
	be      $i1, -1, be.28534
bne.28534:
	li      0, $i6
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      8, $i10
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i12, 1, $i12
	b       trace_or_matrix_fast.2893
be.28534:
	add     $i12, 1, $i12
	b       trace_or_matrix_fast.2893
be.28499:
	jr      $ra3
.end trace_or_matrix_fast

######################################################################
# trace_reflections($i14, $f17, $f18, $f19, $f20, $f21)
# $ra = $ra4
# [$i1 - $i15]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg9, $fg11]
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_reflections
trace_reflections.2915:
	bl      $i14, 0, bl.28535
bge.28535:
	load    [ext_reflections + $i14], $i15
	mov     $fc9, $fg11
	li      0, $i12
	load    [$i15 + 4], $i7
.count move_args
	mov     $ig1, $i13
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	load    [$i15 + 3], $f13
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg11, $fc7, bne.28539
bg.28536:
	ble     $fc8, $fg11, bne.28539
bg.28537:
	add     $ig3, $ig3, $i1
	load    [$i15 + 0], $i2
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
	bne     $i1, $i2, bne.28539
be.28539:
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.28539
be.28540:
	load    [ext_nvector + 0], $f1
	load    [$i15 + 1], $f2
	fmul    $f1, $f2, $f1
	load    [ext_nvector + 1], $f3
	fmul    $f19, $f2, $f2
	load    [$i15 + 2], $f4
	fmul    $f3, $f4, $f3
	load    [ext_nvector + 2], $f5
	fadd    $f1, $f3, $f1
	load    [$i15 + 3], $f6
	fmul    $f5, $f6, $f3
	load    [$i15 + 5], $f7
	fmul    $f7, $f17, $f5
	fmul    $f20, $f4, $f4
	fadd    $f1, $f3, $f1
	fmul    $f21, $f6, $f3
	fadd    $f2, $f4, $f2
	fmul    $f5, $f1, $f1
	fadd    $f2, $f3, $f2
	fmul    $f7, $f2, $f2
	ble     $f1, $f0, ble.28541
bg.28541:
	fmul    $f1, $fg13, $f3
	fmul    $f1, $fg10, $f4
	fmul    $f1, $fg12, $f1
	fadd    $fg7, $f3, $fg7
	fadd    $fg8, $f4, $fg8
	fadd    $fg9, $f1, $fg9
	ble     $f2, $f0, bne.28539
.count dual_jmp
	b       bg.28542
ble.28541:
	ble     $f2, $f0, bne.28539
bg.28542:
	fmul    $f2, $f2, $f1
	add     $i14, -1, $i14
	fmul    $f1, $f1, $f1
	fmul    $f1, $f18, $f1
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f1, $fg8
	fadd    $fg9, $f1, $fg9
	b       trace_reflections.2915
bne.28539:
	add     $i14, -1, $i14
	b       trace_reflections.2915
bl.28535:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i16, $f22, $i17, $i18, $i19, $i20, $i21, $i22, $f23)
# $ra = $ra5
# [$i1 - $i16, $i23]
# [$f1 - $f23]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra4]
######################################################################
.align 2
.begin trace_ray
trace_ray.2920:
	bg      $i16, 4, bg.28543
ble.28543:
	mov     $fc9, $fg11
	li      0, $i11
	load    [$i17 + 0], $f11
	load    [$i17 + 1], $f12
.count move_args
	mov     $ig1, $i12
	load    [$i17 + 2], $f13
	jal     trace_or_matrix.2879, $ra3
	ble     $fg11, $fc7, ble.28545
bg.28544:
	bg      $fc8, $fg11, bg.28545
ble.28545:
	add     $i0, -1, $i1
.count storer
	add     $i19, $i16, $tmp
	store   $i1, [$tmp + 0]
	be      $i16, 0, bg.28543
bne.28547:
	load    [$i17 + 0], $f1
	fmul    $f1, $fg16, $f1
	load    [$i17 + 1], $f2
	fmul    $f2, $fg14, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $fg15, $f3
	fadd    $f1, $f2, $f1
	fadd_n  $f1, $f3, $f1
	ble     $f1, $f0, bg.28543
bg.28548:
	fmul    $f1, $f1, $f2
	mov     $fig9, $f3
	fmul    $f2, $f1, $f1
	fmul    $f1, $f22, $f1
	fmul    $f1, $f3, $f1
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f1, $fg8
	fadd    $fg9, $f1, $fg9
	jr      $ra5
bg.28545:
	load    [ext_objects + $ig3], $i23
	load    [$i23 + 1], $i1
	be      $i1, 1, be.28549
bne.28549:
	bne     $i1, 2, bne.28552
be.28552:
	load    [$i23 + 4], $f1
	fneg    $f1, $f1
	mov     $fg1, $fig0
	mov     $fg3, $fig1
	store   $f1, [ext_nvector + 0]
	load    [$i23 + 5], $f1
	mov     $fg2, $fig2
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i23 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
bne.28552:
	load    [$i23 + 7], $f1
	fsub    $fg1, $f1, $f1
	load    [$i23 + 8], $f2
	fsub    $fg3, $f2, $f2
	load    [$i23 + 9], $f3
	fsub    $fg2, $f3, $f3
	load    [$i23 + 4], $f4
	fmul    $f1, $f4, $f4
	load    [$i23 + 5], $f5
	fmul    $f2, $f5, $f5
	load    [$i23 + 6], $f6
	fmul    $f3, $f6, $f6
	load    [$i23 + 3], $i1
	be      $i1, 0, be.28553
bne.28553:
	load    [$i23 + 18], $f7
	fmul    $f2, $f7, $f7
	load    [$i23 + 17], $f8
	fmul    $f3, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc2, $f7
	fadd    $f4, $f7, $f4
	store   $f4, [ext_nvector + 0]
	load    [$i23 + 18], $f4
	fmul    $f1, $f4, $f4
	load    [$i23 + 16], $f7
	fmul    $f3, $f7, $f3
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc2, $f3
	fadd    $f5, $f3, $f3
	store   $f3, [ext_nvector + 1]
	load    [$i23 + 17], $f3
	fmul    $f1, $f3, $f1
	load    [$i23 + 16], $f4
	fmul    $f2, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc2, $f1
	fadd    $f6, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i23 + 10], $i1
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f4
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.28554
.count dual_jmp
	b       bne.28554
be.28553:
	store   $f4, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f6, [ext_nvector + 2]
	load    [$i23 + 10], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $f1, $f4
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.28554
be.28554:
	mov     $fc0, $f2
	mov     $fg1, $fig0
	fmul    $f1, $f2, $f1
	mov     $fg3, $fig1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	mov     $fg2, $fig2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
bne.28554:
	mov     $fg2, $fig2
	mov     $fg3, $fig1
	mov     $fg1, $fig0
	be      $i1, 0, be.28555
bne.28555:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
be.28555:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
be.28549:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	load    [$i17 + $i1], $f1
	mov     $fg2, $fig2
	mov     $fg3, $fig1
	mov     $fg1, $fig0
	bne     $f1, $f0, bne.28550
be.28550:
	mov     $f0, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
bne.28550:
	ble     $f1, $f0, ble.28551
bg.28551:
	mov     $fc0, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
.count dual_jmp
	b       bne.28556
ble.28551:
	mov     $fc6, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i23 + 0], $i1
	load    [$i23 + 13], $fg13
	load    [$i23 + 14], $fg10
	load    [$i23 + 15], $fg12
	be      $i1, 1, be.28556
bne.28556:
	bne     $i1, 2, bne.28562
be.28562:
	fmul    $fg3, $fc12, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	add     $ig3, $ig3, $i1
	fsub    $fc0, $f1, $f2
	add     $i1, $i1, $i1
	fmul    $fc1, $f1, $fg13
.count storer
	add     $i19, $i16, $tmp
	fmul    $fc1, $f2, $fg10
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
bne.28562:
	bne     $i1, 3, bne.28563
be.28563:
	load    [$i23 + 7], $f1
	load    [$i23 + 9], $f2
	fsub    $fg1, $f1, $f1
	fsub    $fg2, $f2, $f2
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc3, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc16, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	add     $ig3, $ig3, $i1
	fsub    $fc0, $f1, $f2
	add     $i1, $i1, $i1
	fmul    $f1, $fc1, $fg10
.count storer
	add     $i19, $i16, $tmp
	fmul    $f2, $fc1, $fg12
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
bne.28563:
	be      $i1, 4, be.28564
bne.28564:
	add     $ig3, $ig3, $i1
.count storer
	add     $i19, $i16, $tmp
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
be.28564:
	load    [$i23 + 7], $f1
	fsub    $fg1, $f1, $f1
	load    [$i23 + 4], $f2
	fsqrt   $f2, $f2
	load    [$i23 + 6], $f3
	fsqrt   $f3, $f3
	load    [$i23 + 9], $f4
	fsub    $fg2, $f4, $f4
.count load_float
	load    [f.27983], $f9
	fmul    $f1, $f2, $f1
	fmul    $f4, $f3, $f2
	fmul    $f1, $f1, $f3
	fmul    $f2, $f2, $f4
	fabs    $f1, $f5
	fadd    $f3, $f4, $f10
	ble     $f9, $f5, ble.28565
bg.28565:
	mov     $fc5, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	load    [$i23 + 5], $f2
	load    [$i23 + 8], $f3
	fsub    $f4, $f1, $f11
	fsqrt   $f2, $f1
	fsub    $fg3, $f3, $f2
	fabs    $f10, $f3
	fmul    $f2, $f1, $f1
	ble     $f9, $f3, ble.28566
.count dual_jmp
	b       bg.28566
ble.28565:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
	fmul    $fc4, $f1, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	load    [$i23 + 5], $f2
	fsub    $f4, $f1, $f11
	load    [$i23 + 8], $f3
	fsqrt   $f2, $f1
	fsub    $fg3, $f3, $f2
	fabs    $f10, $f3
	fmul    $f2, $f1, $f1
	ble     $f9, $f3, ble.28566
bg.28566:
	mov     $fc5, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc2, $f11, $f2
	fsub    $fc2, $f1, $f1
	fmul    $f2, $f2, $f2
	fmul    $f1, $f1, $f1
	fsub    $fc15, $f2, $f2
	fsub    $f2, $f1, $f1
	ble     $f0, $f1, ble.28567
.count dual_jmp
	b       bg.28567
ble.28566:
	finv    $f10, $f2
	fmul_a  $f1, $f2, $f2
	call    ext_atan
	fmul    $fc4, $f1, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc2, $f11, $f2
	fsub    $fc2, $f1, $f1
	fmul    $f2, $f2, $f2
	fmul    $f1, $f1, $f1
	fsub    $fc15, $f2, $f2
	fsub    $f2, $f1, $f1
	ble     $f0, $f1, ble.28567
bg.28567:
	add     $ig3, $ig3, $i1
	mov     $f0, $f1
	add     $i1, $i1, $i1
	fmul    $fc14, $f1, $fg12
	add     $i1, $ig2, $i1
.count storer
	add     $i19, $i16, $tmp
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
ble.28567:
	add     $ig3, $ig3, $i1
	fmul    $fc14, $f1, $fg12
	add     $i1, $i1, $i1
.count storer
	add     $i19, $i16, $tmp
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
be.28556:
	load    [$i23 + 7], $f1
	fsub    $fg1, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28557
bg.28557:
	load    [$i23 + 9], $f1
	li      1, $i1
	fsub    $fg2, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28558
.count dual_jmp
	b       bg.28558
ble.28557:
	load    [$i23 + 9], $f1
	li      0, $i1
	fsub    $fg2, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28558
bg.28558:
	be      $i1, 0, be.28781
.count dual_jmp
	b       bne.28780
ble.28558:
	be      $i1, 0, bne.28780
be.28781:
	add     $ig3, $ig3, $i1
	mov     $f0, $fg10
	add     $i1, $i1, $i1
.count storer
	add     $i19, $i16, $tmp
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
.count dual_jmp
	b       bg.28568
bne.28780:
	add     $ig3, $ig3, $i1
	mov     $fc1, $fg10
	add     $i1, $i1, $i1
.count storer
	add     $i19, $i16, $tmp
	add     $i1, $ig2, $i1
	store   $i1, [$tmp + 0]
	load    [$i18 + $i16], $i1
	store   $fg1, [$i1 + 0]
	store   $fg3, [$i1 + 1]
	store   $fg2, [$i1 + 2]
	load    [$i23 + 11], $f1
	fmul    $f1, $f22, $f17
	ble     $fc2, $f1, ble.28568
bg.28568:
	li      0, $i1
.count storer
	add     $i20, $i16, $tmp
	store   $i1, [$tmp + 0]
	li      0, $i10
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.28001], $f2
.count move_args
	mov     $ig1, $i11
	load    [$i17 + 0], $f3
	fmul    $f3, $f1, $f6
	load    [$i17 + 1], $f4
	load    [ext_nvector + 1], $f5
	load    [$i17 + 2], $f7
	fmul    $f4, $f5, $f4
	load    [ext_nvector + 2], $f5
	fadd    $f6, $f4, $f4
	fmul    $f7, $f5, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 1], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 1]
	load    [ext_nvector + 2], $f1
	load    [$i17 + 2], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 2]
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i23 + 12], $f1
	fmul    $f22, $f1, $f18
	be      $i1, 0, be.28569
.count dual_jmp
	b       bne.28569
ble.28568:
	li      1, $i1
.count storer
	add     $i20, $i16, $tmp
.count load_float
	load    [f.28000], $f1
	store   $i1, [$tmp + 0]
	fmul    $f1, $f17, $f1
	load    [$i21 + $i16], $i1
	li      0, $i10
	store   $fg13, [$i1 + 0]
.count move_args
	mov     $ig1, $i11
	store   $fg10, [$i1 + 1]
	store   $fg12, [$i1 + 2]
	load    [$i21 + $i16], $i1
	load    [$i1 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i1 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i22 + $i16], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.28001], $f2
	load    [$i17 + 0], $f3
	load    [$i17 + 1], $f4
	fmul    $f3, $f1, $f6
	load    [ext_nvector + 1], $f5
	fmul    $f4, $f5, $f4
	load    [$i17 + 2], $f7
	fadd    $f6, $f4, $f4
	load    [ext_nvector + 2], $f5
	fmul    $f7, $f5, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 0]
	load    [ext_nvector + 1], $f1
	load    [$i17 + 1], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 2], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 2]
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i23 + 12], $f1
	fmul    $f22, $f1, $f18
	bne     $i1, 0, bne.28569
be.28569:
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $fg16, $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $fg14, $f2
	fmul    $f3, $fg15, $f3
	load    [$i17 + 0], $f4
	load    [$i17 + 1], $f5
	fadd    $f1, $f2, $f1
	fmul    $f4, $fg16, $f2
	fmul    $f5, $fg14, $f4
	load    [$i17 + 2], $f5
	fadd_n  $f1, $f3, $f1
	fadd    $f2, $f4, $f2
	fmul    $f5, $fg15, $f3
	fmul    $f1, $f17, $f1
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, ble.28570
bg.28570:
	fmul    $f1, $fg13, $f3
	fmul    $f1, $fg10, $f4
	fmul    $f1, $fg12, $f1
	fadd    $fg7, $f3, $fg7
	fadd    $fg8, $f4, $fg8
	fadd    $fg9, $f1, $fg9
	ble     $f2, $f0, bne.28569
.count dual_jmp
	b       bg.28571
ble.28570:
	ble     $f2, $f0, bne.28569
bg.28571:
	fmul    $f2, $f2, $f1
	add     $ig0, -1, $i1
	mov     $fg1, $fg17
	mov     $fg3, $fg18
	fmul    $f1, $f1, $f1
	mov     $fg2, $fg19
	fmul    $f1, $f18, $f1
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f1, $fg8
	fadd    $fg9, $f1, $fg9
	bge     $i1, 0, bge.28572
.count dual_jmp
	b       bl.28572
bne.28569:
	mov     $fg1, $fg17
	add     $ig0, -1, $i1
	mov     $fg3, $fg18
	mov     $fg2, $fg19
	bge     $i1, 0, bge.28572
bl.28572:
	add     $ig4, -1, $i14
	load    [$i17 + 0], $f19
	load    [$i17 + 1], $f20
	load    [$i17 + 2], $f21
	jal     trace_reflections.2915, $ra4
	ble     $f22, $fc3, bg.28543
.count dual_jmp
	b       bg.28577
bge.28572:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 7], $f1
	load    [$i2 + 1], $i3
	fsub    $fg1, $f1, $f1
	store   $f1, [$i2 + 19]
	load    [$i2 + 8], $f1
	fsub    $fg3, $f1, $f1
	store   $f1, [$i2 + 20]
	load    [$i2 + 9], $f1
	fsub    $fg2, $f1, $f1
	store   $f1, [$i2 + 21]
	bne     $i3, 2, bne.28573
be.28573:
	load    [$i2 + 19], $f1
	add     $i1, -1, $i1
	load    [$i2 + 20], $f2
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 5], $f5
	fmul    $f5, $f2, $f2
	load    [$i2 + 6], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
.count move_args
	mov     $fg1, $f2
.count move_args
	mov     $fg2, $f4
	fadd    $f1, $f3, $f1
.count move_args
	mov     $fg3, $f3
	store   $f1, [$i2 + 22]
	call    setup_startp_constants.2831
	load    [$i17 + 0], $f19
	add     $ig4, -1, $i14
	load    [$i17 + 1], $f20
	load    [$i17 + 2], $f21
	jal     trace_reflections.2915, $ra4
	ble     $f22, $fc3, bg.28543
.count dual_jmp
	b       bg.28577
bne.28573:
	bg      $i3, 2, bg.28574
ble.28574:
	add     $i1, -1, $i1
.count move_args
	mov     $fg1, $f2
.count move_args
	mov     $fg3, $f3
.count move_args
	mov     $fg2, $f4
	call    setup_startp_constants.2831
	add     $ig4, -1, $i14
	load    [$i17 + 0], $f19
	load    [$i17 + 1], $f20
	load    [$i17 + 2], $f21
	jal     trace_reflections.2915, $ra4
	ble     $f22, $fc3, bg.28543
.count dual_jmp
	b       bg.28577
bg.28574:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	fmul    $f1, $f1, $f4
	load    [$i2 + 21], $f3
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 5], $f7
	fmul    $f3, $f3, $f5
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	load    [$i2 + 3], $i4
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28575
bne.28575:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28576
.count dual_jmp
	b       bne.28576
be.28575:
	mov     $f4, $f1
	be      $i3, 3, be.28576
bne.28576:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
.count move_args
	mov     $fg1, $f2
.count move_args
	mov     $fg3, $f3
.count move_args
	mov     $fg2, $f4
	call    setup_startp_constants.2831
	load    [$i17 + 0], $f19
	add     $ig4, -1, $i14
	load    [$i17 + 1], $f20
	load    [$i17 + 2], $f21
	jal     trace_reflections.2915, $ra4
	ble     $f22, $fc3, bg.28543
.count dual_jmp
	b       bg.28577
be.28576:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
.count move_args
	mov     $fg1, $f2
	store   $f1, [$i2 + 22]
.count move_args
	mov     $fg3, $f3
.count move_args
	mov     $fg2, $f4
	call    setup_startp_constants.2831
	load    [$i17 + 0], $f19
	add     $ig4, -1, $i14
	load    [$i17 + 1], $f20
	load    [$i17 + 2], $f21
	jal     trace_reflections.2915, $ra4
	ble     $f22, $fc3, bg.28543
bg.28577:
	bge     $i16, 4, bge.28578
bl.28578:
	add     $i16, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i19, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i23 + 2], $i1
	be      $i1, 2, be.28579
.count dual_jmp
	b       bg.28543
bge.28578:
	load    [$i23 + 2], $i1
	be      $i1, 2, be.28579
bg.28543:
	jr      $ra5
be.28579:
	load    [$i23 + 11], $f1
	fadd    $f23, $fg11, $f23
	add     $i16, 1, $i16
	fsub    $fc0, $f1, $f1
	fmul    $f22, $f1, $f22
	b       trace_ray.2920
.end trace_ray

######################################################################
# iter_trace_diffuse_rays($i14, $f17, $f18, $f19, $i15)
# $ra = $ra4
# [$i1 - $i13, $i15 - $i16]
# [$f1 - $f16, $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg6, $fg10 - $fg13]
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i15, 0, bl.28580
bge.28580:
	load    [$i14 + $i15], $i1
.count move_args
	mov     $ig1, $i13
	load    [$i1 + 0], $f1
	li      0, $i12
	load    [$i1 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f1, $f17, $f1
	fmul    $f2, $f18, $f2
	fmul    $f3, $f19, $f3
	mov     $fc9, $fg11
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	ble     $f0, $f1, ble.28581
bg.28581:
	add     $i15, 1, $i1
.count load_float
	load    [f.28003], $f2
	load    [$i14 + $i1], $i16
	fmul    $f1, $f2, $f20
	load    [$i16 + 3], $i7
	load    [$i16 + 0], $f11
	load    [$i16 + 1], $f12
	load    [$i16 + 2], $f13
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg11, $fc7, bne.28628
.count dual_jmp
	b       bg.28606
ble.28581:
	load    [$i14 + $i15], $i16
.count load_float
	load    [f.28005], $f2
	fmul    $f1, $f2, $f20
	load    [$i16 + 3], $i7
	load    [$i16 + 0], $f11
	load    [$i16 + 1], $f12
	load    [$i16 + 2], $f13
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg11, $fc7, bne.28628
bg.28606:
	ble     $fc8, $fg11, bne.28628
bg.28607:
	load    [ext_objects + $ig3], $i12
	load    [$i12 + 1], $i1
	be      $i1, 1, be.28609
bne.28609:
	bne     $i1, 2, bne.28612
be.28612:
	load    [$i12 + 4], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i12 + 5], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i12 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
bne.28612:
	load    [$i12 + 7], $f1
	fsub    $fg1, $f1, $f1
	load    [$i12 + 8], $f2
	fsub    $fg3, $f2, $f2
	load    [$i12 + 9], $f3
	fsub    $fg2, $f3, $f3
	load    [$i12 + 4], $f4
	fmul    $f1, $f4, $f4
	load    [$i12 + 5], $f5
	fmul    $f2, $f5, $f5
	load    [$i12 + 6], $f6
	fmul    $f3, $f6, $f6
	load    [$i12 + 3], $i1
	be      $i1, 0, be.28613
bne.28613:
	load    [$i12 + 18], $f7
	fmul    $f2, $f7, $f7
	load    [$i12 + 17], $f8
	fmul    $f3, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc2, $f7
	fadd    $f4, $f7, $f4
	store   $f4, [ext_nvector + 0]
	load    [$i12 + 18], $f4
	fmul    $f1, $f4, $f4
	load    [$i12 + 16], $f7
	fmul    $f3, $f7, $f3
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc2, $f3
	fadd    $f5, $f3, $f3
	store   $f3, [ext_nvector + 1]
	load    [$i12 + 17], $f3
	fmul    $f1, $f3, $f1
	load    [$i12 + 16], $f4
	fmul    $f2, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc2, $f1
	fadd    $f6, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i12 + 10], $i1
	load    [ext_nvector + 0], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f4
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.28614
.count dual_jmp
	b       bne.28614
be.28613:
	store   $f4, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f6, [ext_nvector + 2]
	load    [$i12 + 10], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $f1, $f4
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.28614
be.28614:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
bne.28614:
	be      $i1, 0, be.28615
bne.28615:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
be.28615:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
be.28609:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	load    [$i16 + $i1], $f1
	bne     $f1, $f0, bne.28610
be.28610:
	mov     $f0, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
bne.28610:
	ble     $f1, $f0, ble.28611
bg.28611:
	mov     $fc0, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
.count dual_jmp
	b       bne.28616
ble.28611:
	mov     $fc6, $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + $i1]
	load    [$i12 + 0], $i1
	load    [$i12 + 13], $fg13
	load    [$i12 + 14], $fg10
	load    [$i12 + 15], $fg12
	be      $i1, 1, be.28616
bne.28616:
	bne     $i1, 2, bne.28622
be.28622:
	fmul    $fg3, $fc12, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	fsub    $fc0, $f1, $f2
	fmul    $fc1, $f1, $fg13
	fmul    $fc1, $f2, $fg10
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
bne.28622:
	bne     $i1, 3, bne.28623
be.28623:
	load    [$i12 + 7], $f1
	fsub    $fg1, $f1, $f1
	load    [$i12 + 9], $f2
	fsub    $fg2, $f2, $f2
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc3, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc16, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	fsub    $fc0, $f1, $f2
	fmul    $f1, $fc1, $fg10
	fmul    $f2, $fc1, $fg12
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
bne.28623:
	be      $i1, 4, be.28624
bne.28624:
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
be.28624:
	load    [$i12 + 7], $f1
	load    [$i12 + 4], $f2
	fsub    $fg1, $f1, $f1
	load    [$i12 + 6], $f3
	fsqrt   $f2, $f2
	load    [$i12 + 9], $f4
	fsqrt   $f3, $f3
	fsub    $fg2, $f4, $f4
.count load_float
	load    [f.27983], $f9
	fmul    $f1, $f2, $f1
	fmul    $f4, $f3, $f2
	fmul    $f1, $f1, $f3
	fmul    $f2, $f2, $f4
	fabs    $f1, $f5
	fadd    $f3, $f4, $f10
	ble     $f9, $f5, ble.28625
bg.28625:
	mov     $fc5, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	load    [$i12 + 5], $f2
	fsub    $f4, $f1, $f11
	load    [$i12 + 8], $f3
	fsqrt   $f2, $f1
	fsub    $fg3, $f3, $f2
	fabs    $f10, $f3
	fmul    $f2, $f1, $f1
	ble     $f9, $f3, ble.28626
.count dual_jmp
	b       bg.28626
ble.28625:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
	fmul    $fc4, $f1, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	load    [$i12 + 5], $f2
	load    [$i12 + 8], $f3
	fsub    $f4, $f1, $f11
	fsqrt   $f2, $f1
	fsub    $fg3, $f3, $f2
	fabs    $f10, $f3
	fmul    $f2, $f1, $f1
	ble     $f9, $f3, ble.28626
bg.28626:
	mov     $fc5, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc2, $f11, $f2
	fsub    $fc2, $f1, $f1
	fmul    $f2, $f2, $f2
	fmul    $f1, $f1, $f1
	fsub    $fc15, $f2, $f2
	fsub    $f2, $f1, $f1
	ble     $f0, $f1, ble.28627
.count dual_jmp
	b       bg.28627
ble.28626:
	finv    $f10, $f2
	fmul_a  $f1, $f2, $f2
	call    ext_atan
	fmul    $fc4, $f1, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc2, $f11, $f2
	fsub    $fc2, $f1, $f1
	fmul    $f2, $f2, $f2
	fmul    $f1, $f1, $f1
	fsub    $fc15, $f2, $f2
	fsub    $f2, $f1, $f1
	ble     $f0, $f1, ble.28627
bg.28627:
	mov     $f0, $f1
	fmul    $fc14, $f1, $fg12
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
ble.28627:
	fmul    $fc14, $f1, $fg12
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
be.28616:
	load    [$i12 + 7], $f1
	fsub    $fg1, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28617
bg.28617:
	load    [$i12 + 9], $f1
	li      1, $i1
	fsub    $fg2, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28618
.count dual_jmp
	b       bg.28618
ble.28617:
	load    [$i12 + 9], $f1
	li      0, $i1
	fsub    $fg2, $f1, $f4
	fmul    $f4, $fc11, $f2
	call    ext_floor
	fmul    $f1, $fc10, $f1
	fsub    $f4, $f1, $f1
	ble     $fc13, $f1, ble.28618
bg.28618:
	be      $i1, 0, be.28785
.count dual_jmp
	b       bne.28784
ble.28618:
	be      $i1, 0, bne.28784
be.28785:
	mov     $f0, $fg10
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	be      $i1, 0, be.28628
.count dual_jmp
	b       bne.28628
bne.28784:
	mov     $fc1, $fg10
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.28628
be.28628:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg16, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg14, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $fg15, $f3
	add     $i15, -2, $i15
	fadd    $f1, $f2, $f1
	load    [$i12 + 11], $f2
	fadd_n  $f1, $f3, $f1
	ble     $f1, $f0, ble.28629
bg.28629:
	fmul    $f20, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg13, $f2
	fmul    $f1, $fg10, $f3
	fmul    $f1, $fg12, $f1
	fadd    $fg4, $f2, $fg4
	fadd    $fg5, $f3, $fg5
	fadd    $fg6, $f1, $fg6
	b       iter_trace_diffuse_rays.2929
ble.28629:
	mov     $f0, $f1
	fmul    $f20, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg13, $f2
	fmul    $f1, $fg10, $f3
	fmul    $f1, $fg12, $f1
	fadd    $fg4, $f2, $fg4
	fadd    $fg5, $f3, $fg5
	fadd    $fg6, $f1, $fg6
	b       iter_trace_diffuse_rays.2929
bne.28628:
	add     $i15, -2, $i15
	b       iter_trace_diffuse_rays.2929
bl.28580:
	jr      $ra4
.end iter_trace_diffuse_rays

######################################################################
# do_without_neighbors($i17, $i18, $i19, $i20, $i21, $i22, $i23, $i24)
# $ra = $ra5
# [$i1 - $i16, $i24 - $i26]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i24, 4, bg.28630
ble.28630:
	load    [$i18 + $i24], $i1
	bl      $i1, 0, bg.28630
bge.28631:
	load    [$i19 + $i24], $i1
	be      $i1, 0, be.28632
bne.28632:
	load    [$i21 + $i24], $i1
	load    [$i23 + $i24], $i25
	load    [$i17 + $i24], $i26
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	bne     $i22, 0, bne.28633
be.28633:
	be      $i22, 1, be.28639
.count dual_jmp
	b       bne.28639
bne.28633:
	load    [ext_dirvecs + 0], $i14
	add     $ig0, -1, $i1
	load    [$i26 + 0], $fg17
	load    [$i26 + 1], $fg18
	load    [$i26 + 2], $fg19
	bge     $i1, 0, bge.28634
bl.28634:
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 1, be.28639
.count dual_jmp
	b       bne.28639
bge.28634:
	load    [ext_objects + $i1], $i2
	load    [$i26 + 0], $f1
	load    [$i2 + 7], $f2
	load    [$i2 + 1], $i3
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 19]
	load    [$i26 + 1], $f1
	load    [$i2 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 20]
	load    [$i26 + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 21]
	bne     $i3, 2, bne.28635
be.28635:
	load    [$i2 + 19], $f1
	add     $i1, -1, $i1
	load    [$i2 + 20], $f2
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 5], $f5
	fmul    $f5, $f2, $f2
	load    [$i2 + 6], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 1, be.28639
.count dual_jmp
	b       bne.28639
bne.28635:
	bg      $i3, 2, bg.28636
ble.28636:
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 1, be.28639
.count dual_jmp
	b       bne.28639
bg.28636:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	fmul    $f1, $f1, $f4
	load    [$i2 + 21], $f3
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 5], $f7
	fmul    $f3, $f3, $f5
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	load    [$i2 + 3], $i4
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28637
bne.28637:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28638
.count dual_jmp
	b       bne.28638
be.28637:
	mov     $f4, $f1
	be      $i3, 3, be.28638
bne.28638:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 1, be.28639
.count dual_jmp
	b       bne.28639
be.28638:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	bne     $i22, 1, bne.28639
be.28639:
	be      $i22, 2, be.28645
.count dual_jmp
	b       bne.28645
bne.28639:
	load    [ext_dirvecs + 1], $i14
	load    [$i26 + 0], $fg17
	add     $ig0, -1, $i1
	load    [$i26 + 1], $fg18
	load    [$i26 + 2], $fg19
	bge     $i1, 0, bge.28640
bl.28640:
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 2, be.28645
.count dual_jmp
	b       bne.28645
bge.28640:
	load    [ext_objects + $i1], $i2
	load    [$i26 + 0], $f1
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [$i2 + 1], $i3
	store   $f1, [$i2 + 19]
	load    [$i26 + 1], $f1
	load    [$i2 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 20]
	load    [$i26 + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 21]
	bne     $i3, 2, bne.28641
be.28641:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	add     $i1, -1, $i1
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	load    [$i2 + 5], $f5
	fmul    $f4, $f1, $f1
	load    [$i2 + 6], $f6
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 2, be.28645
.count dual_jmp
	b       bne.28645
bne.28641:
	bg      $i3, 2, bg.28642
ble.28642:
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 2, be.28645
.count dual_jmp
	b       bne.28645
bg.28642:
	load    [$i2 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i2 + 20], $f2
	fmul    $f2, $f2, $f6
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f5
	load    [$i2 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i2 + 3], $i4
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28643
bne.28643:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28644
.count dual_jmp
	b       bne.28644
be.28643:
	mov     $f4, $f1
	be      $i3, 3, be.28644
bne.28644:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 2, be.28645
.count dual_jmp
	b       bne.28645
be.28644:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	bne     $i22, 2, bne.28645
be.28645:
	be      $i22, 3, be.28651
.count dual_jmp
	b       bne.28651
bne.28645:
	load    [ext_dirvecs + 2], $i14
	add     $ig0, -1, $i1
	load    [$i26 + 0], $fg17
	load    [$i26 + 1], $fg18
	load    [$i26 + 2], $fg19
	bge     $i1, 0, bge.28646
bl.28646:
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 3, be.28651
.count dual_jmp
	b       bne.28651
bge.28646:
	load    [ext_objects + $i1], $i2
	load    [$i26 + 0], $f1
	load    [$i2 + 7], $f2
	load    [$i2 + 1], $i3
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 19]
	load    [$i26 + 1], $f1
	load    [$i2 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 20]
	load    [$i26 + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 21]
	bne     $i3, 2, bne.28647
be.28647:
	load    [$i2 + 19], $f1
	add     $i1, -1, $i1
	load    [$i2 + 20], $f2
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 5], $f5
	fmul    $f5, $f2, $f2
	load    [$i2 + 6], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 3, be.28651
.count dual_jmp
	b       bne.28651
bne.28647:
	bg      $i3, 2, bg.28648
ble.28648:
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 3, be.28651
.count dual_jmp
	b       bne.28651
bg.28648:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	fmul    $f1, $f1, $f4
	load    [$i2 + 21], $f3
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 5], $f7
	fmul    $f3, $f3, $f5
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	load    [$i2 + 3], $i4
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28649
bne.28649:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28650
.count dual_jmp
	b       bne.28650
be.28649:
	mov     $f4, $f1
	be      $i3, 3, be.28650
bne.28650:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 3, be.28651
.count dual_jmp
	b       bne.28651
be.28650:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	bne     $i22, 3, bne.28651
be.28651:
	be      $i22, 4, be.28657
.count dual_jmp
	b       bne.28657
bne.28651:
	load    [ext_dirvecs + 3], $i14
	load    [$i26 + 0], $fg17
	add     $ig0, -1, $i1
	load    [$i26 + 1], $fg18
	load    [$i26 + 2], $fg19
	bge     $i1, 0, bge.28652
bl.28652:
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 4, be.28657
.count dual_jmp
	b       bne.28657
bge.28652:
	load    [ext_objects + $i1], $i2
	load    [$i26 + 0], $f1
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [$i2 + 1], $i3
	store   $f1, [$i2 + 19]
	load    [$i26 + 1], $f1
	load    [$i2 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 20]
	load    [$i26 + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 21]
	bne     $i3, 2, bne.28653
be.28653:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	add     $i1, -1, $i1
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	load    [$i2 + 5], $f5
	fmul    $f4, $f1, $f1
	load    [$i2 + 6], $f6
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 4, be.28657
.count dual_jmp
	b       bne.28657
bne.28653:
	bg      $i3, 2, bg.28654
ble.28654:
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	load    [$i25 + 0], $f17
	li      118, $i15
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 4, be.28657
.count dual_jmp
	b       bne.28657
bg.28654:
	load    [$i2 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i2 + 20], $f2
	fmul    $f2, $f2, $f6
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f5
	load    [$i2 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i2 + 3], $i4
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28655
bne.28655:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28656
.count dual_jmp
	b       bne.28656
be.28655:
	mov     $f4, $f1
	be      $i3, 3, be.28656
bne.28656:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 4, be.28657
.count dual_jmp
	b       bne.28657
be.28656:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	be      $i22, 4, be.28657
bne.28657:
	load    [ext_dirvecs + 4], $i14
	add     $ig0, -1, $i1
	load    [$i26 + 0], $fg17
	load    [$i26 + 1], $fg18
	load    [$i26 + 2], $fg19
	bl      $i1, 0, bl.28658
bge.28658:
	load    [ext_objects + $i1], $i2
	load    [$i26 + 0], $f1
	load    [$i2 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [$i2 + 1], $i3
	store   $f1, [$i2 + 19]
	load    [$i26 + 1], $f1
	load    [$i2 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 20]
	load    [$i26 + 2], $f1
	load    [$i2 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i2 + 21]
	be      $i3, 2, be.28659
bne.28659:
	ble     $i3, 2, ble.28660
bg.28660:
	load    [$i2 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i2 + 20], $f2
	fmul    $f2, $f2, $f6
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f5
	load    [$i2 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i2 + 3], $i4
	fmul    $f6, $f7, $f6
	load    [$i2 + 6], $f7
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i4, 0, be.28661
bne.28661:
	fmul    $f2, $f3, $f5
	load    [$i2 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i2 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i3, 3, be.28662
.count dual_jmp
	b       bne.28662
be.28661:
	mov     $f4, $f1
	be      $i3, 3, be.28662
bne.28662:
	store   $f1, [$i2 + 22]
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg4, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg5, $f2
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
be.28662:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg4, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg5, $f2
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
ble.28660:
	add     $i1, -1, $i1
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg4, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg5, $f2
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
be.28659:
	load    [$i2 + 19], $f1
	load    [$i2 + 20], $f2
	add     $i1, -1, $i1
	load    [$i2 + 21], $f3
	load    [$i2 + 4], $f4
	load    [$i2 + 5], $f5
	fmul    $f4, $f1, $f1
	load    [$i2 + 6], $f6
	fmul    $f5, $f2, $f2
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i2 + 22]
	load    [$i26 + 0], $f2
	load    [$i26 + 1], $f3
	load    [$i26 + 2], $f4
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f2
	fmul    $f1, $fg4, $f1
	load    [$i1 + 2], $f3
	fmul    $f2, $fg5, $f2
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
bl.28658:
	li      118, $i15
	load    [$i25 + 0], $f17
	load    [$i25 + 1], $f18
	load    [$i25 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	fmul    $f1, $fg4, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg5, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
be.28657:
	load    [$i20 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	fmul    $f1, $fg4, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg5, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       do_without_neighbors.2951
be.28632:
	add     $i24, 1, $i24
	b       do_without_neighbors.2951
bg.28630:
	jr      $ra5
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i24)
# $ra = $ra5
# [$i1 - $i26]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i24, 4, bg.28663
ble.28663:
	load    [$i4 + $i2], $i1
	add     $i1, 8, $i6
	load    [$i6 + $i24], $i6
	bl      $i6, 0, bg.28663
bge.28664:
	load    [$i3 + $i2], $i7
	add     $i7, 8, $i8
	load    [$i8 + $i24], $i8
	bne     $i8, $i6, bne.28665
be.28665:
	load    [$i5 + $i2], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i24], $i8
	bne     $i8, $i6, bne.28665
be.28666:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i24], $i8
	bne     $i8, $i6, bne.28665
be.28667:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i24], $i8
	bne     $i8, $i6, bne.28665
be.28668:
	add     $i1, 13, $i6
	load    [$i6 + $i24], $i6
	be      $i6, 0, be.28670
bne.28670:
	add     $i2, -1, $i6
	load    [$i4 + $i6], $i6
	add     $i7, 23, $i7
	load    [$i5 + $i2], $i9
	add     $i1, 23, $i1
	load    [$i7 + $i24], $i7
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	add     $i6, 23, $i6
	load    [$i6 + $i24], $i6
	add     $i8, 23, $i8
	load    [$i7 + 0], $fg4
	add     $i9, 23, $i9
	load    [$i7 + 1], $fg5
	load    [$i7 + 2], $fg6
	load    [$i6 + 0], $f1
	load    [$i6 + 1], $f2
	fadd    $fg4, $f1, $fg4
	load    [$i6 + 2], $f3
	fadd    $fg5, $f2, $fg5
	load    [$i1 + $i24], $i1
	fadd    $fg6, $f3, $fg6
	load    [$i1 + 0], $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f2
	fadd    $fg5, $f2, $fg5
	load    [$i1 + 2], $f3
	fadd    $fg6, $f3, $fg6
	load    [$i8 + $i24], $i1
	load    [$i4 + $i2], $i6
	load    [$i1 + 0], $f1
	add     $i6, 18, $i6
	load    [$i1 + 1], $f2
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 2], $f3
	fadd    $fg5, $f2, $fg5
	load    [$i9 + $i24], $i1
	fadd    $fg6, $f3, $fg6
	load    [$i1 + 0], $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f2
	fadd    $fg5, $f2, $fg5
	load    [$i1 + 2], $f3
	fadd    $fg6, $f3, $fg6
	load    [$i6 + $i24], $i1
	add     $i24, 1, $i24
	load    [$i1 + 0], $f1
	fmul    $f1, $fg4, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg5, $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $fg6, $f3
	fadd    $fg7, $f1, $fg7
	fadd    $fg8, $f2, $fg8
	fadd    $fg9, $f3, $fg9
	b       try_exploit_neighbors.2967
be.28670:
	add     $i24, 1, $i24
	b       try_exploit_neighbors.2967
bne.28665:
	load    [$i4 + $i2], $i1
	add     $i1, 3, $i17
	load    [$i1 + 28], $i22
	add     $i1, 8, $i18
	add     $i1, 13, $i19
	add     $i1, 18, $i20
	add     $i1, 23, $i21
	add     $i1, 29, $i23
	b       do_without_neighbors.2951
bg.28663:
	jr      $ra5
.end try_exploit_neighbors

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
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
	bg      $i1, $i4, bg.28673
ble.28673:
	bge     $i1, 0, bge.28674
bl.28674:
	li      0, $i2
	b       ext_write
bge.28674:
	mov     $i1, $i2
	b       ext_write
bg.28673:
	li      255, $i2
	b       ext_write
.end write_rgb_element

######################################################################
# pretrace_diffuse_rays($i17, $i18, $i19, $i20, $i21, $i22, $i23)
# $ra = $ra5
# [$i1 - $i16, $i23]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg6, $fg10 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i23, 4, bg.28675
ble.28675:
	load    [$i18 + $i23], $i1
	bl      $i1, 0, bg.28675
bge.28676:
	load    [$i19 + $i23], $i1
	be      $i1, 0, be.28677
bne.28677:
	load    [$i17 + $i23], $i1
	mov     $f0, $fg6
	load    [ext_dirvecs + $i21], $i14
	mov     $fg6, $fg4
	load    [$i22 + $i23], $i5
	mov     $fg6, $fg5
	load    [$i1 + 0], $fg17
	load    [$i1 + 1], $fg18
	add     $ig0, -1, $i2
	load    [$i1 + 2], $fg19
	bl      $i2, 0, bl.28678
bge.28678:
	load    [ext_objects + $i2], $i3
	load    [$i1 + 0], $f1
	load    [$i3 + 7], $f2
	fsub    $f1, $f2, $f1
	load    [$i3 + 1], $i4
	store   $f1, [$i3 + 19]
	load    [$i1 + 1], $f1
	load    [$i3 + 8], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 20]
	load    [$i1 + 2], $f1
	load    [$i3 + 9], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 21]
	be      $i4, 2, be.28679
bne.28679:
	ble     $i4, 2, ble.28680
bg.28680:
	load    [$i3 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i3 + 20], $f2
	fmul    $f2, $f2, $f6
	load    [$i3 + 21], $f3
	load    [$i3 + 4], $f5
	load    [$i3 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i3 + 3], $i6
	fmul    $f6, $f7, $f6
	load    [$i3 + 6], $f7
	fadd    $f4, $f6, $f4
	fmul    $f5, $f7, $f5
	fadd    $f4, $f5, $f4
	be      $i6, 0, be.28681
bne.28681:
	fmul    $f2, $f3, $f5
	load    [$i3 + 16], $f6
	fmul    $f3, $f1, $f3
	load    [$i3 + 17], $f7
	fmul    $f5, $f6, $f5
	fmul    $f1, $f2, $f1
	fmul    $f3, $f7, $f2
	fadd    $f4, $f5, $f3
	load    [$i3 + 18], $f4
	fadd    $f3, $f2, $f2
	fmul    $f1, $f4, $f1
	fadd    $f2, $f1, $f1
	be      $i4, 3, be.28682
.count dual_jmp
	b       bne.28682
be.28681:
	mov     $f4, $f1
	be      $i4, 3, be.28682
bne.28682:
	add     $i2, -1, $i2
	store   $f1, [$i3 + 22]
	load    [$i1 + 0], $f2
	load    [$i1 + 1], $f3
	load    [$i1 + 2], $f4
.count move_args
	mov     $i2, $i1
	call    setup_startp_constants.2831
	load    [$i5 + 0], $f17
	li      118, $i15
	load    [$i5 + 1], $f18
	load    [$i5 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i23], $i1
	add     $i23, 1, $i23
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
be.28682:
	fsub    $f1, $fc0, $f1
	add     $i2, -1, $i2
	store   $f1, [$i3 + 22]
	load    [$i1 + 0], $f2
	load    [$i1 + 1], $f3
	load    [$i1 + 2], $f4
.count move_args
	mov     $i2, $i1
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i5 + 0], $f17
	load    [$i5 + 1], $f18
	load    [$i5 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i23], $i1
	add     $i23, 1, $i23
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
ble.28680:
	add     $i2, -1, $i2
	load    [$i1 + 0], $f2
	load    [$i1 + 1], $f3
	load    [$i1 + 2], $f4
.count move_args
	mov     $i2, $i1
	call    setup_startp_constants.2831
	load    [$i5 + 0], $f17
	li      118, $i15
	load    [$i5 + 1], $f18
	load    [$i5 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i23], $i1
	add     $i23, 1, $i23
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
be.28679:
	load    [$i3 + 19], $f1
	add     $i2, -1, $i2
	load    [$i3 + 20], $f2
	load    [$i3 + 21], $f3
	load    [$i3 + 4], $f4
	fmul    $f4, $f1, $f1
	load    [$i3 + 5], $f5
	fmul    $f5, $f2, $f2
	load    [$i3 + 6], $f6
	fmul    $f6, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	store   $f1, [$i3 + 22]
	load    [$i1 + 0], $f2
	load    [$i1 + 1], $f3
	load    [$i1 + 2], $f4
.count move_args
	mov     $i2, $i1
	call    setup_startp_constants.2831
	li      118, $i15
	load    [$i5 + 0], $f17
	load    [$i5 + 1], $f18
	load    [$i5 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i23], $i1
	add     $i23, 1, $i23
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
bl.28678:
	li      118, $i15
	load    [$i5 + 0], $f17
	load    [$i5 + 1], $f18
	load    [$i5 + 2], $f19
	jal     iter_trace_diffuse_rays.2929, $ra4
	load    [$i20 + $i23], $i1
	add     $i23, 1, $i23
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
be.28677:
	add     $i23, 1, $i23
	b       pretrace_diffuse_rays.2980
bg.28675:
	jr      $ra5
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i24, $i25, $i26, $f24, $f25, $f26)
# $ra = $ra6
# [$i1 - $i23, $i25 - $i26]
# [$f1 - $f23]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra5]
######################################################################
.align 2
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i25, 0, bl.28683
bge.28683:
	mov     $fig13, $f4
	add     $i25, -64, $i2
	call    ext_float_of_int
	mov     $fig14, $f2
	fmul    $f1, $f4, $f3
	fmul    $f1, $f2, $f1
	li      0, $i16
.count move_args
	mov     $f0, $f23
	li      ext_ptrace_dirvec, $i17
	fadd    $f3, $f24, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	fadd    $f1, $f26, $f1
	store   $f25, [ext_ptrace_dirvec + 1]
.count move_args
	mov     $fc0, $f22
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_ptrace_dirvec + 0], $f1
	fmul    $f1, $f1, $f4
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_ptrace_dirvec + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	mov     $f0, $fg9
	fadd    $f2, $f3, $f2
	mov     $f0, $fg8
	mov     $f0, $fg7
	fsqrt   $f2, $f2
	be      $f2, $f0, be.28684
bne.28684:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_viewpoint + 0], $f1
	load    [ext_viewpoint + 1], $f2
	load    [ext_viewpoint + 2], $f3
	load    [$i24 + $i25], $i1
	mov     $f1, $fig0
	add     $i1, 3, $i18
	mov     $f2, $fig1
	add     $i1, 8, $i19
	mov     $f3, $fig2
	add     $i1, 13, $i20
	add     $i1, 18, $i21
	add     $i1, 29, $i22
	jal     trace_ray.2920, $ra5
	load    [$i24 + $i25], $i1
	li      0, $i23
	store   $fg7, [$i1 + 0]
	store   $fg8, [$i1 + 1]
	store   $fg9, [$i1 + 2]
	load    [$i24 + $i25], $i1
	store   $i26, [$i1 + 28]
	load    [$i24 + $i25], $i1
	add     $i1, 3, $i17
	add     $i1, 8, $i18
	load    [$i1 + 28], $i21
	add     $i1, 13, $i19
	add     $i1, 23, $i20
	add     $i1, 29, $i22
	jal     pretrace_diffuse_rays.2980, $ra5
	add     $i25, -1, $i25
	add     $i26, 1, $i1
	bge     $i1, 5, bge.28685
.count dual_jmp
	b       bl.28685
be.28684:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_viewpoint + 0], $f1
	load    [ext_viewpoint + 1], $f2
	load    [ext_viewpoint + 2], $f3
	load    [$i24 + $i25], $i1
	add     $i1, 3, $i18
	mov     $f1, $fig0
	add     $i1, 8, $i19
	mov     $f2, $fig1
	add     $i1, 13, $i20
	mov     $f3, $fig2
	add     $i1, 18, $i21
	add     $i1, 29, $i22
	jal     trace_ray.2920, $ra5
	load    [$i24 + $i25], $i1
	li      0, $i23
	store   $fg7, [$i1 + 0]
	store   $fg8, [$i1 + 1]
	store   $fg9, [$i1 + 2]
	load    [$i24 + $i25], $i1
	store   $i26, [$i1 + 28]
	load    [$i24 + $i25], $i1
	add     $i1, 3, $i17
	load    [$i1 + 28], $i21
	add     $i1, 8, $i18
	add     $i1, 13, $i19
	add     $i1, 23, $i20
	add     $i1, 29, $i22
	jal     pretrace_diffuse_rays.2980, $ra5
	add     $i25, -1, $i25
	add     $i26, 1, $i1
	bge     $i1, 5, bge.28685
bl.28685:
	mov     $i1, $i26
	b       pretrace_pixels.2983
bge.28685:
	add     $i26, -4, $i26
	b       pretrace_pixels.2983
bl.28683:
	jr      $ra6
.end pretrace_pixels

######################################################################
# scan_pixel($i27, $i28, $i29, $i30, $i31)
# $ra = $ra6
# [$i1 - $i27]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra5]
######################################################################
.align 2
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	ble     $i1, $i27, ble.28686
bg.28686:
	load    [$i30 + $i27], $i1
	li      128, $i2
	add     $i28, 1, $i3
	load    [$i1 + 0], $fg7
	load    [$i1 + 1], $fg8
	load    [$i1 + 2], $fg9
	ble     $i2, $i3, ble.28689
bg.28687:
	ble     $i28, 0, ble.28689
bg.28688:
	li      128, $i1
	add     $i27, 1, $i2
	ble     $i1, $i2, ble.28689
bg.28689:
	li      0, $i24
	ble     $i27, 0, ble.28690
bg.28690:
.count move_args
	mov     $i27, $i2
.count move_args
	mov     $i29, $i3
.count move_args
	mov     $i30, $i4
.count move_args
	mov     $i31, $i5
	jal     try_exploit_neighbors.2967, $ra5
.count move_args
	mov     $fg7, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg8, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg9, $f2
	call    write_rgb_element.2976
	add     $i27, 1, $i27
	b       scan_pixel.2994
ble.28690:
	load    [$i30 + $i27], $i1
	add     $i1, 3, $i17
	load    [$i1 + 28], $i22
	add     $i1, 8, $i18
	add     $i1, 13, $i19
	add     $i1, 18, $i20
	add     $i1, 23, $i21
	add     $i1, 29, $i23
	jal     do_without_neighbors.2951, $ra5
.count move_args
	mov     $fg7, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg8, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg9, $f2
	call    write_rgb_element.2976
	add     $i27, 1, $i27
	b       scan_pixel.2994
ble.28689:
	load    [$i30 + $i27], $i1
	li      0, $i24
	load    [$i1 + 28], $i22
	add     $i1, 3, $i17
	add     $i1, 8, $i18
	add     $i1, 13, $i19
	add     $i1, 18, $i20
	add     $i1, 23, $i21
	add     $i1, 29, $i23
	jal     do_without_neighbors.2951, $ra5
.count move_args
	mov     $fg7, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg8, $f2
	call    write_rgb_element.2976
.count move_args
	mov     $fg9, $f2
	call    write_rgb_element.2976
	add     $i27, 1, $i27
	b       scan_pixel.2994
ble.28686:
	jr      $ra6
.end scan_pixel

######################################################################
# scan_line($i28, $i29, $i30, $i31, $i32)
# $ra = $ra7
# [$i1 - $i32]
# [$f1 - $f26]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra6]
######################################################################
.align 2
.begin scan_line
scan_line.3000:
	li      128, $i1
	ble     $i1, $i28, ble.28692
bg.28692:
	bge     $i28, 127, bge.28693
bl.28693:
	add     $i28, -63, $i2
	call    ext_float_of_int
	mov     $fig6, $f2
	fmul    $f1, $f2, $f2
	mov     $fig3, $f3
	mov     $fig7, $f4
	fadd    $f2, $f3, $f24
	mov     $fig8, $f5
	fmul    $f1, $f4, $f2
	fmul    $f1, $f5, $f1
	mov     $fig4, $f3
	mov     $fig5, $f4
	fadd    $f2, $f3, $f25
	fadd    $f1, $f4, $f26
	li      127, $i25
.count move_args
	mov     $i31, $i24
.count move_args
	mov     $i32, $i26
	jal     pretrace_pixels.2983, $ra6
	li      0, $i27
	jal     scan_pixel.2994, $ra6
	add     $i28, 1, $i28
	add     $i32, 2, $i1
	bge     $i1, 5, bge.28694
.count dual_jmp
	b       bl.28694
bge.28693:
	li      0, $i27
	jal     scan_pixel.2994, $ra6
	add     $i28, 1, $i28
	add     $i32, 2, $i1
	bge     $i1, 5, bge.28694
bl.28694:
.count move_args
	mov     $i29, $tmp
	mov     $i1, $i32
.count move_args
	mov     $i30, $i29
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $tmp, $i31
	b       scan_line.3000
bge.28694:
.count move_args
	mov     $i29, $tmp
	add     $i32, -3, $i32
.count move_args
	mov     $i30, $i29
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $tmp, $i31
	b       scan_line.3000
ble.28692:
	jr      $ra7
.end scan_line

######################################################################
# $i1 = create_float5x3array()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
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
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_line_elements
init_line_elements.3010:
	bge     $i13, 0, bge.28695
bl.28695:
	mov     $i12, $i1
	jr      $ra3
bge.28695:
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
# calc_dirvec($i2, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra1
# [$i1 - $i7]
# [$f1 - $f8, $f11 - $f14]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin calc_dirvec
calc_dirvec.3020:
	bge     $i2, 5, bge.28696
bl.28696:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc3, $f1
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
	fmul    $f13, $f1, $f1
	fmul    $f1, $f11, $f11
	fmul    $f11, $f11, $f1
	fadd    $f1, $fc3, $f1
	fsqrt   $f1, $f12
	finv    $f12, $f2
	call    ext_atan
	fmul    $f1, $f10, $f13
.count move_args
	mov     $f13, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f14
.count move_args
	mov     $f13, $f2
	call    ext_cos
	finv    $f1, $f1
	add     $i2, 1, $i2
	fmul    $f14, $f1, $f1
	fmul    $f1, $f12, $f2
.count move_args
	mov     $f11, $f1
	b       calc_dirvec.3020
bge.28696:
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
# calc_dirvecs($i8, $f10, $i9, $i10)
# $ra = $ra2
# [$i1 - $i9, $i11]
# [$f1 - $f9, $f11 - $f17]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i8, 0, bl.28697
bge.28697:
	li      0, $i1
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
.count load_float
	load    [f.28075], $f15
.count move_args
	mov     $i1, $i2
.count load_float
	load    [f.28076], $f16
	fmul    $f1, $f15, $f17
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f17, $f16, $f9
	jal     calc_dirvec.3020, $ra1
	add     $i10, 2, $i11
	fadd    $f17, $fc3, $f9
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
	bl      $i8, 0, bl.28697
bge.28698:
	li      0, $i1
	add     $i9, 1, $i2
	bge     $i2, 5, bge.28699
bl.28699:
	mov     $i2, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f17
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
	fsub    $f17, $f16, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f2
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f17, $fc3, $f9
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
	bge     $i8, 0, bge.28700
.count dual_jmp
	b       bl.28697
bge.28699:
	add     $i9, -4, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f17
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
	fsub    $f17, $f16, $f9
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f17, $fc3, $f9
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
	bl      $i8, 0, bl.28697
bge.28700:
	add     $i9, 1, $i1
.count move_args
	mov     $i8, $i2
	bge     $i1, 5, bge.28701
bl.28701:
	mov     $i1, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $f15, $f17
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
	fsub    $f17, $f16, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f2
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f17, $fc3, $f9
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
	bge     $i8, 0, bge.28702
.count dual_jmp
	b       bl.28697
bge.28701:
	add     $i9, -4, $i9
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $f15, $f17
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
	fsub    $f17, $f16, $f9
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f17, $fc3, $f9
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
	bl      $i8, 0, bl.28697
bge.28702:
	li      0, $i1
	add     $i9, 1, $i2
	bge     $i2, 5, bge.28703
bl.28703:
	mov     $i2, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
	fsub    $f15, $f16, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f2
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f15, $fc3, $f9
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
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28704
.count dual_jmp
	b       bl.28704
bge.28703:
	add     $i9, -4, $i9
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
	fsub    $f15, $f16, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f2
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	fadd    $f15, $fc3, $f9
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
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28704
bl.28704:
	mov     $i1, $i9
	b       calc_dirvecs.3028
bge.28704:
	add     $i9, -4, $i9
	b       calc_dirvecs.3028
bl.28697:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i12, $i13, $i10)
# $ra = $ra3
# [$i1 - $i13]
# [$f1 - $f17]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i12, 0, bl.28705
bge.28705:
	li      0, $i1
.count load_float
	load    [f.28077], $f9
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
.count load_float
	load    [f.28075], $f2
.count load_float
	load    [f.28076], $f15
.count move_args
	mov     $i1, $i2
	fmul    $f1, $f2, $f1
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
	fsub    $f1, $f15, $f10
.count move_args
	mov     $f0, $f1
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	add     $i10, 2, $i8
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $f15, $f9
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f2
	add     $i13, 1, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i10, $i4
.count load_float
	load    [f.28078], $f9
	li      0, $i2
	bge     $i1, 5, bge.28706
bl.28706:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.28079], $f9
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28707
.count dual_jmp
	b       bl.28707
bge.28706:
	add     $i13, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.28079], $f9
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i2
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28707
bl.28707:
	mov     $i1, $i9
.count load_float
	load    [f.28080], $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
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
	mov     $fc2, $f9
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28708
.count dual_jmp
	b       bl.28708
bge.28707:
	add     $i9, -4, $i9
.count load_float
	load    [f.28080], $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
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
	mov     $fc2, $f9
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.28708
bl.28708:
	mov     $i1, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	add     $i13, 2, $i1
	bge     $i1, 5, bge.28709
.count dual_jmp
	b       bl.28709
bge.28708:
	add     $i9, -4, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	add     $i13, 2, $i1
	bge     $i1, 5, bge.28709
bl.28709:
	mov     $i1, $i13
	add     $i10, 4, $i10
	b       calc_dirvec_rows.3033
bge.28709:
	add     $i13, -3, $i13
	add     $i10, 4, $i10
	b       calc_dirvec_rows.3033
bl.28705:
	jr      $ra3
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
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
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bge     $i6, 0, bge.28710
bl.28710:
	jr      $ra2
bge.28710:
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
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin create_dirvecs
create_dirvecs.3042:
	bge     $i7, 0, bge.28711
bl.28711:
	jr      $ra3
bge.28711:
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
# init_dirvec_constants($i7, $i8)
# $ra = $ra2
# [$i1 - $i6, $i8]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bge     $i8, 0, bge.28712
bl.28712:
	jr      $ra2
bge.28712:
	load    [$i7 + $i8], $i1
	load    [$i1 + 3], $i4
	load    [$i1 + 0], $f1
	load    [$i1 + 1], $f3
	load    [$i1 + 2], $f4
	jal     setup_dirvec_constants.2829, $ra1
	add     $i8, -1, $i8
	b       init_dirvec_constants.3044
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i9)
# $ra = $ra3
# [$i1 - $i9]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_vecset_constants
init_vecset_constants.3047:
	bge     $i9, 0, bge.28713
bl.28713:
	jr      $ra3
bge.28713:
	load    [ext_dirvecs + $i9], $i7
	li      119, $i8
	jal     init_dirvec_constants.3044, $ra2
	add     $i9, -1, $i9
	b       init_vecset_constants.3047
.end init_vecset_constants

######################################################################
# add_reflection($i7, $i8, $f12, $f1, $f3, $f4)
# $ra = $ra2
# [$i1 - $i6, $i9]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin add_reflection
add_reflection.3051:
	jal     create_dirvec.3037, $ra1
.count move_ret
	mov     $i1, $i9
	store   $f1, [$i9 + 0]
	store   $f3, [$i9 + 1]
	store   $f4, [$i9 + 2]
	load    [$i9 + 3], $i4
	load    [$i9 + 0], $f1
	load    [$i9 + 1], $f3
	load    [$i9 + 2], $f4
	jal     setup_dirvec_constants.2829, $ra1
	mov     $hp, $i1
	store   $i8, [$i1 + 0]
	load    [$i9 + 0], $i2
	add     $hp, 6, $hp
	store   $i2, [$i1 + 1]
	load    [$i9 + 1], $i2
	store   $i2, [$i1 + 2]
	load    [$i9 + 2], $i2
	store   $i2, [$i1 + 3]
	load    [$i9 + 3], $i2
	store   $i2, [$i1 + 4]
	store   $f12, [$i1 + 5]
	store   $i1, [ext_reflections + $i7]
	jr      $ra2
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i32]
# [$f1 - $f26]
# [$ig0 - $ig4]
# [$fg0 - $fg19]
# [$fig0 - $fig14]
# [$ra - $ra7]
######################################################################
.align 2
.begin main
ext_main:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
	load    [ext_solver_dist + 0], $fg0
	load    [ext_intersection_point + 0], $fg1
	load    [ext_intersection_point + 2], $fg2
	load    [ext_intersection_point + 1], $fg3
	load    [ext_diffuse_ray + 0], $fg4
	load    [ext_diffuse_ray + 1], $fg5
	load    [ext_diffuse_ray + 2], $fg6
	load    [ext_rgb + 0], $fg7
	load    [ext_rgb + 1], $fg8
	load    [ext_rgb + 2], $fg9
	load    [ext_texture_color + 1], $fg10
	load    [ext_tmin + 0], $fg11
	load    [ext_texture_color + 2], $fg12
	load    [ext_n_objects + 0], $ig0
	load    [ext_texture_color + 0], $fg13
	load    [ext_light + 1], $fg14
	load    [ext_light + 2], $fg15
	load    [ext_light + 0], $fg16
	load    [ext_or_net + 0], $ig1
	load    [ext_startp_fast + 0], $fg17
	load    [ext_startp_fast + 1], $fg18
	load    [ext_startp_fast + 2], $fg19
	load    [ext_intsec_rectside + 0], $ig2
	load    [ext_intersected_object_id + 0], $ig3
	load    [ext_n_reflections + 0], $ig4
	load    [ext_startp + 0], $fig0
	load    [ext_startp + 1], $fig1
	load    [ext_startp + 2], $fig2
	load    [ext_screenz_dir + 0], $fig3
	load    [ext_screenz_dir + 1], $fig4
	load    [ext_screenz_dir + 2], $fig5
	load    [ext_screeny_dir + 0], $fig6
	load    [ext_screeny_dir + 1], $fig7
	load    [ext_screeny_dir + 2], $fig8
	load    [ext_beam + 0], $fig9
	load    [ext_screen + 0], $fig10
	load    [ext_screen + 1], $fig11
	load    [ext_screen + 2], $fig12
	load    [ext_screenx_dir + 0], $fig13
	load    [ext_screenx_dir + 2], $fig14
	load    [f.27975 + 0], $fc0
	load    [f.27990 + 0], $fc1
	load    [f.27977 + 0], $fc2
	load    [f.27995 + 0], $fc3
	load    [f.27988 + 0], $fc4
	load    [f.27984 + 0], $fc5
	load    [f.27974 + 0], $fc6
	load    [f.27980 + 0], $fc7
	load    [f.27982 + 0], $fc8
	load    [f.27981 + 0], $fc9
	load    [f.27998 + 0], $fc10
	load    [f.27997 + 0], $fc11
	load    [f.27996 + 0], $fc12
	load    [f.27994 + 0], $fc13
	load    [f.27993 + 0], $fc14
	load    [f.27989 + 0], $fc15
	load    [f.27986 + 0], $fc16
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i29
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i24
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i31
	call    ext_read_float
	mov     $f1, $fig10
	call    ext_read_float
	mov     $f1, $fig11
	call    ext_read_float
	mov     $f1, $fig12
	call    ext_read_float
.count load_float
	load    [f.27931], $f9
	fmul    $f1, $f9, $f10
.count move_args
	mov     $f10, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
.count move_args
	mov     $f10, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	call    ext_read_float
	fmul    $f1, $f9, $f12
.count move_args
	mov     $f12, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f13
.count move_args
	mov     $f12, $f2
	call    ext_sin
	fmul    $f11, $f1, $f2
.count load_float
	load    [f.28100], $f3
	fmul    $f11, $f13, $f5
.count load_float
	load    [f.28101], $f4
	fmul    $f2, $f3, $f2
	fmul    $f10, $f4, $f4
	mov     $f2, $fig3
	fmul    $f5, $f3, $f3
	mov     $f4, $fig4
	mov     $f3, $fig5
	fneg    $f10, $f2
	mov     $f13, $fig13
	fneg    $f1, $f3
	fmul    $f2, $f1, $f1
	mov     $f3, $fig14
	fneg    $f11, $f3
	mov     $f1, $fig6
	mov     $f3, $fig7
	fmul    $f2, $f13, $f1
	mov     $fig10, $f2
	mov     $fig3, $f3
	mov     $f1, $fig8
	fsub    $f2, $f3, $f1
	mov     $fig11, $f2
	mov     $fig4, $f3
	store   $f1, [ext_viewpoint + 0]
	fsub    $f2, $f3, $f1
	mov     $fig12, $f2
	mov     $fig5, $f3
	fsub    $f2, $f3, $f2
	store   $f1, [ext_viewpoint + 1]
	store   $f2, [ext_viewpoint + 2]
	call    ext_read_int
	call    ext_read_float
	fmul    $f1, $f9, $f10
.count move_args
	mov     $f10, $f2
	call    ext_sin
	fneg    $f1, $fg14
	call    ext_read_float
.count move_ret
	mov     $f1, $f11
.count move_args
	mov     $f10, $f2
	call    ext_cos
	fmul    $f11, $f9, $f9
.count move_ret
	mov     $f1, $f10
.count move_args
	mov     $f9, $f2
	call    ext_sin
	fmul    $f10, $f1, $fg16
.count move_args
	mov     $f9, $f2
	call    ext_cos
	fmul    $f10, $f1, $fg15
	call    ext_read_float
	mov     $f1, $fig9
	li      0, $i6
	jal     read_object.2721, $ra1
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
	li      9, $i12
	li      0, $i13
	li      0, $i10
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i9
	jal     init_vecset_constants.3047, $ra3
	store   $fg16, [%{ext_light_dirvec + 0} + 0]
	store   $fg14, [%{ext_light_dirvec + 0} + 1]
	store   $fg15, [%{ext_light_dirvec + 0} + 2]
	load    [ext_light_dirvec + 3], $i4
	load    [%{ext_light_dirvec + 0} + 0], $f1
	load    [%{ext_light_dirvec + 0} + 1], $f3
	load    [%{ext_light_dirvec + 0} + 2], $f4
	jal     setup_dirvec_constants.2829, $ra1
	add     $ig0, -1, $i1
	bl      $i1, 0, bl.28715
bge.28715:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.28715
be.28716:
	load    [$i2 + 11], $f1
	ble     $fc0, $f1, bl.28715
bg.28717:
	load    [$i2 + 1], $i3
	be      $i3, 1, be.28718
bne.28718:
	be      $i3, 2, be.28719
bl.28715:
.count load_float
	load    [f.28102], $f1
	li      0, $i26
	li      127, $i25
	mov     $fig6, $f2
	fmul    $f1, $f2, $f2
	mov     $fig3, $f3
	mov     $fig7, $f4
	fadd    $f2, $f3, $f24
	mov     $fig8, $f5
	fmul    $f1, $f4, $f2
	fmul    $f1, $f5, $f1
	mov     $fig4, $f3
	mov     $fig5, $f4
	fadd    $f2, $f3, $f25
	fadd    $f1, $f4, $f26
	jal     pretrace_pixels.2983, $ra6
	li      0, $i28
	li      2, $i32
.count move_args
	mov     $i24, $i30
	jal     scan_line.3000, $ra7
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
be.28719:
	add     $i1, $i1, $i1
	fsub    $fc0, $f1, $f12
	add     $i1, $i1, $i1
	load    [$i2 + 4], $f1
	load    [$i2 + 5], $f2
	add     $i1, 1, $i8
	fmul    $fg16, $f1, $f3
	load    [$i2 + 6], $f5
	fmul    $fg14, $f2, $f4
.count load_float
	load    [f.27976], $f6
	fadd    $f3, $f4, $f3
.count move_args
	mov     $ig4, $i7
	fmul    $fg15, $f5, $f4
	fmul    $f6, $f1, $f1
	fmul    $f6, $f2, $f2
	fadd    $f3, $f4, $f3
	fmul    $f6, $f5, $f4
	fmul    $f2, $f3, $f2
	fmul    $f1, $f3, $f1
	fmul    $f4, $f3, $f3
	fsub    $f2, $fg14, $f2
	fsub    $f1, $fg16, $f1
	fsub    $f3, $fg15, $f4
.count move_args
	mov     $f2, $f3
	jal     add_reflection.3051, $ra2
.count load_float
	load    [f.28102], $f1
	add     $ig4, 1, $ig4
	mov     $fig6, $f2
	li      0, $i26
	fmul    $f1, $f2, $f2
	li      127, $i25
	mov     $fig3, $f3
	mov     $fig7, $f4
	fadd    $f2, $f3, $f24
	mov     $fig8, $f5
	fmul    $f1, $f4, $f2
	fmul    $f1, $f5, $f1
	mov     $fig4, $f3
	mov     $fig5, $f4
	fadd    $f2, $f3, $f25
	fadd    $f1, $f4, $f26
	jal     pretrace_pixels.2983, $ra6
	li      0, $i28
	li      2, $i32
.count move_args
	mov     $i24, $i30
	jal     scan_line.3000, $ra7
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
be.28718:
	add     $i1, $i1, $i1
	load    [$i2 + 11], $f1
	add     $i1, $i1, $i10
	fneg    $fg16, $f13
	fsub    $fc0, $f1, $f12
	add     $i10, 1, $i8
	fneg    $fg14, $f14
.count move_args
	mov     $ig4, $i7
	fneg    $fg15, $f15
.count move_args
	mov     $fg16, $f1
.count move_args
	mov     $f14, $f3
.count move_args
	mov     $f15, $f4
	jal     add_reflection.3051, $ra2
.count move_args
	mov     $f13, $f1
	add     $ig4, 1, $i7
.count move_args
	mov     $fg14, $f3
	add     $i10, 2, $i8
.count move_args
	mov     $f15, $f4
	jal     add_reflection.3051, $ra2
.count move_args
	mov     $f13, $f1
	add     $ig4, 2, $i7
.count move_args
	mov     $f14, $f3
	add     $i10, 3, $i8
.count move_args
	mov     $fg15, $f4
	jal     add_reflection.3051, $ra2
.count load_float
	load    [f.28102], $f1
	add     $ig4, 3, $ig4
	mov     $fig6, $f2
	li      0, $i26
	fmul    $f1, $f2, $f2
	li      127, $i25
	mov     $fig3, $f3
	mov     $fig7, $f4
	fadd    $f2, $f3, $f24
	mov     $fig8, $f5
	fmul    $f1, $f4, $f2
	fmul    $f1, $f5, $f1
	mov     $fig4, $f3
	mov     $fig5, $f4
	fadd    $f2, $f3, $f25
	fadd    $f1, $f4, $f26
	jal     pretrace_pixels.2983, $ra6
	li      0, $i28
	li      2, $i32
.count move_args
	mov     $i24, $i30
	jal     scan_line.3000, $ra7
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
.end main
