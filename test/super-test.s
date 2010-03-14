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
f._164:	.float  6.2831853072E+00
f._163:	.float  3.1415926536E+00
f._162:	.float  1.5707963268E+00
f._161:	.float  6.0725293501E-01
f._160:	.float  1.0000000000E+00
f._159:	.float  5.0000000000E-01

######################################################################
# $f1 = cordic_atan_rec($i2, $f2, $f3, $f4, $f5)
# $ra = $ra
# [$i2]
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
	fmul    $f5, $f3, $f1
	bg      $f3, $f0, bg._166
ble._166:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fsub    $f4, $f2, $f4
.count load_float
	load    [f._159], $f2
	fmul    $f5, $f2, $f5
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f2
	b       ext_cordic_atan_rec
bg._166:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fadd    $f4, $f2, $f4
.count load_float
	load    [f._159], $f2
	fmul    $f5, $f2, $f5
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f2
	b       ext_cordic_atan_rec
.end cordic_atan_rec

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f5]
# []
# []
# []
######################################################################
.begin atan
ext_atan:
.count load_float
	load    [f._160], $f5
	li      0, $i2
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f0, $f4
.count move_args
	mov     $f5, $f2
	b       ext_cordic_atan_rec
.end atan

######################################################################
# $f1 = cordic_sin_rec($f2, $i2, $f3, $f4, $f5, $f6)
# $ra = $ra
# [$i2]
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
	add     $i2, 1, $i2
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
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f3
	b       ext_cordic_sin_rec
.end cordic_sin_rec

######################################################################
# $f1 = cordic_sin($f2)
# $ra = $ra
# [$i2]
# [$f1, $f3 - $f6]
# []
# []
# []
######################################################################
.begin cordic_sin
ext_cordic_sin:
.count load_float
	load    [f._161], $f3
.count load_float
	load    [f._160], $f6
	li      0, $i2
.count move_args
	mov     $f0, $f4
.count move_args
	mov     $f0, $f5
	b       ext_cordic_sin_rec
.end cordic_sin

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.begin sin
ext_sin:
	bg      $f0, $f2, bg._169
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
	fsub    $f2, $f1, $f2
	b       ext_sin
bg._172:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	add     $sp, -1, $sp
	fsub    $f1, $f2, $f2
	call    ext_sin
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret     
bg._171:
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
# [$i2]
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
ext_a: .skip 96
ext_b: .skip 96
.define ext_write2 ext_write
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
.define $fg0 $f19
.define $f19 orz
.define $fg1 $f20
.define $f20 orz
.define $fg2 $f21
.define $f21 orz
.define $fg3 $f22
.define $f22 orz
.define $fg4 $f23
.define $f23 orz
.define $fg5 $f24
.define $f24 orz
.define $fg6 $f25
.define $f25 orz
.define $fg7 $f26
.define $f26 orz
.define $fg8 $f27
.define $f27 orz
.define $fg9 $f28
.define $f28 orz
.define $fg10 $f29
.define $f29 orz
.define $fg11 $f30
.define $f30 orz
.define $fg12 $f31
.define $f31 orz
.define $fg13 $f32
.define $f32 orz
.define $fg14 $f33
.define $f33 orz
.define $fg15 $f34
.define $f34 orz
.define $fg16 $f35
.define $f35 orz
.define $fg17 $f36
.define $f36 orz
.define $fg18 $f37
.define $f37 orz
.define $fg19 $f38
.define $f38 orz
.define $fg20 $f39
.define $f39 orz
.define $fg21 $f40
.define $f40 orz
.define $fg22 $f41
.define $f41 orz
.define $fg23 $f42
.define $f42 orz
.define $fg24 $f43
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
f.6163:	.float  1.0000000000E+02
f.6162:	.float  1.0416666667E-02

######################################################################
# init($i4)
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
# [$ra]
######################################################################
.begin init
init.192:
	bne     $i4, 96, bne.8200
be.8200:
	jr      $ra1
bne.8200:
	li      96, $i2
	li      0, $i3
	call    ext_create_array_int
	store   $i1, [ext_a + $i4]
	li      96, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [ext_b + $i4]
	add     $i4, 1, $i4
	b       init.192
.end init

######################################################################
# read_rec($i1, $i2)
# $ra = $ra1
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin read_rec
read_rec.316.524:
	be      $i2, 96, be.8203
bne.8201:
	bne     $i1, 96, bne.8202
be.8202:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i2, 1, $i1
	bne     $i1, 96, bne.8203
be.8203:
	jr      $ra1
bne.8203:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i1, [$sp + 0]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8205:
	call    ext_read
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8207:
	call    ext_read
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8209:
	call    ext_read
	load    [ext_a + 3], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8211:
	call    ext_read
	load    [ext_a + 4], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8213:
	call    ext_read
	load    [ext_a + 5], $i2
.count stack_load
	load    [$sp + 0], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8215:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 6], $i2
.count stack_load
	load    [$sp - 9], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      7, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8202:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i1, [$sp + 2]
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [ext_a + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8219:
	add     $i2, 1, $i1
	bne     $i1, 96, bne.8221
be.8221:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8222:
.count stack_store
	store   $i1, [$sp + 3]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8224:
	call    ext_read
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8226:
	call    ext_read
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8228:
	call    ext_read
	load    [ext_a + 3], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8230:
	call    ext_read
	load    [ext_a + 4], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8232:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 5], $i2
.count stack_load
	load    [$sp - 6], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      6, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8221:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 1} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8235:
	add     $i2, 2, $i1
	bne     $i1, 96, bne.8237
be.8237:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8238:
.count stack_store
	store   $i1, [$sp + 4]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 4], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8240:
	call    ext_read
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 4], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8242:
	call    ext_read
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp + 4], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8244:
	call    ext_read
	load    [ext_a + 3], $i2
.count stack_load
	load    [$sp + 4], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8246:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 4], $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      5, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8237:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 2} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8249:
	add     $i2, 3, $i1
	bne     $i1, 96, bne.8251
be.8251:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8252:
.count stack_store
	store   $i1, [$sp + 5]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 5], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8254:
	call    ext_read
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 5], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8256:
	call    ext_read
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp + 5], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8258:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 3], $i2
.count stack_load
	load    [$sp - 4], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      4, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8251:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 3} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8261:
	add     $i2, 4, $i1
	bne     $i1, 96, bne.8263
be.8263:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8264:
.count stack_store
	store   $i1, [$sp + 6]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 6], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8266:
	call    ext_read
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 6], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8268:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp - 3], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      3, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8263:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 4} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8271:
	add     $i2, 5, $i1
	bne     $i1, 96, bne.8273
be.8273:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8274:
.count stack_store
	store   $i1, [$sp + 7]
	call    ext_read
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 7], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	be      $i3, 96, be.8285
bne.8276:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp - 2], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      2, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8273:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 5} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	be      $i4, 96, be.8285
bne.8279:
	add     $i2, 6, $i1
	bne     $i1, 96, bne.8281
be.8281:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i4, 1, $i1
	be      $i1, 96, be.8285
bne.8282:
.count stack_store
	store   $i1, [$sp + 8]
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp - 1], $i3
.count storer
	add     $i2, $i3, $tmp
	store   $i1, [$tmp + 0]
	li      1, $i1
.count move_args
	mov     $i3, $i2
	b       read_rec.316.524
bne.8281:
	call    ext_read
.count stack_load
	load    [$sp + 2], $i2
	load    [%{ext_a + 6} + $i2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	bne     $i4, 96, bne.8285
be.8285:
.count stack_move
	add     $sp, 9, $sp
	jr      $ra1
bne.8285:
	add     $i2, 7, $i1
	bne     $i1, 96, bne.8287
be.8287:
.count stack_move
	add     $sp, 9, $sp
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	li      0, $i1
	add     $i4, 1, $i2
	b       read_rec.316.524
bne.8287:
	call    ext_read
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i2
	load    [%{ext_a + 7} + $i2], $i3
.count stack_load
	load    [$sp - 8], $i4
.count storer
	add     $i3, $i4, $tmp
	store   $i1, [$tmp + 0]
	add     $i2, 8, $i1
.count move_args
	mov     $i4, $i2
	b       read_rec.316.524
.end read_rec

######################################################################
# write2_rec($i1, $i2)
# $ra = $ra1
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin write2_rec
write2_rec.320.530:
	be      $i2, 96, be.8292
bne.8290:
	bne     $i1, 96, bne.8291
be.8291:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i2, 1, $i1
	bne     $i1, 96, bne.8292
be.8292:
	jr      $ra1
bne.8292:
.count stack_move
	add     $sp, -16, $sp
.count stack_store
	store   $i1, [$sp + 0]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8294:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 1, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8296:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 3], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 2, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8298:
	load    [ext_a + 3], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 4], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 3, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8300:
	load    [ext_a + 4], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 5], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 4, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8302:
	load    [ext_a + 5], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 6], $i1
.count stack_load
	load    [$sp + 0], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 5, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8304:
	load    [ext_a + 6], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      7, $i1
	load    [ext_a + 7], $i2
.count stack_load
	load    [$sp - 16], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 6, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8291:
.count stack_move
	add     $sp, -16, $sp
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i1, [$sp + 2]
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 1, $i2
	bl      $i2, 96, bl.8308
bge.8308:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8309
bl.8308:
	load    [%{ext_a + 1} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
	add     $i5, $i1, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8309:
	bne     $i2, 96, bne.8311
be.8311:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8312:
.count stack_store
	store   $i1, [$sp + 3]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 3], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8314:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 3], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 1, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8316:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 3], $i1
.count stack_load
	load    [$sp + 3], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 2, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8318:
	load    [ext_a + 3], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 4], $i1
.count stack_load
	load    [$sp + 3], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 3, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8320:
	load    [ext_a + 4], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 5], $i1
.count stack_load
	load    [$sp + 3], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 4, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8322:
	load    [ext_a + 5], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      6, $i1
	load    [ext_a + 6], $i2
.count stack_load
	load    [$sp - 13], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 5, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8311:
.count stack_store
	store   $i2, [$sp + 4]
	load    [%{ext_a + 1} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 2, $i2
	bl      $i2, 96, bl.8325
bge.8325:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8326
bl.8325:
	load    [%{ext_a + 2} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 4], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8326:
	bne     $i2, 96, bne.8328
be.8328:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8329:
.count stack_store
	store   $i1, [$sp + 5]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 5], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8331:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 5], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 1, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8333:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 3], $i1
.count stack_load
	load    [$sp + 5], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 2, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8335:
	load    [ext_a + 3], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 4], $i1
.count stack_load
	load    [$sp + 5], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 3, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8337:
	load    [ext_a + 4], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      5, $i1
	load    [ext_a + 5], $i2
.count stack_load
	load    [$sp - 11], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 4, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8328:
.count stack_store
	store   $i2, [$sp + 6]
	load    [%{ext_a + 2} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 3, $i2
	bl      $i2, 96, bl.8340
bge.8340:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8341
bl.8340:
	load    [%{ext_a + 3} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 6], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8341:
	bne     $i2, 96, bne.8343
be.8343:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8344:
.count stack_store
	store   $i1, [$sp + 7]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 7], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8346:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 7], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 1, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8348:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 3], $i1
.count stack_load
	load    [$sp + 7], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 2, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8350:
	load    [ext_a + 3], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      4, $i1
	load    [ext_a + 4], $i2
.count stack_load
	load    [$sp - 9], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 3, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8343:
.count stack_store
	store   $i2, [$sp + 8]
	load    [%{ext_a + 3} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 4, $i2
	bl      $i2, 96, bl.8353
bge.8353:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8354
bl.8353:
	load    [%{ext_a + 4} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 8], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8354:
	bne     $i2, 96, bne.8356
be.8356:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8357:
.count stack_store
	store   $i1, [$sp + 9]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 9], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8359:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 9], $i2
	load    [$i1 + $i2], $i3
	add     $i3, 1, $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8361:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      3, $i1
	load    [ext_a + 3], $i2
.count stack_load
	load    [$sp - 7], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 2, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8356:
.count stack_store
	store   $i2, [$sp + 10]
	load    [%{ext_a + 4} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 5, $i2
	bl      $i2, 96, bl.8364
bge.8364:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8365
bl.8364:
	load    [%{ext_a + 5} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 10], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8365:
	bne     $i2, 96, bne.8367
be.8367:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8368:
.count stack_store
	store   $i1, [$sp + 11]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 11], $i2
	load    [$i1 + $i2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8381
bne.8370:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      2, $i1
	load    [ext_a + 2], $i2
.count stack_load
	load    [$sp - 5], $i3
	load    [$i2 + $i3], $i4
	add     $i4, 1, $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8367:
.count stack_store
	store   $i2, [$sp + 12]
	load    [%{ext_a + 5} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 6, $i2
	bl      $i2, 96, bl.8373
bge.8373:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8374
bl.8373:
	load    [%{ext_a + 6} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 12], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
bne.8374:
	bne     $i2, 96, bne.8376
be.8376:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8381
bne.8377:
.count stack_store
	store   $i1, [$sp + 13]
	load    [ext_a + 0], $i2
	load    [$i2 + $i1], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
	li      1, $i1
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp - 3], $i3
	load    [$i2 + $i3], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
.count move_args
	mov     $i3, $i2
	b       write2_rec.320.530
bne.8376:
.count stack_store
	store   $i2, [$sp + 14]
	load    [%{ext_a + 6} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 7, $i2
	bl      $i2, 96, bl.8380
bge.8380:
.count stack_load
	load    [$sp + 1], $i3
	be      $i3, 96, be.8381
.count dual_jmp
	b       bne.8381
bl.8380:
	load    [%{ext_a + 7} + $i1], $i3
.count stack_load
	load    [$sp + 1], $i4
	load    [$i3 + $i4], $i5
.count stack_load
	load    [$sp + 14], $i6
	add     $i5, $i6, $i5
.count storer
	add     $i3, $i4, $tmp
	store   $i5, [$tmp + 0]
.count stack_load
	load    [$sp + 1], $i3
	bne     $i3, 96, bne.8381
be.8381:
.count stack_move
	add     $sp, 16, $sp
	jr      $ra1
bne.8381:
	bne     $i2, 96, bne.8383
be.8383:
.count stack_move
	add     $sp, 16, $sp
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	li      0, $i1
	add     $i3, 1, $i2
	b       write2_rec.320.530
bne.8383:
.count stack_store
	store   $i2, [$sp + 15]
	load    [%{ext_a + 7} + $i1], $i1
	load    [$i1 + $i3], $i2
	call    ext_write2
.count stack_move
	add     $sp, 16, $sp
.count stack_load
	load    [$sp - 14], $i1
	add     $i1, 8, $i3
.count stack_load
	load    [$sp - 15], $i2
	bl      $i3, 96, bl.8386
bge.8386:
.count move_args
	mov     $i3, $i1
	b       write2_rec.320.530
bl.8386:
	load    [%{ext_a + 8} + $i1], $i1
	load    [$i1 + $i2], $i4
.count stack_load
	load    [$sp - 1], $i5
	add     $i4, $i5, $i4
.count storer
	add     $i1, $i2, $tmp
	store   $i4, [$tmp + 0]
.count stack_load
	load    [$sp - 15], $i2
.count move_args
	mov     $i3, $i1
	b       write2_rec.320.530
.end write2_rec

######################################################################
# itof_rec($i1, $i2)
# $ra = $ra1
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin itof_rec
itof_rec.274.477:
	be      $i2, 96, be.8389
bne.8387:
	bne     $i1, 96, bne.8388
be.8388:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i2, 1, $i1
	bne     $i1, 96, bne.8389
be.8389:
	jr      $ra1
bne.8389:
.count stack_move
	add     $sp, -15, $sp
.count stack_store
	store   $i1, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [ext_a + 0], $i5
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 95], $i2
	load    [$i2 + $i1], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	bne     $i1, 0, bne.8391
be.8391:
	li      95, $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8392
.count dual_jmp
	b       bg.8392
bne.8391:
.count stack_load
	load    [$sp + 1], $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8392
ble.8392:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 2]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 0], $i2
.count stack_load
	load    [$sp + 2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
.count dual_jmp
	b       bne.8393
bg.8392:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 2]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 0], $i2
.count stack_load
	load    [$sp + 2], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
bne.8393:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 0], $i3
	load    [$i2 + $i3], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 0], $i2
	bne     $i2, 0, bne.8395
be.8395:
	li      95, $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8396
.count dual_jmp
	b       bg.8396
bne.8395:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8396
ble.8396:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 3]
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 0], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
.count dual_jmp
	b       bne.8397
bg.8396:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 3]
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 0], $i2
.count stack_load
	load    [$sp + 3], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
bne.8397:
	load    [ext_a + 2], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 1], $i2
.count stack_load
	load    [$sp + 0], $i3
	load    [$i2 + $i3], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 0], $i2
	bne     $i2, 0, bne.8399
be.8399:
	li      95, $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8400
.count dual_jmp
	b       bg.8400
bne.8399:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8400
ble.8400:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 4]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp - 15], $i2
.count stack_load
	load    [$sp - 11], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      3, $i1
	b       itof_rec.274.477
bg.8400:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 4]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp - 15], $i2
.count stack_load
	load    [$sp - 11], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      3, $i1
	b       itof_rec.274.477
bne.8388:
.count stack_move
	add     $sp, -15, $sp
.count stack_store
	store   $i1, [$sp + 5]
.count stack_store
	store   $i2, [$sp + 1]
	load    [ext_a + $i1], $i5
	load    [$i5 + $i2], $i2
	call    ext_float_of_int
	mov     $f1, $f4
.count stack_load
	load    [$sp + 1], $i2
	bne     $i1, 0, bne.8403
be.8403:
	li      95, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	be      $i1, 0, be.8404
.count dual_jmp
	b       bne.8404
bne.8403:
	add     $i1, -1, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	bne     $i1, 0, bne.8404
be.8404:
	li      95, $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8405
.count dual_jmp
	b       bg.8405
bne.8404:
	add     $i1, -1, $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8405
ble.8405:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 6]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [ext_a + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 6], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	be      $i3, 96, be.8432
.count dual_jmp
	b       bne.8406
bg.8405:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 6]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [ext_a + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 6], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	be      $i3, 96, be.8432
bne.8406:
	add     $i1, 1, $i5
	bne     $i5, 96, bne.8408
be.8408:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8432
bne.8409:
.count stack_store
	store   $i1, [$sp + 7]
	load    [ext_a + 0], $i5
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 95], $i2
	load    [$i2 + $i1], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	bne     $i1, 0, bne.8411
be.8411:
	li      95, $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8412
.count dual_jmp
	b       bg.8412
bne.8411:
.count stack_load
	load    [$sp + 1], $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8412
ble.8412:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 8], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
.count dual_jmp
	b       bne.8413
bg.8412:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 8], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	be      $i2, 96, be.8432
bne.8413:
	load    [ext_a + 1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 0], $i2
.count stack_load
	load    [$sp + 7], $i3
	load    [$i2 + $i3], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 7], $i2
	bne     $i2, 0, bne.8415
be.8415:
	li      95, $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8416
.count dual_jmp
	b       bg.8416
bne.8415:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8416
ble.8416:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp - 8], $i2
.count stack_load
	load    [$sp - 6], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      2, $i1
	b       itof_rec.274.477
bg.8416:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp - 8], $i2
.count stack_load
	load    [$sp - 6], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      2, $i1
	b       itof_rec.274.477
bne.8408:
	load    [%{ext_a + 1} + $i1], $i6
	load    [$i6 + $i3], $i2
	call    ext_float_of_int
	mov     $f1, $f4
.count stack_load
	load    [$sp + 1], $i2
	bne     $i5, 0, bne.8418
be.8418:
	li      95, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	be      $i1, 0, be.8419
.count dual_jmp
	b       bne.8419
bne.8418:
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	bne     $i1, 0, bne.8419
be.8419:
	li      95, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8420
.count dual_jmp
	b       bg.8420
bne.8419:
	add     $i1, -1, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8420
ble.8420:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [%{ext_a + 1} + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 10], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	be      $i3, 96, be.8432
.count dual_jmp
	b       bne.8421
bg.8420:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [%{ext_a + 1} + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 10], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	be      $i3, 96, be.8432
bne.8421:
	add     $i1, 2, $i5
	bne     $i5, 96, bne.8423
be.8423:
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	add     $i3, 1, $i1
	be      $i1, 96, be.8432
bne.8424:
.count stack_store
	store   $i1, [$sp + 11]
	load    [ext_a + 0], $i5
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 95], $i2
	load    [$i2 + $i1], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	bne     $i1, 0, bne.8426
be.8426:
	li      95, $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8427
.count dual_jmp
	b       bg.8427
bne.8426:
.count stack_load
	load    [$sp + 1], $i1
	load    [$i5 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8427
ble.8427:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 12]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp - 4], $i2
.count stack_load
	load    [$sp - 3], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      1, $i1
	b       itof_rec.274.477
bg.8427:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 12]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp - 4], $i2
.count stack_load
	load    [$sp - 3], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	li      1, $i1
	b       itof_rec.274.477
bne.8423:
	load    [%{ext_a + 2} + $i1], $i6
	load    [$i6 + $i3], $i2
	call    ext_float_of_int
	mov     $f1, $f4
.count stack_load
	load    [$sp + 1], $i2
	bne     $i5, 0, bne.8429
be.8429:
	li      95, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	be      $i1, 0, be.8430
.count dual_jmp
	b       bne.8430
bne.8429:
	add     $i1, 1, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	bne     $i1, 0, bne.8430
be.8430:
	li      95, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8431
.count dual_jmp
	b       bg.8431
bne.8430:
	add     $i1, -1, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8431
ble.8431:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 13]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [%{ext_a + 2} + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 13], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	be      $i3, 96, be.8432
.count dual_jmp
	b       bne.8432
bg.8431:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 13]
	call    ext_write2
.count stack_load
	load    [$sp + 5], $i1
	load    [%{ext_a + 2} + $i1], $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 13], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	bne     $i3, 96, bne.8432
be.8432:
.count stack_move
	add     $sp, 15, $sp
	jr      $ra1
bne.8432:
	add     $i1, 3, $i5
	bne     $i5, 96, bne.8434
be.8434:
.count stack_move
	add     $sp, 15, $sp
	load    [ext_b + 0], $i1
	store   $f0, [$i1 + 0]
	li      0, $i1
	add     $i3, 1, $i2
	b       itof_rec.274.477
bne.8434:
	load    [%{ext_a + 3} + $i1], $i6
	load    [$i6 + $i3], $i2
	call    ext_float_of_int
	mov     $f1, $f4
.count stack_load
	load    [$sp + 1], $i2
	bne     $i5, 0, bne.8436
be.8436:
	li      95, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	be      $i1, 0, be.8437
.count dual_jmp
	b       bne.8437
bne.8436:
	add     $i1, 2, $i1
	load    [ext_a + $i1], $i1
	load    [$i1 + $i2], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
.count stack_load
	load    [$sp + 1], $i1
	bne     $i1, 0, bne.8437
be.8437:
	li      95, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8438
.count dual_jmp
	b       bg.8438
bne.8437:
	add     $i1, -1, $i1
	load    [$i6 + $i1], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8438
ble.8438:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 14]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 10], $i1
	load    [%{ext_a + 3} + $i1], $i2
.count stack_load
	load    [$sp - 14], $i3
.count stack_load
	load    [$sp - 1], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	add     $i1, 4, $i1
.count move_args
	mov     $i3, $i2
	b       itof_rec.274.477
bg.8438:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 14]
	call    ext_write2
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 10], $i1
	load    [%{ext_a + 3} + $i1], $i2
.count stack_load
	load    [$sp - 14], $i3
.count stack_load
	load    [$sp - 1], $i4
.count storer
	add     $i2, $i3, $tmp
	store   $i4, [$tmp + 0]
	add     $i1, 4, $i1
.count move_args
	mov     $i3, $i2
	b       itof_rec.274.477
.end itof_rec

######################################################################
# fpu_rec($i1)
# $ra = $ra1
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin fpu_rec
fpu_rec.259.457:
	bne     $i1, 96, bne.8440
be.8440:
	jr      $ra1
bne.8440:
.count stack_move
	add     $sp, -1, $sp
.count stack_store
	store   $i1, [$sp + 0]
.count move_args
	mov     $i1, $i2
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 1, $i2
	be      $i2, 96, be.8502
bne.8442:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 2, $i2
	be      $i2, 96, be.8502
bne.8444:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 3, $i2
	be      $i2, 96, be.8502
bne.8446:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 4, $i2
	be      $i2, 96, be.8502
bne.8448:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 5, $i2
	be      $i2, 96, be.8502
bne.8450:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 6, $i2
	be      $i2, 96, be.8502
bne.8452:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 7, $i2
	be      $i2, 96, be.8502
bne.8454:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 8, $i2
	be      $i2, 96, be.8502
bne.8456:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 9, $i2
	be      $i2, 96, be.8502
bne.8458:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 10, $i2
	be      $i2, 96, be.8502
bne.8460:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 11, $i2
	be      $i2, 96, be.8502
bne.8462:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 12, $i2
	be      $i2, 96, be.8502
bne.8464:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 13, $i2
	be      $i2, 96, be.8502
bne.8466:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 14, $i2
	be      $i2, 96, be.8502
bne.8468:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 15, $i2
	be      $i2, 96, be.8502
bne.8470:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 16, $i2
	be      $i2, 96, be.8502
bne.8472:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 17, $i2
	be      $i2, 96, be.8502
bne.8474:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 18, $i2
	be      $i2, 96, be.8502
bne.8476:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 19, $i2
	be      $i2, 96, be.8502
bne.8478:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 20, $i2
	be      $i2, 96, be.8502
bne.8480:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 21, $i2
	be      $i2, 96, be.8502
bne.8482:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 22, $i2
	be      $i2, 96, be.8502
bne.8484:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 23, $i2
	be      $i2, 96, be.8502
bne.8486:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 24, $i2
	be      $i2, 96, be.8502
bne.8488:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 25, $i2
	be      $i2, 96, be.8502
bne.8490:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 26, $i2
	be      $i2, 96, be.8502
bne.8492:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 27, $i2
	be      $i2, 96, be.8502
bne.8494:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 28, $i2
	be      $i2, 96, be.8502
bne.8496:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 29, $i2
	be      $i2, 96, be.8502
bne.8498:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 30, $i2
	be      $i2, 96, be.8502
bne.8500:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_load
	load    [$sp + 0], $i1
	add     $i1, 31, $i2
	bne     $i2, 96, bne.8502
be.8502:
.count stack_move
	add     $sp, 1, $sp
	jr      $ra1
bne.8502:
	call    ext_float_of_int
	fmul    $f1, $fc1, $f2
	call    ext_sin
	fmul    $f1, $fc0, $f2
	call    ext_int_of_float
	mov     $i1, $i2
	call    ext_write2
.count stack_move
	add     $sp, 1, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 32, $i1
	b       fpu_rec.259.457
.end fpu_rec

######################################################################
# $i1 = load_rec($i1, $i2, $i3)
# $ra = $ra1
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin load_rec
load_rec.222.415:
	be      $i2, 96, be.8561
bne.8505:
	bne     $i1, 96, bne.8506
be.8506:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8509
be.8509:
.count stack_load
	load    [$sp - 9], $i1
	jr      $ra1
bne.8509:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 9], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i7
	add     $i5, $i7, $i5
	be      $i2, 96, be.8555
bne.8510:
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8511:
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8512:
	load    [ext_a + 3], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8513:
	load    [ext_a + 4], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8514:
	load    [ext_a + 5], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8515:
	li      7, $i4
	load    [ext_a + 6], $i5
	load    [$i5 + $i2], $i5
	add     $i3, $i5, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i7, $i3
.count move_args
	mov     $i4, $i1
	b       load_rec.222.415
bne.8506:
	load    [ext_a + $i1], $i4
	load    [ext_a + 0], $i5
	load    [ext_a + 1], $i6
	load    [ext_a + 2], $i7
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	load    [$i5 + 0], $i4
	add     $i3, $i4, $i3
	load    [$i6 + 1], $i5
	add     $i3, $i5, $i3
	load    [$i7 + 2], $i6
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8516:
	add     $i1, 1, $i7
	bne     $i7, 96, bne.8517
be.8517:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8520
be.8520:
.count stack_load
	load    [$sp - 7], $i1
	jr      $ra1
bne.8520:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 7], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i7
	add     $i5, $i7, $i5
	be      $i2, 96, be.8555
bne.8521:
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8522:
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8523:
	load    [ext_a + 3], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8524:
	load    [ext_a + 4], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8525:
	li      6, $i4
	load    [ext_a + 5], $i5
	load    [$i5 + $i2], $i5
	add     $i3, $i5, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i7, $i3
.count move_args
	mov     $i4, $i1
	b       load_rec.222.415
bne.8517:
	load    [%{ext_a + 1} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8526:
	add     $i1, 2, $i7
	bne     $i7, 96, bne.8527
be.8527:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8530
be.8530:
.count stack_load
	load    [$sp - 6], $i1
	jr      $ra1
bne.8530:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 6], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i7
	add     $i5, $i7, $i5
	be      $i2, 96, be.8555
bne.8531:
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8532:
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8533:
	load    [ext_a + 3], $i4
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8534:
	li      5, $i4
	load    [ext_a + 4], $i5
	load    [$i5 + $i2], $i5
	add     $i3, $i5, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i7, $i3
.count move_args
	mov     $i4, $i1
	b       load_rec.222.415
bne.8527:
	load    [%{ext_a + 2} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8535:
	add     $i1, 3, $i7
	bne     $i7, 96, bne.8536
be.8536:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 4]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8539
be.8539:
.count stack_load
	load    [$sp - 5], $i1
	jr      $ra1
bne.8539:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 5], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i7
	add     $i5, $i7, $i5
	be      $i2, 96, be.8555
bne.8540:
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8541:
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8542:
	li      4, $i4
	load    [ext_a + 3], $i5
	load    [$i5 + $i2], $i5
	add     $i3, $i5, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i7, $i3
.count move_args
	mov     $i4, $i1
	b       load_rec.222.415
bne.8536:
	load    [%{ext_a + 3} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8543:
	add     $i1, 4, $i7
	bne     $i7, 96, bne.8544
be.8544:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 5]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8547
be.8547:
.count stack_load
	load    [$sp - 4], $i1
	jr      $ra1
bne.8547:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 4], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i7
	add     $i5, $i7, $i5
	be      $i2, 96, be.8555
bne.8548:
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i3
	add     $i3, $i6, $i3
	add     $i3, $i7, $i3
	be      $i2, 96, be.8561
bne.8549:
	li      3, $i5
	load    [$i4 + $i2], $i4
	add     $i3, $i4, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i7, $i3
.count move_args
	mov     $i5, $i1
	b       load_rec.222.415
bne.8544:
	load    [%{ext_a + 4} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8550:
	add     $i1, 5, $i7
	bne     $i7, 96, bne.8551
be.8551:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 6]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8554
be.8554:
.count stack_load
	load    [$sp - 3], $i1
	jr      $ra1
bne.8554:
	load    [ext_a + 0], $i1
	load    [ext_a + 1], $i3
	load    [ext_a + 2], $i4
	load    [$i1 + $i2], $i5
.count stack_load
	load    [$sp - 3], $i6
	add     $i6, $i5, $i5
	load    [$i1 + 0], $i1
	add     $i5, $i1, $i5
	load    [$i3 + 1], $i6
	add     $i5, $i6, $i5
	load    [$i4 + 2], $i4
	add     $i5, $i4, $i5
	bne     $i2, 96, bne.8555
be.8555:
	mov     $i5, $i1
	jr      $ra1
bne.8555:
	li      2, $i7
	load    [$i3 + $i2], $i3
	add     $i5, $i3, $i3
	add     $i3, $i1, $i1
	add     $i1, $i6, $i1
	add     $i1, $i4, $i3
.count move_args
	mov     $i7, $i1
	b       load_rec.222.415
bne.8551:
	load    [%{ext_a + 5} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	be      $i2, 96, be.8561
bne.8556:
	add     $i1, 6, $i7
	bne     $i7, 96, bne.8557
be.8557:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 7]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 1, $i2
	bne     $i2, 96, bne.8560
be.8560:
.count stack_load
	load    [$sp - 2], $i1
	jr      $ra1
bne.8560:
	li      1, $i1
	load    [ext_a + 0], $i3
	load    [$i3 + $i2], $i4
.count stack_load
	load    [$sp - 2], $i5
	add     $i5, $i4, $i4
	load    [$i3 + 0], $i3
	add     $i4, $i3, $i3
	load    [ext_a + 1], $i4
	load    [$i4 + 1], $i4
	add     $i3, $i4, $i3
	load    [ext_a + 2], $i4
	load    [$i4 + 2], $i4
	add     $i3, $i4, $i3
	b       load_rec.222.415
bne.8557:
	load    [%{ext_a + 6} + $i1], $i7
	load    [$i7 + $i2], $i7
	add     $i3, $i7, $i3
	add     $i3, $i4, $i3
	add     $i3, $i5, $i3
	add     $i3, $i6, $i3
	bne     $i2, 96, bne.8561
be.8561:
	mov     $i3, $i1
	jr      $ra1
bne.8561:
	add     $i1, 7, $i7
	bne     $i7, 96, bne.8562
be.8562:
.count stack_move
	add     $sp, -9, $sp
.count stack_store
	store   $i3, [$sp + 8]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i3, $i2
	call    ext_write2
.count stack_move
	add     $sp, 9, $sp
	li      0, $i1
.count stack_load
	load    [$sp - 8], $i2
	add     $i2, 1, $i2
.count stack_load
	load    [$sp - 1], $i3
	b       load_rec.222.415
bne.8562:
	add     $i1, 8, $i7
	load    [%{ext_a + 7} + $i1], $i1
	load    [$i1 + $i2], $i1
	add     $i3, $i1, $i1
	add     $i1, $i4, $i1
	add     $i1, $i5, $i1
	add     $i1, $i6, $i3
.count move_args
	mov     $i7, $i1
	b       load_rec.222.415
.end load_rec

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i45]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin main
ext_main:
.count stack_store_ra
	store   $ra, [$sp - 7]
.count stack_move
	add     $sp, -7, $sp
	load    [f.6163 + 0], $fc0
	load    [f.6162 + 0], $fc1
	li      0, $i4
	jal     init.192, $ra1
	call    ext_read
	load    [ext_a + 0], $i2
	li      0, $i3
.count stack_store
	store   $i3, [$sp + 1]
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 1], $i2
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 2], $i2
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 3], $i2
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 4], $i2
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 5], $i2
	store   $i1, [$i2 + 0]
	call    ext_read
	load    [ext_a + 6], $i2
	store   $i1, [$i2 + 0]
	li      7, $i1
.count stack_load
	load    [$sp + 1], $i2
	jal     read_rec.316.524, $ra1
	load    [ext_a + 0], $i1
	li      0, $i2
.count stack_store
	store   $i2, [$sp + 2]
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 1], $i1
	load    [$i1 + 0], $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 1], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 2], $i1
	load    [$i1 + 0], $i2
	add     $i2, 1, $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 2], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 3], $i1
	load    [$i1 + 0], $i2
	add     $i2, 2, $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 3], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 4], $i1
	load    [$i1 + 0], $i2
	add     $i2, 3, $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 4], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 5], $i1
	load    [$i1 + 0], $i2
	add     $i2, 4, $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 5], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	load    [ext_a + 6], $i1
	load    [$i1 + 0], $i2
	add     $i2, 5, $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 6], $i1
	load    [$i1 + 0], $i2
	call    ext_write2
	li      7, $i1
	load    [ext_a + 7], $i2
	load    [$i2 + 0], $i3
	add     $i3, 6, $i3
	store   $i3, [$i2 + 0]
.count stack_load
	load    [$sp + 2], $i2
	jal     write2_rec.320.530, $ra1
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	load    [ext_a + 0], $i1
	li      0, $i2
.count stack_store
	store   $i2, [$sp + 3]
	load    [$i1 + 0], $i2
	call    ext_float_of_int
	mov     $f1, $f4
	load    [ext_a + 95], $i2
	load    [$i2 + 0], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	load    [$i1 + 95], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8566
ble.8566:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 4]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 1], $i1
	load    [$i1 + 0], $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f4
	load    [ext_a + 0], $i2
	load    [$i2 + 0], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	load    [$i1 + 95], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8567
.count dual_jmp
	b       bg.8567
bg.8566:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 4]
	call    ext_write2
	load    [ext_a + 0], $i1
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 1], $i1
	load    [$i1 + 0], $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f4
	load    [ext_a + 0], $i2
	load    [$i2 + 0], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	load    [$i1 + 95], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8567
ble.8567:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 5]
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 5], $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 2], $i1
	load    [$i1 + 0], $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f4
	load    [ext_a + 1], $i2
	load    [$i2 + 0], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	load    [$i1 + 95], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	ble     $i1, 0, ble.8568
.count dual_jmp
	b       bg.8568
bg.8567:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 5]
	call    ext_write2
	load    [ext_a + 1], $i1
.count stack_load
	load    [$sp + 5], $i2
	store   $i2, [$i1 + 0]
	load    [ext_a + 2], $i1
	load    [$i1 + 0], $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f4
	load    [ext_a + 1], $i2
	load    [$i2 + 0], $i2
	call    ext_float_of_int
	fmul    $f4, $f1, $f4
	load    [$i1 + 95], $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $f2
	call    ext_int_of_float
	bg      $i1, 0, bg.8568
ble.8568:
	li      1, $i1
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 6]
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 6], $i2
	store   $i2, [$i1 + 0]
	li      3, $i1
.count stack_load
	load    [$sp + 3], $i2
	jal     itof_rec.274.477, $ra1
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      0, $i2
	call    ext_write2
	li      1, $i2
	call    ext_write2
	li      2, $i2
	call    ext_write2
	li      3, $i2
	call    ext_write2
	li      4, $i2
	call    ext_write2
	li      5, $i2
	call    ext_write2
	li      6, $i2
	call    ext_write2
	li      7, $i2
	call    ext_write2
	li      8, $i2
	call    ext_write2
	li      9, $i2
	call    ext_write2
	li      10, $i2
	call    ext_write2
	li      11, $i2
	call    ext_write2
	li      12, $i2
	call    ext_write2
	li      13, $i2
	call    ext_write2
	li      14, $i2
	call    ext_write2
	li      15, $i2
	call    ext_write2
	li      16, $i2
	call    ext_write2
	li      17, $i2
	call    ext_write2
	li      18, $i2
	call    ext_write2
	li      19, $i2
	call    ext_write2
	li      20, $i2
	call    ext_write2
	li      21, $i2
	call    ext_write2
	li      22, $i2
	call    ext_write2
	li      23, $i2
	call    ext_write2
	li      24, $i2
	call    ext_write2
	li      25, $i2
	call    ext_write2
	li      26, $i2
	call    ext_write2
	li      27, $i2
	call    ext_write2
	li      28, $i2
	call    ext_write2
	li      29, $i2
	call    ext_write2
	li      30, $i2
	call    ext_write2
	li      31, $i1
	jal     fpu_rec.259.457, $ra1
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      0, $i2
	li      7, $i1
	load    [ext_a + 0], $i3
	load    [$i3 + 0], $i3
	load    [ext_a + 6], $i4
	load    [$i4 + 0], $i4
	load    [ext_a + 5], $i5
	load    [$i5 + 0], $i5
	load    [ext_a + 4], $i6
	load    [$i6 + 0], $i6
	load    [ext_a + 3], $i7
	load    [$i7 + 0], $i7
	load    [ext_a + 2], $i8
	load    [$i8 + 0], $i9
	load    [ext_a + 1], $i10
	load    [$i10 + 0], $i11
	add     $i3, $i3, $i12
	load    [$i10 + 1], $i10
	add     $i12, $i10, $i12
	load    [$i8 + 2], $i8
	add     $i12, $i8, $i12
	add     $i12, $i11, $i11
	add     $i11, $i3, $i11
	add     $i11, $i10, $i11
	add     $i11, $i8, $i11
	add     $i11, $i9, $i9
	add     $i9, $i3, $i9
	add     $i9, $i10, $i9
	add     $i9, $i8, $i9
	add     $i9, $i7, $i7
	add     $i7, $i3, $i7
	add     $i7, $i10, $i7
	add     $i7, $i8, $i7
	add     $i7, $i6, $i6
	add     $i6, $i3, $i6
	add     $i6, $i10, $i6
	add     $i6, $i8, $i6
	add     $i6, $i5, $i5
	add     $i5, $i3, $i5
	add     $i5, $i10, $i5
	add     $i5, $i8, $i5
	add     $i5, $i4, $i4
	add     $i4, $i3, $i3
	add     $i3, $i10, $i3
	add     $i3, $i8, $i3
	jal     load_rec.222.415, $ra1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	li      0, $i1
	ret     
bg.8568:
	mov     $i1, $i2
.count stack_store
	store   $i2, [$sp + 6]
	call    ext_write2
	load    [ext_a + 2], $i1
.count stack_load
	load    [$sp + 6], $i2
	store   $i2, [$i1 + 0]
	li      3, $i1
.count stack_load
	load    [$sp + 3], $i2
	jal     itof_rec.274.477, $ra1
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      0, $i2
	call    ext_write2
	li      1, $i2
	call    ext_write2
	li      2, $i2
	call    ext_write2
	li      3, $i2
	call    ext_write2
	li      4, $i2
	call    ext_write2
	li      5, $i2
	call    ext_write2
	li      6, $i2
	call    ext_write2
	li      7, $i2
	call    ext_write2
	li      8, $i2
	call    ext_write2
	li      9, $i2
	call    ext_write2
	li      10, $i2
	call    ext_write2
	li      11, $i2
	call    ext_write2
	li      12, $i2
	call    ext_write2
	li      13, $i2
	call    ext_write2
	li      14, $i2
	call    ext_write2
	li      15, $i2
	call    ext_write2
	li      16, $i2
	call    ext_write2
	li      17, $i2
	call    ext_write2
	li      18, $i2
	call    ext_write2
	li      19, $i2
	call    ext_write2
	li      20, $i2
	call    ext_write2
	li      21, $i2
	call    ext_write2
	li      22, $i2
	call    ext_write2
	li      23, $i2
	call    ext_write2
	li      24, $i2
	call    ext_write2
	li      25, $i2
	call    ext_write2
	li      26, $i2
	call    ext_write2
	li      27, $i2
	call    ext_write2
	li      28, $i2
	call    ext_write2
	li      29, $i2
	call    ext_write2
	li      30, $i2
	call    ext_write2
	li      31, $i1
	jal     fpu_rec.259.457, $ra1
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      32, $i2
	call    ext_write2
	li      0, $i2
	li      7, $i1
	load    [ext_a + 0], $i3
	load    [$i3 + 0], $i3
	load    [ext_a + 6], $i4
	load    [$i4 + 0], $i4
	load    [ext_a + 5], $i5
	load    [$i5 + 0], $i5
	load    [ext_a + 4], $i6
	load    [$i6 + 0], $i6
	load    [ext_a + 3], $i7
	load    [$i7 + 0], $i7
	load    [ext_a + 2], $i8
	load    [$i8 + 0], $i9
	load    [ext_a + 1], $i10
	load    [$i10 + 0], $i11
	add     $i3, $i3, $i12
	load    [$i10 + 1], $i10
	add     $i12, $i10, $i12
	load    [$i8 + 2], $i8
	add     $i12, $i8, $i12
	add     $i12, $i11, $i11
	add     $i11, $i3, $i11
	add     $i11, $i10, $i11
	add     $i11, $i8, $i11
	add     $i11, $i9, $i9
	add     $i9, $i3, $i9
	add     $i9, $i10, $i9
	add     $i9, $i8, $i9
	add     $i9, $i7, $i7
	add     $i7, $i3, $i7
	add     $i7, $i10, $i7
	add     $i7, $i8, $i7
	add     $i7, $i6, $i6
	add     $i6, $i3, $i6
	add     $i6, $i10, $i6
	add     $i6, $i8, $i6
	add     $i6, $i5, $i5
	add     $i5, $i3, $i5
	add     $i5, $i10, $i5
	add     $i5, $i8, $i5
	add     $i5, $i4, $i4
	add     $i4, $i3, $i3
	add     $i3, $i10, $i3
	add     $i3, $i8, $i3
	jal     load_rec.222.415, $ra1
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	li      0, $i1
	ret     
.end main
