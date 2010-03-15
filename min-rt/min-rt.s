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
#	load [FLOAT_HALF], $f3
#	fadd $f2, $f3, $f2
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
# 三角関数用テーブル
######################################################################
ext_atan_table:
	.float 0.785398163397448279
	.float 0.463647609000806094
	.float 0.244978663126864143
	.float 0.124354994546761438
	.float 0.06241880999595735
	.float 0.0312398334302682774
	.float 0.0156237286204768313
	.float 0.00781234106010111114
	.float 0.00390623013196697176
	.float 0.00195312251647881876
	.float 0.000976562189559319459
	.float 0.00048828121119489829
	.float 0.000244140620149361771
	.float 0.000122070311893670208
	.float 6.10351561742087726e-05
	.float 3.05175781155260957e-05
	.float 1.52587890613157615e-05
	.float 7.62939453110197e-06
	.float 3.81469726560649614e-06
	.float 1.90734863281018696e-06
	.float 9.53674316405960844e-07
	.float 4.76837158203088842e-07
	.float 2.38418579101557974e-07
	.float 1.19209289550780681e-07
	.float 5.96046447753905522e-08

######################################################################
#
# 		↑　ここまで lib_asm.s
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
.define $ig0 $i32
.define $i32 orz
.define $ig1 $i33
.define $i33 orz
.define $ig2 $i34
.define $i34 orz
.define $ig3 $i35
.define $i35 orz
.define $ig4 $i36
.define $i36 orz
.define $fig0 $i37
.define $i37 orz
.define $fig1 $i38
.define $i38 orz
.define $fig2 $i39
.define $i39 orz
.define $fig3 $i40
.define $i40 orz
.define $fig4 $i41
.define $i41 orz
.define $fig5 $i42
.define $i42 orz
.define $fig6 $i43
.define $i43 orz
.define $fig7 $i44
.define $i44 orz
.define $fig8 $i45
.define $i45 orz
.define $fig9 $i46
.define $i46 orz
.define $fig10 $i47
.define $i47 orz
.define $fig11 $i48
.define $i48 orz
.define $fig12 $i49
.define $i49 orz
.define $fig13 $i50
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
f.22159:	.float  -6.4000000000E+01
f.22158:	.float  -2.0000000000E+02
f.22157:	.float  2.0000000000E+02
f.22137:	.float  -5.0000000000E-01
f.22136:	.float  7.0000000000E-01
f.22135:	.float  -3.0000000000E-01
f.22134:	.float  -1.0000000000E-01
f.22133:	.float  2.0000000000E-01
f.22132:	.float  9.0000000000E-01
f.22062:	.float  1.5000000000E+02
f.22061:	.float  -1.5000000000E+02
f.22060:	.float  6.6666666667E-03
f.22059:	.float  -6.6666666667E-03
f.22058:	.float  -2.0000000000E+00
f.22057:	.float  3.9062500000E-03
f.22056:	.float  2.5600000000E+02
f.22055:	.float  1.0000000000E+08
f.22054:	.float  1.0000000000E+09
f.22053:	.float  1.0000000000E+01
f.22052:	.float  5.0000000000E-02
f.22051:	.float  2.0000000000E+01
f.22050:	.float  2.5000000000E-01
f.22049:	.float  2.5500000000E+02
f.22048:	.float  1.0000000000E-01
f.22047:	.float  8.5000000000E+02
f.22046:	.float  1.5000000000E-01
f.22045:	.float  9.5492964444E+00
f.22044:	.float  3.1830988148E-01
f.22043:	.float  3.1415927000E+00
f.22042:	.float  3.0000000000E+01
f.22041:	.float  1.5000000000E+01
f.22040:	.float  1.0000000000E-04
f.22039:	.float  -1.0000000000E-01
f.22038:	.float  1.0000000000E-02
f.22037:	.float  -2.0000000000E-01
f.22036:	.float  5.0000000000E-01
f.22035:	.float  1.0000000000E+00
f.22034:	.float  -1.0000000000E+00
f.22033:	.float  2.0000000000E+00
f.21990:	.float  1.7453293000E-02

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i5, $i7 - $i15]
# [$f1 - $f21]
# []
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
	be      $i7, -1, be.22200
bne.22200:
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
	be      $i10, 0, be.22201
bne.22201:
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
	ble     $f0, $f3, ble.22202
.count dual_jmp
	b       bg.22202
be.22201:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	ble     $f0, $f3, ble.22202
bg.22202:
	li      1, $i2
	be      $i8, 2, be.22203
.count dual_jmp
	b       bne.22203
ble.22202:
	li      0, $i2
	be      $i8, 2, be.22203
bne.22203:
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
	be      $i8, 3, be.22204
.count dual_jmp
	b       bne.22204
be.22203:
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
	bne     $i8, 3, bne.22204
be.22204:
	load    [$i11 + 0], $f1
	be      $f1, $f0, be.22206
bne.22205:
	bne     $f1, $f0, bne.22206
be.22206:
	mov     $f0, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22209
.count dual_jmp
	b       bne.22208
bne.22206:
	ble     $f1, $f0, ble.22207
bg.22207:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22209
.count dual_jmp
	b       bne.22208
ble.22207:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22209
bne.22208:
	bne     $f1, $f0, bne.22209
be.22209:
	mov     $f0, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22211
.count dual_jmp
	b       bne.22211
bne.22209:
	ble     $f1, $f0, ble.22210
bg.22210:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22211
.count dual_jmp
	b       bne.22211
ble.22210:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	bne     $f1, $f0, bne.22211
be.22211:
	store   $f0, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
bne.22211:
	fmul    $f1, $f1, $f2
	finv    $f2, $f2
	bne     $f1, $f0, bne.22213
be.22213:
	mov     $f0, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
bne.22213:
	ble     $f1, $f0, ble.22214
bg.22214:
	mov     $fc0, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
ble.22214:
	mov     $fc12, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
bne.22204:
	be      $i8, 2, be.22216
bne.22216:
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
be.22216:
	load    [$i11 + 0], $f1
	load    [$i11 + 1], $f2
	fmul    $f1, $f1, $f4
	load    [$i11 + 2], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f3
	fadd    $f4, $f2, $f2
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $i2, 0, be.22217
bne.22217:
	be      $f2, $f0, be.22218
bne.22877:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
be.22217:
	be      $f2, $f0, be.22218
bne.22878:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
.count dual_jmp
	b       bne.22221
be.22218:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22221
bne.22221:
	load    [$i15 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f9
	load    [$i15 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i15 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
	load    [$i15 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f12
	load    [$i15 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f13
	load    [$i15 + 2], $f2
	call    ext_sin
	fmul    $f10, $f12, $f2
	load    [$i11 + 0], $f3
	fmul    $f11, $f13, $f4
	load    [$i11 + 1], $f5
	fmul    $f11, $f1, $f6
	load    [$i11 + 2], $f7
	fneg    $f12, $f8
	li      1, $i1
	fmul    $f4, $f4, $f14
	fmul    $f8, $f8, $f15
	fmul    $f6, $f6, $f16
	fmul    $f2, $f13, $f17
	fmul    $f9, $f1, $f18
	fmul    $f3, $f14, $f14
	fmul    $f7, $f15, $f15
	fmul    $f5, $f16, $f16
	fmul    $f2, $f1, $f2
	fsub    $f17, $f18, $f17
	fmul    $f9, $f13, $f18
	fmul    $f9, $f12, $f12
	fadd    $f14, $f16, $f14
	fmul    $f10, $f11, $f16
	fmul    $f17, $f17, $f19
	fadd    $f2, $f18, $f2
	fmul    $f12, $f13, $f18
	fadd    $f14, $f15, $f14
	fmul    $f16, $f16, $f15
	store   $f14, [$i11 + 0]
	fmul    $f3, $f19, $f19
	fmul    $f2, $f2, $f20
	fmul    $f10, $f1, $f21
	fmul    $f7, $f15, $f14
	fmul    $f12, $f1, $f1
	fmul    $f10, $f13, $f10
	fmul    $f5, $f20, $f12
	fadd    $f18, $f21, $f13
	fmul    $f9, $f11, $f9
	fmul    $f3, $f17, $f11
	fsub    $f1, $f10, $f1
	fadd    $f19, $f12, $f10
	fmul    $f13, $f13, $f12
	fmul    $f9, $f9, $f15
	fmul    $f11, $f13, $f11
	fmul    $f1, $f1, $f18
	fadd    $f10, $f14, $f10
	store   $f10, [$i11 + 1]
	fmul    $f3, $f12, $f12
	fmul    $f7, $f15, $f14
	fmul    $f5, $f2, $f15
	fmul    $f5, $f18, $f18
	fmul    $f7, $f16, $f10
	fmul    $f3, $f4, $f3
	fmul    $f5, $f6, $f4
	fadd    $f12, $f18, $f5
	fmul    $f15, $f1, $f6
	fmul    $f10, $f9, $f10
	fmul    $f3, $f13, $f12
	fmul    $f4, $f1, $f1
	fadd    $f5, $f14, $f5
	store   $f5, [$i11 + 2]
	fadd    $f11, $f6, $f6
	fmul    $f7, $f8, $f7
	fmul    $f3, $f17, $f3
	fmul    $f4, $f2, $f2
	fadd    $f6, $f10, $f4
	fadd    $f12, $f1, $f1
	fmul    $f7, $f9, $f5
	fadd    $f3, $f2, $f2
	fmul    $f7, $f16, $f3
	fmul    $fc5, $f4, $f4
	fadd    $f1, $f5, $f1
	store   $f4, [$i15 + 0]
	fadd    $f2, $f3, $f2
	fmul    $fc5, $f1, $f1
	fmul    $fc5, $f2, $f2
	store   $f1, [$i15 + 1]
	store   $f2, [$i15 + 2]
	jr      $ra1
be.22221:
	li      1, $i1
	jr      $ra1
be.22200:
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
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin read_object
read_object.2721:
	bge     $i6, 60, bge.22222
bl.22222:
	jal     read_nth_object.2719, $ra1
	be      $i1, 0, be.22223
bne.22223:
	add     $i6, 1, $i6
	b       read_object.2721
be.22223:
	mov     $i6, $ig0
	jr      $ra2
bge.22222:
	jr      $ra2
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
	be      $i1, -1, be.22225
bne.22225:
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
be.22225:
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
	be      $i2, -1, be.22229
bne.22229:
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
be.22229:
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
	be      $i2, -1, be.22232
bne.22232:
	add     $i6, 1, $i2
	store   $i1, [ext_and_net + $i6]
.count move_args
	mov     $i2, $i6
	b       read_and_network.2729
be.22232:
	jr      $ra1
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1, $i3 - $i4]
# [$f1 - $f17]
# []
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
	bne     $i3, 1, bne.22233
be.22233:
	be      $f4, $f0, ble.22240
bne.22234:
	finv    $f4, $f5
	load    [$i1 + 4], $f6
	load    [$i1 + 10], $i4
	ble     $f0, $f4, ble.22235
bg.22235:
	be      $i4, 0, be.22236
.count dual_jmp
	b       bne.22879
ble.22235:
	be      $i4, 0, bne.22879
be.22236:
	mov     $f6, $f4
	load    [$i2 + 1], $f6
	fsub    $f4, $f3, $f4
	load    [$i1 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f4, $f6, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f7, $f5, ble.22240
.count dual_jmp
	b       bg.22239
bne.22879:
	fneg    $f6, $f4
	fsub    $f4, $f3, $f4
	load    [$i2 + 1], $f6
	load    [$i1 + 5], $f7
	fmul    $f4, $f5, $f4
	fmul    $f4, $f6, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f7, $f5, ble.22240
bg.22239:
	load    [$i2 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f6, $f5, bg.22240
ble.22240:
	load    [$i2 + 1], $f4
	be      $f4, $f0, ble.22248
bne.22242:
	finv    $f4, $f5
	load    [$i1 + 5], $f6
	load    [$i1 + 10], $i4
	ble     $f0, $f4, ble.22243
bg.22243:
	be      $i4, 0, be.22244
.count dual_jmp
	b       bne.22882
ble.22243:
	be      $i4, 0, bne.22882
be.22244:
	mov     $f6, $f4
	fsub    $f4, $f2, $f4
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $f7
	fmul    $f4, $f5, $f4
	fmul    $f4, $f6, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f7, $f5, ble.22248
.count dual_jmp
	b       bg.22247
bne.22882:
	fneg    $f6, $f4
	load    [$i2 + 2], $f6
	fsub    $f4, $f2, $f4
	load    [$i1 + 6], $f7
	fmul    $f4, $f5, $f4
	fmul    $f4, $f6, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f7, $f5, ble.22248
bg.22247:
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f3, $f5
	bg      $f6, $f5, bg.22248
ble.22248:
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.22264
bne.22250:
	load    [$i1 + 10], $i3
	load    [$i1 + 4], $f5
	load    [$i1 + 6], $f6
	ble     $f0, $f4, ble.22251
bg.22251:
	finv    $f4, $f4
	be      $i3, 0, be.22252
.count dual_jmp
	b       bne.22885
ble.22251:
	finv    $f4, $f4
	be      $i3, 0, bne.22885
be.22252:
	fsub    $f6, $f1, $f1
	load    [$i2 + 0], $f6
	fmul    $f1, $f4, $f1
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f5, $f3, ble.22264
.count dual_jmp
	b       bg.22255
bne.22885:
	fneg    $f6, $f6
	fsub    $f6, $f1, $f1
	load    [$i2 + 0], $f6
	fmul    $f1, $f4, $f1
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f5, $f3, ble.22264
bg.22255:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	load    [$i1 + 5], $f4
	fadd_a  $f3, $f2, $f2
	ble     $f4, $f2, ble.22264
bg.22256:
	mov     $f1, $fg0
	li      3, $i1
	ret     
bg.22248:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bg.22240:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22233:
	bne     $i3, 2, bne.22257
be.22257:
	load    [$i1 + 4], $f5
	load    [$i2 + 1], $f6
	fmul    $f4, $f5, $f4
	load    [$i1 + 5], $f7
	fmul    $f6, $f7, $f6
	load    [$i2 + 2], $f8
	fadd    $f4, $f6, $f4
	load    [$i1 + 6], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	ble     $f4, $f0, ble.22264
bg.22258:
	finv    $f4, $f4
	li      1, $i1
	fmul    $f5, $f3, $f3
	fmul    $f7, $f2, $f2
	fmul    $f9, $f1, $f1
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f4, $fg0
	ret     
bne.22257:
	load    [$i2 + 1], $f5
	load    [$i1 + 3], $i4
	fmul    $f4, $f4, $f7
	load    [$i1 + 4], $f6
	fmul    $f5, $f5, $f8
	load    [$i1 + 5], $f9
	fmul    $f7, $f6, $f7
	load    [$i2 + 2], $f10
	fmul    $f8, $f9, $f8
	load    [$i1 + 6], $f11
	fmul    $f10, $f10, $f12
	fadd    $f7, $f8, $f7
	fmul    $f12, $f11, $f8
	fadd    $f7, $f8, $f7
	be      $i4, 0, be.22259
bne.22259:
	fmul    $f5, $f10, $f8
	load    [$i1 + 18], $f12
	load    [$i1 + 16], $f13
	fmul    $f4, $f5, $f14
	load    [$i1 + 17], $f15
	fmul    $f10, $f4, $f16
	fmul    $f8, $f13, $f8
	fmul    $f14, $f12, $f12
	fmul    $f16, $f15, $f13
	fadd    $f7, $f8, $f7
	fadd    $f7, $f13, $f7
	fadd    $f7, $f12, $f7
	be      $f7, $f0, ble.22264
.count dual_jmp
	b       bne.22260
be.22259:
	be      $f7, $f0, ble.22264
bne.22260:
	fmul    $f3, $f3, $f8
	fmul    $f2, $f2, $f12
	fmul    $f1, $f1, $f13
	fmul    $f8, $f6, $f8
	fmul    $f12, $f9, $f12
	fmul    $f13, $f11, $f13
	fadd    $f8, $f12, $f8
	fadd    $f8, $f13, $f8
	be      $i4, 0, be.22261
bne.22261:
	fmul    $f2, $f1, $f12
	load    [$i1 + 18], $f13
	load    [$i1 + 16], $f14
	fmul    $f3, $f2, $f15
	load    [$i1 + 17], $f16
	fmul    $f1, $f3, $f17
	fmul    $f12, $f14, $f12
	fmul    $f15, $f13, $f13
	fmul    $f17, $f16, $f14
	fadd    $f8, $f12, $f8
	fadd    $f8, $f14, $f8
	fadd    $f8, $f13, $f8
	be      $i3, 3, be.22262
.count dual_jmp
	b       bne.22262
be.22261:
	be      $i3, 3, be.22262
bne.22262:
	fmul    $f7, $f8, $f8
	fmul    $f4, $f3, $f12
	fmul    $f5, $f2, $f13
	fmul    $f10, $f1, $f14
	fmul    $f12, $f6, $f6
	fmul    $f13, $f9, $f9
	fmul    $f14, $f11, $f11
	fadd    $f6, $f9, $f6
	fadd    $f6, $f11, $f6
	be      $i4, 0, be.22263
.count dual_jmp
	b       bne.22263
be.22262:
	fsub    $f8, $fc0, $f8
	fmul    $f4, $f3, $f12
	fmul    $f5, $f2, $f13
	fmul    $f10, $f1, $f14
	fmul    $f7, $f8, $f8
	fmul    $f12, $f6, $f6
	fmul    $f13, $f9, $f9
	fmul    $f14, $f11, $f11
	fadd    $f6, $f9, $f6
	fadd    $f6, $f11, $f6
	be      $i4, 0, be.22263
bne.22263:
	load    [$i1 + 18], $f9
	fmul    $f5, $f3, $f11
	load    [$i1 + 17], $f13
	fmul    $f4, $f2, $f12
	load    [$i1 + 16], $f14
	fmul    $f10, $f3, $f3
	fmul    $f4, $f1, $f4
	fadd    $f12, $f11, $f11
	fmul    $f5, $f1, $f1
	fmul    $f10, $f2, $f2
	fadd    $f4, $f3, $f3
	fmul    $f11, $f9, $f4
	fadd    $f2, $f1, $f1
	fmul    $f3, $f13, $f2
	fmul    $f1, $f14, $f1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f4, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f8, $f2
	ble     $f2, $f0, ble.22264
.count dual_jmp
	b       bg.22264
be.22263:
	mov     $f6, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f8, $f2
	ble     $f2, $f0, ble.22264
bg.22264:
	load    [$i1 + 10], $i1
	fsqrt   $f2, $f2
	finv    $f7, $f3
	be      $i1, 0, be.22265
bne.22265:
	fsub    $f2, $f1, $f1
	li      1, $i1
	fmul    $f1, $f3, $fg0
	ret     
be.22265:
	fneg    $f2, $f2
	li      1, $i1
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	ret     
ble.22264:
	li      0, $i1
	ret     
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f11]
# []
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
	load    [$i3 + $i1], $i1
	load    [$i2 + 9], $f2
	load    [$i2 + 8], $f3
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f4
	fsub    $f4, $f3, $f3
	load    [$i2 + 7], $f2
	load    [ext_intersection_point + 0], $f5
	load    [$i1 + 0], $f4
	fsub    $f5, $f2, $f2
	bne     $i4, 1, bne.22266
be.22266:
	fsub    $f4, $f2, $f4
	load    [$i1 + 1], $f5
	fmul    $f4, $f5, $f4
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 5], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22269
bg.22267:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f8
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f8, $f6, be.22269
bg.22268:
	bne     $f5, $f0, bne.22269
be.22269:
	load    [$i1 + 2], $f4
	load    [$i1 + 3], $f5
	fsub    $f4, $f3, $f4
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f8
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f8, $f6, be.22273
bg.22271:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 6], $f9
	fadd_a  $f6, $f1, $f6
	ble     $f9, $f6, be.22273
bg.22272:
	bne     $f5, $f0, bne.22273
be.22273:
	load    [$i1 + 4], $f4
	fsub    $f4, $f1, $f1
	load    [$i1 + 5], $f5
	fmul    $f1, $f5, $f1
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f8, $f2, ble.22283
bg.22275:
	load    [%{ext_light_dirvec + 0} + 1], $f2
	fmul    $f1, $f2, $f2
	fadd_a  $f2, $f3, $f2
	ble     $f7, $f2, ble.22283
bg.22276:
	be      $f5, $f0, ble.22283
bne.22277:
	mov     $f1, $fg0
	li      3, $i1
	ret     
bne.22273:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bne.22269:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22266:
	be      $i4, 2, be.22278
bne.22278:
	be      $f4, $f0, ble.22283
bne.22280:
	load    [$i2 + 3], $i3
	fmul    $f2, $f2, $f5
	fmul    $f3, $f3, $f6
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f1, $f1, $f9
	fmul    $f5, $f7, $f5
	load    [$i2 + 6], $f7
	fmul    $f6, $f8, $f6
	fmul    $f9, $f7, $f7
	fadd    $f5, $f6, $f5
	fadd    $f5, $f7, $f5
	be      $i3, 0, be.22281
bne.22281:
	fmul    $f3, $f1, $f6
	load    [$i2 + 18], $f7
	fmul    $f2, $f3, $f9
	load    [$i2 + 16], $f8
	fmul    $f1, $f2, $f11
	load    [$i2 + 17], $f10
	fmul    $f6, $f8, $f6
	fmul    $f9, $f7, $f7
	fmul    $f11, $f10, $f8
	fadd    $f5, $f6, $f5
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	be      $i4, 3, be.22282
.count dual_jmp
	b       bne.22282
be.22281:
	be      $i4, 3, be.22282
bne.22282:
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	load    [$i1 + 2], $f6
	fmul    $f5, $f1, $f1
	load    [$i1 + 1], $f7
	fmul    $f6, $f3, $f3
	fmul    $f7, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22283
.count dual_jmp
	b       bg.22283
be.22282:
	fsub    $f5, $fc0, $f5
	load    [$i1 + 2], $f6
	fmul    $f6, $f3, $f3
	load    [$i1 + 1], $f7
	fmul    $f7, $f2, $f2
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f1, $f1
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22283
bg.22283:
	load    [$i2 + 10], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	be      $i2, 0, be.22284
bne.22284:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22284:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22278:
	ble     $f0, $f4, ble.22283
bg.22279:
	load    [$i1 + 3], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f3, $f3
	load    [$i1 + 1], $f6
	fmul    $f6, $f2, $f2
	li      1, $i1
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $fg0
	ret     
ble.22283:
	li      0, $i1
	ret     
.end solver_fast

######################################################################
# $i1 = solver_fast2($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f9]
# []
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
	load    [$i4 + $i1], $i1
	load    [$i3 + 21], $f1
	load    [$i3 + 20], $f2
	load    [$i3 + 19], $f3
	bne     $i5, 1, bne.22285
be.22285:
	load    [$i1 + 0], $f4
	fsub    $f4, $f3, $f4
	load    [$i1 + 1], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 1], $f6
	fmul    $f4, $f6, $f6
	load    [$i3 + 5], $f7
	fadd_a  $f6, $f2, $f6
	ble     $f7, $f6, be.22288
bg.22286:
	load    [$i2 + 2], $f6
	load    [$i3 + 6], $f8
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f8, $f6, be.22288
bg.22287:
	bne     $f5, $f0, bne.22288
be.22288:
	load    [$i1 + 2], $f4
	load    [$i1 + 3], $f5
	fsub    $f4, $f2, $f4
	load    [$i2 + 0], $f6
	fmul    $f4, $f5, $f4
	load    [$i3 + 4], $f8
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f8, $f6, be.22292
bg.22290:
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i3 + 6], $f9
	fadd_a  $f6, $f1, $f6
	ble     $f9, $f6, be.22292
bg.22291:
	bne     $f5, $f0, bne.22292
be.22292:
	load    [$i1 + 4], $f4
	fsub    $f4, $f1, $f1
	load    [$i1 + 5], $f5
	fmul    $f1, $f5, $f1
	load    [$i2 + 0], $f6
	fmul    $f1, $f6, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f8, $f3, ble.22300
bg.22294:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	ble     $f7, $f2, ble.22300
bg.22295:
	be      $f5, $f0, ble.22300
bne.22296:
	mov     $f1, $fg0
	li      3, $i1
	ret     
bne.22292:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bne.22288:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22285:
	be      $i5, 2, be.22297
bne.22297:
	load    [$i1 + 0], $f4
	be      $f4, $f0, ble.22300
bne.22299:
	load    [$i3 + 22], $f5
	load    [$i1 + 3], $f6
	fmul    $f4, $f5, $f4
	load    [$i1 + 2], $f7
	fmul    $f6, $f1, $f1
	load    [$i1 + 1], $f8
	fmul    $f7, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22300
bg.22300:
	load    [$i3 + 10], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	be      $i2, 0, be.22301
bne.22301:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22301:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret     
be.22297:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, ble.22300
bg.22298:
	load    [$i3 + 22], $f2
	li      1, $i1
	fmul    $f1, $f2, $fg0
	ret     
ble.22300:
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
	bne     $f1, $f0, bne.22302
be.22302:
	store   $f0, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22307
.count dual_jmp
	b       bne.22307
bne.22302:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22303
bg.22303:
	load    [$i5 + 4], $f1
	be      $i2, 0, be.22304
.count dual_jmp
	b       bne.22888
ble.22303:
	load    [$i5 + 4], $f1
	be      $i2, 0, bne.22888
be.22304:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22307
.count dual_jmp
	b       bne.22307
bne.22888:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	bne     $f1, $f0, bne.22307
be.22307:
	store   $f0, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22312
.count dual_jmp
	b       bne.22312
bne.22307:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22308
bg.22308:
	load    [$i5 + 5], $f1
	be      $i2, 0, be.22309
.count dual_jmp
	b       bne.22891
ble.22308:
	load    [$i5 + 5], $f1
	be      $i2, 0, bne.22891
be.22309:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22312
.count dual_jmp
	b       bne.22312
bne.22891:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22312
bne.22312:
	load    [$i5 + 10], $i2
	ble     $f0, $f1, ble.22313
bg.22313:
	load    [$i5 + 6], $f1
	be      $i2, 0, be.22895
.count dual_jmp
	b       bne.22894
ble.22313:
	load    [$i5 + 6], $f1
	be      $i2, 0, bne.22894
be.22895:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
bne.22894:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be.22312:
	store   $f0, [$i1 + 5]
	jr      $ra1
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f5]
# []
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
	load    [$i5 + 6], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i5 + 5], $f3
	load    [$i4 + 1], $f4
	load    [$i5 + 4], $f2
	fmul    $f4, $f3, $f3
	load    [$i4 + 0], $f5
	fmul    $f5, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	ble     $f1, $f0, ble.22317
bg.22317:
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
ble.22317:
	store   $f0, [$i1 + 0]
	jr      $ra1
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f9]
# []
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
	load    [$i5 + 6], $f1
	load    [$i4 + 2], $f2
	load    [$i5 + 5], $f3
	fmul    $f2, $f2, $f6
	load    [$i4 + 1], $f4
	fmul    $f4, $f4, $f7
	load    [$i4 + 0], $f5
	fmul    $f5, $f5, $f8
	load    [$i5 + 4], $f9
	fmul    $f6, $f1, $f1
	fmul    $f7, $f3, $f3
	fmul    $f8, $f9, $f6
	fadd    $f6, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i2, 0, be.22318
bne.22318:
	fmul    $f4, $f2, $f3
	load    [$i5 + 16], $f6
	fmul    $f2, $f5, $f7
	load    [$i5 + 17], $f8
	fmul    $f5, $f4, $f9
	fmul    $f3, $f6, $f3
	load    [$i5 + 18], $f6
	fmul    $f7, $f8, $f7
	fmul    $f9, $f6, $f6
	fadd    $f1, $f3, $f1
	fadd    $f1, $f7, $f1
	fadd    $f1, $f6, $f1
	store   $f1, [$i1 + 0]
	load    [$i5 + 6], $f3
	fmul_n  $f2, $f3, $f2
	load    [$i5 + 5], $f6
	fmul_n  $f4, $f6, $f3
	load    [$i5 + 4], $f7
	fmul_n  $f5, $f7, $f4
	be      $i2, 0, be.22319
.count dual_jmp
	b       bne.22319
be.22318:
	store   $f1, [$i1 + 0]
	load    [$i5 + 6], $f3
	load    [$i5 + 5], $f6
	fmul_n  $f2, $f3, $f2
	load    [$i5 + 4], $f7
	fmul_n  $f4, $f6, $f3
	fmul_n  $f5, $f7, $f4
	be      $i2, 0, be.22319
bne.22319:
	load    [$i5 + 18], $f5
	load    [$i4 + 1], $f6
	load    [$i5 + 17], $f7
	fmul    $f6, $f5, $f6
	load    [$i4 + 2], $f8
	fmul    $f8, $f7, $f8
	fadd    $f8, $f6, $f6
	fmul    $f6, $fc3, $f6
	fsub    $f4, $f6, $f4
	store   $f4, [$i1 + 1]
	load    [$i4 + 0], $f4
	fmul    $f4, $f5, $f4
	load    [$i5 + 16], $f6
	load    [$i4 + 2], $f8
	fmul    $f8, $f6, $f5
	fadd    $f5, $f4, $f4
	fmul    $f4, $fc3, $f4
	fsub    $f3, $f4, $f3
	store   $f3, [$i1 + 2]
	load    [$i4 + 0], $f3
	load    [$i4 + 1], $f4
	fmul    $f3, $f7, $f3
	fmul    $f4, $f6, $f4
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 3]
	be      $f1, $f0, be.22321
.count dual_jmp
	b       bne.22321
be.22319:
	store   $f4, [$i1 + 1]
	store   $f3, [$i1 + 2]
	store   $f2, [$i1 + 3]
	be      $f1, $f0, be.22321
bne.22321:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
be.22321:
	jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i4, $i6)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f9]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i6, 0, bl.22322
bge.22322:
	load    [ext_objects + $i6], $i5
	load    [$i4 + 3], $i7
	load    [$i5 + 1], $i1
	be      $i1, 1, be.22323
bne.22323:
	be      $i1, 2, be.22324
bne.22324:
	jal     setup_second_table.2823, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
be.22324:
	jal     setup_surface_table.2820, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
be.22323:
	jal     setup_rect_table.2817, $ra1
	add     $i6, -1, $i2
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
.count move_args
	mov     $i2, $i6
	b       iter_setup_dirvec_constants.2826
bl.22322:
	jr      $ra2
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i4)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f9]
# []
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
# []
######################################################################
.align 2
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bl.22325
bge.22325:
	load    [ext_objects + $i1], $i3
	load    [$i2 + 0], $f1
	load    [$i3 + 7], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i3 + 19]
	load    [$i3 + 8], $f1
	load    [$i2 + 1], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i3 + 20]
	load    [$i3 + 9], $f1
	load    [$i2 + 2], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i3 + 21]
	load    [$i3 + 1], $i4
	be      $i4, 2, be.22326
bne.22326:
	ble     $i4, 2, ble.22327
bg.22327:
	load    [$i3 + 3], $i5
	load    [$i3 + 19], $f1
	fmul    $f1, $f1, $f4
	load    [$i3 + 20], $f2
	fmul    $f2, $f2, $f5
	load    [$i3 + 4], $f3
	fmul    $f4, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f5, $f6, $f4
	load    [$i3 + 21], $f7
	fmul    $f7, $f7, $f5
	load    [$i3 + 6], $f8
	fadd    $f3, $f4, $f3
	fmul    $f5, $f8, $f4
	fadd    $f3, $f4, $f3
	be      $i5, 0, be.22328
bne.22328:
	fmul    $f2, $f7, $f4
	load    [$i3 + 18], $f5
	fmul    $f1, $f2, $f2
	load    [$i3 + 16], $f6
	fmul    $f7, $f1, $f1
	load    [$i3 + 17], $f8
	fmul    $f4, $f6, $f4
	fmul    $f2, $f5, $f2
	fmul    $f1, $f8, $f1
	fadd    $f3, $f4, $f3
	fadd    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	be      $i4, 3, be.22329
.count dual_jmp
	b       bne.22329
be.22328:
	mov     $f3, $f1
	be      $i4, 3, be.22329
bne.22329:
	add     $i1, -1, $i1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
be.22329:
	fsub    $f1, $fc0, $f1
	add     $i1, -1, $i1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
ble.22327:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
be.22326:
	load    [$i3 + 19], $f1
	add     $i1, -1, $i1
	load    [$i3 + 4], $f2
	fmul    $f2, $f1, $f1
	load    [$i3 + 20], $f3
	load    [$i3 + 5], $f4
	load    [$i3 + 21], $f2
	fmul    $f4, $f3, $f3
	load    [$i3 + 6], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f3, $f1
	fadd    $f1, $f2, $f1
	store   $f1, [$i3 + 22]
	b       setup_startp_constants.2831
bl.22325:
	ret     
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i6]
# [$f1, $f5 - $f12]
# []
# []
# []
# []
######################################################################
.align 2
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22384
bne.22330:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f1
	fsub    $f4, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 7], $f6
	fsub    $f2, $f6, $f6
	bne     $i4, 1, bne.22331
be.22331:
	load    [$i2 + 4], $f7
	fabs    $f6, $f6
	ble     $f7, $f6, ble.22334
bg.22332:
	load    [$i2 + 5], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, bg.22334
ble.22334:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22346
bg.22334:
	load    [$i2 + 6], $f5
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f5, $f1, ble.22344
.count dual_jmp
	b       bg.22344
bne.22331:
	bne     $i4, 2, bne.22338
be.22338:
	load    [$i2 + 4], $f7
	fmul    $f7, $f6, $f6
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 6], $f9
	fmul    $f9, $f1, $f1
	load    [$i2 + 10], $i2
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	ble     $f0, $f1, ble.22344
.count dual_jmp
	b       bg.22344
bne.22338:
	fmul    $f6, $f6, $f7
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $f9
	load    [$i2 + 5], $f10
	fmul    $f1, $f1, $f11
	fmul    $f7, $f9, $f7
	load    [$i2 + 6], $f9
	fmul    $f8, $f10, $f8
	load    [$i2 + 3], $i5
	fmul    $f11, $f9, $f9
	fadd    $f7, $f8, $f7
	fadd    $f7, $f9, $f7
	be      $i5, 0, be.22342
bne.22342:
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
	be      $i4, 3, be.22343
.count dual_jmp
	b       bne.22343
be.22342:
	mov     $f7, $f1
	be      $i4, 3, be.22343
bne.22343:
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.22344
.count dual_jmp
	b       bg.22344
be.22343:
	fsub    $f1, $fc0, $f1
	load    [$i2 + 10], $i2
	ble     $f0, $f1, ble.22344
bg.22344:
	be      $i2, 0, be.22346
.count dual_jmp
	b       bne.22346
ble.22344:
	be      $i2, 0, bne.22346
be.22346:
	add     $i1, 1, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22384
bne.22348:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f1
	fsub    $f4, $f1, $f1
	load    [$i2 + 8], $f5
	fsub    $f3, $f5, $f5
	load    [$i2 + 7], $f6
	fsub    $f2, $f6, $f6
	bne     $i4, 1, bne.22349
be.22349:
	load    [$i2 + 4], $f7
	fabs    $f6, $f6
	ble     $f7, $f6, ble.22362
bg.22350:
	load    [$i2 + 5], $f6
	fabs    $f5, $f5
	ble     $f6, $f5, ble.22362
bg.22352:
	load    [$i2 + 6], $f5
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f5, $f1, ble.22357
.count dual_jmp
	b       bg.22357
bne.22349:
	load    [$i2 + 6], $f7
	be      $i4, 2, be.22356
bne.22356:
	load    [$i2 + 3], $i5
	fmul    $f1, $f1, $f8
	load    [$i2 + 5], $f9
	fmul    $f5, $f5, $f10
	fmul    $f6, $f6, $f11
	load    [$i2 + 4], $f12
	fmul    $f8, $f7, $f7
	fmul    $f10, $f9, $f8
	fmul    $f11, $f12, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	be      $i5, 0, be.22360
bne.22360:
	fmul    $f5, $f1, $f8
	load    [$i2 + 18], $f9
	load    [$i2 + 16], $f10
	fmul    $f6, $f5, $f5
	load    [$i2 + 17], $f11
	fmul    $f1, $f6, $f1
	fmul    $f8, $f10, $f6
	fmul    $f5, $f9, $f5
	fmul    $f1, $f11, $f1
	fadd    $f7, $f6, $f6
	fadd    $f6, $f1, $f1
	fadd    $f1, $f5, $f1
	be      $i4, 3, be.22361
.count dual_jmp
	b       bne.22361
be.22360:
	mov     $f7, $f1
	be      $i4, 3, be.22361
bne.22361:
	ble     $f0, $f1, ble.22362
.count dual_jmp
	b       bg.22362
be.22361:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22362
bg.22362:
	load    [$i2 + 10], $i2
	be      $i2, 0, be.22364
.count dual_jmp
	b       bne.22346
ble.22362:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22364
be.22356:
	load    [$i2 + 5], $f8
	fmul    $f7, $f1, $f1
	load    [$i2 + 4], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f6, $f6
	load    [$i2 + 10], $i2
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	ble     $f0, $f1, ble.22357
bg.22357:
	be      $i2, 0, be.22364
.count dual_jmp
	b       bne.22346
ble.22357:
	be      $i2, 0, bne.22346
be.22364:
	add     $i1, 2, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22384
bne.22366:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f1
	load    [$i2 + 8], $f5
	fsub    $f4, $f1, $f1
	load    [$i2 + 7], $f6
	fsub    $f3, $f5, $f5
	fsub    $f2, $f6, $f6
	bne     $i4, 1, bne.22367
be.22367:
	load    [$i2 + 4], $f7
	fabs    $f6, $f6
	ble     $f7, $f6, ble.22370
bg.22368:
	load    [$i2 + 5], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, bg.22370
ble.22370:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22382
bg.22370:
	load    [$i2 + 6], $f5
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f5, $f1, ble.22372
bg.22372:
	be      $i2, 0, be.22382
.count dual_jmp
	b       bne.22346
ble.22372:
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22382
bne.22367:
	load    [$i2 + 6], $f7
	be      $i4, 2, be.22374
bne.22374:
	load    [$i2 + 10], $i5
	fmul    $f1, $f1, $f8
	load    [$i2 + 5], $f9
	fmul    $f5, $f5, $f10
	load    [$i2 + 4], $f12
	fmul    $f6, $f6, $f11
	load    [$i2 + 3], $i6
	fmul    $f8, $f7, $f7
	fmul    $f10, $f9, $f8
	fmul    $f11, $f12, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	be      $i6, 0, be.22378
bne.22378:
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
	be      $i4, 3, be.22379
.count dual_jmp
	b       bne.22379
be.22378:
	mov     $f7, $f1
	be      $i4, 3, be.22379
bne.22379:
	ble     $f0, $f1, ble.22380
.count dual_jmp
	b       bg.22380
be.22379:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22380
bg.22380:
	be      $i5, 0, be.22382
.count dual_jmp
	b       bne.22346
ble.22380:
	be      $i5, 0, bne.22346
.count dual_jmp
	b       be.22382
be.22374:
	load    [$i2 + 10], $i4
	fmul    $f7, $f1, $f1
	load    [$i2 + 5], $f8
	fmul    $f8, $f5, $f5
	load    [$i2 + 4], $f9
	fmul    $f9, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	ble     $f0, $f1, ble.22375
bg.22375:
	be      $i4, 0, be.22382
.count dual_jmp
	b       bne.22346
ble.22375:
	be      $i4, 0, bne.22346
be.22382:
	add     $i1, 3, $i2
	load    [$i3 + $i2], $i2
	be      $i2, -1, be.22384
bne.22384:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 9], $f1
	load    [$i2 + 8], $f5
	fsub    $f4, $f1, $f1
	load    [$i2 + 7], $f6
	fsub    $f3, $f5, $f5
	fsub    $f2, $f6, $f6
	bne     $i4, 1, bne.22385
be.22385:
	load    [$i2 + 4], $f7
	fabs    $f6, $f6
	ble     $f7, $f6, ble.22387
bg.22386:
	load    [$i2 + 5], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, bg.22387
ble.22387:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22903
bg.22387:
	load    [$i2 + 6], $f5
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f5, $f1, ble.22388
bg.22388:
	be      $i2, 0, be.22903
.count dual_jmp
	b       bne.22346
ble.22388:
	be      $i2, 0, bne.22346
.count dual_jmp
	b       be.22903
bne.22385:
	be      $i4, 2, be.22392
bne.22392:
	load    [$i2 + 3], $i5
	fmul    $f6, $f6, $f7
	load    [$i2 + 10], $i6
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
	be      $i5, 0, be.22397
bne.22397:
	fmul    $f5, $f1, $f8
	load    [$i2 + 18], $f9
	load    [$i2 + 16], $f10
	fmul    $f6, $f5, $f5
	load    [$i2 + 17], $f11
	fmul    $f1, $f6, $f1
	fmul    $f8, $f10, $f6
	fmul    $f5, $f9, $f5
	fmul    $f1, $f11, $f1
	fadd    $f7, $f6, $f6
	fadd    $f6, $f1, $f1
	fadd    $f1, $f5, $f1
	be      $i4, 3, be.22398
.count dual_jmp
	b       bne.22398
be.22397:
	mov     $f7, $f1
	be      $i4, 3, be.22398
bne.22398:
	ble     $f0, $f1, ble.22399
.count dual_jmp
	b       bg.22399
be.22398:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22399
bg.22399:
	be      $i6, 0, be.22903
.count dual_jmp
	b       bne.22346
ble.22399:
	be      $i6, 0, bne.22346
.count dual_jmp
	b       be.22903
be.22392:
	load    [$i2 + 10], $i4
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f7, $f6, $f6
	load    [$i2 + 6], $f9
	fmul    $f8, $f5, $f5
	fmul    $f9, $f1, $f1
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	ble     $f0, $f1, ble.22393
bg.22393:
	be      $i4, 0, be.22903
.count dual_jmp
	b       bne.22346
ble.22393:
	be      $i4, 0, bne.22346
be.22903:
	add     $i1, 4, $i1
	b       check_all_inside.2856
bne.22346:
	li      0, $i1
	ret     
be.22384:
	li      1, $i1
	ret     
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i7, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7]
# [$f1 - $f12]
# []
# []
# [$fg0]
# [$ra]
######################################################################
.align 2
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i7], $i1
	be      $i1, -1, be.22426
bne.22403:
	load    [ext_objects + $i1], $i2
	load    [ext_light_dirvec + 3], $i4
	load    [ext_intersection_point + 2], $f1
	load    [$i2 + 1], $i5
	load    [$i4 + $i1], $i4
	load    [$i2 + 9], $f2
	load    [$i2 + 8], $f3
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f4
	fsub    $f4, $f3, $f3
	load    [$i2 + 7], $f2
	load    [ext_intersection_point + 0], $f5
	load    [$i4 + 0], $f4
	fsub    $f5, $f2, $f2
	bne     $i5, 1, bne.22404
be.22404:
	fsub    $f4, $f2, $f4
	load    [$i4 + 1], $f5
	fmul    $f4, $f5, $f4
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 5], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22407
bg.22405:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22407
bg.22406:
	bne     $f5, $f0, bne.22407
be.22407:
	load    [$i4 + 2], $f4
	load    [$i4 + 3], $f5
	fsub    $f4, $f3, $f4
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f7, $f6, be.22411
bg.22409:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22411
bg.22410:
	be      $f5, $f0, be.22411
bne.22407:
	mov     $f4, $fg0
.count load_float
	load    [f.22037], $f1
	ble     $f1, $fg0, ble.22424
.count dual_jmp
	b       bg.22424
be.22411:
	load    [$i4 + 4], $f4
	fsub    $f4, $f1, $f1
	load    [$i4 + 5], $f5
	fmul    $f1, $f5, $f1
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f1, $f6, $f6
	load    [$i2 + 4], $f4
	fadd_a  $f6, $f2, $f2
	ble     $f4, $f2, ble.22424
bg.22413:
	load    [%{ext_light_dirvec + 0} + 1], $f2
	load    [$i2 + 5], $f4
	fmul    $f1, $f2, $f2
	fadd_a  $f2, $f3, $f2
	ble     $f4, $f2, ble.22424
bg.22414:
	be      $f5, $f0, ble.22424
bne.22415:
	mov     $f1, $fg0
.count load_float
	load    [f.22037], $f1
	ble     $f1, $fg0, ble.22424
.count dual_jmp
	b       bg.22424
bne.22404:
	be      $i5, 2, be.22416
bne.22416:
	be      $f4, $f0, ble.22424
bne.22418:
	fmul    $f2, $f2, $f5
	fmul    $f3, $f3, $f6
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f1, $f1, $f9
	fmul    $f5, $f7, $f5
	load    [$i2 + 6], $f7
	fmul    $f6, $f8, $f6
	load    [$i2 + 3], $i6
	fmul    $f9, $f7, $f7
	fadd    $f5, $f6, $f5
	fadd    $f5, $f7, $f5
	be      $i6, 0, be.22419
bne.22419:
	fmul    $f3, $f1, $f6
	load    [$i2 + 16], $f7
	fmul    $f1, $f2, $f8
	load    [$i2 + 17], $f9
	fmul    $f2, $f3, $f10
	fmul    $f6, $f7, $f6
	load    [$i2 + 18], $f7
	fmul    $f8, $f9, $f8
	fmul    $f10, $f7, $f7
	fadd    $f5, $f6, $f5
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	be      $i5, 3, be.22420
.count dual_jmp
	b       bne.22420
be.22419:
	be      $i5, 3, be.22420
bne.22420:
	fmul    $f4, $f5, $f4
	load    [$i4 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i4 + 2], $f6
	fmul    $f6, $f3, $f3
	load    [$i4 + 1], $f7
	fmul    $f7, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22424
.count dual_jmp
	b       bg.22421
be.22420:
	fsub    $f5, $fc0, $f5
	load    [$i4 + 2], $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f3, $f3
	fmul    $f7, $f2, $f2
	fmul    $f4, $f5, $f4
	load    [$i4 + 3], $f5
	fmul    $f5, $f1, $f1
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22424
bg.22421:
	load    [$i2 + 10], $i2
	load    [$i4 + 4], $f3
	fsqrt   $f2, $f2
	be      $i2, 0, be.22422
bne.22422:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count load_float
	load    [f.22037], $f1
	ble     $f1, $fg0, ble.22424
.count dual_jmp
	b       bg.22424
be.22422:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count load_float
	load    [f.22037], $f1
	ble     $f1, $fg0, ble.22424
.count dual_jmp
	b       bg.22424
be.22416:
	ble     $f0, $f4, ble.22424
bg.22417:
	load    [$i4 + 3], $f4
	fmul    $f4, $f1, $f1
	load    [$i4 + 2], $f5
	fmul    $f5, $f3, $f3
	load    [$i4 + 1], $f6
	fmul    $f6, $f2, $f2
	fadd    $f2, $f3, $f2
	fadd    $f2, $f1, $fg0
.count load_float
	load    [f.22037], $f1
	bg      $f1, $fg0, bg.22424
ble.22424:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22443
be.22426:
	li      0, $i1
	jr      $ra1
bg.22424:
	load    [$i3 + 0], $i1
	be      $i1, -1, bne.22445
bne.22427:
	fadd    $fg0, $fc11, $f1
	load    [ext_objects + $i1], $i1
	fmul    $fg12, $f1, $f4
	load    [ext_intersection_point + 2], $f2
	fmul    $fg13, $f1, $f6
	load    [ext_intersection_point + 1], $f3
	fmul    $fg15, $f1, $f1
	load    [$i1 + 1], $i2
	fadd    $f4, $f2, $f4
	load    [$i1 + 9], $f5
	fadd    $f6, $f3, $f3
	load    [$i1 + 8], $f7
	fsub    $f4, $f5, $f5
	load    [ext_intersection_point + 0], $f8
	fadd    $f1, $f8, $f2
	load    [$i1 + 7], $f1
	fsub    $f3, $f7, $f6
	fsub    $f2, $f1, $f1
	bne     $i2, 1, bne.22428
be.22428:
	load    [$i1 + 4], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22441
bg.22429:
	load    [$i1 + 5], $f1
	fabs    $f6, $f6
	ble     $f1, $f6, ble.22441
bg.22431:
	load    [$i1 + 6], $f1
	fabs    $f5, $f5
	load    [$i1 + 10], $i1
	ble     $f1, $f5, ble.22436
.count dual_jmp
	b       bg.22436
bne.22428:
	load    [$i1 + 6], $f7
	be      $i2, 2, be.22435
bne.22435:
	fmul    $f5, $f5, $f8
	load    [$i1 + 5], $f9
	fmul    $f6, $f6, $f10
	fmul    $f1, $f1, $f11
	load    [$i1 + 4], $f12
	fmul    $f8, $f7, $f7
	load    [$i1 + 3], $i4
	fmul    $f10, $f9, $f8
	fmul    $f11, $f12, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	be      $i4, 0, be.22439
bne.22439:
	fmul    $f6, $f5, $f8
	load    [$i1 + 18], $f9
	fmul    $f1, $f6, $f6
	load    [$i1 + 16], $f10
	fmul    $f5, $f1, $f1
	load    [$i1 + 17], $f11
	fmul    $f8, $f10, $f5
	fmul    $f6, $f9, $f6
	fmul    $f1, $f11, $f1
	fadd    $f7, $f5, $f5
	fadd    $f5, $f1, $f1
	fadd    $f1, $f6, $f1
	be      $i2, 3, be.22440
.count dual_jmp
	b       bne.22440
be.22439:
	mov     $f7, $f1
	be      $i2, 3, be.22440
bne.22440:
	ble     $f0, $f1, ble.22441
.count dual_jmp
	b       bg.22441
be.22440:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22441
bg.22441:
	load    [$i1 + 10], $i1
	be      $i1, 0, be.22443
.count dual_jmp
	b       bne.22443
ble.22441:
	load    [$i1 + 10], $i1
	be      $i1, 0, bne.22443
.count dual_jmp
	b       be.22443
be.22435:
	load    [$i1 + 5], $f8
	load    [$i1 + 4], $f9
	fmul    $f7, $f5, $f5
	fmul    $f8, $f6, $f6
	load    [$i1 + 10], $i1
	fmul    $f9, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.22436
bg.22436:
	be      $i1, 0, be.22443
.count dual_jmp
	b       bne.22443
ble.22436:
	be      $i1, 0, bne.22443
be.22443:
	li      1, $i1
	call    check_all_inside.2856
	be      $i1, 0, bne.22443
bne.22445:
	li      1, $i1
	jr      $ra1
bne.22443:
	add     $i7, 1, $i7
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i8, $i9)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f12]
# []
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.align 2
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i9 + $i8], $i1
	be      $i1, -1, be.22460
bne.22446:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22447:
	add     $i8, 1, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22448:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22449:
	add     $i8, 2, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22450:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22451:
	add     $i8, 3, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22452:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22453:
	add     $i8, 4, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22454:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22455:
	add     $i8, 5, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22456:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22457:
	add     $i8, 6, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22458:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22447
be.22459:
	add     $i8, 7, $i1
	load    [$i9 + $i1], $i1
	be      $i1, -1, be.22460
bne.22460:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	be      $i1, 0, be.22461
bne.22447:
	li      1, $i1
	jr      $ra2
be.22461:
	add     $i8, 8, $i8
	b       shadow_check_one_or_group.2865
be.22460:
	li      0, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i10, $i11)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f12]
# []
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.align 2
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i11 + $i10], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22519
bne.22462:
	be      $i1, 99, bne.22486
bne.22463:
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
	bne     $i4, 1, bne.22464
be.22464:
	fsub    $f4, $f1, $f4
	load    [$i1 + 1], $f5
	fmul    $f4, $f5, $f4
	load    [%{ext_light_dirvec + 0} + 1], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 5], $f7
	fadd_a  $f6, $f2, $f6
	ble     $f7, $f6, be.22467
bg.22465:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	load    [$i2 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22467
bg.22466:
	bne     $f5, $f0, bne.22467
be.22467:
	load    [$i1 + 2], $f4
	load    [$i1 + 3], $f5
	fsub    $f4, $f2, $f4
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f4, $f5, $f4
	load    [$i2 + 4], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22471
bg.22469:
	load    [%{ext_light_dirvec + 0} + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i2 + 6], $f7
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22471
bg.22470:
	be      $f5, $f0, be.22471
bne.22467:
	mov     $f4, $fg0
	ble     $fc4, $fg0, be.22518
.count dual_jmp
	b       bg.22484
be.22471:
	load    [$i1 + 4], $f4
	load    [$i1 + 5], $f5
	fsub    $f4, $f3, $f3
	load    [%{ext_light_dirvec + 0} + 0], $f6
	fmul    $f3, $f5, $f3
	load    [$i2 + 4], $f4
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f4, $f1, be.22518
bg.22473:
	load    [%{ext_light_dirvec + 0} + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i2 + 5], $f4
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, be.22518
bg.22474:
	be      $f5, $f0, be.22518
bne.22475:
	mov     $f3, $fg0
	ble     $fc4, $fg0, be.22518
.count dual_jmp
	b       bg.22484
bne.22464:
	be      $i4, 2, be.22476
bne.22476:
	be      $f4, $f0, be.22518
bne.22478:
	fmul    $f1, $f1, $f5
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $f7
	load    [$i2 + 5], $f8
	fmul    $f3, $f3, $f9
	fmul    $f5, $f7, $f5
	load    [$i2 + 6], $f7
	fmul    $f6, $f8, $f6
	load    [$i2 + 3], $i3
	fmul    $f9, $f7, $f7
	fadd    $f5, $f6, $f5
	fadd    $f5, $f7, $f5
	be      $i3, 0, be.22479
bne.22479:
	fmul    $f2, $f3, $f6
	load    [$i2 + 16], $f7
	fmul    $f3, $f1, $f8
	load    [$i2 + 17], $f9
	fmul    $f1, $f2, $f10
	fmul    $f6, $f7, $f6
	load    [$i2 + 18], $f7
	fmul    $f8, $f9, $f8
	fmul    $f10, $f7, $f7
	fadd    $f5, $f6, $f5
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	be      $i4, 3, be.22480
.count dual_jmp
	b       bne.22480
be.22479:
	be      $i4, 3, be.22480
bne.22480:
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f3, $f3
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f2
	load    [$i1 + 1], $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, be.22518
.count dual_jmp
	b       bg.22481
be.22480:
	fsub    $f5, $fc0, $f5
	load    [$i1 + 2], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f2, $f2
	fmul    $f7, $f1, $f1
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f3, $f3
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, be.22518
bg.22481:
	load    [$i2 + 10], $i2
	load    [$i1 + 4], $f3
	fsqrt   $f2, $f2
	be      $i2, 0, be.22482
bne.22482:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fc4, $fg0, be.22518
.count dual_jmp
	b       bg.22484
be.22482:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fc4, $fg0, be.22518
.count dual_jmp
	b       bg.22484
be.22476:
	ble     $f0, $f4, be.22518
bg.22477:
	load    [$i1 + 3], $f4
	fmul    $f4, $f3, $f3
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 1], $f6
	fmul    $f6, $f1, $f1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $fg0
	ble     $fc4, $fg0, be.22518
bg.22484:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22518
bne.22485:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22486
be.22486:
	li      2, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22518
bne.22486:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22518
bne.22504:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22505:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22518
bne.22506:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22507:
	load    [$i9 + 3], $i1
	be      $i1, -1, be.22518
bne.22508:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22509:
	load    [$i9 + 4], $i1
	be      $i1, -1, be.22518
bne.22510:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22511:
	load    [$i9 + 5], $i1
	be      $i1, -1, be.22518
bne.22512:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22513:
	load    [$i9 + 6], $i1
	be      $i1, -1, be.22518
bne.22514:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22515:
	load    [$i9 + 7], $i1
	be      $i1, -1, be.22518
bne.22516:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22517:
	li      8, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22500
be.22518:
	add     $i10, 1, $i1
	load    [$i11 + $i1], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22519
bne.22519:
	be      $i1, 99, bne.22524
bne.22520:
	call    solver_fast.2796
	be      $i1, 0, be.22503
bne.22521:
	ble     $fc4, $fg0, be.22503
bg.22522:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22503
bne.22523:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22524
be.22524:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22503
bne.22525:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22524
be.22526:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22503
bne.22524:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22503
bne.22529:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22500:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22503
bne.22501:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22500
be.22502:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22503
bne.22500:
	li      1, $i1
	jr      $ra3
be.22503:
	add     $i10, 2, $i10
	b       shadow_check_one_or_matrix.2868
be.22519:
	li      0, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f16]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i7], $i9
	be      $i9, -1, be.22569
bne.22534:
	load    [ext_objects + $i9], $i1
	load    [$i1 + 1], $i2
	load    [$i1 + 9], $f1
	fsub    $fg19, $f1, $f1
	load    [$i1 + 8], $f2
	fsub    $fg18, $f2, $f2
	load    [$i1 + 7], $f3
	fsub    $fg17, $f3, $f3
	bne     $i2, 1, bne.22535
be.22535:
	load    [$i8 + 0], $f4
	be      $f4, $f0, ble.22542
bne.22536:
	load    [$i1 + 10], $i2
	load    [$i1 + 4], $f5
	ble     $f0, $f4, ble.22537
bg.22537:
	be      $i2, 0, be.22538
.count dual_jmp
	b       bne.22906
ble.22537:
	be      $i2, 0, bne.22906
be.22538:
	fsub    $f5, $f3, $f5
	finv    $f4, $f4
	load    [$i1 + 5], $f6
	load    [$i8 + 1], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.22542
.count dual_jmp
	b       bg.22541
bne.22906:
	fneg    $f5, $f5
	load    [$i1 + 5], $f6
	fsub    $f5, $f3, $f5
	load    [$i8 + 1], $f7
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f6, $f5, ble.22542
bg.22541:
	load    [$i8 + 2], $f5
	load    [$i1 + 6], $f6
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.22542
bg.22542:
	mov     $f4, $fg0
	li      1, $i10
	ble     $fg0, $f0, bne.22569
.count dual_jmp
	b       bg.22570
ble.22542:
	load    [$i8 + 1], $f4
	be      $f4, $f0, ble.22550
bne.22544:
	load    [$i1 + 10], $i2
	load    [$i1 + 5], $f5
	ble     $f0, $f4, ble.22545
bg.22545:
	be      $i2, 0, be.22546
.count dual_jmp
	b       bne.22909
ble.22545:
	be      $i2, 0, bne.22909
be.22546:
	fsub    $f5, $f2, $f5
	load    [$i1 + 6], $f6
	finv    $f4, $f4
	load    [$i8 + 2], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.22550
.count dual_jmp
	b       bg.22549
bne.22909:
	fneg    $f5, $f5
	fsub    $f5, $f2, $f5
	load    [$i1 + 6], $f6
	finv    $f4, $f4
	load    [$i8 + 2], $f7
	fmul    $f5, $f4, $f4
	fmul    $f4, $f7, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f6, $f5, ble.22550
bg.22549:
	load    [$i8 + 0], $f5
	fmul    $f4, $f5, $f5
	load    [$i1 + 4], $f6
	fadd_a  $f5, $f3, $f5
	ble     $f6, $f5, ble.22550
bg.22550:
	mov     $f4, $fg0
	li      2, $i10
	ble     $fg0, $f0, bne.22569
.count dual_jmp
	b       bg.22570
ble.22550:
	load    [$i8 + 2], $f4
	be      $f4, $f0, ble.22566
bne.22552:
	finv    $f4, $f5
	load    [$i1 + 6], $f6
	load    [$i1 + 10], $i4
	ble     $f0, $f4, ble.22553
bg.22553:
	be      $i4, 0, be.22554
.count dual_jmp
	b       bne.22912
ble.22553:
	be      $i4, 0, bne.22912
be.22554:
	mov     $f6, $f4
	load    [$i1 + 4], $f6
	fsub    $f4, $f1, $f1
	load    [$i8 + 0], $f4
	fmul    $f1, $f5, $f1
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f6, $f3, ble.22566
.count dual_jmp
	b       bg.22557
bne.22912:
	fneg    $f6, $f4
	fsub    $f4, $f1, $f1
	load    [$i8 + 0], $f4
	load    [$i1 + 4], $f6
	fmul    $f1, $f5, $f1
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	ble     $f6, $f3, ble.22566
bg.22557:
	load    [$i8 + 1], $f3
	load    [$i1 + 5], $f4
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	ble     $f4, $f2, ble.22566
bg.22558:
	mov     $f1, $fg0
	li      3, $i10
	ble     $fg0, $f0, bne.22569
.count dual_jmp
	b       bg.22570
bne.22535:
	bne     $i2, 2, bne.22559
be.22559:
	load    [$i8 + 0], $f4
	load    [$i1 + 4], $f5
	fmul    $f4, $f5, $f4
	load    [$i8 + 1], $f6
	load    [$i1 + 5], $f7
	load    [$i8 + 2], $f8
	fmul    $f6, $f7, $f6
	load    [$i1 + 6], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f6, $f4
	fadd    $f4, $f8, $f4
	ble     $f4, $f0, ble.22566
bg.22560:
	finv    $f4, $f4
	fmul    $f5, $f3, $f3
	li      1, $i10
	fmul    $f7, $f2, $f2
	fmul    $f9, $f1, $f1
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f4, $fg0
	ble     $fg0, $f0, bne.22569
.count dual_jmp
	b       bg.22570
bne.22559:
	load    [$i1 + 3], $i4
	load    [$i1 + 6], $f4
	load    [$i8 + 2], $f5
	load    [$i1 + 5], $f6
	fmul    $f5, $f5, $f9
	load    [$i8 + 1], $f7
	fmul    $f7, $f7, $f10
	load    [$i8 + 0], $f8
	fmul    $f8, $f8, $f11
	load    [$i1 + 4], $f12
	fmul    $f9, $f4, $f9
	fmul    $f10, $f6, $f10
	fmul    $f11, $f12, $f11
	fadd    $f11, $f10, $f10
	fadd    $f10, $f9, $f9
	be      $i4, 0, be.22561
bne.22561:
	fmul    $f7, $f5, $f10
	load    [$i1 + 16], $f11
	fmul    $f5, $f8, $f13
	load    [$i1 + 17], $f14
	fmul    $f8, $f7, $f15
	fmul    $f10, $f11, $f10
	load    [$i1 + 18], $f11
	fmul    $f13, $f14, $f13
	fmul    $f15, $f11, $f11
	fadd    $f9, $f10, $f9
	fadd    $f9, $f13, $f9
	fadd    $f9, $f11, $f9
	be      $f9, $f0, ble.22566
.count dual_jmp
	b       bne.22562
be.22561:
	be      $f9, $f0, ble.22566
bne.22562:
	fmul    $f1, $f1, $f10
	fmul    $f2, $f2, $f11
	fmul    $f3, $f3, $f13
	fmul    $f10, $f4, $f10
	fmul    $f11, $f6, $f11
	fmul    $f13, $f12, $f13
	fadd    $f13, $f11, $f11
	fadd    $f11, $f10, $f10
	be      $i4, 0, be.22563
bne.22563:
	fmul    $f2, $f1, $f11
	load    [$i1 + 16], $f13
	fmul    $f1, $f3, $f14
	load    [$i1 + 17], $f15
	fmul    $f3, $f2, $f16
	fmul    $f11, $f13, $f11
	load    [$i1 + 18], $f13
	fmul    $f14, $f15, $f14
	fmul    $f16, $f13, $f13
	fadd    $f10, $f11, $f10
	fadd    $f10, $f14, $f10
	fadd    $f10, $f13, $f10
	be      $i2, 3, be.22564
.count dual_jmp
	b       bne.22564
be.22563:
	be      $i2, 3, be.22564
bne.22564:
	fmul    $f9, $f10, $f10
	fmul    $f5, $f1, $f11
	fmul    $f7, $f2, $f13
	fmul    $f8, $f3, $f14
	fmul    $f11, $f4, $f4
	fmul    $f13, $f6, $f6
	fmul    $f14, $f12, $f11
	fadd    $f11, $f6, $f6
	fadd    $f6, $f4, $f4
	be      $i4, 0, be.22565
.count dual_jmp
	b       bne.22565
be.22564:
	fsub    $f10, $fc0, $f10
	fmul    $f5, $f1, $f11
	fmul    $f7, $f2, $f13
	fmul    $f8, $f3, $f14
	fmul    $f9, $f10, $f10
	fmul    $f11, $f4, $f4
	fmul    $f13, $f6, $f6
	fmul    $f14, $f12, $f11
	fadd    $f11, $f6, $f6
	fadd    $f6, $f4, $f4
	be      $i4, 0, be.22565
bne.22565:
	fmul    $f5, $f2, $f6
	load    [$i1 + 16], $f12
	fmul    $f7, $f1, $f11
	load    [$i1 + 17], $f13
	fmul    $f8, $f1, $f1
	fmul    $f5, $f3, $f5
	fadd    $f6, $f11, $f6
	fmul    $f8, $f2, $f2
	fmul    $f7, $f3, $f3
	fadd    $f1, $f5, $f1
	load    [$i1 + 18], $f5
	fmul    $f6, $f12, $f6
	fadd    $f2, $f3, $f2
	fmul    $f1, $f13, $f1
	fmul    $f2, $f5, $f2
	fadd    $f6, $f1, $f1
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f10, $f2
	ble     $f2, $f0, ble.22566
.count dual_jmp
	b       bg.22566
be.22565:
	mov     $f4, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f10, $f2
	bg      $f2, $f0, bg.22566
ble.22566:
	load    [ext_objects + $i9], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22569
be.22569:
	jr      $ra1
bg.22566:
	load    [$i1 + 10], $i1
	fsqrt   $f2, $f2
	li      1, $i10
	finv    $f9, $f3
	be      $i1, 0, be.22567
bne.22567:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22569
.count dual_jmp
	b       bg.22570
be.22567:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22569
bg.22570:
	ble     $fg7, $fg0, bne.22569
bg.22571:
	fadd    $fg0, $fc11, $f13
	load    [$i8 + 2], $f1
	li      0, $i1
	load    [$i8 + 1], $f2
	fmul    $f2, $f13, $f2
	load    [$i8 + 0], $f3
	fmul    $f1, $f13, $f1
	fmul    $f3, $f13, $f3
	fadd    $f2, $fg18, $f14
	fadd    $f1, $fg19, $f4
	fadd    $f3, $fg17, $f2
.count move_args
	mov     $f14, $f3
	call    check_all_inside.2856
	add     $i7, 1, $i7
	be      $i1, 0, solve_each_element.2871
bne.22572:
	mov     $f13, $fg7
	store   $f2, [ext_intersection_point + 0]
	store   $f14, [ext_intersection_point + 1]
	mov     $i9, $ig4
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig2
	b       solve_each_element.2871
bne.22569:
	add     $i7, 1, $i7
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f16]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i12 + $i11], $i1
	be      $i1, -1, be.22580
bne.22573:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 1, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22574:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 2, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22575:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 3, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22576:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 4, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22577:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 5, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22578:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 6, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22579:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 7, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22580
bne.22580:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	add     $i11, 8, $i11
	b       solve_one_or_network.2875
be.22580:
	jr      $ra2
.end solve_one_or_network

######################################################################
# trace_or_matrix($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f17]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i14 + $i13], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22589
bne.22581:
	bne     $i1, 99, bne.22582
be.22582:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22588
bne.22583:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22588
bne.22584:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, be.22588
bne.22585:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, be.22588
bne.22586:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 5], $i1
	be      $i1, -1, be.22588
bne.22587:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 6], $i1
	be      $i1, -1, be.22588
bne.22588:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	li      7, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22589
.count dual_jmp
	b       bne.22589
be.22588:
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22589
bne.22589:
	be      $i1, 99, be.22590
bne.22590:
.count move_args
	mov     $i8, $i2
	call    solver.2773
	be      $i1, 0, ble.22596
bne.22595:
	ble     $fg7, $fg0, ble.22596
bg.22596:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
be.22590:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22596
bne.22591:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22596
bne.22592:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22596
bne.22593:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22596
bne.22594:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	li      5, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
ble.22596:
	add     $i13, 2, $i13
	b       trace_or_matrix.2879
be.22589:
	jr      $ra3
bne.22582:
.count move_args
	mov     $i8, $i2
	call    solver.2773
	be      $i1, 0, ble.22598
bne.22597:
	ble     $fg7, $fg0, ble.22598
bg.22598:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	add     $i13, 1, $i13
	b       trace_or_matrix.2879
ble.22598:
	add     $i13, 1, $i13
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f14]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i7], $i9
	be      $i9, -1, be.22618
bne.22599:
	load    [ext_objects + $i9], $i1
	load    [$i8 + 3], $i2
	load    [$i1 + 1], $i4
	load    [$i2 + $i9], $i2
	load    [$i1 + 21], $f1
	load    [$i1 + 20], $f2
	load    [$i1 + 19], $f3
	bne     $i4, 1, bne.22600
be.22600:
	load    [$i2 + 0], $f4
	fsub    $f4, $f3, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f4
	load    [$i8 + 1], $f6
	fmul    $f4, $f6, $f6
	load    [$i1 + 5], $f7
	fadd_a  $f6, $f2, $f6
	ble     $f7, $f6, be.22603
bg.22601:
	load    [$i8 + 2], $f6
	load    [$i1 + 6], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22603
bg.22602:
	be      $f5, $f0, be.22603
bne.22603:
	mov     $f4, $fg0
	li      1, $i10
	ble     $fg0, $f0, bne.22618
.count dual_jmp
	b       bg.22619
be.22603:
	load    [$i2 + 2], $f4
	load    [$i2 + 3], $f5
	fsub    $f4, $f2, $f4
	load    [$i8 + 0], $f6
	fmul    $f4, $f5, $f4
	load    [$i1 + 4], $f7
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f7, $f6, be.22607
bg.22605:
	load    [$i8 + 2], $f6
	fmul    $f4, $f6, $f6
	load    [$i1 + 6], $f7
	fadd_a  $f6, $f1, $f6
	ble     $f7, $f6, be.22607
bg.22606:
	be      $f5, $f0, be.22607
bne.22607:
	mov     $f4, $fg0
	li      2, $i10
	ble     $fg0, $f0, bne.22618
.count dual_jmp
	b       bg.22619
be.22607:
	load    [$i2 + 4], $f4
	fsub    $f4, $f1, $f1
	load    [$i2 + 5], $f5
	fmul    $f1, $f5, $f1
	load    [$i8 + 0], $f6
	fmul    $f1, $f6, $f6
	load    [$i1 + 4], $f4
	fadd_a  $f6, $f3, $f3
	ble     $f4, $f3, ble.22615
bg.22609:
	load    [$i8 + 1], $f3
	load    [$i1 + 5], $f4
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	ble     $f4, $f2, ble.22615
bg.22610:
	be      $f5, $f0, ble.22615
bne.22611:
	mov     $f1, $fg0
	li      3, $i10
	ble     $fg0, $f0, bne.22618
.count dual_jmp
	b       bg.22619
bne.22600:
	be      $i4, 2, be.22612
bne.22612:
	load    [$i2 + 0], $f4
	be      $f4, $f0, ble.22615
bne.22614:
	load    [$i1 + 22], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 3], $f6
	fmul    $f6, $f1, $f1
	load    [$i2 + 2], $f7
	fmul    $f7, $f2, $f2
	load    [$i2 + 1], $f8
	fmul    $f8, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	ble     $f2, $f0, ble.22615
bg.22615:
	load    [$i1 + 10], $i1
	li      1, $i10
	load    [$i2 + 4], $f3
	fsqrt   $f2, $f2
	be      $i1, 0, be.22616
bne.22616:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22618
.count dual_jmp
	b       bg.22619
be.22616:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ble     $fg0, $f0, bne.22618
.count dual_jmp
	b       bg.22619
be.22612:
	load    [$i2 + 0], $f1
	ble     $f0, $f1, ble.22615
bg.22613:
	load    [$i1 + 22], $f2
	li      1, $i10
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22618
bg.22619:
	ble     $fg7, $fg0, bne.22618
bg.22620:
	fadd    $fg0, $fc11, $f13
	load    [$i8 + 2], $f1
	li      0, $i1
	load    [$i8 + 1], $f2
	fmul    $f2, $f13, $f2
	load    [$i8 + 0], $f3
	fmul    $f1, $f13, $f1
	fmul    $f3, $f13, $f3
	fadd    $f2, $fg9, $f14
	fadd    $f1, $fg10, $f4
	fadd    $f3, $fg8, $f2
.count move_args
	mov     $f14, $f3
	call    check_all_inside.2856
	add     $i7, 1, $i7
	be      $i1, 0, solve_each_element_fast.2885
bne.22621:
	mov     $f13, $fg7
	store   $f2, [ext_intersection_point + 0]
	store   $f14, [ext_intersection_point + 1]
	mov     $i9, $ig4
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig2
	b       solve_each_element_fast.2885
ble.22615:
	load    [ext_objects + $i9], $i1
	load    [$i1 + 10], $i1
	be      $i1, 0, be.22618
bne.22618:
	add     $i7, 1, $i7
	b       solve_each_element_fast.2885
be.22618:
	jr      $ra1
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f14]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i12 + $i11], $i1
	be      $i1, -1, be.22629
bne.22622:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 1, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22623:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 2, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22624:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 3, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22625:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 4, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22626:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 5, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22627:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 6, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22628:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 7, $i1
	load    [$i12 + $i1], $i1
	be      $i1, -1, be.22629
bne.22629:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	add     $i11, 8, $i11
	b       solve_one_or_network_fast.2889
be.22629:
	jr      $ra2
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f14]
# [$ig2, $ig4]
# []
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i14 + $i13], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22638
bne.22630:
	bne     $i1, 99, bne.22631
be.22631:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22637
bne.22632:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22637
bne.22633:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, be.22637
bne.22634:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, be.22637
bne.22635:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 5], $i1
	be      $i1, -1, be.22637
bne.22636:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 6], $i1
	be      $i1, -1, be.22637
bne.22637:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22638
.count dual_jmp
	b       bne.22638
be.22637:
	add     $i13, 1, $i1
	load    [$i14 + $i1], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22638
bne.22638:
	be      $i1, 99, be.22639
bne.22639:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22645
bne.22644:
	ble     $fg7, $fg0, ble.22645
bg.22645:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
be.22639:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22645
bne.22640:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22645
bne.22641:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22645
bne.22642:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22645
bne.22643:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
ble.22645:
	add     $i13, 2, $i13
	b       trace_or_matrix_fast.2893
be.22638:
	jr      $ra3
bne.22631:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22647
bne.22646:
	ble     $fg7, $fg0, ble.22647
bg.22647:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i13, 1, $i13
	b       trace_or_matrix_fast.2893
ble.22647:
	add     $i13, 1, $i13
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i2)
# $ra = $ra1
# [$i1]
# [$f1 - $f12]
# []
# []
# [$fg11, $fg14, $fg16]
# [$ra]
######################################################################
.align 2
.begin utexture
utexture.2908:
	load    [$i2 + 0], $i1
	load    [$i2 + 13], $fg16
	load    [$i2 + 14], $fg11
	load    [$i2 + 15], $fg14
	be      $i1, 1, be.22648
bne.22648:
	be      $i1, 2, be.22653
bne.22653:
	be      $i1, 3, be.22654
bne.22654:
	bne     $i1, 4, bne.22655
be.22655:
	load    [$i2 + 6], $f1
	fsqrt   $f1, $f1
	load    [$i2 + 9], $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i2 + 4], $f4
	fsub    $f3, $f2, $f2
	load    [$i2 + 7], $f3
	fsqrt   $f4, $f4
	load    [ext_intersection_point + 0], $f5
	fsub    $f5, $f3, $f3
.count load_float
	load    [f.22040], $f9
	fmul    $f2, $f1, $f10
	fmul    $f3, $f4, $f11
	fabs    $f11, $f1
	ble     $f9, $f1, ble.22656
bg.22656:
	mov     $fc15, $f12
	fmul    $f10, $f10, $f1
	load    [$i2 + 5], $f3
	fmul    $f11, $f11, $f2
	load    [$i2 + 8], $f4
	load    [ext_intersection_point + 1], $f5
	fsqrt   $f3, $f3
	fadd    $f2, $f1, $f1
	fsub    $f5, $f4, $f2
	fabs    $f1, $f4
	fmul    $f2, $f3, $f2
	ble     $f9, $f4, ble.22657
.count dual_jmp
	b       bg.22657
ble.22656:
	finv    $f11, $f1
	fmul_a  $f10, $f1, $f2
	call    ext_atan
	fmul    $fc14, $f1, $f12
	fmul    $f10, $f10, $f1
	load    [$i2 + 5], $f3
	fmul    $f11, $f11, $f2
	load    [$i2 + 8], $f4
	load    [ext_intersection_point + 1], $f5
	fsqrt   $f3, $f3
	fadd    $f2, $f1, $f1
	fsub    $f5, $f4, $f2
	fabs    $f1, $f4
	fmul    $f2, $f3, $f2
	ble     $f9, $f4, ble.22657
bg.22657:
	mov     $fc15, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
.count move_args
	mov     $f12, $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f4
	call    ext_floor
	fsub    $f12, $f1, $f1
.count load_float
	load    [f.22046], $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f2, $f1, $f1
	fsub    $f1, $f4, $f1
	ble     $f0, $f1, ble.22658
.count dual_jmp
	b       bg.22658
ble.22657:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
	fmul    $fc14, $f1, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
.count move_args
	mov     $f12, $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f4
	call    ext_floor
	fsub    $f12, $f1, $f1
.count load_float
	load    [f.22046], $f2
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f2, $f1, $f1
	fsub    $f1, $f4, $f1
	ble     $f0, $f1, ble.22658
bg.22658:
	mov     $f0, $fg14
	jr      $ra1
ble.22658:
.count load_float
	load    [f.22047], $f2
	fmul    $f2, $f1, $fg14
	jr      $ra1
bne.22655:
	jr      $ra1
be.22654:
.count load_float
	load    [f.22043], $f4
	load    [$i2 + 9], $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i2 + 7], $f3
	fsub    $f2, $f1, $f1
	load    [ext_intersection_point + 0], $f5
	fsub    $f5, $f3, $f2
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc7, $f5
.count move_args
	mov     $f5, $f2
	call    ext_floor
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	fsub    $fc0, $f1, $f2
	fmul    $f1, $fc6, $fg11
	fmul    $f2, $fc6, $fg14
	jr      $ra1
be.22653:
.count load_float
	load    [f.22050], $f1
	load    [ext_intersection_point + 1], $f2
	fmul    $f2, $f1, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fsub    $fc0, $f1, $f2
	fmul    $fc6, $f1, $fg16
	fmul    $fc6, $f2, $fg11
	jr      $ra1
be.22648:
	load    [$i2 + 7], $f1
	load    [ext_intersection_point + 0], $f2
.count load_float
	load    [f.22051], $f4
	fsub    $f2, $f1, $f6
.count load_float
	load    [f.22052], $f5
	fmul    $f6, $f5, $f2
	call    ext_floor
	fmul    $f1, $f4, $f1
.count load_float
	load    [f.22053], $f7
	fsub    $f6, $f1, $f1
	load    [ext_intersection_point + 2], $f2
	ble     $f7, $f1, ble.22649
bg.22649:
	load    [$i2 + 9], $f1
	li      1, $i1
	fsub    $f2, $f1, $f6
	fmul    $f6, $f5, $f2
	call    ext_floor
	fmul    $f1, $f4, $f1
	fsub    $f6, $f1, $f1
	ble     $f7, $f1, ble.22650
.count dual_jmp
	b       bg.22650
ble.22649:
	load    [$i2 + 9], $f1
	li      0, $i1
	fsub    $f2, $f1, $f6
	fmul    $f6, $f5, $f2
	call    ext_floor
	fmul    $f1, $f4, $f1
	fsub    $f6, $f1, $f1
	ble     $f7, $f1, ble.22650
bg.22650:
	be      $i1, 0, be.22652
.count dual_jmp
	b       bne.22652
ble.22650:
	be      $i1, 0, bne.22652
be.22652:
	mov     $f0, $fg11
	jr      $ra1
bne.22652:
	mov     $fc6, $fg11
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i15, $f15, $f16, $i16)
# $ra = $ra4
# [$i1 - $i15, $i17]
# [$f1 - $f14]
# [$ig2, $ig4]
# []
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_reflections
trace_reflections.2915:
	bl      $i15, 0, bl.22659
bge.22659:
	load    [$ig1 + 0], $i12
	load    [ext_reflections + $i15], $i17
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22660
be.22660:
	ble     $fg7, $fc4, bne.22671
.count dual_jmp
	b       bg.22668
bne.22660:
	add     $i17, 1, $i8
	be      $i1, 99, be.22661
bne.22661:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22667
bne.22666:
	ble     $fg7, $fg0, ble.22667
bg.22667:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22671
.count dual_jmp
	b       bg.22668
be.22661:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22667
bne.22662:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22667
bne.22663:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22667
bne.22664:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22667
bne.22665:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22671
.count dual_jmp
	b       bg.22668
ble.22667:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22671
bg.22668:
	ble     $fc9, $fg7, bne.22671
bg.22669:
	add     $ig4, $ig4, $i1
	load    [$i17 + 0], $i2
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
	bne     $i1, $i2, bne.22671
be.22671:
	li      0, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22671
be.22672:
	load    [$i17 + 5], $f1
	fmul    $f1, $f15, $f8
	load    [$i17 + 1], $f2
	load    [ext_nvector + 0], $f3
	load    [$i17 + 2], $f4
	fmul    $f3, $f2, $f3
	load    [ext_nvector + 1], $f5
	fmul    $f5, $f4, $f5
	load    [$i17 + 3], $f6
	fadd    $f3, $f5, $f3
	load    [ext_nvector + 2], $f7
	fmul    $f7, $f6, $f7
	fadd    $f3, $f7, $f3
	fmul    $f8, $f3, $f3
	ble     $f3, $f0, ble.22673
bg.22673:
	fmul    $f3, $fg16, $f5
	fmul    $f3, $fg11, $f7
	fmul    $f3, $fg14, $f3
	fadd    $fg4, $f5, $fg4
	load    [$i16 + 1], $f5
	fadd    $fg5, $f7, $fg5
	load    [$i16 + 2], $f7
	fadd    $fg6, $f3, $fg6
	load    [$i16 + 0], $f3
	fmul    $f3, $f2, $f2
	fmul    $f5, $f4, $f3
	fmul    $f7, $f6, $f4
	fadd    $f2, $f3, $f2
	fadd    $f2, $f4, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22671
.count dual_jmp
	b       bg.22674
ble.22673:
	load    [$i16 + 0], $f3
	fmul    $f3, $f2, $f2
	load    [$i16 + 1], $f5
	fmul    $f5, $f4, $f3
	load    [$i16 + 2], $f7
	fmul    $f7, $f6, $f4
	fadd    $f2, $f3, $f2
	fadd    $f2, $f4, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22671
bg.22674:
	fmul    $f1, $f1, $f1
	add     $i15, -1, $i15
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
bne.22671:
	add     $i15, -1, $i15
	b       trace_reflections.2915
bl.22659:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i18, $f18, $i16, $i19, $f19)
# $ra = $ra5
# [$i1 - $i15, $i17 - $i18, $i20 - $i21]
# [$f1 - $f19]
# [$ig2, $ig4]
# []
# [$fg0, $fg4 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra4]
######################################################################
.align 2
.begin trace_ray
trace_ray.2920:
	bg      $i18, 4, bg.22675
ble.22675:
	load    [$ig1 + 0], $i12
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22676
be.22676:
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22685
.count dual_jmp
	b       bg.22684
bne.22676:
	be      $i1, 99, be.22677
bne.22677:
.count move_args
	mov     $i16, $i2
	call    solver.2773
.count move_args
	mov     $i16, $i8
	be      $i1, 0, ble.22683
bne.22682:
	ble     $fg7, $fg0, ble.22683
bg.22683:
	li      1, $i11
	jal     solve_one_or_network.2875, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
.count move_args
	mov     $i16, $i8
	jal     trace_or_matrix.2879, $ra3
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22685
.count dual_jmp
	b       bg.22684
be.22677:
	load    [$i12 + 1], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22683
bne.22678:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 2], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22683
bne.22679:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 3], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22683
bne.22680:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element.2871, $ra1
	load    [$i12 + 4], $i1
.count move_args
	mov     $i16, $i8
	be      $i1, -1, ble.22683
bne.22681:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
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
	ble     $fg7, $fc4, ble.22685
.count dual_jmp
	b       bg.22684
ble.22683:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix.2879, $ra3
	add     $i19, 8, $i20
	ble     $fg7, $fc4, ble.22685
bg.22684:
	bg      $fc9, $fg7, bg.22685
ble.22685:
	add     $i0, -1, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	be      $i18, 0, bg.22675
bne.22687:
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	fmul    $f1, $fg12, $f1
	load    [$i16 + 0], $f3
	fmul    $f2, $fg13, $f2
	fmul    $f3, $fg15, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	ble     $f1, $f0, bg.22675
bg.22688:
	fmul    $f1, $f1, $f2
	mov     $fig12, $f3
	fmul    $f2, $f1, $f1
	fmul    $f1, $f18, $f1
	fmul    $f1, $f3, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
bg.22685:
	load    [ext_objects + $ig4], $i21
	load    [$i21 + 1], $i1
	be      $i1, 1, be.22689
bne.22689:
	bne     $i1, 2, bne.22692
be.22692:
	load    [$i21 + 4], $f1
.count move_args
	mov     $i21, $i2
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i21 + 5], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i21 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
bne.22692:
	load    [$i21 + 9], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i21 + 8], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i21 + 7], $f2
	fsub    $f4, $f3, $f3
	load    [ext_intersection_point + 0], $f5
	fsub    $f5, $f2, $f2
	load    [$i21 + 6], $f4
	fmul    $f1, $f4, $f4
	load    [$i21 + 5], $f5
	fmul    $f3, $f5, $f5
	load    [$i21 + 4], $f6
	fmul    $f2, $f6, $f6
	load    [$i21 + 3], $i1
	be      $i1, 0, be.22693
bne.22693:
	load    [$i21 + 18], $f7
	fmul    $f3, $f7, $f7
	load    [$i21 + 17], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i21 + 18], $f6
	fmul    $f2, $f6, $f6
	load    [$i21 + 16], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i21 + 17], $f1
	fmul    $f2, $f1, $f1
	load    [$i21 + 16], $f5
	fmul    $f3, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f4
	load    [$i21 + 10], $i1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	be      $f1, $f0, be.22694
.count dual_jmp
	b       bne.22694
be.22693:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
	load    [ext_nvector + 2], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 0], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f4
	load    [$i21 + 10], $i1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $f1, $f0, bne.22694
be.22694:
	mov     $fc0, $f1
.count move_args
	mov     $i21, $i2
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
bne.22694:
.count move_args
	mov     $i21, $i2
	be      $i1, 0, be.22695
bne.22695:
	finv_n  $f1, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
be.22695:
	finv    $f1, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
be.22689:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
.count move_args
	mov     $i21, $i2
	store   $f0, [ext_nvector + 2]
	load    [$i16 + $i1], $f1
	bne     $f1, $f0, bne.22690
be.22690:
	store   $f0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
bne.22690:
	ble     $f1, $f0, ble.22691
bg.22691:
	store   $fc12, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
.count dual_jmp
	b       bg.22696
ble.22691:
	store   $fc0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i19, 3, $i2
	add     $i1, $i1, $i1
	add     $i19, 13, $i3
	add     $i1, $ig2, $i1
.count storer
	add     $i20, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + $i18], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i21 + 11], $f1
	fmul    $f1, $f18, $f15
	ble     $fc3, $f1, ble.22696
bg.22696:
	li      0, $i1
.count storer
	add     $i3, $i18, $tmp
	store   $i1, [$tmp + 0]
	load    [$i16 + 0], $f1
	load    [ext_nvector + 2], $f2
	load    [$i16 + 2], $f3
	load    [ext_nvector + 1], $f4
	fmul    $f3, $f2, $f2
	load    [$i16 + 1], $f5
	fmul    $f5, $f4, $f3
	load    [ext_nvector + 0], $f6
	fmul    $f1, $f6, $f4
.count load_float
	load    [f.22058], $f5
	fadd    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fmul    $f5, $f2, $f2
	fmul    $f2, $f6, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i16 + 0]
	load    [ext_nvector + 1], $f1
	load    [$i16 + 1], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i16 + 2], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 2]
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22697
.count dual_jmp
	b       bne.22697
ble.22696:
	li      1, $i1
.count storer
	add     $i3, $i18, $tmp
	store   $i1, [$tmp + 0]
	add     $i19, 18, $i2
	load    [$i2 + $i18], $i1
.count load_float
	load    [f.22057], $f1
	add     $i19, 29, $i3
	store   $fg16, [$i1 + 0]
	fmul    $f1, $f15, $f1
	store   $fg11, [$i1 + 1]
	store   $fg14, [$i1 + 2]
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
	load    [$i16 + 0], $f1
	load    [ext_nvector + 2], $f2
	load    [$i16 + 2], $f3
	load    [ext_nvector + 1], $f4
	fmul    $f3, $f2, $f2
	load    [$i16 + 1], $f5
	fmul    $f5, $f4, $f3
	load    [ext_nvector + 0], $f6
	fmul    $f1, $f6, $f4
.count load_float
	load    [f.22058], $f5
	fadd    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fmul    $f5, $f2, $f2
	fmul    $f2, $f6, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i16 + 0]
	load    [ext_nvector + 1], $f1
	load    [$i16 + 1], $f3
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i16 + 2], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i16 + 2]
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22697
bne.22697:
	be      $i1, 99, bne.22702
bne.22698:
	call    solver_fast.2796
	be      $i1, 0, be.22711
bne.22699:
	ble     $fc4, $fg0, be.22711
bg.22700:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22711
bne.22701:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22702
be.22702:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22711
bne.22703:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22702
be.22704:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22711
bne.22702:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22711
bne.22707:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22708
be.22708:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22711
bne.22709:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22708
be.22710:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22711
bne.22708:
	load    [$i21 + 12], $f1
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	fmul    $f18, $f1, $f16
	load    [ext_intersection_point + 1], $fg9
	add     $ig0, -1, $i1
	load    [ext_intersection_point + 2], $fg10
	call    setup_startp_constants.2831
	add     $ig3, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f18, $fc7, bg.22675
.count dual_jmp
	b       bg.22715
be.22711:
	li      1, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i21 + 12], $f1
	fmul    $f18, $f1, $f16
	bne     $i1, 0, bne.22712
be.22712:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg15, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg13, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $fg12, $f3
	load    [$i16 + 0], $f4
	fadd    $f1, $f2, $f1
	load    [$i16 + 1], $f5
	fmul    $f4, $fg15, $f2
	load    [$i16 + 2], $f6
	fmul    $f5, $fg13, $f4
	fmul    $f6, $fg12, $f5
	fadd_n  $f1, $f3, $f1
	fadd    $f2, $f4, $f2
	fmul    $f1, $f15, $f1
	fadd_n  $f2, $f5, $f2
	ble     $f1, $f0, ble.22713
.count dual_jmp
	b       bg.22713
be.22697:
	load    [$i21 + 12], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f18, $f1, $f16
	load    [ext_nvector + 2], $f3
	fmul    $f2, $fg13, $f2
	load    [ext_nvector + 0], $f1
	fmul    $f3, $fg12, $f3
	fmul    $f1, $fg15, $f1
	load    [$i16 + 0], $f4
	load    [$i16 + 1], $f5
	fadd    $f1, $f2, $f1
	load    [$i16 + 2], $f6
	fmul    $f4, $fg15, $f2
	fmul    $f5, $fg13, $f4
	fmul    $f6, $fg12, $f5
	fadd_n  $f1, $f3, $f1
	fadd    $f2, $f4, $f2
	fmul    $f1, $f15, $f1
	fadd_n  $f2, $f5, $f2
	ble     $f1, $f0, ble.22713
bg.22713:
	fmul    $f1, $fg16, $f3
	fmul    $f1, $fg11, $f4
	fmul    $f1, $fg14, $f1
	fadd    $fg4, $f3, $fg4
	fadd    $fg5, $f4, $fg5
	fadd    $fg6, $f1, $fg6
	ble     $f2, $f0, bne.22712
.count dual_jmp
	b       bg.22714
ble.22713:
	ble     $f2, $f0, bne.22712
bg.22714:
	fmul    $f2, $f2, $f1
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	fmul    $f1, $f1, $f1
	load    [ext_intersection_point + 1], $fg9
	add     $ig0, -1, $i1
	load    [ext_intersection_point + 2], $fg10
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	call    setup_startp_constants.2831
	add     $ig3, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f18, $fc7, bg.22675
.count dual_jmp
	b       bg.22715
bne.22712:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	add     $ig0, -1, $i1
	load    [ext_intersection_point + 2], $fg10
	call    setup_startp_constants.2831
	add     $ig3, -1, $i15
	jal     trace_reflections.2915, $ra4
	ble     $f18, $fc7, bg.22675
bg.22715:
	bge     $i18, 4, bge.22716
bl.22716:
	add     $i18, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i20, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i21 + 2], $i1
	be      $i1, 2, be.22717
.count dual_jmp
	b       bg.22675
bge.22716:
	load    [$i21 + 2], $i1
	be      $i1, 2, be.22717
bg.22675:
	jr      $ra5
be.22717:
	load    [$i21 + 11], $f1
	add     $i18, 1, $i18
	fadd    $f19, $fg7, $f19
	fsub    $fc0, $f1, $f1
	fmul    $f18, $f1, $f18
	b       trace_ray.2920
.end trace_ray

######################################################################
# trace_diffuse_ray($i8, $f15)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f14]
# [$ig2, $ig4]
# []
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	load    [$ig1 + 0], $i12
	mov     $fc10, $fg7
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22718
be.22718:
	ble     $fg7, $fc4, bne.22747
.count dual_jmp
	b       bg.22726
bne.22718:
	be      $i1, 99, be.22719
bne.22719:
.count move_args
	mov     $i8, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22725
bne.22724:
	ble     $fg7, $fg0, ble.22725
bg.22725:
	li      1, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22747
.count dual_jmp
	b       bg.22726
be.22719:
	load    [$i12 + 1], $i1
	be      $i1, -1, ble.22725
bne.22720:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 2], $i1
	be      $i1, -1, ble.22725
bne.22721:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 3], $i1
	be      $i1, -1, ble.22725
bne.22722:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	load    [$i12 + 4], $i1
	be      $i1, -1, ble.22725
bne.22723:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i11
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22747
.count dual_jmp
	b       bg.22726
ble.22725:
	li      1, $i13
.count move_args
	mov     $ig1, $i14
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc4, bne.22747
bg.22726:
	ble     $fc9, $fg7, bne.22747
bg.22727:
	load    [ext_objects + $ig4], $i12
	load    [$i12 + 1], $i1
	be      $i1, 1, be.22729
bne.22729:
	bne     $i1, 2, bne.22732
be.22732:
	load    [$i12 + 4], $f1
.count move_args
	mov     $i12, $i2
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i12 + 5], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i12 + 6], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
bne.22732:
	load    [$i12 + 9], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i12 + 8], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i12 + 7], $f2
	fsub    $f4, $f3, $f3
	load    [ext_intersection_point + 0], $f5
	fsub    $f5, $f2, $f2
	load    [$i12 + 6], $f4
	fmul    $f1, $f4, $f4
	load    [$i12 + 5], $f5
	fmul    $f3, $f5, $f5
	load    [$i12 + 4], $f6
	fmul    $f2, $f6, $f6
	load    [$i12 + 3], $i1
	be      $i1, 0, be.22733
bne.22733:
	load    [$i12 + 18], $f7
	fmul    $f3, $f7, $f7
	load    [$i12 + 17], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i12 + 18], $f6
	fmul    $f2, $f6, $f6
	load    [$i12 + 16], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i12 + 17], $f1
	fmul    $f2, $f1, $f1
	load    [$i12 + 16], $f5
	fmul    $f3, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f4
	load    [$i12 + 10], $i1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	be      $f1, $f0, be.22734
.count dual_jmp
	b       bne.22734
be.22733:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
	load    [ext_nvector + 2], $f1
	load    [ext_nvector + 1], $f2
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 0], $f3
	fmul    $f2, $f2, $f2
	fmul    $f3, $f3, $f4
	load    [$i12 + 10], $i1
	fadd    $f4, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $f1, $f0, bne.22734
be.22734:
	mov     $fc0, $f1
.count move_args
	mov     $i12, $i2
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
bne.22734:
.count move_args
	mov     $i12, $i2
	be      $i1, 0, be.22735
bne.22735:
	finv_n  $f1, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
be.22735:
	finv    $f1, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
be.22729:
	add     $ig2, -1, $i1
	store   $f0, [ext_nvector + 0]
.count move_args
	mov     $i12, $i2
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	load    [$i8 + $i1], $f1
	bne     $f1, $f0, bne.22730
be.22730:
	store   $f0, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
bne.22730:
	ble     $f1, $f0, ble.22731
bg.22731:
	store   $fc12, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
.count dual_jmp
	b       bne.22736
ble.22731:
	store   $fc0, [ext_nvector + $i1]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i9
	load    [$i9 + 0], $i1
	be      $i1, -1, be.22751
bne.22736:
	be      $i1, 99, bne.22741
bne.22737:
	call    solver_fast.2796
	be      $i1, 0, be.22750
bne.22738:
	ble     $fc4, $fg0, be.22750
bg.22739:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22750
bne.22740:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22741
be.22741:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22750
bne.22742:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22741
be.22743:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22750
bne.22741:
	load    [$i9 + 1], $i1
	be      $i1, -1, be.22750
bne.22746:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22747
be.22747:
	load    [$i9 + 2], $i1
	be      $i1, -1, be.22750
bne.22748:
	load    [ext_and_net + $i1], $i3
	li      0, $i7
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22747
be.22749:
	li      3, $i8
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22747
be.22750:
	li      1, $i10
.count move_args
	mov     $ig1, $i11
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22747
be.22751:
	load    [$i12 + 11], $f1
	load    [ext_nvector + 2], $f2
	load    [ext_nvector + 1], $f3
	fmul    $f2, $fg12, $f2
	load    [ext_nvector + 0], $f4
	fmul    $f3, $fg13, $f3
	fmul    $f4, $fg15, $f4
	fadd    $f4, $f3, $f3
	fadd_n  $f3, $f2, $f2
	ble     $f2, $f0, ble.22752
bg.22752:
	fmul    $f15, $f2, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $fg16, $f2
	fmul    $f1, $fg11, $f3
	fmul    $f1, $fg14, $f1
	fadd    $fg1, $f2, $fg1
	fadd    $fg2, $f3, $fg2
	fadd    $fg3, $f1, $fg3
	jr      $ra4
ble.22752:
	mov     $f0, $f2
	fmul    $f15, $f2, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $fg16, $f2
	fmul    $f1, $fg11, $f3
	fmul    $f1, $fg14, $f1
	fadd    $fg1, $f2, $fg1
	fadd    $fg2, $f3, $fg2
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bne.22747:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i15, $i16, $i17)
# $ra = $ra5
# [$i1 - $i14, $i17]
# [$f1 - $f15]
# [$ig2, $ig4]
# []
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
# [$ra - $ra4]
######################################################################
.align 2
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i17, 0, bl.22753
bge.22753:
	load    [$i15 + $i17], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22754
bg.22754:
	add     $i17, 1, $i1
	fmul    $f1, $fc2, $f15
	load    [$i15 + $i1], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	bge     $i17, 0, bge.22757
.count dual_jmp
	b       bl.22753
ble.22754:
	load    [$i15 + $i17], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	bl      $i17, 0, bl.22753
bge.22757:
	load    [$i15 + $i17], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22758
bg.22758:
	add     $i17, 1, $i1
	fmul    $f1, $fc2, $f15
	load    [$i15 + $i1], $i8
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	b       iter_trace_diffuse_rays.2929
ble.22758:
	load    [$i15 + $i17], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	add     $i17, -2, $i17
	b       iter_trace_diffuse_rays.2929
bl.22753:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i18, $i19)
# $ra = $ra6
# [$i1 - $i17, $i20 - $i21]
# [$f1 - $f15]
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	add     $i18, 23, $i1
	load    [$i1 + $i19], $i1
	add     $i18, 3, $i2
	load    [$i18 + 28], $i20
	add     $i18, 29, $i3
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i2 + $i19], $i21
	load    [$i3 + $i19], $i16
	bne     $i20, 0, bne.22759
be.22759:
	be      $i20, 1, be.22761
.count dual_jmp
	b       bne.22761
bne.22759:
	load    [ext_dirvecs + 0], $i15
	load    [$i21 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i21 + 1], $fg9
.count move_args
	mov     $i21, $i2
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22760
bg.22760:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i20, 1, be.22761
.count dual_jmp
	b       bne.22761
ble.22760:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i20, 1, bne.22761
be.22761:
	be      $i20, 2, be.22763
.count dual_jmp
	b       bne.22763
bne.22761:
	load    [ext_dirvecs + 1], $i15
	add     $ig0, -1, $i1
	load    [$i21 + 0], $fg8
.count move_args
	mov     $i21, $i2
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22762
bg.22762:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i20, 2, be.22763
.count dual_jmp
	b       bne.22763
ble.22762:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i20, 2, bne.22763
be.22763:
	be      $i20, 3, be.22765
.count dual_jmp
	b       bne.22765
bne.22763:
	load    [ext_dirvecs + 2], $i15
	load    [$i21 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i21 + 1], $fg9
.count move_args
	mov     $i21, $i2
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22764
bg.22764:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i20, 3, be.22765
.count dual_jmp
	b       bne.22765
ble.22764:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i20, 3, bne.22765
be.22765:
	be      $i20, 4, be.22767
.count dual_jmp
	b       bne.22767
bne.22765:
	load    [ext_dirvecs + 3], $i15
	add     $ig0, -1, $i1
	load    [$i21 + 0], $fg8
.count move_args
	mov     $i21, $i2
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22766
bg.22766:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i20, 4, be.22767
.count dual_jmp
	b       bne.22767
ble.22766:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i20, 4, be.22767
bne.22767:
	load    [ext_dirvecs + 4], $i15
	load    [$i21 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i21 + 1], $fg9
.count move_args
	mov     $i21, $i2
	load    [$i21 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22768
bg.22768:
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
ble.22768:
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
be.22767:
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
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i22, 4, bg.22769
ble.22769:
	add     $i18, 8, $i19
	load    [$i19 + $i22], $i1
	bl      $i1, 0, bg.22769
bge.22770:
	add     $i18, 13, $i20
	load    [$i20 + $i22], $i1
	bne     $i1, 0, bne.22771
be.22771:
	add     $i22, 1, $i1
	bg      $i1, 4, bg.22769
ble.22772:
	load    [$i19 + $i1], $i2
	bl      $i2, 0, bg.22769
bge.22773:
	load    [$i20 + $i1], $i2
	be      $i2, 0, be.22787
bne.22774:
.count move_args
	mov     $i1, $i19
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
bne.22771:
	add     $i18, 23, $i1
	add     $i18, 3, $i2
	load    [$i1 + $i22], $i1
	add     $i18, 29, $i3
	load    [$i18 + 28], $i21
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i3 + $i22], $i16
	load    [$i2 + $i22], $i23
	bne     $i21, 0, bne.22775
be.22775:
	be      $i21, 1, be.22777
.count dual_jmp
	b       bne.22777
bne.22775:
	load    [ext_dirvecs + 0], $i15
	add     $ig0, -1, $i1
	load    [$i23 + 0], $fg8
.count move_args
	mov     $i23, $i2
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22776
bg.22776:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 1, be.22777
.count dual_jmp
	b       bne.22777
ble.22776:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 1, bne.22777
be.22777:
	be      $i21, 2, be.22779
.count dual_jmp
	b       bne.22779
bne.22777:
	load    [ext_dirvecs + 1], $i15
	load    [$i23 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i23 + 1], $fg9
.count move_args
	mov     $i23, $i2
	load    [$i23 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22778
bg.22778:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 2, be.22779
.count dual_jmp
	b       bne.22779
ble.22778:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 2, bne.22779
be.22779:
	be      $i21, 3, be.22781
.count dual_jmp
	b       bne.22781
bne.22779:
	load    [ext_dirvecs + 2], $i15
	add     $ig0, -1, $i1
	load    [$i23 + 0], $fg8
.count move_args
	mov     $i23, $i2
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22780
bg.22780:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 3, be.22781
.count dual_jmp
	b       bne.22781
ble.22780:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 3, bne.22781
be.22781:
	be      $i21, 4, be.22783
.count dual_jmp
	b       bne.22783
bne.22781:
	load    [ext_dirvecs + 3], $i15
	load    [$i23 + 0], $fg8
	add     $ig0, -1, $i1
	load    [$i23 + 1], $fg9
.count move_args
	mov     $i23, $i2
	load    [$i23 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22782
bg.22782:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i21, 4, be.22783
.count dual_jmp
	b       bne.22783
ble.22782:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i21, 4, bne.22783
be.22783:
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
	ble     $i2, 4, ble.22785
.count dual_jmp
	b       bg.22769
bne.22783:
	load    [ext_dirvecs + 4], $i15
	add     $ig0, -1, $i1
	load    [$i23 + 0], $fg8
.count move_args
	mov     $i23, $i2
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	call    setup_startp_constants.2831
	load    [$i15 + 118], $i1
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f2, $f2
	load    [$i16 + 0], $f5
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22784
bg.22784:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
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
	ble     $i2, 4, ble.22785
.count dual_jmp
	b       bg.22769
ble.22784:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
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
	bg      $i2, 4, bg.22769
ble.22785:
	load    [$i19 + $i2], $i1
	bl      $i1, 0, bg.22769
bge.22786:
	load    [$i20 + $i2], $i1
	be      $i1, 0, be.22787
bne.22787:
.count move_args
	mov     $i2, $i19
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
be.22787:
	add     $i22, 2, $i22
	b       do_without_neighbors.2951
bg.22769:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i19)
# $ra = $ra7
# [$i1 - $i23]
# [$f1 - $f15]
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i19, 4, bg.22788
ble.22788:
	load    [$i4 + $i2], $i1
	add     $i1, 8, $i6
	load    [$i6 + $i19], $i6
	bl      $i6, 0, bg.22788
bge.22789:
	load    [$i3 + $i2], $i7
	add     $i7, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22790
be.22790:
	load    [$i5 + $i2], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22790
be.22791:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	bne     $i8, $i6, bne.22790
be.22792:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i19], $i8
	be      $i8, $i6, be.22793
bne.22790:
	bg      $i19, 4, bg.22788
ble.22795:
	load    [$i4 + $i2], $i18
	add     $i18, 8, $i1
	load    [$i1 + $i19], $i1
	bl      $i1, 0, bg.22788
bge.22796:
	add     $i18, 13, $i1
	load    [$i1 + $i19], $i1
	be      $i1, 0, be.22797
bne.22797:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i19, 1, $i22
	b       do_without_neighbors.2951
be.22797:
	add     $i19, 1, $i22
	b       do_without_neighbors.2951
bg.22788:
	jr      $ra7
be.22793:
	add     $i1, 13, $i1
	load    [$i1 + $i19], $i1
	be      $i1, 0, be.22798
bne.22798:
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
be.22798:
	add     $i19, 1, $i19
	b       try_exploit_neighbors.2967
.end try_exploit_neighbors

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i3]
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
	call    ext_int_of_float
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      255, $i2
	bg      $i1, $i2, bg.22801
ble.22801:
	bge     $i1, 0, bge.22802
bl.22802:
	li      0, $i2
	b       ext_write
bge.22802:
.count move_args
	mov     $i1, $i2
	b       ext_write
bg.22801:
	li      255, $i2
	b       ext_write
.end write_rgb_element

######################################################################
# write_rgb()
# $ra = $ra
# [$i1 - $i3]
# [$f2 - $f3]
# []
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
# [$ig2, $ig4]
# []
# [$fg0 - $fg3, $fg7 - $fg11, $fg14, $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i19, 4, bg.22805
ble.22805:
	add     $i18, 8, $i20
	load    [$i20 + $i19], $i1
	bl      $i1, 0, bg.22805
bge.22806:
	add     $i18, 13, $i21
	load    [$i21 + $i19], $i1
	bne     $i1, 0, bne.22807
be.22807:
	add     $i19, 1, $i22
	bg      $i22, 4, bg.22805
ble.22808:
	load    [$i20 + $i22], $i1
	bl      $i1, 0, bg.22805
bge.22809:
	load    [$i21 + $i22], $i1
	be      $i1, 0, be.22815
bne.22810:
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
	ble     $f0, $f1, ble.22811
bg.22811:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
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
ble.22811:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
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
bne.22807:
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
	ble     $f0, $f1, ble.22812
bg.22812:
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
	ble     $i25, 4, ble.22813
.count dual_jmp
	b       bg.22805
ble.22812:
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
	bg      $i25, 4, bg.22805
ble.22813:
	load    [$i20 + $i25], $i1
	bl      $i1, 0, bg.22805
bge.22814:
	load    [$i21 + $i25], $i1
	be      $i1, 0, be.22815
bne.22815:
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
	ble     $f0, $f1, ble.22816
bg.22816:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i24 + $i25], $i1
	add     $i19, 2, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
ble.22816:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i24 + $i25], $i1
	add     $i19, 2, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	b       pretrace_diffuse_rays.2980
be.22815:
	add     $i19, 2, $i19
	b       pretrace_diffuse_rays.2980
bg.22805:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i26, $i27, $i28, $f20, $f21, $f1)
# $ra = $ra7
# [$i1 - $i25, $i27 - $i28]
# [$f1 - $f19]
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra6]
######################################################################
.align 2
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i27, 0, bl.22817
bge.22817:
.count stack_move
	add     $sp, -1, $sp
	add     $i27, -64, $i2
.count stack_store
	store   $f1, [$sp + 0]
	call    ext_float_of_int
	mov     $fig7, $f2
	mov     $fig8, $f3
	fmul    $f1, $f2, $f2
	fmul    $f1, $f3, $f1
.count stack_load
	load    [$sp + 0], $f3
.count move_args
	mov     $f0, $f19
	li      ext_ptrace_dirvec, $i16
.count move_args
	mov     $fc0, $f18
	li      0, $i18
	fadd    $f2, $f20, $f2
	mov     $fig6, $fg19
	fadd    $f1, $f3, $f1
	store   $f2, [ext_ptrace_dirvec + 0]
	store   $f21, [ext_ptrace_dirvec + 1]
	mov     $f0, $fg6
	store   $f1, [ext_ptrace_dirvec + 2]
	mov     $f0, $fg5
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_ptrace_dirvec + 0], $f3
	fmul    $f3, $f3, $f4
	mov     $fig5, $fg18
	fadd    $f4, $f2, $f2
	mov     $fig4, $fg17
	mov     $f0, $fg4
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	be      $f1, $f0, be.22819
bne.22819:
	finv    $f1, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
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
	bge     $i1, 0, bge.22820
.count dual_jmp
	b       bl.22820
be.22819:
	mov     $fc0, $f1
	fmul    $f3, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
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
	bge     $i1, 0, bge.22820
bl.22820:
.count stack_move
	add     $sp, 1, $sp
	add     $i28, 1, $i1
	bge     $i1, 5, bge.22824
.count dual_jmp
	b       bl.22824
bge.22820:
	load    [$i18 + 13], $i1
	bne     $i1, 0, bne.22821
be.22821:
	li      1, $i19
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 1, $sp
	add     $i28, 1, $i1
	bge     $i1, 5, bge.22824
.count dual_jmp
	b       bl.22824
bne.22821:
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
	load    [$i16 + 2], $f1
	load    [$i16 + 1], $f2
	load    [$i1 + 2], $f3
	load    [$i1 + 1], $f4
	fmul    $f3, $f1, $f1
	load    [$i16 + 0], $f5
	fmul    $f4, $f2, $f2
	load    [$i1 + 0], $f6
	fmul    $f6, $f5, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	ble     $f0, $f1, ble.22822
bg.22822:
	load    [$i15 + 119], $i8
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i18 + 23], $i1
	li      1, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 1, $sp
	add     $i28, 1, $i1
	bge     $i1, 5, bge.22824
.count dual_jmp
	b       bl.22824
ble.22822:
	load    [$i15 + 118], $i8
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i17
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i18 + 23], $i1
	li      1, $i19
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 1, $sp
	add     $i28, 1, $i1
	bge     $i1, 5, bge.22824
bl.22824:
	add     $i27, -1, $i27
.count stack_load
	load    [$sp - 1], $f1
.count move_args
	mov     $i1, $i28
	b       pretrace_pixels.2983
bge.22824:
	add     $i28, -4, $i28
.count stack_load
	load    [$sp - 1], $f1
	add     $i27, -1, $i27
	b       pretrace_pixels.2983
bl.22817:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i24, $i25, $i26, $i27, $i28)
# $ra = $ra8
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra7]
######################################################################
.align 2
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	ble     $i1, $i24, ble.22825
bg.22825:
	load    [$i27 + $i24], $i1
	add     $i25, 1, $i2
	li      128, $i3
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	ble     $i3, $i2, ble.22828
bg.22826:
	ble     $i25, 0, ble.22828
bg.22827:
	li      128, $i1
	add     $i24, 1, $i2
	ble     $i1, $i2, ble.22828
bg.22828:
	li      0, $i19
	ble     $i24, 0, bne.22834
bg.22829:
	load    [$i27 + $i24], $i1
	load    [$i1 + 8], $i2
	bl      $i2, 0, bl.22833
bge.22833:
	load    [$i26 + $i24], $i3
	load    [$i3 + 8], $i4
	bne     $i4, $i2, bne.22834
be.22834:
	load    [$i28 + $i24], $i4
	load    [$i4 + 8], $i4
	bne     $i4, $i2, bne.22834
be.22835:
	add     $i24, -1, $i4
	load    [$i27 + $i4], $i4
	load    [$i4 + 8], $i4
	bne     $i4, $i2, bne.22834
be.22836:
	add     $i24, 1, $i4
	load    [$i27 + $i4], $i4
	load    [$i4 + 8], $i4
	be      $i4, $i2, be.22837
bne.22834:
	load    [$i27 + $i24], $i18
	load    [$i18 + 8], $i1
	bge     $i1, 0, bge.22839
.count dual_jmp
	b       bl.22833
be.22837:
	load    [$i1 + 13], $i1
.count move_args
	mov     $i28, $i5
.count move_args
	mov     $i27, $i4
	li      1, $i19
	be      $i1, 0, be.22841
bne.22841:
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
be.22841:
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
ble.22828:
	load    [$i27 + $i24], $i18
	li      0, $i19
	load    [$i18 + 8], $i1
	bl      $i1, 0, bl.22833
bge.22839:
	load    [$i18 + 13], $i1
	be      $i1, 0, be.22840
bne.22840:
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i22
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
be.22840:
	li      1, $i22
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
bl.22833:
	call    write_rgb.2978
	add     $i24, 1, $i24
	b       scan_pixel.2994
ble.22825:
	jr      $ra8
.end scan_pixel

######################################################################
# scan_line($i29, $i30, $i31, $i1, $i2)
# $ra = $ra9
# [$i1 - $i31]
# [$f1 - $f21]
# [$ig2, $ig4]
# []
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra8]
######################################################################
.align 2
.begin scan_line
scan_line.3000:
	li      128, $i3
	ble     $i3, $i29, ble.22842
bg.22842:
.count stack_move
	add     $sp, -2, $sp
.count stack_store
	store   $i2, [$sp + 0]
.count stack_store
	store   $i1, [$sp + 1]
	bge     $i29, 127, bge.22844
bl.22844:
	add     $i29, -63, $i2
	call    ext_float_of_int
	mov     $fig3, $f2
	fmul    $f1, $f2, $f2
	mov     $fig0, $f3
	fadd    $f2, $f3, $f20
	mov     $fig2, $f4
	fmul    $f1, $f4, $f4
	mov     $fig1, $f5
	fmul    $f1, $f5, $f1
	li      127, $i27
.count stack_load
	load    [$sp + 0], $i28
	fadd    $f4, $fg21, $f21
.count move_args
	mov     $i1, $i26
	fadd    $f1, $fg20, $f1
	jal     pretrace_pixels.2983, $ra7
	li      0, $i24
.count stack_load
	load    [$sp + 1], $i28
.count move_args
	mov     $i29, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
	jal     scan_pixel.2994, $ra8
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 2, $i2
	bge     $i2, 5, bge.22846
.count dual_jmp
	b       bl.22846
bge.22844:
	li      0, $i24
.count stack_load
	load    [$sp + 1], $i28
.count move_args
	mov     $i29, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
	jal     scan_pixel.2994, $ra8
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 2, $i2
	bge     $i2, 5, bge.22846
bl.22846:
	add     $i29, 1, $i29
.count move_args
	mov     $i30, $i1
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $i28, $i31
	b       scan_line.3000
bge.22846:
	add     $i1, -3, $i2
	add     $i29, 1, $i29
.count move_args
	mov     $i30, $i1
.count move_args
	mov     $i31, $i30
.count move_args
	mov     $i28, $i31
	b       scan_line.3000
ble.22842:
	jr      $ra9
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
	li      0, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      0, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	jal     create_float5x3array.3006, $ra1
.count move_ret
	mov     $i1, $i9
	jal     create_float5x3array.3006, $ra1
.count move_ret
	mov     $i1, $i10
	li      0, $i3
	li      1, $i2
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
	bge     $i13, 0, bge.22847
bl.22847:
	mov     $i12, $i1
	jr      $ra3
bge.22847:
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
	bge     $i2, 5, bge.22848
bl.22848:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc7, $f1
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
	fadd    $f1, $fc7, $f1
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
bge.22848:
	load    [ext_dirvecs + $i3], $i1
	fmul    $f2, $f2, $f3
	fmul    $f1, $f1, $f4
	load    [$i1 + $i4], $i2
	add     $i4, 40, $i3
	fadd    $f4, $f3, $f3
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
# [$f1 - $f9, $f11 - $f15]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i8, 0, bl.22849
bge.22849:
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f15
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
	fsub    $f15, $fc8, $f9
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
	add     $i10, 2, $i11
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i8, -1, $i8
	bl      $i8, 0, bl.22849
bge.22850:
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f15
	li      0, $i2
.count move_args
	mov     $f0, $f2
	add     $i9, 1, $i1
	fsub    $f15, $fc8, $f9
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f1
	bge     $i1, 5, bge.22851
bl.22851:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
	li      0, $i2
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
	bge     $i8, 0, bge.22852
.count dual_jmp
	b       bl.22849
bge.22851:
	add     $i9, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
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
	bl      $i8, 0, bl.22849
bge.22852:
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f15
	add     $i9, 1, $i1
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f1
	li      0, $i2
	fsub    $f15, $fc8, $f9
	bge     $i1, 5, bge.22853
bl.22853:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
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
	bge     $i8, 0, bge.22854
.count dual_jmp
	b       bl.22849
bge.22853:
	add     $i9, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
	li      0, $i2
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
	bl      $i8, 0, bl.22849
bge.22854:
.count move_args
	mov     $i8, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f15
	add     $i9, 1, $i1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i10, $i4
.count move_args
	mov     $f0, $f1
	fsub    $f15, $fc8, $f9
	li      0, $i2
	bge     $i1, 5, bge.22855
bl.22855:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
	li      0, $i2
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
	bge     $i1, 5, bge.22856
.count dual_jmp
	b       bl.22856
bge.22855:
	add     $i9, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc7, $f9
	li      0, $i2
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
	bge     $i1, 5, bge.22856
bl.22856:
.count move_args
	mov     $i1, $i9
	b       calc_dirvecs.3028
bge.22856:
	add     $i9, -4, $i9
	b       calc_dirvecs.3028
bl.22849:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i12, $i13, $i14)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f18]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i12, 0, bl.22857
bge.22857:
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f1
.count load_float
	load    [f.22134], $f16
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $f16, $f9
.count move_args
	mov     $i14, $i4
	fsub    $f1, $fc8, $f10
.count move_args
	mov     $f0, $f1
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	add     $i14, 2, $i8
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $fc8, $f9
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22135], $f17
	add     $i13, 1, $i1
.count move_args
	mov     $f17, $f9
.count move_args
	mov     $i14, $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f1
	li      0, $i2
	bge     $i1, 5, bge.22858
bl.22858:
	mov     $i1, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22136], $f18
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
.count move_args
	mov     $f18, $f9
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22137], $f9
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22859
.count dual_jmp
	b       bl.22859
bge.22858:
	add     $i13, -4, $i9
.count move_args
	mov     $i9, $i3
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22136], $f18
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f18, $f9
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.22137], $f9
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22859
bl.22859:
	mov     $i1, $i9
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i14, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc3, $f9
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22860
.count dual_jmp
	b       bl.22860
bge.22859:
	add     $i9, -4, $i9
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i14, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc3, $f9
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22860
bl.22860:
	mov     $i1, $i9
.count move_args
	mov     $i14, $i10
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	bge     $i12, 0, bge.22861
.count dual_jmp
	b       bl.22857
bge.22860:
	add     $i9, -4, $i9
.count move_args
	mov     $i14, $i10
	jal     calc_dirvecs.3028, $ra2
	add     $i12, -1, $i12
	bl      $i12, 0, bl.22857
bge.22861:
.count move_args
	mov     $i12, $i2
	call    ext_float_of_int
	fmul    $f1, $fc13, $f1
	add     $i14, 4, $i10
	add     $i13, 2, $i1
.count move_args
	mov     $f16, $f9
.count move_args
	mov     $i10, $i4
	fsub    $f1, $fc8, $f10
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $f0, $f1
	bge     $i1, 5, bge.22862
bl.22862:
	mov     $i1, $i13
.count move_args
	mov     $i13, $i3
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	add     $i14, 6, $i8
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $fc8, $f9
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i13, 1, $i1
	bge     $i1, 5, bge.22863
.count dual_jmp
	b       bl.22863
bge.22862:
	add     $i13, -3, $i13
.count move_args
	mov     $i13, $i3
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	add     $i14, 6, $i8
.count move_args
	mov     $f0, $f2
	li      0, $i2
.count move_args
	mov     $fc8, $f9
.count move_args
	mov     $i13, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i13, 1, $i1
	bge     $i1, 5, bge.22863
bl.22863:
	mov     $i1, $i9
	li      0, $i2
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f17, $f9
.count move_args
	mov     $i10, $i4
	jal     calc_dirvec.3020, $ra1
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f18, $f9
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22864
.count dual_jmp
	b       bl.22864
bge.22863:
	add     $i13, -4, $i9
.count move_args
	mov     $f0, $f1
	li      0, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f17, $f9
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
	mov     $f18, $f9
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i8
	add     $i9, 1, $i1
	bge     $i1, 5, bge.22864
bl.22864:
	mov     $i1, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i13, 2, $i1
	add     $i14, 8, $i14
	bge     $i1, 5, bge.22865
.count dual_jmp
	b       bl.22865
bge.22864:
	add     $i9, -4, $i9
	jal     calc_dirvecs.3028, $ra2
	add     $i13, 2, $i1
	add     $i14, 8, $i14
	bge     $i1, 5, bge.22865
bl.22865:
	add     $i12, -1, $i12
.count move_args
	mov     $i1, $i13
	b       calc_dirvec_rows.3033
bge.22865:
	add     $i13, -3, $i13
	add     $i12, -1, $i12
	b       calc_dirvec_rows.3033
bl.22857:
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
	bge     $i6, 0, bge.22866
bl.22866:
	jr      $ra2
bge.22866:
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
	bge     $i7, 0, bge.22867
bl.22867:
	jr      $ra3
bge.22867:
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
# [$f1 - $f9]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bge     $i9, 0, bge.22868
bl.22868:
	jr      $ra3
bge.22868:
	load    [$i8 + $i9], $i4
	jal     setup_dirvec_constants.2829, $ra2
	add     $i9, -1, $i9
	b       init_dirvec_constants.3044
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i10)
# $ra = $ra4
# [$i1 - $i10]
# [$f1 - $f9]
# []
# []
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin init_vecset_constants
init_vecset_constants.3047:
	bge     $i10, 0, bge.22869
bl.22869:
	jr      $ra4
bge.22869:
	li      119, $i9
	load    [ext_dirvecs + $i10], $i8
	jal     init_dirvec_constants.3044, $ra3
	add     $i10, -1, $i10
	b       init_vecset_constants.3047
.end init_vecset_constants

######################################################################
# add_reflection($i8, $i9, $f10, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i7]
# [$f1 - $f9]
# []
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
	store   $f10, [$i1 + 5]
	store   $i1, [ext_reflections + $i8]
	jr      $ra3
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i31]
# [$f1 - $f21]
# [$ig0 - $ig4]
# [$fig0 - $fig12]
# [$fg0 - $fg21]
# [$ra - $ra9]
######################################################################
.align 2
.begin main
ext_main:
.count stack_store_ra
	store   $ra, [$sp - 2]
.count stack_move
	add     $sp, -2, $sp
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
	load    [ext_light + 2], $fg12
	load    [ext_light + 1], $fg13
	load    [ext_texture_color + 2], $fg14
	load    [ext_light + 0], $fg15
	load    [ext_or_net + 0], $ig1
	load    [ext_texture_color + 0], $fg16
	load    [ext_intsec_rectside + 0], $ig2
	load    [ext_startp + 0], $fg17
	load    [ext_startp + 1], $fg18
	load    [ext_startp + 2], $fg19
	load    [ext_n_reflections + 0], $ig3
	load    [ext_intersected_object_id + 0], $ig4
	load    [ext_screenz_dir + 2], $fg20
	load    [ext_screenz_dir + 1], $fg21
	load    [ext_screenz_dir + 0], $fig0
	load    [ext_screeny_dir + 2], $fig1
	load    [ext_screeny_dir + 1], $fig2
	load    [ext_screeny_dir + 0], $fig3
	load    [ext_viewpoint + 0], $fig4
	load    [ext_viewpoint + 1], $fig5
	load    [ext_viewpoint + 2], $fig6
	load    [ext_screenx_dir + 0], $fig7
	load    [ext_screenx_dir + 2], $fig8
	load    [ext_screen + 0], $fig9
	load    [ext_screen + 1], $fig10
	load    [ext_screen + 2], $fig11
	load    [ext_beam + 0], $fig12
	load    [f.22035 + 0], $fc0
	load    [f.22060 + 0], $fc1
	load    [f.22059 + 0], $fc2
	load    [f.22036 + 0], $fc3
	load    [f.22039 + 0], $fc4
	load    [f.22033 + 0], $fc5
	load    [f.22049 + 0], $fc6
	load    [f.22048 + 0], $fc7
	load    [f.22132 + 0], $fc8
	load    [f.22055 + 0], $fc9
	load    [f.22054 + 0], $fc10
	load    [f.22038 + 0], $fc11
	load    [f.22034 + 0], $fc12
	load    [f.22133 + 0], $fc13
	load    [f.22045 + 0], $fc14
	load    [f.22041 + 0], $fc15
	load    [f.21990 + 0], $fc16
	load    [f.22159 + 0], $fc17
	load    [f.22158 + 0], $fc18
	load    [f.22157 + 0], $fc19
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i30
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i26
	jal     create_pixelline.3013, $ra3
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_float
	mov     $f1, $fig9
	call    ext_read_float
	mov     $f1, $fig10
	call    ext_read_float
	mov     $f1, $fig11
	call    ext_read_float
	fmul    $f1, $fc16, $f9
.count move_args
	mov     $f9, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f10
.count move_args
	mov     $f9, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	call    ext_read_float
	fmul    $f1, $fc16, $f11
.count move_args
	mov     $f11, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f12
.count move_args
	mov     $f11, $f2
	call    ext_sin
	fmul    $f10, $f1, $f2
	fmul    $f9, $fc18, $fg21
	mov     $f12, $fig7
	fmul    $f10, $f12, $f3
	fneg    $f1, $f4
	fmul    $f2, $fc19, $f2
	mov     $f4, $fig8
	fmul    $f3, $fc19, $fg20
	mov     $f2, $fig0
	fneg    $f9, $f3
	fneg    $f10, $f4
	fmul    $f3, $f12, $f2
	mov     $f4, $fig2
	fmul    $f3, $f1, $f1
	mov     $fig9, $f3
	mov     $fig0, $f4
	mov     $f2, $fig1
	mov     $f1, $fig3
	fsub    $f3, $f4, $f1
	mov     $fig10, $f2
	fsub    $f2, $fg21, $f2
	mov     $fig11, $f3
	fsub    $f3, $fg20, $f3
	mov     $f1, $fig4
	mov     $f2, $fig5
	mov     $f3, $fig6
	call    ext_read_int
	call    ext_read_float
	fmul    $f1, $fc16, $f9
.count move_args
	mov     $f9, $f2
	call    ext_sin
	fneg    $f1, $fg13
	call    ext_read_float
.count move_ret
	mov     $f1, $f10
.count move_args
	mov     $f9, $f2
	call    ext_cos
	fmul    $f10, $fc16, $f10
.count move_ret
	mov     $f1, $f9
.count move_args
	mov     $f10, $f2
	call    ext_sin
	fmul    $f9, $f1, $fg15
.count move_args
	mov     $f10, $f2
	call    ext_cos
	fmul    $f9, $f1, $fg12
	call    ext_read_float
	mov     $f1, $fig12
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
	li      4, $i8
.count move_args
	mov     $fc8, $f10
	li      0, $i9
	li      0, $i10
	jal     calc_dirvecs.3028, $ra2
	li      4, $i14
	li      2, $i13
	li      8, $i12
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i10
	jal     init_vecset_constants.3047, $ra4
	store   $fg15, [%{ext_light_dirvec + 0} + 0]
	li      ext_light_dirvec, $i4
	store   $fg13, [%{ext_light_dirvec + 0} + 1]
	store   $fg12, [%{ext_light_dirvec + 0} + 2]
	jal     setup_dirvec_constants.2829, $ra2
	add     $ig0, -1, $i1
	bl      $i1, 0, bl.22871
bge.22871:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.22871
be.22872:
	load    [$i2 + 11], $f1
	ble     $fc0, $f1, bl.22871
bg.22873:
	load    [$i2 + 1], $i3
	be      $i3, 1, be.22874
bne.22874:
	be      $i3, 2, be.22875
bl.22871:
	mov     $fig1, $f1
	fmul    $fc17, $f1, $f1
	mov     $fig2, $f2
	fmul    $fc17, $f2, $f2
	mov     $fig3, $f3
	fmul    $fc17, $f3, $f3
	fadd    $f1, $fg20, $f1
	mov     $fig0, $f4
	li      0, $i28
	fadd    $f2, $fg21, $f21
	fadd    $f3, $f4, $f20
	li      127, $i27
	jal     pretrace_pixels.2983, $ra7
.count stack_load
	load    [$sp + 1], $i1
	li      2, $i2
	li      0, $i29
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	li      0, $i1
	ret     
be.22875:
	add     $i1, $i1, $i1
	fsub    $fc0, $f1, $f10
	add     $i1, $i1, $i1
	load    [$i2 + 6], $f1
	add     $i1, 1, $i9
	load    [$i2 + 5], $f2
	load    [$i2 + 4], $f3
	fmul    $fg12, $f1, $f4
	fmul    $fg13, $f2, $f5
.count move_args
	mov     $ig3, $i8
	fmul    $fg15, $f3, $f6
	fmul    $fc5, $f1, $f1
	fmul    $fc5, $f2, $f2
	fmul    $fc5, $f3, $f3
	fadd    $f6, $f5, $f5
	fadd    $f5, $f4, $f4
	fmul    $f2, $f4, $f2
	fmul    $f1, $f4, $f1
	fmul    $f3, $f4, $f3
	fsub    $f2, $fg13, $f2
	fsub    $f1, $fg12, $f4
	fsub    $f3, $fg15, $f1
.count move_args
	mov     $f2, $f3
	jal     add_reflection.3051, $ra3
	add     $ig3, 1, $ig3
	mov     $fig1, $f1
	fmul    $fc17, $f1, $f1
	mov     $fig2, $f2
	mov     $fig3, $f3
	fmul    $fc17, $f2, $f2
	fmul    $fc17, $f3, $f3
	mov     $fig0, $f4
	fadd    $f1, $fg20, $f1
	li      0, $i28
	fadd    $f2, $fg21, $f21
	li      127, $i27
	fadd    $f3, $f4, $f20
	jal     pretrace_pixels.2983, $ra7
	li      2, $i2
.count stack_load
	load    [$sp + 1], $i1
	li      0, $i29
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	li      0, $i1
	ret     
be.22874:
	add     $i1, $i1, $i1
	load    [$i2 + 11], $f1
	add     $i1, $i1, $i10
	fneg    $fg12, $f11
	add     $i10, 1, $i9
	fneg    $fg13, $f12
.count move_args
	mov     $ig3, $i8
	fsub    $fc0, $f1, $f10
.count move_args
	mov     $fg15, $f1
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
	fneg    $fg15, $f13
	add     $i10, 2, $i9
.count move_args
	mov     $f13, $f1
	add     $ig3, 1, $i8
.count move_args
	mov     $fg13, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
	add     $i10, 3, $i9
.count move_args
	mov     $f13, $f1
	add     $ig3, 2, $i8
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $fg12, $f4
	jal     add_reflection.3051, $ra3
	add     $ig3, 3, $ig3
	mov     $fig1, $f1
	fmul    $fc17, $f1, $f1
	mov     $fig2, $f2
	mov     $fig3, $f3
	fmul    $fc17, $f2, $f2
	fmul    $fc17, $f3, $f3
	mov     $fig0, $f4
	fadd    $f1, $fg20, $f1
	li      0, $i28
	fadd    $f2, $fg21, $f21
	li      127, $i27
	fadd    $f3, $f4, $f20
	jal     pretrace_pixels.2983, $ra7
	li      2, $i2
.count stack_load
	load    [$sp + 1], $i1
	li      0, $i29
.count move_args
	mov     $i26, $i31
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	li      0, $i1
	ret     
.end main
