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
# [$i2]
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
# [$i1 - $i3]
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
# [$f2]
######################################################################
ext_create_array_float:
	mov $f2, $i3
	jal ext_create_array_int $tmp
.end create_array

######################################################################
# 三角関数
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

f._186:	.float  6.2831853072E+00
f._185:	.float  3.1415926536E+00
f._184:	.float  1.5707963268E+00
f._183:	.float  6.0725293501E-01
f._182:	.float  1.0000000000E+00
f._181:	.float  5.0000000000E-01

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f5]
######################################################################
.begin atan
ext_atan:
.count load_float
	load    [f._182], $f5
	li      0, $i2
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f0, $f4
.count move_args
	mov     $f5, $f2
	b       cordic_rec._146

cordic_rec._146:
	bne     $i2, 25, be_else._188
be_then._188:
	mov     $f4, $f1
	ret
be_else._188:
	fmul    $f5, $f3, $f1
	bg      $f3, $f0, ble_else._189
ble_then._189:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fsub    $f4, $f2, $f4
.count load_float
	load    [f._181], $f2
	fmul    $f5, $f2, $f5
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f2
	b       cordic_rec._146
ble_else._189:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	load    [ext_atan_table + $i2], $f2
	fadd    $f4, $f2, $f4
.count load_float
	load    [f._181], $f2
	fmul    $f5, $f2, $f5
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f2
	b       cordic_rec._146
.end atan

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f7]
######################################################################
.begin sin
ext_sin:
	bg      $f0, $f2, ble_else._192
ble_then._192:
.count load_float
	load    [f._184], $f7
	bg      $f7, $f2, cordic_sin._82
.count load_float
	load    [f._185], $f7
	bg      $f7, $f2, ble_else._194
ble_then._194:
.count load_float
	load    [f._186], $f1
	bg      $f1, $f2, ble_else._195
ble_then._195:
	fsub    $f2, $f1, $f2
	b       ext_sin
ble_else._195:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f1, $f2, $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else._194:
	fsub    $f7, $f2, $f2
	b       cordic_sin._82
ble_else._192:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fneg    $f2, $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret

cordic_rec._111:
	bne     $i2, 25, be_else._190
be_then._190:
	mov     $f4, $f1
	ret
be_else._190:
	fmul    $f6, $f4, $f1
	bg      $f2, $f5, ble_else._191
ble_then._191:
	fadd    $f3, $f1, $f1
	fmul    $f6, $f3, $f3
	fsub    $f4, $f3, $f4
	load    [ext_atan_table + $i2], $f3
	fsub    $f5, $f3, $f5
.count load_float
	load    [f._181], $f3
	fmul    $f6, $f3, $f6
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f3
	b       cordic_rec._111
ble_else._191:
	fsub    $f3, $f1, $f1
	fmul    $f6, $f3, $f3
	fadd    $f4, $f3, $f4
	load    [ext_atan_table + $i2], $f3
	fadd    $f5, $f3, $f5
.count load_float
	load    [f._181], $f3
	fmul    $f6, $f3, $f6
	add     $i2, 1, $i2
.count move_args
	mov     $f1, $f3
	b       cordic_rec._111

cordic_sin._82:
.count load_float
	load    [f._183], $f3
.count load_float
	load    [f._182], $f6
	li      0, $i2
.count move_args
	mov     $f0, $f4
.count move_args
	mov     $f0, $f5
	b       cordic_rec._111
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f8]
######################################################################
.begin cos
ext_cos:
.count load_float
	load    [f._184], $f8
	fsub    $f8, $f2, $f2
	b       ext_sin
.end cos

######################################################################
#
# 		↑　ここまで lib_asm.s
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
f.21506:	.float  -6.4000000000E+01
f.21498:	.float  -5.0000000000E-01
f.21497:	.float  7.0000000000E-01
f.21496:	.float  -3.0000000000E-01
f.21495:	.float  -1.0000000000E-01
f.21494:	.float  2.0000000000E-01
f.21493:	.float  9.0000000000E-01
f.21483:	.float  1.5000000000E+02
f.21482:	.float  -1.5000000000E+02
f.21481:	.float  6.6666666667E-03
f.21480:	.float  -6.6666666667E-03
f.21479:	.float  -2.0000000000E+00
f.21478:	.float  3.9062500000E-03
f.21477:	.float  2.5600000000E+02
f.21476:	.float  1.0000000000E+08
f.21475:	.float  1.0000000000E+09
f.21474:	.float  1.0000000000E+01
f.21473:	.float  5.0000000000E-02
f.21472:	.float  2.0000000000E+01
f.21471:	.float  2.5000000000E-01
f.21470:	.float  2.5500000000E+02
f.21469:	.float  1.0000000000E-01
f.21468:	.float  8.5000000000E+02
f.21467:	.float  1.5000000000E-01
f.21466:	.float  9.5492964444E+00
f.21465:	.float  3.1830988148E-01
f.21464:	.float  3.1415927000E+00
f.21463:	.float  3.0000000000E+01
f.21462:	.float  1.5000000000E+01
f.21461:	.float  1.0000000000E-04
f.21460:	.float  -1.0000000000E-01
f.21459:	.float  1.0000000000E-02
f.21458:	.float  -2.0000000000E-01
f.21457:	.float  5.0000000000E-01
f.21456:	.float  1.0000000000E+00
f.21455:	.float  -1.0000000000E+00
f.21454:	.float  2.0000000000E+00
f.21440:	.float  -2.0000000000E+02
f.21439:	.float  2.0000000000E+02
f.21438:	.float  1.7453293000E-02

######################################################################
# read_screen_settings()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f11]
# []
# [$fg20 - $fg24]
# [$ra]
######################################################################
.begin read_screen_settings
read_screen_settings.2712:
	call    ext_read_float
	store   $f1, [ext_screen + 0]
	call    ext_read_float
	store   $f1, [ext_screen + 1]
	call    ext_read_float
	store   $f1, [ext_screen + 2]
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
	mov     $f1, $f8
.count move_args
	mov     $f11, $f2
	call    ext_sin
.count load_float
	load    [f.21439], $f2
	fmul    $f10, $f1, $f3
	fmul    $f3, $f2, $fg22
.count load_float
	load    [f.21440], $f3
	fmul    $f9, $f3, $fg21
	fmul    $f10, $f8, $f3
	fmul    $f3, $f2, $fg20
	store   $f8, [ext_screenx_dir + 0]
	fneg    $f1, $f2
	store   $f2, [ext_screenx_dir + 2]
	fneg    $f9, $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_screeny_dir + 0]
	fneg    $f10, $fg24
	fmul    $f2, $f8, $fg23
	load    [ext_screen + 0], $f1
	fsub    $f1, $fg22, $f1
	store   $f1, [ext_viewpoint + 0]
	load    [ext_screen + 1], $f1
	fsub    $f1, $fg21, $f1
	store   $f1, [ext_viewpoint + 1]
	load    [ext_screen + 2], $f1
	fsub    $f1, $fg20, $f1
	store   $f1, [ext_viewpoint + 2]
	jr      $ra1
.end read_screen_settings

######################################################################
# read_light()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f10]
# []
# [$fg12 - $fg13, $fg15]
# [$ra]
######################################################################
.begin read_light
read_light.2714:
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
.count move_ret
	mov     $f1, $f10
	fmul    $f9, $fc16, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
	fmul    $f10, $f1, $fg15
.count move_args
	mov     $f8, $f2
	call    ext_cos
	fmul    $f10, $f1, $fg13
	call    ext_read_float
	store   $f1, [ext_beam + 0]
	jr      $ra1
.end read_light

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i15]
# [$f1 - $f18]
# []
# []
# [$ra]
######################################################################
.begin read_nth_object
read_nth_object.2719:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	bne     $i7, -1, be_else.21621
be_then.21621:
	li      0, $i1
	jr      $ra1
be_else.21621:
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
	be      $i10, 0, bne_cont.21622
bne_then.21622:
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 2]
bne_cont.21622:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	bg      $f0, $f3, ble_else.21623
ble_then.21623:
	li      0, $i2
.count b_cont
	b       ble_cont.21623
ble_else.21623:
	li      1, $i2
ble_cont.21623:
	bne     $i8, 2, be_else.21624
be_then.21624:
	li      1, $i3
.count b_cont
	b       be_cont.21624
be_else.21624:
	mov     $i2, $i3
be_cont.21624:
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
	bne     $i8, 3, be_else.21625
be_then.21625:
	load    [$i11 + 0], $f1
	bne     $f1, $f0, be_else.21626
be_then.21626:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21626
be_else.21626:
	bne     $f1, $f0, be_else.21627
be_then.21627:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21627
be_else.21627:
	bg      $f1, $f0, ble_else.21628
ble_then.21628:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21628
ble_else.21628:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21628:
be_cont.21627:
be_cont.21626:
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	bne     $f1, $f0, be_else.21629
be_then.21629:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21629
be_else.21629:
	bne     $f1, $f0, be_else.21630
be_then.21630:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21630
be_else.21630:
	bg      $f1, $f0, ble_else.21631
ble_then.21631:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21631
ble_else.21631:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21631:
be_cont.21630:
be_cont.21629:
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	bne     $f1, $f0, be_else.21632
be_then.21632:
	store   $f0, [$i11 + 2]
	bne     $i10, 0, be_else.21633
be_then.21633:
	li      1, $i1
	jr      $ra1
be_else.21633:
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
	mov     $f1, $f8
	load    [$i15 + 2], $f2
	call    ext_sin
	load    [$i11 + 2], $f2
	fneg    $f12, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i11 + 1], $f5
	fmul    $f11, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i11 + 0], $f13
	fmul    $f11, $f8, $f14
	fmul    $f14, $f14, $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i11 + 0]
	fmul    $f10, $f11, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f9, $f8, $f15
	fmul    $f10, $f12, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f9, $f1, $f18
	fmul    $f16, $f8, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f13, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i11 + 1]
	fmul    $f9, $f11, $f7
	fmul    $f7, $f7, $f11
	fmul    $f2, $f11, $f11
	fmul    $f10, $f8, $f17
	fmul    $f9, $f12, $f9
	fmul    $f9, $f1, $f12
	fsub    $f12, $f17, $f12
	fmul    $f12, $f12, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fadd    $f8, $f1, $f1
	fmul    $f1, $f1, $f8
	fmul    $f13, $f8, $f8
	fadd    $f8, $f17, $f8
	fadd    $f8, $f11, $f8
	store   $f8, [$i11 + 2]
	fmul    $f2, $f4, $f8
	fmul    $f8, $f7, $f8
	fmul    $f5, $f15, $f9
	fmul    $f9, $f12, $f9
	fmul    $f13, $f16, $f10
	fmul    $f10, $f1, $f10
	fadd    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fmul    $fc8, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f12, $f6
	fmul    $f13, $f14, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 2]
	li      1, $i1
	jr      $ra1
be_else.21632:
	fmul    $f1, $f1, $f2
	finv    $f2, $f2
	bne     $f1, $f0, be_else.21634
be_then.21634:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21634
be_else.21634:
	bg      $f1, $f0, ble_else.21635
ble_then.21635:
	mov     $fc3, $f1
.count b_cont
	b       ble_cont.21635
ble_else.21635:
	mov     $fc0, $f1
ble_cont.21635:
be_cont.21634:
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21636
be_then.21636:
	li      1, $i1
	jr      $ra1
be_else.21636:
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
	mov     $f1, $f8
	load    [$i15 + 2], $f2
	call    ext_sin
	load    [$i11 + 2], $f2
	fneg    $f12, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i11 + 1], $f5
	fmul    $f11, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i11 + 0], $f13
	fmul    $f11, $f8, $f14
	fmul    $f14, $f14, $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i11 + 0]
	fmul    $f10, $f11, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f9, $f8, $f15
	fmul    $f10, $f12, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f9, $f1, $f18
	fmul    $f16, $f8, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f13, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i11 + 1]
	fmul    $f9, $f11, $f7
	fmul    $f7, $f7, $f11
	fmul    $f2, $f11, $f11
	fmul    $f10, $f8, $f17
	fmul    $f9, $f12, $f9
	fmul    $f9, $f1, $f12
	fsub    $f12, $f17, $f12
	fmul    $f12, $f12, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fadd    $f8, $f1, $f1
	fmul    $f1, $f1, $f8
	fmul    $f13, $f8, $f8
	fadd    $f8, $f17, $f8
	fadd    $f8, $f11, $f8
	store   $f8, [$i11 + 2]
	fmul    $f2, $f4, $f8
	fmul    $f8, $f7, $f8
	fmul    $f5, $f15, $f9
	fmul    $f9, $f12, $f9
	fmul    $f13, $f16, $f10
	fmul    $f10, $f1, $f10
	fadd    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fmul    $fc8, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f12, $f6
	fmul    $f13, $f14, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 2]
	li      1, $i1
	jr      $ra1
be_else.21625:
	bne     $i8, 2, be_else.21637
be_then.21637:
	load    [$i11 + 2], $f1
	fmul    $f1, $f1, $f1
	load    [$i11 + 1], $f2
	fmul    $f2, $f2, $f2
	load    [$i11 + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.21638
be_then.21638:
	li      1, $i1
.count b_cont
	b       be_cont.21638
be_else.21638:
	li      0, $i1
be_cont.21638:
	bne     $f1, $f0, be_else.21639
be_then.21639:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.21639
be_else.21639:
	bne     $i1, 0, be_else.21640
be_then.21640:
	finv    $f1, $f1
.count b_cont
	b       be_cont.21640
be_else.21640:
	finv_n  $f1, $f1
be_cont.21640:
be_cont.21639:
	load    [$i11 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i11 + 0]
	load    [$i11 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i11 + 1]
	load    [$i11 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21641
be_then.21641:
	li      1, $i1
	jr      $ra1
be_else.21641:
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
	mov     $f1, $f8
	load    [$i15 + 2], $f2
	call    ext_sin
	load    [$i11 + 2], $f2
	fneg    $f12, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i11 + 1], $f5
	fmul    $f11, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i11 + 0], $f13
	fmul    $f11, $f8, $f14
	fmul    $f14, $f14, $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i11 + 0]
	fmul    $f10, $f11, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f9, $f8, $f15
	fmul    $f10, $f12, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f9, $f1, $f18
	fmul    $f16, $f8, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f13, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i11 + 1]
	fmul    $f9, $f11, $f7
	fmul    $f7, $f7, $f11
	fmul    $f2, $f11, $f11
	fmul    $f10, $f8, $f17
	fmul    $f9, $f12, $f9
	fmul    $f9, $f1, $f12
	fsub    $f12, $f17, $f12
	fmul    $f12, $f12, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fadd    $f8, $f1, $f1
	fmul    $f1, $f1, $f8
	fmul    $f13, $f8, $f8
	fadd    $f8, $f17, $f8
	fadd    $f8, $f11, $f8
	store   $f8, [$i11 + 2]
	fmul    $f2, $f4, $f8
	fmul    $f8, $f7, $f8
	fmul    $f5, $f15, $f9
	fmul    $f9, $f12, $f9
	fmul    $f13, $f16, $f10
	fmul    $f10, $f1, $f10
	fadd    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fmul    $fc8, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f12, $f6
	fmul    $f13, $f14, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 2]
	li      1, $i1
	jr      $ra1
be_else.21637:
	bne     $i10, 0, be_else.21642
be_then.21642:
	li      1, $i1
	jr      $ra1
be_else.21642:
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
	mov     $f1, $f8
	load    [$i15 + 2], $f2
	call    ext_sin
	load    [$i11 + 2], $f2
	fneg    $f12, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i11 + 1], $f5
	fmul    $f11, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i11 + 0], $f13
	fmul    $f11, $f8, $f14
	fmul    $f14, $f14, $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i11 + 0]
	fmul    $f10, $f11, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f9, $f8, $f15
	fmul    $f10, $f12, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f9, $f1, $f18
	fmul    $f16, $f8, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f13, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i11 + 1]
	fmul    $f9, $f11, $f7
	fmul    $f7, $f7, $f11
	fmul    $f2, $f11, $f11
	fmul    $f10, $f8, $f17
	fmul    $f9, $f12, $f9
	fmul    $f9, $f1, $f12
	fsub    $f12, $f17, $f12
	fmul    $f12, $f12, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fadd    $f8, $f1, $f1
	fmul    $f1, $f1, $f8
	fmul    $f13, $f8, $f8
	fadd    $f8, $f17, $f8
	fadd    $f8, $f11, $f8
	store   $f8, [$i11 + 2]
	fmul    $f2, $f4, $f8
	fmul    $f8, $f7, $f8
	fmul    $f5, $f15, $f9
	fmul    $f9, $f12, $f9
	fmul    $f13, $f16, $f10
	fmul    $f10, $f1, $f10
	fadd    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fmul    $fc8, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f12, $f6
	fmul    $f13, $f14, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc8, $f1, $f1
	store   $f1, [$i15 + 2]
	li      1, $i1
	jr      $ra1
.end read_nth_object

######################################################################
# read_object($i16)
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f18]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_object
read_object.2721:
	bl      $i16, 60, bge_else.21643
bge_then.21643:
	jr      $ra2
bge_else.21643:
.count move_args
	mov     $i16, $i6
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, be_else.21644
be_then.21644:
	mov     $i16, $ig0
	jr      $ra2
be_else.21644:
	add     $i16, 1, $i16
	b       read_object.2721
.end read_object

######################################################################
# read_all_object()
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f18]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_all_object
read_all_object.2723:
	li      0, $i16
	b       read_object.2721
.end read_all_object

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
	sub     $sp, 3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	bne     $i1, -1, be_else.21645
be_then.21645:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	add     $i0, -1, $i3
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	b       ext_create_array_int
be_else.21645:
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
	sub     $sp, 3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.21646
be_then.21646:
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
be_else.21646:
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
	bne     $i2, -1, be_else.21647
be_then.21647:
	jr      $ra1
be_else.21647:
	store   $i1, [ext_and_net + $i6]
	add     $i6, 1, $i6
	b       read_and_network.2729
.end read_and_network

######################################################################
# read_parameter()
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f18]
# [$ig0 - $ig1]
# [$fg12 - $fg13, $fg15, $fg20 - $fg24]
# [$ra - $ra2]
######################################################################
.begin read_parameter
read_parameter.2731:
	jal     read_screen_settings.2712, $ra1
	jal     read_light.2714, $ra1
	jal     read_all_object.2723, $ra2
	li      0, $i6
	jal     read_and_network.2729, $ra1
	li      0, $i1
	call    read_or_network.2727
.count move_ret
	mov     $i1, $ig1
	jr      $ra3
.end read_parameter

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f15]
# []
# [$fg0]
# []
######################################################################
.begin solver
solver.2773:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 1], $i3
	load    [$i1 + 5], $i4
	load    [$i4 + 2], $f1
	fsub    $fg19, $f1, $f1
	load    [$i4 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i4 + 0], $f3
	fsub    $fg17, $f3, $f3
	bne     $i3, 1, be_else.21648
be_then.21648:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.21649
be_then.21649:
	li      0, $i3
.count b_cont
	b       be_cont.21649
be_else.21649:
	finv    $f4, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 0], $f6
	bg      $f0, $f4, ble_else.21650
ble_then.21650:
	li      0, $i4
.count b_cont
	b       ble_cont.21650
ble_else.21650:
	li      1, $i4
ble_cont.21650:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.21651
bne_then.21651:
	bne     $i4, 0, be_else.21652
be_then.21652:
	li      1, $i4
.count b_cont
	b       be_cont.21652
be_else.21652:
	li      0, $i4
be_cont.21652:
bne_cont.21651:
	bne     $i4, 0, be_else.21653
be_then.21653:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21653
be_else.21653:
	mov     $f6, $f4
be_cont.21653:
	fsub    $f4, $f3, $f4
	fmul    $f4, $f5, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i3 + 1], $f6
	bg      $f6, $f5, ble_else.21654
ble_then.21654:
	li      0, $i3
.count b_cont
	b       ble_cont.21654
ble_else.21654:
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i3 + 2], $f6
	bg      $f6, $f5, ble_else.21655
ble_then.21655:
	li      0, $i3
.count b_cont
	b       ble_cont.21655
ble_else.21655:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21655:
ble_cont.21654:
be_cont.21649:
	bne     $i3, 0, be_else.21656
be_then.21656:
	load    [$i2 + 1], $f4
	bne     $f4, $f0, be_else.21657
be_then.21657:
	li      0, $i3
.count b_cont
	b       be_cont.21657
be_else.21657:
	finv    $f4, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f6
	bg      $f0, $f4, ble_else.21658
ble_then.21658:
	li      0, $i4
.count b_cont
	b       ble_cont.21658
ble_else.21658:
	li      1, $i4
ble_cont.21658:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.21659
bne_then.21659:
	bne     $i4, 0, be_else.21660
be_then.21660:
	li      1, $i4
.count b_cont
	b       be_cont.21660
be_else.21660:
	li      0, $i4
be_cont.21660:
bne_cont.21659:
	bne     $i4, 0, be_else.21661
be_then.21661:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21661
be_else.21661:
	mov     $f6, $f4
be_cont.21661:
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i3 + 2], $f6
	bg      $f6, $f5, ble_else.21662
ble_then.21662:
	li      0, $i3
.count b_cont
	b       ble_cont.21662
ble_else.21662:
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i3 + 0], $f6
	bg      $f6, $f5, ble_else.21663
ble_then.21663:
	li      0, $i3
.count b_cont
	b       ble_cont.21663
ble_else.21663:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21663:
ble_cont.21662:
be_cont.21657:
	bne     $i3, 0, be_else.21664
be_then.21664:
	load    [$i2 + 2], $f4
	bne     $f4, $f0, be_else.21665
be_then.21665:
	li      0, $i1
	ret
be_else.21665:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	finv    $f4, $f5
	load    [$i3 + 2], $f6
	bg      $f0, $f4, ble_else.21666
ble_then.21666:
	li      0, $i4
.count b_cont
	b       ble_cont.21666
ble_else.21666:
	li      1, $i4
ble_cont.21666:
	bne     $i1, 0, be_else.21667
be_then.21667:
	mov     $i4, $i1
.count b_cont
	b       be_cont.21667
be_else.21667:
	bne     $i4, 0, be_else.21668
be_then.21668:
	li      1, $i1
.count b_cont
	b       be_cont.21668
be_else.21668:
	li      0, $i1
be_cont.21668:
be_cont.21667:
	bne     $i1, 0, be_else.21669
be_then.21669:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21669
be_else.21669:
	mov     $f6, $f4
be_cont.21669:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f5, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i3 + 0], $f4
	bg      $f4, $f3, ble_else.21670
ble_then.21670:
	li      0, $i1
	ret
ble_else.21670:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i3 + 1], $f3
	bg      $f3, $f2, ble_else.21671
ble_then.21671:
	li      0, $i1
	ret
ble_else.21671:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21664:
	li      2, $i1
	ret
be_else.21656:
	li      1, $i1
	ret
be_else.21648:
	load    [$i2 + 2], $f5
	bne     $i3, 2, be_else.21672
be_then.21672:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f5, $f4, $f5
	load    [$i1 + 1], $f6
	load    [$i2 + 1], $f7
	fmul    $f7, $f6, $f7
	load    [$i1 + 0], $f8
	load    [$i2 + 0], $f9
	fmul    $f9, $f8, $f9
	fadd    $f9, $f7, $f7
	fadd    $f7, $f5, $f5
	bg      $f5, $f0, ble_else.21673
ble_then.21673:
	li      0, $i1
	ret
ble_else.21673:
	finv    $f5, $f5
	fmul    $f4, $f1, $f1
	fmul    $f6, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f5, $fg0
	li      1, $i1
	ret
be_else.21672:
	load    [$i1 + 4], $i4
	load    [$i1 + 3], $i5
	load    [$i4 + 2], $f4
	fmul    $f5, $f5, $f6
	fmul    $f6, $f4, $f6
	load    [$i4 + 1], $f7
	load    [$i2 + 1], $f8
	fmul    $f8, $f8, $f9
	fmul    $f9, $f7, $f9
	load    [$i4 + 0], $f10
	load    [$i2 + 0], $f11
	fmul    $f11, $f11, $f12
	fmul    $f12, $f10, $f12
	fadd    $f12, $f9, $f9
	fadd    $f9, $f6, $f6
	be      $i5, 0, bne_cont.21674
bne_then.21674:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f9
	fmul    $f11, $f8, $f12
	fmul    $f12, $f9, $f9
	load    [$i2 + 1], $f12
	fmul    $f5, $f11, $f13
	fmul    $f13, $f12, $f12
	load    [$i2 + 0], $f13
	fmul    $f8, $f5, $f14
	fmul    $f14, $f13, $f13
	fadd    $f6, $f13, $f6
	fadd    $f6, $f12, $f6
	fadd    $f6, $f9, $f6
bne_cont.21674:
	bne     $f6, $f0, be_else.21675
be_then.21675:
	li      0, $i1
	ret
be_else.21675:
	fmul    $f1, $f1, $f9
	fmul    $f9, $f4, $f9
	fmul    $f2, $f2, $f12
	fmul    $f12, $f7, $f12
	fmul    $f3, $f3, $f13
	fmul    $f13, $f10, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f9, $f9
	be      $i5, 0, bne_cont.21676
bne_then.21676:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f12
	fmul    $f3, $f2, $f13
	fmul    $f13, $f12, $f12
	load    [$i2 + 1], $f13
	fmul    $f1, $f3, $f14
	fmul    $f14, $f13, $f13
	load    [$i2 + 0], $f14
	fmul    $f2, $f1, $f15
	fmul    $f15, $f14, $f14
	fadd    $f9, $f14, $f9
	fadd    $f9, $f13, $f9
	fadd    $f9, $f12, $f9
bne_cont.21676:
	bne     $i3, 3, be_cont.21677
be_then.21677:
	fsub    $f9, $fc0, $f9
be_cont.21677:
	fmul    $f6, $f9, $f9
	fmul    $f5, $f1, $f12
	fmul    $f12, $f4, $f4
	fmul    $f8, $f2, $f12
	fmul    $f12, $f7, $f7
	fmul    $f11, $f3, $f12
	fmul    $f12, $f10, $f10
	fadd    $f10, $f7, $f7
	fadd    $f7, $f4, $f4
	bne     $i5, 0, be_else.21678
be_then.21678:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21678
be_else.21678:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f7
	fmul    $f8, $f3, $f10
	fmul    $f11, $f2, $f12
	fadd    $f12, $f10, $f10
	fmul    $f10, $f7, $f7
	load    [$i2 + 1], $f10
	fmul    $f5, $f3, $f3
	fmul    $f11, $f1, $f11
	fadd    $f11, $f3, $f3
	fmul    $f3, $f10, $f3
	load    [$i2 + 0], $f10
	fmul    $f8, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $f3, $f1
	fadd    $f1, $f7, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
be_cont.21678:
	fmul    $f1, $f1, $f2
	fsub    $f2, $f9, $f2
	bg      $f2, $f0, ble_else.21679
ble_then.21679:
	li      0, $i1
	ret
ble_else.21679:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	finv    $f6, $f3
	bne     $i1, 0, be_else.21680
be_then.21680:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
be_else.21680:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
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
	load    [$i2 + 1], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i4 + $i1], $i1
	load    [$i5 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i5 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	bne     $i3, 1, be_else.21681
be_then.21681:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i2
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 1], $f6
	bg      $f6, $f5, ble_else.21682
ble_then.21682:
	li      0, $i4
.count b_cont
	b       ble_cont.21682
ble_else.21682:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.21683
ble_then.21683:
	li      0, $i4
.count b_cont
	b       ble_cont.21683
ble_else.21683:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21684
be_then.21684:
	li      0, $i4
.count b_cont
	b       be_cont.21684
be_else.21684:
	li      1, $i4
be_cont.21684:
ble_cont.21683:
ble_cont.21682:
	bne     $i4, 0, be_else.21685
be_then.21685:
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i2 + 0], $f7
	bg      $f7, $f5, ble_else.21686
ble_then.21686:
	li      0, $i2
.count b_cont
	b       ble_cont.21686
ble_else.21686:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.21687
ble_then.21687:
	li      0, $i2
.count b_cont
	b       ble_cont.21687
ble_else.21687:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.21688
be_then.21688:
	li      0, $i2
.count b_cont
	b       be_cont.21688
be_else.21688:
	li      1, $i2
be_cont.21688:
ble_cont.21687:
ble_cont.21686:
	bne     $i2, 0, be_else.21689
be_then.21689:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.21690
ble_then.21690:
	li      0, $i1
	ret
ble_else.21690:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.21691
ble_then.21691:
	li      0, $i1
	ret
ble_else.21691:
	load    [$i1 + 5], $f2
	bne     $f2, $f0, be_else.21692
be_then.21692:
	li      0, $i1
	ret
be_else.21692:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21689:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.21685:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.21681:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.21693
be_then.21693:
	bg      $f0, $f4, ble_else.21694
ble_then.21694:
	li      0, $i1
	ret
ble_else.21694:
	load    [$i1 + 3], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $fg0
	li      1, $i1
	ret
be_else.21693:
	bne     $f4, $f0, be_else.21695
be_then.21695:
	li      0, $i1
	ret
be_else.21695:
	load    [$i2 + 4], $i4
	load    [$i2 + 3], $i5
	load    [$i4 + 2], $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f5, $f5
	load    [$i4 + 1], $f6
	fmul    $f2, $f2, $f7
	fmul    $f7, $f6, $f6
	load    [$i4 + 0], $f7
	fmul    $f3, $f3, $f8
	fmul    $f8, $f7, $f7
	fadd    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	be      $i5, 0, bne_cont.21696
bne_then.21696:
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f6
	fmul    $f3, $f2, $f7
	fmul    $f7, $f6, $f6
	load    [$i4 + 1], $f7
	fmul    $f1, $f3, $f8
	fmul    $f8, $f7, $f7
	load    [$i4 + 0], $f8
	fmul    $f2, $f1, $f9
	fmul    $f9, $f8, $f8
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	fadd    $f5, $f6, $f5
bne_cont.21696:
	bne     $i3, 3, be_cont.21697
be_then.21697:
	fsub    $f5, $fc0, $f5
be_cont.21697:
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.21698
ble_then.21698:
	li      0, $i1
	ret
ble_else.21698:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.21699
be_then.21699:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret
be_else.21699:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
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
	load    [$i3 + 1], $i5
	load    [$i2 + 1], $i6
	load    [$i6 + $i1], $i1
	load    [$i4 + 2], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 0], $f3
	bne     $i5, 1, be_else.21700
be_then.21700:
	load    [$i2 + 0], $i2
	load    [$i3 + 4], $i3
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i3 + 1], $f6
	bg      $f6, $f5, ble_else.21701
ble_then.21701:
	li      0, $i4
.count b_cont
	b       ble_cont.21701
ble_else.21701:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.21702
ble_then.21702:
	li      0, $i4
.count b_cont
	b       ble_cont.21702
ble_else.21702:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21703
be_then.21703:
	li      0, $i4
.count b_cont
	b       be_cont.21703
be_else.21703:
	li      1, $i4
be_cont.21703:
ble_cont.21702:
ble_cont.21701:
	bne     $i4, 0, be_else.21704
be_then.21704:
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i3 + 0], $f7
	bg      $f7, $f5, ble_else.21705
ble_then.21705:
	li      0, $i3
.count b_cont
	b       ble_cont.21705
ble_else.21705:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.21706
ble_then.21706:
	li      0, $i3
.count b_cont
	b       ble_cont.21706
ble_else.21706:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.21707
be_then.21707:
	li      0, $i3
.count b_cont
	b       be_cont.21707
be_else.21707:
	li      1, $i3
be_cont.21707:
ble_cont.21706:
ble_cont.21705:
	bne     $i3, 0, be_else.21708
be_then.21708:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.21709
ble_then.21709:
	li      0, $i1
	ret
ble_else.21709:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.21710
ble_then.21710:
	li      0, $i1
	ret
ble_else.21710:
	load    [$i1 + 5], $f2
	bne     $f2, $f0, be_else.21711
be_then.21711:
	li      0, $i1
	ret
be_else.21711:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21708:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.21704:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.21700:
	bne     $i5, 2, be_else.21712
be_then.21712:
	load    [$i1 + 0], $f1
	bg      $f0, $f1, ble_else.21713
ble_then.21713:
	li      0, $i1
	ret
ble_else.21713:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21712:
	load    [$i1 + 0], $f4
	bne     $f4, $f0, be_else.21714
be_then.21714:
	li      0, $i1
	ret
be_else.21714:
	load    [$i4 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.21715
ble_then.21715:
	li      0, $i1
	ret
ble_else.21715:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.21716
be_then.21716:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret
be_else.21716:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret
.end solver_fast2

######################################################################
# $i1 = setup_rect_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i5]
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
	bne     $f1, $f0, be_else.21717
be_then.21717:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.21717
be_else.21717:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21718
ble_then.21718:
	li      0, $i3
.count b_cont
	b       ble_cont.21718
ble_else.21718:
	li      1, $i3
ble_cont.21718:
	bne     $i2, 0, be_else.21719
be_then.21719:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21719
be_else.21719:
	bne     $i3, 0, be_else.21720
be_then.21720:
	li      1, $i2
.count b_cont
	b       be_cont.21720
be_else.21720:
	li      0, $i2
be_cont.21720:
be_cont.21719:
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.21721
be_then.21721:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.21721
be_else.21721:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.21721:
be_cont.21717:
	load    [$i4 + 1], $f1
	bne     $f1, $f0, be_else.21722
be_then.21722:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.21722
be_else.21722:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21723
ble_then.21723:
	li      0, $i3
.count b_cont
	b       ble_cont.21723
ble_else.21723:
	li      1, $i3
ble_cont.21723:
	bne     $i2, 0, be_else.21724
be_then.21724:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21724
be_else.21724:
	bne     $i3, 0, be_else.21725
be_then.21725:
	li      1, $i2
.count b_cont
	b       be_cont.21725
be_else.21725:
	li      0, $i2
be_cont.21725:
be_cont.21724:
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.21726
be_then.21726:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.21726
be_else.21726:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.21726:
be_cont.21722:
	load    [$i4 + 2], $f1
	bne     $f1, $f0, be_else.21727
be_then.21727:
	store   $f0, [$i1 + 5]
	jr      $ra1
be_else.21727:
	load    [$i5 + 4], $i2
	load    [$i5 + 6], $i3
	bg      $f0, $f1, ble_else.21728
ble_then.21728:
	li      0, $i5
.count b_cont
	b       ble_cont.21728
ble_else.21728:
	li      1, $i5
ble_cont.21728:
	load    [$i2 + 2], $f1
	bne     $i3, 0, be_else.21729
be_then.21729:
	bne     $i5, 0, be_else.21730
be_then.21730:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21730:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21729:
	bne     $i5, 0, be_else.21731
be_then.21731:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21731:
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
# [$i1 - $i5]
# [$f1 - $f4]
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
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i2 + 1], $f2
	load    [$i4 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i2 + 0], $f3
	load    [$i4 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f1, $f0, ble_else.21732
ble_then.21732:
	store   $f0, [$i1 + 0]
	jr      $ra1
ble_else.21732:
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
# [$i1 - $i6]
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
	load    [$i5 + 4], $i2
	load    [$i5 + 3], $i3
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i2 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i2 + 0], $f5
	load    [$i4 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i3, 0, bne_cont.21733
bne_then.21733:
	fmul    $f4, $f2, $f3
	load    [$i5 + 9], $i6
	load    [$i6 + 0], $f5
	fmul    $f3, $f5, $f3
	fadd    $f1, $f3, $f1
	fmul    $f2, $f6, $f2
	load    [$i6 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f6, $f4, $f2
	load    [$i6 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
bne_cont.21733:
	store   $f1, [$i1 + 0]
	load    [$i2 + 2], $f2
	load    [$i4 + 2], $f3
	fmul_n  $f3, $f2, $f2
	load    [$i2 + 1], $f4
	load    [$i4 + 1], $f5
	fmul_n  $f5, $f4, $f4
	load    [$i2 + 0], $f6
	load    [$i4 + 0], $f7
	fmul_n  $f7, $f6, $f6
	bne     $i3, 0, be_else.21734
be_then.21734:
	store   $f6, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.21735
be_then.21735:
	jr      $ra1
be_else.21735:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
be_else.21734:
	load    [$i5 + 9], $i2
	load    [$i2 + 2], $f7
	fmul    $f5, $f7, $f5
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f3, $f5, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f6, $f3, $f3
	store   $f3, [$i1 + 1]
	load    [$i4 + 0], $f3
	fmul    $f3, $f7, $f3
	load    [$i2 + 0], $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f5, $f6
	fadd    $f6, $f3, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f4, $f3, $f3
	store   $f3, [$i1 + 2]
	load    [$i4 + 0], $f3
	fmul    $f3, $f8, $f3
	load    [$i4 + 1], $f4
	fmul    $f4, $f5, $f4
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.21736
be_then.21736:
	jr      $ra1
be_else.21736:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i7, $i8)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i8, 0, bge_else.21737
bge_then.21737:
	load    [$i7 + 0], $i4
	load    [ext_objects + $i8], $i5
	load    [$i5 + 1], $i1
	load    [$i7 + 1], $i9
	bne     $i1, 1, be_else.21738
be_then.21738:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	sub     $i8, 1, $i8
	b       iter_setup_dirvec_constants.2826
be_else.21738:
	bne     $i1, 2, be_else.21739
be_then.21739:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	sub     $i8, 1, $i8
	b       iter_setup_dirvec_constants.2826
be_else.21739:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	sub     $i8, 1, $i8
	b       iter_setup_dirvec_constants.2826
bge_else.21737:
	jr      $ra2
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i7)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
	sub     $ig0, 1, $i8
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f7]
# []
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bge_else.21740
bge_then.21740:
	load    [ext_objects + $i1], $i3
	load    [$i3 + 10], $i4
	load    [$i3 + 5], $i5
	load    [$i5 + 0], $f1
	load    [$i2 + 0], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 0]
	load    [$i5 + 1], $f1
	load    [$i2 + 1], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 1]
	load    [$i5 + 2], $f1
	load    [$i2 + 2], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 2]
	load    [$i3 + 1], $i5
	bne     $i5, 2, be_else.21741
be_then.21741:
	load    [$i3 + 4], $i3
	load    [$i3 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f1, $f2, $f1
	load    [$i3 + 1], $f2
	load    [$i4 + 1], $f3
	fmul    $f2, $f3, $f2
	load    [$i3 + 0], $f3
	load    [$i4 + 0], $f4
	fmul    $f3, $f4, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	store   $f1, [$i4 + 3]
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
be_else.21741:
	bg      $i5, 2, ble_else.21742
ble_then.21742:
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
ble_else.21742:
	load    [$i3 + 4], $i6
	load    [$i3 + 3], $i7
	load    [$i6 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i6 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i6 + 0], $f5
	load    [$i4 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i7, 0, bne_cont.21743
bne_then.21743:
	load    [$i3 + 9], $i3
	load    [$i3 + 2], $f3
	fmul    $f6, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i3 + 1], $f5
	fmul    $f2, $f6, $f6
	fmul    $f6, $f5, $f5
	load    [$i3 + 0], $f6
	fmul    $f4, $f2, $f2
	fmul    $f2, $f6, $f2
	fadd    $f1, $f2, $f1
	fadd    $f1, $f5, $f1
	fadd    $f1, $f3, $f1
bne_cont.21743:
	sub     $i1, 1, $i1
	bne     $i5, 3, be_else.21744
be_then.21744:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
be_else.21744:
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
bge_else.21740:
	ret
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f10]
# []
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21745
be_then.21745:
	li      1, $i1
	ret
be_else.21745:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i5, 1, be_else.21746
be_then.21746:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	load    [$i2 + 6], $i2
	bg      $f7, $f6, ble_else.21747
ble_then.21747:
	bne     $i2, 0, be_else.21748
be_then.21748:
	li      1, $i2
.count b_cont
	b       be_cont.21746
be_else.21748:
	li      0, $i2
.count b_cont
	b       be_cont.21746
ble_else.21747:
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21749
ble_then.21749:
	bne     $i2, 0, be_else.21750
be_then.21750:
	li      1, $i2
.count b_cont
	b       be_cont.21746
be_else.21750:
	li      0, $i2
.count b_cont
	b       be_cont.21746
ble_else.21749:
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, be_cont.21746
ble_then.21751:
	bne     $i2, 0, be_else.21752
be_then.21752:
	li      1, $i2
.count b_cont
	b       be_cont.21746
be_else.21752:
	li      0, $i2
.count b_cont
	b       be_cont.21746
be_else.21746:
	bne     $i5, 2, be_else.21753
be_then.21753:
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f6, $f5, $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21754
ble_then.21754:
	bne     $i2, 0, be_else.21755
be_then.21755:
	li      1, $i2
.count b_cont
	b       be_cont.21753
be_else.21755:
	li      0, $i2
.count b_cont
	b       be_cont.21753
ble_else.21754:
	bne     $i2, 0, be_else.21756
be_then.21756:
	li      0, $i2
.count b_cont
	b       be_cont.21753
be_else.21756:
	li      1, $i2
.count b_cont
	b       be_cont.21753
be_else.21753:
	fmul    $f6, $f6, $f7
	load    [$i4 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f1, $f8
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i4
	bne     $i4, 0, be_else.21757
be_then.21757:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21757
be_else.21757:
	fmul    $f5, $f1, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f6, $f1
	load    [$i4 + 1], $f8
	fmul    $f1, $f8, $f1
	fadd    $f7, $f1, $f1
	fmul    $f6, $f5, $f5
	load    [$i4 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
be_cont.21757:
	bne     $i5, 3, be_cont.21758
be_then.21758:
	fsub    $f1, $fc0, $f1
be_cont.21758:
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21759
ble_then.21759:
	bne     $i2, 0, be_else.21760
be_then.21760:
	li      1, $i2
.count b_cont
	b       ble_cont.21759
be_else.21760:
	li      0, $i2
.count b_cont
	b       ble_cont.21759
ble_else.21759:
	bne     $i2, 0, be_else.21761
be_then.21761:
	li      0, $i2
.count b_cont
	b       be_cont.21761
be_else.21761:
	li      1, $i2
be_cont.21761:
ble_cont.21759:
be_cont.21753:
be_cont.21746:
	bne     $i2, 0, be_else.21762
be_then.21762:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21763
be_then.21763:
	li      1, $i1
	ret
be_else.21763:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i5, 1, be_else.21764
be_then.21764:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	load    [$i2 + 6], $i2
	bg      $f7, $f6, ble_else.21765
ble_then.21765:
	bne     $i2, 0, be_else.21766
be_then.21766:
	li      1, $i2
.count b_cont
	b       be_cont.21764
be_else.21766:
	li      0, $i2
.count b_cont
	b       be_cont.21764
ble_else.21765:
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21767
ble_then.21767:
	bne     $i2, 0, be_else.21768
be_then.21768:
	li      1, $i2
.count b_cont
	b       be_cont.21764
be_else.21768:
	li      0, $i2
.count b_cont
	b       be_cont.21764
ble_else.21767:
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, be_cont.21764
ble_then.21769:
	bne     $i2, 0, be_else.21770
be_then.21770:
	li      1, $i2
.count b_cont
	b       be_cont.21764
be_else.21770:
	li      0, $i2
.count b_cont
	b       be_cont.21764
be_else.21764:
	load    [$i4 + 2], $f7
	bne     $i5, 2, be_else.21771
be_then.21771:
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21772
ble_then.21772:
	bne     $i2, 0, be_else.21773
be_then.21773:
	li      1, $i2
.count b_cont
	b       be_cont.21771
be_else.21773:
	li      0, $i2
.count b_cont
	b       be_cont.21771
ble_else.21772:
	bne     $i2, 0, be_else.21774
be_then.21774:
	li      0, $i2
.count b_cont
	b       be_cont.21771
be_else.21774:
	li      1, $i2
.count b_cont
	b       be_cont.21771
be_else.21771:
	load    [$i2 + 3], $i6
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i4 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i4 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	bne     $i6, 0, be_else.21775
be_then.21775:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21775
be_else.21775:
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i4 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i4 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.21775:
	bne     $i5, 3, be_cont.21776
be_then.21776:
	fsub    $f1, $fc0, $f1
be_cont.21776:
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21777
ble_then.21777:
	bne     $i2, 0, be_else.21778
be_then.21778:
	li      1, $i2
.count b_cont
	b       ble_cont.21777
be_else.21778:
	li      0, $i2
.count b_cont
	b       ble_cont.21777
ble_else.21777:
	bne     $i2, 0, be_else.21779
be_then.21779:
	li      0, $i2
.count b_cont
	b       be_cont.21779
be_else.21779:
	li      1, $i2
be_cont.21779:
ble_cont.21777:
be_cont.21771:
be_cont.21764:
	bne     $i2, 0, be_else.21780
be_then.21780:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21781
be_then.21781:
	li      1, $i1
	ret
be_else.21781:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 0], $f6
	fsub    $f2, $f6, $f6
	bne     $i5, 1, be_else.21782
be_then.21782:
	load    [$i2 + 4], $i4
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	load    [$i2 + 6], $i2
	bg      $f7, $f6, ble_else.21783
ble_then.21783:
	bne     $i2, 0, be_else.21784
be_then.21784:
	li      1, $i2
.count b_cont
	b       be_cont.21782
be_else.21784:
	li      0, $i2
.count b_cont
	b       be_cont.21782
ble_else.21783:
	fabs    $f5, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.21785
ble_then.21785:
	bne     $i2, 0, be_else.21786
be_then.21786:
	li      1, $i2
.count b_cont
	b       be_cont.21782
be_else.21786:
	li      0, $i2
.count b_cont
	b       be_cont.21782
ble_else.21785:
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, be_cont.21782
ble_then.21787:
	bne     $i2, 0, be_else.21788
be_then.21788:
	li      1, $i2
.count b_cont
	b       be_cont.21782
be_else.21788:
	li      0, $i2
.count b_cont
	b       be_cont.21782
be_else.21782:
	bne     $i5, 2, be_else.21789
be_then.21789:
	load    [$i2 + 4], $i4
	load    [$i2 + 6], $i2
	load    [$i4 + 2], $f7
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.21790
ble_then.21790:
	bne     $i2, 0, be_else.21791
be_then.21791:
	li      1, $i2
.count b_cont
	b       be_cont.21789
be_else.21791:
	li      0, $i2
.count b_cont
	b       be_cont.21789
ble_else.21790:
	bne     $i2, 0, be_else.21792
be_then.21792:
	li      0, $i2
.count b_cont
	b       be_cont.21789
be_else.21792:
	li      1, $i2
.count b_cont
	b       be_cont.21789
be_else.21789:
	load    [$i2 + 6], $i4
	load    [$i2 + 4], $i6
	load    [$i6 + 2], $f7
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i6 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i6 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	load    [$i2 + 3], $i6
	bne     $i6, 0, be_else.21793
be_then.21793:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21793
be_else.21793:
	fmul    $f5, $f1, $f8
	load    [$i2 + 9], $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f6, $f1
	load    [$i2 + 1], $f8
	fmul    $f1, $f8, $f1
	fadd    $f7, $f1, $f1
	fmul    $f6, $f5, $f5
	load    [$i2 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
be_cont.21793:
	bne     $i5, 3, be_cont.21794
be_then.21794:
	fsub    $f1, $fc0, $f1
be_cont.21794:
	bg      $f0, $f1, ble_else.21795
ble_then.21795:
	bne     $i4, 0, be_else.21796
be_then.21796:
	li      1, $i2
.count b_cont
	b       ble_cont.21795
be_else.21796:
	li      0, $i2
.count b_cont
	b       ble_cont.21795
ble_else.21795:
	bne     $i4, 0, be_else.21797
be_then.21797:
	li      0, $i2
.count b_cont
	b       be_cont.21797
be_else.21797:
	li      1, $i2
be_cont.21797:
ble_cont.21795:
be_cont.21789:
be_cont.21782:
	bne     $i2, 0, be_else.21798
be_then.21798:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21799
be_then.21799:
	li      1, $i1
	ret
be_else.21799:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i5, 1, be_else.21800
be_then.21800:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.21801
ble_then.21801:
	li      0, $i4
.count b_cont
	b       ble_cont.21801
ble_else.21801:
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21802
ble_then.21802:
	li      0, $i4
.count b_cont
	b       ble_cont.21802
ble_else.21802:
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.21803
ble_then.21803:
	li      0, $i4
.count b_cont
	b       ble_cont.21803
ble_else.21803:
	li      1, $i4
ble_cont.21803:
ble_cont.21802:
ble_cont.21801:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.21804
be_then.21804:
	bne     $i2, 0, be_else.21805
be_then.21805:
	li      0, $i1
	ret
be_else.21805:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21804:
	bne     $i2, 0, be_else.21806
be_then.21806:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21806:
	li      0, $i1
	ret
be_else.21800:
	load    [$i4 + 2], $f7
	bne     $i5, 2, be_else.21807
be_then.21807:
	load    [$i2 + 6], $i2
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.21808
ble_then.21808:
	li      0, $i4
.count b_cont
	b       ble_cont.21808
ble_else.21808:
	li      1, $i4
ble_cont.21808:
	bne     $i2, 0, be_else.21809
be_then.21809:
	bne     $i4, 0, be_else.21810
be_then.21810:
	li      0, $i1
	ret
be_else.21810:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21809:
	bne     $i4, 0, be_else.21811
be_then.21811:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21811:
	li      0, $i1
	ret
be_else.21807:
	load    [$i2 + 3], $i6
	load    [$i2 + 6], $i7
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i4 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i4 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	bne     $i6, 0, be_else.21812
be_then.21812:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21812
be_else.21812:
	load    [$i2 + 9], $i2
	load    [$i2 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i2 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i2 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.21812:
	bne     $i5, 3, be_cont.21813
be_then.21813:
	fsub    $f1, $fc0, $f1
be_cont.21813:
	bg      $f0, $f1, ble_else.21814
ble_then.21814:
	li      0, $i2
.count b_cont
	b       ble_cont.21814
ble_else.21814:
	li      1, $i2
ble_cont.21814:
	bne     $i7, 0, be_else.21815
be_then.21815:
	bne     $i2, 0, be_else.21816
be_then.21816:
	li      0, $i1
	ret
be_else.21816:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21815:
	bne     $i2, 0, be_else.21817
be_then.21817:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21817:
	li      0, $i1
	ret
be_else.21798:
	li      0, $i1
	ret
be_else.21780:
	li      0, $i1
	ret
be_else.21762:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i8, $i9)
# $ra = $ra1
# [$i1 - $i9]
# [$f1 - $f10]
# []
# [$fg0]
# [$ra]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i9 + $i8], $i1
	bne     $i1, -1, be_else.21818
be_then.21818:
	li      0, $i1
	jr      $ra1
be_else.21818:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 1], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i4 + $i1], $i4
	load    [$i5 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i5 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	bne     $i3, 1, be_else.21819
be_then.21819:
	load    [ext_light_dirvec + 0], $i3
	load    [$i4 + 1], $f4
	load    [$i4 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f6
	bg      $f6, $f5, ble_else.21820
ble_then.21820:
	li      0, $i5
.count b_cont
	b       ble_cont.21820
ble_else.21820:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21821
ble_then.21821:
	li      0, $i5
.count b_cont
	b       ble_cont.21821
ble_else.21821:
	load    [$i4 + 1], $f5
	bne     $f5, $f0, be_else.21822
be_then.21822:
	li      0, $i5
.count b_cont
	b       be_cont.21822
be_else.21822:
	li      1, $i5
be_cont.21822:
ble_cont.21821:
ble_cont.21820:
	bne     $i5, 0, be_else.21823
be_then.21823:
	load    [$i4 + 3], $f4
	load    [$i4 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i2 + 0], $f6
	bg      $f6, $f5, ble_else.21824
ble_then.21824:
	li      0, $i5
.count b_cont
	b       ble_cont.21824
ble_else.21824:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21825
ble_then.21825:
	li      0, $i5
.count b_cont
	b       ble_cont.21825
ble_else.21825:
	load    [$i4 + 3], $f5
	bne     $f5, $f0, be_else.21826
be_then.21826:
	li      0, $i5
.count b_cont
	b       be_cont.21826
be_else.21826:
	li      1, $i5
be_cont.21826:
ble_cont.21825:
ble_cont.21824:
	bne     $i5, 0, be_else.21827
be_then.21827:
	load    [$i4 + 5], $f4
	load    [$i4 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i2 + 0], $f4
	bg      $f4, $f3, ble_else.21828
ble_then.21828:
	li      0, $i2
.count b_cont
	b       be_cont.21819
ble_else.21828:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i2 + 1], $f3
	bg      $f3, $f2, ble_else.21829
ble_then.21829:
	li      0, $i2
.count b_cont
	b       be_cont.21819
ble_else.21829:
	load    [$i4 + 5], $f2
	bne     $f2, $f0, be_else.21830
be_then.21830:
	li      0, $i2
.count b_cont
	b       be_cont.21819
be_else.21830:
	mov     $f1, $fg0
	li      3, $i2
.count b_cont
	b       be_cont.21819
be_else.21827:
	mov     $f4, $fg0
	li      2, $i2
.count b_cont
	b       be_cont.21819
be_else.21823:
	mov     $f4, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21819
be_else.21819:
	load    [$i4 + 0], $f4
	bne     $i3, 2, be_else.21831
be_then.21831:
	bg      $f0, $f4, ble_else.21832
ble_then.21832:
	li      0, $i2
.count b_cont
	b       be_cont.21831
ble_else.21832:
	load    [$i4 + 3], $f4
	fmul    $f4, $f1, $f1
	load    [$i4 + 2], $f4
	fmul    $f4, $f2, $f2
	load    [$i4 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21831
be_else.21831:
	bne     $f4, $f0, be_else.21833
be_then.21833:
	li      0, $i2
.count b_cont
	b       be_cont.21833
be_else.21833:
	fmul    $f3, $f3, $f5
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f6
	fmul    $f5, $f6, $f5
	fmul    $f2, $f2, $f6
	load    [$i5 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f1, $f6
	load    [$i5 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i5
	be      $i5, 0, bne_cont.21834
bne_then.21834:
	fmul    $f2, $f1, $f6
	load    [$i2 + 9], $i5
	load    [$i5 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f3, $f6
	load    [$i5 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f2, $f6
	load    [$i5 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
bne_cont.21834:
	bne     $i3, 3, be_cont.21835
be_then.21835:
	fsub    $f5, $fc0, $f5
be_cont.21835:
	fmul    $f4, $f5, $f4
	load    [$i4 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i4 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i4 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.21836
ble_then.21836:
	li      0, $i2
.count b_cont
	b       ble_cont.21836
ble_else.21836:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i4 + 4], $f3
	bne     $i2, 0, be_else.21837
be_then.21837:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21837
be_else.21837:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i2
be_cont.21837:
ble_cont.21836:
be_cont.21833:
be_cont.21831:
be_cont.21819:
	bne     $i2, 0, be_else.21838
be_then.21838:
	li      0, $i2
.count b_cont
	b       be_cont.21838
be_else.21838:
.count load_float
	load    [f.21458], $f1
	bg      $f1, $fg0, ble_else.21839
ble_then.21839:
	li      0, $i2
.count b_cont
	b       ble_cont.21839
ble_else.21839:
	li      1, $i2
ble_cont.21839:
be_cont.21838:
	bne     $i2, 0, be_else.21840
be_then.21840:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21841
be_then.21841:
	li      0, $i1
	jr      $ra1
be_else.21841:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
be_else.21840:
	load    [$i9 + 0], $i1
	bne     $i1, -1, be_else.21842
be_then.21842:
	li      1, $i1
	jr      $ra1
be_else.21842:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 1], $i3
	load    [ext_intersection_point + 2], $f1
	fadd    $fg0, $fc15, $f2
	fmul    $fg13, $f2, $f3
	fadd    $f3, $f1, $f4
	load    [$i2 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [ext_intersection_point + 1], $f3
	fmul    $fg12, $f2, $f5
	fadd    $f5, $f3, $f3
	load    [$i2 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [ext_intersection_point + 0], $f6
	fmul    $fg15, $f2, $f2
	fadd    $f2, $f6, $f2
	load    [$i2 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i1 + 4], $i2
	bne     $i3, 1, be_else.21843
be_then.21843:
	fabs    $f6, $f6
	load    [$i2 + 0], $f7
	load    [$i1 + 6], $i1
	bg      $f7, $f6, ble_else.21844
ble_then.21844:
	bne     $i1, 0, be_else.21845
be_then.21845:
	li      1, $i1
.count b_cont
	b       be_cont.21843
be_else.21845:
	li      0, $i1
.count b_cont
	b       be_cont.21843
ble_else.21844:
	load    [$i2 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21846
ble_then.21846:
	bne     $i1, 0, be_else.21847
be_then.21847:
	li      1, $i1
.count b_cont
	b       be_cont.21843
be_else.21847:
	li      0, $i1
.count b_cont
	b       be_cont.21843
ble_else.21846:
	load    [$i2 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, be_cont.21843
ble_then.21848:
	bne     $i1, 0, be_else.21849
be_then.21849:
	li      1, $i1
.count b_cont
	b       be_cont.21843
be_else.21849:
	li      0, $i1
.count b_cont
	b       be_cont.21843
be_else.21843:
	load    [$i2 + 2], $f7
	bne     $i3, 2, be_else.21850
be_then.21850:
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i2 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.21851
ble_then.21851:
	bne     $i1, 0, be_else.21852
be_then.21852:
	li      1, $i1
.count b_cont
	b       be_cont.21850
be_else.21852:
	li      0, $i1
.count b_cont
	b       be_cont.21850
ble_else.21851:
	bne     $i1, 0, be_else.21853
be_then.21853:
	li      0, $i1
.count b_cont
	b       be_cont.21850
be_else.21853:
	li      1, $i1
.count b_cont
	b       be_cont.21850
be_else.21850:
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i2 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i2 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	load    [$i1 + 3], $i2
	bne     $i2, 0, be_else.21854
be_then.21854:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21854
be_else.21854:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i2 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i2 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.21854:
	bne     $i3, 3, be_cont.21855
be_then.21855:
	fsub    $f1, $fc0, $f1
be_cont.21855:
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.21856
ble_then.21856:
	bne     $i1, 0, be_else.21857
be_then.21857:
	li      1, $i1
.count b_cont
	b       ble_cont.21856
be_else.21857:
	li      0, $i1
.count b_cont
	b       ble_cont.21856
ble_else.21856:
	bne     $i1, 0, be_else.21858
be_then.21858:
	li      0, $i1
.count b_cont
	b       be_cont.21858
be_else.21858:
	li      1, $i1
be_cont.21858:
ble_cont.21856:
be_cont.21850:
be_cont.21843:
	bne     $i1, 0, be_else.21859
be_then.21859:
	li      1, $i1
.count move_args
	mov     $i9, $i3
	call    check_all_inside.2856
	bne     $i1, 0, be_else.21860
be_then.21860:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
be_else.21860:
	li      1, $i1
	jr      $ra1
be_else.21859:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i10, $i11)
# $ra = $ra2
# [$i1 - $i11]
# [$f1 - $f10]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21861
be_then.21861:
	li      0, $i1
	jr      $ra2
be_else.21861:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21862
be_then.21862:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21863
be_then.21863:
	li      0, $i1
	jr      $ra2
be_else.21863:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21864
be_then.21864:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21865
be_then.21865:
	li      0, $i1
	jr      $ra2
be_else.21865:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21866
be_then.21866:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21867
be_then.21867:
	li      0, $i1
	jr      $ra2
be_else.21867:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21868
be_then.21868:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21869
be_then.21869:
	li      0, $i1
	jr      $ra2
be_else.21869:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21870
be_then.21870:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21871
be_then.21871:
	li      0, $i1
	jr      $ra2
be_else.21871:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21872
be_then.21872:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21873
be_then.21873:
	li      0, $i1
	jr      $ra2
be_else.21873:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21874
be_then.21874:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21875
be_then.21875:
	li      0, $i1
	jr      $ra2
be_else.21875:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21876
be_then.21876:
	add     $i10, 1, $i10
	b       shadow_check_one_or_group.2865
be_else.21876:
	li      1, $i1
	jr      $ra2
be_else.21874:
	li      1, $i1
	jr      $ra2
be_else.21872:
	li      1, $i1
	jr      $ra2
be_else.21870:
	li      1, $i1
	jr      $ra2
be_else.21868:
	li      1, $i1
	jr      $ra2
be_else.21866:
	li      1, $i1
	jr      $ra2
be_else.21864:
	li      1, $i1
	jr      $ra2
be_else.21862:
	li      1, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i12, $i13)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f10]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.21877
be_then.21877:
	li      0, $i1
	jr      $ra3
be_else.21877:
	bne     $i1, 99, be_else.21878
be_then.21878:
	li      1, $i1
.count b_cont
	b       be_cont.21878
be_else.21878:
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
	bne     $i3, 1, be_else.21879
be_then.21879:
	load    [ext_light_dirvec + 0], $i3
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f6
	bg      $f6, $f5, ble_else.21880
ble_then.21880:
	li      0, $i4
.count b_cont
	b       ble_cont.21880
ble_else.21880:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.21881
ble_then.21881:
	li      0, $i4
.count b_cont
	b       ble_cont.21881
ble_else.21881:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21882
be_then.21882:
	li      0, $i4
.count b_cont
	b       be_cont.21882
be_else.21882:
	li      1, $i4
be_cont.21882:
ble_cont.21881:
ble_cont.21880:
	bne     $i4, 0, be_else.21883
be_then.21883:
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i2 + 0], $f6
	bg      $f6, $f5, ble_else.21884
ble_then.21884:
	li      0, $i4
.count b_cont
	b       ble_cont.21884
ble_else.21884:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.21885
ble_then.21885:
	li      0, $i4
.count b_cont
	b       ble_cont.21885
ble_else.21885:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.21886
be_then.21886:
	li      0, $i4
.count b_cont
	b       be_cont.21886
be_else.21886:
	li      1, $i4
be_cont.21886:
ble_cont.21885:
ble_cont.21884:
	bne     $i4, 0, be_else.21887
be_then.21887:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f3, $f3
	fmul    $f3, $f4, $f3
	load    [$i3 + 0], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f1, $f1
	load    [$i2 + 0], $f4
	bg      $f4, $f1, ble_else.21888
ble_then.21888:
	li      0, $i1
.count b_cont
	b       be_cont.21879
ble_else.21888:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	load    [$i2 + 1], $f2
	bg      $f2, $f1, ble_else.21889
ble_then.21889:
	li      0, $i1
.count b_cont
	b       be_cont.21879
ble_else.21889:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.21890
be_then.21890:
	li      0, $i1
.count b_cont
	b       be_cont.21879
be_else.21890:
	mov     $f3, $fg0
	li      3, $i1
.count b_cont
	b       be_cont.21879
be_else.21887:
	mov     $f4, $fg0
	li      2, $i1
.count b_cont
	b       be_cont.21879
be_else.21883:
	mov     $f4, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.21879
be_else.21879:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.21891
be_then.21891:
	bg      $f0, $f4, ble_else.21892
ble_then.21892:
	li      0, $i1
.count b_cont
	b       be_cont.21891
ble_else.21892:
	load    [$i1 + 3], $f4
	fmul    $f4, $f3, $f3
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.21891
be_else.21891:
	bne     $f4, $f0, be_else.21893
be_then.21893:
	li      0, $i1
.count b_cont
	b       be_cont.21893
be_else.21893:
	fmul    $f1, $f1, $f5
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f6
	fmul    $f5, $f6, $f5
	fmul    $f2, $f2, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f3, $f6
	load    [$i4 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i4
	be      $i4, 0, bne_cont.21894
bne_then.21894:
	fmul    $f2, $f3, $f6
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f1, $f6
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f2, $f6
	load    [$i4 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
bne_cont.21894:
	bne     $i3, 3, be_cont.21895
be_then.21895:
	fsub    $f5, $fc0, $f5
be_cont.21895:
	fmul    $f4, $f5, $f4
	load    [$i1 + 3], $f5
	fmul    $f5, $f3, $f3
	load    [$i1 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i1 + 1], $f5
	fmul    $f5, $f1, $f1
	fadd    $f1, $f2, $f1
	fadd    $f1, $f3, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.21896
ble_then.21896:
	li      0, $i1
.count b_cont
	b       ble_cont.21896
ble_else.21896:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.21897
be_then.21897:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.21897
be_else.21897:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
be_cont.21897:
ble_cont.21896:
be_cont.21893:
be_cont.21891:
be_cont.21879:
	bne     $i1, 0, be_else.21898
be_then.21898:
	li      0, $i1
.count b_cont
	b       be_cont.21898
be_else.21898:
	bg      $fc7, $fg0, ble_else.21899
ble_then.21899:
	li      0, $i1
.count b_cont
	b       ble_cont.21899
ble_else.21899:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21900
be_then.21900:
	li      0, $i1
.count b_cont
	b       be_cont.21900
be_else.21900:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21901
be_then.21901:
	li      2, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21902
be_then.21902:
	li      0, $i1
.count b_cont
	b       be_cont.21901
be_else.21902:
	li      1, $i1
.count b_cont
	b       be_cont.21901
be_else.21901:
	li      1, $i1
be_cont.21901:
be_cont.21900:
ble_cont.21899:
be_cont.21898:
be_cont.21878:
	bne     $i1, 0, be_else.21903
be_then.21903:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.21904
be_then.21904:
	li      0, $i1
	jr      $ra3
be_else.21904:
	bne     $i1, 99, be_else.21905
be_then.21905:
	li      1, $i1
.count b_cont
	b       be_cont.21905
be_else.21905:
	call    solver_fast.2796
	bne     $i1, 0, be_else.21906
be_then.21906:
	li      0, $i1
.count b_cont
	b       be_cont.21906
be_else.21906:
	bg      $fc7, $fg0, ble_else.21907
ble_then.21907:
	li      0, $i1
.count b_cont
	b       ble_cont.21907
ble_else.21907:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21908
be_then.21908:
	li      0, $i1
.count b_cont
	b       be_cont.21908
be_else.21908:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21909
be_then.21909:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.21910
be_then.21910:
	li      0, $i1
.count b_cont
	b       be_cont.21909
be_else.21910:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21911
be_then.21911:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21912
be_then.21912:
	li      0, $i1
.count b_cont
	b       be_cont.21909
be_else.21912:
	li      1, $i1
.count b_cont
	b       be_cont.21909
be_else.21911:
	li      1, $i1
.count b_cont
	b       be_cont.21909
be_else.21909:
	li      1, $i1
be_cont.21909:
be_cont.21908:
ble_cont.21907:
be_cont.21906:
be_cont.21905:
	bne     $i1, 0, be_else.21913
be_then.21913:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21913:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21914
be_then.21914:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21914:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21915
be_then.21915:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.21916
be_then.21916:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21916:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21917
be_then.21917:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21918
be_then.21918:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21918:
	li      1, $i1
	jr      $ra3
be_else.21917:
	li      1, $i1
	jr      $ra3
be_else.21915:
	li      1, $i1
	jr      $ra3
be_else.21903:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21919
be_then.21919:
	li      0, $i1
.count b_cont
	b       be_cont.21919
be_else.21919:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21920
be_then.21920:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.21921
be_then.21921:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21921:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21922
be_then.21922:
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.21923
be_then.21923:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21923:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21924
be_then.21924:
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.21925
be_then.21925:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21925:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21926
be_then.21926:
	load    [$i14 + 5], $i1
	bne     $i1, -1, be_else.21927
be_then.21927:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21927:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21928
be_then.21928:
	load    [$i14 + 6], $i1
	bne     $i1, -1, be_else.21929
be_then.21929:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21929:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21930
be_then.21930:
	load    [$i14 + 7], $i1
	bne     $i1, -1, be_else.21931
be_then.21931:
	li      0, $i1
.count b_cont
	b       be_cont.21920
be_else.21931:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21932
be_then.21932:
	li      8, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
.count b_cont
	b       be_cont.21920
be_else.21932:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21930:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21928:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21926:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21924:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21922:
	li      1, $i1
.count b_cont
	b       be_cont.21920
be_else.21920:
	li      1, $i1
be_cont.21920:
be_cont.21919:
	bne     $i1, 0, be_else.21933
be_then.21933:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.21934
be_then.21934:
	li      0, $i1
	jr      $ra3
be_else.21934:
	bne     $i1, 99, be_else.21935
be_then.21935:
	li      1, $i1
.count b_cont
	b       be_cont.21935
be_else.21935:
	call    solver_fast.2796
	bne     $i1, 0, be_else.21936
be_then.21936:
	li      0, $i1
.count b_cont
	b       be_cont.21936
be_else.21936:
	bg      $fc7, $fg0, ble_else.21937
ble_then.21937:
	li      0, $i1
.count b_cont
	b       ble_cont.21937
ble_else.21937:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21938
be_then.21938:
	li      0, $i1
.count b_cont
	b       be_cont.21938
be_else.21938:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21939
be_then.21939:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.21940
be_then.21940:
	li      0, $i1
.count b_cont
	b       be_cont.21939
be_else.21940:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21941
be_then.21941:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21942
be_then.21942:
	li      0, $i1
.count b_cont
	b       be_cont.21939
be_else.21942:
	li      1, $i1
.count b_cont
	b       be_cont.21939
be_else.21941:
	li      1, $i1
.count b_cont
	b       be_cont.21939
be_else.21939:
	li      1, $i1
be_cont.21939:
be_cont.21938:
ble_cont.21937:
be_cont.21936:
be_cont.21935:
	bne     $i1, 0, be_else.21943
be_then.21943:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21943:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.21944
be_then.21944:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21944:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21945
be_then.21945:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.21946
be_then.21946:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21946:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21947
be_then.21947:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21948
be_then.21948:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
be_else.21948:
	li      1, $i1
	jr      $ra3
be_else.21947:
	li      1, $i1
	jr      $ra3
be_else.21945:
	li      1, $i1
	jr      $ra3
be_else.21933:
	li      1, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i8, $i9, $i10)
# $ra = $ra1
# [$i1 - $i12]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i9 + $i8], $i11
	bne     $i11, -1, be_else.21949
be_then.21949:
	jr      $ra1
be_else.21949:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 1], $i2
	load    [$i1 + 5], $i3
	load    [$i3 + 2], $f1
	fsub    $fg19, $f1, $f1
	load    [$i3 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i3 + 0], $f3
	fsub    $fg17, $f3, $f3
	bne     $i2, 1, be_else.21950
be_then.21950:
	load    [$i10 + 0], $f4
	bne     $f4, $f0, be_else.21951
be_then.21951:
	li      0, $i2
.count b_cont
	b       be_cont.21951
be_else.21951:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.21952
ble_then.21952:
	li      0, $i4
.count b_cont
	b       ble_cont.21952
ble_else.21952:
	li      1, $i4
ble_cont.21952:
	bne     $i3, 0, be_else.21953
be_then.21953:
	mov     $i4, $i3
.count b_cont
	b       be_cont.21953
be_else.21953:
	bne     $i4, 0, be_else.21954
be_then.21954:
	li      1, $i3
.count b_cont
	b       be_cont.21954
be_else.21954:
	li      0, $i3
be_cont.21954:
be_cont.21953:
	load    [$i2 + 0], $f5
	bne     $i3, 0, be_cont.21955
be_then.21955:
	fneg    $f5, $f5
be_cont.21955:
	fsub    $f5, $f3, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	load    [$i10 + 1], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.21956
ble_then.21956:
	li      0, $i2
.count b_cont
	b       ble_cont.21956
ble_else.21956:
	load    [$i2 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21957
ble_then.21957:
	li      0, $i2
.count b_cont
	b       ble_cont.21957
ble_else.21957:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.21957:
ble_cont.21956:
be_cont.21951:
	bne     $i2, 0, be_else.21958
be_then.21958:
	load    [$i10 + 1], $f4
	bne     $f4, $f0, be_else.21959
be_then.21959:
	li      0, $i2
.count b_cont
	b       be_cont.21959
be_else.21959:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.21960
ble_then.21960:
	li      0, $i4
.count b_cont
	b       ble_cont.21960
ble_else.21960:
	li      1, $i4
ble_cont.21960:
	bne     $i3, 0, be_else.21961
be_then.21961:
	mov     $i4, $i3
.count b_cont
	b       be_cont.21961
be_else.21961:
	bne     $i4, 0, be_else.21962
be_then.21962:
	li      1, $i3
.count b_cont
	b       be_cont.21962
be_else.21962:
	li      0, $i3
be_cont.21962:
be_cont.21961:
	load    [$i2 + 1], $f5
	bne     $i3, 0, be_cont.21963
be_then.21963:
	fneg    $f5, $f5
be_cont.21963:
	fsub    $f5, $f2, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21964
ble_then.21964:
	li      0, $i2
.count b_cont
	b       ble_cont.21964
ble_else.21964:
	load    [$i2 + 0], $f5
	load    [$i10 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.21965
ble_then.21965:
	li      0, $i2
.count b_cont
	b       ble_cont.21965
ble_else.21965:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.21965:
ble_cont.21964:
be_cont.21959:
	bne     $i2, 0, be_else.21966
be_then.21966:
	load    [$i10 + 2], $f4
	bne     $f4, $f0, be_else.21967
be_then.21967:
	li      0, $i12
.count b_cont
	b       be_cont.21950
be_else.21967:
	finv    $f4, $f5
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f6
	bg      $f0, $f4, ble_else.21968
ble_then.21968:
	li      0, $i3
.count b_cont
	b       ble_cont.21968
ble_else.21968:
	li      1, $i3
ble_cont.21968:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21969
be_then.21969:
	mov     $i3, $i1
.count b_cont
	b       be_cont.21969
be_else.21969:
	bne     $i3, 0, be_else.21970
be_then.21970:
	li      1, $i1
.count b_cont
	b       be_cont.21970
be_else.21970:
	li      0, $i1
be_cont.21970:
be_cont.21969:
	bne     $i1, 0, be_else.21971
be_then.21971:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21971
be_else.21971:
	mov     $f6, $f4
be_cont.21971:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f5, $f1
	load    [$i10 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i2 + 0], $f4
	bg      $f4, $f3, ble_else.21972
ble_then.21972:
	li      0, $i12
.count b_cont
	b       be_cont.21950
ble_else.21972:
	load    [$i10 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i2 + 1], $f3
	bg      $f3, $f2, ble_else.21973
ble_then.21973:
	li      0, $i12
.count b_cont
	b       be_cont.21950
ble_else.21973:
	mov     $f1, $fg0
	li      3, $i12
.count b_cont
	b       be_cont.21950
be_else.21966:
	li      2, $i12
.count b_cont
	b       be_cont.21950
be_else.21958:
	li      1, $i12
.count b_cont
	b       be_cont.21950
be_else.21950:
	bne     $i2, 2, be_else.21974
be_then.21974:
	load    [$i1 + 4], $i1
	load    [$i10 + 0], $f4
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [$i10 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [$i10 + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	bg      $f4, $f0, ble_else.21975
ble_then.21975:
	li      0, $i12
.count b_cont
	b       be_cont.21974
ble_else.21975:
	finv    $f4, $f4
	fmul    $f5, $f3, $f3
	fmul    $f7, $f2, $f2
	fadd    $f3, $f2, $f2
	fmul    $f8, $f1, $f1
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f4, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.21974
be_else.21974:
	load    [$i1 + 4], $i3
	load    [$i1 + 3], $i4
	load    [$i3 + 2], $f4
	load    [$i10 + 2], $f5
	fmul    $f5, $f5, $f6
	fmul    $f6, $f4, $f6
	load    [$i3 + 1], $f7
	load    [$i10 + 1], $f8
	fmul    $f8, $f8, $f9
	fmul    $f9, $f7, $f9
	load    [$i3 + 0], $f10
	load    [$i10 + 0], $f11
	fmul    $f11, $f11, $f12
	fmul    $f12, $f10, $f12
	fadd    $f12, $f9, $f9
	fadd    $f9, $f6, $f6
	be      $i4, 0, bne_cont.21976
bne_then.21976:
	fmul    $f8, $f5, $f9
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
	fmul    $f5, $f11, $f9
	load    [$i3 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
	fmul    $f11, $f8, $f9
	load    [$i3 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
bne_cont.21976:
	bne     $f6, $f0, be_else.21977
be_then.21977:
	li      0, $i12
.count b_cont
	b       be_cont.21977
be_else.21977:
	fmul    $f1, $f1, $f9
	fmul    $f9, $f4, $f9
	fmul    $f2, $f2, $f12
	fmul    $f12, $f7, $f12
	fmul    $f3, $f3, $f13
	fmul    $f13, $f10, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f9, $f9
	be      $i4, 0, bne_cont.21978
bne_then.21978:
	fmul    $f2, $f1, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
	fmul    $f1, $f3, $f12
	load    [$i3 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
	fmul    $f3, $f2, $f12
	load    [$i3 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
bne_cont.21978:
	bne     $i2, 3, be_cont.21979
be_then.21979:
	fsub    $f9, $fc0, $f9
be_cont.21979:
	fmul    $f6, $f9, $f9
	fmul    $f5, $f1, $f12
	fmul    $f12, $f4, $f4
	fmul    $f8, $f2, $f12
	fmul    $f12, $f7, $f7
	fmul    $f11, $f3, $f12
	fmul    $f12, $f10, $f10
	fadd    $f10, $f7, $f7
	fadd    $f7, $f4, $f4
	bne     $i4, 0, be_else.21980
be_then.21980:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21980
be_else.21980:
	fmul    $f5, $f2, $f7
	fmul    $f8, $f1, $f10
	fadd    $f7, $f10, $f7
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f10
	fmul    $f7, $f10, $f7
	fmul    $f11, $f1, $f1
	fmul    $f5, $f3, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 1], $f5
	fmul    $f1, $f5, $f1
	fadd    $f7, $f1, $f1
	fmul    $f11, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
be_cont.21980:
	fmul    $f1, $f1, $f2
	fsub    $f2, $f9, $f2
	bg      $f2, $f0, ble_else.21981
ble_then.21981:
	li      0, $i12
.count b_cont
	b       ble_cont.21981
ble_else.21981:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	li      1, $i12
	finv    $f6, $f3
	bne     $i1, 0, be_else.21982
be_then.21982:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.21982
be_else.21982:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
be_cont.21982:
ble_cont.21981:
be_cont.21977:
be_cont.21974:
be_cont.21950:
	bne     $i12, 0, be_else.21983
be_then.21983:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21984
be_then.21984:
	jr      $ra1
be_else.21984:
	add     $i8, 1, $i8
	b       solve_each_element.2871
be_else.21983:
	bg      $fg0, $f0, ble_else.21985
ble_then.21985:
	add     $i8, 1, $i8
	b       solve_each_element.2871
ble_else.21985:
	bg      $fg7, $fg0, ble_else.21986
ble_then.21986:
	add     $i8, 1, $i8
	b       solve_each_element.2871
ble_else.21986:
	fadd    $fg0, $fc15, $f11
	load    [$i10 + 2], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg19, $f12
	load    [$i10 + 1], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg18, $f13
	load    [$i10 + 0], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg17, $f14
	li      0, $i1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f14, $f2
.count move_args
	mov     $f13, $f3
.count move_args
	mov     $f12, $f4
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element.2871
	mov     $f11, $fg7
	store   $f14, [ext_intersection_point + 0]
	store   $f13, [ext_intersection_point + 1]
	store   $f12, [ext_intersection_point + 2]
	mov     $i11, $ig4
	mov     $i12, $ig2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21988
be_then.21988:
	jr      $ra2
be_else.21988:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21989
be_then.21989:
	jr      $ra2
be_else.21989:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21990
be_then.21990:
	jr      $ra2
be_else.21990:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21991
be_then.21991:
	jr      $ra2
be_else.21991:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21992
be_then.21992:
	jr      $ra2
be_else.21992:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21993
be_then.21993:
	jr      $ra2
be_else.21993:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21994
be_then.21994:
	jr      $ra2
be_else.21994:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.21995
be_then.21995:
	jr      $ra2
be_else.21995:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i16, $i17, $i18)
# $ra = $ra3
# [$i1 - $i18]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.21996
be_then.21996:
	jr      $ra3
be_else.21996:
	bne     $i1, 99, be_else.21997
be_then.21997:
	load    [$i14 + 1], $i1
	be      $i1, -1, bne_cont.21998
bne_then.21998:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, bne_cont.21999
bne_then.21999:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, bne_cont.22000
bne_then.22000:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, bne_cont.22001
bne_then.22001:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 5], $i1
	be      $i1, -1, bne_cont.22002
bne_then.22002:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 6], $i1
	be      $i1, -1, bne_cont.22003
bne_then.22003:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	li      7, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
bne_cont.22003:
bne_cont.22002:
bne_cont.22001:
bne_cont.22000:
bne_cont.21999:
bne_cont.21998:
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22004
be_then.22004:
	jr      $ra3
be_else.22004:
	bne     $i1, 99, be_else.22005
be_then.22005:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22006
be_then.22006:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22006:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22007
be_then.22007:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22007:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.22008
be_then.22008:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22008:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.22009
be_then.22009:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22009:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	li      5, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22005:
.count move_args
	mov     $i18, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22010
be_then.22010:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22010:
	bg      $fg7, $fg0, ble_else.22011
ble_then.22011:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
ble_else.22011:
	li      1, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.21997:
.count move_args
	mov     $i18, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22012
be_then.22012:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
be_else.22012:
	bg      $fg7, $fg0, ble_else.22013
ble_then.22013:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
ble_else.22013:
	li      1, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i8, $i9, $i10)
# $ra = $ra1
# [$i1 - $i12]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i9 + $i8], $i11
	bne     $i11, -1, be_else.22014
be_then.22014:
	jr      $ra1
be_else.22014:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 10], $i2
	load    [$i1 + 1], $i3
	load    [$i10 + 1], $i4
	load    [$i4 + $i11], $i4
	load    [$i2 + 2], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 0], $f3
	bne     $i3, 1, be_else.22015
be_then.22015:
	load    [$i10 + 0], $i2
	load    [$i4 + 1], $f4
	load    [$i4 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f6
	bg      $f6, $f5, ble_else.22016
ble_then.22016:
	li      0, $i3
.count b_cont
	b       ble_cont.22016
ble_else.22016:
	load    [$i1 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22017
ble_then.22017:
	li      0, $i3
.count b_cont
	b       ble_cont.22017
ble_else.22017:
	load    [$i4 + 1], $f5
	bne     $f5, $f0, be_else.22018
be_then.22018:
	li      0, $i3
.count b_cont
	b       be_cont.22018
be_else.22018:
	li      1, $i3
be_cont.22018:
ble_cont.22017:
ble_cont.22016:
	bne     $i3, 0, be_else.22019
be_then.22019:
	load    [$i4 + 3], $f4
	load    [$i4 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i1 + 0], $f6
	bg      $f6, $f5, ble_else.22020
ble_then.22020:
	li      0, $i3
.count b_cont
	b       ble_cont.22020
ble_else.22020:
	load    [$i1 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22021
ble_then.22021:
	li      0, $i3
.count b_cont
	b       ble_cont.22021
ble_else.22021:
	load    [$i4 + 3], $f5
	bne     $f5, $f0, be_else.22022
be_then.22022:
	li      0, $i3
.count b_cont
	b       be_cont.22022
be_else.22022:
	li      1, $i3
be_cont.22022:
ble_cont.22021:
ble_cont.22020:
	bne     $i3, 0, be_else.22023
be_then.22023:
	load    [$i4 + 5], $f4
	load    [$i4 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i1 + 0], $f4
	bg      $f4, $f3, ble_else.22024
ble_then.22024:
	li      0, $i12
.count b_cont
	b       be_cont.22015
ble_else.22024:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i1 + 1], $f3
	bg      $f3, $f2, ble_else.22025
ble_then.22025:
	li      0, $i12
.count b_cont
	b       be_cont.22015
ble_else.22025:
	load    [$i4 + 5], $f2
	bne     $f2, $f0, be_else.22026
be_then.22026:
	li      0, $i12
.count b_cont
	b       be_cont.22015
be_else.22026:
	mov     $f1, $fg0
	li      3, $i12
.count b_cont
	b       be_cont.22015
be_else.22023:
	mov     $f4, $fg0
	li      2, $i12
.count b_cont
	b       be_cont.22015
be_else.22019:
	mov     $f4, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.22015
be_else.22015:
	bne     $i3, 2, be_else.22027
be_then.22027:
	load    [$i4 + 0], $f1
	bg      $f0, $f1, ble_else.22028
ble_then.22028:
	li      0, $i12
.count b_cont
	b       be_cont.22027
ble_else.22028:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.22027
be_else.22027:
	load    [$i4 + 0], $f4
	bne     $f4, $f0, be_else.22029
be_then.22029:
	li      0, $i12
.count b_cont
	b       be_cont.22029
be_else.22029:
	load    [$i2 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i4 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i4 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i4 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.22030
ble_then.22030:
	li      0, $i12
.count b_cont
	b       ble_cont.22030
ble_else.22030:
	load    [$i1 + 6], $i1
	li      1, $i12
	fsqrt   $f2, $f2
	load    [$i4 + 4], $f3
	bne     $i1, 0, be_else.22031
be_then.22031:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.22031
be_else.22031:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
be_cont.22031:
ble_cont.22030:
be_cont.22029:
be_cont.22027:
be_cont.22015:
	bne     $i12, 0, be_else.22032
be_then.22032:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22033
be_then.22033:
	jr      $ra1
be_else.22033:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
be_else.22032:
	bg      $fg0, $f0, ble_else.22034
ble_then.22034:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
ble_else.22034:
	load    [$i10 + 0], $i1
	bg      $fg7, $fg0, ble_else.22035
ble_then.22035:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
ble_else.22035:
	fadd    $fg0, $fc15, $f11
	load    [$i1 + 2], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg10, $f12
	load    [$i1 + 1], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg9, $f13
	load    [$i1 + 0], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg8, $f14
	li      0, $i1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f14, $f2
.count move_args
	mov     $f13, $f3
.count move_args
	mov     $f12, $f4
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element_fast.2885
	mov     $f11, $fg7
	store   $f14, [ext_intersection_point + 0]
	store   $f13, [ext_intersection_point + 1]
	store   $f12, [ext_intersection_point + 2]
	mov     $i11, $ig4
	mov     $i12, $ig2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22037
be_then.22037:
	jr      $ra2
be_else.22037:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22038
be_then.22038:
	jr      $ra2
be_else.22038:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22039
be_then.22039:
	jr      $ra2
be_else.22039:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22040
be_then.22040:
	jr      $ra2
be_else.22040:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22041
be_then.22041:
	jr      $ra2
be_else.22041:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22042
be_then.22042:
	jr      $ra2
be_else.22042:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22043
be_then.22043:
	jr      $ra2
be_else.22043:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, be_else.22044
be_then.22044:
	jr      $ra2
be_else.22044:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i16, $i17, $i18)
# $ra = $ra3
# [$i1 - $i18]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22045
be_then.22045:
	jr      $ra3
be_else.22045:
	bne     $i1, 99, be_else.22046
be_then.22046:
	load    [$i14 + 1], $i1
	be      $i1, -1, bne_cont.22047
bne_then.22047:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, bne_cont.22048
bne_then.22048:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, bne_cont.22049
bne_then.22049:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, bne_cont.22050
bne_then.22050:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 5], $i1
	be      $i1, -1, bne_cont.22051
bne_then.22051:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 6], $i1
	be      $i1, -1, bne_cont.22052
bne_then.22052:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
bne_cont.22052:
bne_cont.22051:
bne_cont.22050:
bne_cont.22049:
bne_cont.22048:
bne_cont.22047:
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22053
be_then.22053:
	jr      $ra3
be_else.22053:
	bne     $i1, 99, be_else.22054
be_then.22054:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22055
be_then.22055:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22055:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22056
be_then.22056:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22056:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.22057
be_then.22057:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22057:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.22058
be_then.22058:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22058:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22054:
.count move_args
	mov     $i18, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22059
be_then.22059:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22059:
	bg      $fg7, $fg0, ble_else.22060
ble_then.22060:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
ble_else.22060:
	li      1, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22046:
.count move_args
	mov     $i18, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22061
be_then.22061:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
be_else.22061:
	bg      $fg7, $fg0, ble_else.22062
ble_then.22062:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
ble_else.22062:
	li      1, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f9]
# []
# [$fg11, $fg14, $fg16]
# [$ra]
######################################################################
.begin utexture
utexture.2908:
	load    [$i1 + 8], $i2
	load    [$i2 + 0], $fg16
	load    [$i2 + 1], $fg11
	load    [$i2 + 2], $fg14
	load    [$i1 + 0], $i2
	bne     $i2, 1, be_else.22063
be_then.22063:
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	fsub    $f2, $f1, $f4
.count load_float
	load    [f.21472], $f5
.count load_float
	load    [f.21473], $f6
	fmul    $f4, $f6, $f2
	call    ext_floor
	fmul    $f1, $f5, $f1
	fsub    $f4, $f1, $f1
.count load_float
	load    [f.21474], $f4
	bg      $f4, $f1, ble_else.22064
ble_then.22064:
	li      0, $i2
.count b_cont
	b       ble_cont.22064
ble_else.22064:
	li      1, $i2
ble_cont.22064:
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f7
	fmul    $f7, $f6, $f2
	call    ext_floor
	fmul    $f1, $f5, $f1
	fsub    $f7, $f1, $f1
	bg      $f4, $f1, ble_else.22065
ble_then.22065:
	bne     $i2, 0, be_else.22066
be_then.22066:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22066:
	mov     $f0, $fg11
	jr      $ra1
ble_else.22065:
	bne     $i2, 0, be_else.22067
be_then.22067:
	mov     $f0, $fg11
	jr      $ra1
be_else.22067:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22063:
	bne     $i2, 2, be_else.22068
be_then.22068:
.count load_float
	load    [f.21471], $f1
	load    [ext_intersection_point + 1], $f2
	fmul    $f2, $f1, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	jr      $ra1
be_else.22068:
	bne     $i2, 3, be_else.22069
be_then.22069:
	load    [$i1 + 5], $i1
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f1, $f1
	load    [$i1 + 0], $f2
	load    [ext_intersection_point + 0], $f3
	fsub    $f3, $f2, $f2
	fmul    $f2, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc10, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc14, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg14
	jr      $ra1
be_else.22069:
	bne     $i2, 4, be_else.22070
be_then.22070:
	load    [$i1 + 4], $i3
	load    [$i1 + 5], $i1
	load    [$i3 + 2], $f1
	fsqrt   $f1, $f1
	load    [$i1 + 2], $f2
	load    [ext_intersection_point + 2], $f3
	fsub    $f3, $f2, $f2
	fmul    $f2, $f1, $f6
	load    [$i3 + 0], $f1
	fsqrt   $f1, $f1
	load    [$i1 + 0], $f2
	load    [ext_intersection_point + 0], $f3
	fsub    $f3, $f2, $f2
	fmul    $f2, $f1, $f7
	fabs    $f7, $f1
.count load_float
	load    [f.21461], $f8
	bg      $f8, $f1, ble_else.22071
ble_then.22071:
	finv    $f7, $f1
	fmul_a  $f6, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21463], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21465], $f2
.count load_float
	load    [f.21466], $f2
	fmul    $f2, $f1, $f9
.count b_cont
	b       ble_cont.22071
ble_else.22071:
.count load_float
	load    [f.21462], $f9
ble_cont.22071:
	fmul    $f6, $f6, $f1
	fmul    $f7, $f7, $f2
	fadd    $f2, $f1, $f1
	load    [$i3 + 1], $f2
	fsqrt   $f2, $f2
	load    [$i1 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	fsub    $f4, $f3, $f3
	fmul    $f3, $f2, $f2
	fabs    $f1, $f3
	bg      $f8, $f3, ble_else.22072
ble_then.22072:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21463], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21465], $f2
.count load_float
	load    [f.21466], $f2
	fmul    $f2, $f1, $f4
.count b_cont
	b       ble_cont.22072
ble_else.22072:
.count load_float
	load    [f.21462], $f4
ble_cont.22072:
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f4
.count move_args
	mov     $f9, $f2
	call    ext_floor
	fsub    $f9, $f1, $f1
	fsub    $fc4, $f1, $f1
	fmul    $f1, $f1, $f1
.count load_float
	load    [f.21467], $f2
	fsub    $f2, $f1, $f1
	fsub    $f1, $f4, $f1
	bg      $f0, $f1, ble_else.22073
ble_then.22073:
.count load_float
	load    [f.21468], $f2
	fmul    $f2, $f1, $fg14
	jr      $ra1
ble_else.22073:
	mov     $f0, $fg14
	jr      $ra1
be_else.22070:
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i19, $f15, $f16, $i20)
# $ra = $ra4
# [$i1 - $i22]
# [$f1 - $f16]
# [$ig2, $ig4]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i19, 0, bge_else.22074
bge_then.22074:
	load    [ext_reflections + $i19], $i21
	load    [$i21 + 1], $i22
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, bne_cont.22075
bne_then.22075:
	bne     $i1, 99, be_else.22076
be_then.22076:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22077
be_then.22077:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22076
be_else.22077:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22078
be_then.22078:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22076
be_else.22078:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.22079
be_then.22079:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22076
be_else.22079:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.22080
be_then.22080:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22076
be_else.22080:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i13
.count move_args
	mov     $i22, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22076
be_else.22076:
.count move_args
	mov     $i22, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22081
be_then.22081:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22081
be_else.22081:
	bg      $fg7, $fg0, ble_else.22082
ble_then.22082:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22082
ble_else.22082:
	li      1, $i13
.count move_args
	mov     $i22, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
ble_cont.22082:
be_cont.22081:
be_cont.22076:
bne_cont.22075:
	bg      $fg7, $fc7, ble_else.22083
ble_then.22083:
	li      0, $i1
.count b_cont
	b       ble_cont.22083
ble_else.22083:
	bg      $fc12, $fg7, ble_else.22084
ble_then.22084:
	li      0, $i1
.count b_cont
	b       ble_cont.22084
ble_else.22084:
	li      1, $i1
ble_cont.22084:
ble_cont.22083:
	bne     $i1, 0, be_else.22085
be_then.22085:
	sub     $i19, 1, $i19
	b       trace_reflections.2915
be_else.22085:
	load    [$i21 + 0], $i1
	add     $ig4, $ig4, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, be_else.22086
be_then.22086:
	li      0, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, be_else.22087
be_then.22087:
	load    [$i21 + 2], $f1
	load    [$i22 + 0], $i1
	load    [$i1 + 2], $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f2, $f3
	load    [$i1 + 1], $f4
	load    [ext_nvector + 1], $f5
	fmul    $f5, $f4, $f5
	load    [$i1 + 0], $f6
	load    [ext_nvector + 0], $f7
	fmul    $f7, $f6, $f7
	fadd    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fmul    $f1, $f15, $f5
	fmul    $f5, $f3, $f3
	ble     $f3, $f0, bg_cont.22088
bg_then.22088:
	fmul    $f3, $fg16, $f5
	fadd    $fg4, $f5, $fg4
	fmul    $f3, $fg11, $f5
	fadd    $fg5, $f5, $fg5
	fmul    $f3, $fg14, $f3
	fadd    $fg6, $f3, $fg6
bg_cont.22088:
	load    [$i20 + 2], $f3
	fmul    $f3, $f2, $f2
	load    [$i20 + 1], $f3
	fmul    $f3, $f4, $f3
	load    [$i20 + 0], $f4
	fmul    $f4, $f6, $f4
	fadd    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fmul    $f1, $f2, $f1
	sub     $i19, 1, $i19
	ble     $f1, $f0, trace_reflections.2915
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
be_else.22087:
	sub     $i19, 1, $i19
	b       trace_reflections.2915
be_else.22086:
	sub     $i19, 1, $i19
	b       trace_reflections.2915
bge_else.22074:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i23, $f17, $i24, $i25, $f18)
# $ra = $ra5
# [$i1 - $i28]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0, $fg4 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra4]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i23, 4, ble_else.22090
ble_then.22090:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, bne_cont.22091
bne_then.22091:
	bne     $i1, 99, be_else.22092
be_then.22092:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22093
be_then.22093:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22092
be_else.22093:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22094
be_then.22094:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22092
be_else.22094:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.22095
be_then.22095:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22092
be_else.22095:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.22096
be_then.22096:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22092
be_else.22096:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	li      5, $i13
.count move_args
	mov     $i24, $i15
	jal     solve_one_or_network.2875, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22092
be_else.22092:
.count move_args
	mov     $i24, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22097
be_then.22097:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22097
be_else.22097:
	bg      $fg7, $fg0, ble_else.22098
ble_then.22098:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       ble_cont.22098
ble_else.22098:
	li      1, $i13
.count move_args
	mov     $i24, $i15
	jal     solve_one_or_network.2875, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
ble_cont.22098:
be_cont.22097:
be_cont.22092:
bne_cont.22091:
	load    [$i25 + 2], $i26
	bg      $fg7, $fc7, ble_else.22099
ble_then.22099:
	li      0, $i1
.count b_cont
	b       ble_cont.22099
ble_else.22099:
	bg      $fc12, $fg7, ble_else.22100
ble_then.22100:
	li      0, $i1
.count b_cont
	b       ble_cont.22100
ble_else.22100:
	li      1, $i1
ble_cont.22100:
ble_cont.22099:
	bne     $i1, 0, be_else.22101
be_then.22101:
	add     $i0, -1, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	bne     $i23, 0, be_else.22102
be_then.22102:
	jr      $ra5
be_else.22102:
	load    [$i24 + 2], $f1
	fmul    $f1, $fg13, $f1
	load    [$i24 + 1], $f2
	fmul    $f2, $fg12, $f2
	load    [$i24 + 0], $f3
	fmul    $f3, $fg15, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	bg      $f1, $f0, ble_else.22103
ble_then.22103:
	jr      $ra5
ble_else.22103:
	load    [ext_beam + 0], $f2
	fmul    $f1, $f1, $f3
	fmul    $f3, $f1, $f1
	fmul    $f1, $f17, $f1
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
be_else.22101:
	load    [ext_objects + $ig4], $i27
	load    [$i27 + 1], $i1
	bne     $i1, 1, be_else.22104
be_then.22104:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i1
	load    [$i24 + $i1], $f1
	bne     $f1, $f0, be_else.22105
be_then.22105:
	store   $f0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22104
be_else.22105:
	bg      $f1, $f0, ble_else.22106
ble_then.22106:
	store   $fc0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22104
ble_else.22106:
	store   $fc3, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22104
be_else.22104:
	bne     $i1, 2, be_else.22107
be_then.22107:
	load    [$i27 + 4], $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
.count b_cont
	b       be_cont.22107
be_else.22107:
	load    [$i27 + 5], $i1
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i1 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i1 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	load    [$i27 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f1, $f4, $f4
	load    [$i1 + 1], $f5
	fmul    $f2, $f5, $f5
	load    [$i1 + 0], $f6
	fmul    $f3, $f6, $f6
	load    [$i27 + 3], $i1
	bne     $i1, 0, be_else.22108
be_then.22108:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
.count b_cont
	b       be_cont.22108
be_else.22108:
	load    [$i27 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f2, $f7, $f7
	load    [$i1 + 1], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i1 + 2], $f6
	fmul    $f3, $f6, $f6
	load    [$i1 + 0], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i1 + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22108:
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	load    [$i27 + 6], $i1
	bne     $f1, $f0, be_else.22109
be_then.22109:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22109
be_else.22109:
	bne     $i1, 0, be_else.22110
be_then.22110:
	finv    $f1, $f1
.count b_cont
	b       be_cont.22110
be_else.22110:
	finv_n  $f1, $f1
be_cont.22110:
be_cont.22109:
	load    [ext_nvector + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22107:
be_cont.22104:
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + $i23], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f17, $f15
.count storer
	add     $i1, $i23, $tmp
	bg      $fc4, $f1, ble_else.22111
ble_then.22111:
	li      1, $i2
	store   $i2, [$tmp + 0]
	load    [$i25 + 4], $i1
	load    [$i1 + $i23], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg14, [$i2 + 2]
	load    [$i1 + $i23], $i1
.count load_float
	load    [f.21477], $f1
.count load_float
	load    [f.21478], $f1
	fmul    $f1, $f15, $f1
	load    [$i1 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i1 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i25 + 7], $i1
	load    [$i1 + $i23], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
.count b_cont
	b       ble_cont.22111
ble_else.22111:
	li      0, $i2
	store   $i2, [$tmp + 0]
ble_cont.22111:
	load    [$i24 + 0], $f1
	load    [ext_nvector + 2], $f2
	load    [$i24 + 2], $f3
	fmul    $f3, $f2, $f2
	load    [ext_nvector + 1], $f3
	load    [$i24 + 1], $f4
	fmul    $f4, $f3, $f3
	load    [ext_nvector + 0], $f4
	fmul    $f1, $f4, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
.count load_float
	load    [f.21479], $f3
	fmul    $f3, $f2, $f2
	fmul    $f2, $f4, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i24 + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i24 + 1], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i24 + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i24 + 2], $f2
	fadd    $f2, $f1, $f1
	store   $f1, [$i24 + 2]
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	bne     $i1, -1, be_else.22112
be_then.22112:
	li      0, $i1
.count b_cont
	b       be_cont.22112
be_else.22112:
	bne     $i1, 99, be_else.22113
be_then.22113:
	li      1, $i1
.count b_cont
	b       be_cont.22113
be_else.22113:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22114
be_then.22114:
	li      0, $i1
.count b_cont
	b       be_cont.22114
be_else.22114:
	bg      $fc7, $fg0, ble_else.22115
ble_then.22115:
	li      0, $i1
.count b_cont
	b       ble_cont.22115
ble_else.22115:
	load    [$i12 + 1], $i1
	bne     $i1, -1, be_else.22116
be_then.22116:
	li      0, $i1
.count b_cont
	b       be_cont.22116
be_else.22116:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22117
be_then.22117:
	load    [$i12 + 2], $i1
	bne     $i1, -1, be_else.22118
be_then.22118:
	li      0, $i1
.count b_cont
	b       be_cont.22117
be_else.22118:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22119
be_then.22119:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22120
be_then.22120:
	li      0, $i1
.count b_cont
	b       be_cont.22117
be_else.22120:
	li      1, $i1
.count b_cont
	b       be_cont.22117
be_else.22119:
	li      1, $i1
.count b_cont
	b       be_cont.22117
be_else.22117:
	li      1, $i1
be_cont.22117:
be_cont.22116:
ble_cont.22115:
be_cont.22114:
be_cont.22113:
	bne     $i1, 0, be_else.22121
be_then.22121:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22121
be_else.22121:
	load    [$i12 + 1], $i1
	bne     $i1, -1, be_else.22122
be_then.22122:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22122
be_else.22122:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22123
be_then.22123:
	load    [$i12 + 2], $i1
	bne     $i1, -1, be_else.22124
be_then.22124:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22123
be_else.22124:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22125
be_then.22125:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22126
be_then.22126:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22123
be_else.22126:
	li      1, $i1
.count b_cont
	b       be_cont.22123
be_else.22125:
	li      1, $i1
.count b_cont
	b       be_cont.22123
be_else.22123:
	li      1, $i1
be_cont.22123:
be_cont.22122:
be_cont.22121:
be_cont.22112:
	load    [$i28 + 1], $f1
	fmul    $f17, $f1, $f16
	bne     $i1, 0, be_cont.22127
be_then.22127:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg15, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f15, $f1
	load    [$i24 + 0], $f2
	fmul    $f2, $fg15, $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i24 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, bg_cont.22128
bg_then.22128:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg14, $f1
	fadd    $fg6, $f1, $fg6
bg_cont.22128:
	ble     $f2, $f0, bg_cont.22129
bg_then.22129:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
bg_cont.22129:
be_cont.22127:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	sub     $ig3, 1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_reflections.2915, $ra4
	bg      $f17, $fc10, ble_else.22130
ble_then.22130:
	jr      $ra5
ble_else.22130:
	bge     $i23, 4, bl_cont.22131
bl_then.22131:
	add     $i23, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i26, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.22131:
	load    [$i27 + 2], $i1
	bne     $i1, 2, be_else.22132
be_then.22132:
	load    [$i28 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f17, $f1, $f17
	add     $i23, 1, $i23
	fadd    $f18, $fg7, $f18
	b       trace_ray.2920
be_else.22132:
	jr      $ra5
ble_else.22090:
	jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i19, $f15)
# $ra = $ra4
# [$i1 - $i19]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
# [$ra - $ra3]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, bne_cont.22133
bne_then.22133:
	bne     $i1, 99, be_else.22134
be_then.22134:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22135
be_then.22135:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22134
be_else.22135:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22136
be_then.22136:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22134
be_else.22136:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	bne     $i1, -1, be_else.22137
be_then.22137:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22134
be_else.22137:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	bne     $i1, -1, be_else.22138
be_then.22138:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22134
be_else.22138:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i13
.count move_args
	mov     $i19, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22134
be_else.22134:
.count move_args
	mov     $i19, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22139
be_then.22139:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22139
be_else.22139:
	bg      $fg7, $fg0, ble_else.22140
ble_then.22140:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22140
ble_else.22140:
	li      1, $i13
.count move_args
	mov     $i19, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
ble_cont.22140:
be_cont.22139:
be_cont.22134:
bne_cont.22133:
	bg      $fg7, $fc7, ble_else.22141
ble_then.22141:
	li      0, $i1
.count b_cont
	b       ble_cont.22141
ble_else.22141:
	bg      $fc12, $fg7, ble_else.22142
ble_then.22142:
	li      0, $i1
.count b_cont
	b       ble_cont.22142
ble_else.22142:
	li      1, $i1
ble_cont.22142:
ble_cont.22141:
	bne     $i1, 0, be_else.22143
be_then.22143:
	jr      $ra4
be_else.22143:
	load    [$i19 + 0], $i1
	load    [ext_objects + $ig4], $i15
	load    [$i15 + 1], $i2
	bne     $i2, 1, be_else.22144
be_then.22144:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i2
	load    [$i1 + $i2], $f1
	bne     $f1, $f0, be_else.22145
be_then.22145:
	store   $f0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22144
be_else.22145:
	bg      $f1, $f0, ble_else.22146
ble_then.22146:
	store   $fc0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22144
ble_else.22146:
	store   $fc3, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22144
be_else.22144:
	bne     $i2, 2, be_else.22147
be_then.22147:
	load    [$i15 + 4], $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
.count b_cont
	b       be_cont.22147
be_else.22147:
	load    [$i15 + 5], $i1
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i1 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i1 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	load    [$i15 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f1, $f4, $f4
	load    [$i1 + 1], $f5
	fmul    $f2, $f5, $f5
	load    [$i1 + 0], $f6
	fmul    $f3, $f6, $f6
	load    [$i15 + 3], $i1
	bne     $i1, 0, be_else.22148
be_then.22148:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
.count b_cont
	b       be_cont.22148
be_else.22148:
	load    [$i15 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f2, $f7, $f7
	load    [$i1 + 1], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i1 + 2], $f6
	fmul    $f3, $f6, $f6
	load    [$i1 + 0], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i1 + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i1 + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22148:
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	load    [$i15 + 6], $i1
	bne     $f1, $f0, be_else.22149
be_then.22149:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22149
be_else.22149:
	bne     $i1, 0, be_else.22150
be_then.22150:
	finv    $f1, $f1
.count b_cont
	b       be_cont.22150
be_else.22150:
	finv_n  $f1, $f1
be_cont.22150:
be_cont.22149:
	load    [ext_nvector + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22147:
be_cont.22144:
.count move_args
	mov     $i15, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	bne     $i1, -1, be_else.22151
be_then.22151:
	li      0, $i1
.count b_cont
	b       be_cont.22151
be_else.22151:
	bne     $i1, 99, be_else.22152
be_then.22152:
	li      1, $i1
.count b_cont
	b       be_cont.22152
be_else.22152:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22153
be_then.22153:
	li      0, $i1
.count b_cont
	b       be_cont.22153
be_else.22153:
	bg      $fc7, $fg0, ble_else.22154
ble_then.22154:
	li      0, $i1
.count b_cont
	b       ble_cont.22154
ble_else.22154:
	load    [$i12 + 1], $i1
	bne     $i1, -1, be_else.22155
be_then.22155:
	li      0, $i1
.count b_cont
	b       be_cont.22155
be_else.22155:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22156
be_then.22156:
	load    [$i12 + 2], $i1
	bne     $i1, -1, be_else.22157
be_then.22157:
	li      0, $i1
.count b_cont
	b       be_cont.22156
be_else.22157:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22158
be_then.22158:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22159
be_then.22159:
	li      0, $i1
.count b_cont
	b       be_cont.22156
be_else.22159:
	li      1, $i1
.count b_cont
	b       be_cont.22156
be_else.22158:
	li      1, $i1
.count b_cont
	b       be_cont.22156
be_else.22156:
	li      1, $i1
be_cont.22156:
be_cont.22155:
ble_cont.22154:
be_cont.22153:
be_cont.22152:
	bne     $i1, 0, be_else.22160
be_then.22160:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22160
be_else.22160:
	load    [$i12 + 1], $i1
	bne     $i1, -1, be_else.22161
be_then.22161:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22161
be_else.22161:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22162
be_then.22162:
	load    [$i12 + 2], $i1
	bne     $i1, -1, be_else.22163
be_then.22163:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22162
be_else.22163:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22164
be_then.22164:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22165
be_then.22165:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22162
be_else.22165:
	li      1, $i1
.count b_cont
	b       be_cont.22162
be_else.22164:
	li      1, $i1
.count b_cont
	b       be_cont.22162
be_else.22162:
	li      1, $i1
be_cont.22162:
be_cont.22161:
be_cont.22160:
be_cont.22151:
	bne     $i1, 0, be_else.22166
be_then.22166:
	load    [$i15 + 7], $i1
	load    [$i1 + 0], $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $fg12, $f3
	load    [ext_nvector + 0], $f4
	fmul    $f4, $fg15, $f4
	fadd    $f4, $f3, $f3
	fadd_n  $f3, $f2, $f2
	bg      $f2, $f0, ble_cont.22167
ble_then.22167:
	mov     $f0, $f2
ble_cont.22167:
	fmul    $f15, $f2, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg14, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
be_else.22166:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i20, $i21, $i22)
# $ra = $ra5
# [$i1 - $i22]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
# [$ra - $ra4]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i22, 0, bge_else.22168
bge_then.22168:
	load    [$i20 + $i22], $i1
	load    [$i1 + 0], $i1
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22169
ble_then.22169:
	load    [$i20 + $i22], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	bl      $i22, 0, bge_else.22170
bge_then.22170:
	load    [$i20 + $i22], $i1
	load    [$i1 + 0], $i1
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22171
ble_then.22171:
	load    [$i20 + $i22], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	b       iter_trace_diffuse_rays.2929
ble_else.22171:
	add     $i22, 1, $i1
	load    [$i20 + $i1], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	b       iter_trace_diffuse_rays.2929
bge_else.22170:
	jr      $ra5
ble_else.22169:
	add     $i22, 1, $i1
	load    [$i20 + $i1], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	bl      $i22, 0, bge_else.22172
bge_then.22172:
	load    [$i20 + $i22], $i1
	load    [$i1 + 0], $i1
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22173
ble_then.22173:
	load    [$i20 + $i22], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	b       iter_trace_diffuse_rays.2929
ble_else.22173:
	add     $i22, 1, $i1
	load    [$i20 + $i1], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i22, 2, $i22
	b       iter_trace_diffuse_rays.2929
bge_else.22172:
	jr      $ra5
bge_else.22168:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i23, $i24)
# $ra = $ra6
# [$i1 - $i27]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra5]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	load    [$i23 + 5], $i1
	load    [$i1 + $i24], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i23 + 6], $i1
	load    [$i23 + 1], $i2
	load    [$i23 + 7], $i3
	load    [$i1 + 0], $i25
	load    [$i2 + $i24], $i26
	load    [$i3 + $i24], $i27
	be      $i25, 0, bne_cont.22174
bne_then.22174:
	load    [ext_dirvecs + 0], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i27 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22175
ble_then.22175:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22175
ble_else.22175:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22175:
bne_cont.22174:
	be      $i25, 1, bne_cont.22176
bne_then.22176:
	load    [ext_dirvecs + 1], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i27 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22177
ble_then.22177:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22177
ble_else.22177:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22177:
bne_cont.22176:
	be      $i25, 2, bne_cont.22178
bne_then.22178:
	load    [ext_dirvecs + 2], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i27 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22179
ble_then.22179:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22179
ble_else.22179:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22179:
bne_cont.22178:
	be      $i25, 3, bne_cont.22180
bne_then.22180:
	load    [ext_dirvecs + 3], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i27 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22181
ble_then.22181:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22181
ble_else.22181:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22181:
bne_cont.22180:
	be      $i25, 4, bne_cont.22182
bne_then.22182:
	load    [ext_dirvecs + 4], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i27 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22183
ble_then.22183:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22183
ble_else.22183:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i27, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22183:
bne_cont.22182:
	load    [$i23 + 4], $i1
	load    [$i1 + $i24], $i1
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
# do_without_neighbors($i28, $i23)
# $ra = $ra7
# [$i1 - $i29]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra6]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i23, 4, ble_else.22184
ble_then.22184:
	load    [$i28 + 2], $i24
	load    [$i24 + $i23], $i1
	bl      $i1, 0, bge_else.22185
bge_then.22185:
	load    [$i28 + 3], $i25
	load    [$i25 + $i23], $i1
	bne     $i1, 0, be_else.22186
be_then.22186:
	add     $i23, 1, $i29
	bg      $i29, 4, ble_else.22187
ble_then.22187:
	load    [$i24 + $i29], $i1
	bl      $i1, 0, bge_else.22188
bge_then.22188:
	load    [$i25 + $i29], $i1
	bne     $i1, 0, be_else.22189
be_then.22189:
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
be_else.22189:
.count move_args
	mov     $i28, $i23
.count move_args
	mov     $i29, $i24
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
bge_else.22188:
	jr      $ra7
ble_else.22187:
	jr      $ra7
be_else.22186:
	load    [$i28 + 5], $i1
	load    [$i1 + $i23], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i28 + 6], $i1
	load    [$i28 + 1], $i2
	load    [$i28 + 7], $i3
	load    [$i1 + 0], $i26
	load    [$i2 + $i23], $i27
	load    [$i3 + $i23], $i29
	be      $i26, 0, bne_cont.22190
bne_then.22190:
	load    [ext_dirvecs + 0], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i29 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22191
ble_then.22191:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22191
ble_else.22191:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22191:
bne_cont.22190:
	be      $i26, 1, bne_cont.22192
bne_then.22192:
	load    [ext_dirvecs + 1], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i29 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22193
ble_then.22193:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22193
ble_else.22193:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22193:
bne_cont.22192:
	be      $i26, 2, bne_cont.22194
bne_then.22194:
	load    [ext_dirvecs + 2], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i29 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22195
ble_then.22195:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22195
ble_else.22195:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22195:
bne_cont.22194:
	be      $i26, 3, bne_cont.22196
bne_then.22196:
	load    [ext_dirvecs + 3], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i29 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22197
ble_then.22197:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22197
ble_else.22197:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22197:
bne_cont.22196:
	be      $i26, 4, bne_cont.22198
bne_then.22198:
	load    [ext_dirvecs + 4], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i29 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22199
ble_then.22199:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22199
ble_else.22199:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i29, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22199:
bne_cont.22198:
	load    [$i28 + 4], $i1
	load    [$i1 + $i23], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i23, 1, $i29
	bg      $i29, 4, ble_else.22200
ble_then.22200:
	load    [$i24 + $i29], $i1
	bl      $i1, 0, bge_else.22201
bge_then.22201:
	load    [$i25 + $i29], $i1
	bne     $i1, 0, be_else.22202
be_then.22202:
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
be_else.22202:
.count move_args
	mov     $i28, $i23
.count move_args
	mov     $i29, $i24
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
bge_else.22201:
	jr      $ra7
ble_else.22200:
	jr      $ra7
bge_else.22185:
	jr      $ra7
ble_else.22184:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i28)
# $ra = $ra7
# [$i1 - $i29]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra6]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i28, 4, ble_else.22203
ble_then.22203:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i28], $i6
	bl      $i6, 0, bge_else.22204
bge_then.22204:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, be_else.22205
be_then.22205:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, be_else.22206
be_then.22206:
	sub     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, be_else.22207
be_then.22207:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, be_else.22208
be_then.22208:
	li      1, $i6
.count b_cont
	b       be_cont.22205
be_else.22208:
	li      0, $i6
.count b_cont
	b       be_cont.22205
be_else.22207:
	li      0, $i6
.count b_cont
	b       be_cont.22205
be_else.22206:
	li      0, $i6
.count b_cont
	b       be_cont.22205
be_else.22205:
	li      0, $i6
be_cont.22205:
	bne     $i6, 0, be_else.22209
be_then.22209:
	bg      $i28, 4, ble_else.22210
ble_then.22210:
	load    [$i4 + $i2], $i29
	load    [$i29 + 2], $i1
	load    [$i1 + $i28], $i1
	bl      $i1, 0, bge_else.22211
bge_then.22211:
	load    [$i29 + 3], $i1
	load    [$i1 + $i28], $i1
	bne     $i1, 0, be_else.22212
be_then.22212:
	add     $i28, 1, $i23
.count move_args
	mov     $i29, $i28
	b       do_without_neighbors.2951
be_else.22212:
.count move_args
	mov     $i29, $i23
.count move_args
	mov     $i28, $i24
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i28, 1, $i23
.count move_args
	mov     $i29, $i28
	b       do_without_neighbors.2951
bge_else.22211:
	jr      $ra7
ble_else.22210:
	jr      $ra7
be_else.22209:
	load    [$i1 + 3], $i1
	load    [$i1 + $i28], $i1
	bne     $i1, 0, be_else.22213
be_then.22213:
	add     $i28, 1, $i28
	b       try_exploit_neighbors.2967
be_else.22213:
	load    [$i7 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i28, 1, $i28
	b       try_exploit_neighbors.2967
bge_else.22204:
	jr      $ra7
ble_else.22203:
	jr      $ra7
.end try_exploit_neighbors

######################################################################
# write_ppm_header()
# $ra = $ra
# [$i2]
# []
# []
# []
# [$ra]
######################################################################
.begin write_ppm_header
write_ppm_header.2974:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	sub     $sp, 1, $sp
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
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      10, $i2
	b       ext_write
.end write_ppm_header

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i3]
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
	sub     $sp, 1, $sp
	call    ext_int_of_float
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      255, $i2
	bg      $i1, $i2, ble_else.22214
ble_then.22214:
	bl      $i1, 0, bge_else.22215
bge_then.22215:
.count move_args
	mov     $i1, $i2
	b       ext_write
bge_else.22215:
	li      0, $i2
	b       ext_write
ble_else.22214:
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
# [$ra]
######################################################################
.begin write_rgb
write_rgb.2978:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	sub     $sp, 1, $sp
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
# pretrace_diffuse_rays($i23, $i24)
# $ra = $ra6
# [$i1 - $i30]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7 - $fg11, $fg14, $fg16]
# [$ra - $ra5]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i24, 4, ble_else.22216
ble_then.22216:
	load    [$i23 + 2], $i25
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bge_else.22217
bge_then.22217:
	load    [$i23 + 3], $i26
	load    [$i26 + $i24], $i1
	bne     $i1, 0, be_else.22218
be_then.22218:
	add     $i24, 1, $i24
	bg      $i24, 4, ble_else.22219
ble_then.22219:
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bge_else.22220
bge_then.22220:
	load    [$i26 + $i24], $i1
	bne     $i1, 0, be_else.22221
be_then.22221:
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
be_else.22221:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i23 + 1], $i1
	load    [$i23 + 7], $i8
	load    [$i23 + 6], $i9
	load    [$i1 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i9 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i8 + $i24], $i21
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22222
ble_then.22222:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22222
ble_else.22222:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22222:
	load    [$i23 + 5], $i1
	load    [$i1 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bge_else.22220:
	jr      $ra6
ble_else.22219:
	jr      $ra6
be_else.22218:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i23 + 1], $i27
	load    [$i23 + 7], $i28
	load    [$i23 + 6], $i29
	load    [$i27 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i29 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i28 + $i24], $i21
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22223
ble_then.22223:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
.count b_cont
	b       ble_cont.22223
ble_else.22223:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
ble_cont.22223:
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i30
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	bg      $i24, 4, ble_else.22224
ble_then.22224:
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bge_else.22225
bge_then.22225:
	load    [$i26 + $i24], $i1
	bne     $i1, 0, be_else.22226
be_then.22226:
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
be_else.22226:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i27 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i29 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i28 + $i24], $i21
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22227
ble_then.22227:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22227
ble_else.22227:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22227:
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bge_else.22225:
	jr      $ra6
ble_else.22224:
	jr      $ra6
bge_else.22217:
	jr      $ra6
ble_else.22216:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i31, $i32, $i33, $f1, $f2, $f3)
# $ra = $ra7
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra6]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i32, 0, bge_else.22228
bge_then.22228:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $f3, [$sp + 0]
.count stack_store
	store   $f2, [$sp + 1]
.count stack_store
	store   $f1, [$sp + 2]
	load    [ext_screenx_dir + 0], $f4
	sub     $i32, 64, $i2
	call    ext_float_of_int
	fmul    $f1, $f4, $f2
.count stack_load
	load    [$sp + 2], $f3
	fadd    $f2, $f3, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
.count stack_load
	load    [$sp + 1], $i34
	store   $i34, [ext_ptrace_dirvec + 1]
	load    [ext_screenx_dir + 2], $f2
	fmul    $f1, $f2, $f1
.count stack_load
	load    [$sp + 0], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_ptrace_dirvec + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $f1, $f0, be_else.22229
be_then.22229:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22229
be_else.22229:
	finv    $f1, $f1
be_cont.22229:
	load    [ext_ptrace_dirvec + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	mov     $f0, $fg4
	mov     $f0, $fg5
	mov     $f0, $fg6
	load    [ext_viewpoint + 0], $fg17
	load    [ext_viewpoint + 1], $fg18
	load    [ext_viewpoint + 2], $fg19
	load    [$i31 + $i32], $i25
	li      0, $i23
	li      ext_ptrace_dirvec, $i24
.count move_args
	mov     $fc0, $f17
.count move_args
	mov     $f0, $f18
	jal     trace_ray.2920, $ra5
	load    [$i31 + $i32], $i1
	load    [$i1 + 0], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i31 + $i32], $i1
	load    [$i1 + 6], $i1
	store   $i33, [$i1 + 0]
	load    [$i31 + $i32], $i23
	load    [$i23 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bge_cont.22230
bge_then.22230:
	load    [$i23 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22231
be_then.22231:
	li      1, $i24
	jal     pretrace_diffuse_rays.2980, $ra6
.count b_cont
	b       be_cont.22231
be_else.22231:
	load    [$i23 + 6], $i1
	load    [$i1 + 0], $i1
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i23 + 7], $i2
	load    [$i23 + 1], $i3
	load    [ext_dirvecs + $i1], $i20
	load    [$i2 + 0], $i21
	load    [$i3 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i21 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i21 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i21 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22232
ble_then.22232:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22232
ble_else.22232:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22232:
	load    [$i23 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i24
	jal     pretrace_diffuse_rays.2980, $ra6
be_cont.22231:
bge_cont.22230:
.count stack_move
	add     $sp, 3, $sp
	add     $i33, 1, $i33
.count move_args
	mov     $i34, $f2
.count stack_load
	load    [$sp - 3], $f3
.count stack_load
	load    [$sp - 1], $f1
	sub     $i32, 1, $i32
	bl      $i33, 5, pretrace_pixels.2983
	sub     $i33, 5, $i33
	b       pretrace_pixels.2983
bge_else.22228:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i30, $i31, $i32, $i33, $i34)
# $ra = $ra8
# [$i1 - $i34]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
# [$ra - $ra7]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i30, ble_else.22234
ble_then.22234:
	jr      $ra8
ble_else.22234:
	load    [$i33 + $i30], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	add     $i31, 1, $i1
	li      128, $i2
	bg      $i2, $i1, ble_else.22235
ble_then.22235:
	li      0, $i1
.count b_cont
	b       ble_cont.22235
ble_else.22235:
	bg      $i31, 0, ble_else.22236
ble_then.22236:
	li      0, $i1
.count b_cont
	b       ble_cont.22236
ble_else.22236:
	li      128, $i1
	add     $i30, 1, $i2
	bg      $i1, $i2, ble_else.22237
ble_then.22237:
	li      0, $i1
.count b_cont
	b       ble_cont.22237
ble_else.22237:
	bg      $i30, 0, ble_else.22238
ble_then.22238:
	li      0, $i1
.count b_cont
	b       ble_cont.22238
ble_else.22238:
	li      1, $i1
ble_cont.22238:
ble_cont.22237:
ble_cont.22236:
ble_cont.22235:
	li      0, $i24
	bne     $i1, 0, be_else.22239
be_then.22239:
	load    [$i33 + $i30], $i28
	load    [$i28 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22239
bge_then.22240:
	load    [$i28 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22241
be_then.22241:
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22239
be_else.22241:
.count move_args
	mov     $i28, $i23
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22239
be_else.22239:
	load    [$i33 + $i30], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bge_cont.22242
bge_then.22242:
	load    [$i32 + $i30], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22243
be_then.22243:
	load    [$i34 + $i30], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22244
be_then.22244:
	sub     $i30, 1, $i4
	load    [$i33 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22245
be_then.22245:
	add     $i30, 1, $i4
	load    [$i33 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22246
be_then.22246:
	li      1, $i2
.count b_cont
	b       be_cont.22243
be_else.22246:
	li      0, $i2
.count b_cont
	b       be_cont.22243
be_else.22245:
	li      0, $i2
.count b_cont
	b       be_cont.22243
be_else.22244:
	li      0, $i2
.count b_cont
	b       be_cont.22243
be_else.22243:
	li      0, $i2
be_cont.22243:
	bne     $i2, 0, be_else.22247
be_then.22247:
	load    [$i33 + $i30], $i28
	load    [$i28 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22247
bge_then.22248:
	load    [$i28 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22249
be_then.22249:
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22247
be_else.22249:
.count move_args
	mov     $i28, $i23
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22247
be_else.22247:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i34, $i5
.count move_args
	mov     $i33, $i4
.count move_args
	mov     $i30, $i2
	li      1, $i28
	bne     $i1, 0, be_else.22250
be_then.22250:
.count move_args
	mov     $i32, $i3
	jal     try_exploit_neighbors.2967, $ra7
.count b_cont
	b       be_cont.22250
be_else.22250:
	load    [$i3 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i30, 1, $i1
	load    [$i33 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i33 + $i30], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i30, 1, $i1
	load    [$i33 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i34 + $i30], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i33 + $i30], $i1
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
	mov     $i32, $i3
	jal     try_exploit_neighbors.2967, $ra7
be_cont.22250:
be_cont.22247:
bge_cont.22242:
be_cont.22239:
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i35, $i36, $i37, $i38, $i39)
# $ra = $ra9
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
# [$ra - $ra8]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i35, ble_else.22251
ble_then.22251:
	jr      $ra9
ble_else.22251:
	bge     $i35, 127, bl_cont.22252
bl_then.22252:
	add     $i35, 1, $i1
	sub     $i1, 64, $i2
	call    ext_float_of_int
	load    [ext_screeny_dir + 0], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg22, $f4
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f2
	fmul    $f1, $fg23, $f1
	fadd    $f1, $fg20, $f3
	li      127, $i32
.count move_args
	mov     $i38, $i31
.count move_args
	mov     $i39, $i33
.count move_args
	mov     $f4, $f1
	jal     pretrace_pixels.2983, $ra7
bl_cont.22252:
	li      0, $i30
.count move_args
	mov     $i35, $i31
.count move_args
	mov     $i36, $i32
.count move_args
	mov     $i37, $i33
.count move_args
	mov     $i38, $i34
	jal     scan_pixel.2994, $ra8
	add     $i39, 2, $i39
.count move_args
	mov     $i36, $tmp
.count move_args
	mov     $i37, $i36
.count move_args
	mov     $i38, $i37
.count move_args
	mov     $tmp, $i38
	add     $i35, 1, $i35
	bl      $i39, 5, scan_line.3000
	sub     $i39, 5, $i39
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
# [$i1 - $i13]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i13, 0, bge_else.22254
bge_then.22254:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	sub     $i13, 1, $i13
	b       init_line_elements.3010
bge_else.22254:
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
# calc_dirvec($i1, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra1
# [$i1 - $i4]
# [$f1 - $f13]
# []
# []
# [$ra]
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i1, 5, bge_else.22255
bge_then.22255:
	load    [ext_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f2, $f2, $f3
	fmul    $f1, $f1, $f4
	fadd    $f4, $f3, $f3
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
bge_else.22255:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc10, $f1
	fsqrt   $f1, $f11
	finv    $f11, $f2
	call    ext_atan
	fmul    $f1, $f9, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f12
.count move_args
	mov     $f8, $f2
	call    ext_cos
	finv    $f1, $f1
	fmul    $f12, $f1, $f1
	fmul    $f1, $f11, $f11
	fmul    $f11, $f11, $f1
	fadd    $f1, $fc10, $f1
	fsqrt   $f1, $f12
	finv    $f12, $f2
	call    ext_atan
	fmul    $f1, $f10, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f13
.count move_args
	mov     $f8, $f2
	call    ext_cos
	add     $i1, 1, $i1
	finv    $f1, $f1
	fmul    $f13, $f1, $f1
	fmul    $f1, $f12, $f2
.count move_args
	mov     $f11, $f1
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs($i5, $f14, $i6, $i7)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f16]
# []
# []
# [$ra - $ra1]
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i5, 0, bge_else.22256
bge_then.22256:
.count load_float
	load    [f.21494], $f15
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f16, $fc10, $f9
	add     $i7, 2, $i8
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.22257
bge_then.22257:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22258
bge_then.22258:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22258
bge_else.22258:
	mov     $i1, $i6
bge_cont.22258:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f16, $fc10, $f9
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.22259
bge_then.22259:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22260
bge_then.22260:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22260
bge_else.22260:
	mov     $i1, $i6
bge_cont.22260:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f16, $fc10, $f9
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.22261
bge_then.22261:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
	fsub    $f15, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22262
bge_then.22262:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22262
bge_else.22262:
	mov     $i1, $i6
bge_cont.22262:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	fadd    $f15, $fc10, $f9
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, 1, $i6
	sub     $i5, 1, $i5
	bl      $i6, 5, calc_dirvecs.3028
	sub     $i6, 5, $i6
	b       calc_dirvecs.3028
bge_else.22261:
	jr      $ra2
bge_else.22259:
	jr      $ra2
bge_else.22257:
	jr      $ra2
bge_else.22256:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f17]
# []
# []
# [$ra - $ra2]
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i9, 0, bge_else.22264
bge_then.22264:
.count load_float
	load    [f.21494], $f17
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc19, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i11, 2, $i5
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i10, 1, $i1
	bl      $i1, 5, bge_else.22265
bge_then.22265:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22265
bge_else.22265:
	mov     $i1, $i6
bge_cont.22265:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc18, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc17, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
.count load_float
	load    [f.21498], $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22266
bge_then.22266:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22266
bge_else.22266:
	mov     $i1, $i6
bge_cont.22266:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc4, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22267
bge_then.22267:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22267
bge_else.22267:
	mov     $i1, $i6
bge_cont.22267:
	li      1, $i5
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	sub     $i9, 1, $i9
	bl      $i9, 0, bge_else.22268
bge_then.22268:
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
	li      0, $i1
	add     $i11, 4, $i11
	add     $i10, 2, $i2
	bl      $i2, 5, bge_else.22269
bge_then.22269:
	sub     $i2, 5, $i10
.count b_cont
	b       bge_cont.22269
bge_else.22269:
	mov     $i2, $i10
bge_cont.22269:
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc19, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i11, 2, $i5
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i10, 1, $i1
	bl      $i1, 5, bge_else.22270
bge_then.22270:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22270
bge_else.22270:
	mov     $i1, $i6
bge_cont.22270:
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc18, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc17, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22271
bge_then.22271:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22271
bge_else.22271:
	mov     $i1, $i6
bge_cont.22271:
	li      2, $i5
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	add     $i10, 2, $i10
	add     $i11, 4, $i11
	sub     $i9, 1, $i9
	bl      $i10, 5, calc_dirvec_rows.3033
	sub     $i10, 5, $i10
	b       calc_dirvec_rows.3033
bge_else.22268:
	jr      $ra3
bge_else.22264:
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
	mov     $i1, $i4
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i4, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
	store   $i4, [$i2 + 0]
	mov     $i2, $i1
	jr      $ra1
.end create_dirvec

######################################################################
# create_dirvec_elements($i5, $i6)
# $ra = $ra2
# [$i1 - $i6]
# [$f2]
# []
# []
# [$ra - $ra1]
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i6, 0, bge_else.22273
bge_then.22273:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i6
	b       create_dirvec_elements.3039
bge_else.22273:
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
	bl      $i7, 0, bge_else.22274
bge_then.22274:
	jal     create_dirvec.3037, $ra1
	li      120, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i7]
	li      118, $i6
	load    [ext_dirvecs + $i7], $i5
	jal     create_dirvec_elements.3039, $ra2
	sub     $i7, 1, $i7
	b       create_dirvecs.3042
bge_else.22274:
	jr      $ra3
.end create_dirvecs

######################################################################
# init_dirvec_constants($i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i11, 0, bge_else.22275
bge_then.22275:
	load    [$i10 + $i11], $i7
	jal     setup_dirvec_constants.2829, $ra2
	sub     $i11, 1, $i11
	b       init_dirvec_constants.3044
bge_else.22275:
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
	bl      $i12, 0, bge_else.22276
bge_then.22276:
	li      119, $i11
	load    [ext_dirvecs + $i12], $i10
	jal     init_dirvec_constants.3044, $ra3
	sub     $i12, 1, $i12
	b       init_vecset_constants.3047
bge_else.22276:
	jr      $ra4
.end init_vecset_constants

######################################################################
# init_dirvecs()
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f17]
# []
# []
# [$ra - $ra3]
######################################################################
.begin init_dirvecs
init_dirvecs.3049:
	li      4, $i7
	jal     create_dirvecs.3042, $ra3
	li      0, $i1
	li      0, $i7
	li      0, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc19, $f9
.count move_args
	mov     $fc11, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i6
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc11, $f9
.count move_args
	mov     $fc11, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i5
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc18, $f9
.count move_args
	mov     $fc11, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $fc17, $f9
.count move_args
	mov     $fc11, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i6
	li      2, $i5
.count move_args
	mov     $fc11, $f14
	jal     calc_dirvecs.3028, $ra2
	li      4, $i11
	li      2, $i10
	li      8, $i9
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i12
	b       init_vecset_constants.3047
.end init_dirvecs

######################################################################
# add_reflection($i10, $i11, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i12]
# [$f1 - $f9]
# []
# []
# [$ra - $ra2]
######################################################################
.begin add_reflection
add_reflection.3051:
	jal     create_dirvec.3037, $ra1
.count move_ret
	mov     $i1, $i12
	load    [$i12 + 0], $i1
	store   $f1, [$i1 + 0]
	store   $f3, [$i1 + 1]
	store   $f4, [$i1 + 2]
.count move_args
	mov     $i12, $i7
	jal     setup_dirvec_constants.2829, $ra2
	mov     $hp, $i1
	add     $hp, 3, $hp
	store   $f9, [$i1 + 2]
	store   $i12, [$i1 + 1]
	store   $i11, [$i1 + 0]
	store   $i1, [ext_reflections + $i10]
	jr      $ra3
.end add_reflection

######################################################################
# setup_rect_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig3]
# []
# [$ra - $ra3]
######################################################################
.begin setup_rect_reflection
setup_rect_reflection.3058:
	load    [$i2 + 7], $i2
	fneg    $fg13, $f10
	fneg    $fg12, $f11
	load    [$i2 + 0], $f1
	fsub    $fc0, $f1, $f12
	add     $i1, $i1, $i1
	add     $i1, $i1, $i13
	add     $i13, 1, $i11
.count move_args
	mov     $ig3, $i10
.count move_args
	mov     $f12, $f9
.count move_args
	mov     $fg15, $f1
.count move_args
	mov     $f11, $f3
.count move_args
	mov     $f10, $f4
	jal     add_reflection.3051, $ra3
	fneg    $fg15, $f13
	add     $i13, 2, $i11
	add     $ig3, 1, $i10
.count move_args
	mov     $f12, $f9
.count move_args
	mov     $f13, $f1
.count move_args
	mov     $fg12, $f3
.count move_args
	mov     $f10, $f4
	jal     add_reflection.3051, $ra3
	add     $i13, 3, $i11
	add     $ig3, 2, $i10
.count move_args
	mov     $f12, $f9
.count move_args
	mov     $f13, $f1
.count move_args
	mov     $f11, $f3
.count move_args
	mov     $fg13, $f4
	jal     add_reflection.3051, $ra3
	add     $ig3, 3, $ig3
	jr      $ra4
.end setup_rect_reflection

######################################################################
# setup_surface_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f9]
# [$ig3]
# []
# [$ra - $ra3]
######################################################################
.begin setup_surface_reflection
setup_surface_reflection.3061:
	load    [$i2 + 7], $i3
	load    [$i2 + 4], $i2
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i11
	load    [$i3 + 0], $f1
	fsub    $fc0, $f1, $f9
	load    [$i2 + 2], $f1
	fmul    $fg13, $f1, $f2
	load    [$i2 + 1], $f3
	fmul    $fg12, $f3, $f4
	load    [$i2 + 0], $f5
	fmul    $fg15, $f5, $f6
	fadd    $f6, $f4, $f4
	fadd    $f4, $f2, $f2
	fmul    $fc8, $f1, $f1
	fmul    $f1, $f2, $f1
	fsub    $f1, $fg13, $f4
	fmul    $fc8, $f3, $f1
	fmul    $f1, $f2, $f1
	fsub    $f1, $fg12, $f3
	fmul    $fc8, $f5, $f1
	fmul    $f1, $f2, $f1
	fsub    $f1, $fg15, $f1
.count move_args
	mov     $ig3, $i10
	jal     add_reflection.3051, $ra3
	add     $ig3, 1, $ig3
	jr      $ra4
.end setup_surface_reflection

######################################################################
# setup_reflections($i1)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig3]
# []
# [$ra - $ra3]
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i1, 0, bge_else.22277
bge_then.22277:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, be_else.22278
be_then.22278:
	load    [$i2 + 7], $i3
	load    [$i3 + 0], $f1
	bg      $fc0, $f1, ble_else.22279
ble_then.22279:
	jr      $ra4
ble_else.22279:
	load    [$i2 + 1], $i3
	be      $i3, 1, setup_rect_reflection.3058
	be      $i3, 2, setup_surface_reflection.3061
	jr      $ra4
be_else.22278:
	jr      $ra4
bge_else.22277:
	jr      $ra4
.end setup_reflections

######################################################################
# rt()
# $ra = $ra9
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra8]
######################################################################
.begin rt
rt.3066:
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i36
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i37
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i38
	jal     read_parameter.2731, $ra3
	call    write_ppm_header.2974
	jal     init_dirvecs.3049, $ra4
	li      ext_light_dirvec, $i7
	load    [ext_light_dirvec + 0], $i1
	store   $fg15, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	sub     $ig0, 1, $i1
	jal     setup_reflections.3064, $ra4
.count load_float
	load    [f.21506], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f3
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f2
	load    [ext_screeny_dir + 0], $f4
	fmul    $f1, $f4, $f1
	fadd    $f1, $fg22, $f1
	li      127, $i32
	li      0, $i33
.count move_args
	mov     $i37, $i31
	jal     pretrace_pixels.2983, $ra7
	li      2, $i39
	li      0, $i35
	b       scan_line.3000
.end rt

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i39]
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
	sub     $sp, 1, $sp
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
	load    [ext_screenz_dir + 0], $fg22
	load    [ext_screeny_dir + 2], $fg23
	load    [ext_screeny_dir + 1], $fg24
	load    [f.21456 + 0], $fc0
	load    [f.21481 + 0], $fc1
	load    [f.21480 + 0], $fc2
	load    [f.21455 + 0], $fc3
	load    [f.21457 + 0], $fc4
	load    [f.21483 + 0], $fc5
	load    [f.21482 + 0], $fc6
	load    [f.21460 + 0], $fc7
	load    [f.21454 + 0], $fc8
	load    [f.21470 + 0], $fc9
	load    [f.21469 + 0], $fc10
	load    [f.21493 + 0], $fc11
	load    [f.21476 + 0], $fc12
	load    [f.21475 + 0], $fc13
	load    [f.21464 + 0], $fc14
	load    [f.21459 + 0], $fc15
	load    [f.21438 + 0], $fc16
	load    [f.21497 + 0], $fc17
	load    [f.21496 + 0], $fc18
	load    [f.21495 + 0], $fc19
	jal     rt.3066, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
.end main
