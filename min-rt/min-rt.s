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
	bne     be_else.30927
be_then.30927:
.count stack_move
	add     $sp, 1, $sp
	li      0, $1
	ret
be_else.30927:
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
	be      bne_cont.30928
bne_then.30928:
	call    min_caml_read_float
.count move_ret
	mov     $1, $20
.count load_float
	load    [f.27070], $21
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
bne_cont.30928:
	li      4, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $20
	fcmp    $zero, $16
	bg      ble_else.30929
ble_then.30929:
	li      0, $16
	b       ble_cont.30929
ble_else.30929:
	li      1, $16
ble_cont.30929:
	cmp     $11, 2
	bne     be_else.30930
be_then.30930:
	li      1, $21
	b       be_cont.30930
be_else.30930:
	mov     $16, $21
be_cont.30930:
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
	mov     $22, $12
.count stack_load
	load    [$sp + 0], $15
	store   $12, [min_caml_objects + $15]
	cmp     $11, 3
	bne     be_else.30931
be_then.30931:
	load    [$14 + 0], $11
	fcmp    $11, $zero
	bne     be_else.30932
be_then.30932:
	mov     $zero, $11
	b       be_cont.30932
be_else.30932:
	fcmp    $11, $zero
	bne     be_else.30933
be_then.30933:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
	b       be_cont.30933
be_else.30933:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30934
ble_then.30934:
	fneg    $11, $11
ble_cont.30934:
be_cont.30933:
be_cont.30932:
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fcmp    $11, $zero
	bne     be_else.30935
be_then.30935:
	mov     $zero, $11
	b       be_cont.30935
be_else.30935:
	fcmp    $11, $zero
	bne     be_else.30936
be_then.30936:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
	b       be_cont.30936
be_else.30936:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30937
ble_then.30937:
	fneg    $11, $11
ble_cont.30937:
be_cont.30936:
be_cont.30935:
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fcmp    $11, $zero
	bne     be_else.30938
be_then.30938:
	mov     $zero, $11
	b       be_cont.30938
be_else.30938:
	fcmp    $11, $zero
	bne     be_else.30939
be_then.30939:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
	b       be_cont.30939
be_else.30939:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.30940
ble_then.30940:
	fneg    $11, $11
ble_cont.30940:
be_cont.30939:
be_cont.30938:
	store   $11, [$14 + 2]
	cmp     $13, 0
	bne     be_else.30941
be_then.30941:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30941:
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
	fmul    $2, $2, $3
	load    [$14 + 0], $4
	fmul    $4, $3, $3
	fmul    $13, $1, $5
	fmul    $5, $5, $6
	load    [$14 + 1], $7
	fmul    $7, $6, $6
	fadd    $3, $6, $3
	fneg    $15, $6
	fmul    $6, $6, $8
	load    [$14 + 2], $9
	fmul    $9, $8, $8
	fadd    $3, $8, $3
	store   $3, [$14 + 0]
	fmul    $12, $15, $3
	fmul    $3, $16, $8
	fmul    $11, $1, $10
	fsub    $8, $10, $8
	fmul    $8, $8, $10
	fmul    $4, $10, $10
	fmul    $3, $1, $3
	fmul    $11, $16, $17
	fadd    $3, $17, $3
	fmul    $3, $3, $17
	fmul    $7, $17, $17
	fadd    $10, $17, $10
	fmul    $12, $13, $17
	fmul    $17, $17, $18
	fmul    $9, $18, $18
	fadd    $10, $18, $10
	store   $10, [$14 + 1]
	fmul    $11, $15, $10
	fmul    $10, $16, $15
	fmul    $12, $1, $18
	fadd    $15, $18, $15
	fmul    $15, $15, $18
	fmul    $4, $18, $18
	fmul    $10, $1, $1
	fmul    $12, $16, $10
	fsub    $1, $10, $1
	fmul    $1, $1, $10
	fmul    $7, $10, $10
	fadd    $18, $10, $10
	fmul    $11, $13, $11
	fmul    $11, $11, $12
	fmul    $9, $12, $12
	fadd    $10, $12, $10
	store   $10, [$14 + 2]
.count load_float
	load    [f.27083], $10
	fmul    $4, $8, $12
	fmul    $12, $15, $12
	fmul    $7, $3, $13
	fmul    $13, $1, $13
	fadd    $12, $13, $12
	fmul    $9, $17, $13
	fmul    $13, $11, $13
	fadd    $12, $13, $12
	fmul    $10, $12, $12
	store   $12, [$19 + 0]
	fmul    $4, $2, $2
	fmul    $2, $15, $4
	fmul    $7, $5, $5
	fmul    $5, $1, $1
	fadd    $4, $1, $1
	fmul    $9, $6, $4
	fmul    $4, $11, $6
	fadd    $1, $6, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $8, $1
	fmul    $5, $3, $2
	fadd    $1, $2, $1
	fmul    $4, $17, $2
	fadd    $1, $2, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.30931:
	cmp     $11, 2
	bne     be_else.30942
be_then.30942:
	load    [$14 + 0], $11
	cmp     $16, 0
	bne     be_else.30943
be_then.30943:
	li      1, $12
	b       be_cont.30943
be_else.30943:
	li      0, $12
be_cont.30943:
	fmul    $11, $11, $15
	load    [$14 + 1], $16
	fmul    $16, $16, $16
	fadd    $15, $16, $15
	load    [$14 + 2], $16
	fmul    $16, $16, $16
	fadd    $15, $16, $15
	fsqrt   $15, $15
	fcmp    $15, $zero
	bne     be_else.30944
be_then.30944:
	mov     $36, $12
	b       be_cont.30944
be_else.30944:
	cmp     $12, 0
	finv    $15, $12
	be      bne_cont.30945
bne_then.30945:
	fneg    $12, $12
bne_cont.30945:
be_cont.30944:
	fmul    $11, $12, $11
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fmul    $11, $12, $11
	store   $11, [$14 + 2]
	cmp     $13, 0
	bne     be_else.30946
be_then.30946:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30946:
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
	fmul    $2, $2, $3
	load    [$14 + 0], $4
	fmul    $4, $3, $3
	fmul    $13, $1, $5
	fmul    $5, $5, $6
	load    [$14 + 1], $7
	fmul    $7, $6, $6
	fadd    $3, $6, $3
	fneg    $15, $6
	fmul    $6, $6, $8
	load    [$14 + 2], $9
	fmul    $9, $8, $8
	fadd    $3, $8, $3
	store   $3, [$14 + 0]
	fmul    $12, $15, $3
	fmul    $3, $16, $8
	fmul    $11, $1, $10
	fsub    $8, $10, $8
	fmul    $8, $8, $10
	fmul    $4, $10, $10
	fmul    $3, $1, $3
	fmul    $11, $16, $17
	fadd    $3, $17, $3
	fmul    $3, $3, $17
	fmul    $7, $17, $17
	fadd    $10, $17, $10
	fmul    $12, $13, $17
	fmul    $17, $17, $18
	fmul    $9, $18, $18
	fadd    $10, $18, $10
	store   $10, [$14 + 1]
	fmul    $11, $15, $10
	fmul    $10, $16, $15
	fmul    $12, $1, $18
	fadd    $15, $18, $15
	fmul    $15, $15, $18
	fmul    $4, $18, $18
	fmul    $10, $1, $1
	fmul    $12, $16, $10
	fsub    $1, $10, $1
	fmul    $1, $1, $10
	fmul    $7, $10, $10
	fadd    $18, $10, $10
	fmul    $11, $13, $11
	fmul    $11, $11, $12
	fmul    $9, $12, $12
	fadd    $10, $12, $10
	store   $10, [$14 + 2]
.count load_float
	load    [f.27083], $10
	fmul    $4, $8, $12
	fmul    $12, $15, $12
	fmul    $7, $3, $13
	fmul    $13, $1, $13
	fadd    $12, $13, $12
	fmul    $9, $17, $13
	fmul    $13, $11, $13
	fadd    $12, $13, $12
	fmul    $10, $12, $12
	store   $12, [$19 + 0]
	fmul    $4, $2, $2
	fmul    $2, $15, $4
	fmul    $7, $5, $5
	fmul    $5, $1, $1
	fadd    $4, $1, $1
	fmul    $9, $6, $4
	fmul    $4, $11, $6
	fadd    $1, $6, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $8, $1
	fmul    $5, $3, $2
	fadd    $1, $2, $1
	fmul    $4, $17, $2
	fadd    $1, $2, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.30942:
	cmp     $13, 0
	bne     be_else.30947
be_then.30947:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.30947:
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
	fmul    $2, $2, $3
	load    [$14 + 0], $4
	fmul    $4, $3, $3
	fmul    $13, $1, $5
	fmul    $5, $5, $6
	load    [$14 + 1], $7
	fmul    $7, $6, $6
	fadd    $3, $6, $3
	fneg    $15, $6
	fmul    $6, $6, $8
	load    [$14 + 2], $9
	fmul    $9, $8, $8
	fadd    $3, $8, $3
	store   $3, [$14 + 0]
	fmul    $12, $15, $3
	fmul    $3, $16, $8
	fmul    $11, $1, $10
	fsub    $8, $10, $8
	fmul    $8, $8, $10
	fmul    $4, $10, $10
	fmul    $3, $1, $3
	fmul    $11, $16, $17
	fadd    $3, $17, $3
	fmul    $3, $3, $17
	fmul    $7, $17, $17
	fadd    $10, $17, $10
	fmul    $12, $13, $17
	fmul    $17, $17, $18
	fmul    $9, $18, $18
	fadd    $10, $18, $10
	store   $10, [$14 + 1]
	fmul    $11, $15, $10
	fmul    $10, $16, $15
	fmul    $12, $1, $18
	fadd    $15, $18, $15
	fmul    $15, $15, $18
	fmul    $4, $18, $18
	fmul    $10, $1, $1
	fmul    $12, $16, $10
	fsub    $1, $10, $1
	fmul    $1, $1, $10
	fmul    $7, $10, $10
	fadd    $18, $10, $10
	fmul    $11, $13, $11
	fmul    $11, $11, $12
	fmul    $9, $12, $12
	fadd    $10, $12, $10
	store   $10, [$14 + 2]
.count load_float
	load    [f.27083], $10
	fmul    $4, $8, $12
	fmul    $12, $15, $12
	fmul    $7, $3, $13
	fmul    $13, $1, $13
	fadd    $12, $13, $12
	fmul    $9, $17, $13
	fmul    $13, $11, $13
	fadd    $12, $13, $12
	fmul    $10, $12, $12
	store   $12, [$19 + 0]
	fmul    $4, $2, $2
	fmul    $2, $15, $4
	fmul    $7, $5, $5
	fmul    $5, $1, $1
	fadd    $4, $1, $1
	fmul    $9, $6, $4
	fmul    $4, $11, $6
	fadd    $1, $6, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $8, $1
	fmul    $5, $3, $2
	fadd    $1, $2, $1
	fmul    $4, $17, $2
	fadd    $1, $2, $1
	fmul    $10, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
.end read_nth_object

######################################################################
.begin read_object
read_object.2721:
	cmp     $2, 60
	bl      bge_else.30948
bge_then.30948:
	ret
bge_else.30948:
.count stack_move
	sub     $sp, 8, $sp
.count stack_store
	store   $2, [$sp + 0]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30949
be_then.30949:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 8], $1
.count move_float
	mov     $1, $41
	ret
be_else.30949:
.count stack_load
	load    [$sp + 0], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30950
bge_then.30950:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30950:
.count stack_store
	store   $2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30951
be_then.30951:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 7], $1
.count move_float
	mov     $1, $41
	ret
be_else.30951:
.count stack_load
	load    [$sp + 1], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30952
bge_then.30952:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30952:
.count stack_store
	store   $2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30953
be_then.30953:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 6], $1
.count move_float
	mov     $1, $41
	ret
be_else.30953:
.count stack_load
	load    [$sp + 2], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30954
bge_then.30954:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30954:
.count stack_store
	store   $2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30955
be_then.30955:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 5], $1
.count move_float
	mov     $1, $41
	ret
be_else.30955:
.count stack_load
	load    [$sp + 3], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30956
bge_then.30956:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30956:
.count stack_store
	store   $2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30957
be_then.30957:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 4], $1
.count move_float
	mov     $1, $41
	ret
be_else.30957:
.count stack_load
	load    [$sp + 4], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30958
bge_then.30958:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30958:
.count stack_store
	store   $2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30959
be_then.30959:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 3], $1
.count move_float
	mov     $1, $41
	ret
be_else.30959:
.count stack_load
	load    [$sp + 5], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30960
bge_then.30960:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30960:
.count stack_store
	store   $2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.30961
be_then.30961:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 2], $1
.count move_float
	mov     $1, $41
	ret
be_else.30961:
.count stack_load
	load    [$sp + 6], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.30962
bge_then.30962:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.30962:
.count stack_store
	store   $2, [$sp + 7]
	call    read_nth_object.2719
.count stack_move
	add     $sp, 8, $sp
	cmp     $1, 0
.count stack_load
	load    [$sp - 1], $1
	bne     be_else.30963
be_then.30963:
.count move_float
	mov     $1, $41
	ret
be_else.30963:
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
	bne     be_else.30964
be_then.30964:
.count stack_move
	add     $sp, 8, $sp
.count stack_load
	load    [$sp - 8], $10
	add     $10, 1, $2
	add     $zero, -1, $3
	b       min_caml_create_array
be_else.30964:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
.count stack_load
	load    [$sp + 0], $12
	add     $12, 1, $13
	cmp     $11, -1
	bne     be_else.30965
be_then.30965:
	add     $13, 1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count stack_move
	add     $sp, 8, $sp
.count storer
	add     $1, $12, $tmp
	store   $10, [$tmp + 0]
	ret
be_else.30965:
	call    min_caml_read_int
.count move_ret
	mov     $1, $14
	add     $13, 1, $15
	cmp     $14, -1
	bne     be_else.30966
be_then.30966:
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
be_else.30966:
	call    min_caml_read_int
.count move_ret
	mov     $1, $16
	add     $15, 1, $17
	cmp     $16, -1
	add     $17, 1, $2
	bne     be_else.30967
be_then.30967:
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
be_else.30967:
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
	bne     be_else.30968
be_then.30968:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.30968
be_else.30968:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.30969
be_then.30969:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.30969
be_else.30969:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.30970
be_then.30970:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.30970
be_else.30970:
.count stack_store
	store   $10, [$sp + 1]
.count stack_store
	store   $11, [$sp + 2]
.count stack_store
	store   $12, [$sp + 3]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 3], $11
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.30970:
be_cont.30969:
be_cont.30968:
	mov     $10, $3
	load    [$3 + 0], $10
	cmp     $10, -1
	bne     be_else.30971
be_then.30971:
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 9], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.30971:
.count stack_store
	store   $3, [$sp + 4]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.30972
be_then.30972:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.30972
be_else.30972:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.30973
be_then.30973:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.30973
be_else.30973:
.count stack_store
	store   $10, [$sp + 5]
.count stack_store
	store   $11, [$sp + 6]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 6], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 5], $11
	store   $11, [$10 + 0]
be_cont.30973:
be_cont.30972:
	mov     $10, $3
	load    [$3 + 0], $10
.count stack_load
	load    [$sp + 0], $11
	add     $11, 1, $12
	cmp     $10, -1
	add     $12, 1, $2
	bne     be_else.30974
be_then.30974:
	call    min_caml_create_array
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 5], $2
.count storer
	add     $1, $11, $tmp
	store   $2, [$tmp + 0]
	ret
be_else.30974:
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
	bne     be_else.30975
be_then.30975:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.30975
be_else.30975:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.30976
be_then.30976:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.30976
be_else.30976:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.30977
be_then.30977:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.30977
be_else.30977:
.count stack_store
	store   $10, [$sp + 1]
.count stack_store
	store   $11, [$sp + 2]
.count stack_store
	store   $12, [$sp + 3]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 3], $11
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.30977:
be_cont.30976:
be_cont.30975:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.30978
be_then.30978:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.30978:
.count stack_load
	load    [$sp + 0], $11
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.30979
be_then.30979:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.30979
be_else.30979:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.30980
be_then.30980:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.30980
be_else.30980:
.count stack_store
	store   $10, [$sp + 4]
.count stack_store
	store   $11, [$sp + 5]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 5], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 4], $11
	store   $11, [$10 + 0]
be_cont.30980:
be_cont.30979:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.30981
be_then.30981:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.30981:
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
	bne     be_else.30982
be_then.30982:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.30982
be_else.30982:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.30983
be_then.30983:
	li      2, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.30983
be_else.30983:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.30984
be_then.30984:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.30984
be_else.30984:
.count stack_store
	store   $10, [$sp + 7]
.count stack_store
	store   $11, [$sp + 8]
.count stack_store
	store   $12, [$sp + 9]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 9], $11
	store   $11, [$10 + 2]
.count stack_load
	load    [$sp + 8], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 7], $11
	store   $11, [$10 + 0]
be_cont.30984:
be_cont.30983:
be_cont.30982:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.30985
be_then.30985:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.30985:
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
	bne     be_else.30986
be_then.30986:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
	b       be_cont.30986
be_else.30986:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.30987
be_then.30987:
	add     $zero, -1, $3
	call    min_caml_create_array
	store   $10, [$1 + 0]
	b       be_cont.30987
be_else.30987:
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
be_cont.30987:
be_cont.30986:
.count stack_move
	add     $sp, 13, $sp
	load    [$1 + 0], $2
	cmp     $2, -1
	bne     be_else.30988
be_then.30988:
	ret
be_else.30988:
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
	load    [$1 + 5], $2
	load    [$1 + 5], $4
	load    [$1 + 5], $5
	load    [$1 + 1], $6
	load    [min_caml_startp + 0], $7
	load    [$2 + 0], $2
	load    [min_caml_startp + 1], $8
	load    [$4 + 1], $4
	load    [min_caml_startp + 2], $9
	load    [$5 + 2], $5
	fsub    $7, $2, $2
	fsub    $8, $4, $4
	fsub    $9, $5, $5
	cmp     $6, 1
	bne     be_else.30989
be_then.30989:
	load    [$3 + 0], $6
	fcmp    $6, $zero
	bne     be_else.30990
be_then.30990:
	li      0, $6
	b       be_cont.30990
be_else.30990:
	load    [$1 + 4], $7
	load    [$7 + 1], $8
	load    [$3 + 1], $9
	load    [$1 + 6], $10
	fcmp    $zero, $6
	bg      ble_else.30991
ble_then.30991:
	li      0, $11
	b       ble_cont.30991
ble_else.30991:
	li      1, $11
ble_cont.30991:
	cmp     $10, 0
	bne     be_else.30992
be_then.30992:
	mov     $11, $10
	b       be_cont.30992
be_else.30992:
	cmp     $11, 0
	bne     be_else.30993
be_then.30993:
	li      1, $10
	b       be_cont.30993
be_else.30993:
	li      0, $10
be_cont.30993:
be_cont.30992:
	load    [$7 + 0], $11
	cmp     $10, 0
	bne     be_else.30994
be_then.30994:
	fneg    $11, $10
	b       be_cont.30994
be_else.30994:
	mov     $11, $10
be_cont.30994:
	fsub    $10, $2, $10
	finv    $6, $6
	fmul    $10, $6, $6
	fmul    $6, $9, $9
	fadd    $9, $4, $9
	fabs    $9, $9
	fcmp    $8, $9
	bg      ble_else.30995
ble_then.30995:
	li      0, $6
	b       ble_cont.30995
ble_else.30995:
	load    [$7 + 2], $7
	load    [$3 + 2], $8
	fmul    $6, $8, $8
	fadd    $8, $5, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.30996
ble_then.30996:
	li      0, $6
	b       ble_cont.30996
ble_else.30996:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.30996:
ble_cont.30995:
be_cont.30990:
	cmp     $6, 0
	bne     be_else.30997
be_then.30997:
	load    [$3 + 1], $6
	fcmp    $6, $zero
	bne     be_else.30998
be_then.30998:
	li      0, $6
	b       be_cont.30998
be_else.30998:
	load    [$1 + 4], $7
	load    [$7 + 2], $8
	load    [$3 + 2], $9
	load    [$1 + 6], $10
	fcmp    $zero, $6
	bg      ble_else.30999
ble_then.30999:
	li      0, $11
	b       ble_cont.30999
ble_else.30999:
	li      1, $11
ble_cont.30999:
	cmp     $10, 0
	bne     be_else.31000
be_then.31000:
	mov     $11, $10
	b       be_cont.31000
be_else.31000:
	cmp     $11, 0
	bne     be_else.31001
be_then.31001:
	li      1, $10
	b       be_cont.31001
be_else.31001:
	li      0, $10
be_cont.31001:
be_cont.31000:
	load    [$7 + 1], $11
	cmp     $10, 0
	bne     be_else.31002
be_then.31002:
	fneg    $11, $10
	b       be_cont.31002
be_else.31002:
	mov     $11, $10
be_cont.31002:
	fsub    $10, $4, $10
	finv    $6, $6
	fmul    $10, $6, $6
	fmul    $6, $9, $9
	fadd    $9, $5, $9
	fabs    $9, $9
	fcmp    $8, $9
	bg      ble_else.31003
ble_then.31003:
	li      0, $6
	b       ble_cont.31003
ble_else.31003:
	load    [$7 + 0], $7
	load    [$3 + 0], $8
	fmul    $6, $8, $8
	fadd    $8, $2, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31004
ble_then.31004:
	li      0, $6
	b       ble_cont.31004
ble_else.31004:
.count move_float
	mov     $6, $42
	li      1, $6
ble_cont.31004:
ble_cont.31003:
be_cont.30998:
	cmp     $6, 0
	bne     be_else.31005
be_then.31005:
	load    [$3 + 2], $6
	fcmp    $6, $zero
	bne     be_else.31006
be_then.31006:
	li      0, $1
	ret
be_else.31006:
	load    [$1 + 4], $7
	load    [$1 + 6], $1
	load    [$7 + 0], $8
	load    [$3 + 0], $9
	fcmp    $zero, $6
	bg      ble_else.31007
ble_then.31007:
	li      0, $10
	b       ble_cont.31007
ble_else.31007:
	li      1, $10
ble_cont.31007:
	cmp     $1, 0
	bne     be_else.31008
be_then.31008:
	mov     $10, $1
	b       be_cont.31008
be_else.31008:
	cmp     $10, 0
	bne     be_else.31009
be_then.31009:
	li      1, $1
	b       be_cont.31009
be_else.31009:
	li      0, $1
be_cont.31009:
be_cont.31008:
	load    [$7 + 2], $10
	cmp     $1, 0
	bne     be_else.31010
be_then.31010:
	fneg    $10, $1
	b       be_cont.31010
be_else.31010:
	mov     $10, $1
be_cont.31010:
	fsub    $1, $5, $1
	finv    $6, $5
	fmul    $1, $5, $1
	fmul    $1, $9, $5
	fadd    $5, $2, $2
	fabs    $2, $2
	fcmp    $8, $2
	bg      ble_else.31011
ble_then.31011:
	li      0, $1
	ret
ble_else.31011:
	load    [$7 + 1], $2
	load    [$3 + 1], $3
	fmul    $1, $3, $3
	fadd    $3, $4, $3
	fabs    $3, $3
	fcmp    $2, $3
	bg      ble_else.31012
ble_then.31012:
	li      0, $1
	ret
ble_else.31012:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.31005:
	li      2, $1
	ret
be_else.30997:
	li      1, $1
	ret
be_else.30989:
	cmp     $6, 2
	bne     be_else.31013
be_then.31013:
	load    [$1 + 4], $1
	load    [$3 + 0], $6
	load    [$1 + 0], $7
	fmul    $6, $7, $6
	load    [$3 + 1], $8
	load    [$1 + 1], $9
	fmul    $8, $9, $8
	fadd    $6, $8, $6
	load    [$3 + 2], $3
	load    [$1 + 2], $1
	fmul    $3, $1, $3
	fadd    $6, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31014
ble_then.31014:
	li      0, $1
	ret
ble_else.31014:
	fmul    $7, $2, $2
	fmul    $9, $4, $4
	fadd    $2, $4, $2
	fmul    $1, $5, $1
	fadd    $2, $1, $1
	fneg    $1, $1
	finv    $3, $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31013:
	load    [$1 + 4], $7
	load    [$1 + 4], $8
	load    [$1 + 4], $9
	load    [$1 + 3], $10
	load    [$3 + 0], $11
	load    [$3 + 1], $12
	load    [$3 + 2], $3
	fmul    $11, $11, $13
	load    [$7 + 0], $7
	fmul    $13, $7, $13
	fmul    $12, $12, $14
	load    [$8 + 1], $8
	fmul    $14, $8, $14
	fadd    $13, $14, $13
	fmul    $3, $3, $14
	load    [$9 + 2], $9
	fmul    $14, $9, $14
	fadd    $13, $14, $13
	cmp     $10, 0
	bne     be_else.31015
be_then.31015:
	mov     $13, $10
	b       be_cont.31015
be_else.31015:
	fmul    $12, $3, $10
	load    [$1 + 9], $14
	load    [$14 + 0], $14
	fmul    $10, $14, $10
	fadd    $13, $10, $10
	fmul    $3, $11, $13
	load    [$1 + 9], $14
	load    [$14 + 1], $14
	fmul    $13, $14, $13
	fadd    $10, $13, $10
	fmul    $11, $12, $13
	load    [$1 + 9], $14
	load    [$14 + 2], $14
	fmul    $13, $14, $13
	fadd    $10, $13, $10
be_cont.31015:
	fcmp    $10, $zero
	bne     be_else.31016
be_then.31016:
	li      0, $1
	ret
be_else.31016:
	load    [$1 + 3], $13
	load    [$1 + 3], $14
	fmul    $11, $2, $15
	fmul    $15, $7, $15
	fmul    $12, $4, $16
	fmul    $16, $8, $16
	fadd    $15, $16, $15
	fmul    $3, $5, $16
	fmul    $16, $9, $16
	fadd    $15, $16, $15
	cmp     $13, 0
	bne     be_else.31017
be_then.31017:
	mov     $15, $3
	b       be_cont.31017
be_else.31017:
	fmul    $3, $4, $13
	fmul    $12, $5, $16
	fadd    $13, $16, $13
	load    [$1 + 9], $16
	load    [$16 + 0], $16
	fmul    $13, $16, $13
	fmul    $11, $5, $16
	fmul    $3, $2, $3
	fadd    $16, $3, $3
	load    [$1 + 9], $16
	load    [$16 + 1], $16
	fmul    $3, $16, $3
	fadd    $13, $3, $3
	fmul    $11, $4, $11
	fmul    $12, $2, $12
	fadd    $11, $12, $11
	load    [$1 + 9], $12
	load    [$12 + 2], $12
	fmul    $11, $12, $11
	fadd    $3, $11, $3
	fmul    $3, $39, $3
	fadd    $15, $3, $3
be_cont.31017:
	fmul    $3, $3, $11
	fmul    $2, $2, $12
	fmul    $12, $7, $7
	fmul    $4, $4, $12
	fmul    $12, $8, $8
	fadd    $7, $8, $7
	fmul    $5, $5, $8
	fmul    $8, $9, $8
	fadd    $7, $8, $7
	cmp     $14, 0
	bne     be_else.31018
be_then.31018:
	mov     $7, $2
	b       be_cont.31018
be_else.31018:
	fmul    $4, $5, $8
	load    [$1 + 9], $9
	load    [$9 + 0], $9
	fmul    $8, $9, $8
	fadd    $7, $8, $7
	fmul    $5, $2, $5
	load    [$1 + 9], $8
	load    [$8 + 1], $8
	fmul    $5, $8, $5
	fadd    $7, $5, $5
	fmul    $2, $4, $2
	load    [$1 + 9], $4
	load    [$4 + 2], $4
	fmul    $2, $4, $2
	fadd    $5, $2, $2
be_cont.31018:
	cmp     $6, 3
	bne     be_cont.31019
be_then.31019:
	fsub    $2, $36, $2
be_cont.31019:
	fmul    $10, $2, $2
	fsub    $11, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31020
ble_then.31020:
	li      0, $1
	ret
ble_else.31020:
	load    [$1 + 6], $1
	fsqrt   $2, $2
	cmp     $1, 0
	bne     be_else.31021
be_then.31021:
	fneg    $2, $1
	fsub    $1, $3, $1
	finv    $10, $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31021:
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
	load    [$1 + 5], $3
	load    [$1 + 5], $4
	load    [$1 + 5], $5
	load    [min_caml_light_dirvec + 1], $6
	load    [$1 + 1], $7
	load    [min_caml_intersection_point + 0], $8
	load    [$3 + 0], $3
	load    [min_caml_intersection_point + 1], $9
	load    [$4 + 1], $4
	load    [min_caml_intersection_point + 2], $10
	load    [$5 + 2], $5
	fsub    $8, $3, $3
	fsub    $9, $4, $4
	fsub    $10, $5, $5
	load    [$6 + $2], $2
	cmp     $7, 1
	bne     be_else.31022
be_then.31022:
	load    [min_caml_light_dirvec + 0], $6
	load    [$1 + 4], $7
	load    [$7 + 1], $7
	load    [$6 + 1], $8
	load    [$2 + 0], $9
	fsub    $9, $3, $9
	load    [$2 + 1], $10
	fmul    $9, $10, $9
	fmul    $9, $8, $8
	fadd    $8, $4, $8
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31023
ble_then.31023:
	li      0, $8
	b       ble_cont.31023
ble_else.31023:
	load    [$1 + 4], $8
	load    [$8 + 2], $8
	load    [$6 + 2], $10
	fmul    $9, $10, $10
	fadd    $10, $5, $10
	fabs    $10, $10
	fcmp    $8, $10
	bg      ble_else.31024
ble_then.31024:
	li      0, $8
	b       ble_cont.31024
ble_else.31024:
	load    [$2 + 1], $8
	fcmp    $8, $zero
	bne     be_else.31025
be_then.31025:
	li      0, $8
	b       be_cont.31025
be_else.31025:
	li      1, $8
be_cont.31025:
ble_cont.31024:
ble_cont.31023:
	cmp     $8, 0
	bne     be_else.31026
be_then.31026:
	load    [$1 + 4], $8
	load    [$8 + 0], $8
	load    [$6 + 0], $9
	load    [$2 + 2], $10
	fsub    $10, $4, $10
	load    [$2 + 3], $11
	fmul    $10, $11, $10
	fmul    $10, $9, $9
	fadd    $9, $3, $9
	fabs    $9, $9
	fcmp    $8, $9
	bg      ble_else.31027
ble_then.31027:
	li      0, $1
	b       ble_cont.31027
ble_else.31027:
	load    [$1 + 4], $1
	load    [$1 + 2], $1
	load    [$6 + 2], $9
	fmul    $10, $9, $9
	fadd    $9, $5, $9
	fabs    $9, $9
	fcmp    $1, $9
	bg      ble_else.31028
ble_then.31028:
	li      0, $1
	b       ble_cont.31028
ble_else.31028:
	load    [$2 + 3], $1
	fcmp    $1, $zero
	bne     be_else.31029
be_then.31029:
	li      0, $1
	b       be_cont.31029
be_else.31029:
	li      1, $1
be_cont.31029:
ble_cont.31028:
ble_cont.31027:
	cmp     $1, 0
	bne     be_else.31030
be_then.31030:
	load    [$6 + 0], $1
	load    [$2 + 4], $9
	fsub    $9, $5, $5
	load    [$2 + 5], $9
	fmul    $5, $9, $5
	fmul    $5, $1, $1
	fadd    $1, $3, $1
	fabs    $1, $1
	fcmp    $8, $1
	bg      ble_else.31031
ble_then.31031:
	li      0, $1
	ret
ble_else.31031:
	load    [$6 + 1], $1
	fmul    $5, $1, $1
	fadd    $1, $4, $1
	fabs    $1, $1
	fcmp    $7, $1
	bg      ble_else.31032
ble_then.31032:
	li      0, $1
	ret
ble_else.31032:
	load    [$2 + 5], $1
	fcmp    $1, $zero
	bne     be_else.31033
be_then.31033:
	li      0, $1
	ret
be_else.31033:
.count move_float
	mov     $5, $42
	li      3, $1
	ret
be_else.31030:
.count move_float
	mov     $10, $42
	li      2, $1
	ret
be_else.31026:
.count move_float
	mov     $9, $42
	li      1, $1
	ret
be_else.31022:
	cmp     $7, 2
	bne     be_else.31034
be_then.31034:
	load    [$2 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31035
ble_then.31035:
	li      0, $1
	ret
ble_else.31035:
	load    [$2 + 1], $1
	fmul    $1, $3, $1
	load    [$2 + 2], $3
	fmul    $3, $4, $3
	fadd    $1, $3, $1
	load    [$2 + 3], $2
	fmul    $2, $5, $2
	fadd    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31034:
	load    [$2 + 0], $6
	fcmp    $6, $zero
	bne     be_else.31036
be_then.31036:
	li      0, $1
	ret
be_else.31036:
	load    [$1 + 4], $8
	load    [$1 + 4], $9
	load    [$1 + 4], $10
	load    [$1 + 3], $11
	load    [$2 + 1], $12
	fmul    $12, $3, $12
	load    [$2 + 2], $13
	fmul    $13, $4, $13
	fadd    $12, $13, $12
	load    [$2 + 3], $13
	fmul    $13, $5, $13
	fadd    $12, $13, $12
	fmul    $12, $12, $13
	fmul    $3, $3, $14
	load    [$8 + 0], $8
	fmul    $14, $8, $8
	fmul    $4, $4, $14
	load    [$9 + 1], $9
	fmul    $14, $9, $9
	fadd    $8, $9, $8
	fmul    $5, $5, $9
	load    [$10 + 2], $10
	fmul    $9, $10, $9
	fadd    $8, $9, $8
	cmp     $11, 0
	bne     be_else.31037
be_then.31037:
	mov     $8, $3
	b       be_cont.31037
be_else.31037:
	fmul    $4, $5, $9
	load    [$1 + 9], $10
	load    [$10 + 0], $10
	fmul    $9, $10, $9
	fadd    $8, $9, $8
	fmul    $5, $3, $5
	load    [$1 + 9], $9
	load    [$9 + 1], $9
	fmul    $5, $9, $5
	fadd    $8, $5, $5
	fmul    $3, $4, $3
	load    [$1 + 9], $4
	load    [$4 + 2], $4
	fmul    $3, $4, $3
	fadd    $5, $3, $3
be_cont.31037:
	cmp     $7, 3
	bne     be_cont.31038
be_then.31038:
	fsub    $3, $36, $3
be_cont.31038:
	fmul    $6, $3, $3
	fsub    $13, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31039
ble_then.31039:
	li      0, $1
	ret
ble_else.31039:
	load    [$1 + 6], $1
	cmp     $1, 0
	load    [$2 + 4], $2
	fsqrt   $3, $1
	bne     be_else.31040
be_then.31040:
	fsub    $12, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31040:
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
	load    [$1 + 10], $4
	load    [$3 + 1], $5
	load    [$1 + 1], $6
	load    [$4 + 0], $7
	load    [$4 + 1], $8
	load    [$4 + 2], $9
	load    [$5 + $2], $2
	cmp     $6, 1
	bne     be_else.31041
be_then.31041:
	load    [$3 + 0], $3
	load    [$1 + 4], $4
	load    [$4 + 1], $4
	load    [$3 + 1], $5
	load    [$2 + 0], $6
	fsub    $6, $7, $6
	load    [$2 + 1], $10
	fmul    $6, $10, $6
	fmul    $6, $5, $5
	fadd    $5, $8, $5
	fabs    $5, $5
	fcmp    $4, $5
	bg      ble_else.31042
ble_then.31042:
	li      0, $5
	b       ble_cont.31042
ble_else.31042:
	load    [$1 + 4], $5
	load    [$5 + 2], $5
	load    [$3 + 2], $10
	fmul    $6, $10, $10
	fadd    $10, $9, $10
	fabs    $10, $10
	fcmp    $5, $10
	bg      ble_else.31043
ble_then.31043:
	li      0, $5
	b       ble_cont.31043
ble_else.31043:
	load    [$2 + 1], $5
	fcmp    $5, $zero
	bne     be_else.31044
be_then.31044:
	li      0, $5
	b       be_cont.31044
be_else.31044:
	li      1, $5
be_cont.31044:
ble_cont.31043:
ble_cont.31042:
	cmp     $5, 0
	bne     be_else.31045
be_then.31045:
	load    [$1 + 4], $5
	load    [$5 + 0], $5
	load    [$3 + 0], $6
	load    [$2 + 2], $10
	fsub    $10, $8, $10
	load    [$2 + 3], $11
	fmul    $10, $11, $10
	fmul    $10, $6, $6
	fadd    $6, $7, $6
	fabs    $6, $6
	fcmp    $5, $6
	bg      ble_else.31046
ble_then.31046:
	li      0, $1
	b       ble_cont.31046
ble_else.31046:
	load    [$1 + 4], $1
	load    [$1 + 2], $1
	load    [$3 + 2], $6
	fmul    $10, $6, $6
	fadd    $6, $9, $6
	fabs    $6, $6
	fcmp    $1, $6
	bg      ble_else.31047
ble_then.31047:
	li      0, $1
	b       ble_cont.31047
ble_else.31047:
	load    [$2 + 3], $1
	fcmp    $1, $zero
	bne     be_else.31048
be_then.31048:
	li      0, $1
	b       be_cont.31048
be_else.31048:
	li      1, $1
be_cont.31048:
ble_cont.31047:
ble_cont.31046:
	cmp     $1, 0
	bne     be_else.31049
be_then.31049:
	load    [$3 + 0], $1
	load    [$2 + 4], $6
	fsub    $6, $9, $6
	load    [$2 + 5], $9
	fmul    $6, $9, $6
	fmul    $6, $1, $1
	fadd    $1, $7, $1
	fabs    $1, $1
	fcmp    $5, $1
	bg      ble_else.31050
ble_then.31050:
	li      0, $1
	ret
ble_else.31050:
	load    [$3 + 1], $1
	fmul    $6, $1, $1
	fadd    $1, $8, $1
	fabs    $1, $1
	fcmp    $4, $1
	bg      ble_else.31051
ble_then.31051:
	li      0, $1
	ret
ble_else.31051:
	load    [$2 + 5], $1
	fcmp    $1, $zero
	bne     be_else.31052
be_then.31052:
	li      0, $1
	ret
be_else.31052:
.count move_float
	mov     $6, $42
	li      3, $1
	ret
be_else.31049:
.count move_float
	mov     $10, $42
	li      2, $1
	ret
be_else.31045:
.count move_float
	mov     $6, $42
	li      1, $1
	ret
be_else.31041:
	cmp     $6, 2
	bne     be_else.31053
be_then.31053:
	load    [$2 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31054
ble_then.31054:
	li      0, $1
	ret
ble_else.31054:
	load    [$4 + 3], $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31053:
	load    [$2 + 0], $3
	fcmp    $3, $zero
	bne     be_else.31055
be_then.31055:
	li      0, $1
	ret
be_else.31055:
	load    [$2 + 1], $5
	fmul    $5, $7, $5
	load    [$2 + 2], $6
	fmul    $6, $8, $6
	fadd    $5, $6, $5
	load    [$2 + 3], $6
	fmul    $6, $9, $6
	fadd    $5, $6, $5
	fmul    $5, $5, $6
	load    [$4 + 3], $4
	fmul    $3, $4, $3
	fsub    $6, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31056
ble_then.31056:
	li      0, $1
	ret
ble_else.31056:
	load    [$1 + 6], $1
	cmp     $1, 0
	load    [$2 + 4], $2
	fsqrt   $3, $1
	bne     be_else.31057
be_then.31057:
	fsub    $5, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31057:
	fadd    $5, $1, $1
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
	bl      bge_else.31058
bge_then.31058:
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 1], $10
	load    [min_caml_objects + $3], $11
	load    [$11 + 1], $12
	load    [$2 + 0], $13
	cmp     $12, 1
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count move_args
	mov     $zero, $3
	bne     be_else.31059
be_then.31059:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	load    [$13 + 0], $14
	fcmp    $14, $zero
	bne     be_else.31060
be_then.31060:
	store   $zero, [$12 + 1]
	b       be_cont.31060
be_else.31060:
	load    [$11 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31061
ble_then.31061:
	li      0, $14
	b       ble_cont.31061
ble_else.31061:
	li      1, $14
ble_cont.31061:
	cmp     $15, 0
	be      bne_cont.31062
bne_then.31062:
	cmp     $14, 0
	bne     be_else.31063
be_then.31063:
	li      1, $14
	b       be_cont.31063
be_else.31063:
	li      0, $14
be_cont.31063:
bne_cont.31062:
	load    [$11 + 4], $15
	load    [$15 + 0], $15
	cmp     $14, 0
	bne     be_else.31064
be_then.31064:
	fneg    $15, $14
	store   $14, [$12 + 0]
	load    [$13 + 0], $14
	finv    $14, $14
	store   $14, [$12 + 1]
	b       be_cont.31064
be_else.31064:
	store   $15, [$12 + 0]
	load    [$13 + 0], $14
	finv    $14, $14
	store   $14, [$12 + 1]
be_cont.31064:
be_cont.31060:
	load    [$13 + 1], $14
	fcmp    $14, $zero
	bne     be_else.31065
be_then.31065:
	store   $zero, [$12 + 3]
	b       be_cont.31065
be_else.31065:
	load    [$11 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31066
ble_then.31066:
	li      0, $14
	b       ble_cont.31066
ble_else.31066:
	li      1, $14
ble_cont.31066:
	cmp     $15, 0
	be      bne_cont.31067
bne_then.31067:
	cmp     $14, 0
	bne     be_else.31068
be_then.31068:
	li      1, $14
	b       be_cont.31068
be_else.31068:
	li      0, $14
be_cont.31068:
bne_cont.31067:
	load    [$11 + 4], $15
	load    [$15 + 1], $15
	cmp     $14, 0
	bne     be_else.31069
be_then.31069:
	fneg    $15, $14
	store   $14, [$12 + 2]
	load    [$13 + 1], $14
	finv    $14, $14
	store   $14, [$12 + 3]
	b       be_cont.31069
be_else.31069:
	store   $15, [$12 + 2]
	load    [$13 + 1], $14
	finv    $14, $14
	store   $14, [$12 + 3]
be_cont.31069:
be_cont.31065:
	load    [$13 + 2], $14
	fcmp    $14, $zero
	bne     be_else.31070
be_then.31070:
	store   $zero, [$12 + 5]
	mov     $12, $11
	b       be_cont.31070
be_else.31070:
	load    [$11 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31071
ble_then.31071:
	li      0, $14
	b       ble_cont.31071
ble_else.31071:
	li      1, $14
ble_cont.31071:
	cmp     $15, 0
	be      bne_cont.31072
bne_then.31072:
	cmp     $14, 0
	bne     be_else.31073
be_then.31073:
	li      1, $14
	b       be_cont.31073
be_else.31073:
	li      0, $14
be_cont.31073:
bne_cont.31072:
	load    [$11 + 4], $11
	load    [$11 + 2], $11
	cmp     $14, 0
	bne     be_else.31074
be_then.31074:
	fneg    $11, $11
	store   $11, [$12 + 4]
	load    [$13 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
	b       be_cont.31074
be_else.31074:
	store   $11, [$12 + 4]
	load    [$13 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
be_cont.31074:
be_cont.31070:
.count stack_load
	load    [$sp + 1], $12
.count storer
	add     $10, $12, $tmp
	store   $11, [$tmp + 0]
	sub     $12, 1, $11
	cmp     $11, 0
	bl      bge_else.31075
bge_then.31075:
	load    [min_caml_objects + $11], $12
	load    [$12 + 1], $14
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31076
be_then.31076:
	li      6, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$13 + 0], $2
	fcmp    $2, $zero
	bne     be_else.31077
be_then.31077:
	store   $zero, [$1 + 1]
	b       be_cont.31077
be_else.31077:
	load    [$12 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31078
ble_then.31078:
	li      0, $2
	b       ble_cont.31078
ble_else.31078:
	li      1, $2
ble_cont.31078:
	cmp     $3, 0
	be      bne_cont.31079
bne_then.31079:
	cmp     $2, 0
	bne     be_else.31080
be_then.31080:
	li      1, $2
	b       be_cont.31080
be_else.31080:
	li      0, $2
be_cont.31080:
bne_cont.31079:
	load    [$12 + 4], $3
	load    [$3 + 0], $3
	cmp     $2, 0
	bne     be_else.31081
be_then.31081:
	fneg    $3, $2
	store   $2, [$1 + 0]
	load    [$13 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
	b       be_cont.31081
be_else.31081:
	store   $3, [$1 + 0]
	load    [$13 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
be_cont.31081:
be_cont.31077:
	load    [$13 + 1], $2
	fcmp    $2, $zero
	bne     be_else.31082
be_then.31082:
	store   $zero, [$1 + 3]
	b       be_cont.31082
be_else.31082:
	load    [$12 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31083
ble_then.31083:
	li      0, $2
	b       ble_cont.31083
ble_else.31083:
	li      1, $2
ble_cont.31083:
	cmp     $3, 0
	be      bne_cont.31084
bne_then.31084:
	cmp     $2, 0
	bne     be_else.31085
be_then.31085:
	li      1, $2
	b       be_cont.31085
be_else.31085:
	li      0, $2
be_cont.31085:
bne_cont.31084:
	load    [$12 + 4], $3
	load    [$3 + 1], $3
	cmp     $2, 0
	bne     be_else.31086
be_then.31086:
	fneg    $3, $2
	store   $2, [$1 + 2]
	load    [$13 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
	b       be_cont.31086
be_else.31086:
	store   $3, [$1 + 2]
	load    [$13 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
be_cont.31086:
be_cont.31082:
	load    [$13 + 2], $2
	fcmp    $2, $zero
	bne     be_else.31087
be_then.31087:
	store   $zero, [$1 + 5]
.count storer
	add     $10, $11, $tmp
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31087:
	load    [$12 + 6], $3
	load    [$12 + 4], $4
	fcmp    $zero, $2
	bg      ble_else.31088
ble_then.31088:
	li      0, $2
	b       ble_cont.31088
ble_else.31088:
	li      1, $2
ble_cont.31088:
	cmp     $3, 0
	be      bne_cont.31089
bne_then.31089:
	cmp     $2, 0
	bne     be_else.31090
be_then.31090:
	li      1, $2
	b       be_cont.31090
be_else.31090:
	li      0, $2
be_cont.31090:
bne_cont.31089:
	load    [$4 + 2], $3
	cmp     $2, 0
	bne     be_else.31091
be_then.31091:
	fneg    $3, $2
	b       be_cont.31091
be_else.31091:
	mov     $3, $2
be_cont.31091:
	store   $2, [$1 + 4]
	load    [$13 + 2], $2
	finv    $2, $2
	store   $2, [$1 + 5]
.count storer
	add     $10, $11, $tmp
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31076:
	cmp     $14, 2
	bne     be_else.31092
be_then.31092:
	li      4, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$12 + 4], $2
	load    [$12 + 4], $3
	load    [$12 + 4], $4
	load    [$13 + 0], $5
	load    [$2 + 0], $2
	fmul    $5, $2, $2
	load    [$13 + 1], $5
	load    [$3 + 1], $3
	fmul    $5, $3, $3
	fadd    $2, $3, $2
	load    [$13 + 2], $3
	load    [$4 + 2], $4
	fmul    $3, $4, $3
	fadd    $2, $3, $2
	fcmp    $2, $zero
.count storer
	add     $10, $11, $tmp
	bg      ble_else.31093
ble_then.31093:
	store   $zero, [$1 + 0]
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.31093:
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
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31092:
	li      5, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$12 + 3], $2
	load    [$12 + 4], $3
	load    [$12 + 4], $4
	load    [$12 + 4], $5
	load    [$13 + 0], $6
	load    [$13 + 1], $7
	load    [$13 + 2], $8
	fmul    $6, $6, $9
	load    [$3 + 0], $3
	fmul    $9, $3, $3
	fmul    $7, $7, $9
	load    [$4 + 1], $4
	fmul    $9, $4, $4
	fadd    $3, $4, $3
	fmul    $8, $8, $4
	load    [$5 + 2], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	cmp     $2, 0
	be      bne_cont.31094
bne_then.31094:
	fmul    $7, $8, $4
	load    [$12 + 9], $5
	load    [$5 + 0], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	fmul    $8, $6, $4
	load    [$12 + 9], $5
	load    [$5 + 1], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	fmul    $6, $7, $4
	load    [$12 + 9], $5
	load    [$5 + 2], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
bne_cont.31094:
	store   $3, [$1 + 0]
	load    [$12 + 4], $4
	load    [$12 + 4], $5
	load    [$12 + 4], $6
	load    [$13 + 0], $7
	load    [$4 + 0], $4
	fmul    $7, $4, $4
	load    [$13 + 1], $7
	load    [$5 + 1], $5
	fmul    $7, $5, $5
	load    [$13 + 2], $8
	load    [$6 + 2], $6
	fmul    $8, $6, $6
	fneg    $4, $4
	fneg    $5, $5
	fneg    $6, $6
	cmp     $2, 0
.count storer
	add     $10, $11, $tmp
	bne     be_else.31095
be_then.31095:
	store   $4, [$1 + 1]
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	fcmp    $3, $zero
	bne     be_else.31096
be_then.31096:
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31096:
	finv    $3, $2
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31095:
	load    [$12 + 9], $2
	load    [$12 + 9], $9
	load    [$2 + 1], $2
	fmul    $8, $2, $8
	load    [$9 + 2], $9
	fmul    $7, $9, $7
	fadd    $8, $7, $7
	fmul    $7, $39, $7
	fsub    $4, $7, $4
	store   $4, [$1 + 1]
	load    [$12 + 9], $4
	load    [$13 + 2], $7
	load    [$4 + 0], $4
	fmul    $7, $4, $7
	load    [$13 + 0], $8
	fmul    $8, $9, $8
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $5, $7, $5
	store   $5, [$1 + 2]
	load    [$13 + 1], $5
	fmul    $5, $4, $4
	load    [$13 + 0], $5
	fmul    $5, $2, $2
	fadd    $4, $2, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	fcmp    $3, $zero
	bne     be_else.31097
be_then.31097:
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31097:
	finv    $3, $2
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
	sub     $11, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31075:
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.31059:
	cmp     $12, 2
	bne     be_else.31098
be_then.31098:
	li      4, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$11 + 4], $2
	load    [$11 + 4], $3
	load    [$11 + 4], $4
	load    [$13 + 0], $5
	load    [$2 + 0], $2
	fmul    $5, $2, $2
	load    [$13 + 1], $5
	load    [$3 + 1], $3
	fmul    $5, $3, $3
	fadd    $2, $3, $2
	load    [$13 + 2], $3
	load    [$4 + 2], $4
	fmul    $3, $4, $3
	fadd    $2, $3, $2
	fcmp    $2, $zero
	bg      ble_else.31099
ble_then.31099:
	store   $zero, [$1 + 0]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.31099:
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
	load    [$3 + 2], $3
	fmul    $3, $2, $2
	fneg    $2, $2
	store   $2, [$1 + 3]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31098:
	li      5, $2
	call    min_caml_create_array
.count stack_move
	add     $sp, 2, $sp
	load    [$11 + 3], $2
	load    [$11 + 4], $3
	load    [$11 + 4], $4
	load    [$11 + 4], $5
	load    [$13 + 0], $6
	load    [$13 + 1], $7
	load    [$13 + 2], $8
	fmul    $6, $6, $9
	load    [$3 + 0], $3
	fmul    $9, $3, $3
	fmul    $7, $7, $9
	load    [$4 + 1], $4
	fmul    $9, $4, $4
	fadd    $3, $4, $3
	fmul    $8, $8, $4
	load    [$5 + 2], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	cmp     $2, 0
	be      bne_cont.31100
bne_then.31100:
	fmul    $7, $8, $4
	load    [$11 + 9], $5
	load    [$5 + 0], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	fmul    $8, $6, $4
	load    [$11 + 9], $5
	load    [$5 + 1], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	fmul    $6, $7, $4
	load    [$11 + 9], $5
	load    [$5 + 2], $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
bne_cont.31100:
	store   $3, [$1 + 0]
	load    [$11 + 4], $4
	load    [$11 + 4], $5
	load    [$11 + 4], $6
	load    [$13 + 0], $7
	load    [$4 + 0], $4
	fmul    $7, $4, $4
	load    [$13 + 1], $7
	load    [$5 + 1], $5
	fmul    $7, $5, $5
	load    [$13 + 2], $8
	load    [$6 + 2], $6
	fmul    $8, $6, $6
	fneg    $4, $4
	fneg    $5, $5
	fneg    $6, $6
	cmp     $2, 0
	bne     be_else.31101
be_then.31101:
	store   $4, [$1 + 1]
	store   $5, [$1 + 2]
	store   $6, [$1 + 3]
	fcmp    $3, $zero
	bne     be_else.31102
be_then.31102:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31102:
	finv    $3, $2
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31101:
	load    [$11 + 9], $2
	load    [$11 + 9], $9
	load    [$2 + 1], $2
	fmul    $8, $2, $8
	load    [$9 + 2], $9
	fmul    $7, $9, $7
	fadd    $8, $7, $7
	fmul    $7, $39, $7
	fsub    $4, $7, $4
	store   $4, [$1 + 1]
	load    [$11 + 9], $4
	load    [$13 + 2], $7
	load    [$4 + 0], $4
	fmul    $7, $4, $7
	load    [$13 + 0], $8
	fmul    $8, $9, $8
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $5, $7, $5
	store   $5, [$1 + 2]
	load    [$13 + 1], $5
	fmul    $5, $4, $4
	load    [$13 + 0], $5
	fmul    $5, $2, $2
	fadd    $4, $2, $2
	fmul    $2, $39, $2
	fsub    $6, $2, $2
	store   $2, [$1 + 3]
	fcmp    $3, $zero
	bne     be_else.31103
be_then.31103:
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31103:
	finv    $3, $2
	store   $2, [$1 + 4]
.count stack_load
	load    [$sp - 1], $2
.count storer
	add     $10, $2, $tmp
	store   $1, [$tmp + 0]
	sub     $2, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31058:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	cmp     $3, 0
	bl      bge_else.31104
bge_then.31104:
	load    [min_caml_objects + $3], $1
	load    [$1 + 5], $4
	load    [$1 + 10], $5
	load    [$2 + 0], $6
	load    [$4 + 0], $4
	fsub    $6, $4, $4
	store   $4, [$5 + 0]
	load    [$1 + 5], $4
	load    [$2 + 1], $6
	load    [$4 + 1], $4
	fsub    $6, $4, $4
	store   $4, [$5 + 1]
	load    [$1 + 5], $4
	load    [$2 + 2], $6
	load    [$4 + 2], $4
	fsub    $6, $4, $4
	store   $4, [$5 + 2]
	load    [$1 + 1], $4
	cmp     $4, 2
	bne     be_else.31105
be_then.31105:
	load    [$1 + 4], $1
	load    [$5 + 0], $4
	load    [$1 + 0], $6
	fmul    $6, $4, $4
	load    [$5 + 1], $6
	load    [$1 + 1], $7
	fmul    $7, $6, $6
	fadd    $4, $6, $4
	load    [$5 + 2], $6
	load    [$1 + 2], $1
	fmul    $1, $6, $1
	fadd    $4, $1, $1
	store   $1, [$5 + 3]
	sub     $3, 1, $3
	b       setup_startp_constants.2831
be_else.31105:
	cmp     $4, 2
	bg      ble_else.31106
ble_then.31106:
	sub     $3, 1, $3
	b       setup_startp_constants.2831
ble_else.31106:
	load    [$1 + 4], $6
	load    [$1 + 4], $7
	load    [$1 + 4], $8
	load    [$1 + 3], $9
	load    [$5 + 0], $10
	load    [$5 + 1], $11
	load    [$5 + 2], $12
	fmul    $10, $10, $13
	load    [$6 + 0], $6
	fmul    $13, $6, $6
	fmul    $11, $11, $13
	load    [$7 + 1], $7
	fmul    $13, $7, $7
	fadd    $6, $7, $6
	fmul    $12, $12, $7
	load    [$8 + 2], $8
	fmul    $7, $8, $7
	fadd    $6, $7, $6
	cmp     $9, 0
	bne     be_else.31107
be_then.31107:
	mov     $6, $1
	b       be_cont.31107
be_else.31107:
	load    [$1 + 9], $7
	load    [$1 + 9], $8
	load    [$1 + 9], $1
	fmul    $11, $12, $9
	load    [$7 + 0], $7
	fmul    $9, $7, $7
	fadd    $6, $7, $6
	fmul    $12, $10, $7
	load    [$8 + 1], $8
	fmul    $7, $8, $7
	fadd    $6, $7, $6
	fmul    $10, $11, $7
	load    [$1 + 2], $1
	fmul    $7, $1, $1
	fadd    $6, $1, $1
be_cont.31107:
	cmp     $4, 3
	sub     $3, 1, $3
	bne     be_else.31108
be_then.31108:
	fsub    $1, $36, $1
	store   $1, [$5 + 3]
	b       setup_startp_constants.2831
be_else.31108:
	store   $1, [$5 + 3]
	b       setup_startp_constants.2831
bge_else.31104:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$3 + $2], $1
	cmp     $1, -1
	bne     be_else.31109
be_then.31109:
	li      1, $1
	ret
be_else.31109:
	load    [min_caml_objects + $1], $1
	load    [$1 + 1], $7
	load    [$1 + 5], $8
	load    [$1 + 5], $9
	load    [$1 + 5], $10
	load    [$8 + 0], $8
	fsub    $4, $8, $8
	load    [$9 + 1], $9
	fsub    $5, $9, $9
	load    [$10 + 2], $10
	fsub    $6, $10, $10
	cmp     $7, 1
	bne     be_else.31110
be_then.31110:
	load    [$1 + 4], $7
	load    [$7 + 0], $7
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31111
ble_then.31111:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31112
be_then.31112:
	li      1, $1
	b       be_cont.31110
be_else.31112:
	li      0, $1
	b       be_cont.31110
ble_else.31111:
	load    [$1 + 4], $7
	load    [$7 + 1], $7
	fabs    $9, $8
	fcmp    $7, $8
	bg      ble_else.31113
ble_then.31113:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31114
be_then.31114:
	li      1, $1
	b       be_cont.31110
be_else.31114:
	li      0, $1
	b       be_cont.31110
ble_else.31113:
	load    [$1 + 4], $7
	load    [$7 + 2], $7
	fabs    $10, $8
	fcmp    $7, $8
	load    [$1 + 6], $1
	bg      be_cont.31110
ble_then.31115:
	cmp     $1, 0
	bne     be_else.31116
be_then.31116:
	li      1, $1
	b       be_cont.31110
be_else.31116:
	li      0, $1
	b       be_cont.31110
be_else.31110:
	cmp     $7, 2
	bne     be_else.31117
be_then.31117:
	load    [$1 + 6], $7
	load    [$1 + 4], $1
	load    [$1 + 0], $11
	fmul    $11, $8, $8
	load    [$1 + 1], $11
	fmul    $11, $9, $9
	fadd    $8, $9, $8
	load    [$1 + 2], $1
	fmul    $1, $10, $1
	fadd    $8, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31118
ble_then.31118:
	cmp     $7, 0
	bne     be_else.31119
be_then.31119:
	li      1, $1
	b       be_cont.31117
be_else.31119:
	li      0, $1
	b       be_cont.31117
ble_else.31118:
	cmp     $7, 0
	bne     be_else.31120
be_then.31120:
	li      0, $1
	b       be_cont.31117
be_else.31120:
	li      1, $1
	b       be_cont.31117
be_else.31117:
	load    [$1 + 6], $11
	fmul    $8, $8, $12
	load    [$1 + 4], $13
	load    [$13 + 0], $13
	fmul    $12, $13, $12
	fmul    $9, $9, $13
	load    [$1 + 4], $14
	load    [$14 + 1], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	fmul    $10, $10, $13
	load    [$1 + 4], $14
	load    [$14 + 2], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	load    [$1 + 3], $13
	cmp     $13, 0
	bne     be_else.31121
be_then.31121:
	mov     $12, $1
	b       be_cont.31121
be_else.31121:
	fmul    $9, $10, $13
	load    [$1 + 9], $14
	load    [$14 + 0], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	fmul    $10, $8, $10
	load    [$1 + 9], $13
	load    [$13 + 1], $13
	fmul    $10, $13, $10
	fadd    $12, $10, $10
	fmul    $8, $9, $8
	load    [$1 + 9], $1
	load    [$1 + 2], $1
	fmul    $8, $1, $1
	fadd    $10, $1, $1
be_cont.31121:
	cmp     $7, 3
	bne     be_cont.31122
be_then.31122:
	fsub    $1, $36, $1
be_cont.31122:
	fcmp    $zero, $1
	bg      ble_else.31123
ble_then.31123:
	cmp     $11, 0
	bne     be_else.31124
be_then.31124:
	li      1, $1
	b       ble_cont.31123
be_else.31124:
	li      0, $1
	b       ble_cont.31123
ble_else.31123:
	cmp     $11, 0
	bne     be_else.31125
be_then.31125:
	li      0, $1
	b       be_cont.31125
be_else.31125:
	li      1, $1
be_cont.31125:
ble_cont.31123:
be_cont.31117:
be_cont.31110:
	cmp     $1, 0
	bne     be_else.31126
be_then.31126:
	add     $2, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31127
be_then.31127:
	li      1, $1
	ret
be_else.31127:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$2 + 1], $10
	load    [$7 + 0], $7
	fsub    $4, $7, $7
	load    [$8 + 1], $8
	fsub    $5, $8, $8
	load    [$9 + 2], $9
	fsub    $6, $9, $9
	cmp     $10, 1
	bne     be_else.31128
be_then.31128:
	load    [$2 + 4], $10
	load    [$10 + 0], $10
	fabs    $7, $7
	fcmp    $10, $7
	bg      ble_else.31129
ble_then.31129:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31130
be_then.31130:
	li      1, $2
	b       be_cont.31128
be_else.31130:
	li      0, $2
	b       be_cont.31128
ble_else.31129:
	load    [$2 + 4], $7
	load    [$7 + 1], $7
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31131
ble_then.31131:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31132
be_then.31132:
	li      1, $2
	b       be_cont.31128
be_else.31132:
	li      0, $2
	b       be_cont.31128
ble_else.31131:
	load    [$2 + 4], $7
	load    [$7 + 2], $7
	fabs    $9, $8
	fcmp    $7, $8
	load    [$2 + 6], $2
	bg      be_cont.31128
ble_then.31133:
	cmp     $2, 0
	bne     be_else.31134
be_then.31134:
	li      1, $2
	b       be_cont.31128
be_else.31134:
	li      0, $2
	b       be_cont.31128
be_else.31128:
	cmp     $10, 2
	load    [$2 + 6], $10
	bne     be_else.31135
be_then.31135:
	load    [$2 + 4], $2
	load    [$2 + 0], $11
	fmul    $11, $7, $7
	load    [$2 + 1], $11
	fmul    $11, $8, $8
	fadd    $7, $8, $7
	load    [$2 + 2], $2
	fmul    $2, $9, $2
	fadd    $7, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31136
ble_then.31136:
	cmp     $10, 0
	bne     be_else.31137
be_then.31137:
	li      1, $2
	b       be_cont.31135
be_else.31137:
	li      0, $2
	b       be_cont.31135
ble_else.31136:
	cmp     $10, 0
	bne     be_else.31138
be_then.31138:
	li      0, $2
	b       be_cont.31135
be_else.31138:
	li      1, $2
	b       be_cont.31135
be_else.31135:
	load    [$2 + 1], $11
	load    [$2 + 4], $12
	load    [$2 + 4], $13
	load    [$2 + 4], $14
	load    [$2 + 3], $15
	fmul    $7, $7, $16
	load    [$12 + 0], $12
	fmul    $16, $12, $12
	fmul    $8, $8, $16
	load    [$13 + 1], $13
	fmul    $16, $13, $13
	fadd    $12, $13, $12
	fmul    $9, $9, $13
	load    [$14 + 2], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	cmp     $15, 0
	bne     be_else.31139
be_then.31139:
	mov     $12, $2
	b       be_cont.31139
be_else.31139:
	load    [$2 + 9], $13
	load    [$2 + 9], $14
	load    [$2 + 9], $2
	fmul    $8, $9, $15
	load    [$13 + 0], $13
	fmul    $15, $13, $13
	fadd    $12, $13, $12
	fmul    $9, $7, $9
	load    [$14 + 1], $13
	fmul    $9, $13, $9
	fadd    $12, $9, $9
	fmul    $7, $8, $7
	load    [$2 + 2], $2
	fmul    $7, $2, $2
	fadd    $9, $2, $2
be_cont.31139:
	cmp     $11, 3
	bne     be_cont.31140
be_then.31140:
	fsub    $2, $36, $2
be_cont.31140:
	fcmp    $zero, $2
	bg      ble_else.31141
ble_then.31141:
	cmp     $10, 0
	bne     be_else.31142
be_then.31142:
	li      1, $2
	b       ble_cont.31141
be_else.31142:
	li      0, $2
	b       ble_cont.31141
ble_else.31141:
	cmp     $10, 0
	bne     be_else.31143
be_then.31143:
	li      0, $2
	b       be_cont.31143
be_else.31143:
	li      1, $2
be_cont.31143:
ble_cont.31141:
be_cont.31135:
be_cont.31128:
	cmp     $2, 0
	bne     be_else.31144
be_then.31144:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31145
be_then.31145:
	li      1, $1
	ret
be_else.31145:
	load    [min_caml_objects + $2], $2
	load    [$2 + 1], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$2 + 5], $10
	load    [$8 + 0], $8
	fsub    $4, $8, $8
	load    [$9 + 1], $9
	fsub    $5, $9, $9
	load    [$10 + 2], $10
	fsub    $6, $10, $10
	cmp     $7, 1
	bne     be_else.31146
be_then.31146:
	load    [$2 + 4], $7
	load    [$7 + 0], $7
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31147
ble_then.31147:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31148
be_then.31148:
	li      1, $2
	b       be_cont.31146
be_else.31148:
	li      0, $2
	b       be_cont.31146
ble_else.31147:
	load    [$2 + 4], $7
	load    [$7 + 1], $7
	fabs    $9, $8
	fcmp    $7, $8
	bg      ble_else.31149
ble_then.31149:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31150
be_then.31150:
	li      1, $2
	b       be_cont.31146
be_else.31150:
	li      0, $2
	b       be_cont.31146
ble_else.31149:
	load    [$2 + 4], $7
	load    [$7 + 2], $7
	fabs    $10, $8
	fcmp    $7, $8
	load    [$2 + 6], $2
	bg      be_cont.31146
ble_then.31151:
	cmp     $2, 0
	bne     be_else.31152
be_then.31152:
	li      1, $2
	b       be_cont.31146
be_else.31152:
	li      0, $2
	b       be_cont.31146
be_else.31146:
	cmp     $7, 2
	load    [$2 + 6], $7
	bne     be_else.31153
be_then.31153:
	load    [$2 + 4], $2
	load    [$2 + 0], $11
	fmul    $11, $8, $8
	load    [$2 + 1], $11
	fmul    $11, $9, $9
	fadd    $8, $9, $8
	load    [$2 + 2], $2
	fmul    $2, $10, $2
	fadd    $8, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31154
ble_then.31154:
	cmp     $7, 0
	bne     be_else.31155
be_then.31155:
	li      1, $2
	b       be_cont.31153
be_else.31155:
	li      0, $2
	b       be_cont.31153
ble_else.31154:
	cmp     $7, 0
	bne     be_else.31156
be_then.31156:
	li      0, $2
	b       be_cont.31153
be_else.31156:
	li      1, $2
	b       be_cont.31153
be_else.31153:
	load    [$2 + 1], $11
	load    [$2 + 3], $12
	fmul    $8, $8, $13
	load    [$2 + 4], $14
	load    [$14 + 0], $14
	fmul    $13, $14, $13
	fmul    $9, $9, $14
	load    [$2 + 4], $15
	load    [$15 + 1], $15
	fmul    $14, $15, $14
	fadd    $13, $14, $13
	fmul    $10, $10, $14
	load    [$2 + 4], $15
	load    [$15 + 2], $15
	fmul    $14, $15, $14
	fadd    $13, $14, $13
	cmp     $12, 0
	bne     be_else.31157
be_then.31157:
	mov     $13, $2
	b       be_cont.31157
be_else.31157:
	fmul    $9, $10, $12
	load    [$2 + 9], $14
	load    [$14 + 0], $14
	fmul    $12, $14, $12
	fadd    $13, $12, $12
	fmul    $10, $8, $10
	load    [$2 + 9], $13
	load    [$13 + 1], $13
	fmul    $10, $13, $10
	fadd    $12, $10, $10
	fmul    $8, $9, $8
	load    [$2 + 9], $2
	load    [$2 + 2], $2
	fmul    $8, $2, $2
	fadd    $10, $2, $2
be_cont.31157:
	cmp     $11, 3
	bne     be_cont.31158
be_then.31158:
	fsub    $2, $36, $2
be_cont.31158:
	fcmp    $zero, $2
	bg      ble_else.31159
ble_then.31159:
	cmp     $7, 0
	bne     be_else.31160
be_then.31160:
	li      1, $2
	b       ble_cont.31159
be_else.31160:
	li      0, $2
	b       ble_cont.31159
ble_else.31159:
	cmp     $7, 0
	bne     be_else.31161
be_then.31161:
	li      0, $2
	b       be_cont.31161
be_else.31161:
	li      1, $2
be_cont.31161:
ble_cont.31159:
be_cont.31153:
be_cont.31146:
	cmp     $2, 0
	bne     be_else.31162
be_then.31162:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31163
be_then.31163:
	li      1, $1
	ret
be_else.31163:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$2 + 1], $10
	load    [$7 + 0], $7
	load    [$8 + 1], $8
	load    [$9 + 2], $9
	fsub    $4, $7, $7
	fsub    $5, $8, $8
	fsub    $6, $9, $9
	cmp     $10, 1
	bne     be_else.31164
be_then.31164:
	load    [$2 + 4], $10
	load    [$10 + 0], $10
	fabs    $7, $7
	fcmp    $10, $7
	bg      ble_else.31165
ble_then.31165:
	li      0, $7
	b       ble_cont.31165
ble_else.31165:
	load    [$2 + 4], $7
	load    [$7 + 1], $7
	fabs    $8, $8
	fcmp    $7, $8
	bg      ble_else.31166
ble_then.31166:
	li      0, $7
	b       ble_cont.31166
ble_else.31166:
	load    [$2 + 4], $7
	load    [$7 + 2], $7
	fabs    $9, $8
	fcmp    $7, $8
	bg      ble_else.31167
ble_then.31167:
	li      0, $7
	b       ble_cont.31167
ble_else.31167:
	li      1, $7
ble_cont.31167:
ble_cont.31166:
ble_cont.31165:
	cmp     $7, 0
	load    [$2 + 6], $2
	bne     be_else.31168
be_then.31168:
	cmp     $2, 0
	bne     be_else.31169
be_then.31169:
	li      0, $1
	ret
be_else.31169:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31168:
	cmp     $2, 0
	bne     be_else.31170
be_then.31170:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31170:
	li      0, $1
	ret
be_else.31164:
	cmp     $10, 2
	bne     be_else.31171
be_then.31171:
	load    [$2 + 6], $10
	load    [$2 + 4], $2
	load    [$2 + 0], $11
	fmul    $11, $7, $7
	load    [$2 + 1], $11
	fmul    $11, $8, $8
	fadd    $7, $8, $7
	load    [$2 + 2], $2
	fmul    $2, $9, $2
	fadd    $7, $2, $2
	fcmp    $zero, $2
	bg      ble_else.31172
ble_then.31172:
	cmp     $10, 0
	bne     be_else.31173
be_then.31173:
	li      0, $1
	ret
be_else.31173:
	add     $1, 1, $2
	b       check_all_inside.2856
ble_else.31172:
	cmp     $10, 0
	bne     be_else.31174
be_then.31174:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31174:
	li      0, $1
	ret
be_else.31171:
	load    [$2 + 6], $11
	load    [$2 + 4], $12
	load    [$2 + 4], $13
	load    [$2 + 4], $14
	load    [$2 + 3], $15
	fmul    $7, $7, $16
	load    [$12 + 0], $12
	fmul    $16, $12, $12
	fmul    $8, $8, $16
	load    [$13 + 1], $13
	fmul    $16, $13, $13
	fadd    $12, $13, $12
	fmul    $9, $9, $13
	load    [$14 + 2], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	cmp     $15, 0
	bne     be_else.31175
be_then.31175:
	mov     $12, $2
	b       be_cont.31175
be_else.31175:
	fmul    $8, $9, $13
	load    [$2 + 9], $14
	load    [$14 + 0], $14
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	fmul    $9, $7, $9
	load    [$2 + 9], $13
	load    [$13 + 1], $13
	fmul    $9, $13, $9
	fadd    $12, $9, $9
	fmul    $7, $8, $7
	load    [$2 + 9], $2
	load    [$2 + 2], $2
	fmul    $7, $2, $2
	fadd    $9, $2, $2
be_cont.31175:
	cmp     $10, 3
	bne     be_cont.31176
be_then.31176:
	fsub    $2, $36, $2
be_cont.31176:
	fcmp    $zero, $2
	bg      ble_else.31177
ble_then.31177:
	cmp     $11, 0
	bne     be_else.31178
be_then.31178:
	li      0, $1
	ret
be_else.31178:
	add     $1, 1, $2
	b       check_all_inside.2856
ble_else.31177:
	cmp     $11, 0
	bne     be_else.31179
be_then.31179:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31179:
	li      0, $1
	ret
be_else.31162:
	li      0, $1
	ret
be_else.31144:
	li      0, $1
	ret
be_else.31126:
	li      0, $1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$3 + $2], $17
	cmp     $17, -1
	bne     be_else.31180
be_then.31180:
	li      0, $1
	ret
be_else.31180:
	load    [min_caml_objects + $17], $18
	load    [$18 + 5], $19
	load    [$18 + 5], $20
	load    [$18 + 5], $21
	load    [min_caml_light_dirvec + 1], $22
	load    [$18 + 1], $23
	load    [min_caml_intersection_point + 0], $24
	load    [$19 + 0], $19
	fsub    $24, $19, $19
	load    [min_caml_intersection_point + 1], $24
	load    [$20 + 1], $20
	fsub    $24, $20, $20
	load    [min_caml_intersection_point + 2], $24
	load    [$21 + 2], $21
	fsub    $24, $21, $21
	load    [$22 + $17], $22
	cmp     $23, 1
	bne     be_else.31181
be_then.31181:
	load    [min_caml_light_dirvec + 0], $23
	load    [$18 + 4], $24
	load    [$24 + 1], $24
	load    [$23 + 1], $25
	load    [$22 + 0], $26
	fsub    $26, $19, $26
	load    [$22 + 1], $27
	fmul    $26, $27, $26
	fmul    $26, $25, $25
	fadd    $25, $20, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31182
ble_then.31182:
	li      0, $24
	b       ble_cont.31182
ble_else.31182:
	load    [$18 + 4], $24
	load    [$24 + 2], $24
	load    [$23 + 2], $25
	fmul    $26, $25, $25
	fadd    $25, $21, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31183
ble_then.31183:
	li      0, $24
	b       ble_cont.31183
ble_else.31183:
	load    [$22 + 1], $24
	fcmp    $24, $zero
	bne     be_else.31184
be_then.31184:
	li      0, $24
	b       be_cont.31184
be_else.31184:
	li      1, $24
be_cont.31184:
ble_cont.31183:
ble_cont.31182:
	cmp     $24, 0
	bne     be_else.31185
be_then.31185:
	load    [$18 + 4], $24
	load    [$24 + 0], $24
	load    [$23 + 0], $25
	load    [$22 + 2], $26
	fsub    $26, $20, $26
	load    [$22 + 3], $27
	fmul    $26, $27, $26
	fmul    $26, $25, $25
	fadd    $25, $19, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31186
ble_then.31186:
	li      0, $24
	b       ble_cont.31186
ble_else.31186:
	load    [$18 + 4], $24
	load    [$24 + 2], $24
	load    [$23 + 2], $25
	fmul    $26, $25, $25
	fadd    $25, $21, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31187
ble_then.31187:
	li      0, $24
	b       ble_cont.31187
ble_else.31187:
	load    [$22 + 3], $24
	fcmp    $24, $zero
	bne     be_else.31188
be_then.31188:
	li      0, $24
	b       be_cont.31188
be_else.31188:
	li      1, $24
be_cont.31188:
ble_cont.31187:
ble_cont.31186:
	cmp     $24, 0
	bne     be_else.31189
be_then.31189:
	load    [$18 + 4], $24
	load    [$24 + 0], $24
	load    [$23 + 0], $25
	load    [$22 + 4], $26
	fsub    $26, $21, $21
	load    [$22 + 5], $26
	fmul    $21, $26, $21
	fmul    $21, $25, $25
	fadd    $25, $19, $19
	fabs    $19, $19
	fcmp    $24, $19
	bg      ble_else.31190
ble_then.31190:
	li      0, $18
	b       be_cont.31181
ble_else.31190:
	load    [$18 + 4], $18
	load    [$18 + 1], $18
	load    [$23 + 1], $19
	fmul    $21, $19, $19
	fadd    $19, $20, $19
	fabs    $19, $19
	fcmp    $18, $19
	bg      ble_else.31191
ble_then.31191:
	li      0, $18
	b       be_cont.31181
ble_else.31191:
	load    [$22 + 5], $18
	fcmp    $18, $zero
	bne     be_else.31192
be_then.31192:
	li      0, $18
	b       be_cont.31181
be_else.31192:
.count move_float
	mov     $21, $42
	li      3, $18
	b       be_cont.31181
be_else.31189:
.count move_float
	mov     $26, $42
	li      2, $18
	b       be_cont.31181
be_else.31185:
.count move_float
	mov     $26, $42
	li      1, $18
	b       be_cont.31181
be_else.31181:
	cmp     $23, 2
	bne     be_else.31193
be_then.31193:
	load    [$22 + 0], $18
	fcmp    $zero, $18
	bg      ble_else.31194
ble_then.31194:
	li      0, $18
	b       be_cont.31193
ble_else.31194:
	load    [$22 + 1], $18
	fmul    $18, $19, $18
	load    [$22 + 2], $19
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	load    [$22 + 3], $19
	fmul    $19, $21, $19
	fadd    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31193
be_else.31193:
	load    [$22 + 0], $24
	fcmp    $24, $zero
	bne     be_else.31195
be_then.31195:
	li      0, $18
	b       be_cont.31195
be_else.31195:
	load    [$22 + 1], $25
	fmul    $25, $19, $25
	load    [$22 + 2], $26
	fmul    $26, $20, $26
	fadd    $25, $26, $25
	load    [$22 + 3], $26
	fmul    $26, $21, $26
	fadd    $25, $26, $25
	fmul    $25, $25, $26
	fmul    $19, $19, $27
	load    [$18 + 4], $28
	load    [$28 + 0], $28
	fmul    $27, $28, $27
	fmul    $20, $20, $28
	load    [$18 + 4], $29
	load    [$29 + 1], $29
	fmul    $28, $29, $28
	fadd    $27, $28, $27
	fmul    $21, $21, $28
	load    [$18 + 4], $29
	load    [$29 + 2], $29
	fmul    $28, $29, $28
	fadd    $27, $28, $27
	load    [$18 + 3], $28
	cmp     $28, 0
	bne     be_else.31196
be_then.31196:
	mov     $27, $19
	b       be_cont.31196
be_else.31196:
	fmul    $20, $21, $28
	load    [$18 + 9], $29
	load    [$29 + 0], $29
	fmul    $28, $29, $28
	fadd    $27, $28, $27
	fmul    $21, $19, $21
	load    [$18 + 9], $28
	load    [$28 + 1], $28
	fmul    $21, $28, $21
	fadd    $27, $21, $21
	fmul    $19, $20, $19
	load    [$18 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $21, $19, $19
be_cont.31196:
	cmp     $23, 3
	bne     be_cont.31197
be_then.31197:
	fsub    $19, $36, $19
be_cont.31197:
	fmul    $24, $19, $19
	fsub    $26, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31198
ble_then.31198:
	li      0, $18
	b       ble_cont.31198
ble_else.31198:
	load    [$18 + 6], $18
	cmp     $18, 0
	fsqrt   $19, $18
	load    [$22 + 4], $19
	bne     be_else.31199
be_then.31199:
	fsub    $25, $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31199
be_else.31199:
	fadd    $25, $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31199:
ble_cont.31198:
be_cont.31195:
be_cont.31193:
be_cont.31181:
	cmp     $18, 0
	bne     be_else.31200
be_then.31200:
	li      0, $18
	b       be_cont.31200
be_else.31200:
.count load_float
	load    [f.27087], $18
	fcmp    $18, $42
	bg      ble_else.31201
ble_then.31201:
	li      0, $18
	b       ble_cont.31201
ble_else.31201:
	li      1, $18
ble_cont.31201:
be_cont.31200:
	cmp     $18, 0
	bne     be_else.31202
be_then.31202:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31203
be_then.31203:
	li      0, $1
	ret
be_else.31203:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
be_else.31202:
	load    [$3 + 0], $17
	cmp     $17, -1
	bne     be_else.31204
be_then.31204:
	li      1, $1
	ret
be_else.31204:
	load    [min_caml_objects + $17], $17
	load    [$17 + 5], $18
	load    [$17 + 5], $19
	load    [$17 + 5], $20
	load    [$17 + 1], $21
	load    [$18 + 0], $18
.count load_float
	load    [f.27088], $22
	fadd    $42, $22, $22
	fmul    $55, $22, $23
	load    [min_caml_intersection_point + 0], $24
	fadd    $23, $24, $4
	fsub    $4, $18, $18
	load    [$19 + 1], $19
	fmul    $56, $22, $23
	load    [min_caml_intersection_point + 1], $24
	fadd    $23, $24, $5
	fsub    $5, $19, $19
	load    [$20 + 2], $20
	fmul    $57, $22, $22
	load    [min_caml_intersection_point + 2], $23
	fadd    $22, $23, $6
	fsub    $6, $20, $20
	cmp     $21, 1
	bne     be_else.31205
be_then.31205:
	load    [$17 + 4], $21
	load    [$21 + 0], $21
	fabs    $18, $18
	fcmp    $21, $18
	bg      ble_else.31206
ble_then.31206:
	load    [$17 + 6], $17
	cmp     $17, 0
	bne     be_else.31207
be_then.31207:
	li      1, $17
	b       be_cont.31205
be_else.31207:
	li      0, $17
	b       be_cont.31205
ble_else.31206:
	load    [$17 + 4], $18
	load    [$18 + 1], $18
	fabs    $19, $19
	fcmp    $18, $19
	bg      ble_else.31208
ble_then.31208:
	load    [$17 + 6], $17
	cmp     $17, 0
	bne     be_else.31209
be_then.31209:
	li      1, $17
	b       be_cont.31205
be_else.31209:
	li      0, $17
	b       be_cont.31205
ble_else.31208:
	load    [$17 + 4], $18
	load    [$18 + 2], $18
	fabs    $20, $19
	fcmp    $18, $19
	load    [$17 + 6], $17
	bg      be_cont.31205
ble_then.31210:
	cmp     $17, 0
	bne     be_else.31211
be_then.31211:
	li      1, $17
	b       be_cont.31205
be_else.31211:
	li      0, $17
	b       be_cont.31205
be_else.31205:
	cmp     $21, 2
	bne     be_else.31212
be_then.31212:
	load    [$17 + 6], $21
	load    [$17 + 4], $17
	load    [$17 + 0], $22
	fmul    $22, $18, $18
	load    [$17 + 1], $22
	fmul    $22, $19, $19
	fadd    $18, $19, $18
	load    [$17 + 2], $17
	fmul    $17, $20, $17
	fadd    $18, $17, $17
	fcmp    $zero, $17
	bg      ble_else.31213
ble_then.31213:
	cmp     $21, 0
	bne     be_else.31214
be_then.31214:
	li      1, $17
	b       be_cont.31212
be_else.31214:
	li      0, $17
	b       be_cont.31212
ble_else.31213:
	cmp     $21, 0
	bne     be_else.31215
be_then.31215:
	li      0, $17
	b       be_cont.31212
be_else.31215:
	li      1, $17
	b       be_cont.31212
be_else.31212:
	load    [$17 + 6], $22
	fmul    $18, $18, $23
	load    [$17 + 4], $24
	load    [$24 + 0], $24
	fmul    $23, $24, $23
	fmul    $19, $19, $24
	load    [$17 + 4], $25
	load    [$25 + 1], $25
	fmul    $24, $25, $24
	fadd    $23, $24, $23
	fmul    $20, $20, $24
	load    [$17 + 4], $25
	load    [$25 + 2], $25
	fmul    $24, $25, $24
	load    [$17 + 3], $25
	fadd    $23, $24, $23
	cmp     $25, 0
	bne     be_else.31216
be_then.31216:
	mov     $23, $17
	b       be_cont.31216
be_else.31216:
	fmul    $19, $20, $24
	load    [$17 + 9], $25
	load    [$25 + 0], $25
	fmul    $24, $25, $24
	fadd    $23, $24, $23
	fmul    $20, $18, $20
	load    [$17 + 9], $24
	load    [$24 + 1], $24
	fmul    $20, $24, $20
	fadd    $23, $20, $20
	fmul    $18, $19, $18
	load    [$17 + 9], $17
	load    [$17 + 2], $17
	fmul    $18, $17, $17
	fadd    $20, $17, $17
be_cont.31216:
	cmp     $21, 3
	bne     be_cont.31217
be_then.31217:
	fsub    $17, $36, $17
be_cont.31217:
	fcmp    $zero, $17
	bg      ble_else.31218
ble_then.31218:
	cmp     $22, 0
	bne     be_else.31219
be_then.31219:
	li      1, $17
	b       ble_cont.31218
be_else.31219:
	li      0, $17
	b       ble_cont.31218
ble_else.31218:
	cmp     $22, 0
	bne     be_else.31220
be_then.31220:
	li      0, $17
	b       be_cont.31220
be_else.31220:
	li      1, $17
be_cont.31220:
ble_cont.31218:
be_cont.31212:
be_cont.31205:
	cmp     $17, 0
	bne     be_else.31221
be_then.31221:
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
	bne     be_else.31222
be_then.31222:
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 2], $3
	b       shadow_check_and_group.2862
be_else.31222:
	li      1, $1
	ret
be_else.31221:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$3 + $2], $30
	cmp     $30, -1
	bne     be_else.31223
be_then.31223:
	li      0, $1
	ret
be_else.31223:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31224
be_then.31224:
.count stack_load
	load    [$sp + 1], $30
	add     $30, 1, $30
.count stack_load
	load    [$sp + 0], $31
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31225
be_then.31225:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31225:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31226
be_then.31226:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31227
be_then.31227:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31227:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31228
be_then.31228:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31229
be_then.31229:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31229:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31230
be_then.31230:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31231
be_then.31231:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31231:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31232
be_then.31232:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31233
be_then.31233:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31233:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31234
be_then.31234:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31235
be_then.31235:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31235:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	bne     be_else.31236
be_then.31236:
	add     $30, 1, $30
	load    [$31 + $30], $32
	cmp     $32, -1
	bne     be_else.31237
be_then.31237:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31237:
	li      0, $2
	load    [min_caml_and_net + $32], $3
	call    shadow_check_and_group.2862
.count stack_move
	add     $sp, 2, $sp
	cmp     $1, 0
	bne     be_else.31238
be_then.31238:
	add     $30, 1, $2
.count move_args
	mov     $31, $3
	b       shadow_check_one_or_group.2865
be_else.31238:
	li      1, $1
	ret
be_else.31236:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31234:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31232:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31230:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31228:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31226:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31224:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
.end shadow_check_one_or_group

######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$3 + $2], $30
	load    [$30 + 0], $31
	cmp     $31, -1
	bne     be_else.31239
be_then.31239:
	li      0, $1
	ret
be_else.31239:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $30, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	cmp     $31, 99
	bne     be_else.31240
be_then.31240:
	li      1, $15
	b       be_cont.31240
be_else.31240:
	load    [min_caml_objects + $31], $32
	load    [min_caml_intersection_point + 0], $33
	load    [$32 + 5], $34
	load    [$34 + 0], $34
	fsub    $33, $34, $33
	load    [min_caml_intersection_point + 1], $34
	load    [$32 + 5], $35
	load    [$35 + 1], $35
	fsub    $34, $35, $34
	load    [min_caml_intersection_point + 2], $35
	load    [$32 + 5], $15
	load    [$15 + 2], $15
	fsub    $35, $15, $35
	load    [min_caml_light_dirvec + 1], $15
	load    [$15 + $31], $31
	load    [$32 + 1], $15
	cmp     $15, 1
	bne     be_else.31241
be_then.31241:
	load    [min_caml_light_dirvec + 0], $15
	load    [$32 + 4], $16
	load    [$16 + 1], $16
	load    [$15 + 1], $17
	load    [$31 + 0], $18
	fsub    $18, $33, $18
	load    [$31 + 1], $19
	fmul    $18, $19, $18
	fmul    $18, $17, $17
	fadd    $17, $34, $17
	fabs    $17, $17
	fcmp    $16, $17
	bg      ble_else.31242
ble_then.31242:
	li      0, $16
	b       ble_cont.31242
ble_else.31242:
	load    [$32 + 4], $16
	load    [$16 + 2], $16
	load    [$15 + 2], $17
	fmul    $18, $17, $17
	fadd    $17, $35, $17
	fabs    $17, $17
	fcmp    $16, $17
	bg      ble_else.31243
ble_then.31243:
	li      0, $16
	b       ble_cont.31243
ble_else.31243:
	load    [$31 + 1], $16
	fcmp    $16, $zero
	bne     be_else.31244
be_then.31244:
	li      0, $16
	b       be_cont.31244
be_else.31244:
	li      1, $16
be_cont.31244:
ble_cont.31243:
ble_cont.31242:
	cmp     $16, 0
	bne     be_else.31245
be_then.31245:
	load    [$32 + 4], $16
	load    [$16 + 0], $16
	load    [$15 + 0], $17
	load    [$31 + 2], $18
	fsub    $18, $34, $18
	load    [$31 + 3], $19
	fmul    $18, $19, $18
	fmul    $18, $17, $17
	fadd    $17, $33, $17
	fabs    $17, $17
	fcmp    $16, $17
	bg      ble_else.31246
ble_then.31246:
	li      0, $16
	b       ble_cont.31246
ble_else.31246:
	load    [$32 + 4], $16
	load    [$16 + 2], $16
	load    [$15 + 2], $17
	fmul    $18, $17, $17
	fadd    $17, $35, $17
	fabs    $17, $17
	fcmp    $16, $17
	bg      ble_else.31247
ble_then.31247:
	li      0, $16
	b       ble_cont.31247
ble_else.31247:
	load    [$31 + 3], $16
	fcmp    $16, $zero
	bne     be_else.31248
be_then.31248:
	li      0, $16
	b       be_cont.31248
be_else.31248:
	li      1, $16
be_cont.31248:
ble_cont.31247:
ble_cont.31246:
	cmp     $16, 0
	bne     be_else.31249
be_then.31249:
	load    [$32 + 4], $16
	load    [$16 + 0], $16
	load    [$15 + 0], $17
	load    [$31 + 4], $18
	fsub    $18, $35, $35
	load    [$31 + 5], $18
	fmul    $35, $18, $35
	fmul    $35, $17, $17
	fadd    $17, $33, $33
	fabs    $33, $33
	fcmp    $16, $33
	bg      ble_else.31250
ble_then.31250:
	li      0, $31
	b       be_cont.31241
ble_else.31250:
	load    [$32 + 4], $32
	load    [$32 + 1], $32
	load    [$15 + 1], $33
	fmul    $35, $33, $33
	fadd    $33, $34, $33
	fabs    $33, $33
	fcmp    $32, $33
	bg      ble_else.31251
ble_then.31251:
	li      0, $31
	b       be_cont.31241
ble_else.31251:
	load    [$31 + 5], $31
	fcmp    $31, $zero
	bne     be_else.31252
be_then.31252:
	li      0, $31
	b       be_cont.31241
be_else.31252:
.count move_float
	mov     $35, $42
	li      3, $31
	b       be_cont.31241
be_else.31249:
.count move_float
	mov     $18, $42
	li      2, $31
	b       be_cont.31241
be_else.31245:
.count move_float
	mov     $18, $42
	li      1, $31
	b       be_cont.31241
be_else.31241:
	cmp     $15, 2
	bne     be_else.31253
be_then.31253:
	load    [$31 + 0], $32
	fcmp    $zero, $32
	bg      ble_else.31254
ble_then.31254:
	li      0, $31
	b       be_cont.31253
ble_else.31254:
	load    [$31 + 1], $32
	fmul    $32, $33, $32
	load    [$31 + 2], $33
	fmul    $33, $34, $33
	fadd    $32, $33, $32
	load    [$31 + 3], $31
	fmul    $31, $35, $31
	fadd    $32, $31, $31
.count move_float
	mov     $31, $42
	li      1, $31
	b       be_cont.31253
be_else.31253:
	load    [$31 + 0], $16
	fcmp    $16, $zero
	bne     be_else.31255
be_then.31255:
	li      0, $31
	b       be_cont.31255
be_else.31255:
	load    [$31 + 1], $17
	fmul    $17, $33, $17
	load    [$31 + 2], $18
	fmul    $18, $34, $18
	fadd    $17, $18, $17
	load    [$31 + 3], $18
	fmul    $18, $35, $18
	fadd    $17, $18, $17
	fmul    $17, $17, $18
	fmul    $33, $33, $19
	load    [$32 + 4], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fmul    $34, $34, $20
	load    [$32 + 4], $21
	load    [$21 + 1], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $35, $35, $20
	load    [$32 + 4], $21
	load    [$21 + 2], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	load    [$32 + 3], $20
	cmp     $20, 0
	bne     be_else.31256
be_then.31256:
	mov     $19, $33
	b       be_cont.31256
be_else.31256:
	fmul    $34, $35, $20
	load    [$32 + 9], $21
	load    [$21 + 0], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $35, $33, $35
	load    [$32 + 9], $20
	load    [$20 + 1], $20
	fmul    $35, $20, $35
	fadd    $19, $35, $35
	fmul    $33, $34, $33
	load    [$32 + 9], $34
	load    [$34 + 2], $34
	fmul    $33, $34, $33
	fadd    $35, $33, $33
be_cont.31256:
	cmp     $15, 3
	bne     be_cont.31257
be_then.31257:
	fsub    $33, $36, $33
be_cont.31257:
	fmul    $16, $33, $33
	fsub    $18, $33, $33
	fcmp    $33, $zero
	bg      ble_else.31258
ble_then.31258:
	li      0, $31
	b       ble_cont.31258
ble_else.31258:
	load    [$32 + 6], $32
	cmp     $32, 0
	load    [$31 + 4], $31
	fsqrt   $33, $32
	bne     be_else.31259
be_then.31259:
	fsub    $17, $32, $32
	fmul    $32, $31, $31
.count move_float
	mov     $31, $42
	li      1, $31
	b       be_cont.31259
be_else.31259:
	fadd    $17, $32, $32
	fmul    $32, $31, $31
.count move_float
	mov     $31, $42
	li      1, $31
be_cont.31259:
ble_cont.31258:
be_cont.31255:
be_cont.31253:
be_cont.31241:
	cmp     $31, 0
	bne     be_else.31260
be_then.31260:
	li      0, $15
	b       be_cont.31260
be_else.31260:
.count load_float
	load    [f.27089], $31
	fcmp    $31, $42
	bg      ble_else.31261
ble_then.31261:
	li      0, $15
	b       ble_cont.31261
ble_else.31261:
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31262
be_then.31262:
	li      0, $15
	b       be_cont.31262
be_else.31262:
	load    [min_caml_and_net + $31], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31263
be_then.31263:
	li      2, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $15
	cmp     $15, 0
	bne     be_else.31264
be_then.31264:
	li      0, $15
	b       be_cont.31263
be_else.31264:
	li      1, $15
	b       be_cont.31263
be_else.31263:
	li      1, $15
be_cont.31263:
be_cont.31262:
ble_cont.31261:
be_cont.31260:
be_cont.31240:
	cmp     $15, 0
	bne     be_else.31265
be_then.31265:
.count stack_load
	load    [$sp + 2], $15
	add     $15, 1, $15
.count stack_load
	load    [$sp + 1], $16
	load    [$16 + $15], $17
	load    [$17 + 0], $2
	cmp     $2, -1
	bne     be_else.31266
be_then.31266:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31266:
.count stack_store
	store   $17, [$sp + 3]
.count stack_store
	store   $15, [$sp + 4]
	cmp     $2, 99
	bne     be_else.31267
be_then.31267:
	li      1, $30
	b       be_cont.31267
be_else.31267:
	call    solver_fast.2796
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31268
be_then.31268:
	li      0, $30
	b       be_cont.31268
be_else.31268:
.count load_float
	load    [f.27089], $30
	fcmp    $30, $42
	bg      ble_else.31269
ble_then.31269:
	li      0, $30
	b       ble_cont.31269
ble_else.31269:
	load    [$17 + 1], $30
	cmp     $30, -1
	bne     be_else.31270
be_then.31270:
	li      0, $30
	b       be_cont.31270
be_else.31270:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31271
be_then.31271:
.count stack_load
	load    [$sp + 3], $30
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31272
be_then.31272:
	li      0, $30
	b       be_cont.31271
be_else.31272:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31273
be_then.31273:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31274
be_then.31274:
	li      0, $30
	b       be_cont.31271
be_else.31274:
	li      1, $30
	b       be_cont.31271
be_else.31273:
	li      1, $30
	b       be_cont.31271
be_else.31271:
	li      1, $30
be_cont.31271:
be_cont.31270:
ble_cont.31269:
be_cont.31268:
be_cont.31267:
	cmp     $30, 0
	bne     be_else.31275
be_then.31275:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31275:
.count stack_load
	load    [$sp + 3], $30
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31276
be_then.31276:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31276:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31277
be_then.31277:
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31278
be_then.31278:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31278:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31279
be_then.31279:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31280
be_then.31280:
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31280:
	li      1, $1
	ret
be_else.31279:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31277:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31265:
.count stack_load
	load    [$sp + 0], $30
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31281
be_then.31281:
	li      0, $15
	b       be_cont.31281
be_else.31281:
	load    [min_caml_and_net + $31], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31282
be_then.31282:
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31283
be_then.31283:
	li      0, $15
	b       be_cont.31282
be_else.31283:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31284
be_then.31284:
	load    [$30 + 3], $31
	cmp     $31, -1
	bne     be_else.31285
be_then.31285:
	li      0, $15
	b       be_cont.31282
be_else.31285:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31286
be_then.31286:
	load    [$30 + 4], $31
	cmp     $31, -1
	bne     be_else.31287
be_then.31287:
	li      0, $15
	b       be_cont.31282
be_else.31287:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31288
be_then.31288:
	load    [$30 + 5], $31
	cmp     $31, -1
	bne     be_else.31289
be_then.31289:
	li      0, $15
	b       be_cont.31282
be_else.31289:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31290
be_then.31290:
	load    [$30 + 6], $31
	cmp     $31, -1
	bne     be_else.31291
be_then.31291:
	li      0, $15
	b       be_cont.31282
be_else.31291:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31292
be_then.31292:
	load    [$30 + 7], $31
	cmp     $31, -1
	bne     be_else.31293
be_then.31293:
	li      0, $15
	b       be_cont.31282
be_else.31293:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31294
be_then.31294:
	li      8, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $15
	b       be_cont.31282
be_else.31294:
	li      1, $15
	b       be_cont.31282
be_else.31292:
	li      1, $15
	b       be_cont.31282
be_else.31290:
	li      1, $15
	b       be_cont.31282
be_else.31288:
	li      1, $15
	b       be_cont.31282
be_else.31286:
	li      1, $15
	b       be_cont.31282
be_else.31284:
	li      1, $15
	b       be_cont.31282
be_else.31282:
	li      1, $15
be_cont.31282:
be_cont.31281:
	cmp     $15, 0
	bne     be_else.31295
be_then.31295:
.count stack_load
	load    [$sp + 2], $15
	add     $15, 1, $15
.count stack_load
	load    [$sp + 1], $16
	load    [$16 + $15], $17
	load    [$17 + 0], $2
	cmp     $2, -1
	bne     be_else.31296
be_then.31296:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31296:
.count stack_store
	store   $17, [$sp + 5]
.count stack_store
	store   $15, [$sp + 6]
	cmp     $2, 99
	bne     be_else.31297
be_then.31297:
	li      1, $30
	b       be_cont.31297
be_else.31297:
	call    solver_fast.2796
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31298
be_then.31298:
	li      0, $30
	b       be_cont.31298
be_else.31298:
.count load_float
	load    [f.27089], $30
	fcmp    $30, $42
	bg      ble_else.31299
ble_then.31299:
	li      0, $30
	b       ble_cont.31299
ble_else.31299:
	load    [$17 + 1], $30
	cmp     $30, -1
	bne     be_else.31300
be_then.31300:
	li      0, $30
	b       be_cont.31300
be_else.31300:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31301
be_then.31301:
.count stack_load
	load    [$sp + 5], $30
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31302
be_then.31302:
	li      0, $30
	b       be_cont.31301
be_else.31302:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31303
be_then.31303:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31304
be_then.31304:
	li      0, $30
	b       be_cont.31301
be_else.31304:
	li      1, $30
	b       be_cont.31301
be_else.31303:
	li      1, $30
	b       be_cont.31301
be_else.31301:
	li      1, $30
be_cont.31301:
be_cont.31300:
ble_cont.31299:
be_cont.31298:
be_cont.31297:
	cmp     $30, 0
	bne     be_else.31305
be_then.31305:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31305:
.count stack_load
	load    [$sp + 5], $30
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31306
be_then.31306:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31306:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31307
be_then.31307:
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31308
be_then.31308:
.count stack_move
	add     $sp, 7, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31308:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31309
be_then.31309:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31310
be_then.31310:
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $3
	b       shadow_check_one_or_matrix.2868
be_else.31310:
	li      1, $1
	ret
be_else.31309:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31307:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31295:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
.end shadow_check_one_or_matrix

######################################################################
.begin solve_each_element
solve_each_element.2871:
	load    [$3 + $2], $17
	cmp     $17, -1
	bne     be_else.31311
be_then.31311:
	ret
be_else.31311:
	load    [min_caml_objects + $17], $18
	load    [$18 + 5], $19
	load    [$18 + 5], $20
	load    [$18 + 5], $21
	load    [$18 + 1], $22
	load    [min_caml_startp + 0], $23
	load    [$19 + 0], $19
	fsub    $23, $19, $19
	load    [min_caml_startp + 1], $23
	load    [$20 + 1], $20
	fsub    $23, $20, $20
	load    [min_caml_startp + 2], $23
	load    [$21 + 2], $21
	fsub    $23, $21, $21
	cmp     $22, 1
	bne     be_else.31312
be_then.31312:
	load    [$4 + 0], $22
	fcmp    $22, $zero
	bne     be_else.31313
be_then.31313:
	li      0, $22
	b       be_cont.31313
be_else.31313:
	load    [$18 + 4], $23
	load    [$18 + 6], $24
	fcmp    $zero, $22
	bg      ble_else.31314
ble_then.31314:
	li      0, $25
	b       ble_cont.31314
ble_else.31314:
	li      1, $25
ble_cont.31314:
	cmp     $24, 0
	bne     be_else.31315
be_then.31315:
	mov     $25, $24
	b       be_cont.31315
be_else.31315:
	cmp     $25, 0
	bne     be_else.31316
be_then.31316:
	li      1, $24
	b       be_cont.31316
be_else.31316:
	li      0, $24
be_cont.31316:
be_cont.31315:
	load    [$23 + 0], $25
	cmp     $24, 0
	bne     be_else.31317
be_then.31317:
	fneg    $25, $24
	b       be_cont.31317
be_else.31317:
	mov     $25, $24
be_cont.31317:
	fsub    $24, $19, $24
	finv    $22, $22
	fmul    $24, $22, $22
	load    [$23 + 1], $24
	load    [$4 + 1], $25
	fmul    $22, $25, $25
	fadd    $25, $20, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31318
ble_then.31318:
	li      0, $22
	b       ble_cont.31318
ble_else.31318:
	load    [$23 + 2], $23
	load    [$4 + 2], $24
	fmul    $22, $24, $24
	fadd    $24, $21, $24
	fabs    $24, $24
	fcmp    $23, $24
	bg      ble_else.31319
ble_then.31319:
	li      0, $22
	b       ble_cont.31319
ble_else.31319:
.count move_float
	mov     $22, $42
	li      1, $22
ble_cont.31319:
ble_cont.31318:
be_cont.31313:
	cmp     $22, 0
	bne     be_else.31320
be_then.31320:
	load    [$4 + 1], $22
	fcmp    $22, $zero
	bne     be_else.31321
be_then.31321:
	li      0, $22
	b       be_cont.31321
be_else.31321:
	load    [$18 + 4], $23
	load    [$18 + 6], $24
	fcmp    $zero, $22
	bg      ble_else.31322
ble_then.31322:
	li      0, $25
	b       ble_cont.31322
ble_else.31322:
	li      1, $25
ble_cont.31322:
	cmp     $24, 0
	bne     be_else.31323
be_then.31323:
	mov     $25, $24
	b       be_cont.31323
be_else.31323:
	cmp     $25, 0
	bne     be_else.31324
be_then.31324:
	li      1, $24
	b       be_cont.31324
be_else.31324:
	li      0, $24
be_cont.31324:
be_cont.31323:
	load    [$23 + 1], $25
	cmp     $24, 0
	bne     be_else.31325
be_then.31325:
	fneg    $25, $24
	b       be_cont.31325
be_else.31325:
	mov     $25, $24
be_cont.31325:
	fsub    $24, $20, $24
	finv    $22, $22
	fmul    $24, $22, $22
	load    [$23 + 2], $24
	load    [$4 + 2], $25
	fmul    $22, $25, $25
	fadd    $25, $21, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31326
ble_then.31326:
	li      0, $22
	b       ble_cont.31326
ble_else.31326:
	load    [$23 + 0], $23
	load    [$4 + 0], $24
	fmul    $22, $24, $24
	fadd    $24, $19, $24
	fabs    $24, $24
	fcmp    $23, $24
	bg      ble_else.31327
ble_then.31327:
	li      0, $22
	b       ble_cont.31327
ble_else.31327:
.count move_float
	mov     $22, $42
	li      1, $22
ble_cont.31327:
ble_cont.31326:
be_cont.31321:
	cmp     $22, 0
	bne     be_else.31328
be_then.31328:
	load    [$4 + 2], $22
	fcmp    $22, $zero
	bne     be_else.31329
be_then.31329:
	li      0, $18
	b       be_cont.31312
be_else.31329:
	load    [$18 + 4], $23
	load    [$23 + 0], $24
	load    [$4 + 0], $25
	load    [$18 + 6], $18
	fcmp    $zero, $22
	bg      ble_else.31330
ble_then.31330:
	li      0, $26
	b       ble_cont.31330
ble_else.31330:
	li      1, $26
ble_cont.31330:
	cmp     $18, 0
	bne     be_else.31331
be_then.31331:
	mov     $26, $18
	b       be_cont.31331
be_else.31331:
	cmp     $26, 0
	bne     be_else.31332
be_then.31332:
	li      1, $18
	b       be_cont.31332
be_else.31332:
	li      0, $18
be_cont.31332:
be_cont.31331:
	load    [$23 + 2], $26
	cmp     $18, 0
	bne     be_else.31333
be_then.31333:
	fneg    $26, $18
	b       be_cont.31333
be_else.31333:
	mov     $26, $18
be_cont.31333:
	fsub    $18, $21, $18
	finv    $22, $21
	fmul    $18, $21, $18
	fmul    $18, $25, $21
	fadd    $21, $19, $19
	fabs    $19, $19
	fcmp    $24, $19
	bg      ble_else.31334
ble_then.31334:
	li      0, $18
	b       be_cont.31312
ble_else.31334:
	load    [$23 + 1], $19
	load    [$4 + 1], $21
	fmul    $18, $21, $21
	fadd    $21, $20, $20
	fabs    $20, $20
	fcmp    $19, $20
	bg      ble_else.31335
ble_then.31335:
	li      0, $18
	b       be_cont.31312
ble_else.31335:
.count move_float
	mov     $18, $42
	li      3, $18
	b       be_cont.31312
be_else.31328:
	li      2, $18
	b       be_cont.31312
be_else.31320:
	li      1, $18
	b       be_cont.31312
be_else.31312:
	cmp     $22, 2
	bne     be_else.31336
be_then.31336:
	load    [$18 + 4], $18
	load    [$4 + 0], $22
	load    [$18 + 0], $23
	fmul    $22, $23, $22
	load    [$4 + 1], $24
	load    [$18 + 1], $25
	fmul    $24, $25, $24
	fadd    $22, $24, $22
	load    [$4 + 2], $24
	load    [$18 + 2], $18
	fmul    $24, $18, $24
	fadd    $22, $24, $22
	fcmp    $22, $zero
	bg      ble_else.31337
ble_then.31337:
	li      0, $18
	b       be_cont.31336
ble_else.31337:
	fmul    $23, $19, $19
	fmul    $25, $20, $20
	fadd    $19, $20, $19
	fmul    $18, $21, $18
	fadd    $19, $18, $18
	fneg    $18, $18
	finv    $22, $19
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31336
be_else.31336:
	load    [$18 + 3], $22
	load    [$18 + 4], $23
	load    [$18 + 4], $24
	load    [$18 + 4], $25
	load    [$4 + 0], $26
	load    [$4 + 1], $27
	load    [$4 + 2], $28
	fmul    $26, $26, $29
	load    [$23 + 0], $23
	fmul    $29, $23, $29
	fmul    $27, $27, $30
	load    [$24 + 1], $24
	fmul    $30, $24, $30
	fadd    $29, $30, $29
	fmul    $28, $28, $30
	load    [$25 + 2], $25
	fmul    $30, $25, $30
	fadd    $29, $30, $29
	cmp     $22, 0
	be      bne_cont.31338
bne_then.31338:
	fmul    $27, $28, $30
	load    [$18 + 9], $31
	load    [$31 + 0], $31
	fmul    $30, $31, $30
	fadd    $29, $30, $29
	fmul    $28, $26, $30
	load    [$18 + 9], $31
	load    [$31 + 1], $31
	fmul    $30, $31, $30
	fadd    $29, $30, $29
	fmul    $26, $27, $30
	load    [$18 + 9], $31
	load    [$31 + 2], $31
	fmul    $30, $31, $30
	fadd    $29, $30, $29
bne_cont.31338:
	fcmp    $29, $zero
	bne     be_else.31339
be_then.31339:
	li      0, $18
	b       be_cont.31339
be_else.31339:
	load    [$18 + 1], $30
	fmul    $26, $19, $31
	fmul    $31, $23, $31
	fmul    $27, $20, $32
	fmul    $32, $24, $32
	fadd    $31, $32, $31
	fmul    $28, $21, $32
	fmul    $32, $25, $32
	fadd    $31, $32, $31
	cmp     $22, 0
	bne     be_else.31340
be_then.31340:
	mov     $31, $26
	b       be_cont.31340
be_else.31340:
	fmul    $28, $20, $32
	fmul    $27, $21, $33
	fadd    $32, $33, $32
	load    [$18 + 9], $33
	load    [$33 + 0], $33
	fmul    $32, $33, $32
	fmul    $26, $21, $33
	fmul    $28, $19, $28
	fadd    $33, $28, $28
	load    [$18 + 9], $33
	load    [$33 + 1], $33
	fmul    $28, $33, $28
	fadd    $32, $28, $28
	fmul    $26, $20, $26
	fmul    $27, $19, $27
	fadd    $26, $27, $26
	load    [$18 + 9], $27
	load    [$27 + 2], $27
	fmul    $26, $27, $26
	fadd    $28, $26, $26
	fmul    $26, $39, $26
	fadd    $31, $26, $26
be_cont.31340:
	fmul    $26, $26, $27
	fmul    $19, $19, $28
	fmul    $28, $23, $23
	fmul    $20, $20, $28
	fmul    $28, $24, $24
	fadd    $23, $24, $23
	fmul    $21, $21, $24
	fmul    $24, $25, $24
	fadd    $23, $24, $23
	cmp     $22, 0
	bne     be_else.31341
be_then.31341:
	mov     $23, $19
	b       be_cont.31341
be_else.31341:
	fmul    $20, $21, $22
	load    [$18 + 9], $24
	load    [$24 + 0], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $21, $19, $21
	load    [$18 + 9], $23
	load    [$23 + 1], $23
	fmul    $21, $23, $21
	fadd    $22, $21, $21
	fmul    $19, $20, $19
	load    [$18 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $21, $19, $19
be_cont.31341:
	cmp     $30, 3
	bne     be_cont.31342
be_then.31342:
	fsub    $19, $36, $19
be_cont.31342:
	fmul    $29, $19, $19
	fsub    $27, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31343
ble_then.31343:
	li      0, $18
	b       ble_cont.31343
ble_else.31343:
	load    [$18 + 6], $18
	fsqrt   $19, $19
	cmp     $18, 0
	bne     be_else.31344
be_then.31344:
	fneg    $19, $18
	fsub    $18, $26, $18
	finv    $29, $19
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31344
be_else.31344:
	fsub    $19, $26, $18
	finv    $29, $19
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31344:
ble_cont.31343:
be_cont.31339:
be_cont.31336:
be_cont.31312:
	cmp     $18, 0
	bne     be_else.31345
be_then.31345:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31346
be_then.31346:
	ret
be_else.31346:
	add     $2, 1, $2
	b       solve_each_element.2871
be_else.31345:
	fcmp    $42, $zero
	bg      ble_else.31347
ble_then.31347:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31347:
	fcmp    $49, $42
	bg      ble_else.31348
ble_then.31348:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31348:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $2
	load    [$4 + 0], $19
.count load_float
	load    [f.27088], $20
	fadd    $42, $20, $20
	fmul    $19, $20, $19
	load    [min_caml_startp + 0], $21
	fadd    $19, $21, $19
	load    [$4 + 1], $21
	fmul    $21, $20, $21
	load    [min_caml_startp + 1], $22
	fadd    $21, $22, $5
.count stack_store
	store   $5, [$sp + 3]
	load    [$4 + 2], $21
	fmul    $21, $20, $21
	load    [min_caml_startp + 2], $22
	fadd    $21, $22, $6
.count stack_store
	store   $6, [$sp + 4]
.count move_args
	mov     $19, $4
	call    check_all_inside.2856
.count stack_move
	add     $sp, 5, $sp
	cmp     $1, 0
	bne     be_else.31349
be_then.31349:
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	b       solve_each_element.2871
be_else.31349:
.count move_float
	mov     $20, $49
	store   $19, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $17, [min_caml_intersected_object_id + 0]
	store   $18, [min_caml_intsec_rectside + 0]
.count stack_load
	load    [$sp - 3], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
	b       solve_each_element.2871
.end solve_each_element

######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$3 + $2], $34
	cmp     $34, -1
	bne     be_else.31350
be_then.31350:
	ret
be_else.31350:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    solve_each_element.2871
.count stack_load
	load    [$sp + 2], $34
	add     $34, 1, $34
.count stack_load
	load    [$sp + 1], $35
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31351
be_then.31351:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31351:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31352
be_then.31352:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31352:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31353
be_then.31353:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31353:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31354
be_then.31354:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31354:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31355
be_then.31355:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31355:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31356
be_then.31356:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31356:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31357
be_then.31357:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31357:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_move
	add     $sp, 3, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $4
.count move_args
	mov     $35, $3
	b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
	load    [$3 + $2], $34
	load    [$34 + 0], $35
	cmp     $35, -1
	bne     be_else.31358
be_then.31358:
	ret
be_else.31358:
.count stack_move
	sub     $sp, 4, $sp
	cmp     $35, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.31359
be_then.31359:
	load    [$34 + 1], $35
	cmp     $35, -1
	be      bne_cont.31360
bne_then.31360:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element.2871
	load    [$34 + 2], $35
	cmp     $35, -1
	be      bne_cont.31361
bne_then.31361:
	li      0, $2
	load    [min_caml_and_net + $35], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 3], $35
	cmp     $35, -1
	be      bne_cont.31362
bne_then.31362:
	li      0, $2
	load    [min_caml_and_net + $35], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 4], $35
	cmp     $35, -1
	be      bne_cont.31363
bne_then.31363:
	li      0, $2
	load    [min_caml_and_net + $35], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 5], $35
	cmp     $35, -1
	be      bne_cont.31364
bne_then.31364:
	li      0, $2
	load    [min_caml_and_net + $35], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 6], $35
	cmp     $35, -1
	be      bne_cont.31365
bne_then.31365:
	li      0, $2
	load    [min_caml_and_net + $35], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      7, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
bne_cont.31365:
bne_cont.31364:
bne_cont.31363:
bne_cont.31362:
bne_cont.31361:
bne_cont.31360:
.count stack_load
	load    [$sp + 2], $34
	add     $34, 1, $34
.count stack_load
	load    [$sp + 1], $3
	load    [$3 + $34], $35
	load    [$35 + 0], $2
	cmp     $2, -1
	bne     be_else.31366
be_then.31366:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31366:
	cmp     $2, 99
	bne     be_else.31367
be_then.31367:
	load    [$35 + 1], $1
	cmp     $1, -1
	bne     be_else.31368
be_then.31368:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31368:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 2], $1
	cmp     $1, -1
	bne     be_else.31369
be_then.31369:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31369:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 3], $1
	cmp     $1, -1
	bne     be_else.31370
be_then.31370:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31370:
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 4], $1
	cmp     $1, -1
	bne     be_else.31371
be_then.31371:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31371:
.count stack_store
	store   $34, [$sp + 3]
	li      0, $2
	load    [min_caml_and_net + $1], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      5, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $35, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31367:
.count stack_load
	load    [$sp + 0], $3
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31372
be_then.31372:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31372:
	fcmp    $49, $42
	bg      ble_else.31373
ble_then.31373:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
ble_else.31373:
.count stack_store
	store   $34, [$sp + 3]
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $35, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31359:
.count move_args
	mov     $4, $3
.count move_args
	mov     $35, $2
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31374
be_then.31374:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31374:
	fcmp    $49, $42
	bg      ble_else.31375
ble_then.31375:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
ble_else.31375:
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$3 + $2], $17
	cmp     $17, -1
	bne     be_else.31376
be_then.31376:
	ret
be_else.31376:
	load    [min_caml_objects + $17], $18
	load    [$18 + 10], $19
	load    [$4 + 1], $20
	load    [$18 + 1], $21
	load    [$19 + 0], $22
	load    [$19 + 1], $23
	load    [$19 + 2], $24
	load    [$20 + $17], $20
	cmp     $21, 1
	bne     be_else.31377
be_then.31377:
	load    [$4 + 0], $19
	load    [$18 + 4], $21
	load    [$21 + 1], $21
	load    [$19 + 1], $25
	load    [$20 + 0], $26
	fsub    $26, $22, $26
	load    [$20 + 1], $27
	fmul    $26, $27, $26
	fmul    $26, $25, $25
	fadd    $25, $23, $25
	fabs    $25, $25
	fcmp    $21, $25
	bg      ble_else.31378
ble_then.31378:
	li      0, $21
	b       ble_cont.31378
ble_else.31378:
	load    [$18 + 4], $21
	load    [$21 + 2], $21
	load    [$19 + 2], $25
	fmul    $26, $25, $25
	fadd    $25, $24, $25
	fabs    $25, $25
	fcmp    $21, $25
	bg      ble_else.31379
ble_then.31379:
	li      0, $21
	b       ble_cont.31379
ble_else.31379:
	load    [$20 + 1], $21
	fcmp    $21, $zero
	bne     be_else.31380
be_then.31380:
	li      0, $21
	b       be_cont.31380
be_else.31380:
	li      1, $21
be_cont.31380:
ble_cont.31379:
ble_cont.31378:
	cmp     $21, 0
	bne     be_else.31381
be_then.31381:
	load    [$18 + 4], $21
	load    [$21 + 0], $21
	load    [$19 + 0], $25
	load    [$20 + 2], $26
	fsub    $26, $23, $26
	load    [$20 + 3], $27
	fmul    $26, $27, $26
	fmul    $26, $25, $25
	fadd    $25, $22, $25
	fabs    $25, $25
	fcmp    $21, $25
	bg      ble_else.31382
ble_then.31382:
	li      0, $21
	b       ble_cont.31382
ble_else.31382:
	load    [$18 + 4], $21
	load    [$21 + 2], $21
	load    [$19 + 2], $25
	fmul    $26, $25, $25
	fadd    $25, $24, $25
	fabs    $25, $25
	fcmp    $21, $25
	bg      ble_else.31383
ble_then.31383:
	li      0, $21
	b       ble_cont.31383
ble_else.31383:
	load    [$20 + 3], $21
	fcmp    $21, $zero
	bne     be_else.31384
be_then.31384:
	li      0, $21
	b       be_cont.31384
be_else.31384:
	li      1, $21
be_cont.31384:
ble_cont.31383:
ble_cont.31382:
	cmp     $21, 0
	bne     be_else.31385
be_then.31385:
	load    [$18 + 4], $21
	load    [$21 + 0], $21
	load    [$19 + 0], $25
	load    [$20 + 4], $26
	fsub    $26, $24, $24
	load    [$20 + 5], $26
	fmul    $24, $26, $24
	fmul    $24, $25, $25
	fadd    $25, $22, $22
	fabs    $22, $22
	fcmp    $21, $22
	bg      ble_else.31386
ble_then.31386:
	li      0, $18
	b       be_cont.31377
ble_else.31386:
	load    [$18 + 4], $18
	load    [$18 + 1], $18
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $19, $23, $19
	fabs    $19, $19
	fcmp    $18, $19
	bg      ble_else.31387
ble_then.31387:
	li      0, $18
	b       be_cont.31377
ble_else.31387:
	load    [$20 + 5], $18
	fcmp    $18, $zero
	bne     be_else.31388
be_then.31388:
	li      0, $18
	b       be_cont.31377
be_else.31388:
.count move_float
	mov     $24, $42
	li      3, $18
	b       be_cont.31377
be_else.31385:
.count move_float
	mov     $26, $42
	li      2, $18
	b       be_cont.31377
be_else.31381:
.count move_float
	mov     $26, $42
	li      1, $18
	b       be_cont.31377
be_else.31377:
	cmp     $21, 2
	bne     be_else.31389
be_then.31389:
	load    [$20 + 0], $18
	fcmp    $zero, $18
	bg      ble_else.31390
ble_then.31390:
	li      0, $18
	b       be_cont.31389
ble_else.31390:
	load    [$19 + 3], $19
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31389
be_else.31389:
	load    [$20 + 0], $21
	fcmp    $21, $zero
	bne     be_else.31391
be_then.31391:
	li      0, $18
	b       be_cont.31391
be_else.31391:
	load    [$20 + 1], $25
	fmul    $25, $22, $22
	load    [$20 + 2], $25
	fmul    $25, $23, $23
	fadd    $22, $23, $22
	load    [$20 + 3], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $22, $23
	load    [$19 + 3], $19
	fmul    $21, $19, $19
	fsub    $23, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31392
ble_then.31392:
	li      0, $18
	b       ble_cont.31392
ble_else.31392:
	load    [$18 + 6], $18
	cmp     $18, 0
	fsqrt   $19, $18
	load    [$20 + 4], $19
	bne     be_else.31393
be_then.31393:
	fsub    $22, $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31393
be_else.31393:
	fadd    $22, $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31393:
ble_cont.31392:
be_cont.31391:
be_cont.31389:
be_cont.31377:
	cmp     $18, 0
	bne     be_else.31394
be_then.31394:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31395
be_then.31395:
	ret
be_else.31395:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
be_else.31394:
	fcmp    $42, $zero
	bg      ble_else.31396
ble_then.31396:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31396:
	load    [$4 + 0], $19
	fcmp    $49, $42
	bg      ble_else.31397
ble_then.31397:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31397:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $2
	load    [$19 + 0], $20
.count load_float
	load    [f.27088], $21
	fadd    $42, $21, $21
	fmul    $20, $21, $20
	fadd    $20, $51, $4
.count stack_store
	store   $4, [$sp + 3]
	load    [$19 + 1], $20
	fmul    $20, $21, $20
	fadd    $20, $52, $5
.count stack_store
	store   $5, [$sp + 4]
	load    [$19 + 2], $19
	fmul    $19, $21, $19
	fadd    $19, $53, $6
.count stack_store
	store   $6, [$sp + 5]
	call    check_all_inside.2856
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
	bne     be_else.31398
be_then.31398:
.count stack_load
	load    [$sp - 4], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       solve_each_element_fast.2885
be_else.31398:
.count move_float
	mov     $21, $49
.count stack_load
	load    [$sp - 3], $1
	store   $1, [min_caml_intersection_point + 0]
.count stack_load
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $17, [min_caml_intersected_object_id + 0]
	store   $18, [min_caml_intsec_rectside + 0]
.count stack_load
	load    [$sp - 4], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 5], $3
.count stack_load
	load    [$sp - 6], $4
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$3 + $2], $28
	cmp     $28, -1
	bne     be_else.31399
be_then.31399:
	ret
be_else.31399:
.count stack_move
	sub     $sp, 3, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $2
	load    [min_caml_and_net + $28], $3
	call    solve_each_element_fast.2885
.count stack_load
	load    [$sp + 2], $28
	add     $28, 1, $28
.count stack_load
	load    [$sp + 1], $29
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31400
be_then.31400:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31400:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31401
be_then.31401:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31401:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31402
be_then.31402:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31402:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31403
be_then.31403:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31403:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31404
be_then.31404:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31404:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31405
be_then.31405:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31405:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31406
be_then.31406:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31406:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_move
	add     $sp, 3, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $4
.count move_args
	mov     $29, $3
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$3 + $2], $28
	load    [$28 + 0], $29
	cmp     $29, -1
	bne     be_else.31407
be_then.31407:
	ret
be_else.31407:
.count stack_move
	sub     $sp, 4, $sp
	cmp     $29, 99
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	bne     be_else.31408
be_then.31408:
	load    [$28 + 1], $29
	cmp     $29, -1
	be      bne_cont.31409
bne_then.31409:
	li      0, $2
	load    [min_caml_and_net + $29], $3
	call    solve_each_element_fast.2885
	load    [$28 + 2], $29
	cmp     $29, -1
	be      bne_cont.31410
bne_then.31410:
	li      0, $2
	load    [min_caml_and_net + $29], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 3], $29
	cmp     $29, -1
	be      bne_cont.31411
bne_then.31411:
	li      0, $2
	load    [min_caml_and_net + $29], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 4], $29
	cmp     $29, -1
	be      bne_cont.31412
bne_then.31412:
	li      0, $2
	load    [min_caml_and_net + $29], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 5], $29
	cmp     $29, -1
	be      bne_cont.31413
bne_then.31413:
	li      0, $2
	load    [min_caml_and_net + $29], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 6], $29
	cmp     $29, -1
	be      bne_cont.31414
bne_then.31414:
	li      0, $2
	load    [min_caml_and_net + $29], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      7, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $28, $3
	call    solve_one_or_network_fast.2889
bne_cont.31414:
bne_cont.31413:
bne_cont.31412:
bne_cont.31411:
bne_cont.31410:
bne_cont.31409:
.count stack_load
	load    [$sp + 2], $28
	add     $28, 1, $28
.count stack_load
	load    [$sp + 1], $3
	load    [$3 + $28], $29
	load    [$29 + 0], $30
	cmp     $30, -1
	bne     be_else.31415
be_then.31415:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31415:
	cmp     $30, 99
	bne     be_else.31416
be_then.31416:
	load    [$29 + 1], $30
	cmp     $30, -1
	bne     be_else.31417
be_then.31417:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31417:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$29 + 2], $30
	cmp     $30, -1
	bne     be_else.31418
be_then.31418:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31418:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$29 + 3], $30
	cmp     $30, -1
	bne     be_else.31419
be_then.31419:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31419:
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$29 + 4], $30
	cmp     $30, -1
	bne     be_else.31420
be_then.31420:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31420:
.count stack_store
	store   $28, [$sp + 3]
	li      0, $2
	load    [min_caml_and_net + $30], $3
.count stack_load
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $29, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31416:
.count stack_load
	load    [$sp + 0], $3
.count move_args
	mov     $30, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31421
be_then.31421:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31421:
	fcmp    $49, $42
	bg      ble_else.31422
ble_then.31422:
.count stack_move
	add     $sp, 4, $sp
	add     $28, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
ble_else.31422:
.count stack_store
	store   $28, [$sp + 3]
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $29, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31408:
.count move_args
	mov     $4, $3
.count move_args
	mov     $29, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31423
be_then.31423:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31423:
	fcmp    $49, $42
	bg      ble_else.31424
ble_then.31424:
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
ble_else.31424:
	li      1, $2
.count stack_load
	load    [$sp + 0], $4
.count move_args
	mov     $28, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 3], $3
.count stack_load
	load    [$sp - 4], $4
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
	bne     be_else.31425
be_then.31425:
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 5], $10
	load    [$2 + 5], $11
	load    [min_caml_intersection_point + 0], $12
	load    [$10 + 0], $10
.count load_float
	load    [f.27100], $13
	fsub    $12, $10, $10
	fmul    $10, $13, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $12
.count load_float
	load    [f.27101], $14
.count load_float
	load    [f.27102], $15
	fmul    $12, $14, $12
	fsub    $10, $12, $10
	load    [min_caml_intersection_point + 2], $12
	load    [$11 + 2], $11
	fsub    $12, $11, $11
	fmul    $11, $13, $2
	call    min_caml_floor
.count stack_move
	add     $sp, 2, $sp
	fmul    $1, $14, $1
	fsub    $11, $1, $1
	fcmp    $15, $10
	bg      ble_else.31426
ble_then.31426:
	li      0, $2
	b       ble_cont.31426
ble_else.31426:
	li      1, $2
ble_cont.31426:
	fcmp    $15, $1
	bg      ble_else.31427
ble_then.31427:
	cmp     $2, 0
	bne     be_else.31428
be_then.31428:
.count load_float
	load    [f.27096], $1
.count move_float
	mov     $1, $54
	ret
be_else.31428:
.count move_float
	mov     $zero, $54
	ret
ble_else.31427:
	cmp     $2, 0
	bne     be_else.31429
be_then.31429:
.count move_float
	mov     $zero, $54
	ret
be_else.31429:
.count load_float
	load    [f.27096], $1
.count move_float
	mov     $1, $54
	ret
be_else.31425:
	cmp     $10, 2
	bne     be_else.31430
be_then.31430:
.count stack_move
	sub     $sp, 2, $sp
	load    [min_caml_intersection_point + 1], $11
.count load_float
	load    [f.27099], $12
	fmul    $11, $12, $2
	call    min_caml_sin
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.27096], $2
	fmul    $1, $1, $1
	fmul    $2, $1, $3
	store   $3, [min_caml_texture_color + 0]
	fsub    $36, $1, $1
	fmul    $2, $1, $1
.count move_float
	mov     $1, $54
	ret
be_else.31430:
	cmp     $10, 3
	bne     be_else.31431
be_then.31431:
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 5], $10
	load    [$2 + 5], $11
	load    [min_caml_intersection_point + 0], $12
	load    [$10 + 0], $10
	fsub    $12, $10, $10
	fmul    $10, $10, $10
	load    [min_caml_intersection_point + 2], $12
	load    [$11 + 2], $11
	fsub    $12, $11, $11
	fmul    $11, $11, $11
	fadd    $10, $11, $10
	fsqrt   $10, $10
.count load_float
	load    [f.27098], $11
	fmul    $10, $11, $2
.count stack_store
	store   $2, [$sp + 0]
	call    min_caml_floor
.count move_ret
	mov     $1, $11
.count stack_load
	load    [$sp + 0], $12
	fsub    $12, $11, $11
.count load_float
	load    [f.27093], $12
	fmul    $11, $12, $2
	call    min_caml_cos
.count stack_move
	add     $sp, 2, $sp
.count load_float
	load    [f.27096], $2
	fmul    $1, $1, $1
	fmul    $1, $2, $3
.count move_float
	mov     $3, $54
	fsub    $36, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
be_else.31431:
	cmp     $10, 4
	bne     be_else.31432
be_then.31432:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $2, [$sp + 1]
	load    [$2 + 5], $11
	load    [$2 + 4], $12
	load    [$2 + 5], $13
	load    [$2 + 4], $14
.count load_float
	load    [f.27090], $15
	load    [min_caml_intersection_point + 0], $16
	load    [$11 + 0], $11
	fsub    $16, $11, $11
	load    [$12 + 0], $12
	fsqrt   $12, $12
	fmul    $11, $12, $11
	fabs    $11, $12
	load    [min_caml_intersection_point + 2], $16
	load    [$13 + 2], $13
	fsub    $16, $13, $13
	load    [$14 + 2], $14
	fsqrt   $14, $14
	fmul    $13, $14, $13
	fcmp    $15, $12
	bg      ble_else.31433
ble_then.31433:
	finv    $11, $12
	fmul    $13, $12, $12
	fabs    $12, $2
	call    min_caml_atan
.count move_ret
	mov     $1, $12
.count load_float
	load    [f.27092], $14
	fmul    $12, $14, $12
.count load_float
	load    [f.27093], $14
.count load_float
	load    [f.27094], $14
	fmul    $12, $14, $12
	b       ble_cont.31433
ble_else.31433:
.count load_float
	load    [f.27091], $12
ble_cont.31433:
.count stack_load
	load    [$sp + 1], $14
	load    [$14 + 5], $16
	load    [$14 + 4], $14
	fmul    $11, $11, $11
	fmul    $13, $13, $13
	fadd    $11, $13, $11
	fabs    $11, $13
	load    [min_caml_intersection_point + 1], $17
	load    [$16 + 1], $16
	fsub    $17, $16, $16
	load    [$14 + 1], $14
	fsqrt   $14, $14
	fmul    $16, $14, $14
	fcmp    $15, $13
	bg      ble_else.31434
ble_then.31434:
	finv    $11, $11
	fmul    $14, $11, $11
	fabs    $11, $2
	call    min_caml_atan
.count move_ret
	mov     $1, $10
.count load_float
	load    [f.27092], $11
	fmul    $10, $11, $10
.count load_float
	load    [f.27093], $11
.count load_float
	load    [f.27094], $11
	fmul    $10, $11, $10
	b       ble_cont.31434
ble_else.31434:
.count load_float
	load    [f.27091], $10
ble_cont.31434:
.count load_float
	load    [f.27095], $11
.count move_args
	mov     $12, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $13
	fsub    $12, $13, $12
	fsub    $39, $12, $12
	fmul    $12, $12, $12
	fsub    $11, $12, $11
.count move_args
	mov     $10, $2
	call    min_caml_floor
.count stack_move
	add     $sp, 2, $sp
	fsub    $10, $1, $1
	fsub    $39, $1, $1
	fmul    $1, $1, $1
	fsub    $11, $1, $1
	fcmp    $zero, $1
	bg      ble_else.31435
ble_then.31435:
.count load_float
	load    [f.27096], $2
	fmul    $2, $1, $1
.count load_float
	load    [f.27097], $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
ble_else.31435:
.count move_float
	mov     $zero, $58
	ret
be_else.31432:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2915:
	cmp     $2, 0
	bl      bge_else.31436
bge_then.31436:
.count stack_move
	sub     $sp, 6, $sp
.count stack_store
	store   $5, [$sp + 0]
.count stack_store
	store   $4, [$sp + 1]
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
	load    [min_caml_reflections + $2], $32
	load    [$32 + 1], $4
.count stack_store
	store   $4, [$sp + 4]
.count load_float
	load    [f.27103], $33
.count move_float
	mov     $33, $49
	load    [$59 + 0], $33
	load    [$33 + 0], $34
	cmp     $34, -1
	be      bne_cont.31437
bne_then.31437:
	cmp     $34, 99
	bne     be_else.31438
be_then.31438:
	load    [$33 + 1], $34
	cmp     $34, -1
	bne     be_else.31439
be_then.31439:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31438
be_else.31439:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    solve_each_element_fast.2885
	load    [$33 + 2], $34
	cmp     $34, -1
.count stack_load
	load    [$sp + 4], $4
	bne     be_else.31440
be_then.31440:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31438
be_else.31440:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    solve_each_element_fast.2885
	load    [$33 + 3], $34
	cmp     $34, -1
.count stack_load
	load    [$sp + 4], $4
	bne     be_else.31441
be_then.31441:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31438
be_else.31441:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    solve_each_element_fast.2885
	load    [$33 + 4], $34
	cmp     $34, -1
.count stack_load
	load    [$sp + 4], $4
	bne     be_else.31442
be_then.31442:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31438
be_else.31442:
	li      0, $2
	load    [min_caml_and_net + $34], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $33, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31438
be_else.31438:
.count move_args
	mov     $4, $3
.count move_args
	mov     $34, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $34
	cmp     $34, 0
.count stack_load
	load    [$sp + 4], $4
	li      1, $2
	bne     be_else.31443
be_then.31443:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31443
be_else.31443:
	fcmp    $49, $42
	bg      ble_else.31444
ble_then.31444:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       ble_cont.31444
ble_else.31444:
.count move_args
	mov     $33, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31444:
be_cont.31443:
be_cont.31438:
bne_cont.31437:
.count load_float
	load    [f.27089], $1
	fcmp    $49, $1
	bg      ble_else.31445
ble_then.31445:
	li      0, $1
	b       ble_cont.31445
ble_else.31445:
.count load_float
	load    [f.27104], $1
	fcmp    $1, $49
	bg      ble_else.31446
ble_then.31446:
	li      0, $1
	b       ble_cont.31446
ble_else.31446:
	li      1, $1
ble_cont.31446:
ble_cont.31445:
	cmp     $1, 0
	bne     be_else.31447
be_then.31447:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
.count stack_load
	load    [$sp - 6], $5
	b       trace_reflections.2915
be_else.31447:
	load    [$32 + 0], $1
	load    [min_caml_intersected_object_id + 0], $2
	sll     $2, 2, $2
	load    [min_caml_intsec_rectside + 0], $3
	add     $2, $3, $2
	cmp     $2, $1
	bne     be_else.31448
be_then.31448:
.count stack_store
	store   $32, [$sp + 5]
	li      0, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
.count stack_load
	load    [$sp - 4], $3
	bne     be_else.31449
be_then.31449:
.count stack_load
	load    [$sp - 1], $1
	load    [$1 + 2], $1
.count stack_load
	load    [$sp - 2], $2
	load    [$2 + 0], $2
	fmul    $1, $3, $4
	load    [min_caml_nvector + 0], $5
	load    [$2 + 0], $6
	fmul    $5, $6, $5
	load    [min_caml_nvector + 1], $7
	load    [$2 + 1], $8
	fmul    $7, $8, $7
	fadd    $5, $7, $5
	load    [min_caml_nvector + 2], $7
	load    [$2 + 2], $2
	fmul    $7, $2, $7
	fadd    $5, $7, $5
	fmul    $4, $5, $4
	fcmp    $4, $zero
	ble     bg_cont.31450
bg_then.31450:
	load    [min_caml_texture_color + 0], $5
	fmul    $4, $5, $5
	fadd    $46, $5, $5
.count move_float
	mov     $5, $46
	fmul    $4, $54, $5
	fadd    $47, $5, $5
.count move_float
	mov     $5, $47
	fmul    $4, $58, $4
	fadd    $48, $4, $4
.count move_float
	mov     $4, $48
bg_cont.31450:
.count stack_load
	load    [$sp - 6], $5
	load    [$5 + 0], $4
	fmul    $4, $6, $4
	load    [$5 + 1], $6
	fmul    $6, $8, $6
	fadd    $4, $6, $4
	load    [$5 + 2], $6
	fmul    $6, $2, $2
	fadd    $4, $2, $2
	fmul    $1, $2, $1
	fcmp    $1, $zero
.count stack_load
	load    [$sp - 5], $4
	bg      ble_else.31451
ble_then.31451:
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
	b       trace_reflections.2915
ble_else.31451:
	fmul    $1, $1, $1
	fmul    $1, $1, $1
	fmul    $1, $4, $1
	fadd    $46, $1, $2
.count move_float
	mov     $2, $46
	fadd    $47, $1, $2
.count move_float
	mov     $2, $47
	fadd    $48, $1, $1
.count move_float
	mov     $1, $48
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
	b       trace_reflections.2915
be_else.31449:
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 5], $4
.count stack_load
	load    [$sp - 6], $5
	b       trace_reflections.2915
be_else.31448:
.count stack_move
	add     $sp, 6, $sp
.count stack_load
	load    [$sp - 3], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 4], $3
.count stack_load
	load    [$sp - 5], $4
.count stack_load
	load    [$sp - 6], $5
	b       trace_reflections.2915
bge_else.31436:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2920:
	cmp     $2, 4
	bg      ble_else.31452
ble_then.31452:
.count stack_move
	sub     $sp, 9, $sp
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
.count load_float
	load    [f.27103], $34
.count move_float
	mov     $34, $49
	load    [$59 + 0], $34
	load    [$34 + 0], $35
	cmp     $35, -1
	be      bne_cont.31453
bne_then.31453:
	cmp     $35, 99
	bne     be_else.31454
be_then.31454:
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31455
be_then.31455:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31454
be_else.31455:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element.2871
	load    [$34 + 2], $35
	cmp     $35, -1
.count stack_load
	load    [$sp + 2], $4
	bne     be_else.31456
be_then.31456:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31454
be_else.31456:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element.2871
	load    [$34 + 3], $35
	cmp     $35, -1
.count stack_load
	load    [$sp + 2], $4
	bne     be_else.31457
be_then.31457:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31454
be_else.31457:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element.2871
	load    [$34 + 4], $35
	cmp     $35, -1
.count stack_load
	load    [$sp + 2], $4
	bne     be_else.31458
be_then.31458:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31454
be_else.31458:
	li      0, $2
	load    [min_caml_and_net + $35], $3
	call    solve_each_element.2871
	li      5, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31454
be_else.31454:
.count move_args
	mov     $4, $3
.count move_args
	mov     $35, $2
	call    solver.2773
.count move_ret
	mov     $1, $18
	cmp     $18, 0
.count stack_load
	load    [$sp + 2], $4
	li      1, $2
	bne     be_else.31459
be_then.31459:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31459
be_else.31459:
	fcmp    $49, $42
	bg      ble_else.31460
ble_then.31460:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       ble_cont.31460
ble_else.31460:
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
	li      1, $2
.count stack_load
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
ble_cont.31460:
be_cont.31459:
be_cont.31454:
bne_cont.31453:
.count stack_load
	load    [$sp + 4], $18
	load    [$18 + 2], $19
.count load_float
	load    [f.27089], $20
	fcmp    $49, $20
	bg      ble_else.31461
ble_then.31461:
	li      0, $21
	b       ble_cont.31461
ble_else.31461:
.count load_float
	load    [f.27104], $21
	fcmp    $21, $49
	bg      ble_else.31462
ble_then.31462:
	li      0, $21
	b       ble_cont.31462
ble_else.31462:
	li      1, $21
ble_cont.31462:
ble_cont.31461:
	cmp     $21, 0
	bne     be_else.31463
be_then.31463:
.count stack_move
	add     $sp, 9, $sp
	add     $zero, -1, $1
.count stack_load
	load    [$sp - 6], $2
.count storer
	add     $19, $2, $tmp
	store   $1, [$tmp + 0]
	cmp     $2, 0
	bne     be_else.31464
be_then.31464:
	ret
be_else.31464:
.count stack_load
	load    [$sp - 7], $1
	load    [$1 + 0], $2
	fmul    $2, $55, $2
	load    [$1 + 1], $3
	fmul    $3, $56, $3
	fadd    $2, $3, $2
	load    [$1 + 2], $1
	fmul    $1, $57, $1
	fadd    $2, $1, $1
	fneg    $1, $1
	fcmp    $1, $zero
	bg      ble_else.31465
ble_then.31465:
	ret
ble_else.31465:
	fmul    $1, $1, $2
	fmul    $2, $1, $1
.count stack_load
	load    [$sp - 8], $2
	fmul    $1, $2, $1
	load    [min_caml_beam + 0], $2
	fmul    $1, $2, $1
	fadd    $46, $1, $2
.count move_float
	mov     $2, $46
	fadd    $47, $1, $2
.count move_float
	mov     $2, $47
	fadd    $48, $1, $1
.count move_float
	mov     $1, $48
	ret
be_else.31463:
.count stack_store
	store   $19, [$sp + 5]
	load    [min_caml_intersected_object_id + 0], $21
	load    [min_caml_objects + $21], $2
.count stack_store
	store   $2, [$sp + 6]
	load    [$2 + 1], $22
	cmp     $22, 1
	bne     be_else.31466
be_then.31466:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $22
	sub     $22, 1, $22
.count stack_load
	load    [$sp + 2], $23
	load    [$23 + $22], $23
	fcmp    $23, $zero
	bne     be_else.31467
be_then.31467:
	store   $zero, [min_caml_nvector + $22]
	b       be_cont.31466
be_else.31467:
	fcmp    $23, $zero
	bg      ble_else.31468
ble_then.31468:
	store   $36, [min_caml_nvector + $22]
	b       be_cont.31466
ble_else.31468:
	store   $40, [min_caml_nvector + $22]
	b       be_cont.31466
be_else.31466:
	cmp     $22, 2
	bne     be_else.31469
be_then.31469:
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
	b       be_cont.31469
be_else.31469:
	load    [$2 + 3], $22
	load    [$2 + 4], $23
	load    [$23 + 0], $23
	load    [min_caml_intersection_point + 0], $24
	load    [$2 + 5], $25
	load    [$25 + 0], $25
	fsub    $24, $25, $24
	fmul    $24, $23, $23
	load    [$2 + 4], $25
	load    [$25 + 1], $25
	load    [min_caml_intersection_point + 1], $26
	load    [$2 + 5], $27
	load    [$27 + 1], $27
	fsub    $26, $27, $26
	fmul    $26, $25, $25
	load    [$2 + 4], $27
	load    [$27 + 2], $27
	load    [min_caml_intersection_point + 2], $28
	load    [$2 + 5], $29
	load    [$29 + 2], $29
	fsub    $28, $29, $28
	fmul    $28, $27, $27
	cmp     $22, 0
	bne     be_else.31470
be_then.31470:
	store   $23, [min_caml_nvector + 0]
	store   $25, [min_caml_nvector + 1]
	store   $27, [min_caml_nvector + 2]
	b       be_cont.31470
be_else.31470:
	load    [$2 + 9], $22
	load    [$22 + 2], $22
	fmul    $26, $22, $22
	load    [$2 + 9], $29
	load    [$29 + 1], $29
	fmul    $28, $29, $29
	fadd    $22, $29, $22
	fmul    $22, $39, $22
	fadd    $23, $22, $22
	store   $22, [min_caml_nvector + 0]
	load    [$2 + 9], $22
	load    [$22 + 2], $22
	fmul    $24, $22, $22
	load    [$2 + 9], $23
	load    [$23 + 0], $23
	fmul    $28, $23, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fadd    $25, $22, $22
	store   $22, [min_caml_nvector + 1]
	load    [$2 + 9], $22
	load    [$22 + 1], $22
	fmul    $24, $22, $22
	load    [$2 + 9], $23
	load    [$23 + 0], $23
	fmul    $26, $23, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fadd    $27, $22, $22
	store   $22, [min_caml_nvector + 2]
be_cont.31470:
	load    [min_caml_nvector + 0], $22
	load    [$2 + 6], $23
	fmul    $22, $22, $24
	load    [min_caml_nvector + 1], $25
	fmul    $25, $25, $25
	fadd    $24, $25, $24
	load    [min_caml_nvector + 2], $25
	fmul    $25, $25, $25
	fadd    $24, $25, $24
	fsqrt   $24, $24
	fcmp    $24, $zero
	bne     be_else.31471
be_then.31471:
	mov     $36, $23
	b       be_cont.31471
be_else.31471:
	cmp     $23, 0
	finv    $24, $23
	be      bne_cont.31472
bne_then.31472:
	fneg    $23, $23
bne_cont.31472:
be_cont.31471:
	fmul    $22, $23, $22
	store   $22, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $22
	fmul    $22, $23, $22
	store   $22, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $22
	fmul    $22, $23, $22
	store   $22, [min_caml_nvector + 2]
be_cont.31469:
be_cont.31466:
	load    [min_caml_intersection_point + 0], $22
	store   $22, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $22
	store   $22, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $22
	store   $22, [min_caml_startp + 2]
	call    utexture.2908
	sll     $21, 2, $15
	load    [min_caml_intsec_rectside + 0], $16
	add     $15, $16, $15
.count stack_load
	load    [$sp + 3], $16
.count storer
	add     $19, $16, $tmp
	store   $15, [$tmp + 0]
	load    [$18 + 1], $15
	load    [$15 + $16], $15
	load    [min_caml_intersection_point + 0], $17
	store   $17, [$15 + 0]
	load    [min_caml_intersection_point + 1], $17
	store   $17, [$15 + 1]
	load    [min_caml_intersection_point + 2], $17
	store   $17, [$15 + 2]
.count stack_load
	load    [$sp + 6], $15
	load    [$15 + 7], $15
	load    [$18 + 3], $17
	load    [$15 + 0], $15
.count stack_load
	load    [$sp + 1], $19
	fmul    $15, $19, $19
.count stack_store
	store   $19, [$sp + 7]
	fcmp    $39, $15
.count storer
	add     $17, $16, $tmp
	bg      ble_else.31473
ble_then.31473:
	li      1, $15
	store   $15, [$tmp + 0]
	load    [$18 + 4], $15
	load    [$15 + $16], $17
	load    [min_caml_texture_color + 0], $21
	store   $21, [$17 + 0]
	store   $54, [$17 + 1]
	store   $58, [$17 + 2]
	load    [$15 + $16], $15
.count load_float
	load    [f.27105], $17
.count load_float
	load    [f.27106], $17
	fmul    $17, $19, $17
	load    [$15 + 0], $19
	fmul    $19, $17, $19
	store   $19, [$15 + 0]
	load    [$15 + 1], $19
	fmul    $19, $17, $19
	store   $19, [$15 + 1]
	load    [$15 + 2], $19
	fmul    $19, $17, $17
	store   $17, [$15 + 2]
	load    [$18 + 7], $15
	load    [$15 + $16], $15
	load    [min_caml_nvector + 0], $16
	store   $16, [$15 + 0]
	load    [min_caml_nvector + 1], $16
	store   $16, [$15 + 1]
	load    [min_caml_nvector + 2], $16
	store   $16, [$15 + 2]
	b       ble_cont.31473
ble_else.31473:
	li      0, $15
	store   $15, [$tmp + 0]
ble_cont.31473:
	load    [min_caml_nvector + 0], $15
.count load_float
	load    [f.27107], $16
.count stack_load
	load    [$sp + 2], $17
	load    [$17 + 0], $18
	fmul    $18, $15, $19
	load    [$17 + 1], $21
	load    [min_caml_nvector + 1], $22
	fmul    $21, $22, $21
	fadd    $19, $21, $19
	load    [$17 + 2], $21
	load    [min_caml_nvector + 2], $22
	fmul    $21, $22, $21
	fadd    $19, $21, $19
	fmul    $16, $19, $16
	fmul    $16, $15, $15
	fadd    $18, $15, $15
	store   $15, [$17 + 0]
	load    [$17 + 1], $15
	load    [min_caml_nvector + 1], $18
	fmul    $16, $18, $18
	fadd    $15, $18, $15
	store   $15, [$17 + 1]
	load    [$17 + 2], $15
	load    [min_caml_nvector + 2], $18
	fmul    $16, $18, $16
	fadd    $15, $16, $15
	store   $15, [$17 + 2]
	load    [$59 + 0], $15
	load    [$15 + 0], $2
	cmp     $2, -1
	bne     be_else.31474
be_then.31474:
	li      0, $14
	b       be_cont.31474
be_else.31474:
.count stack_store
	store   $15, [$sp + 8]
	cmp     $2, 99
	bne     be_else.31475
be_then.31475:
	li      1, $30
	b       be_cont.31475
be_else.31475:
	call    solver_fast.2796
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31476
be_then.31476:
	li      0, $30
	b       be_cont.31476
be_else.31476:
	fcmp    $20, $42
	bg      ble_else.31477
ble_then.31477:
	li      0, $30
	b       ble_cont.31477
ble_else.31477:
	load    [$15 + 1], $30
	cmp     $30, -1
	bne     be_else.31478
be_then.31478:
	li      0, $30
	b       be_cont.31478
be_else.31478:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31479
be_then.31479:
.count stack_load
	load    [$sp + 8], $30
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31480
be_then.31480:
	li      0, $30
	b       be_cont.31479
be_else.31480:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31481
be_then.31481:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31482
be_then.31482:
	li      0, $30
	b       be_cont.31479
be_else.31482:
	li      1, $30
	b       be_cont.31479
be_else.31481:
	li      1, $30
	b       be_cont.31479
be_else.31479:
	li      1, $30
be_cont.31479:
be_cont.31478:
ble_cont.31477:
be_cont.31476:
be_cont.31475:
	cmp     $30, 0
	bne     be_else.31483
be_then.31483:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31483
be_else.31483:
.count stack_load
	load    [$sp + 8], $30
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31484
be_then.31484:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31484
be_else.31484:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31485
be_then.31485:
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31486
be_then.31486:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31485
be_else.31486:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31487
be_then.31487:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $14
	cmp     $14, 0
	bne     be_else.31488
be_then.31488:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31485
be_else.31488:
	li      1, $14
	b       be_cont.31485
be_else.31487:
	li      1, $14
	b       be_cont.31485
be_else.31485:
	li      1, $14
be_cont.31485:
be_cont.31484:
be_cont.31483:
be_cont.31474:
.count stack_load
	load    [$sp + 6], $15
	load    [$15 + 7], $15
	load    [$15 + 1], $15
.count stack_load
	load    [$sp + 1], $16
	fmul    $16, $15, $15
	cmp     $14, 0
	bne     be_cont.31489
be_then.31489:
	load    [min_caml_nvector + 0], $14
	fmul    $14, $55, $14
	load    [min_caml_nvector + 1], $16
	fmul    $16, $56, $16
	fadd    $14, $16, $14
	load    [min_caml_nvector + 2], $16
	fmul    $16, $57, $16
	fadd    $14, $16, $14
	fneg    $14, $14
.count stack_load
	load    [$sp + 7], $16
	fmul    $14, $16, $14
.count stack_load
	load    [$sp + 2], $16
	load    [$16 + 0], $17
	fmul    $17, $55, $17
	load    [$16 + 1], $18
	fmul    $18, $56, $18
	fadd    $17, $18, $17
	load    [$16 + 2], $16
	fmul    $16, $57, $16
	fadd    $17, $16, $16
	fneg    $16, $16
	fcmp    $14, $zero
	ble     bg_cont.31490
bg_then.31490:
	load    [min_caml_texture_color + 0], $17
	fmul    $14, $17, $17
	fadd    $46, $17, $17
.count move_float
	mov     $17, $46
	fmul    $14, $54, $17
	fadd    $47, $17, $17
.count move_float
	mov     $17, $47
	fmul    $14, $58, $14
	fadd    $48, $14, $14
.count move_float
	mov     $14, $48
bg_cont.31490:
	fcmp    $16, $zero
	ble     bg_cont.31491
bg_then.31491:
	fmul    $16, $16, $14
	fmul    $14, $14, $14
	fmul    $14, $15, $14
	fadd    $46, $14, $16
.count move_float
	mov     $16, $46
	fadd    $47, $14, $16
.count move_float
	mov     $16, $47
	fadd    $48, $14, $14
.count move_float
	mov     $14, $48
bg_cont.31491:
be_cont.31489:
	li      min_caml_intersection_point, $2
	load    [min_caml_intersection_point + 0], $14
.count move_float
	mov     $14, $51
	load    [min_caml_intersection_point + 1], $14
.count move_float
	mov     $14, $52
	load    [min_caml_intersection_point + 2], $14
.count move_float
	mov     $14, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [min_caml_n_reflections + 0], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp + 7], $3
.count stack_load
	load    [$sp + 2], $5
.count move_args
	mov     $15, $4
	call    trace_reflections.2915
.count stack_move
	add     $sp, 9, $sp
.count load_float
	load    [f.27098], $1
.count stack_load
	load    [$sp - 8], $2
	fcmp    $2, $1
	bg      ble_else.31492
ble_then.31492:
	ret
ble_else.31492:
.count stack_load
	load    [$sp - 6], $1
	cmp     $1, 4
	bge     bl_cont.31493
bl_then.31493:
	add     $1, 1, $1
	add     $zero, -1, $3
.count stack_load
	load    [$sp - 4], $4
.count storer
	add     $4, $1, $tmp
	store   $3, [$tmp + 0]
bl_cont.31493:
.count stack_load
	load    [$sp - 3], $1
	load    [$1 + 2], $3
	cmp     $3, 2
	bne     be_else.31494
be_then.31494:
	load    [$1 + 7], $1
.count stack_load
	load    [$sp - 9], $3
	fadd    $3, $49, $6
.count stack_load
	load    [$sp - 6], $3
	add     $3, 1, $3
	load    [$1 + 0], $1
	fsub    $36, $1, $1
	fmul    $2, $1, $1
.count stack_load
	load    [$sp - 7], $4
.count stack_load
	load    [$sp - 5], $5
.count move_args
	mov     $3, $2
.count move_args
	mov     $1, $3
	b       trace_ray.2920
be_else.31494:
	ret
ble_else.31452:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count load_float
	load    [f.27103], $32
.count move_float
	mov     $32, $49
	load    [$59 + 0], $32
	load    [$32 + 0], $33
	cmp     $33, -1
	be      bne_cont.31495
bne_then.31495:
	cmp     $33, 99
	bne     be_else.31496
be_then.31496:
	load    [$32 + 1], $33
	cmp     $33, -1
.count move_args
	mov     $2, $4
	bne     be_else.31497
be_then.31497:
	li      1, $32
.count move_args
	mov     $59, $3
.count move_args
	mov     $32, $2
	call    trace_or_matrix_fast.2893
	b       be_cont.31496
be_else.31497:
	li      0, $28
	load    [min_caml_and_net + $33], $3
.count move_args
	mov     $28, $2
	call    solve_each_element_fast.2885
	load    [$32 + 2], $33
	cmp     $33, -1
.count stack_load
	load    [$sp + 1], $4
	bne     be_else.31498
be_then.31498:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31496
be_else.31498:
	li      0, $2
	load    [min_caml_and_net + $33], $3
	call    solve_each_element_fast.2885
	load    [$32 + 3], $33
	cmp     $33, -1
.count stack_load
	load    [$sp + 1], $4
	bne     be_else.31499
be_then.31499:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31496
be_else.31499:
	li      0, $2
	load    [min_caml_and_net + $33], $3
	call    solve_each_element_fast.2885
	load    [$32 + 4], $33
	cmp     $33, -1
.count stack_load
	load    [$sp + 1], $4
	bne     be_else.31500
be_then.31500:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31496
be_else.31500:
	li      0, $2
	load    [min_caml_and_net + $33], $3
	call    solve_each_element_fast.2885
	li      5, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $32, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31496
be_else.31496:
.count move_args
	mov     $2, $3
.count move_args
	mov     $33, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $33
	cmp     $33, 0
.count stack_load
	load    [$sp + 1], $4
	li      1, $2
	bne     be_else.31501
be_then.31501:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31501
be_else.31501:
	fcmp    $49, $42
	bg      ble_else.31502
ble_then.31502:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       ble_cont.31502
ble_else.31502:
.count move_args
	mov     $32, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
.count stack_load
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31502:
be_cont.31501:
be_cont.31496:
bne_cont.31495:
.count load_float
	load    [f.27089], $18
	fcmp    $49, $18
	bg      ble_else.31503
ble_then.31503:
	li      0, $19
	b       ble_cont.31503
ble_else.31503:
.count load_float
	load    [f.27104], $19
	fcmp    $19, $49
	bg      ble_else.31504
ble_then.31504:
	li      0, $19
	b       ble_cont.31504
ble_else.31504:
	li      1, $19
ble_cont.31504:
ble_cont.31503:
	cmp     $19, 0
	bne     be_else.31505
be_then.31505:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31505:
.count stack_load
	load    [$sp + 1], $19
	load    [$19 + 0], $19
	load    [min_caml_intersected_object_id + 0], $20
	load    [min_caml_objects + $20], $2
.count stack_store
	store   $2, [$sp + 2]
	load    [$2 + 1], $20
	cmp     $20, 1
	bne     be_else.31506
be_then.31506:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $20
	sub     $20, 1, $20
	load    [$19 + $20], $19
	fcmp    $19, $zero
	bne     be_else.31507
be_then.31507:
	store   $zero, [min_caml_nvector + $20]
	b       be_cont.31506
be_else.31507:
	fcmp    $19, $zero
	bg      ble_else.31508
ble_then.31508:
	store   $36, [min_caml_nvector + $20]
	b       be_cont.31506
ble_else.31508:
	store   $40, [min_caml_nvector + $20]
	b       be_cont.31506
be_else.31506:
	cmp     $20, 2
	bne     be_else.31509
be_then.31509:
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
	b       be_cont.31509
be_else.31509:
	load    [$2 + 3], $19
	load    [$2 + 4], $20
	load    [$20 + 0], $20
	load    [min_caml_intersection_point + 0], $21
	load    [$2 + 5], $22
	load    [$22 + 0], $22
	fsub    $21, $22, $21
	fmul    $21, $20, $20
	load    [$2 + 4], $22
	load    [$22 + 1], $22
	load    [min_caml_intersection_point + 1], $23
	load    [$2 + 5], $24
	load    [$24 + 1], $24
	fsub    $23, $24, $23
	fmul    $23, $22, $22
	load    [$2 + 4], $24
	load    [$24 + 2], $24
	load    [min_caml_intersection_point + 2], $25
	load    [$2 + 5], $26
	load    [$26 + 2], $26
	fsub    $25, $26, $25
	fmul    $25, $24, $24
	cmp     $19, 0
	bne     be_else.31510
be_then.31510:
	store   $20, [min_caml_nvector + 0]
	store   $22, [min_caml_nvector + 1]
	store   $24, [min_caml_nvector + 2]
	b       be_cont.31510
be_else.31510:
	load    [$2 + 9], $19
	load    [$19 + 2], $19
	fmul    $23, $19, $19
	load    [$2 + 9], $26
	load    [$26 + 1], $26
	fmul    $25, $26, $26
	fadd    $19, $26, $19
	fmul    $19, $39, $19
	fadd    $20, $19, $19
	store   $19, [min_caml_nvector + 0]
	load    [$2 + 9], $19
	load    [$19 + 2], $19
	fmul    $21, $19, $19
	load    [$2 + 9], $20
	load    [$20 + 0], $20
	fmul    $25, $20, $20
	fadd    $19, $20, $19
	fmul    $19, $39, $19
	fadd    $22, $19, $19
	store   $19, [min_caml_nvector + 1]
	load    [$2 + 9], $19
	load    [$19 + 1], $19
	fmul    $21, $19, $19
	load    [$2 + 9], $20
	load    [$20 + 0], $20
	fmul    $23, $20, $20
	fadd    $19, $20, $19
	fmul    $19, $39, $19
	fadd    $24, $19, $19
	store   $19, [min_caml_nvector + 2]
be_cont.31510:
	load    [min_caml_nvector + 0], $19
	load    [$2 + 6], $20
	fmul    $19, $19, $21
	load    [min_caml_nvector + 1], $22
	fmul    $22, $22, $22
	fadd    $21, $22, $21
	load    [min_caml_nvector + 2], $22
	fmul    $22, $22, $22
	fadd    $21, $22, $21
	fsqrt   $21, $21
	fcmp    $21, $zero
	bne     be_else.31511
be_then.31511:
	mov     $36, $20
	b       be_cont.31511
be_else.31511:
	cmp     $20, 0
	finv    $21, $20
	be      bne_cont.31512
bne_then.31512:
	fneg    $20, $20
bne_cont.31512:
be_cont.31511:
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $19
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $19
	fmul    $19, $20, $19
	store   $19, [min_caml_nvector + 2]
be_cont.31509:
be_cont.31506:
	call    utexture.2908
	load    [$59 + 0], $15
	load    [$15 + 0], $2
	cmp     $2, -1
	bne     be_else.31513
be_then.31513:
	li      0, $1
	b       be_cont.31513
be_else.31513:
.count stack_store
	store   $15, [$sp + 3]
	cmp     $2, 99
	bne     be_else.31514
be_then.31514:
	li      1, $30
	b       be_cont.31514
be_else.31514:
	call    solver_fast.2796
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31515
be_then.31515:
	li      0, $30
	b       be_cont.31515
be_else.31515:
	fcmp    $18, $42
	bg      ble_else.31516
ble_then.31516:
	li      0, $30
	b       ble_cont.31516
ble_else.31516:
	load    [$15 + 1], $30
	cmp     $30, -1
	bne     be_else.31517
be_then.31517:
	li      0, $30
	b       be_cont.31517
be_else.31517:
	li      0, $2
	load    [min_caml_and_net + $30], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31518
be_then.31518:
.count stack_load
	load    [$sp + 3], $30
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31519
be_then.31519:
	li      0, $30
	b       be_cont.31518
be_else.31519:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31520
be_then.31520:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31521
be_then.31521:
	li      0, $30
	b       be_cont.31518
be_else.31521:
	li      1, $30
	b       be_cont.31518
be_else.31520:
	li      1, $30
	b       be_cont.31518
be_else.31518:
	li      1, $30
be_cont.31518:
be_cont.31517:
ble_cont.31516:
be_cont.31515:
be_cont.31514:
	cmp     $30, 0
	bne     be_else.31522
be_then.31522:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31522
be_else.31522:
.count stack_load
	load    [$sp + 3], $30
	load    [$30 + 1], $31
	cmp     $31, -1
	bne     be_else.31523
be_then.31523:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31523
be_else.31523:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31524
be_then.31524:
	load    [$30 + 2], $31
	cmp     $31, -1
	bne     be_else.31525
be_then.31525:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31524
be_else.31525:
	li      0, $2
	load    [min_caml_and_net + $31], $3
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	bne     be_else.31526
be_then.31526:
	li      3, $2
.count move_args
	mov     $30, $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.31527
be_then.31527:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31524
be_else.31527:
	li      1, $1
	b       be_cont.31524
be_else.31526:
	li      1, $1
	b       be_cont.31524
be_else.31524:
	li      1, $1
be_cont.31524:
be_cont.31523:
be_cont.31522:
be_cont.31513:
.count stack_move
	add     $sp, 4, $sp
	cmp     $1, 0
	bne     be_else.31528
be_then.31528:
.count stack_load
	load    [$sp - 2], $1
	load    [$1 + 7], $1
	load    [min_caml_texture_color + 0], $2
	load    [min_caml_nvector + 0], $3
	fmul    $3, $55, $3
	load    [min_caml_nvector + 1], $4
	fmul    $4, $56, $4
	fadd    $3, $4, $3
	load    [min_caml_nvector + 2], $4
	fmul    $4, $57, $4
	fadd    $3, $4, $3
	fneg    $3, $3
	fcmp    $3, $zero
	bg      ble_cont.31529
ble_then.31529:
	mov     $zero, $3
ble_cont.31529:
.count stack_load
	load    [$sp - 4], $4
	fmul    $4, $3, $3
	load    [$1 + 0], $1
	fmul    $3, $1, $1
	fmul    $1, $2, $2
	fadd    $43, $2, $2
.count move_float
	mov     $2, $43
	fmul    $1, $54, $2
	fadd    $44, $2, $2
.count move_float
	mov     $2, $44
	fmul    $1, $58, $1
	fadd    $45, $1, $1
.count move_float
	mov     $1, $45
	ret
be_else.31528:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	cmp     $4, 0
	bl      bge_else.31530
bge_then.31530:
.count stack_move
	sub     $sp, 4, $sp
	load    [$2 + $4], $1
	load    [$1 + 0], $1
	load    [$1 + 0], $5
	load    [$3 + 0], $6
	fmul    $5, $6, $5
	load    [$1 + 1], $6
	load    [$3 + 1], $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	load    [$1 + 2], $1
	load    [$3 + 2], $6
	fmul    $1, $6, $1
	fadd    $5, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $3, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
	bg      ble_else.31531
ble_then.31531:
	fmul    $1, $37, $3
	load    [$2 + $4], $2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31532
bge_then.31532:
.count stack_load
	load    [$sp + 1], $2
	load    [$2 + $1], $3
	load    [$3 + 0], $3
	load    [$3 + 0], $4
.count stack_load
	load    [$sp + 0], $5
	load    [$5 + 0], $6
	fmul    $4, $6, $4
	load    [$3 + 1], $6
	load    [$5 + 1], $7
	fmul    $6, $7, $6
	fadd    $4, $6, $4
	load    [$3 + 2], $3
	load    [$5 + 2], $6
	fmul    $3, $6, $3
	fadd    $4, $3, $3
	fcmp    $zero, $3
.count stack_store
	store   $1, [$sp + 3]
	bg      ble_else.31533
ble_then.31533:
	fmul    $3, $37, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 2, $4
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	b       iter_trace_diffuse_rays.2929
ble_else.31533:
	fmul    $3, $38, $3
	add     $1, 1, $1
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 2, $4
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	b       iter_trace_diffuse_rays.2929
bge_else.31532:
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.31531:
	fmul    $1, $38, $3
	add     $4, 1, $1
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_load
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31534
bge_then.31534:
.count stack_load
	load    [$sp + 1], $2
	load    [$2 + $1], $3
	load    [$3 + 0], $3
	load    [$3 + 0], $4
.count stack_load
	load    [$sp + 0], $5
	load    [$5 + 0], $6
	fmul    $4, $6, $4
	load    [$3 + 1], $6
	load    [$5 + 1], $7
	fmul    $6, $7, $6
	fadd    $4, $6, $4
	load    [$3 + 2], $3
	load    [$5 + 2], $6
	fmul    $3, $6, $3
	fadd    $4, $3, $3
	fcmp    $zero, $3
.count stack_store
	store   $1, [$sp + 3]
	bg      ble_else.31535
ble_then.31535:
	fmul    $3, $37, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 2, $4
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	b       iter_trace_diffuse_rays.2929
ble_else.31535:
	fmul    $3, $38, $3
	add     $1, 1, $1
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 2, $4
.count stack_load
	load    [$sp - 3], $2
.count stack_load
	load    [$sp - 4], $3
	b       iter_trace_diffuse_rays.2929
bge_else.31534:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31530:
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
	load    [$2 + 5], $14
	load    [$14 + $3], $14
	load    [$14 + 0], $15
.count move_float
	mov     $15, $43
	load    [$14 + 1], $15
.count move_float
	mov     $15, $44
	load    [$14 + 2], $14
.count move_float
	mov     $14, $45
	load    [$2 + 7], $14
	load    [$2 + 1], $15
	load    [$2 + 6], $16
	load    [$14 + $3], $14
.count stack_store
	store   $14, [$sp + 2]
	load    [$15 + $3], $2
.count stack_store
	store   $2, [$sp + 3]
	load    [$16 + 0], $15
.count stack_store
	store   $15, [$sp + 4]
	cmp     $15, 0
	be      bne_cont.31536
bne_then.31536:
	load    [min_caml_dirvecs + 0], $15
	load    [$2 + 0], $16
.count move_float
	mov     $16, $51
	load    [$2 + 1], $16
.count move_float
	mov     $16, $52
	load    [$2 + 2], $16
.count move_float
	mov     $16, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$15 + 118], $16
	load    [$16 + 0], $16
	load    [$16 + 0], $17
	load    [$14 + 0], $18
	fmul    $17, $18, $17
	load    [$16 + 1], $18
	load    [$14 + 1], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	load    [$16 + 2], $16
	load    [$14 + 2], $18
	fmul    $16, $18, $16
	fadd    $17, $16, $16
	fcmp    $zero, $16
.count stack_store
	store   $15, [$sp + 5]
	bg      ble_else.31537
ble_then.31537:
	load    [$15 + 118], $2
.count load_float
	load    [f.27111], $14
	fmul    $16, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31537
ble_else.31537:
	load    [$15 + 119], $2
.count load_float
	load    [f.27110], $14
	fmul    $16, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 5], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31537:
bne_cont.31536:
.count stack_load
	load    [$sp + 4], $14
	cmp     $14, 1
	be      bne_cont.31538
bne_then.31538:
	load    [min_caml_dirvecs + 1], $14
.count stack_load
	load    [$sp + 3], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 2], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 6]
	bg      ble_else.31539
ble_then.31539:
	load    [$14 + 118], $2
.count load_float
	load    [f.27111], $14
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31539
ble_else.31539:
	load    [$14 + 119], $2
.count load_float
	load    [f.27110], $14
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 6], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31539:
bne_cont.31538:
.count stack_load
	load    [$sp + 4], $14
	cmp     $14, 2
	be      bne_cont.31540
bne_then.31540:
	load    [min_caml_dirvecs + 2], $14
.count stack_load
	load    [$sp + 3], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 2], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 7]
	bg      ble_else.31541
ble_then.31541:
	load    [$14 + 118], $2
.count load_float
	load    [f.27111], $14
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31541
ble_else.31541:
	load    [$14 + 119], $2
.count load_float
	load    [f.27110], $14
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 7], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31541:
bne_cont.31540:
.count stack_load
	load    [$sp + 4], $14
	cmp     $14, 3
	be      bne_cont.31542
bne_then.31542:
	load    [min_caml_dirvecs + 3], $14
.count stack_load
	load    [$sp + 3], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 2], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 8]
	bg      ble_else.31543
ble_then.31543:
	load    [$14 + 118], $2
.count load_float
	load    [f.27111], $14
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31543
ble_else.31543:
	load    [$14 + 119], $2
.count load_float
	load    [f.27110], $14
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31543:
bne_cont.31542:
.count stack_load
	load    [$sp + 4], $14
	cmp     $14, 4
	be      bne_cont.31544
bne_then.31544:
	load    [min_caml_dirvecs + 4], $14
.count stack_load
	load    [$sp + 3], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 0], $2
.count stack_load
	load    [$sp + 2], $3
	load    [$3 + 0], $4
	fmul    $2, $4, $2
	load    [$1 + 1], $4
	load    [$3 + 1], $5
	fmul    $4, $5, $4
	fadd    $2, $4, $2
	load    [$1 + 2], $1
	load    [$3 + 2], $4
	fmul    $1, $4, $1
	fadd    $2, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $14, [$sp + 9]
	bg      ble_else.31545
ble_then.31545:
	load    [$14 + 118], $2
.count load_float
	load    [f.27111], $3
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31545
ble_else.31545:
	load    [$14 + 119], $2
.count load_float
	load    [f.27110], $3
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31545:
bne_cont.31544:
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 9], $1
	load    [$1 + 4], $1
.count stack_load
	load    [$sp - 10], $2
	load    [$1 + $2], $1
	load    [$1 + 0], $2
	fmul    $2, $43, $2
	fadd    $46, $2, $2
.count move_float
	mov     $2, $46
	load    [$1 + 1], $2
	fmul    $2, $44, $2
	fadd    $47, $2, $2
.count move_float
	mov     $2, $47
	load    [$1 + 2], $1
	fmul    $1, $45, $1
	fadd    $48, $1, $1
.count move_float
	mov     $1, $48
	ret
.end calc_diffuse_using_1point

######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
	cmp     $3, 4
	bg      ble_else.31546
ble_then.31546:
	load    [$2 + 2], $14
	load    [$14 + $3], $15
	cmp     $15, 0
	bl      bge_else.31547
bge_then.31547:
	load    [$2 + 3], $15
	load    [$15 + $3], $16
	cmp     $16, 0
	bne     be_else.31548
be_then.31548:
	add     $3, 1, $3
	cmp     $3, 4
	bg      ble_else.31549
ble_then.31549:
	load    [$14 + $3], $1
	cmp     $1, 0
	bl      bge_else.31550
bge_then.31550:
	load    [$15 + $3], $1
	cmp     $1, 0
	bne     be_else.31551
be_then.31551:
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31551:
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
	add     $1, 1, $3
.count stack_load
	load    [$sp - 13], $2
	b       do_without_neighbors.2951
bge_else.31550:
	ret
ble_else.31549:
	ret
be_else.31548:
.count stack_move
	sub     $sp, 13, $sp
.count stack_store
	store   $15, [$sp + 2]
.count stack_store
	store   $14, [$sp + 3]
.count stack_store
	store   $3, [$sp + 4]
.count stack_store
	store   $2, [$sp + 0]
	load    [$2 + 5], $14
	load    [$14 + $3], $14
	load    [$14 + 0], $15
.count move_float
	mov     $15, $43
	load    [$14 + 1], $15
.count move_float
	mov     $15, $44
	load    [$14 + 2], $14
.count move_float
	mov     $14, $45
	load    [$2 + 7], $14
	load    [$2 + 1], $15
	load    [$2 + 6], $16
	load    [$14 + $3], $14
.count stack_store
	store   $14, [$sp + 5]
	load    [$15 + $3], $2
.count stack_store
	store   $2, [$sp + 6]
	load    [$16 + 0], $15
.count stack_store
	store   $15, [$sp + 7]
	cmp     $15, 0
	be      bne_cont.31552
bne_then.31552:
	load    [min_caml_dirvecs + 0], $15
	load    [$2 + 0], $16
.count move_float
	mov     $16, $51
	load    [$2 + 1], $16
.count move_float
	mov     $16, $52
	load    [$2 + 2], $16
.count move_float
	mov     $16, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$15 + 118], $16
	load    [$16 + 0], $16
	load    [$16 + 0], $17
	load    [$14 + 0], $18
	fmul    $17, $18, $17
	load    [$16 + 1], $18
	load    [$14 + 1], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	load    [$16 + 2], $16
	load    [$14 + 2], $18
	fmul    $16, $18, $16
	fadd    $17, $16, $16
	fcmp    $zero, $16
.count stack_store
	store   $15, [$sp + 8]
	bg      ble_else.31553
ble_then.31553:
	fmul    $16, $37, $3
	load    [$15 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31553
ble_else.31553:
	fmul    $16, $38, $3
	load    [$15 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31553:
bne_cont.31552:
.count stack_load
	load    [$sp + 7], $14
	cmp     $14, 1
	be      bne_cont.31554
bne_then.31554:
	load    [min_caml_dirvecs + 1], $14
.count stack_load
	load    [$sp + 6], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 9]
	bg      ble_else.31555
ble_then.31555:
	fmul    $15, $37, $3
	load    [$14 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31555
ble_else.31555:
	fmul    $15, $38, $3
	load    [$14 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31555:
bne_cont.31554:
.count stack_load
	load    [$sp + 7], $14
	cmp     $14, 2
	be      bne_cont.31556
bne_then.31556:
	load    [min_caml_dirvecs + 2], $14
.count stack_load
	load    [$sp + 6], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 10]
	bg      ble_else.31557
ble_then.31557:
	fmul    $15, $37, $3
	load    [$14 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31557
ble_else.31557:
	fmul    $15, $38, $3
	load    [$14 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 10], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31557:
bne_cont.31556:
.count stack_load
	load    [$sp + 7], $14
	cmp     $14, 3
	be      bne_cont.31558
bne_then.31558:
	load    [min_caml_dirvecs + 3], $14
.count stack_load
	load    [$sp + 6], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$15 + 0], $15
	load    [$15 + 0], $16
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 0], $17
	fmul    $16, $17, $16
	load    [$15 + 1], $17
	load    [$3 + 1], $18
	fmul    $17, $18, $17
	fadd    $16, $17, $16
	load    [$15 + 2], $15
	load    [$3 + 2], $17
	fmul    $15, $17, $15
	fadd    $16, $15, $15
	fcmp    $zero, $15
.count stack_store
	store   $14, [$sp + 11]
	bg      ble_else.31559
ble_then.31559:
	fmul    $15, $37, $3
	load    [$14 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31559
ble_else.31559:
	fmul    $15, $38, $3
	load    [$14 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 11], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31559:
bne_cont.31558:
.count stack_load
	load    [$sp + 7], $14
	cmp     $14, 4
	be      bne_cont.31560
bne_then.31560:
	load    [min_caml_dirvecs + 4], $14
.count stack_load
	load    [$sp + 6], $2
	load    [$2 + 0], $15
.count move_float
	mov     $15, $51
	load    [$2 + 1], $15
.count move_float
	mov     $15, $52
	load    [$2 + 2], $15
.count move_float
	mov     $15, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 0], $2
.count stack_load
	load    [$sp + 5], $3
	load    [$3 + 0], $4
	fmul    $2, $4, $2
	load    [$1 + 1], $4
	load    [$3 + 1], $5
	fmul    $4, $5, $4
	fadd    $2, $4, $2
	load    [$1 + 2], $1
	load    [$3 + 2], $4
	fmul    $1, $4, $1
	fadd    $2, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $14, [$sp + 12]
	bg      ble_else.31561
ble_then.31561:
	fmul    $1, $37, $3
	load    [$14 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31561
ble_else.31561:
	fmul    $1, $38, $3
	load    [$14 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 12], $2
.count stack_load
	load    [$sp + 5], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31561:
bne_cont.31560:
.count stack_load
	load    [$sp + 0], $2
	load    [$2 + 4], $1
.count stack_load
	load    [$sp + 4], $3
	load    [$1 + $3], $1
	load    [$1 + 0], $4
	fmul    $4, $43, $4
	fadd    $46, $4, $4
.count move_float
	mov     $4, $46
	load    [$1 + 1], $4
	fmul    $4, $44, $4
	fadd    $47, $4, $4
.count move_float
	mov     $4, $47
	load    [$1 + 2], $1
	fmul    $1, $45, $1
	fadd    $48, $1, $1
.count move_float
	mov     $1, $48
	add     $3, 1, $3
	cmp     $3, 4
	bg      ble_else.31562
ble_then.31562:
.count stack_load
	load    [$sp + 3], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bl      bge_else.31563
bge_then.31563:
.count stack_load
	load    [$sp + 2], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bne     be_else.31564
be_then.31564:
.count stack_move
	add     $sp, 13, $sp
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31564:
.count stack_store
	store   $3, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 13, $sp
.count stack_load
	load    [$sp - 12], $1
	add     $1, 1, $3
.count stack_load
	load    [$sp - 13], $2
	b       do_without_neighbors.2951
bge_else.31563:
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.31562:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31547:
	ret
ble_else.31546:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	cmp     $6, 4
	bg      ble_else.31565
ble_then.31565:
	load    [$4 + $2], $1
	load    [$1 + 2], $7
	load    [$7 + $6], $7
	cmp     $7, 0
	bl      bge_else.31566
bge_then.31566:
	load    [$3 + $2], $8
	load    [$8 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31567
be_then.31567:
	load    [$5 + $2], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31568
be_then.31568:
	sub     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31569
be_then.31569:
	add     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31570
be_then.31570:
	li      1, $7
	b       be_cont.31567
be_else.31570:
	li      0, $7
	b       be_cont.31567
be_else.31569:
	li      0, $7
	b       be_cont.31567
be_else.31568:
	li      0, $7
	b       be_cont.31567
be_else.31567:
	li      0, $7
be_cont.31567:
	cmp     $7, 0
	bne     be_else.31571
be_then.31571:
	cmp     $6, 4
	bg      ble_else.31572
ble_then.31572:
	load    [$4 + $2], $2
	load    [$2 + 2], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bl      bge_else.31573
bge_then.31573:
	load    [$2 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31574
be_then.31574:
	add     $6, 1, $3
	b       do_without_neighbors.2951
be_else.31574:
.count stack_move
	sub     $sp, 2, $sp
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $6, [$sp + 1]
.count move_args
	mov     $6, $3
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 2, $sp
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $3
.count stack_load
	load    [$sp - 2], $2
	b       do_without_neighbors.2951
bge_else.31573:
	ret
ble_else.31572:
	ret
be_else.31571:
	load    [$1 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31575
be_then.31575:
	add     $6, 1, $6
	b       try_exploit_neighbors.2967
be_else.31575:
	load    [$8 + 5], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
.count move_float
	mov     $7, $43
	load    [$1 + 1], $7
.count move_float
	mov     $7, $44
	load    [$1 + 2], $1
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
	fadd    $44, $7, $7
.count move_float
	mov     $7, $44
	load    [$1 + 2], $1
	fadd    $45, $1, $1
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
	fadd    $44, $7, $7
.count move_float
	mov     $7, $44
	load    [$1 + 2], $1
	fadd    $45, $1, $1
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
	fadd    $44, $7, $7
.count move_float
	mov     $7, $44
	load    [$1 + 2], $1
	fadd    $45, $1, $1
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
	fadd    $44, $7, $7
.count move_float
	mov     $7, $44
	load    [$1 + 2], $1
	fadd    $45, $1, $1
.count move_float
	mov     $1, $45
	load    [$4 + $2], $1
	load    [$1 + 4], $1
	load    [$1 + $6], $1
	load    [$1 + 0], $7
	fmul    $7, $43, $7
	fadd    $46, $7, $7
.count move_float
	mov     $7, $46
	load    [$1 + 1], $7
	fmul    $7, $44, $7
	fadd    $47, $7, $7
.count move_float
	mov     $7, $47
	load    [$1 + 2], $1
	fmul    $1, $45, $1
	fadd    $48, $1, $1
.count move_float
	mov     $1, $48
	add     $6, 1, $6
	b       try_exploit_neighbors.2967
bge_else.31566:
	ret
ble_else.31565:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	cmp     $3, 4
	bg      ble_else.31576
ble_then.31576:
	load    [$2 + 2], $14
	load    [$14 + $3], $15
	cmp     $15, 0
	bl      bge_else.31577
bge_then.31577:
	load    [$2 + 3], $15
	load    [$15 + $3], $16
	cmp     $16, 0
	bne     be_else.31578
be_then.31578:
	add     $3, 1, $16
	cmp     $16, 4
	bg      ble_else.31579
ble_then.31579:
	load    [$14 + $16], $14
	cmp     $14, 0
	bl      bge_else.31580
bge_then.31580:
	load    [$15 + $16], $14
	cmp     $14, 0
	bne     be_else.31581
be_then.31581:
	add     $16, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31581:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $16, [$sp + 0]
.count stack_store
	store   $2, [$sp + 1]
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $14
	load    [$2 + 7], $15
	load    [$2 + 1], $17
	load    [$17 + $16], $2
	load    [$2 + 0], $17
.count move_float
	mov     $17, $51
	load    [$2 + 1], $17
.count move_float
	mov     $17, $52
	load    [$2 + 2], $17
.count move_float
	mov     $17, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 0], $1
	load    [min_caml_dirvecs + $1], $2
	load    [$2 + 118], $1
	load    [$1 + 0], $1
	load    [$15 + $16], $3
	load    [$1 + 0], $4
	load    [$3 + 0], $5
	fmul    $4, $5, $4
	load    [$1 + 1], $5
	load    [$3 + 1], $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    [$1 + 2], $1
	load    [$3 + 2], $5
	fmul    $1, $5, $1
	fadd    $4, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $3, [$sp + 2]
.count stack_store
	store   $2, [$sp + 3]
	bg      ble_else.31582
ble_then.31582:
	fmul    $1, $37, $3
	load    [$2 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31582
ble_else.31582:
	fmul    $1, $38, $3
	load    [$2 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 3], $2
.count stack_load
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31582:
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 13], $2
	load    [$2 + 5], $1
.count stack_load
	load    [$sp - 14], $3
	load    [$1 + $3], $1
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	add     $3, 1, $3
	b       pretrace_diffuse_rays.2980
bge_else.31580:
	ret
ble_else.31579:
	ret
be_else.31578:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $15, [$sp + 4]
.count stack_store
	store   $14, [$sp + 5]
.count stack_store
	store   $2, [$sp + 1]
.count stack_store
	store   $3, [$sp + 6]
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $14
	load    [$2 + 7], $15
.count stack_store
	store   $15, [$sp + 7]
	load    [$2 + 1], $16
.count stack_store
	store   $16, [$sp + 8]
	load    [$16 + $3], $2
	load    [$2 + 0], $16
.count move_float
	mov     $16, $51
	load    [$2 + 1], $16
.count move_float
	mov     $16, $52
	load    [$2 + 2], $16
.count move_float
	mov     $16, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 0], $14
	load    [min_caml_dirvecs + $14], $2
.count stack_store
	store   $2, [$sp + 9]
	load    [$2 + 118], $14
	load    [$14 + 0], $14
	load    [$14 + 0], $16
.count stack_load
	load    [$sp + 6], $17
	load    [$15 + $17], $3
.count stack_store
	store   $3, [$sp + 10]
	load    [$3 + 0], $15
	fmul    $16, $15, $15
	load    [$14 + 1], $16
	load    [$3 + 1], $17
	fmul    $16, $17, $16
	fadd    $15, $16, $15
	load    [$14 + 2], $14
	load    [$3 + 2], $16
	fmul    $14, $16, $14
	fadd    $15, $14, $14
	fcmp    $zero, $14
	bg      ble_else.31583
ble_then.31583:
	load    [$2 + 118], $2
.count load_float
	load    [f.27111], $15
	fmul    $14, $37, $3
	call    trace_diffuse_ray.2926
	b       ble_cont.31583
ble_else.31583:
	load    [$2 + 119], $2
.count load_float
	load    [f.27110], $15
	fmul    $14, $38, $3
	call    trace_diffuse_ray.2926
ble_cont.31583:
	li      116, $4
.count stack_load
	load    [$sp + 9], $2
.count stack_load
	load    [$sp + 10], $3
	call    iter_trace_diffuse_rays.2929
.count stack_load
	load    [$sp + 1], $2
	load    [$2 + 5], $14
.count stack_load
	load    [$sp + 6], $15
	load    [$14 + $15], $16
	store   $43, [$16 + 0]
	store   $44, [$16 + 1]
	store   $45, [$16 + 2]
	add     $15, 1, $15
	cmp     $15, 4
	bg      ble_else.31584
ble_then.31584:
.count stack_load
	load    [$sp + 5], $16
	load    [$16 + $15], $16
	cmp     $16, 0
	bl      bge_else.31585
bge_then.31585:
.count stack_load
	load    [$sp + 4], $16
	load    [$16 + $15], $16
	cmp     $16, 0
	bne     be_else.31586
be_then.31586:
.count stack_move
	add     $sp, 14, $sp
	add     $15, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31586:
.count stack_store
	store   $15, [$sp + 0]
.count stack_store
	store   $14, [$sp + 11]
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 6], $14
.count stack_load
	load    [$sp + 8], $16
	load    [$16 + $15], $2
	load    [$2 + 0], $16
.count move_float
	mov     $16, $51
	load    [$2 + 1], $16
.count move_float
	mov     $16, $52
	load    [$2 + 2], $16
.count move_float
	mov     $16, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 0], $1
	load    [min_caml_dirvecs + $1], $2
	load    [$2 + 118], $1
	load    [$1 + 0], $1
.count stack_load
	load    [$sp + 7], $3
	load    [$3 + $15], $3
	load    [$1 + 0], $4
	load    [$3 + 0], $5
	fmul    $4, $5, $4
	load    [$1 + 1], $5
	load    [$3 + 1], $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    [$1 + 2], $1
	load    [$3 + 2], $5
	fmul    $1, $5, $1
	fadd    $4, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $3, [$sp + 12]
.count stack_store
	store   $2, [$sp + 13]
	bg      ble_else.31587
ble_then.31587:
	fmul    $1, $37, $3
	load    [$2 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 13], $2
.count stack_load
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31587
ble_else.31587:
	fmul    $1, $38, $3
	load    [$2 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 13], $2
.count stack_load
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31587:
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 14], $1
.count stack_load
	load    [$sp - 3], $2
	load    [$2 + $1], $2
	store   $43, [$2 + 0]
	store   $44, [$2 + 1]
	store   $45, [$2 + 2]
	add     $1, 1, $3
.count stack_load
	load    [$sp - 13], $2
	b       pretrace_diffuse_rays.2980
bge_else.31585:
.count stack_move
	add     $sp, 14, $sp
	ret
ble_else.31584:
.count stack_move
	add     $sp, 14, $sp
	ret
bge_else.31577:
	ret
ble_else.31576:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	cmp     $3, 0
	bl      bge_else.31588
bge_then.31588:
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
	load    [min_caml_screenx_dir + 0], $10
	load    [min_caml_scan_pitch + 0], $11
	load    [min_caml_image_center + 0], $12
	sub     $3, $12, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $14
	fmul    $11, $14, $14
	fmul    $14, $10, $15
.count stack_load
	load    [$sp + 5], $16
	fadd    $15, $16, $15
	store   $15, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_screenx_dir + 1], $15
	fmul    $14, $15, $15
.count stack_load
	load    [$sp + 4], $16
	fadd    $15, $16, $15
	store   $15, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $15
	fmul    $14, $15, $14
.count stack_load
	load    [$sp + 3], $15
	fadd    $14, $15, $14
	store   $14, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $14
	fmul    $14, $14, $15
	load    [min_caml_ptrace_dirvec + 1], $16
	fmul    $16, $16, $16
	fadd    $15, $16, $15
	load    [min_caml_ptrace_dirvec + 2], $16
	fmul    $16, $16, $16
	fadd    $15, $16, $15
	fsqrt   $15, $15
	fcmp    $15, $zero
	bne     be_else.31589
be_then.31589:
	mov     $36, $15
	b       be_cont.31589
be_else.31589:
	finv    $15, $15
be_cont.31589:
	fmul    $14, $15, $14
	store   $14, [min_caml_ptrace_dirvec + 0]
	load    [min_caml_ptrace_dirvec + 1], $14
	fmul    $14, $15, $14
	store   $14, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $14
	fmul    $14, $15, $14
	store   $14, [min_caml_ptrace_dirvec + 2]
.count move_float
	mov     $zero, $46
.count move_float
	mov     $zero, $47
.count move_float
	mov     $zero, $48
	load    [min_caml_viewpoint + 0], $14
	store   $14, [min_caml_startp + 0]
	load    [min_caml_viewpoint + 1], $14
	store   $14, [min_caml_startp + 1]
	load    [min_caml_viewpoint + 2], $14
	store   $14, [min_caml_startp + 2]
	li      min_caml_ptrace_dirvec, $4
	li      0, $2
.count stack_load
	load    [$sp + 1], $14
.count stack_load
	load    [$sp + 2], $15
	load    [$15 + $14], $5
.count move_args
	mov     $zero, $6
.count move_args
	mov     $36, $3
	call    trace_ray.2920
.count stack_load
	load    [$sp + 1], $14
.count stack_load
	load    [$sp + 2], $15
	load    [$15 + $14], $16
	load    [$16 + 0], $16
	store   $46, [$16 + 0]
	store   $47, [$16 + 1]
	store   $48, [$16 + 2]
	load    [$15 + $14], $16
	load    [$16 + 6], $16
.count stack_load
	load    [$sp + 0], $17
	store   $17, [$16 + 0]
	load    [$15 + $14], $2
	load    [$2 + 2], $14
	load    [$14 + 0], $14
	cmp     $14, 0
	bl      bge_cont.31590
bge_then.31590:
	load    [$2 + 3], $14
	load    [$14 + 0], $14
	cmp     $14, 0
	bne     be_else.31591
be_then.31591:
	li      1, $3
	call    pretrace_diffuse_rays.2980
	b       be_cont.31591
be_else.31591:
.count stack_store
	store   $2, [$sp + 6]
	load    [$2 + 6], $14
	load    [$14 + 0], $14
.count move_float
	mov     $zero, $43
.count move_float
	mov     $zero, $44
.count move_float
	mov     $zero, $45
	load    [$2 + 7], $15
	load    [$2 + 1], $16
	load    [min_caml_dirvecs + $14], $14
	load    [$15 + 0], $15
	load    [$16 + 0], $2
	load    [$2 + 0], $16
.count move_float
	mov     $16, $51
	load    [$2 + 1], $16
.count move_float
	mov     $16, $52
	load    [$2 + 2], $16
.count move_float
	mov     $16, $53
	sub     $41, 1, $3
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 0], $2
	load    [$15 + 0], $3
	fmul    $2, $3, $2
	load    [$1 + 1], $3
	load    [$15 + 1], $4
	fmul    $3, $4, $3
	fadd    $2, $3, $2
	load    [$1 + 2], $1
	load    [$15 + 2], $3
	fmul    $1, $3, $1
	fadd    $2, $1, $1
	fcmp    $zero, $1
.count stack_store
	store   $15, [$sp + 7]
.count stack_store
	store   $14, [$sp + 8]
	bg      ble_else.31592
ble_then.31592:
	fmul    $1, $37, $3
	load    [$14 + 118], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31592
ble_else.31592:
	fmul    $1, $38, $3
	load    [$14 + 119], $2
	call    trace_diffuse_ray.2926
	li      116, $4
.count stack_load
	load    [$sp + 8], $2
.count stack_load
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31592:
.count stack_load
	load    [$sp + 6], $2
	load    [$2 + 5], $1
	load    [$1 + 0], $1
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	li      1, $3
	call    pretrace_diffuse_rays.2980
be_cont.31591:
bge_cont.31590:
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 8], $1
	sub     $1, 1, $3
.count stack_load
	load    [$sp - 9], $1
	add     $1, 1, $4
	cmp     $4, 5
.count stack_load
	load    [$sp - 6], $7
.count stack_load
	load    [$sp - 5], $6
.count stack_load
	load    [$sp - 4], $5
.count stack_load
	load    [$sp - 7], $2
	bl      pretrace_pixels.2983
	sub     $4, 5, $4
	b       pretrace_pixels.2983
bge_else.31588:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.2994:
	cmp     $50, $2
	bg      ble_else.31594
ble_then.31594:
	ret
ble_else.31594:
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
.count move_float
	mov     $11, $47
	load    [$10 + 2], $10
.count move_float
	mov     $10, $48
	add     $3, 1, $10
.count stack_store
	store   $10, [$sp + 5]
	cmp     $60, $10
	bg      ble_else.31595
ble_then.31595:
	li      0, $10
	b       ble_cont.31595
ble_else.31595:
	cmp     $3, 0
	bg      ble_else.31596
ble_then.31596:
	li      0, $10
	b       ble_cont.31596
ble_else.31596:
	add     $2, 1, $10
	cmp     $50, $10
	bg      ble_else.31597
ble_then.31597:
	li      0, $10
	b       ble_cont.31597
ble_else.31597:
	cmp     $2, 0
	bg      ble_else.31598
ble_then.31598:
	li      0, $10
	b       ble_cont.31598
ble_else.31598:
	li      1, $10
ble_cont.31598:
ble_cont.31597:
ble_cont.31596:
ble_cont.31595:
	cmp     $10, 0
	li      0, $3
	bne     be_else.31599
be_then.31599:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31599
bge_then.31600:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31601
be_then.31601:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31599
be_else.31601:
.count stack_store
	store   $2, [$sp + 6]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 6], $2
	call    do_without_neighbors.2951
	b       be_cont.31599
be_else.31599:
	load    [$5 + $2], $10
	load    [$10 + 2], $11
	load    [$11 + 0], $11
	cmp     $11, 0
	bl      bge_cont.31602
bge_then.31602:
	load    [$4 + $2], $12
	load    [$12 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31603
be_then.31603:
	load    [$6 + $2], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31604
be_then.31604:
	sub     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31605
be_then.31605:
	add     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31606
be_then.31606:
	li      1, $11
	b       be_cont.31603
be_else.31606:
	li      0, $11
	b       be_cont.31603
be_else.31605:
	li      0, $11
	b       be_cont.31603
be_else.31604:
	li      0, $11
	b       be_cont.31603
be_else.31603:
	li      0, $11
be_cont.31603:
	cmp     $11, 0
	bne     be_else.31607
be_then.31607:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31607
bge_then.31608:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31609
be_then.31609:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31607
be_else.31609:
.count stack_store
	store   $2, [$sp + 7]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 7], $2
	call    do_without_neighbors.2951
	b       be_cont.31607
be_else.31607:
	load    [$10 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
.count move_args
	mov     $4, $3
.count move_args
	mov     $5, $4
	bne     be_else.31610
be_then.31610:
	li      1, $10
.count move_args
	mov     $6, $5
.count move_args
	mov     $10, $6
	call    try_exploit_neighbors.2967
	b       be_cont.31610
be_else.31610:
	load    [$12 + 5], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $43
	load    [$10 + 1], $11
.count move_float
	mov     $11, $44
	load    [$10 + 2], $10
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
	fadd    $44, $11, $11
.count move_float
	mov     $11, $44
	load    [$10 + 2], $10
	fadd    $45, $10, $10
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
	fadd    $44, $11, $11
.count move_float
	mov     $11, $44
	load    [$10 + 2], $10
	fadd    $45, $10, $10
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
	fadd    $44, $11, $11
.count move_float
	mov     $11, $44
	load    [$10 + 2], $10
	fadd    $45, $10, $10
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
	fadd    $44, $11, $11
.count move_float
	mov     $11, $44
	load    [$10 + 2], $10
	fadd    $45, $10, $10
.count move_float
	mov     $10, $45
	load    [$5 + $2], $10
	load    [$10 + 4], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
	fmul    $11, $43, $11
	fadd    $46, $11, $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
	fmul    $11, $44, $11
	fadd    $47, $11, $11
.count move_float
	mov     $11, $47
	load    [$10 + 2], $10
	fmul    $10, $45, $10
	fadd    $48, $10, $10
.count move_float
	mov     $10, $48
	li      1, $10
.count move_args
	mov     $6, $5
.count move_args
	mov     $10, $6
	call    try_exploit_neighbors.2967
be_cont.31610:
be_cont.31607:
bge_cont.31602:
be_cont.31599:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31611
ble_then.31611:
	cmp     $2, 0
	bl      bge_else.31612
bge_then.31612:
	call    min_caml_write
	b       ble_cont.31611
bge_else.31612:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31611
ble_else.31611:
	li      255, $2
	call    min_caml_write
ble_cont.31611:
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31613
ble_then.31613:
	cmp     $2, 0
	bl      bge_else.31614
bge_then.31614:
	call    min_caml_write
	b       ble_cont.31613
bge_else.31614:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31613
ble_else.31613:
	li      255, $2
	call    min_caml_write
ble_cont.31613:
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31615
ble_then.31615:
	cmp     $2, 0
	bl      bge_else.31616
bge_then.31616:
	call    min_caml_write
	b       ble_cont.31615
bge_else.31616:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31615
ble_else.31615:
	li      255, $2
	call    min_caml_write
ble_cont.31615:
.count stack_load
	load    [$sp + 4], $10
	add     $10, 1, $2
	cmp     $50, $2
	bg      ble_else.31617
ble_then.31617:
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.31617:
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
.count move_float
	mov     $11, $47
	load    [$10 + 2], $10
.count move_float
	mov     $10, $48
.count stack_load
	load    [$sp + 5], $10
	cmp     $60, $10
	bg      ble_else.31618
ble_then.31618:
	li      0, $10
	b       ble_cont.31618
ble_else.31618:
.count stack_load
	load    [$sp + 2], $10
	cmp     $10, 0
	bg      ble_else.31619
ble_then.31619:
	li      0, $10
	b       ble_cont.31619
ble_else.31619:
	add     $2, 1, $10
	cmp     $50, $10
	bg      ble_else.31620
ble_then.31620:
	li      0, $10
	b       ble_cont.31620
ble_else.31620:
	cmp     $2, 0
	bg      ble_else.31621
ble_then.31621:
	li      0, $10
	b       ble_cont.31621
ble_else.31621:
	li      1, $10
ble_cont.31621:
ble_cont.31620:
ble_cont.31619:
ble_cont.31618:
	cmp     $10, 0
	bne     be_else.31622
be_then.31622:
	load    [$4 + $2], $2
	li      0, $3
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
	b       be_cont.31622
be_else.31624:
.count stack_store
	store   $2, [$sp + 9]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 9], $2
	call    do_without_neighbors.2951
	b       be_cont.31622
be_else.31622:
	li      0, $6
.count stack_load
	load    [$sp + 1], $3
.count stack_load
	load    [$sp + 0], $5
	call    try_exploit_neighbors.2967
be_cont.31622:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31625
ble_then.31625:
	cmp     $1, 0
	bge     ble_cont.31625
bl_then.31626:
	li      0, $1
	b       ble_cont.31625
ble_else.31625:
	li      255, $1
ble_cont.31625:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31627
ble_then.31627:
	cmp     $1, 0
	bge     ble_cont.31627
bl_then.31628:
	li      0, $1
	b       ble_cont.31627
ble_else.31627:
	li      255, $1
ble_cont.31627:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31629
ble_then.31629:
	cmp     $1, 0
	bge     ble_cont.31629
bl_then.31630:
	li      0, $1
	b       ble_cont.31629
ble_else.31629:
	li      255, $1
ble_cont.31629:
	mov     $1, $2
	call    min_caml_write
.count stack_move
	add     $sp, 10, $sp
.count stack_load
	load    [$sp - 2], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 8], $3
.count stack_load
	load    [$sp - 9], $4
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
	bg      ble_else.31631
ble_then.31631:
	ret
ble_else.31631:
.count stack_move
	sub     $sp, 8, $sp
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
	sub     $60, 1, $10
	cmp     $10, $2
	ble     bg_cont.31632
bg_then.31632:
	add     $2, 1, $10
	load    [min_caml_scan_pitch + 0], $11
	load    [min_caml_image_center + 1], $12
	sub     $10, $12, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $10
	fmul    $11, $10, $10
	load    [min_caml_screeny_dir + 0], $11
	fmul    $10, $11, $11
	load    [min_caml_screenz_dir + 0], $12
	fadd    $11, $12, $5
	load    [min_caml_screeny_dir + 1], $11
	fmul    $10, $11, $11
	load    [min_caml_screenz_dir + 1], $12
	fadd    $11, $12, $6
	load    [min_caml_screeny_dir + 2], $11
	fmul    $10, $11, $10
	load    [min_caml_screenz_dir + 2], $11
	fadd    $10, $11, $7
	sub     $50, 1, $3
.count stack_load
	load    [$sp + 1], $2
.count stack_load
	load    [$sp + 0], $4
	call    pretrace_pixels.2983
bg_cont.31632:
	li      0, $2
	cmp     $50, 0
	ble     bg_cont.31633
bg_then.31633:
.count stack_load
	load    [$sp + 4], $4
	load    [$4 + 0], $10
	load    [$10 + 0], $10
	load    [$10 + 0], $11
.count move_float
	mov     $11, $46
	load    [$10 + 1], $11
.count move_float
	mov     $11, $47
	load    [$10 + 2], $10
.count move_float
	mov     $10, $48
.count stack_load
	load    [$sp + 3], $10
	add     $10, 1, $11
	cmp     $60, $11
	bg      ble_else.31634
ble_then.31634:
	li      0, $10
	b       ble_cont.31634
ble_else.31634:
	cmp     $10, 0
	li      0, $10
	ble     bg_cont.31635
bg_then.31635:
	cmp     $50, 1
bg_cont.31635:
ble_cont.31634:
	cmp     $10, 0
	bne     be_else.31636
be_then.31636:
	load    [$4 + 0], $2
	li      0, $3
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31636
bge_then.31637:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31638
be_then.31638:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31636
be_else.31638:
.count stack_store
	store   $2, [$sp + 5]
	call    calc_diffuse_using_1point.2942
	li      1, $3
.count stack_load
	load    [$sp + 5], $2
	call    do_without_neighbors.2951
	b       be_cont.31636
be_else.31636:
	li      0, $6
.count stack_load
	load    [$sp + 2], $3
.count stack_load
	load    [$sp + 1], $5
	call    try_exploit_neighbors.2967
be_cont.31636:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31639
ble_then.31639:
	cmp     $1, 0
	bge     ble_cont.31639
bl_then.31640:
	li      0, $1
	b       ble_cont.31639
ble_else.31639:
	li      255, $1
ble_cont.31639:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31641
ble_then.31641:
	cmp     $1, 0
	bge     ble_cont.31641
bl_then.31642:
	li      0, $1
	b       ble_cont.31641
ble_else.31641:
	li      255, $1
ble_cont.31641:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31643
ble_then.31643:
	cmp     $1, 0
	bge     ble_cont.31643
bl_then.31644:
	li      0, $1
	b       ble_cont.31643
ble_else.31643:
	li      255, $1
ble_cont.31643:
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
bg_cont.31633:
.count stack_load
	load    [$sp + 3], $10
	add     $10, 1, $10
	cmp     $60, $10
	bg      ble_else.31645
ble_then.31645:
.count stack_move
	add     $sp, 8, $sp
	ret
ble_else.31645:
.count stack_store
	store   $10, [$sp + 6]
	sub     $60, 1, $11
.count stack_load
	load    [$sp + 0], $12
	add     $12, 2, $12
	cmp     $12, 5
	bl      bge_cont.31646
bge_then.31646:
	sub     $12, 5, $12
bge_cont.31646:
.count stack_store
	store   $12, [$sp + 7]
	cmp     $11, $10
	ble     bg_cont.31647
bg_then.31647:
	add     $10, 1, $10
	sub     $50, 1, $11
	load    [min_caml_screeny_dir + 0], $13
	load    [min_caml_scan_pitch + 0], $14
	load    [min_caml_image_center + 1], $15
	sub     $10, $15, $2
	call    min_caml_float_of_int
	fmul    $14, $1, $1
	fmul    $1, $13, $2
	load    [min_caml_screenz_dir + 0], $3
	fadd    $2, $3, $5
	load    [min_caml_screeny_dir + 1], $2
	fmul    $1, $2, $2
	load    [min_caml_screenz_dir + 1], $3
	fadd    $2, $3, $6
	load    [min_caml_screeny_dir + 2], $2
	fmul    $1, $2, $1
	load    [min_caml_screenz_dir + 2], $2
	fadd    $1, $2, $7
.count stack_load
	load    [$sp + 2], $2
.count move_args
	mov     $12, $4
.count move_args
	mov     $11, $3
	call    pretrace_pixels.2983
bg_cont.31647:
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
	add     $1, 1, $2
.count stack_load
	load    [$sp - 1], $1
	add     $1, 2, $6
	cmp     $6, 5
.count stack_load
	load    [$sp - 4], $5
.count stack_load
	load    [$sp - 6], $4
.count stack_load
	load    [$sp - 7], $3
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
	bl      bge_else.31649
bge_then.31649:
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
	bl      bge_else.31650
bge_then.31650:
	call    create_pixel.3008
.count move_ret
	mov     $1, $10
.count storer
	add     $21, $19, $tmp
	store   $10, [$tmp + 0]
	sub     $19, 1, $10
	cmp     $10, 0
	bl      bge_else.31651
bge_then.31651:
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
	bl      bge_else.31652
bge_then.31652:
	call    create_pixel.3008
.count stack_move
	add     $sp, 2, $sp
.count storer
	add     $21, $19, $tmp
	store   $1, [$tmp + 0]
	sub     $19, 1, $3
.count move_args
	mov     $21, $2
	b       init_line_elements.3010
bge_else.31652:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31651:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31650:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31649:
	mov     $2, $1
	ret
.end init_line_elements

######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	cmp     $2, 5
	bl      bge_else.31653
bge_then.31653:
	load    [min_caml_dirvecs + $7], $1
	load    [$1 + $8], $2
	load    [$2 + 0], $2
	fmul    $3, $3, $5
	fmul    $4, $4, $6
	fadd    $5, $6, $5
	fadd    $5, $36, $5
	fsqrt   $5, $5
	finv    $5, $5
	fmul    $3, $5, $3
	store   $3, [$2 + 0]
	fmul    $4, $5, $4
	store   $4, [$2 + 1]
	store   $5, [$2 + 2]
	add     $8, 40, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $3, [$2 + 0]
	store   $5, [$2 + 1]
	fneg    $4, $6
	store   $6, [$2 + 2]
	add     $8, 80, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $5, [$2 + 0]
	fneg    $3, $7
	store   $7, [$2 + 1]
	store   $6, [$2 + 2]
	add     $8, 1, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $7, [$2 + 0]
	store   $6, [$2 + 1]
	fneg    $5, $5
	store   $5, [$2 + 2]
	add     $8, 41, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $7, [$2 + 0]
	store   $5, [$2 + 1]
	store   $4, [$2 + 2]
	add     $8, 81, $2
	load    [$1 + $2], $1
	load    [$1 + 0], $1
	store   $5, [$1 + 0]
	store   $3, [$1 + 1]
	store   $4, [$1 + 2]
	ret
bge_else.31653:
.count stack_move
	sub     $sp, 7, $sp
.count stack_store
	store   $8, [$sp + 0]
.count stack_store
	store   $7, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
.count stack_store
	store   $6, [$sp + 3]
.count stack_store
	store   $5, [$sp + 4]
	fmul    $4, $4, $11
.count load_float
	load    [f.27098], $12
	fadd    $11, $12, $11
	fsqrt   $11, $11
	finv    $11, $2
	call    min_caml_atan
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 4], $14
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
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 3], $15
	fmul    $13, $15, $2
.count stack_store
	store   $2, [$sp + 6]
	call    min_caml_sin
.count move_ret
	mov     $1, $13
.count stack_load
	load    [$sp + 6], $2
	call    min_caml_cos
.count stack_move
	add     $sp, 7, $sp
	finv    $1, $1
	fmul    $13, $1, $1
	fmul    $1, $12, $4
.count stack_load
	load    [$sp - 5], $1
	add     $1, 1, $2
.count stack_load
	load    [$sp - 6], $7
.count stack_load
	load    [$sp - 7], $8
.count move_args
	mov     $15, $6
.count move_args
	mov     $14, $5
.count move_args
	mov     $11, $3
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	cmp     $2, 0
	bl      bge_else.31654
bge_then.31654:
.count stack_move
	sub     $sp, 11, $sp
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $5, [$sp + 1]
.count stack_store
	store   $4, [$sp + 2]
.count stack_store
	store   $3, [$sp + 3]
	li      0, $10
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
.count load_float
	load    [f.27139], $17
	fmul    $16, $17, $16
.count load_float
	load    [f.27140], $18
	fsub    $16, $18, $5
.count stack_load
	load    [$sp + 3], $6
.count stack_load
	load    [$sp + 2], $7
.count stack_load
	load    [$sp + 1], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
.count stack_load
	load    [$sp + 1], $19
	add     $19, 2, $8
.count stack_store
	store   $8, [$sp + 4]
.count load_float
	load    [f.27098], $20
	fadd    $16, $20, $5
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
	bl      bge_else.31655
bge_then.31655:
.count stack_store
	store   $2, [$sp + 5]
	li      0, $10
.count stack_load
	load    [$sp + 2], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31656
bge_then.31656:
	sub     $11, 5, $11
bge_cont.31656:
.count stack_store
	store   $11, [$sp + 6]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
	fsub    $16, $18, $5
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
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
	cmp     $2, 0
	bl      bge_else.31657
bge_then.31657:
.count stack_store
	store   $2, [$sp + 7]
	li      0, $10
.count stack_load
	load    [$sp + 6], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31658
bge_then.31658:
	sub     $11, 5, $11
bge_cont.31658:
.count stack_store
	store   $11, [$sp + 8]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
	fsub    $16, $18, $5
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
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
	cmp     $2, 0
	bl      bge_else.31659
bge_then.31659:
.count stack_store
	store   $2, [$sp + 9]
	li      0, $10
.count stack_load
	load    [$sp + 8], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31660
bge_then.31660:
	sub     $11, 5, $11
bge_cont.31660:
.count stack_store
	store   $11, [$sp + 10]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	fmul    $16, $17, $16
	fsub    $16, $18, $5
.count stack_load
	load    [$sp + 3], $6
.count move_args
	mov     $19, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
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
.count stack_load
	load    [$sp - 2], $1
	sub     $1, 1, $2
.count stack_load
	load    [$sp - 1], $1
	add     $1, 1, $4
	cmp     $4, 5
.count move_args
	mov     $19, $5
.count stack_load
	load    [$sp - 8], $3
	bl      calc_dirvecs.3028
	sub     $4, 5, $4
	b       calc_dirvecs.3028
bge_else.31659:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31657:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31655:
.count stack_move
	add     $sp, 11, $sp
	ret
bge_else.31654:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	cmp     $2, 0
	bl      bge_else.31662
bge_then.31662:
.count stack_move
	sub     $sp, 20, $sp
.count stack_store
	store   $4, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
.count stack_store
	store   $2, [$sp + 2]
	li      0, $10
.count load_float
	load    [f.27140], $11
.count stack_store
	store   $11, [$sp + 3]
.count load_float
	load    [f.27139], $12
.count stack_store
	store   $12, [$sp + 4]
	li      4, $2
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
	fsub    $16, $11, $6
.count stack_store
	store   $6, [$sp + 7]
.count stack_load
	load    [$sp + 1], $7
.count stack_load
	load    [$sp + 0], $8
.count move_args
	mov     $13, $5
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
.count stack_load
	load    [$sp + 0], $16
	add     $16, 2, $8
.count stack_store
	store   $8, [$sp + 8]
.count load_float
	load    [f.27098], $17
.count stack_load
	load    [$sp + 5], $18
	fadd    $18, $17, $5
.count stack_store
	store   $5, [$sp + 9]
.count stack_load
	load    [$sp + 7], $6
.count stack_load
	load    [$sp + 1], $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	li      0, $10
.count stack_load
	load    [$sp + 1], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31663
bge_then.31663:
	sub     $11, 5, $11
bge_cont.31663:
.count stack_store
	store   $11, [$sp + 10]
	li      3, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
.count stack_load
	load    [$sp + 4], $19
	fmul    $18, $19, $18
.count stack_load
	load    [$sp + 3], $20
	fsub    $18, $20, $5
.count stack_store
	store   $5, [$sp + 11]
.count stack_load
	load    [$sp + 7], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count move_args
	mov     $10, $2
	call    calc_dirvec.3020
	li      0, $2
	fadd    $18, $17, $5
.count stack_store
	store   $5, [$sp + 12]
.count stack_load
	load    [$sp + 7], $6
.count stack_load
	load    [$sp + 10], $7
.count stack_load
	load    [$sp + 8], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	li      0, $10
.count stack_load
	load    [$sp + 10], $11
	add     $11, 1, $11
	cmp     $11, 5
	bl      bge_cont.31664
bge_then.31664:
	sub     $11, 5, $11
bge_cont.31664:
.count stack_store
	store   $11, [$sp + 13]
	li      2, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
	fmul    $18, $19, $18
	fsub    $18, $20, $5
.count stack_load
	load    [$sp + 7], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $11, $7
.count move_args
	mov     $zero, $4
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
	li      1, $2
.count stack_load
	load    [$sp + 13], $21
	add     $21, 1, $21
	cmp     $21, 5
	bl      bge_cont.31665
bge_then.31665:
	sub     $21, 5, $21
bge_cont.31665:
	mov     $21, $4
.count stack_load
	load    [$sp + 7], $3
.count move_args
	mov     $16, $5
	call    calc_dirvecs.3028
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31666
bge_then.31666:
.count stack_store
	store   $2, [$sp + 14]
.count stack_load
	load    [$sp + 1], $10
	add     $10, 2, $10
	cmp     $10, 5
	bl      bge_cont.31667
bge_then.31667:
	sub     $10, 5, $10
bge_cont.31667:
.count stack_store
	store   $10, [$sp + 15]
.count stack_load
	load    [$sp + 0], $11
	add     $11, 4, $11
.count stack_store
	store   $11, [$sp + 16]
	li      0, $12
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
.count stack_load
	load    [$sp + 4], $17
	fmul    $16, $17, $16
.count stack_load
	load    [$sp + 3], $17
	fsub    $16, $17, $6
.count stack_store
	store   $6, [$sp + 17]
.count stack_load
	load    [$sp + 6], $5
.count move_args
	mov     $11, $8
.count move_args
	mov     $10, $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
.count move_args
	mov     $12, $2
	call    calc_dirvec.3020
	li      0, $2
.count stack_load
	load    [$sp + 16], $16
	add     $16, 2, $8
.count stack_store
	store   $8, [$sp + 18]
.count stack_load
	load    [$sp + 9], $5
.count stack_load
	load    [$sp + 17], $6
.count stack_load
	load    [$sp + 15], $7
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	li      0, $2
.count stack_load
	load    [$sp + 15], $17
	add     $17, 1, $17
	cmp     $17, 5
	bl      bge_cont.31668
bge_then.31668:
	sub     $17, 5, $17
bge_cont.31668:
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
	li      2, $2
.count stack_load
	load    [$sp + 19], $21
	add     $21, 1, $21
	cmp     $21, 5
	bl      bge_cont.31669
bge_then.31669:
	sub     $21, 5, $21
bge_cont.31669:
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
	cmp     $3, 5
.count stack_load
	load    [$sp - 4], $1
	add     $1, 4, $4
	bl      calc_dirvec_rows.3033
	sub     $3, 5, $3
	b       calc_dirvec_rows.3033
bge_else.31666:
.count stack_move
	add     $sp, 20, $sp
	ret
bge_else.31662:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	cmp     $3, 0
	bl      bge_else.31671
bge_then.31671:
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
	add     $hp, 2, $hp
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 2], $10
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
	bl      bge_else.31672
bge_then.31672:
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
.count move_ret
	mov     $1, $11
	mov     $hp, $13
	add     $hp, 2, $hp
	store   $11, [$13 + 1]
.count stack_load
	load    [$sp + 3], $11
	store   $11, [$13 + 0]
	mov     $13, $11
.count storer
	add     $12, $10, $tmp
	store   $11, [$tmp + 0]
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31673
bge_then.31673:
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
.count move_ret
	mov     $1, $11
	mov     $hp, $13
	add     $hp, 2, $hp
	store   $11, [$13 + 1]
.count stack_load
	load    [$sp + 4], $11
	store   $11, [$13 + 0]
	mov     $13, $11
.count storer
	add     $12, $10, $tmp
	store   $11, [$tmp + 0]
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31674
bge_then.31674:
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
.count stack_move
	add     $sp, 6, $sp
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, [$2 + 1]
.count stack_load
	load    [$sp - 1], $1
	store   $1, [$2 + 0]
	mov     $2, $1
.count storer
	add     $12, $10, $tmp
	store   $1, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $12, $2
	b       create_dirvec_elements.3039
bge_else.31674:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31673:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31672:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31671:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	cmp     $2, 0
	bl      bge_else.31675
bge_then.31675:
.count stack_move
	sub     $sp, 9, $sp
.count stack_store
	store   $2, [$sp + 0]
	li      3, $2
.count move_args
	mov     $zero, $3
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
	li      120, $2
	mov     $hp, $11
	add     $hp, 2, $hp
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 1], $10
	store   $10, [$11 + 0]
	mov     $11, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 0], $11
	store   $10, [min_caml_dirvecs + $11]
	li      3, $2
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
	load    [min_caml_dirvecs + $11], $11
	mov     $hp, $12
	add     $hp, 2, $hp
	store   $10, [$12 + 1]
.count stack_load
	load    [$sp + 2], $10
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 118]
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
.count move_ret
	mov     $1, $10
	mov     $hp, $12
	add     $hp, 2, $hp
	store   $10, [$12 + 1]
.count stack_load
	load    [$sp + 3], $10
	store   $10, [$12 + 0]
	mov     $12, $10
	store   $10, [$11 + 117]
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
.count move_ret
	mov     $1, $14
	mov     $hp, $15
	add     $hp, 2, $hp
	store   $14, [$15 + 1]
.count stack_load
	load    [$sp + 4], $14
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$11 + 116]
	li      115, $3
.count move_args
	mov     $11, $2
	call    create_dirvec_elements.3039
.count stack_load
	load    [$sp + 0], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31676
bge_then.31676:
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
.count move_ret
	mov     $1, $11
	li      120, $2
	mov     $hp, $12
	add     $hp, 2, $hp
	store   $11, [$12 + 1]
.count stack_load
	load    [$sp + 6], $11
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
	load    [min_caml_dirvecs + $10], $10
	mov     $hp, $12
	add     $hp, 2, $hp
	store   $11, [$12 + 1]
.count stack_load
	load    [$sp + 7], $11
	store   $11, [$12 + 0]
	mov     $12, $11
	store   $11, [$10 + 118]
	li      3, $2
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
	add     $hp, 2, $hp
	store   $14, [$15 + 1]
.count stack_load
	load    [$sp + 8], $14
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$10 + 117]
	li      116, $3
.count move_args
	mov     $10, $2
	call    create_dirvec_elements.3039
.count stack_move
	add     $sp, 9, $sp
.count stack_load
	load    [$sp - 4], $1
	sub     $1, 1, $2
	b       create_dirvecs.3042
bge_else.31676:
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.31675:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	cmp     $3, 0
	bl      bge_else.31677
bge_then.31677:
.count stack_move
	sub     $sp, 4, $sp
.count stack_store
	store   $2, [$sp + 0]
.count stack_store
	store   $3, [$sp + 1]
	sub     $41, 1, $10
	load    [$2 + $3], $11
	cmp     $10, 0
	bl      bge_cont.31678
bge_then.31678:
	load    [$11 + 1], $12
	load    [min_caml_objects + $10], $13
	load    [$13 + 1], $14
	load    [$11 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31679
be_then.31679:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$15 + 0], $17
	fcmp    $17, $zero
	bne     be_else.31680
be_then.31680:
	store   $zero, [$16 + 1]
	b       be_cont.31680
be_else.31680:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31681
ble_then.31681:
	li      0, $17
	b       ble_cont.31681
ble_else.31681:
	li      1, $17
ble_cont.31681:
	cmp     $18, 0
	be      bne_cont.31682
bne_then.31682:
	cmp     $17, 0
	bne     be_else.31683
be_then.31683:
	li      1, $17
	b       be_cont.31683
be_else.31683:
	li      0, $17
be_cont.31683:
bne_cont.31682:
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	cmp     $17, 0
	bne     be_else.31684
be_then.31684:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31684
be_else.31684:
	store   $18, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31684:
be_cont.31680:
	load    [$15 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31685
be_then.31685:
	store   $zero, [$16 + 3]
	b       be_cont.31685
be_else.31685:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31686
ble_then.31686:
	li      0, $17
	b       ble_cont.31686
ble_else.31686:
	li      1, $17
ble_cont.31686:
	cmp     $18, 0
	be      bne_cont.31687
bne_then.31687:
	cmp     $17, 0
	bne     be_else.31688
be_then.31688:
	li      1, $17
	b       be_cont.31688
be_else.31688:
	li      0, $17
be_cont.31688:
bne_cont.31687:
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	cmp     $17, 0
	bne     be_else.31689
be_then.31689:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31689
be_else.31689:
	store   $18, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31689:
be_cont.31685:
	load    [$15 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31690
be_then.31690:
	store   $zero, [$16 + 5]
.count storer
	add     $12, $10, $tmp
	store   $16, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31679
be_else.31690:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31691
ble_then.31691:
	li      0, $17
	b       ble_cont.31691
ble_else.31691:
	li      1, $17
ble_cont.31691:
	cmp     $18, 0
	be      bne_cont.31692
bne_then.31692:
	cmp     $17, 0
	bne     be_else.31693
be_then.31693:
	li      1, $17
	b       be_cont.31693
be_else.31693:
	li      0, $17
be_cont.31693:
bne_cont.31692:
	load    [$13 + 4], $18
	load    [$18 + 2], $18
	cmp     $17, 0
	bne     be_else.31694
be_then.31694:
	fneg    $18, $17
	b       be_cont.31694
be_else.31694:
	mov     $18, $17
be_cont.31694:
	store   $17, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
.count storer
	add     $12, $10, $tmp
	store   $16, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31679
be_else.31679:
	cmp     $14, 2
	bne     be_else.31695
be_then.31695:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$15 + 0], $20
	load    [$17 + 0], $17
	fmul    $20, $17, $17
	load    [$15 + 1], $20
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	fadd    $17, $18, $17
	load    [$15 + 2], $18
	load    [$19 + 2], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bg      ble_else.31696
ble_then.31696:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31695
ble_else.31696:
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
	b       be_cont.31695
be_else.31695:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 3], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$15 + 1], $22
	load    [$15 + 2], $23
	fmul    $21, $21, $24
	load    [$18 + 0], $18
	fmul    $24, $18, $18
	fmul    $22, $22, $24
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $18, $19, $18
	fmul    $23, $23, $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	cmp     $17, 0
	be      bne_cont.31697
bne_then.31697:
	fmul    $22, $23, $19
	load    [$13 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $23, $21, $19
	load    [$13 + 9], $20
	load    [$20 + 1], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $21, $22, $19
	load    [$13 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31697:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$15 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	load    [$15 + 2], $23
	load    [$21 + 2], $21
	fmul    $23, $21, $21
	fneg    $19, $19
	fneg    $20, $20
	fneg    $21, $21
	cmp     $17, 0
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	bne     be_else.31698
be_then.31698:
	store   $19, [$16 + 1]
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31699
be_then.31699:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31698
be_else.31699:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31698
be_else.31698:
	load    [$13 + 9], $17
	load    [$13 + 9], $24
	load    [$17 + 1], $17
	fmul    $23, $17, $23
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 9], $19
	load    [$15 + 2], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $22
	load    [$15 + 0], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$15 + 1], $20
	fmul    $20, $19, $19
	load    [$15 + 0], $20
	fmul    $20, $17, $17
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31700
be_then.31700:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31700
be_else.31700:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31700:
be_cont.31698:
be_cont.31695:
be_cont.31679:
bge_cont.31678:
.count stack_load
	load    [$sp + 1], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31701
bge_then.31701:
.count stack_store
	store   $10, [$sp + 2]
	sub     $41, 1, $11
.count stack_load
	load    [$sp + 0], $12
	load    [$12 + $10], $10
	cmp     $11, 0
	bl      bge_cont.31702
bge_then.31702:
	load    [$10 + 1], $12
	load    [min_caml_objects + $11], $13
	load    [$13 + 1], $14
	load    [$10 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31703
be_then.31703:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$15 + 0], $17
	fcmp    $17, $zero
	bne     be_else.31704
be_then.31704:
	store   $zero, [$16 + 1]
	b       be_cont.31704
be_else.31704:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31705
ble_then.31705:
	li      0, $17
	b       ble_cont.31705
ble_else.31705:
	li      1, $17
ble_cont.31705:
	cmp     $18, 0
	be      bne_cont.31706
bne_then.31706:
	cmp     $17, 0
	bne     be_else.31707
be_then.31707:
	li      1, $17
	b       be_cont.31707
be_else.31707:
	li      0, $17
be_cont.31707:
bne_cont.31706:
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	cmp     $17, 0
	bne     be_else.31708
be_then.31708:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31708
be_else.31708:
	store   $18, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31708:
be_cont.31704:
	load    [$15 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31709
be_then.31709:
	store   $zero, [$16 + 3]
	b       be_cont.31709
be_else.31709:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31710
ble_then.31710:
	li      0, $17
	b       ble_cont.31710
ble_else.31710:
	li      1, $17
ble_cont.31710:
	cmp     $18, 0
	be      bne_cont.31711
bne_then.31711:
	cmp     $17, 0
	bne     be_else.31712
be_then.31712:
	li      1, $17
	b       be_cont.31712
be_else.31712:
	li      0, $17
be_cont.31712:
bne_cont.31711:
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	cmp     $17, 0
	bne     be_else.31713
be_then.31713:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31713
be_else.31713:
	store   $18, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31713:
be_cont.31709:
	load    [$15 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31714
be_then.31714:
	store   $zero, [$16 + 5]
.count storer
	add     $12, $11, $tmp
	store   $16, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31703
be_else.31714:
	load    [$13 + 6], $18
	load    [$13 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31715
ble_then.31715:
	li      0, $17
	b       ble_cont.31715
ble_else.31715:
	li      1, $17
ble_cont.31715:
	cmp     $18, 0
	be      bne_cont.31716
bne_then.31716:
	cmp     $17, 0
	bne     be_else.31717
be_then.31717:
	li      1, $17
	b       be_cont.31717
be_else.31717:
	li      0, $17
be_cont.31717:
bne_cont.31716:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.31718
be_then.31718:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31703
be_else.31718:
	store   $18, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31703
be_else.31703:
	cmp     $14, 2
	bne     be_else.31719
be_then.31719:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$15 + 0], $20
	load    [$17 + 0], $17
	fmul    $20, $17, $17
	load    [$15 + 1], $20
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	fadd    $17, $18, $17
	load    [$15 + 2], $18
	load    [$19 + 2], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bg      ble_else.31720
ble_then.31720:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31719
ble_else.31720:
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
	b       be_cont.31719
be_else.31719:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 3], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$15 + 1], $22
	load    [$15 + 2], $23
	fmul    $21, $21, $24
	load    [$18 + 0], $18
	fmul    $24, $18, $18
	fmul    $22, $22, $24
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $18, $19, $18
	fmul    $23, $23, $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	cmp     $17, 0
	be      bne_cont.31721
bne_then.31721:
	fmul    $22, $23, $19
	load    [$13 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $23, $21, $19
	load    [$13 + 9], $20
	load    [$20 + 1], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $21, $22, $19
	load    [$13 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31721:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$15 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	load    [$15 + 2], $23
	load    [$21 + 2], $21
	fmul    $23, $21, $21
	fneg    $19, $19
	fneg    $20, $20
	fneg    $21, $21
	cmp     $17, 0
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.31722
be_then.31722:
	store   $19, [$16 + 1]
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31723
be_then.31723:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31722
be_else.31723:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31722
be_else.31722:
	load    [$13 + 9], $17
	load    [$13 + 9], $24
	load    [$17 + 1], $17
	fmul    $23, $17, $23
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 9], $19
	load    [$15 + 2], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $22
	load    [$15 + 0], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$15 + 1], $20
	fmul    $20, $19, $19
	load    [$15 + 0], $20
	fmul    $20, $17, $17
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31724
be_then.31724:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31724
be_else.31724:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31724:
be_cont.31722:
be_cont.31719:
be_cont.31703:
bge_cont.31702:
.count stack_load
	load    [$sp + 2], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31725
bge_then.31725:
	sub     $41, 1, $3
.count stack_load
	load    [$sp + 0], $17
	load    [$17 + $16], $2
	call    iter_setup_dirvec_constants.2826
	sub     $16, 1, $10
	cmp     $10, 0
	bl      bge_else.31726
bge_then.31726:
	sub     $41, 1, $11
	cmp     $11, 0
	bl      bge_else.31727
bge_then.31727:
	load    [$17 + $10], $12
	load    [$12 + 1], $13
	load    [min_caml_objects + $11], $14
	load    [$14 + 1], $15
	load    [$12 + 0], $16
	cmp     $15, 1
.count stack_store
	store   $10, [$sp + 3]
.count move_args
	mov     $zero, $3
	bne     be_else.31728
be_then.31728:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$16 + 0], $19
	fcmp    $19, $zero
	bne     be_else.31729
be_then.31729:
	store   $zero, [$18 + 1]
	b       be_cont.31729
be_else.31729:
	load    [$14 + 6], $20
	fcmp    $zero, $19
	bg      ble_else.31730
ble_then.31730:
	li      0, $19
	b       ble_cont.31730
ble_else.31730:
	li      1, $19
ble_cont.31730:
	cmp     $20, 0
	be      bne_cont.31731
bne_then.31731:
	cmp     $19, 0
	bne     be_else.31732
be_then.31732:
	li      1, $19
	b       be_cont.31732
be_else.31732:
	li      0, $19
be_cont.31732:
bne_cont.31731:
	load    [$14 + 4], $20
	load    [$20 + 0], $20
	cmp     $19, 0
	bne     be_else.31733
be_then.31733:
	fneg    $20, $19
	store   $19, [$18 + 0]
	load    [$16 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
	b       be_cont.31733
be_else.31733:
	store   $20, [$18 + 0]
	load    [$16 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
be_cont.31733:
be_cont.31729:
	load    [$16 + 1], $19
	fcmp    $19, $zero
	bne     be_else.31734
be_then.31734:
	store   $zero, [$18 + 3]
	b       be_cont.31734
be_else.31734:
	load    [$14 + 6], $20
	fcmp    $zero, $19
	bg      ble_else.31735
ble_then.31735:
	li      0, $19
	b       ble_cont.31735
ble_else.31735:
	li      1, $19
ble_cont.31735:
	cmp     $20, 0
	be      bne_cont.31736
bne_then.31736:
	cmp     $19, 0
	bne     be_else.31737
be_then.31737:
	li      1, $19
	b       be_cont.31737
be_else.31737:
	li      0, $19
be_cont.31737:
bne_cont.31736:
	load    [$14 + 4], $20
	load    [$20 + 1], $20
	cmp     $19, 0
	bne     be_else.31738
be_then.31738:
	fneg    $20, $19
	store   $19, [$18 + 2]
	load    [$16 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
	b       be_cont.31738
be_else.31738:
	store   $20, [$18 + 2]
	load    [$16 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
be_cont.31738:
be_cont.31734:
	load    [$16 + 2], $19
	fcmp    $19, $zero
	bne     be_else.31739
be_then.31739:
	store   $zero, [$18 + 5]
	mov     $18, $16
	b       be_cont.31739
be_else.31739:
	load    [$14 + 6], $20
	load    [$14 + 4], $21
	fcmp    $zero, $19
	bg      ble_else.31740
ble_then.31740:
	li      0, $19
	b       ble_cont.31740
ble_else.31740:
	li      1, $19
ble_cont.31740:
	cmp     $20, 0
	be      bne_cont.31741
bne_then.31741:
	cmp     $19, 0
	bne     be_else.31742
be_then.31742:
	li      1, $19
	b       be_cont.31742
be_else.31742:
	li      0, $19
be_cont.31742:
bne_cont.31741:
	load    [$21 + 2], $20
	cmp     $19, 0
	bne     be_else.31743
be_then.31743:
	fneg    $20, $19
	store   $19, [$18 + 4]
	load    [$16 + 2], $16
	finv    $16, $16
	store   $16, [$18 + 5]
	mov     $18, $16
	b       be_cont.31743
be_else.31743:
	store   $20, [$18 + 4]
	load    [$16 + 2], $16
	finv    $16, $16
	store   $16, [$18 + 5]
	mov     $18, $16
be_cont.31743:
be_cont.31739:
.count storer
	add     $13, $11, $tmp
	store   $16, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
.count move_args
	mov     $17, $2
	b       init_dirvec_constants.3044
be_else.31728:
	cmp     $15, 2
	bne     be_else.31744
be_then.31744:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$16 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$16 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	fadd    $19, $20, $19
	load    [$16 + 2], $16
	load    [$21 + 2], $20
	fmul    $16, $20, $16
	fadd    $19, $16, $16
	fcmp    $16, $zero
.count storer
	add     $13, $11, $tmp
	bg      ble_else.31745
ble_then.31745:
	store   $zero, [$18 + 0]
	store   $18, [$tmp + 0]
	b       be_cont.31744
ble_else.31745:
	finv    $16, $16
	fneg    $16, $19
	store   $19, [$18 + 0]
	load    [$14 + 4], $19
	load    [$19 + 0], $19
	fmul    $19, $16, $19
	fneg    $19, $19
	store   $19, [$18 + 1]
	load    [$14 + 4], $19
	load    [$19 + 1], $19
	fmul    $19, $16, $19
	fneg    $19, $19
	store   $19, [$18 + 2]
	load    [$14 + 4], $19
	load    [$19 + 2], $19
	fmul    $19, $16, $16
	fneg    $16, $16
	store   $16, [$18 + 3]
	store   $18, [$tmp + 0]
	b       be_cont.31744
be_else.31744:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	load    [$14 + 3], $19
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$14 + 4], $22
	load    [$16 + 0], $23
	load    [$16 + 1], $24
	load    [$16 + 2], $25
	fmul    $23, $23, $26
	load    [$20 + 0], $20
	fmul    $26, $20, $20
	fmul    $24, $24, $26
	load    [$21 + 1], $21
	fmul    $26, $21, $21
	fadd    $20, $21, $20
	fmul    $25, $25, $21
	load    [$22 + 2], $22
	fmul    $21, $22, $21
	fadd    $20, $21, $20
	cmp     $19, 0
	be      bne_cont.31746
bne_then.31746:
	fmul    $24, $25, $21
	load    [$14 + 9], $22
	load    [$22 + 0], $22
	fmul    $21, $22, $21
	fadd    $20, $21, $20
	fmul    $25, $23, $21
	load    [$14 + 9], $22
	load    [$22 + 1], $22
	fmul    $21, $22, $21
	fadd    $20, $21, $20
	fmul    $23, $24, $21
	load    [$14 + 9], $22
	load    [$22 + 2], $22
	fmul    $21, $22, $21
	fadd    $20, $21, $20
bne_cont.31746:
	store   $20, [$18 + 0]
	load    [$14 + 4], $21
	load    [$14 + 4], $22
	load    [$14 + 4], $23
	load    [$16 + 0], $24
	load    [$21 + 0], $21
	fmul    $24, $21, $21
	load    [$16 + 1], $24
	load    [$22 + 1], $22
	fmul    $24, $22, $22
	load    [$16 + 2], $25
	load    [$23 + 2], $23
	fmul    $25, $23, $23
	fneg    $21, $21
	fneg    $22, $22
	fneg    $23, $23
	cmp     $19, 0
.count storer
	add     $13, $11, $tmp
	bne     be_else.31747
be_then.31747:
	store   $21, [$18 + 1]
	store   $22, [$18 + 2]
	store   $23, [$18 + 3]
	fcmp    $20, $zero
	bne     be_else.31748
be_then.31748:
	store   $18, [$tmp + 0]
	b       be_cont.31747
be_else.31748:
	finv    $20, $16
	store   $16, [$18 + 4]
	store   $18, [$tmp + 0]
	b       be_cont.31747
be_else.31747:
	load    [$14 + 9], $19
	load    [$14 + 9], $26
	load    [$19 + 1], $19
	fmul    $25, $19, $25
	load    [$26 + 2], $26
	fmul    $24, $26, $24
	fadd    $25, $24, $24
	fmul    $24, $39, $24
	fsub    $21, $24, $21
	store   $21, [$18 + 1]
	load    [$14 + 9], $21
	load    [$16 + 2], $24
	load    [$21 + 0], $21
	fmul    $24, $21, $24
	load    [$16 + 0], $25
	fmul    $25, $26, $25
	fadd    $24, $25, $24
	fmul    $24, $39, $24
	fsub    $22, $24, $22
	store   $22, [$18 + 2]
	load    [$16 + 1], $22
	fmul    $22, $21, $21
	load    [$16 + 0], $16
	fmul    $16, $19, $16
	fadd    $21, $16, $16
	fmul    $16, $39, $16
	fsub    $23, $16, $16
	store   $16, [$18 + 3]
	fcmp    $20, $zero
	bne     be_else.31749
be_then.31749:
	store   $18, [$tmp + 0]
	b       be_cont.31749
be_else.31749:
	finv    $20, $16
	store   $16, [$18 + 4]
	store   $18, [$tmp + 0]
be_cont.31749:
be_cont.31747:
be_cont.31744:
	sub     $11, 1, $3
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count stack_load
	load    [$sp - 1], $1
	sub     $1, 1, $3
.count move_args
	mov     $17, $2
	b       init_dirvec_constants.3044
bge_else.31727:
.count stack_move
	add     $sp, 4, $sp
	sub     $10, 1, $3
.count move_args
	mov     $17, $2
	b       init_dirvec_constants.3044
bge_else.31726:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31725:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31701:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31677:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	cmp     $2, 0
	bl      bge_else.31750
bge_then.31750:
.count stack_move
	sub     $sp, 5, $sp
.count stack_store
	store   $2, [$sp + 0]
	sub     $41, 1, $10
	load    [min_caml_dirvecs + $2], $11
.count stack_store
	store   $11, [$sp + 1]
	load    [$11 + 119], $11
	cmp     $10, 0
	bl      bge_cont.31751
bge_then.31751:
	load    [$11 + 1], $12
	load    [min_caml_objects + $10], $13
	load    [$13 + 1], $14
	load    [$11 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31752
be_then.31752:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$15 + 0], $17
	fcmp    $17, $zero
	bne     be_else.31753
be_then.31753:
	store   $zero, [$16 + 1]
	b       be_cont.31753
be_else.31753:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31754
ble_then.31754:
	li      0, $17
	b       ble_cont.31754
ble_else.31754:
	li      1, $17
ble_cont.31754:
	cmp     $18, 0
	be      bne_cont.31755
bne_then.31755:
	cmp     $17, 0
	bne     be_else.31756
be_then.31756:
	li      1, $17
	b       be_cont.31756
be_else.31756:
	li      0, $17
be_cont.31756:
bne_cont.31755:
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	cmp     $17, 0
	bne     be_else.31757
be_then.31757:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31757
be_else.31757:
	store   $18, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31757:
be_cont.31753:
	load    [$15 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31758
be_then.31758:
	store   $zero, [$16 + 3]
	b       be_cont.31758
be_else.31758:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31759
ble_then.31759:
	li      0, $17
	b       ble_cont.31759
ble_else.31759:
	li      1, $17
ble_cont.31759:
	cmp     $18, 0
	be      bne_cont.31760
bne_then.31760:
	cmp     $17, 0
	bne     be_else.31761
be_then.31761:
	li      1, $17
	b       be_cont.31761
be_else.31761:
	li      0, $17
be_cont.31761:
bne_cont.31760:
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	cmp     $17, 0
	bne     be_else.31762
be_then.31762:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31762
be_else.31762:
	store   $18, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31762:
be_cont.31758:
	load    [$15 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31763
be_then.31763:
	store   $zero, [$16 + 5]
.count storer
	add     $12, $10, $tmp
	store   $16, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31752
be_else.31763:
	load    [$13 + 6], $18
	load    [$13 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31764
ble_then.31764:
	li      0, $17
	b       ble_cont.31764
ble_else.31764:
	li      1, $17
ble_cont.31764:
	cmp     $18, 0
	be      bne_cont.31765
bne_then.31765:
	cmp     $17, 0
	bne     be_else.31766
be_then.31766:
	li      1, $17
	b       be_cont.31766
be_else.31766:
	li      0, $17
be_cont.31766:
bne_cont.31765:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31767
be_then.31767:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31752
be_else.31767:
	store   $18, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31752
be_else.31752:
	cmp     $14, 2
	bne     be_else.31768
be_then.31768:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$15 + 0], $20
	load    [$17 + 0], $17
	fmul    $20, $17, $17
	load    [$15 + 1], $20
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	fadd    $17, $18, $17
	load    [$15 + 2], $18
	load    [$19 + 2], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bg      ble_else.31769
ble_then.31769:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31768
ble_else.31769:
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
	b       be_cont.31768
be_else.31768:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 3], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$15 + 1], $22
	load    [$15 + 2], $23
	fmul    $21, $21, $24
	load    [$18 + 0], $18
	fmul    $24, $18, $18
	fmul    $22, $22, $24
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $18, $19, $18
	fmul    $23, $23, $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	cmp     $17, 0
	be      bne_cont.31770
bne_then.31770:
	fmul    $22, $23, $19
	load    [$13 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $23, $21, $19
	load    [$13 + 9], $20
	load    [$20 + 1], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $21, $22, $19
	load    [$13 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31770:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$15 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	load    [$15 + 2], $23
	load    [$21 + 2], $21
	fmul    $23, $21, $21
	fneg    $19, $19
	fneg    $20, $20
	fneg    $21, $21
	cmp     $17, 0
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	bne     be_else.31771
be_then.31771:
	store   $19, [$16 + 1]
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31772
be_then.31772:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31771
be_else.31772:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31771
be_else.31771:
	load    [$13 + 9], $17
	load    [$13 + 9], $24
	load    [$17 + 1], $17
	fmul    $23, $17, $23
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 9], $19
	load    [$15 + 2], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $22
	load    [$15 + 0], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$15 + 1], $20
	fmul    $20, $19, $19
	load    [$15 + 0], $20
	fmul    $20, $17, $17
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31773
be_then.31773:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31773
be_else.31773:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31773:
be_cont.31771:
be_cont.31768:
be_cont.31752:
bge_cont.31751:
	sub     $41, 1, $3
.count stack_load
	load    [$sp + 1], $16
	load    [$16 + 118], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $10
	load    [$16 + 117], $11
	cmp     $10, 0
	bl      bge_cont.31774
bge_then.31774:
	load    [$11 + 1], $12
	load    [min_caml_objects + $10], $13
	load    [$13 + 1], $14
	load    [$11 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31775
be_then.31775:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$15 + 0], $18
	fcmp    $18, $zero
	bne     be_else.31776
be_then.31776:
	store   $zero, [$17 + 1]
	b       be_cont.31776
be_else.31776:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31777
ble_then.31777:
	li      0, $18
	b       ble_cont.31777
ble_else.31777:
	li      1, $18
ble_cont.31777:
	cmp     $19, 0
	be      bne_cont.31778
bne_then.31778:
	cmp     $18, 0
	bne     be_else.31779
be_then.31779:
	li      1, $18
	b       be_cont.31779
be_else.31779:
	li      0, $18
be_cont.31779:
bne_cont.31778:
	load    [$13 + 4], $19
	load    [$19 + 0], $19
	cmp     $18, 0
	bne     be_else.31780
be_then.31780:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
	b       be_cont.31780
be_else.31780:
	store   $19, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31780:
be_cont.31776:
	load    [$15 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31781
be_then.31781:
	store   $zero, [$17 + 3]
	b       be_cont.31781
be_else.31781:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31782
ble_then.31782:
	li      0, $18
	b       ble_cont.31782
ble_else.31782:
	li      1, $18
ble_cont.31782:
	cmp     $19, 0
	be      bne_cont.31783
bne_then.31783:
	cmp     $18, 0
	bne     be_else.31784
be_then.31784:
	li      1, $18
	b       be_cont.31784
be_else.31784:
	li      0, $18
be_cont.31784:
bne_cont.31783:
	load    [$13 + 4], $19
	load    [$19 + 1], $19
	cmp     $18, 0
	bne     be_else.31785
be_then.31785:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
	b       be_cont.31785
be_else.31785:
	store   $19, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31785:
be_cont.31781:
	load    [$15 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31786
be_then.31786:
	store   $zero, [$17 + 5]
.count storer
	add     $12, $10, $tmp
	store   $17, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31775
be_else.31786:
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $zero, $18
	bg      ble_else.31787
ble_then.31787:
	li      0, $18
	b       ble_cont.31787
ble_else.31787:
	li      1, $18
ble_cont.31787:
	cmp     $19, 0
	be      bne_cont.31788
bne_then.31788:
	cmp     $18, 0
	bne     be_else.31789
be_then.31789:
	li      1, $18
	b       be_cont.31789
be_else.31789:
	li      0, $18
be_cont.31789:
bne_cont.31788:
	load    [$20 + 2], $19
	cmp     $18, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31790
be_then.31790:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31775
be_else.31790:
	store   $19, [$17 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31775
be_else.31775:
	cmp     $14, 2
	bne     be_else.31791
be_then.31791:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$18 + 0], $18
	fmul    $21, $18, $18
	load    [$15 + 1], $21
	load    [$19 + 1], $19
	fmul    $21, $19, $19
	fadd    $18, $19, $18
	load    [$15 + 2], $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fcmp    $18, $zero
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bg      ble_else.31792
ble_then.31792:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31791
ble_else.31792:
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
	b       be_cont.31791
be_else.31791:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 3], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$15 + 1], $23
	load    [$15 + 2], $24
	fmul    $22, $22, $25
	load    [$19 + 0], $19
	fmul    $25, $19, $19
	fmul    $23, $23, $25
	load    [$20 + 1], $20
	fmul    $25, $20, $20
	fadd    $19, $20, $19
	fmul    $24, $24, $20
	load    [$21 + 2], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	cmp     $18, 0
	be      bne_cont.31793
bne_then.31793:
	fmul    $23, $24, $20
	load    [$13 + 9], $21
	load    [$21 + 0], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $24, $22, $20
	load    [$13 + 9], $21
	load    [$21 + 1], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $22, $23, $20
	load    [$13 + 9], $21
	load    [$21 + 2], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
bne_cont.31793:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$15 + 0], $23
	load    [$20 + 0], $20
	fmul    $23, $20, $20
	load    [$15 + 1], $23
	load    [$21 + 1], $21
	fmul    $23, $21, $21
	load    [$15 + 2], $24
	load    [$22 + 2], $22
	fmul    $24, $22, $22
	fneg    $20, $20
	fneg    $21, $21
	fneg    $22, $22
	cmp     $18, 0
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	bne     be_else.31794
be_then.31794:
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	fcmp    $19, $zero
	bne     be_else.31795
be_then.31795:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31794
be_else.31795:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31794
be_else.31794:
	load    [$13 + 9], $18
	load    [$13 + 9], $25
	load    [$18 + 1], $18
	fmul    $24, $18, $24
	load    [$25 + 2], $25
	fmul    $23, $25, $23
	fadd    $24, $23, $23
	fmul    $23, $39, $23
	fsub    $20, $23, $20
	store   $20, [$17 + 1]
	load    [$13 + 9], $20
	load    [$15 + 2], $23
	load    [$20 + 0], $20
	fmul    $23, $20, $23
	load    [$15 + 0], $24
	fmul    $24, $25, $24
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $21, $23, $21
	store   $21, [$17 + 2]
	load    [$15 + 1], $21
	fmul    $21, $20, $20
	load    [$15 + 0], $21
	fmul    $21, $18, $18
	fadd    $20, $18, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	fcmp    $19, $zero
	bne     be_else.31796
be_then.31796:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31796
be_else.31796:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31796:
be_cont.31794:
be_cont.31791:
be_cont.31775:
bge_cont.31774:
	li      116, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 0], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31797
bge_then.31797:
.count stack_store
	store   $16, [$sp + 2]
	sub     $41, 1, $3
	load    [min_caml_dirvecs + $16], $16
	load    [$16 + 119], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $10
	load    [$16 + 118], $11
	cmp     $10, 0
	bl      bge_cont.31798
bge_then.31798:
	load    [$11 + 1], $12
	load    [min_caml_objects + $10], $13
	load    [$13 + 1], $14
	load    [$11 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31799
be_then.31799:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$15 + 0], $18
	fcmp    $18, $zero
	bne     be_else.31800
be_then.31800:
	store   $zero, [$17 + 1]
	b       be_cont.31800
be_else.31800:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31801
ble_then.31801:
	li      0, $18
	b       ble_cont.31801
ble_else.31801:
	li      1, $18
ble_cont.31801:
	cmp     $19, 0
	be      bne_cont.31802
bne_then.31802:
	cmp     $18, 0
	bne     be_else.31803
be_then.31803:
	li      1, $18
	b       be_cont.31803
be_else.31803:
	li      0, $18
be_cont.31803:
bne_cont.31802:
	load    [$13 + 4], $19
	load    [$19 + 0], $19
	cmp     $18, 0
	bne     be_else.31804
be_then.31804:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
	b       be_cont.31804
be_else.31804:
	store   $19, [$17 + 0]
	load    [$15 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31804:
be_cont.31800:
	load    [$15 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31805
be_then.31805:
	store   $zero, [$17 + 3]
	b       be_cont.31805
be_else.31805:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31806
ble_then.31806:
	li      0, $18
	b       ble_cont.31806
ble_else.31806:
	li      1, $18
ble_cont.31806:
	cmp     $19, 0
	be      bne_cont.31807
bne_then.31807:
	cmp     $18, 0
	bne     be_else.31808
be_then.31808:
	li      1, $18
	b       be_cont.31808
be_else.31808:
	li      0, $18
be_cont.31808:
bne_cont.31807:
	load    [$13 + 4], $19
	load    [$19 + 1], $19
	cmp     $18, 0
	bne     be_else.31809
be_then.31809:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
	b       be_cont.31809
be_else.31809:
	store   $19, [$17 + 2]
	load    [$15 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31809:
be_cont.31805:
	load    [$15 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31810
be_then.31810:
	store   $zero, [$17 + 5]
.count storer
	add     $12, $10, $tmp
	store   $17, [$tmp + 0]
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31799
be_else.31810:
	load    [$13 + 6], $19
	load    [$13 + 4], $20
	fcmp    $zero, $18
	bg      ble_else.31811
ble_then.31811:
	li      0, $18
	b       ble_cont.31811
ble_else.31811:
	li      1, $18
ble_cont.31811:
	cmp     $19, 0
	be      bne_cont.31812
bne_then.31812:
	cmp     $18, 0
	bne     be_else.31813
be_then.31813:
	li      1, $18
	b       be_cont.31813
be_else.31813:
	li      0, $18
be_cont.31813:
bne_cont.31812:
	load    [$20 + 2], $19
	cmp     $18, 0
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bne     be_else.31814
be_then.31814:
	fneg    $19, $18
	store   $18, [$17 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31799
be_else.31814:
	store   $19, [$17 + 4]
	load    [$15 + 2], $18
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31799
be_else.31799:
	cmp     $14, 2
	bne     be_else.31815
be_then.31815:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$18 + 0], $18
	fmul    $21, $18, $18
	load    [$15 + 1], $21
	load    [$19 + 1], $19
	fmul    $21, $19, $19
	fadd    $18, $19, $18
	load    [$15 + 2], $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fcmp    $18, $zero
.count move_args
	mov     $11, $2
	sub     $10, 1, $3
.count storer
	add     $12, $10, $tmp
	bg      ble_else.31816
ble_then.31816:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31815
ble_else.31816:
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
	b       be_cont.31815
be_else.31815:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $17
	load    [$13 + 3], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$15 + 1], $23
	load    [$15 + 2], $24
	fmul    $22, $22, $25
	load    [$19 + 0], $19
	fmul    $25, $19, $19
	fmul    $23, $23, $25
	load    [$20 + 1], $20
	fmul    $25, $20, $20
	fadd    $19, $20, $19
	fmul    $24, $24, $20
	load    [$21 + 2], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	cmp     $18, 0
	be      bne_cont.31817
bne_then.31817:
	fmul    $23, $24, $20
	load    [$13 + 9], $21
	load    [$21 + 0], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $24, $22, $20
	load    [$13 + 9], $21
	load    [$21 + 1], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
	fmul    $22, $23, $20
	load    [$13 + 9], $21
	load    [$21 + 2], $21
	fmul    $20, $21, $20
	fadd    $19, $20, $19
bne_cont.31817:
	store   $19, [$17 + 0]
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$13 + 4], $22
	load    [$15 + 0], $23
	load    [$20 + 0], $20
	fmul    $23, $20, $20
	load    [$15 + 1], $23
	load    [$21 + 1], $21
	fmul    $23, $21, $21
	load    [$15 + 2], $24
	load    [$22 + 2], $22
	fmul    $24, $22, $22
	fneg    $20, $20
	fneg    $21, $21
	fneg    $22, $22
	cmp     $18, 0
.count storer
	add     $12, $10, $tmp
	sub     $10, 1, $3
.count move_args
	mov     $11, $2
	bne     be_else.31818
be_then.31818:
	store   $20, [$17 + 1]
	store   $21, [$17 + 2]
	store   $22, [$17 + 3]
	fcmp    $19, $zero
	bne     be_else.31819
be_then.31819:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31818
be_else.31819:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31818
be_else.31818:
	load    [$13 + 9], $18
	load    [$13 + 9], $25
	load    [$18 + 1], $18
	fmul    $24, $18, $24
	load    [$25 + 2], $25
	fmul    $23, $25, $23
	fadd    $24, $23, $23
	fmul    $23, $39, $23
	fsub    $20, $23, $20
	store   $20, [$17 + 1]
	load    [$13 + 9], $20
	load    [$15 + 2], $23
	load    [$20 + 0], $20
	fmul    $23, $20, $23
	load    [$15 + 0], $24
	fmul    $24, $25, $24
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $21, $23, $21
	store   $21, [$17 + 2]
	load    [$15 + 1], $21
	fmul    $21, $20, $20
	load    [$15 + 0], $21
	fmul    $21, $18, $18
	fadd    $20, $18, $18
	fmul    $18, $39, $18
	fsub    $22, $18, $18
	store   $18, [$17 + 3]
	fcmp    $19, $zero
	bne     be_else.31820
be_then.31820:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31820
be_else.31820:
	finv    $19, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31820:
be_cont.31818:
be_cont.31815:
be_cont.31799:
bge_cont.31798:
	li      117, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 2], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31821
bge_then.31821:
.count stack_store
	store   $10, [$sp + 3]
	sub     $41, 1, $11
	load    [min_caml_dirvecs + $10], $10
.count stack_store
	store   $10, [$sp + 4]
	load    [$10 + 119], $10
	cmp     $11, 0
	bl      bge_cont.31822
bge_then.31822:
	load    [$10 + 1], $12
	load    [min_caml_objects + $11], $13
	load    [$13 + 1], $14
	load    [$10 + 0], $15
	cmp     $14, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31823
be_then.31823:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$15 + 0], $17
	fcmp    $17, $zero
	bne     be_else.31824
be_then.31824:
	store   $zero, [$16 + 1]
	b       be_cont.31824
be_else.31824:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31825
ble_then.31825:
	li      0, $17
	b       ble_cont.31825
ble_else.31825:
	li      1, $17
ble_cont.31825:
	cmp     $18, 0
	be      bne_cont.31826
bne_then.31826:
	cmp     $17, 0
	bne     be_else.31827
be_then.31827:
	li      1, $17
	b       be_cont.31827
be_else.31827:
	li      0, $17
be_cont.31827:
bne_cont.31826:
	load    [$13 + 4], $18
	load    [$18 + 0], $18
	cmp     $17, 0
	bne     be_else.31828
be_then.31828:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31828
be_else.31828:
	store   $18, [$16 + 0]
	load    [$15 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31828:
be_cont.31824:
	load    [$15 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31829
be_then.31829:
	store   $zero, [$16 + 3]
	b       be_cont.31829
be_else.31829:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31830
ble_then.31830:
	li      0, $17
	b       ble_cont.31830
ble_else.31830:
	li      1, $17
ble_cont.31830:
	cmp     $18, 0
	be      bne_cont.31831
bne_then.31831:
	cmp     $17, 0
	bne     be_else.31832
be_then.31832:
	li      1, $17
	b       be_cont.31832
be_else.31832:
	li      0, $17
be_cont.31832:
bne_cont.31831:
	load    [$13 + 4], $18
	load    [$18 + 1], $18
	cmp     $17, 0
	bne     be_else.31833
be_then.31833:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31833
be_else.31833:
	store   $18, [$16 + 2]
	load    [$15 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31833:
be_cont.31829:
	load    [$15 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31834
be_then.31834:
	store   $zero, [$16 + 5]
.count storer
	add     $12, $11, $tmp
	store   $16, [$tmp + 0]
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31823
be_else.31834:
	load    [$13 + 6], $18
	load    [$13 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31835
ble_then.31835:
	li      0, $17
	b       ble_cont.31835
ble_else.31835:
	li      1, $17
ble_cont.31835:
	cmp     $18, 0
	be      bne_cont.31836
bne_then.31836:
	cmp     $17, 0
	bne     be_else.31837
be_then.31837:
	li      1, $17
	b       be_cont.31837
be_else.31837:
	li      0, $17
be_cont.31837:
bne_cont.31836:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bne     be_else.31838
be_then.31838:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31823
be_else.31838:
	store   $18, [$16 + 4]
	load    [$15 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31823
be_else.31823:
	cmp     $14, 2
	bne     be_else.31839
be_then.31839:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$15 + 0], $20
	load    [$17 + 0], $17
	fmul    $20, $17, $17
	load    [$15 + 1], $20
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	fadd    $17, $18, $17
	load    [$15 + 2], $18
	load    [$19 + 2], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
.count move_args
	mov     $10, $2
	sub     $11, 1, $3
.count storer
	add     $12, $11, $tmp
	bg      ble_else.31840
ble_then.31840:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31839
ble_else.31840:
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
	b       be_cont.31839
be_else.31839:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$13 + 3], $17
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$15 + 0], $21
	load    [$15 + 1], $22
	load    [$15 + 2], $23
	fmul    $21, $21, $24
	load    [$18 + 0], $18
	fmul    $24, $18, $18
	fmul    $22, $22, $24
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $18, $19, $18
	fmul    $23, $23, $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	cmp     $17, 0
	be      bne_cont.31841
bne_then.31841:
	fmul    $22, $23, $19
	load    [$13 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $23, $21, $19
	load    [$13 + 9], $20
	load    [$20 + 1], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $21, $22, $19
	load    [$13 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31841:
	store   $18, [$16 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $21
	load    [$15 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$15 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	load    [$15 + 2], $23
	load    [$21 + 2], $21
	fmul    $23, $21, $21
	fneg    $19, $19
	fneg    $20, $20
	fneg    $21, $21
	cmp     $17, 0
.count storer
	add     $12, $11, $tmp
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.31842
be_then.31842:
	store   $19, [$16 + 1]
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31843
be_then.31843:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31842
be_else.31843:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31842
be_else.31842:
	load    [$13 + 9], $17
	load    [$13 + 9], $24
	load    [$17 + 1], $17
	fmul    $23, $17, $23
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$13 + 9], $19
	load    [$15 + 2], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $22
	load    [$15 + 0], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$15 + 1], $20
	fmul    $20, $19, $19
	load    [$15 + 0], $20
	fmul    $20, $17, $17
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31844
be_then.31844:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31844
be_else.31844:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31844:
be_cont.31842:
be_cont.31839:
be_cont.31823:
bge_cont.31822:
	li      118, $3
.count stack_load
	load    [$sp + 4], $2
	call    init_dirvec_constants.3044
.count stack_load
	load    [$sp + 3], $27
	sub     $27, 1, $27
	cmp     $27, 0
	bl      bge_else.31845
bge_then.31845:
	load    [min_caml_dirvecs + $27], $2
	li      119, $3
	call    init_dirvec_constants.3044
.count stack_move
	add     $sp, 5, $sp
	sub     $27, 1, $2
	b       init_vecset_constants.3047
bge_else.31845:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31821:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31797:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31750:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3064:
	cmp     $2, 0
	bl      bge_else.31846
bge_then.31846:
	load    [min_caml_objects + $2], $10
	load    [$10 + 2], $11
	cmp     $11, 2
	bne     be_else.31847
be_then.31847:
	load    [$10 + 7], $11
	load    [$11 + 0], $11
	fcmp    $36, $11
	bg      ble_else.31848
ble_then.31848:
	ret
ble_else.31848:
	load    [$10 + 1], $12
	cmp     $12, 1
	bne     be_else.31849
be_then.31849:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $2, [$sp + 0]
	load    [$10 + 7], $10
.count stack_store
	store   $10, [$sp + 1]
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
	mov     $1, $16
.count stack_load
	load    [$sp + 2], $17
	store   $55, [$17 + 0]
	fneg    $56, $18
	store   $18, [$17 + 1]
	fneg    $57, $19
	store   $19, [$17 + 2]
	sub     $41, 1, $3
	mov     $hp, $20
	add     $hp, 2, $hp
	store   $16, [$20 + 1]
	store   $17, [$20 + 0]
	mov     $20, $2
.count stack_store
	store   $2, [$sp + 3]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 0], $10
	sll     $10, 2, $10
.count stack_store
	store   $10, [$sp + 4]
	add     $10, 1, $10
.count stack_load
	load    [$sp + 1], $11
	load    [$11 + 0], $11
	fsub    $36, $11, $11
.count stack_store
	store   $11, [$sp + 5]
	mov     $hp, $12
	add     $hp, 3, $hp
	store   $11, [$12 + 2]
.count stack_load
	load    [$sp + 3], $11
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	load    [min_caml_n_reflections + 0], $11
.count stack_store
	store   $11, [$sp + 6]
	store   $10, [min_caml_reflections + $11]
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
	mov     $1, $16
	fneg    $55, $17
.count stack_load
	load    [$sp + 7], $20
	store   $17, [$20 + 0]
	store   $56, [$20 + 1]
	store   $19, [$20 + 2]
	sub     $41, 1, $3
	mov     $hp, $19
	add     $hp, 2, $hp
	store   $16, [$19 + 1]
	store   $20, [$19 + 0]
	mov     $19, $2
.count stack_store
	store   $2, [$sp + 8]
	call    iter_setup_dirvec_constants.2826
.count stack_load
	load    [$sp + 6], $10
	add     $10, 1, $10
.count stack_load
	load    [$sp + 4], $11
	add     $11, 2, $11
	mov     $hp, $12
	add     $hp, 3, $hp
.count stack_load
	load    [$sp + 5], $13
	store   $13, [$12 + 2]
.count stack_load
	load    [$sp + 8], $13
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
.count move_ret
	mov     $1, $16
.count stack_load
	load    [$sp + 9], $19
	store   $17, [$19 + 0]
	store   $18, [$19 + 1]
	store   $57, [$19 + 2]
	sub     $41, 1, $3
	mov     $hp, $17
	add     $hp, 2, $hp
	store   $16, [$17 + 1]
	store   $19, [$17 + 0]
	mov     $17, $2
.count stack_store
	store   $2, [$sp + 10]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 8], $1
	add     $1, 2, $2
.count stack_load
	load    [$sp - 10], $3
	add     $3, 3, $3
	mov     $hp, $4
	add     $hp, 3, $hp
.count stack_load
	load    [$sp - 9], $5
	store   $5, [$4 + 2]
.count stack_load
	load    [$sp - 4], $5
	store   $5, [$4 + 1]
	store   $3, [$4 + 0]
	mov     $4, $3
	store   $3, [min_caml_reflections + $2]
	add     $1, 3, $1
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.31849:
	cmp     $12, 2
	bne     be_else.31850
be_then.31850:
.count stack_move
	sub     $sp, 14, $sp
.count stack_store
	store   $11, [$sp + 11]
.count stack_store
	store   $2, [$sp + 0]
	load    [$10 + 4], $11
	load    [$10 + 4], $10
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	mov     $12, $3
.count stack_store
	store   $3, [$sp + 12]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
.count load_float
	load    [f.27083], $17
	load    [$11 + 0], $18
	fmul    $17, $18, $19
	fmul    $55, $18, $18
	load    [$10 + 1], $20
	fmul    $56, $20, $21
	fadd    $18, $21, $18
	load    [$10 + 2], $21
	fmul    $57, $21, $22
	fadd    $18, $22, $18
	fmul    $19, $18, $19
	fsub    $19, $55, $19
.count stack_load
	load    [$sp + 12], $22
	store   $19, [$22 + 0]
	fmul    $17, $20, $19
	fmul    $19, $18, $19
	fsub    $19, $56, $19
	store   $19, [$22 + 1]
	fmul    $17, $21, $17
	fmul    $17, $18, $17
	fsub    $17, $57, $17
	store   $17, [$22 + 2]
	sub     $41, 1, $3
	mov     $hp, $17
	add     $hp, 2, $hp
	store   $16, [$17 + 1]
	store   $22, [$17 + 0]
	mov     $17, $2
.count stack_store
	store   $2, [$sp + 13]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
.count stack_load
	load    [$sp - 3], $1
	fsub    $36, $1, $1
.count stack_load
	load    [$sp - 14], $2
	sll     $2, 2, $2
	add     $2, 1, $2
	mov     $hp, $3
	add     $hp, 3, $hp
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
be_else.31850:
	ret
be_else.31847:
	ret
bge_else.31846:
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
	load    [f.27085 + 0], $36
	load    [f.27109 + 0], $37
	load    [f.27108 + 0], $38
	load    [f.27086 + 0], $39
	load    [f.27084 + 0], $40
	li      128, $2
.count move_float
	mov     $2, $50
	li      128, $10
.count move_float
	mov     $10, $60
	li      64, $10
	store   $10, [min_caml_image_center + 0]
	li      64, $10
	store   $10, [min_caml_image_center + 1]
.count load_float
	load    [f.27202], $10
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $11
	finv    $11, $11
	fmul    $10, $11, $10
	store   $10, [min_caml_scan_pitch + 0]
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
.count move_ret
	mov     $1, $19
	sub     $50, 2, $20
	cmp     $20, 0
	bl      bge_else.31851
bge_then.31851:
	call    create_pixel.3008
.count move_ret
	mov     $1, $22
.count storer
	add     $19, $20, $tmp
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31851
bge_else.31851:
	mov     $19, $10
bge_cont.31851:
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
.count move_ret
	mov     $1, $19
	sub     $50, 2, $20
	cmp     $20, 0
	bl      bge_else.31852
bge_then.31852:
	call    create_pixel.3008
.count move_ret
	mov     $1, $22
.count storer
	add     $19, $20, $tmp
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31852
bge_else.31852:
	mov     $19, $10
bge_cont.31852:
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
.count move_ret
	mov     $1, $19
	sub     $50, 2, $20
	cmp     $20, 0
	bl      bge_else.31853
bge_then.31853:
	call    create_pixel.3008
.count move_ret
	mov     $1, $22
.count storer
	add     $19, $20, $tmp
	store   $22, [$tmp + 0]
	sub     $20, 1, $3
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31853
bge_else.31853:
	mov     $19, $10
bge_cont.31853:
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
.count move_ret
	mov     $1, $11
.count load_float
	load    [f.27070], $12
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
.count load_float
	load    [f.27231], $14
.count stack_load
	load    [$sp + 4], $16
	fmul    $16, $14, $14
	store   $14, [min_caml_screenz_dir + 1]
	fmul    $11, $13, $14
	fmul    $14, $15, $14
	store   $14, [min_caml_screenz_dir + 2]
	store   $13, [min_caml_screenx_dir + 0]
	store   $zero, [min_caml_screenx_dir + 1]
	fneg    $10, $14
	store   $14, [min_caml_screenx_dir + 2]
	fneg    $16, $14
	fmul    $14, $10, $10
	store   $10, [min_caml_screeny_dir + 0]
	fneg    $11, $10
	store   $10, [min_caml_screeny_dir + 1]
	fmul    $14, $13, $10
	store   $10, [min_caml_screeny_dir + 2]
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
.count move_ret
	mov     $1, $13
	fmul    $11, $12, $2
.count stack_store
	store   $2, [$sp + 7]
	call    min_caml_sin
.count move_ret
	mov     $1, $11
	fmul    $13, $11, $11
.count move_float
	mov     $11, $55
.count stack_load
	load    [$sp + 7], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $10
	fmul    $13, $10, $10
.count move_float
	mov     $10, $57
	call    min_caml_read_float
.count move_ret
	mov     $1, $23
	store   $23, [min_caml_beam + 0]
	li      0, $2
.count stack_store
	store   $2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31854
be_then.31854:
.count stack_load
	load    [$sp + 8], $10
.count move_float
	mov     $10, $41
	b       be_cont.31854
be_else.31854:
	li      1, $2
.count stack_store
	store   $2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31855
be_then.31855:
.count stack_load
	load    [$sp + 9], $10
.count move_float
	mov     $10, $41
	b       be_cont.31855
be_else.31855:
	li      2, $2
.count stack_store
	store   $2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31856
be_then.31856:
.count stack_load
	load    [$sp + 10], $10
.count move_float
	mov     $10, $41
	b       be_cont.31856
be_else.31856:
	li      3, $2
.count stack_store
	store   $2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $24
	cmp     $24, 0
	bne     be_else.31857
be_then.31857:
.count stack_load
	load    [$sp + 11], $10
.count move_float
	mov     $10, $41
	b       be_cont.31857
be_else.31857:
	li      4, $2
	call    read_object.2721
be_cont.31857:
be_cont.31856:
be_cont.31855:
be_cont.31854:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31858
be_then.31858:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	b       be_cont.31858
be_else.31858:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31859
be_then.31859:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $10, [$18 + 0]
	b       be_cont.31859
be_else.31859:
.count stack_store
	store   $10, [$sp + 12]
.count stack_store
	store   $11, [$sp + 13]
	call    read_net_item.2725
.count move_ret
	mov     $1, $18
.count stack_load
	load    [$sp + 13], $19
	store   $19, [$18 + 1]
.count stack_load
	load    [$sp + 12], $19
	store   $19, [$18 + 0]
be_cont.31859:
be_cont.31858:
	load    [$18 + 0], $19
	cmp     $19, -1
	be      bne_cont.31860
bne_then.31860:
	store   $18, [min_caml_and_net + 0]
	li      1, $2
	call    read_and_network.2729
bne_cont.31860:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31861
be_then.31861:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31861
be_else.31861:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31862
be_then.31862:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31862
be_else.31862:
.count stack_store
	store   $10, [$sp + 14]
.count stack_store
	store   $11, [$sp + 15]
	call    read_net_item.2725
.count move_ret
	mov     $1, $10
.count stack_load
	load    [$sp + 15], $11
	store   $11, [$10 + 1]
.count stack_load
	load    [$sp + 14], $11
	store   $11, [$10 + 0]
be_cont.31862:
be_cont.31861:
	mov     $10, $3
	load    [$3 + 0], $10
	cmp     $10, -1
	li      1, $2
	bne     be_else.31863
be_then.31863:
	call    min_caml_create_array
	b       be_cont.31863
be_else.31863:
.count stack_store
	store   $3, [$sp + 16]
	call    read_or_network.2727
.count stack_load
	load    [$sp + 16], $10
	store   $10, [$1 + 0]
be_cont.31863:
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
	li      120, $2
	mov     $hp, $11
	add     $hp, 2, $hp
	store   $10, [$11 + 1]
.count stack_load
	load    [$sp + 17], $10
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
.count move_ret
	mov     $1, $21
.count load_float
	load    [f.27139], $22
	fmul    $21, $22, $21
.count load_float
	load    [f.27140], $22
	fsub    $21, $22, $3
.count move_args
	mov     $11, $5
.count move_args
	mov     $10, $4
.count move_args
	mov     $12, $2
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
	store   $55, [$11 + 0]
	store   $56, [$11 + 1]
	store   $57, [$11 + 2]
	sub     $41, 1, $12
	cmp     $12, 0
	bl      bge_cont.31864
bge_then.31864:
	load    [min_caml_light_dirvec + 1], $13
	load    [min_caml_objects + $12], $14
	load    [$14 + 1], $15
	cmp     $15, 1
.count move_args
	mov     $zero, $3
	bne     be_else.31865
be_then.31865:
	li      6, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$11 + 0], $17
	fcmp    $17, $zero
	bne     be_else.31866
be_then.31866:
	store   $zero, [$16 + 1]
	b       be_cont.31866
be_else.31866:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31867
ble_then.31867:
	li      0, $17
	b       ble_cont.31867
ble_else.31867:
	li      1, $17
ble_cont.31867:
	cmp     $18, 0
	be      bne_cont.31868
bne_then.31868:
	cmp     $17, 0
	bne     be_else.31869
be_then.31869:
	li      1, $17
	b       be_cont.31869
be_else.31869:
	li      0, $17
be_cont.31869:
bne_cont.31868:
	load    [$14 + 4], $18
	load    [$18 + 0], $18
	cmp     $17, 0
	bne     be_else.31870
be_then.31870:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31870
be_else.31870:
	store   $18, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31870:
be_cont.31866:
	load    [$11 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31871
be_then.31871:
	store   $zero, [$16 + 3]
	b       be_cont.31871
be_else.31871:
	load    [$14 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31872
ble_then.31872:
	li      0, $17
	b       ble_cont.31872
ble_else.31872:
	li      1, $17
ble_cont.31872:
	cmp     $18, 0
	be      bne_cont.31873
bne_then.31873:
	cmp     $17, 0
	bne     be_else.31874
be_then.31874:
	li      1, $17
	b       be_cont.31874
be_else.31874:
	li      0, $17
be_cont.31874:
bne_cont.31873:
	load    [$14 + 4], $18
	load    [$18 + 1], $18
	cmp     $17, 0
	bne     be_else.31875
be_then.31875:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31875
be_else.31875:
	store   $18, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31875:
be_cont.31871:
	load    [$11 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31876
be_then.31876:
	store   $zero, [$16 + 5]
.count storer
	add     $13, $12, $tmp
	store   $16, [$tmp + 0]
	sub     $12, 1, $3
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31865
be_else.31876:
	load    [$14 + 6], $18
	load    [$14 + 4], $19
	fcmp    $zero, $17
	bg      ble_else.31877
ble_then.31877:
	li      0, $17
	b       ble_cont.31877
ble_else.31877:
	li      1, $17
ble_cont.31877:
	cmp     $18, 0
	be      bne_cont.31878
bne_then.31878:
	cmp     $17, 0
	bne     be_else.31879
be_then.31879:
	li      1, $17
	b       be_cont.31879
be_else.31879:
	li      0, $17
be_cont.31879:
bne_cont.31878:
	load    [$19 + 2], $18
	cmp     $17, 0
.count move_args
	mov     $10, $2
	sub     $12, 1, $3
.count storer
	add     $13, $12, $tmp
	bne     be_else.31880
be_then.31880:
	fneg    $18, $17
	store   $17, [$16 + 4]
	load    [$11 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31865
be_else.31880:
	store   $18, [$16 + 4]
	load    [$11 + 2], $17
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31865
be_else.31865:
	cmp     $15, 2
	bne     be_else.31881
be_then.31881:
	li      4, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$14 + 4], $17
	load    [$14 + 4], $18
	load    [$14 + 4], $19
	load    [$11 + 0], $20
	load    [$17 + 0], $17
	fmul    $20, $17, $17
	load    [$11 + 1], $20
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	fadd    $17, $18, $17
	load    [$11 + 2], $18
	load    [$19 + 2], $19
	fmul    $18, $19, $18
	fadd    $17, $18, $17
	fcmp    $17, $zero
.count move_args
	mov     $10, $2
	sub     $12, 1, $3
.count storer
	add     $13, $12, $tmp
	bg      ble_else.31882
ble_then.31882:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31881
ble_else.31882:
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
	b       be_cont.31881
be_else.31881:
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $16
	load    [$14 + 3], $17
	load    [$14 + 4], $18
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	load    [$11 + 0], $21
	load    [$11 + 1], $22
	load    [$11 + 2], $23
	fmul    $21, $21, $24
	load    [$18 + 0], $18
	fmul    $24, $18, $18
	fmul    $22, $22, $24
	load    [$19 + 1], $19
	fmul    $24, $19, $19
	fadd    $18, $19, $18
	fmul    $23, $23, $19
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	cmp     $17, 0
	be      bne_cont.31883
bne_then.31883:
	fmul    $22, $23, $19
	load    [$14 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $23, $21, $19
	load    [$14 + 9], $20
	load    [$20 + 1], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $21, $22, $19
	load    [$14 + 9], $20
	load    [$20 + 2], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31883:
	store   $18, [$16 + 0]
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$11 + 0], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $19
	load    [$11 + 1], $22
	load    [$20 + 1], $20
	fmul    $22, $20, $20
	load    [$11 + 2], $23
	load    [$21 + 2], $21
	fmul    $23, $21, $21
	fneg    $19, $19
	fneg    $20, $20
	fneg    $21, $21
	cmp     $17, 0
.count storer
	add     $13, $12, $tmp
	sub     $12, 1, $3
.count move_args
	mov     $10, $2
	bne     be_else.31884
be_then.31884:
	store   $19, [$16 + 1]
	store   $20, [$16 + 2]
	store   $21, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31885
be_then.31885:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31884
be_else.31885:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31884
be_else.31884:
	load    [$14 + 9], $17
	load    [$14 + 9], $24
	load    [$17 + 1], $17
	fmul    $23, $17, $23
	load    [$24 + 2], $24
	fmul    $22, $24, $22
	fadd    $23, $22, $22
	fmul    $22, $39, $22
	fsub    $19, $22, $19
	store   $19, [$16 + 1]
	load    [$14 + 9], $19
	load    [$11 + 2], $22
	load    [$19 + 0], $19
	fmul    $22, $19, $22
	load    [$11 + 0], $23
	fmul    $23, $24, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $20, $22, $20
	store   $20, [$16 + 2]
	load    [$11 + 1], $20
	fmul    $20, $19, $19
	load    [$11 + 0], $20
	fmul    $20, $17, $17
	fadd    $19, $17, $17
	fmul    $17, $39, $17
	fsub    $21, $17, $17
	store   $17, [$16 + 3]
	fcmp    $18, $zero
	bne     be_else.31886
be_then.31886:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31886
be_else.31886:
	finv    $18, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31886:
be_cont.31884:
be_cont.31881:
be_cont.31865:
bge_cont.31864:
	sub     $41, 1, $2
	call    setup_reflections.3064
	li      0, $10
	sub     $50, 1, $11
	load    [min_caml_screeny_dir + 0], $12
	load    [min_caml_scan_pitch + 0], $13
	load    [min_caml_image_center + 1], $14
	neg     $14, $2
	call    min_caml_float_of_int
	fmul    $13, $1, $1
	fmul    $1, $12, $2
	load    [min_caml_screenz_dir + 0], $3
	fadd    $2, $3, $5
	load    [min_caml_screeny_dir + 1], $2
	fmul    $1, $2, $2
	load    [min_caml_screenz_dir + 1], $3
	fadd    $2, $3, $6
	load    [min_caml_screeny_dir + 2], $2
	fmul    $1, $2, $1
	load    [min_caml_screenz_dir + 2], $2
	fadd    $1, $2, $7
.count stack_load
	load    [$sp + 1], $2
.count move_args
	mov     $10, $4
.count move_args
	mov     $11, $3
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
