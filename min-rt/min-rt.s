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
f.32096:	.float  -2.0000000000E+02
f.32095:	.float  2.0000000000E+02
f.32067:	.float  1.2800000000E+02
f.32005:	.float  9.0000000000E-01
f.32004:	.float  2.0000000000E-01
f.31976:	.float  1.5000000000E+02
f.31975:	.float  -1.5000000000E+02
f.31974:	.float  6.6666666667E-03
f.31973:	.float  -6.6666666667E-03
f.31972:	.float  -2.0000000000E+00
f.31971:	.float  3.9062500000E-03
f.31970:	.float  2.5600000000E+02
f.31969:	.float  1.0000000000E+08
f.31968:	.float  1.0000000000E+09
f.31967:	.float  1.0000000000E+01
f.31966:	.float  2.0000000000E+01
f.31965:	.float  5.0000000000E-02
f.31964:	.float  2.5000000000E-01
f.31963:	.float  1.0000000000E-01
f.31962:	.float  3.3333333333E+00
f.31961:	.float  2.5500000000E+02
f.31960:	.float  1.5000000000E-01
f.31959:	.float  3.1830988148E-01
f.31958:	.float  3.1415927000E+00
f.31957:	.float  3.0000000000E+01
f.31956:	.float  1.5000000000E+01
f.31955:	.float  1.0000000000E-04
f.31954:	.float  -1.0000000000E-01
f.31953:	.float  1.0000000000E-02
f.31952:	.float  -2.0000000000E-01
f.31951:	.float  5.0000000000E-01
f.31950:	.float  1.0000000000E+00
f.31949:	.float  -1.0000000000E+00
f.31948:	.float  2.0000000000E+00
f.31935:	.float  1.7453293000E-02

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
	bne     $i10, -1, be_else.35554
be_then.35554:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35554:
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
	be      $i13, 0, bne_cont.35555
bne_then.35555:
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
.count load_float
	load    [f.31935], $f11
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
bne_cont.35555:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 2], $f10
	bg      $f0, $f10, ble_else.35556
ble_then.35556:
	li      0, $i19
.count b_cont
	b       ble_cont.35556
ble_else.35556:
	li      1, $i19
ble_cont.35556:
	bne     $i11, 2, be_else.35557
be_then.35557:
	li      1, $i20
.count b_cont
	b       be_cont.35557
be_else.35557:
	mov     $i19, $i20
be_cont.35557:
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
	bne     $i11, 3, be_else.35558
be_then.35558:
	load    [$i14 + 0], $f10
	bne     $f10, $f0, be_else.35559
be_then.35559:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35559
be_else.35559:
	bne     $f10, $f0, be_else.35560
be_then.35560:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
	mov     $f0, $f10
.count b_cont
	b       be_cont.35560
be_else.35560:
	bg      $f10, $f0, ble_else.35561
ble_then.35561:
	fmul    $f10, $f10, $f10
	finv_n  $f10, $f10
.count b_cont
	b       ble_cont.35561
ble_else.35561:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
ble_cont.35561:
be_cont.35560:
be_cont.35559:
	store   $f10, [$i14 + 0]
	load    [$i14 + 1], $f10
	bne     $f10, $f0, be_else.35562
be_then.35562:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35562
be_else.35562:
	bne     $f10, $f0, be_else.35563
be_then.35563:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
	mov     $f0, $f10
.count b_cont
	b       be_cont.35563
be_else.35563:
	bg      $f10, $f0, ble_else.35564
ble_then.35564:
	fmul    $f10, $f10, $f10
	finv_n  $f10, $f10
.count b_cont
	b       ble_cont.35564
ble_else.35564:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
ble_cont.35564:
be_cont.35563:
be_cont.35562:
	store   $f10, [$i14 + 1]
	load    [$i14 + 2], $f10
	bne     $f10, $f0, be_else.35565
be_then.35565:
	mov     $f0, $f10
.count b_cont
	b       be_cont.35565
be_else.35565:
	bne     $f10, $f0, be_else.35566
be_then.35566:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
	mov     $f0, $f10
.count b_cont
	b       be_cont.35566
be_else.35566:
	bg      $f10, $f0, ble_else.35567
ble_then.35567:
	fmul    $f10, $f10, $f10
	finv_n  $f10, $f10
.count b_cont
	b       ble_cont.35567
ble_else.35567:
	fmul    $f10, $f10, $f10
	finv    $f10, $f10
ble_cont.35567:
be_cont.35566:
be_cont.35565:
	store   $f10, [$i14 + 2]
	bne     $i13, 0, be_else.35568
be_then.35568:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35568:
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
	fmul    $f12, $f14, $f2
	fmul    $f2, $f2, $f3
	load    [$i14 + 0], $f4
	fmul    $f4, $f3, $f3
	fmul    $f12, $f1, $f5
	fmul    $f5, $f5, $f6
	load    [$i14 + 1], $f7
	fmul    $f7, $f6, $f6
	fadd    $f3, $f6, $f3
	fneg    $f13, $f6
	fmul    $f6, $f6, $f8
	load    [$i14 + 2], $f9
	fmul    $f9, $f8, $f8
	fadd    $f3, $f8, $f3
	store   $f3, [$i14 + 0]
	fmul    $f11, $f13, $f3
	fmul    $f3, $f14, $f8
	fmul    $f10, $f1, $f15
	fsub    $f8, $f15, $f8
	fmul    $f8, $f8, $f15
	fmul    $f4, $f15, $f15
	fmul    $f3, $f1, $f3
	fmul    $f10, $f14, $f16
	fadd    $f3, $f16, $f3
	fmul    $f3, $f3, $f16
	fmul    $f7, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f11, $f12, $f16
	fmul    $f16, $f16, $f17
	fmul    $f9, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i14 + 1]
	fmul    $f10, $f13, $f13
	fmul    $f13, $f14, $f15
	fmul    $f11, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f4, $f17, $f17
	fmul    $f13, $f1, $f1
	fmul    $f11, $f14, $f11
	fsub    $f1, $f11, $f1
	fmul    $f1, $f1, $f11
	fmul    $f7, $f11, $f11
	fadd    $f17, $f11, $f11
	fmul    $f10, $f12, $f10
	fmul    $f10, $f10, $f12
	fmul    $f9, $f12, $f12
	fadd    $f11, $f12, $f11
	store   $f11, [$i14 + 2]
	fmul    $f4, $f8, $f11
	fmul    $f11, $f15, $f11
	fmul    $f7, $f3, $f12
	fmul    $f12, $f1, $f12
	fadd    $f11, $f12, $f11
	fmul    $f9, $f16, $f12
	fmul    $f12, $f10, $f12
	fadd    $f11, $f12, $f11
	fmul    $fc10, $f11, $f11
	store   $f11, [$i18 + 0]
	fmul    $f4, $f2, $f2
	fmul    $f2, $f15, $f4
	fmul    $f7, $f5, $f5
	fmul    $f5, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f9, $f6, $f4
	fmul    $f4, $f10, $f6
	fadd    $f1, $f6, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f8, $f1
	fmul    $f5, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
be_else.35558:
	bne     $i11, 2, be_else.35569
be_then.35569:
	load    [$i14 + 0], $f10
	bne     $i19, 0, be_else.35570
be_then.35570:
	li      1, $i1
.count b_cont
	b       be_cont.35570
be_else.35570:
	li      0, $i1
be_cont.35570:
	fmul    $f10, $f10, $f11
	load    [$i14 + 1], $f12
	fmul    $f12, $f12, $f12
	fadd    $f11, $f12, $f11
	load    [$i14 + 2], $f12
	fmul    $f12, $f12, $f12
	fadd    $f11, $f12, $f11
	fsqrt   $f11, $f11
	bne     $f11, $f0, be_else.35571
be_then.35571:
	mov     $fc0, $f11
.count b_cont
	b       be_cont.35571
be_else.35571:
	bne     $i1, 0, be_else.35572
be_then.35572:
	finv    $f11, $f11
.count b_cont
	b       be_cont.35572
be_else.35572:
	finv_n  $f11, $f11
be_cont.35572:
be_cont.35571:
	fmul    $f10, $f11, $f10
	store   $f10, [$i14 + 0]
	load    [$i14 + 1], $f10
	fmul    $f10, $f11, $f10
	store   $f10, [$i14 + 1]
	load    [$i14 + 2], $f10
	fmul    $f10, $f11, $f10
	store   $f10, [$i14 + 2]
	bne     $i13, 0, be_else.35573
be_then.35573:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35573:
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
	fmul    $f12, $f14, $f2
	fmul    $f2, $f2, $f3
	load    [$i14 + 0], $f4
	fmul    $f4, $f3, $f3
	fmul    $f12, $f1, $f5
	fmul    $f5, $f5, $f6
	load    [$i14 + 1], $f7
	fmul    $f7, $f6, $f6
	fadd    $f3, $f6, $f3
	fneg    $f13, $f6
	fmul    $f6, $f6, $f8
	load    [$i14 + 2], $f9
	fmul    $f9, $f8, $f8
	fadd    $f3, $f8, $f3
	store   $f3, [$i14 + 0]
	fmul    $f11, $f13, $f3
	fmul    $f3, $f14, $f8
	fmul    $f10, $f1, $f15
	fsub    $f8, $f15, $f8
	fmul    $f8, $f8, $f15
	fmul    $f4, $f15, $f15
	fmul    $f3, $f1, $f3
	fmul    $f10, $f14, $f16
	fadd    $f3, $f16, $f3
	fmul    $f3, $f3, $f16
	fmul    $f7, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f11, $f12, $f16
	fmul    $f16, $f16, $f17
	fmul    $f9, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i14 + 1]
	fmul    $f10, $f13, $f13
	fmul    $f13, $f14, $f15
	fmul    $f11, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f4, $f17, $f17
	fmul    $f13, $f1, $f1
	fmul    $f11, $f14, $f11
	fsub    $f1, $f11, $f1
	fmul    $f1, $f1, $f11
	fmul    $f7, $f11, $f11
	fadd    $f17, $f11, $f11
	fmul    $f10, $f12, $f10
	fmul    $f10, $f10, $f12
	fmul    $f9, $f12, $f12
	fadd    $f11, $f12, $f11
	store   $f11, [$i14 + 2]
	fmul    $f4, $f8, $f11
	fmul    $f11, $f15, $f11
	fmul    $f7, $f3, $f12
	fmul    $f12, $f1, $f12
	fadd    $f11, $f12, $f11
	fmul    $f9, $f16, $f12
	fmul    $f12, $f10, $f12
	fadd    $f11, $f12, $f11
	fmul    $fc10, $f11, $f11
	store   $f11, [$i18 + 0]
	fmul    $f4, $f2, $f2
	fmul    $f2, $f15, $f4
	fmul    $f7, $f5, $f5
	fmul    $f5, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f9, $f6, $f4
	fmul    $f4, $f10, $f6
	fadd    $f1, $f6, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f8, $f1
	fmul    $f5, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 2]
	li      1, $i1
	ret
be_else.35569:
	bne     $i13, 0, be_else.35574
be_then.35574:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35574:
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
	fmul    $f12, $f14, $f2
	fmul    $f2, $f2, $f3
	load    [$i14 + 0], $f4
	fmul    $f4, $f3, $f3
	fmul    $f12, $f1, $f5
	fmul    $f5, $f5, $f6
	load    [$i14 + 1], $f7
	fmul    $f7, $f6, $f6
	fadd    $f3, $f6, $f3
	fneg    $f13, $f6
	fmul    $f6, $f6, $f8
	load    [$i14 + 2], $f9
	fmul    $f9, $f8, $f8
	fadd    $f3, $f8, $f3
	store   $f3, [$i14 + 0]
	fmul    $f11, $f13, $f3
	fmul    $f3, $f14, $f8
	fmul    $f10, $f1, $f15
	fsub    $f8, $f15, $f8
	fmul    $f8, $f8, $f15
	fmul    $f4, $f15, $f15
	fmul    $f3, $f1, $f3
	fmul    $f10, $f14, $f16
	fadd    $f3, $f16, $f3
	fmul    $f3, $f3, $f16
	fmul    $f7, $f16, $f16
	fadd    $f15, $f16, $f15
	fmul    $f11, $f12, $f16
	fmul    $f16, $f16, $f17
	fmul    $f9, $f17, $f17
	fadd    $f15, $f17, $f15
	store   $f15, [$i14 + 1]
	fmul    $f10, $f13, $f13
	fmul    $f13, $f14, $f15
	fmul    $f11, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f15, $f15, $f17
	fmul    $f4, $f17, $f17
	fmul    $f13, $f1, $f1
	fmul    $f11, $f14, $f11
	fsub    $f1, $f11, $f1
	fmul    $f1, $f1, $f11
	fmul    $f7, $f11, $f11
	fadd    $f17, $f11, $f11
	fmul    $f10, $f12, $f10
	fmul    $f10, $f10, $f12
	fmul    $f9, $f12, $f12
	fadd    $f11, $f12, $f11
	store   $f11, [$i14 + 2]
	fmul    $f4, $f8, $f11
	fmul    $f11, $f15, $f11
	fmul    $f7, $f3, $f12
	fmul    $f12, $f1, $f12
	fadd    $f11, $f12, $f11
	fmul    $f9, $f16, $f12
	fmul    $f12, $f10, $f12
	fadd    $f11, $f12, $f11
	fmul    $fc10, $f11, $f11
	store   $f11, [$i18 + 0]
	fmul    $f4, $f2, $f2
	fmul    $f2, $f15, $f4
	fmul    $f7, $f5, $f5
	fmul    $f5, $f1, $f1
	fadd    $f4, $f1, $f1
	fmul    $f9, $f6, $f4
	fmul    $f4, $f10, $f6
	fadd    $f1, $f6, $f1
	fmul    $fc10, $f1, $f1
	store   $f1, [$i18 + 1]
	fmul    $f2, $f8, $f1
	fmul    $f5, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f4, $f16, $f2
	fadd    $f1, $f2, $f1
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
	bl      $i2, 60, bge_else.35575
bge_then.35575:
	ret
bge_else.35575:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35576
be_then.35576:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	mov     $i1, $ig0
	ret
be_else.35576:
.count stack_load
	load    [$sp + 1], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35577
bge_then.35577:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35577:
.count stack_store
	store   $i2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35578
be_then.35578:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i1
	mov     $i1, $ig0
	ret
be_else.35578:
.count stack_load
	load    [$sp + 2], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35579
bge_then.35579:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35579:
.count stack_store
	store   $i2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35580
be_then.35580:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 6], $i1
	mov     $i1, $ig0
	ret
be_else.35580:
.count stack_load
	load    [$sp + 3], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35581
bge_then.35581:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35581:
.count stack_store
	store   $i2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35582
be_then.35582:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i1
	mov     $i1, $ig0
	ret
be_else.35582:
.count stack_load
	load    [$sp + 4], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35583
bge_then.35583:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35583:
.count stack_store
	store   $i2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35584
be_then.35584:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $i1
	mov     $i1, $ig0
	ret
be_else.35584:
.count stack_load
	load    [$sp + 5], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35585
bge_then.35585:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35585:
.count stack_store
	store   $i2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35586
be_then.35586:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
	mov     $i1, $ig0
	ret
be_else.35586:
.count stack_load
	load    [$sp + 6], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35587
bge_then.35587:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35587:
.count stack_store
	store   $i2, [$sp + 7]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.35588
be_then.35588:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i1
	mov     $i1, $ig0
	ret
be_else.35588:
.count stack_load
	load    [$sp + 7], $i22
	add     $i22, 1, $i2
	bl      $i2, 60, bge_else.35589
bge_then.35589:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.35589:
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2719
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	bne     $i1, 0, be_else.35590
be_then.35590:
.count stack_load
	load    [$sp - 1], $i1
	mov     $i1, $ig0
	ret
be_else.35590:
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
	bne     $i10, -1, be_else.35591
be_then.35591:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i10
	add     $i10, 1, $i2
	add     $i0, -1, $i3
	b       min_caml_create_array_int
be_else.35591:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
.count stack_load
	load    [$sp + 1], $i12
	add     $i12, 1, $i13
	bne     $i11, -1, be_else.35592
be_then.35592:
	add     $i13, 1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $i1, $i12, $tmp
	store   $i10, [$tmp + 0]
	ret
be_else.35592:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i14
	add     $i13, 1, $i15
	bne     $i14, -1, be_else.35593
be_then.35593:
	add     $i15, 1, $i2
	add     $i0, -1, $i3
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
be_else.35593:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i16
	add     $i15, 1, $i17
	add     $i17, 1, $i2
	bne     $i16, -1, be_else.35594
be_then.35594:
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
be_else.35594:
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
	bne     $i10, -1, be_else.35595
be_then.35595:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35595
be_else.35595:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35596
be_then.35596:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35596
be_else.35596:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35597
be_then.35597:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35597
be_else.35597:
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
be_cont.35597:
be_cont.35596:
be_cont.35595:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.35598
be_then.35598:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $i10
	add     $i10, 1, $i2
	b       min_caml_create_array_int
be_else.35598:
.count stack_store
	store   $i3, [$sp + 5]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35599
be_then.35599:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35599
be_else.35599:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35600
be_then.35600:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35600
be_else.35600:
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
be_cont.35600:
be_cont.35599:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i12
	add     $i12, 1, $i2
	bne     $i10, -1, be_else.35601
be_then.35601:
	call    min_caml_create_array_int
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 5], $i2
.count storer
	add     $i1, $i11, $tmp
	store   $i2, [$tmp + 0]
	ret
be_else.35601:
.count stack_store
	store   $i12, [$sp + 8]
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
	bne     $i10, -1, be_else.35602
be_then.35602:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35602
be_else.35602:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35603
be_then.35603:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35603
be_else.35603:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35604
be_then.35604:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35604
be_else.35604:
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
be_cont.35604:
be_cont.35603:
be_cont.35602:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35605
be_then.35605:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35605:
.count stack_load
	load    [$sp + 1], $i11
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35606
be_then.35606:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35606
be_else.35606:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35607
be_then.35607:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35607
be_else.35607:
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
be_cont.35607:
be_cont.35606:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35608
be_then.35608:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35608:
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 7]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35609
be_then.35609:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35609
be_else.35609:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.35610
be_then.35610:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.35610
be_else.35610:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.35611
be_then.35611:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.35611
be_else.35611:
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
be_cont.35611:
be_cont.35610:
be_cont.35609:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.35612
be_then.35612:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.35612:
.count stack_load
	load    [$sp + 7], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 11]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.35613
be_then.35613:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.35613
be_else.35613:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.35614
be_then.35614:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
	store   $i10, [$i1 + 0]
.count b_cont
	b       be_cont.35614
be_else.35614:
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
be_cont.35614:
be_cont.35613:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.35615
be_then.35615:
	ret
be_else.35615:
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
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 1], $i6
	load    [$i2 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i5 + 2], $f3
	fsub    $fg21, $f1, $f1
	fsub    $fg22, $f2, $f2
	fsub    $fg23, $f3, $f3
	load    [$i3 + 0], $f4
	bne     $i6, 1, be_else.35616
be_then.35616:
	bne     $f4, $f0, be_else.35617
be_then.35617:
	li      0, $i2
.count b_cont
	b       be_cont.35617
be_else.35617:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f5
	load    [$i3 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.35618
ble_then.35618:
	li      0, $i5
.count b_cont
	b       ble_cont.35618
ble_else.35618:
	li      1, $i5
ble_cont.35618:
	bne     $i4, 0, be_else.35619
be_then.35619:
	mov     $i5, $i4
.count b_cont
	b       be_cont.35619
be_else.35619:
	bne     $i5, 0, be_else.35620
be_then.35620:
	li      1, $i4
.count b_cont
	b       be_cont.35620
be_else.35620:
	li      0, $i4
be_cont.35620:
be_cont.35619:
	load    [$i2 + 0], $f7
	bne     $i4, 0, be_cont.35621
be_then.35621:
	fneg    $f7, $f7
be_cont.35621:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f2, $f6
	bg      $f5, $f6, ble_else.35622
ble_then.35622:
	li      0, $i2
.count b_cont
	b       ble_cont.35622
ble_else.35622:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.35623
ble_then.35623:
	li      0, $i2
.count b_cont
	b       ble_cont.35623
ble_else.35623:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.35623:
ble_cont.35622:
be_cont.35617:
	bne     $i2, 0, be_else.35624
be_then.35624:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.35625
be_then.35625:
	li      0, $i2
.count b_cont
	b       be_cont.35625
be_else.35625:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.35626
ble_then.35626:
	li      0, $i5
.count b_cont
	b       ble_cont.35626
ble_else.35626:
	li      1, $i5
ble_cont.35626:
	bne     $i4, 0, be_else.35627
be_then.35627:
	mov     $i5, $i4
.count b_cont
	b       be_cont.35627
be_else.35627:
	bne     $i5, 0, be_else.35628
be_then.35628:
	li      1, $i4
.count b_cont
	b       be_cont.35628
be_else.35628:
	li      0, $i4
be_cont.35628:
be_cont.35627:
	load    [$i2 + 1], $f7
	bne     $i4, 0, be_cont.35629
be_then.35629:
	fneg    $f7, $f7
be_cont.35629:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f3, $f6
	bg      $f5, $f6, ble_else.35630
ble_then.35630:
	li      0, $i2
.count b_cont
	b       ble_cont.35630
ble_else.35630:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.35631
ble_then.35631:
	li      0, $i2
.count b_cont
	b       ble_cont.35631
ble_else.35631:
	mov     $f4, $fg0
	li      1, $i2
ble_cont.35631:
ble_cont.35630:
be_cont.35625:
	bne     $i2, 0, be_else.35632
be_then.35632:
	load    [$i3 + 2], $f4
	bne     $f4, $f0, be_else.35633
be_then.35633:
	li      0, $i1
	ret
be_else.35633:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i1
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	bg      $f0, $f4, ble_else.35634
ble_then.35634:
	li      0, $i4
.count b_cont
	b       ble_cont.35634
ble_else.35634:
	li      1, $i4
ble_cont.35634:
	bne     $i1, 0, be_else.35635
be_then.35635:
	mov     $i4, $i1
.count b_cont
	b       be_cont.35635
be_else.35635:
	bne     $i4, 0, be_else.35636
be_then.35636:
	li      1, $i1
.count b_cont
	b       be_cont.35636
be_else.35636:
	li      0, $i1
be_cont.35636:
be_cont.35635:
	load    [$i2 + 2], $f7
	bne     $i1, 0, be_cont.35637
be_then.35637:
	fneg    $f7, $f7
be_cont.35637:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd_a  $f4, $f1, $f1
	bg      $f5, $f1, ble_else.35638
ble_then.35638:
	li      0, $i1
	ret
ble_else.35638:
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd_a  $f4, $f2, $f2
	bg      $f1, $f2, ble_else.35639
ble_then.35639:
	li      0, $i1
	ret
ble_else.35639:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.35632:
	li      2, $i1
	ret
be_else.35624:
	li      1, $i1
	ret
be_else.35616:
	bne     $i6, 2, be_else.35640
be_then.35640:
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [$i3 + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [$i3 + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	bg      $f4, $f0, ble_else.35641
ble_then.35641:
	li      0, $i1
	ret
ble_else.35641:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd_n  $f1, $f2, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35640:
	load    [$i1 + 4], $i2
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 3], $i7
	load    [$i3 + 1], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f4, $f7
	load    [$i2 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f9
	load    [$i4 + 1], $f10
	fmul    $f9, $f10, $f9
	fadd    $f7, $f9, $f7
	fmul    $f6, $f6, $f9
	load    [$i5 + 2], $f11
	fmul    $f9, $f11, $f9
	fadd    $f7, $f9, $f7
	be      $i7, 0, bne_cont.35642
bne_then.35642:
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
bne_cont.35642:
	bne     $f7, $f0, be_else.35643
be_then.35643:
	li      0, $i1
	ret
be_else.35643:
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
	bne     $i2, 0, be_else.35644
be_then.35644:
	mov     $f9, $f4
.count b_cont
	b       be_cont.35644
be_else.35644:
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
be_cont.35644:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.35645
be_then.35645:
	mov     $f6, $f1
.count b_cont
	b       be_cont.35645
be_else.35645:
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
be_cont.35645:
	bne     $i6, 3, be_cont.35646
be_then.35646:
	fsub    $f1, $fc0, $f1
be_cont.35646:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.35647
ble_then.35647:
	li      0, $i1
	ret
ble_else.35647:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.35648
be_then.35648:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35648:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
.end solver

######################################################################
# solver_fast
######################################################################
.begin solver_fast
solver_fast.2796:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 5], $i3
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [min_caml_light_dirvec + 1], $i6
	load    [$i1 + 1], $i7
	load    [min_caml_intersection_point + 0], $f1
	load    [$i3 + 0], $f2
	load    [min_caml_intersection_point + 1], $f3
	load    [$i4 + 1], $f4
	load    [min_caml_intersection_point + 2], $f5
	load    [$i5 + 2], $f6
	fsub    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsub    $f5, $f6, $f3
	load    [$i6 + $i2], $i2
	bne     $i7, 1, be_else.35649
be_then.35649:
	load    [min_caml_light_dirvec + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i2 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i2 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.35650
ble_then.35650:
	li      0, $i4
.count b_cont
	b       ble_cont.35650
ble_else.35650:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.35651
ble_then.35651:
	li      0, $i4
.count b_cont
	b       ble_cont.35651
ble_else.35651:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.35652
be_then.35652:
	li      0, $i4
.count b_cont
	b       be_cont.35652
be_else.35652:
	li      1, $i4
be_cont.35652:
ble_cont.35651:
ble_cont.35650:
	bne     $i4, 0, be_else.35653
be_then.35653:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i2 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i2 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.35654
ble_then.35654:
	li      0, $i1
.count b_cont
	b       ble_cont.35654
ble_else.35654:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.35655
ble_then.35655:
	li      0, $i1
.count b_cont
	b       ble_cont.35655
ble_else.35655:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.35656
be_then.35656:
	li      0, $i1
.count b_cont
	b       be_cont.35656
be_else.35656:
	li      1, $i1
be_cont.35656:
ble_cont.35655:
ble_cont.35654:
	bne     $i1, 0, be_else.35657
be_then.35657:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.35658
ble_then.35658:
	li      0, $i1
	ret
ble_else.35658:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.35659
ble_then.35659:
	li      0, $i1
	ret
ble_else.35659:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.35660
be_then.35660:
	li      0, $i1
	ret
be_else.35660:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.35657:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.35653:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.35649:
	load    [$i2 + 0], $f4
	bne     $i7, 2, be_else.35661
be_then.35661:
	bg      $f0, $f4, ble_else.35662
ble_then.35662:
	li      0, $i1
	ret
ble_else.35662:
	load    [$i2 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i2 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35661:
	bne     $f4, $f0, be_else.35663
be_then.35663:
	li      0, $i1
	ret
be_else.35663:
	load    [$i1 + 4], $i3
	load    [$i1 + 4], $i4
	load    [$i1 + 4], $i5
	load    [$i1 + 3], $i6
	load    [$i2 + 1], $f5
	fmul    $f5, $f1, $f5
	load    [$i2 + 2], $f6
	fmul    $f6, $f2, $f6
	fadd    $f5, $f6, $f5
	load    [$i2 + 3], $f6
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
	bne     $i6, 0, be_else.35664
be_then.35664:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35664
be_else.35664:
	fmul    $f2, $f3, $f8
	load    [$i1 + 9], $i3
	load    [$i3 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f1, $f3
	load    [$i1 + 9], $i3
	load    [$i3 + 1], $f8
	fmul    $f3, $f8, $f3
	fadd    $f7, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i1 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.35664:
	bne     $i7, 3, be_cont.35665
be_then.35665:
	fsub    $f1, $fc0, $f1
be_cont.35665:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.35666
ble_then.35666:
	li      0, $i1
	ret
ble_else.35666:
	load    [$i1 + 6], $i1
	load    [$i2 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i1, 0, be_else.35667
be_then.35667:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35667:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $fg0
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
	load    [$i3 + 1], $i5
	load    [$i1 + 1], $i6
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	load    [$i5 + $i2], $i2
	bne     $i6, 1, be_else.35668
be_then.35668:
	load    [$i3 + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i2 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i2 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd_a  $f5, $f2, $f5
	bg      $f4, $f5, ble_else.35669
ble_then.35669:
	li      0, $i4
.count b_cont
	b       ble_cont.35669
ble_else.35669:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd_a  $f7, $f3, $f7
	bg      $f5, $f7, ble_else.35670
ble_then.35670:
	li      0, $i4
.count b_cont
	b       ble_cont.35670
ble_else.35670:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.35671
be_then.35671:
	li      0, $i4
.count b_cont
	b       be_cont.35671
be_else.35671:
	li      1, $i4
be_cont.35671:
ble_cont.35670:
ble_cont.35669:
	bne     $i4, 0, be_else.35672
be_then.35672:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i2 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i2 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd_a  $f6, $f1, $f6
	bg      $f5, $f6, ble_else.35673
ble_then.35673:
	li      0, $i1
.count b_cont
	b       ble_cont.35673
ble_else.35673:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd_a  $f8, $f3, $f8
	bg      $f6, $f8, ble_else.35674
ble_then.35674:
	li      0, $i1
.count b_cont
	b       ble_cont.35674
ble_else.35674:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.35675
be_then.35675:
	li      0, $i1
.count b_cont
	b       be_cont.35675
be_else.35675:
	li      1, $i1
be_cont.35675:
ble_cont.35674:
ble_cont.35673:
	bne     $i1, 0, be_else.35676
be_then.35676:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd_a  $f6, $f1, $f1
	bg      $f5, $f1, ble_else.35677
ble_then.35677:
	li      0, $i1
	ret
ble_else.35677:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd_a  $f1, $f2, $f1
	bg      $f4, $f1, ble_else.35678
ble_then.35678:
	li      0, $i1
	ret
ble_else.35678:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.35679
be_then.35679:
	li      0, $i1
	ret
be_else.35679:
	mov     $f3, $fg0
	li      3, $i1
	ret
be_else.35676:
	mov     $f7, $fg0
	li      2, $i1
	ret
be_else.35672:
	mov     $f6, $fg0
	li      1, $i1
	ret
be_else.35668:
	bne     $i6, 2, be_else.35680
be_then.35680:
	load    [$i2 + 0], $f1
	bg      $f0, $f1, ble_else.35681
ble_then.35681:
	li      0, $i1
	ret
ble_else.35681:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35680:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.35682
be_then.35682:
	li      0, $i1
	ret
be_else.35682:
	load    [$i2 + 1], $f5
	fmul    $f5, $f1, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i2 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fmul    $f1, $f1, $f2
	load    [$i4 + 3], $f3
	fmul    $f4, $f3, $f3
	fsub    $f2, $f3, $f2
	bg      $f2, $f0, ble_else.35683
ble_then.35683:
	li      0, $i1
	ret
ble_else.35683:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	bne     $i1, 0, be_else.35684
be_then.35684:
	fsub    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
be_else.35684:
	fadd    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $fg0
	li      1, $i1
	ret
.end solver_fast2

######################################################################
# iter_setup_dirvec_constants
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	bl      $i3, 0, bge_else.35685
bge_then.35685:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 1], $i10
	load    [min_caml_objects + $i3], $i11
	load    [$i11 + 1], $i12
	load    [$i2 + 0], $i13
.count move_args
	mov     $f0, $f2
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	bne     $i12, 1, be_else.35686
be_then.35686:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.35687
be_then.35687:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.35687
be_else.35687:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.35688
ble_then.35688:
	li      0, $i15
.count b_cont
	b       ble_cont.35688
ble_else.35688:
	li      1, $i15
ble_cont.35688:
	bne     $i14, 0, be_else.35689
be_then.35689:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35689
be_else.35689:
	bne     $i15, 0, be_else.35690
be_then.35690:
	li      1, $i14
.count b_cont
	b       be_cont.35690
be_else.35690:
	li      0, $i14
be_cont.35690:
be_cont.35689:
	load    [$i11 + 4], $i15
	load    [$i15 + 0], $f1
	bne     $i14, 0, be_else.35691
be_then.35691:
	fneg    $f1, $f1
	store   $f1, [$i12 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
.count b_cont
	b       be_cont.35691
be_else.35691:
	store   $f1, [$i12 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
be_cont.35691:
be_cont.35687:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.35692
be_then.35692:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.35692
be_else.35692:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.35693
ble_then.35693:
	li      0, $i15
.count b_cont
	b       ble_cont.35693
ble_else.35693:
	li      1, $i15
ble_cont.35693:
	bne     $i14, 0, be_else.35694
be_then.35694:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35694
be_else.35694:
	bne     $i15, 0, be_else.35695
be_then.35695:
	li      1, $i14
.count b_cont
	b       be_cont.35695
be_else.35695:
	li      0, $i14
be_cont.35695:
be_cont.35694:
	load    [$i11 + 4], $i15
	load    [$i15 + 1], $f1
	bne     $i14, 0, be_else.35696
be_then.35696:
	fneg    $f1, $f1
	store   $f1, [$i12 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
.count b_cont
	b       be_cont.35696
be_else.35696:
	store   $f1, [$i12 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
be_cont.35696:
be_cont.35692:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.35697
be_then.35697:
	store   $f0, [$i12 + 5]
	mov     $i12, $i11
.count b_cont
	b       be_cont.35697
be_else.35697:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.35698
ble_then.35698:
	li      0, $i15
.count b_cont
	b       ble_cont.35698
ble_else.35698:
	li      1, $i15
ble_cont.35698:
	bne     $i14, 0, be_else.35699
be_then.35699:
	mov     $i15, $i14
.count b_cont
	b       be_cont.35699
be_else.35699:
	bne     $i15, 0, be_else.35700
be_then.35700:
	li      1, $i14
.count b_cont
	b       be_cont.35700
be_else.35700:
	li      0, $i14
be_cont.35700:
be_cont.35699:
	load    [$i11 + 4], $i11
	load    [$i11 + 2], $f1
	mov     $i12, $i11
	bne     $i14, 0, be_else.35701
be_then.35701:
	fneg    $f1, $f1
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.35701
be_else.35701:
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
be_cont.35701:
be_cont.35697:
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i10, $i12, $tmp
	store   $i11, [$tmp + 0]
	sub     $i12, 1, $i11
	bl      $i11, 0, bge_else.35702
bge_then.35702:
	load    [min_caml_objects + $i11], $i12
	load    [$i12 + 1], $i14
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.35703
be_then.35703:
	li      6, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.35704
be_then.35704:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.35704
be_else.35704:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.35705
ble_then.35705:
	li      0, $i3
.count b_cont
	b       ble_cont.35705
ble_else.35705:
	li      1, $i3
ble_cont.35705:
	bne     $i2, 0, be_else.35706
be_then.35706:
	mov     $i3, $i2
.count b_cont
	b       be_cont.35706
be_else.35706:
	bne     $i3, 0, be_else.35707
be_then.35707:
	li      1, $i2
.count b_cont
	b       be_cont.35707
be_else.35707:
	li      0, $i2
be_cont.35707:
be_cont.35706:
	load    [$i12 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.35708
be_then.35708:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.35708
be_else.35708:
	store   $f1, [$i1 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.35708:
be_cont.35704:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.35709
be_then.35709:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.35709
be_else.35709:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.35710
ble_then.35710:
	li      0, $i3
.count b_cont
	b       ble_cont.35710
ble_else.35710:
	li      1, $i3
ble_cont.35710:
	bne     $i2, 0, be_else.35711
be_then.35711:
	mov     $i3, $i2
.count b_cont
	b       be_cont.35711
be_else.35711:
	bne     $i3, 0, be_else.35712
be_then.35712:
	li      1, $i2
.count b_cont
	b       be_cont.35712
be_else.35712:
	li      0, $i2
be_cont.35712:
be_cont.35711:
	load    [$i12 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.35713
be_then.35713:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.35713
be_else.35713:
	store   $f1, [$i1 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.35713:
be_cont.35709:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.35714
be_then.35714:
	store   $f0, [$i1 + 5]
.count storer
	add     $i10, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35714:
	load    [$i12 + 6], $i2
	load    [$i12 + 4], $i3
	bg      $f0, $f1, ble_else.35715
ble_then.35715:
	li      0, $i4
.count b_cont
	b       ble_cont.35715
ble_else.35715:
	li      1, $i4
ble_cont.35715:
	bne     $i2, 0, be_else.35716
be_then.35716:
	mov     $i4, $i2
.count b_cont
	b       be_cont.35716
be_else.35716:
	bne     $i4, 0, be_else.35717
be_then.35717:
	li      1, $i2
.count b_cont
	b       be_cont.35717
be_else.35717:
	li      0, $i2
be_cont.35717:
be_cont.35716:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.35718
be_then.35718:
	fneg    $f1, $f1
be_cont.35718:
	store   $f1, [$i1 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 5]
.count storer
	add     $i10, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35703:
	bne     $i14, 2, be_else.35719
be_then.35719:
	li      4, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i12 + 4], $i2
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i13 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i13 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i13 + 2], $f2
	load    [$i4 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	sub     $i11, 1, $i3
.count storer
	add     $i10, $i11, $tmp
	bg      $f1, $f0, ble_else.35720
ble_then.35720:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
ble_else.35720:
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
be_else.35719:
	li      5, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i12 + 3], $i2
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i12 + 4], $i5
	load    [$i13 + 0], $f1
	load    [$i13 + 1], $f2
	load    [$i13 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i4 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i5 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.35721
be_then.35721:
	mov     $f4, $f1
.count b_cont
	b       be_cont.35721
be_else.35721:
	fmul    $f2, $f3, $f5
	load    [$i12 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i12 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i12 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.35721:
	store   $f1, [$i1 + 0]
	load    [$i12 + 4], $i3
	load    [$i12 + 4], $i4
	load    [$i12 + 4], $i5
	load    [$i13 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i13 + 2], $f5
	load    [$i5 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
.count storer
	add     $i10, $i11, $tmp
	bne     $i2, 0, be_else.35722
be_then.35722:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.35723
be_then.35723:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35723:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35722:
	load    [$i12 + 9], $i2
	load    [$i12 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i12 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.35724
be_then.35724:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35724:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
bge_else.35702:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.35686:
	bne     $i12, 2, be_else.35725
be_then.35725:
	li      4, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i11 + 4], $i2
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i13 + 0], $f1
	load    [$i2 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i13 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i13 + 2], $f2
	load    [$i4 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	bg      $f1, $f0, ble_else.35726
ble_then.35726:
	store   $f0, [$i1 + 0]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
ble_else.35726:
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
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35725:
	li      5, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i11 + 3], $i2
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i11 + 4], $i5
	load    [$i13 + 0], $f1
	load    [$i13 + 1], $f2
	load    [$i13 + 2], $f3
	fmul    $f1, $f1, $f4
	load    [$i3 + 0], $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    [$i4 + 1], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    [$i5 + 2], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	bne     $i2, 0, be_else.35727
be_then.35727:
	mov     $f4, $f1
.count b_cont
	b       be_cont.35727
be_else.35727:
	fmul    $f2, $f3, $f5
	load    [$i11 + 9], $i3
	load    [$i3 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i11 + 9], $i3
	load    [$i3 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i11 + 9], $i3
	load    [$i3 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.35727:
	store   $f1, [$i1 + 0]
	load    [$i11 + 4], $i3
	load    [$i11 + 4], $i4
	load    [$i11 + 4], $i5
	load    [$i13 + 0], $f2
	load    [$i3 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 1], $f3
	load    [$i4 + 1], $f4
	fmul    $f3, $f4, $f4
	load    [$i13 + 2], $f5
	load    [$i5 + 2], $f6
	fmul    $f5, $f6, $f6
	fneg    $f2, $f2
	fneg    $f4, $f4
	fneg    $f6, $f6
	bne     $i2, 0, be_else.35728
be_then.35728:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.35729
be_then.35729:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35729:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35728:
	load    [$i11 + 9], $i2
	load    [$i11 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $fc3, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i11 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $fc3, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.35730
be_then.35730:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
be_else.35730:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2826
bge_else.35685:
	ret
.end iter_setup_dirvec_constants

######################################################################
# setup_startp_constants
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	bl      $i3, 0, bge_else.35731
bge_then.35731:
	load    [min_caml_objects + $i3], $i1
	load    [$i1 + 5], $i4
	load    [$i1 + 10], $i5
	load    [$i2 + 0], $f1
	load    [$i4 + 0], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 0]
	load    [$i1 + 5], $i4
	load    [$i2 + 1], $f1
	load    [$i4 + 1], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 1]
	load    [$i1 + 5], $i4
	load    [$i2 + 2], $f1
	load    [$i4 + 2], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 2]
	load    [$i1 + 1], $i4
	bne     $i4, 2, be_else.35732
be_then.35732:
	load    [$i1 + 4], $i1
	load    [$i5 + 0], $f1
	load    [$i1 + 0], $f2
	fmul    $f2, $f1, $f1
	load    [$i5 + 1], $f2
	load    [$i1 + 1], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i5 + 2], $f2
	load    [$i1 + 2], $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [$i5 + 3]
	sub     $i3, 1, $i3
	b       setup_startp_constants.2831
be_else.35732:
	bg      $i4, 2, ble_else.35733
ble_then.35733:
	sub     $i3, 1, $i3
	b       setup_startp_constants.2831
ble_else.35733:
	load    [$i1 + 4], $i6
	load    [$i1 + 4], $i7
	load    [$i1 + 4], $i8
	load    [$i1 + 3], $i9
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
	bne     $i9, 0, be_else.35734
be_then.35734:
	mov     $f4, $f1
.count b_cont
	b       be_cont.35734
be_else.35734:
	load    [$i1 + 9], $i6
	load    [$i1 + 9], $i7
	load    [$i1 + 9], $i1
	fmul    $f2, $f3, $f5
	load    [$i6 + 0], $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    [$i7 + 1], $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
be_cont.35734:
	sub     $i3, 1, $i3
	bne     $i4, 3, be_else.35735
be_then.35735:
	fsub    $f1, $fc0, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
be_else.35735:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2831
bge_else.35731:
	ret
.end setup_startp_constants

######################################################################
# check_all_inside
######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$i3 + $i2], $i1
	bne     $i1, -1, be_else.35736
be_then.35736:
	li      1, $i1
	ret
be_else.35736:
	load    [min_caml_objects + $i1], $i1
	load    [$i1 + 1], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 5], $i6
	load    [$i1 + 5], $i7
	load    [$i5 + 0], $f1
	fsub    $f2, $f1, $f1
	load    [$i6 + 1], $f5
	fsub    $f3, $f5, $f5
	load    [$i7 + 2], $f6
	fsub    $f4, $f6, $f6
	bne     $i4, 1, be_else.35737
be_then.35737:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.35738
ble_then.35738:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35739
be_then.35739:
	li      1, $i1
.count b_cont
	b       be_cont.35737
be_else.35739:
	li      0, $i1
.count b_cont
	b       be_cont.35737
ble_else.35738:
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.35740
ble_then.35740:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35741
be_then.35741:
	li      1, $i1
.count b_cont
	b       be_cont.35737
be_else.35741:
	li      0, $i1
.count b_cont
	b       be_cont.35737
ble_else.35740:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i1 + 6], $i1
	bg      $f1, $f5, be_cont.35737
ble_then.35742:
	bne     $i1, 0, be_else.35743
be_then.35743:
	li      1, $i1
.count b_cont
	b       be_cont.35737
be_else.35743:
	li      0, $i1
.count b_cont
	b       be_cont.35737
be_else.35737:
	bne     $i4, 2, be_else.35744
be_then.35744:
	load    [$i1 + 6], $i4
	load    [$i1 + 4], $i1
	load    [$i1 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i1 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i1 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.35745
ble_then.35745:
	bne     $i4, 0, be_else.35746
be_then.35746:
	li      1, $i1
.count b_cont
	b       be_cont.35744
be_else.35746:
	li      0, $i1
.count b_cont
	b       be_cont.35744
ble_else.35745:
	bne     $i4, 0, be_else.35747
be_then.35747:
	li      0, $i1
.count b_cont
	b       be_cont.35744
be_else.35747:
	li      1, $i1
.count b_cont
	b       be_cont.35744
be_else.35744:
	load    [$i1 + 6], $i5
	fmul    $f1, $f1, $f7
	load    [$i1 + 4], $i6
	load    [$i6 + 0], $f8
	fmul    $f7, $f8, $f7
	fmul    $f5, $f5, $f8
	load    [$i1 + 4], $i6
	load    [$i6 + 1], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f6, $f8
	load    [$i1 + 4], $i6
	load    [$i6 + 2], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    [$i1 + 3], $i6
	bne     $i6, 0, be_else.35748
be_then.35748:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35748
be_else.35748:
	fmul    $f5, $f6, $f8
	load    [$i1 + 9], $i6
	load    [$i6 + 0], $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f6, $f1, $f6
	load    [$i1 + 9], $i6
	load    [$i6 + 1], $f8
	fmul    $f6, $f8, $f6
	fadd    $f7, $f6, $f6
	fmul    $f1, $f5, $f1
	load    [$i1 + 9], $i1
	load    [$i1 + 2], $f5
	fmul    $f1, $f5, $f1
	fadd    $f6, $f1, $f1
be_cont.35748:
	bne     $i4, 3, be_cont.35749
be_then.35749:
	fsub    $f1, $fc0, $f1
be_cont.35749:
	bg      $f0, $f1, ble_else.35750
ble_then.35750:
	bne     $i5, 0, be_else.35751
be_then.35751:
	li      1, $i1
.count b_cont
	b       ble_cont.35750
be_else.35751:
	li      0, $i1
.count b_cont
	b       ble_cont.35750
ble_else.35750:
	bne     $i5, 0, be_else.35752
be_then.35752:
	li      0, $i1
.count b_cont
	b       be_cont.35752
be_else.35752:
	li      1, $i1
be_cont.35752:
ble_cont.35750:
be_cont.35744:
be_cont.35737:
	bne     $i1, 0, be_else.35753
be_then.35753:
	add     $i2, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35754
be_then.35754:
	li      1, $i1
	ret
be_else.35754:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i7, 1, be_else.35755
be_then.35755:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.35756
ble_then.35756:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35757
be_then.35757:
	li      1, $i2
.count b_cont
	b       be_cont.35755
be_else.35757:
	li      0, $i2
.count b_cont
	b       be_cont.35755
ble_else.35756:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.35758
ble_then.35758:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35759
be_then.35759:
	li      1, $i2
.count b_cont
	b       be_cont.35755
be_else.35759:
	li      0, $i2
.count b_cont
	b       be_cont.35755
ble_else.35758:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.35755
ble_then.35760:
	bne     $i2, 0, be_else.35761
be_then.35761:
	li      1, $i2
.count b_cont
	b       be_cont.35755
be_else.35761:
	li      0, $i2
.count b_cont
	b       be_cont.35755
be_else.35755:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.35762
be_then.35762:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.35763
ble_then.35763:
	bne     $i4, 0, be_else.35764
be_then.35764:
	li      1, $i2
.count b_cont
	b       be_cont.35762
be_else.35764:
	li      0, $i2
.count b_cont
	b       be_cont.35762
ble_else.35763:
	bne     $i4, 0, be_else.35765
be_then.35765:
	li      0, $i2
.count b_cont
	b       be_cont.35762
be_else.35765:
	li      1, $i2
.count b_cont
	b       be_cont.35762
be_else.35762:
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
	bne     $i9, 0, be_else.35766
be_then.35766:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35766
be_else.35766:
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
be_cont.35766:
	bne     $i5, 3, be_cont.35767
be_then.35767:
	fsub    $f1, $fc0, $f1
be_cont.35767:
	bg      $f0, $f1, ble_else.35768
ble_then.35768:
	bne     $i4, 0, be_else.35769
be_then.35769:
	li      1, $i2
.count b_cont
	b       ble_cont.35768
be_else.35769:
	li      0, $i2
.count b_cont
	b       ble_cont.35768
ble_else.35768:
	bne     $i4, 0, be_else.35770
be_then.35770:
	li      0, $i2
.count b_cont
	b       be_cont.35770
be_else.35770:
	li      1, $i2
be_cont.35770:
ble_cont.35768:
be_cont.35762:
be_cont.35755:
	bne     $i2, 0, be_else.35771
be_then.35771:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35772
be_then.35772:
	li      1, $i1
	ret
be_else.35772:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i4, 1, be_else.35773
be_then.35773:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.35774
ble_then.35774:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35775
be_then.35775:
	li      1, $i2
.count b_cont
	b       be_cont.35773
be_else.35775:
	li      0, $i2
.count b_cont
	b       be_cont.35773
ble_else.35774:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.35776
ble_then.35776:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.35777
be_then.35777:
	li      1, $i2
.count b_cont
	b       be_cont.35773
be_else.35777:
	li      0, $i2
.count b_cont
	b       be_cont.35773
ble_else.35776:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.35773
ble_then.35778:
	bne     $i2, 0, be_else.35779
be_then.35779:
	li      1, $i2
.count b_cont
	b       be_cont.35773
be_else.35779:
	li      0, $i2
.count b_cont
	b       be_cont.35773
be_else.35773:
	bne     $i4, 2, be_else.35780
be_then.35780:
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
	bg      $f0, $f1, ble_else.35781
ble_then.35781:
	bne     $i4, 0, be_else.35782
be_then.35782:
	li      1, $i2
.count b_cont
	b       be_cont.35780
be_else.35782:
	li      0, $i2
.count b_cont
	b       be_cont.35780
ble_else.35781:
	bne     $i4, 0, be_else.35783
be_then.35783:
	li      0, $i2
.count b_cont
	b       be_cont.35780
be_else.35783:
	li      1, $i2
.count b_cont
	b       be_cont.35780
be_else.35780:
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
	bne     $i6, 0, be_else.35784
be_then.35784:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35784
be_else.35784:
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
be_cont.35784:
	bne     $i5, 3, be_cont.35785
be_then.35785:
	fsub    $f1, $fc0, $f1
be_cont.35785:
	bg      $f0, $f1, ble_else.35786
ble_then.35786:
	bne     $i4, 0, be_else.35787
be_then.35787:
	li      1, $i2
.count b_cont
	b       ble_cont.35786
be_else.35787:
	li      0, $i2
.count b_cont
	b       ble_cont.35786
ble_else.35786:
	bne     $i4, 0, be_else.35788
be_then.35788:
	li      0, $i2
.count b_cont
	b       be_cont.35788
be_else.35788:
	li      1, $i2
be_cont.35788:
ble_cont.35786:
be_cont.35780:
be_cont.35773:
	bne     $i2, 0, be_else.35789
be_then.35789:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.35790
be_then.35790:
	li      1, $i1
	ret
be_else.35790:
	load    [min_caml_objects + $i2], $i2
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
	bne     $i7, 1, be_else.35791
be_then.35791:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.35792
ble_then.35792:
	li      0, $i4
.count b_cont
	b       ble_cont.35792
ble_else.35792:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.35793
ble_then.35793:
	li      0, $i4
.count b_cont
	b       ble_cont.35793
ble_else.35793:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.35794
ble_then.35794:
	li      0, $i4
.count b_cont
	b       ble_cont.35794
ble_else.35794:
	li      1, $i4
ble_cont.35794:
ble_cont.35793:
ble_cont.35792:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.35795
be_then.35795:
	bne     $i2, 0, be_else.35796
be_then.35796:
	li      0, $i1
	ret
be_else.35796:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35795:
	bne     $i2, 0, be_else.35797
be_then.35797:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35797:
	li      0, $i1
	ret
be_else.35791:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.35798
be_then.35798:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.35799
ble_then.35799:
	bne     $i4, 0, be_else.35800
be_then.35800:
	li      0, $i1
	ret
be_else.35800:
	add     $i1, 1, $i2
	b       check_all_inside.2856
ble_else.35799:
	bne     $i4, 0, be_else.35801
be_then.35801:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35801:
	li      0, $i1
	ret
be_else.35798:
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
	bne     $i9, 0, be_else.35802
be_then.35802:
	mov     $f7, $f1
.count b_cont
	b       be_cont.35802
be_else.35802:
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
be_cont.35802:
	bne     $i7, 3, be_cont.35803
be_then.35803:
	fsub    $f1, $fc0, $f1
be_cont.35803:
	bg      $f0, $f1, ble_else.35804
ble_then.35804:
	bne     $i4, 0, be_else.35805
be_then.35805:
	li      0, $i1
	ret
be_else.35805:
	add     $i1, 1, $i2
	b       check_all_inside.2856
ble_else.35804:
	bne     $i4, 0, be_else.35806
be_then.35806:
	add     $i1, 1, $i2
	b       check_all_inside.2856
be_else.35806:
	li      0, $i1
	ret
be_else.35789:
	li      0, $i1
	ret
be_else.35771:
	li      0, $i1
	ret
be_else.35753:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
# shadow_check_and_group
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.35807
be_then.35807:
	li      0, $i1
	ret
be_else.35807:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 5], $i12
	load    [$i11 + 5], $i13
	load    [$i11 + 5], $i14
	load    [min_caml_light_dirvec + 1], $i15
	load    [$i11 + 1], $i16
	load    [min_caml_intersection_point + 0], $f10
	load    [$i12 + 0], $f11
	fsub    $f10, $f11, $f10
	load    [min_caml_intersection_point + 1], $f11
	load    [$i13 + 1], $f12
	fsub    $f11, $f12, $f11
	load    [min_caml_intersection_point + 2], $f12
	load    [$i14 + 2], $f13
	fsub    $f12, $f13, $f12
	load    [$i15 + $i10], $i12
	bne     $i16, 1, be_else.35808
be_then.35808:
	load    [min_caml_light_dirvec + 0], $i13
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f13
	load    [$i13 + 1], $f14
	load    [$i12 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i12 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35809
ble_then.35809:
	li      0, $i14
.count b_cont
	b       ble_cont.35809
ble_else.35809:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35810
ble_then.35810:
	li      0, $i14
.count b_cont
	b       ble_cont.35810
ble_else.35810:
	load    [$i12 + 1], $f13
	bne     $f13, $f0, be_else.35811
be_then.35811:
	li      0, $i14
.count b_cont
	b       be_cont.35811
be_else.35811:
	li      1, $i14
be_cont.35811:
ble_cont.35810:
ble_cont.35809:
	bne     $i14, 0, be_else.35812
be_then.35812:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i12 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i12 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.35813
ble_then.35813:
	li      0, $i14
.count b_cont
	b       ble_cont.35813
ble_else.35813:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35814
ble_then.35814:
	li      0, $i14
.count b_cont
	b       ble_cont.35814
ble_else.35814:
	load    [$i12 + 3], $f13
	bne     $f13, $f0, be_else.35815
be_then.35815:
	li      0, $i14
.count b_cont
	b       be_cont.35815
be_else.35815:
	li      1, $i14
be_cont.35815:
ble_cont.35814:
ble_cont.35813:
	bne     $i14, 0, be_else.35816
be_then.35816:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i12 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i12 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.35817
ble_then.35817:
	li      0, $i11
.count b_cont
	b       be_cont.35808
ble_else.35817:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i13 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35818
ble_then.35818:
	li      0, $i11
.count b_cont
	b       be_cont.35808
ble_else.35818:
	load    [$i12 + 5], $f10
	bne     $f10, $f0, be_else.35819
be_then.35819:
	li      0, $i11
.count b_cont
	b       be_cont.35808
be_else.35819:
	mov     $f12, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.35808
be_else.35816:
	mov     $f15, $fg0
	li      2, $i11
.count b_cont
	b       be_cont.35808
be_else.35812:
	mov     $f15, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35808
be_else.35808:
	load    [$i12 + 0], $f13
	bne     $i16, 2, be_else.35820
be_then.35820:
	bg      $f0, $f13, ble_else.35821
ble_then.35821:
	li      0, $i11
.count b_cont
	b       be_cont.35820
ble_else.35821:
	load    [$i12 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i12 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i12 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35820
be_else.35820:
	bne     $f13, $f0, be_else.35822
be_then.35822:
	li      0, $i11
.count b_cont
	b       be_cont.35822
be_else.35822:
	load    [$i12 + 1], $f14
	fmul    $f14, $f10, $f14
	load    [$i12 + 2], $f15
	fmul    $f15, $f11, $f15
	fadd    $f14, $f15, $f14
	load    [$i12 + 3], $f15
	fmul    $f15, $f12, $f15
	fadd    $f14, $f15, $f14
	fmul    $f14, $f14, $f15
	fmul    $f10, $f10, $f16
	load    [$i11 + 4], $i13
	load    [$i13 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f11, $f11, $f17
	load    [$i11 + 4], $i13
	load    [$i13 + 1], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f12, $f17
	load    [$i11 + 4], $i13
	load    [$i13 + 2], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	load    [$i11 + 3], $i13
	bne     $i13, 0, be_else.35823
be_then.35823:
	mov     $f16, $f10
.count b_cont
	b       be_cont.35823
be_else.35823:
	fmul    $f11, $f12, $f17
	load    [$i11 + 9], $i13
	load    [$i13 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f10, $f12
	load    [$i11 + 9], $i13
	load    [$i13 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f16, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i11 + 9], $i13
	load    [$i13 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.35823:
	bne     $i16, 3, be_cont.35824
be_then.35824:
	fsub    $f10, $fc0, $f10
be_cont.35824:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.35825
ble_then.35825:
	li      0, $i11
.count b_cont
	b       ble_cont.35825
ble_else.35825:
	load    [$i11 + 6], $i11
	load    [$i12 + 4], $f11
	fsqrt   $f10, $f10
	bne     $i11, 0, be_else.35826
be_then.35826:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35826
be_else.35826:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i11
be_cont.35826:
ble_cont.35825:
be_cont.35822:
be_cont.35820:
be_cont.35808:
	bne     $i11, 0, be_else.35827
be_then.35827:
	li      0, $i11
.count b_cont
	b       be_cont.35827
be_else.35827:
.count load_float
	load    [f.31952], $f10
	bg      $f10, $fg0, ble_else.35828
ble_then.35828:
	li      0, $i11
.count b_cont
	b       ble_cont.35828
ble_else.35828:
	li      1, $i11
ble_cont.35828:
be_cont.35827:
	bne     $i11, 0, be_else.35829
be_then.35829:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35830
be_then.35830:
	li      0, $i1
	ret
be_else.35830:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2862
be_else.35829:
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.35831
be_then.35831:
	li      1, $i1
	ret
be_else.35831:
	load    [min_caml_objects + $i10], $i10
	load    [$i10 + 5], $i11
	load    [$i10 + 5], $i12
	load    [$i10 + 5], $i13
	load    [$i10 + 1], $i14
	load    [$i11 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $fg12, $f11, $f12
	load    [min_caml_intersection_point + 0], $f13
	fadd    $f12, $f13, $f2
	fsub    $f2, $f10, $f10
	load    [$i12 + 1], $f12
	fmul    $fg13, $f11, $f13
	load    [min_caml_intersection_point + 1], $f14
	fadd    $f13, $f14, $f3
	fsub    $f3, $f12, $f12
	load    [$i13 + 2], $f13
	fmul    $fg14, $f11, $f11
	load    [min_caml_intersection_point + 2], $f14
	fadd    $f11, $f14, $f4
	fsub    $f4, $f13, $f11
	bne     $i14, 1, be_else.35832
be_then.35832:
	load    [$i10 + 4], $i11
	load    [$i11 + 0], $f13
	fabs    $f10, $f10
	bg      $f13, $f10, ble_else.35833
ble_then.35833:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.35834
be_then.35834:
	li      1, $i10
.count b_cont
	b       be_cont.35832
be_else.35834:
	li      0, $i10
.count b_cont
	b       be_cont.35832
ble_else.35833:
	load    [$i10 + 4], $i11
	load    [$i11 + 1], $f10
	fabs    $f12, $f12
	bg      $f10, $f12, ble_else.35835
ble_then.35835:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.35836
be_then.35836:
	li      1, $i10
.count b_cont
	b       be_cont.35832
be_else.35836:
	li      0, $i10
.count b_cont
	b       be_cont.35832
ble_else.35835:
	load    [$i10 + 4], $i11
	load    [$i11 + 2], $f10
	fabs    $f11, $f11
	load    [$i10 + 6], $i10
	bg      $f10, $f11, be_cont.35832
ble_then.35837:
	bne     $i10, 0, be_else.35838
be_then.35838:
	li      1, $i10
.count b_cont
	b       be_cont.35832
be_else.35838:
	li      0, $i10
.count b_cont
	b       be_cont.35832
be_else.35832:
	load    [$i10 + 6], $i11
	bne     $i14, 2, be_else.35839
be_then.35839:
	load    [$i10 + 4], $i10
	load    [$i10 + 0], $f13
	fmul    $f13, $f10, $f10
	load    [$i10 + 1], $f13
	fmul    $f13, $f12, $f12
	fadd    $f10, $f12, $f10
	load    [$i10 + 2], $f12
	fmul    $f12, $f11, $f11
	fadd    $f10, $f11, $f10
	bg      $f0, $f10, ble_else.35840
ble_then.35840:
	bne     $i11, 0, be_else.35841
be_then.35841:
	li      1, $i10
.count b_cont
	b       be_cont.35839
be_else.35841:
	li      0, $i10
.count b_cont
	b       be_cont.35839
ble_else.35840:
	bne     $i11, 0, be_else.35842
be_then.35842:
	li      0, $i10
.count b_cont
	b       be_cont.35839
be_else.35842:
	li      1, $i10
.count b_cont
	b       be_cont.35839
be_else.35839:
	fmul    $f10, $f10, $f13
	load    [$i10 + 4], $i12
	load    [$i12 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i10 + 4], $i12
	load    [$i12 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i10 + 4], $i12
	load    [$i12 + 2], $f15
	fmul    $f14, $f15, $f14
	load    [$i10 + 3], $i12
	fadd    $f13, $f14, $f13
	bne     $i12, 0, be_else.35843
be_then.35843:
	mov     $f13, $f10
.count b_cont
	b       be_cont.35843
be_else.35843:
	fmul    $f12, $f11, $f14
	load    [$i10 + 9], $i12
	load    [$i12 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f10, $f11
	load    [$i10 + 9], $i12
	load    [$i12 + 1], $f14
	fmul    $f11, $f14, $f11
	fadd    $f13, $f11, $f11
	fmul    $f10, $f12, $f10
	load    [$i10 + 9], $i10
	load    [$i10 + 2], $f12
	fmul    $f10, $f12, $f10
	fadd    $f11, $f10, $f10
be_cont.35843:
	bne     $i14, 3, be_cont.35844
be_then.35844:
	fsub    $f10, $fc0, $f10
be_cont.35844:
	bg      $f0, $f10, ble_else.35845
ble_then.35845:
	bne     $i11, 0, be_else.35846
be_then.35846:
	li      1, $i10
.count b_cont
	b       ble_cont.35845
be_else.35846:
	li      0, $i10
.count b_cont
	b       ble_cont.35845
ble_else.35845:
	bne     $i11, 0, be_else.35847
be_then.35847:
	li      0, $i10
.count b_cont
	b       be_cont.35847
be_else.35847:
	li      1, $i10
be_cont.35847:
ble_cont.35845:
be_cont.35839:
be_cont.35832:
	bne     $i10, 0, be_else.35848
be_then.35848:
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
	bne     $i1, 0, be_else.35849
be_then.35849:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 2], $i3
	b       shadow_check_and_group.2862
be_else.35849:
	li      1, $i1
	ret
be_else.35848:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
# shadow_check_one_or_group
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$i3 + $i2], $i17
	bne     $i17, -1, be_else.35850
be_then.35850:
	li      0, $i1
	ret
be_else.35850:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35851
be_then.35851:
.count stack_load
	load    [$sp + 2], $i17
	add     $i17, 1, $i17
.count stack_load
	load    [$sp + 1], $i18
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35852
be_then.35852:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35852:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35853
be_then.35853:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35854
be_then.35854:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35854:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35855
be_then.35855:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35856
be_then.35856:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35856:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35857
be_then.35857:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35858
be_then.35858:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35858:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35859
be_then.35859:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35860
be_then.35860:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35860:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35861
be_then.35861:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35862
be_then.35862:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35862:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35863
be_then.35863:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.35864
be_then.35864:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.35864:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2862
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.35865
be_then.35865:
	add     $i17, 1, $i2
.count move_args
	mov     $i18, $i3
	b       shadow_check_one_or_group.2865
be_else.35865:
	li      1, $i1
	ret
be_else.35863:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35861:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35859:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35857:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35855:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35853:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.35851:
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
	bne     $i18, -1, be_else.35866
be_then.35866:
	li      0, $i1
	ret
be_else.35866:
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
	bne     $i18, 99, be_else.35867
be_then.35867:
	li      1, $i10
.count b_cont
	b       be_cont.35867
be_else.35867:
	load    [min_caml_objects + $i18], $i19
	load    [min_caml_intersection_point + 0], $f10
	load    [$i19 + 5], $i20
	load    [$i20 + 0], $f11
	fsub    $f10, $f11, $f10
	load    [min_caml_intersection_point + 1], $f11
	load    [$i19 + 5], $i20
	load    [$i20 + 1], $f12
	fsub    $f11, $f12, $f11
	load    [min_caml_intersection_point + 2], $f12
	load    [$i19 + 5], $i20
	load    [$i20 + 2], $f13
	fsub    $f12, $f13, $f12
	load    [min_caml_light_dirvec + 1], $i20
	load    [$i20 + $i18], $i18
	load    [$i19 + 1], $i20
	bne     $i20, 1, be_else.35868
be_then.35868:
	load    [min_caml_light_dirvec + 0], $i20
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f13
	load    [$i20 + 1], $f14
	load    [$i18 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i18 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.35869
ble_then.35869:
	li      0, $i21
.count b_cont
	b       ble_cont.35869
ble_else.35869:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f13
	load    [$i20 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35870
ble_then.35870:
	li      0, $i21
.count b_cont
	b       ble_cont.35870
ble_else.35870:
	load    [$i18 + 1], $f13
	bne     $f13, $f0, be_else.35871
be_then.35871:
	li      0, $i21
.count b_cont
	b       be_cont.35871
be_else.35871:
	li      1, $i21
be_cont.35871:
ble_cont.35870:
ble_cont.35869:
	bne     $i21, 0, be_else.35872
be_then.35872:
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f13
	load    [$i20 + 0], $f14
	load    [$i18 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i18 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.35873
ble_then.35873:
	li      0, $i21
.count b_cont
	b       ble_cont.35873
ble_else.35873:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f13
	load    [$i20 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.35874
ble_then.35874:
	li      0, $i21
.count b_cont
	b       ble_cont.35874
ble_else.35874:
	load    [$i18 + 3], $f13
	bne     $f13, $f0, be_else.35875
be_then.35875:
	li      0, $i21
.count b_cont
	b       be_cont.35875
be_else.35875:
	li      1, $i21
be_cont.35875:
ble_cont.35874:
ble_cont.35873:
	bne     $i21, 0, be_else.35876
be_then.35876:
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f13
	load    [$i20 + 0], $f14
	load    [$i18 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i18 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.35877
ble_then.35877:
	li      0, $i18
.count b_cont
	b       be_cont.35868
ble_else.35877:
	load    [$i19 + 4], $i19
	load    [$i19 + 1], $f10
	load    [$i20 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35878
ble_then.35878:
	li      0, $i18
.count b_cont
	b       be_cont.35868
ble_else.35878:
	load    [$i18 + 5], $f10
	bne     $f10, $f0, be_else.35879
be_then.35879:
	li      0, $i18
.count b_cont
	b       be_cont.35868
be_else.35879:
	mov     $f12, $fg0
	li      3, $i18
.count b_cont
	b       be_cont.35868
be_else.35876:
	mov     $f15, $fg0
	li      2, $i18
.count b_cont
	b       be_cont.35868
be_else.35872:
	mov     $f15, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35868
be_else.35868:
	load    [$i18 + 0], $f13
	bne     $i20, 2, be_else.35880
be_then.35880:
	bg      $f0, $f13, ble_else.35881
ble_then.35881:
	li      0, $i18
.count b_cont
	b       be_cont.35880
ble_else.35881:
	load    [$i18 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i18 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i18 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $fg0
	li      1, $i18
.count b_cont
	b       be_cont.35880
be_else.35880:
	bne     $f13, $f0, be_else.35882
be_then.35882:
	li      0, $i18
.count b_cont
	b       be_cont.35882
be_else.35882:
	load    [$i18 + 1], $f14
	fmul    $f14, $f10, $f14
	load    [$i18 + 2], $f15
	fmul    $f15, $f11, $f15
	fadd    $f14, $f15, $f14
	load    [$i18 + 3], $f15
	fmul    $f15, $f12, $f15
	fadd    $f14, $f15, $f14
	fmul    $f14, $f14, $f15
	fmul    $f10, $f10, $f16
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f11, $f11, $f17
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f12, $f17
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	load    [$i19 + 3], $i21
	bne     $i21, 0, be_else.35883
be_then.35883:
	mov     $f16, $f10
.count b_cont
	b       be_cont.35883
be_else.35883:
	fmul    $f11, $f12, $f17
	load    [$i19 + 9], $i21
	load    [$i21 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f16, $f17, $f16
	fmul    $f12, $f10, $f12
	load    [$i19 + 9], $i21
	load    [$i21 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f16, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i19 + 9], $i21
	load    [$i21 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.35883:
	bne     $i20, 3, be_cont.35884
be_then.35884:
	fsub    $f10, $fc0, $f10
be_cont.35884:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.35885
ble_then.35885:
	li      0, $i18
.count b_cont
	b       ble_cont.35885
ble_else.35885:
	load    [$i19 + 6], $i19
	load    [$i18 + 4], $f11
	li      1, $i18
	fsqrt   $f10, $f10
	bne     $i19, 0, be_else.35886
be_then.35886:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
.count b_cont
	b       be_cont.35886
be_else.35886:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $fg0
be_cont.35886:
ble_cont.35885:
be_cont.35882:
be_cont.35880:
be_cont.35868:
	bne     $i18, 0, be_else.35887
be_then.35887:
	li      0, $i10
.count b_cont
	b       be_cont.35887
be_else.35887:
	bg      $fc7, $fg0, ble_else.35888
ble_then.35888:
	li      0, $i10
.count b_cont
	b       ble_cont.35888
ble_else.35888:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35889
be_then.35889:
	li      0, $i10
.count b_cont
	b       be_cont.35889
be_else.35889:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35890
be_then.35890:
	li      2, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i10
	bne     $i10, 0, be_else.35891
be_then.35891:
	li      0, $i10
.count b_cont
	b       be_cont.35890
be_else.35891:
	li      1, $i10
.count b_cont
	b       be_cont.35890
be_else.35890:
	li      1, $i10
be_cont.35890:
be_cont.35889:
ble_cont.35888:
be_cont.35887:
be_cont.35867:
	bne     $i10, 0, be_else.35892
be_then.35892:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.35893
be_then.35893:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.35893:
.count stack_store
	store   $i12, [$sp + 4]
.count stack_store
	store   $i10, [$sp + 5]
	bne     $i2, 99, be_else.35894
be_then.35894:
	li      1, $i17
.count b_cont
	b       be_cont.35894
be_else.35894:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35895
be_then.35895:
	li      0, $i17
.count b_cont
	b       be_cont.35895
be_else.35895:
	bg      $fc7, $fg0, ble_else.35896
ble_then.35896:
	li      0, $i17
.count b_cont
	b       ble_cont.35896
ble_else.35896:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.35897
be_then.35897:
	li      0, $i17
.count b_cont
	b       be_cont.35897
be_else.35897:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35898
be_then.35898:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35899
be_then.35899:
	li      0, $i17
.count b_cont
	b       be_cont.35898
be_else.35899:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35900
be_then.35900:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35901
be_then.35901:
	li      0, $i17
.count b_cont
	b       be_cont.35898
be_else.35901:
	li      1, $i17
.count b_cont
	b       be_cont.35898
be_else.35900:
	li      1, $i17
.count b_cont
	b       be_cont.35898
be_else.35898:
	li      1, $i17
be_cont.35898:
be_cont.35897:
ble_cont.35896:
be_cont.35895:
be_cont.35894:
	bne     $i17, 0, be_else.35902
be_then.35902:
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
be_else.35902:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35903
be_then.35903:
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
be_else.35903:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35904
be_then.35904:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35905
be_then.35905:
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
be_else.35905:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35906
be_then.35906:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.35907
be_then.35907:
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.35907:
	li      1, $i1
	ret
be_else.35906:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35904:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35892:
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35908
be_then.35908:
	li      0, $i10
.count b_cont
	b       be_cont.35908
be_else.35908:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35909
be_then.35909:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35910
be_then.35910:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35910:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35911
be_then.35911:
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.35912
be_then.35912:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35912:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35913
be_then.35913:
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.35914
be_then.35914:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35914:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35915
be_then.35915:
	load    [$i17 + 5], $i18
	bne     $i18, -1, be_else.35916
be_then.35916:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35916:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35917
be_then.35917:
	load    [$i17 + 6], $i18
	bne     $i18, -1, be_else.35918
be_then.35918:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35918:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35919
be_then.35919:
	load    [$i17 + 7], $i18
	bne     $i18, -1, be_else.35920
be_then.35920:
	li      0, $i10
.count b_cont
	b       be_cont.35909
be_else.35920:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35921
be_then.35921:
	li      8, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.35909
be_else.35921:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35919:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35917:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35915:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35913:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35911:
	li      1, $i10
.count b_cont
	b       be_cont.35909
be_else.35909:
	li      1, $i10
be_cont.35909:
be_cont.35908:
	bne     $i10, 0, be_else.35922
be_then.35922:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.35923
be_then.35923:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.35923:
.count stack_store
	store   $i12, [$sp + 6]
.count stack_store
	store   $i10, [$sp + 7]
	bne     $i2, 99, be_else.35924
be_then.35924:
	li      1, $i17
.count b_cont
	b       be_cont.35924
be_else.35924:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35925
be_then.35925:
	li      0, $i17
.count b_cont
	b       be_cont.35925
be_else.35925:
	bg      $fc7, $fg0, ble_else.35926
ble_then.35926:
	li      0, $i17
.count b_cont
	b       ble_cont.35926
ble_else.35926:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.35927
be_then.35927:
	li      0, $i17
.count b_cont
	b       be_cont.35927
be_else.35927:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35928
be_then.35928:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35929
be_then.35929:
	li      0, $i17
.count b_cont
	b       be_cont.35928
be_else.35929:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35930
be_then.35930:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.35931
be_then.35931:
	li      0, $i17
.count b_cont
	b       be_cont.35928
be_else.35931:
	li      1, $i17
.count b_cont
	b       be_cont.35928
be_else.35930:
	li      1, $i17
.count b_cont
	b       be_cont.35928
be_else.35928:
	li      1, $i17
be_cont.35928:
be_cont.35927:
ble_cont.35926:
be_cont.35925:
be_cont.35924:
	bne     $i17, 0, be_else.35932
be_then.35932:
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
be_else.35932:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35933
be_then.35933:
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
be_else.35933:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.35934
be_then.35934:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35935
be_then.35935:
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
be_else.35935:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.35936
be_then.35936:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.35937
be_then.35937:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2868
be_else.35937:
	li      1, $i1
	ret
be_else.35936:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35934:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.35922:
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
	bne     $i10, -1, be_else.35938
be_then.35938:
	ret
be_else.35938:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 5], $i12
	load    [$i11 + 5], $i13
	load    [$i11 + 5], $i14
	load    [$i11 + 1], $i15
	load    [$i12 + 0], $f10
	fsub    $fg21, $f10, $f10
	load    [$i13 + 1], $f11
	fsub    $fg22, $f11, $f11
	load    [$i14 + 2], $f12
	fsub    $fg23, $f12, $f12
	load    [$i4 + 0], $f13
	bne     $i15, 1, be_else.35939
be_then.35939:
	bne     $f13, $f0, be_else.35940
be_then.35940:
	li      0, $i12
.count b_cont
	b       be_cont.35940
be_else.35940:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.35941
ble_then.35941:
	li      0, $i14
.count b_cont
	b       ble_cont.35941
ble_else.35941:
	li      1, $i14
ble_cont.35941:
	bne     $i13, 0, be_else.35942
be_then.35942:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35942
be_else.35942:
	bne     $i14, 0, be_else.35943
be_then.35943:
	li      1, $i13
.count b_cont
	b       be_cont.35943
be_else.35943:
	li      0, $i13
be_cont.35943:
be_cont.35942:
	load    [$i12 + 0], $f14
	bne     $i13, 0, be_cont.35944
be_then.35944:
	fneg    $f14, $f14
be_cont.35944:
	fsub    $f14, $f10, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 1], $f14
	load    [$i4 + 1], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f11, $f15
	bg      $f14, $f15, ble_else.35945
ble_then.35945:
	li      0, $i12
.count b_cont
	b       ble_cont.35945
ble_else.35945:
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f12, $f15
	bg      $f14, $f15, ble_else.35946
ble_then.35946:
	li      0, $i12
.count b_cont
	b       ble_cont.35946
ble_else.35946:
	mov     $f13, $fg0
	li      1, $i12
ble_cont.35946:
ble_cont.35945:
be_cont.35940:
	bne     $i12, 0, be_else.35947
be_then.35947:
	load    [$i4 + 1], $f13
	bne     $f13, $f0, be_else.35948
be_then.35948:
	li      0, $i12
.count b_cont
	b       be_cont.35948
be_else.35948:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.35949
ble_then.35949:
	li      0, $i14
.count b_cont
	b       ble_cont.35949
ble_else.35949:
	li      1, $i14
ble_cont.35949:
	bne     $i13, 0, be_else.35950
be_then.35950:
	mov     $i14, $i13
.count b_cont
	b       be_cont.35950
be_else.35950:
	bne     $i14, 0, be_else.35951
be_then.35951:
	li      1, $i13
.count b_cont
	b       be_cont.35951
be_else.35951:
	li      0, $i13
be_cont.35951:
be_cont.35950:
	load    [$i12 + 1], $f14
	bne     $i13, 0, be_cont.35952
be_then.35952:
	fneg    $f14, $f14
be_cont.35952:
	fsub    $f14, $f11, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f12, $f15
	bg      $f14, $f15, ble_else.35953
ble_then.35953:
	li      0, $i12
.count b_cont
	b       ble_cont.35953
ble_else.35953:
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	fmul    $f13, $f15, $f15
	fadd_a  $f15, $f10, $f15
	bg      $f14, $f15, ble_else.35954
ble_then.35954:
	li      0, $i12
.count b_cont
	b       ble_cont.35954
ble_else.35954:
	mov     $f13, $fg0
	li      1, $i12
ble_cont.35954:
ble_cont.35953:
be_cont.35948:
	bne     $i12, 0, be_else.35955
be_then.35955:
	load    [$i4 + 2], $f13
	bne     $f13, $f0, be_else.35956
be_then.35956:
	li      0, $i11
.count b_cont
	b       be_cont.35939
be_else.35956:
	load    [$i11 + 4], $i12
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	load    [$i11 + 6], $i11
	bg      $f0, $f13, ble_else.35957
ble_then.35957:
	li      0, $i13
.count b_cont
	b       ble_cont.35957
ble_else.35957:
	li      1, $i13
ble_cont.35957:
	bne     $i11, 0, be_else.35958
be_then.35958:
	mov     $i13, $i11
.count b_cont
	b       be_cont.35958
be_else.35958:
	bne     $i13, 0, be_else.35959
be_then.35959:
	li      1, $i11
.count b_cont
	b       be_cont.35959
be_else.35959:
	li      0, $i11
be_cont.35959:
be_cont.35958:
	load    [$i12 + 2], $f16
	bne     $i11, 0, be_cont.35960
be_then.35960:
	fneg    $f16, $f16
be_cont.35960:
	fsub    $f16, $f12, $f12
	finv    $f13, $f13
	fmul    $f12, $f13, $f12
	fmul    $f12, $f15, $f13
	fadd_a  $f13, $f10, $f10
	bg      $f14, $f10, ble_else.35961
ble_then.35961:
	li      0, $i11
.count b_cont
	b       be_cont.35939
ble_else.35961:
	load    [$i12 + 1], $f10
	load    [$i4 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.35962
ble_then.35962:
	li      0, $i11
.count b_cont
	b       be_cont.35939
ble_else.35962:
	mov     $f12, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.35939
be_else.35955:
	li      2, $i11
.count b_cont
	b       be_cont.35939
be_else.35947:
	li      1, $i11
.count b_cont
	b       be_cont.35939
be_else.35939:
	bne     $i15, 2, be_else.35963
be_then.35963:
	load    [$i11 + 4], $i11
	load    [$i11 + 0], $f14
	fmul    $f13, $f14, $f13
	load    [$i4 + 1], $f15
	load    [$i11 + 1], $f16
	fmul    $f15, $f16, $f15
	fadd    $f13, $f15, $f13
	load    [$i4 + 2], $f15
	load    [$i11 + 2], $f17
	fmul    $f15, $f17, $f15
	fadd    $f13, $f15, $f13
	bg      $f13, $f0, ble_else.35964
ble_then.35964:
	li      0, $i11
.count b_cont
	b       be_cont.35963
ble_else.35964:
	fmul    $f14, $f10, $f10
	fmul    $f16, $f11, $f11
	fadd    $f10, $f11, $f10
	fmul    $f17, $f12, $f11
	fadd_n  $f10, $f11, $f10
	finv    $f13, $f11
	fmul    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35963
be_else.35963:
	load    [$i11 + 3], $i12
	load    [$i11 + 4], $i13
	load    [$i11 + 4], $i14
	load    [$i11 + 4], $i15
	load    [$i4 + 1], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f13, $f16
	load    [$i13 + 0], $f17
	fmul    $f16, $f17, $f16
	fmul    $f14, $f14, $f18
	load    [$i14 + 1], $f1
	fmul    $f18, $f1, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f15, $f18
	load    [$i15 + 2], $f2
	fmul    $f18, $f2, $f18
	fadd    $f16, $f18, $f16
	be      $i12, 0, bne_cont.35965
bne_then.35965:
	fmul    $f14, $f15, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 0], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f13, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 1], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
	fmul    $f13, $f14, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 2], $f3
	fmul    $f18, $f3, $f18
	fadd    $f16, $f18, $f16
bne_cont.35965:
	bne     $f16, $f0, be_else.35966
be_then.35966:
	li      0, $i11
.count b_cont
	b       be_cont.35966
be_else.35966:
	load    [$i11 + 1], $i13
	fmul    $f13, $f10, $f18
	fmul    $f18, $f17, $f18
	fmul    $f14, $f11, $f3
	fmul    $f3, $f1, $f3
	fadd    $f18, $f3, $f18
	fmul    $f15, $f12, $f3
	fmul    $f3, $f2, $f3
	fadd    $f18, $f3, $f18
	bne     $i12, 0, be_else.35967
be_then.35967:
	mov     $f18, $f13
.count b_cont
	b       be_cont.35967
be_else.35967:
	fmul    $f15, $f11, $f3
	fmul    $f14, $f12, $f4
	fadd    $f3, $f4, $f3
	load    [$i11 + 9], $i14
	load    [$i14 + 0], $f4
	fmul    $f3, $f4, $f3
	fmul    $f13, $f12, $f4
	fmul    $f15, $f10, $f15
	fadd    $f4, $f15, $f15
	load    [$i11 + 9], $i14
	load    [$i14 + 1], $f4
	fmul    $f15, $f4, $f15
	fadd    $f3, $f15, $f15
	fmul    $f13, $f11, $f13
	fmul    $f14, $f10, $f14
	fadd    $f13, $f14, $f13
	load    [$i11 + 9], $i14
	load    [$i14 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f15, $f13, $f13
	fmul    $f13, $fc3, $f13
	fadd    $f18, $f13, $f13
be_cont.35967:
	fmul    $f13, $f13, $f14
	fmul    $f10, $f10, $f15
	fmul    $f15, $f17, $f15
	fmul    $f11, $f11, $f17
	fmul    $f17, $f1, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f12, $f17
	fmul    $f17, $f2, $f17
	fadd    $f15, $f17, $f15
	bne     $i12, 0, be_else.35968
be_then.35968:
	mov     $f15, $f10
.count b_cont
	b       be_cont.35968
be_else.35968:
	fmul    $f11, $f12, $f17
	load    [$i11 + 9], $i12
	load    [$i12 + 0], $f18
	fmul    $f17, $f18, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f10, $f12
	load    [$i11 + 9], $i12
	load    [$i12 + 1], $f17
	fmul    $f12, $f17, $f12
	fadd    $f15, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i11 + 9], $i12
	load    [$i12 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.35968:
	bne     $i13, 3, be_cont.35969
be_then.35969:
	fsub    $f10, $fc0, $f10
be_cont.35969:
	fmul    $f16, $f10, $f10
	fsub    $f14, $f10, $f10
	bg      $f10, $f0, ble_else.35970
ble_then.35970:
	li      0, $i11
.count b_cont
	b       ble_cont.35970
ble_else.35970:
	load    [$i11 + 6], $i11
	fsqrt   $f10, $f10
	finv    $f16, $f11
	bne     $i11, 0, be_else.35971
be_then.35971:
	fneg    $f10, $f10
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.35971
be_else.35971:
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $fg0
	li      1, $i11
be_cont.35971:
ble_cont.35970:
be_cont.35966:
be_cont.35963:
be_cont.35939:
	bne     $i11, 0, be_else.35972
be_then.35972:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.35973
be_then.35973:
	ret
be_else.35973:
	add     $i2, 1, $i2
	b       solve_each_element.2871
be_else.35972:
	bg      $fg0, $f0, ble_else.35974
ble_then.35974:
	add     $i2, 1, $i2
	b       solve_each_element.2871
ble_else.35974:
	bg      $fg7, $fg0, ble_else.35975
ble_then.35975:
	add     $i2, 1, $i2
	b       solve_each_element.2871
ble_else.35975:
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
	li      0, $i2
	load    [$i4 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg21, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i4 + 1], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg22, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i4 + 2], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg23, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.35976
be_then.35976:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2871
be_else.35976:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
	mov     $i10, $ig5
	mov     $i11, $ig4
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
	bne     $i16, -1, be_else.35977
be_then.35977:
	ret
be_else.35977:
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
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i17
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35978
be_then.35978:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35978:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35979
be_then.35979:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35979:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35980
be_then.35980:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35980:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35981
be_then.35981:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35981:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35982
be_then.35982:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35982:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35983
be_then.35983:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35983:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.35984
be_then.35984:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.35984:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
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
	bne     $i17, -1, be_else.35985
be_then.35985:
	ret
be_else.35985:
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
	bne     $i17, 99, be_else.35986
be_then.35986:
	load    [$i16 + 1], $i17
	be      $i17, -1, bne_cont.35987
bne_then.35987:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    solve_each_element.2871
	load    [$i16 + 2], $i17
	be      $i17, -1, bne_cont.35988
bne_then.35988:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 3], $i17
	be      $i17, -1, bne_cont.35989
bne_then.35989:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 4], $i17
	be      $i17, -1, bne_cont.35990
bne_then.35990:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 5], $i17
	be      $i17, -1, bne_cont.35991
bne_then.35991:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i16 + 6], $i17
	be      $i17, -1, bne_cont.35992
bne_then.35992:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network.2875
bne_cont.35992:
bne_cont.35991:
bne_cont.35990:
bne_cont.35989:
bne_cont.35988:
bne_cont.35987:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i16], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.35993
be_then.35993:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.35993:
	bne     $i18, 99, be_else.35994
be_then.35994:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.35995
be_then.35995:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2879
be_else.35995:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.35996
be_then.35996:
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
be_else.35996:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.35997
be_then.35997:
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
be_else.35997:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2871
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.35998
be_then.35998:
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
be_else.35998:
.count stack_store
	store   $i16, [$sp + 4]
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
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
be_else.35994:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i18, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.35999
be_then.35999:
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
be_else.35999:
	bg      $fg7, $fg0, ble_else.36000
ble_then.36000:
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
ble_else.36000:
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
be_else.35986:
.count move_args
	mov     $i17, $i2
.count move_args
	mov     $i4, $i3
	call    solver.2773
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.36001
be_then.36001:
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
be_else.36001:
	bg      $fg7, $fg0, ble_else.36002
ble_then.36002:
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
ble_else.36002:
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
	bne     $i10, -1, be_else.36003
be_then.36003:
	ret
be_else.36003:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 10], $i12
	load    [$i4 + 1], $i13
	load    [$i11 + 1], $i14
	load    [$i12 + 0], $f10
	load    [$i12 + 1], $f11
	load    [$i12 + 2], $f12
	load    [$i13 + $i10], $i13
	bne     $i14, 1, be_else.36004
be_then.36004:
	load    [$i4 + 0], $i12
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f13
	load    [$i12 + 1], $f14
	load    [$i13 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i13 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f11, $f14
	bg      $f13, $f14, ble_else.36005
ble_then.36005:
	li      0, $i14
.count b_cont
	b       ble_cont.36005
ble_else.36005:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.36006
ble_then.36006:
	li      0, $i14
.count b_cont
	b       ble_cont.36006
ble_else.36006:
	load    [$i13 + 1], $f13
	bne     $f13, $f0, be_else.36007
be_then.36007:
	li      0, $i14
.count b_cont
	b       be_cont.36007
be_else.36007:
	li      1, $i14
be_cont.36007:
ble_cont.36006:
ble_cont.36005:
	bne     $i14, 0, be_else.36008
be_then.36008:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i12 + 0], $f14
	load    [$i13 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i13 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f10, $f14
	bg      $f13, $f14, ble_else.36009
ble_then.36009:
	li      0, $i14
.count b_cont
	b       ble_cont.36009
ble_else.36009:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd_a  $f14, $f12, $f14
	bg      $f13, $f14, ble_else.36010
ble_then.36010:
	li      0, $i14
.count b_cont
	b       ble_cont.36010
ble_else.36010:
	load    [$i13 + 3], $f13
	bne     $f13, $f0, be_else.36011
be_then.36011:
	li      0, $i14
.count b_cont
	b       be_cont.36011
be_else.36011:
	li      1, $i14
be_cont.36011:
ble_cont.36010:
ble_cont.36009:
	bne     $i14, 0, be_else.36012
be_then.36012:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i12 + 0], $f14
	load    [$i13 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i13 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd_a  $f14, $f10, $f10
	bg      $f13, $f10, ble_else.36013
ble_then.36013:
	li      0, $i11
.count b_cont
	b       be_cont.36004
ble_else.36013:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i12 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd_a  $f13, $f11, $f11
	bg      $f10, $f11, ble_else.36014
ble_then.36014:
	li      0, $i11
.count b_cont
	b       be_cont.36004
ble_else.36014:
	load    [$i13 + 5], $f10
	bne     $f10, $f0, be_else.36015
be_then.36015:
	li      0, $i11
.count b_cont
	b       be_cont.36004
be_else.36015:
	mov     $f12, $fg0
	li      3, $i11
.count b_cont
	b       be_cont.36004
be_else.36012:
	mov     $f15, $fg0
	li      2, $i11
.count b_cont
	b       be_cont.36004
be_else.36008:
	mov     $f15, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36004
be_else.36004:
	bne     $i14, 2, be_else.36016
be_then.36016:
	load    [$i13 + 0], $f10
	bg      $f0, $f10, ble_else.36017
ble_then.36017:
	li      0, $i11
.count b_cont
	b       be_cont.36016
ble_else.36017:
	load    [$i12 + 3], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36016
be_else.36016:
	load    [$i13 + 0], $f13
	bne     $f13, $f0, be_else.36018
be_then.36018:
	li      0, $i11
.count b_cont
	b       be_cont.36018
be_else.36018:
	load    [$i13 + 1], $f14
	fmul    $f14, $f10, $f10
	load    [$i13 + 2], $f14
	fmul    $f14, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i13 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	fmul    $f10, $f10, $f11
	load    [$i12 + 3], $f12
	fmul    $f13, $f12, $f12
	fsub    $f11, $f12, $f11
	bg      $f11, $f0, ble_else.36019
ble_then.36019:
	li      0, $i11
.count b_cont
	b       ble_cont.36019
ble_else.36019:
	load    [$i11 + 6], $i11
	fsqrt   $f11, $f11
	bne     $i11, 0, be_else.36020
be_then.36020:
	fsub    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i11
.count b_cont
	b       be_cont.36020
be_else.36020:
	fadd    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $fg0
	li      1, $i11
be_cont.36020:
ble_cont.36019:
be_cont.36018:
be_cont.36016:
be_cont.36004:
	bne     $i11, 0, be_else.36021
be_then.36021:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.36022
be_then.36022:
	ret
be_else.36022:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
be_else.36021:
	bg      $fg0, $f0, ble_else.36023
ble_then.36023:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
ble_else.36023:
	load    [$i4 + 0], $i12
	bg      $fg7, $fg0, ble_else.36024
ble_then.36024:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2885
ble_else.36024:
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
	li      0, $i2
	load    [$i12 + 0], $f10
	fadd    $fg0, $fc16, $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg8, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i12 + 1], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg9, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i12 + 2], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $fg10, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2856
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.36025
be_then.36025:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2885
be_else.36025:
	mov     $f11, $fg7
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
	mov     $i10, $ig5
	mov     $i11, $ig4
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
	bne     $i15, -1, be_else.36026
be_then.36026:
	ret
be_else.36026:
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
	li      0, $i2
	load    [min_caml_and_net + $i15], $i3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36027
be_then.36027:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36027:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36028
be_then.36028:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36028:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36029
be_then.36029:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36029:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36030
be_then.36030:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36030:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36031
be_then.36031:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36031:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36032
be_then.36032:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36032:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.36033
be_then.36033:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.36033:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
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
	bne     $i16, -1, be_else.36034
be_then.36034:
	ret
be_else.36034:
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
	bne     $i16, 99, be_else.36035
be_then.36035:
	load    [$i15 + 1], $i16
	be      $i16, -1, bne_cont.36036
bne_then.36036:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
	call    solve_each_element_fast.2885
	load    [$i15 + 2], $i16
	be      $i16, -1, bne_cont.36037
bne_then.36037:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 3], $i16
	be      $i16, -1, bne_cont.36038
bne_then.36038:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 4], $i16
	be      $i16, -1, bne_cont.36039
bne_then.36039:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 5], $i16
	be      $i16, -1, bne_cont.36040
bne_then.36040:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i15 + 6], $i16
	be      $i16, -1, bne_cont.36041
bne_then.36041:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i15, $i3
	call    solve_one_or_network_fast.2889
bne_cont.36041:
bne_cont.36040:
bne_cont.36039:
bne_cont.36038:
bne_cont.36037:
bne_cont.36036:
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i15], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.36042
be_then.36042:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36042:
	bne     $i17, 99, be_else.36043
be_then.36043:
	load    [$i16 + 1], $i17
	bne     $i17, -1, be_else.36044
be_then.36044:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2893
be_else.36044:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 2], $i17
	bne     $i17, -1, be_else.36045
be_then.36045:
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
be_else.36045:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 3], $i17
	bne     $i17, -1, be_else.36046
be_then.36046:
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
be_else.36046:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2885
	load    [$i16 + 4], $i17
	bne     $i17, -1, be_else.36047
be_then.36047:
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
be_else.36047:
.count stack_store
	store   $i15, [$sp + 4]
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
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
be_else.36043:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i17, $i2
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36048
be_then.36048:
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
be_else.36048:
	bg      $fg7, $fg0, ble_else.36049
ble_then.36049:
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
ble_else.36049:
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
be_else.36035:
.count move_args
	mov     $i16, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2814
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.36050
be_then.36050:
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
be_else.36050:
	bg      $fg7, $fg0, ble_else.36051
ble_then.36051:
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
ble_else.36051:
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
	bne     $i1, 1, be_else.36052
be_then.36052:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
	load    [min_caml_intersection_point + 0], $f10
	load    [$i1 + 0], $f11
.count load_float
	load    [f.31965], $f12
	fsub    $f10, $f11, $f10
	fmul    $f10, $f12, $f2
	call    min_caml_floor
.count move_ret
	mov     $f1, $f11
.count load_float
	load    [f.31966], $f13
.count load_float
	load    [f.31967], $f14
	fmul    $f11, $f13, $f11
	fsub    $f10, $f11, $f10
	load    [min_caml_intersection_point + 2], $f11
	load    [$i10 + 2], $f15
	fsub    $f11, $f15, $f11
	fmul    $f11, $f12, $f2
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	fmul    $f1, $f13, $f1
	fsub    $f11, $f1, $f1
	bg      $f14, $f10, ble_else.36053
ble_then.36053:
	li      0, $i1
.count b_cont
	b       ble_cont.36053
ble_else.36053:
	li      1, $i1
ble_cont.36053:
	bg      $f14, $f1, ble_else.36054
ble_then.36054:
	bne     $i1, 0, be_else.36055
be_then.36055:
	mov     $fc9, $fg11
	ret
be_else.36055:
	mov     $f0, $fg11
	ret
ble_else.36054:
	bne     $i1, 0, be_else.36056
be_then.36056:
	mov     $f0, $fg11
	ret
be_else.36056:
	mov     $fc9, $fg11
	ret
be_else.36052:
	bne     $i1, 2, be_else.36057
be_then.36057:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [min_caml_intersection_point + 1], $f10
.count load_float
	load    [f.31964], $f11
	fmul    $f10, $f11, $f2
	call    min_caml_sin
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	fmul    $f1, $f1, $f1
	fmul    $fc9, $f1, $fg16
	fsub    $fc0, $f1, $f1
	fmul    $fc9, $f1, $fg11
	ret
be_else.36057:
	bne     $i1, 3, be_else.36058
be_then.36058:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
	load    [min_caml_intersection_point + 0], $f10
	load    [$i1 + 0], $f11
	fsub    $f10, $f11, $f10
	fmul    $f10, $f10, $f10
	load    [min_caml_intersection_point + 2], $f11
	load    [$i10 + 2], $f12
	fsub    $f11, $f12, $f11
	fmul    $f11, $f11, $f11
	fadd    $f10, $f11, $f10
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
	add     $sp, 3, $sp
	fmul    $f1, $f1, $f1
	fmul    $f1, $fc9, $fg11
	fsub    $fc0, $f1, $f1
	fmul    $f1, $fc9, $fg15
	ret
be_else.36058:
	bne     $i1, 4, be_else.36059
be_then.36059:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 2]
	load    [$i2 + 5], $i1
	load    [$i2 + 4], $i10
	load    [$i2 + 5], $i11
	load    [$i2 + 4], $i12
.count load_float
	load    [f.31955], $f10
	load    [min_caml_intersection_point + 0], $f11
	load    [$i1 + 0], $f12
	fsub    $f11, $f12, $f11
	load    [$i10 + 0], $f12
	fsqrt   $f12, $f12
	fmul    $f11, $f12, $f11
	fabs    $f11, $f12
	load    [min_caml_intersection_point + 2], $f13
	load    [$i11 + 2], $f14
	fsub    $f13, $f14, $f13
	load    [$i12 + 2], $f14
	fsqrt   $f14, $f14
	fmul    $f13, $f14, $f13
	bg      $f10, $f12, ble_else.36060
ble_then.36060:
	finv    $f11, $f12
	fmul_a  $f13, $f12, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f12
	fmul    $f12, $fc18, $f12
	fmul    $f12, $fc17, $f12
.count b_cont
	b       ble_cont.36060
ble_else.36060:
	mov     $fc19, $f12
ble_cont.36060:
.count stack_load
	load    [$sp + 2], $i1
	load    [$i1 + 5], $i10
	load    [$i1 + 4], $i1
	fmul    $f11, $f11, $f11
	fmul    $f13, $f13, $f13
	fadd    $f11, $f13, $f11
	fabs    $f11, $f13
	load    [min_caml_intersection_point + 1], $f14
	load    [$i10 + 1], $f15
	fsub    $f14, $f15, $f14
	load    [$i1 + 1], $f15
	fsqrt   $f15, $f15
	fmul    $f14, $f15, $f14
	bg      $f10, $f13, ble_else.36061
ble_then.36061:
	finv    $f11, $f10
	fmul_a  $f14, $f10, $f2
	call    min_caml_atan
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $fc18, $f10
	fmul    $f10, $fc17, $f10
.count b_cont
	b       ble_cont.36061
ble_else.36061:
	mov     $fc19, $f10
ble_cont.36061:
.count load_float
	load    [f.31960], $f11
.count move_args
	mov     $f12, $f2
	call    min_caml_floor
.count move_ret
	mov     $f1, $f13
	fsub    $f12, $f13, $f12
	fsub    $fc3, $f12, $f12
	fmul    $f12, $f12, $f12
	fsub    $f11, $f12, $f11
.count move_args
	mov     $f10, $f2
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	fsub    $f10, $f1, $f1
	fsub    $fc3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f11, $f1, $f1
	bg      $f0, $f1, ble_else.36062
ble_then.36062:
	fmul    $fc9, $f1, $f1
.count load_float
	load    [f.31962], $f2
	fmul    $f1, $f2, $fg15
	ret
ble_else.36062:
	mov     $f0, $fg15
	ret
be_else.36059:
	ret
.end utexture

######################################################################
# trace_reflections
######################################################################
.begin trace_reflections
trace_reflections.2915:
	bl      $i2, 0, bge_else.36063
bge_then.36063:
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
	load    [$ig2 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.36064
bne_then.36064:
	bne     $i21, 99, be_else.36065
be_then.36065:
	load    [$i20 + 1], $i21
	bne     $i21, -1, be_else.36066
be_then.36066:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36065
be_else.36066:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36067
be_then.36067:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36065
be_else.36067:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36068
be_then.36068:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36065
be_else.36068:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2885
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.36069
be_then.36069:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36065
be_else.36069:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
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
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36065
be_else.36065:
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
	bne     $i21, 0, be_else.36070
be_then.36070:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36070
be_else.36070:
	bg      $fg7, $fg0, ble_else.36071
ble_then.36071:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36071
ble_else.36071:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
ble_cont.36071:
be_cont.36070:
be_cont.36065:
bne_cont.36064:
	bg      $fg7, $fc7, ble_else.36072
ble_then.36072:
	li      0, $i22
.count b_cont
	b       ble_cont.36072
ble_else.36072:
	bg      $fc13, $fg7, ble_else.36073
ble_then.36073:
	li      0, $i22
.count b_cont
	b       ble_cont.36073
ble_else.36073:
	li      1, $i22
ble_cont.36073:
ble_cont.36072:
	bne     $i22, 0, be_else.36074
be_then.36074:
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
be_else.36074:
	load    [$i19 + 0], $i22
	add     $ig5, $ig5, $i23
	add     $i23, $i23, $i23
	add     $i23, $ig4, $i23
	bne     $i23, $i22, be_else.36075
be_then.36075:
.count stack_store
	store   $i19, [$sp + 6]
	li      0, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 4], $f2
	bne     $i1, 0, be_else.36076
be_then.36076:
.count stack_load
	load    [$sp - 1], $i1
	load    [$i1 + 2], $f1
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 0], $i1
	fmul    $f1, $f2, $f3
	load    [min_caml_nvector + 0], $f4
	load    [$i1 + 0], $f5
	fmul    $f4, $f5, $f4
	load    [min_caml_nvector + 1], $f6
	load    [$i1 + 1], $f7
	fmul    $f6, $f7, $f6
	fadd    $f4, $f6, $f4
	load    [min_caml_nvector + 2], $f6
	load    [$i1 + 2], $f8
	fmul    $f6, $f8, $f6
	fadd    $f4, $f6, $f4
	fmul    $f3, $f4, $f3
	ble     $f3, $f0, bg_cont.36077
bg_then.36077:
	fmul    $f3, $fg16, $f4
	fadd    $fg4, $f4, $fg4
	fmul    $f3, $fg11, $f4
	fadd    $fg5, $f4, $fg5
	fmul    $f3, $fg15, $f3
	fadd    $fg6, $f3, $fg6
bg_cont.36077:
.count stack_load
	load    [$sp - 6], $i3
	load    [$i3 + 0], $f3
	fmul    $f3, $f5, $f3
	load    [$i3 + 1], $f4
	fmul    $f4, $f7, $f4
	fadd    $f3, $f4, $f3
	load    [$i3 + 2], $f4
	fmul    $f4, $f8, $f4
	fadd    $f3, $f4, $f3
	fmul    $f1, $f3, $f1
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
be_else.36076:
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 6], $i3
	b       trace_reflections.2915
be_else.36075:
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
bge_else.36063:
	ret
.end trace_reflections

######################################################################
# trace_ray
######################################################################
.begin trace_ray
trace_ray.2920:
	bg      $i2, 4, ble_else.36079
ble_then.36079:
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
	load    [$ig2 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.36080
bne_then.36080:
	bne     $i21, 99, be_else.36081
be_then.36081:
	load    [$i20 + 1], $i21
.count move_args
	mov     $i3, $i4
	bne     $i21, -1, be_else.36082
be_then.36082:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36081
be_else.36082:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i16
.count move_args
	mov     $i16, $i3
	call    solve_each_element.2871
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36083
be_then.36083:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36081
be_else.36083:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element.2871
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36084
be_then.36084:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36081
be_else.36084:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element.2871
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.36085
be_then.36085:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36081
be_else.36085:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
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
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36081
be_else.36081:
.count move_args
	mov     $i21, $i2
	call    solver.2773
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 3], $i4
	li      1, $i2
	bne     $i21, 0, be_else.36086
be_then.36086:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36086
be_else.36086:
	bg      $fg7, $fg0, ble_else.36087
ble_then.36087:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.36087
ble_else.36087:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network.2875
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix.2879
ble_cont.36087:
be_cont.36086:
be_cont.36081:
bne_cont.36080:
.count stack_load
	load    [$sp + 5], $i13
	load    [$i13 + 2], $i14
	bg      $fg7, $fc7, ble_else.36088
ble_then.36088:
	li      0, $i15
.count b_cont
	b       ble_cont.36088
ble_else.36088:
	bg      $fc13, $fg7, ble_else.36089
ble_then.36089:
	li      0, $i15
.count b_cont
	b       ble_cont.36089
ble_else.36089:
	li      1, $i15
ble_cont.36089:
ble_cont.36088:
	bne     $i15, 0, be_else.36090
be_then.36090:
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
	bne     $i2, 0, be_else.36091
be_then.36091:
	ret
be_else.36091:
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
	bg      $f1, $f0, ble_else.36092
ble_then.36092:
	ret
ble_else.36092:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
.count stack_load
	load    [$sp - 8], $f2
	fmul    $f1, $f2, $f1
	load    [min_caml_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $fg4, $f1, $fg4
	fadd    $fg5, $f1, $fg5
	fadd    $fg6, $f1, $fg6
	ret
be_else.36090:
.count stack_store
	store   $i14, [$sp + 6]
	load    [min_caml_objects + $ig5], $i2
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 1], $i15
	bne     $i15, 1, be_else.36093
be_then.36093:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $ig4, 1, $i15
.count stack_load
	load    [$sp + 3], $i16
	load    [$i16 + $i15], $f16
	bne     $f16, $f0, be_else.36094
be_then.36094:
	store   $f0, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36093
be_else.36094:
	bg      $f16, $f0, ble_else.36095
ble_then.36095:
	store   $fc0, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36093
ble_else.36095:
	store   $fc4, [min_caml_nvector + $i15]
.count b_cont
	b       be_cont.36093
be_else.36093:
	bne     $i15, 2, be_else.36096
be_then.36096:
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
	b       be_cont.36096
be_else.36096:
	load    [$i2 + 3], $i15
	load    [$i2 + 4], $i16
	load    [$i16 + 0], $f16
	load    [min_caml_intersection_point + 0], $f17
	load    [$i2 + 5], $i16
	load    [$i16 + 0], $f18
	fsub    $f17, $f18, $f17
	fmul    $f17, $f16, $f16
	load    [$i2 + 4], $i16
	load    [$i16 + 1], $f18
	load    [min_caml_intersection_point + 1], $f9
	load    [$i2 + 5], $i16
	load    [$i16 + 1], $f10
	fsub    $f9, $f10, $f9
	fmul    $f9, $f18, $f18
	load    [$i2 + 4], $i16
	load    [$i16 + 2], $f10
	load    [min_caml_intersection_point + 2], $f11
	load    [$i2 + 5], $i16
	load    [$i16 + 2], $f12
	fsub    $f11, $f12, $f11
	fmul    $f11, $f10, $f10
	bne     $i15, 0, be_else.36097
be_then.36097:
	store   $f16, [min_caml_nvector + 0]
	store   $f18, [min_caml_nvector + 1]
	store   $f10, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36097
be_else.36097:
	load    [$i2 + 9], $i15
	load    [$i15 + 2], $f12
	fmul    $f9, $f12, $f12
	load    [$i2 + 9], $i15
	load    [$i15 + 1], $f13
	fmul    $f11, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f16, $f12, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [$i2 + 9], $i15
	load    [$i15 + 2], $f16
	fmul    $f17, $f16, $f16
	load    [$i2 + 9], $i15
	load    [$i15 + 0], $f12
	fmul    $f11, $f12, $f11
	fadd    $f16, $f11, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f18, $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 9], $i15
	load    [$i15 + 1], $f16
	fmul    $f17, $f16, $f16
	load    [$i2 + 9], $i15
	load    [$i15 + 0], $f17
	fmul    $f9, $f17, $f17
	fadd    $f16, $f17, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f10, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36097:
	load    [min_caml_nvector + 0], $f16
	load    [$i2 + 6], $i15
	fmul    $f16, $f16, $f17
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f18, $f18
	fadd    $f17, $f18, $f17
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f18, $f18
	fadd    $f17, $f18, $f17
	fsqrt   $f17, $f17
	bne     $f17, $f0, be_else.36098
be_then.36098:
	mov     $fc0, $f17
.count b_cont
	b       be_cont.36098
be_else.36098:
	bne     $i15, 0, be_else.36099
be_then.36099:
	finv    $f17, $f17
.count b_cont
	b       be_cont.36099
be_else.36099:
	finv_n  $f17, $f17
be_cont.36099:
be_cont.36098:
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f16
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f16
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36096:
be_cont.36093:
	load    [min_caml_intersection_point + 0], $fg21
	load    [min_caml_intersection_point + 1], $fg22
	load    [min_caml_intersection_point + 2], $fg23
	call    utexture.2908
	add     $ig5, $ig5, $i10
	add     $i10, $i10, $i10
	add     $i10, $ig4, $i10
.count stack_load
	load    [$sp + 4], $i11
.count storer
	add     $i14, $i11, $tmp
	store   $i10, [$tmp + 0]
	load    [$i13 + 1], $i10
	load    [$i10 + $i11], $i10
	load    [min_caml_intersection_point + 0], $f10
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
	bg      $fc3, $f10, ble_else.36100
ble_then.36100:
	li      1, $i10
	store   $i10, [$tmp + 0]
	load    [$i13 + 4], $i10
	load    [$i10 + $i11], $i12
	store   $fg16, [$i12 + 0]
	store   $fg11, [$i12 + 1]
	store   $fg15, [$i12 + 2]
	load    [$i10 + $i11], $i10
.count load_float
	load    [f.31970], $f10
.count load_float
	load    [f.31971], $f10
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
	b       ble_cont.36100
ble_else.36100:
	li      0, $i10
	store   $i10, [$tmp + 0]
ble_cont.36100:
	load    [min_caml_nvector + 0], $f10
.count load_float
	load    [f.31972], $f11
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f12
	fmul    $f12, $f10, $f13
	load    [$i10 + 1], $f14
	load    [min_caml_nvector + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	load    [$i10 + 2], $f14
	load    [min_caml_nvector + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f11, $f13, $f11
	fmul    $f11, $f10, $f10
	fadd    $f12, $f10, $f10
	store   $f10, [$i10 + 0]
	load    [$i10 + 1], $f10
	load    [min_caml_nvector + 1], $f12
	fmul    $f11, $f12, $f12
	fadd    $f10, $f12, $f10
	store   $f10, [$i10 + 1]
	load    [$i10 + 2], $f10
	load    [min_caml_nvector + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	store   $f10, [$i10 + 2]
	load    [$ig2 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.36101
be_then.36101:
	li      0, $i10
.count b_cont
	b       be_cont.36101
be_else.36101:
.count stack_store
	store   $i10, [$sp + 9]
	bne     $i2, 99, be_else.36102
be_then.36102:
	li      1, $i22
.count b_cont
	b       be_cont.36102
be_else.36102:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36103
be_then.36103:
	li      0, $i22
.count b_cont
	b       be_cont.36103
be_else.36103:
	bg      $fc7, $fg0, ble_else.36104
ble_then.36104:
	li      0, $i22
.count b_cont
	b       ble_cont.36104
ble_else.36104:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.36105
be_then.36105:
	li      0, $i22
.count b_cont
	b       be_cont.36105
be_else.36105:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36106
be_then.36106:
.count stack_load
	load    [$sp + 9], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36107
be_then.36107:
	li      0, $i22
.count b_cont
	b       be_cont.36106
be_else.36107:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36108
be_then.36108:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36109
be_then.36109:
	li      0, $i22
.count b_cont
	b       be_cont.36106
be_else.36109:
	li      1, $i22
.count b_cont
	b       be_cont.36106
be_else.36108:
	li      1, $i22
.count b_cont
	b       be_cont.36106
be_else.36106:
	li      1, $i22
be_cont.36106:
be_cont.36105:
ble_cont.36104:
be_cont.36103:
be_cont.36102:
	bne     $i22, 0, be_else.36110
be_then.36110:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36110
be_else.36110:
.count stack_load
	load    [$sp + 9], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.36111
be_then.36111:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36111
be_else.36111:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36112
be_then.36112:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.36113
be_then.36113:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36112
be_else.36113:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36114
be_then.36114:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36115
be_then.36115:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36112
be_else.36115:
	li      1, $i10
.count b_cont
	b       be_cont.36112
be_else.36114:
	li      1, $i10
.count b_cont
	b       be_cont.36112
be_else.36112:
	li      1, $i10
be_cont.36112:
be_cont.36111:
be_cont.36110:
be_cont.36101:
.count stack_load
	load    [$sp + 7], $i11
	load    [$i11 + 7], $i11
	load    [$i11 + 1], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f11, $f10, $f10
	bne     $i10, 0, be_cont.36116
be_then.36116:
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
	ble     $f11, $f0, bg_cont.36117
bg_then.36117:
	fmul    $f11, $fg16, $f13
	fadd    $fg4, $f13, $fg4
	fmul    $f11, $fg11, $f13
	fadd    $fg5, $f13, $fg5
	fmul    $f11, $fg15, $f11
	fadd    $fg6, $f11, $fg6
bg_cont.36117:
	ble     $f12, $f0, bg_cont.36118
bg_then.36118:
	fmul    $f12, $f12, $f11
	fmul    $f11, $f11, $f11
	fmul    $f11, $f10, $f11
	fadd    $fg4, $f11, $fg4
	fadd    $fg5, $f11, $fg5
	fadd    $fg6, $f11, $fg6
bg_cont.36118:
be_cont.36116:
	li      min_caml_intersection_point, $i2
	load    [min_caml_intersection_point + 0], $fg8
	load    [min_caml_intersection_point + 1], $fg9
	load    [min_caml_intersection_point + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	sub     $ig6, 1, $i2
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
	bg      $f1, $fc8, ble_else.36119
ble_then.36119:
	ret
ble_else.36119:
.count stack_load
	load    [$sp - 6], $i1
	bge     $i1, 4, bl_cont.36120
bl_then.36120:
	add     $i1, 1, $i1
	add     $i0, -1, $i2
.count stack_load
	load    [$sp - 4], $i3
.count storer
	add     $i3, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.36120:
.count stack_load
	load    [$sp - 3], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.36121
be_then.36121:
	load    [$i1 + 7], $i1
.count stack_load
	load    [$sp - 9], $f2
	fadd    $f2, $fg7, $f3
.count stack_load
	load    [$sp - 6], $i2
	add     $i2, 1, $i2
	load    [$i1 + 0], $f2
	fsub    $fc0, $f2, $f2
	fmul    $f1, $f2, $f2
.count stack_load
	load    [$sp - 7], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       trace_ray.2920
be_else.36121:
	ret
ble_else.36079:
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
	load    [$ig2 + 0], $i19
	load    [$i19 + 0], $i20
	be      $i20, -1, bne_cont.36122
bne_then.36122:
	bne     $i20, 99, be_else.36123
be_then.36123:
	load    [$i19 + 1], $i20
.count move_args
	mov     $i2, $i4
	bne     $i20, -1, be_else.36124
be_then.36124:
	li      1, $i19
.count move_args
	mov     $ig2, $i3
.count move_args
	mov     $i19, $i2
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36123
be_else.36124:
	li      0, $i15
	load    [min_caml_and_net + $i20], $i3
.count move_args
	mov     $i15, $i2
	call    solve_each_element_fast.2885
	load    [$i19 + 2], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36125
be_then.36125:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36123
be_else.36125:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2885
	load    [$i19 + 3], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36126
be_then.36126:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36123
be_else.36126:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2885
	load    [$i19 + 4], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.36127
be_then.36127:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36123
be_else.36127:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
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
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36123
be_else.36123:
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
	bne     $i20, 0, be_else.36128
be_then.36128:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36128
be_else.36128:
	bg      $fg7, $fg0, ble_else.36129
ble_then.36129:
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36129
ble_else.36129:
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2889
	li      1, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $ig2, $i3
	call    trace_or_matrix_fast.2893
ble_cont.36129:
be_cont.36128:
be_cont.36123:
bne_cont.36122:
	bg      $fg7, $fc7, ble_else.36130
ble_then.36130:
	li      0, $i13
.count b_cont
	b       ble_cont.36130
ble_else.36130:
	bg      $fc13, $fg7, ble_else.36131
ble_then.36131:
	li      0, $i13
.count b_cont
	b       ble_cont.36131
ble_else.36131:
	li      1, $i13
ble_cont.36131:
ble_cont.36130:
	bne     $i13, 0, be_else.36132
be_then.36132:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36132:
.count stack_load
	load    [$sp + 2], $i13
	load    [$i13 + 0], $i13
	load    [min_caml_objects + $ig5], $i2
.count stack_store
	store   $i2, [$sp + 3]
	load    [$i2 + 1], $i14
	bne     $i14, 1, be_else.36133
be_then.36133:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $ig4, 1, $i14
	load    [$i13 + $i14], $f16
	bne     $f16, $f0, be_else.36134
be_then.36134:
	store   $f0, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36133
be_else.36134:
	bg      $f16, $f0, ble_else.36135
ble_then.36135:
	store   $fc0, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36133
ble_else.36135:
	store   $fc4, [min_caml_nvector + $i14]
.count b_cont
	b       be_cont.36133
be_else.36133:
	bne     $i14, 2, be_else.36136
be_then.36136:
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
	b       be_cont.36136
be_else.36136:
	load    [$i2 + 3], $i13
	load    [$i2 + 4], $i14
	load    [$i14 + 0], $f16
	load    [min_caml_intersection_point + 0], $f17
	load    [$i2 + 5], $i14
	load    [$i14 + 0], $f18
	fsub    $f17, $f18, $f17
	fmul    $f17, $f16, $f16
	load    [$i2 + 4], $i14
	load    [$i14 + 1], $f18
	load    [min_caml_intersection_point + 1], $f9
	load    [$i2 + 5], $i14
	load    [$i14 + 1], $f10
	fsub    $f9, $f10, $f9
	fmul    $f9, $f18, $f18
	load    [$i2 + 4], $i14
	load    [$i14 + 2], $f10
	load    [min_caml_intersection_point + 2], $f11
	load    [$i2 + 5], $i14
	load    [$i14 + 2], $f12
	fsub    $f11, $f12, $f11
	fmul    $f11, $f10, $f10
	bne     $i13, 0, be_else.36137
be_then.36137:
	store   $f16, [min_caml_nvector + 0]
	store   $f18, [min_caml_nvector + 1]
	store   $f10, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36137
be_else.36137:
	load    [$i2 + 9], $i13
	load    [$i13 + 2], $f12
	fmul    $f9, $f12, $f12
	load    [$i2 + 9], $i13
	load    [$i13 + 1], $f13
	fmul    $f11, $f13, $f13
	fadd    $f12, $f13, $f12
	fmul    $f12, $fc3, $f12
	fadd    $f16, $f12, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [$i2 + 9], $i13
	load    [$i13 + 2], $f16
	fmul    $f17, $f16, $f16
	load    [$i2 + 9], $i13
	load    [$i13 + 0], $f12
	fmul    $f11, $f12, $f11
	fadd    $f16, $f11, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f18, $f16, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [$i2 + 9], $i13
	load    [$i13 + 1], $f16
	fmul    $f17, $f16, $f16
	load    [$i2 + 9], $i13
	load    [$i13 + 0], $f17
	fmul    $f9, $f17, $f17
	fadd    $f16, $f17, $f16
	fmul    $f16, $fc3, $f16
	fadd    $f10, $f16, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36137:
	load    [min_caml_nvector + 0], $f16
	load    [$i2 + 6], $i13
	fmul    $f16, $f16, $f17
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f18, $f18
	fadd    $f17, $f18, $f17
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f18, $f18
	fadd    $f17, $f18, $f17
	fsqrt   $f17, $f17
	bne     $f17, $f0, be_else.36138
be_then.36138:
	mov     $fc0, $f17
.count b_cont
	b       be_cont.36138
be_else.36138:
	bne     $i13, 0, be_else.36139
be_then.36139:
	finv    $f17, $f17
.count b_cont
	b       be_cont.36139
be_else.36139:
	finv_n  $f17, $f17
be_cont.36139:
be_cont.36138:
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f16
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f16
	fmul    $f16, $f17, $f16
	store   $f16, [min_caml_nvector + 2]
be_cont.36136:
be_cont.36133:
	call    utexture.2908
	load    [$ig2 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.36140
be_then.36140:
	li      0, $i1
.count b_cont
	b       be_cont.36140
be_else.36140:
.count stack_store
	store   $i10, [$sp + 4]
	bne     $i2, 99, be_else.36141
be_then.36141:
	li      1, $i22
.count b_cont
	b       be_cont.36141
be_else.36141:
	call    solver_fast.2796
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36142
be_then.36142:
	li      0, $i22
.count b_cont
	b       be_cont.36142
be_else.36142:
	bg      $fc7, $fg0, ble_else.36143
ble_then.36143:
	li      0, $i22
.count b_cont
	b       ble_cont.36143
ble_else.36143:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.36144
be_then.36144:
	li      0, $i22
.count b_cont
	b       be_cont.36144
be_else.36144:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.36145
be_then.36145:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.36146
be_then.36146:
	li      0, $i22
.count b_cont
	b       be_cont.36145
be_else.36146:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36147
be_then.36147:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36148
be_then.36148:
	li      0, $i22
.count b_cont
	b       be_cont.36145
be_else.36148:
	li      1, $i22
.count b_cont
	b       be_cont.36145
be_else.36147:
	li      1, $i22
.count b_cont
	b       be_cont.36145
be_else.36145:
	li      1, $i22
be_cont.36145:
be_cont.36144:
ble_cont.36143:
be_cont.36142:
be_cont.36141:
	bne     $i22, 0, be_else.36149
be_then.36149:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36149
be_else.36149:
.count stack_load
	load    [$sp + 4], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.36150
be_then.36150:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36150
be_else.36150:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36151
be_then.36151:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.36152
be_then.36152:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36151
be_else.36152:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.36153
be_then.36153:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36154
be_then.36154:
	li      1, $i2
.count move_args
	mov     $ig2, $i3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36151
be_else.36154:
	li      1, $i1
.count b_cont
	b       be_cont.36151
be_else.36153:
	li      1, $i1
.count b_cont
	b       be_cont.36151
be_else.36151:
	li      1, $i1
be_cont.36151:
be_cont.36150:
be_cont.36149:
be_cont.36140:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	bne     $i1, 0, be_else.36155
be_then.36155:
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 7], $i1
	load    [min_caml_nvector + 0], $f1
	fmul    $f1, $fg12, $f1
	load    [min_caml_nvector + 1], $f2
	fmul    $f2, $fg13, $f2
	fadd    $f1, $f2, $f1
	load    [min_caml_nvector + 2], $f2
	fmul    $f2, $fg14, $f2
	fadd_n  $f1, $f2, $f1
	bg      $f1, $f0, ble_cont.36156
ble_then.36156:
	mov     $f0, $f1
ble_cont.36156:
.count stack_load
	load    [$sp - 4], $f2
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
be_else.36155:
	ret
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	bl      $i4, 0, bge_else.36157
bge_then.36157:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + $i4], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f1
	load    [$i3 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i24 + 1], $f2
	load    [$i3 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i24 + 2], $f2
	load    [$i3 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count stack_store
	store   $i4, [$sp + 3]
	bg      $f0, $f1, ble_else.36158
ble_then.36158:
	fmul    $f1, $fc1, $f2
	load    [$i2 + $i4], $i2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.36159
bge_then.36159:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
	load    [$i26 + 0], $f1
.count stack_load
	load    [$sp + 1], $i27
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
	bg      $f0, $f1, ble_else.36160
ble_then.36160:
	fmul    $f1, $fc1, $f2
	load    [$i25 + $i24], $i2
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
ble_else.36160:
	fmul    $f1, $fc2, $f2
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
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
bge_else.36159:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.36158:
	fmul    $f1, $fc2, $f2
	add     $i4, 1, $i24
	load    [$i2 + $i24], $i2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.36161
bge_then.36161:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
	load    [$i26 + 0], $f1
.count stack_load
	load    [$sp + 1], $i27
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
	bg      $f0, $f1, ble_else.36162
ble_then.36162:
	fmul    $f1, $fc1, $f2
	load    [$i25 + $i24], $i2
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
ble_else.36162:
	fmul    $f1, $fc2, $f2
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
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
bge_else.36161:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.36157:
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
	load    [$i2 + 7], $i10
	load    [$i2 + 1], $i11
	load    [$i2 + 6], $i12
	load    [$i10 + $i3], $i10
.count stack_store
	store   $i10, [$sp + 3]
	load    [$i11 + $i3], $i2
.count stack_store
	store   $i2, [$sp + 4]
	load    [$i12 + 0], $i11
.count stack_store
	store   $i11, [$sp + 5]
	be      $i11, 0, bne_cont.36163
bne_then.36163:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i11 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f10
	load    [$i10 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i10 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i10 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i11, [$sp + 6]
	bg      $f0, $f10, ble_else.36164
ble_then.36164:
	load    [$i11 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 3], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36164
ble_else.36164:
	load    [$i11 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 3], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36164:
bne_cont.36163:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 1, bne_cont.36165
bne_then.36165:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f10, ble_else.36166
ble_then.36166:
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
	b       ble_cont.36166
ble_else.36166:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36166:
bne_cont.36165:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 2, bne_cont.36167
bne_then.36167:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f10, ble_else.36168
ble_then.36168:
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
	b       ble_cont.36168
ble_else.36168:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36168:
bne_cont.36167:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 3, bne_cont.36169
bne_then.36169:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f10, ble_else.36170
ble_then.36170:
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
	b       ble_cont.36170
ble_else.36170:
	load    [$i10 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36170:
bne_cont.36169:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 4, bne_cont.36171
bne_then.36171:
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
	load    [$i24 + 0], $f1
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i24 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i24 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f1, ble_else.36172
ble_then.36172:
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
	b       ble_cont.36172
ble_else.36172:
	load    [$i10 + 119], $i2
	fmul    $f1, $fc2, $f2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36172:
bne_cont.36171:
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
	bg      $i3, 4, ble_else.36173
ble_then.36173:
	load    [$i2 + 2], $i28
	load    [$i28 + $i3], $i29
	bl      $i29, 0, bge_else.36174
bge_then.36174:
	load    [$i2 + 3], $i29
	load    [$i29 + $i3], $i30
	bne     $i30, 0, be_else.36175
be_then.36175:
	add     $i3, 1, $i3
	bg      $i3, 4, ble_else.36176
ble_then.36176:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.36177
bge_then.36177:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.36178
be_then.36178:
	add     $i3, 1, $i3
	b       do_without_neighbors.2951
be_else.36178:
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
bge_else.36177:
	ret
ble_else.36176:
	ret
be_else.36175:
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
	load    [$i2 + 7], $i10
	load    [$i2 + 1], $i11
	load    [$i2 + 6], $i12
	load    [$i10 + $i3], $i10
.count stack_store
	store   $i10, [$sp + 4]
	load    [$i11 + $i3], $i2
.count stack_store
	store   $i2, [$sp + 5]
	load    [$i12 + 0], $i11
.count stack_store
	store   $i11, [$sp + 6]
	be      $i11, 0, bne_cont.36179
bne_then.36179:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i11 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f10
	load    [$i10 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i10 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i10 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i11, [$sp + 7]
	bg      $f0, $f10, ble_else.36180
ble_then.36180:
	fmul    $f10, $fc1, $f2
	load    [$i11 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 4], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36180
ble_else.36180:
	fmul    $f10, $fc2, $f2
	load    [$i11 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 4], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36180:
bne_cont.36179:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 1, bne_cont.36181
bne_then.36181:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f10, ble_else.36182
ble_then.36182:
	fmul    $f10, $fc1, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36182
ble_else.36182:
	fmul    $f10, $fc2, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36182:
bne_cont.36181:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 2, bne_cont.36183
bne_then.36183:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f10, ble_else.36184
ble_then.36184:
	fmul    $f10, $fc1, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36184
ble_else.36184:
	fmul    $f10, $fc2, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36184:
bne_cont.36183:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 3, bne_cont.36185
bne_then.36185:
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
	load    [$i24 + 0], $f10
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i24 + 1], $f11
	load    [$i25 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i24 + 2], $f11
	load    [$i25 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f10, ble_else.36186
ble_then.36186:
	fmul    $f10, $fc1, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36186
ble_else.36186:
	fmul    $f10, $fc2, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36186:
bne_cont.36185:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 4, bne_cont.36187
bne_then.36187:
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
	load    [$i24 + 0], $f1
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i24 + 1], $f2
	load    [$i25 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i24 + 2], $f2
	load    [$i25 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i10, [$sp + 11]
	bg      $f0, $f1, ble_else.36188
ble_then.36188:
	fmul    $f1, $fc1, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36188
ble_else.36188:
	fmul    $f1, $fc2, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36188:
bne_cont.36187:
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
	bg      $i3, 4, ble_else.36189
ble_then.36189:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.36190
bge_then.36190:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.36191
be_then.36191:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	add     $i3, 1, $i3
	b       do_without_neighbors.2951
be_else.36191:
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
bge_else.36190:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.36189:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.36174:
	ret
ble_else.36173:
	ret
.end do_without_neighbors

######################################################################
# try_exploit_neighbors
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	bg      $i6, 4, ble_else.36192
ble_then.36192:
	load    [$i4 + $i2], $i32
	load    [$i32 + 2], $i33
	load    [$i33 + $i6], $i33
	bl      $i33, 0, bge_else.36193
bge_then.36193:
	load    [$i3 + $i2], $i34
	load    [$i34 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36194
be_then.36194:
	load    [$i5 + $i2], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36195
be_then.36195:
	sub     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36196
be_then.36196:
	add     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.36197
be_then.36197:
	li      1, $i33
.count b_cont
	b       be_cont.36194
be_else.36197:
	li      0, $i33
.count b_cont
	b       be_cont.36194
be_else.36196:
	li      0, $i33
.count b_cont
	b       be_cont.36194
be_else.36195:
	li      0, $i33
.count b_cont
	b       be_cont.36194
be_else.36194:
	li      0, $i33
be_cont.36194:
	bne     $i33, 0, be_else.36198
be_then.36198:
	bg      $i6, 4, ble_else.36199
ble_then.36199:
	load    [$i4 + $i2], $i2
	load    [$i2 + 2], $i32
	load    [$i32 + $i6], $i32
	bl      $i32, 0, bge_else.36200
bge_then.36200:
	load    [$i2 + 3], $i32
	load    [$i32 + $i6], $i32
	bne     $i32, 0, be_else.36201
be_then.36201:
	add     $i6, 1, $i3
	b       do_without_neighbors.2951
be_else.36201:
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
bge_else.36200:
	ret
ble_else.36199:
	ret
be_else.36198:
	load    [$i32 + 3], $i1
	load    [$i1 + $i6], $i1
	bne     $i1, 0, be_else.36202
be_then.36202:
	add     $i6, 1, $i6
	b       try_exploit_neighbors.2967
be_else.36202:
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
bge_else.36193:
	ret
ble_else.36192:
	ret
.end try_exploit_neighbors

######################################################################
# pretrace_diffuse_rays
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	bg      $i3, 4, ble_else.36203
ble_then.36203:
	load    [$i2 + 2], $i10
	load    [$i10 + $i3], $i11
	bl      $i11, 0, bge_else.36204
bge_then.36204:
	load    [$i2 + 3], $i11
	load    [$i11 + $i3], $i12
	bne     $i12, 0, be_else.36205
be_then.36205:
	add     $i3, 1, $i12
	bg      $i12, 4, ble_else.36206
ble_then.36206:
	load    [$i10 + $i12], $i10
	bl      $i10, 0, bge_else.36207
bge_then.36207:
	load    [$i11 + $i12], $i10
	bne     $i10, 0, be_else.36208
be_then.36208:
	add     $i12, 1, $i3
	b       pretrace_diffuse_rays.2980
be_else.36208:
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
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i13
	load    [$i13 + $i12], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i11 + $i12], $i26
	load    [$i25 + 0], $f1
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
	bg      $f0, $f1, ble_else.36209
ble_then.36209:
	fmul    $f1, $fc1, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36209
ble_else.36209:
	fmul    $f1, $fc2, $f2
	load    [$i24 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36209:
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
bge_else.36207:
	ret
ble_else.36206:
	ret
be_else.36205:
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
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
.count stack_store
	store   $i11, [$sp + 6]
	load    [$i2 + 1], $i12
.count stack_store
	store   $i12, [$sp + 7]
	load    [$i12 + $i3], $i2
	load    [$i2 + 0], $fg8
	load    [$i2 + 1], $fg9
	load    [$i2 + 2], $fg10
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f10
.count stack_load
	load    [$sp + 5], $i26
	load    [$i11 + $i26], $i26
	load    [$i26 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i25 + 1], $f11
	load    [$i26 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i25 + 2], $f11
	load    [$i26 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	bg      $f0, $f10, ble_else.36210
ble_then.36210:
	load    [$i24 + 118], $i2
	fmul    $f10, $fc1, $f2
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.36210
ble_else.36210:
	load    [$i24 + 119], $i2
	fmul    $f10, $fc2, $f2
	call    trace_diffuse_ray.2926
ble_cont.36210:
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
	bg      $i11, 4, ble_else.36211
ble_then.36211:
.count stack_load
	load    [$sp + 4], $i12
	load    [$i12 + $i11], $i12
	bl      $i12, 0, bge_else.36212
bge_then.36212:
.count stack_load
	load    [$sp + 3], $i12
	load    [$i12 + $i11], $i12
	bne     $i12, 0, be_else.36213
be_then.36213:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i11, 1, $i3
	b       pretrace_diffuse_rays.2980
be_else.36213:
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
	sub     $ig0, 1, $i3
	call    setup_startp_constants.2831
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
.count stack_load
	load    [$sp + 6], $i26
	load    [$i26 + $i11], $i26
	load    [$i25 + 0], $f1
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
	bg      $f0, $f1, ble_else.36214
ble_then.36214:
	fmul    $f1, $fc1, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36214
ble_else.36214:
	fmul    $f1, $fc2, $f2
	load    [$i24 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36214:
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
bge_else.36212:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.36211:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.36204:
	ret
ble_else.36203:
	ret
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	bl      $i3, 0, bge_else.36215
bge_then.36215:
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
	load    [min_caml_screenx_dir + 0], $f10
	sub     $i3, $ig8, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f11
	fmul    $fg17, $f11, $f11
	fmul    $f11, $f10, $f10
.count stack_load
	load    [$sp + 6], $f12
	fadd    $f10, $f12, $f10
	store   $f10, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_screenx_dir + 1], $f10
	fmul    $f11, $f10, $f10
.count stack_load
	load    [$sp + 5], $f12
	fadd    $f10, $f12, $f10
	store   $f10, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $f10
	fmul    $f11, $f10, $f10
	fadd    $f10, $f4, $f10
	store   $f10, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $f10
	fmul    $f10, $f10, $f11
	load    [min_caml_ptrace_dirvec + 1], $f12
	fmul    $f12, $f12, $f12
	fadd    $f11, $f12, $f11
	load    [min_caml_ptrace_dirvec + 2], $f12
	fmul    $f12, $f12, $f12
	fadd    $f11, $f12, $f11
	fsqrt   $f11, $f11
	bne     $f11, $f0, be_else.36216
be_then.36216:
	mov     $fc0, $f11
.count b_cont
	b       be_cont.36216
be_else.36216:
	finv    $f11, $f11
be_cont.36216:
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_ptrace_dirvec + 2]
	mov     $f0, $fg4
	mov     $f0, $fg5
	mov     $f0, $fg6
	load    [min_caml_viewpoint + 0], $fg21
	load    [min_caml_viewpoint + 1], $fg22
	load    [min_caml_viewpoint + 2], $fg23
	li      min_caml_ptrace_dirvec, $i3
	li      0, $i2
.count stack_load
	load    [$sp + 3], $i24
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + $i24], $i4
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
	bl      $i28, 0, bge_cont.36217
bge_then.36217:
	load    [$i2 + 3], $i28
	load    [$i28 + 0], $i28
	bne     $i28, 0, be_else.36218
be_then.36218:
	li      1, $i3
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.36218
be_else.36218:
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
	load    [$i24 + 0], $f1
	load    [$i11 + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i24 + 1], $f2
	load    [$i11 + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i24 + 2], $f2
	load    [$i11 + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f1, ble_else.36219
ble_then.36219:
	fmul    $f1, $fc1, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36219
ble_else.36219:
	fmul    $f1, $fc2, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.2926
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.2929
ble_cont.36219:
.count stack_load
	load    [$sp + 7], $i2
	load    [$i2 + 5], $i28
	load    [$i28 + 0], $i28
	store   $fg1, [$i28 + 0]
	store   $fg2, [$i28 + 1]
	store   $fg3, [$i28 + 2]
	li      1, $i3
	call    pretrace_diffuse_rays.2980
be_cont.36218:
bge_cont.36217:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 7], $i1
	sub     $i1, 1, $i3
	add     $i29, 1, $i4
.count stack_load
	load    [$sp - 9], $f4
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 4], $f2
.count stack_load
	load    [$sp - 6], $i2
	bl      $i4, 5, pretrace_pixels.2983
	sub     $i4, 5, $i4
	b       pretrace_pixels.2983
bge_else.36215:
	ret
.end pretrace_pixels

######################################################################
# scan_pixel
######################################################################
.begin scan_pixel
scan_pixel.2994:
	bg      $ig1, $i2, ble_else.36221
ble_then.36221:
	ret
ble_else.36221:
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
	bg      $ig3, $i32, ble_else.36222
ble_then.36222:
	li      0, $i32
.count b_cont
	b       ble_cont.36222
ble_else.36222:
	bg      $i3, 0, ble_else.36223
ble_then.36223:
	li      0, $i32
.count b_cont
	b       ble_cont.36223
ble_else.36223:
	add     $i2, 1, $i32
	bg      $ig1, $i32, ble_else.36224
ble_then.36224:
	li      0, $i32
.count b_cont
	b       ble_cont.36224
ble_else.36224:
	bg      $i2, 0, ble_else.36225
ble_then.36225:
	li      0, $i32
.count b_cont
	b       ble_cont.36225
ble_else.36225:
	li      1, $i32
ble_cont.36225:
ble_cont.36224:
ble_cont.36223:
ble_cont.36222:
	bne     $i32, 0, be_else.36226
be_then.36226:
	load    [$i5 + $i2], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36226
bge_then.36227:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36228
be_then.36228:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36226
be_else.36228:
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
	b       be_cont.36226
be_else.36226:
	li      0, $i32
	load    [$i5 + $i2], $i33
	load    [$i33 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, bge_cont.36229
bge_then.36229:
	load    [$i4 + $i2], $i35
	load    [$i35 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36230
be_then.36230:
	load    [$i6 + $i2], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36231
be_then.36231:
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36232
be_then.36232:
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.36233
be_then.36233:
	li      1, $i34
.count b_cont
	b       be_cont.36230
be_else.36233:
	li      0, $i34
.count b_cont
	b       be_cont.36230
be_else.36232:
	li      0, $i34
.count b_cont
	b       be_cont.36230
be_else.36231:
	li      0, $i34
.count b_cont
	b       be_cont.36230
be_else.36230:
	li      0, $i34
be_cont.36230:
	bne     $i34, 0, be_else.36234
be_then.36234:
	load    [$i5 + $i2], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36234
bge_then.36235:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36236
be_then.36236:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36234
be_else.36236:
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
	b       be_cont.36234
be_else.36234:
	load    [$i33 + 3], $i36
	load    [$i36 + 0], $i36
.count move_args
	mov     $i4, $i3
.count move_args
	mov     $i5, $i4
	bne     $i36, 0, be_else.36237
be_then.36237:
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.36237
be_else.36237:
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
be_cont.36237:
be_cont.36234:
bge_cont.36229:
be_cont.36226:
	li      255, $i10
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.36238
ble_then.36238:
	bl      $i2, 0, bge_else.36239
bge_then.36239:
	call    min_caml_write
.count b_cont
	b       ble_cont.36238
bge_else.36239:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36238
ble_else.36238:
	li      255, $i2
	call    min_caml_write
ble_cont.36238:
	li      255, $i10
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.36240
ble_then.36240:
	bl      $i2, 0, bge_else.36241
bge_then.36241:
	call    min_caml_write
.count b_cont
	b       ble_cont.36240
bge_else.36241:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36240
ble_else.36240:
	li      255, $i2
	call    min_caml_write
ble_cont.36240:
	li      255, $i10
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.36242
ble_then.36242:
	bl      $i2, 0, bge_else.36243
bge_then.36243:
	call    min_caml_write
.count b_cont
	b       ble_cont.36242
bge_else.36243:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.36242
ble_else.36242:
	li      255, $i2
	call    min_caml_write
ble_cont.36242:
.count stack_load
	load    [$sp + 5], $i32
	add     $i32, 1, $i32
	bg      $ig1, $i32, ble_else.36244
ble_then.36244:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	ret
ble_else.36244:
.count stack_store
	store   $i32, [$sp + 9]
.count stack_load
	load    [$sp + 4], $i33
	load    [$i33 + $i32], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $fg4
	load    [$i34 + 1], $fg5
	load    [$i34 + 2], $fg6
.count stack_load
	load    [$sp + 6], $i34
	bg      $ig3, $i34, ble_else.36245
ble_then.36245:
	li      0, $i34
.count b_cont
	b       ble_cont.36245
ble_else.36245:
.count stack_load
	load    [$sp + 3], $i34
	bg      $i34, 0, ble_else.36246
ble_then.36246:
	li      0, $i34
.count b_cont
	b       ble_cont.36246
ble_else.36246:
	add     $i32, 1, $i34
	bg      $ig1, $i34, ble_else.36247
ble_then.36247:
	li      0, $i34
.count b_cont
	b       ble_cont.36247
ble_else.36247:
	bg      $i32, 0, ble_else.36248
ble_then.36248:
	li      0, $i34
.count b_cont
	b       ble_cont.36248
ble_else.36248:
	li      1, $i34
ble_cont.36248:
ble_cont.36247:
ble_cont.36246:
ble_cont.36245:
	bne     $i34, 0, be_else.36249
be_then.36249:
	load    [$i33 + $i32], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36249
bge_then.36250:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36251
be_then.36251:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36249
be_else.36251:
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
	b       be_cont.36249
be_else.36249:
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
be_cont.36249:
	li      255, $i10
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.36252
ble_then.36252:
	bge     $i1, 0, ble_cont.36252
bl_then.36253:
	li      0, $i1
.count b_cont
	b       ble_cont.36252
ble_else.36252:
	li      255, $i1
ble_cont.36252:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.36254
ble_then.36254:
	bge     $i1, 0, ble_cont.36254
bl_then.36255:
	li      0, $i1
.count b_cont
	b       ble_cont.36254
ble_else.36254:
	li      255, $i1
ble_cont.36254:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.36256
ble_then.36256:
	bge     $i1, 0, ble_cont.36256
bl_then.36257:
	li      0, $i1
.count b_cont
	b       ble_cont.36256
ble_else.36256:
	li      255, $i1
ble_cont.36256:
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
	bg      $ig3, $i2, ble_else.36258
ble_then.36258:
	ret
ble_else.36258:
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
	sub     $ig3, 1, $i1
	ble     $i1, $i2, bg_cont.36259
bg_then.36259:
	add     $i2, 1, $i1
	sub     $i1, $ig7, $i2
	call    min_caml_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f10
	fadd    $f10, $fg18, $f2
	load    [min_caml_screeny_dir + 1], $f10
	fmul    $f1, $f10, $f10
	fadd    $f10, $fg19, $f3
	load    [min_caml_screeny_dir + 2], $f10
	fmul    $f1, $f10, $f1
	fadd    $f1, $fg20, $f4
	sub     $ig1, 1, $i3
.count move_args
	mov     $i5, $i2
.count move_args
	mov     $i6, $i4
	call    pretrace_pixels.2983
bg_cont.36259:
	li      0, $i32
	ble     $ig1, 0, bg_cont.36260
bg_then.36260:
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
	bg      $ig3, $i35, ble_else.36261
ble_then.36261:
	li      0, $i34
.count b_cont
	b       ble_cont.36261
ble_else.36261:
	bg      $i34, 0, ble_else.36262
ble_then.36262:
	li      0, $i34
.count b_cont
	b       ble_cont.36262
ble_else.36262:
	li      0, $i34
ble_cont.36262:
ble_cont.36261:
	bne     $i34, 0, be_else.36263
be_then.36263:
	load    [$i33 + 0], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.36263
bge_then.36264:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.36265
be_then.36265:
	li      1, $i3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36263
be_else.36265:
.count stack_store
	store   $i2, [$sp + 6]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.2942
	li      1, $i3
.count stack_load
	load    [$sp + 6], $i2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36263
be_else.36263:
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
be_cont.36263:
.count move_args
	mov     $fg4, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36266
ble_then.36266:
	bge     $i1, 0, ble_cont.36266
bl_then.36267:
	li      0, $i1
.count b_cont
	b       ble_cont.36266
ble_else.36266:
	li      255, $i1
ble_cont.36266:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $fg5, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.36268
ble_then.36268:
	bge     $i1, 0, ble_cont.36268
bl_then.36269:
	li      0, $i1
.count b_cont
	b       ble_cont.36268
ble_else.36268:
	li      255, $i1
ble_cont.36268:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $fg6, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.36270
ble_then.36270:
	bge     $i1, 0, ble_cont.36270
bl_then.36271:
	li      0, $i1
.count b_cont
	b       ble_cont.36270
ble_else.36270:
	li      255, $i1
ble_cont.36270:
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
bg_cont.36260:
.count stack_load
	load    [$sp + 4], $i1
	add     $i1, 1, $i1
	bg      $ig3, $i1, ble_else.36272
ble_then.36272:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
ble_else.36272:
.count stack_store
	store   $i1, [$sp + 7]
	sub     $ig3, 1, $i10
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 2, $i11
	bl      $i11, 5, bge_cont.36273
bge_then.36273:
	sub     $i11, 5, $i11
bge_cont.36273:
.count stack_store
	store   $i11, [$sp + 8]
	ble     $i10, $i1, bg_cont.36274
bg_then.36274:
	add     $i1, 1, $i1
	sub     $ig1, 1, $i10
	sub     $i1, $ig7, $i2
	call    min_caml_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f2
	load    [min_caml_screeny_dir + 1], $f3
	fmul    $f1, $f3, $f3
	fadd    $f3, $fg19, $f3
	load    [min_caml_screeny_dir + 2], $f4
	fmul    $f1, $f4, $f1
	fadd    $f1, $fg20, $f4
.count stack_load
	load    [$sp + 3], $i2
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	call    pretrace_pixels.2983
bg_cont.36274:
	li      0, $i2
.count stack_load
	load    [$sp + 7], $i3
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
	load    [$sp - 2], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 2, $i6
.count stack_load
	load    [$sp - 4], $i5
.count stack_load
	load    [$sp - 6], $i4
.count stack_load
	load    [$sp - 7], $i3
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
	bl      $i3, 0, bge_else.36276
bge_then.36276:
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
	bl      $i19, 0, bge_else.36277
bge_then.36277:
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i10
.count storer
	add     $i21, $i19, $tmp
	store   $i10, [$tmp + 0]
	sub     $i19, 1, $i10
	bl      $i10, 0, bge_else.36278
bge_then.36278:
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i13
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
	bl      $i19, 0, bge_else.36279
bge_then.36279:
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
bge_else.36279:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36278:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36277:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.36276:
	mov     $i2, $i1
	ret
.end init_line_elements

######################################################################
# calc_dirvec
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	bl      $i2, 5, bge_else.36280
bge_then.36280:
	load    [min_caml_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f2, $f2, $f1
	fmul    $f3, $f3, $f4
	fadd    $f1, $f4, $f1
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
bge_else.36280:
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
	finv    $f1, $f1
	fmul    $f13, $f1, $f1
	fmul    $f1, $f11, $f3
.count stack_load
	load    [$sp - 5], $i1
	add     $i1, 1, $i2
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
	bl      $i2, 0, bge_else.36281
bge_then.36281:
.count stack_move
	sub     $sp, 9, $sp
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
	li      0, $i1
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      0, $i2
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 5]
	fadd    $f15, $fc8, $f4
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
	bl      $i2, 0, bge_else.36282
bge_then.36282:
.count stack_store
	store   $i2, [$sp + 6]
	li      0, $i1
.count stack_load
	load    [$sp + 3], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36283
bge_then.36283:
	sub     $i11, 5, $i11
bge_cont.36283:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	fadd    $f15, $fc8, $f4
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 6], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36284
bge_then.36284:
.count stack_store
	store   $i2, [$sp + 7]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36285
bge_then.36285:
	sub     $i11, 5, $i11
bge_cont.36285:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	fadd    $f15, $fc8, $f4
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 7], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36286
bge_then.36286:
.count stack_store
	store   $i2, [$sp + 8]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36287
bge_then.36287:
	sub     $i11, 5, $i11
bge_cont.36287:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_load
	load    [$sp + 4], $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	fadd    $f15, $fc8, $f4
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i2
	add     $i11, 1, $i3
.count move_args
	mov     $i10, $i4
.count stack_load
	load    [$sp - 5], $f2
	bl      $i3, 5, calc_dirvecs.3028
	sub     $i3, 5, $i3
	b       calc_dirvecs.3028
bge_else.36286:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.36284:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.36282:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.36281:
	ret
.end calc_dirvecs

######################################################################
# calc_dirvec_rows
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	bl      $i2, 0, bge_else.36289
bge_then.36289:
.count stack_move
	sub     $sp, 17, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	li      0, $i1
	li      4, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f10
	fmul    $f10, $fc12, $f10
.count stack_store
	store   $f10, [$sp + 4]
	fsub    $f10, $fc11, $f10
.count stack_store
	store   $f10, [$sp + 5]
.count stack_load
	load    [$sp + 3], $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f5
.count stack_store
	store   $f5, [$sp + 6]
.count stack_load
	load    [$sp + 2], $i3
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $f10, $f4
	call    calc_dirvec.3020
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 7]
.count stack_load
	load    [$sp + 4], $f15
	fadd    $f15, $fc8, $f4
.count stack_store
	store   $f4, [$sp + 8]
.count stack_load
	load    [$sp + 6], $f5
.count stack_load
	load    [$sp + 2], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      0, $i1
.count stack_load
	load    [$sp + 2], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36290
bge_then.36290:
	sub     $i11, 5, $i11
bge_cont.36290:
	li      3, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_store
	store   $f4, [$sp + 9]
.count stack_load
	load    [$sp + 6], $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	fadd    $f15, $fc8, $f4
.count stack_store
	store   $f4, [$sp + 10]
.count stack_load
	load    [$sp + 6], $f5
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3020
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36291
bge_then.36291:
	sub     $i11, 5, $i11
bge_cont.36291:
	li      2, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f4
.count stack_load
	load    [$sp + 6], $f5
.count move_args
	mov     $i1, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	fadd    $f15, $fc8, $f4
.count stack_load
	load    [$sp + 6], $f5
.count stack_load
	load    [$sp + 7], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3020
	li      1, $i2
	add     $i11, 1, $i12
	bl      $i12, 5, bge_cont.36292
bge_then.36292:
	sub     $i12, 5, $i12
bge_cont.36292:
	mov     $i12, $i3
.count stack_load
	load    [$sp + 6], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 3], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.36293
bge_then.36293:
.count stack_store
	store   $i2, [$sp + 11]
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.36294
bge_then.36294:
	sub     $i1, 5, $i1
bge_cont.36294:
.count stack_store
	store   $i1, [$sp + 12]
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, 4, $i10
.count stack_store
	store   $i10, [$sp + 13]
	li      0, $i11
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f15
	fmul    $f15, $fc12, $f15
	fsub    $f15, $fc11, $f5
.count stack_store
	store   $f5, [$sp + 14]
.count stack_load
	load    [$sp + 5], $f4
.count move_args
	mov     $i11, $i2
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3020
	li      0, $i2
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 15]
.count stack_load
	load    [$sp + 8], $f4
.count stack_load
	load    [$sp + 14], $f5
.count stack_load
	load    [$sp + 12], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      0, $i2
.count stack_load
	load    [$sp + 12], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.36295
bge_then.36295:
	sub     $i11, 5, $i11
bge_cont.36295:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 16]
.count stack_load
	load    [$sp + 9], $f4
.count stack_load
	load    [$sp + 14], $f5
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
	load    [$sp + 14], $f5
.count stack_load
	load    [$sp + 16], $i3
.count stack_load
	load    [$sp + 15], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3020
	li      2, $i2
.count stack_load
	load    [$sp + 16], $i12
	add     $i12, 1, $i12
	bl      $i12, 5, bge_cont.36296
bge_then.36296:
	sub     $i12, 5, $i12
bge_cont.36296:
	mov     $i12, $i3
.count stack_load
	load    [$sp + 14], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 17, $sp
.count stack_load
	load    [$sp - 6], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i1
	add     $i1, 2, $i3
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 4, $i4
	bl      $i3, 5, calc_dirvec_rows.3033
	sub     $i3, 5, $i3
	b       calc_dirvec_rows.3033
bge_else.36293:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 17, $sp
	ret
bge_else.36289:
	ret
.end calc_dirvec_rows

######################################################################
# create_dirvec_elements
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	bl      $i3, 0, bge_else.36298
bge_then.36298:
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
	bl      $i10, 0, bge_else.36299
bge_then.36299:
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
	bl      $i10, 0, bge_else.36300
bge_then.36300:
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
	bl      $i10, 0, bge_else.36301
bge_then.36301:
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
bge_else.36301:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36300:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36299:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.36298:
	ret
.end create_dirvec_elements

######################################################################
# create_dirvecs
######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	bl      $i2, 0, bge_else.36302
bge_then.36302:
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
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i10, [$i3 + 1]
.count stack_load
	load    [$sp + 2], $i10
	store   $i10, [$i3 + 0]
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
	load    [min_caml_dirvecs + $i11], $i11
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i10, [$i12 + 1]
.count stack_load
	load    [$sp + 3], $i10
	store   $i10, [$i12 + 0]
	store   $i12, [$i11 + 118]
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
	mov     $i1, $i10
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i10, [$i12 + 1]
.count stack_load
	load    [$sp + 4], $i10
	store   $i10, [$i12 + 0]
	store   $i12, [$i11 + 117]
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
	store   $i15, [$i11 + 116]
	li      115, $i3
.count move_args
	mov     $i11, $i2
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 1], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36303
bge_then.36303:
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
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i11, [$i3 + 1]
.count stack_load
	load    [$sp + 7], $i11
	store   $i11, [$i3 + 0]
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
	load    [min_caml_dirvecs + $i10], $i10
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i11, [$i12 + 1]
.count stack_load
	load    [$sp + 8], $i11
	store   $i11, [$i12 + 0]
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
bge_else.36303:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.36302:
	ret
.end create_dirvecs

######################################################################
# init_dirvec_constants
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	bl      $i3, 0, bge_else.36304
bge_then.36304:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	sub     $ig0, 1, $i10
	load    [$i2 + $i3], $i11
	bl      $i10, 0, bge_cont.36305
bge_then.36305:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36306
be_then.36306:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36307
be_then.36307:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36307
be_else.36307:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36308
ble_then.36308:
	li      0, $i18
.count b_cont
	b       ble_cont.36308
ble_else.36308:
	li      1, $i18
ble_cont.36308:
	bne     $i17, 0, be_else.36309
be_then.36309:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36309
be_else.36309:
	bne     $i18, 0, be_else.36310
be_then.36310:
	li      1, $i17
.count b_cont
	b       be_cont.36310
be_else.36310:
	li      0, $i17
be_cont.36310:
be_cont.36309:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.36311
be_then.36311:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.36311
be_else.36311:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.36311:
be_cont.36307:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36312
be_then.36312:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36312
be_else.36312:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36313
ble_then.36313:
	li      0, $i18
.count b_cont
	b       ble_cont.36313
ble_else.36313:
	li      1, $i18
ble_cont.36313:
	bne     $i17, 0, be_else.36314
be_then.36314:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36314
be_else.36314:
	bne     $i18, 0, be_else.36315
be_then.36315:
	li      1, $i17
.count b_cont
	b       be_cont.36315
be_else.36315:
	li      0, $i17
be_cont.36315:
be_cont.36314:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.36316
be_then.36316:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.36316
be_else.36316:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.36316:
be_cont.36312:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36317
be_then.36317:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36306
be_else.36317:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36318
ble_then.36318:
	li      0, $i18
.count b_cont
	b       ble_cont.36318
ble_else.36318:
	li      1, $i18
ble_cont.36318:
	bne     $i17, 0, be_else.36319
be_then.36319:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36319
be_else.36319:
	bne     $i18, 0, be_else.36320
be_then.36320:
	li      1, $i17
.count b_cont
	b       be_cont.36320
be_else.36320:
	li      0, $i17
be_cont.36320:
be_cont.36319:
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f10
	bne     $i17, 0, be_cont.36321
be_then.36321:
	fneg    $f10, $f10
be_cont.36321:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36306
be_else.36306:
	bne     $i14, 2, be_else.36322
be_then.36322:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i15 + 0], $f10
	load    [$i17 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i18 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i19 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bg      $f10, $f0, ble_else.36323
ble_then.36323:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36322
ble_else.36323:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36322
be_else.36322:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 3], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i18 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i17, 0, be_else.36324
be_then.36324:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36324
be_else.36324:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36324:
	store   $f10, [$i16 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i10, $tmp
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	bne     $i17, 0, be_else.36325
be_then.36325:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.36326
be_then.36326:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36325
be_else.36326:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36325
be_else.36325:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.36327
be_then.36327:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36327
be_else.36327:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36327:
be_cont.36325:
be_cont.36322:
be_cont.36306:
bge_cont.36305:
.count stack_load
	load    [$sp + 2], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36328
bge_then.36328:
.count stack_store
	store   $i10, [$sp + 3]
	sub     $ig0, 1, $i11
.count stack_load
	load    [$sp + 1], $i12
	load    [$i12 + $i10], $i10
	bl      $i11, 0, bge_cont.36329
bge_then.36329:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36330
be_then.36330:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36331
be_then.36331:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36331
be_else.36331:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36332
ble_then.36332:
	li      0, $i18
.count b_cont
	b       ble_cont.36332
ble_else.36332:
	li      1, $i18
ble_cont.36332:
	bne     $i17, 0, be_else.36333
be_then.36333:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36333
be_else.36333:
	bne     $i18, 0, be_else.36334
be_then.36334:
	li      1, $i17
.count b_cont
	b       be_cont.36334
be_else.36334:
	li      0, $i17
be_cont.36334:
be_cont.36333:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.36335
be_then.36335:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.36335
be_else.36335:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.36335:
be_cont.36331:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36336
be_then.36336:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36336
be_else.36336:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36337
ble_then.36337:
	li      0, $i18
.count b_cont
	b       ble_cont.36337
ble_else.36337:
	li      1, $i18
ble_cont.36337:
	bne     $i17, 0, be_else.36338
be_then.36338:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36338
be_else.36338:
	bne     $i18, 0, be_else.36339
be_then.36339:
	li      1, $i17
.count b_cont
	b       be_cont.36339
be_else.36339:
	li      0, $i17
be_cont.36339:
be_cont.36338:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.36340
be_then.36340:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.36340
be_else.36340:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.36340:
be_cont.36336:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36341
be_then.36341:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36330
be_else.36341:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.36342
ble_then.36342:
	li      0, $i19
.count b_cont
	b       ble_cont.36342
ble_else.36342:
	li      1, $i19
ble_cont.36342:
	bne     $i17, 0, be_else.36343
be_then.36343:
	mov     $i19, $i17
.count b_cont
	b       be_cont.36343
be_else.36343:
	bne     $i19, 0, be_else.36344
be_then.36344:
	li      1, $i17
.count b_cont
	b       be_cont.36344
be_else.36344:
	li      0, $i17
be_cont.36344:
be_cont.36343:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.36345
be_then.36345:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36330
be_else.36345:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36330
be_else.36330:
	bne     $i14, 2, be_else.36346
be_then.36346:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i15 + 0], $f10
	load    [$i17 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i18 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i19 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bg      $f10, $f0, ble_else.36347
ble_then.36347:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36346
ble_else.36347:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36346
be_else.36346:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 3], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i18 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i17, 0, be_else.36348
be_then.36348:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36348
be_else.36348:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36348:
	store   $f10, [$i16 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i17, 0, be_else.36349
be_then.36349:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.36350
be_then.36350:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36349
be_else.36350:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36349
be_else.36349:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.36351
be_then.36351:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36351
be_else.36351:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36351:
be_cont.36349:
be_cont.36346:
be_cont.36330:
bge_cont.36329:
.count stack_load
	load    [$sp + 3], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.36352
bge_then.36352:
	sub     $ig0, 1, $i3
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + $i16], $i2
	call    iter_setup_dirvec_constants.2826
	sub     $i16, 1, $i10
	bl      $i10, 0, bge_else.36353
bge_then.36353:
	sub     $ig0, 1, $i11
	bl      $i11, 0, bge_else.36354
bge_then.36354:
	load    [$i17 + $i10], $i12
	load    [$i12 + 1], $i13
	load    [min_caml_objects + $i11], $i14
	load    [$i14 + 1], $i15
	load    [$i12 + 0], $i16
.count stack_store
	store   $i10, [$sp + 4]
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.36355
be_then.36355:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i16 + 0], $f10
	bne     $f10, $f0, be_else.36356
be_then.36356:
	store   $f0, [$i18 + 1]
.count b_cont
	b       be_cont.36356
be_else.36356:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.36357
ble_then.36357:
	li      0, $i20
.count b_cont
	b       ble_cont.36357
ble_else.36357:
	li      1, $i20
ble_cont.36357:
	bne     $i19, 0, be_else.36358
be_then.36358:
	mov     $i20, $i19
.count b_cont
	b       be_cont.36358
be_else.36358:
	bne     $i20, 0, be_else.36359
be_then.36359:
	li      1, $i19
.count b_cont
	b       be_cont.36359
be_else.36359:
	li      0, $i19
be_cont.36359:
be_cont.36358:
	load    [$i14 + 4], $i20
	load    [$i20 + 0], $f10
	bne     $i19, 0, be_else.36360
be_then.36360:
	fneg    $f10, $f10
	store   $f10, [$i18 + 0]
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
.count b_cont
	b       be_cont.36360
be_else.36360:
	store   $f10, [$i18 + 0]
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
be_cont.36360:
be_cont.36356:
	load    [$i16 + 1], $f10
	bne     $f10, $f0, be_else.36361
be_then.36361:
	store   $f0, [$i18 + 3]
.count b_cont
	b       be_cont.36361
be_else.36361:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.36362
ble_then.36362:
	li      0, $i20
.count b_cont
	b       ble_cont.36362
ble_else.36362:
	li      1, $i20
ble_cont.36362:
	bne     $i19, 0, be_else.36363
be_then.36363:
	mov     $i20, $i19
.count b_cont
	b       be_cont.36363
be_else.36363:
	bne     $i20, 0, be_else.36364
be_then.36364:
	li      1, $i19
.count b_cont
	b       be_cont.36364
be_else.36364:
	li      0, $i19
be_cont.36364:
be_cont.36363:
	load    [$i14 + 4], $i20
	load    [$i20 + 1], $f10
	bne     $i19, 0, be_else.36365
be_then.36365:
	fneg    $f10, $f10
	store   $f10, [$i18 + 2]
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
.count b_cont
	b       be_cont.36365
be_else.36365:
	store   $f10, [$i18 + 2]
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
be_cont.36365:
be_cont.36361:
	load    [$i16 + 2], $f10
	bne     $f10, $f0, be_else.36366
be_then.36366:
	store   $f0, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.36366
be_else.36366:
	load    [$i14 + 6], $i19
	load    [$i14 + 4], $i20
	bg      $f0, $f10, ble_else.36367
ble_then.36367:
	li      0, $i21
.count b_cont
	b       ble_cont.36367
ble_else.36367:
	li      1, $i21
ble_cont.36367:
	bne     $i19, 0, be_else.36368
be_then.36368:
	mov     $i21, $i19
.count b_cont
	b       be_cont.36368
be_else.36368:
	bne     $i21, 0, be_else.36369
be_then.36369:
	li      1, $i19
.count b_cont
	b       be_cont.36369
be_else.36369:
	li      0, $i19
be_cont.36369:
be_cont.36368:
	load    [$i20 + 2], $f10
	bne     $i19, 0, be_else.36370
be_then.36370:
	fneg    $f10, $f10
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.36370
be_else.36370:
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
be_cont.36370:
be_cont.36366:
.count storer
	add     $i13, $i11, $tmp
	store   $i16, [$tmp + 0]
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
be_else.36355:
	bne     $i15, 2, be_else.36371
be_then.36371:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i16 + 0], $f10
	load    [$i19 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i16 + 1], $f11
	load    [$i20 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i16 + 2], $f11
	load    [$i21 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count storer
	add     $i13, $i11, $tmp
	bg      $f10, $f0, ble_else.36372
ble_then.36372:
	store   $f0, [$i18 + 0]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36371
ble_else.36372:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i18 + 0]
	load    [$i14 + 4], $i16
	load    [$i16 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i18 + 1]
	load    [$i14 + 4], $i16
	load    [$i16 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i18 + 2]
	load    [$i14 + 4], $i16
	load    [$i16 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i18 + 3]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36371
be_else.36371:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i14 + 3], $i19
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i14 + 4], $i22
	load    [$i16 + 0], $f10
	load    [$i16 + 1], $f11
	load    [$i16 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i20 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i21 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i22 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i19, 0, be_else.36373
be_then.36373:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36373
be_else.36373:
	fmul    $f11, $f12, $f14
	load    [$i14 + 9], $i20
	load    [$i20 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i14 + 9], $i20
	load    [$i20 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i14 + 9], $i20
	load    [$i20 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36373:
	store   $f10, [$i18 + 0]
	load    [$i14 + 4], $i20
	load    [$i14 + 4], $i21
	load    [$i14 + 4], $i22
	load    [$i16 + 0], $f11
	load    [$i20 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i16 + 1], $f12
	load    [$i21 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i16 + 2], $f14
	load    [$i22 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i13, $i11, $tmp
	bne     $i19, 0, be_else.36374
be_then.36374:
	store   $f11, [$i18 + 1]
	store   $f13, [$i18 + 2]
	store   $f15, [$i18 + 3]
	bne     $f10, $f0, be_else.36375
be_then.36375:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36374
be_else.36375:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36374
be_else.36374:
	load    [$i14 + 9], $i19
	load    [$i14 + 9], $i20
	load    [$i19 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i20 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i18 + 1]
	load    [$i14 + 9], $i19
	load    [$i16 + 2], $f11
	load    [$i19 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i18 + 2]
	load    [$i16 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i18 + 3]
	bne     $f10, $f0, be_else.36376
be_then.36376:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.36376
be_else.36376:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
be_cont.36376:
be_cont.36374:
be_cont.36371:
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
bge_else.36354:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	sub     $i10, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3044
bge_else.36353:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36352:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36328:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36304:
	ret
.end init_dirvec_constants

######################################################################
# init_vecset_constants
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	bl      $i2, 0, bge_else.36377
bge_then.36377:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	sub     $ig0, 1, $i10
	load    [min_caml_dirvecs + $i2], $i11
.count stack_store
	store   $i11, [$sp + 2]
	load    [$i11 + 119], $i11
	bl      $i10, 0, bge_cont.36378
bge_then.36378:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36379
be_then.36379:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36380
be_then.36380:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36380
be_else.36380:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36381
ble_then.36381:
	li      0, $i18
.count b_cont
	b       ble_cont.36381
ble_else.36381:
	li      1, $i18
ble_cont.36381:
	bne     $i17, 0, be_else.36382
be_then.36382:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36382
be_else.36382:
	bne     $i18, 0, be_else.36383
be_then.36383:
	li      1, $i17
.count b_cont
	b       be_cont.36383
be_else.36383:
	li      0, $i17
be_cont.36383:
be_cont.36382:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.36384
be_then.36384:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.36384
be_else.36384:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.36384:
be_cont.36380:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36385
be_then.36385:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36385
be_else.36385:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36386
ble_then.36386:
	li      0, $i18
.count b_cont
	b       ble_cont.36386
ble_else.36386:
	li      1, $i18
ble_cont.36386:
	bne     $i17, 0, be_else.36387
be_then.36387:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36387
be_else.36387:
	bne     $i18, 0, be_else.36388
be_then.36388:
	li      1, $i17
.count b_cont
	b       be_cont.36388
be_else.36388:
	li      0, $i17
be_cont.36388:
be_cont.36387:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.36389
be_then.36389:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.36389
be_else.36389:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.36389:
be_cont.36385:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36390
be_then.36390:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36379
be_else.36390:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.36391
ble_then.36391:
	li      0, $i19
.count b_cont
	b       ble_cont.36391
ble_else.36391:
	li      1, $i19
ble_cont.36391:
	bne     $i17, 0, be_else.36392
be_then.36392:
	mov     $i19, $i17
.count b_cont
	b       be_cont.36392
be_else.36392:
	bne     $i19, 0, be_else.36393
be_then.36393:
	li      1, $i17
.count b_cont
	b       be_cont.36393
be_else.36393:
	li      0, $i17
be_cont.36393:
be_cont.36392:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i17, 0, be_else.36394
be_then.36394:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36379
be_else.36394:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36379
be_else.36379:
	bne     $i14, 2, be_else.36395
be_then.36395:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i15 + 0], $f10
	load    [$i17 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i18 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i19 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bg      $f10, $f0, ble_else.36396
ble_then.36396:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36395
ble_else.36396:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36395
be_else.36395:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 3], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i18 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i17, 0, be_else.36397
be_then.36397:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36397
be_else.36397:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36397:
	store   $f10, [$i16 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i10, $tmp
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	bne     $i17, 0, be_else.36398
be_then.36398:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.36399
be_then.36399:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36398
be_else.36399:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36398
be_else.36398:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.36400
be_then.36400:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36400
be_else.36400:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36400:
be_cont.36398:
be_cont.36395:
be_cont.36379:
bge_cont.36378:
	sub     $ig0, 1, $i3
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 118], $i2
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i10
	load    [$i16 + 117], $i11
	bl      $i10, 0, bge_cont.36401
bge_then.36401:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36402
be_then.36402:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36403
be_then.36403:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.36403
be_else.36403:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.36404
ble_then.36404:
	li      0, $i19
.count b_cont
	b       ble_cont.36404
ble_else.36404:
	li      1, $i19
ble_cont.36404:
	bne     $i18, 0, be_else.36405
be_then.36405:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36405
be_else.36405:
	bne     $i19, 0, be_else.36406
be_then.36406:
	li      1, $i18
.count b_cont
	b       be_cont.36406
be_else.36406:
	li      0, $i18
be_cont.36406:
be_cont.36405:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.36407
be_then.36407:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.36407
be_else.36407:
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.36407:
be_cont.36403:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36408
be_then.36408:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.36408
be_else.36408:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.36409
ble_then.36409:
	li      0, $i19
.count b_cont
	b       ble_cont.36409
ble_else.36409:
	li      1, $i19
ble_cont.36409:
	bne     $i18, 0, be_else.36410
be_then.36410:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36410
be_else.36410:
	bne     $i19, 0, be_else.36411
be_then.36411:
	li      1, $i18
.count b_cont
	b       be_cont.36411
be_else.36411:
	li      0, $i18
be_cont.36411:
be_cont.36410:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.36412
be_then.36412:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.36412
be_else.36412:
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.36412:
be_cont.36408:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36413
be_then.36413:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36402
be_else.36413:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.36414
ble_then.36414:
	li      0, $i20
.count b_cont
	b       ble_cont.36414
ble_else.36414:
	li      1, $i20
ble_cont.36414:
	bne     $i18, 0, be_else.36415
be_then.36415:
	mov     $i20, $i18
.count b_cont
	b       be_cont.36415
be_else.36415:
	bne     $i20, 0, be_else.36416
be_then.36416:
	li      1, $i18
.count b_cont
	b       be_cont.36416
be_else.36416:
	li      0, $i18
be_cont.36416:
be_cont.36415:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.36417
be_then.36417:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36402
be_else.36417:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36402
be_else.36402:
	bne     $i14, 2, be_else.36418
be_then.36418:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i18 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i19 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i20 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bg      $f10, $f0, ble_else.36419
ble_then.36419:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36418
ble_else.36419:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36418
be_else.36418:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 3], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 4], $i21
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i19 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i20 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i18, 0, be_else.36420
be_then.36420:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36420
be_else.36420:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i19
	load    [$i19 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i19
	load    [$i19 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i19
	load    [$i19 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36420:
	store   $f10, [$i17 + 0]
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 4], $i21
	load    [$i15 + 0], $f11
	load    [$i19 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i20 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i10, $tmp
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	bne     $i18, 0, be_else.36421
be_then.36421:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.36422
be_then.36422:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36421
be_else.36422:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36421
be_else.36421:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.36423
be_then.36423:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36423
be_else.36423:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36423:
be_cont.36421:
be_cont.36418:
be_cont.36402:
bge_cont.36401:
	li      116, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 1], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.36424
bge_then.36424:
.count stack_store
	store   $i16, [$sp + 3]
	sub     $ig0, 1, $i3
	load    [min_caml_dirvecs + $i16], $i16
	load    [$i16 + 119], $i2
	call    iter_setup_dirvec_constants.2826
	sub     $ig0, 1, $i10
	load    [$i16 + 118], $i11
	bl      $i10, 0, bge_cont.36425
bge_then.36425:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36426
be_then.36426:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36427
be_then.36427:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.36427
be_else.36427:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.36428
ble_then.36428:
	li      0, $i19
.count b_cont
	b       ble_cont.36428
ble_else.36428:
	li      1, $i19
ble_cont.36428:
	bne     $i18, 0, be_else.36429
be_then.36429:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36429
be_else.36429:
	bne     $i19, 0, be_else.36430
be_then.36430:
	li      1, $i18
.count b_cont
	b       be_cont.36430
be_else.36430:
	li      0, $i18
be_cont.36430:
be_cont.36429:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.36431
be_then.36431:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.36431
be_else.36431:
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.36431:
be_cont.36427:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36432
be_then.36432:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.36432
be_else.36432:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.36433
ble_then.36433:
	li      0, $i19
.count b_cont
	b       ble_cont.36433
ble_else.36433:
	li      1, $i19
ble_cont.36433:
	bne     $i18, 0, be_else.36434
be_then.36434:
	mov     $i19, $i18
.count b_cont
	b       be_cont.36434
be_else.36434:
	bne     $i19, 0, be_else.36435
be_then.36435:
	li      1, $i18
.count b_cont
	b       be_cont.36435
be_else.36435:
	li      0, $i18
be_cont.36435:
be_cont.36434:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.36436
be_then.36436:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.36436
be_else.36436:
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.36436:
be_cont.36432:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36437
be_then.36437:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36426
be_else.36437:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.36438
ble_then.36438:
	li      0, $i20
.count b_cont
	b       ble_cont.36438
ble_else.36438:
	li      1, $i20
ble_cont.36438:
	bne     $i18, 0, be_else.36439
be_then.36439:
	mov     $i20, $i18
.count b_cont
	b       be_cont.36439
be_else.36439:
	bne     $i20, 0, be_else.36440
be_then.36440:
	li      1, $i18
.count b_cont
	b       be_cont.36440
be_else.36440:
	li      0, $i18
be_cont.36440:
be_cont.36439:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.36441
be_then.36441:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36426
be_else.36441:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36426
be_else.36426:
	bne     $i14, 2, be_else.36442
be_then.36442:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i18 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i19 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i20 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bg      $f10, $f0, ble_else.36443
ble_then.36443:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36442
ble_else.36443:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36442
be_else.36442:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i13 + 3], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 4], $i21
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i19 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i20 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i18, 0, be_else.36444
be_then.36444:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36444
be_else.36444:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i19
	load    [$i19 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i19
	load    [$i19 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i19
	load    [$i19 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36444:
	store   $f10, [$i17 + 0]
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i13 + 4], $i21
	load    [$i15 + 0], $f11
	load    [$i19 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i20 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i21 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i10, $tmp
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	bne     $i18, 0, be_else.36445
be_then.36445:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.36446
be_then.36446:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36445
be_else.36446:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36445
be_else.36445:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.36447
be_then.36447:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36447
be_else.36447:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36447:
be_cont.36445:
be_cont.36442:
be_cont.36426:
bge_cont.36425:
	li      117, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.36448
bge_then.36448:
.count stack_store
	store   $i10, [$sp + 4]
	sub     $ig0, 1, $i11
	load    [min_caml_dirvecs + $i10], $i10
.count stack_store
	store   $i10, [$sp + 5]
	load    [$i10 + 119], $i10
	bl      $i11, 0, bge_cont.36449
bge_then.36449:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.36450
be_then.36450:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.36451
be_then.36451:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36451
be_else.36451:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36452
ble_then.36452:
	li      0, $i18
.count b_cont
	b       ble_cont.36452
ble_else.36452:
	li      1, $i18
ble_cont.36452:
	bne     $i17, 0, be_else.36453
be_then.36453:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36453
be_else.36453:
	bne     $i18, 0, be_else.36454
be_then.36454:
	li      1, $i17
.count b_cont
	b       be_cont.36454
be_else.36454:
	li      0, $i17
be_cont.36454:
be_cont.36453:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.36455
be_then.36455:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.36455
be_else.36455:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.36455:
be_cont.36451:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.36456
be_then.36456:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36456
be_else.36456:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.36457
ble_then.36457:
	li      0, $i18
.count b_cont
	b       ble_cont.36457
ble_else.36457:
	li      1, $i18
ble_cont.36457:
	bne     $i17, 0, be_else.36458
be_then.36458:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36458
be_else.36458:
	bne     $i18, 0, be_else.36459
be_then.36459:
	li      1, $i17
.count b_cont
	b       be_cont.36459
be_else.36459:
	li      0, $i17
be_cont.36459:
be_cont.36458:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.36460
be_then.36460:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.36460
be_else.36460:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.36460:
be_cont.36456:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.36461
be_then.36461:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36450
be_else.36461:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.36462
ble_then.36462:
	li      0, $i19
.count b_cont
	b       ble_cont.36462
ble_else.36462:
	li      1, $i19
ble_cont.36462:
	bne     $i17, 0, be_else.36463
be_then.36463:
	mov     $i19, $i17
.count b_cont
	b       be_cont.36463
be_else.36463:
	bne     $i19, 0, be_else.36464
be_then.36464:
	li      1, $i17
.count b_cont
	b       be_cont.36464
be_else.36464:
	li      0, $i17
be_cont.36464:
be_cont.36463:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.36465
be_then.36465:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36450
be_else.36465:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36450
be_else.36450:
	bne     $i14, 2, be_else.36466
be_then.36466:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 4], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i15 + 0], $f10
	load    [$i17 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i15 + 1], $f11
	load    [$i18 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i15 + 2], $f11
	load    [$i19 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bg      $f10, $f0, ble_else.36467
ble_then.36467:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36466
ble_else.36467:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36466
be_else.36466:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i13 + 3], $i17
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f10
	load    [$i15 + 1], $f11
	load    [$i15 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i18 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i17, 0, be_else.36468
be_then.36468:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36468
be_else.36468:
	fmul    $f11, $f12, $f14
	load    [$i13 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i13 + 9], $i18
	load    [$i18 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i13 + 9], $i18
	load    [$i18 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36468:
	store   $f10, [$i16 + 0]
	load    [$i13 + 4], $i18
	load    [$i13 + 4], $i19
	load    [$i13 + 4], $i20
	load    [$i15 + 0], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 1], $f12
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i15 + 2], $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i12, $i11, $tmp
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i17, 0, be_else.36469
be_then.36469:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.36470
be_then.36470:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36469
be_else.36470:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36469
be_else.36469:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.36471
be_then.36471:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36471
be_else.36471:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36471:
be_cont.36469:
be_cont.36466:
be_cont.36450:
bge_cont.36449:
	li      118, $i3
.count stack_load
	load    [$sp + 5], $i2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 4], $i23
	sub     $i23, 1, $i23
	bl      $i23, 0, bge_else.36472
bge_then.36472:
	load    [min_caml_dirvecs + $i23], $i2
	li      119, $i3
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	sub     $i23, 1, $i2
	b       init_vecset_constants.3047
bge_else.36472:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36448:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36424:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36377:
	ret
.end init_vecset_constants

######################################################################
# setup_reflections
######################################################################
.begin setup_reflections
setup_reflections.3064:
	bl      $i2, 0, bge_else.36473
bge_then.36473:
	load    [min_caml_objects + $i2], $i10
	load    [$i10 + 2], $i11
	bne     $i11, 2, be_else.36474
be_then.36474:
	load    [$i10 + 7], $i11
	load    [$i11 + 0], $f1
	bg      $fc0, $f1, ble_else.36475
ble_then.36475:
	ret
ble_else.36475:
	load    [$i10 + 1], $i11
	bne     $i11, 1, be_else.36476
be_then.36476:
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
	fneg    $fg13, $f10
	store   $f10, [$i17 + 1]
	fneg    $fg14, $f11
	store   $f11, [$i17 + 2]
	sub     $ig0, 1, $i3
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 4]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, $i10, $i10
	add     $i10, $i10, $i10
.count stack_store
	store   $i10, [$sp + 5]
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + 0], $f1
	fsub    $fc0, $f1, $f1
.count stack_store
	store   $f1, [$sp + 6]
	mov     $hp, $i11
	add     $hp, 3, $hp
	store   $f1, [$i11 + 2]
.count stack_load
	load    [$sp + 4], $i12
	store   $i12, [$i11 + 1]
	store   $i10, [$i11 + 0]
	store   $i11, [min_caml_reflections + $ig6]
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
	fneg    $fg12, $f12
.count stack_load
	load    [$sp + 7], $i17
	store   $f12, [$i17 + 0]
	store   $fg13, [$i17 + 1]
	store   $f11, [$i17 + 2]
	sub     $ig0, 1, $i3
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 8]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	call    iter_setup_dirvec_constants.2826
	add     $ig6, 1, $i10
.count stack_load
	load    [$sp + 5], $i11
	add     $i11, 2, $i11
	mov     $hp, $i12
	add     $hp, 3, $hp
.count stack_load
	load    [$sp + 6], $i13
	store   $i13, [$i12 + 2]
.count stack_load
	load    [$sp + 8], $i13
	store   $i13, [$i12 + 1]
	store   $i11, [$i12 + 0]
	store   $i12, [min_caml_reflections + $i10]
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
	store   $f12, [$i17 + 0]
	store   $f10, [$i17 + 1]
	store   $fg14, [$i17 + 2]
	sub     $ig0, 1, $i3
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 10]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	add     $ig6, 2, $i1
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
	store   $i3, [min_caml_reflections + $i1]
	add     $ig6, 3, $ig6
	ret
be_else.36476:
	bne     $i11, 2, be_else.36477
be_then.36477:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 11]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i10 + 4], $i11
	load    [$i10 + 4], $i10
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	mov     $i12, $i3
.count stack_store
	store   $i3, [$sp + 12]
.count move_args
	mov     $ig0, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	load    [$i11 + 0], $f10
	fmul    $fc10, $f10, $f11
	fmul    $fg12, $f10, $f10
	load    [$i10 + 1], $f12
	fmul    $fg13, $f12, $f13
	fadd    $f10, $f13, $f10
	load    [$i10 + 2], $f13
	fmul    $fg14, $f13, $f14
	fadd    $f10, $f14, $f10
	fmul    $f11, $f10, $f11
	fsub    $f11, $fg12, $f11
.count stack_load
	load    [$sp + 12], $i17
	store   $f11, [$i17 + 0]
	fmul    $fc10, $f12, $f11
	fmul    $f11, $f10, $f11
	fsub    $f11, $fg13, $f11
	store   $f11, [$i17 + 1]
	fmul    $fc10, $f13, $f11
	fmul    $f11, $f10, $f10
	fsub    $f10, $fg14, $f10
	store   $f10, [$i17 + 2]
	sub     $ig0, 1, $i3
	mov     $hp, $i2
.count stack_store
	store   $i2, [$sp + 13]
	add     $hp, 2, $hp
	store   $i16, [$i2 + 1]
	store   $i17, [$i2 + 0]
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
	store   $i2, [min_caml_reflections + $ig6]
	add     $ig6, 1, $ig6
	ret
be_else.36477:
	ret
be_else.36474:
	ret
bge_else.36473:
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
	load    [min_caml_image_size + 0], $ig1
	load    [min_caml_startp_fast + 0], $fg8
	load    [min_caml_startp_fast + 1], $fg9
	load    [min_caml_startp_fast + 2], $fg10
	load    [min_caml_texture_color + 1], $fg11
	load    [min_caml_light + 0], $fg12
	load    [min_caml_light + 1], $fg13
	load    [min_caml_light + 2], $fg14
	load    [min_caml_texture_color + 2], $fg15
	load    [min_caml_or_net + 0], $ig2
	load    [min_caml_image_size + 1], $ig3
	load    [min_caml_intsec_rectside + 0], $ig4
	load    [min_caml_texture_color + 0], $fg16
	load    [min_caml_intersected_object_id + 0], $ig5
	load    [min_caml_n_reflections + 0], $ig6
	load    [min_caml_scan_pitch + 0], $fg17
	load    [min_caml_screenz_dir + 0], $fg18
	load    [min_caml_screenz_dir + 1], $fg19
	load    [min_caml_screenz_dir + 2], $fg20
	load    [min_caml_startp + 0], $fg21
	load    [min_caml_startp + 1], $fg22
	load    [min_caml_startp + 2], $fg23
	load    [min_caml_image_center + 1], $ig7
	load    [min_caml_screeny_dir + 0], $fg24
	load    [min_caml_image_center + 0], $ig8
	load    [f.31950 + 0], $fc0
	load    [f.31974 + 0], $fc1
	load    [f.31973 + 0], $fc2
	load    [f.31951 + 0], $fc3
	load    [f.31949 + 0], $fc4
	load    [f.31976 + 0], $fc5
	load    [f.31975 + 0], $fc6
	load    [f.31954 + 0], $fc7
	load    [f.31963 + 0], $fc8
	load    [f.31961 + 0], $fc9
	load    [f.31948 + 0], $fc10
	load    [f.32005 + 0], $fc11
	load    [f.32004 + 0], $fc12
	load    [f.31969 + 0], $fc13
	load    [f.31968 + 0], $fc14
	load    [f.31958 + 0], $fc15
	load    [f.31953 + 0], $fc16
	load    [f.31959 + 0], $fc17
	load    [f.31957 + 0], $fc18
	load    [f.31956 + 0], $fc19
	li      128, $i2
	mov     $i2, $ig1
	li      128, $ig3
	li      64, $ig8
	li      64, $ig7
.count load_float
	load    [f.32067], $f10
	call    min_caml_float_of_int
	finv    $f1, $f1
	fmul    $f10, $f1, $fg17
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
.count move_args
	mov     $ig1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $ig1, 2, $i20
	bl      $i20, 0, bge_else.36478
bge_then.36478:
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.36478
bge_else.36478:
	mov     $i19, $i10
bge_cont.36478:
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
.count move_args
	mov     $ig1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $ig1, 2, $i20
	bl      $i20, 0, bge_else.36479
bge_then.36479:
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.36479
bge_else.36479:
	mov     $i19, $i10
bge_cont.36479:
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
	li      5, $i2
	li      0, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	li      5, $i2
	li      0, $i3
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
	li      1, $i2
	li      0, $i3
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
.count move_args
	mov     $ig1, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $ig1, 2, $i20
	bl      $i20, 0, bge_else.36480
bge_then.36480:
	call    create_pixel.3008
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3010
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.36480
bge_else.36480:
	mov     $i19, $i10
bge_cont.36480:
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
	load    [f.31935], $f11
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
	fmul    $f10, $f1, $f14
.count load_float
	load    [f.32095], $f15
	fmul    $f14, $f15, $fg18
.count load_float
	load    [f.32096], $f14
	fmul    $f12, $f14, $fg19
	fmul    $f10, $f13, $f14
	fmul    $f14, $f15, $fg20
	store   $f13, [min_caml_screenx_dir + 0]
	store   $f0, [min_caml_screenx_dir + 1]
	fneg    $f1, $f14
	store   $f14, [min_caml_screenx_dir + 2]
	fneg    $f12, $f12
	fmul    $f12, $f1, $fg24
	fneg    $f10, $f1
	store   $f1, [min_caml_screeny_dir + 1]
	fmul    $f12, $f13, $f1
	store   $f1, [min_caml_screeny_dir + 2]
	load    [min_caml_screen + 0], $f1
	fsub    $f1, $fg18, $f1
	store   $f1, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $f1
	fsub    $f1, $fg19, $f1
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
.count move_ret
	mov     $f1, $f18
	store   $f18, [min_caml_beam + 0]
	li      0, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36481
be_then.36481:
.count stack_load
	load    [$sp + 8], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36481
be_else.36481:
	li      1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36482
be_then.36482:
.count stack_load
	load    [$sp + 9], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36482
be_else.36482:
	li      2, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.36483
be_then.36483:
.count stack_load
	load    [$sp + 10], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36483
be_else.36483:
	li      3, $i2
.count stack_store
	store   $i2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.36484
be_then.36484:
.count stack_load
	load    [$sp + 11], $i10
	mov     $i10, $ig0
.count b_cont
	b       be_cont.36484
be_else.36484:
	li      4, $i2
	call    read_object.2721
be_cont.36484:
be_cont.36483:
be_cont.36482:
be_cont.36481:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.36485
be_then.36485:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
.count b_cont
	b       be_cont.36485
be_else.36485:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.36486
be_then.36486:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
	store   $i10, [$i18 + 0]
.count b_cont
	b       be_cont.36486
be_else.36486:
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
be_cont.36486:
be_cont.36485:
	load    [$i18 + 0], $i19
	be      $i19, -1, bne_cont.36487
bne_then.36487:
	store   $i18, [min_caml_and_net + 0]
	li      1, $i2
	call    read_and_network.2729
bne_cont.36487:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.36488
be_then.36488:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.36488
be_else.36488:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.36489
be_then.36489:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.36489
be_else.36489:
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
be_cont.36489:
be_cont.36488:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	li      1, $i2
	bne     $i10, -1, be_else.36490
be_then.36490:
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.36490
be_else.36490:
.count stack_store
	store   $i3, [$sp + 16]
	call    read_or_network.2727
.count stack_load
	load    [$sp + 16], $i10
	store   $i10, [$i1 + 0]
be_cont.36490:
	mov     $i1, $ig2
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
	li      120, $i2
	mov     $hp, $i3
	add     $hp, 2, $hp
	store   $i10, [$i3 + 1]
.count stack_load
	load    [$sp + 17], $i10
	store   $i10, [$i3 + 0]
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	store   $i14, [min_caml_dirvecs + 4]
	load    [min_caml_dirvecs + 4], $i2
	li      118, $i3
	call    create_dirvec_elements.3039
	li      3, $i2
	call    create_dirvecs.3042
	li      0, $i1
	li      0, $i10
	li      4, $i11
	li      9, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f16
	fmul    $f16, $fc12, $f16
	fsub    $f16, $fc11, $f2
.count move_args
	mov     $i11, $i2
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3028
	li      8, $i2
	li      2, $i3
	li      4, $i4
	call    calc_dirvec_rows.3033
	load    [min_caml_dirvecs + 4], $i2
	li      119, $i3
	call    init_dirvec_constants.3044
	li      3, $i2
	call    init_vecset_constants.3047
	li      min_caml_light_dirvec, $i10
	load    [min_caml_light_dirvec + 0], $i11
	store   $fg12, [$i11 + 0]
	store   $fg13, [$i11 + 1]
	store   $fg14, [$i11 + 2]
	sub     $ig0, 1, $i12
	bl      $i12, 0, bge_cont.36491
bge_then.36491:
	load    [min_caml_light_dirvec + 1], $i13
	load    [min_caml_objects + $i12], $i14
	load    [$i14 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.36492
be_then.36492:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i11 + 0], $f10
	bne     $f10, $f0, be_else.36493
be_then.36493:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.36493
be_else.36493:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.36494
ble_then.36494:
	li      0, $i18
.count b_cont
	b       ble_cont.36494
ble_else.36494:
	li      1, $i18
ble_cont.36494:
	bne     $i17, 0, be_else.36495
be_then.36495:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36495
be_else.36495:
	bne     $i18, 0, be_else.36496
be_then.36496:
	li      1, $i17
.count b_cont
	b       be_cont.36496
be_else.36496:
	li      0, $i17
be_cont.36496:
be_cont.36495:
	load    [$i14 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.36497
be_then.36497:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.36497
be_else.36497:
	store   $f10, [$i16 + 0]
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.36497:
be_cont.36493:
	load    [$i11 + 1], $f10
	bne     $f10, $f0, be_else.36498
be_then.36498:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.36498
be_else.36498:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.36499
ble_then.36499:
	li      0, $i18
.count b_cont
	b       ble_cont.36499
ble_else.36499:
	li      1, $i18
ble_cont.36499:
	bne     $i17, 0, be_else.36500
be_then.36500:
	mov     $i18, $i17
.count b_cont
	b       be_cont.36500
be_else.36500:
	bne     $i18, 0, be_else.36501
be_then.36501:
	li      1, $i17
.count b_cont
	b       be_cont.36501
be_else.36501:
	li      0, $i17
be_cont.36501:
be_cont.36500:
	load    [$i14 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.36502
be_then.36502:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.36502
be_else.36502:
	store   $f10, [$i16 + 2]
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.36502:
be_cont.36498:
	load    [$i11 + 2], $f10
	bne     $f10, $f0, be_else.36503
be_then.36503:
	store   $f0, [$i16 + 5]
.count storer
	add     $i13, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36492
be_else.36503:
	load    [$i14 + 6], $i17
	load    [$i14 + 4], $i18
	bg      $f0, $f10, ble_else.36504
ble_then.36504:
	li      0, $i19
.count b_cont
	b       ble_cont.36504
ble_else.36504:
	li      1, $i19
ble_cont.36504:
	bne     $i17, 0, be_else.36505
be_then.36505:
	mov     $i19, $i17
.count b_cont
	b       be_cont.36505
be_else.36505:
	bne     $i19, 0, be_else.36506
be_then.36506:
	li      1, $i17
.count b_cont
	b       be_cont.36506
be_else.36506:
	li      0, $i17
be_cont.36506:
be_cont.36505:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i12, 1, $i3
.count storer
	add     $i13, $i12, $tmp
	bne     $i17, 0, be_else.36507
be_then.36507:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36492
be_else.36507:
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36492
be_else.36492:
	bne     $i15, 2, be_else.36508
be_then.36508:
	li      4, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i14 + 4], $i17
	load    [$i14 + 4], $i18
	load    [$i14 + 4], $i19
	load    [$i11 + 0], $f10
	load    [$i17 + 0], $f11
	fmul    $f10, $f11, $f10
	load    [$i11 + 1], $f11
	load    [$i18 + 1], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	load    [$i11 + 2], $f11
	load    [$i19 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_args
	mov     $i10, $i2
	sub     $i12, 1, $i3
.count storer
	add     $i13, $i12, $tmp
	bg      $f10, $f0, ble_else.36509
ble_then.36509:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36508
ble_else.36509:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i14 + 4], $i17
	load    [$i17 + 0], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 1]
	load    [$i14 + 4], $i17
	load    [$i17 + 1], $f11
	fmul_n  $f11, $f10, $f11
	store   $f11, [$i16 + 2]
	load    [$i14 + 4], $i17
	load    [$i17 + 2], $f11
	fmul_n  $f11, $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36508
be_else.36508:
	li      5, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i14 + 3], $i17
	load    [$i14 + 4], $i18
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i11 + 0], $f10
	load    [$i11 + 1], $f11
	load    [$i11 + 2], $f12
	fmul    $f10, $f10, $f13
	load    [$i18 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f11, $f11, $f14
	load    [$i19 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	bne     $i17, 0, be_else.36510
be_then.36510:
	mov     $f13, $f10
.count b_cont
	b       be_cont.36510
be_else.36510:
	fmul    $f11, $f12, $f14
	load    [$i14 + 9], $i18
	load    [$i18 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f12, $f10, $f12
	load    [$i14 + 9], $i18
	load    [$i18 + 1], $f14
	fmul    $f12, $f14, $f12
	fadd    $f13, $f12, $f12
	fmul    $f10, $f11, $f10
	load    [$i14 + 9], $i18
	load    [$i18 + 2], $f11
	fmul    $f10, $f11, $f10
	fadd    $f12, $f10, $f10
be_cont.36510:
	store   $f10, [$i16 + 0]
	load    [$i14 + 4], $i18
	load    [$i14 + 4], $i19
	load    [$i14 + 4], $i20
	load    [$i11 + 0], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i11 + 1], $f12
	load    [$i19 + 1], $f13
	fmul    $f12, $f13, $f13
	load    [$i11 + 2], $f14
	load    [$i20 + 2], $f15
	fmul    $f14, $f15, $f15
	fneg    $f11, $f11
	fneg    $f13, $f13
	fneg    $f15, $f15
.count storer
	add     $i13, $i12, $tmp
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	bne     $i17, 0, be_else.36511
be_then.36511:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.36512
be_then.36512:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36511
be_else.36512:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36511
be_else.36511:
	load    [$i14 + 9], $i17
	load    [$i14 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $fc3, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i14 + 9], $i17
	load    [$i11 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i11 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $fc3, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.36513
be_then.36513:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36513
be_else.36513:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36513:
be_cont.36511:
be_cont.36508:
be_cont.36492:
bge_cont.36491:
	sub     $ig0, 1, $i2
	call    setup_reflections.3064
	li      0, $i1
	sub     $ig1, 1, $i10
	sub     $i0, $ig7, $i2
	call    min_caml_float_of_int
	fmul    $fg17, $f1, $f1
	fmul    $f1, $fg24, $f2
	fadd    $f2, $fg18, $f2
	load    [min_caml_screeny_dir + 1], $f3
	fmul    $f1, $f3, $f3
	fadd    $f3, $fg19, $f3
	load    [min_caml_screeny_dir + 2], $f4
	fmul    $f1, $f4, $f1
	fadd    $f1, $fg20, $f4
.count stack_load
	load    [$sp + 2], $i2
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i1, $i4
	call    pretrace_pixels.2983
	li      0, $i2
	li      2, $i6
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
