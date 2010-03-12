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

#スタックとヒープの初期化($hp=0x4000,$sp=0x20000)
	li      0, $i0
	mov     $i0, $f0
	li      0x2000, $hp
	sll     $hp, $hp
	sll     $hp, $sp
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
	.int	light_dirvec_v3
	.int	light_dirvec_consts
light_dirvec_v3:
	.skip	3
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
f.22000:	.float  -6.4000000000E+01
f.21999:	.float  -2.0000000000E+02
f.21998:	.float  2.0000000000E+02
f.21990:	.float  -5.0000000000E-01
f.21989:	.float  7.0000000000E-01
f.21988:	.float  -3.0000000000E-01
f.21987:	.float  -1.0000000000E-01
f.21986:	.float  9.0000000000E-01
f.21985:	.float  2.0000000000E-01
f.21975:	.float  1.5000000000E+02
f.21974:	.float  -1.5000000000E+02
f.21973:	.float  6.6666666667E-03
f.21972:	.float  -6.6666666667E-03
f.21971:	.float  -2.0000000000E+00
f.21970:	.float  3.9062500000E-03
f.21969:	.float  2.5600000000E+02
f.21968:	.float  1.0000000000E+08
f.21967:	.float  1.0000000000E+09
f.21966:	.float  1.0000000000E+01
f.21965:	.float  2.0000000000E+01
f.21964:	.float  5.0000000000E-02
f.21963:	.float  2.5000000000E-01
f.21962:	.float  2.5500000000E+02
f.21961:	.float  1.0000000000E-01
f.21960:	.float  8.5000000000E+02
f.21959:	.float  1.5000000000E-01
f.21958:	.float  9.5492964444E+00
f.21957:	.float  3.1830988148E-01
f.21956:	.float  3.1415927000E+00
f.21955:	.float  3.0000000000E+01
f.21954:	.float  1.5000000000E+01
f.21953:	.float  1.0000000000E-04
f.21952:	.float  -1.0000000000E-01
f.21951:	.float  1.0000000000E-02
f.21950:	.float  -2.0000000000E-01
f.21949:	.float  5.0000000000E-01
f.21948:	.float  1.0000000000E+00
f.21947:	.float  -1.0000000000E+00
f.21946:	.float  2.0000000000E+00
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
	bne     $i7, -1, bne.22011
be.22011:
	li      0, $i1
	jr      $ra1
bne.22011:
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
	bne     $i10, 0, bne.22012
be.22012:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	ble     $f0, $f3, ble.22013
.count dual_jmp
	b       bg.22013
bne.22012:
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
	bg      $f0, $f3, bg.22013
ble.22013:
	li      0, $i2
	be      $i8, 2, be.22014
.count dual_jmp
	b       bne.22014
bg.22013:
	li      1, $i2
	bne     $i8, 2, bne.22014
be.22014:
	li      1, $i3
	mov     $hp, $i4
	add     $hp, 11, $hp
	store   $i1, [$i4 + 10]
	store   $i15, [$i4 + 9]
	store   $i14, [$i4 + 8]
	store   $i13, [$i4 + 7]
	store   $i3, [$i4 + 6]
	store   $i12, [$i4 + 5]
	store   $i11, [$i4 + 4]
	store   $i10, [$i4 + 3]
	store   $i9, [$i4 + 2]
	store   $i8, [$i4 + 1]
	store   $i7, [$i4 + 0]
	store   $i4, [ext_objects + $i6]
	be      $i8, 3, be.22015
.count dual_jmp
	b       bne.22015
bne.22014:
	mov     $i2, $i3
	mov     $hp, $i4
	add     $hp, 11, $hp
	store   $i1, [$i4 + 10]
	store   $i15, [$i4 + 9]
	store   $i14, [$i4 + 8]
	store   $i13, [$i4 + 7]
	store   $i3, [$i4 + 6]
	store   $i12, [$i4 + 5]
	store   $i11, [$i4 + 4]
	store   $i10, [$i4 + 3]
	store   $i9, [$i4 + 2]
	store   $i8, [$i4 + 1]
	store   $i7, [$i4 + 0]
	store   $i4, [ext_objects + $i6]
	bne     $i8, 3, bne.22015
be.22015:
	load    [$i11 + 0], $f1
	be      $f1, $f0, be.22017
bne.22016:
	bne     $f1, $f0, bne.22017
be.22017:
	mov     $f0, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22020
.count dual_jmp
	b       bne.22019
bne.22017:
	bg      $f1, $f0, bg.22018
ble.22018:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22020
.count dual_jmp
	b       bne.22019
bg.22018:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.22020
bne.22019:
	bne     $f1, $f0, bne.22020
be.22020:
	mov     $f0, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22023
.count dual_jmp
	b       bne.22022
bne.22020:
	bg      $f1, $f0, bg.22021
ble.22021:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22023
.count dual_jmp
	b       bne.22022
bg.22021:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.22023
bne.22022:
	bne     $f1, $f0, bne.22023
be.22023:
	mov     $f0, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bne.22023:
	bg      $f1, $f0, bg.22024
ble.22024:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bg.22024:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bne.22015:
	bne     $i8, 2, bne.22026
be.22026:
	load    [$i11 + 0], $f1
	load    [$i11 + 1], $f3
	fmul    $f3, $f3, $f3
	fmul    $f1, $f1, $f2
	fadd    $f2, $f3, $f2
	load    [$i11 + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.22027
be.22027:
	li      1, $i1
	be      $f2, $f0, be.22028
.count dual_jmp
	b       bne.22028
bne.22027:
	li      0, $i1
	bne     $f2, $f0, bne.22028
be.22028:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bne.22028:
	bne     $i1, 0, bne.22029
be.22029:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bne.22029:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.22031
.count dual_jmp
	b       bne.22031
bne.22026:
	bne     $i10, 0, bne.22031
be.22031:
	li      1, $i1
	jr      $ra1
bne.22031:
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
	bl      $i6, 60, bl.22032
bge.22032:
	jr      $ra2
bl.22032:
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, bne.22033
be.22033:
	mov     $i6, $ig0
	jr      $ra2
bne.22033:
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
	bne     $i1, -1, bne.22035
be.22035:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
bne.22035:
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
	bne     $i2, -1, bne.22039
be.22039:
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
bne.22039:
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
	bne     $i2, -1, bne.22042
be.22042:
	jr      $ra1
bne.22042:
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
	load    [$i1 + 5], $i3
	load    [$i1 + 1], $i4
	load    [$i3 + 0], $f1
	load    [$i3 + 1], $f2
	load    [$i3 + 2], $f3
	fsub    $fg17, $f1, $f1
	fsub    $fg18, $f2, $f2
	fsub    $fg19, $f3, $f3
	load    [$i2 + 0], $f4
	bne     $i4, 1, bne.22043
be.22043:
	be      $f4, $f0, ble.22050
bne.22044:
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.22045
ble.22045:
	li      0, $i5
	be      $i4, 0, be.22046
.count dual_jmp
	b       bne.22046
bg.22045:
	li      1, $i5
	bne     $i4, 0, bne.22046
be.22046:
	mov     $i5, $i4
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22048
be.22048:
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22050
.count dual_jmp
	b       bg.22049
bne.22048:
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22050
.count dual_jmp
	b       bg.22049
bne.22046:
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.22047
be.22047:
	li      1, $i4
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22050
.count dual_jmp
	b       bg.22049
bne.22047:
	li      0, $i4
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22050
bg.22049:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.22050
ble.22050:
	load    [$i2 + 1], $f4
	li      0, $i3
	bne     $f4, $f0, bne.22052
be.22052:
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.22074
.count dual_jmp
	b       bne.22060
bne.22052:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.22053
ble.22053:
	li      0, $i5
	be      $i4, 0, be.22054
.count dual_jmp
	b       bne.22054
bg.22053:
	li      1, $i5
	bne     $i4, 0, bne.22054
be.22054:
	mov     $i5, $i4
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	be      $i4, 0, bne.22055
.count dual_jmp
	b       be.22055
bne.22054:
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.22055
be.22055:
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22058
.count dual_jmp
	b       bg.22057
bne.22055:
	fneg    $f7, $f7
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22058
bg.22057:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.22058
ble.22058:
	li      0, $i3
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.22074
bne.22060:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, bg.22061
ble.22061:
	li      0, $i4
	be      $i1, 0, be.22062
.count dual_jmp
	b       bne.22062
bg.22061:
	li      1, $i4
	bne     $i1, 0, bne.22062
be.22062:
	mov     $i4, $i1
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	be      $i1, 0, bne.22063
.count dual_jmp
	b       be.22063
bne.22062:
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22063
be.22063:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22074
.count dual_jmp
	b       bg.22065
bne.22063:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22074
bg.22065:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22074
bg.22066:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bg.22058:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bg.22050:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.22043:
	bne     $i4, 2, bne.22067
be.22067:
	load    [$i1 + 4], $i1
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
	ble     $f4, $f0, ble.22074
bg.22068:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22067:
	load    [$i1 + 4], $i3
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
	bne     $i5, 0, bne.22069
be.22069:
	be      $f7, $f0, ble.22074
.count dual_jmp
	b       bne.22070
bne.22069:
	fmul    $f5, $f6, $f9
	load    [$i1 + 9], $i2
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
	be      $f7, $f0, ble.22074
bne.22070:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i5, 0, bne.22071
be.22071:
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
	be      $i5, 0, be.22072
.count dual_jmp
	b       bne.22072
bne.22071:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	load    [$i1 + 9], $i2
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
	bne     $i5, 0, bne.22072
be.22072:
	mov     $f6, $f1
	be      $i4, 3, be.22073
.count dual_jmp
	b       bne.22073
bne.22072:
	fmul    $f2, $f3, $f8
	load    [$i1 + 9], $i2
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
	bne     $i4, 3, bne.22073
be.22073:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22074
.count dual_jmp
	b       bg.22074
bne.22073:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.22074
ble.22074:
	li      0, $i1
	ret     
bg.22074:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, bne.22075
be.22075:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22075:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f9]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast
solver_fast.2796:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 5], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 1], $i5
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i3 + 1], $f4
	load    [ext_intersection_point + 2], $f5
	load    [$i3 + 2], $f6
	fsub    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsub    $f5, $f6, $f3
	load    [$i4 + $i1], $i1
	bne     $i5, 1, bne.22076
be.22076:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22079
bg.22077:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.22079
bg.22078:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.22079
be.22079:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22083
bg.22081:
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.22083
bg.22082:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.22083
be.22083:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.22093
bg.22085:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22093
bg.22086:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.22093
bne.22087:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.22083:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.22079:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.22076:
	load    [$i1 + 0], $f4
	bne     $i5, 2, bne.22088
be.22088:
	ble     $f0, $f4, ble.22093
bg.22089:
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
bne.22088:
	be      $f4, $f0, ble.22093
bne.22090:
	load    [$i2 + 4], $i3
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
	bne     $i4, 0, bne.22091
be.22091:
	mov     $f7, $f1
	be      $i5, 3, be.22092
.count dual_jmp
	b       bne.22092
bne.22091:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i3
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
	bne     $i5, 3, bne.22092
be.22092:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22093
.count dual_jmp
	b       bg.22093
bne.22092:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, bg.22093
ble.22093:
	li      0, $i1
	ret     
bg.22093:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22094
be.22094:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
bne.22094:
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
	load    [$i3 + 10], $i4
	load    [$i2 + 1], $i5
	load    [$i3 + 1], $i6
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	load    [$i5 + $i1], $i1
	bne     $i6, 1, bne.22095
be.22095:
	load    [$i2 + 0], $i2
	load    [$i3 + 4], $i3
	load    [$i3 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22098
bg.22096:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.22098
bg.22097:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.22098
be.22098:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.22102
bg.22100:
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.22102
bg.22101:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.22102
be.22102:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.22110
bg.22104:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.22110
bg.22105:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.22110
bne.22106:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.22102:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.22098:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.22095:
	bne     $i6, 2, bne.22107
be.22107:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, ble.22110
bg.22108:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22107:
	load    [$i1 + 0], $f4
	be      $f4, $f0, ble.22110
bne.22109:
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
	bg      $f2, $f0, bg.22110
ble.22110:
	li      0, $i1
	ret     
bg.22110:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.22111
be.22111:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.22111:
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
	bne     $f1, $f0, bne.22112
be.22112:
	store   $f0, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22117
.count dual_jmp
	b       bne.22117
bne.22112:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, bg.22113
ble.22113:
	li      0, $i3
	be      $i2, 0, be.22114
.count dual_jmp
	b       bne.22114
bg.22113:
	li      1, $i3
	bne     $i2, 0, bne.22114
be.22114:
	mov     $i3, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, bne.22116
be.22116:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22117
.count dual_jmp
	b       bne.22117
bne.22116:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22117
.count dual_jmp
	b       bne.22117
bne.22114:
	bne     $i3, 0, bne.22115
be.22115:
	li      1, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.22117
.count dual_jmp
	b       bne.22117
bne.22115:
	li      0, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	bne     $f1, $f0, bne.22117
be.22117:
	store   $f0, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22122
bne.22117:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, bg.22118
ble.22118:
	li      0, $i3
	be      $i2, 0, be.22119
.count dual_jmp
	b       bne.22119
bg.22118:
	li      1, $i3
	bne     $i2, 0, bne.22119
be.22119:
	mov     $i3, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, bne.22121
be.22121:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22122
bne.22121:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22122
bne.22119:
	bne     $i3, 0, bne.22120
be.22120:
	li      1, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.22122
.count dual_jmp
	b       bne.22122
bne.22120:
	li      0, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	bne     $f1, $f0, bne.22122
be.22122:
	store   $f0, [$i1 + 5]
	jr      $ra1
bne.22122:
	load    [$i5 + 6], $i2
	load    [$i5 + 4], $i3
	bg      $f0, $f1, bg.22123
ble.22123:
	li      0, $i5
	be      $i2, 0, be.22124
.count dual_jmp
	b       bne.22124
bg.22123:
	li      1, $i5
	bne     $i2, 0, bne.22124
be.22124:
	mov     $i5, $i2
	load    [$i3 + 2], $f1
	be      $i2, 0, bne.22125
.count dual_jmp
	b       be.22125
bne.22124:
	load    [$i3 + 2], $f1
	bne     $i5, 0, bne.22125
be.22125:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
bne.22125:
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
	load    [$i5 + 4], $i2
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
	bg      $f1, $f0, bg.22127
ble.22127:
	store   $f0, [$i1 + 0]
	jr      $ra1
bg.22127:
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
	load    [$i5 + 4], $i3
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
	bne     $i2, 0, bne.22128
be.22128:
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
	be      $i2, 0, be.22129
.count dual_jmp
	b       bne.22129
bne.22128:
	fmul    $f2, $f3, $f5
	load    [$i5 + 9], $i6
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
	bne     $i2, 0, bne.22129
be.22129:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	be      $f1, $f0, be.22131
.count dual_jmp
	b       bne.22131
bne.22129:
	load    [$i5 + 9], $i2
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
	bne     $f1, $f0, bne.22131
be.22131:
	jr      $ra1
bne.22131:
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
	bl      $i8, 0, bl.22132
bge.22132:
	load    [$i7 + 1], $i9
	load    [ext_objects + $i8], $i5
	load    [$i5 + 1], $i1
	load    [$i7 + 0], $i4
	bne     $i1, 1, bne.22133
be.22133:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.22133:
	bne     $i1, 2, bne.22134
be.22134:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.22134:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bl.22132:
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
	bl      $i1, 0, bl.22135
bge.22135:
	load    [ext_objects + $i1], $i3
	load    [$i3 + 5], $i4
	load    [$i3 + 10], $i5
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
	bne     $i4, 2, bne.22136
be.22136:
	load    [$i3 + 4], $i3
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
bne.22136:
	bg      $i4, 2, bg.22137
ble.22137:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bg.22137:
	load    [$i3 + 4], $i6
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
	bne     $i7, 0, bne.22138
be.22138:
	mov     $f4, $f1
	be      $i4, 3, be.22139
.count dual_jmp
	b       bne.22139
bne.22138:
	load    [$i3 + 9], $i3
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
	bne     $i4, 3, bne.22139
be.22139:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bne.22139:
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bl.22135:
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
	be      $i2, -1, be.22194
bne.22140:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22141
be.22141:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.22146
bg.22142:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22146
bg.22144:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22146
ble.22146:
	be      $i2, 0, bne.22156
.count dual_jmp
	b       be.22156
bg.22146:
	bne     $i2, 0, bne.22156
be.22157:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22194
.count dual_jmp
	b       bne.22158
bne.22141:
	bne     $i4, 2, bne.22148
be.22148:
	load    [$i2 + 6], $i4
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, bg.22149
ble.22149:
	be      $i4, 0, bne.22156
.count dual_jmp
	b       be.22156
bg.22149:
	be      $i4, 0, be.22156
.count dual_jmp
	b       bne.22156
bne.22148:
	load    [$i2 + 6], $i5
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $i6
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
	bne     $i6, 0, bne.22152
be.22152:
	mov     $f7, $f1
	be      $i4, 3, be.22153
.count dual_jmp
	b       bne.22153
bne.22152:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i2
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
	bne     $i4, 3, bne.22153
be.22153:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22154
.count dual_jmp
	b       bg.22154
bne.22153:
	bg      $f0, $f1, bg.22154
ble.22154:
	be      $i5, 0, bne.22156
.count dual_jmp
	b       be.22156
bg.22154:
	bne     $i5, 0, bne.22156
be.22156:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22194
bne.22158:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.22159
be.22159:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.22164
bg.22160:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22164
bg.22162:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22164
ble.22164:
	be      $i2, 0, bne.22156
.count dual_jmp
	b       be.22174
bg.22164:
	bne     $i2, 0, bne.22156
be.22175:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22194
.count dual_jmp
	b       bne.22176
bne.22159:
	load    [$i2 + 6], $i4
	bne     $i5, 2, bne.22166
be.22166:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.22172
.count dual_jmp
	b       bg.22172
bne.22166:
	load    [$i2 + 4], $i6
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
	bne     $i7, 0, bne.22170
be.22170:
	mov     $f7, $f1
	be      $i5, 3, be.22171
.count dual_jmp
	b       bne.22171
bne.22170:
	load    [$i2 + 9], $i2
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
	bne     $i5, 3, bne.22171
be.22171:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22172
.count dual_jmp
	b       bg.22172
bne.22171:
	bg      $f0, $f1, bg.22172
ble.22172:
	be      $i4, 0, bne.22156
.count dual_jmp
	b       be.22174
bg.22172:
	bne     $i4, 0, bne.22156
be.22174:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22194
bne.22176:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.22177
be.22177:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.22182
bg.22178:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22182
bg.22180:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22182
ble.22182:
	be      $i2, 0, bne.22156
.count dual_jmp
	b       be.22192
bg.22182:
	bne     $i2, 0, bne.22156
be.22193:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.22194
.count dual_jmp
	b       bne.22194
bne.22177:
	bne     $i4, 2, bne.22184
be.22184:
	load    [$i2 + 6], $i4
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, bg.22185
ble.22185:
	be      $i4, 0, bne.22156
.count dual_jmp
	b       be.22192
bg.22185:
	be      $i4, 0, be.22192
.count dual_jmp
	b       bne.22156
bne.22184:
	load    [$i2 + 6], $i5
	load    [$i2 + 3], $i6
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $i7
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
	bne     $i6, 0, bne.22188
be.22188:
	mov     $f7, $f1
	be      $i4, 3, be.22189
.count dual_jmp
	b       bne.22189
bne.22188:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i2
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
	bne     $i4, 3, bne.22189
be.22189:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22190
.count dual_jmp
	b       bg.22190
bne.22189:
	bg      $f0, $f1, bg.22190
ble.22190:
	be      $i5, 0, bne.22156
.count dual_jmp
	b       be.22192
bg.22190:
	bne     $i5, 0, bne.22156
be.22192:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, bne.22194
be.22194:
	li      1, $i1
	ret     
bne.22194:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f5
	load    [$i4 + 2], $f6
	fsub    $f2, $f1, $f1
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.22195
be.22195:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.22198
bg.22196:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.22198
bg.22197:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.22198
ble.22198:
	load    [$i2 + 6], $i2
	be      $i2, 0, bne.22156
.count dual_jmp
	b       be.22210
bg.22198:
	load    [$i2 + 6], $i2
	be      $i2, 0, be.22210
.count dual_jmp
	b       bne.22156
bne.22195:
	load    [$i2 + 6], $i4
	bne     $i5, 2, bne.22202
be.22202:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.22208
.count dual_jmp
	b       bg.22208
bne.22202:
	load    [$i2 + 4], $i6
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
	bne     $i7, 0, bne.22206
be.22206:
	mov     $f7, $f1
	be      $i5, 3, be.22207
.count dual_jmp
	b       bne.22207
bne.22206:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i2
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
	bne     $i5, 3, bne.22207
be.22207:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22208
.count dual_jmp
	b       bg.22208
bne.22207:
	bg      $f0, $f1, bg.22208
ble.22208:
	be      $i4, 0, bne.22156
.count dual_jmp
	b       be.22210
bg.22208:
	bne     $i4, 0, bne.22156
be.22210:
	add     $i1, 1, $i1
	b       check_all_inside.2856
bne.22156:
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
	be      $i1, -1, be.22234
bne.22211:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 5], $i4
	load    [ext_light_dirvec + 1], $i5
	load    [$i2 + 1], $i6
	load    [ext_intersection_point + 0], $f1
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i4 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i4 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [$i5 + $i1], $i4
	bne     $i6, 1, bne.22212
be.22212:
	load    [ext_light_dirvec + 0], $i5
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f4
	load    [$i5 + 1], $f5
	load    [$i4 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22215
bg.22213:
	load    [$i2 + 2], $f4
	load    [$i5 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22215
bg.22214:
	load    [$i4 + 1], $f4
	bne     $f4, $f0, bne.22215
be.22215:
	load    [$i2 + 0], $f4
	load    [$i5 + 0], $f5
	load    [$i4 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i4 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22219
bg.22217:
	load    [$i2 + 2], $f4
	load    [$i5 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22219
bg.22218:
	load    [$i4 + 3], $f4
	bne     $f4, $f0, bne.22215
be.22219:
	load    [$i2 + 0], $f4
	load    [$i5 + 0], $f5
	load    [$i4 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.22232
bg.22221:
	load    [$i2 + 1], $f1
	load    [$i5 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22232
bg.22222:
	load    [$i4 + 5], $f1
	be      $f1, $f0, ble.22232
bne.22223:
	mov     $f3, $fg0
.count load_float
	load    [f.21950], $f1
	ble     $f1, $fg0, ble.22232
.count dual_jmp
	b       bg.22232
bne.22215:
	mov     $f6, $fg0
.count load_float
	load    [f.21950], $f1
	ble     $f1, $fg0, ble.22232
.count dual_jmp
	b       bg.22232
bne.22212:
	load    [$i4 + 0], $f4
	bne     $i6, 2, bne.22224
be.22224:
	ble     $f0, $f4, ble.22232
bg.22225:
	load    [$i4 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i4 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i4 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
.count load_float
	load    [f.21950], $f1
	ble     $f1, $fg0, ble.22232
.count dual_jmp
	b       bg.22232
bne.22224:
	be      $f4, $f0, ble.22232
bne.22226:
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
	load    [$i2 + 4], $i5
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
	bne     $i5, 0, bne.22227
be.22227:
	mov     $f7, $f1
	be      $i6, 3, be.22228
.count dual_jmp
	b       bne.22228
bne.22227:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i5
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
	bne     $i6, 3, bne.22228
be.22228:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22232
.count dual_jmp
	b       bg.22229
bne.22228:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.22232
bg.22229:
	load    [$i2 + 6], $i2
	load    [$i4 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22230
be.22230:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21950], $f1
	ble     $f1, $fg0, ble.22232
.count dual_jmp
	b       bg.22232
bne.22230:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21950], $f1
	bg      $f1, $fg0, bg.22232
ble.22232:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, bne.22251
be.22234:
	li      0, $i1
	jr      $ra1
bg.22232:
	load    [$i3 + 0], $i1
	be      $i1, -1, bne.22253
bne.22235:
	li      1, $i2
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
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
	bne     $i4, 1, bne.22236
be.22236:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f4
	fabs    $f1, $f1
	load    [$i1 + 6], $i1
	ble     $f4, $f1, ble.22241
bg.22237:
	load    [$i2 + 1], $f1
	fabs    $f3, $f3
	ble     $f1, $f3, ble.22241
bg.22239:
	load    [$i2 + 2], $f1
	fabs    $f2, $f2
	bg      $f1, $f2, bg.22241
ble.22241:
	be      $i1, 0, bne.22251
.count dual_jmp
	b       be.22251
bg.22241:
	be      $i1, 0, be.22251
.count dual_jmp
	b       bne.22251
bne.22236:
	load    [$i1 + 6], $i2
	bne     $i4, 2, bne.22243
be.22243:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	ble     $f0, $f1, ble.22249
.count dual_jmp
	b       bg.22249
bne.22243:
	fmul    $f1, $f1, $f4
	load    [$i1 + 4], $i5
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
	bne     $i5, 0, bne.22247
be.22247:
	mov     $f4, $f1
	be      $i4, 3, be.22248
.count dual_jmp
	b       bne.22248
bne.22247:
	fmul    $f3, $f2, $f8
	load    [$i1 + 9], $i1
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
	bne     $i4, 3, bne.22248
be.22248:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.22249
.count dual_jmp
	b       bg.22249
bne.22248:
	bg      $f0, $f1, bg.22249
ble.22249:
	be      $i2, 0, bne.22251
.count dual_jmp
	b       be.22251
bg.22249:
	bne     $i2, 0, bne.22251
be.22251:
	li      1, $i1
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f7, $f4
	call    check_all_inside.2856
	bne     $i1, 0, bne.22253
bne.22251:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
bne.22253:
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
	be      $i1, -1, be.22268
bne.22254:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22255:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22256:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22257:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22258:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22259:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22260:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22261:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22262:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22263:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22264:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22265:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	be      $i1, -1, be.22268
bne.22266:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22267:
	add     $i9, 1, $i9
	load    [$i10 + $i9], $i1
	bne     $i1, -1, bne.22268
be.22268:
	li      0, $i1
	jr      $ra2
bne.22268:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22255
be.22269:
	add     $i9, 1, $i9
	b       shadow_check_one_or_group.2865
bne.22255:
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
	be      $i1, -1, be.22327
bne.22270:
	be      $i1, 99, bne.22294
bne.22271:
	load    [ext_objects + $i1], $i2
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 5], $i3
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i3 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i3 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [ext_light_dirvec + 1], $i3
	load    [$i3 + $i1], $i1
	load    [$i2 + 1], $i3
	bne     $i3, 1, bne.22272
be.22272:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22275
bg.22273:
	load    [$i2 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22275
bg.22274:
	load    [$i1 + 1], $f4
	bne     $f4, $f0, bne.22275
be.22275:
	load    [$i2 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22279
bg.22277:
	load    [$i2 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22279
bg.22278:
	load    [$i1 + 3], $f4
	bne     $f4, $f0, bne.22279
be.22279:
	load    [$i2 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i1 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.22324
bg.22281:
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, be.22324
bg.22282:
	load    [$i1 + 5], $f1
	be      $f1, $f0, be.22324
bne.22283:
	mov     $f3, $fg0
	li      3, $i1
	ble     $fc7, $fg0, be.22324
.count dual_jmp
	b       bg.22292
bne.22279:
	mov     $f6, $fg0
	li      2, $i1
	ble     $fc7, $fg0, be.22324
.count dual_jmp
	b       bg.22292
bne.22275:
	mov     $f6, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.22324
.count dual_jmp
	b       bg.22292
bne.22272:
	load    [$i1 + 0], $f4
	bne     $i3, 2, bne.22284
be.22284:
	ble     $f0, $f4, be.22324
bg.22285:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.22324
.count dual_jmp
	b       bg.22292
bne.22284:
	be      $f4, $f0, be.22324
bne.22286:
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
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f2, $f2, $f8
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i4
	bne     $i4, 0, bne.22287
be.22287:
	mov     $f7, $f1
	be      $i3, 3, be.22288
.count dual_jmp
	b       bne.22288
bne.22287:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i4 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i4 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	bne     $i3, 3, bne.22288
be.22288:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.22324
.count dual_jmp
	b       bg.22289
bne.22288:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.22324
bg.22289:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.22290
be.22290:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.22324
.count dual_jmp
	b       bg.22292
bne.22290:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ble     $fc7, $fg0, be.22324
bg.22292:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22324
bne.22293:
	load    [ext_and_net + $i1], $i3
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22294
be.22294:
	li      2, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22324
bne.22294:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22324
bne.22312:
	load    [ext_and_net + $i1], $i3
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22313:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22324
bne.22314:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22315:
	load    [$i10 + 3], $i1
	be      $i1, -1, be.22324
bne.22316:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22317:
	load    [$i10 + 4], $i1
	be      $i1, -1, be.22324
bne.22318:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22319:
	load    [$i10 + 5], $i1
	be      $i1, -1, be.22324
bne.22320:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22321:
	load    [$i10 + 6], $i1
	be      $i1, -1, be.22324
bne.22322:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22323:
	load    [$i10 + 7], $i1
	bne     $i1, -1, bne.22324
be.22324:
	li      0, $i1
	add     $i11, 1, $i11
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22327
.count dual_jmp
	b       bne.22327
bne.22324:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22325:
	li      8, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22308
be.22326:
	add     $i11, 1, $i11
	load    [$i12 + $i11], $i10
	load    [$i10 + 0], $i1
	bne     $i1, -1, bne.22327
be.22327:
	li      0, $i1
	jr      $ra3
bne.22327:
	be      $i1, 99, bne.22332
bne.22328:
	call    solver_fast.2796
	be      $i1, 0, be.22331
bne.22329:
	ble     $fc7, $fg0, be.22331
bg.22330:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22331
bne.22331:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22332
be.22332:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22331
bne.22333:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22332
be.22334:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22331
bne.22332:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22331
bne.22337:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22338:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22331
bne.22339:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22308
be.22340:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22308
be.22331:
	add     $i11, 1, $i11
	b       shadow_check_one_or_matrix.2868
bne.22308:
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
	be      $i10, -1, be.22377
bne.22342:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	fsub    $fg17, $f1, $f1
	load    [$i2 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i2 + 2], $f3
	fsub    $fg19, $f3, $f3
	load    [$i9 + 0], $f4
	bne     $i4, 1, bne.22343
be.22343:
	be      $f4, $f0, ble.22350
bne.22344:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.22345
ble.22345:
	li      0, $i5
	be      $i4, 0, be.22346
.count dual_jmp
	b       bne.22346
bg.22345:
	li      1, $i5
	bne     $i4, 0, bne.22346
be.22346:
	mov     $i5, $i4
	load    [$i2 + 0], $f5
	load    [$i9 + 1], $f6
	finv    $f4, $f4
	bne     $i4, 0, bne.22348
be.22348:
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22350
.count dual_jmp
	b       bg.22349
bne.22348:
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22350
.count dual_jmp
	b       bg.22349
bne.22346:
	load    [$i2 + 0], $f5
	load    [$i9 + 1], $f6
	finv    $f4, $f4
	bne     $i5, 0, bne.22347
be.22347:
	li      1, $i4
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22350
.count dual_jmp
	b       bg.22349
bne.22347:
	li      0, $i4
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.22350
bg.22349:
	load    [$i2 + 2], $f5
	load    [$i9 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.22350
ble.22350:
	load    [$i9 + 1], $f4
	li      0, $i2
	bne     $f4, $f0, bne.22352
be.22352:
	load    [$i9 + 2], $f4
	be      $f4, $f0, ble.22374
.count dual_jmp
	b       bne.22360
bne.22352:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.22353
ble.22353:
	li      0, $i5
	be      $i4, 0, be.22354
.count dual_jmp
	b       bne.22354
bg.22353:
	li      1, $i5
	bne     $i4, 0, bne.22354
be.22354:
	mov     $i5, $i4
	load    [$i2 + 1], $f5
	load    [$i9 + 2], $f6
	finv    $f4, $f4
	be      $i4, 0, bne.22355
.count dual_jmp
	b       be.22355
bne.22354:
	load    [$i2 + 1], $f5
	load    [$i9 + 2], $f6
	finv    $f4, $f4
	bne     $i5, 0, bne.22355
be.22355:
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22358
.count dual_jmp
	b       bg.22357
bne.22355:
	fneg    $f5, $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.22358
bg.22357:
	load    [$i2 + 0], $f5
	load    [$i9 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.22358
ble.22358:
	li      0, $i2
	load    [$i9 + 2], $f4
	be      $f4, $f0, ble.22374
bne.22360:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f5
	load    [$i9 + 0], $f6
	load    [$i1 + 6], $i1
	bg      $f0, $f4, bg.22361
ble.22361:
	li      0, $i4
	be      $i1, 0, be.22362
.count dual_jmp
	b       bne.22362
bg.22361:
	li      1, $i4
	bne     $i1, 0, bne.22362
be.22362:
	mov     $i4, $i1
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i1, 0, bne.22364
be.22364:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22374
.count dual_jmp
	b       bg.22365
bne.22364:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22374
.count dual_jmp
	b       bg.22365
bne.22362:
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.22363
be.22363:
	li      1, $i1
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22374
.count dual_jmp
	b       bg.22365
bne.22363:
	li      0, $i1
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.22374
bg.22365:
	load    [$i2 + 1], $f1
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22374
bg.22366:
	mov     $f3, $fg0
	li      3, $i11
	ble     $fg0, $f0, bne.22377
.count dual_jmp
	b       bg.22378
bg.22358:
	mov     $f4, $fg0
	li      2, $i11
	ble     $fg0, $f0, bne.22377
.count dual_jmp
	b       bg.22378
bg.22350:
	mov     $f4, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22377
.count dual_jmp
	b       bg.22378
bne.22343:
	bne     $i4, 2, bne.22367
be.22367:
	load    [$i1 + 4], $i1
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
	ble     $f4, $f0, ble.22374
bg.22368:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22377
.count dual_jmp
	b       bg.22378
bne.22367:
	load    [$i1 + 3], $i2
	load    [$i1 + 4], $i5
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
	bne     $i2, 0, bne.22369
be.22369:
	be      $f7, $f0, ble.22374
.count dual_jmp
	b       bne.22370
bne.22369:
	fmul    $f5, $f6, $f9
	load    [$i1 + 9], $i5
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
	be      $f7, $f0, ble.22374
bne.22370:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, bne.22371
be.22371:
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
	be      $i2, 0, be.22372
.count dual_jmp
	b       bne.22372
bne.22371:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	load    [$i1 + 9], $i5
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
	bne     $i2, 0, bne.22372
be.22372:
	mov     $f6, $f1
	be      $i4, 3, be.22373
.count dual_jmp
	b       bne.22373
bne.22372:
	fmul    $f2, $f3, $f8
	load    [$i1 + 9], $i2
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
	bne     $i4, 3, bne.22373
be.22373:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.22374
.count dual_jmp
	b       bg.22374
bne.22373:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.22374
ble.22374:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, bne.22377
be.22377:
	jr      $ra1
bg.22374:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	li      1, $i11
	finv    $f7, $f2
	bne     $i1, 0, bne.22375
be.22375:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22377
.count dual_jmp
	b       bg.22378
bne.22375:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22377
bg.22378:
	bg      $fg7, $fg0, bg.22379
bne.22377:
	add     $i8, 1, $i8
	b       solve_each_element.2871
bg.22379:
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
bne.22380:
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
	be      $i1, -1, be.22388
bne.22381:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22382:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22383:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22384:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22385:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22386:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22388
bne.22387:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, bne.22388
be.22388:
	jr      $ra2
bne.22388:
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
	be      $i1, -1, be.22397
bne.22389:
	bne     $i1, 99, bne.22390
be.22390:
	load    [$i13 + 1], $i1
	be      $i1, -1, be.22396
bne.22391:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, be.22396
bne.22392:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, be.22396
bne.22393:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, be.22396
bne.22394:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 5], $i1
	be      $i1, -1, be.22396
bne.22395:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 6], $i1
	bne     $i1, -1, bne.22396
be.22396:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22397
.count dual_jmp
	b       bne.22397
bne.22396:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      7, $i12
	jal     solve_one_or_network.2875, $ra2
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22397
be.22397:
	jr      $ra3
bne.22397:
	bne     $i1, 99, bne.22390
be.22398:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22406
bne.22399:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22406
bne.22400:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22406
bne.22401:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22406
bne.22402:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	li      5, $i12
	jal     solve_one_or_network.2875, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix.2879
bne.22390:
.count move_args
	mov     $i9, $i2
	call    solver.2773
	be      $i1, 0, ble.22406
bne.22405:
	bg      $fg7, $fg0, bg.22406
ble.22406:
	add     $i14, 1, $i14
	b       trace_or_matrix.2879
bg.22406:
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
	be      $i10, -1, be.22426
bne.22407:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 10], $i2
	load    [$i9 + 1], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 2], $f3
	load    [$i4 + $i10], $i4
	bne     $i5, 1, bne.22408
be.22408:
	load    [$i9 + 0], $i2
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i4 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.22411
bg.22409:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22411
bg.22410:
	load    [$i4 + 1], $f4
	bne     $f4, $f0, bne.22411
be.22411:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i4 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i4 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.22415
bg.22413:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.22415
bg.22414:
	load    [$i4 + 3], $f4
	bne     $f4, $f0, bne.22415
be.22415:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i4 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.22423
bg.22417:
	load    [$i1 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.22423
bg.22418:
	load    [$i4 + 5], $f1
	be      $f1, $f0, ble.22423
bne.22419:
	mov     $f3, $fg0
	li      3, $i11
	ble     $fg0, $f0, bne.22426
.count dual_jmp
	b       bg.22427
bne.22415:
	mov     $f6, $fg0
	li      2, $i11
	ble     $fg0, $f0, bne.22426
.count dual_jmp
	b       bg.22427
bne.22411:
	mov     $f6, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22426
.count dual_jmp
	b       bg.22427
bne.22408:
	bne     $i5, 2, bne.22420
be.22420:
	load    [$i4 + 0], $f1
	ble     $f0, $f1, ble.22423
bg.22421:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i11
	ble     $fg0, $f0, bne.22426
.count dual_jmp
	b       bg.22427
bne.22420:
	load    [$i4 + 0], $f4
	be      $f4, $f0, ble.22423
bne.22422:
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
	bg      $f2, $f0, bg.22423
ble.22423:
	load    [ext_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, bne.22426
be.22426:
	jr      $ra1
bg.22423:
	load    [$i1 + 6], $i1
	li      1, $i11
	fsqrt   $f2, $f2
	bne     $i1, 0, bne.22424
be.22424:
	fsub    $f1, $f2, $f1
	load    [$i4 + 4], $f2
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22426
.count dual_jmp
	b       bg.22427
bne.22424:
	fadd    $f1, $f2, $f1
	load    [$i4 + 4], $f2
	fmul    $f1, $f2, $fg0
	ble     $fg0, $f0, bne.22426
bg.22427:
	bg      $fg7, $fg0, bg.22428
bne.22426:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
bg.22428:
	load    [$i9 + 0], $i1
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
bne.22429:
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
	be      $i1, -1, be.22437
bne.22430:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22431:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22432:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22433:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22434:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22435:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	be      $i1, -1, be.22437
bne.22436:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, bne.22437
be.22437:
	jr      $ra2
bne.22437:
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
	be      $i1, -1, be.22446
bne.22438:
	bne     $i1, 99, bne.22439
be.22439:
	load    [$i13 + 1], $i1
	be      $i1, -1, be.22445
bne.22440:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, be.22445
bne.22441:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, be.22445
bne.22442:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, be.22445
bne.22443:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 5], $i1
	be      $i1, -1, be.22445
bne.22444:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 6], $i1
	bne     $i1, -1, bne.22445
be.22445:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	be      $i1, -1, be.22446
.count dual_jmp
	b       bne.22446
bne.22445:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22446
be.22446:
	jr      $ra3
bne.22446:
	bne     $i1, 99, bne.22439
be.22447:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22455
bne.22448:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22455
bne.22449:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22455
bne.22450:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22455
bne.22451:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
bne.22439:
.count move_args
	mov     $i9, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22455
bne.22454:
	bg      $fg7, $fg0, bg.22455
ble.22455:
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
bg.22455:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i14, 1, $i14
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i4]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.begin utexture
utexture.2908:
	load    [$i1 + 8], $i2
	load    [$i2 + 0], $fg16
	load    [$i2 + 1], $fg11
	load    [$i2 + 2], $fg15
	load    [$i1 + 0], $i2
	bne     $i2, 1, bne.22456
be.22456:
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + 0], $f2
.count load_float
	load    [f.21964], $f4
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.21965], $f6
.count load_float
	load    [f.21966], $f7
	fmul    $f1, $f6, $f1
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 2], $f1
	load    [$i1 + 2], $f2
	fsub    $f1, $f2, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	bg      $f7, $f5, bg.22457
ble.22457:
	li      0, $i1
	ble     $f7, $f1, ble.22458
.count dual_jmp
	b       bg.22458
bg.22457:
	li      1, $i1
	bg      $f7, $f1, bg.22458
ble.22458:
	be      $i1, 0, bne.22460
.count dual_jmp
	b       be.22460
bg.22458:
	bne     $i1, 0, bne.22460
be.22460:
	mov     $f0, $fg11
	jr      $ra1
bne.22460:
	mov     $fc8, $fg11
	jr      $ra1
bne.22456:
	bne     $i2, 2, bne.22461
be.22461:
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.21963], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc8, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc8, $f1, $fg11
	jr      $ra1
bne.22461:
	bne     $i2, 3, bne.22462
be.22462:
	load    [$i1 + 5], $i1
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
bne.22462:
	bne     $i2, 4, bne.22463
be.22463:
	load    [$i1 + 5], $i3
	load    [$i1 + 4], $i4
.count load_float
	load    [f.21953], $f6
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [$i4 + 0], $f2
	fsqrt   $f2, $f2
	fmul    $f1, $f2, $f7
	fabs    $f7, $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i3 + 2], $f3
	fsub    $f2, $f3, $f2
	load    [$i4 + 2], $f3
	fsqrt   $f3, $f3
	fmul    $f2, $f3, $f8
	bg      $f6, $f1, bg.22464
ble.22464:
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
	load    [$i4 + 1], $f4
	fsqrt   $f4, $f4
	fmul    $f3, $f4, $f3
	ble     $f6, $f2, ble.22465
.count dual_jmp
	b       bg.22465
bg.22464:
.count load_float
	load    [f.21954], $f9
	fmul    $f7, $f7, $f1
	fmul    $f8, $f8, $f2
	fadd    $f1, $f2, $f1
	fabs    $f1, $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i3 + 1], $f4
	fsub    $f3, $f4, $f3
	load    [$i4 + 1], $f4
	fsqrt   $f4, $f4
	fmul    $f3, $f4, $f3
	bg      $f6, $f2, bg.22465
ble.22465:
	finv    $f1, $f1
	fmul_a  $f3, $f1, $f2
	call    ext_atan
	fmul    $fc17, $f1, $f4
.count load_float
	load    [f.21959], $f5
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
	ble     $f0, $f1, ble.22466
.count dual_jmp
	b       bg.22466
bg.22465:
.count load_float
	load    [f.21954], $f4
.count load_float
	load    [f.21959], $f5
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
	bg      $f0, $f1, bg.22466
ble.22466:
.count load_float
	load    [f.21960], $f2
	fmul    $f2, $f1, $fg15
	jr      $ra1
bg.22466:
	mov     $f0, $fg15
	jr      $ra1
bne.22463:
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
	bl      $i16, 0, bl.22467
bge.22467:
	load    [ext_reflections + $i16], $i18
	load    [$i18 + 1], $i19
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22468
be.22468:
	ble     $fg7, $fc7, bne.22479
.count dual_jmp
	b       bg.22476
bne.22468:
	bne     $i1, 99, bne.22469
be.22469:
	load    [$i13 + 1], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22475
bne.22470:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22475
bne.22471:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22475
bne.22472:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
.count move_args
	mov     $i19, $i9
	be      $i1, -1, ble.22475
bne.22473:
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
	ble     $fg7, $fc7, bne.22479
.count dual_jmp
	b       bg.22476
bne.22469:
.count move_args
	mov     $i19, $i2
	call    solver_fast2.2814
.count move_args
	mov     $i19, $i9
	be      $i1, 0, ble.22475
bne.22474:
	bg      $fg7, $fg0, bg.22475
ble.22475:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22479
.count dual_jmp
	b       bg.22476
bg.22475:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i19, $i9
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22479
bg.22476:
	ble     $fc12, $fg7, bne.22479
bg.22477:
	li      1, $i1
	load    [$i18 + 0], $i1
	add     $ig3, $ig3, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, bne.22479
be.22479:
	li      0, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22479
be.22480:
	load    [$i18 + 2], $f1
	load    [$i19 + 0], $i1
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
	bg      $f2, $f0, bg.22481
ble.22481:
	load    [$i17 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i17 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i17 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22479
.count dual_jmp
	b       bg.22482
bg.22481:
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
	bg      $f1, $f0, bg.22482
bne.22479:
	add     $i16, -1, $i16
	b       trace_reflections.2915
bg.22482:
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f12, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	add     $i16, -1, $i16
	b       trace_reflections.2915
bl.22467:
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
	bg      $i20, 4, bg.22483
ble.22483:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i13
	load    [$i13 + 0], $i1
	bne     $i1, -1, bne.22484
be.22484:
	load    [$i21 + 2], $i22
	ble     $fg7, $fc7, ble.22493
.count dual_jmp
	b       bg.22492
bne.22484:
	bne     $i1, 99, bne.22485
be.22485:
	load    [$i13 + 1], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22491
bne.22486:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 2], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22491
bne.22487:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 3], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22491
bne.22488:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element.2871, $ra1
	load    [$i13 + 4], $i1
.count move_args
	mov     $i17, $i9
	be      $i1, -1, ble.22491
bne.22489:
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
	load    [$i21 + 2], $i22
	ble     $fg7, $fc7, ble.22493
.count dual_jmp
	b       bg.22492
bne.22485:
.count move_args
	mov     $i17, $i2
	call    solver.2773
.count move_args
	mov     $i17, $i9
	be      $i1, 0, ble.22491
bne.22490:
	bg      $fg7, $fg0, bg.22491
ble.22491:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix.2879, $ra3
	load    [$i21 + 2], $i22
	ble     $fg7, $fc7, ble.22493
.count dual_jmp
	b       bg.22492
bg.22491:
	li      1, $i12
	jal     solve_one_or_network.2875, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
.count move_args
	mov     $i17, $i9
	jal     trace_or_matrix.2879, $ra3
	load    [$i21 + 2], $i22
	ble     $fg7, $fc7, ble.22493
bg.22492:
	bg      $fc12, $fg7, bg.22493
ble.22493:
	add     $i0, -1, $i1
.count storer
	add     $i22, $i20, $tmp
	store   $i1, [$tmp + 0]
	be      $i20, 0, bg.22483
bne.22495:
	load    [$i17 + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [$i17 + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [$i17 + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	ble     $f1, $f0, bg.22483
bg.22496:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f14, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
bg.22493:
	li      1, $i1
	load    [ext_objects + $ig3], $i23
	load    [$i23 + 1], $i1
	bne     $i1, 1, bne.22497
be.22497:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i1
	load    [$i17 + $i1], $f1
	bne     $f1, $f0, bne.22498
be.22498:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bne.22498:
	bg      $f1, $f0, bg.22499
ble.22499:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bg.22499:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bne.22497:
	bne     $i1, 2, bne.22500
be.22500:
	load    [$i23 + 4], $i1
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bne.22500:
	load    [$i23 + 3], $i1
	load    [$i23 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i23 + 5], $i3
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
	bne     $i1, 0, bne.22501
be.22501:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i23 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22502
.count dual_jmp
	b       bne.22502
bne.22501:
	load    [$i23 + 9], $i1
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
	load    [$i23 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22502
be.22502:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bne.22502:
	bne     $i1, 0, bne.22503
be.22503:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	ble     $fc4, $f1, ble.22504
.count dual_jmp
	b       bg.22504
bne.22503:
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
	load    [$i21 + 1], $i1
	load    [$i1 + $i20], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i23 + 7], $i24
	load    [$i21 + 3], $i1
	load    [$i24 + 0], $f1
	fmul    $f1, $f14, $f11
	bg      $fc4, $f1, bg.22504
ble.22504:
	li      1, $i2
.count storer
	add     $i1, $i20, $tmp
	store   $i2, [$tmp + 0]
	load    [$i21 + 4], $i1
	load    [$i1 + $i20], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg15, [$i2 + 2]
	load    [$i1 + $i20], $i1
.count load_float
	load    [f.21969], $f1
.count load_float
	load    [f.21970], $f1
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
	load    [$i21 + 7], $i1
	load    [$i1 + $i20], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.21971], $f2
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
	be      $i1, -1, be.22505
.count dual_jmp
	b       bne.22505
bg.22504:
	li      0, $i2
.count storer
	add     $i1, $i20, $tmp
	store   $i2, [$tmp + 0]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.21971], $f2
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
	bne     $i1, -1, bne.22505
be.22505:
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
	ble     $f1, $f0, ble.22521
.count dual_jmp
	b       bg.22521
bne.22505:
	be      $i1, 99, bne.22510
bne.22506:
	call    solver_fast.2796
	be      $i1, 0, be.22519
bne.22507:
	ble     $fc7, $fg0, be.22519
bg.22508:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22519
bne.22509:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22510
be.22510:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22519
bne.22511:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22510
be.22512:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22519
bne.22510:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22519
bne.22515:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22516
be.22516:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22519
bne.22517:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22516
be.22518:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22516
be.22519:
	li      1, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i24 + 1], $f1
	fmul    $f14, $f1, $f12
	bne     $i1, 0, bne.22520
be.22520:
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
	bg      $f1, $f0, bg.22521
ble.22521:
	ble     $f2, $f0, bne.22520
.count dual_jmp
	b       bg.22522
bg.22521:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg15, $f1
	fadd    $fg6, $f1, $fg6
	bg      $f2, $f0, bg.22522
bne.22520:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i16
	jal     trace_reflections.2915, $ra4
	ble     $f14, $fc9, bg.22483
.count dual_jmp
	b       bg.22523
bg.22522:
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
	ble     $f14, $fc9, bg.22483
.count dual_jmp
	b       bg.22523
bne.22516:
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
	ble     $f14, $fc9, bg.22483
bg.22523:
	bl      $i20, 4, bl.22524
bge.22524:
	load    [$i23 + 2], $i1
	be      $i1, 2, be.22525
.count dual_jmp
	b       bg.22483
bl.22524:
	add     $i20, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i22, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i23 + 2], $i1
	bne     $i1, 2, bg.22483
be.22525:
	fadd    $f15, $fg7, $f15
	add     $i20, 1, $i20
	load    [$i24 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f14, $f1, $f14
	b       trace_ray.2920
bg.22483:
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
	bne     $i1, -1, bne.22526
be.22526:
	ble     $fg7, $fc7, bne.22555
.count dual_jmp
	b       bg.22534
bne.22526:
	bne     $i1, 99, bne.22527
be.22527:
	load    [$i13 + 1], $i1
	be      $i1, -1, ble.22533
bne.22528:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 2], $i1
	be      $i1, -1, ble.22533
bne.22529:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 3], $i1
	be      $i1, -1, ble.22533
bne.22530:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	load    [$i13 + 4], $i1
	be      $i1, -1, ble.22533
bne.22531:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22555
.count dual_jmp
	b       bg.22534
bne.22527:
.count move_args
	mov     $i9, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22533
bne.22532:
	bg      $fg7, $fg0, bg.22533
ble.22533:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22555
.count dual_jmp
	b       bg.22534
bg.22533:
	li      1, $i12
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22555
bg.22534:
	ble     $fc12, $fg7, bne.22555
bg.22535:
	li      1, $i1
	load    [$i9 + 0], $i1
	load    [ext_objects + $ig3], $i13
	load    [$i13 + 1], $i2
	bne     $i2, 1, bne.22537
be.22537:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i2
	load    [$i1 + $i2], $f1
.count move_args
	mov     $i13, $i1
	bne     $f1, $f0, bne.22538
be.22538:
	store   $f0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bne.22538:
	bg      $f1, $f0, bg.22539
ble.22539:
	store   $fc0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bg.22539:
	store   $fc3, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i1
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bne.22537:
	bne     $i2, 2, bne.22540
be.22540:
	load    [$i13 + 4], $i1
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
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bne.22540:
	load    [$i13 + 3], $i1
	load    [$i13 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i13 + 5], $i3
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
	bne     $i1, 0, bne.22541
be.22541:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i13 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22542
.count dual_jmp
	b       bne.22542
bne.22541:
	load    [$i13 + 9], $i1
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
	load    [$i13 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22542
be.22542:
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
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bne.22542:
	bne     $i1, 0, bne.22543
be.22543:
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
	be      $i1, -1, be.22544
.count dual_jmp
	b       bne.22544
bne.22543:
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
	bne     $i1, -1, bne.22544
be.22544:
	li      0, $i1
	load    [$i13 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	ble     $f1, $f0, ble.22560
.count dual_jmp
	b       bg.22560
bne.22544:
	be      $i1, 99, bne.22549
bne.22545:
	call    solver_fast.2796
	be      $i1, 0, be.22558
bne.22546:
	ble     $fc7, $fg0, be.22558
bg.22547:
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22558
bne.22548:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22549
be.22549:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22558
bne.22550:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22549
be.22551:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22558
bne.22549:
	li      1, $i1
	load    [$i10 + 1], $i1
	be      $i1, -1, be.22558
bne.22554:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22555
be.22555:
	load    [$i10 + 2], $i1
	be      $i1, -1, be.22558
bne.22556:
	li      0, $i8
	load    [ext_and_net + $i1], $i3
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22555
be.22557:
	li      3, $i9
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22555
be.22558:
	li      1, $i11
.count move_args
	mov     $ig1, $i12
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22555
be.22559:
	load    [$i13 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, bg.22560
ble.22560:
	mov     $f0, $f1
	fmul    $f11, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bg.22560:
	fmul    $f11, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bne.22555:
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
	bl      $i18, 0, bl.22561
bge.22561:
	load    [$i16 + $i18], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22562
ble.22562:
	fmul    $f1, $fc1, $f11
	load    [$i16 + $i18], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	bge     $i18, 0, bge.22565
.count dual_jmp
	b       bl.22561
bg.22562:
	fmul    $f1, $fc2, $f11
	add     $i18, 1, $i1
	load    [$i16 + $i1], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	bl      $i18, 0, bl.22561
bge.22565:
	load    [$i16 + $i18], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22566
ble.22566:
	fmul    $f1, $fc1, $f11
	load    [$i16 + $i18], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	b       iter_trace_diffuse_rays.2929
bg.22566:
	fmul    $f1, $fc2, $f11
	add     $i18, 1, $i1
	load    [$i16 + $i1], $i9
	jal     trace_diffuse_ray.2926, $ra4
	add     $i18, -2, $i18
	b       iter_trace_diffuse_rays.2929
bl.22561:
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
	load    [$i19 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i19 + 7], $i1
	load    [$i19 + 1], $i2
	load    [$i19 + 6], $i3
	load    [$i1 + $i20], $i17
	load    [$i2 + $i20], $i21
	load    [$i3 + 0], $i22
	bne     $i22, 0, bne.22567
be.22567:
	be      $i22, 1, be.22569
.count dual_jmp
	b       bne.22569
bne.22567:
	load    [ext_dirvecs + 0], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22568
ble.22568:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 1, be.22569
.count dual_jmp
	b       bne.22569
bg.22568:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 1, bne.22569
be.22569:
	be      $i22, 2, be.22571
.count dual_jmp
	b       bne.22571
bne.22569:
	load    [ext_dirvecs + 1], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22570
ble.22570:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 2, be.22571
.count dual_jmp
	b       bne.22571
bg.22570:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 2, bne.22571
be.22571:
	be      $i22, 3, be.22573
.count dual_jmp
	b       bne.22573
bne.22571:
	load    [ext_dirvecs + 2], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22572
ble.22572:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 3, be.22573
.count dual_jmp
	b       bne.22573
bg.22572:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 3, bne.22573
be.22573:
	be      $i22, 4, be.22575
.count dual_jmp
	b       bne.22575
bne.22573:
	load    [ext_dirvecs + 3], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22574
ble.22574:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i22, 4, be.22575
.count dual_jmp
	b       bne.22575
bg.22574:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i22, 4, bne.22575
be.22575:
	load    [$i19 + 4], $i1
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
bne.22575:
	load    [ext_dirvecs + 4], $i16
	load    [$i21 + 0], $fg8
	load    [$i21 + 1], $fg9
	load    [$i21 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i21, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22576
ble.22576:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 4], $i1
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
bg.22576:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 4], $i1
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
	bg      $i20, 4, bg.22577
ble.22577:
	load    [$i19 + 2], $i21
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22577
bge.22578:
	load    [$i19 + 3], $i22
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22579
be.22579:
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22593
.count dual_jmp
	b       bg.22577
bne.22579:
	load    [$i19 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i19 + 7], $i1
	load    [$i19 + 1], $i2
	load    [$i19 + 6], $i3
	load    [$i1 + $i20], $i17
	load    [$i2 + $i20], $i23
	load    [$i3 + 0], $i24
	bne     $i24, 0, bne.22583
be.22583:
	be      $i24, 1, be.22585
.count dual_jmp
	b       bne.22585
bne.22583:
	load    [ext_dirvecs + 0], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22584
ble.22584:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 1, be.22585
.count dual_jmp
	b       bne.22585
bg.22584:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 1, bne.22585
be.22585:
	be      $i24, 2, be.22587
.count dual_jmp
	b       bne.22587
bne.22585:
	load    [ext_dirvecs + 1], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22586
ble.22586:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 2, be.22587
.count dual_jmp
	b       bne.22587
bg.22586:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 2, bne.22587
be.22587:
	be      $i24, 3, be.22589
.count dual_jmp
	b       bne.22589
bne.22587:
	load    [ext_dirvecs + 2], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22588
ble.22588:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 3, be.22589
.count dual_jmp
	b       bne.22589
bg.22588:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 3, bne.22589
be.22589:
	be      $i24, 4, be.22591
.count dual_jmp
	b       bne.22591
bne.22589:
	load    [ext_dirvecs + 3], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22590
ble.22590:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i24, 4, be.22591
.count dual_jmp
	b       bne.22591
bg.22590:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i24, 4, bne.22591
be.22591:
	load    [$i19 + 4], $i1
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
	ble     $i20, 4, ble.22593
.count dual_jmp
	b       bg.22577
bne.22591:
	load    [ext_dirvecs + 4], $i16
	load    [$i23 + 0], $fg8
	load    [$i23 + 1], $fg9
	load    [$i23 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i23, $i2
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22592
ble.22592:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 4], $i1
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
	ble     $i20, 4, ble.22593
.count dual_jmp
	b       bg.22577
bg.22592:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 4], $i1
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
	bg      $i20, 4, bg.22577
ble.22593:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22577
bge.22594:
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22595
be.22595:
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bne.22595:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bg.22577:
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
	bg      $i20, 4, bg.22596
ble.22596:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i20], $i6
	bl      $i6, 0, bg.22596
bge.22597:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22598
be.22598:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22598
be.22599:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22598
be.22600:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i20], $i8
	bne     $i8, $i6, bne.22598
be.22601:
	load    [$i1 + 3], $i1
	load    [$i1 + $i20], $i1
	bne     $i1, 0, bne.22606
be.22606:
	add     $i20, 1, $i20
	b       try_exploit_neighbors.2967
bne.22606:
	load    [$i7 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i2, -1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i20], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
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
bne.22598:
	bg      $i20, 4, bg.22596
ble.22603:
	load    [$i4 + $i2], $i19
	load    [$i19 + 2], $i1
	load    [$i1 + $i20], $i1
	bl      $i1, 0, bg.22596
bge.22604:
	load    [$i19 + 3], $i1
	load    [$i1 + $i20], $i1
	bne     $i1, 0, bne.22605
be.22605:
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bne.22605:
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i20, 1, $i20
	b       do_without_neighbors.2951
bg.22596:
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
	bg      $i1, $i4, bg.22609
ble.22609:
	bl      $i1, 0, bl.22610
bge.22610:
.count move_args
	mov     $i1, $i2
	b       ext_write
bl.22610:
	li      0, $i2
	b       ext_write
bg.22609:
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
	bg      $i20, 4, bg.22613
ble.22613:
	load    [$i19 + 2], $i21
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22613
bge.22614:
	load    [$i19 + 3], $i22
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22615
be.22615:
	add     $i20, 1, $i20
	bg      $i20, 4, bg.22613
ble.22616:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22613
bge.22617:
	load    [$i22 + $i20], $i1
	be      $i1, 0, be.22623
bne.22618:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i19 + 6], $i8
	load    [$i19 + 7], $i9
	load    [$i19 + 1], $i1
	load    [$i1 + $i20], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i8 + 0], $i1
	load    [ext_dirvecs + $i1], $i16
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22619
ble.22619:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i1
	load    [$i1 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bg.22619:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i1
	load    [$i1 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bne.22615:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i19 + 6], $i23
	load    [$i19 + 7], $i24
	load    [$i19 + 1], $i25
	load    [$i25 + $i20], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i23 + 0], $i1
	load    [ext_dirvecs + $i1], $i16
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22620
ble.22620:
	load    [$i16 + 118], $i9
	fmul    $f1, $fc1, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i26
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	ble     $i20, 4, ble.22621
.count dual_jmp
	b       bg.22613
bg.22620:
	load    [$i16 + 119], $i9
	fmul    $f1, $fc2, $f11
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i26
	load    [$i26 + $i20], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i20, 1, $i20
	bg      $i20, 4, bg.22613
ble.22621:
	load    [$i21 + $i20], $i1
	bl      $i1, 0, bg.22613
bge.22622:
	load    [$i22 + $i20], $i1
	bne     $i1, 0, bne.22623
be.22623:
	add     $i20, 1, $i20
	b       pretrace_diffuse_rays.2980
bne.22623:
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
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22624
ble.22624:
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
bg.22624:
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
bg.22613:
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
	bl      $i28, 0, bl.22625
bge.22625:
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
	bne     $f2, $f0, bne.22626
be.22626:
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
	load    [$i1 + 0], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i27 + $i28], $i1
	load    [$i1 + 6], $i1
	store   $i29, [$i1 + 0]
	load    [$i27 + $i28], $i19
	load    [$i19 + 2], $i1
	load    [$i1 + 0], $i1
	bge     $i1, 0, bge.22627
.count dual_jmp
	b       bl.22627
bne.22626:
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
	load    [$i1 + 0], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i27 + $i28], $i1
	load    [$i1 + 6], $i1
	store   $i29, [$i1 + 0]
	load    [$i27 + $i28], $i19
	load    [$i19 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22627
bge.22627:
	load    [$i19 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22628
be.22628:
	li      1, $i20
	jal     pretrace_diffuse_rays.2980, $ra6
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
.count dual_jmp
	b       bge.22630
bne.22628:
	load    [$i19 + 6], $i1
	load    [$i1 + 0], $i1
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i19 + 7], $i2
	load    [$i19 + 1], $i3
	load    [ext_dirvecs + $i1], $i16
	load    [$i2 + 0], $i17
	load    [$i3 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i16 + 118], $i1
	load    [$i1 + 0], $i1
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
	bg      $f0, $f1, bg.22629
ble.22629:
	fmul    $f1, $fc1, $f11
	load    [$i16 + 118], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i1
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
	b       bge.22630
bg.22629:
	fmul    $f1, $fc2, $f11
	load    [$i16 + 119], $i9
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i18
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i19 + 5], $i1
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
	b       bge.22630
bl.22627:
	add     $i28, -1, $i28
	add     $i29, 1, $i29
	bl      $i29, 5, pretrace_pixels.2983
bge.22630:
	add     $i29, -5, $i29
	b       pretrace_pixels.2983
bl.22625:
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
	bg      $i1, $i25, bg.22631
ble.22631:
	jr      $ra8
bg.22631:
	load    [$i28 + $i25], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i26, 1, $i2
	ble     $i1, $i2, ble.22635
bg.22632:
	ble     $i26, 0, ble.22635
bg.22633:
	li      128, $i1
	add     $i25, 1, $i2
	ble     $i1, $i2, ble.22635
bg.22634:
	bg      $i25, 0, bg.22635
ble.22635:
	li      0, $i1
	load    [$i28 + $i25], $i19
	load    [$i19 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22639
bge.22637:
	load    [$i19 + 3], $i1
	load    [$i1 + 0], $i1
	be      $i1, 0, be.22646
bne.22638:
	li      0, $i20
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bg.22635:
	li      1, $i1
	load    [$i28 + $i25], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bl.22639
bge.22639:
	li      0, $i20
	load    [$i27 + $i25], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22640
be.22640:
	load    [$i29 + $i25], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22640
be.22641:
	add     $i25, -1, $i4
	load    [$i28 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22640
be.22642:
	add     $i25, 1, $i4
	load    [$i28 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22640
be.22643:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i29, $i5
.count move_args
	mov     $i28, $i4
.count move_args
	mov     $i25, $i2
	li      1, $i20
	bne     $i1, 0, bne.22647
be.22647:
.count move_args
	mov     $i27, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bne.22647:
	load    [$i3 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i25, -1, $i1
	load    [$i28 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i28 + $i25], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i25, 1, $i1
	load    [$i28 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i29 + $i25], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i28 + $i25], $i1
	load    [$i1 + 4], $i1
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
bne.22640:
	load    [$i28 + $i25], $i19
	load    [$i19 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22639
bge.22645:
	load    [$i19 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22646
be.22646:
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bne.22646:
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i20
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i25, 1, $i25
	b       scan_pixel.2994
bl.22639:
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
	bg      $i1, $i30, bg.22648
ble.22648:
	jr      $ra9
bg.22648:
	bl      $i30, 127, bl.22649
bge.22649:
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
	bge     $i34, 5, bge.22650
.count dual_jmp
	b       bl.22650
bl.22649:
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
	bl      $i34, 5, bl.22650
bge.22650:
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
bl.22650:
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
	add     $hp, 8, $hp
	store   $i1, [$i2 + 7]
	store   $i11, [$i2 + 6]
	store   $i10, [$i2 + 5]
	store   $i9, [$i2 + 4]
	store   $i8, [$i2 + 3]
	store   $i7, [$i2 + 2]
	store   $i6, [$i2 + 1]
	store   $i5, [$i2 + 0]
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
	bl      $i13, 0, bl.22651
bge.22651:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	add     $i13, -1, $i13
	b       init_line_elements.3010
bl.22651:
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
# calc_dirvec($i3, $f1, $f2, $f7, $f8, $i5, $i4)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f6, $f9 - $f12]
# []
# []
# [$ra]
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i3, 5, bl.22652
bge.22652:
	load    [ext_dirvecs + $i5], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
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
	load    [$i2 + 0], $i2
	store   $f1, [$i2 + 0]
	store   $f3, [$i2 + 1]
	fneg    $f2, $f4
	store   $f4, [$i2 + 2]
	add     $i4, 80, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f3, [$i2 + 0]
	fneg    $f1, $f5
	store   $f5, [$i2 + 1]
	store   $f4, [$i2 + 2]
	add     $i4, 1, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f5, [$i2 + 0]
	store   $f4, [$i2 + 1]
	fneg    $f3, $f3
	store   $f3, [$i2 + 2]
	add     $i4, 41, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f5, [$i2 + 0]
	store   $f3, [$i2 + 1]
	store   $f2, [$i2 + 2]
	add     $i4, 81, $i2
	load    [$i1 + $i2], $i1
	load    [$i1 + 0], $i1
	store   $f3, [$i1 + 0]
	store   $f1, [$i1 + 1]
	store   $f2, [$i1 + 2]
	jr      $ra1
bl.22652:
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
	add     $i3, 1, $i3
.count move_args
	mov     $f9, $f1
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs($i6, $f8, $i5, $i7)
# $ra = $ra2
# [$i1 - $i6, $i8]
# [$f1 - $f7, $f9 - $f13]
# []
# []
# [$ra - $ra1]
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i6, 0, bl.22653
bge.22653:
	li      0, $i1
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i7, 2, $i8
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	bl      $i6, 0, bl.22653
bge.22654:
	li      0, $i1
	add     $i5, 1, $i2
	bl      $i2, 5, bl.22655
bge.22655:
	add     $i2, -5, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	bge     $i6, 0, bge.22656
.count dual_jmp
	b       bl.22653
bl.22655:
	mov     $i2, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	bl      $i6, 0, bl.22653
bge.22656:
	li      0, $i1
	add     $i5, 1, $i2
	bl      $i2, 5, bl.22657
bge.22657:
	add     $i2, -5, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	bge     $i6, 0, bge.22658
.count dual_jmp
	b       bl.22653
bl.22657:
	mov     $i2, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	bl      $i6, 0, bl.22653
bge.22658:
	li      0, $i1
	add     $i5, 1, $i2
	bl      $i2, 5, bl.22659
bge.22659:
	add     $i2, -5, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	add     $i5, 1, $i5
	bl      $i5, 5, calc_dirvecs.3028
.count dual_jmp
	b       bge.22660
bl.22659:
	mov     $i2, $i5
.count move_args
	mov     $i6, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f13
	fsub    $f13, $fc11, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	fadd    $f13, $fc9, $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, -1, $i6
	add     $i5, 1, $i5
	bl      $i5, 5, calc_dirvecs.3028
bge.22660:
	add     $i5, -5, $i5
	b       calc_dirvecs.3028
bl.22653:
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
	bl      $i9, 0, bl.22661
bge.22661:
	li      0, $i1
.count load_float
	load    [f.21987], $f14
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i7, 2, $i6
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i10, 1, $i1
.count move_args
	mov     $i7, $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f1
.count load_float
	load    [f.21988], $f15
.count move_args
	mov     $f15, $f7
	bl      $i1, 5, bl.22662
bge.22662:
	add     $i1, -5, $i5
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count load_float
	load    [f.21989], $f16
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i5, 1, $i1
	bge     $i1, 5, bge.22663
.count dual_jmp
	b       bl.22663
bl.22662:
	mov     $i1, $i5
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count load_float
	load    [f.21989], $f16
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i5, 1, $i1
	bl      $i1, 5, bl.22663
bge.22663:
	add     $i1, -5, $i5
.count load_float
	load    [f.21990], $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc4, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i6
	add     $i5, 1, $i1
	bge     $i1, 5, bge.22664
.count dual_jmp
	b       bl.22664
bl.22663:
	mov     $i1, $i5
.count load_float
	load    [f.21990], $f7
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc4, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i6
	add     $i5, 1, $i1
	bl      $i1, 5, bl.22664
bge.22664:
	add     $i1, -5, $i5
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bge     $i9, 0, bge.22665
.count dual_jmp
	b       bl.22661
bl.22664:
	mov     $i1, $i5
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bl      $i9, 0, bl.22661
bge.22665:
	add     $i10, 2, $i1
.count move_args
	mov     $i9, $i2
	add     $i7, 4, $i7
	bl      $i1, 5, bl.22666
bge.22666:
	add     $i1, -5, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i7, 2, $i6
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i10, 1, $i1
	bge     $i1, 5, bge.22667
.count dual_jmp
	b       bl.22667
bl.22666:
	mov     $i1, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $fc16, $f1
	fsub    $f1, $fc11, $f8
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i7, 2, $i6
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f7
.count move_args
	mov     $i10, $i5
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
	add     $i10, 1, $i1
	bl      $i1, 5, bl.22667
bge.22667:
	add     $i1, -5, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f7
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i6
	add     $i5, 1, $i1
	bge     $i1, 5, bge.22668
.count dual_jmp
	b       bl.22668
bl.22667:
	mov     $i1, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f7
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i3
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f7
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i6
	add     $i5, 1, $i1
	bl      $i1, 5, bl.22668
bge.22668:
	add     $i1, -5, $i5
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bge     $i10, 5, bge.22669
.count dual_jmp
	b       bl.22669
bl.22668:
	mov     $i1, $i5
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bl      $i10, 5, bl.22669
bge.22669:
	add     $i10, -5, $i10
	add     $i7, 4, $i7
	b       calc_dirvec_rows.3033
bl.22669:
	add     $i7, 4, $i7
	b       calc_dirvec_rows.3033
bl.22661:
	jr      $ra3
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i3]
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
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
	store   $i3, [$i2 + 0]
	mov     $i2, $i1
	jr      $ra1
.end create_dirvec

######################################################################
# create_dirvec_elements($i4, $i5)
# $ra = $ra2
# [$i1 - $i3, $i5]
# [$f2]
# []
# []
# [$ra - $ra1]
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i5, 0, bl.22670
bge.22670:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i4, $i5, $tmp
	store   $i1, [$tmp + 0]
	add     $i5, -1, $i5
	b       create_dirvec_elements.3039
bl.22670:
	jr      $ra2
.end create_dirvec_elements

######################################################################
# create_dirvecs($i6)
# $ra = $ra3
# [$i1 - $i6]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i6, 0, bl.22671
bge.22671:
	jal     create_dirvec.3037, $ra1
	li      120, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i6]
	load    [ext_dirvecs + $i6], $i4
	li      118, $i5
	jal     create_dirvec_elements.3039, $ra2
	add     $i6, -1, $i6
	b       create_dirvecs.3042
bl.22671:
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
	bl      $i11, 0, bl.22672
bge.22672:
	load    [$i10 + $i11], $i7
	jal     setup_dirvec_constants.2829, $ra2
	add     $i11, -1, $i11
	b       init_dirvec_constants.3044
bl.22672:
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
	bl      $i12, 0, bl.22673
bge.22673:
	load    [ext_dirvecs + $i12], $i10
	li      119, $i11
	jal     init_dirvec_constants.3044, $ra3
	add     $i12, -1, $i12
	b       init_vecset_constants.3047
bl.22673:
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
	load    [$i7 + 0], $i1
	store   $f1, [$i1 + 0]
	store   $f3, [$i1 + 1]
	store   $f4, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	mov     $hp, $i1
	add     $hp, 3, $hp
	store   $f9, [$i1 + 2]
	store   $i7, [$i1 + 1]
	store   $i11, [$i1 + 0]
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
	load    [f.21948 + 0], $fc0
	load    [f.21973 + 0], $fc1
	load    [f.21972 + 0], $fc2
	load    [f.21947 + 0], $fc3
	load    [f.21949 + 0], $fc4
	load    [f.21975 + 0], $fc5
	load    [f.21974 + 0], $fc6
	load    [f.21952 + 0], $fc7
	load    [f.21962 + 0], $fc8
	load    [f.21961 + 0], $fc9
	load    [f.21946 + 0], $fc10
	load    [f.21986 + 0], $fc11
	load    [f.21968 + 0], $fc12
	load    [f.21967 + 0], $fc13
	load    [f.21956 + 0], $fc14
	load    [f.21951 + 0], $fc15
	load    [f.21985 + 0], $fc16
	load    [f.21958 + 0], $fc17
	load    [f.21957 + 0], $fc18
	load    [f.21955 + 0], $fc19
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
	load    [f.21998], $f3
	fmul    $f2, $f3, $fg20
.count load_float
	load    [f.21999], $f2
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
	li      4, $i6
	jal     create_dirvecs.3042, $ra3
	li      0, $i5
	li      0, $i7
	li      4, $i6
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
	load    [ext_light_dirvec + 0], $i1
	store   $fg14, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	add     $ig0, -1, $i1
	bl      $i1, 0, bl.22675
bge.22675:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.22675
be.22676:
	load    [$i2 + 7], $i3
	load    [$i3 + 0], $f1
	ble     $fc0, $f1, bl.22675
bg.22677:
	load    [$i2 + 1], $i4
	bne     $i4, 1, bne.22678
be.22678:
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
	load    [f.22000], $f1
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
bne.22678:
	bne     $i4, 2, bl.22675
be.22679:
	load    [$i2 + 4], $i2
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
	load    [f.22000], $f1
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
bl.22675:
	li      127, $i28
	li      0, $i29
.count load_float
	load    [f.22000], $f1
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
