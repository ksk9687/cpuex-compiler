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
f.21671:	.float  -6.4000000000E+01
f.21663:	.float  -5.0000000000E-01
f.21662:	.float  7.0000000000E-01
f.21661:	.float  -3.0000000000E-01
f.21660:	.float  -1.0000000000E-01
f.21659:	.float  2.0000000000E-01
f.21658:	.float  9.0000000000E-01
f.21648:	.float  1.5000000000E+02
f.21647:	.float  -1.5000000000E+02
f.21646:	.float  6.6666666667E-03
f.21645:	.float  -6.6666666667E-03
f.21644:	.float  -2.0000000000E+00
f.21643:	.float  3.9062500000E-03
f.21642:	.float  2.5600000000E+02
f.21641:	.float  1.0000000000E+08
f.21640:	.float  1.0000000000E+09
f.21639:	.float  1.0000000000E+01
f.21638:	.float  5.0000000000E-02
f.21637:	.float  2.0000000000E+01
f.21636:	.float  2.5000000000E-01
f.21635:	.float  2.5500000000E+02
f.21634:	.float  1.0000000000E-01
f.21633:	.float  8.5000000000E+02
f.21632:	.float  1.5000000000E-01
f.21631:	.float  9.5492964444E+00
f.21630:	.float  3.1830988148E-01
f.21629:	.float  3.1415927000E+00
f.21628:	.float  3.0000000000E+01
f.21627:	.float  1.5000000000E+01
f.21626:	.float  1.0000000000E-04
f.21625:	.float  -1.0000000000E-01
f.21624:	.float  1.0000000000E-02
f.21623:	.float  -2.0000000000E-01
f.21622:	.float  5.0000000000E-01
f.21621:	.float  1.0000000000E+00
f.21620:	.float  -1.0000000000E+00
f.21619:	.float  2.0000000000E+00
f.21605:	.float  -2.0000000000E+02
f.21604:	.float  2.0000000000E+02
f.21603:	.float  1.7453293000E-02

######################################################################
# read_screen_settings()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f11]
# []
# [$fg20 - $fg24]
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
	load    [f.21604], $f2
	fmul    $f10, $f1, $f3
	fmul    $f3, $f2, $fg22
.count load_float
	load    [f.21605], $f3
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
######################################################################
.begin read_nth_object
read_nth_object.2719:
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	bne     $i7, -1, be_else.21786
be_then.21786:
	li      0, $i1
	jr      $ra1
be_else.21786:
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
	be      $i10, 0, bne_cont.21787
bne_then.21787:
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 0]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 1]
	call    ext_read_float
	fmul    $f1, $fc16, $f1
	store   $f1, [$i15 + 2]
bne_cont.21787:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	bg      $f0, $f3, ble_else.21788
ble_then.21788:
	li      0, $i2
.count b_cont
	b       ble_cont.21788
ble_else.21788:
	li      1, $i2
ble_cont.21788:
	bne     $i8, 2, be_else.21789
be_then.21789:
	li      1, $i3
.count b_cont
	b       be_cont.21789
be_else.21789:
	mov     $i2, $i3
be_cont.21789:
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
	bne     $i8, 3, be_else.21790
be_then.21790:
	load    [$i11 + 0], $f1
	bne     $f1, $f0, be_else.21791
be_then.21791:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21791
be_else.21791:
	bne     $f1, $f0, be_else.21792
be_then.21792:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21792
be_else.21792:
	bg      $f1, $f0, ble_else.21793
ble_then.21793:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21793
ble_else.21793:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21793:
be_cont.21792:
be_cont.21791:
	store   $f1, [$i11 + 0]
	load    [$i11 + 1], $f1
	bne     $f1, $f0, be_else.21794
be_then.21794:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21794
be_else.21794:
	bne     $f1, $f0, be_else.21795
be_then.21795:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.21795
be_else.21795:
	bg      $f1, $f0, ble_else.21796
ble_then.21796:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.21796
ble_else.21796:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.21796:
be_cont.21795:
be_cont.21794:
	store   $f1, [$i11 + 1]
	load    [$i11 + 2], $f1
	bne     $f1, $f0, be_else.21797
be_then.21797:
	store   $f0, [$i11 + 2]
	bne     $i10, 0, be_else.21798
be_then.21798:
	li      1, $i1
	jr      $ra1
be_else.21798:
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
be_else.21797:
	fmul    $f1, $f1, $f2
	finv    $f2, $f2
	bne     $f1, $f0, be_else.21799
be_then.21799:
	mov     $f0, $f1
.count b_cont
	b       be_cont.21799
be_else.21799:
	bg      $f1, $f0, ble_else.21800
ble_then.21800:
	mov     $fc3, $f1
.count b_cont
	b       ble_cont.21800
ble_else.21800:
	mov     $fc0, $f1
ble_cont.21800:
be_cont.21799:
	fmul    $f1, $f2, $f1
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21801
be_then.21801:
	li      1, $i1
	jr      $ra1
be_else.21801:
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
be_else.21790:
	bne     $i8, 2, be_else.21802
be_then.21802:
	load    [$i11 + 2], $f1
	fmul    $f1, $f1, $f1
	load    [$i11 + 1], $f2
	fmul    $f2, $f2, $f2
	load    [$i11 + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.21803
be_then.21803:
	li      1, $i1
.count b_cont
	b       be_cont.21803
be_else.21803:
	li      0, $i1
be_cont.21803:
	bne     $f1, $f0, be_else.21804
be_then.21804:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.21804
be_else.21804:
	bne     $i1, 0, be_else.21805
be_then.21805:
	finv    $f1, $f1
.count b_cont
	b       be_cont.21805
be_else.21805:
	finv_n  $f1, $f1
be_cont.21805:
be_cont.21804:
	load    [$i11 + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i11 + 0]
	load    [$i11 + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [$i11 + 1]
	load    [$i11 + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [$i11 + 2]
	bne     $i10, 0, be_else.21806
be_then.21806:
	li      1, $i1
	jr      $ra1
be_else.21806:
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
be_else.21802:
	bne     $i10, 0, be_else.21807
be_then.21807:
	li      1, $i1
	jr      $ra1
be_else.21807:
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
######################################################################
.begin read_object
read_object.2721:
	bl      $i16, 60, bge_else.21808
bge_then.21808:
	jr      $ra2
bge_else.21808:
.count move_args
	mov     $i16, $i6
	jal     read_nth_object.2719, $ra1
	bne     $i1, 0, be_else.21809
be_then.21809:
	mov     $i16, $ig0
	jr      $ra2
be_else.21809:
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
	bne     $i1, -1, be_else.21810
be_then.21810:
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	add     $i0, -1, $i3
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
	b       ext_create_array_int
be_else.21810:
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
	bne     $i2, -1, be_else.21811
be_then.21811:
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
be_else.21811:
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
	bne     $i2, -1, be_else.21812
be_then.21812:
	jr      $ra1
be_else.21812:
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
# [$f1 - $f15]
# []
# [$fg0]
######################################################################
.begin solver
solver.2773:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 1], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 5], $i6
	load    [$i4 + 2], $f1
	fsub    $fg19, $f1, $f1
	load    [$i5 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i6 + 0], $f3
	fsub    $fg17, $f3, $f3
	bne     $i3, 1, be_else.21813
be_then.21813:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.21814
be_then.21814:
	li      0, $i3
.count b_cont
	b       be_cont.21814
be_else.21814:
	finv    $f4, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 0], $f6
	bg      $f0, $f4, ble_else.21815
ble_then.21815:
	li      0, $i4
.count b_cont
	b       ble_cont.21815
ble_else.21815:
	li      1, $i4
ble_cont.21815:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.21816
bne_then.21816:
	bne     $i4, 0, be_else.21817
be_then.21817:
	li      1, $i4
.count b_cont
	b       be_cont.21817
be_else.21817:
	li      0, $i4
be_cont.21817:
bne_cont.21816:
	bne     $i4, 0, be_else.21818
be_then.21818:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21818
be_else.21818:
	mov     $f6, $f4
be_cont.21818:
	fsub    $f4, $f3, $f4
	fmul    $f4, $f5, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i3 + 1], $f6
	bg      $f6, $f5, ble_else.21819
ble_then.21819:
	li      0, $i3
.count b_cont
	b       ble_cont.21819
ble_else.21819:
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i3 + 2], $f6
	bg      $f6, $f5, ble_else.21820
ble_then.21820:
	li      0, $i3
.count b_cont
	b       ble_cont.21820
ble_else.21820:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21820:
ble_cont.21819:
be_cont.21814:
	bne     $i3, 0, be_else.21821
be_then.21821:
	load    [$i2 + 1], $f4
	bne     $f4, $f0, be_else.21822
be_then.21822:
	li      0, $i3
.count b_cont
	b       be_cont.21822
be_else.21822:
	finv    $f4, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f6
	bg      $f0, $f4, ble_else.21823
ble_then.21823:
	li      0, $i4
.count b_cont
	b       ble_cont.21823
ble_else.21823:
	li      1, $i4
ble_cont.21823:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.21824
bne_then.21824:
	bne     $i4, 0, be_else.21825
be_then.21825:
	li      1, $i4
.count b_cont
	b       be_cont.21825
be_else.21825:
	li      0, $i4
be_cont.21825:
bne_cont.21824:
	bne     $i4, 0, be_else.21826
be_then.21826:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21826
be_else.21826:
	mov     $f6, $f4
be_cont.21826:
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	load    [$i2 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i3 + 2], $f6
	bg      $f6, $f5, ble_else.21827
ble_then.21827:
	li      0, $i3
.count b_cont
	b       ble_cont.21827
ble_else.21827:
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i3 + 0], $f6
	bg      $f6, $f5, ble_else.21828
ble_then.21828:
	li      0, $i3
.count b_cont
	b       ble_cont.21828
ble_else.21828:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.21828:
ble_cont.21827:
be_cont.21822:
	bne     $i3, 0, be_else.21829
be_then.21829:
	load    [$i2 + 2], $f4
	bne     $f4, $f0, be_else.21830
be_then.21830:
	li      0, $i1
	ret
be_else.21830:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	finv    $f4, $f5
	load    [$i3 + 2], $f6
	bg      $f0, $f4, ble_else.21831
ble_then.21831:
	li      0, $i4
.count b_cont
	b       ble_cont.21831
ble_else.21831:
	li      1, $i4
ble_cont.21831:
	bne     $i1, 0, be_else.21832
be_then.21832:
	mov     $i4, $i1
.count b_cont
	b       be_cont.21832
be_else.21832:
	bne     $i4, 0, be_else.21833
be_then.21833:
	li      1, $i1
.count b_cont
	b       be_cont.21833
be_else.21833:
	li      0, $i1
be_cont.21833:
be_cont.21832:
	bne     $i1, 0, be_else.21834
be_then.21834:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.21834
be_else.21834:
	mov     $f6, $f4
be_cont.21834:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f5, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i3 + 0], $f4
	bg      $f4, $f3, ble_else.21835
ble_then.21835:
	li      0, $i1
	ret
ble_else.21835:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i3 + 1], $f3
	bg      $f3, $f2, ble_else.21836
ble_then.21836:
	li      0, $i1
	ret
ble_else.21836:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21829:
	li      2, $i1
	ret
be_else.21821:
	li      1, $i1
	ret
be_else.21813:
	load    [$i2 + 2], $f5
	bne     $i3, 2, be_else.21837
be_then.21837:
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
	bg      $f5, $f0, ble_else.21838
ble_then.21838:
	li      0, $i1
	ret
ble_else.21838:
	finv    $f5, $f5
	fmul    $f4, $f1, $f1
	fmul    $f6, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f5, $fg0
	li      1, $i1
	ret
be_else.21837:
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 4], $i6
	load    [$i1 + 3], $i7
	load    [$i4 + 2], $f4
	fmul    $f5, $f5, $f6
	fmul    $f6, $f4, $f6
	load    [$i5 + 1], $f7
	load    [$i2 + 1], $f8
	fmul    $f8, $f8, $f9
	fmul    $f9, $f7, $f9
	load    [$i6 + 0], $f10
	load    [$i2 + 0], $f11
	fmul    $f11, $f11, $f12
	fmul    $f12, $f10, $f12
	fadd    $f12, $f9, $f9
	fadd    $f9, $f6, $f6
	be      $i7, 0, bne_cont.21839
bne_then.21839:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f9
	fmul    $f11, $f8, $f12
	fmul    $f12, $f9, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f12
	fmul    $f5, $f11, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f13
	fmul    $f8, $f5, $f14
	fmul    $f14, $f13, $f13
	fadd    $f6, $f13, $f6
	fadd    $f6, $f12, $f6
	fadd    $f6, $f9, $f6
bne_cont.21839:
	bne     $f6, $f0, be_else.21840
be_then.21840:
	li      0, $i1
	ret
be_else.21840:
	load    [$i1 + 3], $i2
	load    [$i1 + 3], $i4
	fmul    $f1, $f1, $f9
	fmul    $f9, $f4, $f9
	fmul    $f2, $f2, $f12
	fmul    $f12, $f7, $f12
	fmul    $f3, $f3, $f13
	fmul    $f13, $f10, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f9, $f9
	be      $i2, 0, bne_cont.21841
bne_then.21841:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f12
	fmul    $f3, $f2, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f13
	fmul    $f1, $f3, $f14
	fmul    $f14, $f13, $f13
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f14
	fmul    $f2, $f1, $f15
	fmul    $f15, $f14, $f14
	fadd    $f9, $f14, $f9
	fadd    $f9, $f13, $f9
	fadd    $f9, $f12, $f9
bne_cont.21841:
	bne     $i3, 3, be_cont.21842
be_then.21842:
	fsub    $f9, $fc0, $f9
be_cont.21842:
	fmul    $f6, $f9, $f9
	fmul    $f5, $f1, $f12
	fmul    $f12, $f4, $f4
	fmul    $f8, $f2, $f12
	fmul    $f12, $f7, $f7
	fmul    $f11, $f3, $f12
	fmul    $f12, $f10, $f10
	fadd    $f10, $f7, $f7
	fadd    $f7, $f4, $f4
	bne     $i4, 0, be_else.21843
be_then.21843:
	mov     $f4, $f1
.count b_cont
	b       be_cont.21843
be_else.21843:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f7
	fmul    $f8, $f3, $f10
	fmul    $f11, $f2, $f12
	fadd    $f12, $f10, $f10
	fmul    $f10, $f7, $f7
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f10
	fmul    $f5, $f3, $f3
	fmul    $f11, $f1, $f11
	fadd    $f11, $f3, $f3
	fmul    $f3, $f10, $f3
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f10
	fmul    $f8, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $f3, $f1
	fadd    $f1, $f7, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
be_cont.21843:
	fmul    $f1, $f1, $f2
	fsub    $f2, $f9, $f2
	bg      $f2, $f0, ble_else.21844
ble_then.21844:
	li      0, $i1
	ret
ble_else.21844:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	finv    $f6, $f3
	bne     $i1, 0, be_else.21845
be_then.21845:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
be_else.21845:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
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
	load    [$i2 + 1], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 5], $i7
	load    [$i4 + $i1], $i1
	load    [$i5 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i7 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	bne     $i3, 1, be_else.21846
be_then.21846:
	load    [ext_light_dirvec + 0], $i3
	load    [$i2 + 4], $i4
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.21847
ble_then.21847:
	li      0, $i4
.count b_cont
	b       ble_cont.21847
ble_else.21847:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.21848
ble_then.21848:
	li      0, $i4
.count b_cont
	b       ble_cont.21848
ble_else.21848:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21849
be_then.21849:
	li      0, $i4
.count b_cont
	b       be_cont.21849
be_else.21849:
	li      1, $i4
be_cont.21849:
ble_cont.21848:
ble_cont.21847:
	bne     $i4, 0, be_else.21850
be_then.21850:
	load    [$i2 + 4], $i4
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i4 + 0], $f7
	bg      $f7, $f5, ble_else.21851
ble_then.21851:
	li      0, $i2
.count b_cont
	b       ble_cont.21851
ble_else.21851:
	load    [$i2 + 4], $i2
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.21852
ble_then.21852:
	li      0, $i2
.count b_cont
	b       ble_cont.21852
ble_else.21852:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.21853
be_then.21853:
	li      0, $i2
.count b_cont
	b       be_cont.21853
be_else.21853:
	li      1, $i2
be_cont.21853:
ble_cont.21852:
ble_cont.21851:
	bne     $i2, 0, be_else.21854
be_then.21854:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.21855
ble_then.21855:
	li      0, $i1
	ret
ble_else.21855:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.21856
ble_then.21856:
	li      0, $i1
	ret
ble_else.21856:
	load    [$i1 + 5], $f2
	bne     $f2, $f0, be_else.21857
be_then.21857:
	li      0, $i1
	ret
be_else.21857:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21854:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.21850:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.21846:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.21858
be_then.21858:
	bg      $f0, $f4, ble_else.21859
ble_then.21859:
	li      0, $i1
	ret
ble_else.21859:
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
be_else.21858:
	bne     $f4, $f0, be_else.21860
be_then.21860:
	li      0, $i1
	ret
be_else.21860:
	load    [$i2 + 4], $i4
	load    [$i2 + 4], $i5
	load    [$i2 + 4], $i6
	load    [$i2 + 3], $i7
	load    [$i4 + 2], $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f5, $f5
	load    [$i5 + 1], $f6
	fmul    $f2, $f2, $f7
	fmul    $f7, $f6, $f6
	load    [$i6 + 0], $f7
	fmul    $f3, $f3, $f8
	fmul    $f8, $f7, $f7
	fadd    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	be      $i7, 0, bne_cont.21861
bne_then.21861:
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f6
	fmul    $f3, $f2, $f7
	fmul    $f7, $f6, $f6
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f7
	fmul    $f1, $f3, $f8
	fmul    $f8, $f7, $f7
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f8
	fmul    $f2, $f1, $f9
	fmul    $f9, $f8, $f8
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	fadd    $f5, $f6, $f5
bne_cont.21861:
	bne     $i3, 3, be_cont.21862
be_then.21862:
	fsub    $f5, $fc0, $f5
be_cont.21862:
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
	bg      $f2, $f0, ble_else.21863
ble_then.21863:
	li      0, $i1
	ret
ble_else.21863:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.21864
be_then.21864:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret
be_else.21864:
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
	bne     $i5, 1, be_else.21865
be_then.21865:
	load    [$i2 + 0], $i2
	load    [$i3 + 4], $i4
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.21866
ble_then.21866:
	li      0, $i4
.count b_cont
	b       ble_cont.21866
ble_else.21866:
	load    [$i3 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.21867
ble_then.21867:
	li      0, $i4
.count b_cont
	b       ble_cont.21867
ble_else.21867:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.21868
be_then.21868:
	li      0, $i4
.count b_cont
	b       be_cont.21868
be_else.21868:
	li      1, $i4
be_cont.21868:
ble_cont.21867:
ble_cont.21866:
	bne     $i4, 0, be_else.21869
be_then.21869:
	load    [$i3 + 4], $i4
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i4 + 0], $f7
	bg      $f7, $f5, ble_else.21870
ble_then.21870:
	li      0, $i3
.count b_cont
	b       ble_cont.21870
ble_else.21870:
	load    [$i3 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.21871
ble_then.21871:
	li      0, $i3
.count b_cont
	b       ble_cont.21871
ble_else.21871:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.21872
be_then.21872:
	li      0, $i3
.count b_cont
	b       be_cont.21872
be_else.21872:
	li      1, $i3
be_cont.21872:
ble_cont.21871:
ble_cont.21870:
	bne     $i3, 0, be_else.21873
be_then.21873:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.21874
ble_then.21874:
	li      0, $i1
	ret
ble_else.21874:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.21875
ble_then.21875:
	li      0, $i1
	ret
ble_else.21875:
	load    [$i1 + 5], $f2
	bne     $f2, $f0, be_else.21876
be_then.21876:
	li      0, $i1
	ret
be_else.21876:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.21873:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.21869:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.21865:
	bne     $i5, 2, be_else.21877
be_then.21877:
	load    [$i1 + 0], $f1
	bg      $f0, $f1, ble_else.21878
ble_then.21878:
	li      0, $i1
	ret
ble_else.21878:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.21877:
	load    [$i1 + 0], $f4
	bne     $f4, $f0, be_else.21879
be_then.21879:
	li      0, $i1
	ret
be_else.21879:
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
	bg      $f2, $f0, ble_else.21880
ble_then.21880:
	li      0, $i1
	ret
ble_else.21880:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.21881
be_then.21881:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	ret
be_else.21881:
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
######################################################################
.begin setup_rect_table
setup_rect_table.2817:
	li      6, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	load    [$i4 + 0], $f1
	bne     $f1, $f0, be_else.21882
be_then.21882:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.21882
be_else.21882:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21883
ble_then.21883:
	li      0, $i3
.count b_cont
	b       ble_cont.21883
ble_else.21883:
	li      1, $i3
ble_cont.21883:
	bne     $i2, 0, be_else.21884
be_then.21884:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21884
be_else.21884:
	bne     $i3, 0, be_else.21885
be_then.21885:
	li      1, $i2
.count b_cont
	b       be_cont.21885
be_else.21885:
	li      0, $i2
be_cont.21885:
be_cont.21884:
	load    [$i5 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.21886
be_then.21886:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.21886
be_else.21886:
	store   $f1, [$i1 + 0]
	load    [$i4 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.21886:
be_cont.21882:
	load    [$i4 + 1], $f1
	bne     $f1, $f0, be_else.21887
be_then.21887:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.21887
be_else.21887:
	load    [$i5 + 6], $i2
	bg      $f0, $f1, ble_else.21888
ble_then.21888:
	li      0, $i3
.count b_cont
	b       ble_cont.21888
ble_else.21888:
	li      1, $i3
ble_cont.21888:
	bne     $i2, 0, be_else.21889
be_then.21889:
	mov     $i3, $i2
.count b_cont
	b       be_cont.21889
be_else.21889:
	bne     $i3, 0, be_else.21890
be_then.21890:
	li      1, $i2
.count b_cont
	b       be_cont.21890
be_else.21890:
	li      0, $i2
be_cont.21890:
be_cont.21889:
	load    [$i5 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.21891
be_then.21891:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.21891
be_else.21891:
	store   $f1, [$i1 + 2]
	load    [$i4 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.21891:
be_cont.21887:
	load    [$i4 + 2], $f1
	bne     $f1, $f0, be_else.21892
be_then.21892:
	store   $f0, [$i1 + 5]
	jr      $ra1
be_else.21892:
	load    [$i5 + 4], $i2
	load    [$i5 + 6], $i3
	bg      $f0, $f1, ble_else.21893
ble_then.21893:
	li      0, $i5
.count b_cont
	b       ble_cont.21893
ble_else.21893:
	li      1, $i5
ble_cont.21893:
	load    [$i2 + 2], $f1
	bne     $i3, 0, be_else.21894
be_then.21894:
	bne     $i5, 0, be_else.21895
be_then.21895:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21895:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21894:
	bne     $i5, 0, be_else.21896
be_then.21896:
	store   $f1, [$i1 + 4]
	load    [$i4 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	jr      $ra1
be_else.21896:
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
# [$i1 - $i6]
# [$f1 - $f4]
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
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i3 + 1], $f2
	load    [$i4 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i6 + 0], $f3
	load    [$i4 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f1, $f0, ble_else.21897
ble_then.21897:
	store   $f0, [$i1 + 0]
	jr      $ra1
ble_else.21897:
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
	load    [$i5 + 4], $i2
	load    [$i5 + 4], $i3
	load    [$i5 + 4], $i6
	load    [$i5 + 3], $i7
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i3 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i6 + 0], $f5
	load    [$i4 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i7, 0, bne_cont.21898
bne_then.21898:
	fmul    $f4, $f2, $f3
	load    [$i5 + 9], $i2
	load    [$i2 + 0], $f5
	fmul    $f3, $f5, $f3
	fadd    $f1, $f3, $f1
	fmul    $f2, $f6, $f2
	load    [$i5 + 9], $i2
	load    [$i2 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f6, $f4, $f2
	load    [$i5 + 9], $i2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
bne_cont.21898:
	store   $f1, [$i1 + 0]
	load    [$i5 + 4], $i2
	load    [$i5 + 4], $i3
	load    [$i5 + 4], $i6
	load    [$i2 + 2], $f2
	load    [$i4 + 2], $f3
	fmul_n  $f3, $f2, $f2
	load    [$i3 + 1], $f4
	load    [$i4 + 1], $f5
	fmul_n  $f5, $f4, $f4
	load    [$i6 + 0], $f6
	load    [$i4 + 0], $f7
	fmul_n  $f7, $f6, $f6
	bne     $i7, 0, be_else.21899
be_then.21899:
	store   $f6, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.21900
be_then.21900:
	jr      $ra1
be_else.21900:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	jr      $ra1
be_else.21899:
	load    [$i5 + 9], $i2
	load    [$i5 + 9], $i3
	load    [$i2 + 2], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f3, $f5, $f3
	fmul    $f3, $fc4, $f3
	fsub    $f6, $f3, $f3
	store   $f3, [$i1 + 1]
	load    [$i5 + 9], $i2
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
	bne     $f1, $f0, be_else.21901
be_then.21901:
	jr      $ra1
be_else.21901:
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
	bl      $i9, 0, bge_else.21902
bge_then.21902:
	load    [$i8 + 0], $i4
	load    [ext_objects + $i9], $i5
	load    [$i5 + 1], $i1
	load    [$i8 + 1], $i10
	bne     $i1, 1, be_else.21903
be_then.21903:
	jal     setup_rect_table.2817, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
be_else.21903:
	bne     $i1, 2, be_else.21904
be_then.21904:
	jal     setup_surface_table.2820, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
be_else.21904:
	jal     setup_second_table.2823, $ra1
.count storer
	add     $i10, $i9, $tmp
	store   $i1, [$tmp + 0]
	sub     $i9, 1, $i9
	b       iter_setup_dirvec_constants.2826
bge_else.21902:
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
# [$f1 - $f7]
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i1, 0, bge_else.21905
bge_then.21905:
	load    [ext_objects + $i1], $i3
	load    [$i3 + 10], $i4
	load    [$i3 + 5], $i5
	load    [$i5 + 0], $f1
	load    [$i2 + 0], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 0]
	load    [$i3 + 5], $i5
	load    [$i5 + 1], $f1
	load    [$i2 + 1], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 1]
	load    [$i3 + 5], $i5
	load    [$i5 + 2], $f1
	load    [$i2 + 2], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 2]
	load    [$i3 + 1], $i5
	bne     $i5, 2, be_else.21906
be_then.21906:
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
be_else.21906:
	bg      $i5, 2, ble_else.21907
ble_then.21907:
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
ble_else.21907:
	load    [$i3 + 4], $i6
	load    [$i3 + 4], $i7
	load    [$i3 + 4], $i8
	load    [$i3 + 3], $i9
	load    [$i6 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i7 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i8 + 0], $f5
	load    [$i4 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i9, 0, bne_cont.21908
bne_then.21908:
	load    [$i3 + 9], $i6
	load    [$i3 + 9], $i7
	load    [$i3 + 9], $i3
	load    [$i6 + 2], $f3
	fmul    $f6, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i7 + 1], $f5
	fmul    $f2, $f6, $f6
	fmul    $f6, $f5, $f5
	load    [$i3 + 0], $f6
	fmul    $f4, $f2, $f2
	fmul    $f2, $f6, $f2
	fadd    $f1, $f2, $f1
	fadd    $f1, $f5, $f1
	fadd    $f1, $f3, $f1
bne_cont.21908:
	sub     $i1, 1, $i1
	bne     $i5, 3, be_else.21909
be_then.21909:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
be_else.21909:
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
bge_else.21905:
	ret
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i9]
# [$f1 - $f10]
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21910
be_then.21910:
	li      1, $i1
	ret
be_else.21910:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i7, 1, be_else.21911
be_then.21911:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.21912
ble_then.21912:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21913
be_then.21913:
	li      1, $i2
.count b_cont
	b       be_cont.21911
be_else.21913:
	li      0, $i2
.count b_cont
	b       be_cont.21911
ble_else.21912:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21914
ble_then.21914:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21915
be_then.21915:
	li      1, $i2
.count b_cont
	b       be_cont.21911
be_else.21915:
	li      0, $i2
.count b_cont
	b       be_cont.21911
ble_else.21914:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f5, $f1, be_cont.21911
ble_then.21916:
	bne     $i2, 0, be_else.21917
be_then.21917:
	li      1, $i2
.count b_cont
	b       be_cont.21911
be_else.21917:
	li      0, $i2
.count b_cont
	b       be_cont.21911
be_else.21911:
	bne     $i7, 2, be_else.21918
be_then.21918:
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f6, $f5, $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21919
ble_then.21919:
	bne     $i2, 0, be_else.21920
be_then.21920:
	li      1, $i2
.count b_cont
	b       be_cont.21918
be_else.21920:
	li      0, $i2
.count b_cont
	b       be_cont.21918
ble_else.21919:
	bne     $i2, 0, be_else.21921
be_then.21921:
	li      0, $i2
.count b_cont
	b       be_cont.21918
be_else.21921:
	li      1, $i2
.count b_cont
	b       be_cont.21918
be_else.21918:
	fmul    $f6, $f6, $f7
	load    [$i4 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f1, $f8
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i2 + 3], $i4
	bne     $i4, 0, be_else.21922
be_then.21922:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21922
be_else.21922:
	fmul    $f5, $f1, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f6, $f1
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f8
	fmul    $f1, $f8, $f1
	fadd    $f7, $f1, $f1
	fmul    $f6, $f5, $f5
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
be_cont.21922:
	bne     $i7, 3, be_cont.21923
be_then.21923:
	fsub    $f1, $fc0, $f1
be_cont.21923:
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21924
ble_then.21924:
	bne     $i2, 0, be_else.21925
be_then.21925:
	li      1, $i2
.count b_cont
	b       ble_cont.21924
be_else.21925:
	li      0, $i2
.count b_cont
	b       ble_cont.21924
ble_else.21924:
	bne     $i2, 0, be_else.21926
be_then.21926:
	li      0, $i2
.count b_cont
	b       be_cont.21926
be_else.21926:
	li      1, $i2
be_cont.21926:
ble_cont.21924:
be_cont.21918:
be_cont.21911:
	bne     $i2, 0, be_else.21927
be_then.21927:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21928
be_then.21928:
	li      1, $i1
	ret
be_else.21928:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i7, 1, be_else.21929
be_then.21929:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.21930
ble_then.21930:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21931
be_then.21931:
	li      1, $i2
.count b_cont
	b       be_cont.21929
be_else.21931:
	li      0, $i2
.count b_cont
	b       be_cont.21929
ble_else.21930:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21932
ble_then.21932:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21933
be_then.21933:
	li      1, $i2
.count b_cont
	b       be_cont.21929
be_else.21933:
	li      0, $i2
.count b_cont
	b       be_cont.21929
ble_else.21932:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f5, $f1, be_cont.21929
ble_then.21934:
	bne     $i2, 0, be_else.21935
be_then.21935:
	li      1, $i2
.count b_cont
	b       be_cont.21929
be_else.21935:
	li      0, $i2
.count b_cont
	b       be_cont.21929
be_else.21929:
	load    [$i4 + 2], $f7
	bne     $i7, 2, be_else.21936
be_then.21936:
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21937
ble_then.21937:
	bne     $i2, 0, be_else.21938
be_then.21938:
	li      1, $i2
.count b_cont
	b       be_cont.21936
be_else.21938:
	li      0, $i2
.count b_cont
	b       be_cont.21936
ble_else.21937:
	bne     $i2, 0, be_else.21939
be_then.21939:
	li      0, $i2
.count b_cont
	b       be_cont.21936
be_else.21939:
	li      1, $i2
.count b_cont
	b       be_cont.21936
be_else.21936:
	load    [$i2 + 4], $i5
	load    [$i2 + 4], $i6
	load    [$i2 + 3], $i7
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i5 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i6 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	bne     $i7, 0, be_else.21940
be_then.21940:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21940
be_else.21940:
	load    [$i2 + 9], $i4
	load    [$i2 + 9], $i5
	load    [$i2 + 9], $i6
	load    [$i4 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i5 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i6 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.21940:
	load    [$i2 + 1], $i4
	bne     $i4, 3, be_cont.21941
be_then.21941:
	fsub    $f1, $fc0, $f1
be_cont.21941:
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.21942
ble_then.21942:
	bne     $i2, 0, be_else.21943
be_then.21943:
	li      1, $i2
.count b_cont
	b       ble_cont.21942
be_else.21943:
	li      0, $i2
.count b_cont
	b       ble_cont.21942
ble_else.21942:
	bne     $i2, 0, be_else.21944
be_then.21944:
	li      0, $i2
.count b_cont
	b       be_cont.21944
be_else.21944:
	li      1, $i2
be_cont.21944:
ble_cont.21942:
be_cont.21936:
be_cont.21929:
	bne     $i2, 0, be_else.21945
be_then.21945:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21946
be_then.21946:
	li      1, $i1
	ret
be_else.21946:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 0], $f6
	fsub    $f2, $f6, $f6
	bne     $i7, 1, be_else.21947
be_then.21947:
	load    [$i2 + 4], $i4
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.21948
ble_then.21948:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21949
be_then.21949:
	li      1, $i2
.count b_cont
	b       be_cont.21947
be_else.21949:
	li      0, $i2
.count b_cont
	b       be_cont.21947
ble_else.21948:
	load    [$i2 + 4], $i4
	fabs    $f5, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.21950
ble_then.21950:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.21951
be_then.21951:
	li      1, $i2
.count b_cont
	b       be_cont.21947
be_else.21951:
	li      0, $i2
.count b_cont
	b       be_cont.21947
ble_else.21950:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f5, $f1, be_cont.21947
ble_then.21952:
	bne     $i2, 0, be_else.21953
be_then.21953:
	li      1, $i2
.count b_cont
	b       be_cont.21947
be_else.21953:
	li      0, $i2
.count b_cont
	b       be_cont.21947
be_else.21947:
	bne     $i7, 2, be_else.21954
be_then.21954:
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
	bg      $f0, $f1, ble_else.21955
ble_then.21955:
	bne     $i2, 0, be_else.21956
be_then.21956:
	li      1, $i2
.count b_cont
	b       be_cont.21954
be_else.21956:
	li      0, $i2
.count b_cont
	b       be_cont.21954
ble_else.21955:
	bne     $i2, 0, be_else.21957
be_then.21957:
	li      0, $i2
.count b_cont
	b       be_cont.21954
be_else.21957:
	li      1, $i2
.count b_cont
	b       be_cont.21954
be_else.21954:
	load    [$i2 + 1], $i4
	load    [$i2 + 6], $i5
	load    [$i2 + 4], $i6
	load    [$i6 + 2], $f7
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i2 + 4], $i6
	load    [$i6 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i2 + 4], $i6
	load    [$i6 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	load    [$i2 + 3], $i6
	bne     $i6, 0, be_else.21958
be_then.21958:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21958
be_else.21958:
	fmul    $f5, $f1, $f8
	load    [$i2 + 9], $i6
	load    [$i6 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f6, $f1
	load    [$i2 + 9], $i6
	load    [$i6 + 1], $f8
	fmul    $f1, $f8, $f1
	fadd    $f7, $f1, $f1
	fmul    $f6, $f5, $f5
	load    [$i2 + 9], $i2
	load    [$i2 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
be_cont.21958:
	bne     $i4, 3, be_cont.21959
be_then.21959:
	fsub    $f1, $fc0, $f1
be_cont.21959:
	bg      $f0, $f1, ble_else.21960
ble_then.21960:
	bne     $i5, 0, be_else.21961
be_then.21961:
	li      1, $i2
.count b_cont
	b       ble_cont.21960
be_else.21961:
	li      0, $i2
.count b_cont
	b       ble_cont.21960
ble_else.21960:
	bne     $i5, 0, be_else.21962
be_then.21962:
	li      0, $i2
.count b_cont
	b       be_cont.21962
be_else.21962:
	li      1, $i2
be_cont.21962:
ble_cont.21960:
be_cont.21954:
be_cont.21947:
	bne     $i2, 0, be_else.21963
be_then.21963:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.21964
be_then.21964:
	li      1, $i1
	ret
be_else.21964:
	load    [ext_objects + $i2], $i2
	load    [$i2 + 5], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 1], $i7
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i2 + 4], $i4
	bne     $i7, 1, be_else.21965
be_then.21965:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.21966
ble_then.21966:
	li      0, $i4
.count b_cont
	b       ble_cont.21966
ble_else.21966:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.21967
ble_then.21967:
	li      0, $i4
.count b_cont
	b       ble_cont.21967
ble_else.21967:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.21968
ble_then.21968:
	li      0, $i4
.count b_cont
	b       ble_cont.21968
ble_else.21968:
	li      1, $i4
ble_cont.21968:
ble_cont.21967:
ble_cont.21966:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.21969
be_then.21969:
	bne     $i2, 0, be_else.21970
be_then.21970:
	li      0, $i1
	ret
be_else.21970:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21969:
	bne     $i2, 0, be_else.21971
be_then.21971:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21971:
	li      0, $i1
	ret
be_else.21965:
	load    [$i4 + 2], $f7
	bne     $i7, 2, be_else.21972
be_then.21972:
	load    [$i2 + 6], $i2
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.21973
ble_then.21973:
	li      0, $i4
.count b_cont
	b       ble_cont.21973
ble_else.21973:
	li      1, $i4
ble_cont.21973:
	bne     $i2, 0, be_else.21974
be_then.21974:
	bne     $i4, 0, be_else.21975
be_then.21975:
	li      0, $i1
	ret
be_else.21975:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21974:
	bne     $i4, 0, be_else.21976
be_then.21976:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21976:
	li      0, $i1
	ret
be_else.21972:
	load    [$i2 + 4], $i5
	load    [$i2 + 4], $i6
	load    [$i2 + 3], $i8
	load    [$i2 + 6], $i9
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i5 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i6 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	bne     $i8, 0, be_else.21977
be_then.21977:
	mov     $f7, $f1
.count b_cont
	b       be_cont.21977
be_else.21977:
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i2 + 9], $i2
	load    [$i2 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.21977:
	bne     $i7, 3, be_cont.21978
be_then.21978:
	fsub    $f1, $fc0, $f1
be_cont.21978:
	bg      $f0, $f1, ble_else.21979
ble_then.21979:
	li      0, $i2
.count b_cont
	b       ble_cont.21979
ble_else.21979:
	li      1, $i2
ble_cont.21979:
	bne     $i9, 0, be_else.21980
be_then.21980:
	bne     $i2, 0, be_else.21981
be_then.21981:
	li      0, $i1
	ret
be_else.21981:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21980:
	bne     $i2, 0, be_else.21982
be_then.21982:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.21982:
	li      0, $i1
	ret
be_else.21963:
	li      0, $i1
	ret
be_else.21945:
	li      0, $i1
	ret
be_else.21927:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i10, $i11)
# $ra = $ra1
# [$i1 - $i11]
# [$f1 - $f10]
# []
# [$fg0]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.21983
be_then.21983:
	li      0, $i1
	jr      $ra1
be_else.21983:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 1], $i3
	load    [ext_light_dirvec + 1], $i4
	load    [$i2 + 5], $i5
	load    [$i2 + 5], $i6
	load    [$i2 + 5], $i7
	load    [$i4 + $i1], $i4
	load    [$i5 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i7 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	bne     $i3, 1, be_else.21984
be_then.21984:
	load    [ext_light_dirvec + 0], $i3
	load    [$i4 + 1], $f4
	load    [$i4 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 4], $i5
	load    [$i5 + 1], $f6
	bg      $f6, $f5, ble_else.21985
ble_then.21985:
	li      0, $i5
.count b_cont
	b       ble_cont.21985
ble_else.21985:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21986
ble_then.21986:
	li      0, $i5
.count b_cont
	b       ble_cont.21986
ble_else.21986:
	load    [$i4 + 1], $f5
	bne     $f5, $f0, be_else.21987
be_then.21987:
	li      0, $i5
.count b_cont
	b       be_cont.21987
be_else.21987:
	li      1, $i5
be_cont.21987:
ble_cont.21986:
ble_cont.21985:
	bne     $i5, 0, be_else.21988
be_then.21988:
	load    [$i4 + 3], $f4
	load    [$i4 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f6
	bg      $f6, $f5, ble_else.21989
ble_then.21989:
	li      0, $i5
.count b_cont
	b       ble_cont.21989
ble_else.21989:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.21990
ble_then.21990:
	li      0, $i5
.count b_cont
	b       ble_cont.21990
ble_else.21990:
	load    [$i4 + 3], $f5
	bne     $f5, $f0, be_else.21991
be_then.21991:
	li      0, $i5
.count b_cont
	b       be_cont.21991
be_else.21991:
	li      1, $i5
be_cont.21991:
ble_cont.21990:
ble_cont.21989:
	bne     $i5, 0, be_else.21992
be_then.21992:
	load    [$i4 + 5], $f4
	load    [$i4 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f4
	bg      $f4, $f3, ble_else.21993
ble_then.21993:
	li      0, $i2
.count b_cont
	b       be_cont.21984
ble_else.21993:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f3
	bg      $f3, $f2, ble_else.21994
ble_then.21994:
	li      0, $i2
.count b_cont
	b       be_cont.21984
ble_else.21994:
	load    [$i4 + 5], $f2
	bne     $f2, $f0, be_else.21995
be_then.21995:
	li      0, $i2
.count b_cont
	b       be_cont.21984
be_else.21995:
	mov     $f1, $fg0
	li      3, $i2
.count b_cont
	b       be_cont.21984
be_else.21992:
	mov     $f4, $fg0
	li      2, $i2
.count b_cont
	b       be_cont.21984
be_else.21988:
	mov     $f4, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.21984
be_else.21984:
	load    [$i4 + 0], $f4
	bne     $i3, 2, be_else.21996
be_then.21996:
	bg      $f0, $f4, ble_else.21997
ble_then.21997:
	li      0, $i2
.count b_cont
	b       be_cont.21996
ble_else.21997:
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
	b       be_cont.21996
be_else.21996:
	bne     $f4, $f0, be_else.21998
be_then.21998:
	li      0, $i2
.count b_cont
	b       be_cont.21998
be_else.21998:
	fmul    $f3, $f3, $f5
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f6
	fmul    $f5, $f6, $f5
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $i5
	load    [$i5 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f1, $f6
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i5
	be      $i5, 0, bne_cont.21999
bne_then.21999:
	fmul    $f2, $f1, $f6
	load    [$i2 + 9], $i5
	load    [$i5 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f3, $f6
	load    [$i2 + 9], $i5
	load    [$i5 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f2, $f6
	load    [$i2 + 9], $i5
	load    [$i5 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
bne_cont.21999:
	bne     $i3, 3, be_cont.22000
be_then.22000:
	fsub    $f5, $fc0, $f5
be_cont.22000:
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
	bg      $f2, $f0, ble_else.22001
ble_then.22001:
	li      0, $i2
.count b_cont
	b       ble_cont.22001
ble_else.22001:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i4 + 4], $f3
	bne     $i2, 0, be_else.22002
be_then.22002:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.22002
be_else.22002:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i2
be_cont.22002:
ble_cont.22001:
be_cont.21998:
be_cont.21996:
be_cont.21984:
	bne     $i2, 0, be_else.22003
be_then.22003:
	li      0, $i2
.count b_cont
	b       be_cont.22003
be_else.22003:
.count load_float
	load    [f.21623], $f1
	bg      $f1, $fg0, ble_else.22004
ble_then.22004:
	li      0, $i2
.count b_cont
	b       ble_cont.22004
ble_else.22004:
	li      1, $i2
ble_cont.22004:
be_cont.22003:
	bne     $i2, 0, be_else.22005
be_then.22005:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22006
be_then.22006:
	li      0, $i1
	jr      $ra1
be_else.22006:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.22005:
	load    [$i11 + 0], $i1
	bne     $i1, -1, be_else.22007
be_then.22007:
	li      1, $i1
	jr      $ra1
be_else.22007:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 1], $i5
	load    [ext_intersection_point + 2], $f1
	fadd    $fg0, $fc15, $f2
	fmul    $fg13, $f2, $f3
	fadd    $f3, $f1, $f4
	load    [$i2 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [ext_intersection_point + 1], $f3
	fmul    $fg12, $f2, $f5
	fadd    $f5, $f3, $f3
	load    [$i3 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [ext_intersection_point + 0], $f6
	fmul    $fg15, $f2, $f2
	fadd    $f2, $f6, $f2
	load    [$i4 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i1 + 4], $i2
	bne     $i5, 1, be_else.22008
be_then.22008:
	fabs    $f6, $f6
	load    [$i2 + 0], $f7
	bg      $f7, $f6, ble_else.22009
ble_then.22009:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22010
be_then.22010:
	li      1, $i1
.count b_cont
	b       be_cont.22008
be_else.22010:
	li      0, $i1
.count b_cont
	b       be_cont.22008
ble_else.22009:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.22011
ble_then.22011:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22012
be_then.22012:
	li      1, $i1
.count b_cont
	b       be_cont.22008
be_else.22012:
	li      0, $i1
.count b_cont
	b       be_cont.22008
ble_else.22011:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f5
	fabs    $f1, $f1
	load    [$i1 + 6], $i1
	bg      $f5, $f1, be_cont.22008
ble_then.22013:
	bne     $i1, 0, be_else.22014
be_then.22014:
	li      1, $i1
.count b_cont
	b       be_cont.22008
be_else.22014:
	li      0, $i1
.count b_cont
	b       be_cont.22008
be_else.22008:
	load    [$i2 + 2], $f7
	bne     $i5, 2, be_else.22015
be_then.22015:
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i2 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.22016
ble_then.22016:
	bne     $i1, 0, be_else.22017
be_then.22017:
	li      1, $i1
.count b_cont
	b       be_cont.22015
be_else.22017:
	li      0, $i1
.count b_cont
	b       be_cont.22015
ble_else.22016:
	bne     $i1, 0, be_else.22018
be_then.22018:
	li      0, $i1
.count b_cont
	b       be_cont.22015
be_else.22018:
	li      1, $i1
.count b_cont
	b       be_cont.22015
be_else.22015:
	fmul    $f1, $f1, $f8
	fmul    $f8, $f7, $f7
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f8
	fmul    $f5, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f9
	fmul    $f6, $f6, $f10
	fmul    $f10, $f9, $f9
	fadd    $f9, $f8, $f8
	fadd    $f8, $f7, $f7
	load    [$i1 + 3], $i2
	bne     $i2, 0, be_else.22019
be_then.22019:
	mov     $f7, $f1
.count b_cont
	b       be_cont.22019
be_else.22019:
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f8
	fmul    $f6, $f5, $f9
	fmul    $f9, $f8, $f8
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f9
	fmul    $f1, $f6, $f6
	fmul    $f6, $f9, $f6
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f9
	fmul    $f5, $f1, $f1
	fmul    $f1, $f9, $f1
	fadd    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f8, $f1
be_cont.22019:
	bne     $i5, 3, be_cont.22020
be_then.22020:
	fsub    $f1, $fc0, $f1
be_cont.22020:
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.22021
ble_then.22021:
	bne     $i1, 0, be_else.22022
be_then.22022:
	li      1, $i1
.count b_cont
	b       ble_cont.22021
be_else.22022:
	li      0, $i1
.count b_cont
	b       ble_cont.22021
ble_else.22021:
	bne     $i1, 0, be_else.22023
be_then.22023:
	li      0, $i1
.count b_cont
	b       be_cont.22023
be_else.22023:
	li      1, $i1
be_cont.22023:
ble_cont.22021:
be_cont.22015:
be_cont.22008:
	bne     $i1, 0, be_else.22024
be_then.22024:
	li      1, $i1
.count move_args
	mov     $i11, $i3
	call    check_all_inside.2856
	bne     $i1, 0, be_else.22025
be_then.22025:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.22025:
	li      1, $i1
	jr      $ra1
be_else.22024:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i12, $i13)
# $ra = $ra2
# [$i1 - $i13]
# [$f1 - $f10]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22026
be_then.22026:
	li      0, $i1
	jr      $ra2
be_else.22026:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22027
be_then.22027:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22028
be_then.22028:
	li      0, $i1
	jr      $ra2
be_else.22028:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22029
be_then.22029:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22030
be_then.22030:
	li      0, $i1
	jr      $ra2
be_else.22030:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22031
be_then.22031:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22032
be_then.22032:
	li      0, $i1
	jr      $ra2
be_else.22032:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22033
be_then.22033:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22034
be_then.22034:
	li      0, $i1
	jr      $ra2
be_else.22034:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22035
be_then.22035:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22036
be_then.22036:
	li      0, $i1
	jr      $ra2
be_else.22036:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22037
be_then.22037:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22038
be_then.22038:
	li      0, $i1
	jr      $ra2
be_else.22038:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22039
be_then.22039:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.22040
be_then.22040:
	li      0, $i1
	jr      $ra2
be_else.22040:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22041
be_then.22041:
	add     $i12, 1, $i12
	b       shadow_check_one_or_group.2865
be_else.22041:
	li      1, $i1
	jr      $ra2
be_else.22039:
	li      1, $i1
	jr      $ra2
be_else.22037:
	li      1, $i1
	jr      $ra2
be_else.22035:
	li      1, $i1
	jr      $ra2
be_else.22033:
	li      1, $i1
	jr      $ra2
be_else.22031:
	li      1, $i1
	jr      $ra2
be_else.22029:
	li      1, $i1
	jr      $ra2
be_else.22027:
	li      1, $i1
	jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i14, $i15)
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f10]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22042
be_then.22042:
	li      0, $i1
	jr      $ra3
be_else.22042:
	bne     $i1, 99, be_else.22043
be_then.22043:
	li      1, $i1
.count b_cont
	b       be_cont.22043
be_else.22043:
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
	bne     $i3, 1, be_else.22044
be_then.22044:
	load    [ext_light_dirvec + 0], $i3
	load    [$i1 + 1], $f4
	load    [$i1 + 0], $f5
	fsub    $f5, $f1, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.22045
ble_then.22045:
	li      0, $i4
.count b_cont
	b       ble_cont.22045
ble_else.22045:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.22046
ble_then.22046:
	li      0, $i4
.count b_cont
	b       ble_cont.22046
ble_else.22046:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.22047
be_then.22047:
	li      0, $i4
.count b_cont
	b       be_cont.22047
be_else.22047:
	li      1, $i4
be_cont.22047:
ble_cont.22046:
ble_cont.22045:
	bne     $i4, 0, be_else.22048
be_then.22048:
	load    [$i1 + 3], $f4
	load    [$i1 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f6
	bg      $f6, $f5, ble_else.22049
ble_then.22049:
	li      0, $i4
.count b_cont
	b       ble_cont.22049
ble_else.22049:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.22050
ble_then.22050:
	li      0, $i4
.count b_cont
	b       ble_cont.22050
ble_else.22050:
	load    [$i1 + 3], $f5
	bne     $f5, $f0, be_else.22051
be_then.22051:
	li      0, $i4
.count b_cont
	b       be_cont.22051
be_else.22051:
	li      1, $i4
be_cont.22051:
ble_cont.22050:
ble_cont.22049:
	bne     $i4, 0, be_else.22052
be_then.22052:
	load    [$i1 + 5], $f4
	load    [$i1 + 4], $f5
	fsub    $f5, $f3, $f3
	fmul    $f3, $f4, $f3
	load    [$i3 + 0], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f1, $f1
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f4
	bg      $f4, $f1, ble_else.22053
ble_then.22053:
	li      0, $i1
.count b_cont
	b       be_cont.22044
ble_else.22053:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f2
	bg      $f2, $f1, ble_else.22054
ble_then.22054:
	li      0, $i1
.count b_cont
	b       be_cont.22044
ble_else.22054:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.22055
be_then.22055:
	li      0, $i1
.count b_cont
	b       be_cont.22044
be_else.22055:
	mov     $f3, $fg0
	li      3, $i1
.count b_cont
	b       be_cont.22044
be_else.22052:
	mov     $f4, $fg0
	li      2, $i1
.count b_cont
	b       be_cont.22044
be_else.22048:
	mov     $f4, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.22044
be_else.22044:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.22056
be_then.22056:
	bg      $f0, $f4, ble_else.22057
ble_then.22057:
	li      0, $i1
.count b_cont
	b       be_cont.22056
ble_else.22057:
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
	b       be_cont.22056
be_else.22056:
	bne     $f4, $f0, be_else.22058
be_then.22058:
	li      0, $i1
.count b_cont
	b       be_cont.22058
be_else.22058:
	fmul    $f1, $f1, $f5
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f6
	fmul    $f5, $f6, $f5
	fmul    $f2, $f2, $f6
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f3, $f6
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $i4
	be      $i4, 0, bne_cont.22059
bne_then.22059:
	fmul    $f2, $f3, $f6
	load    [$i2 + 9], $i4
	load    [$i4 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f3, $f1, $f6
	load    [$i2 + 9], $i4
	load    [$i4 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	fmul    $f1, $f2, $f6
	load    [$i2 + 9], $i4
	load    [$i4 + 2], $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
bne_cont.22059:
	bne     $i3, 3, be_cont.22060
be_then.22060:
	fsub    $f5, $fc0, $f5
be_cont.22060:
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
	bg      $f2, $f0, ble_else.22061
ble_then.22061:
	li      0, $i1
.count b_cont
	b       ble_cont.22061
ble_else.22061:
	load    [$i2 + 6], $i2
	fsqrt   $f2, $f2
	load    [$i1 + 4], $f3
	li      1, $i1
	bne     $i2, 0, be_else.22062
be_then.22062:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.22062
be_else.22062:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
be_cont.22062:
ble_cont.22061:
be_cont.22058:
be_cont.22056:
be_cont.22044:
	bne     $i1, 0, be_else.22063
be_then.22063:
	li      0, $i1
.count b_cont
	b       be_cont.22063
be_else.22063:
	bg      $fc7, $fg0, ble_else.22064
ble_then.22064:
	li      0, $i1
.count b_cont
	b       ble_cont.22064
ble_else.22064:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22065
be_then.22065:
	li      0, $i1
.count b_cont
	b       be_cont.22065
be_else.22065:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22066
be_then.22066:
	li      2, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22067
be_then.22067:
	li      0, $i1
.count b_cont
	b       be_cont.22066
be_else.22067:
	li      1, $i1
.count b_cont
	b       be_cont.22066
be_else.22066:
	li      1, $i1
be_cont.22066:
be_cont.22065:
ble_cont.22064:
be_cont.22063:
be_cont.22043:
	bne     $i1, 0, be_else.22068
be_then.22068:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22069
be_then.22069:
	li      0, $i1
	jr      $ra3
be_else.22069:
	bne     $i1, 99, be_else.22070
be_then.22070:
	li      1, $i1
.count b_cont
	b       be_cont.22070
be_else.22070:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22071
be_then.22071:
	li      0, $i1
.count b_cont
	b       be_cont.22071
be_else.22071:
	bg      $fc7, $fg0, ble_else.22072
ble_then.22072:
	li      0, $i1
.count b_cont
	b       ble_cont.22072
ble_else.22072:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22073
be_then.22073:
	li      0, $i1
.count b_cont
	b       be_cont.22073
be_else.22073:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22074
be_then.22074:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22075
be_then.22075:
	li      0, $i1
.count b_cont
	b       be_cont.22074
be_else.22075:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22076
be_then.22076:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22077
be_then.22077:
	li      0, $i1
.count b_cont
	b       be_cont.22074
be_else.22077:
	li      1, $i1
.count b_cont
	b       be_cont.22074
be_else.22076:
	li      1, $i1
.count b_cont
	b       be_cont.22074
be_else.22074:
	li      1, $i1
be_cont.22074:
be_cont.22073:
ble_cont.22072:
be_cont.22071:
be_cont.22070:
	bne     $i1, 0, be_else.22078
be_then.22078:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22078:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22079
be_then.22079:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22079:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22080
be_then.22080:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22081
be_then.22081:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22081:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22082
be_then.22082:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22083
be_then.22083:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22083:
	li      1, $i1
	jr      $ra3
be_else.22082:
	li      1, $i1
	jr      $ra3
be_else.22080:
	li      1, $i1
	jr      $ra3
be_else.22068:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22084
be_then.22084:
	li      0, $i1
.count b_cont
	b       be_cont.22084
be_else.22084:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22085
be_then.22085:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22086
be_then.22086:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22086:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22087
be_then.22087:
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22088
be_then.22088:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22088:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22089
be_then.22089:
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22090
be_then.22090:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22090:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22091
be_then.22091:
	load    [$i16 + 5], $i1
	bne     $i1, -1, be_else.22092
be_then.22092:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22092:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22093
be_then.22093:
	load    [$i16 + 6], $i1
	bne     $i1, -1, be_else.22094
be_then.22094:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22094:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22095
be_then.22095:
	load    [$i16 + 7], $i1
	bne     $i1, -1, be_else.22096
be_then.22096:
	li      0, $i1
.count b_cont
	b       be_cont.22085
be_else.22096:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22097
be_then.22097:
	li      8, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
.count b_cont
	b       be_cont.22085
be_else.22097:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22095:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22093:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22091:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22089:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22087:
	li      1, $i1
.count b_cont
	b       be_cont.22085
be_else.22085:
	li      1, $i1
be_cont.22085:
be_cont.22084:
	bne     $i1, 0, be_else.22098
be_then.22098:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22099
be_then.22099:
	li      0, $i1
	jr      $ra3
be_else.22099:
	bne     $i1, 99, be_else.22100
be_then.22100:
	li      1, $i1
.count b_cont
	b       be_cont.22100
be_else.22100:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22101
be_then.22101:
	li      0, $i1
.count b_cont
	b       be_cont.22101
be_else.22101:
	bg      $fc7, $fg0, ble_else.22102
ble_then.22102:
	li      0, $i1
.count b_cont
	b       ble_cont.22102
ble_else.22102:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22103
be_then.22103:
	li      0, $i1
.count b_cont
	b       be_cont.22103
be_else.22103:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22104
be_then.22104:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22105
be_then.22105:
	li      0, $i1
.count b_cont
	b       be_cont.22104
be_else.22105:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22106
be_then.22106:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22107
be_then.22107:
	li      0, $i1
.count b_cont
	b       be_cont.22104
be_else.22107:
	li      1, $i1
.count b_cont
	b       be_cont.22104
be_else.22106:
	li      1, $i1
.count b_cont
	b       be_cont.22104
be_else.22104:
	li      1, $i1
be_cont.22104:
be_cont.22103:
ble_cont.22102:
be_cont.22101:
be_cont.22100:
	bne     $i1, 0, be_else.22108
be_then.22108:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22108:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22109
be_then.22109:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22109:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22110
be_then.22110:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22111
be_then.22111:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22111:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22112
be_then.22112:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22113
be_then.22113:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.22113:
	li      1, $i1
	jr      $ra3
be_else.22112:
	li      1, $i1
	jr      $ra3
be_else.22110:
	li      1, $i1
	jr      $ra3
be_else.22098:
	li      1, $i1
	jr      $ra3
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i10, $i11, $i12)
# $ra = $ra1
# [$i1 - $i14]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.22114
be_then.22114:
	jr      $ra1
be_else.22114:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 1], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i3 + 2], $f1
	fsub    $fg19, $f1, $f1
	load    [$i4 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i5 + 0], $f3
	fsub    $fg17, $f3, $f3
	bne     $i2, 1, be_else.22115
be_then.22115:
	load    [$i12 + 0], $f4
	bne     $f4, $f0, be_else.22116
be_then.22116:
	li      0, $i2
.count b_cont
	b       be_cont.22116
be_else.22116:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.22117
ble_then.22117:
	li      0, $i4
.count b_cont
	b       ble_cont.22117
ble_else.22117:
	li      1, $i4
ble_cont.22117:
	bne     $i3, 0, be_else.22118
be_then.22118:
	mov     $i4, $i3
.count b_cont
	b       be_cont.22118
be_else.22118:
	bne     $i4, 0, be_else.22119
be_then.22119:
	li      1, $i3
.count b_cont
	b       be_cont.22119
be_else.22119:
	li      0, $i3
be_cont.22119:
be_cont.22118:
	load    [$i2 + 0], $f5
	bne     $i3, 0, be_cont.22120
be_then.22120:
	fneg    $f5, $f5
be_cont.22120:
	fsub    $f5, $f3, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	load    [$i12 + 1], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.22121
ble_then.22121:
	li      0, $i2
.count b_cont
	b       ble_cont.22121
ble_else.22121:
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22122
ble_then.22122:
	li      0, $i2
.count b_cont
	b       ble_cont.22122
ble_else.22122:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.22122:
ble_cont.22121:
be_cont.22116:
	bne     $i2, 0, be_else.22123
be_then.22123:
	load    [$i12 + 1], $f4
	bne     $f4, $f0, be_else.22124
be_then.22124:
	li      0, $i2
.count b_cont
	b       be_cont.22124
be_else.22124:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.22125
ble_then.22125:
	li      0, $i4
.count b_cont
	b       ble_cont.22125
ble_else.22125:
	li      1, $i4
ble_cont.22125:
	bne     $i3, 0, be_else.22126
be_then.22126:
	mov     $i4, $i3
.count b_cont
	b       be_cont.22126
be_else.22126:
	bne     $i4, 0, be_else.22127
be_then.22127:
	li      1, $i3
.count b_cont
	b       be_cont.22127
be_else.22127:
	li      0, $i3
be_cont.22127:
be_cont.22126:
	load    [$i2 + 1], $f5
	bne     $i3, 0, be_cont.22128
be_then.22128:
	fneg    $f5, $f5
be_cont.22128:
	fsub    $f5, $f2, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22129
ble_then.22129:
	li      0, $i2
.count b_cont
	b       ble_cont.22129
ble_else.22129:
	load    [$i2 + 0], $f5
	load    [$i12 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.22130
ble_then.22130:
	li      0, $i2
.count b_cont
	b       ble_cont.22130
ble_else.22130:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.22130:
ble_cont.22129:
be_cont.22124:
	bne     $i2, 0, be_else.22131
be_then.22131:
	load    [$i12 + 2], $f4
	bne     $f4, $f0, be_else.22132
be_then.22132:
	li      0, $i14
.count b_cont
	b       be_cont.22115
be_else.22132:
	finv    $f4, $f5
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f6
	bg      $f0, $f4, ble_else.22133
ble_then.22133:
	li      0, $i3
.count b_cont
	b       ble_cont.22133
ble_else.22133:
	li      1, $i3
ble_cont.22133:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22134
be_then.22134:
	mov     $i3, $i1
.count b_cont
	b       be_cont.22134
be_else.22134:
	bne     $i3, 0, be_else.22135
be_then.22135:
	li      1, $i1
.count b_cont
	b       be_cont.22135
be_else.22135:
	li      0, $i1
be_cont.22135:
be_cont.22134:
	bne     $i1, 0, be_else.22136
be_then.22136:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.22136
be_else.22136:
	mov     $f6, $f4
be_cont.22136:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f5, $f1
	load    [$i12 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i2 + 0], $f4
	bg      $f4, $f3, ble_else.22137
ble_then.22137:
	li      0, $i14
.count b_cont
	b       be_cont.22115
ble_else.22137:
	load    [$i12 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i2 + 1], $f3
	bg      $f3, $f2, ble_else.22138
ble_then.22138:
	li      0, $i14
.count b_cont
	b       be_cont.22115
ble_else.22138:
	mov     $f1, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.22115
be_else.22131:
	li      2, $i14
.count b_cont
	b       be_cont.22115
be_else.22123:
	li      1, $i14
.count b_cont
	b       be_cont.22115
be_else.22115:
	bne     $i2, 2, be_else.22139
be_then.22139:
	load    [$i1 + 4], $i1
	load    [$i12 + 0], $f4
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
	bg      $f4, $f0, ble_else.22140
ble_then.22140:
	li      0, $i14
.count b_cont
	b       be_cont.22139
ble_else.22140:
	finv    $f4, $f4
	fmul    $f5, $f3, $f3
	fmul    $f7, $f2, $f2
	fadd    $f3, $f2, $f2
	fmul    $f8, $f1, $f1
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f4, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22139
be_else.22139:
	load    [$i1 + 4], $i2
	load    [$i1 + 4], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 3], $i5
	load    [$i2 + 2], $f4
	load    [$i12 + 2], $f5
	fmul    $f5, $f5, $f6
	fmul    $f6, $f4, $f6
	load    [$i3 + 1], $f7
	load    [$i12 + 1], $f8
	fmul    $f8, $f8, $f9
	fmul    $f9, $f7, $f9
	load    [$i4 + 0], $f10
	load    [$i12 + 0], $f11
	fmul    $f11, $f11, $f12
	fmul    $f12, $f10, $f12
	fadd    $f12, $f9, $f9
	fadd    $f9, $f6, $f6
	be      $i5, 0, bne_cont.22141
bne_then.22141:
	fmul    $f8, $f5, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
	fmul    $f5, $f11, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
	fmul    $f11, $f8, $f9
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f12
	fmul    $f9, $f12, $f9
	fadd    $f6, $f9, $f6
bne_cont.22141:
	bne     $f6, $f0, be_else.22142
be_then.22142:
	li      0, $i14
.count b_cont
	b       be_cont.22142
be_else.22142:
	load    [$i1 + 1], $i2
	fmul    $f1, $f1, $f9
	fmul    $f9, $f4, $f9
	fmul    $f2, $f2, $f12
	fmul    $f12, $f7, $f12
	fmul    $f3, $f3, $f13
	fmul    $f13, $f10, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f9, $f9
	be      $i5, 0, bne_cont.22143
bne_then.22143:
	fmul    $f2, $f1, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
	fmul    $f1, $f3, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
	fmul    $f3, $f2, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f9, $f12, $f9
bne_cont.22143:
	bne     $i2, 3, be_cont.22144
be_then.22144:
	fsub    $f9, $fc0, $f9
be_cont.22144:
	fmul    $f6, $f9, $f9
	fmul    $f5, $f1, $f12
	fmul    $f12, $f4, $f4
	fmul    $f8, $f2, $f12
	fmul    $f12, $f7, $f7
	fmul    $f11, $f3, $f12
	fmul    $f12, $f10, $f10
	fadd    $f10, $f7, $f7
	fadd    $f7, $f4, $f4
	bne     $i5, 0, be_else.22145
be_then.22145:
	mov     $f4, $f1
.count b_cont
	b       be_cont.22145
be_else.22145:
	fmul    $f5, $f2, $f7
	fmul    $f8, $f1, $f10
	fadd    $f7, $f10, $f7
	load    [$i1 + 9], $i2
	load    [$i2 + 0], $f10
	fmul    $f7, $f10, $f7
	fmul    $f11, $f1, $f1
	fmul    $f5, $f3, $f5
	fadd    $f1, $f5, $f1
	load    [$i1 + 9], $i2
	load    [$i2 + 1], $f5
	fmul    $f1, $f5, $f1
	fadd    $f7, $f1, $f1
	fmul    $f11, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [$i1 + 9], $i2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
be_cont.22145:
	fmul    $f1, $f1, $f2
	fsub    $f2, $f9, $f2
	bg      $f2, $f0, ble_else.22146
ble_then.22146:
	li      0, $i14
.count b_cont
	b       ble_cont.22146
ble_else.22146:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	li      1, $i14
	finv    $f6, $f3
	bne     $i1, 0, be_else.22147
be_then.22147:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.22147
be_else.22147:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
be_cont.22147:
ble_cont.22146:
be_cont.22142:
be_cont.22139:
be_cont.22115:
	bne     $i14, 0, be_else.22148
be_then.22148:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22149
be_then.22149:
	jr      $ra1
be_else.22149:
	add     $i10, 1, $i10
	b       solve_each_element.2871
be_else.22148:
	bg      $fg0, $f0, ble_else.22150
ble_then.22150:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.22150:
	bg      $fg7, $fg0, ble_else.22151
ble_then.22151:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.22151:
	fadd    $fg0, $fc15, $f11
	load    [$i12 + 2], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg19, $f12
	load    [$i12 + 1], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg18, $f13
	load    [$i12 + 0], $f1
	fmul    $f1, $f11, $f1
	fadd    $f1, $fg17, $f14
	li      0, $i1
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $f14, $f2
.count move_args
	mov     $f13, $f3
.count move_args
	mov     $f12, $f4
	call    check_all_inside.2856
	add     $i10, 1, $i10
	be      $i1, 0, solve_each_element.2871
	mov     $f11, $fg7
	store   $f14, [ext_intersection_point + 0]
	store   $f13, [ext_intersection_point + 1]
	store   $f12, [ext_intersection_point + 2]
	mov     $i13, $ig4
	mov     $i14, $ig2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22153
be_then.22153:
	jr      $ra2
be_else.22153:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22154
be_then.22154:
	jr      $ra2
be_else.22154:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22155
be_then.22155:
	jr      $ra2
be_else.22155:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22156
be_then.22156:
	jr      $ra2
be_else.22156:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22157
be_then.22157:
	jr      $ra2
be_else.22157:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22158
be_then.22158:
	jr      $ra2
be_else.22158:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22159
be_then.22159:
	jr      $ra2
be_else.22159:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element.2871, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22160
be_then.22160:
	jr      $ra2
be_else.22160:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
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
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22161
be_then.22161:
	jr      $ra3
be_else.22161:
	bne     $i1, 99, be_else.22162
be_then.22162:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.22163
bne_then.22163:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.22164
bne_then.22164:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.22165
bne_then.22165:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.22166
bne_then.22166:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.22167
bne_then.22167:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.22168
bne_then.22168:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	li      7, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
bne_cont.22168:
bne_cont.22167:
bne_cont.22166:
bne_cont.22165:
bne_cont.22164:
bne_cont.22163:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22169
be_then.22169:
	jr      $ra3
be_else.22169:
	bne     $i1, 99, be_else.22170
be_then.22170:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22171
be_then.22171:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22171:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22172
be_then.22172:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22172:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22173
be_then.22173:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22173:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22174
be_then.22174:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22174:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element.2871, $ra1
	li      5, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22170:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22175
be_then.22175:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22175:
	bg      $fg7, $fg0, ble_else.22176
ble_then.22176:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.22176:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network.2875, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22162:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22177
be_then.22177:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.22177:
	bg      $fg7, $fg0, ble_else.22178
ble_then.22178:
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.22178:
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
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.22179
be_then.22179:
	jr      $ra1
be_else.22179:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 10], $i2
	load    [$i1 + 1], $i3
	load    [$i12 + 1], $i4
	load    [$i4 + $i13], $i4
	load    [$i2 + 2], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 0], $f3
	bne     $i3, 1, be_else.22180
be_then.22180:
	load    [$i12 + 0], $i2
	load    [$i4 + 1], $f4
	load    [$i4 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f6
	bg      $f6, $f5, ble_else.22181
ble_then.22181:
	li      0, $i3
.count b_cont
	b       ble_cont.22181
ble_else.22181:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22182
ble_then.22182:
	li      0, $i3
.count b_cont
	b       ble_cont.22182
ble_else.22182:
	load    [$i4 + 1], $f5
	bne     $f5, $f0, be_else.22183
be_then.22183:
	li      0, $i3
.count b_cont
	b       be_cont.22183
be_else.22183:
	li      1, $i3
be_cont.22183:
ble_cont.22182:
ble_cont.22181:
	bne     $i3, 0, be_else.22184
be_then.22184:
	load    [$i4 + 3], $f4
	load    [$i4 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i2 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i1 + 4], $i3
	load    [$i3 + 0], $f6
	bg      $f6, $f5, ble_else.22185
ble_then.22185:
	li      0, $i3
.count b_cont
	b       ble_cont.22185
ble_else.22185:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.22186
ble_then.22186:
	li      0, $i3
.count b_cont
	b       ble_cont.22186
ble_else.22186:
	load    [$i4 + 3], $f5
	bne     $f5, $f0, be_else.22187
be_then.22187:
	li      0, $i3
.count b_cont
	b       be_cont.22187
be_else.22187:
	li      1, $i3
be_cont.22187:
ble_cont.22186:
ble_cont.22185:
	bne     $i3, 0, be_else.22188
be_then.22188:
	load    [$i4 + 5], $f4
	load    [$i4 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i2 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i1 + 4], $i3
	load    [$i3 + 0], $f4
	bg      $f4, $f3, ble_else.22189
ble_then.22189:
	li      0, $i14
.count b_cont
	b       be_cont.22180
ble_else.22189:
	load    [$i2 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f3
	bg      $f3, $f2, ble_else.22190
ble_then.22190:
	li      0, $i14
.count b_cont
	b       be_cont.22180
ble_else.22190:
	load    [$i4 + 5], $f2
	bne     $f2, $f0, be_else.22191
be_then.22191:
	li      0, $i14
.count b_cont
	b       be_cont.22180
be_else.22191:
	mov     $f1, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.22180
be_else.22188:
	mov     $f4, $fg0
	li      2, $i14
.count b_cont
	b       be_cont.22180
be_else.22184:
	mov     $f4, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22180
be_else.22180:
	bne     $i3, 2, be_else.22192
be_then.22192:
	load    [$i4 + 0], $f1
	bg      $f0, $f1, ble_else.22193
ble_then.22193:
	li      0, $i14
.count b_cont
	b       be_cont.22192
ble_else.22193:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.22192
be_else.22192:
	load    [$i4 + 0], $f4
	bne     $f4, $f0, be_else.22194
be_then.22194:
	li      0, $i14
.count b_cont
	b       be_cont.22194
be_else.22194:
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
	bg      $f2, $f0, ble_else.22195
ble_then.22195:
	li      0, $i14
.count b_cont
	b       ble_cont.22195
ble_else.22195:
	load    [$i1 + 6], $i1
	li      1, $i14
	fsqrt   $f2, $f2
	load    [$i4 + 4], $f3
	bne     $i1, 0, be_else.22196
be_then.22196:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
.count b_cont
	b       be_cont.22196
be_else.22196:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
be_cont.22196:
ble_cont.22195:
be_cont.22194:
be_cont.22192:
be_cont.22180:
	bne     $i14, 0, be_else.22197
be_then.22197:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.22198
be_then.22198:
	jr      $ra1
be_else.22198:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
be_else.22197:
	bg      $fg0, $f0, ble_else.22199
ble_then.22199:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.22199:
	load    [$i12 + 0], $i1
	bg      $fg7, $fg0, ble_else.22200
ble_then.22200:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.22200:
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
	mov     $i11, $i3
.count move_args
	mov     $f14, $f2
.count move_args
	mov     $f13, $f3
.count move_args
	mov     $f12, $f4
	call    check_all_inside.2856
	add     $i10, 1, $i10
	be      $i1, 0, solve_each_element_fast.2885
	mov     $f11, $fg7
	store   $f14, [ext_intersection_point + 0]
	store   $f13, [ext_intersection_point + 1]
	store   $f12, [ext_intersection_point + 2]
	mov     $i13, $ig4
	mov     $i14, $ig2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i15, $i16, $i17)
# $ra = $ra2
# [$i1 - $i17]
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22202
be_then.22202:
	jr      $ra2
be_else.22202:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22203
be_then.22203:
	jr      $ra2
be_else.22203:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22204
be_then.22204:
	jr      $ra2
be_else.22204:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22205
be_then.22205:
	jr      $ra2
be_else.22205:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22206
be_then.22206:
	jr      $ra2
be_else.22206:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22207
be_then.22207:
	jr      $ra2
be_else.22207:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22208
be_then.22208:
	jr      $ra2
be_else.22208:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i17, $i12
	jal     solve_each_element_fast.2885, $ra1
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.22209
be_then.22209:
	jr      $ra2
be_else.22209:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
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
# [$f1 - $f14]
# [$ig2, $ig4]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22210
be_then.22210:
	jr      $ra3
be_else.22210:
	bne     $i1, 99, be_else.22211
be_then.22211:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.22212
bne_then.22212:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.22213
bne_then.22213:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.22214
bne_then.22214:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.22215
bne_then.22215:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.22216
bne_then.22216:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.22217
bne_then.22217:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      7, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
bne_cont.22217:
bne_cont.22216:
bne_cont.22215:
bne_cont.22214:
bne_cont.22213:
bne_cont.22212:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.22218
be_then.22218:
	jr      $ra3
be_else.22218:
	bne     $i1, 99, be_else.22219
be_then.22219:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22220
be_then.22220:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22220:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22221
be_then.22221:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22221:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22222
be_then.22222:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22222:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22223
be_then.22223:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22223:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i20, $i12
	jal     solve_each_element_fast.2885, $ra1
	li      5, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22219:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22224
be_then.22224:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22224:
	bg      $fg7, $fg0, ble_else.22225
ble_then.22225:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.22225:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	jal     solve_one_or_network_fast.2889, $ra2
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22211:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22226
be_then.22226:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.22226:
	bg      $fg7, $fg0, ble_else.22227
ble_then.22227:
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.22227:
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
# [$fg11, $fg14, $fg16]
######################################################################
.begin utexture
utexture.2908:
	load    [$i1 + 8], $i2
	load    [$i2 + 0], $fg16
	load    [$i1 + 8], $i2
	load    [$i2 + 1], $fg11
	load    [$i1 + 8], $i2
	load    [$i2 + 2], $fg14
	load    [$i1 + 0], $i2
	bne     $i2, 1, be_else.22228
be_then.22228:
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [$i2 + 0], $f1
	load    [ext_intersection_point + 0], $f2
	fsub    $f2, $f1, $f4
.count load_float
	load    [f.21637], $f5
.count load_float
	load    [f.21638], $f6
	fmul    $f4, $f6, $f2
	call    ext_floor
	fmul    $f1, $f5, $f1
	fsub    $f4, $f1, $f1
.count load_float
	load    [f.21639], $f4
	bg      $f4, $f1, ble_else.22229
ble_then.22229:
	li      0, $i2
.count b_cont
	b       ble_cont.22229
ble_else.22229:
	li      1, $i2
ble_cont.22229:
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f7
	fmul    $f7, $f6, $f2
	call    ext_floor
	fmul    $f1, $f5, $f1
	fsub    $f7, $f1, $f1
	bg      $f4, $f1, ble_else.22230
ble_then.22230:
	bne     $i2, 0, be_else.22231
be_then.22231:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22231:
	mov     $f0, $fg11
	jr      $ra1
ble_else.22230:
	bne     $i2, 0, be_else.22232
be_then.22232:
	mov     $f0, $fg11
	jr      $ra1
be_else.22232:
	mov     $fc9, $fg11
	jr      $ra1
be_else.22228:
	bne     $i2, 2, be_else.22233
be_then.22233:
.count load_float
	load    [f.21636], $f1
	load    [ext_intersection_point + 1], $f2
	fmul    $f2, $f1, $f2
	call    ext_sin
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	jr      $ra1
be_else.22233:
	bne     $i2, 3, be_else.22234
be_then.22234:
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [$i2 + 2], $f1
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
be_else.22234:
	bne     $i2, 4, be_else.22235
be_then.22235:
	load    [$i1 + 4], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 5], $i5
	load    [$i2 + 2], $f1
	fsqrt   $f1, $f1
	load    [$i3 + 2], $f2
	load    [ext_intersection_point + 2], $f3
	fsub    $f3, $f2, $f2
	fmul    $f2, $f1, $f6
	load    [$i4 + 0], $f1
	fsqrt   $f1, $f1
	load    [$i5 + 0], $f2
	load    [ext_intersection_point + 0], $f3
	fsub    $f3, $f2, $f2
	fmul    $f2, $f1, $f7
	fabs    $f7, $f1
.count load_float
	load    [f.21626], $f8
	bg      $f8, $f1, ble_else.22236
ble_then.22236:
	finv    $f7, $f1
	fmul_a  $f6, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21628], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21630], $f2
.count load_float
	load    [f.21631], $f2
	fmul    $f2, $f1, $f9
.count b_cont
	b       ble_cont.22236
ble_else.22236:
.count load_float
	load    [f.21627], $f9
ble_cont.22236:
	load    [$i1 + 4], $i2
	load    [$i1 + 5], $i1
	fmul    $f6, $f6, $f1
	fmul    $f7, $f7, $f2
	fadd    $f2, $f1, $f1
	load    [$i2 + 1], $f2
	fsqrt   $f2, $f2
	load    [$i1 + 1], $f3
	load    [ext_intersection_point + 1], $f4
	fsub    $f4, $f3, $f3
	fmul    $f3, $f2, $f2
	fabs    $f1, $f3
	bg      $f8, $f3, ble_else.22237
ble_then.22237:
	finv    $f1, $f1
	fmul_a  $f2, $f1, $f2
	call    ext_atan
.count load_float
	load    [f.21628], $f2
	fmul    $f1, $f2, $f2
.count load_float
	load    [f.21630], $f2
.count load_float
	load    [f.21631], $f2
	fmul    $f2, $f1, $f4
.count b_cont
	b       ble_cont.22237
ble_else.22237:
.count load_float
	load    [f.21627], $f4
ble_cont.22237:
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
	load    [f.21632], $f2
	fsub    $f2, $f1, $f1
	fsub    $f1, $f4, $f1
	bg      $f0, $f1, ble_else.22238
ble_then.22238:
.count load_float
	load    [f.21633], $f2
	fmul    $f2, $f1, $fg14
	jr      $ra1
ble_else.22238:
	mov     $f0, $fg14
	jr      $ra1
be_else.22235:
	jr      $ra1
.end utexture

######################################################################
# trace_reflections($i21, $f15, $f16, $i22)
# $ra = $ra4
# [$i1 - $i24]
# [$f1 - $f16]
# [$ig2, $ig4]
# [$fg0, $fg4 - $fg7]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i21, 0, bge_else.22239
bge_then.22239:
	load    [ext_reflections + $i21], $i23
	load    [$i23 + 1], $i24
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22240
bne_then.22240:
	bne     $i1, 99, be_else.22241
be_then.22241:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22242
be_then.22242:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22241
be_else.22242:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22243
be_then.22243:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22241
be_else.22243:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22244
be_then.22244:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22241
be_else.22244:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i24, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22245
be_then.22245:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22241
be_else.22245:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
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
	b       be_cont.22241
be_else.22241:
.count move_args
	mov     $i24, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22246
be_then.22246:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22246
be_else.22246:
	bg      $fg7, $fg0, ble_else.22247
ble_then.22247:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22247
ble_else.22247:
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
ble_cont.22247:
be_cont.22246:
be_cont.22241:
bne_cont.22240:
	bg      $fg7, $fc7, ble_else.22248
ble_then.22248:
	li      0, $i1
.count b_cont
	b       ble_cont.22248
ble_else.22248:
	bg      $fc12, $fg7, ble_else.22249
ble_then.22249:
	li      0, $i1
.count b_cont
	b       ble_cont.22249
ble_else.22249:
	li      1, $i1
ble_cont.22249:
ble_cont.22248:
	bne     $i1, 0, be_else.22250
be_then.22250:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.22250:
	load    [$i23 + 0], $i1
	add     $ig4, $ig4, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, be_else.22251
be_then.22251:
	li      0, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
	bne     $i1, 0, be_else.22252
be_then.22252:
	load    [$i23 + 2], $f1
	load    [$i24 + 0], $i1
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
	ble     $f3, $f0, bg_cont.22253
bg_then.22253:
	fmul    $f3, $fg16, $f5
	fadd    $fg4, $f5, $fg4
	fmul    $f3, $fg11, $f5
	fadd    $fg5, $f5, $fg5
	fmul    $f3, $fg14, $f3
	fadd    $fg6, $f3, $fg6
bg_cont.22253:
	load    [$i22 + 2], $f3
	fmul    $f3, $f2, $f2
	load    [$i22 + 1], $f3
	fmul    $f3, $f4, $f3
	load    [$i22 + 0], $f4
	fmul    $f4, $f6, $f4
	fadd    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fmul    $f1, $f2, $f1
	sub     $i21, 1, $i21
	ble     $f1, $f0, trace_reflections.2915
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
be_else.22252:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.22251:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
bge_else.22239:
	jr      $ra4
.end trace_reflections

######################################################################
# trace_ray($i25, $f17, $i26, $i27, $f18)
# $ra = $ra5
# [$i1 - $i29]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0, $fg4 - $fg11, $fg14, $fg16 - $fg19]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i25, 4, ble_else.22255
ble_then.22255:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22256
bne_then.22256:
	bne     $i1, 99, be_else.22257
be_then.22257:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22258
be_then.22258:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22257
be_else.22258:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22259
be_then.22259:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22257
be_else.22259:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22260
be_then.22260:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22257
be_else.22260:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i26, $i12
	jal     solve_each_element.2871, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22261
be_then.22261:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22257
be_else.22261:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
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
	b       be_cont.22257
be_else.22257:
.count move_args
	mov     $i26, $i2
	call    solver.2773
	bne     $i1, 0, be_else.22262
be_then.22262:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       be_cont.22262
be_else.22262:
	bg      $fg7, $fg0, ble_else.22263
ble_then.22263:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	jal     trace_or_matrix.2879, $ra3
.count b_cont
	b       ble_cont.22263
ble_else.22263:
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
ble_cont.22263:
be_cont.22262:
be_cont.22257:
bne_cont.22256:
	load    [$i27 + 2], $i28
	bg      $fg7, $fc7, ble_else.22264
ble_then.22264:
	li      0, $i1
.count b_cont
	b       ble_cont.22264
ble_else.22264:
	bg      $fc12, $fg7, ble_else.22265
ble_then.22265:
	li      0, $i1
.count b_cont
	b       ble_cont.22265
ble_else.22265:
	li      1, $i1
ble_cont.22265:
ble_cont.22264:
	bne     $i1, 0, be_else.22266
be_then.22266:
	add     $i0, -1, $i1
.count storer
	add     $i28, $i25, $tmp
	store   $i1, [$tmp + 0]
	bne     $i25, 0, be_else.22267
be_then.22267:
	jr      $ra5
be_else.22267:
	load    [$i26 + 2], $f1
	fmul    $f1, $fg13, $f1
	load    [$i26 + 1], $f2
	fmul    $f2, $fg12, $f2
	load    [$i26 + 0], $f3
	fmul    $f3, $fg15, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	bg      $f1, $f0, ble_else.22268
ble_then.22268:
	jr      $ra5
ble_else.22268:
	load    [ext_beam + 0], $f2
	fmul    $f1, $f1, $f3
	fmul    $f3, $f1, $f1
	fmul    $f1, $f17, $f1
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	jr      $ra5
be_else.22266:
	load    [ext_objects + $ig4], $i29
	load    [$i29 + 1], $i1
	bne     $i1, 1, be_else.22269
be_then.22269:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i1
	load    [$i26 + $i1], $f1
	bne     $f1, $f0, be_else.22270
be_then.22270:
	store   $f0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22269
be_else.22270:
	bg      $f1, $f0, ble_else.22271
ble_then.22271:
	store   $fc0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22269
ble_else.22271:
	store   $fc3, [ext_nvector + $i1]
.count b_cont
	b       be_cont.22269
be_else.22269:
	bne     $i1, 2, be_else.22272
be_then.22272:
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
	b       be_cont.22272
be_else.22272:
	load    [$i29 + 5], $i1
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i29 + 5], $i1
	load    [$i1 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i29 + 5], $i1
	load    [$i1 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	load    [$i29 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f1, $f4, $f4
	load    [$i29 + 4], $i1
	load    [$i1 + 1], $f5
	fmul    $f2, $f5, $f5
	load    [$i29 + 4], $i1
	load    [$i1 + 0], $f6
	fmul    $f3, $f6, $f6
	load    [$i29 + 3], $i1
	bne     $i1, 0, be_else.22273
be_then.22273:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
.count b_cont
	b       be_cont.22273
be_else.22273:
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f2, $f7, $f7
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f6
	fmul    $f3, $f6, $f6
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22273:
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	load    [$i29 + 6], $i1
	bne     $f1, $f0, be_else.22274
be_then.22274:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22274
be_else.22274:
	bne     $i1, 0, be_else.22275
be_then.22275:
	finv    $f1, $f1
.count b_cont
	b       be_cont.22275
be_else.22275:
	finv_n  $f1, $f1
be_cont.22275:
be_cont.22274:
	load    [ext_nvector + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22272:
be_cont.22269:
	load    [ext_intersection_point + 0], $fg17
	load    [ext_intersection_point + 1], $fg18
	load    [ext_intersection_point + 2], $fg19
.count move_args
	mov     $i29, $i1
	jal     utexture.2908, $ra1
	add     $ig4, $ig4, $i1
	add     $i1, $i1, $i1
	add     $i1, $ig2, $i1
.count storer
	add     $i28, $i25, $tmp
	store   $i1, [$tmp + 0]
	load    [$i27 + 1], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i1 + $i25], $i1
	store   $f1, [$i1 + 0]
	load    [ext_intersection_point + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_intersection_point + 2], $f1
	store   $f1, [$i1 + 2]
	load    [$i29 + 7], $i1
	load    [$i27 + 3], $i2
	load    [$i1 + 0], $f1
	fmul    $f1, $f17, $f15
.count storer
	add     $i2, $i25, $tmp
	bg      $fc4, $f1, ble_else.22276
ble_then.22276:
	li      1, $i1
	store   $i1, [$tmp + 0]
	load    [$i27 + 4], $i1
	load    [$i1 + $i25], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg14, [$i2 + 2]
	load    [$i1 + $i25], $i1
.count load_float
	load    [f.21642], $f1
.count load_float
	load    [f.21643], $f1
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
	load    [$i27 + 7], $i1
	load    [$i1 + $i25], $i1
	load    [ext_nvector + 0], $f1
	store   $f1, [$i1 + 0]
	load    [ext_nvector + 1], $f1
	store   $f1, [$i1 + 1]
	load    [ext_nvector + 2], $f1
	store   $f1, [$i1 + 2]
.count b_cont
	b       ble_cont.22276
ble_else.22276:
	li      0, $i1
	store   $i1, [$tmp + 0]
ble_cont.22276:
	load    [$i26 + 0], $f1
	load    [ext_nvector + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f3, $f2, $f2
	load    [ext_nvector + 1], $f3
	load    [$i26 + 1], $f4
	fmul    $f4, $f3, $f3
	load    [ext_nvector + 0], $f4
	fmul    $f1, $f4, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
.count load_float
	load    [f.21644], $f3
	fmul    $f3, $f2, $f2
	fmul    $f2, $f4, $f3
	fadd    $f1, $f3, $f1
	store   $f1, [$i26 + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i26 + 1], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [$i26 + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i26 + 2], $f2
	fadd    $f2, $f1, $f1
	store   $f1, [$i26 + 2]
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22277
be_then.22277:
	li      0, $i1
.count b_cont
	b       be_cont.22277
be_else.22277:
	bne     $i1, 99, be_else.22278
be_then.22278:
	li      1, $i1
.count b_cont
	b       be_cont.22278
be_else.22278:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22279
be_then.22279:
	li      0, $i1
.count b_cont
	b       be_cont.22279
be_else.22279:
	bg      $fc7, $fg0, ble_else.22280
ble_then.22280:
	li      0, $i1
.count b_cont
	b       ble_cont.22280
ble_else.22280:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22281
be_then.22281:
	li      0, $i1
.count b_cont
	b       be_cont.22281
be_else.22281:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22282
be_then.22282:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22283
be_then.22283:
	li      0, $i1
.count b_cont
	b       be_cont.22282
be_else.22283:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22284
be_then.22284:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22285
be_then.22285:
	li      0, $i1
.count b_cont
	b       be_cont.22282
be_else.22285:
	li      1, $i1
.count b_cont
	b       be_cont.22282
be_else.22284:
	li      1, $i1
.count b_cont
	b       be_cont.22282
be_else.22282:
	li      1, $i1
be_cont.22282:
be_cont.22281:
ble_cont.22280:
be_cont.22279:
be_cont.22278:
	bne     $i1, 0, be_else.22286
be_then.22286:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22286
be_else.22286:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22287
be_then.22287:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22287
be_else.22287:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22288
be_then.22288:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22289
be_then.22289:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22288
be_else.22289:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22290
be_then.22290:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22291
be_then.22291:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22288
be_else.22291:
	li      1, $i1
.count b_cont
	b       be_cont.22288
be_else.22290:
	li      1, $i1
.count b_cont
	b       be_cont.22288
be_else.22288:
	li      1, $i1
be_cont.22288:
be_cont.22287:
be_cont.22286:
be_cont.22277:
	load    [$i29 + 7], $i2
	load    [$i2 + 1], $f1
	fmul    $f17, $f1, $f16
	bne     $i1, 0, be_cont.22292
be_then.22292:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg15, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg12, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f15, $f1
	load    [$i26 + 0], $f2
	fmul    $f2, $fg15, $f2
	load    [$i26 + 1], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f2, $f3, $f2
	load    [$i26 + 2], $f3
	fmul    $f3, $fg13, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, bg_cont.22293
bg_then.22293:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg14, $f1
	fadd    $fg6, $f1, $fg6
bg_cont.22293:
	ble     $f2, $f0, bg_cont.22294
bg_then.22294:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f16, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
bg_cont.22294:
be_cont.22292:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	sub     $ig3, 1, $i21
.count move_args
	mov     $i26, $i22
	jal     trace_reflections.2915, $ra4
	bg      $f17, $fc10, ble_else.22295
ble_then.22295:
	jr      $ra5
ble_else.22295:
	bge     $i25, 4, bl_cont.22296
bl_then.22296:
	add     $i25, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i28, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.22296:
	load    [$i29 + 2], $i1
	bne     $i1, 2, be_else.22297
be_then.22297:
	load    [$i29 + 7], $i1
	load    [$i1 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f17, $f1, $f17
	add     $i25, 1, $i25
	fadd    $f18, $fg7, $f18
	b       trace_ray.2920
be_else.22297:
	jr      $ra5
ble_else.22255:
	jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i21, $f15)
# $ra = $ra4
# [$i1 - $i21]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
	mov     $fc13, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.22298
bne_then.22298:
	bne     $i1, 99, be_else.22299
be_then.22299:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.22300
be_then.22300:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22299
be_else.22300:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.22301
be_then.22301:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22299
be_else.22301:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.22302
be_then.22302:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22299
be_else.22302:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
.count move_args
	mov     $i21, $i12
	jal     solve_each_element_fast.2885, $ra1
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.22303
be_then.22303:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22299
be_else.22303:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
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
	b       be_cont.22299
be_else.22299:
.count move_args
	mov     $i21, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.22304
be_then.22304:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       be_cont.22304
be_else.22304:
	bg      $fg7, $fg0, ble_else.22305
ble_then.22305:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
	b       ble_cont.22305
ble_else.22305:
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
ble_cont.22305:
be_cont.22304:
be_cont.22299:
bne_cont.22298:
	bg      $fg7, $fc7, ble_else.22306
ble_then.22306:
	li      0, $i1
.count b_cont
	b       ble_cont.22306
ble_else.22306:
	bg      $fc12, $fg7, ble_else.22307
ble_then.22307:
	li      0, $i1
.count b_cont
	b       ble_cont.22307
ble_else.22307:
	li      1, $i1
ble_cont.22307:
ble_cont.22306:
	bne     $i1, 0, be_else.22308
be_then.22308:
	jr      $ra4
be_else.22308:
	load    [$i21 + 0], $i1
	load    [ext_objects + $ig4], $i17
	load    [$i17 + 1], $i2
	bne     $i2, 1, be_else.22309
be_then.22309:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i2
	load    [$i1 + $i2], $f1
	bne     $f1, $f0, be_else.22310
be_then.22310:
	store   $f0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22309
be_else.22310:
	bg      $f1, $f0, ble_else.22311
ble_then.22311:
	store   $fc0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22309
ble_else.22311:
	store   $fc3, [ext_nvector + $i2]
.count b_cont
	b       be_cont.22309
be_else.22309:
	bne     $i2, 2, be_else.22312
be_then.22312:
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
	b       be_cont.22312
be_else.22312:
	load    [$i17 + 5], $i1
	load    [$i1 + 2], $f1
	load    [ext_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i17 + 5], $i1
	load    [$i1 + 1], $f2
	load    [ext_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i17 + 5], $i1
	load    [$i1 + 0], $f3
	load    [ext_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	load    [$i17 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f1, $f4, $f4
	load    [$i17 + 4], $i1
	load    [$i1 + 1], $f5
	fmul    $f2, $f5, $f5
	load    [$i17 + 4], $i1
	load    [$i1 + 0], $f6
	fmul    $f3, $f6, $f6
	load    [$i17 + 3], $i1
	bne     $i1, 0, be_else.22313
be_then.22313:
	store   $f6, [ext_nvector + 0]
	store   $f5, [ext_nvector + 1]
	store   $f4, [ext_nvector + 2]
.count b_cont
	b       be_cont.22313
be_else.22313:
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f2, $f7, $f7
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f1, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc4, $f7
	fadd    $f6, $f7, $f6
	store   $f6, [ext_nvector + 0]
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f6
	fmul    $f3, $f6, $f6
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f1, $f7, $f1
	fadd    $f6, $f1, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f3, $f1, $f1
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc4, $f1
	fadd    $f4, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22313:
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_nvector + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	load    [$i17 + 6], $i1
	bne     $f1, $f0, be_else.22314
be_then.22314:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22314
be_else.22314:
	bne     $i1, 0, be_else.22315
be_then.22315:
	finv    $f1, $f1
.count b_cont
	b       be_cont.22315
be_else.22315:
	finv_n  $f1, $f1
be_cont.22315:
be_cont.22314:
	load    [ext_nvector + 0], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 0]
	load    [ext_nvector + 1], $f2
	fmul    $f2, $f1, $f2
	store   $f2, [ext_nvector + 1]
	load    [ext_nvector + 2], $f2
	fmul    $f2, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.22312:
be_cont.22309:
.count move_args
	mov     $i17, $i1
	jal     utexture.2908, $ra1
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.22316
be_then.22316:
	li      0, $i1
.count b_cont
	b       be_cont.22316
be_else.22316:
	bne     $i1, 99, be_else.22317
be_then.22317:
	li      1, $i1
.count b_cont
	b       be_cont.22317
be_else.22317:
	call    solver_fast.2796
	bne     $i1, 0, be_else.22318
be_then.22318:
	li      0, $i1
.count b_cont
	b       be_cont.22318
be_else.22318:
	bg      $fc7, $fg0, ble_else.22319
ble_then.22319:
	li      0, $i1
.count b_cont
	b       ble_cont.22319
ble_else.22319:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22320
be_then.22320:
	li      0, $i1
.count b_cont
	b       be_cont.22320
be_else.22320:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22321
be_then.22321:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22322
be_then.22322:
	li      0, $i1
.count b_cont
	b       be_cont.22321
be_else.22322:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22323
be_then.22323:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22324
be_then.22324:
	li      0, $i1
.count b_cont
	b       be_cont.22321
be_else.22324:
	li      1, $i1
.count b_cont
	b       be_cont.22321
be_else.22323:
	li      1, $i1
.count b_cont
	b       be_cont.22321
be_else.22321:
	li      1, $i1
be_cont.22321:
be_cont.22320:
ble_cont.22319:
be_cont.22318:
be_cont.22317:
	bne     $i1, 0, be_else.22325
be_then.22325:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22325
be_else.22325:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.22326
be_then.22326:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22326
be_else.22326:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22327
be_then.22327:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.22328
be_then.22328:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22327
be_else.22328:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	jal     shadow_check_and_group.2862, $ra1
	bne     $i1, 0, be_else.22329
be_then.22329:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	jal     shadow_check_one_or_group.2865, $ra2
	bne     $i1, 0, be_else.22330
be_then.22330:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
	b       be_cont.22327
be_else.22330:
	li      1, $i1
.count b_cont
	b       be_cont.22327
be_else.22329:
	li      1, $i1
.count b_cont
	b       be_cont.22327
be_else.22327:
	li      1, $i1
be_cont.22327:
be_cont.22326:
be_cont.22325:
be_cont.22316:
	bne     $i1, 0, be_else.22331
be_then.22331:
	load    [$i17 + 7], $i1
	load    [$i1 + 0], $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg13, $f2
	load    [ext_nvector + 1], $f3
	fmul    $f3, $fg12, $f3
	load    [ext_nvector + 0], $f4
	fmul    $f4, $fg15, $f4
	fadd    $f4, $f3, $f3
	fadd_n  $f3, $f2, $f2
	bg      $f2, $f0, ble_cont.22332
ble_then.22332:
	mov     $f0, $f2
ble_cont.22332:
	fmul    $f15, $f2, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg14, $f1
	fadd    $fg3, $f1, $fg3
	jr      $ra4
be_else.22331:
	jr      $ra4
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i22, $i23, $i24)
# $ra = $ra5
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7, $fg11, $fg14, $fg16]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i24, 0, bge_else.22333
bge_then.22333:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22334
ble_then.22334:
	load    [$i22 + $i24], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.22335
bge_then.22335:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22336
ble_then.22336:
	load    [$i22 + $i24], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.22336:
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.22335:
	jr      $ra5
ble_else.22334:
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.22337
bge_then.22337:
	load    [$i22 + $i24], $i1
	load    [$i1 + 0], $i1
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22338
ble_then.22338:
	load    [$i22 + $i24], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.22338:
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.22337:
	jr      $ra5
bge_else.22333:
	jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i25, $i26)
# $ra = $ra6
# [$i1 - $i29]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
	load    [$i25 + 5], $i1
	load    [$i1 + $i26], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i25 + 6], $i1
	load    [$i25 + 1], $i2
	load    [$i25 + 7], $i3
	load    [$i1 + 0], $i27
	load    [$i2 + $i26], $i28
	load    [$i3 + $i26], $i29
	be      $i27, 0, bne_cont.22339
bne_then.22339:
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
	bg      $f0, $f1, ble_else.22340
ble_then.22340:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22340
ble_else.22340:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22340:
bne_cont.22339:
	be      $i27, 1, bne_cont.22341
bne_then.22341:
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
	bg      $f0, $f1, ble_else.22342
ble_then.22342:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22342
ble_else.22342:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22342:
bne_cont.22341:
	be      $i27, 2, bne_cont.22343
bne_then.22343:
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
	bg      $f0, $f1, ble_else.22344
ble_then.22344:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22344
ble_else.22344:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22344:
bne_cont.22343:
	be      $i27, 3, bne_cont.22345
bne_then.22345:
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
	bg      $f0, $f1, ble_else.22346
ble_then.22346:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22346
ble_else.22346:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22346:
bne_cont.22345:
	be      $i27, 4, bne_cont.22347
bne_then.22347:
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
	bg      $f0, $f1, ble_else.22348
ble_then.22348:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22348
ble_else.22348:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i29, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22348:
bne_cont.22347:
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
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i25, 4, ble_else.22349
ble_then.22349:
	load    [$i30 + 2], $i26
	load    [$i26 + $i25], $i1
	bl      $i1, 0, bge_else.22350
bge_then.22350:
	load    [$i30 + 3], $i27
	load    [$i27 + $i25], $i1
	bne     $i1, 0, be_else.22351
be_then.22351:
	add     $i25, 1, $i31
	bg      $i31, 4, ble_else.22352
ble_then.22352:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.22353
bge_then.22353:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.22354
be_then.22354:
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.22354:
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.22353:
	jr      $ra7
ble_else.22352:
	jr      $ra7
be_else.22351:
	load    [$i30 + 5], $i1
	load    [$i1 + $i25], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	load    [$i30 + 6], $i1
	load    [$i30 + 1], $i2
	load    [$i30 + 7], $i3
	load    [$i1 + 0], $i28
	load    [$i2 + $i25], $i29
	load    [$i3 + $i25], $i31
	be      $i28, 0, bne_cont.22355
bne_then.22355:
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
	load    [$i31 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i31 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i31 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22356
ble_then.22356:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22356
ble_else.22356:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22356:
bne_cont.22355:
	be      $i28, 1, bne_cont.22357
bne_then.22357:
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
	load    [$i31 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i31 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i31 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22358
ble_then.22358:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22358
ble_else.22358:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22358:
bne_cont.22357:
	be      $i28, 2, bne_cont.22359
bne_then.22359:
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
	load    [$i31 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i31 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i31 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22360
ble_then.22360:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22360
ble_else.22360:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22360:
bne_cont.22359:
	be      $i28, 3, bne_cont.22361
bne_then.22361:
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
	load    [$i31 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i31 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i31 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22362
ble_then.22362:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22362
ble_else.22362:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22362:
bne_cont.22361:
	be      $i28, 4, bne_cont.22363
bne_then.22363:
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
	load    [$i31 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i31 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i31 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22364
ble_then.22364:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22364
ble_else.22364:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
.count move_args
	mov     $i31, $i23
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22364:
bne_cont.22363:
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
	bg      $i31, 4, ble_else.22365
ble_then.22365:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.22366
bge_then.22366:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.22367
be_then.22367:
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.22367:
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.22366:
	jr      $ra7
ble_else.22365:
	jr      $ra7
bge_else.22350:
	jr      $ra7
ble_else.22349:
	jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i30)
# $ra = $ra7
# [$i1 - $i31]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i30, 4, ble_else.22368
ble_then.22368:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i30], $i6
	bl      $i6, 0, bge_else.22369
bge_then.22369:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22370
be_then.22370:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22371
be_then.22371:
	sub     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22372
be_then.22372:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.22373
be_then.22373:
	li      1, $i6
.count b_cont
	b       be_cont.22370
be_else.22373:
	li      0, $i6
.count b_cont
	b       be_cont.22370
be_else.22372:
	li      0, $i6
.count b_cont
	b       be_cont.22370
be_else.22371:
	li      0, $i6
.count b_cont
	b       be_cont.22370
be_else.22370:
	li      0, $i6
be_cont.22370:
	bne     $i6, 0, be_else.22374
be_then.22374:
	bg      $i30, 4, ble_else.22375
ble_then.22375:
	load    [$i4 + $i2], $i31
	load    [$i31 + 2], $i1
	load    [$i1 + $i30], $i1
	bl      $i1, 0, bge_else.22376
bge_then.22376:
	load    [$i31 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.22377
be_then.22377:
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
be_else.22377:
.count move_args
	mov     $i31, $i25
.count move_args
	mov     $i30, $i26
	jal     calc_diffuse_using_1point.2942, $ra6
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
bge_else.22376:
	jr      $ra7
ble_else.22375:
	jr      $ra7
be_else.22374:
	load    [$i1 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.22378
be_then.22378:
	add     $i30, 1, $i30
	b       try_exploit_neighbors.2967
be_else.22378:
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
bge_else.22369:
	jr      $ra7
ble_else.22368:
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
# [$i1 - $i3]
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
	call    ext_int_of_float
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      255, $i2
	bg      $i1, $i2, ble_else.22379
ble_then.22379:
	bl      $i1, 0, bge_else.22380
bge_then.22380:
.count move_args
	mov     $i1, $i2
	b       ext_write
bge_else.22380:
	li      0, $i2
	b       ext_write
ble_else.22379:
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
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg3, $fg7 - $fg11, $fg14, $fg16]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i26, 4, ble_else.22381
ble_then.22381:
	load    [$i25 + 2], $i27
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22382
bge_then.22382:
	load    [$i25 + 3], $i28
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22383
be_then.22383:
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.22384
ble_then.22384:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22385
bge_then.22385:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22386
be_then.22386:
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.22386:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 1], $i1
	load    [$i25 + 7], $i10
	load    [$i25 + 6], $i11
	load    [$i1 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i11 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i10 + $i26], $i23
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22387
ble_then.22387:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22387
ble_else.22387:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22387:
	load    [$i25 + 5], $i1
	load    [$i1 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.22385:
	jr      $ra6
ble_else.22384:
	jr      $ra6
be_else.22383:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 1], $i29
	load    [$i25 + 7], $i30
	load    [$i25 + 6], $i10
	load    [$i29 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i30 + $i26], $i23
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22388
ble_then.22388:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
.count b_cont
	b       ble_cont.22388
ble_else.22388:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
ble_cont.22388:
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
	load    [$i25 + 5], $i31
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.22389
ble_then.22389:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.22390
bge_then.22390:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.22391
be_then.22391:
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.22391:
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i25 + 6], $i10
	load    [$i29 + $i26], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i1
	load    [ext_dirvecs + $i1], $i22
	load    [$i22 + 118], $i1
	load    [$i1 + 0], $i1
	load    [$i30 + $i26], $i23
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22392
ble_then.22392:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22392
ble_else.22392:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22392:
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.22390:
	jr      $ra6
ble_else.22389:
	jr      $ra6
bge_else.22382:
	jr      $ra6
ble_else.22381:
	jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i32, $i33, $i34, $f1, $f2, $f3)
# $ra = $ra7
# [$i1 - $i35]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i33, 0, bge_else.22393
bge_then.22393:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $f3, [$sp + 0]
.count stack_store
	store   $f2, [$sp + 1]
.count stack_store
	store   $f1, [$sp + 2]
	load    [ext_screenx_dir + 0], $f4
	sub     $i33, 64, $i2
	call    ext_float_of_int
	fmul    $f1, $f4, $f2
.count stack_load
	load    [$sp + 2], $f3
	fadd    $f2, $f3, $f2
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
	load    [ext_ptrace_dirvec + 2], $f1
	fmul    $f1, $f1, $f1
	load    [ext_ptrace_dirvec + 1], $f2
	fmul    $f2, $f2, $f2
	load    [ext_ptrace_dirvec + 0], $f3
	fmul    $f3, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fsqrt   $f1, $f1
	bne     $f1, $f0, be_else.22394
be_then.22394:
	mov     $fc0, $f1
.count b_cont
	b       be_cont.22394
be_else.22394:
	finv    $f1, $f1
be_cont.22394:
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
	load    [$i32 + $i33], $i27
	li      0, $i25
	li      ext_ptrace_dirvec, $i26
.count move_args
	mov     $fc0, $f17
.count move_args
	mov     $f0, $f18
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
	bl      $i1, 0, bge_cont.22395
bge_then.22395:
	load    [$i25 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22396
be_then.22396:
	li      1, $i26
	jal     pretrace_diffuse_rays.2980, $ra6
.count b_cont
	b       be_cont.22396
be_else.22396:
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
	load    [$i23 + 2], $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i23 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i23 + 0], $f3
	load    [$i1 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.22397
ble_then.22397:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
	b       ble_cont.22397
ble_else.22397:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f15
	jal     trace_diffuse_ray.2926, $ra4
	li      116, $i24
	jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22397:
	load    [$i25 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i26
	jal     pretrace_diffuse_rays.2980, $ra6
be_cont.22396:
bge_cont.22395:
.count stack_move
	add     $sp, 3, $sp
	add     $i34, 1, $i34
.count move_args
	mov     $i35, $f2
.count stack_load
	load    [$sp - 3], $f3
.count stack_load
	load    [$sp - 1], $f1
	sub     $i33, 1, $i33
	bl      $i34, 5, pretrace_pixels.2983
	sub     $i34, 5, $i34
	b       pretrace_pixels.2983
bge_else.22393:
	jr      $ra7
.end pretrace_pixels

######################################################################
# scan_pixel($i32, $i33, $i34, $i35, $i36)
# $ra = $ra8
# [$i1 - $i36]
# [$f1 - $f15]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i32, ble_else.22399
ble_then.22399:
	jr      $ra8
ble_else.22399:
	load    [$i35 + $i32], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	add     $i33, 1, $i1
	li      128, $i2
	bg      $i2, $i1, ble_else.22400
ble_then.22400:
	li      0, $i1
.count b_cont
	b       ble_cont.22400
ble_else.22400:
	bg      $i33, 0, ble_else.22401
ble_then.22401:
	li      0, $i1
.count b_cont
	b       ble_cont.22401
ble_else.22401:
	li      128, $i1
	add     $i32, 1, $i2
	bg      $i1, $i2, ble_else.22402
ble_then.22402:
	li      0, $i1
.count b_cont
	b       ble_cont.22402
ble_else.22402:
	bg      $i32, 0, ble_else.22403
ble_then.22403:
	li      0, $i1
.count b_cont
	b       ble_cont.22403
ble_else.22403:
	li      1, $i1
ble_cont.22403:
ble_cont.22402:
ble_cont.22401:
ble_cont.22400:
	li      0, $i26
	bne     $i1, 0, be_else.22404
be_then.22404:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22404
bge_then.22405:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22406
be_then.22406:
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22404
be_else.22406:
.count move_args
	mov     $i30, $i25
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22404
be_else.22404:
	load    [$i35 + $i32], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bge_cont.22407
bge_then.22407:
	load    [$i34 + $i32], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22408
be_then.22408:
	load    [$i36 + $i32], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22409
be_then.22409:
	sub     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22410
be_then.22410:
	add     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.22411
be_then.22411:
	li      1, $i2
.count b_cont
	b       be_cont.22408
be_else.22411:
	li      0, $i2
.count b_cont
	b       be_cont.22408
be_else.22410:
	li      0, $i2
.count b_cont
	b       be_cont.22408
be_else.22409:
	li      0, $i2
.count b_cont
	b       be_cont.22408
be_else.22408:
	li      0, $i2
be_cont.22408:
	bne     $i2, 0, be_else.22412
be_then.22412:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.22412
bge_then.22413:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.22414
be_then.22414:
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22412
be_else.22414:
.count move_args
	mov     $i30, $i25
	jal     calc_diffuse_using_1point.2942, $ra6
	li      1, $i25
	jal     do_without_neighbors.2951, $ra7
.count b_cont
	b       be_cont.22412
be_else.22412:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i36, $i5
.count move_args
	mov     $i35, $i4
.count move_args
	mov     $i32, $i2
	li      1, $i30
	bne     $i1, 0, be_else.22415
be_then.22415:
.count move_args
	mov     $i34, $i3
	jal     try_exploit_neighbors.2967, $ra7
.count b_cont
	b       be_cont.22415
be_else.22415:
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
be_cont.22415:
be_cont.22412:
bge_cont.22407:
be_cont.22404:
	call    write_rgb.2978
	add     $i32, 1, $i32
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i37, $i38, $i39, $i40, $i41)
# $ra = $ra9
# [$i1 - $i41]
# [$f1 - $f18]
# [$ig2, $ig4]
# [$fg0 - $fg11, $fg14, $fg16 - $fg19]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i37, ble_else.22416
ble_then.22416:
	jr      $ra9
ble_else.22416:
	bge     $i37, 127, bl_cont.22417
bl_then.22417:
	add     $i37, 1, $i1
	sub     $i1, 64, $i2
	call    ext_float_of_int
	load    [ext_screeny_dir + 0], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg22, $f4
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f2
	fmul    $f1, $fg23, $f1
	fadd    $f1, $fg20, $f3
	li      127, $i33
.count move_args
	mov     $i40, $i32
.count move_args
	mov     $i41, $i34
.count move_args
	mov     $f4, $f1
	jal     pretrace_pixels.2983, $ra7
bl_cont.22417:
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
	add     $i41, 2, $i41
.count move_args
	mov     $i38, $tmp
.count move_args
	mov     $i39, $i38
.count move_args
	mov     $i40, $i39
.count move_args
	mov     $tmp, $i40
	add     $i37, 1, $i37
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
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i13, 0, bge_else.22419
bge_then.22419:
	jal     create_pixel.3008, $ra2
.count storer
	add     $i12, $i13, $tmp
	store   $i1, [$tmp + 0]
	sub     $i13, 1, $i13
	b       init_line_elements.3010
bge_else.22419:
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
	bl      $i1, 5, bge_else.22420
bge_then.22420:
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
bge_else.22420:
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
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i5, 0, bge_else.22421
bge_then.22421:
.count load_float
	load    [f.21659], $f15
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
	bl      $i5, 0, bge_else.22422
bge_then.22422:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22423
bge_then.22423:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22423
bge_else.22423:
	mov     $i1, $i6
bge_cont.22423:
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
	bl      $i5, 0, bge_else.22424
bge_then.22424:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f16
	fsub    $f16, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22425
bge_then.22425:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22425
bge_else.22425:
	mov     $i1, $i6
bge_cont.22425:
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
	bl      $i5, 0, bge_else.22426
bge_then.22426:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $f15, $f15
	fsub    $f15, $fc11, $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22427
bge_then.22427:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22427
bge_else.22427:
	mov     $i1, $i6
bge_cont.22427:
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
bge_else.22426:
	jr      $ra2
bge_else.22424:
	jr      $ra2
bge_else.22422:
	jr      $ra2
bge_else.22421:
	jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f17]
# []
# []
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i9, 0, bge_else.22429
bge_then.22429:
.count load_float
	load    [f.21659], $f17
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
	bl      $i1, 5, bge_else.22430
bge_then.22430:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22430
bge_else.22430:
	mov     $i1, $i6
bge_cont.22430:
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
	load    [f.21663], $f9
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.22431
bge_then.22431:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22431
bge_else.22431:
	mov     $i1, $i6
bge_cont.22431:
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
	bl      $i1, 5, bge_else.22432
bge_then.22432:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22432
bge_else.22432:
	mov     $i1, $i6
bge_cont.22432:
	li      1, $i5
.count move_args
	mov     $i11, $i7
	jal     calc_dirvecs.3028, $ra2
	sub     $i9, 1, $i9
	bl      $i9, 0, bge_else.22433
bge_then.22433:
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $f17, $f1
	fsub    $f1, $fc11, $f14
	li      0, $i1
	add     $i11, 4, $i11
	add     $i10, 2, $i2
	bl      $i2, 5, bge_else.22434
bge_then.22434:
	sub     $i2, 5, $i10
.count b_cont
	b       bge_cont.22434
bge_else.22434:
	mov     $i2, $i10
bge_cont.22434:
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
	bl      $i1, 5, bge_else.22435
bge_then.22435:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22435
bge_else.22435:
	mov     $i1, $i6
bge_cont.22435:
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
	bl      $i1, 5, bge_else.22436
bge_then.22436:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.22436
bge_else.22436:
	mov     $i1, $i6
bge_cont.22436:
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
bge_else.22433:
	jr      $ra3
bge_else.22429:
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
	bl      $i6, 0, bge_else.22438
bge_then.22438:
	jal     create_dirvec.3037, $ra1
.count storer
	add     $i5, $i6, $tmp
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i6
	b       create_dirvec_elements.3039
bge_else.22438:
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
	bl      $i7, 0, bge_else.22439
bge_then.22439:
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
bge_else.22439:
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
	bl      $i12, 0, bge_else.22440
bge_then.22440:
	load    [$i11 + $i12], $i8
	jal     setup_dirvec_constants.2829, $ra2
	sub     $i12, 1, $i12
	b       init_dirvec_constants.3044
bge_else.22440:
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
	bl      $i13, 0, bge_else.22441
bge_then.22441:
	li      119, $i12
	load    [ext_dirvecs + $i13], $i11
	jal     init_dirvec_constants.3044, $ra3
	sub     $i13, 1, $i13
	b       init_vecset_constants.3047
bge_else.22441:
	jr      $ra4
.end init_vecset_constants

######################################################################
# init_dirvecs()
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f17]
# []
# []
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
# [$ig3]
# []
######################################################################
.begin setup_rect_reflection
setup_rect_reflection.3058:
	load    [$i2 + 7], $i2
	fneg    $fg13, $f10
	fneg    $fg12, $f11
	load    [$i2 + 0], $f1
	fsub    $fc0, $f1, $f12
	add     $i1, $i1, $i1
	add     $i1, $i1, $i14
	add     $i14, 1, $i12
.count move_args
	mov     $ig3, $i11
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
	add     $i14, 2, $i12
	add     $ig3, 1, $i11
.count move_args
	mov     $f12, $f9
.count move_args
	mov     $f13, $f1
.count move_args
	mov     $fg12, $f3
.count move_args
	mov     $f10, $f4
	jal     add_reflection.3051, $ra3
	add     $i14, 3, $i12
	add     $ig3, 2, $i11
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
# [$i1 - $i13]
# [$f1 - $f9]
# [$ig3]
# []
######################################################################
.begin setup_surface_reflection
setup_surface_reflection.3061:
	load    [$i2 + 7], $i3
	load    [$i2 + 4], $i2
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i12
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
	mov     $ig3, $i11
	jal     add_reflection.3051, $ra3
	add     $ig3, 1, $ig3
	jr      $ra4
.end setup_surface_reflection

######################################################################
# setup_reflections($i1)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig3]
# []
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i1, 0, bge_else.22442
bge_then.22442:
	load    [ext_objects + $i1], $i2
	load    [$i2 + 2], $i3
	bne     $i3, 2, be_else.22443
be_then.22443:
	load    [$i2 + 7], $i3
	load    [$i3 + 0], $f1
	bg      $fc0, $f1, ble_else.22444
ble_then.22444:
	jr      $ra4
ble_else.22444:
	load    [$i2 + 1], $i3
	be      $i3, 1, setup_rect_reflection.3058
	be      $i3, 2, setup_surface_reflection.3061
	jr      $ra4
be_else.22443:
	jr      $ra4
bge_else.22442:
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
	store   $fg15, [$i1 + 0]
	store   $fg12, [$i1 + 1]
	store   $fg13, [$i1 + 2]
	jal     setup_dirvec_constants.2829, $ra2
	sub     $ig0, 1, $i1
	jal     setup_reflections.3064, $ra4
.count load_float
	load    [f.21671], $f1
	fmul    $f1, $fg23, $f2
	fadd    $f2, $fg20, $f3
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg21, $f2
	load    [ext_screeny_dir + 0], $f4
	fmul    $f1, $f4, $f1
	fadd    $f1, $fg22, $f1
	li      127, $i33
	li      0, $i34
.count move_args
	mov     $i39, $i32
	jal     pretrace_pixels.2983, $ra7
	li      2, $i41
	li      0, $i37
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
	load    [f.21621 + 0], $fc0
	load    [f.21646 + 0], $fc1
	load    [f.21645 + 0], $fc2
	load    [f.21620 + 0], $fc3
	load    [f.21622 + 0], $fc4
	load    [f.21648 + 0], $fc5
	load    [f.21647 + 0], $fc6
	load    [f.21625 + 0], $fc7
	load    [f.21619 + 0], $fc8
	load    [f.21635 + 0], $fc9
	load    [f.21634 + 0], $fc10
	load    [f.21658 + 0], $fc11
	load    [f.21641 + 0], $fc12
	load    [f.21640 + 0], $fc13
	load    [f.21629 + 0], $fc14
	load    [f.21624 + 0], $fc15
	load    [f.21603 + 0], $fc16
	load    [f.21662 + 0], $fc17
	load    [f.21661 + 0], $fc18
	load    [f.21660 + 0], $fc19
	jal     rt.3066, $ra9
.count stack_load_ra
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
.end main
