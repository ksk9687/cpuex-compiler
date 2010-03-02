######################################################################
#
# 		↓　ここから macro.s
#
######################################################################

#レジスタ名置き換え
.define $zero $0
.define $sp $63
.define $hp $62
.define $tmp $61
.define $0 orz
.define $63 orz
.define $62 orz
.define $61 orz

#疑似命令
.define { neg %Reg %Reg } { sub $zero %1 %2 }
.define { b %Imm } { jmp 0 %1 }
.define { be %Imm } { jmp 5 %1 }
.define { bne %Imm } { jmp 2 %1 }
.define { bl %Imm } { jmp 6 %1 }
.define { ble %Imm } { jmp 4 %1 }
.define { bg %Imm } { jmp 3 %1 }
.define { bge %Imm } { jmp 1 %1 }

# 入力,出力の順にコンマで区切る形式
.define { li %Imm, %Reg } { li %2 %1 }
.define { add %Reg, %Reg, %Reg } { add %1 %2 %3 }
.define { add %Reg, %Imm, %Reg } { addi %1 %3 %2 }
.define { sub %Reg, %Reg, %Reg } { sub %1 %2 %3 }
.define { sub %Reg, %Imm, %Reg } { addi %1 %3 -%2 }
.define { sll %Reg, %Imm, %Reg } { sll %1 %3 %2 }
.define { cmp %Reg, %Reg } { cmp %1 %2 }
.define { cmp %Reg, %Imm } { cmpi %1 %2 }
.define { fadd %Reg, %Reg, %Reg } { fadd %1 %2 %3 }
.define { fsub %Reg, %Reg, %Reg } { fsub %1 %2 %3 }
.define { fmul %Reg, %Reg, %Reg } { fmul %1 %2 %3 }
.define { finv %Reg, %Reg } { finv %1 %2 }
.define { fsqrt %Reg, %Reg } { fsqrt %1 %2 }
.define { fcmp %Reg, %Reg } { fcmp %1 %2 }
.define { fabs %Reg, %Reg } { fabs %1 %2 }
.define { fneg %Reg, %Reg } { fneg %1 %2 }
.define { load [%Reg + %Imm], %Reg } { load %1 %3 %2 }
.define { load [%Reg - %Imm], %Reg } { load [%1 + -%2], %3}
.define { load [%Reg], %Reg } { load [%1 + 0], %2 }
.define { load [%Imm], %Reg } { load [$zero + %1], %2 }
.define { load [%Imm + %Reg], %Reg } { load [%2 + %1], %3 }
.define { load [%Imm + %Imm], %Reg } { load [%{ %1 + %2 }], %3 }
.define { load [%Imm - %Imm], %Reg } { load [%{ %1 - %2 }], %3 }
.define { load [%Reg + %Reg], %Reg } { loadr %1 %2 %3 }
.define { store %Reg, [%Reg + %Imm] } { store %2 %1 %3 }
.define { store %Reg, [%Reg - %Imm] } { store %1, [%2 + -%3] }
.define { store %Reg, [%Reg] } { store %1, [%2 + 0] }
.define { store %Reg, [%Imm] } { store %1, [$zero + %2] }
.define { store %Reg, [%Imm + %Reg] } { store %1, [%3 + %2] }
.define { store %Reg, [%Imm + %Imm] } { store %1, [%{ %2 + %3 }] }
.define { store %Reg, [%Imm - %Imm] } { store %1, [%{ %2 - %3 }] }
.define { mov %Reg, %Reg } { mov %1 %2 }
.define { neg %Reg, %Reg } { neg %1 %2 }
.define { write %Reg, %Reg } { write %1 %2 }

#スタックとヒープの初期化
	li      0, $zero
	li      0x1000, $hp
	sll		$hp, 4, $hp
	sll     $hp, 3, $sp
	call     min_caml_main
	halt

######################################################################
#
# 		↑　ここまで macro.s
#
######################################################################
######################################################################
#
# 		↓　ここから lib_asm.s
#
######################################################################

######################################################################
# * floor
######################################################################
.begin floor
min_caml_floor:
	mov $2, $1
	cmp $1, 0
	bge FLOOR_POSITIVE	# if ($f1 >= 0) FLOOR_POSITIVE
	fneg $1, $1
	call FLOOR_POSITIVE		# $f1 = FLOOR_POSITIVE(-$f1)
	load [FLOOR_MONE], $2
	fsub $2, $1, $1		# $f1 = (-1) - $f1
	ret
FLOOR_POSITIVE:
	load [FLOAT_MAGICF], $3
	cmp $1, $3
	ble FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	mov $1, $2
	fadd $1, $3, $1		# $f1 += 0x4b000000
	fsub $1, $3, $1		# $f1 -= 0x4b000000
	cmp $1, $2
	ble FLOOR_RET
	load [FLOOR_ONE], $2
	fsub $1, $2, $1		# 返り値が元の値より大きければ1.0引く
FLOOR_RET:
	ret
FLOOR_ONE:
	.float 1.0
FLOOR_MONE:
	.float -1.0
.end floor

######################################################################
# * float_of_int
######################################################################
.begin float_of_int
min_caml_float_of_int:
	mov $2, $1
	cmp $1, 0
	bge ITOF_MAIN		# if ($i1 >= 0) goto ITOF_MAIN
	neg $1, $1		# 正の値にしてitofした後に、マイナスにしてかえす
	call ITOF_MAIN	# $f1 = float_of_int(-$i1)
	fneg $1, $1
	ret
ITOF_MAIN:
	load [FLOAT_MAGICI], $3		# $3 = 8388608
	load [FLOAT_MAGICF], $4 		# $4 = 8388608.0
	load [FLOAT_MAGICFHX], $5 		# $5 = 0x4b000000
	cmp $1, $3 			# $cond = cmp($i1, 8388608)
	bge ITOF_BIG			# if ($i1 >= 8388608) goto ITOF_BIG
	add $1, $5, $1		# $i1 = $i1 + $5 (i.e. $i1 + 0x4b000000)
	fsub $1, $4, $1		# $f1 = $f1 - $4 (i.e. $f1 - 8388608.0)
	ret				# return
ITOF_BIG:
	li 0, $6				# $i1 = $6 * 8388608 + $7 なる$6, $7を求める
	mov $1, $7
ITOF_LOOP:
	add $6, 1, $6			# $6 += 1
	sub $7, $3, $7			# $7 -= 8388608
	cmp $7, $3
	bge ITOF_LOOP		# if ($7 >= 8388608) continue
	li 0, $1
ITOF_LOOP2:
	fadd $1, $4, $1		# $f1 = $6 * $4
	add $6, -1, $6
	cmp $6, 0
	bg ITOF_LOOP2
	add $7, $5, $7			# $7 < 8388608 だからそのままitof
	fsub $7, $4, $7		# $tempf = itof($7)
	fadd $1, $7, $1		# $f1 = $f1 + $tempf (i.e. $f1 = itof($6 * $4) + itof($7) )
	ret
.end float_of_int

######################################################################
# * int_of_float
######################################################################
.begin int_of_float
min_caml_int_of_float:
	mov $2, $1
	cmp $1, 0
	bge FTOI_MAIN		# if ($f1 >= 0) goto FTOI_MAIN
	fneg $1, $1		# 正の値にしてftoiした後に、マイナスにしてかえす
	call FTOI_MAIN	# $i1 = float_of_int(-$f1)
	neg $1, $1
	ret			# return
FTOI_MAIN:
	load [FLOAT_MAGICI], $3		# $3 = 8388608
	load [FLOAT_MAGICF], $4 		# $4 = 8388608.0
	load [FLOAT_MAGICFHX], $5		# $5 = 0x4b000000
	cmp $1, $4
	bge FTOI_BIG		# if ($f1 >= 8688608.0) goto FTOI_BIG
	fadd $1, $4, $1
	sub $1, $5, $1
	ret
FTOI_BIG:
	li 0, $6				# $f1 = $6 * 8388608 + $8 なる$6, $8を求める
	mov $1, $8
FTOI_LOOP:
	add $6, 1, $6			# $6 += 1
	fsub $8, $4, $8		# $8 -= 8388608.0
	cmp $8, $4
	bge FTOI_LOOP		# if ($8 >= 8388608.0) continue
	li 0, $1
FTOI_LOOP2:
	add $1, $3, $1			# $i1 = $6 * $3
	add $6, -1, $6
	cmp $6, 0
	bg FTOI_LOOP2
	fadd $8, $4, $8		# $8 < 8388608.0 だからそのままftoi
	sub $8, $5, $8		# $temp = ftoi($8)
	add $1, $8, $1		# $i1 = $i1 + $temp (i.e. $i1 = ftoi($6 * $3) + ftoi($8) )
	ret

FLOAT_MAGICI:
	.int 8388608
FLOAT_MAGICF:
	.float 8388608.0
FLOAT_MAGICFHX:
	.int 1258291200			# 0x4b000000
.end int_of_float

######################################################################
# * read_int=read_float
# * wordバイナリ読み込み
######################################################################
.begin read
min_caml_read_int:
min_caml_read_float:
read_1:
	read $1
	cmp $1, 255
	bg read_1
	sll $1, 24, $1
read_2:
	read $2
	cmp $2, 255
	bg read_2
	sll $2, 16, $2
	add $1, $2, $1
read_3:
	read $2
	cmp $2, 255
	bg read_3
	sll $2, 8, $2
	add $1, $2, $1
read_4:
	read $2
	cmp $2, 255
	bg read_4
	add $1, $2, $1
	ret
.end read

######################################################################
# * write
# * バイト出力
# * 失敗してたらループ
######################################################################
.begin write
min_caml_write:
	write $2, $tmp
	cmp $tmp, 0
	bg min_caml_write
	ret
.end write

######################################################################
# * create_array
######################################################################
.begin create_array
min_caml_create_array:
	mov $2, $1
	mov $3, $2
	add $1, $hp, $3
	mov $hp, $1
CREATE_ARRAY_LOOP:
	cmp $hp, $3
	bge CREATE_ARRAY_END
	store $2, [$hp]
	add $hp, 1, $hp
	b CREATE_ARRAY_LOOP
CREATE_ARRAY_END:
	ret
.end create_array

######################################################################
# * ledout_in
# * ledout_float
# * バイトLED出力
######################################################################
.begin ledout
min_caml_ledout_int:
min_caml_ledout_float:
	ledout $2
	ret
.end ledout

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
.begin atan
min_caml_atan:
	load    [f._182], $3
	li      0, $10
	mov     $3, $6
	mov     $zero, $5
	mov     $2, $4
	mov     $10, $2
	b       cordic_rec._146

######################################################################
cordic_rec._146:
	cmp     $2, 25
	bne     be_else._192
	mov     $5, $1
	ret
be_else._192:
	fcmp    $4, $zero
	bg      ble_else._193
	fmul    $6, $4, $10
	fmul    $6, $3, $9
	load    [min_caml_atan_table + $2], $8
	load    [f._181], $7
	fsub    $3, $10, $3
	fadd    $4, $9, $4
	fsub    $5, $8, $5
	fmul    $6, $7, $6
	add     $2, 1, $2
	b       cordic_rec._146
ble_else._193:
	fmul    $6, $4, $10
	fmul    $6, $3, $9
	load    [min_caml_atan_table + $2], $8
	load    [f._181], $7
	fadd    $3, $10, $3
	fsub    $4, $9, $4
	fadd    $5, $8, $5
	fmul    $6, $7, $6
	add     $2, 1, $2
	b       cordic_rec._146
.end atan

######################################################################
.begin sin
min_caml_sin:
	fcmp    $zero, $2
	bg      ble_else._196
	load    [f._184], $10
	fcmp    $10, $2
	bg      ble_else._197
	load    [f._185], $10
	fcmp    $10, $2
	bg      ble_else._198
	load    [f._186], $10
	fcmp    $10, $2
	bg      ble_else._199
	fsub    $2, $10, $2
	b       min_caml_sin
ble_else._199:
	fsub    $10, $2, $2
	call     min_caml_sin
	mov     $1, $10
	fneg    $10, $1
	ret
ble_else._198:
	fsub    $10, $2, $2
	b       cordic_sin._82
ble_else._197:
	b       cordic_sin._82
ble_else._196:
	fneg    $2, $2
	call     min_caml_sin
	mov     $1, $10
	fneg    $10, $1
	ret

######################################################################
cordic_rec._111:
	cmp     $3, 25
	bne     be_else._194
	mov     $5, $1
	ret
be_else._194:
	fcmp    $2, $6
	bg      ble_else._195
	fmul    $7, $5, $10
	fmul    $7, $4, $9
	load    [min_caml_atan_table + $3], $8
	load    [f._181], $1
	fadd    $4, $10, $4
	fsub    $5, $9, $5
	fsub    $6, $8, $6
	fmul    $7, $1, $7
	add     $3, 1, $3
	b       cordic_rec._111
ble_else._195:
	fmul    $7, $5, $10
	fmul    $7, $4, $9
	load    [min_caml_atan_table + $3], $8
	load    [f._181], $1
	fsub    $4, $10, $4
	fadd    $5, $9, $5
	fadd    $6, $8, $6
	fmul    $7, $1, $7
	add     $3, 1, $3
	b       cordic_rec._111

######################################################################
cordic_sin._82:
	load    [f._183], $4
	load    [f._182], $7
	li      0, $3
	mov     $zero, $6
	mov     $zero, $5
	b       cordic_rec._111
.end sin

######################################################################
.begin cos
min_caml_cos:
	load    [f._184], $10
	fsub    $10, $2, $2
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
f.32092:	.float  -2.0000000000E+02
f.32091:	.float  2.0000000000E+02
f.32063:	.float  1.2800000000E+02
f.32001:	.float  9.0000000000E-01
f.32000:	.float  2.0000000000E-01
f.31972:	.float  1.5000000000E+02
f.31971:	.float  -1.5000000000E+02
f.31970:	.float  6.6666666667E-03
f.31969:	.float  -6.6666666667E-03
f.31968:	.float  -2.0000000000E+00
f.31967:	.float  3.9062500000E-03
f.31966:	.float  2.5600000000E+02
f.31965:	.float  1.0000000000E+08
f.31964:	.float  1.0000000000E+09
f.31963:	.float  1.0000000000E+01
f.31962:	.float  2.0000000000E+01
f.31961:	.float  5.0000000000E-02
f.31960:	.float  2.5000000000E-01
f.31959:	.float  1.0000000000E-01
f.31958:	.float  3.3333333333E+00
f.31957:	.float  2.5500000000E+02
f.31956:	.float  1.5000000000E-01
f.31955:	.float  3.1830988148E-01
f.31954:	.float  3.1415927000E+00
f.31953:	.float  3.0000000000E+01
f.31952:	.float  1.5000000000E+01
f.31951:	.float  1.0000000000E-04
f.31950:	.float  -1.0000000000E-01
f.31949:	.float  1.0000000000E-02
f.31948:	.float  -2.0000000000E-01
f.31947:	.float  5.0000000000E-01
f.31946:	.float  1.0000000000E+00
f.31945:	.float  -1.0000000000E+00
f.31944:	.float  2.0000000000E+00
f.31931:	.float  1.7453293000E-02

######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
	sub     $sp, 1, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36186
be_then.36186:
.count stack_move
	add     $sp, 1, $sp
	li      0, $1
	ret
be_else.36186:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	call    min_caml_read_int
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	call    min_caml_read_float
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	call    min_caml_read_float
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	call    min_caml_read_float
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	call    min_caml_read_float
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	call    min_caml_read_float
.count move_ret
	mov     $1, $16
	li      2, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	call    min_caml_read_float
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	call    min_caml_read_float
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 1]
	call    min_caml_read_float
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
	cmp     $13, 0
.count move_ret
	mov     $1, $19
	be      bne_cont.36187
bne_then.36187:
	call    min_caml_read_float
.count load_float
	load    [f.31931], $21
.count move_ret
	mov     $1, $20
	fmul    $20, $21, $20
	store   $20, [$19 + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $20
	fmul    $20, $21, $20
	store   $20, [$19 + 1]
	call    min_caml_read_float
.count move_ret
	mov     $1, $20
	fmul    $20, $21, $20
	store   $20, [$19 + 2]
bne_cont.36187:
	li      4, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
	fcmp    $zero, $16
.count move_ret
	mov     $1, $20
	bg      ble_else.36188
ble_then.36188:
	li      0, $16
.count b_cont
	b       ble_cont.36188
ble_else.36188:
	li      1, $16
ble_cont.36188:
	cmp     $11, 2
	bne     be_else.36189
be_then.36189:
	li      1, $21
.count b_cont
	b       be_cont.36189
be_else.36189:
	mov     $16, $21
be_cont.36189:
	mov     $hp, $22
	add     $hp, 11, $hp
	store   $20, [$22 + 10]
	store   $19, [$22 + 9]
	store   $18, [$22 + 8]
	store   $17, [$22 + 7]
	store   $21, [$22 + 6]
	store   $15, [$22 + 5]
	store   $14, [$22 + 4]
	store   $13, [$22 + 3]
	store   $12, [$22 + 2]
	store   $11, [$22 + 1]
	store   $10, [$22 + 0]
.count stack_load
	load    [$sp + 0], $15
	cmp     $11, 3
	mov     $22, $12
	store   $12, [min_caml_objects + $15]
	bne     be_else.36190
be_then.36190:
	load    [$14 + 0], $11
	fcmp    $11, $zero
	bne     be_else.36191
be_then.36191:
	mov     $zero, $11
.count b_cont
	b       be_cont.36191
be_else.36191:
	fcmp    $11, $zero
	bne     be_else.36192
be_then.36192:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.36192
be_else.36192:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.36193
ble_then.36193:
	fneg    $11, $11
ble_cont.36193:
be_cont.36192:
be_cont.36191:
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fcmp    $11, $zero
	bne     be_else.36194
be_then.36194:
	mov     $zero, $11
.count b_cont
	b       be_cont.36194
be_else.36194:
	fcmp    $11, $zero
	bne     be_else.36195
be_then.36195:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.36195
be_else.36195:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.36196
ble_then.36196:
	fneg    $11, $11
ble_cont.36196:
be_cont.36195:
be_cont.36194:
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fcmp    $11, $zero
	bne     be_else.36197
be_then.36197:
	mov     $zero, $11
.count b_cont
	b       be_cont.36197
be_else.36197:
	fcmp    $11, $zero
	bne     be_else.36198
be_then.36198:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.36198
be_else.36198:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.36199
ble_then.36199:
	fneg    $11, $11
ble_cont.36199:
be_cont.36198:
be_cont.36197:
	cmp     $13, 0
	store   $11, [$14 + 2]
	bne     be_else.36200
be_then.36200:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.36200:
	load    [$19 + 0], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $11
	load    [$19 + 0], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $12
	load    [$19 + 1], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $13
	load    [$19 + 1], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $15
	load    [$19 + 2], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $16
	load    [$19 + 2], $2
	call    min_caml_sin
.count stack_move
	add     $sp, 1, $sp
	fmul    $13, $16, $2
	fmul    $13, $1, $4
	load    [$14 + 0], $3
	load    [$14 + 1], $5
	fneg    $15, $6
	fmul    $2, $2, $7
	fmul    $6, $6, $8
	fmul    $4, $4, $9
	fmul    $12, $15, $17
	load    [$14 + 2], $10
	fmul    $3, $7, $7
	fmul    $11, $1, $18
	fmul    $10, $8, $8
	fmul    $5, $9, $9
	fmul    $17, $16, $20
	fmul    $17, $1, $17
	fmul    $11, $16, $21
	fmul    $3, $2, $2
	fadd    $7, $9, $7
	fmul    $11, $15, $9
	fsub    $20, $18, $15
	fadd    $17, $21, $17
	fmul    $12, $13, $18
	fadd    $7, $8, $7
	fmul    $9, $16, $8
	fmul    $15, $15, $20
	fmul    $17, $17, $22
	fmul    $18, $18, $21
	store   $7, [$14 + 0]
	fmul    $12, $1, $7
	fmul    $3, $20, $20
	fmul    $5, $22, $22
	fmul    $10, $21, $21
	fmul    $9, $1, $1
	fmul    $12, $16, $9
	fadd    $8, $7, $7
	fmul    $11, $13, $8
	fadd    $20, $22, $11
.count load_float
	load    [f.31944], $12
	fsub    $1, $9, $1
	fmul    $7, $7, $9
	fmul    $8, $8, $13
	fadd    $11, $21, $11
	fmul    $3, $15, $16
	fmul    $1, $1, $20
	fmul    $3, $9, $9
	fmul    $10, $13, $13
	store   $11, [$14 + 1]
	fmul    $16, $7, $11
	fmul    $5, $20, $16
	fmul    $5, $17, $20
	fmul    $5, $4, $3
	fmul    $10, $18, $21
	fmul    $2, $7, $7
	fadd    $9, $16, $4
	fmul    $20, $1, $5
	fmul    $3, $1, $1
	fmul    $21, $8, $9
	fmul    $10, $6, $6
	fadd    $4, $13, $4
	fadd    $11, $5, $5
	fmul    $2, $15, $2
	fmul    $3, $17, $3
	fadd    $7, $1, $1
	store   $4, [$14 + 2]
	fadd    $5, $9, $4
	fmul    $6, $8, $5
	fadd    $2, $3, $2
	fmul    $6, $18, $3
	fmul    $12, $4, $4
	fadd    $1, $5, $1
	fadd    $2, $3, $2
	store   $4, [$19 + 0]
	fmul    $12, $1, $1
	fmul    $12, $2, $2
	store   $1, [$19 + 1]
	li      1, $1
	store   $2, [$19 + 2]
	ret
be_else.36190:
	cmp     $11, 2
	bne     be_else.36201
be_then.36201:
	cmp     $16, 0
	load    [$14 + 0], $11
	bne     be_else.36202
be_then.36202:
	li      1, $12
.count b_cont
	b       be_cont.36202
be_else.36202:
	li      0, $12
be_cont.36202:
	load    [$14 + 1], $16
	fmul    $11, $11, $15
	load    [$14 + 2], $17
	fmul    $16, $16, $16
	fmul    $17, $17, $17
	fadd    $15, $16, $15
	fadd    $15, $17, $15
	fsqrt   $15, $15
	fcmp    $15, $zero
	bne     be_else.36203
be_then.36203:
	mov     $36, $12
.count b_cont
	b       be_cont.36203
be_else.36203:
	cmp     $12, 0
	finv    $15, $12
	be      bne_cont.36204
bne_then.36204:
	fneg    $12, $12
bne_cont.36204:
be_cont.36203:
	fmul    $11, $12, $11
	cmp     $13, 0
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 2]
	bne     be_else.36205
be_then.36205:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.36205:
	load    [$19 + 0], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $11
	load    [$19 + 0], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $12
	load    [$19 + 1], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $13
	load    [$19 + 1], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $15
	load    [$19 + 2], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $16
	load    [$19 + 2], $2
	call    min_caml_sin
.count stack_move
	add     $sp, 1, $sp
	fmul    $13, $16, $2
	fmul    $13, $1, $4
	load    [$14 + 0], $3
	load    [$14 + 1], $5
	fneg    $15, $6
	fmul    $2, $2, $7
	fmul    $6, $6, $8
	fmul    $4, $4, $9
	fmul    $12, $15, $17
	load    [$14 + 2], $10
	fmul    $3, $7, $7
	fmul    $11, $1, $18
	fmul    $10, $8, $8
	fmul    $5, $9, $9
	fmul    $17, $16, $20
	fmul    $17, $1, $17
	fmul    $11, $16, $21
	fmul    $3, $2, $2
	fadd    $7, $9, $7
	fmul    $11, $15, $9
	fsub    $20, $18, $15
	fadd    $17, $21, $17
	fmul    $12, $13, $18
	fadd    $7, $8, $7
	fmul    $9, $16, $8
	fmul    $15, $15, $20
	fmul    $17, $17, $22
	fmul    $18, $18, $21
	store   $7, [$14 + 0]
	fmul    $12, $1, $7
	fmul    $3, $20, $20
	fmul    $5, $22, $22
	fmul    $10, $21, $21
	fmul    $9, $1, $1
	fmul    $12, $16, $9
	fadd    $8, $7, $7
	fmul    $11, $13, $8
	fadd    $20, $22, $11
.count load_float
	load    [f.31944], $12
	fsub    $1, $9, $1
	fmul    $7, $7, $9
	fmul    $8, $8, $13
	fadd    $11, $21, $11
	fmul    $3, $15, $16
	fmul    $1, $1, $20
	fmul    $3, $9, $9
	fmul    $10, $13, $13
	store   $11, [$14 + 1]
	fmul    $16, $7, $11
	fmul    $5, $20, $16
	fmul    $5, $17, $20
	fmul    $5, $4, $3
	fmul    $10, $18, $21
	fmul    $2, $7, $7
	fadd    $9, $16, $4
	fmul    $20, $1, $5
	fmul    $3, $1, $1
	fmul    $21, $8, $9
	fmul    $10, $6, $6
	fadd    $4, $13, $4
	fadd    $11, $5, $5
	fmul    $2, $15, $2
	fmul    $3, $17, $3
	fadd    $7, $1, $1
	store   $4, [$14 + 2]
	fadd    $5, $9, $4
	fmul    $6, $8, $5
	fadd    $2, $3, $2
	fmul    $6, $18, $3
	fmul    $12, $4, $4
	fadd    $1, $5, $1
	fadd    $2, $3, $2
	store   $4, [$19 + 0]
	fmul    $12, $1, $1
	fmul    $12, $2, $2
	store   $1, [$19 + 1]
	li      1, $1
	store   $2, [$19 + 2]
	ret
be_else.36201:
	cmp     $13, 0
	bne     be_else.36206
be_then.36206:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.36206:
	load    [$19 + 0], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $11
	load    [$19 + 0], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $12
	load    [$19 + 1], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $13
	load    [$19 + 1], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $15
	load    [$19 + 2], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $16
	load    [$19 + 2], $2
	call    min_caml_sin
.count stack_move
	add     $sp, 1, $sp
	fmul    $13, $16, $2
	fmul    $13, $1, $4
	load    [$14 + 0], $3
	load    [$14 + 1], $5
	fneg    $15, $6
	fmul    $2, $2, $7
	fmul    $6, $6, $8
	fmul    $4, $4, $9
	fmul    $12, $15, $17
	load    [$14 + 2], $10
	fmul    $3, $7, $7
	fmul    $11, $1, $18
	fmul    $10, $8, $8
	fmul    $5, $9, $9
	fmul    $17, $16, $20
	fmul    $17, $1, $17
	fmul    $11, $16, $21
	fmul    $3, $2, $2
	fadd    $7, $9, $7
	fmul    $11, $15, $9
	fsub    $20, $18, $15
	fadd    $17, $21, $17
	fmul    $12, $13, $18
	fadd    $7, $8, $7
	fmul    $9, $16, $8
	fmul    $15, $15, $20
	fmul    $17, $17, $22
	fmul    $18, $18, $21
	store   $7, [$14 + 0]
	fmul    $12, $1, $7
	fmul    $3, $20, $20
	fmul    $5, $22, $22
	fmul    $10, $21, $21
	fmul    $9, $1, $1
	fmul    $12, $16, $9
	fadd    $8, $7, $7
	fmul    $11, $13, $8
	fadd    $20, $22, $11
.count load_float
	load    [f.31944], $12
	fsub    $1, $9, $1
	fmul    $7, $7, $9
	fmul    $8, $8, $13
	fadd    $11, $21, $11
	fmul    $3, $15, $16
	fmul    $1, $1, $20
	fmul    $3, $9, $9
	fmul    $10, $13, $13
	store   $11, [$14 + 1]
	fmul    $16, $7, $11
	fmul    $5, $20, $16
	fmul    $5, $17, $20
	fmul    $5, $4, $3
	fmul    $10, $18, $21
	fmul    $2, $7, $7
	fadd    $9, $16, $4
	fmul    $20, $1, $5
	fmul    $3, $1, $1
	fmul    $21, $8, $9
	fmul    $10, $6, $6
	fadd    $4, $13, $4
	fadd    $11, $5, $5
	fmul    $2, $15, $2
	fmul    $3, $17, $3
	fadd    $7, $1, $1
	store   $4, [$14 + 2]
	fadd    $5, $9, $4
	fmul    $6, $8, $5
	fadd    $2, $3, $2
	fmul    $6, $18, $3
	fmul    $12, $4, $4
	fadd    $1, $5, $1
	fadd    $2, $3, $2
	store   $4, [$19 + 0]
	fmul    $12, $1, $1
	fmul    $12, $2, $2
	store   $1, [$19 + 1]
	li      1, $1
	store   $2, [$19 + 2]
	ret
.end read_nth_object

######################################################################
.begin read_object
read_object.2721:
	cmp     $2, 60
	bl      bge_else.36207
bge_then.36207:
	ret
bge_else.36207:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36208
be_then.36208:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 8], $1
.count move_float
	mov     $1, $41
	ret
be_else.36208:
.count stack_load
	load    [$sp + 0], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36209
bge_then.36209:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36209:
.count stack_store
	store   $2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36210
be_then.36210:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 7], $1
.count move_float
	mov     $1, $41
	ret
be_else.36210:
.count stack_load
	load    [$sp + 1], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36211
bge_then.36211:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36211:
.count stack_store
	store   $2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36212
be_then.36212:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 6], $1
.count move_float
	mov     $1, $41
	ret
be_else.36212:
.count stack_load
	load    [$sp + 2], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36213
bge_then.36213:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36213:
.count stack_store
	store   $2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36214
be_then.36214:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 5], $1
.count move_float
	mov     $1, $41
	ret
be_else.36214:
.count stack_load
	load    [$sp + 3], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36215
bge_then.36215:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36215:
.count stack_store
	store   $2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36216
be_then.36216:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 4], $1
.count move_float
	mov     $1, $41
	ret
be_else.36216:
.count stack_load
	load    [$sp + 4], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36217
bge_then.36217:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36217:
.count stack_store
	store   $2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36218
be_then.36218:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $1, $41
	ret
be_else.36218:
.count stack_load
	load    [$sp + 5], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36219
bge_then.36219:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36219:
.count stack_store
	store   $2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.36220
be_then.36220:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 2], $1
.count move_float
	mov     $1, $41
	ret
be_else.36220:
.count stack_load
	load    [$sp + 6], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.36221
bge_then.36221:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.36221:
.count stack_store
	store   $2, [$sp + 7]
	call    read_nth_object.2719
.count stack_move
	add     $sp, 8, $sp
	cmp     $1, 0
.count stack_load
	load    [$sp - 1], $1
	bne     be_else.36222
be_then.36222:
.count move_float
	mov     $1, $41
	ret
be_else.36222:
	add     $1, 1, $2
	b       read_object.2721
.end read_object

######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36223
be_then.36223:
.count stack_move
	add     $sp, 8, $sp
	add     $zero, -1, $3
.count stack_load
	load    [$sp - 8], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.36223:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
.count stack_load
	load    [$sp + 0], $12
	cmp     $11, -1
	add     $12, 1, $13
	bne     be_else.36224
be_then.36224:
	add     $13, 1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count storer
	add     $1, $12, $tmp
.count stack_move
	add     $sp, 8, $sp
	store   $10, [$tmp + 0]
	ret
be_else.36224:
	call    min_caml_read_int
.count move_ret
	mov     $1, $14
	cmp     $14, -1
	add     $13, 1, $15
	bne     be_else.36225
be_then.36225:
	add     $15, 1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count stack_move
	add     $sp, 8, $sp
.count storer
	add     $1, $13, $tmp
	store   $11, [$tmp + 0]
.count storer
	add     $1, $12, $tmp
	store   $10, [$tmp + 0]
	ret
be_else.36225:
	call    min_caml_read_int
.count move_ret
	mov     $1, $16
	add     $15, 1, $17
	cmp     $16, -1
	add     $17, 1, $2
	bne     be_else.36226
be_then.36226:
	add     $zero, -1, $3
	call    min_caml_create_array
.count stack_move
	add     $sp, 8, $sp
.count storer
	add     $1, $15, $tmp
	store   $14, [$tmp + 0]
.count storer
	add     $1, $13, $tmp
	store   $11, [$tmp + 0]
.count storer
	add     $1, $12, $tmp
	store   $10, [$tmp + 0]
	ret
be_else.36226:
.count stack_store
	store   $10, [$sp + 1]
.count stack_store
	store   $13, [$sp + 2]
.count stack_store
	store   $11, [$sp + 3]
.count stack_store
	store   $15, [$sp + 4]
.count stack_store
	store   $14, [$sp + 5]
.count stack_store
	store   $17, [$sp + 6]
.count stack_store
	store   $16, [$sp + 7]
	call    read_net_item.2725
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 2], $2
.count stack_load
	load    [$sp - 1], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
.count stack_load
	load    [$sp - 4], $2
.count stack_load
	load    [$sp - 3], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
.count stack_load
	load    [$sp - 6], $2
.count stack_load
	load    [$sp - 5], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
.count stack_load
	load    [$sp - 8], $2
.count stack_load
	load    [$sp - 7], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	ret
.end read_net_item

######################################################################
.begin read_or_network
read_or_network.2727:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36227
be_then.36227:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.36227
be_else.36227:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.36228
be_then.36228:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.36228
be_else.36228:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.36229
be_then.36229:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.36229
be_else.36229:
.count stack_store
	store   $10, [$sp + 1]
.count stack_store
	store   $11, [$sp + 2]
.count stack_store
	store   $12, [$sp + 3]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 3], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.36229:
be_cont.36228:
be_cont.36227:
	mov     $10, $3
	load    [$3 + 0], $10
.count stack_load
	load    [$sp + 0], $11
	cmp     $10, -1
	add     $11, 1, $2
	bne     be_else.36230
be_then.36230:
.count stack_move
	add     $sp, 9, $sp
	b       min_caml_create_array
be_else.36230:
.count stack_store
	store   $3, [$sp + 4]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36231
be_then.36231:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.36231
be_else.36231:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.36232
be_then.36232:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.36232
be_else.36232:
.count stack_store
	store   $10, [$sp + 5]
.count stack_store
	store   $11, [$sp + 6]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 6], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 5], $11
	store   $11, [$10 + 0]
be_cont.36232:
be_cont.36231:
	mov     $10, $3
	load    [$3 + 0], $10
.count stack_load
	load    [$sp + 0], $11
	cmp     $10, -1
	add     $11, 1, $12
	add     $12, 1, $2
	bne     be_else.36233
be_then.36233:
	call    min_caml_create_array
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $1, $11, $tmp
.count stack_load
	load    [$sp - 5], $2
	store   $2, [$tmp + 0]
	ret
be_else.36233:
.count stack_store
	store   $12, [$sp + 7]
.count stack_store
	store   $3, [$sp + 8]
	call    read_or_network.2727
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 2], $2
.count stack_load
	load    [$sp - 1], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
.count stack_load
	load    [$sp - 9], $2
.count stack_load
	load    [$sp - 5], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	ret
.end read_or_network

######################################################################
.begin read_and_network
read_and_network.2729:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36234
be_then.36234:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.36234
be_else.36234:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.36235
be_then.36235:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.36235
be_else.36235:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.36236
be_then.36236:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.36236
be_else.36236:
.count stack_store
	store   $10, [$sp + 1]
.count stack_store
	store   $11, [$sp + 2]
.count stack_store
	store   $12, [$sp + 3]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 3], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.36236:
be_cont.36235:
be_cont.36234:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.36237
be_then.36237:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.36237:
.count stack_load
	load    [$sp + 0], $11
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36238
be_then.36238:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.36238
be_else.36238:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.36239
be_then.36239:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.36239
be_else.36239:
.count stack_store
	store   $10, [$sp + 4]
.count stack_store
	store   $11, [$sp + 5]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 5], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 4], $11
	store   $11, [$10 + 0]
be_cont.36239:
be_cont.36238:
	load    [$10 + 0], $11
.count stack_load
	load    [$sp + 0], $12
	cmp     $11, -1
	add     $12, 1, $12
	bne     be_else.36240
be_then.36240:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.36240:
.count stack_store
	store   $12, [$sp + 6]
	store   $10, [min_caml_and_net + $12]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36241
be_then.36241:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.36241
be_else.36241:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.36242
be_then.36242:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.36242
be_else.36242:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.36243
be_then.36243:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.36243
be_else.36243:
.count stack_store
	store   $10, [$sp + 7]
.count stack_store
	store   $11, [$sp + 8]
.count stack_store
	store   $12, [$sp + 9]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 9], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 8], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 7], $11
	store   $11, [$10 + 0]
be_cont.36243:
be_cont.36242:
be_cont.36241:
	load    [$10 + 0], $11
.count stack_load
	load    [$sp + 6], $12
	cmp     $11, -1
	add     $12, 1, $12
	bne     be_else.36244
be_then.36244:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.36244:
.count stack_store
	store   $12, [$sp + 10]
	store   $10, [min_caml_and_net + $12]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.36245
be_then.36245:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count b_cont
	b       be_cont.36245
be_else.36245:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.36246
be_then.36246:
	add     $zero, -1, $3
	call    min_caml_create_array
	store   $10, [$1 + 0]
.count b_cont
	b       be_cont.36246
be_else.36246:
.count stack_store
	store   $10, [$sp + 11]
.count stack_store
	store   $11, [$sp + 12]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 12], $2
	store   $2, [$1 + 1]
.count stack_load
	load    [$sp + 11], $2
	store   $2, [$1 + 0]
be_cont.36246:
be_cont.36245:
.count stack_move
	add     $sp, 13, $sp
	load    [$1 + 0], $2
.count stack_load
	load    [$sp - 3], $3
	cmp     $2, -1
	add     $3, 1, $3
	bne     be_else.36247
be_then.36247:
	ret
be_else.36247:
	store   $1, [min_caml_and_net + $3]
	add     $3, 1, $2
	b       read_and_network.2729
.end read_and_network

######################################################################
.begin solver
solver.2773:
	load    [min_caml_objects + $2], $1
	load    [min_caml_startp + 0], $2
	load    [min_caml_startp + 1], $4
	load    [$1 + 5], $5
	load    [$1 + 5], $6
	load    [$1 + 5], $7
	load    [$1 + 1], $8
	load    [$5 + 0], $5
	load    [$6 + 1], $6
	load    [min_caml_startp + 2], $9
	load    [$7 + 2], $7
	cmp     $8, 1
	fsub    $2, $5, $2
	fsub    $4, $6, $4
	fsub    $9, $7, $5
	bne     be_else.36248
be_then.36248:
	load    [$3 + 0], $6
	load    [$1 + 4], $7
	load    [$3 + 1], $8
	fcmp    $6, $zero
	bne     be_else.36249
be_then.36249:
	li      0, $6
.count b_cont
	b       be_cont.36249
be_else.36249:
	fcmp    $zero, $6
	load    [$7 + 1], $9
	load    [$1 + 6], $10
	bg      ble_else.36250
ble_then.36250:
	li      0, $11
.count b_cont
	b       ble_cont.36250
ble_else.36250:
	li      1, $11
ble_cont.36250:
	cmp     $10, 0
	bne     be_else.36251
be_then.36251:
	mov     $11, $10
.count b_cont
	b       be_cont.36251
be_else.36251:
	cmp     $11, 0
	bne     be_else.36252
be_then.36252:
	li      1, $10
.count b_cont
	b       be_cont.36252
be_else.36252:
	li      0, $10
be_cont.36252:
be_cont.36251:
	cmp     $10, 0
	load    [$7 + 0], $11
	bne     be_else.36253
be_then.36253:
	fneg    $11, $10
.count b_cont
	b       be_cont.36253
be_else.36253:
	mov     $11, $10
be_cont.36253:
	fsub    $10, $2, $10
	finv    $6, $6
	load    [$7 + 2], $7
	load    [$3 + 2], $11
	fmul    $10, $6, $6
	fmul    $6, $8, $8
	fmul    $6, $11, $10
	fadd    $8, $4, $8
	fadd    $10, $5, $10
	fabs    $8, $8
	fabs    $10, $10
	fcmp    $9, $8
	bg      ble_else.36254
ble_then.36254:
	li      0, $6
.count b_cont
	b       ble_cont.36254
ble_else.36254:
	fcmp    $7, $10
	bg      ble_else.36255
ble_then.36255:
	li      0, $6
.count b_cont
	b       ble_cont.36255
ble_else.36255:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.36255:
ble_cont.36254:
be_cont.36249:
	cmp     $6, 0
	bne     be_else.36256
be_then.36256:
	load    [$3 + 1], $6
	load    [$1 + 4], $7
	load    [$3 + 2], $8
	fcmp    $6, $zero
	bne     be_else.36257
be_then.36257:
	li      0, $6
.count b_cont
	b       be_cont.36257
be_else.36257:
	fcmp    $zero, $6
	load    [$7 + 2], $9
	load    [$1 + 6], $10
	bg      ble_else.36258
ble_then.36258:
	li      0, $11
.count b_cont
	b       ble_cont.36258
ble_else.36258:
	li      1, $11
ble_cont.36258:
	cmp     $10, 0
	bne     be_else.36259
be_then.36259:
	mov     $11, $10
.count b_cont
	b       be_cont.36259
be_else.36259:
	cmp     $11, 0
	bne     be_else.36260
be_then.36260:
	li      1, $10
.count b_cont
	b       be_cont.36260
be_else.36260:
	li      0, $10
be_cont.36260:
be_cont.36259:
	cmp     $10, 0
	load    [$7 + 1], $11
	bne     be_else.36261
be_then.36261:
	fneg    $11, $10
.count b_cont
	b       be_cont.36261
be_else.36261:
	mov     $11, $10
be_cont.36261:
	fsub    $10, $4, $10
	finv    $6, $6
	load    [$7 + 0], $7
	load    [$3 + 0], $11
	fmul    $10, $6, $6
	fmul    $6, $8, $8
	fmul    $6, $11, $10
	fadd    $8, $5, $8
	fadd    $10, $2, $10
	fabs    $8, $8
	fabs    $10, $10
	fcmp    $9, $8
	bg      ble_else.36262
ble_then.36262:
	li      0, $6
.count b_cont
	b       ble_cont.36262
ble_else.36262:
	fcmp    $7, $10
	bg      ble_else.36263
ble_then.36263:
	li      0, $6
.count b_cont
	b       ble_cont.36263
ble_else.36263:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.36263:
ble_cont.36262:
be_cont.36257:
	cmp     $6, 0
	bne     be_else.36264
be_then.36264:
	load    [$3 + 2], $6
	load    [$1 + 4], $7
	load    [$1 + 6], $1
	fcmp    $6, $zero
	bne     be_else.36265
be_then.36265:
	li      0, $1
	ret
be_else.36265:
	fcmp    $zero, $6
	load    [$7 + 0], $8
	load    [$3 + 0], $9
	bg      ble_else.36266
ble_then.36266:
	li      0, $10
.count b_cont
	b       ble_cont.36266
ble_else.36266:
	li      1, $10
ble_cont.36266:
	cmp     $1, 0
	bne     be_else.36267
be_then.36267:
	mov     $10, $1
.count b_cont
	b       be_cont.36267
be_else.36267:
	cmp     $10, 0
	bne     be_else.36268
be_then.36268:
	li      1, $1
.count b_cont
	b       be_cont.36268
be_else.36268:
	li      0, $1
be_cont.36268:
be_cont.36267:
	cmp     $1, 0
	load    [$7 + 2], $10
	bne     be_else.36269
be_then.36269:
	fneg    $10, $1
.count b_cont
	b       be_cont.36269
be_else.36269:
	mov     $10, $1
be_cont.36269:
	fsub    $1, $5, $1
	finv    $6, $5
	load    [$7 + 1], $6
	load    [$3 + 1], $3
	fmul    $1, $5, $1
	fmul    $1, $9, $5
	fmul    $1, $3, $3
	fadd    $5, $2, $2
	fadd    $3, $4, $3
	fabs    $2, $2
	fabs    $3, $3
	fcmp    $8, $2
	bg      ble_else.36270
ble_then.36270:
	li      0, $1
	ret
ble_else.36270:
	fcmp    $6, $3
	bg      ble_else.36271
ble_then.36271:
	li      0, $1
	ret
ble_else.36271:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.36264:
	li      2, $1
	ret
be_else.36256:
	li      1, $1
	ret
be_else.36248:
	cmp     $8, 2
	bne     be_else.36272
be_then.36272:
	load    [$1 + 4], $1
	load    [$3 + 0], $6
	load    [$3 + 1], $7
	load    [$1 + 0], $8
	load    [$1 + 1], $9
	load    [$3 + 2], $3
	fmul    $6, $8, $6
	fmul    $7, $9, $7
	load    [$1 + 2], $1
	fmul    $8, $2, $2
	fmul    $9, $4, $4
	fmul    $3, $1, $3
	fadd    $6, $7, $6
	fmul    $1, $5, $1
	fadd    $2, $4, $2
	fadd    $6, $3, $3
	fadd    $2, $1, $1
	fcmp    $3, $zero
	bg      ble_else.36273
ble_then.36273:
	li      0, $1
	ret
ble_else.36273:
	finv    $3, $2
	fneg    $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36272:
	load    [$1 + 4], $6
	load    [$1 + 4], $7
	load    [$1 + 4], $9
	load    [$1 + 3], $10
	load    [$3 + 0], $11
	load    [$3 + 1], $12
	load    [$3 + 2], $3
	fmul    $11, $11, $13
	fmul    $12, $12, $14
	load    [$6 + 0], $6
	load    [$7 + 1], $7
	fmul    $3, $3, $15
	fmul    $13, $6, $13
	fmul    $14, $7, $14
	load    [$9 + 2], $9
	load    [$1 + 3], $16
	load    [$1 + 3], $17
	fmul    $15, $9, $15
	fmul    $11, $2, $18
	fadd    $13, $14, $13
	fmul    $12, $4, $14
	fmul    $3, $5, $19
	cmp     $10, 0
	fmul    $2, $2, $20
	fmul    $18, $6, $18
	fadd    $13, $15, $13
	bne     be_else.36274
be_then.36274:
	mov     $13, $10
.count b_cont
	b       be_cont.36274
be_else.36274:
	load    [$1 + 9], $15
	fmul    $12, $3, $10
	fmul    $3, $11, $21
	load    [$15 + 0], $15
	load    [$1 + 9], $22
	fmul    $11, $12, $23
	fmul    $10, $15, $10
	load    [$22 + 1], $22
	load    [$1 + 9], $15
	fmul    $21, $22, $21
	fadd    $13, $10, $10
	load    [$15 + 2], $15
	fmul    $23, $15, $13
	fadd    $10, $21, $10
	fadd    $10, $13, $10
be_cont.36274:
	fcmp    $10, $zero
	bne     be_else.36275
be_then.36275:
	li      0, $1
	ret
be_else.36275:
	fmul    $14, $7, $13
	fmul    $19, $9, $14
	fmul    $20, $6, $6
	fmul    $4, $4, $15
	fmul    $5, $5, $19
	fadd    $18, $13, $13
	load    [$1 + 6], $18
	fmul    $4, $5, $20
	cmp     $16, 0
	fmul    $15, $7, $7
	fmul    $19, $9, $9
	fadd    $13, $14, $13
	bne     be_else.36276
be_then.36276:
	mov     $13, $3
.count b_cont
	b       be_cont.36276
be_else.36276:
	fmul    $3, $4, $14
	fmul    $12, $5, $15
	load    [$1 + 9], $16
	fmul    $11, $5, $19
	fmul    $3, $2, $3
	load    [$16 + 0], $16
	fadd    $14, $15, $14
	load    [$1 + 9], $15
	fmul    $11, $4, $11
	fadd    $19, $3, $3
	fmul    $12, $2, $12
	fmul    $14, $16, $14
	load    [$15 + 1], $15
	load    [$1 + 9], $16
	fmul    $3, $15, $3
	fadd    $11, $12, $11
	load    [$16 + 2], $12
	fadd    $14, $3, $3
	fmul    $11, $12, $11
	fadd    $3, $11, $3
	fmul    $3, $39, $3
	fadd    $13, $3, $3
be_cont.36276:
	fadd    $6, $7, $6
	fmul    $3, $3, $11
	load    [$1 + 9], $7
	cmp     $17, 0
	fmul    $5, $2, $5
	load    [$1 + 9], $12
	load    [$7 + 0], $7
	fadd    $6, $9, $6
	bne     be_else.36277
be_then.36277:
	mov     $6, $1
.count b_cont
	b       be_cont.36277
be_else.36277:
	fmul    $20, $7, $7
	load    [$12 + 1], $9
	fmul    $2, $4, $2
	load    [$1 + 9], $1
	fmul    $5, $9, $4
	fadd    $6, $7, $5
	load    [$1 + 2], $1
	fmul    $2, $1, $1
	fadd    $5, $4, $2
	fadd    $2, $1, $1
be_cont.36277:
	cmp     $8, 3
	bne     be_cont.36278
be_then.36278:
	fsub    $1, $36, $1
be_cont.36278:
	fmul    $10, $1, $1
	finv    $10, $2
	finv    $10, $4
	fsub    $11, $1, $1
	fcmp    $1, $zero
	bg      ble_else.36279
ble_then.36279:
	li      0, $1
	ret
ble_else.36279:
	cmp     $18, 0
	fsqrt   $1, $1
	bne     be_else.36280
be_then.36280:
	fneg    $1, $1
	fsub    $1, $3, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36280:
	fsub    $1, $3, $1
	fmul    $1, $4, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver

######################################################################
.begin solver_fast
solver_fast.2796:
	load    [min_caml_objects + $2], $1
	load    [min_caml_light_dirvec + 1], $3
	load    [min_caml_intersection_point + 0], $4
	load    [$1 + 5], $5
	load    [$1 + 5], $6
	load    [$1 + 5], $7
	load    [$1 + 1], $8
	load    [$5 + 0], $5
	load    [min_caml_intersection_point + 1], $9
	load    [$6 + 1], $6
	load    [min_caml_intersection_point + 2], $10
	load    [$7 + 2], $7
	cmp     $8, 1
	fsub    $4, $5, $4
	fsub    $9, $6, $5
	fsub    $10, $7, $6
	load    [$3 + $2], $2
	bne     be_else.36281
be_then.36281:
	load    [$2 + 0], $8
	load    [min_caml_light_dirvec + 0], $3
	load    [$1 + 4], $7
	fsub    $8, $4, $8
	load    [$3 + 1], $9
	load    [$2 + 1], $10
	load    [$7 + 1], $7
	load    [$1 + 4], $11
	fmul    $8, $10, $8
	load    [$3 + 0], $12
	load    [$2 + 2], $13
	load    [$11 + 0], $10
	load    [$1 + 4], $14
	fmul    $8, $9, $9
	fsub    $13, $5, $11
	load    [$2 + 3], $13
	load    [$3 + 2], $15
	load    [$2 + 4], $16
	fadd    $9, $5, $9
	fmul    $11, $13, $11
	load    [$14 + 2], $13
	fmul    $8, $15, $14
	load    [$3 + 0], $15
	fabs    $9, $9
	fmul    $11, $12, $12
	fcmp    $7, $9
	fadd    $14, $6, $14
	fsub    $16, $6, $16
	bg      ble_else.36282
ble_then.36282:
	li      0, $9
.count b_cont
	b       ble_cont.36282
ble_else.36282:
	fabs    $14, $9
	load    [$2 + 1], $14
	fcmp    $13, $9
	bg      ble_else.36283
ble_then.36283:
	li      0, $9
.count b_cont
	b       ble_cont.36283
ble_else.36283:
	fcmp    $14, $zero
	bne     be_else.36284
be_then.36284:
	li      0, $9
.count b_cont
	b       be_cont.36284
be_else.36284:
	li      1, $9
be_cont.36284:
ble_cont.36283:
ble_cont.36282:
	cmp     $9, 0
	bne     be_else.36285
be_then.36285:
	fadd    $12, $4, $8
	load    [$2 + 5], $9
	load    [$1 + 4], $1
	load    [$3 + 2], $12
	fmul    $16, $9, $9
	fabs    $8, $8
	load    [$1 + 2], $1
	fcmp    $10, $8
	bg      ble_else.36286
ble_then.36286:
	li      0, $1
.count b_cont
	b       ble_cont.36286
ble_else.36286:
	fmul    $11, $12, $8
	load    [$2 + 3], $12
	fadd    $8, $6, $6
	fabs    $6, $6
	fcmp    $1, $6
	bg      ble_else.36287
ble_then.36287:
	li      0, $1
.count b_cont
	b       ble_cont.36287
ble_else.36287:
	fcmp    $12, $zero
	bne     be_else.36288
be_then.36288:
	li      0, $1
.count b_cont
	b       be_cont.36288
be_else.36288:
	li      1, $1
be_cont.36288:
ble_cont.36287:
ble_cont.36286:
	cmp     $1, 0
	bne     be_else.36289
be_then.36289:
	fmul    $9, $15, $1
	load    [$3 + 1], $3
	load    [$2 + 5], $2
	fmul    $9, $3, $3
	fadd    $1, $4, $1
	fadd    $3, $5, $3
	fabs    $1, $1
	fcmp    $10, $1
	bg      ble_else.36290
ble_then.36290:
	li      0, $1
	ret
ble_else.36290:
	fabs    $3, $1
	fcmp    $7, $1
	bg      ble_else.36291
ble_then.36291:
	li      0, $1
	ret
ble_else.36291:
	fcmp    $2, $zero
	bne     be_else.36292
be_then.36292:
	li      0, $1
	ret
be_else.36292:
.count move_float
	mov     $9, $42
	li      3, $1
	ret
be_else.36289:
.count move_float
	mov     $11, $42
	li      2, $1
	ret
be_else.36285:
.count move_float
	mov     $8, $42
	li      1, $1
	ret
be_else.36281:
	cmp     $8, 2
	bne     be_else.36293
be_then.36293:
	load    [$2 + 0], $1
	load    [$2 + 1], $3
	load    [$2 + 2], $7
	fcmp    $zero, $1
	bg      ble_else.36294
ble_then.36294:
	li      0, $1
	ret
ble_else.36294:
	fmul    $3, $4, $1
	fmul    $7, $5, $3
	load    [$2 + 3], $2
	fmul    $2, $6, $2
	fadd    $1, $3, $1
	fadd    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36293:
	load    [$2 + 0], $3
	load    [$1 + 4], $7
	load    [$1 + 4], $9
	fcmp    $3, $zero
	bne     be_else.36295
be_then.36295:
	li      0, $1
	ret
be_else.36295:
	load    [$1 + 4], $10
	load    [$1 + 3], $11
	load    [$2 + 1], $12
	load    [$2 + 2], $13
	load    [$2 + 3], $14
	fmul    $12, $4, $12
	fmul    $13, $5, $13
	fmul    $14, $6, $14
	fmul    $4, $4, $15
	fmul    $5, $5, $16
	load    [$7 + 0], $7
	load    [$9 + 1], $9
	fadd    $12, $13, $12
	fmul    $15, $7, $7
	fmul    $6, $6, $13
	fmul    $16, $9, $9
	load    [$10 + 2], $10
	fadd    $12, $14, $12
	load    [$1 + 6], $14
	fmul    $5, $6, $15
	fadd    $7, $9, $7
	fmul    $13, $10, $10
	fmul    $12, $12, $9
	load    [$1 + 9], $13
	cmp     $11, 0
	fmul    $6, $4, $6
	load    [$1 + 9], $16
	load    [$13 + 0], $13
	fadd    $7, $10, $7
	bne     be_else.36296
be_then.36296:
	mov     $7, $1
.count b_cont
	b       be_cont.36296
be_else.36296:
	fmul    $15, $13, $10
	load    [$16 + 1], $11
	fmul    $4, $5, $4
	load    [$1 + 9], $1
	fmul    $6, $11, $5
	fadd    $7, $10, $6
	load    [$1 + 2], $1
	fmul    $4, $1, $1
	fadd    $6, $5, $4
	fadd    $4, $1, $1
be_cont.36296:
	cmp     $8, 3
	bne     be_cont.36297
be_then.36297:
	fsub    $1, $36, $1
be_cont.36297:
	fmul    $3, $1, $1
	load    [$2 + 4], $3
	load    [$2 + 4], $2
	fsub    $9, $1, $1
	fcmp    $1, $zero
	bg      ble_else.36298
ble_then.36298:
	li      0, $1
	ret
ble_else.36298:
	cmp     $14, 0
	fsqrt   $1, $1
	bne     be_else.36299
be_then.36299:
	fsub    $12, $1, $1
	fmul    $1, $3, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36299:
	fadd    $12, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver_fast

######################################################################
.begin solver_fast2
solver_fast2.2814:
	load    [min_caml_objects + $2], $1
	load    [$3 + 1], $4
	load    [$3 + 0], $3
	load    [$1 + 1], $6
	load    [$1 + 10], $5
	load    [$4 + $2], $2
	cmp     $6, 1
	load    [$5 + 0], $4
	load    [$5 + 1], $7
	load    [$5 + 2], $8
	bne     be_else.36300
be_then.36300:
	load    [$2 + 0], $6
	load    [$1 + 4], $5
	load    [$3 + 1], $9
	fsub    $6, $4, $6
	load    [$5 + 1], $5
	load    [$2 + 1], $10
	load    [$1 + 4], $11
	load    [$3 + 0], $12
	fmul    $6, $10, $6
	load    [$2 + 2], $13
	load    [$11 + 0], $10
	load    [$1 + 4], $14
	fsub    $13, $7, $11
	fmul    $6, $9, $9
	load    [$2 + 3], $13
	load    [$3 + 2], $15
	load    [$2 + 4], $16
	fmul    $11, $13, $11
	fadd    $9, $7, $9
	load    [$14 + 2], $13
	fmul    $6, $15, $14
	load    [$3 + 0], $15
	fmul    $11, $12, $12
	fabs    $9, $9
	fsub    $16, $8, $16
	fcmp    $5, $9
	fadd    $14, $8, $14
	bg      ble_else.36301
ble_then.36301:
	li      0, $9
.count b_cont
	b       ble_cont.36301
ble_else.36301:
	fabs    $14, $9
	load    [$2 + 1], $14
	fcmp    $13, $9
	bg      ble_else.36302
ble_then.36302:
	li      0, $9
.count b_cont
	b       ble_cont.36302
ble_else.36302:
	fcmp    $14, $zero
	bne     be_else.36303
be_then.36303:
	li      0, $9
.count b_cont
	b       be_cont.36303
be_else.36303:
	li      1, $9
be_cont.36303:
ble_cont.36302:
ble_cont.36301:
	cmp     $9, 0
	bne     be_else.36304
be_then.36304:
	fadd    $12, $4, $6
	load    [$2 + 5], $9
	load    [$1 + 4], $1
	load    [$3 + 2], $12
	fmul    $16, $9, $9
	fabs    $6, $6
	load    [$1 + 2], $1
	fcmp    $10, $6
	bg      ble_else.36305
ble_then.36305:
	li      0, $1
.count b_cont
	b       ble_cont.36305
ble_else.36305:
	fmul    $11, $12, $6
	load    [$2 + 3], $12
	fadd    $6, $8, $6
	fabs    $6, $6
	fcmp    $1, $6
	bg      ble_else.36306
ble_then.36306:
	li      0, $1
.count b_cont
	b       ble_cont.36306
ble_else.36306:
	fcmp    $12, $zero
	bne     be_else.36307
be_then.36307:
	li      0, $1
.count b_cont
	b       be_cont.36307
be_else.36307:
	li      1, $1
be_cont.36307:
ble_cont.36306:
ble_cont.36305:
	cmp     $1, 0
	bne     be_else.36308
be_then.36308:
	fmul    $9, $15, $1
	load    [$3 + 1], $3
	load    [$2 + 5], $2
	fmul    $9, $3, $3
	fadd    $1, $4, $1
	fadd    $3, $7, $3
	fabs    $1, $1
	fcmp    $10, $1
	bg      ble_else.36309
ble_then.36309:
	li      0, $1
	ret
ble_else.36309:
	fabs    $3, $1
	fcmp    $5, $1
	bg      ble_else.36310
ble_then.36310:
	li      0, $1
	ret
ble_else.36310:
	fcmp    $2, $zero
	bne     be_else.36311
be_then.36311:
	li      0, $1
	ret
be_else.36311:
.count move_float
	mov     $9, $42
	li      3, $1
	ret
be_else.36308:
.count move_float
	mov     $11, $42
	li      2, $1
	ret
be_else.36304:
.count move_float
	mov     $6, $42
	li      1, $1
	ret
be_else.36300:
	cmp     $6, 2
	bne     be_else.36312
be_then.36312:
	load    [$2 + 0], $1
	load    [$5 + 3], $2
	fcmp    $zero, $1
	bg      ble_else.36313
ble_then.36313:
	li      0, $1
	ret
ble_else.36313:
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36312:
	load    [$2 + 0], $3
	load    [$2 + 1], $6
	load    [$2 + 2], $9
	fcmp    $3, $zero
	bne     be_else.36314
be_then.36314:
	li      0, $1
	ret
be_else.36314:
	fmul    $6, $4, $4
	fmul    $9, $7, $6
	load    [$2 + 3], $7
	load    [$5 + 3], $5
	load    [$1 + 6], $1
	fmul    $7, $8, $7
	fadd    $4, $6, $4
	fmul    $3, $5, $3
	load    [$2 + 4], $5
	load    [$2 + 4], $2
	fadd    $4, $7, $4
	fmul    $4, $4, $6
	fsub    $6, $3, $3
	fcmp    $3, $zero
	bg      ble_else.36315
ble_then.36315:
	li      0, $1
	ret
ble_else.36315:
	cmp     $1, 0
	fsqrt   $3, $1
	bne     be_else.36316
be_then.36316:
	fsub    $4, $1, $1
	fmul    $1, $5, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.36316:
	fadd    $4, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver_fast2

######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	cmp     $3, 0
	bl      bge_else.36317
bge_then.36317:
	load    [min_caml_objects + $3], $11
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 1], $10
	load    [$11 + 1], $14
	load    [$2 + 0], $12
	li      6, $13
	cmp     $14, 1
	li      4, $15
	li      5, $16
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count move_args
	mov     $zero, $3
	bne     be_else.36318
be_then.36318:
.count move_args
	mov     $13, $2
	call    min_caml_create_array
	load    [$12 + 0], $14
.count move_ret
	mov     $1, $13
	load    [$11 + 6], $15
	fcmp    $14, $zero
	load    [$11 + 4], $16
	bne     be_else.36319
be_then.36319:
	store   $zero, [$13 + 1]
.count b_cont
	b       be_cont.36319
be_else.36319:
	fcmp    $zero, $14
	bg      ble_else.36320
ble_then.36320:
	li      0, $14
.count b_cont
	b       ble_cont.36320
ble_else.36320:
	li      1, $14
ble_cont.36320:
	cmp     $15, 0
	be      bne_cont.36321
bne_then.36321:
	cmp     $14, 0
	bne     be_else.36322
be_then.36322:
	li      1, $14
.count b_cont
	b       be_cont.36322
be_else.36322:
	li      0, $14
be_cont.36322:
bne_cont.36321:
	cmp     $14, 0
	load    [$16 + 0], $15
	bne     be_else.36323
be_then.36323:
	fneg    $15, $14
	store   $14, [$13 + 0]
	load    [$12 + 0], $14
	finv    $14, $14
	store   $14, [$13 + 1]
.count b_cont
	b       be_cont.36323
be_else.36323:
	store   $15, [$13 + 0]
	load    [$12 + 0], $14
	finv    $14, $14
	store   $14, [$13 + 1]
be_cont.36323:
be_cont.36319:
	load    [$12 + 1], $14
	load    [$11 + 6], $15
	load    [$11 + 4], $16
	fcmp    $14, $zero
	bne     be_else.36324
be_then.36324:
	store   $zero, [$13 + 3]
.count b_cont
	b       be_cont.36324
be_else.36324:
	fcmp    $zero, $14
	bg      ble_else.36325
ble_then.36325:
	li      0, $14
.count b_cont
	b       ble_cont.36325
ble_else.36325:
	li      1, $14
ble_cont.36325:
	cmp     $15, 0
	be      bne_cont.36326
bne_then.36326:
	cmp     $14, 0
	bne     be_else.36327
be_then.36327:
	li      1, $14
.count b_cont
	b       be_cont.36327
be_else.36327:
	li      0, $14
be_cont.36327:
bne_cont.36326:
	cmp     $14, 0
	load    [$16 + 1], $15
	bne     be_else.36328
be_then.36328:
	fneg    $15, $14
	store   $14, [$13 + 2]
	load    [$12 + 1], $14
	finv    $14, $14
	store   $14, [$13 + 3]
.count b_cont
	b       be_cont.36328
be_else.36328:
	store   $15, [$13 + 2]
	load    [$12 + 1], $14
	finv    $14, $14
	store   $14, [$13 + 3]
be_cont.36328:
be_cont.36324:
	load    [$12 + 2], $14
	load    [$11 + 6], $15
	load    [$11 + 4], $11
	fcmp    $14, $zero
	bne     be_else.36329
be_then.36329:
	store   $zero, [$13 + 5]
	mov     $13, $11
.count b_cont
	b       be_cont.36329
be_else.36329:
	fcmp    $zero, $14
	bg      ble_else.36330
ble_then.36330:
	li      0, $14
.count b_cont
	b       ble_cont.36330
ble_else.36330:
	li      1, $14
ble_cont.36330:
	cmp     $15, 0
	be      bne_cont.36331
bne_then.36331:
	cmp     $14, 0
	bne     be_else.36332
be_then.36332:
	li      1, $14
.count b_cont
	b       be_cont.36332
be_else.36332:
	li      0, $14
be_cont.36332:
bne_cont.36331:
	cmp     $14, 0
	load    [$11 + 2], $11
	bne     be_else.36333
be_then.36333:
	fneg    $11, $11
	store   $11, [$13 + 4]
	load    [$12 + 2], $11
	finv    $11, $11
	store   $11, [$13 + 5]
	mov     $13, $11
.count b_cont
	b       be_cont.36333
be_else.36333:
	store   $11, [$13 + 4]
	load    [$12 + 2], $11
	finv    $11, $11
	store   $11, [$13 + 5]
	mov     $13, $11
be_cont.36333:
be_cont.36329:
.count stack_load
	load    [$sp + 1], $13
	li      6, $2
.count storer
	add     $10, $13, $tmp
	store   $11, [$tmp + 0]
	sub     $13, 1, $11
	cmp     $11, 0
	bl      bge_else.36334
bge_then.36334:
	load    [min_caml_objects + $11], $13
	li      4, $14
	li      5, $15
	load    [$13 + 1], $16
.count move_args
	mov     $zero, $3
	cmp     $16, 1
	bne     be_else.36335
be_then.36335:
	call    min_caml_create_array
	load    [$12 + 0], $2
.count stack_move
	add     $sp, 2, $sp
	load    [$13 + 6], $3
	fcmp    $2, $zero
	load    [$13 + 4], $4
	bne     be_else.36336
be_then.36336:
	store   $zero, [$1 + 1]
.count b_cont
	b       be_cont.36336
be_else.36336:
	fcmp    $zero, $2
	bg      ble_else.36337
ble_then.36337:
	li      0, $2
.count b_cont
	b       ble_cont.36337
ble_else.36337:
	li      1, $2
ble_cont.36337:
	cmp     $3, 0
	be      bne_cont.36338
bne_then.36338:
	cmp     $2, 0
	bne     be_else.36339
be_then.36339:
	li      1, $2
.count b_cont
	b       be_cont.36339
be_else.36339:
	li      0, $2
be_cont.36339:
bne_cont.36338:
	cmp     $2, 0
	load    [$4 + 0], $3
	bne     be_else.36340
be_then.36340:
	fneg    $3, $2
	store   $2, [$1 + 0]
	load    [$12 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
.count b_cont
	b       be_cont.36340
be_else.36340:
	store   $3, [$1 + 0]
	load    [$12 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
be_cont.36340:
be_cont.36336:
	load    [$12 + 1], $2
	load    [$13 + 6], $3
	load    [$13 + 4], $4
	fcmp    $2, $zero
	bne     be_else.36341
be_then.36341:
	store   $zero, [$1 + 3]
.count b_cont
	b       be_cont.36341
be_else.36341:
	fcmp    $zero, $2
	bg      ble_else.36342
ble_then.36342:
	li      0, $2
.count b_cont
	b       ble_cont.36342
ble_else.36342:
	li      1, $2
ble_cont.36342:
	cmp     $3, 0
	be      bne_cont.36343
bne_then.36343:
	cmp     $2, 0
	bne     be_else.36344
be_then.36344:
	li      1, $2
.count b_cont
	b       be_cont.36344
be_else.36344:
	li      0, $2
be_cont.36344:
bne_cont.36343:
	cmp     $2, 0
	load    [$4 + 1], $3
	bne     be_else.36345
be_then.36345:
	fneg    $3, $2
	store   $2, [$1 + 2]
	load    [$12 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
.count b_cont
	b       be_cont.36345
be_else.36345:
	store   $3, [$1 + 2]
	load    [$12 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
be_cont.36345:
be_cont.36341:
	load    [$12 + 2], $2
	load    [$13 + 6], $3
	load    [$13 + 4], $4
	fcmp    $2, $zero
	bne     be_else.36346
be_then.36346:
.count storer
	add     $10, $11, $tmp
	store   $zero, [$1 + 5]
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36346:
	fcmp    $zero, $2
	bg      ble_else.36347
ble_then.36347:
	li      0, $2
.count b_cont
	b       ble_cont.36347
ble_else.36347:
	li      1, $2
ble_cont.36347:
	cmp     $3, 0
	be      bne_cont.36348
bne_then.36348:
	cmp     $2, 0
	bne     be_else.36349
be_then.36349:
	li      1, $2
.count b_cont
	b       be_cont.36349
be_else.36349:
	li      0, $2
be_cont.36349:
bne_cont.36348:
	cmp     $2, 0
	load    [$4 + 2], $3
	bne     be_else.36350
be_then.36350:
	fneg    $3, $2
.count b_cont
	b       be_cont.36350
be_else.36350:
	mov     $3, $2
be_cont.36350:
	store   $2, [$1 + 4]
	load    [$12 + 2], $2
.count storer
	add     $10, $11, $tmp
	sub     $11, 1, $3
	finv    $2, $2
	store   $1, [$tmp + 0]
	store   $2, [$1 + 5]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36335:
	cmp     $16, 2
	bne     be_else.36351
be_then.36351:
.count move_args
	mov     $14, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$13 + 4], $2
	load    [$13 + 4], $3
	load    [$13 + 4], $4
	load    [$12 + 0], $5
	load    [$2 + 0], $2
	load    [$12 + 1], $6
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$12 + 2], $5
	fmul    $6, $3, $3
	load    [$4 + 2], $4
.count storer
	add     $10, $11, $tmp
	fmul    $5, $4, $4
	fadd    $2, $3, $2
	fadd    $2, $4, $2
	fcmp    $2, $zero
	bg      ble_else.36352
ble_then.36352:
	store   $zero, [$1 + 0]
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.36352:
	finv    $2, $2
	sub     $11, 1, $4
	fneg    $2, $3
	store   $3, [$1 + 0]
	load    [$13 + 4], $3
	load    [$3 + 0], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 1]
	load    [$13 + 4], $3
	load    [$3 + 1], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 2]
	load    [$13 + 4], $3
	load    [$3 + 2], $3
	store   $1, [$tmp + 0]
	fmul    $3, $2, $2
.count move_args
	mov     $4, $3
	fneg    $2, $2
	store   $2, [$1 + 3]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36351:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$13 + 3], $2
	load    [$13 + 4], $3
	load    [$13 + 4], $4
	load    [$13 + 4], $5
	load    [$12 + 0], $6
	load    [$12 + 1], $7
	load    [$12 + 2], $8
	fmul    $6, $6, $9
	fmul    $7, $7, $14
	load    [$3 + 0], $3
	load    [$4 + 1], $4
	fmul    $8, $8, $15
	fmul    $9, $3, $3
	fmul    $14, $4, $4
	load    [$5 + 2], $5
	fmul    $7, $8, $9
	load    [$13 + 9], $14
	fmul    $15, $5, $5
	fadd    $3, $4, $3
	fmul    $8, $6, $8
	load    [$14 + 0], $4
	cmp     $2, 0
	load    [$13 + 9], $14
	fmul    $6, $7, $6
	fmul    $9, $4, $4
	fadd    $3, $5, $3
	be      bne_cont.36353
bne_then.36353:
	fadd    $3, $4, $3
	load    [$14 + 1], $4
	load    [$13 + 9], $5
	fmul    $8, $4, $4
	load    [$5 + 2], $5
	fmul    $6, $5, $5
	fadd    $3, $4, $3
	fadd    $3, $5, $3
bne_cont.36353:
	store   $3, [$1 + 0]
	load    [$13 + 4], $4
	load    [$13 + 4], $5
	load    [$13 + 4], $6
	load    [$12 + 0], $7
	load    [$4 + 0], $4
	load    [$12 + 1], $8
	load    [$5 + 1], $5
	fmul    $7, $4, $4
	load    [$12 + 2], $7
	load    [$6 + 2], $6
	fmul    $8, $5, $5
	load    [$13 + 9], $9
	fmul    $7, $6, $6
	fneg    $4, $4
	load    [$13 + 9], $14
	cmp     $2, 0
	fneg    $5, $5
	load    [$9 + 1], $9
	fneg    $6, $6
.count storer
	add     $10, $11, $tmp
	bne     be_else.36354
be_then.36354:
	fcmp    $3, $zero
	store   $4, [$1 + 1]
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	store   $1, [$tmp + 0]
	bne     be_else.36355
be_then.36355:
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36355:
	finv    $3, $2
	sub     $11, 1, $3
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36354:
	fmul    $7, $9, $2
	load    [$14 + 2], $7
	fcmp    $3, $zero
	fmul    $8, $7, $8
	fadd    $2, $8, $2
	fmul    $2, $39, $2
	fsub    $4, $2, $2
	store   $2, [$1 + 1]
	load    [$13 + 9], $2
	load    [$12 + 2], $4
	load    [$12 + 0], $8
	load    [$2 + 0], $2
	fmul    $8, $7, $7
	fmul    $4, $2, $4
	fadd    $4, $7, $4
	finv    $3, $7
	sub     $11, 1, $3
	fmul    $4, $39, $4
	fsub    $5, $4, $4
	store   $4, [$1 + 2]
	load    [$12 + 1], $4
	load    [$12 + 0], $5
	fmul    $4, $2, $2
	fmul    $5, $9, $4
	fadd    $2, $4, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	bne     be_else.36356
be_then.36356:
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36356:
	store   $7, [$1 + 4]
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.36334:
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.36318:
	cmp     $14, 2
	bne     be_else.36357
be_then.36357:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$11 + 4], $2
	load    [$11 + 4], $3
	load    [$11 + 4], $4
	load    [$12 + 0], $5
	load    [$2 + 0], $2
	load    [$12 + 1], $6
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$12 + 2], $5
	fmul    $6, $3, $3
	load    [$4 + 2], $4
	fmul    $5, $4, $4
	fadd    $2, $3, $2
	fadd    $2, $4, $2
	fcmp    $2, $zero
	bg      ble_else.36358
ble_then.36358:
	store   $zero, [$1 + 0]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.36358:
	finv    $2, $2
	fneg    $2, $3
	store   $3, [$1 + 0]
	load    [$11 + 4], $3
	load    [$3 + 0], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 1]
	load    [$11 + 4], $3
	load    [$3 + 1], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 2]
	load    [$11 + 4], $3
.count stack_load
	load    [$sp - 1], $4
	load    [$3 + 2], $3
.count storer
	add     $10, $4, $tmp
	sub     $4, 1, $4
	fmul    $3, $2, $2
	store   $1, [$tmp + 0]
.count move_args
	mov     $4, $3
	fneg    $2, $2
	store   $2, [$1 + 3]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36357:
.count move_args
	mov     $16, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$11 + 3], $2
	load    [$11 + 4], $3
	load    [$11 + 4], $4
	load    [$11 + 4], $5
	load    [$12 + 0], $6
	load    [$12 + 1], $7
	load    [$12 + 2], $8
	fmul    $6, $6, $9
	fmul    $7, $7, $13
	load    [$3 + 0], $3
	load    [$4 + 1], $4
	fmul    $8, $8, $14
	fmul    $9, $3, $3
	fmul    $13, $4, $4
	load    [$5 + 2], $5
	fmul    $7, $8, $9
	load    [$11 + 9], $13
	fmul    $14, $5, $5
	fadd    $3, $4, $3
	fmul    $8, $6, $8
	load    [$13 + 0], $4
	cmp     $2, 0
	load    [$11 + 9], $13
	fmul    $6, $7, $6
	fmul    $9, $4, $4
	fadd    $3, $5, $3
	be      bne_cont.36359
bne_then.36359:
	fadd    $3, $4, $3
	load    [$13 + 1], $4
	load    [$11 + 9], $5
	fmul    $8, $4, $4
	load    [$5 + 2], $5
	fmul    $6, $5, $5
	fadd    $3, $4, $3
	fadd    $3, $5, $3
bne_cont.36359:
	store   $3, [$1 + 0]
	load    [$11 + 4], $4
	load    [$11 + 4], $5
	load    [$11 + 4], $6
	load    [$12 + 0], $7
	load    [$4 + 0], $4
	load    [$12 + 1], $8
	load    [$5 + 1], $5
	fmul    $7, $4, $4
	load    [$12 + 2], $7
	load    [$6 + 2], $6
	fmul    $8, $5, $5
	load    [$11 + 9], $9
	fmul    $7, $6, $6
	fneg    $4, $4
	load    [$11 + 9], $13
	cmp     $2, 0
	fneg    $5, $5
	load    [$9 + 1], $9
	fneg    $6, $6
	bne     be_else.36360
be_then.36360:
	fcmp    $3, $zero
	store   $4, [$1 + 1]
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	bne     be_else.36361
be_then.36361:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36361:
	finv    $3, $2
.count stack_load
	load    [$sp - 1], $3
.count storer
	add     $10, $3, $tmp
	sub     $3, 1, $3
	store   $1, [$tmp + 0]
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36360:
	fmul    $7, $9, $2
	load    [$13 + 2], $7
	fcmp    $3, $zero
	fmul    $8, $7, $8
	fadd    $2, $8, $2
	fmul    $2, $39, $2
	fsub    $4, $2, $2
	store   $2, [$1 + 1]
	load    [$11 + 9], $2
	load    [$12 + 2], $4
	load    [$12 + 0], $8
	load    [$2 + 0], $2
	fmul    $8, $7, $7
	fmul    $4, $2, $4
	fadd    $4, $7, $4
	finv    $3, $7
	fmul    $4, $39, $4
	fsub    $5, $4, $4
	store   $4, [$1 + 2]
	load    [$12 + 1], $4
	load    [$12 + 0], $5
	fmul    $4, $2, $2
	fmul    $5, $9, $4
	fadd    $2, $4, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	bne     be_else.36362
be_then.36362:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.36362:
	store   $7, [$1 + 4]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.36317:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	cmp     $3, 0
	bl      bge_else.36363
bge_then.36363:
	load    [min_caml_objects + $3], $1
	load    [$2 + 0], $4
	load    [$1 + 5], $5
	load    [$1 + 10], $6
	load    [$5 + 0], $5
	fsub    $4, $5, $4
	store   $4, [$6 + 0]
	load    [$1 + 5], $4
	load    [$2 + 1], $5
	load    [$4 + 1], $4
	fsub    $5, $4, $4
	store   $4, [$6 + 1]
	load    [$1 + 5], $4
	load    [$2 + 2], $5
	load    [$4 + 2], $4
	fsub    $5, $4, $4
	store   $4, [$6 + 2]
	load    [$1 + 1], $4
	load    [$1 + 4], $5
	load    [$6 + 0], $7
	cmp     $4, 2
	bne     be_else.36364
be_then.36364:
	load    [$5 + 0], $1
	load    [$6 + 1], $4
	load    [$5 + 1], $8
	fmul    $1, $7, $1
	load    [$6 + 2], $7
	fmul    $8, $4, $4
	load    [$5 + 2], $5
	sub     $3, 1, $3
	fmul    $5, $7, $5
	fadd    $1, $4, $1
	fadd    $1, $5, $1
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
be_else.36364:
	cmp     $4, 2
	bg      ble_else.36365
ble_then.36365:
	sub     $3, 1, $3
	b       setup_startp_constants.2831
ble_else.36365:
	load    [$1 + 4], $5
	load    [$1 + 4], $7
	load    [$1 + 4], $8
	load    [$1 + 3], $9
	load    [$6 + 0], $10
	load    [$6 + 1], $11
	load    [$6 + 2], $12
	fmul    $10, $10, $13
	fmul    $11, $11, $14
	load    [$5 + 0], $5
	load    [$7 + 1], $7
	fmul    $12, $12, $15
	fmul    $13, $5, $5
	fmul    $14, $7, $7
	load    [$8 + 2], $8
	load    [$1 + 9], $13
	load    [$1 + 9], $14
	fmul    $15, $8, $8
	fadd    $5, $7, $5
	load    [$1 + 9], $1
	fmul    $11, $12, $7
	cmp     $9, 0
	load    [$13 + 0], $13
	fmul    $12, $10, $12
	load    [$14 + 1], $14
	fadd    $5, $8, $5
	bne     be_else.36366
be_then.36366:
	mov     $5, $1
.count b_cont
	b       be_cont.36366
be_else.36366:
	fmul    $7, $13, $7
	fmul    $12, $14, $8
	fmul    $10, $11, $9
	load    [$1 + 2], $1
	fadd    $5, $7, $5
	fmul    $9, $1, $1
	fadd    $5, $8, $5
	fadd    $5, $1, $1
be_cont.36366:
	cmp     $4, 3
	sub     $3, 1, $3
	bne     be_else.36367
be_then.36367:
	fsub    $1, $36, $1
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
be_else.36367:
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
bge_else.36363:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$3 + $2], $1
	add     $2, 1, $2
	cmp     $1, -1
	bne     be_else.36368
be_then.36368:
	li      1, $1
	ret
be_else.36368:
	load    [min_caml_objects + $1], $1
	load    [$3 + $2], $7
	add     $2, 1, $2
	load    [$1 + 1], $8
	load    [$1 + 5], $9
	load    [$1 + 5], $10
	load    [$1 + 5], $11
	load    [$9 + 0], $9
	load    [$10 + 1], $10
	load    [$11 + 2], $11
	cmp     $8, 1
	fsub    $4, $9, $9
	fsub    $5, $10, $10
	fsub    $6, $11, $11
	bne     be_else.36369
be_then.36369:
	load    [$1 + 4], $8
	fabs    $9, $9
	load    [$1 + 6], $12
	load    [$8 + 0], $8
	load    [$1 + 4], $13
	fabs    $10, $10
	fcmp    $8, $9
	bg      ble_else.36370
ble_then.36370:
	cmp     $12, 0
	bne     be_else.36371
be_then.36371:
	li      1, $1
.count b_cont
	b       be_cont.36369
be_else.36371:
	li      0, $1
.count b_cont
	b       be_cont.36369
ble_else.36370:
	load    [$13 + 1], $8
	load    [$1 + 6], $9
	load    [$1 + 4], $12
	fcmp    $8, $10
	bg      ble_else.36372
ble_then.36372:
	cmp     $9, 0
	bne     be_else.36373
be_then.36373:
	li      1, $1
.count b_cont
	b       be_cont.36369
be_else.36373:
	li      0, $1
.count b_cont
	b       be_cont.36369
ble_else.36372:
	load    [$12 + 2], $8
	fabs    $11, $9
	load    [$1 + 6], $10
	fcmp    $8, $9
	bg      ble_else.36374
ble_then.36374:
	cmp     $10, 0
	bne     be_else.36375
be_then.36375:
	li      1, $1
.count b_cont
	b       be_cont.36369
be_else.36375:
	li      0, $1
.count b_cont
	b       be_cont.36369
ble_else.36374:
	load    [$1 + 6], $1
.count b_cont
	b       be_cont.36369
be_else.36369:
	cmp     $8, 2
	bne     be_else.36376
be_then.36376:
	load    [$1 + 6], $8
	load    [$1 + 4], $1
	load    [$1 + 0], $12
	load    [$1 + 1], $13
	load    [$1 + 2], $1
	fmul    $12, $9, $9
	fmul    $13, $10, $10
	fmul    $1, $11, $1
	fadd    $9, $10, $9
	fadd    $9, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36377
ble_then.36377:
	cmp     $8, 0
	bne     be_else.36378
be_then.36378:
	li      1, $1
.count b_cont
	b       be_cont.36376
be_else.36378:
	li      0, $1
.count b_cont
	b       be_cont.36376
ble_else.36377:
	cmp     $8, 0
	bne     be_else.36379
be_then.36379:
	li      0, $1
.count b_cont
	b       be_cont.36376
be_else.36379:
	li      1, $1
.count b_cont
	b       be_cont.36376
be_else.36376:
	load    [$1 + 6], $12
	fmul    $9, $9, $13
	load    [$1 + 4], $14
	load    [$1 + 4], $15
	fmul    $10, $10, $16
	load    [$14 + 0], $14
	load    [$15 + 1], $15
	fmul    $11, $11, $17
	fmul    $13, $14, $13
	fmul    $16, $15, $14
	load    [$1 + 4], $15
	load    [$1 + 3], $16
	fmul    $10, $11, $18
	load    [$15 + 2], $15
	fadd    $13, $14, $13
	load    [$1 + 9], $14
	fmul    $17, $15, $15
	fmul    $11, $9, $11
	load    [$14 + 0], $14
	cmp     $16, 0
	load    [$1 + 9], $17
	fmul    $9, $10, $9
	fadd    $13, $15, $10
	bne     be_else.36380
be_then.36380:
	mov     $10, $1
.count b_cont
	b       be_cont.36380
be_else.36380:
	fmul    $18, $14, $13
	load    [$17 + 1], $14
	load    [$1 + 9], $1
	fmul    $11, $14, $11
	fadd    $10, $13, $10
	load    [$1 + 2], $1
	fmul    $9, $1, $1
	fadd    $10, $11, $9
	fadd    $9, $1, $1
be_cont.36380:
	cmp     $8, 3
	bne     be_cont.36381
be_then.36381:
	fsub    $1, $36, $1
be_cont.36381:
	fcmp    $zero, $1
	bg      ble_else.36382
ble_then.36382:
	cmp     $12, 0
	bne     be_else.36383
be_then.36383:
	li      1, $1
.count b_cont
	b       ble_cont.36382
be_else.36383:
	li      0, $1
.count b_cont
	b       ble_cont.36382
ble_else.36382:
	cmp     $12, 0
	bne     be_else.36384
be_then.36384:
	li      0, $1
.count b_cont
	b       be_cont.36384
be_else.36384:
	li      1, $1
be_cont.36384:
ble_cont.36382:
be_cont.36376:
be_cont.36369:
	cmp     $1, 0
	bne     be_else.36385
be_then.36385:
	cmp     $7, -1
	bne     be_else.36386
be_then.36386:
	li      1, $1
	ret
be_else.36386:
	load    [min_caml_objects + $7], $1
	load    [$3 + $2], $7
	add     $2, 1, $2
	load    [$1 + 5], $8
	load    [$1 + 5], $9
	load    [$1 + 5], $10
	load    [$1 + 1], $11
	load    [$8 + 0], $8
	load    [$9 + 1], $9
	load    [$10 + 2], $10
	cmp     $11, 1
	fsub    $4, $8, $8
	fsub    $5, $9, $9
	fsub    $6, $10, $10
	bne     be_else.36387
be_then.36387:
	load    [$1 + 4], $11
	fabs    $8, $8
	load    [$1 + 6], $12
	load    [$11 + 0], $11
	load    [$1 + 4], $13
	fabs    $9, $9
	fcmp    $11, $8
	bg      ble_else.36388
ble_then.36388:
	cmp     $12, 0
	bne     be_else.36389
be_then.36389:
	li      1, $1
.count b_cont
	b       be_cont.36387
be_else.36389:
	li      0, $1
.count b_cont
	b       be_cont.36387
ble_else.36388:
	load    [$13 + 1], $8
	load    [$1 + 6], $11
	load    [$1 + 4], $12
	fcmp    $8, $9
	bg      ble_else.36390
ble_then.36390:
	cmp     $11, 0
	bne     be_else.36391
be_then.36391:
	li      1, $1
.count b_cont
	b       be_cont.36387
be_else.36391:
	li      0, $1
.count b_cont
	b       be_cont.36387
ble_else.36390:
	load    [$12 + 2], $8
	fabs    $10, $9
	load    [$1 + 6], $10
	fcmp    $8, $9
	bg      ble_else.36392
ble_then.36392:
	cmp     $10, 0
	bne     be_else.36393
be_then.36393:
	li      1, $1
.count b_cont
	b       be_cont.36387
be_else.36393:
	li      0, $1
.count b_cont
	b       be_cont.36387
ble_else.36392:
	load    [$1 + 6], $1
.count b_cont
	b       be_cont.36387
be_else.36387:
	cmp     $11, 2
	load    [$1 + 6], $11
	bne     be_else.36394
be_then.36394:
	load    [$1 + 4], $1
	load    [$1 + 0], $12
	load    [$1 + 1], $13
	load    [$1 + 2], $1
	fmul    $12, $8, $8
	fmul    $13, $9, $9
	fmul    $1, $10, $1
	fadd    $8, $9, $8
	fadd    $8, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36395
ble_then.36395:
	cmp     $11, 0
	bne     be_else.36396
be_then.36396:
	li      1, $1
.count b_cont
	b       be_cont.36394
be_else.36396:
	li      0, $1
.count b_cont
	b       be_cont.36394
ble_else.36395:
	cmp     $11, 0
	bne     be_else.36397
be_then.36397:
	li      0, $1
.count b_cont
	b       be_cont.36394
be_else.36397:
	li      1, $1
.count b_cont
	b       be_cont.36394
be_else.36394:
	load    [$1 + 1], $12
	load    [$1 + 4], $13
	load    [$1 + 4], $14
	load    [$1 + 4], $15
	load    [$1 + 3], $16
	fmul    $8, $8, $17
	fmul    $9, $9, $18
	load    [$13 + 0], $13
	load    [$14 + 1], $14
	fmul    $10, $10, $19
	fmul    $17, $13, $13
	fmul    $18, $14, $14
	load    [$15 + 2], $15
	load    [$1 + 9], $17
	load    [$1 + 9], $18
	fmul    $19, $15, $15
	fadd    $13, $14, $13
	load    [$1 + 9], $1
	fmul    $9, $10, $14
	cmp     $16, 0
	load    [$17 + 0], $17
	fmul    $10, $8, $10
	load    [$18 + 1], $18
	fadd    $13, $15, $13
	bne     be_else.36398
be_then.36398:
	mov     $13, $1
.count b_cont
	b       be_cont.36398
be_else.36398:
	fmul    $14, $17, $14
	fmul    $10, $18, $10
	fmul    $8, $9, $8
	load    [$1 + 2], $1
	fadd    $13, $14, $9
	fmul    $8, $1, $1
	fadd    $9, $10, $8
	fadd    $8, $1, $1
be_cont.36398:
	cmp     $12, 3
	bne     be_cont.36399
be_then.36399:
	fsub    $1, $36, $1
be_cont.36399:
	fcmp    $zero, $1
	bg      ble_else.36400
ble_then.36400:
	cmp     $11, 0
	bne     be_else.36401
be_then.36401:
	li      1, $1
.count b_cont
	b       ble_cont.36400
be_else.36401:
	li      0, $1
.count b_cont
	b       ble_cont.36400
ble_else.36400:
	cmp     $11, 0
	bne     be_else.36402
be_then.36402:
	li      0, $1
.count b_cont
	b       be_cont.36402
be_else.36402:
	li      1, $1
be_cont.36402:
ble_cont.36400:
be_cont.36394:
be_cont.36387:
	cmp     $1, 0
	bne     be_else.36403
be_then.36403:
	cmp     $7, -1
	bne     be_else.36404
be_then.36404:
	li      1, $1
	ret
be_else.36404:
	load    [min_caml_objects + $7], $1
	load    [$3 + $2], $7
	add     $2, 1, $8
	load    [$1 + 1], $9
	load    [$1 + 5], $10
	load    [$1 + 5], $11
	load    [$1 + 5], $12
	load    [$10 + 0], $10
	load    [$11 + 1], $11
	load    [$12 + 2], $12
	cmp     $9, 1
	fsub    $4, $10, $10
	fsub    $5, $11, $11
	fsub    $6, $12, $12
	bne     be_else.36405
be_then.36405:
	load    [$1 + 4], $9
	fabs    $10, $10
	load    [$1 + 6], $13
	load    [$9 + 0], $9
	load    [$1 + 4], $14
	fabs    $11, $11
	fcmp    $9, $10
	bg      ble_else.36406
ble_then.36406:
	cmp     $13, 0
	bne     be_else.36407
be_then.36407:
	li      1, $1
.count b_cont
	b       be_cont.36405
be_else.36407:
	li      0, $1
.count b_cont
	b       be_cont.36405
ble_else.36406:
	load    [$14 + 1], $9
	load    [$1 + 6], $10
	load    [$1 + 4], $13
	fcmp    $9, $11
	bg      ble_else.36408
ble_then.36408:
	cmp     $10, 0
	bne     be_else.36409
be_then.36409:
	li      1, $1
.count b_cont
	b       be_cont.36405
be_else.36409:
	li      0, $1
.count b_cont
	b       be_cont.36405
ble_else.36408:
	load    [$13 + 2], $9
	fabs    $12, $10
	load    [$1 + 6], $11
	fcmp    $9, $10
	bg      ble_else.36410
ble_then.36410:
	cmp     $11, 0
	bne     be_else.36411
be_then.36411:
	li      1, $1
.count b_cont
	b       be_cont.36405
be_else.36411:
	li      0, $1
.count b_cont
	b       be_cont.36405
ble_else.36410:
	load    [$1 + 6], $1
.count b_cont
	b       be_cont.36405
be_else.36405:
	cmp     $9, 2
	load    [$1 + 6], $9
	bne     be_else.36412
be_then.36412:
	load    [$1 + 4], $1
	load    [$1 + 0], $13
	load    [$1 + 1], $14
	load    [$1 + 2], $1
	fmul    $13, $10, $10
	fmul    $14, $11, $11
	fmul    $1, $12, $1
	fadd    $10, $11, $10
	fadd    $10, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36413
ble_then.36413:
	cmp     $9, 0
	bne     be_else.36414
be_then.36414:
	li      1, $1
.count b_cont
	b       be_cont.36412
be_else.36414:
	li      0, $1
.count b_cont
	b       be_cont.36412
ble_else.36413:
	cmp     $9, 0
	bne     be_else.36415
be_then.36415:
	li      0, $1
.count b_cont
	b       be_cont.36412
be_else.36415:
	li      1, $1
.count b_cont
	b       be_cont.36412
be_else.36412:
	load    [$1 + 1], $13
	load    [$1 + 3], $14
	fmul    $10, $10, $15
	load    [$1 + 4], $16
	load    [$1 + 4], $17
	fmul    $11, $11, $18
	load    [$16 + 0], $16
	load    [$17 + 1], $17
	fmul    $12, $12, $19
	fmul    $15, $16, $15
	fmul    $18, $17, $16
	load    [$1 + 4], $17
	fmul    $11, $12, $18
	load    [$1 + 9], $20
	load    [$17 + 2], $17
	fadd    $15, $16, $15
	load    [$20 + 0], $16
	fmul    $19, $17, $17
	fmul    $12, $10, $12
	fmul    $18, $16, $16
	cmp     $14, 0
	load    [$1 + 9], $18
	fmul    $10, $11, $10
	fadd    $15, $17, $11
	bne     be_else.36416
be_then.36416:
	mov     $11, $1
.count b_cont
	b       be_cont.36416
be_else.36416:
	load    [$18 + 1], $14
	fadd    $11, $16, $11
	load    [$1 + 9], $1
	fmul    $12, $14, $12
	load    [$1 + 2], $1
	fmul    $10, $1, $1
	fadd    $11, $12, $10
	fadd    $10, $1, $1
be_cont.36416:
	cmp     $13, 3
	bne     be_cont.36417
be_then.36417:
	fsub    $1, $36, $1
be_cont.36417:
	fcmp    $zero, $1
	bg      ble_else.36418
ble_then.36418:
	cmp     $9, 0
	bne     be_else.36419
be_then.36419:
	li      1, $1
.count b_cont
	b       ble_cont.36418
be_else.36419:
	li      0, $1
.count b_cont
	b       ble_cont.36418
ble_else.36418:
	cmp     $9, 0
	bne     be_else.36420
be_then.36420:
	li      0, $1
.count b_cont
	b       be_cont.36420
be_else.36420:
	li      1, $1
be_cont.36420:
ble_cont.36418:
be_cont.36412:
be_cont.36405:
	cmp     $1, 0
	bne     be_else.36421
be_then.36421:
	cmp     $7, -1
	bne     be_else.36422
be_then.36422:
	li      1, $1
	ret
be_else.36422:
	load    [min_caml_objects + $7], $1
	add     $2, 1, $7
	add     $2, 1, $9
	load    [$1 + 5], $10
	load    [$1 + 5], $11
	load    [$1 + 5], $12
	load    [$1 + 1], $13
	load    [$10 + 0], $10
	load    [$11 + 1], $11
	load    [$12 + 2], $12
	cmp     $13, 1
	fsub    $4, $10, $10
	fsub    $5, $11, $11
	fsub    $6, $12, $12
	bne     be_else.36423
be_then.36423:
	load    [$1 + 4], $2
	fabs    $10, $9
	load    [$1 + 6], $10
	load    [$2 + 0], $2
	load    [$1 + 6], $13
	load    [$1 + 4], $14
	fcmp    $2, $9
	bg      ble_else.36424
ble_then.36424:
	li      0, $1
.count b_cont
	b       ble_cont.36424
ble_else.36424:
	load    [$14 + 1], $2
	fabs    $11, $9
	load    [$1 + 4], $1
	fcmp    $2, $9
	bg      ble_else.36425
ble_then.36425:
	li      0, $1
.count b_cont
	b       ble_cont.36425
ble_else.36425:
	load    [$1 + 2], $1
	fabs    $12, $2
	fcmp    $1, $2
	bg      ble_else.36426
ble_then.36426:
	li      0, $1
.count b_cont
	b       ble_cont.36426
ble_else.36426:
	li      1, $1
ble_cont.36426:
ble_cont.36425:
ble_cont.36424:
	cmp     $1, 0
	bne     be_else.36427
be_then.36427:
	cmp     $10, 0
	bne     be_else.36428
be_then.36428:
	li      0, $1
	ret
be_else.36428:
.count move_args
	mov     $8, $2
	b       check_all_inside.2856
be_else.36427:
	cmp     $13, 0
	bne     be_else.36429
be_then.36429:
.count move_args
	mov     $7, $2
	b       check_all_inside.2856
be_else.36429:
	li      0, $1
	ret
be_else.36423:
	cmp     $13, 2
	load    [$1 + 6], $7
	bne     be_else.36430
be_then.36430:
	load    [$1 + 4], $1
	add     $2, 1, $2
	load    [$1 + 0], $8
	load    [$1 + 1], $13
	load    [$1 + 2], $1
	fmul    $8, $10, $8
	fmul    $13, $11, $10
	fmul    $1, $12, $1
	fadd    $8, $10, $8
	fadd    $8, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36431
ble_then.36431:
	cmp     $7, 0
	bne     be_else.36432
be_then.36432:
	li      0, $1
	ret
be_else.36432:
.count move_args
	mov     $9, $2
	b       check_all_inside.2856
ble_else.36431:
	cmp     $7, 0
	be      check_all_inside.2856
	li      0, $1
	ret
be_else.36430:
	load    [$1 + 4], $8
	load    [$1 + 4], $9
	load    [$1 + 4], $14
	load    [$1 + 3], $15
	fmul    $10, $10, $16
	fmul    $11, $11, $17
	load    [$8 + 0], $8
	load    [$9 + 1], $9
	fmul    $12, $12, $18
	fmul    $16, $8, $8
	fmul    $17, $9, $9
	load    [$14 + 2], $14
	fmul    $11, $12, $16
	load    [$1 + 9], $17
	fmul    $18, $14, $14
	fadd    $8, $9, $8
	fmul    $12, $10, $12
	load    [$17 + 0], $9
	cmp     $15, 0
	load    [$1 + 9], $17
	fmul    $10, $11, $10
	fmul    $16, $9, $9
	fadd    $8, $14, $8
	bne     be_else.36434
be_then.36434:
	mov     $8, $1
.count b_cont
	b       be_cont.36434
be_else.36434:
	fadd    $8, $9, $8
	load    [$17 + 1], $9
	load    [$1 + 9], $1
	fmul    $12, $9, $9
	load    [$1 + 2], $1
	fmul    $10, $1, $1
	fadd    $8, $9, $8
	fadd    $8, $1, $1
be_cont.36434:
	cmp     $13, 3
	bne     be_cont.36435
be_then.36435:
	fsub    $1, $36, $1
be_cont.36435:
	fcmp    $zero, $1
	bg      ble_else.36436
ble_then.36436:
	cmp     $7, 0
	bne     be_else.36437
be_then.36437:
	li      0, $1
	ret
be_else.36437:
	add     $2, 1, $2
	b       check_all_inside.2856
ble_else.36436:
	cmp     $7, 0
	bne     be_else.36438
be_then.36438:
	add     $2, 1, $2
	b       check_all_inside.2856
be_else.36438:
	li      0, $1
	ret
be_else.36421:
	li      0, $1
	ret
be_else.36403:
	li      0, $1
	ret
be_else.36385:
	li      0, $1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$3 + $2], $21
	load    [min_caml_light_dirvec + 1], $22
	load    [min_caml_intersection_point + 0], $23
	cmp     $21, -1
	bne     be_else.36439
be_then.36439:
	li      0, $1
	ret
be_else.36439:
	load    [min_caml_objects + $21], $24
	load    [min_caml_intersection_point + 1], $25
	load    [min_caml_intersection_point + 2], $26
	load    [$24 + 5], $27
	load    [$24 + 5], $28
	load    [$24 + 5], $29
	load    [$24 + 1], $30
	load    [$27 + 0], $27
	load    [$28 + 1], $28
	load    [$29 + 2], $29
	cmp     $30, 1
	fsub    $23, $27, $23
	fsub    $25, $28, $25
	fsub    $26, $29, $26
	load    [$22 + $21], $22
	bne     be_else.36440
be_then.36440:
	load    [$22 + 0], $29
	load    [min_caml_light_dirvec + 0], $27
	load    [$24 + 4], $28
	fsub    $29, $23, $29
	load    [$27 + 1], $30
	load    [$22 + 1], $31
	load    [$28 + 1], $28
	load    [$24 + 4], $32
	fmul    $29, $31, $29
	load    [$27 + 0], $33
	load    [$22 + 2], $34
	load    [$32 + 0], $31
	load    [$24 + 4], $35
	fmul    $29, $30, $30
	fsub    $34, $25, $32
	load    [$22 + 3], $34
	load    [$27 + 2], $1
	load    [$27 + 0], $4
	fadd    $30, $25, $30
	fmul    $32, $34, $32
	load    [$35 + 2], $34
	fmul    $29, $1, $35
	load    [$24 + 4], $1
	fabs    $30, $30
	fmul    $32, $33, $33
	fcmp    $28, $30
	fadd    $35, $26, $35
	load    [$1 + 0], $1
	bg      ble_else.36441
ble_then.36441:
	li      0, $28
.count b_cont
	b       ble_cont.36441
ble_else.36441:
	fabs    $35, $28
	load    [$22 + 1], $30
	fcmp    $34, $28
	bg      ble_else.36442
ble_then.36442:
	li      0, $28
.count b_cont
	b       ble_cont.36442
ble_else.36442:
	fcmp    $30, $zero
	bne     be_else.36443
be_then.36443:
	li      0, $28
.count b_cont
	b       be_cont.36443
be_else.36443:
	li      1, $28
be_cont.36443:
ble_cont.36442:
ble_cont.36441:
	cmp     $28, 0
	bne     be_else.36444
be_then.36444:
	fadd    $33, $23, $28
	load    [$22 + 4], $29
	load    [$22 + 5], $30
	load    [$24 + 4], $33
	fsub    $29, $26, $29
	fabs    $28, $28
	load    [$33 + 2], $33
	fcmp    $31, $28
	bg      ble_else.36445
ble_then.36445:
	li      0, $26
.count b_cont
	b       ble_cont.36445
ble_else.36445:
	load    [$27 + 2], $28
	load    [$22 + 3], $31
	fmul    $32, $28, $28
	fadd    $28, $26, $26
	fabs    $26, $26
	fcmp    $33, $26
	bg      ble_else.36446
ble_then.36446:
	li      0, $26
.count b_cont
	b       ble_cont.36446
ble_else.36446:
	fcmp    $31, $zero
	bne     be_else.36447
be_then.36447:
	li      0, $26
.count b_cont
	b       be_cont.36447
be_else.36447:
	li      1, $26
be_cont.36447:
ble_cont.36446:
ble_cont.36445:
	cmp     $26, 0
	bne     be_else.36448
be_then.36448:
	fmul    $29, $30, $26
	load    [$24 + 4], $24
	load    [$27 + 1], $27
	load    [$22 + 5], $22
	load    [$24 + 1], $24
	fmul    $26, $4, $28
	fmul    $26, $27, $27
	fadd    $28, $23, $23
	fadd    $27, $25, $25
	fabs    $23, $23
	fabs    $25, $25
	fcmp    $1, $23
	bg      ble_else.36449
ble_then.36449:
	li      0, $22
.count b_cont
	b       be_cont.36440
ble_else.36449:
	fcmp    $24, $25
	bg      ble_else.36450
ble_then.36450:
	li      0, $22
.count b_cont
	b       be_cont.36440
ble_else.36450:
	fcmp    $22, $zero
	bne     be_else.36451
be_then.36451:
	li      0, $22
.count b_cont
	b       be_cont.36440
be_else.36451:
.count move_float
	mov     $26, $42
	li      3, $22
.count b_cont
	b       be_cont.36440
be_else.36448:
.count move_float
	mov     $32, $42
	li      2, $22
.count b_cont
	b       be_cont.36440
be_else.36444:
.count move_float
	mov     $29, $42
	li      1, $22
.count b_cont
	b       be_cont.36440
be_else.36440:
	cmp     $30, 2
	bne     be_else.36452
be_then.36452:
	load    [$22 + 0], $24
	load    [$22 + 1], $27
	load    [$22 + 2], $28
	fcmp    $zero, $24
	bg      ble_else.36453
ble_then.36453:
	li      0, $22
.count b_cont
	b       be_cont.36452
ble_else.36453:
	fmul    $27, $23, $23
	fmul    $28, $25, $24
	load    [$22 + 3], $22
	fmul    $22, $26, $22
	fadd    $23, $24, $23
	fadd    $23, $22, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36452
be_else.36452:
	load    [$22 + 0], $27
	load    [$22 + 1], $28
	load    [$22 + 2], $29
	fcmp    $27, $zero
	bne     be_else.36454
be_then.36454:
	li      0, $22
.count b_cont
	b       be_cont.36454
be_else.36454:
	fmul    $28, $23, $28
	fmul    $29, $25, $29
	load    [$22 + 3], $31
	fmul    $23, $23, $32
	load    [$24 + 4], $33
	load    [$24 + 4], $34
	fadd    $28, $29, $28
	fmul    $31, $26, $29
	fmul    $25, $25, $31
	load    [$33 + 0], $33
	load    [$34 + 1], $34
	fmul    $26, $26, $35
	fadd    $28, $29, $28
	load    [$24 + 4], $29
	fmul    $32, $33, $32
	fmul    $31, $34, $31
	load    [$29 + 2], $29
	fmul    $28, $28, $33
	load    [$24 + 3], $34
	fmul    $35, $29, $29
	fadd    $32, $31, $31
	load    [$24 + 6], $32
	fmul    $25, $26, $35
	cmp     $34, 0
	load    [$24 + 9], $1
	fmul    $26, $23, $26
	fadd    $31, $29, $29
	bne     be_else.36455
be_then.36455:
	mov     $29, $23
.count b_cont
	b       be_cont.36455
be_else.36455:
	load    [$1 + 0], $31
	load    [$24 + 9], $34
	fmul    $23, $25, $23
	fmul    $35, $31, $25
	load    [$34 + 1], $31
	load    [$24 + 9], $24
	fmul    $26, $31, $26
	fadd    $29, $25, $25
	load    [$24 + 2], $24
	fmul    $23, $24, $23
	fadd    $25, $26, $24
	fadd    $24, $23, $23
be_cont.36455:
	cmp     $30, 3
	bne     be_cont.36456
be_then.36456:
	fsub    $23, $36, $23
be_cont.36456:
	fmul    $27, $23, $23
	load    [$22 + 4], $24
	load    [$22 + 4], $22
	fsub    $33, $23, $23
	fcmp    $23, $zero
	bg      ble_else.36457
ble_then.36457:
	li      0, $22
.count b_cont
	b       ble_cont.36457
ble_else.36457:
	cmp     $32, 0
	bne     be_else.36458
be_then.36458:
	fsqrt   $23, $22
	fsub    $28, $22, $22
	fmul    $22, $24, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36458
be_else.36458:
	fsqrt   $23, $23
	fadd    $28, $23, $23
	fmul    $23, $22, $22
.count move_float
	mov     $22, $42
	li      1, $22
be_cont.36458:
ble_cont.36457:
be_cont.36454:
be_cont.36452:
be_cont.36440:
	cmp     $22, 0
	bne     be_else.36459
be_then.36459:
	li      0, $22
.count b_cont
	b       be_cont.36459
be_else.36459:
.count load_float
	load    [f.31948], $22
	fcmp    $22, $42
	bg      ble_else.36460
ble_then.36460:
	li      0, $22
.count b_cont
	b       ble_cont.36460
ble_else.36460:
	li      1, $22
ble_cont.36460:
be_cont.36459:
	cmp     $22, 0
	bne     be_else.36461
be_then.36461:
	load    [min_caml_objects + $21], $1
	add     $2, 1, $2
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     shadow_check_and_group.2862
	li      0, $1
	ret
be_else.36461:
	load    [$3 + 0], $21
.count load_float
	load    [f.31949], $22
	cmp     $21, -1
	bne     be_else.36463
be_then.36463:
	li      1, $1
	ret
be_else.36463:
	fadd    $42, $22, $22
	load    [min_caml_objects + $21], $21
	load    [min_caml_intersection_point + 0], $23
	load    [min_caml_intersection_point + 1], $29
	load    [$21 + 5], $24
	load    [$21 + 5], $25
	load    [$21 + 5], $26
	load    [$21 + 1], $27
	load    [$24 + 0], $24
	fmul    $55, $22, $28
	load    [$25 + 1], $25
	load    [$26 + 2], $26
	cmp     $27, 1
	fadd    $28, $23, $4
	fmul    $56, $22, $23
	fmul    $57, $22, $22
	load    [min_caml_intersection_point + 2], $28
	fsub    $4, $24, $24
	fadd    $23, $29, $5
	fadd    $22, $28, $6
	li      1, $22
	add     $2, 1, $23
	load    [$21 + 4], $28
	fsub    $5, $25, $25
	fsub    $6, $26, $26
	bne     be_else.36464
be_then.36464:
	load    [$28 + 0], $27
	fabs    $24, $24
	load    [$21 + 6], $28
	fcmp    $27, $24
	bg      ble_else.36465
ble_then.36465:
	cmp     $28, 0
	bne     be_else.36466
be_then.36466:
	li      1, $21
.count b_cont
	b       be_cont.36464
be_else.36466:
	li      0, $21
.count b_cont
	b       be_cont.36464
ble_else.36465:
	load    [$21 + 4], $24
	fabs    $25, $25
	load    [$21 + 6], $27
	load    [$24 + 1], $24
	load    [$21 + 4], $28
	fabs    $26, $26
	fcmp    $24, $25
	bg      ble_else.36467
ble_then.36467:
	cmp     $27, 0
	bne     be_else.36468
be_then.36468:
	li      1, $21
.count b_cont
	b       be_cont.36464
be_else.36468:
	li      0, $21
.count b_cont
	b       be_cont.36464
ble_else.36467:
	load    [$28 + 2], $24
	load    [$21 + 6], $25
	load    [$21 + 6], $21
	fcmp    $24, $26
	bg      be_cont.36464
ble_then.36469:
	cmp     $25, 0
	bne     be_else.36470
be_then.36470:
	li      1, $21
.count b_cont
	b       be_cont.36464
be_else.36470:
	li      0, $21
.count b_cont
	b       be_cont.36464
be_else.36464:
	cmp     $27, 2
	bne     be_else.36471
be_then.36471:
	load    [$21 + 6], $27
	load    [$21 + 4], $21
	load    [$21 + 0], $28
	load    [$21 + 1], $29
	load    [$21 + 2], $21
	fmul    $28, $24, $24
	fmul    $29, $25, $25
	fmul    $21, $26, $21
	fadd    $24, $25, $24
	fadd    $24, $21, $21
	fcmp    $zero, $21
	bg      ble_else.36472
ble_then.36472:
	cmp     $27, 0
	bne     be_else.36473
be_then.36473:
	li      1, $21
.count b_cont
	b       be_cont.36471
be_else.36473:
	li      0, $21
.count b_cont
	b       be_cont.36471
ble_else.36472:
	cmp     $27, 0
	bne     be_else.36474
be_then.36474:
	li      0, $21
.count b_cont
	b       be_cont.36471
be_else.36474:
	li      1, $21
.count b_cont
	b       be_cont.36471
be_else.36471:
	load    [$21 + 6], $28
	fmul    $24, $24, $29
	load    [$21 + 4], $30
	load    [$21 + 4], $31
	fmul    $25, $25, $32
	load    [$30 + 0], $30
	load    [$31 + 1], $31
	fmul    $26, $26, $33
	fmul    $29, $30, $29
	fmul    $32, $31, $30
	load    [$21 + 4], $31
	load    [$21 + 3], $32
	fmul    $25, $26, $34
	load    [$31 + 2], $31
	fadd    $29, $30, $29
	load    [$21 + 9], $30
	fmul    $33, $31, $31
	fmul    $26, $24, $26
	load    [$30 + 0], $30
	cmp     $32, 0
	load    [$21 + 9], $33
	fmul    $24, $25, $24
	fadd    $29, $31, $25
	bne     be_else.36475
be_then.36475:
	mov     $25, $21
.count b_cont
	b       be_cont.36475
be_else.36475:
	fmul    $34, $30, $29
	load    [$33 + 1], $30
	load    [$21 + 9], $21
	fmul    $26, $30, $26
	fadd    $25, $29, $25
	load    [$21 + 2], $21
	fmul    $24, $21, $21
	fadd    $25, $26, $24
	fadd    $24, $21, $21
be_cont.36475:
	cmp     $27, 3
	bne     be_cont.36476
be_then.36476:
	fsub    $21, $36, $21
be_cont.36476:
	fcmp    $zero, $21
	bg      ble_else.36477
ble_then.36477:
	cmp     $28, 0
	bne     be_else.36478
be_then.36478:
	li      1, $21
.count b_cont
	b       ble_cont.36477
be_else.36478:
	li      0, $21
.count b_cont
	b       ble_cont.36477
ble_else.36477:
	cmp     $28, 0
	bne     be_else.36479
be_then.36479:
	li      0, $21
.count b_cont
	b       be_cont.36479
be_else.36479:
	li      1, $21
be_cont.36479:
ble_cont.36477:
be_cont.36471:
be_cont.36464:
	cmp     $21, 0
	bne     be_else.36480
be_then.36480:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count move_args
	mov     $22, $2
	call    check_all_inside.2856
	cmp     $1, 0
.count stack_move
	add     $sp, 2, $sp
	bne     be_else.36481
be_then.36481:
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 2], $3
	add     $1, 1, $2
	b       shadow_check_and_group.2862
be_else.36481:
	li      1, $1
	ret
be_else.36480:
.count move_args
	mov     $23, $2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$3 + $2], $1
	li      0, $4
	cmp     $1, -1
	bne     be_else.36482
be_then.36482:
	li      0, $1
	ret
be_else.36482:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $4, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36483
be_then.36483:
.count stack_load
	load    [$sp + 1], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36484
be_then.36484:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36484:
.count stack_store
	store   $1, [$sp + 2]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36485
be_then.36485:
.count stack_load
	load    [$sp + 2], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36486
be_then.36486:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36486:
.count stack_store
	store   $1, [$sp + 3]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36487
be_then.36487:
.count stack_load
	load    [$sp + 3], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36488
be_then.36488:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36488:
.count stack_store
	store   $1, [$sp + 4]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36489
be_then.36489:
.count stack_load
	load    [$sp + 4], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36490
be_then.36490:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36490:
.count stack_store
	store   $1, [$sp + 5]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36491
be_then.36491:
.count stack_load
	load    [$sp + 5], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36492
be_then.36492:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36492:
.count stack_store
	store   $1, [$sp + 6]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36493
be_then.36493:
.count stack_load
	load    [$sp + 6], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36494
be_then.36494:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36494:
.count stack_store
	store   $1, [$sp + 7]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36495
be_then.36495:
.count stack_load
	load    [$sp + 7], $1
	li      0, $2
.count stack_load
	load    [$sp + 0], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36496
be_then.36496:
.count stack_move
	add     $sp, 9, $sp
	li      0, $1
	ret
be_else.36496:
.count stack_store
	store   $1, [$sp + 8]
	load    [min_caml_and_net + $4], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
.count stack_move
	add     $sp, 9, $sp
	bne     be_else.36497
be_then.36497:
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 9], $3
	add     $1, 1, $2
	b       shadow_check_one_or_group.2865
be_else.36497:
	li      1, $1
	ret
be_else.36495:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36493:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36491:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36489:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36487:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36485:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
be_else.36483:
.count stack_move
	add     $sp, 9, $sp
	li      1, $1
	ret
.end shadow_check_one_or_group

######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$3 + $2], $17
	load    [min_caml_intersection_point + 0], $18
	load    [min_caml_intersection_point + 1], $19
	load    [$17 + 0], $20
	load    [min_caml_intersection_point + 2], $21
	load    [min_caml_light_dirvec + 1], $22
	cmp     $20, -1
	bne     be_else.36498
be_then.36498:
	li      0, $1
	ret
be_else.36498:
.count stack_move
	sub     $sp, 7, $sp
	cmp     $20, 99
.count stack_store
	store   $17, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.36499
be_then.36499:
	li      1, $17
.count b_cont
	b       be_cont.36499
be_else.36499:
	load    [min_caml_objects + $20], $23
	load    [$22 + $20], $20
	load    [min_caml_light_dirvec + 0], $22
	load    [$23 + 5], $24
	load    [$23 + 5], $25
	load    [$23 + 5], $26
	load    [$24 + 0], $24
	load    [$25 + 1], $25
	load    [$26 + 2], $26
	fsub    $18, $24, $18
	load    [$23 + 1], $24
	fsub    $19, $25, $19
	fsub    $21, $26, $21
	cmp     $24, 1
	load    [$23 + 4], $25
	load    [$22 + 1], $26
	bne     be_else.36500
be_then.36500:
	load    [$25 + 1], $24
	load    [$20 + 0], $25
	load    [$20 + 1], $27
	load    [$23 + 4], $28
	fsub    $25, $18, $25
	load    [$22 + 0], $29
	load    [$28 + 0], $28
	load    [$20 + 2], $30
	load    [$20 + 3], $31
	fmul    $25, $27, $25
	fsub    $30, $19, $27
	load    [$23 + 4], $30
	load    [$22 + 2], $32
	load    [$23 + 4], $33
	fmul    $25, $26, $26
	fmul    $27, $31, $27
	load    [$30 + 2], $30
	fmul    $25, $32, $31
	load    [$33 + 0], $32
	fadd    $26, $19, $26
	fmul    $27, $29, $29
	load    [$22 + 0], $33
	fadd    $31, $21, $31
	load    [$20 + 4], $34
	fabs    $26, $26
	fadd    $29, $18, $29
	fcmp    $24, $26
	bg      ble_else.36501
ble_then.36501:
	li      0, $24
.count b_cont
	b       ble_cont.36501
ble_else.36501:
	fabs    $31, $24
	load    [$20 + 1], $26
	fcmp    $30, $24
	bg      ble_else.36502
ble_then.36502:
	li      0, $24
.count b_cont
	b       ble_cont.36502
ble_else.36502:
	fcmp    $26, $zero
	bne     be_else.36503
be_then.36503:
	li      0, $24
.count b_cont
	b       be_cont.36503
be_else.36503:
	li      1, $24
be_cont.36503:
ble_cont.36502:
ble_cont.36501:
	cmp     $24, 0
	bne     be_else.36504
be_then.36504:
	fabs    $29, $24
	fsub    $34, $21, $25
	fcmp    $28, $24
	bg      ble_else.36505
ble_then.36505:
	li      0, $21
.count b_cont
	b       ble_cont.36505
ble_else.36505:
	load    [$22 + 2], $26
	load    [$23 + 4], $24
	load    [$20 + 3], $28
	fmul    $27, $26, $26
	load    [$24 + 2], $24
	fadd    $26, $21, $21
	fabs    $21, $21
	fcmp    $24, $21
	bg      ble_else.36506
ble_then.36506:
	li      0, $21
.count b_cont
	b       ble_cont.36506
ble_else.36506:
	fcmp    $28, $zero
	bne     be_else.36507
be_then.36507:
	li      0, $21
.count b_cont
	b       be_cont.36507
be_else.36507:
	li      1, $21
be_cont.36507:
ble_cont.36506:
ble_cont.36505:
	cmp     $21, 0
	bne     be_else.36508
be_then.36508:
	load    [$20 + 5], $21
	load    [$23 + 4], $23
	load    [$22 + 1], $22
	fmul    $25, $21, $21
	load    [$23 + 1], $23
	load    [$20 + 5], $20
	fmul    $21, $33, $24
	fmul    $21, $22, $22
	fadd    $24, $18, $18
	fadd    $22, $19, $19
	fabs    $18, $18
	fabs    $19, $19
	fcmp    $32, $18
	bg      ble_else.36509
ble_then.36509:
	li      0, $18
.count b_cont
	b       be_cont.36500
ble_else.36509:
	fcmp    $23, $19
	bg      ble_else.36510
ble_then.36510:
	li      0, $18
.count b_cont
	b       be_cont.36500
ble_else.36510:
	fcmp    $20, $zero
	bne     be_else.36511
be_then.36511:
	li      0, $18
.count b_cont
	b       be_cont.36500
be_else.36511:
.count move_float
	mov     $21, $42
	li      3, $18
.count b_cont
	b       be_cont.36500
be_else.36508:
.count move_float
	mov     $27, $42
	li      2, $18
.count b_cont
	b       be_cont.36500
be_else.36504:
.count move_float
	mov     $25, $42
	li      1, $18
.count b_cont
	b       be_cont.36500
be_else.36500:
	cmp     $24, 2
	load    [$20 + 0], $22
	bne     be_else.36512
be_then.36512:
	fcmp    $zero, $22
	load    [$20 + 1], $23
	load    [$20 + 2], $24
	bg      ble_else.36513
ble_then.36513:
	li      0, $18
.count b_cont
	b       be_cont.36512
ble_else.36513:
	fmul    $23, $18, $18
	fmul    $24, $19, $19
	load    [$20 + 3], $20
	fmul    $20, $21, $20
	fadd    $18, $19, $18
	fadd    $18, $20, $18
.count move_float
	mov     $18, $42
	li      1, $18
.count b_cont
	b       be_cont.36512
be_else.36512:
	fcmp    $22, $zero
	load    [$20 + 1], $25
	load    [$20 + 2], $26
	bne     be_else.36514
be_then.36514:
	li      0, $18
.count b_cont
	b       be_cont.36514
be_else.36514:
	fmul    $25, $18, $25
	fmul    $26, $19, $26
	load    [$20 + 3], $27
	fmul    $18, $18, $28
	load    [$23 + 4], $29
	load    [$23 + 4], $30
	fadd    $25, $26, $25
	fmul    $27, $21, $26
	fmul    $19, $19, $27
	load    [$29 + 0], $29
	load    [$30 + 1], $30
	fmul    $21, $21, $31
	fadd    $25, $26, $25
	load    [$23 + 4], $26
	fmul    $28, $29, $28
	fmul    $27, $30, $27
	load    [$26 + 2], $26
	fmul    $25, $25, $29
	load    [$23 + 3], $30
	fmul    $31, $26, $26
	fadd    $28, $27, $27
	load    [$23 + 6], $28
	fmul    $19, $21, $31
	cmp     $30, 0
	load    [$23 + 9], $32
	fmul    $21, $18, $21
	fadd    $27, $26, $26
	bne     be_else.36515
be_then.36515:
	mov     $26, $18
.count b_cont
	b       be_cont.36515
be_else.36515:
	load    [$32 + 0], $27
	load    [$23 + 9], $30
	fmul    $18, $19, $18
	fmul    $31, $27, $19
	load    [$30 + 1], $27
	load    [$23 + 9], $23
	fmul    $21, $27, $21
	fadd    $26, $19, $19
	load    [$23 + 2], $23
	fmul    $18, $23, $18
	fadd    $19, $21, $19
	fadd    $19, $18, $18
be_cont.36515:
	cmp     $24, 3
	bne     be_cont.36516
be_then.36516:
	fsub    $18, $36, $18
be_cont.36516:
	fmul    $22, $18, $18
	load    [$20 + 4], $19
	load    [$20 + 4], $20
	fsub    $29, $18, $18
	fcmp    $18, $zero
	bg      ble_else.36517
ble_then.36517:
	li      0, $18
.count b_cont
	b       ble_cont.36517
ble_else.36517:
	cmp     $28, 0
	fsqrt   $18, $18
	bne     be_else.36518
be_then.36518:
	fsub    $25, $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
.count b_cont
	b       be_cont.36518
be_else.36518:
	fadd    $25, $18, $18
	fmul    $18, $20, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.36518:
ble_cont.36517:
be_cont.36514:
be_cont.36512:
be_cont.36500:
	cmp     $18, 0
	bne     be_else.36519
be_then.36519:
	li      0, $17
.count b_cont
	b       be_cont.36519
be_else.36519:
.count load_float
	load    [f.31950], $18
	load    [$17 + 1], $19
	li      0, $2
	fcmp    $18, $42
	bg      ble_else.36520
ble_then.36520:
	li      0, $17
.count b_cont
	b       ble_cont.36520
ble_else.36520:
	cmp     $19, -1
	bne     be_else.36521
be_then.36521:
	li      0, $17
.count b_cont
	b       be_cont.36521
be_else.36521:
	load    [min_caml_and_net + $19], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36522
be_then.36522:
	li      2, $2
.count stack_load
	load    [$sp + 0], $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36523
be_then.36523:
	li      0, $17
.count b_cont
	b       be_cont.36522
be_else.36523:
	li      1, $17
.count b_cont
	b       be_cont.36522
be_else.36522:
	li      1, $17
be_cont.36522:
be_cont.36521:
ble_cont.36520:
be_cont.36519:
be_cont.36499:
	cmp     $17, 0
	bne     be_else.36524
be_then.36524:
.count stack_load
	load    [$sp + 2], $17
.count stack_load
	load    [$sp + 1], $18
	add     $17, 1, $17
	load    [$18 + $17], $19
	load    [$19 + 0], $2
	cmp     $2, -1
	bne     be_else.36525
be_then.36525:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.36525:
	cmp     $2, 99
.count stack_store
	store   $19, [$sp + 3]
.count stack_store
	store   $17, [$sp + 4]
	bne     be_else.36526
be_then.36526:
	li      1, $1
.count b_cont
	b       be_cont.36526
be_else.36526:
	call    solver_fast.2796
	cmp     $1, 0
	bne     be_else.36527
be_then.36527:
	li      0, $1
.count b_cont
	b       be_cont.36527
be_else.36527:
.count load_float
	load    [f.31950], $1
	load    [$19 + 1], $2
	li      0, $3
	fcmp    $1, $42
	bg      ble_else.36528
ble_then.36528:
	li      0, $1
.count b_cont
	b       ble_cont.36528
ble_else.36528:
	cmp     $2, -1
	bne     be_else.36529
be_then.36529:
	li      0, $1
.count b_cont
	b       be_cont.36529
be_else.36529:
	load    [min_caml_and_net + $2], $1
.count move_args
	mov     $3, $2
.count move_args
	mov     $1, $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36530
be_then.36530:
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.36531
be_then.36531:
	li      0, $1
.count b_cont
	b       be_cont.36530
be_else.36531:
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36532
be_then.36532:
	li      3, $2
.count stack_load
	load    [$sp + 3], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.36533
be_then.36533:
	li      0, $1
.count b_cont
	b       be_cont.36530
be_else.36533:
	li      1, $1
.count b_cont
	b       be_cont.36530
be_else.36532:
	li      1, $1
.count b_cont
	b       be_cont.36530
be_else.36530:
	li      1, $1
be_cont.36530:
be_cont.36529:
ble_cont.36528:
be_cont.36527:
be_cont.36526:
	cmp     $1, 0
	bne     be_else.36534
be_then.36534:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.36534:
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 1], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36535
be_then.36535:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.36535:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36536
be_then.36536:
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 2], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36537
be_then.36537:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.36537:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36538
be_then.36538:
	li      3, $2
.count stack_load
	load    [$sp + 3], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
.count stack_move
	add     $sp, 7, $sp
	bne     be_else.36539
be_then.36539:
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.36539:
	li      1, $1
	ret
be_else.36538:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.36536:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.36524:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 1], $17
	cmp     $17, -1
	bne     be_else.36540
be_then.36540:
	li      0, $17
.count b_cont
	b       be_cont.36540
be_else.36540:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36541
be_then.36541:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 2], $17
	cmp     $17, -1
	bne     be_else.36542
be_then.36542:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36542:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36543
be_then.36543:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 3], $17
	cmp     $17, -1
	bne     be_else.36544
be_then.36544:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36544:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36545
be_then.36545:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 4], $17
	cmp     $17, -1
	bne     be_else.36546
be_then.36546:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36546:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36547
be_then.36547:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 5], $17
	cmp     $17, -1
	bne     be_else.36548
be_then.36548:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36548:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36549
be_then.36549:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 6], $17
	cmp     $17, -1
	bne     be_else.36550
be_then.36550:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36550:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36551
be_then.36551:
.count stack_load
	load    [$sp + 0], $3
	li      0, $2
	load    [$3 + 7], $17
	cmp     $17, -1
	bne     be_else.36552
be_then.36552:
	li      0, $17
.count b_cont
	b       be_cont.36541
be_else.36552:
	load    [min_caml_and_net + $17], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	bne     be_else.36553
be_then.36553:
	li      8, $2
.count stack_load
	load    [$sp + 0], $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $17
.count b_cont
	b       be_cont.36541
be_else.36553:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36551:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36549:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36547:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36545:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36543:
	li      1, $17
.count b_cont
	b       be_cont.36541
be_else.36541:
	li      1, $17
be_cont.36541:
be_cont.36540:
	cmp     $17, 0
	bne     be_else.36554
be_then.36554:
.count stack_load
	load    [$sp + 2], $17
.count stack_load
	load    [$sp + 1], $18
	add     $17, 1, $17
	load    [$18 + $17], $19
	load    [$19 + 0], $2
	cmp     $2, -1
	bne     be_else.36555
be_then.36555:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.36555:
	cmp     $2, 99
.count stack_store
	store   $19, [$sp + 5]
.count stack_store
	store   $17, [$sp + 6]
	bne     be_else.36556
be_then.36556:
	li      1, $1
.count b_cont
	b       be_cont.36556
be_else.36556:
	call    solver_fast.2796
	cmp     $1, 0
	bne     be_else.36557
be_then.36557:
	li      0, $1
.count b_cont
	b       be_cont.36557
be_else.36557:
.count load_float
	load    [f.31950], $1
	load    [$19 + 1], $2
	li      0, $3
	fcmp    $1, $42
	bg      ble_else.36558
ble_then.36558:
	li      0, $1
.count b_cont
	b       ble_cont.36558
ble_else.36558:
	cmp     $2, -1
	bne     be_else.36559
be_then.36559:
	li      0, $1
.count b_cont
	b       be_cont.36559
be_else.36559:
	load    [min_caml_and_net + $2], $1
.count move_args
	mov     $3, $2
.count move_args
	mov     $1, $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36560
be_then.36560:
.count stack_load
	load    [$sp + 5], $3
	li      0, $2
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.36561
be_then.36561:
	li      0, $1
.count b_cont
	b       be_cont.36560
be_else.36561:
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36562
be_then.36562:
	li      3, $2
.count stack_load
	load    [$sp + 5], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.36563
be_then.36563:
	li      0, $1
.count b_cont
	b       be_cont.36560
be_else.36563:
	li      1, $1
.count b_cont
	b       be_cont.36560
be_else.36562:
	li      1, $1
.count b_cont
	b       be_cont.36560
be_else.36560:
	li      1, $1
be_cont.36560:
be_cont.36559:
ble_cont.36558:
be_cont.36557:
be_cont.36556:
	cmp     $1, 0
	bne     be_else.36564
be_then.36564:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.36564:
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 6], $2
	li      0, $5
	load    [$3 + 1], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36565
be_then.36565:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.36565:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36566
be_then.36566:
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 6], $2
	li      0, $5
	load    [$3 + 2], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36567
be_then.36567:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.36567:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36568
be_then.36568:
	li      3, $2
.count stack_load
	load    [$sp + 5], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
.count stack_move
	add     $sp, 7, $sp
	bne     be_else.36569
be_then.36569:
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.36569:
	li      1, $1
	ret
be_else.36568:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.36566:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.36554:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
.end shadow_check_one_or_matrix

######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$3 + $2], $21
	load    [min_caml_startp + 0], $22
	load    [min_caml_startp + 1], $23
	cmp     $21, -1
	bne     be_else.36570
be_then.36570:
	ret
be_else.36570:
	load    [min_caml_objects + $21], $24
	load    [min_caml_startp + 2], $25
	load    [$4 + 0], $26
	load    [$24 + 5], $27
	load    [$24 + 5], $28
	load    [$24 + 5], $29
	load    [$24 + 1], $30
	load    [$27 + 0], $27
	load    [$28 + 1], $28
	load    [$29 + 2], $29
	cmp     $30, 1
	fsub    $22, $27, $22
	fsub    $23, $28, $23
	fsub    $25, $29, $25
	bne     be_else.36571
be_then.36571:
	fcmp    $26, $zero
	bne     be_else.36572
be_then.36572:
	li      0, $26
.count b_cont
	b       be_cont.36572
be_else.36572:
	fcmp    $zero, $26
	load    [$24 + 4], $27
	load    [$24 + 6], $28
	bg      ble_else.36573
ble_then.36573:
	li      0, $29
.count b_cont
	b       ble_cont.36573
ble_else.36573:
	li      1, $29
ble_cont.36573:
	cmp     $28, 0
	bne     be_else.36574
be_then.36574:
	mov     $29, $28
.count b_cont
	b       be_cont.36574
be_else.36574:
	cmp     $29, 0
	bne     be_else.36575
be_then.36575:
	li      1, $28
.count b_cont
	b       be_cont.36575
be_else.36575:
	li      0, $28
be_cont.36575:
be_cont.36574:
	cmp     $28, 0
	load    [$27 + 0], $29
	bne     be_else.36576
be_then.36576:
	fneg    $29, $28
.count b_cont
	b       be_cont.36576
be_else.36576:
	mov     $29, $28
be_cont.36576:
	fsub    $28, $22, $28
	finv    $26, $26
	load    [$27 + 1], $29
	load    [$4 + 1], $30
	load    [$27 + 2], $27
	load    [$4 + 2], $31
	fmul    $28, $26, $26
	fmul    $26, $30, $28
	fmul    $26, $31, $30
	fadd    $28, $23, $28
	fadd    $30, $25, $30
	fabs    $28, $28
	fabs    $30, $30
	fcmp    $29, $28
	bg      ble_else.36577
ble_then.36577:
	li      0, $26
.count b_cont
	b       ble_cont.36577
ble_else.36577:
	fcmp    $27, $30
	bg      ble_else.36578
ble_then.36578:
	li      0, $26
.count b_cont
	b       ble_cont.36578
ble_else.36578:
.count move_float
	mov     $26, $42
	li      1, $26
ble_cont.36578:
ble_cont.36577:
be_cont.36572:
	cmp     $26, 0
	bne     be_else.36579
be_then.36579:
	load    [$4 + 1], $26
	load    [$24 + 4], $27
	load    [$24 + 6], $28
	fcmp    $26, $zero
	bne     be_else.36580
be_then.36580:
	li      0, $26
.count b_cont
	b       be_cont.36580
be_else.36580:
	fcmp    $zero, $26
	bg      ble_else.36581
ble_then.36581:
	li      0, $29
.count b_cont
	b       ble_cont.36581
ble_else.36581:
	li      1, $29
ble_cont.36581:
	cmp     $28, 0
	bne     be_else.36582
be_then.36582:
	mov     $29, $28
.count b_cont
	b       be_cont.36582
be_else.36582:
	cmp     $29, 0
	bne     be_else.36583
be_then.36583:
	li      1, $28
.count b_cont
	b       be_cont.36583
be_else.36583:
	li      0, $28
be_cont.36583:
be_cont.36582:
	cmp     $28, 0
	load    [$27 + 1], $29
	bne     be_else.36584
be_then.36584:
	fneg    $29, $28
.count b_cont
	b       be_cont.36584
be_else.36584:
	mov     $29, $28
be_cont.36584:
	fsub    $28, $23, $28
	finv    $26, $26
	load    [$27 + 2], $29
	load    [$4 + 2], $30
	load    [$27 + 0], $27
	load    [$4 + 0], $31
	fmul    $28, $26, $26
	fmul    $26, $30, $28
	fmul    $26, $31, $30
	fadd    $28, $25, $28
	fadd    $30, $22, $30
	fabs    $28, $28
	fabs    $30, $30
	fcmp    $29, $28
	bg      ble_else.36585
ble_then.36585:
	li      0, $26
.count b_cont
	b       ble_cont.36585
ble_else.36585:
	fcmp    $27, $30
	bg      ble_else.36586
ble_then.36586:
	li      0, $26
.count b_cont
	b       ble_cont.36586
ble_else.36586:
.count move_float
	mov     $26, $42
	li      1, $26
ble_cont.36586:
ble_cont.36585:
be_cont.36580:
	cmp     $26, 0
	bne     be_else.36587
be_then.36587:
	load    [$4 + 2], $26
	load    [$24 + 4], $27
	load    [$4 + 0], $28
	fcmp    $26, $zero
	bne     be_else.36588
be_then.36588:
	li      0, $22
.count b_cont
	b       be_cont.36571
be_else.36588:
	fcmp    $zero, $26
	load    [$27 + 0], $29
	load    [$24 + 6], $24
	bg      ble_else.36589
ble_then.36589:
	li      0, $30
.count b_cont
	b       ble_cont.36589
ble_else.36589:
	li      1, $30
ble_cont.36589:
	cmp     $24, 0
	bne     be_else.36590
be_then.36590:
	mov     $30, $24
.count b_cont
	b       be_cont.36590
be_else.36590:
	cmp     $30, 0
	bne     be_else.36591
be_then.36591:
	li      1, $24
.count b_cont
	b       be_cont.36591
be_else.36591:
	li      0, $24
be_cont.36591:
be_cont.36590:
	cmp     $24, 0
	load    [$27 + 2], $30
	bne     be_else.36592
be_then.36592:
	fneg    $30, $24
.count b_cont
	b       be_cont.36592
be_else.36592:
	mov     $30, $24
be_cont.36592:
	fsub    $24, $25, $24
	finv    $26, $25
	load    [$27 + 1], $26
	load    [$4 + 1], $27
	fmul    $24, $25, $24
	fmul    $24, $28, $25
	fmul    $24, $27, $27
	fadd    $25, $22, $22
	fadd    $27, $23, $23
	fabs    $22, $22
	fabs    $23, $23
	fcmp    $29, $22
	bg      ble_else.36593
ble_then.36593:
	li      0, $22
.count b_cont
	b       be_cont.36571
ble_else.36593:
	fcmp    $26, $23
	bg      ble_else.36594
ble_then.36594:
	li      0, $22
.count b_cont
	b       be_cont.36571
ble_else.36594:
.count move_float
	mov     $24, $42
	li      3, $22
.count b_cont
	b       be_cont.36571
be_else.36587:
	li      2, $22
.count b_cont
	b       be_cont.36571
be_else.36579:
	li      1, $22
.count b_cont
	b       be_cont.36571
be_else.36571:
	cmp     $30, 2
	bne     be_else.36595
be_then.36595:
	load    [$24 + 4], $24
	load    [$4 + 0], $26
	load    [$4 + 1], $27
	load    [$24 + 0], $28
	load    [$24 + 1], $29
	load    [$4 + 2], $30
	fmul    $26, $28, $26
	fmul    $27, $29, $27
	load    [$24 + 2], $24
	fmul    $28, $22, $22
	fmul    $29, $23, $23
	fmul    $30, $24, $28
	fadd    $26, $27, $26
	fmul    $24, $25, $24
	fadd    $22, $23, $22
	fadd    $26, $28, $23
	fadd    $22, $24, $22
	fcmp    $23, $zero
	bg      ble_else.36596
ble_then.36596:
	li      0, $22
.count b_cont
	b       be_cont.36595
ble_else.36596:
	finv    $23, $23
	fneg    $22, $22
	fmul    $22, $23, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36595
be_else.36595:
	load    [$24 + 3], $26
	load    [$24 + 4], $27
	load    [$24 + 4], $28
	load    [$24 + 4], $29
	load    [$4 + 0], $30
	load    [$4 + 1], $31
	load    [$4 + 2], $32
	fmul    $30, $30, $33
	fmul    $31, $31, $34
	load    [$27 + 0], $27
	load    [$28 + 1], $28
	fmul    $32, $32, $35
	fmul    $33, $27, $33
	fmul    $34, $28, $34
	load    [$29 + 2], $29
	load    [$24 + 1], $1
	fmul    $30, $22, $5
	fmul    $35, $29, $35
	fmul    $31, $23, $6
	fadd    $33, $34, $33
	fmul    $32, $25, $34
	fmul    $22, $22, $7
	cmp     $26, 0
	fmul    $5, $27, $5
	fmul    $6, $28, $6
	fadd    $33, $35, $33
	be      bne_cont.36597
bne_then.36597:
	load    [$24 + 9], $8
	fmul    $31, $32, $35
	fmul    $32, $30, $9
	load    [$8 + 0], $8
	load    [$24 + 9], $10
	fmul    $30, $31, $11
	fmul    $35, $8, $35
	load    [$10 + 1], $10
	load    [$24 + 9], $8
	fmul    $9, $10, $9
	fadd    $33, $35, $33
	load    [$8 + 2], $8
	fmul    $11, $8, $35
	fadd    $33, $9, $33
	fadd    $33, $35, $33
bne_cont.36597:
	fcmp    $33, $zero
	bne     be_else.36598
be_then.36598:
	li      0, $22
.count b_cont
	b       be_cont.36598
be_else.36598:
	fadd    $5, $6, $35
	fmul    $34, $29, $34
	fmul    $7, $27, $27
	fmul    $23, $23, $5
	cmp     $26, 0
	fmul    $25, $25, $6
	load    [$24 + 6], $7
	fadd    $35, $34, $34
	bne     be_else.36599
be_then.36599:
	mov     $34, $30
.count b_cont
	b       be_cont.36599
be_else.36599:
	fmul    $32, $23, $35
	fmul    $31, $25, $8
	load    [$24 + 9], $9
	fmul    $30, $25, $10
	fmul    $32, $22, $32
	load    [$9 + 0], $9
	fadd    $35, $8, $35
	load    [$24 + 9], $8
	fmul    $30, $23, $30
	fadd    $10, $32, $32
	fmul    $31, $22, $31
	fmul    $35, $9, $35
	load    [$8 + 1], $8
	load    [$24 + 9], $9
	fmul    $32, $8, $32
	fadd    $30, $31, $30
	load    [$9 + 2], $31
	fadd    $35, $32, $32
	fmul    $30, $31, $30
	fadd    $32, $30, $30
	fmul    $30, $39, $30
	fadd    $34, $30, $30
be_cont.36599:
	fmul    $5, $28, $28
	fmul    $30, $30, $31
	fmul    $6, $29, $29
	fmul    $23, $25, $32
	load    [$24 + 9], $34
	fadd    $27, $28, $27
	fmul    $25, $22, $25
	load    [$34 + 0], $28
	cmp     $26, 0
	load    [$24 + 9], $34
	fmul    $22, $23, $22
	fmul    $32, $28, $23
	fadd    $27, $29, $27
	bne     be_else.36600
be_then.36600:
	mov     $27, $22
.count b_cont
	b       be_cont.36600
be_else.36600:
	load    [$34 + 1], $26
	fadd    $27, $23, $23
	load    [$24 + 9], $24
	fmul    $25, $26, $25
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $25, $23
	fadd    $23, $22, $22
be_cont.36600:
	cmp     $1, 3
	bne     be_cont.36601
be_then.36601:
	fsub    $22, $36, $22
be_cont.36601:
	fmul    $33, $22, $22
	finv    $33, $23
	finv    $33, $24
	fsub    $31, $22, $22
	fcmp    $22, $zero
	bg      ble_else.36602
ble_then.36602:
	li      0, $22
.count b_cont
	b       ble_cont.36602
ble_else.36602:
	cmp     $7, 0
	fsqrt   $22, $22
	bne     be_else.36603
be_then.36603:
	fneg    $22, $22
	fsub    $22, $30, $22
	fmul    $22, $23, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36603
be_else.36603:
	fsub    $22, $30, $22
	fmul    $22, $24, $22
.count move_float
	mov     $22, $42
	li      1, $22
be_cont.36603:
ble_cont.36602:
be_cont.36598:
be_cont.36595:
be_cont.36571:
	cmp     $22, 0
	bne     be_else.36604
be_then.36604:
	load    [min_caml_objects + $21], $1
	add     $2, 1, $2
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     solve_each_element.2871
	ret
be_else.36604:
	fcmp    $42, $zero
	add     $2, 1, $23
	bg      ble_else.36606
ble_then.36606:
.count move_args
	mov     $23, $2
	b       solve_each_element.2871
ble_else.36606:
	fcmp    $49, $42
	bg      ble_else.36607
ble_then.36607:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.36607:
.count load_float
	load    [f.31949], $24
.count stack_move
	sub     $sp, 6, $sp
	fadd    $42, $24, $24
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $2
	load    [$4 + 0], $23
	load    [min_caml_startp + 0], $25
	load    [$4 + 1], $26
	load    [$4 + 2], $28
	load    [min_caml_startp + 1], $27
	load    [min_caml_startp + 2], $29
	fmul    $23, $24, $23
	fmul    $26, $24, $26
	fmul    $28, $24, $28
	fadd    $23, $25, $4
	fadd    $26, $27, $5
	fadd    $28, $29, $6
.count stack_store
	store   $4, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
.count stack_store
	store   $6, [$sp + 5]
	call    check_all_inside.2856
	cmp     $1, 0
.count stack_move
	add     $sp, 6, $sp
	bne     be_else.36608
be_then.36608:
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element.2871
be_else.36608:
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $24, $49
	store   $1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $21, [min_caml_intersected_object_id + 0]
	store   $22, [min_caml_intsec_rectside + 0]
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$3 + $2], $1
	li      0, $5
	cmp     $1, -1
	bne     be_else.36609
be_then.36609:
	ret
be_else.36609:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 2], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36610
be_then.36610:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36610:
.count stack_store
	store   $1, [$sp + 3]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36611
be_then.36611:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36611:
.count stack_store
	store   $1, [$sp + 4]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 4], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36612
be_then.36612:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36612:
.count stack_store
	store   $1, [$sp + 5]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36613
be_then.36613:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36613:
.count stack_store
	store   $1, [$sp + 6]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 6], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36614
be_then.36614:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36614:
.count stack_store
	store   $1, [$sp + 7]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 7], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36615
be_then.36615:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36615:
.count stack_store
	store   $1, [$sp + 8]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 8], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36616
be_then.36616:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36616:
.count stack_store
	store   $1, [$sp + 9]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 9], $3
.count stack_load
	load    [$sp - 10], $4
	add     $1, 1, $2
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$3 + $2], $24
	li      0, $25
	load    [$24 + 0], $26
	load    [$24 + 1], $27
	cmp     $26, -1
	bne     be_else.36617
be_then.36617:
	ret
be_else.36617:
.count stack_move
	sub     $sp, 6, $sp
	cmp     $26, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.36618
be_then.36618:
	cmp     $27, -1
	be      bne_cont.36619
bne_then.36619:
.count stack_store
	store   $24, [$sp + 3]
	load    [min_caml_and_net + $27], $3
.count move_args
	mov     $25, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 2], $24
	cmp     $24, -1
	be      bne_cont.36620
bne_then.36620:
	load    [min_caml_and_net + $24], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 3], $24
	cmp     $24, -1
	be      bne_cont.36621
bne_then.36621:
	load    [min_caml_and_net + $24], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 4], $24
	cmp     $24, -1
	be      bne_cont.36622
bne_then.36622:
	load    [min_caml_and_net + $24], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 5], $24
	cmp     $24, -1
	be      bne_cont.36623
bne_then.36623:
	load    [min_caml_and_net + $24], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 6], $24
	cmp     $24, -1
	be      bne_cont.36624
bne_then.36624:
	load    [min_caml_and_net + $24], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      7, $2
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_one_or_network.2875
bne_cont.36624:
bne_cont.36623:
bne_cont.36622:
bne_cont.36621:
bne_cont.36620:
bne_cont.36619:
.count stack_load
	load    [$sp + 2], $24
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $24, 1, $24
	load    [$3 + $24], $25
	add     $24, 1, $26
	load    [$25 + 0], $27
	load    [$25 + 1], $28
	cmp     $27, -1
	bne     be_else.36625
be_then.36625:
.count stack_move
	add     $sp, 6, $sp
	ret
be_else.36625:
	cmp     $27, 99
	bne     be_else.36626
be_then.36626:
	cmp     $28, -1
	bne     be_else.36627
be_then.36627:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $26, $2
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
be_else.36627:
.count stack_store
	store   $24, [$sp + 4]
.count stack_store
	store   $25, [$sp + 5]
	load    [min_caml_and_net + $28], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 2], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36628
be_then.36628:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix.2879
be_else.36628:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 3], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36629
be_then.36629:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix.2879
be_else.36629:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 4], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36630
be_then.36630:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix.2879
be_else.36630:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element.2871
	li      5, $2
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.36626:
.count stack_load
	load    [$sp + 0], $3
.count move_args
	mov     $27, $2
	call    solver.2773
	cmp     $1, 0
	add     $24, 1, $2
	bne     be_else.36631
be_then.36631:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
be_else.36631:
	fcmp    $49, $42
	li      1, $1
	bg      ble_else.36632
ble_then.36632:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
ble_else.36632:
.count stack_store
	store   $24, [$sp + 4]
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $25, $3
.count move_args
	mov     $1, $2
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.36618:
.count move_args
	mov     $4, $3
.count move_args
	mov     $26, $2
	call    solver.2773
	cmp     $1, 0
	bne     be_else.36633
be_then.36633:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.36633:
.count stack_load
	load    [$sp + 2], $1
	fcmp    $49, $42
	li      1, $3
	add     $1, 1, $2
	bg      ble_else.36634
ble_then.36634:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
ble_else.36634:
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $3, $2
.count move_args
	mov     $24, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$3 + $2], $21
	load    [$4 + 1], $22
	load    [$4 + 0], $23
	cmp     $21, -1
	bne     be_else.36635
be_then.36635:
	ret
be_else.36635:
	load    [min_caml_objects + $21], $24
	load    [$22 + $21], $22
	load    [$23 + 1], $25
	load    [$24 + 1], $27
	load    [$24 + 10], $26
	load    [$24 + 4], $28
	cmp     $27, 1
	load    [$26 + 0], $29
	load    [$26 + 1], $30
	load    [$26 + 2], $31
	bne     be_else.36636
be_then.36636:
	load    [$22 + 0], $27
	load    [$28 + 1], $26
	load    [$22 + 1], $28
	fsub    $27, $29, $27
	load    [$24 + 4], $32
	load    [$23 + 0], $33
	load    [$22 + 2], $34
	load    [$32 + 0], $32
	fmul    $27, $28, $27
	load    [$22 + 3], $35
	fsub    $34, $30, $28
	load    [$24 + 4], $34
	load    [$23 + 2], $1
	fmul    $27, $25, $25
	load    [$24 + 4], $5
	fmul    $28, $35, $28
	load    [$34 + 2], $34
	fmul    $27, $1, $35
	fadd    $25, $30, $25
	load    [$5 + 0], $1
	fmul    $28, $33, $33
	load    [$23 + 0], $5
	fadd    $35, $31, $35
	fabs    $25, $25
	load    [$22 + 4], $6
	fcmp    $26, $25
	fadd    $33, $29, $33
	bg      ble_else.36637
ble_then.36637:
	li      0, $25
.count b_cont
	b       ble_cont.36637
ble_else.36637:
	fabs    $35, $25
	load    [$22 + 1], $26
	fcmp    $34, $25
	bg      ble_else.36638
ble_then.36638:
	li      0, $25
.count b_cont
	b       ble_cont.36638
ble_else.36638:
	fcmp    $26, $zero
	bne     be_else.36639
be_then.36639:
	li      0, $25
.count b_cont
	b       be_cont.36639
be_else.36639:
	li      1, $25
be_cont.36639:
ble_cont.36638:
ble_cont.36637:
	cmp     $25, 0
	bne     be_else.36640
be_then.36640:
	fabs    $33, $25
	fsub    $6, $31, $26
	fcmp    $32, $25
	bg      ble_else.36641
ble_then.36641:
	li      0, $25
.count b_cont
	b       ble_cont.36641
ble_else.36641:
	load    [$23 + 2], $27
	load    [$24 + 4], $25
	load    [$22 + 3], $32
	fmul    $28, $27, $27
	load    [$25 + 2], $25
	fadd    $27, $31, $27
	fabs    $27, $27
	fcmp    $25, $27
	bg      ble_else.36642
ble_then.36642:
	li      0, $25
.count b_cont
	b       ble_cont.36642
ble_else.36642:
	fcmp    $32, $zero
	bne     be_else.36643
be_then.36643:
	li      0, $25
.count b_cont
	b       be_cont.36643
be_else.36643:
	li      1, $25
be_cont.36643:
ble_cont.36642:
ble_cont.36641:
	cmp     $25, 0
	bne     be_else.36644
be_then.36644:
	load    [$22 + 5], $25
	load    [$24 + 4], $24
	load    [$23 + 1], $23
	fmul    $26, $25, $25
	load    [$24 + 1], $24
	load    [$22 + 5], $22
	fmul    $25, $5, $26
	fmul    $25, $23, $23
	fadd    $26, $29, $26
	fadd    $23, $30, $23
	fabs    $26, $26
	fabs    $23, $23
	fcmp    $1, $26
	bg      ble_else.36645
ble_then.36645:
	li      0, $22
.count b_cont
	b       be_cont.36636
ble_else.36645:
	fcmp    $24, $23
	bg      ble_else.36646
ble_then.36646:
	li      0, $22
.count b_cont
	b       be_cont.36636
ble_else.36646:
	fcmp    $22, $zero
	bne     be_else.36647
be_then.36647:
	li      0, $22
.count b_cont
	b       be_cont.36636
be_else.36647:
.count move_float
	mov     $25, $42
	li      3, $22
.count b_cont
	b       be_cont.36636
be_else.36644:
.count move_float
	mov     $28, $42
	li      2, $22
.count b_cont
	b       be_cont.36636
be_else.36640:
.count move_float
	mov     $27, $42
	li      1, $22
.count b_cont
	b       be_cont.36636
be_else.36636:
	cmp     $27, 2
	bne     be_else.36648
be_then.36648:
	load    [$22 + 0], $22
	load    [$26 + 3], $23
	fcmp    $zero, $22
	bg      ble_else.36649
ble_then.36649:
	li      0, $22
.count b_cont
	b       be_cont.36648
ble_else.36649:
	fmul    $22, $23, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36648
be_else.36648:
	load    [$22 + 0], $23
	load    [$22 + 1], $25
	load    [$22 + 2], $27
	fcmp    $23, $zero
	bne     be_else.36650
be_then.36650:
	li      0, $22
.count b_cont
	b       be_cont.36650
be_else.36650:
	fmul    $25, $29, $25
	fmul    $27, $30, $27
	load    [$22 + 3], $28
	load    [$26 + 3], $26
	load    [$24 + 6], $24
	fmul    $28, $31, $28
	fadd    $25, $27, $25
	fmul    $23, $26, $23
	load    [$22 + 4], $26
	load    [$22 + 4], $22
	fadd    $25, $28, $25
	fmul    $25, $25, $27
	fsub    $27, $23, $23
	fcmp    $23, $zero
	bg      ble_else.36651
ble_then.36651:
	li      0, $22
.count b_cont
	b       ble_cont.36651
ble_else.36651:
	cmp     $24, 0
	bne     be_else.36652
be_then.36652:
	fsqrt   $23, $22
	fsub    $25, $22, $22
	fmul    $22, $26, $22
.count move_float
	mov     $22, $42
	li      1, $22
.count b_cont
	b       be_cont.36652
be_else.36652:
	fsqrt   $23, $23
	fadd    $25, $23, $23
	fmul    $23, $22, $22
.count move_float
	mov     $22, $42
	li      1, $22
be_cont.36652:
ble_cont.36651:
be_cont.36650:
be_cont.36648:
be_cont.36636:
	cmp     $22, 0
	bne     be_else.36653
be_then.36653:
	load    [min_caml_objects + $21], $1
	add     $2, 1, $2
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     solve_each_element_fast.2885
	ret
be_else.36653:
	fcmp    $42, $zero
	add     $2, 1, $23
	load    [$4 + 0], $24
	bg      ble_else.36655
ble_then.36655:
.count move_args
	mov     $23, $2
	b       solve_each_element_fast.2885
ble_else.36655:
	fcmp    $49, $42
	add     $2, 1, $23
	li      0, $25
	bg      ble_else.36656
ble_then.36656:
.count move_args
	mov     $23, $2
	b       solve_each_element_fast.2885
ble_else.36656:
.count load_float
	load    [f.31949], $26
.count stack_move
	sub     $sp, 6, $sp
	fadd    $42, $26, $26
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	load    [$24 + 0], $23
	load    [$24 + 1], $27
	load    [$24 + 2], $24
	fmul    $23, $26, $23
	fmul    $27, $26, $27
	fmul    $24, $26, $24
.count move_args
	mov     $25, $2
	fadd    $23, $51, $4
	fadd    $27, $52, $5
	fadd    $24, $53, $6
.count stack_store
	store   $4, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
.count stack_store
	store   $6, [$sp + 5]
	call    check_all_inside.2856
	cmp     $1, 0
.count stack_move
	add     $sp, 6, $sp
	bne     be_else.36657
be_then.36657:
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element_fast.2885
be_else.36657:
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $26, $49
	store   $1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $21, [min_caml_intersected_object_id + 0]
	store   $22, [min_caml_intsec_rectside + 0]
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$3 + $2], $1
	li      0, $5
	cmp     $1, -1
	bne     be_else.36658
be_then.36658:
	ret
be_else.36658:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $5, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36659
be_then.36659:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36659:
.count stack_store
	store   $1, [$sp + 3]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36660
be_then.36660:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36660:
.count stack_store
	store   $1, [$sp + 4]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 4], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36661
be_then.36661:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36661:
.count stack_store
	store   $1, [$sp + 5]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 5], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36662
be_then.36662:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36662:
.count stack_store
	store   $1, [$sp + 6]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 6], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36663
be_then.36663:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36663:
.count stack_store
	store   $1, [$sp + 7]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 7], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36664
be_then.36664:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36664:
.count stack_store
	store   $1, [$sp + 8]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 8], $1
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $4
	cmp     $4, -1
	bne     be_else.36665
be_then.36665:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.36665:
.count stack_store
	store   $1, [$sp + 9]
	load    [min_caml_and_net + $4], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 9], $3
.count stack_load
	load    [$sp - 10], $4
	add     $1, 1, $2
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$3 + $2], $17
	li      0, $18
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	cmp     $19, -1
	bne     be_else.36666
be_then.36666:
	ret
be_else.36666:
.count stack_move
	sub     $sp, 6, $sp
	cmp     $19, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.36667
be_then.36667:
	cmp     $20, -1
	be      bne_cont.36668
bne_then.36668:
.count stack_store
	store   $17, [$sp + 3]
	load    [min_caml_and_net + $20], $3
.count move_args
	mov     $18, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 2], $17
	cmp     $17, -1
	be      bne_cont.36669
bne_then.36669:
	load    [min_caml_and_net + $17], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 3], $17
	cmp     $17, -1
	be      bne_cont.36670
bne_then.36670:
	load    [min_caml_and_net + $17], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 4], $17
	cmp     $17, -1
	be      bne_cont.36671
bne_then.36671:
	load    [min_caml_and_net + $17], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 5], $17
	cmp     $17, -1
	be      bne_cont.36672
bne_then.36672:
	load    [min_caml_and_net + $17], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 3], $3
	li      0, $2
	load    [$3 + 6], $17
	cmp     $17, -1
	be      bne_cont.36673
bne_then.36673:
	load    [min_caml_and_net + $17], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      7, $2
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_one_or_network_fast.2889
bne_cont.36673:
bne_cont.36672:
bne_cont.36671:
bne_cont.36670:
bne_cont.36669:
bne_cont.36668:
.count stack_load
	load    [$sp + 2], $17
	li      0, $2
.count stack_load
	load    [$sp + 1], $3
	add     $17, 1, $17
	load    [$3 + $17], $18
	add     $17, 1, $19
	load    [$18 + 0], $20
	load    [$18 + 1], $21
	cmp     $20, -1
	bne     be_else.36674
be_then.36674:
.count stack_move
	add     $sp, 6, $sp
	ret
be_else.36674:
	cmp     $20, 99
	bne     be_else.36675
be_then.36675:
	cmp     $21, -1
	bne     be_else.36676
be_then.36676:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $19, $2
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix_fast.2893
be_else.36676:
.count stack_store
	store   $17, [$sp + 4]
.count stack_store
	store   $18, [$sp + 5]
	load    [min_caml_and_net + $21], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 2], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36677
be_then.36677:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix_fast.2893
be_else.36677:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 3], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36678
be_then.36678:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix_fast.2893
be_else.36678:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 4], $2
	li      0, $5
	load    [$3 + 4], $1
	add     $2, 1, $4
	cmp     $1, -1
	bne     be_else.36679
be_then.36679:
.count stack_move
	add     $sp, 6, $sp
.count move_args
	mov     $4, $2
.count stack_load
	load    [$sp - 6], $1
.count stack_load
	load    [$sp - 5], $3
.count move_args
	mov     $1, $4
	b       trace_or_matrix_fast.2893
be_else.36679:
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $5, $2
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.36675:
.count stack_load
	load    [$sp + 0], $3
.count move_args
	mov     $20, $2
	call    solver_fast2.2814
	cmp     $1, 0
	add     $17, 1, $2
	bne     be_else.36680
be_then.36680:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix_fast.2893
be_else.36680:
	fcmp    $49, $42
	li      1, $1
	bg      ble_else.36681
ble_then.36681:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix_fast.2893
ble_else.36681:
.count stack_store
	store   $17, [$sp + 4]
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $18, $3
.count move_args
	mov     $1, $2
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.36667:
.count move_args
	mov     $4, $3
.count move_args
	mov     $19, $2
	call    solver_fast2.2814
	cmp     $1, 0
	bne     be_else.36682
be_then.36682:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.36682:
.count stack_load
	load    [$sp + 2], $1
	fcmp    $49, $42
	li      1, $3
	add     $1, 1, $2
	bg      ble_else.36683
ble_then.36683:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix_fast.2893
ble_else.36683:
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $3, $2
.count move_args
	mov     $17, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
.begin utexture
utexture.2908:
	load    [$2 + 8], $10
	load    [$10 + 0], $10
	store   $10, [min_caml_texture_color + 0]
	load    [$2 + 8], $10
	load    [$2 + 5], $11
	load    [$2 + 5], $12
	load    [$10 + 1], $10
.count move_float
	mov     $10, $54
	load    [$2 + 8], $10
	load    [$10 + 2], $10
.count move_float
	mov     $10, $58
	load    [$2 + 0], $10
	cmp     $10, 1
	bne     be_else.36684
be_then.36684:
.count stack_move
	sub     $sp, 2, $sp
	load    [min_caml_intersection_point + 0], $10
	load    [$11 + 0], $11
.count load_float
	load    [f.31961], $13
	fsub    $10, $11, $10
	fmul    $10, $13, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $11
.count load_float
	load    [f.31962], $14
.count load_float
	load    [f.31963], $15
	load    [min_caml_intersection_point + 2], $16
	load    [$12 + 2], $12
	fmul    $11, $14, $11
	fsub    $16, $12, $12
	fsub    $10, $11, $10
	fmul    $12, $13, $2
	call    min_caml_floor
	fmul    $1, $14, $1
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.31957], $2
	fcmp    $15, $10
.count load_float
	load    [f.31957], $3
	fsub    $12, $1, $1
	bg      ble_else.36685
ble_then.36685:
	li      0, $4
.count b_cont
	b       ble_cont.36685
ble_else.36685:
	li      1, $4
ble_cont.36685:
	fcmp    $15, $1
	bg      ble_else.36686
ble_then.36686:
	cmp     $4, 0
	bne     be_else.36687
be_then.36687:
.count move_float
	mov     $2, $54
	ret
be_else.36687:
.count move_float
	mov     $zero, $54
	ret
ble_else.36686:
	cmp     $4, 0
	bne     be_else.36688
be_then.36688:
.count move_float
	mov     $zero, $54
	ret
be_else.36688:
.count move_float
	mov     $3, $54
	ret
be_else.36684:
	cmp     $10, 2
	bne     be_else.36689
be_then.36689:
.count stack_move
	sub     $sp, 2, $sp
	load    [min_caml_intersection_point + 1], $11
.count load_float
	load    [f.31960], $12
	fmul    $11, $12, $2
	call    min_caml_sin
	fmul    $1, $1, $1
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.31957], $2
	fmul    $2, $1, $3
	fsub    $36, $1, $1
	store   $3, [min_caml_texture_color + 0]
	fmul    $2, $1, $1
.count move_float
	mov     $1, $54
	ret
be_else.36689:
	cmp     $10, 3
	bne     be_else.36690
be_then.36690:
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 5], $10
	load    [$2 + 5], $11
	load    [min_caml_intersection_point + 0], $12
	load    [$10 + 0], $10
	load    [min_caml_intersection_point + 2], $13
	load    [$11 + 2], $11
	fsub    $12, $10, $10
.count load_float
	load    [f.31959], $12
	fsub    $13, $11, $11
	fmul    $10, $10, $10
	fmul    $11, $11, $11
	fadd    $10, $11, $10
	fsqrt   $10, $10
	fmul    $10, $12, $2
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $12
.count move_ret
	mov     $1, $11
	fsub    $12, $11, $11
.count load_float
	load    [f.31954], $12
	fmul    $11, $12, $2
	call    min_caml_cos
	fmul    $1, $1, $1
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.31957], $2
	fmul    $1, $2, $3
	fsub    $36, $1, $1
.count move_float
	mov     $3, $54
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
be_else.36690:
	cmp     $10, 4
	bne     be_else.36691
be_then.36691:
.count stack_move
	sub     $sp, 2, $sp
.count load_float
	load    [f.31951], $15
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 5], $11
	load    [$2 + 4], $12
	load    [$2 + 5], $13
	load    [$2 + 4], $14
	load    [min_caml_intersection_point + 0], $16
	load    [$11 + 0], $11
	load    [$12 + 0], $12
	load    [min_caml_intersection_point + 2], $17
	fsub    $16, $11, $11
	fsqrt   $12, $12
	load    [$13 + 2], $13
	load    [$14 + 2], $14
	fsub    $17, $13, $13
	fmul    $11, $12, $11
	fsqrt   $14, $12
	fabs    $11, $14
	fmul    $13, $12, $12
	fcmp    $15, $14
	bg      ble_else.36692
ble_then.36692:
	finv    $11, $13
	fmul    $12, $13, $13
	fabs    $13, $2
	call    min_caml_atan
.count load_float
	load    [f.31953], $14
.count move_ret
	mov     $1, $13
.count load_float
	load    [f.31954], $16
	fmul    $13, $14, $13
.count load_float
	load    [f.31955], $16
	fmul    $13, $16, $13
.count b_cont
	b       ble_cont.36692
ble_else.36692:
.count load_float
	load    [f.31952], $13
ble_cont.36692:
.count stack_load
	load    [$sp + 1], $14
	fmul    $11, $11, $11
	fmul    $12, $12, $12
	load    [$14 + 5], $16
	load    [$14 + 4], $14
	load    [min_caml_intersection_point + 1], $17
	load    [$16 + 1], $16
	fadd    $11, $12, $11
	load    [$14 + 1], $14
	fsub    $17, $16, $12
	fsqrt   $14, $14
	fabs    $11, $16
	finv    $11, $11
	fcmp    $15, $16
	fmul    $12, $14, $12
	bg      ble_else.36693
ble_then.36693:
	fmul    $12, $11, $11
	fabs    $11, $2
	call    min_caml_atan
.count load_float
	load    [f.31953], $11
.count move_ret
	mov     $1, $10
.count load_float
	load    [f.31954], $12
	fmul    $10, $11, $10
.count load_float
	load    [f.31955], $12
	fmul    $10, $12, $10
.count b_cont
	b       ble_cont.36693
ble_else.36693:
.count load_float
	load    [f.31952], $10
ble_cont.36693:
.count load_float
	load    [f.31956], $11
.count move_args
	mov     $13, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $12
	fsub    $13, $12, $12
.count move_args
	mov     $10, $2
	fsub    $39, $12, $12
	fmul    $12, $12, $12
	fsub    $11, $12, $11
	call    min_caml_floor
	fsub    $10, $1, $1
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.31957], $2
.count load_float
	load    [f.31958], $3
	fsub    $39, $1, $1
	fmul    $1, $1, $1
	fsub    $11, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36694
ble_then.36694:
	fmul    $2, $1, $1
	fmul    $1, $3, $1
.count move_float
	mov     $1, $58
	ret
ble_else.36694:
.count move_float
	mov     $zero, $58
	ret
be_else.36691:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2915:
	cmp     $2, 0
	bl      bge_else.36695
bge_then.36695:
.count stack_move
	sub     $sp, 7, $sp
.count load_float
	load    [f.31964], $18
.count stack_store
	store   $5, [$sp + 0]
.count stack_store
	store   $4, [$sp + 1]
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
	load    [min_caml_reflections + $2], $17
.count move_float
	mov     $18, $49
	li      1, $2
.count stack_store
	store   $17, [$sp + 4]
	load    [$17 + 1], $4
	li      0, $17
.count stack_store
	store   $4, [$sp + 5]
	load    [$59 + 0], $3
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	cmp     $18, -1
	be      bne_cont.36696
bne_then.36696:
	cmp     $18, 99
	bne     be_else.36697
be_then.36697:
	cmp     $19, -1
	bne     be_else.36698
be_then.36698:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36697
be_else.36698:
.count stack_store
	store   $3, [$sp + 6]
	load    [min_caml_and_net + $19], $3
.count move_args
	mov     $17, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 6], $3
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.36699
be_then.36699:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36697
be_else.36699:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 6], $3
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
	load    [$3 + 3], $1
	cmp     $1, -1
	bne     be_else.36700
be_then.36700:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36697
be_else.36700:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 6], $3
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
	load    [$3 + 4], $1
	cmp     $1, -1
	bne     be_else.36701
be_then.36701:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36697
be_else.36701:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 6], $3
.count stack_load
	load    [$sp + 5], $4
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36697
be_else.36697:
.count stack_store
	store   $3, [$sp + 6]
.count move_args
	mov     $4, $3
.count move_args
	mov     $18, $2
	call    solver_fast2.2814
	cmp     $1, 0
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
	bne     be_else.36702
be_then.36702:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36702
be_else.36702:
	fcmp    $49, $42
	bg      ble_else.36703
ble_then.36703:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36703
ble_else.36703:
	li      1, $2
.count stack_load
	load    [$sp + 6], $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 5], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.36703:
be_cont.36702:
be_cont.36697:
bne_cont.36696:
.count load_float
	load    [f.31950], $1
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 4], $4
	fcmp    $49, $1
	sub     $2, 1, $3
	load    [$4 + 0], $5
	bg      ble_else.36704
ble_then.36704:
	li      0, $1
.count b_cont
	b       ble_cont.36704
ble_else.36704:
.count load_float
	load    [f.31965], $1
	fcmp    $1, $49
	bg      ble_else.36705
ble_then.36705:
	li      0, $1
.count b_cont
	b       ble_cont.36705
ble_else.36705:
	li      1, $1
ble_cont.36705:
ble_cont.36704:
	cmp     $1, 0
	bne     be_else.36706
be_then.36706:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $3, $2
.count stack_load
	load    [$sp - 5], $1
.count stack_load
	load    [$sp - 6], $4
.count stack_load
	load    [$sp - 7], $5
.count move_args
	mov     $1, $3
	b       trace_reflections.2915
be_else.36706:
	load    [min_caml_intersected_object_id + 0], $1
	load    [min_caml_intsec_rectside + 0], $3
	li      0, $6
	sll     $1, 2, $1
	add     $1, $3, $1
	sub     $2, 1, $3
	cmp     $1, $5
	bne     be_else.36707
be_then.36707:
.count move_args
	mov     $59, $3
.count move_args
	mov     $6, $2
	call    shadow_check_one_or_matrix.2868
	cmp     $1, 0
.count stack_move
	add     $sp, 7, $sp
	bne     be_else.36708
be_then.36708:
.count stack_load
	load    [$sp - 2], $2
.count stack_load
	load    [$sp - 3], $1
	load    [min_caml_nvector + 0], $3
	load    [$2 + 0], $2
	load    [$1 + 2], $1
.count stack_load
	load    [$sp - 5], $4
	load    [$2 + 0], $6
	load    [min_caml_nvector + 1], $7
	load    [$2 + 1], $8
	fmul    $1, $4, $5
	fmul    $3, $6, $3
	fmul    $7, $8, $7
	load    [min_caml_nvector + 2], $9
	load    [$2 + 2], $2
	load    [min_caml_texture_color + 0], $10
	fmul    $9, $2, $9
	fadd    $3, $7, $3
	fadd    $3, $9, $3
	fmul    $5, $3, $3
	fcmp    $3, $zero
	ble     bg_cont.36709
bg_then.36709:
	fmul    $3, $10, $5
	fadd    $46, $5, $5
.count move_float
	mov     $5, $46
	fmul    $3, $54, $5
	fmul    $3, $58, $3
	fadd    $47, $5, $5
	fadd    $48, $3, $3
.count move_float
	mov     $5, $47
.count move_float
	mov     $3, $48
bg_cont.36709:
.count stack_load
	load    [$sp - 7], $5
	load    [$5 + 0], $3
	load    [$5 + 1], $7
	load    [$5 + 2], $9
	fmul    $3, $6, $3
	fmul    $7, $8, $6
	fmul    $9, $2, $2
.count stack_load
	load    [$sp - 4], $7
	fadd    $3, $6, $3
	sub     $7, 1, $8
	fadd    $3, $2, $2
	fmul    $1, $2, $1
	fcmp    $1, $zero
	bg      ble_else.36710
ble_then.36710:
.count stack_load
	load    [$sp - 6], $1
.count move_args
	mov     $4, $3
.count move_args
	mov     $8, $2
.count move_args
	mov     $1, $4
	b       trace_reflections.2915
ble_else.36710:
	fmul    $1, $1, $1
.count stack_load
	load    [$sp - 6], $2
.count move_args
	mov     $4, $tmp
.count move_args
	mov     $2, $4
	fmul    $1, $1, $1
	fmul    $1, $2, $1
	fadd    $46, $1, $3
.count move_float
	mov     $3, $46
	fadd    $47, $1, $3
	fadd    $48, $1, $1
.count move_float
	mov     $3, $47
	sub     $7, 1, $3
.count move_float
	mov     $1, $48
.count move_args
	mov     $3, $2
.count move_args
	mov     $tmp, $3
	b       trace_reflections.2915
be_else.36708:
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 7], $5
	b       trace_reflections.2915
be_else.36707:
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $3, $2
.count stack_load
	load    [$sp - 5], $1
.count stack_load
	load    [$sp - 6], $4
.count stack_load
	load    [$sp - 7], $5
.count move_args
	mov     $1, $3
	b       trace_reflections.2915
bge_else.36695:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2920:
	cmp     $2, 4
	bg      ble_else.36711
ble_then.36711:
.count stack_move
	sub     $sp, 10, $sp
.count load_float
	load    [f.31964], $24
.count stack_store
	store   $6, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
	load    [$59 + 0], $3
.count move_float
	mov     $24, $49
	li      1, $2
	load    [$3 + 0], $25
	li      0, $24
	load    [$3 + 1], $26
	cmp     $25, -1
	be      bne_cont.36712
bne_then.36712:
	cmp     $25, 99
	bne     be_else.36713
be_then.36713:
	cmp     $26, -1
	bne     be_else.36714
be_then.36714:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36713
be_else.36714:
.count stack_store
	store   $3, [$sp + 5]
	load    [min_caml_and_net + $26], $3
.count move_args
	mov     $24, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 2], $18
	cmp     $18, -1
	bne     be_else.36715
be_then.36715:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36713
be_else.36715:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 3], $18
	cmp     $18, -1
	bne     be_else.36716
be_then.36716:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36713
be_else.36716:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 4], $18
	cmp     $18, -1
	bne     be_else.36717
be_then.36717:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36713
be_else.36717:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
	li      5, $2
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 2], $4
	call    solve_one_or_network.2875
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36713
be_else.36713:
.count stack_store
	store   $3, [$sp + 5]
.count move_args
	mov     $4, $3
.count move_args
	mov     $25, $2
	call    solver.2773
.count move_ret
	mov     $1, $18
	cmp     $18, 0
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
	bne     be_else.36718
be_then.36718:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.36718
be_else.36718:
	fcmp    $49, $42
	bg      ble_else.36719
ble_then.36719:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.36719
ble_else.36719:
	li      1, $2
.count stack_load
	load    [$sp + 5], $3
	call    solve_one_or_network.2875
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
ble_cont.36719:
be_cont.36718:
be_cont.36713:
bne_cont.36712:
.count load_float
	load    [f.31950], $20
.count stack_load
	load    [$sp + 4], $18
	add     $zero, -1, $21
	fcmp    $49, $20
	load    [$18 + 2], $19
	load    [min_caml_intersected_object_id + 0], $22
	bg      ble_else.36720
ble_then.36720:
	li      0, $23
.count b_cont
	b       ble_cont.36720
ble_else.36720:
.count load_float
	load    [f.31965], $23
	fcmp    $23, $49
	bg      ble_else.36721
ble_then.36721:
	li      0, $23
.count b_cont
	b       ble_cont.36721
ble_else.36721:
	li      1, $23
ble_cont.36721:
ble_cont.36720:
	cmp     $23, 0
	bne     be_else.36722
be_then.36722:
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 7], $1
.count storer
	add     $19, $1, $tmp
	cmp     $1, 0
	store   $21, [$tmp + 0]
	bne     be_else.36723
be_then.36723:
	ret
be_else.36723:
.count stack_load
	load    [$sp - 8], $1
	load    [min_caml_beam + 0], $4
	load    [$1 + 0], $2
	load    [$1 + 1], $3
	load    [$1 + 2], $1
	fmul    $2, $55, $2
	fmul    $3, $56, $3
	fmul    $1, $57, $1
	fadd    $2, $3, $2
	fadd    $2, $1, $1
	fneg    $1, $1
	fcmp    $1, $zero
	bg      ble_else.36724
ble_then.36724:
	ret
ble_else.36724:
	fmul    $1, $1, $2
	fmul    $2, $1, $1
.count stack_load
	load    [$sp - 9], $2
	fmul    $1, $2, $1
	fmul    $1, $4, $1
	fadd    $46, $1, $2
.count move_float
	mov     $2, $46
	fadd    $47, $1, $2
	fadd    $48, $1, $1
.count move_float
	mov     $2, $47
.count move_float
	mov     $1, $48
	ret
be_else.36722:
.count stack_store
	store   $19, [$sp + 6]
	load    [min_caml_objects + $22], $2
.count stack_store
	store   $2, [$sp + 7]
	load    [$2 + 1], $24
	load    [min_caml_intersection_point + 0], $21
	load    [min_caml_intersection_point + 1], $23
	cmp     $24, 1
	load    [$2 + 4], $25
	load    [$2 + 3], $26
	bne     be_else.36725
be_then.36725:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $21
.count stack_load
	load    [$sp + 2], $23
	sub     $21, 1, $21
	load    [$23 + $21], $23
	fcmp    $23, $zero
	bne     be_else.36726
be_then.36726:
	store   $zero, [min_caml_nvector + $21]
.count b_cont
	b       be_cont.36725
be_else.36726:
	fcmp    $23, $zero
	bg      ble_else.36727
ble_then.36727:
	store   $36, [min_caml_nvector + $21]
.count b_cont
	b       be_cont.36725
ble_else.36727:
	store   $40, [min_caml_nvector + $21]
.count b_cont
	b       be_cont.36725
be_else.36725:
	cmp     $24, 2
	bne     be_else.36728
be_then.36728:
	load    [$25 + 0], $21
	fneg    $21, $21
	store   $21, [min_caml_nvector + 0]
	load    [$2 + 4], $21
	load    [$21 + 1], $21
	fneg    $21, $21
	store   $21, [min_caml_nvector + 1]
	load    [$2 + 4], $21
	load    [$21 + 2], $21
	fneg    $21, $21
	store   $21, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36728
be_else.36728:
	load    [$2 + 5], $25
	load    [$2 + 4], $24
	load    [$2 + 4], $27
	load    [$25 + 0], $25
	load    [$24 + 0], $24
	load    [$27 + 1], $27
	load    [$2 + 5], $28
	fsub    $21, $25, $21
	load    [$2 + 5], $25
	load    [$28 + 1], $28
	load    [$2 + 4], $29
	load    [min_caml_intersection_point + 2], $30
	load    [$25 + 2], $25
	fmul    $21, $24, $24
	fsub    $23, $28, $23
	fsub    $30, $25, $25
	load    [$29 + 2], $28
	load    [$2 + 9], $29
	cmp     $26, 0
	fmul    $23, $27, $27
	load    [$29 + 2], $29
	load    [$2 + 9], $30
	fmul    $25, $28, $28
	bne     be_else.36729
be_then.36729:
	store   $24, [min_caml_nvector + 0]
	store   $27, [min_caml_nvector + 1]
	store   $28, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36729
be_else.36729:
	fmul    $23, $29, $26
	load    [$30 + 1], $29
	fmul    $25, $29, $29
	fadd    $26, $29, $26
	fmul    $26, $39, $26
	fadd    $24, $26, $24
	store   $24, [min_caml_nvector + 0]
	load    [$2 + 9], $24
	load    [$2 + 9], $26
	load    [$24 + 2], $24
	load    [$26 + 0], $26
	fmul    $21, $24, $24
	fmul    $25, $26, $25
	fadd    $24, $25, $24
	fmul    $24, $39, $24
	fadd    $27, $24, $24
	store   $24, [min_caml_nvector + 1]
	load    [$2 + 9], $24
	load    [$2 + 9], $25
	load    [$24 + 1], $24
	load    [$25 + 0], $25
	fmul    $21, $24, $21
	fmul    $23, $25, $23
	fadd    $21, $23, $21
	fmul    $21, $39, $21
	fadd    $28, $21, $21
	store   $21, [min_caml_nvector + 2]
be_cont.36729:
	load    [min_caml_nvector + 0], $21
	load    [min_caml_nvector + 1], $24
	load    [$2 + 6], $23
	fmul    $21, $21, $25
	fmul    $24, $24, $24
	load    [min_caml_nvector + 2], $26
	fmul    $26, $26, $26
	fadd    $25, $24, $24
	fadd    $24, $26, $24
	fsqrt   $24, $24
	fcmp    $24, $zero
	bne     be_else.36730
be_then.36730:
	mov     $36, $23
.count b_cont
	b       be_cont.36730
be_else.36730:
	cmp     $23, 0
	finv    $24, $23
	be      bne_cont.36731
bne_then.36731:
	fneg    $23, $23
bne_cont.36731:
be_cont.36730:
	fmul    $21, $23, $21
	store   $21, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $21
	fmul    $21, $23, $21
	store   $21, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $21
	fmul    $21, $23, $21
	store   $21, [min_caml_nvector + 2]
be_cont.36728:
be_cont.36725:
	load    [min_caml_intersection_point + 0], $21
	store   $21, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $21
	store   $21, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $21
	store   $21, [min_caml_startp + 2]
	call    utexture.2908
	sll     $22, 2, $17
	load    [min_caml_intsec_rectside + 0], $21
	li      1, $22
	li      0, $23
	add     $17, $21, $17
.count stack_load
	load    [$sp + 3], $21
.count storer
	add     $19, $21, $tmp
	store   $17, [$tmp + 0]
	load    [$18 + 1], $17
	load    [min_caml_intersection_point + 0], $19
	load    [$17 + $21], $17
	store   $19, [$17 + 0]
	load    [min_caml_intersection_point + 1], $19
	store   $19, [$17 + 1]
	load    [min_caml_intersection_point + 2], $19
	store   $19, [$17 + 2]
.count stack_load
	load    [$sp + 7], $17
	load    [$18 + 3], $19
.count stack_load
	load    [$sp + 1], $24
	load    [$17 + 7], $17
.count storer
	add     $19, $21, $tmp
	load    [$17 + 0], $17
	fmul    $17, $24, $24
	fcmp    $39, $17
.count stack_store
	store   $24, [$sp + 8]
	bg      ble_else.36732
ble_then.36732:
	store   $22, [$tmp + 0]
	load    [$18 + 4], $17
	load    [min_caml_texture_color + 0], $19
	load    [$17 + $21], $22
	store   $19, [$22 + 0]
	store   $54, [$22 + 1]
	store   $58, [$22 + 2]
	load    [$17 + $21], $17
.count load_float
	load    [f.31966], $19
	load    [$17 + 0], $22
.count load_float
	load    [f.31967], $19
	fmul    $19, $24, $19
	fmul    $22, $19, $22
	store   $22, [$17 + 0]
	load    [$17 + 1], $22
	fmul    $22, $19, $22
	store   $22, [$17 + 1]
	load    [$17 + 2], $22
	fmul    $22, $19, $19
	store   $19, [$17 + 2]
	load    [$18 + 7], $17
	load    [min_caml_nvector + 0], $18
	load    [$17 + $21], $17
	store   $18, [$17 + 0]
	load    [min_caml_nvector + 1], $18
	store   $18, [$17 + 1]
	load    [min_caml_nvector + 2], $18
	store   $18, [$17 + 2]
.count b_cont
	b       ble_cont.36732
ble_else.36732:
	store   $23, [$tmp + 0]
ble_cont.36732:
.count stack_load
	load    [$sp + 2], $19
	load    [min_caml_nvector + 0], $17
.count load_float
	load    [f.31968], $18
	load    [$19 + 0], $21
	load    [$19 + 1], $22
	load    [min_caml_nvector + 1], $23
	fmul    $21, $17, $24
	load    [$19 + 2], $25
	fmul    $22, $23, $22
	load    [min_caml_nvector + 2], $23
	fmul    $25, $23, $23
	fadd    $24, $22, $22
	fadd    $22, $23, $22
	fmul    $18, $22, $18
	fmul    $18, $17, $17
	fadd    $21, $17, $17
	store   $17, [$19 + 0]
	load    [min_caml_nvector + 1], $21
	load    [$19 + 1], $17
	fmul    $18, $21, $21
	fadd    $17, $21, $17
	store   $17, [$19 + 1]
	load    [min_caml_nvector + 2], $21
	load    [$19 + 2], $17
	fmul    $18, $21, $18
	fadd    $17, $18, $17
	store   $17, [$19 + 2]
	load    [$59 + 0], $17
	load    [$17 + 0], $2
	cmp     $2, -1
	bne     be_else.36733
be_then.36733:
	li      0, $16
.count b_cont
	b       be_cont.36733
be_else.36733:
	cmp     $2, 99
.count stack_store
	store   $17, [$sp + 9]
	bne     be_else.36734
be_then.36734:
	li      1, $16
.count b_cont
	b       be_cont.36734
be_else.36734:
	call    solver_fast.2796
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36735
be_then.36735:
	li      0, $16
.count b_cont
	b       be_cont.36735
be_else.36735:
	fcmp    $20, $42
	load    [$17 + 1], $16
	li      0, $2
	bg      ble_else.36736
ble_then.36736:
	li      0, $16
.count b_cont
	b       ble_cont.36736
ble_else.36736:
	cmp     $16, -1
	bne     be_else.36737
be_then.36737:
	li      0, $16
.count b_cont
	b       be_cont.36737
be_else.36737:
	load    [min_caml_and_net + $16], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36738
be_then.36738:
.count stack_load
	load    [$sp + 9], $3
	li      0, $2
	load    [$3 + 2], $16
	cmp     $16, -1
	bne     be_else.36739
be_then.36739:
	li      0, $16
.count b_cont
	b       be_cont.36738
be_else.36739:
	load    [min_caml_and_net + $16], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36740
be_then.36740:
	li      3, $2
.count stack_load
	load    [$sp + 9], $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36741
be_then.36741:
	li      0, $16
.count b_cont
	b       be_cont.36738
be_else.36741:
	li      1, $16
.count b_cont
	b       be_cont.36738
be_else.36740:
	li      1, $16
.count b_cont
	b       be_cont.36738
be_else.36738:
	li      1, $16
be_cont.36738:
be_cont.36737:
ble_cont.36736:
be_cont.36735:
be_cont.36734:
	cmp     $16, 0
	li      1, $2
	bne     be_else.36742
be_then.36742:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.36742
be_else.36742:
.count stack_load
	load    [$sp + 9], $3
	li      0, $17
	load    [$3 + 1], $16
	cmp     $16, -1
	bne     be_else.36743
be_then.36743:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.36743
be_else.36743:
	load    [min_caml_and_net + $16], $3
.count move_args
	mov     $17, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36744
be_then.36744:
.count stack_load
	load    [$sp + 9], $3
	li      1, $2
	li      0, $17
	load    [$3 + 2], $16
	cmp     $16, -1
	bne     be_else.36745
be_then.36745:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.36744
be_else.36745:
	load    [min_caml_and_net + $16], $3
.count move_args
	mov     $17, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36746
be_then.36746:
	li      3, $2
.count stack_load
	load    [$sp + 9], $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.36747
be_then.36747:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.36744
be_else.36747:
	li      1, $16
.count b_cont
	b       be_cont.36744
be_else.36746:
	li      1, $16
.count b_cont
	b       be_cont.36744
be_else.36744:
	li      1, $16
be_cont.36744:
be_cont.36743:
be_cont.36742:
be_cont.36733:
.count stack_load
	load    [$sp + 7], $17
	load    [min_caml_nvector + 0], $18
	load    [min_caml_nvector + 1], $19
	load    [$17 + 7], $17
	fmul    $18, $55, $18
.count stack_load
	load    [$sp + 1], $20
	load    [$17 + 1], $17
	cmp     $16, 0
	fmul    $20, $17, $17
	bne     be_cont.36748
be_then.36748:
	fmul    $19, $56, $19
	load    [min_caml_nvector + 2], $16
.count stack_load
	load    [$sp + 2], $20
	fmul    $16, $57, $16
	fadd    $18, $19, $18
	load    [$20 + 0], $21
	load    [$20 + 1], $22
	load    [$20 + 2], $20
	fmul    $21, $55, $21
	fmul    $22, $56, $19
	fadd    $18, $16, $16
	load    [min_caml_texture_color + 0], $22
	fadd    $21, $19, $18
	fmul    $20, $57, $19
.count stack_load
	load    [$sp + 8], $20
	fneg    $16, $16
	fmul    $16, $20, $16
	fadd    $18, $19, $18
	fcmp    $16, $zero
	fmul    $16, $22, $19
	fneg    $18, $18
	ble     bg_cont.36749
bg_then.36749:
	fadd    $46, $19, $19
.count move_float
	mov     $19, $46
	fmul    $16, $54, $19
	fmul    $16, $58, $16
	fadd    $47, $19, $19
	fadd    $48, $16, $16
.count move_float
	mov     $19, $47
.count move_float
	mov     $16, $48
bg_cont.36749:
	fcmp    $18, $zero
	ble     bg_cont.36750
bg_then.36750:
	fmul    $18, $18, $16
	fmul    $16, $16, $16
	fmul    $16, $17, $16
	fadd    $46, $16, $18
.count move_float
	mov     $18, $46
	fadd    $47, $16, $18
	fadd    $48, $16, $16
.count move_float
	mov     $18, $47
.count move_float
	mov     $16, $48
bg_cont.36750:
be_cont.36748:
	li      min_caml_intersection_point, $2
	load    [min_caml_intersection_point + 0], $16
	sub     $41, 1, $3
.count move_float
	mov     $16, $51
	load    [min_caml_intersection_point + 1], $16
.count move_float
	mov     $16, $52
	load    [min_caml_intersection_point + 2], $16
.count move_float
	mov     $16, $53
	call    setup_startp_constants.2831
	load    [min_caml_n_reflections + 0], $1
.count stack_load
	load    [$sp + 8], $3
.count stack_load
	load    [$sp + 2], $5
	sub     $1, 1, $2
.count move_args
	mov     $17, $4
	call    trace_reflections.2915
.count stack_move
	add     $sp, 10, $sp
.count load_float
	load    [f.31959], $1
.count stack_load
	load    [$sp - 9], $5
.count stack_load
	load    [$sp - 7], $2
	add     $zero, -1, $4
	fcmp    $5, $1
	add     $2, 1, $3
	bg      ble_else.36751
ble_then.36751:
	ret
ble_else.36751:
	cmp     $2, 4
	bge     bl_cont.36752
bl_then.36752:
.count stack_load
	load    [$sp - 4], $1
.count storer
	add     $1, $3, $tmp
	store   $4, [$tmp + 0]
bl_cont.36752:
.count stack_load
	load    [$sp - 3], $1
	load    [$1 + 2], $3
	load    [$1 + 7], $1
	cmp     $3, 2
	bne     be_else.36753
be_then.36753:
	load    [$1 + 0], $1
.count stack_load
	load    [$sp - 10], $3
	add     $2, 1, $2
	fsub    $36, $1, $1
	fadd    $3, $49, $6
.count stack_load
	load    [$sp - 8], $4
	fmul    $5, $1, $3
.count stack_load
	load    [$sp - 6], $5
	b       trace_ray.2920
be_else.36753:
	ret
ble_else.36711:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 5, $sp
.count load_float
	load    [f.31964], $17
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	load    [$59 + 0], $3
.count move_float
	mov     $17, $49
	li      1, $17
	load    [$3 + 0], $19
	li      0, $18
	load    [$3 + 1], $20
	cmp     $19, -1
	be      bne_cont.36754
bne_then.36754:
	cmp     $19, 99
	bne     be_else.36755
be_then.36755:
	cmp     $20, -1
.count move_args
	mov     $2, $4
	bne     be_else.36756
be_then.36756:
.count move_args
	mov     $59, $3
.count move_args
	mov     $17, $2
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36755
be_else.36756:
.count stack_store
	store   $3, [$sp + 2]
	load    [min_caml_and_net + $20], $3
.count move_args
	mov     $18, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $3
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
	load    [$3 + 2], $18
	cmp     $18, -1
	bne     be_else.36757
be_then.36757:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36755
be_else.36757:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $3
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
	load    [$3 + 3], $18
	cmp     $18, -1
	bne     be_else.36758
be_then.36758:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36755
be_else.36758:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $3
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
	load    [$3 + 4], $18
	cmp     $18, -1
	bne     be_else.36759
be_then.36759:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36755
be_else.36759:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 2], $3
.count stack_load
	load    [$sp + 1], $4
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36755
be_else.36755:
.count stack_store
	store   $3, [$sp + 2]
.count move_args
	mov     $2, $3
.count move_args
	mov     $19, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $18
	cmp     $18, 0
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
	bne     be_else.36760
be_then.36760:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.36760
be_else.36760:
	fcmp    $49, $42
	bg      ble_else.36761
ble_then.36761:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.36761
ble_else.36761:
	li      1, $2
.count stack_load
	load    [$sp + 2], $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.36761:
be_cont.36760:
be_cont.36755:
bne_cont.36754:
.count load_float
	load    [f.31950], $18
.count stack_load
	load    [$sp + 1], $19
	load    [min_caml_intersected_object_id + 0], $20
	fcmp    $49, $18
	load    [$19 + 0], $19
	bg      ble_else.36762
ble_then.36762:
	li      0, $21
.count b_cont
	b       ble_cont.36762
ble_else.36762:
.count load_float
	load    [f.31965], $21
	fcmp    $21, $49
	bg      ble_else.36763
ble_then.36763:
	li      0, $21
.count b_cont
	b       ble_cont.36763
ble_else.36763:
	li      1, $21
ble_cont.36763:
ble_cont.36762:
	cmp     $21, 0
	bne     be_else.36764
be_then.36764:
.count stack_move
	add     $sp, 5, $sp
	ret
be_else.36764:
	load    [min_caml_objects + $20], $2
.count stack_store
	store   $2, [$sp + 3]
	load    [$2 + 1], $22
	load    [min_caml_intersection_point + 0], $20
	load    [min_caml_intersection_point + 1], $21
	cmp     $22, 1
	load    [$2 + 4], $23
	load    [$2 + 3], $24
	bne     be_else.36765
be_then.36765:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $20
	sub     $20, 1, $20
	load    [$19 + $20], $19
	fcmp    $19, $zero
	bne     be_else.36766
be_then.36766:
	store   $zero, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.36765
be_else.36766:
	fcmp    $19, $zero
	bg      ble_else.36767
ble_then.36767:
	store   $36, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.36765
ble_else.36767:
	store   $40, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.36765
be_else.36765:
	cmp     $22, 2
	bne     be_else.36768
be_then.36768:
	load    [$23 + 0], $19
	fneg    $19, $19
	store   $19, [min_caml_nvector + 0]
	load    [$2 + 4], $19
	load    [$19 + 1], $19
	fneg    $19, $19
	store   $19, [min_caml_nvector + 1]
	load    [$2 + 4], $19
	load    [$19 + 2], $19
	fneg    $19, $19
	store   $19, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36768
be_else.36768:
	load    [$2 + 5], $22
	load    [$2 + 4], $19
	load    [$2 + 4], $23
	load    [$22 + 0], $22
	load    [$19 + 0], $19
	load    [$23 + 1], $23
	load    [$2 + 5], $25
	fsub    $20, $22, $20
	load    [$2 + 5], $22
	load    [$25 + 1], $25
	load    [$2 + 4], $26
	load    [min_caml_intersection_point + 2], $27
	load    [$22 + 2], $22
	fmul    $20, $19, $19
	fsub    $21, $25, $21
	fsub    $27, $22, $22
	load    [$26 + 2], $25
	load    [$2 + 9], $26
	cmp     $24, 0
	fmul    $21, $23, $23
	load    [$26 + 2], $26
	load    [$2 + 9], $27
	fmul    $22, $25, $25
	bne     be_else.36769
be_then.36769:
	store   $19, [min_caml_nvector + 0]
	store   $23, [min_caml_nvector + 1]
	store   $25, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.36769
be_else.36769:
	fmul    $21, $26, $24
	load    [$27 + 1], $26
	fmul    $22, $26, $26
	fadd    $24, $26, $24
	fmul    $24, $39, $24
	fadd    $19, $24, $19
	store   $19, [min_caml_nvector + 0]
	load    [$2 + 9], $19
	load    [$2 + 9], $24
	load    [$19 + 2], $19
	load    [$24 + 0], $24
	fmul    $20, $19, $19
	fmul    $22, $24, $22
	fadd    $19, $22, $19
	fmul    $19, $39, $19
	fadd    $23, $19, $19
	store   $19, [min_caml_nvector + 1]
	load    [$2 + 9], $19
	load    [$2 + 9], $22
	load    [$19 + 1], $19
	load    [$22 + 0], $22
	fmul    $20, $19, $19
	fmul    $21, $22, $20
	fadd    $19, $20, $19
	fmul    $19, $39, $19
	fadd    $25, $19, $19
	store   $19, [min_caml_nvector + 2]
be_cont.36769:
	load    [min_caml_nvector + 0], $19
	load    [min_caml_nvector + 1], $21
	load    [$2 + 6], $20
	fmul    $19, $19, $22
	fmul    $21, $21, $21
	load    [min_caml_nvector + 2], $23
	fmul    $23, $23, $23
	fadd    $22, $21, $21
	fadd    $21, $23, $21
	fsqrt   $21, $21
	fcmp    $21, $zero
	bne     be_else.36770
be_then.36770:
	mov     $36, $20
.count b_cont
	b       be_cont.36770
be_else.36770:
	cmp     $20, 0
	finv    $21, $20
	be      bne_cont.36771
bne_then.36771:
	fneg    $20, $20
bne_cont.36771:
be_cont.36770:
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $19
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $19
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 2]
be_cont.36768:
be_cont.36765:
	call    utexture.2908
	load    [$59 + 0], $17
	load    [$17 + 0], $2
	cmp     $2, -1
	bne     be_else.36772
be_then.36772:
	li      0, $1
.count b_cont
	b       be_cont.36772
be_else.36772:
	cmp     $2, 99
.count stack_store
	store   $17, [$sp + 4]
	bne     be_else.36773
be_then.36773:
	li      1, $1
.count b_cont
	b       be_cont.36773
be_else.36773:
	call    solver_fast.2796
	cmp     $1, 0
	bne     be_else.36774
be_then.36774:
	li      0, $1
.count b_cont
	b       be_cont.36774
be_else.36774:
	fcmp    $18, $42
	load    [$17 + 1], $1
	li      0, $2
	bg      ble_else.36775
ble_then.36775:
	li      0, $1
.count b_cont
	b       ble_cont.36775
ble_else.36775:
	cmp     $1, -1
	bne     be_else.36776
be_then.36776:
	li      0, $1
.count b_cont
	b       be_cont.36776
be_else.36776:
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36777
be_then.36777:
.count stack_load
	load    [$sp + 4], $3
	li      0, $2
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.36778
be_then.36778:
	li      0, $1
.count b_cont
	b       be_cont.36777
be_else.36778:
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36779
be_then.36779:
	li      3, $2
.count stack_load
	load    [$sp + 4], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.36780
be_then.36780:
	li      0, $1
.count b_cont
	b       be_cont.36777
be_else.36780:
	li      1, $1
.count b_cont
	b       be_cont.36777
be_else.36779:
	li      1, $1
.count b_cont
	b       be_cont.36777
be_else.36777:
	li      1, $1
be_cont.36777:
be_cont.36776:
ble_cont.36775:
be_cont.36774:
be_cont.36773:
	cmp     $1, 0
	li      1, $2
	bne     be_else.36781
be_then.36781:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36781
be_else.36781:
.count stack_load
	load    [$sp + 4], $3
	li      0, $4
	load    [$3 + 1], $1
	cmp     $1, -1
	bne     be_else.36782
be_then.36782:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36782
be_else.36782:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $4, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36783
be_then.36783:
.count stack_load
	load    [$sp + 4], $3
	li      1, $2
	li      0, $4
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.36784
be_then.36784:
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36783
be_else.36784:
	load    [min_caml_and_net + $1], $3
.count move_args
	mov     $4, $2
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.36785
be_then.36785:
	li      3, $2
.count stack_load
	load    [$sp + 4], $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.36786
be_then.36786:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.36783
be_else.36786:
	li      1, $1
.count b_cont
	b       be_cont.36783
be_else.36785:
	li      1, $1
.count b_cont
	b       be_cont.36783
be_else.36783:
	li      1, $1
be_cont.36783:
be_cont.36782:
be_cont.36781:
be_cont.36772:
	cmp     $1, 0
.count stack_move
	add     $sp, 5, $sp
	bne     be_else.36787
be_then.36787:
.count stack_load
	load    [$sp - 2], $1
	load    [min_caml_texture_color + 0], $2
	load    [min_caml_nvector + 0], $3
	load    [min_caml_nvector + 1], $4
	load    [$1 + 7], $1
	fmul    $3, $55, $3
	fmul    $4, $56, $4
	load    [min_caml_nvector + 2], $5
	load    [$1 + 0], $1
	fmul    $5, $57, $5
	fadd    $3, $4, $3
	fadd    $3, $5, $3
	fneg    $3, $3
	fcmp    $3, $zero
	bg      ble_cont.36788
ble_then.36788:
	mov     $zero, $3
ble_cont.36788:
.count stack_load
	load    [$sp - 5], $4
	fmul    $4, $3, $3
	fmul    $3, $1, $1
	fmul    $1, $2, $2
	fadd    $43, $2, $2
.count move_float
	mov     $2, $43
	fmul    $1, $54, $2
	fmul    $1, $58, $1
	fadd    $44, $2, $2
	fadd    $45, $1, $1
.count move_float
	mov     $2, $44
.count move_float
	mov     $1, $45
	ret
be_else.36787:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	cmp     $4, 0
	bl      bge_else.36789
bge_then.36789:
	load    [$2 + $4], $1
.count stack_move
	sub     $sp, 5, $sp
	load    [$3 + 0], $5
	load    [$1 + 0], $1
	load    [$3 + 1], $6
	load    [$3 + 2], $7
	load    [$2 + $4], $8
	load    [$1 + 0], $9
	load    [$1 + 1], $10
	load    [$1 + 2], $1
	fmul    $9, $5, $5
	fmul    $10, $6, $6
	fmul    $1, $7, $1
	add     $4, 1, $7
	load    [$2 + $7], $7
	fadd    $5, $6, $5
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
	fadd    $5, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36790
ble_then.36790:
	fmul    $1, $37, $3
.count move_args
	mov     $8, $2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
.count stack_load
	load    [$sp + 1], $3
	sub     $1, 2, $1
	load    [$3 + 0], $2
	cmp     $1, 0
	bl      bge_else.36791
bge_then.36791:
.count stack_load
	load    [$sp + 0], $4
	load    [$3 + 1], $6
	load    [$3 + 2], $7
	load    [$4 + $1], $5
	load    [$4 + $1], $8
	add     $1, 1, $9
	load    [$5 + 0], $5
	load    [$5 + 0], $10
	load    [$5 + 1], $11
	load    [$5 + 2], $5
	fmul    $10, $2, $2
	fmul    $11, $6, $6
	fmul    $5, $7, $5
	load    [$4 + $9], $7
.count stack_store
	store   $1, [$sp + 3]
	fadd    $2, $6, $2
	fadd    $2, $5, $2
	fcmp    $zero, $2
	bg      ble_else.36792
ble_then.36792:
	fmul    $2, $37, $3
.count move_args
	mov     $8, $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.36792:
	fmul    $2, $38, $3
.count move_args
	mov     $7, $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 5], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.36791:
.count stack_move
	add     $sp, 5, $sp
	ret
ble_else.36790:
	fmul    $1, $38, $3
.count move_args
	mov     $7, $2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
.count stack_load
	load    [$sp + 1], $3
	sub     $1, 2, $1
	load    [$3 + 0], $2
	cmp     $1, 0
	bl      bge_else.36793
bge_then.36793:
.count stack_load
	load    [$sp + 0], $4
	load    [$3 + 1], $6
	load    [$3 + 2], $7
	load    [$4 + $1], $5
	load    [$4 + $1], $8
	add     $1, 1, $9
	load    [$5 + 0], $5
	load    [$5 + 0], $10
	load    [$5 + 1], $11
	load    [$5 + 2], $5
	fmul    $10, $2, $2
	fmul    $11, $6, $6
	fmul    $5, $7, $5
	load    [$4 + $9], $7
.count stack_store
	store   $1, [$sp + 4]
	fadd    $2, $6, $2
	fadd    $2, $5, $2
	fcmp    $zero, $2
	bg      ble_else.36794
ble_then.36794:
	fmul    $2, $37, $3
.count move_args
	mov     $8, $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 5], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.36794:
	fmul    $2, $38, $3
.count move_args
	mov     $7, $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 5, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 5], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.36793:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.36789:
	ret
.end iter_trace_diffuse_rays

######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 5], $16
	load    [$2 + 6], $18
	load    [$16 + $3], $16
	load    [$16 + 0], $17
.count move_float
	mov     $17, $43
	load    [$16 + 1], $17
	load    [$16 + 2], $16
.count move_float
	mov     $17, $44
.count move_float
	mov     $16, $45
	load    [$2 + 7], $16
	load    [$2 + 1], $17
	load    [$16 + $3], $16
.count stack_store
	store   $16, [$sp + 2]
	load    [$17 + $3], $2
.count stack_store
	store   $2, [$sp + 3]
	load    [$18 + 0], $17
	cmp     $17, 0
.count stack_store
	store   $17, [$sp + 4]
	load    [min_caml_dirvecs + 0], $18
	load    [$2 + 0], $19
	be      bne_cont.36795
bne_then.36795:
.count move_float
	mov     $19, $51
	load    [$2 + 1], $17
	sub     $41, 1, $3
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$18 + 118], $17
	load    [$16 + 0], $19
	load    [$16 + 1], $20
	load    [$17 + 0], $17
	load    [$16 + 2], $21
	load    [$18 + 118], $2
	load    [$17 + 0], $22
	load    [$17 + 1], $23
	load    [$17 + 2], $17
	fmul    $22, $19, $19
	fmul    $23, $20, $20
	fmul    $17, $21, $17
.count load_float
	load    [f.31972], $21
.count load_float
	load    [f.31971], $22
	fadd    $19, $20, $19
	load    [$18 + 119], $21
.count stack_store
	store   $18, [$sp + 5]
	fadd    $19, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36796
ble_then.36796:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36796
ble_else.36796:
	fmul    $17, $38, $3
.count move_args
	mov     $21, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36796:
bne_cont.36795:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 1
	be      bne_cont.36797
bne_then.36797:
.count stack_load
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 1], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 2], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
.count load_float
	load    [f.31972], $20
.count load_float
	load    [f.31971], $21
	fadd    $18, $19, $18
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 6]
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36798
ble_then.36798:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36798
ble_else.36798:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36798:
bne_cont.36797:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 2
	be      bne_cont.36799
bne_then.36799:
.count stack_load
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 2], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 2], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
.count load_float
	load    [f.31972], $20
.count load_float
	load    [f.31971], $21
	fadd    $18, $19, $18
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 7]
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36800
ble_then.36800:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36800
ble_else.36800:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36800:
bne_cont.36799:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 3
	be      bne_cont.36801
bne_then.36801:
.count stack_load
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 3], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 2], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
.count load_float
	load    [f.31972], $20
.count load_float
	load    [f.31971], $21
	fadd    $18, $19, $18
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 8]
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36802
ble_then.36802:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36802
ble_else.36802:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36802:
bne_cont.36801:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 4
	be      bne_cont.36803
bne_then.36803:
.count stack_load
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 4], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $1
.count stack_load
	load    [$sp + 2], $3
	load    [$16 + 118], $6
	load    [$1 + 0], $1
	load    [$3 + 0], $2
	load    [$3 + 1], $4
	load    [$3 + 2], $5
	load    [$1 + 0], $7
	load    [$1 + 1], $8
	load    [$1 + 2], $1
	fmul    $7, $2, $2
	fmul    $8, $4, $4
	fmul    $1, $5, $1
.count load_float
	load    [f.31972], $5
.count load_float
	load    [f.31971], $7
	fadd    $2, $4, $2
	load    [$16 + 119], $5
.count stack_store
	store   $16, [$sp + 9]
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36804
ble_then.36804:
	fmul    $1, $37, $3
.count move_args
	mov     $6, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36804
ble_else.36804:
	fmul    $1, $38, $3
.count move_args
	mov     $5, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36804:
bne_cont.36803:
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $1
.count stack_load
	load    [$sp - 10], $2
	load    [$1 + 4], $1
	load    [$1 + $2], $1
	load    [$1 + 0], $2
	fmul    $2, $43, $2
	fadd    $46, $2, $2
.count move_float
	mov     $2, $46
	load    [$1 + 1], $2
	load    [$1 + 2], $1
	fmul    $2, $44, $2
	fmul    $1, $45, $1
	fadd    $47, $2, $2
	fadd    $48, $1, $1
.count move_float
	mov     $2, $47
.count move_float
	mov     $1, $48
	ret
.end calc_diffuse_using_1point

######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	cmp     $3, 4
	bg      ble_else.36805
ble_then.36805:
	load    [$2 + 2], $16
	load    [$2 + 3], $17
	add     $3, 1, $18
	load    [$16 + $3], $19
	load    [$17 + $3], $20
	load    [$2 + 5], $21
	cmp     $19, 0
	bl      bge_else.36806
bge_then.36806:
	cmp     $20, 0
	bne     be_else.36807
be_then.36807:
	cmp     $18, 4
	bg      ble_else.36808
ble_then.36808:
	load    [$16 + $18], $1
	load    [$17 + $18], $3
	add     $18, 1, $4
	cmp     $1, 0
	bl      bge_else.36809
bge_then.36809:
	cmp     $3, 0
	bne     be_else.36810
be_then.36810:
.count move_args
	mov     $4, $3
	b       do_without_neighbors.2951
be_else.36810:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $18, $3
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $18, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 13], $1
.count stack_load
	load    [$sp - 14], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.36809:
	ret
ble_else.36808:
	ret
be_else.36807:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $17, [$sp + 2]
.count stack_store
	store   $16, [$sp + 3]
.count stack_store
	store   $3, [$sp + 4]
.count stack_store
	store   $2, [$sp + 0]
	load    [$21 + $3], $16
	load    [$2 + 6], $18
	load    [$16 + 0], $17
.count move_float
	mov     $17, $43
	load    [$16 + 1], $17
	load    [$16 + 2], $16
.count move_float
	mov     $17, $44
.count move_float
	mov     $16, $45
	load    [$2 + 7], $16
	load    [$2 + 1], $17
	load    [$16 + $3], $16
.count stack_store
	store   $16, [$sp + 5]
	load    [$17 + $3], $2
.count stack_store
	store   $2, [$sp + 6]
	load    [$18 + 0], $17
	cmp     $17, 0
.count stack_store
	store   $17, [$sp + 7]
	load    [min_caml_dirvecs + 0], $18
	load    [$2 + 0], $19
	be      bne_cont.36811
bne_then.36811:
.count move_float
	mov     $19, $51
	load    [$2 + 1], $17
	sub     $41, 1, $3
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$18 + 118], $17
	load    [$16 + 0], $19
	load    [$16 + 1], $20
	load    [$17 + 0], $17
	load    [$16 + 2], $21
	load    [$18 + 118], $2
	load    [$17 + 0], $22
	load    [$17 + 1], $23
	load    [$17 + 2], $17
	fmul    $22, $19, $19
	fmul    $23, $20, $20
	fmul    $17, $21, $17
	load    [$18 + 119], $21
.count stack_store
	store   $18, [$sp + 8]
	fadd    $19, $20, $19
	fadd    $19, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36812
ble_then.36812:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36812
ble_else.36812:
	fmul    $17, $38, $3
.count move_args
	mov     $21, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36812:
bne_cont.36811:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 1
	be      bne_cont.36813
bne_then.36813:
.count stack_load
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 1], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 5], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 9]
	fadd    $18, $19, $18
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36814
ble_then.36814:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36814
ble_else.36814:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36814:
bne_cont.36813:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 2
	be      bne_cont.36815
bne_then.36815:
.count stack_load
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 2], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 5], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 10]
	fadd    $18, $19, $18
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36816
ble_then.36816:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36816
ble_else.36816:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36816:
bne_cont.36815:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 3
	be      bne_cont.36817
bne_then.36817:
.count stack_load
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 3], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $17
.count stack_load
	load    [$sp + 5], $3
	load    [$16 + 118], $2
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $19
	load    [$3 + 2], $20
	load    [$17 + 0], $21
	load    [$17 + 1], $22
	load    [$17 + 2], $17
	fmul    $21, $18, $18
	fmul    $22, $19, $19
	fmul    $17, $20, $17
	load    [$16 + 119], $20
.count stack_store
	store   $16, [$sp + 11]
	fadd    $18, $19, $18
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.36818
ble_then.36818:
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36818
ble_else.36818:
	fmul    $17, $38, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36818:
bne_cont.36817:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 4
	be      bne_cont.36819
bne_then.36819:
.count stack_load
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 4], $16
	sub     $41, 1, $3
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $1
.count stack_load
	load    [$sp + 5], $3
	load    [$16 + 118], $6
	load    [$1 + 0], $1
	load    [$3 + 0], $2
	load    [$3 + 1], $4
	load    [$3 + 2], $5
	load    [$1 + 0], $7
	load    [$1 + 1], $8
	load    [$1 + 2], $1
	fmul    $7, $2, $2
	fmul    $8, $4, $4
	fmul    $1, $5, $1
	load    [$16 + 119], $5
.count stack_store
	store   $16, [$sp + 12]
	fadd    $2, $4, $2
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36820
ble_then.36820:
	fmul    $1, $37, $3
.count move_args
	mov     $6, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36820
ble_else.36820:
	fmul    $1, $38, $3
.count move_args
	mov     $5, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36820:
bne_cont.36819:
.count stack_load
	load    [$sp + 0], $2
.count stack_load
	load    [$sp + 4], $3
	load    [$2 + 4], $1
	load    [$1 + $3], $1
	add     $3, 1, $3
	load    [$1 + 0], $4
	cmp     $3, 4
	fmul    $4, $43, $4
	fadd    $46, $4, $4
.count move_float
	mov     $4, $46
	load    [$1 + 1], $4
	load    [$1 + 2], $1
	fmul    $4, $44, $4
	fmul    $1, $45, $1
	fadd    $47, $4, $4
	fadd    $48, $1, $1
.count move_float
	mov     $4, $47
.count move_float
	mov     $1, $48
	bg      ble_else.36821
ble_then.36821:
.count stack_load
	load    [$sp + 3], $1
.count stack_load
	load    [$sp + 2], $4
	add     $3, 1, $5
	load    [$1 + $3], $1
	load    [$4 + $3], $4
	cmp     $1, 0
	bl      bge_else.36822
bge_then.36822:
	cmp     $4, 0
	bne     be_else.36823
be_then.36823:
.count stack_move
	add     $sp, 14, $sp
.count move_args
	mov     $5, $3
	b       do_without_neighbors.2951
be_else.36823:
.count stack_store
	store   $3, [$sp + 13]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 14], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.36822:
.count stack_move
	add     $sp, 14, $sp
	ret
ble_else.36821:
.count stack_move
	add     $sp, 14, $sp
	ret
bge_else.36806:
	ret
ble_else.36805:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	cmp     $6, 4
	bg      ble_else.36824
ble_then.36824:
	load    [$4 + $2], $1
	load    [$3 + $2], $7
	load    [$5 + $2], $8
	load    [$1 + 2], $9
	load    [$7 + 2], $10
	load    [$1 + 3], $1
	load    [$9 + $6], $9
	load    [$10 + $6], $10
	load    [$1 + $6], $1
	cmp     $9, 0
	bl      bge_else.36825
bge_then.36825:
	cmp     $10, $9
	bne     be_else.36826
be_then.36826:
	load    [$8 + 2], $8
	sub     $2, 1, $10
	add     $2, 1, $11
	load    [$8 + $6], $8
	load    [$4 + $10], $10
	load    [$4 + $11], $11
	cmp     $8, $9
	bne     be_else.36827
be_then.36827:
	load    [$10 + 2], $8
	load    [$11 + 2], $10
	load    [$8 + $6], $8
	load    [$10 + $6], $10
	cmp     $8, $9
	bne     be_else.36828
be_then.36828:
	cmp     $10, $9
	bne     be_else.36829
be_then.36829:
	li      1, $8
.count b_cont
	b       be_cont.36826
be_else.36829:
	li      0, $8
.count b_cont
	b       be_cont.36826
be_else.36828:
	li      0, $8
.count b_cont
	b       be_cont.36826
be_else.36827:
	li      0, $8
.count b_cont
	b       be_cont.36826
be_else.36826:
	li      0, $8
be_cont.36826:
	cmp     $8, 0
	bne     be_else.36830
be_then.36830:
	cmp     $6, 4
	bg      ble_else.36831
ble_then.36831:
	load    [$4 + $2], $2
	add     $6, 1, $3
	load    [$2 + 2], $1
	load    [$2 + 3], $4
	load    [$1 + $6], $1
	load    [$4 + $6], $4
	cmp     $1, 0
	bl      bge_else.36832
bge_then.36832:
	cmp     $4, 0
	be      do_without_neighbors.2951
.count stack_move
	sub     $sp, 2, $sp
.count move_args
	mov     $6, $3
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $6, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 2], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.36832:
	ret
ble_else.36831:
	ret
be_else.36830:
	cmp     $1, 0
	bne     be_else.36834
be_then.36834:
	add     $6, 1, $6
	b       try_exploit_neighbors.2967
be_else.36834:
	load    [$7 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
.count move_float
	mov     $7, $44
	sub     $2, 1, $7
.count move_float
	mov     $1, $45
	load    [$4 + $7], $1
	load    [$1 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
	fadd    $43, $7, $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fadd    $44, $7, $7
	fadd    $45, $1, $1
.count move_float
	mov     $7, $44
.count move_float
	mov     $1, $45
	load    [$4 + $2], $1
	load    [$1 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
	fadd    $43, $7, $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fadd    $44, $7, $7
	fadd    $45, $1, $1
.count move_float
	mov     $7, $44
	add     $2, 1, $7
.count move_float
	mov     $1, $45
	load    [$4 + $7], $1
	load    [$1 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
	fadd    $43, $7, $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fadd    $44, $7, $7
	fadd    $45, $1, $1
.count move_float
	mov     $7, $44
.count move_float
	mov     $1, $45
	load    [$5 + $2], $1
	load    [$1 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
	fadd    $43, $7, $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fadd    $44, $7, $7
	fadd    $45, $1, $1
.count move_float
	mov     $7, $44
.count move_float
	mov     $1, $45
	load    [$4 + $2], $1
	load    [$1 + 4], $1
	load    [$1 + $6], $1
	add     $6, 1, $6
	load    [$1 + 0], $7
	fmul    $7, $43, $7
	fadd    $46, $7, $7
.count move_float
	mov     $7, $46
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fmul    $7, $44, $7
	fmul    $1, $45, $1
	fadd    $47, $7, $7
	fadd    $48, $1, $1
.count move_float
	mov     $7, $47
.count move_float
	mov     $1, $48
	b       try_exploit_neighbors.2967
bge_else.36825:
	ret
ble_else.36824:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	cmp     $3, 4
	bg      ble_else.36835
ble_then.36835:
	load    [$2 + 2], $16
	load    [$2 + 3], $17
	add     $3, 1, $18
	load    [$16 + $3], $19
	load    [$17 + $3], $20
	load    [$16 + $18], $21
	cmp     $19, 0
	bl      bge_else.36836
bge_then.36836:
	cmp     $20, 0
	bne     be_else.36837
be_then.36837:
	cmp     $18, 4
	bg      ble_else.36838
ble_then.36838:
	cmp     $21, 0
	bl      bge_else.36839
bge_then.36839:
	load    [$17 + $18], $16
	add     $18, 1, $3
	cmp     $16, 0
	be      pretrace_diffuse_rays.2980
.count stack_move
	sub     $sp, 15, $sp
.count move_float
	mov     $zero, $43
.count stack_store
	store   $18, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 1], $19
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $16
	load    [$2 + 7], $17
	load    [$19 + $18], $2
	sub     $41, 1, $3
	load    [$2 + 0], $19
.count move_float
	mov     $19, $51
	load    [$2 + 1], $19
.count move_float
	mov     $19, $52
	load    [$2 + 2], $19
.count move_float
	mov     $19, $53
	call    setup_startp_constants.2831
	load    [$16 + 0], $1
	load    [$17 + $18], $3
	load    [min_caml_dirvecs + $1], $2
	load    [$3 + 0], $1
	load    [$3 + 1], $4
	load    [$2 + 118], $5
	load    [$3 + 2], $6
	load    [$2 + 118], $7
	load    [$5 + 0], $5
	load    [$2 + 119], $8
	load    [$5 + 0], $9
	load    [$5 + 1], $10
	load    [$5 + 2], $5
	fmul    $9, $1, $1
	fmul    $10, $4, $4
	fmul    $5, $6, $5
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
	fadd    $1, $4, $1
	fadd    $1, $5, $1
	fcmp    $zero, $1
	bg      ble_else.36841
ble_then.36841:
	fmul    $1, $37, $3
.count move_args
	mov     $7, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36841
ble_else.36841:
	fmul    $1, $38, $3
.count move_args
	mov     $8, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36841:
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 14], $2
.count stack_load
	load    [$sp - 15], $3
	load    [$2 + 5], $1
	load    [$1 + $3], $1
	add     $3, 1, $3
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	b       pretrace_diffuse_rays.2980
bge_else.36839:
	ret
ble_else.36838:
	ret
be_else.36837:
.count stack_move
	sub     $sp, 15, $sp
.count move_float
	mov     $zero, $43
.count stack_store
	store   $17, [$sp + 4]
.count stack_store
	store   $16, [$sp + 5]
.count stack_store
	store   $2, [$sp + 1]
.count stack_store
	store   $3, [$sp + 6]
	load    [$2 + 7], $17
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $16
.count stack_store
	store   $17, [$sp + 7]
	load    [$2 + 1], $18
.count stack_store
	store   $18, [$sp + 8]
	load    [$18 + $3], $2
	sub     $41, 1, $3
	load    [$2 + 0], $18
.count move_float
	mov     $18, $51
	load    [$2 + 1], $18
.count move_float
	mov     $18, $52
	load    [$2 + 2], $18
.count move_float
	mov     $18, $53
	call    setup_startp_constants.2831
.count stack_load
	load    [$sp + 6], $18
	load    [$16 + 0], $16
.count load_float
	load    [f.31971], $21
	load    [$17 + $18], $3
.count load_float
	load    [f.31972], $17
.count stack_store
	store   $3, [$sp + 9]
	load    [min_caml_dirvecs + $16], $2
.count stack_store
	store   $2, [$sp + 10]
	load    [$2 + 118], $18
	load    [$3 + 0], $16
	load    [$3 + 1], $17
	load    [$18 + 0], $18
	load    [$3 + 2], $19
	load    [$2 + 118], $20
	load    [$2 + 119], $2
	load    [$18 + 0], $21
	load    [$18 + 1], $22
	load    [$18 + 2], $18
	fmul    $21, $16, $16
	fmul    $22, $17, $17
	fmul    $18, $19, $18
	fadd    $16, $17, $16
	fadd    $16, $18, $16
	fcmp    $zero, $16
	bg      ble_else.36842
ble_then.36842:
	fmul    $16, $37, $3
.count move_args
	mov     $20, $2
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.36842
ble_else.36842:
	fmul    $16, $38, $3
	call    trace_diffuse_ray.2926
ble_cont.36842:
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 9], $3
	call    iter_trace_diffuse_rays.2929
.count stack_load
	load    [$sp + 1], $2
.count stack_load
	load    [$sp + 6], $17
	load    [$2 + 5], $16
	load    [$16 + $17], $18
	add     $17, 1, $17
	cmp     $17, 4
	store   $43, [$18 + 0]
	store   $44, [$18 + 1]
	store   $45, [$18 + 2]
	bg      ble_else.36843
ble_then.36843:
.count stack_load
	load    [$sp + 5], $18
.count stack_load
	load    [$sp + 4], $19
	add     $17, 1, $3
	load    [$18 + $17], $18
	load    [$19 + $17], $19
	cmp     $18, 0
	bl      bge_else.36844
bge_then.36844:
	cmp     $19, 0
	bne     be_else.36845
be_then.36845:
.count stack_move
	add     $sp, 15, $sp
	b       pretrace_diffuse_rays.2980
be_else.36845:
.count stack_store
	store   $17, [$sp + 11]
.count stack_store
	store   $16, [$sp + 12]
.count stack_load
	load    [$sp + 8], $18
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $16
	load    [$18 + $17], $2
	sub     $41, 1, $3
	load    [$2 + 0], $18
.count move_float
	mov     $18, $51
	load    [$2 + 1], $18
.count move_float
	mov     $18, $52
	load    [$2 + 2], $18
.count move_float
	mov     $18, $53
	call    setup_startp_constants.2831
	load    [$16 + 0], $1
.count stack_load
	load    [$sp + 7], $2
	load    [$2 + $17], $3
	load    [min_caml_dirvecs + $1], $2
	load    [$3 + 0], $1
	load    [$2 + 118], $5
	load    [$3 + 1], $4
	load    [$3 + 2], $6
	load    [$5 + 0], $5
	load    [$2 + 118], $7
	load    [$2 + 119], $8
	load    [$5 + 0], $9
	load    [$5 + 1], $10
	load    [$5 + 2], $5
	fmul    $9, $1, $1
	fmul    $10, $4, $4
	fmul    $5, $6, $5
.count stack_store
	store   $3, [$sp + 13]
.count stack_store
	store   $2, [$sp + 14]
	fadd    $1, $4, $1
	fadd    $1, $5, $1
	fcmp    $zero, $1
	bg      ble_else.36846
ble_then.36846:
	fmul    $1, $37, $3
.count move_args
	mov     $7, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 14], $2
.count stack_load
	load    [$sp + 13], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36846
ble_else.36846:
	fmul    $1, $38, $3
.count move_args
	mov     $8, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 14], $2
.count stack_load
	load    [$sp + 13], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36846:
.count stack_move
	add     $sp, 15, $sp
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 3], $2
	add     $1, 1, $3
	load    [$2 + $1], $2
	store   $43, [$2 + 0]
	store   $44, [$2 + 1]
	store   $45, [$2 + 2]
.count stack_load
	load    [$sp - 14], $2
	b       pretrace_diffuse_rays.2980
bge_else.36844:
.count stack_move
	add     $sp, 15, $sp
	ret
ble_else.36843:
.count stack_move
	add     $sp, 15, $sp
	ret
bge_else.36836:
	ret
ble_else.36835:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	cmp     $3, 0
	bl      bge_else.36847
bge_then.36847:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
.count stack_store
	store   $7, [$sp + 3]
.count stack_store
	store   $6, [$sp + 4]
.count stack_store
	store   $5, [$sp + 5]
	load    [min_caml_image_center + 0], $12
	load    [min_caml_screenx_dir + 0], $10
	load    [min_caml_scan_pitch + 0], $11
	sub     $3, $12, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $11, $16, $16
.count stack_load
	load    [$sp + 5], $18
	fmul    $16, $10, $17
	fadd    $17, $18, $17
	store   $17, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_screenx_dir + 1], $17
.count stack_load
	load    [$sp + 4], $18
	fmul    $16, $17, $17
	fadd    $17, $18, $17
	store   $17, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $17
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $17
	fadd    $16, $17, $16
	store   $16, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $16
	load    [min_caml_ptrace_dirvec + 1], $17
	load    [min_caml_ptrace_dirvec + 2], $18
	fmul    $16, $16, $19
	fmul    $17, $17, $17
	fmul    $18, $18, $18
	fadd    $19, $17, $17
	fadd    $17, $18, $17
	fsqrt   $17, $17
	fcmp    $17, $zero
	bne     be_else.36848
be_then.36848:
	mov     $36, $17
.count b_cont
	b       be_cont.36848
be_else.36848:
	finv    $17, $17
be_cont.36848:
	fmul    $16, $17, $16
.count move_float
	mov     $zero, $46
.count move_float
	mov     $zero, $47
.count move_float
	mov     $zero, $48
	li      min_caml_ptrace_dirvec, $4
	store   $16, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $16
	li      0, $2
.count move_args
	mov     $zero, $6
	fmul    $16, $17, $16
.count move_args
	mov     $36, $3
	store   $16, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $16
	fmul    $16, $17, $16
	store   $16, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_viewpoint + 0], $16
	store   $16, [min_caml_startp + 0]
	load    [min_caml_viewpoint + 1], $16
	store   $16, [min_caml_startp + 1]
	load    [min_caml_viewpoint + 2], $16
	store   $16, [min_caml_startp + 2]
.count stack_load
	load    [$sp + 1], $16
.count stack_load
	load    [$sp + 2], $17
	load    [$17 + $16], $5
	call    trace_ray.2920
.count stack_load
	load    [$sp + 1], $16
.count stack_load
	load    [$sp + 2], $17
	li      1, $3
	load    [$17 + $16], $18
	load    [$18 + 0], $18
	store   $46, [$18 + 0]
	store   $47, [$18 + 1]
	store   $48, [$18 + 2]
	load    [$17 + $16], $18
.count stack_load
	load    [$sp + 0], $19
	load    [$18 + 6], $18
	store   $19, [$18 + 0]
	load    [$17 + $16], $2
	load    [$2 + 2], $16
	load    [$2 + 3], $17
	load    [$2 + 6], $18
	load    [$16 + 0], $16
	load    [$17 + 0], $17
	load    [$18 + 0], $18
	cmp     $16, 0
	bl      bge_cont.36849
bge_then.36849:
	cmp     $17, 0
	bne     be_else.36850
be_then.36850:
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.36850
be_else.36850:
.count stack_store
	store   $2, [$sp + 6]
	load    [$2 + 1], $17
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 7], $16
	load    [$17 + 0], $2
	load    [min_caml_dirvecs + $18], $18
	load    [$16 + 0], $16
	load    [$2 + 0], $17
	sub     $41, 1, $3
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	call    setup_startp_constants.2831
	load    [$18 + 118], $1
	load    [$16 + 0], $2
	load    [$16 + 1], $3
	load    [$1 + 0], $1
	load    [$16 + 2], $4
	load    [$18 + 118], $5
	load    [$1 + 0], $6
	load    [$1 + 1], $7
	load    [$1 + 2], $1
	fmul    $6, $2, $2
	fmul    $7, $3, $3
	fmul    $1, $4, $1
	load    [$18 + 119], $4
.count stack_store
	store   $16, [$sp + 7]
.count stack_store
	store   $18, [$sp + 8]
	fadd    $2, $3, $2
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.36851
ble_then.36851:
	fmul    $1, $37, $3
.count move_args
	mov     $5, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.36851
ble_else.36851:
	fmul    $1, $38, $3
.count move_args
	mov     $4, $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.36851:
.count stack_load
	load    [$sp + 6], $2
	li      1, $3
	load    [$2 + 5], $1
	load    [$1 + 0], $1
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	call    pretrace_diffuse_rays.2980
be_cont.36850:
bge_cont.36849:
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $1
.count stack_load
	load    [$sp - 6], $7
.count stack_load
	load    [$sp - 5], $6
	sub     $1, 1, $3
.count stack_load
	load    [$sp - 9], $1
.count stack_load
	load    [$sp - 4], $5
.count stack_load
	load    [$sp - 7], $2
	add     $1, 1, $4
	cmp     $4, 5
	bl      pretrace_pixels.2983
	sub     $4, 5, $4
	b       pretrace_pixels.2983
bge_else.36847:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.2994:
	cmp     $50, $2
	load    [$5 + $2], $10
	bg      ble_else.36853
ble_then.36853:
	ret
ble_else.36853:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $6, [$sp + 0]
.count stack_store
	store   $4, [$sp + 1]
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $5, [$sp + 3]
.count stack_store
	store   $2, [$sp + 4]
	load    [$10 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
	load    [$10 + 2], $10
.count move_float
	mov     $11, $47
.count move_float
	mov     $10, $48
	add     $3, 1, $10
	cmp     $60, $10
.count stack_store
	store   $10, [$sp + 5]
	load    [$5 + $2], $11
	bg      ble_else.36854
ble_then.36854:
	li      0, $10
.count b_cont
	b       ble_cont.36854
ble_else.36854:
	cmp     $3, 0
	bg      ble_else.36855
ble_then.36855:
	li      0, $10
.count b_cont
	b       ble_cont.36855
ble_else.36855:
	add     $2, 1, $10
	cmp     $50, $10
	bg      ble_else.36856
ble_then.36856:
	li      0, $10
.count b_cont
	b       ble_cont.36856
ble_else.36856:
	cmp     $2, 0
	bg      ble_else.36857
ble_then.36857:
	li      0, $10
.count b_cont
	b       ble_cont.36857
ble_else.36857:
	li      1, $10
ble_cont.36857:
ble_cont.36856:
ble_cont.36855:
ble_cont.36854:
	cmp     $10, 0
	li      0, $3
	bne     be_else.36858
be_then.36858:
	load    [$11 + 2], $10
	load    [$11 + 3], $12
	li      1, $13
	load    [$10 + 0], $10
	load    [$12 + 0], $12
	cmp     $10, 0
	bl      be_cont.36858
bge_then.36859:
	cmp     $12, 0
.count move_args
	mov     $11, $2
	bne     be_else.36860
be_then.36860:
.count move_args
	mov     $13, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36858
be_else.36860:
.count stack_store
	store   $11, [$sp + 6]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 6], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36858
be_else.36858:
	load    [$5 + $2], $10
	load    [$4 + $2], $11
	load    [$5 + $2], $12
	load    [$10 + 2], $13
	load    [$11 + 2], $14
	load    [$12 + 2], $15
	load    [$13 + 0], $13
	load    [$14 + 0], $14
	load    [$15 + 0], $15
	cmp     $13, 0
	bl      bge_cont.36861
bge_then.36861:
	cmp     $14, $13
	bne     be_else.36862
be_then.36862:
	load    [$6 + $2], $14
	sub     $2, 1, $16
	add     $2, 1, $17
	load    [$14 + 2], $14
	load    [$5 + $16], $16
	load    [$5 + $17], $17
	load    [$14 + 0], $14
	load    [$16 + 2], $16
	load    [$17 + 2], $17
	cmp     $14, $13
	bne     be_else.36863
be_then.36863:
	load    [$16 + 0], $14
	load    [$17 + 0], $16
	cmp     $14, $13
	bne     be_else.36864
be_then.36864:
	cmp     $16, $13
	bne     be_else.36865
be_then.36865:
	li      1, $13
.count b_cont
	b       be_cont.36862
be_else.36865:
	li      0, $13
.count b_cont
	b       be_cont.36862
be_else.36864:
	li      0, $13
.count b_cont
	b       be_cont.36862
be_else.36863:
	li      0, $13
.count b_cont
	b       be_cont.36862
be_else.36862:
	li      0, $13
be_cont.36862:
	cmp     $13, 0
	bne     be_else.36866
be_then.36866:
	cmp     $15, 0
	bl      be_cont.36866
bge_then.36867:
	load    [$12 + 3], $10
	li      1, $11
.count move_args
	mov     $12, $2
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.36868
be_then.36868:
.count move_args
	mov     $11, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36866
be_else.36868:
.count stack_store
	store   $12, [$sp + 7]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 7], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36866
be_else.36866:
	load    [$10 + 3], $10
	li      1, $12
	load    [$11 + 5], $11
	load    [$10 + 0], $10
.count move_args
	mov     $4, $3
.count move_args
	mov     $5, $4
	cmp     $10, 0
	bne     be_else.36869
be_then.36869:
.count move_args
	mov     $6, $5
.count move_args
	mov     $12, $6
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.36869
be_else.36869:
	load    [$11 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
.count move_float
	mov     $11, $44
	sub     $2, 1, $11
.count move_float
	mov     $10, $45
	load    [$5 + $11], $10
	load    [$10 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fadd    $43, $11, $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
	fadd    $44, $11, $11
	fadd    $45, $10, $10
.count move_float
	mov     $11, $44
.count move_float
	mov     $10, $45
	load    [$5 + $2], $10
	load    [$10 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fadd    $43, $11, $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
	fadd    $44, $11, $11
	fadd    $45, $10, $10
.count move_float
	mov     $11, $44
	add     $2, 1, $11
.count move_float
	mov     $10, $45
	load    [$5 + $11], $10
	load    [$10 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fadd    $43, $11, $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
	fadd    $44, $11, $11
	fadd    $45, $10, $10
.count move_float
	mov     $11, $44
.count move_float
	mov     $10, $45
	load    [$6 + $2], $10
	load    [$10 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fadd    $43, $11, $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
	fadd    $44, $11, $11
	fadd    $45, $10, $10
.count move_float
	mov     $11, $44
.count move_float
	mov     $10, $45
	load    [$5 + $2], $10
.count move_args
	mov     $6, $5
	load    [$10 + 4], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fmul    $11, $43, $11
	fadd    $46, $11, $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
	load    [$10 + 2], $10
	fmul    $11, $44, $11
	fmul    $10, $45, $10
	fadd    $47, $11, $11
	fadd    $48, $10, $10
.count move_float
	mov     $11, $47
	li      1, $11
.count move_float
	mov     $10, $48
.count move_args
	mov     $11, $6
	call    try_exploit_neighbors.2967
be_cont.36869:
be_cont.36866:
bge_cont.36861:
be_cont.36858:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.36870
ble_then.36870:
	cmp     $2, 0
	bl      bge_else.36871
bge_then.36871:
	call    min_caml_write
.count b_cont
	b       ble_cont.36870
bge_else.36871:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.36870
ble_else.36870:
	li      255, $2
	call    min_caml_write
ble_cont.36870:
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.36872
ble_then.36872:
	cmp     $2, 0
	bl      bge_else.36873
bge_then.36873:
	call    min_caml_write
.count b_cont
	b       ble_cont.36872
bge_else.36873:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.36872
ble_else.36872:
	li      255, $2
	call    min_caml_write
ble_cont.36872:
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.36874
ble_then.36874:
	cmp     $2, 0
	bl      bge_else.36875
bge_then.36875:
	call    min_caml_write
.count b_cont
	b       ble_cont.36874
bge_else.36875:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.36874
ble_else.36874:
	li      255, $2
	call    min_caml_write
ble_cont.36874:
.count stack_load
	load    [$sp + 4], $10
	add     $10, 1, $2
	cmp     $50, $2
	bg      ble_else.36876
ble_then.36876:
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.36876:
.count stack_store
	store   $2, [$sp + 8]
.count stack_load
	load    [$sp + 3], $4
	li      0, $3
	load    [$4 + $2], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
	load    [$10 + 2], $10
.count move_float
	mov     $11, $47
.count stack_load
	load    [$sp + 5], $11
.count move_float
	mov     $10, $48
	load    [$4 + $2], $10
	cmp     $60, $11
	bg      ble_else.36877
ble_then.36877:
	li      0, $11
.count b_cont
	b       ble_cont.36877
ble_else.36877:
.count stack_load
	load    [$sp + 2], $11
	cmp     $11, 0
	bg      ble_else.36878
ble_then.36878:
	li      0, $11
.count b_cont
	b       ble_cont.36878
ble_else.36878:
	add     $2, 1, $11
	cmp     $50, $11
	bg      ble_else.36879
ble_then.36879:
	li      0, $11
.count b_cont
	b       ble_cont.36879
ble_else.36879:
	cmp     $2, 0
	bg      ble_else.36880
ble_then.36880:
	li      0, $11
.count b_cont
	b       ble_cont.36880
ble_else.36880:
	li      1, $11
ble_cont.36880:
ble_cont.36879:
ble_cont.36878:
ble_cont.36877:
	cmp     $11, 0
	bne     be_else.36881
be_then.36881:
	load    [$10 + 2], $11
	load    [$10 + 3], $12
	li      1, $13
	load    [$11 + 0], $11
	load    [$12 + 0], $12
	cmp     $11, 0
	bl      be_cont.36881
bge_then.36882:
	cmp     $12, 0
.count move_args
	mov     $10, $2
	bne     be_else.36883
be_then.36883:
.count move_args
	mov     $13, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36881
be_else.36883:
.count stack_store
	store   $10, [$sp + 9]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 9], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36881
be_else.36881:
	li      0, $6
.count stack_load
	load    [$sp + 1], $3
.count stack_load
	load    [$sp + 0], $5
	call    try_exploit_neighbors.2967
be_cont.36881:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36884
ble_then.36884:
	cmp     $1, 0
	bge     ble_cont.36884
bl_then.36885:
	li      0, $1
.count b_cont
	b       ble_cont.36884
ble_else.36884:
	li      255, $1
ble_cont.36884:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36886
ble_then.36886:
	cmp     $1, 0
	bge     ble_cont.36886
bl_then.36887:
	li      0, $1
.count b_cont
	b       ble_cont.36886
ble_else.36886:
	li      255, $1
ble_cont.36886:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36888
ble_then.36888:
	cmp     $1, 0
	bge     ble_cont.36888
bl_then.36889:
	li      0, $1
.count b_cont
	b       ble_cont.36888
ble_else.36888:
	li      255, $1
ble_cont.36888:
	mov     $1, $2
	call    min_caml_write
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 8], $3
.count stack_load
	load    [$sp - 9], $4
	add     $1, 1, $2
.count stack_load
	load    [$sp - 7], $5
.count stack_load
	load    [$sp - 10], $6
	b       scan_pixel.2994
.end scan_pixel

######################################################################
.begin scan_line
scan_line.3000:
	cmp     $60, $2
	add     $2, 1, $10
	load    [min_caml_scan_pitch + 0], $11
	bg      ble_else.36890
ble_then.36890:
	ret
ble_else.36890:
	sub     $60, 1, $12
.count stack_move
	sub     $sp, 8, $sp
	cmp     $12, $2
.count stack_store
	store   $6, [$sp + 0]
.count stack_store
	store   $5, [$sp + 1]
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
.count stack_store
	store   $4, [$sp + 4]
	load    [min_caml_image_center + 1], $13
	ble     bg_cont.36891
bg_then.36891:
	sub     $10, $13, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $10
	fmul    $11, $10, $10
	load    [min_caml_screeny_dir + 0], $11
	load    [min_caml_screenz_dir + 0], $12
	load    [min_caml_screeny_dir + 1], $13
	load    [min_caml_screeny_dir + 2], $14
	fmul    $10, $11, $11
	fmul    $10, $13, $13
	fmul    $10, $14, $10
	load    [min_caml_screenz_dir + 1], $14
	load    [min_caml_screenz_dir + 2], $15
	fadd    $11, $12, $5
	fadd    $13, $14, $6
	fadd    $10, $15, $7
	sub     $50, 1, $3
.count stack_load
	load    [$sp + 1], $2
.count stack_load
	load    [$sp + 0], $4
	call    pretrace_pixels.2983
bg_cont.36891:
.count stack_load
	load    [$sp + 4], $4
	cmp     $50, 0
	li      0, $2
	load    [$4 + 0], $10
	ble     bg_cont.36892
bg_then.36892:
	load    [$10 + 0], $10
	load    [$4 + 0], $12
	load    [$10 + 0], $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
	load    [$10 + 2], $10
.count move_float
	mov     $11, $47
.count move_float
	mov     $10, $48
.count stack_load
	load    [$sp + 3], $10
	add     $10, 1, $11
	cmp     $60, $11
	bg      ble_else.36893
ble_then.36893:
	li      0, $10
.count b_cont
	b       ble_cont.36893
ble_else.36893:
	cmp     $10, 0
	li      0, $10
	ble     bg_cont.36894
bg_then.36894:
	cmp     $50, 1
bg_cont.36894:
ble_cont.36893:
	cmp     $10, 0
	bne     be_else.36895
be_then.36895:
	load    [$12 + 2], $10
	li      0, $3
	load    [$12 + 3], $11
	load    [$10 + 0], $10
	li      1, $13
	load    [$11 + 0], $11
	cmp     $10, 0
	bl      be_cont.36895
bge_then.36896:
	cmp     $11, 0
.count move_args
	mov     $12, $2
	bne     be_else.36897
be_then.36897:
.count move_args
	mov     $13, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36895
be_else.36897:
.count stack_store
	store   $12, [$sp + 5]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 5], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.36895
be_else.36895:
	li      0, $6
.count stack_load
	load    [$sp + 2], $3
.count stack_load
	load    [$sp + 1], $5
	call    try_exploit_neighbors.2967
be_cont.36895:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36898
ble_then.36898:
	cmp     $1, 0
	bge     ble_cont.36898
bl_then.36899:
	li      0, $1
.count b_cont
	b       ble_cont.36898
ble_else.36898:
	li      255, $1
ble_cont.36898:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36900
ble_then.36900:
	cmp     $1, 0
	bge     ble_cont.36900
bl_then.36901:
	li      0, $1
.count b_cont
	b       ble_cont.36900
ble_else.36900:
	li      255, $1
ble_cont.36900:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.36902
ble_then.36902:
	cmp     $1, 0
	bge     ble_cont.36902
bl_then.36903:
	li      0, $1
.count b_cont
	b       ble_cont.36902
ble_else.36902:
	li      255, $1
ble_cont.36902:
	mov     $1, $2
	call    min_caml_write
	li      1, $2
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 2], $4
.count stack_load
	load    [$sp + 4], $5
.count stack_load
	load    [$sp + 1], $6
	call    scan_pixel.2994
bg_cont.36892:
.count stack_load
	load    [$sp + 3], $10
.count stack_load
	load    [$sp + 0], $11
	add     $10, 1, $10
	add     $11, 2, $11
	cmp     $60, $10
	bg      ble_else.36904
ble_then.36904:
.count stack_move
	add     $sp, 8, $sp
	ret
ble_else.36904:
	cmp     $11, 5
.count stack_store
	store   $10, [$sp + 6]
	sub     $60, 1, $12
	bl      bge_cont.36905
bge_then.36905:
	sub     $11, 5, $11
bge_cont.36905:
	cmp     $12, $10
.count stack_store
	store   $11, [$sp + 7]
	ble     bg_cont.36906
bg_then.36906:
	load    [min_caml_image_center + 1], $12
	add     $10, 1, $10
	load    [min_caml_screeny_dir + 0], $13
	sub     $50, 1, $14
	load    [min_caml_scan_pitch + 0], $15
	sub     $10, $12, $2
	call    min_caml_float_of_int
	fmul    $15, $1, $1
	load    [min_caml_screenz_dir + 0], $2
	load    [min_caml_screeny_dir + 1], $3
	load    [min_caml_screeny_dir + 2], $4
	load    [min_caml_screenz_dir + 1], $5
	fmul    $1, $13, $6
	fmul    $1, $3, $3
	fmul    $1, $4, $1
	load    [min_caml_screenz_dir + 2], $4
	fadd    $6, $2, $2
	fadd    $3, $5, $6
	fadd    $1, $4, $7
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $14, $3
.count move_args
	mov     $2, $5
.count move_args
	mov     $4, $2
.count move_args
	mov     $11, $4
	call    pretrace_pixels.2983
bg_cont.36906:
	li      0, $2
.count stack_load
	load    [$sp + 6], $3
.count stack_load
	load    [$sp + 4], $4
.count stack_load
	load    [$sp + 1], $5
.count stack_load
	load    [$sp + 2], $6
	call    scan_pixel.2994
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 4], $5
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 7], $3
	add     $1, 2, $6
	cmp     $6, 5
	bl      scan_line.3000
	sub     $6, 5, $6
	b       scan_line.3000
.end scan_line

######################################################################
.begin create_pixel
create_pixel.3008:
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
	store   $1, [$17 + 4]
	mov     $hp, $1
	add     $hp, 8, $hp
	store   $17, [$1 + 7]
	store   $16, [$1 + 6]
	store   $15, [$1 + 5]
	store   $14, [$1 + 4]
	store   $13, [$1 + 3]
	store   $12, [$1 + 2]
	store   $11, [$1 + 1]
	store   $10, [$1 + 0]
	ret
.end create_pixel

######################################################################
.begin init_line_elements
init_line_elements.3010:
	cmp     $3, 0
	bl      bge_else.36908
bge_then.36908:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $11, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	mov     $14, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	mov     $15, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	mov     $17, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $19
	store   $19, [$17 + 4]
	mov     $hp, $19
	add     $hp, 8, $hp
	store   $17, [$19 + 7]
	store   $16, [$19 + 6]
	store   $15, [$19 + 5]
	store   $14, [$19 + 4]
	store   $13, [$19 + 3]
	store   $12, [$19 + 2]
	store   $11, [$19 + 1]
	store   $10, [$19 + 0]
.count stack_load
	load    [$sp + 0], $20
.count stack_load
	load    [$sp + 1], $21
.count storer
	add     $21, $20, $tmp
	store   $19, [$tmp + 0]
	sub     $20, 1, $19
	cmp     $19, 0
	bl      bge_else.36909
bge_then.36909:
	call    create_pixel.3008
.count move_ret
	mov     $1, $10
.count storer
	add     $21, $19, $tmp
	li      3, $2
	store   $10, [$tmp + 0]
	sub     $19, 1, $10
	cmp     $10, 0
	bl      bge_else.36910
bge_then.36910:
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	store   $13, [$12 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	store   $13, [$12 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	store   $13, [$12 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	store   $13, [$12 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	store   $17, [$16 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	store   $17, [$16 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	store   $17, [$16 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	store   $17, [$16 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $19
	store   $19, [$18 + 4]
	mov     $hp, $19
	add     $hp, 8, $hp
	store   $18, [$19 + 7]
	store   $17, [$19 + 6]
	store   $16, [$19 + 5]
	store   $15, [$19 + 4]
	store   $14, [$19 + 3]
	store   $13, [$19 + 2]
	store   $12, [$19 + 1]
	store   $11, [$19 + 0]
.count storer
	add     $21, $10, $tmp
	store   $19, [$tmp + 0]
	sub     $10, 1, $19
	cmp     $19, 0
	bl      bge_else.36911
bge_then.36911:
	call    create_pixel.3008
.count storer
	add     $21, $19, $tmp
.count stack_move
	add     $sp, 2, $sp
	store   $1, [$tmp + 0]
	sub     $19, 1, $3
.count move_args
	mov     $21, $2
	b       init_line_elements.3010
bge_else.36911:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.36910:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.36909:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.36908:
	mov     $2, $1
	ret
.end init_line_elements

######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	cmp     $2, 5
	bl      bge_else.36912
bge_then.36912:
	load    [min_caml_dirvecs + $7], $1
	fmul    $3, $3, $2
	fmul    $4, $4, $5
	load    [$1 + $8], $6
	add     $8, 40, $7
	add     $8, 1, $9
	load    [$6 + 0], $6
	fadd    $2, $5, $2
	fadd    $2, $36, $2
	fsqrt   $2, $2
	finv    $2, $2
	fmul    $3, $2, $3
	fmul    $4, $2, $4
	store   $2, [$6 + 2]
	store   $3, [$6 + 0]
	store   $4, [$6 + 1]
	load    [$1 + $7], $5
	fneg    $4, $6
	add     $8, 80, $7
	load    [$5 + 0], $5
	store   $3, [$5 + 0]
	store   $2, [$5 + 1]
	store   $6, [$5 + 2]
	load    [$1 + $7], $5
	fneg    $3, $7
	load    [$5 + 0], $5
	store   $2, [$5 + 0]
	store   $7, [$5 + 1]
	store   $6, [$5 + 2]
	load    [$1 + $9], $5
	fneg    $2, $2
	add     $8, 41, $9
	load    [$5 + 0], $5
	store   $7, [$5 + 0]
	store   $6, [$5 + 1]
	store   $2, [$5 + 2]
	load    [$1 + $9], $5
	add     $8, 81, $6
	load    [$5 + 0], $5
	store   $7, [$5 + 0]
	store   $2, [$5 + 1]
	store   $4, [$5 + 2]
	load    [$1 + $6], $1
	load    [$1 + 0], $1
	store   $2, [$1 + 0]
	store   $3, [$1 + 1]
	store   $4, [$1 + 2]
	ret
bge_else.36912:
	fmul    $4, $4, $11
.count stack_move
	sub     $sp, 7, $sp
.count load_float
	load    [f.31959], $12
.count stack_store
	store   $8, [$sp + 0]
.count stack_store
	store   $7, [$sp + 1]
	fadd    $11, $12, $11
.count stack_store
	store   $2, [$sp + 2]
.count stack_store
	store   $6, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
	fsqrt   $11, $11
	finv    $11, $2
	call    min_caml_atan
.count stack_load
	load    [$sp + 4], $14
.count move_ret
	mov     $1, $13
	fmul    $13, $14, $2
.count stack_store
	store   $2, [$sp + 5]
	call    min_caml_sin
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 5], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $15
	finv    $15, $15
	fmul    $13, $15, $13
	fmul    $13, $11, $11
	fmul    $11, $11, $13
	fadd    $13, $12, $12
	fsqrt   $12, $12
	finv    $12, $2
	call    min_caml_atan
.count stack_load
	load    [$sp + 3], $15
.count move_ret
	mov     $1, $13
	fmul    $13, $15, $2
.count stack_store
	store   $2, [$sp + 6]
	call    min_caml_sin
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 6], $2
	call    min_caml_cos
	finv    $1, $1
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $15, $6
.count stack_load
	load    [$sp - 5], $2
.count stack_load
	load    [$sp - 6], $7
	fmul    $13, $1, $1
	add     $2, 1, $2
.count stack_load
	load    [$sp - 7], $8
.count move_args
	mov     $14, $5
.count move_args
	mov     $11, $3
	fmul    $1, $12, $4
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	cmp     $2, 0
	bl      bge_else.36913
bge_then.36913:
.count stack_move
	sub     $sp, 11, $sp
	li      0, $10
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $5, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
.count stack_store
	store   $3, [$sp + 3]
	call    min_caml_float_of_int
.count load_float
	load    [f.32000], $17
.count move_ret
	mov     $1, $16
.count load_float
	load    [f.32001], $18
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 2], $7
.count stack_load
	load    [$sp + 1], $8
.count move_args
	mov     $zero, $4
	fsub    $16, $18, $5
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 1], $19
	li      0, $2
.count load_float
	load    [f.31959], $20
	add     $19, 2, $8
.count move_args
	mov     $zero, $4
.count stack_store
	store   $8, [$sp + 4]
	fadd    $16, $20, $5
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 2], $7
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $10
	sub     $10, 1, $2
	li      0, $10
	cmp     $2, 0
	bl      bge_else.36914
bge_then.36914:
.count stack_store
	store   $2, [$sp + 5]
.count stack_load
	load    [$sp + 2], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.36915
bge_then.36915:
	sub     $11, 5, $11
bge_cont.36915:
.count stack_store
	store   $11, [$sp + 6]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
	fsub    $16, $18, $5
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $20, $5
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 6], $7
.count stack_load
	load    [$sp + 4], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 5], $10
	sub     $10, 1, $2
	li      0, $10
	cmp     $2, 0
	bl      bge_else.36916
bge_then.36916:
.count stack_store
	store   $2, [$sp + 7]
.count stack_load
	load    [$sp + 6], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.36917
bge_then.36917:
	sub     $11, 5, $11
bge_cont.36917:
.count stack_store
	store   $11, [$sp + 8]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
	fsub    $16, $18, $5
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $20, $5
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 8], $7
.count stack_load
	load    [$sp + 4], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 7], $10
	sub     $10, 1, $2
	li      0, $10
	cmp     $2, 0
	bl      bge_else.36918
bge_then.36918:
.count stack_store
	store   $2, [$sp + 9]
.count stack_load
	load    [$sp + 8], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.36919
bge_then.36919:
	sub     $11, 5, $11
bge_cont.36919:
.count stack_store
	store   $11, [$sp + 10]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
	fsub    $16, $18, $5
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $20, $5
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 10], $7
.count stack_load
	load    [$sp + 4], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_move
	add     $sp, 11, $sp
.count move_args
	mov     $19, $5
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 8], $3
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $4
	cmp     $4, 5
	bl      calc_dirvecs.3028
	sub     $4, 5, $4
	b       calc_dirvecs.3028
bge_else.36918:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.36916:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.36914:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.36913:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	cmp     $2, 0
	bl      bge_else.36921
bge_then.36921:
.count stack_move
	sub     $sp, 20, $sp
	li      0, $10
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
.count load_float
	load    [f.32001], $11
.count load_float
	load    [f.32000], $12
	li      4, $2
.count stack_store
	store   $11, [$sp + 3]
.count stack_store
	store   $12, [$sp + 4]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $13
	fmul    $13, $12, $13
.count stack_store
	store   $13, [$sp + 5]
	fsub    $13, $11, $13
.count stack_store
	store   $13, [$sp + 6]
.count stack_load
	load    [$sp + 2], $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $12, $16
.count move_args
	mov     $13, $5
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	fsub    $16, $11, $6
.count stack_store
	store   $6, [$sp + 7]
.count stack_load
	load    [$sp + 1], $7
.count stack_load
	load    [$sp + 0], $8
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $16
	li      0, $2
.count load_float
	load    [f.31959], $17
	add     $16, 2, $8
.count move_args
	mov     $zero, $4
.count stack_store
	store   $8, [$sp + 8]
.count stack_load
	load    [$sp + 5], $18
.count move_args
	mov     $zero, $3
	fadd    $18, $17, $5
.count stack_store
	store   $5, [$sp + 9]
.count stack_load
	load    [$sp + 7], $6
.count stack_load
	load    [$sp + 1], $7
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 1], $11
	li      0, $10
	li      3, $2
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.36922
bge_then.36922:
	sub     $11, 5, $11
bge_cont.36922:
.count stack_store
	store   $11, [$sp + 10]
	call    min_caml_float_of_int
.count stack_load
	load    [$sp + 4], $19
.count move_ret
	mov     $1, $18
.count stack_load
	load    [$sp + 3], $20
	fmul    $18, $19, $18
.count move_args
	mov     $16, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $18, $20, $5
.count move_args
	mov     $10, $2
.count stack_store
	store   $5, [$sp + 11]
.count stack_load
	load    [$sp + 7], $6
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count stack_store
	store   $5, [$sp + 12]
.count stack_load
	load    [$sp + 7], $6
.count stack_load
	load    [$sp + 10], $7
.count stack_load
	load    [$sp + 8], $8
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 10], $11
	li      0, $10
	li      2, $2
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.36923
bge_then.36923:
	sub     $11, 5, $11
bge_cont.36923:
.count stack_store
	store   $11, [$sp + 13]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
	fmul    $18, $19, $18
.count stack_load
	load    [$sp + 7], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
	fsub    $18, $20, $5
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $18, $17, $5
.count stack_load
	load    [$sp + 7], $6
.count stack_load
	load    [$sp + 13], $7
.count stack_load
	load    [$sp + 8], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 13], $21
	li      1, $2
	add     $21, 1, $21
	cmp     $21, 5
	bl      bge_cont.36924
bge_then.36924:
	sub     $21, 5, $21
bge_cont.36924:
	mov     $21, $4
.count stack_load
	load    [$sp + 7], $3
.count move_args
	mov     $16, $5
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $2
.count stack_load
	load    [$sp + 1], $10
	cmp     $2, 0
	add     $10, 2, $10
	bl      bge_else.36925
bge_then.36925:
	cmp     $10, 5
.count stack_store
	store   $2, [$sp + 14]
	bl      bge_cont.36926
bge_then.36926:
	sub     $10, 5, $10
bge_cont.36926:
.count stack_store
	store   $10, [$sp + 15]
.count stack_load
	load    [$sp + 0], $11
	li      0, $12
	add     $11, 4, $11
.count stack_store
	store   $11, [$sp + 16]
	call    min_caml_float_of_int
.count stack_load
	load    [$sp + 4], $17
.count move_ret
	mov     $1, $16
.count move_args
	mov     $11, $8
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $17
.count move_args
	mov     $10, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $17, $6
.count move_args
	mov     $12, $2
.count stack_store
	store   $6, [$sp + 17]
.count stack_load
	load    [$sp + 6], $5
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 16], $16
	li      0, $2
.count move_args
	mov     $zero, $4
	add     $16, 2, $8
.count move_args
	mov     $zero, $3
.count stack_store
	store   $8, [$sp + 18]
.count stack_load
	load    [$sp + 9], $5
.count stack_load
	load    [$sp + 17], $6
.count stack_load
	load    [$sp + 15], $7
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 15], $17
	li      0, $2
	add     $17, 1, $17
	cmp     $17, 5
	bl      bge_cont.36927
bge_then.36927:
	sub     $17, 5, $17
bge_cont.36927:
	mov     $17, $7
.count stack_store
	store   $7, [$sp + 19]
.count stack_load
	load    [$sp + 11], $5
.count stack_load
	load    [$sp + 17], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	li      0, $2
.count stack_load
	load    [$sp + 12], $5
.count stack_load
	load    [$sp + 17], $6
.count stack_load
	load    [$sp + 19], $7
.count stack_load
	load    [$sp + 18], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 19], $21
	li      2, $2
	add     $21, 1, $21
	cmp     $21, 5
	bl      bge_cont.36928
bge_then.36928:
	sub     $21, 5, $21
bge_cont.36928:
	mov     $21, $4
.count stack_load
	load    [$sp + 17], $3
.count move_args
	mov     $16, $5
	call    calc_dirvecs.3028
.count stack_move
	add     $sp, 20, $sp
.count stack_load
	load    [$sp - 6], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 5], $1
	add     $1, 2, $3
.count stack_load
	load    [$sp - 4], $1
	cmp     $3, 5
	add     $1, 4, $4
	bl      bge_else.36929
bge_then.36929:
	sub     $3, 5, $3
	b       calc_dirvec_rows.3033
bge_else.36929:
	add     $1, 4, $4
	b       calc_dirvec_rows.3033
bge_else.36925:
.count stack_move
	add     $sp, 20, $sp
	ret
bge_else.36921:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	cmp     $3, 0
	bl      bge_else.36930
bge_then.36930:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
.count stack_store
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $hp, $11
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 2], $10
	add     $hp, 2, $hp
	li      3, $2
	store   $10, [$11 + 0]
	mov     $11, $10
.count stack_load
	load    [$sp + 0], $11
.count stack_load
	load    [$sp + 1], $12
.count storer
	add     $12, $11, $tmp
	store   $10, [$tmp + 0]
	sub     $11, 1, $10
	cmp     $10, 0
	bl      bge_else.36931
bge_then.36931:
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 3]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $hp, $13
	add     $hp, 2, $hp
	store   $11, [$13 + 1]
.count stack_load
	load    [$sp + 3], $11
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $10
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	li      3, $2
	bl      bge_else.36932
bge_then.36932:
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 4]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $hp, $13
	add     $hp, 2, $hp
	store   $11, [$13 + 1]
.count stack_load
	load    [$sp + 4], $11
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $10
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	li      3, $2
	bl      bge_else.36933
bge_then.36933:
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 5]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 6, $sp
	mov     $hp, $2
	store   $1, [$2 + 1]
.count stack_load
	load    [$sp - 1], $1
.count storer
	add     $12, $10, $tmp
	add     $hp, 2, $hp
	store   $1, [$2 + 0]
	mov     $2, $1
	store   $1, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $12, $2
	b       create_dirvec_elements.3039
bge_else.36933:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36932:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36931:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.36930:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	cmp     $2, 0
	bl      bge_else.36934
bge_then.36934:
.count stack_move
	sub     $sp, 9, $sp
.count move_args
	mov     $zero, $3
.count stack_store
	store   $2, [$sp + 0]
	li      3, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
.count stack_store
	store   $3, [$sp + 1]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $hp, $11
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 1], $10
	li      120, $2
	add     $hp, 2, $hp
	store   $10, [$11 + 0]
	mov     $11, $3
	call    min_caml_create_array
.count stack_load
	load    [$sp + 0], $11
.count move_ret
	mov     $1, $10
	li      3, $2
	store   $10, [min_caml_dirvecs + $11]
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $hp, $12
	load    [min_caml_dirvecs + $11], $11
	store   $10, [$12 + 1]
.count stack_load
	load    [$sp + 2], $10
	add     $hp, 2, $hp
	li      3, $2
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 118]
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 3]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $hp, $12
	store   $10, [$12 + 1]
.count stack_load
	load    [$sp + 3], $10
	add     $hp, 2, $hp
	li      3, $2
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 117]
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 4]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	mov     $hp, $15
	store   $14, [$15 + 1]
.count stack_load
	load    [$sp + 4], $14
	add     $hp, 2, $hp
	li      115, $3
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$11 + 116]
.count move_args
	mov     $11, $2
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $10
	li      3, $2
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.36935
bge_then.36935:
.count stack_store
	store   $10, [$sp + 5]
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 6]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $hp, $12
	store   $11, [$12 + 1]
.count stack_load
	load    [$sp + 6], $11
	li      120, $2
	add     $hp, 2, $hp
	store   $11, [$12 + 0]
	mov     $12, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $11, [min_caml_dirvecs + $10]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 7]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $hp, $12
	load    [min_caml_dirvecs + $10], $10
	store   $11, [$12 + 1]
.count stack_load
	load    [$sp + 7], $11
	add     $hp, 2, $hp
	li      3, $2
	store   $11, [$12 + 0]
	mov     $12, $11
	store   $11, [$10 + 118]
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 8]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	mov     $hp, $15
	store   $14, [$15 + 1]
.count stack_load
	load    [$sp + 8], $14
	add     $hp, 2, $hp
	li      116, $3
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$10 + 117]
.count move_args
	mov     $10, $2
	call    create_dirvec_elements.3039
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $1
	sub     $1, 1, $2
	b       create_dirvecs.3042
bge_else.36935:
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.36934:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	cmp     $3, 0
	bl      bge_else.36936
bge_then.36936:
.count stack_move
	sub     $sp, 4, $sp
	sub     $41, 1, $11
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
	load    [$2 + $3], $10
	cmp     $11, 0
	li      6, $2
	load    [$10 + 1], $12
	bl      bge_cont.36937
bge_then.36937:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $14
	li      4, $15
	load    [$13 + 1], $16
	li      5, $17
.count move_args
	mov     $zero, $3
	cmp     $16, 1
	bne     be_else.36938
be_then.36938:
	call    min_caml_create_array
	load    [$14 + 0], $18
.count move_ret
	mov     $1, $17
	load    [$13 + 6], $19
	fcmp    $18, $zero
	load    [$13 + 4], $20
	bne     be_else.36939
be_then.36939:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.36939
be_else.36939:
	fcmp    $zero, $18
	bg      ble_else.36940
ble_then.36940:
	li      0, $18
.count b_cont
	b       ble_cont.36940
ble_else.36940:
	li      1, $18
ble_cont.36940:
	cmp     $19, 0
	be      bne_cont.36941
bne_then.36941:
	cmp     $18, 0
	bne     be_else.36942
be_then.36942:
	li      1, $18
.count b_cont
	b       be_cont.36942
be_else.36942:
	li      0, $18
be_cont.36942:
bne_cont.36941:
	cmp     $18, 0
	load    [$20 + 0], $19
	bne     be_else.36943
be_then.36943:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.36943
be_else.36943:
	store   $19, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.36943:
be_cont.36939:
	load    [$14 + 1], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.36944
be_then.36944:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.36944
be_else.36944:
	fcmp    $zero, $18
	bg      ble_else.36945
ble_then.36945:
	li      0, $18
.count b_cont
	b       ble_cont.36945
ble_else.36945:
	li      1, $18
ble_cont.36945:
	cmp     $19, 0
	be      bne_cont.36946
bne_then.36946:
	cmp     $18, 0
	bne     be_else.36947
be_then.36947:
	li      1, $18
.count b_cont
	b       be_cont.36947
be_else.36947:
	li      0, $18
be_cont.36947:
bne_cont.36946:
	cmp     $18, 0
	load    [$20 + 1], $19
	bne     be_else.36948
be_then.36948:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.36948
be_else.36948:
	store   $19, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.36948:
be_cont.36944:
	load    [$14 + 2], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.36949
be_then.36949:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$17 + 5]
	store   $17, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36938
be_else.36949:
	fcmp    $zero, $18
	bg      ble_else.36950
ble_then.36950:
	li      0, $18
.count b_cont
	b       ble_cont.36950
ble_else.36950:
	li      1, $18
ble_cont.36950:
	cmp     $19, 0
	be      bne_cont.36951
bne_then.36951:
	cmp     $18, 0
	bne     be_else.36952
be_then.36952:
	li      1, $18
.count b_cont
	b       be_cont.36952
be_else.36952:
	li      0, $18
be_cont.36952:
bne_cont.36951:
	cmp     $18, 0
	load    [$20 + 2], $19
	bne     be_else.36953
be_then.36953:
	fneg    $19, $18
.count b_cont
	b       be_cont.36953
be_else.36953:
	mov     $19, $18
be_cont.36953:
	store   $18, [$17 + 4]
	load    [$14 + 2], $18
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
	finv    $18, $18
	store   $17, [$tmp + 0]
.count move_args
	mov     $10, $2
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36938
be_else.36938:
	cmp     $16, 2
	bne     be_else.36954
be_then.36954:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$14 + 0], $21
	load    [$18 + 0], $18
	load    [$14 + 1], $22
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$14 + 2], $21
	fmul    $22, $19, $19
	load    [$20 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $21, $20, $20
	fadd    $18, $19, $18
.count storer
	add     $12, $11, $tmp
	fadd    $18, $20, $18
	fcmp    $18, $zero
	bg      ble_else.36955
ble_then.36955:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36954
ble_else.36955:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$17 + 0]
	load    [$13 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 1]
	load    [$13 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 2]
	load    [$13 + 4], $19
	load    [$19 + 2], $19
	store   $17, [$tmp + 0]
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36954
be_else.36954:
.count move_args
	mov     $17, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 3], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$14 + 0], $22
	load    [$14 + 1], $23
	load    [$14 + 2], $24
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	fmul    $23, $24, $25
	load    [$13 + 9], $26
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	fmul    $24, $22, $24
	load    [$26 + 0], $20
	cmp     $18, 0
	load    [$13 + 9], $26
	fmul    $22, $23, $22
	fmul    $25, $20, $20
	fadd    $19, $21, $19
	be      bne_cont.36956
bne_then.36956:
	fadd    $19, $20, $19
	load    [$26 + 1], $20
	load    [$13 + 9], $21
	fmul    $24, $20, $20
	load    [$21 + 2], $21
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
bne_cont.36956:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$14 + 0], $23
	load    [$20 + 0], $20
	load    [$14 + 1], $24
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$14 + 2], $23
	load    [$22 + 2], $22
	fmul    $24, $21, $21
	load    [$13 + 9], $25
	fmul    $23, $22, $22
	fneg    $20, $20
	load    [$13 + 9], $26
	cmp     $18, 0
	fneg    $21, $21
	load    [$25 + 1], $25
	fneg    $22, $22
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.36957
be_then.36957:
	fcmp    $19, $zero
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	store   $17, [$tmp + 0]
	bne     be_else.36958
be_then.36958:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36957
be_else.36958:
	finv    $19, $18
	store   $18, [$17 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36957
be_else.36957:
	fmul    $23, $25, $18
	load    [$26 + 2], $23
	fcmp    $19, $zero
	fmul    $24, $23, $24
	fadd    $18, $24, $18
	fmul    $18, $39, $18
	fsub    $20, $18, $18
	store   $18, [$17 + 1]
	load    [$13 + 9], $18
	load    [$14 + 2], $20
	load    [$14 + 0], $24
	load    [$18 + 0], $18
	fmul    $24, $23, $23
	fmul    $20, $18, $20
	fadd    $20, $23, $20
	finv    $19, $23
	fmul    $20, $39, $20
	fsub    $21, $20, $20
	store   $20, [$17 + 2]
	load    [$14 + 1], $20
	load    [$14 + 0], $21
	fmul    $20, $18, $18
	fmul    $21, $25, $20
	fadd    $18, $20, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.36959
be_then.36959:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36959
be_else.36959:
	store   $23, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36959:
be_cont.36957:
be_cont.36954:
be_cont.36938:
bge_cont.36937:
.count stack_load
	load    [$sp + 1], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.36960
bge_then.36960:
.count stack_store
	store   $10, [$sp + 2]
	sub     $41, 1, $11
.count stack_load
	load    [$sp + 0], $12
	cmp     $11, 0
	load    [$12 + $10], $10
	bl      bge_cont.36961
bge_then.36961:
	load    [min_caml_objects + $11], $13
	load    [$10 + 1], $12
	load    [$10 + 0], $14
	load    [$13 + 1], $15
	li      6, $2
	li      4, $16
	cmp     $15, 1
	li      5, $17
.count move_args
	mov     $zero, $3
	bne     be_else.36962
be_then.36962:
	call    min_caml_create_array
	load    [$14 + 0], $18
.count move_ret
	mov     $1, $17
	load    [$13 + 6], $19
	fcmp    $18, $zero
	load    [$13 + 4], $20
	bne     be_else.36963
be_then.36963:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.36963
be_else.36963:
	fcmp    $zero, $18
	bg      ble_else.36964
ble_then.36964:
	li      0, $18
.count b_cont
	b       ble_cont.36964
ble_else.36964:
	li      1, $18
ble_cont.36964:
	cmp     $19, 0
	be      bne_cont.36965
bne_then.36965:
	cmp     $18, 0
	bne     be_else.36966
be_then.36966:
	li      1, $18
.count b_cont
	b       be_cont.36966
be_else.36966:
	li      0, $18
be_cont.36966:
bne_cont.36965:
	cmp     $18, 0
	load    [$20 + 0], $19
	bne     be_else.36967
be_then.36967:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.36967
be_else.36967:
	store   $19, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.36967:
be_cont.36963:
	load    [$14 + 1], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.36968
be_then.36968:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.36968
be_else.36968:
	fcmp    $zero, $18
	bg      ble_else.36969
ble_then.36969:
	li      0, $18
.count b_cont
	b       ble_cont.36969
ble_else.36969:
	li      1, $18
ble_cont.36969:
	cmp     $19, 0
	be      bne_cont.36970
bne_then.36970:
	cmp     $18, 0
	bne     be_else.36971
be_then.36971:
	li      1, $18
.count b_cont
	b       be_cont.36971
be_else.36971:
	li      0, $18
be_cont.36971:
bne_cont.36970:
	cmp     $18, 0
	load    [$20 + 1], $19
	bne     be_else.36972
be_then.36972:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.36972
be_else.36972:
	store   $19, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.36972:
be_cont.36968:
	load    [$14 + 2], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.36973
be_then.36973:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$17 + 5]
	store   $17, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36962
be_else.36973:
	fcmp    $zero, $18
	bg      ble_else.36974
ble_then.36974:
	li      0, $18
.count b_cont
	b       ble_cont.36974
ble_else.36974:
	li      1, $18
ble_cont.36974:
	cmp     $19, 0
	be      bne_cont.36975
bne_then.36975:
	cmp     $18, 0
	bne     be_else.36976
be_then.36976:
	li      1, $18
.count b_cont
	b       be_cont.36976
be_else.36976:
	li      0, $18
be_cont.36976:
bne_cont.36975:
	cmp     $18, 0
	load    [$20 + 2], $19
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.36977
be_then.36977:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$14 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36962
be_else.36977:
	store   $19, [$17 + 4]
	load    [$14 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36962
be_else.36962:
	cmp     $15, 2
	bne     be_else.36978
be_then.36978:
.count move_args
	mov     $16, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$14 + 0], $21
	load    [$18 + 0], $18
	load    [$14 + 1], $22
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$14 + 2], $21
	fmul    $22, $19, $19
	load    [$20 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $21, $20, $20
	fadd    $18, $19, $18
.count storer
	add     $12, $11, $tmp
	fadd    $18, $20, $18
	fcmp    $18, $zero
	bg      ble_else.36979
ble_then.36979:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36978
ble_else.36979:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$17 + 0]
	load    [$13 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 1]
	load    [$13 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 2]
	load    [$13 + 4], $19
	load    [$19 + 2], $19
	store   $17, [$tmp + 0]
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36978
be_else.36978:
.count move_args
	mov     $17, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 3], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$14 + 0], $22
	load    [$14 + 1], $23
	load    [$14 + 2], $24
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	fmul    $23, $24, $25
	load    [$13 + 9], $26
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	fmul    $24, $22, $24
	load    [$26 + 0], $20
	cmp     $18, 0
	load    [$13 + 9], $26
	fmul    $22, $23, $22
	fmul    $25, $20, $20
	fadd    $19, $21, $19
	be      bne_cont.36980
bne_then.36980:
	fadd    $19, $20, $19
	load    [$26 + 1], $20
	load    [$13 + 9], $21
	fmul    $24, $20, $20
	load    [$21 + 2], $21
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
bne_cont.36980:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$14 + 0], $23
	load    [$20 + 0], $20
	load    [$14 + 1], $24
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$14 + 2], $23
	load    [$22 + 2], $22
	fmul    $24, $21, $21
	load    [$13 + 9], $25
	fmul    $23, $22, $22
	fneg    $20, $20
	load    [$13 + 9], $26
	cmp     $18, 0
	fneg    $21, $21
	load    [$25 + 1], $25
	fneg    $22, $22
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.36981
be_then.36981:
	fcmp    $19, $zero
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	store   $17, [$tmp + 0]
	bne     be_else.36982
be_then.36982:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36981
be_else.36982:
	finv    $19, $18
	store   $18, [$17 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36981
be_else.36981:
	fmul    $23, $25, $18
	load    [$26 + 2], $23
	fcmp    $19, $zero
	fmul    $24, $23, $24
	fadd    $18, $24, $18
	fmul    $18, $39, $18
	fsub    $20, $18, $18
	store   $18, [$17 + 1]
	load    [$13 + 9], $18
	load    [$14 + 2], $20
	load    [$14 + 0], $24
	load    [$18 + 0], $18
	fmul    $24, $23, $23
	fmul    $20, $18, $20
	fadd    $20, $23, $20
	finv    $19, $23
	fmul    $20, $39, $20
	fsub    $21, $20, $20
	store   $20, [$17 + 2]
	load    [$14 + 1], $20
	load    [$14 + 0], $21
	fmul    $20, $18, $18
	fmul    $21, $25, $20
	fadd    $18, $20, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.36983
be_then.36983:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.36983
be_else.36983:
	store   $23, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.36983:
be_cont.36981:
be_cont.36978:
be_cont.36962:
bge_cont.36961:
.count stack_load
	load    [$sp + 2], $17
	sub     $17, 1, $17
	cmp     $17, 0
	bl      bge_else.36984
bge_then.36984:
.count stack_load
	load    [$sp + 0], $18
	sub     $41, 1, $3
	load    [$18 + $17], $2
	call    iter_setup_dirvec_constants.2826
	sub     $17, 1, $10
	cmp     $10, 0
	bl      bge_else.36985
bge_then.36985:
	sub     $41, 1, $11
	load    [$18 + $10], $12
	cmp     $11, 0
	bl      bge_else.36986
bge_then.36986:
	load    [min_caml_objects + $11], $14
	load    [$12 + 1], $13
	load    [$12 + 0], $15
	load    [$14 + 1], $16
	li      6, $2
	li      4, $17
	cmp     $16, 1
	li      5, $19
.count stack_store
	store   $10, [$sp + 3]
.count move_args
	mov     $zero, $3
	bne     be_else.36987
be_then.36987:
	call    min_caml_create_array
	load    [$15 + 0], $19
.count move_ret
	mov     $1, $17
	load    [$14 + 6], $20
	fcmp    $19, $zero
	load    [$14 + 4], $21
	bne     be_else.36988
be_then.36988:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.36988
be_else.36988:
	fcmp    $zero, $19
	bg      ble_else.36989
ble_then.36989:
	li      0, $19
.count b_cont
	b       ble_cont.36989
ble_else.36989:
	li      1, $19
ble_cont.36989:
	cmp     $20, 0
	be      bne_cont.36990
bne_then.36990:
	cmp     $19, 0
	bne     be_else.36991
be_then.36991:
	li      1, $19
.count b_cont
	b       be_cont.36991
be_else.36991:
	li      0, $19
be_cont.36991:
bne_cont.36990:
	cmp     $19, 0
	load    [$21 + 0], $20
	bne     be_else.36992
be_then.36992:
	fneg    $20, $19
	store   $19, [$17 + 0]
	load    [$15 + 0], $19
	finv    $19, $19
	store   $19, [$17 + 1]
.count b_cont
	b       be_cont.36992
be_else.36992:
	store   $20, [$17 + 0]
	load    [$15 + 0], $19
	finv    $19, $19
	store   $19, [$17 + 1]
be_cont.36992:
be_cont.36988:
	load    [$15 + 1], $19
	load    [$14 + 6], $20
	load    [$14 + 4], $21
	fcmp    $19, $zero
	bne     be_else.36993
be_then.36993:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.36993
be_else.36993:
	fcmp    $zero, $19
	bg      ble_else.36994
ble_then.36994:
	li      0, $19
.count b_cont
	b       ble_cont.36994
ble_else.36994:
	li      1, $19
ble_cont.36994:
	cmp     $20, 0
	be      bne_cont.36995
bne_then.36995:
	cmp     $19, 0
	bne     be_else.36996
be_then.36996:
	li      1, $19
.count b_cont
	b       be_cont.36996
be_else.36996:
	li      0, $19
be_cont.36996:
bne_cont.36995:
	cmp     $19, 0
	load    [$21 + 1], $20
	bne     be_else.36997
be_then.36997:
	fneg    $20, $19
	store   $19, [$17 + 2]
	load    [$15 + 1], $19
	finv    $19, $19
	store   $19, [$17 + 3]
.count b_cont
	b       be_cont.36997
be_else.36997:
	store   $20, [$17 + 2]
	load    [$15 + 1], $19
	finv    $19, $19
	store   $19, [$17 + 3]
be_cont.36997:
be_cont.36993:
	load    [$15 + 2], $19
	load    [$14 + 6], $20
	load    [$14 + 4], $21
	fcmp    $19, $zero
	bne     be_else.36998
be_then.36998:
	store   $zero, [$17 + 5]
.count b_cont
	b       be_cont.36998
be_else.36998:
	fcmp    $zero, $19
	bg      ble_else.36999
ble_then.36999:
	li      0, $19
.count b_cont
	b       ble_cont.36999
ble_else.36999:
	li      1, $19
ble_cont.36999:
	cmp     $20, 0
	be      bne_cont.37000
bne_then.37000:
	cmp     $19, 0
	bne     be_else.37001
be_then.37001:
	li      1, $19
.count b_cont
	b       be_cont.37001
be_else.37001:
	li      0, $19
be_cont.37001:
bne_cont.37000:
	cmp     $19, 0
	load    [$21 + 2], $20
	bne     be_else.37002
be_then.37002:
	fneg    $20, $19
	store   $19, [$17 + 4]
	load    [$15 + 2], $19
	finv    $19, $19
	store   $19, [$17 + 5]
.count b_cont
	b       be_cont.37002
be_else.37002:
	store   $20, [$17 + 4]
	load    [$15 + 2], $19
	finv    $19, $19
	store   $19, [$17 + 5]
be_cont.37002:
be_cont.36998:
.count storer
	add     $13, $11, $tmp
	sub     $11, 1, $3
	store   $17, [$tmp + 0]
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $18, $2
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
be_else.36987:
	cmp     $16, 2
	bne     be_else.37003
be_then.37003:
.count move_args
	mov     $17, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$15 + 0], $22
	load    [$19 + 0], $19
	load    [$15 + 1], $23
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$15 + 2], $22
	fmul    $23, $20, $20
	load    [$21 + 2], $21
.count storer
	add     $13, $11, $tmp
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
	fcmp    $19, $zero
	bg      ble_else.37004
ble_then.37004:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
.count b_cont
	b       be_cont.37003
ble_else.37004:
	finv    $19, $19
	fneg    $19, $20
	store   $20, [$17 + 0]
	load    [$14 + 4], $20
	load    [$20 + 0], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$17 + 1]
	load    [$14 + 4], $20
	load    [$20 + 1], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$17 + 2]
	load    [$14 + 4], $20
	load    [$20 + 2], $20
	fmul    $20, $19, $19
	fneg    $19, $19
	store   $19, [$17 + 3]
	store   $17, [$tmp + 0]
.count b_cont
	b       be_cont.37003
be_else.37003:
.count move_args
	mov     $19, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$14 + 3], $19
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$14 + 4], $22
	load    [$15 + 0], $23
	load    [$15 + 1], $24
	load    [$15 + 2], $25
	fmul    $23, $23, $26
	fmul    $24, $24, $27
	load    [$20 + 0], $20
	load    [$21 + 1], $21
	fmul    $25, $25, $28
	fmul    $26, $20, $20
	fmul    $27, $21, $21
	load    [$22 + 2], $22
	fmul    $24, $25, $26
	load    [$14 + 9], $27
	fmul    $28, $22, $22
	fadd    $20, $21, $20
	fmul    $25, $23, $25
	load    [$27 + 0], $21
	cmp     $19, 0
	load    [$14 + 9], $27
	fmul    $23, $24, $23
	fmul    $26, $21, $21
	fadd    $20, $22, $20
	be      bne_cont.37005
bne_then.37005:
	fadd    $20, $21, $20
	load    [$27 + 1], $21
	load    [$14 + 9], $22
	fmul    $25, $21, $21
	load    [$22 + 2], $22
	fmul    $23, $22, $22
	fadd    $20, $21, $20
	fadd    $20, $22, $20
bne_cont.37005:
	store   $20, [$17 + 0]
	load    [$14 + 4], $21
	load    [$14 + 4], $22
	load    [$14 + 4], $23
	load    [$15 + 0], $24
	load    [$21 + 0], $21
	load    [$15 + 1], $25
	load    [$22 + 1], $22
	fmul    $24, $21, $21
	load    [$15 + 2], $24
	load    [$23 + 2], $23
	fmul    $25, $22, $22
	load    [$14 + 9], $26
	fmul    $24, $23, $23
	fneg    $21, $21
	load    [$14 + 9], $27
	cmp     $19, 0
	fneg    $22, $22
	load    [$26 + 1], $26
	fneg    $23, $23
.count storer
	add     $13, $11, $tmp
	bne     be_else.37006
be_then.37006:
	fcmp    $20, $zero
	store   $21, [$17 + 1]
	store   $22, [$17 + 2]
	store   $23, [$17 + 3]
	bne     be_else.37007
be_then.37007:
	store   $17, [$tmp + 0]
.count b_cont
	b       be_cont.37006
be_else.37007:
	finv    $20, $19
	store   $19, [$17 + 4]
	store   $17, [$tmp + 0]
.count b_cont
	b       be_cont.37006
be_else.37006:
	fmul    $24, $26, $19
	load    [$27 + 2], $24
	fcmp    $20, $zero
	fmul    $25, $24, $25
	fadd    $19, $25, $19
	fmul    $19, $39, $19
	fsub    $21, $19, $19
	store   $19, [$17 + 1]
	load    [$14 + 9], $19
	load    [$15 + 2], $21
	load    [$15 + 0], $25
	load    [$19 + 0], $19
	fmul    $25, $24, $24
	fmul    $21, $19, $21
	fadd    $21, $24, $21
	finv    $20, $24
	fmul    $21, $39, $21
	fsub    $22, $21, $21
	store   $21, [$17 + 2]
	load    [$15 + 1], $21
	load    [$15 + 0], $22
	fmul    $21, $19, $19
	fmul    $22, $26, $21
	fadd    $19, $21, $19
	fmul    $19, $39, $19
	fsub    $23, $19, $19
	store   $19, [$17 + 3]
	bne     be_else.37008
be_then.37008:
	store   $17, [$tmp + 0]
.count b_cont
	b       be_cont.37008
be_else.37008:
	store   $24, [$17 + 4]
	store   $17, [$tmp + 0]
be_cont.37008:
be_cont.37006:
be_cont.37003:
	sub     $11, 1, $3
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $18, $2
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
bge_else.36986:
.count stack_move
	add     $sp, 4, $sp
	sub     $10, 1, $3
.count move_args
	mov     $18, $2
	b       init_dirvec_constants.3044
bge_else.36985:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.36984:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.36960:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.36936:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	cmp     $2, 0
	bl      bge_else.37009
bge_then.37009:
.count stack_move
	sub     $sp, 5, $sp
	sub     $41, 1, $11
.count stack_store
	store   $2, [$sp + 0]
	load    [min_caml_dirvecs + $2], $10
	li      6, $2
	cmp     $11, 0
.count stack_store
	store   $10, [$sp + 1]
	load    [$10 + 119], $10
	bl      bge_cont.37010
bge_then.37010:
	load    [min_caml_objects + $11], $13
	load    [$10 + 1], $12
	load    [$10 + 0], $14
	load    [$13 + 1], $16
	li      4, $15
	li      5, $17
	cmp     $16, 1
.count move_args
	mov     $zero, $3
	bne     be_else.37011
be_then.37011:
	call    min_caml_create_array
	load    [$14 + 0], $18
.count move_ret
	mov     $1, $17
	load    [$13 + 6], $19
	fcmp    $18, $zero
	load    [$13 + 4], $20
	bne     be_else.37012
be_then.37012:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.37012
be_else.37012:
	fcmp    $zero, $18
	bg      ble_else.37013
ble_then.37013:
	li      0, $18
.count b_cont
	b       ble_cont.37013
ble_else.37013:
	li      1, $18
ble_cont.37013:
	cmp     $19, 0
	be      bne_cont.37014
bne_then.37014:
	cmp     $18, 0
	bne     be_else.37015
be_then.37015:
	li      1, $18
.count b_cont
	b       be_cont.37015
be_else.37015:
	li      0, $18
be_cont.37015:
bne_cont.37014:
	cmp     $18, 0
	load    [$20 + 0], $19
	bne     be_else.37016
be_then.37016:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.37016
be_else.37016:
	store   $19, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.37016:
be_cont.37012:
	load    [$14 + 1], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37017
be_then.37017:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.37017
be_else.37017:
	fcmp    $zero, $18
	bg      ble_else.37018
ble_then.37018:
	li      0, $18
.count b_cont
	b       ble_cont.37018
ble_else.37018:
	li      1, $18
ble_cont.37018:
	cmp     $19, 0
	be      bne_cont.37019
bne_then.37019:
	cmp     $18, 0
	bne     be_else.37020
be_then.37020:
	li      1, $18
.count b_cont
	b       be_cont.37020
be_else.37020:
	li      0, $18
be_cont.37020:
bne_cont.37019:
	cmp     $18, 0
	load    [$20 + 1], $19
	bne     be_else.37021
be_then.37021:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.37021
be_else.37021:
	store   $19, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.37021:
be_cont.37017:
	load    [$14 + 2], $18
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37022
be_then.37022:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$17 + 5]
	store   $17, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37011
be_else.37022:
	fcmp    $zero, $18
	bg      ble_else.37023
ble_then.37023:
	li      0, $18
.count b_cont
	b       ble_cont.37023
ble_else.37023:
	li      1, $18
ble_cont.37023:
	cmp     $19, 0
	be      bne_cont.37024
bne_then.37024:
	cmp     $18, 0
	bne     be_else.37025
be_then.37025:
	li      1, $18
.count b_cont
	b       be_cont.37025
be_else.37025:
	li      0, $18
be_cont.37025:
bne_cont.37024:
	cmp     $18, 0
	load    [$20 + 2], $19
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.37026
be_then.37026:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$14 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37011
be_else.37026:
	store   $19, [$17 + 4]
	load    [$14 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37011
be_else.37011:
	cmp     $16, 2
	bne     be_else.37027
be_then.37027:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$14 + 0], $21
	load    [$18 + 0], $18
	load    [$14 + 1], $22
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$14 + 2], $21
	fmul    $22, $19, $19
	load    [$20 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $21, $20, $20
	fadd    $18, $19, $18
.count storer
	add     $12, $11, $tmp
	fadd    $18, $20, $18
	fcmp    $18, $zero
	bg      ble_else.37028
ble_then.37028:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37027
ble_else.37028:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$17 + 0]
	load    [$13 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 1]
	load    [$13 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 2]
	load    [$13 + 4], $19
	load    [$19 + 2], $19
	store   $17, [$tmp + 0]
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37027
be_else.37027:
.count move_args
	mov     $17, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 3], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$14 + 0], $22
	load    [$14 + 1], $23
	load    [$14 + 2], $24
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	fmul    $23, $24, $25
	load    [$13 + 9], $26
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	fmul    $24, $22, $24
	load    [$26 + 0], $20
	cmp     $18, 0
	load    [$13 + 9], $26
	fmul    $22, $23, $22
	fmul    $25, $20, $20
	fadd    $19, $21, $19
	be      bne_cont.37029
bne_then.37029:
	fadd    $19, $20, $19
	load    [$26 + 1], $20
	load    [$13 + 9], $21
	fmul    $24, $20, $20
	load    [$21 + 2], $21
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
bne_cont.37029:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$14 + 0], $23
	load    [$20 + 0], $20
	load    [$14 + 1], $24
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$14 + 2], $23
	load    [$22 + 2], $22
	fmul    $24, $21, $21
	load    [$13 + 9], $25
	fmul    $23, $22, $22
	fneg    $20, $20
	load    [$13 + 9], $26
	cmp     $18, 0
	fneg    $21, $21
	load    [$25 + 1], $25
	fneg    $22, $22
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.37030
be_then.37030:
	fcmp    $19, $zero
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	store   $17, [$tmp + 0]
	bne     be_else.37031
be_then.37031:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37030
be_else.37031:
	finv    $19, $18
	store   $18, [$17 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37030
be_else.37030:
	fmul    $23, $25, $18
	load    [$26 + 2], $23
	fcmp    $19, $zero
	fmul    $24, $23, $24
	fadd    $18, $24, $18
	fmul    $18, $39, $18
	fsub    $20, $18, $18
	store   $18, [$17 + 1]
	load    [$13 + 9], $18
	load    [$14 + 2], $20
	load    [$14 + 0], $24
	load    [$18 + 0], $18
	fmul    $24, $23, $23
	fmul    $20, $18, $20
	fadd    $20, $23, $20
	finv    $19, $23
	fmul    $20, $39, $20
	fsub    $21, $20, $20
	store   $20, [$17 + 2]
	load    [$14 + 1], $20
	load    [$14 + 0], $21
	fmul    $20, $18, $18
	fmul    $21, $25, $20
	fadd    $18, $20, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.37032
be_then.37032:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37032
be_else.37032:
	store   $23, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.37032:
be_cont.37030:
be_cont.37027:
be_cont.37011:
bge_cont.37010:
.count stack_load
	load    [$sp + 1], $17
	sub     $41, 1, $3
	load    [$17 + 118], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $11
	load    [$17 + 117], $10
	cmp     $11, 0
	li      6, $2
	load    [$10 + 1], $12
	bl      bge_cont.37033
bge_then.37033:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $14
	li      4, $15
	load    [$13 + 1], $16
	li      5, $18
.count move_args
	mov     $zero, $3
	cmp     $16, 1
	bne     be_else.37034
be_then.37034:
	call    min_caml_create_array
	load    [$14 + 0], $19
.count move_ret
	mov     $1, $18
	load    [$13 + 6], $20
	fcmp    $19, $zero
	load    [$13 + 4], $21
	bne     be_else.37035
be_then.37035:
	store   $zero, [$18 + 1]
.count b_cont
	b       be_cont.37035
be_else.37035:
	fcmp    $zero, $19
	bg      ble_else.37036
ble_then.37036:
	li      0, $19
.count b_cont
	b       ble_cont.37036
ble_else.37036:
	li      1, $19
ble_cont.37036:
	cmp     $20, 0
	be      bne_cont.37037
bne_then.37037:
	cmp     $19, 0
	bne     be_else.37038
be_then.37038:
	li      1, $19
.count b_cont
	b       be_cont.37038
be_else.37038:
	li      0, $19
be_cont.37038:
bne_cont.37037:
	cmp     $19, 0
	load    [$21 + 0], $20
	bne     be_else.37039
be_then.37039:
	fneg    $20, $19
	store   $19, [$18 + 0]
	load    [$14 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
.count b_cont
	b       be_cont.37039
be_else.37039:
	store   $20, [$18 + 0]
	load    [$14 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
be_cont.37039:
be_cont.37035:
	load    [$14 + 1], $19
	load    [$13 + 6], $20
	load    [$13 + 4], $21
	fcmp    $19, $zero
	bne     be_else.37040
be_then.37040:
	store   $zero, [$18 + 3]
.count b_cont
	b       be_cont.37040
be_else.37040:
	fcmp    $zero, $19
	bg      ble_else.37041
ble_then.37041:
	li      0, $19
.count b_cont
	b       ble_cont.37041
ble_else.37041:
	li      1, $19
ble_cont.37041:
	cmp     $20, 0
	be      bne_cont.37042
bne_then.37042:
	cmp     $19, 0
	bne     be_else.37043
be_then.37043:
	li      1, $19
.count b_cont
	b       be_cont.37043
be_else.37043:
	li      0, $19
be_cont.37043:
bne_cont.37042:
	cmp     $19, 0
	load    [$21 + 1], $20
	bne     be_else.37044
be_then.37044:
	fneg    $20, $19
	store   $19, [$18 + 2]
	load    [$14 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
.count b_cont
	b       be_cont.37044
be_else.37044:
	store   $20, [$18 + 2]
	load    [$14 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
be_cont.37044:
be_cont.37040:
	load    [$14 + 2], $19
	load    [$13 + 6], $20
	load    [$13 + 4], $21
	fcmp    $19, $zero
	bne     be_else.37045
be_then.37045:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$18 + 5]
	store   $18, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37034
be_else.37045:
	fcmp    $zero, $19
	bg      ble_else.37046
ble_then.37046:
	li      0, $19
.count b_cont
	b       ble_cont.37046
ble_else.37046:
	li      1, $19
ble_cont.37046:
	cmp     $20, 0
	be      bne_cont.37047
bne_then.37047:
	cmp     $19, 0
	bne     be_else.37048
be_then.37048:
	li      1, $19
.count b_cont
	b       be_cont.37048
be_else.37048:
	li      0, $19
be_cont.37048:
bne_cont.37047:
	cmp     $19, 0
	load    [$21 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.37049
be_then.37049:
	fneg    $20, $19
	store   $19, [$18 + 4]
	load    [$14 + 2], $19
	store   $18, [$tmp + 0]
	finv    $19, $19
	store   $19, [$18 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37034
be_else.37049:
	store   $20, [$18 + 4]
	load    [$14 + 2], $19
	store   $18, [$tmp + 0]
	finv    $19, $19
	store   $19, [$18 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37034
be_else.37034:
	cmp     $16, 2
	bne     be_else.37050
be_then.37050:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$14 + 0], $22
	load    [$19 + 0], $19
	load    [$14 + 1], $23
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$14 + 2], $22
	fmul    $23, $20, $20
	load    [$21 + 2], $21
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $22, $21, $21
	fadd    $19, $20, $19
.count storer
	add     $12, $11, $tmp
	fadd    $19, $21, $19
	fcmp    $19, $zero
	bg      ble_else.37051
ble_then.37051:
	store   $zero, [$18 + 0]
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37050
ble_else.37051:
	finv    $19, $19
	fneg    $19, $20
	store   $20, [$18 + 0]
	load    [$13 + 4], $20
	load    [$20 + 0], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 1]
	load    [$13 + 4], $20
	load    [$20 + 1], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 2]
	load    [$13 + 4], $20
	load    [$20 + 2], $20
	store   $18, [$tmp + 0]
	fmul    $20, $19, $19
	fneg    $19, $19
	store   $19, [$18 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37050
be_else.37050:
.count move_args
	mov     $18, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$13 + 3], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$14 + 0], $23
	load    [$14 + 1], $24
	load    [$14 + 2], $25
	fmul    $23, $23, $26
	fmul    $24, $24, $27
	load    [$20 + 0], $20
	load    [$21 + 1], $21
	fmul    $25, $25, $28
	fmul    $26, $20, $20
	fmul    $27, $21, $21
	load    [$22 + 2], $22
	fmul    $24, $25, $26
	load    [$13 + 9], $27
	fmul    $28, $22, $22
	fadd    $20, $21, $20
	fmul    $25, $23, $25
	load    [$27 + 0], $21
	cmp     $19, 0
	load    [$13 + 9], $27
	fmul    $23, $24, $23
	fmul    $26, $21, $21
	fadd    $20, $22, $20
	be      bne_cont.37052
bne_then.37052:
	fadd    $20, $21, $20
	load    [$27 + 1], $21
	load    [$13 + 9], $22
	fmul    $25, $21, $21
	load    [$22 + 2], $22
	fmul    $23, $22, $22
	fadd    $20, $21, $20
	fadd    $20, $22, $20
bne_cont.37052:
	store   $20, [$18 + 0]
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$13 + 4], $23
	load    [$14 + 0], $24
	load    [$21 + 0], $21
	load    [$14 + 1], $25
	load    [$22 + 1], $22
	fmul    $24, $21, $21
	load    [$14 + 2], $24
	load    [$23 + 2], $23
	fmul    $25, $22, $22
	load    [$13 + 9], $26
	fmul    $24, $23, $23
	fneg    $21, $21
	load    [$13 + 9], $27
	cmp     $19, 0
	fneg    $22, $22
	load    [$26 + 1], $26
	fneg    $23, $23
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.37053
be_then.37053:
	fcmp    $20, $zero
	store   $21, [$18 + 1]
	store   $22, [$18 + 2]
	store   $23, [$18 + 3]
	store   $18, [$tmp + 0]
	bne     be_else.37054
be_then.37054:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37053
be_else.37054:
	finv    $20, $19
	store   $19, [$18 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37053
be_else.37053:
	fmul    $24, $26, $19
	load    [$27 + 2], $24
	fcmp    $20, $zero
	fmul    $25, $24, $25
	fadd    $19, $25, $19
	fmul    $19, $39, $19
	fsub    $21, $19, $19
	store   $19, [$18 + 1]
	load    [$13 + 9], $19
	load    [$14 + 2], $21
	load    [$14 + 0], $25
	load    [$19 + 0], $19
	fmul    $25, $24, $24
	fmul    $21, $19, $21
	fadd    $21, $24, $21
	finv    $20, $24
	fmul    $21, $39, $21
	fsub    $22, $21, $21
	store   $21, [$18 + 2]
	load    [$14 + 1], $21
	load    [$14 + 0], $22
	fmul    $21, $19, $19
	fmul    $22, $26, $21
	fadd    $19, $21, $19
	fmul    $19, $39, $19
	fsub    $23, $19, $19
	store   $19, [$18 + 3]
	bne     be_else.37055
be_then.37055:
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37055
be_else.37055:
	store   $24, [$18 + 4]
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.37055:
be_cont.37053:
be_cont.37050:
be_cont.37034:
bge_cont.37033:
	li      116, $3
.count move_args
	mov     $17, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $17
	sub     $17, 1, $17
	cmp     $17, 0
	bl      bge_else.37056
bge_then.37056:
.count stack_store
	store   $17, [$sp + 2]
	load    [min_caml_dirvecs + $17], $17
	sub     $41, 1, $3
	load    [$17 + 119], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $11
	load    [$17 + 118], $10
	cmp     $11, 0
	li      6, $2
	load    [$10 + 1], $12
	bl      bge_cont.37057
bge_then.37057:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $14
	li      4, $15
	load    [$13 + 1], $16
	li      5, $18
.count move_args
	mov     $zero, $3
	cmp     $16, 1
	bne     be_else.37058
be_then.37058:
	call    min_caml_create_array
	load    [$14 + 0], $19
.count move_ret
	mov     $1, $18
	load    [$13 + 6], $20
	fcmp    $19, $zero
	load    [$13 + 4], $21
	bne     be_else.37059
be_then.37059:
	store   $zero, [$18 + 1]
.count b_cont
	b       be_cont.37059
be_else.37059:
	fcmp    $zero, $19
	bg      ble_else.37060
ble_then.37060:
	li      0, $19
.count b_cont
	b       ble_cont.37060
ble_else.37060:
	li      1, $19
ble_cont.37060:
	cmp     $20, 0
	be      bne_cont.37061
bne_then.37061:
	cmp     $19, 0
	bne     be_else.37062
be_then.37062:
	li      1, $19
.count b_cont
	b       be_cont.37062
be_else.37062:
	li      0, $19
be_cont.37062:
bne_cont.37061:
	cmp     $19, 0
	load    [$21 + 0], $20
	bne     be_else.37063
be_then.37063:
	fneg    $20, $19
	store   $19, [$18 + 0]
	load    [$14 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
.count b_cont
	b       be_cont.37063
be_else.37063:
	store   $20, [$18 + 0]
	load    [$14 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
be_cont.37063:
be_cont.37059:
	load    [$14 + 1], $19
	load    [$13 + 6], $20
	load    [$13 + 4], $21
	fcmp    $19, $zero
	bne     be_else.37064
be_then.37064:
	store   $zero, [$18 + 3]
.count b_cont
	b       be_cont.37064
be_else.37064:
	fcmp    $zero, $19
	bg      ble_else.37065
ble_then.37065:
	li      0, $19
.count b_cont
	b       ble_cont.37065
ble_else.37065:
	li      1, $19
ble_cont.37065:
	cmp     $20, 0
	be      bne_cont.37066
bne_then.37066:
	cmp     $19, 0
	bne     be_else.37067
be_then.37067:
	li      1, $19
.count b_cont
	b       be_cont.37067
be_else.37067:
	li      0, $19
be_cont.37067:
bne_cont.37066:
	cmp     $19, 0
	load    [$21 + 1], $20
	bne     be_else.37068
be_then.37068:
	fneg    $20, $19
	store   $19, [$18 + 2]
	load    [$14 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
.count b_cont
	b       be_cont.37068
be_else.37068:
	store   $20, [$18 + 2]
	load    [$14 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
be_cont.37068:
be_cont.37064:
	load    [$14 + 2], $19
	load    [$13 + 6], $20
	load    [$13 + 4], $21
	fcmp    $19, $zero
	bne     be_else.37069
be_then.37069:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$18 + 5]
	store   $18, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37058
be_else.37069:
	fcmp    $zero, $19
	bg      ble_else.37070
ble_then.37070:
	li      0, $19
.count b_cont
	b       ble_cont.37070
ble_else.37070:
	li      1, $19
ble_cont.37070:
	cmp     $20, 0
	be      bne_cont.37071
bne_then.37071:
	cmp     $19, 0
	bne     be_else.37072
be_then.37072:
	li      1, $19
.count b_cont
	b       be_cont.37072
be_else.37072:
	li      0, $19
be_cont.37072:
bne_cont.37071:
	cmp     $19, 0
	load    [$21 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.37073
be_then.37073:
	fneg    $20, $19
	store   $19, [$18 + 4]
	load    [$14 + 2], $19
	store   $18, [$tmp + 0]
	finv    $19, $19
	store   $19, [$18 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37058
be_else.37073:
	store   $20, [$18 + 4]
	load    [$14 + 2], $19
	store   $18, [$tmp + 0]
	finv    $19, $19
	store   $19, [$18 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37058
be_else.37058:
	cmp     $16, 2
	bne     be_else.37074
be_then.37074:
.count move_args
	mov     $15, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$14 + 0], $22
	load    [$19 + 0], $19
	load    [$14 + 1], $23
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$14 + 2], $22
	fmul    $23, $20, $20
	load    [$21 + 2], $21
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $22, $21, $21
	fadd    $19, $20, $19
.count storer
	add     $12, $11, $tmp
	fadd    $19, $21, $19
	fcmp    $19, $zero
	bg      ble_else.37075
ble_then.37075:
	store   $zero, [$18 + 0]
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37074
ble_else.37075:
	finv    $19, $19
	fneg    $19, $20
	store   $20, [$18 + 0]
	load    [$13 + 4], $20
	load    [$20 + 0], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 1]
	load    [$13 + 4], $20
	load    [$20 + 1], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 2]
	load    [$13 + 4], $20
	load    [$20 + 2], $20
	store   $18, [$tmp + 0]
	fmul    $20, $19, $19
	fneg    $19, $19
	store   $19, [$18 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37074
be_else.37074:
.count move_args
	mov     $18, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$13 + 3], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$14 + 0], $23
	load    [$14 + 1], $24
	load    [$14 + 2], $25
	fmul    $23, $23, $26
	fmul    $24, $24, $27
	load    [$20 + 0], $20
	load    [$21 + 1], $21
	fmul    $25, $25, $28
	fmul    $26, $20, $20
	fmul    $27, $21, $21
	load    [$22 + 2], $22
	fmul    $24, $25, $26
	load    [$13 + 9], $27
	fmul    $28, $22, $22
	fadd    $20, $21, $20
	fmul    $25, $23, $25
	load    [$27 + 0], $21
	cmp     $19, 0
	load    [$13 + 9], $27
	fmul    $23, $24, $23
	fmul    $26, $21, $21
	fadd    $20, $22, $20
	be      bne_cont.37076
bne_then.37076:
	fadd    $20, $21, $20
	load    [$27 + 1], $21
	load    [$13 + 9], $22
	fmul    $25, $21, $21
	load    [$22 + 2], $22
	fmul    $23, $22, $22
	fadd    $20, $21, $20
	fadd    $20, $22, $20
bne_cont.37076:
	store   $20, [$18 + 0]
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$13 + 4], $23
	load    [$14 + 0], $24
	load    [$21 + 0], $21
	load    [$14 + 1], $25
	load    [$22 + 1], $22
	fmul    $24, $21, $21
	load    [$14 + 2], $24
	load    [$23 + 2], $23
	fmul    $25, $22, $22
	load    [$13 + 9], $26
	fmul    $24, $23, $23
	fneg    $21, $21
	load    [$13 + 9], $27
	cmp     $19, 0
	fneg    $22, $22
	load    [$26 + 1], $26
	fneg    $23, $23
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.37077
be_then.37077:
	fcmp    $20, $zero
	store   $21, [$18 + 1]
	store   $22, [$18 + 2]
	store   $23, [$18 + 3]
	store   $18, [$tmp + 0]
	bne     be_else.37078
be_then.37078:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37077
be_else.37078:
	finv    $20, $19
	store   $19, [$18 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37077
be_else.37077:
	fmul    $24, $26, $19
	load    [$27 + 2], $24
	fcmp    $20, $zero
	fmul    $25, $24, $25
	fadd    $19, $25, $19
	fmul    $19, $39, $19
	fsub    $21, $19, $19
	store   $19, [$18 + 1]
	load    [$13 + 9], $19
	load    [$14 + 2], $21
	load    [$14 + 0], $25
	load    [$19 + 0], $19
	fmul    $25, $24, $24
	fmul    $21, $19, $21
	fadd    $21, $24, $21
	finv    $20, $24
	fmul    $21, $39, $21
	fsub    $22, $21, $21
	store   $21, [$18 + 2]
	load    [$14 + 1], $21
	load    [$14 + 0], $22
	fmul    $21, $19, $19
	fmul    $22, $26, $21
	fadd    $19, $21, $19
	fmul    $19, $39, $19
	fsub    $23, $19, $19
	store   $19, [$18 + 3]
	bne     be_else.37079
be_then.37079:
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37079
be_else.37079:
	store   $24, [$18 + 4]
	store   $18, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.37079:
be_cont.37077:
be_cont.37074:
be_cont.37058:
bge_cont.37057:
	li      117, $3
.count move_args
	mov     $17, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.37080
bge_then.37080:
.count stack_store
	store   $10, [$sp + 3]
	sub     $41, 1, $11
	load    [min_caml_dirvecs + $10], $10
	li      6, $2
	cmp     $11, 0
.count stack_store
	store   $10, [$sp + 4]
	load    [min_caml_objects + $11], $12
	load    [$10 + 119], $10
	bl      bge_cont.37081
bge_then.37081:
	load    [$12 + 1], $14
	load    [$10 + 1], $13
	load    [$10 + 0], $15
	cmp     $14, 1
	li      4, $16
.count move_args
	mov     $zero, $3
	bne     be_else.37082
be_then.37082:
	call    min_caml_create_array
	load    [$15 + 0], $18
.count move_ret
	mov     $1, $17
	load    [$12 + 6], $19
	fcmp    $18, $zero
	load    [$12 + 4], $20
	bne     be_else.37083
be_then.37083:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.37083
be_else.37083:
	fcmp    $zero, $18
	bg      ble_else.37084
ble_then.37084:
	li      0, $18
.count b_cont
	b       ble_cont.37084
ble_else.37084:
	li      1, $18
ble_cont.37084:
	cmp     $19, 0
	be      bne_cont.37085
bne_then.37085:
	cmp     $18, 0
	bne     be_else.37086
be_then.37086:
	li      1, $18
.count b_cont
	b       be_cont.37086
be_else.37086:
	li      0, $18
be_cont.37086:
bne_cont.37085:
	cmp     $18, 0
	load    [$20 + 0], $19
	bne     be_else.37087
be_then.37087:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.37087
be_else.37087:
	store   $19, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.37087:
be_cont.37083:
	load    [$15 + 1], $18
	load    [$12 + 6], $19
	load    [$12 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37088
be_then.37088:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.37088
be_else.37088:
	fcmp    $zero, $18
	bg      ble_else.37089
ble_then.37089:
	li      0, $18
.count b_cont
	b       ble_cont.37089
ble_else.37089:
	li      1, $18
ble_cont.37089:
	cmp     $19, 0
	be      bne_cont.37090
bne_then.37090:
	cmp     $18, 0
	bne     be_else.37091
be_then.37091:
	li      1, $18
.count b_cont
	b       be_cont.37091
be_else.37091:
	li      0, $18
be_cont.37091:
bne_cont.37090:
	cmp     $18, 0
	load    [$20 + 1], $19
	bne     be_else.37092
be_then.37092:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.37092
be_else.37092:
	store   $19, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.37092:
be_cont.37088:
	load    [$15 + 2], $18
	load    [$12 + 6], $19
	load    [$12 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37093
be_then.37093:
.count storer
	add     $13, $11, $tmp
	store   $zero, [$17 + 5]
	store   $17, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37082
be_else.37093:
	fcmp    $zero, $18
	bg      ble_else.37094
ble_then.37094:
	li      0, $18
.count b_cont
	b       ble_cont.37094
ble_else.37094:
	li      1, $18
ble_cont.37094:
	cmp     $19, 0
	be      bne_cont.37095
bne_then.37095:
	cmp     $18, 0
	bne     be_else.37096
be_then.37096:
	li      1, $18
.count b_cont
	b       be_cont.37096
be_else.37096:
	li      0, $18
be_cont.37096:
bne_cont.37095:
	cmp     $18, 0
	load    [$20 + 2], $19
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $13, $11, $tmp
	bne     be_else.37097
be_then.37097:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$15 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37082
be_else.37097:
	store   $19, [$17 + 4]
	load    [$15 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37082
be_else.37082:
	cmp     $14, 2
	bne     be_else.37098
be_then.37098:
.count move_args
	mov     $16, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$12 + 4], $18
	load    [$12 + 4], $19
	load    [$12 + 4], $20
	load    [$15 + 0], $21
	load    [$18 + 0], $18
	load    [$15 + 1], $22
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$15 + 2], $21
	fmul    $22, $19, $19
	load    [$20 + 2], $20
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
	fmul    $21, $20, $20
	fadd    $18, $19, $18
.count storer
	add     $13, $11, $tmp
	fadd    $18, $20, $18
	fcmp    $18, $zero
	bg      ble_else.37099
ble_then.37099:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37098
ble_else.37099:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$17 + 0]
	load    [$12 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 1]
	load    [$12 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 2]
	load    [$12 + 4], $19
	load    [$19 + 2], $19
	store   $17, [$tmp + 0]
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37098
be_else.37098:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$12 + 3], $18
	load    [$12 + 4], $19
	load    [$12 + 4], $20
	load    [$12 + 4], $21
	load    [$15 + 0], $22
	load    [$15 + 1], $23
	load    [$15 + 2], $24
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	fmul    $23, $24, $25
	load    [$12 + 9], $26
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	fmul    $24, $22, $24
	load    [$26 + 0], $20
	cmp     $18, 0
	load    [$12 + 9], $26
	fmul    $22, $23, $22
	fmul    $25, $20, $20
	fadd    $19, $21, $19
	be      bne_cont.37100
bne_then.37100:
	fadd    $19, $20, $19
	load    [$26 + 1], $20
	load    [$12 + 9], $21
	fmul    $24, $20, $20
	load    [$21 + 2], $21
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
bne_cont.37100:
	store   $19, [$17 + 0]
	load    [$12 + 4], $20
	load    [$12 + 4], $21
	load    [$12 + 4], $22
	load    [$15 + 0], $23
	load    [$20 + 0], $20
	load    [$15 + 1], $24
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$15 + 2], $23
	load    [$22 + 2], $22
	fmul    $24, $21, $21
	load    [$12 + 9], $25
	fmul    $23, $22, $22
	fneg    $20, $20
	load    [$12 + 9], $26
	cmp     $18, 0
	fneg    $21, $21
	load    [$25 + 1], $25
	fneg    $22, $22
.count storer
	add     $13, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.37101
be_then.37101:
	fcmp    $19, $zero
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	store   $17, [$tmp + 0]
	bne     be_else.37102
be_then.37102:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37101
be_else.37102:
	finv    $19, $18
	store   $18, [$17 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37101
be_else.37101:
	fmul    $23, $25, $18
	load    [$26 + 2], $23
	fcmp    $19, $zero
	fmul    $24, $23, $24
	fadd    $18, $24, $18
	fmul    $18, $39, $18
	fsub    $20, $18, $18
	store   $18, [$17 + 1]
	load    [$12 + 9], $18
	load    [$15 + 2], $20
	load    [$15 + 0], $24
	load    [$18 + 0], $18
	fmul    $24, $23, $23
	fmul    $20, $18, $20
	fadd    $20, $23, $20
	finv    $19, $23
	fmul    $20, $39, $20
	fsub    $21, $20, $20
	store   $20, [$17 + 2]
	load    [$15 + 1], $20
	load    [$15 + 0], $21
	fmul    $20, $18, $18
	fmul    $21, $25, $20
	fadd    $18, $20, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.37103
be_then.37103:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37103
be_else.37103:
	store   $23, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.37103:
be_cont.37101:
be_cont.37098:
be_cont.37082:
bge_cont.37081:
	li      118, $3
.count stack_load
	load    [$sp + 4], $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $29
	li      119, $3
	sub     $29, 1, $29
	cmp     $29, 0
	bl      bge_else.37104
bge_then.37104:
	load    [min_caml_dirvecs + $29], $2
	call    init_dirvec_constants.3044
.count stack_move
	add     $sp, 5, $sp
	sub     $29, 1, $2
	b       init_vecset_constants.3047
bge_else.37104:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.37080:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.37056:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.37009:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3064:
	cmp     $2, 0
	bl      bge_else.37105
bge_then.37105:
	load    [min_caml_objects + $2], $10
	li      3, $11
	li      3, $12
	load    [$10 + 2], $13
	load    [$10 + 7], $14
	load    [$10 + 1], $15
	cmp     $13, 2
	bne     be_else.37106
be_then.37106:
	load    [$14 + 0], $13
	load    [$10 + 7], $14
	load    [$10 + 4], $16
	fcmp    $36, $13
	bg      ble_else.37107
ble_then.37107:
	ret
ble_else.37107:
	cmp     $15, 1
	bne     be_else.37108
be_then.37108:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
.count stack_store
	store   $14, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count move_args
	mov     $11, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
.count stack_store
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count stack_load
	load    [$sp + 2], $18
.count move_ret
	mov     $1, $17
	fneg    $56, $19
	store   $55, [$18 + 0]
	store   $19, [$18 + 1]
	fneg    $57, $20
	mov     $hp, $21
	mov     $21, $2
	store   $20, [$18 + 2]
	add     $hp, 2, $hp
	sub     $41, 1, $3
	store   $17, [$21 + 1]
	store   $18, [$21 + 0]
.count stack_store
	store   $2, [$sp + 3]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 1], $10
	mov     $hp, $12
	add     $hp, 3, $hp
	sll     $10, 2, $10
	li      3, $2
.count stack_store
	store   $10, [$sp + 4]
.count stack_load
	load    [$sp + 0], $11
	add     $10, 1, $10
.count move_args
	mov     $zero, $3
	load    [$11 + 0], $11
	fsub    $36, $11, $11
.count stack_store
	store   $11, [$sp + 5]
.count stack_load
	load    [$sp + 3], $13
	store   $13, [$12 + 1]
	store   $10, [$12 + 0]
	store   $11, [$12 + 2]
	load    [min_caml_n_reflections + 0], $11
	mov     $12, $10
.count stack_store
	store   $11, [$sp + 6]
	store   $10, [min_caml_reflections + $11]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 7]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count stack_load
	load    [$sp + 7], $21
.count move_ret
	mov     $1, $17
	fneg    $55, $18
	sub     $41, 1, $3
	store   $18, [$21 + 0]
	store   $20, [$21 + 2]
	mov     $hp, $20
	mov     $20, $2
	store   $56, [$21 + 1]
	add     $hp, 2, $hp
	store   $17, [$20 + 1]
	store   $21, [$20 + 0]
.count stack_store
	store   $2, [$sp + 8]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 5], $13
.count stack_load
	load    [$sp + 6], $10
.count stack_load
	load    [$sp + 4], $11
	mov     $hp, $12
	store   $13, [$12 + 2]
.count stack_load
	load    [$sp + 8], $13
	add     $10, 1, $10
	add     $11, 2, $11
	add     $hp, 3, $hp
	store   $13, [$12 + 1]
	store   $11, [$12 + 0]
	mov     $12, $11
	store   $11, [min_caml_reflections + $10]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 9]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count stack_load
	load    [$sp + 9], $20
.count move_ret
	mov     $1, $17
	sub     $41, 1, $3
	store   $18, [$20 + 0]
	mov     $hp, $18
	mov     $18, $2
	store   $19, [$20 + 1]
	store   $57, [$20 + 2]
	add     $hp, 2, $hp
	store   $17, [$18 + 1]
	store   $20, [$18 + 0]
.count stack_store
	store   $2, [$sp + 10]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
	mov     $hp, $4
.count stack_load
	load    [$sp - 9], $5
.count stack_load
	load    [$sp - 8], $1
.count stack_load
	load    [$sp - 10], $3
	store   $5, [$4 + 2]
.count stack_load
	load    [$sp - 4], $5
	add     $1, 2, $2
	add     $3, 3, $3
	add     $1, 3, $1
	add     $hp, 3, $hp
	store   $5, [$4 + 1]
	store   $3, [$4 + 0]
	mov     $4, $3
	store   $3, [min_caml_reflections + $2]
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.37108:
	cmp     $15, 2
	bne     be_else.37109
be_then.37109:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
.count stack_store
	store   $13, [$sp + 11]
.count stack_store
	store   $2, [$sp + 1]
	load    [$10 + 4], $10
.count move_args
	mov     $12, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $11, $3
.count stack_store
	store   $3, [$sp + 12]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
.count load_float
	load    [f.31944], $18
	load    [$16 + 0], $19
	load    [$10 + 1], $20
	load    [$10 + 2], $23
	fmul    $18, $19, $21
	fmul    $55, $19, $19
	fmul    $56, $20, $22
	fmul    $18, $20, $20
	fmul    $18, $23, $18
	sub     $41, 1, $3
	fadd    $19, $22, $19
	fmul    $57, $23, $22
	fadd    $19, $22, $19
	fmul    $18, $19, $18
	fmul    $21, $19, $21
	fmul    $20, $19, $20
	fsub    $18, $57, $18
	fsub    $21, $55, $19
	fsub    $20, $56, $20
.count stack_load
	load    [$sp + 12], $21
	store   $19, [$21 + 0]
	store   $20, [$21 + 1]
	store   $18, [$21 + 2]
	mov     $hp, $18
	mov     $18, $2
	add     $hp, 2, $hp
	store   $17, [$18 + 1]
	store   $21, [$18 + 0]
.count stack_store
	store   $2, [$sp + 13]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
	mov     $hp, $3
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 13], $2
	add     $hp, 3, $hp
	fsub    $36, $1, $1
	sll     $2, 2, $2
	add     $2, 1, $2
	store   $1, [$3 + 2]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [$3 + 1]
	store   $2, [$3 + 0]
	load    [min_caml_n_reflections + 0], $2
	mov     $3, $1
	store   $1, [min_caml_reflections + $2]
	add     $2, 1, $1
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.37109:
	ret
be_else.37106:
	ret
bge_else.37105:
	ret
.end setup_reflections

######################################################################
.begin main
min_caml_main:
.count stack_move
	sub     $sp, 18, $sp
	load    [min_caml_n_objects + 0], $41
	load    [min_caml_solver_dist + 0], $42
	load    [min_caml_diffuse_ray + 0], $43
	load    [min_caml_diffuse_ray + 1], $44
	load    [min_caml_diffuse_ray + 2], $45
	load    [min_caml_rgb + 0], $46
	load    [min_caml_rgb + 1], $47
	load    [min_caml_rgb + 2], $48
	load    [min_caml_tmin + 0], $49
	load    [min_caml_image_size + 0], $50
	load    [min_caml_startp_fast + 0], $51
	load    [min_caml_startp_fast + 1], $52
	load    [min_caml_startp_fast + 2], $53
	load    [min_caml_texture_color + 1], $54
	load    [min_caml_light + 0], $55
	load    [min_caml_light + 1], $56
	load    [min_caml_light + 2], $57
	load    [min_caml_texture_color + 2], $58
	load    [min_caml_or_net + 0], $59
	load    [min_caml_image_size + 1], $60
	load    [f.31946 + 0], $36
	load    [f.31970 + 0], $37
	load    [f.31969 + 0], $38
	load    [f.31947 + 0], $39
	load    [f.31945 + 0], $40
	li      128, $2
	li      128, $10
.count move_float
	mov     $2, $50
.count move_float
	mov     $10, $60
	li      64, $10
	li      64, $11
	store   $10, [min_caml_image_center + 0]
	store   $11, [min_caml_image_center + 1]
.count load_float
	load    [f.32063], $10
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $11
	finv    $11, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	fmul    $10, $11, $10
	store   $10, [min_caml_scan_pitch + 0]
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 4]
	mov     $hp, $18
	add     $hp, 8, $hp
	store   $17, [$18 + 7]
	store   $16, [$18 + 6]
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	mov     $18, $3
.count move_args
	mov     $50, $2
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.37110
bge_then.37110:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
.count b_cont
	b       bge_cont.37110
bge_else.37110:
	mov     $19, $10
bge_cont.37110:
.count stack_store
	store   $10, [$sp + 0]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 4]
	mov     $hp, $18
	add     $hp, 8, $hp
	store   $17, [$18 + 7]
	store   $16, [$18 + 6]
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	mov     $18, $3
.count move_args
	mov     $50, $2
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.37111
bge_then.37111:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
.count b_cont
	b       bge_cont.37111
bge_else.37111:
	mov     $19, $10
bge_cont.37111:
.count stack_store
	store   $10, [$sp + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $11, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $12, [$11 + 4]
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      5, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	mov     $14, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	store   $15, [$14 + 4]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	mov     $15, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $15
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	store   $16, [$15 + 4]
	li      1, $2
	li      0, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	mov     $17, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 1]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 2]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 3]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $18, [$17 + 4]
	mov     $hp, $18
	add     $hp, 8, $hp
	store   $17, [$18 + 7]
	store   $16, [$18 + 6]
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	mov     $18, $3
.count move_args
	mov     $50, $2
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.37112
bge_then.37112:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
.count b_cont
	b       bge_cont.37112
bge_else.37112:
	mov     $19, $10
bge_cont.37112:
.count stack_store
	store   $10, [$sp + 2]
	call    min_caml_read_float
.count move_ret
	mov     $1, $10
	store   $10, [min_caml_screen + 0]
	call    min_caml_read_float
.count move_ret
	mov     $1, $10
	store   $10, [min_caml_screen + 1]
	call    min_caml_read_float
.count move_ret
	mov     $1, $10
	store   $10, [min_caml_screen + 2]
	call    min_caml_read_float
.count load_float
	load    [f.31931], $12
.count move_ret
	mov     $1, $11
	fmul    $11, $12, $2
.count stack_store
	store   $2, [$sp + 3]
	call    min_caml_cos
.count move_ret
	mov     $1, $11
.count stack_load
	load    [$sp + 3], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $10
.count stack_store
	store   $10, [$sp + 4]
	call    min_caml_read_float
.count move_ret
	mov     $1, $13
	fmul    $13, $12, $2
.count stack_store
	store   $2, [$sp + 5]
	call    min_caml_cos
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 5], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $10
	fmul    $11, $10, $14
.count load_float
	load    [f.32091], $15
	fmul    $11, $13, $16
.count load_float
	load    [f.32092], $17
	store   $13, [min_caml_screenx_dir + 0]
	fmul    $14, $15, $14
.count stack_load
	load    [$sp + 4], $18
	fmul    $16, $15, $15
	store   $zero, [min_caml_screenx_dir + 1]
	fmul    $18, $17, $17
	fneg    $10, $16
	store   $14, [min_caml_screenz_dir + 0]
	fneg    $18, $14
	fneg    $11, $11
	store   $17, [min_caml_screenz_dir + 1]
	store   $15, [min_caml_screenz_dir + 2]
	store   $16, [min_caml_screenx_dir + 2]
	fmul    $14, $10, $10
	store   $11, [min_caml_screeny_dir + 1]
	fmul    $14, $13, $11
	store   $10, [min_caml_screeny_dir + 0]
	store   $11, [min_caml_screeny_dir + 2]
	load    [min_caml_screen + 0], $10
	load    [min_caml_screenz_dir + 0], $11
	fsub    $10, $11, $10
	store   $10, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $10
	load    [min_caml_screenz_dir + 1], $11
	fsub    $10, $11, $10
	store   $10, [min_caml_viewpoint + 1]
	load    [min_caml_screen + 2], $10
	load    [min_caml_screenz_dir + 2], $11
	fsub    $10, $11, $10
	store   $10, [min_caml_viewpoint + 2]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	call    min_caml_read_float
.count move_ret
	mov     $1, $11
	fmul    $11, $12, $2
.count stack_store
	store   $2, [$sp + 6]
	call    min_caml_sin
.count move_ret
	mov     $1, $10
	fneg    $10, $10
.count move_float
	mov     $10, $56
	call    min_caml_read_float
.count move_ret
	mov     $1, $11
.count stack_load
	load    [$sp + 6], $2
	call    min_caml_cos
	fmul    $11, $12, $2
.count move_ret
	mov     $1, $13
.count stack_store
	store   $2, [$sp + 7]
	call    min_caml_sin
.count move_ret
	mov     $1, $11
	fmul    $13, $11, $11
.count stack_load
	load    [$sp + 7], $2
.count move_float
	mov     $11, $55
	call    min_caml_cos
.count move_ret
	mov     $1, $10
	fmul    $13, $10, $10
.count move_float
	mov     $10, $57
	call    min_caml_read_float
	li      0, $2
.count move_ret
	mov     $1, $23
	store   $23, [min_caml_beam + 0]
.count stack_store
	store   $2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.37113
be_then.37113:
.count stack_load
	load    [$sp + 8], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.37113
be_else.37113:
	li      1, $2
.count stack_store
	store   $2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.37114
be_then.37114:
.count stack_load
	load    [$sp + 9], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.37114
be_else.37114:
	li      2, $2
.count stack_store
	store   $2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.37115
be_then.37115:
.count stack_load
	load    [$sp + 10], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.37115
be_else.37115:
	li      3, $2
.count stack_store
	store   $2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $24
	cmp     $24, 0
	bne     be_else.37116
be_then.37116:
.count stack_load
	load    [$sp + 11], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.37116
be_else.37116:
	li      4, $2
	call    read_object.2721
be_cont.37116:
be_cont.37115:
be_cont.37114:
be_cont.37113:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.37117
be_then.37117:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
.count b_cont
	b       be_cont.37117
be_else.37117:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.37118
be_then.37118:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $10, [$18 + 0]
.count b_cont
	b       be_cont.37118
be_else.37118:
.count stack_store
	store   $10, [$sp + 12]
.count stack_store
	store   $11, [$sp + 13]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 13], $19
.count move_ret
	mov     $1, $18
	store   $19, [$18 + 1]
.count stack_load
	load    [$sp + 12], $19
	store   $19, [$18 + 0]
be_cont.37118:
be_cont.37117:
	load    [$18 + 0], $19
	cmp     $19, -1
	be      bne_cont.37119
bne_then.37119:
	store   $18, [min_caml_and_net + 0]
	li      1, $2
	call    read_and_network.2729
bne_cont.37119:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.37120
be_then.37120:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.37120
be_else.37120:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.37121
be_then.37121:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.37121
be_else.37121:
.count stack_store
	store   $10, [$sp + 14]
.count stack_store
	store   $11, [$sp + 15]
	call    read_net_item.2725
.count stack_load
	load    [$sp + 15], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 14], $11
	store   $11, [$10 + 0]
be_cont.37121:
be_cont.37120:
	mov     $10, $3
	load    [$3 + 0], $10
	li      1, $2
	li      1, $11
	cmp     $10, -1
	bne     be_else.37122
be_then.37122:
	call    min_caml_create_array
.count b_cont
	b       be_cont.37122
be_else.37122:
.count stack_store
	store   $3, [$sp + 16]
.count move_args
	mov     $11, $2
	call    read_or_network.2727
.count stack_load
	load    [$sp + 16], $10
	store   $10, [$1 + 0]
be_cont.37122:
.count move_float
	mov     $1, $59
	li      80, $2
	call    min_caml_write
	li      54, $2
	call    min_caml_write
	li      10, $2
	call    min_caml_write
	li      49, $2
	call    min_caml_write
	li      50, $2
	call    min_caml_write
	li      56, $2
	call    min_caml_write
	li      32, $2
	call    min_caml_write
	li      49, $2
	call    min_caml_write
	li      50, $2
	call    min_caml_write
	li      56, $2
	call    min_caml_write
	li      32, $2
	call    min_caml_write
	li      50, $2
	call    min_caml_write
	li      53, $2
	call    min_caml_write
	li      53, $2
	call    min_caml_write
	li      10, $2
	call    min_caml_write
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
.count stack_store
	store   $3, [$sp + 17]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $hp, $11
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 17], $10
	li      120, $2
	add     $hp, 2, $hp
	store   $10, [$11 + 0]
	mov     $11, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	store   $14, [min_caml_dirvecs + 4]
	load    [min_caml_dirvecs + 4], $2
	li      118, $3
	call    create_dirvec_elements.3039
	li      3, $2
	call    create_dirvecs.3042
	li      0, $10
	li      0, $11
	li      4, $12
	li      9, $2
	call    min_caml_float_of_int
.count load_float
	load    [f.32000], $22
.count move_ret
	mov     $1, $21
.count load_float
	load    [f.32001], $23
	fmul    $21, $22, $21
.count move_args
	mov     $11, $5
.count move_args
	mov     $10, $4
.count move_args
	mov     $12, $2
	fsub    $21, $23, $3
	call    calc_dirvecs.3028
	li      8, $2
	li      2, $3
	li      4, $4
	call    calc_dirvec_rows.3033
	load    [min_caml_dirvecs + 4], $2
	li      119, $3
	call    init_dirvec_constants.3044
	li      3, $2
	call    init_vecset_constants.3047
	li      min_caml_light_dirvec, $10
	load    [min_caml_light_dirvec + 0], $11
	sub     $41, 1, $13
	li      6, $2
	cmp     $13, 0
	store   $55, [$11 + 0]
	store   $56, [$11 + 1]
	store   $57, [$11 + 2]
	load    [min_caml_light_dirvec + 1], $12
	li      4, $14
	bl      bge_cont.37123
bge_then.37123:
	load    [min_caml_objects + $13], $15
	li      5, $16
.count move_args
	mov     $zero, $3
	load    [$15 + 1], $17
	cmp     $17, 1
	bne     be_else.37124
be_then.37124:
	call    min_caml_create_array
	load    [$11 + 0], $18
.count move_ret
	mov     $1, $17
	load    [$15 + 6], $19
	fcmp    $18, $zero
	load    [$15 + 4], $20
	bne     be_else.37125
be_then.37125:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.37125
be_else.37125:
	fcmp    $zero, $18
	bg      ble_else.37126
ble_then.37126:
	li      0, $18
.count b_cont
	b       ble_cont.37126
ble_else.37126:
	li      1, $18
ble_cont.37126:
	cmp     $19, 0
	be      bne_cont.37127
bne_then.37127:
	cmp     $18, 0
	bne     be_else.37128
be_then.37128:
	li      1, $18
.count b_cont
	b       be_cont.37128
be_else.37128:
	li      0, $18
be_cont.37128:
bne_cont.37127:
	cmp     $18, 0
	load    [$20 + 0], $19
	bne     be_else.37129
be_then.37129:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$11 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.37129
be_else.37129:
	store   $19, [$17 + 0]
	load    [$11 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.37129:
be_cont.37125:
	load    [$11 + 1], $18
	load    [$15 + 6], $19
	load    [$15 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37130
be_then.37130:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.37130
be_else.37130:
	fcmp    $zero, $18
	bg      ble_else.37131
ble_then.37131:
	li      0, $18
.count b_cont
	b       ble_cont.37131
ble_else.37131:
	li      1, $18
ble_cont.37131:
	cmp     $19, 0
	be      bne_cont.37132
bne_then.37132:
	cmp     $18, 0
	bne     be_else.37133
be_then.37133:
	li      1, $18
.count b_cont
	b       be_cont.37133
be_else.37133:
	li      0, $18
be_cont.37133:
bne_cont.37132:
	cmp     $18, 0
	load    [$20 + 1], $19
	bne     be_else.37134
be_then.37134:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$11 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.37134
be_else.37134:
	store   $19, [$17 + 2]
	load    [$11 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.37134:
be_cont.37130:
	load    [$11 + 2], $18
	load    [$15 + 6], $19
	load    [$15 + 4], $20
	fcmp    $18, $zero
	bne     be_else.37135
be_then.37135:
.count storer
	add     $12, $13, $tmp
	store   $zero, [$17 + 5]
	store   $17, [$tmp + 0]
	sub     $13, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37124
be_else.37135:
	fcmp    $zero, $18
	bg      ble_else.37136
ble_then.37136:
	li      0, $18
.count b_cont
	b       ble_cont.37136
ble_else.37136:
	li      1, $18
ble_cont.37136:
	cmp     $19, 0
	be      bne_cont.37137
bne_then.37137:
	cmp     $18, 0
	bne     be_else.37138
be_then.37138:
	li      1, $18
.count b_cont
	b       be_cont.37138
be_else.37138:
	li      0, $18
be_cont.37138:
bne_cont.37137:
	cmp     $18, 0
	load    [$20 + 2], $19
.count move_args
	mov     $10, $2
	sub     $13, 1, $3
.count storer
	add     $12, $13, $tmp
	bne     be_else.37139
be_then.37139:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$11 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37124
be_else.37139:
	store   $19, [$17 + 4]
	load    [$11 + 2], $18
	store   $17, [$tmp + 0]
	finv    $18, $18
	store   $18, [$17 + 5]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37124
be_else.37124:
	cmp     $17, 2
	bne     be_else.37140
be_then.37140:
.count move_args
	mov     $14, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$15 + 4], $18
	load    [$15 + 4], $19
	load    [$15 + 4], $20
	load    [$11 + 0], $21
	load    [$18 + 0], $18
	load    [$11 + 1], $22
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$11 + 2], $21
	fmul    $22, $19, $19
	load    [$20 + 2], $20
.count move_args
	mov     $10, $2
	sub     $13, 1, $3
	fmul    $21, $20, $20
	fadd    $18, $19, $18
.count storer
	add     $12, $13, $tmp
	fadd    $18, $20, $18
	fcmp    $18, $zero
	bg      ble_else.37141
ble_then.37141:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37140
ble_else.37141:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$17 + 0]
	load    [$15 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 1]
	load    [$15 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$17 + 2]
	load    [$15 + 4], $19
	load    [$19 + 2], $19
	store   $17, [$tmp + 0]
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37140
be_else.37140:
.count move_args
	mov     $16, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$15 + 3], $18
	load    [$15 + 4], $19
	load    [$15 + 4], $20
	load    [$15 + 4], $21
	load    [$11 + 0], $22
	load    [$11 + 1], $23
	load    [$11 + 2], $24
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	fmul    $23, $24, $25
	load    [$15 + 9], $26
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	fmul    $24, $22, $24
	load    [$26 + 0], $20
	cmp     $18, 0
	load    [$15 + 9], $26
	fmul    $22, $23, $22
	fmul    $25, $20, $20
	fadd    $19, $21, $19
	be      bne_cont.37142
bne_then.37142:
	fadd    $19, $20, $19
	load    [$26 + 1], $20
	load    [$15 + 9], $21
	fmul    $24, $20, $20
	load    [$21 + 2], $21
	fmul    $22, $21, $21
	fadd    $19, $20, $19
	fadd    $19, $21, $19
bne_cont.37142:
	store   $19, [$17 + 0]
	load    [$15 + 4], $20
	load    [$15 + 4], $21
	load    [$15 + 4], $22
	load    [$11 + 0], $23
	load    [$20 + 0], $20
	load    [$11 + 1], $24
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$11 + 2], $23
	load    [$22 + 2], $22
	fmul    $24, $21, $21
	load    [$15 + 9], $25
	fmul    $23, $22, $22
	fneg    $20, $20
	load    [$15 + 9], $26
	cmp     $18, 0
	fneg    $21, $21
	load    [$25 + 1], $25
	fneg    $22, $22
.count storer
	add     $12, $13, $tmp
	sub     $13, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.37143
be_then.37143:
	fcmp    $19, $zero
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	store   $17, [$tmp + 0]
	bne     be_else.37144
be_then.37144:
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37143
be_else.37144:
	finv    $19, $18
	store   $18, [$17 + 4]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37143
be_else.37143:
	fmul    $23, $25, $18
	load    [$26 + 2], $23
	fcmp    $19, $zero
	fmul    $24, $23, $24
	fadd    $18, $24, $18
	fmul    $18, $39, $18
	fsub    $20, $18, $18
	store   $18, [$17 + 1]
	load    [$15 + 9], $18
	load    [$11 + 2], $20
	load    [$11 + 0], $24
	load    [$18 + 0], $18
	fmul    $24, $23, $23
	fmul    $20, $18, $20
	fadd    $20, $23, $20
	finv    $19, $23
	fmul    $20, $39, $20
	fsub    $21, $20, $20
	store   $20, [$17 + 2]
	load    [$11 + 1], $20
	load    [$11 + 0], $21
	fmul    $20, $18, $18
	fmul    $21, $25, $20
	fadd    $18, $20, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.37145
be_then.37145:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.37145
be_else.37145:
	store   $23, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.37145:
be_cont.37143:
be_cont.37140:
be_cont.37124:
bge_cont.37123:
	sub     $41, 1, $2
	call    setup_reflections.3064
	load    [min_caml_image_center + 1], $11
	li      0, $10
	load    [min_caml_screeny_dir + 0], $12
	sub     $50, 1, $13
	load    [min_caml_scan_pitch + 0], $14
	neg     $11, $2
	call    min_caml_float_of_int
	fmul    $14, $1, $1
	load    [min_caml_screenz_dir + 0], $2
	load    [min_caml_screeny_dir + 1], $3
	load    [min_caml_screeny_dir + 2], $4
	load    [min_caml_screenz_dir + 1], $5
	fmul    $1, $12, $6
	fmul    $1, $3, $3
	fmul    $1, $4, $1
	load    [min_caml_screenz_dir + 2], $4
	fadd    $6, $2, $2
	fadd    $3, $5, $6
	fadd    $1, $4, $7
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $13, $3
.count move_args
	mov     $2, $5
.count move_args
	mov     $4, $2
.count move_args
	mov     $10, $4
	call    pretrace_pixels.2983
	li      0, $2
	li      2, $6
.count stack_load
	load    [$sp + 0], $3
.count stack_load
	load    [$sp + 1], $4
.count stack_load
	load    [$sp + 2], $5
	call    scan_line.3000
.count stack_move
	add     $sp, 18, $sp
	li      0, $1
	ret
.end main
