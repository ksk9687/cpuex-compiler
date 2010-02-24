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
f.27231:	.float  -2.0000000000E+02
f.27230:	.float  2.0000000000E+02
f.27202:	.float  1.2800000000E+02
f.27140:	.float  9.0000000000E-01
f.27139:	.float  2.0000000000E-01
f.27111:	.float  1.5000000000E+02
f.27110:	.float  -1.5000000000E+02
f.27109:	.float  6.6666666667E-03
f.27108:	.float  -6.6666666667E-03
f.27107:	.float  -2.0000000000E+00
f.27106:	.float  3.9062500000E-03
f.27105:	.float  2.5600000000E+02
f.27104:	.float  1.0000000000E+08
f.27103:	.float  1.0000000000E+09
f.27102:	.float  1.0000000000E+01
f.27101:	.float  2.0000000000E+01
f.27100:	.float  5.0000000000E-02
f.27099:	.float  2.5000000000E-01
f.27098:	.float  1.0000000000E-01
f.27097:	.float  3.3333333333E+00
f.27096:	.float  2.5500000000E+02
f.27095:	.float  1.5000000000E-01
f.27094:	.float  3.1830988148E-01
f.27093:	.float  3.1415927000E+00
f.27092:	.float  3.0000000000E+01
f.27091:	.float  1.5000000000E+01
f.27090:	.float  1.0000000000E-04
f.27089:	.float  -1.0000000000E-01
f.27088:	.float  1.0000000000E-02
f.27087:	.float  -2.0000000000E-01
f.27086:	.float  5.0000000000E-01
f.27085:	.float  1.0000000000E+00
f.27084:	.float  -1.0000000000E+00
f.27083:	.float  2.0000000000E+00
f.27070:	.float  1.7453293000E-02

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
	bne     be_else.30950
be_then.30950:
.count stack_move
	add     $sp, 1, $sp
	li      0, $1
	ret
be_else.30950:
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
.count move_ret
	mov     $1, $19
	cmp     $13, 0
	be      bne_cont.30951
bne_then.30951:
	call    min_caml_read_float
.count load_float
	load    [f.27070], $21
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
bne_cont.30951:
	li      4, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $20
	fcmp    $zero, $16
	bg      ble_else.30952
ble_then.30952:
	li      0, $16
.count b_cont
	b       ble_cont.30952
ble_else.30952:
	li      1, $16
ble_cont.30952:
	cmp     $11, 2
	bne     be_else.30953
be_then.30953:
	li      1, $21
.count b_cont
	b       be_cont.30953
be_else.30953:
	mov     $16, $21
be_cont.30953:
	mov     $hp, $22
	store   $20, [$22 + 10]
	add     $hp, 11, $hp
	store   $19, [$22 + 9]
	cmp     $11, 3
	store   $18, [$22 + 8]
	store   $17, [$22 + 7]
	store   $21, [$22 + 6]
	store   $15, [$22 + 5]
	store   $14, [$22 + 4]
	store   $13, [$22 + 3]
	store   $12, [$22 + 2]
	store   $11, [$22 + 1]
	mov     $22, $12
	store   $10, [$22 + 0]
.count stack_load
	load    [$sp + 0], $15
	store   $12, [min_caml_objects + $15]
	bne     be_else.30954
be_then.30954:
	load    [$14 + 0], $11
	fcmp    $11, $zero
	bne     be_else.30955
be_then.30955:
	mov     $zero, $11
.count b_cont
	b       be_cont.30955
be_else.30955:
	fcmp    $11, $zero
	bne     be_else.30956
be_then.30956:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.30956
be_else.30956:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30957
ble_then.30957:
	fneg    $11, $11
ble_cont.30957:
be_cont.30956:
be_cont.30955:
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fcmp    $11, $zero
	bne     be_else.30958
be_then.30958:
	mov     $zero, $11
.count b_cont
	b       be_cont.30958
be_else.30958:
	fcmp    $11, $zero
	bne     be_else.30959
be_then.30959:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.30959
be_else.30959:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30960
ble_then.30960:
	fneg    $11, $11
ble_cont.30960:
be_cont.30959:
be_cont.30958:
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fcmp    $11, $zero
	bne     be_else.30961
be_then.30961:
	mov     $zero, $11
.count b_cont
	b       be_cont.30961
be_else.30961:
	fcmp    $11, $zero
	bne     be_else.30962
be_then.30962:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
.count b_cont
	b       be_cont.30962
be_else.30962:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30963
ble_then.30963:
	fneg    $11, $11
ble_cont.30963:
be_cont.30962:
be_cont.30961:
	store   $11, [$14 + 2]
	cmp     $13, 0
	bne     be_else.30964
be_then.30964:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30964:
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
	fmul    $13, $1, $3
	fmul    $13, $16, $2
	load    [$14 + 0], $4
	load    [$14 + 1], $6
	fneg    $15, $8
	fmul    $3, $3, $7
	fmul    $2, $2, $5
	fmul    $8, $8, $9
	load    [$14 + 2], $10
	fmul    $12, $13, $17
	fmul    $6, $7, $7
	fmul    $4, $5, $5
	fmul    $10, $9, $9
	fmul    $4, $2, $2
	fmul    $17, $17, $20
	fmul    $6, $3, $3
	fadd    $5, $7, $5
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $1, $7
	fadd    $5, $9, $5
	fmul    $11, $16, $9
	store   $5, [$14 + 0]
	fmul    $12, $15, $5
	fmul    $5, $16, $18
	fmul    $5, $1, $5
	fsub    $18, $7, $7
	fadd    $5, $9, $5
	fmul    $10, $20, $9
	fmul    $7, $7, $18
	fmul    $5, $5, $20
	fmul    $4, $18, $18
	fmul    $6, $20, $20
	fadd    $18, $20, $18
	fadd    $18, $9, $9
	store   $9, [$14 + 1]
	fmul    $11, $15, $9
	fmul    $11, $13, $11
	fmul    $12, $1, $15
	fmul    $9, $16, $13
	fmul    $9, $1, $1
	fmul    $12, $16, $12
	fmul    $11, $11, $9
	fadd    $13, $15, $13
	fsub    $1, $12, $1
	fmul    $10, $9, $9
	fmul    $13, $13, $12
	fmul    $1, $1, $15
	fmul    $4, $12, $12
	fmul    $6, $15, $15
	fadd    $12, $15, $12
	fmul    $10, $17, $15
	fadd    $12, $9, $9
	fmul    $4, $7, $12
	fmul    $15, $11, $15
	fmul    $10, $8, $4
	store   $9, [$14 + 2]
	fmul    $6, $5, $14
	fmul    $12, $13, $12
	fmul    $2, $13, $6
	fmul    $4, $11, $8
.count load_float
	load    [f.27083], $9
	fmul    $14, $1, $14
	fmul    $3, $1, $1
	fadd    $12, $14, $12
	fadd    $6, $1, $1
	fadd    $12, $15, $12
	fadd    $1, $8, $1
	fmul    $9, $12, $12
	fmul    $9, $1, $1
	store   $12, [$19 + 0]
	store   $1, [$19 + 1]
	fmul    $2, $7, $1
	fmul    $3, $5, $2
	fmul    $4, $17, $3
	fadd    $1, $2, $1
	fadd    $1, $3, $1
	fmul    $9, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.30954:
	cmp     $11, 2
	bne     be_else.30965
be_then.30965:
	load    [$14 + 0], $11
	cmp     $16, 0
	bne     be_else.30966
be_then.30966:
	li      1, $12
.count b_cont
	b       be_cont.30966
be_else.30966:
	li      0, $12
be_cont.30966:
	load    [$14 + 1], $16
	fmul    $11, $11, $15
	load    [$14 + 2], $17
	fmul    $16, $16, $16
	fmul    $17, $17, $17
	fadd    $15, $16, $15
	fadd    $15, $17, $15
	fsqrt   $15, $15
	fcmp    $15, $zero
	bne     be_else.30967
be_then.30967:
	mov     $36, $12
.count b_cont
	b       be_cont.30967
be_else.30967:
	cmp     $12, 0
	finv    $15, $12
	be      bne_cont.30968
bne_then.30968:
	fneg    $12, $12
bne_cont.30968:
be_cont.30967:
	fmul    $11, $12, $11
	cmp     $13, 0
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 2]
	bne     be_else.30969
be_then.30969:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30969:
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
	fmul    $13, $1, $3
	fmul    $13, $16, $2
	load    [$14 + 0], $4
	load    [$14 + 1], $6
	fneg    $15, $8
	fmul    $3, $3, $7
	fmul    $2, $2, $5
	fmul    $8, $8, $9
	load    [$14 + 2], $10
	fmul    $12, $13, $17
	fmul    $6, $7, $7
	fmul    $4, $5, $5
	fmul    $10, $9, $9
	fmul    $4, $2, $2
	fmul    $17, $17, $20
	fmul    $6, $3, $3
	fadd    $5, $7, $5
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $1, $7
	fadd    $5, $9, $5
	fmul    $11, $16, $9
	store   $5, [$14 + 0]
	fmul    $12, $15, $5
	fmul    $5, $16, $18
	fmul    $5, $1, $5
	fsub    $18, $7, $7
	fadd    $5, $9, $5
	fmul    $10, $20, $9
	fmul    $7, $7, $18
	fmul    $5, $5, $20
	fmul    $4, $18, $18
	fmul    $6, $20, $20
	fadd    $18, $20, $18
	fadd    $18, $9, $9
	store   $9, [$14 + 1]
	fmul    $11, $15, $9
	fmul    $11, $13, $11
	fmul    $12, $1, $15
	fmul    $9, $16, $13
	fmul    $9, $1, $1
	fmul    $12, $16, $12
	fmul    $11, $11, $9
	fadd    $13, $15, $13
	fsub    $1, $12, $1
	fmul    $10, $9, $9
	fmul    $13, $13, $12
	fmul    $1, $1, $15
	fmul    $4, $12, $12
	fmul    $6, $15, $15
	fadd    $12, $15, $12
	fmul    $10, $17, $15
	fadd    $12, $9, $9
	fmul    $4, $7, $12
	fmul    $15, $11, $15
	fmul    $10, $8, $4
	store   $9, [$14 + 2]
	fmul    $6, $5, $14
	fmul    $12, $13, $12
	fmul    $2, $13, $6
	fmul    $4, $11, $8
.count load_float
	load    [f.27083], $9
	fmul    $14, $1, $14
	fmul    $3, $1, $1
	fadd    $12, $14, $12
	fadd    $6, $1, $1
	fadd    $12, $15, $12
	fadd    $1, $8, $1
	fmul    $9, $12, $12
	fmul    $9, $1, $1
	store   $12, [$19 + 0]
	store   $1, [$19 + 1]
	fmul    $2, $7, $1
	fmul    $3, $5, $2
	fmul    $4, $17, $3
	fadd    $1, $2, $1
	fadd    $1, $3, $1
	fmul    $9, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.30965:
	cmp     $13, 0
	bne     be_else.30970
be_then.30970:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30970:
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
	fmul    $13, $1, $3
	fmul    $13, $16, $2
	load    [$14 + 0], $4
	load    [$14 + 1], $6
	fneg    $15, $8
	fmul    $3, $3, $7
	fmul    $2, $2, $5
	fmul    $8, $8, $9
	load    [$14 + 2], $10
	fmul    $12, $13, $17
	fmul    $6, $7, $7
	fmul    $4, $5, $5
	fmul    $10, $9, $9
	fmul    $4, $2, $2
	fmul    $17, $17, $20
	fmul    $6, $3, $3
	fadd    $5, $7, $5
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $1, $7
	fadd    $5, $9, $5
	fmul    $11, $16, $9
	store   $5, [$14 + 0]
	fmul    $12, $15, $5
	fmul    $5, $16, $18
	fmul    $5, $1, $5
	fsub    $18, $7, $7
	fadd    $5, $9, $5
	fmul    $10, $20, $9
	fmul    $7, $7, $18
	fmul    $5, $5, $20
	fmul    $4, $18, $18
	fmul    $6, $20, $20
	fadd    $18, $20, $18
	fadd    $18, $9, $9
	store   $9, [$14 + 1]
	fmul    $11, $15, $9
	fmul    $11, $13, $11
	fmul    $12, $1, $15
	fmul    $9, $16, $13
	fmul    $9, $1, $1
	fmul    $12, $16, $12
	fmul    $11, $11, $9
	fadd    $13, $15, $13
	fsub    $1, $12, $1
	fmul    $10, $9, $9
	fmul    $13, $13, $12
	fmul    $1, $1, $15
	fmul    $4, $12, $12
	fmul    $6, $15, $15
	fadd    $12, $15, $12
	fmul    $10, $17, $15
	fadd    $12, $9, $9
	fmul    $4, $7, $12
	fmul    $15, $11, $15
	fmul    $10, $8, $4
	store   $9, [$14 + 2]
	fmul    $6, $5, $14
	fmul    $12, $13, $12
	fmul    $2, $13, $6
	fmul    $4, $11, $8
.count load_float
	load    [f.27083], $9
	fmul    $14, $1, $14
	fmul    $3, $1, $1
	fadd    $12, $14, $12
	fadd    $6, $1, $1
	fadd    $12, $15, $12
	fadd    $1, $8, $1
	fmul    $9, $12, $12
	fmul    $9, $1, $1
	store   $12, [$19 + 0]
	store   $1, [$19 + 1]
	fmul    $2, $7, $1
	fmul    $3, $5, $2
	fmul    $4, $17, $3
	fadd    $1, $2, $1
	fadd    $1, $3, $1
	fmul    $9, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
.end read_nth_object

######################################################################
.begin read_object
read_object.2721:
	cmp     $2, 60
	bl      bge_else.30971
bge_then.30971:
	ret
bge_else.30971:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30972
be_then.30972:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 8], $1
.count move_float
	mov     $1, $41
	ret
be_else.30972:
.count stack_load
	load    [$sp + 0], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30973
bge_then.30973:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30973:
.count stack_store
	store   $2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30974
be_then.30974:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 7], $1
.count move_float
	mov     $1, $41
	ret
be_else.30974:
.count stack_load
	load    [$sp + 1], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30975
bge_then.30975:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30975:
.count stack_store
	store   $2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30976
be_then.30976:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 6], $1
.count move_float
	mov     $1, $41
	ret
be_else.30976:
.count stack_load
	load    [$sp + 2], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30977
bge_then.30977:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30977:
.count stack_store
	store   $2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30978
be_then.30978:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 5], $1
.count move_float
	mov     $1, $41
	ret
be_else.30978:
.count stack_load
	load    [$sp + 3], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30979
bge_then.30979:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30979:
.count stack_store
	store   $2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30980
be_then.30980:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 4], $1
.count move_float
	mov     $1, $41
	ret
be_else.30980:
.count stack_load
	load    [$sp + 4], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30981
bge_then.30981:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30981:
.count stack_store
	store   $2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30982
be_then.30982:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $1, $41
	ret
be_else.30982:
.count stack_load
	load    [$sp + 5], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30983
bge_then.30983:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30983:
.count stack_store
	store   $2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30984
be_then.30984:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 2], $1
.count move_float
	mov     $1, $41
	ret
be_else.30984:
.count stack_load
	load    [$sp + 6], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30985
bge_then.30985:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30985:
.count stack_store
	store   $2, [$sp + 7]
	call    read_nth_object.2719
.count stack_move
	add     $sp, 8, $sp
	cmp     $1, 0
.count stack_load
	load    [$sp - 1], $1
	bne     be_else.30986
be_then.30986:
.count move_float
	mov     $1, $41
	ret
be_else.30986:
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
	bne     be_else.30987
be_then.30987:
.count stack_move
	add     $sp, 8, $sp
	add     $zero, -1, $3
.count stack_load
	load    [$sp - 8], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.30987:
	call    min_caml_read_int
.count stack_load
	load    [$sp + 0], $12
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	add     $12, 1, $13
	bne     be_else.30988
be_then.30988:
	add     $zero, -1, $3
	add     $13, 1, $2
	call    min_caml_create_array
.count storer
	add     $1, $12, $tmp
.count stack_move
	add     $sp, 8, $sp
	store   $10, [$tmp + 0]
	ret
be_else.30988:
	call    min_caml_read_int
.count move_ret
	mov     $1, $14
	add     $13, 1, $15
	cmp     $14, -1
	bne     be_else.30989
be_then.30989:
	add     $zero, -1, $3
	add     $15, 1, $2
	call    min_caml_create_array
.count storer
	add     $1, $13, $tmp
.count stack_move
	add     $sp, 8, $sp
	store   $11, [$tmp + 0]
.count storer
	add     $1, $12, $tmp
	store   $10, [$tmp + 0]
	ret
be_else.30989:
	call    min_caml_read_int
	add     $15, 1, $17
.count move_ret
	mov     $1, $16
	cmp     $16, -1
	add     $17, 1, $2
	bne     be_else.30990
be_then.30990:
	add     $zero, -1, $3
	call    min_caml_create_array
.count storer
	add     $1, $15, $tmp
.count stack_move
	add     $sp, 8, $sp
	store   $14, [$tmp + 0]
.count storer
	add     $1, $13, $tmp
	store   $11, [$tmp + 0]
.count storer
	add     $1, $12, $tmp
	store   $10, [$tmp + 0]
	ret
be_else.30990:
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
	bne     be_else.30991
be_then.30991:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.30991
be_else.30991:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.30992
be_then.30992:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.30992
be_else.30992:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.30993
be_then.30993:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.30993
be_else.30993:
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
be_cont.30993:
be_cont.30992:
be_cont.30991:
	mov     $10, $3
	load    [$3 + 0], $10
	cmp     $10, -1
	bne     be_else.30994
be_then.30994:
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 9], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.30994:
.count stack_store
	store   $3, [$sp + 4]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.30995
be_then.30995:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.30995
be_else.30995:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.30996
be_then.30996:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.30996
be_else.30996:
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
be_cont.30996:
be_cont.30995:
	mov     $10, $3
.count stack_load
	load    [$sp + 0], $11
	load    [$3 + 0], $10
	add     $11, 1, $12
	cmp     $10, -1
	add     $12, 1, $2
	bne     be_else.30997
be_then.30997:
	call    min_caml_create_array
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $1, $11, $tmp
.count stack_load
	load    [$sp - 5], $2
	store   $2, [$tmp + 0]
	ret
be_else.30997:
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
	bne     be_else.30998
be_then.30998:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.30998
be_else.30998:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.30999
be_then.30999:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.30999
be_else.30999:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.31000
be_then.31000:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.31000
be_else.31000:
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
be_cont.31000:
be_cont.30999:
be_cont.30998:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31001
be_then.31001:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31001:
.count stack_load
	load    [$sp + 0], $11
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31002
be_then.31002:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.31002
be_else.31002:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31003
be_then.31003:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.31003
be_else.31003:
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
be_cont.31003:
be_cont.31002:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31004
be_then.31004:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31004:
.count stack_load
	load    [$sp + 0], $11
	add     $11, 1, $11
.count stack_store
	store   $11, [$sp + 6]
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31005
be_then.31005:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.31005
be_else.31005:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.31006
be_then.31006:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.31006
be_else.31006:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.31007
be_then.31007:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
.count b_cont
	b       be_cont.31007
be_else.31007:
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
be_cont.31007:
be_cont.31006:
be_cont.31005:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31008
be_then.31008:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31008:
.count stack_load
	load    [$sp + 6], $11
	add     $11, 1, $11
.count stack_store
	store   $11, [$sp + 10]
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31009
be_then.31009:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count b_cont
	b       be_cont.31009
be_else.31009:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31010
be_then.31010:
	add     $zero, -1, $3
	call    min_caml_create_array
	store   $10, [$1 + 0]
.count b_cont
	b       be_cont.31010
be_else.31010:
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
be_cont.31010:
be_cont.31009:
	load    [$1 + 0], $2
.count stack_move
	add     $sp, 13, $sp
	cmp     $2, -1
	bne     be_else.31011
be_then.31011:
	ret
be_else.31011:
.count stack_load
	load    [$sp - 3], $2
	add     $2, 1, $2
	store   $1, [min_caml_and_net + $2]
	add     $2, 1, $2
	b       read_and_network.2729
.end read_and_network

######################################################################
.begin solver
solver.2773:
	load    [min_caml_objects + $2], $1
	load    [min_caml_startp + 0], $7
	load    [min_caml_startp + 1], $8
	load    [$1 + 5], $2
	load    [$1 + 5], $4
	load    [$1 + 5], $5
	load    [$2 + 0], $2
	load    [$4 + 1], $4
	load    [$5 + 2], $5
	load    [min_caml_startp + 2], $9
	load    [$1 + 1], $6
	fsub    $7, $2, $2
	fsub    $8, $4, $4
	fsub    $9, $5, $5
	cmp     $6, 1
	bne     be_else.31012
be_then.31012:
	load    [$3 + 0], $6
	fcmp    $6, $zero
	bne     be_else.31013
be_then.31013:
	li      0, $6
.count b_cont
	b       be_cont.31013
be_else.31013:
	load    [$1 + 4], $7
	load    [$3 + 1], $8
	load    [$1 + 6], $9
	load    [$7 + 1], $10
	fcmp    $zero, $6
	bg      ble_else.31014
ble_then.31014:
	li      0, $11
.count b_cont
	b       ble_cont.31014
ble_else.31014:
	li      1, $11
ble_cont.31014:
	cmp     $9, 0
	bne     be_else.31015
be_then.31015:
	mov     $11, $9
.count b_cont
	b       be_cont.31015
be_else.31015:
	cmp     $11, 0
	bne     be_else.31016
be_then.31016:
	li      1, $9
.count b_cont
	b       be_cont.31016
be_else.31016:
	li      0, $9
be_cont.31016:
be_cont.31015:
	load    [$7 + 0], $11
	cmp     $9, 0
	bne     be_else.31017
be_then.31017:
	fneg    $11, $9
.count b_cont
	b       be_cont.31017
be_else.31017:
	mov     $11, $9
be_cont.31017:
	finv    $6, $6
	fsub    $9, $2, $9
	fmul    $9, $6, $6
	fmul    $6, $8, $8
	fadd    $8, $4, $8
	fabs    $8, $8
	fcmp    $10, $8
	bg      ble_else.31018
ble_then.31018:
	li      0, $6
.count b_cont
	b       ble_cont.31018
ble_else.31018:
	load    [$3 + 2], $8
	load    [$7 + 2], $7
	fmul    $6, $8, $8
	fadd    $8, $5, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31019
ble_then.31019:
	li      0, $6
.count b_cont
	b       ble_cont.31019
ble_else.31019:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.31019:
ble_cont.31018:
be_cont.31013:
	cmp     $6, 0
	bne     be_else.31020
be_then.31020:
	load    [$3 + 1], $6
	fcmp    $6, $zero
	bne     be_else.31021
be_then.31021:
	li      0, $6
.count b_cont
	b       be_cont.31021
be_else.31021:
	load    [$1 + 4], $7
	load    [$3 + 2], $8
	load    [$1 + 6], $9
	load    [$7 + 2], $10
	fcmp    $zero, $6
	bg      ble_else.31022
ble_then.31022:
	li      0, $11
.count b_cont
	b       ble_cont.31022
ble_else.31022:
	li      1, $11
ble_cont.31022:
	cmp     $9, 0
	bne     be_else.31023
be_then.31023:
	mov     $11, $9
.count b_cont
	b       be_cont.31023
be_else.31023:
	cmp     $11, 0
	bne     be_else.31024
be_then.31024:
	li      1, $9
.count b_cont
	b       be_cont.31024
be_else.31024:
	li      0, $9
be_cont.31024:
be_cont.31023:
	load    [$7 + 1], $11
	cmp     $9, 0
	bne     be_else.31025
be_then.31025:
	fneg    $11, $9
.count b_cont
	b       be_cont.31025
be_else.31025:
	mov     $11, $9
be_cont.31025:
	finv    $6, $6
	fsub    $9, $4, $9
	fmul    $9, $6, $6
	fmul    $6, $8, $8
	fadd    $8, $5, $8
	fabs    $8, $8
	fcmp    $10, $8
	bg      ble_else.31026
ble_then.31026:
	li      0, $6
.count b_cont
	b       ble_cont.31026
ble_else.31026:
	load    [$3 + 0], $8
	load    [$7 + 0], $7
	fmul    $6, $8, $8
	fadd    $8, $2, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31027
ble_then.31027:
	li      0, $6
.count b_cont
	b       ble_cont.31027
ble_else.31027:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.31027:
ble_cont.31026:
be_cont.31021:
	cmp     $6, 0
	bne     be_else.31028
be_then.31028:
	load    [$3 + 2], $6
	fcmp    $6, $zero
	bne     be_else.31029
be_then.31029:
	li      0, $1
	ret
be_else.31029:
	load    [$1 + 4], $7
	load    [$3 + 0], $9
	load    [$1 + 6], $1
	load    [$7 + 0], $8
	fcmp    $zero, $6
	bg      ble_else.31030
ble_then.31030:
	li      0, $10
.count b_cont
	b       ble_cont.31030
ble_else.31030:
	li      1, $10
ble_cont.31030:
	cmp     $1, 0
	bne     be_else.31031
be_then.31031:
	mov     $10, $1
.count b_cont
	b       be_cont.31031
be_else.31031:
	cmp     $10, 0
	bne     be_else.31032
be_then.31032:
	li      1, $1
.count b_cont
	b       be_cont.31032
be_else.31032:
	li      0, $1
be_cont.31032:
be_cont.31031:
	load    [$7 + 2], $10
	cmp     $1, 0
	bne     be_else.31033
be_then.31033:
	fneg    $10, $1
.count b_cont
	b       be_cont.31033
be_else.31033:
	mov     $10, $1
be_cont.31033:
	fsub    $1, $5, $1
	finv    $6, $5
	fmul    $1, $5, $1
	fmul    $1, $9, $5
	fadd    $5, $2, $2
	fabs    $2, $2
	fcmp    $8, $2
	bg      ble_else.31034
ble_then.31034:
	li      0, $1
	ret
ble_else.31034:
	load    [$3 + 1], $3
	load    [$7 + 1], $2
	fmul    $1, $3, $3
	fadd    $3, $4, $3
	fabs    $3, $3
	fcmp    $2, $3
	bg      ble_else.31035
ble_then.31035:
	li      0, $1
	ret
ble_else.31035:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.31028:
	li      2, $1
	ret
be_else.31020:
	li      1, $1
	ret
be_else.31012:
	cmp     $6, 2
	bne     be_else.31036
be_then.31036:
	load    [$1 + 4], $1
	load    [$3 + 1], $8
	load    [$3 + 0], $6
	load    [$1 + 1], $9
	load    [$1 + 0], $7
	load    [$3 + 2], $3
	fmul    $8, $9, $8
	fmul    $6, $7, $6
	load    [$1 + 2], $1
	fmul    $3, $1, $3
	fadd    $6, $8, $6
	fadd    $6, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31037
ble_then.31037:
	li      0, $1
	ret
ble_else.31037:
	fmul    $9, $4, $4
	fmul    $7, $2, $2
	fmul    $1, $5, $1
	finv    $3, $3
	fadd    $2, $4, $2
	fadd    $2, $1, $1
	fneg    $1, $1
	fmul    $1, $3, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31036:
	load    [$3 + 0], $11
	load    [$3 + 1], $12
	load    [$1 + 4], $7
	load    [$1 + 4], $8
	fmul    $11, $11, $13
	fmul    $12, $12, $14
	load    [$3 + 2], $3
	load    [$7 + 0], $7
	load    [$8 + 1], $8
	load    [$1 + 4], $9
	fmul    $3, $3, $15
	fmul    $13, $7, $13
	fmul    $14, $8, $14
	load    [$9 + 2], $9
	load    [$1 + 3], $10
	fmul    $15, $9, $15
	fadd    $13, $14, $13
	cmp     $10, 0
	fadd    $13, $15, $13
	bne     be_else.31038
be_then.31038:
	mov     $13, $10
.count b_cont
	b       be_cont.31038
be_else.31038:
	load    [$1 + 9], $14
	fmul    $12, $3, $10
	load    [$1 + 9], $16
	load    [$14 + 0], $14
	fmul    $3, $11, $15
	load    [$1 + 9], $17
	fmul    $10, $14, $10
	load    [$16 + 1], $14
	fmul    $11, $12, $16
	fadd    $13, $10, $10
	fmul    $15, $14, $14
	load    [$17 + 2], $13
	fmul    $16, $13, $13
	fadd    $10, $14, $10
	fadd    $10, $13, $10
be_cont.31038:
	fcmp    $10, $zero
	bne     be_else.31039
be_then.31039:
	li      0, $1
	ret
be_else.31039:
	fmul    $11, $2, $15
	fmul    $12, $4, $16
	fmul    $3, $5, $17
	load    [$1 + 3], $13
	load    [$1 + 3], $14
	fmul    $15, $7, $15
	fmul    $16, $8, $16
	fmul    $17, $9, $17
	cmp     $13, 0
	fadd    $15, $16, $15
	fadd    $15, $17, $15
	bne     be_else.31040
be_then.31040:
	mov     $15, $3
.count b_cont
	b       be_cont.31040
be_else.31040:
	fmul    $3, $4, $13
	fmul    $12, $5, $16
	fmul    $11, $5, $18
	fmul    $3, $2, $3
	load    [$1 + 9], $17
	fmul    $12, $2, $12
	fadd    $13, $16, $13
	load    [$17 + 0], $17
	load    [$1 + 9], $16
	fmul    $11, $4, $11
	fadd    $18, $3, $3
	fmul    $13, $17, $13
	load    [$16 + 1], $16
	load    [$1 + 9], $17
	fadd    $11, $12, $11
	fmul    $3, $16, $3
	load    [$17 + 2], $16
	fmul    $11, $16, $11
	fadd    $13, $3, $3
	fadd    $3, $11, $3
	fmul    $3, $39, $3
	fadd    $15, $3, $3
be_cont.31040:
	fmul    $2, $2, $12
	fmul    $4, $4, $13
	fmul    $5, $5, $15
	fmul    $3, $3, $11
	cmp     $14, 0
	fmul    $12, $7, $7
	fmul    $13, $8, $8
	fmul    $15, $9, $9
	fadd    $7, $8, $7
	fadd    $7, $9, $7
	bne     be_else.31041
be_then.31041:
	mov     $7, $2
.count b_cont
	b       be_cont.31041
be_else.31041:
	load    [$1 + 9], $9
	fmul    $4, $5, $8
	load    [$1 + 9], $12
	load    [$9 + 0], $9
	fmul    $5, $2, $5
	fmul    $8, $9, $8
	fmul    $2, $4, $2
	load    [$12 + 1], $9
	load    [$1 + 9], $4
	fadd    $7, $8, $7
	fmul    $5, $9, $5
	load    [$4 + 2], $4
	fmul    $2, $4, $2
	fadd    $7, $5, $5
	fadd    $5, $2, $2
be_cont.31041:
	cmp     $6, 3
	bne     be_cont.31042
be_then.31042:
	fsub    $2, $36, $2
be_cont.31042:
	fmul    $10, $2, $2
	fsub    $11, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31043
ble_then.31043:
	li      0, $1
	ret
ble_else.31043:
	load    [$1 + 6], $1
	fsqrt   $2, $2
	cmp     $1, 0
	bne     be_else.31044
be_then.31044:
	fneg    $2, $1
	fsub    $1, $3, $1
	finv    $10, $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31044:
	fsub    $2, $3, $1
	finv    $10, $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver

######################################################################
.begin solver_fast
solver_fast.2796:
	load    [min_caml_objects + $2], $1
	load    [min_caml_intersection_point + 0], $8
	load    [min_caml_intersection_point + 1], $9
	load    [$1 + 5], $4
	load    [$1 + 5], $5
	load    [$1 + 5], $6
	load    [$4 + 0], $4
	load    [$5 + 1], $5
	load    [$6 + 2], $6
	load    [min_caml_intersection_point + 2], $10
	load    [min_caml_light_dirvec + 1], $3
	load    [$1 + 1], $7
	fsub    $8, $4, $4
	fsub    $9, $5, $5
	fsub    $10, $6, $6
	load    [$3 + $2], $2
	cmp     $7, 1
	bne     be_else.31045
be_then.31045:
	load    [$2 + 0], $9
	load    [$2 + 1], $10
	load    [min_caml_light_dirvec + 0], $3
	fsub    $9, $4, $9
	load    [$1 + 4], $7
	load    [$3 + 1], $8
	load    [$7 + 1], $7
	fmul    $9, $10, $9
	fmul    $9, $8, $8
	fadd    $8, $5, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31046
ble_then.31046:
	li      0, $8
.count b_cont
	b       ble_cont.31046
ble_else.31046:
	load    [$3 + 2], $10
	load    [$1 + 4], $8
	fmul    $9, $10, $10
	load    [$8 + 2], $8
	fadd    $10, $6, $10
	fabs    $10, $10
	fcmp    $8, $10
	bg      ble_else.31047
ble_then.31047:
	li      0, $8
.count b_cont
	b       ble_cont.31047
ble_else.31047:
	load    [$2 + 1], $8
	fcmp    $8, $zero
	bne     be_else.31048
be_then.31048:
	li      0, $8
.count b_cont
	b       be_cont.31048
be_else.31048:
	li      1, $8
be_cont.31048:
ble_cont.31047:
ble_cont.31046:
	cmp     $8, 0
	bne     be_else.31049
be_then.31049:
	load    [$2 + 2], $10
	load    [$2 + 3], $11
	load    [$3 + 0], $9
	fsub    $10, $5, $10
	load    [$1 + 4], $8
	load    [$8 + 0], $8
	fmul    $10, $11, $10
	fmul    $10, $9, $9
	fadd    $9, $4, $9
	fabs    $9, $9
	fcmp    $8, $9
	bg      ble_else.31050
ble_then.31050:
	li      0, $1
.count b_cont
	b       ble_cont.31050
ble_else.31050:
	load    [$3 + 2], $9
	load    [$1 + 4], $1
	fmul    $10, $9, $9
	load    [$1 + 2], $1
	fadd    $9, $6, $9
	fabs    $9, $9
	fcmp    $1, $9
	bg      ble_else.31051
ble_then.31051:
	li      0, $1
.count b_cont
	b       ble_cont.31051
ble_else.31051:
	load    [$2 + 3], $1
	fcmp    $1, $zero
	bne     be_else.31052
be_then.31052:
	li      0, $1
.count b_cont
	b       be_cont.31052
be_else.31052:
	li      1, $1
be_cont.31052:
ble_cont.31051:
ble_cont.31050:
	cmp     $1, 0
	bne     be_else.31053
be_then.31053:
	load    [$2 + 4], $9
	load    [$3 + 0], $1
	fsub    $9, $6, $6
	load    [$2 + 5], $9
	fmul    $6, $9, $6
	fmul    $6, $1, $1
	fadd    $1, $4, $1
	fabs    $1, $1
	fcmp    $8, $1
	bg      ble_else.31054
ble_then.31054:
	li      0, $1
	ret
ble_else.31054:
	load    [$3 + 1], $1
	fmul    $6, $1, $1
	fadd    $1, $5, $1
	fabs    $1, $1
	fcmp    $7, $1
	bg      ble_else.31055
ble_then.31055:
	li      0, $1
	ret
ble_else.31055:
	load    [$2 + 5], $1
	fcmp    $1, $zero
	bne     be_else.31056
be_then.31056:
	li      0, $1
	ret
be_else.31056:
.count move_float
	mov     $6, $42
	li      3, $1
	ret
be_else.31053:
.count move_float
	mov     $10, $42
	li      2, $1
	ret
be_else.31049:
.count move_float
	mov     $9, $42
	li      1, $1
	ret
be_else.31045:
	cmp     $7, 2
	bne     be_else.31057
be_then.31057:
	load    [$2 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31058
ble_then.31058:
	li      0, $1
	ret
ble_else.31058:
	load    [$2 + 2], $3
	load    [$2 + 1], $1
	fmul    $3, $5, $3
	fmul    $1, $4, $1
	load    [$2 + 3], $2
	fmul    $2, $6, $2
	fadd    $1, $3, $1
	fadd    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31057:
	load    [$2 + 0], $3
	fcmp    $3, $zero
	bne     be_else.31059
be_then.31059:
	li      0, $1
	ret
be_else.31059:
	load    [$2 + 2], $13
	load    [$2 + 1], $12
	load    [$1 + 4], $8
	fmul    $13, $5, $13
	fmul    $12, $4, $12
	load    [$1 + 4], $9
	fmul    $5, $5, $15
	load    [$8 + 0], $8
	load    [$9 + 1], $9
	fadd    $12, $13, $12
	load    [$2 + 3], $14
	fmul    $4, $4, $13
	fmul    $15, $9, $9
	load    [$1 + 4], $10
	fmul    $14, $6, $14
	load    [$1 + 3], $11
	fmul    $13, $8, $8
	load    [$10 + 2], $10
	fmul    $6, $6, $13
	fadd    $12, $14, $12
	cmp     $11, 0
	fadd    $8, $9, $8
	fmul    $13, $10, $9
	fmul    $12, $12, $14
	fadd    $8, $9, $8
	bne     be_else.31060
be_then.31060:
	mov     $8, $4
.count b_cont
	b       be_cont.31060
be_else.31060:
	load    [$1 + 9], $10
	fmul    $5, $6, $9
	load    [$1 + 9], $11
	load    [$10 + 0], $10
	fmul    $6, $4, $6
	fmul    $9, $10, $9
	fmul    $4, $5, $4
	load    [$11 + 1], $10
	load    [$1 + 9], $5
	fadd    $8, $9, $8
	fmul    $6, $10, $6
	load    [$5 + 2], $5
	fmul    $4, $5, $4
	fadd    $8, $6, $6
	fadd    $6, $4, $4
be_cont.31060:
	cmp     $7, 3
	bne     be_cont.31061
be_then.31061:
	fsub    $4, $36, $4
be_cont.31061:
	fmul    $3, $4, $3
	fsub    $14, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31062
ble_then.31062:
	li      0, $1
	ret
ble_else.31062:
	load    [$1 + 6], $1
	load    [$2 + 4], $2
	cmp     $1, 0
	fsqrt   $3, $1
	bne     be_else.31063
be_then.31063:
	fsub    $12, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31063:
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
	load    [min_caml_objects + $2], $4
	load    [$3 + 1], $1
	load    [$4 + 10], $5
	load    [$4 + 1], $6
	load    [$1 + $2], $1
	load    [$5 + 0], $7
	load    [$5 + 1], $8
	load    [$5 + 2], $9
	cmp     $6, 1
	bne     be_else.31064
be_then.31064:
	load    [$1 + 0], $6
	load    [$1 + 1], $10
	load    [$3 + 0], $2
	fsub    $6, $7, $6
	load    [$4 + 4], $3
	load    [$2 + 1], $5
	load    [$3 + 1], $3
	fmul    $6, $10, $6
	fmul    $6, $5, $5
	fadd    $5, $8, $5
	fabs    $5, $5
	fcmp    $3, $5
	bg      ble_else.31065
ble_then.31065:
	li      0, $5
.count b_cont
	b       ble_cont.31065
ble_else.31065:
	load    [$2 + 2], $10
	load    [$4 + 4], $5
	fmul    $6, $10, $10
	load    [$5 + 2], $5
	fadd    $10, $9, $10
	fabs    $10, $10
	fcmp    $5, $10
	bg      ble_else.31066
ble_then.31066:
	li      0, $5
.count b_cont
	b       ble_cont.31066
ble_else.31066:
	load    [$1 + 1], $5
	fcmp    $5, $zero
	bne     be_else.31067
be_then.31067:
	li      0, $5
.count b_cont
	b       be_cont.31067
be_else.31067:
	li      1, $5
be_cont.31067:
ble_cont.31066:
ble_cont.31065:
	cmp     $5, 0
	bne     be_else.31068
be_then.31068:
	load    [$1 + 2], $10
	load    [$1 + 3], $11
	load    [$2 + 0], $6
	fsub    $10, $8, $10
	load    [$4 + 4], $5
	load    [$5 + 0], $5
	fmul    $10, $11, $10
	fmul    $10, $6, $6
	fadd    $6, $7, $6
	fabs    $6, $6
	fcmp    $5, $6
	bg      ble_else.31069
ble_then.31069:
	li      0, $4
.count b_cont
	b       ble_cont.31069
ble_else.31069:
	load    [$2 + 2], $6
	load    [$4 + 4], $4
	fmul    $10, $6, $6
	load    [$4 + 2], $4
	fadd    $6, $9, $6
	fabs    $6, $6
	fcmp    $4, $6
	bg      ble_else.31070
ble_then.31070:
	li      0, $4
.count b_cont
	b       ble_cont.31070
ble_else.31070:
	load    [$1 + 3], $4
	fcmp    $4, $zero
	bne     be_else.31071
be_then.31071:
	li      0, $4
.count b_cont
	b       be_cont.31071
be_else.31071:
	li      1, $4
be_cont.31071:
ble_cont.31070:
ble_cont.31069:
	cmp     $4, 0
	bne     be_else.31072
be_then.31072:
	load    [$1 + 4], $6
	load    [$2 + 0], $4
	fsub    $6, $9, $6
	load    [$1 + 5], $9
	fmul    $6, $9, $6
	fmul    $6, $4, $4
	fadd    $4, $7, $4
	fabs    $4, $4
	fcmp    $5, $4
	bg      ble_else.31073
ble_then.31073:
	li      0, $1
	ret
ble_else.31073:
	load    [$2 + 1], $2
	fmul    $6, $2, $2
	fadd    $2, $8, $2
	fabs    $2, $2
	fcmp    $3, $2
	bg      ble_else.31074
ble_then.31074:
	li      0, $1
	ret
ble_else.31074:
	load    [$1 + 5], $1
	fcmp    $1, $zero
	bne     be_else.31075
be_then.31075:
	li      0, $1
	ret
be_else.31075:
.count move_float
	mov     $6, $42
	li      3, $1
	ret
be_else.31072:
.count move_float
	mov     $10, $42
	li      2, $1
	ret
be_else.31068:
.count move_float
	mov     $6, $42
	li      1, $1
	ret
be_else.31064:
	cmp     $6, 2
	bne     be_else.31076
be_then.31076:
	load    [$1 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31077
ble_then.31077:
	li      0, $1
	ret
ble_else.31077:
	load    [$5 + 3], $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31076:
	load    [$1 + 0], $2
	fcmp    $2, $zero
	bne     be_else.31078
be_then.31078:
	li      0, $1
	ret
be_else.31078:
	load    [$1 + 2], $6
	load    [$1 + 1], $3
	load    [$5 + 3], $5
	fmul    $6, $8, $6
	fmul    $3, $7, $3
	fmul    $2, $5, $2
	load    [$1 + 3], $7
	fadd    $3, $6, $3
	fmul    $7, $9, $7
	fadd    $3, $7, $3
	fmul    $3, $3, $5
	fsub    $5, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31079
ble_then.31079:
	li      0, $1
	ret
ble_else.31079:
	load    [$4 + 6], $4
	load    [$1 + 4], $1
	fsqrt   $2, $2
	cmp     $4, 0
	bne     be_else.31080
be_then.31080:
	fsub    $3, $2, $2
	fmul    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31080:
	fadd    $3, $2, $2
	fmul    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver_fast2

######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
	cmp     $3, 0
	bl      bge_else.31081
bge_then.31081:
	load    [min_caml_objects + $3], $12
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 0], $11
	load    [$12 + 1], $13
	load    [$2 + 1], $10
.count stack_store
	store   $2, [$sp + 0]
	cmp     $13, 1
.count stack_store
	store   $3, [$sp + 1]
.count move_args
	mov     $zero, $3
	bne     be_else.31082
be_then.31082:
	li      6, $2
	call    min_caml_create_array
	load    [$11 + 0], $14
.count move_ret
	mov     $1, $13
	fcmp    $14, $zero
	bne     be_else.31083
be_then.31083:
	store   $zero, [$13 + 1]
.count b_cont
	b       be_cont.31083
be_else.31083:
	load    [$12 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31084
ble_then.31084:
	li      0, $14
.count b_cont
	b       ble_cont.31084
ble_else.31084:
	li      1, $14
ble_cont.31084:
	cmp     $15, 0
	be      bne_cont.31085
bne_then.31085:
	cmp     $14, 0
	bne     be_else.31086
be_then.31086:
	li      1, $14
.count b_cont
	b       be_cont.31086
be_else.31086:
	li      0, $14
be_cont.31086:
bne_cont.31085:
	load    [$12 + 4], $15
	cmp     $14, 0
	load    [$15 + 0], $15
	bne     be_else.31087
be_then.31087:
	fneg    $15, $14
	store   $14, [$13 + 0]
	load    [$11 + 0], $14
	finv    $14, $14
	store   $14, [$13 + 1]
.count b_cont
	b       be_cont.31087
be_else.31087:
	store   $15, [$13 + 0]
	load    [$11 + 0], $14
	finv    $14, $14
	store   $14, [$13 + 1]
be_cont.31087:
be_cont.31083:
	load    [$11 + 1], $14
	fcmp    $14, $zero
	bne     be_else.31088
be_then.31088:
	store   $zero, [$13 + 3]
.count b_cont
	b       be_cont.31088
be_else.31088:
	load    [$12 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31089
ble_then.31089:
	li      0, $14
.count b_cont
	b       ble_cont.31089
ble_else.31089:
	li      1, $14
ble_cont.31089:
	cmp     $15, 0
	be      bne_cont.31090
bne_then.31090:
	cmp     $14, 0
	bne     be_else.31091
be_then.31091:
	li      1, $14
.count b_cont
	b       be_cont.31091
be_else.31091:
	li      0, $14
be_cont.31091:
bne_cont.31090:
	load    [$12 + 4], $15
	cmp     $14, 0
	load    [$15 + 1], $15
	bne     be_else.31092
be_then.31092:
	fneg    $15, $14
	store   $14, [$13 + 2]
	load    [$11 + 1], $14
	finv    $14, $14
	store   $14, [$13 + 3]
.count b_cont
	b       be_cont.31092
be_else.31092:
	store   $15, [$13 + 2]
	load    [$11 + 1], $14
	finv    $14, $14
	store   $14, [$13 + 3]
be_cont.31092:
be_cont.31088:
	load    [$11 + 2], $14
	fcmp    $14, $zero
	bne     be_else.31093
be_then.31093:
	store   $zero, [$13 + 5]
	mov     $13, $12
.count b_cont
	b       be_cont.31093
be_else.31093:
	load    [$12 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31094
ble_then.31094:
	li      0, $14
.count b_cont
	b       ble_cont.31094
ble_else.31094:
	li      1, $14
ble_cont.31094:
	cmp     $15, 0
	be      bne_cont.31095
bne_then.31095:
	cmp     $14, 0
	bne     be_else.31096
be_then.31096:
	li      1, $14
.count b_cont
	b       be_cont.31096
be_else.31096:
	li      0, $14
be_cont.31096:
bne_cont.31095:
	load    [$12 + 4], $12
	cmp     $14, 0
	load    [$12 + 2], $12
	bne     be_else.31097
be_then.31097:
	fneg    $12, $12
	store   $12, [$13 + 4]
	load    [$11 + 2], $12
	finv    $12, $12
	store   $12, [$13 + 5]
	mov     $13, $12
.count b_cont
	b       be_cont.31097
be_else.31097:
	store   $12, [$13 + 4]
	load    [$11 + 2], $12
	finv    $12, $12
	store   $12, [$13 + 5]
	mov     $13, $12
be_cont.31097:
be_cont.31093:
.count stack_load
	load    [$sp + 1], $13
.count storer
	add     $10, $13, $tmp
	store   $12, [$tmp + 0]
	sub     $13, 1, $12
	cmp     $12, 0
	bl      bge_else.31098
bge_then.31098:
	load    [min_caml_objects + $12], $13
.count move_args
	mov     $zero, $3
	load    [$13 + 1], $14
	cmp     $14, 1
	bne     be_else.31099
be_then.31099:
	li      6, $2
	call    min_caml_create_array
	load    [$11 + 0], $2
.count stack_move
	add     $sp, 2, $sp
	fcmp    $2, $zero
	bne     be_else.31100
be_then.31100:
	store   $zero, [$1 + 1]
.count b_cont
	b       be_cont.31100
be_else.31100:
	load    [$13 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31101
ble_then.31101:
	li      0, $2
.count b_cont
	b       ble_cont.31101
ble_else.31101:
	li      1, $2
ble_cont.31101:
	cmp     $3, 0
	be      bne_cont.31102
bne_then.31102:
	cmp     $2, 0
	bne     be_else.31103
be_then.31103:
	li      1, $2
.count b_cont
	b       be_cont.31103
be_else.31103:
	li      0, $2
be_cont.31103:
bne_cont.31102:
	load    [$13 + 4], $3
	cmp     $2, 0
	load    [$3 + 0], $3
	bne     be_else.31104
be_then.31104:
	fneg    $3, $2
	store   $2, [$1 + 0]
	load    [$11 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
.count b_cont
	b       be_cont.31104
be_else.31104:
	store   $3, [$1 + 0]
	load    [$11 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
be_cont.31104:
be_cont.31100:
	load    [$11 + 1], $2
	fcmp    $2, $zero
	bne     be_else.31105
be_then.31105:
	store   $zero, [$1 + 3]
.count b_cont
	b       be_cont.31105
be_else.31105:
	load    [$13 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31106
ble_then.31106:
	li      0, $2
.count b_cont
	b       ble_cont.31106
ble_else.31106:
	li      1, $2
ble_cont.31106:
	cmp     $3, 0
	be      bne_cont.31107
bne_then.31107:
	cmp     $2, 0
	bne     be_else.31108
be_then.31108:
	li      1, $2
.count b_cont
	b       be_cont.31108
be_else.31108:
	li      0, $2
be_cont.31108:
bne_cont.31107:
	load    [$13 + 4], $3
	cmp     $2, 0
	load    [$3 + 1], $3
	bne     be_else.31109
be_then.31109:
	fneg    $3, $2
	store   $2, [$1 + 2]
	load    [$11 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
.count b_cont
	b       be_cont.31109
be_else.31109:
	store   $3, [$1 + 2]
	load    [$11 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
be_cont.31109:
be_cont.31105:
	load    [$11 + 2], $2
	fcmp    $2, $zero
	bne     be_else.31110
be_then.31110:
	store   $zero, [$1 + 5]
.count storer
	add     $10, $12, $tmp
	sub     $12, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31110:
	load    [$13 + 6], $3
	load    [$13 + 4], $4
	fcmp    $zero, $2
	bg      ble_else.31111
ble_then.31111:
	li      0, $2
.count b_cont
	b       ble_cont.31111
ble_else.31111:
	li      1, $2
ble_cont.31111:
	cmp     $3, 0
	be      bne_cont.31112
bne_then.31112:
	cmp     $2, 0
	bne     be_else.31113
be_then.31113:
	li      1, $2
.count b_cont
	b       be_cont.31113
be_else.31113:
	li      0, $2
be_cont.31113:
bne_cont.31112:
	load    [$4 + 2], $3
	cmp     $2, 0
	bne     be_else.31114
be_then.31114:
	fneg    $3, $2
.count b_cont
	b       be_cont.31114
be_else.31114:
	mov     $3, $2
be_cont.31114:
	store   $2, [$1 + 4]
.count storer
	add     $10, $12, $tmp
	load    [$11 + 2], $2
	sub     $12, 1, $3
	finv    $2, $2
	store   $2, [$1 + 5]
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31099:
	cmp     $14, 2
	bne     be_else.31115
be_then.31115:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $2
	load    [$11 + 0], $5
	load    [$13 + 4], $3
	load    [$2 + 0], $2
	load    [$13 + 4], $4
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$4 + 2], $4
	load    [$11 + 1], $5
.count stack_move
	add     $sp, 2, $sp
.count storer
	add     $10, $12, $tmp
	fmul    $5, $3, $3
	load    [$11 + 2], $5
	fadd    $2, $3, $2
	fmul    $5, $4, $3
	fadd    $2, $3, $2
	fcmp    $2, $zero
	bg      ble_else.31116
ble_then.31116:
	store   $zero, [$1 + 0]
	sub     $12, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.31116:
	finv    $2, $2
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
	fmul    $3, $2, $2
	sub     $12, 1, $3
	fneg    $2, $2
	store   $2, [$1 + 3]
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31115:
	li      5, $2
	call    min_caml_create_array
	load    [$11 + 0], $6
	load    [$11 + 1], $7
	load    [$13 + 4], $3
	load    [$13 + 4], $4
	fmul    $6, $6, $9
	fmul    $7, $7, $14
	load    [$11 + 2], $8
	load    [$3 + 0], $3
	load    [$4 + 1], $4
	load    [$13 + 4], $5
	fmul    $8, $8, $15
	fmul    $9, $3, $3
	fmul    $14, $4, $4
	load    [$5 + 2], $5
	load    [$13 + 3], $2
.count stack_move
	add     $sp, 2, $sp
	fmul    $15, $5, $5
	fadd    $3, $4, $3
	cmp     $2, 0
	fadd    $3, $5, $3
	be      bne_cont.31117
bne_then.31117:
	load    [$13 + 9], $5
	fmul    $7, $8, $4
	load    [$13 + 9], $9
	load    [$5 + 0], $5
	fmul    $8, $6, $8
	fmul    $4, $5, $4
	fmul    $6, $7, $6
	load    [$9 + 1], $5
	load    [$13 + 9], $7
	fadd    $3, $4, $3
	fmul    $8, $5, $5
	load    [$7 + 2], $4
	fmul    $6, $4, $4
	fadd    $3, $5, $3
	fadd    $3, $4, $3
bne_cont.31117:
	store   $3, [$1 + 0]
	load    [$13 + 4], $4
	load    [$11 + 0], $7
	load    [$13 + 4], $5
	load    [$4 + 0], $4
	load    [$13 + 4], $6
	load    [$5 + 1], $5
	fmul    $7, $4, $4
	load    [$11 + 2], $8
	load    [$11 + 1], $7
	load    [$6 + 2], $6
	cmp     $2, 0
	fmul    $7, $5, $5
	fmul    $8, $6, $6
	fneg    $4, $4
.count storer
	add     $10, $12, $tmp
	fneg    $5, $5
	fneg    $6, $6
	bne     be_else.31118
be_then.31118:
	store   $4, [$1 + 1]
	fcmp    $3, $zero
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	bne     be_else.31119
be_then.31119:
	store   $1, [$tmp + 0]
	sub     $12, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31119:
	finv    $3, $2
	sub     $12, 1, $3
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31118:
	load    [$13 + 9], $9
	load    [$13 + 9], $2
	fcmp    $3, $zero
	load    [$9 + 2], $9
	load    [$2 + 1], $2
	fmul    $7, $9, $7
	fmul    $8, $2, $8
	fadd    $8, $7, $7
	fmul    $7, $39, $7
	fsub    $4, $7, $4
	store   $4, [$1 + 1]
	load    [$11 + 2], $7
	load    [$13 + 9], $4
	load    [$11 + 0], $8
	load    [$4 + 0], $4
	fmul    $8, $9, $8
	fmul    $7, $4, $7
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $5, $7, $5
	store   $5, [$1 + 2]
	load    [$11 + 0], $7
	load    [$11 + 1], $5
	fmul    $7, $2, $2
	fmul    $5, $4, $4
	fadd    $4, $2, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	bne     be_else.31120
be_then.31120:
	store   $1, [$tmp + 0]
	sub     $12, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31120:
	finv    $3, $2
	sub     $12, 1, $3
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31098:
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.31082:
	cmp     $13, 2
	bne     be_else.31121
be_then.31121:
	li      4, $2
	call    min_caml_create_array
	load    [$12 + 4], $2
	load    [$11 + 0], $5
	load    [$12 + 4], $3
	load    [$2 + 0], $2
	load    [$12 + 4], $4
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$4 + 2], $4
	load    [$11 + 1], $5
.count stack_move
	add     $sp, 2, $sp
	fmul    $5, $3, $3
	load    [$11 + 2], $5
	fadd    $2, $3, $2
	fmul    $5, $4, $3
	fadd    $2, $3, $2
	fcmp    $2, $zero
	bg      ble_else.31122
ble_then.31122:
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
ble_else.31122:
	finv    $2, $2
	fneg    $2, $3
	store   $3, [$1 + 0]
	load    [$12 + 4], $3
	load    [$3 + 0], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 1]
	load    [$12 + 4], $3
	load    [$3 + 1], $3
	fmul    $3, $2, $3
	fneg    $3, $3
	store   $3, [$1 + 2]
	load    [$12 + 4], $3
	load    [$3 + 2], $3
	fmul    $3, $2, $2
	fneg    $2, $2
	store   $2, [$1 + 3]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31121:
	li      5, $2
	call    min_caml_create_array
	load    [$11 + 0], $6
	load    [$11 + 1], $7
	load    [$12 + 4], $3
	load    [$12 + 4], $4
	fmul    $6, $6, $9
	fmul    $7, $7, $13
	load    [$11 + 2], $8
	load    [$3 + 0], $3
	load    [$4 + 1], $4
	load    [$12 + 4], $5
	fmul    $8, $8, $14
	fmul    $9, $3, $3
	fmul    $13, $4, $4
	load    [$5 + 2], $5
	load    [$12 + 3], $2
.count stack_move
	add     $sp, 2, $sp
	fmul    $14, $5, $5
	fadd    $3, $4, $3
	cmp     $2, 0
	fadd    $3, $5, $3
	be      bne_cont.31123
bne_then.31123:
	load    [$12 + 9], $5
	fmul    $7, $8, $4
	load    [$12 + 9], $9
	load    [$5 + 0], $5
	fmul    $8, $6, $8
	fmul    $4, $5, $4
	fmul    $6, $7, $6
	load    [$9 + 1], $5
	load    [$12 + 9], $7
	fadd    $3, $4, $3
	fmul    $8, $5, $5
	load    [$7 + 2], $4
	fmul    $6, $4, $4
	fadd    $3, $5, $3
	fadd    $3, $4, $3
bne_cont.31123:
	store   $3, [$1 + 0]
	load    [$12 + 4], $4
	load    [$11 + 0], $7
	load    [$12 + 4], $5
	load    [$4 + 0], $4
	load    [$12 + 4], $6
	load    [$5 + 1], $5
	fmul    $7, $4, $4
	load    [$11 + 2], $8
	load    [$11 + 1], $7
	load    [$6 + 2], $6
	cmp     $2, 0
	fmul    $7, $5, $5
	fmul    $8, $6, $6
	fneg    $4, $4
	fneg    $5, $5
	fneg    $6, $6
	bne     be_else.31124
be_then.31124:
	store   $4, [$1 + 1]
	fcmp    $3, $zero
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	bne     be_else.31125
be_then.31125:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31125:
	finv    $3, $2
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31124:
	load    [$12 + 9], $9
	load    [$12 + 9], $2
	fcmp    $3, $zero
	load    [$9 + 2], $9
	load    [$2 + 1], $2
	fmul    $7, $9, $7
	fmul    $8, $2, $8
	fadd    $8, $7, $7
	fmul    $7, $39, $7
	fsub    $4, $7, $4
	store   $4, [$1 + 1]
	load    [$11 + 2], $7
	load    [$12 + 9], $4
	load    [$11 + 0], $8
	load    [$4 + 0], $4
	fmul    $8, $9, $8
	fmul    $7, $4, $7
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $5, $7, $5
	store   $5, [$1 + 2]
	load    [$11 + 0], $7
	load    [$11 + 1], $5
	fmul    $7, $2, $2
	fmul    $5, $4, $4
	fadd    $4, $2, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	bne     be_else.31126
be_then.31126:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31126:
	finv    $3, $2
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31081:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	cmp     $3, 0
	bl      bge_else.31127
bge_then.31127:
	load    [min_caml_objects + $3], $1
	load    [$2 + 0], $4
	load    [$1 + 5], $5
	load    [$1 + 10], $6
	load    [$5 + 0], $5
	fsub    $4, $5, $4
	store   $4, [$6 + 0]
	load    [$2 + 1], $5
	load    [$1 + 5], $4
	load    [$4 + 1], $4
	fsub    $5, $4, $4
	store   $4, [$6 + 1]
	load    [$2 + 2], $5
	load    [$1 + 5], $4
	load    [$4 + 2], $4
	fsub    $5, $4, $4
	store   $4, [$6 + 2]
	load    [$1 + 1], $4
	cmp     $4, 2
	bne     be_else.31128
be_then.31128:
	load    [$1 + 4], $1
	load    [$6 + 0], $4
	sub     $3, 1, $3
	load    [$1 + 0], $5
	load    [$1 + 1], $7
	fmul    $5, $4, $4
	load    [$1 + 2], $1
	load    [$6 + 1], $5
	fmul    $7, $5, $5
	load    [$6 + 2], $7
	fadd    $4, $5, $4
	fmul    $1, $7, $1
	fadd    $4, $1, $1
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
be_else.31128:
	cmp     $4, 2
	bg      ble_else.31129
ble_then.31129:
	sub     $3, 1, $3
	b       setup_startp_constants.2831
ble_else.31129:
	load    [$6 + 0], $10
	load    [$6 + 1], $11
	load    [$1 + 4], $5
	load    [$1 + 4], $7
	fmul    $10, $10, $12
	fmul    $11, $11, $14
	load    [$6 + 2], $13
	load    [$5 + 0], $5
	load    [$7 + 1], $7
	load    [$1 + 4], $8
	fmul    $13, $13, $15
	fmul    $12, $5, $5
	fmul    $14, $7, $7
	load    [$8 + 2], $8
	load    [$1 + 3], $9
	fmul    $15, $8, $8
	fadd    $5, $7, $5
	cmp     $9, 0
	fadd    $5, $8, $5
	bne     be_else.31130
be_then.31130:
	mov     $5, $1
.count b_cont
	b       be_cont.31130
be_else.31130:
	load    [$1 + 9], $7
	fmul    $11, $13, $9
	load    [$1 + 9], $8
	load    [$7 + 0], $7
	fmul    $13, $10, $12
	load    [$8 + 1], $8
	fmul    $9, $7, $7
	load    [$1 + 9], $1
	fmul    $10, $11, $10
	fmul    $12, $8, $8
	load    [$1 + 2], $1
	fadd    $5, $7, $5
	fmul    $10, $1, $1
	fadd    $5, $8, $5
	fadd    $5, $1, $1
be_cont.31130:
	cmp     $4, 3
	sub     $3, 1, $3
	bne     be_else.31131
be_then.31131:
	fsub    $1, $36, $1
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
be_else.31131:
	store   $1, [$6 + 3]
	b       setup_startp_constants.2831
bge_else.31127:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$3 + $2], $1
	cmp     $1, -1
	bne     be_else.31132
be_then.31132:
	li      1, $1
	ret
be_else.31132:
	load    [min_caml_objects + $1], $1
	load    [$1 + 5], $8
	load    [$1 + 5], $9
	load    [$1 + 5], $10
	load    [$8 + 0], $8
	load    [$9 + 1], $9
	load    [$10 + 2], $10
	load    [$1 + 1], $7
	fsub    $4, $8, $8
	fsub    $5, $9, $9
	fsub    $6, $10, $10
	cmp     $7, 1
	bne     be_else.31133
be_then.31133:
	load    [$1 + 4], $7
	fabs    $8, $8
	load    [$7 + 0], $7
	fcmp    $7, $8
	bg      ble_else.31134
ble_then.31134:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31135
be_then.31135:
	li      1, $1
.count b_cont
	b       be_cont.31133
be_else.31135:
	li      0, $1
.count b_cont
	b       be_cont.31133
ble_else.31134:
	load    [$1 + 4], $7
	fabs    $9, $8
	load    [$7 + 1], $7
	fcmp    $7, $8
	bg      ble_else.31136
ble_then.31136:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31137
be_then.31137:
	li      1, $1
.count b_cont
	b       be_cont.31133
be_else.31137:
	li      0, $1
.count b_cont
	b       be_cont.31133
ble_else.31136:
	load    [$1 + 4], $7
	fabs    $10, $8
	load    [$1 + 6], $1
	load    [$7 + 2], $7
	fcmp    $7, $8
	bg      be_cont.31133
ble_then.31138:
	cmp     $1, 0
	bne     be_else.31139
be_then.31139:
	li      1, $1
.count b_cont
	b       be_cont.31133
be_else.31139:
	li      0, $1
.count b_cont
	b       be_cont.31133
be_else.31133:
	cmp     $7, 2
	bne     be_else.31140
be_then.31140:
	load    [$1 + 6], $7
	load    [$1 + 4], $1
	load    [$1 + 1], $12
	load    [$1 + 0], $11
	fmul    $12, $9, $9
	fmul    $11, $8, $8
	load    [$1 + 2], $1
	fmul    $1, $10, $1
	fadd    $8, $9, $8
	fadd    $8, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31141
ble_then.31141:
	cmp     $7, 0
	bne     be_else.31142
be_then.31142:
	li      1, $1
.count b_cont
	b       be_cont.31140
be_else.31142:
	li      0, $1
.count b_cont
	b       be_cont.31140
ble_else.31141:
	cmp     $7, 0
	bne     be_else.31143
be_then.31143:
	li      0, $1
.count b_cont
	b       be_cont.31140
be_else.31143:
	li      1, $1
.count b_cont
	b       be_cont.31140
be_else.31140:
	load    [$1 + 4], $13
	fmul    $8, $8, $12
	load    [$1 + 4], $15
	load    [$13 + 0], $13
	fmul    $9, $9, $14
	load    [$1 + 4], $16
	fmul    $12, $13, $12
	load    [$1 + 6], $11
	load    [$15 + 1], $13
	load    [$16 + 2], $16
	fmul    $10, $10, $15
	fmul    $14, $13, $13
	load    [$1 + 3], $14
	fadd    $12, $13, $12
	cmp     $14, 0
	fmul    $15, $16, $13
	fadd    $12, $13, $12
	bne     be_else.31144
be_then.31144:
	mov     $12, $1
.count b_cont
	b       be_cont.31144
be_else.31144:
	load    [$1 + 9], $14
	fmul    $9, $10, $13
	load    [$1 + 9], $15
	load    [$14 + 0], $14
	fmul    $10, $8, $10
	load    [$1 + 9], $1
	fmul    $13, $14, $13
	fmul    $8, $9, $8
	load    [$15 + 1], $14
	load    [$1 + 2], $1
	fmul    $10, $14, $9
	fmul    $8, $1, $1
	fadd    $12, $13, $10
	fadd    $10, $9, $9
	fadd    $9, $1, $1
be_cont.31144:
	cmp     $7, 3
	bne     be_cont.31145
be_then.31145:
	fsub    $1, $36, $1
be_cont.31145:
	fcmp    $zero, $1
	bg      ble_else.31146
ble_then.31146:
	cmp     $11, 0
	bne     be_else.31147
be_then.31147:
	li      1, $1
.count b_cont
	b       ble_cont.31146
be_else.31147:
	li      0, $1
.count b_cont
	b       ble_cont.31146
ble_else.31146:
	cmp     $11, 0
	bne     be_else.31148
be_then.31148:
	li      0, $1
.count b_cont
	b       be_cont.31148
be_else.31148:
	li      1, $1
be_cont.31148:
ble_cont.31146:
be_cont.31140:
be_cont.31133:
	cmp     $1, 0
	bne     be_else.31149
be_then.31149:
	add     $2, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31150
be_then.31150:
	li      1, $1
	ret
be_else.31150:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$7 + 0], $7
	load    [$8 + 1], $8
	load    [$9 + 2], $9
	load    [$2 + 1], $10
	fsub    $4, $7, $7
	fsub    $5, $8, $8
	fsub    $6, $9, $9
	cmp     $10, 1
	bne     be_else.31151
be_then.31151:
	load    [$2 + 4], $10
	fabs    $7, $7
	load    [$10 + 0], $10
	fcmp    $10, $7
	bg      ble_else.31152
ble_then.31152:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31153
be_then.31153:
	li      1, $2
.count b_cont
	b       be_cont.31151
be_else.31153:
	li      0, $2
.count b_cont
	b       be_cont.31151
ble_else.31152:
	load    [$2 + 4], $7
	fabs    $8, $8
	load    [$7 + 1], $7
	fcmp    $7, $8
	bg      ble_else.31154
ble_then.31154:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31155
be_then.31155:
	li      1, $2
.count b_cont
	b       be_cont.31151
be_else.31155:
	li      0, $2
.count b_cont
	b       be_cont.31151
ble_else.31154:
	load    [$2 + 4], $7
	fabs    $9, $8
	load    [$2 + 6], $2
	load    [$7 + 2], $7
	fcmp    $7, $8
	bg      be_cont.31151
ble_then.31156:
	cmp     $2, 0
	bne     be_else.31157
be_then.31157:
	li      1, $2
.count b_cont
	b       be_cont.31151
be_else.31157:
	li      0, $2
.count b_cont
	b       be_cont.31151
be_else.31151:
	cmp     $10, 2
	load    [$2 + 6], $10
	bne     be_else.31158
be_then.31158:
	load    [$2 + 4], $2
	load    [$2 + 1], $12
	load    [$2 + 0], $11
	fmul    $12, $8, $8
	fmul    $11, $7, $7
	load    [$2 + 2], $2
	fmul    $2, $9, $2
	fadd    $7, $8, $7
	fadd    $7, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31159
ble_then.31159:
	cmp     $10, 0
	bne     be_else.31160
be_then.31160:
	li      1, $2
.count b_cont
	b       be_cont.31158
be_else.31160:
	li      0, $2
.count b_cont
	b       be_cont.31158
ble_else.31159:
	cmp     $10, 0
	bne     be_else.31161
be_then.31161:
	li      0, $2
.count b_cont
	b       be_cont.31158
be_else.31161:
	li      1, $2
.count b_cont
	b       be_cont.31158
be_else.31158:
	load    [$2 + 4], $12
	load    [$2 + 4], $13
	fmul    $7, $7, $16
	fmul    $8, $8, $17
	load    [$12 + 0], $12
	load    [$13 + 1], $13
	load    [$2 + 4], $14
	fmul    $9, $9, $18
	fmul    $16, $12, $12
	fmul    $17, $13, $13
	load    [$14 + 2], $14
	load    [$2 + 3], $15
	load    [$2 + 1], $11
	fmul    $18, $14, $14
	fadd    $12, $13, $12
	cmp     $15, 0
	fadd    $12, $14, $12
	bne     be_else.31162
be_then.31162:
	mov     $12, $2
.count b_cont
	b       be_cont.31162
be_else.31162:
	fmul    $8, $9, $15
	load    [$2 + 9], $13
	fmul    $9, $7, $9
	load    [$2 + 9], $14
	load    [$13 + 0], $13
	fmul    $7, $8, $7
	load    [$2 + 9], $2
	fmul    $15, $13, $8
	load    [$14 + 1], $13
	load    [$2 + 2], $2
	fadd    $12, $8, $8
	fmul    $9, $13, $9
	fmul    $7, $2, $2
	fadd    $8, $9, $7
	fadd    $7, $2, $2
be_cont.31162:
	cmp     $11, 3
	bne     be_cont.31163
be_then.31163:
	fsub    $2, $36, $2
be_cont.31163:
	fcmp    $zero, $2
	bg      ble_else.31164
ble_then.31164:
	cmp     $10, 0
	bne     be_else.31165
be_then.31165:
	li      1, $2
.count b_cont
	b       ble_cont.31164
be_else.31165:
	li      0, $2
.count b_cont
	b       ble_cont.31164
ble_else.31164:
	cmp     $10, 0
	bne     be_else.31166
be_then.31166:
	li      0, $2
.count b_cont
	b       be_cont.31166
be_else.31166:
	li      1, $2
be_cont.31166:
ble_cont.31164:
be_cont.31158:
be_cont.31151:
	cmp     $2, 0
	bne     be_else.31167
be_then.31167:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31168
be_then.31168:
	li      1, $1
	ret
be_else.31168:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$2 + 5], $10
	load    [$8 + 0], $8
	load    [$9 + 1], $9
	load    [$10 + 2], $10
	load    [$2 + 1], $7
	fsub    $4, $8, $8
	fsub    $5, $9, $9
	fsub    $6, $10, $10
	cmp     $7, 1
	bne     be_else.31169
be_then.31169:
	load    [$2 + 4], $7
	fabs    $8, $8
	load    [$7 + 0], $7
	fcmp    $7, $8
	bg      ble_else.31170
ble_then.31170:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31171
be_then.31171:
	li      1, $2
.count b_cont
	b       be_cont.31169
be_else.31171:
	li      0, $2
.count b_cont
	b       be_cont.31169
ble_else.31170:
	load    [$2 + 4], $7
	fabs    $9, $8
	load    [$7 + 1], $7
	fcmp    $7, $8
	bg      ble_else.31172
ble_then.31172:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31173
be_then.31173:
	li      1, $2
.count b_cont
	b       be_cont.31169
be_else.31173:
	li      0, $2
.count b_cont
	b       be_cont.31169
ble_else.31172:
	load    [$2 + 4], $7
	fabs    $10, $8
	load    [$2 + 6], $2
	load    [$7 + 2], $7
	fcmp    $7, $8
	bg      be_cont.31169
ble_then.31174:
	cmp     $2, 0
	bne     be_else.31175
be_then.31175:
	li      1, $2
.count b_cont
	b       be_cont.31169
be_else.31175:
	li      0, $2
.count b_cont
	b       be_cont.31169
be_else.31169:
	cmp     $7, 2
	load    [$2 + 6], $7
	bne     be_else.31176
be_then.31176:
	load    [$2 + 4], $2
	load    [$2 + 1], $12
	load    [$2 + 0], $11
	fmul    $12, $9, $9
	fmul    $11, $8, $8
	load    [$2 + 2], $2
	fmul    $2, $10, $2
	fadd    $8, $9, $8
	fadd    $8, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31177
ble_then.31177:
	cmp     $7, 0
	bne     be_else.31178
be_then.31178:
	li      1, $2
.count b_cont
	b       be_cont.31176
be_else.31178:
	li      0, $2
.count b_cont
	b       be_cont.31176
ble_else.31177:
	cmp     $7, 0
	bne     be_else.31179
be_then.31179:
	li      0, $2
.count b_cont
	b       be_cont.31176
be_else.31179:
	li      1, $2
.count b_cont
	b       be_cont.31176
be_else.31176:
	load    [$2 + 4], $14
	fmul    $8, $8, $13
	load    [$2 + 4], $16
	load    [$14 + 0], $14
	fmul    $9, $9, $15
	load    [$2 + 4], $17
	fmul    $13, $14, $13
	load    [$2 + 3], $12
	load    [$16 + 1], $14
	load    [$2 + 1], $11
	fmul    $10, $10, $16
	fmul    $15, $14, $14
	cmp     $12, 0
	load    [$17 + 2], $15
	fadd    $13, $14, $13
	fmul    $16, $15, $14
	fadd    $13, $14, $13
	bne     be_else.31180
be_then.31180:
	mov     $13, $2
.count b_cont
	b       be_cont.31180
be_else.31180:
	load    [$2 + 9], $14
	fmul    $9, $10, $12
	load    [$2 + 9], $15
	load    [$14 + 0], $14
	fmul    $10, $8, $10
	load    [$2 + 9], $2
	fmul    $12, $14, $12
	fmul    $8, $9, $8
	load    [$15 + 1], $14
	load    [$2 + 2], $2
	fmul    $10, $14, $9
	fmul    $8, $2, $2
	fadd    $13, $12, $10
	fadd    $10, $9, $9
	fadd    $9, $2, $2
be_cont.31180:
	cmp     $11, 3
	bne     be_cont.31181
be_then.31181:
	fsub    $2, $36, $2
be_cont.31181:
	fcmp    $zero, $2
	bg      ble_else.31182
ble_then.31182:
	cmp     $7, 0
	bne     be_else.31183
be_then.31183:
	li      1, $2
.count b_cont
	b       ble_cont.31182
be_else.31183:
	li      0, $2
.count b_cont
	b       ble_cont.31182
ble_else.31182:
	cmp     $7, 0
	bne     be_else.31184
be_then.31184:
	li      0, $2
.count b_cont
	b       be_cont.31184
be_else.31184:
	li      1, $2
be_cont.31184:
ble_cont.31182:
be_cont.31176:
be_cont.31169:
	cmp     $2, 0
	bne     be_else.31185
be_then.31185:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31186
be_then.31186:
	li      1, $1
	ret
be_else.31186:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$7 + 0], $7
	load    [$8 + 1], $8
	load    [$9 + 2], $9
	load    [$2 + 1], $10
	fsub    $4, $7, $7
	fsub    $5, $8, $8
	fsub    $6, $9, $9
	cmp     $10, 1
	bne     be_else.31187
be_then.31187:
	load    [$2 + 4], $10
	fabs    $7, $7
	load    [$10 + 0], $10
	fcmp    $10, $7
	bg      ble_else.31188
ble_then.31188:
	li      0, $7
.count b_cont
	b       ble_cont.31188
ble_else.31188:
	load    [$2 + 4], $7
	fabs    $8, $8
	load    [$7 + 1], $7
	fcmp    $7, $8
	bg      ble_else.31189
ble_then.31189:
	li      0, $7
.count b_cont
	b       ble_cont.31189
ble_else.31189:
	load    [$2 + 4], $7
	fabs    $9, $8
	load    [$7 + 2], $7
	fcmp    $7, $8
	bg      ble_else.31190
ble_then.31190:
	li      0, $7
.count b_cont
	b       ble_cont.31190
ble_else.31190:
	li      1, $7
ble_cont.31190:
ble_cont.31189:
ble_cont.31188:
	cmp     $7, 0
	load    [$2 + 6], $2
	bne     be_else.31191
be_then.31191:
	cmp     $2, 0
	bne     be_else.31192
be_then.31192:
	li      0, $1
	ret
be_else.31192:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31191:
	cmp     $2, 0
	bne     be_else.31193
be_then.31193:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31193:
	li      0, $1
	ret
be_else.31187:
	cmp     $10, 2
	bne     be_else.31194
be_then.31194:
	load    [$2 + 6], $10
	load    [$2 + 4], $2
	load    [$2 + 1], $12
	load    [$2 + 0], $11
	fmul    $12, $8, $8
	fmul    $11, $7, $7
	load    [$2 + 2], $2
	fmul    $2, $9, $2
	fadd    $7, $8, $7
	fadd    $7, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31195
ble_then.31195:
	cmp     $10, 0
	bne     be_else.31196
be_then.31196:
	li      0, $1
	ret
be_else.31196:
	add     $1, 1, $2
	b       check_all_inside.2856
ble_else.31195:
	cmp     $10, 0
	bne     be_else.31197
be_then.31197:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31197:
	li      0, $1
	ret
be_else.31194:
	load    [$2 + 4], $12
	load    [$2 + 4], $13
	fmul    $7, $7, $16
	fmul    $8, $8, $17
	load    [$12 + 0], $12
	load    [$13 + 1], $13
	load    [$2 + 4], $14
	fmul    $9, $9, $18
	fmul    $16, $12, $12
	fmul    $17, $13, $13
	load    [$14 + 2], $14
	load    [$2 + 3], $15
	load    [$2 + 6], $11
	fmul    $18, $14, $14
	fadd    $12, $13, $12
	cmp     $15, 0
	fadd    $12, $14, $12
	bne     be_else.31198
be_then.31198:
	mov     $12, $2
.count b_cont
	b       be_cont.31198
be_else.31198:
	load    [$2 + 9], $14
	fmul    $8, $9, $13
	load    [$2 + 9], $15
	load    [$14 + 0], $14
	fmul    $9, $7, $9
	load    [$2 + 9], $2
	fmul    $13, $14, $13
	fmul    $7, $8, $7
	load    [$15 + 1], $14
	load    [$2 + 2], $2
	fmul    $9, $14, $8
	fmul    $7, $2, $2
	fadd    $12, $13, $9
	fadd    $9, $8, $8
	fadd    $8, $2, $2
be_cont.31198:
	cmp     $10, 3
	bne     be_cont.31199
be_then.31199:
	fsub    $2, $36, $2
be_cont.31199:
	fcmp    $zero, $2
	bg      ble_else.31200
ble_then.31200:
	cmp     $11, 0
	bne     be_else.31201
be_then.31201:
	li      0, $1
	ret
be_else.31201:
	add     $1, 1, $2
	b       check_all_inside.2856
ble_else.31200:
	cmp     $11, 0
	bne     be_else.31202
be_then.31202:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31202:
	li      0, $1
	ret
be_else.31185:
	li      0, $1
	ret
be_else.31167:
	li      0, $1
	ret
be_else.31149:
	li      0, $1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$3 + $2], $19
	cmp     $19, -1
	bne     be_else.31203
be_then.31203:
	li      0, $1
	ret
be_else.31203:
	load    [min_caml_objects + $19], $20
	load    [min_caml_intersection_point + 0], $26
	load    [min_caml_light_dirvec + 1], $21
	load    [$20 + 5], $22
	load    [$20 + 5], $23
	load    [$20 + 5], $24
	load    [$22 + 0], $22
	load    [$23 + 1], $23
	load    [$24 + 2], $24
	fsub    $26, $22, $22
	load    [$20 + 1], $25
	load    [min_caml_intersection_point + 1], $26
	load    [$21 + $19], $21
	cmp     $25, 1
	fsub    $26, $23, $23
	load    [min_caml_intersection_point + 2], $26
	fsub    $26, $24, $24
	bne     be_else.31204
be_then.31204:
	load    [$21 + 0], $28
	load    [$21 + 1], $29
	load    [min_caml_light_dirvec + 0], $25
	fsub    $28, $22, $28
	load    [$20 + 4], $26
	load    [$25 + 1], $27
	load    [$26 + 1], $26
	fmul    $28, $29, $28
	fmul    $28, $27, $27
	fadd    $27, $23, $27
	fabs    $27, $27
	fcmp    $26, $27
	bg      ble_else.31205
ble_then.31205:
	li      0, $26
.count b_cont
	b       ble_cont.31205
ble_else.31205:
	load    [$25 + 2], $27
	load    [$20 + 4], $26
	fmul    $28, $27, $27
	load    [$26 + 2], $26
	fadd    $27, $24, $27
	fabs    $27, $27
	fcmp    $26, $27
	bg      ble_else.31206
ble_then.31206:
	li      0, $26
.count b_cont
	b       ble_cont.31206
ble_else.31206:
	load    [$21 + 1], $26
	fcmp    $26, $zero
	bne     be_else.31207
be_then.31207:
	li      0, $26
.count b_cont
	b       be_cont.31207
be_else.31207:
	li      1, $26
be_cont.31207:
ble_cont.31206:
ble_cont.31205:
	cmp     $26, 0
	bne     be_else.31208
be_then.31208:
	load    [$21 + 2], $28
	load    [$21 + 3], $29
	load    [$25 + 0], $27
	fsub    $28, $23, $28
	load    [$20 + 4], $26
	load    [$26 + 0], $26
	fmul    $28, $29, $28
	fmul    $28, $27, $27
	fadd    $27, $22, $27
	fabs    $27, $27
	fcmp    $26, $27
	bg      ble_else.31209
ble_then.31209:
	li      0, $26
.count b_cont
	b       ble_cont.31209
ble_else.31209:
	load    [$25 + 2], $27
	load    [$20 + 4], $26
	fmul    $28, $27, $27
	load    [$26 + 2], $26
	fadd    $27, $24, $27
	fabs    $27, $27
	fcmp    $26, $27
	bg      ble_else.31210
ble_then.31210:
	li      0, $26
.count b_cont
	b       ble_cont.31210
ble_else.31210:
	load    [$21 + 3], $26
	fcmp    $26, $zero
	bne     be_else.31211
be_then.31211:
	li      0, $26
.count b_cont
	b       be_cont.31211
be_else.31211:
	li      1, $26
be_cont.31211:
ble_cont.31210:
ble_cont.31209:
	cmp     $26, 0
	bne     be_else.31212
be_then.31212:
	load    [$21 + 4], $28
	load    [$21 + 5], $29
	load    [$25 + 0], $27
	fsub    $28, $24, $24
	load    [$20 + 4], $26
	load    [$26 + 0], $26
	fmul    $24, $29, $24
	fmul    $24, $27, $27
	fadd    $27, $22, $22
	fabs    $22, $22
	fcmp    $26, $22
	bg      ble_else.31213
ble_then.31213:
	li      0, $20
.count b_cont
	b       be_cont.31204
ble_else.31213:
	load    [$25 + 1], $22
	load    [$20 + 4], $20
	fmul    $24, $22, $22
	load    [$20 + 1], $20
	fadd    $22, $23, $22
	fabs    $22, $22
	fcmp    $20, $22
	bg      ble_else.31214
ble_then.31214:
	li      0, $20
.count b_cont
	b       be_cont.31204
ble_else.31214:
	load    [$21 + 5], $20
	fcmp    $20, $zero
	bne     be_else.31215
be_then.31215:
	li      0, $20
.count b_cont
	b       be_cont.31204
be_else.31215:
.count move_float
	mov     $24, $42
	li      3, $20
.count b_cont
	b       be_cont.31204
be_else.31212:
.count move_float
	mov     $28, $42
	li      2, $20
.count b_cont
	b       be_cont.31204
be_else.31208:
.count move_float
	mov     $28, $42
	li      1, $20
.count b_cont
	b       be_cont.31204
be_else.31204:
	cmp     $25, 2
	bne     be_else.31216
be_then.31216:
	load    [$21 + 0], $20
	fcmp    $zero, $20
	bg      ble_else.31217
ble_then.31217:
	li      0, $20
.count b_cont
	b       be_cont.31216
ble_else.31217:
	load    [$21 + 1], $20
	load    [$21 + 2], $25
	fmul    $20, $22, $20
	load    [$21 + 3], $21
	fmul    $25, $23, $22
	fmul    $21, $24, $21
	fadd    $20, $22, $20
	fadd    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31216
be_else.31216:
	load    [$21 + 0], $26
	fcmp    $26, $zero
	bne     be_else.31218
be_then.31218:
	li      0, $20
.count b_cont
	b       be_cont.31218
be_else.31218:
	load    [$21 + 2], $28
	load    [$21 + 1], $27
	load    [$21 + 3], $29
	fmul    $28, $23, $28
	fmul    $27, $22, $27
	fmul    $29, $24, $29
	fmul    $22, $22, $30
	fmul    $23, $23, $31
	load    [$20 + 4], $33
	fadd    $27, $28, $27
	load    [$20 + 4], $28
	fadd    $27, $29, $27
	load    [$28 + 0], $28
	load    [$20 + 4], $29
	fmul    $30, $28, $28
	load    [$29 + 1], $29
	fmul    $24, $24, $30
	fmul    $27, $27, $32
	fmul    $31, $29, $29
	load    [$33 + 2], $31
	load    [$20 + 3], $33
	fmul    $30, $31, $30
	fadd    $28, $29, $28
	cmp     $33, 0
	fadd    $28, $30, $28
	bne     be_else.31219
be_then.31219:
	mov     $28, $22
.count b_cont
	b       be_cont.31219
be_else.31219:
	load    [$20 + 9], $30
	fmul    $23, $24, $29
	load    [$20 + 9], $31
	load    [$30 + 0], $30
	fmul    $24, $22, $24
	fmul    $29, $30, $29
	fmul    $22, $23, $22
	load    [$31 + 1], $30
	load    [$20 + 9], $23
	fadd    $28, $29, $28
	fmul    $24, $30, $24
	load    [$23 + 2], $23
	fmul    $22, $23, $22
	fadd    $28, $24, $24
	fadd    $24, $22, $22
be_cont.31219:
	cmp     $25, 3
	bne     be_cont.31220
be_then.31220:
	fsub    $22, $36, $22
be_cont.31220:
	fmul    $26, $22, $22
	fsub    $32, $22, $22
	fcmp    $22, $zero
	bg      ble_else.31221
ble_then.31221:
	li      0, $20
.count b_cont
	b       ble_cont.31221
ble_else.31221:
	load    [$20 + 6], $20
	load    [$21 + 4], $21
	cmp     $20, 0
	fsqrt   $22, $20
	bne     be_else.31222
be_then.31222:
	fsub    $27, $20, $20
	fmul    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31222
be_else.31222:
	fadd    $27, $20, $20
	fmul    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
be_cont.31222:
ble_cont.31221:
be_cont.31218:
be_cont.31216:
be_cont.31204:
	cmp     $20, 0
	bne     be_else.31223
be_then.31223:
	li      0, $20
.count b_cont
	b       be_cont.31223
be_else.31223:
.count load_float
	load    [f.27087], $20
	fcmp    $20, $42
	bg      ble_else.31224
ble_then.31224:
	li      0, $20
.count b_cont
	b       ble_cont.31224
ble_else.31224:
	li      1, $20
ble_cont.31224:
be_cont.31223:
	cmp     $20, 0
	bne     be_else.31225
be_then.31225:
	load    [min_caml_objects + $19], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31226
be_then.31226:
	li      0, $1
	ret
be_else.31226:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
be_else.31225:
	load    [$3 + 0], $19
	cmp     $19, -1
	bne     be_else.31227
be_then.31227:
	li      1, $1
	ret
be_else.31227:
.count load_float
	load    [f.27088], $24
	load    [min_caml_intersection_point + 0], $25
	load    [min_caml_intersection_point + 1], $27
	fadd    $42, $24, $24
	load    [min_caml_objects + $19], $19
	load    [$19 + 5], $20
	fmul    $55, $24, $26
	load    [$19 + 5], $21
	load    [$19 + 5], $22
	load    [$20 + 0], $20
	load    [$21 + 1], $21
	fadd    $26, $25, $4
	load    [$22 + 2], $22
	fmul    $56, $24, $25
	load    [$19 + 1], $23
	fmul    $57, $24, $24
	fsub    $4, $20, $20
	cmp     $23, 1
	fadd    $25, $27, $5
	load    [min_caml_intersection_point + 2], $25
	fadd    $24, $25, $6
	fsub    $5, $21, $21
	fsub    $6, $22, $22
	bne     be_else.31228
be_then.31228:
	load    [$19 + 4], $23
	fabs    $20, $20
	load    [$23 + 0], $23
	fcmp    $23, $20
	bg      ble_else.31229
ble_then.31229:
	load    [$19 + 6], $19
	cmp     $19, 0
	bne     be_else.31230
be_then.31230:
	li      1, $19
.count b_cont
	b       be_cont.31228
be_else.31230:
	li      0, $19
.count b_cont
	b       be_cont.31228
ble_else.31229:
	load    [$19 + 4], $20
	fabs    $21, $21
	load    [$20 + 1], $20
	fcmp    $20, $21
	bg      ble_else.31231
ble_then.31231:
	load    [$19 + 6], $19
	cmp     $19, 0
	bne     be_else.31232
be_then.31232:
	li      1, $19
.count b_cont
	b       be_cont.31228
be_else.31232:
	li      0, $19
.count b_cont
	b       be_cont.31228
ble_else.31231:
	load    [$19 + 4], $20
	fabs    $22, $21
	load    [$19 + 6], $19
	load    [$20 + 2], $20
	fcmp    $20, $21
	bg      be_cont.31228
ble_then.31233:
	cmp     $19, 0
	bne     be_else.31234
be_then.31234:
	li      1, $19
.count b_cont
	b       be_cont.31228
be_else.31234:
	li      0, $19
.count b_cont
	b       be_cont.31228
be_else.31228:
	cmp     $23, 2
	bne     be_else.31235
be_then.31235:
	load    [$19 + 6], $23
	load    [$19 + 4], $19
	load    [$19 + 1], $25
	load    [$19 + 0], $24
	fmul    $25, $21, $21
	fmul    $24, $20, $20
	load    [$19 + 2], $19
	fmul    $19, $22, $19
	fadd    $20, $21, $20
	fadd    $20, $19, $19
	fcmp    $zero, $19
	bg      ble_else.31236
ble_then.31236:
	cmp     $23, 0
	bne     be_else.31237
be_then.31237:
	li      1, $19
.count b_cont
	b       be_cont.31235
be_else.31237:
	li      0, $19
.count b_cont
	b       be_cont.31235
ble_else.31236:
	cmp     $23, 0
	bne     be_else.31238
be_then.31238:
	li      0, $19
.count b_cont
	b       be_cont.31235
be_else.31238:
	li      1, $19
.count b_cont
	b       be_cont.31235
be_else.31235:
	load    [$19 + 4], $26
	fmul    $20, $20, $25
	load    [$19 + 4], $28
	load    [$26 + 0], $26
	fmul    $21, $21, $27
	load    [$19 + 4], $29
	fmul    $25, $26, $25
	load    [$19 + 6], $24
	load    [$28 + 1], $26
	load    [$29 + 2], $29
	fmul    $22, $22, $28
	fmul    $27, $26, $26
	load    [$19 + 3], $27
	fadd    $25, $26, $25
	cmp     $27, 0
	fmul    $28, $29, $26
	fadd    $25, $26, $25
	bne     be_else.31239
be_then.31239:
	mov     $25, $19
.count b_cont
	b       be_cont.31239
be_else.31239:
	load    [$19 + 9], $27
	fmul    $21, $22, $26
	load    [$19 + 9], $28
	load    [$27 + 0], $27
	fmul    $22, $20, $22
	load    [$19 + 9], $19
	fmul    $26, $27, $26
	fmul    $20, $21, $20
	load    [$28 + 1], $27
	load    [$19 + 2], $19
	fmul    $22, $27, $21
	fmul    $20, $19, $19
	fadd    $25, $26, $22
	fadd    $22, $21, $21
	fadd    $21, $19, $19
be_cont.31239:
	cmp     $23, 3
	bne     be_cont.31240
be_then.31240:
	fsub    $19, $36, $19
be_cont.31240:
	fcmp    $zero, $19
	bg      ble_else.31241
ble_then.31241:
	cmp     $24, 0
	bne     be_else.31242
be_then.31242:
	li      1, $19
.count b_cont
	b       ble_cont.31241
be_else.31242:
	li      0, $19
.count b_cont
	b       ble_cont.31241
ble_else.31241:
	cmp     $24, 0
	bne     be_else.31243
be_then.31243:
	li      0, $19
.count b_cont
	b       be_cont.31243
be_else.31243:
	li      1, $19
be_cont.31243:
ble_cont.31241:
be_cont.31235:
be_cont.31228:
	cmp     $19, 0
	bne     be_else.31244
be_then.31244:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	li      1, $2
	call    check_all_inside.2856
.count stack_move
	add     $sp, 2, $sp
	cmp     $1, 0
	bne     be_else.31245
be_then.31245:
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 2], $3
	add     $1, 1, $2
	b       shadow_check_and_group.2862
be_else.31245:
	li      1, $1
	ret
be_else.31244:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$3 + $2], $34
	cmp     $34, -1
	bne     be_else.31246
be_then.31246:
	li      0, $1
	ret
be_else.31246:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	load    [min_caml_and_net + $34], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31247
be_then.31247:
.count stack_load
	load    [$sp + 1], $34
.count stack_load
	load    [$sp + 0], $35
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31248
be_then.31248:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31248:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31249
be_then.31249:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31250
be_then.31250:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31250:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31251
be_then.31251:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31252
be_then.31252:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31252:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31253
be_then.31253:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31254
be_then.31254:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31254:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31255
be_then.31255:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31256
be_then.31256:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31256:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31257
be_then.31257:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31258
be_then.31258:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31258:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31259
be_then.31259:
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31260
be_then.31260:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31260:
	li      0, $2
	load    [min_caml_and_net + $1], $3
	call    shadow_check_and_group.2862
.count stack_move
	add     $sp, 2, $sp
	cmp     $1, 0
	bne     be_else.31261
be_then.31261:
	add     $34, 1, $2
.count move_args
	mov     $35, $3
	b       shadow_check_one_or_group.2865
be_else.31261:
	li      1, $1
	ret
be_else.31259:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31257:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31255:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31253:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31251:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31249:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31247:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
.end shadow_check_one_or_group

######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$3 + $2], $34
	load    [$34 + 0], $35
	cmp     $35, -1
	bne     be_else.31262
be_then.31262:
	li      0, $1
	ret
be_else.31262:
.count stack_move
	sub     $sp, 7, $sp
	cmp     $35, 99
.count stack_store
	store   $34, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.31263
be_then.31263:
	li      1, $16
.count b_cont
	b       be_cont.31263
be_else.31263:
	load    [min_caml_objects + $35], $16
	load    [min_caml_intersection_point + 0], $17
	load    [min_caml_intersection_point + 1], $20
	load    [$16 + 5], $18
	load    [$16 + 5], $19
	load    [min_caml_light_dirvec + 1], $21
	load    [$18 + 0], $18
	load    [$16 + 1], $22
	load    [$21 + $35], $35
	fsub    $17, $18, $17
	cmp     $22, 1
	load    [$19 + 1], $18
	load    [$16 + 5], $19
	fsub    $20, $18, $18
	load    [$19 + 2], $19
	load    [min_caml_intersection_point + 2], $20
	fsub    $20, $19, $19
	bne     be_else.31264
be_then.31264:
	load    [$35 + 0], $23
	load    [$35 + 1], $24
	load    [min_caml_light_dirvec + 0], $20
	fsub    $23, $17, $23
	load    [$16 + 4], $21
	load    [$20 + 1], $22
	load    [$21 + 1], $21
	fmul    $23, $24, $23
	fmul    $23, $22, $22
	fadd    $22, $18, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31265
ble_then.31265:
	li      0, $21
.count b_cont
	b       ble_cont.31265
ble_else.31265:
	load    [$20 + 2], $22
	load    [$16 + 4], $21
	fmul    $23, $22, $22
	load    [$21 + 2], $21
	fadd    $22, $19, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31266
ble_then.31266:
	li      0, $21
.count b_cont
	b       ble_cont.31266
ble_else.31266:
	load    [$35 + 1], $21
	fcmp    $21, $zero
	bne     be_else.31267
be_then.31267:
	li      0, $21
.count b_cont
	b       be_cont.31267
be_else.31267:
	li      1, $21
be_cont.31267:
ble_cont.31266:
ble_cont.31265:
	cmp     $21, 0
	bne     be_else.31268
be_then.31268:
	load    [$35 + 2], $23
	load    [$35 + 3], $24
	load    [$20 + 0], $22
	fsub    $23, $18, $23
	load    [$16 + 4], $21
	load    [$21 + 0], $21
	fmul    $23, $24, $23
	fmul    $23, $22, $22
	fadd    $22, $17, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31269
ble_then.31269:
	li      0, $21
.count b_cont
	b       ble_cont.31269
ble_else.31269:
	load    [$20 + 2], $22
	load    [$16 + 4], $21
	fmul    $23, $22, $22
	load    [$21 + 2], $21
	fadd    $22, $19, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31270
ble_then.31270:
	li      0, $21
.count b_cont
	b       ble_cont.31270
ble_else.31270:
	load    [$35 + 3], $21
	fcmp    $21, $zero
	bne     be_else.31271
be_then.31271:
	li      0, $21
.count b_cont
	b       be_cont.31271
be_else.31271:
	li      1, $21
be_cont.31271:
ble_cont.31270:
ble_cont.31269:
	cmp     $21, 0
	bne     be_else.31272
be_then.31272:
	load    [$35 + 4], $23
	load    [$35 + 5], $24
	load    [$20 + 0], $22
	fsub    $23, $19, $19
	load    [$16 + 4], $21
	load    [$21 + 0], $21
	fmul    $19, $24, $19
	fmul    $19, $22, $22
	fadd    $22, $17, $17
	fabs    $17, $17
	fcmp    $21, $17
	bg      ble_else.31273
ble_then.31273:
	li      0, $35
.count b_cont
	b       be_cont.31264
ble_else.31273:
	load    [$20 + 1], $17
	load    [$16 + 4], $16
	fmul    $19, $17, $17
	load    [$16 + 1], $16
	fadd    $17, $18, $17
	fabs    $17, $17
	fcmp    $16, $17
	bg      ble_else.31274
ble_then.31274:
	li      0, $35
.count b_cont
	b       be_cont.31264
ble_else.31274:
	load    [$35 + 5], $35
	fcmp    $35, $zero
	bne     be_else.31275
be_then.31275:
	li      0, $35
.count b_cont
	b       be_cont.31264
be_else.31275:
.count move_float
	mov     $19, $42
	li      3, $35
.count b_cont
	b       be_cont.31264
be_else.31272:
.count move_float
	mov     $23, $42
	li      2, $35
.count b_cont
	b       be_cont.31264
be_else.31268:
.count move_float
	mov     $23, $42
	li      1, $35
.count b_cont
	b       be_cont.31264
be_else.31264:
	cmp     $22, 2
	bne     be_else.31276
be_then.31276:
	load    [$35 + 0], $16
	fcmp    $zero, $16
	bg      ble_else.31277
ble_then.31277:
	li      0, $35
.count b_cont
	b       be_cont.31276
ble_else.31277:
	load    [$35 + 1], $16
	load    [$35 + 2], $20
	fmul    $16, $17, $16
	load    [$35 + 3], $35
	fmul    $20, $18, $17
	fmul    $35, $19, $35
	fadd    $16, $17, $16
	fadd    $16, $35, $35
.count move_float
	mov     $35, $42
	li      1, $35
.count b_cont
	b       be_cont.31276
be_else.31276:
	load    [$35 + 0], $20
	fcmp    $20, $zero
	bne     be_else.31278
be_then.31278:
	li      0, $35
.count b_cont
	b       be_cont.31278
be_else.31278:
	load    [$35 + 2], $23
	load    [$35 + 1], $21
	load    [$35 + 3], $24
	fmul    $23, $18, $23
	fmul    $21, $17, $21
	fmul    $24, $19, $24
	fmul    $17, $17, $25
	fmul    $18, $18, $26
	load    [$16 + 4], $28
	fadd    $21, $23, $21
	load    [$16 + 4], $23
	fadd    $21, $24, $21
	load    [$23 + 0], $23
	load    [$16 + 4], $24
	fmul    $25, $23, $23
	load    [$24 + 1], $24
	fmul    $19, $19, $25
	fmul    $21, $21, $27
	fmul    $26, $24, $24
	load    [$28 + 2], $26
	load    [$16 + 3], $28
	fmul    $25, $26, $25
	fadd    $23, $24, $23
	cmp     $28, 0
	fadd    $23, $25, $23
	bne     be_else.31279
be_then.31279:
	mov     $23, $17
.count b_cont
	b       be_cont.31279
be_else.31279:
	load    [$16 + 9], $25
	fmul    $18, $19, $24
	load    [$16 + 9], $26
	load    [$25 + 0], $25
	fmul    $19, $17, $19
	fmul    $24, $25, $24
	fmul    $17, $18, $17
	load    [$26 + 1], $25
	load    [$16 + 9], $18
	fadd    $23, $24, $23
	fmul    $19, $25, $19
	load    [$18 + 2], $18
	fmul    $17, $18, $17
	fadd    $23, $19, $19
	fadd    $19, $17, $17
be_cont.31279:
	cmp     $22, 3
	bne     be_cont.31280
be_then.31280:
	fsub    $17, $36, $17
be_cont.31280:
	fmul    $20, $17, $17
	fsub    $27, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31281
ble_then.31281:
	li      0, $35
.count b_cont
	b       ble_cont.31281
ble_else.31281:
	load    [$16 + 6], $16
	load    [$35 + 4], $35
	cmp     $16, 0
	fsqrt   $17, $16
	bne     be_else.31282
be_then.31282:
	fsub    $21, $16, $16
	fmul    $16, $35, $35
.count move_float
	mov     $35, $42
	li      1, $35
.count b_cont
	b       be_cont.31282
be_else.31282:
	fadd    $21, $16, $16
	fmul    $16, $35, $35
.count move_float
	mov     $35, $42
	li      1, $35
be_cont.31282:
ble_cont.31281:
be_cont.31278:
be_cont.31276:
be_cont.31264:
	cmp     $35, 0
	bne     be_else.31283
be_then.31283:
	li      0, $16
.count b_cont
	b       be_cont.31283
be_else.31283:
.count load_float
	load    [f.27089], $35
	fcmp    $35, $42
	bg      ble_else.31284
ble_then.31284:
	li      0, $16
.count b_cont
	b       ble_cont.31284
ble_else.31284:
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31285
be_then.31285:
	li      0, $16
.count b_cont
	b       be_cont.31285
be_else.31285:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.31286
be_then.31286:
	li      2, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.31287
be_then.31287:
	li      0, $16
.count b_cont
	b       be_cont.31286
be_else.31287:
	li      1, $16
.count b_cont
	b       be_cont.31286
be_else.31286:
	li      1, $16
be_cont.31286:
be_cont.31285:
ble_cont.31284:
be_cont.31283:
be_cont.31263:
	cmp     $16, 0
	bne     be_else.31288
be_then.31288:
.count stack_load
	load    [$sp + 2], $16
.count stack_load
	load    [$sp + 1], $17
	add     $16, 1, $16
	load    [$17 + $16], $18
	load    [$18 + 0], $2
	cmp     $2, -1
	bne     be_else.31289
be_then.31289:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31289:
.count stack_store
	store   $18, [$sp + 3]
	cmp     $2, 99
.count stack_store
	store   $16, [$sp + 4]
	bne     be_else.31290
be_then.31290:
	li      1, $34
.count b_cont
	b       be_cont.31290
be_else.31290:
	call    solver_fast.2796
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31291
be_then.31291:
	li      0, $34
.count b_cont
	b       be_cont.31291
be_else.31291:
.count load_float
	load    [f.27089], $34
	fcmp    $34, $42
	bg      ble_else.31292
ble_then.31292:
	li      0, $34
.count b_cont
	b       ble_cont.31292
ble_else.31292:
	load    [$18 + 1], $34
	cmp     $34, -1
	bne     be_else.31293
be_then.31293:
	li      0, $34
.count b_cont
	b       be_cont.31293
be_else.31293:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31294
be_then.31294:
.count stack_load
	load    [$sp + 3], $34
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31295
be_then.31295:
	li      0, $34
.count b_cont
	b       be_cont.31294
be_else.31295:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31296
be_then.31296:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31297
be_then.31297:
	li      0, $34
.count b_cont
	b       be_cont.31294
be_else.31297:
	li      1, $34
.count b_cont
	b       be_cont.31294
be_else.31296:
	li      1, $34
.count b_cont
	b       be_cont.31294
be_else.31294:
	li      1, $34
be_cont.31294:
be_cont.31293:
ble_cont.31292:
be_cont.31291:
be_cont.31290:
	cmp     $34, 0
	bne     be_else.31298
be_then.31298:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31298:
.count stack_load
	load    [$sp + 3], $34
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31299
be_then.31299:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31299:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31300
be_then.31300:
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31301
be_then.31301:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31301:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31302
be_then.31302:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31303
be_then.31303:
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31303:
	li      1, $1
	ret
be_else.31302:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31300:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31288:
.count stack_load
	load    [$sp + 0], $34
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31304
be_then.31304:
	li      0, $16
.count b_cont
	b       be_cont.31304
be_else.31304:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31305
be_then.31305:
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31306
be_then.31306:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31306:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31307
be_then.31307:
	load    [$34 + 3], $35
	cmp     $35, -1
	bne     be_else.31308
be_then.31308:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31308:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31309
be_then.31309:
	load    [$34 + 4], $35
	cmp     $35, -1
	bne     be_else.31310
be_then.31310:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31310:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31311
be_then.31311:
	load    [$34 + 5], $35
	cmp     $35, -1
	bne     be_else.31312
be_then.31312:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31312:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31313
be_then.31313:
	load    [$34 + 6], $35
	cmp     $35, -1
	bne     be_else.31314
be_then.31314:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31314:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31315
be_then.31315:
	load    [$34 + 7], $35
	cmp     $35, -1
	bne     be_else.31316
be_then.31316:
	li      0, $16
.count b_cont
	b       be_cont.31305
be_else.31316:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.31317
be_then.31317:
	li      8, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.31305
be_else.31317:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31315:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31313:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31311:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31309:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31307:
	li      1, $16
.count b_cont
	b       be_cont.31305
be_else.31305:
	li      1, $16
be_cont.31305:
be_cont.31304:
	cmp     $16, 0
	bne     be_else.31318
be_then.31318:
.count stack_load
	load    [$sp + 2], $16
.count stack_load
	load    [$sp + 1], $17
	add     $16, 1, $16
	load    [$17 + $16], $18
	load    [$18 + 0], $2
	cmp     $2, -1
	bne     be_else.31319
be_then.31319:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31319:
.count stack_store
	store   $18, [$sp + 5]
	cmp     $2, 99
.count stack_store
	store   $16, [$sp + 6]
	bne     be_else.31320
be_then.31320:
	li      1, $34
.count b_cont
	b       be_cont.31320
be_else.31320:
	call    solver_fast.2796
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31321
be_then.31321:
	li      0, $34
.count b_cont
	b       be_cont.31321
be_else.31321:
.count load_float
	load    [f.27089], $34
	fcmp    $34, $42
	bg      ble_else.31322
ble_then.31322:
	li      0, $34
.count b_cont
	b       ble_cont.31322
ble_else.31322:
	load    [$18 + 1], $34
	cmp     $34, -1
	bne     be_else.31323
be_then.31323:
	li      0, $34
.count b_cont
	b       be_cont.31323
be_else.31323:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31324
be_then.31324:
.count stack_load
	load    [$sp + 5], $34
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31325
be_then.31325:
	li      0, $34
.count b_cont
	b       be_cont.31324
be_else.31325:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31326
be_then.31326:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31327
be_then.31327:
	li      0, $34
.count b_cont
	b       be_cont.31324
be_else.31327:
	li      1, $34
.count b_cont
	b       be_cont.31324
be_else.31326:
	li      1, $34
.count b_cont
	b       be_cont.31324
be_else.31324:
	li      1, $34
be_cont.31324:
be_cont.31323:
ble_cont.31322:
be_cont.31321:
be_cont.31320:
	cmp     $34, 0
	bne     be_else.31328
be_then.31328:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31328:
.count stack_load
	load    [$sp + 5], $34
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31329
be_then.31329:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31329:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31330
be_then.31330:
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31331
be_then.31331:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31331:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31332
be_then.31332:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31333
be_then.31333:
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31333:
	li      1, $1
	ret
be_else.31332:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31330:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31318:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
.end shadow_check_one_or_matrix

######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$3 + $2], $19
	cmp     $19, -1
	bne     be_else.31334
be_then.31334:
	ret
be_else.31334:
	load    [min_caml_objects + $19], $20
	load    [min_caml_startp + 0], $25
	load    [min_caml_startp + 1], $26
	load    [$20 + 5], $21
	load    [$20 + 5], $22
	load    [$20 + 5], $23
	load    [$21 + 0], $21
	load    [$22 + 1], $22
	load    [$23 + 2], $23
	fsub    $25, $21, $21
	load    [$20 + 1], $24
	load    [min_caml_startp + 2], $25
	fsub    $26, $22, $22
	cmp     $24, 1
	fsub    $25, $23, $23
	bne     be_else.31335
be_then.31335:
	load    [$4 + 0], $24
	fcmp    $24, $zero
	bne     be_else.31336
be_then.31336:
	li      0, $24
.count b_cont
	b       be_cont.31336
be_else.31336:
	load    [$20 + 4], $25
	load    [$20 + 6], $26
	fcmp    $zero, $24
	bg      ble_else.31337
ble_then.31337:
	li      0, $27
.count b_cont
	b       ble_cont.31337
ble_else.31337:
	li      1, $27
ble_cont.31337:
	cmp     $26, 0
	bne     be_else.31338
be_then.31338:
	mov     $27, $26
.count b_cont
	b       be_cont.31338
be_else.31338:
	cmp     $27, 0
	bne     be_else.31339
be_then.31339:
	li      1, $26
.count b_cont
	b       be_cont.31339
be_else.31339:
	li      0, $26
be_cont.31339:
be_cont.31338:
	load    [$25 + 0], $27
	cmp     $26, 0
	bne     be_else.31340
be_then.31340:
	fneg    $27, $26
.count b_cont
	b       be_cont.31340
be_else.31340:
	mov     $27, $26
be_cont.31340:
	fsub    $26, $21, $26
	finv    $24, $24
	load    [$4 + 1], $28
	load    [$25 + 1], $27
	fmul    $26, $24, $24
	fmul    $24, $28, $26
	fadd    $26, $22, $26
	fabs    $26, $26
	fcmp    $27, $26
	bg      ble_else.31341
ble_then.31341:
	li      0, $24
.count b_cont
	b       ble_cont.31341
ble_else.31341:
	load    [$4 + 2], $26
	load    [$25 + 2], $25
	fmul    $24, $26, $26
	fadd    $26, $23, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31342
ble_then.31342:
	li      0, $24
.count b_cont
	b       ble_cont.31342
ble_else.31342:
.count move_float
	mov     $24, $42
	li      1, $24
ble_cont.31342:
ble_cont.31341:
be_cont.31336:
	cmp     $24, 0
	bne     be_else.31343
be_then.31343:
	load    [$4 + 1], $24
	fcmp    $24, $zero
	bne     be_else.31344
be_then.31344:
	li      0, $24
.count b_cont
	b       be_cont.31344
be_else.31344:
	load    [$20 + 4], $25
	load    [$20 + 6], $26
	fcmp    $zero, $24
	bg      ble_else.31345
ble_then.31345:
	li      0, $27
.count b_cont
	b       ble_cont.31345
ble_else.31345:
	li      1, $27
ble_cont.31345:
	cmp     $26, 0
	bne     be_else.31346
be_then.31346:
	mov     $27, $26
.count b_cont
	b       be_cont.31346
be_else.31346:
	cmp     $27, 0
	bne     be_else.31347
be_then.31347:
	li      1, $26
.count b_cont
	b       be_cont.31347
be_else.31347:
	li      0, $26
be_cont.31347:
be_cont.31346:
	load    [$25 + 1], $27
	cmp     $26, 0
	bne     be_else.31348
be_then.31348:
	fneg    $27, $26
.count b_cont
	b       be_cont.31348
be_else.31348:
	mov     $27, $26
be_cont.31348:
	fsub    $26, $22, $26
	finv    $24, $24
	load    [$4 + 2], $28
	load    [$25 + 2], $27
	fmul    $26, $24, $24
	fmul    $24, $28, $26
	fadd    $26, $23, $26
	fabs    $26, $26
	fcmp    $27, $26
	bg      ble_else.31349
ble_then.31349:
	li      0, $24
.count b_cont
	b       ble_cont.31349
ble_else.31349:
	load    [$4 + 0], $26
	load    [$25 + 0], $25
	fmul    $24, $26, $26
	fadd    $26, $21, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31350
ble_then.31350:
	li      0, $24
.count b_cont
	b       ble_cont.31350
ble_else.31350:
.count move_float
	mov     $24, $42
	li      1, $24
ble_cont.31350:
ble_cont.31349:
be_cont.31344:
	cmp     $24, 0
	bne     be_else.31351
be_then.31351:
	load    [$4 + 2], $24
	fcmp    $24, $zero
	bne     be_else.31352
be_then.31352:
	li      0, $20
.count b_cont
	b       be_cont.31335
be_else.31352:
	load    [$20 + 4], $25
	load    [$4 + 0], $26
	load    [$20 + 6], $20
	load    [$25 + 0], $27
	fcmp    $zero, $24
	bg      ble_else.31353
ble_then.31353:
	li      0, $28
.count b_cont
	b       ble_cont.31353
ble_else.31353:
	li      1, $28
ble_cont.31353:
	cmp     $20, 0
	bne     be_else.31354
be_then.31354:
	mov     $28, $20
.count b_cont
	b       be_cont.31354
be_else.31354:
	cmp     $28, 0
	bne     be_else.31355
be_then.31355:
	li      1, $20
.count b_cont
	b       be_cont.31355
be_else.31355:
	li      0, $20
be_cont.31355:
be_cont.31354:
	load    [$25 + 2], $28
	cmp     $20, 0
	bne     be_else.31356
be_then.31356:
	fneg    $28, $20
.count b_cont
	b       be_cont.31356
be_else.31356:
	mov     $28, $20
be_cont.31356:
	fsub    $20, $23, $20
	finv    $24, $23
	fmul    $20, $23, $20
	fmul    $20, $26, $23
	fadd    $23, $21, $21
	fabs    $21, $21
	fcmp    $27, $21
	bg      ble_else.31357
ble_then.31357:
	li      0, $20
.count b_cont
	b       be_cont.31335
ble_else.31357:
	load    [$4 + 1], $23
	load    [$25 + 1], $21
	fmul    $20, $23, $23
	fadd    $23, $22, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31358
ble_then.31358:
	li      0, $20
.count b_cont
	b       be_cont.31335
ble_else.31358:
.count move_float
	mov     $20, $42
	li      3, $20
.count b_cont
	b       be_cont.31335
be_else.31351:
	li      2, $20
.count b_cont
	b       be_cont.31335
be_else.31343:
	li      1, $20
.count b_cont
	b       be_cont.31335
be_else.31335:
	cmp     $24, 2
	bne     be_else.31359
be_then.31359:
	load    [$20 + 4], $20
	load    [$4 + 1], $26
	load    [$4 + 0], $24
	load    [$20 + 1], $27
	load    [$20 + 0], $25
	load    [$4 + 2], $28
	fmul    $26, $27, $26
	fmul    $24, $25, $24
	load    [$20 + 2], $20
	fadd    $24, $26, $24
	fmul    $28, $20, $26
	fadd    $24, $26, $24
	fcmp    $24, $zero
	bg      ble_else.31360
ble_then.31360:
	li      0, $20
.count b_cont
	b       be_cont.31359
ble_else.31360:
	fmul    $27, $22, $22
	fmul    $25, $21, $21
	fmul    $20, $23, $20
	finv    $24, $23
	fadd    $21, $22, $21
	fadd    $21, $20, $20
	fneg    $20, $20
	fmul    $20, $23, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31359
be_else.31359:
	load    [$4 + 0], $28
	load    [$4 + 1], $29
	load    [$20 + 4], $25
	load    [$20 + 4], $26
	fmul    $28, $28, $31
	fmul    $29, $29, $32
	load    [$4 + 2], $30
	load    [$25 + 0], $25
	load    [$26 + 1], $26
	load    [$20 + 4], $27
	fmul    $30, $30, $33
	fmul    $31, $25, $31
	fmul    $32, $26, $32
	load    [$27 + 2], $27
	load    [$20 + 3], $24
	fmul    $33, $27, $33
	fadd    $31, $32, $31
	cmp     $24, 0
	fadd    $31, $33, $31
	be      bne_cont.31361
bne_then.31361:
	load    [$20 + 9], $33
	fmul    $29, $30, $32
	load    [$20 + 9], $35
	load    [$33 + 0], $33
	fmul    $30, $28, $34
	load    [$20 + 9], $1
	fmul    $32, $33, $32
	load    [$35 + 1], $33
	fmul    $28, $29, $35
	fadd    $31, $32, $31
	fmul    $34, $33, $33
	load    [$1 + 2], $32
	fmul    $35, $32, $32
	fadd    $31, $33, $31
	fadd    $31, $32, $31
bne_cont.31361:
	fcmp    $31, $zero
	bne     be_else.31362
be_then.31362:
	li      0, $20
.count b_cont
	b       be_cont.31362
be_else.31362:
	fmul    $28, $21, $33
	fmul    $29, $22, $34
	fmul    $30, $23, $35
	load    [$20 + 1], $32
	cmp     $24, 0
	fmul    $33, $25, $33
	fmul    $34, $26, $34
	fmul    $35, $27, $35
	fadd    $33, $34, $33
	fadd    $33, $35, $33
	bne     be_else.31363
be_then.31363:
	mov     $33, $28
.count b_cont
	b       be_cont.31363
be_else.31363:
	fmul    $29, $23, $35
	fmul    $30, $22, $34
	fmul    $28, $23, $5
	fmul    $30, $21, $30
	load    [$20 + 9], $1
	fmul    $29, $21, $29
	fadd    $34, $35, $34
	load    [$1 + 0], $1
	load    [$20 + 9], $35
	fmul    $28, $22, $28
	fadd    $5, $30, $30
	fmul    $34, $1, $34
	load    [$35 + 1], $35
	load    [$20 + 9], $1
	fadd    $28, $29, $28
	fmul    $30, $35, $30
	load    [$1 + 2], $35
	fmul    $28, $35, $28
	fadd    $34, $30, $29
	fadd    $29, $28, $28
	fmul    $28, $39, $28
	fadd    $33, $28, $28
be_cont.31363:
	fmul    $21, $21, $30
	fmul    $22, $22, $33
	fmul    $23, $23, $34
	fmul    $28, $28, $29
	cmp     $24, 0
	fmul    $30, $25, $25
	fmul    $33, $26, $26
	fmul    $34, $27, $27
	fadd    $25, $26, $25
	fadd    $25, $27, $25
	bne     be_else.31364
be_then.31364:
	mov     $25, $21
.count b_cont
	b       be_cont.31364
be_else.31364:
	load    [$20 + 9], $26
	fmul    $22, $23, $24
	load    [$20 + 9], $27
	load    [$26 + 0], $26
	fmul    $23, $21, $23
	fmul    $24, $26, $24
	fmul    $21, $22, $21
	load    [$27 + 1], $26
	load    [$20 + 9], $22
	fadd    $25, $24, $24
	fmul    $23, $26, $23
	load    [$22 + 2], $22
	fmul    $21, $22, $21
	fadd    $24, $23, $23
	fadd    $23, $21, $21
be_cont.31364:
	cmp     $32, 3
	bne     be_cont.31365
be_then.31365:
	fsub    $21, $36, $21
be_cont.31365:
	fmul    $31, $21, $21
	fsub    $29, $21, $21
	fcmp    $21, $zero
	bg      ble_else.31366
ble_then.31366:
	li      0, $20
.count b_cont
	b       ble_cont.31366
ble_else.31366:
	load    [$20 + 6], $20
	fsqrt   $21, $21
	cmp     $20, 0
	bne     be_else.31367
be_then.31367:
	fneg    $21, $20
	fsub    $20, $28, $20
	finv    $31, $21
	fmul    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31367
be_else.31367:
	fsub    $21, $28, $20
	finv    $31, $21
	fmul    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
be_cont.31367:
ble_cont.31366:
be_cont.31362:
be_cont.31359:
be_cont.31335:
	cmp     $20, 0
	bne     be_else.31368
be_then.31368:
	load    [min_caml_objects + $19], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31369
be_then.31369:
	ret
be_else.31369:
	add     $2, 1, $2
	b       solve_each_element.2871
be_else.31368:
	fcmp    $42, $zero
	bg      ble_else.31370
ble_then.31370:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31370:
	fcmp    $49, $42
	bg      ble_else.31371
ble_then.31371:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31371:
.count stack_move
	sub     $sp, 5, $sp
.count load_float
	load    [f.27088], $21
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
	fadd    $42, $21, $21
.count stack_store
	store   $2, [$sp + 2]
	load    [$4 + 0], $22
	load    [$4 + 1], $24
	load    [min_caml_startp + 0], $23
	fmul    $22, $21, $22
	fmul    $24, $21, $24
	load    [min_caml_startp + 1], $25
	li      0, $2
	fadd    $22, $23, $22
	fadd    $24, $25, $5
	load    [$4 + 2], $23
	fmul    $23, $21, $23
.count stack_store
	store   $5, [$sp + 3]
	load    [min_caml_startp + 2], $24
.count move_args
	mov     $22, $4
	fadd    $23, $24, $6
.count stack_store
	store   $6, [$sp + 4]
	call    check_all_inside.2856
.count stack_move
	add     $sp, 5, $sp
	cmp     $1, 0
	bne     be_else.31372
be_then.31372:
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	add     $1, 1, $2
	b       solve_each_element.2871
be_else.31372:
	store   $22, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
.count move_float
	mov     $21, $49
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $19, [min_caml_intersected_object_id + 0]
	store   $20, [min_caml_intsec_rectside + 0]
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	add     $1, 1, $2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$3 + $2], $1
	cmp     $1, -1
	bne     be_else.31373
be_then.31373:
	ret
be_else.31373:
.count stack_move
	sub     $sp, 10, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $1], $3
	li      0, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 2], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31374
be_then.31374:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31374:
.count stack_store
	store   $1, [$sp + 3]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31375
be_then.31375:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31375:
.count stack_store
	store   $1, [$sp + 4]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 4], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31376
be_then.31376:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31376:
.count stack_store
	store   $1, [$sp + 5]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31377
be_then.31377:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31377:
.count stack_store
	store   $1, [$sp + 6]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 6], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31378
be_then.31378:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31378:
.count stack_store
	store   $1, [$sp + 7]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 7], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31379
be_then.31379:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31379:
.count stack_store
	store   $1, [$sp + 8]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 8], $1
.count stack_load
	load    [$sp + 1], $3
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31380
be_then.31380:
.count stack_move
	add     $sp, 10, $sp
	ret
be_else.31380:
.count stack_store
	store   $1, [$sp + 9]
	load    [min_caml_and_net + $2], $3
	li      0, $1
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $1, $2
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
	load    [$3 + $2], $19
	load    [$19 + 0], $20
	cmp     $20, -1
	bne     be_else.31381
be_then.31381:
	ret
be_else.31381:
.count stack_move
	sub     $sp, 6, $sp
	cmp     $20, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.31382
be_then.31382:
	load    [$19 + 1], $20
	cmp     $20, -1
	be      bne_cont.31383
bne_then.31383:
.count stack_store
	store   $19, [$sp + 3]
	li      0, $2
	load    [min_caml_and_net + $20], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	load    [$3 + 2], $19
	cmp     $19, -1
	be      bne_cont.31384
bne_then.31384:
	li      0, $2
	load    [min_caml_and_net + $19], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	load    [$3 + 3], $19
	cmp     $19, -1
	be      bne_cont.31385
bne_then.31385:
	li      0, $2
	load    [min_caml_and_net + $19], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	load    [$3 + 4], $19
	cmp     $19, -1
	be      bne_cont.31386
bne_then.31386:
	li      0, $2
	load    [min_caml_and_net + $19], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	load    [$3 + 5], $19
	cmp     $19, -1
	be      bne_cont.31387
bne_then.31387:
	li      0, $2
	load    [min_caml_and_net + $19], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 3], $3
	load    [$3 + 6], $19
	cmp     $19, -1
	be      bne_cont.31388
bne_then.31388:
	li      0, $2
	load    [min_caml_and_net + $19], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      7, $2
.count stack_load
	load    [$sp + 3], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_one_or_network.2875
bne_cont.31388:
bne_cont.31387:
bne_cont.31386:
bne_cont.31385:
bne_cont.31384:
bne_cont.31383:
.count stack_load
	load    [$sp + 2], $19
.count stack_load
	load    [$sp + 1], $3
	add     $19, 1, $19
	load    [$3 + $19], $20
	load    [$20 + 0], $2
	cmp     $2, -1
	bne     be_else.31389
be_then.31389:
.count stack_move
	add     $sp, 6, $sp
	ret
be_else.31389:
	cmp     $2, 99
	bne     be_else.31390
be_then.31390:
	load    [$20 + 1], $1
	cmp     $1, -1
	bne     be_else.31391
be_then.31391:
.count stack_move
	add     $sp, 6, $sp
	add     $19, 1, $2
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
be_else.31391:
.count stack_store
	store   $19, [$sp + 4]
	li      0, $2
.count stack_store
	store   $20, [$sp + 5]
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 2], $1
	cmp     $1, -1
	bne     be_else.31392
be_then.31392:
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
be_else.31392:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 3], $1
	cmp     $1, -1
	bne     be_else.31393
be_then.31393:
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
be_else.31393:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 4], $1
	cmp     $1, -1
	bne     be_else.31394
be_then.31394:
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
be_else.31394:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
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
be_else.31390:
.count stack_load
	load    [$sp + 0], $3
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31395
be_then.31395:
.count stack_move
	add     $sp, 6, $sp
	add     $19, 1, $2
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
be_else.31395:
	fcmp    $49, $42
	bg      ble_else.31396
ble_then.31396:
.count stack_move
	add     $sp, 6, $sp
	add     $19, 1, $2
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       trace_or_matrix.2879
ble_else.31396:
.count stack_store
	store   $19, [$sp + 4]
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $20, $3
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
be_else.31382:
.count move_args
	mov     $4, $3
.count move_args
	mov     $20, $2
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31397
be_then.31397:
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
be_else.31397:
	fcmp    $49, $42
	bg      ble_else.31398
ble_then.31398:
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
ble_else.31398:
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $19, $3
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
	load    [$3 + $2], $19
	cmp     $19, -1
	bne     be_else.31399
be_then.31399:
	ret
be_else.31399:
	load    [min_caml_objects + $19], $21
	load    [$4 + 1], $20
	load    [$21 + 10], $22
	load    [$21 + 1], $23
	load    [$20 + $19], $20
	load    [$22 + 0], $24
	load    [$22 + 1], $25
	load    [$22 + 2], $26
	cmp     $23, 1
	bne     be_else.31400
be_then.31400:
	load    [$20 + 0], $28
	load    [$20 + 1], $29
	load    [$4 + 0], $22
	fsub    $28, $24, $28
	load    [$21 + 4], $23
	load    [$22 + 1], $27
	load    [$23 + 1], $23
	fmul    $28, $29, $28
	fmul    $28, $27, $27
	fadd    $27, $25, $27
	fabs    $27, $27
	fcmp    $23, $27
	bg      ble_else.31401
ble_then.31401:
	li      0, $23
.count b_cont
	b       ble_cont.31401
ble_else.31401:
	load    [$22 + 2], $27
	load    [$21 + 4], $23
	fmul    $28, $27, $27
	load    [$23 + 2], $23
	fadd    $27, $26, $27
	fabs    $27, $27
	fcmp    $23, $27
	bg      ble_else.31402
ble_then.31402:
	li      0, $23
.count b_cont
	b       ble_cont.31402
ble_else.31402:
	load    [$20 + 1], $23
	fcmp    $23, $zero
	bne     be_else.31403
be_then.31403:
	li      0, $23
.count b_cont
	b       be_cont.31403
be_else.31403:
	li      1, $23
be_cont.31403:
ble_cont.31402:
ble_cont.31401:
	cmp     $23, 0
	bne     be_else.31404
be_then.31404:
	load    [$20 + 2], $28
	load    [$20 + 3], $29
	load    [$22 + 0], $27
	fsub    $28, $25, $28
	load    [$21 + 4], $23
	load    [$23 + 0], $23
	fmul    $28, $29, $28
	fmul    $28, $27, $27
	fadd    $27, $24, $27
	fabs    $27, $27
	fcmp    $23, $27
	bg      ble_else.31405
ble_then.31405:
	li      0, $23
.count b_cont
	b       ble_cont.31405
ble_else.31405:
	load    [$22 + 2], $27
	load    [$21 + 4], $23
	fmul    $28, $27, $27
	load    [$23 + 2], $23
	fadd    $27, $26, $27
	fabs    $27, $27
	fcmp    $23, $27
	bg      ble_else.31406
ble_then.31406:
	li      0, $23
.count b_cont
	b       ble_cont.31406
ble_else.31406:
	load    [$20 + 3], $23
	fcmp    $23, $zero
	bne     be_else.31407
be_then.31407:
	li      0, $23
.count b_cont
	b       be_cont.31407
be_else.31407:
	li      1, $23
be_cont.31407:
ble_cont.31406:
ble_cont.31405:
	cmp     $23, 0
	bne     be_else.31408
be_then.31408:
	load    [$20 + 4], $28
	load    [$20 + 5], $29
	load    [$22 + 0], $27
	fsub    $28, $26, $26
	load    [$21 + 4], $23
	load    [$23 + 0], $23
	fmul    $26, $29, $26
	fmul    $26, $27, $27
	fadd    $27, $24, $24
	fabs    $24, $24
	fcmp    $23, $24
	bg      ble_else.31409
ble_then.31409:
	li      0, $20
.count b_cont
	b       be_cont.31400
ble_else.31409:
	load    [$22 + 1], $22
	load    [$21 + 4], $21
	fmul    $26, $22, $22
	load    [$21 + 1], $21
	fadd    $22, $25, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31410
ble_then.31410:
	li      0, $20
.count b_cont
	b       be_cont.31400
ble_else.31410:
	load    [$20 + 5], $20
	fcmp    $20, $zero
	bne     be_else.31411
be_then.31411:
	li      0, $20
.count b_cont
	b       be_cont.31400
be_else.31411:
.count move_float
	mov     $26, $42
	li      3, $20
.count b_cont
	b       be_cont.31400
be_else.31408:
.count move_float
	mov     $28, $42
	li      2, $20
.count b_cont
	b       be_cont.31400
be_else.31404:
.count move_float
	mov     $28, $42
	li      1, $20
.count b_cont
	b       be_cont.31400
be_else.31400:
	cmp     $23, 2
	bne     be_else.31412
be_then.31412:
	load    [$20 + 0], $20
	fcmp    $zero, $20
	bg      ble_else.31413
ble_then.31413:
	li      0, $20
.count b_cont
	b       be_cont.31412
ble_else.31413:
	load    [$22 + 3], $21
	fmul    $20, $21, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31412
be_else.31412:
	load    [$20 + 0], $23
	fcmp    $23, $zero
	bne     be_else.31414
be_then.31414:
	li      0, $20
.count b_cont
	b       be_cont.31414
be_else.31414:
	load    [$20 + 1], $27
	load    [$20 + 2], $28
	load    [$22 + 3], $22
	fmul    $27, $24, $24
	fmul    $28, $25, $25
	load    [$20 + 3], $27
	fmul    $23, $22, $22
	fmul    $27, $26, $26
	fadd    $24, $25, $24
	fadd    $24, $26, $23
	fmul    $23, $23, $24
	fsub    $24, $22, $22
	fcmp    $22, $zero
	bg      ble_else.31415
ble_then.31415:
	li      0, $20
.count b_cont
	b       ble_cont.31415
ble_else.31415:
	load    [$21 + 6], $21
	load    [$20 + 4], $20
	cmp     $21, 0
	fsqrt   $22, $21
	bne     be_else.31416
be_then.31416:
	fsub    $23, $21, $21
	fmul    $21, $20, $20
.count move_float
	mov     $20, $42
	li      1, $20
.count b_cont
	b       be_cont.31416
be_else.31416:
	fadd    $23, $21, $21
	fmul    $21, $20, $20
.count move_float
	mov     $20, $42
	li      1, $20
be_cont.31416:
ble_cont.31415:
be_cont.31414:
be_cont.31412:
be_cont.31400:
	cmp     $20, 0
	bne     be_else.31417
be_then.31417:
	load    [min_caml_objects + $19], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31418
be_then.31418:
	ret
be_else.31418:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
be_else.31417:
	fcmp    $42, $zero
	bg      ble_else.31419
ble_then.31419:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31419:
	load    [$4 + 0], $21
	fcmp    $49, $42
	bg      ble_else.31420
ble_then.31420:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31420:
.count stack_move
	sub     $sp, 6, $sp
.count load_float
	load    [f.27088], $22
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
	fadd    $42, $22, $22
.count stack_store
	store   $2, [$sp + 2]
	load    [$21 + 0], $23
	load    [$21 + 1], $24
	li      0, $2
	fmul    $23, $22, $23
	fmul    $24, $22, $24
	fadd    $23, $51, $4
	fadd    $24, $52, $5
.count stack_store
	store   $4, [$sp + 3]
	load    [$21 + 2], $21
.count stack_store
	store   $5, [$sp + 4]
	fmul    $21, $22, $21
	fadd    $21, $53, $6
.count stack_store
	store   $6, [$sp + 5]
	call    check_all_inside.2856
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
	bne     be_else.31421
be_then.31421:
.count stack_load
	load    [$sp - 4], $1
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element_fast.2885
be_else.31421:
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $22, $49
	store   $1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $19, [min_caml_intersected_object_id + 0]
	store   $20, [min_caml_intsec_rectside + 0]
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
	load    [$3 + $2], $30
	cmp     $30, -1
	bne     be_else.31422
be_then.31422:
	ret
be_else.31422:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $30
.count stack_load
	load    [$sp + 1], $31
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31423
be_then.31423:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31423:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31424
be_then.31424:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31424:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31425
be_then.31425:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31425:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31426
be_then.31426:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31426:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31427
be_then.31427:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31427:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31428
be_then.31428:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31428:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31429
be_then.31429:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31429:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_move
	add     $sp, 3, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $4
.count move_args
	mov     $31, $3
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$3 + $2], $30
	load    [$30 + 0], $31
	cmp     $31, -1
	bne     be_else.31430
be_then.31430:
	ret
be_else.31430:
.count stack_move
	sub     $sp, 4, $sp
	cmp     $31, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.31431
be_then.31431:
	load    [$30 + 1], $31
	cmp     $31, -1
	be      bne_cont.31432
bne_then.31432:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    solve_each_element_fast.2885
	load    [$30 + 2], $31
	cmp     $31, -1
	be      bne_cont.31433
bne_then.31433:
	li      0, $2
	load    [min_caml_and_net + $31], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$30 + 3], $31
	cmp     $31, -1
	be      bne_cont.31434
bne_then.31434:
	li      0, $2
	load    [min_caml_and_net + $31], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$30 + 4], $31
	cmp     $31, -1
	be      bne_cont.31435
bne_then.31435:
	li      0, $2
	load    [min_caml_and_net + $31], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$30 + 5], $31
	cmp     $31, -1
	be      bne_cont.31436
bne_then.31436:
	li      0, $2
	load    [min_caml_and_net + $31], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$30 + 6], $31
	cmp     $31, -1
	be      bne_cont.31437
bne_then.31437:
	li      0, $2
	load    [min_caml_and_net + $31], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      7, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $30, $3
	call    solve_one_or_network_fast.2889
bne_cont.31437:
bne_cont.31436:
bne_cont.31435:
bne_cont.31434:
bne_cont.31433:
bne_cont.31432:
.count stack_load
	load    [$sp + 2], $30
.count stack_load
	load    [$sp + 1], $3
	add     $30, 1, $30
	load    [$3 + $30], $31
	load    [$31 + 0], $32
	cmp     $32, -1
	bne     be_else.31438
be_then.31438:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31438:
	cmp     $32, 99
	bne     be_else.31439
be_then.31439:
	load    [$31 + 1], $32
	cmp     $32, -1
	bne     be_else.31440
be_then.31440:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31440:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$31 + 2], $32
	cmp     $32, -1
	bne     be_else.31441
be_then.31441:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31441:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$31 + 3], $32
	cmp     $32, -1
	bne     be_else.31442
be_then.31442:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31442:
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$31 + 4], $32
	cmp     $32, -1
	bne     be_else.31443
be_then.31443:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31443:
.count stack_store
	store   $30, [$sp + 3]
	li      0, $2
	load    [min_caml_and_net + $32], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $31, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31439:
.count stack_load
	load    [$sp + 0], $3
.count move_args
	mov     $32, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31444
be_then.31444:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31444:
	fcmp    $49, $42
	bg      ble_else.31445
ble_then.31445:
.count stack_move
	add     $sp, 4, $sp
	add     $30, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
ble_else.31445:
.count stack_store
	store   $30, [$sp + 3]
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $31, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31431:
.count move_args
	mov     $4, $3
.count move_args
	mov     $31, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31446
be_then.31446:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31446:
	fcmp    $49, $42
	bg      ble_else.31447
ble_then.31447:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
ble_else.31447:
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $30, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
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
	load    [$10 + 1], $10
.count move_float
	mov     $10, $54
	load    [$2 + 8], $10
	load    [$10 + 2], $10
.count move_float
	mov     $10, $58
	load    [$2 + 0], $10
	cmp     $10, 1
	bne     be_else.31448
be_then.31448:
	load    [$2 + 5], $10
	load    [min_caml_intersection_point + 0], $12
.count load_float
	load    [f.27100], $13
	load    [$10 + 0], $10
	load    [$2 + 5], $11
.count stack_move
	sub     $sp, 2, $sp
	fsub    $12, $10, $10
	fmul    $10, $13, $2
	call    min_caml_floor
.count load_float
	load    [f.27101], $14
	load    [min_caml_intersection_point + 2], $16
	load    [$11 + 2], $11
.count move_ret
	mov     $1, $12
.count load_float
	load    [f.27102], $15
	fmul    $12, $14, $12
	fsub    $16, $11, $11
	fsub    $10, $12, $10
	fmul    $11, $13, $2
	call    min_caml_floor
	fmul    $1, $14, $1
.count stack_move
	add     $sp, 2, $sp
	fcmp    $15, $10
	fsub    $11, $1, $1
	bg      ble_else.31449
ble_then.31449:
	li      0, $2
.count b_cont
	b       ble_cont.31449
ble_else.31449:
	li      1, $2
ble_cont.31449:
	fcmp    $15, $1
	bg      ble_else.31450
ble_then.31450:
	cmp     $2, 0
	bne     be_else.31451
be_then.31451:
.count load_float
	load    [f.27096], $1
.count move_float
	mov     $1, $54
	ret
be_else.31451:
.count move_float
	mov     $zero, $54
	ret
ble_else.31450:
	cmp     $2, 0
	bne     be_else.31452
be_then.31452:
.count move_float
	mov     $zero, $54
	ret
be_else.31452:
.count load_float
	load    [f.27096], $1
.count move_float
	mov     $1, $54
	ret
be_else.31448:
	cmp     $10, 2
	bne     be_else.31453
be_then.31453:
.count load_float
	load    [f.27099], $11
	load    [min_caml_intersection_point + 1], $12
.count stack_move
	sub     $sp, 2, $sp
	fmul    $12, $11, $2
	call    min_caml_sin
	fmul    $1, $1, $1
.count load_float
	load    [f.27096], $2
.count stack_move
	add     $sp, 2, $sp
	fmul    $2, $1, $3
	fsub    $36, $1, $1
	store   $3, [min_caml_texture_color + 0]
	fmul    $2, $1, $1
.count move_float
	mov     $1, $54
	ret
be_else.31453:
	cmp     $10, 3
	bne     be_else.31454
be_then.31454:
	load    [$2 + 5], $10
	load    [min_caml_intersection_point + 0], $12
	load    [$2 + 5], $11
	load    [$10 + 0], $10
.count load_float
	load    [f.27098], $13
	load    [$11 + 2], $11
	fsub    $12, $10, $10
.count stack_move
	sub     $sp, 2, $sp
	load    [min_caml_intersection_point + 2], $12
	fsub    $12, $11, $11
	fmul    $10, $10, $10
	fmul    $11, $11, $11
	fadd    $10, $11, $10
	fsqrt   $10, $10
	fmul    $10, $13, $2
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_floor
.count stack_load
	load    [$sp + 0], $12
.count move_ret
	mov     $1, $11
	fsub    $12, $11, $11
.count load_float
	load    [f.27093], $12
	fmul    $11, $12, $2
	call    min_caml_cos
	fmul    $1, $1, $1
.count load_float
	load    [f.27096], $2
.count stack_move
	add     $sp, 2, $sp
	fmul    $1, $2, $3
	fsub    $36, $1, $1
.count move_float
	mov     $3, $54
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
be_else.31454:
	cmp     $10, 4
	bne     be_else.31455
be_then.31455:
.count stack_move
	sub     $sp, 2, $sp
.count load_float
	load    [f.27090], $15
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 4], $12
	load    [$2 + 5], $11
	load    [min_caml_intersection_point + 0], $16
	load    [$12 + 0], $12
	load    [$11 + 0], $11
	load    [$2 + 4], $14
	fsqrt   $12, $12
	fsub    $16, $11, $11
	load    [$2 + 5], $13
	load    [min_caml_intersection_point + 2], $16
	load    [$13 + 2], $13
	fmul    $11, $12, $11
	load    [$14 + 2], $12
	fsub    $16, $13, $13
	fsqrt   $12, $12
	fabs    $11, $14
	fcmp    $15, $14
	fmul    $13, $12, $12
	bg      ble_else.31456
ble_then.31456:
	finv    $11, $13
	fmul    $12, $13, $13
	fabs    $13, $2
	call    min_caml_atan
.count load_float
	load    [f.27092], $14
.count move_ret
	mov     $1, $13
.count load_float
	load    [f.27093], $16
	fmul    $13, $14, $13
.count load_float
	load    [f.27094], $16
	fmul    $13, $16, $13
.count b_cont
	b       ble_cont.31456
ble_else.31456:
.count load_float
	load    [f.27091], $13
ble_cont.31456:
.count stack_load
	load    [$sp + 1], $14
	fmul    $12, $12, $12
	fmul    $11, $11, $11
	load    [$14 + 5], $16
	load    [min_caml_intersection_point + 1], $17
	load    [$14 + 4], $14
	load    [$16 + 1], $16
	fadd    $11, $12, $11
	load    [$14 + 1], $14
	fsub    $17, $16, $12
	fsqrt   $14, $14
	fabs    $11, $16
	fcmp    $15, $16
	fmul    $12, $14, $12
	bg      ble_else.31457
ble_then.31457:
	finv    $11, $11
	fmul    $12, $11, $11
	fabs    $11, $2
	call    min_caml_atan
.count load_float
	load    [f.27092], $11
.count move_ret
	mov     $1, $10
.count load_float
	load    [f.27093], $12
	fmul    $10, $11, $10
.count load_float
	load    [f.27094], $12
	fmul    $10, $12, $10
.count b_cont
	b       ble_cont.31457
ble_else.31457:
.count load_float
	load    [f.27091], $10
ble_cont.31457:
.count load_float
	load    [f.27095], $11
.count move_args
	mov     $13, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $12
.count move_args
	mov     $10, $2
	fsub    $13, $12, $12
	fsub    $39, $12, $12
	fmul    $12, $12, $12
	fsub    $11, $12, $11
	call    min_caml_floor
	fsub    $10, $1, $1
.count stack_move
	add     $sp, 2, $sp
	fsub    $39, $1, $1
	fmul    $1, $1, $1
	fsub    $11, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31458
ble_then.31458:
.count load_float
	load    [f.27096], $2
.count load_float
	load    [f.27097], $3
	fmul    $2, $1, $1
	fmul    $1, $3, $1
.count move_float
	mov     $1, $58
	ret
ble_else.31458:
.count move_float
	mov     $zero, $58
	ret
be_else.31455:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2915:
	cmp     $2, 0
	bl      bge_else.31459
bge_then.31459:
.count stack_move
	sub     $sp, 6, $sp
.count load_float
	load    [f.27103], $35
.count stack_store
	store   $5, [$sp + 0]
.count stack_store
	store   $4, [$sp + 1]
.count move_float
	mov     $35, $49
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
	load    [min_caml_reflections + $2], $34
	load    [$34 + 1], $4
.count stack_store
	store   $4, [$sp + 4]
	load    [$59 + 0], $35
	load    [$35 + 0], $30
	cmp     $30, -1
	be      bne_cont.31460
bne_then.31460:
	cmp     $30, 99
	bne     be_else.31461
be_then.31461:
	load    [$35 + 1], $30
	cmp     $30, -1
	bne     be_else.31462
be_then.31462:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31461
be_else.31462:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    solve_each_element_fast.2885
	load    [$35 + 2], $30
.count stack_load
	load    [$sp + 4], $4
	cmp     $30, -1
	bne     be_else.31463
be_then.31463:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31461
be_else.31463:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    solve_each_element_fast.2885
	load    [$35 + 3], $30
.count stack_load
	load    [$sp + 4], $4
	cmp     $30, -1
	bne     be_else.31464
be_then.31464:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31461
be_else.31464:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    solve_each_element_fast.2885
	load    [$35 + 4], $30
.count stack_load
	load    [$sp + 4], $4
	cmp     $30, -1
	bne     be_else.31465
be_then.31465:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31461
be_else.31465:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $35, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31461
be_else.31461:
.count move_args
	mov     $4, $3
.count move_args
	mov     $30, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $33
	cmp     $33, 0
.count stack_load
	load    [$sp + 4], $4
	li      1, $2
	bne     be_else.31466
be_then.31466:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31466
be_else.31466:
	fcmp    $49, $42
	bg      ble_else.31467
ble_then.31467:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.31467
ble_else.31467:
.count move_args
	mov     $35, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31467:
be_cont.31466:
be_cont.31461:
bne_cont.31460:
.count load_float
	load    [f.27089], $1
	fcmp    $49, $1
	bg      ble_else.31468
ble_then.31468:
	li      0, $1
.count b_cont
	b       ble_cont.31468
ble_else.31468:
.count load_float
	load    [f.27104], $1
	fcmp    $1, $49
	bg      ble_else.31469
ble_then.31469:
	li      0, $1
.count b_cont
	b       ble_cont.31469
ble_else.31469:
	li      1, $1
ble_cont.31469:
ble_cont.31468:
	cmp     $1, 0
	bne     be_else.31470
be_then.31470:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 6], $5
	b       trace_reflections.2915
be_else.31470:
	load    [min_caml_intersected_object_id + 0], $2
	load    [min_caml_intsec_rectside + 0], $3
	load    [$34 + 0], $1
	sll     $2, 2, $2
	add     $2, $3, $2
	cmp     $2, $1
	bne     be_else.31471
be_then.31471:
.count stack_store
	store   $34, [$sp + 5]
	li      0, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
.count stack_load
	load    [$sp - 4], $3
	bne     be_else.31472
be_then.31472:
.count stack_load
	load    [$sp - 2], $2
	load    [min_caml_nvector + 0], $5
	load    [min_caml_nvector + 1], $7
	load    [$2 + 0], $2
	load    [min_caml_nvector + 2], $9
.count stack_load
	load    [$sp - 1], $1
	load    [$2 + 0], $6
	load    [$2 + 1], $8
	load    [$1 + 2], $1
	fmul    $5, $6, $5
	fmul    $7, $8, $7
	load    [$2 + 2], $2
	fmul    $1, $3, $4
	fadd    $5, $7, $5
	fmul    $9, $2, $7
	fadd    $5, $7, $5
	fmul    $4, $5, $4
	fcmp    $4, $zero
	ble     bg_cont.31473
bg_then.31473:
	load    [min_caml_texture_color + 0], $5
	fmul    $4, $5, $5
	fadd    $46, $5, $5
.count move_float
	mov     $5, $46
	fmul    $4, $54, $5
	fmul    $4, $58, $4
	fadd    $47, $5, $5
	fadd    $48, $4, $4
.count move_float
	mov     $5, $47
.count move_float
	mov     $4, $48
bg_cont.31473:
.count stack_load
	load    [$sp - 6], $5
	load    [$5 + 0], $4
	load    [$5 + 1], $7
	fmul    $4, $6, $4
	fmul    $7, $8, $6
	load    [$5 + 2], $7
	fmul    $7, $2, $2
	fadd    $4, $6, $4
	fadd    $4, $2, $2
.count stack_load
	load    [$sp - 5], $4
	fmul    $1, $2, $1
	fcmp    $1, $zero
	bg      ble_else.31474
ble_then.31474:
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
	b       trace_reflections.2915
ble_else.31474:
	fmul    $1, $1, $1
	fmul    $1, $1, $1
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
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
	b       trace_reflections.2915
be_else.31472:
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 5], $4
.count stack_load
	load    [$sp - 6], $5
	sub     $1, 1, $2
	b       trace_reflections.2915
be_else.31471:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 6], $5
	b       trace_reflections.2915
bge_else.31459:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2920:
	cmp     $2, 4
	bg      ble_else.31475
ble_then.31475:
.count stack_move
	sub     $sp, 10, $sp
.count load_float
	load    [f.27103], $19
.count stack_store
	store   $6, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count move_float
	mov     $19, $49
.count stack_store
	store   $4, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
	load    [$59 + 0], $3
	load    [$3 + 0], $2
	cmp     $2, -1
	be      bne_cont.31476
bne_then.31476:
	cmp     $2, 99
	bne     be_else.31477
be_then.31477:
	load    [$3 + 1], $18
	cmp     $18, -1
	bne     be_else.31478
be_then.31478:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.31477
be_else.31478:
.count stack_store
	store   $3, [$sp + 5]
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 2], $18
	cmp     $18, -1
	bne     be_else.31479
be_then.31479:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.31477
be_else.31479:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 3], $18
	cmp     $18, -1
	bne     be_else.31480
be_then.31480:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.31477
be_else.31480:
	li      0, $2
	load    [min_caml_and_net + $18], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 5], $3
.count stack_load
	load    [$sp + 2], $4
	load    [$3 + 4], $18
	cmp     $18, -1
	bne     be_else.31481
be_then.31481:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.31477
be_else.31481:
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
	b       be_cont.31477
be_else.31477:
.count stack_store
	store   $3, [$sp + 5]
.count move_args
	mov     $4, $3
	call    solver.2773
.count move_ret
	mov     $1, $18
	cmp     $18, 0
.count stack_load
	load    [$sp + 2], $4
	li      1, $2
	bne     be_else.31482
be_then.31482:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       be_cont.31482
be_else.31482:
	fcmp    $49, $42
	bg      ble_else.31483
ble_then.31483:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
.count b_cont
	b       ble_cont.31483
ble_else.31483:
.count stack_load
	load    [$sp + 5], $3
	call    solve_one_or_network.2875
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
ble_cont.31483:
be_cont.31482:
be_cont.31477:
bne_cont.31476:
.count stack_load
	load    [$sp + 4], $18
.count load_float
	load    [f.27089], $20
	load    [$18 + 2], $19
	fcmp    $49, $20
	bg      ble_else.31484
ble_then.31484:
	li      0, $21
.count b_cont
	b       ble_cont.31484
ble_else.31484:
.count load_float
	load    [f.27104], $21
	fcmp    $21, $49
	bg      ble_else.31485
ble_then.31485:
	li      0, $21
.count b_cont
	b       ble_cont.31485
ble_else.31485:
	li      1, $21
ble_cont.31485:
ble_cont.31484:
	cmp     $21, 0
	bne     be_else.31486
be_then.31486:
.count stack_move
	add     $sp, 10, $sp
	add     $zero, -1, $1
.count stack_load
	load    [$sp - 7], $2
.count storer
	add     $19, $2, $tmp
	cmp     $2, 0
	store   $1, [$tmp + 0]
	bne     be_else.31487
be_then.31487:
	ret
be_else.31487:
.count stack_load
	load    [$sp - 8], $1
	load    [$1 + 0], $2
	load    [$1 + 1], $3
	fmul    $2, $55, $2
	fmul    $3, $56, $3
	load    [$1 + 2], $1
	fmul    $1, $57, $1
	fadd    $2, $3, $2
	fadd    $2, $1, $1
	fneg    $1, $1
	fcmp    $1, $zero
	bg      ble_else.31488
ble_then.31488:
	ret
ble_else.31488:
	fmul    $1, $1, $2
.count stack_load
	load    [$sp - 9], $3
	fmul    $2, $1, $1
	load    [min_caml_beam + 0], $2
	fmul    $1, $3, $1
	fmul    $1, $2, $1
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
be_else.31486:
.count stack_store
	store   $19, [$sp + 6]
	load    [min_caml_intersected_object_id + 0], $21
	load    [min_caml_objects + $21], $2
.count stack_store
	store   $2, [$sp + 7]
	load    [$2 + 1], $22
	cmp     $22, 1
	bne     be_else.31489
be_then.31489:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $22
.count stack_load
	load    [$sp + 2], $23
	sub     $22, 1, $22
	load    [$23 + $22], $23
	fcmp    $23, $zero
	bne     be_else.31490
be_then.31490:
	store   $zero, [min_caml_nvector + $22]
.count b_cont
	b       be_cont.31489
be_else.31490:
	fcmp    $23, $zero
	bg      ble_else.31491
ble_then.31491:
	store   $36, [min_caml_nvector + $22]
.count b_cont
	b       be_cont.31489
ble_else.31491:
	store   $40, [min_caml_nvector + $22]
.count b_cont
	b       be_cont.31489
be_else.31489:
	cmp     $22, 2
	bne     be_else.31492
be_then.31492:
	load    [$2 + 4], $22
	load    [$22 + 0], $22
	fneg    $22, $22
	store   $22, [min_caml_nvector + 0]
	load    [$2 + 4], $22
	load    [$22 + 1], $22
	fneg    $22, $22
	store   $22, [min_caml_nvector + 1]
	load    [$2 + 4], $22
	load    [$22 + 2], $22
	fneg    $22, $22
	store   $22, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.31492
be_else.31492:
	load    [$2 + 5], $24
	load    [min_caml_intersection_point + 0], $25
	load    [$2 + 4], $26
	load    [$24 + 0], $24
	load    [$2 + 5], $27
	load    [$2 + 4], $28
	fsub    $25, $24, $24
	load    [$27 + 1], $27
	load    [$26 + 1], $25
	load    [min_caml_intersection_point + 2], $29
	load    [min_caml_intersection_point + 1], $26
	load    [$2 + 4], $23
	load    [$2 + 3], $22
	fsub    $26, $27, $26
	load    [$23 + 0], $23
	load    [$28 + 2], $27
	cmp     $22, 0
	load    [$2 + 5], $28
	fmul    $24, $23, $23
	fmul    $26, $25, $25
	load    [$28 + 2], $28
	fsub    $29, $28, $28
	fmul    $28, $27, $27
	bne     be_else.31493
be_then.31493:
	store   $23, [min_caml_nvector + 0]
	store   $25, [min_caml_nvector + 1]
	store   $27, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.31493
be_else.31493:
	load    [$2 + 9], $29
	load    [$2 + 9], $22
	load    [$29 + 1], $29
	load    [$22 + 2], $22
	fmul    $28, $29, $29
	fmul    $26, $22, $22
	fadd    $22, $29, $22
	fmul    $22, $39, $22
	fadd    $23, $22, $22
	store   $22, [min_caml_nvector + 0]
	load    [$2 + 9], $23
	load    [$2 + 9], $22
	load    [$23 + 0], $23
	load    [$22 + 2], $22
	fmul    $28, $23, $23
	fmul    $24, $22, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fadd    $25, $22, $22
	store   $22, [min_caml_nvector + 1]
	load    [$2 + 9], $23
	load    [$2 + 9], $22
	load    [$23 + 0], $23
	load    [$22 + 1], $22
	fmul    $26, $23, $23
	fmul    $24, $22, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fadd    $27, $22, $22
	store   $22, [min_caml_nvector + 2]
be_cont.31493:
	load    [min_caml_nvector + 0], $23
	load    [min_caml_nvector + 1], $25
	load    [min_caml_nvector + 2], $26
	fmul    $23, $23, $24
	fmul    $25, $25, $25
	fmul    $26, $26, $26
	load    [$2 + 6], $22
	fadd    $24, $25, $24
	fadd    $24, $26, $24
	fsqrt   $24, $24
	fcmp    $24, $zero
	bne     be_else.31494
be_then.31494:
	mov     $36, $22
.count b_cont
	b       be_cont.31494
be_else.31494:
	cmp     $22, 0
	finv    $24, $22
	be      bne_cont.31495
bne_then.31495:
	fneg    $22, $22
bne_cont.31495:
be_cont.31494:
	fmul    $23, $22, $23
	store   $23, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $23
	fmul    $23, $22, $23
	store   $23, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $23
	fmul    $23, $22, $22
	store   $22, [min_caml_nvector + 2]
be_cont.31492:
be_cont.31489:
	load    [min_caml_intersection_point + 0], $22
	store   $22, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $22
	store   $22, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $22
	store   $22, [min_caml_startp + 2]
	call    utexture.2908
	load    [min_caml_intsec_rectside + 0], $17
	sll     $21, 2, $16
	add     $16, $17, $16
.count stack_load
	load    [$sp + 3], $17
.count storer
	add     $19, $17, $tmp
	store   $16, [$tmp + 0]
	load    [min_caml_intersection_point + 0], $19
	load    [$18 + 1], $16
	load    [$16 + $17], $16
	store   $19, [$16 + 0]
	load    [min_caml_intersection_point + 1], $19
	store   $19, [$16 + 1]
	load    [min_caml_intersection_point + 2], $19
	store   $19, [$16 + 2]
.count stack_load
	load    [$sp + 1], $21
.count stack_load
	load    [$sp + 7], $16
	load    [$18 + 3], $19
	load    [$16 + 7], $16
.count storer
	add     $19, $17, $tmp
	load    [$16 + 0], $16
	fmul    $16, $21, $21
	fcmp    $39, $16
.count stack_store
	store   $21, [$sp + 8]
	bg      ble_else.31496
ble_then.31496:
	li      1, $16
	store   $16, [$tmp + 0]
	load    [min_caml_texture_color + 0], $22
	load    [$18 + 4], $16
	load    [$16 + $17], $19
	store   $22, [$19 + 0]
	store   $54, [$19 + 1]
	store   $58, [$19 + 2]
	load    [$16 + $17], $16
.count load_float
	load    [f.27105], $19
.count load_float
	load    [f.27106], $19
	fmul    $19, $21, $19
	load    [$16 + 0], $21
	fmul    $21, $19, $21
	store   $21, [$16 + 0]
	load    [$16 + 1], $21
	fmul    $21, $19, $21
	store   $21, [$16 + 1]
	load    [$16 + 2], $21
	fmul    $21, $19, $19
	store   $19, [$16 + 2]
	load    [$18 + 7], $16
	load    [$16 + $17], $16
	load    [min_caml_nvector + 0], $17
	store   $17, [$16 + 0]
	load    [min_caml_nvector + 1], $17
	store   $17, [$16 + 1]
	load    [min_caml_nvector + 2], $17
	store   $17, [$16 + 2]
.count b_cont
	b       ble_cont.31496
ble_else.31496:
	li      0, $16
	store   $16, [$tmp + 0]
ble_cont.31496:
.count stack_load
	load    [$sp + 2], $18
	load    [min_caml_nvector + 1], $23
	load    [min_caml_nvector + 0], $17
	load    [$18 + 1], $21
	load    [$18 + 0], $19
	load    [min_caml_nvector + 2], $24
	fmul    $21, $23, $21
	fmul    $19, $17, $22
	load    [$18 + 2], $23
.count load_float
	load    [f.27107], $16
	fadd    $22, $21, $21
	fmul    $23, $24, $22
	fadd    $21, $22, $21
	fmul    $16, $21, $16
	fmul    $16, $17, $17
	fadd    $19, $17, $17
	store   $17, [$18 + 0]
	load    [min_caml_nvector + 1], $19
	load    [$18 + 1], $17
	fmul    $16, $19, $19
	fadd    $17, $19, $17
	store   $17, [$18 + 1]
	load    [min_caml_nvector + 2], $19
	load    [$18 + 2], $17
	fmul    $16, $19, $16
	fadd    $17, $16, $16
	store   $16, [$18 + 2]
	load    [$59 + 0], $16
	load    [$16 + 0], $2
	cmp     $2, -1
	bne     be_else.31497
be_then.31497:
	li      0, $16
.count b_cont
	b       be_cont.31497
be_else.31497:
.count stack_store
	store   $16, [$sp + 9]
	cmp     $2, 99
	bne     be_else.31498
be_then.31498:
	li      1, $34
.count b_cont
	b       be_cont.31498
be_else.31498:
	call    solver_fast.2796
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31499
be_then.31499:
	li      0, $34
.count b_cont
	b       be_cont.31499
be_else.31499:
	fcmp    $20, $42
	bg      ble_else.31500
ble_then.31500:
	li      0, $34
.count b_cont
	b       ble_cont.31500
ble_else.31500:
	load    [$16 + 1], $34
	cmp     $34, -1
	bne     be_else.31501
be_then.31501:
	li      0, $34
.count b_cont
	b       be_cont.31501
be_else.31501:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31502
be_then.31502:
.count stack_load
	load    [$sp + 9], $34
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31503
be_then.31503:
	li      0, $34
.count b_cont
	b       be_cont.31502
be_else.31503:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31504
be_then.31504:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31505
be_then.31505:
	li      0, $34
.count b_cont
	b       be_cont.31502
be_else.31505:
	li      1, $34
.count b_cont
	b       be_cont.31502
be_else.31504:
	li      1, $34
.count b_cont
	b       be_cont.31502
be_else.31502:
	li      1, $34
be_cont.31502:
be_cont.31501:
ble_cont.31500:
be_cont.31499:
be_cont.31498:
	cmp     $34, 0
	bne     be_else.31506
be_then.31506:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.31506
be_else.31506:
.count stack_load
	load    [$sp + 9], $34
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31507
be_then.31507:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.31507
be_else.31507:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31508
be_then.31508:
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31509
be_then.31509:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.31508
be_else.31509:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.31510
be_then.31510:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $16
	cmp     $16, 0
	bne     be_else.31511
be_then.31511:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $16
.count b_cont
	b       be_cont.31508
be_else.31511:
	li      1, $16
.count b_cont
	b       be_cont.31508
be_else.31510:
	li      1, $16
.count b_cont
	b       be_cont.31508
be_else.31508:
	li      1, $16
be_cont.31508:
be_cont.31507:
be_cont.31506:
be_cont.31497:
.count stack_load
	load    [$sp + 7], $17
.count stack_load
	load    [$sp + 1], $18
	cmp     $16, 0
	load    [$17 + 7], $17
	load    [$17 + 1], $17
	fmul    $18, $17, $17
	bne     be_cont.31512
be_then.31512:
	load    [min_caml_nvector + 0], $16
	load    [min_caml_nvector + 1], $18
	load    [min_caml_nvector + 2], $19
	fmul    $16, $55, $16
	fmul    $18, $56, $18
.count stack_load
	load    [$sp + 8], $21
	fadd    $16, $18, $16
	fmul    $19, $57, $18
.count stack_load
	load    [$sp + 2], $19
	fadd    $16, $18, $16
	load    [$19 + 0], $20
	load    [$19 + 1], $18
	fmul    $20, $55, $20
	fmul    $18, $56, $18
	load    [$19 + 2], $19
	fneg    $16, $16
	fmul    $19, $57, $19
	fadd    $20, $18, $18
	fmul    $16, $21, $16
	fadd    $18, $19, $18
	fcmp    $16, $zero
	fneg    $18, $18
	ble     bg_cont.31513
bg_then.31513:
	load    [min_caml_texture_color + 0], $19
	fmul    $16, $19, $19
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
bg_cont.31513:
	fcmp    $18, $zero
	ble     bg_cont.31514
bg_then.31514:
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
bg_cont.31514:
be_cont.31512:
	load    [min_caml_intersection_point + 0], $16
	li      min_caml_intersection_point, $2
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
	load    [f.27098], $1
.count stack_load
	load    [$sp - 9], $2
	fcmp    $2, $1
	bg      ble_else.31515
ble_then.31515:
	ret
ble_else.31515:
.count stack_load
	load    [$sp - 7], $1
	cmp     $1, 4
	bge     bl_cont.31516
bl_then.31516:
.count stack_load
	load    [$sp - 4], $4
	add     $1, 1, $1
	add     $zero, -1, $3
.count storer
	add     $4, $1, $tmp
	store   $3, [$tmp + 0]
bl_cont.31516:
.count stack_load
	load    [$sp - 3], $1
	load    [$1 + 2], $3
	cmp     $3, 2
	bne     be_else.31517
be_then.31517:
	load    [$1 + 7], $1
.count stack_load
	load    [$sp - 7], $3
.count stack_load
	load    [$sp - 10], $4
	load    [$1 + 0], $1
	add     $3, 1, $3
	fadd    $4, $49, $6
	fsub    $36, $1, $1
.count stack_load
	load    [$sp - 8], $4
.count stack_load
	load    [$sp - 6], $5
	fmul    $2, $1, $1
.count move_args
	mov     $3, $2
.count move_args
	mov     $1, $3
	b       trace_ray.2920
be_else.31517:
	ret
ble_else.31475:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 4, $sp
.count load_float
	load    [f.27103], $34
.count stack_store
	store   $3, [$sp + 0]
.count move_float
	mov     $34, $49
.count stack_store
	store   $2, [$sp + 1]
	load    [$59 + 0], $34
	load    [$34 + 0], $35
	cmp     $35, -1
	be      bne_cont.31518
bne_then.31518:
	cmp     $35, 99
	bne     be_else.31519
be_then.31519:
	load    [$34 + 1], $35
.count move_args
	mov     $2, $4
	cmp     $35, -1
	bne     be_else.31520
be_then.31520:
	li      1, $34
.count move_args
	mov     $59, $3
.count move_args
	mov     $34, $2
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31519
be_else.31520:
	li      0, $30
	load    [min_caml_and_net + $35], $3
.count move_args
	mov     $30, $2
	call    solve_each_element_fast.2885
	load    [$34 + 2], $35
.count stack_load
	load    [$sp + 1], $4
	cmp     $35, -1
	bne     be_else.31521
be_then.31521:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31519
be_else.31521:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element_fast.2885
	load    [$34 + 3], $35
.count stack_load
	load    [$sp + 1], $4
	cmp     $35, -1
	bne     be_else.31522
be_then.31522:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31519
be_else.31522:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element_fast.2885
	load    [$34 + 4], $35
.count stack_load
	load    [$sp + 1], $4
	cmp     $35, -1
	bne     be_else.31523
be_then.31523:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31519
be_else.31523:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31519
be_else.31519:
.count move_args
	mov     $2, $3
.count move_args
	mov     $35, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $35
	cmp     $35, 0
.count stack_load
	load    [$sp + 1], $4
	li      1, $2
	bne     be_else.31524
be_then.31524:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       be_cont.31524
be_else.31524:
	fcmp    $49, $42
	bg      ble_else.31525
ble_then.31525:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
.count b_cont
	b       ble_cont.31525
ble_else.31525:
.count move_args
	mov     $34, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31525:
be_cont.31524:
be_cont.31519:
bne_cont.31518:
.count load_float
	load    [f.27089], $18
	fcmp    $49, $18
	bg      ble_else.31526
ble_then.31526:
	li      0, $19
.count b_cont
	b       ble_cont.31526
ble_else.31526:
.count load_float
	load    [f.27104], $19
	fcmp    $19, $49
	bg      ble_else.31527
ble_then.31527:
	li      0, $19
.count b_cont
	b       ble_cont.31527
ble_else.31527:
	li      1, $19
ble_cont.31527:
ble_cont.31526:
	cmp     $19, 0
	bne     be_else.31528
be_then.31528:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31528:
	load    [min_caml_intersected_object_id + 0], $20
.count stack_load
	load    [$sp + 1], $19
	load    [min_caml_objects + $20], $2
	load    [$19 + 0], $19
.count stack_store
	store   $2, [$sp + 2]
	load    [$2 + 1], $20
	cmp     $20, 1
	bne     be_else.31529
be_then.31529:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $20
	sub     $20, 1, $20
	load    [$19 + $20], $19
	fcmp    $19, $zero
	bne     be_else.31530
be_then.31530:
	store   $zero, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.31529
be_else.31530:
	fcmp    $19, $zero
	bg      ble_else.31531
ble_then.31531:
	store   $36, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.31529
ble_else.31531:
	store   $40, [min_caml_nvector + $20]
.count b_cont
	b       be_cont.31529
be_else.31529:
	cmp     $20, 2
	bne     be_else.31532
be_then.31532:
	load    [$2 + 4], $19
	load    [$19 + 0], $19
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
	b       be_cont.31532
be_else.31532:
	load    [$2 + 5], $21
	load    [min_caml_intersection_point + 0], $22
	load    [$2 + 4], $23
	load    [$21 + 0], $21
	load    [$2 + 5], $24
	load    [$2 + 4], $25
	fsub    $22, $21, $21
	load    [$24 + 1], $24
	load    [$23 + 1], $22
	load    [min_caml_intersection_point + 2], $26
	load    [min_caml_intersection_point + 1], $23
	load    [$2 + 4], $20
	load    [$2 + 3], $19
	fsub    $23, $24, $23
	load    [$20 + 0], $20
	load    [$25 + 2], $24
	cmp     $19, 0
	load    [$2 + 5], $25
	fmul    $21, $20, $20
	fmul    $23, $22, $22
	load    [$25 + 2], $25
	fsub    $26, $25, $25
	fmul    $25, $24, $24
	bne     be_else.31533
be_then.31533:
	store   $20, [min_caml_nvector + 0]
	store   $22, [min_caml_nvector + 1]
	store   $24, [min_caml_nvector + 2]
.count b_cont
	b       be_cont.31533
be_else.31533:
	load    [$2 + 9], $26
	load    [$2 + 9], $19
	load    [$26 + 1], $26
	load    [$19 + 2], $19
	fmul    $25, $26, $26
	fmul    $23, $19, $19
	fadd    $19, $26, $19
	fmul    $19, $39, $19
	fadd    $20, $19, $19
	store   $19, [min_caml_nvector + 0]
	load    [$2 + 9], $20
	load    [$2 + 9], $19
	load    [$20 + 0], $20
	load    [$19 + 2], $19
	fmul    $25, $20, $20
	fmul    $21, $19, $19
	fadd    $19, $20, $19
	fmul    $19, $39, $19
	fadd    $22, $19, $19
	store   $19, [min_caml_nvector + 1]
	load    [$2 + 9], $20
	load    [$2 + 9], $19
	load    [$20 + 0], $20
	load    [$19 + 1], $19
	fmul    $23, $20, $20
	fmul    $21, $19, $19
	fadd    $19, $20, $19
	fmul    $19, $39, $19
	fadd    $24, $19, $19
	store   $19, [min_caml_nvector + 2]
be_cont.31533:
	load    [min_caml_nvector + 0], $20
	load    [min_caml_nvector + 1], $22
	load    [min_caml_nvector + 2], $23
	fmul    $20, $20, $21
	fmul    $22, $22, $22
	fmul    $23, $23, $23
	load    [$2 + 6], $19
	fadd    $21, $22, $21
	fadd    $21, $23, $21
	fsqrt   $21, $21
	fcmp    $21, $zero
	bne     be_else.31534
be_then.31534:
	mov     $36, $19
.count b_cont
	b       be_cont.31534
be_else.31534:
	cmp     $19, 0
	finv    $21, $19
	be      bne_cont.31535
bne_then.31535:
	fneg    $19, $19
bne_cont.31535:
be_cont.31534:
	fmul    $20, $19, $20
	store   $20, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $20
	fmul    $20, $19, $20
	store   $20, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $20
	fmul    $20, $19, $19
	store   $19, [min_caml_nvector + 2]
be_cont.31532:
be_cont.31529:
	call    utexture.2908
	load    [$59 + 0], $16
	load    [$16 + 0], $2
	cmp     $2, -1
	bne     be_else.31536
be_then.31536:
	li      0, $1
.count b_cont
	b       be_cont.31536
be_else.31536:
.count stack_store
	store   $16, [$sp + 3]
	cmp     $2, 99
	bne     be_else.31537
be_then.31537:
	li      1, $34
.count b_cont
	b       be_cont.31537
be_else.31537:
	call    solver_fast.2796
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31538
be_then.31538:
	li      0, $34
.count b_cont
	b       be_cont.31538
be_else.31538:
	fcmp    $18, $42
	bg      ble_else.31539
ble_then.31539:
	li      0, $34
.count b_cont
	b       ble_cont.31539
ble_else.31539:
	load    [$16 + 1], $34
	cmp     $34, -1
	bne     be_else.31540
be_then.31540:
	li      0, $34
.count b_cont
	b       be_cont.31540
be_else.31540:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31541
be_then.31541:
.count stack_load
	load    [$sp + 3], $34
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31542
be_then.31542:
	li      0, $34
.count b_cont
	b       be_cont.31541
be_else.31542:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31543
be_then.31543:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $34
	cmp     $34, 0
	bne     be_else.31544
be_then.31544:
	li      0, $34
.count b_cont
	b       be_cont.31541
be_else.31544:
	li      1, $34
.count b_cont
	b       be_cont.31541
be_else.31543:
	li      1, $34
.count b_cont
	b       be_cont.31541
be_else.31541:
	li      1, $34
be_cont.31541:
be_cont.31540:
ble_cont.31539:
be_cont.31538:
be_cont.31537:
	cmp     $34, 0
	bne     be_else.31545
be_then.31545:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.31545
be_else.31545:
.count stack_load
	load    [$sp + 3], $34
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31546
be_then.31546:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.31546
be_else.31546:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $35
	cmp     $35, 0
	bne     be_else.31547
be_then.31547:
	load    [$34 + 2], $35
	cmp     $35, -1
	bne     be_else.31548
be_then.31548:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.31547
be_else.31548:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    shadow_check_and_group.2862
	cmp     $1, 0
	bne     be_else.31549
be_then.31549:
	li      3, $2
.count move_args
	mov     $34, $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.31550
be_then.31550:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count b_cont
	b       be_cont.31547
be_else.31550:
	li      1, $1
.count b_cont
	b       be_cont.31547
be_else.31549:
	li      1, $1
.count b_cont
	b       be_cont.31547
be_else.31547:
	li      1, $1
be_cont.31547:
be_cont.31546:
be_cont.31545:
be_cont.31536:
.count stack_move
	add     $sp, 4, $sp
	cmp     $1, 0
	bne     be_else.31551
be_then.31551:
	load    [min_caml_nvector + 0], $3
	load    [min_caml_nvector + 1], $4
	load    [min_caml_nvector + 2], $5
	fmul    $3, $55, $3
	fmul    $4, $56, $4
.count stack_load
	load    [$sp - 2], $1
	load    [min_caml_texture_color + 0], $2
	load    [$1 + 7], $1
	fadd    $3, $4, $3
	fmul    $5, $57, $4
	fadd    $3, $4, $3
	fneg    $3, $3
	fcmp    $3, $zero
	bg      ble_cont.31552
ble_then.31552:
	mov     $zero, $3
ble_cont.31552:
.count stack_load
	load    [$sp - 4], $4
	load    [$1 + 0], $1
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
be_else.31551:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	cmp     $4, 0
	bl      bge_else.31553
bge_then.31553:
	load    [$2 + $4], $1
	load    [$3 + 0], $5
.count stack_move
	sub     $sp, 4, $sp
	load    [$1 + 0], $1
	load    [$1 + 0], $6
	load    [$1 + 1], $7
	fmul    $6, $5, $5
	load    [$1 + 2], $1
	load    [$3 + 1], $6
	fmul    $7, $6, $6
	load    [$3 + 2], $7
.count stack_store
	store   $3, [$sp + 0]
	fadd    $5, $6, $5
	fmul    $1, $7, $1
.count stack_store
	store   $2, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
	fadd    $5, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31554
ble_then.31554:
	load    [$2 + $4], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31555
bge_then.31555:
.count stack_load
	load    [$sp + 1], $2
.count stack_load
	load    [$sp + 0], $4
	load    [$2 + $1], $3
	load    [$4 + 0], $5
	load    [$3 + 0], $3
	load    [$3 + 0], $6
	load    [$3 + 1], $7
	fmul    $6, $5, $5
	load    [$3 + 2], $3
	load    [$4 + 1], $6
	fmul    $7, $6, $6
	load    [$4 + 2], $7
.count stack_store
	store   $1, [$sp + 3]
	fadd    $5, $6, $5
	fmul    $3, $7, $3
	fadd    $5, $3, $3
	fcmp    $zero, $3
	bg      ble_else.31556
ble_then.31556:
	fmul    $3, $37, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.31556:
	add     $1, 1, $1
	fmul    $3, $38, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.31555:
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.31554:
	fmul    $1, $38, $3
	add     $4, 1, $1
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31557
bge_then.31557:
.count stack_load
	load    [$sp + 1], $2
.count stack_load
	load    [$sp + 0], $4
	load    [$2 + $1], $3
	load    [$4 + 0], $5
	load    [$3 + 0], $3
	load    [$3 + 0], $6
	load    [$3 + 1], $7
	fmul    $6, $5, $5
	load    [$3 + 2], $3
	load    [$4 + 1], $6
	fmul    $7, $6, $6
	load    [$4 + 2], $7
.count stack_store
	store   $1, [$sp + 3]
	fadd    $5, $6, $5
	fmul    $3, $7, $3
	fadd    $5, $3, $3
	fcmp    $zero, $3
	bg      ble_else.31558
ble_then.31558:
	load    [$2 + $1], $2
	fmul    $3, $37, $3
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.31558:
	add     $1, 1, $1
	fmul    $3, $38, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.31557:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31553:
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
	load    [$2 + 1], $17
	load    [$2 + 7], $16
	load    [$16 + $3], $16
.count stack_store
	store   $16, [$sp + 2]
	load    [$17 + $3], $2
.count stack_store
	store   $2, [$sp + 3]
	load    [$18 + 0], $17
.count stack_store
	store   $17, [$sp + 4]
	cmp     $17, 0
	be      bne_cont.31559
bne_then.31559:
	load    [$2 + 0], $18
	load    [min_caml_dirvecs + 0], $17
	sub     $41, 1, $3
.count move_float
	mov     $18, $51
	load    [$2 + 1], $18
.count move_float
	mov     $18, $52
	load    [$2 + 2], $18
.count move_float
	mov     $18, $53
	call    setup_startp_constants.2831
	load    [$17 + 118], $18
	load    [$16 + 0], $19
	load    [$16 + 1], $22
	load    [$18 + 0], $18
	load    [$18 + 0], $20
	load    [$18 + 1], $21
	fmul    $20, $19, $19
	load    [$18 + 2], $18
	fmul    $21, $22, $20
	load    [$16 + 2], $21
.count stack_store
	store   $17, [$sp + 5]
	fadd    $19, $20, $19
	fmul    $18, $21, $18
	fadd    $19, $18, $18
	fcmp    $zero, $18
	bg      ble_else.31560
ble_then.31560:
	load    [$17 + 118], $2
.count load_float
	load    [f.27111], $16
	fmul    $18, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31560
ble_else.31560:
.count load_float
	load    [f.27110], $16
	load    [$17 + 119], $2
	fmul    $18, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31560:
bne_cont.31559:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 1
	be      bne_cont.31561
bne_then.31561:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $21
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	fmul    $20, $21, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 6]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31562
ble_then.31562:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
.count load_float
	load    [f.27111], $16
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31562
ble_else.31562:
.count load_float
	load    [f.27110], $18
	load    [$16 + 119], $2
	fmul    $17, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31562:
bne_cont.31561:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 2
	be      bne_cont.31563
bne_then.31563:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $21
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	fmul    $20, $21, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 7]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31564
ble_then.31564:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
.count load_float
	load    [f.27111], $16
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31564
ble_else.31564:
.count load_float
	load    [f.27110], $18
	load    [$16 + 119], $2
	fmul    $17, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31564:
bne_cont.31563:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 3
	be      bne_cont.31565
bne_then.31565:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$3 + 1], $21
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	fmul    $20, $21, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 8]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31566
ble_then.31566:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
.count load_float
	load    [f.27111], $16
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31566
ble_else.31566:
.count load_float
	load    [f.27110], $18
	load    [$16 + 119], $2
	fmul    $17, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31566:
bne_cont.31565:
.count stack_load
	load    [$sp + 4], $16
	cmp     $16, 4
	be      bne_cont.31567
bne_then.31567:
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
	load    [$1 + 0], $1
	load    [$3 + 0], $2
	load    [$3 + 1], $6
	load    [$1 + 0], $4
	load    [$1 + 1], $5
	fmul    $4, $2, $2
	load    [$1 + 2], $1
	fmul    $5, $6, $4
	load    [$3 + 2], $5
.count stack_store
	store   $16, [$sp + 9]
	fadd    $2, $4, $2
	fmul    $1, $5, $1
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31568
ble_then.31568:
.count load_float
	load    [f.27111], $3
	load    [$16 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31568
ble_else.31568:
.count load_float
	load    [f.27110], $2
	fmul    $1, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31568:
bne_cont.31567:
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
	bg      ble_else.31569
ble_then.31569:
	load    [$2 + 2], $16
	load    [$16 + $3], $17
	cmp     $17, 0
	bl      bge_else.31570
bge_then.31570:
	load    [$2 + 3], $17
	load    [$17 + $3], $18
	cmp     $18, 0
	bne     be_else.31571
be_then.31571:
	add     $3, 1, $3
	cmp     $3, 4
	bg      ble_else.31572
ble_then.31572:
	load    [$16 + $3], $1
	cmp     $1, 0
	bl      bge_else.31573
bge_then.31573:
	load    [$17 + $3], $1
	cmp     $1, 0
	bne     be_else.31574
be_then.31574:
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31574:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 12], $1
.count stack_load
	load    [$sp - 13], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.31573:
	ret
ble_else.31572:
	ret
be_else.31571:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $17, [$sp + 2]
.count stack_store
	store   $16, [$sp + 3]
.count stack_store
	store   $3, [$sp + 4]
.count stack_store
	store   $2, [$sp + 0]
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
	load    [$2 + 1], $17
	load    [$2 + 7], $16
	load    [$16 + $3], $16
.count stack_store
	store   $16, [$sp + 5]
	load    [$17 + $3], $2
.count stack_store
	store   $2, [$sp + 6]
	load    [$18 + 0], $17
.count stack_store
	store   $17, [$sp + 7]
	cmp     $17, 0
	be      bne_cont.31575
bne_then.31575:
	load    [$2 + 0], $18
	load    [min_caml_dirvecs + 0], $17
	sub     $41, 1, $3
.count move_float
	mov     $18, $51
	load    [$2 + 1], $18
.count move_float
	mov     $18, $52
	load    [$2 + 2], $18
.count move_float
	mov     $18, $53
	call    setup_startp_constants.2831
	load    [$17 + 118], $18
	load    [$16 + 0], $19
	load    [$18 + 0], $18
	load    [$18 + 0], $20
	load    [$18 + 1], $21
	fmul    $20, $19, $19
	load    [$18 + 2], $18
	load    [$16 + 1], $20
	fmul    $21, $20, $20
	load    [$16 + 2], $21
.count stack_store
	store   $17, [$sp + 8]
	fadd    $19, $20, $19
	fmul    $18, $21, $18
	fadd    $19, $18, $18
	fcmp    $zero, $18
	bg      ble_else.31576
ble_then.31576:
	load    [$17 + 118], $2
	fmul    $18, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31576
ble_else.31576:
	fmul    $18, $38, $3
	load    [$17 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31576:
bne_cont.31575:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 1
	be      bne_cont.31577
bne_then.31577:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	load    [$3 + 1], $19
	fmul    $20, $19, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 9]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31578
ble_then.31578:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31578
ble_else.31578:
	fmul    $17, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31578:
bne_cont.31577:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 2
	be      bne_cont.31579
bne_then.31579:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	load    [$3 + 1], $19
	fmul    $20, $19, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 10]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31580
ble_then.31580:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31580
ble_else.31580:
	fmul    $17, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31580:
bne_cont.31579:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 3
	be      bne_cont.31581
bne_then.31581:
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
	load    [$17 + 0], $17
	load    [$3 + 0], $18
	load    [$17 + 0], $19
	load    [$17 + 1], $20
	fmul    $19, $18, $18
	load    [$17 + 2], $17
	load    [$3 + 1], $19
	fmul    $20, $19, $19
	load    [$3 + 2], $20
.count stack_store
	store   $16, [$sp + 11]
	fadd    $18, $19, $18
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31582
ble_then.31582:
	load    [$16 + 118], $2
	fmul    $17, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31582
ble_else.31582:
	fmul    $17, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31582:
bne_cont.31581:
.count stack_load
	load    [$sp + 7], $16
	cmp     $16, 4
	be      bne_cont.31583
bne_then.31583:
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
	load    [$1 + 0], $1
	load    [$3 + 0], $2
	load    [$1 + 0], $4
	load    [$1 + 1], $5
	fmul    $4, $2, $2
	load    [$1 + 2], $1
	load    [$3 + 1], $4
	fmul    $5, $4, $4
	load    [$3 + 2], $5
.count stack_store
	store   $16, [$sp + 12]
	fadd    $2, $4, $2
	fmul    $1, $5, $1
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31584
ble_then.31584:
	load    [$16 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31584
ble_else.31584:
	fmul    $1, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31584:
bne_cont.31583:
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
	bg      ble_else.31585
ble_then.31585:
.count stack_load
	load    [$sp + 3], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bl      bge_else.31586
bge_then.31586:
.count stack_load
	load    [$sp + 2], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bne     be_else.31587
be_then.31587:
.count stack_move
	add     $sp, 13, $sp
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31587:
.count stack_store
	store   $3, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 12], $1
.count stack_load
	load    [$sp - 13], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.31586:
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.31585:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31570:
	ret
ble_else.31569:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	cmp     $6, 4
	bg      ble_else.31588
ble_then.31588:
	load    [$4 + $2], $1
	load    [$1 + 2], $7
	load    [$7 + $6], $7
	cmp     $7, 0
	bl      bge_else.31589
bge_then.31589:
	load    [$3 + $2], $8
	load    [$8 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31590
be_then.31590:
	load    [$5 + $2], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31591
be_then.31591:
	sub     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31592
be_then.31592:
	add     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31593
be_then.31593:
	li      1, $7
.count b_cont
	b       be_cont.31590
be_else.31593:
	li      0, $7
.count b_cont
	b       be_cont.31590
be_else.31592:
	li      0, $7
.count b_cont
	b       be_cont.31590
be_else.31591:
	li      0, $7
.count b_cont
	b       be_cont.31590
be_else.31590:
	li      0, $7
be_cont.31590:
	cmp     $7, 0
	bne     be_else.31594
be_then.31594:
	cmp     $6, 4
	bg      ble_else.31595
ble_then.31595:
	load    [$4 + $2], $2
	load    [$2 + 2], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bl      bge_else.31596
bge_then.31596:
	load    [$2 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31597
be_then.31597:
	add     $6, 1, $3
	b       do_without_neighbors.2951
be_else.31597:
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
bge_else.31596:
	ret
ble_else.31595:
	ret
be_else.31594:
	load    [$1 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31598
be_then.31598:
	add     $6, 1, $6
	b       try_exploit_neighbors.2967
be_else.31598:
	load    [$8 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
	load    [$1 + 2], $1
.count move_float
	mov     $7, $44
.count move_float
	mov     $1, $45
	sub     $2, 1, $1
	load    [$4 + $1], $1
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
.count move_float
	mov     $1, $45
	add     $2, 1, $1
	load    [$4 + $1], $1
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
bge_else.31589:
	ret
ble_else.31588:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	cmp     $3, 4
	bg      ble_else.31599
ble_then.31599:
	load    [$2 + 2], $16
	load    [$16 + $3], $17
	cmp     $17, 0
	bl      bge_else.31600
bge_then.31600:
	load    [$2 + 3], $17
	load    [$17 + $3], $18
	cmp     $18, 0
	bne     be_else.31601
be_then.31601:
	add     $3, 1, $18
	cmp     $18, 4
	bg      ble_else.31602
ble_then.31602:
	load    [$16 + $18], $16
	cmp     $16, 0
	bl      bge_else.31603
bge_then.31603:
	load    [$17 + $18], $16
	cmp     $16, 0
	bne     be_else.31604
be_then.31604:
	add     $18, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31604:
.count stack_move
	sub     $sp, 14, $sp
.count move_float
	mov     $zero, $43
.count stack_store
	store   $18, [$sp + 0]
.count move_float
	mov     $zero, $44
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 1], $19
	load    [$2 + 7], $17
	load    [$2 + 6], $16
.count move_float
	mov     $zero, $45
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
	load    [$3 + 1], $5
	load    [$3 + 0], $4
	load    [$2 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 1], $7
	load    [$1 + 0], $6
	fmul    $7, $5, $5
	fmul    $6, $4, $4
	load    [$1 + 2], $1
	load    [$3 + 2], $6
.count stack_store
	store   $3, [$sp + 2]
	fadd    $4, $5, $4
	fmul    $1, $6, $1
.count stack_store
	store   $2, [$sp + 3]
	fadd    $4, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31605
ble_then.31605:
	load    [$2 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31605
ble_else.31605:
	fmul    $1, $38, $3
	load    [$2 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31605:
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 13], $2
.count stack_load
	load    [$sp - 14], $3
	load    [$2 + 5], $1
	load    [$1 + $3], $1
	add     $3, 1, $3
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	b       pretrace_diffuse_rays.2980
bge_else.31603:
	ret
ble_else.31602:
	ret
be_else.31601:
.count stack_move
	sub     $sp, 14, $sp
.count move_float
	mov     $zero, $43
.count stack_store
	store   $17, [$sp + 4]
.count move_float
	mov     $zero, $44
.count stack_store
	store   $16, [$sp + 5]
.count move_float
	mov     $zero, $45
.count stack_store
	store   $2, [$sp + 1]
.count stack_store
	store   $3, [$sp + 6]
	load    [$2 + 7], $17
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
	load    [$17 + $18], $3
.count stack_store
	store   $3, [$sp + 9]
	load    [min_caml_dirvecs + $16], $2
.count stack_store
	store   $2, [$sp + 10]
	load    [$2 + 118], $16
	load    [$3 + 1], $18
	load    [$3 + 0], $17
	load    [$16 + 0], $16
	load    [$16 + 1], $20
	load    [$16 + 0], $19
	fmul    $20, $18, $18
	fmul    $19, $17, $17
	load    [$16 + 2], $16
	load    [$3 + 2], $19
	fadd    $17, $18, $17
	fmul    $16, $19, $16
	fadd    $17, $16, $16
	fcmp    $zero, $16
	bg      ble_else.31606
ble_then.31606:
	load    [$2 + 118], $2
.count load_float
	load    [f.27111], $17
	fmul    $16, $37, $3
	call    trace_diffuse_ray.2926
.count b_cont
	b       ble_cont.31606
ble_else.31606:
.count load_float
	load    [f.27110], $17
	load    [$2 + 119], $2
	fmul    $16, $38, $3
	call    trace_diffuse_ray.2926
ble_cont.31606:
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
	store   $43, [$18 + 0]
	cmp     $17, 4
	store   $44, [$18 + 1]
	store   $45, [$18 + 2]
	bg      ble_else.31607
ble_then.31607:
.count stack_load
	load    [$sp + 5], $18
	load    [$18 + $17], $18
	cmp     $18, 0
	bl      bge_else.31608
bge_then.31608:
.count stack_load
	load    [$sp + 4], $18
	load    [$18 + $17], $18
	cmp     $18, 0
	bne     be_else.31609
be_then.31609:
.count stack_move
	add     $sp, 14, $sp
	add     $17, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31609:
.count stack_store
	store   $17, [$sp + 0]
.count move_float
	mov     $zero, $43
.count stack_store
	store   $16, [$sp + 11]
.count stack_load
	load    [$sp + 8], $18
	load    [$2 + 6], $16
.count move_float
	mov     $zero, $44
	load    [$18 + $17], $2
.count move_float
	mov     $zero, $45
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
	load    [$sp + 7], $2
	load    [$16 + 0], $1
	load    [$2 + $17], $3
	load    [min_caml_dirvecs + $1], $2
	load    [$3 + 1], $5
	load    [$3 + 0], $4
	load    [$2 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 1], $7
	load    [$1 + 0], $6
	fmul    $7, $5, $5
	fmul    $6, $4, $4
	load    [$1 + 2], $1
	load    [$3 + 2], $6
.count stack_store
	store   $3, [$sp + 12]
	fadd    $4, $5, $4
	fmul    $1, $6, $1
.count stack_store
	store   $2, [$sp + 13]
	fadd    $4, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31610
ble_then.31610:
	load    [$2 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 13], $2
.count stack_load
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31610
ble_else.31610:
	fmul    $1, $38, $3
	load    [$2 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 13], $2
.count stack_load
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31610:
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 14], $1
.count stack_load
	load    [$sp - 3], $2
	add     $1, 1, $3
	load    [$2 + $1], $2
	store   $43, [$2 + 0]
	store   $44, [$2 + 1]
	store   $45, [$2 + 2]
.count stack_load
	load    [$sp - 13], $2
	b       pretrace_diffuse_rays.2980
bge_else.31608:
.count stack_move
	add     $sp, 14, $sp
	ret
ble_else.31607:
.count stack_move
	add     $sp, 14, $sp
	ret
bge_else.31600:
	ret
ble_else.31599:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	cmp     $3, 0
	bl      bge_else.31611
bge_then.31611:
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
.count stack_load
	load    [$sp + 5], $18
	fmul    $11, $16, $16
	fmul    $16, $10, $17
	fadd    $17, $18, $17
	store   $17, [min_caml_ptrace_dirvec + 0]
.count stack_load
	load    [$sp + 4], $18
	load    [min_caml_screenx_dir + 1], $17
	fmul    $16, $17, $17
	fadd    $17, $18, $17
	store   $17, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $17
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $17
	fadd    $16, $17, $16
	store   $16, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 1], $18
	load    [min_caml_ptrace_dirvec + 0], $16
	load    [min_caml_ptrace_dirvec + 2], $19
	fmul    $18, $18, $18
	fmul    $16, $16, $17
	fmul    $19, $19, $19
	fadd    $17, $18, $17
	fadd    $17, $19, $17
	fsqrt   $17, $17
	fcmp    $17, $zero
	bne     be_else.31612
be_then.31612:
	mov     $36, $17
.count b_cont
	b       be_cont.31612
be_else.31612:
	finv    $17, $17
be_cont.31612:
	fmul    $16, $17, $16
.count move_float
	mov     $zero, $46
.count move_float
	mov     $zero, $47
.count move_float
	mov     $zero, $48
	li      min_caml_ptrace_dirvec, $4
	store   $16, [min_caml_ptrace_dirvec + 0]
	li      0, $2
	load    [min_caml_ptrace_dirvec + 1], $16
.count move_args
	mov     $zero, $6
.count move_args
	mov     $36, $3
	fmul    $16, $17, $16
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
	load    [$sp + 2], $17
.count stack_load
	load    [$sp + 1], $16
	load    [$17 + $16], $5
	call    trace_ray.2920
.count stack_load
	load    [$sp + 1], $16
.count stack_load
	load    [$sp + 2], $17
	load    [$17 + $16], $18
	load    [$18 + 0], $18
	store   $46, [$18 + 0]
	store   $47, [$18 + 1]
	store   $48, [$18 + 2]
.count stack_load
	load    [$sp + 0], $19
	load    [$17 + $16], $18
	load    [$18 + 6], $18
	store   $19, [$18 + 0]
	load    [$17 + $16], $2
	load    [$2 + 2], $16
	load    [$16 + 0], $16
	cmp     $16, 0
	bl      bge_cont.31613
bge_then.31613:
	load    [$2 + 3], $16
	load    [$16 + 0], $16
	cmp     $16, 0
	bne     be_else.31614
be_then.31614:
	li      1, $3
	call    pretrace_diffuse_rays.2980
.count b_cont
	b       be_cont.31614
be_else.31614:
.count stack_store
	store   $2, [$sp + 6]
	load    [$2 + 1], $18
	load    [$2 + 7], $17
	load    [$2 + 6], $16
.count move_float
	mov     $zero, $43
	load    [$18 + 0], $2
	load    [$16 + 0], $16
.count move_float
	mov     $zero, $44
	load    [$2 + 0], $18
.count move_float
	mov     $zero, $45
	load    [$17 + 0], $17
.count move_float
	mov     $18, $51
	load    [min_caml_dirvecs + $16], $16
	load    [$2 + 1], $18
	sub     $41, 1, $3
.count move_float
	mov     $18, $52
	load    [$2 + 2], $18
.count move_float
	mov     $18, $53
	call    setup_startp_constants.2831
	load    [$16 + 118], $1
	load    [$17 + 0], $2
	load    [$17 + 1], $5
	load    [$1 + 0], $1
	load    [$1 + 0], $3
	load    [$1 + 1], $4
	fmul    $3, $2, $2
	load    [$1 + 2], $1
	fmul    $4, $5, $3
	load    [$17 + 2], $4
.count stack_store
	store   $17, [$sp + 7]
	fadd    $2, $3, $2
	fmul    $1, $4, $1
.count stack_store
	store   $16, [$sp + 8]
	fadd    $2, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31615
ble_then.31615:
	load    [$16 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
.count b_cont
	b       ble_cont.31615
ble_else.31615:
	fmul    $1, $38, $3
	load    [$16 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31615:
.count stack_load
	load    [$sp + 6], $2
	li      1, $3
	load    [$2 + 5], $1
	load    [$1 + 0], $1
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	call    pretrace_diffuse_rays.2980
be_cont.31614:
bge_cont.31613:
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
	load    [$sp - 4], $5
.count stack_load
	load    [$sp - 9], $1
.count stack_load
	load    [$sp - 7], $2
	add     $1, 1, $4
	cmp     $4, 5
	bl      pretrace_pixels.2983
	sub     $4, 5, $4
	b       pretrace_pixels.2983
bge_else.31611:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.2994:
	cmp     $50, $2
	bg      ble_else.31617
ble_then.31617:
	ret
ble_else.31617:
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
	load    [$5 + $2], $10
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
.count stack_store
	store   $10, [$sp + 5]
	cmp     $60, $10
	bg      ble_else.31618
ble_then.31618:
	li      0, $10
.count b_cont
	b       ble_cont.31618
ble_else.31618:
	cmp     $3, 0
	bg      ble_else.31619
ble_then.31619:
	li      0, $10
.count b_cont
	b       ble_cont.31619
ble_else.31619:
	add     $2, 1, $10
	cmp     $50, $10
	bg      ble_else.31620
ble_then.31620:
	li      0, $10
.count b_cont
	b       ble_cont.31620
ble_else.31620:
	cmp     $2, 0
	bg      ble_else.31621
ble_then.31621:
	li      0, $10
.count b_cont
	b       ble_cont.31621
ble_else.31621:
	li      1, $10
ble_cont.31621:
ble_cont.31620:
ble_cont.31619:
ble_cont.31618:
	cmp     $10, 0
	li      0, $3
	bne     be_else.31622
be_then.31622:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31622
bge_then.31623:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31624
be_then.31624:
	li      1, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31622
be_else.31624:
.count stack_store
	store   $2, [$sp + 6]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 6], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31622
be_else.31622:
	load    [$5 + $2], $10
	load    [$10 + 2], $11
	load    [$11 + 0], $11
	cmp     $11, 0
	bl      bge_cont.31625
bge_then.31625:
	load    [$4 + $2], $12
	load    [$12 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31626
be_then.31626:
	load    [$6 + $2], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31627
be_then.31627:
	sub     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31628
be_then.31628:
	add     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31629
be_then.31629:
	li      1, $11
.count b_cont
	b       be_cont.31626
be_else.31629:
	li      0, $11
.count b_cont
	b       be_cont.31626
be_else.31628:
	li      0, $11
.count b_cont
	b       be_cont.31626
be_else.31627:
	li      0, $11
.count b_cont
	b       be_cont.31626
be_else.31626:
	li      0, $11
be_cont.31626:
	cmp     $11, 0
	bne     be_else.31630
be_then.31630:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31630
bge_then.31631:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31632
be_then.31632:
	li      1, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31630
be_else.31632:
.count stack_store
	store   $2, [$sp + 7]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 7], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31630
be_else.31630:
	load    [$10 + 3], $10
.count move_args
	mov     $4, $3
	load    [$10 + 0], $10
.count move_args
	mov     $5, $4
	cmp     $10, 0
	bne     be_else.31633
be_then.31633:
	li      1, $10
.count move_args
	mov     $6, $5
.count move_args
	mov     $10, $6
	call    try_exploit_neighbors.2967
.count b_cont
	b       be_cont.31633
be_else.31633:
	load    [$12 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
	load    [$10 + 2], $10
.count move_float
	mov     $11, $44
.count move_float
	mov     $10, $45
	sub     $2, 1, $10
	load    [$5 + $10], $10
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
.count move_float
	mov     $10, $45
	add     $2, 1, $10
	load    [$5 + $10], $10
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
.count move_float
	mov     $10, $48
	li      1, $10
.count move_args
	mov     $10, $6
	call    try_exploit_neighbors.2967
be_cont.31633:
be_cont.31630:
bge_cont.31625:
be_cont.31622:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31634
ble_then.31634:
	cmp     $2, 0
	bl      bge_else.31635
bge_then.31635:
	call    min_caml_write
.count b_cont
	b       ble_cont.31634
bge_else.31635:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.31634
ble_else.31634:
	li      255, $2
	call    min_caml_write
ble_cont.31634:
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31636
ble_then.31636:
	cmp     $2, 0
	bl      bge_else.31637
bge_then.31637:
	call    min_caml_write
.count b_cont
	b       ble_cont.31636
bge_else.31637:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.31636
ble_else.31636:
	li      255, $2
	call    min_caml_write
ble_cont.31636:
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31638
ble_then.31638:
	cmp     $2, 0
	bl      bge_else.31639
bge_then.31639:
	call    min_caml_write
.count b_cont
	b       ble_cont.31638
bge_else.31639:
	li      0, $2
	call    min_caml_write
.count b_cont
	b       ble_cont.31638
ble_else.31638:
	li      255, $2
	call    min_caml_write
ble_cont.31638:
.count stack_load
	load    [$sp + 4], $10
	add     $10, 1, $2
	cmp     $50, $2
	bg      ble_else.31640
ble_then.31640:
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.31640:
.count stack_store
	store   $2, [$sp + 8]
.count stack_load
	load    [$sp + 3], $4
	load    [$4 + $2], $10
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
.count stack_load
	load    [$sp + 5], $10
	cmp     $60, $10
	bg      ble_else.31641
ble_then.31641:
	li      0, $10
.count b_cont
	b       ble_cont.31641
ble_else.31641:
.count stack_load
	load    [$sp + 2], $10
	cmp     $10, 0
	bg      ble_else.31642
ble_then.31642:
	li      0, $10
.count b_cont
	b       ble_cont.31642
ble_else.31642:
	add     $2, 1, $10
	cmp     $50, $10
	bg      ble_else.31643
ble_then.31643:
	li      0, $10
.count b_cont
	b       ble_cont.31643
ble_else.31643:
	cmp     $2, 0
	bg      ble_else.31644
ble_then.31644:
	li      0, $10
.count b_cont
	b       ble_cont.31644
ble_else.31644:
	li      1, $10
ble_cont.31644:
ble_cont.31643:
ble_cont.31642:
ble_cont.31641:
	cmp     $10, 0
	bne     be_else.31645
be_then.31645:
	load    [$4 + $2], $2
	li      0, $3
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31645
bge_then.31646:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31647
be_then.31647:
	li      1, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31645
be_else.31647:
.count stack_store
	store   $2, [$sp + 9]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 9], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31645
be_else.31645:
	li      0, $6
.count stack_load
	load    [$sp + 1], $3
.count stack_load
	load    [$sp + 0], $5
	call    try_exploit_neighbors.2967
be_cont.31645:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31648
ble_then.31648:
	cmp     $1, 0
	bge     ble_cont.31648
bl_then.31649:
	li      0, $1
.count b_cont
	b       ble_cont.31648
ble_else.31648:
	li      255, $1
ble_cont.31648:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31650
ble_then.31650:
	cmp     $1, 0
	bge     ble_cont.31650
bl_then.31651:
	li      0, $1
.count b_cont
	b       ble_cont.31650
ble_else.31650:
	li      255, $1
ble_cont.31650:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31652
ble_then.31652:
	cmp     $1, 0
	bge     ble_cont.31652
bl_then.31653:
	li      0, $1
.count b_cont
	b       ble_cont.31652
ble_else.31652:
	li      255, $1
ble_cont.31652:
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
	bg      ble_else.31654
ble_then.31654:
	ret
ble_else.31654:
.count stack_move
	sub     $sp, 8, $sp
	sub     $60, 1, $10
.count stack_store
	store   $6, [$sp + 0]
	cmp     $10, $2
.count stack_store
	store   $5, [$sp + 1]
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
.count stack_store
	store   $4, [$sp + 4]
	ble     bg_cont.31655
bg_then.31655:
	load    [min_caml_image_center + 1], $12
	add     $2, 1, $10
	load    [min_caml_scan_pitch + 0], $11
	sub     $10, $12, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $10
	load    [min_caml_screenz_dir + 0], $12
	fmul    $11, $10, $10
	load    [min_caml_screeny_dir + 1], $13
	load    [min_caml_screeny_dir + 0], $11
	sub     $50, 1, $3
.count stack_load
	load    [$sp + 1], $2
	fmul    $10, $11, $11
.count stack_load
	load    [$sp + 0], $4
	fadd    $11, $12, $5
	fmul    $10, $13, $11
	load    [min_caml_screenz_dir + 1], $12
	load    [min_caml_screeny_dir + 2], $13
	fmul    $10, $13, $10
	fadd    $11, $12, $6
	load    [min_caml_screenz_dir + 2], $11
	fadd    $10, $11, $7
	call    pretrace_pixels.2983
bg_cont.31655:
	li      0, $2
	cmp     $50, 0
	ble     bg_cont.31656
bg_then.31656:
.count stack_load
	load    [$sp + 4], $4
	load    [$4 + 0], $10
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
.count stack_load
	load    [$sp + 3], $10
	add     $10, 1, $11
	cmp     $60, $11
	bg      ble_else.31657
ble_then.31657:
	li      0, $10
.count b_cont
	b       ble_cont.31657
ble_else.31657:
	cmp     $10, 0
	li      0, $10
	ble     bg_cont.31658
bg_then.31658:
	cmp     $50, 1
bg_cont.31658:
ble_cont.31657:
	cmp     $10, 0
	bne     be_else.31659
be_then.31659:
	load    [$4 + 0], $2
	li      0, $3
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31659
bge_then.31660:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31661
be_then.31661:
	li      1, $3
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31659
be_else.31661:
.count stack_store
	store   $2, [$sp + 5]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 5], $2
	call    do_without_neighbors.2951
.count b_cont
	b       be_cont.31659
be_else.31659:
	li      0, $6
.count stack_load
	load    [$sp + 2], $3
.count stack_load
	load    [$sp + 1], $5
	call    try_exploit_neighbors.2967
be_cont.31659:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31662
ble_then.31662:
	cmp     $1, 0
	bge     ble_cont.31662
bl_then.31663:
	li      0, $1
.count b_cont
	b       ble_cont.31662
ble_else.31662:
	li      255, $1
ble_cont.31662:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31664
ble_then.31664:
	cmp     $1, 0
	bge     ble_cont.31664
bl_then.31665:
	li      0, $1
.count b_cont
	b       ble_cont.31664
ble_else.31664:
	li      255, $1
ble_cont.31664:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31666
ble_then.31666:
	cmp     $1, 0
	bge     ble_cont.31666
bl_then.31667:
	li      0, $1
.count b_cont
	b       ble_cont.31666
ble_else.31666:
	li      255, $1
ble_cont.31666:
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
bg_cont.31656:
.count stack_load
	load    [$sp + 3], $10
	add     $10, 1, $10
	cmp     $60, $10
	bg      ble_else.31668
ble_then.31668:
.count stack_move
	add     $sp, 8, $sp
	ret
ble_else.31668:
.count stack_store
	store   $10, [$sp + 6]
.count stack_load
	load    [$sp + 0], $12
	sub     $60, 1, $11
	add     $12, 2, $12
	cmp     $12, 5
	bl      bge_cont.31669
bge_then.31669:
	sub     $12, 5, $12
bge_cont.31669:
.count stack_store
	store   $12, [$sp + 7]
	cmp     $11, $10
	ble     bg_cont.31670
bg_then.31670:
	load    [min_caml_image_center + 1], $15
	add     $10, 1, $10
	sub     $50, 1, $11
	load    [min_caml_screeny_dir + 0], $13
	load    [min_caml_scan_pitch + 0], $14
	sub     $10, $15, $2
	call    min_caml_float_of_int
	fmul    $14, $1, $1
	load    [min_caml_screenz_dir + 0], $2
	load    [min_caml_screeny_dir + 1], $4
	fmul    $1, $13, $3
	fmul    $1, $4, $4
	fadd    $3, $2, $5
	load    [min_caml_screeny_dir + 2], $3
	load    [min_caml_screenz_dir + 1], $2
	fmul    $1, $3, $1
	fadd    $4, $2, $6
.count move_args
	mov     $11, $3
	load    [min_caml_screenz_dir + 2], $2
.count move_args
	mov     $12, $4
	fadd    $1, $2, $7
.count stack_load
	load    [$sp + 2], $2
	call    pretrace_pixels.2983
bg_cont.31670:
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
	load    [$sp - 7], $3
.count stack_load
	load    [$sp - 1], $1
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
	store   $17, [$1 + 7]
	add     $hp, 8, $hp
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
	bl      bge_else.31672
bge_then.31672:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count move_args
	mov     $zero, $3
	li      3, $2
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
	store   $17, [$19 + 7]
	add     $hp, 8, $hp
	store   $16, [$19 + 6]
	store   $15, [$19 + 5]
	store   $14, [$19 + 4]
	store   $13, [$19 + 3]
	store   $12, [$19 + 2]
	store   $11, [$19 + 1]
	store   $10, [$19 + 0]
.count stack_load
	load    [$sp + 1], $21
.count stack_load
	load    [$sp + 0], $20
.count storer
	add     $21, $20, $tmp
	store   $19, [$tmp + 0]
	sub     $20, 1, $19
	cmp     $19, 0
	bl      bge_else.31673
bge_then.31673:
	call    create_pixel.3008
.count storer
	add     $21, $19, $tmp
.count move_ret
	mov     $1, $10
	store   $10, [$tmp + 0]
	sub     $19, 1, $10
	cmp     $10, 0
	bl      bge_else.31674
bge_then.31674:
	li      3, $2
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
.count storer
	add     $21, $10, $tmp
	mov     $hp, $19
	store   $18, [$19 + 7]
	add     $hp, 8, $hp
	store   $17, [$19 + 6]
	store   $16, [$19 + 5]
	store   $15, [$19 + 4]
	store   $14, [$19 + 3]
	store   $13, [$19 + 2]
	store   $12, [$19 + 1]
	store   $11, [$19 + 0]
	store   $19, [$tmp + 0]
	sub     $10, 1, $19
	cmp     $19, 0
	bl      bge_else.31675
bge_then.31675:
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
bge_else.31675:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31674:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31673:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31672:
	mov     $2, $1
	ret
.end init_line_elements

######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	cmp     $2, 5
	bl      bge_else.31676
bge_then.31676:
	fmul    $4, $4, $5
	fmul    $3, $3, $2
	load    [min_caml_dirvecs + $7], $1
	load    [$1 + $8], $6
	fadd    $2, $5, $2
	load    [$6 + 0], $6
	add     $8, 40, $5
	fadd    $2, $36, $2
	fsqrt   $2, $2
	finv    $2, $2
	fmul    $3, $2, $3
	fmul    $4, $2, $4
	store   $3, [$6 + 0]
	fneg    $3, $7
	store   $4, [$6 + 1]
	store   $2, [$6 + 2]
	load    [$1 + $5], $5
	fneg    $4, $6
	load    [$5 + 0], $5
	store   $3, [$5 + 0]
	store   $2, [$5 + 1]
	store   $6, [$5 + 2]
	add     $8, 80, $5
	load    [$1 + $5], $5
	load    [$5 + 0], $5
	store   $2, [$5 + 0]
	store   $7, [$5 + 1]
	fneg    $2, $2
	store   $6, [$5 + 2]
	add     $8, 1, $5
	load    [$1 + $5], $5
	load    [$5 + 0], $5
	store   $7, [$5 + 0]
	store   $6, [$5 + 1]
	store   $2, [$5 + 2]
	add     $8, 41, $5
	load    [$1 + $5], $5
	load    [$5 + 0], $5
	store   $7, [$5 + 0]
	store   $2, [$5 + 1]
	store   $4, [$5 + 2]
	add     $8, 81, $5
	load    [$1 + $5], $1
	load    [$1 + 0], $1
	store   $2, [$1 + 0]
	store   $3, [$1 + 1]
	store   $4, [$1 + 2]
	ret
bge_else.31676:
	fmul    $4, $4, $11
.count load_float
	load    [f.27098], $12
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $8, [$sp + 0]
	fadd    $11, $12, $11
.count stack_store
	store   $7, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	fsqrt   $11, $11
.count stack_store
	store   $6, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
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
	bl      bge_else.31677
bge_then.31677:
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
	load    [f.27139], $17
.count move_ret
	mov     $1, $16
.count load_float
	load    [f.27140], $18
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
	load    [$sp + 1], $20
.count load_float
	load    [f.27098], $19
	li      0, $2
	add     $20, 2, $8
	fadd    $16, $19, $5
.count stack_store
	store   $8, [$sp + 4]
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 2], $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_load
	load    [$sp + 0], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31678
bge_then.31678:
.count stack_store
	store   $2, [$sp + 5]
.count stack_load
	load    [$sp + 2], $11
	li      0, $10
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31679
bge_then.31679:
	sub     $11, 5, $11
bge_cont.31679:
.count stack_store
	store   $11, [$sp + 6]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
.count stack_load
	load    [$sp + 3], $6
	fmul    $16, $17, $16
.count move_args
	mov     $20, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $18, $5
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $19, $5
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
	cmp     $2, 0
	bl      bge_else.31680
bge_then.31680:
.count stack_store
	store   $2, [$sp + 7]
.count stack_load
	load    [$sp + 6], $11
	li      0, $10
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31681
bge_then.31681:
	sub     $11, 5, $11
bge_cont.31681:
.count stack_store
	store   $11, [$sp + 8]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
.count stack_load
	load    [$sp + 3], $6
	fmul    $16, $17, $16
.count move_args
	mov     $20, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $18, $5
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $19, $5
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
	cmp     $2, 0
	bl      bge_else.31682
bge_then.31682:
.count stack_store
	store   $2, [$sp + 9]
.count stack_load
	load    [$sp + 8], $11
	li      0, $10
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31683
bge_then.31683:
	sub     $11, 5, $11
bge_cont.31683:
.count stack_store
	store   $11, [$sp + 10]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
.count stack_load
	load    [$sp + 3], $6
	fmul    $16, $17, $16
.count move_args
	mov     $20, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $18, $5
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $16, $19, $5
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
	mov     $20, $5
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
bge_else.31682:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31680:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31678:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31677:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	cmp     $2, 0
	bl      bge_else.31685
bge_then.31685:
.count stack_move
	sub     $sp, 20, $sp
.count load_float
	load    [f.27140], $11
.count stack_store
	store   $4, [$sp + 0]
.count load_float
	load    [f.27139], $12
.count stack_store
	store   $3, [$sp + 1]
	li      0, $10
.count stack_store
	store   $2, [$sp + 2]
.count stack_store
	store   $11, [$sp + 3]
	li      4, $2
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
.count move_args
	mov     $13, $5
	fmul    $16, $12, $16
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
	load    [$sp + 0], $17
.count load_float
	load    [f.27098], $16
	li      0, $2
	add     $17, 2, $8
.count move_args
	mov     $zero, $4
.count stack_store
	store   $8, [$sp + 8]
.count stack_load
	load    [$sp + 5], $18
.count move_args
	mov     $zero, $3
	fadd    $18, $16, $5
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
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31686
bge_then.31686:
	sub     $11, 5, $11
bge_cont.31686:
.count stack_store
	store   $11, [$sp + 10]
	li      3, $2
	call    min_caml_float_of_int
.count stack_load
	load    [$sp + 4], $19
.count move_ret
	mov     $1, $18
.count stack_load
	load    [$sp + 3], $20
	fmul    $18, $19, $18
.count move_args
	mov     $17, $8
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
	fadd    $18, $16, $5
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
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31687
bge_then.31687:
	sub     $11, 5, $11
bge_cont.31687:
.count stack_store
	store   $11, [$sp + 13]
	li      2, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
.count stack_load
	load    [$sp + 7], $6
	fmul    $18, $19, $18
.count move_args
	mov     $17, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $18, $20, $5
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $18, $16, $5
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
	bl      bge_cont.31688
bge_then.31688:
	sub     $21, 5, $21
bge_cont.31688:
	mov     $21, $4
.count stack_load
	load    [$sp + 7], $3
.count move_args
	mov     $17, $5
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31689
bge_then.31689:
.count stack_store
	store   $2, [$sp + 14]
.count stack_load
	load    [$sp + 1], $10
	add     $10, 2, $10
	cmp     $10, 5
	bl      bge_cont.31690
bge_then.31690:
	sub     $10, 5, $10
bge_cont.31690:
.count stack_store
	store   $10, [$sp + 15]
.count stack_load
	load    [$sp + 0], $12
	li      0, $11
	add     $12, 4, $12
.count stack_store
	store   $12, [$sp + 16]
	call    min_caml_float_of_int
.count stack_load
	load    [$sp + 4], $17
.count move_ret
	mov     $1, $16
.count move_args
	mov     $12, $8
	fmul    $16, $17, $16
.count move_args
	mov     $10, $7
.count stack_load
	load    [$sp + 3], $17
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $17, $6
.count move_args
	mov     $11, $2
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
	bl      bge_cont.31691
bge_then.31691:
	sub     $17, 5, $17
bge_cont.31691:
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
	bl      bge_cont.31692
bge_then.31692:
	sub     $21, 5, $21
bge_cont.31692:
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
	bl      calc_dirvec_rows.3033
	sub     $3, 5, $3
	b       calc_dirvec_rows.3033
bge_else.31689:
.count stack_move
	add     $sp, 20, $sp
	ret
bge_else.31685:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	cmp     $3, 0
	bl      bge_else.31694
bge_then.31694:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count move_args
	mov     $zero, $3
	li      3, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
.count stack_store
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 2], $10
	store   $10, [$11 + 0]
.count stack_load
	load    [$sp + 1], $12
	mov     $11, $10
.count stack_load
	load    [$sp + 0], $11
.count storer
	add     $12, $11, $tmp
	store   $10, [$tmp + 0]
	sub     $11, 1, $10
	cmp     $10, 0
	bl      bge_else.31695
bge_then.31695:
	li      3, $2
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
	mov     $hp, $13
.count move_ret
	mov     $1, $11
	store   $11, [$13 + 1]
.count storer
	add     $12, $10, $tmp
.count stack_load
	load    [$sp + 3], $11
	sub     $10, 1, $10
	add     $hp, 2, $hp
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	bl      bge_else.31696
bge_then.31696:
	li      3, $2
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
	mov     $hp, $13
.count move_ret
	mov     $1, $11
	store   $11, [$13 + 1]
.count storer
	add     $12, $10, $tmp
.count stack_load
	load    [$sp + 4], $11
	sub     $10, 1, $10
	add     $hp, 2, $hp
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	bl      bge_else.31697
bge_then.31697:
	li      3, $2
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
	mov     $hp, $2
.count stack_move
	add     $sp, 6, $sp
	store   $1, [$2 + 1]
.count storer
	add     $12, $10, $tmp
.count stack_load
	load    [$sp - 1], $1
	add     $hp, 2, $hp
	sub     $10, 1, $3
	store   $1, [$2 + 0]
	mov     $2, $1
	store   $1, [$tmp + 0]
.count move_args
	mov     $12, $2
	b       create_dirvec_elements.3039
bge_else.31697:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31696:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31695:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31694:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	cmp     $2, 0
	bl      bge_else.31698
bge_then.31698:
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
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	li      120, $2
.count stack_load
	load    [$sp + 1], $10
	add     $hp, 2, $hp
	mov     $11, $3
	store   $10, [$11 + 0]
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
	load    [min_caml_dirvecs + $11], $11
	mov     $hp, $12
.count move_ret
	mov     $1, $10
	store   $10, [$12 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 2], $10
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 118]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 3]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $12
.count move_ret
	mov     $1, $10
	store   $10, [$12 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 3], $10
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 117]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 4]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $15
.count move_ret
	mov     $1, $14
	store   $14, [$15 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 4], $14
	li      115, $3
.count move_args
	mov     $11, $2
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$11 + 116]
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31699
bge_then.31699:
.count stack_store
	store   $10, [$sp + 5]
	li      3, $2
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
	mov     $hp, $12
.count move_ret
	mov     $1, $11
	store   $11, [$12 + 1]
	li      120, $2
.count stack_load
	load    [$sp + 6], $11
	add     $hp, 2, $hp
	mov     $12, $3
	store   $11, [$12 + 0]
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
	load    [min_caml_dirvecs + $10], $10
	mov     $hp, $12
.count move_ret
	mov     $1, $11
	store   $11, [$12 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 7], $11
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $11, [$12 + 0]
	mov     $12, $11
	store   $11, [$10 + 118]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 8]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $15
.count move_ret
	mov     $1, $14
	store   $14, [$15 + 1]
	add     $hp, 2, $hp
.count stack_load
	load    [$sp + 8], $14
	li      116, $3
.count move_args
	mov     $10, $2
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$10 + 117]
	call    create_dirvec_elements.3039
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $1
	sub     $1, 1, $2
	b       create_dirvecs.3042
bge_else.31699:
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.31698:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	cmp     $3, 0
	bl      bge_else.31700
bge_then.31700:
.count stack_move
	sub     $sp, 4, $sp
	sub     $41, 1, $11
.count stack_store
	store   $2, [$sp + 0]
	cmp     $11, 0
.count stack_store
	store   $3, [$sp + 1]
	load    [$2 + $3], $10
	bl      bge_cont.31701
bge_then.31701:
	load    [min_caml_objects + $11], $13
	load    [$10 + 1], $12
	load    [$10 + 0], $14
	load    [$13 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31702
be_then.31702:
	li      6, $2
	call    min_caml_create_array
	load    [$14 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31703
be_then.31703:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31703
be_else.31703:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31704
ble_then.31704:
	li      0, $17
.count b_cont
	b       ble_cont.31704
ble_else.31704:
	li      1, $17
ble_cont.31704:
	cmp     $18, 0
	be      bne_cont.31705
bne_then.31705:
	cmp     $17, 0
	bne     be_else.31706
be_then.31706:
	li      1, $17
.count b_cont
	b       be_cont.31706
be_else.31706:
	li      0, $17
be_cont.31706:
bne_cont.31705:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31707
be_then.31707:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$14 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
.count b_cont
	b       be_cont.31707
be_else.31707:
	store   $18, [$16 + 0]
	load    [$14 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31707:
be_cont.31703:
	load    [$14 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31708
be_then.31708:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31708
be_else.31708:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31709
ble_then.31709:
	li      0, $17
.count b_cont
	b       ble_cont.31709
ble_else.31709:
	li      1, $17
ble_cont.31709:
	cmp     $18, 0
	be      bne_cont.31710
bne_then.31710:
	cmp     $17, 0
	bne     be_else.31711
be_then.31711:
	li      1, $17
.count b_cont
	b       be_cont.31711
be_else.31711:
	li      0, $17
be_cont.31711:
bne_cont.31710:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31712
be_then.31712:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$14 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
.count b_cont
	b       be_cont.31712
be_else.31712:
	store   $18, [$16 + 2]
	load    [$14 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31712:
be_cont.31708:
	load    [$14 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31713
be_then.31713:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31702
be_else.31713:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31714
ble_then.31714:
	li      0, $17
.count b_cont
	b       ble_cont.31714
ble_else.31714:
	li      1, $17
ble_cont.31714:
	cmp     $18, 0
	be      bne_cont.31715
bne_then.31715:
	cmp     $17, 0
	bne     be_else.31716
be_then.31716:
	li      1, $17
.count b_cont
	b       be_cont.31716
be_else.31716:
	li      0, $17
be_cont.31716:
bne_cont.31715:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 2], $18
	bne     be_else.31717
be_then.31717:
	fneg    $18, $17
.count b_cont
	b       be_cont.31717
be_else.31717:
	mov     $18, $17
be_cont.31717:
	store   $17, [$16 + 4]
.count storer
	add     $12, $11, $tmp
	load    [$14 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31702
be_else.31702:
	cmp     $15, 2
	bne     be_else.31718
be_then.31718:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$14 + 0], $20
	load    [$13 + 4], $18
	load    [$17 + 0], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 2], $19
	load    [$14 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$14 + 2], $20
.count storer
	add     $12, $11, $tmp
	fadd    $17, $18, $17
	fmul    $20, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
	bg      ble_else.31719
ble_then.31719:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31718
ble_else.31719:
	finv    $17, $17
	fneg    $17, $18
	store   $18, [$16 + 0]
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 1]
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 2]
	load    [$13 + 4], $18
	load    [$18 + 2], $18
	fmul    $18, $17, $17
	fneg    $17, $17
	store   $17, [$16 + 3]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31718
be_else.31718:
	li      5, $2
	call    min_caml_create_array
	load    [$14 + 0], $21
	load    [$14 + 1], $22
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	fmul    $21, $21, $24
	fmul    $22, $22, $25
	load    [$14 + 2], $23
	load    [$18 + 0], $18
	load    [$19 + 1], $19
	load    [$13 + 4], $20
	fmul    $23, $23, $26
	fmul    $24, $18, $18
	fmul    $25, $19, $19
	load    [$20 + 2], $20
	load    [$13 + 3], $17
.count move_ret
	mov     $1, $16
	fmul    $26, $20, $20
	fadd    $18, $19, $18
	cmp     $17, 0
	fadd    $18, $20, $18
	be      bne_cont.31720
bne_then.31720:
	load    [$13 + 9], $20
	fmul    $22, $23, $19
	load    [$13 + 9], $24
	load    [$20 + 0], $20
	fmul    $23, $21, $23
	fmul    $19, $20, $19
	fmul    $21, $22, $21
	load    [$24 + 1], $20
	load    [$13 + 9], $22
	fadd    $18, $19, $18
	fmul    $23, $20, $20
	load    [$22 + 2], $19
	fmul    $21, $19, $19
	fadd    $18, $20, $18
	fadd    $18, $19, $18
bne_cont.31720:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$14 + 0], $22
	load    [$13 + 4], $20
	load    [$19 + 0], $19
	load    [$13 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$14 + 2], $23
	load    [$14 + 1], $22
	load    [$21 + 2], $21
	cmp     $17, 0
	fmul    $22, $20, $20
	fmul    $23, $21, $21
	fneg    $19, $19
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
	fneg    $20, $20
	fneg    $21, $21
.count move_args
	mov     $10, $2
	bne     be_else.31721
be_then.31721:
	store   $19, [$16 + 1]
	fcmp    $18, $zero
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	bne     be_else.31722
be_then.31722:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31721
be_else.31722:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31721
be_else.31721:
	load    [$13 + 9], $24
	load    [$13 + 9], $17
	fcmp    $18, $zero
	load    [$24 + 2], $24
	load    [$17 + 1], $17
	fmul    $22, $24, $22
	fmul    $23, $17, $23
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$14 + 2], $22
	load    [$13 + 9], $19
	load    [$14 + 0], $23
	load    [$19 + 0], $19
	fmul    $23, $24, $23
	fmul    $22, $19, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$14 + 0], $22
	load    [$14 + 1], $20
	fmul    $22, $17, $17
	fmul    $20, $19, $19
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	bne     be_else.31723
be_then.31723:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31723
be_else.31723:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31723:
be_cont.31721:
be_cont.31718:
be_cont.31702:
bge_cont.31701:
.count stack_load
	load    [$sp + 1], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31724
bge_then.31724:
.count stack_store
	store   $10, [$sp + 2]
.count stack_load
	load    [$sp + 0], $11
	load    [$11 + $10], $10
	sub     $41, 1, $11
	cmp     $11, 0
	bl      bge_cont.31725
bge_then.31725:
	load    [min_caml_objects + $11], $14
	load    [$10 + 1], $12
	load    [$10 + 0], $13
	load    [$14 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31726
be_then.31726:
	li      6, $2
	call    min_caml_create_array
	load    [$13 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31727
be_then.31727:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31727
be_else.31727:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31728
ble_then.31728:
	li      0, $17
.count b_cont
	b       ble_cont.31728
ble_else.31728:
	li      1, $17
ble_cont.31728:
	cmp     $18, 0
	be      bne_cont.31729
bne_then.31729:
	cmp     $17, 0
	bne     be_else.31730
be_then.31730:
	li      1, $17
.count b_cont
	b       be_cont.31730
be_else.31730:
	li      0, $17
be_cont.31730:
bne_cont.31729:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31731
be_then.31731:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$13 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
.count b_cont
	b       be_cont.31731
be_else.31731:
	store   $18, [$16 + 0]
	load    [$13 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31731:
be_cont.31727:
	load    [$13 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31732
be_then.31732:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31732
be_else.31732:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31733
ble_then.31733:
	li      0, $17
.count b_cont
	b       ble_cont.31733
ble_else.31733:
	li      1, $17
ble_cont.31733:
	cmp     $18, 0
	be      bne_cont.31734
bne_then.31734:
	cmp     $17, 0
	bne     be_else.31735
be_then.31735:
	li      1, $17
.count b_cont
	b       be_cont.31735
be_else.31735:
	li      0, $17
be_cont.31735:
bne_cont.31734:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31736
be_then.31736:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$13 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
.count b_cont
	b       be_cont.31736
be_else.31736:
	store   $18, [$16 + 2]
	load    [$13 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31736:
be_cont.31732:
	load    [$13 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31737
be_then.31737:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31726
be_else.31737:
	load    [$14 + 6], $18
	load    [$14 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31738
ble_then.31738:
	li      0, $17
.count b_cont
	b       ble_cont.31738
ble_else.31738:
	li      1, $17
ble_cont.31738:
	cmp     $18, 0
	be      bne_cont.31739
bne_then.31739:
	cmp     $17, 0
	bne     be_else.31740
be_then.31740:
	li      1, $17
.count b_cont
	b       be_cont.31740
be_else.31740:
	li      0, $17
be_cont.31740:
bne_cont.31739:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.31741
be_then.31741:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$13 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31726
be_else.31741:
	store   $18, [$16 + 4]
	load    [$13 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31726
be_else.31726:
	cmp     $15, 2
	bne     be_else.31742
be_then.31742:
	li      4, $2
	call    min_caml_create_array
	load    [$14 + 4], $17
	load    [$13 + 0], $20
	load    [$14 + 4], $18
	load    [$17 + 0], $17
	load    [$14 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 2], $19
	load    [$13 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$13 + 2], $20
.count storer
	add     $12, $11, $tmp
	fadd    $17, $18, $17
	fmul    $20, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
	bg      ble_else.31743
ble_then.31743:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31742
ble_else.31743:
	finv    $17, $17
	fneg    $17, $18
	store   $18, [$16 + 0]
	load    [$14 + 4], $18
	load    [$18 + 0], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 1]
	load    [$14 + 4], $18
	load    [$18 + 1], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 2]
	load    [$14 + 4], $18
	load    [$18 + 2], $18
	fmul    $18, $17, $17
	fneg    $17, $17
	store   $17, [$16 + 3]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31742
be_else.31742:
	li      5, $2
	call    min_caml_create_array
	load    [$13 + 0], $21
	load    [$13 + 1], $22
	load    [$14 + 4], $18
	load    [$14 + 4], $19
	fmul    $21, $21, $24
	fmul    $22, $22, $25
	load    [$13 + 2], $23
	load    [$18 + 0], $18
	load    [$19 + 1], $19
	load    [$14 + 4], $20
	fmul    $23, $23, $26
	fmul    $24, $18, $18
	fmul    $25, $19, $19
	load    [$20 + 2], $20
	load    [$14 + 3], $17
.count move_ret
	mov     $1, $16
	fmul    $26, $20, $20
	fadd    $18, $19, $18
	cmp     $17, 0
	fadd    $18, $20, $18
	be      bne_cont.31744
bne_then.31744:
	load    [$14 + 9], $20
	fmul    $22, $23, $19
	load    [$14 + 9], $24
	load    [$20 + 0], $20
	fmul    $23, $21, $23
	fmul    $19, $20, $19
	fmul    $21, $22, $21
	load    [$24 + 1], $20
	load    [$14 + 9], $22
	fadd    $18, $19, $18
	fmul    $23, $20, $20
	load    [$22 + 2], $19
	fmul    $21, $19, $19
	fadd    $18, $20, $18
	fadd    $18, $19, $18
bne_cont.31744:
	store   $18, [$16 + 0]
	load    [$14 + 4], $19
	load    [$13 + 0], $22
	load    [$14 + 4], $20
	load    [$19 + 0], $19
	load    [$14 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$13 + 2], $23
	load    [$13 + 1], $22
	load    [$21 + 2], $21
	cmp     $17, 0
	fmul    $22, $20, $20
	fmul    $23, $21, $21
	fneg    $19, $19
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
	fneg    $20, $20
	fneg    $21, $21
.count move_args
	mov     $10, $2
	bne     be_else.31745
be_then.31745:
	store   $19, [$16 + 1]
	fcmp    $18, $zero
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	bne     be_else.31746
be_then.31746:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31745
be_else.31746:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31745
be_else.31745:
	load    [$14 + 9], $24
	load    [$14 + 9], $17
	fcmp    $18, $zero
	load    [$24 + 2], $24
	load    [$17 + 1], $17
	fmul    $22, $24, $22
	fmul    $23, $17, $23
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 2], $22
	load    [$14 + 9], $19
	load    [$13 + 0], $23
	load    [$19 + 0], $19
	fmul    $23, $24, $23
	fmul    $22, $19, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$13 + 0], $22
	load    [$13 + 1], $20
	fmul    $22, $17, $17
	fmul    $20, $19, $19
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	bne     be_else.31747
be_then.31747:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31747
be_else.31747:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31747:
be_cont.31745:
be_cont.31742:
be_cont.31726:
bge_cont.31725:
.count stack_load
	load    [$sp + 2], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31748
bge_then.31748:
.count stack_load
	load    [$sp + 0], $17
	sub     $41, 1, $3
	load    [$17 + $16], $2
	call    iter_setup_dirvec_constants.2826
	sub     $16, 1, $10
	cmp     $10, 0
	bl      bge_else.31749
bge_then.31749:
	sub     $41, 1, $11
	cmp     $11, 0
	bl      bge_else.31750
bge_then.31750:
	load    [min_caml_objects + $11], $14
	load    [$17 + $10], $12
.count move_args
	mov     $zero, $3
	load    [$14 + 1], $16
	load    [$12 + 0], $15
	load    [$12 + 1], $13
	cmp     $16, 1
.count stack_store
	store   $10, [$sp + 3]
	bne     be_else.31751
be_then.31751:
	li      6, $2
	call    min_caml_create_array
	load    [$15 + 0], $18
.count move_ret
	mov     $1, $16
	fcmp    $18, $zero
	bne     be_else.31752
be_then.31752:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31752
be_else.31752:
	load    [$14 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31753
ble_then.31753:
	li      0, $18
.count b_cont
	b       ble_cont.31753
ble_else.31753:
	li      1, $18
ble_cont.31753:
	cmp     $19, 0
	be      bne_cont.31754
bne_then.31754:
	cmp     $18, 0
	bne     be_else.31755
be_then.31755:
	li      1, $18
.count b_cont
	b       be_cont.31755
be_else.31755:
	li      0, $18
be_cont.31755:
bne_cont.31754:
	load    [$14 + 4], $19
	cmp     $18, 0
	load    [$19 + 0], $19
	bne     be_else.31756
be_then.31756:
	fneg    $19, $18
	store   $18, [$16 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$16 + 1]
.count b_cont
	b       be_cont.31756
be_else.31756:
	store   $19, [$16 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$16 + 1]
be_cont.31756:
be_cont.31752:
	load    [$15 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31757
be_then.31757:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31757
be_else.31757:
	load    [$14 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31758
ble_then.31758:
	li      0, $18
.count b_cont
	b       ble_cont.31758
ble_else.31758:
	li      1, $18
ble_cont.31758:
	cmp     $19, 0
	be      bne_cont.31759
bne_then.31759:
	cmp     $18, 0
	bne     be_else.31760
be_then.31760:
	li      1, $18
.count b_cont
	b       be_cont.31760
be_else.31760:
	li      0, $18
be_cont.31760:
bne_cont.31759:
	load    [$14 + 4], $19
	cmp     $18, 0
	load    [$19 + 1], $19
	bne     be_else.31761
be_then.31761:
	fneg    $19, $18
	store   $18, [$16 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$16 + 3]
.count b_cont
	b       be_cont.31761
be_else.31761:
	store   $19, [$16 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$16 + 3]
be_cont.31761:
be_cont.31757:
	load    [$15 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31762
be_then.31762:
	store   $zero, [$16 + 5]
.count b_cont
	b       be_cont.31762
be_else.31762:
	load    [$14 + 6], $19
	load    [$14 + 4], $20
	fcmp    $zero, $18
	bg      ble_else.31763
ble_then.31763:
	li      0, $18
.count b_cont
	b       ble_cont.31763
ble_else.31763:
	li      1, $18
ble_cont.31763:
	cmp     $19, 0
	be      bne_cont.31764
bne_then.31764:
	cmp     $18, 0
	bne     be_else.31765
be_then.31765:
	li      1, $18
.count b_cont
	b       be_cont.31765
be_else.31765:
	li      0, $18
be_cont.31765:
bne_cont.31764:
	load    [$20 + 2], $19
	cmp     $18, 0
	bne     be_else.31766
be_then.31766:
	fneg    $19, $18
	store   $18, [$16 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$16 + 5]
.count b_cont
	b       be_cont.31766
be_else.31766:
	store   $19, [$16 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$16 + 5]
be_cont.31766:
be_cont.31762:
.count storer
	add     $13, $11, $tmp
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $17, $2
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
be_else.31751:
	cmp     $16, 2
	bne     be_else.31767
be_then.31767:
	li      4, $2
	call    min_caml_create_array
	load    [$14 + 4], $18
	load    [$15 + 0], $21
	load    [$14 + 4], $19
	load    [$18 + 0], $18
	load    [$14 + 4], $20
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$20 + 2], $20
	load    [$15 + 1], $21
.count move_ret
	mov     $1, $16
.count storer
	add     $13, $11, $tmp
	fmul    $21, $19, $19
	load    [$15 + 2], $21
	fadd    $18, $19, $18
	fmul    $21, $20, $19
	fadd    $18, $19, $18
	fcmp    $18, $zero
	bg      ble_else.31768
ble_then.31768:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
.count b_cont
	b       be_cont.31767
ble_else.31768:
	finv    $18, $18
	fneg    $18, $19
	store   $19, [$16 + 0]
	load    [$14 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$16 + 1]
	load    [$14 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $18, $19
	fneg    $19, $19
	store   $19, [$16 + 2]
	load    [$14 + 4], $19
	load    [$19 + 2], $19
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$16 + 3]
	store   $16, [$tmp + 0]
.count b_cont
	b       be_cont.31767
be_else.31767:
	li      5, $2
	call    min_caml_create_array
	load    [$15 + 0], $22
	load    [$15 + 1], $23
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$15 + 2], $24
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	load    [$14 + 4], $21
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	load    [$14 + 3], $18
.count move_ret
	mov     $1, $16
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	cmp     $18, 0
	fadd    $19, $21, $19
	be      bne_cont.31769
bne_then.31769:
	load    [$14 + 9], $21
	fmul    $23, $24, $20
	load    [$14 + 9], $25
	load    [$21 + 0], $21
	fmul    $24, $22, $24
	fmul    $20, $21, $20
	fmul    $22, $23, $22
	load    [$25 + 1], $21
	load    [$14 + 9], $23
	fadd    $19, $20, $19
	fmul    $24, $21, $21
	load    [$23 + 2], $20
	fmul    $22, $20, $20
	fadd    $19, $21, $19
	fadd    $19, $20, $19
bne_cont.31769:
	store   $19, [$16 + 0]
	load    [$14 + 4], $20
	load    [$15 + 0], $23
	load    [$14 + 4], $21
	load    [$20 + 0], $20
	load    [$14 + 4], $22
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$15 + 2], $24
	load    [$15 + 1], $23
	load    [$22 + 2], $22
	cmp     $18, 0
	fmul    $23, $21, $21
	fmul    $24, $22, $22
	fneg    $20, $20
.count storer
	add     $13, $11, $tmp
	fneg    $21, $21
	fneg    $22, $22
	bne     be_else.31770
be_then.31770:
	store   $20, [$16 + 1]
	fcmp    $19, $zero
	store   $21, [$16 + 2]
	store   $22, [$16 + 3]
	bne     be_else.31771
be_then.31771:
	store   $16, [$tmp + 0]
.count b_cont
	b       be_cont.31770
be_else.31771:
	finv    $19, $18
	store   $18, [$16 + 4]
	store   $16, [$tmp + 0]
.count b_cont
	b       be_cont.31770
be_else.31770:
	load    [$14 + 9], $25
	load    [$14 + 9], $18
	fcmp    $19, $zero
	load    [$25 + 2], $25
	load    [$18 + 1], $18
	fmul    $23, $25, $23
	fmul    $24, $18, $24
	fadd    $24, $23, $23
	fmul    $23, $39, $23
	fsub    $20, $23, $20
	store   $20, [$16 + 1]
	load    [$15 + 2], $23
	load    [$14 + 9], $20
	load    [$15 + 0], $24
	load    [$20 + 0], $20
	fmul    $24, $25, $24
	fmul    $23, $20, $23
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $21, $23, $21
	store   $21, [$16 + 2]
	load    [$15 + 0], $23
	load    [$15 + 1], $21
	fmul    $23, $18, $18
	fmul    $21, $20, $20
	fadd    $20, $18, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$16 + 3]
	bne     be_else.31772
be_then.31772:
	store   $16, [$tmp + 0]
.count b_cont
	b       be_cont.31772
be_else.31772:
	finv    $19, $18
	store   $18, [$16 + 4]
	store   $16, [$tmp + 0]
be_cont.31772:
be_cont.31770:
be_cont.31767:
	sub     $11, 1, $3
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $17, $2
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
bge_else.31750:
.count stack_move
	add     $sp, 4, $sp
	sub     $10, 1, $3
.count move_args
	mov     $17, $2
	b       init_dirvec_constants.3044
bge_else.31749:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31748:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31724:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31700:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	cmp     $2, 0
	bl      bge_else.31773
bge_then.31773:
.count stack_move
	sub     $sp, 5, $sp
	sub     $41, 1, $10
.count stack_store
	store   $2, [$sp + 0]
	load    [min_caml_dirvecs + $2], $11
	cmp     $10, 0
.count stack_store
	store   $11, [$sp + 1]
	load    [$11 + 119], $11
	bl      bge_cont.31774
bge_then.31774:
	load    [min_caml_objects + $10], $14
	load    [$11 + 1], $12
	load    [$11 + 0], $13
	load    [$14 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31775
be_then.31775:
	li      6, $2
	call    min_caml_create_array
	load    [$13 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31776
be_then.31776:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31776
be_else.31776:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31777
ble_then.31777:
	li      0, $17
.count b_cont
	b       ble_cont.31777
ble_else.31777:
	li      1, $17
ble_cont.31777:
	cmp     $18, 0
	be      bne_cont.31778
bne_then.31778:
	cmp     $17, 0
	bne     be_else.31779
be_then.31779:
	li      1, $17
.count b_cont
	b       be_cont.31779
be_else.31779:
	li      0, $17
be_cont.31779:
bne_cont.31778:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31780
be_then.31780:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$13 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
.count b_cont
	b       be_cont.31780
be_else.31780:
	store   $18, [$16 + 0]
	load    [$13 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31780:
be_cont.31776:
	load    [$13 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31781
be_then.31781:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31781
be_else.31781:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31782
ble_then.31782:
	li      0, $17
.count b_cont
	b       ble_cont.31782
ble_else.31782:
	li      1, $17
ble_cont.31782:
	cmp     $18, 0
	be      bne_cont.31783
bne_then.31783:
	cmp     $17, 0
	bne     be_else.31784
be_then.31784:
	li      1, $17
.count b_cont
	b       be_cont.31784
be_else.31784:
	li      0, $17
be_cont.31784:
bne_cont.31783:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31785
be_then.31785:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$13 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
.count b_cont
	b       be_cont.31785
be_else.31785:
	store   $18, [$16 + 2]
	load    [$13 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31785:
be_cont.31781:
	load    [$13 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31786
be_then.31786:
.count storer
	add     $12, $10, $tmp
	store   $zero, [$16 + 5]
	sub     $10, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31775
be_else.31786:
	load    [$14 + 6], $18
	load    [$14 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31787
ble_then.31787:
	li      0, $17
.count b_cont
	b       ble_cont.31787
ble_else.31787:
	li      1, $17
ble_cont.31787:
	cmp     $18, 0
	be      bne_cont.31788
bne_then.31788:
	cmp     $17, 0
	bne     be_else.31789
be_then.31789:
	li      1, $17
.count b_cont
	b       be_cont.31789
be_else.31789:
	li      0, $17
be_cont.31789:
bne_cont.31788:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31790
be_then.31790:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$13 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31775
be_else.31790:
	store   $18, [$16 + 4]
	load    [$13 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31775
be_else.31775:
	cmp     $15, 2
	bne     be_else.31791
be_then.31791:
	li      4, $2
	call    min_caml_create_array
	load    [$14 + 4], $17
	load    [$13 + 0], $20
	load    [$14 + 4], $18
	load    [$17 + 0], $17
	load    [$14 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 2], $19
	load    [$13 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $11, $2
	fmul    $20, $18, $18
	sub     $10, 1, $3
	load    [$13 + 2], $20
.count storer
	add     $12, $10, $tmp
	fadd    $17, $18, $17
	fmul    $20, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
	bg      ble_else.31792
ble_then.31792:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31791
ble_else.31792:
	finv    $17, $17
	fneg    $17, $18
	store   $18, [$16 + 0]
	load    [$14 + 4], $18
	load    [$18 + 0], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 1]
	load    [$14 + 4], $18
	load    [$18 + 1], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 2]
	load    [$14 + 4], $18
	load    [$18 + 2], $18
	fmul    $18, $17, $17
	fneg    $17, $17
	store   $17, [$16 + 3]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31791
be_else.31791:
	li      5, $2
	call    min_caml_create_array
	load    [$13 + 0], $21
	load    [$13 + 1], $22
	load    [$14 + 4], $18
	load    [$14 + 4], $19
	fmul    $21, $21, $24
	fmul    $22, $22, $25
	load    [$13 + 2], $23
	load    [$18 + 0], $18
	load    [$19 + 1], $19
	load    [$14 + 4], $20
	fmul    $23, $23, $26
	fmul    $24, $18, $18
	fmul    $25, $19, $19
	load    [$20 + 2], $20
	load    [$14 + 3], $17
.count move_ret
	mov     $1, $16
	fmul    $26, $20, $20
	fadd    $18, $19, $18
	cmp     $17, 0
	fadd    $18, $20, $18
	be      bne_cont.31793
bne_then.31793:
	load    [$14 + 9], $20
	fmul    $22, $23, $19
	load    [$14 + 9], $24
	load    [$20 + 0], $20
	fmul    $23, $21, $23
	fmul    $19, $20, $19
	fmul    $21, $22, $21
	load    [$24 + 1], $20
	load    [$14 + 9], $22
	fadd    $18, $19, $18
	fmul    $23, $20, $20
	load    [$22 + 2], $19
	fmul    $21, $19, $19
	fadd    $18, $20, $18
	fadd    $18, $19, $18
bne_cont.31793:
	store   $18, [$16 + 0]
	load    [$14 + 4], $19
	load    [$13 + 0], $22
	load    [$14 + 4], $20
	load    [$19 + 0], $19
	load    [$14 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$13 + 2], $23
	load    [$13 + 1], $22
	load    [$21 + 2], $21
	cmp     $17, 0
	fmul    $22, $20, $20
	fmul    $23, $21, $21
	fneg    $19, $19
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
	fneg    $20, $20
	fneg    $21, $21
.count move_args
	mov     $11, $2
	bne     be_else.31794
be_then.31794:
	store   $19, [$16 + 1]
	fcmp    $18, $zero
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	bne     be_else.31795
be_then.31795:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31794
be_else.31795:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31794
be_else.31794:
	load    [$14 + 9], $24
	load    [$14 + 9], $17
	fcmp    $18, $zero
	load    [$24 + 2], $24
	load    [$17 + 1], $17
	fmul    $22, $24, $22
	fmul    $23, $17, $23
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 2], $22
	load    [$14 + 9], $19
	load    [$13 + 0], $23
	load    [$19 + 0], $19
	fmul    $23, $24, $23
	fmul    $22, $19, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$13 + 0], $22
	load    [$13 + 1], $20
	fmul    $22, $17, $17
	fmul    $20, $19, $19
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	bne     be_else.31796
be_then.31796:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31796
be_else.31796:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31796:
be_cont.31794:
be_cont.31791:
be_cont.31775:
bge_cont.31774:
.count stack_load
	load    [$sp + 1], $16
	sub     $41, 1, $3
	load    [$16 + 118], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $10
	load    [$16 + 117], $11
	cmp     $10, 0
	bl      bge_cont.31797
bge_then.31797:
	load    [min_caml_objects + $10], $13
	load    [$11 + 1], $12
	load    [$11 + 0], $14
	load    [$13 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31798
be_then.31798:
	li      6, $2
	call    min_caml_create_array
	load    [$14 + 0], $18
.count move_ret
	mov     $1, $17
	fcmp    $18, $zero
	bne     be_else.31799
be_then.31799:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.31799
be_else.31799:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31800
ble_then.31800:
	li      0, $18
.count b_cont
	b       ble_cont.31800
ble_else.31800:
	li      1, $18
ble_cont.31800:
	cmp     $19, 0
	be      bne_cont.31801
bne_then.31801:
	cmp     $18, 0
	bne     be_else.31802
be_then.31802:
	li      1, $18
.count b_cont
	b       be_cont.31802
be_else.31802:
	li      0, $18
be_cont.31802:
bne_cont.31801:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 0], $19
	bne     be_else.31803
be_then.31803:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.31803
be_else.31803:
	store   $19, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31803:
be_cont.31799:
	load    [$14 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31804
be_then.31804:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.31804
be_else.31804:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31805
ble_then.31805:
	li      0, $18
.count b_cont
	b       ble_cont.31805
ble_else.31805:
	li      1, $18
ble_cont.31805:
	cmp     $19, 0
	be      bne_cont.31806
bne_then.31806:
	cmp     $18, 0
	bne     be_else.31807
be_then.31807:
	li      1, $18
.count b_cont
	b       be_cont.31807
be_else.31807:
	li      0, $18
be_cont.31807:
bne_cont.31806:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 1], $19
	bne     be_else.31808
be_then.31808:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.31808
be_else.31808:
	store   $19, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31808:
be_cont.31804:
	load    [$14 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31809
be_then.31809:
.count storer
	add     $12, $10, $tmp
	store   $zero, [$17 + 5]
	sub     $10, 1, $3
	store   $17, [$tmp + 0]
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31798
be_else.31809:
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $zero, $18
	bg      ble_else.31810
ble_then.31810:
	li      0, $18
.count b_cont
	b       ble_cont.31810
ble_else.31810:
	li      1, $18
ble_cont.31810:
	cmp     $19, 0
	be      bne_cont.31811
bne_then.31811:
	cmp     $18, 0
	bne     be_else.31812
be_then.31812:
	li      1, $18
.count b_cont
	b       be_cont.31812
be_else.31812:
	li      0, $18
be_cont.31812:
bne_cont.31811:
	load    [$20 + 2], $19
	cmp     $18, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31813
be_then.31813:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$14 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31798
be_else.31813:
	store   $19, [$17 + 4]
	load    [$14 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31798
be_else.31798:
	cmp     $15, 2
	bne     be_else.31814
be_then.31814:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $18
	load    [$14 + 0], $21
	load    [$13 + 4], $19
	load    [$18 + 0], $18
	load    [$13 + 4], $20
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$20 + 2], $20
	load    [$14 + 1], $21
.count move_ret
	mov     $1, $17
.count move_args
	mov     $11, $2
	fmul    $21, $19, $19
	sub     $10, 1, $3
	load    [$14 + 2], $21
.count storer
	add     $12, $10, $tmp
	fadd    $18, $19, $18
	fmul    $21, $20, $19
	fadd    $18, $19, $18
	fcmp    $18, $zero
	bg      ble_else.31815
ble_then.31815:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31814
ble_else.31815:
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
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31814
be_else.31814:
	li      5, $2
	call    min_caml_create_array
	load    [$14 + 0], $22
	load    [$14 + 1], $23
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$14 + 2], $24
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	load    [$13 + 4], $21
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	load    [$13 + 3], $18
.count move_ret
	mov     $1, $17
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	cmp     $18, 0
	fadd    $19, $21, $19
	be      bne_cont.31816
bne_then.31816:
	load    [$13 + 9], $21
	fmul    $23, $24, $20
	load    [$13 + 9], $25
	load    [$21 + 0], $21
	fmul    $24, $22, $24
	fmul    $20, $21, $20
	fmul    $22, $23, $22
	load    [$25 + 1], $21
	load    [$13 + 9], $23
	fadd    $19, $20, $19
	fmul    $24, $21, $21
	load    [$23 + 2], $20
	fmul    $22, $20, $20
	fadd    $19, $21, $19
	fadd    $19, $20, $19
bne_cont.31816:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$14 + 0], $23
	load    [$13 + 4], $21
	load    [$20 + 0], $20
	load    [$13 + 4], $22
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$14 + 2], $24
	load    [$14 + 1], $23
	load    [$22 + 2], $22
	cmp     $18, 0
	fmul    $23, $21, $21
	fmul    $24, $22, $22
	fneg    $20, $20
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
	fneg    $21, $21
	fneg    $22, $22
.count move_args
	mov     $11, $2
	bne     be_else.31817
be_then.31817:
	store   $20, [$17 + 1]
	fcmp    $19, $zero
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	bne     be_else.31818
be_then.31818:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31817
be_else.31818:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31817
be_else.31817:
	load    [$13 + 9], $25
	load    [$13 + 9], $18
	fcmp    $19, $zero
	load    [$25 + 2], $25
	load    [$18 + 1], $18
	fmul    $23, $25, $23
	fmul    $24, $18, $24
	fadd    $24, $23, $23
	fmul    $23, $39, $23
	fsub    $20, $23, $20
	store   $20, [$17 + 1]
	load    [$14 + 2], $23
	load    [$13 + 9], $20
	load    [$14 + 0], $24
	load    [$20 + 0], $20
	fmul    $24, $25, $24
	fmul    $23, $20, $23
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $21, $23, $21
	store   $21, [$17 + 2]
	load    [$14 + 0], $23
	load    [$14 + 1], $21
	fmul    $23, $18, $18
	fmul    $21, $20, $20
	fadd    $20, $18, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.31819
be_then.31819:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31819
be_else.31819:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31819:
be_cont.31817:
be_cont.31814:
be_cont.31798:
bge_cont.31797:
	li      116, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31820
bge_then.31820:
.count stack_store
	store   $16, [$sp + 2]
	sub     $41, 1, $3
	load    [min_caml_dirvecs + $16], $16
	load    [$16 + 119], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $10
	load    [$16 + 118], $11
	cmp     $10, 0
	bl      bge_cont.31821
bge_then.31821:
	load    [min_caml_objects + $10], $13
	load    [$11 + 1], $12
	load    [$11 + 0], $14
	load    [$13 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31822
be_then.31822:
	li      6, $2
	call    min_caml_create_array
	load    [$14 + 0], $18
.count move_ret
	mov     $1, $17
	fcmp    $18, $zero
	bne     be_else.31823
be_then.31823:
	store   $zero, [$17 + 1]
.count b_cont
	b       be_cont.31823
be_else.31823:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31824
ble_then.31824:
	li      0, $18
.count b_cont
	b       ble_cont.31824
ble_else.31824:
	li      1, $18
ble_cont.31824:
	cmp     $19, 0
	be      bne_cont.31825
bne_then.31825:
	cmp     $18, 0
	bne     be_else.31826
be_then.31826:
	li      1, $18
.count b_cont
	b       be_cont.31826
be_else.31826:
	li      0, $18
be_cont.31826:
bne_cont.31825:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 0], $19
	bne     be_else.31827
be_then.31827:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
.count b_cont
	b       be_cont.31827
be_else.31827:
	store   $19, [$17 + 0]
	load    [$14 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31827:
be_cont.31823:
	load    [$14 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31828
be_then.31828:
	store   $zero, [$17 + 3]
.count b_cont
	b       be_cont.31828
be_else.31828:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31829
ble_then.31829:
	li      0, $18
.count b_cont
	b       ble_cont.31829
ble_else.31829:
	li      1, $18
ble_cont.31829:
	cmp     $19, 0
	be      bne_cont.31830
bne_then.31830:
	cmp     $18, 0
	bne     be_else.31831
be_then.31831:
	li      1, $18
.count b_cont
	b       be_cont.31831
be_else.31831:
	li      0, $18
be_cont.31831:
bne_cont.31830:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 1], $19
	bne     be_else.31832
be_then.31832:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
.count b_cont
	b       be_cont.31832
be_else.31832:
	store   $19, [$17 + 2]
	load    [$14 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31832:
be_cont.31828:
	load    [$14 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31833
be_then.31833:
.count storer
	add     $12, $10, $tmp
	store   $zero, [$17 + 5]
	sub     $10, 1, $3
	store   $17, [$tmp + 0]
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31822
be_else.31833:
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $zero, $18
	bg      ble_else.31834
ble_then.31834:
	li      0, $18
.count b_cont
	b       ble_cont.31834
ble_else.31834:
	li      1, $18
ble_cont.31834:
	cmp     $19, 0
	be      bne_cont.31835
bne_then.31835:
	cmp     $18, 0
	bne     be_else.31836
be_then.31836:
	li      1, $18
.count b_cont
	b       be_cont.31836
be_else.31836:
	li      0, $18
be_cont.31836:
bne_cont.31835:
	load    [$20 + 2], $19
	cmp     $18, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31837
be_then.31837:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$14 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31822
be_else.31837:
	store   $19, [$17 + 4]
	load    [$14 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31822
be_else.31822:
	cmp     $15, 2
	bne     be_else.31838
be_then.31838:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $18
	load    [$14 + 0], $21
	load    [$13 + 4], $19
	load    [$18 + 0], $18
	load    [$13 + 4], $20
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$20 + 2], $20
	load    [$14 + 1], $21
.count move_ret
	mov     $1, $17
.count move_args
	mov     $11, $2
	fmul    $21, $19, $19
	sub     $10, 1, $3
	load    [$14 + 2], $21
.count storer
	add     $12, $10, $tmp
	fadd    $18, $19, $18
	fmul    $21, $20, $19
	fadd    $18, $19, $18
	fcmp    $18, $zero
	bg      ble_else.31839
ble_then.31839:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31838
ble_else.31839:
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
	fmul    $19, $18, $18
	fneg    $18, $18
	store   $18, [$17 + 3]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31838
be_else.31838:
	li      5, $2
	call    min_caml_create_array
	load    [$14 + 0], $22
	load    [$14 + 1], $23
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	fmul    $22, $22, $25
	fmul    $23, $23, $26
	load    [$14 + 2], $24
	load    [$19 + 0], $19
	load    [$20 + 1], $20
	load    [$13 + 4], $21
	fmul    $24, $24, $27
	fmul    $25, $19, $19
	fmul    $26, $20, $20
	load    [$21 + 2], $21
	load    [$13 + 3], $18
.count move_ret
	mov     $1, $17
	fmul    $27, $21, $21
	fadd    $19, $20, $19
	cmp     $18, 0
	fadd    $19, $21, $19
	be      bne_cont.31840
bne_then.31840:
	load    [$13 + 9], $21
	fmul    $23, $24, $20
	load    [$13 + 9], $25
	load    [$21 + 0], $21
	fmul    $24, $22, $24
	fmul    $20, $21, $20
	fmul    $22, $23, $22
	load    [$25 + 1], $21
	load    [$13 + 9], $23
	fadd    $19, $20, $19
	fmul    $24, $21, $21
	load    [$23 + 2], $20
	fmul    $22, $20, $20
	fadd    $19, $21, $19
	fadd    $19, $20, $19
bne_cont.31840:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$14 + 0], $23
	load    [$13 + 4], $21
	load    [$20 + 0], $20
	load    [$13 + 4], $22
	load    [$21 + 1], $21
	fmul    $23, $20, $20
	load    [$14 + 2], $24
	load    [$14 + 1], $23
	load    [$22 + 2], $22
	cmp     $18, 0
	fmul    $23, $21, $21
	fmul    $24, $22, $22
	fneg    $20, $20
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
	fneg    $21, $21
	fneg    $22, $22
.count move_args
	mov     $11, $2
	bne     be_else.31841
be_then.31841:
	store   $20, [$17 + 1]
	fcmp    $19, $zero
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	bne     be_else.31842
be_then.31842:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31841
be_else.31842:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31841
be_else.31841:
	load    [$13 + 9], $25
	load    [$13 + 9], $18
	fcmp    $19, $zero
	load    [$25 + 2], $25
	load    [$18 + 1], $18
	fmul    $23, $25, $23
	fmul    $24, $18, $24
	fadd    $24, $23, $23
	fmul    $23, $39, $23
	fsub    $20, $23, $20
	store   $20, [$17 + 1]
	load    [$14 + 2], $23
	load    [$13 + 9], $20
	load    [$14 + 0], $24
	load    [$20 + 0], $20
	fmul    $24, $25, $24
	fmul    $23, $20, $23
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $21, $23, $21
	store   $21, [$17 + 2]
	load    [$14 + 0], $23
	load    [$14 + 1], $21
	fmul    $23, $18, $18
	fmul    $21, $20, $20
	fadd    $20, $18, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	bne     be_else.31843
be_then.31843:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31843
be_else.31843:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31843:
be_cont.31841:
be_cont.31838:
be_cont.31822:
bge_cont.31821:
	li      117, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31844
bge_then.31844:
.count stack_store
	store   $10, [$sp + 3]
	sub     $41, 1, $11
	load    [min_caml_dirvecs + $10], $10
	cmp     $11, 0
.count stack_store
	store   $10, [$sp + 4]
	load    [$10 + 119], $10
	bl      bge_cont.31845
bge_then.31845:
	load    [min_caml_objects + $11], $13
	load    [$10 + 1], $12
	load    [$10 + 0], $14
	load    [$13 + 1], $15
.count move_args
	mov     $zero, $3
	cmp     $15, 1
	bne     be_else.31846
be_then.31846:
	li      6, $2
	call    min_caml_create_array
	load    [$14 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31847
be_then.31847:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31847
be_else.31847:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31848
ble_then.31848:
	li      0, $17
.count b_cont
	b       ble_cont.31848
ble_else.31848:
	li      1, $17
ble_cont.31848:
	cmp     $18, 0
	be      bne_cont.31849
bne_then.31849:
	cmp     $17, 0
	bne     be_else.31850
be_then.31850:
	li      1, $17
.count b_cont
	b       be_cont.31850
be_else.31850:
	li      0, $17
be_cont.31850:
bne_cont.31849:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31851
be_then.31851:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$14 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
.count b_cont
	b       be_cont.31851
be_else.31851:
	store   $18, [$16 + 0]
	load    [$14 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31851:
be_cont.31847:
	load    [$14 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31852
be_then.31852:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31852
be_else.31852:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31853
ble_then.31853:
	li      0, $17
.count b_cont
	b       ble_cont.31853
ble_else.31853:
	li      1, $17
ble_cont.31853:
	cmp     $18, 0
	be      bne_cont.31854
bne_then.31854:
	cmp     $17, 0
	bne     be_else.31855
be_then.31855:
	li      1, $17
.count b_cont
	b       be_cont.31855
be_else.31855:
	li      0, $17
be_cont.31855:
bne_cont.31854:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31856
be_then.31856:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$14 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
.count b_cont
	b       be_cont.31856
be_else.31856:
	store   $18, [$16 + 2]
	load    [$14 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31856:
be_cont.31852:
	load    [$14 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31857
be_then.31857:
.count storer
	add     $12, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31846
be_else.31857:
	load    [$13 + 6], $18
	load    [$13 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31858
ble_then.31858:
	li      0, $17
.count b_cont
	b       ble_cont.31858
ble_else.31858:
	li      1, $17
ble_cont.31858:
	cmp     $18, 0
	be      bne_cont.31859
bne_then.31859:
	cmp     $17, 0
	bne     be_else.31860
be_then.31860:
	li      1, $17
.count b_cont
	b       be_cont.31860
be_else.31860:
	li      0, $17
be_cont.31860:
bne_cont.31859:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.31861
be_then.31861:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$14 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31846
be_else.31861:
	store   $18, [$16 + 4]
	load    [$14 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31846
be_else.31846:
	cmp     $15, 2
	bne     be_else.31862
be_then.31862:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$14 + 0], $20
	load    [$13 + 4], $18
	load    [$17 + 0], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 2], $19
	load    [$14 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$14 + 2], $20
.count storer
	add     $12, $11, $tmp
	fadd    $17, $18, $17
	fmul    $20, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
	bg      ble_else.31863
ble_then.31863:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31862
ble_else.31863:
	finv    $17, $17
	fneg    $17, $18
	store   $18, [$16 + 0]
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 1]
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 2]
	load    [$13 + 4], $18
	load    [$18 + 2], $18
	fmul    $18, $17, $17
	fneg    $17, $17
	store   $17, [$16 + 3]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31862
be_else.31862:
	li      5, $2
	call    min_caml_create_array
	load    [$14 + 0], $21
	load    [$14 + 1], $22
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	fmul    $21, $21, $24
	fmul    $22, $22, $25
	load    [$14 + 2], $23
	load    [$18 + 0], $18
	load    [$19 + 1], $19
	load    [$13 + 4], $20
	fmul    $23, $23, $26
	fmul    $24, $18, $18
	fmul    $25, $19, $19
	load    [$20 + 2], $20
	load    [$13 + 3], $17
.count move_ret
	mov     $1, $16
	fmul    $26, $20, $20
	fadd    $18, $19, $18
	cmp     $17, 0
	fadd    $18, $20, $18
	be      bne_cont.31864
bne_then.31864:
	load    [$13 + 9], $20
	fmul    $22, $23, $19
	load    [$13 + 9], $24
	load    [$20 + 0], $20
	fmul    $23, $21, $23
	fmul    $19, $20, $19
	fmul    $21, $22, $21
	load    [$24 + 1], $20
	load    [$13 + 9], $22
	fadd    $18, $19, $18
	fmul    $23, $20, $20
	load    [$22 + 2], $19
	fmul    $21, $19, $19
	fadd    $18, $20, $18
	fadd    $18, $19, $18
bne_cont.31864:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$14 + 0], $22
	load    [$13 + 4], $20
	load    [$19 + 0], $19
	load    [$13 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$14 + 2], $23
	load    [$14 + 1], $22
	load    [$21 + 2], $21
	cmp     $17, 0
	fmul    $22, $20, $20
	fmul    $23, $21, $21
	fneg    $19, $19
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
	fneg    $20, $20
	fneg    $21, $21
.count move_args
	mov     $10, $2
	bne     be_else.31865
be_then.31865:
	store   $19, [$16 + 1]
	fcmp    $18, $zero
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	bne     be_else.31866
be_then.31866:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31865
be_else.31866:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31865
be_else.31865:
	load    [$13 + 9], $24
	load    [$13 + 9], $17
	fcmp    $18, $zero
	load    [$24 + 2], $24
	load    [$17 + 1], $17
	fmul    $22, $24, $22
	fmul    $23, $17, $23
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$14 + 2], $22
	load    [$13 + 9], $19
	load    [$14 + 0], $23
	load    [$19 + 0], $19
	fmul    $23, $24, $23
	fmul    $22, $19, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$14 + 0], $22
	load    [$14 + 1], $20
	fmul    $22, $17, $17
	fmul    $20, $19, $19
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	bne     be_else.31867
be_then.31867:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31867
be_else.31867:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31867:
be_cont.31865:
be_cont.31862:
be_cont.31846:
bge_cont.31845:
	li      118, $3
.count stack_load
	load    [$sp + 4], $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $28
	sub     $28, 1, $28
	cmp     $28, 0
	bl      bge_else.31868
bge_then.31868:
	li      119, $3
	load    [min_caml_dirvecs + $28], $2
	call    init_dirvec_constants.3044
.count stack_move
	add     $sp, 5, $sp
	sub     $28, 1, $2
	b       init_vecset_constants.3047
bge_else.31868:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31844:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31820:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31773:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3064:
	cmp     $2, 0
	bl      bge_else.31869
bge_then.31869:
	load    [min_caml_objects + $2], $10
	load    [$10 + 2], $11
	cmp     $11, 2
	bne     be_else.31870
be_then.31870:
	load    [$10 + 7], $11
	load    [$11 + 0], $11
	fcmp    $36, $11
	bg      ble_else.31871
ble_then.31871:
	ret
ble_else.31871:
	load    [$10 + 1], $12
	cmp     $12, 1
	bne     be_else.31872
be_then.31872:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
.count stack_store
	store   $2, [$sp + 0]
	load    [$10 + 7], $10
	li      3, $2
.count stack_store
	store   $10, [$sp + 1]
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
	load    [$sp + 2], $17
	fneg    $56, $18
	fneg    $57, $19
	store   $55, [$17 + 0]
	mov     $hp, $20
	store   $18, [$17 + 1]
.count move_ret
	mov     $1, $16
	store   $19, [$17 + 2]
	mov     $20, $2
	store   $16, [$20 + 1]
	add     $hp, 2, $hp
	store   $17, [$20 + 0]
	sub     $41, 1, $3
.count stack_store
	store   $2, [$sp + 3]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $10
	mov     $hp, $12
	li      3, $2
	sll     $10, 2, $10
	add     $hp, 3, $hp
.count stack_store
	store   $10, [$sp + 4]
.count stack_load
	load    [$sp + 1], $11
	add     $10, 1, $10
.count move_args
	mov     $zero, $3
	load    [$11 + 0], $11
	fsub    $36, $11, $11
.count stack_store
	store   $11, [$sp + 5]
	store   $11, [$12 + 2]
.count stack_load
	load    [$sp + 3], $11
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
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
	load    [$sp + 7], $20
	fneg    $55, $17
.count move_ret
	mov     $1, $16
	store   $17, [$20 + 0]
	sub     $41, 1, $3
	store   $56, [$20 + 1]
	store   $19, [$20 + 2]
	mov     $hp, $19
	store   $16, [$19 + 1]
	mov     $19, $2
	store   $20, [$19 + 0]
	add     $hp, 2, $hp
.count stack_store
	store   $2, [$sp + 8]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 5], $13
.count stack_load
	load    [$sp + 4], $11
.count stack_load
	load    [$sp + 6], $10
	mov     $hp, $12
	store   $13, [$12 + 2]
	add     $11, 2, $11
.count stack_load
	load    [$sp + 8], $13
	add     $10, 1, $10
	add     $hp, 3, $hp
	store   $13, [$12 + 1]
	li      3, $2
	store   $11, [$12 + 0]
.count move_args
	mov     $zero, $3
	mov     $12, $11
	store   $11, [min_caml_reflections + $10]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
.count stack_store
	store   $3, [$sp + 9]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count stack_load
	load    [$sp + 9], $19
.count move_ret
	mov     $1, $16
	sub     $41, 1, $3
	store   $17, [$19 + 0]
	store   $18, [$19 + 1]
	mov     $hp, $17
	store   $57, [$19 + 2]
	mov     $17, $2
	store   $16, [$17 + 1]
	add     $hp, 2, $hp
	store   $19, [$17 + 0]
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
	add     $hp, 3, $hp
	store   $5, [$4 + 2]
	add     $3, 3, $3
.count stack_load
	load    [$sp - 4], $5
	add     $1, 2, $2
	store   $5, [$4 + 1]
	add     $1, 3, $1
	store   $3, [$4 + 0]
	mov     $4, $3
	store   $3, [min_caml_reflections + $2]
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.31872:
	cmp     $12, 2
	bne     be_else.31873
be_then.31873:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
.count stack_store
	store   $11, [$sp + 11]
.count stack_store
	store   $2, [$sp + 0]
	load    [$10 + 4], $11
	li      3, $2
	load    [$10 + 4], $10
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	mov     $12, $3
.count stack_store
	store   $3, [$sp + 12]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count load_float
	load    [f.27083], $17
	load    [$11 + 0], $18
	load    [$10 + 1], $20
	load    [$10 + 2], $22
	fmul    $17, $18, $19
	fmul    $56, $20, $21
	fmul    $55, $18, $18
.count move_ret
	mov     $1, $16
	sub     $41, 1, $3
	fadd    $18, $21, $18
	fmul    $57, $22, $21
	fadd    $18, $21, $18
.count stack_load
	load    [$sp + 12], $21
	fmul    $19, $18, $19
	fsub    $19, $55, $19
	store   $19, [$21 + 0]
	fmul    $17, $20, $19
	fmul    $17, $22, $17
	fmul    $19, $18, $19
	fmul    $17, $18, $17
	fsub    $19, $56, $19
	fsub    $17, $57, $17
	store   $19, [$21 + 1]
	store   $17, [$21 + 2]
	mov     $hp, $17
	store   $16, [$17 + 1]
	mov     $17, $2
	store   $21, [$17 + 0]
	add     $hp, 2, $hp
.count stack_store
	store   $2, [$sp + 13]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
	mov     $hp, $3
.count stack_load
	load    [$sp - 3], $1
.count stack_load
	load    [$sp - 14], $2
	add     $hp, 3, $hp
	fsub    $36, $1, $1
	sll     $2, 2, $2
	add     $2, 1, $2
	store   $1, [$3 + 2]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [$3 + 1]
	store   $2, [$3 + 0]
	mov     $3, $1
	load    [min_caml_n_reflections + 0], $2
	store   $1, [min_caml_reflections + $2]
	add     $2, 1, $1
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.31873:
	ret
be_else.31870:
	ret
bge_else.31869:
	ret
.end setup_reflections

######################################################################
.begin main
min_caml_main:
	load    [min_caml_image_size + 1], $60
	li      128, $10
	load    [min_caml_image_size + 0], $50
.count move_float
	mov     $10, $60
	load    [f.27084 + 0], $40
	li      64, $10
	load    [f.27086 + 0], $39
	load    [f.27108 + 0], $38
	load    [f.27109 + 0], $37
	load    [f.27085 + 0], $36
	load    [min_caml_or_net + 0], $59
	load    [min_caml_texture_color + 2], $58
	load    [min_caml_light + 2], $57
	load    [min_caml_light + 1], $56
	load    [min_caml_light + 0], $55
	load    [min_caml_texture_color + 1], $54
	load    [min_caml_startp_fast + 2], $53
	load    [min_caml_startp_fast + 1], $52
	load    [min_caml_startp_fast + 0], $51
	load    [min_caml_tmin + 0], $49
	load    [min_caml_rgb + 2], $48
	load    [min_caml_rgb + 1], $47
	load    [min_caml_rgb + 0], $46
	load    [min_caml_diffuse_ray + 2], $45
	load    [min_caml_diffuse_ray + 1], $44
	load    [min_caml_diffuse_ray + 0], $43
	load    [min_caml_solver_dist + 0], $42
	load    [min_caml_n_objects + 0], $41
	li      128, $2
	store   $10, [min_caml_image_center + 0]
.count stack_move
	sub     $sp, 18, $sp
	li      64, $10
.count move_float
	mov     $2, $50
	store   $10, [min_caml_image_center + 1]
.count load_float
	load    [f.27202], $10
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $11
	li      3, $2
	finv    $11, $11
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
.count move_args
	mov     $50, $2
	mov     $hp, $18
	store   $17, [$18 + 7]
	add     $hp, 8, $hp
	store   $16, [$18 + 6]
	mov     $18, $3
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31874
bge_then.31874:
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
	b       bge_cont.31874
bge_else.31874:
	mov     $19, $10
bge_cont.31874:
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
.count move_args
	mov     $50, $2
	mov     $hp, $18
	store   $17, [$18 + 7]
	add     $hp, 8, $hp
	store   $16, [$18 + 6]
	mov     $18, $3
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31875
bge_then.31875:
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
	b       bge_cont.31875
bge_else.31875:
	mov     $19, $10
bge_cont.31875:
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
.count move_args
	mov     $50, $2
	mov     $hp, $18
	store   $17, [$18 + 7]
	add     $hp, 8, $hp
	store   $16, [$18 + 6]
	mov     $18, $3
	store   $15, [$18 + 5]
	store   $14, [$18 + 4]
	store   $13, [$18 + 3]
	store   $12, [$18 + 2]
	store   $11, [$18 + 1]
	store   $10, [$18 + 0]
	call    min_caml_create_array
	sub     $50, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31876
bge_then.31876:
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
	b       bge_cont.31876
bge_else.31876:
	mov     $19, $10
bge_cont.31876:
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
	load    [f.27070], $12
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
	load    [f.27230], $15
	fmul    $14, $15, $14
	store   $14, [min_caml_screenz_dir + 0]
.count stack_load
	load    [$sp + 4], $16
.count load_float
	load    [f.27231], $14
	fmul    $16, $14, $14
	store   $14, [min_caml_screenz_dir + 1]
	fmul    $11, $13, $14
	fmul    $14, $15, $14
	store   $14, [min_caml_screenz_dir + 2]
	store   $13, [min_caml_screenx_dir + 0]
	fneg    $10, $14
	store   $zero, [min_caml_screenx_dir + 1]
	store   $14, [min_caml_screenx_dir + 2]
	fneg    $16, $14
	fmul    $14, $10, $10
	store   $10, [min_caml_screeny_dir + 0]
	fneg    $11, $10
	store   $10, [min_caml_screeny_dir + 1]
	fmul    $14, $13, $10
	store   $10, [min_caml_screeny_dir + 2]
	load    [min_caml_screenz_dir + 0], $11
	load    [min_caml_screen + 0], $10
	fsub    $10, $11, $10
	store   $10, [min_caml_viewpoint + 0]
	load    [min_caml_screenz_dir + 1], $11
	load    [min_caml_screen + 1], $10
	fsub    $10, $11, $10
	store   $10, [min_caml_viewpoint + 1]
	load    [min_caml_screenz_dir + 2], $11
	load    [min_caml_screen + 2], $10
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
.count stack_load
	load    [$sp + 7], $2
	fmul    $13, $11, $11
.count move_float
	mov     $11, $55
	call    min_caml_cos
.count move_ret
	mov     $1, $10
	fmul    $13, $10, $10
.count move_float
	mov     $10, $57
	call    min_caml_read_float
.count move_ret
	mov     $1, $23
	li      0, $2
	store   $23, [min_caml_beam + 0]
.count stack_store
	store   $2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31877
be_then.31877:
.count stack_load
	load    [$sp + 8], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.31877
be_else.31877:
	li      1, $2
.count stack_store
	store   $2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31878
be_then.31878:
.count stack_load
	load    [$sp + 9], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.31878
be_else.31878:
	li      2, $2
.count stack_store
	store   $2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31879
be_then.31879:
.count stack_load
	load    [$sp + 10], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.31879
be_else.31879:
	li      3, $2
.count stack_store
	store   $2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $24
	cmp     $24, 0
	bne     be_else.31880
be_then.31880:
.count stack_load
	load    [$sp + 11], $10
.count move_float
	mov     $10, $41
.count b_cont
	b       be_cont.31880
be_else.31880:
	li      4, $2
	call    read_object.2721
be_cont.31880:
be_cont.31879:
be_cont.31878:
be_cont.31877:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31881
be_then.31881:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
.count b_cont
	b       be_cont.31881
be_else.31881:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31882
be_then.31882:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $10, [$18 + 0]
.count b_cont
	b       be_cont.31882
be_else.31882:
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
be_cont.31882:
be_cont.31881:
	load    [$18 + 0], $19
	cmp     $19, -1
	be      bne_cont.31883
bne_then.31883:
	store   $18, [min_caml_and_net + 0]
	li      1, $2
	call    read_and_network.2729
bne_cont.31883:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31884
be_then.31884:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count b_cont
	b       be_cont.31884
be_else.31884:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31885
be_then.31885:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
.count b_cont
	b       be_cont.31885
be_else.31885:
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
be_cont.31885:
be_cont.31884:
	mov     $10, $3
	li      1, $2
	load    [$3 + 0], $10
	cmp     $10, -1
	bne     be_else.31886
be_then.31886:
	call    min_caml_create_array
.count b_cont
	b       be_cont.31886
be_else.31886:
.count stack_store
	store   $3, [$sp + 16]
	call    read_or_network.2727
.count stack_load
	load    [$sp + 16], $10
	store   $10, [$1 + 0]
be_cont.31886:
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
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	li      120, $2
.count stack_load
	load    [$sp + 17], $10
	add     $hp, 2, $hp
	mov     $11, $3
	store   $10, [$11 + 0]
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
	load    [f.27139], $22
.count move_ret
	mov     $1, $21
.count load_float
	load    [f.27140], $23
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
	li      119, $3
	load    [min_caml_dirvecs + 4], $2
	call    init_dirvec_constants.3044
	li      3, $2
	call    init_vecset_constants.3047
	load    [min_caml_light_dirvec + 0], $11
	sub     $41, 1, $12
	li      min_caml_light_dirvec, $10
	store   $55, [$11 + 0]
	cmp     $12, 0
	store   $56, [$11 + 1]
	store   $57, [$11 + 2]
	bl      bge_cont.31887
bge_then.31887:
	load    [min_caml_objects + $12], $14
	load    [min_caml_light_dirvec + 1], $13
.count move_args
	mov     $zero, $3
	load    [$14 + 1], $15
	cmp     $15, 1
	bne     be_else.31888
be_then.31888:
	li      6, $2
	call    min_caml_create_array
	load    [$11 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31889
be_then.31889:
	store   $zero, [$16 + 1]
.count b_cont
	b       be_cont.31889
be_else.31889:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31890
ble_then.31890:
	li      0, $17
.count b_cont
	b       ble_cont.31890
ble_else.31890:
	li      1, $17
ble_cont.31890:
	cmp     $18, 0
	be      bne_cont.31891
bne_then.31891:
	cmp     $17, 0
	bne     be_else.31892
be_then.31892:
	li      1, $17
.count b_cont
	b       be_cont.31892
be_else.31892:
	li      0, $17
be_cont.31892:
bne_cont.31891:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31893
be_then.31893:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
.count b_cont
	b       be_cont.31893
be_else.31893:
	store   $18, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31893:
be_cont.31889:
	load    [$11 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31894
be_then.31894:
	store   $zero, [$16 + 3]
.count b_cont
	b       be_cont.31894
be_else.31894:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31895
ble_then.31895:
	li      0, $17
.count b_cont
	b       ble_cont.31895
ble_else.31895:
	li      1, $17
ble_cont.31895:
	cmp     $18, 0
	be      bne_cont.31896
bne_then.31896:
	cmp     $17, 0
	bne     be_else.31897
be_then.31897:
	li      1, $17
.count b_cont
	b       be_cont.31897
be_else.31897:
	li      0, $17
be_cont.31897:
bne_cont.31896:
	load    [$14 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31898
be_then.31898:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
.count b_cont
	b       be_cont.31898
be_else.31898:
	store   $18, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31898:
be_cont.31894:
	load    [$11 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31899
be_then.31899:
.count storer
	add     $13, $12, $tmp
	store   $zero, [$16 + 5]
	sub     $12, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31888
be_else.31899:
	load    [$14 + 6], $18
	load    [$14 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31900
ble_then.31900:
	li      0, $17
.count b_cont
	b       ble_cont.31900
ble_else.31900:
	li      1, $17
ble_cont.31900:
	cmp     $18, 0
	be      bne_cont.31901
bne_then.31901:
	cmp     $17, 0
	bne     be_else.31902
be_then.31902:
	li      1, $17
.count b_cont
	b       be_cont.31902
be_else.31902:
	li      0, $17
be_cont.31902:
bne_cont.31901:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $12, 1, $3
.count storer
	add     $13, $12, $tmp
	bne     be_else.31903
be_then.31903:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$11 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31888
be_else.31903:
	store   $18, [$16 + 4]
	load    [$11 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31888
be_else.31888:
	cmp     $15, 2
	bne     be_else.31904
be_then.31904:
	li      4, $2
	call    min_caml_create_array
	load    [$14 + 4], $17
	load    [$11 + 0], $20
	load    [$14 + 4], $18
	load    [$17 + 0], $17
	load    [$14 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 2], $19
	load    [$11 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $12, 1, $3
	load    [$11 + 2], $20
.count storer
	add     $13, $12, $tmp
	fadd    $17, $18, $17
	fmul    $20, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
	bg      ble_else.31905
ble_then.31905:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31904
ble_else.31905:
	finv    $17, $17
	fneg    $17, $18
	store   $18, [$16 + 0]
	load    [$14 + 4], $18
	load    [$18 + 0], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 1]
	load    [$14 + 4], $18
	load    [$18 + 1], $18
	fmul    $18, $17, $18
	fneg    $18, $18
	store   $18, [$16 + 2]
	load    [$14 + 4], $18
	load    [$18 + 2], $18
	fmul    $18, $17, $17
	fneg    $17, $17
	store   $17, [$16 + 3]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31904
be_else.31904:
	li      5, $2
	call    min_caml_create_array
	load    [$11 + 0], $21
	load    [$11 + 1], $22
	load    [$14 + 4], $18
	load    [$14 + 4], $19
	fmul    $21, $21, $24
	fmul    $22, $22, $25
	load    [$11 + 2], $23
	load    [$18 + 0], $18
	load    [$19 + 1], $19
	load    [$14 + 4], $20
	fmul    $23, $23, $26
	fmul    $24, $18, $18
	fmul    $25, $19, $19
	load    [$20 + 2], $20
	load    [$14 + 3], $17
.count move_ret
	mov     $1, $16
	fmul    $26, $20, $20
	fadd    $18, $19, $18
	cmp     $17, 0
	fadd    $18, $20, $18
	be      bne_cont.31906
bne_then.31906:
	load    [$14 + 9], $20
	fmul    $22, $23, $19
	load    [$14 + 9], $24
	load    [$20 + 0], $20
	fmul    $23, $21, $23
	fmul    $19, $20, $19
	fmul    $21, $22, $21
	load    [$24 + 1], $20
	load    [$14 + 9], $22
	fadd    $18, $19, $18
	fmul    $23, $20, $20
	load    [$22 + 2], $19
	fmul    $21, $19, $19
	fadd    $18, $20, $18
	fadd    $18, $19, $18
bne_cont.31906:
	store   $18, [$16 + 0]
	load    [$14 + 4], $19
	load    [$11 + 0], $22
	load    [$14 + 4], $20
	load    [$19 + 0], $19
	load    [$14 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$11 + 2], $23
	load    [$11 + 1], $22
	load    [$21 + 2], $21
	cmp     $17, 0
	fmul    $22, $20, $20
	fmul    $23, $21, $21
	fneg    $19, $19
.count storer
	add     $13, $12, $tmp
	sub     $12, 1, $3
	fneg    $20, $20
	fneg    $21, $21
.count move_args
	mov     $10, $2
	bne     be_else.31907
be_then.31907:
	store   $19, [$16 + 1]
	fcmp    $18, $zero
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	bne     be_else.31908
be_then.31908:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31907
be_else.31908:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31907
be_else.31907:
	load    [$14 + 9], $24
	load    [$14 + 9], $17
	fcmp    $18, $zero
	load    [$24 + 2], $24
	load    [$17 + 1], $17
	fmul    $22, $24, $22
	fmul    $23, $17, $23
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$11 + 2], $22
	load    [$14 + 9], $19
	load    [$11 + 0], $23
	load    [$19 + 0], $19
	fmul    $23, $24, $23
	fmul    $22, $19, $22
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$11 + 0], $22
	load    [$11 + 1], $20
	fmul    $22, $17, $17
	fmul    $20, $19, $19
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	bne     be_else.31909
be_then.31909:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
.count b_cont
	b       be_cont.31909
be_else.31909:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31909:
be_cont.31907:
be_cont.31904:
be_cont.31888:
bge_cont.31887:
	sub     $41, 1, $2
	call    setup_reflections.3064
	load    [min_caml_image_center + 1], $14
	li      0, $10
	sub     $50, 1, $11
	load    [min_caml_screeny_dir + 0], $12
	load    [min_caml_scan_pitch + 0], $13
	neg     $14, $2
	call    min_caml_float_of_int
	fmul    $13, $1, $1
	load    [min_caml_screenz_dir + 0], $2
	load    [min_caml_screeny_dir + 1], $4
	fmul    $1, $12, $3
	fmul    $1, $4, $4
	fadd    $3, $2, $5
	load    [min_caml_screeny_dir + 2], $3
	load    [min_caml_screenz_dir + 1], $2
	fmul    $1, $3, $1
	fadd    $4, $2, $6
.count move_args
	mov     $11, $3
	load    [min_caml_screenz_dir + 2], $2
.count move_args
	mov     $10, $4
	fadd    $1, $2, $7
.count stack_load
	load    [$sp + 1], $2
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
