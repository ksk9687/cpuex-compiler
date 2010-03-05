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
.define { fadd_abs %fReg, %fReg, %fReg } { fadd 2 %1 %2 %3 }
.define { fsub_abs %fReg, %fReg, %fReg } { fsub 2 %1 %2 %3 }
.define { fmul_abs %fReg, %fReg, %fReg } { fmul 2 %1 %2 %3 }
.define { finv_abs %fReg, %fReg } { finv 2 %1 %2 }
.define { fsqrt_abs %fReg, %fReg } { fsqrt 2 %1 %2 }
.define { fabs %fReg, %fReg } { fmov 2 %1 %2 }
.define { fadd_neg %fReg, %fReg, %fReg } { fadd 1 %1 %2 %3 }
.define { fsub_neg %fReg, %fReg, %fReg } { fsub 1 %1 %2 %3 }
.define { fmul_neg %fReg, %fReg, %fReg } { fmul 1 %1 %2 %3 }
.define { finv_neg %fReg, %fReg } { finv 1 %1 %2 }
.define { fsqrt_neg %fReg, %fReg } { fsqrt 1 %1 %2 }
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
#
# 		↑　ここまで lib_asm.s
#
######################################################################

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
f.34915:	.float  1.2800000000E+02
f.34853:	.float  9.0000000000E-01
f.34852:	.float  2.0000000000E-01
f.34824:	.float  1.5000000000E+02
f.34823:	.float  -1.5000000000E+02
f.34822:	.float  6.6666666667E-03
f.34821:	.float  -6.6666666667E-03
f.34820:	.float  -2.0000000000E+00
f.34819:	.float  3.9062500000E-03
f.34818:	.float  2.5600000000E+02
f.34817:	.float  1.0000000000E+08
f.34816:	.float  1.0000000000E+09
f.34815:	.float  1.0000000000E+01
f.34814:	.float  2.0000000000E+01
f.34813:	.float  5.0000000000E-02
f.34812:	.float  2.5000000000E-01
f.34811:	.float  1.0000000000E-01
f.34810:	.float  3.3333333333E+00
f.34809:	.float  2.5500000000E+02
f.34808:	.float  3.1830988148E-01
f.34807:	.float  3.1415927000E+00
f.34806:	.float  3.0000000000E+01
f.34805:	.float  1.5000000000E+01
f.34804:	.float  1.0000000000E-04
f.34803:	.float  1.5000000000E-01
f.34802:	.float  -1.0000000000E-01
f.34801:	.float  1.0000000000E-02
f.34800:	.float  -2.0000000000E-01
f.34799:	.float  1.0000000000E+00
f.34798:	.float  -1.0000000000E+00
f.34785:	.float  2.0000000000E+00
f.34784:	.float  -2.0000000000E+02
f.34783:	.float  2.0000000000E+02
f.34782:	.float  1.7453293000E-02
f.34781:	.float  6.2831853072E+00
f.34780:	.float  3.1415926536E+00
f.34779:	.float  -6.0725293501E-01
f.34778:	.float  6.0725293501E-01
f.34777:	.float  1.5707963268E+00
f.34775:	.float  5.0000000000E-01

######################################################################
.begin cordic_rec
cordic_rec.6342.29081:
	bne     $i2, 25, be_else.38551
be_then.38551:
	mov     $f4, $f1
	ret
be_else.38551:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38552
ble_then.38552:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38553
be_then.38553:
	ret
be_else.38553:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38554
ble_then.38554:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29081
ble_else.38554:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29081
ble_else.38552:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38555
be_then.38555:
	ret
be_else.38555:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38556
ble_then.38556:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29081
ble_else.38556:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29081
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.32670:
	bne     $i2, 25, be_else.38557
be_then.38557:
	mov     $f4, $f1
	ret
be_else.38557:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38558
ble_then.38558:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38559
be_then.38559:
	ret
be_else.38559:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38560
ble_then.38560:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32670
ble_else.38560:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32670
ble_else.38558:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38561
be_then.38561:
	ret
be_else.38561:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38562
ble_then.38562:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32670
ble_else.38562:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32670
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.11361:
	bne     $i2, 25, be_else.38563
be_then.38563:
	mov     $f4, $f1
	ret
be_else.38563:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38564
ble_then.38564:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38565
be_then.38565:
	ret
be_else.38565:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38566
ble_then.38566:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11361
ble_else.38566:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11361
ble_else.38564:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38567
be_then.38567:
	ret
be_else.38567:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38568
ble_then.38568:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11361
ble_else.38568:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11361
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.11396:
	bne     $i2, 25, be_else.38569
be_then.38569:
	mov     $f4, $f1
	ret
be_else.38569:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38570
ble_then.38570:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38571
be_then.38571:
	ret
be_else.38571:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38572
ble_then.38572:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11396
ble_else.38572:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11396
ble_else.38570:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38573
be_then.38573:
	ret
be_else.38573:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38574
ble_then.38574:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11396
ble_else.38574:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.11396
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.29165:
	bne     $i2, 25, be_else.38575
be_then.38575:
	mov     $f4, $f1
	ret
be_else.38575:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38576
ble_then.38576:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38577
be_then.38577:
	ret
be_else.38577:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38578
ble_then.38578:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29165
ble_else.38578:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29165
ble_else.38576:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38579
be_then.38579:
	ret
be_else.38579:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38580
ble_then.38580:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29165
ble_else.38580:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.29165
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.32761:
	bne     $i2, 25, be_else.38581
be_then.38581:
	mov     $f4, $f1
	ret
be_else.38581:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38582
ble_then.38582:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38583
be_then.38583:
	ret
be_else.38583:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38584
ble_then.38584:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32761
ble_else.38584:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32761
ble_else.38582:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38585
be_then.38585:
	ret
be_else.38585:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38586
ble_then.38586:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32761
ble_else.38586:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.32761
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19974:
	bne     $i2, 25, be_else.38587
be_then.38587:
	mov     $f4, $f1
	ret
be_else.38587:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38588
ble_then.38588:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38589
be_then.38589:
	ret
be_else.38589:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38590
ble_then.38590:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19974
ble_else.38590:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19974
ble_else.38588:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38591
be_then.38591:
	ret
be_else.38591:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38592
ble_then.38592:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19974
ble_else.38592:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19974
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20058:
	bne     $i2, 25, be_else.38593
be_then.38593:
	mov     $f4, $f1
	ret
be_else.38593:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38594
ble_then.38594:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38595
be_then.38595:
	ret
be_else.38595:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38596
ble_then.38596:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20058
ble_else.38596:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20058
ble_else.38594:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38597
be_then.38597:
	ret
be_else.38597:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38598
ble_then.38598:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20058
ble_else.38598:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20058
.end cordic_rec

######################################################################
.begin sin
sin.2657:
	bg      $f0, $f2, ble_else.38599
ble_then.38599:
.count load_float
	load    [f.34777], $f10
	bg      $f10, $f2, ble_else.38600
ble_then.38600:
.count load_float
	load    [f.34780], $f11
	bg      $f11, $f2, ble_else.38601
ble_then.38601:
.count load_float
	load    [f.34781], $f12
	bg      $f12, $f2, ble_else.38602
ble_then.38602:
	fsub    $f2, $f12, $f13
	bg      $f0, $f13, ble_else.38603
ble_then.38603:
	bg      $f10, $f13, ble_else.38604
ble_then.38604:
	bg      $f11, $f13, ble_else.38605
ble_then.38605:
	bg      $f12, $f13, ble_else.38606
ble_then.38606:
	fsub    $f13, $f12, $f2
	b       sin.2657
ble_else.38606:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f12, $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38605:
	fsub    $f11, $f13, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38607
ble_then.38607:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.20058
ble_else.38607:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.20058
ble_else.38604:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f13, $f2
	li      1, $i2
	bg      $f13, $f0, ble_else.38608
ble_then.38608:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.19974
ble_else.38608:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.19974
ble_else.38603:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fneg    $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38602:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f12, $f2, $f13
	bg      $f0, $f13, ble_else.38609
ble_then.38609:
	bg      $f10, $f13, ble_else.38610
ble_then.38610:
	bg      $f11, $f13, ble_else.38611
ble_then.38611:
	bg      $f12, $f13, ble_else.38612
ble_then.38612:
	fsub    $f13, $f12, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38612:
	fsub    $f12, $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38611:
	fsub    $f11, $f13, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38613
ble_then.38613:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.32761
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38613:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.32761
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38610:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f13, $f2
	li      1, $i2
	bg      $f13, $f0, ble_else.38614
ble_then.38614:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.29165
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38614:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.29165
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38609:
	fneg    $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38601:
	fsub    $f11, $f2, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38615
ble_then.38615:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.11396
ble_else.38615:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.11396
ble_else.38600:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38616
ble_then.38616:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.11361
ble_else.38616:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.11361
ble_else.38599:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fneg    $f2, $f10
	bg      $f0, $f10, ble_else.38617
ble_then.38617:
.count load_float
	load    [f.34777], $f11
	bg      $f11, $f10, ble_else.38618
ble_then.38618:
.count load_float
	load    [f.34780], $f11
	bg      $f11, $f10, ble_else.38619
ble_then.38619:
.count load_float
	load    [f.34781], $f1
	bg      $f1, $f10, ble_else.38620
ble_then.38620:
	fsub    $f10, $f1, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38620:
	fsub    $f1, $f10, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38619:
	fsub    $f11, $f10, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38621
ble_then.38621:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.32670
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38621:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.32670
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38618:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f10, $f2
	li      1, $i2
	bg      $f10, $f0, ble_else.38622
ble_then.38622:
	load    [min_caml_atan_table + 0], $f11
	fneg    $f11, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.29081
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38622:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.29081
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38617:
	fneg    $f10, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
.end sin

######################################################################
.begin cordic_rec
cordic_rec.6342.19662:
	bne     $i2, 25, be_else.38623
be_then.38623:
	mov     $f4, $f1
	ret
be_else.38623:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38624
ble_then.38624:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38625
be_then.38625:
	ret
be_else.38625:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38626
ble_then.38626:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19662
ble_else.38626:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19662
ble_else.38624:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38627
be_then.38627:
	ret
be_else.38627:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38628
ble_then.38628:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19662
ble_else.38628:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19662
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19746:
	bne     $i2, 25, be_else.38629
be_then.38629:
	mov     $f4, $f1
	ret
be_else.38629:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38630
ble_then.38630:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38631
be_then.38631:
	ret
be_else.38631:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38632
ble_then.38632:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19746
ble_else.38632:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19746
ble_else.38630:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38633
be_then.38633:
	ret
be_else.38633:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38634
ble_then.38634:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19746
ble_else.38634:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19746
.end cordic_rec

######################################################################
.begin cos
cos.2659:
.count load_float
	load    [f.34777], $f14
	fsub    $f14, $f2, $f15
	bg      $f0, $f15, ble_else.38635
ble_then.38635:
	bg      $f14, $f15, ble_else.38636
ble_then.38636:
.count load_float
	load    [f.34780], $f14
	bg      $f14, $f15, ble_else.38637
ble_then.38637:
.count load_float
	load    [f.34781], $f14
	bg      $f14, $f15, ble_else.38638
ble_then.38638:
	fsub    $f15, $f14, $f2
	b       sin.2657
ble_else.38638:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f14, $f15, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38637:
	fsub    $f14, $f15, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38639
ble_then.38639:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.19746
ble_else.38639:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.19746
ble_else.38636:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f15, $f2
	li      1, $i2
	bg      $f15, $f0, ble_else.38640
ble_then.38640:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	b       cordic_rec.6342.19662
ble_else.38640:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	b       cordic_rec.6342.19662
ble_else.38635:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fneg    $f15, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
.end cos

######################################################################
.begin cordic_rec
cordic_rec.6342.19326:
	bne     $i2, 25, be_else.38641
be_then.38641:
	mov     $f4, $f1
	ret
be_else.38641:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38642
ble_then.38642:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38643
be_then.38643:
	ret
be_else.38643:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38644
ble_then.38644:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19326
ble_else.38644:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19326
ble_else.38642:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38645
be_then.38645:
	ret
be_else.38645:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38646
ble_then.38646:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19326
ble_else.38646:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19326
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19410:
	bne     $i2, 25, be_else.38647
be_then.38647:
	mov     $f4, $f1
	ret
be_else.38647:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38648
ble_then.38648:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38649
be_then.38649:
	ret
be_else.38649:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38650
ble_then.38650:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19410
ble_else.38650:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19410
ble_else.38648:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38651
be_then.38651:
	ret
be_else.38651:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38652
ble_then.38652:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19410
ble_else.38652:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19410
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19494:
	bne     $i2, 25, be_else.38653
be_then.38653:
	mov     $f4, $f1
	ret
be_else.38653:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38654
ble_then.38654:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38655
be_then.38655:
	ret
be_else.38655:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38656
ble_then.38656:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19494
ble_else.38656:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19494
ble_else.38654:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38657
be_then.38657:
	ret
be_else.38657:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38658
ble_then.38658:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19494
ble_else.38658:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19494
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19578:
	bne     $i2, 25, be_else.38659
be_then.38659:
	mov     $f4, $f1
	ret
be_else.38659:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38660
ble_then.38660:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38661
be_then.38661:
	ret
be_else.38661:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38662
ble_then.38662:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19578
ble_else.38662:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19578
ble_else.38660:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38663
be_then.38663:
	ret
be_else.38663:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38664
ble_then.38664:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19578
ble_else.38664:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19578
.end cordic_rec

######################################################################
.begin read_screen_settings
read_screen_settings.2791:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
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
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f14
.count load_float
	load    [f.34777], $f15
.count load_float
	load    [f.34782], $f16
	fmul    $f10, $f16, $f17
	fsub    $f15, $f17, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fmul    $f14, $f16, $f14
	bg      $f0, $f14, ble_else.38665
ble_then.38665:
	bg      $f15, $f14, ble_else.38666
ble_then.38666:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.38667
ble_then.38667:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.38668
ble_then.38668:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38668:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38667:
	fsub    $f16, $f14, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38669
ble_then.38669:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19578
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38669:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19578
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38666:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f14, $f2
	li      1, $i2
	bg      $f14, $f0, ble_else.38670
ble_then.38670:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19494
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38670:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19494
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38665
ble_else.38665:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
ble_cont.38665:
	fmul    $f18, $f16, $f19
.count load_float
	load    [f.34783], $f20
	fmul    $f19, $f20, $f19
.count move_float
	mov     $f19, $f62
.count load_float
	load    [f.34784], $f19
	bg      $f0, $f17, ble_else.38671
ble_then.38671:
	bg      $f15, $f17, ble_else.38672
ble_then.38672:
.count load_float
	load    [f.34780], $f21
	bg      $f21, $f17, ble_else.38673
ble_then.38673:
.count load_float
	load    [f.34781], $f21
	bg      $f21, $f17, ble_else.38674
ble_then.38674:
	fsub    $f17, $f21, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38674:
	fsub    $f21, $f17, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
	fneg    $f17, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38673:
	fsub    $f21, $f17, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38675
ble_then.38675:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19410
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38675:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19410
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38672:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f17, $f2
	li      1, $i2
	bg      $f17, $f0, ble_else.38676
ble_then.38676:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19326
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38676:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19326
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38671
ble_else.38671:
	fneg    $f17, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
	fneg    $f17, $f17
ble_cont.38671:
	fmul    $f17, $f19, $f19
.count move_float
	mov     $f19, $f63
	fsub    $f15, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fmul    $f18, $f1, $f2
	fmul    $f2, $f20, $f2
	store   $f2, [min_caml_screenz_dir + 2]
	store   $f1, [min_caml_screenx_dir + 0]
	store   $f0, [min_caml_screenx_dir + 1]
	fneg    $f16, $f2
	store   $f2, [min_caml_screenx_dir + 2]
	fneg    $f17, $f2
	fmul    $f2, $f16, $f3
	store   $f3, [min_caml_screeny_dir + 0]
	fneg    $f18, $f3
	store   $f3, [min_caml_screeny_dir + 1]
	fmul    $f2, $f1, $f1
	store   $f1, [min_caml_screeny_dir + 2]
	load    [min_caml_screen + 0], $f1
	fsub    $f1, $f62, $f1
	store   $f1, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $f1
	fsub    $f1, $f63, $f1
	store   $f1, [min_caml_viewpoint + 1]
	load    [min_caml_screen + 2], $f1
	load    [min_caml_screenz_dir + 2], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [min_caml_viewpoint + 2]
	ret
.end read_screen_settings

######################################################################
.begin cordic_rec
cordic_rec.6342.18822:
	bne     $i2, 25, be_else.38677
be_then.38677:
	mov     $f4, $f1
	ret
be_else.38677:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38678
ble_then.38678:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38679
be_then.38679:
	ret
be_else.38679:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38680
ble_then.38680:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18822
ble_else.38680:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18822
ble_else.38678:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38681
be_then.38681:
	ret
be_else.38681:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38682
ble_then.38682:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18822
ble_else.38682:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18822
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.18906:
	bne     $i2, 25, be_else.38683
be_then.38683:
	mov     $f4, $f1
	ret
be_else.38683:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38684
ble_then.38684:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38685
be_then.38685:
	ret
be_else.38685:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38686
ble_then.38686:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18906
ble_else.38686:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18906
ble_else.38684:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38687
be_then.38687:
	ret
be_else.38687:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38688
ble_then.38688:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18906
ble_else.38688:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18906
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.18990:
	bne     $i2, 25, be_else.38689
be_then.38689:
	mov     $f4, $f1
	ret
be_else.38689:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38690
ble_then.38690:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38691
be_then.38691:
	ret
be_else.38691:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38692
ble_then.38692:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18990
ble_else.38692:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18990
ble_else.38690:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38693
be_then.38693:
	ret
be_else.38693:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38694
ble_then.38694:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18990
ble_else.38694:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.18990
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19074:
	bne     $i2, 25, be_else.38695
be_then.38695:
	mov     $f4, $f1
	ret
be_else.38695:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38696
ble_then.38696:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38697
be_then.38697:
	ret
be_else.38697:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38698
ble_then.38698:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19074
ble_else.38698:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19074
ble_else.38696:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38699
be_then.38699:
	ret
be_else.38699:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38700
ble_then.38700:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19074
ble_else.38700:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19074
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19158:
	bne     $i2, 25, be_else.38701
be_then.38701:
	mov     $f4, $f1
	ret
be_else.38701:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38702
ble_then.38702:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38703
be_then.38703:
	ret
be_else.38703:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38704
ble_then.38704:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19158
ble_else.38704:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19158
ble_else.38702:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38705
be_then.38705:
	ret
be_else.38705:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38706
ble_then.38706:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19158
ble_else.38706:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19158
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19242:
	bne     $i2, 25, be_else.38707
be_then.38707:
	mov     $f4, $f1
	ret
be_else.38707:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38708
ble_then.38708:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38709
be_then.38709:
	ret
be_else.38709:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38710
ble_then.38710:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19242
ble_else.38710:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19242
ble_else.38708:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38711
be_then.38711:
	ret
be_else.38711:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.38712
ble_then.38712:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19242
ble_else.38712:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.19242
.end cordic_rec

######################################################################
.begin rotate_quadratic_matrix
rotate_quadratic_matrix.2795:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [$i3 + 1], $f14
.count load_float
	load    [f.34777], $f15
	fsub    $f15, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f14
	load    [$i3 + 2], $f16
	fsub    $f15, $f16, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fmul    $f14, $f16, $f17
	fmul    $f17, $f17, $f18
.count stack_load
	load    [$sp + 1], $i10
	load    [$i10 + 0], $f19
	fmul    $f19, $f18, $f18
	load    [$i3 + 2], $f20
	bg      $f0, $f20, ble_else.38713
ble_then.38713:
	bg      $f15, $f20, ble_else.38714
ble_then.38714:
.count load_float
	load    [f.34780], $f21
	bg      $f21, $f20, ble_else.38715
ble_then.38715:
.count load_float
	load    [f.34781], $f21
	bg      $f21, $f20, ble_else.38716
ble_then.38716:
	fsub    $f20, $f21, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38716:
	fsub    $f21, $f20, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
	fneg    $f20, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38715:
	fsub    $f21, $f20, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38717
ble_then.38717:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19242
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38717:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19242
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38714:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f20, $f2
	li      1, $i2
	bg      $f20, $f0, ble_else.38718
ble_then.38718:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19158
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38718:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19158
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38713
ble_else.38713:
	fneg    $f20, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
	fneg    $f20, $f20
ble_cont.38713:
	fmul    $f14, $f20, $f21
	fmul    $f21, $f21, $f22
	load    [$i10 + 1], $f23
	fmul    $f23, $f22, $f22
	fadd    $f18, $f22, $f18
	load    [$i3 + 1], $f22
	bg      $f0, $f22, ble_else.38719
ble_then.38719:
	bg      $f15, $f22, ble_else.38720
ble_then.38720:
.count load_float
	load    [f.34780], $f24
	bg      $f24, $f22, ble_else.38721
ble_then.38721:
.count load_float
	load    [f.34781], $f24
	bg      $f24, $f22, ble_else.38722
ble_then.38722:
	fsub    $f22, $f24, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38722:
	fsub    $f24, $f22, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
	fneg    $f22, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38721:
	fsub    $f24, $f22, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38723
ble_then.38723:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.19074
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38723:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.19074
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38720:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f22, $f2
	li      1, $i2
	bg      $f22, $f0, ble_else.38724
ble_then.38724:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.18990
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38724:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.18990
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38719
ble_else.38719:
	fneg    $f22, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
	fneg    $f22, $f22
ble_cont.38719:
	fneg    $f22, $f24
	fmul    $f24, $f24, $f25
	load    [$i10 + 2], $f26
	fmul    $f26, $f25, $f25
	fadd    $f18, $f25, $f18
	store   $f18, [$i10 + 0]
	load    [$i3 + 0], $f18
	bg      $f0, $f18, ble_else.38725
ble_then.38725:
	bg      $f15, $f18, ble_else.38726
ble_then.38726:
.count load_float
	load    [f.34780], $f25
	bg      $f25, $f18, ble_else.38727
ble_then.38727:
.count load_float
	load    [f.34781], $f25
	bg      $f25, $f18, ble_else.38728
ble_then.38728:
	fsub    $f18, $f25, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38728:
	fsub    $f25, $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38727:
	fsub    $f25, $f18, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.38729
ble_then.38729:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.18906
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38729:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.18906
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38726:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f18, $f2
	li      1, $i2
	bg      $f18, $f0, ble_else.38730
ble_then.38730:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.18822
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38730:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.18822
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38725
ble_else.38725:
	fneg    $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
ble_cont.38725:
	fmul    $f18, $f22, $f25
	fmul    $f25, $f16, $f27
	load    [$i3 + 0], $f28
	fsub    $f15, $f28, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 2, $sp
	fmul    $f1, $f20, $f2
	fsub    $f27, $f2, $f2
	fmul    $f2, $f2, $f3
	fmul    $f19, $f3, $f3
	fmul    $f25, $f20, $f4
	fmul    $f1, $f16, $f5
	fadd    $f4, $f5, $f4
	fmul    $f4, $f4, $f5
	fmul    $f23, $f5, $f5
	fadd    $f3, $f5, $f3
	fmul    $f18, $f14, $f5
	fmul    $f5, $f5, $f6
	fmul    $f26, $f6, $f6
	fadd    $f3, $f6, $f3
	store   $f3, [$i10 + 1]
	fmul    $f1, $f22, $f3
	fmul    $f3, $f16, $f6
	fmul    $f18, $f20, $f7
	fadd    $f6, $f7, $f6
	fmul    $f6, $f6, $f7
	fmul    $f19, $f7, $f7
	fmul    $f3, $f20, $f3
	fmul    $f18, $f16, $f8
	fsub    $f3, $f8, $f3
	fmul    $f3, $f3, $f8
	fmul    $f23, $f8, $f8
	fadd    $f7, $f8, $f7
	fmul    $f1, $f14, $f1
	fmul    $f1, $f1, $f8
	fmul    $f26, $f8, $f8
	fadd    $f7, $f8, $f7
	store   $f7, [$i10 + 2]
.count load_float
	load    [f.34785], $f7
	fmul    $f19, $f2, $f8
	fmul    $f8, $f6, $f8
	fmul    $f23, $f4, $f9
	fmul    $f9, $f3, $f9
	fadd    $f8, $f9, $f8
	fmul    $f26, $f5, $f9
	fmul    $f9, $f1, $f9
	fadd    $f8, $f9, $f8
	fmul    $f7, $f8, $f8
	store   $f8, [$i3 + 0]
	fmul    $f19, $f17, $f8
	fmul    $f8, $f6, $f6
	fmul    $f23, $f21, $f9
	fmul    $f9, $f3, $f3
	fadd    $f6, $f3, $f3
	fmul    $f26, $f24, $f6
	fmul    $f6, $f1, $f1
	fadd    $f3, $f1, $f1
	fmul    $f7, $f1, $f1
	store   $f1, [$i3 + 1]
	fmul    $f8, $f2, $f1
	fmul    $f9, $f4, $f2
	fadd    $f1, $f2, $f1
	fmul    $f6, $f5, $f2
	fadd    $f1, $f2, $f1
	fmul    $f7, $f1, $f1
	store   $f1, [$i3 + 2]
	ret
.end rotate_quadratic_matrix

######################################################################
.begin read_nth_object
read_nth_object.2798:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38731
be_then.38731:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.38731:
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
	be      $i13, 0, bne_cont.38732
bne_then.38732:
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f10
.count load_float
	load    [f.34782], $f11
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
bne_cont.38732:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
.count stack_load
	load    [$sp + 2], $f29
	bg      $f0, $f29, ble_else.38733
ble_then.38733:
	li      0, $i20
.count b_cont
	b       ble_cont.38733
ble_else.38733:
	li      1, $i20
ble_cont.38733:
	bne     $i11, 2, be_else.38734
be_then.38734:
	li      1, $i21
.count b_cont
	b       be_cont.38734
be_else.38734:
	mov     $i20, $i21
be_cont.38734:
	mov     $hp, $i22
	add     $hp, 11, $hp
	store   $i19, [$i22 + 10]
	store   $i18, [$i22 + 9]
	store   $i17, [$i22 + 8]
	store   $i16, [$i22 + 7]
	store   $i21, [$i22 + 6]
	store   $i15, [$i22 + 5]
	store   $i14, [$i22 + 4]
	store   $i13, [$i22 + 3]
	store   $i12, [$i22 + 2]
	store   $i11, [$i22 + 1]
	store   $i10, [$i22 + 0]
	mov     $i22, $i12
.count stack_load
	load    [$sp + 1], $i15
	store   $i12, [min_caml_objects + $i15]
	bne     $i11, 3, be_else.38735
be_then.38735:
	load    [$i14 + 0], $f29
	bne     $f29, $f0, be_else.38736
be_then.38736:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38736
be_else.38736:
	bne     $f29, $f0, be_else.38737
be_then.38737:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38737
be_else.38737:
	bg      $f29, $f0, ble_else.38738
ble_then.38738:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38738
ble_else.38738:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38738:
be_cont.38737:
be_cont.38736:
	store   $f29, [$i14 + 0]
	load    [$i14 + 1], $f29
	bne     $f29, $f0, be_else.38739
be_then.38739:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38739
be_else.38739:
	bne     $f29, $f0, be_else.38740
be_then.38740:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38740
be_else.38740:
	bg      $f29, $f0, ble_else.38741
ble_then.38741:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38741
ble_else.38741:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38741:
be_cont.38740:
be_cont.38739:
	store   $f29, [$i14 + 1]
	load    [$i14 + 2], $f29
	bne     $f29, $f0, be_else.38742
be_then.38742:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38742
be_else.38742:
	bne     $f29, $f0, be_else.38743
be_then.38743:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38743
be_else.38743:
	bg      $f29, $f0, ble_else.38744
ble_then.38744:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38744
ble_else.38744:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38744:
be_cont.38743:
be_cont.38742:
	store   $f29, [$i14 + 2]
	bne     $i13, 0, be_else.38745
be_then.38745:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38745:
.count move_args
	mov     $i14, $i2
.count move_args
	mov     $i18, $i3
	call    rotate_quadratic_matrix.2795
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38735:
	bne     $i11, 2, be_else.38746
be_then.38746:
	load    [$i14 + 0], $f29
	bne     $i20, 0, be_else.38747
be_then.38747:
	li      1, $i11
.count b_cont
	b       be_cont.38747
be_else.38747:
	li      0, $i11
be_cont.38747:
	fmul    $f29, $f29, $f30
	load    [$i14 + 1], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	load    [$i14 + 2], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	fsqrt   $f30, $f30
	bne     $f30, $f0, be_else.38748
be_then.38748:
	mov     $f40, $f30
.count b_cont
	b       be_cont.38748
be_else.38748:
	finv    $f30, $f30
	be      $i11, 0, bne_cont.38749
bne_then.38749:
.count load_float
	load    [f.34798], $f31
	fneg    $f30, $f30
bne_cont.38749:
be_cont.38748:
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 0]
	load    [$i14 + 1], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 1]
	load    [$i14 + 2], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 2]
	bne     $i13, 0, be_else.38750
be_then.38750:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38750:
.count move_args
	mov     $i14, $i2
.count move_args
	mov     $i18, $i3
	call    rotate_quadratic_matrix.2795
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38746:
	bne     $i13, 0, be_else.38751
be_then.38751:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38751:
.count move_args
	mov     $i14, $i2
.count move_args
	mov     $i18, $i3
	call    rotate_quadratic_matrix.2795
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
.end read_nth_object

######################################################################
.begin read_object
read_object.2800:
	bl      $i2, 60, bge_else.38752
bge_then.38752:
	ret
bge_else.38752:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38753
be_then.38753:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38753:
.count stack_load
	load    [$sp + 1], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38754
bge_then.38754:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38754:
.count stack_store
	store   $i2, [$sp + 2]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38755
be_then.38755:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38755:
.count stack_load
	load    [$sp + 2], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38756
bge_then.38756:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38756:
.count stack_store
	store   $i2, [$sp + 3]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38757
be_then.38757:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 6], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38757:
.count stack_load
	load    [$sp + 3], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38758
bge_then.38758:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38758:
.count stack_store
	store   $i2, [$sp + 4]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38759
be_then.38759:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38759:
.count stack_load
	load    [$sp + 4], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38760
bge_then.38760:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38760:
.count stack_store
	store   $i2, [$sp + 5]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38761
be_then.38761:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38761:
.count stack_load
	load    [$sp + 5], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38762
bge_then.38762:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38762:
.count stack_store
	store   $i2, [$sp + 6]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38763
be_then.38763:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38763:
.count stack_load
	load    [$sp + 6], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38764
bge_then.38764:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38764:
.count stack_store
	store   $i2, [$sp + 7]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38765
be_then.38765:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38765:
.count stack_load
	load    [$sp + 7], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38766
bge_then.38766:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38766:
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2798
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	bne     $i1, 0, be_else.38767
be_then.38767:
.count stack_load
	load    [$sp - 1], $i1
.count move_float
	mov     $i1, $i51
	ret
be_else.38767:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
	b       read_object.2800
.end read_object

######################################################################
.begin read_net_item
read_net_item.2804:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38768
be_then.38768:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i10
	add     $i10, 1, $i2
	add     $i0, -1, $i3
	b       min_caml_create_array_int
be_else.38768:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
.count stack_load
	load    [$sp + 1], $i12
	add     $i12, 1, $i13
	bne     $i11, -1, be_else.38769
be_then.38769:
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
be_else.38769:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i14
	add     $i13, 1, $i15
	bne     $i14, -1, be_else.38770
be_then.38770:
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
be_else.38770:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i16
	add     $i15, 1, $i17
	add     $i17, 1, $i2
	bne     $i16, -1, be_else.38771
be_then.38771:
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
be_else.38771:
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
	call    read_net_item.2804
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
.begin read_or_network
read_or_network.2806:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38772
be_then.38772:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38772
be_else.38772:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38773
be_then.38773:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38773
be_else.38773:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38774
be_then.38774:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38774
be_else.38774:
.count stack_store
	store   $i10, [$sp + 2]
.count stack_store
	store   $i11, [$sp + 3]
.count stack_store
	store   $i12, [$sp + 4]
	call    read_net_item.2804
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
be_cont.38774:
be_cont.38773:
be_cont.38772:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.38775
be_then.38775:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $i10
	add     $i10, 1, $i2
	b       min_caml_create_array_int
be_else.38775:
.count stack_store
	store   $i3, [$sp + 5]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38776
be_then.38776:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38776
be_else.38776:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38777
be_then.38777:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38777
be_else.38777:
.count stack_store
	store   $i10, [$sp + 6]
.count stack_store
	store   $i11, [$sp + 7]
	call    read_net_item.2804
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 7], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 6], $i11
	store   $i11, [$i10 + 0]
be_cont.38777:
be_cont.38776:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i12
	add     $i12, 1, $i2
	bne     $i10, -1, be_else.38778
be_then.38778:
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
be_else.38778:
.count stack_store
	store   $i12, [$sp + 8]
.count stack_store
	store   $i3, [$sp + 9]
	call    read_or_network.2806
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
.begin read_and_network
read_and_network.2808:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38779
be_then.38779:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38779
be_else.38779:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38780
be_then.38780:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38780
be_else.38780:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38781
be_then.38781:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38781
be_else.38781:
.count stack_store
	store   $i10, [$sp + 2]
.count stack_store
	store   $i11, [$sp + 3]
.count stack_store
	store   $i12, [$sp + 4]
	call    read_net_item.2804
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
be_cont.38781:
be_cont.38780:
be_cont.38779:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38782
be_then.38782:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38782:
.count stack_load
	load    [$sp + 1], $i11
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38783
be_then.38783:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38783
be_else.38783:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38784
be_then.38784:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38784
be_else.38784:
.count stack_store
	store   $i10, [$sp + 5]
.count stack_store
	store   $i11, [$sp + 6]
	call    read_net_item.2804
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 6], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 5], $i11
	store   $i11, [$i10 + 0]
be_cont.38784:
be_cont.38783:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38785
be_then.38785:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38785:
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 7]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38786
be_then.38786:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38786
be_else.38786:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38787
be_then.38787:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38787
be_else.38787:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38788
be_then.38788:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38788
be_else.38788:
.count stack_store
	store   $i10, [$sp + 8]
.count stack_store
	store   $i11, [$sp + 9]
.count stack_store
	store   $i12, [$sp + 10]
	call    read_net_item.2804
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
be_cont.38788:
be_cont.38787:
be_cont.38786:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38789
be_then.38789:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38789:
.count stack_load
	load    [$sp + 7], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 11]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38790
be_then.38790:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.38790
be_else.38790:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38791
be_then.38791:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
	store   $i10, [$i1 + 0]
.count b_cont
	b       be_cont.38791
be_else.38791:
.count stack_store
	store   $i10, [$sp + 12]
.count stack_store
	store   $i11, [$sp + 13]
	call    read_net_item.2804
.count stack_load
	load    [$sp + 13], $i2
	store   $i2, [$i1 + 1]
.count stack_load
	load    [$sp + 12], $i2
	store   $i2, [$i1 + 0]
be_cont.38791:
be_cont.38790:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.38792
be_then.38792:
	ret
be_else.38792:
.count stack_load
	load    [$sp - 3], $i2
	add     $i2, 1, $i2
	store   $i1, [min_caml_and_net + $i2]
	add     $i2, 1, $i2
	b       read_and_network.2808
.end read_and_network

######################################################################
.begin solver
solver.2852:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 5], $i2
	load    [$i1 + 5], $i4
	load    [$i1 + 5], $i5
	load    [$i1 + 1], $i6
	load    [min_caml_startp + 0], $f1
	load    [$i2 + 0], $f2
	load    [min_caml_startp + 1], $f3
	load    [$i4 + 1], $f4
	load    [min_caml_startp + 2], $f5
	load    [$i5 + 2], $f6
	fsub    $f1, $f2, $f1
	fsub    $f3, $f4, $f2
	fsub    $f5, $f6, $f3
	load    [$i3 + 0], $f4
	bne     $i6, 1, be_else.38793
be_then.38793:
	bne     $f4, $f0, be_else.38794
be_then.38794:
	li      0, $i2
.count b_cont
	b       be_cont.38794
be_else.38794:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f5
	load    [$i3 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.38795
ble_then.38795:
	li      0, $i5
.count b_cont
	b       ble_cont.38795
ble_else.38795:
	li      1, $i5
ble_cont.38795:
	bne     $i4, 0, be_else.38796
be_then.38796:
	mov     $i5, $i4
.count b_cont
	b       be_cont.38796
be_else.38796:
	bne     $i5, 0, be_else.38797
be_then.38797:
	li      1, $i4
.count b_cont
	b       be_cont.38797
be_else.38797:
	li      0, $i4
be_cont.38797:
be_cont.38796:
	load    [$i2 + 0], $f7
	bne     $i4, 0, be_cont.38798
be_then.38798:
	fneg    $f7, $f7
be_cont.38798:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd    $f6, $f2, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38799
ble_then.38799:
	li      0, $i2
.count b_cont
	b       ble_cont.38799
ble_else.38799:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd    $f6, $f3, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38800
ble_then.38800:
	li      0, $i2
.count b_cont
	b       ble_cont.38800
ble_else.38800:
.count move_float
	mov     $f4, $f44
	li      1, $i2
ble_cont.38800:
ble_cont.38799:
be_cont.38794:
	bne     $i2, 0, be_else.38801
be_then.38801:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.38802
be_then.38802:
	li      0, $i2
.count b_cont
	b       be_cont.38802
be_else.38802:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.38803
ble_then.38803:
	li      0, $i5
.count b_cont
	b       ble_cont.38803
ble_else.38803:
	li      1, $i5
ble_cont.38803:
	bne     $i4, 0, be_else.38804
be_then.38804:
	mov     $i5, $i4
.count b_cont
	b       be_cont.38804
be_else.38804:
	bne     $i5, 0, be_else.38805
be_then.38805:
	li      1, $i4
.count b_cont
	b       be_cont.38805
be_else.38805:
	li      0, $i4
be_cont.38805:
be_cont.38804:
	load    [$i2 + 1], $f7
	bne     $i4, 0, be_cont.38806
be_then.38806:
	fneg    $f7, $f7
be_cont.38806:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd    $f6, $f3, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38807
ble_then.38807:
	li      0, $i2
.count b_cont
	b       ble_cont.38807
ble_else.38807:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd    $f6, $f1, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38808
ble_then.38808:
	li      0, $i2
.count b_cont
	b       ble_cont.38808
ble_else.38808:
.count move_float
	mov     $f4, $f44
	li      1, $i2
ble_cont.38808:
ble_cont.38807:
be_cont.38802:
	bne     $i2, 0, be_else.38809
be_then.38809:
	load    [$i3 + 2], $f4
	bne     $f4, $f0, be_else.38810
be_then.38810:
	li      0, $i1
	ret
be_else.38810:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i1
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	bg      $f0, $f4, ble_else.38811
ble_then.38811:
	li      0, $i4
.count b_cont
	b       ble_cont.38811
ble_else.38811:
	li      1, $i4
ble_cont.38811:
	bne     $i1, 0, be_else.38812
be_then.38812:
	mov     $i4, $i1
.count b_cont
	b       be_cont.38812
be_else.38812:
	bne     $i4, 0, be_else.38813
be_then.38813:
	li      1, $i1
.count b_cont
	b       be_cont.38813
be_else.38813:
	li      0, $i1
be_cont.38813:
be_cont.38812:
	load    [$i2 + 2], $f7
	bne     $i1, 0, be_cont.38814
be_then.38814:
	fneg    $f7, $f7
be_cont.38814:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd    $f4, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38815
ble_then.38815:
	li      0, $i1
	ret
ble_else.38815:
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd    $f4, $f2, $f2
	fabs    $f2, $f2
	bg      $f1, $f2, ble_else.38816
ble_then.38816:
	li      0, $i1
	ret
ble_else.38816:
.count move_float
	mov     $f3, $f44
	li      3, $i1
	ret
be_else.38809:
	li      2, $i1
	ret
be_else.38801:
	li      1, $i1
	ret
be_else.38793:
	bne     $i6, 2, be_else.38817
be_then.38817:
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
	bg      $f4, $f0, ble_else.38818
ble_then.38818:
	li      0, $i1
	ret
ble_else.38818:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38817:
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
	be      $i7, 0, bne_cont.38819
bne_then.38819:
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
bne_cont.38819:
	bne     $f7, $f0, be_else.38820
be_then.38820:
	li      0, $i1
	ret
be_else.38820:
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
	bne     $i2, 0, be_else.38821
be_then.38821:
	mov     $f9, $f4
.count b_cont
	b       be_cont.38821
be_else.38821:
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
	fmul    $f4, $f39, $f4
	fadd    $f9, $f4, $f4
be_cont.38821:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.38822
be_then.38822:
	mov     $f6, $f1
.count b_cont
	b       be_cont.38822
be_else.38822:
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
be_cont.38822:
	bne     $i6, 3, be_cont.38823
be_then.38823:
	fsub    $f1, $f40, $f1
be_cont.38823:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.38824
ble_then.38824:
	li      0, $i1
	ret
ble_else.38824:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.38825
be_then.38825:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38825:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
.end solver

######################################################################
.begin solver_fast
solver_fast.2875:
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
	bne     $i7, 1, be_else.38826
be_then.38826:
	load    [min_caml_light_dirvec + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i2 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i2 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd    $f5, $f2, $f5
	fabs    $f5, $f5
	bg      $f4, $f5, ble_else.38827
ble_then.38827:
	li      0, $i4
.count b_cont
	b       ble_cont.38827
ble_else.38827:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd    $f7, $f3, $f7
	fabs    $f7, $f7
	bg      $f5, $f7, ble_else.38828
ble_then.38828:
	li      0, $i4
.count b_cont
	b       ble_cont.38828
ble_else.38828:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.38829
be_then.38829:
	li      0, $i4
.count b_cont
	b       be_cont.38829
be_else.38829:
	li      1, $i4
be_cont.38829:
ble_cont.38828:
ble_cont.38827:
	bne     $i4, 0, be_else.38830
be_then.38830:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i2 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i2 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f1, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38831
ble_then.38831:
	li      0, $i1
.count b_cont
	b       ble_cont.38831
ble_else.38831:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd    $f8, $f3, $f8
	fabs    $f8, $f8
	bg      $f6, $f8, ble_else.38832
ble_then.38832:
	li      0, $i1
.count b_cont
	b       ble_cont.38832
ble_else.38832:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.38833
be_then.38833:
	li      0, $i1
.count b_cont
	b       be_cont.38833
be_else.38833:
	li      1, $i1
be_cont.38833:
ble_cont.38832:
ble_cont.38831:
	bne     $i1, 0, be_else.38834
be_then.38834:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd    $f6, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38835
ble_then.38835:
	li      0, $i1
	ret
ble_else.38835:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.38836
ble_then.38836:
	li      0, $i1
	ret
ble_else.38836:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.38837
be_then.38837:
	li      0, $i1
	ret
be_else.38837:
.count move_float
	mov     $f3, $f44
	li      3, $i1
	ret
be_else.38834:
.count move_float
	mov     $f7, $f44
	li      2, $i1
	ret
be_else.38830:
.count move_float
	mov     $f6, $f44
	li      1, $i1
	ret
be_else.38826:
	load    [$i2 + 0], $f4
	bne     $i7, 2, be_else.38838
be_then.38838:
	bg      $f0, $f4, ble_else.38839
ble_then.38839:
	li      0, $i1
	ret
ble_else.38839:
	load    [$i2 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i2 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38838:
	bne     $f4, $f0, be_else.38840
be_then.38840:
	li      0, $i1
	ret
be_else.38840:
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
	bne     $i6, 0, be_else.38841
be_then.38841:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38841
be_else.38841:
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
be_cont.38841:
	bne     $i7, 3, be_cont.38842
be_then.38842:
	fsub    $f1, $f40, $f1
be_cont.38842:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.38843
ble_then.38843:
	li      0, $i1
	ret
ble_else.38843:
	load    [$i1 + 6], $i1
	load    [$i2 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i1, 0, be_else.38844
be_then.38844:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38844:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
.end solver_fast

######################################################################
.begin solver_fast2
solver_fast2.2893:
	load    [min_caml_objects + $i2], $i1
	load    [$i1 + 10], $i4
	load    [$i3 + 1], $i5
	load    [$i1 + 1], $i6
	load    [$i4 + 0], $f1
	load    [$i4 + 1], $f2
	load    [$i4 + 2], $f3
	load    [$i5 + $i2], $i2
	bne     $i6, 1, be_else.38845
be_then.38845:
	load    [$i3 + 0], $i3
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f4
	load    [$i3 + 1], $f5
	load    [$i2 + 0], $f6
	fsub    $f6, $f1, $f6
	load    [$i2 + 1], $f7
	fmul    $f6, $f7, $f6
	fmul    $f6, $f5, $f5
	fadd    $f5, $f2, $f5
	fabs    $f5, $f5
	bg      $f4, $f5, ble_else.38846
ble_then.38846:
	li      0, $i4
.count b_cont
	b       ble_cont.38846
ble_else.38846:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd    $f7, $f3, $f7
	fabs    $f7, $f7
	bg      $f5, $f7, ble_else.38847
ble_then.38847:
	li      0, $i4
.count b_cont
	b       ble_cont.38847
ble_else.38847:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.38848
be_then.38848:
	li      0, $i4
.count b_cont
	b       be_cont.38848
be_else.38848:
	li      1, $i4
be_cont.38848:
ble_cont.38847:
ble_cont.38846:
	bne     $i4, 0, be_else.38849
be_then.38849:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f5
	load    [$i3 + 0], $f6
	load    [$i2 + 2], $f7
	fsub    $f7, $f2, $f7
	load    [$i2 + 3], $f8
	fmul    $f7, $f8, $f7
	fmul    $f7, $f6, $f6
	fadd    $f6, $f1, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38850
ble_then.38850:
	li      0, $i1
.count b_cont
	b       ble_cont.38850
ble_else.38850:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd    $f8, $f3, $f8
	fabs    $f8, $f8
	bg      $f6, $f8, ble_else.38851
ble_then.38851:
	li      0, $i1
.count b_cont
	b       ble_cont.38851
ble_else.38851:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.38852
be_then.38852:
	li      0, $i1
.count b_cont
	b       be_cont.38852
be_else.38852:
	li      1, $i1
be_cont.38852:
ble_cont.38851:
ble_cont.38850:
	bne     $i1, 0, be_else.38853
be_then.38853:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd    $f6, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38854
ble_then.38854:
	li      0, $i1
	ret
ble_else.38854:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.38855
ble_then.38855:
	li      0, $i1
	ret
ble_else.38855:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.38856
be_then.38856:
	li      0, $i1
	ret
be_else.38856:
.count move_float
	mov     $f3, $f44
	li      3, $i1
	ret
be_else.38853:
.count move_float
	mov     $f7, $f44
	li      2, $i1
	ret
be_else.38849:
.count move_float
	mov     $f6, $f44
	li      1, $i1
	ret
be_else.38845:
	bne     $i6, 2, be_else.38857
be_then.38857:
	load    [$i2 + 0], $f1
	bg      $f0, $f1, ble_else.38858
ble_then.38858:
	li      0, $i1
	ret
ble_else.38858:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38857:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.38859
be_then.38859:
	li      0, $i1
	ret
be_else.38859:
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
	bg      $f2, $f0, ble_else.38860
ble_then.38860:
	li      0, $i1
	ret
ble_else.38860:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	bne     $i1, 0, be_else.38861
be_then.38861:
	fsub    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
be_else.38861:
	fadd    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f44
	li      1, $i1
	ret
.end solver_fast2

######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2905:
	bl      $i3, 0, bge_else.38862
bge_then.38862:
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
	bne     $i12, 1, be_else.38863
be_then.38863:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.38864
be_then.38864:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.38864
be_else.38864:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38865
ble_then.38865:
	li      0, $i15
.count b_cont
	b       ble_cont.38865
ble_else.38865:
	li      1, $i15
ble_cont.38865:
	bne     $i14, 0, be_else.38866
be_then.38866:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38866
be_else.38866:
	bne     $i15, 0, be_else.38867
be_then.38867:
	li      1, $i14
.count b_cont
	b       be_cont.38867
be_else.38867:
	li      0, $i14
be_cont.38867:
be_cont.38866:
	load    [$i11 + 4], $i15
	load    [$i15 + 0], $f1
	bne     $i14, 0, be_else.38868
be_then.38868:
	fneg    $f1, $f1
	store   $f1, [$i12 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
.count b_cont
	b       be_cont.38868
be_else.38868:
	store   $f1, [$i12 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
be_cont.38868:
be_cont.38864:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.38869
be_then.38869:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.38869
be_else.38869:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38870
ble_then.38870:
	li      0, $i15
.count b_cont
	b       ble_cont.38870
ble_else.38870:
	li      1, $i15
ble_cont.38870:
	bne     $i14, 0, be_else.38871
be_then.38871:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38871
be_else.38871:
	bne     $i15, 0, be_else.38872
be_then.38872:
	li      1, $i14
.count b_cont
	b       be_cont.38872
be_else.38872:
	li      0, $i14
be_cont.38872:
be_cont.38871:
	load    [$i11 + 4], $i15
	load    [$i15 + 1], $f1
	bne     $i14, 0, be_else.38873
be_then.38873:
	fneg    $f1, $f1
	store   $f1, [$i12 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
.count b_cont
	b       be_cont.38873
be_else.38873:
	store   $f1, [$i12 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
be_cont.38873:
be_cont.38869:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.38874
be_then.38874:
	store   $f0, [$i12 + 5]
	mov     $i12, $i11
.count b_cont
	b       be_cont.38874
be_else.38874:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38875
ble_then.38875:
	li      0, $i15
.count b_cont
	b       ble_cont.38875
ble_else.38875:
	li      1, $i15
ble_cont.38875:
	bne     $i14, 0, be_else.38876
be_then.38876:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38876
be_else.38876:
	bne     $i15, 0, be_else.38877
be_then.38877:
	li      1, $i14
.count b_cont
	b       be_cont.38877
be_else.38877:
	li      0, $i14
be_cont.38877:
be_cont.38876:
	load    [$i11 + 4], $i11
	load    [$i11 + 2], $f1
	mov     $i12, $i11
	bne     $i14, 0, be_else.38878
be_then.38878:
	fneg    $f1, $f1
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.38878
be_else.38878:
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
be_cont.38878:
be_cont.38874:
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i10, $i12, $tmp
	store   $i11, [$tmp + 0]
	sub     $i12, 1, $i11
	bl      $i11, 0, bge_else.38879
bge_then.38879:
	load    [min_caml_objects + $i11], $i12
	load    [$i12 + 1], $i14
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.38880
be_then.38880:
	li      6, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.38881
be_then.38881:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.38881
be_else.38881:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.38882
ble_then.38882:
	li      0, $i3
.count b_cont
	b       ble_cont.38882
ble_else.38882:
	li      1, $i3
ble_cont.38882:
	bne     $i2, 0, be_else.38883
be_then.38883:
	mov     $i3, $i2
.count b_cont
	b       be_cont.38883
be_else.38883:
	bne     $i3, 0, be_else.38884
be_then.38884:
	li      1, $i2
.count b_cont
	b       be_cont.38884
be_else.38884:
	li      0, $i2
be_cont.38884:
be_cont.38883:
	load    [$i12 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.38885
be_then.38885:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.38885
be_else.38885:
	store   $f1, [$i1 + 0]
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.38885:
be_cont.38881:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.38886
be_then.38886:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.38886
be_else.38886:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.38887
ble_then.38887:
	li      0, $i3
.count b_cont
	b       ble_cont.38887
ble_else.38887:
	li      1, $i3
ble_cont.38887:
	bne     $i2, 0, be_else.38888
be_then.38888:
	mov     $i3, $i2
.count b_cont
	b       be_cont.38888
be_else.38888:
	bne     $i3, 0, be_else.38889
be_then.38889:
	li      1, $i2
.count b_cont
	b       be_cont.38889
be_else.38889:
	li      0, $i2
be_cont.38889:
be_cont.38888:
	load    [$i12 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.38890
be_then.38890:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.38890
be_else.38890:
	store   $f1, [$i1 + 2]
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.38890:
be_cont.38886:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.38891
be_then.38891:
	store   $f0, [$i1 + 5]
.count storer
	add     $i10, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38891:
	load    [$i12 + 6], $i2
	load    [$i12 + 4], $i3
	bg      $f0, $f1, ble_else.38892
ble_then.38892:
	li      0, $i4
.count b_cont
	b       ble_cont.38892
ble_else.38892:
	li      1, $i4
ble_cont.38892:
	bne     $i2, 0, be_else.38893
be_then.38893:
	mov     $i4, $i2
.count b_cont
	b       be_cont.38893
be_else.38893:
	bne     $i4, 0, be_else.38894
be_then.38894:
	li      1, $i2
.count b_cont
	b       be_cont.38894
be_else.38894:
	li      0, $i2
be_cont.38894:
be_cont.38893:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.38895
be_then.38895:
	fneg    $f1, $f1
be_cont.38895:
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
	b       iter_setup_dirvec_constants.2905
be_else.38880:
	bne     $i14, 2, be_else.38896
be_then.38896:
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
	bg      $f1, $f0, ble_else.38897
ble_then.38897:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
ble_else.38897:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i12 + 4], $i2
	load    [$i2 + 0], $f2
	fmul    $f2, $f1, $f2
	fneg    $f2, $f2
	store   $f2, [$i1 + 1]
	load    [$i12 + 4], $i2
	load    [$i2 + 1], $f2
	fmul    $f2, $f1, $f2
	fneg    $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i12 + 4], $i2
	load    [$i2 + 2], $f2
	fmul    $f2, $f1, $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 3]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38896:
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
	bne     $i2, 0, be_else.38898
be_then.38898:
	mov     $f4, $f1
.count b_cont
	b       be_cont.38898
be_else.38898:
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
be_cont.38898:
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
	bne     $i2, 0, be_else.38899
be_then.38899:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.38900
be_then.38900:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38900:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38899:
	load    [$i12 + 9], $i2
	load    [$i12 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $f39, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i12 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $f39, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $f39, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.38901
be_then.38901:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38901:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
bge_else.38879:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.38863:
	bne     $i12, 2, be_else.38902
be_then.38902:
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
	bg      $f1, $f0, ble_else.38903
ble_then.38903:
	store   $f0, [$i1 + 0]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
ble_else.38903:
	finv    $f1, $f1
	fneg    $f1, $f2
	store   $f2, [$i1 + 0]
	load    [$i11 + 4], $i2
	load    [$i2 + 0], $f2
	fmul    $f2, $f1, $f2
	fneg    $f2, $f2
	store   $f2, [$i1 + 1]
	load    [$i11 + 4], $i2
	load    [$i2 + 1], $f2
	fmul    $f2, $f1, $f2
	fneg    $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i11 + 4], $i2
	load    [$i2 + 2], $f2
	fmul    $f2, $f1, $f1
	fneg    $f1, $f1
	store   $f1, [$i1 + 3]
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38902:
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
	bne     $i2, 0, be_else.38904
be_then.38904:
	mov     $f4, $f1
.count b_cont
	b       be_cont.38904
be_else.38904:
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
be_cont.38904:
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
	bne     $i2, 0, be_else.38905
be_then.38905:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.38906
be_then.38906:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38906:
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
	b       iter_setup_dirvec_constants.2905
be_else.38905:
	load    [$i11 + 9], $i2
	load    [$i11 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
	fmul    $f3, $f39, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i11 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f5
	fmul    $f5, $f8, $f5
	fadd    $f2, $f5, $f2
	fmul    $f2, $f39, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $f39, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.38907
be_then.38907:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38907:
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
	b       iter_setup_dirvec_constants.2905
bge_else.38862:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2910:
	bl      $i3, 0, bge_else.38908
bge_then.38908:
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
	bne     $i4, 2, be_else.38909
be_then.38909:
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
	b       setup_startp_constants.2910
be_else.38909:
	bg      $i4, 2, ble_else.38910
ble_then.38910:
	sub     $i3, 1, $i3
	b       setup_startp_constants.2910
ble_else.38910:
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
	bne     $i9, 0, be_else.38911
be_then.38911:
	mov     $f4, $f1
.count b_cont
	b       be_cont.38911
be_else.38911:
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
be_cont.38911:
	sub     $i3, 1, $i3
	bne     $i4, 3, be_else.38912
be_then.38912:
	fsub    $f1, $f40, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2910
be_else.38912:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2910
bge_else.38908:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2935:
	load    [$i3 + $i2], $i1
	bne     $i1, -1, be_else.38913
be_then.38913:
	li      1, $i1
	ret
be_else.38913:
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
	bne     $i4, 1, be_else.38914
be_then.38914:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.38915
ble_then.38915:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.38916
be_then.38916:
	li      1, $i1
.count b_cont
	b       be_cont.38914
be_else.38916:
	li      0, $i1
.count b_cont
	b       be_cont.38914
ble_else.38915:
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.38917
ble_then.38917:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.38918
be_then.38918:
	li      1, $i1
.count b_cont
	b       be_cont.38914
be_else.38918:
	li      0, $i1
.count b_cont
	b       be_cont.38914
ble_else.38917:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i1 + 6], $i1
	bg      $f1, $f5, be_cont.38914
ble_then.38919:
	bne     $i1, 0, be_else.38920
be_then.38920:
	li      1, $i1
.count b_cont
	b       be_cont.38914
be_else.38920:
	li      0, $i1
.count b_cont
	b       be_cont.38914
be_else.38914:
	bne     $i4, 2, be_else.38921
be_then.38921:
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
	bg      $f0, $f1, ble_else.38922
ble_then.38922:
	bne     $i4, 0, be_else.38923
be_then.38923:
	li      1, $i1
.count b_cont
	b       be_cont.38921
be_else.38923:
	li      0, $i1
.count b_cont
	b       be_cont.38921
ble_else.38922:
	bne     $i4, 0, be_else.38924
be_then.38924:
	li      0, $i1
.count b_cont
	b       be_cont.38921
be_else.38924:
	li      1, $i1
.count b_cont
	b       be_cont.38921
be_else.38921:
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
	bne     $i6, 0, be_else.38925
be_then.38925:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38925
be_else.38925:
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
be_cont.38925:
	bne     $i4, 3, be_cont.38926
be_then.38926:
	fsub    $f1, $f40, $f1
be_cont.38926:
	bg      $f0, $f1, ble_else.38927
ble_then.38927:
	bne     $i5, 0, be_else.38928
be_then.38928:
	li      1, $i1
.count b_cont
	b       ble_cont.38927
be_else.38928:
	li      0, $i1
.count b_cont
	b       ble_cont.38927
ble_else.38927:
	bne     $i5, 0, be_else.38929
be_then.38929:
	li      0, $i1
.count b_cont
	b       be_cont.38929
be_else.38929:
	li      1, $i1
be_cont.38929:
ble_cont.38927:
be_cont.38921:
be_cont.38914:
	bne     $i1, 0, be_else.38930
be_then.38930:
	add     $i2, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.38931
be_then.38931:
	li      1, $i1
	ret
be_else.38931:
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
	bne     $i7, 1, be_else.38932
be_then.38932:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.38933
ble_then.38933:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.38934
be_then.38934:
	li      1, $i2
.count b_cont
	b       be_cont.38932
be_else.38934:
	li      0, $i2
.count b_cont
	b       be_cont.38932
ble_else.38933:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.38935
ble_then.38935:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.38936
be_then.38936:
	li      1, $i2
.count b_cont
	b       be_cont.38932
be_else.38936:
	li      0, $i2
.count b_cont
	b       be_cont.38932
ble_else.38935:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.38932
ble_then.38937:
	bne     $i2, 0, be_else.38938
be_then.38938:
	li      1, $i2
.count b_cont
	b       be_cont.38932
be_else.38938:
	li      0, $i2
.count b_cont
	b       be_cont.38932
be_else.38932:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.38939
be_then.38939:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.38940
ble_then.38940:
	bne     $i4, 0, be_else.38941
be_then.38941:
	li      1, $i2
.count b_cont
	b       be_cont.38939
be_else.38941:
	li      0, $i2
.count b_cont
	b       be_cont.38939
ble_else.38940:
	bne     $i4, 0, be_else.38942
be_then.38942:
	li      0, $i2
.count b_cont
	b       be_cont.38939
be_else.38942:
	li      1, $i2
.count b_cont
	b       be_cont.38939
be_else.38939:
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
	bne     $i9, 0, be_else.38943
be_then.38943:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38943
be_else.38943:
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
be_cont.38943:
	bne     $i5, 3, be_cont.38944
be_then.38944:
	fsub    $f1, $f40, $f1
be_cont.38944:
	bg      $f0, $f1, ble_else.38945
ble_then.38945:
	bne     $i4, 0, be_else.38946
be_then.38946:
	li      1, $i2
.count b_cont
	b       ble_cont.38945
be_else.38946:
	li      0, $i2
.count b_cont
	b       ble_cont.38945
ble_else.38945:
	bne     $i4, 0, be_else.38947
be_then.38947:
	li      0, $i2
.count b_cont
	b       be_cont.38947
be_else.38947:
	li      1, $i2
be_cont.38947:
ble_cont.38945:
be_cont.38939:
be_cont.38932:
	bne     $i2, 0, be_else.38948
be_then.38948:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.38949
be_then.38949:
	li      1, $i1
	ret
be_else.38949:
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
	bne     $i4, 1, be_else.38950
be_then.38950:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.38951
ble_then.38951:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.38952
be_then.38952:
	li      1, $i2
.count b_cont
	b       be_cont.38950
be_else.38952:
	li      0, $i2
.count b_cont
	b       be_cont.38950
ble_else.38951:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.38953
ble_then.38953:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.38954
be_then.38954:
	li      1, $i2
.count b_cont
	b       be_cont.38950
be_else.38954:
	li      0, $i2
.count b_cont
	b       be_cont.38950
ble_else.38953:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.38950
ble_then.38955:
	bne     $i2, 0, be_else.38956
be_then.38956:
	li      1, $i2
.count b_cont
	b       be_cont.38950
be_else.38956:
	li      0, $i2
.count b_cont
	b       be_cont.38950
be_else.38950:
	bne     $i4, 2, be_else.38957
be_then.38957:
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
	bg      $f0, $f1, ble_else.38958
ble_then.38958:
	bne     $i4, 0, be_else.38959
be_then.38959:
	li      1, $i2
.count b_cont
	b       be_cont.38957
be_else.38959:
	li      0, $i2
.count b_cont
	b       be_cont.38957
ble_else.38958:
	bne     $i4, 0, be_else.38960
be_then.38960:
	li      0, $i2
.count b_cont
	b       be_cont.38957
be_else.38960:
	li      1, $i2
.count b_cont
	b       be_cont.38957
be_else.38957:
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
	bne     $i6, 0, be_else.38961
be_then.38961:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38961
be_else.38961:
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
be_cont.38961:
	bne     $i5, 3, be_cont.38962
be_then.38962:
	fsub    $f1, $f40, $f1
be_cont.38962:
	bg      $f0, $f1, ble_else.38963
ble_then.38963:
	bne     $i4, 0, be_else.38964
be_then.38964:
	li      1, $i2
.count b_cont
	b       ble_cont.38963
be_else.38964:
	li      0, $i2
.count b_cont
	b       ble_cont.38963
ble_else.38963:
	bne     $i4, 0, be_else.38965
be_then.38965:
	li      0, $i2
.count b_cont
	b       be_cont.38965
be_else.38965:
	li      1, $i2
be_cont.38965:
ble_cont.38963:
be_cont.38957:
be_cont.38950:
	bne     $i2, 0, be_else.38966
be_then.38966:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.38967
be_then.38967:
	li      1, $i1
	ret
be_else.38967:
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
	bne     $i7, 1, be_else.38968
be_then.38968:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.38969
ble_then.38969:
	li      0, $i4
.count b_cont
	b       ble_cont.38969
ble_else.38969:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.38970
ble_then.38970:
	li      0, $i4
.count b_cont
	b       ble_cont.38970
ble_else.38970:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.38971
ble_then.38971:
	li      0, $i4
.count b_cont
	b       ble_cont.38971
ble_else.38971:
	li      1, $i4
ble_cont.38971:
ble_cont.38970:
ble_cont.38969:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.38972
be_then.38972:
	bne     $i2, 0, be_else.38973
be_then.38973:
	li      0, $i1
	ret
be_else.38973:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.38972:
	bne     $i2, 0, be_else.38974
be_then.38974:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.38974:
	li      0, $i1
	ret
be_else.38968:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.38975
be_then.38975:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.38976
ble_then.38976:
	bne     $i4, 0, be_else.38977
be_then.38977:
	li      0, $i1
	ret
be_else.38977:
	add     $i1, 1, $i2
	b       check_all_inside.2935
ble_else.38976:
	bne     $i4, 0, be_else.38978
be_then.38978:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.38978:
	li      0, $i1
	ret
be_else.38975:
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
	bne     $i9, 0, be_else.38979
be_then.38979:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38979
be_else.38979:
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
be_cont.38979:
	bne     $i7, 3, be_cont.38980
be_then.38980:
	fsub    $f1, $f40, $f1
be_cont.38980:
	bg      $f0, $f1, ble_else.38981
ble_then.38981:
	bne     $i4, 0, be_else.38982
be_then.38982:
	li      0, $i1
	ret
be_else.38982:
	add     $i1, 1, $i2
	b       check_all_inside.2935
ble_else.38981:
	bne     $i4, 0, be_else.38983
be_then.38983:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.38983:
	li      0, $i1
	ret
be_else.38966:
	li      0, $i1
	ret
be_else.38948:
	li      0, $i1
	ret
be_else.38930:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2941:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.38984
be_then.38984:
	li      0, $i1
	ret
be_else.38984:
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
	bne     $i16, 1, be_else.38985
be_then.38985:
	load    [min_caml_light_dirvec + 0], $i13
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f13
	load    [$i13 + 1], $f14
	load    [$i12 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i12 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd    $f14, $f11, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.38986
ble_then.38986:
	li      0, $i14
.count b_cont
	b       ble_cont.38986
ble_else.38986:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.38987
ble_then.38987:
	li      0, $i14
.count b_cont
	b       ble_cont.38987
ble_else.38987:
	load    [$i12 + 1], $f13
	bne     $f13, $f0, be_else.38988
be_then.38988:
	li      0, $i14
.count b_cont
	b       be_cont.38988
be_else.38988:
	li      1, $i14
be_cont.38988:
ble_cont.38987:
ble_cont.38986:
	bne     $i14, 0, be_else.38989
be_then.38989:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i12 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i12 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd    $f14, $f10, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.38990
ble_then.38990:
	li      0, $i14
.count b_cont
	b       ble_cont.38990
ble_else.38990:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.38991
ble_then.38991:
	li      0, $i14
.count b_cont
	b       ble_cont.38991
ble_else.38991:
	load    [$i12 + 3], $f13
	bne     $f13, $f0, be_else.38992
be_then.38992:
	li      0, $i14
.count b_cont
	b       be_cont.38992
be_else.38992:
	li      1, $i14
be_cont.38992:
ble_cont.38991:
ble_cont.38990:
	bne     $i14, 0, be_else.38993
be_then.38993:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i13 + 0], $f14
	load    [$i12 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i12 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd    $f14, $f10, $f10
	fabs    $f10, $f10
	bg      $f13, $f10, ble_else.38994
ble_then.38994:
	li      0, $i11
.count b_cont
	b       be_cont.38985
ble_else.38994:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i13 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.38995
ble_then.38995:
	li      0, $i11
.count b_cont
	b       be_cont.38985
ble_else.38995:
	load    [$i12 + 5], $f10
	bne     $f10, $f0, be_else.38996
be_then.38996:
	li      0, $i11
.count b_cont
	b       be_cont.38985
be_else.38996:
.count move_float
	mov     $f12, $f44
	li      3, $i11
.count b_cont
	b       be_cont.38985
be_else.38993:
.count move_float
	mov     $f15, $f44
	li      2, $i11
.count b_cont
	b       be_cont.38985
be_else.38989:
.count move_float
	mov     $f15, $f44
	li      1, $i11
.count b_cont
	b       be_cont.38985
be_else.38985:
	load    [$i12 + 0], $f13
	bne     $i16, 2, be_else.38997
be_then.38997:
	bg      $f0, $f13, ble_else.38998
ble_then.38998:
	li      0, $i11
.count b_cont
	b       be_cont.38997
ble_else.38998:
	load    [$i12 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i12 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i12 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.38997
be_else.38997:
	bne     $f13, $f0, be_else.38999
be_then.38999:
	li      0, $i11
.count b_cont
	b       be_cont.38999
be_else.38999:
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
	bne     $i13, 0, be_else.39000
be_then.39000:
	mov     $f16, $f10
.count b_cont
	b       be_cont.39000
be_else.39000:
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
be_cont.39000:
	bne     $i16, 3, be_cont.39001
be_then.39001:
	fsub    $f10, $f40, $f10
be_cont.39001:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.39002
ble_then.39002:
	li      0, $i11
.count b_cont
	b       ble_cont.39002
ble_else.39002:
	load    [$i11 + 6], $i11
	load    [$i12 + 4], $f11
	fsqrt   $f10, $f10
	bne     $i11, 0, be_else.39003
be_then.39003:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39003
be_else.39003:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
be_cont.39003:
ble_cont.39002:
be_cont.38999:
be_cont.38997:
be_cont.38985:
	bne     $i11, 0, be_else.39004
be_then.39004:
	li      0, $i11
.count b_cont
	b       be_cont.39004
be_else.39004:
.count load_float
	load    [f.34800], $f10
	bg      $f10, $f44, ble_else.39005
ble_then.39005:
	li      0, $i11
.count b_cont
	b       ble_cont.39005
ble_else.39005:
	li      1, $i11
ble_cont.39005:
be_cont.39004:
	bne     $i11, 0, be_else.39006
be_then.39006:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39007
be_then.39007:
	li      0, $i1
	ret
be_else.39007:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2941
be_else.39006:
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.39008
be_then.39008:
	li      1, $i1
	ret
be_else.39008:
	load    [min_caml_objects + $i10], $i10
	load    [$i10 + 5], $i11
	load    [$i10 + 5], $i12
	load    [$i10 + 5], $i13
	load    [$i10 + 1], $i14
	load    [$i11 + 0], $f10
.count load_float
	load    [f.34801], $f11
	fadd    $f44, $f11, $f11
	fmul    $f57, $f11, $f12
	load    [min_caml_intersection_point + 0], $f13
	fadd    $f12, $f13, $f2
	fsub    $f2, $f10, $f10
	load    [$i12 + 1], $f12
	fmul    $f58, $f11, $f13
	load    [min_caml_intersection_point + 1], $f14
	fadd    $f13, $f14, $f3
	fsub    $f3, $f12, $f12
	load    [$i13 + 2], $f13
	fmul    $f59, $f11, $f11
	load    [min_caml_intersection_point + 2], $f14
	fadd    $f11, $f14, $f4
	fsub    $f4, $f13, $f11
	bne     $i14, 1, be_else.39009
be_then.39009:
	load    [$i10 + 4], $i11
	load    [$i11 + 0], $f13
	fabs    $f10, $f10
	bg      $f13, $f10, ble_else.39010
ble_then.39010:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.39011
be_then.39011:
	li      1, $i10
.count b_cont
	b       be_cont.39009
be_else.39011:
	li      0, $i10
.count b_cont
	b       be_cont.39009
ble_else.39010:
	load    [$i10 + 4], $i11
	load    [$i11 + 1], $f10
	fabs    $f12, $f12
	bg      $f10, $f12, ble_else.39012
ble_then.39012:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.39013
be_then.39013:
	li      1, $i10
.count b_cont
	b       be_cont.39009
be_else.39013:
	li      0, $i10
.count b_cont
	b       be_cont.39009
ble_else.39012:
	load    [$i10 + 4], $i11
	load    [$i11 + 2], $f10
	fabs    $f11, $f11
	load    [$i10 + 6], $i10
	bg      $f10, $f11, be_cont.39009
ble_then.39014:
	bne     $i10, 0, be_else.39015
be_then.39015:
	li      1, $i10
.count b_cont
	b       be_cont.39009
be_else.39015:
	li      0, $i10
.count b_cont
	b       be_cont.39009
be_else.39009:
	load    [$i10 + 6], $i11
	bne     $i14, 2, be_else.39016
be_then.39016:
	load    [$i10 + 4], $i10
	load    [$i10 + 0], $f13
	fmul    $f13, $f10, $f10
	load    [$i10 + 1], $f13
	fmul    $f13, $f12, $f12
	fadd    $f10, $f12, $f10
	load    [$i10 + 2], $f12
	fmul    $f12, $f11, $f11
	fadd    $f10, $f11, $f10
	bg      $f0, $f10, ble_else.39017
ble_then.39017:
	bne     $i11, 0, be_else.39018
be_then.39018:
	li      1, $i10
.count b_cont
	b       be_cont.39016
be_else.39018:
	li      0, $i10
.count b_cont
	b       be_cont.39016
ble_else.39017:
	bne     $i11, 0, be_else.39019
be_then.39019:
	li      0, $i10
.count b_cont
	b       be_cont.39016
be_else.39019:
	li      1, $i10
.count b_cont
	b       be_cont.39016
be_else.39016:
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
	bne     $i12, 0, be_else.39020
be_then.39020:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39020
be_else.39020:
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
be_cont.39020:
	bne     $i14, 3, be_cont.39021
be_then.39021:
	fsub    $f10, $f40, $f10
be_cont.39021:
	bg      $f0, $f10, ble_else.39022
ble_then.39022:
	bne     $i11, 0, be_else.39023
be_then.39023:
	li      1, $i10
.count b_cont
	b       ble_cont.39022
be_else.39023:
	li      0, $i10
.count b_cont
	b       ble_cont.39022
ble_else.39022:
	bne     $i11, 0, be_else.39024
be_then.39024:
	li      0, $i10
.count b_cont
	b       be_cont.39024
be_else.39024:
	li      1, $i10
be_cont.39024:
ble_cont.39022:
be_cont.39016:
be_cont.39009:
	bne     $i10, 0, be_else.39025
be_then.39025:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	li      1, $i2
	call    check_all_inside.2935
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.39026
be_then.39026:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 2], $i3
	b       shadow_check_and_group.2941
be_else.39026:
	li      1, $i1
	ret
be_else.39025:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2941
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2944:
	load    [$i3 + $i2], $i17
	bne     $i17, -1, be_else.39027
be_then.39027:
	li      0, $i1
	ret
be_else.39027:
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
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39028
be_then.39028:
.count stack_load
	load    [$sp + 2], $i17
	add     $i17, 1, $i17
.count stack_load
	load    [$sp + 1], $i18
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39029
be_then.39029:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39029:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39030
be_then.39030:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39031
be_then.39031:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39031:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39032
be_then.39032:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39033
be_then.39033:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39033:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39034
be_then.39034:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39035
be_then.39035:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39035:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39036
be_then.39036:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39037
be_then.39037:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39037:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39038
be_then.39038:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39039
be_then.39039:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39039:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39040
be_then.39040:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39041
be_then.39041:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39041:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.39042
be_then.39042:
	add     $i17, 1, $i2
.count move_args
	mov     $i18, $i3
	b       shadow_check_one_or_group.2944
be_else.39042:
	li      1, $i1
	ret
be_else.39040:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39038:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39036:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39034:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39032:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39030:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39028:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_group

######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2947:
	load    [$i3 + $i2], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.39043
be_then.39043:
	li      0, $i1
	ret
be_else.39043:
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
	bne     $i18, 99, be_else.39044
be_then.39044:
	li      1, $i10
.count b_cont
	b       be_cont.39044
be_else.39044:
	load    [min_caml_objects + $i18], $i19
	load    [min_caml_intersection_point + 0], $f19
	load    [$i19 + 5], $i20
	load    [$i20 + 0], $f20
	fsub    $f19, $f20, $f19
	load    [min_caml_intersection_point + 1], $f20
	load    [$i19 + 5], $i20
	load    [$i20 + 1], $f21
	fsub    $f20, $f21, $f20
	load    [min_caml_intersection_point + 2], $f21
	load    [$i19 + 5], $i20
	load    [$i20 + 2], $f22
	fsub    $f21, $f22, $f21
	load    [min_caml_light_dirvec + 1], $i20
	load    [$i20 + $i18], $i18
	load    [$i19 + 1], $i20
	bne     $i20, 1, be_else.39045
be_then.39045:
	load    [min_caml_light_dirvec + 0], $i20
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f22
	load    [$i20 + 1], $f23
	load    [$i18 + 0], $f24
	fsub    $f24, $f19, $f24
	load    [$i18 + 1], $f25
	fmul    $f24, $f25, $f24
	fmul    $f24, $f23, $f23
	fadd    $f23, $f20, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39046
ble_then.39046:
	li      0, $i21
.count b_cont
	b       ble_cont.39046
ble_else.39046:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f22
	load    [$i20 + 2], $f23
	fmul    $f24, $f23, $f23
	fadd    $f23, $f21, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39047
ble_then.39047:
	li      0, $i21
.count b_cont
	b       ble_cont.39047
ble_else.39047:
	load    [$i18 + 1], $f22
	bne     $f22, $f0, be_else.39048
be_then.39048:
	li      0, $i21
.count b_cont
	b       be_cont.39048
be_else.39048:
	li      1, $i21
be_cont.39048:
ble_cont.39047:
ble_cont.39046:
	bne     $i21, 0, be_else.39049
be_then.39049:
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f22
	load    [$i20 + 0], $f23
	load    [$i18 + 2], $f24
	fsub    $f24, $f20, $f24
	load    [$i18 + 3], $f25
	fmul    $f24, $f25, $f24
	fmul    $f24, $f23, $f23
	fadd    $f23, $f19, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39050
ble_then.39050:
	li      0, $i21
.count b_cont
	b       ble_cont.39050
ble_else.39050:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f22
	load    [$i20 + 2], $f23
	fmul    $f24, $f23, $f23
	fadd    $f23, $f21, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39051
ble_then.39051:
	li      0, $i21
.count b_cont
	b       ble_cont.39051
ble_else.39051:
	load    [$i18 + 3], $f22
	bne     $f22, $f0, be_else.39052
be_then.39052:
	li      0, $i21
.count b_cont
	b       be_cont.39052
be_else.39052:
	li      1, $i21
be_cont.39052:
ble_cont.39051:
ble_cont.39050:
	bne     $i21, 0, be_else.39053
be_then.39053:
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f22
	load    [$i20 + 0], $f23
	load    [$i18 + 4], $f24
	fsub    $f24, $f21, $f21
	load    [$i18 + 5], $f24
	fmul    $f21, $f24, $f21
	fmul    $f21, $f23, $f23
	fadd    $f23, $f19, $f19
	fabs    $f19, $f19
	bg      $f22, $f19, ble_else.39054
ble_then.39054:
	li      0, $i18
.count b_cont
	b       be_cont.39045
ble_else.39054:
	load    [$i19 + 4], $i19
	load    [$i19 + 1], $f19
	load    [$i20 + 1], $f22
	fmul    $f21, $f22, $f22
	fadd    $f22, $f20, $f20
	fabs    $f20, $f20
	bg      $f19, $f20, ble_else.39055
ble_then.39055:
	li      0, $i18
.count b_cont
	b       be_cont.39045
ble_else.39055:
	load    [$i18 + 5], $f19
	bne     $f19, $f0, be_else.39056
be_then.39056:
	li      0, $i18
.count b_cont
	b       be_cont.39045
be_else.39056:
.count move_float
	mov     $f21, $f44
	li      3, $i18
.count b_cont
	b       be_cont.39045
be_else.39053:
.count move_float
	mov     $f24, $f44
	li      2, $i18
.count b_cont
	b       be_cont.39045
be_else.39049:
.count move_float
	mov     $f24, $f44
	li      1, $i18
.count b_cont
	b       be_cont.39045
be_else.39045:
	load    [$i18 + 0], $f22
	bne     $i20, 2, be_else.39057
be_then.39057:
	bg      $f0, $f22, ble_else.39058
ble_then.39058:
	li      0, $i18
.count b_cont
	b       be_cont.39057
ble_else.39058:
	load    [$i18 + 1], $f22
	fmul    $f22, $f19, $f19
	load    [$i18 + 2], $f22
	fmul    $f22, $f20, $f20
	fadd    $f19, $f20, $f19
	load    [$i18 + 3], $f20
	fmul    $f20, $f21, $f20
	fadd    $f19, $f20, $f19
.count move_float
	mov     $f19, $f44
	li      1, $i18
.count b_cont
	b       be_cont.39057
be_else.39057:
	bne     $f22, $f0, be_else.39059
be_then.39059:
	li      0, $i18
.count b_cont
	b       be_cont.39059
be_else.39059:
	load    [$i18 + 1], $f23
	fmul    $f23, $f19, $f23
	load    [$i18 + 2], $f24
	fmul    $f24, $f20, $f24
	fadd    $f23, $f24, $f23
	load    [$i18 + 3], $f24
	fmul    $f24, $f21, $f24
	fadd    $f23, $f24, $f23
	fmul    $f23, $f23, $f24
	fmul    $f19, $f19, $f25
	load    [$i19 + 4], $i21
	load    [$i21 + 0], $f26
	fmul    $f25, $f26, $f25
	fmul    $f20, $f20, $f26
	load    [$i19 + 4], $i21
	load    [$i21 + 1], $f27
	fmul    $f26, $f27, $f26
	fadd    $f25, $f26, $f25
	fmul    $f21, $f21, $f26
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f27
	fmul    $f26, $f27, $f26
	fadd    $f25, $f26, $f25
	load    [$i19 + 3], $i21
	bne     $i21, 0, be_else.39060
be_then.39060:
	mov     $f25, $f19
.count b_cont
	b       be_cont.39060
be_else.39060:
	fmul    $f20, $f21, $f26
	load    [$i19 + 9], $i21
	load    [$i21 + 0], $f27
	fmul    $f26, $f27, $f26
	fadd    $f25, $f26, $f25
	fmul    $f21, $f19, $f21
	load    [$i19 + 9], $i21
	load    [$i21 + 1], $f26
	fmul    $f21, $f26, $f21
	fadd    $f25, $f21, $f21
	fmul    $f19, $f20, $f19
	load    [$i19 + 9], $i21
	load    [$i21 + 2], $f20
	fmul    $f19, $f20, $f19
	fadd    $f21, $f19, $f19
be_cont.39060:
	bne     $i20, 3, be_cont.39061
be_then.39061:
	fsub    $f19, $f40, $f19
be_cont.39061:
	fmul    $f22, $f19, $f19
	fsub    $f24, $f19, $f19
	bg      $f19, $f0, ble_else.39062
ble_then.39062:
	li      0, $i18
.count b_cont
	b       ble_cont.39062
ble_else.39062:
	load    [$i19 + 6], $i19
	load    [$i18 + 4], $f20
	li      1, $i18
	fsqrt   $f19, $f19
	bne     $i19, 0, be_else.39063
be_then.39063:
	fsub    $f23, $f19, $f19
	fmul    $f19, $f20, $f19
.count move_float
	mov     $f19, $f44
.count b_cont
	b       be_cont.39063
be_else.39063:
	fadd    $f23, $f19, $f19
	fmul    $f19, $f20, $f19
.count move_float
	mov     $f19, $f44
be_cont.39063:
ble_cont.39062:
be_cont.39059:
be_cont.39057:
be_cont.39045:
	bne     $i18, 0, be_else.39064
be_then.39064:
	li      0, $i10
.count b_cont
	b       be_cont.39064
be_else.39064:
.count load_float
	load    [f.34802], $f19
	bg      $f19, $f44, ble_else.39065
ble_then.39065:
	li      0, $i10
.count b_cont
	b       ble_cont.39065
ble_else.39065:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39066
be_then.39066:
	li      0, $i10
.count b_cont
	b       be_cont.39066
be_else.39066:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39067
be_then.39067:
	li      2, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i10
	bne     $i10, 0, be_else.39068
be_then.39068:
	li      0, $i10
.count b_cont
	b       be_cont.39067
be_else.39068:
	li      1, $i10
.count b_cont
	b       be_cont.39067
be_else.39067:
	li      1, $i10
be_cont.39067:
be_cont.39066:
ble_cont.39065:
be_cont.39064:
be_cont.39044:
	bne     $i10, 0, be_else.39069
be_then.39069:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.39070
be_then.39070:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.39070:
.count stack_store
	store   $i12, [$sp + 4]
.count stack_store
	store   $i10, [$sp + 5]
	bne     $i2, 99, be_else.39071
be_then.39071:
	li      1, $i17
.count b_cont
	b       be_cont.39071
be_else.39071:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39072
be_then.39072:
	li      0, $i17
.count b_cont
	b       be_cont.39072
be_else.39072:
.count load_float
	load    [f.34802], $f19
	bg      $f19, $f44, ble_else.39073
ble_then.39073:
	li      0, $i17
.count b_cont
	b       ble_cont.39073
ble_else.39073:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.39074
be_then.39074:
	li      0, $i17
.count b_cont
	b       be_cont.39074
be_else.39074:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39075
be_then.39075:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39076
be_then.39076:
	li      0, $i17
.count b_cont
	b       be_cont.39075
be_else.39076:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39077
be_then.39077:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39078
be_then.39078:
	li      0, $i17
.count b_cont
	b       be_cont.39075
be_else.39078:
	li      1, $i17
.count b_cont
	b       be_cont.39075
be_else.39077:
	li      1, $i17
.count b_cont
	b       be_cont.39075
be_else.39075:
	li      1, $i17
be_cont.39075:
be_cont.39074:
ble_cont.39073:
be_cont.39072:
be_cont.39071:
	bne     $i17, 0, be_else.39079
be_then.39079:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39079:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39080
be_then.39080:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39080:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39081
be_then.39081:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39082
be_then.39082:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39082:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39083
be_then.39083:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.39084
be_then.39084:
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39084:
	li      1, $i1
	ret
be_else.39083:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39081:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39069:
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39085
be_then.39085:
	li      0, $i10
.count b_cont
	b       be_cont.39085
be_else.39085:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39086
be_then.39086:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39087
be_then.39087:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39087:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39088
be_then.39088:
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.39089
be_then.39089:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39089:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39090
be_then.39090:
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.39091
be_then.39091:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39091:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39092
be_then.39092:
	load    [$i17 + 5], $i18
	bne     $i18, -1, be_else.39093
be_then.39093:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39093:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39094
be_then.39094:
	load    [$i17 + 6], $i18
	bne     $i18, -1, be_else.39095
be_then.39095:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39095:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39096
be_then.39096:
	load    [$i17 + 7], $i18
	bne     $i18, -1, be_else.39097
be_then.39097:
	li      0, $i10
.count b_cont
	b       be_cont.39086
be_else.39097:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39098
be_then.39098:
	li      8, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39086
be_else.39098:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39096:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39094:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39092:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39090:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39088:
	li      1, $i10
.count b_cont
	b       be_cont.39086
be_else.39086:
	li      1, $i10
be_cont.39086:
be_cont.39085:
	bne     $i10, 0, be_else.39099
be_then.39099:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.39100
be_then.39100:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.39100:
.count stack_store
	store   $i12, [$sp + 6]
.count stack_store
	store   $i10, [$sp + 7]
	bne     $i2, 99, be_else.39101
be_then.39101:
	li      1, $i17
.count b_cont
	b       be_cont.39101
be_else.39101:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39102
be_then.39102:
	li      0, $i17
.count b_cont
	b       be_cont.39102
be_else.39102:
.count load_float
	load    [f.34802], $f19
	bg      $f19, $f44, ble_else.39103
ble_then.39103:
	li      0, $i17
.count b_cont
	b       ble_cont.39103
ble_else.39103:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.39104
be_then.39104:
	li      0, $i17
.count b_cont
	b       be_cont.39104
be_else.39104:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39105
be_then.39105:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39106
be_then.39106:
	li      0, $i17
.count b_cont
	b       be_cont.39105
be_else.39106:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39107
be_then.39107:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39108
be_then.39108:
	li      0, $i17
.count b_cont
	b       be_cont.39105
be_else.39108:
	li      1, $i17
.count b_cont
	b       be_cont.39105
be_else.39107:
	li      1, $i17
.count b_cont
	b       be_cont.39105
be_else.39105:
	li      1, $i17
be_cont.39105:
be_cont.39104:
ble_cont.39103:
be_cont.39102:
be_cont.39101:
	bne     $i17, 0, be_else.39109
be_then.39109:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39109:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39110
be_then.39110:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39110:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39111
be_then.39111:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39112
be_then.39112:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39112:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39113
be_then.39113:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.39114
be_then.39114:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39114:
	li      1, $i1
	ret
be_else.39113:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39111:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39099:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
.end shadow_check_one_or_matrix

######################################################################
.begin solve_each_element
solve_each_element.2950:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.39115
be_then.39115:
	ret
be_else.39115:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 5], $i12
	load    [$i11 + 5], $i13
	load    [$i11 + 5], $i14
	load    [$i11 + 1], $i15
	load    [min_caml_startp + 0], $f10
	load    [$i12 + 0], $f11
	fsub    $f10, $f11, $f10
	load    [min_caml_startp + 1], $f11
	load    [$i13 + 1], $f12
	fsub    $f11, $f12, $f11
	load    [min_caml_startp + 2], $f12
	load    [$i14 + 2], $f13
	fsub    $f12, $f13, $f12
	load    [$i4 + 0], $f13
	bne     $i15, 1, be_else.39116
be_then.39116:
	bne     $f13, $f0, be_else.39117
be_then.39117:
	li      0, $i12
.count b_cont
	b       be_cont.39117
be_else.39117:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.39118
ble_then.39118:
	li      0, $i14
.count b_cont
	b       ble_cont.39118
ble_else.39118:
	li      1, $i14
ble_cont.39118:
	bne     $i13, 0, be_else.39119
be_then.39119:
	mov     $i14, $i13
.count b_cont
	b       be_cont.39119
be_else.39119:
	bne     $i14, 0, be_else.39120
be_then.39120:
	li      1, $i13
.count b_cont
	b       be_cont.39120
be_else.39120:
	li      0, $i13
be_cont.39120:
be_cont.39119:
	load    [$i12 + 0], $f14
	bne     $i13, 0, be_cont.39121
be_then.39121:
	fneg    $f14, $f14
be_cont.39121:
	fsub    $f14, $f10, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 1], $f14
	load    [$i4 + 1], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f11, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39122
ble_then.39122:
	li      0, $i12
.count b_cont
	b       ble_cont.39122
ble_else.39122:
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f12, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39123
ble_then.39123:
	li      0, $i12
.count b_cont
	b       ble_cont.39123
ble_else.39123:
.count move_float
	mov     $f13, $f44
	li      1, $i12
ble_cont.39123:
ble_cont.39122:
be_cont.39117:
	bne     $i12, 0, be_else.39124
be_then.39124:
	load    [$i4 + 1], $f13
	bne     $f13, $f0, be_else.39125
be_then.39125:
	li      0, $i12
.count b_cont
	b       be_cont.39125
be_else.39125:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.39126
ble_then.39126:
	li      0, $i14
.count b_cont
	b       ble_cont.39126
ble_else.39126:
	li      1, $i14
ble_cont.39126:
	bne     $i13, 0, be_else.39127
be_then.39127:
	mov     $i14, $i13
.count b_cont
	b       be_cont.39127
be_else.39127:
	bne     $i14, 0, be_else.39128
be_then.39128:
	li      1, $i13
.count b_cont
	b       be_cont.39128
be_else.39128:
	li      0, $i13
be_cont.39128:
be_cont.39127:
	load    [$i12 + 1], $f14
	bne     $i13, 0, be_cont.39129
be_then.39129:
	fneg    $f14, $f14
be_cont.39129:
	fsub    $f14, $f11, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f12, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39130
ble_then.39130:
	li      0, $i12
.count b_cont
	b       ble_cont.39130
ble_else.39130:
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f10, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39131
ble_then.39131:
	li      0, $i12
.count b_cont
	b       ble_cont.39131
ble_else.39131:
.count move_float
	mov     $f13, $f44
	li      1, $i12
ble_cont.39131:
ble_cont.39130:
be_cont.39125:
	bne     $i12, 0, be_else.39132
be_then.39132:
	load    [$i4 + 2], $f13
	bne     $f13, $f0, be_else.39133
be_then.39133:
	li      0, $i11
.count b_cont
	b       be_cont.39116
be_else.39133:
	load    [$i11 + 4], $i12
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	load    [$i11 + 6], $i11
	bg      $f0, $f13, ble_else.39134
ble_then.39134:
	li      0, $i13
.count b_cont
	b       ble_cont.39134
ble_else.39134:
	li      1, $i13
ble_cont.39134:
	bne     $i11, 0, be_else.39135
be_then.39135:
	mov     $i13, $i11
.count b_cont
	b       be_cont.39135
be_else.39135:
	bne     $i13, 0, be_else.39136
be_then.39136:
	li      1, $i11
.count b_cont
	b       be_cont.39136
be_else.39136:
	li      0, $i11
be_cont.39136:
be_cont.39135:
	load    [$i12 + 2], $f16
	bne     $i11, 0, be_cont.39137
be_then.39137:
	fneg    $f16, $f16
be_cont.39137:
	fsub    $f16, $f12, $f12
	finv    $f13, $f13
	fmul    $f12, $f13, $f12
	fmul    $f12, $f15, $f13
	fadd    $f13, $f10, $f10
	fabs    $f10, $f10
	bg      $f14, $f10, ble_else.39138
ble_then.39138:
	li      0, $i11
.count b_cont
	b       be_cont.39116
ble_else.39138:
	load    [$i12 + 1], $f10
	load    [$i4 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.39139
ble_then.39139:
	li      0, $i11
.count b_cont
	b       be_cont.39116
ble_else.39139:
.count move_float
	mov     $f12, $f44
	li      3, $i11
.count b_cont
	b       be_cont.39116
be_else.39132:
	li      2, $i11
.count b_cont
	b       be_cont.39116
be_else.39124:
	li      1, $i11
.count b_cont
	b       be_cont.39116
be_else.39116:
	bne     $i15, 2, be_else.39140
be_then.39140:
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
	bg      $f13, $f0, ble_else.39141
ble_then.39141:
	li      0, $i11
.count b_cont
	b       be_cont.39140
ble_else.39141:
	fmul    $f14, $f10, $f10
	fmul    $f16, $f11, $f11
	fadd    $f10, $f11, $f10
	fmul    $f17, $f12, $f11
	fadd    $f10, $f11, $f10
	fneg    $f10, $f10
	finv    $f13, $f11
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39140
be_else.39140:
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
	load    [$i14 + 1], $f19
	fmul    $f18, $f19, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f15, $f18
	load    [$i15 + 2], $f20
	fmul    $f18, $f20, $f18
	fadd    $f16, $f18, $f16
	be      $i12, 0, bne_cont.39142
bne_then.39142:
	fmul    $f14, $f15, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 0], $f21
	fmul    $f18, $f21, $f18
	fadd    $f16, $f18, $f16
	fmul    $f15, $f13, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 1], $f21
	fmul    $f18, $f21, $f18
	fadd    $f16, $f18, $f16
	fmul    $f13, $f14, $f18
	load    [$i11 + 9], $i13
	load    [$i13 + 2], $f21
	fmul    $f18, $f21, $f18
	fadd    $f16, $f18, $f16
bne_cont.39142:
	bne     $f16, $f0, be_else.39143
be_then.39143:
	li      0, $i11
.count b_cont
	b       be_cont.39143
be_else.39143:
	load    [$i11 + 1], $i13
	fmul    $f13, $f10, $f18
	fmul    $f18, $f17, $f18
	fmul    $f14, $f11, $f21
	fmul    $f21, $f19, $f21
	fadd    $f18, $f21, $f18
	fmul    $f15, $f12, $f21
	fmul    $f21, $f20, $f21
	fadd    $f18, $f21, $f18
	bne     $i12, 0, be_else.39144
be_then.39144:
	mov     $f18, $f13
.count b_cont
	b       be_cont.39144
be_else.39144:
	fmul    $f15, $f11, $f21
	fmul    $f14, $f12, $f22
	fadd    $f21, $f22, $f21
	load    [$i11 + 9], $i14
	load    [$i14 + 0], $f22
	fmul    $f21, $f22, $f21
	fmul    $f13, $f12, $f22
	fmul    $f15, $f10, $f15
	fadd    $f22, $f15, $f15
	load    [$i11 + 9], $i14
	load    [$i14 + 1], $f22
	fmul    $f15, $f22, $f15
	fadd    $f21, $f15, $f15
	fmul    $f13, $f11, $f13
	fmul    $f14, $f10, $f14
	fadd    $f13, $f14, $f13
	load    [$i11 + 9], $i14
	load    [$i14 + 2], $f14
	fmul    $f13, $f14, $f13
	fadd    $f15, $f13, $f13
	fmul    $f13, $f39, $f13
	fadd    $f18, $f13, $f13
be_cont.39144:
	fmul    $f13, $f13, $f14
	fmul    $f10, $f10, $f15
	fmul    $f15, $f17, $f15
	fmul    $f11, $f11, $f17
	fmul    $f17, $f19, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f12, $f17
	fmul    $f17, $f20, $f17
	fadd    $f15, $f17, $f15
	bne     $i12, 0, be_else.39145
be_then.39145:
	mov     $f15, $f10
.count b_cont
	b       be_cont.39145
be_else.39145:
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
be_cont.39145:
	bne     $i13, 3, be_cont.39146
be_then.39146:
	fsub    $f10, $f40, $f10
be_cont.39146:
	fmul    $f16, $f10, $f10
	fsub    $f14, $f10, $f10
	bg      $f10, $f0, ble_else.39147
ble_then.39147:
	li      0, $i11
.count b_cont
	b       ble_cont.39147
ble_else.39147:
	load    [$i11 + 6], $i11
	fsqrt   $f10, $f10
	finv    $f16, $f11
	bne     $i11, 0, be_else.39148
be_then.39148:
	fneg    $f10, $f10
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39148
be_else.39148:
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
be_cont.39148:
ble_cont.39147:
be_cont.39143:
be_cont.39140:
be_cont.39116:
	bne     $i11, 0, be_else.39149
be_then.39149:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39150
be_then.39150:
	ret
be_else.39150:
	add     $i2, 1, $i2
	b       solve_each_element.2950
be_else.39149:
	bg      $f44, $f0, ble_else.39151
ble_then.39151:
	add     $i2, 1, $i2
	b       solve_each_element.2950
ble_else.39151:
	bg      $f51, $f44, ble_else.39152
ble_then.39152:
	add     $i2, 1, $i2
	b       solve_each_element.2950
ble_else.39152:
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
.count load_float
	load    [f.34801], $f11
	fadd    $f44, $f11, $f11
	fmul    $f10, $f11, $f10
	load    [min_caml_startp + 0], $f12
	fadd    $f10, $f12, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i4 + 1], $f10
	fmul    $f10, $f11, $f10
	load    [min_caml_startp + 1], $f12
	fadd    $f10, $f12, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i4 + 2], $f10
	fmul    $f10, $f11, $f10
	load    [min_caml_startp + 2], $f12
	fadd    $f10, $f12, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2935
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.39153
be_then.39153:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2950
be_else.39153:
.count move_float
	mov     $f11, $f51
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
.count move_float
	mov     $i10, $i56
.count move_float
	mov     $i11, $i55
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2950
.end solve_each_element

######################################################################
.begin solve_one_or_network
solve_one_or_network.2954:
	load    [$i3 + $i2], $i16
	bne     $i16, -1, be_else.39154
be_then.39154:
	ret
be_else.39154:
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
	call    solve_each_element.2950
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i17
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39155
be_then.39155:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39155:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39156
be_then.39156:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39156:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39157
be_then.39157:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39157:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39158
be_then.39158:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39158:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39159
be_then.39159:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39159:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39160
be_then.39160:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39160:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39161
be_then.39161:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39161:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i4
.count move_args
	mov     $i17, $i3
	b       solve_one_or_network.2954
.end solve_one_or_network

######################################################################
.begin trace_or_matrix
trace_or_matrix.2958:
	load    [$i3 + $i2], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.39162
be_then.39162:
	ret
be_else.39162:
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
	bne     $i17, 99, be_else.39163
be_then.39163:
	load    [$i16 + 1], $i17
	be      $i17, -1, bne_cont.39164
bne_then.39164:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    solve_each_element.2950
	load    [$i16 + 2], $i17
	be      $i17, -1, bne_cont.39165
bne_then.39165:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 3], $i17
	be      $i17, -1, bne_cont.39166
bne_then.39166:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 4], $i17
	be      $i17, -1, bne_cont.39167
bne_then.39167:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 5], $i17
	be      $i17, -1, bne_cont.39168
bne_then.39168:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 6], $i17
	be      $i17, -1, bne_cont.39169
bne_then.39169:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network.2954
bne_cont.39169:
bne_cont.39168:
bne_cont.39167:
bne_cont.39166:
bne_cont.39165:
bne_cont.39164:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i16], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.39170
be_then.39170:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.39170:
	bne     $i18, 99, be_else.39171
be_then.39171:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39172
be_then.39172:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39172:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39173
be_then.39173:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39173:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.39174
be_then.39174:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39174:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.39175
be_then.39175:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39175:
.count stack_store
	store   $i16, [$sp + 4]
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	li      5, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i17, $i3
	call    solve_one_or_network.2954
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
	b       trace_or_matrix.2958
be_else.39171:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i18, $i2
	call    solver.2852
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39176
be_then.39176:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39176:
	bg      $f51, $f44, ble_else.39177
ble_then.39177:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
ble_else.39177:
.count stack_store
	store   $i16, [$sp + 4]
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i17, $i3
	call    solve_one_or_network.2954
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
	b       trace_or_matrix.2958
be_else.39163:
.count move_args
	mov     $i17, $i2
.count move_args
	mov     $i4, $i3
	call    solver.2852
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39178
be_then.39178:
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
	b       trace_or_matrix.2958
be_else.39178:
	bg      $f51, $f44, ble_else.39179
ble_then.39179:
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
	b       trace_or_matrix.2958
ble_else.39179:
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network.2954
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
	b       trace_or_matrix.2958
.end trace_or_matrix

######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2964:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.39180
be_then.39180:
	ret
be_else.39180:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 10], $i12
	load    [$i4 + 1], $i13
	load    [$i11 + 1], $i14
	load    [$i12 + 0], $f10
	load    [$i12 + 1], $f11
	load    [$i12 + 2], $f12
	load    [$i13 + $i10], $i13
	bne     $i14, 1, be_else.39181
be_then.39181:
	load    [$i4 + 0], $i12
	load    [$i11 + 4], $i14
	load    [$i14 + 1], $f13
	load    [$i12 + 1], $f14
	load    [$i13 + 0], $f15
	fsub    $f15, $f10, $f15
	load    [$i13 + 1], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd    $f14, $f11, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39182
ble_then.39182:
	li      0, $i14
.count b_cont
	b       ble_cont.39182
ble_else.39182:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39183
ble_then.39183:
	li      0, $i14
.count b_cont
	b       ble_cont.39183
ble_else.39183:
	load    [$i13 + 1], $f13
	bne     $f13, $f0, be_else.39184
be_then.39184:
	li      0, $i14
.count b_cont
	b       be_cont.39184
be_else.39184:
	li      1, $i14
be_cont.39184:
ble_cont.39183:
ble_cont.39182:
	bne     $i14, 0, be_else.39185
be_then.39185:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i12 + 0], $f14
	load    [$i13 + 2], $f15
	fsub    $f15, $f11, $f15
	load    [$i13 + 3], $f16
	fmul    $f15, $f16, $f15
	fmul    $f15, $f14, $f14
	fadd    $f14, $f10, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39186
ble_then.39186:
	li      0, $i14
.count b_cont
	b       ble_cont.39186
ble_else.39186:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39187
ble_then.39187:
	li      0, $i14
.count b_cont
	b       ble_cont.39187
ble_else.39187:
	load    [$i13 + 3], $f13
	bne     $f13, $f0, be_else.39188
be_then.39188:
	li      0, $i14
.count b_cont
	b       be_cont.39188
be_else.39188:
	li      1, $i14
be_cont.39188:
ble_cont.39187:
ble_cont.39186:
	bne     $i14, 0, be_else.39189
be_then.39189:
	load    [$i11 + 4], $i14
	load    [$i14 + 0], $f13
	load    [$i12 + 0], $f14
	load    [$i13 + 4], $f15
	fsub    $f15, $f12, $f12
	load    [$i13 + 5], $f15
	fmul    $f12, $f15, $f12
	fmul    $f12, $f14, $f14
	fadd    $f14, $f10, $f10
	fabs    $f10, $f10
	bg      $f13, $f10, ble_else.39190
ble_then.39190:
	li      0, $i11
.count b_cont
	b       be_cont.39181
ble_else.39190:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i12 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.39191
ble_then.39191:
	li      0, $i11
.count b_cont
	b       be_cont.39181
ble_else.39191:
	load    [$i13 + 5], $f10
	bne     $f10, $f0, be_else.39192
be_then.39192:
	li      0, $i11
.count b_cont
	b       be_cont.39181
be_else.39192:
.count move_float
	mov     $f12, $f44
	li      3, $i11
.count b_cont
	b       be_cont.39181
be_else.39189:
.count move_float
	mov     $f15, $f44
	li      2, $i11
.count b_cont
	b       be_cont.39181
be_else.39185:
.count move_float
	mov     $f15, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39181
be_else.39181:
	bne     $i14, 2, be_else.39193
be_then.39193:
	load    [$i13 + 0], $f10
	bg      $f0, $f10, ble_else.39194
ble_then.39194:
	li      0, $i11
.count b_cont
	b       be_cont.39193
ble_else.39194:
	load    [$i12 + 3], $f11
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39193
be_else.39193:
	load    [$i13 + 0], $f13
	bne     $f13, $f0, be_else.39195
be_then.39195:
	li      0, $i11
.count b_cont
	b       be_cont.39195
be_else.39195:
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
	bg      $f11, $f0, ble_else.39196
ble_then.39196:
	li      0, $i11
.count b_cont
	b       ble_cont.39196
ble_else.39196:
	load    [$i11 + 6], $i11
	fsqrt   $f11, $f11
	bne     $i11, 0, be_else.39197
be_then.39197:
	fsub    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
.count b_cont
	b       be_cont.39197
be_else.39197:
	fadd    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $f10
.count move_float
	mov     $f10, $f44
	li      1, $i11
be_cont.39197:
ble_cont.39196:
be_cont.39195:
be_cont.39193:
be_cont.39181:
	bne     $i11, 0, be_else.39198
be_then.39198:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39199
be_then.39199:
	ret
be_else.39199:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
be_else.39198:
	bg      $f44, $f0, ble_else.39200
ble_then.39200:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
ble_else.39200:
	load    [$i4 + 0], $i12
	bg      $f51, $f44, ble_else.39201
ble_then.39201:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
ble_else.39201:
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
.count load_float
	load    [f.34801], $f11
	fadd    $f44, $f11, $f11
	fmul    $f10, $f11, $f10
	fadd    $f10, $f53, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i12 + 1], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $f54, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i12 + 2], $f10
	fmul    $f10, $f11, $f10
	fadd    $f10, $f55, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2935
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.39202
be_then.39202:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2964
be_else.39202:
.count move_float
	mov     $f11, $f51
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
.count move_float
	mov     $i10, $i56
.count move_float
	mov     $i11, $i55
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2964
.end solve_each_element_fast

######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2968:
	load    [$i3 + $i2], $i15
	bne     $i15, -1, be_else.39203
be_then.39203:
	ret
be_else.39203:
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
	call    solve_each_element_fast.2964
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39204
be_then.39204:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39204:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39205
be_then.39205:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39205:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39206
be_then.39206:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39206:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39207
be_then.39207:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39207:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39208
be_then.39208:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39208:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39209
be_then.39209:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39209:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39210
be_then.39210:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39210:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i4
.count move_args
	mov     $i16, $i3
	b       solve_one_or_network_fast.2968
.end solve_one_or_network_fast

######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2972:
	load    [$i3 + $i2], $i15
	load    [$i15 + 0], $i16
	bne     $i16, -1, be_else.39211
be_then.39211:
	ret
be_else.39211:
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
	bne     $i16, 99, be_else.39212
be_then.39212:
	load    [$i15 + 1], $i16
	be      $i16, -1, bne_cont.39213
bne_then.39213:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
	call    solve_each_element_fast.2964
	load    [$i15 + 2], $i16
	be      $i16, -1, bne_cont.39214
bne_then.39214:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 3], $i16
	be      $i16, -1, bne_cont.39215
bne_then.39215:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 4], $i16
	be      $i16, -1, bne_cont.39216
bne_then.39216:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 5], $i16
	be      $i16, -1, bne_cont.39217
bne_then.39217:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 6], $i16
	be      $i16, -1, bne_cont.39218
bne_then.39218:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	li      7, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i15, $i3
	call    solve_one_or_network_fast.2968
bne_cont.39218:
bne_cont.39217:
bne_cont.39216:
bne_cont.39215:
bne_cont.39214:
bne_cont.39213:
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i15], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.39219
be_then.39219:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.39219:
	bne     $i17, 99, be_else.39220
be_then.39220:
	load    [$i16 + 1], $i17
	bne     $i17, -1, be_else.39221
be_then.39221:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39221:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 2], $i17
	bne     $i17, -1, be_else.39222
be_then.39222:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39222:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 3], $i17
	bne     $i17, -1, be_else.39223
be_then.39223:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39223:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 4], $i17
	bne     $i17, -1, be_else.39224
be_then.39224:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39224:
.count stack_store
	store   $i15, [$sp + 4]
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	li      5, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network_fast.2968
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
	b       trace_or_matrix_fast.2972
be_else.39220:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i17, $i2
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39225
be_then.39225:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39225:
	bg      $f51, $f44, ble_else.39226
ble_then.39226:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 3], $i3
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
ble_else.39226:
.count stack_store
	store   $i15, [$sp + 4]
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i16, $i3
	call    solve_one_or_network_fast.2968
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
	b       trace_or_matrix_fast.2972
be_else.39212:
.count move_args
	mov     $i16, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39227
be_then.39227:
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
	b       trace_or_matrix_fast.2972
be_else.39227:
	bg      $f51, $f44, ble_else.39228
ble_then.39228:
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
	b       trace_or_matrix_fast.2972
ble_else.39228:
	li      1, $i2
.count stack_load
	load    [$sp + 1], $i4
.count move_args
	mov     $i15, $i3
	call    solve_one_or_network_fast.2968
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
	b       trace_or_matrix_fast.2972
.end trace_or_matrix_fast

######################################################################
.begin cordic_rec
cordic_rec.6377.8520:
	bne     $i2, 25, be_else.39229
be_then.39229:
	mov     $f4, $f1
	ret
be_else.39229:
	fmul    $f5, $f3, $f1
	add     $i2, 1, $i1
	bg      $f3, $f0, ble_else.39230
ble_then.39230:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
	bne     $i1, 25, be_else.39231
be_then.39231:
	mov     $f3, $f1
	ret
be_else.39231:
	fmul    $f4, $f2, $f5
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39232
ble_then.39232:
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8520
ble_else.39232:
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8520
ble_else.39230:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
	bne     $i1, 25, be_else.39233
be_then.39233:
	mov     $f3, $f1
	ret
be_else.39233:
	fmul    $f4, $f2, $f5
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39234
ble_then.39234:
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8520
ble_else.39234:
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8520
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6377.8578:
	bne     $i2, 25, be_else.39235
be_then.39235:
	mov     $f4, $f1
	ret
be_else.39235:
	fmul    $f5, $f3, $f1
	add     $i2, 1, $i1
	bg      $f3, $f0, ble_else.39236
ble_then.39236:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
	bne     $i1, 25, be_else.39237
be_then.39237:
	mov     $f3, $f1
	ret
be_else.39237:
	fmul    $f4, $f2, $f5
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39238
ble_then.39238:
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8578
ble_else.39238:
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8578
ble_else.39236:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
	bne     $i1, 25, be_else.39239
be_then.39239:
	mov     $f3, $f1
	ret
be_else.39239:
	fmul    $f4, $f2, $f5
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39240
ble_then.39240:
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8578
ble_else.39240:
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f4, $f39, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f1, $f3
	b       cordic_rec.6377.8578
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.27406:
	bne     $i2, 25, be_else.39241
be_then.39241:
	mov     $f4, $f1
	ret
be_else.39241:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39242
ble_then.39242:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39243
be_then.39243:
	ret
be_else.39243:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39244
ble_then.39244:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.27406
ble_else.39244:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.27406
ble_else.39242:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39245
be_then.39245:
	ret
be_else.39245:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39246
ble_then.39246:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.27406
ble_else.39246:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.27406
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.31997:
	bne     $i2, 25, be_else.39247
be_then.39247:
	mov     $f4, $f1
	ret
be_else.39247:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39248
ble_then.39248:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39249
be_then.39249:
	ret
be_else.39249:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39250
ble_then.39250:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.31997
ble_else.39250:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.31997
ble_else.39248:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39251
be_then.39251:
	ret
be_else.39251:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39252
ble_then.39252:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.31997
ble_else.39252:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.31997
.end cordic_rec

######################################################################
.begin utexture
utexture.2987:
	load    [$i2 + 8], $i1
	load    [$i1 + 0], $f10
.count move_float
	mov     $f10, $f56
	load    [$i2 + 8], $i1
	load    [$i1 + 1], $f10
.count move_float
	mov     $f10, $f52
	load    [$i2 + 8], $i1
	load    [$i1 + 2], $f10
.count move_float
	mov     $f10, $f60
	load    [$i2 + 0], $i1
	bne     $i1, 1, be_else.39253
be_then.39253:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
	load    [min_caml_intersection_point + 0], $f10
	load    [$i1 + 0], $f11
.count load_float
	load    [f.34813], $f12
	fsub    $f10, $f11, $f10
	fmul    $f10, $f12, $f2
	call    min_caml_floor
.count move_ret
	mov     $f1, $f11
.count load_float
	load    [f.34814], $f13
.count load_float
	load    [f.34815], $f14
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
	add     $sp, 5, $sp
	fmul    $f1, $f13, $f1
	fsub    $f11, $f1, $f1
	bg      $f14, $f10, ble_else.39254
ble_then.39254:
	li      0, $i1
.count b_cont
	b       ble_cont.39254
ble_else.39254:
	li      1, $i1
ble_cont.39254:
	bg      $f14, $f1, ble_else.39255
ble_then.39255:
	bne     $i1, 0, be_else.39256
be_then.39256:
.count load_float
	load    [f.34809], $f1
.count move_float
	mov     $f1, $f52
	ret
be_else.39256:
.count move_float
	mov     $f0, $f52
	ret
ble_else.39255:
	bne     $i1, 0, be_else.39257
be_then.39257:
.count move_float
	mov     $f0, $f52
	ret
be_else.39257:
.count load_float
	load    [f.34809], $f1
.count move_float
	mov     $f1, $f52
	ret
be_else.39253:
	bne     $i1, 2, be_else.39258
be_then.39258:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [min_caml_intersection_point + 1], $f14
.count load_float
	load    [f.34812], $f15
	fmul    $f14, $f15, $f14
.count load_float
	load    [f.34809], $f15
	bg      $f0, $f14, ble_else.39259
ble_then.39259:
.count load_float
	load    [f.34777], $f16
	bg      $f16, $f14, ble_else.39260
ble_then.39260:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.39261
ble_then.39261:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.39262
ble_then.39262:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39262:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fneg    $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39261:
	fsub    $f16, $f14, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.39263
ble_then.39263:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.31997
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39263:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.31997
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39260:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f14, $f2
	li      1, $i2
	bg      $f14, $f0, ble_else.39264
ble_then.39264:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.27406
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39264:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.27406
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
ble_else.39259:
	fneg    $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fneg    $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
.count move_float
	mov     $f2, $f56
	fsub    $f40, $f1, $f1
	fmul    $f15, $f1, $f1
.count move_float
	mov     $f1, $f52
	ret
be_else.39258:
	bne     $i1, 3, be_else.39265
be_then.39265:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i1
	load    [$i2 + 5], $i10
.count load_float
	load    [f.34809], $f10
.count stack_store
	store   $f10, [$sp + 1]
.count load_float
	load    [f.34777], $f10
	load    [min_caml_intersection_point + 0], $f11
	load    [$i1 + 0], $f12
	fsub    $f11, $f12, $f11
	fmul    $f11, $f11, $f11
	load    [min_caml_intersection_point + 2], $f12
	load    [$i10 + 2], $f13
	fsub    $f12, $f13, $f12
	fmul    $f12, $f12, $f12
	fadd    $f11, $f12, $f11
	fsqrt   $f11, $f11
.count load_float
	load    [f.34811], $f12
	fmul    $f11, $f12, $f2
.count stack_store
	store   $f2, [$sp + 2]
	call    min_caml_floor
.count move_ret
	mov     $f1, $f14
.count stack_load
	load    [$sp + 2], $f15
	fsub    $f15, $f14, $f14
.count load_float
	load    [f.34807], $f15
	fmul    $f14, $f15, $f14
	fsub    $f10, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	fmul    $f1, $f1, $f1
.count stack_load
	load    [$sp - 4], $f2
	fmul    $f1, $f2, $f3
.count move_float
	mov     $f3, $f52
	fsub    $f40, $f1, $f1
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f60
	ret
be_else.39265:
	bne     $i1, 4, be_else.39266
be_then.39266:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + 5], $i10
	load    [$i2 + 4], $i11
	load    [$i2 + 5], $i12
	load    [$i2 + 4], $i13
	load    [$i2 + 5], $i14
	load    [$i2 + 4], $i15
.count load_float
	load    [f.34803], $f10
.count load_float
	load    [f.34804], $f11
	load    [min_caml_intersection_point + 0], $f12
	load    [$i10 + 0], $f13
	fsub    $f12, $f13, $f12
	load    [$i11 + 0], $f13
	fsqrt   $f13, $f13
	fmul    $f12, $f13, $f12
	fabs    $f12, $f13
	load    [min_caml_intersection_point + 2], $f14
	load    [$i12 + 2], $f15
	fsub    $f14, $f15, $f14
	load    [$i13 + 2], $f15
	fsqrt   $f15, $f15
	fmul    $f14, $f15, $f14
	bg      $f11, $f13, ble_else.39267
ble_then.39267:
	finv    $f12, $f13
	fmul    $f14, $f13, $f13
	fabs    $f13, $f13
.count move_args
	mov     $f39, $f5
	li      1, $i2
	bg      $f13, $f0, ble_else.39268
ble_then.39268:
	fsub    $f40, $f13, $f2
	fadd    $f13, $f40, $f3
	load    [min_caml_atan_table + 0], $f13
	fneg    $f13, $f4
	call    cordic_rec.6377.8578
.count move_ret
	mov     $f1, $f13
.count load_float
	load    [f.34806], $f15
	fmul    $f13, $f15, $f13
.count load_float
	load    [f.34807], $f15
.count load_float
	load    [f.34808], $f15
	fmul    $f13, $f15, $f2
.count b_cont
	b       ble_cont.39267
ble_else.39268:
	fadd    $f40, $f13, $f2
	fsub    $f13, $f40, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.8578
.count move_ret
	mov     $f1, $f13
.count load_float
	load    [f.34806], $f15
	fmul    $f13, $f15, $f13
.count load_float
	load    [f.34807], $f15
.count load_float
	load    [f.34808], $f15
	fmul    $f13, $f15, $f2
.count b_cont
	b       ble_cont.39267
ble_else.39267:
.count load_float
	load    [f.34805], $f2
ble_cont.39267:
.count stack_store
	store   $f2, [$sp + 3]
	call    min_caml_floor
.count move_ret
	mov     $f1, $f13
.count stack_load
	load    [$sp + 3], $f15
	fsub    $f15, $f13, $f13
	fsub    $f39, $f13, $f13
	fmul    $f13, $f13, $f13
	fsub    $f10, $f13, $f10
	fmul    $f12, $f12, $f12
	fmul    $f14, $f14, $f13
	fadd    $f12, $f13, $f12
	fabs    $f12, $f13
	load    [min_caml_intersection_point + 1], $f14
	load    [$i14 + 1], $f15
	fsub    $f14, $f15, $f14
	load    [$i15 + 1], $f15
	fsqrt   $f15, $f15
	fmul    $f14, $f15, $f14
	bg      $f11, $f13, ble_else.39269
ble_then.39269:
	finv    $f12, $f11
	fmul    $f14, $f11, $f11
	fabs    $f11, $f11
.count move_args
	mov     $f39, $f5
	li      1, $i2
	bg      $f11, $f0, ble_else.39270
ble_then.39270:
	fsub    $f40, $f11, $f2
	fadd    $f11, $f40, $f3
	load    [min_caml_atan_table + 0], $f11
	fneg    $f11, $f4
	call    cordic_rec.6377.8520
.count move_ret
	mov     $f1, $f11
.count load_float
	load    [f.34806], $f12
	fmul    $f11, $f12, $f11
.count load_float
	load    [f.34807], $f12
.count load_float
	load    [f.34808], $f12
	fmul    $f11, $f12, $f2
.count b_cont
	b       ble_cont.39269
ble_else.39270:
	fadd    $f40, $f11, $f2
	fsub    $f11, $f40, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.8520
.count move_ret
	mov     $f1, $f11
.count load_float
	load    [f.34806], $f12
	fmul    $f11, $f12, $f11
.count load_float
	load    [f.34807], $f12
.count load_float
	load    [f.34808], $f12
	fmul    $f11, $f12, $f2
.count b_cont
	b       ble_cont.39269
ble_else.39269:
.count load_float
	load    [f.34805], $f2
ble_cont.39269:
.count stack_store
	store   $f2, [$sp + 4]
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $f2
	fsub    $f2, $f1, $f1
	fsub    $f39, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f10, $f1, $f1
	bg      $f0, $f1, ble_else.39271
ble_then.39271:
.count load_float
	load    [f.34809], $f2
	fmul    $f2, $f1, $f1
.count load_float
	load    [f.34810], $f2
	fmul    $f1, $f2, $f1
.count move_float
	mov     $f1, $f60
	ret
ble_else.39271:
.count move_float
	mov     $f0, $f60
	ret
be_else.39266:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2994:
	bl      $i2, 0, bge_else.39272
bge_then.39272:
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
.count load_float
	load    [f.34816], $f17
.count move_float
	mov     $f17, $f51
	load    [$i53 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.39273
bne_then.39273:
	bne     $i21, 99, be_else.39274
be_then.39274:
	load    [$i20 + 1], $i21
	bne     $i21, -1, be_else.39275
be_then.39275:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39274
be_else.39275:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39276
be_then.39276:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39274
be_else.39276:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39277
be_then.39277:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39274
be_else.39277:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39278
be_then.39278:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39274
be_else.39278:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	li      5, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39274
be_else.39274:
.count move_args
	mov     $i21, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 5], $i4
	li      1, $i2
	bne     $i21, 0, be_else.39279
be_then.39279:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39279
be_else.39279:
	bg      $f51, $f44, ble_else.39280
ble_then.39280:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       ble_cont.39280
ble_else.39280:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 5], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
ble_cont.39280:
be_cont.39279:
be_cont.39274:
bne_cont.39273:
.count load_float
	load    [f.34802], $f28
	bg      $f51, $f28, ble_else.39281
ble_then.39281:
	li      0, $i22
.count b_cont
	b       ble_cont.39281
ble_else.39281:
.count load_float
	load    [f.34817], $f28
	bg      $f28, $f51, ble_else.39282
ble_then.39282:
	li      0, $i22
.count b_cont
	b       ble_cont.39282
ble_else.39282:
	li      1, $i22
ble_cont.39282:
ble_cont.39281:
	bne     $i22, 0, be_else.39283
be_then.39283:
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
	b       trace_reflections.2994
be_else.39283:
	load    [$i19 + 0], $i22
	add     $i56, $i56, $i23
	add     $i23, $i23, $i23
	add     $i23, $i55, $i23
	bne     $i23, $i22, be_else.39284
be_then.39284:
.count stack_store
	store   $i19, [$sp + 6]
	li      0, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 4], $f2
	bne     $i1, 0, be_else.39285
be_then.39285:
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
	ble     $f3, $f0, bg_cont.39286
bg_then.39286:
	fmul    $f3, $f56, $f4
	fadd    $f48, $f4, $f4
.count move_float
	mov     $f4, $f48
	fmul    $f3, $f52, $f4
	fadd    $f49, $f4, $f4
.count move_float
	mov     $f4, $f49
	fmul    $f3, $f60, $f3
	fadd    $f50, $f3, $f3
.count move_float
	mov     $f3, $f50
bg_cont.39286:
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
	ble     $f1, $f0, trace_reflections.2994
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f3, $f1
	fadd    $f48, $f1, $f4
.count move_float
	mov     $f4, $f48
	fadd    $f49, $f1, $f4
.count move_float
	mov     $f4, $f49
	fadd    $f50, $f1, $f1
.count move_float
	mov     $f1, $f50
	b       trace_reflections.2994
be_else.39285:
.count stack_load
	load    [$sp - 3], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $f3
.count stack_load
	load    [$sp - 6], $i3
	b       trace_reflections.2994
be_else.39284:
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
	b       trace_reflections.2994
bge_else.39272:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2999:
	bg      $i2, 4, ble_else.39288
ble_then.39288:
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
.count load_float
	load    [f.34816], $f23
.count move_float
	mov     $f23, $f51
	load    [$i53 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.39289
bne_then.39289:
	bne     $i21, 99, be_else.39290
be_then.39290:
	load    [$i20 + 1], $i21
.count move_args
	mov     $i3, $i4
	bne     $i21, -1, be_else.39291
be_then.39291:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39290
be_else.39291:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i16
.count move_args
	mov     $i16, $i3
	call    solve_each_element.2950
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.39292
be_then.39292:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39290
be_else.39292:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element.2950
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.39293
be_then.39293:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39290
be_else.39293:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element.2950
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 3], $i4
	bne     $i21, -1, be_else.39294
be_then.39294:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39290
be_else.39294:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element.2950
	li      5, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network.2954
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39290
be_else.39290:
.count move_args
	mov     $i21, $i2
	call    solver.2852
.count move_ret
	mov     $i1, $i21
.count stack_load
	load    [$sp + 3], $i4
	li      1, $i2
	bne     $i21, 0, be_else.39295
be_then.39295:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39295
be_else.39295:
	bg      $f51, $f44, ble_else.39296
ble_then.39296:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       ble_cont.39296
ble_else.39296:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network.2954
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix.2958
ble_cont.39296:
be_cont.39295:
be_cont.39290:
bne_cont.39289:
.count stack_load
	load    [$sp + 5], $i16
	load    [$i16 + 2], $i17
.count load_float
	load    [f.34802], $f17
	bg      $f51, $f17, ble_else.39297
ble_then.39297:
	li      0, $i18
.count b_cont
	b       ble_cont.39297
ble_else.39297:
.count load_float
	load    [f.34817], $f18
	bg      $f18, $f51, ble_else.39298
ble_then.39298:
	li      0, $i18
.count b_cont
	b       ble_cont.39298
ble_else.39298:
	li      1, $i18
ble_cont.39298:
ble_cont.39297:
	bne     $i18, 0, be_else.39299
be_then.39299:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i0, -1, $i1
.count stack_load
	load    [$sp - 6], $i2
.count storer
	add     $i17, $i2, $tmp
	store   $i1, [$tmp + 0]
	bne     $i2, 0, be_else.39300
be_then.39300:
	ret
be_else.39300:
.count stack_load
	load    [$sp - 7], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $f57, $f1
	load    [$i1 + 1], $f2
	fmul    $f2, $f58, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	fmul    $f2, $f59, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	bg      $f1, $f0, ble_else.39301
ble_then.39301:
	ret
ble_else.39301:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
.count stack_load
	load    [$sp - 8], $f2
	fmul    $f1, $f2, $f1
	load    [min_caml_beam + 0], $f2
	fmul    $f1, $f2, $f1
	fadd    $f48, $f1, $f2
.count move_float
	mov     $f2, $f48
	fadd    $f49, $f1, $f2
.count move_float
	mov     $f2, $f49
	fadd    $f50, $f1, $f1
.count move_float
	mov     $f1, $f50
	ret
be_else.39299:
.count stack_store
	store   $i17, [$sp + 6]
	load    [min_caml_objects + $i56], $i2
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 1], $i18
	bne     $i18, 1, be_else.39302
be_then.39302:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $i55, 1, $i18
.count stack_load
	load    [$sp + 3], $i19
	load    [$i19 + $i18], $f18
	bne     $f18, $f0, be_else.39303
be_then.39303:
	store   $f0, [min_caml_nvector + $i18]
.count b_cont
	b       be_cont.39302
be_else.39303:
	bg      $f18, $f0, ble_else.39304
ble_then.39304:
.count load_float
	load    [f.34798], $f18
	store   $f40, [min_caml_nvector + $i18]
.count b_cont
	b       be_cont.39302
ble_else.39304:
.count load_float
	load    [f.34798], $f18
	store   $f18, [min_caml_nvector + $i18]
.count b_cont
	b       be_cont.39302
be_else.39302:
	bne     $i18, 2, be_else.39305
be_then.39305:
	load    [$i2 + 4], $i18
	load    [$i18 + 0], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 4], $i18
	load    [$i18 + 1], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 4], $i18
	load    [$i18 + 2], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39305
be_else.39305:
	load    [$i2 + 3], $i18
	load    [$i2 + 4], $i19
	load    [$i19 + 0], $f18
	load    [min_caml_intersection_point + 0], $f19
	load    [$i2 + 5], $i19
	load    [$i19 + 0], $f20
	fsub    $f19, $f20, $f19
	fmul    $f19, $f18, $f18
	load    [$i2 + 4], $i19
	load    [$i19 + 1], $f20
	load    [min_caml_intersection_point + 1], $f21
	load    [$i2 + 5], $i19
	load    [$i19 + 1], $f22
	fsub    $f21, $f22, $f21
	fmul    $f21, $f20, $f20
	load    [$i2 + 4], $i19
	load    [$i19 + 2], $f22
	load    [min_caml_intersection_point + 2], $f23
	load    [$i2 + 5], $i19
	load    [$i19 + 2], $f24
	fsub    $f23, $f24, $f23
	fmul    $f23, $f22, $f22
	bne     $i18, 0, be_else.39306
be_then.39306:
	store   $f18, [min_caml_nvector + 0]
	store   $f20, [min_caml_nvector + 1]
	store   $f22, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39306
be_else.39306:
	load    [$i2 + 9], $i18
	load    [$i18 + 2], $f24
	fmul    $f21, $f24, $f24
	load    [$i2 + 9], $i18
	load    [$i18 + 1], $f25
	fmul    $f23, $f25, $f25
	fadd    $f24, $f25, $f24
	fmul    $f24, $f39, $f24
	fadd    $f18, $f24, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 9], $i18
	load    [$i18 + 2], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i18
	load    [$i18 + 0], $f24
	fmul    $f23, $f24, $f23
	fadd    $f18, $f23, $f18
	fmul    $f18, $f39, $f18
	fadd    $f20, $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 9], $i18
	load    [$i18 + 1], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i18
	load    [$i18 + 0], $f19
	fmul    $f21, $f19, $f19
	fadd    $f18, $f19, $f18
	fmul    $f18, $f39, $f18
	fadd    $f22, $f18, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39306:
	load    [min_caml_nvector + 0], $f18
	load    [$i2 + 6], $i18
	fmul    $f18, $f18, $f19
	load    [min_caml_nvector + 1], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	load    [min_caml_nvector + 2], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	fsqrt   $f19, $f19
	bne     $f19, $f0, be_else.39307
be_then.39307:
	mov     $f40, $f19
.count b_cont
	b       be_cont.39307
be_else.39307:
	finv    $f19, $f19
	be      $i18, 0, bne_cont.39308
bne_then.39308:
.count load_float
	load    [f.34798], $f20
	fneg    $f19, $f19
bne_cont.39308:
be_cont.39307:
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39305:
be_cont.39302:
	load    [min_caml_intersection_point + 0], $f18
	store   $f18, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $f18
	store   $f18, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $f18
	store   $f18, [min_caml_startp + 2]
	call    utexture.2987
	add     $i56, $i56, $i10
	add     $i10, $i10, $i10
	add     $i10, $i55, $i10
.count stack_load
	load    [$sp + 4], $i11
.count storer
	add     $i17, $i11, $tmp
	store   $i10, [$tmp + 0]
	load    [$i16 + 1], $i10
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
	load    [$i16 + 3], $i12
	load    [$i10 + 0], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f10, $f11, $f11
.count stack_store
	store   $f11, [$sp + 8]
.count storer
	add     $i12, $i11, $tmp
	bg      $f39, $f10, ble_else.39309
ble_then.39309:
	li      1, $i10
	store   $i10, [$tmp + 0]
	load    [$i16 + 4], $i10
	load    [$i10 + $i11], $i12
	store   $f56, [$i12 + 0]
	store   $f52, [$i12 + 1]
	store   $f60, [$i12 + 2]
	load    [$i10 + $i11], $i10
.count load_float
	load    [f.34818], $f10
.count load_float
	load    [f.34819], $f10
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
	load    [$i16 + 7], $i10
	load    [$i10 + $i11], $i10
	load    [min_caml_nvector + 0], $f10
	store   $f10, [$i10 + 0]
	load    [min_caml_nvector + 1], $f10
	store   $f10, [$i10 + 1]
	load    [min_caml_nvector + 2], $f10
	store   $f10, [$i10 + 2]
.count b_cont
	b       ble_cont.39309
ble_else.39309:
	li      0, $i10
	store   $i10, [$tmp + 0]
ble_cont.39309:
	load    [min_caml_nvector + 0], $f10
.count load_float
	load    [f.34820], $f11
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
	load    [$i53 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.39310
be_then.39310:
	li      0, $i10
.count b_cont
	b       be_cont.39310
be_else.39310:
.count stack_store
	store   $i10, [$sp + 9]
	bne     $i2, 99, be_else.39311
be_then.39311:
	li      1, $i22
.count b_cont
	b       be_cont.39311
be_else.39311:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39312
be_then.39312:
	li      0, $i22
.count b_cont
	b       be_cont.39312
be_else.39312:
	bg      $f17, $f44, ble_else.39313
ble_then.39313:
	li      0, $i22
.count b_cont
	b       ble_cont.39313
ble_else.39313:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.39314
be_then.39314:
	li      0, $i22
.count b_cont
	b       be_cont.39314
be_else.39314:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39315
be_then.39315:
.count stack_load
	load    [$sp + 9], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39316
be_then.39316:
	li      0, $i22
.count b_cont
	b       be_cont.39315
be_else.39316:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39317
be_then.39317:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39318
be_then.39318:
	li      0, $i22
.count b_cont
	b       be_cont.39315
be_else.39318:
	li      1, $i22
.count b_cont
	b       be_cont.39315
be_else.39317:
	li      1, $i22
.count b_cont
	b       be_cont.39315
be_else.39315:
	li      1, $i22
be_cont.39315:
be_cont.39314:
ble_cont.39313:
be_cont.39312:
be_cont.39311:
	bne     $i22, 0, be_else.39319
be_then.39319:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39319
be_else.39319:
.count stack_load
	load    [$sp + 9], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.39320
be_then.39320:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39320
be_else.39320:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39321
be_then.39321:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.39322
be_then.39322:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39321
be_else.39322:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39323
be_then.39323:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39324
be_then.39324:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39321
be_else.39324:
	li      1, $i10
.count b_cont
	b       be_cont.39321
be_else.39323:
	li      1, $i10
.count b_cont
	b       be_cont.39321
be_else.39321:
	li      1, $i10
be_cont.39321:
be_cont.39320:
be_cont.39319:
be_cont.39310:
.count stack_load
	load    [$sp + 7], $i11
	load    [$i11 + 7], $i11
	load    [$i11 + 1], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f11, $f10, $f10
	bne     $i10, 0, be_cont.39325
be_then.39325:
	load    [min_caml_nvector + 0], $f11
	fmul    $f11, $f57, $f11
	load    [min_caml_nvector + 1], $f12
	fmul    $f12, $f58, $f12
	fadd    $f11, $f12, $f11
	load    [min_caml_nvector + 2], $f12
	fmul    $f12, $f59, $f12
	fadd    $f11, $f12, $f11
	fneg    $f11, $f11
.count stack_load
	load    [$sp + 8], $f12
	fmul    $f11, $f12, $f11
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f12
	fmul    $f12, $f57, $f12
	load    [$i10 + 1], $f13
	fmul    $f13, $f58, $f13
	fadd    $f12, $f13, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $f59, $f13
	fadd    $f12, $f13, $f12
	fneg    $f12, $f12
	ble     $f11, $f0, bg_cont.39326
bg_then.39326:
	fmul    $f11, $f56, $f13
	fadd    $f48, $f13, $f13
.count move_float
	mov     $f13, $f48
	fmul    $f11, $f52, $f13
	fadd    $f49, $f13, $f13
.count move_float
	mov     $f13, $f49
	fmul    $f11, $f60, $f11
	fadd    $f50, $f11, $f11
.count move_float
	mov     $f11, $f50
bg_cont.39326:
	ble     $f12, $f0, bg_cont.39327
bg_then.39327:
	fmul    $f12, $f12, $f11
	fmul    $f11, $f11, $f11
	fmul    $f11, $f10, $f11
	fadd    $f48, $f11, $f12
.count move_float
	mov     $f12, $f48
	fadd    $f49, $f11, $f12
.count move_float
	mov     $f12, $f49
	fadd    $f50, $f11, $f11
.count move_float
	mov     $f11, $f50
bg_cont.39327:
be_cont.39325:
	li      min_caml_intersection_point, $i2
	load    [min_caml_intersection_point + 0], $f11
.count move_float
	mov     $f11, $f53
	load    [min_caml_intersection_point + 1], $f11
.count move_float
	mov     $f11, $f54
	load    [min_caml_intersection_point + 2], $f11
.count move_float
	mov     $f11, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	sub     $i57, 1, $i2
.count stack_load
	load    [$sp + 8], $f2
.count stack_load
	load    [$sp + 3], $i3
.count move_args
	mov     $f10, $f3
	call    trace_reflections.2994
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count load_float
	load    [f.34811], $f1
.count stack_load
	load    [$sp - 8], $f2
	bg      $f2, $f1, ble_else.39328
ble_then.39328:
	ret
ble_else.39328:
.count stack_load
	load    [$sp - 6], $i1
	bge     $i1, 4, bl_cont.39329
bl_then.39329:
	add     $i1, 1, $i1
	add     $i0, -1, $i2
.count stack_load
	load    [$sp - 4], $i3
.count storer
	add     $i3, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.39329:
.count stack_load
	load    [$sp - 3], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.39330
be_then.39330:
	load    [$i1 + 7], $i1
.count stack_load
	load    [$sp - 9], $f1
	fadd    $f1, $f51, $f3
.count stack_load
	load    [$sp - 6], $i2
	add     $i2, 1, $i2
	load    [$i1 + 0], $f1
	fsub    $f40, $f1, $f1
	fmul    $f2, $f1, $f2
.count stack_load
	load    [$sp - 7], $i3
.count stack_load
	load    [$sp - 5], $i4
	b       trace_ray.2999
be_else.39330:
	ret
ble_else.39288:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.3005:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f2, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count load_float
	load    [f.34816], $f17
.count move_float
	mov     $f17, $f51
	load    [$i53 + 0], $i19
	load    [$i19 + 0], $i20
	be      $i20, -1, bne_cont.39331
bne_then.39331:
	bne     $i20, 99, be_else.39332
be_then.39332:
	load    [$i19 + 1], $i20
.count move_args
	mov     $i2, $i4
	bne     $i20, -1, be_else.39333
be_then.39333:
	li      1, $i19
.count move_args
	mov     $i53, $i3
.count move_args
	mov     $i19, $i2
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39332
be_else.39333:
	li      0, $i15
	load    [min_caml_and_net + $i20], $i3
.count move_args
	mov     $i15, $i2
	call    solve_each_element_fast.2964
	load    [$i19 + 2], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39334
be_then.39334:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39332
be_else.39334:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2964
	load    [$i19 + 3], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39335
be_then.39335:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39332
be_else.39335:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2964
	load    [$i19 + 4], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39336
be_then.39336:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39332
be_else.39336:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2964
	li      5, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39332
be_else.39332:
.count move_args
	mov     $i2, $i3
.count move_args
	mov     $i20, $i2
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i20
.count stack_load
	load    [$sp + 2], $i4
	li      1, $i2
	bne     $i20, 0, be_else.39337
be_then.39337:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39337
be_else.39337:
	bg      $f51, $f44, ble_else.39338
ble_then.39338:
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       ble_cont.39338
ble_else.39338:
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 2], $i4
.count move_args
	mov     $i53, $i3
	call    trace_or_matrix_fast.2972
ble_cont.39338:
be_cont.39337:
be_cont.39332:
bne_cont.39331:
.count load_float
	load    [f.34802], $f17
	bg      $f51, $f17, ble_else.39339
ble_then.39339:
	li      0, $i16
.count b_cont
	b       ble_cont.39339
ble_else.39339:
.count load_float
	load    [f.34817], $f18
	bg      $f18, $f51, ble_else.39340
ble_then.39340:
	li      0, $i16
.count b_cont
	b       ble_cont.39340
ble_else.39340:
	li      1, $i16
ble_cont.39340:
ble_cont.39339:
	bne     $i16, 0, be_else.39341
be_then.39341:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.39341:
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 0], $i16
	load    [min_caml_objects + $i56], $i2
.count stack_store
	store   $i2, [$sp + 3]
	load    [$i2 + 1], $i17
	bne     $i17, 1, be_else.39342
be_then.39342:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	sub     $i55, 1, $i17
	load    [$i16 + $i17], $f18
	bne     $f18, $f0, be_else.39343
be_then.39343:
	store   $f0, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39342
be_else.39343:
	bg      $f18, $f0, ble_else.39344
ble_then.39344:
.count load_float
	load    [f.34798], $f18
	store   $f40, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39342
ble_else.39344:
.count load_float
	load    [f.34798], $f18
	store   $f18, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39342
be_else.39342:
	bne     $i17, 2, be_else.39345
be_then.39345:
	load    [$i2 + 4], $i16
	load    [$i16 + 0], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 4], $i16
	load    [$i16 + 1], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 4], $i16
	load    [$i16 + 2], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39345
be_else.39345:
	load    [$i2 + 3], $i16
	load    [$i2 + 4], $i17
	load    [$i17 + 0], $f18
	load    [min_caml_intersection_point + 0], $f19
	load    [$i2 + 5], $i17
	load    [$i17 + 0], $f20
	fsub    $f19, $f20, $f19
	fmul    $f19, $f18, $f18
	load    [$i2 + 4], $i17
	load    [$i17 + 1], $f20
	load    [min_caml_intersection_point + 1], $f21
	load    [$i2 + 5], $i17
	load    [$i17 + 1], $f22
	fsub    $f21, $f22, $f21
	fmul    $f21, $f20, $f20
	load    [$i2 + 4], $i17
	load    [$i17 + 2], $f22
	load    [min_caml_intersection_point + 2], $f23
	load    [$i2 + 5], $i17
	load    [$i17 + 2], $f24
	fsub    $f23, $f24, $f23
	fmul    $f23, $f22, $f22
	bne     $i16, 0, be_else.39346
be_then.39346:
	store   $f18, [min_caml_nvector + 0]
	store   $f20, [min_caml_nvector + 1]
	store   $f22, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39346
be_else.39346:
	load    [$i2 + 9], $i16
	load    [$i16 + 2], $f24
	fmul    $f21, $f24, $f24
	load    [$i2 + 9], $i16
	load    [$i16 + 1], $f25
	fmul    $f23, $f25, $f25
	fadd    $f24, $f25, $f24
	fmul    $f24, $f39, $f24
	fadd    $f18, $f24, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 9], $i16
	load    [$i16 + 2], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i16
	load    [$i16 + 0], $f24
	fmul    $f23, $f24, $f23
	fadd    $f18, $f23, $f18
	fmul    $f18, $f39, $f18
	fadd    $f20, $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 9], $i16
	load    [$i16 + 1], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i16
	load    [$i16 + 0], $f19
	fmul    $f21, $f19, $f19
	fadd    $f18, $f19, $f18
	fmul    $f18, $f39, $f18
	fadd    $f22, $f18, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39346:
	load    [min_caml_nvector + 0], $f18
	load    [$i2 + 6], $i16
	fmul    $f18, $f18, $f19
	load    [min_caml_nvector + 1], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	load    [min_caml_nvector + 2], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	fsqrt   $f19, $f19
	bne     $f19, $f0, be_else.39347
be_then.39347:
	mov     $f40, $f19
.count b_cont
	b       be_cont.39347
be_else.39347:
	finv    $f19, $f19
	be      $i16, 0, bne_cont.39348
bne_then.39348:
.count load_float
	load    [f.34798], $f20
	fneg    $f19, $f19
bne_cont.39348:
be_cont.39347:
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39345:
be_cont.39342:
	call    utexture.2987
	load    [$i53 + 0], $i10
	load    [$i10 + 0], $i2
	bne     $i2, -1, be_else.39349
be_then.39349:
	li      0, $i1
.count b_cont
	b       be_cont.39349
be_else.39349:
.count stack_store
	store   $i10, [$sp + 4]
	bne     $i2, 99, be_else.39350
be_then.39350:
	li      1, $i22
.count b_cont
	b       be_cont.39350
be_else.39350:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39351
be_then.39351:
	li      0, $i22
.count b_cont
	b       be_cont.39351
be_else.39351:
	bg      $f17, $f44, ble_else.39352
ble_then.39352:
	li      0, $i22
.count b_cont
	b       ble_cont.39352
ble_else.39352:
	load    [$i10 + 1], $i17
	bne     $i17, -1, be_else.39353
be_then.39353:
	li      0, $i22
.count b_cont
	b       be_cont.39353
be_else.39353:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39354
be_then.39354:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39355
be_then.39355:
	li      0, $i22
.count b_cont
	b       be_cont.39354
be_else.39355:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39356
be_then.39356:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39357
be_then.39357:
	li      0, $i22
.count b_cont
	b       be_cont.39354
be_else.39357:
	li      1, $i22
.count b_cont
	b       be_cont.39354
be_else.39356:
	li      1, $i22
.count b_cont
	b       be_cont.39354
be_else.39354:
	li      1, $i22
be_cont.39354:
be_cont.39353:
ble_cont.39352:
be_cont.39351:
be_cont.39350:
	bne     $i22, 0, be_else.39358
be_then.39358:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39358
be_else.39358:
.count stack_load
	load    [$sp + 4], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.39359
be_then.39359:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39359
be_else.39359:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39360
be_then.39360:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.39361
be_then.39361:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39360
be_else.39361:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39362
be_then.39362:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39363
be_then.39363:
	li      1, $i2
.count move_args
	mov     $i53, $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39360
be_else.39363:
	li      1, $i1
.count b_cont
	b       be_cont.39360
be_else.39362:
	li      1, $i1
.count b_cont
	b       be_cont.39360
be_else.39360:
	li      1, $i1
be_cont.39360:
be_cont.39359:
be_cont.39358:
be_cont.39349:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	bne     $i1, 0, be_else.39364
be_then.39364:
.count stack_load
	load    [$sp - 2], $i1
	load    [$i1 + 7], $i1
	load    [min_caml_nvector + 0], $f1
	fmul    $f1, $f57, $f1
	load    [min_caml_nvector + 1], $f2
	fmul    $f2, $f58, $f2
	fadd    $f1, $f2, $f1
	load    [min_caml_nvector + 2], $f2
	fmul    $f2, $f59, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	bg      $f1, $f0, ble_cont.39365
ble_then.39365:
	mov     $f0, $f1
ble_cont.39365:
.count stack_load
	load    [$sp - 4], $f2
	fmul    $f2, $f1, $f1
	load    [$i1 + 0], $f2
	fmul    $f1, $f2, $f1
	fmul    $f1, $f56, $f2
	fadd    $f45, $f2, $f2
.count move_float
	mov     $f2, $f45
	fmul    $f1, $f52, $f2
	fadd    $f46, $f2, $f2
.count move_float
	mov     $f2, $f46
	fmul    $f1, $f60, $f1
	fadd    $f47, $f1, $f1
.count move_float
	mov     $f1, $f47
	ret
be_else.39364:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.3008:
	bl      $i4, 0, bge_else.39366
bge_then.39366:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [$i2 + $i4], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
	load    [$i3 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i3 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i3 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i3, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count stack_store
	store   $i4, [$sp + 3]
	bg      $f0, $f28, ble_else.39367
ble_then.39367:
	fmul    $f28, $f43, $f2
	load    [$i2 + $i4], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.39368
bge_then.39368:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
	load    [$i26 + 0], $f28
.count stack_load
	load    [$sp + 1], $i27
	load    [$i27 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i26 + 1], $f29
	load    [$i27 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i26 + 2], $f29
	load    [$i27 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	bg      $f0, $f28, ble_else.39369
ble_then.39369:
	fmul    $f28, $f43, $f2
	load    [$i25 + $i24], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.3008
ble_else.39369:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.3008
bge_else.39368:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.39367:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	add     $i4, 1, $i24
	load    [$i2 + $i24], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.39370
bge_then.39370:
.count stack_load
	load    [$sp + 2], $i25
	load    [$i25 + $i24], $i26
	load    [$i26 + 0], $i26
	load    [$i26 + 0], $f28
.count stack_load
	load    [$sp + 1], $i27
	load    [$i27 + 0], $f30
	fmul    $f28, $f30, $f28
	load    [$i26 + 1], $f30
	load    [$i27 + 1], $f31
	fmul    $f30, $f31, $f30
	fadd    $f28, $f30, $f28
	load    [$i26 + 2], $f30
	load    [$i27 + 2], $f31
	fmul    $f30, $f31, $f30
	fadd    $f28, $f30, $f28
	bg      $f0, $f28, ble_else.39371
ble_then.39371:
	fmul    $f28, $f43, $f2
	load    [$i25 + $i24], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.3008
ble_else.39371:
	fmul    $f28, $f29, $f2
	add     $i24, 1, $i26
	load    [$i25 + $i26], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	sub     $i24, 2, $i4
.count move_args
	mov     $i25, $i2
.count move_args
	mov     $i27, $i3
	b       iter_trace_diffuse_rays.3008
bge_else.39370:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.39366:
	ret
.end iter_trace_diffuse_rays

######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.3021:
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
	load    [$i10 + 0], $f10
.count move_float
	mov     $f10, $f45
	load    [$i10 + 1], $f10
.count move_float
	mov     $f10, $f46
	load    [$i10 + 2], $f10
.count move_float
	mov     $f10, $f47
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
	be      $i11, 0, bne_cont.39372
bne_then.39372:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i11 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
	load    [$i10 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i10 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i10 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i11, [$sp + 6]
	bg      $f0, $f28, ble_else.39373
ble_then.39373:
	load    [$i11 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 3], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39373
ble_else.39373:
	load    [$i11 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 3], $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39373:
bne_cont.39372:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 1, bne_cont.39374
bne_then.39374:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 7]
	bg      $f0, $f28, ble_else.39375
ble_then.39375:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39375
ble_else.39375:
	load    [$i10 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39375:
bne_cont.39374:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 2, bne_cont.39376
bne_then.39376:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f28, ble_else.39377
ble_then.39377:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39377
ble_else.39377:
	load    [$i10 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39377:
bne_cont.39376:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 3, bne_cont.39378
bne_then.39378:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f28, ble_else.39379
ble_then.39379:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39379
ble_else.39379:
	load    [$i10 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39379:
bne_cont.39378:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 4, bne_cont.39380
bne_then.39380:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 3], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f28, ble_else.39381
ble_then.39381:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39381
ble_else.39381:
	load    [$i10 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39381:
bne_cont.39380:
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
	fmul    $f1, $f45, $f1
	fadd    $f48, $f1, $f1
.count move_float
	mov     $f1, $f48
	load    [$i1 + 1], $f1
	fmul    $f1, $f46, $f1
	fadd    $f49, $f1, $f1
.count move_float
	mov     $f1, $f49
	load    [$i1 + 2], $f1
	fmul    $f1, $f47, $f1
	fadd    $f50, $f1, $f1
.count move_float
	mov     $f1, $f50
	ret
.end calc_diffuse_using_1point

######################################################################
.begin do_without_neighbors
do_without_neighbors.3030:
	bg      $i3, 4, ble_else.39382
ble_then.39382:
	load    [$i2 + 2], $i28
	load    [$i28 + $i3], $i29
	bl      $i29, 0, bge_else.39383
bge_then.39383:
	load    [$i2 + 3], $i29
	load    [$i29 + $i3], $i30
	bne     $i30, 0, be_else.39384
be_then.39384:
	add     $i3, 1, $i3
	bg      $i3, 4, ble_else.39385
ble_then.39385:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.39386
bge_then.39386:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.39387
be_then.39387:
	add     $i3, 1, $i3
	b       do_without_neighbors.3030
be_else.39387:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	call    calc_diffuse_using_1point.3021
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 11], $i1
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 12], $i2
	b       do_without_neighbors.3030
bge_else.39386:
	ret
ble_else.39385:
	ret
be_else.39384:
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
	load    [$i10 + 0], $f10
.count move_float
	mov     $f10, $f45
	load    [$i10 + 1], $f10
.count move_float
	mov     $f10, $f46
	load    [$i10 + 2], $f10
.count move_float
	mov     $f10, $f47
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
	be      $i11, 0, bne_cont.39388
bne_then.39388:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i11 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
	load    [$i10 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i10 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i10 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i11, [$sp + 7]
	bg      $f0, $f28, ble_else.39389
ble_then.39389:
	fmul    $f28, $f43, $f2
	load    [$i11 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 4], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39389
ble_else.39389:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i11 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 4], $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39389:
bne_cont.39388:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 1, bne_cont.39390
bne_then.39390:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 8]
	bg      $f0, $f28, ble_else.39391
ble_then.39391:
	fmul    $f28, $f43, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39391
ble_else.39391:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39391:
bne_cont.39390:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 2, bne_cont.39392
bne_then.39392:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f28, ble_else.39393
ble_then.39393:
	fmul    $f28, $f43, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39393
ble_else.39393:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39393:
bne_cont.39392:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 3, bne_cont.39394
bne_then.39394:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 10]
	bg      $f0, $f28, ble_else.39395
ble_then.39395:
	fmul    $f28, $f43, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39395
ble_else.39395:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39395:
bne_cont.39394:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 4, bne_cont.39396
bne_then.39396:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i25 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i25 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i10, [$sp + 11]
	bg      $f0, $f28, ble_else.39397
ble_then.39397:
	fmul    $f28, $f43, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39397
ble_else.39397:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39397:
bne_cont.39396:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i2 + 4], $i30
.count stack_load
	load    [$sp + 3], $i31
	load    [$i30 + $i31], $i30
	load    [$i30 + 0], $f32
	fmul    $f32, $f45, $f32
	fadd    $f48, $f32, $f32
.count move_float
	mov     $f32, $f48
	load    [$i30 + 1], $f32
	fmul    $f32, $f46, $f32
	fadd    $f49, $f32, $f32
.count move_float
	mov     $f32, $f49
	load    [$i30 + 2], $f32
	fmul    $f32, $f47, $f32
	fadd    $f50, $f32, $f32
.count move_float
	mov     $f32, $f50
	add     $i31, 1, $i3
	bg      $i3, 4, ble_else.39398
ble_then.39398:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.39399
bge_then.39399:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.39400
be_then.39400:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	add     $i3, 1, $i3
	b       do_without_neighbors.3030
be_else.39400:
.count stack_store
	store   $i3, [$sp + 12]
	call    calc_diffuse_using_1point.3021
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 12], $i2
	b       do_without_neighbors.3030
bge_else.39399:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.39398:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.39383:
	ret
ble_else.39382:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.3046:
	bg      $i6, 4, ble_else.39401
ble_then.39401:
	load    [$i4 + $i2], $i32
	load    [$i32 + 2], $i33
	load    [$i33 + $i6], $i33
	bl      $i33, 0, bge_else.39402
bge_then.39402:
	load    [$i3 + $i2], $i34
	load    [$i34 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39403
be_then.39403:
	load    [$i5 + $i2], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39404
be_then.39404:
	sub     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39405
be_then.39405:
	add     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39406
be_then.39406:
	li      1, $i33
.count b_cont
	b       be_cont.39403
be_else.39406:
	li      0, $i33
.count b_cont
	b       be_cont.39403
be_else.39405:
	li      0, $i33
.count b_cont
	b       be_cont.39403
be_else.39404:
	li      0, $i33
.count b_cont
	b       be_cont.39403
be_else.39403:
	li      0, $i33
be_cont.39403:
	bne     $i33, 0, be_else.39407
be_then.39407:
	bg      $i6, 4, ble_else.39408
ble_then.39408:
	load    [$i4 + $i2], $i2
	load    [$i2 + 2], $i32
	load    [$i32 + $i6], $i32
	bl      $i32, 0, bge_else.39409
bge_then.39409:
	load    [$i2 + 3], $i32
	load    [$i32 + $i6], $i32
	bne     $i32, 0, be_else.39410
be_then.39410:
	add     $i6, 1, $i3
	b       do_without_neighbors.3030
be_else.39410:
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
	call    calc_diffuse_using_1point.3021
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
.count stack_load
	load    [$sp - 1], $i32
	add     $i32, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       do_without_neighbors.3030
bge_else.39409:
	ret
ble_else.39408:
	ret
be_else.39407:
	load    [$i32 + 3], $i1
	load    [$i1 + $i6], $i1
	bne     $i1, 0, be_else.39411
be_then.39411:
	add     $i6, 1, $i6
	b       try_exploit_neighbors.3046
be_else.39411:
	load    [$i34 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
.count move_float
	mov     $f1, $f45
	load    [$i1 + 1], $f1
.count move_float
	mov     $f1, $f46
	load    [$i1 + 2], $f1
.count move_float
	mov     $f1, $f47
	sub     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $f45, $f1, $f1
.count move_float
	mov     $f1, $f45
	load    [$i1 + 1], $f1
	fadd    $f46, $f1, $f1
.count move_float
	mov     $f1, $f46
	load    [$i1 + 2], $f1
	fadd    $f47, $f1, $f1
.count move_float
	mov     $f1, $f47
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $f45, $f1, $f1
.count move_float
	mov     $f1, $f45
	load    [$i1 + 1], $f1
	fadd    $f46, $f1, $f1
.count move_float
	mov     $f1, $f46
	load    [$i1 + 2], $f1
	fadd    $f47, $f1, $f1
.count move_float
	mov     $f1, $f47
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $f45, $f1, $f1
.count move_float
	mov     $f1, $f45
	load    [$i1 + 1], $f1
	fadd    $f46, $f1, $f1
.count move_float
	mov     $f1, $f46
	load    [$i1 + 2], $f1
	fadd    $f47, $f1, $f1
.count move_float
	mov     $f1, $f47
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fadd    $f45, $f1, $f1
.count move_float
	mov     $f1, $f45
	load    [$i1 + 1], $f1
	fadd    $f46, $f1, $f1
.count move_float
	mov     $f1, $f46
	load    [$i1 + 2], $f1
	fadd    $f47, $f1, $f1
.count move_float
	mov     $f1, $f47
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	fmul    $f1, $f45, $f1
	fadd    $f48, $f1, $f1
.count move_float
	mov     $f1, $f48
	load    [$i1 + 1], $f1
	fmul    $f1, $f46, $f1
	fadd    $f49, $f1, $f1
.count move_float
	mov     $f1, $f49
	load    [$i1 + 2], $f1
	fmul    $f1, $f47, $f1
	fadd    $f50, $f1, $f1
.count move_float
	mov     $f1, $f50
	add     $i6, 1, $i6
	b       try_exploit_neighbors.3046
bge_else.39402:
	ret
ble_else.39401:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.3059:
	bg      $i3, 4, ble_else.39412
ble_then.39412:
	load    [$i2 + 2], $i10
	load    [$i10 + $i3], $i11
	bl      $i11, 0, bge_else.39413
bge_then.39413:
	load    [$i2 + 3], $i11
	load    [$i11 + $i3], $i12
	bne     $i12, 0, be_else.39414
be_then.39414:
	add     $i3, 1, $i12
	bg      $i12, 4, ble_else.39415
ble_then.39415:
	load    [$i10 + $i12], $i10
	bl      $i10, 0, bge_else.39416
bge_then.39416:
	load    [$i11 + $i12], $i10
	bne     $i10, 0, be_else.39417
be_then.39417:
	add     $i12, 1, $i3
	b       pretrace_diffuse_rays.3059
be_else.39417:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i12, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count move_float
	mov     $f0, $f45
.count move_float
	mov     $f0, $f46
.count move_float
	mov     $f0, $f47
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i13
	load    [$i13 + $i12], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i11 + $i12], $i26
	load    [$i25 + 0], $f28
	load    [$i26 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i25 + 1], $f29
	load    [$i26 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i25 + 2], $f29
	load    [$i26 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	bg      $f0, $f28, ble_else.39418
ble_then.39418:
	fmul    $f28, $f43, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39418
ble_else.39418:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i24 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39418:
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
	store   $f45, [$i1 + 0]
	store   $f46, [$i1 + 1]
	store   $f47, [$i1 + 2]
	add     $i3, 1, $i3
	b       pretrace_diffuse_rays.3059
bge_else.39416:
	ret
ble_else.39415:
	ret
be_else.39414:
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
.count move_float
	mov     $f0, $f45
.count move_float
	mov     $f0, $f46
.count move_float
	mov     $f0, $f47
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
.count stack_store
	store   $i11, [$sp + 6]
	load    [$i2 + 1], $i12
.count stack_store
	store   $i12, [$sp + 7]
	load    [$i12 + $i3], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
	load    [$i25 + 0], $f28
.count stack_load
	load    [$sp + 5], $i26
	load    [$i11 + $i26], $i26
	load    [$i26 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i25 + 1], $f29
	load    [$i26 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i25 + 2], $f29
	load    [$i26 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	bg      $f0, $f28, ble_else.39419
ble_then.39419:
	load    [$i24 + 118], $i2
.count load_float
	load    [f.34824], $f29
	fmul    $f28, $f43, $f2
	call    trace_diffuse_ray.3005
.count b_cont
	b       ble_cont.39419
ble_else.39419:
	load    [$i24 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
ble_cont.39419:
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
.count stack_load
	load    [$sp + 2], $i2
	load    [$i2 + 5], $i10
.count stack_load
	load    [$sp + 5], $i11
	load    [$i10 + $i11], $i12
	store   $f45, [$i12 + 0]
	store   $f46, [$i12 + 1]
	store   $f47, [$i12 + 2]
	add     $i11, 1, $i11
	bg      $i11, 4, ble_else.39420
ble_then.39420:
.count stack_load
	load    [$sp + 4], $i12
	load    [$i12 + $i11], $i12
	bl      $i12, 0, bge_else.39421
bge_then.39421:
.count stack_load
	load    [$sp + 3], $i12
	load    [$i12 + $i11], $i12
	bne     $i12, 0, be_else.39422
be_then.39422:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i11, 1, $i3
	b       pretrace_diffuse_rays.3059
be_else.39422:
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
.count move_float
	mov     $f0, $f45
.count move_float
	mov     $f0, $f46
.count move_float
	mov     $f0, $f47
	load    [$i2 + 6], $i10
.count stack_load
	load    [$sp + 7], $i12
	load    [$i12 + $i11], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 0], $i24
	load    [min_caml_dirvecs + $i24], $i24
	load    [$i24 + 118], $i25
	load    [$i25 + 0], $i25
.count stack_load
	load    [$sp + 6], $i26
	load    [$i26 + $i11], $i26
	load    [$i25 + 0], $f28
	load    [$i26 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i25 + 1], $f29
	load    [$i26 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i25 + 2], $f29
	load    [$i26 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	bg      $f0, $f28, ble_else.39423
ble_then.39423:
	fmul    $f28, $f43, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39423
ble_else.39423:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i24 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39423:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $i1
.count stack_load
	load    [$sp - 1], $i2
	load    [$i2 + $i1], $i2
	store   $f45, [$i2 + 0]
	store   $f46, [$i2 + 1]
	store   $f47, [$i2 + 2]
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 8], $i2
	b       pretrace_diffuse_rays.3059
bge_else.39421:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.39420:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.39413:
	ret
ble_else.39412:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.3062:
	bl      $i3, 0, bge_else.39424
bge_then.39424:
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
	sub     $i3, $i59, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f29
	fmul    $f61, $f29, $f29
	fmul    $f29, $f10, $f30
.count stack_load
	load    [$sp + 6], $f31
	fadd    $f30, $f31, $f30
	store   $f30, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_screenx_dir + 1], $f30
	fmul    $f29, $f30, $f30
.count stack_load
	load    [$sp + 5], $f31
	fadd    $f30, $f31, $f30
	store   $f30, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f29, $f4, $f29
	store   $f29, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $f29
	fmul    $f29, $f29, $f30
	load    [min_caml_ptrace_dirvec + 1], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	load    [min_caml_ptrace_dirvec + 2], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	fsqrt   $f30, $f30
	bne     $f30, $f0, be_else.39425
be_then.39425:
	mov     $f40, $f30
.count b_cont
	b       be_cont.39425
be_else.39425:
	finv    $f30, $f30
be_cont.39425:
	fmul    $f29, $f30, $f29
	store   $f29, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [min_caml_ptrace_dirvec + 2]
.count move_float
	mov     $f0, $f48
.count move_float
	mov     $f0, $f49
.count move_float
	mov     $f0, $f50
	load    [min_caml_viewpoint + 0], $f29
	store   $f29, [min_caml_startp + 0]
	load    [min_caml_viewpoint + 1], $f29
	store   $f29, [min_caml_startp + 1]
	load    [min_caml_viewpoint + 2], $f29
	store   $f29, [min_caml_startp + 2]
	li      min_caml_ptrace_dirvec, $i3
	li      0, $i2
.count stack_load
	load    [$sp + 3], $i24
.count stack_load
	load    [$sp + 4], $i25
	load    [$i25 + $i24], $i4
.count move_args
	mov     $f40, $f2
.count move_args
	mov     $f0, $f3
	call    trace_ray.2999
	load    [$i25 + $i24], $i28
	load    [$i28 + 0], $i28
	store   $f48, [$i28 + 0]
	store   $f49, [$i28 + 1]
	store   $f50, [$i28 + 2]
	load    [$i25 + $i24], $i28
	load    [$i28 + 6], $i28
.count stack_load
	load    [$sp + 2], $i29
	store   $i29, [$i28 + 0]
	load    [$i25 + $i24], $i2
	load    [$i2 + 2], $i28
	load    [$i28 + 0], $i28
	bl      $i28, 0, bge_cont.39426
bge_then.39426:
	load    [$i2 + 3], $i28
	load    [$i28 + 0], $i28
	bne     $i28, 0, be_else.39427
be_then.39427:
	li      1, $i3
	call    pretrace_diffuse_rays.3059
.count b_cont
	b       be_cont.39427
be_else.39427:
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 6], $i10
	load    [$i10 + 0], $i10
.count move_float
	mov     $f0, $f45
.count move_float
	mov     $f0, $f46
.count move_float
	mov     $f0, $f47
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i12
	load    [min_caml_dirvecs + $i10], $i10
	load    [$i11 + 0], $i11
	load    [$i12 + 0], $i2
	load    [$i2 + 0], $f10
.count move_float
	mov     $f10, $f53
	load    [$i2 + 1], $f10
.count move_float
	mov     $f10, $f54
	load    [$i2 + 2], $f10
.count move_float
	mov     $f10, $f55
	sub     $i51, 1, $i3
	call    setup_startp_constants.2910
	load    [$i10 + 118], $i24
	load    [$i24 + 0], $i24
	load    [$i24 + 0], $f28
	load    [$i11 + 0], $f29
	fmul    $f28, $f29, $f28
	load    [$i24 + 1], $f29
	load    [$i11 + 1], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
	load    [$i24 + 2], $f29
	load    [$i11 + 2], $f30
	fmul    $f29, $f30, $f29
	fadd    $f28, $f29, $f28
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	bg      $f0, $f28, ble_else.39428
ble_then.39428:
	fmul    $f28, $f43, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39428
ble_else.39428:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 119], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.3008
ble_cont.39428:
.count stack_load
	load    [$sp + 7], $i2
	load    [$i2 + 5], $i28
	load    [$i28 + 0], $i28
	store   $f45, [$i28 + 0]
	store   $f46, [$i28 + 1]
	store   $f47, [$i28 + 2]
	li      1, $i3
	call    pretrace_diffuse_rays.3059
be_cont.39427:
bge_cont.39426:
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
	bl      $i4, 5, pretrace_pixels.3062
	sub     $i4, 5, $i4
	b       pretrace_pixels.3062
bge_else.39424:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.3073:
	bg      $i52, $i2, ble_else.39430
ble_then.39430:
	ret
ble_else.39430:
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
	load    [$i32 + 0], $f33
.count move_float
	mov     $f33, $f48
	load    [$i32 + 1], $f33
.count move_float
	mov     $f33, $f49
	load    [$i32 + 2], $f33
.count move_float
	mov     $f33, $f50
	add     $i3, 1, $i32
.count stack_store
	store   $i32, [$sp + 6]
	bg      $i54, $i32, ble_else.39431
ble_then.39431:
	li      0, $i32
.count b_cont
	b       ble_cont.39431
ble_else.39431:
	bg      $i3, 0, ble_else.39432
ble_then.39432:
	li      0, $i32
.count b_cont
	b       ble_cont.39432
ble_else.39432:
	add     $i2, 1, $i32
	bg      $i52, $i32, ble_else.39433
ble_then.39433:
	li      0, $i32
.count b_cont
	b       ble_cont.39433
ble_else.39433:
	bg      $i2, 0, ble_else.39434
ble_then.39434:
	li      0, $i32
.count b_cont
	b       ble_cont.39434
ble_else.39434:
	li      1, $i32
ble_cont.39434:
ble_cont.39433:
ble_cont.39432:
ble_cont.39431:
	bne     $i32, 0, be_else.39435
be_then.39435:
	load    [$i5 + $i2], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39435
bge_then.39436:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39437
be_then.39437:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39435
be_else.39437:
.count stack_store
	store   $i2, [$sp + 7]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.3021
	li      1, $i3
.count stack_load
	load    [$sp + 7], $i2
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39435
be_else.39435:
	li      0, $i32
	load    [$i5 + $i2], $i33
	load    [$i33 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, bge_cont.39438
bge_then.39438:
	load    [$i4 + $i2], $i35
	load    [$i35 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39439
be_then.39439:
	load    [$i6 + $i2], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39440
be_then.39440:
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39441
be_then.39441:
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39442
be_then.39442:
	li      1, $i34
.count b_cont
	b       be_cont.39439
be_else.39442:
	li      0, $i34
.count b_cont
	b       be_cont.39439
be_else.39441:
	li      0, $i34
.count b_cont
	b       be_cont.39439
be_else.39440:
	li      0, $i34
.count b_cont
	b       be_cont.39439
be_else.39439:
	li      0, $i34
be_cont.39439:
	bne     $i34, 0, be_else.39443
be_then.39443:
	load    [$i5 + $i2], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39443
bge_then.39444:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39445
be_then.39445:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39443
be_else.39445:
.count stack_store
	store   $i2, [$sp + 8]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.3021
	li      1, $i3
.count stack_load
	load    [$sp + 8], $i2
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39443
be_else.39443:
	load    [$i33 + 3], $i36
	load    [$i36 + 0], $i36
.count move_args
	mov     $i4, $i3
.count move_args
	mov     $i5, $i4
	bne     $i36, 0, be_else.39446
be_then.39446:
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.3046
.count b_cont
	b       be_cont.39446
be_else.39446:
	load    [$i35 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
.count move_float
	mov     $f33, $f45
	load    [$i36 + 1], $f33
.count move_float
	mov     $f33, $f46
	load    [$i36 + 2], $f33
.count move_float
	mov     $f33, $f47
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
	fadd    $f45, $f33, $f33
.count move_float
	mov     $f33, $f45
	load    [$i36 + 1], $f33
	fadd    $f46, $f33, $f33
.count move_float
	mov     $f33, $f46
	load    [$i36 + 2], $f33
	fadd    $f47, $f33, $f33
.count move_float
	mov     $f33, $f47
	load    [$i5 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
	fadd    $f45, $f33, $f33
.count move_float
	mov     $f33, $f45
	load    [$i36 + 1], $f33
	fadd    $f46, $f33, $f33
.count move_float
	mov     $f33, $f46
	load    [$i36 + 2], $f33
	fadd    $f47, $f33, $f33
.count move_float
	mov     $f33, $f47
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
	fadd    $f45, $f33, $f33
.count move_float
	mov     $f33, $f45
	load    [$i36 + 1], $f33
	fadd    $f46, $f33, $f33
.count move_float
	mov     $f33, $f46
	load    [$i36 + 2], $f33
	fadd    $f47, $f33, $f33
.count move_float
	mov     $f33, $f47
	load    [$i6 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
	fadd    $f45, $f33, $f33
.count move_float
	mov     $f33, $f45
	load    [$i36 + 1], $f33
	fadd    $f46, $f33, $f33
.count move_float
	mov     $f33, $f46
	load    [$i36 + 2], $f33
	fadd    $f47, $f33, $f33
.count move_float
	mov     $f33, $f47
	load    [$i5 + $i2], $i36
	load    [$i36 + 4], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f33
	fmul    $f33, $f45, $f33
	fadd    $f48, $f33, $f33
.count move_float
	mov     $f33, $f48
	load    [$i36 + 1], $f33
	fmul    $f33, $f46, $f33
	fadd    $f49, $f33, $f33
.count move_float
	mov     $f33, $f49
	load    [$i36 + 2], $f33
	fmul    $f33, $f47, $f33
	fadd    $f50, $f33, $f33
.count move_float
	mov     $f33, $f50
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.3046
be_cont.39446:
be_cont.39443:
bge_cont.39438:
be_cont.39435:
	li      255, $i10
.count move_args
	mov     $f48, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39447
ble_then.39447:
	bl      $i2, 0, bge_else.39448
bge_then.39448:
	call    min_caml_write
.count b_cont
	b       ble_cont.39447
bge_else.39448:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39447
ble_else.39447:
	li      255, $i2
	call    min_caml_write
ble_cont.39447:
	li      255, $i10
.count move_args
	mov     $f49, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39449
ble_then.39449:
	bl      $i2, 0, bge_else.39450
bge_then.39450:
	call    min_caml_write
.count b_cont
	b       ble_cont.39449
bge_else.39450:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39449
ble_else.39449:
	li      255, $i2
	call    min_caml_write
ble_cont.39449:
	li      255, $i10
.count move_args
	mov     $f50, $f2
	call    min_caml_int_of_float
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39451
ble_then.39451:
	bl      $i2, 0, bge_else.39452
bge_then.39452:
	call    min_caml_write
.count b_cont
	b       ble_cont.39451
bge_else.39452:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39451
ble_else.39451:
	li      255, $i2
	call    min_caml_write
ble_cont.39451:
.count stack_load
	load    [$sp + 5], $i32
	add     $i32, 1, $i32
	bg      $i52, $i32, ble_else.39453
ble_then.39453:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	ret
ble_else.39453:
.count stack_store
	store   $i32, [$sp + 9]
.count stack_load
	load    [$sp + 4], $i33
	load    [$i33 + $i32], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $f33
.count move_float
	mov     $f33, $f48
	load    [$i34 + 1], $f33
.count move_float
	mov     $f33, $f49
	load    [$i34 + 2], $f33
.count move_float
	mov     $f33, $f50
.count stack_load
	load    [$sp + 6], $i34
	bg      $i54, $i34, ble_else.39454
ble_then.39454:
	li      0, $i34
.count b_cont
	b       ble_cont.39454
ble_else.39454:
.count stack_load
	load    [$sp + 3], $i34
	bg      $i34, 0, ble_else.39455
ble_then.39455:
	li      0, $i34
.count b_cont
	b       ble_cont.39455
ble_else.39455:
	add     $i32, 1, $i34
	bg      $i52, $i34, ble_else.39456
ble_then.39456:
	li      0, $i34
.count b_cont
	b       ble_cont.39456
ble_else.39456:
	bg      $i32, 0, ble_else.39457
ble_then.39457:
	li      0, $i34
.count b_cont
	b       ble_cont.39457
ble_else.39457:
	li      1, $i34
ble_cont.39457:
ble_cont.39456:
ble_cont.39455:
ble_cont.39454:
	bne     $i34, 0, be_else.39458
be_then.39458:
	load    [$i33 + $i32], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39458
bge_then.39459:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39460
be_then.39460:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39458
be_else.39460:
.count stack_store
	store   $i2, [$sp + 10]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.3021
	li      1, $i3
.count stack_load
	load    [$sp + 10], $i2
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39458
be_else.39458:
	li      0, $i6
.count stack_load
	load    [$sp + 2], $i3
.count stack_load
	load    [$sp + 1], $i5
.count move_args
	mov     $i32, $i2
.count move_args
	mov     $i33, $i4
	call    try_exploit_neighbors.3046
be_cont.39458:
	li      255, $i10
.count move_args
	mov     $f48, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.39461
ble_then.39461:
	bge     $i1, 0, ble_cont.39461
bl_then.39462:
	li      0, $i1
.count b_cont
	b       ble_cont.39461
ble_else.39461:
	li      255, $i1
ble_cont.39461:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $f49, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.39463
ble_then.39463:
	bge     $i1, 0, ble_cont.39463
bl_then.39464:
	li      0, $i1
.count b_cont
	b       ble_cont.39463
ble_else.39463:
	li      255, $i1
ble_cont.39463:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $f50, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.39465
ble_then.39465:
	bge     $i1, 0, ble_cont.39465
bl_then.39466:
	li      0, $i1
.count b_cont
	b       ble_cont.39465
ble_else.39465:
	li      255, $i1
ble_cont.39465:
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
	b       scan_pixel.3073
.end scan_pixel

######################################################################
.begin scan_line
scan_line.3079:
	bg      $i54, $i2, ble_else.39467
ble_then.39467:
	ret
ble_else.39467:
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
	sub     $i54, 1, $i1
	ble     $i1, $i2, bg_cont.39468
bg_then.39468:
	add     $i2, 1, $i1
	sub     $i1, $i58, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f32
	fmul    $f61, $f32, $f32
	load    [min_caml_screeny_dir + 0], $f33
	fmul    $f32, $f33, $f33
	fadd    $f33, $f62, $f2
	load    [min_caml_screeny_dir + 1], $f33
	fmul    $f32, $f33, $f33
	fadd    $f33, $f63, $f3
	load    [min_caml_screeny_dir + 2], $f33
	fmul    $f32, $f33, $f32
	load    [min_caml_screenz_dir + 2], $f33
	fadd    $f32, $f33, $f4
	sub     $i52, 1, $i3
.count move_args
	mov     $i5, $i2
.count move_args
	mov     $i6, $i4
	call    pretrace_pixels.3062
bg_cont.39468:
	li      0, $i32
	ble     $i52, 0, bg_cont.39469
bg_then.39469:
.count stack_load
	load    [$sp + 5], $i33
	load    [$i33 + 0], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $f33
.count move_float
	mov     $f33, $f48
	load    [$i34 + 1], $f33
.count move_float
	mov     $f33, $f49
	load    [$i34 + 2], $f33
.count move_float
	mov     $f33, $f50
.count stack_load
	load    [$sp + 4], $i34
	add     $i34, 1, $i35
	bg      $i54, $i35, ble_else.39470
ble_then.39470:
	li      0, $i34
.count b_cont
	b       ble_cont.39470
ble_else.39470:
	bg      $i34, 0, ble_else.39471
ble_then.39471:
	li      0, $i34
.count b_cont
	b       ble_cont.39471
ble_else.39471:
	li      0, $i34
ble_cont.39471:
ble_cont.39470:
	bne     $i34, 0, be_else.39472
be_then.39472:
	load    [$i33 + 0], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39472
bge_then.39473:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39474
be_then.39474:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39472
be_else.39474:
.count stack_store
	store   $i2, [$sp + 6]
.count move_args
	mov     $i32, $i3
	call    calc_diffuse_using_1point.3021
	li      1, $i3
.count stack_load
	load    [$sp + 6], $i2
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39472
be_else.39472:
	li      0, $i6
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i5
.count move_args
	mov     $i32, $i2
.count move_args
	mov     $i33, $i4
	call    try_exploit_neighbors.3046
be_cont.39472:
.count move_args
	mov     $f48, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.39475
ble_then.39475:
	bge     $i1, 0, ble_cont.39475
bl_then.39476:
	li      0, $i1
.count b_cont
	b       ble_cont.39475
ble_else.39475:
	li      255, $i1
ble_cont.39475:
	mov     $i1, $i2
	call    min_caml_write
.count move_args
	mov     $f49, $f2
	call    min_caml_int_of_float
	li      255, $i10
	bg      $i1, $i10, ble_else.39477
ble_then.39477:
	bge     $i1, 0, ble_cont.39477
bl_then.39478:
	li      0, $i1
.count b_cont
	b       ble_cont.39477
ble_else.39477:
	li      255, $i1
ble_cont.39477:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
.count move_args
	mov     $f50, $f2
	call    min_caml_int_of_float
	bg      $i1, $i10, ble_else.39479
ble_then.39479:
	bge     $i1, 0, ble_cont.39479
bl_then.39480:
	li      0, $i1
.count b_cont
	b       ble_cont.39479
ble_else.39479:
	li      255, $i1
ble_cont.39479:
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
	call    scan_pixel.3073
bg_cont.39469:
.count stack_load
	load    [$sp + 4], $i1
	add     $i1, 1, $i1
	bg      $i54, $i1, ble_else.39481
ble_then.39481:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
ble_else.39481:
.count stack_store
	store   $i1, [$sp + 7]
	sub     $i54, 1, $i10
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 2, $i11
	bl      $i11, 5, bge_cont.39482
bge_then.39482:
	sub     $i11, 5, $i11
bge_cont.39482:
.count stack_store
	store   $i11, [$sp + 8]
	ble     $i10, $i1, bg_cont.39483
bg_then.39483:
	add     $i1, 1, $i1
	sub     $i52, 1, $i10
	load    [min_caml_screeny_dir + 0], $f10
	sub     $i1, $i58, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f32
	fmul    $f61, $f32, $f32
	fmul    $f32, $f10, $f33
	fadd    $f33, $f62, $f2
	load    [min_caml_screeny_dir + 1], $f33
	fmul    $f32, $f33, $f33
	fadd    $f33, $f63, $f3
	load    [min_caml_screeny_dir + 2], $f33
	fmul    $f32, $f33, $f32
	load    [min_caml_screenz_dir + 2], $f33
	fadd    $f32, $f33, $f4
.count stack_load
	load    [$sp + 3], $i2
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	call    pretrace_pixels.3062
bg_cont.39483:
	li      0, $i2
.count stack_load
	load    [$sp + 7], $i3
.count stack_load
	load    [$sp + 5], $i4
.count stack_load
	load    [$sp + 2], $i5
.count stack_load
	load    [$sp + 3], $i6
	call    scan_pixel.3073
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
	bl      $i6, 5, scan_line.3079
	sub     $i6, 5, $i6
	b       scan_line.3079
.end scan_line

######################################################################
.begin create_pixel
create_pixel.3087:
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
.begin init_line_elements
init_line_elements.3089:
	bl      $i3, 0, bge_else.39485
bge_then.39485:
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
	bl      $i19, 0, bge_else.39486
bge_then.39486:
	call    create_pixel.3087
.count move_ret
	mov     $i1, $i10
.count storer
	add     $i21, $i19, $tmp
	store   $i10, [$tmp + 0]
	sub     $i19, 1, $i10
	bl      $i10, 0, bge_else.39487
bge_then.39487:
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
	bl      $i19, 0, bge_else.39488
bge_then.39488:
	call    create_pixel.3087
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
	b       init_line_elements.3089
bge_else.39488:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39487:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39486:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39485:
	mov     $i2, $i1
	ret
.end init_line_elements

######################################################################
.begin cordic_rec
cordic_rec.6377.12642:
	bne     $i2, 25, be_else.39489
be_then.39489:
	mov     $f4, $f1
	ret
be_else.39489:
	add     $i2, 1, $i1
	load    [min_caml_atan_table + $i2], $f1
	bg      $f3, $f0, ble_else.39490
ble_then.39490:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39491
be_then.39491:
	ret
be_else.39491:
	fmul    $f5, $f3, $f4
	fsub    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f39, $f3
	add     $i1, 1, $i2
	fmul    $f3, $f2, $f5
	bg      $f2, $f0, ble_else.39492
ble_then.39492:
	fsub    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12642
ble_else.39492:
	fadd    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12642
ble_else.39490:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39493
be_then.39493:
	ret
be_else.39493:
	fmul    $f5, $f3, $f4
	fadd    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f39, $f3
	add     $i1, 1, $i2
	fmul    $f3, $f2, $f5
	bg      $f2, $f0, ble_else.39494
ble_then.39494:
	fsub    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12642
ble_else.39494:
	fadd    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12642
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6377.12539:
	bne     $i2, 25, be_else.39495
be_then.39495:
	mov     $f4, $f1
	ret
be_else.39495:
	add     $i2, 1, $i1
	load    [min_caml_atan_table + $i2], $f1
	bg      $f3, $f0, ble_else.39496
ble_then.39496:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39497
be_then.39497:
	ret
be_else.39497:
	fmul    $f5, $f3, $f4
	fsub    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f39, $f3
	add     $i1, 1, $i2
	fmul    $f3, $f2, $f5
	bg      $f2, $f0, ble_else.39498
ble_then.39498:
	fsub    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12539
ble_else.39498:
	fadd    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12539
ble_else.39496:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39499
be_then.39499:
	ret
be_else.39499:
	fmul    $f5, $f3, $f4
	fadd    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f39, $f3
	add     $i1, 1, $i2
	fmul    $f3, $f2, $f5
	bg      $f2, $f0, ble_else.39500
ble_then.39500:
	fsub    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12539
ble_else.39500:
	fadd    $f4, $f5, $f5
	fmul    $f3, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f3, $f39, $f1
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f5, $f2
.count move_args
	mov     $f1, $f5
	b       cordic_rec.6377.12539
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20863:
	bne     $i2, 25, be_else.39501
be_then.39501:
	mov     $f4, $f1
	ret
be_else.39501:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39502
ble_then.39502:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39503
be_then.39503:
	ret
be_else.39503:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39504
ble_then.39504:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20863
ble_else.39504:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20863
ble_else.39502:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39505
be_then.39505:
	ret
be_else.39505:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39506
ble_then.39506:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20863
ble_else.39506:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20863
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20945:
	bne     $i2, 25, be_else.39507
be_then.39507:
	mov     $f4, $f1
	ret
be_else.39507:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39508
ble_then.39508:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39509
be_then.39509:
	ret
be_else.39509:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39510
ble_then.39510:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20945
ble_else.39510:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20945
ble_else.39508:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39511
be_then.39511:
	ret
be_else.39511:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39512
ble_then.39512:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20945
ble_else.39512:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.20945
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.21027:
	bne     $i2, 25, be_else.39513
be_then.39513:
	mov     $f4, $f1
	ret
be_else.39513:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39514
ble_then.39514:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39515
be_then.39515:
	ret
be_else.39515:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39516
ble_then.39516:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21027
ble_else.39516:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21027
ble_else.39514:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39517
be_then.39517:
	ret
be_else.39517:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39518
ble_then.39518:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21027
ble_else.39518:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21027
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.21109:
	bne     $i2, 25, be_else.39519
be_then.39519:
	mov     $f4, $f1
	ret
be_else.39519:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39520
ble_then.39520:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39521
be_then.39521:
	ret
be_else.39521:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39522
ble_then.39522:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21109
ble_else.39522:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21109
ble_else.39520:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39523
be_then.39523:
	ret
be_else.39523:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
	fmul    $f6, $f39, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f1, $f6
	bg      $f2, $f4, ble_else.39524
ble_then.39524:
	fadd    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21109
ble_else.39524:
	fsub    $f3, $f6, $f6
	fmul    $f5, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f5, $f39, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f6, $f3
.count move_args
	mov     $f4, $f6
.count move_args
	mov     $f1, $f4
	b       cordic_rec.6342.21109
.end cordic_rec

######################################################################
.begin calc_dirvec
calc_dirvec.3099:
	bl      $i2, 5, bge_else.39525
bge_then.39525:
	load    [min_caml_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f2, $f2, $f1
	fmul    $f3, $f3, $f4
	fadd    $f1, $f4, $f1
	fadd    $f1, $f40, $f1
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
bge_else.39525:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $f5, [$sp + 2]
.count stack_store
	store   $f4, [$sp + 3]
	fmul    $f3, $f3, $f10
.count load_float
	load    [f.34811], $f11
.count stack_store
	store   $f11, [$sp + 4]
	fadd    $f10, $f11, $f10
	fsqrt   $f10, $f10
.count stack_store
	store   $f10, [$sp + 5]
	finv    $f10, $f10
.count move_args
	mov     $f39, $f5
	li      1, $i2
	bg      $f10, $f0, ble_else.39526
ble_then.39526:
	fsub    $f40, $f10, $f2
	fadd    $f10, $f40, $f3
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f4
	call    cordic_rec.6377.12642
.count move_ret
	mov     $f1, $f14
.count b_cont
	b       ble_cont.39526
ble_else.39526:
	fadd    $f40, $f10, $f2
	fsub    $f10, $f40, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.12642
.count move_ret
	mov     $f1, $f14
ble_cont.39526:
.count stack_load
	load    [$sp + 3], $f15
	fmul    $f14, $f15, $f14
	bg      $f0, $f14, ble_else.39527
ble_then.39527:
.count load_float
	load    [f.34777], $f16
	bg      $f16, $f14, ble_else.39528
ble_then.39528:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.39529
ble_then.39529:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.39530
ble_then.39530:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39530:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39529:
	fsub    $f16, $f14, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.39531
ble_then.39531:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.21109
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39531:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.21109
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39528:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f14, $f2
	li      1, $i2
	bg      $f14, $f0, ble_else.39532
ble_then.39532:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.21027
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39532:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.21027
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39527
ble_else.39527:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
ble_cont.39527:
.count load_float
	load    [f.34777], $f17
	fsub    $f17, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f10
	finv    $f10, $f10
	fmul    $f16, $f10, $f10
.count stack_load
	load    [$sp + 5], $f11
	fmul    $f10, $f11, $f10
.count stack_store
	store   $f10, [$sp + 6]
	fmul    $f10, $f10, $f10
.count stack_load
	load    [$sp + 4], $f11
	fadd    $f10, $f11, $f10
	fsqrt   $f10, $f10
.count stack_store
	store   $f10, [$sp + 7]
	finv    $f10, $f10
.count move_args
	mov     $f39, $f5
	li      1, $i2
	bg      $f10, $f0, ble_else.39533
ble_then.39533:
	fsub    $f40, $f10, $f2
	fadd    $f10, $f40, $f3
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f4
	call    cordic_rec.6377.12539
.count move_ret
	mov     $f1, $f14
.count b_cont
	b       ble_cont.39533
ble_else.39533:
	fadd    $f40, $f10, $f2
	fsub    $f10, $f40, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.12539
.count move_ret
	mov     $f1, $f14
ble_cont.39533:
.count stack_load
	load    [$sp + 2], $f16
	fmul    $f14, $f16, $f14
	bg      $f0, $f14, ble_else.39534
ble_then.39534:
	bg      $f17, $f14, ble_else.39535
ble_then.39535:
.count load_float
	load    [f.34780], $f18
	bg      $f18, $f14, ble_else.39536
ble_then.39536:
.count load_float
	load    [f.34781], $f18
	bg      $f18, $f14, ble_else.39537
ble_then.39537:
	fsub    $f14, $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39537:
	fsub    $f18, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39536:
	fsub    $f18, $f14, $f2
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
	li      1, $i2
	bg      $f2, $f0, ble_else.39538
ble_then.39538:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.20945
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39538:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.20945
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39535:
.count move_args
	mov     $f39, $f6
.count move_args
	mov     $f41, $f3
.count move_args
	mov     $f14, $f2
	li      1, $i2
	bg      $f14, $f0, ble_else.39539
ble_then.39539:
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
.count move_args
	mov     $f42, $f4
	call    cordic_rec.6342.20863
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39539:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f41, $f4
	call    cordic_rec.6342.20863
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39534
ble_else.39534:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
ble_cont.39534:
	fsub    $f17, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	finv    $f1, $f1
	fmul    $f18, $f1, $f1
.count stack_load
	load    [$sp - 1], $f2
	fmul    $f1, $f2, $f3
.count stack_load
	load    [$sp - 7], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 2], $f2
.count move_args
	mov     $f15, $f4
.count move_args
	mov     $f16, $f5
	b       calc_dirvec.3099
.end calc_dirvec

######################################################################
.begin calc_dirvecs
calc_dirvecs.3107:
	bl      $i2, 0, bge_else.39540
bge_then.39540:
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
	mov     $f1, $f19
.count load_float
	load    [f.34852], $f20
	fmul    $f19, $f20, $f19
.count load_float
	load    [f.34853], $f21
	fsub    $f19, $f21, $f4
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
	call    calc_dirvec.3099
	li      0, $i2
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 5]
.count load_float
	load    [f.34811], $f22
	fadd    $f19, $f22, $f4
.count stack_load
	load    [$sp + 4], $f5
.count stack_load
	load    [$sp + 3], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3099
.count stack_load
	load    [$sp + 1], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.39541
bge_then.39541:
.count stack_store
	store   $i2, [$sp + 6]
	li      0, $i1
.count stack_load
	load    [$sp + 3], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39542
bge_then.39542:
	sub     $i11, 5, $i11
bge_cont.39542:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f19
	fmul    $f19, $f20, $f19
	fsub    $f19, $f21, $f4
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
	call    calc_dirvec.3099
	li      0, $i2
	fadd    $f19, $f22, $f4
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
	call    calc_dirvec.3099
.count stack_load
	load    [$sp + 6], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.39543
bge_then.39543:
.count stack_store
	store   $i2, [$sp + 7]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39544
bge_then.39544:
	sub     $i11, 5, $i11
bge_cont.39544:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f19
	fmul    $f19, $f20, $f19
	fsub    $f19, $f21, $f4
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
	call    calc_dirvec.3099
	li      0, $i2
	fadd    $f19, $f22, $f4
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
	call    calc_dirvec.3099
.count stack_load
	load    [$sp + 7], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.39545
bge_then.39545:
.count stack_store
	store   $i2, [$sp + 8]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39546
bge_then.39546:
	sub     $i11, 5, $i11
bge_cont.39546:
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f19
	fmul    $f19, $f20, $f19
	fsub    $f19, $f21, $f4
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
	call    calc_dirvec.3099
	li      0, $i2
	fadd    $f19, $f22, $f4
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
	call    calc_dirvec.3099
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
	bl      $i3, 5, calc_dirvecs.3107
	sub     $i3, 5, $i3
	b       calc_dirvecs.3107
bge_else.39545:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39543:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39541:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39540:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3112:
	bl      $i2, 0, bge_else.39548
bge_then.39548:
.count stack_move
	sub     $sp, 19, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i4, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
.count stack_store
	store   $i2, [$sp + 3]
	li      0, $i1
.count load_float
	load    [f.34853], $f10
.count stack_store
	store   $f10, [$sp + 4]
.count load_float
	load    [f.34852], $f11
.count stack_store
	store   $f11, [$sp + 5]
	li      4, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f12
	fmul    $f12, $f11, $f12
.count stack_store
	store   $f12, [$sp + 6]
	fsub    $f12, $f10, $f12
.count stack_store
	store   $f12, [$sp + 7]
.count stack_load
	load    [$sp + 3], $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f19
	fmul    $f19, $f11, $f19
	fsub    $f19, $f10, $f5
.count stack_store
	store   $f5, [$sp + 8]
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
	mov     $f12, $f4
	call    calc_dirvec.3099
	li      0, $i2
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 9]
.count load_float
	load    [f.34811], $f19
.count stack_load
	load    [$sp + 6], $f20
	fadd    $f20, $f19, $f4
.count stack_store
	store   $f4, [$sp + 10]
.count stack_load
	load    [$sp + 8], $f5
.count stack_load
	load    [$sp + 2], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3099
	li      0, $i1
.count stack_load
	load    [$sp + 2], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39549
bge_then.39549:
	sub     $i11, 5, $i11
bge_cont.39549:
	li      3, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f20
.count stack_load
	load    [$sp + 5], $f21
	fmul    $f20, $f21, $f20
.count stack_load
	load    [$sp + 4], $f22
	fsub    $f20, $f22, $f4
.count stack_store
	store   $f4, [$sp + 11]
.count stack_load
	load    [$sp + 8], $f5
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
	call    calc_dirvec.3099
	li      0, $i2
	fadd    $f20, $f19, $f4
.count stack_store
	store   $f4, [$sp + 12]
.count stack_load
	load    [$sp + 8], $f5
.count stack_load
	load    [$sp + 9], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3099
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39550
bge_then.39550:
	sub     $i11, 5, $i11
bge_cont.39550:
	li      2, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f20
	fmul    $f20, $f21, $f20
	fsub    $f20, $f22, $f4
.count stack_load
	load    [$sp + 8], $f5
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
	call    calc_dirvec.3099
	li      0, $i2
	fadd    $f20, $f19, $f4
.count stack_load
	load    [$sp + 8], $f5
.count stack_load
	load    [$sp + 9], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i11, $i3
	call    calc_dirvec.3099
	li      1, $i2
	add     $i11, 1, $i12
	bl      $i12, 5, bge_cont.39551
bge_then.39551:
	sub     $i12, 5, $i12
bge_cont.39551:
	mov     $i12, $i3
.count stack_load
	load    [$sp + 8], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3107
.count stack_load
	load    [$sp + 3], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.39552
bge_then.39552:
.count stack_store
	store   $i2, [$sp + 13]
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.39553
bge_then.39553:
	sub     $i1, 5, $i1
bge_cont.39553:
.count stack_store
	store   $i1, [$sp + 14]
.count stack_load
	load    [$sp + 1], $i10
	add     $i10, 4, $i10
.count stack_store
	store   $i10, [$sp + 15]
	li      0, $i11
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f19
.count stack_load
	load    [$sp + 5], $f20
	fmul    $f19, $f20, $f19
.count stack_load
	load    [$sp + 4], $f20
	fsub    $f19, $f20, $f5
.count stack_store
	store   $f5, [$sp + 16]
.count stack_load
	load    [$sp + 7], $f4
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
	call    calc_dirvec.3099
	li      0, $i2
	add     $i10, 2, $i4
.count stack_store
	store   $i4, [$sp + 17]
.count stack_load
	load    [$sp + 10], $f4
.count stack_load
	load    [$sp + 16], $f5
.count stack_load
	load    [$sp + 14], $i3
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3099
	li      0, $i2
.count stack_load
	load    [$sp + 14], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39554
bge_then.39554:
	sub     $i11, 5, $i11
bge_cont.39554:
	mov     $i11, $i3
.count stack_store
	store   $i3, [$sp + 18]
.count stack_load
	load    [$sp + 11], $f4
.count stack_load
	load    [$sp + 16], $f5
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
.count move_args
	mov     $i10, $i4
	call    calc_dirvec.3099
	li      0, $i2
.count stack_load
	load    [$sp + 12], $f4
.count stack_load
	load    [$sp + 16], $f5
.count stack_load
	load    [$sp + 18], $i3
.count stack_load
	load    [$sp + 17], $i4
.count move_args
	mov     $f0, $f2
.count move_args
	mov     $f0, $f3
	call    calc_dirvec.3099
	li      2, $i2
.count stack_load
	load    [$sp + 18], $i12
	add     $i12, 1, $i12
	bl      $i12, 5, bge_cont.39555
bge_then.39555:
	sub     $i12, 5, $i12
bge_cont.39555:
	mov     $i12, $i3
.count stack_load
	load    [$sp + 16], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3107
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 19, $sp
.count stack_load
	load    [$sp - 6], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i1
	add     $i1, 2, $i3
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 4, $i4
	bl      $i3, 5, calc_dirvec_rows.3112
	sub     $i3, 5, $i3
	b       calc_dirvec_rows.3112
bge_else.39552:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 19, $sp
	ret
bge_else.39548:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3118:
	bl      $i3, 0, bge_else.39557
bge_then.39557:
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i11
	add     $hp, 2, $hp
	store   $i10, [$i11 + 1]
.count stack_load
	load    [$sp + 3], $i10
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count stack_load
	load    [$sp + 1], $i11
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i12, $i11, $tmp
	store   $i10, [$tmp + 0]
	sub     $i11, 1, $i10
	bl      $i10, 0, bge_else.39558
bge_then.39558:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i13
	add     $hp, 2, $hp
	store   $i11, [$i13 + 1]
.count stack_load
	load    [$sp + 4], $i11
	store   $i11, [$i13 + 0]
	mov     $i13, $i11
.count storer
	add     $i12, $i10, $tmp
	store   $i11, [$tmp + 0]
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39559
bge_then.39559:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	mov     $hp, $i13
	add     $hp, 2, $hp
	store   $i11, [$i13 + 1]
.count stack_load
	load    [$sp + 5], $i11
	store   $i11, [$i13 + 0]
	mov     $i13, $i11
.count storer
	add     $i12, $i10, $tmp
	store   $i11, [$tmp + 0]
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39560
bge_then.39560:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 6]
.count move_args
	mov     $i51, $i2
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
	mov     $i2, $i1
.count storer
	add     $i12, $i10, $tmp
	store   $i1, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i12, $i2
	b       create_dirvec_elements.3118
bge_else.39560:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39559:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39558:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39557:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3121:
	bl      $i2, 0, bge_else.39561
bge_then.39561:
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	li      120, $i2
	mov     $hp, $i11
	add     $hp, 2, $hp
	store   $i10, [$i11 + 1]
.count stack_load
	load    [$sp + 2], $i10
	store   $i10, [$i11 + 0]
	mov     $i11, $i3
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
	mov     $i51, $i2
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
	mov     $i12, $i10
	store   $i10, [$i11 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i10, [$i12 + 1]
.count stack_load
	load    [$sp + 4], $i10
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
	store   $i10, [$i11 + 117]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	mov     $hp, $i15
	add     $hp, 2, $hp
	store   $i14, [$i15 + 1]
.count stack_load
	load    [$sp + 5], $i14
	store   $i14, [$i15 + 0]
	mov     $i15, $i14
	store   $i14, [$i11 + 116]
	li      115, $i3
.count move_args
	mov     $i11, $i2
	call    create_dirvec_elements.3118
.count stack_load
	load    [$sp + 1], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39562
bge_then.39562:
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	li      120, $i2
	mov     $hp, $i12
	add     $hp, 2, $hp
	store   $i11, [$i12 + 1]
.count stack_load
	load    [$sp + 7], $i11
	store   $i11, [$i12 + 0]
	mov     $i12, $i3
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
	mov     $i51, $i2
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
	mov     $i12, $i11
	store   $i11, [$i10 + 118]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	mov     $hp, $i15
	add     $hp, 2, $hp
	store   $i14, [$i15 + 1]
.count stack_load
	load    [$sp + 9], $i14
	store   $i14, [$i15 + 0]
	mov     $i15, $i14
	store   $i14, [$i10 + 117]
	li      116, $i3
.count move_args
	mov     $i10, $i2
	call    create_dirvec_elements.3118
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
	b       create_dirvecs.3121
bge_else.39562:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.39561:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3123:
	bl      $i3, 0, bge_else.39563
bge_then.39563:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	sub     $i51, 1, $i10
	load    [$i2 + $i3], $i11
	bl      $i10, 0, bge_cont.39564
bge_then.39564:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39565
be_then.39565:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39566
be_then.39566:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39566
be_else.39566:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39567
ble_then.39567:
	li      0, $i18
.count b_cont
	b       ble_cont.39567
ble_else.39567:
	li      1, $i18
ble_cont.39567:
	bne     $i17, 0, be_else.39568
be_then.39568:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39568
be_else.39568:
	bne     $i18, 0, be_else.39569
be_then.39569:
	li      1, $i17
.count b_cont
	b       be_cont.39569
be_else.39569:
	li      0, $i17
be_cont.39569:
be_cont.39568:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39570
be_then.39570:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39570
be_else.39570:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39570:
be_cont.39566:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39571
be_then.39571:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39571
be_else.39571:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39572
ble_then.39572:
	li      0, $i18
.count b_cont
	b       ble_cont.39572
ble_else.39572:
	li      1, $i18
ble_cont.39572:
	bne     $i17, 0, be_else.39573
be_then.39573:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39573
be_else.39573:
	bne     $i18, 0, be_else.39574
be_then.39574:
	li      1, $i17
.count b_cont
	b       be_cont.39574
be_else.39574:
	li      0, $i17
be_cont.39574:
be_cont.39573:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39575
be_then.39575:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39575
be_else.39575:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39575:
be_cont.39571:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39576
be_then.39576:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39565
be_else.39576:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39577
ble_then.39577:
	li      0, $i18
.count b_cont
	b       ble_cont.39577
ble_else.39577:
	li      1, $i18
ble_cont.39577:
	bne     $i17, 0, be_else.39578
be_then.39578:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39578
be_else.39578:
	bne     $i18, 0, be_else.39579
be_then.39579:
	li      1, $i17
.count b_cont
	b       be_cont.39579
be_else.39579:
	li      0, $i17
be_cont.39579:
be_cont.39578:
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f10
	bne     $i17, 0, be_cont.39580
be_then.39580:
	fneg    $f10, $f10
be_cont.39580:
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
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39565
be_else.39565:
	bne     $i14, 2, be_else.39581
be_then.39581:
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
	bg      $f10, $f0, ble_else.39582
ble_then.39582:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39581
ble_else.39582:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39581
be_else.39581:
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
	bne     $i17, 0, be_else.39583
be_then.39583:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39583
be_else.39583:
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
be_cont.39583:
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
	bne     $i17, 0, be_else.39584
be_then.39584:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39585
be_then.39585:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39584
be_else.39585:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39584
be_else.39584:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39586
be_then.39586:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39586
be_else.39586:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39586:
be_cont.39584:
be_cont.39581:
be_cont.39565:
bge_cont.39564:
.count stack_load
	load    [$sp + 2], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39587
bge_then.39587:
.count stack_store
	store   $i10, [$sp + 3]
	sub     $i51, 1, $i11
.count stack_load
	load    [$sp + 1], $i12
	load    [$i12 + $i10], $i10
	bl      $i11, 0, bge_cont.39588
bge_then.39588:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39589
be_then.39589:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39590
be_then.39590:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39590
be_else.39590:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39591
ble_then.39591:
	li      0, $i18
.count b_cont
	b       ble_cont.39591
ble_else.39591:
	li      1, $i18
ble_cont.39591:
	bne     $i17, 0, be_else.39592
be_then.39592:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39592
be_else.39592:
	bne     $i18, 0, be_else.39593
be_then.39593:
	li      1, $i17
.count b_cont
	b       be_cont.39593
be_else.39593:
	li      0, $i17
be_cont.39593:
be_cont.39592:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39594
be_then.39594:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39594
be_else.39594:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39594:
be_cont.39590:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39595
be_then.39595:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39595
be_else.39595:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39596
ble_then.39596:
	li      0, $i18
.count b_cont
	b       ble_cont.39596
ble_else.39596:
	li      1, $i18
ble_cont.39596:
	bne     $i17, 0, be_else.39597
be_then.39597:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39597
be_else.39597:
	bne     $i18, 0, be_else.39598
be_then.39598:
	li      1, $i17
.count b_cont
	b       be_cont.39598
be_else.39598:
	li      0, $i17
be_cont.39598:
be_cont.39597:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39599
be_then.39599:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39599
be_else.39599:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39599:
be_cont.39595:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39600
be_then.39600:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39589
be_else.39600:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39601
ble_then.39601:
	li      0, $i19
.count b_cont
	b       ble_cont.39601
ble_else.39601:
	li      1, $i19
ble_cont.39601:
	bne     $i17, 0, be_else.39602
be_then.39602:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39602
be_else.39602:
	bne     $i19, 0, be_else.39603
be_then.39603:
	li      1, $i17
.count b_cont
	b       be_cont.39603
be_else.39603:
	li      0, $i17
be_cont.39603:
be_cont.39602:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.39604
be_then.39604:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39589
be_else.39604:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39589
be_else.39589:
	bne     $i14, 2, be_else.39605
be_then.39605:
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
	bg      $f10, $f0, ble_else.39606
ble_then.39606:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39605
ble_else.39606:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39605
be_else.39605:
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
	bne     $i17, 0, be_else.39607
be_then.39607:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39607
be_else.39607:
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
be_cont.39607:
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
	bne     $i17, 0, be_else.39608
be_then.39608:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39609
be_then.39609:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39608
be_else.39609:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39608
be_else.39608:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39610
be_then.39610:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39610
be_else.39610:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39610:
be_cont.39608:
be_cont.39605:
be_cont.39589:
bge_cont.39588:
.count stack_load
	load    [$sp + 3], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.39611
bge_then.39611:
	sub     $i51, 1, $i3
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + $i16], $i2
	call    iter_setup_dirvec_constants.2905
	sub     $i16, 1, $i10
	bl      $i10, 0, bge_else.39612
bge_then.39612:
	sub     $i51, 1, $i11
	bl      $i11, 0, bge_else.39613
bge_then.39613:
	load    [$i17 + $i10], $i12
	load    [$i12 + 1], $i13
	load    [min_caml_objects + $i11], $i14
	load    [$i14 + 1], $i15
	load    [$i12 + 0], $i16
.count stack_store
	store   $i10, [$sp + 4]
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.39614
be_then.39614:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i16 + 0], $f10
	bne     $f10, $f0, be_else.39615
be_then.39615:
	store   $f0, [$i18 + 1]
.count b_cont
	b       be_cont.39615
be_else.39615:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.39616
ble_then.39616:
	li      0, $i20
.count b_cont
	b       ble_cont.39616
ble_else.39616:
	li      1, $i20
ble_cont.39616:
	bne     $i19, 0, be_else.39617
be_then.39617:
	mov     $i20, $i19
.count b_cont
	b       be_cont.39617
be_else.39617:
	bne     $i20, 0, be_else.39618
be_then.39618:
	li      1, $i19
.count b_cont
	b       be_cont.39618
be_else.39618:
	li      0, $i19
be_cont.39618:
be_cont.39617:
	load    [$i14 + 4], $i20
	load    [$i20 + 0], $f10
	bne     $i19, 0, be_else.39619
be_then.39619:
	fneg    $f10, $f10
	store   $f10, [$i18 + 0]
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
.count b_cont
	b       be_cont.39619
be_else.39619:
	store   $f10, [$i18 + 0]
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
be_cont.39619:
be_cont.39615:
	load    [$i16 + 1], $f10
	bne     $f10, $f0, be_else.39620
be_then.39620:
	store   $f0, [$i18 + 3]
.count b_cont
	b       be_cont.39620
be_else.39620:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.39621
ble_then.39621:
	li      0, $i20
.count b_cont
	b       ble_cont.39621
ble_else.39621:
	li      1, $i20
ble_cont.39621:
	bne     $i19, 0, be_else.39622
be_then.39622:
	mov     $i20, $i19
.count b_cont
	b       be_cont.39622
be_else.39622:
	bne     $i20, 0, be_else.39623
be_then.39623:
	li      1, $i19
.count b_cont
	b       be_cont.39623
be_else.39623:
	li      0, $i19
be_cont.39623:
be_cont.39622:
	load    [$i14 + 4], $i20
	load    [$i20 + 1], $f10
	bne     $i19, 0, be_else.39624
be_then.39624:
	fneg    $f10, $f10
	store   $f10, [$i18 + 2]
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
.count b_cont
	b       be_cont.39624
be_else.39624:
	store   $f10, [$i18 + 2]
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
be_cont.39624:
be_cont.39620:
	load    [$i16 + 2], $f10
	bne     $f10, $f0, be_else.39625
be_then.39625:
	store   $f0, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.39625
be_else.39625:
	load    [$i14 + 6], $i19
	load    [$i14 + 4], $i20
	bg      $f0, $f10, ble_else.39626
ble_then.39626:
	li      0, $i21
.count b_cont
	b       ble_cont.39626
ble_else.39626:
	li      1, $i21
ble_cont.39626:
	bne     $i19, 0, be_else.39627
be_then.39627:
	mov     $i21, $i19
.count b_cont
	b       be_cont.39627
be_else.39627:
	bne     $i21, 0, be_else.39628
be_then.39628:
	li      1, $i19
.count b_cont
	b       be_cont.39628
be_else.39628:
	li      0, $i19
be_cont.39628:
be_cont.39627:
	load    [$i20 + 2], $f10
	bne     $i19, 0, be_else.39629
be_then.39629:
	fneg    $f10, $f10
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.39629
be_else.39629:
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
be_cont.39629:
be_cont.39625:
.count storer
	add     $i13, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i12, $i2
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3123
be_else.39614:
	bne     $i15, 2, be_else.39630
be_then.39630:
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
	bg      $f10, $f0, ble_else.39631
ble_then.39631:
	store   $f0, [$i18 + 0]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39630
ble_else.39631:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i18 + 0]
	load    [$i14 + 4], $i16
	load    [$i16 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i18 + 1]
	load    [$i14 + 4], $i16
	load    [$i16 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i18 + 2]
	load    [$i14 + 4], $i16
	load    [$i16 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i18 + 3]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39630
be_else.39630:
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
	bne     $i19, 0, be_else.39632
be_then.39632:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39632
be_else.39632:
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
be_cont.39632:
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
	bne     $i19, 0, be_else.39633
be_then.39633:
	store   $f11, [$i18 + 1]
	store   $f13, [$i18 + 2]
	store   $f15, [$i18 + 3]
	bne     $f10, $f0, be_else.39634
be_then.39634:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39633
be_else.39634:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39633
be_else.39633:
	load    [$i14 + 9], $i19
	load    [$i14 + 9], $i20
	load    [$i19 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i20 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i18 + 1]
	load    [$i14 + 9], $i19
	load    [$i16 + 2], $f11
	load    [$i19 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i18 + 2]
	load    [$i16 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i18 + 3]
	bne     $f10, $f0, be_else.39635
be_then.39635:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39635
be_else.39635:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
be_cont.39635:
be_cont.39633:
be_cont.39630:
	sub     $i11, 1, $i3
.count move_args
	mov     $i12, $i2
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $i1
	sub     $i1, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3123
bge_else.39613:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	sub     $i10, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3123
bge_else.39612:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39611:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39587:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39563:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3126:
	bl      $i2, 0, bge_else.39636
bge_then.39636:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	sub     $i51, 1, $i10
	load    [min_caml_dirvecs + $i2], $i11
.count stack_store
	store   $i11, [$sp + 2]
	load    [$i11 + 119], $i11
	bl      $i10, 0, bge_cont.39637
bge_then.39637:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39638
be_then.39638:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39639
be_then.39639:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39639
be_else.39639:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39640
ble_then.39640:
	li      0, $i18
.count b_cont
	b       ble_cont.39640
ble_else.39640:
	li      1, $i18
ble_cont.39640:
	bne     $i17, 0, be_else.39641
be_then.39641:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39641
be_else.39641:
	bne     $i18, 0, be_else.39642
be_then.39642:
	li      1, $i17
.count b_cont
	b       be_cont.39642
be_else.39642:
	li      0, $i17
be_cont.39642:
be_cont.39641:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39643
be_then.39643:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39643
be_else.39643:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39643:
be_cont.39639:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39644
be_then.39644:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39644
be_else.39644:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39645
ble_then.39645:
	li      0, $i18
.count b_cont
	b       ble_cont.39645
ble_else.39645:
	li      1, $i18
ble_cont.39645:
	bne     $i17, 0, be_else.39646
be_then.39646:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39646
be_else.39646:
	bne     $i18, 0, be_else.39647
be_then.39647:
	li      1, $i17
.count b_cont
	b       be_cont.39647
be_else.39647:
	li      0, $i17
be_cont.39647:
be_cont.39646:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39648
be_then.39648:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39648
be_else.39648:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39648:
be_cont.39644:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39649
be_then.39649:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39638
be_else.39649:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39650
ble_then.39650:
	li      0, $i19
.count b_cont
	b       ble_cont.39650
ble_else.39650:
	li      1, $i19
ble_cont.39650:
	bne     $i17, 0, be_else.39651
be_then.39651:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39651
be_else.39651:
	bne     $i19, 0, be_else.39652
be_then.39652:
	li      1, $i17
.count b_cont
	b       be_cont.39652
be_else.39652:
	li      0, $i17
be_cont.39652:
be_cont.39651:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i17, 0, be_else.39653
be_then.39653:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39638
be_else.39653:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39638
be_else.39638:
	bne     $i14, 2, be_else.39654
be_then.39654:
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
	bg      $f10, $f0, ble_else.39655
ble_then.39655:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39654
ble_else.39655:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39654
be_else.39654:
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
	bne     $i17, 0, be_else.39656
be_then.39656:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39656
be_else.39656:
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
be_cont.39656:
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
	bne     $i17, 0, be_else.39657
be_then.39657:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39658
be_then.39658:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39657
be_else.39658:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39657
be_else.39657:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39659
be_then.39659:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39659
be_else.39659:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39659:
be_cont.39657:
be_cont.39654:
be_cont.39638:
bge_cont.39637:
	sub     $i51, 1, $i3
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 118], $i2
	call    iter_setup_dirvec_constants.2905
	sub     $i51, 1, $i10
	load    [$i16 + 117], $i11
	bl      $i10, 0, bge_cont.39660
bge_then.39660:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39661
be_then.39661:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39662
be_then.39662:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.39662
be_else.39662:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39663
ble_then.39663:
	li      0, $i19
.count b_cont
	b       ble_cont.39663
ble_else.39663:
	li      1, $i19
ble_cont.39663:
	bne     $i18, 0, be_else.39664
be_then.39664:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39664
be_else.39664:
	bne     $i19, 0, be_else.39665
be_then.39665:
	li      1, $i18
.count b_cont
	b       be_cont.39665
be_else.39665:
	li      0, $i18
be_cont.39665:
be_cont.39664:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.39666
be_then.39666:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.39666
be_else.39666:
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.39666:
be_cont.39662:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39667
be_then.39667:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.39667
be_else.39667:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39668
ble_then.39668:
	li      0, $i19
.count b_cont
	b       ble_cont.39668
ble_else.39668:
	li      1, $i19
ble_cont.39668:
	bne     $i18, 0, be_else.39669
be_then.39669:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39669
be_else.39669:
	bne     $i19, 0, be_else.39670
be_then.39670:
	li      1, $i18
.count b_cont
	b       be_cont.39670
be_else.39670:
	li      0, $i18
be_cont.39670:
be_cont.39669:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.39671
be_then.39671:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.39671
be_else.39671:
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.39671:
be_cont.39667:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39672
be_then.39672:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39661
be_else.39672:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.39673
ble_then.39673:
	li      0, $i20
.count b_cont
	b       ble_cont.39673
ble_else.39673:
	li      1, $i20
ble_cont.39673:
	bne     $i18, 0, be_else.39674
be_then.39674:
	mov     $i20, $i18
.count b_cont
	b       be_cont.39674
be_else.39674:
	bne     $i20, 0, be_else.39675
be_then.39675:
	li      1, $i18
.count b_cont
	b       be_cont.39675
be_else.39675:
	li      0, $i18
be_cont.39675:
be_cont.39674:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.39676
be_then.39676:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39661
be_else.39676:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39661
be_else.39661:
	bne     $i14, 2, be_else.39677
be_then.39677:
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
	bg      $f10, $f0, ble_else.39678
ble_then.39678:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39677
ble_else.39678:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39677
be_else.39677:
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
	bne     $i18, 0, be_else.39679
be_then.39679:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39679
be_else.39679:
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
be_cont.39679:
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
	bne     $i18, 0, be_else.39680
be_then.39680:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.39681
be_then.39681:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39680
be_else.39681:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39680
be_else.39680:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.39682
be_then.39682:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39682
be_else.39682:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39682:
be_cont.39680:
be_cont.39677:
be_cont.39661:
bge_cont.39660:
	li      116, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 1], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.39683
bge_then.39683:
.count stack_store
	store   $i16, [$sp + 3]
	sub     $i51, 1, $i3
	load    [min_caml_dirvecs + $i16], $i16
	load    [$i16 + 119], $i2
	call    iter_setup_dirvec_constants.2905
	sub     $i51, 1, $i10
	load    [$i16 + 118], $i11
	bl      $i10, 0, bge_cont.39684
bge_then.39684:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39685
be_then.39685:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39686
be_then.39686:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.39686
be_else.39686:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39687
ble_then.39687:
	li      0, $i19
.count b_cont
	b       ble_cont.39687
ble_else.39687:
	li      1, $i19
ble_cont.39687:
	bne     $i18, 0, be_else.39688
be_then.39688:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39688
be_else.39688:
	bne     $i19, 0, be_else.39689
be_then.39689:
	li      1, $i18
.count b_cont
	b       be_cont.39689
be_else.39689:
	li      0, $i18
be_cont.39689:
be_cont.39688:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.39690
be_then.39690:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.39690
be_else.39690:
	store   $f10, [$i17 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.39690:
be_cont.39686:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39691
be_then.39691:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.39691
be_else.39691:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39692
ble_then.39692:
	li      0, $i19
.count b_cont
	b       ble_cont.39692
ble_else.39692:
	li      1, $i19
ble_cont.39692:
	bne     $i18, 0, be_else.39693
be_then.39693:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39693
be_else.39693:
	bne     $i19, 0, be_else.39694
be_then.39694:
	li      1, $i18
.count b_cont
	b       be_cont.39694
be_else.39694:
	li      0, $i18
be_cont.39694:
be_cont.39693:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.39695
be_then.39695:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.39695
be_else.39695:
	store   $f10, [$i17 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.39695:
be_cont.39691:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39696
be_then.39696:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39685
be_else.39696:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.39697
ble_then.39697:
	li      0, $i20
.count b_cont
	b       ble_cont.39697
ble_else.39697:
	li      1, $i20
ble_cont.39697:
	bne     $i18, 0, be_else.39698
be_then.39698:
	mov     $i20, $i18
.count b_cont
	b       be_cont.39698
be_else.39698:
	bne     $i20, 0, be_else.39699
be_then.39699:
	li      1, $i18
.count b_cont
	b       be_cont.39699
be_else.39699:
	li      0, $i18
be_cont.39699:
be_cont.39698:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.39700
be_then.39700:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39685
be_else.39700:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39685
be_else.39685:
	bne     $i14, 2, be_else.39701
be_then.39701:
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
	bg      $f10, $f0, ble_else.39702
ble_then.39702:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39701
ble_else.39702:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i17 + 0]
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i17 + 3]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39701
be_else.39701:
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
	bne     $i18, 0, be_else.39703
be_then.39703:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39703
be_else.39703:
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
be_cont.39703:
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
	bne     $i18, 0, be_else.39704
be_then.39704:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.39705
be_then.39705:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39704
be_else.39705:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39704
be_else.39704:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.39706
be_then.39706:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39706
be_else.39706:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39706:
be_cont.39704:
be_cont.39701:
be_cont.39685:
bge_cont.39684:
	li      117, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 3], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39707
bge_then.39707:
.count stack_store
	store   $i10, [$sp + 4]
	sub     $i51, 1, $i11
	load    [min_caml_dirvecs + $i10], $i10
.count stack_store
	store   $i10, [$sp + 5]
	load    [$i10 + 119], $i10
	bl      $i11, 0, bge_cont.39708
bge_then.39708:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39709
be_then.39709:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39710
be_then.39710:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39710
be_else.39710:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39711
ble_then.39711:
	li      0, $i18
.count b_cont
	b       ble_cont.39711
ble_else.39711:
	li      1, $i18
ble_cont.39711:
	bne     $i17, 0, be_else.39712
be_then.39712:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39712
be_else.39712:
	bne     $i18, 0, be_else.39713
be_then.39713:
	li      1, $i17
.count b_cont
	b       be_cont.39713
be_else.39713:
	li      0, $i17
be_cont.39713:
be_cont.39712:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39714
be_then.39714:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39714
be_else.39714:
	store   $f10, [$i16 + 0]
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39714:
be_cont.39710:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39715
be_then.39715:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39715
be_else.39715:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39716
ble_then.39716:
	li      0, $i18
.count b_cont
	b       ble_cont.39716
ble_else.39716:
	li      1, $i18
ble_cont.39716:
	bne     $i17, 0, be_else.39717
be_then.39717:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39717
be_else.39717:
	bne     $i18, 0, be_else.39718
be_then.39718:
	li      1, $i17
.count b_cont
	b       be_cont.39718
be_else.39718:
	li      0, $i17
be_cont.39718:
be_cont.39717:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39719
be_then.39719:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39719
be_else.39719:
	store   $f10, [$i16 + 2]
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39719:
be_cont.39715:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39720
be_then.39720:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39709
be_else.39720:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39721
ble_then.39721:
	li      0, $i19
.count b_cont
	b       ble_cont.39721
ble_else.39721:
	li      1, $i19
ble_cont.39721:
	bne     $i17, 0, be_else.39722
be_then.39722:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39722
be_else.39722:
	bne     $i19, 0, be_else.39723
be_then.39723:
	li      1, $i17
.count b_cont
	b       be_cont.39723
be_else.39723:
	li      0, $i17
be_cont.39723:
be_cont.39722:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.39724
be_then.39724:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39709
be_else.39724:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39709
be_else.39709:
	bne     $i14, 2, be_else.39725
be_then.39725:
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
	bg      $f10, $f0, ble_else.39726
ble_then.39726:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39725
ble_else.39726:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i13 + 4], $i17
	load    [$i17 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 4], $i17
	load    [$i17 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i13 + 4], $i17
	load    [$i17 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39725
be_else.39725:
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
	bne     $i17, 0, be_else.39727
be_then.39727:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39727
be_else.39727:
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
be_cont.39727:
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
	bne     $i17, 0, be_else.39728
be_then.39728:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39729
be_then.39729:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39728
be_else.39729:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39728
be_else.39728:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39730
be_then.39730:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39730
be_else.39730:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39730:
be_cont.39728:
be_cont.39725:
be_cont.39709:
bge_cont.39708:
	li      118, $i3
.count stack_load
	load    [$sp + 5], $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 4], $i23
	sub     $i23, 1, $i23
	bl      $i23, 0, bge_else.39731
bge_then.39731:
	load    [min_caml_dirvecs + $i23], $i2
	li      119, $i3
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	sub     $i23, 1, $i2
	b       init_vecset_constants.3126
bge_else.39731:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39707:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39683:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39636:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3143:
	bl      $i2, 0, bge_else.39732
bge_then.39732:
	load    [min_caml_objects + $i2], $i10
	load    [$i10 + 2], $i11
	bne     $i11, 2, be_else.39733
be_then.39733:
	load    [$i10 + 7], $i11
	load    [$i11 + 0], $f1
	bg      $f40, $f1, ble_else.39734
ble_then.39734:
	ret
ble_else.39734:
	load    [$i10 + 1], $i11
	bne     $i11, 1, be_else.39735
be_then.39735:
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count stack_load
	load    [$sp + 3], $i17
	store   $f57, [$i17 + 0]
	fneg    $f58, $f10
	store   $f10, [$i17 + 1]
	fneg    $f59, $f11
	store   $f11, [$i17 + 2]
	sub     $i51, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 4]
	call    iter_setup_dirvec_constants.2905
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
	fsub    $f40, $f1, $f1
.count stack_store
	store   $f1, [$sp + 6]
	mov     $hp, $i11
	add     $hp, 3, $hp
	store   $f1, [$i11 + 2]
.count stack_load
	load    [$sp + 4], $i12
	store   $i12, [$i11 + 1]
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
	store   $i10, [min_caml_reflections + $i57]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 7]
.count move_args
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	fneg    $f57, $f12
.count stack_load
	load    [$sp + 7], $i17
	store   $f12, [$i17 + 0]
	store   $f58, [$i17 + 1]
	store   $f11, [$i17 + 2]
	sub     $i51, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    iter_setup_dirvec_constants.2905
	add     $i57, 1, $i10
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
	mov     $i12, $i11
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count stack_load
	load    [$sp + 9], $i17
	store   $f12, [$i17 + 0]
	store   $f10, [$i17 + 1]
	store   $f59, [$i17 + 2]
	sub     $i51, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	add     $i57, 2, $i1
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
	mov     $i3, $i2
	store   $i2, [min_caml_reflections + $i1]
	add     $i57, 3, $i1
.count move_float
	mov     $i1, $i57
	ret
be_else.39735:
	bne     $i11, 2, be_else.39736
be_then.39736:
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count load_float
	load    [f.34785], $f10
	load    [$i11 + 0], $f11
	fmul    $f10, $f11, $f12
	fmul    $f57, $f11, $f11
	load    [$i10 + 1], $f13
	fmul    $f58, $f13, $f14
	fadd    $f11, $f14, $f11
	load    [$i10 + 2], $f14
	fmul    $f59, $f14, $f15
	fadd    $f11, $f15, $f11
	fmul    $f12, $f11, $f12
	fsub    $f12, $f57, $f12
.count stack_load
	load    [$sp + 12], $i17
	store   $f12, [$i17 + 0]
	fmul    $f10, $f13, $f12
	fmul    $f12, $f11, $f12
	fsub    $f12, $f58, $f12
	store   $f12, [$i17 + 1]
	fmul    $f10, $f14, $f10
	fmul    $f10, $f11, $f10
	fsub    $f10, $f59, $f10
	store   $f10, [$i17 + 2]
	sub     $i51, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 13]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 3], $f1
	fsub    $f40, $f1, $f1
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
	mov     $i2, $i1
	store   $i1, [min_caml_reflections + $i57]
	add     $i57, 1, $i1
.count move_float
	mov     $i1, $i57
	ret
be_else.39736:
	ret
be_else.39733:
	ret
bge_else.39732:
	ret
.end setup_reflections

######################################################################
.begin main
min_caml_main:
.count stack_move
	sub     $sp, 18, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [min_caml_n_objects + 0], $i51
	load    [min_caml_solver_dist + 0], $f44
	load    [min_caml_diffuse_ray + 0], $f45
	load    [min_caml_diffuse_ray + 1], $f46
	load    [min_caml_diffuse_ray + 2], $f47
	load    [min_caml_rgb + 0], $f48
	load    [min_caml_rgb + 1], $f49
	load    [min_caml_rgb + 2], $f50
	load    [min_caml_tmin + 0], $f51
	load    [min_caml_texture_color + 1], $f52
	load    [min_caml_image_size + 0], $i52
	load    [min_caml_startp_fast + 0], $f53
	load    [min_caml_startp_fast + 1], $f54
	load    [min_caml_startp_fast + 2], $f55
	load    [min_caml_texture_color + 0], $f56
	load    [min_caml_light + 0], $f57
	load    [min_caml_light + 1], $f58
	load    [min_caml_light + 2], $f59
	load    [min_caml_texture_color + 2], $f60
	load    [min_caml_or_net + 0], $i53
	load    [min_caml_image_size + 1], $i54
	load    [min_caml_intsec_rectside + 0], $i55
	load    [min_caml_intersected_object_id + 0], $i56
	load    [min_caml_n_reflections + 0], $i57
	load    [min_caml_scan_pitch + 0], $f61
	load    [min_caml_screenz_dir + 0], $f62
	load    [min_caml_screenz_dir + 1], $f63
	load    [min_caml_image_center + 1], $i58
	load    [min_caml_image_center + 0], $i59
	load    [f.34775 + 0], $f39
	load    [f.34799 + 0], $f40
	load    [f.34778 + 0], $f41
	load    [f.34779 + 0], $f42
	load    [f.34822 + 0], $f43
	li      128, $i2
.count move_float
	mov     $i2, $i52
	li      128, $i1
.count move_float
	mov     $i1, $i54
	li      64, $i1
.count move_float
	mov     $i1, $i59
	li      64, $i1
.count move_float
	mov     $i1, $i58
.count load_float
	load    [f.34915], $f10
	call    min_caml_float_of_int
	finv    $f1, $f1
	fmul    $f10, $f1, $f1
.count move_float
	mov     $f1, $f61
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
	mov     $hp, $i18
	add     $hp, 8, $hp
	store   $i17, [$i18 + 7]
	store   $i16, [$i18 + 6]
	store   $i15, [$i18 + 5]
	store   $i14, [$i18 + 4]
	store   $i13, [$i18 + 3]
	store   $i12, [$i18 + 2]
	store   $i11, [$i18 + 1]
	store   $i10, [$i18 + 0]
	mov     $i18, $i3
.count move_args
	mov     $i52, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $i52, 2, $i20
	bl      $i20, 0, bge_else.39737
bge_then.39737:
	call    create_pixel.3087
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3089
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.39737
bge_else.39737:
	mov     $i19, $i10
bge_cont.39737:
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
	mov     $hp, $i18
	add     $hp, 8, $hp
	store   $i17, [$i18 + 7]
	store   $i16, [$i18 + 6]
	store   $i15, [$i18 + 5]
	store   $i14, [$i18 + 4]
	store   $i13, [$i18 + 3]
	store   $i12, [$i18 + 2]
	store   $i11, [$i18 + 1]
	store   $i10, [$i18 + 0]
	mov     $i18, $i3
.count move_args
	mov     $i52, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $i52, 2, $i20
	bl      $i20, 0, bge_else.39738
bge_then.39738:
	call    create_pixel.3087
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3089
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.39738
bge_else.39738:
	mov     $i19, $i10
bge_cont.39738:
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
	mov     $hp, $i18
	add     $hp, 8, $hp
	store   $i17, [$i18 + 7]
	store   $i16, [$i18 + 6]
	store   $i15, [$i18 + 5]
	store   $i14, [$i18 + 4]
	store   $i13, [$i18 + 3]
	store   $i12, [$i18 + 2]
	store   $i11, [$i18 + 1]
	store   $i10, [$i18 + 0]
	mov     $i18, $i3
.count move_args
	mov     $i52, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	sub     $i52, 2, $i20
	bl      $i20, 0, bge_else.39739
bge_then.39739:
	call    create_pixel.3087
.count move_ret
	mov     $i1, $i22
.count storer
	add     $i19, $i20, $tmp
	store   $i22, [$tmp + 0]
	sub     $i20, 1, $i3
.count move_args
	mov     $i19, $i2
	call    init_line_elements.3089
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       bge_cont.39739
bge_else.39739:
	mov     $i19, $i10
bge_cont.39739:
.count stack_store
	store   $i10, [$sp + 3]
	call    read_screen_settings.2791
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f14
.count load_float
	load    [f.34782], $f15
.count stack_store
	store   $f15, [$sp + 4]
	fmul    $f14, $f15, $f2
.count stack_store
	store   $f2, [$sp + 5]
	call    sin.2657
.count move_ret
	mov     $f1, $f10
	fneg    $f10, $f10
.count move_float
	mov     $f10, $f58
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f16
.count stack_load
	load    [$sp + 5], $f2
	call    cos.2659
.count move_ret
	mov     $f1, $f14
.count stack_store
	store   $f14, [$sp + 6]
.count stack_load
	load    [$sp + 4], $f15
	fmul    $f16, $f15, $f2
.count stack_store
	store   $f2, [$sp + 7]
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fmul    $f14, $f16, $f16
.count move_float
	mov     $f16, $f57
.count stack_load
	load    [$sp + 7], $f2
	call    cos.2659
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 6], $f11
	fmul    $f11, $f10, $f10
.count move_float
	mov     $f10, $f59
	call    min_caml_read_float
.count move_ret
	mov     $f1, $f32
	store   $f32, [min_caml_beam + 0]
	li      0, $i2
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39740
be_then.39740:
.count stack_load
	load    [$sp + 8], $i10
.count move_float
	mov     $i10, $i51
.count b_cont
	b       be_cont.39740
be_else.39740:
	li      1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39741
be_then.39741:
.count stack_load
	load    [$sp + 9], $i10
.count move_float
	mov     $i10, $i51
.count b_cont
	b       be_cont.39741
be_else.39741:
	li      2, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39742
be_then.39742:
.count stack_load
	load    [$sp + 10], $i10
.count move_float
	mov     $i10, $i51
.count b_cont
	b       be_cont.39742
be_else.39742:
	li      3, $i2
.count stack_store
	store   $i2, [$sp + 11]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i24
	bne     $i24, 0, be_else.39743
be_then.39743:
.count stack_load
	load    [$sp + 11], $i10
.count move_float
	mov     $i10, $i51
.count b_cont
	b       be_cont.39743
be_else.39743:
	li      4, $i2
	call    read_object.2800
be_cont.39743:
be_cont.39742:
be_cont.39741:
be_cont.39740:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.39744
be_then.39744:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
.count b_cont
	b       be_cont.39744
be_else.39744:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.39745
be_then.39745:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
	store   $i10, [$i18 + 0]
.count b_cont
	b       be_cont.39745
be_else.39745:
.count stack_store
	store   $i10, [$sp + 12]
.count stack_store
	store   $i11, [$sp + 13]
	call    read_net_item.2804
.count move_ret
	mov     $i1, $i18
.count stack_load
	load    [$sp + 13], $i19
	store   $i19, [$i18 + 1]
.count stack_load
	load    [$sp + 12], $i19
	store   $i19, [$i18 + 0]
be_cont.39745:
be_cont.39744:
	load    [$i18 + 0], $i19
	be      $i19, -1, bne_cont.39746
bne_then.39746:
	store   $i18, [min_caml_and_net + 0]
	li      1, $i2
	call    read_and_network.2808
bne_cont.39746:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.39747
be_then.39747:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39747
be_else.39747:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.39748
be_then.39748:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.39748
be_else.39748:
.count stack_store
	store   $i10, [$sp + 14]
.count stack_store
	store   $i11, [$sp + 15]
	call    read_net_item.2804
.count move_ret
	mov     $i1, $i10
.count stack_load
	load    [$sp + 15], $i11
	store   $i11, [$i10 + 1]
.count stack_load
	load    [$sp + 14], $i11
	store   $i11, [$i10 + 0]
be_cont.39748:
be_cont.39747:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	li      1, $i2
	bne     $i10, -1, be_else.39749
be_then.39749:
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.39749
be_else.39749:
.count stack_store
	store   $i3, [$sp + 16]
	call    read_or_network.2806
.count stack_load
	load    [$sp + 16], $i10
	store   $i10, [$i1 + 0]
be_cont.39749:
.count move_float
	mov     $i1, $i53
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
	mov     $i51, $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
	li      120, $i2
	mov     $hp, $i11
	add     $hp, 2, $hp
	store   $i10, [$i11 + 1]
.count stack_load
	load    [$sp + 17], $i10
	store   $i10, [$i11 + 0]
	mov     $i11, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i14
	store   $i14, [min_caml_dirvecs + 4]
	load    [min_caml_dirvecs + 4], $i2
	li      118, $i3
	call    create_dirvec_elements.3118
	li      3, $i2
	call    create_dirvecs.3121
	li      0, $i1
	li      0, $i10
	li      4, $i11
	li      9, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f23
.count load_float
	load    [f.34852], $f24
	fmul    $f23, $f24, $f23
.count load_float
	load    [f.34853], $f24
	fsub    $f23, $f24, $f2
.count move_args
	mov     $i11, $i2
.count move_args
	mov     $i1, $i3
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3107
	li      8, $i2
	li      2, $i3
	li      4, $i4
	call    calc_dirvec_rows.3112
	load    [min_caml_dirvecs + 4], $i2
	li      119, $i3
	call    init_dirvec_constants.3123
	li      3, $i2
	call    init_vecset_constants.3126
	li      min_caml_light_dirvec, $i10
	load    [min_caml_light_dirvec + 0], $i11
	store   $f57, [$i11 + 0]
	store   $f58, [$i11 + 1]
	store   $f59, [$i11 + 2]
	sub     $i51, 1, $i12
	bl      $i12, 0, bge_cont.39750
bge_then.39750:
	load    [min_caml_light_dirvec + 1], $i13
	load    [min_caml_objects + $i12], $i14
	load    [$i14 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.39751
be_then.39751:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i11 + 0], $f10
	bne     $f10, $f0, be_else.39752
be_then.39752:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39752
be_else.39752:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.39753
ble_then.39753:
	li      0, $i18
.count b_cont
	b       ble_cont.39753
ble_else.39753:
	li      1, $i18
ble_cont.39753:
	bne     $i17, 0, be_else.39754
be_then.39754:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39754
be_else.39754:
	bne     $i18, 0, be_else.39755
be_then.39755:
	li      1, $i17
.count b_cont
	b       be_cont.39755
be_else.39755:
	li      0, $i17
be_cont.39755:
be_cont.39754:
	load    [$i14 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39756
be_then.39756:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39756
be_else.39756:
	store   $f10, [$i16 + 0]
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39756:
be_cont.39752:
	load    [$i11 + 1], $f10
	bne     $f10, $f0, be_else.39757
be_then.39757:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39757
be_else.39757:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.39758
ble_then.39758:
	li      0, $i18
.count b_cont
	b       ble_cont.39758
ble_else.39758:
	li      1, $i18
ble_cont.39758:
	bne     $i17, 0, be_else.39759
be_then.39759:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39759
be_else.39759:
	bne     $i18, 0, be_else.39760
be_then.39760:
	li      1, $i17
.count b_cont
	b       be_cont.39760
be_else.39760:
	li      0, $i17
be_cont.39760:
be_cont.39759:
	load    [$i14 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39761
be_then.39761:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39761
be_else.39761:
	store   $f10, [$i16 + 2]
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39761:
be_cont.39757:
	load    [$i11 + 2], $f10
	bne     $f10, $f0, be_else.39762
be_then.39762:
	store   $f0, [$i16 + 5]
.count storer
	add     $i13, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39751
be_else.39762:
	load    [$i14 + 6], $i17
	load    [$i14 + 4], $i18
	bg      $f0, $f10, ble_else.39763
ble_then.39763:
	li      0, $i19
.count b_cont
	b       ble_cont.39763
ble_else.39763:
	li      1, $i19
ble_cont.39763:
	bne     $i17, 0, be_else.39764
be_then.39764:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39764
be_else.39764:
	bne     $i19, 0, be_else.39765
be_then.39765:
	li      1, $i17
.count b_cont
	b       be_cont.39765
be_else.39765:
	li      0, $i17
be_cont.39765:
be_cont.39764:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i12, 1, $i3
.count storer
	add     $i13, $i12, $tmp
	bne     $i17, 0, be_else.39766
be_then.39766:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39751
be_else.39766:
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39751
be_else.39751:
	bne     $i15, 2, be_else.39767
be_then.39767:
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
	bg      $f10, $f0, ble_else.39768
ble_then.39768:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39767
ble_else.39768:
	finv    $f10, $f10
	fneg    $f10, $f11
	store   $f11, [$i16 + 0]
	load    [$i14 + 4], $i17
	load    [$i17 + 0], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 1]
	load    [$i14 + 4], $i17
	load    [$i17 + 1], $f11
	fmul    $f11, $f10, $f11
	fneg    $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i14 + 4], $i17
	load    [$i17 + 2], $f11
	fmul    $f11, $f10, $f10
	fneg    $f10, $f10
	store   $f10, [$i16 + 3]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39767
be_else.39767:
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
	bne     $i17, 0, be_else.39769
be_then.39769:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39769
be_else.39769:
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
be_cont.39769:
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
	bne     $i17, 0, be_else.39770
be_then.39770:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39771
be_then.39771:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39770
be_else.39771:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39770
be_else.39770:
	load    [$i14 + 9], $i17
	load    [$i14 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
	fmul    $f12, $f39, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i14 + 9], $i17
	load    [$i11 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f14
	fmul    $f14, $f17, $f14
	fadd    $f11, $f14, $f11
	fmul    $f11, $f39, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i11 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f39, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39772
be_then.39772:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39772
be_else.39772:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39772:
be_cont.39770:
be_cont.39767:
be_cont.39751:
bge_cont.39750:
	sub     $i51, 1, $i2
	call    setup_reflections.3143
	li      0, $i1
	sub     $i52, 1, $i10
	load    [min_caml_screeny_dir + 0], $f10
	neg     $i58, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f32
	fmul    $f61, $f32, $f32
	fmul    $f32, $f10, $f33
	fadd    $f33, $f62, $f2
	load    [min_caml_screeny_dir + 1], $f33
	fmul    $f32, $f33, $f33
	fadd    $f33, $f63, $f3
	load    [min_caml_screeny_dir + 2], $f33
	fmul    $f32, $f33, $f32
	load    [min_caml_screenz_dir + 2], $f33
	fadd    $f32, $f33, $f4
.count stack_load
	load    [$sp + 2], $i2
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i1, $i4
	call    pretrace_pixels.3062
	li      0, $i2
	li      2, $i6
.count stack_load
	load    [$sp + 1], $i3
.count stack_load
	load    [$sp + 2], $i4
.count stack_load
	load    [$sp + 3], $i5
	call    scan_line.3079
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 18, $sp
	li      0, $tmp
	ret
.end main
