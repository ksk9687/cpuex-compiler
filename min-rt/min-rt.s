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
f.21573:	.float  -6.4000000000E+01
f.21565:	.float  -5.0000000000E-01
f.21564:	.float  7.0000000000E-01
f.21563:	.float  -3.0000000000E-01
f.21562:	.float  -1.0000000000E-01
f.21561:	.float  9.0000000000E-01
f.21560:	.float  2.0000000000E-01
f.21550:	.float  1.5000000000E+02
f.21549:	.float  -1.5000000000E+02
f.21548:	.float  6.6666666667E-03
f.21547:	.float  -6.6666666667E-03
f.21546:	.float  -2.0000000000E+00
f.21545:	.float  3.9062500000E-03
f.21544:	.float  2.5600000000E+02
f.21543:	.float  1.0000000000E+08
f.21542:	.float  1.0000000000E+09
f.21541:	.float  1.0000000000E+01
f.21540:	.float  2.0000000000E+01
f.21539:	.float  5.0000000000E-02
f.21538:	.float  2.5000000000E-01
f.21537:	.float  2.5500000000E+02
f.21536:	.float  1.0000000000E-01
f.21535:	.float  8.5000000000E+02
f.21534:	.float  1.5000000000E-01
f.21533:	.float  9.5492964444E+00
f.21532:	.float  3.1830988148E-01
f.21531:	.float  3.1415927000E+00
f.21530:	.float  3.0000000000E+01
f.21529:	.float  1.5000000000E+01
f.21528:	.float  1.0000000000E-04
f.21527:	.float  -1.0000000000E-01
f.21526:	.float  1.0000000000E-02
f.21525:	.float  -2.0000000000E-01
f.21524:	.float  5.0000000000E-01
f.21523:	.float  1.0000000000E+00
f.21522:	.float  -1.0000000000E+00
f.21521:	.float  2.0000000000E+00
f.21507:	.float  -2.0000000000E+02
f.21506:	.float  2.0000000000E+02
f.21505:	.float  1.7453293000E-02

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
	fmul    $f10, $f1, $f2
.count load_float
	load    [f.21506], $f3
	fmul    $f2, $f3, $fg20
.count load_float
	load    [f.21507], $f2
	fmul    $f9, $f2, $fg21
	fmul    $f10, $f8, $f2
	fmul    $f2, $f3, $fg22
	store   $f8, [ext_screenx_dir + 0]
	fneg    $f1, $f2
	store   $f2, [ext_screenx_dir + 2]
	fneg    $f9, $f2
	fmul    $f2, $f1, $fg23
	fneg    $f10, $fg24
	fmul    $f2, $f8, $f1
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
	jr      $ra1
.end read_screen_settings

######################################################################
# read_light()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f10]
# []
# [$fg12 - $fg14]
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
	fmul    $f10, $f1, $fg14
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
	bne     $i7, -1, bne.21593
be.21593:
	li      0, $i1
	jr      $ra1
bne.21593:
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
	bne     $i10, 0, bne.21594
be.21594:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	ble     $f0, $f3, ble.21595
.count dual_jmp
	b       bg.21595
bne.21594:
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 2]
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	bg      $f0, $f3, bg.21595
ble.21595:
	li      0, $i2
	be      $i8, 2, be.21596
.count dual_jmp
	b       bne.21596
bg.21595:
	li      1, $i2
	bne     $i8, 2, bne.21596
be.21596:
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
	be      $i8, 3, be.21597
.count dual_jmp
	b       bne.21597
bne.21596:
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
	bne     $i8, 3, bne.21597
be.21597:
	load    [$i11 + 0], $f1
	be      $f1, $f0, be.21599
bne.21598:
	bne     $f1, $f0, bne.21599
be.21599:
	mov     $f0, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.21602
.count dual_jmp
	b       bne.21601
bne.21599:
	bg      $f1, $f0, bg.21600
ble.21600:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.21602
.count dual_jmp
	b       bne.21601
bg.21600:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	be      $f1, $f0, be.21602
bne.21601:
	bne     $f1, $f0, bne.21602
be.21602:
	mov     $f0, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.21605
.count dual_jmp
	b       bne.21604
bne.21602:
	bg      $f1, $f0, bg.21603
ble.21603:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.21605
.count dual_jmp
	b       bne.21604
bg.21603:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	be      $f1, $f0, be.21605
bne.21604:
	bne     $f1, $f0, bne.21605
be.21605:
	mov     $f0, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bne.21605:
	bg      $f1, $f0, bg.21606
ble.21606:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bg.21606:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bne.21597:
	bne     $i8, 2, bne.21608
be.21608:
	load    [$i11 + 0], $f1
	load    [$i11 + 1], $f3
	fmul    $f3, $f3, $f3
	fmul    $f1, $f1, $f2
	fadd    $f2, $f3, $f2
	load    [$i11 + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.21609
be.21609:
	li      1, $i1
	be      $f2, $f0, be.21610
.count dual_jmp
	b       bne.21610
bne.21609:
	li      0, $i1
	bne     $f2, $f0, bne.21610
be.21610:
	mov     $fc0, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bne.21610:
	bne     $i1, 0, bne.21611
be.21611:
	finv    $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bne.21611:
	finv_n  $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	be      $i10, 0, be.21613
.count dual_jmp
	b       bne.21613
bne.21608:
	bne     $i10, 0, bne.21613
be.21613:
	li      1, $i1
	jr      $ra1
bne.21613:
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
	fmul    $f11, $f8, $f2
	fmul    $f2, $f2, $f3
	load    [$i11 + 0], $f4
	fmul    $f4, $f3, $f3
	fmul    $f11, $f1, $f5
	fmul    $f5, $f5, $f6
	load    [$i11 + 1], $f7
	fmul    $f7, $f6, $f6
	fadd    $f3, $f6, $f3
	fneg    $f12, $f6
	fmul    $f6, $f6, $f13
	load    [$i11 + 2], $f14
	fmul    $f14, $f13, $f13
	fadd    $f3, $f13, $f3
	store   $f3, [$i11 + 0]
	fmul    $f10, $f12, $f3
	fmul    $f3, $f8, $f13
	fmul    $f9, $f1, $f15
	fsub    $f13, $f15, $f13
	fmul    $f13, $f13, $f15
	fmul    $f4, $f15, $f15
	fmul    $f3, $f1, $f3
	fmul    $f9, $f8, $f16
	fadd    $f3, $f16, $f3
	fmul    $f3, $f3, $f16
	fmul    $f7, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f10, $f11, $f16
	fmul    $f16, $f16, $f17
	fmul    $f14, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i11 + 1]
	fmul    $f9, $f12, $f12
	fmul    $f12, $f8, $f15
	fmul    $f10, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f4, $f17, $f17
	fmul    $f12, $f1, $f1
	fmul    $f10, $f8, $f8
	fsub    $f1, $f8, $f1
	fmul    $f1, $f1, $f8
	fmul    $f7, $f8, $f8
	fadd    $f17, $f8, $f8
	fmul    $f9, $f11, $f9
	fmul    $f9, $f9, $f10
	fmul    $f14, $f10, $f10
	fadd    $f8, $f10, $f8
	store   $f8, [$i11 + 2]
	fmul    $f4, $f13, $f8
	fmul    $f8, $f15, $f8
	fmul    $f7, $f3, $f10
	fmul    $f10, $f1, $f10
	fadd    $f8, $f10, $f8
	fmul    $f14, $f16, $f10
	fmul    $f10, $f9, $f10
	fadd    $f8, $f10, $f8
	fmul    $fc10, $f8, $f8
	store   $f8, [$i15 + 0]
	fmul    $f4, $f2, $f2
	fmul    $f2, $f15, $f4
	fmul    $f7, $f5, $f5
	fmul    $f5, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f14, $f6, $f4
	fmul    $f4, $f9, $f6
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
# read_object($i16)
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_object
read_object.2721:
	bl      $i16, 60, bl.21614
bge.21614:
	jr      $ra2
bl.21614:
.count move_args
	mov     $i16, $i6
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, bne.21615
be.21615:
	mov     $i16, $ig0
	jr      $ra2
bne.21615:
	add     $i16, 1, $i16
	b       read_object.2721
.end read_object

######################################################################
# read_all_object()
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f17]
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
	add     $sp, -3, $sp
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	bne     $i1, -1, bne.21617
be.21617:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
bne.21617:
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
	bne     $i2, -1, bne.21621
be.21621:
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
bne.21621:
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
	bne     $i2, -1, bne.21624
be.21624:
	jr      $ra1
bne.21624:
	store   $i1, [ext_and_net + $i6]
	add     $i6, 1, $i6
	b       read_and_network.2729
.end read_and_network

######################################################################
# read_parameter()
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0 - $ig1]
# [$fg12 - $fg14, $fg20 - $fg24]
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
	bne     $i4, 1, bne.21625
be.21625:
	be      $f4, $f0, ble.21632
bne.21626:
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.21627
ble.21627:
	li      0, $i5
	be      $i4, 0, be.21628
.count dual_jmp
	b       bne.21628
bg.21627:
	li      1, $i5
	bne     $i4, 0, bne.21628
be.21628:
	mov     $i5, $i4
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.21630
be.21630:
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21632
.count dual_jmp
	b       bg.21631
bne.21630:
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21632
.count dual_jmp
	b       bg.21631
bne.21628:
	load    [$i3 + 0], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.21629
be.21629:
	li      1, $i4
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21632
.count dual_jmp
	b       bg.21631
bne.21629:
	li      0, $i4
	fneg    $f7, $f7
	fsub    $f7, $f1, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21632
bg.21631:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.21632
ble.21632:
	li      0, $i3
	load    [$i2 + 1], $f4
	be      $f4, $f0, ble.21640
bne.21634:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, bg.21635
ble.21635:
	li      0, $i5
	be      $i4, 0, be.21636
.count dual_jmp
	b       bne.21636
bg.21635:
	li      1, $i5
	bne     $i4, 0, bne.21636
be.21636:
	mov     $i5, $i4
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	be      $i4, 0, bne.21637
.count dual_jmp
	b       be.21637
bne.21636:
	load    [$i3 + 1], $f7
	finv    $f4, $f4
	bne     $i5, 0, bne.21637
be.21637:
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.21640
.count dual_jmp
	b       bg.21639
bne.21637:
	fneg    $f7, $f7
	fsub    $f7, $f2, $f7
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.21640
bg.21639:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.21640
ble.21640:
	li      0, $i3
	load    [$i2 + 2], $f4
	be      $f4, $f0, ble.21656
bne.21642:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, bg.21643
ble.21643:
	li      0, $i4
	be      $i1, 0, be.21644
.count dual_jmp
	b       bne.21644
bg.21643:
	li      1, $i4
	bne     $i1, 0, bne.21644
be.21644:
	mov     $i4, $i1
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	be      $i1, 0, bne.21645
.count dual_jmp
	b       be.21645
bne.21644:
	load    [$i3 + 2], $f7
	finv    $f4, $f4
	bne     $i4, 0, bne.21645
be.21645:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.21656
.count dual_jmp
	b       bg.21647
bne.21645:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, ble.21656
bg.21647:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.21656
bg.21648:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bg.21640:
	mov     $f4, $fg0
	li      2, $i1
	ret     
bg.21632:
	mov     $f4, $fg0
	li      1, $i1
	ret     
bne.21625:
	bne     $i4, 2, bne.21649
be.21649:
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
	ble     $f4, $f0, ble.21656
bg.21650:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.21649:
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
	bne     $i5, 0, bne.21651
be.21651:
	be      $f7, $f0, ble.21656
.count dual_jmp
	b       bne.21652
bne.21651:
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
	be      $f7, $f0, ble.21656
bne.21652:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i5, 0, bne.21653
be.21653:
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
	be      $i5, 0, be.21654
.count dual_jmp
	b       bne.21654
bne.21653:
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
	bne     $i5, 0, bne.21654
be.21654:
	mov     $f6, $f1
	be      $i4, 3, be.21655
.count dual_jmp
	b       bne.21655
bne.21654:
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
	bne     $i4, 3, bne.21655
be.21655:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, ble.21656
.count dual_jmp
	b       bg.21656
bne.21655:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, bg.21656
ble.21656:
	li      0, $i1
	ret     
bg.21656:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, bne.21657
be.21657:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.21657:
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
	bne     $i5, 1, bne.21658
be.21658:
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
	ble     $f4, $f5, be.21661
bg.21659:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.21661
bg.21660:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.21661
be.21661:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.21665
bg.21663:
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.21665
bg.21664:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.21665
be.21665:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.21675
bg.21667:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.21675
bg.21668:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.21675
bne.21669:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.21665:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.21661:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.21658:
	load    [$i1 + 0], $f4
	bne     $i5, 2, bne.21670
be.21670:
	ble     $f0, $f4, ble.21675
bg.21671:
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
bne.21670:
	be      $f4, $f0, ble.21675
bne.21672:
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
	bne     $i4, 0, bne.21673
be.21673:
	mov     $f7, $f1
	be      $i5, 3, be.21674
.count dual_jmp
	b       bne.21674
bne.21673:
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
	bne     $i5, 3, bne.21674
be.21674:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.21675
.count dual_jmp
	b       bg.21675
bne.21674:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, bg.21675
ble.21675:
	li      0, $i1
	ret     
bg.21675:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.21676
be.21676:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret     
bne.21676:
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
	bne     $i6, 1, bne.21677
be.21677:
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
	ble     $f4, $f5, be.21680
bg.21678:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	ble     $f5, $f7, be.21680
bg.21679:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, bne.21680
be.21680:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	ble     $f5, $f6, be.21684
bg.21682:
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	ble     $f6, $f8, be.21684
bg.21683:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, bne.21684
be.21684:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	ble     $f5, $f1, ble.21692
bg.21686:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	ble     $f4, $f1, ble.21692
bg.21687:
	load    [$i1 + 5], $f1
	be      $f1, $f0, ble.21692
bne.21688:
	mov     $f3, $fg0
	li      3, $i1
	ret     
bne.21684:
	mov     $f7, $fg0
	li      2, $i1
	ret     
bne.21680:
	mov     $f6, $fg0
	li      1, $i1
	ret     
bne.21677:
	bne     $i6, 2, bne.21689
be.21689:
	load    [$i1 + 0], $f1
	ble     $f0, $f1, ble.21692
bg.21690:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.21689:
	load    [$i1 + 0], $f4
	be      $f4, $f0, ble.21692
bne.21691:
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
	bg      $f2, $f0, bg.21692
ble.21692:
	li      0, $i1
	ret     
bg.21692:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, bne.21693
be.21693:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret     
bne.21693:
	fadd    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
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
	bne     $f1, $f0, bne.21694
be.21694:
	store   $f0, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.21699
.count dual_jmp
	b       bne.21699
bne.21694:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, bg.21695
ble.21695:
	li      0, $i3
	be      $i2, 0, be.21696
.count dual_jmp
	b       bne.21696
bg.21695:
	li      1, $i3
	bne     $i2, 0, bne.21696
be.21696:
	mov     $i3, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, bne.21698
be.21698:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.21699
.count dual_jmp
	b       bne.21699
bne.21698:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.21699
.count dual_jmp
	b       bne.21699
bne.21696:
	bne     $i3, 0, bne.21697
be.21697:
	li      1, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	be      $f1, $f0, be.21699
.count dual_jmp
	b       bne.21699
bne.21697:
	li      0, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
	load    [$i4 + 1], $f1
	bne     $f1, $f0, bne.21699
be.21699:
	store   $f0, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.21704
.count dual_jmp
	b       bne.21704
bne.21699:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, bg.21700
ble.21700:
	li      0, $i3
	be      $i2, 0, be.21701
.count dual_jmp
	b       bne.21701
bg.21700:
	li      1, $i3
	bne     $i2, 0, bne.21701
be.21701:
	mov     $i3, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, bne.21703
be.21703:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.21704
.count dual_jmp
	b       bne.21704
bne.21703:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.21704
.count dual_jmp
	b       bne.21704
bne.21701:
	bne     $i3, 0, bne.21702
be.21702:
	li      1, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	be      $f1, $f0, be.21704
.count dual_jmp
	b       bne.21704
bne.21702:
	li      0, $i2
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
	load    [$i4 + 2], $f1
	bne     $f1, $f0, bne.21704
be.21704:
	store   $f0, [$i1 + 5]
	jr      $ra1
bne.21704:
	load    [$i5 + 6], $i2
	load    [$i5 + 4], $i3
	bg      $f0, $f1, bg.21705
ble.21705:
	li      0, $i5
	be      $i2, 0, be.21706
.count dual_jmp
	b       bne.21706
bg.21705:
	li      1, $i5
	bne     $i2, 0, bne.21706
be.21706:
	mov     $i5, $i2
	load    [$i3 + 2], $f1
	be      $i2, 0, bne.21707
.count dual_jmp
	b       be.21707
bne.21706:
	load    [$i3 + 2], $f1
	bne     $i5, 0, bne.21707
be.21707:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
bne.21707:
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
	bg      $f1, $f0, bg.21709
ble.21709:
	store   $f0, [$i1 + 0]
	jr      $ra1
bg.21709:
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
	bne     $i2, 0, bne.21710
be.21710:
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
	be      $i2, 0, be.21711
.count dual_jmp
	b       bne.21711
bne.21710:
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
	bne     $i2, 0, bne.21711
be.21711:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	be      $f1, $f0, be.21713
.count dual_jmp
	b       bne.21713
bne.21711:
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
	bne     $f1, $f0, bne.21713
be.21713:
	jr      $ra1
bne.21713:
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
	bl      $i8, 0, bl.21714
bge.21714:
	load    [$i7 + 1], $i9
	load    [ext_objects + $i8], $i5
	load    [$i5 + 1], $i1
	load    [$i7 + 0], $i4
	bne     $i1, 1, bne.21715
be.21715:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.21715:
	bne     $i1, 2, bne.21716
be.21716:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bne.21716:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i9, $i8, $tmp
	store   $i1, [$tmp + 0]
	add     $i8, -1, $i8
	b       iter_setup_dirvec_constants.2826
bl.21714:
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
	add     $ig0, -1, $i8
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f6]
# []
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bl.21717
bge.21717:
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
	bne     $i4, 2, bne.21718
be.21718:
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
bne.21718:
	bg      $i4, 2, bg.21719
ble.21719:
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bg.21719:
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
	bne     $i7, 0, bne.21720
be.21720:
	mov     $f4, $f1
	be      $i4, 3, be.21721
.count dual_jmp
	b       bne.21721
bne.21720:
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
	bne     $i4, 3, bne.21721
be.21721:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bne.21721:
	store   $f1, [$i5 + 3]
	add     $i1, -1, $i1
	b       setup_startp_constants.2831
bl.21717:
	ret     
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f9]
# []
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
bne.21722:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.21723
be.21723:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.21728
bg.21724:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.21728
bg.21726:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.21728
ble.21728:
	be      $i2, 0, bne.21738
.count dual_jmp
	b       be.21738
bg.21728:
	bne     $i2, 0, bne.21738
be.21739:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
.count dual_jmp
	b       bne.21740
bne.21723:
	bne     $i4, 2, bne.21730
be.21730:
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
	bg      $f0, $f1, bg.21731
ble.21731:
	be      $i4, 0, bne.21738
.count dual_jmp
	b       be.21738
bg.21731:
	be      $i4, 0, be.21738
.count dual_jmp
	b       bne.21738
bne.21730:
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
	bne     $i6, 0, bne.21734
be.21734:
	mov     $f7, $f1
	be      $i4, 3, be.21735
.count dual_jmp
	b       bne.21735
bne.21734:
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
	bne     $i4, 3, bne.21735
be.21735:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.21736
.count dual_jmp
	b       bg.21736
bne.21735:
	bg      $f0, $f1, bg.21736
ble.21736:
	be      $i5, 0, bne.21738
.count dual_jmp
	b       be.21738
bg.21736:
	bne     $i5, 0, bne.21738
be.21738:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
bne.21740:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i4 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i4 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.21741
be.21741:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.21746
bg.21742:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.21746
bg.21744:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.21746
ble.21746:
	be      $i2, 0, bne.21738
.count dual_jmp
	b       be.21756
bg.21746:
	bne     $i2, 0, bne.21738
be.21757:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
.count dual_jmp
	b       bne.21758
bne.21741:
	load    [$i2 + 6], $i4
	bne     $i5, 2, bne.21748
be.21748:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.21754
.count dual_jmp
	b       bg.21754
bne.21748:
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
	bne     $i7, 0, bne.21752
be.21752:
	mov     $f7, $f1
	be      $i5, 3, be.21753
.count dual_jmp
	b       bne.21753
bne.21752:
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
	bne     $i5, 3, bne.21753
be.21753:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.21754
.count dual_jmp
	b       bg.21754
bne.21753:
	bg      $f0, $f1, bg.21754
ble.21754:
	be      $i4, 0, bne.21738
.count dual_jmp
	b       be.21756
bg.21754:
	bne     $i4, 0, bne.21738
be.21756:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
bne.21758:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i5 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, bne.21759
be.21759:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	ble     $f7, $f1, ble.21764
bg.21760:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.21764
bg.21762:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.21764
ble.21764:
	be      $i2, 0, bne.21738
.count dual_jmp
	b       be.21774
bg.21764:
	bne     $i2, 0, bne.21738
be.21775:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	be      $i2, -1, be.21776
.count dual_jmp
	b       bne.21776
bne.21759:
	bne     $i4, 2, bne.21766
be.21766:
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
	bg      $f0, $f1, bg.21767
ble.21767:
	be      $i4, 0, bne.21738
.count dual_jmp
	b       be.21774
bg.21767:
	be      $i4, 0, be.21774
.count dual_jmp
	b       bne.21738
bne.21766:
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
	bne     $i6, 0, bne.21770
be.21770:
	mov     $f7, $f1
	be      $i4, 3, be.21771
.count dual_jmp
	b       bne.21771
bne.21770:
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
	bne     $i4, 3, bne.21771
be.21771:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.21772
.count dual_jmp
	b       bg.21772
bne.21771:
	bg      $f0, $f1, bg.21772
ble.21772:
	be      $i5, 0, bne.21738
.count dual_jmp
	b       be.21774
bg.21772:
	bne     $i5, 0, bne.21738
be.21774:
	li      0, $i2
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, bne.21776
be.21776:
	li      1, $i1
	ret     
bne.21776:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 1], $i5
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f5
	load    [$i4 + 2], $f6
	fsub    $f2, $f1, $f1
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	bne     $i5, 1, bne.21777
be.21777:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	ble     $f7, $f1, ble.21780
bg.21778:
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	ble     $f1, $f5, ble.21780
bg.21779:
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, bg.21780
ble.21780:
	load    [$i2 + 6], $i2
	be      $i2, 0, bne.21738
.count dual_jmp
	b       be.21792
bg.21780:
	load    [$i2 + 6], $i2
	be      $i2, 0, be.21792
.count dual_jmp
	b       bne.21738
bne.21777:
	load    [$i2 + 6], $i4
	bne     $i5, 2, bne.21784
be.21784:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	ble     $f0, $f1, ble.21790
.count dual_jmp
	b       bg.21790
bne.21784:
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
	bne     $i7, 0, bne.21788
be.21788:
	mov     $f7, $f1
	be      $i5, 3, be.21789
.count dual_jmp
	b       bne.21789
bne.21788:
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
	bne     $i5, 3, bne.21789
be.21789:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.21790
.count dual_jmp
	b       bg.21790
bne.21789:
	bg      $f0, $f1, bg.21790
ble.21790:
	be      $i4, 0, bne.21738
.count dual_jmp
	b       be.21792
bg.21790:
	bne     $i4, 0, bne.21738
be.21792:
	add     $i1, 1, $i1
	b       check_all_inside.2856
bne.21738:
	li      0, $i1
	ret     
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i8, $i9)
# $ra = $ra1
# [$i1 - $i9]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i9 + $i8], $i1
	be      $i1, -1, be.21816
bne.21793:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 5], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 1], $i5
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i3 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i3 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [$i4 + $i1], $i3
	bne     $i5, 1, bne.21794
be.21794:
	load    [ext_light_dirvec + 0], $i4
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f4
	load    [$i4 + 1], $f5
	load    [$i3 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i3 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.21797
bg.21795:
	load    [$i2 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21797
bg.21796:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, bne.21797
be.21797:
	load    [$i2 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.21801
bg.21799:
	load    [$i2 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21801
bg.21800:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, bne.21797
be.21801:
	load    [$i2 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, ble.21814
bg.21803:
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, ble.21814
bg.21804:
	load    [$i3 + 5], $f1
	be      $f1, $f0, ble.21814
bne.21805:
	mov     $f3, $fg0
.count load_float
	load    [f.21525], $f1
	ble     $f1, $fg0, ble.21814
.count dual_jmp
	b       bg.21814
bne.21797:
	mov     $f6, $fg0
.count load_float
	load    [f.21525], $f1
	ble     $f1, $fg0, ble.21814
.count dual_jmp
	b       bg.21814
bne.21794:
	load    [$i3 + 0], $f4
	bne     $i5, 2, bne.21806
be.21806:
	ble     $f0, $f4, ble.21814
bg.21807:
	load    [$i3 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i3 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i3 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
.count load_float
	load    [f.21525], $f1
	ble     $f1, $fg0, ble.21814
.count dual_jmp
	b       bg.21814
bne.21806:
	be      $f4, $f0, ble.21814
bne.21808:
	load    [$i3 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i3 + 2], $f6
	fmul    $f6, $f2, $f6
	fadd    $f5, $f6, $f5
	load    [$i3 + 3], $f6
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
	bne     $i4, 0, bne.21809
be.21809:
	mov     $f7, $f1
	be      $i5, 3, be.21810
.count dual_jmp
	b       bne.21810
bne.21809:
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
	bne     $i5, 3, bne.21810
be.21810:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.21814
.count dual_jmp
	b       bg.21811
bne.21810:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, ble.21814
bg.21811:
	load    [$i2 + 6], $i2
	load    [$i3 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.21812
be.21812:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21525], $f1
	ble     $f1, $fg0, ble.21814
.count dual_jmp
	b       bg.21814
bne.21812:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count load_float
	load    [f.21525], $f1
	bg      $f1, $fg0, bg.21814
ble.21814:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, bne.21833
be.21816:
	li      0, $i1
	jr      $ra1
bg.21814:
	li      1, $i2
	load    [$i9 + 0], $i1
	be      $i1, -1, bne.21835
bne.21817:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 1], $i3
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
	bne     $i3, 1, bne.21818
be.21818:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f4
	fabs    $f1, $f1
	load    [$i1 + 6], $i1
	ble     $f4, $f1, ble.21823
bg.21819:
	load    [$i2 + 1], $f1
	fabs    $f3, $f3
	ble     $f1, $f3, ble.21823
bg.21821:
	load    [$i2 + 2], $f1
	fabs    $f2, $f2
	bg      $f1, $f2, bg.21823
ble.21823:
	be      $i1, 0, bne.21833
.count dual_jmp
	b       be.21833
bg.21823:
	be      $i1, 0, be.21833
.count dual_jmp
	b       bne.21833
bne.21818:
	load    [$i1 + 6], $i2
	bne     $i3, 2, bne.21825
be.21825:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	ble     $f0, $f1, ble.21831
.count dual_jmp
	b       bg.21831
bne.21825:
	fmul    $f1, $f1, $f4
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f8
	fmul    $f4, $f8, $f4
	fmul    $f3, $f3, $f8
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	fmul    $f2, $f2, $f8
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	load    [$i1 + 3], $i4
	fadd    $f4, $f8, $f4
	bne     $i4, 0, bne.21829
be.21829:
	mov     $f4, $f1
	be      $i3, 3, be.21830
.count dual_jmp
	b       bne.21830
bne.21829:
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
	bne     $i3, 3, bne.21830
be.21830:
	fsub    $f1, $fc0, $f1
	ble     $f0, $f1, ble.21831
.count dual_jmp
	b       bg.21831
bne.21830:
	bg      $f0, $f1, bg.21831
ble.21831:
	be      $i2, 0, bne.21833
.count dual_jmp
	b       be.21833
bg.21831:
	bne     $i2, 0, bne.21833
be.21833:
	li      1, $i1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f7, $f4
	call    check_all_inside.2856
	bne     $i1, 0, bne.21835
bne.21833:
	add     $i8, 1, $i8
	b       shadow_check_and_group.2862
bne.21835:
	li      1, $i1
	jr      $ra1
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i10, $i11)
# $ra = $ra2
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21836:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21837:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21838:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21839:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21840:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21841:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21842:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21843:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21844:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21845:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21846:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21847:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	be      $i1, -1, be.21850
bne.21848:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21849:
	add     $i10, 1, $i10
	load    [$i11 + $i10], $i1
	bne     $i1, -1, bne.21850
be.21850:
	li      0, $i1
	jr      $ra2
bne.21850:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21837
be.21851:
	add     $i10, 1, $i10
	b       shadow_check_one_or_group.2865
bne.21837:
	li      1, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i12, $i13)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.21909
bne.21852:
	be      $i1, 99, bne.21876
bne.21853:
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
	bne     $i3, 1, bne.21854
be.21854:
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
	ble     $f4, $f5, be.21857
bg.21855:
	load    [$i2 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21857
bg.21856:
	load    [$i1 + 1], $f4
	bne     $f4, $f0, bne.21857
be.21857:
	load    [$i2 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.21861
bg.21859:
	load    [$i2 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21861
bg.21860:
	load    [$i1 + 3], $f4
	bne     $f4, $f0, bne.21861
be.21861:
	load    [$i2 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i1 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.21906
bg.21863:
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, be.21906
bg.21864:
	load    [$i1 + 5], $f1
	be      $f1, $f0, be.21906
bne.21865:
	mov     $f3, $fg0
	li      3, $i1
	ble     $fc7, $fg0, be.21906
.count dual_jmp
	b       bg.21874
bne.21861:
	mov     $f6, $fg0
	li      2, $i1
	ble     $fc7, $fg0, be.21906
.count dual_jmp
	b       bg.21874
bne.21857:
	mov     $f6, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.21906
.count dual_jmp
	b       bg.21874
bne.21854:
	load    [$i1 + 0], $f4
	bne     $i3, 2, bne.21866
be.21866:
	ble     $f0, $f4, be.21906
bg.21867:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
	ble     $fc7, $fg0, be.21906
.count dual_jmp
	b       bg.21874
bne.21866:
	be      $f4, $f0, be.21906
bne.21868:
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
	bne     $i4, 0, bne.21869
be.21869:
	mov     $f7, $f1
	be      $i3, 3, be.21870
.count dual_jmp
	b       bne.21870
bne.21869:
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
	bne     $i3, 3, bne.21870
be.21870:
	fsub    $f1, $fc0, $f1
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.21906
.count dual_jmp
	b       bg.21871
bne.21870:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	ble     $f1, $f0, be.21906
bg.21871:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, bne.21872
be.21872:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	be      $i1, 0, be.21906
.count dual_jmp
	b       bne.21873
bne.21872:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	be      $i1, 0, be.21906
bne.21873:
	ble     $fc7, $fg0, be.21906
bg.21874:
	load    [$i14 + 1], $i1
	be      $i1, -1, be.21906
bne.21875:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21876
be.21876:
	li      2, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.21906
bne.21876:
	li      1, $i1
	load    [$i14 + 1], $i1
	be      $i1, -1, be.21906
bne.21894:
	load    [ext_and_net + $i1], $i9
	li      0, $i8
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21895:
	load    [$i14 + 2], $i1
	be      $i1, -1, be.21906
bne.21896:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21897:
	load    [$i14 + 3], $i1
	be      $i1, -1, be.21906
bne.21898:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21899:
	load    [$i14 + 4], $i1
	be      $i1, -1, be.21906
bne.21900:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21901:
	load    [$i14 + 5], $i1
	be      $i1, -1, be.21906
bne.21902:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21903:
	load    [$i14 + 6], $i1
	be      $i1, -1, be.21906
bne.21904:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21905:
	load    [$i14 + 7], $i1
	bne     $i1, -1, bne.21906
be.21906:
	li      0, $i1
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.21909
.count dual_jmp
	b       bne.21909
bne.21906:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21907:
	li      8, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.21895
be.21908:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.21909
be.21909:
	li      0, $i1
	jr      $ra3
bne.21909:
	be      $i1, 99, bne.21914
bne.21910:
	call    solver_fast.2796
	be      $i1, 0, be.21913
bne.21911:
	ble     $fc7, $fg0, be.21913
bg.21912:
	load    [$i14 + 1], $i1
	be      $i1, -1, be.21913
bne.21913:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21914
be.21914:
	load    [$i14 + 2], $i1
	be      $i1, -1, be.21913
bne.21915:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21914
be.21916:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.21913
bne.21914:
	li      1, $i1
	load    [$i14 + 1], $i1
	be      $i1, -1, be.21913
bne.21919:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21920:
	load    [$i14 + 2], $i1
	be      $i1, -1, be.21913
bne.21921:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.21895
be.21922:
	li      3, $i10
.count move_args
	mov     $i14, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.21895
be.21913:
	add     $i12, 1, $i12
	b       shadow_check_one_or_matrix.2868
bne.21895:
	li      1, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i8, $i9, $i10)
# $ra = $ra1
# [$i1 - $i12]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i9 + $i8], $i11
	be      $i11, -1, be.21959
bne.21924:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 1], $i3
	load    [$i2 + 0], $f1
	fsub    $fg17, $f1, $f1
	load    [$i2 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i2 + 2], $f3
	fsub    $fg19, $f3, $f3
	load    [$i10 + 0], $f4
	bne     $i3, 1, bne.21925
be.21925:
	be      $f4, $f0, ble.21932
bne.21926:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, bg.21927
ble.21927:
	li      0, $i4
	be      $i3, 0, be.21928
.count dual_jmp
	b       bne.21928
bg.21927:
	li      1, $i4
	bne     $i3, 0, bne.21928
be.21928:
	mov     $i4, $i3
	load    [$i2 + 0], $f5
	load    [$i10 + 1], $f6
	finv    $f4, $f4
	bne     $i3, 0, bne.21930
be.21930:
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21932
.count dual_jmp
	b       bg.21931
bne.21930:
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21932
.count dual_jmp
	b       bg.21931
bne.21928:
	load    [$i2 + 0], $f5
	load    [$i10 + 1], $f6
	finv    $f4, $f4
	bne     $i4, 0, bne.21929
be.21929:
	li      1, $i3
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21932
.count dual_jmp
	b       bg.21931
bne.21929:
	li      0, $i3
	fneg    $f5, $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	ble     $f5, $f6, ble.21932
bg.21931:
	load    [$i2 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, bg.21932
ble.21932:
	li      0, $i2
	load    [$i10 + 1], $f4
	be      $f4, $f0, ble.21940
bne.21934:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, bg.21935
ble.21935:
	li      0, $i4
	be      $i3, 0, be.21936
.count dual_jmp
	b       bne.21936
bg.21935:
	li      1, $i4
	bne     $i3, 0, bne.21936
be.21936:
	mov     $i4, $i3
	load    [$i2 + 1], $f5
	load    [$i10 + 2], $f6
	finv    $f4, $f4
	be      $i3, 0, bne.21937
.count dual_jmp
	b       be.21937
bne.21936:
	load    [$i2 + 1], $f5
	load    [$i10 + 2], $f6
	finv    $f4, $f4
	bne     $i4, 0, bne.21937
be.21937:
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.21940
.count dual_jmp
	b       bg.21939
bne.21937:
	fneg    $f5, $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	ble     $f5, $f6, ble.21940
bg.21939:
	load    [$i2 + 0], $f5
	load    [$i10 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, bg.21940
ble.21940:
	li      0, $i2
	load    [$i10 + 2], $f4
	be      $f4, $f0, be.21958
bne.21942:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f5
	load    [$i10 + 0], $f6
	load    [$i1 + 6], $i1
	bg      $f0, $f4, bg.21943
ble.21943:
	li      0, $i3
	be      $i1, 0, be.21944
.count dual_jmp
	b       bne.21944
bg.21943:
	li      1, $i3
	bne     $i1, 0, bne.21944
be.21944:
	mov     $i3, $i1
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i1, 0, bne.21946
be.21946:
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, be.21958
.count dual_jmp
	b       bg.21947
bne.21946:
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, be.21958
.count dual_jmp
	b       bg.21947
bne.21944:
	load    [$i2 + 2], $f7
	finv    $f4, $f4
	bne     $i3, 0, bne.21945
be.21945:
	li      1, $i1
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, be.21958
.count dual_jmp
	b       bg.21947
bne.21945:
	li      0, $i1
	fneg    $f7, $f7
	fsub    $f7, $f3, $f3
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	ble     $f5, $f1, be.21958
bg.21947:
	load    [$i2 + 1], $f1
	load    [$i10 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, be.21958
bg.21948:
	mov     $f3, $fg0
	li      3, $i12
	ble     $fg0, $f0, bne.21959
.count dual_jmp
	b       bg.21960
bg.21940:
	mov     $f4, $fg0
	li      2, $i12
	ble     $fg0, $f0, bne.21959
.count dual_jmp
	b       bg.21960
bg.21932:
	mov     $f4, $fg0
	li      1, $i12
	ble     $fg0, $f0, bne.21959
.count dual_jmp
	b       bg.21960
bne.21925:
	bne     $i3, 2, bne.21949
be.21949:
	load    [$i1 + 4], $i1
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
	ble     $f4, $f0, be.21958
bg.21950:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i12
	ble     $fg0, $f0, bne.21959
.count dual_jmp
	b       bg.21960
bne.21949:
	load    [$i1 + 3], $i2
	load    [$i1 + 4], $i4
	load    [$i10 + 1], $f5
	load    [$i10 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i4 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i4 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i4 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	bne     $i2, 0, bne.21951
be.21951:
	be      $f7, $f0, be.21958
.count dual_jmp
	b       bne.21952
bne.21951:
	fmul    $f5, $f6, $f9
	load    [$i1 + 9], $i4
	load    [$i4 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f4, $f9
	load    [$i4 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f4, $f5, $f9
	load    [$i4 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	be      $f7, $f0, be.21958
bne.21952:
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, bne.21953
be.21953:
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
	be      $i2, 0, be.21954
.count dual_jmp
	b       bne.21954
bne.21953:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	load    [$i1 + 9], $i4
	load    [$i4 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f4, $f3, $f13
	fmul    $f6, $f1, $f6
	fadd    $f13, $f6, $f6
	load    [$i4 + 1], $f13
	fmul    $f6, $f13, $f6
	fadd    $f12, $f6, $f6
	fmul    $f4, $f2, $f4
	fmul    $f5, $f1, $f5
	fadd    $f4, $f5, $f4
	load    [$i4 + 2], $f5
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
	bne     $i2, 0, bne.21954
be.21954:
	mov     $f6, $f1
	be      $i3, 3, be.21955
.count dual_jmp
	b       bne.21955
bne.21954:
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
	bne     $i3, 3, bne.21955
be.21955:
	fsub    $f1, $fc0, $f1
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, be.21958
.count dual_jmp
	b       bg.21956
bne.21955:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	ble     $f1, $f0, be.21958
bg.21956:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	li      1, $i12
	finv    $f7, $f2
	bne     $i1, 0, bne.21957
be.21957:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	be      $i12, 0, be.21958
.count dual_jmp
	b       bne.21958
bne.21957:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	bne     $i12, 0, bne.21958
be.21958:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, bne.21959
be.21959:
	jr      $ra1
bne.21958:
	ble     $fg0, $f0, bne.21959
bg.21960:
	bg      $fg7, $fg0, bg.21961
bne.21959:
	add     $i8, 1, $i8
	b       solve_each_element.2871
bg.21961:
	li      0, $i1
	load    [$i10 + 0], $f1
	fadd    $fg0, $fc15, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg17, $f11
	load    [$i10 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg18, $f12
	load    [$i10 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg19, $f13
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f11, $f2
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f13, $f4
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element.2871
bne.21962:
	mov     $f10, $fg7
	store   $f11, [ext_intersection_point + 0]
	store   $f12, [ext_intersection_point + 1]
	store   $f13, [ext_intersection_point + 2]
	mov     $i11, $ig3
	mov     $i12, $ig2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21963:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21964:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21965:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21966:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21967:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21968:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.21970
bne.21969:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element.2871, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, bne.21970
be.21970:
	jr      $ra2
bne.21970:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
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
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.21979
bne.21971:
	bne     $i1, 99, bne.21972
be.21972:
	load    [$i14 + 1], $i1
	be      $i1, -1, be.21978
bne.21973:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, be.21978
bne.21974:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, be.21978
bne.21975:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, be.21978
bne.21976:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 5], $i1
	be      $i1, -1, be.21978
bne.21977:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 6], $i1
	bne     $i1, -1, bne.21978
be.21978:
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.21979
.count dual_jmp
	b       bne.21979
bne.21978:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	li      7, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.21979
be.21979:
	jr      $ra3
bne.21979:
	bne     $i1, 99, bne.21972
be.21980:
	load    [$i14 + 1], $i1
	be      $i1, -1, ble.21988
bne.21981:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, ble.21988
bne.21982:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, ble.21988
bne.21983:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, ble.21988
bne.21984:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element.2871, $ra1
	li      5, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network.2875, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
bne.21972:
.count move_args
	mov     $i18, $i2
	call    solver.2773
	be      $i1, 0, ble.21988
bne.21987:
	bg      $fg7, $fg0, bg.21988
ble.21988:
	add     $i16, 1, $i16
	b       trace_or_matrix.2879
bg.21988:
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
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i9 + $i8], $i11
	be      $i11, -1, be.22008
bne.21989:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 10], $i2
	load    [$i10 + 1], $i3
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 2], $f3
	load    [$i3 + $i11], $i3
	bne     $i4, 1, bne.21990
be.21990:
	load    [$i10 + 0], $i2
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i3 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i3 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	ble     $f4, $f5, be.21993
bg.21991:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21993
bg.21992:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, bne.21993
be.21993:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	ble     $f4, $f5, be.21997
bg.21995:
	load    [$i1 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	ble     $f4, $f5, be.21997
bg.21996:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, bne.21997
be.21997:
	load    [$i1 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	ble     $f4, $f1, be.22007
bg.21999:
	load    [$i1 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	ble     $f1, $f2, be.22007
bg.22000:
	load    [$i3 + 5], $f1
	be      $f1, $f0, be.22007
bne.22001:
	mov     $f3, $fg0
	li      3, $i12
	ble     $fg0, $f0, ble.22010
.count dual_jmp
	b       bg.22009
bne.21997:
	mov     $f6, $fg0
	li      2, $i12
	ble     $fg0, $f0, ble.22010
.count dual_jmp
	b       bg.22009
bne.21993:
	mov     $f6, $fg0
	li      1, $i12
	ble     $fg0, $f0, ble.22010
.count dual_jmp
	b       bg.22009
bne.21990:
	bne     $i4, 2, bne.22002
be.22002:
	load    [$i3 + 0], $f1
	ble     $f0, $f1, be.22007
bg.22003:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i12
	ble     $fg0, $f0, ble.22010
.count dual_jmp
	b       bg.22009
bne.22002:
	load    [$i3 + 0], $f4
	be      $f4, $f0, be.22007
bne.22004:
	load    [$i3 + 1], $f5
	fmul    $f5, $f1, $f1
	load    [$i3 + 2], $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i3 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	load    [$i2 + 3], $f3
	fmul    $f4, $f3, $f3
	fsub    $f2, $f3, $f2
	ble     $f2, $f0, be.22007
bg.22005:
	load    [$i1 + 6], $i1
	li      1, $i12
	fsqrt   $f2, $f2
	bne     $i1, 0, bne.22006
be.22006:
	fsub    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
	be      $i12, 0, be.22007
.count dual_jmp
	b       bne.22007
bne.22006:
	fadd    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
	bne     $i12, 0, bne.22007
be.22007:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, ble.22010
be.22008:
	jr      $ra1
bne.22007:
	ble     $fg0, $f0, ble.22010
bg.22009:
	load    [$i10 + 0], $i1
	bg      $fg7, $fg0, bg.22010
ble.22010:
	add     $i8, 1, $i8
	b       solve_each_element_fast.2885
bg.22010:
	li      0, $i2
	load    [$i1 + 0], $f1
	fadd    $fg0, $fc15, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg8, $f11
	load    [$i1 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg9, $f12
	load    [$i1 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg10, $f13
.count move_args
	mov     $i2, $i1
.count move_args
	mov     $i9, $i3
.count move_args
	mov     $f11, $f2
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f13, $f4
	call    check_all_inside.2856
	add     $i8, 1, $i8
	be      $i1, 0, solve_each_element_fast.2885
bne.22011:
	mov     $f10, $fg7
	store   $f11, [ext_intersection_point + 0]
	store   $f12, [ext_intersection_point + 1]
	store   $f13, [ext_intersection_point + 2]
	mov     $i11, $ig3
	mov     $i12, $ig2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22012:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22013:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22014:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22015:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22016:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22017:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	be      $i1, -1, be.22019
bne.22018:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i15, $i10
	jal     solve_each_element_fast.2885, $ra1
	add     $i13, 1, $i13
	load    [$i14 + $i13], $i1
	bne     $i1, -1, bne.22019
be.22019:
	jr      $ra2
bne.22019:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
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
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.22028
bne.22020:
	bne     $i1, 99, bne.22021
be.22021:
	load    [$i14 + 1], $i1
	be      $i1, -1, be.22027
bne.22022:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, be.22027
bne.22023:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, be.22027
bne.22024:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, be.22027
bne.22025:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 5], $i1
	be      $i1, -1, be.22027
bne.22026:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 6], $i1
	bne     $i1, -1, bne.22027
be.22027:
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	be      $i1, -1, be.22028
.count dual_jmp
	b       bne.22028
bne.22027:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.22028
be.22028:
	jr      $ra3
bne.22028:
	bne     $i1, 99, bne.22021
be.22029:
	load    [$i14 + 1], $i1
	be      $i1, -1, ble.22037
bne.22030:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, ble.22037
bne.22031:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, ble.22037
bne.22032:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, ble.22037
bne.22033:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i18, $i10
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i13
.count move_args
	mov     $i18, $i15
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
bne.22021:
.count move_args
	mov     $i18, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22037
bne.22036:
	bg      $fg7, $fg0, bg.22037
ble.22037:
	add     $i16, 1, $i16
	b       trace_or_matrix_fast.2893
bg.22037:
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
	bne     $i2, 1, bne.22038
be.22038:
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + 0], $f2
.count load_float
	load    [f.21539], $f4
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.21540], $f6
.count load_float
	load    [f.21541], $f7
	fmul    $f1, $f6, $f1
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 2], $f1
	load    [$i1 + 2], $f2
	fsub    $f1, $f2, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	bg      $f7, $f5, bg.22039
ble.22039:
	li      0, $i1
	ble     $f7, $f1, ble.22040
.count dual_jmp
	b       bg.22040
bg.22039:
	li      1, $i1
	bg      $f7, $f1, bg.22040
ble.22040:
	be      $i1, 0, bne.22042
.count dual_jmp
	b       be.22042
bg.22040:
	bne     $i1, 0, bne.22042
be.22042:
	mov     $f0, $fg11
	jr      $ra1
bne.22042:
	mov     $fc8, $fg11
	jr      $ra1
bne.22038:
	bne     $i2, 2, bne.22043
be.22043:
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.21538], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc8, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc8, $f1, $fg11
	jr      $ra1
bne.22043:
	bne     $i2, 3, bne.22044
be.22044:
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
bne.22044:
	bne     $i2, 4, bne.22045
be.22045:
	load    [$i1 + 5], $i3
	load    [$i1 + 4], $i1
.count load_float
	load    [f.21528], $f6
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
	bg      $f6, $f1, bg.22046
ble.22046:
	finv    $f7, $f1
	fmul_a  $f8, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21530], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21532], $f2
.count load_float
	load    [f.21533], $f2
	fmul    $f2, $f1, $f9
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
	ble     $f6, $f2, ble.22047
.count dual_jmp
	b       bg.22047
bg.22046:
.count load_float
	load    [f.21529], $f9
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
	bg      $f6, $f2, bg.22047
ble.22047:
	finv    $f1, $f1
	fmul_a  $f3, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21530], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21532], $f2
.count load_float
	load    [f.21533], $f2
	fmul    $f2, $f1, $f4
.count load_float
	load    [f.21534], $f5
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
	ble     $f0, $f1, ble.22048
.count dual_jmp
	b       bg.22048
bg.22047:
.count load_float
	load    [f.21529], $f4
.count load_float
	load    [f.21534], $f5
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
	bg      $f0, $f1, bg.22048
ble.22048:
.count load_float
	load    [f.21535], $f2
	fmul    $f2, $f1, $fg15
	jr      $ra1
bg.22048:
	mov     $f0, $fg15
	jr      $ra1
bne.22045:
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i19, $f14, $f15, $i20)
# $ra = $ra4
# [$i1 - $i22]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i19, 0, bl.22049
bge.22049:
	load    [ext_reflections + $i19], $i21
	load    [$i21 + 1], $i22
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.22050
be.22050:
	ble     $fg7, $fc7, bne.22061
.count dual_jmp
	b       bg.22058
bne.22050:
	bne     $i1, 99, bne.22051
be.22051:
	load    [$i14 + 1], $i1
	be      $i1, -1, ble.22057
bne.22052:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, ble.22057
bne.22053:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, ble.22057
bne.22054:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i22, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, ble.22057
bne.22055:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
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
	ble     $fg7, $fc7, bne.22061
.count dual_jmp
	b       bg.22058
bne.22051:
.count move_args
	mov     $i22, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22057
bne.22056:
	bg      $fg7, $fg0, bg.22057
ble.22057:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i22, $i18
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22061
.count dual_jmp
	b       bg.22058
bg.22057:
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
	ble     $fg7, $fc7, bne.22061
bg.22058:
	ble     $fc12, $fg7, bne.22061
bg.22059:
	li      1, $i1
	load    [$i21 + 0], $i1
	add     $ig3, $ig3, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, bne.22061
be.22061:
	li      0, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22061
be.22062:
	load    [$i21 + 2], $f1
	load    [$i22 + 0], $i1
	fmul    $f1, $f14, $f2
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
	bg      $f2, $f0, bg.22063
ble.22063:
	load    [$i20 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i20 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i20 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	ble     $f1, $f0, bne.22061
.count dual_jmp
	b       bg.22064
bg.22063:
	fmul    $f2, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f2, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f2, $fg15, $f2
	fadd    $fg6, $f2, $fg6
	load    [$i20 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i20 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i20 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	bg      $f1, $f0, bg.22064
bne.22061:
	add     $i19, -1, $i19
	b       trace_reflections.2915
bg.22064:
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f15, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	add     $i19, -1, $i19
	b       trace_reflections.2915
bl.22049:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i23, $f16, $i24, $i25, $f17)
# $ra = $ra5
# [$i1 - $i28]
# [$f1 - $f17]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i23, 4, bg.22065
ble.22065:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.22066
be.22066:
	load    [$i25 + 2], $i26
	ble     $fg7, $fc7, ble.22075
.count dual_jmp
	b       bg.22074
bne.22066:
	bne     $i1, 99, bne.22067
be.22067:
	load    [$i14 + 1], $i1
	be      $i1, -1, ble.22073
bne.22068:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, ble.22073
bne.22069:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, ble.22073
bne.22070:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i24, $i10
	jal     solve_each_element.2871, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, ble.22073
bne.22071:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
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
	load    [$i25 + 2], $i26
	ble     $fg7, $fc7, ble.22075
.count dual_jmp
	b       bg.22074
bne.22067:
.count move_args
	mov     $i24, $i2
	call    solver.2773
	be      $i1, 0, ble.22073
bne.22072:
	bg      $fg7, $fg0, bg.22073
ble.22073:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i24, $i18
	jal     trace_or_matrix.2879, $ra3
	load    [$i25 + 2], $i26
	ble     $fg7, $fc7, ble.22075
.count dual_jmp
	b       bg.22074
bg.22073:
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
	load    [$i25 + 2], $i26
	ble     $fg7, $fc7, ble.22075
bg.22074:
	bg      $fc12, $fg7, bg.22075
ble.22075:
	add     $i0, -1, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	be      $i23, 0, bg.22065
bne.22077:
	load    [$i24 + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [$i24 + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [$i24 + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	ble     $f1, $f0, bg.22065
bg.22078:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f16, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
bg.22075:
	li      1, $i1
	load    [ext_objects + $ig3], $i27
	load    [$i27 + 1], $i1
	bne     $i1, 1, bne.22079
be.22079:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i1
	load    [$i24 + $i1], $f1
	bne     $f1, $f0, bne.22080
be.22080:
	store   $f0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bne.22080:
	bg      $f1, $f0, bg.22081
ble.22081:
	store   $fc0, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bg.22081:
	store   $fc3, [ext_nvector + $i1]
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bne.22079:
	bne     $i1, 2, bne.22082
be.22082:
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
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bne.22082:
	load    [$i27 + 3], $i1
	load    [$i27 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i27 + 5], $i3
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
	bne     $i1, 0, bne.22083
be.22083:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i27 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22084
.count dual_jmp
	b       bne.22084
bne.22083:
	load    [$i27 + 9], $i1
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
	load    [$i27 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22084
be.22084:
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
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bne.22084:
	bne     $i1, 0, bne.22085
be.22085:
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
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	ble     $fc4, $f1, ble.22086
.count dual_jmp
	b       bg.22086
bne.22085:
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
	mov     $i27, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i26, $i23, $tmp
	store   $i1, [$tmp + 0]
	load    [$i25 + 1], $i1
	load    [$i1 + $i23], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i27 + 7], $i28
	load    [$i25 + 3], $i1
	load    [$i28 + 0], $f1
	fmul    $f1, $f16, $f14
	bg      $fc4, $f1, bg.22086
ble.22086:
	li      1, $i2
.count storer
	add     $i1, $i23, $tmp
	store   $i2, [$tmp + 0]
	load    [$i25 + 4], $i1
	load    [$i1 + $i23], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg15, [$i2 + 2]
	load    [$i1 + $i23], $i1
.count load_float
	load    [f.21544], $f1
.count load_float
	load    [f.21545], $f1
	fmul    $f1, $f14, $f1
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
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.21546], $f2
	load    [$i24 + 0], $f3
	fmul    $f3, $f1, $f4
	load    [$i24 + 1], $f5
	load    [ext_nvector + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    [$i24 + 2], $f5
	load    [ext_nvector + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i24 + 0]
	load    [$i24 + 1], $f1
	load    [ext_nvector + 1], $f3
	fmul    $f2, $f3, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i24 + 1]
	load    [$i24 + 2], $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i24 + 2]
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22087
.count dual_jmp
	b       bne.22087
bg.22086:
	li      0, $i2
.count storer
	add     $i1, $i23, $tmp
	store   $i2, [$tmp + 0]
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.21546], $f2
	load    [$i24 + 0], $f3
	fmul    $f3, $f1, $f4
	load    [$i24 + 1], $f5
	load    [ext_nvector + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    [$i24 + 2], $f5
	load    [ext_nvector + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i24 + 0]
	load    [$i24 + 1], $f1
	load    [ext_nvector + 1], $f3
	fmul    $f2, $f3, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i24 + 1]
	load    [$i24 + 2], $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i24 + 2]
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22087
be.22087:
	load    [$i28 + 1], $f1
	fmul    $f16, $f1, $f15
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f14, $f1
	load    [$i24 + 0], $f2
	fmul    $f2, $fg14, $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i24 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, ble.22103
.count dual_jmp
	b       bg.22103
bne.22087:
	be      $i1, 99, bne.22092
bne.22088:
	call    solver_fast.2796
	be      $i1, 0, be.22101
bne.22089:
	ble     $fc7, $fg0, be.22101
bg.22090:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22101
bne.22091:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22092
be.22092:
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22101
bne.22093:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22092
be.22094:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22101
bne.22092:
	li      1, $i1
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22101
bne.22097:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22098
be.22098:
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22101
bne.22099:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22098
be.22100:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22098
be.22101:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
	load    [$i28 + 1], $f1
	fmul    $f16, $f1, $f15
	bne     $i1, 0, bne.22102
be.22102:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f14, $f1
	load    [$i24 + 0], $f2
	fmul    $f2, $fg14, $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i24 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	bg      $f1, $f0, bg.22103
ble.22103:
	ble     $f2, $f0, bne.22102
.count dual_jmp
	b       bg.22104
bg.22103:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg15, $f1
	fadd    $fg6, $f1, $fg6
	bg      $f2, $f0, bg.22104
bne.22102:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_reflections.2915, $ra4
	ble     $f16, $fc9, bg.22065
.count dual_jmp
	b       bg.22105
bg.22104:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f15, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_reflections.2915, $ra4
	ble     $f16, $fc9, bg.22065
.count dual_jmp
	b       bg.22105
bne.22098:
	load    [$i28 + 1], $f1
	fmul    $f16, $f1, $f15
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	add     $ig4, -1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_reflections.2915, $ra4
	ble     $f16, $fc9, bg.22065
bg.22105:
	bl      $i23, 4, bl.22106
bge.22106:
	load    [$i27 + 2], $i1
	be      $i1, 2, be.22107
.count dual_jmp
	b       bg.22065
bl.22106:
	add     $i23, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i26, $i1, $tmp
	store   $i2, [$tmp + 0]
	load    [$i27 + 2], $i1
	bne     $i1, 2, bg.22065
be.22107:
	fadd    $f17, $fg7, $f17
	add     $i23, 1, $i23
	load    [$i28 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f16, $f1, $f16
	b       trace_ray.2920
bg.22065:
	jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i19, $f14)
# $ra = $ra4
# [$i1 - $i19]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, bne.22108
be.22108:
	ble     $fg7, $fc7, bne.22137
.count dual_jmp
	b       bg.22116
bne.22108:
	bne     $i1, 99, bne.22109
be.22109:
	load    [$i14 + 1], $i1
	be      $i1, -1, ble.22115
bne.22110:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 2], $i1
	be      $i1, -1, ble.22115
bne.22111:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 3], $i1
	be      $i1, -1, ble.22115
bne.22112:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
.count move_args
	mov     $i19, $i10
	jal     solve_each_element_fast.2885, $ra1
	load    [$i14 + 4], $i1
	be      $i1, -1, ble.22115
bne.22113:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
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
	ble     $fg7, $fc7, bne.22137
.count dual_jmp
	b       bg.22116
bne.22109:
.count move_args
	mov     $i19, $i2
	call    solver_fast2.2814
	be      $i1, 0, ble.22115
bne.22114:
	bg      $fg7, $fg0, bg.22115
ble.22115:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
.count move_args
	mov     $i19, $i18
	jal     trace_or_matrix_fast.2893, $ra3
	ble     $fg7, $fc7, bne.22137
.count dual_jmp
	b       bg.22116
bg.22115:
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
	ble     $fg7, $fc7, bne.22137
bg.22116:
	ble     $fc12, $fg7, bne.22137
bg.22117:
	li      1, $i1
	load    [$i19 + 0], $i1
	load    [ext_objects + $ig3], $i15
	load    [$i15 + 1], $i2
	bne     $i2, 1, bne.22119
be.22119:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	add     $ig2, -1, $i2
	load    [$i1 + $i2], $f1
.count move_args
	mov     $i15, $i1
	bne     $f1, $f0, bne.22120
be.22120:
	store   $f0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bne.22120:
	bg      $f1, $f0, bg.22121
ble.22121:
	store   $fc0, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bg.22121:
	store   $fc3, [ext_nvector + $i2]
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bne.22119:
	bne     $i2, 2, bne.22122
be.22122:
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
.count move_args
	mov     $i15, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bne.22122:
	load    [$i15 + 3], $i1
	load    [$i15 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i15 + 5], $i3
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
	bne     $i1, 0, bne.22123
be.22123:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
	load    [ext_nvector + 0], $f1
	load    [$i15 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	be      $f2, $f0, be.22124
.count dual_jmp
	b       bne.22124
bne.22123:
	load    [$i15 + 9], $i1
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
	load    [$i15 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, bne.22124
be.22124:
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
	mov     $i15, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bne.22124:
	bne     $i1, 0, bne.22125
be.22125:
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
	mov     $i15, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	be      $i1, -1, be.22126
.count dual_jmp
	b       bne.22126
bne.22125:
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
	mov     $i15, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i12
	load    [$i12 + 0], $i1
	bne     $i1, -1, bne.22126
be.22126:
	li      0, $i1
	load    [$i15 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	ble     $f1, $f0, ble.22142
.count dual_jmp
	b       bg.22142
bne.22126:
	be      $i1, 99, bne.22131
bne.22127:
	call    solver_fast.2796
	be      $i1, 0, be.22140
bne.22128:
	ble     $fc7, $fg0, be.22140
bg.22129:
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22140
bne.22130:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22131
be.22131:
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22140
bne.22132:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22131
be.22133:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	be      $i1, 0, be.22140
bne.22131:
	li      1, $i1
	load    [$i12 + 1], $i1
	be      $i1, -1, be.22140
bne.22136:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22137
be.22137:
	load    [$i12 + 2], $i1
	be      $i1, -1, be.22140
bne.22138:
	li      0, $i8
	load    [ext_and_net + $i1], $i9
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, bne.22137
be.22139:
	li      3, $i10
.count move_args
	mov     $i12, $i11
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, bne.22137
be.22140:
	li      1, $i12
.count move_args
	mov     $ig1, $i13
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, bne.22137
be.22141:
	load    [$i15 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, bg.22142
ble.22142:
	mov     $f0, $f1
	fmul    $f14, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bg.22142:
	fmul    $f14, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
bne.22137:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i20, $i21, $i22)
# $ra = $ra5
# [$i1 - $i22]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i22, 0, bl.22143
bge.22143:
	load    [$i20 + $i22], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22144
ble.22144:
	fmul    $f1, $fc1, $f14
	load    [$i20 + $i22], $i19
	jal     trace_diffuse_ray.2926, $ra4
	add     $i22, -2, $i22
	bge     $i22, 0, bge.22147
.count dual_jmp
	b       bl.22143
bg.22144:
	fmul    $f1, $fc2, $f14
	add     $i22, 1, $i1
	load    [$i20 + $i1], $i19
	jal     trace_diffuse_ray.2926, $ra4
	add     $i22, -2, $i22
	bl      $i22, 0, bl.22143
bge.22147:
	load    [$i20 + $i22], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22148
ble.22148:
	fmul    $f1, $fc1, $f14
	load    [$i20 + $i22], $i19
	jal     trace_diffuse_ray.2926, $ra4
	add     $i22, -2, $i22
	b       iter_trace_diffuse_rays.2929
bg.22148:
	fmul    $f1, $fc2, $f14
	add     $i22, 1, $i1
	load    [$i20 + $i1], $i19
	jal     trace_diffuse_ray.2926, $ra4
	add     $i22, -2, $i22
	b       iter_trace_diffuse_rays.2929
bl.22143:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i23, $i24)
# $ra = $ra6
# [$i1 - $i27]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	load    [$i23 + 5], $i1
	load    [$i1 + $i24], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i23 + 7], $i1
	load    [$i23 + 1], $i2
	load    [$i23 + 6], $i3
	load    [$i1 + $i24], $i25
	load    [$i2 + $i24], $i26
	load    [$i3 + 0], $i27
	bne     $i27, 0, bne.22149
be.22149:
	be      $i27, 1, be.22151
.count dual_jmp
	b       bne.22151
bne.22149:
	load    [ext_dirvecs + 0], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22150
ble.22150:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i27, 1, be.22151
.count dual_jmp
	b       bne.22151
bg.22150:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i27, 1, bne.22151
be.22151:
	be      $i27, 2, be.22153
.count dual_jmp
	b       bne.22153
bne.22151:
	load    [ext_dirvecs + 1], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22152
ble.22152:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i27, 2, be.22153
.count dual_jmp
	b       bne.22153
bg.22152:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i27, 2, bne.22153
be.22153:
	be      $i27, 3, be.22155
.count dual_jmp
	b       bne.22155
bne.22153:
	load    [ext_dirvecs + 2], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22154
ble.22154:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i27, 3, be.22155
.count dual_jmp
	b       bne.22155
bg.22154:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i27, 3, bne.22155
be.22155:
	be      $i27, 4, be.22157
.count dual_jmp
	b       bne.22157
bne.22155:
	load    [ext_dirvecs + 3], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22156
ble.22156:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i27, 4, be.22157
.count dual_jmp
	b       bne.22157
bg.22156:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i27, 4, bne.22157
be.22157:
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
bne.22157:
	load    [ext_dirvecs + 4], $i20
	load    [$i26 + 0], $fg8
	load    [$i26 + 1], $fg9
	load    [$i26 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i26, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22158
ble.22158:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
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
bg.22158:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i25, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
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
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i23, 4, bg.22159
ble.22159:
	load    [$i28 + 2], $i24
	load    [$i24 + $i23], $i1
	bl      $i1, 0, bg.22159
bge.22160:
	load    [$i28 + 3], $i25
	load    [$i25 + $i23], $i1
	bne     $i1, 0, bne.22161
be.22161:
	add     $i23, 1, $i29
	ble     $i29, 4, ble.22175
.count dual_jmp
	b       bg.22159
bne.22161:
	load    [$i28 + 5], $i1
	load    [$i1 + $i23], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i28 + 7], $i1
	load    [$i28 + 1], $i2
	load    [$i28 + 6], $i3
	load    [$i1 + $i23], $i26
	load    [$i2 + $i23], $i27
	load    [$i3 + 0], $i29
	bne     $i29, 0, bne.22165
be.22165:
	be      $i29, 1, be.22167
.count dual_jmp
	b       bne.22167
bne.22165:
	load    [ext_dirvecs + 0], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22166
ble.22166:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i29, 1, be.22167
.count dual_jmp
	b       bne.22167
bg.22166:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i29, 1, bne.22167
be.22167:
	be      $i29, 2, be.22169
.count dual_jmp
	b       bne.22169
bne.22167:
	load    [ext_dirvecs + 1], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22168
ble.22168:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i29, 2, be.22169
.count dual_jmp
	b       bne.22169
bg.22168:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i29, 2, bne.22169
be.22169:
	be      $i29, 3, be.22171
.count dual_jmp
	b       bne.22171
bne.22169:
	load    [ext_dirvecs + 2], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22170
ble.22170:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i29, 3, be.22171
.count dual_jmp
	b       bne.22171
bg.22170:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i29, 3, bne.22171
be.22171:
	be      $i29, 4, be.22173
.count dual_jmp
	b       bne.22173
bne.22171:
	load    [ext_dirvecs + 3], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22172
ble.22172:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	be      $i29, 4, be.22173
.count dual_jmp
	b       bne.22173
bg.22172:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
	bne     $i29, 4, bne.22173
be.22173:
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
	ble     $i29, 4, ble.22175
.count dual_jmp
	b       bg.22159
bne.22173:
	load    [ext_dirvecs + 4], $i20
	load    [$i27 + 0], $fg8
	load    [$i27 + 1], $fg9
	load    [$i27 + 2], $fg10
	add     $ig0, -1, $i1
.count move_args
	mov     $i27, $i2
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22174
ble.22174:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
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
	ble     $i29, 4, ble.22175
.count dual_jmp
	b       bg.22159
bg.22174:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
.count move_args
	mov     $i26, $i21
	jal     iter_trace_diffuse_rays.2929, $ra5
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
	bg      $i29, 4, bg.22159
ble.22175:
	load    [$i24 + $i29], $i1
	bl      $i1, 0, bg.22159
bge.22176:
	load    [$i25 + $i29], $i1
	bne     $i1, 0, bne.22177
be.22177:
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
bne.22177:
.count move_args
	mov     $i28, $i23
.count move_args
	mov     $i29, $i24
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i29, 1, $i23
	b       do_without_neighbors.2951
bg.22159:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i28)
# $ra = $ra7
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i28, 4, bg.22178
ble.22178:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i28], $i6
	bl      $i6, 0, bg.22178
bge.22179:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, bne.22180
be.22180:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, bne.22180
be.22181:
	add     $i2, -1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, bne.22180
be.22182:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i28], $i8
	bne     $i8, $i6, bne.22180
be.22183:
	load    [$i1 + 3], $i1
	load    [$i1 + $i28], $i1
	bne     $i1, 0, bne.22188
be.22188:
	add     $i28, 1, $i28
	b       try_exploit_neighbors.2967
bne.22188:
	load    [$i7 + 5], $i1
	load    [$i1 + $i28], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i2, -1, $i1
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
bne.22180:
	bg      $i28, 4, bg.22178
ble.22185:
	load    [$i4 + $i2], $i29
	load    [$i29 + 2], $i1
	load    [$i1 + $i28], $i1
	bl      $i1, 0, bg.22178
bge.22186:
	load    [$i29 + 3], $i1
	load    [$i1 + $i28], $i1
	bne     $i1, 0, bne.22187
be.22187:
	add     $i28, 1, $i23
.count move_args
	mov     $i29, $i28
	b       do_without_neighbors.2951
bne.22187:
.count move_args
	mov     $i29, $i23
.count move_args
	mov     $i28, $i24
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i28, 1, $i23
.count move_args
	mov     $i29, $i28
	b       do_without_neighbors.2951
bg.22178:
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
	add     $sp, -1, $sp
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
	bg      $i1, $i4, bg.22193
ble.22193:
	bl      $i1, 0, bl.22194
bge.22194:
.count move_args
	mov     $i1, $i2
	b       ext_write
bl.22194:
	li      0, $i2
	b       ext_write
bg.22193:
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
# pretrace_diffuse_rays($i23, $i24)
# $ra = $ra6
# [$i1 - $i30]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i24, 4, bg.22197
ble.22197:
	load    [$i23 + 2], $i25
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bg.22197
bge.22198:
	load    [$i23 + 3], $i26
	load    [$i26 + $i24], $i1
	bne     $i1, 0, bne.22199
be.22199:
	add     $i24, 1, $i24
	bg      $i24, 4, bg.22197
ble.22200:
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bg.22197
bge.22201:
	load    [$i26 + $i24], $i1
	be      $i1, 0, be.22207
bne.22202:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i23 + 6], $i8
	load    [$i23 + 7], $i9
	load    [$i23 + 1], $i1
	load    [$i1 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i8 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i9 + $i24], $i21
	load    [$i1 + 0], $f1
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22203
ble.22203:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i1
	load    [$i1 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bg.22203:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i1
	load    [$i1 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bne.22199:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i23 + 6], $i27
	load    [$i23 + 7], $i28
	load    [$i23 + 1], $i29
	load    [$i29 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i27 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + $i24], $i21
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22204
ble.22204:
	load    [$i20 + 118], $i19
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i30
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	ble     $i24, 4, ble.22205
.count dual_jmp
	b       bg.22197
bg.22204:
	load    [$i20 + 119], $i19
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i30
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	bg      $i24, 4, bg.22197
ble.22205:
	load    [$i25 + $i24], $i1
	bl      $i1, 0, bg.22197
bge.22206:
	load    [$i26 + $i24], $i1
	bne     $i1, 0, bne.22207
be.22207:
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bne.22207:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i29 + $i24], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i27 + 0], $i1
	load    [ext_dirvecs + $i1], $i20
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i28 + $i24], $i21
	load    [$i1 + 0], $f1
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22208
ble.22208:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bg.22208:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i30 + $i24], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i24, 1, $i24
	b       pretrace_diffuse_rays.2980
bg.22197:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i31, $i32, $i33, $f18, $f1, $f2)
# $ra = $ra7
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i32, 0, bl.22209
bge.22209:
.count stack_move
	add     $sp, -2, $sp
.count stack_store
	store   $f2, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 1]
	add     $i32, -64, $i2
	call    ext_float_of_int
	load    [ext_screenx_dir + 0], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $f18, $f2
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
	mov     $f0, $f17
.count move_args
	mov     $fc0, $f16
	li      0, $i23
	li      ext_ptrace_dirvec, $i24
	mov     $f0, $fg6
	mov     $f0, $fg5
	mov     $f0, $fg4
	bne     $f2, $f0, bne.22211
be.22211:
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
	load    [$i31 + $i32], $i25
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
	bge     $i1, 0, bge.22212
.count dual_jmp
	b       bl.22212
bne.22211:
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
	load    [$i31 + $i32], $i25
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
	bl      $i1, 0, bl.22212
bge.22212:
	load    [$i23 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22213
be.22213:
	li      1, $i24
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 2, $sp
	add     $i32, -1, $i32
	add     $i33, 1, $i33
	bge     $i33, 5, bge.22216
.count dual_jmp
	b       bl.22216
bne.22213:
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
	add     $ig0, -1, $i1
	call    setup_startp_constants.2831
	load    [$i20 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i21 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i21 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i21 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, bg.22214
ble.22214:
	fmul    $f1, $fc1, $f14
	load    [$i20 + 118], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i24
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 2, $sp
	add     $i32, -1, $i32
	add     $i33, 1, $i33
	bge     $i33, 5, bge.22216
.count dual_jmp
	b       bl.22216
bg.22214:
	fmul    $f1, $fc2, $f14
	load    [$i20 + 119], $i19
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i22
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i23 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i24
	jal     pretrace_diffuse_rays.2980, $ra6
.count stack_move
	add     $sp, 2, $sp
	add     $i32, -1, $i32
	add     $i33, 1, $i33
	bge     $i33, 5, bge.22216
.count dual_jmp
	b       bl.22216
bl.22212:
.count stack_move
	add     $sp, 2, $sp
	add     $i32, -1, $i32
	add     $i33, 1, $i33
	bl      $i33, 5, bl.22216
bge.22216:
	add     $i33, -5, $i33
.count stack_load
	load    [$sp - 2], $f2
.count move_args
	mov     $i34, $f1
	b       pretrace_pixels.2983
bl.22216:
.count stack_load
	load    [$sp - 2], $f2
.count move_args
	mov     $i34, $f1
	b       pretrace_pixels.2983
bl.22209:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i30, $i31, $i32, $i33, $i34)
# $ra = $ra8
# [$i1 - $i34]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i30, bg.22217
ble.22217:
	jr      $ra8
bg.22217:
	load    [$i33 + $i30], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i31, 1, $i2
	ble     $i1, $i2, ble.22221
bg.22218:
	ble     $i31, 0, ble.22221
bg.22219:
	li      128, $i1
	add     $i30, 1, $i2
	ble     $i1, $i2, ble.22221
bg.22220:
	bg      $i30, 0, bg.22221
ble.22221:
	li      0, $i1
	load    [$i33 + $i30], $i28
	li      0, $i24
	load    [$i28 + 2], $i1
	load    [$i1 + 0], $i1
	bge     $i1, 0, bge.22231
.count dual_jmp
	b       bl.22225
bg.22221:
	li      1, $i1
	li      0, $i24
	load    [$i33 + $i30], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bl.22225
bge.22225:
	load    [$i32 + $i30], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22226
be.22226:
	load    [$i34 + $i30], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22226
be.22227:
	add     $i30, -1, $i4
	load    [$i33 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22226
be.22228:
	add     $i30, 1, $i4
	load    [$i33 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, bne.22226
be.22229:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i34, $i5
.count move_args
	mov     $i33, $i4
.count move_args
	mov     $i30, $i2
	li      1, $i28
	bne     $i1, 0, bne.22233
be.22233:
.count move_args
	mov     $i32, $i3
	jal     try_exploit_neighbors.2967, $ra7
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
bne.22233:
	load    [$i3 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	add     $i30, -1, $i1
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
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
bne.22226:
	load    [$i33 + $i30], $i28
	load    [$i28 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bl.22225
bge.22231:
	load    [$i28 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, bne.22232
be.22232:
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
bne.22232:
.count move_args
	mov     $i28, $i23
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i23
	jal     do_without_neighbors.2951, $ra7
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
bl.22225:
	call    write_rgb.2978
	add     $i30, 1, $i30
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i35, $i36, $i37, $i38, $i39)
# $ra = $ra9
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i35, bg.22234
ble.22234:
	jr      $ra9
bg.22234:
	bl      $i35, 127, bl.22235
bge.22235:
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
	add     $i35, 1, $i35
	add     $i39, 2, $i39
	bge     $i39, 5, bge.22236
.count dual_jmp
	b       bl.22236
bl.22235:
	add     $i35, 1, $i1
	add     $i1, -64, $i2
	call    ext_float_of_int
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f18
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f3
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f2
	li      127, $i32
.count move_args
	mov     $i38, $i31
.count move_args
	mov     $i39, $i33
.count move_args
	mov     $f3, $f1
	jal     pretrace_pixels.2983, $ra7
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
	add     $i35, 1, $i35
	add     $i39, 2, $i39
	bl      $i39, 5, bl.22236
bge.22236:
	add     $i39, -5, $i39
.count move_args
	mov     $i36, $tmp
.count move_args
	mov     $i37, $i36
.count move_args
	mov     $i38, $i37
.count move_args
	mov     $tmp, $i38
	b       scan_line.3000
bl.22236:
.count move_args
	mov     $i36, $tmp
.count move_args
	mov     $i37, $i36
.count move_args
	mov     $i38, $i37
.count move_args
	mov     $tmp, $i38
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
# [$i1 - $i13]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i13, 0, bl.22237
bge.22237:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	add     $i13, -1, $i13
	b       init_line_elements.3010
bl.22237:
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
	bl      $i1, 5, bl.22238
bge.22238:
	load    [ext_dirvecs + $i3], $i1
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
bl.22238:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc9, $f1
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
	fadd    $f1, $fc9, $f1
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
	finv    $f1, $f1
	fmul    $f13, $f1, $f1
	fmul    $f1, $f12, $f2
	add     $i1, 1, $i1
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
	bl      $i5, 0, bl.22239
bge.22239:
	li      0, $i1
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
.count load_float
	load    [f.21560], $f15
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
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
	li      0, $i1
	add     $i7, 2, $i8
	fadd    $f16, $fc9, $f9
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
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22239
bge.22240:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22241
bge.22241:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
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
	li      0, $i1
	fadd    $f16, $fc9, $f9
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
	add     $i5, -1, $i5
	bge     $i5, 0, bge.22242
.count dual_jmp
	b       bl.22239
bl.22241:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
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
	li      0, $i1
	fadd    $f16, $fc9, $f9
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
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22239
bge.22242:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22243
bge.22243:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
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
	li      0, $i1
	fadd    $f16, $fc9, $f9
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
	add     $i5, -1, $i5
	bge     $i5, 0, bge.22244
.count dual_jmp
	b       bl.22239
bl.22243:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
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
	li      0, $i1
	fadd    $f16, $fc9, $f9
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
	add     $i5, -1, $i5
	bl      $i5, 0, bl.22239
bge.22244:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22245
bge.22245:
	add     $i2, -5, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
	fsub    $f15, $fc11, $f9
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
	li      0, $i1
	fadd    $f15, $fc9, $f9
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
	add     $i5, -1, $i5
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
.count dual_jmp
	b       bge.22246
bl.22245:
	mov     $i2, $i6
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
	fsub    $f15, $fc11, $f9
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
	li      0, $i1
	fadd    $f15, $fc9, $f9
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
	add     $i5, -1, $i5
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
bge.22246:
	add     $i6, -5, $i6
	b       calc_dirvecs.3028
bl.22239:
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
	bl      $i9, 0, bl.22247
bge.22247:
	li      0, $i1
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
.count load_float
	load    [f.21560], $f17
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
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
	li      0, $i1
	add     $i11, 2, $i5
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
	li      0, $i1
	add     $i10, 1, $i2
.count move_args
	mov     $i11, $i4
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $fc18, $f9
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f1
	bl      $i2, 5, bl.22248
bge.22248:
	add     $i2, -5, $i6
.count move_args
	mov     $i6, $i3
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
	li      0, $i1
	add     $i6, 1, $i2
	bge     $i2, 5, bge.22249
.count dual_jmp
	b       bl.22249
bl.22248:
	mov     $i2, $i6
.count move_args
	mov     $i6, $i3
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
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bl.22249
bge.22249:
	add     $i2, -5, $i6
.count load_float
	load    [f.21565], $f9
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
	li      1, $i5
	add     $i6, 1, $i1
	bge     $i1, 5, bge.22250
.count dual_jmp
	b       bl.22250
bl.22249:
	mov     $i2, $i6
.count load_float
	load    [f.21565], $f9
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
	li      1, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bl.22250
bge.22250:
	add     $i1, -5, $i6
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bge     $i9, 0, bge.22251
.count dual_jmp
	b       bl.22247
bl.22250:
	mov     $i1, $i6
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	bl      $i9, 0, bl.22247
bge.22251:
	add     $i10, 2, $i1
.count move_args
	mov     $i9, $i2
	add     $i11, 4, $i11
	bl      $i1, 5, bl.22252
bge.22252:
	add     $i1, -5, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
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
	li      0, $i1
	add     $i11, 2, $i5
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
	li      0, $i1
	add     $i10, 1, $i2
	bge     $i2, 5, bge.22253
.count dual_jmp
	b       bl.22253
bl.22252:
	mov     $i1, $i10
	li      0, $i1
	call    ext_float_of_int
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
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
	li      0, $i1
	add     $i11, 2, $i5
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
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bl.22253
bge.22253:
	add     $i2, -5, $i6
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
	li      2, $i5
	add     $i6, 1, $i1
	bge     $i1, 5, bge.22254
.count dual_jmp
	b       bl.22254
bl.22253:
	mov     $i2, $i6
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
	li      2, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bl.22254
bge.22254:
	add     $i1, -5, $i6
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bge     $i10, 5, bge.22255
.count dual_jmp
	b       bl.22255
bl.22254:
	mov     $i1, $i6
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	add     $i9, -1, $i9
	add     $i10, 2, $i10
	bl      $i10, 5, bl.22255
bge.22255:
	add     $i10, -5, $i10
	add     $i11, 4, $i11
	b       calc_dirvec_rows.3033
bl.22255:
	add     $i11, 4, $i11
	b       calc_dirvec_rows.3033
bl.22247:
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
	bl      $i6, 0, bl.22256
bge.22256:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
	add     $i6, -1, $i6
	b       create_dirvec_elements.3039
bl.22256:
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
	bl      $i7, 0, bl.22257
bge.22257:
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
bl.22257:
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
	bl      $i11, 0, bl.22258
bge.22258:
	load    [$i10 + $i11], $i7
	jal     setup_dirvec_constants.2829, $ra2
	add     $i11, -1, $i11
	b       init_dirvec_constants.3044
bl.22258:
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
	bl      $i12, 0, bl.22259
bge.22259:
	load    [ext_dirvecs + $i12], $i10
	li      119, $i11
	jal     init_dirvec_constants.3044, $ra3
	add     $i12, -1, $i12
	b       init_vecset_constants.3047
bl.22259:
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
	li      0, $i5
	li      0, $i7
	li      0, $i1
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
	li      0, $i1
	li      2, $i6
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
	li      0, $i1
	li      1, $i5
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
	li      2, $i5
	li      2, $i6
.count move_args
	mov     $fc11, $f14
	jal     calc_dirvecs.3028, $ra2
	li      8, $i9
	li      2, $i10
	li      4, $i11
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
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_rect_reflection
setup_rect_reflection.3058:
	load    [$i2 + 7], $i2
	add     $i1, $i1, $i1
	add     $i1, $i1, $i13
	add     $i13, 1, $i11
	load    [$i2 + 0], $f1
	fsub    $fc0, $f1, $f10
	fneg    $fg12, $f11
	fneg    $fg13, $f12
.count move_args
	mov     $ig4, $i10
.count move_args
	mov     $f10, $f9
.count move_args
	mov     $fg14, $f1
.count move_args
	mov     $f11, $f3
.count move_args
	mov     $f12, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $i10
	add     $i13, 2, $i11
	fneg    $fg14, $f13
.count move_args
	mov     $f10, $f9
.count move_args
	mov     $f13, $f1
.count move_args
	mov     $fg12, $f3
.count move_args
	mov     $f12, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 2, $i10
	add     $i13, 3, $i11
.count move_args
	mov     $f10, $f9
.count move_args
	mov     $f13, $f1
.count move_args
	mov     $f11, $f3
.count move_args
	mov     $fg13, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 3, $ig4
	jr      $ra4
.end setup_rect_reflection

######################################################################
# setup_surface_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f9]
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_surface_reflection
setup_surface_reflection.3061:
	load    [$i2 + 4], $i3
	load    [$i2 + 7], $i2
	load    [$i3 + 0], $f1
	fmul    $fc10, $f1, $f2
	fmul    $fg14, $f1, $f1
	load    [$i3 + 1], $f3
	fmul    $fg12, $f3, $f4
	fadd    $f1, $f4, $f1
	load    [$i3 + 2], $f4
	fmul    $fg13, $f4, $f5
	fadd    $f1, $f5, $f1
	fmul    $f2, $f1, $f2
	fsub    $f2, $fg14, $f2
	fmul    $fc10, $f3, $f3
	fmul    $f3, $f1, $f3
	fsub    $f3, $fg12, $f3
	fmul    $fc10, $f4, $f4
	fmul    $f4, $f1, $f1
	fsub    $f1, $fg13, $f4
	load    [$i2 + 0], $f1
	fsub    $fc0, $f1, $f9
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i11
.count move_args
	mov     $ig4, $i10
.count move_args
	mov     $f2, $f1
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $ig4
	jr      $ra4
.end setup_surface_reflection

######################################################################
# setup_reflections($i1)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i1, 0, bl.22260
bge.22260:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, bl.22260
be.22261:
	load    [$i2 + 7], $i3
	load    [$i3 + 0], $f1
	ble     $fc0, $f1, bl.22260
bg.22262:
	load    [$i2 + 1], $i3
	be      $i3, 1, setup_rect_reflection.3058
bne.22263:
	be      $i3, 2, setup_surface_reflection.3061
bl.22260:
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
	store   $fg14, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	add     $ig0, -1, $i1
	jal     setup_reflections.3064, $ra4
	li      0, $i33
	li      127, $i32
.count load_float
	load    [f.21573], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f18
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f3
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f2
.count move_args
	mov     $i37, $i31
.count move_args
	mov     $f3, $f1
	jal     pretrace_pixels.2983, $ra7
	li      0, $i35
	li      2, $i39
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
	load    [f.21523 + 0], $fc0
	load    [f.21548 + 0], $fc1
	load    [f.21547 + 0], $fc2
	load    [f.21522 + 0], $fc3
	load    [f.21524 + 0], $fc4
	load    [f.21550 + 0], $fc5
	load    [f.21549 + 0], $fc6
	load    [f.21527 + 0], $fc7
	load    [f.21537 + 0], $fc8
	load    [f.21536 + 0], $fc9
	load    [f.21521 + 0], $fc10
	load    [f.21561 + 0], $fc11
	load    [f.21543 + 0], $fc12
	load    [f.21542 + 0], $fc13
	load    [f.21531 + 0], $fc14
	load    [f.21526 + 0], $fc15
	load    [f.21505 + 0], $fc16
	load    [f.21564 + 0], $fc17
	load    [f.21563 + 0], $fc18
	load    [f.21562 + 0], $fc19
	jal     rt.3066, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret     
.end main
