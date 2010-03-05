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
.define { b %Imm } { cmpjmp 0, $i0, $i0, %1 }
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
	bne     $i2, 25, be_else.38655
be_then.38655:
	mov     $f4, $f1
	ret
be_else.38655:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38656
ble_then.38656:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38657
be_then.38657:
	ret
be_else.38657:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38658
ble_then.38658:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29081
ble_else.38658:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29081
ble_else.38656:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38659
be_then.38659:
	ret
be_else.38659:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38660
ble_then.38660:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29081
ble_else.38660:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29081
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.32670:
	bne     $i2, 25, be_else.38661
be_then.38661:
	mov     $f4, $f1
	ret
be_else.38661:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38662
ble_then.38662:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38663
be_then.38663:
	ret
be_else.38663:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38664
ble_then.38664:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32670
ble_else.38664:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32670
ble_else.38662:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38665
be_then.38665:
	ret
be_else.38665:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38666
ble_then.38666:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32670
ble_else.38666:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32670
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.11361:
	bne     $i2, 25, be_else.38667
be_then.38667:
	mov     $f4, $f1
	ret
be_else.38667:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38668
ble_then.38668:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38669
be_then.38669:
	ret
be_else.38669:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38670
ble_then.38670:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11361
ble_else.38670:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11361
ble_else.38668:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38671
be_then.38671:
	ret
be_else.38671:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38672
ble_then.38672:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11361
ble_else.38672:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11361
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.11396:
	bne     $i2, 25, be_else.38673
be_then.38673:
	mov     $f4, $f1
	ret
be_else.38673:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38674
ble_then.38674:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38675
be_then.38675:
	ret
be_else.38675:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38676
ble_then.38676:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11396
ble_else.38676:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11396
ble_else.38674:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38677
be_then.38677:
	ret
be_else.38677:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38678
ble_then.38678:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11396
ble_else.38678:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.11396
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.29165:
	bne     $i2, 25, be_else.38679
be_then.38679:
	mov     $f4, $f1
	ret
be_else.38679:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38680
ble_then.38680:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38681
be_then.38681:
	ret
be_else.38681:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38682
ble_then.38682:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29165
ble_else.38682:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29165
ble_else.38680:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38683
be_then.38683:
	ret
be_else.38683:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38684
ble_then.38684:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29165
ble_else.38684:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.29165
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.32761:
	bne     $i2, 25, be_else.38685
be_then.38685:
	mov     $f4, $f1
	ret
be_else.38685:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38686
ble_then.38686:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38687
be_then.38687:
	ret
be_else.38687:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38688
ble_then.38688:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32761
ble_else.38688:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32761
ble_else.38686:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38689
be_then.38689:
	ret
be_else.38689:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38690
ble_then.38690:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32761
ble_else.38690:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.32761
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19974:
	bne     $i2, 25, be_else.38691
be_then.38691:
	mov     $f4, $f1
	ret
be_else.38691:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38692
ble_then.38692:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38693
be_then.38693:
	ret
be_else.38693:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38694
ble_then.38694:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19974
ble_else.38694:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19974
ble_else.38692:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38695
be_then.38695:
	ret
be_else.38695:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38696
ble_then.38696:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19974
ble_else.38696:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19974
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20058:
	bne     $i2, 25, be_else.38697
be_then.38697:
	mov     $f4, $f1
	ret
be_else.38697:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38698
ble_then.38698:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38699
be_then.38699:
	ret
be_else.38699:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38700
ble_then.38700:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20058
ble_else.38700:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20058
ble_else.38698:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38701
be_then.38701:
	ret
be_else.38701:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38702
ble_then.38702:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20058
ble_else.38702:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20058
.end cordic_rec

######################################################################
.begin sin
sin.2657:
	bg      $f0, $f2, ble_else.38703
ble_then.38703:
.count load_float
	load    [f.34777], $f10
	bg      $f10, $f2, ble_else.38704
ble_then.38704:
.count load_float
	load    [f.34780], $f11
	bg      $f11, $f2, ble_else.38705
ble_then.38705:
.count load_float
	load    [f.34781], $f12
	bg      $f12, $f2, ble_else.38706
ble_then.38706:
	fsub    $f2, $f12, $f13
	bg      $f0, $f13, ble_else.38707
ble_then.38707:
	bg      $f10, $f13, ble_else.38708
ble_then.38708:
	bg      $f11, $f13, ble_else.38709
ble_then.38709:
	bg      $f12, $f13, ble_else.38710
ble_then.38710:
	fsub    $f13, $f12, $f2
	b       sin.2657
ble_else.38710:
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
ble_else.38709:
	fsub    $f11, $f13, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38711
ble_then.38711:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.20058
ble_else.38711:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.20058
ble_else.38708:
.count move_args
	mov     $f13, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f13, $f0, ble_else.38712
ble_then.38712:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.19974
ble_else.38712:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.19974
ble_else.38707:
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
ble_else.38706:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fsub    $f12, $f2, $f13
	bg      $f0, $f13, ble_else.38713
ble_then.38713:
	bg      $f10, $f13, ble_else.38714
ble_then.38714:
	bg      $f11, $f13, ble_else.38715
ble_then.38715:
	bg      $f12, $f13, ble_else.38716
ble_then.38716:
	fsub    $f13, $f12, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38716:
	fsub    $f12, $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38715:
	fsub    $f11, $f13, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38717
ble_then.38717:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.32761
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38717:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.32761
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38714:
.count move_args
	mov     $f13, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f13, $f0, ble_else.38718
ble_then.38718:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.29165
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38718:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.29165
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38713:
	fneg    $f13, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38705:
	fsub    $f11, $f2, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38719
ble_then.38719:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.11396
ble_else.38719:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.11396
ble_else.38704:
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38720
ble_then.38720:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.11361
ble_else.38720:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.11361
ble_else.38703:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $ra, [$sp + 0]
	fneg    $f2, $f10
	bg      $f0, $f10, ble_else.38721
ble_then.38721:
.count load_float
	load    [f.34777], $f11
	bg      $f11, $f10, ble_else.38722
ble_then.38722:
.count load_float
	load    [f.34780], $f11
	bg      $f11, $f10, ble_else.38723
ble_then.38723:
.count load_float
	load    [f.34781], $f1
	bg      $f1, $f10, ble_else.38724
ble_then.38724:
	fsub    $f10, $f1, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38724:
	fsub    $f1, $f10, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	fneg    $f1, $f1
	ret
ble_else.38723:
	fsub    $f11, $f10, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38725
ble_then.38725:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.32670
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38725:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.32670
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38722:
.count move_args
	mov     $f10, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f10, $f0, ble_else.38726
ble_then.38726:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f11
	fneg    $f11, $f5
	call    cordic_rec.6342.29081
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38726:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.29081
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 1, $sp
	fneg    $f1, $f1
	ret
ble_else.38721:
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
	bne     $i2, 25, be_else.38727
be_then.38727:
	mov     $f4, $f1
	ret
be_else.38727:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38728
ble_then.38728:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38729
be_then.38729:
	ret
be_else.38729:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38730
ble_then.38730:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19662
ble_else.38730:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19662
ble_else.38728:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38731
be_then.38731:
	ret
be_else.38731:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38732
ble_then.38732:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19662
ble_else.38732:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19662
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19746:
	bne     $i2, 25, be_else.38733
be_then.38733:
	mov     $f4, $f1
	ret
be_else.38733:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38734
ble_then.38734:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38735
be_then.38735:
	ret
be_else.38735:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38736
ble_then.38736:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19746
ble_else.38736:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19746
ble_else.38734:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38737
be_then.38737:
	ret
be_else.38737:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38738
ble_then.38738:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19746
ble_else.38738:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19746
.end cordic_rec

######################################################################
.begin cos
cos.2659:
.count load_float
	load    [f.34777], $f14
	fsub    $f14, $f2, $f15
	bg      $f0, $f15, ble_else.38739
ble_then.38739:
	bg      $f14, $f15, ble_else.38740
ble_then.38740:
.count load_float
	load    [f.34780], $f14
	bg      $f14, $f15, ble_else.38741
ble_then.38741:
.count load_float
	load    [f.34781], $f14
	bg      $f14, $f15, ble_else.38742
ble_then.38742:
	fsub    $f15, $f14, $f2
	b       sin.2657
ble_else.38742:
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
ble_else.38741:
	fsub    $f14, $f15, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38743
ble_then.38743:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.19746
ble_else.38743:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.19746
ble_else.38740:
.count move_args
	mov     $f15, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f15, $f0, ble_else.38744
ble_then.38744:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	b       cordic_rec.6342.19662
ble_else.38744:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	b       cordic_rec.6342.19662
ble_else.38739:
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
	bne     $i2, 25, be_else.38745
be_then.38745:
	mov     $f4, $f1
	ret
be_else.38745:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38746
ble_then.38746:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38747
be_then.38747:
	ret
be_else.38747:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38748
ble_then.38748:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19326
ble_else.38748:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19326
ble_else.38746:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38749
be_then.38749:
	ret
be_else.38749:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38750
ble_then.38750:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19326
ble_else.38750:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19326
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19410:
	bne     $i2, 25, be_else.38751
be_then.38751:
	mov     $f4, $f1
	ret
be_else.38751:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38752
ble_then.38752:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38753
be_then.38753:
	ret
be_else.38753:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38754
ble_then.38754:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19410
ble_else.38754:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19410
ble_else.38752:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38755
be_then.38755:
	ret
be_else.38755:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38756
ble_then.38756:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19410
ble_else.38756:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19410
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19494:
	bne     $i2, 25, be_else.38757
be_then.38757:
	mov     $f4, $f1
	ret
be_else.38757:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38758
ble_then.38758:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38759
be_then.38759:
	ret
be_else.38759:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38760
ble_then.38760:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19494
ble_else.38760:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19494
ble_else.38758:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38761
be_then.38761:
	ret
be_else.38761:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38762
ble_then.38762:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19494
ble_else.38762:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19494
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19578:
	bne     $i2, 25, be_else.38763
be_then.38763:
	mov     $f4, $f1
	ret
be_else.38763:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38764
ble_then.38764:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38765
be_then.38765:
	ret
be_else.38765:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38766
ble_then.38766:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19578
ble_else.38766:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19578
ble_else.38764:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38767
be_then.38767:
	ret
be_else.38767:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38768
ble_then.38768:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19578
ble_else.38768:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
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
	bg      $f0, $f14, ble_else.38769
ble_then.38769:
	bg      $f15, $f14, ble_else.38770
ble_then.38770:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.38771
ble_then.38771:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.38772
ble_then.38772:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38772:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38771:
	fsub    $f16, $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38773
ble_then.38773:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19578
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38773:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19578
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38770:
.count move_args
	mov     $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f14, $f0, ble_else.38774
ble_then.38774:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19494
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38774:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19494
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.38769
ble_else.38769:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
ble_cont.38769:
	fmul    $f18, $f16, $f19
.count load_float
	load    [f.34783], $f20
	fmul    $f19, $f20, $f19
	store   $f19, [min_caml_screenz_dir + 0]
.count load_float
	load    [f.34784], $f19
	bg      $f0, $f17, ble_else.38775
ble_then.38775:
	bg      $f15, $f17, ble_else.38776
ble_then.38776:
.count load_float
	load    [f.34780], $f21
	bg      $f21, $f17, ble_else.38777
ble_then.38777:
.count load_float
	load    [f.34781], $f21
	bg      $f21, $f17, ble_else.38778
ble_then.38778:
	fsub    $f17, $f21, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38778:
	fsub    $f21, $f17, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
	fneg    $f17, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38777:
	fsub    $f21, $f17, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38779
ble_then.38779:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19410
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38779:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19410
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38776:
.count move_args
	mov     $f17, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f17, $f0, ble_else.38780
ble_then.38780:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19326
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38780:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19326
.count move_ret
	mov     $f1, $f17
.count b_cont
	b       ble_cont.38775
ble_else.38775:
	fneg    $f17, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f17
	fneg    $f17, $f17
ble_cont.38775:
	fmul    $f17, $f19, $f19
	store   $f19, [min_caml_screenz_dir + 1]
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
	load    [min_caml_screenz_dir + 0], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $f1
	load    [min_caml_screenz_dir + 1], $f2
	fsub    $f1, $f2, $f1
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
	bne     $i2, 25, be_else.38781
be_then.38781:
	mov     $f4, $f1
	ret
be_else.38781:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38782
ble_then.38782:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38783
be_then.38783:
	ret
be_else.38783:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38784
ble_then.38784:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18822
ble_else.38784:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18822
ble_else.38782:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38785
be_then.38785:
	ret
be_else.38785:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38786
ble_then.38786:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18822
ble_else.38786:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18822
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.18906:
	bne     $i2, 25, be_else.38787
be_then.38787:
	mov     $f4, $f1
	ret
be_else.38787:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38788
ble_then.38788:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38789
be_then.38789:
	ret
be_else.38789:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38790
ble_then.38790:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18906
ble_else.38790:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18906
ble_else.38788:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38791
be_then.38791:
	ret
be_else.38791:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38792
ble_then.38792:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18906
ble_else.38792:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18906
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.18990:
	bne     $i2, 25, be_else.38793
be_then.38793:
	mov     $f4, $f1
	ret
be_else.38793:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38794
ble_then.38794:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38795
be_then.38795:
	ret
be_else.38795:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38796
ble_then.38796:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18990
ble_else.38796:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18990
ble_else.38794:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38797
be_then.38797:
	ret
be_else.38797:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38798
ble_then.38798:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18990
ble_else.38798:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.18990
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19074:
	bne     $i2, 25, be_else.38799
be_then.38799:
	mov     $f4, $f1
	ret
be_else.38799:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38800
ble_then.38800:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38801
be_then.38801:
	ret
be_else.38801:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38802
ble_then.38802:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19074
ble_else.38802:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19074
ble_else.38800:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38803
be_then.38803:
	ret
be_else.38803:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38804
ble_then.38804:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19074
ble_else.38804:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19074
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19158:
	bne     $i2, 25, be_else.38805
be_then.38805:
	mov     $f4, $f1
	ret
be_else.38805:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38806
ble_then.38806:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38807
be_then.38807:
	ret
be_else.38807:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38808
ble_then.38808:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19158
ble_else.38808:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19158
ble_else.38806:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38809
be_then.38809:
	ret
be_else.38809:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38810
ble_then.38810:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19158
ble_else.38810:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19158
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.19242:
	bne     $i2, 25, be_else.38811
be_then.38811:
	mov     $f4, $f1
	ret
be_else.38811:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.38812
ble_then.38812:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.38813
be_then.38813:
	ret
be_else.38813:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38814
ble_then.38814:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19242
ble_else.38814:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19242
ble_else.38812:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.38815
be_then.38815:
	ret
be_else.38815:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.38816
ble_then.38816:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.19242
ble_else.38816:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
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
	bg      $f0, $f20, ble_else.38817
ble_then.38817:
	bg      $f15, $f20, ble_else.38818
ble_then.38818:
.count load_float
	load    [f.34780], $f21
	bg      $f21, $f20, ble_else.38819
ble_then.38819:
.count load_float
	load    [f.34781], $f21
	bg      $f21, $f20, ble_else.38820
ble_then.38820:
	fsub    $f20, $f21, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38820:
	fsub    $f21, $f20, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
	fneg    $f20, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38819:
	fsub    $f21, $f20, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38821
ble_then.38821:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19242
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38821:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19242
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38818:
.count move_args
	mov     $f20, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f20, $f0, ble_else.38822
ble_then.38822:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19158
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38822:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19158
.count move_ret
	mov     $f1, $f20
.count b_cont
	b       ble_cont.38817
ble_else.38817:
	fneg    $f20, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f20
	fneg    $f20, $f20
ble_cont.38817:
	fmul    $f14, $f20, $f21
	fmul    $f21, $f21, $f22
	load    [$i10 + 1], $f23
	fmul    $f23, $f22, $f22
	fadd    $f18, $f22, $f18
	load    [$i3 + 1], $f22
	bg      $f0, $f22, ble_else.38823
ble_then.38823:
	bg      $f15, $f22, ble_else.38824
ble_then.38824:
.count load_float
	load    [f.34780], $f24
	bg      $f24, $f22, ble_else.38825
ble_then.38825:
.count load_float
	load    [f.34781], $f24
	bg      $f24, $f22, ble_else.38826
ble_then.38826:
	fsub    $f22, $f24, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38826:
	fsub    $f24, $f22, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
	fneg    $f22, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38825:
	fsub    $f24, $f22, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38827
ble_then.38827:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.19074
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38827:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.19074
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38824:
.count move_args
	mov     $f22, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f22, $f0, ble_else.38828
ble_then.38828:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.18990
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38828:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.18990
.count move_ret
	mov     $f1, $f22
.count b_cont
	b       ble_cont.38823
ble_else.38823:
	fneg    $f22, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f22
	fneg    $f22, $f22
ble_cont.38823:
	fneg    $f22, $f24
	fmul    $f24, $f24, $f25
	load    [$i10 + 2], $f26
	fmul    $f26, $f25, $f25
	fadd    $f18, $f25, $f18
	store   $f18, [$i10 + 0]
	load    [$i3 + 0], $f18
	bg      $f0, $f18, ble_else.38829
ble_then.38829:
	bg      $f15, $f18, ble_else.38830
ble_then.38830:
.count load_float
	load    [f.34780], $f25
	bg      $f25, $f18, ble_else.38831
ble_then.38831:
.count load_float
	load    [f.34781], $f25
	bg      $f25, $f18, ble_else.38832
ble_then.38832:
	fsub    $f18, $f25, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38832:
	fsub    $f25, $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38831:
	fsub    $f25, $f18, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.38833
ble_then.38833:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.18906
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38833:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.18906
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38830:
.count move_args
	mov     $f18, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f18, $f0, ble_else.38834
ble_then.38834:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.18822
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38834:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.18822
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.38829
ble_else.38829:
	fneg    $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
ble_cont.38829:
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
	bne     $i10, -1, be_else.38835
be_then.38835:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.38835:
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
	be      $i13, 0, bne_cont.38836
bne_then.38836:
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
bne_cont.38836:
	li      4, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i19
.count stack_load
	load    [$sp + 2], $f29
	bg      $f0, $f29, ble_else.38837
ble_then.38837:
	li      0, $i20
.count b_cont
	b       ble_cont.38837
ble_else.38837:
	li      1, $i20
ble_cont.38837:
	bne     $i11, 2, be_else.38838
be_then.38838:
	li      1, $i21
.count b_cont
	b       be_cont.38838
be_else.38838:
	mov     $i20, $i21
be_cont.38838:
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
	bne     $i11, 3, be_else.38839
be_then.38839:
	load    [$i14 + 0], $f29
	bne     $f29, $f0, be_else.38840
be_then.38840:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38840
be_else.38840:
	bne     $f29, $f0, be_else.38841
be_then.38841:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38841
be_else.38841:
	bg      $f29, $f0, ble_else.38842
ble_then.38842:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38842
ble_else.38842:
.count load_float
	load    [f.34799], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38842:
be_cont.38841:
be_cont.38840:
	store   $f29, [$i14 + 0]
	load    [$i14 + 1], $f29
	bne     $f29, $f0, be_else.38843
be_then.38843:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38843
be_else.38843:
	bne     $f29, $f0, be_else.38844
be_then.38844:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38844
be_else.38844:
	bg      $f29, $f0, ble_else.38845
ble_then.38845:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38845
ble_else.38845:
.count load_float
	load    [f.34799], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38845:
be_cont.38844:
be_cont.38843:
	store   $f29, [$i14 + 1]
	load    [$i14 + 2], $f29
	bne     $f29, $f0, be_else.38846
be_then.38846:
	mov     $f0, $f29
.count b_cont
	b       be_cont.38846
be_else.38846:
	bne     $f29, $f0, be_else.38847
be_then.38847:
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	mov     $f0, $f29
.count b_cont
	b       be_cont.38847
be_else.38847:
	bg      $f29, $f0, ble_else.38848
ble_then.38848:
.count load_float
	load    [f.34798], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
	fneg    $f29, $f29
.count b_cont
	b       ble_cont.38848
ble_else.38848:
.count load_float
	load    [f.34799], $f30
	fmul    $f29, $f29, $f29
	finv    $f29, $f29
ble_cont.38848:
be_cont.38847:
be_cont.38846:
	store   $f29, [$i14 + 2]
	bne     $i13, 0, be_else.38849
be_then.38849:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38849:
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
be_else.38839:
	bne     $i11, 2, be_else.38850
be_then.38850:
	load    [$i14 + 0], $f29
	bne     $i20, 0, be_else.38851
be_then.38851:
	li      1, $i11
.count b_cont
	b       be_cont.38851
be_else.38851:
	li      0, $i11
be_cont.38851:
	fmul    $f29, $f29, $f30
	load    [$i14 + 1], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	load    [$i14 + 2], $f31
	fmul    $f31, $f31, $f31
	fadd    $f30, $f31, $f30
	fsqrt   $f30, $f30
	bne     $f30, $f0, be_else.38852
be_then.38852:
.count load_float
	load    [f.34799], $f30
.count b_cont
	b       be_cont.38852
be_else.38852:
	finv    $f30, $f30
	bne     $i11, 0, be_else.38853
be_then.38853:
.count load_float
	load    [f.34799], $f31
.count b_cont
	b       be_cont.38853
be_else.38853:
.count load_float
	load    [f.34798], $f31
	fneg    $f30, $f30
be_cont.38853:
be_cont.38852:
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 0]
	load    [$i14 + 1], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 1]
	load    [$i14 + 2], $f29
	fmul    $f29, $f30, $f29
	store   $f29, [$i14 + 2]
	bne     $i13, 0, be_else.38854
be_then.38854:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38854:
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
be_else.38850:
	bne     $i13, 0, be_else.38855
be_then.38855:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.38855:
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
	bl      $i2, 60, bge_else.38856
bge_then.38856:
	ret
bge_else.38856:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38857
be_then.38857:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38857:
.count stack_load
	load    [$sp + 1], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38858
bge_then.38858:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38858:
.count stack_store
	store   $i2, [$sp + 2]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38859
be_then.38859:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 7], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38859:
.count stack_load
	load    [$sp + 2], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38860
bge_then.38860:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38860:
.count stack_store
	store   $i2, [$sp + 3]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38861
be_then.38861:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 6], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38861:
.count stack_load
	load    [$sp + 3], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38862
bge_then.38862:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38862:
.count stack_store
	store   $i2, [$sp + 4]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38863
be_then.38863:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38863:
.count stack_load
	load    [$sp + 4], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38864
bge_then.38864:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38864:
.count stack_store
	store   $i2, [$sp + 5]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38865
be_then.38865:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38865:
.count stack_load
	load    [$sp + 5], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38866
bge_then.38866:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38866:
.count stack_store
	store   $i2, [$sp + 6]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38867
be_then.38867:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38867:
.count stack_load
	load    [$sp + 6], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38868
bge_then.38868:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38868:
.count stack_store
	store   $i2, [$sp + 7]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.38869
be_then.38869:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38869:
.count stack_load
	load    [$sp + 7], $i23
	add     $i23, 1, $i2
	bl      $i2, 60, bge_else.38870
bge_then.38870:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.38870:
.count stack_store
	store   $i2, [$sp + 8]
	call    read_nth_object.2798
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	bne     $i1, 0, be_else.38871
be_then.38871:
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_n_objects + 0]
	ret
be_else.38871:
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
	bne     $i10, -1, be_else.38872
be_then.38872:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $i10
	add     $i10, 1, $i2
	add     $i0, -1, $i3
	b       min_caml_create_array_int
be_else.38872:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
.count stack_load
	load    [$sp + 1], $i12
	add     $i12, 1, $i13
	bne     $i11, -1, be_else.38873
be_then.38873:
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
be_else.38873:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i14
	add     $i13, 1, $i15
	bne     $i14, -1, be_else.38874
be_then.38874:
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
be_else.38874:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i16
	add     $i15, 1, $i17
	add     $i17, 1, $i2
	bne     $i16, -1, be_else.38875
be_then.38875:
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
be_else.38875:
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
	bne     $i10, -1, be_else.38876
be_then.38876:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38876
be_else.38876:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38877
be_then.38877:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38877
be_else.38877:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38878
be_then.38878:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38878
be_else.38878:
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
be_cont.38878:
be_cont.38877:
be_cont.38876:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.38879
be_then.38879:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $i10
	add     $i10, 1, $i2
	b       min_caml_create_array_int
be_else.38879:
.count stack_store
	store   $i3, [$sp + 5]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38880
be_then.38880:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38880
be_else.38880:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38881
be_then.38881:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38881
be_else.38881:
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
be_cont.38881:
be_cont.38880:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i12
	add     $i12, 1, $i2
	bne     $i10, -1, be_else.38882
be_then.38882:
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
be_else.38882:
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
	bne     $i10, -1, be_else.38883
be_then.38883:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38883
be_else.38883:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38884
be_then.38884:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38884
be_else.38884:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38885
be_then.38885:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38885
be_else.38885:
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
be_cont.38885:
be_cont.38884:
be_cont.38883:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38886
be_then.38886:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38886:
.count stack_load
	load    [$sp + 1], $i11
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38887
be_then.38887:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38887
be_else.38887:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38888
be_then.38888:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38888
be_else.38888:
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
be_cont.38888:
be_cont.38887:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38889
be_then.38889:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38889:
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 7]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38890
be_then.38890:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.38890
be_else.38890:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	bne     $i11, -1, be_else.38891
be_then.38891:
	li      2, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.38891
be_else.38891:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i12
	li      3, $i2
	bne     $i12, -1, be_else.38892
be_then.38892:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i12
	store   $i11, [$i12 + 1]
	store   $i10, [$i12 + 0]
	mov     $i12, $i10
.count b_cont
	b       be_cont.38892
be_else.38892:
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
be_cont.38892:
be_cont.38891:
be_cont.38890:
	load    [$i10 + 0], $i11
	bne     $i11, -1, be_else.38893
be_then.38893:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	ret
be_else.38893:
.count stack_load
	load    [$sp + 7], $i11
	add     $i11, 1, $i11
.count stack_store
	store   $i11, [$sp + 11]
	store   $i10, [min_caml_and_net + $i11]
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.38894
be_then.38894:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.38894
be_else.38894:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.38895
be_then.38895:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
	store   $i10, [$i1 + 0]
.count b_cont
	b       be_cont.38895
be_else.38895:
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
be_cont.38895:
be_cont.38894:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 14, $sp
	load    [$i1 + 0], $i2
	bne     $i2, -1, be_else.38896
be_then.38896:
	ret
be_else.38896:
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
	bne     $i6, 1, be_else.38897
be_then.38897:
	bne     $f4, $f0, be_else.38898
be_then.38898:
	li      0, $i2
.count b_cont
	b       be_cont.38898
be_else.38898:
	load    [$i1 + 4], $i2
	load    [$i2 + 1], $f5
	load    [$i3 + 1], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.38899
ble_then.38899:
	li      0, $i5
.count b_cont
	b       ble_cont.38899
ble_else.38899:
	li      1, $i5
ble_cont.38899:
	bne     $i4, 0, be_else.38900
be_then.38900:
	mov     $i5, $i4
.count b_cont
	b       be_cont.38900
be_else.38900:
	bne     $i5, 0, be_else.38901
be_then.38901:
	li      1, $i4
.count b_cont
	b       be_cont.38901
be_else.38901:
	li      0, $i4
be_cont.38901:
be_cont.38900:
	load    [$i2 + 0], $f7
	bne     $i4, 0, be_cont.38902
be_then.38902:
	fneg    $f7, $f7
be_cont.38902:
	fsub    $f7, $f1, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd    $f6, $f2, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38903
ble_then.38903:
	li      0, $i2
.count b_cont
	b       ble_cont.38903
ble_else.38903:
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	fmul    $f4, $f6, $f6
	fadd    $f6, $f3, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38904
ble_then.38904:
	li      0, $i2
.count b_cont
	b       ble_cont.38904
ble_else.38904:
	store   $f4, [min_caml_solver_dist + 0]
	li      1, $i2
ble_cont.38904:
ble_cont.38903:
be_cont.38898:
	bne     $i2, 0, be_else.38905
be_then.38905:
	load    [$i3 + 1], $f4
	bne     $f4, $f0, be_else.38906
be_then.38906:
	li      0, $i2
.count b_cont
	b       be_cont.38906
be_else.38906:
	load    [$i1 + 4], $i2
	load    [$i2 + 2], $f5
	load    [$i3 + 2], $f6
	load    [$i1 + 6], $i4
	bg      $f0, $f4, ble_else.38907
ble_then.38907:
	li      0, $i5
.count b_cont
	b       ble_cont.38907
ble_else.38907:
	li      1, $i5
ble_cont.38907:
	bne     $i4, 0, be_else.38908
be_then.38908:
	mov     $i5, $i4
.count b_cont
	b       be_cont.38908
be_else.38908:
	bne     $i5, 0, be_else.38909
be_then.38909:
	li      1, $i4
.count b_cont
	b       be_cont.38909
be_else.38909:
	li      0, $i4
be_cont.38909:
be_cont.38908:
	load    [$i2 + 1], $f7
	bne     $i4, 0, be_cont.38910
be_then.38910:
	fneg    $f7, $f7
be_cont.38910:
	fsub    $f7, $f2, $f7
	finv    $f4, $f4
	fmul    $f7, $f4, $f4
	fmul    $f4, $f6, $f6
	fadd    $f6, $f3, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38911
ble_then.38911:
	li      0, $i2
.count b_cont
	b       ble_cont.38911
ble_else.38911:
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	fmul    $f4, $f6, $f6
	fadd    $f6, $f1, $f6
	fabs    $f6, $f6
	bg      $f5, $f6, ble_else.38912
ble_then.38912:
	li      0, $i2
.count b_cont
	b       ble_cont.38912
ble_else.38912:
	store   $f4, [min_caml_solver_dist + 0]
	li      1, $i2
ble_cont.38912:
ble_cont.38911:
be_cont.38906:
	bne     $i2, 0, be_else.38913
be_then.38913:
	load    [$i3 + 2], $f4
	bne     $f4, $f0, be_else.38914
be_then.38914:
	li      0, $i1
	ret
be_else.38914:
	load    [$i1 + 4], $i2
	load    [$i1 + 6], $i1
	load    [$i2 + 0], $f5
	load    [$i3 + 0], $f6
	bg      $f0, $f4, ble_else.38915
ble_then.38915:
	li      0, $i4
.count b_cont
	b       ble_cont.38915
ble_else.38915:
	li      1, $i4
ble_cont.38915:
	bne     $i1, 0, be_else.38916
be_then.38916:
	mov     $i4, $i1
.count b_cont
	b       be_cont.38916
be_else.38916:
	bne     $i4, 0, be_else.38917
be_then.38917:
	li      1, $i1
.count b_cont
	b       be_cont.38917
be_else.38917:
	li      0, $i1
be_cont.38917:
be_cont.38916:
	load    [$i2 + 2], $f7
	bne     $i1, 0, be_cont.38918
be_then.38918:
	fneg    $f7, $f7
be_cont.38918:
	fsub    $f7, $f3, $f3
	finv    $f4, $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f6, $f4
	fadd    $f4, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38919
ble_then.38919:
	li      0, $i1
	ret
ble_else.38919:
	load    [$i2 + 1], $f1
	load    [$i3 + 1], $f4
	fmul    $f3, $f4, $f4
	fadd    $f4, $f2, $f2
	fabs    $f2, $f2
	bg      $f1, $f2, ble_else.38920
ble_then.38920:
	li      0, $i1
	ret
ble_else.38920:
	store   $f3, [min_caml_solver_dist + 0]
	li      3, $i1
	ret
be_else.38913:
	li      2, $i1
	ret
be_else.38905:
	li      1, $i1
	ret
be_else.38897:
	bne     $i6, 2, be_else.38921
be_then.38921:
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
	bg      $f4, $f0, ble_else.38922
ble_then.38922:
	li      0, $i1
	ret
ble_else.38922:
	fmul    $f5, $f1, $f1
	fmul    $f7, $f2, $f2
	fadd    $f1, $f2, $f1
	fmul    $f8, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	finv    $f4, $f2
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38921:
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
	be      $i7, 0, bne_cont.38923
bne_then.38923:
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
bne_cont.38923:
	bne     $f7, $f0, be_else.38924
be_then.38924:
	li      0, $i1
	ret
be_else.38924:
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
	bne     $i2, 0, be_else.38925
be_then.38925:
	mov     $f9, $f4
.count b_cont
	b       be_cont.38925
be_else.38925:
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
.count load_float
	load    [f.34775], $f5
	fmul    $f4, $f5, $f4
	fadd    $f9, $f4, $f4
be_cont.38925:
	fmul    $f4, $f4, $f5
	fmul    $f1, $f1, $f6
	fmul    $f6, $f8, $f6
	fmul    $f2, $f2, $f8
	fmul    $f8, $f10, $f8
	fadd    $f6, $f8, $f6
	fmul    $f3, $f3, $f8
	fmul    $f8, $f11, $f8
	fadd    $f6, $f8, $f6
	bne     $i3, 0, be_else.38926
be_then.38926:
	mov     $f6, $f1
.count b_cont
	b       be_cont.38926
be_else.38926:
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
be_cont.38926:
	bne     $i6, 3, be_cont.38927
be_then.38927:
.count load_float
	load    [f.34799], $f2
	fsub    $f1, $f2, $f1
be_cont.38927:
	fmul    $f7, $f1, $f1
	fsub    $f5, $f1, $f1
	bg      $f1, $f0, ble_else.38928
ble_then.38928:
	li      0, $i1
	ret
ble_else.38928:
	load    [$i1 + 6], $i1
	fsqrt   $f1, $f1
	finv    $f7, $f2
	bne     $i1, 0, be_else.38929
be_then.38929:
	fneg    $f1, $f1
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38929:
	fsub    $f1, $f4, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
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
	bne     $i7, 1, be_else.38930
be_then.38930:
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
	bg      $f4, $f5, ble_else.38931
ble_then.38931:
	li      0, $i4
.count b_cont
	b       ble_cont.38931
ble_else.38931:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd    $f7, $f3, $f7
	fabs    $f7, $f7
	bg      $f5, $f7, ble_else.38932
ble_then.38932:
	li      0, $i4
.count b_cont
	b       ble_cont.38932
ble_else.38932:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.38933
be_then.38933:
	li      0, $i4
.count b_cont
	b       be_cont.38933
be_else.38933:
	li      1, $i4
be_cont.38933:
ble_cont.38932:
ble_cont.38931:
	bne     $i4, 0, be_else.38934
be_then.38934:
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
	bg      $f5, $f6, ble_else.38935
ble_then.38935:
	li      0, $i1
.count b_cont
	b       ble_cont.38935
ble_else.38935:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd    $f8, $f3, $f8
	fabs    $f8, $f8
	bg      $f6, $f8, ble_else.38936
ble_then.38936:
	li      0, $i1
.count b_cont
	b       ble_cont.38936
ble_else.38936:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.38937
be_then.38937:
	li      0, $i1
.count b_cont
	b       be_cont.38937
be_else.38937:
	li      1, $i1
be_cont.38937:
ble_cont.38936:
ble_cont.38935:
	bne     $i1, 0, be_else.38938
be_then.38938:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd    $f6, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38939
ble_then.38939:
	li      0, $i1
	ret
ble_else.38939:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.38940
ble_then.38940:
	li      0, $i1
	ret
ble_else.38940:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.38941
be_then.38941:
	li      0, $i1
	ret
be_else.38941:
	store   $f3, [min_caml_solver_dist + 0]
	li      3, $i1
	ret
be_else.38938:
	store   $f7, [min_caml_solver_dist + 0]
	li      2, $i1
	ret
be_else.38934:
	store   $f6, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38930:
	load    [$i2 + 0], $f4
	bne     $i7, 2, be_else.38942
be_then.38942:
	bg      $f0, $f4, ble_else.38943
ble_then.38943:
	li      0, $i1
	ret
ble_else.38943:
	load    [$i2 + 1], $f4
	fmul    $f4, $f1, $f1
	load    [$i2 + 2], $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    [$i2 + 3], $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38942:
	bne     $f4, $f0, be_else.38944
be_then.38944:
	li      0, $i1
	ret
be_else.38944:
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
	bne     $i6, 0, be_else.38945
be_then.38945:
	mov     $f7, $f1
.count b_cont
	b       be_cont.38945
be_else.38945:
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
be_cont.38945:
	bne     $i7, 3, be_cont.38946
be_then.38946:
.count load_float
	load    [f.34799], $f2
	fsub    $f1, $f2, $f1
be_cont.38946:
	fmul    $f4, $f1, $f1
	fsub    $f6, $f1, $f1
	bg      $f1, $f0, ble_else.38947
ble_then.38947:
	li      0, $i1
	ret
ble_else.38947:
	load    [$i1 + 6], $i1
	load    [$i2 + 4], $f2
	fsqrt   $f1, $f1
	bne     $i1, 0, be_else.38948
be_then.38948:
	fsub    $f5, $f1, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38948:
	fadd    $f5, $f1, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
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
	bne     $i6, 1, be_else.38949
be_then.38949:
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
	bg      $f4, $f5, ble_else.38950
ble_then.38950:
	li      0, $i4
.count b_cont
	b       ble_cont.38950
ble_else.38950:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f5
	load    [$i3 + 2], $f7
	fmul    $f6, $f7, $f7
	fadd    $f7, $f3, $f7
	fabs    $f7, $f7
	bg      $f5, $f7, ble_else.38951
ble_then.38951:
	li      0, $i4
.count b_cont
	b       ble_cont.38951
ble_else.38951:
	load    [$i2 + 1], $f5
	bne     $f5, $f0, be_else.38952
be_then.38952:
	li      0, $i4
.count b_cont
	b       be_cont.38952
be_else.38952:
	li      1, $i4
be_cont.38952:
ble_cont.38951:
ble_cont.38950:
	bne     $i4, 0, be_else.38953
be_then.38953:
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
	bg      $f5, $f6, ble_else.38954
ble_then.38954:
	li      0, $i1
.count b_cont
	b       ble_cont.38954
ble_else.38954:
	load    [$i1 + 4], $i1
	load    [$i1 + 2], $f6
	load    [$i3 + 2], $f8
	fmul    $f7, $f8, $f8
	fadd    $f8, $f3, $f8
	fabs    $f8, $f8
	bg      $f6, $f8, ble_else.38955
ble_then.38955:
	li      0, $i1
.count b_cont
	b       ble_cont.38955
ble_else.38955:
	load    [$i2 + 3], $f6
	bne     $f6, $f0, be_else.38956
be_then.38956:
	li      0, $i1
.count b_cont
	b       be_cont.38956
be_else.38956:
	li      1, $i1
be_cont.38956:
ble_cont.38955:
ble_cont.38954:
	bne     $i1, 0, be_else.38957
be_then.38957:
	load    [$i3 + 0], $f6
	load    [$i2 + 4], $f7
	fsub    $f7, $f3, $f3
	load    [$i2 + 5], $f7
	fmul    $f3, $f7, $f3
	fmul    $f3, $f6, $f6
	fadd    $f6, $f1, $f1
	fabs    $f1, $f1
	bg      $f5, $f1, ble_else.38958
ble_then.38958:
	li      0, $i1
	ret
ble_else.38958:
	load    [$i3 + 1], $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	fabs    $f1, $f1
	bg      $f4, $f1, ble_else.38959
ble_then.38959:
	li      0, $i1
	ret
ble_else.38959:
	load    [$i2 + 5], $f1
	bne     $f1, $f0, be_else.38960
be_then.38960:
	li      0, $i1
	ret
be_else.38960:
	store   $f3, [min_caml_solver_dist + 0]
	li      3, $i1
	ret
be_else.38957:
	store   $f7, [min_caml_solver_dist + 0]
	li      2, $i1
	ret
be_else.38953:
	store   $f6, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38949:
	bne     $i6, 2, be_else.38961
be_then.38961:
	load    [$i2 + 0], $f1
	bg      $f0, $f1, ble_else.38962
ble_then.38962:
	li      0, $i1
	ret
ble_else.38962:
	load    [$i4 + 3], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38961:
	load    [$i2 + 0], $f4
	bne     $f4, $f0, be_else.38963
be_then.38963:
	li      0, $i1
	ret
be_else.38963:
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
	bg      $f2, $f0, ble_else.38964
ble_then.38964:
	li      0, $i1
	ret
ble_else.38964:
	load    [$i1 + 6], $i1
	fsqrt   $f2, $f2
	bne     $i1, 0, be_else.38965
be_then.38965:
	fsub    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
be_else.38965:
	fadd    $f1, $f2, $f1
	load    [$i2 + 4], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_solver_dist + 0]
	li      1, $i1
	ret
.end solver_fast2

######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2905:
	bl      $i3, 0, bge_else.38966
bge_then.38966:
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
	bne     $i12, 1, be_else.38967
be_then.38967:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i12
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.38968
be_then.38968:
	store   $f0, [$i12 + 1]
.count b_cont
	b       be_cont.38968
be_else.38968:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38969
ble_then.38969:
	li      0, $i15
.count b_cont
	b       ble_cont.38969
ble_else.38969:
	li      1, $i15
ble_cont.38969:
	bne     $i14, 0, be_else.38970
be_then.38970:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38970
be_else.38970:
	bne     $i15, 0, be_else.38971
be_then.38971:
	li      1, $i14
.count b_cont
	b       be_cont.38971
be_else.38971:
	li      0, $i14
be_cont.38971:
be_cont.38970:
	load    [$i11 + 4], $i15
	load    [$i15 + 0], $f1
	bne     $i14, 0, be_else.38972
be_then.38972:
	fneg    $f1, $f1
	store   $f1, [$i12 + 0]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
.count b_cont
	b       be_cont.38972
be_else.38972:
	store   $f1, [$i12 + 0]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 1]
be_cont.38972:
be_cont.38968:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.38973
be_then.38973:
	store   $f0, [$i12 + 3]
.count b_cont
	b       be_cont.38973
be_else.38973:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38974
ble_then.38974:
	li      0, $i15
.count b_cont
	b       ble_cont.38974
ble_else.38974:
	li      1, $i15
ble_cont.38974:
	bne     $i14, 0, be_else.38975
be_then.38975:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38975
be_else.38975:
	bne     $i15, 0, be_else.38976
be_then.38976:
	li      1, $i14
.count b_cont
	b       be_cont.38976
be_else.38976:
	li      0, $i14
be_cont.38976:
be_cont.38975:
	load    [$i11 + 4], $i15
	load    [$i15 + 1], $f1
	bne     $i14, 0, be_else.38977
be_then.38977:
	fneg    $f1, $f1
	store   $f1, [$i12 + 2]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
.count b_cont
	b       be_cont.38977
be_else.38977:
	store   $f1, [$i12 + 2]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 3]
be_cont.38977:
be_cont.38973:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.38978
be_then.38978:
	store   $f0, [$i12 + 5]
	mov     $i12, $i11
.count b_cont
	b       be_cont.38978
be_else.38978:
	load    [$i11 + 6], $i14
	bg      $f0, $f1, ble_else.38979
ble_then.38979:
	li      0, $i15
.count b_cont
	b       ble_cont.38979
ble_else.38979:
	li      1, $i15
ble_cont.38979:
	bne     $i14, 0, be_else.38980
be_then.38980:
	mov     $i15, $i14
.count b_cont
	b       be_cont.38980
be_else.38980:
	bne     $i15, 0, be_else.38981
be_then.38981:
	li      1, $i14
.count b_cont
	b       be_cont.38981
be_else.38981:
	li      0, $i14
be_cont.38981:
be_cont.38980:
	load    [$i11 + 4], $i11
	load    [$i11 + 2], $f1
	mov     $i12, $i11
	bne     $i14, 0, be_else.38982
be_then.38982:
	fneg    $f1, $f1
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
.count b_cont
	b       be_cont.38982
be_else.38982:
	store   $f1, [$i12 + 4]
	load    [$i13 + 2], $f1
	finv    $f1, $f1
	store   $f1, [$i12 + 5]
be_cont.38982:
be_cont.38978:
.count stack_load
	load    [$sp + 2], $i12
.count storer
	add     $i10, $i12, $tmp
	store   $i11, [$tmp + 0]
	sub     $i12, 1, $i11
	bl      $i11, 0, bge_else.38983
bge_then.38983:
	load    [min_caml_objects + $i11], $i12
	load    [$i12 + 1], $i14
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.38984
be_then.38984:
	li      6, $i2
	call    min_caml_create_array_float
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	load    [$i13 + 0], $f1
	bne     $f1, $f0, be_else.38985
be_then.38985:
	store   $f0, [$i1 + 1]
.count b_cont
	b       be_cont.38985
be_else.38985:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.38986
ble_then.38986:
	li      0, $i3
.count b_cont
	b       ble_cont.38986
ble_else.38986:
	li      1, $i3
ble_cont.38986:
	bne     $i2, 0, be_else.38987
be_then.38987:
	mov     $i3, $i2
.count b_cont
	b       be_cont.38987
be_else.38987:
	bne     $i3, 0, be_else.38988
be_then.38988:
	li      1, $i2
.count b_cont
	b       be_cont.38988
be_else.38988:
	li      0, $i2
be_cont.38988:
be_cont.38987:
	load    [$i12 + 4], $i3
	load    [$i3 + 0], $f1
	bne     $i2, 0, be_else.38989
be_then.38989:
	fneg    $f1, $f1
	store   $f1, [$i1 + 0]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
.count b_cont
	b       be_cont.38989
be_else.38989:
	store   $f1, [$i1 + 0]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 0], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 1]
be_cont.38989:
be_cont.38985:
	load    [$i13 + 1], $f1
	bne     $f1, $f0, be_else.38990
be_then.38990:
	store   $f0, [$i1 + 3]
.count b_cont
	b       be_cont.38990
be_else.38990:
	load    [$i12 + 6], $i2
	bg      $f0, $f1, ble_else.38991
ble_then.38991:
	li      0, $i3
.count b_cont
	b       ble_cont.38991
ble_else.38991:
	li      1, $i3
ble_cont.38991:
	bne     $i2, 0, be_else.38992
be_then.38992:
	mov     $i3, $i2
.count b_cont
	b       be_cont.38992
be_else.38992:
	bne     $i3, 0, be_else.38993
be_then.38993:
	li      1, $i2
.count b_cont
	b       be_cont.38993
be_else.38993:
	li      0, $i2
be_cont.38993:
be_cont.38992:
	load    [$i12 + 4], $i3
	load    [$i3 + 1], $f1
	bne     $i2, 0, be_else.38994
be_then.38994:
	fneg    $f1, $f1
	store   $f1, [$i1 + 2]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
.count b_cont
	b       be_cont.38994
be_else.38994:
	store   $f1, [$i1 + 2]
.count load_float
	load    [f.34799], $f1
	load    [$i13 + 1], $f1
	finv    $f1, $f1
	store   $f1, [$i1 + 3]
be_cont.38994:
be_cont.38990:
	load    [$i13 + 2], $f1
	bne     $f1, $f0, be_else.38995
be_then.38995:
	store   $f0, [$i1 + 5]
.count storer
	add     $i10, $i11, $tmp
	store   $i1, [$tmp + 0]
	sub     $i11, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.38995:
	load    [$i12 + 6], $i2
	load    [$i12 + 4], $i3
	bg      $f0, $f1, ble_else.38996
ble_then.38996:
	li      0, $i4
.count b_cont
	b       ble_cont.38996
ble_else.38996:
	li      1, $i4
ble_cont.38996:
	bne     $i2, 0, be_else.38997
be_then.38997:
	mov     $i4, $i2
.count b_cont
	b       be_cont.38997
be_else.38997:
	bne     $i4, 0, be_else.38998
be_then.38998:
	li      1, $i2
.count b_cont
	b       be_cont.38998
be_else.38998:
	li      0, $i2
be_cont.38998:
be_cont.38997:
	load    [$i3 + 2], $f1
	bne     $i2, 0, be_cont.38999
be_then.38999:
	fneg    $f1, $f1
be_cont.38999:
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
be_else.38984:
	bne     $i14, 2, be_else.39000
be_then.39000:
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
	bg      $f1, $f0, ble_else.39001
ble_then.39001:
	store   $f0, [$i1 + 0]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
ble_else.39001:
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
be_else.39000:
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
	bne     $i2, 0, be_else.39002
be_then.39002:
	mov     $f4, $f1
.count b_cont
	b       be_cont.39002
be_else.39002:
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
be_cont.39002:
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
	bne     $i2, 0, be_else.39003
be_then.39003:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.39004
be_then.39004:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.39004:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.39003:
	load    [$i12 + 9], $i2
	load    [$i12 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
.count load_float
	load    [f.34775], $f5
	fmul    $f3, $f5, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i12 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f9
	fmul    $f9, $f8, $f8
	fadd    $f2, $f8, $f2
	fmul    $f2, $f5, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $f5, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	sub     $i11, 1, $i3
	bne     $f1, $f0, be_else.39005
be_then.39005:
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.39005:
	finv    $f1, $f1
	store   $f1, [$i1 + 4]
	store   $i1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
bge_else.38983:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.38967:
	bne     $i12, 2, be_else.39006
be_then.39006:
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
	bg      $f1, $f0, ble_else.39007
ble_then.39007:
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
ble_else.39007:
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
be_else.39006:
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
	bne     $i2, 0, be_else.39008
be_then.39008:
	mov     $f4, $f1
.count b_cont
	b       be_cont.39008
be_else.39008:
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
be_cont.39008:
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
	bne     $i2, 0, be_else.39009
be_then.39009:
	store   $f2, [$i1 + 1]
	store   $f4, [$i1 + 2]
	store   $f6, [$i1 + 3]
	bne     $f1, $f0, be_else.39010
be_then.39010:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.39010:
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
be_else.39009:
	load    [$i11 + 9], $i2
	load    [$i11 + 9], $i3
	load    [$i2 + 1], $f7
	fmul    $f5, $f7, $f5
	load    [$i3 + 2], $f8
	fmul    $f3, $f8, $f3
	fadd    $f5, $f3, $f3
.count load_float
	load    [f.34775], $f5
	fmul    $f3, $f5, $f3
	fsub    $f2, $f3, $f2
	store   $f2, [$i1 + 1]
	load    [$i11 + 9], $i2
	load    [$i13 + 2], $f2
	load    [$i2 + 0], $f3
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f9
	fmul    $f9, $f8, $f8
	fadd    $f2, $f8, $f2
	fmul    $f2, $f5, $f2
	fsub    $f4, $f2, $f2
	store   $f2, [$i1 + 2]
	load    [$i13 + 1], $f2
	fmul    $f2, $f3, $f2
	load    [$i13 + 0], $f3
	fmul    $f3, $f7, $f3
	fadd    $f2, $f3, $f2
	fmul    $f2, $f5, $f2
	fsub    $f6, $f2, $f2
	store   $f2, [$i1 + 3]
	bne     $f1, $f0, be_else.39011
be_then.39011:
.count stack_load
	load    [$sp - 1], $i2
.count storer
	add     $i10, $i2, $tmp
	store   $i1, [$tmp + 0]
	sub     $i2, 1, $i3
.count stack_load
	load    [$sp - 2], $i2
	b       iter_setup_dirvec_constants.2905
be_else.39011:
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
bge_else.38966:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2910:
	bl      $i3, 0, bge_else.39012
bge_then.39012:
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
	bne     $i4, 2, be_else.39013
be_then.39013:
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
be_else.39013:
	bg      $i4, 2, ble_else.39014
ble_then.39014:
	sub     $i3, 1, $i3
	b       setup_startp_constants.2910
ble_else.39014:
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
	bne     $i9, 0, be_else.39015
be_then.39015:
	mov     $f4, $f1
.count b_cont
	b       be_cont.39015
be_else.39015:
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
be_cont.39015:
	sub     $i3, 1, $i3
	bne     $i4, 3, be_else.39016
be_then.39016:
.count load_float
	load    [f.34799], $f2
	fsub    $f1, $f2, $f1
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2910
be_else.39016:
	store   $f1, [$i5 + 3]
	b       setup_startp_constants.2910
bge_else.39012:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2935:
	load    [$i3 + $i2], $i1
	bne     $i1, -1, be_else.39017
be_then.39017:
	li      1, $i1
	ret
be_else.39017:
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
	bne     $i4, 1, be_else.39018
be_then.39018:
	load    [$i1 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.39019
ble_then.39019:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39020
be_then.39020:
	li      1, $i1
.count b_cont
	b       be_cont.39018
be_else.39020:
	li      0, $i1
.count b_cont
	b       be_cont.39018
ble_else.39019:
	load    [$i1 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.39021
ble_then.39021:
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39022
be_then.39022:
	li      1, $i1
.count b_cont
	b       be_cont.39018
be_else.39022:
	li      0, $i1
.count b_cont
	b       be_cont.39018
ble_else.39021:
	load    [$i1 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i1 + 6], $i1
	bg      $f1, $f5, be_cont.39018
ble_then.39023:
	bne     $i1, 0, be_else.39024
be_then.39024:
	li      1, $i1
.count b_cont
	b       be_cont.39018
be_else.39024:
	li      0, $i1
.count b_cont
	b       be_cont.39018
be_else.39018:
	bne     $i4, 2, be_else.39025
be_then.39025:
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
	bg      $f0, $f1, ble_else.39026
ble_then.39026:
	bne     $i4, 0, be_else.39027
be_then.39027:
	li      1, $i1
.count b_cont
	b       be_cont.39025
be_else.39027:
	li      0, $i1
.count b_cont
	b       be_cont.39025
ble_else.39026:
	bne     $i4, 0, be_else.39028
be_then.39028:
	li      0, $i1
.count b_cont
	b       be_cont.39025
be_else.39028:
	li      1, $i1
.count b_cont
	b       be_cont.39025
be_else.39025:
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
	bne     $i6, 0, be_else.39029
be_then.39029:
	mov     $f7, $f1
.count b_cont
	b       be_cont.39029
be_else.39029:
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
be_cont.39029:
	bne     $i4, 3, be_cont.39030
be_then.39030:
.count load_float
	load    [f.34799], $f5
	fsub    $f1, $f5, $f1
be_cont.39030:
	bg      $f0, $f1, ble_else.39031
ble_then.39031:
	bne     $i5, 0, be_else.39032
be_then.39032:
	li      1, $i1
.count b_cont
	b       ble_cont.39031
be_else.39032:
	li      0, $i1
.count b_cont
	b       ble_cont.39031
ble_else.39031:
	bne     $i5, 0, be_else.39033
be_then.39033:
	li      0, $i1
.count b_cont
	b       be_cont.39033
be_else.39033:
	li      1, $i1
be_cont.39033:
ble_cont.39031:
be_cont.39025:
be_cont.39018:
	bne     $i1, 0, be_else.39034
be_then.39034:
	add     $i2, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.39035
be_then.39035:
	li      1, $i1
	ret
be_else.39035:
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
	bne     $i7, 1, be_else.39036
be_then.39036:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.39037
ble_then.39037:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.39038
be_then.39038:
	li      1, $i2
.count b_cont
	b       be_cont.39036
be_else.39038:
	li      0, $i2
.count b_cont
	b       be_cont.39036
ble_else.39037:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.39039
ble_then.39039:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.39040
be_then.39040:
	li      1, $i2
.count b_cont
	b       be_cont.39036
be_else.39040:
	li      0, $i2
.count b_cont
	b       be_cont.39036
ble_else.39039:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.39036
ble_then.39041:
	bne     $i2, 0, be_else.39042
be_then.39042:
	li      1, $i2
.count b_cont
	b       be_cont.39036
be_else.39042:
	li      0, $i2
.count b_cont
	b       be_cont.39036
be_else.39036:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.39043
be_then.39043:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.39044
ble_then.39044:
	bne     $i4, 0, be_else.39045
be_then.39045:
	li      1, $i2
.count b_cont
	b       be_cont.39043
be_else.39045:
	li      0, $i2
.count b_cont
	b       be_cont.39043
ble_else.39044:
	bne     $i4, 0, be_else.39046
be_then.39046:
	li      0, $i2
.count b_cont
	b       be_cont.39043
be_else.39046:
	li      1, $i2
.count b_cont
	b       be_cont.39043
be_else.39043:
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
	bne     $i9, 0, be_else.39047
be_then.39047:
	mov     $f7, $f1
.count b_cont
	b       be_cont.39047
be_else.39047:
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
be_cont.39047:
	bne     $i5, 3, be_cont.39048
be_then.39048:
.count load_float
	load    [f.34799], $f5
	fsub    $f1, $f5, $f1
be_cont.39048:
	bg      $f0, $f1, ble_else.39049
ble_then.39049:
	bne     $i4, 0, be_else.39050
be_then.39050:
	li      1, $i2
.count b_cont
	b       ble_cont.39049
be_else.39050:
	li      0, $i2
.count b_cont
	b       ble_cont.39049
ble_else.39049:
	bne     $i4, 0, be_else.39051
be_then.39051:
	li      0, $i2
.count b_cont
	b       be_cont.39051
be_else.39051:
	li      1, $i2
be_cont.39051:
ble_cont.39049:
be_cont.39043:
be_cont.39036:
	bne     $i2, 0, be_else.39052
be_then.39052:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.39053
be_then.39053:
	li      1, $i1
	ret
be_else.39053:
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
	bne     $i4, 1, be_else.39054
be_then.39054:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.39055
ble_then.39055:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.39056
be_then.39056:
	li      1, $i2
.count b_cont
	b       be_cont.39054
be_else.39056:
	li      0, $i2
.count b_cont
	b       be_cont.39054
ble_else.39055:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.39057
ble_then.39057:
	load    [$i2 + 6], $i2
	bne     $i2, 0, be_else.39058
be_then.39058:
	li      1, $i2
.count b_cont
	b       be_cont.39054
be_else.39058:
	li      0, $i2
.count b_cont
	b       be_cont.39054
ble_else.39057:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	load    [$i2 + 6], $i2
	bg      $f1, $f5, be_cont.39054
ble_then.39059:
	bne     $i2, 0, be_else.39060
be_then.39060:
	li      1, $i2
.count b_cont
	b       be_cont.39054
be_else.39060:
	li      0, $i2
.count b_cont
	b       be_cont.39054
be_else.39054:
	bne     $i4, 2, be_else.39061
be_then.39061:
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
	bg      $f0, $f1, ble_else.39062
ble_then.39062:
	bne     $i4, 0, be_else.39063
be_then.39063:
	li      1, $i2
.count b_cont
	b       be_cont.39061
be_else.39063:
	li      0, $i2
.count b_cont
	b       be_cont.39061
ble_else.39062:
	bne     $i4, 0, be_else.39064
be_then.39064:
	li      0, $i2
.count b_cont
	b       be_cont.39061
be_else.39064:
	li      1, $i2
.count b_cont
	b       be_cont.39061
be_else.39061:
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
	bne     $i6, 0, be_else.39065
be_then.39065:
	mov     $f7, $f1
.count b_cont
	b       be_cont.39065
be_else.39065:
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
be_cont.39065:
	bne     $i5, 3, be_cont.39066
be_then.39066:
.count load_float
	load    [f.34799], $f5
	fsub    $f1, $f5, $f1
be_cont.39066:
	bg      $f0, $f1, ble_else.39067
ble_then.39067:
	bne     $i4, 0, be_else.39068
be_then.39068:
	li      1, $i2
.count b_cont
	b       ble_cont.39067
be_else.39068:
	li      0, $i2
.count b_cont
	b       ble_cont.39067
ble_else.39067:
	bne     $i4, 0, be_else.39069
be_then.39069:
	li      0, $i2
.count b_cont
	b       be_cont.39069
be_else.39069:
	li      1, $i2
be_cont.39069:
ble_cont.39067:
be_cont.39061:
be_cont.39054:
	bne     $i2, 0, be_else.39070
be_then.39070:
	add     $i1, 1, $i1
	load    [$i3 + $i1], $i2
	bne     $i2, -1, be_else.39071
be_then.39071:
	li      1, $i1
	ret
be_else.39071:
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
	bne     $i7, 1, be_else.39072
be_then.39072:
	load    [$i2 + 4], $i4
	load    [$i4 + 0], $f7
	fabs    $f1, $f1
	bg      $f7, $f1, ble_else.39073
ble_then.39073:
	li      0, $i4
.count b_cont
	b       ble_cont.39073
ble_else.39073:
	load    [$i2 + 4], $i4
	load    [$i4 + 1], $f1
	fabs    $f5, $f5
	bg      $f1, $f5, ble_else.39074
ble_then.39074:
	li      0, $i4
.count b_cont
	b       ble_cont.39074
ble_else.39074:
	load    [$i2 + 4], $i4
	load    [$i4 + 2], $f1
	fabs    $f6, $f5
	bg      $f1, $f5, ble_else.39075
ble_then.39075:
	li      0, $i4
.count b_cont
	b       ble_cont.39075
ble_else.39075:
	li      1, $i4
ble_cont.39075:
ble_cont.39074:
ble_cont.39073:
	load    [$i2 + 6], $i2
	bne     $i4, 0, be_else.39076
be_then.39076:
	bne     $i2, 0, be_else.39077
be_then.39077:
	li      0, $i1
	ret
be_else.39077:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.39076:
	bne     $i2, 0, be_else.39078
be_then.39078:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.39078:
	li      0, $i1
	ret
be_else.39072:
	load    [$i2 + 6], $i4
	bne     $i7, 2, be_else.39079
be_then.39079:
	load    [$i2 + 4], $i2
	load    [$i2 + 0], $f7
	fmul    $f7, $f1, $f1
	load    [$i2 + 1], $f7
	fmul    $f7, $f5, $f5
	fadd    $f1, $f5, $f1
	load    [$i2 + 2], $f5
	fmul    $f5, $f6, $f5
	fadd    $f1, $f5, $f1
	bg      $f0, $f1, ble_else.39080
ble_then.39080:
	bne     $i4, 0, be_else.39081
be_then.39081:
	li      0, $i1
	ret
be_else.39081:
	add     $i1, 1, $i2
	b       check_all_inside.2935
ble_else.39080:
	bne     $i4, 0, be_else.39082
be_then.39082:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.39082:
	li      0, $i1
	ret
be_else.39079:
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
	bne     $i9, 0, be_else.39083
be_then.39083:
	mov     $f7, $f1
.count b_cont
	b       be_cont.39083
be_else.39083:
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
be_cont.39083:
	bne     $i7, 3, be_cont.39084
be_then.39084:
.count load_float
	load    [f.34799], $f5
	fsub    $f1, $f5, $f1
be_cont.39084:
	bg      $f0, $f1, ble_else.39085
ble_then.39085:
	bne     $i4, 0, be_else.39086
be_then.39086:
	li      0, $i1
	ret
be_else.39086:
	add     $i1, 1, $i2
	b       check_all_inside.2935
ble_else.39085:
	bne     $i4, 0, be_else.39087
be_then.39087:
	add     $i1, 1, $i2
	b       check_all_inside.2935
be_else.39087:
	li      0, $i1
	ret
be_else.39070:
	li      0, $i1
	ret
be_else.39052:
	li      0, $i1
	ret
be_else.39034:
	li      0, $i1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2941:
	load    [$i3 + $i2], $i10
	bne     $i10, -1, be_else.39088
be_then.39088:
	li      0, $i1
	ret
be_else.39088:
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
	bne     $i16, 1, be_else.39089
be_then.39089:
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
	bg      $f13, $f14, ble_else.39090
ble_then.39090:
	li      0, $i14
.count b_cont
	b       ble_cont.39090
ble_else.39090:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39091
ble_then.39091:
	li      0, $i14
.count b_cont
	b       ble_cont.39091
ble_else.39091:
	load    [$i12 + 1], $f13
	bne     $f13, $f0, be_else.39092
be_then.39092:
	li      0, $i14
.count b_cont
	b       be_cont.39092
be_else.39092:
	li      1, $i14
be_cont.39092:
ble_cont.39091:
ble_cont.39090:
	bne     $i14, 0, be_else.39093
be_then.39093:
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
	bg      $f13, $f14, ble_else.39094
ble_then.39094:
	li      0, $i14
.count b_cont
	b       ble_cont.39094
ble_else.39094:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i13 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39095
ble_then.39095:
	li      0, $i14
.count b_cont
	b       ble_cont.39095
ble_else.39095:
	load    [$i12 + 3], $f13
	bne     $f13, $f0, be_else.39096
be_then.39096:
	li      0, $i14
.count b_cont
	b       be_cont.39096
be_else.39096:
	li      1, $i14
be_cont.39096:
ble_cont.39095:
ble_cont.39094:
	bne     $i14, 0, be_else.39097
be_then.39097:
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
	bg      $f13, $f10, ble_else.39098
ble_then.39098:
	li      0, $i11
.count b_cont
	b       be_cont.39089
ble_else.39098:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i13 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.39099
ble_then.39099:
	li      0, $i11
.count b_cont
	b       be_cont.39089
ble_else.39099:
	load    [$i12 + 5], $f10
	bne     $f10, $f0, be_else.39100
be_then.39100:
	li      0, $i11
.count b_cont
	b       be_cont.39089
be_else.39100:
	store   $f12, [min_caml_solver_dist + 0]
	li      3, $i11
.count b_cont
	b       be_cont.39089
be_else.39097:
	store   $f15, [min_caml_solver_dist + 0]
	li      2, $i11
.count b_cont
	b       be_cont.39089
be_else.39093:
	store   $f15, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39089
be_else.39089:
	load    [$i12 + 0], $f13
	bne     $i16, 2, be_else.39101
be_then.39101:
	bg      $f0, $f13, ble_else.39102
ble_then.39102:
	li      0, $i11
.count b_cont
	b       be_cont.39101
ble_else.39102:
	load    [$i12 + 1], $f13
	fmul    $f13, $f10, $f10
	load    [$i12 + 2], $f13
	fmul    $f13, $f11, $f11
	fadd    $f10, $f11, $f10
	load    [$i12 + 3], $f11
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39101
be_else.39101:
	bne     $f13, $f0, be_else.39103
be_then.39103:
	li      0, $i11
.count b_cont
	b       be_cont.39103
be_else.39103:
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
	bne     $i13, 0, be_else.39104
be_then.39104:
	mov     $f16, $f10
.count b_cont
	b       be_cont.39104
be_else.39104:
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
be_cont.39104:
	bne     $i16, 3, be_cont.39105
be_then.39105:
.count load_float
	load    [f.34799], $f11
	fsub    $f10, $f11, $f10
be_cont.39105:
	fmul    $f13, $f10, $f10
	fsub    $f15, $f10, $f10
	bg      $f10, $f0, ble_else.39106
ble_then.39106:
	li      0, $i11
.count b_cont
	b       ble_cont.39106
ble_else.39106:
	load    [$i11 + 6], $i11
	load    [$i12 + 4], $f11
	fsqrt   $f10, $f10
	bne     $i11, 0, be_else.39107
be_then.39107:
	fsub    $f14, $f10, $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39107
be_else.39107:
	fadd    $f14, $f10, $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
be_cont.39107:
ble_cont.39106:
be_cont.39103:
be_cont.39101:
be_cont.39089:
	load    [min_caml_solver_dist + 0], $f10
	bne     $i11, 0, be_else.39108
be_then.39108:
	li      0, $i11
.count b_cont
	b       be_cont.39108
be_else.39108:
.count load_float
	load    [f.34800], $f11
	bg      $f11, $f10, ble_else.39109
ble_then.39109:
	li      0, $i11
.count b_cont
	b       ble_cont.39109
ble_else.39109:
	li      1, $i11
ble_cont.39109:
be_cont.39108:
	bne     $i11, 0, be_else.39110
be_then.39110:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39111
be_then.39111:
	li      0, $i1
	ret
be_else.39111:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2941
be_else.39110:
	load    [$i3 + 0], $i10
	bne     $i10, -1, be_else.39112
be_then.39112:
	li      1, $i1
	ret
be_else.39112:
	load    [min_caml_objects + $i10], $i10
	load    [$i10 + 5], $i11
	load    [$i10 + 5], $i12
	load    [$i10 + 5], $i13
	load    [$i10 + 1], $i14
	load    [$i11 + 0], $f11
	load    [min_caml_light + 0], $f12
.count load_float
	load    [f.34801], $f13
	fadd    $f10, $f13, $f10
	fmul    $f12, $f10, $f12
	load    [min_caml_intersection_point + 0], $f13
	fadd    $f12, $f13, $f2
	fsub    $f2, $f11, $f11
	load    [$i12 + 1], $f12
	load    [min_caml_light + 1], $f13
	fmul    $f13, $f10, $f13
	load    [min_caml_intersection_point + 1], $f14
	fadd    $f13, $f14, $f3
	fsub    $f3, $f12, $f12
	load    [$i13 + 2], $f13
	load    [min_caml_light + 2], $f14
	fmul    $f14, $f10, $f10
	load    [min_caml_intersection_point + 2], $f14
	fadd    $f10, $f14, $f4
	fsub    $f4, $f13, $f10
	bne     $i14, 1, be_else.39113
be_then.39113:
	load    [$i10 + 4], $i11
	load    [$i11 + 0], $f13
	fabs    $f11, $f11
	bg      $f13, $f11, ble_else.39114
ble_then.39114:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.39115
be_then.39115:
	li      1, $i10
.count b_cont
	b       be_cont.39113
be_else.39115:
	li      0, $i10
.count b_cont
	b       be_cont.39113
ble_else.39114:
	load    [$i10 + 4], $i11
	load    [$i11 + 1], $f11
	fabs    $f12, $f12
	bg      $f11, $f12, ble_else.39116
ble_then.39116:
	load    [$i10 + 6], $i10
	bne     $i10, 0, be_else.39117
be_then.39117:
	li      1, $i10
.count b_cont
	b       be_cont.39113
be_else.39117:
	li      0, $i10
.count b_cont
	b       be_cont.39113
ble_else.39116:
	load    [$i10 + 4], $i11
	load    [$i11 + 2], $f11
	fabs    $f10, $f10
	load    [$i10 + 6], $i10
	bg      $f11, $f10, be_cont.39113
ble_then.39118:
	bne     $i10, 0, be_else.39119
be_then.39119:
	li      1, $i10
.count b_cont
	b       be_cont.39113
be_else.39119:
	li      0, $i10
.count b_cont
	b       be_cont.39113
be_else.39113:
	load    [$i10 + 6], $i11
	bne     $i14, 2, be_else.39120
be_then.39120:
	load    [$i10 + 4], $i10
	load    [$i10 + 0], $f13
	fmul    $f13, $f11, $f11
	load    [$i10 + 1], $f13
	fmul    $f13, $f12, $f12
	fadd    $f11, $f12, $f11
	load    [$i10 + 2], $f12
	fmul    $f12, $f10, $f10
	fadd    $f11, $f10, $f10
	bg      $f0, $f10, ble_else.39121
ble_then.39121:
	bne     $i11, 0, be_else.39122
be_then.39122:
	li      1, $i10
.count b_cont
	b       be_cont.39120
be_else.39122:
	li      0, $i10
.count b_cont
	b       be_cont.39120
ble_else.39121:
	bne     $i11, 0, be_else.39123
be_then.39123:
	li      0, $i10
.count b_cont
	b       be_cont.39120
be_else.39123:
	li      1, $i10
.count b_cont
	b       be_cont.39120
be_else.39120:
	fmul    $f11, $f11, $f13
	load    [$i10 + 4], $i12
	load    [$i12 + 0], $f14
	fmul    $f13, $f14, $f13
	fmul    $f12, $f12, $f14
	load    [$i10 + 4], $i12
	load    [$i12 + 1], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f10, $f10, $f14
	load    [$i10 + 4], $i12
	load    [$i12 + 2], $f15
	fmul    $f14, $f15, $f14
	load    [$i10 + 3], $i12
	fadd    $f13, $f14, $f13
	bne     $i12, 0, be_else.39124
be_then.39124:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39124
be_else.39124:
	fmul    $f12, $f10, $f14
	load    [$i10 + 9], $i12
	load    [$i12 + 0], $f15
	fmul    $f14, $f15, $f14
	fadd    $f13, $f14, $f13
	fmul    $f10, $f11, $f10
	load    [$i10 + 9], $i12
	load    [$i12 + 1], $f14
	fmul    $f10, $f14, $f10
	fadd    $f13, $f10, $f10
	fmul    $f11, $f12, $f11
	load    [$i10 + 9], $i10
	load    [$i10 + 2], $f12
	fmul    $f11, $f12, $f11
	fadd    $f10, $f11, $f10
be_cont.39124:
	bne     $i14, 3, be_cont.39125
be_then.39125:
.count load_float
	load    [f.34799], $f11
	fsub    $f10, $f11, $f10
be_cont.39125:
	bg      $f0, $f10, ble_else.39126
ble_then.39126:
	bne     $i11, 0, be_else.39127
be_then.39127:
	li      1, $i10
.count b_cont
	b       ble_cont.39126
be_else.39127:
	li      0, $i10
.count b_cont
	b       ble_cont.39126
ble_else.39126:
	bne     $i11, 0, be_else.39128
be_then.39128:
	li      0, $i10
.count b_cont
	b       be_cont.39128
be_else.39128:
	li      1, $i10
be_cont.39128:
ble_cont.39126:
be_cont.39120:
be_cont.39113:
	bne     $i10, 0, be_else.39129
be_then.39129:
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
	bne     $i1, 0, be_else.39130
be_then.39130:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 2], $i3
	b       shadow_check_and_group.2941
be_else.39130:
	li      1, $i1
	ret
be_else.39129:
	add     $i2, 1, $i2
	b       shadow_check_and_group.2941
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2944:
	load    [$i3 + $i2], $i17
	bne     $i17, -1, be_else.39131
be_then.39131:
	li      0, $i1
	ret
be_else.39131:
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
	bne     $i17, 0, be_else.39132
be_then.39132:
.count stack_load
	load    [$sp + 2], $i17
	add     $i17, 1, $i17
.count stack_load
	load    [$sp + 1], $i18
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39133
be_then.39133:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39133:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39134
be_then.39134:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39135
be_then.39135:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39135:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39136
be_then.39136:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39137
be_then.39137:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39137:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39138
be_then.39138:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39139
be_then.39139:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39139:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39140
be_then.39140:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39141
be_then.39141:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39141:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39142
be_then.39142:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39143
be_then.39143:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39143:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39144
be_then.39144:
	add     $i17, 1, $i17
	load    [$i18 + $i17], $i19
	bne     $i19, -1, be_else.39145
be_then.39145:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      0, $i1
	ret
be_else.39145:
	li      0, $i2
	load    [min_caml_and_net + $i19], $i3
	call    shadow_check_and_group.2941
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	bne     $i1, 0, be_else.39146
be_then.39146:
	add     $i17, 1, $i2
.count move_args
	mov     $i18, $i3
	b       shadow_check_one_or_group.2944
be_else.39146:
	li      1, $i1
	ret
be_else.39144:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39142:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39140:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39138:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39136:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39134:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	li      1, $i1
	ret
be_else.39132:
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
	bne     $i18, -1, be_else.39147
be_then.39147:
	li      0, $i1
	ret
be_else.39147:
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
	bne     $i18, 99, be_else.39148
be_then.39148:
	li      1, $i10
.count b_cont
	b       be_cont.39148
be_else.39148:
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
	bne     $i20, 1, be_else.39149
be_then.39149:
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
	bg      $f22, $f23, ble_else.39150
ble_then.39150:
	li      0, $i21
.count b_cont
	b       ble_cont.39150
ble_else.39150:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f22
	load    [$i20 + 2], $f23
	fmul    $f24, $f23, $f23
	fadd    $f23, $f21, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39151
ble_then.39151:
	li      0, $i21
.count b_cont
	b       ble_cont.39151
ble_else.39151:
	load    [$i18 + 1], $f22
	bne     $f22, $f0, be_else.39152
be_then.39152:
	li      0, $i21
.count b_cont
	b       be_cont.39152
be_else.39152:
	li      1, $i21
be_cont.39152:
ble_cont.39151:
ble_cont.39150:
	bne     $i21, 0, be_else.39153
be_then.39153:
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
	bg      $f22, $f23, ble_else.39154
ble_then.39154:
	li      0, $i21
.count b_cont
	b       ble_cont.39154
ble_else.39154:
	load    [$i19 + 4], $i21
	load    [$i21 + 2], $f22
	load    [$i20 + 2], $f23
	fmul    $f24, $f23, $f23
	fadd    $f23, $f21, $f23
	fabs    $f23, $f23
	bg      $f22, $f23, ble_else.39155
ble_then.39155:
	li      0, $i21
.count b_cont
	b       ble_cont.39155
ble_else.39155:
	load    [$i18 + 3], $f22
	bne     $f22, $f0, be_else.39156
be_then.39156:
	li      0, $i21
.count b_cont
	b       be_cont.39156
be_else.39156:
	li      1, $i21
be_cont.39156:
ble_cont.39155:
ble_cont.39154:
	bne     $i21, 0, be_else.39157
be_then.39157:
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
	bg      $f22, $f19, ble_else.39158
ble_then.39158:
	li      0, $i18
.count b_cont
	b       be_cont.39149
ble_else.39158:
	load    [$i19 + 4], $i19
	load    [$i19 + 1], $f19
	load    [$i20 + 1], $f22
	fmul    $f21, $f22, $f22
	fadd    $f22, $f20, $f20
	fabs    $f20, $f20
	bg      $f19, $f20, ble_else.39159
ble_then.39159:
	li      0, $i18
.count b_cont
	b       be_cont.39149
ble_else.39159:
	load    [$i18 + 5], $f19
	bne     $f19, $f0, be_else.39160
be_then.39160:
	li      0, $i18
.count b_cont
	b       be_cont.39149
be_else.39160:
	store   $f21, [min_caml_solver_dist + 0]
	li      3, $i18
.count b_cont
	b       be_cont.39149
be_else.39157:
	store   $f24, [min_caml_solver_dist + 0]
	li      2, $i18
.count b_cont
	b       be_cont.39149
be_else.39153:
	store   $f24, [min_caml_solver_dist + 0]
	li      1, $i18
.count b_cont
	b       be_cont.39149
be_else.39149:
	load    [$i18 + 0], $f22
	bne     $i20, 2, be_else.39161
be_then.39161:
	bg      $f0, $f22, ble_else.39162
ble_then.39162:
	li      0, $i18
.count b_cont
	b       be_cont.39161
ble_else.39162:
	load    [$i18 + 1], $f22
	fmul    $f22, $f19, $f19
	load    [$i18 + 2], $f22
	fmul    $f22, $f20, $f20
	fadd    $f19, $f20, $f19
	load    [$i18 + 3], $f20
	fmul    $f20, $f21, $f20
	fadd    $f19, $f20, $f19
	store   $f19, [min_caml_solver_dist + 0]
	li      1, $i18
.count b_cont
	b       be_cont.39161
be_else.39161:
	bne     $f22, $f0, be_else.39163
be_then.39163:
	li      0, $i18
.count b_cont
	b       be_cont.39163
be_else.39163:
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
	bne     $i21, 0, be_else.39164
be_then.39164:
	mov     $f25, $f19
.count b_cont
	b       be_cont.39164
be_else.39164:
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
be_cont.39164:
	bne     $i20, 3, be_cont.39165
be_then.39165:
.count load_float
	load    [f.34799], $f20
	fsub    $f19, $f20, $f19
be_cont.39165:
	fmul    $f22, $f19, $f19
	fsub    $f24, $f19, $f19
	bg      $f19, $f0, ble_else.39166
ble_then.39166:
	li      0, $i18
.count b_cont
	b       ble_cont.39166
ble_else.39166:
	load    [$i19 + 6], $i19
	load    [$i18 + 4], $f20
	li      1, $i18
	fsqrt   $f19, $f19
	bne     $i19, 0, be_else.39167
be_then.39167:
	fsub    $f23, $f19, $f19
	fmul    $f19, $f20, $f19
	store   $f19, [min_caml_solver_dist + 0]
.count b_cont
	b       be_cont.39167
be_else.39167:
	fadd    $f23, $f19, $f19
	fmul    $f19, $f20, $f19
	store   $f19, [min_caml_solver_dist + 0]
be_cont.39167:
ble_cont.39166:
be_cont.39163:
be_cont.39161:
be_cont.39149:
	bne     $i18, 0, be_else.39168
be_then.39168:
	li      0, $i10
.count b_cont
	b       be_cont.39168
be_else.39168:
.count load_float
	load    [f.34802], $f19
	load    [min_caml_solver_dist + 0], $f20
	bg      $f19, $f20, ble_else.39169
ble_then.39169:
	li      0, $i10
.count b_cont
	b       ble_cont.39169
ble_else.39169:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39170
be_then.39170:
	li      0, $i10
.count b_cont
	b       be_cont.39170
be_else.39170:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39171
be_then.39171:
	li      2, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i10
	bne     $i10, 0, be_else.39172
be_then.39172:
	li      0, $i10
.count b_cont
	b       be_cont.39171
be_else.39172:
	li      1, $i10
.count b_cont
	b       be_cont.39171
be_else.39171:
	li      1, $i10
be_cont.39171:
be_cont.39170:
ble_cont.39169:
be_cont.39168:
be_cont.39148:
	bne     $i10, 0, be_else.39173
be_then.39173:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.39174
be_then.39174:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.39174:
.count stack_store
	store   $i12, [$sp + 4]
.count stack_store
	store   $i10, [$sp + 5]
	bne     $i2, 99, be_else.39175
be_then.39175:
	li      1, $i17
.count b_cont
	b       be_cont.39175
be_else.39175:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39176
be_then.39176:
	li      0, $i17
.count b_cont
	b       be_cont.39176
be_else.39176:
.count load_float
	load    [f.34802], $f19
	load    [min_caml_solver_dist + 0], $f20
	bg      $f19, $f20, ble_else.39177
ble_then.39177:
	li      0, $i17
.count b_cont
	b       ble_cont.39177
ble_else.39177:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.39178
be_then.39178:
	li      0, $i17
.count b_cont
	b       be_cont.39178
be_else.39178:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39179
be_then.39179:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39180
be_then.39180:
	li      0, $i17
.count b_cont
	b       be_cont.39179
be_else.39180:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39181
be_then.39181:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39182
be_then.39182:
	li      0, $i17
.count b_cont
	b       be_cont.39179
be_else.39182:
	li      1, $i17
.count b_cont
	b       be_cont.39179
be_else.39181:
	li      1, $i17
.count b_cont
	b       be_cont.39179
be_else.39179:
	li      1, $i17
be_cont.39179:
be_cont.39178:
ble_cont.39177:
be_cont.39176:
be_cont.39175:
	bne     $i17, 0, be_else.39183
be_then.39183:
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
be_else.39183:
.count stack_load
	load    [$sp + 4], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39184
be_then.39184:
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
be_else.39184:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39185
be_then.39185:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39186
be_then.39186:
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
be_else.39186:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39187
be_then.39187:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.39188
be_then.39188:
.count stack_load
	load    [$sp - 3], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39188:
	li      1, $i1
	ret
be_else.39187:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39185:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39173:
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39189
be_then.39189:
	li      0, $i10
.count b_cont
	b       be_cont.39189
be_else.39189:
	load    [min_caml_and_net + $i18], $i3
	li      0, $i2
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39190
be_then.39190:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39191
be_then.39191:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39191:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39192
be_then.39192:
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.39193
be_then.39193:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39193:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39194
be_then.39194:
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.39195
be_then.39195:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39195:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39196
be_then.39196:
	load    [$i17 + 5], $i18
	bne     $i18, -1, be_else.39197
be_then.39197:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39197:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39198
be_then.39198:
	load    [$i17 + 6], $i18
	bne     $i18, -1, be_else.39199
be_then.39199:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39199:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39200
be_then.39200:
	load    [$i17 + 7], $i18
	bne     $i18, -1, be_else.39201
be_then.39201:
	li      0, $i10
.count b_cont
	b       be_cont.39190
be_else.39201:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39202
be_then.39202:
	li      8, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39190
be_else.39202:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39200:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39198:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39196:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39194:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39192:
	li      1, $i10
.count b_cont
	b       be_cont.39190
be_else.39190:
	li      1, $i10
be_cont.39190:
be_cont.39189:
	bne     $i10, 0, be_else.39203
be_then.39203:
.count stack_load
	load    [$sp + 3], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 2], $i11
	load    [$i11 + $i10], $i12
	load    [$i12 + 0], $i2
	bne     $i2, -1, be_else.39204
be_then.39204:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      0, $i1
	ret
be_else.39204:
.count stack_store
	store   $i12, [$sp + 6]
.count stack_store
	store   $i10, [$sp + 7]
	bne     $i2, 99, be_else.39205
be_then.39205:
	li      1, $i17
.count b_cont
	b       be_cont.39205
be_else.39205:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39206
be_then.39206:
	li      0, $i17
.count b_cont
	b       be_cont.39206
be_else.39206:
.count load_float
	load    [f.34802], $f19
	load    [min_caml_solver_dist + 0], $f20
	bg      $f19, $f20, ble_else.39207
ble_then.39207:
	li      0, $i17
.count b_cont
	b       ble_cont.39207
ble_else.39207:
	load    [$i12 + 1], $i17
	bne     $i17, -1, be_else.39208
be_then.39208:
	li      0, $i17
.count b_cont
	b       be_cont.39208
be_else.39208:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39209
be_then.39209:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39210
be_then.39210:
	li      0, $i17
.count b_cont
	b       be_cont.39209
be_else.39210:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39211
be_then.39211:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39212
be_then.39212:
	li      0, $i17
.count b_cont
	b       be_cont.39209
be_else.39212:
	li      1, $i17
.count b_cont
	b       be_cont.39209
be_else.39211:
	li      1, $i17
.count b_cont
	b       be_cont.39209
be_else.39209:
	li      1, $i17
be_cont.39209:
be_cont.39208:
ble_cont.39207:
be_cont.39206:
be_cont.39205:
	bne     $i17, 0, be_else.39213
be_then.39213:
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
be_else.39213:
.count stack_load
	load    [$sp + 6], $i17
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39214
be_then.39214:
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
be_else.39214:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39215
be_then.39215:
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39216
be_then.39216:
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
be_else.39216:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39217
be_then.39217:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	bne     $i1, 0, be_else.39218
be_then.39218:
.count stack_load
	load    [$sp - 1], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $i3
	b       shadow_check_one_or_matrix.2947
be_else.39218:
	li      1, $i1
	ret
be_else.39217:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39215:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
	li      1, $i1
	ret
be_else.39203:
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
	bne     $i10, -1, be_else.39219
be_then.39219:
	ret
be_else.39219:
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
	bne     $i15, 1, be_else.39220
be_then.39220:
	bne     $f13, $f0, be_else.39221
be_then.39221:
	li      0, $i12
.count b_cont
	b       be_cont.39221
be_else.39221:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.39222
ble_then.39222:
	li      0, $i14
.count b_cont
	b       ble_cont.39222
ble_else.39222:
	li      1, $i14
ble_cont.39222:
	bne     $i13, 0, be_else.39223
be_then.39223:
	mov     $i14, $i13
.count b_cont
	b       be_cont.39223
be_else.39223:
	bne     $i14, 0, be_else.39224
be_then.39224:
	li      1, $i13
.count b_cont
	b       be_cont.39224
be_else.39224:
	li      0, $i13
be_cont.39224:
be_cont.39223:
	load    [$i12 + 0], $f14
	bne     $i13, 0, be_cont.39225
be_then.39225:
	fneg    $f14, $f14
be_cont.39225:
	fsub    $f14, $f10, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 1], $f14
	load    [$i4 + 1], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f11, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39226
ble_then.39226:
	li      0, $i12
.count b_cont
	b       ble_cont.39226
ble_else.39226:
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f12, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39227
ble_then.39227:
	li      0, $i12
.count b_cont
	b       ble_cont.39227
ble_else.39227:
	store   $f13, [min_caml_solver_dist + 0]
	li      1, $i12
ble_cont.39227:
ble_cont.39226:
be_cont.39221:
	bne     $i12, 0, be_else.39228
be_then.39228:
	load    [$i4 + 1], $f13
	bne     $f13, $f0, be_else.39229
be_then.39229:
	li      0, $i12
.count b_cont
	b       be_cont.39229
be_else.39229:
	load    [$i11 + 4], $i12
	load    [$i11 + 6], $i13
	bg      $f0, $f13, ble_else.39230
ble_then.39230:
	li      0, $i14
.count b_cont
	b       ble_cont.39230
ble_else.39230:
	li      1, $i14
ble_cont.39230:
	bne     $i13, 0, be_else.39231
be_then.39231:
	mov     $i14, $i13
.count b_cont
	b       be_cont.39231
be_else.39231:
	bne     $i14, 0, be_else.39232
be_then.39232:
	li      1, $i13
.count b_cont
	b       be_cont.39232
be_else.39232:
	li      0, $i13
be_cont.39232:
be_cont.39231:
	load    [$i12 + 1], $f14
	bne     $i13, 0, be_cont.39233
be_then.39233:
	fneg    $f14, $f14
be_cont.39233:
	fsub    $f14, $f11, $f14
	finv    $f13, $f13
	fmul    $f14, $f13, $f13
	load    [$i12 + 2], $f14
	load    [$i4 + 2], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f12, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39234
ble_then.39234:
	li      0, $i12
.count b_cont
	b       ble_cont.39234
ble_else.39234:
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	fmul    $f13, $f15, $f15
	fadd    $f15, $f10, $f15
	fabs    $f15, $f15
	bg      $f14, $f15, ble_else.39235
ble_then.39235:
	li      0, $i12
.count b_cont
	b       ble_cont.39235
ble_else.39235:
	store   $f13, [min_caml_solver_dist + 0]
	li      1, $i12
ble_cont.39235:
ble_cont.39234:
be_cont.39229:
	bne     $i12, 0, be_else.39236
be_then.39236:
	load    [$i4 + 2], $f13
	bne     $f13, $f0, be_else.39237
be_then.39237:
	li      0, $i11
.count b_cont
	b       be_cont.39220
be_else.39237:
	load    [$i11 + 4], $i12
	load    [$i12 + 0], $f14
	load    [$i4 + 0], $f15
	load    [$i11 + 6], $i11
	bg      $f0, $f13, ble_else.39238
ble_then.39238:
	li      0, $i13
.count b_cont
	b       ble_cont.39238
ble_else.39238:
	li      1, $i13
ble_cont.39238:
	bne     $i11, 0, be_else.39239
be_then.39239:
	mov     $i13, $i11
.count b_cont
	b       be_cont.39239
be_else.39239:
	bne     $i13, 0, be_else.39240
be_then.39240:
	li      1, $i11
.count b_cont
	b       be_cont.39240
be_else.39240:
	li      0, $i11
be_cont.39240:
be_cont.39239:
	load    [$i12 + 2], $f16
	bne     $i11, 0, be_cont.39241
be_then.39241:
	fneg    $f16, $f16
be_cont.39241:
	fsub    $f16, $f12, $f12
	finv    $f13, $f13
	fmul    $f12, $f13, $f12
	fmul    $f12, $f15, $f13
	fadd    $f13, $f10, $f10
	fabs    $f10, $f10
	bg      $f14, $f10, ble_else.39242
ble_then.39242:
	li      0, $i11
.count b_cont
	b       be_cont.39220
ble_else.39242:
	load    [$i12 + 1], $f10
	load    [$i4 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.39243
ble_then.39243:
	li      0, $i11
.count b_cont
	b       be_cont.39220
ble_else.39243:
	store   $f12, [min_caml_solver_dist + 0]
	li      3, $i11
.count b_cont
	b       be_cont.39220
be_else.39236:
	li      2, $i11
.count b_cont
	b       be_cont.39220
be_else.39228:
	li      1, $i11
.count b_cont
	b       be_cont.39220
be_else.39220:
	bne     $i15, 2, be_else.39244
be_then.39244:
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
	bg      $f13, $f0, ble_else.39245
ble_then.39245:
	li      0, $i11
.count b_cont
	b       be_cont.39244
ble_else.39245:
	fmul    $f14, $f10, $f10
	fmul    $f16, $f11, $f11
	fadd    $f10, $f11, $f10
	fmul    $f17, $f12, $f11
	fadd    $f10, $f11, $f10
	fneg    $f10, $f10
	finv    $f13, $f11
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39244
be_else.39244:
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
	be      $i12, 0, bne_cont.39246
bne_then.39246:
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
bne_cont.39246:
	bne     $f16, $f0, be_else.39247
be_then.39247:
	li      0, $i11
.count b_cont
	b       be_cont.39247
be_else.39247:
	load    [$i11 + 1], $i13
	fmul    $f13, $f10, $f18
	fmul    $f18, $f17, $f18
	fmul    $f14, $f11, $f21
	fmul    $f21, $f19, $f21
	fadd    $f18, $f21, $f18
	fmul    $f15, $f12, $f21
	fmul    $f21, $f20, $f21
	fadd    $f18, $f21, $f18
	bne     $i12, 0, be_else.39248
be_then.39248:
	mov     $f18, $f13
.count b_cont
	b       be_cont.39248
be_else.39248:
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
.count load_float
	load    [f.34775], $f14
	fmul    $f13, $f14, $f13
	fadd    $f18, $f13, $f13
be_cont.39248:
	fmul    $f13, $f13, $f14
	fmul    $f10, $f10, $f15
	fmul    $f15, $f17, $f15
	fmul    $f11, $f11, $f17
	fmul    $f17, $f19, $f17
	fadd    $f15, $f17, $f15
	fmul    $f12, $f12, $f17
	fmul    $f17, $f20, $f17
	fadd    $f15, $f17, $f15
	bne     $i12, 0, be_else.39249
be_then.39249:
	mov     $f15, $f10
.count b_cont
	b       be_cont.39249
be_else.39249:
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
be_cont.39249:
	bne     $i13, 3, be_cont.39250
be_then.39250:
.count load_float
	load    [f.34799], $f11
	fsub    $f10, $f11, $f10
be_cont.39250:
	fmul    $f16, $f10, $f10
	fsub    $f14, $f10, $f10
	bg      $f10, $f0, ble_else.39251
ble_then.39251:
	li      0, $i11
.count b_cont
	b       ble_cont.39251
ble_else.39251:
	load    [$i11 + 6], $i11
	fsqrt   $f10, $f10
	finv    $f16, $f11
	bne     $i11, 0, be_else.39252
be_then.39252:
	fneg    $f10, $f10
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39252
be_else.39252:
	fsub    $f10, $f13, $f10
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
be_cont.39252:
ble_cont.39251:
be_cont.39247:
be_cont.39244:
be_cont.39220:
	bne     $i11, 0, be_else.39253
be_then.39253:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39254
be_then.39254:
	ret
be_else.39254:
	add     $i2, 1, $i2
	b       solve_each_element.2950
be_else.39253:
	load    [min_caml_solver_dist + 0], $f10
	bg      $f10, $f0, ble_else.39255
ble_then.39255:
	add     $i2, 1, $i2
	b       solve_each_element.2950
ble_else.39255:
	load    [min_caml_tmin + 0], $f11
	bg      $f11, $f10, ble_else.39256
ble_then.39256:
	add     $i2, 1, $i2
	b       solve_each_element.2950
ble_else.39256:
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
	load    [$i4 + 0], $f11
.count load_float
	load    [f.34801], $f12
	fadd    $f10, $f12, $f10
	fmul    $f11, $f10, $f11
	load    [min_caml_startp + 0], $f12
	fadd    $f11, $f12, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i4 + 1], $f11
	fmul    $f11, $f10, $f11
	load    [min_caml_startp + 1], $f12
	fadd    $f11, $f12, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i4 + 2], $f11
	fmul    $f11, $f10, $f11
	load    [min_caml_startp + 2], $f12
	fadd    $f11, $f12, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2935
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.39257
be_then.39257:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element.2950
be_else.39257:
	store   $f10, [min_caml_tmin + 0]
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
	store   $i10, [min_caml_intersected_object_id + 0]
	store   $i11, [min_caml_intsec_rectside + 0]
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
	bne     $i16, -1, be_else.39258
be_then.39258:
	ret
be_else.39258:
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
	bne     $i18, -1, be_else.39259
be_then.39259:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39259:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39260
be_then.39260:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39260:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39261
be_then.39261:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39261:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39262
be_then.39262:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39262:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39263
be_then.39263:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39263:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39264
be_then.39264:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39264:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	add     $i16, 1, $i16
	load    [$i17 + $i16], $i18
	bne     $i18, -1, be_else.39265
be_then.39265:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39265:
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
	bne     $i17, -1, be_else.39266
be_then.39266:
	ret
be_else.39266:
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
	bne     $i17, 99, be_else.39267
be_then.39267:
	load    [$i16 + 1], $i17
	be      $i17, -1, bne_cont.39268
bne_then.39268:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    solve_each_element.2950
	load    [$i16 + 2], $i17
	be      $i17, -1, bne_cont.39269
bne_then.39269:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 3], $i17
	be      $i17, -1, bne_cont.39270
bne_then.39270:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 4], $i17
	be      $i17, -1, bne_cont.39271
bne_then.39271:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 5], $i17
	be      $i17, -1, bne_cont.39272
bne_then.39272:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i16 + 6], $i17
	be      $i17, -1, bne_cont.39273
bne_then.39273:
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
bne_cont.39273:
bne_cont.39272:
bne_cont.39271:
bne_cont.39270:
bne_cont.39269:
bne_cont.39268:
.count stack_load
	load    [$sp + 3], $i16
	add     $i16, 1, $i16
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i16], $i17
	load    [$i17 + 0], $i18
	bne     $i18, -1, be_else.39274
be_then.39274:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.39274:
	bne     $i18, 99, be_else.39275
be_then.39275:
	load    [$i17 + 1], $i18
	bne     $i18, -1, be_else.39276
be_then.39276:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i16, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix.2958
be_else.39276:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39277
be_then.39277:
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
be_else.39277:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 3], $i18
	bne     $i18, -1, be_else.39278
be_then.39278:
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
be_else.39278:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element.2950
	load    [$i17 + 4], $i18
	bne     $i18, -1, be_else.39279
be_then.39279:
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
be_else.39279:
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
be_else.39275:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i18, $i2
	call    solver.2852
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39280
be_then.39280:
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
be_else.39280:
	load    [min_caml_tmin + 0], $f23
	load    [min_caml_solver_dist + 0], $f24
	bg      $f23, $f24, ble_else.39281
ble_then.39281:
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
ble_else.39281:
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
be_else.39267:
.count move_args
	mov     $i17, $i2
.count move_args
	mov     $i4, $i3
	call    solver.2852
.count move_ret
	mov     $i1, $i19
	bne     $i19, 0, be_else.39282
be_then.39282:
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
be_else.39282:
	load    [min_caml_tmin + 0], $f23
	load    [min_caml_solver_dist + 0], $f24
	bg      $f23, $f24, ble_else.39283
ble_then.39283:
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
ble_else.39283:
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
	bne     $i10, -1, be_else.39284
be_then.39284:
	ret
be_else.39284:
	load    [min_caml_objects + $i10], $i11
	load    [$i11 + 10], $i12
	load    [$i4 + 1], $i13
	load    [$i11 + 1], $i14
	load    [$i12 + 0], $f10
	load    [$i12 + 1], $f11
	load    [$i12 + 2], $f12
	load    [$i13 + $i10], $i13
	bne     $i14, 1, be_else.39285
be_then.39285:
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
	bg      $f13, $f14, ble_else.39286
ble_then.39286:
	li      0, $i14
.count b_cont
	b       ble_cont.39286
ble_else.39286:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39287
ble_then.39287:
	li      0, $i14
.count b_cont
	b       ble_cont.39287
ble_else.39287:
	load    [$i13 + 1], $f13
	bne     $f13, $f0, be_else.39288
be_then.39288:
	li      0, $i14
.count b_cont
	b       be_cont.39288
be_else.39288:
	li      1, $i14
be_cont.39288:
ble_cont.39287:
ble_cont.39286:
	bne     $i14, 0, be_else.39289
be_then.39289:
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
	bg      $f13, $f14, ble_else.39290
ble_then.39290:
	li      0, $i14
.count b_cont
	b       ble_cont.39290
ble_else.39290:
	load    [$i11 + 4], $i14
	load    [$i14 + 2], $f13
	load    [$i12 + 2], $f14
	fmul    $f15, $f14, $f14
	fadd    $f14, $f12, $f14
	fabs    $f14, $f14
	bg      $f13, $f14, ble_else.39291
ble_then.39291:
	li      0, $i14
.count b_cont
	b       ble_cont.39291
ble_else.39291:
	load    [$i13 + 3], $f13
	bne     $f13, $f0, be_else.39292
be_then.39292:
	li      0, $i14
.count b_cont
	b       be_cont.39292
be_else.39292:
	li      1, $i14
be_cont.39292:
ble_cont.39291:
ble_cont.39290:
	bne     $i14, 0, be_else.39293
be_then.39293:
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
	bg      $f13, $f10, ble_else.39294
ble_then.39294:
	li      0, $i11
.count b_cont
	b       be_cont.39285
ble_else.39294:
	load    [$i11 + 4], $i11
	load    [$i11 + 1], $f10
	load    [$i12 + 1], $f13
	fmul    $f12, $f13, $f13
	fadd    $f13, $f11, $f11
	fabs    $f11, $f11
	bg      $f10, $f11, ble_else.39295
ble_then.39295:
	li      0, $i11
.count b_cont
	b       be_cont.39285
ble_else.39295:
	load    [$i13 + 5], $f10
	bne     $f10, $f0, be_else.39296
be_then.39296:
	li      0, $i11
.count b_cont
	b       be_cont.39285
be_else.39296:
	store   $f12, [min_caml_solver_dist + 0]
	li      3, $i11
.count b_cont
	b       be_cont.39285
be_else.39293:
	store   $f15, [min_caml_solver_dist + 0]
	li      2, $i11
.count b_cont
	b       be_cont.39285
be_else.39289:
	store   $f15, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39285
be_else.39285:
	bne     $i14, 2, be_else.39297
be_then.39297:
	load    [$i13 + 0], $f10
	bg      $f0, $f10, ble_else.39298
ble_then.39298:
	li      0, $i11
.count b_cont
	b       be_cont.39297
ble_else.39298:
	load    [$i12 + 3], $f11
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39297
be_else.39297:
	load    [$i13 + 0], $f13
	bne     $f13, $f0, be_else.39299
be_then.39299:
	li      0, $i11
.count b_cont
	b       be_cont.39299
be_else.39299:
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
	bg      $f11, $f0, ble_else.39300
ble_then.39300:
	li      0, $i11
.count b_cont
	b       ble_cont.39300
ble_else.39300:
	load    [$i11 + 6], $i11
	fsqrt   $f11, $f11
	bne     $i11, 0, be_else.39301
be_then.39301:
	fsub    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
.count b_cont
	b       be_cont.39301
be_else.39301:
	fadd    $f10, $f11, $f10
	load    [$i13 + 4], $f11
	fmul    $f10, $f11, $f10
	store   $f10, [min_caml_solver_dist + 0]
	li      1, $i11
be_cont.39301:
ble_cont.39300:
be_cont.39299:
be_cont.39297:
be_cont.39285:
	bne     $i11, 0, be_else.39302
be_then.39302:
	load    [min_caml_objects + $i10], $i1
	load    [$i1 + 6], $i1
	bne     $i1, 0, be_else.39303
be_then.39303:
	ret
be_else.39303:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
be_else.39302:
	load    [min_caml_solver_dist + 0], $f10
	bg      $f10, $f0, ble_else.39304
ble_then.39304:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
ble_else.39304:
	load    [$i4 + 0], $i12
	load    [min_caml_tmin + 0], $f11
	bg      $f11, $f10, ble_else.39305
ble_then.39305:
	add     $i2, 1, $i2
	b       solve_each_element_fast.2964
ble_else.39305:
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
	load    [$i12 + 0], $f11
.count load_float
	load    [f.34801], $f12
	fadd    $f10, $f12, $f10
	fmul    $f11, $f10, $f11
	load    [min_caml_startp_fast + 0], $f12
	fadd    $f11, $f12, $f2
.count stack_store
	store   $f2, [$sp + 4]
	load    [$i12 + 1], $f11
	fmul    $f11, $f10, $f11
	load    [min_caml_startp_fast + 1], $f12
	fadd    $f11, $f12, $f3
.count stack_store
	store   $f3, [$sp + 5]
	load    [$i12 + 2], $f11
	fmul    $f11, $f10, $f11
	load    [min_caml_startp_fast + 2], $f12
	fadd    $f11, $f12, $f4
.count stack_store
	store   $f4, [$sp + 6]
	call    check_all_inside.2935
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.39306
be_then.39306:
.count stack_load
	load    [$sp - 4], $i1
	add     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       solve_each_element_fast.2964
be_else.39306:
	store   $f10, [min_caml_tmin + 0]
.count stack_load
	load    [$sp - 3], $i1
	store   $i1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $i1
	store   $i1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $i1
	store   $i1, [min_caml_intersection_point + 2]
	store   $i10, [min_caml_intersected_object_id + 0]
	store   $i11, [min_caml_intsec_rectside + 0]
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
	bne     $i15, -1, be_else.39307
be_then.39307:
	ret
be_else.39307:
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
	bne     $i17, -1, be_else.39308
be_then.39308:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39308:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39309
be_then.39309:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39309:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39310
be_then.39310:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39310:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39311
be_then.39311:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39311:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39312
be_then.39312:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39312:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39313
be_then.39313:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39313:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	add     $i15, 1, $i15
	load    [$i16 + $i15], $i17
	bne     $i17, -1, be_else.39314
be_then.39314:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.39314:
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
	bne     $i16, -1, be_else.39315
be_then.39315:
	ret
be_else.39315:
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
	bne     $i16, 99, be_else.39316
be_then.39316:
	load    [$i15 + 1], $i16
	be      $i16, -1, bne_cont.39317
bne_then.39317:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
	call    solve_each_element_fast.2964
	load    [$i15 + 2], $i16
	be      $i16, -1, bne_cont.39318
bne_then.39318:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 3], $i16
	be      $i16, -1, bne_cont.39319
bne_then.39319:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 4], $i16
	be      $i16, -1, bne_cont.39320
bne_then.39320:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 5], $i16
	be      $i16, -1, bne_cont.39321
bne_then.39321:
	li      0, $i2
	load    [min_caml_and_net + $i16], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i15 + 6], $i16
	be      $i16, -1, bne_cont.39322
bne_then.39322:
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
bne_cont.39322:
bne_cont.39321:
bne_cont.39320:
bne_cont.39319:
bne_cont.39318:
bne_cont.39317:
.count stack_load
	load    [$sp + 3], $i15
	add     $i15, 1, $i15
.count stack_load
	load    [$sp + 2], $i3
	load    [$i3 + $i15], $i16
	load    [$i16 + 0], $i17
	bne     $i17, -1, be_else.39323
be_then.39323:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.39323:
	bne     $i17, 99, be_else.39324
be_then.39324:
	load    [$i16 + 1], $i17
	bne     $i17, -1, be_else.39325
be_then.39325:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	add     $i15, 1, $i2
.count stack_load
	load    [$sp - 4], $i4
	b       trace_or_matrix_fast.2972
be_else.39325:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 2], $i17
	bne     $i17, -1, be_else.39326
be_then.39326:
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
be_else.39326:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 3], $i17
	bne     $i17, -1, be_else.39327
be_then.39327:
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
be_else.39327:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
.count stack_load
	load    [$sp + 1], $i4
	call    solve_each_element_fast.2964
	load    [$i16 + 4], $i17
	bne     $i17, -1, be_else.39328
be_then.39328:
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
be_else.39328:
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
be_else.39324:
.count stack_load
	load    [$sp + 1], $i3
.count move_args
	mov     $i17, $i2
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39329
be_then.39329:
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
be_else.39329:
	load    [min_caml_tmin + 0], $f17
	load    [min_caml_solver_dist + 0], $f18
	bg      $f17, $f18, ble_else.39330
ble_then.39330:
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
ble_else.39330:
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
be_else.39316:
.count move_args
	mov     $i16, $i2
.count move_args
	mov     $i4, $i3
	call    solver_fast2.2893
.count move_ret
	mov     $i1, $i18
	bne     $i18, 0, be_else.39331
be_then.39331:
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
be_else.39331:
	load    [min_caml_tmin + 0], $f17
	load    [min_caml_solver_dist + 0], $f18
	bg      $f17, $f18, ble_else.39332
ble_then.39332:
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
ble_else.39332:
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
	bne     $i2, 25, be_else.39333
be_then.39333:
	mov     $f4, $f1
	ret
be_else.39333:
	fmul    $f5, $f3, $f1
	add     $i2, 1, $i1
	bg      $f3, $f0, ble_else.39334
ble_then.39334:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fsub    $f4, $f3, $f3
.count load_float
	load    [f.34775], $f4
	fmul    $f5, $f4, $f5
	bne     $i1, 25, be_else.39335
be_then.39335:
	mov     $f3, $f1
	ret
be_else.39335:
	fmul    $f5, $f2, $f6
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39336
ble_then.39336:
	fsub    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8520
ble_else.39336:
	fadd    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8520
ble_else.39334:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fadd    $f4, $f3, $f3
.count load_float
	load    [f.34775], $f4
	fmul    $f5, $f4, $f5
	bne     $i1, 25, be_else.39337
be_then.39337:
	mov     $f3, $f1
	ret
be_else.39337:
	fmul    $f5, $f2, $f6
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39338
ble_then.39338:
	fsub    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8520
ble_else.39338:
	fadd    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8520
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6377.8578:
	bne     $i2, 25, be_else.39339
be_then.39339:
	mov     $f4, $f1
	ret
be_else.39339:
	fmul    $f5, $f3, $f1
	add     $i2, 1, $i1
	bg      $f3, $f0, ble_else.39340
ble_then.39340:
	fsub    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fsub    $f4, $f3, $f3
.count load_float
	load    [f.34775], $f4
	fmul    $f5, $f4, $f5
	bne     $i1, 25, be_else.39341
be_then.39341:
	mov     $f3, $f1
	ret
be_else.39341:
	fmul    $f5, $f2, $f6
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39342
ble_then.39342:
	fsub    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8578
ble_else.39342:
	fadd    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8578
ble_else.39340:
	fadd    $f2, $f1, $f1
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
	load    [min_caml_atan_table + $i2], $f3
	fadd    $f4, $f3, $f3
.count load_float
	load    [f.34775], $f4
	fmul    $f5, $f4, $f5
	bne     $i1, 25, be_else.39343
be_then.39343:
	mov     $f3, $f1
	ret
be_else.39343:
	fmul    $f5, $f2, $f6
	add     $i1, 1, $i2
	bg      $f2, $f0, ble_else.39344
ble_then.39344:
	fsub    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fadd    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fsub    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8578
ble_else.39344:
	fadd    $f1, $f6, $f6
	fmul    $f5, $f1, $f1
	fsub    $f2, $f1, $f1
	load    [min_caml_atan_table + $i1], $f2
	fadd    $f3, $f2, $f2
	fmul    $f5, $f4, $f5
.count move_args
	mov     $f1, $f3
.count move_args
	mov     $f2, $f4
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.8578
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.27406:
	bne     $i2, 25, be_else.39345
be_then.39345:
	mov     $f4, $f1
	ret
be_else.39345:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39346
ble_then.39346:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39347
be_then.39347:
	ret
be_else.39347:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39348
ble_then.39348:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.27406
ble_else.39348:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.27406
ble_else.39346:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39349
be_then.39349:
	ret
be_else.39349:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39350
ble_then.39350:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.27406
ble_else.39350:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.27406
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.31997:
	bne     $i2, 25, be_else.39351
be_then.39351:
	mov     $f4, $f1
	ret
be_else.39351:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39352
ble_then.39352:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39353
be_then.39353:
	ret
be_else.39353:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39354
ble_then.39354:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.31997
ble_else.39354:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.31997
ble_else.39352:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39355
be_then.39355:
	ret
be_else.39355:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39356
ble_then.39356:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.31997
ble_else.39356:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.31997
.end cordic_rec

######################################################################
.begin utexture
utexture.2987:
	load    [$i2 + 8], $i1
	load    [$i1 + 0], $f10
	store   $f10, [min_caml_texture_color + 0]
	load    [$i2 + 8], $i1
	load    [$i1 + 1], $f10
	store   $f10, [min_caml_texture_color + 1]
	load    [$i2 + 8], $i1
	load    [$i1 + 2], $f10
	store   $f10, [min_caml_texture_color + 2]
	load    [$i2 + 0], $i1
	bne     $i1, 1, be_else.39357
be_then.39357:
.count stack_move
	sub     $sp, 6, $sp
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
	add     $sp, 6, $sp
	fmul    $f1, $f13, $f1
	fsub    $f11, $f1, $f1
	bg      $f14, $f10, ble_else.39358
ble_then.39358:
	li      0, $i1
.count b_cont
	b       ble_cont.39358
ble_else.39358:
	li      1, $i1
ble_cont.39358:
	bg      $f14, $f1, ble_else.39359
ble_then.39359:
	bne     $i1, 0, be_else.39360
be_then.39360:
.count load_float
	load    [f.34809], $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
be_else.39360:
	store   $f0, [min_caml_texture_color + 1]
	ret
ble_else.39359:
	bne     $i1, 0, be_else.39361
be_then.39361:
	store   $f0, [min_caml_texture_color + 1]
	ret
be_else.39361:
.count load_float
	load    [f.34809], $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
be_else.39357:
	bne     $i1, 2, be_else.39362
be_then.39362:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
	load    [min_caml_intersection_point + 1], $f14
.count load_float
	load    [f.34812], $f15
	fmul    $f14, $f15, $f14
.count load_float
	load    [f.34809], $f15
	bg      $f0, $f14, ble_else.39363
ble_then.39363:
.count load_float
	load    [f.34777], $f16
	bg      $f16, $f14, ble_else.39364
ble_then.39364:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.39365
ble_then.39365:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.39366
ble_then.39366:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39366:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fneg    $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39365:
	fsub    $f16, $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.39367
ble_then.39367:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.31997
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39367:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.31997
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39364:
.count move_args
	mov     $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f14, $f0, ble_else.39368
ble_then.39368:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.27406
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39368:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.27406
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
ble_else.39363:
	fneg    $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	fneg    $f1, $f1
	fmul    $f1, $f1, $f1
	fmul    $f15, $f1, $f2
	store   $f2, [min_caml_texture_color + 0]
.count load_float
	load    [f.34799], $f2
	fsub    $f2, $f1, $f1
	fmul    $f15, $f1, $f1
	store   $f1, [min_caml_texture_color + 1]
	ret
be_else.39362:
	bne     $i1, 3, be_else.39369
be_then.39369:
.count stack_move
	sub     $sp, 6, $sp
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
	add     $sp, 6, $sp
	fmul    $f1, $f1, $f1
.count stack_load
	load    [$sp - 5], $f2
	fmul    $f1, $f2, $f3
	store   $f3, [min_caml_texture_color + 1]
.count load_float
	load    [f.34799], $f3
	fsub    $f3, $f1, $f1
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_texture_color + 2]
	ret
be_else.39369:
	bne     $i1, 4, be_else.39370
be_then.39370:
.count stack_move
	sub     $sp, 6, $sp
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
	load    [f.34775], $f5
.count stack_store
	store   $f5, [$sp + 3]
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
	bg      $f11, $f13, ble_else.39371
ble_then.39371:
	finv    $f12, $f13
	fmul    $f14, $f13, $f13
	fabs    $f13, $f13
.count load_float
	load    [f.34799], $f15
	li      1, $i2
	bg      $f13, $f0, ble_else.39372
ble_then.39372:
	fsub    $f15, $f13, $f2
	fadd    $f13, $f15, $f3
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
	fmul    $f13, $f15, $f13
.count b_cont
	b       ble_cont.39371
ble_else.39372:
	fadd    $f15, $f13, $f2
	fsub    $f13, $f15, $f3
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
	fmul    $f13, $f15, $f13
.count b_cont
	b       ble_cont.39371
ble_else.39371:
.count load_float
	load    [f.34805], $f13
ble_cont.39371:
	mov     $f13, $f2
.count stack_store
	store   $f2, [$sp + 4]
	call    min_caml_floor
.count move_ret
	mov     $f1, $f13
.count stack_load
	load    [$sp + 4], $f15
	fsub    $f15, $f13, $f13
.count stack_load
	load    [$sp + 3], $f5
	fsub    $f5, $f13, $f13
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
	bg      $f11, $f13, ble_else.39373
ble_then.39373:
	finv    $f12, $f11
	fmul    $f14, $f11, $f11
	fabs    $f11, $f11
.count load_float
	load    [f.34799], $f12
	li      1, $i2
	bg      $f11, $f0, ble_else.39374
ble_then.39374:
	fsub    $f12, $f11, $f2
	fadd    $f11, $f12, $f3
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
	fmul    $f11, $f12, $f11
.count b_cont
	b       ble_cont.39373
ble_else.39374:
	fadd    $f12, $f11, $f2
	fsub    $f11, $f12, $f3
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
	fmul    $f11, $f12, $f11
.count b_cont
	b       ble_cont.39373
ble_else.39373:
.count load_float
	load    [f.34805], $f11
ble_cont.39373:
	mov     $f11, $f2
.count stack_store
	store   $f2, [$sp + 5]
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 1], $f2
	fsub    $f2, $f1, $f1
.count stack_load
	load    [$sp - 3], $f2
	fsub    $f2, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f10, $f1, $f1
	bg      $f0, $f1, ble_else.39375
ble_then.39375:
.count load_float
	load    [f.34809], $f2
	fmul    $f2, $f1, $f1
.count load_float
	load    [f.34810], $f2
	fmul    $f1, $f2, $f1
	store   $f1, [min_caml_texture_color + 2]
	ret
ble_else.39375:
	store   $f0, [min_caml_texture_color + 2]
	ret
be_else.39370:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2994:
	bl      $i2, 0, bge_else.39376
bge_then.39376:
.count stack_move
	sub     $sp, 8, $sp
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
	load    [f.34816], $f19
	store   $f19, [min_caml_tmin + 0]
	load    [min_caml_or_net + 0], $i3
	load    [$i3 + 0], $i20
	load    [$i20 + 0], $i21
	be      $i21, -1, bne_cont.39377
bne_then.39377:
	bne     $i21, 99, be_else.39378
be_then.39378:
	load    [$i20 + 1], $i21
	bne     $i21, -1, be_else.39379
be_then.39379:
	li      1, $i2
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39378
be_else.39379:
.count stack_store
	store   $i3, [$sp + 6]
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 2], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39380
be_then.39380:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39378
be_else.39380:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 3], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39381
be_then.39381:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39378
be_else.39381:
	li      0, $i2
	load    [min_caml_and_net + $i21], $i3
	call    solve_each_element_fast.2964
	load    [$i20 + 4], $i21
.count stack_load
	load    [$sp + 5], $i4
	bne     $i21, -1, be_else.39382
be_then.39382:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39378
be_else.39382:
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
	load    [$sp + 6], $i3
.count stack_load
	load    [$sp + 5], $i4
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39378
be_else.39378:
.count stack_store
	store   $i3, [$sp + 6]
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
	bne     $i21, 0, be_else.39383
be_then.39383:
.count stack_load
	load    [$sp + 6], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39383
be_else.39383:
	load    [min_caml_solver_dist + 0], $f19
	load    [min_caml_tmin + 0], $f20
	bg      $f20, $f19, ble_else.39384
ble_then.39384:
.count stack_load
	load    [$sp + 6], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       ble_cont.39384
ble_else.39384:
.count move_args
	mov     $i20, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
.count stack_load
	load    [$sp + 5], $i4
	call    trace_or_matrix_fast.2972
ble_cont.39384:
be_cont.39383:
be_cont.39378:
bne_cont.39377:
.count load_float
	load    [f.34802], $f28
	load    [min_caml_tmin + 0], $f29
	bg      $f29, $f28, ble_else.39385
ble_then.39385:
	li      0, $i22
.count b_cont
	b       ble_cont.39385
ble_else.39385:
.count load_float
	load    [f.34817], $f28
	bg      $f28, $f29, ble_else.39386
ble_then.39386:
	li      0, $i22
.count b_cont
	b       ble_cont.39386
ble_else.39386:
	li      1, $i22
ble_cont.39386:
ble_cont.39385:
	bne     $i22, 0, be_else.39387
be_then.39387:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $f2
.count stack_load
	load    [$sp - 6], $f3
.count stack_load
	load    [$sp - 7], $i3
	b       trace_reflections.2994
be_else.39387:
	load    [$i19 + 0], $i22
	load    [min_caml_intersected_object_id + 0], $i23
	add     $i23, $i23, $i23
	add     $i23, $i23, $i23
	load    [min_caml_intsec_rectside + 0], $i24
	add     $i23, $i24, $i23
	bne     $i23, $i22, be_else.39388
be_then.39388:
.count stack_store
	store   $i19, [$sp + 7]
	load    [min_caml_or_net + 0], $i3
	li      0, $i2
	call    shadow_check_one_or_matrix.2947
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 5], $f2
	bne     $i1, 0, be_else.39389
be_then.39389:
.count stack_load
	load    [$sp - 1], $i1
	load    [$i1 + 2], $f1
.count stack_load
	load    [$sp - 3], $i1
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
	ble     $f3, $f0, bg_cont.39390
bg_then.39390:
	load    [min_caml_rgb + 0], $f4
	load    [min_caml_texture_color + 0], $f6
	fmul    $f3, $f6, $f6
	fadd    $f4, $f6, $f4
	store   $f4, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f4
	load    [min_caml_texture_color + 1], $f6
	fmul    $f3, $f6, $f6
	fadd    $f4, $f6, $f4
	store   $f4, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f4
	load    [min_caml_texture_color + 2], $f6
	fmul    $f3, $f6, $f3
	fadd    $f4, $f3, $f3
	store   $f3, [min_caml_rgb + 2]
bg_cont.39390:
.count stack_load
	load    [$sp - 7], $i3
	load    [$i3 + 0], $f3
	fmul    $f3, $f5, $f3
	load    [$i3 + 1], $f4
	fmul    $f4, $f7, $f4
	fadd    $f3, $f4, $f3
	load    [$i3 + 2], $f4
	fmul    $f4, $f8, $f4
	fadd    $f3, $f4, $f3
	fmul    $f1, $f3, $f1
	bg      $f1, $f0, ble_else.39391
ble_then.39391:
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $f3
	b       trace_reflections.2994
ble_else.39391:
	load    [min_caml_rgb + 0], $f3
	fmul    $f1, $f1, $f1
	fmul    $f1, $f1, $f1
.count stack_load
	load    [$sp - 6], $f4
	fmul    $f1, $f4, $f1
	fadd    $f3, $f1, $f3
	store   $f3, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f3
	fadd    $f3, $f1, $f3
	store   $f3, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f3
	fadd    $f3, $f1, $f1
	store   $f1, [min_caml_rgb + 2]
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
.count move_args
	mov     $f4, $f3
	b       trace_reflections.2994
be_else.39389:
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 6], $f3
.count stack_load
	load    [$sp - 7], $i3
	b       trace_reflections.2994
be_else.39388:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 4], $i1
	sub     $i1, 1, $i2
.count stack_load
	load    [$sp - 5], $f2
.count stack_load
	load    [$sp - 6], $f3
.count stack_load
	load    [$sp - 7], $i3
	b       trace_reflections.2994
bge_else.39376:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2999:
	bg      $i2, 4, ble_else.39392
ble_then.39392:
.count stack_move
	sub     $sp, 11, $sp
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
	load    [f.34816], $f25
	store   $f25, [min_caml_tmin + 0]
	load    [min_caml_or_net + 0], $i20
	load    [$i20 + 0], $i21
	load    [$i21 + 0], $i22
	be      $i22, -1, bne_cont.39393
bne_then.39393:
	bne     $i22, 99, be_else.39394
be_then.39394:
	load    [$i21 + 1], $i22
.count move_args
	mov     $i3, $i4
	bne     $i22, -1, be_else.39395
be_then.39395:
	li      1, $i2
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39394
be_else.39395:
	li      0, $i2
	load    [min_caml_and_net + $i22], $i16
.count move_args
	mov     $i16, $i3
	call    solve_each_element.2950
	load    [$i21 + 2], $i22
.count stack_load
	load    [$sp + 3], $i4
	bne     $i22, -1, be_else.39396
be_then.39396:
	li      1, $i2
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39394
be_else.39396:
	li      0, $i2
	load    [min_caml_and_net + $i22], $i3
	call    solve_each_element.2950
	load    [$i21 + 3], $i22
.count stack_load
	load    [$sp + 3], $i4
	bne     $i22, -1, be_else.39397
be_then.39397:
	li      1, $i2
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39394
be_else.39397:
	li      0, $i2
	load    [min_caml_and_net + $i22], $i3
	call    solve_each_element.2950
	load    [$i21 + 4], $i22
.count stack_load
	load    [$sp + 3], $i4
	bne     $i22, -1, be_else.39398
be_then.39398:
	li      1, $i2
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39394
be_else.39398:
	li      0, $i2
	load    [min_caml_and_net + $i22], $i3
	call    solve_each_element.2950
	li      5, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i21, $i3
	call    solve_one_or_network.2954
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39394
be_else.39394:
.count move_args
	mov     $i22, $i2
	call    solver.2852
.count move_ret
	mov     $i1, $i22
.count stack_load
	load    [$sp + 3], $i4
	li      1, $i2
	bne     $i22, 0, be_else.39399
be_then.39399:
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       be_cont.39399
be_else.39399:
	load    [min_caml_solver_dist + 0], $f25
	load    [min_caml_tmin + 0], $f26
	bg      $f26, $f25, ble_else.39400
ble_then.39400:
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
.count b_cont
	b       ble_cont.39400
ble_else.39400:
.count move_args
	mov     $i21, $i3
	call    solve_one_or_network.2954
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i4
.count move_args
	mov     $i20, $i3
	call    trace_or_matrix.2958
ble_cont.39400:
be_cont.39399:
be_cont.39394:
bne_cont.39393:
.count stack_load
	load    [$sp + 5], $i16
	load    [$i16 + 2], $i17
.count load_float
	load    [f.34802], $f17
	load    [min_caml_tmin + 0], $f18
	bg      $f18, $f17, ble_else.39401
ble_then.39401:
	li      0, $i18
.count b_cont
	b       ble_cont.39401
ble_else.39401:
.count load_float
	load    [f.34817], $f19
	bg      $f19, $f18, ble_else.39402
ble_then.39402:
	li      0, $i18
.count b_cont
	b       ble_cont.39402
ble_else.39402:
	li      1, $i18
ble_cont.39402:
ble_cont.39401:
	bne     $i18, 0, be_else.39403
be_then.39403:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	add     $i0, -1, $i1
.count stack_load
	load    [$sp - 7], $i2
.count storer
	add     $i17, $i2, $tmp
	store   $i1, [$tmp + 0]
	bne     $i2, 0, be_else.39404
be_then.39404:
	ret
be_else.39404:
.count stack_load
	load    [$sp - 8], $i1
	load    [$i1 + 0], $f1
	load    [min_caml_light + 0], $f2
	fmul    $f1, $f2, $f1
	load    [$i1 + 1], $f2
	load    [min_caml_light + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    [$i1 + 2], $f2
	load    [min_caml_light + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	bg      $f1, $f0, ble_else.39405
ble_then.39405:
	ret
ble_else.39405:
	load    [min_caml_rgb + 0], $f2
	fmul    $f1, $f1, $f3
	fmul    $f3, $f1, $f1
.count stack_load
	load    [$sp - 9], $f3
	fmul    $f1, $f3, $f1
	load    [min_caml_beam + 0], $f3
	fmul    $f1, $f3, $f1
	fadd    $f2, $f1, $f2
	store   $f2, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f2
	fadd    $f2, $f1, $f2
	store   $f2, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f2
	fadd    $f2, $f1, $f1
	store   $f1, [min_caml_rgb + 2]
	ret
be_else.39403:
.count stack_store
	store   $i17, [$sp + 6]
	load    [min_caml_intersected_object_id + 0], $i18
	load    [min_caml_objects + $i18], $i2
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 1], $i19
	bne     $i19, 1, be_else.39406
be_then.39406:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $i19
	sub     $i19, 1, $i19
.count stack_load
	load    [$sp + 3], $i20
	load    [$i20 + $i19], $f18
	bne     $f18, $f0, be_else.39407
be_then.39407:
	store   $f0, [min_caml_nvector + $i19]
.count b_cont
	b       be_cont.39406
be_else.39407:
	bg      $f18, $f0, ble_else.39408
ble_then.39408:
.count load_float
	load    [f.34798], $f18
.count load_float
	load    [f.34799], $f18
	store   $f18, [min_caml_nvector + $i19]
.count b_cont
	b       be_cont.39406
ble_else.39408:
.count load_float
	load    [f.34799], $f18
.count load_float
	load    [f.34798], $f18
	store   $f18, [min_caml_nvector + $i19]
.count b_cont
	b       be_cont.39406
be_else.39406:
	bne     $i19, 2, be_else.39409
be_then.39409:
	load    [$i2 + 4], $i19
	load    [$i19 + 0], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 4], $i19
	load    [$i19 + 1], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 4], $i19
	load    [$i19 + 2], $f18
	fneg    $f18, $f18
	store   $f18, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39409
be_else.39409:
	load    [$i2 + 3], $i19
	load    [$i2 + 4], $i20
	load    [$i20 + 0], $f18
	load    [min_caml_intersection_point + 0], $f19
	load    [$i2 + 5], $i20
	load    [$i20 + 0], $f20
	fsub    $f19, $f20, $f19
	fmul    $f19, $f18, $f18
	load    [$i2 + 4], $i20
	load    [$i20 + 1], $f20
	load    [min_caml_intersection_point + 1], $f21
	load    [$i2 + 5], $i20
	load    [$i20 + 1], $f22
	fsub    $f21, $f22, $f21
	fmul    $f21, $f20, $f20
	load    [$i2 + 4], $i20
	load    [$i20 + 2], $f22
	load    [min_caml_intersection_point + 2], $f23
	load    [$i2 + 5], $i20
	load    [$i20 + 2], $f24
	fsub    $f23, $f24, $f23
	fmul    $f23, $f22, $f22
	bne     $i19, 0, be_else.39410
be_then.39410:
	store   $f18, [min_caml_nvector + 0]
	store   $f20, [min_caml_nvector + 1]
	store   $f22, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39410
be_else.39410:
	load    [$i2 + 9], $i19
	load    [$i19 + 2], $f24
	fmul    $f21, $f24, $f24
	load    [$i2 + 9], $i19
	load    [$i19 + 1], $f25
	fmul    $f23, $f25, $f25
	fadd    $f24, $f25, $f24
.count load_float
	load    [f.34775], $f25
	fmul    $f24, $f25, $f24
	fadd    $f18, $f24, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 9], $i19
	load    [$i19 + 2], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i19
	load    [$i19 + 0], $f24
	fmul    $f23, $f24, $f23
	fadd    $f18, $f23, $f18
	fmul    $f18, $f25, $f18
	fadd    $f20, $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 9], $i19
	load    [$i19 + 1], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i19
	load    [$i19 + 0], $f19
	fmul    $f21, $f19, $f19
	fadd    $f18, $f19, $f18
	fmul    $f18, $f25, $f18
	fadd    $f22, $f18, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39410:
	load    [min_caml_nvector + 0], $f18
	load    [$i2 + 6], $i19
	fmul    $f18, $f18, $f19
	load    [min_caml_nvector + 1], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	load    [min_caml_nvector + 2], $f20
	fmul    $f20, $f20, $f20
	fadd    $f19, $f20, $f19
	fsqrt   $f19, $f19
	bne     $f19, $f0, be_else.39411
be_then.39411:
.count load_float
	load    [f.34799], $f19
.count b_cont
	b       be_cont.39411
be_else.39411:
	finv    $f19, $f19
	bne     $i19, 0, be_else.39412
be_then.39412:
.count load_float
	load    [f.34799], $f20
.count b_cont
	b       be_cont.39412
be_else.39412:
.count load_float
	load    [f.34798], $f20
	fneg    $f19, $f19
be_cont.39412:
be_cont.39411:
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39409:
be_cont.39406:
	load    [min_caml_intersection_point + 0], $f18
	store   $f18, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $f18
	store   $f18, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $f18
	store   $f18, [min_caml_startp + 2]
	call    utexture.2987
	add     $i18, $i18, $i10
	add     $i10, $i10, $i10
	load    [min_caml_intsec_rectside + 0], $i11
	add     $i10, $i11, $i10
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
.count load_float
	load    [f.34775], $f10
	load    [$i10 + 0], $f11
.count stack_load
	load    [$sp + 2], $f12
	fmul    $f11, $f12, $f12
.count stack_store
	store   $f12, [$sp + 8]
.count storer
	add     $i12, $i11, $tmp
	bg      $f10, $f11, ble_else.39413
ble_then.39413:
	li      1, $i10
	store   $i10, [$tmp + 0]
	load    [$i16 + 4], $i10
	load    [$i10 + $i11], $i12
	load    [min_caml_texture_color + 0], $f10
	store   $f10, [$i12 + 0]
	load    [min_caml_texture_color + 1], $f10
	store   $f10, [$i12 + 1]
	load    [min_caml_texture_color + 2], $f10
	store   $f10, [$i12 + 2]
	load    [$i10 + $i11], $i10
.count load_float
	load    [f.34799], $f10
.count load_float
	load    [f.34818], $f10
.count load_float
	load    [f.34819], $f10
	fmul    $f10, $f12, $f10
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
	b       ble_cont.39413
ble_else.39413:
	li      0, $i10
	store   $i10, [$tmp + 0]
ble_cont.39413:
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
	load    [min_caml_or_net + 0], $i10
	load    [$i10 + 0], $i11
	load    [$i11 + 0], $i2
	bne     $i2, -1, be_else.39414
be_then.39414:
	li      0, $i10
.count b_cont
	b       be_cont.39414
be_else.39414:
.count stack_store
	store   $i11, [$sp + 9]
.count stack_store
	store   $i10, [$sp + 10]
	bne     $i2, 99, be_else.39415
be_then.39415:
	li      1, $i22
.count b_cont
	b       be_cont.39415
be_else.39415:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39416
be_then.39416:
	li      0, $i22
.count b_cont
	b       be_cont.39416
be_else.39416:
	load    [min_caml_solver_dist + 0], $f19
	bg      $f17, $f19, ble_else.39417
ble_then.39417:
	li      0, $i22
.count b_cont
	b       ble_cont.39417
ble_else.39417:
	load    [$i11 + 1], $i17
	bne     $i17, -1, be_else.39418
be_then.39418:
	li      0, $i22
.count b_cont
	b       be_cont.39418
be_else.39418:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39419
be_then.39419:
.count stack_load
	load    [$sp + 9], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39420
be_then.39420:
	li      0, $i22
.count b_cont
	b       be_cont.39419
be_else.39420:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39421
be_then.39421:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39422
be_then.39422:
	li      0, $i22
.count b_cont
	b       be_cont.39419
be_else.39422:
	li      1, $i22
.count b_cont
	b       be_cont.39419
be_else.39421:
	li      1, $i22
.count b_cont
	b       be_cont.39419
be_else.39419:
	li      1, $i22
be_cont.39419:
be_cont.39418:
ble_cont.39417:
be_cont.39416:
be_cont.39415:
	bne     $i22, 0, be_else.39423
be_then.39423:
	li      1, $i2
.count stack_load
	load    [$sp + 10], $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39423
be_else.39423:
.count stack_load
	load    [$sp + 9], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.39424
be_then.39424:
	li      1, $i2
.count stack_load
	load    [$sp + 10], $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39424
be_else.39424:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39425
be_then.39425:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.39426
be_then.39426:
	li      1, $i2
.count stack_load
	load    [$sp + 10], $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39425
be_else.39426:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39427
be_then.39427:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39428
be_then.39428:
	li      1, $i2
.count stack_load
	load    [$sp + 10], $i3
	call    shadow_check_one_or_matrix.2947
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39425
be_else.39428:
	li      1, $i10
.count b_cont
	b       be_cont.39425
be_else.39427:
	li      1, $i10
.count b_cont
	b       be_cont.39425
be_else.39425:
	li      1, $i10
be_cont.39425:
be_cont.39424:
be_cont.39423:
be_cont.39414:
.count stack_load
	load    [$sp + 7], $i11
	load    [$i11 + 7], $i11
	load    [$i11 + 1], $f10
.count stack_load
	load    [$sp + 2], $f11
	fmul    $f11, $f10, $f10
	bne     $i10, 0, be_cont.39429
be_then.39429:
	load    [min_caml_nvector + 0], $f11
	load    [min_caml_light + 0], $f12
	fmul    $f11, $f12, $f11
	load    [min_caml_nvector + 1], $f13
	load    [min_caml_light + 1], $f14
	fmul    $f13, $f14, $f13
	fadd    $f11, $f13, $f11
	load    [min_caml_nvector + 2], $f13
	load    [min_caml_light + 2], $f15
	fmul    $f13, $f15, $f13
	fadd    $f11, $f13, $f11
	fneg    $f11, $f11
.count stack_load
	load    [$sp + 8], $f13
	fmul    $f11, $f13, $f11
.count stack_load
	load    [$sp + 3], $i10
	load    [$i10 + 0], $f13
	fmul    $f13, $f12, $f12
	load    [$i10 + 1], $f13
	fmul    $f13, $f14, $f13
	fadd    $f12, $f13, $f12
	load    [$i10 + 2], $f13
	fmul    $f13, $f15, $f13
	fadd    $f12, $f13, $f12
	fneg    $f12, $f12
	ble     $f11, $f0, bg_cont.39430
bg_then.39430:
	load    [min_caml_rgb + 0], $f13
	load    [min_caml_texture_color + 0], $f14
	fmul    $f11, $f14, $f14
	fadd    $f13, $f14, $f13
	store   $f13, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f13
	load    [min_caml_texture_color + 1], $f14
	fmul    $f11, $f14, $f14
	fadd    $f13, $f14, $f13
	store   $f13, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f13
	load    [min_caml_texture_color + 2], $f14
	fmul    $f11, $f14, $f11
	fadd    $f13, $f11, $f11
	store   $f11, [min_caml_rgb + 2]
bg_cont.39430:
	ble     $f12, $f0, bg_cont.39431
bg_then.39431:
	fmul    $f12, $f12, $f11
	fmul    $f11, $f11, $f11
	fmul    $f11, $f10, $f11
	load    [min_caml_rgb + 0], $f12
	fadd    $f12, $f11, $f12
	store   $f12, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f12
	fadd    $f12, $f11, $f12
	store   $f12, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f12
	fadd    $f12, $f11, $f11
	store   $f11, [min_caml_rgb + 2]
bg_cont.39431:
be_cont.39429:
	li      min_caml_intersection_point, $i2
	load    [min_caml_intersection_point + 0], $f11
	store   $f11, [min_caml_startp_fast + 0]
	load    [min_caml_intersection_point + 1], $f11
	store   $f11, [min_caml_startp_fast + 1]
	load    [min_caml_intersection_point + 2], $f11
	store   $f11, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i10
	sub     $i10, 1, $i3
	call    setup_startp_constants.2910
	load    [min_caml_n_reflections + 0], $i25
	sub     $i25, 1, $i2
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
	add     $sp, 11, $sp
.count load_float
	load    [f.34811], $f1
.count stack_load
	load    [$sp - 9], $f2
	bg      $f2, $f1, ble_else.39432
ble_then.39432:
	ret
ble_else.39432:
.count stack_load
	load    [$sp - 7], $i1
	bge     $i1, 4, bl_cont.39433
bl_then.39433:
	add     $i1, 1, $i1
	add     $i0, -1, $i2
.count stack_load
	load    [$sp - 5], $i3
.count storer
	add     $i3, $i1, $tmp
	store   $i2, [$tmp + 0]
bl_cont.39433:
.count stack_load
	load    [$sp - 4], $i1
	load    [$i1 + 2], $i2
	bne     $i2, 2, be_else.39434
be_then.39434:
	load    [$i1 + 7], $i1
	load    [min_caml_tmin + 0], $f1
.count stack_load
	load    [$sp - 10], $f3
	fadd    $f3, $f1, $f3
.count stack_load
	load    [$sp - 7], $i2
	add     $i2, 1, $i2
.count load_float
	load    [f.34799], $f1
	load    [$i1 + 0], $f4
	fsub    $f1, $f4, $f1
	fmul    $f2, $f1, $f2
.count stack_load
	load    [$sp - 8], $i3
.count stack_load
	load    [$sp - 6], $i4
	b       trace_ray.2999
be_else.39434:
	ret
ble_else.39392:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.3005:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f2, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
.count load_float
	load    [f.34816], $f19
	store   $f19, [min_caml_tmin + 0]
	load    [min_caml_or_net + 0], $i3
	load    [$i3 + 0], $i19
	load    [$i19 + 0], $i20
	be      $i20, -1, bne_cont.39435
bne_then.39435:
	bne     $i20, 99, be_else.39436
be_then.39436:
	load    [$i19 + 1], $i20
.count move_args
	mov     $i2, $i4
	bne     $i20, -1, be_else.39437
be_then.39437:
	li      1, $i19
.count move_args
	mov     $i19, $i2
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39436
be_else.39437:
.count stack_store
	store   $i3, [$sp + 3]
	li      0, $i15
	load    [min_caml_and_net + $i20], $i3
.count move_args
	mov     $i15, $i2
	call    solve_each_element_fast.2964
	load    [$i19 + 2], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39438
be_then.39438:
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39436
be_else.39438:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2964
	load    [$i19 + 3], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39439
be_then.39439:
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39436
be_else.39439:
	li      0, $i2
	load    [min_caml_and_net + $i20], $i3
	call    solve_each_element_fast.2964
	load    [$i19 + 4], $i20
.count stack_load
	load    [$sp + 2], $i4
	bne     $i20, -1, be_else.39440
be_then.39440:
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39436
be_else.39440:
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
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i4
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39436
be_else.39436:
.count stack_store
	store   $i3, [$sp + 3]
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
	bne     $i20, 0, be_else.39441
be_then.39441:
.count stack_load
	load    [$sp + 3], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       be_cont.39441
be_else.39441:
	load    [min_caml_solver_dist + 0], $f19
	load    [min_caml_tmin + 0], $f20
	bg      $f20, $f19, ble_else.39442
ble_then.39442:
.count stack_load
	load    [$sp + 3], $i3
	call    trace_or_matrix_fast.2972
.count b_cont
	b       ble_cont.39442
ble_else.39442:
.count move_args
	mov     $i19, $i3
	call    solve_one_or_network_fast.2968
	li      1, $i2
.count stack_load
	load    [$sp + 3], $i3
.count stack_load
	load    [$sp + 2], $i4
	call    trace_or_matrix_fast.2972
ble_cont.39442:
be_cont.39441:
be_cont.39436:
bne_cont.39435:
.count load_float
	load    [f.34802], $f17
	load    [min_caml_tmin + 0], $f18
	bg      $f18, $f17, ble_else.39443
ble_then.39443:
	li      0, $i16
.count b_cont
	b       ble_cont.39443
ble_else.39443:
.count load_float
	load    [f.34817], $f19
	bg      $f19, $f18, ble_else.39444
ble_then.39444:
	li      0, $i16
.count b_cont
	b       ble_cont.39444
ble_else.39444:
	li      1, $i16
ble_cont.39444:
ble_cont.39443:
	bne     $i16, 0, be_else.39445
be_then.39445:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
be_else.39445:
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 0], $i16
	load    [min_caml_intersected_object_id + 0], $i17
	load    [min_caml_objects + $i17], $i2
.count stack_store
	store   $i2, [$sp + 4]
	load    [$i2 + 1], $i17
	bne     $i17, 1, be_else.39446
be_then.39446:
	store   $f0, [min_caml_nvector + 0]
	store   $f0, [min_caml_nvector + 1]
	store   $f0, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $i17
	sub     $i17, 1, $i17
	load    [$i16 + $i17], $f18
	bne     $f18, $f0, be_else.39447
be_then.39447:
	store   $f0, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39446
be_else.39447:
	bg      $f18, $f0, ble_else.39448
ble_then.39448:
.count load_float
	load    [f.34798], $f18
.count load_float
	load    [f.34799], $f18
	store   $f18, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39446
ble_else.39448:
.count load_float
	load    [f.34799], $f18
.count load_float
	load    [f.34798], $f18
	store   $f18, [min_caml_nvector + $i17]
.count b_cont
	b       be_cont.39446
be_else.39446:
	bne     $i17, 2, be_else.39449
be_then.39449:
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
	b       be_cont.39449
be_else.39449:
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
	bne     $i16, 0, be_else.39450
be_then.39450:
	store   $f18, [min_caml_nvector + 0]
	store   $f20, [min_caml_nvector + 1]
	store   $f22, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.39450
be_else.39450:
	load    [$i2 + 9], $i16
	load    [$i16 + 2], $f24
	fmul    $f21, $f24, $f24
	load    [$i2 + 9], $i16
	load    [$i16 + 1], $f25
	fmul    $f23, $f25, $f25
	fadd    $f24, $f25, $f24
.count load_float
	load    [f.34775], $f25
	fmul    $f24, $f25, $f24
	fadd    $f18, $f24, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [$i2 + 9], $i16
	load    [$i16 + 2], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i16
	load    [$i16 + 0], $f24
	fmul    $f23, $f24, $f23
	fadd    $f18, $f23, $f18
	fmul    $f18, $f25, $f18
	fadd    $f20, $f18, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [$i2 + 9], $i16
	load    [$i16 + 1], $f18
	fmul    $f19, $f18, $f18
	load    [$i2 + 9], $i16
	load    [$i16 + 0], $f19
	fmul    $f21, $f19, $f19
	fadd    $f18, $f19, $f18
	fmul    $f18, $f25, $f18
	fadd    $f22, $f18, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39450:
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
	bne     $f19, $f0, be_else.39451
be_then.39451:
.count load_float
	load    [f.34799], $f19
.count b_cont
	b       be_cont.39451
be_else.39451:
	finv    $f19, $f19
	bne     $i16, 0, be_else.39452
be_then.39452:
.count load_float
	load    [f.34799], $f20
.count b_cont
	b       be_cont.39452
be_else.39452:
.count load_float
	load    [f.34798], $f20
	fneg    $f19, $f19
be_cont.39452:
be_cont.39451:
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $f18
	fmul    $f18, $f19, $f18
	store   $f18, [min_caml_nvector + 2]
be_cont.39449:
be_cont.39446:
	call    utexture.2987
	load    [min_caml_or_net + 0], $i10
	load    [$i10 + 0], $i11
	load    [$i11 + 0], $i2
	bne     $i2, -1, be_else.39453
be_then.39453:
	li      0, $i1
.count b_cont
	b       be_cont.39453
be_else.39453:
.count stack_store
	store   $i11, [$sp + 5]
.count stack_store
	store   $i10, [$sp + 6]
	bne     $i2, 99, be_else.39454
be_then.39454:
	li      1, $i22
.count b_cont
	b       be_cont.39454
be_else.39454:
	call    solver_fast.2875
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39455
be_then.39455:
	li      0, $i22
.count b_cont
	b       be_cont.39455
be_else.39455:
	load    [min_caml_solver_dist + 0], $f19
	bg      $f17, $f19, ble_else.39456
ble_then.39456:
	li      0, $i22
.count b_cont
	b       ble_cont.39456
ble_else.39456:
	load    [$i11 + 1], $i17
	bne     $i17, -1, be_else.39457
be_then.39457:
	li      0, $i22
.count b_cont
	b       be_cont.39457
be_else.39457:
	li      0, $i2
	load    [min_caml_and_net + $i17], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i17
	bne     $i17, 0, be_else.39458
be_then.39458:
.count stack_load
	load    [$sp + 5], $i17
	load    [$i17 + 2], $i18
	bne     $i18, -1, be_else.39459
be_then.39459:
	li      0, $i22
.count b_cont
	b       be_cont.39458
be_else.39459:
	li      0, $i2
	load    [min_caml_and_net + $i18], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39460
be_then.39460:
	li      3, $i2
.count move_args
	mov     $i17, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39461
be_then.39461:
	li      0, $i22
.count b_cont
	b       be_cont.39458
be_else.39461:
	li      1, $i22
.count b_cont
	b       be_cont.39458
be_else.39460:
	li      1, $i22
.count b_cont
	b       be_cont.39458
be_else.39458:
	li      1, $i22
be_cont.39458:
be_cont.39457:
ble_cont.39456:
be_cont.39455:
be_cont.39454:
	bne     $i22, 0, be_else.39462
be_then.39462:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39462
be_else.39462:
.count stack_load
	load    [$sp + 5], $i22
	load    [$i22 + 1], $i23
	bne     $i23, -1, be_else.39463
be_then.39463:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39463
be_else.39463:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39464
be_then.39464:
	load    [$i22 + 2], $i23
	bne     $i23, -1, be_else.39465
be_then.39465:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39464
be_else.39465:
	li      0, $i2
	load    [min_caml_and_net + $i23], $i3
	call    shadow_check_and_group.2941
.count move_ret
	mov     $i1, $i20
	bne     $i20, 0, be_else.39466
be_then.39466:
	li      3, $i2
.count move_args
	mov     $i22, $i3
	call    shadow_check_one_or_group.2944
.count move_ret
	mov     $i1, $i22
	bne     $i22, 0, be_else.39467
be_then.39467:
	li      1, $i2
.count stack_load
	load    [$sp + 6], $i3
	call    shadow_check_one_or_matrix.2947
.count b_cont
	b       be_cont.39464
be_else.39467:
	li      1, $i1
.count b_cont
	b       be_cont.39464
be_else.39466:
	li      1, $i1
.count b_cont
	b       be_cont.39464
be_else.39464:
	li      1, $i1
be_cont.39464:
be_cont.39463:
be_cont.39462:
be_cont.39453:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	bne     $i1, 0, be_else.39468
be_then.39468:
.count stack_load
	load    [$sp - 3], $i1
	load    [$i1 + 7], $i1
	load    [min_caml_diffuse_ray + 0], $f1
	load    [min_caml_texture_color + 0], $f2
	load    [min_caml_nvector + 0], $f3
	load    [min_caml_light + 0], $f4
	fmul    $f3, $f4, $f3
	load    [min_caml_nvector + 1], $f4
	load    [min_caml_light + 1], $f5
	fmul    $f4, $f5, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_nvector + 2], $f4
	load    [min_caml_light + 2], $f5
	fmul    $f4, $f5, $f4
	fadd    $f3, $f4, $f3
	fneg    $f3, $f3
	bg      $f3, $f0, ble_cont.39469
ble_then.39469:
	mov     $f0, $f3
ble_cont.39469:
.count stack_load
	load    [$sp - 6], $f4
	fmul    $f4, $f3, $f3
	load    [$i1 + 0], $f4
	fmul    $f3, $f4, $f3
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	load    [min_caml_texture_color + 1], $f2
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	load    [min_caml_texture_color + 2], $f2
	fmul    $f3, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	ret
be_else.39468:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.3008:
	bl      $i4, 0, bge_else.39470
bge_then.39470:
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
	bg      $f0, $f28, ble_else.39471
ble_then.39471:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i2 + $i4], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.39472
bge_then.39472:
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
	bg      $f0, $f28, ble_else.39473
ble_then.39473:
	fmul    $f28, $f29, $f2
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
ble_else.39473:
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
bge_else.39472:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.39471:
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	add     $i4, 1, $i24
	load    [$i2 + $i24], $i2
	call    trace_diffuse_ray.3005
.count stack_load
	load    [$sp + 3], $i24
	sub     $i24, 2, $i24
	bl      $i24, 0, bge_else.39474
bge_then.39474:
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
	bg      $f0, $f28, ble_else.39475
ble_then.39475:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
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
ble_else.39475:
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
bge_else.39474:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.39470:
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
	store   $f10, [min_caml_diffuse_ray + 0]
	load    [$i10 + 1], $f10
	store   $f10, [min_caml_diffuse_ray + 1]
	load    [$i10 + 2], $f10
	store   $f10, [min_caml_diffuse_ray + 2]
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
	be      $i11, 0, bne_cont.39476
bne_then.39476:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i3
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
	bg      $f0, $f28, ble_else.39477
ble_then.39477:
	load    [$i11 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 6], $i2
.count stack_load
	load    [$sp + 3], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39477
ble_else.39477:
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
ble_cont.39477:
bne_cont.39476:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 1, bne_cont.39478
bne_then.39478:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39479
ble_then.39479:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39479
ble_else.39479:
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
ble_cont.39479:
bne_cont.39478:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 2, bne_cont.39480
bne_then.39480:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39481
ble_then.39481:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39481
ble_else.39481:
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
ble_cont.39481:
bne_cont.39480:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 3, bne_cont.39482
bne_then.39482:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39483
ble_then.39483:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39483
ble_else.39483:
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
ble_cont.39483:
bne_cont.39482:
.count stack_load
	load    [$sp + 5], $i10
	be      $i10, 4, bne_cont.39484
bne_then.39484:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 4], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39485
ble_then.39485:
	load    [$i10 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39485
ble_else.39485:
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
ble_cont.39485:
bne_cont.39484:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
.count stack_load
	load    [$sp - 9], $i1
	load    [$i1 + 4], $i1
	load    [min_caml_rgb + 0], $f1
.count stack_load
	load    [$sp - 10], $i2
	load    [$i1 + $i2], $i1
	load    [$i1 + 0], $f2
	load    [min_caml_diffuse_ray + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f1
	load    [$i1 + 1], $f2
	load    [min_caml_diffuse_ray + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f1
	load    [$i1 + 2], $f2
	load    [min_caml_diffuse_ray + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 2]
	ret
.end calc_diffuse_using_1point

######################################################################
.begin do_without_neighbors
do_without_neighbors.3030:
	bg      $i3, 4, ble_else.39486
ble_then.39486:
	load    [$i2 + 2], $i28
	load    [$i28 + $i3], $i29
	bl      $i29, 0, bge_else.39487
bge_then.39487:
	load    [$i2 + 3], $i29
	load    [$i29 + $i3], $i30
	bne     $i30, 0, be_else.39488
be_then.39488:
	add     $i3, 1, $i3
	bg      $i3, 4, ble_else.39489
ble_then.39489:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.39490
bge_then.39490:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.39491
be_then.39491:
	add     $i3, 1, $i3
	b       do_without_neighbors.3030
be_else.39491:
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
bge_else.39490:
	ret
ble_else.39489:
	ret
be_else.39488:
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
	store   $f10, [min_caml_diffuse_ray + 0]
	load    [$i10 + 1], $f10
	store   $f10, [min_caml_diffuse_ray + 1]
	load    [$i10 + 2], $f10
	store   $f10, [min_caml_diffuse_ray + 2]
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
	be      $i11, 0, bne_cont.39492
bne_then.39492:
	load    [min_caml_dirvecs + 0], $i11
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i3
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
	bg      $f0, $f28, ble_else.39493
ble_then.39493:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i11 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 7], $i2
.count stack_load
	load    [$sp + 4], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39493
ble_else.39493:
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
ble_cont.39493:
bne_cont.39492:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 1, bne_cont.39494
bne_then.39494:
	load    [min_caml_dirvecs + 1], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39495
ble_then.39495:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 8], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39495
ble_else.39495:
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
ble_cont.39495:
bne_cont.39494:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 2, bne_cont.39496
bne_then.39496:
	load    [min_caml_dirvecs + 2], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39497
ble_then.39497:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39497
ble_else.39497:
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
ble_cont.39497:
bne_cont.39496:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 3, bne_cont.39498
bne_then.39498:
	load    [min_caml_dirvecs + 3], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39499
ble_then.39499:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 10], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39499
ble_else.39499:
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
ble_cont.39499:
bne_cont.39498:
.count stack_load
	load    [$sp + 6], $i10
	be      $i10, 4, bne_cont.39500
bne_then.39500:
	load    [min_caml_dirvecs + 4], $i10
.count stack_load
	load    [$sp + 5], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i3
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
	bg      $f0, $f28, ble_else.39501
ble_then.39501:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 11], $i2
.count move_args
	mov     $i25, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39501
ble_else.39501:
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
ble_cont.39501:
bne_cont.39500:
.count stack_load
	load    [$sp + 1], $i2
	load    [$i2 + 4], $i30
	load    [min_caml_rgb + 0], $f32
.count stack_load
	load    [$sp + 3], $i31
	load    [$i30 + $i31], $i30
	load    [$i30 + 0], $f33
	load    [min_caml_diffuse_ray + 0], $f34
	fmul    $f33, $f34, $f33
	fadd    $f32, $f33, $f32
	store   $f32, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f32
	load    [$i30 + 1], $f33
	load    [min_caml_diffuse_ray + 1], $f34
	fmul    $f33, $f34, $f33
	fadd    $f32, $f33, $f32
	store   $f32, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f32
	load    [$i30 + 2], $f33
	load    [min_caml_diffuse_ray + 2], $f34
	fmul    $f33, $f34, $f33
	fadd    $f32, $f33, $f32
	store   $f32, [min_caml_rgb + 2]
	add     $i31, 1, $i3
	bg      $i3, 4, ble_else.39502
ble_then.39502:
	load    [$i28 + $i3], $i28
	bl      $i28, 0, bge_else.39503
bge_then.39503:
	load    [$i29 + $i3], $i28
	bne     $i28, 0, be_else.39504
be_then.39504:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	add     $i3, 1, $i3
	b       do_without_neighbors.3030
be_else.39504:
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
bge_else.39503:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.39502:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.39487:
	ret
ble_else.39486:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.3046:
	bg      $i6, 4, ble_else.39505
ble_then.39505:
	load    [$i4 + $i2], $i32
	load    [$i32 + 2], $i33
	load    [$i33 + $i6], $i33
	bl      $i33, 0, bge_else.39506
bge_then.39506:
	load    [$i3 + $i2], $i34
	load    [$i34 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39507
be_then.39507:
	load    [$i5 + $i2], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39508
be_then.39508:
	sub     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39509
be_then.39509:
	add     $i2, 1, $i35
	load    [$i4 + $i35], $i35
	load    [$i35 + 2], $i35
	load    [$i35 + $i6], $i35
	bne     $i35, $i33, be_else.39510
be_then.39510:
	li      1, $i33
.count b_cont
	b       be_cont.39507
be_else.39510:
	li      0, $i33
.count b_cont
	b       be_cont.39507
be_else.39509:
	li      0, $i33
.count b_cont
	b       be_cont.39507
be_else.39508:
	li      0, $i33
.count b_cont
	b       be_cont.39507
be_else.39507:
	li      0, $i33
be_cont.39507:
	bne     $i33, 0, be_else.39511
be_then.39511:
	bg      $i6, 4, ble_else.39512
ble_then.39512:
	load    [$i4 + $i2], $i2
	load    [$i2 + 2], $i32
	load    [$i32 + $i6], $i32
	bl      $i32, 0, bge_else.39513
bge_then.39513:
	load    [$i2 + 3], $i32
	load    [$i32 + $i6], $i32
	bne     $i32, 0, be_else.39514
be_then.39514:
	add     $i6, 1, $i3
	b       do_without_neighbors.3030
be_else.39514:
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
bge_else.39513:
	ret
ble_else.39512:
	ret
be_else.39511:
	load    [$i32 + 3], $i1
	load    [$i1 + $i6], $i1
	bne     $i1, 0, be_else.39515
be_then.39515:
	add     $i6, 1, $i6
	b       try_exploit_neighbors.3046
be_else.39515:
	load    [$i34 + 5], $i1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [$i1 + 1], $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [$i1 + 2], $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	sub     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [min_caml_diffuse_ray + 0], $f1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	load    [$i1 + 1], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	load    [$i1 + 2], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	load    [$i4 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [min_caml_diffuse_ray + 0], $f1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	load    [$i1 + 1], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	load    [$i1 + 2], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	add     $i2, 1, $i1
	load    [$i4 + $i1], $i1
	load    [$i1 + 5], $i1
	load    [min_caml_diffuse_ray + 0], $f1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	load    [$i1 + 1], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	load    [$i1 + 2], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	load    [$i5 + $i2], $i1
	load    [$i1 + 5], $i1
	load    [min_caml_diffuse_ray + 0], $f1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	load    [$i1 + 1], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	load    [$i1 + 2], $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_diffuse_ray + 2]
	load    [$i4 + $i2], $i1
	load    [$i1 + 4], $i1
	load    [min_caml_rgb + 0], $f1
	load    [$i1 + $i6], $i1
	load    [$i1 + 0], $f2
	load    [min_caml_diffuse_ray + 0], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f1
	load    [$i1 + 1], $f2
	load    [min_caml_diffuse_ray + 1], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f1
	load    [$i1 + 2], $f2
	load    [min_caml_diffuse_ray + 2], $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, [min_caml_rgb + 2]
	add     $i6, 1, $i6
	b       try_exploit_neighbors.3046
bge_else.39506:
	ret
ble_else.39505:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.3059:
	bg      $i3, 4, ble_else.39516
ble_then.39516:
	load    [$i2 + 2], $i10
	load    [$i10 + $i3], $i11
	bl      $i11, 0, bge_else.39517
bge_then.39517:
	load    [$i2 + 3], $i11
	load    [$i11 + $i3], $i12
	bne     $i12, 0, be_else.39518
be_then.39518:
	add     $i3, 1, $i12
	bg      $i12, 4, ble_else.39519
ble_then.39519:
	load    [$i10 + $i12], $i10
	bl      $i10, 0, bge_else.39520
bge_then.39520:
	load    [$i11 + $i12], $i10
	bne     $i10, 0, be_else.39521
be_then.39521:
	add     $i12, 1, $i3
	b       pretrace_diffuse_rays.3059
be_else.39521:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i12, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	store   $f0, [min_caml_diffuse_ray + 0]
	store   $f0, [min_caml_diffuse_ray + 1]
	store   $f0, [min_caml_diffuse_ray + 2]
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i13
	load    [$i13 + $i12], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i13
	sub     $i13, 1, $i3
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
	bg      $f0, $f28, ble_else.39522
ble_then.39522:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39522
ble_else.39522:
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
ble_cont.39522:
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
	load    [min_caml_diffuse_ray + 0], $f1
	store   $f1, [$i1 + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	store   $f1, [$i1 + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	store   $f1, [$i1 + 2]
	add     $i3, 1, $i3
	b       pretrace_diffuse_rays.3059
bge_else.39520:
	ret
ble_else.39519:
	ret
be_else.39518:
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
	store   $f0, [min_caml_diffuse_ray + 0]
	store   $f0, [min_caml_diffuse_ray + 1]
	store   $f0, [min_caml_diffuse_ray + 2]
	load    [$i2 + 6], $i10
	load    [$i2 + 7], $i11
.count stack_store
	store   $i11, [$sp + 6]
	load    [$i2 + 1], $i12
.count stack_store
	store   $i12, [$sp + 7]
	load    [$i12 + $i3], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i3
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
	bg      $f0, $f28, ble_else.39523
ble_then.39523:
	load    [$i24 + 118], $i2
.count load_float
	load    [f.34824], $f29
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
.count b_cont
	b       ble_cont.39523
ble_else.39523:
	load    [$i24 + 119], $i2
.count load_float
	load    [f.34823], $f29
.count load_float
	load    [f.34821], $f29
	fmul    $f28, $f29, $f2
	call    trace_diffuse_ray.3005
ble_cont.39523:
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
	load    [min_caml_diffuse_ray + 0], $f10
	store   $f10, [$i12 + 0]
	load    [min_caml_diffuse_ray + 1], $f10
	store   $f10, [$i12 + 1]
	load    [min_caml_diffuse_ray + 2], $f10
	store   $f10, [$i12 + 2]
	add     $i11, 1, $i11
	bg      $i11, 4, ble_else.39524
ble_then.39524:
.count stack_load
	load    [$sp + 4], $i12
	load    [$i12 + $i11], $i12
	bl      $i12, 0, bge_else.39525
bge_then.39525:
.count stack_load
	load    [$sp + 3], $i12
	load    [$i12 + $i11], $i12
	bne     $i12, 0, be_else.39526
be_then.39526:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	add     $i11, 1, $i3
	b       pretrace_diffuse_rays.3059
be_else.39526:
.count stack_store
	store   $i11, [$sp + 8]
.count stack_store
	store   $i10, [$sp + 9]
	store   $f0, [min_caml_diffuse_ray + 0]
	store   $f0, [min_caml_diffuse_ray + 1]
	store   $f0, [min_caml_diffuse_ray + 2]
	load    [$i2 + 6], $i10
.count stack_load
	load    [$sp + 7], $i12
	load    [$i12 + $i11], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i3
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
	bg      $f0, $f28, ble_else.39527
ble_then.39527:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i24 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count move_args
	mov     $i24, $i2
.count move_args
	mov     $i26, $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39527
ble_else.39527:
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
ble_cont.39527:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $i1
.count stack_load
	load    [$sp - 1], $i2
	load    [$i2 + $i1], $i2
	load    [min_caml_diffuse_ray + 0], $f1
	store   $f1, [$i2 + 0]
	load    [min_caml_diffuse_ray + 1], $f1
	store   $f1, [$i2 + 1]
	load    [min_caml_diffuse_ray + 2], $f1
	store   $f1, [$i2 + 2]
	add     $i1, 1, $i3
.count stack_load
	load    [$sp - 8], $i2
	b       pretrace_diffuse_rays.3059
bge_else.39525:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.39524:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.39517:
	ret
ble_else.39516:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.3062:
	bl      $i3, 0, bge_else.39528
bge_then.39528:
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
	load    [min_caml_scan_pitch + 0], $f11
	load    [min_caml_image_center + 0], $i1
	sub     $i3, $i1, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f30
	fmul    $f11, $f30, $f30
	fmul    $f30, $f10, $f31
.count stack_load
	load    [$sp + 6], $f32
	fadd    $f31, $f32, $f31
	store   $f31, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_screenx_dir + 1], $f31
	fmul    $f30, $f31, $f31
.count stack_load
	load    [$sp + 5], $f33
	fadd    $f31, $f33, $f31
	store   $f31, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $f31
	fmul    $f30, $f31, $f30
	fadd    $f30, $f4, $f30
	store   $f30, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $f30
	fmul    $f30, $f30, $f31
	load    [min_caml_ptrace_dirvec + 1], $f34
	fmul    $f34, $f34, $f34
	fadd    $f31, $f34, $f31
	load    [min_caml_ptrace_dirvec + 2], $f34
	fmul    $f34, $f34, $f34
	fadd    $f31, $f34, $f31
	fsqrt   $f31, $f31
	bne     $f31, $f0, be_else.39529
be_then.39529:
.count load_float
	load    [f.34799], $f31
.count b_cont
	b       be_cont.39529
be_else.39529:
.count load_float
	load    [f.34799], $f34
	finv    $f31, $f31
be_cont.39529:
	fmul    $f30, $f31, $f30
	store   $f30, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $f30
	fmul    $f30, $f31, $f30
	store   $f30, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $f30
	fmul    $f30, $f31, $f30
	store   $f30, [min_caml_ptrace_dirvec + 2]
	store   $f0, [min_caml_rgb + 0]
	store   $f0, [min_caml_rgb + 1]
	store   $f0, [min_caml_rgb + 2]
	load    [min_caml_viewpoint + 0], $f30
	store   $f30, [min_caml_startp + 0]
	load    [min_caml_viewpoint + 1], $f30
	store   $f30, [min_caml_startp + 1]
	load    [min_caml_viewpoint + 2], $f30
	store   $f30, [min_caml_startp + 2]
	li      min_caml_ptrace_dirvec, $i3
.count load_float
	load    [f.34799], $f2
	li      0, $i2
.count stack_load
	load    [$sp + 3], $i26
.count stack_load
	load    [$sp + 4], $i27
	load    [$i27 + $i26], $i4
.count move_args
	mov     $f0, $f3
	call    trace_ray.2999
	load    [$i27 + $i26], $i28
	load    [$i28 + 0], $i28
	load    [min_caml_rgb + 0], $f34
	store   $f34, [$i28 + 0]
	load    [min_caml_rgb + 1], $f34
	store   $f34, [$i28 + 1]
	load    [min_caml_rgb + 2], $f34
	store   $f34, [$i28 + 2]
	load    [$i27 + $i26], $i28
	load    [$i28 + 6], $i28
.count stack_load
	load    [$sp + 2], $i29
	store   $i29, [$i28 + 0]
	load    [$i27 + $i26], $i2
	load    [$i2 + 2], $i28
	load    [$i28 + 0], $i28
	bl      $i28, 0, bge_cont.39530
bge_then.39530:
	load    [$i2 + 3], $i28
	load    [$i28 + 0], $i28
	bne     $i28, 0, be_else.39531
be_then.39531:
	li      1, $i3
	call    pretrace_diffuse_rays.3059
.count b_cont
	b       be_cont.39531
be_else.39531:
.count stack_store
	store   $i2, [$sp + 7]
	load    [$i2 + 6], $i10
	load    [$i10 + 0], $i10
	store   $f0, [min_caml_diffuse_ray + 0]
	store   $f0, [min_caml_diffuse_ray + 1]
	store   $f0, [min_caml_diffuse_ray + 2]
	load    [$i2 + 7], $i11
	load    [$i2 + 1], $i12
	load    [min_caml_dirvecs + $i10], $i10
	load    [$i11 + 0], $i11
	load    [$i12 + 0], $i2
	load    [$i2 + 0], $f10
	store   $f10, [min_caml_startp_fast + 0]
	load    [$i2 + 1], $f10
	store   $f10, [min_caml_startp_fast + 1]
	load    [$i2 + 2], $f10
	store   $f10, [min_caml_startp_fast + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i3
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
	bg      $f0, $f28, ble_else.39532
ble_then.39532:
.count load_float
	load    [f.34822], $f29
	fmul    $f28, $f29, $f2
	load    [$i10 + 118], $i2
	call    trace_diffuse_ray.3005
	li      116, $i4
.count stack_load
	load    [$sp + 9], $i2
.count stack_load
	load    [$sp + 8], $i3
	call    iter_trace_diffuse_rays.3008
.count b_cont
	b       ble_cont.39532
ble_else.39532:
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
ble_cont.39532:
.count stack_load
	load    [$sp + 7], $i2
	load    [$i2 + 5], $i28
	load    [$i28 + 0], $i28
	load    [min_caml_diffuse_ray + 0], $f34
	store   $f34, [$i28 + 0]
	load    [min_caml_diffuse_ray + 1], $f34
	store   $f34, [$i28 + 1]
	load    [min_caml_diffuse_ray + 2], $f34
	store   $f34, [$i28 + 2]
	li      1, $i3
	call    pretrace_diffuse_rays.3059
be_cont.39531:
bge_cont.39530:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 7], $i1
	sub     $i1, 1, $i3
	add     $i29, 1, $i4
.count move_args
	mov     $f33, $f3
.count move_args
	mov     $f32, $f2
.count stack_load
	load    [$sp - 9], $f4
.count stack_load
	load    [$sp - 6], $i2
	bl      $i4, 5, pretrace_pixels.3062
	sub     $i4, 5, $i4
	b       pretrace_pixels.3062
bge_else.39528:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.3073:
	load    [min_caml_image_size + 0], $i32
	bg      $i32, $i2, ble_else.39534
ble_then.39534:
	ret
ble_else.39534:
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
	load    [$i32 + 0], $f35
	store   $f35, [min_caml_rgb + 0]
	load    [$i32 + 1], $f35
	store   $f35, [min_caml_rgb + 1]
	load    [$i32 + 2], $f35
	store   $f35, [min_caml_rgb + 2]
	load    [min_caml_image_size + 1], $i32
	add     $i3, 1, $i33
.count stack_store
	store   $i33, [$sp + 6]
	bg      $i32, $i33, ble_else.39535
ble_then.39535:
	li      0, $i32
.count b_cont
	b       ble_cont.39535
ble_else.39535:
	bg      $i3, 0, ble_else.39536
ble_then.39536:
	li      0, $i32
.count b_cont
	b       ble_cont.39536
ble_else.39536:
	load    [min_caml_image_size + 0], $i32
	add     $i2, 1, $i33
	bg      $i32, $i33, ble_else.39537
ble_then.39537:
	li      0, $i32
.count b_cont
	b       ble_cont.39537
ble_else.39537:
	bg      $i2, 0, ble_else.39538
ble_then.39538:
	li      0, $i32
.count b_cont
	b       ble_cont.39538
ble_else.39538:
	li      1, $i32
ble_cont.39538:
ble_cont.39537:
ble_cont.39536:
ble_cont.39535:
	bne     $i32, 0, be_else.39539
be_then.39539:
	load    [$i5 + $i2], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39539
bge_then.39540:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39541
be_then.39541:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39539
be_else.39541:
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
	b       be_cont.39539
be_else.39539:
	li      0, $i32
	load    [$i5 + $i2], $i33
	load    [$i33 + 2], $i34
	load    [$i34 + 0], $i34
	bl      $i34, 0, bge_cont.39542
bge_then.39542:
	load    [$i4 + $i2], $i35
	load    [$i35 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39543
be_then.39543:
	load    [$i6 + $i2], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39544
be_then.39544:
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39545
be_then.39545:
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 2], $i36
	load    [$i36 + 0], $i36
	bne     $i36, $i34, be_else.39546
be_then.39546:
	li      1, $i34
.count b_cont
	b       be_cont.39543
be_else.39546:
	li      0, $i34
.count b_cont
	b       be_cont.39543
be_else.39545:
	li      0, $i34
.count b_cont
	b       be_cont.39543
be_else.39544:
	li      0, $i34
.count b_cont
	b       be_cont.39543
be_else.39543:
	li      0, $i34
be_cont.39543:
	bne     $i34, 0, be_else.39547
be_then.39547:
	load    [$i5 + $i2], $i2
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39547
bge_then.39548:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39549
be_then.39549:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39547
be_else.39549:
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
	b       be_cont.39547
be_else.39547:
	load    [$i33 + 3], $i36
	load    [$i36 + 0], $i36
.count move_args
	mov     $i4, $i3
.count move_args
	mov     $i5, $i4
	bne     $i36, 0, be_else.39550
be_then.39550:
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.3046
.count b_cont
	b       be_cont.39550
be_else.39550:
	load    [$i35 + 5], $i36
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f35
	store   $f35, [min_caml_diffuse_ray + 0]
	load    [$i36 + 1], $f35
	store   $f35, [min_caml_diffuse_ray + 1]
	load    [$i36 + 2], $f35
	store   $f35, [min_caml_diffuse_ray + 2]
	sub     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [min_caml_diffuse_ray + 0], $f35
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f35
	load    [$i36 + 1], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f35
	load    [$i36 + 2], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 2]
	load    [$i5 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [min_caml_diffuse_ray + 0], $f35
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f35
	load    [$i36 + 1], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f35
	load    [$i36 + 2], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 2]
	add     $i2, 1, $i36
	load    [$i5 + $i36], $i36
	load    [$i36 + 5], $i36
	load    [min_caml_diffuse_ray + 0], $f35
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f35
	load    [$i36 + 1], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f35
	load    [$i36 + 2], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 2]
	load    [$i6 + $i2], $i36
	load    [$i36 + 5], $i36
	load    [min_caml_diffuse_ray + 0], $f35
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 0]
	load    [min_caml_diffuse_ray + 1], $f35
	load    [$i36 + 1], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 1]
	load    [min_caml_diffuse_ray + 2], $f35
	load    [$i36 + 2], $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_diffuse_ray + 2]
	load    [$i5 + $i2], $i36
	load    [$i36 + 4], $i36
	load    [min_caml_rgb + 0], $f35
	load    [$i36 + 0], $i36
	load    [$i36 + 0], $f36
	load    [min_caml_diffuse_ray + 0], $f37
	fmul    $f36, $f37, $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_rgb + 0]
	load    [min_caml_rgb + 1], $f35
	load    [$i36 + 1], $f36
	load    [min_caml_diffuse_ray + 1], $f37
	fmul    $f36, $f37, $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_rgb + 1]
	load    [min_caml_rgb + 2], $f35
	load    [$i36 + 2], $f36
	load    [min_caml_diffuse_ray + 2], $f37
	fmul    $f36, $f37, $f36
	fadd    $f35, $f36, $f35
	store   $f35, [min_caml_rgb + 2]
	li      1, $i36
.count move_args
	mov     $i6, $i5
.count move_args
	mov     $i36, $i6
	call    try_exploit_neighbors.3046
be_cont.39550:
be_cont.39547:
bge_cont.39542:
be_cont.39539:
	li      255, $i10
	load    [min_caml_rgb + 0], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39551
ble_then.39551:
	bl      $i2, 0, bge_else.39552
bge_then.39552:
	call    min_caml_write
.count b_cont
	b       ble_cont.39551
bge_else.39552:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39551
ble_else.39551:
	li      255, $i2
	call    min_caml_write
ble_cont.39551:
	li      255, $i10
	load    [min_caml_rgb + 1], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39553
ble_then.39553:
	bl      $i2, 0, bge_else.39554
bge_then.39554:
	call    min_caml_write
.count b_cont
	b       ble_cont.39553
bge_else.39554:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39553
ble_else.39553:
	li      255, $i2
	call    min_caml_write
ble_cont.39553:
	li      255, $i10
	load    [min_caml_rgb + 2], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	mov     $i1, $i2
	bg      $i2, $i10, ble_else.39555
ble_then.39555:
	bl      $i2, 0, bge_else.39556
bge_then.39556:
	call    min_caml_write
.count b_cont
	b       ble_cont.39555
bge_else.39556:
	li      0, $i2
	call    min_caml_write
.count b_cont
	b       ble_cont.39555
ble_else.39555:
	li      255, $i2
	call    min_caml_write
ble_cont.39555:
	load    [min_caml_image_size + 0], $i32
.count stack_load
	load    [$sp + 5], $i33
	add     $i33, 1, $i33
	bg      $i32, $i33, ble_else.39557
ble_then.39557:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 11, $sp
	ret
ble_else.39557:
.count stack_store
	store   $i33, [$sp + 9]
.count stack_load
	load    [$sp + 4], $i32
	load    [$i32 + $i33], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $f35
	store   $f35, [min_caml_rgb + 0]
	load    [$i34 + 1], $f35
	store   $f35, [min_caml_rgb + 1]
	load    [$i34 + 2], $f35
	store   $f35, [min_caml_rgb + 2]
	load    [min_caml_image_size + 1], $i34
.count stack_load
	load    [$sp + 6], $i35
	bg      $i34, $i35, ble_else.39558
ble_then.39558:
	li      0, $i34
.count b_cont
	b       ble_cont.39558
ble_else.39558:
.count stack_load
	load    [$sp + 3], $i34
	bg      $i34, 0, ble_else.39559
ble_then.39559:
	li      0, $i34
.count b_cont
	b       ble_cont.39559
ble_else.39559:
	load    [min_caml_image_size + 0], $i34
	add     $i33, 1, $i35
	bg      $i34, $i35, ble_else.39560
ble_then.39560:
	li      0, $i34
.count b_cont
	b       ble_cont.39560
ble_else.39560:
	bg      $i33, 0, ble_else.39561
ble_then.39561:
	li      0, $i34
.count b_cont
	b       ble_cont.39561
ble_else.39561:
	li      1, $i34
ble_cont.39561:
ble_cont.39560:
ble_cont.39559:
ble_cont.39558:
	bne     $i34, 0, be_else.39562
be_then.39562:
	load    [$i32 + $i33], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39562
bge_then.39563:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39564
be_then.39564:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39562
be_else.39564:
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
	b       be_cont.39562
be_else.39562:
	li      0, $i6
.count stack_load
	load    [$sp + 2], $i3
.count stack_load
	load    [$sp + 1], $i5
.count move_args
	mov     $i33, $i2
.count move_args
	mov     $i32, $i4
	call    try_exploit_neighbors.3046
be_cont.39562:
	li      255, $i10
	load    [min_caml_rgb + 0], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	bg      $i1, $i10, ble_else.39565
ble_then.39565:
	bge     $i1, 0, ble_cont.39565
bl_then.39566:
	li      0, $i1
.count b_cont
	b       ble_cont.39565
ble_else.39565:
	li      255, $i1
ble_cont.39565:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
	load    [min_caml_rgb + 1], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	bg      $i1, $i10, ble_else.39567
ble_then.39567:
	bge     $i1, 0, ble_cont.39567
bl_then.39568:
	li      0, $i1
.count b_cont
	b       ble_cont.39567
ble_else.39567:
	li      255, $i1
ble_cont.39567:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
	load    [min_caml_rgb + 2], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	bg      $i1, $i10, ble_else.39569
ble_then.39569:
	bge     $i1, 0, ble_cont.39569
bl_then.39570:
	li      0, $i1
.count b_cont
	b       ble_cont.39569
ble_else.39569:
	li      255, $i1
ble_cont.39569:
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
	load    [min_caml_image_size + 1], $i1
	bg      $i1, $i2, ble_else.39571
ble_then.39571:
	ret
ble_else.39571:
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
	sub     $i1, 1, $i1
	ble     $i1, $i2, bg_cont.39572
bg_then.39572:
	add     $i2, 1, $i1
	load    [min_caml_scan_pitch + 0], $f10
	load    [min_caml_image_center + 1], $i10
	sub     $i1, $i10, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f35
	fmul    $f10, $f35, $f35
	load    [min_caml_screeny_dir + 0], $f36
	fmul    $f35, $f36, $f36
	load    [min_caml_screenz_dir + 0], $f37
	fadd    $f36, $f37, $f2
	load    [min_caml_screeny_dir + 1], $f36
	fmul    $f35, $f36, $f36
	load    [min_caml_screenz_dir + 1], $f37
	fadd    $f36, $f37, $f3
	load    [min_caml_screeny_dir + 2], $f36
	fmul    $f35, $f36, $f35
	load    [min_caml_screenz_dir + 2], $f36
	fadd    $f35, $f36, $f4
	load    [min_caml_image_size + 0], $i30
	sub     $i30, 1, $i3
.count move_args
	mov     $i5, $i2
.count move_args
	mov     $i6, $i4
	call    pretrace_pixels.3062
bg_cont.39572:
	li      0, $i32
	load    [min_caml_image_size + 0], $i33
	ble     $i33, 0, bg_cont.39573
bg_then.39573:
.count stack_load
	load    [$sp + 5], $i33
	load    [$i33 + 0], $i34
	load    [$i34 + 0], $i34
	load    [$i34 + 0], $f35
	store   $f35, [min_caml_rgb + 0]
	load    [$i34 + 1], $f35
	store   $f35, [min_caml_rgb + 1]
	load    [$i34 + 2], $f35
	store   $f35, [min_caml_rgb + 2]
	load    [min_caml_image_size + 1], $i34
.count stack_load
	load    [$sp + 4], $i35
	add     $i35, 1, $i36
	bg      $i34, $i36, ble_else.39574
ble_then.39574:
	li      0, $i34
.count b_cont
	b       ble_cont.39574
ble_else.39574:
	bg      $i35, 0, ble_else.39575
ble_then.39575:
	li      0, $i34
.count b_cont
	b       ble_cont.39575
ble_else.39575:
	load    [min_caml_image_size + 0], $i34
	bg      $i34, 1, ble_else.39576
ble_then.39576:
	li      0, $i34
.count b_cont
	b       ble_cont.39576
ble_else.39576:
	li      0, $i34
ble_cont.39576:
ble_cont.39575:
ble_cont.39574:
	bne     $i34, 0, be_else.39577
be_then.39577:
	load    [$i33 + 0], $i2
	li      0, $i32
	load    [$i2 + 2], $i33
	load    [$i33 + 0], $i33
	bl      $i33, 0, be_cont.39577
bge_then.39578:
	load    [$i2 + 3], $i33
	load    [$i33 + 0], $i33
	bne     $i33, 0, be_else.39579
be_then.39579:
	li      1, $i3
	call    do_without_neighbors.3030
.count b_cont
	b       be_cont.39577
be_else.39579:
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
	b       be_cont.39577
be_else.39577:
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
be_cont.39577:
	load    [min_caml_rgb + 0], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	li      255, $i10
	bg      $i1, $i10, ble_else.39580
ble_then.39580:
	bge     $i1, 0, ble_cont.39580
bl_then.39581:
	li      0, $i1
.count b_cont
	b       ble_cont.39580
ble_else.39580:
	li      255, $i1
ble_cont.39580:
	mov     $i1, $i2
	call    min_caml_write
	load    [min_caml_rgb + 1], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	li      255, $i10
	bg      $i1, $i10, ble_else.39582
ble_then.39582:
	bge     $i1, 0, ble_cont.39582
bl_then.39583:
	li      0, $i1
.count b_cont
	b       ble_cont.39582
ble_else.39582:
	li      255, $i1
ble_cont.39582:
	mov     $i1, $i2
	call    min_caml_write
	li      255, $i10
	load    [min_caml_rgb + 2], $f2
	call    min_caml_int_of_float
.count move_ret
	mov     $f1, $i1
	bg      $i1, $i10, ble_else.39584
ble_then.39584:
	bge     $i1, 0, ble_cont.39584
bl_then.39585:
	li      0, $i1
.count b_cont
	b       ble_cont.39584
ble_else.39584:
	li      255, $i1
ble_cont.39584:
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
bg_cont.39573:
	load    [min_caml_image_size + 1], $i1
.count stack_load
	load    [$sp + 4], $i10
	add     $i10, 1, $i10
	bg      $i1, $i10, ble_else.39586
ble_then.39586:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
ble_else.39586:
.count stack_store
	store   $i10, [$sp + 7]
	sub     $i1, 1, $i1
.count stack_load
	load    [$sp + 1], $i11
	add     $i11, 2, $i11
	bl      $i11, 5, bge_cont.39587
bge_then.39587:
	sub     $i11, 5, $i11
bge_cont.39587:
.count stack_store
	store   $i11, [$sp + 8]
	ble     $i1, $i10, bg_cont.39588
bg_then.39588:
	add     $i10, 1, $i1
	load    [min_caml_image_size + 0], $i10
	sub     $i10, 1, $i10
	load    [min_caml_screeny_dir + 0], $f10
	load    [min_caml_scan_pitch + 0], $f11
	load    [min_caml_image_center + 1], $i12
	sub     $i1, $i12, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f35
	fmul    $f11, $f35, $f35
	fmul    $f35, $f10, $f36
	load    [min_caml_screenz_dir + 0], $f37
	fadd    $f36, $f37, $f2
	load    [min_caml_screeny_dir + 1], $f36
	fmul    $f35, $f36, $f36
	load    [min_caml_screenz_dir + 1], $f37
	fadd    $f36, $f37, $f3
	load    [min_caml_screeny_dir + 2], $f36
	fmul    $f35, $f36, $f35
	load    [min_caml_screenz_dir + 2], $f36
	fadd    $f35, $f36, $f4
.count stack_load
	load    [$sp + 3], $i2
.count move_args
	mov     $i10, $i3
.count move_args
	mov     $i11, $i4
	call    pretrace_pixels.3062
bg_cont.39588:
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
	bl      $i3, 0, bge_else.39590
bge_then.39590:
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
	bl      $i19, 0, bge_else.39591
bge_then.39591:
	call    create_pixel.3087
.count move_ret
	mov     $i1, $i10
.count storer
	add     $i21, $i19, $tmp
	store   $i10, [$tmp + 0]
	sub     $i19, 1, $i10
	bl      $i10, 0, bge_else.39592
bge_then.39592:
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
	bl      $i19, 0, bge_else.39593
bge_then.39593:
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
bge_else.39593:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39592:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39591:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 3, $sp
	mov     $i21, $i1
	ret
bge_else.39590:
	mov     $i2, $i1
	ret
.end init_line_elements

######################################################################
.begin cordic_rec
cordic_rec.6377.12642:
	bne     $i2, 25, be_else.39594
be_then.39594:
	mov     $f4, $f1
	ret
be_else.39594:
	add     $i2, 1, $i1
	load    [min_caml_atan_table + $i2], $f1
	bg      $f3, $f0, ble_else.39595
ble_then.39595:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39596
be_then.39596:
	ret
be_else.39596:
	fmul    $f5, $f3, $f4
	fsub    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
.count load_float
	load    [f.34775], $f3
	fmul    $f5, $f3, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f2, $f6
	bg      $f2, $f0, ble_else.39597
ble_then.39597:
	fsub    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12642
ble_else.39597:
	fadd    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12642
ble_else.39595:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39598
be_then.39598:
	ret
be_else.39598:
	fmul    $f5, $f3, $f4
	fadd    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
.count load_float
	load    [f.34775], $f3
	fmul    $f5, $f3, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f2, $f6
	bg      $f2, $f0, ble_else.39599
ble_then.39599:
	fsub    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12642
ble_else.39599:
	fadd    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12642
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6377.12539:
	bne     $i2, 25, be_else.39600
be_then.39600:
	mov     $f4, $f1
	ret
be_else.39600:
	add     $i2, 1, $i1
	load    [min_caml_atan_table + $i2], $f1
	bg      $f3, $f0, ble_else.39601
ble_then.39601:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39602
be_then.39602:
	ret
be_else.39602:
	fmul    $f5, $f3, $f4
	fsub    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f2
.count load_float
	load    [f.34775], $f3
	fmul    $f5, $f3, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f2, $f6
	bg      $f2, $f0, ble_else.39603
ble_then.39603:
	fsub    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12539
ble_else.39603:
	fadd    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12539
ble_else.39601:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39604
be_then.39604:
	ret
be_else.39604:
	fmul    $f5, $f3, $f4
	fadd    $f2, $f4, $f4
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f2
.count load_float
	load    [f.34775], $f3
	fmul    $f5, $f3, $f5
	add     $i1, 1, $i2
	fmul    $f5, $f2, $f6
	bg      $f2, $f0, ble_else.39605
ble_then.39605:
	fsub    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fadd    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fsub    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12539
ble_else.39605:
	fadd    $f4, $f6, $f6
	fmul    $f5, $f4, $f4
	fsub    $f2, $f4, $f2
	load    [min_caml_atan_table + $i1], $f4
	fadd    $f1, $f4, $f4
	fmul    $f5, $f3, $f5
.count move_args
	mov     $f2, $f3
.count move_args
	mov     $f6, $f2
	b       cordic_rec.6377.12539
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20863:
	bne     $i2, 25, be_else.39606
be_then.39606:
	mov     $f4, $f1
	ret
be_else.39606:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39607
ble_then.39607:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39608
be_then.39608:
	ret
be_else.39608:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39609
ble_then.39609:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20863
ble_else.39609:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20863
ble_else.39607:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39610
be_then.39610:
	ret
be_else.39610:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39611
ble_then.39611:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20863
ble_else.39611:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20863
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.20945:
	bne     $i2, 25, be_else.39612
be_then.39612:
	mov     $f4, $f1
	ret
be_else.39612:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39613
ble_then.39613:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39614
be_then.39614:
	ret
be_else.39614:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39615
ble_then.39615:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20945
ble_else.39615:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20945
ble_else.39613:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39616
be_then.39616:
	ret
be_else.39616:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39617
ble_then.39617:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20945
ble_else.39617:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.20945
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.21027:
	bne     $i2, 25, be_else.39618
be_then.39618:
	mov     $f4, $f1
	ret
be_else.39618:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39619
ble_then.39619:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39620
be_then.39620:
	ret
be_else.39620:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39621
ble_then.39621:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21027
ble_else.39621:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21027
ble_else.39619:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39622
be_then.39622:
	ret
be_else.39622:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39623
ble_then.39623:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21027
ble_else.39623:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21027
.end cordic_rec

######################################################################
.begin cordic_rec
cordic_rec.6342.21109:
	bne     $i2, 25, be_else.39624
be_then.39624:
	mov     $f4, $f1
	ret
be_else.39624:
	add     $i2, 1, $i1
	fmul    $f6, $f3, $f1
	bg      $f2, $f5, ble_else.39625
ble_then.39625:
	fsub    $f4, $f1, $f1
	bne     $i1, 25, be_else.39626
be_then.39626:
	ret
be_else.39626:
	fmul    $f6, $f4, $f4
	fadd    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fsub    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39627
ble_then.39627:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21109
ble_else.39627:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21109
ble_else.39625:
	fadd    $f4, $f1, $f1
	bne     $i1, 25, be_else.39628
be_then.39628:
	ret
be_else.39628:
	fmul    $f6, $f4, $f4
	fsub    $f3, $f4, $f3
	load    [min_caml_atan_table + $i2], $f4
	fadd    $f5, $f4, $f4
.count load_float
	load    [f.34775], $f5
	fmul    $f6, $f5, $f6
	add     $i1, 1, $i2
	fmul    $f6, $f1, $f7
	bg      $f2, $f4, ble_else.39629
ble_then.39629:
	fadd    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fsub    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fsub    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21109
ble_else.39629:
	fsub    $f3, $f7, $f7
	fmul    $f6, $f3, $f3
	fadd    $f1, $f3, $f1
	load    [min_caml_atan_table + $i1], $f3
	fadd    $f4, $f3, $f3
	fmul    $f6, $f5, $f6
.count move_args
	mov     $f1, $f4
.count move_args
	mov     $f3, $f5
.count move_args
	mov     $f7, $f3
	b       cordic_rec.6342.21109
.end cordic_rec

######################################################################
.begin calc_dirvec
calc_dirvec.3099:
	bl      $i2, 5, bge_else.39630
bge_then.39630:
	load    [min_caml_dirvecs + $i3], $i1
	load    [$i1 + $i4], $i2
	load    [$i2 + 0], $i2
	fmul    $f2, $f2, $f1
	fmul    $f3, $f3, $f4
	fadd    $f1, $f4, $f1
.count load_float
	load    [f.34799], $f4
	fadd    $f1, $f4, $f1
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
bge_else.39630:
.count stack_move
	sub     $sp, 9, $sp
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
.count load_float
	load    [f.34799], $f11
.count stack_store
	store   $f11, [$sp + 6]
	finv    $f10, $f10
	li      1, $i2
.count load_float
	load    [f.34775], $f5
	bg      $f10, $f0, ble_else.39631
ble_then.39631:
	fsub    $f11, $f10, $f2
	fadd    $f10, $f11, $f3
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f4
	call    cordic_rec.6377.12642
.count move_ret
	mov     $f1, $f14
.count b_cont
	b       ble_cont.39631
ble_else.39631:
	fadd    $f11, $f10, $f2
	fsub    $f10, $f11, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.12642
.count move_ret
	mov     $f1, $f14
ble_cont.39631:
.count stack_load
	load    [$sp + 3], $f15
	fmul    $f14, $f15, $f14
	bg      $f0, $f14, ble_else.39632
ble_then.39632:
.count load_float
	load    [f.34777], $f16
	bg      $f16, $f14, ble_else.39633
ble_then.39633:
.count load_float
	load    [f.34780], $f16
	bg      $f16, $f14, ble_else.39634
ble_then.39634:
.count load_float
	load    [f.34781], $f16
	bg      $f16, $f14, ble_else.39635
ble_then.39635:
	fsub    $f14, $f16, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39635:
	fsub    $f16, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39634:
	fsub    $f16, $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.39636
ble_then.39636:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.21109
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39636:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.21109
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39633:
.count move_args
	mov     $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f14, $f0, ble_else.39637
ble_then.39637:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.21027
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39637:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.21027
.count move_ret
	mov     $f1, $f16
.count b_cont
	b       ble_cont.39632
ble_else.39632:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f16
	fneg    $f16, $f16
ble_cont.39632:
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
	store   $f10, [$sp + 7]
	fmul    $f10, $f10, $f10
.count stack_load
	load    [$sp + 4], $f11
	fadd    $f10, $f11, $f10
	fsqrt   $f10, $f10
.count stack_store
	store   $f10, [$sp + 8]
	finv    $f10, $f10
	li      1, $i2
.count load_float
	load    [f.34775], $f5
.count stack_load
	load    [$sp + 6], $f11
	bg      $f10, $f0, ble_else.39638
ble_then.39638:
	fsub    $f11, $f10, $f2
	fadd    $f10, $f11, $f3
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f4
	call    cordic_rec.6377.12539
.count move_ret
	mov     $f1, $f14
.count b_cont
	b       ble_cont.39638
ble_else.39638:
	fadd    $f11, $f10, $f2
	fsub    $f10, $f11, $f3
	load    [min_caml_atan_table + 0], $f4
	call    cordic_rec.6377.12539
.count move_ret
	mov     $f1, $f14
ble_cont.39638:
.count stack_load
	load    [$sp + 2], $f16
	fmul    $f14, $f16, $f14
	bg      $f0, $f14, ble_else.39639
ble_then.39639:
	bg      $f17, $f14, ble_else.39640
ble_then.39640:
.count load_float
	load    [f.34780], $f18
	bg      $f18, $f14, ble_else.39641
ble_then.39641:
.count load_float
	load    [f.34781], $f18
	bg      $f18, $f14, ble_else.39642
ble_then.39642:
	fsub    $f14, $f18, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39642:
	fsub    $f18, $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39641:
	fsub    $f18, $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f2, $f0, ble_else.39643
ble_then.39643:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.20945
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39643:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.20945
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39640:
.count move_args
	mov     $f14, $f2
	li      1, $i2
.count load_float
	load    [f.34775], $f6
.count load_float
	load    [f.34778], $f3
	bg      $f14, $f0, ble_else.39644
ble_then.39644:
.count load_float
	load    [f.34779], $f4
	load    [min_caml_atan_table + 0], $f10
	fneg    $f10, $f5
	call    cordic_rec.6342.20863
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39644:
	load    [min_caml_atan_table + 0], $f5
.count move_args
	mov     $f3, $f4
	call    cordic_rec.6342.20863
.count move_ret
	mov     $f1, $f18
.count b_cont
	b       ble_cont.39639
ble_else.39639:
	fneg    $f14, $f2
	call    sin.2657
.count move_ret
	mov     $f1, $f18
	fneg    $f18, $f18
ble_cont.39639:
	fsub    $f17, $f14, $f2
	call    sin.2657
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	finv    $f1, $f1
	fmul    $f18, $f1, $f1
.count stack_load
	load    [$sp - 1], $f2
	fmul    $f1, $f2, $f3
.count stack_load
	load    [$sp - 8], $i1
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
	bl      $i2, 0, bge_else.39645
bge_then.39645:
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
	bl      $i2, 0, bge_else.39646
bge_then.39646:
.count stack_store
	store   $i2, [$sp + 6]
	li      0, $i1
.count stack_load
	load    [$sp + 3], $i11
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39647
bge_then.39647:
	sub     $i11, 5, $i11
bge_cont.39647:
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
	bl      $i2, 0, bge_else.39648
bge_then.39648:
.count stack_store
	store   $i2, [$sp + 7]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39649
bge_then.39649:
	sub     $i11, 5, $i11
bge_cont.39649:
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
	bl      $i2, 0, bge_else.39650
bge_then.39650:
.count stack_store
	store   $i2, [$sp + 8]
	li      0, $i1
	add     $i11, 1, $i11
	bl      $i11, 5, bge_cont.39651
bge_then.39651:
	sub     $i11, 5, $i11
bge_cont.39651:
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
bge_else.39650:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39648:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39646:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.39645:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3112:
	bl      $i2, 0, bge_else.39653
bge_then.39653:
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
	bl      $i11, 5, bge_cont.39654
bge_then.39654:
	sub     $i11, 5, $i11
bge_cont.39654:
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
	bl      $i11, 5, bge_cont.39655
bge_then.39655:
	sub     $i11, 5, $i11
bge_cont.39655:
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
	bl      $i12, 5, bge_cont.39656
bge_then.39656:
	sub     $i12, 5, $i12
bge_cont.39656:
	mov     $i12, $i3
.count stack_load
	load    [$sp + 8], $f2
.count move_args
	mov     $i10, $i4
	call    calc_dirvecs.3107
.count stack_load
	load    [$sp + 3], $i1
	sub     $i1, 1, $i2
	bl      $i2, 0, bge_else.39657
bge_then.39657:
.count stack_store
	store   $i2, [$sp + 13]
.count stack_load
	load    [$sp + 2], $i1
	add     $i1, 2, $i1
	bl      $i1, 5, bge_cont.39658
bge_then.39658:
	sub     $i1, 5, $i1
bge_cont.39658:
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
	bl      $i11, 5, bge_cont.39659
bge_then.39659:
	sub     $i11, 5, $i11
bge_cont.39659:
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
	bl      $i12, 5, bge_cont.39660
bge_then.39660:
	sub     $i12, 5, $i12
bge_cont.39660:
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
bge_else.39657:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 19, $sp
	ret
bge_else.39653:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3118:
	bl      $i3, 0, bge_else.39662
bge_then.39662:
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
	load    [min_caml_n_objects + 0], $i2
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
	bl      $i10, 0, bge_else.39663
bge_then.39663:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 4]
	load    [min_caml_n_objects + 0], $i2
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
	bl      $i10, 0, bge_else.39664
bge_then.39664:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 5]
	load    [min_caml_n_objects + 0], $i2
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
	bl      $i10, 0, bge_else.39665
bge_then.39665:
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 6]
	load    [min_caml_n_objects + 0], $i2
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
bge_else.39665:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39664:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39663:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 7, $sp
	ret
bge_else.39662:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3121:
	bl      $i2, 0, bge_else.39666
bge_then.39666:
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_n_objects + 0], $i2
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
	bl      $i10, 0, bge_else.39667
bge_then.39667:
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_n_objects + 0], $i2
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
bge_else.39667:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 10, $sp
	ret
bge_else.39666:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3123:
	bl      $i3, 0, bge_else.39668
bge_then.39668:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
.count stack_store
	store   $i3, [$sp + 2]
	load    [min_caml_n_objects + 0], $i10
	sub     $i10, 1, $i10
	load    [$i2 + $i3], $i11
	bl      $i10, 0, bge_cont.39669
bge_then.39669:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39670
be_then.39670:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39671
be_then.39671:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39671
be_else.39671:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39672
ble_then.39672:
	li      0, $i18
.count b_cont
	b       ble_cont.39672
ble_else.39672:
	li      1, $i18
ble_cont.39672:
	bne     $i17, 0, be_else.39673
be_then.39673:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39673
be_else.39673:
	bne     $i18, 0, be_else.39674
be_then.39674:
	li      1, $i17
.count b_cont
	b       be_cont.39674
be_else.39674:
	li      0, $i17
be_cont.39674:
be_cont.39673:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39675
be_then.39675:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39675
be_else.39675:
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39675:
be_cont.39671:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39676
be_then.39676:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39676
be_else.39676:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39677
ble_then.39677:
	li      0, $i18
.count b_cont
	b       ble_cont.39677
ble_else.39677:
	li      1, $i18
ble_cont.39677:
	bne     $i17, 0, be_else.39678
be_then.39678:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39678
be_else.39678:
	bne     $i18, 0, be_else.39679
be_then.39679:
	li      1, $i17
.count b_cont
	b       be_cont.39679
be_else.39679:
	li      0, $i17
be_cont.39679:
be_cont.39678:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39680
be_then.39680:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39680
be_else.39680:
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39680:
be_cont.39676:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39681
be_then.39681:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39670
be_else.39681:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39682
ble_then.39682:
	li      0, $i18
.count b_cont
	b       ble_cont.39682
ble_else.39682:
	li      1, $i18
ble_cont.39682:
	bne     $i17, 0, be_else.39683
be_then.39683:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39683
be_else.39683:
	bne     $i18, 0, be_else.39684
be_then.39684:
	li      1, $i17
.count b_cont
	b       be_cont.39684
be_else.39684:
	li      0, $i17
be_cont.39684:
be_cont.39683:
	load    [$i13 + 4], $i18
	load    [$i18 + 2], $f10
	bne     $i17, 0, be_cont.39685
be_then.39685:
	fneg    $f10, $f10
be_cont.39685:
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
	b       be_cont.39670
be_else.39670:
	bne     $i14, 2, be_else.39686
be_then.39686:
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
	bg      $f10, $f0, ble_else.39687
ble_then.39687:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39686
ble_else.39687:
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
	b       be_cont.39686
be_else.39686:
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
	bne     $i17, 0, be_else.39688
be_then.39688:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39688
be_else.39688:
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
be_cont.39688:
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
	bne     $i17, 0, be_else.39689
be_then.39689:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39690
be_then.39690:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39689
be_else.39690:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39689
be_else.39689:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39691
be_then.39691:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39691
be_else.39691:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39691:
be_cont.39689:
be_cont.39686:
be_cont.39670:
bge_cont.39669:
.count stack_load
	load    [$sp + 2], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39692
bge_then.39692:
.count stack_store
	store   $i10, [$sp + 3]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i11
.count stack_load
	load    [$sp + 1], $i12
	load    [$i12 + $i10], $i10
	bl      $i11, 0, bge_cont.39693
bge_then.39693:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39694
be_then.39694:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39695
be_then.39695:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39695
be_else.39695:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39696
ble_then.39696:
	li      0, $i18
.count b_cont
	b       ble_cont.39696
ble_else.39696:
	li      1, $i18
ble_cont.39696:
	bne     $i17, 0, be_else.39697
be_then.39697:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39697
be_else.39697:
	bne     $i18, 0, be_else.39698
be_then.39698:
	li      1, $i17
.count b_cont
	b       be_cont.39698
be_else.39698:
	li      0, $i17
be_cont.39698:
be_cont.39697:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39699
be_then.39699:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39699
be_else.39699:
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39699:
be_cont.39695:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39700
be_then.39700:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39700
be_else.39700:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39701
ble_then.39701:
	li      0, $i18
.count b_cont
	b       ble_cont.39701
ble_else.39701:
	li      1, $i18
ble_cont.39701:
	bne     $i17, 0, be_else.39702
be_then.39702:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39702
be_else.39702:
	bne     $i18, 0, be_else.39703
be_then.39703:
	li      1, $i17
.count b_cont
	b       be_cont.39703
be_else.39703:
	li      0, $i17
be_cont.39703:
be_cont.39702:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39704
be_then.39704:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39704
be_else.39704:
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39704:
be_cont.39700:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39705
be_then.39705:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39694
be_else.39705:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39706
ble_then.39706:
	li      0, $i19
.count b_cont
	b       ble_cont.39706
ble_else.39706:
	li      1, $i19
ble_cont.39706:
	bne     $i17, 0, be_else.39707
be_then.39707:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39707
be_else.39707:
	bne     $i19, 0, be_else.39708
be_then.39708:
	li      1, $i17
.count b_cont
	b       be_cont.39708
be_else.39708:
	li      0, $i17
be_cont.39708:
be_cont.39707:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.39709
be_then.39709:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39694
be_else.39709:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39694
be_else.39694:
	bne     $i14, 2, be_else.39710
be_then.39710:
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
	bg      $f10, $f0, ble_else.39711
ble_then.39711:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39710
ble_else.39711:
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
	b       be_cont.39710
be_else.39710:
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
	bne     $i17, 0, be_else.39712
be_then.39712:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39712
be_else.39712:
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
be_cont.39712:
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
	bne     $i17, 0, be_else.39713
be_then.39713:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39714
be_then.39714:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39713
be_else.39714:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39713
be_else.39713:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39715
be_then.39715:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39715
be_else.39715:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39715:
be_cont.39713:
be_cont.39710:
be_cont.39694:
bge_cont.39693:
.count stack_load
	load    [$sp + 3], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.39716
bge_then.39716:
	load    [min_caml_n_objects + 0], $i17
	sub     $i17, 1, $i3
.count stack_load
	load    [$sp + 1], $i17
	load    [$i17 + $i16], $i2
	call    iter_setup_dirvec_constants.2905
	sub     $i16, 1, $i10
	bl      $i10, 0, bge_else.39717
bge_then.39717:
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i11
	bl      $i11, 0, bge_else.39718
bge_then.39718:
	load    [$i17 + $i10], $i12
	load    [$i12 + 1], $i13
	load    [min_caml_objects + $i11], $i14
	load    [$i14 + 1], $i15
	load    [$i12 + 0], $i16
.count stack_store
	store   $i10, [$sp + 4]
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.39719
be_then.39719:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i18
	load    [$i16 + 0], $f10
	bne     $f10, $f0, be_else.39720
be_then.39720:
	store   $f0, [$i18 + 1]
.count b_cont
	b       be_cont.39720
be_else.39720:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.39721
ble_then.39721:
	li      0, $i20
.count b_cont
	b       ble_cont.39721
ble_else.39721:
	li      1, $i20
ble_cont.39721:
	bne     $i19, 0, be_else.39722
be_then.39722:
	mov     $i20, $i19
.count b_cont
	b       be_cont.39722
be_else.39722:
	bne     $i20, 0, be_else.39723
be_then.39723:
	li      1, $i19
.count b_cont
	b       be_cont.39723
be_else.39723:
	li      0, $i19
be_cont.39723:
be_cont.39722:
	load    [$i14 + 4], $i20
	load    [$i20 + 0], $f10
	bne     $i19, 0, be_else.39724
be_then.39724:
	fneg    $f10, $f10
	store   $f10, [$i18 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
.count b_cont
	b       be_cont.39724
be_else.39724:
	store   $f10, [$i18 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i16 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 1]
be_cont.39724:
be_cont.39720:
	load    [$i16 + 1], $f10
	bne     $f10, $f0, be_else.39725
be_then.39725:
	store   $f0, [$i18 + 3]
.count b_cont
	b       be_cont.39725
be_else.39725:
	load    [$i14 + 6], $i19
	bg      $f0, $f10, ble_else.39726
ble_then.39726:
	li      0, $i20
.count b_cont
	b       ble_cont.39726
ble_else.39726:
	li      1, $i20
ble_cont.39726:
	bne     $i19, 0, be_else.39727
be_then.39727:
	mov     $i20, $i19
.count b_cont
	b       be_cont.39727
be_else.39727:
	bne     $i20, 0, be_else.39728
be_then.39728:
	li      1, $i19
.count b_cont
	b       be_cont.39728
be_else.39728:
	li      0, $i19
be_cont.39728:
be_cont.39727:
	load    [$i14 + 4], $i20
	load    [$i20 + 1], $f10
	bne     $i19, 0, be_else.39729
be_then.39729:
	fneg    $f10, $f10
	store   $f10, [$i18 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
.count b_cont
	b       be_cont.39729
be_else.39729:
	store   $f10, [$i18 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i16 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 3]
be_cont.39729:
be_cont.39725:
	load    [$i16 + 2], $f10
	bne     $f10, $f0, be_else.39730
be_then.39730:
	store   $f0, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.39730
be_else.39730:
	load    [$i14 + 6], $i19
	load    [$i14 + 4], $i20
	bg      $f0, $f10, ble_else.39731
ble_then.39731:
	li      0, $i21
.count b_cont
	b       ble_cont.39731
ble_else.39731:
	li      1, $i21
ble_cont.39731:
	bne     $i19, 0, be_else.39732
be_then.39732:
	mov     $i21, $i19
.count b_cont
	b       be_cont.39732
be_else.39732:
	bne     $i21, 0, be_else.39733
be_then.39733:
	li      1, $i19
.count b_cont
	b       be_cont.39733
be_else.39733:
	li      0, $i19
be_cont.39733:
be_cont.39732:
	load    [$i20 + 2], $f10
	bne     $i19, 0, be_else.39734
be_then.39734:
	fneg    $f10, $f10
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
.count b_cont
	b       be_cont.39734
be_else.39734:
	store   $f10, [$i18 + 4]
	load    [$i16 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i18 + 5]
	mov     $i18, $i16
be_cont.39734:
be_cont.39730:
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
be_else.39719:
	bne     $i15, 2, be_else.39735
be_then.39735:
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
	bg      $f10, $f0, ble_else.39736
ble_then.39736:
	store   $f0, [$i18 + 0]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39735
ble_else.39736:
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
	b       be_cont.39735
be_else.39735:
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
	bne     $i19, 0, be_else.39737
be_then.39737:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39737
be_else.39737:
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
be_cont.39737:
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
	bne     $i19, 0, be_else.39738
be_then.39738:
	store   $f11, [$i18 + 1]
	store   $f13, [$i18 + 2]
	store   $f15, [$i18 + 3]
	bne     $f10, $f0, be_else.39739
be_then.39739:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39738
be_else.39739:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39738
be_else.39738:
	load    [$i14 + 9], $i19
	load    [$i14 + 9], $i20
	load    [$i19 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i20 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i18 + 1]
	load    [$i14 + 9], $i19
	load    [$i16 + 2], $f11
	load    [$i19 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i18 + 2]
	load    [$i16 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i16 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i18 + 3]
	bne     $f10, $f0, be_else.39740
be_then.39740:
	store   $i18, [$tmp + 0]
.count b_cont
	b       be_cont.39740
be_else.39740:
	finv    $f10, $f10
	store   $f10, [$i18 + 4]
	store   $i18, [$tmp + 0]
be_cont.39740:
be_cont.39738:
be_cont.39735:
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
bge_else.39718:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	sub     $i10, 1, $i3
.count move_args
	mov     $i17, $i2
	b       init_dirvec_constants.3123
bge_else.39717:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39716:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39692:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.39668:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3126:
	bl      $i2, 0, bge_else.39741
bge_then.39741:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $i2, [$sp + 1]
	load    [min_caml_n_objects + 0], $i10
	sub     $i10, 1, $i10
	load    [min_caml_dirvecs + $i2], $i11
.count stack_store
	store   $i11, [$sp + 2]
	load    [$i11 + 119], $i11
	bl      $i10, 0, bge_cont.39742
bge_then.39742:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39743
be_then.39743:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39744
be_then.39744:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39744
be_else.39744:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39745
ble_then.39745:
	li      0, $i18
.count b_cont
	b       ble_cont.39745
ble_else.39745:
	li      1, $i18
ble_cont.39745:
	bne     $i17, 0, be_else.39746
be_then.39746:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39746
be_else.39746:
	bne     $i18, 0, be_else.39747
be_then.39747:
	li      1, $i17
.count b_cont
	b       be_cont.39747
be_else.39747:
	li      0, $i17
be_cont.39747:
be_cont.39746:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39748
be_then.39748:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39748
be_else.39748:
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39748:
be_cont.39744:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39749
be_then.39749:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39749
be_else.39749:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39750
ble_then.39750:
	li      0, $i18
.count b_cont
	b       ble_cont.39750
ble_else.39750:
	li      1, $i18
ble_cont.39750:
	bne     $i17, 0, be_else.39751
be_then.39751:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39751
be_else.39751:
	bne     $i18, 0, be_else.39752
be_then.39752:
	li      1, $i17
.count b_cont
	b       be_cont.39752
be_else.39752:
	li      0, $i17
be_cont.39752:
be_cont.39751:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39753
be_then.39753:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39753
be_else.39753:
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39753:
be_cont.39749:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39754
be_then.39754:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i16, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39743
be_else.39754:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39755
ble_then.39755:
	li      0, $i19
.count b_cont
	b       ble_cont.39755
ble_else.39755:
	li      1, $i19
ble_cont.39755:
	bne     $i17, 0, be_else.39756
be_then.39756:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39756
be_else.39756:
	bne     $i19, 0, be_else.39757
be_then.39757:
	li      1, $i17
.count b_cont
	b       be_cont.39757
be_else.39757:
	li      0, $i17
be_cont.39757:
be_cont.39756:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i17, 0, be_else.39758
be_then.39758:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39743
be_else.39758:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39743
be_else.39743:
	bne     $i14, 2, be_else.39759
be_then.39759:
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
	bg      $f10, $f0, ble_else.39760
ble_then.39760:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39759
ble_else.39760:
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
	b       be_cont.39759
be_else.39759:
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
	bne     $i17, 0, be_else.39761
be_then.39761:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39761
be_else.39761:
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
be_cont.39761:
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
	bne     $i17, 0, be_else.39762
be_then.39762:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39763
be_then.39763:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39762
be_else.39763:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39762
be_else.39762:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39764
be_then.39764:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39764
be_else.39764:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39764:
be_cont.39762:
be_cont.39759:
be_cont.39743:
bge_cont.39742:
	load    [min_caml_n_objects + 0], $i16
	sub     $i16, 1, $i3
.count stack_load
	load    [$sp + 2], $i16
	load    [$i16 + 118], $i2
	call    iter_setup_dirvec_constants.2905
	load    [min_caml_n_objects + 0], $i10
	sub     $i10, 1, $i10
	load    [$i16 + 117], $i11
	bl      $i10, 0, bge_cont.39765
bge_then.39765:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39766
be_then.39766:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39767
be_then.39767:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.39767
be_else.39767:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39768
ble_then.39768:
	li      0, $i19
.count b_cont
	b       ble_cont.39768
ble_else.39768:
	li      1, $i19
ble_cont.39768:
	bne     $i18, 0, be_else.39769
be_then.39769:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39769
be_else.39769:
	bne     $i19, 0, be_else.39770
be_then.39770:
	li      1, $i18
.count b_cont
	b       be_cont.39770
be_else.39770:
	li      0, $i18
be_cont.39770:
be_cont.39769:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.39771
be_then.39771:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.39771
be_else.39771:
	store   $f10, [$i17 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.39771:
be_cont.39767:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39772
be_then.39772:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.39772
be_else.39772:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39773
ble_then.39773:
	li      0, $i19
.count b_cont
	b       ble_cont.39773
ble_else.39773:
	li      1, $i19
ble_cont.39773:
	bne     $i18, 0, be_else.39774
be_then.39774:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39774
be_else.39774:
	bne     $i19, 0, be_else.39775
be_then.39775:
	li      1, $i18
.count b_cont
	b       be_cont.39775
be_else.39775:
	li      0, $i18
be_cont.39775:
be_cont.39774:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.39776
be_then.39776:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.39776
be_else.39776:
	store   $f10, [$i17 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.39776:
be_cont.39772:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39777
be_then.39777:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39766
be_else.39777:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.39778
ble_then.39778:
	li      0, $i20
.count b_cont
	b       ble_cont.39778
ble_else.39778:
	li      1, $i20
ble_cont.39778:
	bne     $i18, 0, be_else.39779
be_then.39779:
	mov     $i20, $i18
.count b_cont
	b       be_cont.39779
be_else.39779:
	bne     $i20, 0, be_else.39780
be_then.39780:
	li      1, $i18
.count b_cont
	b       be_cont.39780
be_else.39780:
	li      0, $i18
be_cont.39780:
be_cont.39779:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.39781
be_then.39781:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39766
be_else.39781:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39766
be_else.39766:
	bne     $i14, 2, be_else.39782
be_then.39782:
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
	bg      $f10, $f0, ble_else.39783
ble_then.39783:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39782
ble_else.39783:
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
	b       be_cont.39782
be_else.39782:
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
	bne     $i18, 0, be_else.39784
be_then.39784:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39784
be_else.39784:
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
be_cont.39784:
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
	bne     $i18, 0, be_else.39785
be_then.39785:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.39786
be_then.39786:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39785
be_else.39786:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39785
be_else.39785:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.39787
be_then.39787:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39787
be_else.39787:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39787:
be_cont.39785:
be_cont.39782:
be_cont.39766:
bge_cont.39765:
	li      116, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 1], $i16
	sub     $i16, 1, $i16
	bl      $i16, 0, bge_else.39788
bge_then.39788:
.count stack_store
	store   $i16, [$sp + 3]
	load    [min_caml_n_objects + 0], $i17
	sub     $i17, 1, $i3
	load    [min_caml_dirvecs + $i16], $i16
	load    [$i16 + 119], $i2
	call    iter_setup_dirvec_constants.2905
	load    [min_caml_n_objects + 0], $i10
	sub     $i10, 1, $i10
	load    [$i16 + 118], $i11
	bl      $i10, 0, bge_cont.39789
bge_then.39789:
	load    [$i11 + 1], $i12
	load    [min_caml_objects + $i10], $i13
	load    [$i13 + 1], $i14
	load    [$i11 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39790
be_then.39790:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i17
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39791
be_then.39791:
	store   $f0, [$i17 + 1]
.count b_cont
	b       be_cont.39791
be_else.39791:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39792
ble_then.39792:
	li      0, $i19
.count b_cont
	b       ble_cont.39792
ble_else.39792:
	li      1, $i19
ble_cont.39792:
	bne     $i18, 0, be_else.39793
be_then.39793:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39793
be_else.39793:
	bne     $i19, 0, be_else.39794
be_then.39794:
	li      1, $i18
.count b_cont
	b       be_cont.39794
be_else.39794:
	li      0, $i18
be_cont.39794:
be_cont.39793:
	load    [$i13 + 4], $i19
	load    [$i19 + 0], $f10
	bne     $i18, 0, be_else.39795
be_then.39795:
	fneg    $f10, $f10
	store   $f10, [$i17 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
.count b_cont
	b       be_cont.39795
be_else.39795:
	store   $f10, [$i17 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 1]
be_cont.39795:
be_cont.39791:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39796
be_then.39796:
	store   $f0, [$i17 + 3]
.count b_cont
	b       be_cont.39796
be_else.39796:
	load    [$i13 + 6], $i18
	bg      $f0, $f10, ble_else.39797
ble_then.39797:
	li      0, $i19
.count b_cont
	b       ble_cont.39797
ble_else.39797:
	li      1, $i19
ble_cont.39797:
	bne     $i18, 0, be_else.39798
be_then.39798:
	mov     $i19, $i18
.count b_cont
	b       be_cont.39798
be_else.39798:
	bne     $i19, 0, be_else.39799
be_then.39799:
	li      1, $i18
.count b_cont
	b       be_cont.39799
be_else.39799:
	li      0, $i18
be_cont.39799:
be_cont.39798:
	load    [$i13 + 4], $i19
	load    [$i19 + 1], $f10
	bne     $i18, 0, be_else.39800
be_then.39800:
	fneg    $f10, $f10
	store   $f10, [$i17 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
.count b_cont
	b       be_cont.39800
be_else.39800:
	store   $f10, [$i17 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 3]
be_cont.39800:
be_cont.39796:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39801
be_then.39801:
	store   $f0, [$i17 + 5]
.count storer
	add     $i12, $i10, $tmp
	store   $i17, [$tmp + 0]
	sub     $i10, 1, $i3
.count move_args
	mov     $i11, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39790
be_else.39801:
	load    [$i13 + 6], $i18
	load    [$i13 + 4], $i19
	bg      $f0, $f10, ble_else.39802
ble_then.39802:
	li      0, $i20
.count b_cont
	b       ble_cont.39802
ble_else.39802:
	li      1, $i20
ble_cont.39802:
	bne     $i18, 0, be_else.39803
be_then.39803:
	mov     $i20, $i18
.count b_cont
	b       be_cont.39803
be_else.39803:
	bne     $i20, 0, be_else.39804
be_then.39804:
	li      1, $i18
.count b_cont
	b       be_cont.39804
be_else.39804:
	li      0, $i18
be_cont.39804:
be_cont.39803:
	load    [$i19 + 2], $f10
.count move_args
	mov     $i11, $i2
	sub     $i10, 1, $i3
.count storer
	add     $i12, $i10, $tmp
	bne     $i18, 0, be_else.39805
be_then.39805:
	fneg    $f10, $f10
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39790
be_else.39805:
	store   $f10, [$i17 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i17 + 5]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39790
be_else.39790:
	bne     $i14, 2, be_else.39806
be_then.39806:
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
	bg      $f10, $f0, ble_else.39807
ble_then.39807:
	store   $f0, [$i17 + 0]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39806
ble_else.39807:
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
	b       be_cont.39806
be_else.39806:
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
	bne     $i18, 0, be_else.39808
be_then.39808:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39808
be_else.39808:
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
be_cont.39808:
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
	bne     $i18, 0, be_else.39809
be_then.39809:
	store   $f11, [$i17 + 1]
	store   $f13, [$i17 + 2]
	store   $f15, [$i17 + 3]
	bne     $f10, $f0, be_else.39810
be_then.39810:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39809
be_else.39810:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39809
be_else.39809:
	load    [$i13 + 9], $i18
	load    [$i13 + 9], $i19
	load    [$i18 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i19 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i17 + 1]
	load    [$i13 + 9], $i18
	load    [$i15 + 2], $f11
	load    [$i18 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i17 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i17 + 3]
	bne     $f10, $f0, be_else.39811
be_then.39811:
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39811
be_else.39811:
	finv    $f10, $f10
	store   $f10, [$i17 + 4]
	store   $i17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39811:
be_cont.39809:
be_cont.39806:
be_cont.39790:
bge_cont.39789:
	li      117, $i3
.count move_args
	mov     $i16, $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 3], $i10
	sub     $i10, 1, $i10
	bl      $i10, 0, bge_else.39812
bge_then.39812:
.count stack_store
	store   $i10, [$sp + 4]
	load    [min_caml_n_objects + 0], $i11
	sub     $i11, 1, $i11
	load    [min_caml_dirvecs + $i10], $i10
.count stack_store
	store   $i10, [$sp + 5]
	load    [$i10 + 119], $i10
	bl      $i11, 0, bge_cont.39813
bge_then.39813:
	load    [$i10 + 1], $i12
	load    [min_caml_objects + $i11], $i13
	load    [$i13 + 1], $i14
	load    [$i10 + 0], $i15
.count move_args
	mov     $f0, $f2
	bne     $i14, 1, be_else.39814
be_then.39814:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i15 + 0], $f10
	bne     $f10, $f0, be_else.39815
be_then.39815:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39815
be_else.39815:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39816
ble_then.39816:
	li      0, $i18
.count b_cont
	b       ble_cont.39816
ble_else.39816:
	li      1, $i18
ble_cont.39816:
	bne     $i17, 0, be_else.39817
be_then.39817:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39817
be_else.39817:
	bne     $i18, 0, be_else.39818
be_then.39818:
	li      1, $i17
.count b_cont
	b       be_cont.39818
be_else.39818:
	li      0, $i17
be_cont.39818:
be_cont.39817:
	load    [$i13 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39819
be_then.39819:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39819
be_else.39819:
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39819:
be_cont.39815:
	load    [$i15 + 1], $f10
	bne     $f10, $f0, be_else.39820
be_then.39820:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39820
be_else.39820:
	load    [$i13 + 6], $i17
	bg      $f0, $f10, ble_else.39821
ble_then.39821:
	li      0, $i18
.count b_cont
	b       ble_cont.39821
ble_else.39821:
	li      1, $i18
ble_cont.39821:
	bne     $i17, 0, be_else.39822
be_then.39822:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39822
be_else.39822:
	bne     $i18, 0, be_else.39823
be_then.39823:
	li      1, $i17
.count b_cont
	b       be_cont.39823
be_else.39823:
	li      0, $i17
be_cont.39823:
be_cont.39822:
	load    [$i13 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39824
be_then.39824:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39824
be_else.39824:
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i15 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39824:
be_cont.39820:
	load    [$i15 + 2], $f10
	bne     $f10, $f0, be_else.39825
be_then.39825:
	store   $f0, [$i16 + 5]
.count storer
	add     $i12, $i11, $tmp
	store   $i16, [$tmp + 0]
	sub     $i11, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39814
be_else.39825:
	load    [$i13 + 6], $i17
	load    [$i13 + 4], $i18
	bg      $f0, $f10, ble_else.39826
ble_then.39826:
	li      0, $i19
.count b_cont
	b       ble_cont.39826
ble_else.39826:
	li      1, $i19
ble_cont.39826:
	bne     $i17, 0, be_else.39827
be_then.39827:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39827
be_else.39827:
	bne     $i19, 0, be_else.39828
be_then.39828:
	li      1, $i17
.count b_cont
	b       be_cont.39828
be_else.39828:
	li      0, $i17
be_cont.39828:
be_cont.39827:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i11, 1, $i3
.count storer
	add     $i12, $i11, $tmp
	bne     $i17, 0, be_else.39829
be_then.39829:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39814
be_else.39829:
	store   $f10, [$i16 + 4]
	load    [$i15 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39814
be_else.39814:
	bne     $i14, 2, be_else.39830
be_then.39830:
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
	bg      $f10, $f0, ble_else.39831
ble_then.39831:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39830
ble_else.39831:
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
	b       be_cont.39830
be_else.39830:
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
	bne     $i17, 0, be_else.39832
be_then.39832:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39832
be_else.39832:
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
be_cont.39832:
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
	bne     $i17, 0, be_else.39833
be_then.39833:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39834
be_then.39834:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39833
be_else.39834:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39833
be_else.39833:
	load    [$i13 + 9], $i17
	load    [$i13 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i13 + 9], $i17
	load    [$i15 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i15 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i15 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39835
be_then.39835:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39835
be_else.39835:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39835:
be_cont.39833:
be_cont.39830:
be_cont.39814:
bge_cont.39813:
	li      118, $i3
.count stack_load
	load    [$sp + 5], $i2
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 4], $i23
	sub     $i23, 1, $i23
	bl      $i23, 0, bge_else.39836
bge_then.39836:
	load    [min_caml_dirvecs + $i23], $i2
	li      119, $i3
	call    init_dirvec_constants.3123
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	sub     $i23, 1, $i2
	b       init_vecset_constants.3126
bge_else.39836:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39812:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39788:
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.39741:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3143:
	bl      $i2, 0, bge_else.39837
bge_then.39837:
	load    [min_caml_objects + $i2], $i10
	load    [$i10 + 2], $i11
	bne     $i11, 2, be_else.39838
be_then.39838:
	load    [$i10 + 7], $i11
.count load_float
	load    [f.34799], $f1
	load    [$i11 + 0], $f10
	bg      $f1, $f10, ble_else.39839
ble_then.39839:
	ret
ble_else.39839:
	load    [$i10 + 1], $i11
	bne     $i11, 1, be_else.39840
be_then.39840:
.count stack_move
	sub     $sp, 15, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
	load    [$i10 + 7], $i10
.count stack_store
	store   $i10, [$sp + 3]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i10
	mov     $i10, $i3
.count stack_store
	store   $i3, [$sp + 4]
	load    [min_caml_n_objects + 0], $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	load    [min_caml_light + 0], $f10
.count stack_load
	load    [$sp + 4], $i17
	store   $f10, [$i17 + 0]
	load    [min_caml_light + 1], $f10
	fneg    $f10, $f10
	store   $f10, [$i17 + 1]
	load    [min_caml_light + 2], $f11
	fneg    $f11, $f11
	store   $f11, [$i17 + 2]
	load    [min_caml_n_objects + 0], $i18
	sub     $i18, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 5]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 2], $i10
	add     $i10, $i10, $i10
	add     $i10, $i10, $i10
.count stack_store
	store   $i10, [$sp + 6]
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 3], $i11
	load    [$i11 + 0], $f1
.count stack_load
	load    [$sp + 1], $f12
	fsub    $f12, $f1, $f1
.count stack_store
	store   $f1, [$sp + 7]
	mov     $hp, $i11
	add     $hp, 3, $hp
	store   $f1, [$i11 + 2]
.count stack_load
	load    [$sp + 5], $i12
	store   $i12, [$i11 + 1]
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
	load    [min_caml_n_reflections + 0], $i11
.count stack_store
	store   $i11, [$sp + 8]
	store   $i10, [min_caml_reflections + $i11]
	li      3, $i2
.count move_args
	mov     $f0, $f2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i3
.count stack_store
	store   $i3, [$sp + 9]
	load    [min_caml_n_objects + 0], $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	load    [min_caml_light + 0], $f12
	fneg    $f12, $f12
.count stack_load
	load    [$sp + 9], $i17
	store   $f12, [$i17 + 0]
	load    [min_caml_light + 1], $f13
	store   $f13, [$i17 + 1]
	store   $f11, [$i17 + 2]
	load    [min_caml_n_objects + 0], $i18
	sub     $i18, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 8], $i10
	add     $i10, 1, $i10
.count stack_load
	load    [$sp + 6], $i11
	add     $i11, 2, $i11
	mov     $hp, $i12
	add     $hp, 3, $hp
.count stack_load
	load    [$sp + 7], $i13
	store   $i13, [$i12 + 2]
.count stack_load
	load    [$sp + 10], $i13
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
	store   $i3, [$sp + 11]
	load    [min_caml_n_objects + 0], $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
.count stack_load
	load    [$sp + 11], $i17
	store   $f12, [$i17 + 0]
	store   $f10, [$i17 + 1]
	load    [min_caml_light + 2], $f10
	store   $f10, [$i17 + 2]
	load    [min_caml_n_objects + 0], $i18
	sub     $i18, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 12]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 7], $i1
	add     $i1, 2, $i2
.count stack_load
	load    [$sp - 9], $i3
	add     $i3, 3, $i3
	mov     $hp, $i4
	add     $hp, 3, $hp
.count stack_load
	load    [$sp - 8], $i5
	store   $i5, [$i4 + 2]
.count stack_load
	load    [$sp - 3], $i5
	store   $i5, [$i4 + 1]
	store   $i3, [$i4 + 0]
	mov     $i4, $i3
	store   $i3, [min_caml_reflections + $i2]
	add     $i1, 3, $i1
	store   $i1, [min_caml_n_reflections + 0]
	ret
be_else.39840:
	bne     $i11, 2, be_else.39841
be_then.39841:
.count stack_move
	sub     $sp, 15, $sp
.count stack_store
	store   $ra, [$sp + 0]
.count stack_store
	store   $f1, [$sp + 1]
.count stack_store
	store   $i2, [$sp + 2]
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
	store   $i3, [$sp + 13]
	load    [min_caml_n_objects + 0], $i2
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i16
	load    [min_caml_light + 0], $f11
.count load_float
	load    [f.34785], $f12
	load    [$i11 + 0], $f13
	fmul    $f12, $f13, $f14
	fmul    $f11, $f13, $f13
	load    [min_caml_light + 1], $f15
	load    [$i10 + 1], $f16
	fmul    $f15, $f16, $f17
	fadd    $f13, $f17, $f13
	load    [min_caml_light + 2], $f17
	load    [$i10 + 2], $f18
	fmul    $f17, $f18, $f19
	fadd    $f13, $f19, $f13
	fmul    $f14, $f13, $f14
	fsub    $f14, $f11, $f11
.count stack_load
	load    [$sp + 13], $i17
	store   $f11, [$i17 + 0]
	fmul    $f12, $f16, $f11
	fmul    $f11, $f13, $f11
	fsub    $f11, $f15, $f11
	store   $f11, [$i17 + 1]
	fmul    $f12, $f18, $f11
	fmul    $f11, $f13, $f11
	fsub    $f11, $f17, $f11
	store   $f11, [$i17 + 2]
	load    [min_caml_n_objects + 0], $i18
	sub     $i18, 1, $i3
	mov     $hp, $i18
	add     $hp, 2, $hp
	store   $i16, [$i18 + 1]
	store   $i17, [$i18 + 0]
	mov     $i18, $i2
.count stack_store
	store   $i2, [$sp + 14]
	call    iter_setup_dirvec_constants.2905
.count stack_load
	load    [$sp + 0], $ra
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 14], $f1
	fsub    $f1, $f10, $f1
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
	load    [min_caml_n_reflections + 0], $i2
	store   $i1, [min_caml_reflections + $i2]
	add     $i2, 1, $i1
	store   $i1, [min_caml_n_reflections + 0]
	ret
be_else.39841:
	ret
be_else.39838:
	ret
bge_else.39837:
	ret
.end setup_reflections

######################################################################
.begin main
min_caml_main:
.count stack_move
	sub     $sp, 18, $sp
.count stack_store
	store   $ra, [$sp + 0]
	li      128, $i2
	store   $i2, [min_caml_image_size + 0]
	li      128, $i1
	store   $i1, [min_caml_image_size + 1]
	li      64, $i1
	store   $i1, [min_caml_image_center + 0]
	li      64, $i1
	store   $i1, [min_caml_image_center + 1]
.count load_float
	load    [f.34915], $f10
	call    min_caml_float_of_int
	finv    $f1, $f1
	fmul    $f10, $f1, $f1
	store   $f1, [min_caml_scan_pitch + 0]
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
	load    [min_caml_image_size + 0], $i2
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
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	load    [min_caml_image_size + 0], $i20
	sub     $i20, 2, $i20
	bl      $i20, 0, bge_else.39842
bge_then.39842:
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
	b       bge_cont.39842
bge_else.39842:
	mov     $i19, $i10
bge_cont.39842:
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
	load    [min_caml_image_size + 0], $i2
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
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	load    [min_caml_image_size + 0], $i20
	sub     $i20, 2, $i20
	bl      $i20, 0, bge_else.39843
bge_then.39843:
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
	b       bge_cont.39843
bge_else.39843:
	mov     $i19, $i10
bge_cont.39843:
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
	load    [min_caml_image_size + 0], $i2
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
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i19
	load    [min_caml_image_size + 0], $i20
	sub     $i20, 2, $i20
	bl      $i20, 0, bge_else.39844
bge_then.39844:
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
	b       bge_cont.39844
bge_else.39844:
	mov     $i19, $i10
bge_cont.39844:
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
	store   $f10, [min_caml_light + 1]
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
	store   $f16, [min_caml_light + 0]
.count stack_load
	load    [$sp + 7], $f2
	call    cos.2659
.count move_ret
	mov     $f1, $f10
.count stack_load
	load    [$sp + 6], $f11
	fmul    $f11, $f10, $f10
	store   $f10, [min_caml_light + 2]
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
	bne     $i23, 0, be_else.39845
be_then.39845:
.count stack_load
	load    [$sp + 8], $i10
	store   $i10, [min_caml_n_objects + 0]
.count b_cont
	b       be_cont.39845
be_else.39845:
	li      1, $i2
.count stack_store
	store   $i2, [$sp + 9]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39846
be_then.39846:
.count stack_load
	load    [$sp + 9], $i10
	store   $i10, [min_caml_n_objects + 0]
.count b_cont
	b       be_cont.39846
be_else.39846:
	li      2, $i2
.count stack_store
	store   $i2, [$sp + 10]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i23
	bne     $i23, 0, be_else.39847
be_then.39847:
.count stack_load
	load    [$sp + 10], $i10
	store   $i10, [min_caml_n_objects + 0]
.count b_cont
	b       be_cont.39847
be_else.39847:
	li      3, $i2
.count stack_store
	store   $i2, [$sp + 11]
	call    read_nth_object.2798
.count move_ret
	mov     $i1, $i24
	bne     $i24, 0, be_else.39848
be_then.39848:
.count stack_load
	load    [$sp + 11], $i10
	store   $i10, [min_caml_n_objects + 0]
.count b_cont
	b       be_cont.39848
be_else.39848:
	li      4, $i2
	call    read_object.2800
be_cont.39848:
be_cont.39847:
be_cont.39846:
be_cont.39845:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.39849
be_then.39849:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
.count b_cont
	b       be_cont.39849
be_else.39849:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.39850
be_then.39850:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i18
	store   $i10, [$i18 + 0]
.count b_cont
	b       be_cont.39850
be_else.39850:
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
be_cont.39850:
be_cont.39849:
	load    [$i18 + 0], $i19
	be      $i19, -1, bne_cont.39851
bne_then.39851:
	store   $i18, [min_caml_and_net + 0]
	li      1, $i2
	call    read_and_network.2808
bne_cont.39851:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i10
	bne     $i10, -1, be_else.39852
be_then.39852:
	li      1, $i2
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i10
.count b_cont
	b       be_cont.39852
be_else.39852:
	call    min_caml_read_int
.count move_ret
	mov     $i1, $i11
	li      2, $i2
	bne     $i11, -1, be_else.39853
be_then.39853:
	add     $i0, -1, $i3
	call    min_caml_create_array_int
.count move_ret
	mov     $i1, $i11
	store   $i10, [$i11 + 0]
	mov     $i11, $i10
.count b_cont
	b       be_cont.39853
be_else.39853:
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
be_cont.39853:
be_cont.39852:
	mov     $i10, $i3
	load    [$i3 + 0], $i10
	li      1, $i2
	bne     $i10, -1, be_else.39854
be_then.39854:
	call    min_caml_create_array_int
.count b_cont
	b       be_cont.39854
be_else.39854:
.count stack_store
	store   $i3, [$sp + 16]
	call    read_or_network.2806
.count stack_load
	load    [$sp + 16], $i10
	store   $i10, [$i1 + 0]
be_cont.39854:
	store   $i1, [min_caml_or_net + 0]
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
	load    [min_caml_n_objects + 0], $i2
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
	load    [min_caml_light + 0], $f1
	store   $f1, [$i11 + 0]
	load    [min_caml_light + 1], $f1
	store   $f1, [$i11 + 1]
	load    [min_caml_light + 2], $f1
	store   $f1, [$i11 + 2]
	load    [min_caml_n_objects + 0], $i12
	sub     $i12, 1, $i12
	bl      $i12, 0, bge_cont.39855
bge_then.39855:
	load    [min_caml_light_dirvec + 1], $i13
	load    [min_caml_objects + $i12], $i14
	load    [$i14 + 1], $i15
.count move_args
	mov     $f0, $f2
	bne     $i15, 1, be_else.39856
be_then.39856:
	li      6, $i2
	call    min_caml_create_array_float
.count move_ret
	mov     $i1, $i16
	load    [$i11 + 0], $f10
	bne     $f10, $f0, be_else.39857
be_then.39857:
	store   $f0, [$i16 + 1]
.count b_cont
	b       be_cont.39857
be_else.39857:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.39858
ble_then.39858:
	li      0, $i18
.count b_cont
	b       ble_cont.39858
ble_else.39858:
	li      1, $i18
ble_cont.39858:
	bne     $i17, 0, be_else.39859
be_then.39859:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39859
be_else.39859:
	bne     $i18, 0, be_else.39860
be_then.39860:
	li      1, $i17
.count b_cont
	b       be_cont.39860
be_else.39860:
	li      0, $i17
be_cont.39860:
be_cont.39859:
	load    [$i14 + 4], $i18
	load    [$i18 + 0], $f10
	bne     $i17, 0, be_else.39861
be_then.39861:
	fneg    $f10, $f10
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
.count b_cont
	b       be_cont.39861
be_else.39861:
	store   $f10, [$i16 + 0]
.count load_float
	load    [f.34799], $f10
	load    [$i11 + 0], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 1]
be_cont.39861:
be_cont.39857:
	load    [$i11 + 1], $f10
	bne     $f10, $f0, be_else.39862
be_then.39862:
	store   $f0, [$i16 + 3]
.count b_cont
	b       be_cont.39862
be_else.39862:
	load    [$i14 + 6], $i17
	bg      $f0, $f10, ble_else.39863
ble_then.39863:
	li      0, $i18
.count b_cont
	b       ble_cont.39863
ble_else.39863:
	li      1, $i18
ble_cont.39863:
	bne     $i17, 0, be_else.39864
be_then.39864:
	mov     $i18, $i17
.count b_cont
	b       be_cont.39864
be_else.39864:
	bne     $i18, 0, be_else.39865
be_then.39865:
	li      1, $i17
.count b_cont
	b       be_cont.39865
be_else.39865:
	li      0, $i17
be_cont.39865:
be_cont.39864:
	load    [$i14 + 4], $i18
	load    [$i18 + 1], $f10
	bne     $i17, 0, be_else.39866
be_then.39866:
	fneg    $f10, $f10
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
.count b_cont
	b       be_cont.39866
be_else.39866:
	store   $f10, [$i16 + 2]
.count load_float
	load    [f.34799], $f10
	load    [$i11 + 1], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 3]
be_cont.39866:
be_cont.39862:
	load    [$i11 + 2], $f10
	bne     $f10, $f0, be_else.39867
be_then.39867:
	store   $f0, [$i16 + 5]
.count storer
	add     $i13, $i12, $tmp
	store   $i16, [$tmp + 0]
	sub     $i12, 1, $i3
.count move_args
	mov     $i10, $i2
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39856
be_else.39867:
	load    [$i14 + 6], $i17
	load    [$i14 + 4], $i18
	bg      $f0, $f10, ble_else.39868
ble_then.39868:
	li      0, $i19
.count b_cont
	b       ble_cont.39868
ble_else.39868:
	li      1, $i19
ble_cont.39868:
	bne     $i17, 0, be_else.39869
be_then.39869:
	mov     $i19, $i17
.count b_cont
	b       be_cont.39869
be_else.39869:
	bne     $i19, 0, be_else.39870
be_then.39870:
	li      1, $i17
.count b_cont
	b       be_cont.39870
be_else.39870:
	li      0, $i17
be_cont.39870:
be_cont.39869:
	load    [$i18 + 2], $f10
.count move_args
	mov     $i10, $i2
	sub     $i12, 1, $i3
.count storer
	add     $i13, $i12, $tmp
	bne     $i17, 0, be_else.39871
be_then.39871:
	fneg    $f10, $f10
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39856
be_else.39871:
	store   $f10, [$i16 + 4]
	load    [$i11 + 2], $f10
	finv    $f10, $f10
	store   $f10, [$i16 + 5]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39856
be_else.39856:
	bne     $i15, 2, be_else.39872
be_then.39872:
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
	bg      $f10, $f0, ble_else.39873
ble_then.39873:
	store   $f0, [$i16 + 0]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39872
ble_else.39873:
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
	b       be_cont.39872
be_else.39872:
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
	bne     $i17, 0, be_else.39874
be_then.39874:
	mov     $f13, $f10
.count b_cont
	b       be_cont.39874
be_else.39874:
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
be_cont.39874:
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
	bne     $i17, 0, be_else.39875
be_then.39875:
	store   $f11, [$i16 + 1]
	store   $f13, [$i16 + 2]
	store   $f15, [$i16 + 3]
	bne     $f10, $f0, be_else.39876
be_then.39876:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39875
be_else.39876:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39875
be_else.39875:
	load    [$i14 + 9], $i17
	load    [$i14 + 9], $i18
	load    [$i17 + 1], $f16
	fmul    $f14, $f16, $f14
	load    [$i18 + 2], $f17
	fmul    $f12, $f17, $f12
	fadd    $f14, $f12, $f12
.count load_float
	load    [f.34775], $f14
	fmul    $f12, $f14, $f12
	fsub    $f11, $f12, $f11
	store   $f11, [$i16 + 1]
	load    [$i14 + 9], $i17
	load    [$i11 + 2], $f11
	load    [$i17 + 0], $f12
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f18
	fmul    $f18, $f17, $f17
	fadd    $f11, $f17, $f11
	fmul    $f11, $f14, $f11
	fsub    $f13, $f11, $f11
	store   $f11, [$i16 + 2]
	load    [$i11 + 1], $f11
	fmul    $f11, $f12, $f11
	load    [$i11 + 0], $f12
	fmul    $f12, $f16, $f12
	fadd    $f11, $f12, $f11
	fmul    $f11, $f14, $f11
	fsub    $f15, $f11, $f11
	store   $f11, [$i16 + 3]
	bne     $f10, $f0, be_else.39877
be_then.39877:
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
.count b_cont
	b       be_cont.39877
be_else.39877:
	finv    $f10, $f10
	store   $f10, [$i16 + 4]
	store   $i16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2905
be_cont.39877:
be_cont.39875:
be_cont.39872:
be_cont.39856:
bge_cont.39855:
	load    [min_caml_n_objects + 0], $i19
	sub     $i19, 1, $i2
	call    setup_reflections.3143
	li      0, $i1
	load    [min_caml_image_size + 0], $i10
	sub     $i10, 1, $i10
	load    [min_caml_screeny_dir + 0], $f10
	load    [min_caml_scan_pitch + 0], $f11
	load    [min_caml_image_center + 1], $i11
	neg     $i11, $i2
	call    min_caml_float_of_int
.count move_ret
	mov     $f1, $f35
	fmul    $f11, $f35, $f35
	fmul    $f35, $f10, $f36
	load    [min_caml_screenz_dir + 0], $f37
	fadd    $f36, $f37, $f2
	load    [min_caml_screeny_dir + 1], $f36
	fmul    $f35, $f36, $f36
	load    [min_caml_screenz_dir + 1], $f37
	fadd    $f36, $f37, $f3
	load    [min_caml_screeny_dir + 2], $f36
	fmul    $f35, $f36, $f35
	load    [min_caml_screenz_dir + 2], $f36
	fadd    $f35, $f36, $f4
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
