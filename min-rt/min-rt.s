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
# [$i1 - $i13]
# [$f1 - $f17]
# []
# []
######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
	sub     $sp, 18, $sp
.count stack_store
	store   $ra, [$sp + 0]
	call    ext_read_int
	bne     $i1, -1, be_else.32531
be_then.32531:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      0, $i1
	ret
be_else.32531:
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	mov     $i1, $i7
	call    ext_read_int
.count stack_store
	store   $i1, [$sp + 2]
	call    ext_read_int
	mov     $i1, $i8
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 3]
	call    ext_read_float
.count stack_load
	load    [$sp + 3], $i9
	store   $f1, [$i9 + 0]
	call    ext_read_float
	store   $f1, [$i9 + 1]
	call    ext_read_float
	store   $f1, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 4]
	call    ext_read_float
.count stack_load
	load    [$sp + 4], $i10
	store   $f1, [$i10 + 0]
	call    ext_read_float
	store   $f1, [$i10 + 1]
	call    ext_read_float
	store   $f1, [$i10 + 2]
	call    ext_read_float
.count stack_store
	store   $f1, [$sp + 5]
	li      2, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 6]
	call    ext_read_float
.count stack_load
	load    [$sp + 6], $i11
	store   $f1, [$i11 + 0]
	call    ext_read_float
	store   $f1, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 7]
	call    ext_read_float
.count stack_load
	load    [$sp + 7], $i12
	store   $f1, [$i12 + 0]
	call    ext_read_float
	store   $f1, [$i12 + 1]
	call    ext_read_float
	store   $f1, [$i12 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 8]
	be      $i8, 0, bne_cont.32532
bne_then.32532:
	call    ext_read_float
.count load_float
	load    [f.31927], $f2
	fmul    $f1, $f2, $f1
.count stack_load
	load    [$sp + 8], $i13
	store   $f1, [$i13 + 0]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i13 + 1]
	call    ext_read_float
	fmul    $f1, $f2, $f1
	store   $f1, [$i13 + 2]
bne_cont.32532:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 5], $f1
	bg      $f0, $f1, ble_else.32533
ble_then.32533:
	li      0, $i2
.count b_cont
	b       ble_cont.32533
ble_else.32533:
	li      1, $i2
ble_cont.32533:
	bne     $i7, 2, be_else.32534
be_then.32534:
	li      1, $i3
.count b_cont
	b       be_cont.32534
be_else.32534:
	mov     $i2, $i3
be_cont.32534:
	mov     $hp, $i4
	add     $hp, 11, $hp
	store   $i1, [$i4 + 10]
.count stack_load
	load    [$sp + 8], $i1
	store   $i1, [$i4 + 9]
	store   $i12, [$i4 + 8]
	store   $i11, [$i4 + 7]
	store   $i3, [$i4 + 6]
	store   $i10, [$i4 + 5]
	store   $i9, [$i4 + 4]
	store   $i8, [$i4 + 3]
.count stack_load
	load    [$sp + 2], $i3
	store   $i3, [$i4 + 2]
	store   $i7, [$i4 + 1]
.count stack_load
	load    [$sp + 1], $i3
	store   $i3, [$i4 + 0]
	store   $i4, [ext_objects + $i6]
	bne     $i7, 3, be_else.32535
be_then.32535:
	load    [$i9 + 0], $f1
	bne     $f1, $f0, be_else.32536
be_then.32536:
	mov     $f0, $f1
.count b_cont
	b       be_cont.32536
be_else.32536:
	bne     $f1, $f0, be_else.32537
be_then.32537:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.32537
be_else.32537:
	bg      $f1, $f0, ble_else.32538
ble_then.32538:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.32538
ble_else.32538:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.32538:
be_cont.32537:
be_cont.32536:
	store   $f1, [$i9 + 0]
	load    [$i9 + 1], $f1
	bne     $f1, $f0, be_else.32539
be_then.32539:
	mov     $f0, $f1
.count b_cont
	b       be_cont.32539
be_else.32539:
	bne     $f1, $f0, be_else.32540
be_then.32540:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.32540
be_else.32540:
	bg      $f1, $f0, ble_else.32541
ble_then.32541:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.32541
ble_else.32541:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.32541:
be_cont.32540:
be_cont.32539:
	store   $f1, [$i9 + 1]
	load    [$i9 + 2], $f1
	bne     $f1, $f0, be_else.32542
be_then.32542:
	mov     $f0, $f1
.count b_cont
	b       be_cont.32542
be_else.32542:
	bne     $f1, $f0, be_else.32543
be_then.32543:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
	mov     $f0, $f1
.count b_cont
	b       be_cont.32543
be_else.32543:
	bg      $f1, $f0, ble_else.32544
ble_then.32544:
	fmul    $f1, $f1, $f1
	finv_n  $f1, $f1
.count b_cont
	b       ble_cont.32544
ble_else.32544:
	fmul    $f1, $f1, $f1
	finv    $f1, $f1
ble_cont.32544:
be_cont.32543:
be_cont.32542:
	store   $f1, [$i9 + 2]
	bne     $i8, 0, be_else.32545
be_then.32545:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      1, $i1
	ret
be_else.32545:
	load    [$i1 + 0], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 9]
	load    [$i1 + 0], $f2
	call    ext_sin
	mov     $f1, $f9
	load    [$i1 + 1], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 10]
	load    [$i1 + 1], $f2
	call    ext_sin
	mov     $f1, $f10
	load    [$i1 + 2], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 11]
	load    [$i1 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
.count stack_load
	load    [$sp - 7], $f2
.count stack_load
	load    [$sp - 8], $f3
	fmul    $f3, $f2, $f4
	fmul    $f4, $f4, $f5
	load    [$i9 + 0], $f6
	fmul    $f6, $f5, $f5
	fmul    $f3, $f1, $f7
	fmul    $f7, $f7, $f8
	load    [$i9 + 1], $f11
	fmul    $f11, $f8, $f8
	fadd    $f5, $f8, $f5
	fneg    $f10, $f8
	fmul    $f8, $f8, $f12
	load    [$i9 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f5, $f12, $f5
	store   $f5, [$i9 + 0]
	fmul    $f9, $f10, $f5
	fmul    $f5, $f2, $f12
.count stack_load
	load    [$sp - 9], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f6, $f15, $f15
	fmul    $f5, $f1, $f5
	fmul    $f14, $f2, $f16
	fadd    $f5, $f16, $f5
	fmul    $f5, $f5, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f3, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i9 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f2, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f6, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f2, $f2
	fsub    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	fmul    $f11, $f2, $f2
	fadd    $f17, $f2, $f2
	fmul    $f14, $f3, $f3
	fmul    $f3, $f3, $f9
	fmul    $f13, $f9, $f9
	fadd    $f2, $f9, $f2
	store   $f2, [$i9 + 2]
	fmul    $f6, $f12, $f2
	fmul    $f2, $f15, $f2
	fmul    $f11, $f5, $f9
	fmul    $f9, $f1, $f9
	fadd    $f2, $f9, $f2
	fmul    $f13, $f16, $f9
	fmul    $f9, $f3, $f9
	fadd    $f2, $f9, $f2
	fmul    $fc10, $f2, $f2
	store   $f2, [$i1 + 0]
	fmul    $f6, $f4, $f2
	fmul    $f2, $f15, $f4
	fmul    $f11, $f7, $f6
	fmul    $f6, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f13, $f8, $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 1]
	fmul    $f2, $f12, $f1
	fmul    $f6, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 2]
	li      1, $i1
	ret
be_else.32535:
	bne     $i7, 2, be_else.32546
be_then.32546:
	load    [$i9 + 0], $f1
	bne     $i2, 0, be_else.32547
be_then.32547:
	li      1, $i2
.count b_cont
	b       be_cont.32547
be_else.32547:
	li      0, $i2
be_cont.32547:
	fmul    $f1, $f1, $f2
	load    [$i9 + 1], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	load    [$i9 + 2], $f3
	fmul    $f3, $f3, $f3
	fadd    $f2, $f3, $f2
	fsqrt   $f2, $f2
	bne     $f2, $f0, be_else.32548
be_then.32548:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.32548
be_else.32548:
	bne     $i2, 0, be_else.32549
be_then.32549:
	finv    $f2, $f2
.count b_cont
	b       be_cont.32549
be_else.32549:
	finv_n  $f2, $f2
be_cont.32549:
be_cont.32548:
	fmul    $f1, $f2, $f1
	store   $f1, [$i9 + 0]
	load    [$i9 + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i9 + 1]
	load    [$i9 + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [$i9 + 2]
	bne     $i8, 0, be_else.32550
be_then.32550:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      1, $i1
	ret
be_else.32550:
	load    [$i1 + 0], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 12]
	load    [$i1 + 0], $f2
	call    ext_sin
	mov     $f1, $f9
	load    [$i1 + 1], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 13]
	load    [$i1 + 1], $f2
	call    ext_sin
	mov     $f1, $f10
	load    [$i1 + 2], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 14]
	load    [$i1 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 5], $f3
	fmul    $f3, $f2, $f4
	fmul    $f4, $f4, $f5
	load    [$i9 + 0], $f6
	fmul    $f6, $f5, $f5
	fmul    $f3, $f1, $f7
	fmul    $f7, $f7, $f8
	load    [$i9 + 1], $f11
	fmul    $f11, $f8, $f8
	fadd    $f5, $f8, $f5
	fneg    $f10, $f8
	fmul    $f8, $f8, $f12
	load    [$i9 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f5, $f12, $f5
	store   $f5, [$i9 + 0]
	fmul    $f9, $f10, $f5
	fmul    $f5, $f2, $f12
.count stack_load
	load    [$sp - 6], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f6, $f15, $f15
	fmul    $f5, $f1, $f5
	fmul    $f14, $f2, $f16
	fadd    $f5, $f16, $f5
	fmul    $f5, $f5, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f3, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i9 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f2, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f6, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f2, $f2
	fsub    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	fmul    $f11, $f2, $f2
	fadd    $f17, $f2, $f2
	fmul    $f14, $f3, $f3
	fmul    $f3, $f3, $f9
	fmul    $f13, $f9, $f9
	fadd    $f2, $f9, $f2
	store   $f2, [$i9 + 2]
	fmul    $f6, $f12, $f2
	fmul    $f2, $f15, $f2
	fmul    $f11, $f5, $f9
	fmul    $f9, $f1, $f9
	fadd    $f2, $f9, $f2
	fmul    $f13, $f16, $f9
	fmul    $f9, $f3, $f9
	fadd    $f2, $f9, $f2
	fmul    $fc10, $f2, $f2
	store   $f2, [$i1 + 0]
	fmul    $f6, $f4, $f2
	fmul    $f2, $f15, $f4
	fmul    $f11, $f7, $f6
	fmul    $f6, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f13, $f8, $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 1]
	fmul    $f2, $f12, $f1
	fmul    $f6, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 2]
	li      1, $i1
	ret
be_else.32546:
	bne     $i8, 0, be_else.32551
be_then.32551:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      1, $i1
	ret
be_else.32551:
	load    [$i1 + 0], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 15]
	load    [$i1 + 0], $f2
	call    ext_sin
	mov     $f1, $f9
	load    [$i1 + 1], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 16]
	load    [$i1 + 1], $f2
	call    ext_sin
	mov     $f1, $f10
	load    [$i1 + 2], $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 17]
	load    [$i1 + 2], $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
.count stack_load
	load    [$sp - 1], $f2
.count stack_load
	load    [$sp - 2], $f3
	fmul    $f3, $f2, $f4
	fmul    $f4, $f4, $f5
	load    [$i9 + 0], $f6
	fmul    $f6, $f5, $f5
	fmul    $f3, $f1, $f7
	fmul    $f7, $f7, $f8
	load    [$i9 + 1], $f11
	fmul    $f11, $f8, $f8
	fadd    $f5, $f8, $f5
	fneg    $f10, $f8
	fmul    $f8, $f8, $f12
	load    [$i9 + 2], $f13
	fmul    $f13, $f12, $f12
	fadd    $f5, $f12, $f5
	store   $f5, [$i9 + 0]
	fmul    $f9, $f10, $f5
	fmul    $f5, $f2, $f12
.count stack_load
	load    [$sp - 3], $f14
	fmul    $f14, $f1, $f15
	fsub    $f12, $f15, $f12
	fmul    $f12, $f12, $f15
	fmul    $f6, $f15, $f15
	fmul    $f5, $f1, $f5
	fmul    $f14, $f2, $f16
	fadd    $f5, $f16, $f5
	fmul    $f5, $f5, $f16
	fmul    $f11, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f9, $f3, $f16
	fmul    $f16, $f16, $f17
	fmul    $f13, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i9 + 1]
	fmul    $f14, $f10, $f10
	fmul    $f10, $f2, $f15
	fmul    $f9, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f6, $f17, $f17
	fmul    $f10, $f1, $f1
	fmul    $f9, $f2, $f2
	fsub    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	fmul    $f11, $f2, $f2
	fadd    $f17, $f2, $f2
	fmul    $f14, $f3, $f3
	fmul    $f3, $f3, $f9
	fmul    $f13, $f9, $f9
	fadd    $f2, $f9, $f2
	store   $f2, [$i9 + 2]
	fmul    $f6, $f12, $f2
	fmul    $f2, $f15, $f2
	fmul    $f11, $f5, $f9
	fmul    $f9, $f1, $f9
	fadd    $f2, $f9, $f2
	fmul    $f13, $f16, $f9
	fmul    $f9, $f3, $f9
	fadd    $f2, $f9, $f2
	fmul    $fc10, $f2, $f2
	store   $f2, [$i1 + 0]
	fmul    $f6, $f4, $f2
	fmul    $f2, $f15, $f4
	fmul    $f11, $f7, $f6
	fmul    $f6, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f13, $f8, $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 1]
	fmul    $f2, $f12, $f1
	fmul    $f6, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i1 + 2]
	li      1, $i1
	ret
.end read_nth_object

######################################################################
# read_object($i14)
# $ra = $ra
# [$i1 - $i14]
# [$f1 - $f17]
# [$ig0]
# []
######################################################################
.begin read_object
read_object.2721:
	bl      $i14, 60, bge_else.32552
bge_then.32552:
	ret
bge_else.32552:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32553
be_then.32553:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32553:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32554
bge_then.32554:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32554:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32555
be_then.32555:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32555:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32556
bge_then.32556:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32556:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32557
be_then.32557:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32557:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32558
bge_then.32558:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32558:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32559
be_then.32559:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32559:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32560
bge_then.32560:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32560:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32561
be_then.32561:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32561:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32562
bge_then.32562:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32562:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32563
be_then.32563:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32563:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32564
bge_then.32564:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32564:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.32565
be_then.32565:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	mov     $i14, $ig0
	ret
be_else.32565:
	add     $i14, 1, $i14
	bl      $i14, 60, bge_else.32566
bge_then.32566:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.32566:
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.32567
be_then.32567:
	mov     $i14, $ig0
	ret
be_else.32567:
	add     $i14, 1, $i14
	b       read_object.2721
.end read_object

######################################################################
# $i1 = read_net_item($i50)
# $ra = $ra
# [$i1 - $i5, $i21, $i33, $i45, $i49 - $i50]
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
	bne     $i1, -1, be_else.32568
be_then.32568:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	add     $i50, 1, $i2
	add     $i0, -1, $i3
	b       ext_create_array_int
be_else.32568:
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	mov     $i1, $i33
	add     $i50, 1, $i45
	bne     $i33, -1, be_else.32569
be_then.32569:
	add     $i45, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i50, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.32569:
	call    ext_read_int
	add     $i45, 1, $i49
	bne     $i1, -1, be_else.32570
be_then.32570:
	add     $i49, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $i1, $i45, $tmp
	store   $i33, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i50, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.32570:
.count stack_store
	store   $i1, [$sp + 2]
	call    ext_read_int
	mov     $i1, $i4
	add     $i49, 1, $i21
	bne     $i4, -1, be_else.32571
be_then.32571:
	add     $i21, 1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i2
.count storer
	add     $i1, $i49, $tmp
	store   $i2, [$tmp + 0]
.count storer
	add     $i1, $i45, $tmp
	store   $i33, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $i2
.count storer
	add     $i1, $i50, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.32571:
.count stack_store
	store   $i50, [$sp + 3]
.count stack_store
	store   $i45, [$sp + 4]
.count stack_store
	store   $i33, [$sp + 5]
.count stack_store
	store   $i49, [$sp + 6]
.count stack_store
	store   $i21, [$sp + 7]
.count stack_store
	store   $i4, [$sp + 8]
	add     $i21, 1, $i50
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
	load    [$sp - 7], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 5], $i2
.count stack_load
	load    [$sp - 4], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 6], $i2
.count stack_load
	load    [$sp - 8], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret
.end read_net_item

######################################################################
# $i1 = read_or_network($i30)
# $ra = $ra
# [$i1 - $i6, $i21, $i30, $i33, $i41, $i45, $i49 - $i50]
# []
# []
# []
######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
	call    ext_read_int
	bne     $i1, -1, be_else.32572
be_then.32572:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32572
be_else.32572:
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	mov     $i1, $i6
	bne     $i6, -1, be_else.32573
be_then.32573:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32573
be_else.32573:
	call    ext_read_int
	bne     $i1, -1, be_else.32574
be_then.32574:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
	store   $i6, [$i1 + 1]
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32574
be_else.32574:
.count stack_store
	store   $i1, [$sp + 2]
	li      3, $i50
	call    read_net_item.2725
.count stack_load
	load    [$sp + 2], $i2
	store   $i2, [$i1 + 2]
	store   $i6, [$i1 + 1]
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
be_cont.32574:
be_cont.32573:
be_cont.32572:
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.32575
be_then.32575:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	add     $i30, 1, $i2
.count move_args
	mov     $i1, $i3
	b       ext_create_array_int
be_else.32575:
.count stack_store
	store   $i1, [$sp + 3]
	call    ext_read_int
	mov     $i1, $i6
	bne     $i6, -1, be_else.32576
be_then.32576:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32576
be_else.32576:
	call    ext_read_int
	bne     $i1, -1, be_else.32577
be_then.32577:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
	store   $i6, [$i1 + 0]
.count b_cont
	b       be_cont.32577
be_else.32577:
.count stack_store
	store   $i1, [$sp + 4]
	li      2, $i50
	call    read_net_item.2725
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 1]
	store   $i6, [$i1 + 0]
be_cont.32577:
be_cont.32576:
	mov     $i1, $i41
	load    [$i41 + 0], $i1
	add     $i30, 1, $i45
	bne     $i1, -1, be_else.32578
be_then.32578:
	add     $i45, 1, $i2
.count move_args
	mov     $i41, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 5], $i2
.count storer
	add     $i1, $i30, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.32578:
.count stack_store
	store   $i30, [$sp + 5]
.count stack_store
	store   $i45, [$sp + 6]
.count stack_store
	store   $i41, [$sp + 7]
	add     $i45, 1, $i30
	call    read_or_network.2727
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
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
	ret
.end read_or_network

######################################################################
# read_and_network($i6)
# $ra = $ra
# [$i1 - $i7, $i21, $i33, $i45, $i49 - $i50]
# []
# []
# []
######################################################################
.begin read_and_network
read_and_network.2729:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
	call    ext_read_int
	bne     $i1, -1, be_else.32579
be_then.32579:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32579
be_else.32579:
.count stack_store
	store   $i1, [$sp + 1]
	call    ext_read_int
	mov     $i1, $i7
	bne     $i7, -1, be_else.32580
be_then.32580:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32580
be_else.32580:
	call    ext_read_int
	bne     $i1, -1, be_else.32581
be_then.32581:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32581
be_else.32581:
.count stack_store
	store   $i1, [$sp + 2]
	li      3, $i50
	call    read_net_item.2725
.count stack_load
	load    [$sp + 2], $i2
	store   $i2, [$i1 + 2]
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
be_cont.32581:
be_cont.32580:
be_cont.32579:
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.32582
be_then.32582:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
be_else.32582:
	store   $i1, [ext_and_net + $i6]
	call    ext_read_int
	bne     $i1, -1, be_else.32583
be_then.32583:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32583
be_else.32583:
.count stack_store
	store   $i1, [$sp + 3]
	call    ext_read_int
	mov     $i1, $i7
	bne     $i7, -1, be_else.32584
be_then.32584:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 3], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32584
be_else.32584:
	li      2, $i50
	call    read_net_item.2725
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 3], $i2
	store   $i2, [$i1 + 0]
be_cont.32584:
be_cont.32583:
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.32585
be_then.32585:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
be_else.32585:
	add     $i6, 1, $i6
	store   $i1, [ext_and_net + $i6]
	call    ext_read_int
	bne     $i1, -1, be_else.32586
be_then.32586:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32586
be_else.32586:
.count stack_store
	store   $i1, [$sp + 4]
	call    ext_read_int
	mov     $i1, $i7
	bne     $i7, -1, be_else.32587
be_then.32587:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32587
be_else.32587:
	call    ext_read_int
	bne     $i1, -1, be_else.32588
be_then.32588:
	li      3, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32588
be_else.32588:
.count stack_store
	store   $i1, [$sp + 5]
	li      3, $i50
	call    read_net_item.2725
.count stack_load
	load    [$sp + 5], $i2
	store   $i2, [$i1 + 2]
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 4], $i2
	store   $i2, [$i1 + 0]
be_cont.32588:
be_cont.32587:
be_cont.32586:
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.32589
be_then.32589:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
be_else.32589:
	add     $i6, 1, $i6
	store   $i1, [ext_and_net + $i6]
	call    ext_read_int
	bne     $i1, -1, be_else.32590
be_then.32590:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.32590
be_else.32590:
.count stack_store
	store   $i1, [$sp + 6]
	call    ext_read_int
	mov     $i1, $i7
	bne     $i7, -1, be_else.32591
be_then.32591:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 6], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.32591
be_else.32591:
	li      2, $i50
	call    read_net_item.2725
	store   $i7, [$i1 + 1]
.count stack_load
	load    [$sp + 6], $i2
	store   $i2, [$i1 + 0]
be_cont.32591:
be_cont.32590:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.32592
be_then.32592:
	ret
be_else.32592:
	add     $i6, 1, $i2
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
	bne     $i6, 1, be_else.32593
be_then.32593:
	bne     $f4, $f0, be_else.32594
be_then.32594:
	li      0, $i3
.count b_cont
	b       be_cont.32594
be_else.32594:
	load    [$i1 + 4], $i3
	load    [$i3 + 1], $f5
	load    [$i2 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.32595
ble_then.32595:
	li      0, $i5
.count b_cont
	b       ble_cont.32595
ble_else.32595:
	li      1, $i5
ble_cont.32595:
	bne     $i4, 0, be_else.32596
be_then.32596:
	mov     $i5, $i4
.count b_cont
	b       be_cont.32596
be_else.32596:
	bne     $i5, 0, be_else.32597
be_then.32597:
	li      1, $i4
.count b_cont
	b       be_cont.32597
be_else.32597:
	li      0, $i4
be_cont.32597:
be_cont.32596:
	load    [$i3 + 0], $f7
	bne     $i4, 0, be_cont.32598
be_then.32598:
	fneg    $f7, $f7
be_cont.32598:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.32599
ble_then.32599:
	li      0, $i3
.count b_cont
	b       ble_cont.32599
ble_else.32599:
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.32600
ble_then.32600:
	li      0, $i3
.count b_cont
	b       ble_cont.32600
ble_else.32600:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.32600:
ble_cont.32599:
be_cont.32594:
	bne     $i3, 0, be_else.32601
be_then.32601:
	load    [$i2 + 1], $f4
	bne     $f4, $f0, be_else.32602
be_then.32602:
	li      0, $i3
.count b_cont
	b       be_cont.32602
be_else.32602:
	load    [$i1 + 4], $i3
	load    [$i3 + 2], $f5
	load    [$i2 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.32603
ble_then.32603:
	li      0, $i5
.count b_cont
	b       ble_cont.32603
ble_else.32603:
	li      1, $i5
ble_cont.32603:
	bne     $i4, 0, be_else.32604
be_then.32604:
	mov     $i5, $i4
.count b_cont
	b       be_cont.32604
be_else.32604:
	bne     $i5, 0, be_else.32605
be_then.32605:
	li      1, $i4
.count b_cont
	b       be_cont.32605
be_else.32605:
	li      0, $i4
be_cont.32605:
be_cont.32604:
	load    [$i3 + 1], $f7
	bne     $i4, 0, be_cont.32606
be_then.32606:
	fneg    $f7, $f7
be_cont.32606:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.32607
ble_then.32607:
	li      0, $i3
.count b_cont
	b       ble_cont.32607
ble_else.32607:
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.32608
ble_then.32608:
	li      0, $i3
.count b_cont
	b       ble_cont.32608
ble_else.32608:
	mov     $f4, $fg0
	li      1, $i3
ble_cont.32608:
ble_cont.32607:
be_cont.32602:
	bne     $i3, 0, be_else.32609
be_then.32609:
	load    [$i2 + 2], $f4
	bne     $f4, $f0, be_else.32610
be_then.32610:
	li      0, $i1
	ret
be_else.32610:
	load    [$i1 + 4], $i3
	load    [$i1 + 6], $i1
	load    [$i3 + 0], $f5
	load    [$i2 + 0], $f6
	bg      $f0, $f4, ble_else.32611
ble_then.32611:
	li      0, $i4
.count b_cont
	b       ble_cont.32611
ble_else.32611:
	li      1, $i4
ble_cont.32611:
	bne     $i1, 0, be_else.32612
be_then.32612:
	mov     $i4, $i1
.count b_cont
	b       be_cont.32612
be_else.32612:
	bne     $i4, 0, be_else.32613
be_then.32613:
	li      1, $i1
.count b_cont
	b       be_cont.32613
be_else.32613:
	li      0, $i1
be_cont.32613:
be_cont.32612:
	load    [$i3 + 2], $f7
	bne     $i1, 0, be_cont.32614
be_then.32614:
	fneg    $f7, $f7
be_cont.32614:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.32615
ble_then.32615:
	li      0, $i1
	ret
ble_else.32615:
	load    [$i3 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.32616
ble_then.32616:
	li      0, $i1
	ret
ble_else.32616:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.32609:
	li      2, $i1
	ret
be_else.32601:
	li      1, $i1
	ret
be_else.32593:
	bne     $i6, 2, be_else.32617
be_then.32617:
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
	bg      $f4, $f0, ble_else.32618
ble_then.32618:
	li      0, $i1
	ret
ble_else.32618:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.32617:
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
	be      $i7, 0, bne_cont.32619
bne_then.32619:
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
bne_cont.32619:
	bne     $f7, $f0, be_else.32620
be_then.32620:
	li      0, $i1
	ret
be_else.32620:
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
	bne     $i2, 0, be_else.32621
be_then.32621:
	mov     $f9, $f4
.count b_cont
	b       be_cont.32621
be_else.32621:
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
be_cont.32621:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.32622
be_then.32622:
	mov     $f6, $f1
.count b_cont
	b       be_cont.32622
be_else.32622:
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
be_cont.32622:
	bne     $i6, 3, be_cont.32623
be_then.32623:
	fsub    $f1, $fc0, $f1
be_cont.32623:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.32624
ble_then.32624:
	li      0, $i1
	ret
ble_else.32624:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.32625
be_then.32625:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.32625:
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
	bne     $i7, 1, be_else.32626
be_then.32626:
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
	bg      $f4, $f5, ble_else.32627
ble_then.32627:
	li      0, $i4
.count b_cont
	b       ble_cont.32627
ble_else.32627:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.32628
ble_then.32628:
	li      0, $i4
.count b_cont
	b       ble_cont.32628
ble_else.32628:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.32629
be_then.32629:
	li      0, $i4
.count b_cont
	b       be_cont.32629
be_else.32629:
	li      1, $i4
be_cont.32629:
ble_cont.32628:
ble_cont.32627:
	bne     $i4, 0, be_else.32630
be_then.32630:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.32631
ble_then.32631:
	li      0, $i2
.count b_cont
	b       ble_cont.32631
ble_else.32631:
	load    [$i2 + 4], $i2
	load    [$i2 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.32632
ble_then.32632:
	li      0, $i2
.count b_cont
	b       ble_cont.32632
ble_else.32632:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.32633
be_then.32633:
	li      0, $i2
.count b_cont
	b       be_cont.32633
be_else.32633:
	li      1, $i2
be_cont.32633:
ble_cont.32632:
ble_cont.32631:
	bne     $i2, 0, be_else.32634
be_then.32634:
	load    [$i3 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.32635
ble_then.32635:
	li      0, $i1
	ret
ble_else.32635:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.32636
ble_then.32636:
	li      0, $i1
	ret
ble_else.32636:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.32637
be_then.32637:
	li      0, $i1
	ret
be_else.32637:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.32634:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.32630:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.32626:
	load    [$i1 + 0], $f4
	bne     $i7, 2, be_else.32638
be_then.32638:
	bg      $f0, $f4, ble_else.32639
ble_then.32639:
	li      0, $i1
	ret
ble_else.32639:
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
be_else.32638:
	bne     $f4, $f0, be_else.32640
be_then.32640:
	li      0, $i1
	ret
be_else.32640:
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
	bne     $i6, 0, be_else.32641
be_then.32641:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32641
be_else.32641:
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
be_cont.32641:
	bne     $i7, 3, be_cont.32642
be_then.32642:
	fsub    $f1, $fc0, $f1
be_cont.32642:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.32643
ble_then.32643:
	li      0, $i1
	ret
ble_else.32643:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.32644
be_then.32644:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	ret
be_else.32644:
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
	bne     $i6, 1, be_else.32645
be_then.32645:
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
	bg      $f4, $f5, ble_else.32646
ble_then.32646:
	li      0, $i4
.count b_cont
	b       ble_cont.32646
ble_else.32646:
	load    [$i3 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i2 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.32647
ble_then.32647:
	li      0, $i4
.count b_cont
	b       ble_cont.32647
ble_else.32647:
	load    [$i1 + 1], $f5
	bne     $f5, $f0, be_else.32648
be_then.32648:
	li      0, $i4
.count b_cont
	b       be_cont.32648
be_else.32648:
	li      1, $i4
be_cont.32648:
ble_cont.32647:
ble_cont.32646:
	bne     $i4, 0, be_else.32649
be_then.32649:
	load    [$i3 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i2 + 0], $f6
	load    [$i1 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i1 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.32650
ble_then.32650:
	li      0, $i3
.count b_cont
	b       ble_cont.32650
ble_else.32650:
	load    [$i3 + 4], $i3
	load    [$i3 + 2], $f6
	load    [$i2 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.32651
ble_then.32651:
	li      0, $i3
.count b_cont
	b       ble_cont.32651
ble_else.32651:
	load    [$i1 + 3], $f6
	bne     $f6, $f0, be_else.32652
be_then.32652:
	li      0, $i3
.count b_cont
	b       be_cont.32652
be_else.32652:
	li      1, $i3
be_cont.32652:
ble_cont.32651:
ble_cont.32650:
	bne     $i3, 0, be_else.32653
be_then.32653:
	load    [$i2 + 0], $f6
	load    [$i1 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i1 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.32654
ble_then.32654:
	li      0, $i1
	ret
ble_else.32654:
	load    [$i2 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.32655
ble_then.32655:
	li      0, $i1
	ret
ble_else.32655:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.32656
be_then.32656:
	li      0, $i1
	ret
be_else.32656:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.32653:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.32649:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.32645:
	bne     $i6, 2, be_else.32657
be_then.32657:
	load    [$i1 + 0], $f1
	bg      $f0, $f1, ble_else.32658
ble_then.32658:
	li      0, $i1
	ret
ble_else.32658:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.32657:
	load    [$i1 + 0], $f4
	bne     $f4, $f0, be_else.32659
be_then.32659:
	li      0, $i1
	ret
be_else.32659:
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
	bg      $f2, $f0, ble_else.32660
ble_then.32660:
	li      0, $i1
	ret
ble_else.32660:
	load    [$i3 + 6], $i2
	fsqrt   $f2, $f2
	bne     $i2, 0, be_else.32661
be_then.32661:
	fsub    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.32661:
	fadd    $f1, $f2, $f1
	load    [$i1 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants($i4, $i5)
# $ra = $ra
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i5, 0, bge_else.32662
bge_then.32662:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i4 + 1], $i6
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i1
	load    [$i4 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.32663
be_then.32663:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.32664
be_then.32664:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.32664
be_else.32664:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.32665
ble_then.32665:
	li      0, $i3
.count b_cont
	b       ble_cont.32665
ble_else.32665:
	li      1, $i3
ble_cont.32665:
	bne     $i2, 0, be_else.32666
be_then.32666:
	mov     $i3, $i2
.count b_cont
	b       be_cont.32666
be_else.32666:
	bne     $i3, 0, be_else.32667
be_then.32667:
	li      1, $i2
.count b_cont
	b       be_cont.32667
be_else.32667:
	li      0, $i2
be_cont.32667:
be_cont.32666:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.32668
be_then.32668:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.32668
be_else.32668:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.32668:
be_cont.32664:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.32669
be_then.32669:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.32669
be_else.32669:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.32670
ble_then.32670:
	li      0, $i3
.count b_cont
	b       ble_cont.32670
ble_else.32670:
	li      1, $i3
ble_cont.32670:
	bne     $i2, 0, be_else.32671
be_then.32671:
	mov     $i3, $i2
.count b_cont
	b       be_cont.32671
be_else.32671:
	bne     $i3, 0, be_else.32672
be_then.32672:
	li      1, $i2
.count b_cont
	b       be_cont.32672
be_else.32672:
	li      0, $i2
be_cont.32672:
be_cont.32671:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.32673
be_then.32673:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.32673
be_else.32673:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.32673:
be_cont.32669:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.32674
be_then.32674:
	store   $f0, [$i1 + 5]
.count b_cont
	b       be_cont.32674
be_else.32674:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.32675
ble_then.32675:
	li      0, $i3
.count b_cont
	b       ble_cont.32675
ble_else.32675:
	li      1, $i3
ble_cont.32675:
	bne     $i2, 0, be_else.32676
be_then.32676:
	mov     $i3, $i2
.count b_cont
	b       be_cont.32676
be_else.32676:
	bne     $i3, 0, be_else.32677
be_then.32677:
	li      1, $i2
.count b_cont
	b       be_cont.32677
be_else.32677:
	li      0, $i2
be_cont.32677:
be_cont.32676:
	load    [$i7 + 4], $i3
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_else.32678
be_then.32678:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count b_cont
	b       be_cont.32678
be_else.32678:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
be_cont.32678:
be_cont.32674:
.count storer
	add     $i6, $i5, $tmp
	store   $i1, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.32679
bge_then.32679:
	load    [ext_objects + $i5], $i7
	load    [$i7 + 1], $i1
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.32680
be_then.32680:
	li      6, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.32681
be_then.32681:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.32681
be_else.32681:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.32682
ble_then.32682:
	li      0, $i3
.count b_cont
	b       ble_cont.32682
ble_else.32682:
	li      1, $i3
ble_cont.32682:
	bne     $i2, 0, be_else.32683
be_then.32683:
	mov     $i3, $i2
.count b_cont
	b       be_cont.32683
be_else.32683:
	bne     $i3, 0, be_else.32684
be_then.32684:
	li      1, $i2
.count b_cont
	b       be_cont.32684
be_else.32684:
	li      0, $i2
be_cont.32684:
be_cont.32683:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.32685
be_then.32685:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.32685
be_else.32685:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.32685:
be_cont.32681:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.32686
be_then.32686:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.32686
be_else.32686:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.32687
ble_then.32687:
	li      0, $i3
.count b_cont
	b       ble_cont.32687
ble_else.32687:
	li      1, $i3
ble_cont.32687:
	bne     $i2, 0, be_else.32688
be_then.32688:
	mov     $i3, $i2
.count b_cont
	b       be_cont.32688
be_else.32688:
	bne     $i3, 0, be_else.32689
be_then.32689:
	li      1, $i2
.count b_cont
	b       be_cont.32689
be_else.32689:
	li      0, $i2
be_cont.32689:
be_cont.32688:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.32690
be_then.32690:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.32690
be_else.32690:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.32690:
be_cont.32686:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.32691
be_then.32691:
	store   $f0, [$i1 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i1, [$tmp + 0]
	sub     $i5, 1, $i5
	b       iter_setup_dirvec_constants.2826
be_else.32691:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.32692
ble_then.32692:
	li      0, $i7
.count b_cont
	b       ble_cont.32692
ble_else.32692:
	li      1, $i7
ble_cont.32692:
	bne     $i2, 0, be_else.32693
be_then.32693:
	mov     $i7, $i2
.count b_cont
	b       be_cont.32693
be_else.32693:
	bne     $i7, 0, be_else.32694
be_then.32694:
	li      1, $i2
.count b_cont
	b       be_cont.32694
be_else.32694:
	li      0, $i2
be_cont.32694:
be_cont.32693:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.32695
be_then.32695:
	fneg    $f1, $f1
be_cont.32695:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count storer
	add     $i6, $i5, $tmp
	store   $i1, [$tmp + 0]
	sub     $i5, 1, $i5
	b       iter_setup_dirvec_constants.2826
be_else.32680:
	bne     $i1, 2, be_else.32696
be_then.32696:
	li      4, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f1, $f0, ble_else.32697
ble_then.32697:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
ble_else.32697:
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
be_else.32696:
	li      5, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.32698
be_then.32698:
	mov     $f4, $f1
.count b_cont
	b       be_cont.32698
be_else.32698:
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
be_cont.32698:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i2, 0, be_else.32699
be_then.32699:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.32700
be_then.32700:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32700:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32699:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.32701
be_then.32701:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32701:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bge_else.32679:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32663:
	bne     $i1, 2, be_else.32702
be_then.32702:
	li      4, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bg      $f1, $f0, ble_else.32703
ble_then.32703:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
ble_else.32703:
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
be_else.32702:
	li      5, $i2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.32704
be_then.32704:
	mov     $f4, $f1
.count b_cont
	b       be_cont.32704
be_else.32704:
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
be_cont.32704:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i6, $i5, $tmp
	sub     $i5, 1, $i5
	bne     $i2, 0, be_else.32705
be_then.32705:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.32706
be_then.32706:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32706:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32705:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.32707
be_then.32707:
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
be_else.32707:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	b       iter_setup_dirvec_constants.2826
bge_else.32662:
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
	bl      $i1, 0, bge_else.32708
bge_then.32708:
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
	bne     $i4, 2, be_else.32709
be_then.32709:
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
be_else.32709:
	bg      $i4, 2, ble_else.32710
ble_then.32710:
	sub     $i1, 1, $i1
	b       setup_startp_constants.2831
ble_else.32710:
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
	bne     $i9, 0, be_else.32711
be_then.32711:
	mov     $f4, $f1
.count b_cont
	b       be_cont.32711
be_else.32711:
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
be_cont.32711:
	sub     $i1, 1, $i1
	bne     $i4, 3, be_else.32712
be_then.32712:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
be_else.32712:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
bge_else.32708:
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
	bne     $i2, -1, be_else.32713
be_then.32713:
	li      1, $i1
	ret
be_else.32713:
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
	bne     $i4, 1, be_else.32714
be_then.32714:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.32715
ble_then.32715:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32716
be_then.32716:
	li      1, $i2
.count b_cont
	b       be_cont.32714
be_else.32716:
	li      0, $i2
.count b_cont
	b       be_cont.32714
ble_else.32715:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.32717
ble_then.32717:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32718
be_then.32718:
	li      1, $i2
.count b_cont
	b       be_cont.32714
be_else.32718:
	li      0, $i2
.count b_cont
	b       be_cont.32714
ble_else.32717:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.32714
ble_then.32719:
	bne     $i2, 0, be_else.32720
be_then.32720:
	li      1, $i2
.count b_cont
	b       be_cont.32714
be_else.32720:
	li      0, $i2
.count b_cont
	b       be_cont.32714
be_else.32714:
	bne     $i4, 2, be_else.32721
be_then.32721:
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
	bg      $f0, $f1, ble_else.32722
ble_then.32722:
	bne     $i4, 0, be_else.32723
be_then.32723:
	li      1, $i2
.count b_cont
	b       be_cont.32721
be_else.32723:
	li      0, $i2
.count b_cont
	b       be_cont.32721
ble_else.32722:
	bne     $i4, 0, be_else.32724
be_then.32724:
	li      0, $i2
.count b_cont
	b       be_cont.32721
be_else.32724:
	li      1, $i2
.count b_cont
	b       be_cont.32721
be_else.32721:
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
	bne     $i6, 0, be_else.32725
be_then.32725:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32725
be_else.32725:
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
be_cont.32725:
	bne     $i4, 3, be_cont.32726
be_then.32726:
	fsub    $f1, $fc0, $f1
be_cont.32726:
	bg      $f0, $f1, ble_else.32727
ble_then.32727:
	bne     $i5, 0, be_else.32728
be_then.32728:
	li      1, $i2
.count b_cont
	b       ble_cont.32727
be_else.32728:
	li      0, $i2
.count b_cont
	b       ble_cont.32727
ble_else.32727:
	bne     $i5, 0, be_else.32729
be_then.32729:
	li      0, $i2
.count b_cont
	b       be_cont.32729
be_else.32729:
	li      1, $i2
be_cont.32729:
ble_cont.32727:
be_cont.32721:
be_cont.32714:
	bne     $i2, 0, be_else.32730
be_then.32730:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.32731
be_then.32731:
	li      1, $i1
	ret
be_else.32731:
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
	bne     $i7, 1, be_else.32732
be_then.32732:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.32733
ble_then.32733:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32734
be_then.32734:
	li      1, $i2
.count b_cont
	b       be_cont.32732
be_else.32734:
	li      0, $i2
.count b_cont
	b       be_cont.32732
ble_else.32733:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.32735
ble_then.32735:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32736
be_then.32736:
	li      1, $i2
.count b_cont
	b       be_cont.32732
be_else.32736:
	li      0, $i2
.count b_cont
	b       be_cont.32732
ble_else.32735:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.32732
ble_then.32737:
	bne     $i2, 0, be_else.32738
be_then.32738:
	li      1, $i2
.count b_cont
	b       be_cont.32732
be_else.32738:
	li      0, $i2
.count b_cont
	b       be_cont.32732
be_else.32732:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.32739
be_then.32739:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.32740
ble_then.32740:
	bne     $i4, 0, be_else.32741
be_then.32741:
	li      1, $i2
.count b_cont
	b       be_cont.32739
be_else.32741:
	li      0, $i2
.count b_cont
	b       be_cont.32739
ble_else.32740:
	bne     $i4, 0, be_else.32742
be_then.32742:
	li      0, $i2
.count b_cont
	b       be_cont.32739
be_else.32742:
	li      1, $i2
.count b_cont
	b       be_cont.32739
be_else.32739:
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
	bne     $i9, 0, be_else.32743
be_then.32743:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32743
be_else.32743:
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
be_cont.32743:
	bne     $i5, 3, be_cont.32744
be_then.32744:
	fsub    $f1, $fc0, $f1
be_cont.32744:
	bg      $f0, $f1, ble_else.32745
ble_then.32745:
	bne     $i4, 0, be_else.32746
be_then.32746:
	li      1, $i2
.count b_cont
	b       ble_cont.32745
be_else.32746:
	li      0, $i2
.count b_cont
	b       ble_cont.32745
ble_else.32745:
	bne     $i4, 0, be_else.32747
be_then.32747:
	li      0, $i2
.count b_cont
	b       be_cont.32747
be_else.32747:
	li      1, $i2
be_cont.32747:
ble_cont.32745:
be_cont.32739:
be_cont.32732:
	bne     $i2, 0, be_else.32748
be_then.32748:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.32749
be_then.32749:
	li      1, $i1
	ret
be_else.32749:
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
	bne     $i4, 1, be_else.32750
be_then.32750:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.32751
ble_then.32751:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32752
be_then.32752:
	li      1, $i2
.count b_cont
	b       be_cont.32750
be_else.32752:
	li      0, $i2
.count b_cont
	b       be_cont.32750
ble_else.32751:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.32753
ble_then.32753:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.32754
be_then.32754:
	li      1, $i2
.count b_cont
	b       be_cont.32750
be_else.32754:
	li      0, $i2
.count b_cont
	b       be_cont.32750
ble_else.32753:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.32750
ble_then.32755:
	bne     $i2, 0, be_else.32756
be_then.32756:
	li      1, $i2
.count b_cont
	b       be_cont.32750
be_else.32756:
	li      0, $i2
.count b_cont
	b       be_cont.32750
be_else.32750:
	bne     $i4, 2, be_else.32757
be_then.32757:
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
	bg      $f0, $f1, ble_else.32758
ble_then.32758:
	bne     $i4, 0, be_else.32759
be_then.32759:
	li      1, $i2
.count b_cont
	b       be_cont.32757
be_else.32759:
	li      0, $i2
.count b_cont
	b       be_cont.32757
ble_else.32758:
	bne     $i4, 0, be_else.32760
be_then.32760:
	li      0, $i2
.count b_cont
	b       be_cont.32757
be_else.32760:
	li      1, $i2
.count b_cont
	b       be_cont.32757
be_else.32757:
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
	bne     $i6, 0, be_else.32761
be_then.32761:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32761
be_else.32761:
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
be_cont.32761:
	bne     $i5, 3, be_cont.32762
be_then.32762:
	fsub    $f1, $fc0, $f1
be_cont.32762:
	bg      $f0, $f1, ble_else.32763
ble_then.32763:
	bne     $i4, 0, be_else.32764
be_then.32764:
	li      1, $i2
.count b_cont
	b       ble_cont.32763
be_else.32764:
	li      0, $i2
.count b_cont
	b       ble_cont.32763
ble_else.32763:
	bne     $i4, 0, be_else.32765
be_then.32765:
	li      0, $i2
.count b_cont
	b       be_cont.32765
be_else.32765:
	li      1, $i2
be_cont.32765:
ble_cont.32763:
be_cont.32757:
be_cont.32750:
	bne     $i2, 0, be_else.32766
be_then.32766:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.32767
be_then.32767:
	li      1, $i1
	ret
be_else.32767:
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
	bne     $i7, 1, be_else.32768
be_then.32768:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.32769
ble_then.32769:
	li      0, $i4
.count b_cont
	b       ble_cont.32769
ble_else.32769:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.32770
ble_then.32770:
	li      0, $i4
.count b_cont
	b       ble_cont.32770
ble_else.32770:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.32771
ble_then.32771:
	li      0, $i4
.count b_cont
	b       ble_cont.32771
ble_else.32771:
	li      1, $i4
ble_cont.32771:
ble_cont.32770:
ble_cont.32769:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.32772
be_then.32772:
	bne     $i2, 0, be_else.32773
be_then.32773:
	li      0, $i1
	ret
be_else.32773:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.32772:
	bne     $i2, 0, be_else.32774
be_then.32774:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.32774:
	li      0, $i1
	ret
be_else.32768:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.32775
be_then.32775:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.32776
ble_then.32776:
	bne     $i4, 0, be_else.32777
be_then.32777:
	li      0, $i1
	ret
be_else.32777:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.32776:
	bne     $i4, 0, be_else.32778
be_then.32778:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.32778:
	li      0, $i1
	ret
be_else.32775:
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
	bne     $i9, 0, be_else.32779
be_then.32779:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32779
be_else.32779:
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
be_cont.32779:
	bne     $i7, 3, be_cont.32780
be_then.32780:
	fsub    $f1, $fc0, $f1
be_cont.32780:
	bg      $f0, $f1, ble_else.32781
ble_then.32781:
	bne     $i4, 0, be_else.32782
be_then.32782:
	li      0, $i1
	ret
be_else.32782:
	add     $i1, 1, $i1
	b       check_all_inside.2856
ble_else.32781:
	bne     $i4, 0, be_else.32783
be_then.32783:
	add     $i1, 1, $i1
	b       check_all_inside.2856
be_else.32783:
	li      0, $i1
	ret
be_else.32766:
	li      0, $i1
	ret
be_else.32748:
	li      0, $i1
	ret
be_else.32730:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i10, $i11)
# $ra = $ra
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i11 + $i10], $i1
	bne     $i1, -1, be_else.32784
be_then.32784:
	li      0, $i1
	ret
be_else.32784:
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
	bne     $i7, 1, be_else.32785
be_then.32785:
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
	bg      $f4, $f5, ble_else.32786
ble_then.32786:
	li      0, $i5
.count b_cont
	b       ble_cont.32786
ble_else.32786:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32787
ble_then.32787:
	li      0, $i5
.count b_cont
	b       ble_cont.32787
ble_else.32787:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.32788
be_then.32788:
	li      0, $i5
.count b_cont
	b       be_cont.32788
be_else.32788:
	li      1, $i5
be_cont.32788:
ble_cont.32787:
ble_cont.32786:
	bne     $i5, 0, be_else.32789
be_then.32789:
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.32790
ble_then.32790:
	li      0, $i5
.count b_cont
	b       ble_cont.32790
ble_else.32790:
	load    [$i2 + 4], $i5
	load    [$i5 + 2], $f4
	load    [$i4 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32791
ble_then.32791:
	li      0, $i5
.count b_cont
	b       ble_cont.32791
ble_else.32791:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, be_else.32792
be_then.32792:
	li      0, $i5
.count b_cont
	b       be_cont.32792
be_else.32792:
	li      1, $i5
be_cont.32792:
ble_cont.32791:
ble_cont.32790:
	bne     $i5, 0, be_else.32793
be_then.32793:
	load    [$i2 + 4], $i5
	load    [$i5 + 0], $f4
	load    [$i4 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.32794
ble_then.32794:
	li      0, $i2
.count b_cont
	b       be_cont.32785
ble_else.32794:
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.32795
ble_then.32795:
	li      0, $i2
.count b_cont
	b       be_cont.32785
ble_else.32795:
	load    [$i3 + 5], $f1
	bne     $f1, $f0, be_else.32796
be_then.32796:
	li      0, $i2
.count b_cont
	b       be_cont.32785
be_else.32796:
	mov     $f3, $fg0
	li      3, $i2
.count b_cont
	b       be_cont.32785
be_else.32793:
	mov     $f6, $fg0
	li      2, $i2
.count b_cont
	b       be_cont.32785
be_else.32789:
	mov     $f6, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.32785
be_else.32785:
	load    [$i3 + 0], $f4
	bne     $i7, 2, be_else.32797
be_then.32797:
	bg      $f0, $f4, ble_else.32798
ble_then.32798:
	li      0, $i2
.count b_cont
	b       be_cont.32797
ble_else.32798:
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
	b       be_cont.32797
be_else.32797:
	bne     $f4, $f0, be_else.32799
be_then.32799:
	li      0, $i2
.count b_cont
	b       be_cont.32799
be_else.32799:
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
	bne     $i4, 0, be_else.32800
be_then.32800:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32800
be_else.32800:
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
be_cont.32800:
	bne     $i7, 3, be_cont.32801
be_then.32801:
	fsub    $f1, $fc0, $f1
be_cont.32801:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.32802
ble_then.32802:
	li      0, $i2
.count b_cont
	b       ble_cont.32802
ble_else.32802:
	load    [$i2 + 6], $i2
	load    [$i3 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.32803
be_then.32803:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i2
.count b_cont
	b       be_cont.32803
be_else.32803:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i2
be_cont.32803:
ble_cont.32802:
be_cont.32799:
be_cont.32797:
be_cont.32785:
	bne     $i2, 0, be_else.32804
be_then.32804:
	li      0, $i2
.count b_cont
	b       be_cont.32804
be_else.32804:
.count load_float
	load    [f.31944], $f1
	bg      $f1, $fg0, ble_else.32805
ble_then.32805:
	li      0, $i2
.count b_cont
	b       ble_cont.32805
ble_else.32805:
	li      1, $i2
ble_cont.32805:
be_cont.32804:
	bne     $i2, 0, be_else.32806
be_then.32806:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.32807
be_then.32807:
	li      0, $i1
	ret
be_else.32807:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.32806:
	load    [$i11 + 0], $i1
	bne     $i1, -1, be_else.32808
be_then.32808:
	li      1, $i1
	ret
be_else.32808:
	load    [ext_objects + $i1], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	fadd    $fg0, $fc16, $f2
	fmul    $fg12, $f2, $f3
	load    [ext_intersection_point + 0], $f4
	fadd    $f3, $f4, $f5
	fsub    $f5, $f1, $f1
	load    [$i3 + 1], $f3
	fmul    $fg13, $f2, $f4
	load    [ext_intersection_point + 1], $f6
	fadd    $f4, $f6, $f6
	fsub    $f6, $f3, $f3
	load    [$i4 + 2], $f4
	fmul    $fg14, $f2, $f2
	load    [ext_intersection_point + 2], $f7
	fadd    $f2, $f7, $f7
	fsub    $f7, $f4, $f2
	bne     $i5, 1, be_else.32809
be_then.32809:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f4
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.32810
ble_then.32810:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.32811
be_then.32811:
	li      1, $i1
.count b_cont
	b       be_cont.32809
be_else.32811:
	li      0, $i1
.count b_cont
	b       be_cont.32809
ble_else.32810:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f1
	fabs    $f3, $f3
	bg      $f1, $f3, ble_else.32812
ble_then.32812:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.32813
be_then.32813:
	li      1, $i1
.count b_cont
	b       be_cont.32809
be_else.32813:
	li      0, $i1
.count b_cont
	b       be_cont.32809
ble_else.32812:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f1
	fabs    $f2, $f2
	load    [$i1 + 6], $i1
	bg      $f1, $f2, be_cont.32809
ble_then.32814:
	bne     $i1, 0, be_else.32815
be_then.32815:
	li      1, $i1
.count b_cont
	b       be_cont.32809
be_else.32815:
	li      0, $i1
.count b_cont
	b       be_cont.32809
be_else.32809:
	load    [$i1 + 6], $i2
	bne     $i5, 2, be_else.32816
be_then.32816:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f4
	fmul    $f4, $f1, $f1
	load    [$i1 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	bg      $f0, $f1, ble_else.32817
ble_then.32817:
	bne     $i2, 0, be_else.32818
be_then.32818:
	li      1, $i1
.count b_cont
	b       be_cont.32816
be_else.32818:
	li      0, $i1
.count b_cont
	b       be_cont.32816
ble_else.32817:
	bne     $i2, 0, be_else.32819
be_then.32819:
	li      0, $i1
.count b_cont
	b       be_cont.32816
be_else.32819:
	li      1, $i1
.count b_cont
	b       be_cont.32816
be_else.32816:
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
	bne     $i3, 0, be_else.32820
be_then.32820:
	mov     $f4, $f1
.count b_cont
	b       be_cont.32820
be_else.32820:
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
be_cont.32820:
	bne     $i5, 3, be_cont.32821
be_then.32821:
	fsub    $f1, $fc0, $f1
be_cont.32821:
	bg      $f0, $f1, ble_else.32822
ble_then.32822:
	bne     $i2, 0, be_else.32823
be_then.32823:
	li      1, $i1
.count b_cont
	b       ble_cont.32822
be_else.32823:
	li      0, $i1
.count b_cont
	b       ble_cont.32822
ble_else.32822:
	bne     $i2, 0, be_else.32824
be_then.32824:
	li      0, $i1
.count b_cont
	b       be_cont.32824
be_else.32824:
	li      1, $i1
be_cont.32824:
ble_cont.32822:
be_cont.32816:
be_cont.32809:
	bne     $i1, 0, be_else.32825
be_then.32825:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.32826
be_then.32826:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
be_else.32826:
	li      1, $i1
	ret
be_else.32825:
	add     $i10, 1, $i10
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i12, $i13)
# $ra = $ra
# [$i1 - $i13]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32827
be_then.32827:
	li      0, $i1
	ret
be_else.32827:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32828
be_then.32828:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32829
be_then.32829:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32829:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32830
be_then.32830:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32831
be_then.32831:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32831:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32832
be_then.32832:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32833
be_then.32833:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32833:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32834
be_then.32834:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32835
be_then.32835:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32835:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32836
be_then.32836:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32837
be_then.32837:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32837:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32838
be_then.32838:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32839
be_then.32839:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32839:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32840
be_then.32840:
	add     $i12, 1, $i12
	load    [$i13 + $i12], $i1
	bne     $i1, -1, be_else.32841
be_then.32841:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32841:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.32842
be_then.32842:
	add     $i12, 1, $i12
	b       shadow_check_one_or_group.2865
be_else.32842:
	li      1, $i1
	ret
be_else.32840:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32838:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32836:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32834:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32832:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32830:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32828:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i14, $i15)
# $ra = $ra
# [$i1 - $i16]
# [$f1 - $f9]
# []
# [$fg0]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.32843
be_then.32843:
	li      0, $i1
	ret
be_else.32843:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	bne     $i1, 99, be_else.32844
be_then.32844:
	li      1, $i1
.count b_cont
	b       be_cont.32844
be_else.32844:
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
	bne     $i3, 1, be_else.32845
be_then.32845:
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
	bg      $f4, $f5, ble_else.32846
ble_then.32846:
	li      0, $i4
.count b_cont
	b       ble_cont.32846
ble_else.32846:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32847
ble_then.32847:
	li      0, $i4
.count b_cont
	b       ble_cont.32847
ble_else.32847:
	load    [$i1 + 1], $f4
	bne     $f4, $f0, be_else.32848
be_then.32848:
	li      0, $i4
.count b_cont
	b       be_cont.32848
be_else.32848:
	li      1, $i4
be_cont.32848:
ble_cont.32847:
ble_cont.32846:
	bne     $i4, 0, be_else.32849
be_then.32849:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i1 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.32850
ble_then.32850:
	li      0, $i4
.count b_cont
	b       ble_cont.32850
ble_else.32850:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i3 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32851
ble_then.32851:
	li      0, $i4
.count b_cont
	b       ble_cont.32851
ble_else.32851:
	load    [$i1 + 3], $f4
	bne     $f4, $f0, be_else.32852
be_then.32852:
	li      0, $i4
.count b_cont
	b       be_cont.32852
be_else.32852:
	li      1, $i4
be_cont.32852:
ble_cont.32851:
ble_cont.32850:
	bne     $i4, 0, be_else.32853
be_then.32853:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i3 + 0], $f5
	load    [$i1 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i1 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.32854
ble_then.32854:
	li      0, $i1
.count b_cont
	b       be_cont.32845
ble_else.32854:
	load    [$i2 + 4], $i2
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.32855
ble_then.32855:
	li      0, $i1
.count b_cont
	b       be_cont.32845
ble_else.32855:
	load    [$i1 + 5], $f1
	bne     $f1, $f0, be_else.32856
be_then.32856:
	li      0, $i1
.count b_cont
	b       be_cont.32845
be_else.32856:
	mov     $f3, $fg0
	li      3, $i1
.count b_cont
	b       be_cont.32845
be_else.32853:
	mov     $f6, $fg0
	li      2, $i1
.count b_cont
	b       be_cont.32845
be_else.32849:
	mov     $f6, $fg0
	li      1, $i1
.count b_cont
	b       be_cont.32845
be_else.32845:
	load    [$i1 + 0], $f4
	bne     $i3, 2, be_else.32857
be_then.32857:
	bg      $f0, $f4, ble_else.32858
ble_then.32858:
	li      0, $i1
.count b_cont
	b       be_cont.32857
ble_else.32858:
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
	b       be_cont.32857
be_else.32857:
	bne     $f4, $f0, be_else.32859
be_then.32859:
	li      0, $i1
.count b_cont
	b       be_cont.32859
be_else.32859:
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
	bne     $i4, 0, be_else.32860
be_then.32860:
	mov     $f7, $f1
.count b_cont
	b       be_cont.32860
be_else.32860:
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
be_cont.32860:
	bne     $i3, 3, be_cont.32861
be_then.32861:
	fsub    $f1, $fc0, $f1
be_cont.32861:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.32862
ble_then.32862:
	li      0, $i1
.count b_cont
	b       ble_cont.32862
ble_else.32862:
	load    [$i2 + 6], $i2
	load    [$i1 + 4], $f2
	li      1, $i1
	fsqrt   $f1, $f1
	bne     $i2, 0, be_else.32863
be_then.32863:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.32863
be_else.32863:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
be_cont.32863:
ble_cont.32862:
be_cont.32859:
be_cont.32857:
be_cont.32845:
	bne     $i1, 0, be_else.32864
be_then.32864:
	li      0, $i1
.count b_cont
	b       be_cont.32864
be_else.32864:
	bg      $fc7, $fg0, ble_else.32865
ble_then.32865:
	li      0, $i1
.count b_cont
	b       ble_cont.32865
ble_else.32865:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32866
be_then.32866:
	li      0, $i1
.count b_cont
	b       be_cont.32866
be_else.32866:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32867
be_then.32867:
	li      2, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.32868
be_then.32868:
	li      0, $i1
.count b_cont
	b       be_cont.32867
be_else.32868:
	li      1, $i1
.count b_cont
	b       be_cont.32867
be_else.32867:
	li      1, $i1
be_cont.32867:
be_cont.32866:
ble_cont.32865:
be_cont.32864:
be_cont.32844:
	bne     $i1, 0, be_else.32869
be_then.32869:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.32870
be_then.32870:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32870:
	bne     $i1, 99, be_else.32871
be_then.32871:
	li      1, $i1
.count b_cont
	b       be_cont.32871
be_else.32871:
	call    solver_fast.2796
	bne     $i1, 0, be_else.32872
be_then.32872:
	li      0, $i1
.count b_cont
	b       be_cont.32872
be_else.32872:
	bg      $fc7, $fg0, ble_else.32873
ble_then.32873:
	li      0, $i1
.count b_cont
	b       ble_cont.32873
ble_else.32873:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32874
be_then.32874:
	li      0, $i1
.count b_cont
	b       be_cont.32874
be_else.32874:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32875
be_then.32875:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32876
be_then.32876:
	li      0, $i1
.count b_cont
	b       be_cont.32875
be_else.32876:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32877
be_then.32877:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.32878
be_then.32878:
	li      0, $i1
.count b_cont
	b       be_cont.32875
be_else.32878:
	li      1, $i1
.count b_cont
	b       be_cont.32875
be_else.32877:
	li      1, $i1
.count b_cont
	b       be_cont.32875
be_else.32875:
	li      1, $i1
be_cont.32875:
be_cont.32874:
ble_cont.32873:
be_cont.32872:
be_cont.32871:
	bne     $i1, 0, be_else.32879
be_then.32879:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32879:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32880
be_then.32880:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32880:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32881
be_then.32881:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32882
be_then.32882:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32882:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32883
be_then.32883:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.32884
be_then.32884:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32884:
	li      1, $i1
	ret
be_else.32883:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32881:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32869:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32885
be_then.32885:
	li      0, $i1
.count b_cont
	b       be_cont.32885
be_else.32885:
	load    [ext_and_net + $i1], $i11
	li      0, $i10
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32886
be_then.32886:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32887
be_then.32887:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32887:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32888
be_then.32888:
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.32889
be_then.32889:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32889:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32890
be_then.32890:
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.32891
be_then.32891:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32891:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32892
be_then.32892:
	load    [$i16 + 5], $i1
	bne     $i1, -1, be_else.32893
be_then.32893:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32893:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32894
be_then.32894:
	load    [$i16 + 6], $i1
	bne     $i1, -1, be_else.32895
be_then.32895:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32895:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32896
be_then.32896:
	load    [$i16 + 7], $i1
	bne     $i1, -1, be_else.32897
be_then.32897:
	li      0, $i1
.count b_cont
	b       be_cont.32886
be_else.32897:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32898
be_then.32898:
	li      8, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
.count b_cont
	b       be_cont.32886
be_else.32898:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32896:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32894:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32892:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32890:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32888:
	li      1, $i1
.count b_cont
	b       be_cont.32886
be_else.32886:
	li      1, $i1
be_cont.32886:
be_cont.32885:
	bne     $i1, 0, be_else.32899
be_then.32899:
	add     $i14, 1, $i14
	load    [$i15 + $i14], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.32900
be_then.32900:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      0, $i1
	ret
be_else.32900:
	bne     $i1, 99, be_else.32901
be_then.32901:
	li      1, $i1
.count b_cont
	b       be_cont.32901
be_else.32901:
	call    solver_fast.2796
	bne     $i1, 0, be_else.32902
be_then.32902:
	li      0, $i1
.count b_cont
	b       be_cont.32902
be_else.32902:
	bg      $fc7, $fg0, ble_else.32903
ble_then.32903:
	li      0, $i1
.count b_cont
	b       ble_cont.32903
ble_else.32903:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32904
be_then.32904:
	li      0, $i1
.count b_cont
	b       be_cont.32904
be_else.32904:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32905
be_then.32905:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32906
be_then.32906:
	li      0, $i1
.count b_cont
	b       be_cont.32905
be_else.32906:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32907
be_then.32907:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.32908
be_then.32908:
	li      0, $i1
.count b_cont
	b       be_cont.32905
be_else.32908:
	li      1, $i1
.count b_cont
	b       be_cont.32905
be_else.32907:
	li      1, $i1
.count b_cont
	b       be_cont.32905
be_else.32905:
	li      1, $i1
be_cont.32905:
be_cont.32904:
ble_cont.32903:
be_cont.32902:
be_cont.32901:
	bne     $i1, 0, be_else.32909
be_then.32909:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32909:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32910
be_then.32910:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32910:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32911
be_then.32911:
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32912
be_then.32912:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32912:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.32913
be_then.32913:
	li      3, $i12
.count move_args
	mov     $i16, $i13
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.32914
be_then.32914:
	add     $i14, 1, $i14
	b       shadow_check_one_or_matrix.2868
be_else.32914:
	li      1, $i1
	ret
be_else.32913:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32911:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
be_else.32899:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i10, $i11, $i12)
# $ra = $ra
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.32915
be_then.32915:
	ret
be_else.32915:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 1], $i5
	load    [$i2 + 0], $f1
	fsub    $fg21, $f1, $f1
	load    [$i3 + 1], $f2
	fsub    $fg22, $f2, $f2
	load    [$i4 + 2], $f3
	fsub    $fg23, $f3, $f3
	load    [$i12 + 0], $f4
	bne     $i5, 1, be_else.32916
be_then.32916:
	bne     $f4, $f0, be_else.32917
be_then.32917:
	li      0, $i2
.count b_cont
	b       be_cont.32917
be_else.32917:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.32918
ble_then.32918:
	li      0, $i4
.count b_cont
	b       ble_cont.32918
ble_else.32918:
	li      1, $i4
ble_cont.32918:
	bne     $i3, 0, be_else.32919
be_then.32919:
	mov     $i4, $i3
.count b_cont
	b       be_cont.32919
be_else.32919:
	bne     $i4, 0, be_else.32920
be_then.32920:
	li      1, $i3
.count b_cont
	b       be_cont.32920
be_else.32920:
	li      0, $i3
be_cont.32920:
be_cont.32919:
	load    [$i2 + 0], $f5
	bne     $i3, 0, be_cont.32921
be_then.32921:
	fneg    $f5, $f5
be_cont.32921:
	fsub    $f5, $f1, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 1], $f5
	load    [$i12 + 1], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.32922
ble_then.32922:
	li      0, $i2
.count b_cont
	b       ble_cont.32922
ble_else.32922:
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.32923
ble_then.32923:
	li      0, $i2
.count b_cont
	b       ble_cont.32923
ble_else.32923:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.32923:
ble_cont.32922:
be_cont.32917:
	bne     $i2, 0, be_else.32924
be_then.32924:
	load    [$i12 + 1], $f4
	bne     $f4, $f0, be_else.32925
be_then.32925:
	li      0, $i2
.count b_cont
	b       be_cont.32925
be_else.32925:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i3
	bg      $f0, $f4, ble_else.32926
ble_then.32926:
	li      0, $i4
.count b_cont
	b       ble_cont.32926
ble_else.32926:
	li      1, $i4
ble_cont.32926:
	bne     $i3, 0, be_else.32927
be_then.32927:
	mov     $i4, $i3
.count b_cont
	b       be_cont.32927
be_else.32927:
	bne     $i4, 0, be_else.32928
be_then.32928:
	li      1, $i3
.count b_cont
	b       be_cont.32928
be_else.32928:
	li      0, $i3
be_cont.32928:
be_cont.32927:
	load    [$i2 + 1], $f5
	bne     $i3, 0, be_cont.32929
be_then.32929:
	fneg    $f5, $f5
be_cont.32929:
	fsub    $f5, $f2, $f5
	finv    $f4, $f4
	fmul    $f5, $f4, $f4
	load    [$i2 + 2], $f5
	load    [$i12 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.32930
ble_then.32930:
	li      0, $i2
.count b_cont
	b       ble_cont.32930
ble_else.32930:
	load    [$i2 + 0], $f5
	load    [$i12 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.32931
ble_then.32931:
	li      0, $i2
.count b_cont
	b       ble_cont.32931
ble_else.32931:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.32931:
ble_cont.32930:
be_cont.32925:
	bne     $i2, 0, be_else.32932
be_then.32932:
	load    [$i12 + 2], $f4
	bne     $f4, $f0, be_else.32933
be_then.32933:
	li      0, $i14
.count b_cont
	b       be_cont.32916
be_else.32933:
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f5
	load    [$i12 + 0], $f6
	load    [$i1 + 6], $i1
	bg      $f0, $f4, ble_else.32934
ble_then.32934:
	li      0, $i3
.count b_cont
	b       ble_cont.32934
ble_else.32934:
	li      1, $i3
ble_cont.32934:
	bne     $i1, 0, be_else.32935
be_then.32935:
	mov     $i3, $i1
.count b_cont
	b       be_cont.32935
be_else.32935:
	bne     $i3, 0, be_else.32936
be_then.32936:
	li      1, $i1
.count b_cont
	b       be_cont.32936
be_else.32936:
	li      0, $i1
be_cont.32936:
be_cont.32935:
	load    [$i2 + 2], $f7
	bne     $i1, 0, be_cont.32937
be_then.32937:
	fneg    $f7, $f7
be_cont.32937:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.32938
ble_then.32938:
	li      0, $i14
.count b_cont
	b       be_cont.32916
ble_else.32938:
	load    [$i2 + 1], $f1
	load    [$i12 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.32939
ble_then.32939:
	li      0, $i14
.count b_cont
	b       be_cont.32916
ble_else.32939:
	mov     $f3, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.32916
be_else.32932:
	li      2, $i14
.count b_cont
	b       be_cont.32916
be_else.32924:
	li      1, $i14
.count b_cont
	b       be_cont.32916
be_else.32916:
	bne     $i5, 2, be_else.32940
be_then.32940:
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
	bg      $f4, $f0, ble_else.32941
ble_then.32941:
	li      0, $i14
.count b_cont
	b       be_cont.32940
ble_else.32941:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.32940
be_else.32940:
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
	be      $i2, 0, bne_cont.32942
bne_then.32942:
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
bne_cont.32942:
	bne     $f7, $f0, be_else.32943
be_then.32943:
	li      0, $i14
.count b_cont
	b       be_cont.32943
be_else.32943:
	load    [$i1 + 1], $i3
	fmul    $f4, $f1, $f9
	fmul    $f9, $f8, $f9
	fmul    $f5, $f2, $f12
	fmul    $f12, $f10, $f12
	fadd    $f9, $f12, $f9
	fmul    $f6, $f3, $f12
	fmul    $f12, $f11, $f12
	fadd    $f9, $f12, $f9
	bne     $i2, 0, be_else.32944
be_then.32944:
	mov     $f9, $f4
.count b_cont
	b       be_cont.32944
be_else.32944:
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
	fmul    $f4, $fc3, $f4
	fadd    $f9, $f4, $f4
be_cont.32944:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i2, 0, be_else.32945
be_then.32945:
	mov     $f6, $f1
.count b_cont
	b       be_cont.32945
be_else.32945:
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
be_cont.32945:
	bne     $i3, 3, be_cont.32946
be_then.32946:
	fsub    $f1, $fc0, $f1
be_cont.32946:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.32947
ble_then.32947:
	li      0, $i14
.count b_cont
	b       ble_cont.32947
ble_else.32947:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	li      1, $i14
	finv    $f7, $f2
	bne     $i1, 0, be_else.32948
be_then.32948:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.32948
be_else.32948:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
be_cont.32948:
ble_cont.32947:
be_cont.32943:
be_cont.32940:
be_cont.32916:
	bne     $i14, 0, be_else.32949
be_then.32949:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.32950
be_then.32950:
	ret
be_else.32950:
	add     $i10, 1, $i10
	b       solve_each_element.2871
be_else.32949:
	bg      $fg0, $f0, ble_else.32951
ble_then.32951:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.32951:
	bg      $fg7, $fg0, ble_else.32952
ble_then.32952:
	add     $i10, 1, $i10
	b       solve_each_element.2871
ble_else.32952:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i1
	load    [$i12 + 0], $f1
	fadd    $fg0, $fc16, $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg21, $f11
	load    [$i12 + 1], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg22, $f12
	load    [$i12 + 2], $f1
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg23, $f13
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $f11, $f2
.count move_args
	mov     $f12, $f3
.count move_args
	mov     $f13, $f4
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
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
# $ra = $ra
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32954
be_then.32954:
	ret
be_else.32954:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32955
be_then.32955:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32955:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32956
be_then.32956:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32956:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32957
be_then.32957:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32957:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32958
be_then.32958:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32958:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32959
be_then.32959:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32959:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32960
be_then.32960:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32960:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.32961
be_then.32961:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32961:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i15, 1, $i15
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i18, $i19, $i20)
# $ra = $ra
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.32962
be_then.32962:
	ret
be_else.32962:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	bne     $i1, 99, be_else.32963
be_then.32963:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.32964
bne_then.32964:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.32965
bne_then.32965:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.32966
bne_then.32966:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.32967
bne_then.32967:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.32968
bne_then.32968:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.32969
bne_then.32969:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	li      7, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network.2875
bne_cont.32969:
bne_cont.32968:
bne_cont.32967:
bne_cont.32966:
bne_cont.32965:
bne_cont.32964:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.32970
be_then.32970:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.32970:
	bne     $i1, 99, be_else.32971
be_then.32971:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.32972
be_then.32972:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32972:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.32973
be_then.32973:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32973:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.32974
be_then.32974:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32974:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.32975
be_then.32975:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32975:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element.2871
	li      5, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32971:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.32976
be_then.32976:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32976:
	bg      $fg7, $fg0, ble_else.32977
ble_then.32977:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.32977:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32963:
.count move_args
	mov     $i20, $i2
	call    solver.2773
	bne     $i1, 0, be_else.32978
be_then.32978:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
be_else.32978:
	bg      $fg7, $fg0, ble_else.32979
ble_then.32979:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
ble_else.32979:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i10, $i11, $i12)
# $ra = $ra
# [$i1 - $i14]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i11 + $i10], $i13
	bne     $i13, -1, be_else.32980
be_then.32980:
	ret
be_else.32980:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 10], $i2
	load    [$i12 + 1], $i3
	load    [$i1 + 1], $i4
	load    [$i2 + 0], $f1
	load    [$i2 + 1], $f2
	load    [$i2 + 2], $f3
	load    [$i3 + $i13], $i3
	bne     $i4, 1, be_else.32981
be_then.32981:
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
	bg      $f4, $f5, ble_else.32982
ble_then.32982:
	li      0, $i4
.count b_cont
	b       ble_cont.32982
ble_else.32982:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32983
ble_then.32983:
	li      0, $i4
.count b_cont
	b       ble_cont.32983
ble_else.32983:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.32984
be_then.32984:
	li      0, $i4
.count b_cont
	b       be_cont.32984
be_else.32984:
	li      1, $i4
be_cont.32984:
ble_cont.32983:
ble_cont.32982:
	bne     $i4, 0, be_else.32985
be_then.32985:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 2], $f6
	fsub    $f6, $f2, $f6
	load    [$i3 + 3], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f1, $f5
	bg      $f4, $f5, ble_else.32986
ble_then.32986:
	li      0, $i4
.count b_cont
	b       ble_cont.32986
ble_else.32986:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f4
	load    [$i2 + 2], $f5
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f3, $f5
	bg      $f4, $f5, ble_else.32987
ble_then.32987:
	li      0, $i4
.count b_cont
	b       ble_cont.32987
ble_else.32987:
	load    [$i3 + 3], $f4
	bne     $f4, $f0, be_else.32988
be_then.32988:
	li      0, $i4
.count b_cont
	b       be_cont.32988
be_else.32988:
	li      1, $i4
be_cont.32988:
ble_cont.32987:
ble_cont.32986:
	bne     $i4, 0, be_else.32989
be_then.32989:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f4
	load    [$i2 + 0], $f5
	load    [$i3 + 4], $f6
	fsub    $f6, $f3, $f3
	load    [$i3 + 5], $f6
	fmul    $f3, $f6, $f3
	fmul    $f3, $f5, $f5
	fadd_a  $f5, $f1, $f1
	bg      $f4, $f1, ble_else.32990
ble_then.32990:
	li      0, $i14
.count b_cont
	b       be_cont.32981
ble_else.32990:
	load    [$i1 + 4], $i1
	load    [$i1 + 1], $f1
	load    [$i2 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.32991
ble_then.32991:
	li      0, $i14
.count b_cont
	b       be_cont.32981
ble_else.32991:
	load    [$i3 + 5], $f1
	bne     $f1, $f0, be_else.32992
be_then.32992:
	li      0, $i14
.count b_cont
	b       be_cont.32981
be_else.32992:
	mov     $f3, $fg0
	li      3, $i14
.count b_cont
	b       be_cont.32981
be_else.32989:
	mov     $f6, $fg0
	li      2, $i14
.count b_cont
	b       be_cont.32981
be_else.32985:
	mov     $f6, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.32981
be_else.32981:
	bne     $i4, 2, be_else.32993
be_then.32993:
	load    [$i3 + 0], $f1
	bg      $f0, $f1, ble_else.32994
ble_then.32994:
	li      0, $i14
.count b_cont
	b       be_cont.32993
ble_else.32994:
	load    [$i2 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i14
.count b_cont
	b       be_cont.32993
be_else.32993:
	load    [$i3 + 0], $f4
	bne     $f4, $f0, be_else.32995
be_then.32995:
	li      0, $i14
.count b_cont
	b       be_cont.32995
be_else.32995:
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
	bg      $f2, $f0, ble_else.32996
ble_then.32996:
	li      0, $i14
.count b_cont
	b       ble_cont.32996
ble_else.32996:
	load    [$i1 + 6], $i1
	li      1, $i14
	fsqrt   $f2, $f2
	bne     $i1, 0, be_else.32997
be_then.32997:
	fsub    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
.count b_cont
	b       be_cont.32997
be_else.32997:
	fadd    $f1, $f2, $f1
	load    [$i3 + 4], $f2
	fmul    $f1, $f2, $fg0
be_cont.32997:
ble_cont.32996:
be_cont.32995:
be_cont.32993:
be_cont.32981:
	bne     $i14, 0, be_else.32998
be_then.32998:
	load    [ext_objects + $i13], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.32999
be_then.32999:
	ret
be_else.32999:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
be_else.32998:
	bg      $fg0, $f0, ble_else.33000
ble_then.33000:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.33000:
	load    [$i12 + 0], $i1
	bg      $fg7, $fg0, ble_else.33001
ble_then.33001:
	add     $i10, 1, $i10
	b       solve_each_element_fast.2885
ble_else.33001:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
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
# $ra = $ra
# [$i1 - $i17]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33003
be_then.33003:
	ret
be_else.33003:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33004
be_then.33004:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33004:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33005
be_then.33005:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33005:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33006
be_then.33006:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33006:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33007
be_then.33007:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33007:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33008
be_then.33008:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33008:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33009
be_then.33009:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33009:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i1
	bne     $i1, -1, be_else.33010
be_then.33010:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33010:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i17, $i12
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i15, 1, $i15
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i18, $i19, $i20)
# $ra = $ra
# [$i1 - $i20]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.33011
be_then.33011:
	ret
be_else.33011:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	bne     $i1, 99, be_else.33012
be_then.33012:
	load    [$i16 + 1], $i1
	be      $i1, -1, bne_cont.33013
bne_then.33013:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i1
	be      $i1, -1, bne_cont.33014
bne_then.33014:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i1
	be      $i1, -1, bne_cont.33015
bne_then.33015:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i1
	be      $i1, -1, bne_cont.33016
bne_then.33016:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 5], $i1
	be      $i1, -1, bne_cont.33017
bne_then.33017:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 6], $i1
	be      $i1, -1, bne_cont.33018
bne_then.33018:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	li      7, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
bne_cont.33018:
bne_cont.33017:
bne_cont.33016:
bne_cont.33015:
bne_cont.33014:
bne_cont.33013:
	add     $i18, 1, $i18
	load    [$i19 + $i18], $i16
	load    [$i16 + 0], $i1
	bne     $i1, -1, be_else.33019
be_then.33019:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33019:
	bne     $i1, 99, be_else.33020
be_then.33020:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.33021
be_then.33021:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33021:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.33022
be_then.33022:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33022:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.33023
be_then.33023:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33023:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.33024
be_then.33024:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33024:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i20, $i12
	call    solve_each_element_fast.2885
	li      5, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33020:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.33025
be_then.33025:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33025:
	bg      $fg7, $fg0, ble_else.33026
ble_then.33026:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.33026:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33012:
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.33027
be_then.33027:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
be_else.33027:
	bg      $fg7, $fg0, ble_else.33028
ble_then.33028:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
ble_else.33028:
	li      1, $i15
.count move_args
	mov     $i20, $i17
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i18, 1, $i18
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra
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
	bne     $i2, 1, be_else.33029
be_then.33029:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i1
	load    [ext_intersection_point + 0], $f1
	load    [$i2 + 0], $f2
.count load_float
	load    [f.31957], $f4
	fsub    $f1, $f2, $f5
	fmul    $f5, $f4, $f2
	call    ext_floor
.count load_float
	load    [f.31958], $f6
.count load_float
	load    [f.31959], $f7
	fmul    $f1, $f6, $f1
	fsub    $f5, $f1, $f5
	load    [ext_intersection_point + 2], $f1
	load    [$i1 + 2], $f2
	fsub    $f1, $f2, $f8
	fmul    $f8, $f4, $f2
	call    ext_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fmul    $f1, $f6, $f1
	fsub    $f8, $f1, $f1
	bg      $f7, $f5, ble_else.33030
ble_then.33030:
	li      0, $i1
.count b_cont
	b       ble_cont.33030
ble_else.33030:
	li      1, $i1
ble_cont.33030:
	bg      $f7, $f1, ble_else.33031
ble_then.33031:
	bne     $i1, 0, be_else.33032
be_then.33032:
	mov     $fc9, $fg11
	ret
be_else.33032:
	mov     $f0, $fg11
	ret
ble_else.33031:
	bne     $i1, 0, be_else.33033
be_then.33033:
	mov     $f0, $fg11
	ret
be_else.33033:
	mov     $fc9, $fg11
	ret
be_else.33029:
	bne     $i2, 2, be_else.33034
be_then.33034:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [ext_intersection_point + 1], $f1
.count load_float
	load    [f.31956], $f2
	fmul    $f1, $f2, $f2
	call    ext_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	ret
be_else.33034:
	bne     $i2, 3, be_else.33035
be_then.33035:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	fmul    $f1, $fc8, $f4
.count move_args
	mov     $f4, $f2
	call    ext_floor
	fsub    $f4, $f1, $f1
	fmul    $f1, $fc15, $f2
	call    ext_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg15
	ret
be_else.33035:
	bne     $i2, 4, be_else.33036
be_then.33036:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 5], $i2
	load    [$i1 + 4], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 4], $i5
.count load_float
	load    [f.31947], $f6
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
	bg      $f6, $f1, ble_else.33037
ble_then.33037:
	finv    $f7, $f1
	fmul_a  $f8, $f1, $f2
	call    ext_atan
	fmul    $f1, $fc18, $f1
	fmul    $f1, $fc17, $f9
.count b_cont
	b       ble_cont.33037
ble_else.33037:
	mov     $fc19, $f9
ble_cont.33037:
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
	bg      $f6, $f2, ble_else.33038
ble_then.33038:
	finv    $f1, $f1
	fmul_a  $f3, $f1, $f2
	call    ext_atan
	fmul    $f1, $fc18, $f1
	fmul    $f1, $fc17, $f4
.count b_cont
	b       ble_cont.33038
ble_else.33038:
	mov     $fc19, $f4
ble_cont.33038:
.count load_float
	load    [f.31952], $f5
.count move_args
	mov     $f9, $f2
	call    ext_floor
	fsub    $f9, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f5
.count move_args
	mov     $f4, $f2
	call    ext_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fsub    $f4, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.33039
ble_then.33039:
	fmul    $fc9, $f1, $f1
.count load_float
	load    [f.31954], $f2
	fmul    $f1, $f2, $fg15
	ret
ble_else.33039:
	mov     $f0, $fg15
	ret
be_else.33036:
	ret
.end utexture

######################################################################
# trace_reflections($i21, $f14, $f15, $i22)
# $ra = $ra
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i21, 0, bge_else.33040
bge_then.33040:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [ext_reflections + $i21], $i23
	load    [$i23 + 1], $i24
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.33041
bne_then.33041:
	bne     $i1, 99, be_else.33042
be_then.33042:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.33043
be_then.33043:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33042
be_else.33043:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.33044
be_then.33044:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33042
be_else.33044:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.33045
be_then.33045:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33042
be_else.33045:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.33046
be_then.33046:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33042
be_else.33046:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i24, $i12
	call    solve_each_element_fast.2885
	li      5, $i15
.count move_args
	mov     $i24, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33042
be_else.33042:
.count move_args
	mov     $i24, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.33047
be_then.33047:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33047
be_else.33047:
	bg      $fg7, $fg0, ble_else.33048
ble_then.33048:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.33048
ble_else.33048:
	li      1, $i15
.count move_args
	mov     $i24, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i24, $i20
	call    trace_or_matrix_fast.2893
ble_cont.33048:
be_cont.33047:
be_cont.33042:
bne_cont.33041:
	bg      $fg7, $fc7, ble_else.33049
ble_then.33049:
	li      0, $i1
.count b_cont
	b       ble_cont.33049
ble_else.33049:
	bg      $fc13, $fg7, ble_else.33050
ble_then.33050:
	li      0, $i1
.count b_cont
	b       ble_cont.33050
ble_else.33050:
	li      1, $i1
ble_cont.33050:
ble_cont.33049:
	bne     $i1, 0, be_else.33051
be_then.33051:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.33051:
	load    [$i23 + 0], $i1
	add     $ig3, $ig3, $i2
	add     $i2, $i2, $i2
	add     $i2, $ig2, $i2
	bne     $i2, $i1, be_else.33052
be_then.33052:
	li      0, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.33053
be_then.33053:
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
	ble     $f2, $f0, bg_cont.33054
bg_then.33054:
	fmul    $f2, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f2, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f2, $fg15, $f2
	fadd    $fg6, $f2, $fg6
bg_cont.33054:
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
be_else.33053:
	sub     $i21, 1, $i21
	b       trace_reflections.2915
be_else.33052:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i21, 1, $i21
	b       trace_reflections.2915
bge_else.33040:
	ret
.end trace_reflections

######################################################################
# trace_ray($i25, $f16, $i26, $i27, $f17)
# $ra = $ra
# [$i1 - $i29]
# [$f1 - $f17]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i25, 4, ble_else.33056
ble_then.33056:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.33057
bne_then.33057:
	bne     $i1, 99, be_else.33058
be_then.33058:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.33059
be_then.33059:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33058
be_else.33059:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	call    solve_each_element.2871
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.33060
be_then.33060:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33058
be_else.33060:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	call    solve_each_element.2871
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.33061
be_then.33061:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33058
be_else.33061:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	call    solve_each_element.2871
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.33062
be_then.33062:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33058
be_else.33062:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i26, $i12
	call    solve_each_element.2871
	li      5, $i15
.count move_args
	mov     $i26, $i17
	call    solve_one_or_network.2875
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33058
be_else.33058:
.count move_args
	mov     $i26, $i2
	call    solver.2773
	bne     $i1, 0, be_else.33063
be_then.33063:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.33063
be_else.33063:
	bg      $fg7, $fg0, ble_else.33064
ble_then.33064:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.33064
ble_else.33064:
	li      1, $i15
.count move_args
	mov     $i26, $i17
	call    solve_one_or_network.2875
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i26, $i20
	call    trace_or_matrix.2879
ble_cont.33064:
be_cont.33063:
be_cont.33058:
bne_cont.33057:
	load    [$i27 + 2], $i28
	bg      $fg7, $fc7, ble_else.33065
ble_then.33065:
	li      0, $i1
.count b_cont
	b       ble_cont.33065
ble_else.33065:
	bg      $fc13, $fg7, ble_else.33066
ble_then.33066:
	li      0, $i1
.count b_cont
	b       ble_cont.33066
ble_else.33066:
	li      1, $i1
ble_cont.33066:
ble_cont.33065:
	bne     $i1, 0, be_else.33067
be_then.33067:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i0, -1, $i1
.count storer
	add     $i28, $i25, $tmp
	store   $i1, [$tmp + 0]
	bne     $i25, 0, be_else.33068
be_then.33068:
	ret
be_else.33068:
	load    [$i26 + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [$i26 + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [$i26 + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_else.33069
ble_then.33069:
	ret
ble_else.33069:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f16, $f1
	load    [ext_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	ret
be_else.33067:
	load    [ext_objects + $ig3], $i29
	load    [$i29 + 1], $i1
	bne     $i1, 1, be_else.33070
be_then.33070:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i1
	load    [$i26 + $i1], $f1
	bne     $f1, $f0, be_else.33071
be_then.33071:
	store   $f0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.33070
be_else.33071:
	bg      $f1, $f0, ble_else.33072
ble_then.33072:
	store   $fc0, [ext_nvector + $i1]
.count b_cont
	b       be_cont.33070
ble_else.33072:
	store   $fc4, [ext_nvector + $i1]
.count b_cont
	b       be_cont.33070
be_else.33070:
	bne     $i1, 2, be_else.33073
be_then.33073:
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
	b       be_cont.33073
be_else.33073:
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
	bne     $i1, 0, be_else.33074
be_then.33074:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
.count b_cont
	b       be_cont.33074
be_else.33074:
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i29 + 9], $i1
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i29 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i29 + 9], $i1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.33074:
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
	bne     $f2, $f0, be_else.33075
be_then.33075:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.33075
be_else.33075:
	bne     $i1, 0, be_else.33076
be_then.33076:
	finv    $f2, $f2
.count b_cont
	b       be_cont.33076
be_else.33076:
	finv_n  $f2, $f2
be_cont.33076:
be_cont.33075:
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
be_cont.33073:
be_cont.33070:
	load    [ext_intersection_point + 0], $fg21
	load    [ext_intersection_point + 1], $fg22
	load    [ext_intersection_point + 2], $fg23
.count move_args
	mov     $i29, $i1
	call    utexture.2908
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
	bg      $fc3, $f1, ble_else.33077
ble_then.33077:
	li      1, $i1
	store   $i1, [$tmp + 0]
	load    [$i27 + 4], $i1
	load    [$i1 + $i25], $i2
	store   $fg16, [$i2 + 0]
	store   $fg11, [$i2 + 1]
	store   $fg15, [$i2 + 2]
	load    [$i1 + $i25], $i1
.count load_float
	load    [f.31962], $f1
.count load_float
	load    [f.31963], $f1
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
	b       ble_cont.33077
ble_else.33077:
	li      0, $i1
	store   $i1, [$tmp + 0]
ble_cont.33077:
	load    [ext_nvector + 0], $f1
.count load_float
	load    [f.31964], $f2
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
	bne     $i1, -1, be_else.33078
be_then.33078:
	li      0, $i1
.count b_cont
	b       be_cont.33078
be_else.33078:
	bne     $i1, 99, be_else.33079
be_then.33079:
	li      1, $i1
.count b_cont
	b       be_cont.33079
be_else.33079:
	call    solver_fast.2796
	bne     $i1, 0, be_else.33080
be_then.33080:
	li      0, $i1
.count b_cont
	b       be_cont.33080
be_else.33080:
	bg      $fc7, $fg0, ble_else.33081
ble_then.33081:
	li      0, $i1
.count b_cont
	b       ble_cont.33081
ble_else.33081:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.33082
be_then.33082:
	li      0, $i1
.count b_cont
	b       be_cont.33082
be_else.33082:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33083
be_then.33083:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.33084
be_then.33084:
	li      0, $i1
.count b_cont
	b       be_cont.33083
be_else.33084:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33085
be_then.33085:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.33086
be_then.33086:
	li      0, $i1
.count b_cont
	b       be_cont.33083
be_else.33086:
	li      1, $i1
.count b_cont
	b       be_cont.33083
be_else.33085:
	li      1, $i1
.count b_cont
	b       be_cont.33083
be_else.33083:
	li      1, $i1
be_cont.33083:
be_cont.33082:
ble_cont.33081:
be_cont.33080:
be_cont.33079:
	bne     $i1, 0, be_else.33087
be_then.33087:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33087
be_else.33087:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.33088
be_then.33088:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33088
be_else.33088:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33089
be_then.33089:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.33090
be_then.33090:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33089
be_else.33090:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33091
be_then.33091:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.33092
be_then.33092:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33089
be_else.33092:
	li      1, $i1
.count b_cont
	b       be_cont.33089
be_else.33091:
	li      1, $i1
.count b_cont
	b       be_cont.33089
be_else.33089:
	li      1, $i1
be_cont.33089:
be_cont.33088:
be_cont.33087:
be_cont.33078:
	load    [$i29 + 7], $i2
	load    [$i2 + 1], $f1
	fmul    $f16, $f1, $f15
	bne     $i1, 0, be_cont.33093
be_then.33093:
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	fmul    $f1, $f14, $f1
	load    [$i26 + 0], $f2
	fmul    $f2, $fg12, $f2
	load    [$i26 + 1], $f3
	fmul    $f3, $fg13, $f3
	fadd    $f2, $f3, $f2
	load    [$i26 + 2], $f3
	fmul    $f3, $fg14, $f3
	fadd_n  $f2, $f3, $f2
	ble     $f1, $f0, bg_cont.33094
bg_then.33094:
	fmul    $f1, $fg16, $f3
	fadd    $fg4, $f3, $fg4
	fmul    $f1, $fg11, $f3
	fadd    $fg5, $f3, $fg5
	fmul    $f1, $fg15, $f1
	fadd    $fg6, $f1, $fg6
bg_cont.33094:
	ble     $f2, $f0, bg_cont.33095
bg_then.33095:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f15, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
bg_cont.33095:
be_cont.33093:
	li      ext_intersection_point, $i2
	load    [ext_intersection_point + 0], $fg8
	load    [ext_intersection_point + 1], $fg9
	load    [ext_intersection_point + 2], $fg10
	sub     $ig0, 1, $i1
	call    setup_startp_constants.2831
	sub     $ig4, 1, $i21
.count move_args
	mov     $i26, $i22
	call    trace_reflections.2915
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bg      $f16, $fc8, ble_else.33096
ble_then.33096:
	ret
ble_else.33096:
	bge     $i25, 4, bl_cont.33097
bl_then.33097:
	add     $i25, 1, $i1
	add     $i0, -1, $i2
.count storer
	add     $i28, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.33097:
	load    [$i29 + 2], $i1
	bne     $i1, 2, be_else.33098
be_then.33098:
	load    [$i29 + 7], $i1
	fadd    $f17, $fg7, $f17
	add     $i25, 1, $i25
	load    [$i1 + 0], $f1
	fsub    $fc0, $f1, $f1
	fmul    $f16, $f1, $f16
	b       trace_ray.2920
be_else.33098:
	ret
ble_else.33056:
	ret
.end trace_ray

######################################################################
# trace_diffuse_ray($i21, $f14)
# $ra = $ra
# [$i1 - $i21]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i16
	load    [$i16 + 0], $i1
	be      $i1, -1, bne_cont.33099
bne_then.33099:
	bne     $i1, 99, be_else.33100
be_then.33100:
	load    [$i16 + 1], $i1
	bne     $i1, -1, be_else.33101
be_then.33101:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33100
be_else.33101:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i1
	bne     $i1, -1, be_else.33102
be_then.33102:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33100
be_else.33102:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i1
	bne     $i1, -1, be_else.33103
be_then.33103:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33100
be_else.33103:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i1
	bne     $i1, -1, be_else.33104
be_then.33104:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33100
be_else.33104:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
.count move_args
	mov     $i21, $i12
	call    solve_each_element_fast.2885
	li      5, $i15
.count move_args
	mov     $i21, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33100
be_else.33100:
.count move_args
	mov     $i21, $i2
	call    solver_fast2.2814
	bne     $i1, 0, be_else.33105
be_then.33105:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.33105
be_else.33105:
	bg      $fg7, $fg0, ble_else.33106
ble_then.33106:
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.33106
ble_else.33106:
	li      1, $i15
.count move_args
	mov     $i21, $i17
	call    solve_one_or_network_fast.2889
	li      1, $i18
.count move_args
	mov     $ig1, $i19
.count move_args
	mov     $i21, $i20
	call    trace_or_matrix_fast.2893
ble_cont.33106:
be_cont.33105:
be_cont.33100:
bne_cont.33099:
	bg      $fg7, $fc7, ble_else.33107
ble_then.33107:
	li      0, $i1
.count b_cont
	b       ble_cont.33107
ble_else.33107:
	bg      $fc13, $fg7, ble_else.33108
ble_then.33108:
	li      0, $i1
.count b_cont
	b       ble_cont.33108
ble_else.33108:
	li      1, $i1
ble_cont.33108:
ble_cont.33107:
	bne     $i1, 0, be_else.33109
be_then.33109:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
be_else.33109:
	load    [$i21 + 0], $i1
	load    [ext_objects + $ig3], $i17
	load    [$i17 + 1], $i2
	bne     $i2, 1, be_else.33110
be_then.33110:
	store   $f0, [ext_nvector + 0]
	store   $f0, [ext_nvector + 1]
	store   $f0, [ext_nvector + 2]
	sub     $ig2, 1, $i2
	load    [$i1 + $i2], $f1
	bne     $f1, $f0, be_else.33111
be_then.33111:
	store   $f0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.33110
be_else.33111:
	bg      $f1, $f0, ble_else.33112
ble_then.33112:
	store   $fc0, [ext_nvector + $i2]
.count b_cont
	b       be_cont.33110
ble_else.33112:
	store   $fc4, [ext_nvector + $i2]
.count b_cont
	b       be_cont.33110
be_else.33110:
	bne     $i2, 2, be_else.33113
be_then.33113:
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
	b       be_cont.33113
be_else.33113:
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
	bne     $i1, 0, be_else.33114
be_then.33114:
	store   $f1, [ext_nvector + 0]
	store   $f3, [ext_nvector + 1]
	store   $f5, [ext_nvector + 2]
.count b_cont
	b       be_cont.33114
be_else.33114:
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f7
	fmul    $f4, $f7, $f7
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f8
	fmul    $f6, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f7, $fc3, $f7
	fadd    $f1, $f7, $f1
	store   $f1, [ext_nvector + 0]
	load    [$i17 + 9], $i1
	load    [$i1 + 2], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f7
	fmul    $f6, $f7, $f6
	fadd    $f1, $f6, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f3, $f1, $f1
	store   $f1, [ext_nvector + 1]
	load    [$i17 + 9], $i1
	load    [$i1 + 1], $f1
	fmul    $f2, $f1, $f1
	load    [$i17 + 9], $i1
	load    [$i1 + 0], $f2
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $fc3, $f1
	fadd    $f5, $f1, $f1
	store   $f1, [ext_nvector + 2]
be_cont.33114:
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
	bne     $f2, $f0, be_else.33115
be_then.33115:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.33115
be_else.33115:
	bne     $i1, 0, be_else.33116
be_then.33116:
	finv    $f2, $f2
.count b_cont
	b       be_cont.33116
be_else.33116:
	finv_n  $f2, $f2
be_cont.33116:
be_cont.33115:
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 0]
	load    [ext_nvector + 1], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 1]
	load    [ext_nvector + 2], $f1
	fmul    $f1, $f2, $f1
	store   $f1, [ext_nvector + 2]
be_cont.33113:
be_cont.33110:
.count move_args
	mov     $i17, $i1
	call    utexture.2908
	load    [$ig1 + 0], $i14
	load    [$i14 + 0], $i1
	bne     $i1, -1, be_else.33117
be_then.33117:
	li      0, $i1
.count b_cont
	b       be_cont.33117
be_else.33117:
	bne     $i1, 99, be_else.33118
be_then.33118:
	li      1, $i1
.count b_cont
	b       be_cont.33118
be_else.33118:
	call    solver_fast.2796
	bne     $i1, 0, be_else.33119
be_then.33119:
	li      0, $i1
.count b_cont
	b       be_cont.33119
be_else.33119:
	bg      $fc7, $fg0, ble_else.33120
ble_then.33120:
	li      0, $i1
.count b_cont
	b       ble_cont.33120
ble_else.33120:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.33121
be_then.33121:
	li      0, $i1
.count b_cont
	b       be_cont.33121
be_else.33121:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33122
be_then.33122:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.33123
be_then.33123:
	li      0, $i1
.count b_cont
	b       be_cont.33122
be_else.33123:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33124
be_then.33124:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.33125
be_then.33125:
	li      0, $i1
.count b_cont
	b       be_cont.33122
be_else.33125:
	li      1, $i1
.count b_cont
	b       be_cont.33122
be_else.33124:
	li      1, $i1
.count b_cont
	b       be_cont.33122
be_else.33122:
	li      1, $i1
be_cont.33122:
be_cont.33121:
ble_cont.33120:
be_cont.33119:
be_cont.33118:
	bne     $i1, 0, be_else.33126
be_then.33126:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33126
be_else.33126:
	load    [$i14 + 1], $i1
	bne     $i1, -1, be_else.33127
be_then.33127:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33127
be_else.33127:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33128
be_then.33128:
	load    [$i14 + 2], $i1
	bne     $i1, -1, be_else.33129
be_then.33129:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33128
be_else.33129:
	li      0, $i10
	load    [ext_and_net + $i1], $i11
	call    shadow_check_and_group.2862
	bne     $i1, 0, be_else.33130
be_then.33130:
	li      3, $i12
.count move_args
	mov     $i14, $i13
	call    shadow_check_one_or_group.2865
	bne     $i1, 0, be_else.33131
be_then.33131:
	li      1, $i14
.count move_args
	mov     $ig1, $i15
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.33128
be_else.33131:
	li      1, $i1
.count b_cont
	b       be_cont.33128
be_else.33130:
	li      1, $i1
.count b_cont
	b       be_cont.33128
be_else.33128:
	li      1, $i1
be_cont.33128:
be_cont.33127:
be_cont.33126:
be_cont.33117:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	bne     $i1, 0, be_else.33132
be_then.33132:
	load    [$i17 + 7], $i1
	load    [ext_nvector + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [ext_nvector + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [ext_nvector + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_cont.33133
ble_then.33133:
	mov     $f0, $f1
ble_cont.33133:
	fmul    $f14, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	ret
be_else.33132:
	ret
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i22, $i23, $i24)
# $ra = $ra
# [$i1 - $i24]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i24, 0, bge_else.33134
bge_then.33134:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	bg      $f0, $f1, ble_else.33135
ble_then.33135:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	call    trace_diffuse_ray.2926
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.33136
bge_then.33136:
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
	bg      $f0, $f1, ble_else.33137
ble_then.33137:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.33137:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.33136:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.33135:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	call    trace_diffuse_ray.2926
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.33138
bge_then.33138:
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
	bg      $f0, $f1, ble_else.33139
ble_then.33139:
	fmul    $f1, $fc1, $f14
	load    [$i22 + $i24], $i21
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
ble_else.33139:
	fmul    $f1, $fc2, $f14
	add     $i24, 1, $i1
	load    [$i22 + $i1], $i21
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i24, 2, $i24
	b       iter_trace_diffuse_rays.2929
bge_else.33138:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33134:
	ret
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i25, $i26)
# $ra = $ra
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	be      $i29, 0, bne_cont.33140
bne_then.33140:
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
	bg      $f0, $f1, ble_else.33141
ble_then.33141:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33141
ble_else.33141:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33141:
bne_cont.33140:
	be      $i29, 1, bne_cont.33142
bne_then.33142:
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
	bg      $f0, $f1, ble_else.33143
ble_then.33143:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33143
ble_else.33143:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33143:
bne_cont.33142:
	be      $i29, 2, bne_cont.33144
bne_then.33144:
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
	bg      $f0, $f1, ble_else.33145
ble_then.33145:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33145
ble_else.33145:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33145:
bne_cont.33144:
	be      $i29, 3, bne_cont.33146
bne_then.33146:
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
	bg      $f0, $f1, ble_else.33147
ble_then.33147:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33147
ble_else.33147:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33147:
bne_cont.33146:
	be      $i29, 4, bne_cont.33148
bne_then.33148:
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
	bg      $f0, $f1, ble_else.33149
ble_then.33149:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33149
ble_else.33149:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i27, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33149:
bne_cont.33148:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
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
	ret
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i30, $i25)
# $ra = $ra
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i25, 4, ble_else.33150
ble_then.33150:
	load    [$i30 + 2], $i26
	load    [$i26 + $i25], $i1
	bl      $i1, 0, bge_else.33151
bge_then.33151:
	load    [$i30 + 3], $i27
	load    [$i27 + $i25], $i1
	bne     $i1, 0, be_else.33152
be_then.33152:
	add     $i25, 1, $i31
	bg      $i31, 4, ble_else.33153
ble_then.33153:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.33154
bge_then.33154:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.33155
be_then.33155:
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.33155:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.33154:
	ret
ble_else.33153:
	ret
be_else.33152:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	be      $i31, 0, bne_cont.33156
bne_then.33156:
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
	bg      $f0, $f1, ble_else.33157
ble_then.33157:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33157
ble_else.33157:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33157:
bne_cont.33156:
	be      $i31, 1, bne_cont.33158
bne_then.33158:
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
	bg      $f0, $f1, ble_else.33159
ble_then.33159:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33159
ble_else.33159:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33159:
bne_cont.33158:
	be      $i31, 2, bne_cont.33160
bne_then.33160:
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
	bg      $f0, $f1, ble_else.33161
ble_then.33161:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33161
ble_else.33161:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33161:
bne_cont.33160:
	be      $i31, 3, bne_cont.33162
bne_then.33162:
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
	bg      $f0, $f1, ble_else.33163
ble_then.33163:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33163
ble_else.33163:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33163:
bne_cont.33162:
	be      $i31, 4, bne_cont.33164
bne_then.33164:
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
	bg      $f0, $f1, ble_else.33165
ble_then.33165:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33165
ble_else.33165:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
.count move_args
	mov     $i28, $i23
	call    iter_trace_diffuse_rays.2929
ble_cont.33165:
bne_cont.33164:
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
	bg      $i31, 4, ble_else.33166
ble_then.33166:
	load    [$i26 + $i31], $i1
	bl      $i1, 0, bge_else.33167
bge_then.33167:
	load    [$i27 + $i31], $i1
	bne     $i1, 0, be_else.33168
be_then.33168:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
be_else.33168:
.count move_args
	mov     $i30, $i25
.count move_args
	mov     $i31, $i26
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i31, 1, $i25
	b       do_without_neighbors.2951
bge_else.33167:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.33166:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33151:
	ret
ble_else.33150:
	ret
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i30)
# $ra = $ra
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i30, 4, ble_else.33169
ble_then.33169:
	load    [$i4 + $i2], $i1
	load    [$i1 + 2], $i6
	load    [$i6 + $i30], $i6
	bl      $i6, 0, bge_else.33170
bge_then.33170:
	load    [$i3 + $i2], $i7
	load    [$i7 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.33171
be_then.33171:
	load    [$i5 + $i2], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.33172
be_then.33172:
	sub     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.33173
be_then.33173:
	add     $i2, 1, $i8
	load    [$i4 + $i8], $i8
	load    [$i8 + 2], $i8
	load    [$i8 + $i30], $i8
	bne     $i8, $i6, be_else.33174
be_then.33174:
	li      1, $i6
.count b_cont
	b       be_cont.33171
be_else.33174:
	li      0, $i6
.count b_cont
	b       be_cont.33171
be_else.33173:
	li      0, $i6
.count b_cont
	b       be_cont.33171
be_else.33172:
	li      0, $i6
.count b_cont
	b       be_cont.33171
be_else.33171:
	li      0, $i6
be_cont.33171:
	bne     $i6, 0, be_else.33175
be_then.33175:
	bg      $i30, 4, ble_else.33176
ble_then.33176:
	load    [$i4 + $i2], $i31
	load    [$i31 + 2], $i1
	load    [$i1 + $i30], $i1
	bl      $i1, 0, bge_else.33177
bge_then.33177:
	load    [$i31 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.33178
be_then.33178:
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
be_else.33178:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count move_args
	mov     $i31, $i25
.count move_args
	mov     $i30, $i26
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i30, 1, $i25
.count move_args
	mov     $i31, $i30
	b       do_without_neighbors.2951
bge_else.33177:
	ret
ble_else.33176:
	ret
be_else.33175:
	load    [$i1 + 3], $i1
	load    [$i1 + $i30], $i1
	bne     $i1, 0, be_else.33179
be_then.33179:
	add     $i30, 1, $i30
	b       try_exploit_neighbors.2967
be_else.33179:
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
bge_else.33170:
	ret
ble_else.33169:
	ret
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays($i25, $i26)
# $ra = $ra
# [$i1 - $i31]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i26, 4, ble_else.33180
ble_then.33180:
	load    [$i25 + 2], $i27
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.33181
bge_then.33181:
	load    [$i25 + 3], $i28
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.33182
be_then.33182:
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.33183
ble_then.33183:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.33184
bge_then.33184:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.33185
be_then.33185:
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.33185:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	bg      $f0, $f1, ble_else.33186
ble_then.33186:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33186
ble_else.33186:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
ble_cont.33186:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i25 + 5], $i1
	load    [$i1 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.33184:
	ret
ble_else.33183:
	ret
be_else.33182:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	bg      $f0, $f1, ble_else.33187
ble_then.33187:
	load    [$i22 + 118], $i21
	fmul    $f1, $fc1, $f14
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.33187
ble_else.33187:
	load    [$i22 + 119], $i21
	fmul    $f1, $fc2, $f14
	call    trace_diffuse_ray.2926
ble_cont.33187:
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
	load    [$i25 + 5], $i31
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	bg      $i26, 4, ble_else.33188
ble_then.33188:
	load    [$i27 + $i26], $i1
	bl      $i1, 0, bge_else.33189
bge_then.33189:
	load    [$i28 + $i26], $i1
	bne     $i1, 0, be_else.33190
be_then.33190:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
be_else.33190:
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
	bg      $f0, $f1, ble_else.33191
ble_then.33191:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33191
ble_else.33191:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
ble_cont.33191:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	load    [$i31 + $i26], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	add     $i26, 1, $i26
	b       pretrace_diffuse_rays.2980
bge_else.33189:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.33188:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33181:
	ret
ble_else.33180:
	ret
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i32, $i33, $i34, $f18, $f15, $f17)
# $ra = $ra
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i33, 0, bge_else.33192
bge_then.33192:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f17, [$sp + 1]
.count stack_store
	store   $f15, [$sp + 2]
	load    [ext_screenx_dir + 0], $f4
	sub     $i33, 64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $f4, $f2
	fadd    $f2, $f18, $f2
	store   $f2, [ext_ptrace_dirvec + 0]
	store   $f15, [ext_ptrace_dirvec + 1]
	load    [ext_screenx_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $f17, $f1
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
	bne     $f2, $f0, be_else.33193
be_then.33193:
	mov     $fc0, $f2
.count b_cont
	b       be_cont.33193
be_else.33193:
	finv    $f2, $f2
be_cont.33193:
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
	load    [ext_viewpoint + 0], $fg21
	load    [ext_viewpoint + 1], $fg22
	load    [ext_viewpoint + 2], $fg23
	li      ext_ptrace_dirvec, $i26
	li      0, $i25
	load    [$i32 + $i33], $i27
.count move_args
	mov     $fc0, $f16
.count move_args
	mov     $f0, $f17
	call    trace_ray.2920
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
	bl      $i1, 0, bge_cont.33194
bge_then.33194:
	load    [$i25 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.33195
be_then.33195:
	li      1, $i26
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.33195
be_else.33195:
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
	bg      $f0, $f1, ble_else.33196
ble_then.33196:
	fmul    $f1, $fc1, $f14
	load    [$i22 + 118], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.33196
ble_else.33196:
	fmul    $f1, $fc2, $f14
	load    [$i22 + 119], $i21
	call    trace_diffuse_ray.2926
	li      116, $i24
	call    iter_trace_diffuse_rays.2929
ble_cont.33196:
	load    [$i25 + 5], $i1
	load    [$i1 + 0], $i1
	store   $fg1, [$i1 + 0]
	store   $fg2, [$i1 + 1]
	store   $fg3, [$i1 + 2]
	li      1, $i26
	call    pretrace_diffuse_rays.2980
be_cont.33195:
bge_cont.33194:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	sub     $i33, 1, $i33
	add     $i34, 1, $i34
.count stack_load
	load    [$sp - 2], $f17
.count stack_load
	load    [$sp - 1], $f15
	bl      $i34, 5, pretrace_pixels.2983
	sub     $i34, 5, $i34
	b       pretrace_pixels.2983
bge_else.33192:
	ret
.end pretrace_pixels

######################################################################
# scan_pixel($i32, $i33, $i34, $i35, $i36)
# $ra = $ra
# [$i1 - $i37]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i1
	bg      $i1, $i32, ble_else.33198
ble_then.33198:
	ret
ble_else.33198:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i35 + $i32], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i33, 1, $i37
	bg      $i1, $i37, ble_else.33199
ble_then.33199:
	li      0, $i1
.count b_cont
	b       ble_cont.33199
ble_else.33199:
	bg      $i33, 0, ble_else.33200
ble_then.33200:
	li      0, $i1
.count b_cont
	b       ble_cont.33200
ble_else.33200:
	li      128, $i1
	add     $i32, 1, $i2
	bg      $i1, $i2, ble_else.33201
ble_then.33201:
	li      0, $i1
.count b_cont
	b       ble_cont.33201
ble_else.33201:
	bg      $i32, 0, ble_else.33202
ble_then.33202:
	li      0, $i1
.count b_cont
	b       ble_cont.33202
ble_else.33202:
	li      1, $i1
ble_cont.33202:
ble_cont.33201:
ble_cont.33200:
ble_cont.33199:
	li      0, $i26
	bne     $i1, 0, be_else.33203
be_then.33203:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.33203
bge_then.33204:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.33205
be_then.33205:
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33203
be_else.33205:
.count move_args
	mov     $i30, $i25
	call    calc_diffuse_using_1point.2942
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33203
be_else.33203:
	load    [$i35 + $i32], $i1
	load    [$i1 + 2], $i2
	load    [$i2 + 0], $i2
	bl      $i2, 0, bge_cont.33206
bge_then.33206:
	load    [$i34 + $i32], $i3
	load    [$i3 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.33207
be_then.33207:
	load    [$i36 + $i32], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.33208
be_then.33208:
	sub     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.33209
be_then.33209:
	add     $i32, 1, $i4
	load    [$i35 + $i4], $i4
	load    [$i4 + 2], $i4
	load    [$i4 + 0], $i4
	bne     $i4, $i2, be_else.33210
be_then.33210:
	li      1, $i2
.count b_cont
	b       be_cont.33207
be_else.33210:
	li      0, $i2
.count b_cont
	b       be_cont.33207
be_else.33209:
	li      0, $i2
.count b_cont
	b       be_cont.33207
be_else.33208:
	li      0, $i2
.count b_cont
	b       be_cont.33207
be_else.33207:
	li      0, $i2
be_cont.33207:
	bne     $i2, 0, be_else.33211
be_then.33211:
	load    [$i35 + $i32], $i30
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.33211
bge_then.33212:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.33213
be_then.33213:
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33211
be_else.33213:
.count move_args
	mov     $i30, $i25
	call    calc_diffuse_using_1point.2942
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33211
be_else.33211:
	load    [$i1 + 3], $i1
	load    [$i1 + 0], $i1
.count move_args
	mov     $i36, $i5
.count move_args
	mov     $i35, $i4
.count move_args
	mov     $i32, $i2
	li      1, $i30
	bne     $i1, 0, be_else.33214
be_then.33214:
.count move_args
	mov     $i34, $i3
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.33214
be_else.33214:
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
	call    try_exploit_neighbors.2967
be_cont.33214:
be_cont.33211:
bge_cont.33206:
be_cont.33203:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33215
ble_then.33215:
	bl      $i1, 0, bge_else.33216
bge_then.33216:
.count move_args
	mov     $i1, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33215
bge_else.33216:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33215
ble_else.33215:
	li      255, $i2
	call    ext_write
ble_cont.33215:
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33217
ble_then.33217:
	bl      $i1, 0, bge_else.33218
bge_then.33218:
.count move_args
	mov     $i1, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33217
bge_else.33218:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33217
ble_else.33217:
	li      255, $i2
	call    ext_write
ble_cont.33217:
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33219
ble_then.33219:
	bl      $i1, 0, bge_else.33220
bge_then.33220:
.count move_args
	mov     $i1, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33219
bge_else.33220:
	li      0, $i2
	call    ext_write
.count b_cont
	b       ble_cont.33219
ble_else.33219:
	li      255, $i2
	call    ext_write
ble_cont.33219:
	li      128, $i1
	add     $i32, 1, $i32
	bg      $i1, $i32, ble_else.33221
ble_then.33221:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.33221:
	load    [$i35 + $i32], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	bg      $i1, $i37, ble_else.33222
ble_then.33222:
	li      0, $i1
.count b_cont
	b       ble_cont.33222
ble_else.33222:
	bg      $i33, 0, ble_else.33223
ble_then.33223:
	li      0, $i1
.count b_cont
	b       ble_cont.33223
ble_else.33223:
	li      128, $i1
	add     $i32, 1, $i2
	bg      $i1, $i2, ble_else.33224
ble_then.33224:
	li      0, $i1
.count b_cont
	b       ble_cont.33224
ble_else.33224:
	bg      $i32, 0, ble_else.33225
ble_then.33225:
	li      0, $i1
.count b_cont
	b       ble_cont.33225
ble_else.33225:
	li      1, $i1
ble_cont.33225:
ble_cont.33224:
ble_cont.33223:
ble_cont.33222:
	bne     $i1, 0, be_else.33226
be_then.33226:
	load    [$i35 + $i32], $i30
	li      0, $i26
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.33226
bge_then.33227:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.33228
be_then.33228:
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33226
be_else.33228:
.count move_args
	mov     $i30, $i25
	call    calc_diffuse_using_1point.2942
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33226
be_else.33226:
	li      0, $i30
.count move_args
	mov     $i32, $i2
.count move_args
	mov     $i34, $i3
.count move_args
	mov     $i35, $i4
.count move_args
	mov     $i36, $i5
	call    try_exploit_neighbors.2967
be_cont.33226:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33229
ble_then.33229:
	bl      $i1, 0, bge_else.33230
bge_then.33230:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33229
bge_else.33230:
	li      0, $i2
.count b_cont
	b       ble_cont.33229
ble_else.33229:
	li      255, $i2
ble_cont.33229:
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33231
ble_then.33231:
	bl      $i1, 0, bge_else.33232
bge_then.33232:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33231
bge_else.33232:
	li      0, $i2
.count b_cont
	b       ble_cont.33231
ble_else.33231:
	li      255, $i2
ble_cont.33231:
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33233
ble_then.33233:
	bl      $i1, 0, bge_else.33234
bge_then.33234:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33233
bge_else.33234:
	li      0, $i2
.count b_cont
	b       ble_cont.33233
ble_else.33233:
	li      255, $i2
ble_cont.33233:
	call    ext_write
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i32, 1, $i32
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line($i37, $i38, $i39, $i40, $i41)
# $ra = $ra
# [$i1 - $i42]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16, $fg21 - $fg23]
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i37, ble_else.33235
ble_then.33235:
	ret
ble_else.33235:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	bge     $i37, 127, bl_cont.33236
bl_then.33236:
	add     $i37, 1, $i1
	sub     $i1, 64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f18
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg19, $f15
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg20, $f17
	li      127, $i33
.count move_args
	mov     $i40, $i32
.count move_args
	mov     $i41, $i34
	call    pretrace_pixels.2983
bl_cont.33236:
	li      0, $i2
	load    [$i39 + 0], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 0], $fg4
	load    [$i1 + 1], $fg5
	load    [$i1 + 2], $fg6
	li      128, $i1
	add     $i37, 1, $i42
	bg      $i1, $i42, ble_else.33237
ble_then.33237:
	li      0, $i1
.count b_cont
	b       ble_cont.33237
ble_else.33237:
	li      0, $i1
ble_cont.33237:
	bne     $i1, 0, be_else.33238
be_then.33238:
	load    [$i39 + 0], $i30
	li      0, $i26
	load    [$i30 + 2], $i1
	load    [$i1 + 0], $i1
	bl      $i1, 0, be_cont.33238
bge_then.33239:
	load    [$i30 + 3], $i1
	load    [$i1 + 0], $i1
	bne     $i1, 0, be_else.33240
be_then.33240:
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33238
be_else.33240:
.count move_args
	mov     $i30, $i25
	call    calc_diffuse_using_1point.2942
	li      1, $i25
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.33238
be_else.33238:
	li      0, $i30
.count move_args
	mov     $i38, $i3
.count move_args
	mov     $i39, $i4
.count move_args
	mov     $i40, $i5
	call    try_exploit_neighbors.2967
be_cont.33238:
	li      255, $i4
.count move_args
	mov     $fg4, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33241
ble_then.33241:
	bl      $i1, 0, bge_else.33242
bge_then.33242:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33241
bge_else.33242:
	li      0, $i2
.count b_cont
	b       ble_cont.33241
ble_else.33241:
	li      255, $i2
ble_cont.33241:
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg5, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33243
ble_then.33243:
	bl      $i1, 0, bge_else.33244
bge_then.33244:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33243
bge_else.33244:
	li      0, $i2
.count b_cont
	b       ble_cont.33243
ble_else.33243:
	li      255, $i2
ble_cont.33243:
	call    ext_write
	li      255, $i4
.count move_args
	mov     $fg6, $f2
	call    ext_int_of_float
	bg      $i1, $i4, ble_else.33245
ble_then.33245:
	bl      $i1, 0, bge_else.33246
bge_then.33246:
	mov     $i1, $i2
.count b_cont
	b       ble_cont.33245
bge_else.33246:
	li      0, $i2
.count b_cont
	b       ble_cont.33245
ble_else.33245:
	li      255, $i2
ble_cont.33245:
	call    ext_write
	li      1, $i32
.count move_args
	mov     $i37, $i33
.count move_args
	mov     $i38, $i34
.count move_args
	mov     $i39, $i35
.count move_args
	mov     $i40, $i36
	call    scan_pixel.2994
	li      128, $i1
	bg      $i1, $i42, ble_else.33247
ble_then.33247:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
ble_else.33247:
	add     $i41, 2, $i1
	bl      $i1, 5, bge_else.33248
bge_then.33248:
	sub     $i1, 5, $i41
.count b_cont
	b       bge_cont.33248
bge_else.33248:
	mov     $i1, $i41
bge_cont.33248:
	bge     $i42, 127, bl_cont.33249
bl_then.33249:
	add     $i42, 1, $i1
	li      127, $i33
	sub     $i1, 64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f18
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg19, $f15
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg20, $f17
.count move_args
	mov     $i38, $i32
.count move_args
	mov     $i41, $i34
	call    pretrace_pixels.2983
bl_cont.33249:
	li      0, $i32
.count move_args
	mov     $i42, $i33
.count move_args
	mov     $i39, $i34
.count move_args
	mov     $i40, $i35
.count move_args
	mov     $i38, $i36
	call    scan_pixel.2994
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	add     $i42, 1, $i37
	add     $i41, 2, $i41
.count move_args
	mov     $i38, $tmp
.count move_args
	mov     $i40, $i38
.count move_args
	mov     $i39, $i40
.count move_args
	mov     $tmp, $i39
	bl      $i41, 5, scan_line.3000
	sub     $i41, 5, $i41
	b       scan_line.3000
.end scan_line

######################################################################
# $i1 = create_pixel()
# $ra = $ra
# [$i1 - $i8]
# [$f2]
# []
# []
######################################################################
.begin create_pixel
create_pixel.3008:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 2], $i4
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
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 3]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 4], $i6
	store   $i1, [$i6 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 5]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 5], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 7]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 7], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	store   $i1, [$i8 + 4]
	mov     $hp, $i1
	add     $hp, 8, $hp
	store   $i8, [$i1 + 7]
.count stack_load
	load    [$sp - 2], $i2
	store   $i2, [$i1 + 6]
	store   $i7, [$i1 + 5]
	store   $i6, [$i1 + 4]
	store   $i5, [$i1 + 3]
.count stack_load
	load    [$sp - 5], $i2
	store   $i2, [$i1 + 2]
	store   $i4, [$i1 + 1]
.count stack_load
	load    [$sp - 7], $i2
	store   $i2, [$i1 + 0]
	ret
.end create_pixel

######################################################################
# $i1 = init_line_elements($i9, $i4)
# $ra = $ra
# [$i1 - $i10]
# [$f2]
# []
# []
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i4, 0, bge_else.33251
bge_then.33251:
.count stack_move
	sub     $sp, 15, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 2], $i5
	store   $i1, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 3]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 4], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 5]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 5], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 7]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 7], $i10
	store   $i1, [$i10 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 4]
	mov     $hp, $i1
	add     $hp, 8, $hp
	store   $i10, [$i1 + 7]
.count stack_load
	load    [$sp + 6], $i2
	store   $i2, [$i1 + 6]
	store   $i8, [$i1 + 5]
	store   $i7, [$i1 + 4]
	store   $i6, [$i1 + 3]
.count stack_load
	load    [$sp + 3], $i2
	store   $i2, [$i1 + 2]
	store   $i5, [$i1 + 1]
.count stack_load
	load    [$sp + 1], $i2
	store   $i2, [$i1 + 0]
.count storer
	add     $i9, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i10
	bl      $i10, 0, bge_else.33252
bge_then.33252:
	call    create_pixel.3008
.count storer
	add     $i9, $i10, $tmp
	store   $i1, [$tmp + 0]
	sub     $i10, 1, $i4
	bl      $i4, 0, bge_else.33253
bge_then.33253:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 8]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 9]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 9], $i5
	store   $i1, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 10]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 11]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 11], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 12]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 12], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 13]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 14]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 14], $i10
	store   $i1, [$i10 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i10 + 4]
	mov     $hp, $i1
	add     $hp, 8, $hp
	store   $i10, [$i1 + 7]
.count stack_load
	load    [$sp + 13], $i2
	store   $i2, [$i1 + 6]
	store   $i8, [$i1 + 5]
	store   $i7, [$i1 + 4]
	store   $i6, [$i1 + 3]
.count stack_load
	load    [$sp + 10], $i2
	store   $i2, [$i1 + 2]
	store   $i5, [$i1 + 1]
.count stack_load
	load    [$sp + 8], $i2
	store   $i2, [$i1 + 0]
.count storer
	add     $i9, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i10
	bl      $i10, 0, bge_else.33254
bge_then.33254:
	call    create_pixel.3008
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
.count storer
	add     $i9, $i10, $tmp
	store   $i1, [$tmp + 0]
	sub     $i10, 1, $i4
	b       init_line_elements.3010
bge_else.33254:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
	mov     $i9, $i1
	ret
bge_else.33253:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
	mov     $i9, $i1
	ret
bge_else.33252:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
	mov     $i9, $i1
	ret
bge_else.33251:
	mov     $i9, $i1
	ret
.end init_line_elements

######################################################################
# calc_dirvec($i1, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f12]
# []
# []
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i1, 5, bge_else.33255
bge_then.33255:
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
	ret
bge_else.33255:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fmul    $f2, $f2, $f1
	fadd    $f1, $fc8, $f1
	fsqrt   $f1, $f11
	finv    $f11, $f2
	call    ext_atan
	fmul    $f1, $f9, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
.count stack_store
	store   $f1, [$sp + 1]
.count move_args
	mov     $f8, $f2
	call    ext_cos
	finv    $f1, $f1
.count stack_load
	load    [$sp + 1], $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f11, $f11
	fmul    $f11, $f11, $f1
	fadd    $f1, $fc8, $f1
	fsqrt   $f1, $f12
	finv    $f12, $f2
	call    ext_atan
	fmul    $f1, $f10, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
.count stack_store
	store   $f1, [$sp + 2]
.count move_args
	mov     $f8, $f2
	call    ext_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	finv    $f1, $f1
.count stack_load
	load    [$sp - 1], $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $f12, $f2
	add     $i1, 1, $i1
.count move_args
	mov     $f11, $f1
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs($i5, $f13, $i6, $i7)
# $ra = $ra
# [$i1 - $i8]
# [$f1 - $f14]
# []
# []
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i5, 0, bge_else.33256
bge_then.33256:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i1
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i7, 2, $i8
	fadd    $f14, $fc8, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	call    calc_dirvec.3020
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33257
bge_then.33257:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.33258
bge_then.33258:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33258
bge_else.33258:
	mov     $i2, $i6
bge_cont.33258:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f14, $fc8, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	call    calc_dirvec.3020
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33259
bge_then.33259:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.33260
bge_then.33260:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33260
bge_else.33260:
	mov     $i2, $i6
bge_cont.33260:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f14, $fc8, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	call    calc_dirvec.3020
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33261
bge_then.33261:
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.33262
bge_then.33262:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33262
bge_else.33262:
	mov     $i2, $i6
bge_cont.33262:
.count move_args
	mov     $i5, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f14
	fsub    $f14, $fc11, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i7, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f14, $fc8, $f9
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i8, $i4
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i5, 1, $i5
	add     $i6, 1, $i6
	bl      $i6, 5, calc_dirvecs.3028
	sub     $i6, 5, $i6
	b       calc_dirvecs.3028
bge_else.33261:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33259:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33257:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33256:
	ret
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra
# [$i1 - $i11]
# [$f1 - $f18]
# []
# []
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i9, 0, bge_else.33264
bge_then.33264:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      0, $i1
	li      4, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f13
	fsub    $f13, $fc11, $f15
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
	mov     $f15, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i11, 2, $i5
	fadd    $f13, $fc8, $f16
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
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bge_else.33265
bge_then.33265:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33265
bge_else.33265:
	mov     $i2, $i6
bge_cont.33265:
	li      3, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f13
	fsub    $f13, $fc11, $f17
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f17, $f9
.count move_args
	mov     $f14, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f13, $fc8, $f18
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
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i6, 1, $i2
	bl      $i2, 5, bge_else.33266
bge_then.33266:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33266
bge_else.33266:
	mov     $i2, $i6
bge_cont.33266:
	li      2, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f13
	fsub    $f13, $fc11, $f9
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
	call    calc_dirvec.3020
	li      0, $i1
	fadd    $f13, $fc8, $f9
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
	call    calc_dirvec.3020
	li      1, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.33267
bge_then.33267:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.33267
bge_else.33267:
	mov     $i1, $i6
bge_cont.33267:
.count move_args
	mov     $f14, $f13
.count move_args
	mov     $i11, $i7
	call    calc_dirvecs.3028
	sub     $i9, 1, $i9
	bl      $i9, 0, bge_else.33268
bge_then.33268:
	add     $i10, 2, $i1
	bl      $i1, 5, bge_else.33269
bge_then.33269:
	sub     $i1, 5, $i10
.count b_cont
	b       bge_cont.33269
bge_else.33269:
	mov     $i1, $i10
bge_cont.33269:
	add     $i11, 4, $i11
	li      0, $i1
.count move_args
	mov     $i9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
	fsub    $f1, $fc11, $f13
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f15, $f9
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i11, 2, $i5
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f16, $f9
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      0, $i1
	add     $i10, 1, $i2
	bl      $i2, 5, bge_else.33270
bge_then.33270:
	sub     $i2, 5, $i6
.count b_cont
	b       bge_cont.33270
bge_else.33270:
	mov     $i2, $i6
bge_cont.33270:
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f17, $f9
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i11, $i4
	call    calc_dirvec.3020
	li      0, $i1
.count move_args
	mov     $f0, $f1
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f18, $f9
.count move_args
	mov     $f13, $f10
.count move_args
	mov     $i6, $i3
.count move_args
	mov     $i5, $i4
	call    calc_dirvec.3020
	li      2, $i5
	add     $i6, 1, $i1
	bl      $i1, 5, bge_else.33271
bge_then.33271:
	sub     $i1, 5, $i6
.count b_cont
	b       bge_cont.33271
bge_else.33271:
	mov     $i1, $i6
bge_cont.33271:
.count move_args
	mov     $i11, $i7
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i9, 1, $i9
	add     $i10, 2, $i10
	add     $i11, 4, $i11
	bl      $i10, 5, calc_dirvec_rows.3033
	sub     $i10, 5, $i10
	b       calc_dirvec_rows.3033
bge_else.33268:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33264:
	ret
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements($i4, $i5)
# $ra = $ra
# [$i1 - $i5]
# [$f2]
# []
# []
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i5, 0, bge_else.33273
bge_then.33273:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 1]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 1], $i1
	store   $i1, [$i2 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i2, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33274
bge_then.33274:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 2]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 2], $i1
	store   $i1, [$i2 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i2, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33275
bge_then.33275:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 3]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 3], $i1
	store   $i1, [$i2 + 0]
.count storer
	add     $i4, $i5, $tmp
	store   $i2, [$tmp + 0]
	sub     $i5, 1, $i5
	bl      $i5, 0, bge_else.33276
bge_then.33276:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 4]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
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
bge_else.33276:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.33275:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.33274:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.33273:
	ret
.end create_dirvec_elements

######################################################################
# create_dirvecs($i6)
# $ra = $ra
# [$i1 - $i6]
# [$f2]
# []
# []
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i6, 0, bge_else.33277
bge_then.33277:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 1]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i1, [$i3 + 1]
.count stack_load
	load    [$sp + 1], $i1
	store   $i1, [$i3 + 0]
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 2]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	load    [ext_dirvecs + $i6], $i4
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 2], $i1
	store   $i1, [$i2 + 0]
	store   $i2, [$i4 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 3]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 3], $i1
	store   $i1, [$i2 + 0]
	store   $i2, [$i4 + 117]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 4]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 4], $i1
	store   $i1, [$i2 + 0]
	store   $i2, [$i4 + 116]
	li      115, $i5
	call    create_dirvec_elements.3039
	sub     $i6, 1, $i6
	bl      $i6, 0, bge_else.33278
bge_then.33278:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 5]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i1, [$i3 + 1]
.count stack_load
	load    [$sp + 5], $i1
	store   $i1, [$i3 + 0]
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + $i6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 6]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	load    [ext_dirvecs + $i6], $i4
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 6], $i1
	store   $i1, [$i2 + 0]
	store   $i2, [$i4 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 7]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp + 7], $i1
	store   $i1, [$i2 + 0]
	store   $i2, [$i4 + 117]
	li      116, $i5
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	sub     $i6, 1, $i6
	b       create_dirvecs.3042
bge_else.33278:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.33277:
	ret
.end create_dirvecs

######################################################################
# init_dirvec_constants($i11, $i12)
# $ra = $ra
# [$i1 - $i12]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i12, 0, bge_else.33279
bge_then.33279:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	sub     $ig0, 1, $i4
	load    [$i11 + $i12], $i6
	bl      $i4, 0, bge_cont.33280
bge_then.33280:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33281
be_then.33281:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33282
be_then.33282:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33282
be_else.33282:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33283
ble_then.33283:
	li      0, $i3
.count b_cont
	b       ble_cont.33283
ble_else.33283:
	li      1, $i3
ble_cont.33283:
	bne     $i2, 0, be_else.33284
be_then.33284:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33284
be_else.33284:
	bne     $i3, 0, be_else.33285
be_then.33285:
	li      1, $i2
.count b_cont
	b       be_cont.33285
be_else.33285:
	li      0, $i2
be_cont.33285:
be_cont.33284:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33286
be_then.33286:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33286
be_else.33286:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33286:
be_cont.33282:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33287
be_then.33287:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33287
be_else.33287:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33288
ble_then.33288:
	li      0, $i3
.count b_cont
	b       ble_cont.33288
ble_else.33288:
	li      1, $i3
ble_cont.33288:
	bne     $i2, 0, be_else.33289
be_then.33289:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33289
be_else.33289:
	bne     $i3, 0, be_else.33290
be_then.33290:
	li      1, $i2
.count b_cont
	b       be_cont.33290
be_else.33290:
	li      0, $i2
be_cont.33290:
be_cont.33289:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33291
be_then.33291:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33291
be_else.33291:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33291:
be_cont.33287:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33292
be_then.33292:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33281
be_else.33292:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33293
ble_then.33293:
	li      0, $i3
.count b_cont
	b       ble_cont.33293
ble_else.33293:
	li      1, $i3
ble_cont.33293:
	bne     $i2, 0, be_else.33294
be_then.33294:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33294
be_else.33294:
	bne     $i3, 0, be_else.33295
be_then.33295:
	li      1, $i2
.count b_cont
	b       be_cont.33295
be_else.33295:
	li      0, $i2
be_cont.33295:
be_cont.33294:
	load    [$i7 + 4], $i3
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.33296
be_then.33296:
	fneg    $f1, $f1
be_cont.33296:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33281
be_else.33281:
	bne     $i1, 2, be_else.33297
be_then.33297:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33298
ble_then.33298:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33297
ble_else.33298:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33297
be_else.33297:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33299
be_then.33299:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33299
be_else.33299:
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
be_cont.33299:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33300
be_then.33300:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33301
be_then.33301:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33300
be_else.33301:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33300
be_else.33300:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33302
be_then.33302:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33302
be_else.33302:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33302:
be_cont.33300:
be_cont.33297:
be_cont.33281:
bge_cont.33280:
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_else.33303
bge_then.33303:
	sub     $ig0, 1, $i4
	load    [$i11 + $i12], $i6
	bl      $i4, 0, bge_cont.33304
bge_then.33304:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33305
be_then.33305:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33306
be_then.33306:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33306
be_else.33306:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33307
ble_then.33307:
	li      0, $i3
.count b_cont
	b       ble_cont.33307
ble_else.33307:
	li      1, $i3
ble_cont.33307:
	bne     $i2, 0, be_else.33308
be_then.33308:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33308
be_else.33308:
	bne     $i3, 0, be_else.33309
be_then.33309:
	li      1, $i2
.count b_cont
	b       be_cont.33309
be_else.33309:
	li      0, $i2
be_cont.33309:
be_cont.33308:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33310
be_then.33310:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33310
be_else.33310:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33310:
be_cont.33306:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33311
be_then.33311:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33311
be_else.33311:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33312
ble_then.33312:
	li      0, $i3
.count b_cont
	b       ble_cont.33312
ble_else.33312:
	li      1, $i3
ble_cont.33312:
	bne     $i2, 0, be_else.33313
be_then.33313:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33313
be_else.33313:
	bne     $i3, 0, be_else.33314
be_then.33314:
	li      1, $i2
.count b_cont
	b       be_cont.33314
be_else.33314:
	li      0, $i2
be_cont.33314:
be_cont.33313:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33315
be_then.33315:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33315
be_else.33315:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33315:
be_cont.33311:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33316
be_then.33316:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33305
be_else.33316:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33317
ble_then.33317:
	li      0, $i7
.count b_cont
	b       ble_cont.33317
ble_else.33317:
	li      1, $i7
ble_cont.33317:
	bne     $i2, 0, be_else.33318
be_then.33318:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33318
be_else.33318:
	bne     $i7, 0, be_else.33319
be_then.33319:
	li      1, $i2
.count b_cont
	b       be_cont.33319
be_else.33319:
	li      0, $i2
be_cont.33319:
be_cont.33318:
	load    [$i3 + 2], $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33320
be_then.33320:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33305
be_else.33320:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33305
be_else.33305:
	bne     $i1, 2, be_else.33321
be_then.33321:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33322
ble_then.33322:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33321
ble_else.33322:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33321
be_else.33321:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33323
be_then.33323:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33323
be_else.33323:
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
be_cont.33323:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33324
be_then.33324:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33325
be_then.33325:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33324
be_else.33325:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33324
be_else.33324:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33326
be_then.33326:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33326
be_else.33326:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33326:
be_cont.33324:
be_cont.33321:
be_cont.33305:
bge_cont.33304:
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_else.33327
bge_then.33327:
	sub     $ig0, 1, $i5
	load    [$i11 + $i12], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_else.33328
bge_then.33328:
	sub     $ig0, 1, $i4
	bl      $i4, 0, bge_else.33329
bge_then.33329:
	load    [$i11 + $i12], $i6
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33330
be_then.33330:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33331
be_then.33331:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33331
be_else.33331:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33332
ble_then.33332:
	li      0, $i3
.count b_cont
	b       ble_cont.33332
ble_else.33332:
	li      1, $i3
ble_cont.33332:
	bne     $i2, 0, be_else.33333
be_then.33333:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33333
be_else.33333:
	bne     $i3, 0, be_else.33334
be_then.33334:
	li      1, $i2
.count b_cont
	b       be_cont.33334
be_else.33334:
	li      0, $i2
be_cont.33334:
be_cont.33333:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33335
be_then.33335:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33335
be_else.33335:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33335:
be_cont.33331:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33336
be_then.33336:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33336
be_else.33336:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33337
ble_then.33337:
	li      0, $i3
.count b_cont
	b       ble_cont.33337
ble_else.33337:
	li      1, $i3
ble_cont.33337:
	bne     $i2, 0, be_else.33338
be_then.33338:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33338
be_else.33338:
	bne     $i3, 0, be_else.33339
be_then.33339:
	li      1, $i2
.count b_cont
	b       be_cont.33339
be_else.33339:
	li      0, $i2
be_cont.33339:
be_cont.33338:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33340
be_then.33340:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33340
be_else.33340:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33340:
be_cont.33336:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33341
be_then.33341:
	store   $f0, [$i1 + 5]
.count b_cont
	b       be_cont.33341
be_else.33341:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33342
ble_then.33342:
	li      0, $i7
.count b_cont
	b       ble_cont.33342
ble_else.33342:
	li      1, $i7
ble_cont.33342:
	bne     $i2, 0, be_else.33343
be_then.33343:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33343
be_else.33343:
	bne     $i7, 0, be_else.33344
be_then.33344:
	li      1, $i2
.count b_cont
	b       be_cont.33344
be_else.33344:
	li      0, $i2
be_cont.33344:
be_cont.33343:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_else.33345
be_then.33345:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count b_cont
	b       be_cont.33345
be_else.33345:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
be_cont.33345:
be_cont.33341:
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i12, 1, $i12
	b       init_dirvec_constants.3044
be_else.33330:
	bne     $i1, 2, be_else.33346
be_then.33346:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	bg      $f1, $f0, ble_else.33347
ble_then.33347:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
.count b_cont
	b       be_cont.33346
ble_else.33347:
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
.count b_cont
	b       be_cont.33346
be_else.33346:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33348
be_then.33348:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33348
be_else.33348:
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
be_cont.33348:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	bne     $i2, 0, be_else.33349
be_then.33349:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33350
be_then.33350:
	store   $i1, [$tmp + 0]
.count b_cont
	b       be_cont.33349
be_else.33350:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count b_cont
	b       be_cont.33349
be_else.33349:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33351
be_then.33351:
	store   $i1, [$tmp + 0]
.count b_cont
	b       be_cont.33351
be_else.33351:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
be_cont.33351:
be_cont.33349:
be_cont.33346:
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i12, 1, $i12
	b       init_dirvec_constants.3044
bge_else.33329:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i12, 1, $i12
	b       init_dirvec_constants.3044
bge_else.33328:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33327:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33303:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33279:
	ret
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i13)
# $ra = $ra
# [$i1 - $i13]
# [$f1 - $f8]
# []
# []
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i13, 0, bge_else.33352
bge_then.33352:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	sub     $ig0, 1, $i4
	load    [ext_dirvecs + $i13], $i11
	load    [$i11 + 119], $i6
	bl      $i4, 0, bge_cont.33353
bge_then.33353:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33354
be_then.33354:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33355
be_then.33355:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33355
be_else.33355:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33356
ble_then.33356:
	li      0, $i3
.count b_cont
	b       ble_cont.33356
ble_else.33356:
	li      1, $i3
ble_cont.33356:
	bne     $i2, 0, be_else.33357
be_then.33357:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33357
be_else.33357:
	bne     $i3, 0, be_else.33358
be_then.33358:
	li      1, $i2
.count b_cont
	b       be_cont.33358
be_else.33358:
	li      0, $i2
be_cont.33358:
be_cont.33357:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33359
be_then.33359:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33359
be_else.33359:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33359:
be_cont.33355:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33360
be_then.33360:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33360
be_else.33360:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33361
ble_then.33361:
	li      0, $i3
.count b_cont
	b       ble_cont.33361
ble_else.33361:
	li      1, $i3
ble_cont.33361:
	bne     $i2, 0, be_else.33362
be_then.33362:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33362
be_else.33362:
	bne     $i3, 0, be_else.33363
be_then.33363:
	li      1, $i2
.count b_cont
	b       be_cont.33363
be_else.33363:
	li      0, $i2
be_cont.33363:
be_cont.33362:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33364
be_then.33364:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33364
be_else.33364:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33364:
be_cont.33360:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33365
be_then.33365:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33354
be_else.33365:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33366
ble_then.33366:
	li      0, $i7
.count b_cont
	b       ble_cont.33366
ble_else.33366:
	li      1, $i7
ble_cont.33366:
	bne     $i2, 0, be_else.33367
be_then.33367:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33367
be_else.33367:
	bne     $i7, 0, be_else.33368
be_then.33368:
	li      1, $i2
.count b_cont
	b       be_cont.33368
be_else.33368:
	li      0, $i2
be_cont.33368:
be_cont.33367:
	load    [$i3 + 2], $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33369
be_then.33369:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33354
be_else.33369:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33354
be_else.33354:
	bne     $i1, 2, be_else.33370
be_then.33370:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33371
ble_then.33371:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33370
ble_else.33371:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33370
be_else.33370:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33372
be_then.33372:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33372
be_else.33372:
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
be_cont.33372:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33373
be_then.33373:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33374
be_then.33374:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33373
be_else.33374:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33373
be_else.33373:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33375
be_then.33375:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33375
be_else.33375:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33375:
be_cont.33373:
be_cont.33370:
be_cont.33354:
bge_cont.33353:
	sub     $ig0, 1, $i5
	load    [$i11 + 118], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i4
	load    [$i11 + 117], $i6
	bl      $i4, 0, bge_cont.33376
bge_then.33376:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33377
be_then.33377:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33378
be_then.33378:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33378
be_else.33378:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33379
ble_then.33379:
	li      0, $i3
.count b_cont
	b       ble_cont.33379
ble_else.33379:
	li      1, $i3
ble_cont.33379:
	bne     $i2, 0, be_else.33380
be_then.33380:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33380
be_else.33380:
	bne     $i3, 0, be_else.33381
be_then.33381:
	li      1, $i2
.count b_cont
	b       be_cont.33381
be_else.33381:
	li      0, $i2
be_cont.33381:
be_cont.33380:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33382
be_then.33382:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33382
be_else.33382:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33382:
be_cont.33378:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33383
be_then.33383:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33383
be_else.33383:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33384
ble_then.33384:
	li      0, $i3
.count b_cont
	b       ble_cont.33384
ble_else.33384:
	li      1, $i3
ble_cont.33384:
	bne     $i2, 0, be_else.33385
be_then.33385:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33385
be_else.33385:
	bne     $i3, 0, be_else.33386
be_then.33386:
	li      1, $i2
.count b_cont
	b       be_cont.33386
be_else.33386:
	li      0, $i2
be_cont.33386:
be_cont.33385:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33387
be_then.33387:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33387
be_else.33387:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33387:
be_cont.33383:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33388
be_then.33388:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33377
be_else.33388:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33389
ble_then.33389:
	li      0, $i7
.count b_cont
	b       ble_cont.33389
ble_else.33389:
	li      1, $i7
ble_cont.33389:
	bne     $i2, 0, be_else.33390
be_then.33390:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33390
be_else.33390:
	bne     $i7, 0, be_else.33391
be_then.33391:
	li      1, $i2
.count b_cont
	b       be_cont.33391
be_else.33391:
	li      0, $i2
be_cont.33391:
be_cont.33390:
	load    [$i3 + 2], $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33392
be_then.33392:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33377
be_else.33392:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33377
be_else.33377:
	bne     $i1, 2, be_else.33393
be_then.33393:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33394
ble_then.33394:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33393
ble_else.33394:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33393
be_else.33393:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33395
be_then.33395:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33395
be_else.33395:
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
be_cont.33395:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33396
be_then.33396:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33397
be_then.33397:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33396
be_else.33397:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33396
be_else.33396:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33398
be_then.33398:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33398
be_else.33398:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33398:
be_cont.33396:
be_cont.33393:
be_cont.33377:
bge_cont.33376:
	li      116, $i12
	call    init_dirvec_constants.3044
	sub     $i13, 1, $i13
	bl      $i13, 0, bge_else.33399
bge_then.33399:
	sub     $ig0, 1, $i5
	load    [ext_dirvecs + $i13], $i11
	load    [$i11 + 119], $i4
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i4
	load    [$i11 + 118], $i6
	bl      $i4, 0, bge_cont.33400
bge_then.33400:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33401
be_then.33401:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33402
be_then.33402:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33402
be_else.33402:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33403
ble_then.33403:
	li      0, $i3
.count b_cont
	b       ble_cont.33403
ble_else.33403:
	li      1, $i3
ble_cont.33403:
	bne     $i2, 0, be_else.33404
be_then.33404:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33404
be_else.33404:
	bne     $i3, 0, be_else.33405
be_then.33405:
	li      1, $i2
.count b_cont
	b       be_cont.33405
be_else.33405:
	li      0, $i2
be_cont.33405:
be_cont.33404:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33406
be_then.33406:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33406
be_else.33406:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33406:
be_cont.33402:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33407
be_then.33407:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33407
be_else.33407:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33408
ble_then.33408:
	li      0, $i3
.count b_cont
	b       ble_cont.33408
ble_else.33408:
	li      1, $i3
ble_cont.33408:
	bne     $i2, 0, be_else.33409
be_then.33409:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33409
be_else.33409:
	bne     $i3, 0, be_else.33410
be_then.33410:
	li      1, $i2
.count b_cont
	b       be_cont.33410
be_else.33410:
	li      0, $i2
be_cont.33410:
be_cont.33409:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33411
be_then.33411:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33411
be_else.33411:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33411:
be_cont.33407:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33412
be_then.33412:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33401
be_else.33412:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33413
ble_then.33413:
	li      0, $i7
.count b_cont
	b       ble_cont.33413
ble_else.33413:
	li      1, $i7
ble_cont.33413:
	bne     $i2, 0, be_else.33414
be_then.33414:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33414
be_else.33414:
	bne     $i7, 0, be_else.33415
be_then.33415:
	li      1, $i2
.count b_cont
	b       be_cont.33415
be_else.33415:
	li      0, $i2
be_cont.33415:
be_cont.33414:
	load    [$i3 + 2], $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33416
be_then.33416:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33401
be_else.33416:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33401
be_else.33401:
	bne     $i1, 2, be_else.33417
be_then.33417:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33418
ble_then.33418:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33417
ble_else.33418:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33417
be_else.33417:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33419
be_then.33419:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33419
be_else.33419:
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
be_cont.33419:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33420
be_then.33420:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33421
be_then.33421:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33420
be_else.33421:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33420
be_else.33420:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33422
be_then.33422:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33422
be_else.33422:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33422:
be_cont.33420:
be_cont.33417:
be_cont.33401:
bge_cont.33400:
	li      117, $i12
	call    init_dirvec_constants.3044
	sub     $i13, 1, $i13
	bl      $i13, 0, bge_else.33423
bge_then.33423:
	sub     $ig0, 1, $i4
	load    [ext_dirvecs + $i13], $i11
	load    [$i11 + 119], $i6
	bl      $i4, 0, bge_cont.33424
bge_then.33424:
	load    [$i6 + 1], $i5
	load    [ext_objects + $i4], $i7
	load    [$i7 + 1], $i1
	load    [$i6 + 0], $i8
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33425
be_then.33425:
	li      6, $i2
	call    ext_create_array_float
	load    [$i8 + 0], $f1
	bne     $f1, $f0, be_else.33426
be_then.33426:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33426
be_else.33426:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33427
ble_then.33427:
	li      0, $i3
.count b_cont
	b       ble_cont.33427
ble_else.33427:
	li      1, $i3
ble_cont.33427:
	bne     $i2, 0, be_else.33428
be_then.33428:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33428
be_else.33428:
	bne     $i3, 0, be_else.33429
be_then.33429:
	li      1, $i2
.count b_cont
	b       be_cont.33429
be_else.33429:
	li      0, $i2
be_cont.33429:
be_cont.33428:
	load    [$i7 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33430
be_then.33430:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33430
be_else.33430:
	store   $f1, [$i1 + 0]
	load    [$i8 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33430:
be_cont.33426:
	load    [$i8 + 1], $f1
	bne     $f1, $f0, be_else.33431
be_then.33431:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33431
be_else.33431:
	load    [$i7 + 6], $i2
	bg      $f0, $f1, ble_else.33432
ble_then.33432:
	li      0, $i3
.count b_cont
	b       ble_cont.33432
ble_else.33432:
	li      1, $i3
ble_cont.33432:
	bne     $i2, 0, be_else.33433
be_then.33433:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33433
be_else.33433:
	bne     $i3, 0, be_else.33434
be_then.33434:
	li      1, $i2
.count b_cont
	b       be_cont.33434
be_else.33434:
	li      0, $i2
be_cont.33434:
be_cont.33433:
	load    [$i7 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33435
be_then.33435:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33435
be_else.33435:
	store   $f1, [$i1 + 2]
	load    [$i8 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33435:
be_cont.33431:
	load    [$i8 + 2], $f1
	bne     $f1, $f0, be_else.33436
be_then.33436:
	store   $f0, [$i1 + 5]
.count storer
	add     $i5, $i4, $tmp
	store   $i1, [$tmp + 0]
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33425
be_else.33436:
	load    [$i7 + 6], $i2
	load    [$i7 + 4], $i3
	bg      $f0, $f1, ble_else.33437
ble_then.33437:
	li      0, $i7
.count b_cont
	b       ble_cont.33437
ble_else.33437:
	li      1, $i7
ble_cont.33437:
	bne     $i2, 0, be_else.33438
be_then.33438:
	mov     $i7, $i2
.count b_cont
	b       be_cont.33438
be_else.33438:
	bne     $i7, 0, be_else.33439
be_then.33439:
	li      1, $i2
.count b_cont
	b       be_cont.33439
be_else.33439:
	li      0, $i2
be_cont.33439:
be_cont.33438:
	load    [$i3 + 2], $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33440
be_then.33440:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33425
be_else.33440:
	store   $f1, [$i1 + 4]
	load    [$i8 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33425
be_else.33425:
	bne     $i1, 2, be_else.33441
be_then.33441:
	li      4, $i2
	call    ext_create_array_float
	load    [$i7 + 4], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i8 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i8 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i8 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bg      $f1, $f0, ble_else.33442
ble_then.33442:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33441
ble_else.33442:
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
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33441
be_else.33441:
	li      5, $i2
	call    ext_create_array_float
	load    [$i7 + 3], $i2
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f1
	load    [$i8 + 1], $f2
	load    [$i8 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33443
be_then.33443:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33443
be_else.33443:
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
be_cont.33443:
	store   $f1, [$i1 + 0]
	load    [$i7 + 4], $i3
	load    [$i7 + 4], $i9
	load    [$i7 + 4], $i10
	load    [$i8 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i8 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i5, $i4, $tmp
	sub     $i4, 1, $i5
.count move_args
	mov     $i6, $i4
	bne     $i2, 0, be_else.33444
be_then.33444:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.33445
be_then.33445:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33444
be_else.33445:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33444
be_else.33444:
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
	load    [$i8 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i8 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.33446
be_then.33446:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33446
be_else.33446:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33446:
be_cont.33444:
be_cont.33441:
be_cont.33425:
bge_cont.33424:
	li      118, $i12
	call    init_dirvec_constants.3044
	sub     $i13, 1, $i13
	bl      $i13, 0, bge_else.33447
bge_then.33447:
	load    [ext_dirvecs + $i13], $i11
	li      119, $i12
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	sub     $i13, 1, $i13
	b       init_vecset_constants.3047
bge_else.33447:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33423:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33399:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	ret
bge_else.33352:
	ret
.end init_vecset_constants

######################################################################
# setup_reflections($i11)
# $ra = $ra
# [$i1 - $i13]
# [$f1 - $f12]
# [$ig4]
# []
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i11, 0, bge_else.33448
bge_then.33448:
	load    [ext_objects + $i11], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.33449
be_then.33449:
	load    [$i1 + 7], $i2
	load    [$i2 + 0], $f9
	bg      $fc0, $f9, ble_else.33450
ble_then.33450:
	ret
ble_else.33450:
	load    [$i1 + 1], $i2
	bne     $i2, 1, be_else.33451
be_then.33451:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 7], $i12
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 1]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 1], $i2
	store   $fg12, [$i2 + 0]
	fneg    $fg13, $f9
	store   $f9, [$i2 + 1]
	fneg    $fg14, $f10
	store   $f10, [$i2 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i13
	add     $hp, 2, $hp
	store   $i1, [$i13 + 1]
	store   $i2, [$i13 + 0]
.count move_args
	mov     $i13, $i4
	call    iter_setup_dirvec_constants.2826
	add     $i11, $i11, $i1
	add     $i1, $i1, $i11
	add     $i11, 1, $i1
	load    [$i12 + 0], $f1
	fsub    $fc0, $f1, $f11
	mov     $hp, $i2
	add     $hp, 3, $hp
	store   $f11, [$i2 + 2]
	store   $i13, [$i2 + 1]
	store   $i1, [$i2 + 0]
	store   $i2, [ext_reflections + $ig4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 2]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	fneg    $fg12, $f12
.count stack_load
	load    [$sp + 2], $i2
	store   $f12, [$i2 + 0]
	store   $fg13, [$i2 + 1]
	store   $f10, [$i2 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i1, [$i12 + 1]
	store   $i2, [$i12 + 0]
.count move_args
	mov     $i12, $i4
	call    iter_setup_dirvec_constants.2826
	add     $ig4, 1, $i1
	add     $i11, 2, $i2
	mov     $hp, $i3
	add     $hp, 3, $hp
	store   $f11, [$i3 + 2]
	store   $i12, [$i3 + 1]
	store   $i2, [$i3 + 0]
	store   $i3, [ext_reflections + $i1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 3]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 3], $i2
	store   $f12, [$i2 + 0]
	store   $f9, [$i2 + 1]
	store   $fg14, [$i2 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i1, [$i12 + 1]
	store   $i2, [$i12 + 0]
.count move_args
	mov     $i12, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $ig4, 2, $i1
	add     $i11, 3, $i2
	mov     $hp, $i3
	add     $hp, 3, $hp
	store   $f11, [$i3 + 2]
	store   $i12, [$i3 + 1]
	store   $i2, [$i3 + 0]
	store   $i3, [ext_reflections + $i1]
	add     $ig4, 3, $ig4
	ret
be_else.33451:
	bne     $i2, 2, be_else.33452
be_then.33452:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_store
	store   $i1, [$sp + 4]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	load    [$i4 + 0], $f1
	fmul    $fc10, $f1, $f2
	fmul    $fg12, $f1, $f1
	load    [$i5 + 1], $f3
	fmul    $fg13, $f3, $f4
	fadd    $f1, $f4, $f1
	load    [$i5 + 2], $f4
	fmul    $fg14, $f4, $f5
	fadd    $f1, $f5, $f1
	fmul    $f2, $f1, $f2
	fsub    $f2, $fg12, $f2
.count stack_load
	load    [$sp + 4], $i2
	store   $f2, [$i2 + 0]
	fmul    $fc10, $f3, $f2
	fmul    $f2, $f1, $f2
	fsub    $f2, $fg13, $f2
	store   $f2, [$i2 + 1]
	fmul    $fc10, $f4, $f2
	fmul    $f2, $f1, $f1
	fsub    $f1, $fg14, $f1
	store   $f1, [$i2 + 2]
	sub     $ig0, 1, $i5
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i1, [$i12 + 1]
	store   $i2, [$i12 + 0]
.count move_args
	mov     $i12, $i4
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fsub    $fc0, $f9, $f1
	add     $i11, $i11, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	store   $f1, [$i2 + 2]
	store   $i12, [$i2 + 1]
	store   $i1, [$i2 + 0]
	store   $i2, [ext_reflections + $ig4]
	add     $ig4, 1, $ig4
	ret
be_else.33452:
	ret
be_else.33449:
	ret
bge_else.33448:
	ret
.end setup_reflections

######################################################################
# main
######################################################################
.begin main
ext_main:
.count stack_move
	sub     $sp, 32, $sp
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
.count stack_store
	store   $i1, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 2], $i4
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
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 3]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i5
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 4], $i6
	store   $i1, [$i6 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i6 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 5]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 5], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 7]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 7], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i8, [$i3 + 7]
.count stack_load
	load    [$sp + 6], $i1
	store   $i1, [$i3 + 6]
	store   $i7, [$i3 + 5]
	store   $i6, [$i3 + 4]
	store   $i5, [$i3 + 3]
.count stack_load
	load    [$sp + 3], $i1
	store   $i1, [$i3 + 2]
	store   $i4, [$i3 + 1]
.count stack_load
	load    [$sp + 1], $i1
	store   $i1, [$i3 + 0]
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 8]
	call    create_pixel.3008
.count stack_load
	load    [$sp + 8], $i9
	store   $i1, [$i9 + 126]
	li      125, $i4
	call    init_line_elements.3010
.count stack_store
	store   $i1, [$sp + 9]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 10]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 10], $i5
	store   $i1, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 11]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 12]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 12], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 13]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 13], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 14]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 15]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 15], $i9
	store   $i1, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i9, [$i3 + 7]
.count stack_load
	load    [$sp + 14], $i1
	store   $i1, [$i3 + 6]
	store   $i8, [$i3 + 5]
	store   $i7, [$i3 + 4]
	store   $i6, [$i3 + 3]
.count stack_load
	load    [$sp + 11], $i1
	store   $i1, [$i3 + 2]
	store   $i5, [$i3 + 1]
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 16]
	call    create_pixel.3008
.count stack_load
	load    [$sp + 16], $i9
	store   $i1, [$i9 + 126]
	li      125, $i4
	call    init_line_elements.3010
.count stack_store
	store   $i1, [$sp + 17]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i4
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 18]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 18], $i5
	store   $i1, [$i5 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i5 + 4]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 19]
	li      5, $i2
	li      0, $i3
	call    ext_create_array_int
	mov     $i1, $i6
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 20]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 20], $i7
	store   $i1, [$i7 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i7 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	li      5, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 21]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 21], $i8
	store   $i1, [$i8 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i8 + 4]
	li      1, $i2
	li      0, $i3
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 22]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	mov     $i1, $i3
	li      5, $i2
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 23]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
.count stack_load
	load    [$sp + 23], $i9
	store   $i1, [$i9 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    ext_create_array_float
	store   $i1, [$i9 + 4]
	li      128, $i2
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i9, [$i3 + 7]
.count stack_load
	load    [$sp + 22], $i1
	store   $i1, [$i3 + 6]
	store   $i8, [$i3 + 5]
	store   $i7, [$i3 + 4]
	store   $i6, [$i3 + 3]
.count stack_load
	load    [$sp + 19], $i1
	store   $i1, [$i3 + 2]
	store   $i5, [$i3 + 1]
	store   $i4, [$i3 + 0]
	call    ext_create_array_int
.count stack_store
	store   $i1, [$sp + 24]
	call    create_pixel.3008
.count stack_load
	load    [$sp + 24], $i9
	store   $i1, [$i9 + 126]
	li      125, $i4
	call    init_line_elements.3010
.count stack_store
	store   $i1, [$sp + 25]
	call    ext_read_float
	store   $f1, [ext_screen + 0]
	call    ext_read_float
	store   $f1, [ext_screen + 1]
	call    ext_read_float
	store   $f1, [ext_screen + 2]
	call    ext_read_float
.count load_float
	load    [f.31927], $f9
	fmul    $f1, $f9, $f10
.count move_args
	mov     $f10, $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 26]
.count move_args
	mov     $f10, $f2
	call    ext_sin
	mov     $f1, $f10
	call    ext_read_float
	fmul    $f1, $f9, $f11
.count move_args
	mov     $f11, $f2
	call    ext_cos
.count stack_store
	store   $f1, [$sp + 27]
.count move_args
	mov     $f11, $f2
	call    ext_sin
.count stack_load
	load    [$sp + 26], $f2
	fmul    $f2, $f1, $f3
.count load_float
	load    [f.32087], $f4
	fmul    $f3, $f4, $fg18
.count load_float
	load    [f.32088], $f3
	fmul    $f10, $f3, $fg19
.count stack_load
	load    [$sp + 27], $f3
	fmul    $f2, $f3, $f5
	fmul    $f5, $f4, $fg20
	store   $f3, [ext_screenx_dir + 0]
	fneg    $f1, $f4
	store   $f4, [ext_screenx_dir + 2]
	fneg    $f10, $f4
	fmul    $f4, $f1, $fg24
	fneg    $f2, $f1
	store   $f1, [ext_screeny_dir + 1]
	fmul    $f4, $f3, $f1
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
	call    ext_read_float
	fmul    $f1, $f9, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
	fneg    $f1, $fg13
	call    ext_read_float
.count stack_store
	store   $f1, [$sp + 28]
.count move_args
	mov     $f8, $f2
	call    ext_cos
	mov     $f1, $f10
.count stack_load
	load    [$sp + 28], $f1
	fmul    $f1, $f9, $f8
.count move_args
	mov     $f8, $f2
	call    ext_sin
	fmul    $f10, $f1, $fg12
.count move_args
	mov     $f8, $f2
	call    ext_cos
	fmul    $f10, $f1, $fg14
	call    ext_read_float
	store   $f1, [ext_beam + 0]
	li      0, $i14
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.33453
be_then.33453:
	mov     $i14, $ig0
.count b_cont
	b       be_cont.33453
be_else.33453:
	li      1, $i14
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.33454
be_then.33454:
	mov     $i14, $ig0
.count b_cont
	b       be_cont.33454
be_else.33454:
	li      2, $i14
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.33455
be_then.33455:
	mov     $i14, $ig0
.count b_cont
	b       be_cont.33455
be_else.33455:
	li      3, $i14
.count move_args
	mov     $i14, $i6
	call    read_nth_object.2719
	bne     $i1, 0, be_else.33456
be_then.33456:
	mov     $i14, $ig0
.count b_cont
	b       be_cont.33456
be_else.33456:
	li      4, $i14
	call    read_object.2721
be_cont.33456:
be_cont.33455:
be_cont.33454:
be_cont.33453:
	call    ext_read_int
	bne     $i1, -1, be_else.33457
be_then.33457:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.33457
be_else.33457:
.count stack_store
	store   $i1, [$sp + 29]
	call    ext_read_int
	mov     $i1, $i6
	bne     $i6, -1, be_else.33458
be_then.33458:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 29], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.33458
be_else.33458:
	li      2, $i50
	call    read_net_item.2725
	store   $i6, [$i1 + 1]
.count stack_load
	load    [$sp + 29], $i2
	store   $i2, [$i1 + 0]
be_cont.33458:
be_cont.33457:
	load    [$i1 + 0], $i2
	be      $i2, -1, bne_cont.33459
bne_then.33459:
	store   $i1, [ext_and_net + 0]
	li      1, $i6
	call    read_and_network.2729
bne_cont.33459:
	call    ext_read_int
	bne     $i1, -1, be_else.33460
be_then.33460:
	li      1, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.33460
be_else.33460:
.count stack_store
	store   $i1, [$sp + 30]
	call    ext_read_int
	mov     $i1, $i6
	bne     $i6, -1, be_else.33461
be_then.33461:
	li      2, $i2
	add     $i0, -1, $i3
	call    ext_create_array_int
.count stack_load
	load    [$sp + 30], $i2
	store   $i2, [$i1 + 0]
.count b_cont
	b       be_cont.33461
be_else.33461:
	li      2, $i50
	call    read_net_item.2725
	store   $i6, [$i1 + 1]
.count stack_load
	load    [$sp + 30], $i2
	store   $i2, [$i1 + 0]
be_cont.33461:
be_cont.33460:
	mov     $i1, $i7
	load    [$i7 + 0], $i1
	bne     $i1, -1, be_else.33462
be_then.33462:
	li      1, $i2
.count move_args
	mov     $i7, $i3
	call    ext_create_array_int
.count b_cont
	b       be_cont.33462
be_else.33462:
	li      1, $i30
	call    read_or_network.2727
	store   $i7, [$i1 + 0]
be_cont.33462:
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
.count stack_store
	store   $i1, [$sp + 31]
.count move_args
	mov     $ig0, $i2
.count move_args
	mov     $i1, $i3
	call    ext_create_array_int
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i1, [$i3 + 1]
.count stack_load
	load    [$sp + 31], $i1
	store   $i1, [$i3 + 0]
	call    ext_create_array_int
	store   $i1, [ext_dirvecs + 4]
	load    [ext_dirvecs + 4], $i4
	li      118, $i5
	call    create_dirvec_elements.3039
	li      3, $i6
	call    create_dirvecs.3042
	li      0, $i6
	li      0, $i7
	li      4, $i5
	li      9, $i2
	call    ext_float_of_int
	fmul    $f1, $fc12, $f1
	fsub    $f1, $fc11, $f13
	call    calc_dirvecs.3028
	li      8, $i9
	li      2, $i10
	li      4, $i11
	call    calc_dirvec_rows.3033
	load    [ext_dirvecs + 4], $i11
	li      119, $i12
	call    init_dirvec_constants.3044
	li      3, $i13
	call    init_vecset_constants.3047
	li      ext_light_dirvec, $i4
	load    [ext_light_dirvec + 0], $i5
	store   $fg12, [$i5 + 0]
	store   $fg13, [$i5 + 1]
	store   $fg14, [$i5 + 2]
	sub     $ig0, 1, $i6
	bl      $i6, 0, bge_cont.33463
bge_then.33463:
	load    [ext_light_dirvec + 1], $i7
	load    [ext_objects + $i6], $i8
	load    [$i8 + 1], $i1
.count move_args
	mov     $f0, $f2
	bne     $i1, 1, be_else.33464
be_then.33464:
	li      6, $i2
	call    ext_create_array_float
	load    [$i5 + 0], $f1
	bne     $f1, $f0, be_else.33465
be_then.33465:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.33465
be_else.33465:
	load    [$i8 + 6], $i2
	bg      $f0, $f1, ble_else.33466
ble_then.33466:
	li      0, $i3
.count b_cont
	b       ble_cont.33466
ble_else.33466:
	li      1, $i3
ble_cont.33466:
	bne     $i2, 0, be_else.33467
be_then.33467:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33467
be_else.33467:
	bne     $i3, 0, be_else.33468
be_then.33468:
	li      1, $i2
.count b_cont
	b       be_cont.33468
be_else.33468:
	li      0, $i2
be_cont.33468:
be_cont.33467:
	load    [$i8 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.33469
be_then.33469:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i5 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.33469
be_else.33469:
	store   $f1, [$i1 + 0]
	load    [$i5 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.33469:
be_cont.33465:
	load    [$i5 + 1], $f1
	bne     $f1, $f0, be_else.33470
be_then.33470:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.33470
be_else.33470:
	load    [$i8 + 6], $i2
	bg      $f0, $f1, ble_else.33471
ble_then.33471:
	li      0, $i3
.count b_cont
	b       ble_cont.33471
ble_else.33471:
	li      1, $i3
ble_cont.33471:
	bne     $i2, 0, be_else.33472
be_then.33472:
	mov     $i3, $i2
.count b_cont
	b       be_cont.33472
be_else.33472:
	bne     $i3, 0, be_else.33473
be_then.33473:
	li      1, $i2
.count b_cont
	b       be_cont.33473
be_else.33473:
	li      0, $i2
be_cont.33473:
be_cont.33472:
	load    [$i8 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.33474
be_then.33474:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i5 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.33474
be_else.33474:
	store   $f1, [$i1 + 2]
	load    [$i5 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.33474:
be_cont.33470:
	load    [$i5 + 2], $f1
	bne     $f1, $f0, be_else.33475
be_then.33475:
	store   $f0, [$i1 + 5]
.count storer
	add     $i7, $i6, $tmp
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33464
be_else.33475:
	load    [$i8 + 6], $i2
	load    [$i8 + 4], $i3
	bg      $f0, $f1, ble_else.33476
ble_then.33476:
	li      0, $i8
.count b_cont
	b       ble_cont.33476
ble_else.33476:
	li      1, $i8
ble_cont.33476:
	bne     $i2, 0, be_else.33477
be_then.33477:
	mov     $i8, $i2
.count b_cont
	b       be_cont.33477
be_else.33477:
	bne     $i8, 0, be_else.33478
be_then.33478:
	li      1, $i2
.count b_cont
	b       be_cont.33478
be_else.33478:
	li      0, $i2
be_cont.33478:
be_cont.33477:
	load    [$i3 + 2], $f1
.count storer
	add     $i7, $i6, $tmp
	bne     $i2, 0, be_else.33479
be_then.33479:
	fneg    $f1, $f1
	store   $f1, [$i1 + 4]
	load    [$i5 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33464
be_else.33479:
	store   $f1, [$i1 + 4]
	load    [$i5 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
	store   $i1, [$tmp + 0]
	sub     $i6, 1, $i5
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33464
be_else.33464:
	bne     $i1, 2, be_else.33480
be_then.33480:
	li      4, $i2
	call    ext_create_array_float
	load    [$i8 + 4], $i2
	load    [$i8 + 4], $i3
	load    [$i8 + 4], $i9
	load    [$i5 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i5 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i5 + 2], $f2
	load    [$i9 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	sub     $i6, 1, $i5
.count storer
	add     $i7, $i6, $tmp
	bg      $f1, $f0, ble_else.33481
ble_then.33481:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33480
ble_else.33481:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i8 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i8 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i8 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33480
be_else.33480:
	li      5, $i2
	call    ext_create_array_float
	load    [$i8 + 3], $i2
	load    [$i8 + 4], $i3
	load    [$i8 + 4], $i9
	load    [$i8 + 4], $i10
	load    [$i5 + 0], $f1
	load    [$i5 + 1], $f2
	load    [$i5 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i9 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.33482
be_then.33482:
	mov     $f4, $f1
.count b_cont
	b       be_cont.33482
be_else.33482:
	fmul    $f2, $f3, $f5
	load    [$i8 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i8 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i8 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.33482:
	store   $f1, [$i1 + 0]
	load    [$i8 + 4], $i3
	load    [$i8 + 4], $i9
	load    [$i8 + 4], $i10
	load    [$i5 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i5 + 1], $f3
	load    [$i9 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i5 + 2], $f5
	load    [$i10 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i7, $i6, $tmp
	bne     $i2, 0, be_else.33483
be_then.33483:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	sub     $i6, 1, $i5
	bne     $f1, $f0, be_else.33484
be_then.33484:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33483
be_else.33484:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33483
be_else.33483:
	load    [$i8 + 9], $i2
	load    [$i8 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i8 + 9], $i2
	load    [$i5 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i5 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i5 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i5 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	sub     $i6, 1, $i5
	bne     $f1, $f0, be_else.33485
be_then.33485:
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.33485
be_else.33485:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.33485:
be_cont.33483:
be_cont.33480:
be_cont.33464:
bge_cont.33463:
	sub     $ig0, 1, $i11
	call    setup_reflections.3064
	li      0, $i34
	li      127, $i33
	add     $i0, -64, $i2
	call    ext_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f18
	load    [ext_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg19, $f15
	load    [ext_screeny_dir + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg20, $f17
.count stack_load
	load    [$sp + 17], $i39
.count move_args
	mov     $i39, $i32
	call    pretrace_pixels.2983
	li      0, $i37
	li      2, $i41
.count stack_load
	load    [$sp + 9], $i38
.count stack_load
	load    [$sp + 25], $i40
	call    scan_line.3000
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 32, $sp
	li      0, $tmp
	ret
.end main
