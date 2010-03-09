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
.define { store_inst %iReg, [%iReg + %Imm] } { store_inst %2 %3 %1 }
.define { load [%iReg + %Imm], %fReg } { fload %1 %2 %3 }
.define { load [%iReg + %iReg], %fReg } { floadr %1 %2 %3 }
.define { store %fReg, [%iReg + %Imm] } { fstore %2 %3 %1 }
.define { mov %iReg, %fReg } { imovf %1 %2 }
.define { mov %fReg, %iReg } { fmovi %1 %2 }
.define { write %iReg, %iReg } { write %1 %2 }

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
f.21564:	.float  1.2800000000E+02
f.21556:	.float  9.0000000000E-01
f.21555:	.float  2.0000000000E-01
f.21545:	.float  1.5000000000E+02
f.21544:	.float  -1.5000000000E+02
f.21543:	.float  6.6666666667E-03
f.21542:	.float  -6.6666666667E-03
f.21541:	.float  -2.0000000000E+00
f.21540:	.float  3.9062500000E-03
f.21539:	.float  2.5600000000E+02
f.21538:	.float  1.0000000000E+08
f.21537:	.float  1.0000000000E+09
f.21536:	.float  1.0000000000E+01
f.21535:	.float  2.0000000000E+01
f.21534:	.float  5.0000000000E-02
f.21533:	.float  2.5000000000E-01
f.21532:	.float  1.0000000000E-01
f.21531:	.float  3.3333333333E+00
f.21530:	.float  2.5500000000E+02
f.21529:	.float  1.5000000000E-01
f.21528:	.float  3.1830988148E-01
f.21527:	.float  3.1415927000E+00
f.21526:	.float  3.0000000000E+01
f.21525:	.float  1.5000000000E+01
f.21524:	.float  1.0000000000E-04
f.21523:	.float  -1.0000000000E-01
f.21522:	.float  1.0000000000E-02
f.21521:	.float  -2.0000000000E-01
f.21520:	.float  5.0000000000E-01
f.21519:	.float  1.0000000000E+00
f.21518:	.float  -1.0000000000E+00
f.21517:	.float  2.0000000000E+00
f.21503:	.float  -2.0000000000E+02
f.21502:	.float  2.0000000000E+02
f.21501:	.float  1.7453293000E-02

######################################################################
# read_screen_settings()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f11]
# []
# [$fg21 - $fg24]
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
	fmul    $f1, $fc17, $f9
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
	fmul    $f1, $fc17, $f11
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
	load    [f.21502], $f3
	fmul    $f2, $f3, $fg21
.count load_float
	load    [f.21503], $f2
	fmul    $f9, $f2, $fg22
	fmul    $f10, $f8, $f2
	fmul    $f2, $f3, $fg23
	store   $f8, [ext_screenx_dir + 0]
	fneg    $f1, $f2
	store   $f2, [ext_screenx_dir + 2]
	fneg    $f9, $f2
	fmul    $f2, $f1, $fg24
	fneg    $f10, $f1
	store   $f1, [ext_screeny_dir + 1]
	fmul    $f2, $f8, $f1
	store   $f1, [ext_screeny_dir + 2]
	load    [ext_screen + 0], $f1
	fsub    $f1, $fg21, $f1
	store   $f1, [ext_viewpoint + 0]
	load    [ext_screen + 1], $f1
	fsub    $f1, $fg22, $f1
	store   $f1, [ext_viewpoint + 1]
	load    [ext_screen + 2], $f1
	fsub    $f1, $fg23, $f1
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
######################################################################
.begin read_light
read_light.2714:
	call    ext_read_int
	call    ext_read_float
	fmul    $f1, $fc17, $f8
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
	fmul    $f9, $fc17, $f8
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
######################################################################
.begin read_nth_object
read_nth_object.2719:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	bne     $i7, -1, be_else.21683
be_then.21683:
	li      0, $i1
	jr      $ra1
be_else.21683:
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
	be      $i10, 0, bne_cont.21684
bne_then.21684:
	call    ext_read_float
	fmul    $f1, $fc17, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $fc17, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $fc17, $f1
	store   $f1, [$i15 + 2]
bne_cont.21684:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	bg      $f0, $f3, ble_else.21685
ble_then.21685:
	li      0, $i2
.count b_cont
	b       ble_cont.21685
ble_else.21685:
	li      1, $i2
ble_cont.21685:
	bne     $i8, 2, be_else.21686
be_then.21686:
	li      1, $i3
.count b_cont
	b       be_cont.21686
be_else.21686:
	mov     $i2, $i3
be_cont.21686:
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
	bne     $i8, 3, be_else.21687
be_then.21687:
	load    [$i11 + 0], $f1
	bne     $f1, $f0, be_else.21688
be_then.21688:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21688
be_else.21688:
	bne     $f1, $f0, be_else.21689
be_then.21689:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21689
be_else.21689:
	bg      $f1, $f0, ble_else.21690
ble_then.21690:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21690
ble_else.21690:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21690:
be_cont.21689:
be_cont.21688:
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	bne     $f1, $f0, be_else.21691
be_then.21691:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21691
be_else.21691:
	bne     $f1, $f0, be_else.21692
be_then.21692:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21692
be_else.21692:
	bg      $f1, $f0, ble_else.21693
ble_then.21693:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21693
ble_else.21693:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21693:
be_cont.21692:
be_cont.21691:
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	bne     $f1, $f0, be_else.21694
be_then.21694:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21694
be_else.21694:
	bne     $f1, $f0, be_else.21695
be_then.21695:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21695
be_else.21695:
	bg      $f1, $f0, ble_else.21696
ble_then.21696:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21696
ble_else.21696:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21696:
be_cont.21695:
be_cont.21694:
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21697
be_then.21697:
	li      1, $i1
	jr      $ra1
be_else.21697:
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
be_else.21687:
	bne     $i8, 2, be_else.21698
be_then.21698:
	load    [$i11 + 0], $f1
	bne     $i2, 0, be_else.21699
be_then.21699:
	li      1, $i1
.count b_cont
	b       be_cont.21699
be_else.21699:
	li      0, $i1
be_cont.21699:
	fmul    $f1, $f1, $f2
	load    [$i11 + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [$i11 + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, be_else.21700
be_then.21700:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.21700
be_else.21700:
	bne     $i1, 0, be_else.21701
be_then.21701:
	finv    $f2, $f2
.count b_cont
	b       be_cont.21701
be_else.21701:
	finv_n  $f2, $f2
be_cont.21701:
be_cont.21700:
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21702
be_then.21702:
	li      1, $i1
	jr      $ra1
be_else.21702:
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
be_else.21698:
	bne     $i10, 0, be_else.21703
be_then.21703:
	li      1, $i1
	jr      $ra1
be_else.21703:
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
######################################################################
.begin read_object
read_object.2721:
	bl      $i16, 60, bge_else.21704
bge_then.21704:
	jr      $ra2
bge_else.21704:
.count move_args
	mov     $i16, $i6
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, be_else.21705
be_then.21705:
	mov     $i16, $ig0
	jr      $ra2
be_else.21705:
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
	bne     $i1, -1, be_else.21706
be_then.21706:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
be_else.21706:
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
	bne     $i2, -1, be_else.21707
be_then.21707:
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
be_else.21707:
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
######################################################################
.begin read_and_network
read_and_network.2729:
	li      0, $i1
	call    read_net_item.2725
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.21708
be_then.21708:
	jr      $ra1
be_else.21708:
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
# [$fg12 - $fg14, $fg21 - $fg24]
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
# [$i1 - $i7]
# [$f1 - $f13]
# []
# [$fg0]
######################################################################
.begin solver
solver.2773:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 1], $i6
	load    [$i3 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i5 + 2], $f3
	fsub    $fg17, $f1, $f1
	fsub    $fg18, $f2, $f2
	fsub    $fg19, $f3, $f3
	load    [$i2 + 0], $f4
	bne     $i6, 1, be_else.21709
be_then.21709:
	bne     $f4, $f0, be_else.21710
be_then.21710:
	li      0, $i3
.count b_cont
	b       be_cont.21710
be_else.21710:
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.21711
ble_then.21711:
	li      0, $i5
.count b_cont
	b       ble_cont.21711
ble_else.21711:
	li      1, $i5
ble_cont.21711:
	bne     $i4, 0, be_else.21712
be_then.21712:
	mov     $i5, $i4
.count b_cont
	b       be_cont.21712
be_else.21712:
	bne     $i5, 0, be_else.21713
be_then.21713:
	li      1, $i4
.count b_cont
	b       be_cont.21713
be_else.21713:
	li      0, $i4
be_cont.21713:
be_cont.21712:
	load    [$i3 + 0], $f7
	bne     $i4, 0, be_cont.21714
be_then.21714:
	fneg    $f7, $f7
be_cont.21714:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.21715
ble_then.21715:
	li      0, $i3
.count b_cont
	b       ble_cont.21715
ble_else.21715:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.21716
ble_then.21716:
	li      0, $i3
.count b_cont
	b       ble_cont.21716
ble_else.21716:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21716:
ble_cont.21715:
be_cont.21710:
	bne     $i3, 0, be_else.21717
be_then.21717:
	load    [$i2 + 1], $f4
	bne     $f4, $f0, be_else.21718
be_then.21718:
	li      0, $i3
.count b_cont
	b       be_cont.21718
be_else.21718:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.21719
ble_then.21719:
	li      0, $i5
.count b_cont
	b       ble_cont.21719
ble_else.21719:
	li      1, $i5
ble_cont.21719:
	bne     $i4, 0, be_else.21720
be_then.21720:
	mov     $i5, $i4
.count b_cont
	b       be_cont.21720
be_else.21720:
	bne     $i5, 0, be_else.21721
be_then.21721:
	li      1, $i4
.count b_cont
	b       be_cont.21721
be_else.21721:
	li      0, $i4
be_cont.21721:
be_cont.21720:
	load    [$i3 + 1], $f7
	bne     $i4, 0, be_cont.21722
be_then.21722:
	fneg    $f7, $f7
be_cont.21722:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.21723
ble_then.21723:
	li      0, $i3
.count b_cont
	b       ble_cont.21723
ble_else.21723:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21724
ble_then.21724:
	li      0, $i3
.count b_cont
	b       ble_cont.21724
ble_else.21724:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21724:
ble_cont.21723:
be_cont.21718:
	bne     $i3, 0, be_else.21725
be_then.21725:
	load    [$i2 + 2], $f4
	bne     $f4, $f0, be_else.21726
be_then.21726:
	li      0, $i1
	ret
be_else.21726:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, ble_else.21727
ble_then.21727:
	li      0, $i4
.count b_cont
	b       ble_cont.21727
ble_else.21727:
	li      1, $i4
ble_cont.21727:
	bne     $i1, 0, be_else.21728
be_then.21728:
	mov     $i4, $i1
.count b_cont
	b       be_cont.21728
be_else.21728:
	bne     $i4, 0, be_else.21729
be_then.21729:
	li      1, $i1
.count b_cont
	b       be_cont.21729
be_else.21729:
	li      0, $i1
be_cont.21729:
be_cont.21728:
	load    [$i3 + 2], $f7
	bne     $i1, 0, be_cont.21730
be_then.21730:
	fneg    $f7, $f7
be_cont.21730:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.21731
ble_then.21731:
	li      0, $i1
	ret
ble_else.21731:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.21732
ble_then.21732:
	li      0, $i1
	ret
ble_else.21732:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.21725:
	li      2, $i1
	ret
be_else.21717:
	li      1, $i1
	ret
be_else.21709:
	bne     $i6, 2, be_else.21733
be_then.21733:
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
	bg      $f4, $f0, ble_else.21734
ble_then.21734:
	li      0, $i1
	ret
ble_else.21734:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21733:
	load    [$i1 + 4], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 3], $i7
	load    [$i2 + 1], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i3 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i4 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i5 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	be      $i7, 0, bne_cont.21735
bne_then.21735:
	fmul    $f5, $f6, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f4, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f4, $f5, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
bne_cont.21735:
	bne     $f7, $f0, be_else.21736
be_then.21736:
	li      0, $i1
	ret
be_else.21736:
	load    [$i1 + 3], $i2
	load    [$i1 + 3], $i3
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, be_else.21737
be_then.21737:
	mov     $f9, $f4
.count b_cont
	b       be_cont.21737
be_else.21737:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f4, $f3, $f13
	fmul    $f6, $f1, $f6
	fadd    $f13, $f6, $f6
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f13
	fmul    $f6, $f13, $f6
	fadd    $f12, $f6, $f6
	fmul    $f4, $f2, $f4
	fmul    $f5, $f1, $f5
	fadd    $f4, $f5, $f4
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f6, $f4, $f4
	fmul    $f4, $fc4, $f4
	fadd    $f9, $f4, $f4
be_cont.21737:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.21738
be_then.21738:
	mov     $f6, $f1
.count b_cont
	b       be_cont.21738
be_else.21738:
	fmul    $f2, $f3, $f8
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f1, $f3
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f6, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21738:
	bne     $i6, 3, be_cont.21739
be_then.21739:
	fsub    $f1, $fc0, $f1
be_cont.21739:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.21740
ble_then.21740:
	li      0, $i1
	ret
ble_else.21740:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.21741
be_then.21741:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21741:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin solver_fast
solver_fast.2796:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 5], $i3
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [ext_light_dirvec + 1], $i6
	load    [$i2 + 1], $i7
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i4 + 1], $f4
	load    [ext_intersection_point + 2], $f5
	load    [$i5 + 2], $f6
	fsub    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsub    $f5, $f6, $f3
	load    [$i6 + $i1], $i1
	bne     $i7, 1, be_else.21742
be_then.21742:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.21743
ble_then.21743:
	li      0, $i4
.count b_cont
	b       ble_cont.21743
ble_else.21743:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.21744
ble_then.21744:
	li      0, $i4
.count b_cont
	b       ble_cont.21744
ble_else.21744:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21745
be_then.21745:
	li      0, $i4
.count b_cont
	b       be_cont.21745
be_else.21745:
	li      1, $i4
be_cont.21745:
ble_cont.21744:
ble_cont.21743:
	bne     $i4, 0, be_else.21746
be_then.21746:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21747
ble_then.21747:
	li      0, $i2
.count b_cont
	b       ble_cont.21747
ble_else.21747:
	load    [$i2 + 4], $i2
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.21748
ble_then.21748:
	li      0, $i2
.count b_cont
	b       ble_cont.21748
ble_else.21748:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.21749
be_then.21749:
	li      0, $i2
.count b_cont
	b       be_cont.21749
be_else.21749:
	li      1, $i2
be_cont.21749:
ble_cont.21748:
ble_cont.21747:
	bne     $i2, 0, be_else.21750
be_then.21750:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.21751
ble_then.21751:
	li      0, $i1
	ret
ble_else.21751:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.21752
ble_then.21752:
	li      0, $i1
	ret
ble_else.21752:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.21753
be_then.21753:
	li      0, $i1
	ret
be_else.21753:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.21750:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.21746:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.21742:
	load    [$i1 + 0], $f4
	bne     $i7, 2, be_else.21754
be_then.21754:
	bg      $f0, $f4, ble_else.21755
ble_then.21755:
	li      0, $i1
	ret
ble_else.21755:
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
be_else.21754:
	bne     $f4, $f0, be_else.21756
be_then.21756:
	li      0, $i1
	ret
be_else.21756:
	load    [$i2 + 4], $i3
	load    [$i2 + 4], $i4
	load    [$i2 + 4], $i5
	load    [$i2 + 3], $i6
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
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i5 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i6, 0, be_else.21757
be_then.21757:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21757
be_else.21757:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i3
	load    [$i3 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i2 + 9], $i3
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21757:
	bne     $i7, 3, be_cont.21758
be_then.21758:
	fsub    $f1, $fc0, $f1
be_cont.21758:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.21759
ble_then.21759:
	li      0, $i1
	ret
ble_else.21759:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.21760
be_then.21760:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret
be_else.21760:
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
	bne     $i6, 1, be_else.21761
be_then.21761:
	load    [$i2 + 0], $i2
	load    [$i3 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.21762
ble_then.21762:
	li      0, $i4
.count b_cont
	b       ble_cont.21762
ble_else.21762:
	load    [$i3 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.21763
ble_then.21763:
	li      0, $i4
.count b_cont
	b       ble_cont.21763
ble_else.21763:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21764
be_then.21764:
	li      0, $i4
.count b_cont
	b       be_cont.21764
be_else.21764:
	li      1, $i4
be_cont.21764:
ble_cont.21763:
ble_cont.21762:
	bne     $i4, 0, be_else.21765
be_then.21765:
	load    [$i3 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21766
ble_then.21766:
	li      0, $i3
.count b_cont
	b       ble_cont.21766
ble_else.21766:
	load    [$i3 + 4], $i3
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.21767
ble_then.21767:
	li      0, $i3
.count b_cont
	b       ble_cont.21767
ble_else.21767:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.21768
be_then.21768:
	li      0, $i3
.count b_cont
	b       be_cont.21768
be_else.21768:
	li      1, $i3
be_cont.21768:
ble_cont.21767:
ble_cont.21766:
	bne     $i3, 0, be_else.21769
be_then.21769:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.21770
ble_then.21770:
	li      0, $i1
	ret
ble_else.21770:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.21771
ble_then.21771:
	li      0, $i1
	ret
ble_else.21771:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.21772
be_then.21772:
	li      0, $i1
	ret
be_else.21772:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.21769:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.21765:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.21761:
	bne     $i6, 2, be_else.21773
be_then.21773:
	load    [$i1 + 0], $f1
	bg      $f0, $f1, ble_else.21774
ble_then.21774:
	li      0, $i1
	ret
ble_else.21774:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21773:
	load    [$i1 + 0], $f4
	bne     $f4, $f0, be_else.21775
be_then.21775:
	li      0, $i1
	ret
be_else.21775:
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
	bg      $f2, $f0, ble_else.21776
ble_then.21776:
	li      0, $i1
	ret
ble_else.21776:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, be_else.21777
be_then.21777:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21777:
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
######################################################################
.begin setup_rect_table
setup_rect_table.2817:
	li      6, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i4 + 0], $f1
	bne     $f1, $f0, be_else.21778
be_then.21778:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.21778
be_else.21778:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21779
ble_then.21779:
	li      0, $i3
.count b_cont
	b       ble_cont.21779
ble_else.21779:
	li      1, $i3
ble_cont.21779:
	bne     $i2, 0, be_else.21780
be_then.21780:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21780
be_else.21780:
	bne     $i3, 0, be_else.21781
be_then.21781:
	li      1, $i2
.count b_cont
	b       be_cont.21781
be_else.21781:
	li      0, $i2
be_cont.21781:
be_cont.21780:
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.21782
be_then.21782:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.21782
be_else.21782:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.21782:
be_cont.21778:
	load    [$i4 + 1], $f1
	bne     $f1, $f0, be_else.21783
be_then.21783:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.21783
be_else.21783:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21784
ble_then.21784:
	li      0, $i3
.count b_cont
	b       ble_cont.21784
ble_else.21784:
	li      1, $i3
ble_cont.21784:
	bne     $i2, 0, be_else.21785
be_then.21785:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21785
be_else.21785:
	bne     $i3, 0, be_else.21786
be_then.21786:
	li      1, $i2
.count b_cont
	b       be_cont.21786
be_else.21786:
	li      0, $i2
be_cont.21786:
be_cont.21785:
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.21787
be_then.21787:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.21787
be_else.21787:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.21787:
be_cont.21783:
	load    [$i4 + 2], $f1
	bne     $f1, $f0, be_else.21788
be_then.21788:
	store   $f0, [$i1 + 5]
	jr      $ra1
be_else.21788:
	load    [$i5 + 6], $i2
	load    [$i5 + 4], $i3
	bg      $f0, $f1, ble_else.21789
ble_then.21789:
	li      0, $i5
.count b_cont
	b       ble_cont.21789
ble_else.21789:
	li      1, $i5
ble_cont.21789:
	bne     $i2, 0, be_else.21790
be_then.21790:
	mov     $i5, $i2
.count b_cont
	b       be_cont.21790
be_else.21790:
	bne     $i5, 0, be_else.21791
be_then.21791:
	li      1, $i2
.count b_cont
	b       be_cont.21791
be_else.21791:
	li      0, $i2
be_cont.21791:
be_cont.21790:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_else.21792
be_then.21792:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21792:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i6]
# [$f1 - $f3]
# []
# []
######################################################################
.begin setup_surface_table
setup_surface_table.2820:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i5 + 4], $i2
	load    [$i5 + 4], $i3
	load    [$i5 + 4], $i6
	load    [$i4 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i4 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i4 + 2], $f2
	load    [$i6 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f1, $f0, ble_else.21793
ble_then.21793:
	store   $f0, [$i1 + 0]
	jr      $ra1
ble_else.21793:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i5 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i5 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i5 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	jr      $ra1
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i7]
# [$f1 - $f8]
# []
# []
######################################################################
.begin setup_second_table
setup_second_table.2823:
	li      5, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i5 + 3], $i2
	load    [$i5 + 4], $i3
	load    [$i5 + 4], $i6
	load    [$i5 + 4], $i7
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i6 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i7 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.21794
be_then.21794:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21794
be_else.21794:
	fmul    $f2, $f3, $f5
	load    [$i5 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i5 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i5 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21794:
	store   $f1, [$i1 + 0]
	load    [$i5 + 4], $i3
	load    [$i5 + 4], $i6
	load    [$i5 + 4], $i7
	load    [$i4 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i4 + 1], $f3
	load    [$i6 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i4 + 2], $f5
	load    [$i7 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
	bne     $i2, 0, be_else.21795
be_then.21795:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.21796
be_then.21796:
	jr      $ra1
be_else.21796:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
be_else.21795:
	load    [$i5 + 9], $i2
	load    [$i5 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i5 + 9], $i2
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
	bne     $f1, $f0, be_else.21797
be_then.21797:
	jr      $ra1
be_else.21797:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i8, $i9)
# $ra = $ra2
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i9, 0, bge_else.21798
bge_then.21798:
	load    [$i8 + 1], $i10
	load    [ext_objects + $i9], $i5
	load    [$i5 + 1], $i1
	load    [$i8 + 0], $i4
	bne     $i1, 1, be_else.21799
be_then.21799:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
be_else.21799:
	bne     $i1, 2, be_else.21800
be_then.21800:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
be_else.21800:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
bge_else.21798:
	jr      $ra2
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i8)
# $ra = $ra2
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
######################################################################
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
	sub     $ig0, 1, $i9
	b       iter_setup_dirvec_constants.2826
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1 - $i9]
# [$f1 - $f6]
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bge_else.21801
bge_then.21801:
	load    [ext_objects + $i1], $i3
	load    [$i3 + 5], $i4
	load    [$i3 + 10], $i5
	load    [$i2 + 0], $f1
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 0]
	load    [$i3 + 5], $i4
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 1]
	load    [$i3 + 5], $i4
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 2]
	load    [$i3 + 1], $i4
	bne     $i4, 2, be_else.21802
be_then.21802:
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
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
be_else.21802:
	bg      $i4, 2, ble_else.21803
ble_then.21803:
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
ble_else.21803:
	load    [$i3 + 4], $i6
	load    [$i3 + 4], $i7
	load    [$i3 + 4], $i8
	load    [$i3 + 3], $i9
	load    [$i5 + 0], $f1
	load    [$i5 + 1], $f2
	load    [$i5 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i6 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i7 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i8 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i9, 0, be_else.21804
be_then.21804:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21804
be_else.21804:
	load    [$i3 + 9], $i6
	load    [$i3 + 9], $i7
	load    [$i3 + 9], $i3
	fmul    $f2, $f3, $f5
	load    [$i6 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i7 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21804:
	sub     $i1, 1, $i1
	bne     $i4, 3, be_else.21805
be_then.21805:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
be_else.21805:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
bge_else.21801:
	ret
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i9]
# [$f1 - $f9]
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21806
be_then.21806:
	li      1, $i1
	ret
be_else.21806:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 5], $i7
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i7 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, be_else.21807
be_then.21807:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.21808
ble_then.21808:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21809
be_then.21809:
	li      1, $i2
.count b_cont
	b       be_cont.21807
be_else.21809:
	li      0, $i2
.count b_cont
	b       be_cont.21807
ble_else.21808:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.21810
ble_then.21810:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21811
be_then.21811:
	li      1, $i2
.count b_cont
	b       be_cont.21807
be_else.21811:
	li      0, $i2
.count b_cont
	b       be_cont.21807
ble_else.21810:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.21807
ble_then.21812:
	bne     $i2, 0, be_else.21813
be_then.21813:
	li      1, $i2
.count b_cont
	b       be_cont.21807
be_else.21813:
	li      0, $i2
.count b_cont
	b       be_cont.21807
be_else.21807:
	bne     $i4, 2, be_else.21814
be_then.21814:
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
	bg      $f0, $f1, ble_else.21815
ble_then.21815:
	bne     $i4, 0, be_else.21816
be_then.21816:
	li      1, $i2
.count b_cont
	b       be_cont.21814
be_else.21816:
	li      0, $i2
.count b_cont
	b       be_cont.21814
ble_else.21815:
	bne     $i4, 0, be_else.21817
be_then.21817:
	li      0, $i2
.count b_cont
	b       be_cont.21814
be_else.21817:
	li      1, $i2
.count b_cont
	b       be_cont.21814
be_else.21814:
	load    [$i2 + 6], $i5
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $i6
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $i6
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i2 + 4], $i6
	load    [$i6 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i6
	bne     $i6, 0, be_else.21818
be_then.21818:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21818
be_else.21818:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i6
	load    [$i6 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 9], $i6
	load    [$i6 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 9], $i2
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
be_cont.21818:
	bne     $i4, 3, be_cont.21819
be_then.21819:
	fsub    $f1, $fc0, $f1
be_cont.21819:
	bg      $f0, $f1, ble_else.21820
ble_then.21820:
	bne     $i5, 0, be_else.21821
be_then.21821:
	li      1, $i2
.count b_cont
	b       ble_cont.21820
be_else.21821:
	li      0, $i2
.count b_cont
	b       ble_cont.21820
ble_else.21820:
	bne     $i5, 0, be_else.21822
be_then.21822:
	li      0, $i2
.count b_cont
	b       be_cont.21822
be_else.21822:
	li      1, $i2
be_cont.21822:
ble_cont.21820:
be_cont.21814:
be_cont.21807:
	bne     $i2, 0, be_else.21823
be_then.21823:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21824
be_then.21824:
	li      1, $i1
	ret
be_else.21824:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i7, 1, be_else.21825
be_then.21825:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.21826
ble_then.21826:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21827
be_then.21827:
	li      1, $i2
.count b_cont
	b       be_cont.21825
be_else.21827:
	li      0, $i2
.count b_cont
	b       be_cont.21825
ble_else.21826:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.21828
ble_then.21828:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21829
be_then.21829:
	li      1, $i2
.count b_cont
	b       be_cont.21825
be_else.21829:
	li      0, $i2
.count b_cont
	b       be_cont.21825
ble_else.21828:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.21825
ble_then.21830:
	bne     $i2, 0, be_else.21831
be_then.21831:
	li      1, $i2
.count b_cont
	b       be_cont.21825
be_else.21831:
	li      0, $i2
.count b_cont
	b       be_cont.21825
be_else.21825:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.21832
be_then.21832:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.21833
ble_then.21833:
	bne     $i4, 0, be_else.21834
be_then.21834:
	li      1, $i2
.count b_cont
	b       be_cont.21832
be_else.21834:
	li      0, $i2
.count b_cont
	b       be_cont.21832
ble_else.21833:
	bne     $i4, 0, be_else.21835
be_then.21835:
	li      0, $i2
.count b_cont
	b       be_cont.21832
be_else.21835:
	li      1, $i2
.count b_cont
	b       be_cont.21832
be_else.21832:
	load    [$i2 + 1], $i5
	load    [$i2 + 4], $i6
	load    [$i2 + 4], $i7
	load    [$i2 + 4], $i8
	load    [$i2 + 3], $i9
	fmul    $f1, $f1, $f7
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i7 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i8 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i9, 0, be_else.21836
be_then.21836:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21836
be_else.21836:
	load    [$i2 + 9], $i6
	load    [$i2 + 9], $i7
	load    [$i2 + 9], $i2
	fmul    $f5, $f6, $f8
	load    [$i6 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i7 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
be_cont.21836:
	bne     $i5, 3, be_cont.21837
be_then.21837:
	fsub    $f1, $fc0, $f1
be_cont.21837:
	bg      $f0, $f1, ble_else.21838
ble_then.21838:
	bne     $i4, 0, be_else.21839
be_then.21839:
	li      1, $i2
.count b_cont
	b       ble_cont.21838
be_else.21839:
	li      0, $i2
.count b_cont
	b       ble_cont.21838
ble_else.21838:
	bne     $i4, 0, be_else.21840
be_then.21840:
	li      0, $i2
.count b_cont
	b       be_cont.21840
be_else.21840:
	li      1, $i2
be_cont.21840:
ble_cont.21838:
be_cont.21832:
be_cont.21825:
	bne     $i2, 0, be_else.21841
be_then.21841:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21842
be_then.21842:
	li      1, $i1
	ret
be_else.21842:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 5], $i7
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i7 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, be_else.21843
be_then.21843:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.21844
ble_then.21844:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21845
be_then.21845:
	li      1, $i2
.count b_cont
	b       be_cont.21843
be_else.21845:
	li      0, $i2
.count b_cont
	b       be_cont.21843
ble_else.21844:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.21846
ble_then.21846:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21847
be_then.21847:
	li      1, $i2
.count b_cont
	b       be_cont.21843
be_else.21847:
	li      0, $i2
.count b_cont
	b       be_cont.21843
ble_else.21846:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.21843
ble_then.21848:
	bne     $i2, 0, be_else.21849
be_then.21849:
	li      1, $i2
.count b_cont
	b       be_cont.21843
be_else.21849:
	li      0, $i2
.count b_cont
	b       be_cont.21843
be_else.21843:
	bne     $i4, 2, be_else.21850
be_then.21850:
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
	bg      $f0, $f1, ble_else.21851
ble_then.21851:
	bne     $i4, 0, be_else.21852
be_then.21852:
	li      1, $i2
.count b_cont
	b       be_cont.21850
be_else.21852:
	li      0, $i2
.count b_cont
	b       be_cont.21850
ble_else.21851:
	bne     $i4, 0, be_else.21853
be_then.21853:
	li      0, $i2
.count b_cont
	b       be_cont.21850
be_else.21853:
	li      1, $i2
.count b_cont
	b       be_cont.21850
be_else.21850:
	load    [$i2 + 6], $i4
	load    [$i2 + 1], $i5
	load    [$i2 + 3], $i6
	fmul    $f1, $f1, $f7
	load    [$i2 + 4], $i7
	load    [$i7 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $i7
	load    [$i7 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i2 + 4], $i7
	load    [$i7 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i6, 0, be_else.21854
be_then.21854:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21854
be_else.21854:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i6
	load    [$i6 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 9], $i6
	load    [$i6 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 9], $i2
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
be_cont.21854:
	bne     $i5, 3, be_cont.21855
be_then.21855:
	fsub    $f1, $fc0, $f1
be_cont.21855:
	bg      $f0, $f1, ble_else.21856
ble_then.21856:
	bne     $i4, 0, be_else.21857
be_then.21857:
	li      1, $i2
.count b_cont
	b       ble_cont.21856
be_else.21857:
	li      0, $i2
.count b_cont
	b       ble_cont.21856
ble_else.21856:
	bne     $i4, 0, be_else.21858
be_then.21858:
	li      0, $i2
.count b_cont
	b       be_cont.21858
be_else.21858:
	li      1, $i2
be_cont.21858:
ble_cont.21856:
be_cont.21850:
be_cont.21843:
	bne     $i2, 0, be_else.21859
be_then.21859:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21860
be_then.21860:
	li      1, $i1
	ret
be_else.21860:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 0], $f1
	load    [$i5 + 1], $f5
	load    [$i6 + 2], $f6
	fsub    $f2, $f1, $f1
	fsub    $f3, $f5, $f5
	fsub    $f4, $f6, $f6
	bne     $i7, 1, be_else.21861
be_then.21861:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.21862
ble_then.21862:
	li      0, $i4
.count b_cont
	b       ble_cont.21862
ble_else.21862:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.21863
ble_then.21863:
	li      0, $i4
.count b_cont
	b       ble_cont.21863
ble_else.21863:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.21864
ble_then.21864:
	li      0, $i4
.count b_cont
	b       ble_cont.21864
ble_else.21864:
	li      1, $i4
ble_cont.21864:
ble_cont.21863:
ble_cont.21862:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.21865
be_then.21865:
	bne     $i2, 0, be_else.21866
be_then.21866:
	li      0, $i1
	ret
be_else.21866:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21865:
	bne     $i2, 0, be_else.21867
be_then.21867:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21867:
	li      0, $i1
	ret
be_else.21861:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.21868
be_then.21868:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.21869
ble_then.21869:
	bne     $i4, 0, be_else.21870
be_then.21870:
	li      0, $i1
	ret
be_else.21870:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.21869:
	bne     $i4, 0, be_else.21871
be_then.21871:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21871:
	li      0, $i1
	ret
be_else.21868:
	load    [$i2 + 4], $i5
	load    [$i2 + 4], $i6
	load    [$i2 + 4], $i8
	load    [$i2 + 3], $i9
	fmul    $f1, $f1, $f7
	load    [$i5 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i8 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bne     $i9, 0, be_else.21872
be_then.21872:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21872
be_else.21872:
	fmul    $f5, $f6, $f8
	load    [$i2 + 9], $i5
	load    [$i5 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i2 + 9], $i5
	load    [$i5 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i2 + 9], $i2
	load    [$i2 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
be_cont.21872:
	bne     $i7, 3, be_cont.21873
be_then.21873:
	fsub    $f1, $fc0, $f1
be_cont.21873:
	bg      $f0, $f1, ble_else.21874
ble_then.21874:
	bne     $i4, 0, be_else.21875
be_then.21875:
	li      0, $i1
	ret
be_else.21875:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.21874:
	bne     $i4, 0, be_else.21876
be_then.21876:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21876:
	li      0, $i1
	ret
be_else.21859:
	li      0, $i1
	ret
be_else.21841:
	li      0, $i1
	ret
be_else.21823:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i10, $i11)
# $ra = $ra1
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21877
be_then.21877:
	li      0, $i1
	jr      $ra1
be_else.21877:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 5], $i3
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [ext_light_dirvec + 1], $i6
	load    [$i2 + 1], $i7
	load    [ext_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i4 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i5 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [$i6 + $i1], $i3
	bne     $i7, 1, be_else.21878
be_then.21878:
	load    [ext_light_dirvec + 0], $i4
	load    [$i2 + 4], $i5
	load    [$i5 + 1], $f4
	load    [$i4 + 1], $f5
	load    [$i3 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i3 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.21879
ble_then.21879:
	li      0, $i5
.count b_cont
	b       ble_cont.21879
ble_else.21879:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.21880
ble_then.21880:
	li      0, $i5
.count b_cont
	b       ble_cont.21880
ble_else.21880:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.21881
be_then.21881:
	li      0, $i5
.count b_cont
	b       be_cont.21881
be_else.21881:
	li      1, $i5
be_cont.21881:
ble_cont.21880:
ble_cont.21879:
	bne     $i5, 0, be_else.21882
be_then.21882:
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.21883
ble_then.21883:
	li      0, $i5
.count b_cont
	b       ble_cont.21883
ble_else.21883:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.21884
ble_then.21884:
	li      0, $i5
.count b_cont
	b       ble_cont.21884
ble_else.21884:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, be_else.21885
be_then.21885:
	li      0, $i5
.count b_cont
	b       be_cont.21885
be_else.21885:
	li      1, $i5
be_cont.21885:
ble_cont.21884:
ble_cont.21883:
	bne     $i5, 0, be_else.21886
be_then.21886:
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.21887
ble_then.21887:
	li      0, $i2
.count b_cont
	b       be_cont.21878
ble_else.21887:
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.21888
ble_then.21888:
	li      0, $i2
.count b_cont
	b       be_cont.21878
ble_else.21888:
	load    [$i3 + 5], $f1
	bne     $f1, $f0, be_else.21889
be_then.21889:
	li      0, $i2
.count b_cont
	b       be_cont.21878
be_else.21889:
	mov     $f3, $fg0
	li      3, $i2
.count b_cont
	b       be_cont.21878
be_else.21886:
	mov     $f6, $fg0
	li      2, $i2
.count b_cont
	b       be_cont.21878
be_else.21882:
	mov     $f6, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21878
be_else.21878:
	load    [$i3 + 0], $f4
	bne     $i7, 2, be_else.21890
be_then.21890:
	bg      $f0, $f4, ble_else.21891
ble_then.21891:
	li      0, $i2
.count b_cont
	b       be_cont.21890
ble_else.21891:
	load    [$i3 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i3 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i3 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21890
be_else.21890:
	bne     $f4, $f0, be_else.21892
be_then.21892:
	li      0, $i2
.count b_cont
	b       be_cont.21892
be_else.21892:
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
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i4
	bne     $i4, 0, be_else.21893
be_then.21893:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21893
be_else.21893:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21893:
	bne     $i7, 3, be_cont.21894
be_then.21894:
	fsub    $f1, $fc0, $f1
be_cont.21894:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.21895
ble_then.21895:
	li      0, $i2
.count b_cont
	b       ble_cont.21895
ble_else.21895:
	load    [$i2 + 6], $i2
	load    [$i3 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.21896
be_then.21896:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21896
be_else.21896:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i2
be_cont.21896:
ble_cont.21895:
be_cont.21892:
be_cont.21890:
be_cont.21878:
	bne     $i2, 0, be_else.21897
be_then.21897:
	li      0, $i2
.count b_cont
	b       be_cont.21897
be_else.21897:
.count load_float
	load    [f.21521], $f1
	bg      $f1, $fg0, ble_else.21898
ble_then.21898:
	li      0, $i2
.count b_cont
	b       ble_cont.21898
ble_else.21898:
	li      1, $i2
ble_cont.21898:
be_cont.21897:
	bne     $i2, 0, be_else.21899
be_then.21899:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21900
be_then.21900:
	li      0, $i1
	jr      $ra1
be_else.21900:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.21899:
	load    [$i11 + 0], $i1
	bne     $i1, -1, be_else.21901
be_then.21901:
	li      1, $i1
	jr      $ra1
be_else.21901:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	fadd    $fg0, $fc16, $f2
	fmul    $fg14, $f2, $f3
	load    [ext_intersection_point + 0], $f4
	fadd    $f3, $f4, $f5
	fsub    $f5, $f1, $f1
	load    [$i3 + 1], $f3
	fmul    $fg12, $f2, $f4
	load    [ext_intersection_point + 1], $f6
	fadd    $f4, $f6, $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 2], $f4
	fmul    $fg13, $f2, $f2
	load    [ext_intersection_point + 2], $f7
	fadd    $f2, $f7, $f7
	fsub    $f7, $f4, $f2
	bne     $i5, 1, be_else.21902
be_then.21902:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f4
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.21903
ble_then.21903:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21904
be_then.21904:
	li      1, $i1
.count b_cont
	b       be_cont.21902
be_else.21904:
	li      0, $i1
.count b_cont
	b       be_cont.21902
ble_else.21903:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f1
	fabs    $f3, $f3
	bg      $f1, $f3, ble_else.21905
ble_then.21905:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.21906
be_then.21906:
	li      1, $i1
.count b_cont
	b       be_cont.21902
be_else.21906:
	li      0, $i1
.count b_cont
	b       be_cont.21902
ble_else.21905:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f1
	fabs    $f2, $f2
	load    [$i1 + 6], $i1
	bg      $f1, $f2, be_cont.21902
ble_then.21907:
	bne     $i1, 0, be_else.21908
be_then.21908:
	li      1, $i1
.count b_cont
	b       be_cont.21902
be_else.21908:
	li      0, $i1
.count b_cont
	b       be_cont.21902
be_else.21902:
	load    [$i1 + 6], $i2
	bne     $i5, 2, be_else.21909
be_then.21909:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.21910
ble_then.21910:
	bne     $i2, 0, be_else.21911
be_then.21911:
	li      1, $i1
.count b_cont
	b       be_cont.21909
be_else.21911:
	li      0, $i1
.count b_cont
	b       be_cont.21909
ble_else.21910:
	bne     $i2, 0, be_else.21912
be_then.21912:
	li      0, $i1
.count b_cont
	b       be_cont.21909
be_else.21912:
	li      1, $i1
.count b_cont
	b       be_cont.21909
be_else.21909:
	fmul    $f1, $f1, $f4
	load    [$i1 + 4], $i3
	load    [$i3 + 0], $f8
	fmul    $f4, $f8, $f4
	fmul    $f3, $f3, $f8
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	fmul    $f2, $f2, $f8
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f9
	fmul    $f8, $f9, $f8
	load    [$i1 + 3], $i3
	fadd    $f4, $f8, $f4
	bne     $i3, 0, be_else.21913
be_then.21913:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21913
be_else.21913:
	fmul    $f3, $f2, $f8
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f4, $f8, $f4
	fmul    $f2, $f1, $f2
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f8
	fmul    $f2, $f8, $f2
	fadd    $f4, $f2, $f2
	fmul    $f1, $f3, $f1
	load    [$i1 + 9], $i1
	load    [$i1 + 2], $f3
	fmul    $f1, $f3, $f1
	fadd    $f2, $f1, $f1
be_cont.21913:
	bne     $i5, 3, be_cont.21914
be_then.21914:
	fsub    $f1, $fc0, $f1
be_cont.21914:
	bg      $f0, $f1, ble_else.21915
ble_then.21915:
	bne     $i2, 0, be_else.21916
be_then.21916:
	li      1, $i1
.count b_cont
	b       ble_cont.21915
be_else.21916:
	li      0, $i1
.count b_cont
	b       ble_cont.21915
ble_else.21915:
	bne     $i2, 0, be_else.21917
be_then.21917:
	li      0, $i1
.count b_cont
	b       be_cont.21917
be_else.21917:
	li      1, $i1
be_cont.21917:
ble_cont.21915:
be_cont.21909:
be_cont.21902:
	bne     $i1, 0, be_else.21918
be_then.21918:
	li      1, $i1
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f7, $f4
	call    check_all_inside.2856
	bne     $i1, 0, be_else.21919
be_then.21919:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.21919:
	li      1, $i1
	jr      $ra1
be_else.21918:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i12, $i13)
# $ra = $ra2
# [$i1 - $i13]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21920
be_then.21920:
	li      0, $i1
	jr      $ra2
be_else.21920:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21921
be_then.21921:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21922
be_then.21922:
	li      0, $i1
	jr      $ra2
be_else.21922:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21923
be_then.21923:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21924
be_then.21924:
	li      0, $i1
	jr      $ra2
be_else.21924:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21925
be_then.21925:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21926
be_then.21926:
	li      0, $i1
	jr      $ra2
be_else.21926:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21927
be_then.21927:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21928
be_then.21928:
	li      0, $i1
	jr      $ra2
be_else.21928:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21929
be_then.21929:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21930
be_then.21930:
	li      0, $i1
	jr      $ra2
be_else.21930:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21931
be_then.21931:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21932
be_then.21932:
	li      0, $i1
	jr      $ra2
be_else.21932:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21933
be_then.21933:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.21934
be_then.21934:
	li      0, $i1
	jr      $ra2
be_else.21934:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21935
be_then.21935:
	add     $i12, 1, $i12
	b       shadow_check_one_or_group.2865
be_else.21935:
	li      1, $i1
	jr      $ra2
be_else.21933:
	li      1, $i1
	jr      $ra2
be_else.21931:
	li      1, $i1
	jr      $ra2
be_else.21929:
	li      1, $i1
	jr      $ra2
be_else.21927:
	li      1, $i1
	jr      $ra2
be_else.21925:
	li      1, $i1
	jr      $ra2
be_else.21923:
	li      1, $i1
	jr      $ra2
be_else.21921:
	li      1, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i14, $i15)
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.21936
be_then.21936:
	li      0, $i1
	jr      $ra3
be_else.21936:
	bne     $i1, 99, be_else.21937
be_then.21937:
	li      1, $i1
.count b_cont
	b       be_cont.21937
be_else.21937:
	load    [ext_objects + $i1], $i2
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 5], $i3
	load    [$i3 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [ext_intersection_point + 1], $f2
	load    [$i2 + 5], $i3
	load    [$i3 + 1], $f3
	fsub    $f2, $f3, $f2
	load    [ext_intersection_point + 2], $f3
	load    [$i2 + 5], $i3
	load    [$i3 + 2], $f4
	fsub    $f3, $f4, $f3
	load    [ext_light_dirvec + 1], $i3
	load    [$i3 + $i1], $i1
	load    [$i2 + 1], $i3
	bne     $i3, 1, be_else.21938
be_then.21938:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i1 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.21939
ble_then.21939:
	li      0, $i4
.count b_cont
	b       ble_cont.21939
ble_else.21939:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.21940
ble_then.21940:
	li      0, $i4
.count b_cont
	b       ble_cont.21940
ble_else.21940:
	load    [$i1 + 1], $f4
	bne     $f4, $f0, be_else.21941
be_then.21941:
	li      0, $i4
.count b_cont
	b       be_cont.21941
be_else.21941:
	li      1, $i4
be_cont.21941:
ble_cont.21940:
ble_cont.21939:
	bne     $i4, 0, be_else.21942
be_then.21942:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.21943
ble_then.21943:
	li      0, $i4
.count b_cont
	b       ble_cont.21943
ble_else.21943:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.21944
ble_then.21944:
	li      0, $i4
.count b_cont
	b       ble_cont.21944
ble_else.21944:
	load    [$i1 + 3], $f4
	bne     $f4, $f0, be_else.21945
be_then.21945:
	li      0, $i4
.count b_cont
	b       be_cont.21945
be_else.21945:
	li      1, $i4
be_cont.21945:
ble_cont.21944:
ble_cont.21943:
	bne     $i4, 0, be_else.21946
be_then.21946:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i1 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.21947
ble_then.21947:
	li      0, $i1
.count b_cont
	b       be_cont.21938
ble_else.21947:
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.21948
ble_then.21948:
	li      0, $i1
.count b_cont
	b       be_cont.21938
ble_else.21948:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.21949
be_then.21949:
	li      0, $i1
.count b_cont
	b       be_cont.21938
be_else.21949:
	mov     $f3, $fg0
	li      3, $i1
.count b_cont
	b       be_cont.21938
be_else.21946:
	mov     $f6, $fg0
	li      2, $i1
.count b_cont
	b       be_cont.21938
be_else.21942:
	mov     $f6, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.21938
be_else.21938:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.21950
be_then.21950:
	bg      $f0, $f4, ble_else.21951
ble_then.21951:
	li      0, $i1
.count b_cont
	b       be_cont.21950
ble_else.21951:
	load    [$i1 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.21950
be_else.21950:
	bne     $f4, $f0, be_else.21952
be_then.21952:
	li      0, $i1
.count b_cont
	b       be_cont.21952
be_else.21952:
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
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f3, $f8
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i4
	bne     $i4, 0, be_else.21953
be_then.21953:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21953
be_else.21953:
	fmul    $f2, $f3, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.21953:
	bne     $i3, 3, be_cont.21954
be_then.21954:
	fsub    $f1, $fc0, $f1
be_cont.21954:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.21955
ble_then.21955:
	li      0, $i1
.count b_cont
	b       ble_cont.21955
ble_else.21955:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.21956
be_then.21956:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.21956
be_else.21956:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
be_cont.21956:
ble_cont.21955:
be_cont.21952:
be_cont.21950:
be_cont.21938:
	bne     $i1, 0, be_else.21957
be_then.21957:
	li      0, $i1
.count b_cont
	b       be_cont.21957
be_else.21957:
	bg      $fc8, $fg0, ble_else.21958
ble_then.21958:
	li      0, $i1
.count b_cont
	b       ble_cont.21958
ble_else.21958:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.21959
be_then.21959:
	li      0, $i1
.count b_cont
	b       be_cont.21959
be_else.21959:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21960
be_then.21960:
	li      2, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21961
be_then.21961:
	li      0, $i1
.count b_cont
	b       be_cont.21960
be_else.21961:
	li      1, $i1
.count b_cont
	b       be_cont.21960
be_else.21960:
	li      1, $i1
be_cont.21960:
be_cont.21959:
ble_cont.21958:
be_cont.21957:
be_cont.21937:
	bne     $i1, 0, be_else.21962
be_then.21962:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.21963
be_then.21963:
	li      0, $i1
	jr      $ra3
be_else.21963:
	bne     $i1, 99, be_else.21964
be_then.21964:
	li      1, $i1
.count b_cont
	b       be_cont.21964
be_else.21964:
	call    solver_fast.2796
	bne     $i1, 0, be_else.21965
be_then.21965:
	li      0, $i1
.count b_cont
	b       be_cont.21965
be_else.21965:
	bg      $fc8, $fg0, ble_else.21966
ble_then.21966:
	li      0, $i1
.count b_cont
	b       ble_cont.21966
ble_else.21966:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.21967
be_then.21967:
	li      0, $i1
.count b_cont
	b       be_cont.21967
be_else.21967:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21968
be_then.21968:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.21969
be_then.21969:
	li      0, $i1
.count b_cont
	b       be_cont.21968
be_else.21969:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21970
be_then.21970:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21971
be_then.21971:
	li      0, $i1
.count b_cont
	b       be_cont.21968
be_else.21971:
	li      1, $i1
.count b_cont
	b       be_cont.21968
be_else.21970:
	li      1, $i1
.count b_cont
	b       be_cont.21968
be_else.21968:
	li      1, $i1
be_cont.21968:
be_cont.21967:
ble_cont.21966:
be_cont.21965:
be_cont.21964:
	bne     $i1, 0, be_else.21972
be_then.21972:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.21972:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.21973
be_then.21973:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.21973:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21974
be_then.21974:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.21975
be_then.21975:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.21975:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21976
be_then.21976:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.21977
be_then.21977:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.21977:
	li      1, $i1
	jr      $ra3
be_else.21976:
	li      1, $i1
	jr      $ra3
be_else.21974:
	li      1, $i1
	jr      $ra3
be_else.21962:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.21978
be_then.21978:
	li      0, $i1
.count b_cont
	b       be_cont.21978
be_else.21978:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21979
be_then.21979:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.21980
be_then.21980:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21980:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21981
be_then.21981:
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.21982
be_then.21982:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21982:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21983
be_then.21983:
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.21984
be_then.21984:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21984:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21985
be_then.21985:
	load    [$i16 + 5], $i1
	bne     $i1, -1, be_else.21986
be_then.21986:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21986:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21987
be_then.21987:
	load    [$i16 + 6], $i1
	bne     $i1, -1, be_else.21988
be_then.21988:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21988:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21989
be_then.21989:
	load    [$i16 + 7], $i1
	bne     $i1, -1, be_else.21990
be_then.21990:
	li      0, $i1
.count b_cont
	b       be_cont.21979
be_else.21990:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21991
be_then.21991:
	li      8, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
.count b_cont
	b       be_cont.21979
be_else.21991:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21989:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21987:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21985:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21983:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21981:
	li      1, $i1
.count b_cont
	b       be_cont.21979
be_else.21979:
	li      1, $i1
be_cont.21979:
be_cont.21978:
	bne     $i1, 0, be_else.21992
be_then.21992:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.21993
be_then.21993:
	li      0, $i1
	jr      $ra3
be_else.21993:
	bne     $i1, 99, be_else.21994
be_then.21994:
	li      1, $i1
.count b_cont
	b       be_cont.21994
be_else.21994:
	call    solver_fast.2796
	bne     $i1, 0, be_else.21995
be_then.21995:
	li      0, $i1
.count b_cont
	b       be_cont.21995
be_else.21995:
	bg      $fc8, $fg0, ble_else.21996
ble_then.21996:
	li      0, $i1
.count b_cont
	b       ble_cont.21996
ble_else.21996:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.21997
be_then.21997:
	li      0, $i1
.count b_cont
	b       be_cont.21997
be_else.21997:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.21998
be_then.21998:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.21999
be_then.21999:
	li      0, $i1
.count b_cont
	b       be_cont.21998
be_else.21999:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22000
be_then.22000:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22001
be_then.22001:
	li      0, $i1
.count b_cont
	b       be_cont.21998
be_else.22001:
	li      1, $i1
.count b_cont
	b       be_cont.21998
be_else.22000:
	li      1, $i1
.count b_cont
	b       be_cont.21998
be_else.21998:
	li      1, $i1
be_cont.21998:
be_cont.21997:
ble_cont.21996:
be_cont.21995:
be_cont.21994:
	bne     $i1, 0, be_else.22002
be_then.22002:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22002:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22003
be_then.22003:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22003:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22004
be_then.22004:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22005
be_then.22005:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22005:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22006
be_then.22006:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22007
be_then.22007:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22007:
	li      1, $i1
	jr      $ra3
be_else.22006:
	li      1, $i1
	jr      $ra3
be_else.22004:
	li      1, $i1
	jr      $ra3
be_else.21992:
	li      1, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i10, $i11, $i12)
# $ra = $ra1
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.22008
be_then.22008:
	jr      $ra1
be_else.22008:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	fsub    $fg17, $f1, $f1
	load    [$i3 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i4 + 2], $f3
	fsub    $fg19, $f3, $f3
	load    [$i12 + 0], $f4
	bne     $i5, 1, be_else.22009
be_then.22009:
	bne     $f4, $f0, be_else.22010
be_then.22010:
	li      0, $i2
.count b_cont
	b       be_cont.22010
be_else.22010:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.22011
ble_then.22011:
	li      0, $i4
.count b_cont
	b       ble_cont.22011
ble_else.22011:
	li      1, $i4
ble_cont.22011:
	bne     $i3, 0, be_else.22012
be_then.22012:
	mov     $i4, $i3
.count b_cont
	b       be_cont.22012
be_else.22012:
	bne     $i4, 0, be_else.22013
be_then.22013:
	li      1, $i3
.count b_cont
	b       be_cont.22013
be_else.22013:
	li      0, $i3
be_cont.22013:
be_cont.22012:
	load    [$i2 + 0], $f5
	bne     $i3, 0, be_cont.22014
be_then.22014:
	fneg    $f5, $f5
be_cont.22014:
	fsub    $f5, $f1, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	load    [$i12 + 1], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.22015
ble_then.22015:
	li      0, $i2
.count b_cont
	b       ble_cont.22015
ble_else.22015:
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.22016
ble_then.22016:
	li      0, $i2
.count b_cont
	b       ble_cont.22016
ble_else.22016:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.22016:
ble_cont.22015:
be_cont.22010:
	bne     $i2, 0, be_else.22017
be_then.22017:
	load    [$i12 + 1], $f4
	bne     $f4, $f0, be_else.22018
be_then.22018:
	li      0, $i2
.count b_cont
	b       be_cont.22018
be_else.22018:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.22019
ble_then.22019:
	li      0, $i4
.count b_cont
	b       ble_cont.22019
ble_else.22019:
	li      1, $i4
ble_cont.22019:
	bne     $i3, 0, be_else.22020
be_then.22020:
	mov     $i4, $i3
.count b_cont
	b       be_cont.22020
be_else.22020:
	bne     $i4, 0, be_else.22021
be_then.22021:
	li      1, $i3
.count b_cont
	b       be_cont.22021
be_else.22021:
	li      0, $i3
be_cont.22021:
be_cont.22020:
	load    [$i2 + 1], $f5
	bne     $i3, 0, be_cont.22022
be_then.22022:
	fneg    $f5, $f5
be_cont.22022:
	fsub    $f5, $f2, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.22023
ble_then.22023:
	li      0, $i2
.count b_cont
	b       ble_cont.22023
ble_else.22023:
	load    [$i2 + 0], $f5
	load    [$i12 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22024
ble_then.22024:
	li      0, $i2
.count b_cont
	b       ble_cont.22024
ble_else.22024:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.22024:
ble_cont.22023:
be_cont.22018:
	bne     $i2, 0, be_else.22025
be_then.22025:
	load    [$i12 + 2], $f4
	bne     $f4, $f0, be_else.22026
be_then.22026:
	li      0, $i14
.count b_cont
	b       be_cont.22009
be_else.22026:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f5
	load    [$i12 + 0], $f6
	load    [$i1 + 6], $i1
	bg      $f0, $f4, ble_else.22027
ble_then.22027:
	li      0, $i3
.count b_cont
	b       ble_cont.22027
ble_else.22027:
	li      1, $i3
ble_cont.22027:
	bne     $i1, 0, be_else.22028
be_then.22028:
	mov     $i3, $i1
.count b_cont
	b       be_cont.22028
be_else.22028:
	bne     $i3, 0, be_else.22029
be_then.22029:
	li      1, $i1
.count b_cont
	b       be_cont.22029
be_else.22029:
	li      0, $i1
be_cont.22029:
be_cont.22028:
	load    [$i2 + 2], $f7
	bne     $i1, 0, be_cont.22030
be_then.22030:
	fneg    $f7, $f7
be_cont.22030:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.22031
ble_then.22031:
	li      0, $i14
.count b_cont
	b       be_cont.22009
ble_else.22031:
	load    [$i2 + 1], $f1
	load    [$i12 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.22032
ble_then.22032:
	li      0, $i14
.count b_cont
	b       be_cont.22009
ble_else.22032:
	mov     $f3, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.22009
be_else.22025:
	li      2, $i14
.count b_cont
	b       be_cont.22009
be_else.22017:
	li      1, $i14
.count b_cont
	b       be_cont.22009
be_else.22009:
	bne     $i5, 2, be_else.22033
be_then.22033:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [$i12 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [$i12 + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	bg      $f4, $f0, ble_else.22034
ble_then.22034:
	li      0, $i14
.count b_cont
	b       be_cont.22033
ble_else.22034:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22033
be_else.22033:
	load    [$i1 + 3], $i2
	load    [$i1 + 4], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i12 + 1], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i3 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i4 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i5 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	be      $i2, 0, bne_cont.22035
bne_then.22035:
	fmul    $f5, $f6, $f9
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f4, $f9
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
	fmul    $f4, $f5, $f9
	load    [$i1 + 9], $i3
	load    [$i3 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f7, $f9, $f7
bne_cont.22035:
	bne     $f7, $f0, be_else.22036
be_then.22036:
	li      0, $i14
.count b_cont
	b       be_cont.22036
be_else.22036:
	load    [$i1 + 1], $i3
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, be_else.22037
be_then.22037:
	mov     $f9, $f4
.count b_cont
	b       be_cont.22037
be_else.22037:
	fmul    $f6, $f2, $f12
	fmul    $f5, $f3, $f13
	fadd    $f12, $f13, $f12
	load    [$i1 + 9], $i4
	load    [$i4 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f4, $f3, $f13
	fmul    $f6, $f1, $f6
	fadd    $f13, $f6, $f6
	load    [$i1 + 9], $i4
	load    [$i4 + 1], $f13
	fmul    $f6, $f13, $f6
	fadd    $f12, $f6, $f6
	fmul    $f4, $f2, $f4
	fmul    $f5, $f1, $f5
	fadd    $f4, $f5, $f4
	load    [$i1 + 9], $i4
	load    [$i4 + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f6, $f4, $f4
	fmul    $f4, $fc4, $f4
	fadd    $f9, $f4, $f4
be_cont.22037:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i2, 0, be_else.22038
be_then.22038:
	mov     $f6, $f1
.count b_cont
	b       be_cont.22038
be_else.22038:
	fmul    $f2, $f3, $f8
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f1, $f3
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f6, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.22038:
	bne     $i3, 3, be_cont.22039
be_then.22039:
	fsub    $f1, $fc0, $f1
be_cont.22039:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.22040
ble_then.22040:
	li      0, $i14
.count b_cont
	b       ble_cont.22040
ble_else.22040:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	li      1, $i14
	finv    $f7, $f2
	bne     $i1, 0, be_else.22041
be_then.22041:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.22041
be_else.22041:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
be_cont.22041:
ble_cont.22040:
be_cont.22036:
be_cont.22033:
be_cont.22009:
	bne     $i14, 0, be_else.22042
be_then.22042:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22043
be_then.22043:
	jr      $ra1
be_else.22043:
	add     $i10, 1, $i10
	b       solve_each_element.2871
be_else.22042:
	bg      $fg0, $f0, ble_else.22044
ble_then.22044:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.22044:
	bg      $fg7, $fg0, ble_else.22045
ble_then.22045:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.22045:
	li      0, $i1
	load    [$i12 + 0], $f1
	fadd    $fg0, $fc16, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg17, $f11
	load    [$i12 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg18, $f12
	load    [$i12 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg19, $f13
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $f11, $f2
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f13, $f4
	call    check_all_inside.2856
	add     $i10, 1, $i10
	be      $i1, 0, solve_each_element.2871
	mov     $f10, $fg7
	store   $f11, [ext_intersection_point + 0]
	store   $f12, [ext_intersection_point + 1]
	store   $f13, [ext_intersection_point + 2]
	mov     $i13, $ig3
	mov     $i14, $ig2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22047
be_then.22047:
	jr      $ra2
be_else.22047:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22048
be_then.22048:
	jr      $ra2
be_else.22048:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22049
be_then.22049:
	jr      $ra2
be_else.22049:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22050
be_then.22050:
	jr      $ra2
be_else.22050:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22051
be_then.22051:
	jr      $ra2
be_else.22051:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22052
be_then.22052:
	jr      $ra2
be_else.22052:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22053
be_then.22053:
	jr      $ra2
be_else.22053:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22054
be_then.22054:
	jr      $ra2
be_else.22054:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i18, $i19, $i20)
# $ra = $ra3
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22055
be_then.22055:
	jr      $ra3
be_else.22055:
	bne     $i1, 99, be_else.22056
be_then.22056:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.22057
bne_then.22057:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.22058
bne_then.22058:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.22059
bne_then.22059:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.22060
bne_then.22060:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.22061
bne_then.22061:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.22062
bne_then.22062:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	li      7, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
bne_cont.22062:
bne_cont.22061:
bne_cont.22060:
bne_cont.22059:
bne_cont.22058:
bne_cont.22057:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22063
be_then.22063:
	jr      $ra3
be_else.22063:
	bne     $i1, 99, be_else.22064
be_then.22064:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22065
be_then.22065:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22065:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22066
be_then.22066:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22066:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22067
be_then.22067:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22067:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22068
be_then.22068:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22068:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	li      5, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22064:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22069
be_then.22069:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22069:
	bg      $fg7, $fg0, ble_else.22070
ble_then.22070:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.22070:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22056:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22071
be_then.22071:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22071:
	bg      $fg7, $fg0, ble_else.22072
ble_then.22072:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.22072:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i10, $i11, $i12)
# $ra = $ra1
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.22073
be_then.22073:
	jr      $ra1
be_else.22073:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 10], $i2
	load    [$i12 + 1], $i3
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 2], $f3
	load    [$i3 + $i13], $i3
	bne     $i4, 1, be_else.22074
be_then.22074:
	load    [$i12 + 0], $i2
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i2 + 1], $f5
	load    [$i3 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i3 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.22075
ble_then.22075:
	li      0, $i4
.count b_cont
	b       ble_cont.22075
ble_else.22075:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.22076
ble_then.22076:
	li      0, $i4
.count b_cont
	b       ble_cont.22076
ble_else.22076:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.22077
be_then.22077:
	li      0, $i4
.count b_cont
	b       be_cont.22077
be_else.22077:
	li      1, $i4
be_cont.22077:
ble_cont.22076:
ble_cont.22075:
	bne     $i4, 0, be_else.22078
be_then.22078:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.22079
ble_then.22079:
	li      0, $i4
.count b_cont
	b       ble_cont.22079
ble_else.22079:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.22080
ble_then.22080:
	li      0, $i4
.count b_cont
	b       ble_cont.22080
ble_else.22080:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, be_else.22081
be_then.22081:
	li      0, $i4
.count b_cont
	b       be_cont.22081
be_else.22081:
	li      1, $i4
be_cont.22081:
ble_cont.22080:
ble_cont.22079:
	bne     $i4, 0, be_else.22082
be_then.22082:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.22083
ble_then.22083:
	li      0, $i14
.count b_cont
	b       be_cont.22074
ble_else.22083:
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.22084
ble_then.22084:
	li      0, $i14
.count b_cont
	b       be_cont.22074
ble_else.22084:
	load    [$i3 + 5], $f1
	bne     $f1, $f0, be_else.22085
be_then.22085:
	li      0, $i14
.count b_cont
	b       be_cont.22074
be_else.22085:
	mov     $f3, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.22074
be_else.22082:
	mov     $f6, $fg0
	li      2, $i14
.count b_cont
	b       be_cont.22074
be_else.22078:
	mov     $f6, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22074
be_else.22074:
	bne     $i4, 2, be_else.22086
be_then.22086:
	load    [$i3 + 0], $f1
	bg      $f0, $f1, ble_else.22087
ble_then.22087:
	li      0, $i14
.count b_cont
	b       be_cont.22086
ble_else.22087:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22086
be_else.22086:
	load    [$i3 + 0], $f4
	bne     $f4, $f0, be_else.22088
be_then.22088:
	li      0, $i14
.count b_cont
	b       be_cont.22088
be_else.22088:
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
	bg      $f2, $f0, ble_else.22089
ble_then.22089:
	li      0, $i14
.count b_cont
	b       ble_cont.22089
ble_else.22089:
	load    [$i1 + 6], $i1
	li      1, $i14
	fsqrt   $f2, $f2
	bne     $i1, 0, be_else.22090
be_then.22090:
	fsub    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.22090
be_else.22090:
	fadd    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
be_cont.22090:
ble_cont.22089:
be_cont.22088:
be_cont.22086:
be_cont.22074:
	bne     $i14, 0, be_else.22091
be_then.22091:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22092
be_then.22092:
	jr      $ra1
be_else.22092:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
be_else.22091:
	bg      $fg0, $f0, ble_else.22093
ble_then.22093:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.22093:
	load    [$i12 + 0], $i1
	bg      $fg7, $fg0, ble_else.22094
ble_then.22094:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.22094:
	li      0, $i2
	load    [$i1 + 0], $f1
	fadd    $fg0, $fc16, $f10
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
	mov     $i11, $i3
.count move_args
	mov     $f11, $f2
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f13, $f4
	call    check_all_inside.2856
	add     $i10, 1, $i10
	be      $i1, 0, solve_each_element_fast.2885
	mov     $f10, $fg7
	store   $f11, [ext_intersection_point + 0]
	store   $f12, [ext_intersection_point + 1]
	store   $f13, [ext_intersection_point + 2]
	mov     $i13, $ig3
	mov     $i14, $ig2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22096
be_then.22096:
	jr      $ra2
be_else.22096:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22097
be_then.22097:
	jr      $ra2
be_else.22097:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22098
be_then.22098:
	jr      $ra2
be_else.22098:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22099
be_then.22099:
	jr      $ra2
be_else.22099:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22100
be_then.22100:
	jr      $ra2
be_else.22100:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22101
be_then.22101:
	jr      $ra2
be_else.22101:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22102
be_then.22102:
	jr      $ra2
be_else.22102:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22103
be_then.22103:
	jr      $ra2
be_else.22103:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i18, $i19, $i20)
# $ra = $ra3
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22104
be_then.22104:
	jr      $ra3
be_else.22104:
	bne     $i1, 99, be_else.22105
be_then.22105:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.22106
bne_then.22106:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.22107
bne_then.22107:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.22108
bne_then.22108:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.22109
bne_then.22109:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.22110
bne_then.22110:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.22111
bne_then.22111:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
bne_cont.22111:
bne_cont.22110:
bne_cont.22109:
bne_cont.22108:
bne_cont.22107:
bne_cont.22106:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22112
be_then.22112:
	jr      $ra3
be_else.22112:
	bne     $i1, 99, be_else.22113
be_then.22113:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22114
be_then.22114:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22114:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22115
be_then.22115:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22115:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22116
be_then.22116:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22116:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22117
be_then.22117:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22117:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22113:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22118
be_then.22118:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22118:
	bg      $fg7, $fg0, ble_else.22119
ble_then.22119:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.22119:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22105:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22120
be_then.22120:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22120:
	bg      $fg7, $fg0, ble_else.22121
ble_then.22121:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.22121:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
######################################################################
.begin utexture
utexture.2908:
	load    [$i1 + 8], $i2
	load    [$i2 + 0], $fg16
	load    [$i1 + 8], $i2
	load    [$i2 + 1], $fg11
	load    [$i1 + 8], $i2
	load    [$i2 + 2], $fg15
	load    [$i1 + 0], $i2
	bne     $i2, 1, be_else.22122
be_then.22122:
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 0], $f2
.count load_float
	load    [f.21534], $f4
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.21535], $f6
.count load_float
	load    [f.21536], $f7
	fmul    $f1, $f6, $f1
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 2], $f1
	load    [$i1 + 2], $f2
	fsub    $f1, $f2, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	bg      $f7, $f5, ble_else.22123
ble_then.22123:
	li      0, $i1
.count b_cont
	b       ble_cont.22123
ble_else.22123:
	li      1, $i1
ble_cont.22123:
	bg      $f7, $f1, ble_else.22124
ble_then.22124:
	bne     $i1, 0, be_else.22125
be_then.22125:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22125:
	mov     $f0, $fg11
	jr      $ra1
ble_else.22124:
	bne     $i1, 0, be_else.22126
be_then.22126:
	mov     $f0, $fg11
	jr      $ra1
be_else.22126:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22122:
	bne     $i2, 2, be_else.22127
be_then.22127:
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.21533], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	jr      $ra1
be_else.22127:
	bne     $i2, 3, be_else.22128
be_then.22128:
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 0], $f2
	fsub    $f1, $f2, $f1
	fmul    $f1, $f1, $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i1 + 2], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	fsqrt   $f1, $f1
	fmul    $f1, $fc7, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc15, $f2
	call    ext_cos
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg15
	jr      $ra1
be_else.22128:
	bne     $i2, 4, be_else.22129
be_then.22129:
	load    [$i1 + 5], $i2
	load    [$i1 + 4], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 4], $i5
.count load_float
	load    [f.21524], $f6
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 0], $f2
	fsub    $f1, $f2, $f1
	load    [$i3 + 0], $f2
	fsqrt   $f2, $f2
	fmul    $f1, $f2, $f7
	fabs    $f7, $f1
	load    [ext_intersection_point + 2], $f2
	load    [$i4 + 2], $f3
	fsub    $f2, $f3, $f2
	load    [$i5 + 2], $f3
	fsqrt   $f3, $f3
	fmul    $f2, $f3, $f8
	bg      $f6, $f1, ble_else.22130
ble_then.22130:
	finv    $f7, $f1
	fmul_a  $f8, $f1, $f2
	call    ext_atan
	fmul    $f1, $fc19, $f1
	fmul    $f1, $fc18, $f9
.count b_cont
	b       ble_cont.22130
ble_else.22130:
.count load_float
	load    [f.21525], $f9
ble_cont.22130:
	load    [$i1 + 5], $i2
	load    [$i1 + 4], $i1
	fmul    $f7, $f7, $f1
	fmul    $f8, $f8, $f2
	fadd    $f1, $f2, $f1
	fabs    $f1, $f2
	load    [ext_intersection_point + 1], $f3
	load    [$i2 + 1], $f4
	fsub    $f3, $f4, $f3
	load    [$i1 + 1], $f4
	fsqrt   $f4, $f4
	fmul    $f3, $f4, $f3
	bg      $f6, $f2, ble_else.22131
ble_then.22131:
	finv    $f1, $f1
	fmul_a  $f3, $f1, $f2
	call    ext_atan
	fmul    $f1, $fc19, $f1
	fmul    $f1, $fc18, $f4
.count b_cont
	b       ble_cont.22131
ble_else.22131:
.count load_float
	load    [f.21525], $f4
ble_cont.22131:
.count load_float
	load    [f.21529], $f5
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
	bg      $f0, $f1, ble_else.22132
ble_then.22132:
	fmul    $fc9, $f1, $f1
.count load_float
	load    [f.21531], $f2
	fmul    $f1, $f2, $fg15
	jr      $ra1
ble_else.22132:
	mov     $f0, $fg15
	jr      $ra1
be_else.22129:
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i21, $f14, $f15, $i22)
# $ra = $ra4
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i21, 0, bge_else.22133
bge_then.22133:
	load    [ext_reflections + $i21], $i23
	load    [$i23 + 1], $i24
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22134
bne_then.22134:
	bne     $i1, 99, be_else.22135
be_then.22135:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22136
be_then.22136:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22135
be_else.22136:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22137
be_then.22137:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22135
be_else.22137:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22138
be_then.22138:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22135
be_else.22138:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22139
be_then.22139:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22135
be_else.22139:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i15
.count move_args
	mov     $i24, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22135
be_else.22135:
.count move_args
	mov     $i24, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22140
be_then.22140:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22140
be_else.22140:
	bg      $fg7, $fg0, ble_else.22141
ble_then.22141:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22141
ble_else.22141:
	li      1, $i15
.count move_args
	mov     $i24, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
ble_cont.22141:
be_cont.22140:
be_cont.22135:
bne_cont.22134:
	bg      $fg7, $fc8, ble_else.22142
ble_then.22142:
	li      0, $i1
.count b_cont
	b       ble_cont.22142
ble_else.22142:
	bg      $fc13, $fg7, ble_else.22143
ble_then.22143:
	li      0, $i1
.count b_cont
	b       ble_cont.22143
ble_else.22143:
	li      1, $i1
ble_cont.22143:
ble_cont.22142:
	bne     $i1, 0, be_else.22144
be_then.22144:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.22144:
	load    [$i23 + 0], $i1
	add     $ig3, $ig3, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, be_else.22145
be_then.22145:
	li      0, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, be_else.22146
be_then.22146:
	load    [$i23 + 2], $f1
	load    [$i24 + 0], $i1
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
	ble     $f2, $f0, bg_cont.22147
bg_then.22147:
	fmul    $f2, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f2, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f2, $fg15, $f2
	fadd    $fg6, $f2, $fg6
bg_cont.22147:
	load    [$i22 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i22 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i22 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	sub     $i21, 1, $i21
	ble     $f1, $f0, trace_reflections.2915
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f15, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
be_else.22146:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.22145:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
bge_else.22133:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i25, $f16, $i26, $i27, $f17)
# $ra = $ra5
# [$i1 - $i29]
# [$f1 - $f17]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i25, 4, ble_else.22149
ble_then.22149:
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22150
bne_then.22150:
	bne     $i1, 99, be_else.22151
be_then.22151:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22152
be_then.22152:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22151
be_else.22152:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22153
be_then.22153:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22151
be_else.22153:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22154
be_then.22154:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22151
be_else.22154:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22155
be_then.22155:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22151
be_else.22155:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	li      5, $i15
.count move_args
	mov     $i26, $i17
	jal     solve_one_or_network.2875, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22151
be_else.22151:
.count move_args
	mov     $i26, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22156
be_then.22156:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22156
be_else.22156:
	bg      $fg7, $fg0, ble_else.22157
ble_then.22157:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       ble_cont.22157
ble_else.22157:
	li      1, $i15
.count move_args
	mov     $i26, $i17
	jal     solve_one_or_network.2875, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
ble_cont.22157:
be_cont.22156:
be_cont.22151:
bne_cont.22150:
	load    [$i27 + 2], $i28
	bg      $fg7, $fc8, ble_else.22158
ble_then.22158:
	li      0, $i1
.count b_cont
	b       ble_cont.22158
ble_else.22158:
	bg      $fc13, $fg7, ble_else.22159
ble_then.22159:
	li      0, $i1
.count b_cont
	b       ble_cont.22159
ble_else.22159:
	li      1, $i1
ble_cont.22159:
ble_cont.22158:
	bne     $i1, 0, be_else.22160
be_then.22160:
	add     $i0, -1, $i1
.count storer
	add     $i28, $i25, $tmp
	store   $i1, [$tmp + 0]
	bne     $i25, 0, be_else.22161
be_then.22161:
	jr      $ra5
be_else.22161:
	load    [$i26 + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [$i26 + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [$i26 + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_else.22162
ble_then.22162:
	jr      $ra5
ble_else.22162:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f16, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
be_else.22160:
	load    [ext_objects + $ig3], $i29
	load    [$i29 + 1], $i1
	bne     $i1, 1, be_else.22163
be_then.22163:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i1
	load    [$i26 + $i1], $f1
	bne     $f1, $f0, be_else.22164
be_then.22164:
	store   $f0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22163
be_else.22164:
	bg      $f1, $f0, ble_else.22165
ble_then.22165:
	store   $fc0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22163
ble_else.22165:
	store   $fc3, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22163
be_else.22163:
	bne     $i1, 2, be_else.22166
be_then.22166:
	load    [$i29 + 4], $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i29 + 4], $i1
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i29 + 4], $i1
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
.count b_cont
	b       be_cont.22166
be_else.22166:
	load    [$i29 + 3], $i1
	load    [$i29 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i29 + 5], $i2
	load    [$i2 + 0], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	load    [$i29 + 4], $i2
	load    [$i2 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i29 + 5], $i2
	load    [$i2 + 1], $f5
	fsub    $f4, $f5, $f4
	fmul    $f4, $f3, $f3
	load    [$i29 + 4], $i2
	load    [$i2 + 2], $f5
	load    [ext_intersection_point + 2], $f6
	load    [$i29 + 5], $i2
	load    [$i2 + 2], $f7
	fsub    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	bne     $i1, 0, be_else.22167
be_then.22167:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
.count b_cont
	b       be_cont.22167
be_else.22167:
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22167:
	load    [ext_nvector + 0], $f1
	load    [$i29 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, be_else.22168
be_then.22168:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.22168
be_else.22168:
	bne     $i1, 0, be_else.22169
be_then.22169:
	finv    $f2, $f2
.count b_cont
	b       be_cont.22169
be_else.22169:
	finv_n  $f2, $f2
be_cont.22169:
be_cont.22168:
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22166:
be_cont.22163:
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i29, $i1
	jal     utexture.2908, $ra1
	add     $ig3, $ig3, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i28, $i25, $tmp
	store   $i1, [$tmp + 0]
	load    [$i27 + 1], $i1
	load    [$i1 + $i25], $i1
	load    [ext_intersection_point + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i29 + 7], $i1
	load    [$i27 + 3], $i2
	load    [$i1 + 0], $f1
	fmul    $f1, $f16, $f14
.count storer
	add     $i2, $i25, $tmp
	bg      $fc4, $f1, ble_else.22170
ble_then.22170:
	li      1, $i1
	store   $i1, [$tmp + 0]
	load    [$i27 + 4], $i1
	load    [$i1 + $i25], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg15, [$i2 + 2]
	load    [$i1 + $i25], $i1
.count load_float
	load    [f.21539], $f1
.count load_float
	load    [f.21540], $f1
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
	load    [$i27 + 7], $i1
	load    [$i1 + $i25], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
.count b_cont
	b       ble_cont.22170
ble_else.22170:
	li      0, $i1
	store   $i1, [$tmp + 0]
ble_cont.22170:
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.21541], $f2
	load    [$i26 + 0], $f3
	fmul    $f3, $f1, $f4
	load    [$i26 + 1], $f5
	load    [ext_nvector + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    [$i26 + 2], $f5
	load    [ext_nvector + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f2, $f4, $f2
	fmul    $f2, $f1, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [$i26 + 0]
	load    [$i26 + 1], $f1
	load    [ext_nvector + 1], $f3
	fmul    $f2, $f3, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i26 + 1]
	load    [$i26 + 2], $f1
	load    [ext_nvector + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i26 + 2]
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22171
be_then.22171:
	li      0, $i1
.count b_cont
	b       be_cont.22171
be_else.22171:
	bne     $i1, 99, be_else.22172
be_then.22172:
	li      1, $i1
.count b_cont
	b       be_cont.22172
be_else.22172:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22173
be_then.22173:
	li      0, $i1
.count b_cont
	b       be_cont.22173
be_else.22173:
	bg      $fc8, $fg0, ble_else.22174
ble_then.22174:
	li      0, $i1
.count b_cont
	b       ble_cont.22174
ble_else.22174:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22175
be_then.22175:
	li      0, $i1
.count b_cont
	b       be_cont.22175
be_else.22175:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22176
be_then.22176:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22177
be_then.22177:
	li      0, $i1
.count b_cont
	b       be_cont.22176
be_else.22177:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22178
be_then.22178:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22179
be_then.22179:
	li      0, $i1
.count b_cont
	b       be_cont.22176
be_else.22179:
	li      1, $i1
.count b_cont
	b       be_cont.22176
be_else.22178:
	li      1, $i1
.count b_cont
	b       be_cont.22176
be_else.22176:
	li      1, $i1
be_cont.22176:
be_cont.22175:
ble_cont.22174:
be_cont.22173:
be_cont.22172:
	bne     $i1, 0, be_else.22180
be_then.22180:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22180
be_else.22180:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22181
be_then.22181:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22181
be_else.22181:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22182
be_then.22182:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22183
be_then.22183:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22182
be_else.22183:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22184
be_then.22184:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22185
be_then.22185:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22182
be_else.22185:
	li      1, $i1
.count b_cont
	b       be_cont.22182
be_else.22184:
	li      1, $i1
.count b_cont
	b       be_cont.22182
be_else.22182:
	li      1, $i1
be_cont.22182:
be_cont.22181:
be_cont.22180:
be_cont.22171:
	load    [$i29 + 7], $i2
	load    [$i2 + 1], $f1
	fmul    $f16, $f1, $f15
	bne     $i1, 0, be_cont.22186
be_then.22186:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f14, $f1
	load    [$i26 + 0], $f2
	fmul    $f2, $fg14, $f2
	load    [$i26 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i26 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, bg_cont.22187
bg_then.22187:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg15, $f1
	fadd    $fg6, $f1, $fg6
bg_cont.22187:
	ble     $f2, $f0, bg_cont.22188
bg_then.22188:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f15, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
bg_cont.22188:
be_cont.22186:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	sub     $ig4, 1, $i21
.count move_args
	mov     $i26, $i22
	jal     trace_reflections.2915, $ra4
	bg      $f16, $fc7, ble_else.22189
ble_then.22189:
	jr      $ra5
ble_else.22189:
	bge     $i25, 4, bl_cont.22190
bl_then.22190:
	add     $i25, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i28, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.22190:
	load    [$i29 + 2], $i1
	bne     $i1, 2, be_else.22191
be_then.22191:
	load    [$i29 + 7], $i1
	fadd    $f17, $fg7, $f17
	add     $i25, 1, $i25
	load    [$i1 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f16, $f1, $f16
	b       trace_ray.2920
be_else.22191:
	jr      $ra5
ble_else.22149:
	jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i21, $f14)
# $ra = $ra4
# [$i1 - $i21]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22192
bne_then.22192:
	bne     $i1, 99, be_else.22193
be_then.22193:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22194
be_then.22194:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22193
be_else.22194:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22195
be_then.22195:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22193
be_else.22195:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22196
be_then.22196:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22193
be_else.22196:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22197
be_then.22197:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22193
be_else.22197:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i15
.count move_args
	mov     $i21, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22193
be_else.22193:
.count move_args
	mov     $i21, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22198
be_then.22198:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22198
be_else.22198:
	bg      $fg7, $fg0, ble_else.22199
ble_then.22199:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22199
ble_else.22199:
	li      1, $i15
.count move_args
	mov     $i21, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
ble_cont.22199:
be_cont.22198:
be_cont.22193:
bne_cont.22192:
	bg      $fg7, $fc8, ble_else.22200
ble_then.22200:
	li      0, $i1
.count b_cont
	b       ble_cont.22200
ble_else.22200:
	bg      $fc13, $fg7, ble_else.22201
ble_then.22201:
	li      0, $i1
.count b_cont
	b       ble_cont.22201
ble_else.22201:
	li      1, $i1
ble_cont.22201:
ble_cont.22200:
	bne     $i1, 0, be_else.22202
be_then.22202:
	jr      $ra4
be_else.22202:
	load    [$i21 + 0], $i1
	load    [ext_objects + $ig3], $i17
	load    [$i17 + 1], $i2
	bne     $i2, 1, be_else.22203
be_then.22203:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i2
	load    [$i1 + $i2], $f1
	bne     $f1, $f0, be_else.22204
be_then.22204:
	store   $f0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22203
be_else.22204:
	bg      $f1, $f0, ble_else.22205
ble_then.22205:
	store   $fc0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22203
ble_else.22205:
	store   $fc3, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22203
be_else.22203:
	bne     $i2, 2, be_else.22206
be_then.22206:
	load    [$i17 + 4], $i1
	load    [$i1 + 0], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i17 + 4], $i1
	load    [$i1 + 1], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i17 + 4], $i1
	load    [$i1 + 2], $f1
	fneg    $f1, $f1
	store   $f1, [ext_nvector + 2]
.count b_cont
	b       be_cont.22206
be_else.22206:
	load    [$i17 + 3], $i1
	load    [$i17 + 4], $i2
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	load    [$i17 + 5], $i2
	load    [$i2 + 0], $f3
	fsub    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	load    [$i17 + 4], $i2
	load    [$i2 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	load    [$i17 + 5], $i2
	load    [$i2 + 1], $f5
	fsub    $f4, $f5, $f4
	fmul    $f4, $f3, $f3
	load    [$i17 + 4], $i2
	load    [$i2 + 2], $f5
	load    [ext_intersection_point + 2], $f6
	load    [$i17 + 5], $i2
	load    [$i2 + 2], $f7
	fsub    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	bne     $i1, 0, be_else.22207
be_then.22207:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
.count b_cont
	b       be_cont.22207
be_else.22207:
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22207:
	load    [ext_nvector + 0], $f1
	load    [$i17 + 6], $i1
	fmul    $f1, $f1, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [ext_nvector + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, be_else.22208
be_then.22208:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.22208
be_else.22208:
	bne     $i1, 0, be_else.22209
be_then.22209:
	finv    $f2, $f2
.count b_cont
	b       be_cont.22209
be_else.22209:
	finv_n  $f2, $f2
be_cont.22209:
be_cont.22208:
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22206:
be_cont.22203:
.count move_args
	mov     $i17, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22210
be_then.22210:
	li      0, $i1
.count b_cont
	b       be_cont.22210
be_else.22210:
	bne     $i1, 99, be_else.22211
be_then.22211:
	li      1, $i1
.count b_cont
	b       be_cont.22211
be_else.22211:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22212
be_then.22212:
	li      0, $i1
.count b_cont
	b       be_cont.22212
be_else.22212:
	bg      $fc8, $fg0, ble_else.22213
ble_then.22213:
	li      0, $i1
.count b_cont
	b       ble_cont.22213
ble_else.22213:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22214
be_then.22214:
	li      0, $i1
.count b_cont
	b       be_cont.22214
be_else.22214:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22215
be_then.22215:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22216
be_then.22216:
	li      0, $i1
.count b_cont
	b       be_cont.22215
be_else.22216:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22217
be_then.22217:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22218
be_then.22218:
	li      0, $i1
.count b_cont
	b       be_cont.22215
be_else.22218:
	li      1, $i1
.count b_cont
	b       be_cont.22215
be_else.22217:
	li      1, $i1
.count b_cont
	b       be_cont.22215
be_else.22215:
	li      1, $i1
be_cont.22215:
be_cont.22214:
ble_cont.22213:
be_cont.22212:
be_cont.22211:
	bne     $i1, 0, be_else.22219
be_then.22219:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22219
be_else.22219:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22220
be_then.22220:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22220
be_else.22220:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22221
be_then.22221:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22222
be_then.22222:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22221
be_else.22222:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22223
be_then.22223:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22224
be_then.22224:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22221
be_else.22224:
	li      1, $i1
.count b_cont
	b       be_cont.22221
be_else.22223:
	li      1, $i1
.count b_cont
	b       be_cont.22221
be_else.22221:
	li      1, $i1
be_cont.22221:
be_cont.22220:
be_cont.22219:
be_cont.22210:
	bne     $i1, 0, be_else.22225
be_then.22225:
	load    [$i17 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg14, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_cont.22226
ble_then.22226:
	mov     $f0, $f1
ble_cont.22226:
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
be_else.22225:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i22, $i23, $i24)
# $ra = $ra5
# [$i1 - $i24]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i24, 0, bge_else.22227
bge_then.22227:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22228
ble_then.22228:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.22229
bge_then.22229:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22230
ble_then.22230:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.22230:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.22229:
	jr      $ra5
ble_else.22228:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.22231
bge_then.22231:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22232
ble_then.22232:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.22232:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.22231:
	jr      $ra5
bge_else.22227:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i25, $i26)
# $ra = $ra6
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	load    [$i25 + 5], $i1
	load    [$i1 + $i26], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i25 + 7], $i1
	load    [$i25 + 1], $i2
	load    [$i25 + 6], $i3
	load    [$i1 + $i26], $i27
	load    [$i2 + $i26], $i28
	load    [$i3 + 0], $i29
	be      $i29, 0, bne_cont.22233
bne_then.22233:
	load    [ext_dirvecs + 0], $i22
	load    [$i28 + 0], $fg8
	load    [$i28 + 1], $fg9
	load    [$i28 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i28, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22234
ble_then.22234:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22234
ble_else.22234:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22234:
bne_cont.22233:
	be      $i29, 1, bne_cont.22235
bne_then.22235:
	load    [ext_dirvecs + 1], $i22
	load    [$i28 + 0], $fg8
	load    [$i28 + 1], $fg9
	load    [$i28 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i28, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22236
ble_then.22236:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22236
ble_else.22236:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22236:
bne_cont.22235:
	be      $i29, 2, bne_cont.22237
bne_then.22237:
	load    [ext_dirvecs + 2], $i22
	load    [$i28 + 0], $fg8
	load    [$i28 + 1], $fg9
	load    [$i28 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i28, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22238
ble_then.22238:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22238
ble_else.22238:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22238:
bne_cont.22237:
	be      $i29, 3, bne_cont.22239
bne_then.22239:
	load    [ext_dirvecs + 3], $i22
	load    [$i28 + 0], $fg8
	load    [$i28 + 1], $fg9
	load    [$i28 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i28, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22240
ble_then.22240:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22240
ble_else.22240:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22240:
bne_cont.22239:
	be      $i29, 4, bne_cont.22241
bne_then.22241:
	load    [ext_dirvecs + 4], $i22
	load    [$i28 + 0], $fg8
	load    [$i28 + 1], $fg9
	load    [$i28 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i28, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22242
ble_then.22242:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22242
ble_else.22242:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i27, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22242:
bne_cont.22241:
	load    [$i25 + 4], $i1
	load    [$i1 + $i26], $i1
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
# do_without_neighbors($i30, $i25)
# $ra = $ra7
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i25, 4, ble_else.22243
ble_then.22243:
	load    [$i30 + 2], $i26
	load    [$i26 + $i25], $i1
	bl      $i1, 0, bge_else.22244
bge_then.22244:
	load    [$i30 + 3], $i27
	load    [$i27 + $i25], $i1
	bne     $i1, 0, be_else.22245
be_then.22245:
	add     $i25, 1, $i31
	bg      $i31, 4, ble_else.22246
ble_then.22246:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.22247
bge_then.22247:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.22248
be_then.22248:
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.22248:
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.22247:
	jr      $ra7
ble_else.22246:
	jr      $ra7
be_else.22245:
	load    [$i30 + 5], $i1
	load    [$i1 + $i25], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i30 + 7], $i1
	load    [$i30 + 1], $i2
	load    [$i30 + 6], $i3
	load    [$i1 + $i25], $i28
	load    [$i2 + $i25], $i29
	load    [$i3 + 0], $i31
	be      $i31, 0, bne_cont.22249
bne_then.22249:
	load    [ext_dirvecs + 0], $i22
	load    [$i29 + 0], $fg8
	load    [$i29 + 1], $fg9
	load    [$i29 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i29, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i28 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i28 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22250
ble_then.22250:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22250
ble_else.22250:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22250:
bne_cont.22249:
	be      $i31, 1, bne_cont.22251
bne_then.22251:
	load    [ext_dirvecs + 1], $i22
	load    [$i29 + 0], $fg8
	load    [$i29 + 1], $fg9
	load    [$i29 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i29, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i28 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i28 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22252
ble_then.22252:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22252
ble_else.22252:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22252:
bne_cont.22251:
	be      $i31, 2, bne_cont.22253
bne_then.22253:
	load    [ext_dirvecs + 2], $i22
	load    [$i29 + 0], $fg8
	load    [$i29 + 1], $fg9
	load    [$i29 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i29, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i28 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i28 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22254
ble_then.22254:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22254
ble_else.22254:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22254:
bne_cont.22253:
	be      $i31, 3, bne_cont.22255
bne_then.22255:
	load    [ext_dirvecs + 3], $i22
	load    [$i29 + 0], $fg8
	load    [$i29 + 1], $fg9
	load    [$i29 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i29, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i28 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i28 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22256
ble_then.22256:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22256
ble_else.22256:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22256:
bne_cont.22255:
	be      $i31, 4, bne_cont.22257
bne_then.22257:
	load    [ext_dirvecs + 4], $i22
	load    [$i29 + 0], $fg8
	load    [$i29 + 1], $fg9
	load    [$i29 + 2], $fg10
	sub     $ig0, 1, $i1
.count move_args
	mov     $i29, $i2
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i28 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i28 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i28 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22258
ble_then.22258:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22258
ble_else.22258:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i28, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22258:
bne_cont.22257:
	load    [$i30 + 4], $i1
	load    [$i1 + $i25], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i25, 1, $i31
	bg      $i31, 4, ble_else.22259
ble_then.22259:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.22260
bge_then.22260:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.22261
be_then.22261:
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.22261:
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.22260:
	jr      $ra7
ble_else.22259:
	jr      $ra7
bge_else.22244:
	jr      $ra7
ble_else.22243:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i30)
# $ra = $ra7
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i30, 4, ble_else.22262
ble_then.22262:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i30], $i6
	bl      $i6, 0, bge_else.22263
bge_then.22263:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22264
be_then.22264:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22265
be_then.22265:
	sub     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22266
be_then.22266:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22267
be_then.22267:
	li      1, $i6
.count b_cont
	b       be_cont.22264
be_else.22267:
	li      0, $i6
.count b_cont
	b       be_cont.22264
be_else.22266:
	li      0, $i6
.count b_cont
	b       be_cont.22264
be_else.22265:
	li      0, $i6
.count b_cont
	b       be_cont.22264
be_else.22264:
	li      0, $i6
be_cont.22264:
	bne     $i6, 0, be_else.22268
be_then.22268:
	bg      $i30, 4, ble_else.22269
ble_then.22269:
	load    [$i4 + $i2], $i31
	load    [$i31 + 2], $i1
	load    [$i1 + $i30], $i1
	bl      $i1, 0, bge_else.22270
bge_then.22270:
	load    [$i31 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.22271
be_then.22271:
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
be_else.22271:
.count move_args
	mov     $i31, $i25
.count move_args
	mov     $i30, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
bge_else.22270:
	jr      $ra7
ble_else.22269:
	jr      $ra7
be_else.22268:
	load    [$i1 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.22272
be_then.22272:
	add     $i30, 1, $i30
	b       try_exploit_neighbors.2967
be_else.22272:
	load    [$i7 + 5], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
	load    [$i1 + $i30], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i30, 1, $i30
	b       try_exploit_neighbors.2967
bge_else.22263:
	jr      $ra7
ble_else.22262:
	jr      $ra7
.end try_exploit_neighbors

######################################################################
# write_ppm_header()
# $ra = $ra
# [$i2]
# []
# []
# []
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
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
######################################################################
.begin write_rgb_element
write_rgb_element.2976:
.count stack_store_ra
	store   $ra, [$sp - 1]
.count stack_move
	sub     $sp, 1, $sp
	li      255, $i4
	call    ext_int_of_float
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bg      $i1, $i4, ble_else.22273
ble_then.22273:
	bl      $i1, 0, bge_else.22274
bge_then.22274:
.count move_args
	mov     $i1, $i2
	b       ext_write
bge_else.22274:
	li      0, $i2
	b       ext_write
ble_else.22273:
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
# pretrace_diffuse_rays($i25, $i26)
# $ra = $ra6
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i26, 4, ble_else.22275
ble_then.22275:
	load    [$i25 + 2], $i27
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22276
bge_then.22276:
	load    [$i25 + 3], $i28
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22277
be_then.22277:
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.22278
ble_then.22278:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22279
bge_then.22279:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22280
be_then.22280:
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.22280:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 6], $i10
	load    [$i25 + 7], $i11
	load    [$i25 + 1], $i1
	load    [$i1 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i11 + $i26], $i23
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22281
ble_then.22281:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22281
ble_else.22281:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22281:
	load    [$i25 + 5], $i1
	load    [$i1 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.22279:
	jr      $ra6
ble_else.22278:
	jr      $ra6
be_else.22277:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 6], $i10
	load    [$i25 + 7], $i29
	load    [$i25 + 1], $i30
	load    [$i30 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i29 + $i26], $i23
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22282
ble_then.22282:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	jal     trace_diffuse_ray.2926, $ra4
.count b_cont
	b       ble_cont.22282
ble_else.22282:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	jal     trace_diffuse_ray.2926, $ra4
ble_cont.22282:
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i25 + 5], $i31
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.22283
ble_then.22283:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22284
bge_then.22284:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22285
be_then.22285:
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.22285:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 6], $i10
	load    [$i30 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i29 + $i26], $i23
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22286
ble_then.22286:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22286
ble_else.22286:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22286:
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.22284:
	jr      $ra6
ble_else.22283:
	jr      $ra6
bge_else.22276:
	jr      $ra6
ble_else.22275:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i32, $i33, $i34, $f18, $f1, $f2)
# $ra = $ra7
# [$i1 - $i35]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i33, 0, bge_else.22287
bge_then.22287:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $f2, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 1]
	load    [ext_screenx_dir + 0], $f4
	sub     $i33, 64, $i2
	call    ext_float_of_int
	fmul    $fg20, $f1, $f1
	fmul    $f1, $f4, $f2
	fadd    $f2, $f18, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
.count stack_load
	load    [$sp + 1], $i35
	store   $i35, [ext_ptrace_dirvec + 1]
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
	bne     $f2, $f0, be_else.22288
be_then.22288:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.22288
be_else.22288:
	finv    $f2, $f2
be_cont.22288:
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_ptrace_dirvec + 2]
	mov     $f0, $fg4
	mov     $f0, $fg5
	mov     $f0, $fg6
	load    [ext_viewpoint + 0], $fg17
	load    [ext_viewpoint + 1], $fg18
	load    [ext_viewpoint + 2], $fg19
	li      ext_ptrace_dirvec, $i26
	li      0, $i25
	load    [$i32 + $i33], $i27
.count move_args
	mov     $fc0, $f16
.count move_args
	mov     $f0, $f17
	jal     trace_ray.2920, $ra5
	load    [$i32 + $i33], $i1
	load    [$i1 + 0], $i1
	store   $fg4, [$i1 + 0]
	store   $fg5, [$i1 + 1]
	store   $fg6, [$i1 + 2]
	load    [$i32 + $i33], $i1
	load    [$i1 + 6], $i1
	store   $i34, [$i1 + 0]
	load    [$i32 + $i33], $i25
	load    [$i25 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, bge_cont.22289
bge_then.22289:
	load    [$i25 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22290
be_then.22290:
	li      1, $i26
	jal     pretrace_diffuse_rays.2980, $ra6
.count b_cont
	b       be_cont.22290
be_else.22290:
	load    [$i25 + 6], $i1
	load    [$i1 + 0], $i1
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 7], $i2
	load    [$i25 + 1], $i3
	load    [ext_dirvecs + $i1], $i22
	load    [$i2 + 0], $i23
	load    [$i3 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	load    [$i23 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i23 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [$i23 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.22291
ble_then.22291:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22291
ble_else.22291:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22291:
	load    [$i25 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i26
	jal     pretrace_diffuse_rays.2980, $ra6
be_cont.22290:
bge_cont.22289:
.count stack_move
	add     $sp, 2, $sp
	sub     $i33, 1, $i33
	add     $i34, 1, $i34
.count move_args
	mov     $i35, $f1
.count stack_load
	load    [$sp - 2], $f2
	bl      $i34, 5, pretrace_pixels.2983
	sub     $i34, 5, $i34
	b       pretrace_pixels.2983
bge_else.22287:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i32, $i33, $i34, $i35, $i36)
# $ra = $ra8
# [$i1 - $i36]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i32, ble_else.22293
ble_then.22293:
	jr      $ra8
ble_else.22293:
	load    [$i35 + $i32], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i33, 1, $i2
	bg      $i1, $i2, ble_else.22294
ble_then.22294:
	li      0, $i1
.count b_cont
	b       ble_cont.22294
ble_else.22294:
	bg      $i33, 0, ble_else.22295
ble_then.22295:
	li      0, $i1
.count b_cont
	b       ble_cont.22295
ble_else.22295:
	li      128, $i1
	add     $i32, 1, $i2
	bg      $i1, $i2, ble_else.22296
ble_then.22296:
	li      0, $i1
.count b_cont
	b       ble_cont.22296
ble_else.22296:
	bg      $i32, 0, ble_else.22297
ble_then.22297:
	li      0, $i1
.count b_cont
	b       ble_cont.22297
ble_else.22297:
	li      1, $i1
ble_cont.22297:
ble_cont.22296:
ble_cont.22295:
ble_cont.22294:
	li      0, $i26
	bne     $i1, 0, be_else.22298
be_then.22298:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22298
bge_then.22299:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22300
be_then.22300:
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22298
be_else.22300:
.count move_args
	mov     $i30, $i25
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22298
be_else.22298:
	load    [$i35 + $i32], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bge_cont.22301
bge_then.22301:
	load    [$i34 + $i32], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22302
be_then.22302:
	load    [$i36 + $i32], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22303
be_then.22303:
	sub     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22304
be_then.22304:
	add     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22305
be_then.22305:
	li      1, $i2
.count b_cont
	b       be_cont.22302
be_else.22305:
	li      0, $i2
.count b_cont
	b       be_cont.22302
be_else.22304:
	li      0, $i2
.count b_cont
	b       be_cont.22302
be_else.22303:
	li      0, $i2
.count b_cont
	b       be_cont.22302
be_else.22302:
	li      0, $i2
be_cont.22302:
	bne     $i2, 0, be_else.22306
be_then.22306:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22306
bge_then.22307:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22308
be_then.22308:
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22306
be_else.22308:
.count move_args
	mov     $i30, $i25
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22306
be_else.22306:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i36, $i5
.count move_args
	mov     $i35, $i4
.count move_args
	mov     $i32, $i2
	li      1, $i30
	bne     $i1, 0, be_else.22309
be_then.22309:
.count move_args
	mov     $i34, $i3
	jal     try_exploit_neighbors.2967, $ra7
.count b_cont
	b       be_cont.22309
be_else.22309:
	load    [$i3 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i32, 1, $i1
	load    [$i35 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i35 + $i32], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i32, 1, $i1
	load    [$i35 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i36 + $i32], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i35 + $i32], $i1
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
	mov     $i34, $i3
	jal     try_exploit_neighbors.2967, $ra7
be_cont.22309:
be_cont.22306:
bge_cont.22301:
be_cont.22298:
	call    write_rgb.2978
	add     $i32, 1, $i32
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i37, $i38, $i39, $i40, $i41)
# $ra = $ra9
# [$i1 - $i41]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i37, ble_else.22310
ble_then.22310:
	jr      $ra9
ble_else.22310:
	bge     $i37, 127, bl_cont.22311
bl_then.22311:
	add     $i37, 1, $i1
	sub     $i1, 64, $i2
	call    ext_float_of_int
	fmul    $fg20, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f18
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg22, $f3
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg23, $f2
	li      127, $i33
.count move_args
	mov     $i40, $i32
.count move_args
	mov     $i41, $i34
.count move_args
	mov     $f3, $f1
	jal     pretrace_pixels.2983, $ra7
bl_cont.22311:
	li      0, $i32
.count move_args
	mov     $i37, $i33
.count move_args
	mov     $i38, $i34
.count move_args
	mov     $i39, $i35
.count move_args
	mov     $i40, $i36
	jal     scan_pixel.2994, $ra8
	add     $i37, 1, $i37
	add     $i41, 2, $i41
.count move_args
	mov     $i38, $tmp
.count move_args
	mov     $i39, $i38
.count move_args
	mov     $i40, $i39
.count move_args
	mov     $tmp, $i40
	bl      $i41, 5, scan_line.3000
	sub     $i41, 5, $i41
	b       scan_line.3000
.end scan_line

######################################################################
# $i1 = create_float5x3array()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
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
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i13, 0, bge_else.22313
bge_then.22313:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	sub     $i13, 1, $i13
	b       init_line_elements.3010
bge_else.22313:
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
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i1, 5, bge_else.22314
bge_then.22314:
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
bge_else.22314:
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc7, $f1
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
	fadd    $f1, $fc7, $f1
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
# [$f1 - $f15]
# []
# []
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i5, 0, bge_else.22315
bge_then.22315:
	li      0, $i1
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f15
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
	add     $i7, 2, $i8
	fadd    $f15, $fc7, $f9
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
	bl      $i5, 0, bge_else.22316
bge_then.22316:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.22317
bge_then.22317:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.22317
bge_else.22317:
	mov     $i2, $i6
bge_cont.22317:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f15
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
	fadd    $f15, $fc7, $f9
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
	bl      $i5, 0, bge_else.22318
bge_then.22318:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.22319
bge_then.22319:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.22319
bge_else.22319:
	mov     $i2, $i6
bge_cont.22319:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f15
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
	fadd    $f15, $fc7, $f9
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
	bl      $i5, 0, bge_else.22320
bge_then.22320:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.22321
bge_then.22321:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.22321
bge_else.22321:
	mov     $i2, $i6
bge_cont.22321:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f15
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
	fadd    $f15, $fc7, $f9
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
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
	sub     $i6, 5, $i6
	b       calc_dirvecs.3028
bge_else.22320:
	jr      $ra2
bge_else.22318:
	jr      $ra2
bge_else.22316:
	jr      $ra2
bge_else.22315:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f18]
# []
# []
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i9, 0, bge_else.22323
bge_then.22323:
.count stack_move
	sub     $sp, 1, $sp
	li      0, $i1
	li      4, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f16
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
	fsub    $f1, $fc11, $f15
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f9
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i11, 2, $i5
	fadd    $f14, $fc7, $f17
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f17, $f9
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bge_else.22324
bge_then.22324:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.22324
bge_else.22324:
	mov     $i2, $i6
bge_cont.22324:
	li      3, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f18
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f18, $f9
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f14, $fc7, $f9
.count stack_store
	store   $f9, [$sp + 0]
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_cont.22325
bge_then.22325:
	sub     $i2, 5, $i2
bge_cont.22325:
	mov     $i2, $i6
	li      2, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f14, $fc7, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      1, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bge_cont.22326
bge_then.22326:
	sub     $i1, 5, $i1
bge_cont.22326:
	mov     $i1, $i6
.count move_args
	mov     $f15, $f14
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	sub     $i9, 1, $i9
	bl      $i9, 0, bge_else.22327
bge_then.22327:
	add     $i10, 2, $i1
	bl      $i1, 5, bge_cont.22328
bge_then.22328:
	sub     $i1, 5, $i1
bge_cont.22328:
	mov     $i1, $i10
	add     $i11, 4, $i11
	li      0, $i1
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
	fsub    $f1, $fc11, $f14
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f9
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
	mov     $f17, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bge_cont.22329
bge_then.22329:
	sub     $i2, 5, $i2
bge_cont.22329:
	mov     $i2, $i6
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f18, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
.count stack_load
	load    [$sp + 0], $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22330
bge_then.22330:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22330
bge_else.22330:
	mov     $i1, $i6
bge_cont.22330:
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
.count stack_move
	add     $sp, 1, $sp
	sub     $i9, 1, $i9
	add     $i10, 2, $i10
	add     $i11, 4, $i11
	bl      $i10, 5, calc_dirvec_rows.3033
	sub     $i10, 5, $i10
	b       calc_dirvec_rows.3033
bge_else.22327:
.count stack_move
	add     $sp, 1, $sp
	jr      $ra3
bge_else.22323:
	jr      $ra3
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
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
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i6, 0, bge_else.22332
bge_then.22332:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i6
	b       create_dirvec_elements.3039
bge_else.22332:
	jr      $ra2
.end create_dirvec_elements

######################################################################
# create_dirvecs($i7)
# $ra = $ra3
# [$i1 - $i7]
# [$f2]
# []
# []
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i7, 0, bge_else.22333
bge_then.22333:
	jal     create_dirvec.3037, $ra1
	li      120, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i7]
	load    [ext_dirvecs + $i7], $i5
	li      118, $i6
	jal     create_dirvec_elements.3039, $ra2
	sub     $i7, 1, $i7
	b       create_dirvecs.3042
bge_else.22333:
	jr      $ra3
.end create_dirvecs

######################################################################
# init_dirvec_constants($i11, $i12)
# $ra = $ra3
# [$i1 - $i12]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i12, 0, bge_else.22334
bge_then.22334:
	load    [$i11 + $i12], $i8
	jal     setup_dirvec_constants.2829, $ra2
	sub     $i12, 1, $i12
	b       init_dirvec_constants.3044
bge_else.22334:
	jr      $ra3
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i13)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i13, 0, bge_else.22335
bge_then.22335:
	load    [ext_dirvecs + $i13], $i11
	li      119, $i12
	jal     init_dirvec_constants.3044, $ra3
	sub     $i13, 1, $i13
	b       init_vecset_constants.3047
bge_else.22335:
	jr      $ra4
.end init_vecset_constants

######################################################################
# init_dirvecs()
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f18]
# []
# []
######################################################################
.begin init_dirvecs
init_dirvecs.3049:
	li      4, $i7
	jal     create_dirvecs.3042, $ra3
	li      0, $i5
	li      0, $i7
	li      0, $i1
	li      4, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
	li      9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
	fsub    $f1, $fc11, $f15
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	li      2, $i6
	fadd    $f14, $fc7, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	li      1, $i5
	li      3, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i7, $i4
	jal     calc_dirvec.3020, $ra1
	li      0, $i1
	fadd    $f14, $fc7, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f10
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	jal     calc_dirvec.3020, $ra1
	li      2, $i5
	li      2, $i6
.count move_args
	mov     $f15, $f14
	jal     calc_dirvecs.3028, $ra2
	li      8, $i9
	li      2, $i10
	li      4, $i11
	jal     calc_dirvec_rows.3033, $ra3
	li      4, $i13
	b       init_vecset_constants.3047
.end init_dirvecs

######################################################################
# add_reflection($i11, $i12, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i13]
# [$f1 - $f9]
# []
# []
######################################################################
.begin add_reflection
add_reflection.3051:
	jal     create_dirvec.3037, $ra1
.count move_ret
	mov     $i1, $i13
	load    [$i13 + 0], $i1
	store   $f1, [$i1 + 0]
	store   $f3, [$i1 + 1]
	store   $f4, [$i1 + 2]
.count move_args
	mov     $i13, $i8
	jal     setup_dirvec_constants.2829, $ra2
	mov     $hp, $i1
	add     $hp, 3, $hp
	store   $f9, [$i1 + 2]
	store   $i13, [$i1 + 1]
	store   $i12, [$i1 + 0]
	store   $i1, [ext_reflections + $i11]
	jr      $ra3
.end add_reflection

######################################################################
# setup_rect_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig4]
# []
######################################################################
.begin setup_rect_reflection
setup_rect_reflection.3058:
	load    [$i2 + 7], $i2
	add     $i1, $i1, $i1
	add     $i1, $i1, $i14
	add     $i14, 1, $i12
	load    [$i2 + 0], $f1
	fsub    $fc0, $f1, $f10
	fneg    $fg12, $f11
	fneg    $fg13, $f12
.count move_args
	mov     $ig4, $i11
.count move_args
	mov     $f10, $f9
.count move_args
	mov     $fg14, $f1
.count move_args
	mov     $f11, $f3
.count move_args
	mov     $f12, $f4
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $i11
	add     $i14, 2, $i12
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
	add     $ig4, 2, $i11
	add     $i14, 3, $i12
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
# [$i1 - $i13]
# [$f1 - $f9]
# [$ig4]
# []
######################################################################
.begin setup_surface_reflection
setup_surface_reflection.3061:
	load    [$i2 + 4], $i3
	load    [$i2 + 4], $i4
	load    [$i2 + 7], $i2
	load    [$i3 + 0], $f1
	fmul    $fc10, $f1, $f2
	fmul    $fg14, $f1, $f1
	load    [$i4 + 1], $f3
	fmul    $fg12, $f3, $f4
	fadd    $f1, $f4, $f1
	load    [$i4 + 2], $f4
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
	add     $i1, 1, $i12
.count move_args
	mov     $ig4, $i11
.count move_args
	mov     $f2, $f1
	jal     add_reflection.3051, $ra3
	add     $ig4, 1, $ig4
	jr      $ra4
.end setup_surface_reflection

######################################################################
# setup_reflections($i1)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig4]
# []
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i1, 0, bge_else.22336
bge_then.22336:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, be_else.22337
be_then.22337:
	load    [$i2 + 7], $i3
	load    [$i3 + 0], $f1
	bg      $fc0, $f1, ble_else.22338
ble_then.22338:
	jr      $ra4
ble_else.22338:
	load    [$i2 + 1], $i3
	be      $i3, 1, setup_rect_reflection.3058
	be      $i3, 2, setup_surface_reflection.3061
	jr      $ra4
be_else.22337:
	jr      $ra4
bge_else.22336:
	jr      $ra4
.end setup_reflections

######################################################################
# rt()
# $ra = $ra9
# [$i1 - $i41]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
######################################################################
.begin rt
rt.3066:
.count load_float
	load    [f.21564], $f4
	li      128, $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $fg20
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i38
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i39
	jal     create_pixelline.3013, $ra3
.count move_ret
	mov     $i1, $i40
	jal     read_parameter.2731, $ra3
	call    write_ppm_header.2974
	jal     init_dirvecs.3049, $ra4
	li      ext_light_dirvec, $i8
	load    [ext_light_dirvec + 0], $i1
	store   $fg14, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	sub     $ig0, 1, $i1
	jal     setup_reflections.3064, $ra4
	li      0, $i34
	li      127, $i33
	add     $i0, -64, $i2
	call    ext_float_of_int
	fmul    $fg20, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f18
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg22, $f3
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg23, $f2
.count move_args
	mov     $i39, $i32
.count move_args
	mov     $f3, $f1
	jal     pretrace_pixels.2983, $ra7
	li      0, $i37
	li      2, $i41
	b       scan_line.3000
.end rt

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i41]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
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
	load    [ext_scan_pitch + 0], $fg20
	load    [ext_screenz_dir + 0], $fg21
	load    [ext_screenz_dir + 1], $fg22
	load    [ext_screenz_dir + 2], $fg23
	load    [ext_screeny_dir + 0], $fg24
	load    [f.21519 + 0], $fc0
	load    [f.21543 + 0], $fc1
	load    [f.21542 + 0], $fc2
	load    [f.21518 + 0], $fc3
	load    [f.21520 + 0], $fc4
	load    [f.21545 + 0], $fc5
	load    [f.21544 + 0], $fc6
	load    [f.21532 + 0], $fc7
	load    [f.21523 + 0], $fc8
	load    [f.21530 + 0], $fc9
	load    [f.21517 + 0], $fc10
	load    [f.21556 + 0], $fc11
	load    [f.21555 + 0], $fc12
	load    [f.21538 + 0], $fc13
	load    [f.21537 + 0], $fc14
	load    [f.21527 + 0], $fc15
	load    [f.21522 + 0], $fc16
	load    [f.21501 + 0], $fc17
	load    [f.21528 + 0], $fc18
	load    [f.21526 + 0], $fc19
	jal     rt.3066, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
.end main
