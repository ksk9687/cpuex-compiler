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
.define $ig0 $i55
.define $i55 orz
.define $ig1 $i56
.define $i56 orz
.define $ig2 $i57
.define $i57 orz
.define $ig3 $i58
.define $i58 orz
.define $ig4 $i59
.define $i59 orz
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
f.32088:	.float  -2.0000000000E+02
f.32087:	.float  2.0000000000E+02
f.32059:	.float  1.2800000000E+02
f.31997:	.float  9.0000000000E-01
f.31996:	.float  2.0000000000E-01
f.31968:	.float  1.5000000000E+02
f.31967:	.float  -1.5000000000E+02
f.31966:	.float  6.6666666667E-03
f.31965:	.float  -6.6666666667E-03
f.31964:	.float  -2.0000000000E+00
f.31963:	.float  3.9062500000E-03
f.31962:	.float  2.5600000000E+02
f.31961:	.float  1.0000000000E+08
f.31960:	.float  1.0000000000E+09
f.31959:	.float  1.0000000000E+01
f.31958:	.float  2.0000000000E+01
f.31957:	.float  5.0000000000E-02
f.31956:	.float  2.5000000000E-01
f.31955:	.float  1.0000000000E-01
f.31954:	.float  3.3333333333E+00
f.31953:	.float  2.5500000000E+02
f.31952:	.float  1.5000000000E-01
f.31951:	.float  3.1830988148E-01
f.31950:	.float  3.1415927000E+00
f.31949:	.float  3.0000000000E+01
f.31948:	.float  1.5000000000E+01
f.31947:	.float  1.0000000000E-04
f.31946:	.float  -1.0000000000E-01
f.31945:	.float  1.0000000000E-02
f.31944:	.float  -2.0000000000E-01
f.31943:	.float  5.0000000000E-01
f.31942:	.float  1.0000000000E+00
f.31941:	.float  -1.0000000000E+00
f.31940:	.float  2.0000000000E+00
f.31927:	.float  1.7453293000E-02

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra
# [$i1 - $i15]
# [$f1 - $f17]
# []
# []
######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
	call    ext_read_int
.count move_ret
	mov     $i1, $i7
	bne     $i7, -1, be_else.34729
be_then.34729:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	li      0, $i1
	ret
be_else.34729:
	call    ext_read_int
.count move_ret
	mov     $i1, $i8
	call    ext_read_int
.count move_ret
	mov     $i1, $i9
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
.count stack_store
	store   $i4, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i10 + 0]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i10 + 1]
	call    ext_read_float
	store   $f1, [$i10 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i11 + 0]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i11 + 1]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i11 + 2]
	call    ext_read_float
.count stack_store
	store   $f1, [$sp + 2]
	li      2, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i12 + 0]
	call    ext_read_float
	store   $f1, [$i12 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i13 + 0]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [$i13 + 1]
	call    ext_read_float
	store   $f1, [$i13 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
.count stack_load
	load    [$sp + 1], $i15
	be      $i15, 0, bne_cont.34730
bne_then.34730:
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
.count load_float
	load    [f.31927], $f3
	fmul    $f2, $f3, $f2
	store   $f2, [$i14 + 0]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	fmul    $f2, $f3, $f2
	store   $f2, [$i14 + 1]
	call    ext_read_float
	fmul    $f1, $f3, $f1
	store   $f1, [$i14 + 2]
bne_cont.34730:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 2], $f9
	bg      $f0, $f9, ble_else.34731
ble_then.34731:
	li      0, $i3
.count b_cont
	b       ble_cont.34731
ble_else.34731:
	li      1, $i3
ble_cont.34731:
	bne     $i8, 2, be_else.34732
be_then.34732:
	li      1, $i4
.count b_cont
	b       be_cont.34732
be_else.34732:
	mov     $i3, $i4
be_cont.34732:
	mov     $hp, $i5
	add     $hp, 11, $hp
	store   $i1, [$i5 + 10]
	store   $i14, [$i5 + 9]
	store   $i13, [$i5 + 8]
	store   $i12, [$i5 + 7]
	store   $i4, [$i5 + 6]
	store   $i11, [$i5 + 5]
	store   $i10, [$i5 + 4]
.count stack_load
	load    [$sp + 1], $i1
	store   $i1, [$i5 + 3]
	store   $i9, [$i5 + 2]
	store   $i8, [$i5 + 1]
	store   $i7, [$i5 + 0]
	store   $i5, [ext_objects + $i6]
	bne     $i8, 3, be_else.34733
be_then.34733:
	load    [$i10 + 0], $f9
	bne     $f9, $f0, be_else.34734
be_then.34734:
	mov     $f0, $f9
.count b_cont
	b       be_cont.34734
be_else.34734:
	bne     $f9, $f0, be_else.34735
be_then.34735:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
	mov     $f0, $f9
.count b_cont
	b       be_cont.34735
be_else.34735:
	bg      $f9, $f0, ble_else.34736
ble_then.34736:
	fmul    $f9, $f9, $f9
	finv_n  $f9, $f9
.count b_cont
	b       ble_cont.34736
ble_else.34736:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
ble_cont.34736:
be_cont.34735:
be_cont.34734:
	store   $f9, [$i10 + 0]
	load    [$i10 + 1], $f9
	bne     $f9, $f0, be_else.34737
be_then.34737:
	mov     $f0, $f9
.count b_cont
	b       be_cont.34737
be_else.34737:
	bne     $f9, $f0, be_else.34738
be_then.34738:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
	mov     $f0, $f9
.count b_cont
	b       be_cont.34738
be_else.34738:
	bg      $f9, $f0, ble_else.34739
ble_then.34739:
	fmul    $f9, $f9, $f9
	finv_n  $f9, $f9
.count b_cont
	b       ble_cont.34739
ble_else.34739:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
ble_cont.34739:
be_cont.34738:
be_cont.34737:
	store   $f9, [$i10 + 1]
	load    [$i10 + 2], $f9
	bne     $f9, $f0, be_else.34740
be_then.34740:
	mov     $f0, $f9
.count b_cont
	b       be_cont.34740
be_else.34740:
	bne     $f9, $f0, be_else.34741
be_then.34741:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
	mov     $f0, $f9
.count b_cont
	b       be_cont.34741
be_else.34741:
	bg      $f9, $f0, ble_else.34742
ble_then.34742:
	fmul    $f9, $f9, $f9
	finv_n  $f9, $f9
.count b_cont
	b       ble_cont.34742
ble_else.34742:
	fmul    $f9, $f9, $f9
	finv    $f9, $f9
ble_cont.34742:
be_cont.34741:
be_cont.34740:
	store   $f9, [$i10 + 2]
	bne     $i1, 0, be_else.34743
be_then.34743:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	li      1, $i1
	ret
be_else.34743:
	load    [$i14 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 3]
	load    [$i14 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	load    [$i14 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 4]
	load    [$i14 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i14 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
	load    [$i14 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $f2
	fmul    $f2, $f8, $f3
	fmul    $f3, $f3, $f4
	load    [$i10 + 0], $f5
	fmul    $f5, $f4, $f4
	fmul    $f2, $f1, $f6
	fmul    $f6, $f6, $f7
	load    [$i10 + 1], $f11
	fmul    $f11, $f7, $f7
	fadd    $f4, $f7, $f4
	fneg    $f10, $f7
	fmul    $f7, $f7, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f4, $f12, $f4
	store   $f4, [$i10 + 0]
	fmul    $f9, $f10, $f4
	fmul    $f4, $f8, $f12
.count stack_load
	load    [$sp - 6], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f5, $f15, $f15
	fmul    $f4, $f1, $f4
	fmul    $f14, $f8, $f16
	fadd    $f4, $f16, $f4
	fmul    $f4, $f4, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f2, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i10 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f8, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fsub    $f1, $f8, $f1
	fmul    $f1, $f1, $f8
	fmul    $f11, $f8, $f8
	fadd    $f17, $f8, $f8
	fmul    $f14, $f2, $f2
	fmul    $f2, $f2, $f9
	fmul    $f13, $f9, $f9
	fadd    $f8, $f9, $f8
	store   $f8, [$i10 + 2]
	fmul    $f5, $f12, $f8
	fmul    $f8, $f15, $f8
	fmul    $f11, $f4, $f9
	fmul    $f9, $f1, $f9
	fadd    $f8, $f9, $f8
	fmul    $f13, $f16, $f9
	fmul    $f9, $f2, $f9
	fadd    $f8, $f9, $f8
	fmul    $fc10, $f8, $f8
	store   $f8, [$i14 + 0]
	fmul    $f5, $f3, $f3
	fmul    $f3, $f15, $f5
	fmul    $f11, $f6, $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	fmul    $f13, $f7, $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 1]
	fmul    $f3, $f12, $f1
	fmul    $f6, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f5, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 2]
	li      1, $i1
	ret
be_else.34733:
	bne     $i8, 2, be_else.34744
be_then.34744:
	load    [$i10 + 0], $f9
	bne     $i3, 0, be_else.34745
be_then.34745:
	li      1, $i3
.count b_cont
	b       be_cont.34745
be_else.34745:
	li      0, $i3
be_cont.34745:
	fmul    $f9, $f9, $f10
	load    [$i10 + 1], $f11
	fmul    $f11, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i10 + 2], $f11
	fmul    $f11, $f11, $f11
	fadd    $f10, $f11, $f10
	fsqrt   $f10, $f10
	bne     $f10, $f0, be_else.34746
be_then.34746:
	mov     $fc0, $f10
.count b_cont
	b       be_cont.34746
be_else.34746:
	bne     $i3, 0, be_else.34747
be_then.34747:
	finv    $f10, $f10
.count b_cont
	b       be_cont.34747
be_else.34747:
	finv_n  $f10, $f10
be_cont.34747:
be_cont.34746:
	fmul    $f9, $f10, $f9
	store   $f9, [$i10 + 0]
	load    [$i10 + 1], $f9
	fmul    $f9, $f10, $f9
	store   $f9, [$i10 + 1]
	load    [$i10 + 2], $f9
	fmul    $f9, $f10, $f9
	store   $f9, [$i10 + 2]
	bne     $i1, 0, be_else.34748
be_then.34748:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	li      1, $i1
	ret
be_else.34748:
	load    [$i14 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 5]
	load    [$i14 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	load    [$i14 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 6]
	load    [$i14 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i14 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
	load    [$i14 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $f2
	fmul    $f2, $f8, $f3
	fmul    $f3, $f3, $f4
	load    [$i10 + 0], $f5
	fmul    $f5, $f4, $f4
	fmul    $f2, $f1, $f6
	fmul    $f6, $f6, $f7
	load    [$i10 + 1], $f11
	fmul    $f11, $f7, $f7
	fadd    $f4, $f7, $f4
	fneg    $f10, $f7
	fmul    $f7, $f7, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f4, $f12, $f4
	store   $f4, [$i10 + 0]
	fmul    $f9, $f10, $f4
	fmul    $f4, $f8, $f12
.count stack_load
	load    [$sp - 4], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f5, $f15, $f15
	fmul    $f4, $f1, $f4
	fmul    $f14, $f8, $f16
	fadd    $f4, $f16, $f4
	fmul    $f4, $f4, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f2, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i10 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f8, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fsub    $f1, $f8, $f1
	fmul    $f1, $f1, $f8
	fmul    $f11, $f8, $f8
	fadd    $f17, $f8, $f8
	fmul    $f14, $f2, $f2
	fmul    $f2, $f2, $f9
	fmul    $f13, $f9, $f9
	fadd    $f8, $f9, $f8
	store   $f8, [$i10 + 2]
	fmul    $f5, $f12, $f8
	fmul    $f8, $f15, $f8
	fmul    $f11, $f4, $f9
	fmul    $f9, $f1, $f9
	fadd    $f8, $f9, $f8
	fmul    $f13, $f16, $f9
	fmul    $f9, $f2, $f9
	fadd    $f8, $f9, $f8
	fmul    $fc10, $f8, $f8
	store   $f8, [$i14 + 0]
	fmul    $f5, $f3, $f3
	fmul    $f3, $f15, $f5
	fmul    $f11, $f6, $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	fmul    $f13, $f7, $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 1]
	fmul    $f3, $f12, $f1
	fmul    $f6, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f5, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 2]
	li      1, $i1
	ret
be_else.34744:
	bne     $i1, 0, be_else.34749
be_then.34749:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	li      1, $i1
	ret
be_else.34749:
	load    [$i14 + 0], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 7]
	load    [$i14 + 0], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	load    [$i14 + 1], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 8]
	load    [$i14 + 1], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f10
	load    [$i14 + 2], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
	load    [$i14 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 1], $f2
	fmul    $f2, $f8, $f3
	fmul    $f3, $f3, $f4
	load    [$i10 + 0], $f5
	fmul    $f5, $f4, $f4
	fmul    $f2, $f1, $f6
	fmul    $f6, $f6, $f7
	load    [$i10 + 1], $f11
	fmul    $f11, $f7, $f7
	fadd    $f4, $f7, $f4
	fneg    $f10, $f7
	fmul    $f7, $f7, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f4, $f12, $f4
	store   $f4, [$i10 + 0]
	fmul    $f9, $f10, $f4
	fmul    $f4, $f8, $f12
.count stack_load
	load    [$sp - 2], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f5, $f15, $f15
	fmul    $f4, $f1, $f4
	fmul    $f14, $f8, $f16
	fadd    $f4, $f16, $f4
	fmul    $f4, $f4, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f2, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i10 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f8, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f8, $f8
	fsub    $f1, $f8, $f1
	fmul    $f1, $f1, $f8
	fmul    $f11, $f8, $f8
	fadd    $f17, $f8, $f8
	fmul    $f14, $f2, $f2
	fmul    $f2, $f2, $f9
	fmul    $f13, $f9, $f9
	fadd    $f8, $f9, $f8
	store   $f8, [$i10 + 2]
	fmul    $f5, $f12, $f8
	fmul    $f8, $f15, $f8
	fmul    $f11, $f4, $f9
	fmul    $f9, $f1, $f9
	fadd    $f8, $f9, $f8
	fmul    $f13, $f16, $f9
	fmul    $f9, $f2, $f9
	fadd    $f8, $f9, $f8
	fmul    $fc10, $f8, $f8
	store   $f8, [$i14 + 0]
	fmul    $f5, $f3, $f3
	fmul    $f3, $f15, $f5
	fmul    $f11, $f6, $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	fmul    $f13, $f7, $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 1]
	fmul    $f3, $f12, $f1
	fmul    $f6, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f5, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i14 + 2]
	li      1, $i1
	ret
.end read_nth_object

######################################################################
# read_object($i6)
# $ra = $ra
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
######################################################################
.begin read_object
read_object.2721:
	bl      $i6, 60, bge_else.34750
bge_then.34750:
	ret
bge_else.34750:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34751
be_then.34751:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	mov     $i1, $ig0
	ret
be_else.34751:
.count stack_load
	load    [$sp + 1], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34752
bge_then.34752:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34752:
.count stack_store
	store   $i6, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34753
be_then.34753:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i1
	mov     $i1, $ig0
	ret
be_else.34753:
.count stack_load
	load    [$sp + 2], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34754
bge_then.34754:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34754:
.count stack_store
	store   $i6, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34755
be_then.34755:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 6], $i1
	mov     $i1, $ig0
	ret
be_else.34755:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34756
bge_then.34756:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34756:
.count stack_store
	store   $i6, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34757
be_then.34757:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i1
	mov     $i1, $ig0
	ret
be_else.34757:
.count stack_load
	load    [$sp + 4], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34758
bge_then.34758:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34758:
.count stack_store
	store   $i6, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34759
be_then.34759:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $i1
	mov     $i1, $ig0
	ret
be_else.34759:
.count stack_load
	load    [$sp + 5], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34760
bge_then.34760:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34760:
.count stack_store
	store   $i6, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34761
be_then.34761:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
	mov     $i1, $ig0
	ret
be_else.34761:
.count stack_load
	load    [$sp + 6], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34762
bge_then.34762:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34762:
.count stack_store
	store   $i6, [$sp + 7]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.34763
be_then.34763:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i1
	mov     $i1, $ig0
	ret
be_else.34763:
.count stack_load
	load    [$sp + 7], $i16
	add     $i16, 1, $i6
	bl      $i6, 60, bge_else.34764
bge_then.34764:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.34764:
.count stack_store
	store   $i6, [$sp + 8]
	call    read_nth_object.2719
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	bne     $i1, 0, be_else.34765
be_then.34765:
.count stack_load
	load    [$sp - 1], $i1
	mov     $i1, $ig0
	ret
be_else.34765:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i6
	b       read_object.2721
.end read_object

######################################################################
# $i1 = read_net_item($i6)
# $ra = $ra
# [$i1 - $i7]
# []
# []
# []
######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34766
be_then.34766:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	add     $i6, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
be_else.34766:
.count stack_store
	store   $i4, [$sp + 1]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	add     $i6, 1, $i5
	bne     $i4, -1, be_else.34767
be_then.34767:
	add     $i5, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i6, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.34767:
.count stack_store
	store   $i4, [$sp + 2]
.count stack_store
	store   $i5, [$sp + 3]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 3], $i5
	add     $i5, 1, $i7
	bne     $i4, -1, be_else.34768
be_then.34768:
	add     $i7, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i2
.count storer
	add     $i1, $i5, $tmp
	store   $i2, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i6, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.34768:
.count stack_store
	store   $i4, [$sp + 4]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	add     $i7, 1, $i5
	bne     $i4, -1, be_else.34769
be_then.34769:
	add     $i5, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i2
.count storer
	add     $i1, $i7, $tmp
	store   $i2, [$tmp + 0]
.count stack_load
	load    [$sp - 6], $i2
.count stack_load
	load    [$sp - 7], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i6, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.34769:
.count stack_store
	store   $i6, [$sp + 5]
.count stack_store
	store   $i7, [$sp + 6]
.count stack_store
	store   $i5, [$sp + 7]
.count stack_store
	store   $i4, [$sp + 8]
	add     $i5, 1, $i6
	call    read_net_item.2725
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i2
.count stack_load
	load    [$sp - 1], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 3], $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 6], $i2
.count stack_load
	load    [$sp - 7], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 4], $i2
.count stack_load
	load    [$sp - 8], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret
.end read_net_item

######################################################################
# $i1 = read_or_network($i6)
# $ra = $ra
# [$i1 - $i7]
# []
# []
# []
######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34770
be_then.34770:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count b_cont
	b       be_cont.34770
be_else.34770:
.count stack_store
	store   $i4, [$sp + 2]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34771
be_then.34771:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 2], $i5
	store   $i5, [$i4 + 0]
.count b_cont
	b       be_cont.34771
be_else.34771:
.count stack_store
	store   $i4, [$sp + 3]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34772
be_then.34772:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 3], $i5
	store   $i5, [$i4 + 1]
.count stack_load
	load    [$sp + 2], $i5
	store   $i5, [$i4 + 0]
.count b_cont
	b       be_cont.34772
be_else.34772:
.count stack_store
	store   $i4, [$sp + 4]
	li      3, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 4], $i5
	store   $i5, [$i4 + 2]
.count stack_load
	load    [$sp + 3], $i5
	store   $i5, [$i4 + 1]
.count stack_load
	load    [$sp + 2], $i5
	store   $i5, [$i4 + 0]
be_cont.34772:
be_cont.34771:
be_cont.34770:
	mov     $i4, $i3
	load    [$i3 + 0], $i4
	bne     $i4, -1, be_else.34773
be_then.34773:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $i4
	add     $i4, 1, $i2
	b       ext_create_array_int
be_else.34773:
.count stack_store
	store   $i3, [$sp + 5]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34774
be_then.34774:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count b_cont
	b       be_cont.34774
be_else.34774:
.count stack_store
	store   $i4, [$sp + 6]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34775
be_then.34775:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 6], $i5
	store   $i5, [$i4 + 0]
.count b_cont
	b       be_cont.34775
be_else.34775:
.count stack_store
	store   $i4, [$sp + 7]
	li      2, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 7], $i5
	store   $i5, [$i4 + 1]
.count stack_load
	load    [$sp + 6], $i5
	store   $i5, [$i4 + 0]
be_cont.34775:
be_cont.34774:
	mov     $i4, $i3
	load    [$i3 + 0], $i4
.count stack_load
	load    [$sp + 1], $i5
	add     $i5, 1, $i6
	bne     $i4, -1, be_else.34776
be_then.34776:
	add     $i6, 1, $i2
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 5], $i2
.count storer
	add     $i1, $i5, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.34776:
.count stack_store
	store   $i6, [$sp + 8]
.count stack_store
	store   $i3, [$sp + 9]
	add     $i6, 1, $i6
	call    read_or_network.2727
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $i2
.count stack_load
	load    [$sp - 1], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 9], $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret
.end read_or_network

######################################################################
# read_and_network($i6)
# $ra = $ra
# [$i1 - $i7]
# []
# []
# []
######################################################################
.begin read_and_network
read_and_network.2729:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34777
be_then.34777:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count b_cont
	b       be_cont.34777
be_else.34777:
.count stack_store
	store   $i4, [$sp + 2]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34778
be_then.34778:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 2], $i7
	store   $i7, [$i6 + 0]
.count b_cont
	b       be_cont.34778
be_else.34778:
.count stack_store
	store   $i4, [$sp + 3]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34779
be_then.34779:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 3], $i7
	store   $i7, [$i6 + 1]
.count stack_load
	load    [$sp + 2], $i7
	store   $i7, [$i6 + 0]
.count b_cont
	b       be_cont.34779
be_else.34779:
.count stack_store
	store   $i4, [$sp + 4]
	li      3, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 4], $i7
	store   $i7, [$i6 + 2]
.count stack_load
	load    [$sp + 3], $i7
	store   $i7, [$i6 + 1]
.count stack_load
	load    [$sp + 2], $i7
	store   $i7, [$i6 + 0]
be_cont.34779:
be_cont.34778:
be_cont.34777:
	load    [$i6 + 0], $i7
	bne     $i7, -1, be_else.34780
be_then.34780:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.34780:
.count stack_load
	load    [$sp + 1], $i7
	store   $i6, [ext_and_net + $i7]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34781
be_then.34781:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count b_cont
	b       be_cont.34781
be_else.34781:
.count stack_store
	store   $i4, [$sp + 5]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34782
be_then.34782:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 5], $i7
	store   $i7, [$i6 + 0]
.count b_cont
	b       be_cont.34782
be_else.34782:
.count stack_store
	store   $i4, [$sp + 6]
	li      2, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 6], $i7
	store   $i7, [$i6 + 1]
.count stack_load
	load    [$sp + 5], $i7
	store   $i7, [$i6 + 0]
be_cont.34782:
be_cont.34781:
	load    [$i6 + 0], $i7
	bne     $i7, -1, be_else.34783
be_then.34783:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.34783:
.count stack_load
	load    [$sp + 1], $i7
	add     $i7, 1, $i7
.count stack_store
	store   $i7, [$sp + 7]
	store   $i6, [ext_and_net + $i7]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34784
be_then.34784:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count b_cont
	b       be_cont.34784
be_else.34784:
.count stack_store
	store   $i4, [$sp + 8]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34785
be_then.34785:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 8], $i7
	store   $i7, [$i6 + 0]
.count b_cont
	b       be_cont.34785
be_else.34785:
.count stack_store
	store   $i4, [$sp + 9]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34786
be_then.34786:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 9], $i7
	store   $i7, [$i6 + 1]
.count stack_load
	load    [$sp + 8], $i7
	store   $i7, [$i6 + 0]
.count b_cont
	b       be_cont.34786
be_else.34786:
.count stack_store
	store   $i4, [$sp + 10]
	li      3, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i6
.count stack_load
	load    [$sp + 10], $i7
	store   $i7, [$i6 + 2]
.count stack_load
	load    [$sp + 9], $i7
	store   $i7, [$i6 + 1]
.count stack_load
	load    [$sp + 8], $i7
	store   $i7, [$i6 + 0]
be_cont.34786:
be_cont.34785:
be_cont.34784:
	load    [$i6 + 0], $i7
	bne     $i7, -1, be_else.34787
be_then.34787:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.34787:
.count stack_load
	load    [$sp + 7], $i7
	add     $i7, 1, $i7
.count stack_store
	store   $i7, [$sp + 11]
	store   $i6, [ext_and_net + $i7]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34788
be_then.34788:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.34788
be_else.34788:
.count stack_store
	store   $i4, [$sp + 12]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.34789
be_then.34789:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 12], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.34789
be_else.34789:
.count stack_store
	store   $i4, [$sp + 13]
	li      2, $i6
	call    read_net_item.2725
.count stack_load
	load    [$sp + 13], $i2
	store   $i2, [$i1 + 1]
.count stack_load
	load    [$sp + 12], $i2
	store   $i2, [$i1 + 0]
be_cont.34789:
be_cont.34788:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.34790
be_then.34790:
	ret
be_else.34790:
.count stack_load
	load    [$sp - 3], $i2
	add     $i2, 1, $i2
	store   $i1, [ext_and_net + $i2]
	add     $i2, 1, $i6
	b       read_and_network.2729
.end read_and_network

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
	fsub    $fg21, $f1, $f1
	fsub    $fg22, $f2, $f2
	fsub    $fg23, $f3, $f3
	load    [$i2 + 0], $f4
	bne     $i6, 1, be_else.34791
be_then.34791:
	bne     $f4, $f0, be_else.34792
be_then.34792:
	li      0, $i3
.count b_cont
	b       be_cont.34792
be_else.34792:
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.34793
ble_then.34793:
	li      0, $i5
.count b_cont
	b       ble_cont.34793
ble_else.34793:
	li      1, $i5
ble_cont.34793:
	bne     $i4, 0, be_else.34794
be_then.34794:
	mov     $i5, $i4
.count b_cont
	b       be_cont.34794
be_else.34794:
	bne     $i5, 0, be_else.34795
be_then.34795:
	li      1, $i4
.count b_cont
	b       be_cont.34795
be_else.34795:
	li      0, $i4
be_cont.34795:
be_cont.34794:
	load    [$i3 + 0], $f7
	bne     $i4, 0, be_cont.34796
be_then.34796:
	fneg    $f7, $f7
be_cont.34796:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.34797
ble_then.34797:
	li      0, $i3
.count b_cont
	b       ble_cont.34797
ble_else.34797:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.34798
ble_then.34798:
	li      0, $i3
.count b_cont
	b       ble_cont.34798
ble_else.34798:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.34798:
ble_cont.34797:
be_cont.34792:
	bne     $i3, 0, be_else.34799
be_then.34799:
	load    [$i2 + 1], $f4
	bne     $f4, $f0, be_else.34800
be_then.34800:
	li      0, $i3
.count b_cont
	b       be_cont.34800
be_else.34800:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.34801
ble_then.34801:
	li      0, $i5
.count b_cont
	b       ble_cont.34801
ble_else.34801:
	li      1, $i5
ble_cont.34801:
	bne     $i4, 0, be_else.34802
be_then.34802:
	mov     $i5, $i4
.count b_cont
	b       be_cont.34802
be_else.34802:
	bne     $i5, 0, be_else.34803
be_then.34803:
	li      1, $i4
.count b_cont
	b       be_cont.34803
be_else.34803:
	li      0, $i4
be_cont.34803:
be_cont.34802:
	load    [$i3 + 1], $f7
	bne     $i4, 0, be_cont.34804
be_then.34804:
	fneg    $f7, $f7
be_cont.34804:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.34805
ble_then.34805:
	li      0, $i3
.count b_cont
	b       ble_cont.34805
ble_else.34805:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.34806
ble_then.34806:
	li      0, $i3
.count b_cont
	b       ble_cont.34806
ble_else.34806:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.34806:
ble_cont.34805:
be_cont.34800:
	bne     $i3, 0, be_else.34807
be_then.34807:
	load    [$i2 + 2], $f4
	bne     $f4, $f0, be_else.34808
be_then.34808:
	li      0, $i1
	ret
be_else.34808:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, ble_else.34809
ble_then.34809:
	li      0, $i4
.count b_cont
	b       ble_cont.34809
ble_else.34809:
	li      1, $i4
ble_cont.34809:
	bne     $i1, 0, be_else.34810
be_then.34810:
	mov     $i4, $i1
.count b_cont
	b       be_cont.34810
be_else.34810:
	bne     $i4, 0, be_else.34811
be_then.34811:
	li      1, $i1
.count b_cont
	b       be_cont.34811
be_else.34811:
	li      0, $i1
be_cont.34811:
be_cont.34810:
	load    [$i3 + 2], $f7
	bne     $i1, 0, be_cont.34812
be_then.34812:
	fneg    $f7, $f7
be_cont.34812:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.34813
ble_then.34813:
	li      0, $i1
	ret
ble_else.34813:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.34814
ble_then.34814:
	li      0, $i1
	ret
ble_else.34814:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.34807:
	li      2, $i1
	ret
be_else.34799:
	li      1, $i1
	ret
be_else.34791:
	bne     $i6, 2, be_else.34815
be_then.34815:
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
	bg      $f4, $f0, ble_else.34816
ble_then.34816:
	li      0, $i1
	ret
ble_else.34816:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.34815:
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
	be      $i7, 0, bne_cont.34817
bne_then.34817:
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
bne_cont.34817:
	bne     $f7, $f0, be_else.34818
be_then.34818:
	li      0, $i1
	ret
be_else.34818:
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
	bne     $i2, 0, be_else.34819
be_then.34819:
	mov     $f9, $f4
.count b_cont
	b       be_cont.34819
be_else.34819:
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
	fmul    $f4, $fc3, $f4
	fadd    $f9, $f4, $f4
be_cont.34819:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.34820
be_then.34820:
	mov     $f6, $f1
.count b_cont
	b       be_cont.34820
be_else.34820:
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
be_cont.34820:
	bne     $i6, 3, be_cont.34821
be_then.34821:
	fsub    $f1, $fc0, $f1
be_cont.34821:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.34822
ble_then.34822:
	li      0, $i1
	ret
ble_else.34822:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.34823
be_then.34823:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.34823:
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
	bne     $i7, 1, be_else.34824
be_then.34824:
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
	bg      $f4, $f5, ble_else.34825
ble_then.34825:
	li      0, $i4
.count b_cont
	b       ble_cont.34825
ble_else.34825:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.34826
ble_then.34826:
	li      0, $i4
.count b_cont
	b       ble_cont.34826
ble_else.34826:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.34827
be_then.34827:
	li      0, $i4
.count b_cont
	b       be_cont.34827
be_else.34827:
	li      1, $i4
be_cont.34827:
ble_cont.34826:
ble_cont.34825:
	bne     $i4, 0, be_else.34828
be_then.34828:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.34829
ble_then.34829:
	li      0, $i2
.count b_cont
	b       ble_cont.34829
ble_else.34829:
	load    [$i2 + 4], $i2
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.34830
ble_then.34830:
	li      0, $i2
.count b_cont
	b       ble_cont.34830
ble_else.34830:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.34831
be_then.34831:
	li      0, $i2
.count b_cont
	b       be_cont.34831
be_else.34831:
	li      1, $i2
be_cont.34831:
ble_cont.34830:
ble_cont.34829:
	bne     $i2, 0, be_else.34832
be_then.34832:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.34833
ble_then.34833:
	li      0, $i1
	ret
ble_else.34833:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.34834
ble_then.34834:
	li      0, $i1
	ret
ble_else.34834:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.34835
be_then.34835:
	li      0, $i1
	ret
be_else.34835:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.34832:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.34828:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.34824:
	load    [$i1 + 0], $f4
	bne     $i7, 2, be_else.34836
be_then.34836:
	bg      $f0, $f4, ble_else.34837
ble_then.34837:
	li      0, $i1
	ret
ble_else.34837:
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
be_else.34836:
	bne     $f4, $f0, be_else.34838
be_then.34838:
	li      0, $i1
	ret
be_else.34838:
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
	bne     $i6, 0, be_else.34839
be_then.34839:
	mov     $f7, $f1
.count b_cont
	b       be_cont.34839
be_else.34839:
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
be_cont.34839:
	bne     $i7, 3, be_cont.34840
be_then.34840:
	fsub    $f1, $fc0, $f1
be_cont.34840:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.34841
ble_then.34841:
	li      0, $i1
	ret
ble_else.34841:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.34842
be_then.34842:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret
be_else.34842:
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
	bne     $i6, 1, be_else.34843
be_then.34843:
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
	bg      $f4, $f5, ble_else.34844
ble_then.34844:
	li      0, $i4
.count b_cont
	b       ble_cont.34844
ble_else.34844:
	load    [$i3 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.34845
ble_then.34845:
	li      0, $i4
.count b_cont
	b       ble_cont.34845
ble_else.34845:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.34846
be_then.34846:
	li      0, $i4
.count b_cont
	b       be_cont.34846
be_else.34846:
	li      1, $i4
be_cont.34846:
ble_cont.34845:
ble_cont.34844:
	bne     $i4, 0, be_else.34847
be_then.34847:
	load    [$i3 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.34848
ble_then.34848:
	li      0, $i3
.count b_cont
	b       ble_cont.34848
ble_else.34848:
	load    [$i3 + 4], $i3
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.34849
ble_then.34849:
	li      0, $i3
.count b_cont
	b       ble_cont.34849
ble_else.34849:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.34850
be_then.34850:
	li      0, $i3
.count b_cont
	b       be_cont.34850
be_else.34850:
	li      1, $i3
be_cont.34850:
ble_cont.34849:
ble_cont.34848:
	bne     $i3, 0, be_else.34851
be_then.34851:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.34852
ble_then.34852:
	li      0, $i1
	ret
ble_else.34852:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.34853
ble_then.34853:
	li      0, $i1
	ret
ble_else.34853:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.34854
be_then.34854:
	li      0, $i1
	ret
be_else.34854:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.34851:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.34847:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.34843:
	bne     $i6, 2, be_else.34855
be_then.34855:
	load    [$i1 + 0], $f1
	bg      $f0, $f1, ble_else.34856
ble_then.34856:
	li      0, $i1
	ret
ble_else.34856:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.34855:
	load    [$i1 + 0], $f4
	bne     $f4, $f0, be_else.34857
be_then.34857:
	li      0, $i1
	ret
be_else.34857:
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
	bg      $f2, $f0, ble_else.34858
ble_then.34858:
	li      0, $i1
	ret
ble_else.34858:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, be_else.34859
be_then.34859:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.34859:
	fadd    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants($i4, $i5)
# $ra = $ra
# [$i1 - $i11]
# [$f1 - $f8]
# []
# []
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i5, 0, bge_else.34860
bge_then.34860:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i4 + 1], $i6
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i8
	load    [$i4 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.34861
be_then.34861:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	load    [$i9 + 0], $f1
	bne     $f1, $f0, be_else.34862
be_then.34862:
	store   $f0, [$i8 + 1]
.count b_cont
	b       be_cont.34862
be_else.34862:
	load    [$i7 + 6], $i10
	bg      $f0, $f1, ble_else.34863
ble_then.34863:
	li      0, $i11
.count b_cont
	b       ble_cont.34863
ble_else.34863:
	li      1, $i11
ble_cont.34863:
	bne     $i10, 0, be_else.34864
be_then.34864:
	mov     $i11, $i10
.count b_cont
	b       be_cont.34864
be_else.34864:
	bne     $i11, 0, be_else.34865
be_then.34865:
	li      1, $i10
.count b_cont
	b       be_cont.34865
be_else.34865:
	li      0, $i10
be_cont.34865:
be_cont.34864:
	load    [$i7 + 4], $i11
	load    [$i11 + 0], $f1
	bne     $i10, 0, be_else.34866
be_then.34866:
	fneg    $f1, $f1
	store   $f1, [$i8 + 0]
	load    [$i9 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 1]
.count b_cont
	b       be_cont.34866
be_else.34866:
	store   $f1, [$i8 + 0]
	load    [$i9 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 1]
be_cont.34866:
be_cont.34862:
	load    [$i9 + 1], $f1
	bne     $f1, $f0, be_else.34867
be_then.34867:
	store   $f0, [$i8 + 3]
.count b_cont
	b       be_cont.34867
be_else.34867:
	load    [$i7 + 6], $i10
	bg      $f0, $f1, ble_else.34868
ble_then.34868:
	li      0, $i11
.count b_cont
	b       ble_cont.34868
ble_else.34868:
	li      1, $i11
ble_cont.34868:
	bne     $i10, 0, be_else.34869
be_then.34869:
	mov     $i11, $i10
.count b_cont
	b       be_cont.34869
be_else.34869:
	bne     $i11, 0, be_else.34870
be_then.34870:
	li      1, $i10
.count b_cont
	b       be_cont.34870
be_else.34870:
	li      0, $i10
be_cont.34870:
be_cont.34869:
	load    [$i7 + 4], $i11
	load    [$i11 + 1], $f1
	bne     $i10, 0, be_else.34871
be_then.34871:
	fneg    $f1, $f1
	store   $f1, [$i8 + 2]
	load    [$i9 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 3]
.count b_cont
	b       be_cont.34871
be_else.34871:
	store   $f1, [$i8 + 2]
	load    [$i9 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 3]
be_cont.34871:
be_cont.34867:
	load    [$i9 + 2], $f1
	bne     $f1, $f0, be_else.34872
be_then.34872:
	store   $f0, [$i8 + 5]
	mov     $i8, $i7
.count b_cont
	b       be_cont.34872
be_else.34872:
	load    [$i7 + 6], $i10
	bg      $f0, $f1, ble_else.34873
ble_then.34873:
	li      0, $i11
.count b_cont
	b       ble_cont.34873
ble_else.34873:
	li      1, $i11
ble_cont.34873:
	bne     $i10, 0, be_else.34874
be_then.34874:
	mov     $i11, $i10
.count b_cont
	b       be_cont.34874
be_else.34874:
	bne     $i11, 0, be_else.34875
be_then.34875:
	li      1, $i10
.count b_cont
	b       be_cont.34875
be_else.34875:
	li      0, $i10
be_cont.34875:
be_cont.34874:
	load    [$i7 + 4], $i7
	load    [$i7 + 2], $f1
	mov     $i8, $i7
	bne     $i10, 0, be_else.34876
be_then.34876:
	fneg    $f1, $f1
	store   $f1, [$i8 + 4]
	load    [$i9 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 5]
.count b_cont
	b       be_cont.34876
be_else.34876:
	store   $f1, [$i8 + 4]
	load    [$i9 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i8 + 5]
be_cont.34876:
be_cont.34872:
.count storer
	add     $i6, $i5, $tmp
	store   $i7, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.34877
bge_then.34877:
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i8
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.34878
be_then.34878:
	li      6, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i9 + 0], $f1
	bne     $f1, $f0, be_else.34879
be_then.34879:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.34879
be_else.34879:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.34880
ble_then.34880:
	li      0, $i3
.count b_cont
	b       ble_cont.34880
ble_else.34880:
	li      1, $i3
ble_cont.34880:
	bne     $i2, 0, be_else.34881
be_then.34881:
	mov     $i3, $i2
.count b_cont
	b       be_cont.34881
be_else.34881:
	bne     $i3, 0, be_else.34882
be_then.34882:
	li      1, $i2
.count b_cont
	b       be_cont.34882
be_else.34882:
	li      0, $i2
be_cont.34882:
be_cont.34881:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.34883
be_then.34883:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i9 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.34883
be_else.34883:
	store   $f1, [$i1 + 0]
	load    [$i9 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.34883:
be_cont.34879:
	load    [$i9 + 1], $f1
	bne     $f1, $f0, be_else.34884
be_then.34884:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.34884
be_else.34884:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.34885
ble_then.34885:
	li      0, $i3
.count b_cont
	b       ble_cont.34885
ble_else.34885:
	li      1, $i3
ble_cont.34885:
	bne     $i2, 0, be_else.34886
be_then.34886:
	mov     $i3, $i2
.count b_cont
	b       be_cont.34886
be_else.34886:
	bne     $i3, 0, be_else.34887
be_then.34887:
	li      1, $i2
.count b_cont
	b       be_cont.34887
be_else.34887:
	li      0, $i2
be_cont.34887:
be_cont.34886:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.34888
be_then.34888:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i9 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.34888
be_else.34888:
	store   $f1, [$i1 + 2]
	load    [$i9 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.34888:
be_cont.34884:
	load    [$i9 + 2], $f1
	bne     $f1, $f0, be_else.34889
be_then.34889:
	store   $f0, [$i1 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i1, [$tmp + 0]
	sub     $i5, 1, $i5
	b       iter_setup_dirvec_constants.2826
be_else.34889:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.34890
ble_then.34890:
	li      0, $i7
.count b_cont
	b       ble_cont.34890
ble_else.34890:
	li      1, $i7
ble_cont.34890:
	bne     $i2, 0, be_else.34891
be_then.34891:
	mov     $i7, $i2
.count b_cont
	b       be_cont.34891
be_else.34891:
	bne     $i7, 0, be_else.34892
be_then.34892:
	li      1, $i2
.count b_cont
	b       be_cont.34892
be_else.34892:
	li      0, $i2
be_cont.34892:
be_cont.34891:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.34893
be_then.34893:
	fneg    $f1, $f1
be_cont.34893:
	store   $f1, [$i1 + 4]
	load    [$i9 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i1, [$tmp + 0]
	sub     $i5, 1, $i5
	b       iter_setup_dirvec_constants.2826
be_else.34878:
	bne     $i8, 2, be_else.34894
be_then.34894:
	li      4, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i9 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i9 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i9 + 2], $f2
	load    [$i8 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f1, $f0, ble_else.34895
ble_then.34895:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
ble_else.34895:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i7 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i7 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i7 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34894:
	li      5, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i7 + 4], $i10
	load    [$i9 + 0], $f1
	load    [$i9 + 1], $f2
	load    [$i9 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i8 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.34896
be_then.34896:
	mov     $f4, $f1
.count b_cont
	b       be_cont.34896
be_else.34896:
	fmul    $f2, $f3, $f5
	load    [$i7 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i7 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i7 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.34896:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i7 + 4], $i10
	load    [$i9 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i9 + 1], $f3
	load    [$i8 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i9 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i2, 0, be_else.34897
be_then.34897:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.34898
be_then.34898:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34898:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34897:
	load    [$i7 + 9], $i2
	load    [$i7 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i7 + 9], $i2
	load    [$i9 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i9 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i9 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i9 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.34899
be_then.34899:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34899:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bge_else.34877:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.34861:
	bne     $i8, 2, be_else.34900
be_then.34900:
	li      4, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i9 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i9 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i9 + 2], $f2
	load    [$i8 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f1, $f0, ble_else.34901
ble_then.34901:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
ble_else.34901:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i7 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i7 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i7 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34900:
	li      5, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i7 + 4], $i10
	load    [$i9 + 0], $f1
	load    [$i9 + 1], $f2
	load    [$i9 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i8 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.34902
be_then.34902:
	mov     $f4, $f1
.count b_cont
	b       be_cont.34902
be_else.34902:
	fmul    $f2, $f3, $f5
	load    [$i7 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i7 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i7 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.34902:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i8
	load    [$i7 + 4], $i10
	load    [$i9 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i9 + 1], $f3
	load    [$i8 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i9 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i2, 0, be_else.34903
be_then.34903:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.34904
be_then.34904:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34904:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34903:
	load    [$i7 + 9], $i2
	load    [$i7 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i7 + 9], $i2
	load    [$i9 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i9 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i9 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i9 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.34905
be_then.34905:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.34905:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bge_else.34860:
	ret
.end iter_setup_dirvec_constants

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
	bl      $i1, 0, bge_else.34906
bge_then.34906:
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
	bne     $i4, 2, be_else.34907
be_then.34907:
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
be_else.34907:
	bg      $i4, 2, ble_else.34908
ble_then.34908:
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
ble_else.34908:
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
	bne     $i9, 0, be_else.34909
be_then.34909:
	mov     $f4, $f1
.count b_cont
	b       be_cont.34909
be_else.34909:
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
be_cont.34909:
	sub     $i1, 1, $i1
	bne     $i4, 3, be_else.34910
be_then.34910:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
be_else.34910:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
bge_else.34906:
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
	bne     $i2, -1, be_else.34911
be_then.34911:
	li      1, $i1
	ret
be_else.34911:
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
	bne     $i4, 1, be_else.34912
be_then.34912:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.34913
ble_then.34913:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34914
be_then.34914:
	li      1, $i2
.count b_cont
	b       be_cont.34912
be_else.34914:
	li      0, $i2
.count b_cont
	b       be_cont.34912
ble_else.34913:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.34915
ble_then.34915:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34916
be_then.34916:
	li      1, $i2
.count b_cont
	b       be_cont.34912
be_else.34916:
	li      0, $i2
.count b_cont
	b       be_cont.34912
ble_else.34915:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.34912
ble_then.34917:
	bne     $i2, 0, be_else.34918
be_then.34918:
	li      1, $i2
.count b_cont
	b       be_cont.34912
be_else.34918:
	li      0, $i2
.count b_cont
	b       be_cont.34912
be_else.34912:
	bne     $i4, 2, be_else.34919
be_then.34919:
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
	bg      $f0, $f1, ble_else.34920
ble_then.34920:
	bne     $i4, 0, be_else.34921
be_then.34921:
	li      1, $i2
.count b_cont
	b       be_cont.34919
be_else.34921:
	li      0, $i2
.count b_cont
	b       be_cont.34919
ble_else.34920:
	bne     $i4, 0, be_else.34922
be_then.34922:
	li      0, $i2
.count b_cont
	b       be_cont.34919
be_else.34922:
	li      1, $i2
.count b_cont
	b       be_cont.34919
be_else.34919:
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
	bne     $i6, 0, be_else.34923
be_then.34923:
	mov     $f7, $f1
.count b_cont
	b       be_cont.34923
be_else.34923:
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
be_cont.34923:
	bne     $i4, 3, be_cont.34924
be_then.34924:
	fsub    $f1, $fc0, $f1
be_cont.34924:
	bg      $f0, $f1, ble_else.34925
ble_then.34925:
	bne     $i5, 0, be_else.34926
be_then.34926:
	li      1, $i2
.count b_cont
	b       ble_cont.34925
be_else.34926:
	li      0, $i2
.count b_cont
	b       ble_cont.34925
ble_else.34925:
	bne     $i5, 0, be_else.34927
be_then.34927:
	li      0, $i2
.count b_cont
	b       be_cont.34927
be_else.34927:
	li      1, $i2
be_cont.34927:
ble_cont.34925:
be_cont.34919:
be_cont.34912:
	bne     $i2, 0, be_else.34928
be_then.34928:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.34929
be_then.34929:
	li      1, $i1
	ret
be_else.34929:
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
	bne     $i7, 1, be_else.34930
be_then.34930:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.34931
ble_then.34931:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34932
be_then.34932:
	li      1, $i2
.count b_cont
	b       be_cont.34930
be_else.34932:
	li      0, $i2
.count b_cont
	b       be_cont.34930
ble_else.34931:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.34933
ble_then.34933:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34934
be_then.34934:
	li      1, $i2
.count b_cont
	b       be_cont.34930
be_else.34934:
	li      0, $i2
.count b_cont
	b       be_cont.34930
ble_else.34933:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.34930
ble_then.34935:
	bne     $i2, 0, be_else.34936
be_then.34936:
	li      1, $i2
.count b_cont
	b       be_cont.34930
be_else.34936:
	li      0, $i2
.count b_cont
	b       be_cont.34930
be_else.34930:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.34937
be_then.34937:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.34938
ble_then.34938:
	bne     $i4, 0, be_else.34939
be_then.34939:
	li      1, $i2
.count b_cont
	b       be_cont.34937
be_else.34939:
	li      0, $i2
.count b_cont
	b       be_cont.34937
ble_else.34938:
	bne     $i4, 0, be_else.34940
be_then.34940:
	li      0, $i2
.count b_cont
	b       be_cont.34937
be_else.34940:
	li      1, $i2
.count b_cont
	b       be_cont.34937
be_else.34937:
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
	bne     $i9, 0, be_else.34941
be_then.34941:
	mov     $f7, $f1
.count b_cont
	b       be_cont.34941
be_else.34941:
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
be_cont.34941:
	bne     $i5, 3, be_cont.34942
be_then.34942:
	fsub    $f1, $fc0, $f1
be_cont.34942:
	bg      $f0, $f1, ble_else.34943
ble_then.34943:
	bne     $i4, 0, be_else.34944
be_then.34944:
	li      1, $i2
.count b_cont
	b       ble_cont.34943
be_else.34944:
	li      0, $i2
.count b_cont
	b       ble_cont.34943
ble_else.34943:
	bne     $i4, 0, be_else.34945
be_then.34945:
	li      0, $i2
.count b_cont
	b       be_cont.34945
be_else.34945:
	li      1, $i2
be_cont.34945:
ble_cont.34943:
be_cont.34937:
be_cont.34930:
	bne     $i2, 0, be_else.34946
be_then.34946:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.34947
be_then.34947:
	li      1, $i1
	ret
be_else.34947:
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
	bne     $i4, 1, be_else.34948
be_then.34948:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.34949
ble_then.34949:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34950
be_then.34950:
	li      1, $i2
.count b_cont
	b       be_cont.34948
be_else.34950:
	li      0, $i2
.count b_cont
	b       be_cont.34948
ble_else.34949:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.34951
ble_then.34951:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.34952
be_then.34952:
	li      1, $i2
.count b_cont
	b       be_cont.34948
be_else.34952:
	li      0, $i2
.count b_cont
	b       be_cont.34948
ble_else.34951:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.34948
ble_then.34953:
	bne     $i2, 0, be_else.34954
be_then.34954:
	li      1, $i2
.count b_cont
	b       be_cont.34948
be_else.34954:
	li      0, $i2
.count b_cont
	b       be_cont.34948
be_else.34948:
	bne     $i4, 2, be_else.34955
be_then.34955:
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
	bg      $f0, $f1, ble_else.34956
ble_then.34956:
	bne     $i4, 0, be_else.34957
be_then.34957:
	li      1, $i2
.count b_cont
	b       be_cont.34955
be_else.34957:
	li      0, $i2
.count b_cont
	b       be_cont.34955
ble_else.34956:
	bne     $i4, 0, be_else.34958
be_then.34958:
	li      0, $i2
.count b_cont
	b       be_cont.34955
be_else.34958:
	li      1, $i2
.count b_cont
	b       be_cont.34955
be_else.34955:
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
	bne     $i6, 0, be_else.34959
be_then.34959:
	mov     $f7, $f1
.count b_cont
	b       be_cont.34959
be_else.34959:
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
be_cont.34959:
	bne     $i5, 3, be_cont.34960
be_then.34960:
	fsub    $f1, $fc0, $f1
be_cont.34960:
	bg      $f0, $f1, ble_else.34961
ble_then.34961:
	bne     $i4, 0, be_else.34962
be_then.34962:
	li      1, $i2
.count b_cont
	b       ble_cont.34961
be_else.34962:
	li      0, $i2
.count b_cont
	b       ble_cont.34961
ble_else.34961:
	bne     $i4, 0, be_else.34963
be_then.34963:
	li      0, $i2
.count b_cont
	b       be_cont.34963
be_else.34963:
	li      1, $i2
be_cont.34963:
ble_cont.34961:
be_cont.34955:
be_cont.34948:
	bne     $i2, 0, be_else.34964
be_then.34964:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.34965
be_then.34965:
	li      1, $i1
	ret
be_else.34965:
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
	bne     $i7, 1, be_else.34966
be_then.34966:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.34967
ble_then.34967:
	li      0, $i4
.count b_cont
	b       ble_cont.34967
ble_else.34967:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.34968
ble_then.34968:
	li      0, $i4
.count b_cont
	b       ble_cont.34968
ble_else.34968:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.34969
ble_then.34969:
	li      0, $i4
.count b_cont
	b       ble_cont.34969
ble_else.34969:
	li      1, $i4
ble_cont.34969:
ble_cont.34968:
ble_cont.34967:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.34970
be_then.34970:
	bne     $i2, 0, be_else.34971
be_then.34971:
	li      0, $i1
	ret
be_else.34971:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.34970:
	bne     $i2, 0, be_else.34972
be_then.34972:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.34972:
	li      0, $i1
	ret
be_else.34966:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.34973
be_then.34973:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.34974
ble_then.34974:
	bne     $i4, 0, be_else.34975
be_then.34975:
	li      0, $i1
	ret
be_else.34975:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.34974:
	bne     $i4, 0, be_else.34976
be_then.34976:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.34976:
	li      0, $i1
	ret
be_else.34973:
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
	bne     $i9, 0, be_else.34977
be_then.34977:
	mov     $f7, $f1
.count b_cont
	b       be_cont.34977
be_else.34977:
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
be_cont.34977:
	bne     $i7, 3, be_cont.34978
be_then.34978:
	fsub    $f1, $fc0, $f1
be_cont.34978:
	bg      $f0, $f1, ble_else.34979
ble_then.34979:
	bne     $i4, 0, be_else.34980
be_then.34980:
	li      0, $i1
	ret
be_else.34980:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.34979:
	bne     $i4, 0, be_else.34981
be_then.34981:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.34981:
	li      0, $i1
	ret
be_else.34964:
	li      0, $i1
	ret
be_else.34946:
	li      0, $i1
	ret
be_else.34928:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i10, $i3)
# $ra = $ra
# [$i1 - $i17]
# [$f1 - $f18]
# []
# [$fg0]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i10], $i11
	bne     $i11, -1, be_else.34982
be_then.34982:
	li      0, $i1
	ret
be_else.34982:
	load    [ext_objects + $i11], $i12
	load    [$i12 + 5], $i13
	load    [$i12 + 5], $i14
	load    [$i12 + 5], $i15
	load    [ext_light_dirvec + 1], $i16
	load    [$i12 + 1], $i17
	load    [ext_intersection_point + 0], $f10
	load    [$i13 + 0], $f11
	fsub    $f10, $f11, $f10
	load    [ext_intersection_point + 1], $f11
	load    [$i14 + 1], $f12
	fsub    $f11, $f12, $f11
	load    [ext_intersection_point + 2], $f12
	load    [$i15 + 2], $f13
	fsub    $f12, $f13, $f12
	load    [$i16 + $i11], $i13
	bne     $i17, 1, be_else.34983
be_then.34983:
	load    [ext_light_dirvec + 0], $i14
	load    [$i12 + 4], $i15
	load    [$i15 + 1], $f13
	load    [$i14 + 1], $f14
	load    [$i13 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i13 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.34984
ble_then.34984:
	li      0, $i15
.count b_cont
	b       ble_cont.34984
ble_else.34984:
	load    [$i12 + 4], $i15
	load    [$i15 + 2], $f13
	load    [$i14 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.34985
ble_then.34985:
	li      0, $i15
.count b_cont
	b       ble_cont.34985
ble_else.34985:
	load    [$i13 + 1], $f13
	bne     $f13, $f0, be_else.34986
be_then.34986:
	li      0, $i15
.count b_cont
	b       be_cont.34986
be_else.34986:
	li      1, $i15
be_cont.34986:
ble_cont.34985:
ble_cont.34984:
	bne     $i15, 0, be_else.34987
be_then.34987:
	load    [$i12 + 4], $i15
	load    [$i15 + 0], $f13
	load    [$i14 + 0], $f14
	load    [$i13 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i13 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.34988
ble_then.34988:
	li      0, $i15
.count b_cont
	b       ble_cont.34988
ble_else.34988:
	load    [$i12 + 4], $i15
	load    [$i15 + 2], $f13
	load    [$i14 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.34989
ble_then.34989:
	li      0, $i15
.count b_cont
	b       ble_cont.34989
ble_else.34989:
	load    [$i13 + 3], $f13
	bne     $f13, $f0, be_else.34990
be_then.34990:
	li      0, $i15
.count b_cont
	b       be_cont.34990
be_else.34990:
	li      1, $i15
be_cont.34990:
ble_cont.34989:
ble_cont.34988:
	bne     $i15, 0, be_else.34991
be_then.34991:
	load    [$i12 + 4], $i15
	load    [$i15 + 0], $f13
	load    [$i14 + 0], $f14
	load    [$i13 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i13 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.34992
ble_then.34992:
	li      0, $i12
.count b_cont
	b       be_cont.34983
ble_else.34992:
	load    [$i12 + 4], $i12
	load    [$i12 + 1], $f10
	load    [$i14 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.34993
ble_then.34993:
	li      0, $i12
.count b_cont
	b       be_cont.34983
ble_else.34993:
	load    [$i13 + 5], $f10
	bne     $f10, $f0, be_else.34994
be_then.34994:
	li      0, $i12
.count b_cont
	b       be_cont.34983
be_else.34994:
	mov     $f12, $fg0
	li      3, $i12
.count b_cont
	b       be_cont.34983
be_else.34991:
	mov     $f15, $fg0
	li      2, $i12
.count b_cont
	b       be_cont.34983
be_else.34987:
	mov     $f15, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.34983
be_else.34983:
	load    [$i13 + 0], $f13
	bne     $i17, 2, be_else.34995
be_then.34995:
	bg      $f0, $f13, ble_else.34996
ble_then.34996:
	li      0, $i12
.count b_cont
	b       be_cont.34995
ble_else.34996:
	load    [$i13 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i13 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i13 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.34995
be_else.34995:
	bne     $f13, $f0, be_else.34997
be_then.34997:
	li      0, $i12
.count b_cont
	b       be_cont.34997
be_else.34997:
	load    [$i13 + 1], $f14
	fmul    $f14, $f10, $f14
	load    [$i13 + 2], $f15
	fmul    $f15, $f11, $f15
	fadd    $f14, $f15, $f14
	load    [$i13 + 3], $f15
	fmul    $f15, $f12, $f15
	fadd    $f14, $f15, $f14
	fmul    $f14, $f14, $f15
	fmul    $f10, $f10, $f16
	load    [$i12 + 4], $i14
	load    [$i14 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f11, $f11, $f17
	load    [$i12 + 4], $i14
	load    [$i14 + 1], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f12, $f17
	load    [$i12 + 4], $i14
	load    [$i14 + 2], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	load    [$i12 + 3], $i14
	bne     $i14, 0, be_else.34998
be_then.34998:
	mov     $f16, $f10
.count b_cont
	b       be_cont.34998
be_else.34998:
	fmul    $f11, $f12, $f17
	load    [$i12 + 9], $i14
	load    [$i14 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f10, $f12
	load    [$i12 + 9], $i14
	load    [$i14 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f16, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i12 + 9], $i14
	load    [$i14 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.34998:
	bne     $i17, 3, be_cont.34999
be_then.34999:
	fsub    $f10, $fc0, $f10
be_cont.34999:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.35000
ble_then.35000:
	li      0, $i12
.count b_cont
	b       ble_cont.35000
ble_else.35000:
	load    [$i12 + 6], $i12
	load    [$i13 + 4], $f11
	fsqrt   $f10, $f10
	bne     $i12, 0, be_else.35001
be_then.35001:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35001
be_else.35001:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i12
be_cont.35001:
ble_cont.35000:
be_cont.34997:
be_cont.34995:
be_cont.34983:
	bne     $i12, 0, be_else.35002
be_then.35002:
	li      0, $i12
.count b_cont
	b       be_cont.35002
be_else.35002:
.count load_float
	load    [f.31944], $f10
	bg      $f10, $fg0, ble_else.35003
ble_then.35003:
	li      0, $i12
.count b_cont
	b       ble_cont.35003
ble_else.35003:
	li      1, $i12
ble_cont.35003:
be_cont.35002:
	bne     $i12, 0, be_else.35004
be_then.35004:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35005
be_then.35005:
	li      0, $i1
	ret
be_else.35005:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.35004:
	load    [$i3 + 0], $i11
	bne     $i11, -1, be_else.35006
be_then.35006:
	li      1, $i1
	ret
be_else.35006:
	load    [ext_objects + $i11], $i11
	load    [$i11 + 5], $i12
	load    [$i11 + 5], $i13
	load    [$i11 + 5], $i14
	load    [$i11 + 1], $i15
	load    [$i12 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $fg12, $f11, $f12
	load    [ext_intersection_point + 0], $f13
	fadd    $f12, $f13, $f2
	fsub    $f2, $f10, $f10
	load    [$i13 + 1], $f12
	fmul    $fg13, $f11, $f13
	load    [ext_intersection_point + 1], $f14
	fadd    $f13, $f14, $f3
	fsub    $f3, $f12, $f12
	load    [$i14 + 2], $f13
	fmul    $fg14, $f11, $f11
	load    [ext_intersection_point + 2], $f14
	fadd    $f11, $f14, $f4
	fsub    $f4, $f13, $f11
	bne     $i15, 1, be_else.35007
be_then.35007:
	load    [$i11 + 4], $i12
	load    [$i12 + 0], $f13
	fabs    $f10, $f10
	bg      $f13, $f10, ble_else.35008
ble_then.35008:
	load    [$i11 + 6], $i11
	bne     $i11, 0, be_else.35009
be_then.35009:
	li      1, $i11
.count b_cont
	b       be_cont.35007
be_else.35009:
	li      0, $i11
.count b_cont
	b       be_cont.35007
ble_else.35008:
	load    [$i11 + 4], $i12
	load    [$i12 + 1], $f10
	fabs    $f12, $f12
	bg      $f10, $f12, ble_else.35010
ble_then.35010:
	load    [$i11 + 6], $i11
	bne     $i11, 0, be_else.35011
be_then.35011:
	li      1, $i11
.count b_cont
	b       be_cont.35007
be_else.35011:
	li      0, $i11
.count b_cont
	b       be_cont.35007
ble_else.35010:
	load    [$i11 + 4], $i12
	load    [$i12 + 2], $f10
	fabs    $f11, $f11
	load    [$i11 + 6], $i11
	bg      $f10, $f11, be_cont.35007
ble_then.35012:
	bne     $i11, 0, be_else.35013
be_then.35013:
	li      1, $i11
.count b_cont
	b       be_cont.35007
be_else.35013:
	li      0, $i11
.count b_cont
	b       be_cont.35007
be_else.35007:
	load    [$i11 + 6], $i12
	bne     $i15, 2, be_else.35014
be_then.35014:
	load    [$i11 + 4], $i11
	load    [$i11 + 0], $f13
	fmul    $f13, $f10, $f10
	load    [$i11 + 1], $f13
	fmul    $f13, $f12, $f12
	fadd    $f10, $f12, $f10
	load    [$i11 + 2], $f12
	fmul    $f12, $f11, $f11
	fadd    $f10, $f11, $f10
	bg      $f0, $f10, ble_else.35015
ble_then.35015:
	bne     $i12, 0, be_else.35016
be_then.35016:
	li      1, $i11
.count b_cont
	b       be_cont.35014
be_else.35016:
	li      0, $i11
.count b_cont
	b       be_cont.35014
ble_else.35015:
	bne     $i12, 0, be_else.35017
be_then.35017:
	li      0, $i11
.count b_cont
	b       be_cont.35014
be_else.35017:
	li      1, $i11
.count b_cont
	b       be_cont.35014
be_else.35014:
	fmul    $f10, $f10, $f13
	load    [$i11 + 4], $i13
	load    [$i13 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i11 + 4], $i13
	load    [$i13 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i11 + 4], $i13
	load    [$i13 + 2], $f15
	fmul    $f14, $f15, $f14
	load    [$i11 + 3], $i13
	fadd    $f13, $f14, $f13
	bne     $i13, 0, be_else.35018
be_then.35018:
	mov     $f13, $f10
.count b_cont
	b       be_cont.35018
be_else.35018:
	fmul    $f12, $f11, $f14
	load    [$i11 + 9], $i13
	load    [$i13 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f10, $f11
	load    [$i11 + 9], $i13
	load    [$i13 + 1], $f14
	fmul    $f11, $f14, $f11
	fadd    $f13, $f11, $f11
	fmul    $f10, $f12, $f10
	load    [$i11 + 9], $i11
	load    [$i11 + 2], $f12
	fmul    $f10, $f12, $f10
	fadd    $f11, $f10, $f10
be_cont.35018:
	bne     $i15, 3, be_cont.35019
be_then.35019:
	fsub    $f10, $fc0, $f10
be_cont.35019:
	bg      $f0, $f10, ble_else.35020
ble_then.35020:
	bne     $i12, 0, be_else.35021
be_then.35021:
	li      1, $i11
.count b_cont
	b       ble_cont.35020
be_else.35021:
	li      0, $i11
.count b_cont
	b       ble_cont.35020
ble_else.35020:
	bne     $i12, 0, be_else.35022
be_then.35022:
	li      0, $i11
.count b_cont
	b       be_cont.35022
be_else.35022:
	li      1, $i11
be_cont.35022:
ble_cont.35020:
be_cont.35014:
be_cont.35007:
	bne     $i11, 0, be_else.35023
be_then.35023:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
	li      1, $i1
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	bne     $i1, 0, be_else.35024
be_then.35024:
	add     $i10, 1, $i10
.count stack_load
	load    [$sp - 1], $i3
	b       shadow_check_and_group.2862
be_else.35024:
	li      1, $i1
	ret
be_else.35023:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i18, $i19)
# $ra = $ra
# [$i1 - $i20]
# [$f1 - $f18]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35025
be_then.35025:
	li      0, $i1
	ret
be_else.35025:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35026
be_then.35026:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35027
be_then.35027:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35027:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35028
be_then.35028:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35029
be_then.35029:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35029:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35030
be_then.35030:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35031
be_then.35031:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35031:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35032
be_then.35032:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35033
be_then.35033:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35033:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35034
be_then.35034:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35035
be_then.35035:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35035:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35036
be_then.35036:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35037
be_then.35037:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35037:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35038
be_then.35038:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i20
	bne     $i20, -1, be_else.35039
be_then.35039:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.35039:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
	call    shadow_check_and_group.2862
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.35040
be_then.35040:
	add     $i18, 1, $i18
	b       shadow_check_one_or_group.2865
be_else.35040:
	li      1, $i1
	ret
be_else.35038:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35036:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35034:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35032:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35030:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35028:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.35026:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i18, $i19)
# $ra = $ra
# [$i1 - $i22]
# [$f1 - $f18]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i19 + $i18], $i20
	load    [$i20 + 0], $i21
	bne     $i21, -1, be_else.35041
be_then.35041:
	li      0, $i1
	ret
be_else.35041:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i20, [$sp + 1]
.count stack_store
	store   $i19, [$sp + 2]
.count stack_store
	store   $i18, [$sp + 3]
	bne     $i21, 99, be_else.35042
be_then.35042:
	li      1, $i8
.count b_cont
	b       be_cont.35042
be_else.35042:
	load    [ext_objects + $i21], $i18
	load    [ext_intersection_point + 0], $f10
	load    [$i18 + 5], $i19
	load    [$i19 + 0], $f11
	fsub    $f10, $f11, $f10
	load    [ext_intersection_point + 1], $f11
	load    [$i18 + 5], $i19
	load    [$i19 + 1], $f12
	fsub    $f11, $f12, $f11
	load    [ext_intersection_point + 2], $f12
	load    [$i18 + 5], $i19
	load    [$i19 + 2], $f13
	fsub    $f12, $f13, $f12
	load    [ext_light_dirvec + 1], $i19
	load    [$i19 + $i21], $i19
	load    [$i18 + 1], $i21
	bne     $i21, 1, be_else.35043
be_then.35043:
	load    [ext_light_dirvec + 0], $i21
	load    [$i18 + 4], $i22
	load    [$i22 + 1], $f13
	load    [$i21 + 1], $f14
	load    [$i19 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i19 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35044
ble_then.35044:
	li      0, $i22
.count b_cont
	b       ble_cont.35044
ble_else.35044:
	load    [$i18 + 4], $i22
	load    [$i22 + 2], $f13
	load    [$i21 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35045
ble_then.35045:
	li      0, $i22
.count b_cont
	b       ble_cont.35045
ble_else.35045:
	load    [$i19 + 1], $f13
	bne     $f13, $f0, be_else.35046
be_then.35046:
	li      0, $i22
.count b_cont
	b       be_cont.35046
be_else.35046:
	li      1, $i22
be_cont.35046:
ble_cont.35045:
ble_cont.35044:
	bne     $i22, 0, be_else.35047
be_then.35047:
	load    [$i18 + 4], $i22
	load    [$i22 + 0], $f13
	load    [$i21 + 0], $f14
	load    [$i19 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i19 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.35048
ble_then.35048:
	li      0, $i22
.count b_cont
	b       ble_cont.35048
ble_else.35048:
	load    [$i18 + 4], $i22
	load    [$i22 + 2], $f13
	load    [$i21 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35049
ble_then.35049:
	li      0, $i22
.count b_cont
	b       ble_cont.35049
ble_else.35049:
	load    [$i19 + 3], $f13
	bne     $f13, $f0, be_else.35050
be_then.35050:
	li      0, $i22
.count b_cont
	b       be_cont.35050
be_else.35050:
	li      1, $i22
be_cont.35050:
ble_cont.35049:
ble_cont.35048:
	bne     $i22, 0, be_else.35051
be_then.35051:
	load    [$i18 + 4], $i22
	load    [$i22 + 0], $f13
	load    [$i21 + 0], $f14
	load    [$i19 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i19 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.35052
ble_then.35052:
	li      0, $i18
.count b_cont
	b       be_cont.35043
ble_else.35052:
	load    [$i18 + 4], $i18
	load    [$i18 + 1], $f10
	load    [$i21 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35053
ble_then.35053:
	li      0, $i18
.count b_cont
	b       be_cont.35043
ble_else.35053:
	load    [$i19 + 5], $f10
	bne     $f10, $f0, be_else.35054
be_then.35054:
	li      0, $i18
.count b_cont
	b       be_cont.35043
be_else.35054:
	mov     $f12, $fg0
	li      3, $i18
.count b_cont
	b       be_cont.35043
be_else.35051:
	mov     $f15, $fg0
	li      2, $i18
.count b_cont
	b       be_cont.35043
be_else.35047:
	mov     $f15, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35043
be_else.35043:
	load    [$i19 + 0], $f13
	bne     $i21, 2, be_else.35055
be_then.35055:
	bg      $f0, $f13, ble_else.35056
ble_then.35056:
	li      0, $i18
.count b_cont
	b       be_cont.35055
ble_else.35056:
	load    [$i19 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i19 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i19 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35055
be_else.35055:
	bne     $f13, $f0, be_else.35057
be_then.35057:
	li      0, $i18
.count b_cont
	b       be_cont.35057
be_else.35057:
	load    [$i19 + 1], $f14
	fmul    $f14, $f10, $f14
	load    [$i19 + 2], $f15
	fmul    $f15, $f11, $f15
	fadd    $f14, $f15, $f14
	load    [$i19 + 3], $f15
	fmul    $f15, $f12, $f15
	fadd    $f14, $f15, $f14
	fmul    $f14, $f14, $f15
	fmul    $f10, $f10, $f16
	load    [$i18 + 4], $i22
	load    [$i22 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f11, $f11, $f17
	load    [$i18 + 4], $i22
	load    [$i22 + 1], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f12, $f17
	load    [$i18 + 4], $i22
	load    [$i22 + 2], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	load    [$i18 + 3], $i22
	bne     $i22, 0, be_else.35058
be_then.35058:
	mov     $f16, $f10
.count b_cont
	b       be_cont.35058
be_else.35058:
	fmul    $f11, $f12, $f17
	load    [$i18 + 9], $i22
	load    [$i22 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f10, $f12
	load    [$i18 + 9], $i22
	load    [$i22 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f16, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i18 + 9], $i22
	load    [$i22 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.35058:
	bne     $i21, 3, be_cont.35059
be_then.35059:
	fsub    $f10, $fc0, $f10
be_cont.35059:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.35060
ble_then.35060:
	li      0, $i18
.count b_cont
	b       ble_cont.35060
ble_else.35060:
	load    [$i18 + 6], $i18
	load    [$i19 + 4], $f11
	fsqrt   $f10, $f10
	bne     $i18, 0, be_else.35061
be_then.35061:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35061
be_else.35061:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i18
be_cont.35061:
ble_cont.35060:
be_cont.35057:
be_cont.35055:
be_cont.35043:
	bne     $i18, 0, be_else.35062
be_then.35062:
	li      0, $i8
.count b_cont
	b       be_cont.35062
be_else.35062:
	bg      $fc7, $fg0, ble_else.35063
ble_then.35063:
	li      0, $i8
.count b_cont
	b       ble_cont.35063
ble_else.35063:
	load    [$i20 + 1], $i18
	bne     $i18, -1, be_else.35064
be_then.35064:
	li      0, $i8
.count b_cont
	b       be_cont.35064
be_else.35064:
	load    [ext_and_net + $i18], $i3
	li      0, $i10
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35065
be_then.35065:
	li      2, $i18
.count move_args
	mov     $i20, $i19
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i8
	bne     $i8, 0, be_else.35066
be_then.35066:
	li      0, $i8
.count b_cont
	b       be_cont.35065
be_else.35066:
	li      1, $i8
.count b_cont
	b       be_cont.35065
be_else.35065:
	li      1, $i8
be_cont.35065:
be_cont.35064:
ble_cont.35063:
be_cont.35062:
be_cont.35042:
	bne     $i8, 0, be_else.35067
be_then.35067:
.count stack_load
	load    [$sp + 3], $i8
	add     $i8, 1, $i8
.count stack_load
	load    [$sp + 2], $i9
	load    [$i9 + $i8], $i10
	load    [$i10 + 0], $i1
	bne     $i1, -1, be_else.35068
be_then.35068:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.35068:
.count stack_store
	store   $i10, [$sp + 4]
.count stack_store
	store   $i8, [$sp + 5]
	bne     $i1, 99, be_else.35069
be_then.35069:
	li      1, $i18
.count b_cont
	b       be_cont.35069
be_else.35069:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35070
be_then.35070:
	li      0, $i18
.count b_cont
	b       be_cont.35070
be_else.35070:
	bg      $fc7, $fg0, ble_else.35071
ble_then.35071:
	li      0, $i18
.count b_cont
	b       ble_cont.35071
ble_else.35071:
	load    [$i10 + 1], $i18
	bne     $i18, -1, be_else.35072
be_then.35072:
	li      0, $i18
.count b_cont
	b       be_cont.35072
be_else.35072:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35073
be_then.35073:
.count stack_load
	load    [$sp + 4], $i18
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35074
be_then.35074:
	li      0, $i18
.count b_cont
	b       be_cont.35073
be_else.35074:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35075
be_then.35075:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35076
be_then.35076:
	li      0, $i18
.count b_cont
	b       be_cont.35073
be_else.35076:
	li      1, $i18
.count b_cont
	b       be_cont.35073
be_else.35075:
	li      1, $i18
.count b_cont
	b       be_cont.35073
be_else.35073:
	li      1, $i18
be_cont.35073:
be_cont.35072:
ble_cont.35071:
be_cont.35070:
be_cont.35069:
	bne     $i18, 0, be_else.35077
be_then.35077:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35077:
.count stack_load
	load    [$sp + 4], $i18
	load    [$i18 + 1], $i19
	bne     $i19, -1, be_else.35078
be_then.35078:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35078:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35079
be_then.35079:
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35080
be_then.35080:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35080:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35081
be_then.35081:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.35082
be_then.35082:
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35082:
	li      1, $i1
	ret
be_else.35081:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35079:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35067:
.count stack_load
	load    [$sp + 1], $i18
	load    [$i18 + 1], $i19
	bne     $i19, -1, be_else.35083
be_then.35083:
	li      0, $i8
.count b_cont
	b       be_cont.35083
be_else.35083:
	load    [ext_and_net + $i19], $i3
	li      0, $i10
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35084
be_then.35084:
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35085
be_then.35085:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35085:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35086
be_then.35086:
	load    [$i18 + 3], $i19
	bne     $i19, -1, be_else.35087
be_then.35087:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35087:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35088
be_then.35088:
	load    [$i18 + 4], $i19
	bne     $i19, -1, be_else.35089
be_then.35089:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35089:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35090
be_then.35090:
	load    [$i18 + 5], $i19
	bne     $i19, -1, be_else.35091
be_then.35091:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35091:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35092
be_then.35092:
	load    [$i18 + 6], $i19
	bne     $i19, -1, be_else.35093
be_then.35093:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35093:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35094
be_then.35094:
	load    [$i18 + 7], $i19
	bne     $i19, -1, be_else.35095
be_then.35095:
	li      0, $i8
.count b_cont
	b       be_cont.35084
be_else.35095:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35096
be_then.35096:
	li      8, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i8
.count b_cont
	b       be_cont.35084
be_else.35096:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35094:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35092:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35090:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35088:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35086:
	li      1, $i8
.count b_cont
	b       be_cont.35084
be_else.35084:
	li      1, $i8
be_cont.35084:
be_cont.35083:
	bne     $i8, 0, be_else.35097
be_then.35097:
.count stack_load
	load    [$sp + 3], $i8
	add     $i8, 1, $i8
.count stack_load
	load    [$sp + 2], $i9
	load    [$i9 + $i8], $i10
	load    [$i10 + 0], $i1
	bne     $i1, -1, be_else.35098
be_then.35098:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.35098:
.count stack_store
	store   $i10, [$sp + 6]
.count stack_store
	store   $i8, [$sp + 7]
	bne     $i1, 99, be_else.35099
be_then.35099:
	li      1, $i18
.count b_cont
	b       be_cont.35099
be_else.35099:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35100
be_then.35100:
	li      0, $i18
.count b_cont
	b       be_cont.35100
be_else.35100:
	bg      $fc7, $fg0, ble_else.35101
ble_then.35101:
	li      0, $i18
.count b_cont
	b       ble_cont.35101
ble_else.35101:
	load    [$i10 + 1], $i18
	bne     $i18, -1, be_else.35102
be_then.35102:
	li      0, $i18
.count b_cont
	b       be_cont.35102
be_else.35102:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35103
be_then.35103:
.count stack_load
	load    [$sp + 6], $i18
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35104
be_then.35104:
	li      0, $i18
.count b_cont
	b       be_cont.35103
be_else.35104:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35105
be_then.35105:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35106
be_then.35106:
	li      0, $i18
.count b_cont
	b       be_cont.35103
be_else.35106:
	li      1, $i18
.count b_cont
	b       be_cont.35103
be_else.35105:
	li      1, $i18
.count b_cont
	b       be_cont.35103
be_else.35103:
	li      1, $i18
be_cont.35103:
be_cont.35102:
ble_cont.35101:
be_cont.35100:
be_cont.35099:
	bne     $i18, 0, be_else.35107
be_then.35107:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35107:
.count stack_load
	load    [$sp + 6], $i18
	load    [$i18 + 1], $i19
	bne     $i19, -1, be_else.35108
be_then.35108:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35108:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35109
be_then.35109:
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35110
be_then.35110:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35110:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35111
be_then.35111:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.35112
be_then.35112:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i18
.count stack_load
	load    [$sp - 6], $i19
	b       shadow_check_one_or_matrix.2868
be_else.35112:
	li      1, $i1
	ret
be_else.35111:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35109:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35097:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i10, $i3, $i4)
# $ra = $ra
# [$i1 - $i16]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i10], $i11
	bne     $i11, -1, be_else.35113
be_then.35113:
	ret
be_else.35113:
	load    [ext_objects + $i11], $i12
	load    [$i12 + 5], $i13
	load    [$i12 + 5], $i14
	load    [$i12 + 5], $i15
	load    [$i12 + 1], $i16
	load    [$i13 + 0], $f10
	fsub    $fg21, $f10, $f10
	load    [$i14 + 1], $f11
	fsub    $fg22, $f11, $f11
	load    [$i15 + 2], $f12
	fsub    $fg23, $f12, $f12
	load    [$i4 + 0], $f13
	bne     $i16, 1, be_else.35114
be_then.35114:
	bne     $f13, $f0, be_else.35115
be_then.35115:
	li      0, $i13
.count b_cont
	b       be_cont.35115
be_else.35115:
	load    [$i12 + 4], $i13
	load    [$i12 + 6], $i14
	bg      $f0, $f13, ble_else.35116
ble_then.35116:
	li      0, $i15
.count b_cont
	b       ble_cont.35116
ble_else.35116:
	li      1, $i15
ble_cont.35116:
	bne     $i14, 0, be_else.35117
be_then.35117:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35117
be_else.35117:
	bne     $i15, 0, be_else.35118
be_then.35118:
	li      1, $i14
.count b_cont
	b       be_cont.35118
be_else.35118:
	li      0, $i14
be_cont.35118:
be_cont.35117:
	load    [$i13 + 0], $f14
	bne     $i14, 0, be_cont.35119
be_then.35119:
	fneg    $f14, $f14
be_cont.35119:
	fsub    $f14, $f10, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i13 + 1], $f14
	load    [$i4 + 1], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f11, $f15
	bg      $f14, $f15, ble_else.35120
ble_then.35120:
	li      0, $i13
.count b_cont
	b       ble_cont.35120
ble_else.35120:
	load    [$i13 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f12, $f15
	bg      $f14, $f15, ble_else.35121
ble_then.35121:
	li      0, $i13
.count b_cont
	b       ble_cont.35121
ble_else.35121:
	mov     $f13, $fg0
	li      1, $i13
ble_cont.35121:
ble_cont.35120:
be_cont.35115:
	bne     $i13, 0, be_else.35122
be_then.35122:
	load    [$i4 + 1], $f13
	bne     $f13, $f0, be_else.35123
be_then.35123:
	li      0, $i13
.count b_cont
	b       be_cont.35123
be_else.35123:
	load    [$i12 + 4], $i13
	load    [$i12 + 6], $i14
	bg      $f0, $f13, ble_else.35124
ble_then.35124:
	li      0, $i15
.count b_cont
	b       ble_cont.35124
ble_else.35124:
	li      1, $i15
ble_cont.35124:
	bne     $i14, 0, be_else.35125
be_then.35125:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35125
be_else.35125:
	bne     $i15, 0, be_else.35126
be_then.35126:
	li      1, $i14
.count b_cont
	b       be_cont.35126
be_else.35126:
	li      0, $i14
be_cont.35126:
be_cont.35125:
	load    [$i13 + 1], $f14
	bne     $i14, 0, be_cont.35127
be_then.35127:
	fneg    $f14, $f14
be_cont.35127:
	fsub    $f14, $f11, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i13 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f12, $f15
	bg      $f14, $f15, ble_else.35128
ble_then.35128:
	li      0, $i13
.count b_cont
	b       ble_cont.35128
ble_else.35128:
	load    [$i13 + 0], $f14
	load    [$i4 + 0], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f10, $f15
	bg      $f14, $f15, ble_else.35129
ble_then.35129:
	li      0, $i13
.count b_cont
	b       ble_cont.35129
ble_else.35129:
	mov     $f13, $fg0
	li      1, $i13
ble_cont.35129:
ble_cont.35128:
be_cont.35123:
	bne     $i13, 0, be_else.35130
be_then.35130:
	load    [$i4 + 2], $f13
	bne     $f13, $f0, be_else.35131
be_then.35131:
	li      0, $i12
.count b_cont
	b       be_cont.35114
be_else.35131:
	load    [$i12 + 4], $i13
	load    [$i13 + 0], $f14
	load    [$i4 + 0], $f15
	load    [$i12 + 6], $i12
	bg      $f0, $f13, ble_else.35132
ble_then.35132:
	li      0, $i14
.count b_cont
	b       ble_cont.35132
ble_else.35132:
	li      1, $i14
ble_cont.35132:
	bne     $i12, 0, be_else.35133
be_then.35133:
	mov     $i14, $i12
.count b_cont
	b       be_cont.35133
be_else.35133:
	bne     $i14, 0, be_else.35134
be_then.35134:
	li      1, $i12
.count b_cont
	b       be_cont.35134
be_else.35134:
	li      0, $i12
be_cont.35134:
be_cont.35133:
	load    [$i13 + 2], $f16
	bne     $i12, 0, be_cont.35135
be_then.35135:
	fneg    $f16, $f16
be_cont.35135:
	fsub    $f16, $f12, $f12
	finv    $f13, $f13
	fmul    $f12, $f13, $f12
	fmul    $f12, $f15, $f13
	fadd_a  $f13, $f10, $f10
	bg      $f14, $f10, ble_else.35136
ble_then.35136:
	li      0, $i12
.count b_cont
	b       be_cont.35114
ble_else.35136:
	load    [$i13 + 1], $f10
	load    [$i4 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35137
ble_then.35137:
	li      0, $i12
.count b_cont
	b       be_cont.35114
ble_else.35137:
	mov     $f12, $fg0
	li      3, $i12
.count b_cont
	b       be_cont.35114
be_else.35130:
	li      2, $i12
.count b_cont
	b       be_cont.35114
be_else.35122:
	li      1, $i12
.count b_cont
	b       be_cont.35114
be_else.35114:
	bne     $i16, 2, be_else.35138
be_then.35138:
	load    [$i12 + 4], $i12
	load    [$i12 + 0], $f14
	fmul    $f13, $f14, $f13
	load    [$i4 + 1], $f15
	load    [$i12 + 1], $f16
	fmul    $f15, $f16, $f15
	fadd    $f13, $f15, $f13
	load    [$i4 + 2], $f15
	load    [$i12 + 2], $f17
	fmul    $f15, $f17, $f15
	fadd    $f13, $f15, $f13
	bg      $f13, $f0, ble_else.35139
ble_then.35139:
	li      0, $i12
.count b_cont
	b       be_cont.35138
ble_else.35139:
	fmul    $f14, $f10, $f10
	fmul    $f16, $f11, $f11
	fadd    $f10, $f11, $f10
	fmul    $f17, $f12, $f11
	fadd_n  $f10, $f11, $f10
	finv    $f13, $f11
	fmul    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35138
be_else.35138:
	load    [$i12 + 3], $i13
	load    [$i12 + 4], $i14
	load    [$i12 + 4], $i15
	load    [$i12 + 4], $i16
	load    [$i4 + 1], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f13, $f16
	load    [$i14 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f14, $f14, $f18
	load    [$i15 + 1], $f1
	fmul    $f18, $f1, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f15, $f18
	load    [$i16 + 2], $f2
	fmul    $f18, $f2, $f18
	fadd    $f16, $f18, $f16
	be      $i13, 0, bne_cont.35140
bne_then.35140:
	fmul    $f14, $f15, $f18
	load    [$i12 + 9], $i14
	load    [$i14 + 0], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f13, $f18
	load    [$i12 + 9], $i14
	load    [$i14 + 1], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
	fmul    $f13, $f14, $f18
	load    [$i12 + 9], $i14
	load    [$i14 + 2], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
bne_cont.35140:
	bne     $f16, $f0, be_else.35141
be_then.35141:
	li      0, $i12
.count b_cont
	b       be_cont.35141
be_else.35141:
	load    [$i12 + 1], $i14
	fmul    $f13, $f10, $f18
	fmul    $f18, $f17, $f18
	fmul    $f14, $f11, $f3
	fmul    $f3, $f1, $f3
	fadd    $f18, $f3, $f18
	fmul    $f15, $f12, $f3
	fmul    $f3, $f2, $f3
	fadd    $f18, $f3, $f18
	bne     $i13, 0, be_else.35142
be_then.35142:
	mov     $f18, $f13
.count b_cont
	b       be_cont.35142
be_else.35142:
	fmul    $f15, $f11, $f3
	fmul    $f14, $f12, $f4
	fadd    $f3, $f4, $f3
	load    [$i12 + 9], $i15
	load    [$i15 + 0], $f4
	fmul    $f3, $f4, $f3
	fmul    $f13, $f12, $f4
	fmul    $f15, $f10, $f15
	fadd    $f4, $f15, $f15
	load    [$i12 + 9], $i15
	load    [$i15 + 1], $f4
	fmul    $f15, $f4, $f15
	fadd    $f3, $f15, $f15
	fmul    $f13, $f11, $f13
	fmul    $f14, $f10, $f14
	fadd    $f13, $f14, $f13
	load    [$i12 + 9], $i15
	load    [$i15 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f15, $f13, $f13
	fmul    $f13, $fc3, $f13
	fadd    $f18, $f13, $f13
be_cont.35142:
	fmul    $f13, $f13, $f14
	fmul    $f10, $f10, $f15
	fmul    $f15, $f17, $f15
	fmul    $f11, $f11, $f17
	fmul    $f17, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f12, $f17
	fmul    $f17, $f2, $f17
	fadd    $f15, $f17, $f15
	bne     $i13, 0, be_else.35143
be_then.35143:
	mov     $f15, $f10
.count b_cont
	b       be_cont.35143
be_else.35143:
	fmul    $f11, $f12, $f17
	load    [$i12 + 9], $i13
	load    [$i13 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f10, $f12
	load    [$i12 + 9], $i13
	load    [$i13 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f15, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i12 + 9], $i13
	load    [$i13 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.35143:
	bne     $i14, 3, be_cont.35144
be_then.35144:
	fsub    $f10, $fc0, $f10
be_cont.35144:
	fmul    $f16, $f10, $f10
	fsub    $f14, $f10, $f10
	bg      $f10, $f0, ble_else.35145
ble_then.35145:
	li      0, $i12
.count b_cont
	b       ble_cont.35145
ble_else.35145:
	load    [$i12 + 6], $i12
	fsqrt   $f10, $f10
	finv    $f16, $f11
	bne     $i12, 0, be_else.35146
be_then.35146:
	fneg    $f10, $f10
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35146
be_else.35146:
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i12
be_cont.35146:
ble_cont.35145:
be_cont.35141:
be_cont.35138:
be_cont.35114:
	bne     $i12, 0, be_else.35147
be_then.35147:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35148
be_then.35148:
	ret
be_else.35148:
	add     $i10, 1, $i10
	b       solve_each_element.2871
be_else.35147:
	bg      $fg0, $f0, ble_else.35149
ble_then.35149:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.35149:
	bg      $fg7, $fg0, ble_else.35150
ble_then.35150:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.35150:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	li      0, $i1
	load    [$i4 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg21, $f2
.count stack_store
	store   $f2, [$sp + 3]
	load    [$i4 + 1], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg22, $f3
.count stack_store
	store   $f3, [$sp + 4]
	load    [$i4 + 2], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg23, $f4
.count stack_store
	store   $f4, [$sp + 5]
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	add     $i10, 1, $i10
	bne     $i1, 0, be_else.35151
be_then.35151:
.count stack_load
	load    [$sp - 4], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       solve_each_element.2871
be_else.35151:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [ext_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [ext_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [ext_intersection_point + 2]
	mov     $i11, $ig3
	mov     $i12, $ig2
.count stack_load
	load    [$sp - 4], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network($i17, $i18, $i4)
# $ra = $ra
# [$i1 - $i19]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35152
be_then.35152:
	ret
be_else.35152:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35153
be_then.35153:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35153:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35154
be_then.35154:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35154:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35155
be_then.35155:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35155:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35156
be_then.35156:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35156:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35157
be_then.35157:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35157:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35158
be_then.35158:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35158:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35159
be_then.35159:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35159:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 1], $i4
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i17, $i18, $i4)
# $ra = $ra
# [$i1 - $i20]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i18 + $i17], $i19
	load    [$i19 + 0], $i20
	bne     $i20, -1, be_else.35160
be_then.35160:
	ret
be_else.35160:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	bne     $i20, 99, be_else.35161
be_then.35161:
.count stack_store
	store   $i18, [$sp + 2]
.count stack_store
	store   $i17, [$sp + 3]
	load    [$i19 + 1], $i17
	be      $i17, -1, bne_cont.35162
bne_then.35162:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
	call    solve_each_element.2871
	load    [$i19 + 2], $i17
	be      $i17, -1, bne_cont.35163
bne_then.35163:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 3], $i17
	be      $i17, -1, bne_cont.35164
bne_then.35164:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 4], $i17
	be      $i17, -1, bne_cont.35165
bne_then.35165:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 5], $i17
	be      $i17, -1, bne_cont.35166
bne_then.35166:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 6], $i17
	be      $i17, -1, bne_cont.35167
bne_then.35167:
	li      0, $i10
	load    [ext_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	li      7, $i17
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i19, $i18
	call    solve_one_or_network.2875
bne_cont.35167:
bne_cont.35166:
bne_cont.35165:
bne_cont.35164:
bne_cont.35163:
bne_cont.35162:
.count stack_load
	load    [$sp + 3], $i17
	add     $i17, 1, $i17
.count stack_load
	load    [$sp + 2], $i18
	load    [$i18 + $i17], $i19
	load    [$i19 + 0], $i20
	bne     $i20, -1, be_else.35168
be_then.35168:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.35168:
	bne     $i20, 99, be_else.35169
be_then.35169:
	load    [$i19 + 1], $i20
	bne     $i20, -1, be_else.35170
be_then.35170:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35170:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 2], $i20
	bne     $i20, -1, be_else.35171
be_then.35171:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35171:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 3], $i20
	bne     $i20, -1, be_else.35172
be_then.35172:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35172:
	li      0, $i10
	load    [ext_and_net + $i20], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i19 + 4], $i20
	bne     $i20, -1, be_else.35173
be_then.35173:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35173:
.count stack_store
	store   $i17, [$sp + 4]
	li      0, $i10
	load    [ext_and_net + $i20], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	li      5, $i17
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i19, $i18
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i17
.count stack_load
	load    [$sp - 3], $i18
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35169:
.count stack_load
	load    [$sp + 1], $i2
.count move_args
	mov     $i20, $i1
	call    solver.2773
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35174
be_then.35174:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35174:
	bg      $fg7, $fg0, ble_else.35175
ble_then.35175:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
ble_else.35175:
.count stack_store
	store   $i17, [$sp + 4]
	li      1, $i17
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i19, $i18
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i17
.count stack_load
	load    [$sp - 3], $i18
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35161:
.count move_args
	mov     $i20, $i1
.count move_args
	mov     $i4, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35176
be_then.35176:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35176:
	bg      $fg7, $fg0, ble_else.35177
ble_then.35177:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i17, 1, $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
ble_else.35177:
.count stack_store
	store   $i18, [$sp + 2]
.count stack_store
	store   $i17, [$sp + 3]
	li      1, $i17
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i19, $i18
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i17
.count stack_load
	load    [$sp - 3], $i18
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i10, $i3, $i4)
# $ra = $ra
# [$i1 - $i15]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i10], $i11
	bne     $i11, -1, be_else.35178
be_then.35178:
	ret
be_else.35178:
	load    [ext_objects + $i11], $i12
	load    [$i12 + 10], $i13
	load    [$i4 + 1], $i14
	load    [$i12 + 1], $i15
	load    [$i13 + 0], $f10
	load    [$i13 + 1], $f11
	load    [$i13 + 2], $f12
	load    [$i14 + $i11], $i14
	bne     $i15, 1, be_else.35179
be_then.35179:
	load    [$i4 + 0], $i13
	load    [$i12 + 4], $i15
	load    [$i15 + 1], $f13
	load    [$i13 + 1], $f14
	load    [$i14 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i14 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35180
ble_then.35180:
	li      0, $i15
.count b_cont
	b       ble_cont.35180
ble_else.35180:
	load    [$i12 + 4], $i15
	load    [$i15 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35181
ble_then.35181:
	li      0, $i15
.count b_cont
	b       ble_cont.35181
ble_else.35181:
	load    [$i14 + 1], $f13
	bne     $f13, $f0, be_else.35182
be_then.35182:
	li      0, $i15
.count b_cont
	b       be_cont.35182
be_else.35182:
	li      1, $i15
be_cont.35182:
ble_cont.35181:
ble_cont.35180:
	bne     $i15, 0, be_else.35183
be_then.35183:
	load    [$i12 + 4], $i15
	load    [$i15 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i14 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i14 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.35184
ble_then.35184:
	li      0, $i15
.count b_cont
	b       ble_cont.35184
ble_else.35184:
	load    [$i12 + 4], $i15
	load    [$i15 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35185
ble_then.35185:
	li      0, $i15
.count b_cont
	b       ble_cont.35185
ble_else.35185:
	load    [$i14 + 3], $f13
	bne     $f13, $f0, be_else.35186
be_then.35186:
	li      0, $i15
.count b_cont
	b       be_cont.35186
be_else.35186:
	li      1, $i15
be_cont.35186:
ble_cont.35185:
ble_cont.35184:
	bne     $i15, 0, be_else.35187
be_then.35187:
	load    [$i12 + 4], $i15
	load    [$i15 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i14 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i14 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.35188
ble_then.35188:
	li      0, $i12
.count b_cont
	b       be_cont.35179
ble_else.35188:
	load    [$i12 + 4], $i12
	load    [$i12 + 1], $f10
	load    [$i13 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35189
ble_then.35189:
	li      0, $i12
.count b_cont
	b       be_cont.35179
ble_else.35189:
	load    [$i14 + 5], $f10
	bne     $f10, $f0, be_else.35190
be_then.35190:
	li      0, $i12
.count b_cont
	b       be_cont.35179
be_else.35190:
	mov     $f12, $fg0
	li      3, $i12
.count b_cont
	b       be_cont.35179
be_else.35187:
	mov     $f15, $fg0
	li      2, $i12
.count b_cont
	b       be_cont.35179
be_else.35183:
	mov     $f15, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35179
be_else.35179:
	bne     $i15, 2, be_else.35191
be_then.35191:
	load    [$i14 + 0], $f10
	bg      $f0, $f10, ble_else.35192
ble_then.35192:
	li      0, $i12
.count b_cont
	b       be_cont.35191
ble_else.35192:
	load    [$i13 + 3], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35191
be_else.35191:
	load    [$i14 + 0], $f13
	bne     $f13, $f0, be_else.35193
be_then.35193:
	li      0, $i12
.count b_cont
	b       be_cont.35193
be_else.35193:
	load    [$i14 + 1], $f14
	fmul    $f14, $f10, $f10
	load    [$i14 + 2], $f14
	fmul    $f14, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i14 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $f10, $f11
	load    [$i13 + 3], $f12
	fmul    $f13, $f12, $f12
	fsub    $f11, $f12, $f11
	bg      $f11, $f0, ble_else.35194
ble_then.35194:
	li      0, $i12
.count b_cont
	b       ble_cont.35194
ble_else.35194:
	load    [$i12 + 6], $i12
	fsqrt   $f11, $f11
	bne     $i12, 0, be_else.35195
be_then.35195:
	fsub    $f10, $f11, $f10
	load    [$i14 + 4], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i12
.count b_cont
	b       be_cont.35195
be_else.35195:
	fadd    $f10, $f11, $f10
	load    [$i14 + 4], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i12
be_cont.35195:
ble_cont.35194:
be_cont.35193:
be_cont.35191:
be_cont.35179:
	bne     $i12, 0, be_else.35196
be_then.35196:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35197
be_then.35197:
	ret
be_else.35197:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
be_else.35196:
	bg      $fg0, $f0, ble_else.35198
ble_then.35198:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.35198:
	load    [$i4 + 0], $i13
	bg      $fg7, $fg0, ble_else.35199
ble_then.35199:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.35199:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	li      0, $i1
	load    [$i13 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg8, $f2
.count stack_store
	store   $f2, [$sp + 3]
	load    [$i13 + 1], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg9, $f3
.count stack_store
	store   $f3, [$sp + 4]
	load    [$i13 + 2], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg10, $f4
.count stack_store
	store   $f4, [$sp + 5]
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	add     $i10, 1, $i10
	bne     $i1, 0, be_else.35200
be_then.35200:
.count stack_load
	load    [$sp - 4], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       solve_each_element_fast.2885
be_else.35200:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [ext_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [ext_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [ext_intersection_point + 2]
	mov     $i11, $ig3
	mov     $i12, $ig2
.count stack_load
	load    [$sp - 4], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i16, $i17, $i4)
# $ra = $ra
# [$i1 - $i18]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35201
be_then.35201:
	ret
be_else.35201:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	li      0, $i10
	load    [ext_and_net + $i18], $i3
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35202
be_then.35202:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35202:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35203
be_then.35203:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35203:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35204
be_then.35204:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35204:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35205
be_then.35205:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35205:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35206
be_then.35206:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35206:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35207
be_then.35207:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35207:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35208
be_then.35208:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.35208:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 1], $i4
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i16, $i17, $i4)
# $ra = $ra
# [$i1 - $i19]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i17 + $i16], $i18
	load    [$i18 + 0], $i19
	bne     $i19, -1, be_else.35209
be_then.35209:
	ret
be_else.35209:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	bne     $i19, 99, be_else.35210
be_then.35210:
.count stack_store
	store   $i17, [$sp + 2]
.count stack_store
	store   $i16, [$sp + 3]
	load    [$i18 + 1], $i16
	be      $i16, -1, bne_cont.35211
bne_then.35211:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
	call    solve_each_element_fast.2885
	load    [$i18 + 2], $i16
	be      $i16, -1, bne_cont.35212
bne_then.35212:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 3], $i16
	be      $i16, -1, bne_cont.35213
bne_then.35213:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 4], $i16
	be      $i16, -1, bne_cont.35214
bne_then.35214:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 5], $i16
	be      $i16, -1, bne_cont.35215
bne_then.35215:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 6], $i16
	be      $i16, -1, bne_cont.35216
bne_then.35216:
	li      0, $i10
	load    [ext_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	li      7, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i18, $i17
	call    solve_one_or_network_fast.2889
bne_cont.35216:
bne_cont.35215:
bne_cont.35214:
bne_cont.35213:
bne_cont.35212:
bne_cont.35211:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i17
	load    [$i17 + $i16], $i18
	load    [$i18 + 0], $i19
	bne     $i19, -1, be_else.35217
be_then.35217:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.35217:
	bne     $i19, 99, be_else.35218
be_then.35218:
	load    [$i18 + 1], $i19
	bne     $i19, -1, be_else.35219
be_then.35219:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35219:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35220
be_then.35220:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35220:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 3], $i19
	bne     $i19, -1, be_else.35221
be_then.35221:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35221:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i18 + 4], $i19
	bne     $i19, -1, be_else.35222
be_then.35222:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35222:
.count stack_store
	store   $i16, [$sp + 4]
	li      0, $i10
	load    [ext_and_net + $i19], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	li      5, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i18, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i16
.count stack_load
	load    [$sp - 3], $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35218:
.count stack_load
	load    [$sp + 1], $i2
.count move_args
	mov     $i19, $i1
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35223
be_then.35223:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35223:
	bg      $fg7, $fg0, ble_else.35224
ble_then.35224:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
ble_else.35224:
.count stack_store
	store   $i16, [$sp + 4]
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i18, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i16
.count stack_load
	load    [$sp - 3], $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35210:
.count move_args
	mov     $i19, $i1
.count move_args
	mov     $i4, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35225
be_then.35225:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.35225:
	bg      $fg7, $fg0, ble_else.35226
ble_then.35226:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i16
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
ble_else.35226:
.count stack_store
	store   $i17, [$sp + 2]
.count stack_store
	store   $i16, [$sp + 3]
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i18, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i16
.count stack_load
	load    [$sp - 3], $i17
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra
# [$i1 - $i6]
# [$f1 - $f11]
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
	bne     $i2, 1, be_else.35227
be_then.35227:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f4
	load    [$i2 + 0], $f5
.count load_float
	load    [f.31957], $f6
	fsub    $f4, $f5, $f4
	fmul    $f4, $f6, $f2
	call    ext_floor
.count move_ret
	mov     $f1, $f5
.count load_float
	load    [f.31958], $f7
.count load_float
	load    [f.31959], $f8
	fmul    $f5, $f7, $f5
	fsub    $f4, $f5, $f4
	load    [ext_intersection_point + 2], $f5
	load    [$i1 + 2], $f9
	fsub    $f5, $f9, $f5
	fmul    $f5, $f6, $f2
	call    ext_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	fmul    $f1, $f7, $f1
	fsub    $f5, $f1, $f1
	bg      $f8, $f4, ble_else.35228
ble_then.35228:
	li      0, $i1
.count b_cont
	b       ble_cont.35228
ble_else.35228:
	li      1, $i1
ble_cont.35228:
	bg      $f8, $f1, ble_else.35229
ble_then.35229:
	bne     $i1, 0, be_else.35230
be_then.35230:
	mov     $fc9, $fg11
	ret
be_else.35230:
	mov     $f0, $fg11
	ret
ble_else.35229:
	bne     $i1, 0, be_else.35231
be_then.35231:
	mov     $f0, $fg11
	ret
be_else.35231:
	mov     $fc9, $fg11
	ret
be_else.35227:
	bne     $i2, 2, be_else.35232
be_then.35232:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [ext_intersection_point + 1], $f8
.count load_float
	load    [f.31956], $f9
	fmul    $f8, $f9, $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	ret
be_else.35232:
	bne     $i2, 3, be_else.35233
be_then.35233:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f4
	load    [$i2 + 0], $f5
	fsub    $f4, $f5, $f4
	fmul    $f4, $f4, $f4
	load    [ext_intersection_point + 2], $f5
	load    [$i1 + 2], $f6
	fsub    $f5, $f6, $f5
	fmul    $f5, $f5, $f5
	fadd    $f4, $f5, $f4
	fsqrt   $f4, $f4
	fmul    $f4, $fc8, $f2
.count stack_store
	store   $f2, [$sp + 1]
	call    ext_floor
.count move_ret
	mov     $f1, $f9
.count stack_load
	load    [$sp + 1], $f10
	fsub    $f10, $f9, $f9
	fmul    $f9, $fc15, $f2
	call    ext_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg15
	ret
be_else.35233:
	bne     $i2, 4, be_else.35234
be_then.35234:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 5], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 4], $i6
.count load_float
	load    [f.31947], $f6
	load    [ext_intersection_point + 0], $f7
	load    [$i3 + 0], $f8
	fsub    $f7, $f8, $f7
	load    [$i4 + 0], $f8
	fsqrt   $f8, $f8
	fmul    $f7, $f8, $f7
	fabs    $f7, $f8
	load    [ext_intersection_point + 2], $f9
	load    [$i5 + 2], $f10
	fsub    $f9, $f10, $f9
	load    [$i6 + 2], $f10
	fsqrt   $f10, $f10
	fmul    $f9, $f10, $f9
	bg      $f6, $f8, ble_else.35235
ble_then.35235:
	finv    $f7, $f8
	fmul_a  $f9, $f8, $f2
	call    ext_atan
.count move_ret
	mov     $f1, $f8
	fmul    $f8, $fc18, $f8
	fmul    $f8, $fc17, $f8
.count b_cont
	b       ble_cont.35235
ble_else.35235:
	mov     $fc19, $f8
ble_cont.35235:
	load    [$i1 + 5], $i3
	load    [$i1 + 4], $i1
	fmul    $f7, $f7, $f7
	fmul    $f9, $f9, $f9
	fadd    $f7, $f9, $f7
	fabs    $f7, $f9
	load    [ext_intersection_point + 1], $f10
	load    [$i3 + 1], $f11
	fsub    $f10, $f11, $f10
	load    [$i1 + 1], $f11
	fsqrt   $f11, $f11
	fmul    $f10, $f11, $f10
	bg      $f6, $f9, ble_else.35236
ble_then.35236:
	finv    $f7, $f6
	fmul_a  $f10, $f6, $f2
	call    ext_atan
.count move_ret
	mov     $f1, $f4
	fmul    $f4, $fc18, $f4
	fmul    $f4, $fc17, $f4
.count b_cont
	b       ble_cont.35236
ble_else.35236:
	mov     $fc19, $f4
ble_cont.35236:
.count load_float
	load    [f.31952], $f5
.count move_args
	mov     $f8, $f2
	call    ext_floor
.count move_ret
	mov     $f1, $f6
	fsub    $f8, $f6, $f6
	fsub    $fc3, $f6, $f6
	fmul    $f6, $f6, $f6
	fsub    $f5, $f6, $f5
.count move_args
	mov     $f4, $f2
	call    ext_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	fsub    $f4, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.35237
ble_then.35237:
	fmul    $fc9, $f1, $f1
.count load_float
	load    [f.31954], $f2
	fmul    $f1, $f2, $fg15
	ret
ble_else.35237:
	mov     $f0, $fg15
	ret
be_else.35234:
	ret
.end utexture

######################################################################
# trace_reflections($i20, $f17, $f18, $i21)
# $ra = $ra
# [$i1 - $i24]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i20, 0, bge_else.35238
bge_then.35238:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [ext_reflections + $i20], $i22
	load    [$i22 + 1], $i4
.count stack_store
	store   $i4, [$sp + 1]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i23
	load    [$i23 + 0], $i24
	be      $i24, -1, bne_cont.35239
bne_then.35239:
	bne     $i24, 99, be_else.35240
be_then.35240:
	load    [$i23 + 1], $i24
	bne     $i24, -1, be_else.35241
be_then.35241:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35240
be_else.35241:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element_fast.2885
	load    [$i23 + 2], $i24
.count stack_load
	load    [$sp + 1], $i4
	bne     $i24, -1, be_else.35242
be_then.35242:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35240
be_else.35242:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element_fast.2885
	load    [$i23 + 3], $i24
.count stack_load
	load    [$sp + 1], $i4
	bne     $i24, -1, be_else.35243
be_then.35243:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35240
be_else.35243:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element_fast.2885
	load    [$i23 + 4], $i24
.count stack_load
	load    [$sp + 1], $i4
	bne     $i24, -1, be_else.35244
be_then.35244:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35240
be_else.35244:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element_fast.2885
	li      5, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i23, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35240
be_else.35240:
.count move_args
	mov     $i24, $i1
.count move_args
	mov     $i4, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i24
.count stack_load
	load    [$sp + 1], $i4
	li      1, $i16
	bne     $i24, 0, be_else.35245
be_then.35245:
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35245
be_else.35245:
	bg      $fg7, $fg0, ble_else.35246
ble_then.35246:
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.35246
ble_else.35246:
.count move_args
	mov     $i23, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
ble_cont.35246:
be_cont.35245:
be_cont.35240:
bne_cont.35239:
	bg      $fg7, $fc7, ble_else.35247
ble_then.35247:
	li      0, $i23
.count b_cont
	b       ble_cont.35247
ble_else.35247:
	bg      $fc13, $fg7, ble_else.35248
ble_then.35248:
	li      0, $i23
.count b_cont
	b       ble_cont.35248
ble_else.35248:
	li      1, $i23
ble_cont.35248:
ble_cont.35247:
	bne     $i23, 0, be_else.35249
be_then.35249:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	sub     $i20, 1, $i20
	b       trace_reflections.2915
be_else.35249:
	load    [$i22 + 0], $i23
	add     $ig3, $ig3, $i24
	add     $i24, $i24, $i24
	add     $i24, $ig2, $i24
	bne     $i24, $i23, be_else.35250
be_then.35250:
.count stack_store
	store   $f18, [$sp + 2]
.count stack_store
	store   $i20, [$sp + 3]
.count stack_store
	store   $i21, [$sp + 4]
.count stack_store
	store   $f17, [$sp + 5]
.count stack_store
	store   $i22, [$sp + 6]
	li      0, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 2], $f17
	bne     $i1, 0, be_else.35251
be_then.35251:
.count stack_load
	load    [$sp - 1], $i1
	load    [$i1 + 2], $f1
.count stack_load
	load    [$sp - 6], $i1
	load    [$i1 + 0], $i1
	fmul    $f1, $f17, $f2
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
	ble     $f2, $f0, bg_cont.35252
bg_then.35252:
	fmul    $f2, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f2, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f2, $fg15, $f2
	fadd    $fg6, $f2, $fg6
bg_cont.35252:
.count stack_load
	load    [$sp - 3], $i21
	load    [$i21 + 0], $f2
	fmul    $f2, $f4, $f2
	load    [$i21 + 1], $f3
	fmul    $f3, $f6, $f3
	fadd    $f2, $f3, $f2
	load    [$i21 + 2], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
.count stack_load
	load    [$sp - 5], $f18
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i20
	ble     $f1, $f0, trace_reflections.2915
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f18, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
be_else.35251:
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i20
.count stack_load
	load    [$sp - 5], $f18
.count stack_load
	load    [$sp - 3], $i21
	b       trace_reflections.2915
be_else.35250:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	sub     $i20, 1, $i20
	b       trace_reflections.2915
bge_else.35238:
	ret
.end trace_reflections

######################################################################
# trace_ray($i21, $f14, $i4, $i22, $f15)
# $ra = $ra
# [$i1 - $i24]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i21, 4, ble_else.35254
ble_then.35254:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f15, [$sp + 1]
.count stack_store
	store   $f14, [$sp + 2]
.count stack_store
	store   $i4, [$sp + 3]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i23
	load    [$i23 + 0], $i24
	be      $i24, -1, bne_cont.35255
bne_then.35255:
	bne     $i24, 99, be_else.35256
be_then.35256:
	load    [$i23 + 1], $i24
	bne     $i24, -1, be_else.35257
be_then.35257:
	li      1, $i17
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35256
be_else.35257:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element.2871
	load    [$i23 + 2], $i24
.count stack_load
	load    [$sp + 3], $i4
	bne     $i24, -1, be_else.35258
be_then.35258:
	li      1, $i17
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35256
be_else.35258:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element.2871
	load    [$i23 + 3], $i24
.count stack_load
	load    [$sp + 3], $i4
	bne     $i24, -1, be_else.35259
be_then.35259:
	li      1, $i17
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35256
be_else.35259:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element.2871
	load    [$i23 + 4], $i24
.count stack_load
	load    [$sp + 3], $i4
	bne     $i24, -1, be_else.35260
be_then.35260:
	li      1, $i17
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35256
be_else.35260:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    solve_each_element.2871
	li      5, $i17
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i23, $i18
	call    solve_one_or_network.2875
	li      1, $i17
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35256
be_else.35256:
.count move_args
	mov     $i24, $i1
.count move_args
	mov     $i4, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i24
.count stack_load
	load    [$sp + 3], $i4
	li      1, $i17
	bne     $i24, 0, be_else.35261
be_then.35261:
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.35261
be_else.35261:
	bg      $fg7, $fg0, ble_else.35262
ble_then.35262:
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.35262
ble_else.35262:
.count move_args
	mov     $i23, $i18
	call    solve_one_or_network.2875
	li      1, $i17
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $ig1, $i18
	call    trace_or_matrix.2879
ble_cont.35262:
be_cont.35261:
be_cont.35256:
bne_cont.35255:
	load    [$i22 + 2], $i7
	bg      $fg7, $fc7, ble_else.35263
ble_then.35263:
	li      0, $i8
.count b_cont
	b       ble_cont.35263
ble_else.35263:
	bg      $fc13, $fg7, ble_else.35264
ble_then.35264:
	li      0, $i8
.count b_cont
	b       ble_cont.35264
ble_else.35264:
	li      1, $i8
ble_cont.35264:
ble_cont.35263:
	bne     $i8, 0, be_else.35265
be_then.35265:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i0, -1, $i1
.count storer
	add     $i7, $i21, $tmp
	store   $i1, [$tmp + 0]
	bne     $i21, 0, be_else.35266
be_then.35266:
	ret
be_else.35266:
.count stack_load
	load    [$sp - 7], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_else.35267
ble_then.35267:
	ret
ble_else.35267:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
.count stack_load
	load    [$sp - 8], $f2
	fmul    $f1, $f2, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	ret
be_else.35265:
.count stack_store
	store   $i22, [$sp + 4]
.count stack_store
	store   $i7, [$sp + 5]
.count stack_store
	store   $i21, [$sp + 6]
	load    [ext_objects + $ig3], $i1
.count stack_store
	store   $i1, [$sp + 7]
	load    [$i1 + 1], $i8
	bne     $i8, 1, be_else.35268
be_then.35268:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i8
.count stack_load
	load    [$sp + 3], $i9
	load    [$i9 + $i8], $f12
	bne     $f12, $f0, be_else.35269
be_then.35269:
	store   $f0, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35268
be_else.35269:
	bg      $f12, $f0, ble_else.35270
ble_then.35270:
	store   $fc0, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35268
ble_else.35270:
	store   $fc4, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35268
be_else.35268:
	bne     $i8, 2, be_else.35271
be_then.35271:
	load    [$i1 + 4], $i8
	load    [$i8 + 0], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 0]
	load    [$i1 + 4], $i8
	load    [$i8 + 1], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 1]
	load    [$i1 + 4], $i8
	load    [$i8 + 2], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 2]
.count b_cont
	b       be_cont.35271
be_else.35271:
	load    [$i1 + 3], $i8
	load    [$i1 + 4], $i9
	load    [$i9 + 0], $f12
	load    [ext_intersection_point + 0], $f13
	load    [$i1 + 5], $i9
	load    [$i9 + 0], $f14
	fsub    $f13, $f14, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 4], $i9
	load    [$i9 + 1], $f14
	load    [ext_intersection_point + 1], $f15
	load    [$i1 + 5], $i9
	load    [$i9 + 1], $f16
	fsub    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	load    [$i1 + 4], $i9
	load    [$i9 + 2], $f16
	load    [ext_intersection_point + 2], $f17
	load    [$i1 + 5], $i9
	load    [$i9 + 2], $f18
	fsub    $f17, $f18, $f17
	fmul    $f17, $f16, $f16
	bne     $i8, 0, be_else.35272
be_then.35272:
	store   $f12, [ext_nvector + 0]
	store   $f14, [ext_nvector + 1]
	store   $f16, [ext_nvector + 2]
.count b_cont
	b       be_cont.35272
be_else.35272:
	load    [$i1 + 9], $i8
	load    [$i8 + 2], $f18
	fmul    $f15, $f18, $f18
	load    [$i1 + 9], $i8
	load    [$i8 + 1], $f10
	fmul    $f17, $f10, $f10
	fadd    $f18, $f10, $f18
	fmul    $f18, $fc3, $f18
	fadd    $f12, $f18, $f12
	store   $f12, [ext_nvector + 0]
	load    [$i1 + 9], $i8
	load    [$i8 + 2], $f12
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i8
	load    [$i8 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f12, $f17, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f14, $f12, $f12
	store   $f12, [ext_nvector + 1]
	load    [$i1 + 9], $i8
	load    [$i8 + 1], $f12
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i8
	load    [$i8 + 0], $f13
	fmul    $f15, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f16, $f12, $f12
	store   $f12, [ext_nvector + 2]
be_cont.35272:
	load    [ext_nvector + 0], $f12
	load    [$i1 + 6], $i8
	fmul    $f12, $f12, $f13
	load    [ext_nvector + 1], $f14
	fmul    $f14, $f14, $f14
	fadd    $f13, $f14, $f13
	load    [ext_nvector + 2], $f14
	fmul    $f14, $f14, $f14
	fadd    $f13, $f14, $f13
	fsqrt   $f13, $f13
	bne     $f13, $f0, be_else.35273
be_then.35273:
	mov     $fc0, $f13
.count b_cont
	b       be_cont.35273
be_else.35273:
	bne     $i8, 0, be_else.35274
be_then.35274:
	finv    $f13, $f13
.count b_cont
	b       be_cont.35274
be_else.35274:
	finv_n  $f13, $f13
be_cont.35274:
be_cont.35273:
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 0]
	load    [ext_nvector + 1], $f12
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 1]
	load    [ext_nvector + 2], $f12
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 2]
be_cont.35271:
be_cont.35268:
	load    [ext_intersection_point + 0], $fg21
	load    [ext_intersection_point + 1], $fg22
	load    [ext_intersection_point + 2], $fg23
	call    utexture.2908
	add     $ig3, $ig3, $i8
	add     $i8, $i8, $i8
	add     $i8, $ig2, $i8
.count storer
	add     $i7, $i21, $tmp
	store   $i8, [$tmp + 0]
	load    [$i22 + 1], $i8
	load    [$i8 + $i21], $i8
	load    [ext_intersection_point + 0], $f10
	store   $f10, [$i8 + 0]
	load    [ext_intersection_point + 1], $f10
	store   $f10, [$i8 + 1]
	load    [ext_intersection_point + 2], $f10
	store   $f10, [$i8 + 2]
.count stack_load
	load    [$sp + 7], $i8
	load    [$i8 + 7], $i8
	load    [$i22 + 3], $i9
	load    [$i8 + 0], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f10, $f11, $f11
.count stack_store
	store   $f11, [$sp + 8]
.count storer
	add     $i9, $i21, $tmp
	bg      $fc3, $f10, ble_else.35275
ble_then.35275:
	li      1, $i8
	store   $i8, [$tmp + 0]
	load    [$i22 + 4], $i8
	load    [$i8 + $i21], $i9
	store   $fg16, [$i9 + 0]
	store   $fg11, [$i9 + 1]
	store   $fg15, [$i9 + 2]
	load    [$i8 + $i21], $i8
.count load_float
	load    [f.31962], $f10
.count load_float
	load    [f.31963], $f10
	fmul    $f10, $f11, $f10
	load    [$i8 + 0], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i8 + 0]
	load    [$i8 + 1], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i8 + 1]
	load    [$i8 + 2], $f11
	fmul    $f11, $f10, $f10
	store   $f10, [$i8 + 2]
	load    [$i22 + 7], $i8
	load    [$i8 + $i21], $i8
	load    [ext_nvector + 0], $f10
	store   $f10, [$i8 + 0]
	load    [ext_nvector + 1], $f10
	store   $f10, [$i8 + 1]
	load    [ext_nvector + 2], $f10
	store   $f10, [$i8 + 2]
.count b_cont
	b       ble_cont.35275
ble_else.35275:
	li      0, $i8
	store   $i8, [$tmp + 0]
ble_cont.35275:
	load    [ext_nvector + 0], $f10
.count load_float
	load    [f.31964], $f11
.count stack_load
	load    [$sp + 3], $i8
	load    [$i8 + 0], $f12
	fmul    $f12, $f10, $f13
	load    [$i8 + 1], $f14
	load    [ext_nvector + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	load    [$i8 + 2], $f14
	load    [ext_nvector + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f13, $f11
	fmul    $f11, $f10, $f10
	fadd    $f12, $f10, $f10
	store   $f10, [$i8 + 0]
	load    [$i8 + 1], $f10
	load    [ext_nvector + 1], $f12
	fmul    $f11, $f12, $f12
	fadd    $f10, $f12, $f10
	store   $f10, [$i8 + 1]
	load    [$i8 + 2], $f10
	load    [ext_nvector + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	store   $f10, [$i8 + 2]
	load    [$ig1 + 0], $i8
	load    [$i8 + 0], $i1
	bne     $i1, -1, be_else.35276
be_then.35276:
	li      0, $i10
.count b_cont
	b       be_cont.35276
be_else.35276:
.count stack_store
	store   $i8, [$sp + 9]
	bne     $i1, 99, be_else.35277
be_then.35277:
	li      1, $i23
.count b_cont
	b       be_cont.35277
be_else.35277:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35278
be_then.35278:
	li      0, $i23
.count b_cont
	b       be_cont.35278
be_else.35278:
	bg      $fc7, $fg0, ble_else.35279
ble_then.35279:
	li      0, $i23
.count b_cont
	b       ble_cont.35279
ble_else.35279:
	load    [$i8 + 1], $i18
	bne     $i18, -1, be_else.35280
be_then.35280:
	li      0, $i23
.count b_cont
	b       be_cont.35280
be_else.35280:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35281
be_then.35281:
.count stack_load
	load    [$sp + 9], $i18
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35282
be_then.35282:
	li      0, $i23
.count b_cont
	b       be_cont.35281
be_else.35282:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35283
be_then.35283:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.35284
be_then.35284:
	li      0, $i23
.count b_cont
	b       be_cont.35281
be_else.35284:
	li      1, $i23
.count b_cont
	b       be_cont.35281
be_else.35283:
	li      1, $i23
.count b_cont
	b       be_cont.35281
be_else.35281:
	li      1, $i23
be_cont.35281:
be_cont.35280:
ble_cont.35279:
be_cont.35278:
be_cont.35277:
	bne     $i23, 0, be_else.35285
be_then.35285:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35285
be_else.35285:
.count stack_load
	load    [$sp + 9], $i23
	load    [$i23 + 1], $i24
	bne     $i24, -1, be_else.35286
be_then.35286:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35286
be_else.35286:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i24
	bne     $i24, 0, be_else.35287
be_then.35287:
	load    [$i23 + 2], $i24
	bne     $i24, -1, be_else.35288
be_then.35288:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35287
be_else.35288:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35289
be_then.35289:
	li      3, $i18
.count move_args
	mov     $i23, $i19
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.35290
be_then.35290:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35287
be_else.35290:
	li      1, $i10
.count b_cont
	b       be_cont.35287
be_else.35289:
	li      1, $i10
.count b_cont
	b       be_cont.35287
be_else.35287:
	li      1, $i10
be_cont.35287:
be_cont.35286:
be_cont.35285:
be_cont.35276:
.count stack_load
	load    [$sp + 7], $i11
	load    [$i11 + 7], $i11
	load    [$i11 + 1], $f7
.count stack_load
	load    [$sp + 2], $f8
	fmul    $f8, $f7, $f7
	bne     $i10, 0, be_cont.35291
be_then.35291:
	load    [ext_nvector + 0], $f8
	fmul    $f8, $fg12, $f8
	load    [ext_nvector + 1], $f9
	fmul    $f9, $fg13, $f9
	fadd    $f8, $f9, $f8
	load    [ext_nvector + 2], $f9
	fmul    $f9, $fg14, $f9
	fadd_n  $f8, $f9, $f8
.count stack_load
	load    [$sp + 8], $f9
	fmul    $f8, $f9, $f8
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f9
	fmul    $f9, $fg12, $f9
	load    [$i10 + 1], $f10
	fmul    $f10, $fg13, $f10
	fadd    $f9, $f10, $f9
	load    [$i10 + 2], $f10
	fmul    $f10, $fg14, $f10
	fadd_n  $f9, $f10, $f9
	ble     $f8, $f0, bg_cont.35292
bg_then.35292:
	fmul    $f8, $fg16, $f10
	fadd    $fg4, $f10, $fg4
	fmul    $f8, $fg11, $f10
	fadd    $fg5, $f10, $fg5
	fmul    $f8, $fg15, $f8
	fadd    $fg6, $f8, $fg6
bg_cont.35292:
	ble     $f9, $f0, bg_cont.35293
bg_then.35293:
	fmul    $f9, $f9, $f8
	fmul    $f8, $f8, $f8
	fmul    $f8, $f7, $f8
	fadd    $fg4, $f8, $fg4
	fadd    $fg5, $f8, $fg5
	fadd    $fg6, $f8, $fg6
bg_cont.35293:
be_cont.35291:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	sub     $ig4, 1, $i20
.count stack_load
	load    [$sp + 8], $f17
.count stack_load
	load    [$sp + 3], $i21
.count move_args
	mov     $f7, $f18
	call    trace_reflections.2915
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 8], $f1
	bg      $f1, $fc8, ble_else.35294
ble_then.35294:
	ret
ble_else.35294:
.count stack_load
	load    [$sp - 4], $i1
	bge     $i1, 4, bl_cont.35295
bl_then.35295:
	add     $i1, 1, $i1
	add     $i0, -1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i3, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.35295:
.count stack_load
	load    [$sp - 3], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.35296
be_then.35296:
	load    [$i1 + 7], $i1
.count stack_load
	load    [$sp - 9], $f2
	fadd    $f2, $fg7, $f15
.count stack_load
	load    [$sp - 4], $i2
	add     $i2, 1, $i21
	load    [$i1 + 0], $f2
	fsub    $fc0, $f2, $f2
	fmul    $f1, $f2, $f14
.count stack_load
	load    [$sp - 7], $i4
.count stack_load
	load    [$sp - 6], $i22
	b       trace_ray.2920
be_else.35296:
	ret
ble_else.35254:
	ret
.end trace_ray

######################################################################
# trace_diffuse_ray($i4, $f17)
# $ra = $ra
# [$i1 - $i24]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.35297
bne_then.35297:
	bne     $i21, 99, be_else.35298
be_then.35298:
	load    [$i20 + 1], $i21
	bne     $i21, -1, be_else.35299
be_then.35299:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35298
be_else.35299:
	li      0, $i10
	load    [ext_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 1], $i4
	bne     $i21, -1, be_else.35300
be_then.35300:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35298
be_else.35300:
	li      0, $i10
	load    [ext_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 1], $i4
	bne     $i21, -1, be_else.35301
be_then.35301:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35298
be_else.35301:
	li      0, $i10
	load    [ext_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 1], $i4
	bne     $i21, -1, be_else.35302
be_then.35302:
	li      1, $i16
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35298
be_else.35302:
	li      0, $i10
	load    [ext_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	li      5, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35298
be_else.35298:
.count move_args
	mov     $i21, $i1
.count move_args
	mov     $i4, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 1], $i4
	li      1, $i16
	bne     $i21, 0, be_else.35303
be_then.35303:
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.35303
be_else.35303:
	bg      $fg7, $fg0, ble_else.35304
ble_then.35304:
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.35304
ble_else.35304:
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i16
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $ig1, $i17
	call    trace_or_matrix_fast.2893
ble_cont.35304:
be_cont.35303:
be_cont.35298:
bne_cont.35297:
	bg      $fg7, $fc7, ble_else.35305
ble_then.35305:
	li      0, $i7
.count b_cont
	b       ble_cont.35305
ble_else.35305:
	bg      $fc13, $fg7, ble_else.35306
ble_then.35306:
	li      0, $i7
.count b_cont
	b       ble_cont.35306
ble_else.35306:
	li      1, $i7
ble_cont.35306:
ble_cont.35305:
	bne     $i7, 0, be_else.35307
be_then.35307:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.35307:
.count stack_store
	store   $f17, [$sp + 2]
.count stack_load
	load    [$sp + 1], $i7
	load    [$i7 + 0], $i7
	load    [ext_objects + $ig3], $i1
.count stack_store
	store   $i1, [$sp + 3]
	load    [$i1 + 1], $i8
	bne     $i8, 1, be_else.35308
be_then.35308:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i8
	load    [$i7 + $i8], $f12
	bne     $f12, $f0, be_else.35309
be_then.35309:
	store   $f0, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35308
be_else.35309:
	bg      $f12, $f0, ble_else.35310
ble_then.35310:
	store   $fc0, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35308
ble_else.35310:
	store   $fc4, [ext_nvector + $i8]
.count b_cont
	b       be_cont.35308
be_else.35308:
	bne     $i8, 2, be_else.35311
be_then.35311:
	load    [$i1 + 4], $i7
	load    [$i7 + 0], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 0]
	load    [$i1 + 4], $i7
	load    [$i7 + 1], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 1]
	load    [$i1 + 4], $i7
	load    [$i7 + 2], $f12
	fneg    $f12, $f12
	store   $f12, [ext_nvector + 2]
.count b_cont
	b       be_cont.35311
be_else.35311:
	load    [$i1 + 3], $i7
	load    [$i1 + 4], $i8
	load    [$i8 + 0], $f12
	load    [ext_intersection_point + 0], $f13
	load    [$i1 + 5], $i8
	load    [$i8 + 0], $f14
	fsub    $f13, $f14, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 4], $i8
	load    [$i8 + 1], $f14
	load    [ext_intersection_point + 1], $f15
	load    [$i1 + 5], $i8
	load    [$i8 + 1], $f16
	fsub    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	load    [$i1 + 4], $i8
	load    [$i8 + 2], $f16
	load    [ext_intersection_point + 2], $f17
	load    [$i1 + 5], $i8
	load    [$i8 + 2], $f18
	fsub    $f17, $f18, $f17
	fmul    $f17, $f16, $f16
	bne     $i7, 0, be_else.35312
be_then.35312:
	store   $f12, [ext_nvector + 0]
	store   $f14, [ext_nvector + 1]
	store   $f16, [ext_nvector + 2]
.count b_cont
	b       be_cont.35312
be_else.35312:
	load    [$i1 + 9], $i7
	load    [$i7 + 2], $f18
	fmul    $f15, $f18, $f18
	load    [$i1 + 9], $i7
	load    [$i7 + 1], $f10
	fmul    $f17, $f10, $f10
	fadd    $f18, $f10, $f18
	fmul    $f18, $fc3, $f18
	fadd    $f12, $f18, $f12
	store   $f12, [ext_nvector + 0]
	load    [$i1 + 9], $i7
	load    [$i7 + 2], $f12
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i7
	load    [$i7 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f12, $f17, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f14, $f12, $f12
	store   $f12, [ext_nvector + 1]
	load    [$i1 + 9], $i7
	load    [$i7 + 1], $f12
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i7
	load    [$i7 + 0], $f13
	fmul    $f15, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f16, $f12, $f12
	store   $f12, [ext_nvector + 2]
be_cont.35312:
	load    [ext_nvector + 0], $f12
	load    [$i1 + 6], $i7
	fmul    $f12, $f12, $f13
	load    [ext_nvector + 1], $f14
	fmul    $f14, $f14, $f14
	fadd    $f13, $f14, $f13
	load    [ext_nvector + 2], $f14
	fmul    $f14, $f14, $f14
	fadd    $f13, $f14, $f13
	fsqrt   $f13, $f13
	bne     $f13, $f0, be_else.35313
be_then.35313:
	mov     $fc0, $f13
.count b_cont
	b       be_cont.35313
be_else.35313:
	bne     $i7, 0, be_else.35314
be_then.35314:
	finv    $f13, $f13
.count b_cont
	b       be_cont.35314
be_else.35314:
	finv_n  $f13, $f13
be_cont.35314:
be_cont.35313:
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 0]
	load    [ext_nvector + 1], $f12
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 1]
	load    [ext_nvector + 2], $f12
	fmul    $f12, $f13, $f12
	store   $f12, [ext_nvector + 2]
be_cont.35311:
be_cont.35308:
	call    utexture.2908
	load    [$ig1 + 0], $i8
	load    [$i8 + 0], $i1
	bne     $i1, -1, be_else.35315
be_then.35315:
	li      0, $i1
.count b_cont
	b       be_cont.35315
be_else.35315:
.count stack_store
	store   $i8, [$sp + 4]
	bne     $i1, 99, be_else.35316
be_then.35316:
	li      1, $i23
.count b_cont
	b       be_cont.35316
be_else.35316:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35317
be_then.35317:
	li      0, $i23
.count b_cont
	b       be_cont.35317
be_else.35317:
	bg      $fc7, $fg0, ble_else.35318
ble_then.35318:
	li      0, $i23
.count b_cont
	b       ble_cont.35318
ble_else.35318:
	load    [$i8 + 1], $i18
	bne     $i18, -1, be_else.35319
be_then.35319:
	li      0, $i23
.count b_cont
	b       be_cont.35319
be_else.35319:
	li      0, $i10
	load    [ext_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35320
be_then.35320:
.count stack_load
	load    [$sp + 4], $i18
	load    [$i18 + 2], $i19
	bne     $i19, -1, be_else.35321
be_then.35321:
	li      0, $i23
.count b_cont
	b       be_cont.35320
be_else.35321:
	li      0, $i10
	load    [ext_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35322
be_then.35322:
	li      3, $i21
.count move_args
	mov     $i18, $i19
.count move_args
	mov     $i21, $i18
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.35323
be_then.35323:
	li      0, $i23
.count b_cont
	b       be_cont.35320
be_else.35323:
	li      1, $i23
.count b_cont
	b       be_cont.35320
be_else.35322:
	li      1, $i23
.count b_cont
	b       be_cont.35320
be_else.35320:
	li      1, $i23
be_cont.35320:
be_cont.35319:
ble_cont.35318:
be_cont.35317:
be_cont.35316:
	bne     $i23, 0, be_else.35324
be_then.35324:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.35324
be_else.35324:
.count stack_load
	load    [$sp + 4], $i23
	load    [$i23 + 1], $i24
	bne     $i24, -1, be_else.35325
be_then.35325:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.35325
be_else.35325:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i24
	bne     $i24, 0, be_else.35326
be_then.35326:
	load    [$i23 + 2], $i24
	bne     $i24, -1, be_else.35327
be_then.35327:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.35326
be_else.35327:
	li      0, $i10
	load    [ext_and_net + $i24], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i21
	bne     $i21, 0, be_else.35328
be_then.35328:
	li      3, $i18
.count move_args
	mov     $i23, $i19
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.35329
be_then.35329:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.35326
be_else.35329:
	li      1, $i1
.count b_cont
	b       be_cont.35326
be_else.35328:
	li      1, $i1
.count b_cont
	b       be_cont.35326
be_else.35326:
	li      1, $i1
be_cont.35326:
be_cont.35325:
be_cont.35324:
be_cont.35315:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	bne     $i1, 0, be_else.35330
be_then.35330:
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_cont.35331
ble_then.35331:
	mov     $f0, $f1
ble_cont.35331:
.count stack_load
	load    [$sp - 3], $f2
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	ret
be_else.35330:
	ret
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i25, $i26, $i27)
# $ra = $ra
# [$i1 - $i28]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i27, 0, bge_else.35332
bge_then.35332:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i25 + $i27], $i28
	load    [$i28 + 0], $i28
	load    [$i28 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i28 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i28 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.35333
ble_then.35333:
	fmul    $f1, $fc1, $f17
	load    [$i25 + $i27], $i4
	call    trace_diffuse_ray.2926
	sub     $i27, 2, $i27
	bl      $i27, 0, bge_else.35334
bge_then.35334:
	load    [$i25 + $i27], $i28
	load    [$i28 + 0], $i28
	load    [$i28 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i28 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i28 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.35335
ble_then.35335:
	fmul    $f1, $fc1, $f17
	load    [$i25 + $i27], $i4
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i27, 2, $i27
	b       iter_trace_diffuse_rays.2929
ble_else.35335:
	fmul    $f1, $fc2, $f17
	add     $i27, 1, $i28
	load    [$i25 + $i28], $i4
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i27, 2, $i27
	b       iter_trace_diffuse_rays.2929
bge_else.35334:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.35333:
	fmul    $f1, $fc2, $f17
	add     $i27, 1, $i28
	load    [$i25 + $i28], $i4
	call    trace_diffuse_ray.2926
	sub     $i27, 2, $i27
	bl      $i27, 0, bge_else.35336
bge_then.35336:
	load    [$i25 + $i27], $i28
	load    [$i28 + 0], $i28
	load    [$i28 + 0], $f1
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i28 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i28 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.35337
ble_then.35337:
	fmul    $f1, $fc1, $f17
	load    [$i25 + $i27], $i4
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i27, 2, $i27
	b       iter_trace_diffuse_rays.2929
ble_else.35337:
	fmul    $f1, $fc2, $f17
	add     $i27, 1, $i28
	load    [$i25 + $i28], $i4
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i27, 2, $i27
	b       iter_trace_diffuse_rays.2929
bge_else.35336:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.35332:
	ret
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i10, $i11)
# $ra = $ra
# [$i1 - $i28]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
	sub     $sp, 11, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i11, [$sp + 1]
.count stack_store
	store   $i10, [$sp + 2]
	load    [$i10 + 5], $i12
	load    [$i12 + $i11], $i12
	load    [$i12 + 0], $fg1
	load    [$i12 + 1], $fg2
	load    [$i12 + 2], $fg3
	load    [$i10 + 7], $i12
	load    [$i10 + 1], $i13
	load    [$i10 + 6], $i10
	load    [$i12 + $i11], $i12
.count stack_store
	store   $i12, [$sp + 3]
	load    [$i13 + $i11], $i2
.count stack_store
	store   $i2, [$sp + 4]
	load    [$i10 + 0], $i10
.count stack_store
	store   $i10, [$sp + 5]
	be      $i10, 0, bne_cont.35338
bne_then.35338:
	load    [ext_dirvecs + 0], $i10
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
	load    [$i12 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i12 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i12 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 6]
	bg      $f0, $f7, ble_else.35339
ble_then.35339:
	load    [$i10 + 118], $i4
	fmul    $f7, $fc1, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 6], $i25
.count stack_load
	load    [$sp + 3], $i26
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35339
ble_else.35339:
	load    [$i10 + 119], $i4
	fmul    $f7, $fc2, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 6], $i25
.count stack_load
	load    [$sp + 3], $i26
	call    iter_trace_diffuse_rays.2929
ble_cont.35339:
bne_cont.35338:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 1, bne_cont.35340
bne_then.35340:
	load    [ext_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f7, ble_else.35341
ble_then.35341:
	load    [$i10 + 118], $i4
	fmul    $f7, $fc1, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 7], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35341
ble_else.35341:
	load    [$i10 + 119], $i4
	fmul    $f7, $fc2, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 7], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35341:
bne_cont.35340:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 2, bne_cont.35342
bne_then.35342:
	load    [ext_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f7, ble_else.35343
ble_then.35343:
	load    [$i10 + 118], $i4
	fmul    $f7, $fc1, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 8], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35343
ble_else.35343:
	load    [$i10 + 119], $i4
	fmul    $f7, $fc2, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 8], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35343:
bne_cont.35342:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 3, bne_cont.35344
bne_then.35344:
	load    [ext_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f7, ble_else.35345
ble_then.35345:
	load    [$i10 + 118], $i4
	fmul    $f7, $fc1, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35345
ble_else.35345:
	load    [$i10 + 119], $i4
	fmul    $f7, $fc2, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35345:
bne_cont.35344:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 4, bne_cont.35346
bne_then.35346:
	load    [ext_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f1
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i25 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i25 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f1, ble_else.35347
ble_then.35347:
	load    [$i10 + 118], $i4
	fmul    $f1, $fc1, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 10], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35347
ble_else.35347:
	load    [$i10 + 119], $i4
	fmul    $f1, $fc2, $f17
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 10], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35347:
bne_cont.35346:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
.count stack_load
	load    [$sp - 9], $i1
	load    [$i1 + 4], $i1
.count stack_load
	load    [$sp - 10], $i2
	load    [$i1 + $i2], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	ret
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i2, $i29)
# $ra = $ra
# [$i1 - $i32]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i29, 4, ble_else.35348
ble_then.35348:
	load    [$i2 + 2], $i30
	load    [$i30 + $i29], $i31
	bl      $i31, 0, bge_else.35349
bge_then.35349:
	load    [$i2 + 3], $i31
	load    [$i31 + $i29], $i32
	bne     $i32, 0, be_else.35350
be_then.35350:
	add     $i29, 1, $i11
	bg      $i11, 4, ble_else.35351
ble_then.35351:
	load    [$i30 + $i11], $i29
	bl      $i29, 0, bge_else.35352
bge_then.35352:
	load    [$i31 + $i11], $i29
	bne     $i29, 0, be_else.35353
be_then.35353:
	add     $i11, 1, $i29
	b       do_without_neighbors.2951
be_else.35353:
.count stack_move
	sub     $sp, 12, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i11, [$sp + 2]
.count move_args
	mov     $i2, $i10
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
.count stack_load
	load    [$sp - 10], $i1
	add     $i1, 1, $i29
.count stack_load
	load    [$sp - 11], $i2
	b       do_without_neighbors.2951
bge_else.35352:
	ret
ble_else.35351:
	ret
be_else.35350:
.count stack_move
	sub     $sp, 12, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i2 + 5], $i10
	load    [$i10 + $i29], $i10
	load    [$i10 + 0], $fg1
	load    [$i10 + 1], $fg2
	load    [$i10 + 2], $fg3
	load    [$i2 + 7], $i10
	load    [$i2 + 1], $i11
	load    [$i2 + 6], $i12
	load    [$i10 + $i29], $i10
.count stack_store
	store   $i10, [$sp + 3]
	load    [$i11 + $i29], $i2
.count stack_store
	store   $i2, [$sp + 4]
	load    [$i12 + 0], $i11
.count stack_store
	store   $i11, [$sp + 5]
	be      $i11, 0, bne_cont.35354
bne_then.35354:
	load    [ext_dirvecs + 0], $i11
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i11 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
	load    [$i10 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i10 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i10 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i11, [$sp + 6]
	bg      $f0, $f7, ble_else.35355
ble_then.35355:
	fmul    $f7, $fc1, $f17
	load    [$i11 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 6], $i25
.count stack_load
	load    [$sp + 3], $i26
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35355
ble_else.35355:
	fmul    $f7, $fc2, $f17
	load    [$i11 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 6], $i25
.count stack_load
	load    [$sp + 3], $i26
	call    iter_trace_diffuse_rays.2929
ble_cont.35355:
bne_cont.35354:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 1, bne_cont.35356
bne_then.35356:
	load    [ext_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f7, ble_else.35357
ble_then.35357:
	fmul    $f7, $fc1, $f17
	load    [$i10 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 7], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35357
ble_else.35357:
	fmul    $f7, $fc2, $f17
	load    [$i10 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 7], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35357:
bne_cont.35356:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 2, bne_cont.35358
bne_then.35358:
	load    [ext_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f7, ble_else.35359
ble_then.35359:
	fmul    $f7, $fc1, $f17
	load    [$i10 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 8], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35359
ble_else.35359:
	fmul    $f7, $fc2, $f17
	load    [$i10 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 8], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35359:
bne_cont.35358:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 3, bne_cont.35360
bne_then.35360:
	load    [ext_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f7
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i25 + 1], $f8
	load    [$i26 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i25 + 2], $f8
	load    [$i26 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f7, ble_else.35361
ble_then.35361:
	fmul    $f7, $fc1, $f17
	load    [$i10 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35361
ble_else.35361:
	fmul    $f7, $fc2, $f17
	load    [$i10 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35361:
bne_cont.35360:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 4, bne_cont.35362
bne_then.35362:
	load    [ext_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f1
.count stack_load
	load    [$sp + 3], $i26
	load    [$i26 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i25 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i25 + 2], $f2
	load    [$i26 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f1, ble_else.35363
ble_then.35363:
	fmul    $f1, $fc1, $f17
	load    [$i10 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 10], $i25
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35363
ble_else.35363:
	fmul    $f1, $fc2, $f17
	load    [$i10 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 10], $i25
	call    iter_trace_diffuse_rays.2929
ble_cont.35363:
bne_cont.35362:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i2 + 4], $i32
	load    [$i32 + $i29], $i32
	load    [$i32 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i32 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i32 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i29, 1, $i11
	bg      $i11, 4, ble_else.35364
ble_then.35364:
	load    [$i30 + $i11], $i29
	bl      $i29, 0, bge_else.35365
bge_then.35365:
	load    [$i31 + $i11], $i29
	bne     $i29, 0, be_else.35366
be_then.35366:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	add     $i11, 1, $i29
	b       do_without_neighbors.2951
be_else.35366:
.count stack_store
	store   $i11, [$sp + 11]
.count move_args
	mov     $i2, $i10
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i29
.count stack_load
	load    [$sp - 11], $i2
	b       do_without_neighbors.2951
bge_else.35365:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	ret
ble_else.35364:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	ret
bge_else.35349:
	ret
ble_else.35348:
	ret
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i33, $i34, $i35, $i36, $i37)
# $ra = $ra
# [$i1 - $i41]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i37, 4, ble_else.35367
ble_then.35367:
	load    [$i35 + $i33], $i38
	load    [$i38 + 2], $i39
	load    [$i39 + $i37], $i39
	bl      $i39, 0, bge_else.35368
bge_then.35368:
	load    [$i34 + $i33], $i40
	load    [$i40 + 2], $i41
	load    [$i41 + $i37], $i41
	bne     $i41, $i39, be_else.35369
be_then.35369:
	load    [$i36 + $i33], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + $i37], $i41
	bne     $i41, $i39, be_else.35370
be_then.35370:
	sub     $i33, 1, $i41
	load    [$i35 + $i41], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + $i37], $i41
	bne     $i41, $i39, be_else.35371
be_then.35371:
	add     $i33, 1, $i41
	load    [$i35 + $i41], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + $i37], $i41
	bne     $i41, $i39, be_else.35372
be_then.35372:
	li      1, $i39
.count b_cont
	b       be_cont.35369
be_else.35372:
	li      0, $i39
.count b_cont
	b       be_cont.35369
be_else.35371:
	li      0, $i39
.count b_cont
	b       be_cont.35369
be_else.35370:
	li      0, $i39
.count b_cont
	b       be_cont.35369
be_else.35369:
	li      0, $i39
be_cont.35369:
	bne     $i39, 0, be_else.35373
be_then.35373:
	bg      $i37, 4, ble_else.35374
ble_then.35374:
	load    [$i35 + $i33], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + $i37], $i33
	bl      $i33, 0, bge_else.35375
bge_then.35375:
	load    [$i2 + 3], $i33
	load    [$i33 + $i37], $i33
	bne     $i33, 0, be_else.35376
be_then.35376:
	add     $i37, 1, $i29
	b       do_without_neighbors.2951
be_else.35376:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count move_args
	mov     $i2, $i10
.count move_args
	mov     $i37, $i11
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	add     $i37, 1, $i29
.count stack_load
	load    [$sp - 1], $i2
	b       do_without_neighbors.2951
bge_else.35375:
	ret
ble_else.35374:
	ret
be_else.35373:
	load    [$i38 + 3], $i1
	load    [$i1 + $i37], $i1
	bne     $i1, 0, be_else.35377
be_then.35377:
	add     $i37, 1, $i37
	b       try_exploit_neighbors.2967
be_else.35377:
	load    [$i40 + 5], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i33, 1, $i1
	load    [$i35 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i35 + $i33], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i33, 1, $i1
	load    [$i35 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i36 + $i33], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i35 + $i33], $i1
	load    [$i1 + 4], $i1
	load    [$i1 + $i37], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i37, 1, $i37
	b       try_exploit_neighbors.2967
bge_else.35368:
	ret
ble_else.35367:
	ret
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays($i2, $i10)
# $ra = $ra
# [$i1 - $i29]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i10, 4, ble_else.35378
ble_then.35378:
	load    [$i2 + 2], $i11
	load    [$i11 + $i10], $i12
	bl      $i12, 0, bge_else.35379
bge_then.35379:
	load    [$i2 + 3], $i12
	load    [$i12 + $i10], $i13
	bne     $i13, 0, be_else.35380
be_then.35380:
	add     $i10, 1, $i10
	bg      $i10, 4, ble_else.35381
ble_then.35381:
	load    [$i11 + $i10], $i11
	bl      $i11, 0, bge_else.35382
bge_then.35382:
	load    [$i12 + $i10], $i11
	bne     $i11, 0, be_else.35383
be_then.35383:
	add     $i10, 1, $i10
	b       pretrace_diffuse_rays.2980
be_else.35383:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i10, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 6], $i11
	load    [$i2 + 7], $i12
	load    [$i2 + 1], $i13
	load    [$i13 + $i10], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i11 + 0], $i25
	load    [ext_dirvecs + $i25], $i25
	load    [$i25 + 118], $i26
	load    [$i26 + 0], $i26
	load    [$i12 + $i10], $i27
	load    [$i26 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i26 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i26 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.35384
ble_then.35384:
	fmul    $f1, $fc1, $f17
	load    [$i25 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i29
.count move_args
	mov     $i27, $i26
.count move_args
	mov     $i29, $i27
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35384
ble_else.35384:
	fmul    $f1, $fc2, $f17
	load    [$i25 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i29
.count move_args
	mov     $i27, $i26
.count move_args
	mov     $i29, $i27
	call    iter_trace_diffuse_rays.2929
ble_cont.35384:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 8], $i2
	load    [$i2 + 5], $i1
.count stack_load
	load    [$sp - 9], $i3
	load    [$i1 + $i3], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i3, 1, $i10
	b       pretrace_diffuse_rays.2980
bge_else.35382:
	ret
ble_else.35381:
	ret
be_else.35380:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i12, [$sp + 3]
.count stack_store
	store   $i11, [$sp + 4]
.count stack_store
	store   $i10, [$sp + 5]
.count stack_store
	store   $i2, [$sp + 2]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 6], $i11
	load    [$i2 + 7], $i12
.count stack_store
	store   $i12, [$sp + 6]
	load    [$i2 + 1], $i13
.count stack_store
	store   $i13, [$sp + 7]
	load    [$i13 + $i10], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i11 + 0], $i25
	load    [ext_dirvecs + $i25], $i25
	load    [$i25 + 118], $i26
	load    [$i26 + 0], $i26
	load    [$i26 + 0], $f7
	load    [$i12 + $i10], $i27
	load    [$i27 + 0], $f8
	fmul    $f7, $f8, $f7
	load    [$i26 + 1], $f8
	load    [$i27 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i26 + 2], $f8
	load    [$i27 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	bg      $f0, $f7, ble_else.35385
ble_then.35385:
	load    [$i25 + 118], $i4
	fmul    $f7, $fc1, $f17
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.35385
ble_else.35385:
	load    [$i25 + 119], $i4
	fmul    $f7, $fc2, $f17
	call    trace_diffuse_ray.2926
ble_cont.35385:
	li      116, $i29
.count move_args
	mov     $i27, $i26
.count move_args
	mov     $i29, $i27
	call    iter_trace_diffuse_rays.2929
.count stack_load
	load    [$sp + 2], $i2
	load    [$i2 + 5], $i10
.count stack_load
	load    [$sp + 5], $i11
	load    [$i10 + $i11], $i12
	store   $fg1, [$i12 + 0]
	store   $fg2, [$i12 + 1]
	store   $fg3, [$i12 + 2]
	add     $i11, 1, $i11
	bg      $i11, 4, ble_else.35386
ble_then.35386:
.count stack_load
	load    [$sp + 4], $i12
	load    [$i12 + $i11], $i12
	bl      $i12, 0, bge_else.35387
bge_then.35387:
.count stack_load
	load    [$sp + 3], $i12
	load    [$i12 + $i11], $i12
	bne     $i12, 0, be_else.35388
be_then.35388:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i11, 1, $i10
	b       pretrace_diffuse_rays.2980
be_else.35388:
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 6], $i10
.count stack_load
	load    [$sp + 7], $i12
	load    [$i12 + $i11], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i25
	load    [ext_dirvecs + $i25], $i25
	load    [$i25 + 118], $i26
	load    [$i26 + 0], $i26
.count stack_load
	load    [$sp + 6], $i27
	load    [$i27 + $i11], $i27
	load    [$i26 + 0], $f1
	load    [$i27 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i26 + 1], $f2
	load    [$i27 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i26 + 2], $f2
	load    [$i27 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.35389
ble_then.35389:
	fmul    $f1, $fc1, $f17
	load    [$i25 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i29
.count move_args
	mov     $i27, $i26
.count move_args
	mov     $i29, $i27
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35389
ble_else.35389:
	fmul    $f1, $fc2, $f17
	load    [$i25 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i29
.count move_args
	mov     $i27, $i26
.count move_args
	mov     $i29, $i27
	call    iter_trace_diffuse_rays.2929
ble_cont.35389:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $i1
.count stack_load
	load    [$sp - 1], $i2
	load    [$i2 + $i1], $i2
	store   $fg1, [$i2 + 0]
	store   $fg2, [$i2 + 1]
	store   $fg3, [$i2 + 2]
	add     $i1, 1, $i10
.count stack_load
	load    [$sp - 8], $i2
	b       pretrace_diffuse_rays.2980
bge_else.35387:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.35386:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.35379:
	ret
ble_else.35378:
	ret
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i1, $i5, $i6, $f4, $f5, $f6)
# $ra = $ra
# [$i1 - $i33]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i5, 0, bge_else.35390
bge_then.35390:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f6, [$sp + 1]
.count stack_store
	store   $f5, [$sp + 2]
.count stack_store
	store   $f4, [$sp + 3]
.count stack_store
	store   $i6, [$sp + 4]
.count stack_store
	store   $i5, [$sp + 5]
.count stack_store
	store   $i1, [$sp + 6]
	load    [ext_screenx_dir + 0], $f7
	sub     $i5, 64, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f8
	fmul    $fg17, $f8, $f8
	fmul    $f8, $f7, $f7
	fadd    $f7, $f4, $f7
	store   $f7, [ext_ptrace_dirvec + 0]
	store   $f5, [ext_ptrace_dirvec + 1]
	load    [ext_screenx_dir + 2], $f7
	fmul    $f8, $f7, $f7
	fadd    $f7, $f6, $f7
	store   $f7, [ext_ptrace_dirvec + 2]
	load    [ext_ptrace_dirvec + 0], $f7
	fmul    $f7, $f7, $f8
	load    [ext_ptrace_dirvec + 1], $f9
	fmul    $f9, $f9, $f9
	fadd    $f8, $f9, $f8
	load    [ext_ptrace_dirvec + 2], $f9
	fmul    $f9, $f9, $f9
	fadd    $f8, $f9, $f8
	fsqrt   $f8, $f8
	bne     $f8, $f0, be_else.35391
be_then.35391:
	mov     $fc0, $f8
.count b_cont
	b       be_cont.35391
be_else.35391:
	finv    $f8, $f8
be_cont.35391:
	fmul    $f7, $f8, $f7
	store   $f7, [ext_ptrace_dirvec + 0]
	load    [ext_ptrace_dirvec + 1], $f7
	fmul    $f7, $f8, $f7
	store   $f7, [ext_ptrace_dirvec + 1]
	load    [ext_ptrace_dirvec + 2], $f7
	fmul    $f7, $f8, $f7
	store   $f7, [ext_ptrace_dirvec + 2]
	mov     $f0, $fg4
	mov     $f0, $fg5
	mov     $f0, $fg6
	load    [ext_viewpoint + 0], $fg21
	load    [ext_viewpoint + 1], $fg22
	load    [ext_viewpoint + 2], $fg23
	li      ext_ptrace_dirvec, $i4
	li      0, $i21
	load    [$i1 + $i5], $i22
.count move_args
	mov     $fc0, $f14
.count move_args
	mov     $f0, $f15
	call    trace_ray.2920
.count stack_load
	load    [$sp + 5], $i30
.count stack_load
	load    [$sp + 6], $i31
	load    [$i31 + $i30], $i32
	load    [$i32 + 0], $i32
	store   $fg4, [$i32 + 0]
	store   $fg5, [$i32 + 1]
	store   $fg6, [$i32 + 2]
	load    [$i31 + $i30], $i32
	load    [$i32 + 6], $i32
.count stack_load
	load    [$sp + 4], $i33
	store   $i33, [$i32 + 0]
	load    [$i31 + $i30], $i2
	load    [$i2 + 2], $i32
	load    [$i32 + 0], $i32
	bl      $i32, 0, bge_cont.35392
bge_then.35392:
	load    [$i2 + 3], $i32
	load    [$i32 + 0], $i32
	bne     $i32, 0, be_else.35393
be_then.35393:
	li      1, $i10
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.35393
be_else.35393:
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 6], $i10
	load    [$i10 + 0], $i10
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i12
	load    [ext_dirvecs + $i10], $i10
	load    [$i11 + 0], $i11
	load    [$i12 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f1
	load    [$i11 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i25 + 1], $f2
	load    [$i11 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i25 + 2], $f2
	load    [$i11 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f1, ble_else.35394
ble_then.35394:
	fmul    $f1, $fc1, $f17
	load    [$i10 + 118], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
.count stack_load
	load    [$sp + 8], $i26
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.35394
ble_else.35394:
	fmul    $f1, $fc2, $f17
	load    [$i10 + 119], $i4
	call    trace_diffuse_ray.2926
	li      116, $i27
.count stack_load
	load    [$sp + 9], $i25
.count stack_load
	load    [$sp + 8], $i26
	call    iter_trace_diffuse_rays.2929
ble_cont.35394:
.count stack_load
	load    [$sp + 7], $i2
	load    [$i2 + 5], $i32
	load    [$i32 + 0], $i32
	store   $fg1, [$i32 + 0]
	store   $fg2, [$i32 + 1]
	store   $fg3, [$i32 + 2]
	li      1, $i10
	call    pretrace_diffuse_rays.2980
be_cont.35393:
bge_cont.35392:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	sub     $i30, 1, $i5
	add     $i33, 1, $i6
.count move_args
	mov     $i31, $i1
.count stack_load
	load    [$sp - 9], $f6
.count stack_load
	load    [$sp - 8], $f5
.count stack_load
	load    [$sp - 7], $f4
	bl      $i6, 5, pretrace_pixels.2983
	sub     $i6, 5, $i6
	b       pretrace_pixels.2983
bge_else.35390:
	ret
.end pretrace_pixels

######################################################################
# scan_pixel($i33, $i34, $i35, $i36, $i37)
# $ra = $ra
# [$i1 - $i42]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i38
	bg      $i38, $i33, ble_else.35396
ble_then.35396:
	ret
ble_else.35396:
.count stack_move
	sub     $sp, 11, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i37, [$sp + 1]
.count stack_store
	store   $i35, [$sp + 2]
.count stack_store
	store   $i34, [$sp + 3]
.count stack_store
	store   $i36, [$sp + 4]
.count stack_store
	store   $i33, [$sp + 5]
	load    [$i36 + $i33], $i38
	load    [$i38 + 0], $i38
	load    [$i38 + 0], $fg4
	load    [$i38 + 1], $fg5
	load    [$i38 + 2], $fg6
	li      128, $i38
	add     $i34, 1, $i39
.count stack_store
	store   $i39, [$sp + 6]
	bg      $i38, $i39, ble_else.35397
ble_then.35397:
	li      0, $i34
.count b_cont
	b       ble_cont.35397
ble_else.35397:
	bg      $i34, 0, ble_else.35398
ble_then.35398:
	li      0, $i34
.count b_cont
	b       ble_cont.35398
ble_else.35398:
	li      128, $i34
	add     $i33, 1, $i38
	bg      $i34, $i38, ble_else.35399
ble_then.35399:
	li      0, $i34
.count b_cont
	b       ble_cont.35399
ble_else.35399:
	bg      $i33, 0, ble_else.35400
ble_then.35400:
	li      0, $i34
.count b_cont
	b       ble_cont.35400
ble_else.35400:
	li      1, $i34
ble_cont.35400:
ble_cont.35399:
ble_cont.35398:
ble_cont.35397:
	bne     $i34, 0, be_else.35401
be_then.35401:
	load    [$i36 + $i33], $i2
	li      0, $i33
	load    [$i2 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, be_cont.35401
bge_then.35402:
	load    [$i2 + 3], $i34
	load    [$i34 + 0], $i34
	bne     $i34, 0, be_else.35403
be_then.35403:
	li      1, $i29
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35401
be_else.35403:
.count stack_store
	store   $i2, [$sp + 7]
.count move_args
	mov     $i2, $i10
.count move_args
	mov     $i33, $i11
	call    calc_diffuse_using_1point.2942
	li      1, $i29
.count stack_load
	load    [$sp + 7], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35401
be_else.35401:
	li      0, $i34
	load    [$i36 + $i33], $i38
	load    [$i38 + 2], $i39
	load    [$i39 + 0], $i39
	bl      $i39, 0, bge_cont.35404
bge_then.35404:
	load    [$i35 + $i33], $i40
	load    [$i40 + 2], $i41
	load    [$i41 + 0], $i41
	bne     $i41, $i39, be_else.35405
be_then.35405:
	load    [$i37 + $i33], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + 0], $i41
	bne     $i41, $i39, be_else.35406
be_then.35406:
	sub     $i33, 1, $i41
	load    [$i36 + $i41], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + 0], $i41
	bne     $i41, $i39, be_else.35407
be_then.35407:
	add     $i33, 1, $i41
	load    [$i36 + $i41], $i41
	load    [$i41 + 2], $i41
	load    [$i41 + 0], $i41
	bne     $i41, $i39, be_else.35408
be_then.35408:
	li      1, $i39
.count b_cont
	b       be_cont.35405
be_else.35408:
	li      0, $i39
.count b_cont
	b       be_cont.35405
be_else.35407:
	li      0, $i39
.count b_cont
	b       be_cont.35405
be_else.35406:
	li      0, $i39
.count b_cont
	b       be_cont.35405
be_else.35405:
	li      0, $i39
be_cont.35405:
	bne     $i39, 0, be_else.35409
be_then.35409:
	load    [$i36 + $i33], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.35409
bge_then.35410:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.35411
be_then.35411:
	li      1, $i29
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35409
be_else.35411:
.count stack_store
	store   $i2, [$sp + 8]
.count move_args
	mov     $i2, $i10
.count move_args
	mov     $i34, $i11
	call    calc_diffuse_using_1point.2942
	li      1, $i29
.count stack_load
	load    [$sp + 8], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35409
be_else.35409:
	load    [$i38 + 3], $i42
	load    [$i42 + 0], $i42
.count move_args
	mov     $i35, $i34
.count move_args
	mov     $i36, $i35
	bne     $i42, 0, be_else.35412
be_then.35412:
	li      1, $i42
.count move_args
	mov     $i37, $i36
.count move_args
	mov     $i42, $i37
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.35412
be_else.35412:
	load    [$i40 + 5], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $fg1
	load    [$i42 + 1], $fg2
	load    [$i42 + 2], $fg3
	sub     $i33, 1, $i42
	load    [$i36 + $i42], $i42
	load    [$i42 + 5], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i42 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i42 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i36 + $i33], $i42
	load    [$i42 + 5], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i42 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i42 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i33, 1, $i42
	load    [$i36 + $i42], $i42
	load    [$i42 + 5], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i42 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i42 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i37 + $i33], $i42
	load    [$i42 + 5], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i42 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i42 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i36 + $i33], $i42
	load    [$i42 + 4], $i42
	load    [$i42 + 0], $i42
	load    [$i42 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i42 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i42 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	li      1, $i42
.count move_args
	mov     $i37, $i36
.count move_args
	mov     $i42, $i37
	call    try_exploit_neighbors.2967
be_cont.35412:
be_cont.35409:
bge_cont.35404:
be_cont.35401:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
.count move_ret
	mov     $i1, $i2
	bg      $i2, $i4, ble_else.35413
ble_then.35413:
	bl      $i2, 0, bge_else.35414
bge_then.35414:
	call    ext_write
.count b_cont
	b       ble_cont.35413
bge_else.35414:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.35413
ble_else.35413:
	li      255, $i2
	call    ext_write
ble_cont.35413:
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
.count move_ret
	mov     $i1, $i2
	bg      $i2, $i4, ble_else.35415
ble_then.35415:
	bl      $i2, 0, bge_else.35416
bge_then.35416:
	call    ext_write
.count b_cont
	b       ble_cont.35415
bge_else.35416:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.35415
ble_else.35415:
	li      255, $i2
	call    ext_write
ble_cont.35415:
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
.count move_ret
	mov     $i1, $i2
	bg      $i2, $i4, ble_else.35417
ble_then.35417:
	bl      $i2, 0, bge_else.35418
bge_then.35418:
	call    ext_write
.count b_cont
	b       ble_cont.35417
bge_else.35418:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.35417
ble_else.35417:
	li      255, $i2
	call    ext_write
ble_cont.35417:
	li      128, $i33
.count stack_load
	load    [$sp + 5], $i34
	add     $i34, 1, $i34
	bg      $i33, $i34, ble_else.35419
ble_then.35419:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	ret
ble_else.35419:
.count stack_store
	store   $i34, [$sp + 9]
.count stack_load
	load    [$sp + 4], $i33
	load    [$i33 + $i34], $i35
	load    [$i35 + 0], $i35
	load    [$i35 + 0], $fg4
	load    [$i35 + 1], $fg5
	load    [$i35 + 2], $fg6
	li      128, $i35
.count stack_load
	load    [$sp + 6], $i36
	bg      $i35, $i36, ble_else.35420
ble_then.35420:
	li      0, $i35
.count b_cont
	b       ble_cont.35420
ble_else.35420:
.count stack_load
	load    [$sp + 3], $i35
	bg      $i35, 0, ble_else.35421
ble_then.35421:
	li      0, $i35
.count b_cont
	b       ble_cont.35421
ble_else.35421:
	li      128, $i35
	add     $i34, 1, $i36
	bg      $i35, $i36, ble_else.35422
ble_then.35422:
	li      0, $i35
.count b_cont
	b       ble_cont.35422
ble_else.35422:
	bg      $i34, 0, ble_else.35423
ble_then.35423:
	li      0, $i35
.count b_cont
	b       ble_cont.35423
ble_else.35423:
	li      1, $i35
ble_cont.35423:
ble_cont.35422:
ble_cont.35421:
ble_cont.35420:
	bne     $i35, 0, be_else.35424
be_then.35424:
	load    [$i33 + $i34], $i2
	li      0, $i33
	load    [$i2 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, be_cont.35424
bge_then.35425:
	load    [$i2 + 3], $i34
	load    [$i34 + 0], $i34
	bne     $i34, 0, be_else.35426
be_then.35426:
	li      1, $i29
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35424
be_else.35426:
.count stack_store
	store   $i2, [$sp + 10]
.count move_args
	mov     $i2, $i10
.count move_args
	mov     $i33, $i11
	call    calc_diffuse_using_1point.2942
	li      1, $i29
.count stack_load
	load    [$sp + 10], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35424
be_else.35424:
	li      0, $i37
.count stack_load
	load    [$sp + 2], $i42
.count stack_load
	load    [$sp + 1], $i36
.count move_args
	mov     $i33, $i35
.count move_args
	mov     $i34, $i33
.count move_args
	mov     $i42, $i34
	call    try_exploit_neighbors.2967
be_cont.35424:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35427
ble_then.35427:
	bge     $i1, 0, ble_cont.35427
bl_then.35428:
	li      0, $i1
.count b_cont
	b       ble_cont.35427
ble_else.35427:
	li      255, $i1
ble_cont.35427:
	mov     $i1, $i2
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35429
ble_then.35429:
	bge     $i1, 0, ble_cont.35429
bl_then.35430:
	li      0, $i1
.count b_cont
	b       ble_cont.35429
ble_else.35429:
	li      255, $i1
ble_cont.35429:
	mov     $i1, $i2
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35431
ble_then.35431:
	bge     $i1, 0, ble_cont.35431
bl_then.35432:
	li      0, $i1
.count b_cont
	b       ble_cont.35431
ble_else.35431:
	li      255, $i1
ble_cont.35431:
	mov     $i1, $i2
	call    ext_write
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i33
.count stack_load
	load    [$sp - 8], $i34
.count stack_load
	load    [$sp - 9], $i35
.count stack_load
	load    [$sp - 7], $i36
.count stack_load
	load    [$sp - 10], $i37
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i1, $i5, $i6, $i7, $i8)
# $ra = $ra
# [$i1 - $i42]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i9
	bg      $i9, $i1, ble_else.35433
ble_then.35433:
	ret
ble_else.35433:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i8, [$sp + 1]
.count stack_store
	store   $i7, [$sp + 2]
.count stack_store
	store   $i5, [$sp + 3]
.count stack_store
	store   $i1, [$sp + 4]
.count stack_store
	store   $i6, [$sp + 5]
	bge     $i1, 127, bl_cont.35434
bl_then.35434:
	add     $i1, 1, $i1
	sub     $i1, 64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f4
	fadd    $f4, $fg18, $f4
	load    [ext_screeny_dir + 1], $f5
	fmul    $f1, $f5, $f5
	fadd    $f5, $fg19, $f5
	load    [ext_screeny_dir + 2], $f6
	fmul    $f1, $f6, $f1
	fadd    $f1, $fg20, $f6
	li      127, $i5
.count move_args
	mov     $i7, $i1
.count move_args
	mov     $i8, $i6
	call    pretrace_pixels.2983
bl_cont.35434:
	li      0, $i33
.count stack_load
	load    [$sp + 5], $i34
	load    [$i34 + 0], $i35
	load    [$i35 + 0], $i35
	load    [$i35 + 0], $fg4
	load    [$i35 + 1], $fg5
	load    [$i35 + 2], $fg6
	li      128, $i35
.count stack_load
	load    [$sp + 4], $i36
	add     $i36, 1, $i37
.count stack_store
	store   $i37, [$sp + 6]
	bg      $i35, $i37, ble_else.35435
ble_then.35435:
	li      0, $i35
.count b_cont
	b       ble_cont.35435
ble_else.35435:
	li      0, $i35
ble_cont.35435:
	bne     $i35, 0, be_else.35436
be_then.35436:
	load    [$i34 + 0], $i2
	li      0, $i33
	load    [$i2 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, be_cont.35436
bge_then.35437:
	load    [$i2 + 3], $i34
	load    [$i34 + 0], $i34
	bne     $i34, 0, be_else.35438
be_then.35438:
	li      1, $i29
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35436
be_else.35438:
.count stack_store
	store   $i2, [$sp + 7]
.count move_args
	mov     $i2, $i10
.count move_args
	mov     $i33, $i11
	call    calc_diffuse_using_1point.2942
	li      1, $i29
.count stack_load
	load    [$sp + 7], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.35436
be_else.35436:
	li      0, $i37
.count stack_load
	load    [$sp + 3], $i42
.count stack_load
	load    [$sp + 2], $i36
.count move_args
	mov     $i34, $i35
.count move_args
	mov     $i42, $i34
	call    try_exploit_neighbors.2967
be_cont.35436:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35439
ble_then.35439:
	bge     $i1, 0, ble_cont.35439
bl_then.35440:
	li      0, $i1
.count b_cont
	b       ble_cont.35439
ble_else.35439:
	li      255, $i1
ble_cont.35439:
	mov     $i1, $i2
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35441
ble_then.35441:
	bge     $i1, 0, ble_cont.35441
bl_then.35442:
	li      0, $i1
.count b_cont
	b       ble_cont.35441
ble_else.35441:
	li      255, $i1
ble_cont.35441:
	mov     $i1, $i2
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.35443
ble_then.35443:
	bge     $i1, 0, ble_cont.35443
bl_then.35444:
	li      0, $i1
.count b_cont
	b       ble_cont.35443
ble_else.35443:
	li      255, $i1
ble_cont.35443:
	mov     $i1, $i2
	call    ext_write
	li      1, $i33
.count stack_load
	load    [$sp + 4], $i34
.count stack_load
	load    [$sp + 3], $i35
.count stack_load
	load    [$sp + 5], $i36
.count stack_load
	load    [$sp + 2], $i37
	call    scan_pixel.2994
	li      128, $i1
.count stack_load
	load    [$sp + 6], $i5
	bg      $i1, $i5, ble_else.35445
ble_then.35445:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
ble_else.35445:
.count stack_load
	load    [$sp + 1], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.35446
bge_then.35446:
	sub     $i1, 5, $i1
bge_cont.35446:
.count stack_store
	store   $i1, [$sp + 8]
	bge     $i5, 127, bl_cont.35447
bl_then.35447:
	add     $i5, 1, $i5
	li      127, $i6
	sub     $i5, 64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f4
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg19, $f5
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg20, $f6
.count stack_load
	load    [$sp + 3], $i34
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i1, $i6
.count move_args
	mov     $i34, $i1
	call    pretrace_pixels.2983
bl_cont.35447:
	li      0, $i33
.count stack_load
	load    [$sp + 6], $i34
.count stack_load
	load    [$sp + 5], $i35
.count stack_load
	load    [$sp + 2], $i36
.count stack_load
	load    [$sp + 3], $i37
	call    scan_pixel.2994
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i1
.count stack_load
	load    [$sp - 1], $i2
	add     $i2, 2, $i8
.count stack_load
	load    [$sp - 4], $i7
.count stack_load
	load    [$sp - 6], $i6
.count stack_load
	load    [$sp - 7], $i5
	bl      $i8, 5, scan_line.3000
	sub     $i8, 5, $i8
	b       scan_line.3000
.end scan_line

######################################################################
# $i1 = create_pixel()
# $ra = $ra
# [$i1 - $i12]
# [$f2]
# []
# []
######################################################################
.begin create_pixel
create_pixel.3008:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	store   $i1, [$i11 + 4]
	mov     $hp, $i1
	add     $hp, 8, $hp
	store   $i11, [$i1 + 7]
	store   $i10, [$i1 + 6]
	store   $i9, [$i1 + 5]
	store   $i8, [$i1 + 4]
	store   $i7, [$i1 + 3]
	store   $i6, [$i1 + 2]
	store   $i5, [$i1 + 1]
	store   $i4, [$i1 + 0]
	ret
.end create_pixel

######################################################################
# $i1 = init_line_elements($i4, $i5)
# $ra = $ra
# [$i1 - $i14]
# [$f2]
# []
# []
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i5, 0, bge_else.35449
bge_then.35449:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 4]
	mov     $hp, $i14
	add     $hp, 8, $hp
	store   $i13, [$i14 + 7]
	store   $i12, [$i14 + 6]
	store   $i11, [$i14 + 5]
	store   $i10, [$i14 + 4]
	store   $i9, [$i14 + 3]
	store   $i8, [$i14 + 2]
	store   $i7, [$i14 + 1]
	store   $i6, [$i14 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i14, [$tmp + 0]
	sub     $i5, 1, $i13
	bl      $i13, 0, bge_else.35450
bge_then.35450:
.count stack_store
	store   $i4, [$sp + 1]
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 1], $i5
.count storer
	add     $i5, $i13, $tmp
	store   $i4, [$tmp + 0]
	sub     $i13, 1, $i4
	bl      $i4, 0, bge_else.35451
bge_then.35451:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i8
	store   $i8, [$i7 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i11
	store   $i11, [$i10 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i14
	store   $i14, [$i13 + 4]
	mov     $hp, $i14
	add     $hp, 8, $hp
	store   $i13, [$i14 + 7]
	store   $i12, [$i14 + 6]
	store   $i11, [$i14 + 5]
	store   $i10, [$i14 + 4]
	store   $i9, [$i14 + 3]
	store   $i8, [$i14 + 2]
	store   $i7, [$i14 + 1]
	store   $i6, [$i14 + 0]
.count storer
	add     $i5, $i4, $tmp
	store   $i14, [$tmp + 0]
	sub     $i4, 1, $i13
	bl      $i13, 0, bge_else.35452
bge_then.35452:
	call    create_pixel.3008
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $i4
.count storer
	add     $i4, $i13, $tmp
	store   $i1, [$tmp + 0]
	sub     $i13, 1, $i5
	b       init_line_elements.3010
bge_else.35452:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	mov     $i5, $i1
	ret
bge_else.35451:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	mov     $i5, $i1
	ret
bge_else.35450:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	mov     $i4, $i1
	ret
bge_else.35449:
	mov     $i4, $i1
	ret
.end init_line_elements

######################################################################
# calc_dirvec($i1, $f6, $f7, $f8, $f9, $i3, $i4)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f10]
# []
# []
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i1, 5, bge_else.35453
bge_then.35453:
	load    [ext_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f6, $f6, $f1
	fmul    $f7, $f7, $f2
	fadd    $f1, $f2, $f1
	fadd    $f1, $fc0, $f1
	fsqrt   $f1, $f1
	finv    $f1, $f1
	fmul    $f6, $f1, $f2
	store   $f2, [$i2 + 0]
	fmul    $f7, $f1, $f3
	store   $f3, [$i2 + 1]
	store   $f1, [$i2 + 2]
	add     $i4, 40, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f2, [$i2 + 0]
	store   $f1, [$i2 + 1]
	fneg    $f3, $f4
	store   $f4, [$i2 + 2]
	add     $i4, 80, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f1, [$i2 + 0]
	fneg    $f2, $f5
	store   $f5, [$i2 + 1]
	store   $f4, [$i2 + 2]
	add     $i4, 1, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f5, [$i2 + 0]
	store   $f4, [$i2 + 1]
	fneg    $f1, $f1
	store   $f1, [$i2 + 2]
	add     $i4, 41, $i2
	load    [$i1 + $i2], $i2
	load    [$i2 + 0], $i2
	store   $f5, [$i2 + 0]
	store   $f1, [$i2 + 1]
	store   $f3, [$i2 + 2]
	add     $i4, 81, $i2
	load    [$i1 + $i2], $i1
	load    [$i1 + 0], $i1
	store   $f1, [$i1 + 0]
	store   $f2, [$i1 + 1]
	store   $f3, [$i1 + 2]
	ret
bge_else.35453:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f8, [$sp + 1]
	fmul    $f7, $f7, $f6
	fadd    $f6, $fc8, $f6
	fsqrt   $f6, $f6
.count stack_store
	store   $f6, [$sp + 2]
	finv    $f6, $f2
	call    ext_atan
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $f8, $f2
.count stack_store
	store   $f2, [$sp + 3]
	call    ext_sin
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 3], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f6
	finv    $f6, $f6
	fmul    $f10, $f6, $f6
.count stack_load
	load    [$sp + 2], $f7
	fmul    $f6, $f7, $f6
.count stack_store
	store   $f6, [$sp + 4]
	fmul    $f6, $f6, $f6
	fadd    $f6, $fc8, $f6
	fsqrt   $f6, $f6
.count stack_store
	store   $f6, [$sp + 5]
	finv    $f6, $f2
	call    ext_atan
.count move_ret
	mov     $f1, $f8
	fmul    $f8, $f9, $f2
.count stack_store
	store   $f2, [$sp + 6]
	call    ext_sin
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 6], $f2
	call    ext_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	finv    $f1, $f1
	fmul    $f10, $f1, $f1
.count stack_load
	load    [$sp - 2], $f2
	fmul    $f1, $f2, $f7
	add     $i1, 1, $i1
.count stack_load
	load    [$sp - 3], $f6
.count stack_load
	load    [$sp - 6], $f8
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs($i2, $f4, $i1, $i5)
# $ra = $ra
# [$i1 - $i6]
# [$f1 - $f11]
# []
# []
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i2, 0, bge_else.35454
bge_then.35454:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i1, [$sp + 1]
.count stack_store
	store   $f4, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	li      0, $i6
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $f4, $f9
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i6, $i1
	call    calc_dirvec.3020
	li      0, $i1
	add     $i5, 2, $i4
.count stack_store
	store   $i4, [$sp + 4]
	fadd    $f11, $fc8, $f8
.count stack_load
	load    [$sp + 2], $f9
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 3], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.35455
bge_then.35455:
.count stack_store
	store   $i2, [$sp + 5]
	li      0, $i1
.count stack_load
	load    [$sp + 1], $i6
	add     $i6, 1, $i6
	bl      $i6, 5, bge_cont.35456
bge_then.35456:
	sub     $i6, 5, $i6
bge_cont.35456:
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count stack_load
	load    [$sp + 2], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f11, $fc8, $f8
.count stack_load
	load    [$sp + 2], $f9
.count stack_load
	load    [$sp + 4], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 5], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.35457
bge_then.35457:
.count stack_store
	store   $i2, [$sp + 6]
	li      0, $i1
	add     $i6, 1, $i6
	bl      $i6, 5, bge_cont.35458
bge_then.35458:
	sub     $i6, 5, $i6
bge_cont.35458:
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count stack_load
	load    [$sp + 2], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f11, $fc8, $f8
.count stack_load
	load    [$sp + 2], $f9
.count stack_load
	load    [$sp + 4], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 6], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.35459
bge_then.35459:
.count stack_store
	store   $i2, [$sp + 7]
	li      0, $i1
	add     $i6, 1, $i6
	bl      $i6, 5, bge_cont.35460
bge_then.35460:
	sub     $i6, 5, $i6
bge_cont.35460:
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count stack_load
	load    [$sp + 2], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f11, $fc8, $f8
.count stack_load
	load    [$sp + 2], $f9
.count stack_load
	load    [$sp + 4], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i6, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i2
	add     $i6, 1, $i1
.count stack_load
	load    [$sp - 6], $f4
	bl      $i1, 5, calc_dirvecs.3028
	sub     $i1, 5, $i1
	b       calc_dirvecs.3028
bge_else.35459:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.35457:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.35455:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.35454:
	ret
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i1, $i5, $i6)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f11]
# []
# []
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i1, 0, bge_else.35462
bge_then.35462:
.count stack_move
	sub     $sp, 17, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
.count stack_store
	store   $i5, [$sp + 2]
.count stack_store
	store   $i1, [$sp + 3]
	li      0, $i7
	li      4, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f4
	fmul    $f4, $fc12, $f4
.count stack_store
	store   $f4, [$sp + 4]
	fsub    $f4, $fc11, $f4
.count stack_store
	store   $f4, [$sp + 5]
.count move_args
	mov     $i1, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f9
.count stack_store
	store   $f9, [$sp + 6]
.count move_args
	mov     $i7, $i1
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $f4, $f8
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i6, 2, $i4
.count stack_store
	store   $i4, [$sp + 7]
.count stack_load
	load    [$sp + 4], $f11
	fadd    $f11, $fc8, $f8
.count stack_store
	store   $f8, [$sp + 8]
.count stack_load
	load    [$sp + 6], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i3
	call    calc_dirvec.3020
	li      0, $i1
	add     $i5, 1, $i5
	bl      $i5, 5, bge_cont.35463
bge_then.35463:
	sub     $i5, 5, $i5
bge_cont.35463:
	li      3, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count stack_store
	store   $f8, [$sp + 9]
.count stack_load
	load    [$sp + 6], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f11, $fc8, $f8
.count stack_store
	store   $f8, [$sp + 10]
.count stack_load
	load    [$sp + 6], $f9
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i3
	call    calc_dirvec.3020
	li      0, $i1
	add     $i5, 1, $i5
	bl      $i5, 5, bge_cont.35464
bge_then.35464:
	sub     $i5, 5, $i5
bge_cont.35464:
	li      2, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f8
.count stack_load
	load    [$sp + 6], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i3
.count move_args
	mov     $i6, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f11, $fc8, $f8
.count stack_load
	load    [$sp + 6], $f9
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i3
	call    calc_dirvec.3020
	li      1, $i2
	add     $i5, 1, $i7
	bl      $i7, 5, bge_cont.35465
bge_then.35465:
	sub     $i7, 5, $i7
bge_cont.35465:
	mov     $i7, $i1
.count stack_load
	load    [$sp + 6], $f4
.count move_args
	mov     $i6, $i5
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 3], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.35466
bge_then.35466:
.count stack_store
	store   $i2, [$sp + 11]
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.35467
bge_then.35467:
	sub     $i1, 5, $i1
bge_cont.35467:
.count stack_store
	store   $i1, [$sp + 12]
.count stack_load
	load    [$sp + 1], $i5
	add     $i5, 4, $i5
.count stack_store
	store   $i5, [$sp + 13]
	li      0, $i6
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $f11, $fc12, $f11
	fsub    $f11, $fc11, $f9
.count stack_store
	store   $f9, [$sp + 14]
.count stack_load
	load    [$sp + 5], $f8
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i6, $i1
	call    calc_dirvec.3020
	li      0, $i1
	add     $i5, 2, $i4
.count stack_store
	store   $i4, [$sp + 15]
.count stack_load
	load    [$sp + 8], $f8
.count stack_load
	load    [$sp + 14], $f9
.count stack_load
	load    [$sp + 12], $i3
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
	call    calc_dirvec.3020
	li      0, $i1
.count stack_load
	load    [$sp + 12], $i6
	add     $i6, 1, $i6
	bl      $i6, 5, bge_cont.35468
bge_then.35468:
	sub     $i6, 5, $i6
bge_cont.35468:
	mov     $i6, $i3
.count stack_store
	store   $i3, [$sp + 16]
.count stack_load
	load    [$sp + 9], $f8
.count stack_load
	load    [$sp + 14], $f9
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
.count stack_load
	load    [$sp + 10], $f8
.count stack_load
	load    [$sp + 14], $f9
.count stack_load
	load    [$sp + 16], $i3
.count stack_load
	load    [$sp + 15], $i4
.count move_args
	mov     $f0, $f6
.count move_args
	mov     $f0, $f7
	call    calc_dirvec.3020
	li      2, $i2
.count stack_load
	load    [$sp + 16], $i7
	add     $i7, 1, $i7
	bl      $i7, 5, bge_cont.35469
bge_then.35469:
	sub     $i7, 5, $i7
bge_cont.35469:
	mov     $i7, $i1
.count stack_load
	load    [$sp + 14], $f4
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 17, $sp
.count stack_load
	load    [$sp - 6], $i1
	sub     $i1, 1, $i1
.count stack_load
	load    [$sp - 5], $i2
	add     $i2, 2, $i5
.count stack_load
	load    [$sp - 4], $i2
	add     $i2, 4, $i6
	bl      $i5, 5, calc_dirvec_rows.3033
	sub     $i5, 5, $i5
	b       calc_dirvec_rows.3033
bge_else.35466:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 17, $sp
	ret
bge_else.35462:
	ret
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements($i4, $i5)
# $ra = $ra
# [$i1 - $i7]
# [$f2]
# []
# []
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i5, 0, bge_else.35471
bge_then.35471:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 1]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	mov     $hp, $i7
	add     $hp, 2, $hp
	store   $i6, [$i7 + 1]
.count stack_load
	load    [$sp + 1], $i6
	store   $i6, [$i7 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i7, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.35472
bge_then.35472:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 2]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	mov     $hp, $i7
	add     $hp, 2, $hp
	store   $i6, [$i7 + 1]
.count stack_load
	load    [$sp + 2], $i6
	store   $i6, [$i7 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i7, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.35473
bge_then.35473:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	mov     $hp, $i7
	add     $hp, 2, $hp
	store   $i6, [$i7 + 1]
.count stack_load
	load    [$sp + 3], $i6
	store   $i6, [$i7 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i7, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.35474
bge_then.35474:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [$i2 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i2, [$tmp + 0]
	sub     $i5, 1, $i5
	b       create_dirvec_elements.3039
bge_else.35474:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35473:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35472:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35471:
	ret
.end create_dirvec_elements

######################################################################
# create_dirvecs($i4)
# $ra = $ra
# [$i1 - $i9]
# [$f2]
# []
# []
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i4, 0, bge_else.35475
bge_then.35475:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 2]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i5, [$i3 + 1]
.count stack_load
	load    [$sp + 2], $i5
	store   $i5, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	store   $i5, [ext_dirvecs + $i4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	load    [ext_dirvecs + $i4], $i4
	mov     $hp, $i6
	add     $hp, 2, $hp
	store   $i5, [$i6 + 1]
.count stack_load
	load    [$sp + 3], $i5
	store   $i5, [$i6 + 0]
	store   $i6, [$i4 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	mov     $hp, $i6
	add     $hp, 2, $hp
	store   $i5, [$i6 + 1]
.count stack_load
	load    [$sp + 4], $i5
	store   $i5, [$i6 + 0]
	store   $i6, [$i4 + 117]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	mov     $hp, $i9
	add     $hp, 2, $hp
	store   $i8, [$i9 + 1]
.count stack_load
	load    [$sp + 5], $i8
	store   $i8, [$i9 + 0]
	store   $i9, [$i4 + 116]
	li      115, $i5
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 1], $i4
	sub     $i4, 1, $i4
	bl      $i4, 0, bge_else.35476
bge_then.35476:
.count stack_store
	store   $i4, [$sp + 6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 7]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i5, [$i3 + 1]
.count stack_load
	load    [$sp + 7], $i5
	store   $i5, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	store   $i5, [ext_dirvecs + $i4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 8]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	load    [ext_dirvecs + $i4], $i4
	mov     $hp, $i6
	add     $hp, 2, $hp
	store   $i5, [$i6 + 1]
.count stack_load
	load    [$sp + 8], $i5
	store   $i5, [$i6 + 0]
	store   $i6, [$i4 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	mov     $hp, $i9
	add     $hp, 2, $hp
	store   $i8, [$i9 + 1]
.count stack_load
	load    [$sp + 9], $i8
	store   $i8, [$i9 + 0]
	store   $i9, [$i4 + 117]
	li      116, $i5
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i4
	b       create_dirvecs.3042
bge_else.35476:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.35475:
	ret
.end create_dirvecs

######################################################################
# init_dirvec_constants($i4, $i5)
# $ra = $ra
# [$i1 - $i17]
# [$f1 - $f16]
# []
# []
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i5, 0, bge_else.35477
bge_then.35477:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i5, [$sp + 2]
	sub     $ig0, 1, $i6
	load    [$i4 + $i5], $i4
	bl      $i6, 0, bge_cont.35478
bge_then.35478:
	load    [$i4 + 1], $i5
	load    [ext_objects + $i6], $i7
	load    [$i7 + 1], $i8
	load    [$i4 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35479
be_then.35479:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35480
be_then.35480:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35480
be_else.35480:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35481
ble_then.35481:
	li      0, $i14
.count b_cont
	b       ble_cont.35481
ble_else.35481:
	li      1, $i14
ble_cont.35481:
	bne     $i13, 0, be_else.35482
be_then.35482:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35482
be_else.35482:
	bne     $i14, 0, be_else.35483
be_then.35483:
	li      1, $i13
.count b_cont
	b       be_cont.35483
be_else.35483:
	li      0, $i13
be_cont.35483:
be_cont.35482:
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f9
	bne     $i13, 0, be_else.35484
be_then.35484:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35484
be_else.35484:
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35484:
be_cont.35480:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35485
be_then.35485:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35485
be_else.35485:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35486
ble_then.35486:
	li      0, $i14
.count b_cont
	b       ble_cont.35486
ble_else.35486:
	li      1, $i14
ble_cont.35486:
	bne     $i13, 0, be_else.35487
be_then.35487:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35487
be_else.35487:
	bne     $i14, 0, be_else.35488
be_then.35488:
	li      1, $i13
.count b_cont
	b       be_cont.35488
be_else.35488:
	li      0, $i13
be_cont.35488:
be_cont.35487:
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f9
	bne     $i13, 0, be_else.35489
be_then.35489:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35489
be_else.35489:
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35489:
be_cont.35485:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35490
be_then.35490:
	store   $f0, [$i12 + 5]
.count storer
	add     $i5, $i6, $tmp
	store   $i12, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35479
be_else.35490:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35491
ble_then.35491:
	li      0, $i14
.count b_cont
	b       ble_cont.35491
ble_else.35491:
	li      1, $i14
ble_cont.35491:
	bne     $i13, 0, be_else.35492
be_then.35492:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35492
be_else.35492:
	bne     $i14, 0, be_else.35493
be_then.35493:
	li      1, $i13
.count b_cont
	b       be_cont.35493
be_else.35493:
	li      0, $i13
be_cont.35493:
be_cont.35492:
	load    [$i7 + 4], $i14
	load    [$i14 + 2], $f9
	bne     $i13, 0, be_cont.35494
be_then.35494:
	fneg    $f9, $f9
be_cont.35494:
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
.count storer
	add     $i5, $i6, $tmp
	store   $i12, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35479
be_else.35479:
	bne     $i8, 2, be_else.35495
be_then.35495:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 4], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i9 + 0], $f9
	load    [$i13 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i14 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i15 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i5, $i6, $tmp
	sub     $i6, 1, $i5
	bg      $f9, $f0, ble_else.35496
ble_then.35496:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35495
ble_else.35496:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i7 + 4], $i13
	load    [$i13 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 4], $i13
	load    [$i13 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i7 + 4], $i13
	load    [$i13 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35495
be_else.35495:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 3], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i14 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i15 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i13, 0, be_else.35497
be_then.35497:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35497
be_else.35497:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i14
	load    [$i14 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i14
	load    [$i14 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i14
	load    [$i14 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35497:
	store   $f9, [$i12 + 0]
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i15 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i5, $i6, $tmp
	sub     $i6, 1, $i5
	bne     $i13, 0, be_else.35498
be_then.35498:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	bne     $f9, $f0, be_else.35499
be_then.35499:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35498
be_else.35499:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35498
be_else.35498:
	load    [$i7 + 9], $i13
	load    [$i7 + 9], $i14
	load    [$i13 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i14 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 9], $i13
	load    [$i9 + 2], $f10
	load    [$i13 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	bne     $f9, $f0, be_else.35500
be_then.35500:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35500
be_else.35500:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.35500:
be_cont.35498:
be_cont.35495:
be_cont.35479:
bge_cont.35478:
.count stack_load
	load    [$sp + 2], $i4
	sub     $i4, 1, $i4
	bl      $i4, 0, bge_else.35501
bge_then.35501:
.count stack_store
	store   $i4, [$sp + 3]
	sub     $ig0, 1, $i5
.count stack_load
	load    [$sp + 1], $i6
	load    [$i6 + $i4], $i4
	bl      $i5, 0, bge_cont.35502
bge_then.35502:
	load    [$i4 + 1], $i6
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i8
	load    [$i4 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35503
be_then.35503:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35504
be_then.35504:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35504
be_else.35504:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35505
ble_then.35505:
	li      0, $i14
.count b_cont
	b       ble_cont.35505
ble_else.35505:
	li      1, $i14
ble_cont.35505:
	bne     $i13, 0, be_else.35506
be_then.35506:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35506
be_else.35506:
	bne     $i14, 0, be_else.35507
be_then.35507:
	li      1, $i13
.count b_cont
	b       be_cont.35507
be_else.35507:
	li      0, $i13
be_cont.35507:
be_cont.35506:
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f9
	bne     $i13, 0, be_else.35508
be_then.35508:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35508
be_else.35508:
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35508:
be_cont.35504:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35509
be_then.35509:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35509
be_else.35509:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35510
ble_then.35510:
	li      0, $i14
.count b_cont
	b       ble_cont.35510
ble_else.35510:
	li      1, $i14
ble_cont.35510:
	bne     $i13, 0, be_else.35511
be_then.35511:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35511
be_else.35511:
	bne     $i14, 0, be_else.35512
be_then.35512:
	li      1, $i13
.count b_cont
	b       be_cont.35512
be_else.35512:
	li      0, $i13
be_cont.35512:
be_cont.35511:
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f9
	bne     $i13, 0, be_else.35513
be_then.35513:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35513
be_else.35513:
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35513:
be_cont.35509:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35514
be_then.35514:
	store   $f0, [$i12 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i12, [$tmp + 0]
	sub     $i5, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35503
be_else.35514:
	load    [$i7 + 6], $i13
	load    [$i7 + 4], $i14
	bg      $f0, $f9, ble_else.35515
ble_then.35515:
	li      0, $i15
.count b_cont
	b       ble_cont.35515
ble_else.35515:
	li      1, $i15
ble_cont.35515:
	bne     $i13, 0, be_else.35516
be_then.35516:
	mov     $i15, $i13
.count b_cont
	b       be_cont.35516
be_else.35516:
	bne     $i15, 0, be_else.35517
be_then.35517:
	li      1, $i13
.count b_cont
	b       be_cont.35517
be_else.35517:
	li      0, $i13
be_cont.35517:
be_cont.35516:
	load    [$i14 + 2], $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35518
be_then.35518:
	fneg    $f9, $f9
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35503
be_else.35518:
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35503
be_else.35503:
	bne     $i8, 2, be_else.35519
be_then.35519:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 4], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i9 + 0], $f9
	load    [$i13 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i14 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i15 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f9, $f0, ble_else.35520
ble_then.35520:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35519
ble_else.35520:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i7 + 4], $i13
	load    [$i13 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 4], $i13
	load    [$i13 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i7 + 4], $i13
	load    [$i13 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35519
be_else.35519:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 3], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i14 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i15 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i13, 0, be_else.35521
be_then.35521:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35521
be_else.35521:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i14
	load    [$i14 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i14
	load    [$i14 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i14
	load    [$i14 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35521:
	store   $f9, [$i12 + 0]
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i15 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35522
be_then.35522:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	bne     $f9, $f0, be_else.35523
be_then.35523:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35522
be_else.35523:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35522
be_else.35522:
	load    [$i7 + 9], $i13
	load    [$i7 + 9], $i14
	load    [$i13 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i14 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 9], $i13
	load    [$i9 + 2], $f10
	load    [$i13 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	bne     $f9, $f0, be_else.35524
be_then.35524:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35524
be_else.35524:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.35524:
be_cont.35522:
be_cont.35519:
be_cont.35503:
bge_cont.35502:
.count stack_load
	load    [$sp + 3], $i12
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_else.35525
bge_then.35525:
	sub     $ig0, 1, $i5
.count stack_load
	load    [$sp + 1], $i13
	load    [$i13 + $i12], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $i12, 1, $i4
	bl      $i4, 0, bge_else.35526
bge_then.35526:
	sub     $ig0, 1, $i5
	bl      $i5, 0, bge_else.35527
bge_then.35527:
	load    [$i13 + $i4], $i6
	load    [$i6 + 1], $i7
	load    [ext_objects + $i5], $i8
	load    [$i8 + 1], $i9
	load    [$i6 + 0], $i10
.count stack_store
	store   $i4, [$sp + 4]
.count move_args
	mov     $f0, $f2
	bne     $i9, 1, be_else.35528
be_then.35528:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i10 + 0], $f9
	bne     $f9, $f0, be_else.35529
be_then.35529:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35529
be_else.35529:
	load    [$i8 + 6], $i14
	bg      $f0, $f9, ble_else.35530
ble_then.35530:
	li      0, $i15
.count b_cont
	b       ble_cont.35530
ble_else.35530:
	li      1, $i15
ble_cont.35530:
	bne     $i14, 0, be_else.35531
be_then.35531:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35531
be_else.35531:
	bne     $i15, 0, be_else.35532
be_then.35532:
	li      1, $i14
.count b_cont
	b       be_cont.35532
be_else.35532:
	li      0, $i14
be_cont.35532:
be_cont.35531:
	load    [$i8 + 4], $i15
	load    [$i15 + 0], $f9
	bne     $i14, 0, be_else.35533
be_then.35533:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i10 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35533
be_else.35533:
	store   $f9, [$i12 + 0]
	load    [$i10 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35533:
be_cont.35529:
	load    [$i10 + 1], $f9
	bne     $f9, $f0, be_else.35534
be_then.35534:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35534
be_else.35534:
	load    [$i8 + 6], $i14
	bg      $f0, $f9, ble_else.35535
ble_then.35535:
	li      0, $i15
.count b_cont
	b       ble_cont.35535
ble_else.35535:
	li      1, $i15
ble_cont.35535:
	bne     $i14, 0, be_else.35536
be_then.35536:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35536
be_else.35536:
	bne     $i15, 0, be_else.35537
be_then.35537:
	li      1, $i14
.count b_cont
	b       be_cont.35537
be_else.35537:
	li      0, $i14
be_cont.35537:
be_cont.35536:
	load    [$i8 + 4], $i15
	load    [$i15 + 1], $f9
	bne     $i14, 0, be_else.35538
be_then.35538:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i10 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35538
be_else.35538:
	store   $f9, [$i12 + 2]
	load    [$i10 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35538:
be_cont.35534:
	load    [$i10 + 2], $f9
	bne     $f9, $f0, be_else.35539
be_then.35539:
	store   $f0, [$i12 + 5]
.count b_cont
	b       be_cont.35539
be_else.35539:
	load    [$i8 + 6], $i14
	load    [$i8 + 4], $i15
	bg      $f0, $f9, ble_else.35540
ble_then.35540:
	li      0, $i16
.count b_cont
	b       ble_cont.35540
ble_else.35540:
	li      1, $i16
ble_cont.35540:
	bne     $i14, 0, be_else.35541
be_then.35541:
	mov     $i16, $i14
.count b_cont
	b       be_cont.35541
be_else.35541:
	bne     $i16, 0, be_else.35542
be_then.35542:
	li      1, $i14
.count b_cont
	b       be_cont.35542
be_else.35542:
	li      0, $i14
be_cont.35542:
be_cont.35541:
	load    [$i15 + 2], $f9
	bne     $i14, 0, be_else.35543
be_then.35543:
	fneg    $f9, $f9
	store   $f9, [$i12 + 4]
	load    [$i10 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
.count b_cont
	b       be_cont.35543
be_else.35543:
	store   $f9, [$i12 + 4]
	load    [$i10 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
be_cont.35543:
be_cont.35539:
.count storer
	add     $i7, $i5, $tmp
	store   $i12, [$tmp + 0]
	sub     $i5, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i5
.count move_args
	mov     $i13, $i4
	b       init_dirvec_constants.3044
be_else.35528:
	bne     $i9, 2, be_else.35544
be_then.35544:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i8 + 4], $i14
	load    [$i8 + 4], $i15
	load    [$i8 + 4], $i16
	load    [$i10 + 0], $f9
	load    [$i14 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i10 + 1], $f10
	load    [$i15 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i10 + 2], $f10
	load    [$i16 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i7, $i5, $tmp
	bg      $f9, $f0, ble_else.35545
ble_then.35545:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
.count b_cont
	b       be_cont.35544
ble_else.35545:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i8 + 4], $i14
	load    [$i14 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i8 + 4], $i14
	load    [$i14 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i8 + 4], $i14
	load    [$i14 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
.count b_cont
	b       be_cont.35544
be_else.35544:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i8 + 3], $i14
	load    [$i8 + 4], $i15
	load    [$i8 + 4], $i16
	load    [$i8 + 4], $i17
	load    [$i10 + 0], $f9
	load    [$i10 + 1], $f10
	load    [$i10 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i15 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i16 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i14, 0, be_else.35546
be_then.35546:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35546
be_else.35546:
	fmul    $f10, $f11, $f13
	load    [$i8 + 9], $i15
	load    [$i15 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i8 + 9], $i15
	load    [$i15 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i8 + 9], $i15
	load    [$i15 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35546:
	store   $f9, [$i12 + 0]
	load    [$i8 + 4], $i15
	load    [$i8 + 4], $i16
	load    [$i8 + 4], $i17
	load    [$i10 + 0], $f10
	load    [$i15 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i10 + 1], $f11
	load    [$i16 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i10 + 2], $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i7, $i5, $tmp
	bne     $i14, 0, be_else.35547
be_then.35547:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	bne     $f9, $f0, be_else.35548
be_then.35548:
	store   $i12, [$tmp + 0]
.count b_cont
	b       be_cont.35547
be_else.35548:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
.count b_cont
	b       be_cont.35547
be_else.35547:
	load    [$i8 + 9], $i14
	load    [$i8 + 9], $i15
	load    [$i14 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i15 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i8 + 9], $i14
	load    [$i10 + 2], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i10 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i10 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i10 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	bne     $f9, $f0, be_else.35549
be_then.35549:
	store   $i12, [$tmp + 0]
.count b_cont
	b       be_cont.35549
be_else.35549:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
be_cont.35549:
be_cont.35547:
be_cont.35544:
	sub     $i5, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i5
.count move_args
	mov     $i13, $i4
	b       init_dirvec_constants.3044
bge_else.35527:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	sub     $i4, 1, $i5
.count move_args
	mov     $i13, $i4
	b       init_dirvec_constants.3044
bge_else.35526:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35525:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35501:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.35477:
	ret
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i4)
# $ra = $ra
# [$i1 - $i18]
# [$f1 - $f16]
# []
# []
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i4, 0, bge_else.35550
bge_then.35550:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	sub     $ig0, 1, $i5
	load    [ext_dirvecs + $i4], $i4
.count stack_store
	store   $i4, [$sp + 2]
	load    [$i4 + 119], $i4
	bl      $i5, 0, bge_cont.35551
bge_then.35551:
	load    [$i4 + 1], $i6
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i8
	load    [$i4 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35552
be_then.35552:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35553
be_then.35553:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35553
be_else.35553:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35554
ble_then.35554:
	li      0, $i14
.count b_cont
	b       ble_cont.35554
ble_else.35554:
	li      1, $i14
ble_cont.35554:
	bne     $i13, 0, be_else.35555
be_then.35555:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35555
be_else.35555:
	bne     $i14, 0, be_else.35556
be_then.35556:
	li      1, $i13
.count b_cont
	b       be_cont.35556
be_else.35556:
	li      0, $i13
be_cont.35556:
be_cont.35555:
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f9
	bne     $i13, 0, be_else.35557
be_then.35557:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35557
be_else.35557:
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35557:
be_cont.35553:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35558
be_then.35558:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35558
be_else.35558:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35559
ble_then.35559:
	li      0, $i14
.count b_cont
	b       ble_cont.35559
ble_else.35559:
	li      1, $i14
ble_cont.35559:
	bne     $i13, 0, be_else.35560
be_then.35560:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35560
be_else.35560:
	bne     $i14, 0, be_else.35561
be_then.35561:
	li      1, $i13
.count b_cont
	b       be_cont.35561
be_else.35561:
	li      0, $i13
be_cont.35561:
be_cont.35560:
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f9
	bne     $i13, 0, be_else.35562
be_then.35562:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35562
be_else.35562:
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35562:
be_cont.35558:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35563
be_then.35563:
	store   $f0, [$i12 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i12, [$tmp + 0]
	sub     $i5, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35552
be_else.35563:
	load    [$i7 + 6], $i13
	load    [$i7 + 4], $i14
	bg      $f0, $f9, ble_else.35564
ble_then.35564:
	li      0, $i15
.count b_cont
	b       ble_cont.35564
ble_else.35564:
	li      1, $i15
ble_cont.35564:
	bne     $i13, 0, be_else.35565
be_then.35565:
	mov     $i15, $i13
.count b_cont
	b       be_cont.35565
be_else.35565:
	bne     $i15, 0, be_else.35566
be_then.35566:
	li      1, $i13
.count b_cont
	b       be_cont.35566
be_else.35566:
	li      0, $i13
be_cont.35566:
be_cont.35565:
	load    [$i14 + 2], $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35567
be_then.35567:
	fneg    $f9, $f9
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35552
be_else.35567:
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35552
be_else.35552:
	bne     $i8, 2, be_else.35568
be_then.35568:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 4], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i9 + 0], $f9
	load    [$i13 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i14 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i15 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f9, $f0, ble_else.35569
ble_then.35569:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35568
ble_else.35569:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i7 + 4], $i13
	load    [$i13 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 4], $i13
	load    [$i13 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i7 + 4], $i13
	load    [$i13 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35568
be_else.35568:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 3], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i14 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i15 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i13, 0, be_else.35570
be_then.35570:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35570
be_else.35570:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i14
	load    [$i14 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i14
	load    [$i14 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i14
	load    [$i14 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35570:
	store   $f9, [$i12 + 0]
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i15 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35571
be_then.35571:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	bne     $f9, $f0, be_else.35572
be_then.35572:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35571
be_else.35572:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35571
be_else.35571:
	load    [$i7 + 9], $i13
	load    [$i7 + 9], $i14
	load    [$i13 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i14 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 9], $i13
	load    [$i9 + 2], $f10
	load    [$i13 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	bne     $f9, $f0, be_else.35573
be_then.35573:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35573
be_else.35573:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.35573:
be_cont.35571:
be_cont.35568:
be_cont.35552:
bge_cont.35551:
	sub     $ig0, 1, $i5
.count stack_load
	load    [$sp + 2], $i12
	load    [$i12 + 118], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i4
	load    [$i12 + 117], $i5
	bl      $i4, 0, bge_cont.35574
bge_then.35574:
	load    [$i5 + 1], $i6
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i8
	load    [$i5 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35575
be_then.35575:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35576
be_then.35576:
	store   $f0, [$i13 + 1]
.count b_cont
	b       be_cont.35576
be_else.35576:
	load    [$i7 + 6], $i14
	bg      $f0, $f9, ble_else.35577
ble_then.35577:
	li      0, $i15
.count b_cont
	b       ble_cont.35577
ble_else.35577:
	li      1, $i15
ble_cont.35577:
	bne     $i14, 0, be_else.35578
be_then.35578:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35578
be_else.35578:
	bne     $i15, 0, be_else.35579
be_then.35579:
	li      1, $i14
.count b_cont
	b       be_cont.35579
be_else.35579:
	li      0, $i14
be_cont.35579:
be_cont.35578:
	load    [$i7 + 4], $i15
	load    [$i15 + 0], $f9
	bne     $i14, 0, be_else.35580
be_then.35580:
	fneg    $f9, $f9
	store   $f9, [$i13 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 1]
.count b_cont
	b       be_cont.35580
be_else.35580:
	store   $f9, [$i13 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 1]
be_cont.35580:
be_cont.35576:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35581
be_then.35581:
	store   $f0, [$i13 + 3]
.count b_cont
	b       be_cont.35581
be_else.35581:
	load    [$i7 + 6], $i14
	bg      $f0, $f9, ble_else.35582
ble_then.35582:
	li      0, $i15
.count b_cont
	b       ble_cont.35582
ble_else.35582:
	li      1, $i15
ble_cont.35582:
	bne     $i14, 0, be_else.35583
be_then.35583:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35583
be_else.35583:
	bne     $i15, 0, be_else.35584
be_then.35584:
	li      1, $i14
.count b_cont
	b       be_cont.35584
be_else.35584:
	li      0, $i14
be_cont.35584:
be_cont.35583:
	load    [$i7 + 4], $i15
	load    [$i15 + 1], $f9
	bne     $i14, 0, be_else.35585
be_then.35585:
	fneg    $f9, $f9
	store   $f9, [$i13 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 3]
.count b_cont
	b       be_cont.35585
be_else.35585:
	store   $f9, [$i13 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 3]
be_cont.35585:
be_cont.35581:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35586
be_then.35586:
	store   $f0, [$i13 + 5]
.count storer
	add     $i6, $i4, $tmp
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35575
be_else.35586:
	load    [$i7 + 6], $i14
	load    [$i7 + 4], $i15
	bg      $f0, $f9, ble_else.35587
ble_then.35587:
	li      0, $i16
.count b_cont
	b       ble_cont.35587
ble_else.35587:
	li      1, $i16
ble_cont.35587:
	bne     $i14, 0, be_else.35588
be_then.35588:
	mov     $i16, $i14
.count b_cont
	b       be_cont.35588
be_else.35588:
	bne     $i16, 0, be_else.35589
be_then.35589:
	li      1, $i14
.count b_cont
	b       be_cont.35589
be_else.35589:
	li      0, $i14
be_cont.35589:
be_cont.35588:
	load    [$i15 + 2], $f9
.count storer
	add     $i6, $i4, $tmp
	bne     $i14, 0, be_else.35590
be_then.35590:
	fneg    $f9, $f9
	store   $f9, [$i13 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 5]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35575
be_else.35590:
	store   $f9, [$i13 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 5]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35575
be_else.35575:
	bne     $i8, 2, be_else.35591
be_then.35591:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i14 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i15 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i16 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i6, $i4, $tmp
	bg      $f9, $f0, ble_else.35592
ble_then.35592:
	store   $f0, [$i13 + 0]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35591
ble_else.35592:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i13 + 0]
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i13 + 1]
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i13 + 2]
	load    [$i7 + 4], $i14
	load    [$i14 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i13 + 3]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35591
be_else.35591:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i7 + 3], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i7 + 4], $i17
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i15 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i16 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i14, 0, be_else.35593
be_then.35593:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35593
be_else.35593:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i15
	load    [$i15 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i15
	load    [$i15 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i15
	load    [$i15 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35593:
	store   $f9, [$i13 + 0]
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i7 + 4], $i17
	load    [$i9 + 0], $f10
	load    [$i15 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i16 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i6, $i4, $tmp
	bne     $i14, 0, be_else.35594
be_then.35594:
	store   $f10, [$i13 + 1]
	store   $f12, [$i13 + 2]
	store   $f14, [$i13 + 3]
	bne     $f9, $f0, be_else.35595
be_then.35595:
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35594
be_else.35595:
	finv    $f9, $f9
	store   $f9, [$i13 + 4]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35594
be_else.35594:
	load    [$i7 + 9], $i14
	load    [$i7 + 9], $i15
	load    [$i14 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i15 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i13 + 1]
	load    [$i7 + 9], $i14
	load    [$i9 + 2], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i13 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i13 + 3]
	bne     $f9, $f0, be_else.35596
be_then.35596:
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35596
be_else.35596:
	finv    $f9, $f9
	store   $f9, [$i13 + 4]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
be_cont.35596:
be_cont.35594:
be_cont.35591:
be_cont.35575:
bge_cont.35574:
	li      116, $i5
.count move_args
	mov     $i12, $i4
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 1], $i12
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_else.35597
bge_then.35597:
.count stack_store
	store   $i12, [$sp + 3]
	sub     $ig0, 1, $i5
	load    [ext_dirvecs + $i12], $i12
	load    [$i12 + 119], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i4
	load    [$i12 + 118], $i5
	bl      $i4, 0, bge_cont.35598
bge_then.35598:
	load    [$i5 + 1], $i6
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i8
	load    [$i5 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35599
be_then.35599:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35600
be_then.35600:
	store   $f0, [$i13 + 1]
.count b_cont
	b       be_cont.35600
be_else.35600:
	load    [$i7 + 6], $i14
	bg      $f0, $f9, ble_else.35601
ble_then.35601:
	li      0, $i15
.count b_cont
	b       ble_cont.35601
ble_else.35601:
	li      1, $i15
ble_cont.35601:
	bne     $i14, 0, be_else.35602
be_then.35602:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35602
be_else.35602:
	bne     $i15, 0, be_else.35603
be_then.35603:
	li      1, $i14
.count b_cont
	b       be_cont.35603
be_else.35603:
	li      0, $i14
be_cont.35603:
be_cont.35602:
	load    [$i7 + 4], $i15
	load    [$i15 + 0], $f9
	bne     $i14, 0, be_else.35604
be_then.35604:
	fneg    $f9, $f9
	store   $f9, [$i13 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 1]
.count b_cont
	b       be_cont.35604
be_else.35604:
	store   $f9, [$i13 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 1]
be_cont.35604:
be_cont.35600:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35605
be_then.35605:
	store   $f0, [$i13 + 3]
.count b_cont
	b       be_cont.35605
be_else.35605:
	load    [$i7 + 6], $i14
	bg      $f0, $f9, ble_else.35606
ble_then.35606:
	li      0, $i15
.count b_cont
	b       ble_cont.35606
ble_else.35606:
	li      1, $i15
ble_cont.35606:
	bne     $i14, 0, be_else.35607
be_then.35607:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35607
be_else.35607:
	bne     $i15, 0, be_else.35608
be_then.35608:
	li      1, $i14
.count b_cont
	b       be_cont.35608
be_else.35608:
	li      0, $i14
be_cont.35608:
be_cont.35607:
	load    [$i7 + 4], $i15
	load    [$i15 + 1], $f9
	bne     $i14, 0, be_else.35609
be_then.35609:
	fneg    $f9, $f9
	store   $f9, [$i13 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 3]
.count b_cont
	b       be_cont.35609
be_else.35609:
	store   $f9, [$i13 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 3]
be_cont.35609:
be_cont.35605:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35610
be_then.35610:
	store   $f0, [$i13 + 5]
.count storer
	add     $i6, $i4, $tmp
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35599
be_else.35610:
	load    [$i7 + 6], $i14
	load    [$i7 + 4], $i15
	bg      $f0, $f9, ble_else.35611
ble_then.35611:
	li      0, $i16
.count b_cont
	b       ble_cont.35611
ble_else.35611:
	li      1, $i16
ble_cont.35611:
	bne     $i14, 0, be_else.35612
be_then.35612:
	mov     $i16, $i14
.count b_cont
	b       be_cont.35612
be_else.35612:
	bne     $i16, 0, be_else.35613
be_then.35613:
	li      1, $i14
.count b_cont
	b       be_cont.35613
be_else.35613:
	li      0, $i14
be_cont.35613:
be_cont.35612:
	load    [$i15 + 2], $f9
.count storer
	add     $i6, $i4, $tmp
	bne     $i14, 0, be_else.35614
be_then.35614:
	fneg    $f9, $f9
	store   $f9, [$i13 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 5]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35599
be_else.35614:
	store   $f9, [$i13 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i13 + 5]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35599
be_else.35599:
	bne     $i8, 2, be_else.35615
be_then.35615:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i14 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i15 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i16 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i6, $i4, $tmp
	bg      $f9, $f0, ble_else.35616
ble_then.35616:
	store   $f0, [$i13 + 0]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35615
ble_else.35616:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i13 + 0]
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i13 + 1]
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i13 + 2]
	load    [$i7 + 4], $i14
	load    [$i14 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i13 + 3]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35615
be_else.35615:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i13
	load    [$i7 + 3], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i7 + 4], $i17
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i15 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i16 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i14, 0, be_else.35617
be_then.35617:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35617
be_else.35617:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i15
	load    [$i15 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i15
	load    [$i15 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i15
	load    [$i15 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35617:
	store   $f9, [$i13 + 0]
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i7 + 4], $i17
	load    [$i9 + 0], $f10
	load    [$i15 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i16 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i17 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i6, $i4, $tmp
	bne     $i14, 0, be_else.35618
be_then.35618:
	store   $f10, [$i13 + 1]
	store   $f12, [$i13 + 2]
	store   $f14, [$i13 + 3]
	bne     $f9, $f0, be_else.35619
be_then.35619:
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35618
be_else.35619:
	finv    $f9, $f9
	store   $f9, [$i13 + 4]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35618
be_else.35618:
	load    [$i7 + 9], $i14
	load    [$i7 + 9], $i15
	load    [$i14 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i15 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i13 + 1]
	load    [$i7 + 9], $i14
	load    [$i9 + 2], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i13 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i13 + 3]
	bne     $f9, $f0, be_else.35620
be_then.35620:
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35620
be_else.35620:
	finv    $f9, $f9
	store   $f9, [$i13 + 4]
	store   $i13, [$tmp + 0]
	sub     $i4, 1, $i13
.count move_args
	mov     $i5, $i4
.count move_args
	mov     $i13, $i5
	call    iter_setup_dirvec_constants.2826
be_cont.35620:
be_cont.35618:
be_cont.35615:
be_cont.35599:
bge_cont.35598:
	li      117, $i5
.count move_args
	mov     $i12, $i4
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $i4
	sub     $i4, 1, $i4
	bl      $i4, 0, bge_else.35621
bge_then.35621:
.count stack_store
	store   $i4, [$sp + 4]
	sub     $ig0, 1, $i5
	load    [ext_dirvecs + $i4], $i4
.count stack_store
	store   $i4, [$sp + 5]
	load    [$i4 + 119], $i4
	bl      $i5, 0, bge_cont.35622
bge_then.35622:
	load    [$i4 + 1], $i6
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i8
	load    [$i4 + 0], $i9
.count move_args
	mov     $f0, $f2
	bne     $i8, 1, be_else.35623
be_then.35623:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i9 + 0], $f9
	bne     $f9, $f0, be_else.35624
be_then.35624:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35624
be_else.35624:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35625
ble_then.35625:
	li      0, $i14
.count b_cont
	b       ble_cont.35625
ble_else.35625:
	li      1, $i14
ble_cont.35625:
	bne     $i13, 0, be_else.35626
be_then.35626:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35626
be_else.35626:
	bne     $i14, 0, be_else.35627
be_then.35627:
	li      1, $i13
.count b_cont
	b       be_cont.35627
be_else.35627:
	li      0, $i13
be_cont.35627:
be_cont.35626:
	load    [$i7 + 4], $i14
	load    [$i14 + 0], $f9
	bne     $i13, 0, be_else.35628
be_then.35628:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35628
be_else.35628:
	store   $f9, [$i12 + 0]
	load    [$i9 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35628:
be_cont.35624:
	load    [$i9 + 1], $f9
	bne     $f9, $f0, be_else.35629
be_then.35629:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35629
be_else.35629:
	load    [$i7 + 6], $i13
	bg      $f0, $f9, ble_else.35630
ble_then.35630:
	li      0, $i14
.count b_cont
	b       ble_cont.35630
ble_else.35630:
	li      1, $i14
ble_cont.35630:
	bne     $i13, 0, be_else.35631
be_then.35631:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35631
be_else.35631:
	bne     $i14, 0, be_else.35632
be_then.35632:
	li      1, $i13
.count b_cont
	b       be_cont.35632
be_else.35632:
	li      0, $i13
be_cont.35632:
be_cont.35631:
	load    [$i7 + 4], $i14
	load    [$i14 + 1], $f9
	bne     $i13, 0, be_else.35633
be_then.35633:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35633
be_else.35633:
	store   $f9, [$i12 + 2]
	load    [$i9 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35633:
be_cont.35629:
	load    [$i9 + 2], $f9
	bne     $f9, $f0, be_else.35634
be_then.35634:
	store   $f0, [$i12 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i12, [$tmp + 0]
	sub     $i5, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35623
be_else.35634:
	load    [$i7 + 6], $i13
	load    [$i7 + 4], $i14
	bg      $f0, $f9, ble_else.35635
ble_then.35635:
	li      0, $i15
.count b_cont
	b       ble_cont.35635
ble_else.35635:
	li      1, $i15
ble_cont.35635:
	bne     $i13, 0, be_else.35636
be_then.35636:
	mov     $i15, $i13
.count b_cont
	b       be_cont.35636
be_else.35636:
	bne     $i15, 0, be_else.35637
be_then.35637:
	li      1, $i13
.count b_cont
	b       be_cont.35637
be_else.35637:
	li      0, $i13
be_cont.35637:
be_cont.35636:
	load    [$i14 + 2], $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35638
be_then.35638:
	fneg    $f9, $f9
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35623
be_else.35638:
	store   $f9, [$i12 + 4]
	load    [$i9 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35623
be_else.35623:
	bne     $i8, 2, be_else.35639
be_then.35639:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 4], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i9 + 0], $f9
	load    [$i13 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i9 + 1], $f10
	load    [$i14 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i9 + 2], $f10
	load    [$i15 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f9, $f0, ble_else.35640
ble_then.35640:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35639
ble_else.35640:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i7 + 4], $i13
	load    [$i13 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 4], $i13
	load    [$i13 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i7 + 4], $i13
	load    [$i13 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35639
be_else.35639:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i7 + 3], $i13
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f9
	load    [$i9 + 1], $f10
	load    [$i9 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i14 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i15 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i13, 0, be_else.35641
be_then.35641:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35641
be_else.35641:
	fmul    $f10, $f11, $f13
	load    [$i7 + 9], $i14
	load    [$i14 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i7 + 9], $i14
	load    [$i14 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i7 + 9], $i14
	load    [$i14 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35641:
	store   $f9, [$i12 + 0]
	load    [$i7 + 4], $i14
	load    [$i7 + 4], $i15
	load    [$i7 + 4], $i16
	load    [$i9 + 0], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 1], $f11
	load    [$i15 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i9 + 2], $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i13, 0, be_else.35642
be_then.35642:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	bne     $f9, $f0, be_else.35643
be_then.35643:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35642
be_else.35643:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35642
be_else.35642:
	load    [$i7 + 9], $i13
	load    [$i7 + 9], $i14
	load    [$i13 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i14 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i7 + 9], $i13
	load    [$i9 + 2], $f10
	load    [$i13 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i9 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i9 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	bne     $f9, $f0, be_else.35644
be_then.35644:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35644
be_else.35644:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.35644:
be_cont.35642:
be_cont.35639:
be_cont.35623:
bge_cont.35622:
	li      118, $i5
.count stack_load
	load    [$sp + 5], $i4
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 4], $i18
	sub     $i18, 1, $i18
	bl      $i18, 0, bge_else.35645
bge_then.35645:
	load    [ext_dirvecs + $i18], $i4
	li      119, $i5
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	sub     $i18, 1, $i4
	b       init_vecset_constants.3047
bge_else.35645:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.35621:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.35597:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.35550:
	ret
.end init_vecset_constants

######################################################################
# setup_reflections($i4)
# $ra = $ra
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig4]
# []
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i4, 0, bge_else.35646
bge_then.35646:
	load    [ext_objects + $i4], $i5
	load    [$i5 + 2], $i6
	bne     $i6, 2, be_else.35647
be_then.35647:
	load    [$i5 + 7], $i6
	load    [$i6 + 0], $f1
	bg      $fc0, $f1, ble_else.35648
ble_then.35648:
	ret
ble_else.35648:
	load    [$i5 + 1], $i6
	bne     $i6, 1, be_else.35649
be_then.35649:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
	load    [$i5 + 7], $i4
.count stack_store
	store   $i4, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
.count stack_load
	load    [$sp + 3], $i13
	store   $fg12, [$i13 + 0]
	fneg    $fg13, $f9
	store   $f9, [$i13 + 1]
	fneg    $fg14, $f10
	store   $f10, [$i13 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i4
.count stack_store
	store   $i4, [$sp + 4]
	add     $hp, 2, $hp
	store   $i12, [$i4 + 1]
	store   $i13, [$i4 + 0]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 1], $i4
	add     $i4, $i4, $i4
	add     $i4, $i4, $i4
.count stack_store
	store   $i4, [$sp + 5]
	add     $i4, 1, $i4
.count stack_load
	load    [$sp + 2], $i5
	load    [$i5 + 0], $f1
	fsub    $fc0, $f1, $f1
.count stack_store
	store   $f1, [$sp + 6]
	mov     $hp, $i5
	add     $hp, 3, $hp
	store   $f1, [$i5 + 2]
.count stack_load
	load    [$sp + 4], $i6
	store   $i6, [$i5 + 1]
	store   $i4, [$i5 + 0]
	store   $i5, [ext_reflections + $ig4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 7]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
	fneg    $fg12, $f11
.count stack_load
	load    [$sp + 7], $i13
	store   $f11, [$i13 + 0]
	store   $fg13, [$i13 + 1]
	store   $f10, [$i13 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i4
.count stack_store
	store   $i4, [$sp + 8]
	add     $hp, 2, $hp
	store   $i12, [$i4 + 1]
	store   $i13, [$i4 + 0]
	call    iter_setup_dirvec_constants.2826
	add     $ig4, 1, $i4
.count stack_load
	load    [$sp + 5], $i5
	add     $i5, 2, $i5
	mov     $hp, $i6
	add     $hp, 3, $hp
.count stack_load
	load    [$sp + 6], $i7
	store   $i7, [$i6 + 2]
.count stack_load
	load    [$sp + 8], $i7
	store   $i7, [$i6 + 1]
	store   $i5, [$i6 + 0]
	store   $i6, [ext_reflections + $i4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
.count stack_load
	load    [$sp + 9], $i13
	store   $f11, [$i13 + 0]
	store   $f9, [$i13 + 1]
	store   $fg14, [$i13 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i4
.count stack_store
	store   $i4, [$sp + 10]
	add     $hp, 2, $hp
	store   $i12, [$i4 + 1]
	store   $i13, [$i4 + 0]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	add     $ig4, 2, $i1
.count stack_load
	load    [$sp - 9], $i2
	add     $i2, 3, $i2
	mov     $hp, $i3
	add     $hp, 3, $hp
.count stack_load
	load    [$sp - 8], $i4
	store   $i4, [$i3 + 2]
.count stack_load
	load    [$sp - 4], $i4
	store   $i4, [$i3 + 1]
	store   $i2, [$i3 + 0]
	store   $i3, [ext_reflections + $i1]
	add     $ig4, 3, $ig4
	ret
be_else.35649:
	bne     $i6, 2, be_else.35650
be_then.35650:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $f1, [$sp + 11]
	load    [$i5 + 4], $i4
	load    [$i5 + 4], $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 12]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i12
	load    [$i4 + 0], $f9
	fmul    $fc10, $f9, $f10
	fmul    $fg12, $f9, $f9
	load    [$i5 + 1], $f11
	fmul    $fg13, $f11, $f12
	fadd    $f9, $f12, $f9
	load    [$i5 + 2], $f12
	fmul    $fg14, $f12, $f13
	fadd    $f9, $f13, $f9
	fmul    $f10, $f9, $f10
	fsub    $f10, $fg12, $f10
.count stack_load
	load    [$sp + 12], $i13
	store   $f10, [$i13 + 0]
	fmul    $fc10, $f11, $f10
	fmul    $f10, $f9, $f10
	fsub    $f10, $fg13, $f10
	store   $f10, [$i13 + 1]
	fmul    $fc10, $f12, $f10
	fmul    $f10, $f9, $f9
	fsub    $f9, $fg14, $f9
	store   $f9, [$i13 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i4
.count stack_store
	store   $i4, [$sp + 13]
	add     $hp, 2, $hp
	store   $i12, [$i4 + 1]
	store   $i13, [$i4 + 0]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 3], $f1
	fsub    $fc0, $f1, $f1
.count stack_load
	load    [$sp - 13], $i1
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	store   $f1, [$i2 + 2]
.count stack_load
	load    [$sp - 1], $i3
	store   $i3, [$i2 + 1]
	store   $i1, [$i2 + 0]
	store   $i2, [ext_reflections + $ig4]
	add     $ig4, 1, $ig4
	ret
be_else.35650:
	ret
be_else.35647:
	ret
bge_else.35646:
	ret
.end setup_reflections

######################################################################
# main
######################################################################
.begin main
ext_main:
.count stack_move
	sub     $sp, 21, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [ext_n_objects + 0], $ig0
	load    [ext_solver_dist + 0], $fg0
	load    [ext_diffuse_ray + 0], $fg1
	load    [ext_diffuse_ray + 1], $fg2
	load    [ext_diffuse_ray + 2], $fg3
	load    [ext_rgb + 0], $fg4
	load    [ext_rgb + 1], $fg5
	load    [ext_rgb + 2], $fg6
	load    [ext_tmin + 0], $fg7
	load    [ext_startp_fast + 0], $fg8
	load    [ext_startp_fast + 1], $fg9
	load    [ext_startp_fast + 2], $fg10
	load    [ext_texture_color + 1], $fg11
	load    [ext_light + 0], $fg12
	load    [ext_light + 1], $fg13
	load    [ext_light + 2], $fg14
	load    [ext_texture_color + 2], $fg15
	load    [ext_or_net + 0], $ig1
	load    [ext_intsec_rectside + 0], $ig2
	load    [ext_texture_color + 0], $fg16
	load    [ext_intersected_object_id + 0], $ig3
	load    [ext_n_reflections + 0], $ig4
	load    [ext_scan_pitch + 0], $fg17
	load    [ext_screenz_dir + 0], $fg18
	load    [ext_screenz_dir + 1], $fg19
	load    [ext_screenz_dir + 2], $fg20
	load    [ext_startp + 0], $fg21
	load    [ext_startp + 1], $fg22
	load    [ext_startp + 2], $fg23
	load    [ext_screeny_dir + 0], $fg24
	load    [f.31942 + 0], $fc0
	load    [f.31966 + 0], $fc1
	load    [f.31965 + 0], $fc2
	load    [f.31943 + 0], $fc3
	load    [f.31941 + 0], $fc4
	load    [f.31968 + 0], $fc5
	load    [f.31967 + 0], $fc6
	load    [f.31946 + 0], $fc7
	load    [f.31955 + 0], $fc8
	load    [f.31953 + 0], $fc9
	load    [f.31940 + 0], $fc10
	load    [f.31997 + 0], $fc11
	load    [f.31996 + 0], $fc12
	load    [f.31961 + 0], $fc13
	load    [f.31960 + 0], $fc14
	load    [f.31950 + 0], $fc15
	load    [f.31945 + 0], $fc16
	load    [f.31951 + 0], $fc17
	load    [f.31949 + 0], $fc18
	load    [f.31948 + 0], $fc19
.count load_float
	load    [f.32059], $f4
	li      128, $i2
	call    ext_float_of_int
	finv    $f1, $f1
	fmul    $f4, $f1, $fg17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i11, [$i3 + 7]
	store   $i10, [$i3 + 6]
	store   $i9, [$i3 + 5]
	store   $i8, [$i3 + 4]
	store   $i7, [$i3 + 3]
	store   $i6, [$i3 + 2]
	store   $i5, [$i3 + 1]
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i13
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i13 + 126]
	li      125, $i5
.count move_args
	mov     $i13, $i4
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i4
.count stack_store
	store   $i4, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i11, [$i3 + 7]
	store   $i10, [$i3 + 6]
	store   $i9, [$i3 + 5]
	store   $i8, [$i3 + 4]
	store   $i7, [$i3 + 3]
	store   $i6, [$i3 + 2]
	store   $i5, [$i3 + 1]
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i13
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i13 + 126]
	li      125, $i5
.count move_args
	mov     $i13, $i4
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i4
.count stack_store
	store   $i4, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i6
	store   $i6, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i6
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i7
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i9
	store   $i9, [$i8 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i9
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i10
	store   $i10, [$i9 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i11, [$i3 + 7]
	store   $i10, [$i3 + 6]
	store   $i9, [$i3 + 5]
	store   $i8, [$i3 + 4]
	store   $i7, [$i3 + 3]
	store   $i6, [$i3 + 2]
	store   $i5, [$i3 + 1]
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i13
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i13 + 126]
	li      125, $i5
.count move_args
	mov     $i13, $i4
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i6
.count stack_store
	store   $i6, [$sp + 3]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [ext_screen + 0]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [ext_screen + 1]
	call    ext_read_float
.count move_ret
	mov     $f1, $f2
	store   $f2, [ext_screen + 2]
	call    ext_read_float
.count move_ret
	mov     $f1, $f9
.count load_float
	load    [f.31927], $f10
	fmul    $f9, $f10, $f2
.count stack_store
	store   $f2, [$sp + 4]
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 5]
.count stack_load
	load    [$sp + 4], $f2
	call    ext_sin
.count move_ret
	mov     $f1, $f2
.count stack_store
	store   $f2, [$sp + 6]
	call    ext_read_float
.count move_ret
	mov     $f1, $f9
	fmul    $f9, $f10, $f2
.count stack_store
	store   $f2, [$sp + 7]
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_load
	load    [$sp + 7], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 5], $f2
	fmul    $f2, $f1, $f3
.count load_float
	load    [f.32087], $f4
	fmul    $f3, $f4, $fg18
.count load_float
	load    [f.32088], $f3
.count stack_load
	load    [$sp + 6], $f5
	fmul    $f5, $f3, $fg19
	fmul    $f2, $f8, $f3
	fmul    $f3, $f4, $fg20
	store   $f8, [ext_screenx_dir + 0]
	fneg    $f1, $f3
	store   $f3, [ext_screenx_dir + 2]
	fneg    $f5, $f3
	fmul    $f3, $f1, $fg24
	fneg    $f2, $f1
	store   $f1, [ext_screeny_dir + 1]
	fmul    $f3, $f8, $f1
	store   $f1, [ext_screeny_dir + 2]
	load    [ext_screen + 0], $f1
	fsub    $f1, $fg18, $f1
	store   $f1, [ext_viewpoint + 0]
	load    [ext_screen + 1], $f1
	fsub    $f1, $fg19, $f1
	store   $f1, [ext_viewpoint + 1]
	load    [ext_screen + 2], $f1
	fsub    $f1, $fg20, $f1
	store   $f1, [ext_viewpoint + 2]
	call    ext_read_int
.count move_ret
	mov     $i1, $i6
	call    ext_read_float
.count move_ret
	mov     $f1, $f8
	fmul    $f8, $f10, $f2
.count stack_store
	store   $f2, [$sp + 8]
	call    ext_sin
.count move_ret
	mov     $f1, $f2
	fneg    $f2, $fg13
	call    ext_read_float
.count move_ret
	mov     $f1, $f9
.count stack_load
	load    [$sp + 8], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f8
.count stack_store
	store   $f8, [$sp + 9]
	fmul    $f9, $f10, $f2
.count stack_store
	store   $f2, [$sp + 10]
	call    ext_sin
.count move_ret
	mov     $f1, $f9
	fmul    $f8, $f9, $fg12
.count stack_load
	load    [$sp + 10], $f2
	call    ext_cos
.count move_ret
	mov     $f1, $f2
.count stack_load
	load    [$sp + 9], $f3
	fmul    $f3, $f2, $fg14
	call    ext_read_float
.count move_ret
	mov     $f1, $f18
	store   $f18, [ext_beam + 0]
	li      0, $i6
.count stack_store
	store   $i6, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.35651
be_then.35651:
.count stack_load
	load    [$sp + 11], $i6
	mov     $i6, $ig0
.count b_cont
	b       be_cont.35651
be_else.35651:
	li      1, $i6
.count stack_store
	store   $i6, [$sp + 12]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.35652
be_then.35652:
.count stack_load
	load    [$sp + 12], $i6
	mov     $i6, $ig0
.count b_cont
	b       be_cont.35652
be_else.35652:
	li      2, $i6
.count stack_store
	store   $i6, [$sp + 13]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i16
	bne     $i16, 0, be_else.35653
be_then.35653:
.count stack_load
	load    [$sp + 13], $i6
	mov     $i6, $ig0
.count b_cont
	b       be_cont.35653
be_else.35653:
	li      3, $i6
.count stack_store
	store   $i6, [$sp + 14]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35654
be_then.35654:
.count stack_load
	load    [$sp + 14], $i6
	mov     $i6, $ig0
.count b_cont
	b       be_cont.35654
be_else.35654:
	li      4, $i6
	call    read_object.2721
be_cont.35654:
be_cont.35653:
be_cont.35652:
be_cont.35651:
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.35655
be_then.35655:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
.count b_cont
	b       be_cont.35655
be_else.35655:
.count stack_store
	store   $i4, [$sp + 15]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.35656
be_then.35656:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
.count stack_load
	load    [$sp + 15], $i9
	store   $i9, [$i8 + 0]
.count b_cont
	b       be_cont.35656
be_else.35656:
.count stack_store
	store   $i4, [$sp + 16]
	li      2, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i8
.count stack_load
	load    [$sp + 16], $i9
	store   $i9, [$i8 + 1]
.count stack_load
	load    [$sp + 15], $i9
	store   $i9, [$i8 + 0]
be_cont.35656:
be_cont.35655:
	load    [$i8 + 0], $i9
	be      $i9, -1, bne_cont.35657
bne_then.35657:
	store   $i8, [ext_and_net + 0]
	li      1, $i6
	call    read_and_network.2729
bne_cont.35657:
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.35658
be_then.35658:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count b_cont
	b       be_cont.35658
be_else.35658:
.count stack_store
	store   $i4, [$sp + 17]
	call    ext_read_int
.count move_ret
	mov     $i1, $i4
	bne     $i4, -1, be_else.35659
be_then.35659:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 17], $i5
	store   $i5, [$i4 + 0]
.count b_cont
	b       be_cont.35659
be_else.35659:
.count stack_store
	store   $i4, [$sp + 18]
	li      2, $i6
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i4
.count stack_load
	load    [$sp + 18], $i5
	store   $i5, [$i4 + 1]
.count stack_load
	load    [$sp + 17], $i5
	store   $i5, [$i4 + 0]
be_cont.35659:
be_cont.35658:
	mov     $i4, $i3
	load    [$i3 + 0], $i4
	bne     $i4, -1, be_else.35660
be_then.35660:
	li      1, $i2
	call    ext_create_array_int
.count b_cont
	b       be_cont.35660
be_else.35660:
.count stack_store
	store   $i3, [$sp + 19]
	li      1, $i6
	call    read_or_network.2727
.count stack_load
	load    [$sp + 19], $i3
	store   $i3, [$i1 + 0]
be_cont.35660:
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
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 20]
.count move_args
	mov     $ig0, $i2
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i4
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i4, [$i3 + 1]
.count stack_load
	load    [$sp + 20], $i4
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count move_ret
	mov     $i1, $i8
	store   $i8, [ext_dirvecs + 4]
	load    [ext_dirvecs + 4], $i4
	li      118, $i5
	call    create_dirvec_elements.3039
	li      3, $i4
	call    create_dirvecs.3042
	li      0, $i1
	li      0, $i5
	li      4, $i6
	li      9, $i2
	call    ext_float_of_int
.count move_ret
	mov     $f1, $f12
	fmul    $f12, $fc12, $f12
	fsub    $f12, $fc11, $f4
.count move_args
	mov     $i6, $i2
	call    calc_dirvecs.3028
	li      8, $i1
	li      2, $i5
	li      4, $i6
	call    calc_dirvec_rows.3033
	load    [ext_dirvecs + 4], $i4
	li      119, $i5
	call    init_dirvec_constants.3044
	li      3, $i4
	call    init_vecset_constants.3047
	li      ext_light_dirvec, $i4
	load    [ext_light_dirvec + 0], $i5
	store   $fg12, [$i5 + 0]
	store   $fg13, [$i5 + 1]
	store   $fg14, [$i5 + 2]
	sub     $ig0, 1, $i6
	bl      $i6, 0, bge_cont.35661
bge_then.35661:
	load    [ext_light_dirvec + 1], $i7
	load    [ext_objects + $i6], $i8
	load    [$i8 + 1], $i9
.count move_args
	mov     $f0, $f2
	bne     $i9, 1, be_else.35662
be_then.35662:
	li      6, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i5 + 0], $f9
	bne     $f9, $f0, be_else.35663
be_then.35663:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35663
be_else.35663:
	load    [$i8 + 6], $i13
	bg      $f0, $f9, ble_else.35664
ble_then.35664:
	li      0, $i14
.count b_cont
	b       ble_cont.35664
ble_else.35664:
	li      1, $i14
ble_cont.35664:
	bne     $i13, 0, be_else.35665
be_then.35665:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35665
be_else.35665:
	bne     $i14, 0, be_else.35666
be_then.35666:
	li      1, $i13
.count b_cont
	b       be_cont.35666
be_else.35666:
	li      0, $i13
be_cont.35666:
be_cont.35665:
	load    [$i8 + 4], $i14
	load    [$i14 + 0], $f9
	bne     $i13, 0, be_else.35667
be_then.35667:
	fneg    $f9, $f9
	store   $f9, [$i12 + 0]
	load    [$i5 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
.count b_cont
	b       be_cont.35667
be_else.35667:
	store   $f9, [$i12 + 0]
	load    [$i5 + 0], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 1]
be_cont.35667:
be_cont.35663:
	load    [$i5 + 1], $f9
	bne     $f9, $f0, be_else.35668
be_then.35668:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35668
be_else.35668:
	load    [$i8 + 6], $i13
	bg      $f0, $f9, ble_else.35669
ble_then.35669:
	li      0, $i14
.count b_cont
	b       ble_cont.35669
ble_else.35669:
	li      1, $i14
ble_cont.35669:
	bne     $i13, 0, be_else.35670
be_then.35670:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35670
be_else.35670:
	bne     $i14, 0, be_else.35671
be_then.35671:
	li      1, $i13
.count b_cont
	b       be_cont.35671
be_else.35671:
	li      0, $i13
be_cont.35671:
be_cont.35670:
	load    [$i8 + 4], $i14
	load    [$i14 + 1], $f9
	bne     $i13, 0, be_else.35672
be_then.35672:
	fneg    $f9, $f9
	store   $f9, [$i12 + 2]
	load    [$i5 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
.count b_cont
	b       be_cont.35672
be_else.35672:
	store   $f9, [$i12 + 2]
	load    [$i5 + 1], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 3]
be_cont.35672:
be_cont.35668:
	load    [$i5 + 2], $f9
	bne     $f9, $f0, be_else.35673
be_then.35673:
	store   $f0, [$i12 + 5]
.count storer
	add     $i7, $i6, $tmp
	store   $i12, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35662
be_else.35673:
	load    [$i8 + 6], $i13
	load    [$i8 + 4], $i14
	bg      $f0, $f9, ble_else.35674
ble_then.35674:
	li      0, $i15
.count b_cont
	b       ble_cont.35674
ble_else.35674:
	li      1, $i15
ble_cont.35674:
	bne     $i13, 0, be_else.35675
be_then.35675:
	mov     $i15, $i13
.count b_cont
	b       be_cont.35675
be_else.35675:
	bne     $i15, 0, be_else.35676
be_then.35676:
	li      1, $i13
.count b_cont
	b       be_cont.35676
be_else.35676:
	li      0, $i13
be_cont.35676:
be_cont.35675:
	load    [$i14 + 2], $f9
.count storer
	add     $i7, $i6, $tmp
	bne     $i13, 0, be_else.35677
be_then.35677:
	fneg    $f9, $f9
	store   $f9, [$i12 + 4]
	load    [$i5 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35662
be_else.35677:
	store   $f9, [$i12 + 4]
	load    [$i5 + 2], $f9
	finv    $f9, $f9
	store   $f9, [$i12 + 5]
	store   $i12, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35662
be_else.35662:
	bne     $i9, 2, be_else.35678
be_then.35678:
	li      4, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i8 + 4], $i13
	load    [$i8 + 4], $i14
	load    [$i8 + 4], $i15
	load    [$i5 + 0], $f9
	load    [$i13 + 0], $f10
	fmul    $f9, $f10, $f9
	load    [$i5 + 1], $f10
	load    [$i14 + 1], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	load    [$i5 + 2], $f10
	load    [$i15 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f9, $f10, $f9
	sub     $i6, 1, $i5
.count storer
	add     $i7, $i6, $tmp
	bg      $f9, $f0, ble_else.35679
ble_then.35679:
	store   $f0, [$i12 + 0]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35678
ble_else.35679:
	finv    $f9, $f9
	fneg    $f9, $f10
	store   $f10, [$i12 + 0]
	load    [$i8 + 4], $i13
	load    [$i13 + 0], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 1]
	load    [$i8 + 4], $i13
	load    [$i13 + 1], $f10
	fmul_n  $f10, $f9, $f10
	store   $f10, [$i12 + 2]
	load    [$i8 + 4], $i13
	load    [$i13 + 2], $f10
	fmul_n  $f10, $f9, $f9
	store   $f9, [$i12 + 3]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35678
be_else.35678:
	li      5, $i2
	call    ext_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i8 + 3], $i13
	load    [$i8 + 4], $i14
	load    [$i8 + 4], $i15
	load    [$i8 + 4], $i16
	load    [$i5 + 0], $f9
	load    [$i5 + 1], $f10
	load    [$i5 + 2], $f11
	fmul    $f9, $f9, $f12
	load    [$i14 + 0], $f13
	fmul    $f12, $f13, $f12
	fmul    $f10, $f10, $f13
	load    [$i15 + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f11, $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	bne     $i13, 0, be_else.35680
be_then.35680:
	mov     $f12, $f9
.count b_cont
	b       be_cont.35680
be_else.35680:
	fmul    $f10, $f11, $f13
	load    [$i8 + 9], $i14
	load    [$i14 + 0], $f14
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	fmul    $f11, $f9, $f11
	load    [$i8 + 9], $i14
	load    [$i14 + 1], $f13
	fmul    $f11, $f13, $f11
	fadd    $f12, $f11, $f11
	fmul    $f9, $f10, $f9
	load    [$i8 + 9], $i14
	load    [$i14 + 2], $f10
	fmul    $f9, $f10, $f9
	fadd    $f11, $f9, $f9
be_cont.35680:
	store   $f9, [$i12 + 0]
	load    [$i8 + 4], $i14
	load    [$i8 + 4], $i15
	load    [$i8 + 4], $i16
	load    [$i5 + 0], $f10
	load    [$i14 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i5 + 1], $f11
	load    [$i15 + 1], $f12
	fmul    $f11, $f12, $f12
	load    [$i5 + 2], $f13
	load    [$i16 + 2], $f14
	fmul    $f13, $f14, $f14
	fneg    $f10, $f10
	fneg    $f12, $f12
	fneg    $f14, $f14
.count storer
	add     $i7, $i6, $tmp
	bne     $i13, 0, be_else.35681
be_then.35681:
	store   $f10, [$i12 + 1]
	store   $f12, [$i12 + 2]
	store   $f14, [$i12 + 3]
	sub     $i6, 1, $i5
	bne     $f9, $f0, be_else.35682
be_then.35682:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35681
be_else.35682:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35681
be_else.35681:
	load    [$i8 + 9], $i13
	load    [$i8 + 9], $i14
	load    [$i13 + 1], $f15
	fmul    $f13, $f15, $f13
	load    [$i14 + 2], $f16
	fmul    $f11, $f16, $f11
	fadd    $f13, $f11, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f10, $f11, $f10
	store   $f10, [$i12 + 1]
	load    [$i8 + 9], $i13
	load    [$i5 + 2], $f10
	load    [$i13 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i5 + 0], $f13
	fmul    $f13, $f16, $f13
	fadd    $f10, $f13, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f12, $f10, $f10
	store   $f10, [$i12 + 2]
	load    [$i5 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [$i5 + 0], $f11
	fmul    $f11, $f15, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $fc3, $f10
	fsub    $f14, $f10, $f10
	store   $f10, [$i12 + 3]
	sub     $i6, 1, $i5
	bne     $f9, $f0, be_else.35683
be_then.35683:
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.35683
be_else.35683:
	finv    $f9, $f9
	store   $f9, [$i12 + 4]
	store   $i12, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.35683:
be_cont.35681:
be_cont.35678:
be_cont.35662:
bge_cont.35661:
	sub     $ig0, 1, $i4
	call    setup_reflections.3064
	li      0, $i1
	li      127, $i5
	add     $i0, -64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f4
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg19, $f5
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg20, $f6
.count stack_load
	load    [$sp + 2], $i34
.count move_args
	mov     $i1, $i6
.count move_args
	mov     $i34, $i1
	call    pretrace_pixels.2983
	li      0, $i1
	li      2, $i8
.count stack_load
	load    [$sp + 1], $i5
.count stack_load
	load    [$sp + 3], $i7
.count move_args
	mov     $i34, $i6
	call    scan_line.3000
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 21, $sp
	li      0, $tmp
	ret
.end main
