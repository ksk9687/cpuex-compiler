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
	call    min_caml_main
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
# * floor
# それ以下の最大の数
# $f1 = floor($f2)
# [$f1, $f2, $f3]
######################################################################
.begin floor
min_caml_floor:
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
# * float_of_int
# 最も近いfloat
# $f1 = float_of_int($i2)
# [$i2, $i3, $i4, $f1, $f2, $f3]
######################################################################
.begin float_of_int
min_caml_float_of_int:
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
# * int_of_float
# 最も近いint
# $i1 = int_of_float($f2)
# [$i1, $i2, $i3, $f2, $f3]
######################################################################
.begin int_of_float
min_caml_int_of_float:
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
# * read
# 1byte同期読み込み
# $i1 = read()
# [$i1, $i2]
######################################################################
.begin read
min_caml_read:
	li 255, $i2
read_loop:
	read $i1
	bg $i1, $i2, min_caml_read
	ret

######################################################################
# * read_int
# 4byte同期読み込み
# $i1 = read_int()
# [$i1, $i2, $i3, $i4, $i5]
######################################################################
min_caml_read_int:
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
# * read_float
# 4byte同期読み込み
# $f1 = read_float()
# [$i1, $i2, $i3, $i4, $i5, $f1]
######################################################################
min_caml_read_float:
	mov $ra, $tmp
	call min_caml_read_int
	mov $i1, $f1
	jr $tmp
.end read

######################################################################
# * write
# 1byte同期出力
# write($i2)
# [$i2]
######################################################################
.begin write
min_caml_write:
	write $i2, $tmp
	bg $tmp, 0, min_caml_write
	ret
.end write

######################################################################
# * create_array_int
# create_array_int(length, init)で長さlength、初期値initの配列を作成
# $i1 = create_array_int($i2, $i3)
# [$i1, $i2, $i3]
######################################################################
.begin create_array
min_caml_create_array_int:
	mov $i2, $i1
	add $i2, $hp, $i2
	mov $hp, $i1
create_array_loop:
	store $i3, [$hp]
	add $hp, 1, $hp
	bl $hp, $i2, create_array_loop
	ret

######################################################################
# * create_array_float
# create_array_float(length, init)で長さlength、初期値initの配列を作成
# $i1 = create_array_float($i2, $f2)
# [$i1, $i2, $i3, $f2]
######################################################################
min_caml_create_array_float:
	mov $f2, $i3
	jal min_caml_create_array_int $tmp
.end create_array

######################################################################
# * 算術関数(atan, sin, cos)
######################################################################
min_caml_atan_table:
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
# [$i2, $f1, $f2, $f3, $f4, $f5]
######################################################################
.begin atan
min_caml_atan:
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
	load    [min_caml_atan_table + $i2], $f2
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
	load    [min_caml_atan_table + $i2], $f2
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
# [$i2, $f1, $f2, $f3, $f4, $f5, $f6, $f7]
######################################################################
.begin sin
min_caml_sin:
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
	b       min_caml_sin
ble_else._195:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f1, $f2, $f2
	call    min_caml_sin
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
	call    min_caml_sin
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
	load    [min_caml_atan_table + $i2], $f3
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
	load    [min_caml_atan_table + $i2], $f3
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
# [$i2, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $f8]
######################################################################
.begin cos
min_caml_cos:
.count load_float
	load    [f._184], $f8
	fsub    $f8, $f2, $f2
	b       min_caml_sin
.end cos

######################################################################
#
# 		↑　ここまで lib_asm.s
#
######################################################################
min_caml_n_objects:
	.skip	1
min_caml_objects:
	.skip	60
min_caml_screen:
	.skip	3
min_caml_viewpoint:
	.skip	3
min_caml_light:
	.skip	3
min_caml_beam:
	.skip	1
min_caml_and_net:
	.skip	50
min_caml_or_net:
	.skip	1
min_caml_solver_dist:
	.skip	1
min_caml_intsec_rectside:
	.skip	1
min_caml_tmin:
	.skip	1
min_caml_intersection_point:
	.skip	3
min_caml_intersected_object_id:
	.skip	1
min_caml_nvector:
	.skip	3
min_caml_texture_color:
	.skip	3
min_caml_diffuse_ray:
	.skip	3
min_caml_rgb:
	.skip	3
min_caml_image_size:
	.skip	2
min_caml_image_center:
	.skip	2
min_caml_scan_pitch:
	.skip	1
min_caml_startp:
	.skip	3
min_caml_startp_fast:
	.skip	3
min_caml_screenx_dir:
	.skip	3
min_caml_screeny_dir:
	.skip	3
min_caml_screenz_dir:
	.skip	3
min_caml_ptrace_dirvec:
	.skip	3
min_caml_dirvecs:
	.skip	5
min_caml_light_dirvec:
	.int	light_dirvec_v3
	.int	light_dirvec_consts
light_dirvec_v3:
	.skip	3
light_dirvec_consts:
	.skip	60
min_caml_reflections:
	.skip	180
min_caml_n_reflections:
	.skip	1
.define $ig0 $i51
.define $i51 orz
.define $ig1 $i52
.define $i52 orz
.define $ig2 $i53
.define $i53 orz
.define $ig3 $i54
.define $i54 orz
.define $ig4 $i55
.define $i55 orz
.define $ig5 $i56
.define $i56 orz
.define $ig6 $i57
.define $i57 orz
.define $ig7 $i58
.define $i58 orz
.define $ig8 $i59
.define $i59 orz
.define $fc0 $f19
.define $f19 orz
.define $fc1 $f20
.define $f20 orz
.define $fc2 $f21
.define $f21 orz
.define $fc3 $f22
.define $f22 orz
.define $fc4 $f23
.define $f23 orz
.define $fc5 $f24
.define $f24 orz
.define $fc6 $f25
.define $f25 orz
.define $fc7 $f26
.define $f26 orz
.define $fc8 $f27
.define $f27 orz
.define $fc9 $f28
.define $f28 orz
.define $fc10 $f29
.define $f29 orz
.define $fc11 $f30
.define $f30 orz
.define $fc12 $f31
.define $f31 orz
.define $fc13 $f32
.define $f32 orz
.define $fc14 $f33
.define $f33 orz
.define $fc15 $f34
.define $f34 orz
.define $fc16 $f35
.define $f35 orz
.define $fc17 $f36
.define $f36 orz
.define $fc18 $f37
.define $f37 orz
.define $fc19 $f38
.define $f38 orz
.define $fg0 $f39
.define $f39 orz
.define $fg1 $f40
.define $f40 orz
.define $fg2 $f41
.define $f41 orz
.define $fg3 $f42
.define $f42 orz
.define $fg4 $f43
.define $f43 orz
.define $fg5 $f44
.define $f44 orz
.define $fg6 $f45
.define $f45 orz
.define $fg7 $f46
.define $f46 orz
.define $fg8 $f47
.define $f47 orz
.define $fg9 $f48
.define $f48 orz
.define $fg10 $f49
.define $f49 orz
.define $fg11 $f50
.define $f50 orz
.define $fg12 $f51
.define $f51 orz
.define $fg13 $f52
.define $f52 orz
.define $fg14 $f53
.define $f53 orz
.define $fg15 $f54
.define $f54 orz
.define $fg16 $f55
.define $f55 orz
.define $fg17 $f56
.define $f56 orz
.define $fg18 $f57
.define $f57 orz
.define $fg19 $f58
.define $f58 orz
.define $fg20 $f59
.define $f59 orz
.define $fg21 $f60
.define $f60 orz
.define $fg22 $f61
.define $f61 orz
.define $fg23 $f62
.define $f62 orz
.define $fg24 $f63
.define $f63 orz
f.32245:	.float  -2.0000000000E+02
f.32244:	.float  2.0000000000E+02
f.32216:	.float  1.2800000000E+02
f.32154:	.float  2.0000000000E-01
f.32153:	.float  9.0000000000E-01
f.32125:	.float  1.5000000000E+02
f.32124:	.float  -1.5000000000E+02
f.32123:	.float  6.6666666667E-03
f.32122:	.float  -6.6666666667E-03
f.32121:	.float  -2.0000000000E+00
f.32120:	.float  3.9062500000E-03
f.32119:	.float  2.5600000000E+02
f.32118:	.float  1.0000000000E+08
f.32117:	.float  1.0000000000E+09
f.32116:	.float  1.0000000000E+01
f.32115:	.float  5.0000000000E-02
f.32114:	.float  2.0000000000E+01
f.32113:	.float  2.5000000000E-01
f.32112:	.float  1.0000000000E-01
f.32111:	.float  2.5500000000E+02
f.32110:	.float  3.3333333333E+00
f.32109:	.float  1.5000000000E-01
f.32108:	.float  3.1830988148E-01
f.32107:	.float  3.1415927000E+00
f.32106:	.float  3.0000000000E+01
f.32105:	.float  1.5000000000E+01
f.32104:	.float  1.0000000000E-04
f.32103:	.float  -1.0000000000E-01
f.32102:	.float  1.0000000000E-02
f.32101:	.float  -2.0000000000E-01
f.32100:	.float  5.0000000000E-01
f.32099:	.float  1.0000000000E+00
f.32098:	.float  -1.0000000000E+00
f.32097:	.float  2.0000000000E+00
f.32084:	.float  1.7453293000E-02

######################################################################
# read_nth_object
######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35661
be_then.35661:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35661:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i14
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i14 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i14 + 1]
	call    min_caml_read_float
	store   $f1, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i15 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i15 + 1]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i15 + 2]
	call    min_caml_read_float
.count stack_store
	store   $f1, [$sp + 2]
	li      2, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i16 + 0]
	call    min_caml_read_float
	store   $f1, [$i16 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i17 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [$i17 + 1]
	call    min_caml_read_float
	store   $f1, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	be      $i13, 0, bne_cont.35662
bne_then.35662:
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
.count load_float
	load    [f.32084], $f11
	fmul    $f10, $f11, $f10
	store   $f10, [$i18 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $f11, $f10
	store   $f10, [$i18 + 1]
	call    min_caml_read_float
	fmul    $f1, $f11, $f1
	store   $f1, [$i18 + 2]
bne_cont.35662:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 2], $f10
	bg      $f0, $f10, ble_else.35663
ble_then.35663:
	li      0, $i19
.count b_cont
	b       ble_cont.35663
ble_else.35663:
	li      1, $i19
ble_cont.35663:
	bne     $i11, 2, be_else.35664
be_then.35664:
	li      1, $i20
.count b_cont
	b       be_cont.35664
be_else.35664:
	mov     $i19, $i20
be_cont.35664:
	mov     $hp, $i21
	add     $hp, 11, $hp
	store   $i1, [$i21 + 10]
	store   $i18, [$i21 + 9]
	store   $i17, [$i21 + 8]
	store   $i16, [$i21 + 7]
	store   $i20, [$i21 + 6]
	store   $i15, [$i21 + 5]
	store   $i14, [$i21 + 4]
	store   $i13, [$i21 + 3]
	store   $i12, [$i21 + 2]
	store   $i11, [$i21 + 1]
	store   $i10, [$i21 + 0]
.count stack_load
	load    [$sp + 1], $i1
	store   $i21, [min_caml_objects + $i1]
	bne     $i11, 3, be_else.35665
be_then.35665:
	load    [$i14 + 0], $f10
	bne     $f10, $f0, be_else.35666
be_then.35666:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35666
be_else.35666:
	bne     $f10, $f0, be_else.35667
be_then.35667:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
	mov     $f0, $f10
.count b_cont
	b       be_cont.35667
be_else.35667:
	bg      $f10, $f0, ble_else.35668
ble_then.35668:
	fmul    $f10, $f10, $f10
	finv_n  $f10, $f10
.count b_cont
	b       ble_cont.35668
ble_else.35668:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
ble_cont.35668:
be_cont.35667:
be_cont.35666:
	store   $f10, [$i14 + 0]
	load    [$i14 + 1], $f10
	bne     $f10, $f0, be_else.35669
be_then.35669:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35669
be_else.35669:
	bne     $f10, $f0, be_else.35670
be_then.35670:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
	mov     $f0, $f10
.count b_cont
	b       be_cont.35670
be_else.35670:
	bg      $f10, $f0, ble_else.35671
ble_then.35671:
	fmul    $f10, $f10, $f10
	finv_n  $f10, $f10
.count b_cont
	b       ble_cont.35671
ble_else.35671:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
ble_cont.35671:
be_cont.35670:
be_cont.35669:
	store   $f10, [$i14 + 1]
	load    [$i14 + 2], $f10
	bne     $f10, $f0, be_else.35672
be_then.35672:
	store   $f0, [$i14 + 2]
	bne     $i13, 0, be_else.35673
be_then.35673:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35673:
	load    [$i18 + 0], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
	load    [$i18 + 0], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f11
	load    [$i18 + 1], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f12
	load    [$i18 + 1], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f13
	load    [$i18 + 2], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f14
	load    [$i18 + 2], $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i14 + 2], $f2
	fneg    $f13, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i14 + 1], $f5
	fmul    $f12, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i14 + 0], $f8
	fmul    $f12, $f14, $f9
	fmul    $f9, $f9, $f15
	fmul    $f8, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i14 + 0]
	fmul    $f11, $f12, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f10, $f14, $f15
	fmul    $f11, $f13, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f18
	fmul    $f16, $f14, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f8, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i14 + 1]
	fmul    $f10, $f12, $f7
	fmul    $f7, $f7, $f12
	fmul    $f2, $f12, $f12
	fmul    $f11, $f14, $f17
	fmul    $f10, $f13, $f10
	fmul    $f10, $f1, $f13
	fsub    $f13, $f17, $f13
	fmul    $f13, $f13, $f17
	fmul    $f5, $f17, $f17
	fmul    $f11, $f1, $f1
	fmul    $f10, $f14, $f10
	fadd    $f10, $f1, $f1
	fmul    $f1, $f1, $f10
	fmul    $f8, $f10, $f10
	fadd    $f10, $f17, $f10
	fadd    $f10, $f12, $f10
	store   $f10, [$i14 + 2]
	fmul    $f2, $f4, $f10
	fmul    $f10, $f7, $f10
	fmul    $f5, $f15, $f11
	fmul    $f11, $f13, $f11
	fmul    $f8, $f16, $f12
	fmul    $f12, $f1, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fmul    $fc10, $f10, $f10
	store   $f10, [$i18 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f13, $f6
	fmul    $f8, $f9, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
be_else.35672:
	fmul    $f10, $f10, $f11
	finv    $f11, $f11
	bne     $f10, $f0, be_else.35674
be_then.35674:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35674
be_else.35674:
	bg      $f10, $f0, ble_else.35675
ble_then.35675:
	mov     $fc4, $f10
.count b_cont
	b       ble_cont.35675
ble_else.35675:
	mov     $fc0, $f10
ble_cont.35675:
be_cont.35674:
	fmul    $f10, $f11, $f10
	store   $f10, [$i14 + 2]
	bne     $i13, 0, be_else.35676
be_then.35676:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35676:
	load    [$i18 + 0], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
	load    [$i18 + 0], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f11
	load    [$i18 + 1], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f12
	load    [$i18 + 1], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f13
	load    [$i18 + 2], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f14
	load    [$i18 + 2], $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i14 + 2], $f2
	fneg    $f13, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i14 + 1], $f5
	fmul    $f12, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i14 + 0], $f8
	fmul    $f12, $f14, $f9
	fmul    $f9, $f9, $f15
	fmul    $f8, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i14 + 0]
	fmul    $f11, $f12, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f10, $f14, $f15
	fmul    $f11, $f13, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f18
	fmul    $f16, $f14, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f8, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i14 + 1]
	fmul    $f10, $f12, $f7
	fmul    $f7, $f7, $f12
	fmul    $f2, $f12, $f12
	fmul    $f11, $f14, $f17
	fmul    $f10, $f13, $f10
	fmul    $f10, $f1, $f13
	fsub    $f13, $f17, $f13
	fmul    $f13, $f13, $f17
	fmul    $f5, $f17, $f17
	fmul    $f11, $f1, $f1
	fmul    $f10, $f14, $f10
	fadd    $f10, $f1, $f1
	fmul    $f1, $f1, $f10
	fmul    $f8, $f10, $f10
	fadd    $f10, $f17, $f10
	fadd    $f10, $f12, $f10
	store   $f10, [$i14 + 2]
	fmul    $f2, $f4, $f10
	fmul    $f10, $f7, $f10
	fmul    $f5, $f15, $f11
	fmul    $f11, $f13, $f11
	fmul    $f8, $f16, $f12
	fmul    $f12, $f1, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fmul    $fc10, $f10, $f10
	store   $f10, [$i18 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f13, $f6
	fmul    $f8, $f9, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
be_else.35665:
	bne     $i11, 2, be_else.35677
be_then.35677:
	load    [$i14 + 2], $f10
	fmul    $f10, $f10, $f10
	load    [$i14 + 1], $f11
	fmul    $f11, $f11, $f11
	load    [$i14 + 0], $f12
	fmul    $f12, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fsqrt   $f10, $f10
	bne     $i19, 0, be_else.35678
be_then.35678:
	li      1, $i1
.count b_cont
	b       be_cont.35678
be_else.35678:
	li      0, $i1
be_cont.35678:
	bne     $f10, $f0, be_else.35679
be_then.35679:
	mov     $fc0, $f10
.count b_cont
	b       be_cont.35679
be_else.35679:
	bne     $i1, 0, be_else.35680
be_then.35680:
	finv    $f10, $f10
.count b_cont
	b       be_cont.35680
be_else.35680:
	finv_n  $f10, $f10
be_cont.35680:
be_cont.35679:
	load    [$i14 + 0], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i14 + 0]
	load    [$i14 + 1], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i14 + 1]
	load    [$i14 + 2], $f11
	fmul    $f11, $f10, $f10
	store   $f10, [$i14 + 2]
	bne     $i13, 0, be_else.35681
be_then.35681:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35681:
	load    [$i18 + 0], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
	load    [$i18 + 0], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f11
	load    [$i18 + 1], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f12
	load    [$i18 + 1], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f13
	load    [$i18 + 2], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f14
	load    [$i18 + 2], $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i14 + 2], $f2
	fneg    $f13, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i14 + 1], $f5
	fmul    $f12, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i14 + 0], $f8
	fmul    $f12, $f14, $f9
	fmul    $f9, $f9, $f15
	fmul    $f8, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i14 + 0]
	fmul    $f11, $f12, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f10, $f14, $f15
	fmul    $f11, $f13, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f18
	fmul    $f16, $f14, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f8, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i14 + 1]
	fmul    $f10, $f12, $f7
	fmul    $f7, $f7, $f12
	fmul    $f2, $f12, $f12
	fmul    $f11, $f14, $f17
	fmul    $f10, $f13, $f10
	fmul    $f10, $f1, $f13
	fsub    $f13, $f17, $f13
	fmul    $f13, $f13, $f17
	fmul    $f5, $f17, $f17
	fmul    $f11, $f1, $f1
	fmul    $f10, $f14, $f10
	fadd    $f10, $f1, $f1
	fmul    $f1, $f1, $f10
	fmul    $f8, $f10, $f10
	fadd    $f10, $f17, $f10
	fadd    $f10, $f12, $f10
	store   $f10, [$i14 + 2]
	fmul    $f2, $f4, $f10
	fmul    $f10, $f7, $f10
	fmul    $f5, $f15, $f11
	fmul    $f11, $f13, $f11
	fmul    $f8, $f16, $f12
	fmul    $f12, $f1, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fmul    $fc10, $f10, $f10
	store   $f10, [$i18 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f13, $f6
	fmul    $f8, $f9, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
be_else.35677:
	bne     $i13, 0, be_else.35682
be_then.35682:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35682:
	load    [$i18 + 0], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
	load    [$i18 + 0], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f11
	load    [$i18 + 1], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f12
	load    [$i18 + 1], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f13
	load    [$i18 + 2], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f14
	load    [$i18 + 2], $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i14 + 2], $f2
	fneg    $f13, $f3
	fmul    $f3, $f3, $f4
	fmul    $f2, $f4, $f4
	load    [$i14 + 1], $f5
	fmul    $f12, $f1, $f6
	fmul    $f6, $f6, $f7
	fmul    $f5, $f7, $f7
	load    [$i14 + 0], $f8
	fmul    $f12, $f14, $f9
	fmul    $f9, $f9, $f15
	fmul    $f8, $f15, $f15
	fadd    $f15, $f7, $f7
	fadd    $f7, $f4, $f4
	store   $f4, [$i14 + 0]
	fmul    $f11, $f12, $f4
	fmul    $f4, $f4, $f7
	fmul    $f2, $f7, $f7
	fmul    $f10, $f14, $f15
	fmul    $f11, $f13, $f16
	fmul    $f16, $f1, $f17
	fadd    $f17, $f15, $f15
	fmul    $f15, $f15, $f17
	fmul    $f5, $f17, $f17
	fmul    $f10, $f1, $f18
	fmul    $f16, $f14, $f16
	fsub    $f16, $f18, $f16
	fmul    $f16, $f16, $f18
	fmul    $f8, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f7, $f7
	store   $f7, [$i14 + 1]
	fmul    $f10, $f12, $f7
	fmul    $f7, $f7, $f12
	fmul    $f2, $f12, $f12
	fmul    $f11, $f14, $f17
	fmul    $f10, $f13, $f10
	fmul    $f10, $f1, $f13
	fsub    $f13, $f17, $f13
	fmul    $f13, $f13, $f17
	fmul    $f5, $f17, $f17
	fmul    $f11, $f1, $f1
	fmul    $f10, $f14, $f10
	fadd    $f10, $f1, $f1
	fmul    $f1, $f1, $f10
	fmul    $f8, $f10, $f10
	fadd    $f10, $f17, $f10
	fadd    $f10, $f12, $f10
	store   $f10, [$i14 + 2]
	fmul    $f2, $f4, $f10
	fmul    $f10, $f7, $f10
	fmul    $f5, $f15, $f11
	fmul    $f11, $f13, $f11
	fmul    $f8, $f16, $f12
	fmul    $f12, $f1, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fmul    $fc10, $f10, $f10
	store   $f10, [$i18 + 0]
	fmul    $f2, $f3, $f2
	fmul    $f2, $f7, $f3
	fmul    $f5, $f6, $f5
	fmul    $f5, $f13, $f6
	fmul    $f8, $f9, $f7
	fmul    $f7, $f1, $f1
	fadd    $f1, $f6, $f1
	fadd    $f1, $f3, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f4, $f1
	fmul    $f5, $f15, $f2
	fmul    $f7, $f16, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
.end read_nth_object

######################################################################
# read_object
######################################################################
.begin read_object
read_object.2721:
	bl      $i2, 60, bge_else.35683
bge_then.35683:
	ret
bge_else.35683:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35684
be_then.35684:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	mov     $i1, $ig0
	ret
be_else.35684:
.count stack_load
	load    [$sp + 1], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35685
bge_then.35685:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35685:
.count stack_store
	store   $i2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35686
be_then.35686:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i1
	mov     $i1, $ig0
	ret
be_else.35686:
.count stack_load
	load    [$sp + 2], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35687
bge_then.35687:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35687:
.count stack_store
	store   $i2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35688
be_then.35688:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 6], $i1
	mov     $i1, $ig0
	ret
be_else.35688:
.count stack_load
	load    [$sp + 3], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35689
bge_then.35689:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35689:
.count stack_store
	store   $i2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35690
be_then.35690:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i1
	mov     $i1, $ig0
	ret
be_else.35690:
.count stack_load
	load    [$sp + 4], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35691
bge_then.35691:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35691:
.count stack_store
	store   $i2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35692
be_then.35692:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $i1
	mov     $i1, $ig0
	ret
be_else.35692:
.count stack_load
	load    [$sp + 5], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35693
bge_then.35693:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35693:
.count stack_store
	store   $i2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35694
be_then.35694:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
	mov     $i1, $ig0
	ret
be_else.35694:
.count stack_load
	load    [$sp + 6], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35695
bge_then.35695:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35695:
.count stack_store
	store   $i2, [$sp + 7]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35696
be_then.35696:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i1
	mov     $i1, $ig0
	ret
be_else.35696:
.count stack_load
	load    [$sp + 7], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35697
bge_then.35697:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35697:
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2719
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	bne     $i1, 0, be_else.35698
be_then.35698:
.count stack_load
	load    [$sp - 1], $i1
	mov     $i1, $ig0
	ret
be_else.35698:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
	b       read_object.2721
.end read_object

######################################################################
# read_net_item
######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35699
be_then.35699:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	add     $i0, -1, $i3
.count stack_load
	load    [$sp - 8], $i10
	add     $i10, 1, $i2
	b       min_caml_create_array_int
be_else.35699:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
.count stack_load
	load    [$sp + 1], $i12
	add     $i12, 1, $i13
	bne     $i11, -1, be_else.35700
be_then.35700:
	add     $i0, -1, $i3
	add     $i13, 1, $i2
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $i1, $i12, $tmp
	store   $i10, [$tmp + 0]
	ret
be_else.35700:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i14
	add     $i13, 1, $i15
	bne     $i14, -1, be_else.35701
be_then.35701:
	add     $i0, -1, $i3
	add     $i15, 1, $i2
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $i1, $i13, $tmp
	store   $i11, [$tmp + 0]
.count storer
	add     $i1, $i12, $tmp
	store   $i10, [$tmp + 0]
	ret
be_else.35701:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i16
	add     $i15, 1, $i17
	add     $i17, 1, $i2
	bne     $i16, -1, be_else.35702
be_then.35702:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $i1, $i15, $tmp
	store   $i14, [$tmp + 0]
.count storer
	add     $i1, $i13, $tmp
	store   $i11, [$tmp + 0]
.count storer
	add     $i1, $i12, $tmp
	store   $i10, [$tmp + 0]
	ret
be_else.35702:
.count stack_store
	store   $i10, [$sp + 2]
.count stack_store
	store   $i13, [$sp + 3]
.count stack_store
	store   $i11, [$sp + 4]
.count stack_store
	store   $i15, [$sp + 5]
.count stack_store
	store   $i14, [$sp + 6]
.count stack_store
	store   $i17, [$sp + 7]
.count stack_store
	store   $i16, [$sp + 8]
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
	load    [$sp - 4], $i2
.count stack_load
	load    [$sp - 3], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 6], $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $i2
.count stack_load
	load    [$sp - 7], $i3
.count storer
	add     $i1, $i2, $tmp
	store   $i3, [$tmp + 0]
	ret
.end read_net_item

######################################################################
# read_or_network
######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35703
be_then.35703:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35703
be_else.35703:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35704
be_then.35704:
	add     $i0, -1, $i3
	li      2, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35704
be_else.35704:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35705
be_then.35705:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35705
be_else.35705:
.count stack_store
	store   $i10, [$sp + 2]
.count stack_store
	store   $i11, [$sp + 3]
.count stack_store
	store   $i12, [$sp + 4]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 4], $i11
	store   $i11, [$i10 + 2]
.count stack_load
	load    [$sp + 3], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 2], $i11
	store   $i11, [$i10 + 0]
be_cont.35705:
be_cont.35704:
be_cont.35703:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.35706
be_then.35706:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $i10
	add     $i10, 1, $i2
	b       min_caml_create_array_int
be_else.35706:
.count stack_store
	store   $i3, [$sp + 5]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35707
be_then.35707:
	add     $i0, -1, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35707
be_else.35707:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35708
be_then.35708:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35708
be_else.35708:
.count stack_store
	store   $i10, [$sp + 6]
.count stack_store
	store   $i11, [$sp + 7]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 7], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 6], $i11
	store   $i11, [$i10 + 0]
be_cont.35708:
be_cont.35707:
	mov     $i10, $i3
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, 1, $i11
	load    [$i3 + 0], $i12
	add     $i11, 1, $i2
	bne     $i12, -1, be_else.35709
be_then.35709:
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 5], $i2
.count storer
	add     $i1, $i10, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.35709:
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i3, [$sp + 9]
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
# read_and_network
######################################################################
.begin read_and_network
read_and_network.2729:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35710
be_then.35710:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35710
be_else.35710:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35711
be_then.35711:
	add     $i0, -1, $i3
	li      2, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35711
be_else.35711:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35712
be_then.35712:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35712
be_else.35712:
.count stack_store
	store   $i10, [$sp + 2]
.count stack_store
	store   $i11, [$sp + 3]
.count stack_store
	store   $i12, [$sp + 4]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 4], $i11
	store   $i11, [$i10 + 2]
.count stack_load
	load    [$sp + 3], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 2], $i11
	store   $i11, [$i10 + 0]
be_cont.35712:
be_cont.35711:
be_cont.35710:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35713
be_then.35713:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35713:
.count stack_load
	load    [$sp + 1], $i11
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35714
be_then.35714:
	add     $i0, -1, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35714
be_else.35714:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35715
be_then.35715:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35715
be_else.35715:
.count stack_store
	store   $i10, [$sp + 5]
.count stack_store
	store   $i11, [$sp + 6]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 6], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 5], $i11
	store   $i11, [$i10 + 0]
be_cont.35715:
be_cont.35714:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35716
be_then.35716:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35716:
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 7]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35717
be_then.35717:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35717
be_else.35717:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35718
be_then.35718:
	add     $i0, -1, $i3
	li      2, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35718
be_else.35718:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35719
be_then.35719:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35719
be_else.35719:
.count stack_store
	store   $i10, [$sp + 8]
.count stack_store
	store   $i11, [$sp + 9]
.count stack_store
	store   $i12, [$sp + 10]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 10], $i11
	store   $i11, [$i10 + 2]
.count stack_load
	load    [$sp + 9], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 8], $i11
	store   $i11, [$i10 + 0]
be_cont.35719:
be_cont.35718:
be_cont.35717:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35720
be_then.35720:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35720:
.count stack_load
	load    [$sp + 7], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 11]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35721
be_then.35721:
	add     $i0, -1, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.35721
be_else.35721:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35722
be_then.35722:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
	store   $i10, [$i1 + 0]
.count b_cont
	b       be_cont.35722
be_else.35722:
.count stack_store
	store   $i10, [$sp + 12]
.count stack_store
	store   $i11, [$sp + 13]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 13], $i2
	store   $i2, [$i1 + 1]
.count stack_load
	load    [$sp + 12], $i2
	store   $i2, [$i1 + 0]
be_cont.35722:
be_cont.35721:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.35723
be_then.35723:
	ret
be_else.35723:
.count stack_load
	load    [$sp - 3], $i2
	add     $i2, 1, $i2
	store   $i1, [min_caml_and_net + $i2]
	add     $i2, 1, $i2
	b       read_and_network.2729
.end read_and_network

######################################################################
# solver
######################################################################
.begin solver
solver.2773:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 1], $i2
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 5], $i6
	load    [$i4 + 2], $f1
	fsub    $fg19, $f1, $f1
	load    [$i5 + 1], $f2
	fsub    $fg18, $f2, $f2
	load    [$i6 + 0], $f3
	fsub    $fg17, $f3, $f3
	bne     $i2, 1, be_else.35724
be_then.35724:
	load    [$i3 + 0], $f4
	bne     $f4, $f0, be_else.35725
be_then.35725:
	li      0, $i2
.count b_cont
	b       be_cont.35725
be_else.35725:
	finv    $f4, $f5
	load    [$i1 + 4], $i2
	load    [$i2 + 0], $f6
	bg      $f0, $f4, ble_else.35726
ble_then.35726:
	li      0, $i4
.count b_cont
	b       ble_cont.35726
ble_else.35726:
	li      1, $i4
ble_cont.35726:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.35727
bne_then.35727:
	bne     $i4, 0, be_else.35728
be_then.35728:
	li      1, $i4
.count b_cont
	b       be_cont.35728
be_else.35728:
	li      0, $i4
be_cont.35728:
bne_cont.35727:
	bne     $i4, 0, be_else.35729
be_then.35729:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.35729
be_else.35729:
	mov     $f6, $f4
be_cont.35729:
	fsub    $f4, $f3, $f4
	fmul    $f4, $f5, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i2 + 1], $f6
	bg      $f6, $f5, ble_else.35730
ble_then.35730:
	li      0, $i2
.count b_cont
	b       ble_cont.35730
ble_else.35730:
	load    [$i3 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i2 + 2], $f6
	bg      $f6, $f5, ble_else.35731
ble_then.35731:
	li      0, $i2
.count b_cont
	b       ble_cont.35731
ble_else.35731:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.35731:
ble_cont.35730:
be_cont.35725:
	bne     $i2, 0, be_else.35732
be_then.35732:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.35733
be_then.35733:
	li      0, $i2
.count b_cont
	b       be_cont.35733
be_else.35733:
	finv    $f4, $f5
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f6
	bg      $f0, $f4, ble_else.35734
ble_then.35734:
	li      0, $i4
.count b_cont
	b       ble_cont.35734
ble_else.35734:
	li      1, $i4
ble_cont.35734:
	load    [$i1 + 6], $i5
	be      $i5, 0, bne_cont.35735
bne_then.35735:
	bne     $i4, 0, be_else.35736
be_then.35736:
	li      1, $i4
.count b_cont
	b       be_cont.35736
be_else.35736:
	li      0, $i4
be_cont.35736:
bne_cont.35735:
	bne     $i4, 0, be_else.35737
be_then.35737:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.35737
be_else.35737:
	mov     $f6, $f4
be_cont.35737:
	fsub    $f4, $f2, $f4
	fmul    $f4, $f5, $f4
	load    [$i3 + 2], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f1, $f5
	load    [$i2 + 2], $f6
	bg      $f6, $f5, ble_else.35738
ble_then.35738:
	li      0, $i2
.count b_cont
	b       ble_cont.35738
ble_else.35738:
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i2 + 0], $f6
	bg      $f6, $f5, ble_else.35739
ble_then.35739:
	li      0, $i2
.count b_cont
	b       ble_cont.35739
ble_else.35739:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.35739:
ble_cont.35738:
be_cont.35733:
	bne     $i2, 0, be_else.35740
be_then.35740:
	load    [$i3 + 2], $f4
	bne     $f4, $f0, be_else.35741
be_then.35741:
	li      0, $i1
	ret
be_else.35741:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i1
	finv    $f4, $f5
	load    [$i2 + 2], $f6
	bg      $f0, $f4, ble_else.35742
ble_then.35742:
	li      0, $i4
.count b_cont
	b       ble_cont.35742
ble_else.35742:
	li      1, $i4
ble_cont.35742:
	bne     $i1, 0, be_else.35743
be_then.35743:
	mov     $i4, $i1
.count b_cont
	b       be_cont.35743
be_else.35743:
	bne     $i4, 0, be_else.35744
be_then.35744:
	li      1, $i1
.count b_cont
	b       be_cont.35744
be_else.35744:
	li      0, $i1
be_cont.35744:
be_cont.35743:
	bne     $i1, 0, be_else.35745
be_then.35745:
	fneg    $f6, $f4
.count b_cont
	b       be_cont.35745
be_else.35745:
	mov     $f6, $f4
be_cont.35745:
	fsub    $f4, $f1, $f1
	fmul    $f1, $f5, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	load    [$i2 + 0], $f4
	bg      $f4, $f3, ble_else.35746
ble_then.35746:
	li      0, $i1
	ret
ble_else.35746:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	load    [$i2 + 1], $f3
	bg      $f3, $f2, ble_else.35747
ble_then.35747:
	li      0, $i1
	ret
ble_else.35747:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.35740:
	li      2, $i1
	ret
be_else.35732:
	li      1, $i1
	ret
be_else.35724:
	load    [$i3 + 2], $f5
	bne     $i2, 2, be_else.35748
be_then.35748:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f4
	fmul    $f5, $f4, $f5
	load    [$i1 + 1], $f6
	load    [$i3 + 1], $f7
	fmul    $f7, $f6, $f7
	load    [$i1 + 0], $f8
	load    [$i3 + 0], $f9
	fmul    $f9, $f8, $f9
	fadd    $f9, $f7, $f7
	fadd    $f7, $f5, $f5
	bg      $f5, $f0, ble_else.35749
ble_then.35749:
	li      0, $i1
	ret
ble_else.35749:
	finv    $f5, $f5
	fmul    $f4, $f1, $f1
	fmul    $f6, $f2, $f2
	fmul    $f8, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	fmul    $f1, $f5, $fg0
	li      1, $i1
	ret
be_else.35748:
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 4], $i6
	load    [$i1 + 3], $i7
	load    [$i4 + 2], $f4
	fmul    $f5, $f5, $f6
	fmul    $f6, $f4, $f6
	load    [$i5 + 1], $f7
	load    [$i3 + 1], $f8
	fmul    $f8, $f8, $f9
	fmul    $f9, $f7, $f9
	load    [$i6 + 0], $f10
	load    [$i3 + 0], $f11
	fmul    $f11, $f11, $f12
	fmul    $f12, $f10, $f12
	fadd    $f12, $f9, $f9
	fadd    $f9, $f6, $f6
	be      $i7, 0, bne_cont.35750
bne_then.35750:
	load    [$i1 + 9], $i3
	load    [$i3 + 2], $f9
	fmul    $f11, $f8, $f12
	fmul    $f12, $f9, $f9
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f12
	fmul    $f5, $f11, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f13
	fmul    $f8, $f5, $f14
	fmul    $f14, $f13, $f13
	fadd    $f6, $f13, $f6
	fadd    $f6, $f12, $f6
	fadd    $f6, $f9, $f6
bne_cont.35750:
	bne     $f6, $f0, be_else.35751
be_then.35751:
	li      0, $i1
	ret
be_else.35751:
	load    [$i1 + 3], $i3
	load    [$i1 + 3], $i4
	fmul    $f1, $f1, $f9
	fmul    $f9, $f4, $f9
	fmul    $f2, $f2, $f12
	fmul    $f12, $f7, $f12
	fmul    $f3, $f3, $f13
	fmul    $f13, $f10, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f9, $f9
	be      $i3, 0, bne_cont.35752
bne_then.35752:
	load    [$i1 + 9], $i3
	load    [$i3 + 2], $f12
	fmul    $f3, $f2, $f13
	fmul    $f13, $f12, $f12
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f13
	fmul    $f1, $f3, $f14
	fmul    $f14, $f13, $f13
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f14
	fmul    $f2, $f1, $f15
	fmul    $f15, $f14, $f14
	fadd    $f9, $f14, $f9
	fadd    $f9, $f13, $f9
	fadd    $f9, $f12, $f9
bne_cont.35752:
	bne     $i2, 3, be_cont.35753
be_then.35753:
	fsub    $f9, $fc0, $f9
be_cont.35753:
	fmul    $f6, $f9, $f9
	fmul    $f5, $f1, $f12
	fmul    $f12, $f4, $f4
	fmul    $f8, $f2, $f12
	fmul    $f12, $f7, $f7
	fmul    $f11, $f3, $f12
	fmul    $f12, $f10, $f10
	fadd    $f10, $f7, $f7
	fadd    $f7, $f4, $f4
	bne     $i4, 0, be_else.35754
be_then.35754:
	mov     $f4, $f1
.count b_cont
	b       be_cont.35754
be_else.35754:
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
	fmul    $f1, $fc3, $f1
	fadd    $f4, $f1, $f1
be_cont.35754:
	fmul    $f1, $f1, $f2
	fsub    $f2, $f9, $f2
	bg      $f2, $f0, ble_else.35755
ble_then.35755:
	li      0, $i1
	ret
ble_else.35755:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	finv    $f6, $f3
	bne     $i1, 0, be_else.35756
be_then.35756:
	fneg    $f2, $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
be_else.35756:
	fsub    $f2, $f1, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
.end solver

######################################################################
# solver_fast
######################################################################
.begin solver_fast
solver_fast.2796:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 1], $i3
	load    [min_caml_light_dirvec + 1], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 5], $i6
	load    [$i1 + 5], $i7
	load    [$i4 + $i2], $i2
	load    [$i5 + 2], $f1
	load    [min_caml_intersection_point + 2], $f2
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f2
	load    [min_caml_intersection_point + 1], $f3
	fsub    $f3, $f2, $f2
	load    [$i7 + 0], $f3
	load    [min_caml_intersection_point + 0], $f4
	fsub    $f4, $f3, $f3
	bne     $i3, 1, be_else.35757
be_then.35757:
	load    [min_caml_light_dirvec + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i2 + 1], $f4
	load    [$i2 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.35758
ble_then.35758:
	li      0, $i4
.count b_cont
	b       ble_cont.35758
ble_else.35758:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.35759
ble_then.35759:
	li      0, $i4
.count b_cont
	b       ble_cont.35759
ble_else.35759:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.35760
be_then.35760:
	li      0, $i4
.count b_cont
	b       be_cont.35760
be_else.35760:
	li      1, $i4
be_cont.35760:
ble_cont.35759:
ble_cont.35758:
	bne     $i4, 0, be_else.35761
be_then.35761:
	load    [$i1 + 4], $i4
	load    [$i2 + 3], $f4
	load    [$i2 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i4 + 0], $f7
	bg      $f7, $f5, ble_else.35762
ble_then.35762:
	li      0, $i1
.count b_cont
	b       ble_cont.35762
ble_else.35762:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f5
	load    [$i3 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.35763
ble_then.35763:
	li      0, $i1
.count b_cont
	b       ble_cont.35763
ble_else.35763:
	load    [$i2 + 3], $f5
	bne     $f5, $f0, be_else.35764
be_then.35764:
	li      0, $i1
.count b_cont
	b       be_cont.35764
be_else.35764:
	li      1, $i1
be_cont.35764:
ble_cont.35763:
ble_cont.35762:
	bne     $i1, 0, be_else.35765
be_then.35765:
	load    [$i2 + 5], $f4
	load    [$i2 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.35766
ble_then.35766:
	li      0, $i1
	ret
ble_else.35766:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.35767
ble_then.35767:
	li      0, $i1
	ret
ble_else.35767:
	load    [$i2 + 5], $f2
	bne     $f2, $f0, be_else.35768
be_then.35768:
	li      0, $i1
	ret
be_else.35768:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.35765:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.35761:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.35757:
	load    [$i2 + 0], $f4
	bne     $i3, 2, be_else.35769
be_then.35769:
	bg      $f0, $f4, ble_else.35770
ble_then.35770:
	li      0, $i1
	ret
ble_else.35770:
	load    [$i2 + 3], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 2], $f4
	fmul    $f4, $f2, $f2
	load    [$i2 + 1], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $fg0
	li      1, $i1
	ret
be_else.35769:
	bne     $f4, $f0, be_else.35771
be_then.35771:
	li      0, $i1
	ret
be_else.35771:
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 4], $i6
	load    [$i1 + 3], $i7
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
	be      $i7, 0, bne_cont.35772
bne_then.35772:
	load    [$i1 + 9], $i4
	load    [$i4 + 2], $f6
	fmul    $f3, $f2, $f7
	fmul    $f7, $f6, $f6
	load    [$i1 + 9], $i4
	load    [$i4 + 1], $f7
	fmul    $f1, $f3, $f8
	fmul    $f8, $f7, $f7
	load    [$i1 + 9], $i4
	load    [$i4 + 0], $f8
	fmul    $f2, $f1, $f9
	fmul    $f9, $f8, $f8
	fadd    $f5, $f8, $f5
	fadd    $f5, $f7, $f5
	fadd    $f5, $f6, $f5
bne_cont.35772:
	bne     $i3, 3, be_cont.35773
be_then.35773:
	fsub    $f5, $fc0, $f5
be_cont.35773:
	fmul    $f4, $f5, $f4
	load    [$i2 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i2 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.35774
ble_then.35774:
	li      0, $i1
	ret
ble_else.35774:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	load    [$i2 + 4], $f3
	bne     $i1, 0, be_else.35775
be_then.35775:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
be_else.35775:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
.end solver_fast

######################################################################
# solver_fast2
######################################################################
.begin solver_fast2
solver_fast2.2814:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 10], $i4
	load    [$i1 + 1], $i5
	load    [$i3 + 1], $i6
	load    [$i6 + $i2], $i2
	load    [$i4 + 2], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 0], $f3
	bne     $i5, 1, be_else.35776
be_then.35776:
	load    [$i3 + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i2 + 1], $f4
	load    [$i2 + 0], $f5
	fsub    $f5, $f3, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 1], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f2, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.35777
ble_then.35777:
	li      0, $i4
.count b_cont
	b       ble_cont.35777
ble_else.35777:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f4, $f7, $f7
	fadd_a  $f7, $f1, $f7
	bg      $f5, $f7, ble_else.35778
ble_then.35778:
	li      0, $i4
.count b_cont
	b       ble_cont.35778
ble_else.35778:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.35779
be_then.35779:
	li      0, $i4
.count b_cont
	b       be_cont.35779
be_else.35779:
	li      1, $i4
be_cont.35779:
ble_cont.35778:
ble_cont.35777:
	bne     $i4, 0, be_else.35780
be_then.35780:
	load    [$i1 + 4], $i4
	load    [$i2 + 3], $f4
	load    [$i2 + 2], $f5
	fsub    $f5, $f2, $f5
	fmul    $f5, $f4, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f5
	fadd_a  $f5, $f3, $f5
	load    [$i4 + 0], $f7
	bg      $f7, $f5, ble_else.35781
ble_then.35781:
	li      0, $i1
.count b_cont
	b       ble_cont.35781
ble_else.35781:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f5
	load    [$i3 + 2], $f8
	fmul    $f4, $f8, $f8
	fadd_a  $f8, $f1, $f8
	bg      $f5, $f8, ble_else.35782
ble_then.35782:
	li      0, $i1
.count b_cont
	b       ble_cont.35782
ble_else.35782:
	load    [$i2 + 3], $f5
	bne     $f5, $f0, be_else.35783
be_then.35783:
	li      0, $i1
.count b_cont
	b       be_cont.35783
be_else.35783:
	li      1, $i1
be_cont.35783:
ble_cont.35782:
ble_cont.35781:
	bne     $i1, 0, be_else.35784
be_then.35784:
	load    [$i2 + 5], $f4
	load    [$i2 + 4], $f5
	fsub    $f5, $f1, $f1
	fmul    $f1, $f4, $f1
	load    [$i3 + 0], $f4
	fmul    $f1, $f4, $f4
	fadd_a  $f4, $f3, $f3
	bg      $f7, $f3, ble_else.35785
ble_then.35785:
	li      0, $i1
	ret
ble_else.35785:
	load    [$i3 + 1], $f3
	fmul    $f1, $f3, $f3
	fadd_a  $f3, $f2, $f2
	bg      $f6, $f2, ble_else.35786
ble_then.35786:
	li      0, $i1
	ret
ble_else.35786:
	load    [$i2 + 5], $f2
	bne     $f2, $f0, be_else.35787
be_then.35787:
	li      0, $i1
	ret
be_else.35787:
	mov     $f1, $fg0
	li      3, $i1
	ret
be_else.35784:
	mov     $f4, $fg0
	li      2, $i1
	ret
be_else.35780:
	mov     $f4, $fg0
	li      1, $i1
	ret
be_else.35776:
	bne     $i5, 2, be_else.35788
be_then.35788:
	load    [$i2 + 0], $f1
	bg      $f0, $f1, ble_else.35789
ble_then.35789:
	li      0, $i1
	ret
ble_else.35789:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35788:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.35790
be_then.35790:
	li      0, $i1
	ret
be_else.35790:
	load    [$i4 + 3], $f5
	fmul    $f4, $f5, $f4
	load    [$i2 + 3], $f5
	fmul    $f5, $f1, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f2, $f2
	load    [$i2 + 1], $f5
	fmul    $f5, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	fmul    $f1, $f1, $f2
	fsub    $f2, $f4, $f2
	bg      $f2, $f0, ble_else.35791
ble_then.35791:
	li      0, $i1
	ret
ble_else.35791:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	load    [$i2 + 4], $f3
	bne     $i1, 0, be_else.35792
be_then.35792:
	fsub    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
be_else.35792:
	fadd    $f1, $f2, $f1
	fmul    $f1, $f3, $fg0
	li      1, $i1
	ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i3, 0, bge_else.35793
bge_then.35793:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 0], $i10
	load    [min_caml_objects + $i3], $i11
	load    [$i11 + 1], $i12
	load    [$i2 + 1], $i13
.count move_args
	mov     $f0, $f2
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	bne     $i12, 1, be_else.35794
be_then.35794:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i10 + 0], $f1
	bne     $f1, $f0, be_else.35795
be_then.35795:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35795
be_else.35795:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.35796
ble_then.35796:
	li      0, $i15
.count b_cont
	b       ble_cont.35796
ble_else.35796:
	li      1, $i15
ble_cont.35796:
	bne     $i14, 0, be_else.35797
be_then.35797:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35797
be_else.35797:
	bne     $i15, 0, be_else.35798
be_then.35798:
	li      1, $i14
.count b_cont
	b       be_cont.35798
be_else.35798:
	li      0, $i14
be_cont.35798:
be_cont.35797:
	load    [$i11 + 4], $i15
	load    [$i15 + 0], $f1
	bne     $i14, 0, be_else.35799
be_then.35799:
	fneg    $f1, $f1
	store   $f1, [$i12 + 0]
	load    [$i10 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
.count b_cont
	b       be_cont.35799
be_else.35799:
	store   $f1, [$i12 + 0]
	load    [$i10 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
be_cont.35799:
be_cont.35795:
	load    [$i10 + 1], $f1
	bne     $f1, $f0, be_else.35800
be_then.35800:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35800
be_else.35800:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.35801
ble_then.35801:
	li      0, $i15
.count b_cont
	b       ble_cont.35801
ble_else.35801:
	li      1, $i15
ble_cont.35801:
	bne     $i14, 0, be_else.35802
be_then.35802:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35802
be_else.35802:
	bne     $i15, 0, be_else.35803
be_then.35803:
	li      1, $i14
.count b_cont
	b       be_cont.35803
be_else.35803:
	li      0, $i14
be_cont.35803:
be_cont.35802:
	load    [$i11 + 4], $i15
	load    [$i15 + 1], $f1
	bne     $i14, 0, be_else.35804
be_then.35804:
	fneg    $f1, $f1
	store   $f1, [$i12 + 2]
	load    [$i10 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
.count b_cont
	b       be_cont.35804
be_else.35804:
	store   $f1, [$i12 + 2]
	load    [$i10 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
be_cont.35804:
be_cont.35800:
	load    [$i10 + 2], $f1
	bne     $f1, $f0, be_else.35805
be_then.35805:
	store   $f0, [$i12 + 5]
	mov     $i12, $i11
.count b_cont
	b       be_cont.35805
be_else.35805:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f10
	bg      $f0, $f1, ble_else.35806
ble_then.35806:
	li      0, $i14
.count b_cont
	b       ble_cont.35806
ble_else.35806:
	li      1, $i14
ble_cont.35806:
	load    [$i11 + 6], $i11
	bne     $i11, 0, be_else.35807
be_then.35807:
	mov     $i12, $i11
	bne     $i14, 0, be_else.35808
be_then.35808:
	fneg    $f10, $f1
	store   $f1, [$i12 + 4]
	load    [$i10 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.35807
be_else.35808:
	store   $f10, [$i12 + 4]
	load    [$i10 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.35807
be_else.35807:
	mov     $i12, $i11
	bne     $i14, 0, be_else.35809
be_then.35809:
	store   $f10, [$i12 + 4]
	load    [$i10 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.35809
be_else.35809:
	fneg    $f10, $f1
	store   $f1, [$i12 + 4]
	load    [$i10 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
be_cont.35809:
be_cont.35807:
be_cont.35805:
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i13, $i12, $tmp
	store   $i11, [$tmp + 0]
	sub     $i12, 1, $i11
	bl      $i11, 0, bge_else.35810
bge_then.35810:
	load    [min_caml_objects + $i11], $i12
	load    [$i12 + 1], $i14
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.35811
be_then.35811:
	li      6, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i10 + 0], $f1
	bne     $f1, $f0, be_else.35812
be_then.35812:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.35812
be_else.35812:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.35813
ble_then.35813:
	li      0, $i3
.count b_cont
	b       ble_cont.35813
ble_else.35813:
	li      1, $i3
ble_cont.35813:
	bne     $i2, 0, be_else.35814
be_then.35814:
	mov     $i3, $i2
.count b_cont
	b       be_cont.35814
be_else.35814:
	bne     $i3, 0, be_else.35815
be_then.35815:
	li      1, $i2
.count b_cont
	b       be_cont.35815
be_else.35815:
	li      0, $i2
be_cont.35815:
be_cont.35814:
	load    [$i12 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.35816
be_then.35816:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i10 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.35816
be_else.35816:
	store   $f1, [$i1 + 0]
	load    [$i10 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.35816:
be_cont.35812:
	load    [$i10 + 1], $f1
	bne     $f1, $f0, be_else.35817
be_then.35817:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.35817
be_else.35817:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.35818
ble_then.35818:
	li      0, $i3
.count b_cont
	b       ble_cont.35818
ble_else.35818:
	li      1, $i3
ble_cont.35818:
	bne     $i2, 0, be_else.35819
be_then.35819:
	mov     $i3, $i2
.count b_cont
	b       be_cont.35819
be_else.35819:
	bne     $i3, 0, be_else.35820
be_then.35820:
	li      1, $i2
.count b_cont
	b       be_cont.35820
be_else.35820:
	li      0, $i2
be_cont.35820:
be_cont.35819:
	load    [$i12 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.35821
be_then.35821:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i10 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.35821
be_else.35821:
	store   $f1, [$i1 + 2]
	load    [$i10 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.35821:
be_cont.35817:
	load    [$i10 + 2], $f1
	bne     $f1, $f0, be_else.35822
be_then.35822:
	store   $f0, [$i1 + 5]
.count storer
	add     $i13, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35822:
	load    [$i12 + 4], $i2
	load    [$i12 + 6], $i3
	load    [$i2 + 2], $f2
	bg      $f0, $f1, ble_else.35823
ble_then.35823:
	li      0, $i2
.count b_cont
	b       ble_cont.35823
ble_else.35823:
	li      1, $i2
ble_cont.35823:
	be      $i3, 0, bne_cont.35824
bne_then.35824:
	bne     $i2, 0, be_else.35825
be_then.35825:
	li      1, $i2
.count b_cont
	b       be_cont.35825
be_else.35825:
	li      0, $i2
be_cont.35825:
bne_cont.35824:
	bne     $i2, 0, be_else.35826
be_then.35826:
	fneg    $f2, $f1
.count b_cont
	b       be_cont.35826
be_else.35826:
	mov     $f2, $f1
be_cont.35826:
	store   $f1, [$i1 + 4]
	load    [$i10 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count storer
	add     $i13, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35811:
	bne     $i14, 2, be_else.35827
be_then.35827:
	li      4, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i12 + 4], $i2
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i2 + 2], $f1
	load    [$i10 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i3 + 1], $f2
	load    [$i10 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i4 + 0], $f3
	load    [$i10 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	sub     $i11, 1, $i3
.count storer
	add     $i13, $i11, $tmp
	bg      $f1, $f0, ble_else.35828
ble_then.35828:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
ble_else.35828:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i12 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i12 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i12 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35827:
	li      5, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i12 + 4], $i2
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i12 + 3], $i5
	load    [$i2 + 2], $f1
	load    [$i10 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i3 + 1], $f3
	load    [$i10 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i4 + 0], $f5
	load    [$i10 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i5, 0, bne_cont.35829
bne_then.35829:
	fmul    $f4, $f2, $f3
	load    [$i12 + 9], $i2
	load    [$i2 + 0], $f5
	fmul    $f3, $f5, $f3
	fadd    $f1, $f3, $f1
	fmul    $f2, $f6, $f2
	load    [$i12 + 9], $i2
	load    [$i2 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f6, $f4, $f2
	load    [$i12 + 9], $i2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
bne_cont.35829:
	store   $f1, [$i1 + 0]
	load    [$i12 + 4], $i2
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i2 + 2], $f2
	load    [$i10 + 2], $f3
	fmul_n  $f3, $f2, $f2
	load    [$i3 + 1], $f4
	load    [$i10 + 1], $f5
	fmul_n  $f5, $f4, $f4
	load    [$i4 + 0], $f6
	load    [$i10 + 0], $f7
	fmul_n  $f7, $f6, $f6
.count storer
	add     $i13, $i11, $tmp
	bne     $i5, 0, be_else.35830
be_then.35830:
	store   $f6, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f2, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.35831
be_then.35831:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35831:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35830:
	load    [$i12 + 9], $i2
	load    [$i12 + 9], $i3
	load    [$i2 + 2], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f3, $f5, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f6, $f3, $f3
	store   $f3, [$i1 + 1]
	load    [$i12 + 9], $i2
	load    [$i10 + 0], $f3
	fmul    $f3, $f7, $f3
	load    [$i2 + 0], $f5
	load    [$i10 + 2], $f6
	fmul    $f6, $f5, $f6
	fadd    $f6, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f4, $f3, $f3
	store   $f3, [$i1 + 2]
	load    [$i10 + 0], $f3
	fmul    $f3, $f8, $f3
	load    [$i10 + 1], $f4
	fmul    $f4, $f5, $f4
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.35832
be_then.35832:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35832:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
bge_else.35810:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.35794:
	bne     $i12, 2, be_else.35833
be_then.35833:
	li      4, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i11 + 4], $i2
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i2 + 2], $f1
	load    [$i10 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i3 + 1], $f2
	load    [$i10 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i4 + 0], $f3
	load    [$i10 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f1, $f0, ble_else.35834
ble_then.35834:
	store   $f0, [$i1 + 0]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
ble_else.35834:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i11 + 4], $i2
	load    [$i2 + 0], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 1]
	load    [$i11 + 4], $i2
	load    [$i2 + 1], $f2
	fmul_n  $f2, $f1, $f2
	store   $f2, [$i1 + 2]
	load    [$i11 + 4], $i2
	load    [$i2 + 2], $f2
	fmul_n  $f2, $f1, $f1
	store   $f1, [$i1 + 3]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35833:
	li      5, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i11 + 4], $i2
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i11 + 3], $i5
	load    [$i2 + 2], $f1
	load    [$i10 + 2], $f2
	fmul    $f2, $f2, $f3
	fmul    $f3, $f1, $f1
	load    [$i3 + 1], $f3
	load    [$i10 + 1], $f4
	fmul    $f4, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i4 + 0], $f5
	load    [$i10 + 0], $f6
	fmul    $f6, $f6, $f7
	fmul    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
	fadd    $f3, $f1, $f1
	be      $i5, 0, bne_cont.35835
bne_then.35835:
	fmul    $f4, $f2, $f3
	load    [$i11 + 9], $i2
	load    [$i2 + 0], $f5
	fmul    $f3, $f5, $f3
	fadd    $f1, $f3, $f1
	fmul    $f2, $f6, $f2
	load    [$i11 + 9], $i2
	load    [$i2 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f6, $f4, $f2
	load    [$i11 + 9], $i2
	load    [$i2 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
bne_cont.35835:
	store   $f1, [$i1 + 0]
	load    [$i11 + 4], $i2
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i2 + 2], $f2
	load    [$i10 + 2], $f3
	fmul_n  $f3, $f2, $f2
	load    [$i3 + 1], $f4
	load    [$i10 + 1], $f5
	fmul_n  $f5, $f4, $f4
	load    [$i4 + 0], $f6
	load    [$i10 + 0], $f7
	fmul_n  $f7, $f6, $f6
	bne     $i5, 0, be_else.35836
be_then.35836:
	store   $f6, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.35837
be_then.35837:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35837:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35836:
	load    [$i11 + 9], $i2
	load    [$i11 + 9], $i3
	load    [$i2 + 2], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f3, $f5, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f6, $f3, $f3
	store   $f3, [$i1 + 1]
	load    [$i11 + 9], $i2
	load    [$i10 + 0], $f3
	fmul    $f3, $f7, $f3
	load    [$i2 + 0], $f5
	load    [$i10 + 2], $f6
	fmul    $f6, $f5, $f6
	fadd    $f6, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f4, $f3, $f3
	store   $f3, [$i1 + 2]
	load    [$i10 + 0], $f3
	fmul    $f3, $f8, $f3
	load    [$i10 + 1], $f4
	fmul    $f4, $f5, $f4
	fadd    $f4, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.35838
be_then.35838:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35838:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i13, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
bge_else.35793:
	ret
.end iter_setup_dirvec_constants

######################################################################
# setup_startp_constants
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i3, 0, bge_else.35839
bge_then.35839:
	load    [min_caml_objects + $i3], $i1
	load    [$i1 + 10], $i4
	load    [$i1 + 5], $i5
	load    [$i5 + 0], $f1
	load    [$i2 + 0], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 0]
	load    [$i1 + 5], $i5
	load    [$i5 + 1], $f1
	load    [$i2 + 1], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 1]
	load    [$i1 + 5], $i5
	load    [$i5 + 2], $f1
	load    [$i2 + 2], $f2
	fsub    $f2, $f1, $f1
	store   $f1, [$i4 + 2]
	load    [$i1 + 1], $i5
	bne     $i5, 2, be_else.35840
be_then.35840:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f1
	load    [$i4 + 2], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [$i4 + 1], $f3
	fmul    $f2, $f3, $f2
	load    [$i1 + 0], $f3
	load    [$i4 + 0], $f4
	fmul    $f3, $f4, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	store   $f1, [$i4 + 3]
	sub     $i3, 1, $i3
	b       setup_startp_constants.2831
be_else.35840:
	bg      $i5, 2, ble_else.35841
ble_then.35841:
	sub     $i3, 1, $i3
	b       setup_startp_constants.2831
ble_else.35841:
	load    [$i1 + 4], $i6
	load    [$i1 + 4], $i7
	load    [$i1 + 4], $i8
	load    [$i1 + 3], $i9
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
	be      $i9, 0, bne_cont.35842
bne_then.35842:
	load    [$i1 + 9], $i6
	load    [$i1 + 9], $i7
	load    [$i1 + 9], $i1
	load    [$i6 + 2], $f3
	fmul    $f6, $f4, $f5
	fmul    $f5, $f3, $f3
	load    [$i7 + 1], $f5
	fmul    $f2, $f6, $f6
	fmul    $f6, $f5, $f5
	load    [$i1 + 0], $f6
	fmul    $f4, $f2, $f2
	fmul    $f2, $f6, $f2
	fadd    $f1, $f2, $f1
	fadd    $f1, $f5, $f1
	fadd    $f1, $f3, $f1
bne_cont.35842:
	sub     $i3, 1, $i3
	bne     $i5, 3, be_else.35843
be_then.35843:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
be_else.35843:
	store   $f1, [$i4 + 3]
	b       setup_startp_constants.2831
bge_else.35839:
	ret
.end setup_startp_constants

######################################################################
# check_all_inside
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i2], $i1
	bne     $i1, -1, be_else.35844
be_then.35844:
	li      1, $i1
	ret
be_else.35844:
	load    [min_caml_objects + $i1], $i1
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 5], $i6
	load    [$i1 + 1], $i7
	load    [$i4 + 2], $f1
	fsub    $f4, $f1, $f1
	load    [$i5 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i6 + 0], $f6
	fsub    $f2, $f6, $f6
	load    [$i1 + 4], $i4
	bne     $i7, 1, be_else.35845
be_then.35845:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.35846
ble_then.35846:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35847
be_then.35847:
	li      1, $i1
.count b_cont
	b       be_cont.35845
be_else.35847:
	li      0, $i1
.count b_cont
	b       be_cont.35845
ble_else.35846:
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.35848
ble_then.35848:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35849
be_then.35849:
	li      1, $i1
.count b_cont
	b       be_cont.35845
be_else.35849:
	li      0, $i1
.count b_cont
	b       be_cont.35845
ble_else.35848:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i1 + 6], $i1
	bg      $f5, $f1, be_cont.35845
ble_then.35850:
	bne     $i1, 0, be_else.35851
be_then.35851:
	li      1, $i1
.count b_cont
	b       be_cont.35845
be_else.35851:
	li      0, $i1
.count b_cont
	b       be_cont.35845
be_else.35845:
	bne     $i7, 2, be_else.35852
be_then.35852:
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f6, $f5, $f5
	load    [$i4 + 2], $f6
	fmul    $f6, $f1, $f1
	fadd    $f5, $f1, $f1
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.35853
ble_then.35853:
	bne     $i1, 0, be_else.35854
be_then.35854:
	li      1, $i1
.count b_cont
	b       be_cont.35852
be_else.35854:
	li      0, $i1
.count b_cont
	b       be_cont.35852
ble_else.35853:
	bne     $i1, 0, be_else.35855
be_then.35855:
	li      0, $i1
.count b_cont
	b       be_cont.35852
be_else.35855:
	li      1, $i1
.count b_cont
	b       be_cont.35852
be_else.35852:
	fmul    $f6, $f6, $f7
	load    [$i4 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f1, $f8
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i1 + 3], $i4
	bne     $i4, 0, be_else.35856
be_then.35856:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35856
be_else.35856:
	fmul    $f5, $f1, $f8
	load    [$i1 + 9], $i4
	load    [$i4 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f6, $f1
	load    [$i1 + 9], $i4
	load    [$i4 + 1], $f8
	fmul    $f1, $f8, $f1
	fadd    $f7, $f1, $f1
	fmul    $f6, $f5, $f5
	load    [$i1 + 9], $i4
	load    [$i4 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
be_cont.35856:
	bne     $i7, 3, be_cont.35857
be_then.35857:
	fsub    $f1, $fc0, $f1
be_cont.35857:
	load    [$i1 + 6], $i1
	bg      $f0, $f1, ble_else.35858
ble_then.35858:
	bne     $i1, 0, be_else.35859
be_then.35859:
	li      1, $i1
.count b_cont
	b       ble_cont.35858
be_else.35859:
	li      0, $i1
.count b_cont
	b       ble_cont.35858
ble_else.35858:
	bne     $i1, 0, be_else.35860
be_then.35860:
	li      0, $i1
.count b_cont
	b       be_cont.35860
be_else.35860:
	li      1, $i1
be_cont.35860:
ble_cont.35858:
be_cont.35852:
be_cont.35845:
	bne     $i1, 0, be_else.35861
be_then.35861:
	add     $i2, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35862
be_then.35862:
	li      1, $i1
	ret
be_else.35862:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i7, 1, be_else.35863
be_then.35863:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.35864
ble_then.35864:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35865
be_then.35865:
	li      1, $i2
.count b_cont
	b       be_cont.35863
be_else.35865:
	li      0, $i2
.count b_cont
	b       be_cont.35863
ble_else.35864:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.35866
ble_then.35866:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35867
be_then.35867:
	li      1, $i2
.count b_cont
	b       be_cont.35863
be_else.35867:
	li      0, $i2
.count b_cont
	b       be_cont.35863
ble_else.35866:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f5, $f1, be_cont.35863
ble_then.35868:
	bne     $i2, 0, be_else.35869
be_then.35869:
	li      1, $i2
.count b_cont
	b       be_cont.35863
be_else.35869:
	li      0, $i2
.count b_cont
	b       be_cont.35863
be_else.35863:
	load    [$i4 + 2], $f7
	bne     $i7, 2, be_else.35870
be_then.35870:
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.35871
ble_then.35871:
	bne     $i2, 0, be_else.35872
be_then.35872:
	li      1, $i2
.count b_cont
	b       be_cont.35870
be_else.35872:
	li      0, $i2
.count b_cont
	b       be_cont.35870
ble_else.35871:
	bne     $i2, 0, be_else.35873
be_then.35873:
	li      0, $i2
.count b_cont
	b       be_cont.35870
be_else.35873:
	li      1, $i2
.count b_cont
	b       be_cont.35870
be_else.35870:
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
	bne     $i7, 0, be_else.35874
be_then.35874:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35874
be_else.35874:
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
be_cont.35874:
	load    [$i2 + 1], $i4
	bne     $i4, 3, be_cont.35875
be_then.35875:
	fsub    $f1, $fc0, $f1
be_cont.35875:
	load    [$i2 + 6], $i2
	bg      $f0, $f1, ble_else.35876
ble_then.35876:
	bne     $i2, 0, be_else.35877
be_then.35877:
	li      1, $i2
.count b_cont
	b       ble_cont.35876
be_else.35877:
	li      0, $i2
.count b_cont
	b       ble_cont.35876
ble_else.35876:
	bne     $i2, 0, be_else.35878
be_then.35878:
	li      0, $i2
.count b_cont
	b       be_cont.35878
be_else.35878:
	li      1, $i2
be_cont.35878:
ble_cont.35876:
be_cont.35870:
be_cont.35863:
	bne     $i2, 0, be_else.35879
be_then.35879:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35880
be_then.35880:
	li      1, $i1
	ret
be_else.35880:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i7, 1, be_else.35881
be_then.35881:
	load    [$i2 + 4], $i4
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.35882
ble_then.35882:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35883
be_then.35883:
	li      1, $i2
.count b_cont
	b       be_cont.35881
be_else.35883:
	li      0, $i2
.count b_cont
	b       be_cont.35881
ble_else.35882:
	load    [$i2 + 4], $i4
	fabs    $f5, $f5
	load    [$i4 + 1], $f6
	bg      $f6, $f5, ble_else.35884
ble_then.35884:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35885
be_then.35885:
	li      1, $i2
.count b_cont
	b       be_cont.35881
be_else.35885:
	li      0, $i2
.count b_cont
	b       be_cont.35881
ble_else.35884:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	load    [$i2 + 6], $i2
	bg      $f5, $f1, be_cont.35881
ble_then.35886:
	bne     $i2, 0, be_else.35887
be_then.35887:
	li      1, $i2
.count b_cont
	b       be_cont.35881
be_else.35887:
	li      0, $i2
.count b_cont
	b       be_cont.35881
be_else.35881:
	bne     $i7, 2, be_else.35888
be_then.35888:
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
	bg      $f0, $f1, ble_else.35889
ble_then.35889:
	bne     $i2, 0, be_else.35890
be_then.35890:
	li      1, $i2
.count b_cont
	b       be_cont.35888
be_else.35890:
	li      0, $i2
.count b_cont
	b       be_cont.35888
ble_else.35889:
	bne     $i2, 0, be_else.35891
be_then.35891:
	li      0, $i2
.count b_cont
	b       be_cont.35888
be_else.35891:
	li      1, $i2
.count b_cont
	b       be_cont.35888
be_else.35888:
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
	bne     $i6, 0, be_else.35892
be_then.35892:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35892
be_else.35892:
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
be_cont.35892:
	bne     $i4, 3, be_cont.35893
be_then.35893:
	fsub    $f1, $fc0, $f1
be_cont.35893:
	bg      $f0, $f1, ble_else.35894
ble_then.35894:
	bne     $i5, 0, be_else.35895
be_then.35895:
	li      1, $i2
.count b_cont
	b       ble_cont.35894
be_else.35895:
	li      0, $i2
.count b_cont
	b       ble_cont.35894
ble_else.35894:
	bne     $i5, 0, be_else.35896
be_then.35896:
	li      0, $i2
.count b_cont
	b       be_cont.35896
be_else.35896:
	li      1, $i2
be_cont.35896:
ble_cont.35894:
be_cont.35888:
be_cont.35881:
	bne     $i2, 0, be_else.35897
be_then.35897:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35898
be_then.35898:
	li      1, $i1
	ret
be_else.35898:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i7, 1, be_else.35899
be_then.35899:
	fabs    $f6, $f6
	load    [$i4 + 0], $f7
	bg      $f7, $f6, ble_else.35900
ble_then.35900:
	li      0, $i4
.count b_cont
	b       ble_cont.35900
ble_else.35900:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f6
	fabs    $f5, $f5
	bg      $f6, $f5, ble_else.35901
ble_then.35901:
	li      0, $i4
.count b_cont
	b       ble_cont.35901
ble_else.35901:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f5
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.35902
ble_then.35902:
	li      0, $i4
.count b_cont
	b       ble_cont.35902
ble_else.35902:
	li      1, $i4
ble_cont.35902:
ble_cont.35901:
ble_cont.35900:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.35903
be_then.35903:
	bne     $i2, 0, be_else.35904
be_then.35904:
	li      0, $i1
	ret
be_else.35904:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35903:
	bne     $i2, 0, be_else.35905
be_then.35905:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35905:
	li      0, $i1
	ret
be_else.35899:
	load    [$i4 + 2], $f7
	bne     $i7, 2, be_else.35906
be_then.35906:
	load    [$i2 + 6], $i2
	fmul    $f7, $f1, $f1
	load    [$i4 + 1], $f7
	fmul    $f7, $f5, $f5
	load    [$i4 + 0], $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f5, $f5
	fadd    $f5, $f1, $f1
	bg      $f0, $f1, ble_else.35907
ble_then.35907:
	li      0, $i4
.count b_cont
	b       ble_cont.35907
ble_else.35907:
	li      1, $i4
ble_cont.35907:
	bne     $i2, 0, be_else.35908
be_then.35908:
	bne     $i4, 0, be_else.35909
be_then.35909:
	li      0, $i1
	ret
be_else.35909:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35908:
	bne     $i4, 0, be_else.35910
be_then.35910:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35910:
	li      0, $i1
	ret
be_else.35906:
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
	bne     $i8, 0, be_else.35911
be_then.35911:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35911
be_else.35911:
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
be_cont.35911:
	bne     $i7, 3, be_cont.35912
be_then.35912:
	fsub    $f1, $fc0, $f1
be_cont.35912:
	bg      $f0, $f1, ble_else.35913
ble_then.35913:
	li      0, $i2
.count b_cont
	b       ble_cont.35913
ble_else.35913:
	li      1, $i2
ble_cont.35913:
	bne     $i9, 0, be_else.35914
be_then.35914:
	bne     $i2, 0, be_else.35915
be_then.35915:
	li      0, $i1
	ret
be_else.35915:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35914:
	bne     $i2, 0, be_else.35916
be_then.35916:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35916:
	li      0, $i1
	ret
be_else.35897:
	li      0, $i1
	ret
be_else.35879:
	li      0, $i1
	ret
be_else.35861:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# shadow_check_and_group
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.35917
be_then.35917:
	li      0, $i1
	ret
be_else.35917:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 1], $i12
	load    [min_caml_light_dirvec + 1], $i13
	load    [$i11 + 5], $i14
	load    [$i11 + 5], $i15
	load    [$i11 + 5], $i16
	load    [$i13 + $i10], $i13
	load    [$i14 + 2], $f11
	load    [min_caml_intersection_point + 2], $f12
	fsub    $f12, $f11, $f11
	load    [$i15 + 1], $f12
	load    [min_caml_intersection_point + 1], $f13
	fsub    $f13, $f12, $f12
	load    [$i16 + 0], $f13
	load    [min_caml_intersection_point + 0], $f14
	fsub    $f14, $f13, $f13
	bne     $i12, 1, be_else.35918
be_then.35918:
	load    [min_caml_light_dirvec + 0], $i12
	load    [$i13 + 1], $f14
	load    [$i13 + 0], $f15
	fsub    $f15, $f13, $f15
	fmul    $f15, $f14, $f14
	load    [$i12 + 1], $f15
	fmul    $f14, $f15, $f15
	fadd_a  $f15, $f12, $f15
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f16
	bg      $f16, $f15, ble_else.35919
ble_then.35919:
	li      0, $i14
.count b_cont
	b       ble_cont.35919
ble_else.35919:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f15
	load    [$i12 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.35920
ble_then.35920:
	li      0, $i14
.count b_cont
	b       ble_cont.35920
ble_else.35920:
	load    [$i13 + 1], $f15
	bne     $f15, $f0, be_else.35921
be_then.35921:
	li      0, $i14
.count b_cont
	b       be_cont.35921
be_else.35921:
	li      1, $i14
be_cont.35921:
ble_cont.35920:
ble_cont.35919:
	bne     $i14, 0, be_else.35922
be_then.35922:
	load    [$i13 + 3], $f14
	load    [$i13 + 2], $f15
	fsub    $f15, $f12, $f15
	fmul    $f15, $f14, $f14
	load    [$i12 + 0], $f15
	fmul    $f14, $f15, $f15
	fadd_a  $f15, $f13, $f15
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f16
	bg      $f16, $f15, ble_else.35923
ble_then.35923:
	li      0, $i14
.count b_cont
	b       ble_cont.35923
ble_else.35923:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f15
	load    [$i12 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.35924
ble_then.35924:
	li      0, $i14
.count b_cont
	b       ble_cont.35924
ble_else.35924:
	load    [$i13 + 3], $f15
	bne     $f15, $f0, be_else.35925
be_then.35925:
	li      0, $i14
.count b_cont
	b       be_cont.35925
be_else.35925:
	li      1, $i14
be_cont.35925:
ble_cont.35924:
ble_cont.35923:
	bne     $i14, 0, be_else.35926
be_then.35926:
	load    [$i13 + 5], $f14
	load    [$i13 + 4], $f15
	fsub    $f15, $f11, $f11
	fmul    $f11, $f14, $f11
	load    [$i12 + 0], $f14
	fmul    $f11, $f14, $f14
	fadd_a  $f14, $f13, $f13
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f14
	bg      $f14, $f13, ble_else.35927
ble_then.35927:
	li      0, $i11
.count b_cont
	b       be_cont.35918
ble_else.35927:
	load    [$i12 + 1], $f13
	fmul    $f11, $f13, $f13
	fadd_a  $f13, $f12, $f12
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f13
	bg      $f13, $f12, ble_else.35928
ble_then.35928:
	li      0, $i11
.count b_cont
	b       be_cont.35918
ble_else.35928:
	load    [$i13 + 5], $f12
	bne     $f12, $f0, be_else.35929
be_then.35929:
	li      0, $i11
.count b_cont
	b       be_cont.35918
be_else.35929:
	mov     $f11, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.35918
be_else.35926:
	mov     $f14, $fg0
	li      2, $i11
.count b_cont
	b       be_cont.35918
be_else.35922:
	mov     $f14, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35918
be_else.35918:
	load    [$i13 + 0], $f14
	bne     $i12, 2, be_else.35930
be_then.35930:
	bg      $f0, $f14, ble_else.35931
ble_then.35931:
	li      0, $i11
.count b_cont
	b       be_cont.35930
ble_else.35931:
	load    [$i13 + 3], $f14
	fmul    $f14, $f11, $f11
	load    [$i13 + 2], $f14
	fmul    $f14, $f12, $f12
	load    [$i13 + 1], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35930
be_else.35930:
	bne     $f14, $f0, be_else.35932
be_then.35932:
	li      0, $i11
.count b_cont
	b       be_cont.35932
be_else.35932:
	fmul    $f13, $f13, $f15
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f16
	fmul    $f15, $f16, $f15
	fmul    $f12, $f12, $f16
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f17
	fmul    $f16, $f17, $f16
	fadd    $f15, $f16, $f15
	fmul    $f11, $f11, $f16
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f17
	fmul    $f16, $f17, $f16
	fadd    $f15, $f16, $f15
	load    [$i11 + 3], $i14
	be      $i14, 0, bne_cont.35933
bne_then.35933:
	fmul    $f12, $f11, $f16
	load    [$i11 + 9], $i14
	load    [$i14 + 0], $f17
	fmul    $f16, $f17, $f16
	fadd    $f15, $f16, $f15
	fmul    $f11, $f13, $f16
	load    [$i11 + 9], $i14
	load    [$i14 + 1], $f17
	fmul    $f16, $f17, $f16
	fadd    $f15, $f16, $f15
	fmul    $f13, $f12, $f16
	load    [$i11 + 9], $i14
	load    [$i14 + 2], $f17
	fmul    $f16, $f17, $f16
	fadd    $f15, $f16, $f15
bne_cont.35933:
	bne     $i12, 3, be_cont.35934
be_then.35934:
	fsub    $f15, $fc0, $f15
be_cont.35934:
	fmul    $f14, $f15, $f14
	load    [$i13 + 3], $f15
	fmul    $f15, $f11, $f11
	load    [$i13 + 2], $f15
	fmul    $f15, $f12, $f12
	load    [$i13 + 1], $f15
	fmul    $f15, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fmul    $f11, $f11, $f12
	fsub    $f12, $f14, $f12
	bg      $f12, $f0, ble_else.35935
ble_then.35935:
	li      0, $i11
.count b_cont
	b       ble_cont.35935
ble_else.35935:
	load    [$i11 + 6], $i11
	fsqrt   $f12, $f12
	load    [$i13 + 4], $f13
	bne     $i11, 0, be_else.35936
be_then.35936:
	fsub    $f11, $f12, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35936
be_else.35936:
	fadd    $f11, $f12, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
be_cont.35936:
ble_cont.35935:
be_cont.35932:
be_cont.35930:
be_cont.35918:
	bne     $i11, 0, be_else.35937
be_then.35937:
	li      0, $i11
.count b_cont
	b       be_cont.35937
be_else.35937:
.count load_float
	load    [f.32101], $f11
	bg      $f11, $fg0, ble_else.35938
ble_then.35938:
	li      0, $i11
.count b_cont
	b       ble_cont.35938
ble_else.35938:
	li      1, $i11
ble_cont.35938:
be_cont.35937:
	bne     $i11, 0, be_else.35939
be_then.35939:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35940
be_then.35940:
	li      0, $i1
	ret
be_else.35940:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2862
be_else.35939:
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.35941
be_then.35941:
	li      1, $i1
	ret
be_else.35941:
	load    [min_caml_objects + $i10], $i10
	load    [$i10 + 5], $i11
	load    [$i10 + 5], $i12
	load    [$i10 + 5], $i13
	load    [$i10 + 1], $i14
	load    [min_caml_intersection_point + 2], $f11
	fadd    $fg0, $fc16, $f12
	fmul    $fg14, $f12, $f13
	fadd    $f13, $f11, $f4
	load    [$i11 + 2], $f11
	fsub    $f4, $f11, $f11
	load    [min_caml_intersection_point + 1], $f13
	fmul    $fg13, $f12, $f14
	fadd    $f14, $f13, $f3
	load    [$i12 + 1], $f13
	fsub    $f3, $f13, $f13
	load    [min_caml_intersection_point + 0], $f14
	fmul    $fg12, $f12, $f12
	fadd    $f12, $f14, $f2
	load    [$i13 + 0], $f12
	fsub    $f2, $f12, $f12
	load    [$i10 + 4], $i11
	bne     $i14, 1, be_else.35942
be_then.35942:
	fabs    $f12, $f12
	load    [$i11 + 0], $f14
	bg      $f14, $f12, ble_else.35943
ble_then.35943:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.35944
be_then.35944:
	li      1, $i10
.count b_cont
	b       be_cont.35942
be_else.35944:
	li      0, $i10
.count b_cont
	b       be_cont.35942
ble_else.35943:
	load    [$i10 + 4], $i11
	load    [$i11 + 1], $f12
	fabs    $f13, $f13
	bg      $f12, $f13, ble_else.35945
ble_then.35945:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.35946
be_then.35946:
	li      1, $i10
.count b_cont
	b       be_cont.35942
be_else.35946:
	li      0, $i10
.count b_cont
	b       be_cont.35942
ble_else.35945:
	load    [$i10 + 4], $i11
	load    [$i11 + 2], $f12
	fabs    $f11, $f11
	load    [$i10 + 6], $i10
	bg      $f12, $f11, be_cont.35942
ble_then.35947:
	bne     $i10, 0, be_else.35948
be_then.35948:
	li      1, $i10
.count b_cont
	b       be_cont.35942
be_else.35948:
	li      0, $i10
.count b_cont
	b       be_cont.35942
be_else.35942:
	load    [$i11 + 2], $f14
	bne     $i14, 2, be_else.35949
be_then.35949:
	fmul    $f14, $f11, $f11
	load    [$i11 + 1], $f14
	fmul    $f14, $f13, $f13
	load    [$i11 + 0], $f14
	fmul    $f14, $f12, $f12
	fadd    $f12, $f13, $f12
	fadd    $f12, $f11, $f11
	load    [$i10 + 6], $i10
	bg      $f0, $f11, ble_else.35950
ble_then.35950:
	bne     $i10, 0, be_else.35951
be_then.35951:
	li      1, $i10
.count b_cont
	b       be_cont.35949
be_else.35951:
	li      0, $i10
.count b_cont
	b       be_cont.35949
ble_else.35950:
	bne     $i10, 0, be_else.35952
be_then.35952:
	li      0, $i10
.count b_cont
	b       be_cont.35949
be_else.35952:
	li      1, $i10
.count b_cont
	b       be_cont.35949
be_else.35949:
	fmul    $f11, $f11, $f15
	fmul    $f15, $f14, $f14
	load    [$i10 + 4], $i11
	load    [$i11 + 1], $f15
	fmul    $f13, $f13, $f16
	fmul    $f16, $f15, $f15
	load    [$i10 + 4], $i11
	load    [$i11 + 0], $f16
	fmul    $f12, $f12, $f17
	fmul    $f17, $f16, $f16
	fadd    $f16, $f15, $f15
	fadd    $f15, $f14, $f14
	load    [$i10 + 3], $i11
	bne     $i11, 0, be_else.35953
be_then.35953:
	mov     $f14, $f11
.count b_cont
	b       be_cont.35953
be_else.35953:
	load    [$i10 + 9], $i11
	load    [$i11 + 2], $f15
	fmul    $f12, $f13, $f16
	fmul    $f16, $f15, $f15
	load    [$i10 + 9], $i11
	load    [$i11 + 1], $f16
	fmul    $f11, $f12, $f12
	fmul    $f12, $f16, $f12
	load    [$i10 + 9], $i11
	load    [$i11 + 0], $f16
	fmul    $f13, $f11, $f11
	fmul    $f11, $f16, $f11
	fadd    $f14, $f11, $f11
	fadd    $f11, $f12, $f11
	fadd    $f11, $f15, $f11
be_cont.35953:
	bne     $i14, 3, be_cont.35954
be_then.35954:
	fsub    $f11, $fc0, $f11
be_cont.35954:
	load    [$i10 + 6], $i10
	bg      $f0, $f11, ble_else.35955
ble_then.35955:
	bne     $i10, 0, be_else.35956
be_then.35956:
	li      1, $i10
.count b_cont
	b       ble_cont.35955
be_else.35956:
	li      0, $i10
.count b_cont
	b       ble_cont.35955
ble_else.35955:
	bne     $i10, 0, be_else.35957
be_then.35957:
	li      0, $i10
.count b_cont
	b       be_cont.35957
be_else.35957:
	li      1, $i10
be_cont.35957:
ble_cont.35955:
be_cont.35949:
be_cont.35942:
	bne     $i10, 0, be_else.35958
be_then.35958:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	li      1, $i2
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.35959
be_then.35959:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 2], $i3
	b       shadow_check_and_group.2862
be_else.35959:
	li      1, $i1
	ret
be_else.35958:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# shadow_check_one_or_group
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i3 + $i2], $i17
	bne     $i17, -1, be_else.35960
be_then.35960:
	li      0, $i1
	ret
be_else.35960:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35961
be_then.35961:
.count stack_load
	load    [$sp + 2], $i17
	add     $i17, 1, $i17
.count stack_load
	load    [$sp + 1], $i18
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35962
be_then.35962:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35962:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35963
be_then.35963:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35964
be_then.35964:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35964:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35965
be_then.35965:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35966
be_then.35966:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35966:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35967
be_then.35967:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35968
be_then.35968:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35968:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35969
be_then.35969:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35970
be_then.35970:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35970:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35971
be_then.35971:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35972
be_then.35972:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35972:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35973
be_then.35973:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35974
be_then.35974:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35974:
	load    [min_caml_and_net + $i19], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.35975
be_then.35975:
	add     $i17, 1, $i2
.count move_args
	mov     $i18, $i3
	b       shadow_check_one_or_group.2865
be_else.35975:
	li      1, $i1
	ret
be_else.35973:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35971:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35969:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35967:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35965:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35963:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35961:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_group

######################################################################
# shadow_check_one_or_matrix
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$i3 + $i2], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.35976
be_then.35976:
	li      0, $i1
	ret
be_else.35976:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i17, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	bne     $i18, 99, be_else.35977
be_then.35977:
	li      1, $i10
.count b_cont
	b       be_cont.35977
be_else.35977:
	load    [min_caml_objects + $i18], $i19
	load    [min_caml_intersection_point + 0], $f18
	load    [$i19 + 5], $i20
	load    [$i20 + 0], $f10
	fsub    $f18, $f10, $f18
	load    [min_caml_intersection_point + 1], $f10
	load    [$i19 + 5], $i20
	load    [$i20 + 1], $f11
	fsub    $f10, $f11, $f10
	load    [min_caml_intersection_point + 2], $f11
	load    [$i19 + 5], $i20
	load    [$i20 + 2], $f12
	fsub    $f11, $f12, $f11
	load    [min_caml_light_dirvec + 1], $i20
	load    [$i20 + $i18], $i18
	load    [$i19 + 1], $i20
	bne     $i20, 1, be_else.35978
be_then.35978:
	load    [min_caml_light_dirvec + 0], $i20
	load    [$i18 + 1], $f12
	load    [$i18 + 0], $f13
	fsub    $f13, $f18, $f13
	fmul    $f13, $f12, $f12
	load    [$i20 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f10, $f13
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f14
	bg      $f14, $f13, ble_else.35979
ble_then.35979:
	li      0, $i21
.count b_cont
	b       ble_cont.35979
ble_else.35979:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f13
	load    [$i20 + 2], $f14
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35980
ble_then.35980:
	li      0, $i21
.count b_cont
	b       ble_cont.35980
ble_else.35980:
	load    [$i18 + 1], $f13
	bne     $f13, $f0, be_else.35981
be_then.35981:
	li      0, $i21
.count b_cont
	b       be_cont.35981
be_else.35981:
	li      1, $i21
be_cont.35981:
ble_cont.35980:
ble_cont.35979:
	bne     $i21, 0, be_else.35982
be_then.35982:
	load    [$i18 + 3], $f12
	load    [$i18 + 2], $f13
	fsub    $f13, $f10, $f13
	fmul    $f13, $f12, $f12
	load    [$i20 + 0], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f18, $f13
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f14
	bg      $f14, $f13, ble_else.35983
ble_then.35983:
	li      0, $i21
.count b_cont
	b       ble_cont.35983
ble_else.35983:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f13
	load    [$i20 + 2], $f14
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35984
ble_then.35984:
	li      0, $i21
.count b_cont
	b       ble_cont.35984
ble_else.35984:
	load    [$i18 + 3], $f13
	bne     $f13, $f0, be_else.35985
be_then.35985:
	li      0, $i21
.count b_cont
	b       be_cont.35985
be_else.35985:
	li      1, $i21
be_cont.35985:
ble_cont.35984:
ble_cont.35983:
	bne     $i21, 0, be_else.35986
be_then.35986:
	load    [$i18 + 5], $f12
	load    [$i18 + 4], $f13
	fsub    $f13, $f11, $f11
	fmul    $f11, $f12, $f11
	load    [$i20 + 0], $f12
	fmul    $f11, $f12, $f12
	fadd_a  $f12, $f18, $f18
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f12
	bg      $f12, $f18, ble_else.35987
ble_then.35987:
	li      0, $i18
.count b_cont
	b       be_cont.35978
ble_else.35987:
	load    [$i20 + 1], $f18
	fmul    $f11, $f18, $f18
	fadd_a  $f18, $f10, $f18
	load    [$i19 + 4], $i19
	load    [$i19 + 1], $f10
	bg      $f10, $f18, ble_else.35988
ble_then.35988:
	li      0, $i18
.count b_cont
	b       be_cont.35978
ble_else.35988:
	load    [$i18 + 5], $f18
	bne     $f18, $f0, be_else.35989
be_then.35989:
	li      0, $i18
.count b_cont
	b       be_cont.35978
be_else.35989:
	mov     $f11, $fg0
	li      3, $i18
.count b_cont
	b       be_cont.35978
be_else.35986:
	mov     $f12, $fg0
	li      2, $i18
.count b_cont
	b       be_cont.35978
be_else.35982:
	mov     $f12, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35978
be_else.35978:
	load    [$i18 + 0], $f12
	bne     $i20, 2, be_else.35990
be_then.35990:
	bg      $f0, $f12, ble_else.35991
ble_then.35991:
	li      0, $i18
.count b_cont
	b       be_cont.35990
ble_else.35991:
	load    [$i18 + 3], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 2], $f12
	fmul    $f12, $f10, $f10
	load    [$i18 + 1], $f12
	fmul    $f12, $f18, $f18
	fadd    $f18, $f10, $f18
	fadd    $f18, $f11, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35990
be_else.35990:
	bne     $f12, $f0, be_else.35992
be_then.35992:
	li      0, $i18
.count b_cont
	b       be_cont.35992
be_else.35992:
	fmul    $f18, $f18, $f13
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f10, $f10, $f14
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	load    [$i19 + 3], $i21
	be      $i21, 0, bne_cont.35993
bne_then.35993:
	fmul    $f10, $f11, $f14
	load    [$i19 + 9], $i21
	load    [$i21 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f18, $f14
	load    [$i19 + 9], $i21
	load    [$i21 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f18, $f10, $f14
	load    [$i19 + 9], $i21
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
bne_cont.35993:
	bne     $i20, 3, be_cont.35994
be_then.35994:
	fsub    $f13, $fc0, $f13
be_cont.35994:
	fmul    $f12, $f13, $f12
	load    [$i18 + 3], $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 2], $f13
	fmul    $f13, $f10, $f10
	load    [$i18 + 1], $f13
	fmul    $f13, $f18, $f18
	fadd    $f18, $f10, $f18
	fadd    $f18, $f11, $f18
	fmul    $f18, $f18, $f10
	fsub    $f10, $f12, $f10
	bg      $f10, $f0, ble_else.35995
ble_then.35995:
	li      0, $i18
.count b_cont
	b       ble_cont.35995
ble_else.35995:
	load    [$i19 + 6], $i19
	fsqrt   $f10, $f10
	load    [$i18 + 4], $f11
	li      1, $i18
	bne     $i19, 0, be_else.35996
be_then.35996:
	fsub    $f18, $f10, $f18
	fmul    $f18, $f11, $fg0
.count b_cont
	b       be_cont.35996
be_else.35996:
	fadd    $f18, $f10, $f18
	fmul    $f18, $f11, $fg0
be_cont.35996:
ble_cont.35995:
be_cont.35992:
be_cont.35990:
be_cont.35978:
	bne     $i18, 0, be_else.35997
be_then.35997:
	li      0, $i10
.count b_cont
	b       be_cont.35997
be_else.35997:
	bg      $fc7, $fg0, ble_else.35998
ble_then.35998:
	li      0, $i10
.count b_cont
	b       ble_cont.35998
ble_else.35998:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35999
be_then.35999:
	li      0, $i10
.count b_cont
	b       be_cont.35999
be_else.35999:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36000
be_then.36000:
	li      2, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i10
	bne     $i10, 0, be_else.36001
be_then.36001:
	li      0, $i10
.count b_cont
	b       be_cont.36000
be_else.36001:
	li      1, $i10
.count b_cont
	b       be_cont.36000
be_else.36000:
	li      1, $i10
be_cont.36000:
be_cont.35999:
ble_cont.35998:
be_cont.35997:
be_cont.35977:
	bne     $i10, 0, be_else.36002
be_then.36002:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.36003
be_then.36003:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.36003:
.count stack_store
	store   $i12, [$sp + 4]
.count stack_store
	store   $i10, [$sp + 5]
	bne     $i2, 99, be_else.36004
be_then.36004:
	li      1, $i17
.count b_cont
	b       be_cont.36004
be_else.36004:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36005
be_then.36005:
	li      0, $i17
.count b_cont
	b       be_cont.36005
be_else.36005:
	bg      $fc7, $fg0, ble_else.36006
ble_then.36006:
	li      0, $i17
.count b_cont
	b       ble_cont.36006
ble_else.36006:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.36007
be_then.36007:
	li      0, $i17
.count b_cont
	b       be_cont.36007
be_else.36007:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36008
be_then.36008:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36009
be_then.36009:
	li      0, $i17
.count b_cont
	b       be_cont.36008
be_else.36009:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36010
be_then.36010:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36011
be_then.36011:
	li      0, $i17
.count b_cont
	b       be_cont.36008
be_else.36011:
	li      1, $i17
.count b_cont
	b       be_cont.36008
be_else.36010:
	li      1, $i17
.count b_cont
	b       be_cont.36008
be_else.36008:
	li      1, $i17
be_cont.36008:
be_cont.36007:
ble_cont.36006:
be_cont.36005:
be_cont.36004:
	bne     $i17, 0, be_else.36012
be_then.36012:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36012:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.36013
be_then.36013:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36013:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36014
be_then.36014:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36015
be_then.36015:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36015:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36016
be_then.36016:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.36017
be_then.36017:
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36017:
	li      1, $i1
	ret
be_else.36016:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.36014:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.36002:
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.36018
be_then.36018:
	li      0, $i10
.count b_cont
	b       be_cont.36018
be_else.36018:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36019
be_then.36019:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36020
be_then.36020:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36020:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36021
be_then.36021:
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.36022
be_then.36022:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36022:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36023
be_then.36023:
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.36024
be_then.36024:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36024:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36025
be_then.36025:
	load    [$i17 + 5], $i18
	bne     $i18, -1, be_else.36026
be_then.36026:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36026:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36027
be_then.36027:
	load    [$i17 + 6], $i18
	bne     $i18, -1, be_else.36028
be_then.36028:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36028:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36029
be_then.36029:
	load    [$i17 + 7], $i18
	bne     $i18, -1, be_else.36030
be_then.36030:
	li      0, $i10
.count b_cont
	b       be_cont.36019
be_else.36030:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36031
be_then.36031:
	li      8, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36019
be_else.36031:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36029:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36027:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36025:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36023:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36021:
	li      1, $i10
.count b_cont
	b       be_cont.36019
be_else.36019:
	li      1, $i10
be_cont.36019:
be_cont.36018:
	bne     $i10, 0, be_else.36032
be_then.36032:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.36033
be_then.36033:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.36033:
.count stack_store
	store   $i12, [$sp + 6]
.count stack_store
	store   $i10, [$sp + 7]
	bne     $i2, 99, be_else.36034
be_then.36034:
	li      1, $i17
.count b_cont
	b       be_cont.36034
be_else.36034:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36035
be_then.36035:
	li      0, $i17
.count b_cont
	b       be_cont.36035
be_else.36035:
	bg      $fc7, $fg0, ble_else.36036
ble_then.36036:
	li      0, $i17
.count b_cont
	b       ble_cont.36036
ble_else.36036:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.36037
be_then.36037:
	li      0, $i17
.count b_cont
	b       be_cont.36037
be_else.36037:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36038
be_then.36038:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36039
be_then.36039:
	li      0, $i17
.count b_cont
	b       be_cont.36038
be_else.36039:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36040
be_then.36040:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36041
be_then.36041:
	li      0, $i17
.count b_cont
	b       be_cont.36038
be_else.36041:
	li      1, $i17
.count b_cont
	b       be_cont.36038
be_else.36040:
	li      1, $i17
.count b_cont
	b       be_cont.36038
be_else.36038:
	li      1, $i17
be_cont.36038:
be_cont.36037:
ble_cont.36036:
be_cont.36035:
be_cont.36034:
	bne     $i17, 0, be_else.36042
be_then.36042:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36042:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.36043
be_then.36043:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36043:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36044
be_then.36044:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36045
be_then.36045:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36045:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36046
be_then.36046:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.36047
be_then.36047:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.36047:
	li      1, $i1
	ret
be_else.36046:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.36044:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.36032:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element
######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.36048
be_then.36048:
	ret
be_else.36048:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 1], $i12
	load    [$i11 + 5], $i13
	load    [$i11 + 5], $i14
	load    [$i11 + 5], $i15
	load    [$i13 + 2], $f11
	fsub    $fg19, $f11, $f11
	load    [$i14 + 1], $f12
	fsub    $fg18, $f12, $f12
	load    [$i15 + 0], $f13
	fsub    $fg17, $f13, $f13
	bne     $i12, 1, be_else.36049
be_then.36049:
	load    [$i4 + 0], $f14
	bne     $f14, $f0, be_else.36050
be_then.36050:
	li      0, $i12
.count b_cont
	b       be_cont.36050
be_else.36050:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f14, ble_else.36051
ble_then.36051:
	li      0, $i14
.count b_cont
	b       ble_cont.36051
ble_else.36051:
	li      1, $i14
ble_cont.36051:
	bne     $i13, 0, be_else.36052
be_then.36052:
	mov     $i14, $i13
.count b_cont
	b       be_cont.36052
be_else.36052:
	bne     $i14, 0, be_else.36053
be_then.36053:
	li      1, $i13
.count b_cont
	b       be_cont.36053
be_else.36053:
	li      0, $i13
be_cont.36053:
be_cont.36052:
	load    [$i12 + 0], $f15
	bne     $i13, 0, be_cont.36054
be_then.36054:
	fneg    $f15, $f15
be_cont.36054:
	fsub    $f15, $f13, $f15
	finv    $f14, $f14
	fmul    $f15, $f14, $f14
	load    [$i12 + 1], $f15
	load    [$i4 + 1], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f12, $f16
	bg      $f15, $f16, ble_else.36055
ble_then.36055:
	li      0, $i12
.count b_cont
	b       ble_cont.36055
ble_else.36055:
	load    [$i12 + 2], $f15
	load    [$i4 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.36056
ble_then.36056:
	li      0, $i12
.count b_cont
	b       ble_cont.36056
ble_else.36056:
	mov     $f14, $fg0
	li      1, $i12
ble_cont.36056:
ble_cont.36055:
be_cont.36050:
	bne     $i12, 0, be_else.36057
be_then.36057:
	load    [$i4 + 1], $f14
	bne     $f14, $f0, be_else.36058
be_then.36058:
	li      0, $i12
.count b_cont
	b       be_cont.36058
be_else.36058:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f14, ble_else.36059
ble_then.36059:
	li      0, $i14
.count b_cont
	b       ble_cont.36059
ble_else.36059:
	li      1, $i14
ble_cont.36059:
	bne     $i13, 0, be_else.36060
be_then.36060:
	mov     $i14, $i13
.count b_cont
	b       be_cont.36060
be_else.36060:
	bne     $i14, 0, be_else.36061
be_then.36061:
	li      1, $i13
.count b_cont
	b       be_cont.36061
be_else.36061:
	li      0, $i13
be_cont.36061:
be_cont.36060:
	load    [$i12 + 1], $f15
	bne     $i13, 0, be_cont.36062
be_then.36062:
	fneg    $f15, $f15
be_cont.36062:
	fsub    $f15, $f12, $f15
	finv    $f14, $f14
	fmul    $f15, $f14, $f14
	load    [$i12 + 2], $f15
	load    [$i4 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.36063
ble_then.36063:
	li      0, $i12
.count b_cont
	b       ble_cont.36063
ble_else.36063:
	load    [$i12 + 0], $f15
	load    [$i4 + 0], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f13, $f16
	bg      $f15, $f16, ble_else.36064
ble_then.36064:
	li      0, $i12
.count b_cont
	b       ble_cont.36064
ble_else.36064:
	mov     $f14, $fg0
	li      1, $i12
ble_cont.36064:
ble_cont.36063:
be_cont.36058:
	bne     $i12, 0, be_else.36065
be_then.36065:
	load    [$i4 + 2], $f14
	bne     $f14, $f0, be_else.36066
be_then.36066:
	li      0, $i11
.count b_cont
	b       be_cont.36049
be_else.36066:
	finv    $f14, $f15
	load    [$i11 + 4], $i12
	load    [$i12 + 2], $f16
	bg      $f0, $f14, ble_else.36067
ble_then.36067:
	li      0, $i13
.count b_cont
	b       ble_cont.36067
ble_else.36067:
	li      1, $i13
ble_cont.36067:
	load    [$i11 + 6], $i11
	bne     $i11, 0, be_else.36068
be_then.36068:
	mov     $i13, $i11
.count b_cont
	b       be_cont.36068
be_else.36068:
	bne     $i13, 0, be_else.36069
be_then.36069:
	li      1, $i11
.count b_cont
	b       be_cont.36069
be_else.36069:
	li      0, $i11
be_cont.36069:
be_cont.36068:
	bne     $i11, 0, be_else.36070
be_then.36070:
	fneg    $f16, $f14
.count b_cont
	b       be_cont.36070
be_else.36070:
	mov     $f16, $f14
be_cont.36070:
	fsub    $f14, $f11, $f11
	fmul    $f11, $f15, $f11
	load    [$i4 + 0], $f14
	fmul    $f11, $f14, $f14
	fadd_a  $f14, $f13, $f13
	load    [$i12 + 0], $f14
	bg      $f14, $f13, ble_else.36071
ble_then.36071:
	li      0, $i11
.count b_cont
	b       be_cont.36049
ble_else.36071:
	load    [$i4 + 1], $f13
	fmul    $f11, $f13, $f13
	fadd_a  $f13, $f12, $f12
	load    [$i12 + 1], $f13
	bg      $f13, $f12, ble_else.36072
ble_then.36072:
	li      0, $i11
.count b_cont
	b       be_cont.36049
ble_else.36072:
	mov     $f11, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.36049
be_else.36065:
	li      2, $i11
.count b_cont
	b       be_cont.36049
be_else.36057:
	li      1, $i11
.count b_cont
	b       be_cont.36049
be_else.36049:
	bne     $i12, 2, be_else.36073
be_then.36073:
	load    [$i11 + 4], $i11
	load    [$i4 + 0], $f14
	load    [$i11 + 0], $f15
	fmul    $f14, $f15, $f14
	load    [$i4 + 1], $f16
	load    [$i11 + 1], $f17
	fmul    $f16, $f17, $f16
	fadd    $f14, $f16, $f14
	load    [$i4 + 2], $f16
	load    [$i11 + 2], $f18
	fmul    $f16, $f18, $f16
	fadd    $f14, $f16, $f14
	bg      $f14, $f0, ble_else.36074
ble_then.36074:
	li      0, $i11
.count b_cont
	b       be_cont.36073
ble_else.36074:
	finv    $f14, $f14
	fmul    $f15, $f13, $f13
	fmul    $f17, $f12, $f12
	fadd    $f13, $f12, $f12
	fmul    $f18, $f11, $f11
	fadd_n  $f12, $f11, $f11
	fmul    $f11, $f14, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36073
be_else.36073:
	load    [$i11 + 4], $i12
	load    [$i11 + 4], $i13
	load    [$i11 + 4], $i14
	load    [$i11 + 3], $i15
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f15, $f15, $f16
	fmul    $f16, $f14, $f16
	load    [$i13 + 1], $f17
	load    [$i4 + 1], $f18
	fmul    $f18, $f18, $f1
	fmul    $f1, $f17, $f1
	load    [$i14 + 0], $f2
	load    [$i4 + 0], $f3
	fmul    $f3, $f3, $f4
	fmul    $f4, $f2, $f4
	fadd    $f4, $f1, $f1
	fadd    $f1, $f16, $f16
	be      $i15, 0, bne_cont.36075
bne_then.36075:
	fmul    $f18, $f15, $f1
	load    [$i11 + 9], $i12
	load    [$i12 + 0], $f4
	fmul    $f1, $f4, $f1
	fadd    $f16, $f1, $f16
	fmul    $f15, $f3, $f1
	load    [$i11 + 9], $i12
	load    [$i12 + 1], $f4
	fmul    $f1, $f4, $f1
	fadd    $f16, $f1, $f16
	fmul    $f3, $f18, $f1
	load    [$i11 + 9], $i12
	load    [$i12 + 2], $f4
	fmul    $f1, $f4, $f1
	fadd    $f16, $f1, $f16
bne_cont.36075:
	bne     $f16, $f0, be_else.36076
be_then.36076:
	li      0, $i11
.count b_cont
	b       be_cont.36076
be_else.36076:
	load    [$i11 + 1], $i12
	fmul    $f11, $f11, $f1
	fmul    $f1, $f14, $f1
	fmul    $f12, $f12, $f4
	fmul    $f4, $f17, $f4
	fmul    $f13, $f13, $f5
	fmul    $f5, $f2, $f5
	fadd    $f5, $f4, $f4
	fadd    $f4, $f1, $f1
	be      $i15, 0, bne_cont.36077
bne_then.36077:
	fmul    $f12, $f11, $f4
	load    [$i11 + 9], $i13
	load    [$i13 + 0], $f5
	fmul    $f4, $f5, $f4
	fadd    $f1, $f4, $f1
	fmul    $f11, $f13, $f4
	load    [$i11 + 9], $i13
	load    [$i13 + 1], $f5
	fmul    $f4, $f5, $f4
	fadd    $f1, $f4, $f1
	fmul    $f13, $f12, $f4
	load    [$i11 + 9], $i13
	load    [$i13 + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f1, $f4, $f1
bne_cont.36077:
	bne     $i12, 3, be_cont.36078
be_then.36078:
	fsub    $f1, $fc0, $f1
be_cont.36078:
	fmul    $f16, $f1, $f1
	fmul    $f15, $f11, $f4
	fmul    $f4, $f14, $f14
	fmul    $f18, $f12, $f4
	fmul    $f4, $f17, $f17
	fmul    $f3, $f13, $f4
	fmul    $f4, $f2, $f2
	fadd    $f2, $f17, $f17
	fadd    $f17, $f14, $f14
	bne     $i15, 0, be_else.36079
be_then.36079:
	mov     $f14, $f11
.count b_cont
	b       be_cont.36079
be_else.36079:
	fmul    $f15, $f12, $f17
	fmul    $f18, $f11, $f2
	fadd    $f17, $f2, $f17
	load    [$i11 + 9], $i12
	load    [$i12 + 0], $f2
	fmul    $f17, $f2, $f17
	fmul    $f3, $f11, $f11
	fmul    $f15, $f13, $f15
	fadd    $f11, $f15, $f11
	load    [$i11 + 9], $i12
	load    [$i12 + 1], $f15
	fmul    $f11, $f15, $f11
	fadd    $f17, $f11, $f11
	fmul    $f3, $f12, $f12
	fmul    $f18, $f13, $f13
	fadd    $f12, $f13, $f12
	load    [$i11 + 9], $i12
	load    [$i12 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fadd    $f14, $f11, $f11
be_cont.36079:
	fmul    $f11, $f11, $f12
	fsub    $f12, $f1, $f12
	bg      $f12, $f0, ble_else.36080
ble_then.36080:
	li      0, $i11
.count b_cont
	b       ble_cont.36080
ble_else.36080:
	load    [$i11 + 6], $i11
	fsqrt   $f12, $f12
	finv    $f16, $f13
	bne     $i11, 0, be_else.36081
be_then.36081:
	fneg    $f12, $f12
	fsub    $f12, $f11, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36081
be_else.36081:
	fsub    $f12, $f11, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
be_cont.36081:
ble_cont.36080:
be_cont.36076:
be_cont.36073:
be_cont.36049:
	bne     $i11, 0, be_else.36082
be_then.36082:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.36083
be_then.36083:
	ret
be_else.36083:
	add     $i2, 1, $i2
	b       solve_each_element.2871
be_else.36082:
	bg      $fg0, $f0, ble_else.36084
ble_then.36084:
	add     $i2, 1, $i2
	b       solve_each_element.2871
ble_else.36084:
	bg      $fg7, $fg0, ble_else.36085
ble_then.36085:
	add     $i2, 1, $i2
	b       solve_each_element.2871
ble_else.36085:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	fadd    $fg0, $fc16, $f11
	load    [$i4 + 2], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg19, $f4
.count stack_store
	store   $f4, [$sp + 4]
	load    [$i4 + 1], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg18, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i4 + 0], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg17, $f2
.count stack_store
	store   $f2, [$sp + 6]
	li      0, $i2
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.36086
be_then.36086:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2871
be_else.36086:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 2]
	mov     $i10, $ig4
	mov     $i11, $ig2
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2871
.end solve_each_element

######################################################################
# solve_one_or_network
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$i3 + $i2], $i16
	bne     $i16, -1, be_else.36087
be_then.36087:
	ret
be_else.36087:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i17
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36088
be_then.36088:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36088:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36089
be_then.36089:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36089:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36090
be_then.36090:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36090:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36091
be_then.36091:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36091:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36092
be_then.36092:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36092:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36093
be_then.36093:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36093:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.36094
be_then.36094:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36094:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i4
.count move_args
	mov     $i17, $i3
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$i3 + $i2], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.36095
be_then.36095:
	ret
be_else.36095:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	bne     $i17, 99, be_else.36096
be_then.36096:
	load    [$i16 + 1], $i17
	be      $i17, -1, bne_cont.36097
bne_then.36097:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    solve_each_element.2871
	load    [$i16 + 2], $i17
	be      $i17, -1, bne_cont.36098
bne_then.36098:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 3], $i17
	be      $i17, -1, bne_cont.36099
bne_then.36099:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 4], $i17
	be      $i17, -1, bne_cont.36100
bne_then.36100:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 5], $i17
	be      $i17, -1, bne_cont.36101
bne_then.36101:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 6], $i17
	be      $i17, -1, bne_cont.36102
bne_then.36102:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network.2875
bne_cont.36102:
bne_cont.36101:
bne_cont.36100:
bne_cont.36099:
bne_cont.36098:
bne_cont.36097:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i16], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.36103
be_then.36103:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36103:
	bne     $i18, 99, be_else.36104
be_then.36104:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.36105
be_then.36105:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36105:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36106
be_then.36106:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36106:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.36107
be_then.36107:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36107:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.36108
be_then.36108:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36108:
.count stack_store
	store   $i16, [$sp + 4]
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	li      5, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i17, $i3
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36104:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i18, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.36109
be_then.36109:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36109:
	bg      $fg7, $fg0, ble_else.36110
ble_then.36110:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
ble_else.36110:
.count stack_store
	store   $i16, [$sp + 4]
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i17, $i3
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36096:
.count move_args
	mov     $i17, $i2
.count move_args
	mov     $i4, $i3
	call    solver.2773
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.36111
be_then.36111:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.36111:
	bg      $fg7, $fg0, ble_else.36112
ble_then.36112:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
ble_else.36112:
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network.2875
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.36113
be_then.36113:
	ret
be_else.36113:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 10], $i12
	load    [$i11 + 1], $i13
	load    [$i4 + 1], $i14
	load    [$i14 + $i10], $i14
	load    [$i12 + 2], $f11
	load    [$i12 + 1], $f12
	load    [$i12 + 0], $f13
	bne     $i13, 1, be_else.36114
be_then.36114:
	load    [$i4 + 0], $i12
	load    [$i14 + 1], $f14
	load    [$i14 + 0], $f15
	fsub    $f15, $f13, $f15
	fmul    $f15, $f14, $f14
	load    [$i12 + 1], $f15
	fmul    $f14, $f15, $f15
	fadd_a  $f15, $f12, $f15
	load    [$i11 + 4], $i13
	load    [$i13 + 1], $f16
	bg      $f16, $f15, ble_else.36115
ble_then.36115:
	li      0, $i13
.count b_cont
	b       ble_cont.36115
ble_else.36115:
	load    [$i11 + 4], $i13
	load    [$i13 + 2], $f15
	load    [$i12 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.36116
ble_then.36116:
	li      0, $i13
.count b_cont
	b       ble_cont.36116
ble_else.36116:
	load    [$i14 + 1], $f15
	bne     $f15, $f0, be_else.36117
be_then.36117:
	li      0, $i13
.count b_cont
	b       be_cont.36117
be_else.36117:
	li      1, $i13
be_cont.36117:
ble_cont.36116:
ble_cont.36115:
	bne     $i13, 0, be_else.36118
be_then.36118:
	load    [$i14 + 3], $f14
	load    [$i14 + 2], $f15
	fsub    $f15, $f12, $f15
	fmul    $f15, $f14, $f14
	load    [$i12 + 0], $f15
	fmul    $f14, $f15, $f15
	fadd_a  $f15, $f13, $f15
	load    [$i11 + 4], $i13
	load    [$i13 + 0], $f16
	bg      $f16, $f15, ble_else.36119
ble_then.36119:
	li      0, $i13
.count b_cont
	b       ble_cont.36119
ble_else.36119:
	load    [$i11 + 4], $i13
	load    [$i13 + 2], $f15
	load    [$i12 + 2], $f16
	fmul    $f14, $f16, $f16
	fadd_a  $f16, $f11, $f16
	bg      $f15, $f16, ble_else.36120
ble_then.36120:
	li      0, $i13
.count b_cont
	b       ble_cont.36120
ble_else.36120:
	load    [$i14 + 3], $f15
	bne     $f15, $f0, be_else.36121
be_then.36121:
	li      0, $i13
.count b_cont
	b       be_cont.36121
be_else.36121:
	li      1, $i13
be_cont.36121:
ble_cont.36120:
ble_cont.36119:
	bne     $i13, 0, be_else.36122
be_then.36122:
	load    [$i14 + 5], $f14
	load    [$i14 + 4], $f15
	fsub    $f15, $f11, $f11
	fmul    $f11, $f14, $f11
	load    [$i12 + 0], $f14
	fmul    $f11, $f14, $f14
	fadd_a  $f14, $f13, $f13
	load    [$i11 + 4], $i13
	load    [$i13 + 0], $f14
	bg      $f14, $f13, ble_else.36123
ble_then.36123:
	li      0, $i11
.count b_cont
	b       be_cont.36114
ble_else.36123:
	load    [$i12 + 1], $f13
	fmul    $f11, $f13, $f13
	fadd_a  $f13, $f12, $f12
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f13
	bg      $f13, $f12, ble_else.36124
ble_then.36124:
	li      0, $i11
.count b_cont
	b       be_cont.36114
ble_else.36124:
	load    [$i14 + 5], $f12
	bne     $f12, $f0, be_else.36125
be_then.36125:
	li      0, $i11
.count b_cont
	b       be_cont.36114
be_else.36125:
	mov     $f11, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.36114
be_else.36122:
	mov     $f14, $fg0
	li      2, $i11
.count b_cont
	b       be_cont.36114
be_else.36118:
	mov     $f14, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36114
be_else.36114:
	bne     $i13, 2, be_else.36126
be_then.36126:
	load    [$i14 + 0], $f11
	bg      $f0, $f11, ble_else.36127
ble_then.36127:
	li      0, $i11
.count b_cont
	b       be_cont.36126
ble_else.36127:
	load    [$i12 + 3], $f12
	fmul    $f11, $f12, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36126
be_else.36126:
	load    [$i14 + 0], $f14
	bne     $f14, $f0, be_else.36128
be_then.36128:
	li      0, $i11
.count b_cont
	b       be_cont.36128
be_else.36128:
	load    [$i12 + 3], $f15
	fmul    $f14, $f15, $f14
	load    [$i14 + 3], $f15
	fmul    $f15, $f11, $f11
	load    [$i14 + 2], $f15
	fmul    $f15, $f12, $f12
	load    [$i14 + 1], $f15
	fmul    $f15, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fmul    $f11, $f11, $f12
	fsub    $f12, $f14, $f12
	bg      $f12, $f0, ble_else.36129
ble_then.36129:
	li      0, $i11
.count b_cont
	b       ble_cont.36129
ble_else.36129:
	load    [$i11 + 6], $i11
	fsqrt   $f12, $f12
	load    [$i14 + 4], $f13
	bne     $i11, 0, be_else.36130
be_then.36130:
	fsub    $f11, $f12, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36130
be_else.36130:
	fadd    $f11, $f12, $f11
	fmul    $f11, $f13, $fg0
	li      1, $i11
be_cont.36130:
ble_cont.36129:
be_cont.36128:
be_cont.36126:
be_cont.36114:
	bne     $i11, 0, be_else.36131
be_then.36131:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.36132
be_then.36132:
	ret
be_else.36132:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
be_else.36131:
	bg      $fg0, $f0, ble_else.36133
ble_then.36133:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
ble_else.36133:
	load    [$i4 + 0], $i12
	bg      $fg7, $fg0, ble_else.36134
ble_then.36134:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
ble_else.36134:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	fadd    $fg0, $fc16, $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg10, $f4
.count stack_store
	store   $f4, [$sp + 4]
	load    [$i12 + 1], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg9, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i12 + 0], $f12
	fmul    $f12, $f11, $f12
	fadd    $f12, $fg8, $f2
.count stack_store
	store   $f2, [$sp + 6]
	li      0, $i2
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.36135
be_then.36135:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2885
be_else.36135:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 2]
	mov     $i10, $ig4
	mov     $i11, $ig2
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$i3 + $i2], $i15
	bne     $i15, -1, be_else.36136
be_then.36136:
	ret
be_else.36136:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	load    [min_caml_and_net + $i15], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36137
be_then.36137:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36137:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36138
be_then.36138:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36138:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36139
be_then.36139:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36139:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36140
be_then.36140:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36140:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36141
be_then.36141:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36141:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36142
be_then.36142:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36142:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36143
be_then.36143:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36143:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i4
.count move_args
	mov     $i16, $i3
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$i3 + $i2], $i15
	load    [$i15 + 0], $i16
	bne     $i16, -1, be_else.36144
be_then.36144:
	ret
be_else.36144:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	bne     $i16, 99, be_else.36145
be_then.36145:
	load    [$i15 + 1], $i16
	be      $i16, -1, bne_cont.36146
bne_then.36146:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i15 + 2], $i16
	be      $i16, -1, bne_cont.36147
bne_then.36147:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 3], $i16
	be      $i16, -1, bne_cont.36148
bne_then.36148:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 4], $i16
	be      $i16, -1, bne_cont.36149
bne_then.36149:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 5], $i16
	be      $i16, -1, bne_cont.36150
bne_then.36150:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 6], $i16
	be      $i16, -1, bne_cont.36151
bne_then.36151:
	load    [min_caml_and_net + $i16], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i15, $i3
	call    solve_one_or_network_fast.2889
bne_cont.36151:
bne_cont.36150:
bne_cont.36149:
bne_cont.36148:
bne_cont.36147:
bne_cont.36146:
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i15], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.36152
be_then.36152:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36152:
	bne     $i17, 99, be_else.36153
be_then.36153:
	load    [$i16 + 1], $i17
	bne     $i17, -1, be_else.36154
be_then.36154:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36154:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i17
	bne     $i17, -1, be_else.36155
be_then.36155:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36155:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i17
	bne     $i17, -1, be_else.36156
be_then.36156:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36156:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i17
	bne     $i17, -1, be_else.36157
be_then.36157:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36157:
.count stack_store
	store   $i15, [$sp + 4]
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	li      5, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36153:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i17, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36158
be_then.36158:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36158:
	bg      $fg7, $fg0, ble_else.36159
ble_then.36159:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
ble_else.36159:
.count stack_store
	store   $i15, [$sp + 4]
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36145:
.count move_args
	mov     $i16, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36160
be_then.36160:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36160:
	bg      $fg7, $fg0, ble_else.36161
ble_then.36161:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
ble_else.36161:
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i15, $i3
	call    solve_one_or_network_fast.2889
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture
######################################################################
.begin utexture
utexture.2908:
	load    [$i2 + 8], $i1
	load    [$i1 + 0], $fg16
	load    [$i2 + 8], $i1
	load    [$i1 + 1], $fg11
	load    [$i2 + 8], $i1
	load    [$i1 + 2], $fg15
	load    [$i2 + 0], $i1
	bne     $i1, 1, be_else.36162
be_then.36162:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
	load    [$i1 + 0], $f10
	load    [min_caml_intersection_point + 0], $f11
	fsub    $f11, $f10, $f10
.count load_float
	load    [f.32114], $f11
.count load_float
	load    [f.32115], $f12
	fmul    $f10, $f12, $f2
	call    min_caml_floor
.count move_ret
	mov     $f1, $f13
	fmul    $f13, $f11, $f13
	fsub    $f10, $f13, $f10
.count load_float
	load    [f.32116], $f13
	bg      $f13, $f10, ble_else.36163
ble_then.36163:
	li      0, $i1
.count b_cont
	b       ble_cont.36163
ble_else.36163:
	li      1, $i1
ble_cont.36163:
	load    [$i10 + 2], $f10
	load    [min_caml_intersection_point + 2], $f14
	fsub    $f14, $f10, $f10
	fmul    $f10, $f12, $f2
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	fmul    $f1, $f11, $f1
	fsub    $f10, $f1, $f1
	bg      $f13, $f1, ble_else.36164
ble_then.36164:
	bne     $i1, 0, be_else.36165
be_then.36165:
	mov     $fc9, $fg11
	ret
be_else.36165:
	mov     $f0, $fg11
	ret
ble_else.36164:
	bne     $i1, 0, be_else.36166
be_then.36166:
	mov     $f0, $fg11
	ret
be_else.36166:
	mov     $fc9, $fg11
	ret
be_else.36162:
	bne     $i1, 2, be_else.36167
be_then.36167:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count load_float
	load    [f.32113], $f10
	load    [min_caml_intersection_point + 1], $f11
	fmul    $f11, $f10, $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	ret
be_else.36167:
	bne     $i1, 3, be_else.36168
be_then.36168:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
	load    [$i1 + 2], $f10
	load    [min_caml_intersection_point + 2], $f11
	fsub    $f11, $f10, $f10
	fmul    $f10, $f10, $f10
	load    [$i10 + 0], $f11
	load    [min_caml_intersection_point + 0], $f12
	fsub    $f12, $f11, $f11
	fmul    $f11, $f11, $f11
	fadd    $f11, $f10, $f10
	fsqrt   $f10, $f10
	fmul    $f10, $fc8, $f2
.count stack_store
	store   $f2, [$sp + 1]
	call    min_caml_floor
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 1], $f11
	fsub    $f11, $f10, $f10
	fmul    $f10, $fc15, $f2
	call    min_caml_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg15
	ret
be_else.36168:
	bne     $i1, 4, be_else.36169
be_then.36169:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 2]
	load    [$i2 + 4], $i1
	load    [$i2 + 5], $i10
	load    [$i2 + 4], $i11
	load    [$i2 + 5], $i12
	load    [$i1 + 2], $f10
	fsqrt   $f10, $f10
	load    [$i10 + 2], $f11
	load    [min_caml_intersection_point + 2], $f12
	fsub    $f12, $f11, $f11
	fmul    $f11, $f10, $f10
	load    [$i11 + 0], $f11
	fsqrt   $f11, $f11
	load    [$i12 + 0], $f12
	load    [min_caml_intersection_point + 0], $f13
	fsub    $f13, $f12, $f12
	fmul    $f12, $f11, $f11
	fabs    $f11, $f12
.count load_float
	load    [f.32104], $f13
	bg      $f13, $f12, ble_else.36170
ble_then.36170:
	finv    $f11, $f12
	fmul_a  $f10, $f12, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f12
	fmul    $f12, $fc18, $f12
	fmul    $f12, $fc17, $f12
.count b_cont
	b       ble_cont.36170
ble_else.36170:
	mov     $fc19, $f12
ble_cont.36170:
.count stack_load
	load    [$sp + 2], $i1
	load    [$i1 + 4], $i10
	load    [$i1 + 5], $i1
	fmul    $f10, $f10, $f10
	fmul    $f11, $f11, $f11
	fadd    $f11, $f10, $f10
	load    [$i10 + 1], $f11
	fsqrt   $f11, $f11
	load    [$i1 + 1], $f14
	load    [min_caml_intersection_point + 1], $f15
	fsub    $f15, $f14, $f14
	fmul    $f14, $f11, $f11
	fabs    $f10, $f14
	bg      $f13, $f14, ble_else.36171
ble_then.36171:
	finv    $f10, $f10
	fmul_a  $f11, $f10, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $fc18, $f10
	fmul    $f10, $fc17, $f2
.count b_cont
	b       ble_cont.36171
ble_else.36171:
	mov     $fc19, $f2
ble_cont.36171:
.count stack_store
	store   $f2, [$sp + 3]
	call    min_caml_floor
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 3], $f11
	fsub    $f11, $f10, $f10
	fsub    $fc3, $f10, $f10
	fmul    $f10, $f10, $f10
.count move_args
	mov     $f12, $f2
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	fsub    $f12, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
.count load_float
	load    [f.32109], $f2
	fsub    $f2, $f1, $f1
	fsub    $f1, $f10, $f1
	bg      $f0, $f1, ble_else.36172
ble_then.36172:
.count load_float
	load    [f.32110], $f2
	fmul    $fc9, $f1, $f1
	fmul    $f1, $f2, $fg15
	ret
ble_else.36172:
	mov     $f0, $fg15
	ret
be_else.36169:
	ret
.end utexture

######################################################################
# trace_reflections
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i2, 0, bge_else.36173
bge_then.36173:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $f3, [$sp + 2]
.count stack_store
	store   $f2, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 4]
	load    [min_caml_reflections + $i2], $i19
	load    [$i19 + 1], $i4
.count stack_store
	store   $i4, [$sp + 5]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.36174
bne_then.36174:
	bne     $i21, 99, be_else.36175
be_then.36175:
	load    [$i20 + 1], $i21
	bne     $i21, -1, be_else.36176
be_then.36176:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36175
be_else.36176:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36177
be_then.36177:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36175
be_else.36177:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36178
be_then.36178:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36175
be_else.36178:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36179
be_then.36179:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36175
be_else.36179:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	li      5, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36175
be_else.36175:
.count move_args
	mov     $i21, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 5], $i4
	li      1, $i2
	bne     $i21, 0, be_else.36180
be_then.36180:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36180
be_else.36180:
	bg      $fg7, $fg0, ble_else.36181
ble_then.36181:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36181
ble_else.36181:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
ble_cont.36181:
be_cont.36180:
be_cont.36175:
bne_cont.36174:
	bg      $fg7, $fc7, ble_else.36182
ble_then.36182:
	li      0, $i22
.count b_cont
	b       ble_cont.36182
ble_else.36182:
	bg      $fc13, $fg7, ble_else.36183
ble_then.36183:
	li      0, $i22
.count b_cont
	b       ble_cont.36183
ble_else.36183:
	li      1, $i22
ble_cont.36183:
ble_cont.36182:
	bne     $i22, 0, be_else.36184
be_then.36184:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 6], $i3
	b       trace_reflections.2915
be_else.36184:
	load    [$i19 + 0], $i22
	add     $ig4, $ig4, $i23
	add     $i23, $i23, $i23
	add     $i23, $ig2, $i23
	bne     $i23, $i22, be_else.36185
be_then.36185:
.count stack_store
	store   $i19, [$sp + 6]
	li      0, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.36186
be_then.36186:
.count stack_load
	load    [$sp - 1], $i1
	load    [$i1 + 2], $f1
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 0], $i1
	load    [$i1 + 2], $f2
	load    [min_caml_nvector + 2], $f3
	fmul    $f3, $f2, $f3
	load    [$i1 + 1], $f4
	load    [min_caml_nvector + 1], $f5
	fmul    $f5, $f4, $f5
	load    [$i1 + 0], $f6
	load    [min_caml_nvector + 0], $f7
	fmul    $f7, $f6, $f7
	fadd    $f7, $f5, $f5
	fadd    $f5, $f3, $f3
.count stack_load
	load    [$sp - 4], $f5
	fmul    $f1, $f5, $f7
	fmul    $f7, $f3, $f3
	ble     $f3, $f0, bg_cont.36187
bg_then.36187:
	fmul    $f3, $fg16, $f7
	fadd    $fg4, $f7, $fg4
	fmul    $f3, $fg11, $f7
	fadd    $fg5, $f7, $fg5
	fmul    $f3, $fg15, $f3
	fadd    $fg6, $f3, $fg6
bg_cont.36187:
.count stack_load
	load    [$sp - 6], $i3
	load    [$i3 + 2], $f3
	fmul    $f3, $f2, $f2
	load    [$i3 + 1], $f3
	fmul    $f3, $f4, $f3
	load    [$i3 + 0], $f4
	fmul    $f4, $f6, $f4
	fadd    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fmul    $f1, $f2, $f1
.count move_args
	mov     $f5, $f2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
	ble     $f1, $f0, trace_reflections.2915
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f3, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	b       trace_reflections.2915
be_else.36186:
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 6], $i3
	b       trace_reflections.2915
be_else.36185:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 6], $i3
	b       trace_reflections.2915
bge_else.36173:
	ret
.end trace_reflections

######################################################################
# trace_ray
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i2, 4, ble_else.36189
ble_then.36189:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f3, [$sp + 1]
.count stack_store
	store   $f2, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 4]
.count stack_store
	store   $i4, [$sp + 5]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.36190
bne_then.36190:
	bne     $i21, 99, be_else.36191
be_then.36191:
	load    [$i20 + 1], $i21
.count move_args
	mov     $i3, $i4
	bne     $i21, -1, be_else.36192
be_then.36192:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36191
be_else.36192:
	load    [min_caml_and_net + $i21], $i16
	li      0, $i2
.count move_args
	mov     $i16, $i3
	call    solve_each_element.2871
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36193
be_then.36193:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36191
be_else.36193:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element.2871
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36194
be_then.36194:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36191
be_else.36194:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element.2871
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36195
be_then.36195:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36191
be_else.36195:
	load    [min_caml_and_net + $i21], $i3
	li      0, $i2
	call    solve_each_element.2871
	li      5, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network.2875
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36191
be_else.36191:
.count move_args
	mov     $i21, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 3], $i4
	li      1, $i2
	bne     $i21, 0, be_else.36196
be_then.36196:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36196
be_else.36196:
	bg      $fg7, $fg0, ble_else.36197
ble_then.36197:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.36197
ble_else.36197:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network.2875
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix.2879
ble_cont.36197:
be_cont.36196:
be_cont.36191:
bne_cont.36190:
.count stack_load
	load    [$sp + 5], $i13
	load    [$i13 + 2], $i14
	bg      $fg7, $fc7, ble_else.36198
ble_then.36198:
	li      0, $i15
.count b_cont
	b       ble_cont.36198
ble_else.36198:
	bg      $fc13, $fg7, ble_else.36199
ble_then.36199:
	li      0, $i15
.count b_cont
	b       ble_cont.36199
ble_else.36199:
	li      1, $i15
ble_cont.36199:
ble_cont.36198:
	bne     $i15, 0, be_else.36200
be_then.36200:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i0, -1, $i1
.count stack_load
	load    [$sp - 6], $i2
.count storer
	add     $i14, $i2, $tmp
	store   $i1, [$tmp + 0]
	bne     $i2, 0, be_else.36201
be_then.36201:
	ret
be_else.36201:
.count stack_load
	load    [$sp - 7], $i1
	load    [$i1 + 2], $f1
	fmul    $f1, $fg14, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $fg13, $f2
	load    [$i1 + 0], $f3
	fmul    $f3, $fg12, $f3
	fadd    $f3, $f2, $f2
	fadd_n  $f2, $f1, $f1
	bg      $f1, $f0, ble_else.36202
ble_then.36202:
	ret
ble_else.36202:
	load    [min_caml_beam + 0], $f2
	fmul    $f1, $f1, $f3
	fmul    $f3, $f1, $f1
.count stack_load
	load    [$sp - 8], $f3
	fmul    $f1, $f3, $f1
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	ret
be_else.36200:
.count stack_store
	store   $i14, [$sp + 6]
	load    [min_caml_objects + $ig4], $i2
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 1], $i15
	bne     $i15, 1, be_else.36203
be_then.36203:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $ig2, 1, $i15
.count stack_load
	load    [$sp + 3], $i16
	load    [$i16 + $i15], $f16
	bne     $f16, $f0, be_else.36204
be_then.36204:
	store   $f0, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36203
be_else.36204:
	bg      $f16, $f0, ble_else.36205
ble_then.36205:
	store   $fc0, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36203
ble_else.36205:
	store   $fc4, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36203
be_else.36203:
	bne     $i15, 2, be_else.36206
be_then.36206:
	load    [$i2 + 4], $i15
	load    [$i15 + 0], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [$i2 + 4], $i15
	load    [$i15 + 1], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 4], $i15
	load    [$i15 + 2], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36206
be_else.36206:
	load    [$i2 + 5], $i15
	load    [$i15 + 2], $f16
	load    [min_caml_intersection_point + 2], $f17
	fsub    $f17, $f16, $f16
	load    [$i2 + 5], $i15
	load    [$i15 + 1], $f17
	load    [min_caml_intersection_point + 1], $f18
	fsub    $f18, $f17, $f17
	load    [$i2 + 5], $i15
	load    [$i15 + 0], $f18
	load    [min_caml_intersection_point + 0], $f9
	fsub    $f9, $f18, $f18
	load    [$i2 + 4], $i15
	load    [$i15 + 2], $f9
	fmul    $f16, $f9, $f9
	load    [$i2 + 4], $i15
	load    [$i15 + 1], $f10
	fmul    $f17, $f10, $f10
	load    [$i2 + 4], $i15
	load    [$i15 + 0], $f11
	fmul    $f18, $f11, $f11
	load    [$i2 + 3], $i15
	bne     $i15, 0, be_else.36207
be_then.36207:
	store   $f11, [min_caml_nvector + 0]
	store   $f10, [min_caml_nvector + 1]
	store   $f9, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36207
be_else.36207:
	load    [$i2 + 9], $i15
	load    [$i15 + 2], $f12
	fmul    $f17, $f12, $f12
	load    [$i2 + 9], $i15
	load    [$i15 + 1], $f13
	fmul    $f16, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f11, $f12, $f11
	store   $f11, [min_caml_nvector + 0]
	load    [$i2 + 9], $i15
	load    [$i15 + 2], $f11
	fmul    $f18, $f11, $f11
	load    [$i2 + 9], $i15
	load    [$i15 + 0], $f12
	fmul    $f16, $f12, $f16
	fadd    $f11, $f16, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f10, $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 9], $i15
	load    [$i15 + 1], $f16
	fmul    $f18, $f16, $f16
	load    [$i2 + 9], $i15
	load    [$i15 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f9, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36207:
	load    [min_caml_nvector + 2], $f16
	fmul    $f16, $f16, $f16
	load    [min_caml_nvector + 1], $f17
	fmul    $f17, $f17, $f17
	load    [min_caml_nvector + 0], $f18
	fmul    $f18, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f16, $f16
	fsqrt   $f16, $f16
	load    [$i2 + 6], $i15
	bne     $f16, $f0, be_else.36208
be_then.36208:
	mov     $fc0, $f16
.count b_cont
	b       be_cont.36208
be_else.36208:
	bne     $i15, 0, be_else.36209
be_then.36209:
	finv    $f16, $f16
.count b_cont
	b       be_cont.36209
be_else.36209:
	finv_n  $f16, $f16
be_cont.36209:
be_cont.36208:
	load    [min_caml_nvector + 0], $f17
	fmul    $f17, $f16, $f17
	store   $f17, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f17
	fmul    $f17, $f16, $f17
	store   $f17, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f17
	fmul    $f17, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36206:
be_cont.36203:
	load    [min_caml_intersection_point + 0], $fg17
	load    [min_caml_intersection_point + 1], $fg18
	load    [min_caml_intersection_point + 2], $fg19
	call    utexture.2908
	add     $ig4, $ig4, $i10
	add     $i10, $i10, $i10
	add     $i10, $ig2, $i10
.count stack_load
	load    [$sp + 4], $i11
.count storer
	add     $i14, $i11, $tmp
	store   $i10, [$tmp + 0]
	load    [$i13 + 1], $i10
	load    [min_caml_intersection_point + 0], $f10
	load    [$i10 + $i11], $i10
	store   $f10, [$i10 + 0]
	load    [min_caml_intersection_point + 1], $f10
	store   $f10, [$i10 + 1]
	load    [min_caml_intersection_point + 2], $f10
	store   $f10, [$i10 + 2]
.count stack_load
	load    [$sp + 7], $i10
	load    [$i10 + 7], $i10
	load    [$i13 + 3], $i12
	load    [$i10 + 0], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f10, $f11, $f11
.count stack_store
	store   $f11, [$sp + 8]
.count storer
	add     $i12, $i11, $tmp
	bg      $fc3, $f10, ble_else.36210
ble_then.36210:
	li      1, $i10
	store   $i10, [$tmp + 0]
	load    [$i13 + 4], $i10
	load    [$i10 + $i11], $i12
	store   $fg16, [$i12 + 0]
	store   $fg11, [$i12 + 1]
	store   $fg15, [$i12 + 2]
	load    [$i10 + $i11], $i10
.count load_float
	load    [f.32119], $f10
.count load_float
	load    [f.32120], $f10
	fmul    $f10, $f11, $f10
	load    [$i10 + 0], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i10 + 0]
	load    [$i10 + 1], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [$i10 + 1]
	load    [$i10 + 2], $f11
	fmul    $f11, $f10, $f10
	store   $f10, [$i10 + 2]
	load    [$i13 + 7], $i10
	load    [$i10 + $i11], $i10
	load    [min_caml_nvector + 0], $f10
	store   $f10, [$i10 + 0]
	load    [min_caml_nvector + 1], $f10
	store   $f10, [$i10 + 1]
	load    [min_caml_nvector + 2], $f10
	store   $f10, [$i10 + 2]
.count b_cont
	b       ble_cont.36210
ble_else.36210:
	li      0, $i10
	store   $i10, [$tmp + 0]
ble_cont.36210:
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f10
	load    [min_caml_nvector + 2], $f11
	load    [$i10 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [min_caml_nvector + 1], $f12
	load    [$i10 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [min_caml_nvector + 0], $f13
	fmul    $f10, $f13, $f14
	fadd    $f14, $f12, $f12
	fadd    $f12, $f11, $f11
.count load_float
	load    [f.32121], $f12
	fmul    $f12, $f11, $f11
	fmul    $f11, $f13, $f12
	fadd    $f10, $f12, $f10
	store   $f10, [$i10 + 0]
	load    [min_caml_nvector + 1], $f10
	fmul    $f11, $f10, $f10
	load    [$i10 + 1], $f12
	fadd    $f12, $f10, $f10
	store   $f10, [$i10 + 1]
	load    [min_caml_nvector + 2], $f10
	fmul    $f11, $f10, $f10
	load    [$i10 + 2], $f11
	fadd    $f11, $f10, $f10
	store   $f10, [$i10 + 2]
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.36211
be_then.36211:
	li      0, $i10
.count b_cont
	b       be_cont.36211
be_else.36211:
.count stack_store
	store   $i10, [$sp + 9]
	bne     $i2, 99, be_else.36212
be_then.36212:
	li      1, $i22
.count b_cont
	b       be_cont.36212
be_else.36212:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36213
be_then.36213:
	li      0, $i22
.count b_cont
	b       be_cont.36213
be_else.36213:
	bg      $fc7, $fg0, ble_else.36214
ble_then.36214:
	li      0, $i22
.count b_cont
	b       ble_cont.36214
ble_else.36214:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.36215
be_then.36215:
	li      0, $i22
.count b_cont
	b       be_cont.36215
be_else.36215:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36216
be_then.36216:
.count stack_load
	load    [$sp + 9], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36217
be_then.36217:
	li      0, $i22
.count b_cont
	b       be_cont.36216
be_else.36217:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36218
be_then.36218:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36219
be_then.36219:
	li      0, $i22
.count b_cont
	b       be_cont.36216
be_else.36219:
	li      1, $i22
.count b_cont
	b       be_cont.36216
be_else.36218:
	li      1, $i22
.count b_cont
	b       be_cont.36216
be_else.36216:
	li      1, $i22
be_cont.36216:
be_cont.36215:
ble_cont.36214:
be_cont.36213:
be_cont.36212:
	bne     $i22, 0, be_else.36220
be_then.36220:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36220
be_else.36220:
.count stack_load
	load    [$sp + 9], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.36221
be_then.36221:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36221
be_else.36221:
	load    [min_caml_and_net + $i23], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36222
be_then.36222:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.36223
be_then.36223:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36222
be_else.36223:
	load    [min_caml_and_net + $i23], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36224
be_then.36224:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36225
be_then.36225:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36222
be_else.36225:
	li      1, $i10
.count b_cont
	b       be_cont.36222
be_else.36224:
	li      1, $i10
.count b_cont
	b       be_cont.36222
be_else.36222:
	li      1, $i10
be_cont.36222:
be_cont.36221:
be_cont.36220:
be_cont.36211:
.count stack_load
	load    [$sp + 7], $i11
	load    [$i11 + 7], $i11
	load    [$i11 + 1], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f11, $f10, $f10
	bne     $i10, 0, be_cont.36226
be_then.36226:
	load    [min_caml_nvector + 0], $f11
	fmul    $f11, $fg12, $f11
	load    [min_caml_nvector + 1], $f12
	fmul    $f12, $fg13, $f12
	fadd    $f11, $f12, $f11
	load    [min_caml_nvector + 2], $f12
	fmul    $f12, $fg14, $f12
	fadd_n  $f11, $f12, $f11
.count stack_load
	load    [$sp + 8], $f12
	fmul    $f11, $f12, $f11
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f12
	fmul    $f12, $fg12, $f12
	load    [$i10 + 1], $f13
	fmul    $f13, $fg13, $f13
	fadd    $f12, $f13, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $fg14, $f13
	fadd_n  $f12, $f13, $f12
	ble     $f11, $f0, bg_cont.36227
bg_then.36227:
	fmul    $f11, $fg16, $f13
	fadd    $fg4, $f13, $fg4
	fmul    $f11, $fg11, $f13
	fadd    $fg5, $f13, $fg5
	fmul    $f11, $fg15, $f11
	fadd    $fg6, $f11, $fg6
bg_cont.36227:
	ble     $f12, $f0, bg_cont.36228
bg_then.36228:
	fmul    $f12, $f12, $f11
	fmul    $f11, $f11, $f11
	fmul    $f11, $f10, $f11
	fadd    $fg4, $f11, $fg4
	fadd    $fg5, $f11, $fg5
	fadd    $fg6, $f11, $fg6
bg_cont.36228:
be_cont.36226:
	li      min_caml_intersection_point, $i2
	load    [min_caml_intersection_point + 0], $fg8
	load    [min_caml_intersection_point + 1], $fg9
	load    [min_caml_intersection_point + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	sub     $ig3, 1, $i2
.count stack_load
	load    [$sp + 8], $f2
.count stack_load
	load    [$sp + 3], $i3
.count move_args
	mov     $f10, $f3
	call    trace_reflections.2915
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 8], $f1
	bg      $f1, $fc8, ble_else.36229
ble_then.36229:
	ret
ble_else.36229:
.count stack_load
	load    [$sp - 6], $i1
	bge     $i1, 4, bl_cont.36230
bl_then.36230:
	add     $i1, 1, $i1
	add     $i0, -1, $i2
.count stack_load
	load    [$sp - 4], $i3
.count storer
	add     $i3, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.36230:
.count stack_load
	load    [$sp - 3], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.36231
be_then.36231:
	load    [$i1 + 7], $i1
	load    [$i1 + 0], $f2
	fsub    $fc0, $f2, $f2
	fmul    $f1, $f2, $f2
.count stack_load
	load    [$sp - 6], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 9], $f1
	fadd    $f1, $fg7, $f3
.count stack_load
	load    [$sp - 7], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       trace_ray.2920
be_else.36231:
	ret
ble_else.36189:
	ret
.end trace_ray

######################################################################
# trace_diffuse_ray
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f2, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	mov     $fc14, $fg7
	load    [$ig1 + 0], $i19
	load    [$i19 + 0], $i20
	be      $i20, -1, bne_cont.36232
bne_then.36232:
	bne     $i20, 99, be_else.36233
be_then.36233:
	load    [$i19 + 1], $i20
.count move_args
	mov     $i2, $i4
	bne     $i20, -1, be_else.36234
be_then.36234:
	li      1, $i19
.count move_args
	mov     $ig1, $i3
.count move_args
	mov     $i19, $i2
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36233
be_else.36234:
	load    [min_caml_and_net + $i20], $i3
	li      0, $i15
.count move_args
	mov     $i15, $i2
	call    solve_each_element_fast.2885
	load    [$i19 + 2], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36235
be_then.36235:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36233
be_else.36235:
	load    [min_caml_and_net + $i20], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i19 + 3], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36236
be_then.36236:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36233
be_else.36236:
	load    [min_caml_and_net + $i20], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	load    [$i19 + 4], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36237
be_then.36237:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36233
be_else.36237:
	load    [min_caml_and_net + $i20], $i3
	li      0, $i2
	call    solve_each_element_fast.2885
	li      5, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36233
be_else.36233:
.count move_args
	mov     $i2, $i3
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i20
.count stack_load
	load    [$sp + 2], $i4
	li      1, $i2
	bne     $i20, 0, be_else.36238
be_then.36238:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36238
be_else.36238:
	bg      $fg7, $fg0, ble_else.36239
ble_then.36239:
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36239
ble_else.36239:
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $ig1, $i3
	call    trace_or_matrix_fast.2893
ble_cont.36239:
be_cont.36238:
be_cont.36233:
bne_cont.36232:
	bg      $fg7, $fc7, ble_else.36240
ble_then.36240:
	li      0, $i13
.count b_cont
	b       ble_cont.36240
ble_else.36240:
	bg      $fc13, $fg7, ble_else.36241
ble_then.36241:
	li      0, $i13
.count b_cont
	b       ble_cont.36241
ble_else.36241:
	li      1, $i13
ble_cont.36241:
ble_cont.36240:
	bne     $i13, 0, be_else.36242
be_then.36242:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36242:
.count stack_load
	load    [$sp + 2], $i13
	load    [$i13 + 0], $i13
	load    [min_caml_objects + $ig4], $i2
.count stack_store
	store   $i2, [$sp + 3]
	load    [$i2 + 1], $i14
	bne     $i14, 1, be_else.36243
be_then.36243:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $ig2, 1, $i14
	load    [$i13 + $i14], $f16
	bne     $f16, $f0, be_else.36244
be_then.36244:
	store   $f0, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36243
be_else.36244:
	bg      $f16, $f0, ble_else.36245
ble_then.36245:
	store   $fc0, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36243
ble_else.36245:
	store   $fc4, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36243
be_else.36243:
	bne     $i14, 2, be_else.36246
be_then.36246:
	load    [$i2 + 4], $i13
	load    [$i13 + 0], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [$i2 + 4], $i13
	load    [$i13 + 1], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 4], $i13
	load    [$i13 + 2], $f16
	fneg    $f16, $f16
	store   $f16, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36246
be_else.36246:
	load    [$i2 + 5], $i13
	load    [$i13 + 2], $f16
	load    [min_caml_intersection_point + 2], $f17
	fsub    $f17, $f16, $f16
	load    [$i2 + 5], $i13
	load    [$i13 + 1], $f17
	load    [min_caml_intersection_point + 1], $f18
	fsub    $f18, $f17, $f17
	load    [$i2 + 5], $i13
	load    [$i13 + 0], $f18
	load    [min_caml_intersection_point + 0], $f9
	fsub    $f9, $f18, $f18
	load    [$i2 + 4], $i13
	load    [$i13 + 2], $f9
	fmul    $f16, $f9, $f9
	load    [$i2 + 4], $i13
	load    [$i13 + 1], $f10
	fmul    $f17, $f10, $f10
	load    [$i2 + 4], $i13
	load    [$i13 + 0], $f11
	fmul    $f18, $f11, $f11
	load    [$i2 + 3], $i13
	bne     $i13, 0, be_else.36247
be_then.36247:
	store   $f11, [min_caml_nvector + 0]
	store   $f10, [min_caml_nvector + 1]
	store   $f9, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36247
be_else.36247:
	load    [$i2 + 9], $i13
	load    [$i13 + 2], $f12
	fmul    $f17, $f12, $f12
	load    [$i2 + 9], $i13
	load    [$i13 + 1], $f13
	fmul    $f16, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f11, $f12, $f11
	store   $f11, [min_caml_nvector + 0]
	load    [$i2 + 9], $i13
	load    [$i13 + 2], $f11
	fmul    $f18, $f11, $f11
	load    [$i2 + 9], $i13
	load    [$i13 + 0], $f12
	fmul    $f16, $f12, $f16
	fadd    $f11, $f16, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f10, $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 9], $i13
	load    [$i13 + 1], $f16
	fmul    $f18, $f16, $f16
	load    [$i2 + 9], $i13
	load    [$i13 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f9, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36247:
	load    [min_caml_nvector + 2], $f16
	fmul    $f16, $f16, $f16
	load    [min_caml_nvector + 1], $f17
	fmul    $f17, $f17, $f17
	load    [min_caml_nvector + 0], $f18
	fmul    $f18, $f18, $f18
	fadd    $f18, $f17, $f17
	fadd    $f17, $f16, $f16
	fsqrt   $f16, $f16
	load    [$i2 + 6], $i13
	bne     $f16, $f0, be_else.36248
be_then.36248:
	mov     $fc0, $f16
.count b_cont
	b       be_cont.36248
be_else.36248:
	bne     $i13, 0, be_else.36249
be_then.36249:
	finv    $f16, $f16
.count b_cont
	b       be_cont.36249
be_else.36249:
	finv_n  $f16, $f16
be_cont.36249:
be_cont.36248:
	load    [min_caml_nvector + 0], $f17
	fmul    $f17, $f16, $f17
	store   $f17, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f17
	fmul    $f17, $f16, $f17
	store   $f17, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f17
	fmul    $f17, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36246:
be_cont.36243:
	call    utexture.2908
	load    [$ig1 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.36250
be_then.36250:
	li      0, $i1
.count b_cont
	b       be_cont.36250
be_else.36250:
.count stack_store
	store   $i10, [$sp + 4]
	bne     $i2, 99, be_else.36251
be_then.36251:
	li      1, $i22
.count b_cont
	b       be_cont.36251
be_else.36251:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36252
be_then.36252:
	li      0, $i22
.count b_cont
	b       be_cont.36252
be_else.36252:
	bg      $fc7, $fg0, ble_else.36253
ble_then.36253:
	li      0, $i22
.count b_cont
	b       ble_cont.36253
ble_else.36253:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.36254
be_then.36254:
	li      0, $i22
.count b_cont
	b       be_cont.36254
be_else.36254:
	load    [min_caml_and_net + $i17], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36255
be_then.36255:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36256
be_then.36256:
	li      0, $i22
.count b_cont
	b       be_cont.36255
be_else.36256:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36257
be_then.36257:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36258
be_then.36258:
	li      0, $i22
.count b_cont
	b       be_cont.36255
be_else.36258:
	li      1, $i22
.count b_cont
	b       be_cont.36255
be_else.36257:
	li      1, $i22
.count b_cont
	b       be_cont.36255
be_else.36255:
	li      1, $i22
be_cont.36255:
be_cont.36254:
ble_cont.36253:
be_cont.36252:
be_cont.36251:
	bne     $i22, 0, be_else.36259
be_then.36259:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36259
be_else.36259:
.count stack_load
	load    [$sp + 4], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.36260
be_then.36260:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36260
be_else.36260:
	load    [min_caml_and_net + $i23], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36261
be_then.36261:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.36262
be_then.36262:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36261
be_else.36262:
	load    [min_caml_and_net + $i23], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36263
be_then.36263:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36264
be_then.36264:
	li      1, $i2
.count move_args
	mov     $ig1, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36261
be_else.36264:
	li      1, $i1
.count b_cont
	b       be_cont.36261
be_else.36263:
	li      1, $i1
.count b_cont
	b       be_cont.36261
be_else.36261:
	li      1, $i1
be_cont.36261:
be_cont.36260:
be_cont.36259:
be_cont.36250:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	bne     $i1, 0, be_else.36265
be_then.36265:
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 7], $i1
	load    [$i1 + 0], $f1
	load    [min_caml_nvector + 2], $f2
	fmul    $f2, $fg14, $f2
	load    [min_caml_nvector + 1], $f3
	fmul    $f3, $fg13, $f3
	load    [min_caml_nvector + 0], $f4
	fmul    $f4, $fg12, $f4
	fadd    $f4, $f3, $f3
	fadd_n  $f3, $f2, $f2
	bg      $f2, $f0, ble_cont.36266
ble_then.36266:
	mov     $f0, $f2
ble_cont.36266:
.count stack_load
	load    [$sp - 4], $f3
	fmul    $f3, $f2, $f2
	fmul    $f2, $f1, $f1
	fmul    $f1, $fg16, $f2
	fadd    $fg1, $f2, $fg1
	fmul    $f1, $fg11, $f2
	fadd    $fg2, $f2, $fg2
	fmul    $f1, $fg15, $f1
	fadd    $fg3, $f1, $fg3
	ret
be_else.36265:
	ret
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i4, 0, bge_else.36267
bge_then.36267:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + $i4], $i24
	load    [$i24 + 0], $i24
	load    [$i3 + 2], $f1
	load    [$i24 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i3 + 1], $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i3 + 0], $f3
	load    [$i24 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count stack_store
	store   $i4, [$sp + 3]
	bg      $f0, $f1, ble_else.36268
ble_then.36268:
	load    [$i2 + $i4], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.36269
bge_then.36269:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
.count stack_load
	load    [$sp + 1], $i27
	load    [$i27 + 2], $f1
	load    [$i26 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i26 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.36270
ble_then.36270:
	load    [$i25 + $i24], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.2929
ble_else.36270:
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.2929
bge_else.36269:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.36268:
	add     $i4, 1, $i24
	load    [$i2 + $i24], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.36271
bge_then.36271:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
.count stack_load
	load    [$sp + 1], $i27
	load    [$i27 + 2], $f1
	load    [$i26 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i27 + 1], $f2
	load    [$i26 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i27 + 0], $f3
	load    [$i26 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.36272
ble_then.36272:
	load    [$i25 + $i24], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.2929
ble_else.36272:
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.2929
bge_else.36271:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.36267:
	ret
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
	sub     $sp, 11, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	load    [$i2 + 5], $i10
	load    [$i10 + $i3], $i10
	load    [$i10 + 0], $fg1
	load    [$i10 + 1], $fg2
	load    [$i10 + 2], $fg3
	load    [$i2 + 6], $i10
	load    [$i2 + 1], $i11
	load    [$i2 + 7], $i12
	load    [$i10 + 0], $i10
.count stack_store
	store   $i10, [$sp + 3]
	load    [$i11 + $i3], $i2
.count stack_store
	store   $i2, [$sp + 4]
	load    [$i12 + $i3], $i11
.count stack_store
	store   $i11, [$sp + 5]
	be      $i10, 0, bne_cont.36273
bne_then.36273:
	load    [min_caml_dirvecs + 0], $i10
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i11 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i11 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i11 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 6]
	bg      $f0, $f10, ble_else.36274
ble_then.36274:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 5], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36274
ble_else.36274:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 5], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36274:
bne_cont.36273:
.count stack_load
	load    [$sp + 3], $i10
	be      $i10, 1, bne_cont.36275
bne_then.36275:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 5], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f10, ble_else.36276
ble_then.36276:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36276
ble_else.36276:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36276:
bne_cont.36275:
.count stack_load
	load    [$sp + 3], $i10
	be      $i10, 2, bne_cont.36277
bne_then.36277:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 5], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f10, ble_else.36278
ble_then.36278:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36278
ble_else.36278:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36278:
bne_cont.36277:
.count stack_load
	load    [$sp + 3], $i10
	be      $i10, 3, bne_cont.36279
bne_then.36279:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 5], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f10, ble_else.36280
ble_then.36280:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36280
ble_else.36280:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36280:
bne_cont.36279:
.count stack_load
	load    [$sp + 3], $i10
	be      $i10, 4, bne_cont.36281
bne_then.36281:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 5], $i25
	load    [$i25 + 2], $f1
	load    [$i24 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i25 + 1], $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i25 + 0], $f3
	load    [$i24 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f1, ble_else.36282
ble_then.36282:
	load    [$i10 + 118], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36282
ble_else.36282:
	load    [$i10 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36282:
bne_cont.36281:
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
# do_without_neighbors
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	bg      $i3, 4, ble_else.36283
ble_then.36283:
	load    [$i2 + 2], $i28
	load    [$i28 + $i3], $i29
	bl      $i29, 0, bge_else.36284
bge_then.36284:
	load    [$i2 + 3], $i29
	load    [$i29 + $i3], $i30
	bne     $i30, 0, be_else.36285
be_then.36285:
	add     $i3, 1, $i3
	bg      $i3, 4, ble_else.36286
ble_then.36286:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.36287
bge_then.36287:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.36288
be_then.36288:
	add     $i3, 1, $i3
	b       do_without_neighbors.2951
be_else.36288:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 11], $i1
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 12], $i2
	b       do_without_neighbors.2951
bge_else.36287:
	ret
ble_else.36286:
	ret
be_else.36285:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i2 + 5], $i10
	load    [$i10 + $i3], $i10
	load    [$i10 + 0], $fg1
	load    [$i10 + 1], $fg2
	load    [$i10 + 2], $fg3
	load    [$i2 + 6], $i10
	load    [$i2 + 1], $i11
	load    [$i2 + 7], $i12
	load    [$i10 + 0], $i10
.count stack_store
	store   $i10, [$sp + 4]
	load    [$i11 + $i3], $i2
.count stack_store
	store   $i2, [$sp + 5]
	load    [$i12 + $i3], $i11
.count stack_store
	store   $i11, [$sp + 6]
	be      $i10, 0, bne_cont.36289
bne_then.36289:
	load    [min_caml_dirvecs + 0], $i10
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i11 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i11 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i11 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f10, ble_else.36290
ble_then.36290:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 6], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36290
ble_else.36290:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 6], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36290:
bne_cont.36289:
.count stack_load
	load    [$sp + 4], $i10
	be      $i10, 1, bne_cont.36291
bne_then.36291:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 6], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f10, ble_else.36292
ble_then.36292:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36292
ble_else.36292:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36292:
bne_cont.36291:
.count stack_load
	load    [$sp + 4], $i10
	be      $i10, 2, bne_cont.36293
bne_then.36293:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 6], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f10, ble_else.36294
ble_then.36294:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36294
ble_else.36294:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36294:
bne_cont.36293:
.count stack_load
	load    [$sp + 4], $i10
	be      $i10, 3, bne_cont.36295
bne_then.36295:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 6], $i25
	load    [$i25 + 2], $f10
	load    [$i24 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i25 + 1], $f11
	load    [$i24 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i25 + 0], $f12
	load    [$i24 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f10, ble_else.36296
ble_then.36296:
	load    [$i10 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36296
ble_else.36296:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36296:
bne_cont.36295:
.count stack_load
	load    [$sp + 4], $i10
	be      $i10, 4, bne_cont.36297
bne_then.36297:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
.count stack_load
	load    [$sp + 6], $i25
	load    [$i25 + 2], $f1
	load    [$i24 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i25 + 1], $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i25 + 0], $f3
	load    [$i24 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
.count stack_store
	store   $i10, [$sp + 11]
	bg      $f0, $f1, ble_else.36298
ble_then.36298:
	load    [$i10 + 118], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36298
ble_else.36298:
	load    [$i10 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36298:
bne_cont.36297:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i2 + 4], $i30
.count stack_load
	load    [$sp + 3], $i31
	load    [$i30 + $i31], $i30
	load    [$i30 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i30 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i30 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i31, 1, $i3
	bg      $i3, 4, ble_else.36299
ble_then.36299:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.36300
bge_then.36300:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.36301
be_then.36301:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	add     $i3, 1, $i3
	b       do_without_neighbors.2951
be_else.36301:
.count stack_store
	store   $i3, [$sp + 12]
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 12], $i2
	b       do_without_neighbors.2951
bge_else.36300:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.36299:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.36284:
	ret
ble_else.36283:
	ret
.end do_without_neighbors

######################################################################
# try_exploit_neighbors
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i6, 4, ble_else.36302
ble_then.36302:
	load    [$i4 + $i2], $i32
	load    [$i32 + 2], $i33
	load    [$i33 + $i6], $i33
	bl      $i33, 0, bge_else.36303
bge_then.36303:
	load    [$i3 + $i2], $i34
	load    [$i34 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36304
be_then.36304:
	load    [$i5 + $i2], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36305
be_then.36305:
	sub     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36306
be_then.36306:
	add     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36307
be_then.36307:
	li      1, $i33
.count b_cont
	b       be_cont.36304
be_else.36307:
	li      0, $i33
.count b_cont
	b       be_cont.36304
be_else.36306:
	li      0, $i33
.count b_cont
	b       be_cont.36304
be_else.36305:
	li      0, $i33
.count b_cont
	b       be_cont.36304
be_else.36304:
	li      0, $i33
be_cont.36304:
	bne     $i33, 0, be_else.36308
be_then.36308:
	bg      $i6, 4, ble_else.36309
ble_then.36309:
	load    [$i4 + $i2], $i2
	load    [$i2 + 2], $i32
	load    [$i32 + $i6], $i32
	bl      $i32, 0, bge_else.36310
bge_then.36310:
	load    [$i2 + 3], $i32
	load    [$i32 + $i6], $i32
	bne     $i32, 0, be_else.36311
be_then.36311:
	add     $i6, 1, $i3
	b       do_without_neighbors.2951
be_else.36311:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i6, [$sp + 2]
.count move_args
	mov     $i6, $i3
	call    calc_diffuse_using_1point.2942
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 1], $i32
	add     $i32, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       do_without_neighbors.2951
bge_else.36310:
	ret
ble_else.36309:
	ret
be_else.36308:
	load    [$i32 + 3], $i1
	load    [$i1 + $i6], $i1
	bne     $i1, 0, be_else.36312
be_then.36312:
	add     $i6, 1, $i6
	b       try_exploit_neighbors.2967
be_else.36312:
	load    [$i34 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $fg1
	load    [$i1 + 1], $fg2
	load    [$i1 + 2], $fg3
	sub     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i1 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i1 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i1 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i1 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	add     $i6, 1, $i6
	b       try_exploit_neighbors.2967
bge_else.36303:
	ret
ble_else.36302:
	ret
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i3, 4, ble_else.36313
ble_then.36313:
	load    [$i2 + 2], $i10
	load    [$i10 + $i3], $i11
	bl      $i11, 0, bge_else.36314
bge_then.36314:
	load    [$i2 + 3], $i11
	load    [$i11 + $i3], $i12
	bne     $i12, 0, be_else.36315
be_then.36315:
	add     $i3, 1, $i12
	bg      $i12, 4, ble_else.36316
ble_then.36316:
	load    [$i10 + $i12], $i10
	bl      $i10, 0, bge_else.36317
bge_then.36317:
	load    [$i11 + $i12], $i10
	bne     $i10, 0, be_else.36318
be_then.36318:
	add     $i12, 1, $i3
	b       pretrace_diffuse_rays.2980
be_else.36318:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i12, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 1], $i10
	load    [$i2 + 7], $i11
	load    [$i2 + 6], $i13
	load    [$i10 + $i12], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i13 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i11 + $i12], $i26
	load    [$i26 + 2], $f1
	load    [$i25 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i26 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i26 + 0], $f3
	load    [$i25 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.36319
ble_then.36319:
	load    [$i24 + 118], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36319
ble_else.36319:
	load    [$i24 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36319:
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
	add     $i3, 1, $i3
	b       pretrace_diffuse_rays.2980
bge_else.36317:
	ret
ble_else.36316:
	ret
be_else.36315:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i11, [$sp + 3]
.count stack_store
	store   $i10, [$sp + 4]
.count stack_store
	store   $i2, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 5]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 1], $i10
.count stack_store
	store   $i10, [$sp + 6]
	load    [$i2 + 7], $i11
.count stack_store
	store   $i11, [$sp + 7]
	load    [$i2 + 6], $i12
	load    [$i10 + $i3], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i12 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
.count stack_load
	load    [$sp + 5], $i26
	load    [$i11 + $i26], $i26
	load    [$i26 + 2], $f10
	load    [$i25 + 2], $f11
	fmul    $f11, $f10, $f10
	load    [$i26 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f12, $f11, $f11
	load    [$i26 + 0], $f12
	load    [$i25 + 0], $f13
	fmul    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	bg      $f0, $f10, ble_else.36320
ble_then.36320:
	load    [$i24 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.36320
ble_else.36320:
	load    [$i24 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
ble_cont.36320:
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
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
	bg      $i11, 4, ble_else.36321
ble_then.36321:
.count stack_load
	load    [$sp + 4], $i12
	load    [$i12 + $i11], $i12
	bl      $i12, 0, bge_else.36322
bge_then.36322:
.count stack_load
	load    [$sp + 3], $i12
	load    [$i12 + $i11], $i12
	bne     $i12, 0, be_else.36323
be_then.36323:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i11, 1, $i3
	b       pretrace_diffuse_rays.2980
be_else.36323:
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 6], $i10
.count stack_load
	load    [$sp + 6], $i12
	load    [$i12 + $i11], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
.count stack_load
	load    [$sp + 7], $i26
	load    [$i26 + $i11], $i26
	load    [$i26 + 2], $f1
	load    [$i25 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i26 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i26 + 0], $f3
	load    [$i25 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
	bg      $f0, $f1, ble_else.36324
ble_then.36324:
	load    [$i24 + 118], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36324
ble_else.36324:
	load    [$i24 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36324:
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
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 8], $i2
	b       pretrace_diffuse_rays.2980
bge_else.36322:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.36321:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.36314:
	ret
ble_else.36313:
	ret
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i3, 0, bge_else.36325
bge_then.36325:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f4, [$sp + 1]
.count stack_store
	store   $i4, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 4]
.count stack_store
	store   $f3, [$sp + 5]
.count stack_store
	store   $f2, [$sp + 6]
	sub     $i3, 64, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f10
	fmul    $fg23, $f10, $f10
	load    [min_caml_screenx_dir + 0], $f11
	fmul    $f10, $f11, $f11
.count stack_load
	load    [$sp + 6], $f12
	fadd    $f11, $f12, $f11
	store   $f11, [min_caml_ptrace_dirvec + 0]
.count stack_load
	load    [$sp + 5], $i24
	store   $i24, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $f4, $f10
	store   $f10, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 2], $f10
	fmul    $f10, $f10, $f10
	load    [min_caml_ptrace_dirvec + 1], $f11
	fmul    $f11, $f11, $f11
	load    [min_caml_ptrace_dirvec + 0], $f12
	fmul    $f12, $f12, $f12
	fadd    $f12, $f11, $f11
	fadd    $f11, $f10, $f10
	fsqrt   $f10, $f10
	bne     $f10, $f0, be_else.36326
be_then.36326:
	mov     $fc0, $f10
.count b_cont
	b       be_cont.36326
be_else.36326:
	finv    $f10, $f10
be_cont.36326:
	load    [min_caml_ptrace_dirvec + 0], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $f11
	fmul    $f11, $f10, $f11
	store   $f11, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $f11
	fmul    $f11, $f10, $f10
	store   $f10, [min_caml_ptrace_dirvec + 2]
	mov     $f0, $fg4
	mov     $f0, $fg5
	mov     $f0, $fg6
	load    [min_caml_viewpoint + 0], $fg17
	load    [min_caml_viewpoint + 1], $fg18
	load    [min_caml_viewpoint + 2], $fg19
.count stack_load
	load    [$sp + 3], $i24
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + $i24], $i4
	li      0, $i2
	li      min_caml_ptrace_dirvec, $i3
.count move_args
	mov     $fc0, $f2
.count move_args
	mov     $f0, $f3
	call    trace_ray.2920
	load    [$i25 + $i24], $i28
	load    [$i28 + 0], $i28
	store   $fg4, [$i28 + 0]
	store   $fg5, [$i28 + 1]
	store   $fg6, [$i28 + 2]
	load    [$i25 + $i24], $i28
	load    [$i28 + 6], $i28
.count stack_load
	load    [$sp + 2], $i29
	store   $i29, [$i28 + 0]
	load    [$i25 + $i24], $i2
	load    [$i2 + 2], $i28
	load    [$i28 + 0], $i28
	bl      $i28, 0, bge_cont.36327
bge_then.36327:
	load    [$i2 + 3], $i28
	load    [$i28 + 0], $i28
	bne     $i28, 0, be_else.36328
be_then.36328:
	li      1, $i3
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.36328
be_else.36328:
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 6], $i10
	load    [$i10 + 0], $i10
	mov     $f0, $fg1
	mov     $f0, $fg2
	mov     $f0, $fg3
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i12
	load    [min_caml_dirvecs + $i10], $i10
	load    [$i11 + 0], $i11
	load    [$i12 + 0], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i11 + 2], $f1
	load    [$i24 + 2], $f2
	fmul    $f2, $f1, $f1
	load    [$i11 + 1], $f2
	load    [$i24 + 1], $f3
	fmul    $f3, $f2, $f2
	load    [$i11 + 0], $f3
	load    [$i24 + 0], $f4
	fmul    $f4, $f3, $f3
	fadd    $f3, $f2, $f2
	fadd    $f2, $f1, $f1
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f1, ble_else.36329
ble_then.36329:
	load    [$i10 + 118], $i2
	fmul    $f1, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36329
ble_else.36329:
	load    [$i10 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36329:
.count stack_load
	load    [$sp + 7], $i2
	load    [$i2 + 5], $i28
	load    [$i28 + 0], $i28
	store   $fg1, [$i28 + 0]
	store   $fg2, [$i28 + 1]
	store   $fg3, [$i28 + 2]
	li      1, $i3
	call    pretrace_diffuse_rays.2980
be_cont.36328:
bge_cont.36327:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i29, 1, $i4
.count stack_load
	load    [$sp - 9], $f4
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 6], $i2
.count stack_load
	load    [$sp - 7], $i1
	sub     $i1, 1, $i3
	bl      $i4, 5, pretrace_pixels.2983
	sub     $i4, 5, $i4
	b       pretrace_pixels.2983
bge_else.36325:
	ret
.end pretrace_pixels

######################################################################
# scan_pixel
######################################################################
.begin scan_pixel
scan_pixel.2994:
	li      128, $i32
	bg      $i32, $i2, ble_else.36331
ble_then.36331:
	ret
ble_else.36331:
.count stack_move
	sub     $sp, 11, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
.count stack_store
	store   $i4, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i5, [$sp + 4]
.count stack_store
	store   $i2, [$sp + 5]
	load    [$i5 + $i2], $i32
	load    [$i32 + 0], $i32
	load    [$i32 + 0], $fg4
	load    [$i32 + 1], $fg5
	load    [$i32 + 2], $fg6
	add     $i3, 1, $i32
.count stack_store
	store   $i32, [$sp + 6]
	li      128, $i33
	bg      $i33, $i32, ble_else.36332
ble_then.36332:
	li      0, $i32
.count b_cont
	b       ble_cont.36332
ble_else.36332:
	bg      $i3, 0, ble_else.36333
ble_then.36333:
	li      0, $i32
.count b_cont
	b       ble_cont.36333
ble_else.36333:
	li      128, $i32
	add     $i2, 1, $i33
	bg      $i32, $i33, ble_else.36334
ble_then.36334:
	li      0, $i32
.count b_cont
	b       ble_cont.36334
ble_else.36334:
	bg      $i2, 0, ble_else.36335
ble_then.36335:
	li      0, $i32
.count b_cont
	b       ble_cont.36335
ble_else.36335:
	li      1, $i32
ble_cont.36335:
ble_cont.36334:
ble_cont.36333:
ble_cont.36332:
	bne     $i32, 0, be_else.36336
be_then.36336:
	load    [$i5 + $i2], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36336
bge_then.36337:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36338
be_then.36338:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36336
be_else.36338:
.count stack_store
	store   $i2, [$sp + 7]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.2942
	li      1, $i3
.count stack_load
	load    [$sp + 7], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36336
be_else.36336:
	li      0, $i32
	load    [$i5 + $i2], $i33
	load    [$i33 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, bge_cont.36339
bge_then.36339:
	load    [$i4 + $i2], $i35
	load    [$i35 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36340
be_then.36340:
	load    [$i6 + $i2], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36341
be_then.36341:
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36342
be_then.36342:
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36343
be_then.36343:
	li      1, $i34
.count b_cont
	b       be_cont.36340
be_else.36343:
	li      0, $i34
.count b_cont
	b       be_cont.36340
be_else.36342:
	li      0, $i34
.count b_cont
	b       be_cont.36340
be_else.36341:
	li      0, $i34
.count b_cont
	b       be_cont.36340
be_else.36340:
	li      0, $i34
be_cont.36340:
	bne     $i34, 0, be_else.36344
be_then.36344:
	load    [$i5 + $i2], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36344
bge_then.36345:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36346
be_then.36346:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36344
be_else.36346:
.count stack_store
	store   $i2, [$sp + 8]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.2942
	li      1, $i3
.count stack_load
	load    [$sp + 8], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36344
be_else.36344:
	load    [$i33 + 3], $i36
	load    [$i36 + 0], $i36
.count move_args
	mov     $i4, $i3
.count move_args
	mov     $i5, $i4
	bne     $i36, 0, be_else.36347
be_then.36347:
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.36347
be_else.36347:
	load    [$i35 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $fg1
	load    [$i36 + 1], $fg2
	load    [$i36 + 2], $fg3
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i36 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i36 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i36 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i36 + 2], $f1
	fadd    $fg3, $f1, $fg3
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i36 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i36 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i6 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f1
	fadd    $fg1, $f1, $fg1
	load    [$i36 + 1], $f1
	fadd    $fg2, $f1, $fg2
	load    [$i36 + 2], $f1
	fadd    $fg3, $f1, $fg3
	load    [$i5 + $i2], $i36
	load    [$i36 + 4], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f1
	fmul    $f1, $fg1, $f1
	fadd    $fg4, $f1, $fg4
	load    [$i36 + 1], $f1
	fmul    $f1, $fg2, $f1
	fadd    $fg5, $f1, $fg5
	load    [$i36 + 2], $f1
	fmul    $f1, $fg3, $f1
	fadd    $fg6, $f1, $fg6
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.2967
be_cont.36347:
be_cont.36344:
bge_cont.36339:
be_cont.36336:
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	li      255, $i1
	bg      $i2, $i1, ble_else.36348
ble_then.36348:
	bl      $i2, 0, bge_else.36349
bge_then.36349:
	call    min_caml_write
.count b_cont
	b       ble_cont.36348
bge_else.36349:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36348
ble_else.36348:
	li      255, $i2
	call    min_caml_write
ble_cont.36348:
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	li      255, $i1
	bg      $i2, $i1, ble_else.36350
ble_then.36350:
	bl      $i2, 0, bge_else.36351
bge_then.36351:
	call    min_caml_write
.count b_cont
	b       ble_cont.36350
bge_else.36351:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36350
ble_else.36350:
	li      255, $i2
	call    min_caml_write
ble_cont.36350:
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	li      255, $i1
	bg      $i2, $i1, ble_else.36352
ble_then.36352:
	bl      $i2, 0, bge_else.36353
bge_then.36353:
	call    min_caml_write
.count b_cont
	b       ble_cont.36352
bge_else.36353:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36352
ble_else.36352:
	li      255, $i2
	call    min_caml_write
ble_cont.36352:
.count stack_load
	load    [$sp + 5], $i32
	add     $i32, 1, $i32
	li      128, $i33
	bg      $i33, $i32, ble_else.36354
ble_then.36354:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	ret
ble_else.36354:
.count stack_store
	store   $i32, [$sp + 9]
.count stack_load
	load    [$sp + 4], $i33
	load    [$i33 + $i32], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $fg4
	load    [$i34 + 1], $fg5
	load    [$i34 + 2], $fg6
	li      128, $i34
.count stack_load
	load    [$sp + 6], $i35
	bg      $i34, $i35, ble_else.36355
ble_then.36355:
	li      0, $i34
.count b_cont
	b       ble_cont.36355
ble_else.36355:
.count stack_load
	load    [$sp + 3], $i34
	bg      $i34, 0, ble_else.36356
ble_then.36356:
	li      0, $i34
.count b_cont
	b       ble_cont.36356
ble_else.36356:
	add     $i32, 1, $i34
	li      128, $i35
	bg      $i35, $i34, ble_else.36357
ble_then.36357:
	li      0, $i34
.count b_cont
	b       ble_cont.36357
ble_else.36357:
	bg      $i32, 0, ble_else.36358
ble_then.36358:
	li      0, $i34
.count b_cont
	b       ble_cont.36358
ble_else.36358:
	li      1, $i34
ble_cont.36358:
ble_cont.36357:
ble_cont.36356:
ble_cont.36355:
	bne     $i34, 0, be_else.36359
be_then.36359:
	load    [$i33 + $i32], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36359
bge_then.36360:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36361
be_then.36361:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36359
be_else.36361:
.count stack_store
	store   $i2, [$sp + 10]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.2942
	li      1, $i3
.count stack_load
	load    [$sp + 10], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36359
be_else.36359:
	li      0, $i6
.count stack_load
	load    [$sp + 2], $i3
.count stack_load
	load    [$sp + 1], $i5
.count move_args
	mov     $i32, $i2
.count move_args
	mov     $i33, $i4
	call    try_exploit_neighbors.2967
be_cont.36359:
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36362
ble_then.36362:
	bge     $i1, 0, ble_cont.36362
bl_then.36363:
	li      0, $i1
.count b_cont
	b       ble_cont.36362
ble_else.36362:
	li      255, $i1
ble_cont.36362:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36364
ble_then.36364:
	bge     $i1, 0, ble_cont.36364
bl_then.36365:
	li      0, $i1
.count b_cont
	b       ble_cont.36364
ble_else.36364:
	li      255, $i1
ble_cont.36364:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36366
ble_then.36366:
	bge     $i1, 0, ble_cont.36366
bl_then.36367:
	li      0, $i1
.count b_cont
	b       ble_cont.36366
ble_else.36366:
	li      255, $i1
ble_cont.36366:
	mov     $i1, $i2
	call    min_caml_write
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
.count stack_load
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 8], $i3
.count stack_load
	load    [$sp - 9], $i4
.count stack_load
	load    [$sp - 7], $i5
.count stack_load
	load    [$sp - 10], $i6
	b       scan_pixel.2994
.end scan_pixel

######################################################################
# scan_line
######################################################################
.begin scan_line
scan_line.3000:
	li      128, $i1
	bg      $i1, $i2, ble_else.36368
ble_then.36368:
	ret
ble_else.36368:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i6, [$sp + 1]
.count stack_store
	store   $i5, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $i2, [$sp + 4]
.count stack_store
	store   $i4, [$sp + 5]
	bge     $i2, 127, bl_cont.36369
bl_then.36369:
	add     $i2, 1, $i1
	sub     $i1, 64, $i2
	call    min_caml_float_of_int
	fmul    $fg23, $f1, $f1
	load    [min_caml_screeny_dir + 0], $f10
	fmul    $f1, $f10, $f10
	fadd    $f10, $fg22, $f2
	load    [min_caml_screeny_dir + 1], $f10
	fmul    $f1, $f10, $f10
	fadd    $f10, $fg21, $f3
	fmul    $f1, $fg24, $f1
	fadd    $f1, $fg20, $f4
	li      127, $i3
.count move_args
	mov     $i5, $i2
.count move_args
	mov     $i6, $i4
	call    pretrace_pixels.2983
bl_cont.36369:
	li      0, $i32
.count stack_load
	load    [$sp + 5], $i33
	load    [$i33 + 0], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $fg4
	load    [$i34 + 1], $fg5
	load    [$i34 + 2], $fg6
.count stack_load
	load    [$sp + 4], $i34
	add     $i34, 1, $i35
.count stack_store
	store   $i35, [$sp + 6]
	li      128, $i36
	bg      $i36, $i35, ble_else.36370
ble_then.36370:
	li      0, $i34
.count b_cont
	b       ble_cont.36370
ble_else.36370:
	bg      $i34, 0, ble_else.36371
ble_then.36371:
	li      0, $i34
.count b_cont
	b       ble_cont.36371
ble_else.36371:
	li      0, $i34
ble_cont.36371:
ble_cont.36370:
	bne     $i34, 0, be_else.36372
be_then.36372:
	load    [$i33 + 0], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36372
bge_then.36373:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36374
be_then.36374:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36372
be_else.36374:
.count stack_store
	store   $i2, [$sp + 7]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.2942
	li      1, $i3
.count stack_load
	load    [$sp + 7], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36372
be_else.36372:
	li      0, $i6
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i5
.count move_args
	mov     $i32, $i2
.count move_args
	mov     $i33, $i4
	call    try_exploit_neighbors.2967
be_cont.36372:
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36375
ble_then.36375:
	bge     $i1, 0, ble_cont.36375
bl_then.36376:
	li      0, $i1
.count b_cont
	b       ble_cont.36375
ble_else.36375:
	li      255, $i1
ble_cont.36375:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36377
ble_then.36377:
	bge     $i1, 0, ble_cont.36377
bl_then.36378:
	li      0, $i1
.count b_cont
	b       ble_cont.36377
ble_else.36377:
	li      255, $i1
ble_cont.36377:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36379
ble_then.36379:
	bge     $i1, 0, ble_cont.36379
bl_then.36380:
	li      0, $i1
.count b_cont
	b       ble_cont.36379
ble_else.36379:
	li      255, $i1
ble_cont.36379:
	mov     $i1, $i2
	call    min_caml_write
	li      1, $i2
.count stack_load
	load    [$sp + 4], $i3
.count stack_load
	load    [$sp + 3], $i4
.count stack_load
	load    [$sp + 5], $i5
.count stack_load
	load    [$sp + 2], $i6
	call    scan_pixel.2994
	li      128, $i1
.count stack_load
	load    [$sp + 6], $i10
	bg      $i1, $i10, ble_else.36381
ble_then.36381:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
ble_else.36381:
.count stack_load
	load    [$sp + 1], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.36382
bge_then.36382:
	sub     $i1, 5, $i1
bge_cont.36382:
.count stack_store
	store   $i1, [$sp + 8]
	bge     $i10, 127, bl_cont.36383
bl_then.36383:
	add     $i10, 1, $i10
	sub     $i10, 64, $i2
	call    min_caml_float_of_int
	fmul    $fg23, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg20, $f4
	load    [min_caml_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg21, $f3
	load    [min_caml_screeny_dir + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f2
	li      127, $i3
.count stack_load
	load    [$sp + 3], $i2
.count move_args
	mov     $i1, $i4
	call    pretrace_pixels.2983
bl_cont.36383:
	li      0, $i2
.count stack_load
	load    [$sp + 6], $i3
.count stack_load
	load    [$sp + 5], $i4
.count stack_load
	load    [$sp + 2], $i5
.count stack_load
	load    [$sp + 3], $i6
	call    scan_pixel.2994
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 2, $i6
.count stack_load
	load    [$sp - 4], $i5
.count stack_load
	load    [$sp - 6], $i4
.count stack_load
	load    [$sp - 7], $i3
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
	bl      $i6, 5, scan_line.3000
	sub     $i6, 5, $i6
	b       scan_line.3000
.end scan_line

######################################################################
# create_pixel
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
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	store   $i1, [$i17 + 4]
	mov     $hp, $i1
	add     $hp, 8, $hp
	store   $i17, [$i1 + 7]
	store   $i16, [$i1 + 6]
	store   $i15, [$i1 + 5]
	store   $i14, [$i1 + 4]
	store   $i13, [$i1 + 3]
	store   $i12, [$i1 + 2]
	store   $i11, [$i1 + 1]
	store   $i10, [$i1 + 0]
	ret
.end create_pixel

######################################################################
# init_line_elements
######################################################################
.begin init_line_elements
init_line_elements.3010:
	bl      $i3, 0, bge_else.36385
bge_then.36385:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i11
	mov     $i11, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i14
	mov     $i14, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	mov     $i15, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	mov     $i17, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
	store   $i19, [$i17 + 4]
	mov     $hp, $i19
	add     $hp, 8, $hp
	store   $i17, [$i19 + 7]
	store   $i16, [$i19 + 6]
	store   $i15, [$i19 + 5]
	store   $i14, [$i19 + 4]
	store   $i13, [$i19 + 3]
	store   $i12, [$i19 + 2]
	store   $i11, [$i19 + 1]
	store   $i10, [$i19 + 0]
.count stack_load
	load    [$sp + 1], $i20
.count stack_load
	load    [$sp + 2], $i21
.count storer
	add     $i21, $i20, $tmp
	store   $i19, [$tmp + 0]
	sub     $i20, 1, $i19
	bl      $i19, 0, bge_else.36386
bge_then.36386:
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i10
.count storer
	add     $i21, $i19, $tmp
	store   $i10, [$tmp + 0]
	sub     $i19, 1, $i10
	bl      $i10, 0, bge_else.36387
bge_then.36387:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i13
	store   $i13, [$i12 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i13
	store   $i13, [$i12 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i13
	store   $i13, [$i12 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i13
	store   $i13, [$i12 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	store   $i17, [$i16 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	store   $i17, [$i16 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	store   $i17, [$i16 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	store   $i17, [$i16 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
	store   $i19, [$i18 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
	store   $i19, [$i18 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
	store   $i19, [$i18 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
	store   $i19, [$i18 + 4]
	mov     $hp, $i19
	add     $hp, 8, $hp
	store   $i18, [$i19 + 7]
	store   $i17, [$i19 + 6]
	store   $i16, [$i19 + 5]
	store   $i15, [$i19 + 4]
	store   $i14, [$i19 + 3]
	store   $i13, [$i19 + 2]
	store   $i12, [$i19 + 1]
	store   $i11, [$i19 + 0]
.count storer
	add     $i21, $i10, $tmp
	store   $i19, [$tmp + 0]
	sub     $i10, 1, $i19
	bl      $i19, 0, bge_else.36388
bge_then.36388:
	call    create_pixel.3008
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count storer
	add     $i21, $i19, $tmp
	store   $i1, [$tmp + 0]
	sub     $i19, 1, $i3
.count move_args
	mov     $i21, $i2
	b       init_line_elements.3010
bge_else.36388:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36387:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36386:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36385:
	mov     $i2, $i1
	ret
.end init_line_elements

######################################################################
# calc_dirvec
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i2, 5, bge_else.36389
bge_then.36389:
	load    [min_caml_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f3, $f3, $f1
	fmul    $f2, $f2, $f4
	fadd    $f4, $f1, $f1
	fadd    $f1, $fc0, $f1
	fsqrt   $f1, $f1
	finv    $f1, $f1
	fmul    $f2, $f1, $f2
	store   $f2, [$i2 + 0]
	fmul    $f3, $f1, $f3
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
bge_else.36389:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $f5, [$sp + 2]
.count stack_store
	store   $f4, [$sp + 3]
	fmul    $f3, $f3, $f10
	fadd    $f10, $fc8, $f10
	fsqrt   $f10, $f10
	finv    $f10, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f11
.count stack_load
	load    [$sp + 3], $f12
	fmul    $f11, $f12, $f2
.count stack_store
	store   $f2, [$sp + 4]
	call    min_caml_sin
.count move_ret
	mov     $f1, $f11
.count stack_load
	load    [$sp + 4], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f13
	finv    $f13, $f13
	fmul    $f11, $f13, $f11
	fmul    $f11, $f10, $f10
	fmul    $f10, $f10, $f11
	fadd    $f11, $fc8, $f11
	fsqrt   $f11, $f11
	finv    $f11, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f13
.count stack_load
	load    [$sp + 2], $f14
	fmul    $f13, $f14, $f2
.count stack_store
	store   $f2, [$sp + 5]
	call    min_caml_sin
.count move_ret
	mov     $f1, $f13
.count stack_load
	load    [$sp + 5], $f2
	call    min_caml_cos
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $i1
	add     $i1, 1, $i2
	finv    $f1, $f1
	fmul    $f13, $f1, $f1
	fmul    $f1, $f11, $f3
.count move_args
	mov     $f10, $f2
.count move_args
	mov     $f12, $f4
.count move_args
	mov     $f14, $f5
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
# calc_dirvecs
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	bl      $i2, 0, bge_else.36390
bge_then.36390:
.count stack_move
	sub     $sp, 12, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i4, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
.count stack_store
	store   $f2, [$sp + 4]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 5]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 3], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 1], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36391
bge_then.36391:
.count stack_store
	store   $i2, [$sp + 6]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_load
	load    [$sp + 3], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36392
bge_then.36392:
	sub     $i11, 5, $i11
bge_cont.36392:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 7]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 7], $i3
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 6], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36393
bge_then.36393:
.count stack_store
	store   $i2, [$sp + 8]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_load
	load    [$sp + 7], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36394
bge_then.36394:
	sub     $i11, 5, $i11
bge_cont.36394:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 9]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 9], $i3
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 8], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36395
bge_then.36395:
.count stack_store
	store   $i2, [$sp + 10]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_load
	load    [$sp + 9], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36396
bge_then.36396:
	sub     $i11, 5, $i11
bge_cont.36396:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 11]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 11], $i3
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i3
.count move_args
	mov     $i10, $i4
.count stack_load
	load    [$sp - 8], $f2
.count stack_load
	load    [$sp - 2], $i1
	sub     $i1, 1, $i2
	bl      $i3, 5, calc_dirvecs.3028
	sub     $i3, 5, $i3
	b       calc_dirvecs.3028
bge_else.36395:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	ret
bge_else.36393:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	ret
bge_else.36391:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 12, $sp
	ret
bge_else.36390:
	ret
.end calc_dirvecs

######################################################################
# calc_dirvec_rows
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i2, 0, bge_else.36398
bge_then.36398:
.count stack_move
	sub     $sp, 18, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i4, [$sp + 2]
.count stack_store
	store   $i3, [$sp + 3]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $fc11, $f10
	fsub    $f10, $fc12, $f10
.count stack_store
	store   $f10, [$sp + 4]
	li      4, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_store
	store   $f4, [$sp + 5]
	li      0, $i2
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $f10, $f5
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
.count stack_store
	store   $f4, [$sp + 6]
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 7]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 3], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      3, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_store
	store   $f4, [$sp + 8]
.count stack_load
	load    [$sp + 3], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36399
bge_then.36399:
	sub     $i11, 5, $i11
bge_cont.36399:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 9]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
.count stack_store
	store   $f4, [$sp + 10]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 9], $i3
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      2, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f4
.count stack_load
	load    [$sp + 9], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36400
bge_then.36400:
	sub     $i11, 5, $i11
bge_cont.36400:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 11]
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	fadd    $f15, $fc8, $f4
	li      0, $i2
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 11], $i3
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 11], $i12
	add     $i12, 1, $i12
	bl      $i12, 5, bge_cont.36401
bge_then.36401:
	sub     $i12, 5, $i12
bge_cont.36401:
	mov     $i12, $i3
	li      1, $i2
.count stack_load
	load    [$sp + 4], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 1], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36402
bge_then.36402:
.count stack_store
	store   $i2, [$sp + 12]
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc11, $f15
	fsub    $f15, $fc12, $f5
.count stack_store
	store   $f5, [$sp + 13]
	li      0, $i2
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, 4, $i4
.count stack_store
	store   $i4, [$sp + 14]
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 2, $i10
	bl      $i10, 5, bge_cont.36403
bge_then.36403:
	sub     $i10, 5, $i10
bge_cont.36403:
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 15]
.count stack_load
	load    [$sp + 5], $f4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 14], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 16]
	li      0, $i2
.count stack_load
	load    [$sp + 6], $f4
.count stack_load
	load    [$sp + 13], $f5
.count stack_load
	load    [$sp + 15], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 15], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36404
bge_then.36404:
	sub     $i11, 5, $i11
bge_cont.36404:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 17]
	li      0, $i2
.count stack_load
	load    [$sp + 8], $f4
.count stack_load
	load    [$sp + 13], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
.count stack_load
	load    [$sp + 10], $f4
.count stack_load
	load    [$sp + 13], $f5
.count stack_load
	load    [$sp + 17], $i3
.count stack_load
	load    [$sp + 16], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 17], $i12
	add     $i12, 1, $i12
	bl      $i12, 5, bge_cont.36405
bge_then.36405:
	sub     $i12, 5, $i12
bge_cont.36405:
	mov     $i12, $i3
	li      2, $i2
.count stack_load
	load    [$sp + 13], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 2, $i3
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 4, $i4
.count stack_load
	load    [$sp - 6], $i1
	sub     $i1, 1, $i2
	bl      $i3, 5, calc_dirvec_rows.3033
	sub     $i3, 5, $i3
	b       calc_dirvec_rows.3033
bge_else.36402:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	ret
bge_else.36398:
	ret
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i3, 0, bge_else.36407
bge_then.36407:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i11
	add     $hp, 2, $hp
	store   $i10, [$i11 + 1]
.count stack_load
	load    [$sp + 3], $i10
	store   $i10, [$i11 + 0]
.count stack_load
	load    [$sp + 1], $i10
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i12, $i10, $tmp
	store   $i11, [$tmp + 0]
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36408
bge_then.36408:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i13
	add     $hp, 2, $hp
	store   $i11, [$i13 + 1]
.count stack_load
	load    [$sp + 4], $i11
	store   $i11, [$i13 + 0]
.count storer
	add     $i12, $i10, $tmp
	store   $i13, [$tmp + 0]
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36409
bge_then.36409:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i13
	add     $hp, 2, $hp
	store   $i11, [$i13 + 1]
.count stack_load
	load    [$sp + 5], $i11
	store   $i11, [$i13 + 0]
.count storer
	add     $i12, $i10, $tmp
	store   $i13, [$tmp + 0]
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36410
bge_then.36410:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 6]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, [$i2 + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [$i2 + 0]
.count storer
	add     $i12, $i10, $tmp
	store   $i2, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i12, $i2
	b       create_dirvec_elements.3039
bge_else.36410:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36409:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36408:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36407:
	ret
.end create_dirvec_elements

######################################################################
# create_dirvecs
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i2, 0, bge_else.36411
bge_then.36411:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 2]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i10, [$i3 + 1]
.count stack_load
	load    [$sp + 2], $i10
	store   $i10, [$i3 + 0]
	li      120, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 1], $i11
	store   $i10, [min_caml_dirvecs + $i11]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i10, [$i12 + 1]
.count stack_load
	load    [$sp + 3], $i10
	store   $i10, [$i12 + 0]
	load    [min_caml_dirvecs + $i11], $i10
	store   $i12, [$i10 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i11, [$i12 + 1]
.count stack_load
	load    [$sp + 4], $i11
	store   $i11, [$i12 + 0]
	store   $i12, [$i10 + 117]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	mov     $hp, $i15
	add     $hp, 2, $hp
	store   $i14, [$i15 + 1]
.count stack_load
	load    [$sp + 5], $i14
	store   $i14, [$i15 + 0]
	store   $i15, [$i10 + 116]
	li      115, $i3
.count move_args
	mov     $i10, $i2
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 1], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36412
bge_then.36412:
.count stack_store
	store   $i10, [$sp + 6]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 7]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i11, [$i3 + 1]
.count stack_load
	load    [$sp + 7], $i11
	store   $i11, [$i3 + 0]
	li      120, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i11, [min_caml_dirvecs + $i10]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 8]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i11, [$i12 + 1]
.count stack_load
	load    [$sp + 8], $i11
	store   $i11, [$i12 + 0]
	load    [min_caml_dirvecs + $i10], $i10
	store   $i12, [$i10 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	mov     $hp, $i15
	add     $hp, 2, $hp
	store   $i14, [$i15 + 1]
.count stack_load
	load    [$sp + 9], $i14
	store   $i14, [$i15 + 0]
	store   $i15, [$i10 + 117]
	li      116, $i3
.count move_args
	mov     $i10, $i2
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
	b       create_dirvecs.3042
bge_else.36412:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.36411:
	ret
.end create_dirvecs

######################################################################
# init_dirvec_constants
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i3, 0, bge_else.36413
bge_then.36413:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	load    [$i2 + $i3], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36414
bge_then.36414:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36415
be_then.36415:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36416
be_then.36416:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36416
be_else.36416:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36417
ble_then.36417:
	li      0, $i18
.count b_cont
	b       ble_cont.36417
ble_else.36417:
	li      1, $i18
ble_cont.36417:
	bne     $i17, 0, be_else.36418
be_then.36418:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36418
be_else.36418:
	bne     $i18, 0, be_else.36419
be_then.36419:
	li      1, $i17
.count b_cont
	b       be_cont.36419
be_else.36419:
	li      0, $i17
be_cont.36419:
be_cont.36418:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	bne     $i17, 0, be_else.36420
be_then.36420:
	fneg    $f11, $f11
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
.count b_cont
	b       be_cont.36420
be_else.36420:
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
be_cont.36420:
be_cont.36416:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36421
be_then.36421:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36421
be_else.36421:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36422
ble_then.36422:
	li      0, $i18
.count b_cont
	b       ble_cont.36422
ble_else.36422:
	li      1, $i18
ble_cont.36422:
	bne     $i17, 0, be_else.36423
be_then.36423:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36423
be_else.36423:
	bne     $i18, 0, be_else.36424
be_then.36424:
	li      1, $i17
.count b_cont
	b       be_cont.36424
be_else.36424:
	li      0, $i17
be_cont.36424:
be_cont.36423:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	bne     $i17, 0, be_else.36425
be_then.36425:
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
.count b_cont
	b       be_cont.36425
be_else.36425:
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
be_cont.36425:
be_cont.36421:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36426
be_then.36426:
	store   $f0, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36415
be_else.36426:
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	bg      $f0, $f11, ble_else.36427
ble_then.36427:
	li      0, $i17
.count b_cont
	b       ble_cont.36427
ble_else.36427:
	li      1, $i17
ble_cont.36427:
	load    [$i13 + 6], $i18
	be      $i18, 0, bne_cont.36428
bne_then.36428:
	bne     $i17, 0, be_else.36429
be_then.36429:
	li      1, $i17
.count b_cont
	b       be_cont.36429
be_else.36429:
	li      0, $i17
be_cont.36429:
bne_cont.36428:
	bne     $i17, 0, be_else.36430
be_then.36430:
	fneg    $f12, $f11
.count b_cont
	b       be_cont.36430
be_else.36430:
	mov     $f12, $f11
be_cont.36430:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36415
be_else.36415:
	bne     $i14, 2, be_else.36431
be_then.36431:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i19 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36432
ble_then.36432:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36431
ble_else.36432:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36431
be_else.36431:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 3], $i20
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i19 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i20, 0, bne_cont.36433
bne_then.36433:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i17
	load    [$i17 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36433:
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i18 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i19 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i20, 0, be_else.36434
be_then.36434:
	store   $f16, [$i16 + 1]
	store   $f14, [$i16 + 2]
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36435
be_then.36435:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36434
be_else.36435:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36434
be_else.36434:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i18 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i17 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i16 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36436
be_then.36436:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36436
be_else.36436:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36436:
be_cont.36434:
be_cont.36431:
be_cont.36415:
bge_cont.36414:
.count stack_load
	load    [$sp + 2], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36437
bge_then.36437:
.count stack_store
	store   $i10, [$sp + 3]
.count stack_load
	load    [$sp + 1], $i11
	load    [$i11 + $i10], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36438
bge_then.36438:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36439
be_then.36439:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36440
be_then.36440:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36440
be_else.36440:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36441
ble_then.36441:
	li      0, $i18
.count b_cont
	b       ble_cont.36441
ble_else.36441:
	li      1, $i18
ble_cont.36441:
	bne     $i17, 0, be_else.36442
be_then.36442:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36442
be_else.36442:
	bne     $i18, 0, be_else.36443
be_then.36443:
	li      1, $i17
.count b_cont
	b       be_cont.36443
be_else.36443:
	li      0, $i17
be_cont.36443:
be_cont.36442:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	bne     $i17, 0, be_else.36444
be_then.36444:
	fneg    $f11, $f11
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
.count b_cont
	b       be_cont.36444
be_else.36444:
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
be_cont.36444:
be_cont.36440:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36445
be_then.36445:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36445
be_else.36445:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36446
ble_then.36446:
	li      0, $i18
.count b_cont
	b       ble_cont.36446
ble_else.36446:
	li      1, $i18
ble_cont.36446:
	bne     $i17, 0, be_else.36447
be_then.36447:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36447
be_else.36447:
	bne     $i18, 0, be_else.36448
be_then.36448:
	li      1, $i17
.count b_cont
	b       be_cont.36448
be_else.36448:
	li      0, $i17
be_cont.36448:
be_cont.36447:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	bne     $i17, 0, be_else.36449
be_then.36449:
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
.count b_cont
	b       be_cont.36449
be_else.36449:
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
be_cont.36449:
be_cont.36445:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36450
be_then.36450:
	store   $f0, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36439
be_else.36450:
	load    [$i13 + 4], $i17
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36451
ble_then.36451:
	li      0, $i19
.count b_cont
	b       ble_cont.36451
ble_else.36451:
	li      1, $i19
ble_cont.36451:
	load    [$i17 + 2], $f11
	bne     $i18, 0, be_else.36452
be_then.36452:
	bne     $i19, 0, be_cont.36453
be_then.36453:
	fneg    $f11, $f11
be_cont.36453:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36439
be_else.36452:
	bne     $i19, 0, be_else.36454
be_then.36454:
	li      1, $i17
.count b_cont
	b       be_cont.36454
be_else.36454:
	li      0, $i17
be_cont.36454:
	bne     $i17, 0, be_cont.36455
be_then.36455:
	fneg    $f11, $f11
be_cont.36455:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36439
be_else.36439:
	bne     $i14, 2, be_else.36456
be_then.36456:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i19 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36457
ble_then.36457:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36456
ble_else.36457:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36456
be_else.36456:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 3], $i20
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i19 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i20, 0, bne_cont.36458
bne_then.36458:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i17
	load    [$i17 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36458:
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i18 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i19 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i20, 0, be_else.36459
be_then.36459:
	store   $f16, [$i16 + 1]
	store   $f14, [$i16 + 2]
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36460
be_then.36460:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36459
be_else.36460:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36459
be_else.36459:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i18 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i17 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i16 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36461
be_then.36461:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36461
be_else.36461:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36461:
be_cont.36459:
be_cont.36456:
be_cont.36439:
bge_cont.36438:
.count stack_load
	load    [$sp + 3], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.36462
bge_then.36462:
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + $i16], $i2
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
	sub     $i16, 1, $i10
	bl      $i10, 0, bge_else.36463
bge_then.36463:
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_else.36464
bge_then.36464:
	load    [$i17 + $i10], $i12
	load    [$i12 + 0], $i13
	load    [min_caml_objects + $i11], $i14
	load    [$i14 + 1], $i15
	load    [$i12 + 1], $i16
.count stack_store
	store   $i10, [$sp + 4]
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.36465
be_then.36465:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i13 + 0], $f11
	bne     $f11, $f0, be_else.36466
be_then.36466:
	store   $f0, [$i18 + 1]
.count b_cont
	b       be_cont.36466
be_else.36466:
	load    [$i14 + 6], $i19
	bg      $f0, $f11, ble_else.36467
ble_then.36467:
	li      0, $i20
.count b_cont
	b       ble_cont.36467
ble_else.36467:
	li      1, $i20
ble_cont.36467:
	bne     $i19, 0, be_else.36468
be_then.36468:
	mov     $i20, $i19
.count b_cont
	b       be_cont.36468
be_else.36468:
	bne     $i20, 0, be_else.36469
be_then.36469:
	li      1, $i19
.count b_cont
	b       be_cont.36469
be_else.36469:
	li      0, $i19
be_cont.36469:
be_cont.36468:
	load    [$i14 + 4], $i20
	load    [$i20 + 0], $f11
	bne     $i19, 0, be_else.36470
be_then.36470:
	fneg    $f11, $f11
	store   $f11, [$i18 + 0]
	load    [$i13 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 1]
.count b_cont
	b       be_cont.36470
be_else.36470:
	store   $f11, [$i18 + 0]
	load    [$i13 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 1]
be_cont.36470:
be_cont.36466:
	load    [$i13 + 1], $f11
	bne     $f11, $f0, be_else.36471
be_then.36471:
	store   $f0, [$i18 + 3]
.count b_cont
	b       be_cont.36471
be_else.36471:
	load    [$i14 + 6], $i19
	bg      $f0, $f11, ble_else.36472
ble_then.36472:
	li      0, $i20
.count b_cont
	b       ble_cont.36472
ble_else.36472:
	li      1, $i20
ble_cont.36472:
	bne     $i19, 0, be_else.36473
be_then.36473:
	mov     $i20, $i19
.count b_cont
	b       be_cont.36473
be_else.36473:
	bne     $i20, 0, be_else.36474
be_then.36474:
	li      1, $i19
.count b_cont
	b       be_cont.36474
be_else.36474:
	li      0, $i19
be_cont.36474:
be_cont.36473:
	load    [$i14 + 4], $i20
	load    [$i20 + 1], $f11
	bne     $i19, 0, be_else.36475
be_then.36475:
	fneg    $f11, $f11
	store   $f11, [$i18 + 2]
	load    [$i13 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 3]
.count b_cont
	b       be_cont.36475
be_else.36475:
	store   $f11, [$i18 + 2]
	load    [$i13 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 3]
be_cont.36475:
be_cont.36471:
	load    [$i13 + 2], $f11
	bne     $f11, $f0, be_else.36476
be_then.36476:
	store   $f0, [$i18 + 5]
.count b_cont
	b       be_cont.36476
be_else.36476:
	load    [$i14 + 4], $i19
	load    [$i14 + 6], $i20
	bg      $f0, $f11, ble_else.36477
ble_then.36477:
	li      0, $i21
.count b_cont
	b       ble_cont.36477
ble_else.36477:
	li      1, $i21
ble_cont.36477:
	load    [$i19 + 2], $f11
	bne     $i20, 0, be_else.36478
be_then.36478:
	bne     $i21, 0, be_else.36479
be_then.36479:
	fneg    $f11, $f11
	store   $f11, [$i18 + 4]
	load    [$i13 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 5]
.count b_cont
	b       be_cont.36478
be_else.36479:
	store   $f11, [$i18 + 4]
	load    [$i13 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 5]
.count b_cont
	b       be_cont.36478
be_else.36478:
	bne     $i21, 0, be_else.36480
be_then.36480:
	store   $f11, [$i18 + 4]
	load    [$i13 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 5]
.count b_cont
	b       be_cont.36480
be_else.36480:
	fneg    $f11, $f11
	store   $f11, [$i18 + 4]
	load    [$i13 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i18 + 5]
be_cont.36480:
be_cont.36478:
be_cont.36476:
.count storer
	add     $i16, $i11, $tmp
	store   $i18, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i12, $i2
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3044
be_else.36465:
	bne     $i15, 2, be_else.36481
be_then.36481:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i19 + 2], $f11
	load    [$i13 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i20 + 1], $f12
	load    [$i13 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i21 + 0], $f13
	load    [$i13 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count storer
	add     $i16, $i11, $tmp
	bg      $f11, $f0, ble_else.36482
ble_then.36482:
	store   $f0, [$i18 + 0]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36481
ble_else.36482:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i18 + 0]
	load    [$i14 + 4], $i19
	load    [$i19 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i18 + 1]
	load    [$i14 + 4], $i19
	load    [$i19 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i18 + 2]
	load    [$i14 + 4], $i19
	load    [$i19 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i18 + 3]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36481
be_else.36481:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i14 + 3], $i22
	load    [$i19 + 2], $f11
	load    [$i13 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i20 + 1], $f13
	load    [$i13 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i21 + 0], $f15
	load    [$i13 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i22, 0, bne_cont.36483
bne_then.36483:
	fmul    $f14, $f12, $f13
	load    [$i14 + 9], $i19
	load    [$i19 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i14 + 9], $i19
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i14 + 9], $i19
	load    [$i19 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36483:
	store   $f11, [$i18 + 0]
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i19 + 2], $f12
	load    [$i13 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i20 + 1], $f14
	load    [$i13 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i21 + 0], $f16
	load    [$i13 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i16, $i11, $tmp
	bne     $i22, 0, be_else.36484
be_then.36484:
	store   $f16, [$i18 + 1]
	store   $f14, [$i18 + 2]
	store   $f12, [$i18 + 3]
	bne     $f11, $f0, be_else.36485
be_then.36485:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36484
be_else.36485:
	finv    $f11, $f11
	store   $f11, [$i18 + 4]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36484
be_else.36484:
	load    [$i14 + 9], $i19
	load    [$i14 + 9], $i20
	load    [$i19 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i20 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i18 + 1]
	load    [$i14 + 9], $i19
	load    [$i13 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i19 + 0], $f15
	load    [$i13 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i18 + 2]
	load    [$i13 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i13 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i18 + 3]
	bne     $f11, $f0, be_else.36486
be_then.36486:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36486
be_else.36486:
	finv    $f11, $f11
	store   $f11, [$i18 + 4]
	store   $i18, [$tmp + 0]
be_cont.36486:
be_cont.36484:
be_cont.36481:
	sub     $i11, 1, $i3
.count move_args
	mov     $i12, $i2
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3044
bge_else.36464:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	sub     $i10, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3044
bge_else.36463:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36462:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36437:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36413:
	ret
.end init_dirvec_constants

######################################################################
# init_vecset_constants
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i2, 0, bge_else.36487
bge_then.36487:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [min_caml_dirvecs + $i2], $i10
.count stack_store
	store   $i10, [$sp + 2]
	load    [$i10 + 119], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36488
bge_then.36488:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36489
be_then.36489:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36490
be_then.36490:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36490
be_else.36490:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36491
ble_then.36491:
	li      0, $i18
.count b_cont
	b       ble_cont.36491
ble_else.36491:
	li      1, $i18
ble_cont.36491:
	bne     $i17, 0, be_else.36492
be_then.36492:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36492
be_else.36492:
	bne     $i18, 0, be_else.36493
be_then.36493:
	li      1, $i17
.count b_cont
	b       be_cont.36493
be_else.36493:
	li      0, $i17
be_cont.36493:
be_cont.36492:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	bne     $i17, 0, be_else.36494
be_then.36494:
	fneg    $f11, $f11
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
.count b_cont
	b       be_cont.36494
be_else.36494:
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
be_cont.36494:
be_cont.36490:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36495
be_then.36495:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36495
be_else.36495:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36496
ble_then.36496:
	li      0, $i18
.count b_cont
	b       ble_cont.36496
ble_else.36496:
	li      1, $i18
ble_cont.36496:
	bne     $i17, 0, be_else.36497
be_then.36497:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36497
be_else.36497:
	bne     $i18, 0, be_else.36498
be_then.36498:
	li      1, $i17
.count b_cont
	b       be_cont.36498
be_else.36498:
	li      0, $i17
be_cont.36498:
be_cont.36497:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	bne     $i17, 0, be_else.36499
be_then.36499:
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
.count b_cont
	b       be_cont.36499
be_else.36499:
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
be_cont.36499:
be_cont.36495:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36500
be_then.36500:
	store   $f0, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36489
be_else.36500:
	load    [$i13 + 4], $i17
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36501
ble_then.36501:
	li      0, $i19
.count b_cont
	b       ble_cont.36501
ble_else.36501:
	li      1, $i19
ble_cont.36501:
	load    [$i17 + 2], $f11
	bne     $i18, 0, be_else.36502
be_then.36502:
	bne     $i19, 0, be_cont.36503
be_then.36503:
	fneg    $f11, $f11
be_cont.36503:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36489
be_else.36502:
	bne     $i19, 0, be_else.36504
be_then.36504:
	li      1, $i17
.count b_cont
	b       be_cont.36504
be_else.36504:
	li      0, $i17
be_cont.36504:
	bne     $i17, 0, be_cont.36505
be_then.36505:
	fneg    $f11, $f11
be_cont.36505:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36489
be_else.36489:
	bne     $i14, 2, be_else.36506
be_then.36506:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i19 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36507
ble_then.36507:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36506
ble_else.36507:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36506
be_else.36506:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 3], $i20
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i19 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i20, 0, bne_cont.36508
bne_then.36508:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i17
	load    [$i17 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36508:
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i18 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i19 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i20, 0, be_else.36509
be_then.36509:
	store   $f16, [$i16 + 1]
	store   $f14, [$i16 + 2]
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36510
be_then.36510:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36509
be_else.36510:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36509
be_else.36509:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i18 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i17 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i16 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36511
be_then.36511:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36511
be_else.36511:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36511:
be_cont.36509:
be_cont.36506:
be_cont.36489:
bge_cont.36488:
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 118], $i2
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
	load    [$i16 + 117], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36512
bge_then.36512:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36513
be_then.36513:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36514
be_then.36514:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.36514
be_else.36514:
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36515
ble_then.36515:
	li      0, $i19
.count b_cont
	b       ble_cont.36515
ble_else.36515:
	li      1, $i19
ble_cont.36515:
	bne     $i18, 0, be_else.36516
be_then.36516:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36516
be_else.36516:
	bne     $i19, 0, be_else.36517
be_then.36517:
	li      1, $i18
.count b_cont
	b       be_cont.36517
be_else.36517:
	li      0, $i18
be_cont.36517:
be_cont.36516:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f11
	bne     $i18, 0, be_else.36518
be_then.36518:
	fneg    $f11, $f11
	store   $f11, [$i17 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 1]
.count b_cont
	b       be_cont.36518
be_else.36518:
	store   $f11, [$i17 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 1]
be_cont.36518:
be_cont.36514:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36519
be_then.36519:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.36519
be_else.36519:
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36520
ble_then.36520:
	li      0, $i19
.count b_cont
	b       ble_cont.36520
ble_else.36520:
	li      1, $i19
ble_cont.36520:
	bne     $i18, 0, be_else.36521
be_then.36521:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36521
be_else.36521:
	bne     $i19, 0, be_else.36522
be_then.36522:
	li      1, $i18
.count b_cont
	b       be_cont.36522
be_else.36522:
	li      0, $i18
be_cont.36522:
be_cont.36521:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f11
	bne     $i18, 0, be_else.36523
be_then.36523:
	fneg    $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 3]
.count b_cont
	b       be_cont.36523
be_else.36523:
	store   $f11, [$i17 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 3]
be_cont.36523:
be_cont.36519:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36524
be_then.36524:
	store   $f0, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36513
be_else.36524:
	load    [$i13 + 4], $i18
	load    [$i13 + 6], $i19
	bg      $f0, $f11, ble_else.36525
ble_then.36525:
	li      0, $i20
.count b_cont
	b       ble_cont.36525
ble_else.36525:
	li      1, $i20
ble_cont.36525:
	load    [$i18 + 2], $f11
	bne     $i19, 0, be_else.36526
be_then.36526:
	bne     $i20, 0, be_cont.36527
be_then.36527:
	fneg    $f11, $f11
be_cont.36527:
	store   $f11, [$i17 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36513
be_else.36526:
	bne     $i20, 0, be_else.36528
be_then.36528:
	li      1, $i18
.count b_cont
	b       be_cont.36528
be_else.36528:
	li      0, $i18
be_cont.36528:
	bne     $i18, 0, be_cont.36529
be_then.36529:
	fneg    $f11, $f11
be_cont.36529:
	store   $f11, [$i17 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36513
be_else.36513:
	bne     $i14, 2, be_else.36530
be_then.36530:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i18 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i19 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i20 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36531
ble_then.36531:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36530
ble_else.36531:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36530
be_else.36530:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 3], $i21
	load    [$i18 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i19 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i20 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i21, 0, bne_cont.36532
bne_then.36532:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36532:
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i18 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i19 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i20 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i21, 0, be_else.36533
be_then.36533:
	store   $f16, [$i17 + 1]
	store   $f14, [$i17 + 2]
	store   $f12, [$i17 + 3]
	bne     $f11, $f0, be_else.36534
be_then.36534:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36533
be_else.36534:
	finv    $f11, $f11
	store   $f11, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36533
be_else.36533:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i19 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i18 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i17 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i17 + 3]
	bne     $f11, $f0, be_else.36535
be_then.36535:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36535
be_else.36535:
	finv    $f11, $f11
	store   $f11, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36535:
be_cont.36533:
be_cont.36530:
be_cont.36513:
bge_cont.36512:
	li      116, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 1], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.36536
bge_then.36536:
.count stack_store
	store   $i16, [$sp + 3]
	load    [min_caml_dirvecs + $i16], $i16
	load    [$i16 + 119], $i2
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
	load    [$i16 + 118], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36537
bge_then.36537:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36538
be_then.36538:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36539
be_then.36539:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.36539
be_else.36539:
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36540
ble_then.36540:
	li      0, $i19
.count b_cont
	b       ble_cont.36540
ble_else.36540:
	li      1, $i19
ble_cont.36540:
	bne     $i18, 0, be_else.36541
be_then.36541:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36541
be_else.36541:
	bne     $i19, 0, be_else.36542
be_then.36542:
	li      1, $i18
.count b_cont
	b       be_cont.36542
be_else.36542:
	li      0, $i18
be_cont.36542:
be_cont.36541:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f11
	bne     $i18, 0, be_else.36543
be_then.36543:
	fneg    $f11, $f11
	store   $f11, [$i17 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 1]
.count b_cont
	b       be_cont.36543
be_else.36543:
	store   $f11, [$i17 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 1]
be_cont.36543:
be_cont.36539:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36544
be_then.36544:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.36544
be_else.36544:
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36545
ble_then.36545:
	li      0, $i19
.count b_cont
	b       ble_cont.36545
ble_else.36545:
	li      1, $i19
ble_cont.36545:
	bne     $i18, 0, be_else.36546
be_then.36546:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36546
be_else.36546:
	bne     $i19, 0, be_else.36547
be_then.36547:
	li      1, $i18
.count b_cont
	b       be_cont.36547
be_else.36547:
	li      0, $i18
be_cont.36547:
be_cont.36546:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f11
	bne     $i18, 0, be_else.36548
be_then.36548:
	fneg    $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 3]
.count b_cont
	b       be_cont.36548
be_else.36548:
	store   $f11, [$i17 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 3]
be_cont.36548:
be_cont.36544:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36549
be_then.36549:
	store   $f0, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36538
be_else.36549:
	load    [$i13 + 4], $i18
	load    [$i13 + 6], $i19
	bg      $f0, $f11, ble_else.36550
ble_then.36550:
	li      0, $i20
.count b_cont
	b       ble_cont.36550
ble_else.36550:
	li      1, $i20
ble_cont.36550:
	load    [$i18 + 2], $f11
	bne     $i19, 0, be_else.36551
be_then.36551:
	bne     $i20, 0, be_cont.36552
be_then.36552:
	fneg    $f11, $f11
be_cont.36552:
	store   $f11, [$i17 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36538
be_else.36551:
	bne     $i20, 0, be_else.36553
be_then.36553:
	li      1, $i18
.count b_cont
	b       be_cont.36553
be_else.36553:
	li      0, $i18
be_cont.36553:
	bne     $i18, 0, be_cont.36554
be_then.36554:
	fneg    $f11, $f11
be_cont.36554:
	store   $f11, [$i17 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i17 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i17, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36538
be_else.36538:
	bne     $i14, 2, be_else.36555
be_then.36555:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i18 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i19 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i20 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36556
ble_then.36556:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36555
ble_else.36556:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36555
be_else.36555:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 3], $i21
	load    [$i18 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i19 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i20 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i21, 0, bne_cont.36557
bne_then.36557:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36557:
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i18 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i19 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i20 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i21, 0, be_else.36558
be_then.36558:
	store   $f16, [$i17 + 1]
	store   $f14, [$i17 + 2]
	store   $f12, [$i17 + 3]
	bne     $f11, $f0, be_else.36559
be_then.36559:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36558
be_else.36559:
	finv    $f11, $f11
	store   $f11, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36558
be_else.36558:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i19 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i18 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i17 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i17 + 3]
	bne     $f11, $f0, be_else.36560
be_then.36560:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36560
be_else.36560:
	finv    $f11, $f11
	store   $f11, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36560:
be_cont.36558:
be_cont.36555:
be_cont.36538:
bge_cont.36537:
	li      117, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36561
bge_then.36561:
.count stack_store
	store   $i10, [$sp + 4]
	load    [min_caml_dirvecs + $i10], $i10
.count stack_store
	store   $i10, [$sp + 5]
	load    [$i10 + 119], $i10
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_cont.36562
bge_then.36562:
	load    [$i10 + 0], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36563
be_then.36563:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i12 + 0], $f11
	bne     $f11, $f0, be_else.36564
be_then.36564:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36564
be_else.36564:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36565
ble_then.36565:
	li      0, $i18
.count b_cont
	b       ble_cont.36565
ble_else.36565:
	li      1, $i18
ble_cont.36565:
	bne     $i17, 0, be_else.36566
be_then.36566:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36566
be_else.36566:
	bne     $i18, 0, be_else.36567
be_then.36567:
	li      1, $i17
.count b_cont
	b       be_cont.36567
be_else.36567:
	li      0, $i17
be_cont.36567:
be_cont.36566:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	bne     $i17, 0, be_else.36568
be_then.36568:
	fneg    $f11, $f11
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
.count b_cont
	b       be_cont.36568
be_else.36568:
	store   $f11, [$i16 + 0]
	load    [$i12 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
be_cont.36568:
be_cont.36564:
	load    [$i12 + 1], $f11
	bne     $f11, $f0, be_else.36569
be_then.36569:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36569
be_else.36569:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36570
ble_then.36570:
	li      0, $i18
.count b_cont
	b       ble_cont.36570
ble_else.36570:
	li      1, $i18
ble_cont.36570:
	bne     $i17, 0, be_else.36571
be_then.36571:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36571
be_else.36571:
	bne     $i18, 0, be_else.36572
be_then.36572:
	li      1, $i17
.count b_cont
	b       be_cont.36572
be_else.36572:
	li      0, $i17
be_cont.36572:
be_cont.36571:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	bne     $i17, 0, be_else.36573
be_then.36573:
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
.count b_cont
	b       be_cont.36573
be_else.36573:
	store   $f11, [$i16 + 2]
	load    [$i12 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
be_cont.36573:
be_cont.36569:
	load    [$i12 + 2], $f11
	bne     $f11, $f0, be_else.36574
be_then.36574:
	store   $f0, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36563
be_else.36574:
	load    [$i13 + 4], $i17
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36575
ble_then.36575:
	li      0, $i19
.count b_cont
	b       ble_cont.36575
ble_else.36575:
	li      1, $i19
ble_cont.36575:
	load    [$i17 + 2], $f11
	bne     $i18, 0, be_else.36576
be_then.36576:
	bne     $i19, 0, be_cont.36577
be_then.36577:
	fneg    $f11, $f11
be_cont.36577:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36563
be_else.36576:
	bne     $i19, 0, be_else.36578
be_then.36578:
	li      1, $i17
.count b_cont
	b       be_cont.36578
be_else.36578:
	li      0, $i17
be_cont.36578:
	bne     $i17, 0, be_cont.36579
be_then.36579:
	fneg    $f11, $f11
be_cont.36579:
	store   $f11, [$i16 + 4]
	load    [$i12 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36563
be_else.36563:
	bne     $i14, 2, be_else.36580
be_then.36580:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 1], $f12
	load    [$i12 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i19 + 0], $f13
	load    [$i12 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i15, $i11, $tmp
	bg      $f11, $f0, ble_else.36581
ble_then.36581:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36580
ble_else.36581:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36580
be_else.36580:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 3], $i20
	load    [$i17 + 2], $f11
	load    [$i12 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 1], $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i19 + 0], $f15
	load    [$i12 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i20, 0, bne_cont.36582
bne_then.36582:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i17
	load    [$i17 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36582:
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f12
	load    [$i12 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i18 + 1], $f14
	load    [$i12 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i19 + 0], $f16
	load    [$i12 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i20, 0, be_else.36583
be_then.36583:
	store   $f16, [$i16 + 1]
	store   $f14, [$i16 + 2]
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36584
be_then.36584:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36583
be_else.36584:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36583
be_else.36583:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i18 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i12 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i17 + 0], $f15
	load    [$i12 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i16 + 2]
	load    [$i12 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i12 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36585
be_then.36585:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36585
be_else.36585:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36585:
be_cont.36583:
be_cont.36580:
be_cont.36563:
bge_cont.36562:
	li      118, $i3
.count stack_load
	load    [$sp + 5], $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 4], $i23
	sub     $i23, 1, $i23
	bl      $i23, 0, bge_else.36586
bge_then.36586:
	li      119, $i3
	load    [min_caml_dirvecs + $i23], $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	sub     $i23, 1, $i2
	b       init_vecset_constants.3047
bge_else.36586:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36561:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36536:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36487:
	ret
.end init_vecset_constants

######################################################################
# setup_reflections
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i2, 0, bge_else.36587
bge_then.36587:
	load    [min_caml_objects + $i2], $i10
	load    [$i10 + 2], $i11
	bne     $i11, 2, be_else.36588
be_then.36588:
	load    [$i10 + 7], $i11
	load    [$i11 + 0], $f1
	bg      $fc0, $f1, ble_else.36589
ble_then.36589:
	ret
ble_else.36589:
	load    [$i10 + 1], $i11
	bne     $i11, 1, be_else.36590
be_then.36590:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i10 + 7], $i10
.count stack_store
	store   $i10, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 3]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count stack_load
	load    [$sp + 3], $i17
	store   $fg12, [$i17 + 0]
	fneg    $fg13, $f11
	store   $f11, [$i17 + 1]
	fneg    $fg14, $f12
	store   $f12, [$i17 + 2]
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 4]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 2], $i10
	load    [$i10 + 0], $f1
	fsub    $fc0, $f1, $f1
.count stack_store
	store   $f1, [$sp + 5]
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, $i10, $i10
	add     $i10, $i10, $i10
.count stack_store
	store   $i10, [$sp + 6]
	add     $i10, 1, $i10
	mov     $hp, $i11
	add     $hp, 3, $hp
	store   $f1, [$i11 + 2]
.count stack_load
	load    [$sp + 4], $i12
	store   $i12, [$i11 + 1]
	store   $i10, [$i11 + 0]
	store   $i11, [min_caml_reflections + $ig3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 7]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	fneg    $fg12, $f13
.count stack_load
	load    [$sp + 7], $i17
	store   $f13, [$i17 + 0]
	store   $fg13, [$i17 + 1]
	store   $f12, [$i17 + 2]
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 8]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 6], $i10
	add     $i10, 2, $i10
	mov     $hp, $i11
	add     $hp, 3, $hp
.count stack_load
	load    [$sp + 5], $i12
	store   $i12, [$i11 + 2]
.count stack_load
	load    [$sp + 8], $i12
	store   $i12, [$i11 + 1]
	store   $i10, [$i11 + 0]
	add     $ig3, 1, $i10
	store   $i11, [min_caml_reflections + $i10]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count stack_load
	load    [$sp + 9], $i17
	store   $f13, [$i17 + 0]
	store   $f11, [$i17 + 1]
	store   $fg14, [$i17 + 2]
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 10]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 8], $i1
	add     $i1, 3, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
.count stack_load
	load    [$sp - 9], $i3
	store   $i3, [$i2 + 2]
.count stack_load
	load    [$sp - 4], $i3
	store   $i3, [$i2 + 1]
	store   $i1, [$i2 + 0]
	add     $ig3, 2, $i1
	store   $i2, [min_caml_reflections + $i1]
	add     $ig3, 3, $ig3
	ret
be_else.36590:
	bne     $i11, 2, be_else.36591
be_then.36591:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 11]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i10 + 4], $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i11
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 12]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	load    [$i10 + 2], $f11
	fmul    $fg14, $f11, $f12
	load    [$i10 + 1], $f13
	fmul    $fg13, $f13, $f14
	load    [$i10 + 0], $f15
	fmul    $fg12, $f15, $f16
	fadd    $f16, $f14, $f14
	fadd    $f14, $f12, $f12
	fmul    $fc10, $f15, $f14
	fmul    $f14, $f12, $f14
	fsub    $f14, $fg12, $f14
.count stack_load
	load    [$sp + 12], $i17
	store   $f14, [$i17 + 0]
	fmul    $fc10, $f13, $f13
	fmul    $f13, $f12, $f13
	fsub    $f13, $fg13, $f13
	store   $f13, [$i17 + 1]
	fmul    $fc10, $f11, $f11
	fmul    $f11, $f12, $f11
	fsub    $f11, $fg14, $f11
	store   $f11, [$i17 + 2]
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 13]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	sub     $ig0, 1, $i3
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 13], $i1
	add     $i1, $i1, $i1
	add     $i1, $i1, $i1
	add     $i1, 1, $i1
.count stack_load
	load    [$sp - 3], $f1
	fsub    $fc0, $f1, $f1
	mov     $hp, $i2
	add     $hp, 3, $hp
	store   $f1, [$i2 + 2]
.count stack_load
	load    [$sp - 1], $i3
	store   $i3, [$i2 + 1]
	store   $i1, [$i2 + 0]
	store   $i2, [min_caml_reflections + $ig3]
	add     $ig3, 1, $ig3
	ret
be_else.36591:
	ret
be_else.36588:
	ret
bge_else.36587:
	ret
.end setup_reflections

######################################################################
# main
######################################################################
.begin main
min_caml_main:
.count stack_move
	sub     $sp, 18, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [min_caml_n_objects + 0], $ig0
	load    [min_caml_solver_dist + 0], $fg0
	load    [min_caml_diffuse_ray + 0], $fg1
	load    [min_caml_diffuse_ray + 1], $fg2
	load    [min_caml_diffuse_ray + 2], $fg3
	load    [min_caml_rgb + 0], $fg4
	load    [min_caml_rgb + 1], $fg5
	load    [min_caml_rgb + 2], $fg6
	load    [min_caml_tmin + 0], $fg7
	load    [min_caml_startp_fast + 0], $fg8
	load    [min_caml_startp_fast + 1], $fg9
	load    [min_caml_startp_fast + 2], $fg10
	load    [min_caml_texture_color + 1], $fg11
	load    [min_caml_light + 0], $fg12
	load    [min_caml_light + 1], $fg13
	load    [min_caml_light + 2], $fg14
	load    [min_caml_texture_color + 2], $fg15
	load    [min_caml_or_net + 0], $ig1
	load    [min_caml_texture_color + 0], $fg16
	load    [min_caml_intsec_rectside + 0], $ig2
	load    [min_caml_startp + 0], $fg17
	load    [min_caml_startp + 1], $fg18
	load    [min_caml_startp + 2], $fg19
	load    [min_caml_screenz_dir + 2], $fg20
	load    [min_caml_screenz_dir + 1], $fg21
	load    [min_caml_screenz_dir + 0], $fg22
	load    [min_caml_scan_pitch + 0], $fg23
	load    [min_caml_n_reflections + 0], $ig3
	load    [min_caml_intersected_object_id + 0], $ig4
	load    [min_caml_screeny_dir + 2], $fg24
	load    [f.32099 + 0], $fc0
	load    [f.32123 + 0], $fc1
	load    [f.32122 + 0], $fc2
	load    [f.32100 + 0], $fc3
	load    [f.32098 + 0], $fc4
	load    [f.32125 + 0], $fc5
	load    [f.32124 + 0], $fc6
	load    [f.32103 + 0], $fc7
	load    [f.32112 + 0], $fc8
	load    [f.32111 + 0], $fc9
	load    [f.32097 + 0], $fc10
	load    [f.32154 + 0], $fc11
	load    [f.32153 + 0], $fc12
	load    [f.32118 + 0], $fc13
	load    [f.32117 + 0], $fc14
	load    [f.32107 + 0], $fc15
	load    [f.32102 + 0], $fc16
	load    [f.32108 + 0], $fc17
	load    [f.32106 + 0], $fc18
	load    [f.32105 + 0], $fc19
	li      128, $i2
	call    min_caml_float_of_int
	finv    $f1, $f1
.count load_float
	load    [f.32216], $f10
	fmul    $f10, $f1, $fg23
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 4]
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i17, [$i3 + 7]
	store   $i16, [$i3 + 6]
	store   $i15, [$i3 + 5]
	store   $i14, [$i3 + 4]
	store   $i13, [$i3 + 3]
	store   $i12, [$i3 + 2]
	store   $i11, [$i3 + 1]
	store   $i10, [$i3 + 0]
	li      128, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
	store   $i22, [$i19 + 126]
	li      125, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count stack_store
	store   $i10, [$sp + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 4]
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i17, [$i3 + 7]
	store   $i16, [$i3 + 6]
	store   $i15, [$i3 + 5]
	store   $i14, [$i3 + 4]
	store   $i13, [$i3 + 3]
	store   $i12, [$i3 + 2]
	store   $i11, [$i3 + 1]
	store   $i10, [$i3 + 0]
	li      128, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
	store   $i22, [$i19 + 126]
	li      125, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count stack_store
	store   $i10, [$sp + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i11
	mov     $i11, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	store   $i12, [$i11 + 4]
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      0, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i14
	mov     $i14, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	store   $i15, [$i14 + 4]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i15
	mov     $i15, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i15
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	store   $i16, [$i15 + 4]
	li      0, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	mov     $i17, $i3
	li      5, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i17
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 1]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 2]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	store   $i18, [$i17 + 4]
	mov     $hp, $i3
	add     $hp, 8, $hp
	store   $i17, [$i3 + 7]
	store   $i16, [$i3 + 6]
	store   $i15, [$i3 + 5]
	store   $i14, [$i3 + 4]
	store   $i13, [$i3 + 3]
	store   $i12, [$i3 + 2]
	store   $i11, [$i3 + 1]
	store   $i10, [$i3 + 0]
	li      128, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
	store   $i22, [$i19 + 126]
	li      125, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count stack_store
	store   $i10, [$sp + 3]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [min_caml_screen + 0]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [min_caml_screen + 1]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	store   $f10, [min_caml_screen + 2]
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
.count load_float
	load    [f.32084], $f11
	fmul    $f10, $f11, $f2
.count stack_store
	store   $f2, [$sp + 4]
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 4], $f2
	call    min_caml_sin
.count move_ret
	mov     $f1, $f12
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f13
	fmul    $f13, $f11, $f2
.count stack_store
	store   $f2, [$sp + 5]
	call    min_caml_cos
.count move_ret
	mov     $f1, $f13
.count stack_load
	load    [$sp + 5], $f2
	call    min_caml_sin
.count load_float
	load    [f.32244], $f14
	fmul    $f10, $f1, $f15
	fmul    $f15, $f14, $fg22
.count load_float
	load    [f.32245], $f15
	fmul    $f12, $f15, $fg21
	fmul    $f10, $f13, $f15
	fmul    $f15, $f14, $fg20
	store   $f13, [min_caml_screenx_dir + 0]
	fneg    $f1, $f14
	store   $f14, [min_caml_screenx_dir + 2]
	fneg    $f12, $f12
	fmul    $f12, $f1, $f1
	store   $f1, [min_caml_screeny_dir + 0]
	fneg    $f10, $f1
	store   $f1, [min_caml_screeny_dir + 1]
	fmul    $f12, $f13, $fg24
	load    [min_caml_screen + 0], $f1
	fsub    $f1, $fg22, $f1
	store   $f1, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $f1
	fsub    $f1, $fg21, $f1
	store   $f1, [min_caml_viewpoint + 1]
	load    [min_caml_screen + 2], $f1
	fsub    $f1, $fg20, $f1
	store   $f1, [min_caml_viewpoint + 2]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $f11, $f2
.count stack_store
	store   $f2, [$sp + 6]
	call    min_caml_sin
.count move_ret
	mov     $f1, $f10
	fneg    $f10, $fg13
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 6], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f12
	fmul    $f10, $f11, $f2
.count stack_store
	store   $f2, [$sp + 7]
	call    min_caml_sin
.count move_ret
	mov     $f1, $f10
	fmul    $f12, $f10, $fg12
.count stack_load
	load    [$sp + 7], $f2
	call    min_caml_cos
.count move_ret
	mov     $f1, $f10
	fmul    $f12, $f10, $fg14
	call    min_caml_read_float
	store   $f1, [min_caml_beam + 0]
	li      0, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36592
be_then.36592:
.count stack_load
	load    [$sp + 8], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36592
be_else.36592:
	li      1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36593
be_then.36593:
.count stack_load
	load    [$sp + 9], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36593
be_else.36593:
	li      2, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36594
be_then.36594:
.count stack_load
	load    [$sp + 10], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36594
be_else.36594:
	li      3, $i2
.count stack_store
	store   $i2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36595
be_then.36595:
.count stack_load
	load    [$sp + 11], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36595
be_else.36595:
	li      4, $i2
	call    read_object.2721
be_cont.36595:
be_cont.36594:
be_cont.36593:
be_cont.36592:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.36596
be_then.36596:
	add     $i0, -1, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
.count b_cont
	b       be_cont.36596
be_else.36596:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.36597
be_then.36597:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
	store   $i10, [$i18 + 0]
.count b_cont
	b       be_cont.36597
be_else.36597:
.count stack_store
	store   $i10, [$sp + 12]
.count stack_store
	store   $i11, [$sp + 13]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i18
.count stack_load
	load    [$sp + 13], $i19
	store   $i19, [$i18 + 1]
.count stack_load
	load    [$sp + 12], $i19
	store   $i19, [$i18 + 0]
be_cont.36597:
be_cont.36596:
	load    [$i18 + 0], $i19
	be      $i19, -1, bne_cont.36598
bne_then.36598:
	store   $i18, [min_caml_and_net + 0]
	li      1, $i2
	call    read_and_network.2729
bne_cont.36598:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.36599
be_then.36599:
	add     $i0, -1, $i3
	li      1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36599
be_else.36599:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.36600
be_then.36600:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.36600
be_else.36600:
.count stack_store
	store   $i10, [$sp + 14]
.count stack_store
	store   $i11, [$sp + 15]
	call    read_net_item.2725
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 15], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 14], $i11
	store   $i11, [$i10 + 0]
be_cont.36600:
be_cont.36599:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	li      1, $i2
	bne     $i10, -1, be_else.36601
be_then.36601:
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.36601
be_else.36601:
.count stack_store
	store   $i3, [$sp + 16]
	call    read_or_network.2727
.count stack_load
	load    [$sp + 16], $i10
	store   $i10, [$i1 + 0]
be_cont.36601:
	mov     $i1, $ig1
	li      80, $i2
	call    min_caml_write
	li      54, $i2
	call    min_caml_write
	li      10, $i2
	call    min_caml_write
	li      49, $i2
	call    min_caml_write
	li      50, $i2
	call    min_caml_write
	li      56, $i2
	call    min_caml_write
	li      32, $i2
	call    min_caml_write
	li      49, $i2
	call    min_caml_write
	li      50, $i2
	call    min_caml_write
	li      56, $i2
	call    min_caml_write
	li      32, $i2
	call    min_caml_write
	li      50, $i2
	call    min_caml_write
	li      53, $i2
	call    min_caml_write
	li      53, $i2
	call    min_caml_write
	li      10, $i2
	call    min_caml_write
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 17]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i10, [$i3 + 1]
.count stack_load
	load    [$sp + 17], $i10
	store   $i10, [$i3 + 0]
	li      120, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	store   $i14, [min_caml_dirvecs + 4]
	li      118, $i3
	load    [min_caml_dirvecs + 4], $i2
	call    create_dirvec_elements.3039
	li      3, $i2
	call    create_dirvecs.3042
	li      9, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f16
	fmul    $f16, $fc11, $f16
	fsub    $f16, $fc12, $f2
	li      4, $i2
	li      0, $i4
	li      0, $i3
	call    calc_dirvecs.3028
	li      4, $i4
	li      2, $i3
	li      8, $i2
	call    calc_dirvec_rows.3033
	li      119, $i3
	load    [min_caml_dirvecs + 4], $i2
	call    init_dirvec_constants.3044
	li      3, $i2
	call    init_vecset_constants.3047
	li      min_caml_light_dirvec, $i10
	load    [min_caml_light_dirvec + 0], $i11
	store   $fg12, [$i11 + 0]
	store   $fg13, [$i11 + 1]
	store   $fg14, [$i11 + 2]
	sub     $ig0, 1, $i12
	bl      $i12, 0, bge_cont.36602
bge_then.36602:
	load    [min_caml_objects + $i12], $i13
	load    [$i13 + 1], $i14
	load    [min_caml_light_dirvec + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36603
be_then.36603:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i11 + 0], $f11
	bne     $f11, $f0, be_else.36604
be_then.36604:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36604
be_else.36604:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36605
ble_then.36605:
	li      0, $i18
.count b_cont
	b       ble_cont.36605
ble_else.36605:
	li      1, $i18
ble_cont.36605:
	bne     $i17, 0, be_else.36606
be_then.36606:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36606
be_else.36606:
	bne     $i18, 0, be_else.36607
be_then.36607:
	li      1, $i17
.count b_cont
	b       be_cont.36607
be_else.36607:
	li      0, $i17
be_cont.36607:
be_cont.36606:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	bne     $i17, 0, be_else.36608
be_then.36608:
	fneg    $f11, $f11
	store   $f11, [$i16 + 0]
	load    [$i11 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
.count b_cont
	b       be_cont.36608
be_else.36608:
	store   $f11, [$i16 + 0]
	load    [$i11 + 0], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 1]
be_cont.36608:
be_cont.36604:
	load    [$i11 + 1], $f11
	bne     $f11, $f0, be_else.36609
be_then.36609:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36609
be_else.36609:
	load    [$i13 + 6], $i17
	bg      $f0, $f11, ble_else.36610
ble_then.36610:
	li      0, $i18
.count b_cont
	b       ble_cont.36610
ble_else.36610:
	li      1, $i18
ble_cont.36610:
	bne     $i17, 0, be_else.36611
be_then.36611:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36611
be_else.36611:
	bne     $i18, 0, be_else.36612
be_then.36612:
	li      1, $i17
.count b_cont
	b       be_cont.36612
be_else.36612:
	li      0, $i17
be_cont.36612:
be_cont.36611:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	bne     $i17, 0, be_else.36613
be_then.36613:
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i11 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
.count b_cont
	b       be_cont.36613
be_else.36613:
	store   $f11, [$i16 + 2]
	load    [$i11 + 1], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 3]
be_cont.36613:
be_cont.36609:
	load    [$i11 + 2], $f11
	bne     $f11, $f0, be_else.36614
be_then.36614:
	store   $f0, [$i16 + 5]
.count storer
	add     $i15, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36603
be_else.36614:
	load    [$i13 + 4], $i17
	load    [$i13 + 6], $i18
	bg      $f0, $f11, ble_else.36615
ble_then.36615:
	li      0, $i19
.count b_cont
	b       ble_cont.36615
ble_else.36615:
	li      1, $i19
ble_cont.36615:
	load    [$i17 + 2], $f11
	bne     $i18, 0, be_else.36616
be_then.36616:
	bne     $i19, 0, be_cont.36617
be_then.36617:
	fneg    $f11, $f11
be_cont.36617:
	store   $f11, [$i16 + 4]
	load    [$i11 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36603
be_else.36616:
	bne     $i19, 0, be_else.36618
be_then.36618:
	li      1, $i17
.count b_cont
	b       be_cont.36618
be_else.36618:
	li      0, $i17
be_cont.36618:
	bne     $i17, 0, be_cont.36619
be_then.36619:
	fneg    $f11, $f11
be_cont.36619:
	store   $f11, [$i16 + 4]
	load    [$i11 + 2], $f11
	finv    $f11, $f11
	store   $f11, [$i16 + 5]
.count storer
	add     $i15, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36603
be_else.36603:
	bne     $i14, 2, be_else.36620
be_then.36620:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f11
	load    [$i11 + 2], $f12
	fmul    $f12, $f11, $f11
	load    [$i18 + 1], $f12
	load    [$i11 + 1], $f13
	fmul    $f13, $f12, $f12
	load    [$i19 + 0], $f13
	load    [$i11 + 0], $f14
	fmul    $f14, $f13, $f13
	fadd    $f13, $f12, $f12
	fadd    $f12, $f11, $f11
.count move_args
	mov     $i10, $i2
	sub     $i12, 1, $i3
.count storer
	add     $i15, $i12, $tmp
	bg      $f11, $f0, ble_else.36621
ble_then.36621:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36620
ble_else.36621:
	finv    $f11, $f11
	fneg    $f11, $f12
	store   $f12, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f12
	fmul_n  $f12, $f11, $f12
	store   $f12, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f12
	fmul_n  $f12, $f11, $f11
	store   $f11, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36620
be_else.36620:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 3], $i20
	load    [$i17 + 2], $f11
	load    [$i11 + 2], $f12
	fmul    $f12, $f12, $f13
	fmul    $f13, $f11, $f11
	load    [$i18 + 1], $f13
	load    [$i11 + 1], $f14
	fmul    $f14, $f14, $f15
	fmul    $f15, $f13, $f13
	load    [$i19 + 0], $f15
	load    [$i11 + 0], $f16
	fmul    $f16, $f16, $f17
	fmul    $f17, $f15, $f15
	fadd    $f15, $f13, $f13
	fadd    $f13, $f11, $f11
	be      $i20, 0, bne_cont.36622
bne_then.36622:
	fmul    $f14, $f12, $f13
	load    [$i13 + 9], $i17
	load    [$i17 + 0], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fmul    $f12, $f16, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 1], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
	fmul    $f16, $f14, $f12
	load    [$i13 + 9], $i17
	load    [$i17 + 2], $f13
	fmul    $f12, $f13, $f12
	fadd    $f11, $f12, $f11
bne_cont.36622:
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i17 + 2], $f12
	load    [$i11 + 2], $f13
	fmul_n  $f13, $f12, $f12
	load    [$i18 + 1], $f14
	load    [$i11 + 1], $f15
	fmul_n  $f15, $f14, $f14
	load    [$i19 + 0], $f16
	load    [$i11 + 0], $f17
	fmul_n  $f17, $f16, $f16
.count storer
	add     $i15, $i12, $tmp
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i20, 0, be_else.36623
be_then.36623:
	store   $f16, [$i16 + 1]
	store   $f14, [$i16 + 2]
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36624
be_then.36624:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36623
be_else.36624:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36623
be_else.36623:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 2], $f17
	fmul    $f15, $f17, $f15
	load    [$i18 + 1], $f18
	fmul    $f13, $f18, $f13
	fadd    $f13, $f15, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f16, $f13, $f13
	store   $f13, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i11 + 0], $f13
	fmul    $f13, $f17, $f13
	load    [$i17 + 0], $f15
	load    [$i11 + 2], $f16
	fmul    $f16, $f15, $f16
	fadd    $f16, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f14, $f13, $f13
	store   $f13, [$i16 + 2]
	load    [$i11 + 0], $f13
	fmul    $f13, $f18, $f13
	load    [$i11 + 1], $f14
	fmul    $f14, $f15, $f14
	fadd    $f14, $f13, $f13
	fmul    $f13, $fc3, $f13
	fsub    $f12, $f13, $f12
	store   $f12, [$i16 + 3]
	bne     $f11, $f0, be_else.36625
be_then.36625:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36625
be_else.36625:
	finv    $f11, $f11
	store   $f11, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36625:
be_cont.36623:
be_cont.36620:
be_cont.36603:
bge_cont.36602:
	sub     $ig0, 1, $i2
	call    setup_reflections.3064
	add     $i0, -64, $i2
	call    min_caml_float_of_int
	fmul    $fg23, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg20, $f4
	load    [min_caml_screeny_dir + 1], $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $fg21, $f3
	load    [min_caml_screeny_dir + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $f1, $fg22, $f2
	li      127, $i3
	li      0, $i4
.count stack_load
	load    [$sp + 2], $i2
	call    pretrace_pixels.2983
	li      2, $i6
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 2], $i4
.count stack_load
	load    [$sp + 3], $i5
	call    scan_line.3000
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      0, $tmp
	ret
.end main
