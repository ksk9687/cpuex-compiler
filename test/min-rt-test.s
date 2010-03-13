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
	ledout  1, $tmp
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
# [$f1 - $f17]
# []
# []
# [$ra]
######################################################################
.begin read_nth_object
read_nth_object.2719:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	bne     $i7, -1, bne.22113
be.22113:
	li      0, $i1
	jr      $ra1
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
	li      3, $i2
.count move_args
	mov     $f0, $f2
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
	bne     $i10, 0, bne.22114
be.22114:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	ble     $f0, $f3, ble.22115
.count dual_jmp
	b       bg.22115
bne.22114:
	call    ext_read_float
.count load_float
	load    [f.21933], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i15 + 2]
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	bg      $f0, $f3, bg.22115
ble.22115:
	li      0, $i2
	be      $i8, 2, be.22116
.count dual_jmp
	b       bne.22116
bg.22115:
	li      1, $i2
	bne     $i8, 2, bne.22116
be.22116:
	li      1, $i3
	mov     $hp, $i4
	add     $hp, 23, $hp
	store   $i7, [$i4 + 0]
	store   $i8, [$i4 + 1]
	store   $i9, [$i4 + 2]
	store   $i10, [$i4 + 3]
	load    [$i11 + 0], $i5
	store   $i5, [$i4 + 4]
	load    [$i11 + 1], $i5
	store   $i5, [$i4 + 5]
	load    [$i11 + 2], $i5
	store   $i5, [$i4 + 6]
	add     $i4, 4, $i11
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
	store   $i3, [$i4 + 18]
	add     $i4, 16, $i15
	load    [$i1 + 0], $i3
	store   $i3, [$i4 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i4 + 20]
	load    [$i1 + 2], $i3
	store   $i3, [$i4 + 21]
	load    [$i1 + 3], $i1
	store   $i1, [$i4 + 22]
	store   $i4, [ext_objects + $i6]
	be      $i8, 3, be.22117
.count dual_jmp
	b       bne.22117
bne.22116:
	mov     $i2, $i3
	mov     $hp, $i4
	add     $hp, 23, $hp
	store   $i7, [$i4 + 0]
	store   $i8, [$i4 + 1]
	store   $i9, [$i4 + 2]
	store   $i10, [$i4 + 3]
	load    [$i11 + 0], $i5
	store   $i5, [$i4 + 4]
	load    [$i11 + 1], $i5
	store   $i5, [$i4 + 5]
	load    [$i11 + 2], $i5
	store   $i5, [$i4 + 6]
	add     $i4, 4, $i11
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
	store   $i3, [$i4 + 18]
	add     $i4, 16, $i15
	load    [$i1 + 0], $i3
	store   $i3, [$i4 + 19]
	load    [$i1 + 1], $i3
	store   $i3, [$i4 + 20]
	load    [$i1 + 2], $i3
	store   $i3, [$i4 + 21]
	load    [$i1 + 3], $i1
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
	bg      $f1, $f0, bg.22120
ble.22120:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22121
bg.22120:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
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
	bg      $f1, $f0, bg.22123
ble.22123:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22125
.count dual_jmp
	b       bne.22124
bg.22123:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
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
	bg      $f1, $f0, bg.22126
ble.22126:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
bg.22126:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22133
.count dual_jmp
	b       bne.22133
bne.22117:
	bne     $i8, 2, bne.22128
be.22128:
	load    [$i11 + 0], $f1
	load    [$i11 + 1], $f3
	fmul    $f3, $f3, $f3
	fmul    $f1, $f1, $f2
	fadd    $f2, $f3, $f2
	load    [$i11 + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.22129
be.22129:
	li      1, $i1
	be      $f2, $f0, be.22130
.count dual_jmp
	b       bne.22130
bne.22129:
	li      0, $i1
	bne     $f2, $f0, bne.22130
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
.count dual_jmp
	b       bne.22133
bne.22130:
	bne     $i1, 0, bne.22131
be.22131:
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
bne.22131:
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
bne.22128:
	bne     $i10, 0, bne.22133
be.22133:
	li      1, $i1
	jr      $ra1
bne.22133:
	load    [$i15 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f7
	load    [$i15 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f8
	load    [$i15 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f9
	load    [$i15 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i15 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
	load    [$i15 + 2], $f2
	call    ext_sin
	fmul    $f9, $f11, $f2
	fmul    $f2, $f2, $f3
	load    [$i11 + 0], $f4
	fmul    $f4, $f3, $f3
	fmul    $f9, $f1, $f5
	fmul    $f5, $f5, $f6
	load    [$i11 + 1], $f12
	fmul    $f12, $f6, $f6
	fadd    $f3, $f6, $f3
	fneg    $f10, $f6
	fmul    $f6, $f6, $f13
	load    [$i11 + 2], $f14
	fmul    $f14, $f13, $f13
	fadd    $f3, $f13, $f3
	store   $f3, [$i11 + 0]
	fmul    $f8, $f10, $f3
	fmul    $f3, $f11, $f13
	fmul    $f7, $f1, $f15
	fsub    $f13, $f15, $f13
	fmul    $f13, $f13, $f15
	fmul    $f4, $f15, $f15
	fmul    $f3, $f1, $f3
	fmul    $f7, $f11, $f16
	fadd    $f3, $f16, $f3
	fmul    $f3, $f3, $f16
	fmul    $f12, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f8, $f9, $f16
	fmul    $f16, $f16, $f17
	fmul    $f14, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i11 + 1]
	fmul    $f7, $f10, $f10
	fmul    $f10, $f11, $f15
	fmul    $f8, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f4, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f8, $f11, $f8
	fsub    $f1, $f8, $f1
	fmul    $f1, $f1, $f8
	fmul    $f12, $f8, $f8
	fadd    $f17, $f8, $f8
	fmul    $f7, $f9, $f7
	fmul    $f7, $f7, $f9
	fmul    $f14, $f9, $f9
	fadd    $f8, $f9, $f8
	store   $f8, [$i11 + 2]
	fmul    $f4, $f13, $f8
	fmul    $f8, $f15, $f8
	fmul    $f12, $f3, $f9
	fmul    $f9, $f1, $f9
	fadd    $f8, $f9, $f8
	fmul    $f14, $f16, $f9
	fmul    $f9, $f7, $f9
	fadd    $f8, $f9, $f8
	fmul    $fc10, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f4, $f2, $f2
	fmul    $f2, $f15, $f4
	fmul    $f12, $f5, $f5
	fmul    $f5, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f14, $f6, $f4
	fmul    $f4, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i15 + 1]
	fmul    $f2, $f13, $f1
	fmul    $f5, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i15 + 2]
	li      1, $i1
	jr      $ra1
.end read_nth_object

######################################################################
# read_object($i6)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f17]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_object
read_object.2721:
	bl      $i6, 60, bl.22134
bge.22134:
	jr      $ra2
bl.22134:
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, bne.22135
be.22135:
	mov     $i6, $ig0
	jr      $ra2
bne.22135:
	add     $i6, 1, $i6
	b       read_object.2721
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
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
	store   $ra, [$sp - 3]
.count stack_move
	add     $sp, -3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	bne     $i1, -1, bne.22137
be.22137:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
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
	bne     $i2, -1, bne.22141
be.22141:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i2
	add     $i2, 1, $i2
.count move_args
	mov     $i1, $i3
	b       ext_create_array_int
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
.begin read_and_network
read_and_network.2729:
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	bne     $i2, -1, bne.22144
be.22144:
	jr      $ra1
bne.22144:
	store   $i1, [ext_and_net + $i6]
	add     $i6, 1, $i6
	b       read_and_network.2729
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f13]
# []
# [$fg0]
# []
######################################################################
.begin solver
solver.2773:
	load    [ext_objects + $i1], $i1
	add     $i1, 7, $i3
	load    [$i1 + 1], $i4
	load    [$i3 + 0], $f1
	load    [$i3 + 1], $f2
	load    [$i3 + 2], $f3
	fsub    $fg17, $f1, $f1
	fsub    $fg18, $f2, $f2
	fsub    $fg19, $f3, $f3
	load    [$i2 + 0], $f4
	bne     $i4, 1, bne.22145
be.22145:
	be      $f4, $f0, ble.22152
bne.22146:
	add     $i1, 4, $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 10], $i4
	bg      $f0, $f4, bg.22147
ble.22147:
	li      0, $i5
	be      $i4, 0, be.22148
.count dual_jmp
	b       bne.22148
bg.22147:
	li      1, $i5
	bne     $i4, 0, bne.22148
be.22148:
	mov     $i5, $i4
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22150
be.22150:
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
.count dual_jmp
	b       bg.22151
bne.22150:
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
.count dual_jmp
	b       bg.22151
bne.22148:
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.22149
be.22149:
	li      1, $i4
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
.count dual_jmp
	b       bg.22151
bne.22149:
	li      0, $i4
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22152
bg.22151:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.22152
ble.22152:
	load    [$i2 + 1], $f4
	be      $f4, $f0, ble.22160
bne.22154:
	add     $i1, 4, $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 10], $i4
	bg      $f0, $f4, bg.22155
ble.22155:
	li      0, $i5
	be      $i4, 0, be.22156
.count dual_jmp
	b       bne.22156
bg.22155:
	li      1, $i5
	bne     $i4, 0, bne.22156
be.22156:
	mov     $i5, $i4
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	be      $i4, 0, bne.22157
.count dual_jmp
	b       be.22157
bne.22156:
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.22157
be.22157:
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22160
.count dual_jmp
	b       bg.22159
bne.22157:
	fneg    $f7, $f7
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22160
bg.22159:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.22160
ble.22160:
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.22176
bne.22162:
	add     $i1, 4, $i3
	load    [$i1 + 10], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, bg.22163
ble.22163:
	li      0, $i4
	be      $i1, 0, be.22164
.count dual_jmp
	b       bne.22164
bg.22163:
	li      1, $i4
	bne     $i1, 0, bne.22164
be.22164:
	mov     $i4, $i1
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	be      $i1, 0, bne.22165
.count dual_jmp
	b       be.22165
bne.22164:
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22165
be.22165:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22176
.count dual_jmp
	b       bg.22167
bne.22165:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22176
bg.22167:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22176
bg.22168:
	mov     $f3, $fg0
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
	bne     $i4, 2, bne.22169
be.22169:
	add     $i1, 4, $i1
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [$i2 + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	ble     $f4, $f0, ble.22176
bg.22170:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22169:
	add     $i1, 4, $i3
	load    [$i1 + 3], $i5
	load    [$i2 + 1], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i3 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i3 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i3 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	bne     $i5, 0, bne.22171
be.22171:
	be      $f7, $f0, ble.22176
.count dual_jmp
	b       bne.22172
bne.22171:
	fmul    $f5, $f6, $f9
	add     $i1, 16, $i2
	load    [$i2 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f4, $f9
	load    [$i2 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f4, $f5, $f9
	load    [$i2 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	be      $f7, $f0, ble.22176
bne.22172:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i5, 0, bne.22173
be.22173:
	mov     $f9, $f4
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	be      $i5, 0, be.22174
.count dual_jmp
	b       bne.22174
bne.22173:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	add     $i1, 16, $i2
	load    [$i2 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f4, $f3, $f13
	fmul    $f6, $f1, $f6
	fadd    $f13, $f6, $f6
	load    [$i2 + 1], $f13
	fmul    $f6, $f13, $f6
	fadd    $f12, $f6, $f6
	fmul    $f4, $f2, $f4
	fmul    $f5, $f1, $f5
	fadd    $f4, $f5, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f6, $f4, $f4
	fmul    $f4, $fc4, $f4
	fadd    $f9, $f4, $f4
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i5, 0, bne.22174
be.22174:
	mov     $f6, $f1
	be      $i4, 3, be.22175
.count dual_jmp
	b       bne.22175
bne.22174:
	fmul    $f2, $f3, $f8
	add     $i1, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f6, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i4, 3, bne.22175
be.22175:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22176
.count dual_jmp
	b       bg.22176
bne.22175:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.22176
ble.22176:
	li      0, $i1
	ret     
bg.22176:
	load    [$i1 + 10], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, bne.22177
be.22177:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22177:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i6]
# [$f1 - $f9]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast
solver_fast.2796:
	load    [ext_objects + $i1], $i2
	add     $i2, 7, $i3
	li      ext_light_dirvec, $i4
	load    [ext_light_dirvec + 3], $i5
	load    [$i2 + 1], $i6
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i3 + 1], $f4
	load    [ext_intersection_point + 2], $f5
	load    [$i3 + 2], $f6
	fsub    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsub    $f5, $f6, $f3
	load    [$i5 + $i1], $i1
	bne     $i6, 1, bne.22178
be.22178:
	add     $i4, 0, $i3
	add     $i2, 4, $i2
	load    [$i2 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22181
bg.22179:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.22181
bg.22180:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.22181
be.22181:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22185
bg.22183:
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.22185
bg.22184:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.22185
be.22185:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.22195
bg.22187:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22195
bg.22188:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.22195
bne.22189:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.22185:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.22181:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.22178:
	load    [$i1 + 0], $f4
	bne     $i6, 2, bne.22190
be.22190:
	ble     $f0, $f4, ble.22195
bg.22191:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22190:
	be      $f4, $f0, ble.22195
bne.22192:
	add     $i2, 4, $i3
	load    [$i2 + 3], $i4
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f6
	fadd    $f5, $f6, $f5
	load    [$i1 + 3], $f6
	fmul    $f6, $f3, $f6
	fadd    $f5, $f6, $f5
	fmul    $f5, $f5, $f6
	fmul    $f1, $f1, $f7
	load    [$i3 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f2, $f2, $f8
	load    [$i3 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i3 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i4, 0, bne.22193
be.22193:
	mov     $f7, $f1
	be      $i6, 3, be.22194
.count dual_jmp
	b       bne.22194
bne.22193:
	fmul    $f2, $f3, $f8
	add     $i2, 16, $i3
	load    [$i3 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i6, 3, bne.22194
be.22194:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22195
.count dual_jmp
	b       bg.22195
bne.22194:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, bg.22195
ble.22195:
	li      0, $i1
	ret     
bg.22195:
	load    [$i2 + 10], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22196
be.22196:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
bne.22196:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
.end solver_fast

######################################################################
# $i1 = solver_fast2($i1, $i2)
# $ra = $ra
# [$i1 - $i6]
# [$f1 - $f8]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast2
solver_fast2.2814:
	load    [ext_objects + $i1], $i3
	add     $i3, 19, $i4
	load    [$i2 + 3], $i5
	load    [$i3 + 1], $i6
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	load    [$i5 + $i1], $i1
	bne     $i6, 1, bne.22197
be.22197:
	add     $i2, 0, $i2
	add     $i3, 4, $i3
	load    [$i3 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22200
bg.22198:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.22200
bg.22199:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.22200
be.22200:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22204
bg.22202:
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.22204
bg.22203:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.22204
be.22204:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.22212
bg.22206:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22212
bg.22207:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.22212
bne.22208:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.22204:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.22200:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.22197:
	bne     $i6, 2, bne.22209
be.22209:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, ble.22212
bg.22210:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22209:
	load    [$i1 + 0], $f4
	be      $f4, $f0, ble.22212
bne.22211:
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	load    [$i4 + 3], $f3
	fmul    $f4, $f3, $f3
	fsub    $f2, $f3, $f2
	bg      $f2, $f0, bg.22212
ble.22212:
	li      0, $i1
	ret     
bg.22212:
	load    [$i3 + 10], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.22213
be.22213:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22213:
	fadd    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
.end solver_fast2

######################################################################
# $i1 = setup_rect_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3, $i5]
# [$f1 - $f2]
# []
# []
# [$ra]
######################################################################
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
	bg      $f0, $f1, bg.22215
ble.22215:
	li      0, $i3
	be      $i2, 0, be.22216
.count dual_jmp
	b       bne.22216
bg.22215:
	li      1, $i3
	bne     $i2, 0, bne.22216
be.22216:
	mov     $i3, $i2
	add     $i5, 4, $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, bne.22218
be.22218:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22219
.count dual_jmp
	b       bne.22219
bne.22218:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22219
.count dual_jmp
	b       bne.22219
bne.22216:
	bne     $i3, 0, bne.22217
be.22217:
	li      1, $i2
	add     $i5, 4, $i3
	load    [$i3 + 0], $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22219
.count dual_jmp
	b       bne.22219
bne.22217:
	li      0, $i2
	add     $i5, 4, $i3
	load    [$i3 + 0], $f1
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
	bg      $f0, $f1, bg.22220
ble.22220:
	li      0, $i3
	be      $i2, 0, be.22221
.count dual_jmp
	b       bne.22221
bg.22220:
	li      1, $i3
	bne     $i2, 0, bne.22221
be.22221:
	mov     $i3, $i2
	add     $i5, 4, $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, bne.22223
be.22223:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
.count dual_jmp
	b       bne.22224
bne.22223:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
.count dual_jmp
	b       bne.22224
bne.22221:
	bne     $i3, 0, bne.22222
be.22222:
	li      1, $i2
	add     $i5, 4, $i3
	load    [$i3 + 1], $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22224
.count dual_jmp
	b       bne.22224
bne.22222:
	li      0, $i2
	add     $i5, 4, $i3
	load    [$i3 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	bne     $f1, $f0, bne.22224
be.22224:
	store   $f0, [$i1 + 5]
	jr      $ra1
bne.22224:
	load    [$i5 + 10], $i2
	add     $i5, 4, $i3
	bg      $f0, $f1, bg.22225
ble.22225:
	li      0, $i5
	be      $i2, 0, be.22226
.count dual_jmp
	b       bne.22226
bg.22225:
	li      1, $i5
	bne     $i2, 0, bne.22226
be.22226:
	mov     $i5, $i2
	load    [$i3 + 2], $f1
	be      $i2, 0, bne.22227
.count dual_jmp
	b       be.22227
bne.22226:
	load    [$i3 + 2], $f1
	bne     $i5, 0, bne.22227
be.22227:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
bne.22227:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f3]
# []
# []
# [$ra]
######################################################################
.begin setup_surface_table
setup_surface_table.2820:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	add     $i5, 4, $i2
	load    [$i4 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i4 + 1], $f2
	load    [$i2 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i4 + 2], $f2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f1, $f0, bg.22229
ble.22229:
	store   $f0, [$i1 + 0]
	jr      $ra1
bg.22229:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	jr      $ra1
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3, $i6]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.begin setup_second_table
setup_second_table.2823:
	li      5, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i5 + 3], $i2
	add     $i5, 4, $i3
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i3 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i3 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, bne.22230
be.22230:
	mov     $f4, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i4 + 1], $f3
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
	be      $i2, 0, be.22231
.count dual_jmp
	b       bne.22231
bne.22230:
	fmul    $f2, $f3, $f5
	add     $i5, 16, $i6
	load    [$i6 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i6 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i6 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i4 + 1], $f3
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
	bne     $i2, 0, bne.22231
be.22231:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	be      $f1, $f0, be.22233
.count dual_jmp
	b       bne.22233
bne.22231:
	add     $i5, 16, $i2
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i2 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i4 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i4 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc4, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i4 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i4 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc4, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, bne.22233
be.22233:
	jr      $ra1
bne.22233:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i7, $i8)
# $ra = $ra2
# [$i1 - $i6, $i8 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i8, 0, bl.22234
bge.22234:
	load    [$i7 + 3], $i9
	load    [ext_objects + $i8], $i5
	load    [$i5 + 1], $i1
	add     $i7, 0, $i4
	bne     $i1, 1, bne.22235
be.22235:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.22235:
	bne     $i1, 2, bne.22236
be.22236:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.22236:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bl.22234:
	jr      $ra2
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i7)
# $ra = $ra2
# [$i1 - $i6, $i8 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
	add     $ig0, -1, $i8
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1, $i3 - $i7]
# [$f1 - $f6]
# []
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bl.22237
bge.22237:
	load    [ext_objects + $i1], $i3
	add     $i3, 7, $i4
	add     $i3, 19, $i5
	load    [$i2 + 0], $f1
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 0]
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 1]
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 2]
	load    [$i3 + 1], $i4
	bne     $i4, 2, bne.22238
be.22238:
	add     $i3, 4, $i3
	load    [$i5 + 0], $f1
	load    [$i3 + 0], $f2
	fmul    $f2, $f1, $f1
	load    [$i5 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i5 + 2], $f2
	load    [$i3 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bne.22238:
	bg      $i4, 2, bg.22239
ble.22239:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bg.22239:
	add     $i3, 4, $i6
	load    [$i3 + 3], $i7
	load    [$i5 + 0], $f1
	load    [$i5 + 1], $f2
	load    [$i5 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i6 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i6 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i6 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i7, 0, bne.22240
be.22240:
	mov     $f4, $f1
	be      $i4, 3, be.22241
.count dual_jmp
	b       bne.22241
bne.22240:
	add     $i3, 16, $i3
	fmul    $f2, $f3, $f5
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i4, 3, bne.22241
be.22241:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bne.22241:
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bl.22237:
	ret     
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i7]
# [$f1, $f5 - $f9]
# []
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
bne.22242:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	add     $i2, 7, $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22243
be.22243:
	add     $i2, 4, $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f7, $f1, ble.22248
bg.22244:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22248
bg.22246:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22248
ble.22248:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22258
bg.22248:
	bne     $i2, 0, bne.22258
be.22259:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
.count dual_jmp
	b       bne.22260
bne.22243:
	bne     $i4, 2, bne.22250
be.22250:
	load    [$i2 + 10], $i4
	add     $i2, 4, $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, bg.22251
ble.22251:
	be      $i4, 0, bne.22258
.count dual_jmp
	b       be.22258
bg.22251:
	be      $i4, 0, be.22258
.count dual_jmp
	b       bne.22258
bne.22250:
	load    [$i2 + 10], $i5
	fmul    $f1, $f1, $f7
	add     $i2, 4, $i6
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i6 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i6
	bne     $i6, 0, bne.22254
be.22254:
	mov     $f7, $f1
	be      $i4, 3, be.22255
.count dual_jmp
	b       bne.22255
bne.22254:
	fmul    $f5, $f6, $f8
	add     $i2, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
	bne     $i4, 3, bne.22255
be.22255:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22256
.count dual_jmp
	b       bg.22256
bne.22255:
	bg      $f0, $f1, bg.22256
ble.22256:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22258
bg.22256:
	bne     $i5, 0, bne.22258
be.22258:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
bne.22260:
	load    [ext_objects + $i2], $i2
	add     $i2, 7, $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.22261
be.22261:
	add     $i2, 4, $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f7, $f1, ble.22266
bg.22262:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22266
bg.22264:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22266
ble.22266:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22276
bg.22266:
	bne     $i2, 0, bne.22258
be.22277:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
.count dual_jmp
	b       bne.22278
bne.22261:
	load    [$i2 + 10], $i4
	bne     $i5, 2, bne.22268
be.22268:
	add     $i2, 4, $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.22274
.count dual_jmp
	b       bg.22274
bne.22268:
	add     $i2, 4, $i6
	load    [$i2 + 3], $i7
	fmul    $f1, $f1, $f7
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i6 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i7, 0, bne.22272
be.22272:
	mov     $f7, $f1
	be      $i5, 3, be.22273
.count dual_jmp
	b       bne.22273
bne.22272:
	add     $i2, 16, $i2
	fmul    $f5, $f6, $f8
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
	bne     $i5, 3, bne.22273
be.22273:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22274
.count dual_jmp
	b       bg.22274
bne.22273:
	bg      $f0, $f1, bg.22274
ble.22274:
	be      $i4, 0, bne.22258
.count dual_jmp
	b       be.22276
bg.22274:
	bne     $i4, 0, bne.22258
be.22276:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
bne.22278:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	add     $i2, 7, $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22279
be.22279:
	add     $i2, 4, $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 10], $i2
	ble     $f7, $f1, ble.22284
bg.22280:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22284
bg.22282:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22284
ble.22284:
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22294
bg.22284:
	bne     $i2, 0, bne.22258
be.22295:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22296
.count dual_jmp
	b       bne.22296
bne.22279:
	bne     $i4, 2, bne.22286
be.22286:
	load    [$i2 + 10], $i4
	add     $i2, 4, $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, bg.22287
ble.22287:
	be      $i4, 0, bne.22258
.count dual_jmp
	b       be.22294
bg.22287:
	be      $i4, 0, be.22294
.count dual_jmp
	b       bne.22258
bne.22286:
	load    [$i2 + 10], $i5
	load    [$i2 + 3], $i6
	fmul    $f1, $f1, $f7
	add     $i2, 4, $i7
	load    [$i7 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i7 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i7 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i6, 0, bne.22290
be.22290:
	mov     $f7, $f1
	be      $i4, 3, be.22291
.count dual_jmp
	b       bne.22291
bne.22290:
	fmul    $f5, $f6, $f8
	add     $i2, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
	bne     $i4, 3, bne.22291
be.22291:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22292
.count dual_jmp
	b       bg.22292
bne.22291:
	bg      $f0, $f1, bg.22292
ble.22292:
	be      $i5, 0, bne.22258
.count dual_jmp
	b       be.22294
bg.22292:
	bne     $i5, 0, bne.22258
be.22294:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, bne.22296
be.22296:
	li      1, $i1
	ret     
bne.22296:
	load    [ext_objects + $i2], $i2
	add     $i2, 7, $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f5
	load    [$i4 + 2], $f6
	fsub    $f2, $f1, $f1
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.22297
be.22297:
	add     $i2, 4, $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22300
bg.22298:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22300
bg.22299:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22300
ble.22300:
	load    [$i2 + 10], $i2
	be      $i2, 0, bne.22258
.count dual_jmp
	b       be.22312
bg.22300:
	load    [$i2 + 10], $i2
	be      $i2, 0, be.22312
.count dual_jmp
	b       bne.22258
bne.22297:
	load    [$i2 + 10], $i4
	bne     $i5, 2, bne.22304
be.22304:
	add     $i2, 4, $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.22310
.count dual_jmp
	b       bg.22310
bne.22304:
	add     $i2, 4, $i6
	load    [$i2 + 3], $i7
	fmul    $f1, $f1, $f7
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i6 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i7, 0, bne.22308
be.22308:
	mov     $f7, $f1
	be      $i5, 3, be.22309
.count dual_jmp
	b       bne.22309
bne.22308:
	fmul    $f5, $f6, $f8
	add     $i2, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
	bne     $i5, 3, bne.22309
be.22309:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22310
.count dual_jmp
	b       bg.22310
bne.22309:
	bg      $f0, $f1, bg.22310
ble.22310:
	be      $i4, 0, bne.22258
.count dual_jmp
	b       be.22312
bg.22310:
	bne     $i4, 0, bne.22258
be.22312:
	add     $i1, 1, $i1
	b       check_all_inside.2856
bne.22258:
	li      0, $i1
	ret     
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i8, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i8], $i1
	be      $i1, -1, be.22336
bne.22313:
	load    [ext_objects + $i1], $i2
	add     $i2, 7, $i4
	load    [ext_light_dirvec + 3], $i6
	load    [$i2 + 1], $i7
	load    [ext_intersection_point + 0], $f1
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i4 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i4 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [$i6 + $i1], $i4
	bne     $i7, 1, bne.22314
be.22314:
	li      ext_light_dirvec, $i5
	add     $i5, 0, $i5
	add     $i2, 4, $i2
	load    [$i2 + 1], $f4
	load    [$i5 + 1], $f5
	load    [$i4 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22317
bg.22315:
	load    [$i2 + 2], $f4
	load    [$i5 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22317
bg.22316:
	load    [$i4 + 1], $f4
	bne     $f4, $f0, bne.22317
be.22317:
	load    [$i2 + 0], $f4
	load    [$i5 + 0], $f5
	load    [$i4 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i4 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22321
bg.22319:
	load    [$i2 + 2], $f4
	load    [$i5 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22321
bg.22320:
	load    [$i4 + 3], $f4
	bne     $f4, $f0, bne.22317
be.22321:
	load    [$i2 + 0], $f4
	load    [$i5 + 0], $f5
	load    [$i4 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.22334
bg.22323:
	load    [$i2 + 1], $f1
	load    [$i5 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22334
bg.22324:
	load    [$i4 + 5], $f1
	be      $f1, $f0, ble.22334
bne.22325:
	mov     $f3, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
bne.22317:
	mov     $f6, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
bne.22314:
	load    [$i4 + 0], $f4
	bne     $i7, 2, bne.22326
be.22326:
	ble     $f0, $f4, ble.22334
bg.22327:
	load    [$i4 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i4 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i4 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
bne.22326:
	be      $f4, $f0, ble.22334
bne.22328:
	load    [$i4 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f2, $f6
	fadd    $f5, $f6, $f5
	load    [$i4 + 3], $f6
	fmul    $f6, $f3, $f6
	fadd    $f5, $f6, $f5
	fmul    $f5, $f5, $f6
	fmul    $f1, $f1, $f7
	add     $i2, 4, $i5
	load    [$i5 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f2, $f2, $f8
	load    [$i5 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i5 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i5
	bne     $i5, 0, bne.22329
be.22329:
	mov     $f7, $f1
	be      $i7, 3, be.22330
.count dual_jmp
	b       bne.22330
bne.22329:
	fmul    $f2, $f3, $f8
	add     $i2, 16, $i5
	load    [$i5 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i5 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i5 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i7, 3, bne.22330
be.22330:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22334
.count dual_jmp
	b       bg.22331
bne.22330:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22334
bg.22331:
	load    [$i2 + 10], $i2
	load    [$i4 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22332
be.22332:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21980], $f1
	ble     $f1, $fg0, ble.22334
.count dual_jmp
	b       bg.22334
bne.22332:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
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
	load    [ext_objects + $i1], $i1
	add     $i1, 7, $i2
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	fadd    $fg0, $fc15, $f2
	fmul    $fg14, $f2, $f3
	load    [ext_intersection_point + 0], $f4
	fadd    $f3, $f4, $f5
	fsub    $f5, $f1, $f1
	load    [$i2 + 1], $f3
	fmul    $fg12, $f2, $f4
	load    [ext_intersection_point + 1], $f6
	fadd    $f4, $f6, $f6
	fsub    $f6, $f3, $f3
	load    [$i2 + 2], $f4
	fmul    $fg13, $f2, $f2
	load    [ext_intersection_point + 2], $f7
	fadd    $f2, $f7, $f7
	fsub    $f7, $f4, $f2
	bne     $i4, 1, bne.22338
be.22338:
	add     $i1, 4, $i2
	load    [$i2 + 0], $f4
	fabs    $f1, $f1
	load    [$i1 + 10], $i1
	ble     $f4, $f1, ble.22343
bg.22339:
	load    [$i2 + 1], $f1
	fabs    $f3, $f3
	ble     $f1, $f3, ble.22343
bg.22341:
	load    [$i2 + 2], $f1
	fabs    $f2, $f2
	bg      $f1, $f2, bg.22343
ble.22343:
	be      $i1, 0, bne.22353
.count dual_jmp
	b       be.22353
bg.22343:
	be      $i1, 0, be.22353
.count dual_jmp
	b       bne.22353
bne.22338:
	load    [$i1 + 10], $i2
	bne     $i4, 2, bne.22345
be.22345:
	add     $i1, 4, $i1
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	ble     $f0, $f1, ble.22351
.count dual_jmp
	b       bg.22351
bne.22345:
	fmul    $f1, $f1, $f4
	add     $i1, 4, $i5
	load    [$i5 + 0], $f8
	fmul    $f4, $f8, $f4
	fmul    $f3, $f3, $f8
	load    [$i5 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	fmul    $f2, $f2, $f8
	load    [$i5 + 2], $f9
	fmul    $f8, $f9, $f8
	load    [$i1 + 3], $i5
	fadd    $f4, $f8, $f4
	bne     $i5, 0, bne.22349
be.22349:
	mov     $f4, $f1
	be      $i4, 3, be.22350
.count dual_jmp
	b       bne.22350
bne.22349:
	fmul    $f3, $f2, $f8
	add     $i1, 16, $i1
	load    [$i1 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	fmul    $f2, $f1, $f2
	load    [$i1 + 1], $f8
	fmul    $f2, $f8, $f2
	fadd    $f4, $f2, $f2
	fmul    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f1, $f3, $f1
	fadd    $f2, $f1, $f1
	bne     $i4, 3, bne.22350
be.22350:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22351
.count dual_jmp
	b       bg.22351
bne.22350:
	bg      $f0, $f1, bg.22351
ble.22351:
	be      $i2, 0, bne.22353
.count dual_jmp
	b       be.22353
bg.22351:
	bne     $i2, 0, bne.22353
be.22353:
	li      1, $i1
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f7, $f4
	call    check_all_inside.2856
	bne     $i1, 0, bne.22355
bne.22353:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
bne.22355:
	li      1, $i1
	jr      $ra1
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i9, $i10)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22356:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22357:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22358:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22359:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22360:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22361:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22362:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22363:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22364:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22365:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22366:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22367:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22370
bne.22368:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22369:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	bne     $i1, -1, bne.22370
be.22370:
	li      0, $i1
	jr      $ra2
bne.22370:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22357
be.22371:
	add     $i9, 1, $i9
	b       shadow_check_one_or_group.2865
bne.22357:
	li      1, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i11, $i12)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22429
bne.22372:
	be      $i1, 99, bne.22396
bne.22373:
	load    [ext_objects + $i1], $i3
	load    [ext_intersection_point + 0], $f1
	add     $i3, 7, $i4
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i4 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i4 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [ext_light_dirvec + 3], $i4
	load    [$i4 + $i1], $i1
	load    [$i3 + 1], $i4
	bne     $i4, 1, bne.22374
be.22374:
	li      ext_light_dirvec, $i2
	add     $i2, 0, $i2
	add     $i3, 4, $i3
	load    [$i3 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22377
bg.22375:
	load    [$i3 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22377
bg.22376:
	load    [$i1 + 1], $f4
	bne     $f4, $f0, bne.22377
be.22377:
	load    [$i3 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i1 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22381
bg.22379:
	load    [$i3 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22381
bg.22380:
	load    [$i1 + 3], $f4
	bne     $f4, $f0, bne.22381
be.22381:
	load    [$i3 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i1 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i1 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.22426
bg.22383:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, be.22426
bg.22384:
	load    [$i1 + 5], $f1
	be      $f1, $f0, be.22426
bne.22385:
	mov     $f3, $fg0
	li      3, $i1
	ble     $fc7, $fg0, be.22426
.count dual_jmp
	b       bg.22394
bne.22381:
	mov     $f6, $fg0
	li      2, $i1
	ble     $fc7, $fg0, be.22426
.count dual_jmp
	b       bg.22394
bne.22377:
	mov     $f6, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.22426
.count dual_jmp
	b       bg.22394
bne.22374:
	load    [$i1 + 0], $f4
	bne     $i4, 2, bne.22386
be.22386:
	ble     $f0, $f4, be.22426
bg.22387:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.22426
.count dual_jmp
	b       bg.22394
bne.22386:
	be      $f4, $f0, be.22426
bne.22388:
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i1 + 2], $f6
	fmul    $f6, $f2, $f6
	fadd    $f5, $f6, $f5
	load    [$i1 + 3], $f6
	fmul    $f6, $f3, $f6
	fadd    $f5, $f6, $f5
	fmul    $f5, $f5, $f6
	fmul    $f1, $f1, $f7
	add     $i3, 4, $i2
	load    [$i2 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f2, $f2, $f8
	load    [$i2 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i2 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i3 + 3], $i2
	bne     $i2, 0, bne.22389
be.22389:
	mov     $f7, $f1
	be      $i4, 3, be.22390
.count dual_jmp
	b       bne.22390
bne.22389:
	fmul    $f2, $f3, $f8
	add     $i3, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i4, 3, bne.22390
be.22390:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.22426
.count dual_jmp
	b       bg.22391
bne.22390:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.22426
bg.22391:
	load    [$i3 + 10], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22392
be.22392:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.22426
.count dual_jmp
	b       bg.22394
bne.22392:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.22426
bg.22394:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22426
bne.22395:
	load    [ext_and_net + $i1], $i3
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22396
be.22396:
	li      2, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22426
bne.22396:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22426
bne.22414:
	load    [ext_and_net + $i1], $i3
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22415:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22426
bne.22416:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22417:
	load    [$i10 + 3], $i1
	be      $i1, -1, be.22426
bne.22418:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22419:
	load    [$i10 + 4], $i1
	be      $i1, -1, be.22426
bne.22420:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22421:
	load    [$i10 + 5], $i1
	be      $i1, -1, be.22426
bne.22422:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22423:
	load    [$i10 + 6], $i1
	be      $i1, -1, be.22426
bne.22424:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22425:
	load    [$i10 + 7], $i1
	bne     $i1, -1, bne.22426
be.22426:
	li      0, $i1
	add     $i11, 1, $i11
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22429
.count dual_jmp
	b       bne.22429
bne.22426:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22427:
	li      8, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22410
be.22428:
	add     $i11, 1, $i11
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	bne     $i1, -1, bne.22429
be.22429:
	li      0, $i1
	jr      $ra3
bne.22429:
	be      $i1, 99, bne.22434
bne.22430:
	call    solver_fast.2796
	be      $i1, 0, be.22433
bne.22431:
	ble     $fc7, $fg0, be.22433
bg.22432:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22433
bne.22433:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22434
be.22434:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22433
bne.22435:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22434
be.22436:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22433
bne.22434:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22433
bne.22439:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22440:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22433
bne.22441:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22410
be.22442:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22410
be.22433:
	add     $i11, 1, $i11
	b       shadow_check_one_or_matrix.2868
bne.22410:
	li      1, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i8, $i3, $i9)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8, $i10 - $i11]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i8], $i10
	be      $i10, -1, be.22479
bne.22444:
	load    [ext_objects + $i10], $i1
	add     $i1, 7, $i2
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	fsub    $fg17, $f1, $f1
	load    [$i2 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i2 + 2], $f3
	fsub    $fg19, $f3, $f3
	load    [$i9 + 0], $f4
	bne     $i4, 1, bne.22445
be.22445:
	be      $f4, $f0, ble.22452
bne.22446:
	add     $i1, 4, $i2
	load    [$i1 + 10], $i4
	bg      $f0, $f4, bg.22447
ble.22447:
	li      0, $i5
	be      $i4, 0, be.22448
.count dual_jmp
	b       bne.22448
bg.22447:
	li      1, $i5
	bne     $i4, 0, bne.22448
be.22448:
	mov     $i5, $i4
	load    [$i2 + 0], $f5
	load    [$i9 + 1], $f6
	finv    $f4, $f4
	bne     $i4, 0, bne.22450
be.22450:
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22452
.count dual_jmp
	b       bg.22451
bne.22450:
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22452
.count dual_jmp
	b       bg.22451
bne.22448:
	load    [$i2 + 0], $f5
	load    [$i9 + 1], $f6
	finv    $f4, $f4
	bne     $i5, 0, bne.22449
be.22449:
	li      1, $i4
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22452
.count dual_jmp
	b       bg.22451
bne.22449:
	li      0, $i4
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22452
bg.22451:
	load    [$i2 + 2], $f5
	load    [$i9 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.22452
ble.22452:
	load    [$i9 + 1], $f4
	be      $f4, $f0, ble.22460
bne.22454:
	add     $i1, 4, $i2
	load    [$i1 + 10], $i4
	bg      $f0, $f4, bg.22455
ble.22455:
	li      0, $i5
	be      $i4, 0, be.22456
.count dual_jmp
	b       bne.22456
bg.22455:
	li      1, $i5
	bne     $i4, 0, bne.22456
be.22456:
	mov     $i5, $i4
	load    [$i2 + 1], $f5
	load    [$i9 + 2], $f6
	finv    $f4, $f4
	be      $i4, 0, bne.22457
.count dual_jmp
	b       be.22457
bne.22456:
	load    [$i2 + 1], $f5
	load    [$i9 + 2], $f6
	finv    $f4, $f4
	bne     $i5, 0, bne.22457
be.22457:
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22460
.count dual_jmp
	b       bg.22459
bne.22457:
	fneg    $f5, $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22460
bg.22459:
	load    [$i2 + 0], $f5
	load    [$i9 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.22460
ble.22460:
	load    [$i9 + 2], $f4
	be      $f4, $f0, ble.22476
bne.22462:
	add     $i1, 4, $i2
	load    [$i2 + 0], $f5
	load    [$i9 + 0], $f6
	load    [$i1 + 10], $i1
	bg      $f0, $f4, bg.22463
ble.22463:
	li      0, $i4
	be      $i1, 0, be.22464
.count dual_jmp
	b       bne.22464
bg.22463:
	li      1, $i4
	bne     $i1, 0, bne.22464
be.22464:
	mov     $i4, $i1
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i1, 0, bne.22466
be.22466:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
.count dual_jmp
	b       bg.22467
bne.22466:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
.count dual_jmp
	b       bg.22467
bne.22464:
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22465
be.22465:
	li      1, $i1
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
.count dual_jmp
	b       bg.22467
bne.22465:
	li      0, $i1
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22476
bg.22467:
	load    [$i2 + 1], $f1
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22476
bg.22468:
	mov     $f3, $fg0
	li      3, $i11
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bg.22460:
	mov     $f4, $fg0
	li      2, $i11
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bg.22452:
	mov     $f4, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bne.22445:
	bne     $i4, 2, bne.22469
be.22469:
	add     $i1, 4, $i1
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [$i9 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [$i9 + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	ble     $f4, $f0, ble.22476
bg.22470:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bne.22469:
	load    [$i1 + 3], $i2
	add     $i1, 4, $i5
	load    [$i9 + 1], $f5
	load    [$i9 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i5 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i5 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i5 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	bne     $i2, 0, bne.22471
be.22471:
	be      $f7, $f0, ble.22476
.count dual_jmp
	b       bne.22472
bne.22471:
	fmul    $f5, $f6, $f9
	add     $i1, 16, $i5
	load    [$i5 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f4, $f9
	load    [$i5 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f4, $f5, $f9
	load    [$i5 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	be      $f7, $f0, ble.22476
bne.22472:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, bne.22473
be.22473:
	mov     $f9, $f4
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	be      $i2, 0, be.22474
.count dual_jmp
	b       bne.22474
bne.22473:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	add     $i1, 16, $i5
	load    [$i5 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f4, $f3, $f13
	fmul    $f6, $f1, $f6
	fadd    $f13, $f6, $f6
	load    [$i5 + 1], $f13
	fmul    $f6, $f13, $f6
	fadd    $f12, $f6, $f6
	fmul    $f4, $f2, $f4
	fmul    $f5, $f1, $f5
	fadd    $f4, $f5, $f4
	load    [$i5 + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f6, $f4, $f4
	fmul    $f4, $fc4, $f4
	fadd    $f9, $f4, $f4
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i2, 0, bne.22474
be.22474:
	mov     $f6, $f1
	be      $i4, 3, be.22475
.count dual_jmp
	b       bne.22475
bne.22474:
	fmul    $f2, $f3, $f8
	add     $i1, 16, $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f1, $f3
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f6, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i4, 3, bne.22475
be.22475:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22476
.count dual_jmp
	b       bg.22476
bne.22475:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.22476
ble.22476:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22479
be.22479:
	jr      $ra1
bg.22476:
	load    [$i1 + 10], $i1
	fsqrt   $f1, $f1
	li      1, $i11
	finv    $f7, $f2
	bne     $i1, 0, bne.22477
be.22477:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22479
.count dual_jmp
	b       bg.22480
bne.22477:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22479
bg.22480:
	bg      $fg7, $fg0, bg.22481
bne.22479:
	add     $i8, 1, $i8
	b       solve_each_element.2871
bg.22481:
	li      0, $i1
	load    [$i9 + 0], $f1
	fadd    $fg0, $fc15, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg17, $f2
	load    [$i9 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg18, $f3
	load    [$i9 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg19, $f4
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element.2871
bne.22482:
	mov     $f10, $fg7
	store   $f2, [ext_intersection_point + 0]
	store   $f3, [ext_intersection_point + 1]
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig3
	mov     $i11, $ig2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i12, $i13, $i9)
# $ra = $ra2
# [$i1 - $i8, $i10 - $i12]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22483:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22484:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22485:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22486:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22487:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22488:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22490
bne.22489:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, bne.22490
be.22490:
	jr      $ra2
bne.22490:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i14, $i15, $i9)
# $ra = $ra3
# [$i1 - $i8, $i10 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22499
bne.22491:
	bne     $i1, 99, bne.22492
be.22492:
	load    [$i13 + 1], $i1
	be      $i1, -1, be.22498
bne.22493:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, be.22498
bne.22494:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, be.22498
bne.22495:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, be.22498
bne.22496:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 5], $i1
	be      $i1, -1, be.22498
bne.22497:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 6], $i1
	bne     $i1, -1, bne.22498
be.22498:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22499
.count dual_jmp
	b       bne.22499
bne.22498:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      7, $i12
	jal     solve_one_or_network.2875, $ra2
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22499
be.22499:
	jr      $ra3
bne.22499:
	bne     $i1, 99, bne.22492
be.22500:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22508
bne.22501:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22508
bne.22502:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22508
bne.22503:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22508
bne.22504:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      5, $i12
	jal     solve_one_or_network.2875, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix.2879
bne.22492:
.count move_args
	mov     $i9, $i2
	call    solver.2773
	be      $i1, 0, ble.22508
bne.22507:
	bg      $fg7, $fg0, bg.22508
ble.22508:
	add     $i14, 1, $i14
	b       trace_or_matrix.2879
bg.22508:
	li      1, $i12
	jal     solve_one_or_network.2875, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i8, $i3, $i9)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8, $i10 - $i11]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i8], $i10
	be      $i10, -1, be.22528
bne.22509:
	load    [ext_objects + $i10], $i1
	add     $i1, 19, $i2
	load    [$i9 + 3], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 2], $f3
	load    [$i4 + $i10], $i4
	bne     $i5, 1, bne.22510
be.22510:
	add     $i9, 0, $i2
	add     $i1, 4, $i1
	load    [$i1 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i4 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22513
bg.22511:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22513
bg.22512:
	load    [$i4 + 1], $f4
	bne     $f4, $f0, bne.22513
be.22513:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i4 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i4 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22517
bg.22515:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22517
bg.22516:
	load    [$i4 + 3], $f4
	bne     $f4, $f0, bne.22517
be.22517:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i4 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.22525
bg.22519:
	load    [$i1 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22525
bg.22520:
	load    [$i4 + 5], $f1
	be      $f1, $f0, ble.22525
bne.22521:
	mov     $f3, $fg0
	li      3, $i11
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22517:
	mov     $f6, $fg0
	li      2, $i11
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22513:
	mov     $f6, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22510:
	bne     $i5, 2, bne.22522
be.22522:
	load    [$i4 + 0], $f1
	ble     $f0, $f1, ble.22525
bg.22523:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22522:
	load    [$i4 + 0], $f4
	be      $f4, $f0, ble.22525
bne.22524:
	load    [$i4 + 1], $f5
	fmul    $f5, $f1, $f1
	load    [$i4 + 2], $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i4 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	load    [$i2 + 3], $f3
	fmul    $f4, $f3, $f3
	fsub    $f2, $f3, $f2
	bg      $f2, $f0, bg.22525
ble.22525:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 10], $i1
	bne     $i1, 0, bne.22528
be.22528:
	jr      $ra1
bg.22525:
	load    [$i1 + 10], $i1
	li      1, $i11
	fsqrt   $f2, $f2
	bne     $i1, 0, bne.22526
be.22526:
	fsub    $f1, $f2, $f1
	load    [$i4 + 4], $f2
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22528
.count dual_jmp
	b       bg.22529
bne.22526:
	fadd    $f1, $f2, $f1
	load    [$i4 + 4], $f2
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22528
bg.22529:
	bg      $fg7, $fg0, bg.22530
bne.22528:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
bg.22530:
	add     $i9, 0, $i1
	li      0, $i2
	load    [$i1 + 0], $f1
	fadd    $fg0, $fc15, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg8, $f2
	load    [$i1 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg9, $f3
	load    [$i1 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg10, $f4
.count move_args
	mov     $i2, $i1
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element_fast.2885
bne.22531:
	mov     $f10, $fg7
	store   $f2, [ext_intersection_point + 0]
	store   $f3, [ext_intersection_point + 1]
	store   $f4, [ext_intersection_point + 2]
	mov     $i10, $ig3
	mov     $i11, $ig2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i12, $i13, $i9)
# $ra = $ra2
# [$i1 - $i8, $i10 - $i12]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22532:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22533:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22534:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22535:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22536:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22537:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22539
bne.22538:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, bne.22539
be.22539:
	jr      $ra2
bne.22539:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i14, $i15, $i9)
# $ra = $ra3
# [$i1 - $i8, $i10 - $i14]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22548
bne.22540:
	bne     $i1, 99, bne.22541
be.22541:
	load    [$i13 + 1], $i1
	be      $i1, -1, be.22547
bne.22542:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, be.22547
bne.22543:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, be.22547
bne.22544:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, be.22547
bne.22545:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 5], $i1
	be      $i1, -1, be.22547
bne.22546:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 6], $i1
	bne     $i1, -1, bne.22547
be.22547:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22548
.count dual_jmp
	b       bne.22548
bne.22547:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22548
be.22548:
	jr      $ra3
bne.22548:
	bne     $i1, 99, bne.22541
be.22549:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22557
bne.22550:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22557
bne.22551:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22557
bne.22552:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22557
bne.22553:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
bne.22541:
.count move_args
	mov     $i9, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22557
bne.22556:
	bg      $fg7, $fg0, bg.22557
ble.22557:
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
bg.22557:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.begin utexture
utexture.2908:
	add     $i1, 13, $i2
	load    [$i2 + 0], $fg16
	load    [$i2 + 1], $fg11
	load    [$i2 + 2], $fg15
	load    [$i1 + 0], $i2
	bne     $i2, 1, bne.22558
be.22558:
	add     $i1, 7, $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + 0], $f2
.count load_float
	load    [f.21994], $f4
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.21995], $f6
.count load_float
	load    [f.21996], $f7
	fmul    $f1, $f6, $f1
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 2], $f1
	load    [$i1 + 2], $f2
	fsub    $f1, $f2, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	bg      $f7, $f5, bg.22559
ble.22559:
	li      0, $i1
	ble     $f7, $f1, ble.22560
.count dual_jmp
	b       bg.22560
bg.22559:
	li      1, $i1
	bg      $f7, $f1, bg.22560
ble.22560:
	be      $i1, 0, bne.22562
.count dual_jmp
	b       be.22562
bg.22560:
	bne     $i1, 0, bne.22562
be.22562:
	mov     $f0, $fg11
	jr      $ra1
bne.22562:
	mov     $fc8, $fg11
	jr      $ra1
bne.22558:
	bne     $i2, 2, bne.22563
be.22563:
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.21993], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc8, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc8, $f1, $fg11
	jr      $ra1
bne.22563:
	bne     $i2, 3, bne.22564
be.22564:
	add     $i1, 7, $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + 0], $f2
	fsub    $f1, $f2, $f1
	fmul    $f1, $f1, $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i1 + 2], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc9, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc14, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc8, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc8, $fg15
	jr      $ra1
bne.22564:
	bne     $i2, 4, bne.22565
be.22565:
	add     $i1, 7, $i3
	add     $i1, 4, $i1
.count load_float
	load    [f.21983], $f6
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [$i1 + 0], $f2
	fsqrt   $f2, $f2
	fmul    $f1, $f2, $f7
	fabs    $f7, $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i3 + 2], $f3
	fsub    $f2, $f3, $f2
	load    [$i1 + 2], $f3
	fsqrt   $f3, $f3
	fmul    $f2, $f3, $f8
	bg      $f6, $f1, bg.22566
ble.22566:
	finv    $f7, $f1
	fmul_a  $f8, $f1, $f2
	call    ext_atan
	fmul    $fc17, $f1, $f9
	fmul    $f7, $f7, $f1
	fmul    $f8, $f8, $f2
	fadd    $f1, $f2, $f1
	fabs    $f1, $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i3 + 1], $f4
	fsub    $f3, $f4, $f3
	load    [$i1 + 1], $f4
	fsqrt   $f4, $f4
	fmul    $f3, $f4, $f3
	ble     $f6, $f2, ble.22567
.count dual_jmp
	b       bg.22567
bg.22566:
.count load_float
	load    [f.21984], $f9
	fmul    $f7, $f7, $f1
	fmul    $f8, $f8, $f2
	fadd    $f1, $f2, $f1
	fabs    $f1, $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i3 + 1], $f4
	fsub    $f3, $f4, $f3
	load    [$i1 + 1], $f4
	fsqrt   $f4, $f4
	fmul    $f3, $f4, $f3
	bg      $f6, $f2, bg.22567
ble.22567:
	finv    $f1, $f1
	fmul_a  $f3, $f1, $f2
	call    ext_atan
	fmul    $fc17, $f1, $f4
.count load_float
	load    [f.21989], $f5
.count move_args
	mov     $f9, $f2
	call    ext_floor
	fsub    $f9, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f5
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f0, $f1, ble.22568
.count dual_jmp
	b       bg.22568
bg.22567:
.count load_float
	load    [f.21984], $f4
.count load_float
	load    [f.21989], $f5
.count move_args
	mov     $f9, $f2
	call    ext_floor
	fsub    $f9, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f5
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f0, $f1, bg.22568
ble.22568:
.count load_float
	load    [f.21990], $f2
	fmul    $f2, $f1, $fg15
	jr      $ra1
bg.22568:
	mov     $f0, $fg15
	jr      $ra1
bne.22565:
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i16, $f11, $f12, $i17)
# $ra = $ra4
# [$i1 - $i16, $i18 - $i19]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i16, 0, bl.22569
bge.22569:
	load    [ext_reflections + $i16], $i18
	add     $i18, 1, $i19
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22570
be.22570:
	ble     $fg7, $fc7, bne.22581
.count dual_jmp
	b       bg.22578
bne.22570:
	bne     $i1, 99, bne.22571
be.22571:
	load    [$i13 + 1], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22577
bne.22572:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22577
bne.22573:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22577
bne.22574:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22577
bne.22575:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i12
.count move_args
	mov     $i19, $i9
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i19, $i9
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22581
.count dual_jmp
	b       bg.22578
bne.22571:
.count move_args
	mov     $i19, $i2
	call    solver_fast2.2814
.count move_args
	mov     $i19, $i9
	be      $i1, 0, ble.22577
bne.22576:
	bg      $fg7, $fg0, bg.22577
ble.22577:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22581
.count dual_jmp
	b       bg.22578
bg.22577:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i19, $i9
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22581
bg.22578:
	ble     $fc12, $fg7, bne.22581
bg.22579:
	li      1, $i1
	load    [$i18 + 0], $i1
	add     $ig3, $ig3, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, bne.22581
be.22581:
	li      0, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22581
be.22582:
	load    [$i18 + 5], $f1
	add     $i19, 0, $i1
	fmul    $f1, $f11, $f2
	load    [ext_nvector + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f3, $f4, $f3
	load    [ext_nvector + 1], $f5
	load    [$i1 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f3, $f5, $f3
	load    [ext_nvector + 2], $f5
	load    [$i1 + 2], $f7
	fmul    $f5, $f7, $f5
	fadd    $f3, $f5, $f3
	fmul    $f2, $f3, $f2
	bg      $f2, $f0, bg.22583
ble.22583:
	load    [$i17 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i17 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22581
.count dual_jmp
	b       bg.22584
bg.22583:
	fmul    $f2, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f2, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f2, $fg15, $f2
	fadd    $fg6, $f2, $fg6
	load    [$i17 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i17 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	bg      $f1, $f0, bg.22584
bne.22581:
	add     $i16, -1, $i16
	b       trace_reflections.2915
bg.22584:
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f12, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	add     $i16, -1, $i16
	b       trace_reflections.2915
bl.22569:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i20, $f14, $i17, $i21, $f15)
# $ra = $ra5
# [$i1 - $i16, $i18 - $i20, $i22 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i20, 4, bg.22585
ble.22585:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22586
be.22586:
	add     $i21, 8, $i22
	ble     $fg7, $fc7, ble.22595
.count dual_jmp
	b       bg.22594
bne.22586:
	bne     $i1, 99, bne.22587
be.22587:
	load    [$i13 + 1], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22593
bne.22588:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22593
bne.22589:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22593
bne.22590:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22593
bne.22591:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      5, $i12
.count move_args
	mov     $i17, $i9
	jal     solve_one_or_network.2875, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i17, $i9
	jal     trace_or_matrix.2879, $ra3
	add     $i21, 8, $i22
	ble     $fg7, $fc7, ble.22595
.count dual_jmp
	b       bg.22594
bne.22587:
.count move_args
	mov     $i17, $i2
	call    solver.2773
.count move_args
	mov     $i17, $i9
	be      $i1, 0, ble.22593
bne.22592:
	bg      $fg7, $fg0, bg.22593
ble.22593:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix.2879, $ra3
	add     $i21, 8, $i22
	ble     $fg7, $fc7, ble.22595
.count dual_jmp
	b       bg.22594
bg.22593:
	li      1, $i12
	jal     solve_one_or_network.2875, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i17, $i9
	jal     trace_or_matrix.2879, $ra3
	add     $i21, 8, $i22
	ble     $fg7, $fc7, ble.22595
bg.22594:
	bg      $fc12, $fg7, bg.22595
ble.22595:
	add     $i0, -1, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	be      $i20, 0, bg.22585
bne.22597:
	load    [$i17 + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [$i17 + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [$i17 + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	ble     $f1, $f0, bg.22585
bg.22598:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f14, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
bg.22595:
	li      1, $i1
	load    [ext_objects + $ig3], $i23
	load    [$i23 + 1], $i1
	bne     $i1, 1, bne.22599
be.22599:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i1
	load    [$i17 + $i1], $f1
	bne     $f1, $f0, bne.22600
be.22600:
	store   $f0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22600:
	bg      $f1, $f0, bg.22601
ble.22601:
	store   $fc0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bg.22601:
	store   $fc3, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22599:
	bne     $i1, 2, bne.22602
be.22602:
	add     $i23, 4, $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22602:
	load    [$i23 + 3], $i1
	add     $i23, 4, $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	add     $i23, 7, $i3
	load    [$i3 + 0], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	load    [$i2 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i3 + 1], $f5
	fsub    $f4, $f5, $f4
	fmul    $f4, $f3, $f3
	load    [$i2 + 2], $f5
	load    [ext_intersection_point + 2], $f6
	load    [$i3 + 2], $f7
	fsub    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	bne     $i1, 0, bne.22603
be.22603:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i23 + 10], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22604
.count dual_jmp
	b       bne.22604
bne.22603:
	add     $i23, 16, $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i23 + 10], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22604
be.22604:
	mov     $fc0, $f2
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
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
bne.22604:
	bne     $i1, 0, bne.22605
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
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22606
.count dual_jmp
	b       bg.22606
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
.count move_args
	mov     $i23, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	add     $i21, 3, $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i23, 11, $i24
	add     $i21, 13, $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	bg      $fc4, $f1, bg.22606
ble.22606:
	li      1, $i2
.count storer
	add     $i1, $i20, $tmp
	store   $i2, [$tmp + 0]
	add     $i21, 18, $i1
	load    [$i1 + $i20], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg15, [$i2 + 2]
	load    [$i1 + $i20], $i1
.count load_float
	load    [f.21999], $f1
.count load_float
	load    [f.22000], $f1
	fmul    $f1, $f11, $f1
	load    [$i1 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i1 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i1 + 2]
	add     $i21, 29, $i1
	load    [$i1 + $i20], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.22001], $f2
	load    [$i17 + 0], $f3
	fmul    $f3, $f1, $f4
	load    [$i17 + 1], $f5
	load    [ext_nvector + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    [$i17 + 2], $f5
	load    [ext_nvector + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 0]
	load    [$i17 + 1], $f1
	load    [ext_nvector + 1], $f3
	fmul    $f2, $f3, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i17 + 1]
	load    [$i17 + 2], $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i17 + 2]
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22607
.count dual_jmp
	b       bne.22607
bg.22606:
	li      0, $i2
.count storer
	add     $i1, $i20, $tmp
	store   $i2, [$tmp + 0]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.22001], $f2
	load    [$i17 + 0], $f3
	fmul    $f3, $f1, $f4
	load    [$i17 + 1], $f5
	load    [ext_nvector + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    [$i17 + 2], $f5
	load    [ext_nvector + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i17 + 0]
	load    [$i17 + 1], $f1
	load    [ext_nvector + 1], $f3
	fmul    $f2, $f3, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i17 + 1]
	load    [$i17 + 2], $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i17 + 2]
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	bne     $i1, -1, bne.22607
be.22607:
	load    [$i24 + 1], $f1
	fmul    $f14, $f1, $f12
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f11, $f1
	load    [$i17 + 0], $f2
	fmul    $f2, $fg14, $f2
	load    [$i17 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, ble.22623
.count dual_jmp
	b       bg.22623
bne.22607:
	be      $i1, 99, bne.22612
bne.22608:
	call    solver_fast.2796
	be      $i1, 0, be.22621
bne.22609:
	ble     $fc7, $fg0, be.22621
bg.22610:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22621
bne.22611:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22612
be.22612:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22621
bne.22613:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22612
be.22614:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22621
bne.22612:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22621
bne.22617:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22618
be.22618:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22621
bne.22619:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22618
be.22620:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22618
be.22621:
	li      1, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i24 + 1], $f1
	fmul    $f14, $f1, $f12
	bne     $i1, 0, bne.22622
be.22622:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f11, $f1
	load    [$i17 + 0], $f2
	fmul    $f2, $fg14, $f2
	load    [$i17 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	bg      $f1, $f0, bg.22623
ble.22623:
	ble     $f2, $f0, bne.22622
.count dual_jmp
	b       bg.22624
bg.22623:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg15, $f1
	fadd    $fg6, $f1, $fg6
	bg      $f2, $f0, bg.22624
bne.22622:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i16
	jal     trace_reflections.2915, $ra4
	ble     $f14, $fc9, bg.22585
.count dual_jmp
	b       bg.22625
bg.22624:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f12, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i16
	jal     trace_reflections.2915, $ra4
	ble     $f14, $fc9, bg.22585
.count dual_jmp
	b       bg.22625
bne.22618:
	load    [$i24 + 1], $f1
	fmul    $f14, $f1, $f12
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i16
	jal     trace_reflections.2915, $ra4
	ble     $f14, $fc9, bg.22585
bg.22625:
	bl      $i20, 4, bl.22626
bge.22626:
	load    [$i23 + 2], $i1
	be      $i1, 2, be.22627
.count dual_jmp
	b       bg.22585
bl.22626:
	add     $i20, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i22, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i23 + 2], $i1
	bne     $i1, 2, bg.22585
be.22627:
	fadd    $f15, $fg7, $f15
	add     $i20, 1, $i20
	load    [$i24 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f14, $f1, $f14
	b       trace_ray.2920
bg.22585:
	jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i9, $f11)
# $ra = $ra4
# [$i1 - $i15]
# [$f1 - $f10]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22628
be.22628:
	ble     $fg7, $fc7, bne.22657
.count dual_jmp
	b       bg.22636
bne.22628:
	bne     $i1, 99, bne.22629
be.22629:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22635
bne.22630:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22635
bne.22631:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22635
bne.22632:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22635
bne.22633:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22657
.count dual_jmp
	b       bg.22636
bne.22629:
.count move_args
	mov     $i9, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22635
bne.22634:
	bg      $fg7, $fg0, bg.22635
ble.22635:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22657
.count dual_jmp
	b       bg.22636
bg.22635:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22657
bg.22636:
	ble     $fc12, $fg7, bne.22657
bg.22637:
	add     $i9, 0, $i1
	load    [ext_objects + $ig3], $i13
	load    [$i13 + 1], $i2
	bne     $i2, 1, bne.22639
be.22639:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i2
	load    [$i1 + $i2], $f1
.count move_args
	mov     $i13, $i1
	bne     $f1, $f0, bne.22640
be.22640:
	store   $f0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22640:
	bg      $f1, $f0, bg.22641
ble.22641:
	store   $fc0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bg.22641:
	store   $fc3, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22639:
	bne     $i2, 2, bne.22642
be.22642:
	add     $i13, 4, $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
.count move_args
	mov     $i13, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22642:
	load    [$i13 + 3], $i1
	add     $i13, 4, $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	add     $i13, 7, $i3
	load    [$i3 + 0], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	load    [$i2 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i3 + 1], $f5
	fsub    $f4, $f5, $f4
	fmul    $f4, $f3, $f3
	load    [$i2 + 2], $f5
	load    [ext_intersection_point + 2], $f6
	load    [$i3 + 2], $f7
	fsub    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	bne     $i1, 0, bne.22643
be.22643:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i13 + 10], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22644
.count dual_jmp
	b       bne.22644
bne.22643:
	add     $i13, 16, $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i13 + 10], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22644
be.22644:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
.count move_args
	mov     $i13, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
bne.22644:
	bne     $i1, 0, bne.22645
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
.count move_args
	mov     $i13, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
.count dual_jmp
	b       bne.22646
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
.count move_args
	mov     $i13, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22661
bne.22646:
	be      $i1, 99, bne.22651
bne.22647:
	call    solver_fast.2796
	be      $i1, 0, be.22660
bne.22648:
	ble     $fc7, $fg0, be.22660
bg.22649:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22660
bne.22650:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22651
be.22651:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22660
bne.22652:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22651
be.22653:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22660
bne.22651:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22660
bne.22656:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22657
be.22657:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22660
bne.22658:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22657
be.22659:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22657
be.22660:
	li      1, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22657
be.22661:
	add     $i13, 11, $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	load    [$i1 + 0], $f2
	bg      $f1, $f0, bg.22662
ble.22662:
	mov     $f0, $f1
	fmul    $f11, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bg.22662:
	fmul    $f11, $f1, $f1
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bne.22657:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i16, $i17, $i18)
# $ra = $ra5
# [$i1 - $i15, $i18]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i18, 0, bl.22663
bge.22663:
	load    [$i16 + $i18], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22664
ble.22664:
	fmul    $f1, $fc1, $f11
	load    [$i16 + $i18], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	bge     $i18, 0, bge.22667
.count dual_jmp
	b       bl.22663
bg.22664:
	fmul    $f1, $fc2, $f11
	add     $i18, 1, $i1
	load    [$i16 + $i1], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	bl      $i18, 0, bl.22663
bge.22667:
	load    [$i16 + $i18], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22668
ble.22668:
	fmul    $f1, $fc1, $f11
	load    [$i16 + $i18], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	b       iter_trace_diffuse_rays.2929
bg.22668:
	fmul    $f1, $fc2, $f11
	add     $i18, 1, $i1
	load    [$i16 + $i1], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	b       iter_trace_diffuse_rays.2929
bl.22663:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i19, $i20)
# $ra = $ra6
# [$i1 - $i18, $i21 - $i22]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	add     $i19, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i19, 29, $i1
	add     $i19, 3, $i2
	add     $i19, 28, $i3
	load    [$i1 + $i20], $i17
	load    [$i2 + $i20], $i21
	load    [$i3 + 0], $i22
	bne     $i22, 0, bne.22669
be.22669:
	be      $i22, 1, be.22671
.count dual_jmp
	b       bne.22671
bne.22669:
	load    [ext_dirvecs + 0], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22670
ble.22670:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 1, be.22671
.count dual_jmp
	b       bne.22671
bg.22670:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 1, bne.22671
be.22671:
	be      $i22, 2, be.22673
.count dual_jmp
	b       bne.22673
bne.22671:
	load    [ext_dirvecs + 1], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22672
ble.22672:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 2, be.22673
.count dual_jmp
	b       bne.22673
bg.22672:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 2, bne.22673
be.22673:
	be      $i22, 3, be.22675
.count dual_jmp
	b       bne.22675
bne.22673:
	load    [ext_dirvecs + 2], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22674
ble.22674:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 3, be.22675
.count dual_jmp
	b       bne.22675
bg.22674:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 3, bne.22675
be.22675:
	be      $i22, 4, be.22677
.count dual_jmp
	b       bne.22677
bne.22675:
	load    [ext_dirvecs + 3], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22676
ble.22676:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 4, be.22677
.count dual_jmp
	b       bne.22677
bg.22676:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 4, bne.22677
be.22677:
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	jr      $ra6
bne.22677:
	load    [ext_dirvecs + 4], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22678
ble.22678:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	jr      $ra6
bg.22678:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	jr      $ra6
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i19, $i20)
# $ra = $ra7
# [$i1 - $i18, $i20 - $i24]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i20, 4, bg.22679
ble.22679:
	add     $i19, 8, $i21
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22679
bge.22680:
	add     $i19, 13, $i22
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22681
be.22681:
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22695
.count dual_jmp
	b       bg.22679
bne.22681:
	add     $i19, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i19, 29, $i1
	add     $i19, 3, $i2
	add     $i19, 28, $i3
	load    [$i1 + $i20], $i17
	load    [$i2 + $i20], $i23
	load    [$i3 + 0], $i24
	bne     $i24, 0, bne.22685
be.22685:
	be      $i24, 1, be.22687
.count dual_jmp
	b       bne.22687
bne.22685:
	load    [ext_dirvecs + 0], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22686
ble.22686:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 1, be.22687
.count dual_jmp
	b       bne.22687
bg.22686:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 1, bne.22687
be.22687:
	be      $i24, 2, be.22689
.count dual_jmp
	b       bne.22689
bne.22687:
	load    [ext_dirvecs + 1], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22688
ble.22688:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 2, be.22689
.count dual_jmp
	b       bne.22689
bg.22688:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 2, bne.22689
be.22689:
	be      $i24, 3, be.22691
.count dual_jmp
	b       bne.22691
bne.22689:
	load    [ext_dirvecs + 2], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22690
ble.22690:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 3, be.22691
.count dual_jmp
	b       bne.22691
bg.22690:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 3, bne.22691
be.22691:
	be      $i24, 4, be.22693
.count dual_jmp
	b       bne.22693
bne.22691:
	load    [ext_dirvecs + 3], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22692
ble.22692:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 4, be.22693
.count dual_jmp
	b       bne.22693
bg.22692:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 4, bne.22693
be.22693:
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22695
.count dual_jmp
	b       bg.22679
bne.22693:
	load    [ext_dirvecs + 4], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22694
ble.22694:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22695
.count dual_jmp
	b       bg.22679
bg.22694:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i20, 1, $i20
	bg      $i20, 4, bg.22679
ble.22695:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22679
bge.22696:
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22697
be.22697:
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bne.22697:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bg.22679:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i20)
# $ra = $ra7
# [$i1 - $i24]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i20, 4, bg.22698
ble.22698:
	load    [$i4 + $i2], $i1
	add     $i1, 8, $i6
	load    [$i6 + $i20], $i6
	bl      $i6, 0, bg.22698
bge.22699:
	load    [$i3 + $i2], $i7
	add     $i7, 8, $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22700
be.22700:
	load    [$i5 + $i2], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22700
be.22701:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22700
be.22702:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	add     $i8, 8, $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22700
be.22703:
	add     $i1, 13, $i1
	load    [$i1 + $i20], $i1
	bne     $i1, 0, bne.22708
be.22708:
	add     $i20, 1, $i20
	b       try_exploit_neighbors.2967
bne.22708:
	add     $i7, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i2, -1, $i1
	load    [$i4 + $i1], $i1
	add     $i1, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	add     $i1, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	add     $i1, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i1
	add     $i1, 23, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	add     $i1, 18, $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i20, 1, $i20
	b       try_exploit_neighbors.2967
bne.22700:
	bg      $i20, 4, bg.22698
ble.22705:
	load    [$i4 + $i2], $i19
	add     $i19, 8, $i1
	load    [$i1 + $i20], $i1
	bl      $i1, 0, bg.22698
bge.22706:
	add     $i19, 13, $i1
	load    [$i1 + $i20], $i1
	bne     $i1, 0, bne.22707
be.22707:
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bne.22707:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bg.22698:
	jr      $ra7
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
	bl      $i1, 0, bl.22712
bge.22712:
.count move_args
	mov     $i1, $i2
	b       ext_write
bl.22712:
	li      0, $i2
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
# pretrace_diffuse_rays($i19, $i20)
# $ra = $ra6
# [$i1 - $i18, $i20 - $i26]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i20, 4, bg.22715
ble.22715:
	add     $i19, 8, $i21
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22715
bge.22716:
	add     $i19, 13, $i22
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22717
be.22717:
	add     $i20, 1, $i20
	bg      $i20, 4, bg.22715
ble.22718:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22715
bge.22719:
	load    [$i22 + $i20], $i1
	be      $i1, 0, be.22725
bne.22720:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	add     $i19, 28, $i8
	add     $i19, 29, $i9
	add     $i19, 3, $i1
	load    [$i1 + $i20], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i8 + 0], $i1
	load    [ext_dirvecs + $i1], $i16
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i9 + $i20], $i17
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22721
ble.22721:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i1
	load    [$i1 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bg.22721:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i1
	load    [$i1 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bne.22717:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	add     $i19, 28, $i23
	add     $i19, 29, $i24
	add     $i19, 3, $i25
	load    [$i25 + $i20], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i23 + 0], $i1
	load    [ext_dirvecs + $i1], $i16
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i24 + $i20], $i17
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22722
ble.22722:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i26
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22723
.count dual_jmp
	b       bg.22715
bg.22722:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i26
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	bg      $i20, 4, bg.22715
ble.22723:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22715
bge.22724:
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22725
be.22725:
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bne.22725:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + $i20], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i23 + 0], $i1
	load    [ext_dirvecs + $i1], $i16
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i24 + $i20], $i17
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22726
ble.22726:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bg.22726:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bg.22715:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i27, $i28, $i29, $f16, $f17, $f18)
# $ra = $ra7
# [$i1 - $i26, $i28 - $i29]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i28, 0, bl.22727
bge.22727:
	add     $i28, -64, $i2
	call    ext_float_of_int
	load    [ext_screenx_dir + 0], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $f16, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	store   $f17, [ext_ptrace_dirvec + 1]
	load    [ext_screenx_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $f18, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_ptrace_dirvec + 0], $f1
	fmul    $f1, $f1, $f2
	load    [ext_ptrace_dirvec + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_ptrace_dirvec + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
.count move_args
	mov     $f0, $f15
.count move_args
	mov     $fc0, $f14
	li      0, $i20
	li      ext_ptrace_dirvec, $i17
	mov     $f0, $fg6
	mov     $f0, $fg5
	mov     $f0, $fg4
	bne     $f2, $f0, bne.22728
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
	load    [$i27 + $i28], $i21
	jal     trace_ray.2920, $ra5
	load    [$i27 + $i28], $i1
	add     $i1, 0, $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i27 + $i28], $i1
	add     $i1, 28, $i1
	store   $i29, [$i1 + 0]
	load    [$i27 + $i28], $i19
	add     $i19, 8, $i1
	load    [$i1 + 0], $i1
	bge     $i1, 0, bge.22729
.count dual_jmp
	b       bl.22729
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
	load    [$i27 + $i28], $i21
	jal     trace_ray.2920, $ra5
	load    [$i27 + $i28], $i1
	add     $i1, 0, $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i27 + $i28], $i1
	add     $i1, 28, $i1
	store   $i29, [$i1 + 0]
	load    [$i27 + $i28], $i19
	add     $i19, 8, $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22729
bge.22729:
	add     $i19, 13, $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22730
be.22730:
	li      1, $i20
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
.count dual_jmp
	b       bge.22732
bne.22730:
	add     $i19, 28, $i1
	load    [$i1 + 0], $i1
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	add     $i19, 29, $i2
	add     $i19, 3, $i3
	load    [ext_dirvecs + $i1], $i16
	load    [$i2 + 0], $i17
	load    [$i3 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $f1
	load    [$i17 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i17 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i17 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22731
ble.22731:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i20
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
.count dual_jmp
	b       bge.22732
bg.22731:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	add     $i19, 23, $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i20
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
.count dual_jmp
	b       bge.22732
bl.22729:
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
bge.22732:
	add     $i29, -5, $i29
	b       pretrace_pixels.2983
bl.22727:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i25, $i26, $i27, $i28, $i29)
# $ra = $ra8
# [$i1 - $i25]
# [$f1 - $f11]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i25, bg.22733
ble.22733:
	jr      $ra8
bg.22733:
	load    [$i28 + $i25], $i1
	add     $i1, 0, $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i26, 1, $i2
	ble     $i1, $i2, ble.22737
bg.22734:
	ble     $i26, 0, ble.22737
bg.22735:
	li      128, $i1
	add     $i25, 1, $i2
	ble     $i1, $i2, ble.22737
bg.22736:
	bg      $i25, 0, bg.22737
ble.22737:
	load    [$i28 + $i25], $i19
	add     $i19, 8, $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22741
bge.22739:
	add     $i19, 13, $i1
	load    [$i1 + 0], $i1
	be      $i1, 0, be.22748
bne.22740:
	li      0, $i20
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bg.22737:
	li      1, $i1
	load    [$i28 + $i25], $i1
	add     $i1, 8, $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bl.22741
bge.22741:
	li      0, $i20
	load    [$i27 + $i25], $i3
	add     $i3, 8, $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22742
be.22742:
	load    [$i29 + $i25], $i4
	add     $i4, 8, $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22742
be.22743:
	add     $i25, -1, $i4
	load    [$i28 + $i4], $i4
	add     $i4, 8, $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22742
be.22744:
	add     $i25, 1, $i4
	load    [$i28 + $i4], $i4
	add     $i4, 8, $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22742
be.22745:
	add     $i1, 13, $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i29, $i5
.count move_args
	mov     $i28, $i4
.count move_args
	mov     $i25, $i2
	li      1, $i20
	bne     $i1, 0, bne.22749
be.22749:
.count move_args
	mov     $i27, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bne.22749:
	add     $i3, 23, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i25, -1, $i1
	load    [$i28 + $i1], $i1
	add     $i1, 23, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i28 + $i25], $i1
	add     $i1, 23, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i25, 1, $i1
	load    [$i28 + $i1], $i1
	add     $i1, 23, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i29 + $i25], $i1
	add     $i1, 23, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i28 + $i25], $i1
	add     $i1, 18, $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
.count move_args
	mov     $i27, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bne.22742:
	load    [$i28 + $i25], $i19
	add     $i19, 8, $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22741
bge.22747:
	add     $i19, 13, $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22748
be.22748:
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bne.22748:
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bl.22741:
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i30, $i31, $i32, $i33, $i34)
# $ra = $ra9
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i30, bg.22750
ble.22750:
	jr      $ra9
bg.22750:
	bl      $i30, 127, bl.22751
bge.22751:
	li      0, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
.count move_args
	mov     $i32, $i28
.count move_args
	mov     $i33, $i29
	jal     scan_pixel.2994, $ra8
	add     $i30, 1, $i30
	add     $i34, 2, $i34
	bge     $i34, 5, bge.22752
.count dual_jmp
	b       bl.22752
bl.22751:
	add     $i30, 1, $i1
	add     $i1, -64, $i2
	call    ext_float_of_int
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f16
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f17
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f18
	li      127, $i28
.count move_args
	mov     $i33, $i27
.count move_args
	mov     $i34, $i29
	jal     pretrace_pixels.2983, $ra7
	li      0, $i25
.count move_args
	mov     $i30, $i26
.count move_args
	mov     $i31, $i27
.count move_args
	mov     $i32, $i28
.count move_args
	mov     $i33, $i29
	jal     scan_pixel.2994, $ra8
	add     $i30, 1, $i30
	add     $i34, 2, $i34
	bl      $i34, 5, bl.22752
bge.22752:
	add     $i34, -5, $i34
.count move_args
	mov     $i31, $tmp
.count move_args
	mov     $i32, $i31
.count move_args
	mov     $i33, $i32
.count move_args
	mov     $tmp, $i33
	b       scan_line.3000
bl.22752:
.count move_args
	mov     $i31, $tmp
.count move_args
	mov     $i32, $i31
.count move_args
	mov     $i33, $i32
.count move_args
	mov     $tmp, $i33
	b       scan_line.3000
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
	li      3, $i2
.count move_args
	mov     $f0, $f2
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
	mov     $hp, $i2
	add     $hp, 34, $hp
	load    [$i5 + 0], $i3
	store   $i3, [$i2 + 0]
	load    [$i5 + 1], $i3
	store   $i3, [$i2 + 1]
	load    [$i5 + 2], $i3
	store   $i3, [$i2 + 2]
	load    [$i6 + 0], $i3
	store   $i3, [$i2 + 3]
	load    [$i6 + 1], $i3
	store   $i3, [$i2 + 4]
	load    [$i6 + 2], $i3
	store   $i3, [$i2 + 5]
	load    [$i6 + 3], $i3
	store   $i3, [$i2 + 6]
	load    [$i6 + 4], $i3
	store   $i3, [$i2 + 7]
	load    [$i7 + 0], $i3
	store   $i3, [$i2 + 8]
	load    [$i7 + 1], $i3
	store   $i3, [$i2 + 9]
	load    [$i7 + 2], $i3
	store   $i3, [$i2 + 10]
	load    [$i7 + 3], $i3
	store   $i3, [$i2 + 11]
	load    [$i7 + 4], $i3
	store   $i3, [$i2 + 12]
	load    [$i8 + 0], $i3
	store   $i3, [$i2 + 13]
	load    [$i8 + 1], $i3
	store   $i3, [$i2 + 14]
	load    [$i8 + 2], $i3
	store   $i3, [$i2 + 15]
	load    [$i8 + 3], $i3
	store   $i3, [$i2 + 16]
	load    [$i8 + 4], $i3
	store   $i3, [$i2 + 17]
	load    [$i9 + 0], $i3
	store   $i3, [$i2 + 18]
	load    [$i9 + 1], $i3
	store   $i3, [$i2 + 19]
	load    [$i9 + 2], $i3
	store   $i3, [$i2 + 20]
	load    [$i9 + 3], $i3
	store   $i3, [$i2 + 21]
	load    [$i9 + 4], $i3
	store   $i3, [$i2 + 22]
	load    [$i10 + 0], $i3
	store   $i3, [$i2 + 23]
	load    [$i10 + 1], $i3
	store   $i3, [$i2 + 24]
	load    [$i10 + 2], $i3
	store   $i3, [$i2 + 25]
	load    [$i10 + 3], $i3
	store   $i3, [$i2 + 26]
	load    [$i10 + 4], $i3
	store   $i3, [$i2 + 27]
	load    [$i11 + 0], $i3
	store   $i3, [$i2 + 28]
	load    [$i1 + 0], $i3
	store   $i3, [$i2 + 29]
	load    [$i1 + 1], $i3
	store   $i3, [$i2 + 30]
	load    [$i1 + 2], $i3
	store   $i3, [$i2 + 31]
	load    [$i1 + 3], $i3
	store   $i3, [$i2 + 32]
	load    [$i1 + 4], $i1
	store   $i1, [$i2 + 33]
	mov     $i2, $i1
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
.begin init_line_elements
init_line_elements.3010:
	bl      $i13, 0, bl.22753
bge.22753:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	add     $i13, -1, $i13
	b       init_line_elements.3010
bl.22753:
	mov     $i12, $i1
	jr      $ra3
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
# calc_dirvec($i1, $f1, $f2, $f7, $f8, $i3, $i4)
# $ra = $ra1
# [$i1 - $i2]
# [$f1 - $f6, $f9 - $f12]
# []
# []
# [$ra]
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i1, 5, bl.22754
bge.22754:
	load    [ext_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	add     $i2, 0, $i2
	fmul    $f1, $f1, $f3
	fmul    $f2, $f2, $f4
	fadd    $f3, $f4, $f3
	fadd    $f3, $fc0, $f3
	fsqrt   $f3, $f3
	finv    $f3, $f3
	fmul    $f1, $f3, $f1
	store   $f1, [$i2 + 0]
	fmul    $f2, $f3, $f2
	store   $f2, [$i2 + 1]
	store   $f3, [$i2 + 2]
	add     $i4, 40, $i2
	load    [$i1 + $i2], $i2
	add     $i2, 0, $i2
	store   $f1, [$i2 + 0]
	store   $f3, [$i2 + 1]
	fneg    $f2, $f4
	store   $f4, [$i2 + 2]
	add     $i4, 80, $i2
	load    [$i1 + $i2], $i2
	add     $i2, 0, $i2
	store   $f3, [$i2 + 0]
	fneg    $f1, $f5
	store   $f5, [$i2 + 1]
	store   $f4, [$i2 + 2]
	add     $i4, 1, $i2
	load    [$i1 + $i2], $i2
	add     $i2, 0, $i2
	store   $f5, [$i2 + 0]
	store   $f4, [$i2 + 1]
	fneg    $f3, $f3
	store   $f3, [$i2 + 2]
	add     $i4, 41, $i2
	load    [$i1 + $i2], $i2
	add     $i2, 0, $i2
	store   $f5, [$i2 + 0]
	store   $f3, [$i2 + 1]
	store   $f2, [$i2 + 2]
	add     $i4, 81, $i2
	load    [$i1 + $i2], $i1
	add     $i1, 0, $i1
	store   $f3, [$i1 + 0]
	store   $f1, [$i1 + 1]
	store   $f2, [$i1 + 2]
	jr      $ra1
bl.22754:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc9, $f1
	fsqrt   $f1, $f9
	finv    $f9, $f2
	call    ext_atan
	fmul    $f1, $f7, $f10
.count move_args
	mov     $f10, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f11
.count move_args
	mov     $f10, $f2
	call    ext_cos
	finv    $f1, $f1
	fmul    $f11, $f1, $f1
	fmul    $f1, $f9, $f9
	fmul    $f9, $f9, $f1
	fadd    $f1, $fc9, $f1
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
	fmul    $f1, $f10, $f2
	add     $i1, 1, $i1
.count move_args
	mov     $f9, $f1
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs($i5, $f8, $i6, $i7)
# $ra = $ra2
# [$i1 - $i6, $i8]
# [$f1 - $f7, $f9 - $f13]
# []
# []
# [$ra - $ra1]
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i5, 0, bl.22755
bge.22755:
	li      0, $i1
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i7, 2, $i8
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22755
bge.22756:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22757
bge.22757:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	bge     $i5, 0, bge.22758
.count dual_jmp
	b       bl.22755
bl.22757:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22755
bge.22758:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22759
bge.22759:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	bge     $i5, 0, bge.22760
.count dual_jmp
	b       bl.22755
bl.22759:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22755
bge.22760:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22761
bge.22761:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
.count dual_jmp
	b       bge.22762
bl.22761:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i5, -1, $i5
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
bge.22762:
	add     $i6, -5, $i6
	b       calc_dirvecs.3028
bl.22755:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i7)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f16]
# []
# []
# [$ra - $ra2]
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i9, 0, bl.22763
bge.22763:
	li      0, $i1
.count load_float
	load    [f.22077], $f14
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i7, 2, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i10, 1, $i2
.count move_args
	mov     $i7, $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f1
.count load_float
	load    [f.22078], $f15
.count move_args
	mov     $f15, $f7
	bl      $i2, 5, bl.22764
bge.22764:
	add     $i2, -5, $i3
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count load_float
	load    [f.22079], $f16
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i3, 1, $i2
	bge     $i2, 5, bge.22765
.count dual_jmp
	b       bl.22765
bl.22764:
	mov     $i2, $i3
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count load_float
	load    [f.22079], $f16
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i3, 1, $i2
	bl      $i2, 5, bl.22765
bge.22765:
	add     $i2, -5, $i3
.count load_float
	load    [f.22080], $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc4, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i5
	add     $i3, 1, $i1
	bge     $i1, 5, bge.22766
.count dual_jmp
	b       bl.22766
bl.22765:
	mov     $i2, $i3
.count load_float
	load    [f.22080], $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc4, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i5
	add     $i3, 1, $i1
	bl      $i1, 5, bl.22766
bge.22766:
	add     $i1, -5, $i6
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bge     $i9, 0, bge.22767
.count dual_jmp
	b       bl.22763
bl.22766:
	mov     $i1, $i6
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bl      $i9, 0, bl.22763
bge.22767:
	add     $i10, 2, $i1
.count move_args
	mov     $i9, $i2
	add     $i7, 4, $i7
	bl      $i1, 5, bl.22768
bge.22768:
	add     $i1, -5, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i7, 2, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i10, 1, $i2
	bge     $i2, 5, bge.22769
.count dual_jmp
	b       bl.22769
bl.22768:
	mov     $i1, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i7, 2, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bl.22769
bge.22769:
	add     $i2, -5, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f7
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i5
	add     $i3, 1, $i1
	bge     $i1, 5, bge.22770
.count dual_jmp
	b       bl.22770
bl.22769:
	mov     $i2, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f7
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i5
	add     $i3, 1, $i1
	bl      $i1, 5, bl.22770
bge.22770:
	add     $i1, -5, $i6
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bge     $i10, 5, bge.22771
.count dual_jmp
	b       bl.22771
bl.22770:
	mov     $i1, $i6
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bl      $i10, 5, bl.22771
bge.22771:
	add     $i10, -5, $i10
	add     $i7, 4, $i7
	b       calc_dirvec_rows.3033
bl.22771:
	add     $i7, 4, $i7
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
	mov     $hp, $i2
	add     $hp, 4, $hp
	load    [$i3 + 0], $i4
	store   $i4, [$i2 + 0]
	load    [$i3 + 1], $i4
	store   $i4, [$i2 + 1]
	load    [$i3 + 2], $i3
	store   $i3, [$i2 + 2]
	store   $i1, [$i2 + 3]
	mov     $i2, $i1
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
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i6, 0, bl.22772
bge.22772:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
	add     $i6, -1, $i6
	b       create_dirvec_elements.3039
bl.22772:
	jr      $ra2
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
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i7, 0, bl.22773
bge.22773:
	jal     create_dirvec.3037, $ra1
	li      120, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i7]
	load    [ext_dirvecs + $i7], $i5
	li      118, $i6
	jal     create_dirvec_elements.3039, $ra2
	add     $i7, -1, $i7
	b       create_dirvecs.3042
bl.22773:
	jr      $ra3
.end create_dirvecs

######################################################################
# init_dirvec_constants($i10, $i11)
# $ra = $ra3
# [$i1 - $i9, $i11]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i11, 0, bl.22774
bge.22774:
	load    [$i10 + $i11], $i7
	jal     setup_dirvec_constants.2829, $ra2
	add     $i11, -1, $i11
	b       init_dirvec_constants.3044
bl.22774:
	jr      $ra3
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i12)
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f8]
# []
# []
# [$ra - $ra3]
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i12, 0, bl.22775
bge.22775:
	load    [ext_dirvecs + $i12], $i10
	li      119, $i11
	jal     init_dirvec_constants.3044, $ra3
	add     $i12, -1, $i12
	b       init_vecset_constants.3047
bl.22775:
	jr      $ra4
.end init_vecset_constants

######################################################################
# add_reflection($i10, $i11, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.begin add_reflection
add_reflection.3051:
	jal     create_dirvec.3037, $ra1
.count move_ret
	mov     $i1, $i7
	add     $i7, 0, $i1
	store   $f1, [$i1 + 0]
	store   $f3, [$i1 + 1]
	store   $f4, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	mov     $hp, $i1
	add     $hp, 6, $hp
	store   $i11, [$i1 + 0]
	load    [$i7 + 0], $i2
	store   $i2, [$i1 + 1]
	load    [$i7 + 1], $i2
	store   $i2, [$i1 + 2]
	load    [$i7 + 2], $i2
	store   $i2, [$i1 + 3]
	load    [$i7 + 3], $i2
	store   $i2, [$i1 + 4]
	store   $f9, [$i1 + 5]
	store   $i1, [ext_reflections + $i10]
	jr      $ra3
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
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
	load    [ext_screenz_dir + 2], $fg22
	load    [ext_screeny_dir + 0], $fg23
	load    [ext_screeny_dir + 1], $fg24
	load    [f.21978 + 0], $fc0
	load    [f.22003 + 0], $fc1
	load    [f.22002 + 0], $fc2
	load    [f.21977 + 0], $fc3
	load    [f.21979 + 0], $fc4
	load    [f.22005 + 0], $fc5
	load    [f.22004 + 0], $fc6
	load    [f.21982 + 0], $fc7
	load    [f.21992 + 0], $fc8
	load    [f.21991 + 0], $fc9
	load    [f.21976 + 0], $fc10
	load    [f.22076 + 0], $fc11
	load    [f.21998 + 0], $fc12
	load    [f.21997 + 0], $fc13
	load    [f.21986 + 0], $fc14
	load    [f.21981 + 0], $fc15
	load    [f.22075 + 0], $fc16
	load    [f.21988 + 0], $fc17
	load    [f.21987 + 0], $fc18
	load    [f.21985 + 0], $fc19
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i31
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i27
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i33
	call    ext_read_float
	store   $f1, [ext_screen + 0]
	call    ext_read_float
	store   $f1, [ext_screen + 1]
	call    ext_read_float
	store   $f1, [ext_screen + 2]
	call    ext_read_float
.count load_float
	load    [f.21933], $f7
	fmul    $f1, $f7, $f8
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
	fmul    $f1, $f7, $f10
.count move_args
	mov     $f10, $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f11
.count move_args
	mov     $f10, $f2
	call    ext_sin
	fmul    $f9, $f1, $f2
.count load_float
	load    [f.22100], $f3
	fmul    $f2, $f3, $fg20
.count load_float
	load    [f.22101], $f2
	fmul    $f8, $f2, $fg21
	fmul    $f9, $f11, $f2
	fmul    $f2, $f3, $fg22
	store   $f11, [ext_screenx_dir + 0]
	fneg    $f1, $f2
	store   $f2, [ext_screenx_dir + 2]
	fneg    $f8, $f2
	fmul    $f2, $f1, $fg23
	fneg    $f9, $fg24
	fmul    $f2, $f11, $f1
	store   $f1, [ext_screeny_dir + 2]
	load    [ext_screen + 0], $f1
	fsub    $f1, $fg20, $f1
	store   $f1, [ext_viewpoint + 0]
	load    [ext_screen + 1], $f1
	fsub    $f1, $fg21, $f1
	store   $f1, [ext_viewpoint + 1]
	load    [ext_screen + 2], $f1
	fsub    $f1, $fg22, $f1
	store   $f1, [ext_viewpoint + 2]
	call    ext_read_int
	call    ext_read_float
	fmul    $f1, $f7, $f8
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
.count move_ret
	mov     $f1, $f8
	fmul    $f9, $f7, $f7
.count move_args
	mov     $f7, $f2
	call    ext_sin
	fmul    $f8, $f1, $fg14
.count move_args
	mov     $f7, $f2
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
	li      0, $i6
	li      0, $i7
	li      4, $i5
.count move_args
	mov     $fc11, $f8
	jal     calc_dirvecs.3028, $ra2
	li      8, $i9
	li      2, $i10
	li      4, $i7
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i12
	jal     init_vecset_constants.3047, $ra4
	li      ext_light_dirvec, $i7
	add     $i7, 0, $i1
	store   $fg14, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	add     $ig0, -1, $i1
	bl      $i1, 0, bl.22777
bge.22777:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.22777
be.22778:
	add     $i2, 11, $i3
	load    [$i3 + 0], $f1
	ble     $fc0, $f1, bl.22777
bg.22779:
	load    [$i2 + 1], $i4
	bne     $i4, 1, bne.22780
be.22780:
	add     $i1, $i1, $i1
	add     $i1, $i1, $i12
	add     $i12, 1, $i11
	load    [$i3 + 0], $f1
	fsub    $fc0, $f1, $f9
	fneg    $fg12, $f10
	fneg    $fg13, $f11
.count move_args
	mov     $ig4, $i10
.count move_args
	mov     $fg14, $f1
.count move_args
	mov     $f10, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $i10
	add     $i12, 2, $i11
	fneg    $fg14, $f12
.count move_args
	mov     $f12, $f1
.count move_args
	mov     $fg12, $f3
.count move_args
	mov     $f11, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 2, $i10
	add     $i12, 3, $i11
.count move_args
	mov     $f12, $f1
.count move_args
	mov     $f10, $f3
.count move_args
	mov     $fg13, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 3, $ig4
	li      127, $i28
	li      0, $i29
.count load_float
	load    [f.22102], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f16
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f17
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f18
	jal     pretrace_pixels.2983, $ra7
	li      0, $i30
	li      2, $i34
.count move_args
	mov     $i27, $i32
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
bne.22780:
	bne     $i4, 2, bl.22777
be.22781:
	add     $i2, 4, $i2
	load    [$i2 + 0], $f2
	fmul    $fc10, $f2, $f3
	fmul    $fg14, $f2, $f2
	load    [$i2 + 1], $f4
	fmul    $fg12, $f4, $f5
	fadd    $f2, $f5, $f2
	load    [$i2 + 2], $f5
	fmul    $fg13, $f5, $f6
	fadd    $f2, $f6, $f2
	fmul    $f3, $f2, $f3
	fsub    $f3, $fg14, $f6
	fmul    $fc10, $f4, $f3
	fmul    $f3, $f2, $f3
	fsub    $f3, $fg12, $f3
	fmul    $fc10, $f5, $f4
	fmul    $f4, $f2, $f2
	fsub    $f2, $fg13, $f4
	fsub    $fc0, $f1, $f9
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i11
.count move_args
	mov     $ig4, $i10
.count move_args
	mov     $f6, $f1
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $ig4
	li      127, $i28
	li      0, $i29
.count load_float
	load    [f.22102], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f16
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f17
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f18
	jal     pretrace_pixels.2983, $ra7
	li      0, $i30
	li      2, $i34
dat1: .int 127079
	load    [dat1], $tmp
	be      $tmp, $hp, check1
	ledout  2, $tmp
check1:
.count move_args
	mov     $i27, $i32
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
bl.22777:
	li      127, $i28
	li      0, $i29
.count load_float
	load    [f.22102], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f16
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f17
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f18
	jal     pretrace_pixels.2983, $ra7
	li      0, $i30
	li      2, $i34
.count move_args
	mov     $i27, $i32
	jal     scan_line.3000, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
.end main
