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
######################################################################
#
# 		↓　ここから debug.s
#
######################################################################

ext_read:
	li 255, $i2
read_loop:
	read $i1
	bg $i1, $i2, ext_read
	ret

ext_ledout:
	ledout $i2, $tmp
	ret

ext_ledout_float:
	mov $f2, $i2
	ledout $i2, $tmp
	ret

ext_break:
	break
	ret

######################################################################
#
# 		↑　ここまで debug.s
#
######################################################################
.define $ig0 $i48
.define $i48 orz
.define $ig1 $i49
.define $i49 orz
.define $ig2 $i50
.define $i50 orz
.define $ig3 $i51
.define $i51 orz
.define $ig4 $i52
.define $i52 orz
.define $fg0 $f32
.define $f32 orz
.define $fg1 $f33
.define $f33 orz
.define $fg2 $f34
.define $f34 orz
.define $fg3 $f35
.define $f35 orz
.define $fg4 $f36
.define $f36 orz
.define $fg5 $f37
.define $f37 orz
.define $fg6 $f38
.define $f38 orz
.define $fg7 $f39
.define $f39 orz
.define $fg8 $f40
.define $f40 orz
.define $fg9 $f41
.define $f41 orz
.define $fg10 $f42
.define $f42 orz
.define $fg11 $f43
.define $f43 orz
.define $fg12 $f44
.define $f44 orz
.define $fg13 $f45
.define $f45 orz
.define $fg14 $f46
.define $f46 orz
.define $fg15 $f47
.define $f47 orz
.define $fg16 $f48
.define $f48 orz
.define $fc0 $f49
.define $f49 orz
.define $fc1 $f50
.define $f50 orz
.define $fc2 $f51
.define $f51 orz
.define $fc3 $f52
.define $f52 orz
.define $fc4 $f53
.define $f53 orz
.define $fc5 $f54
.define $f54 orz
.define $fc6 $f55
.define $f55 orz
.define $fc7 $f56
.define $f56 orz
.define $fc8 $f57
.define $f57 orz
.define $fc9 $f58
.define $f58 orz
.define $fc10 $f59
.define $f59 orz
.define $fc11 $f60
.define $f60 orz
.define $fc12 $f61
.define $f61 orz
.define $fc13 $f62
.define $f62 orz
.define $fc14 $f63
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

######################################################################
# $i1 = f()
# $ra = $ra
# [$i1]
# []
# []
# []
# []
######################################################################
.align 2
.begin f
f.11:
	b       f.11
.end f

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1]
# []
# []
# []
# []
######################################################################
.align 2
.begin main
ext_main:
	b       f.11
.end main
