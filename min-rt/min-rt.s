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
f.27325:	.float  -2.0000000000E+02
f.27324:	.float  2.0000000000E+02
f.27296:	.float  1.2800000000E+02
f.27234:	.float  2.0000000000E-01
f.27233:	.float  9.0000000000E-01
f.27205:	.float  1.5000000000E+02
f.27204:	.float  -1.5000000000E+02
f.27203:	.float  6.6666666667E-03
f.27202:	.float  -6.6666666667E-03
f.27201:	.float  -2.0000000000E+00
f.27200:	.float  3.9062500000E-03
f.27199:	.float  2.5600000000E+02
f.27198:	.float  1.0000000000E+08
f.27197:	.float  1.0000000000E+09
f.27196:	.float  1.0000000000E+01
f.27195:	.float  5.0000000000E-02
f.27194:	.float  2.0000000000E+01
f.27193:	.float  2.5000000000E-01
f.27192:	.float  1.0000000000E-01
f.27191:	.float  2.5500000000E+02
f.27190:	.float  3.3333333333E+00
f.27189:	.float  1.5000000000E-01
f.27188:	.float  3.1830988148E-01
f.27187:	.float  3.1415927000E+00
f.27186:	.float  3.0000000000E+01
f.27185:	.float  1.5000000000E+01
f.27184:	.float  1.0000000000E-04
f.27183:	.float  -1.0000000000E-01
f.27182:	.float  1.0000000000E-02
f.27181:	.float  -2.0000000000E-01
f.27180:	.float  5.0000000000E-01
f.27179:	.float  1.0000000000E+00
f.27178:	.float  -1.0000000000E+00
f.27177:	.float  2.0000000000E+00
f.27164:	.float  1.7453293000E-02

######################################################################
.begin read_nth_object
read_nth_object.2719:
.count stack_move
	sub     $sp, 1, $sp
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31032
be_then.31032:
.count stack_move
	add     $sp, 1, $sp
	li      0, $1
	ret
be_else.31032:
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
	be      bne_cont.31033
bne_then.31033:
	call    min_caml_read_float
.count load_float
	load    [f.27164], $21
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
bne_cont.31033:
	li      4, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $20
	fcmp    $zero, $16
	bg      ble_else.31034
ble_then.31034:
	li      0, $16
	b       ble_cont.31034
ble_else.31034:
	li      1, $16
ble_cont.31034:
	cmp     $11, 2
	bne     be_else.31035
be_then.31035:
	li      1, $21
	b       be_cont.31035
be_else.31035:
	mov     $16, $21
be_cont.31035:
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
	load    [$sp + 0], $15
	store   $12, [min_caml_objects + $15]
	bne     be_else.31036
be_then.31036:
	load    [$14 + 0], $11
	fcmp    $11, $zero
	bne     be_else.31037
be_then.31037:
	mov     $zero, $11
	b       be_cont.31037
be_else.31037:
	fcmp    $11, $zero
	bne     be_else.31038
be_then.31038:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
	b       be_cont.31038
be_else.31038:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.31039
ble_then.31039:
	fneg    $11, $11
ble_cont.31039:
be_cont.31038:
be_cont.31037:
	store   $11, [$14 + 0]
	load    [$14 + 1], $11
	fcmp    $11, $zero
	bne     be_else.31040
be_then.31040:
	mov     $zero, $11
	b       be_cont.31040
be_else.31040:
	fcmp    $11, $zero
	bne     be_else.31041
be_then.31041:
	fmul    $11, $11, $11
	finv    $11, $11
	mov     $zero, $11
	b       be_cont.31041
be_else.31041:
	fcmp    $11, $zero
	fmul    $11, $11, $11
	finv    $11, $11
	bg      ble_cont.31042
ble_then.31042:
	fneg    $11, $11
ble_cont.31042:
be_cont.31041:
be_cont.31040:
	store   $11, [$14 + 1]
	load    [$14 + 2], $11
	fcmp    $11, $zero
	bne     be_else.31043
be_then.31043:
	store   $zero, [$14 + 2]
	cmp     $13, 0
	bne     be_else.31044
be_then.31044:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.31044:
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
	fmul    $13, $1, $6
	fmul    $13, $16, $9
	load    [$14 + 1], $5
	load    [$14 + 0], $8
	fneg    $15, $3
	fmul    $6, $6, $7
	fmul    $9, $9, $10
	fmul    $3, $3, $4
	fmul    $12, $15, $17
	load    [$14 + 2], $2
	fmul    $5, $7, $7
	fmul    $8, $10, $10
	fmul    $2, $4, $4
	fmul    $17, $1, $18
	fmul    $11, $1, $20
	fmul    $17, $16, $17
	fadd    $10, $7, $7
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $16, $10
	fsub    $17, $20, $17
	fadd    $7, $4, $4
	fadd    $18, $10, $10
	fmul    $17, $17, $20
	store   $4, [$14 + 0]
	fmul    $12, $13, $4
	fmul    $10, $10, $18
	fmul    $8, $20, $20
	fmul    $4, $4, $7
	fmul    $5, $18, $18
	fmul    $2, $7, $7
	fadd    $20, $18, $18
	fadd    $18, $7, $7
	fmul    $12, $16, $18
	store   $7, [$14 + 1]
	fmul    $11, $13, $7
	fmul    $11, $15, $11
	fmul    $7, $7, $13
	fmul    $11, $1, $15
	fmul    $11, $16, $11
	fmul    $12, $1, $1
	fmul    $2, $13, $13
	fsub    $15, $18, $15
	fmul    $5, $10, $12
	fadd    $11, $1, $1
	fmul    $15, $15, $18
	fmul    $12, $15, $12
	fmul    $1, $1, $11
	fmul    $5, $18, $18
	fmul    $5, $6, $5
	fmul    $8, $11, $11
	fmul    $5, $15, $6
	fadd    $11, $18, $11
	fadd    $11, $13, $11
	fmul    $8, $17, $13
	store   $11, [$14 + 2]
	fmul    $2, $4, $11
	fmul    $13, $1, $13
	fmul    $2, $3, $2
	fmul    $11, $7, $11
	fadd    $13, $12, $12
	fmul    $2, $7, $3
	fmul    $8, $9, $7
	fadd    $12, $11, $11
.count load_float
	load    [f.27177], $12
	fmul    $7, $1, $1
	fmul    $12, $11, $11
	fadd    $1, $6, $1
	store   $11, [$19 + 0]
	fadd    $1, $3, $1
	fmul    $7, $17, $3
	fmul    $12, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $4, $1
	fmul    $5, $10, $2
	fadd    $3, $2, $2
	fadd    $2, $1, $1
	fmul    $12, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.31043:
	fmul    $11, $11, $12
	fcmp    $11, $zero
	finv    $12, $12
	bne     be_else.31045
be_then.31045:
	mov     $zero, $11
	b       be_cont.31045
be_else.31045:
	fcmp    $11, $zero
	bg      ble_else.31046
ble_then.31046:
	mov     $40, $11
	b       ble_cont.31046
ble_else.31046:
	mov     $36, $11
ble_cont.31046:
be_cont.31045:
	fmul    $11, $12, $11
	cmp     $13, 0
	store   $11, [$14 + 2]
	bne     be_else.31047
be_then.31047:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.31047:
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
	fmul    $13, $1, $6
	fmul    $13, $16, $9
	load    [$14 + 1], $5
	load    [$14 + 0], $8
	fneg    $15, $3
	fmul    $6, $6, $7
	fmul    $9, $9, $10
	fmul    $3, $3, $4
	fmul    $12, $15, $17
	load    [$14 + 2], $2
	fmul    $5, $7, $7
	fmul    $8, $10, $10
	fmul    $2, $4, $4
	fmul    $17, $1, $18
	fmul    $11, $1, $20
	fmul    $17, $16, $17
	fadd    $10, $7, $7
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $16, $10
	fsub    $17, $20, $17
	fadd    $7, $4, $4
	fadd    $18, $10, $10
	fmul    $17, $17, $20
	store   $4, [$14 + 0]
	fmul    $12, $13, $4
	fmul    $10, $10, $18
	fmul    $8, $20, $20
	fmul    $4, $4, $7
	fmul    $5, $18, $18
	fmul    $2, $7, $7
	fadd    $20, $18, $18
	fadd    $18, $7, $7
	fmul    $12, $16, $18
	store   $7, [$14 + 1]
	fmul    $11, $13, $7
	fmul    $11, $15, $11
	fmul    $7, $7, $13
	fmul    $11, $1, $15
	fmul    $11, $16, $11
	fmul    $12, $1, $1
	fmul    $2, $13, $13
	fsub    $15, $18, $15
	fmul    $5, $10, $12
	fadd    $11, $1, $1
	fmul    $15, $15, $18
	fmul    $12, $15, $12
	fmul    $1, $1, $11
	fmul    $5, $18, $18
	fmul    $5, $6, $5
	fmul    $8, $11, $11
	fmul    $5, $15, $6
	fadd    $11, $18, $11
	fadd    $11, $13, $11
	fmul    $8, $17, $13
	store   $11, [$14 + 2]
	fmul    $2, $4, $11
	fmul    $13, $1, $13
	fmul    $2, $3, $2
	fmul    $11, $7, $11
	fadd    $13, $12, $12
	fmul    $2, $7, $3
	fmul    $8, $9, $7
	fadd    $12, $11, $11
.count load_float
	load    [f.27177], $12
	fmul    $7, $1, $1
	fmul    $12, $11, $11
	fadd    $1, $6, $1
	store   $11, [$19 + 0]
	fadd    $1, $3, $1
	fmul    $7, $17, $3
	fmul    $12, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $4, $1
	fmul    $5, $10, $2
	fadd    $3, $2, $2
	fadd    $2, $1, $1
	fmul    $12, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.31036:
	cmp     $11, 2
	bne     be_else.31048
be_then.31048:
	load    [$14 + 1], $12
	load    [$14 + 0], $15
	load    [$14 + 2], $11
	fmul    $12, $12, $12
	fmul    $15, $15, $15
	fmul    $11, $11, $11
	cmp     $16, 0
	fadd    $15, $12, $12
	fadd    $12, $11, $11
	fsqrt   $11, $11
	bne     be_else.31049
be_then.31049:
	li      1, $12
	b       be_cont.31049
be_else.31049:
	li      0, $12
be_cont.31049:
	fcmp    $11, $zero
	bne     be_else.31050
be_then.31050:
	mov     $36, $11
	b       be_cont.31050
be_else.31050:
	cmp     $12, 0
	finv    $11, $11
	be      bne_cont.31051
bne_then.31051:
	fneg    $11, $11
bne_cont.31051:
be_cont.31050:
	load    [$14 + 0], $12
	cmp     $13, 0
	fmul    $12, $11, $12
	store   $12, [$14 + 0]
	load    [$14 + 1], $12
	fmul    $12, $11, $12
	store   $12, [$14 + 1]
	load    [$14 + 2], $12
	fmul    $12, $11, $11
	store   $11, [$14 + 2]
	bne     be_else.31052
be_then.31052:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.31052:
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
	fmul    $13, $1, $6
	fmul    $13, $16, $9
	load    [$14 + 1], $5
	load    [$14 + 0], $8
	fneg    $15, $3
	fmul    $6, $6, $7
	fmul    $9, $9, $10
	fmul    $3, $3, $4
	fmul    $12, $15, $17
	load    [$14 + 2], $2
	fmul    $5, $7, $7
	fmul    $8, $10, $10
	fmul    $2, $4, $4
	fmul    $17, $1, $18
	fmul    $11, $1, $20
	fmul    $17, $16, $17
	fadd    $10, $7, $7
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $16, $10
	fsub    $17, $20, $17
	fadd    $7, $4, $4
	fadd    $18, $10, $10
	fmul    $17, $17, $20
	store   $4, [$14 + 0]
	fmul    $12, $13, $4
	fmul    $10, $10, $18
	fmul    $8, $20, $20
	fmul    $4, $4, $7
	fmul    $5, $18, $18
	fmul    $2, $7, $7
	fadd    $20, $18, $18
	fadd    $18, $7, $7
	fmul    $12, $16, $18
	store   $7, [$14 + 1]
	fmul    $11, $13, $7
	fmul    $11, $15, $11
	fmul    $7, $7, $13
	fmul    $11, $1, $15
	fmul    $11, $16, $11
	fmul    $12, $1, $1
	fmul    $2, $13, $13
	fsub    $15, $18, $15
	fmul    $5, $10, $12
	fadd    $11, $1, $1
	fmul    $15, $15, $18
	fmul    $12, $15, $12
	fmul    $1, $1, $11
	fmul    $5, $18, $18
	fmul    $5, $6, $5
	fmul    $8, $11, $11
	fmul    $5, $15, $6
	fadd    $11, $18, $11
	fadd    $11, $13, $11
	fmul    $8, $17, $13
	store   $11, [$14 + 2]
	fmul    $2, $4, $11
	fmul    $13, $1, $13
	fmul    $2, $3, $2
	fmul    $11, $7, $11
	fadd    $13, $12, $12
	fmul    $2, $7, $3
	fmul    $8, $9, $7
	fadd    $12, $11, $11
.count load_float
	load    [f.27177], $12
	fmul    $7, $1, $1
	fmul    $12, $11, $11
	fadd    $1, $6, $1
	store   $11, [$19 + 0]
	fadd    $1, $3, $1
	fmul    $7, $17, $3
	fmul    $12, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $4, $1
	fmul    $5, $10, $2
	fadd    $3, $2, $2
	fadd    $2, $1, $1
	fmul    $12, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
be_else.31048:
	cmp     $13, 0
	bne     be_else.31053
be_then.31053:
.count stack_move
	add     $sp, 1, $sp
	li      1, $1
	ret
be_else.31053:
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
	fmul    $13, $1, $6
	fmul    $13, $16, $9
	load    [$14 + 1], $5
	load    [$14 + 0], $8
	fneg    $15, $3
	fmul    $6, $6, $7
	fmul    $9, $9, $10
	fmul    $3, $3, $4
	fmul    $12, $15, $17
	load    [$14 + 2], $2
	fmul    $5, $7, $7
	fmul    $8, $10, $10
	fmul    $2, $4, $4
	fmul    $17, $1, $18
	fmul    $11, $1, $20
	fmul    $17, $16, $17
	fadd    $10, $7, $7
.count stack_move
	add     $sp, 1, $sp
	fmul    $11, $16, $10
	fsub    $17, $20, $17
	fadd    $7, $4, $4
	fadd    $18, $10, $10
	fmul    $17, $17, $20
	store   $4, [$14 + 0]
	fmul    $12, $13, $4
	fmul    $10, $10, $18
	fmul    $8, $20, $20
	fmul    $4, $4, $7
	fmul    $5, $18, $18
	fmul    $2, $7, $7
	fadd    $20, $18, $18
	fadd    $18, $7, $7
	fmul    $12, $16, $18
	store   $7, [$14 + 1]
	fmul    $11, $13, $7
	fmul    $11, $15, $11
	fmul    $7, $7, $13
	fmul    $11, $1, $15
	fmul    $11, $16, $11
	fmul    $12, $1, $1
	fmul    $2, $13, $13
	fsub    $15, $18, $15
	fmul    $5, $10, $12
	fadd    $11, $1, $1
	fmul    $15, $15, $18
	fmul    $12, $15, $12
	fmul    $1, $1, $11
	fmul    $5, $18, $18
	fmul    $5, $6, $5
	fmul    $8, $11, $11
	fmul    $5, $15, $6
	fadd    $11, $18, $11
	fadd    $11, $13, $11
	fmul    $8, $17, $13
	store   $11, [$14 + 2]
	fmul    $2, $4, $11
	fmul    $13, $1, $13
	fmul    $2, $3, $2
	fmul    $11, $7, $11
	fadd    $13, $12, $12
	fmul    $2, $7, $3
	fmul    $8, $9, $7
	fadd    $12, $11, $11
.count load_float
	load    [f.27177], $12
	fmul    $7, $1, $1
	fmul    $12, $11, $11
	fadd    $1, $6, $1
	store   $11, [$19 + 0]
	fadd    $1, $3, $1
	fmul    $7, $17, $3
	fmul    $12, $1, $1
	store   $1, [$19 + 1]
	fmul    $2, $4, $1
	fmul    $5, $10, $2
	fadd    $3, $2, $2
	fadd    $2, $1, $1
	fmul    $12, $1, $1
	store   $1, [$19 + 2]
	li      1, $1
	ret
.end read_nth_object

######################################################################
.begin read_object
read_object.2721:
	cmp     $2, 60
	bl      bge_else.31054
bge_then.31054:
	ret
bge_else.31054:
.count stack_move
	sub     $sp, 8, $sp
	store   $2, [$sp + 0]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31055
be_then.31055:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 8], $1
.count move_float
	mov     $1, $41
	ret
be_else.31055:
	load    [$sp + 0], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31056
bge_then.31056:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31056:
	store   $2, [$sp + 1]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31057
be_then.31057:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 7], $1
.count move_float
	mov     $1, $41
	ret
be_else.31057:
	load    [$sp + 1], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31058
bge_then.31058:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31058:
	store   $2, [$sp + 2]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31059
be_then.31059:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 6], $1
.count move_float
	mov     $1, $41
	ret
be_else.31059:
	load    [$sp + 2], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31060
bge_then.31060:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31060:
	store   $2, [$sp + 3]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31061
be_then.31061:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 5], $1
.count move_float
	mov     $1, $41
	ret
be_else.31061:
	load    [$sp + 3], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31062
bge_then.31062:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31062:
	store   $2, [$sp + 4]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31063
be_then.31063:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 4], $1
.count move_float
	mov     $1, $41
	ret
be_else.31063:
	load    [$sp + 4], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31064
bge_then.31064:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31064:
	store   $2, [$sp + 5]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31065
be_then.31065:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 3], $1
.count move_float
	mov     $1, $41
	ret
be_else.31065:
	load    [$sp + 5], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31066
bge_then.31066:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31066:
	store   $2, [$sp + 6]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31067
be_then.31067:
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 2], $1
.count move_float
	mov     $1, $41
	ret
be_else.31067:
	load    [$sp + 6], $23
	add     $23, 1, $2
	cmp     $2, 60
	bl      bge_else.31068
bge_then.31068:
.count stack_move
	add     $sp, 8, $sp
	ret
bge_else.31068:
	store   $2, [$sp + 7]
	call    read_nth_object.2719
.count stack_move
	add     $sp, 8, $sp
	cmp     $1, 0
	load    [$sp - 1], $1
	bne     be_else.31069
be_then.31069:
.count move_float
	mov     $1, $41
	ret
be_else.31069:
	add     $1, 1, $2
	b       read_object.2721
.end read_object

######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_move
	sub     $sp, 8, $sp
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31070
be_then.31070:
.count stack_move
	add     $sp, 8, $sp
	add     $zero, -1, $3
	load    [$sp - 8], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.31070:
	call    min_caml_read_int
	load    [$sp + 0], $12
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	add     $12, 1, $13
	bne     be_else.31071
be_then.31071:
	add     $zero, -1, $3
	add     $13, 1, $2
	call    min_caml_create_array
.count storer
	add     $1, $12, $tmp
.count stack_move
	add     $sp, 8, $sp
	store   $10, [$tmp + 0]
	ret
be_else.31071:
	call    min_caml_read_int
.count move_ret
	mov     $1, $14
	add     $13, 1, $15
	cmp     $14, -1
	bne     be_else.31072
be_then.31072:
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
be_else.31072:
	call    min_caml_read_int
	add     $15, 1, $17
.count move_ret
	mov     $1, $16
	cmp     $16, -1
	add     $17, 1, $2
	bne     be_else.31073
be_then.31073:
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
be_else.31073:
	store   $10, [$sp + 1]
	store   $13, [$sp + 2]
	store   $11, [$sp + 3]
	store   $15, [$sp + 4]
	store   $14, [$sp + 5]
	store   $17, [$sp + 6]
	store   $16, [$sp + 7]
	call    read_net_item.2725
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 2], $2
	load    [$sp - 1], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	load    [$sp - 4], $2
	load    [$sp - 3], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	load    [$sp - 6], $2
	load    [$sp - 5], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	load    [$sp - 8], $2
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
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31074
be_then.31074:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31074
be_else.31074:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.31075
be_then.31075:
	add     $zero, -1, $3
	li      2, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31075
be_else.31075:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.31076
be_then.31076:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.31076
be_else.31076:
	store   $10, [$sp + 1]
	store   $11, [$sp + 2]
	store   $12, [$sp + 3]
	call    read_net_item.2725
	load    [$sp + 3], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.31076:
be_cont.31075:
be_cont.31074:
	mov     $10, $3
	load    [$3 + 0], $10
	cmp     $10, -1
	bne     be_else.31077
be_then.31077:
.count stack_move
	add     $sp, 9, $sp
	load    [$sp - 9], $10
	add     $10, 1, $2
	b       min_caml_create_array
be_else.31077:
	store   $3, [$sp + 4]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31078
be_then.31078:
	add     $zero, -1, $3
	li      1, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31078
be_else.31078:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31079
be_then.31079:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31079
be_else.31079:
	store   $10, [$sp + 5]
	store   $11, [$sp + 6]
	call    read_net_item.2725
	load    [$sp + 6], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
	load    [$sp + 5], $11
	store   $11, [$10 + 0]
be_cont.31079:
be_cont.31078:
	mov     $10, $3
	load    [$3 + 0], $12
	load    [$sp + 0], $10
	cmp     $12, -1
	add     $10, 1, $11
	add     $11, 1, $2
	bne     be_else.31080
be_then.31080:
	call    min_caml_create_array
.count stack_move
	add     $sp, 9, $sp
.count storer
	add     $1, $10, $tmp
	load    [$sp - 5], $2
	store   $2, [$tmp + 0]
	ret
be_else.31080:
	store   $11, [$sp + 7]
	store   $3, [$sp + 8]
	call    read_or_network.2727
.count stack_move
	add     $sp, 9, $sp
	load    [$sp - 2], $2
	load    [$sp - 1], $3
.count storer
	add     $1, $2, $tmp
	store   $3, [$tmp + 0]
	load    [$sp - 9], $2
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
	store   $2, [$sp + 0]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31081
be_then.31081:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31081
be_else.31081:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.31082
be_then.31082:
	add     $zero, -1, $3
	li      2, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31082
be_else.31082:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.31083
be_then.31083:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.31083
be_else.31083:
	store   $10, [$sp + 1]
	store   $11, [$sp + 2]
	store   $12, [$sp + 3]
	call    read_net_item.2725
	load    [$sp + 3], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
	load    [$sp + 2], $11
	store   $11, [$10 + 1]
	load    [$sp + 1], $11
	store   $11, [$10 + 0]
be_cont.31083:
be_cont.31082:
be_cont.31081:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31084
be_then.31084:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31084:
	load    [$sp + 0], $11
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31085
be_then.31085:
	add     $zero, -1, $3
	li      1, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31085
be_else.31085:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31086
be_then.31086:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31086
be_else.31086:
	store   $10, [$sp + 4]
	store   $11, [$sp + 5]
	call    read_net_item.2725
	load    [$sp + 5], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
	load    [$sp + 4], $11
	store   $11, [$10 + 0]
be_cont.31086:
be_cont.31085:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31087
be_then.31087:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31087:
	load    [$sp + 0], $11
	add     $11, 1, $11
	store   $11, [$sp + 6]
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31088
be_then.31088:
	li      1, $2
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31088
be_else.31088:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	bne     be_else.31089
be_then.31089:
	add     $zero, -1, $3
	li      2, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31089
be_else.31089:
	call    min_caml_read_int
.count move_ret
	mov     $1, $12
	cmp     $12, -1
	li      3, $2
	bne     be_else.31090
be_then.31090:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	store   $11, [$12 + 1]
	store   $10, [$12 + 0]
	mov     $12, $10
	b       be_cont.31090
be_else.31090:
	store   $10, [$sp + 7]
	store   $11, [$sp + 8]
	store   $12, [$sp + 9]
	call    read_net_item.2725
	load    [$sp + 9], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 2]
	load    [$sp + 8], $11
	store   $11, [$10 + 1]
	load    [$sp + 7], $11
	store   $11, [$10 + 0]
be_cont.31090:
be_cont.31089:
be_cont.31088:
	load    [$10 + 0], $11
	cmp     $11, -1
	bne     be_else.31091
be_then.31091:
.count stack_move
	add     $sp, 13, $sp
	ret
be_else.31091:
	load    [$sp + 6], $11
	add     $11, 1, $11
	store   $11, [$sp + 10]
	store   $10, [min_caml_and_net + $11]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31092
be_then.31092:
	add     $zero, -1, $3
	li      1, $2
	call    min_caml_create_array
	b       be_cont.31092
be_else.31092:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31093
be_then.31093:
	add     $zero, -1, $3
	call    min_caml_create_array
	store   $10, [$1 + 0]
	b       be_cont.31093
be_else.31093:
	store   $10, [$sp + 11]
	store   $11, [$sp + 12]
	call    read_net_item.2725
	load    [$sp + 12], $2
	store   $2, [$1 + 1]
	load    [$sp + 11], $2
	store   $2, [$1 + 0]
be_cont.31093:
be_cont.31092:
	load    [$1 + 0], $2
.count stack_move
	add     $sp, 13, $sp
	cmp     $2, -1
	bne     be_else.31094
be_then.31094:
	ret
be_else.31094:
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
	load    [min_caml_startp + 2], $7
	load    [$1 + 5], $4
	load    [$1 + 5], $5
	load    [$1 + 5], $6
	load    [$4 + 2], $4
	load    [$5 + 1], $5
	load    [$1 + 1], $2
	fsub    $7, $4, $4
	load    [$6 + 0], $6
	load    [min_caml_startp + 1], $7
	cmp     $2, 1
	fsub    $7, $5, $5
	load    [min_caml_startp + 0], $7
	fsub    $7, $6, $6
	bne     be_else.31095
be_then.31095:
	load    [$3 + 0], $2
	fcmp    $2, $zero
	bne     be_else.31096
be_then.31096:
	li      0, $2
	b       be_cont.31096
be_else.31096:
	load    [$1 + 4], $8
	finv    $2, $7
	fcmp    $zero, $2
	load    [$8 + 0], $9
	bg      ble_else.31097
ble_then.31097:
	li      0, $2
	b       ble_cont.31097
ble_else.31097:
	li      1, $2
ble_cont.31097:
	load    [$1 + 6], $10
	cmp     $10, 0
	be      bne_cont.31098
bne_then.31098:
	cmp     $2, 0
	bne     be_else.31099
be_then.31099:
	li      1, $2
	b       be_cont.31099
be_else.31099:
	li      0, $2
be_cont.31099:
bne_cont.31098:
	cmp     $2, 0
	bne     be_else.31100
be_then.31100:
	fneg    $9, $2
	b       be_cont.31100
be_else.31100:
	mov     $9, $2
be_cont.31100:
	fsub    $2, $6, $2
	load    [$8 + 1], $9
	fmul    $2, $7, $2
	load    [$3 + 1], $7
	fmul    $2, $7, $7
	fadd    $7, $5, $7
	fabs    $7, $7
	fcmp    $9, $7
	bg      ble_else.31101
ble_then.31101:
	li      0, $2
	b       ble_cont.31101
ble_else.31101:
	load    [$3 + 2], $7
	load    [$8 + 2], $8
	fmul    $2, $7, $7
	fadd    $7, $4, $7
	fabs    $7, $7
	fcmp    $8, $7
	bg      ble_else.31102
ble_then.31102:
	li      0, $2
	b       ble_cont.31102
ble_else.31102:
.count move_float
	mov     $2, $42
	li      1, $2
ble_cont.31102:
ble_cont.31101:
be_cont.31096:
	cmp     $2, 0
	bne     be_else.31103
be_then.31103:
	load    [$3 + 1], $2
	fcmp    $2, $zero
	bne     be_else.31104
be_then.31104:
	li      0, $2
	b       be_cont.31104
be_else.31104:
	load    [$1 + 4], $8
	finv    $2, $7
	fcmp    $zero, $2
	load    [$8 + 1], $9
	bg      ble_else.31105
ble_then.31105:
	li      0, $2
	b       ble_cont.31105
ble_else.31105:
	li      1, $2
ble_cont.31105:
	load    [$1 + 6], $10
	cmp     $10, 0
	be      bne_cont.31106
bne_then.31106:
	cmp     $2, 0
	bne     be_else.31107
be_then.31107:
	li      1, $2
	b       be_cont.31107
be_else.31107:
	li      0, $2
be_cont.31107:
bne_cont.31106:
	cmp     $2, 0
	bne     be_else.31108
be_then.31108:
	fneg    $9, $2
	b       be_cont.31108
be_else.31108:
	mov     $9, $2
be_cont.31108:
	fsub    $2, $5, $2
	load    [$8 + 2], $9
	fmul    $2, $7, $2
	load    [$3 + 2], $7
	fmul    $2, $7, $7
	fadd    $7, $4, $7
	fabs    $7, $7
	fcmp    $9, $7
	bg      ble_else.31109
ble_then.31109:
	li      0, $2
	b       ble_cont.31109
ble_else.31109:
	load    [$3 + 0], $7
	load    [$8 + 0], $8
	fmul    $2, $7, $7
	fadd    $7, $6, $7
	fabs    $7, $7
	fcmp    $8, $7
	bg      ble_else.31110
ble_then.31110:
	li      0, $2
	b       ble_cont.31110
ble_else.31110:
.count move_float
	mov     $2, $42
	li      1, $2
ble_cont.31110:
ble_cont.31109:
be_cont.31104:
	cmp     $2, 0
	bne     be_else.31111
be_then.31111:
	load    [$3 + 2], $2
	fcmp    $2, $zero
	bne     be_else.31112
be_then.31112:
	li      0, $1
	ret
be_else.31112:
	load    [$1 + 4], $7
	finv    $2, $8
	load    [$1 + 6], $1
	load    [$7 + 2], $9
	fcmp    $zero, $2
	bg      ble_else.31113
ble_then.31113:
	li      0, $2
	b       ble_cont.31113
ble_else.31113:
	li      1, $2
ble_cont.31113:
	cmp     $1, 0
	bne     be_else.31114
be_then.31114:
	mov     $2, $1
	b       be_cont.31114
be_else.31114:
	cmp     $2, 0
	bne     be_else.31115
be_then.31115:
	li      1, $1
	b       be_cont.31115
be_else.31115:
	li      0, $1
be_cont.31115:
be_cont.31114:
	cmp     $1, 0
	bne     be_else.31116
be_then.31116:
	fneg    $9, $1
	b       be_cont.31116
be_else.31116:
	mov     $9, $1
be_cont.31116:
	fsub    $1, $4, $1
	load    [$3 + 0], $2
	load    [$7 + 0], $4
	fmul    $1, $8, $1
	fmul    $1, $2, $2
	fadd    $2, $6, $2
	fabs    $2, $2
	fcmp    $4, $2
	bg      ble_else.31117
ble_then.31117:
	li      0, $1
	ret
ble_else.31117:
	load    [$3 + 1], $2
	load    [$7 + 1], $3
	fmul    $1, $2, $2
	fadd    $2, $5, $2
	fabs    $2, $2
	fcmp    $3, $2
	bg      ble_else.31118
ble_then.31118:
	li      0, $1
	ret
ble_else.31118:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.31111:
	li      2, $1
	ret
be_else.31103:
	li      1, $1
	ret
be_else.31095:
	cmp     $2, 2
	bne     be_else.31119
be_then.31119:
	load    [$1 + 4], $1
	load    [$3 + 1], $9
	load    [$3 + 2], $7
	load    [$1 + 1], $8
	load    [$1 + 2], $2
	load    [$3 + 0], $3
	load    [$1 + 0], $1
	fmul    $9, $8, $9
	fmul    $7, $2, $7
	fmul    $3, $1, $3
	fadd    $3, $9, $3
	fadd    $3, $7, $3
	fcmp    $3, $zero
	bg      ble_else.31120
ble_then.31120:
	li      0, $1
	ret
ble_else.31120:
	fmul    $2, $4, $2
	fmul    $1, $6, $1
	fmul    $8, $5, $4
	finv    $3, $3
	fadd    $1, $4, $1
	fadd    $1, $2, $1
	fneg    $1, $1
	fmul    $1, $3, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31119:
	load    [$3 + 1], $13
	load    [$3 + 2], $11
	load    [$1 + 4], $9
	load    [$3 + 0], $3
	load    [$1 + 4], $8
	fmul    $13, $13, $14
	fmul    $3, $3, $15
	load    [$9 + 0], $9
	load    [$8 + 1], $8
	load    [$1 + 4], $7
	fmul    $11, $11, $12
	fmul    $15, $9, $15
	fmul    $14, $8, $14
	load    [$7 + 2], $7
	load    [$1 + 3], $10
	fmul    $12, $7, $12
	fadd    $15, $14, $14
	cmp     $10, 0
	fadd    $14, $12, $12
	bne     be_else.31121
be_then.31121:
	mov     $12, $10
	b       be_cont.31121
be_else.31121:
	load    [$1 + 9], $10
	fmul    $3, $13, $14
	fmul    $11, $3, $15
	load    [$10 + 2], $10
	fmul    $13, $11, $16
	fmul    $14, $10, $10
	load    [$1 + 9], $14
	load    [$14 + 1], $14
	fmul    $15, $14, $14
	load    [$1 + 9], $15
	load    [$15 + 0], $15
	fmul    $16, $15, $15
	fadd    $12, $15, $12
	fadd    $12, $14, $12
	fadd    $12, $10, $10
be_cont.31121:
	fcmp    $10, $zero
	bne     be_else.31122
be_then.31122:
	li      0, $1
	ret
be_else.31122:
	fmul    $6, $6, $17
	fmul    $5, $5, $16
	fmul    $4, $4, $15
	load    [$1 + 3], $12
	load    [$1 + 3], $14
	fmul    $17, $9, $17
	fmul    $16, $8, $16
	fmul    $15, $7, $15
	cmp     $12, 0
	fadd    $17, $16, $16
	fadd    $16, $15, $15
	bne     be_else.31123
be_then.31123:
	mov     $15, $12
	b       be_cont.31123
be_else.31123:
	load    [$1 + 9], $12
	fmul    $6, $5, $16
	fmul    $4, $6, $17
	load    [$12 + 2], $12
	fmul    $5, $4, $18
	fmul    $16, $12, $12
	load    [$1 + 9], $16
	load    [$16 + 1], $16
	fmul    $17, $16, $16
	load    [$1 + 9], $17
	load    [$17 + 0], $17
	fmul    $18, $17, $17
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fadd    $15, $12, $12
be_cont.31123:
	cmp     $2, 3
	bne     be_else.31124
be_then.31124:
	fsub    $12, $36, $2
	b       be_cont.31124
be_else.31124:
	mov     $12, $2
be_cont.31124:
	fmul    $11, $4, $12
	fmul    $10, $2, $2
	cmp     $14, 0
	fmul    $12, $7, $7
	fmul    $13, $5, $12
	fmul    $12, $8, $8
	fmul    $3, $6, $12
	fmul    $12, $9, $9
	fadd    $9, $8, $8
	fadd    $8, $7, $7
	bne     be_else.31125
be_then.31125:
	mov     $7, $3
	b       be_cont.31125
be_else.31125:
	fmul    $3, $5, $12
	fmul    $13, $6, $9
	load    [$1 + 9], $8
	fmul    $3, $4, $3
	fmul    $11, $6, $6
	load    [$8 + 2], $8
	fadd    $12, $9, $9
	fmul    $11, $5, $5
	fmul    $13, $4, $4
	fadd    $3, $6, $3
	fmul    $9, $8, $8
	load    [$1 + 9], $6
	load    [$1 + 9], $9
	fadd    $5, $4, $4
	load    [$6 + 0], $6
	load    [$9 + 1], $9
	fmul    $4, $6, $4
	fmul    $3, $9, $3
	fadd    $4, $3, $3
	fadd    $3, $8, $3
	fmul    $3, $39, $3
	fadd    $7, $3, $3
be_cont.31125:
	fmul    $3, $3, $4
	fsub    $4, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31126
ble_then.31126:
	li      0, $1
	ret
ble_else.31126:
	load    [$1 + 6], $1
	fsqrt   $2, $2
	finv    $10, $4
	cmp     $1, 0
	bne     be_else.31127
be_then.31127:
	fneg    $2, $1
	fsub    $1, $3, $1
	fmul    $1, $4, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31127:
	fsub    $2, $3, $1
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
	load    [min_caml_light_dirvec + 1], $4
	load    [$1 + 5], $5
	load    [$4 + $2], $2
	load    [$1 + 5], $6
	load    [$5 + 2], $4
	load    [$1 + 5], $7
	load    [min_caml_intersection_point + 2], $5
	load    [$1 + 1], $3
	fsub    $5, $4, $4
	cmp     $3, 1
	load    [$6 + 1], $5
	load    [min_caml_intersection_point + 1], $6
	fsub    $6, $5, $5
	load    [$7 + 0], $6
	load    [min_caml_intersection_point + 0], $7
	fsub    $7, $6, $6
	bne     be_else.31128
be_then.31128:
	load    [$2 + 0], $9
	load    [$2 + 1], $8
	load    [min_caml_light_dirvec + 0], $3
	fsub    $9, $6, $9
	load    [$1 + 4], $7
	load    [$7 + 1], $7
	fmul    $9, $8, $8
	load    [$3 + 1], $9
	fmul    $8, $9, $9
	fadd    $9, $5, $9
	fabs    $9, $9
	fcmp    $7, $9
	bg      ble_else.31129
ble_then.31129:
	li      0, $9
	b       ble_cont.31129
ble_else.31129:
	load    [$3 + 2], $10
	load    [$1 + 4], $9
	fmul    $8, $10, $10
	load    [$9 + 2], $9
	fadd    $10, $4, $10
	fabs    $10, $10
	fcmp    $9, $10
	bg      ble_else.31130
ble_then.31130:
	li      0, $9
	b       ble_cont.31130
ble_else.31130:
	load    [$2 + 1], $9
	fcmp    $9, $zero
	bne     be_else.31131
be_then.31131:
	li      0, $9
	b       be_cont.31131
be_else.31131:
	li      1, $9
be_cont.31131:
ble_cont.31130:
ble_cont.31129:
	cmp     $9, 0
	bne     be_else.31132
be_then.31132:
	load    [$2 + 2], $10
	load    [$2 + 3], $9
	load    [$1 + 4], $8
	fsub    $10, $5, $10
	load    [$8 + 0], $8
	fmul    $10, $9, $9
	load    [$3 + 0], $10
	fmul    $9, $10, $10
	fadd    $10, $6, $10
	fabs    $10, $10
	fcmp    $8, $10
	bg      ble_else.31133
ble_then.31133:
	li      0, $1
	b       ble_cont.31133
ble_else.31133:
	load    [$3 + 2], $10
	load    [$1 + 4], $1
	fmul    $9, $10, $10
	load    [$1 + 2], $1
	fadd    $10, $4, $10
	fabs    $10, $10
	fcmp    $1, $10
	bg      ble_else.31134
ble_then.31134:
	li      0, $1
	b       ble_cont.31134
ble_else.31134:
	load    [$2 + 3], $1
	fcmp    $1, $zero
	bne     be_else.31135
be_then.31135:
	li      0, $1
	b       be_cont.31135
be_else.31135:
	li      1, $1
be_cont.31135:
ble_cont.31134:
ble_cont.31133:
	cmp     $1, 0
	bne     be_else.31136
be_then.31136:
	load    [$2 + 4], $9
	load    [$2 + 5], $1
	fsub    $9, $4, $4
	fmul    $4, $1, $1
	load    [$3 + 0], $4
	fmul    $1, $4, $4
	fadd    $4, $6, $4
	fabs    $4, $4
	fcmp    $8, $4
	bg      ble_else.31137
ble_then.31137:
	li      0, $1
	ret
ble_else.31137:
	load    [$3 + 1], $3
	fmul    $1, $3, $3
	fadd    $3, $5, $3
	fabs    $3, $3
	fcmp    $7, $3
	bg      ble_else.31138
ble_then.31138:
	li      0, $1
	ret
ble_else.31138:
	load    [$2 + 5], $2
	fcmp    $2, $zero
	bne     be_else.31139
be_then.31139:
	li      0, $1
	ret
be_else.31139:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.31136:
.count move_float
	mov     $9, $42
	li      2, $1
	ret
be_else.31132:
.count move_float
	mov     $8, $42
	li      1, $1
	ret
be_else.31128:
	cmp     $3, 2
	bne     be_else.31140
be_then.31140:
	load    [$2 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31141
ble_then.31141:
	li      0, $1
	ret
ble_else.31141:
	load    [$2 + 2], $3
	load    [$2 + 3], $1
	load    [$2 + 1], $2
	fmul    $3, $5, $3
	fmul    $1, $4, $1
	fmul    $2, $6, $2
	fadd    $2, $3, $2
	fadd    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31140:
	load    [$2 + 0], $7
	fcmp    $7, $zero
	bne     be_else.31142
be_then.31142:
	li      0, $1
	ret
be_else.31142:
	load    [$1 + 4], $8
	fmul    $4, $4, $12
	load    [$1 + 4], $9
	load    [$8 + 2], $8
	load    [$1 + 4], $10
	load    [$9 + 1], $9
	fmul    $12, $8, $8
	load    [$10 + 0], $10
	fmul    $5, $5, $12
	load    [$1 + 3], $11
	cmp     $11, 0
	fmul    $12, $9, $9
	fmul    $6, $6, $12
	fmul    $12, $10, $10
	fadd    $10, $9, $9
	fadd    $9, $8, $8
	be      bne_cont.31143
bne_then.31143:
	load    [$1 + 9], $9
	fmul    $6, $5, $10
	fmul    $4, $6, $11
	load    [$9 + 2], $9
	fmul    $5, $4, $12
	fmul    $10, $9, $9
	load    [$1 + 9], $10
	load    [$10 + 1], $10
	fmul    $11, $10, $10
	load    [$1 + 9], $11
	load    [$11 + 0], $11
	fmul    $12, $11, $11
	fadd    $8, $11, $8
	fadd    $8, $10, $8
	fadd    $8, $9, $8
bne_cont.31143:
	cmp     $3, 3
	bne     be_else.31144
be_then.31144:
	fsub    $8, $36, $3
	b       be_cont.31144
be_else.31144:
	mov     $8, $3
be_cont.31144:
	fmul    $7, $3, $3
	load    [$2 + 3], $7
	fmul    $7, $4, $4
	load    [$2 + 2], $7
	fmul    $7, $5, $5
	load    [$2 + 1], $7
	fmul    $7, $6, $6
	fadd    $6, $5, $5
	fadd    $5, $4, $4
	fmul    $4, $4, $5
	fsub    $5, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31145
ble_then.31145:
	li      0, $1
	ret
ble_else.31145:
	load    [$1 + 6], $1
	cmp     $1, 0
	load    [$2 + 4], $1
	fsqrt   $3, $2
	bne     be_else.31146
be_then.31146:
	fsub    $4, $2, $2
	fmul    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31146:
	fadd    $4, $2, $2
	fmul    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
.end solver_fast

######################################################################
.begin solver_fast2
solver_fast2.2814:
	load    [min_caml_objects + $2], $1
	load    [$3 + 1], $6
	load    [$1 + 10], $4
	load    [$1 + 1], $5
	load    [$6 + $2], $2
	load    [$4 + 1], $7
	load    [$4 + 2], $6
	load    [$4 + 0], $8
	cmp     $5, 1
	bne     be_else.31147
be_then.31147:
	load    [$2 + 0], $9
	load    [$2 + 1], $5
	load    [$3 + 0], $3
	fsub    $9, $8, $9
	load    [$1 + 4], $4
	load    [$4 + 1], $4
	fmul    $9, $5, $5
	load    [$3 + 1], $9
	fmul    $5, $9, $9
	fadd    $9, $7, $9
	fabs    $9, $9
	fcmp    $4, $9
	bg      ble_else.31148
ble_then.31148:
	li      0, $9
	b       ble_cont.31148
ble_else.31148:
	load    [$3 + 2], $10
	load    [$1 + 4], $9
	fmul    $5, $10, $10
	load    [$9 + 2], $9
	fadd    $10, $6, $10
	fabs    $10, $10
	fcmp    $9, $10
	bg      ble_else.31149
ble_then.31149:
	li      0, $9
	b       ble_cont.31149
ble_else.31149:
	load    [$2 + 1], $9
	fcmp    $9, $zero
	bne     be_else.31150
be_then.31150:
	li      0, $9
	b       be_cont.31150
be_else.31150:
	li      1, $9
be_cont.31150:
ble_cont.31149:
ble_cont.31148:
	cmp     $9, 0
	bne     be_else.31151
be_then.31151:
	load    [$2 + 2], $10
	load    [$2 + 3], $9
	load    [$1 + 4], $5
	fsub    $10, $7, $10
	load    [$5 + 0], $5
	fmul    $10, $9, $9
	load    [$3 + 0], $10
	fmul    $9, $10, $10
	fadd    $10, $8, $10
	fabs    $10, $10
	fcmp    $5, $10
	bg      ble_else.31152
ble_then.31152:
	li      0, $1
	b       ble_cont.31152
ble_else.31152:
	load    [$3 + 2], $10
	load    [$1 + 4], $1
	fmul    $9, $10, $10
	load    [$1 + 2], $1
	fadd    $10, $6, $10
	fabs    $10, $10
	fcmp    $1, $10
	bg      ble_else.31153
ble_then.31153:
	li      0, $1
	b       ble_cont.31153
ble_else.31153:
	load    [$2 + 3], $1
	fcmp    $1, $zero
	bne     be_else.31154
be_then.31154:
	li      0, $1
	b       be_cont.31154
be_else.31154:
	li      1, $1
be_cont.31154:
ble_cont.31153:
ble_cont.31152:
	cmp     $1, 0
	bne     be_else.31155
be_then.31155:
	load    [$2 + 4], $9
	load    [$2 + 5], $1
	fsub    $9, $6, $6
	fmul    $6, $1, $1
	load    [$3 + 0], $6
	fmul    $1, $6, $6
	fadd    $6, $8, $6
	fabs    $6, $6
	fcmp    $5, $6
	bg      ble_else.31156
ble_then.31156:
	li      0, $1
	ret
ble_else.31156:
	load    [$3 + 1], $3
	fmul    $1, $3, $3
	fadd    $3, $7, $3
	fabs    $3, $3
	fcmp    $4, $3
	bg      ble_else.31157
ble_then.31157:
	li      0, $1
	ret
ble_else.31157:
	load    [$2 + 5], $2
	fcmp    $2, $zero
	bne     be_else.31158
be_then.31158:
	li      0, $1
	ret
be_else.31158:
.count move_float
	mov     $1, $42
	li      3, $1
	ret
be_else.31155:
.count move_float
	mov     $9, $42
	li      2, $1
	ret
be_else.31151:
.count move_float
	mov     $5, $42
	li      1, $1
	ret
be_else.31147:
	cmp     $5, 2
	bne     be_else.31159
be_then.31159:
	load    [$2 + 0], $1
	fcmp    $zero, $1
	bg      ble_else.31160
ble_then.31160:
	li      0, $1
	ret
ble_else.31160:
	load    [$4 + 3], $2
	fmul    $1, $2, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31159:
	load    [$2 + 0], $3
	fcmp    $3, $zero
	bne     be_else.31161
be_then.31161:
	li      0, $1
	ret
be_else.31161:
	load    [$4 + 3], $4
	load    [$2 + 2], $5
	fmul    $3, $4, $3
	fmul    $5, $7, $5
	load    [$2 + 3], $4
	fmul    $4, $6, $4
	load    [$2 + 1], $6
	fmul    $6, $8, $6
	fadd    $6, $5, $5
	fadd    $5, $4, $4
	fmul    $4, $4, $5
	fsub    $5, $3, $3
	fcmp    $3, $zero
	bg      ble_else.31162
ble_then.31162:
	li      0, $1
	ret
ble_else.31162:
	load    [$1 + 6], $1
	cmp     $1, 0
	load    [$2 + 4], $1
	fsqrt   $3, $2
	bne     be_else.31163
be_then.31163:
	fsub    $4, $2, $2
	fmul    $2, $1, $1
.count move_float
	mov     $1, $42
	li      1, $1
	ret
be_else.31163:
	fadd    $4, $2, $2
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
	bl      bge_else.31164
bge_then.31164:
	load    [min_caml_objects + $3], $11
.count stack_move
	sub     $sp, 2, $sp
	load    [$2 + 1], $13
	load    [$11 + 1], $12
	load    [$2 + 0], $10
	store   $2, [$sp + 0]
	cmp     $12, 1
	store   $3, [$sp + 1]
.count move_args
	mov     $zero, $3
	bne     be_else.31165
be_then.31165:
	li      6, $2
	call    min_caml_create_array
	load    [$10 + 0], $14
.count move_ret
	mov     $1, $12
	fcmp    $14, $zero
	bne     be_else.31166
be_then.31166:
	store   $zero, [$12 + 1]
	b       be_cont.31166
be_else.31166:
	load    [$11 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31167
ble_then.31167:
	li      0, $14
	b       ble_cont.31167
ble_else.31167:
	li      1, $14
ble_cont.31167:
	cmp     $15, 0
	be      bne_cont.31168
bne_then.31168:
	cmp     $14, 0
	bne     be_else.31169
be_then.31169:
	li      1, $14
	b       be_cont.31169
be_else.31169:
	li      0, $14
be_cont.31169:
bne_cont.31168:
	load    [$11 + 4], $15
	cmp     $14, 0
	load    [$15 + 0], $15
	bne     be_else.31170
be_then.31170:
	fneg    $15, $14
	store   $14, [$12 + 0]
	load    [$10 + 0], $14
	finv    $14, $14
	store   $14, [$12 + 1]
	b       be_cont.31170
be_else.31170:
	store   $15, [$12 + 0]
	load    [$10 + 0], $14
	finv    $14, $14
	store   $14, [$12 + 1]
be_cont.31170:
be_cont.31166:
	load    [$10 + 1], $14
	fcmp    $14, $zero
	bne     be_else.31171
be_then.31171:
	store   $zero, [$12 + 3]
	b       be_cont.31171
be_else.31171:
	load    [$11 + 6], $15
	fcmp    $zero, $14
	bg      ble_else.31172
ble_then.31172:
	li      0, $14
	b       ble_cont.31172
ble_else.31172:
	li      1, $14
ble_cont.31172:
	cmp     $15, 0
	be      bne_cont.31173
bne_then.31173:
	cmp     $14, 0
	bne     be_else.31174
be_then.31174:
	li      1, $14
	b       be_cont.31174
be_else.31174:
	li      0, $14
be_cont.31174:
bne_cont.31173:
	load    [$11 + 4], $15
	cmp     $14, 0
	load    [$15 + 1], $15
	bne     be_else.31175
be_then.31175:
	fneg    $15, $14
	store   $14, [$12 + 2]
	load    [$10 + 1], $14
	finv    $14, $14
	store   $14, [$12 + 3]
	b       be_cont.31175
be_else.31175:
	store   $15, [$12 + 2]
	load    [$10 + 1], $14
	finv    $14, $14
	store   $14, [$12 + 3]
be_cont.31175:
be_cont.31171:
	load    [$10 + 2], $14
	fcmp    $14, $zero
	bne     be_else.31176
be_then.31176:
	store   $zero, [$12 + 5]
	mov     $12, $11
	b       be_cont.31176
be_else.31176:
	load    [$11 + 4], $15
	fcmp    $zero, $14
	load    [$15 + 2], $15
	bg      ble_else.31177
ble_then.31177:
	li      0, $14
	b       ble_cont.31177
ble_else.31177:
	li      1, $14
ble_cont.31177:
	load    [$11 + 6], $11
	cmp     $11, 0
	bne     be_else.31178
be_then.31178:
	cmp     $14, 0
	bne     be_else.31179
be_then.31179:
	fneg    $15, $11
	store   $11, [$12 + 4]
	load    [$10 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
	b       be_cont.31178
be_else.31179:
	store   $15, [$12 + 4]
	load    [$10 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
	b       be_cont.31178
be_else.31178:
	cmp     $14, 0
	bne     be_else.31180
be_then.31180:
	store   $15, [$12 + 4]
	load    [$10 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
	b       be_cont.31180
be_else.31180:
	fneg    $15, $11
	store   $11, [$12 + 4]
	load    [$10 + 2], $11
	finv    $11, $11
	store   $11, [$12 + 5]
	mov     $12, $11
be_cont.31180:
be_cont.31178:
be_cont.31176:
	load    [$sp + 1], $12
.count storer
	add     $13, $12, $tmp
	store   $11, [$tmp + 0]
	sub     $12, 1, $11
	cmp     $11, 0
	bl      bge_else.31181
bge_then.31181:
	load    [min_caml_objects + $11], $12
.count move_args
	mov     $zero, $3
	load    [$12 + 1], $14
	cmp     $14, 1
	bne     be_else.31182
be_then.31182:
	li      6, $2
	call    min_caml_create_array
	load    [$10 + 0], $2
.count stack_move
	add     $sp, 2, $sp
	fcmp    $2, $zero
	bne     be_else.31183
be_then.31183:
	store   $zero, [$1 + 1]
	b       be_cont.31183
be_else.31183:
	load    [$12 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31184
ble_then.31184:
	li      0, $2
	b       ble_cont.31184
ble_else.31184:
	li      1, $2
ble_cont.31184:
	cmp     $3, 0
	be      bne_cont.31185
bne_then.31185:
	cmp     $2, 0
	bne     be_else.31186
be_then.31186:
	li      1, $2
	b       be_cont.31186
be_else.31186:
	li      0, $2
be_cont.31186:
bne_cont.31185:
	load    [$12 + 4], $3
	cmp     $2, 0
	load    [$3 + 0], $3
	bne     be_else.31187
be_then.31187:
	fneg    $3, $2
	store   $2, [$1 + 0]
	load    [$10 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
	b       be_cont.31187
be_else.31187:
	store   $3, [$1 + 0]
	load    [$10 + 0], $2
	finv    $2, $2
	store   $2, [$1 + 1]
be_cont.31187:
be_cont.31183:
	load    [$10 + 1], $2
	fcmp    $2, $zero
	bne     be_else.31188
be_then.31188:
	store   $zero, [$1 + 3]
	b       be_cont.31188
be_else.31188:
	load    [$12 + 6], $3
	fcmp    $zero, $2
	bg      ble_else.31189
ble_then.31189:
	li      0, $2
	b       ble_cont.31189
ble_else.31189:
	li      1, $2
ble_cont.31189:
	cmp     $3, 0
	be      bne_cont.31190
bne_then.31190:
	cmp     $2, 0
	bne     be_else.31191
be_then.31191:
	li      1, $2
	b       be_cont.31191
be_else.31191:
	li      0, $2
be_cont.31191:
bne_cont.31190:
	load    [$12 + 4], $3
	cmp     $2, 0
	load    [$3 + 1], $3
	bne     be_else.31192
be_then.31192:
	fneg    $3, $2
	store   $2, [$1 + 2]
	load    [$10 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
	b       be_cont.31192
be_else.31192:
	store   $3, [$1 + 2]
	load    [$10 + 1], $2
	finv    $2, $2
	store   $2, [$1 + 3]
be_cont.31192:
be_cont.31188:
	load    [$10 + 2], $2
	fcmp    $2, $zero
	bne     be_else.31193
be_then.31193:
	store   $zero, [$1 + 5]
.count storer
	add     $13, $11, $tmp
	sub     $11, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31193:
	load    [$12 + 4], $3
	load    [$12 + 6], $4
	fcmp    $zero, $2
	load    [$3 + 2], $3
	bg      ble_else.31194
ble_then.31194:
	li      0, $2
	b       ble_cont.31194
ble_else.31194:
	li      1, $2
ble_cont.31194:
	cmp     $4, 0
	be      bne_cont.31195
bne_then.31195:
	cmp     $2, 0
	bne     be_else.31196
be_then.31196:
	li      1, $2
	b       be_cont.31196
be_else.31196:
	li      0, $2
be_cont.31196:
bne_cont.31195:
	cmp     $2, 0
	bne     be_else.31197
be_then.31197:
	fneg    $3, $2
	b       be_cont.31197
be_else.31197:
	mov     $3, $2
be_cont.31197:
	store   $2, [$1 + 4]
.count storer
	add     $13, $11, $tmp
	load    [$10 + 2], $2
	sub     $11, 1, $3
	finv    $2, $2
	store   $2, [$1 + 5]
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31182:
	cmp     $14, 2
	bne     be_else.31198
be_then.31198:
	li      4, $2
	call    min_caml_create_array
	load    [$12 + 4], $2
	load    [$10 + 2], $5
	load    [$12 + 4], $3
	load    [$2 + 2], $2
	load    [$12 + 4], $4
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$4 + 0], $4
	load    [$10 + 1], $5
.count stack_move
	add     $sp, 2, $sp
.count storer
	add     $13, $11, $tmp
	fmul    $5, $3, $3
	load    [$10 + 0], $5
	fmul    $5, $4, $4
	fadd    $4, $3, $3
	fadd    $3, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31199
ble_then.31199:
	store   $zero, [$1 + 0]
	sub     $11, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.31199:
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
	sub     $11, 1, $3
	fneg    $2, $2
	store   $2, [$1 + 3]
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31198:
	li      5, $2
	call    min_caml_create_array
	load    [$10 + 2], $6
	load    [$12 + 4], $2
	load    [$12 + 4], $3
	fmul    $6, $6, $7
	load    [$2 + 2], $2
	load    [$3 + 1], $3
	load    [$12 + 4], $4
	load    [$12 + 3], $5
	fmul    $7, $2, $2
	load    [$4 + 0], $4
	load    [$10 + 1], $7
.count stack_move
	add     $sp, 2, $sp
	cmp     $5, 0
	fmul    $7, $7, $8
	fmul    $8, $3, $3
	load    [$10 + 0], $8
	fmul    $8, $8, $9
	fmul    $9, $4, $4
	fadd    $4, $3, $3
	fadd    $3, $2, $2
	be      bne_cont.31200
bne_then.31200:
	load    [$12 + 9], $4
	fmul    $7, $6, $3
	load    [$4 + 0], $4
	fmul    $3, $4, $3
	load    [$12 + 9], $4
	fadd    $2, $3, $2
	load    [$4 + 1], $4
	fmul    $6, $8, $3
	fmul    $3, $4, $3
	load    [$12 + 9], $4
	fadd    $2, $3, $2
	load    [$4 + 2], $4
	fmul    $8, $7, $3
	fmul    $3, $4, $3
	fadd    $2, $3, $2
bne_cont.31200:
	store   $2, [$1 + 0]
	load    [$12 + 4], $3
	load    [$12 + 4], $4
	load    [$12 + 4], $6
	load    [$10 + 2], $7
	load    [$3 + 2], $3
	load    [$10 + 1], $8
	load    [$4 + 1], $4
	load    [$10 + 0], $9
	load    [$6 + 0], $6
	fmul    $7, $3, $3
	fmul    $8, $4, $4
	fmul    $9, $6, $6
	cmp     $5, 0
.count storer
	add     $13, $11, $tmp
	fneg    $3, $3
	fneg    $4, $4
	fneg    $6, $6
	bne     be_else.31201
be_then.31201:
	store   $6, [$1 + 1]
	fcmp    $2, $zero
	store   $4, [$1 + 2]
	store   $3, [$1 + 3]
	sub     $11, 1, $3
	bne     be_else.31202
be_then.31202:
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31202:
	finv    $2, $2
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31201:
	load    [$12 + 9], $5
	load    [$12 + 9], $9
	fcmp    $2, $zero
	load    [$5 + 2], $5
	load    [$9 + 1], $9
	fmul    $8, $5, $8
	fmul    $7, $9, $7
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $6, $7, $6
	store   $6, [$1 + 1]
	load    [$10 + 0], $7
	load    [$12 + 9], $6
	fmul    $7, $5, $5
	load    [$6 + 0], $6
	load    [$10 + 2], $7
	fmul    $7, $6, $7
	fadd    $7, $5, $5
	fmul    $5, $39, $5
	fsub    $4, $5, $4
	store   $4, [$1 + 2]
	load    [$10 + 1], $5
	load    [$10 + 0], $4
	fmul    $5, $6, $5
	fmul    $4, $9, $4
	fadd    $5, $4, $4
	fmul    $4, $39, $4
	fsub    $3, $4, $3
	store   $3, [$1 + 3]
	sub     $11, 1, $3
	bne     be_else.31203
be_then.31203:
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31203:
	finv    $2, $2
	store   $2, [$1 + 4]
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31181:
.count stack_move
	add     $sp, 2, $sp
	ret
be_else.31165:
	cmp     $12, 2
	bne     be_else.31204
be_then.31204:
	li      4, $2
	call    min_caml_create_array
	load    [$11 + 4], $2
	load    [$10 + 2], $5
	load    [$11 + 4], $3
	load    [$2 + 2], $2
	load    [$11 + 4], $4
	load    [$3 + 1], $3
	fmul    $5, $2, $2
	load    [$4 + 0], $4
	load    [$10 + 1], $5
.count stack_move
	add     $sp, 2, $sp
	fmul    $5, $3, $3
	load    [$10 + 0], $5
	fmul    $5, $4, $4
	fadd    $4, $3, $3
	fadd    $3, $2, $2
	fcmp    $2, $zero
	bg      ble_else.31205
ble_then.31205:
	store   $zero, [$1 + 0]
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
ble_else.31205:
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
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31204:
	li      5, $2
	call    min_caml_create_array
	load    [$10 + 2], $6
	load    [$11 + 4], $2
	load    [$11 + 4], $3
	fmul    $6, $6, $7
	load    [$2 + 2], $2
	load    [$3 + 1], $3
	load    [$11 + 4], $4
	load    [$11 + 3], $5
	fmul    $7, $2, $2
	load    [$4 + 0], $4
	load    [$10 + 1], $7
.count stack_move
	add     $sp, 2, $sp
	cmp     $5, 0
	fmul    $7, $7, $8
	fmul    $8, $3, $3
	load    [$10 + 0], $8
	fmul    $8, $8, $9
	fmul    $9, $4, $4
	fadd    $4, $3, $3
	fadd    $3, $2, $2
	be      bne_cont.31206
bne_then.31206:
	load    [$11 + 9], $4
	fmul    $7, $6, $3
	load    [$4 + 0], $4
	fmul    $3, $4, $3
	load    [$11 + 9], $4
	fadd    $2, $3, $2
	load    [$4 + 1], $4
	fmul    $6, $8, $3
	fmul    $3, $4, $3
	load    [$11 + 9], $4
	fadd    $2, $3, $2
	load    [$4 + 2], $4
	fmul    $8, $7, $3
	fmul    $3, $4, $3
	fadd    $2, $3, $2
bne_cont.31206:
	store   $2, [$1 + 0]
	load    [$11 + 4], $3
	load    [$11 + 4], $4
	load    [$11 + 4], $6
	load    [$10 + 2], $7
	load    [$3 + 2], $3
	load    [$10 + 1], $8
	load    [$4 + 1], $4
	load    [$10 + 0], $9
	load    [$6 + 0], $6
	fmul    $7, $3, $3
	fmul    $8, $4, $4
	fmul    $9, $6, $6
	cmp     $5, 0
	fneg    $3, $3
	fneg    $4, $4
	fneg    $6, $6
	bne     be_else.31207
be_then.31207:
	store   $6, [$1 + 1]
	fcmp    $2, $zero
	store   $4, [$1 + 2]
	store   $3, [$1 + 3]
	bne     be_else.31208
be_then.31208:
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31208:
	finv    $2, $2
	store   $2, [$1 + 4]
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31207:
	load    [$11 + 9], $9
	load    [$11 + 9], $5
	fcmp    $2, $zero
	load    [$9 + 1], $9
	load    [$5 + 2], $5
	fmul    $7, $9, $7
	fmul    $8, $5, $8
	fadd    $7, $8, $7
	fmul    $7, $39, $7
	fsub    $6, $7, $6
	store   $6, [$1 + 1]
	load    [$10 + 0], $7
	load    [$11 + 9], $6
	fmul    $7, $5, $5
	load    [$6 + 0], $6
	load    [$10 + 2], $7
	fmul    $7, $6, $7
	fadd    $7, $5, $5
	fmul    $5, $39, $5
	fsub    $4, $5, $4
	store   $4, [$1 + 2]
	load    [$10 + 1], $5
	load    [$10 + 0], $4
	fmul    $5, $6, $5
	fmul    $4, $9, $4
	fadd    $5, $4, $4
	fmul    $4, $39, $4
	fsub    $3, $4, $3
	store   $3, [$1 + 3]
	bne     be_else.31209
be_then.31209:
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
be_else.31209:
	finv    $2, $2
	store   $2, [$1 + 4]
	load    [$sp - 1], $2
.count storer
	add     $13, $2, $tmp
	sub     $2, 1, $3
	store   $1, [$tmp + 0]
	load    [$sp - 2], $2
	b       iter_setup_dirvec_constants.2826
bge_else.31164:
	ret
.end iter_setup_dirvec_constants

######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
	cmp     $3, 0
	bl      bge_else.31210
bge_then.31210:
	load    [min_caml_objects + $3], $1
	load    [$2 + 0], $6
	load    [$1 + 5], $5
	load    [$1 + 10], $4
	load    [$5 + 0], $5
	fsub    $6, $5, $5
	store   $5, [$4 + 0]
	load    [$2 + 1], $6
	load    [$1 + 5], $5
	load    [$5 + 1], $5
	fsub    $6, $5, $5
	store   $5, [$4 + 1]
	load    [$2 + 2], $6
	load    [$1 + 5], $5
	load    [$5 + 2], $5
	fsub    $6, $5, $5
	store   $5, [$4 + 2]
	load    [$1 + 1], $5
	cmp     $5, 2
	bne     be_else.31211
be_then.31211:
	load    [$1 + 4], $1
	load    [$4 + 2], $6
	load    [$4 + 1], $7
	load    [$1 + 2], $5
	sub     $3, 1, $3
	fmul    $5, $6, $5
	load    [$1 + 1], $6
	load    [$1 + 0], $1
	fmul    $6, $7, $6
	load    [$4 + 0], $7
	fmul    $1, $7, $1
	fadd    $1, $6, $1
	fadd    $1, $5, $1
	store   $1, [$4 + 3]
	b       setup_startp_constants.2831
be_else.31211:
	cmp     $5, 2
	bg      ble_else.31212
ble_then.31212:
	sub     $3, 1, $3
	b       setup_startp_constants.2831
ble_else.31212:
	load    [$4 + 2], $10
	load    [$1 + 4], $6
	load    [$1 + 4], $7
	fmul    $10, $10, $11
	load    [$6 + 2], $6
	load    [$7 + 1], $7
	load    [$1 + 4], $8
	load    [$1 + 3], $9
	fmul    $11, $6, $6
	load    [$8 + 0], $8
	load    [$4 + 1], $11
	cmp     $9, 0
	fmul    $11, $11, $12
	fmul    $12, $7, $7
	load    [$4 + 0], $12
	fmul    $12, $12, $13
	fmul    $13, $8, $8
	fadd    $8, $7, $7
	fadd    $7, $6, $6
	bne     be_else.31213
be_then.31213:
	mov     $6, $1
	b       be_cont.31213
be_else.31213:
	load    [$1 + 9], $7
	fmul    $12, $11, $9
	load    [$1 + 9], $8
	load    [$7 + 2], $7
	load    [$1 + 9], $1
	load    [$8 + 1], $8
	fmul    $9, $7, $7
	load    [$1 + 0], $1
	fmul    $10, $12, $9
	fmul    $9, $8, $8
	fmul    $11, $10, $9
	fmul    $9, $1, $1
	fadd    $6, $1, $1
	fadd    $1, $8, $1
	fadd    $1, $7, $1
be_cont.31213:
	cmp     $5, 3
	sub     $3, 1, $3
	bne     be_else.31214
be_then.31214:
	fsub    $1, $36, $1
	store   $1, [$4 + 3]
	b       setup_startp_constants.2831
be_else.31214:
	store   $1, [$4 + 3]
	b       setup_startp_constants.2831
bge_else.31210:
	ret
.end setup_startp_constants

######################################################################
.begin check_all_inside
check_all_inside.2856:
	load    [$3 + $2], $1
	cmp     $1, -1
	bne     be_else.31215
be_then.31215:
	li      1, $1
	ret
be_else.31215:
	load    [min_caml_objects + $1], $1
	load    [$1 + 5], $7
	load    [$1 + 5], $8
	load    [$1 + 5], $9
	load    [$7 + 2], $7
	load    [$8 + 1], $8
	load    [$9 + 0], $9
	load    [$1 + 1], $10
	fsub    $6, $7, $7
	fsub    $5, $8, $8
	fsub    $4, $9, $9
	cmp     $10, 1
	bne     be_else.31216
be_then.31216:
	load    [$1 + 4], $10
	fabs    $9, $9
	load    [$10 + 0], $10
	fcmp    $10, $9
	bg      ble_else.31217
ble_then.31217:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31218
be_then.31218:
	li      1, $1
	b       be_cont.31216
be_else.31218:
	li      0, $1
	b       be_cont.31216
ble_else.31217:
	load    [$1 + 4], $9
	fabs    $8, $8
	load    [$9 + 1], $9
	fcmp    $9, $8
	bg      ble_else.31219
ble_then.31219:
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31220
be_then.31220:
	li      1, $1
	b       be_cont.31216
be_else.31220:
	li      0, $1
	b       be_cont.31216
ble_else.31219:
	load    [$1 + 4], $8
	fabs    $7, $7
	load    [$1 + 6], $1
	load    [$8 + 2], $8
	fcmp    $8, $7
	bg      be_cont.31216
ble_then.31221:
	cmp     $1, 0
	bne     be_else.31222
be_then.31222:
	li      1, $1
	b       be_cont.31216
be_else.31222:
	li      0, $1
	b       be_cont.31216
be_else.31216:
	cmp     $10, 2
	bne     be_else.31223
be_then.31223:
	load    [$1 + 4], $10
	load    [$1 + 6], $1
	load    [$10 + 0], $11
	fmul    $11, $9, $9
	load    [$10 + 1], $11
	fmul    $11, $8, $8
	fadd    $9, $8, $8
	load    [$10 + 2], $9
	fmul    $9, $7, $7
	fadd    $8, $7, $7
	fcmp    $zero, $7
	bg      ble_else.31224
ble_then.31224:
	cmp     $1, 0
	bne     be_else.31225
be_then.31225:
	li      1, $1
	b       be_cont.31223
be_else.31225:
	li      0, $1
	b       be_cont.31223
ble_else.31224:
	cmp     $1, 0
	bne     be_else.31226
be_then.31226:
	li      0, $1
	b       be_cont.31223
be_else.31226:
	li      1, $1
	b       be_cont.31223
be_else.31223:
	load    [$1 + 4], $12
	fmul    $9, $9, $11
	load    [$1 + 4], $13
	load    [$12 + 0], $12
	load    [$13 + 1], $13
	fmul    $11, $12, $11
	fmul    $8, $8, $12
	fmul    $12, $13, $12
	load    [$1 + 4], $13
	fadd    $11, $12, $11
	load    [$13 + 2], $13
	fmul    $7, $7, $12
	fmul    $12, $13, $12
	fadd    $11, $12, $11
	load    [$1 + 3], $12
	cmp     $12, 0
	bne     be_else.31227
be_then.31227:
	mov     $11, $7
	b       be_cont.31227
be_else.31227:
	load    [$1 + 9], $13
	fmul    $8, $7, $12
	load    [$13 + 0], $13
	fmul    $7, $9, $7
	fmul    $9, $8, $8
	fmul    $12, $13, $12
	load    [$1 + 9], $9
	load    [$9 + 2], $9
	fadd    $11, $12, $11
	load    [$1 + 9], $12
	fmul    $8, $9, $8
	load    [$12 + 1], $12
	fmul    $7, $12, $7
	fadd    $11, $7, $7
	fadd    $7, $8, $7
be_cont.31227:
	cmp     $10, 3
	bne     be_cont.31228
be_then.31228:
	fsub    $7, $36, $7
be_cont.31228:
	load    [$1 + 6], $1
	fcmp    $zero, $7
	bg      ble_else.31229
ble_then.31229:
	cmp     $1, 0
	bne     be_else.31230
be_then.31230:
	li      1, $1
	b       ble_cont.31229
be_else.31230:
	li      0, $1
	b       ble_cont.31229
ble_else.31229:
	cmp     $1, 0
	bne     be_else.31231
be_then.31231:
	li      0, $1
	b       be_cont.31231
be_else.31231:
	li      1, $1
be_cont.31231:
ble_cont.31229:
be_cont.31223:
be_cont.31216:
	cmp     $1, 0
	bne     be_else.31232
be_then.31232:
	add     $2, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31233
be_then.31233:
	li      1, $1
	ret
be_else.31233:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$7 + 2], $7
	load    [$8 + 1], $8
	load    [$9 + 0], $9
	load    [$2 + 1], $10
	fsub    $6, $7, $7
	fsub    $5, $8, $8
	fsub    $4, $9, $9
	cmp     $10, 1
	bne     be_else.31234
be_then.31234:
	load    [$2 + 4], $10
	fabs    $9, $9
	load    [$10 + 0], $10
	fcmp    $10, $9
	bg      ble_else.31235
ble_then.31235:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31236
be_then.31236:
	li      1, $2
	b       be_cont.31234
be_else.31236:
	li      0, $2
	b       be_cont.31234
ble_else.31235:
	load    [$2 + 4], $9
	fabs    $8, $8
	load    [$9 + 1], $9
	fcmp    $9, $8
	bg      ble_else.31237
ble_then.31237:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31238
be_then.31238:
	li      1, $2
	b       be_cont.31234
be_else.31238:
	li      0, $2
	b       be_cont.31234
ble_else.31237:
	load    [$2 + 4], $8
	fabs    $7, $7
	load    [$2 + 6], $2
	load    [$8 + 2], $8
	fcmp    $8, $7
	bg      be_cont.31234
ble_then.31239:
	cmp     $2, 0
	bne     be_else.31240
be_then.31240:
	li      1, $2
	b       be_cont.31234
be_else.31240:
	li      0, $2
	b       be_cont.31234
be_else.31234:
	cmp     $10, 2
	load    [$2 + 4], $10
	bne     be_else.31241
be_then.31241:
	load    [$10 + 2], $11
	load    [$2 + 6], $2
	fmul    $11, $7, $7
	load    [$10 + 1], $11
	load    [$10 + 0], $10
	fmul    $11, $8, $8
	fmul    $10, $9, $9
	fadd    $9, $8, $8
	fadd    $8, $7, $7
	fcmp    $zero, $7
	bg      ble_else.31242
ble_then.31242:
	cmp     $2, 0
	bne     be_else.31243
be_then.31243:
	li      1, $2
	b       be_cont.31241
be_else.31243:
	li      0, $2
	b       be_cont.31241
ble_else.31242:
	cmp     $2, 0
	bne     be_else.31244
be_then.31244:
	li      0, $2
	b       be_cont.31241
be_else.31244:
	li      1, $2
	b       be_cont.31241
be_else.31241:
	fmul    $7, $7, $14
	load    [$10 + 2], $10
	load    [$2 + 4], $11
	load    [$2 + 4], $12
	load    [$2 + 3], $13
	fmul    $14, $10, $10
	load    [$11 + 1], $11
	fmul    $8, $8, $14
	load    [$12 + 0], $12
	cmp     $13, 0
	fmul    $14, $11, $11
	fmul    $9, $9, $14
	fmul    $14, $12, $12
	fadd    $12, $11, $11
	fadd    $11, $10, $10
	bne     be_else.31245
be_then.31245:
	mov     $10, $7
	b       be_cont.31245
be_else.31245:
	fmul    $9, $8, $14
	load    [$2 + 9], $12
	fmul    $7, $9, $9
	load    [$2 + 9], $13
	load    [$12 + 1], $12
	fmul    $8, $7, $7
	load    [$2 + 9], $11
	fmul    $9, $12, $9
	load    [$13 + 0], $12
	load    [$11 + 2], $11
	fmul    $7, $12, $7
	fmul    $14, $11, $11
	fadd    $10, $7, $7
	fadd    $7, $9, $7
	fadd    $7, $11, $7
be_cont.31245:
	load    [$2 + 1], $8
	cmp     $8, 3
	bne     be_cont.31246
be_then.31246:
	fsub    $7, $36, $7
be_cont.31246:
	fcmp    $zero, $7
	load    [$2 + 6], $2
	bg      ble_else.31247
ble_then.31247:
	cmp     $2, 0
	bne     be_else.31248
be_then.31248:
	li      1, $2
	b       ble_cont.31247
be_else.31248:
	li      0, $2
	b       ble_cont.31247
ble_else.31247:
	cmp     $2, 0
	bne     be_else.31249
be_then.31249:
	li      0, $2
	b       be_cont.31249
be_else.31249:
	li      1, $2
be_cont.31249:
ble_cont.31247:
be_cont.31241:
be_cont.31234:
	cmp     $2, 0
	bne     be_else.31250
be_then.31250:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31251
be_then.31251:
	li      1, $1
	ret
be_else.31251:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$7 + 2], $7
	load    [$8 + 1], $8
	load    [$9 + 0], $9
	load    [$2 + 1], $10
	fsub    $6, $7, $7
	fsub    $5, $8, $8
	fsub    $4, $9, $9
	cmp     $10, 1
	bne     be_else.31252
be_then.31252:
	load    [$2 + 4], $10
	fabs    $9, $9
	load    [$10 + 0], $10
	fcmp    $10, $9
	bg      ble_else.31253
ble_then.31253:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31254
be_then.31254:
	li      1, $2
	b       be_cont.31252
be_else.31254:
	li      0, $2
	b       be_cont.31252
ble_else.31253:
	load    [$2 + 4], $9
	fabs    $8, $8
	load    [$9 + 1], $9
	fcmp    $9, $8
	bg      ble_else.31255
ble_then.31255:
	load    [$2 + 6], $2
	cmp     $2, 0
	bne     be_else.31256
be_then.31256:
	li      1, $2
	b       be_cont.31252
be_else.31256:
	li      0, $2
	b       be_cont.31252
ble_else.31255:
	load    [$2 + 4], $8
	fabs    $7, $7
	load    [$2 + 6], $2
	load    [$8 + 2], $8
	fcmp    $8, $7
	bg      be_cont.31252
ble_then.31257:
	cmp     $2, 0
	bne     be_else.31258
be_then.31258:
	li      1, $2
	b       be_cont.31252
be_else.31258:
	li      0, $2
	b       be_cont.31252
be_else.31252:
	cmp     $10, 2
	bne     be_else.31259
be_then.31259:
	load    [$2 + 4], $10
	load    [$2 + 6], $2
	load    [$10 + 2], $11
	fmul    $11, $7, $7
	load    [$10 + 1], $11
	load    [$10 + 0], $10
	fmul    $11, $8, $8
	fmul    $10, $9, $9
	fadd    $9, $8, $8
	fadd    $8, $7, $7
	fcmp    $zero, $7
	bg      ble_else.31260
ble_then.31260:
	cmp     $2, 0
	bne     be_else.31261
be_then.31261:
	li      1, $2
	b       be_cont.31259
be_else.31261:
	li      0, $2
	b       be_cont.31259
ble_else.31260:
	cmp     $2, 0
	bne     be_else.31262
be_then.31262:
	li      0, $2
	b       be_cont.31259
be_else.31262:
	li      1, $2
	b       be_cont.31259
be_else.31259:
	load    [$2 + 4], $12
	fmul    $7, $7, $13
	fmul    $8, $8, $14
	load    [$12 + 2], $12
	fmul    $9, $9, $15
	load    [$2 + 1], $10
	fmul    $13, $12, $12
	load    [$2 + 6], $11
	load    [$2 + 4], $13
	load    [$13 + 1], $13
	fmul    $14, $13, $13
	load    [$2 + 4], $14
	load    [$14 + 0], $14
	fmul    $15, $14, $14
	fadd    $14, $13, $13
	fadd    $13, $12, $12
	load    [$2 + 3], $13
	cmp     $13, 0
	bne     be_else.31263
be_then.31263:
	mov     $12, $2
	b       be_cont.31263
be_else.31263:
	load    [$2 + 9], $14
	fmul    $8, $7, $13
	load    [$14 + 0], $14
	fmul    $7, $9, $7
	fmul    $9, $8, $8
	fmul    $13, $14, $13
	fadd    $12, $13, $12
	load    [$2 + 9], $13
	load    [$2 + 9], $2
	load    [$13 + 1], $13
	load    [$2 + 2], $2
	fmul    $7, $13, $7
	fmul    $8, $2, $2
	fadd    $12, $7, $7
	fadd    $7, $2, $2
be_cont.31263:
	cmp     $10, 3
	bne     be_cont.31264
be_then.31264:
	fsub    $2, $36, $2
be_cont.31264:
	fcmp    $zero, $2
	bg      ble_else.31265
ble_then.31265:
	cmp     $11, 0
	bne     be_else.31266
be_then.31266:
	li      1, $2
	b       ble_cont.31265
be_else.31266:
	li      0, $2
	b       ble_cont.31265
ble_else.31265:
	cmp     $11, 0
	bne     be_else.31267
be_then.31267:
	li      0, $2
	b       be_cont.31267
be_else.31267:
	li      1, $2
be_cont.31267:
ble_cont.31265:
be_cont.31259:
be_cont.31252:
	cmp     $2, 0
	bne     be_else.31268
be_then.31268:
	add     $1, 1, $1
	load    [$3 + $1], $2
	cmp     $2, -1
	bne     be_else.31269
be_then.31269:
	li      1, $1
	ret
be_else.31269:
	load    [min_caml_objects + $2], $2
	load    [$2 + 5], $7
	load    [$2 + 5], $8
	load    [$2 + 5], $9
	load    [$7 + 2], $7
	load    [$8 + 1], $8
	load    [$9 + 0], $9
	load    [$2 + 1], $10
	fsub    $6, $7, $7
	fsub    $5, $8, $8
	fsub    $4, $9, $9
	cmp     $10, 1
	bne     be_else.31270
be_then.31270:
	load    [$2 + 4], $10
	fabs    $9, $9
	load    [$10 + 0], $10
	fcmp    $10, $9
	bg      ble_else.31271
ble_then.31271:
	li      0, $7
	b       ble_cont.31271
ble_else.31271:
	load    [$2 + 4], $9
	fabs    $8, $8
	load    [$9 + 1], $9
	fcmp    $9, $8
	bg      ble_else.31272
ble_then.31272:
	li      0, $7
	b       ble_cont.31272
ble_else.31272:
	load    [$2 + 4], $8
	fabs    $7, $7
	load    [$8 + 2], $8
	fcmp    $8, $7
	bg      ble_else.31273
ble_then.31273:
	li      0, $7
	b       ble_cont.31273
ble_else.31273:
	li      1, $7
ble_cont.31273:
ble_cont.31272:
ble_cont.31271:
	cmp     $7, 0
	load    [$2 + 6], $2
	bne     be_else.31274
be_then.31274:
	cmp     $2, 0
	bne     be_else.31275
be_then.31275:
	li      0, $1
	ret
be_else.31275:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31274:
	cmp     $2, 0
	bne     be_else.31276
be_then.31276:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31276:
	li      0, $1
	ret
be_else.31270:
	cmp     $10, 2
	bne     be_else.31277
be_then.31277:
	load    [$2 + 4], $10
	load    [$2 + 6], $2
	load    [$10 + 2], $11
	fmul    $11, $7, $7
	load    [$10 + 1], $11
	load    [$10 + 0], $10
	fmul    $11, $8, $8
	fmul    $10, $9, $9
	fadd    $9, $8, $8
	fadd    $8, $7, $7
	fcmp    $zero, $7
	bg      ble_else.31278
ble_then.31278:
	li      0, $7
	b       ble_cont.31278
ble_else.31278:
	li      1, $7
ble_cont.31278:
	cmp     $2, 0
	bne     be_else.31279
be_then.31279:
	cmp     $7, 0
	bne     be_else.31280
be_then.31280:
	li      0, $1
	ret
be_else.31280:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31279:
	cmp     $7, 0
	bne     be_else.31281
be_then.31281:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31281:
	li      0, $1
	ret
be_else.31277:
	load    [$2 + 4], $11
	fmul    $7, $7, $16
	load    [$2 + 4], $12
	load    [$11 + 2], $11
	load    [$2 + 4], $13
	load    [$12 + 1], $12
	fmul    $16, $11, $11
	load    [$13 + 0], $13
	fmul    $8, $8, $16
	load    [$2 + 3], $14
	load    [$2 + 6], $15
	cmp     $14, 0
	fmul    $16, $12, $12
	fmul    $9, $9, $16
	fmul    $16, $13, $13
	fadd    $13, $12, $12
	fadd    $12, $11, $11
	bne     be_else.31282
be_then.31282:
	mov     $11, $2
	b       be_cont.31282
be_else.31282:
	load    [$2 + 9], $12
	fmul    $9, $8, $13
	load    [$12 + 2], $12
	fmul    $7, $9, $9
	fmul    $13, $12, $12
	fmul    $8, $7, $7
	load    [$2 + 9], $13
	load    [$2 + 9], $2
	load    [$13 + 1], $13
	load    [$2 + 0], $2
	fmul    $9, $13, $9
	fmul    $7, $2, $2
	fadd    $11, $2, $2
	fadd    $2, $9, $2
	fadd    $2, $12, $2
be_cont.31282:
	cmp     $10, 3
	bne     be_cont.31283
be_then.31283:
	fsub    $2, $36, $2
be_cont.31283:
	fcmp    $zero, $2
	bg      ble_else.31284
ble_then.31284:
	li      0, $2
	b       ble_cont.31284
ble_else.31284:
	li      1, $2
ble_cont.31284:
	cmp     $15, 0
	bne     be_else.31285
be_then.31285:
	cmp     $2, 0
	bne     be_else.31286
be_then.31286:
	li      0, $1
	ret
be_else.31286:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31285:
	cmp     $2, 0
	bne     be_else.31287
be_then.31287:
	add     $1, 1, $2
	b       check_all_inside.2856
be_else.31287:
	li      0, $1
	ret
be_else.31268:
	li      0, $1
	ret
be_else.31250:
	li      0, $1
	ret
be_else.31232:
	li      0, $1
	ret
.end check_all_inside

######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
	load    [$3 + $2], $17
	cmp     $17, -1
	bne     be_else.31288
be_then.31288:
	li      0, $1
	ret
be_else.31288:
	load    [min_caml_objects + $17], $18
	load    [min_caml_intersection_point + 2], $24
	load    [min_caml_light_dirvec + 1], $20
	load    [$18 + 5], $21
	load    [$18 + 5], $22
	load    [$18 + 5], $23
	load    [$21 + 2], $21
	load    [$22 + 1], $22
	load    [$18 + 1], $19
	fsub    $24, $21, $21
	load    [$23 + 0], $23
	load    [min_caml_intersection_point + 1], $24
	load    [$20 + $17], $20
	cmp     $19, 1
	fsub    $24, $22, $22
	load    [min_caml_intersection_point + 0], $24
	fsub    $24, $23, $23
	bne     be_else.31289
be_then.31289:
	load    [$20 + 0], $25
	load    [$20 + 1], $24
	load    [min_caml_light_dirvec + 0], $19
	fsub    $25, $23, $25
	load    [$18 + 4], $26
	load    [$26 + 1], $26
	fmul    $25, $24, $24
	load    [$19 + 1], $25
	fmul    $24, $25, $25
	fadd    $25, $22, $25
	fabs    $25, $25
	fcmp    $26, $25
	bg      ble_else.31290
ble_then.31290:
	li      0, $25
	b       ble_cont.31290
ble_else.31290:
	load    [$19 + 2], $26
	load    [$18 + 4], $25
	fmul    $24, $26, $26
	load    [$25 + 2], $25
	fadd    $26, $21, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31291
ble_then.31291:
	li      0, $25
	b       ble_cont.31291
ble_else.31291:
	load    [$20 + 1], $25
	fcmp    $25, $zero
	bne     be_else.31292
be_then.31292:
	li      0, $25
	b       be_cont.31292
be_else.31292:
	li      1, $25
be_cont.31292:
ble_cont.31291:
ble_cont.31290:
	cmp     $25, 0
	bne     be_else.31293
be_then.31293:
	load    [$20 + 2], $25
	load    [$20 + 3], $24
	load    [$18 + 4], $26
	fsub    $25, $22, $25
	load    [$26 + 0], $26
	fmul    $25, $24, $24
	load    [$19 + 0], $25
	fmul    $24, $25, $25
	fadd    $25, $23, $25
	fabs    $25, $25
	fcmp    $26, $25
	bg      ble_else.31294
ble_then.31294:
	li      0, $25
	b       ble_cont.31294
ble_else.31294:
	load    [$19 + 2], $26
	load    [$18 + 4], $25
	fmul    $24, $26, $26
	load    [$25 + 2], $25
	fadd    $26, $21, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31295
ble_then.31295:
	li      0, $25
	b       ble_cont.31295
ble_else.31295:
	load    [$20 + 3], $25
	fcmp    $25, $zero
	bne     be_else.31296
be_then.31296:
	li      0, $25
	b       be_cont.31296
be_else.31296:
	li      1, $25
be_cont.31296:
ble_cont.31295:
ble_cont.31294:
	cmp     $25, 0
	bne     be_else.31297
be_then.31297:
	load    [$20 + 4], $25
	load    [$20 + 5], $24
	fsub    $25, $21, $21
	fmul    $21, $24, $21
	load    [$19 + 0], $24
	fmul    $21, $24, $24
	fadd    $24, $23, $23
	load    [$18 + 4], $24
	load    [$24 + 0], $24
	fabs    $23, $23
	fcmp    $24, $23
	bg      ble_else.31298
ble_then.31298:
	li      0, $18
	b       be_cont.31289
ble_else.31298:
	load    [$19 + 1], $19
	load    [$18 + 4], $18
	fmul    $21, $19, $19
	load    [$18 + 1], $18
	fadd    $19, $22, $19
	fabs    $19, $19
	fcmp    $18, $19
	bg      ble_else.31299
ble_then.31299:
	li      0, $18
	b       be_cont.31289
ble_else.31299:
	load    [$20 + 5], $18
	fcmp    $18, $zero
	bne     be_else.31300
be_then.31300:
	li      0, $18
	b       be_cont.31289
be_else.31300:
.count move_float
	mov     $21, $42
	li      3, $18
	b       be_cont.31289
be_else.31297:
.count move_float
	mov     $24, $42
	li      2, $18
	b       be_cont.31289
be_else.31293:
.count move_float
	mov     $24, $42
	li      1, $18
	b       be_cont.31289
be_else.31289:
	cmp     $19, 2
	bne     be_else.31301
be_then.31301:
	load    [$20 + 0], $18
	fcmp    $zero, $18
	bg      ble_else.31302
ble_then.31302:
	li      0, $18
	b       be_cont.31301
ble_else.31302:
	load    [$20 + 2], $19
	load    [$20 + 3], $18
	load    [$20 + 1], $20
	fmul    $19, $22, $19
	fmul    $18, $21, $18
	fmul    $20, $23, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31301
be_else.31301:
	load    [$20 + 0], $24
	fcmp    $24, $zero
	bne     be_else.31303
be_then.31303:
	li      0, $18
	b       be_cont.31303
be_else.31303:
	load    [$18 + 4], $26
	fmul    $23, $23, $25
	load    [$18 + 4], $27
	load    [$26 + 0], $26
	load    [$27 + 1], $27
	fmul    $25, $26, $25
	fmul    $22, $22, $26
	fmul    $26, $27, $26
	load    [$18 + 4], $27
	fadd    $25, $26, $25
	load    [$27 + 2], $27
	fmul    $21, $21, $26
	fmul    $26, $27, $26
	fadd    $25, $26, $25
	load    [$18 + 3], $26
	cmp     $26, 0
	be      bne_cont.31304
bne_then.31304:
	load    [$18 + 9], $27
	fmul    $22, $21, $26
	load    [$27 + 0], $27
	fmul    $26, $27, $26
	load    [$18 + 9], $27
	fadd    $25, $26, $25
	load    [$27 + 1], $27
	fmul    $21, $23, $26
	fmul    $26, $27, $26
	load    [$18 + 9], $27
	fadd    $25, $26, $25
	load    [$27 + 2], $27
	fmul    $23, $22, $26
	fmul    $26, $27, $26
	fadd    $25, $26, $25
bne_cont.31304:
	cmp     $19, 3
	bne     be_else.31305
be_then.31305:
	fsub    $25, $36, $19
	b       be_cont.31305
be_else.31305:
	mov     $25, $19
be_cont.31305:
	fmul    $24, $19, $19
	load    [$20 + 3], $24
	fmul    $24, $21, $21
	load    [$20 + 2], $24
	fmul    $24, $22, $22
	load    [$20 + 1], $24
	fmul    $24, $23, $23
	fadd    $23, $22, $22
	fadd    $22, $21, $21
	fmul    $21, $21, $22
	fsub    $22, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31306
ble_then.31306:
	li      0, $18
	b       ble_cont.31306
ble_else.31306:
	load    [$18 + 6], $18
	fsqrt   $19, $19
	cmp     $18, 0
	load    [$20 + 4], $18
	bne     be_else.31307
be_then.31307:
	fsub    $21, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31307
be_else.31307:
	fadd    $21, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31307:
ble_cont.31306:
be_cont.31303:
be_cont.31301:
be_cont.31289:
	cmp     $18, 0
	bne     be_else.31308
be_then.31308:
	li      0, $18
	b       be_cont.31308
be_else.31308:
.count load_float
	load    [f.27181], $18
	fcmp    $18, $42
	bg      ble_else.31309
ble_then.31309:
	li      0, $18
	b       ble_cont.31309
ble_else.31309:
	li      1, $18
ble_cont.31309:
be_cont.31308:
	cmp     $18, 0
	bne     be_else.31310
be_then.31310:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31311
be_then.31311:
	li      0, $1
	ret
be_else.31311:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
be_else.31310:
	load    [$3 + 0], $17
	cmp     $17, -1
	bne     be_else.31312
be_then.31312:
	li      1, $1
	ret
be_else.31312:
.count load_float
	load    [f.27182], $23
	load    [min_caml_intersection_point + 2], $22
	load    [min_caml_objects + $17], $17
	fadd    $42, $23, $23
	load    [$17 + 5], $18
	load    [$17 + 5], $19
	load    [$17 + 5], $20
	fmul    $57, $23, $24
	load    [$17 + 1], $21
	load    [$18 + 2], $18
	load    [$19 + 1], $19
	load    [$20 + 0], $20
	fadd    $24, $22, $6
	cmp     $21, 1
	fmul    $56, $23, $24
	load    [min_caml_intersection_point + 1], $22
	fmul    $55, $23, $23
	fsub    $6, $18, $18
	fadd    $24, $22, $5
	load    [min_caml_intersection_point + 0], $22
	fadd    $23, $22, $4
	fsub    $5, $19, $19
	fsub    $4, $20, $20
	bne     be_else.31313
be_then.31313:
	load    [$17 + 4], $21
	fabs    $20, $20
	load    [$21 + 0], $21
	fcmp    $21, $20
	bg      ble_else.31314
ble_then.31314:
	load    [$17 + 6], $17
	cmp     $17, 0
	bne     be_else.31315
be_then.31315:
	li      1, $17
	b       be_cont.31313
be_else.31315:
	li      0, $17
	b       be_cont.31313
ble_else.31314:
	load    [$17 + 4], $20
	fabs    $19, $19
	load    [$20 + 1], $20
	fcmp    $20, $19
	bg      ble_else.31316
ble_then.31316:
	load    [$17 + 6], $17
	cmp     $17, 0
	bne     be_else.31317
be_then.31317:
	li      1, $17
	b       be_cont.31313
be_else.31317:
	li      0, $17
	b       be_cont.31313
ble_else.31316:
	load    [$17 + 4], $19
	fabs    $18, $18
	load    [$17 + 6], $17
	load    [$19 + 2], $19
	fcmp    $19, $18
	bg      be_cont.31313
ble_then.31318:
	cmp     $17, 0
	bne     be_else.31319
be_then.31319:
	li      1, $17
	b       be_cont.31313
be_else.31319:
	li      0, $17
	b       be_cont.31313
be_else.31313:
	cmp     $21, 2
	bne     be_else.31320
be_then.31320:
	load    [$17 + 4], $21
	load    [$17 + 6], $17
	load    [$21 + 2], $22
	fmul    $22, $18, $18
	load    [$21 + 1], $22
	load    [$21 + 0], $21
	fmul    $22, $19, $19
	fmul    $21, $20, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	fcmp    $zero, $18
	bg      ble_else.31321
ble_then.31321:
	cmp     $17, 0
	bne     be_else.31322
be_then.31322:
	li      1, $17
	b       be_cont.31320
be_else.31322:
	li      0, $17
	b       be_cont.31320
ble_else.31321:
	cmp     $17, 0
	bne     be_else.31323
be_then.31323:
	li      0, $17
	b       be_cont.31320
be_else.31323:
	li      1, $17
	b       be_cont.31320
be_else.31320:
	load    [$17 + 4], $22
	fmul    $18, $18, $23
	fmul    $19, $19, $24
	load    [$22 + 2], $22
	fmul    $20, $20, $25
	fmul    $23, $22, $22
	load    [$17 + 4], $23
	load    [$23 + 1], $23
	fmul    $24, $23, $23
	load    [$17 + 4], $24
	load    [$24 + 0], $24
	fmul    $25, $24, $24
	fadd    $24, $23, $23
	fadd    $23, $22, $22
	load    [$17 + 3], $23
	cmp     $23, 0
	bne     be_else.31324
be_then.31324:
	mov     $22, $18
	b       be_cont.31324
be_else.31324:
	load    [$17 + 9], $23
	fmul    $20, $19, $24
	load    [$23 + 2], $23
	fmul    $18, $20, $20
	fmul    $24, $23, $23
	fmul    $19, $18, $18
	load    [$17 + 9], $24
	load    [$24 + 1], $24
	fmul    $20, $24, $20
	load    [$17 + 9], $24
	load    [$24 + 0], $24
	fmul    $18, $24, $18
	fadd    $22, $18, $18
	fadd    $18, $20, $18
	fadd    $18, $23, $18
be_cont.31324:
	cmp     $21, 3
	bne     be_cont.31325
be_then.31325:
	fsub    $18, $36, $18
be_cont.31325:
	fcmp    $zero, $18
	load    [$17 + 6], $17
	bg      ble_else.31326
ble_then.31326:
	cmp     $17, 0
	bne     be_else.31327
be_then.31327:
	li      1, $17
	b       ble_cont.31326
be_else.31327:
	li      0, $17
	b       ble_cont.31326
ble_else.31326:
	cmp     $17, 0
	bne     be_else.31328
be_then.31328:
	li      0, $17
	b       be_cont.31328
be_else.31328:
	li      1, $17
be_cont.31328:
ble_cont.31326:
be_cont.31320:
be_cont.31313:
	cmp     $17, 0
	bne     be_else.31329
be_then.31329:
.count stack_move
	sub     $sp, 2, $sp
	store   $3, [$sp + 0]
	store   $2, [$sp + 1]
	li      1, $2
	call    check_all_inside.2856
.count stack_move
	add     $sp, 2, $sp
	cmp     $1, 0
	bne     be_else.31330
be_then.31330:
	load    [$sp - 1], $1
	load    [$sp - 2], $3
	add     $1, 1, $2
	b       shadow_check_and_group.2862
be_else.31330:
	li      1, $1
	ret
be_else.31329:
	add     $2, 1, $2
	b       shadow_check_and_group.2862
.end shadow_check_and_group

######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
	load    [$3 + $2], $28
	cmp     $28, -1
	bne     be_else.31331
be_then.31331:
	li      0, $1
	ret
be_else.31331:
.count stack_move
	sub     $sp, 2, $sp
	store   $3, [$sp + 0]
	store   $2, [$sp + 1]
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31332
be_then.31332:
	load    [$sp + 1], $28
	load    [$sp + 0], $29
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31333
be_then.31333:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31333:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31334
be_then.31334:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31335
be_then.31335:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31335:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31336
be_then.31336:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31337
be_then.31337:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31337:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31338
be_then.31338:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31339
be_then.31339:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31339:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31340
be_then.31340:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31341
be_then.31341:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31341:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31342
be_then.31342:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31343
be_then.31343:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31343:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31344
be_then.31344:
	add     $28, 1, $28
	load    [$29 + $28], $30
	cmp     $30, -1
	bne     be_else.31345
be_then.31345:
.count stack_move
	add     $sp, 2, $sp
	li      0, $1
	ret
be_else.31345:
	load    [min_caml_and_net + $30], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count stack_move
	add     $sp, 2, $sp
	cmp     $1, 0
	bne     be_else.31346
be_then.31346:
	add     $28, 1, $2
.count move_args
	mov     $29, $3
	b       shadow_check_one_or_group.2865
be_else.31346:
	li      1, $1
	ret
be_else.31344:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31342:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31340:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31338:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31336:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31334:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
be_else.31332:
.count stack_move
	add     $sp, 2, $sp
	li      1, $1
	ret
.end shadow_check_one_or_group

######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
	load    [$3 + $2], $28
	load    [$28 + 0], $29
	cmp     $29, -1
	bne     be_else.31347
be_then.31347:
	li      0, $1
	ret
be_else.31347:
.count stack_move
	sub     $sp, 7, $sp
	cmp     $29, 99
	store   $28, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	bne     be_else.31348
be_then.31348:
	li      1, $13
	b       be_cont.31348
be_else.31348:
	load    [min_caml_objects + $29], $30
	load    [min_caml_intersection_point + 0], $31
	load    [$30 + 5], $32
	load    [$30 + 5], $33
	load    [$30 + 5], $34
	load    [$32 + 0], $32
	load    [$33 + 1], $33
	load    [$34 + 2], $34
	fsub    $31, $32, $31
	load    [min_caml_intersection_point + 1], $32
	fsub    $32, $33, $32
	load    [min_caml_intersection_point + 2], $33
	fsub    $33, $34, $33
	load    [min_caml_light_dirvec + 1], $34
	load    [$34 + $29], $29
	load    [$30 + 1], $34
	cmp     $34, 1
	bne     be_else.31349
be_then.31349:
	load    [$29 + 0], $13
	load    [$29 + 1], $35
	load    [min_caml_light_dirvec + 0], $34
	fsub    $13, $31, $13
	load    [$30 + 4], $14
	load    [$14 + 1], $14
	fmul    $13, $35, $35
	load    [$34 + 1], $13
	fmul    $35, $13, $13
	fadd    $13, $32, $13
	fabs    $13, $13
	fcmp    $14, $13
	bg      ble_else.31350
ble_then.31350:
	li      0, $13
	b       ble_cont.31350
ble_else.31350:
	load    [$34 + 2], $14
	load    [$30 + 4], $13
	fmul    $35, $14, $14
	load    [$13 + 2], $13
	fadd    $14, $33, $14
	fabs    $14, $14
	fcmp    $13, $14
	bg      ble_else.31351
ble_then.31351:
	li      0, $13
	b       ble_cont.31351
ble_else.31351:
	load    [$29 + 1], $13
	fcmp    $13, $zero
	bne     be_else.31352
be_then.31352:
	li      0, $13
	b       be_cont.31352
be_else.31352:
	li      1, $13
be_cont.31352:
ble_cont.31351:
ble_cont.31350:
	cmp     $13, 0
	bne     be_else.31353
be_then.31353:
	load    [$29 + 2], $13
	load    [$29 + 3], $35
	load    [$30 + 4], $14
	fsub    $13, $32, $13
	load    [$14 + 0], $14
	fmul    $13, $35, $35
	load    [$34 + 0], $13
	fmul    $35, $13, $13
	fadd    $13, $31, $13
	fabs    $13, $13
	fcmp    $14, $13
	bg      ble_else.31354
ble_then.31354:
	li      0, $13
	b       ble_cont.31354
ble_else.31354:
	load    [$34 + 2], $14
	load    [$30 + 4], $13
	fmul    $35, $14, $14
	load    [$13 + 2], $13
	fadd    $14, $33, $14
	fabs    $14, $14
	fcmp    $13, $14
	bg      ble_else.31355
ble_then.31355:
	li      0, $13
	b       ble_cont.31355
ble_else.31355:
	load    [$29 + 3], $13
	fcmp    $13, $zero
	bne     be_else.31356
be_then.31356:
	li      0, $13
	b       be_cont.31356
be_else.31356:
	li      1, $13
be_cont.31356:
ble_cont.31355:
ble_cont.31354:
	cmp     $13, 0
	bne     be_else.31357
be_then.31357:
	load    [$29 + 4], $13
	load    [$29 + 5], $35
	fsub    $13, $33, $33
	fmul    $33, $35, $33
	load    [$34 + 0], $35
	fmul    $33, $35, $35
	fadd    $35, $31, $31
	load    [$30 + 4], $35
	load    [$35 + 0], $35
	fabs    $31, $31
	fcmp    $35, $31
	bg      ble_else.31358
ble_then.31358:
	li      0, $29
	b       be_cont.31349
ble_else.31358:
	load    [$34 + 1], $31
	load    [$30 + 4], $30
	fmul    $33, $31, $31
	load    [$30 + 1], $30
	fadd    $31, $32, $31
	fabs    $31, $31
	fcmp    $30, $31
	bg      ble_else.31359
ble_then.31359:
	li      0, $29
	b       be_cont.31349
ble_else.31359:
	load    [$29 + 5], $29
	fcmp    $29, $zero
	bne     be_else.31360
be_then.31360:
	li      0, $29
	b       be_cont.31349
be_else.31360:
.count move_float
	mov     $33, $42
	li      3, $29
	b       be_cont.31349
be_else.31357:
.count move_float
	mov     $35, $42
	li      2, $29
	b       be_cont.31349
be_else.31353:
.count move_float
	mov     $35, $42
	li      1, $29
	b       be_cont.31349
be_else.31349:
	cmp     $34, 2
	bne     be_else.31361
be_then.31361:
	load    [$29 + 0], $30
	fcmp    $zero, $30
	bg      ble_else.31362
ble_then.31362:
	li      0, $29
	b       be_cont.31361
ble_else.31362:
	load    [$29 + 3], $30
	fmul    $30, $33, $30
	load    [$29 + 2], $33
	load    [$29 + 1], $29
	fmul    $33, $32, $32
	fmul    $29, $31, $29
	fadd    $29, $32, $29
	fadd    $29, $30, $29
.count move_float
	mov     $29, $42
	li      1, $29
	b       be_cont.31361
be_else.31361:
	load    [$29 + 0], $35
	fcmp    $35, $zero
	bne     be_else.31363
be_then.31363:
	li      0, $29
	b       be_cont.31363
be_else.31363:
	load    [$30 + 4], $14
	fmul    $31, $31, $13
	load    [$30 + 4], $15
	load    [$14 + 0], $14
	load    [$15 + 1], $15
	fmul    $13, $14, $13
	fmul    $32, $32, $14
	fmul    $14, $15, $14
	load    [$30 + 4], $15
	fadd    $13, $14, $13
	load    [$15 + 2], $15
	fmul    $33, $33, $14
	fmul    $14, $15, $14
	fadd    $13, $14, $13
	load    [$30 + 3], $14
	cmp     $14, 0
	be      bne_cont.31364
bne_then.31364:
	load    [$30 + 9], $15
	fmul    $32, $33, $14
	load    [$15 + 0], $15
	fmul    $14, $15, $14
	load    [$30 + 9], $15
	fadd    $13, $14, $13
	load    [$15 + 1], $15
	fmul    $33, $31, $14
	fmul    $14, $15, $14
	load    [$30 + 9], $15
	fadd    $13, $14, $13
	load    [$15 + 2], $15
	fmul    $31, $32, $14
	fmul    $14, $15, $14
	fadd    $13, $14, $13
bne_cont.31364:
	cmp     $34, 3
	bne     be_else.31365
be_then.31365:
	fsub    $13, $36, $34
	b       be_cont.31365
be_else.31365:
	mov     $13, $34
be_cont.31365:
	fmul    $35, $34, $34
	load    [$29 + 3], $35
	fmul    $35, $33, $33
	load    [$29 + 2], $35
	fmul    $35, $32, $32
	load    [$29 + 1], $35
	fmul    $35, $31, $31
	fadd    $31, $32, $31
	fadd    $31, $33, $31
	fmul    $31, $31, $32
	fsub    $32, $34, $32
	fcmp    $32, $zero
	bg      ble_else.31366
ble_then.31366:
	li      0, $29
	b       ble_cont.31366
ble_else.31366:
	load    [$30 + 6], $30
	load    [$29 + 4], $29
	cmp     $30, 0
	fsqrt   $32, $30
	bne     be_else.31367
be_then.31367:
	fsub    $31, $30, $30
	fmul    $30, $29, $29
.count move_float
	mov     $29, $42
	li      1, $29
	b       be_cont.31367
be_else.31367:
	fadd    $31, $30, $30
	fmul    $30, $29, $29
.count move_float
	mov     $29, $42
	li      1, $29
be_cont.31367:
ble_cont.31366:
be_cont.31363:
be_cont.31361:
be_cont.31349:
	cmp     $29, 0
	bne     be_else.31368
be_then.31368:
	li      0, $13
	b       be_cont.31368
be_else.31368:
.count load_float
	load    [f.27183], $29
	fcmp    $29, $42
	bg      ble_else.31369
ble_then.31369:
	li      0, $13
	b       ble_cont.31369
ble_else.31369:
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31370
be_then.31370:
	li      0, $13
	b       be_cont.31370
be_else.31370:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31371
be_then.31371:
	li      2, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $13
	cmp     $13, 0
	bne     be_else.31372
be_then.31372:
	li      0, $13
	b       be_cont.31371
be_else.31372:
	li      1, $13
	b       be_cont.31371
be_else.31371:
	li      1, $13
be_cont.31371:
be_cont.31370:
ble_cont.31369:
be_cont.31368:
be_cont.31348:
	cmp     $13, 0
	bne     be_else.31373
be_then.31373:
	load    [$sp + 2], $13
	load    [$sp + 1], $14
	add     $13, 1, $13
	load    [$14 + $13], $15
	load    [$15 + 0], $2
	cmp     $2, -1
	bne     be_else.31374
be_then.31374:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31374:
	store   $15, [$sp + 3]
	cmp     $2, 99
	store   $13, [$sp + 4]
	bne     be_else.31375
be_then.31375:
	li      1, $28
	b       be_cont.31375
be_else.31375:
	call    solver_fast.2796
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31376
be_then.31376:
	li      0, $28
	b       be_cont.31376
be_else.31376:
.count load_float
	load    [f.27183], $28
	fcmp    $28, $42
	bg      ble_else.31377
ble_then.31377:
	li      0, $28
	b       ble_cont.31377
ble_else.31377:
	load    [$15 + 1], $28
	cmp     $28, -1
	bne     be_else.31378
be_then.31378:
	li      0, $28
	b       be_cont.31378
be_else.31378:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31379
be_then.31379:
	load    [$sp + 3], $28
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31380
be_then.31380:
	li      0, $28
	b       be_cont.31379
be_else.31380:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31381
be_then.31381:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31382
be_then.31382:
	li      0, $28
	b       be_cont.31379
be_else.31382:
	li      1, $28
	b       be_cont.31379
be_else.31381:
	li      1, $28
	b       be_cont.31379
be_else.31379:
	li      1, $28
be_cont.31379:
be_cont.31378:
ble_cont.31377:
be_cont.31376:
be_cont.31375:
	cmp     $28, 0
	bne     be_else.31383
be_then.31383:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 3], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31383:
	load    [$sp + 3], $28
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31384
be_then.31384:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 3], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31384:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31385
be_then.31385:
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31386
be_then.31386:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 3], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31386:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31387
be_then.31387:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31388
be_then.31388:
	load    [$sp - 3], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31388:
	li      1, $1
	ret
be_else.31387:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31385:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31373:
	load    [$sp + 0], $28
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31389
be_then.31389:
	li      0, $13
	b       be_cont.31389
be_else.31389:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31390
be_then.31390:
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31391
be_then.31391:
	li      0, $13
	b       be_cont.31390
be_else.31391:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31392
be_then.31392:
	load    [$28 + 3], $29
	cmp     $29, -1
	bne     be_else.31393
be_then.31393:
	li      0, $13
	b       be_cont.31390
be_else.31393:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31394
be_then.31394:
	load    [$28 + 4], $29
	cmp     $29, -1
	bne     be_else.31395
be_then.31395:
	li      0, $13
	b       be_cont.31390
be_else.31395:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31396
be_then.31396:
	load    [$28 + 5], $29
	cmp     $29, -1
	bne     be_else.31397
be_then.31397:
	li      0, $13
	b       be_cont.31390
be_else.31397:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31398
be_then.31398:
	load    [$28 + 6], $29
	cmp     $29, -1
	bne     be_else.31399
be_then.31399:
	li      0, $13
	b       be_cont.31390
be_else.31399:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31400
be_then.31400:
	load    [$28 + 7], $29
	cmp     $29, -1
	bne     be_else.31401
be_then.31401:
	li      0, $13
	b       be_cont.31390
be_else.31401:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31402
be_then.31402:
	li      8, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $13
	b       be_cont.31390
be_else.31402:
	li      1, $13
	b       be_cont.31390
be_else.31400:
	li      1, $13
	b       be_cont.31390
be_else.31398:
	li      1, $13
	b       be_cont.31390
be_else.31396:
	li      1, $13
	b       be_cont.31390
be_else.31394:
	li      1, $13
	b       be_cont.31390
be_else.31392:
	li      1, $13
	b       be_cont.31390
be_else.31390:
	li      1, $13
be_cont.31390:
be_cont.31389:
	cmp     $13, 0
	bne     be_else.31403
be_then.31403:
	load    [$sp + 2], $13
	load    [$sp + 1], $14
	add     $13, 1, $13
	load    [$14 + $13], $15
	load    [$15 + 0], $2
	cmp     $2, -1
	bne     be_else.31404
be_then.31404:
.count stack_move
	add     $sp, 7, $sp
	li      0, $1
	ret
be_else.31404:
	store   $15, [$sp + 5]
	cmp     $2, 99
	store   $13, [$sp + 6]
	bne     be_else.31405
be_then.31405:
	li      1, $28
	b       be_cont.31405
be_else.31405:
	call    solver_fast.2796
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31406
be_then.31406:
	li      0, $28
	b       be_cont.31406
be_else.31406:
.count load_float
	load    [f.27183], $28
	fcmp    $28, $42
	bg      ble_else.31407
ble_then.31407:
	li      0, $28
	b       ble_cont.31407
ble_else.31407:
	load    [$15 + 1], $28
	cmp     $28, -1
	bne     be_else.31408
be_then.31408:
	li      0, $28
	b       be_cont.31408
be_else.31408:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31409
be_then.31409:
	load    [$sp + 5], $28
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31410
be_then.31410:
	li      0, $28
	b       be_cont.31409
be_else.31410:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31411
be_then.31411:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31412
be_then.31412:
	li      0, $28
	b       be_cont.31409
be_else.31412:
	li      1, $28
	b       be_cont.31409
be_else.31411:
	li      1, $28
	b       be_cont.31409
be_else.31409:
	li      1, $28
be_cont.31409:
be_cont.31408:
ble_cont.31407:
be_cont.31406:
be_cont.31405:
	cmp     $28, 0
	bne     be_else.31413
be_then.31413:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 1], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31413:
	load    [$sp + 5], $28
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31414
be_then.31414:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 1], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31414:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31415
be_then.31415:
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31416
be_then.31416:
.count stack_move
	add     $sp, 7, $sp
	load    [$sp - 1], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31416:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31417
be_then.31417:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count stack_move
	add     $sp, 7, $sp
	cmp     $1, 0
	bne     be_else.31418
be_then.31418:
	load    [$sp - 1], $1
	load    [$sp - 6], $3
	add     $1, 1, $2
	b       shadow_check_one_or_matrix.2868
be_else.31418:
	li      1, $1
	ret
be_else.31417:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31415:
.count stack_move
	add     $sp, 7, $sp
	li      1, $1
	ret
be_else.31403:
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
	bne     be_else.31419
be_then.31419:
	ret
be_else.31419:
	load    [min_caml_objects + $17], $18
	load    [min_caml_startp + 2], $23
	load    [$18 + 5], $20
	load    [$18 + 5], $21
	load    [$18 + 5], $22
	load    [$20 + 2], $20
	load    [$21 + 1], $21
	load    [$18 + 1], $19
	fsub    $23, $20, $20
	load    [$22 + 0], $22
	load    [min_caml_startp + 1], $23
	cmp     $19, 1
	fsub    $23, $21, $21
	load    [min_caml_startp + 0], $23
	fsub    $23, $22, $22
	bne     be_else.31420
be_then.31420:
	load    [$4 + 0], $19
	fcmp    $19, $zero
	bne     be_else.31421
be_then.31421:
	li      0, $19
	b       be_cont.31421
be_else.31421:
	load    [$18 + 4], $23
	load    [$18 + 6], $24
	fcmp    $zero, $19
	bg      ble_else.31422
ble_then.31422:
	li      0, $25
	b       ble_cont.31422
ble_else.31422:
	li      1, $25
ble_cont.31422:
	cmp     $24, 0
	bne     be_else.31423
be_then.31423:
	mov     $25, $24
	b       be_cont.31423
be_else.31423:
	cmp     $25, 0
	bne     be_else.31424
be_then.31424:
	li      1, $24
	b       be_cont.31424
be_else.31424:
	li      0, $24
be_cont.31424:
be_cont.31423:
	load    [$23 + 0], $25
	cmp     $24, 0
	bne     be_else.31425
be_then.31425:
	fneg    $25, $24
	b       be_cont.31425
be_else.31425:
	mov     $25, $24
be_cont.31425:
	finv    $19, $19
	fsub    $24, $22, $24
	load    [$4 + 1], $25
	fmul    $24, $19, $19
	load    [$23 + 1], $24
	fmul    $19, $25, $25
	fadd    $25, $21, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31426
ble_then.31426:
	li      0, $19
	b       ble_cont.31426
ble_else.31426:
	load    [$4 + 2], $24
	load    [$23 + 2], $23
	fmul    $19, $24, $24
	fadd    $24, $20, $24
	fabs    $24, $24
	fcmp    $23, $24
	bg      ble_else.31427
ble_then.31427:
	li      0, $19
	b       ble_cont.31427
ble_else.31427:
.count move_float
	mov     $19, $42
	li      1, $19
ble_cont.31427:
ble_cont.31426:
be_cont.31421:
	cmp     $19, 0
	bne     be_else.31428
be_then.31428:
	load    [$4 + 1], $19
	fcmp    $19, $zero
	bne     be_else.31429
be_then.31429:
	li      0, $19
	b       be_cont.31429
be_else.31429:
	load    [$18 + 4], $23
	load    [$18 + 6], $24
	fcmp    $zero, $19
	bg      ble_else.31430
ble_then.31430:
	li      0, $25
	b       ble_cont.31430
ble_else.31430:
	li      1, $25
ble_cont.31430:
	cmp     $24, 0
	bne     be_else.31431
be_then.31431:
	mov     $25, $24
	b       be_cont.31431
be_else.31431:
	cmp     $25, 0
	bne     be_else.31432
be_then.31432:
	li      1, $24
	b       be_cont.31432
be_else.31432:
	li      0, $24
be_cont.31432:
be_cont.31431:
	load    [$23 + 1], $25
	cmp     $24, 0
	bne     be_else.31433
be_then.31433:
	fneg    $25, $24
	b       be_cont.31433
be_else.31433:
	mov     $25, $24
be_cont.31433:
	finv    $19, $19
	fsub    $24, $21, $24
	load    [$4 + 2], $25
	fmul    $24, $19, $19
	load    [$23 + 2], $24
	fmul    $19, $25, $25
	fadd    $25, $20, $25
	fabs    $25, $25
	fcmp    $24, $25
	bg      ble_else.31434
ble_then.31434:
	li      0, $19
	b       ble_cont.31434
ble_else.31434:
	load    [$4 + 0], $24
	load    [$23 + 0], $23
	fmul    $19, $24, $24
	fadd    $24, $22, $24
	fabs    $24, $24
	fcmp    $23, $24
	bg      ble_else.31435
ble_then.31435:
	li      0, $19
	b       ble_cont.31435
ble_else.31435:
.count move_float
	mov     $19, $42
	li      1, $19
ble_cont.31435:
ble_cont.31434:
be_cont.31429:
	cmp     $19, 0
	bne     be_else.31436
be_then.31436:
	load    [$4 + 2], $19
	fcmp    $19, $zero
	bne     be_else.31437
be_then.31437:
	li      0, $18
	b       be_cont.31420
be_else.31437:
	load    [$18 + 4], $24
	finv    $19, $23
	fcmp    $zero, $19
	load    [$24 + 2], $25
	bg      ble_else.31438
ble_then.31438:
	li      0, $19
	b       ble_cont.31438
ble_else.31438:
	li      1, $19
ble_cont.31438:
	load    [$18 + 6], $18
	cmp     $18, 0
	bne     be_else.31439
be_then.31439:
	mov     $19, $18
	b       be_cont.31439
be_else.31439:
	cmp     $19, 0
	bne     be_else.31440
be_then.31440:
	li      1, $18
	b       be_cont.31440
be_else.31440:
	li      0, $18
be_cont.31440:
be_cont.31439:
	cmp     $18, 0
	bne     be_else.31441
be_then.31441:
	fneg    $25, $18
	b       be_cont.31441
be_else.31441:
	mov     $25, $18
be_cont.31441:
	fsub    $18, $20, $18
	load    [$4 + 0], $19
	load    [$24 + 0], $20
	fmul    $18, $23, $18
	fmul    $18, $19, $19
	fadd    $19, $22, $19
	fabs    $19, $19
	fcmp    $20, $19
	bg      ble_else.31442
ble_then.31442:
	li      0, $18
	b       be_cont.31420
ble_else.31442:
	load    [$4 + 1], $19
	load    [$24 + 1], $20
	fmul    $18, $19, $19
	fadd    $19, $21, $19
	fabs    $19, $19
	fcmp    $20, $19
	bg      ble_else.31443
ble_then.31443:
	li      0, $18
	b       be_cont.31420
ble_else.31443:
.count move_float
	mov     $18, $42
	li      3, $18
	b       be_cont.31420
be_else.31436:
	li      2, $18
	b       be_cont.31420
be_else.31428:
	li      1, $18
	b       be_cont.31420
be_else.31420:
	cmp     $19, 2
	bne     be_else.31444
be_then.31444:
	load    [$18 + 4], $18
	load    [$4 + 1], $24
	load    [$4 + 0], $19
	load    [$18 + 1], $25
	load    [$18 + 0], $23
	fmul    $24, $25, $24
	fmul    $19, $23, $19
	load    [$18 + 2], $18
	fadd    $19, $24, $19
	load    [$4 + 2], $24
	fmul    $24, $18, $24
	fadd    $19, $24, $19
	fcmp    $19, $zero
	bg      ble_else.31445
ble_then.31445:
	li      0, $18
	b       be_cont.31444
ble_else.31445:
	fmul    $25, $21, $21
	fmul    $23, $22, $22
	fmul    $18, $20, $18
	finv    $19, $19
	fadd    $22, $21, $21
	fadd    $21, $18, $18
	fneg    $18, $18
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31444
be_else.31444:
	load    [$4 + 0], $30
	load    [$4 + 1], $28
	load    [$18 + 4], $24
	load    [$18 + 4], $23
	fmul    $30, $30, $31
	fmul    $28, $28, $29
	load    [$4 + 2], $26
	load    [$24 + 0], $24
	load    [$23 + 1], $23
	load    [$18 + 4], $19
	fmul    $26, $26, $27
	fmul    $31, $24, $31
	fmul    $29, $23, $29
	load    [$19 + 2], $19
	load    [$18 + 3], $25
	fmul    $27, $19, $27
	fadd    $31, $29, $29
	cmp     $25, 0
	fadd    $29, $27, $27
	be      bne_cont.31446
bne_then.31446:
	load    [$18 + 9], $31
	fmul    $28, $26, $29
	load    [$31 + 0], $31
	fmul    $29, $31, $29
	load    [$18 + 9], $31
	fadd    $27, $29, $27
	load    [$31 + 1], $31
	fmul    $26, $30, $29
	fmul    $29, $31, $29
	load    [$18 + 9], $31
	fadd    $27, $29, $27
	load    [$31 + 2], $31
	fmul    $30, $28, $29
	fmul    $29, $31, $29
	fadd    $27, $29, $27
bne_cont.31446:
	fcmp    $27, $zero
	bne     be_else.31447
be_then.31447:
	li      0, $18
	b       be_cont.31447
be_else.31447:
	fmul    $22, $22, $33
	fmul    $21, $21, $32
	fmul    $20, $20, $31
	load    [$18 + 1], $29
	cmp     $25, 0
	fmul    $33, $24, $33
	fmul    $32, $23, $32
	fmul    $31, $19, $31
	fadd    $33, $32, $32
	fadd    $32, $31, $31
	be      bne_cont.31448
bne_then.31448:
	load    [$18 + 9], $33
	fmul    $21, $20, $32
	load    [$33 + 0], $33
	fmul    $32, $33, $32
	load    [$18 + 9], $33
	fadd    $31, $32, $31
	load    [$33 + 1], $33
	fmul    $20, $22, $32
	fmul    $32, $33, $32
	load    [$18 + 9], $33
	fadd    $31, $32, $31
	load    [$33 + 2], $33
	fmul    $22, $21, $32
	fmul    $32, $33, $32
	fadd    $31, $32, $31
bne_cont.31448:
	cmp     $29, 3
	bne     be_else.31449
be_then.31449:
	fsub    $31, $36, $29
	b       be_cont.31449
be_else.31449:
	mov     $31, $29
be_cont.31449:
	fmul    $26, $20, $31
	fmul    $27, $29, $29
	cmp     $25, 0
	fmul    $31, $19, $19
	fmul    $28, $21, $31
	fmul    $31, $23, $23
	fmul    $30, $22, $31
	fmul    $31, $24, $24
	fadd    $24, $23, $23
	fadd    $23, $19, $19
	be      bne_cont.31450
bne_then.31450:
	fmul    $26, $21, $23
	fmul    $28, $20, $24
	fmul    $30, $21, $21
	fmul    $30, $20, $20
	fadd    $23, $24, $23
	load    [$18 + 9], $24
	load    [$24 + 0], $24
	fmul    $23, $24, $23
	fmul    $26, $22, $24
	fmul    $28, $22, $22
	fadd    $20, $24, $20
	load    [$18 + 9], $24
	fadd    $21, $22, $21
	load    [$24 + 1], $24
	load    [$18 + 9], $22
	fmul    $20, $24, $20
	load    [$22 + 2], $22
	fmul    $21, $22, $21
	fadd    $23, $20, $20
	fadd    $20, $21, $20
	fmul    $20, $39, $20
	fadd    $19, $20, $19
bne_cont.31450:
	fmul    $19, $19, $20
	fsub    $20, $29, $20
	fcmp    $20, $zero
	bg      ble_else.31451
ble_then.31451:
	li      0, $18
	b       ble_cont.31451
ble_else.31451:
	load    [$18 + 6], $18
	fsqrt   $20, $20
	cmp     $18, 0
	finv    $27, $18
	bne     be_else.31452
be_then.31452:
	fneg    $20, $20
	fsub    $20, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31452
be_else.31452:
	fsub    $20, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31452:
ble_cont.31451:
be_cont.31447:
be_cont.31444:
be_cont.31420:
	cmp     $18, 0
	bne     be_else.31453
be_then.31453:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31454
be_then.31454:
	ret
be_else.31454:
	add     $2, 1, $2
	b       solve_each_element.2871
be_else.31453:
	fcmp    $42, $zero
	bg      ble_else.31455
ble_then.31455:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31455:
	fcmp    $49, $42
	bg      ble_else.31456
ble_then.31456:
	add     $2, 1, $2
	b       solve_each_element.2871
ble_else.31456:
.count stack_move
	sub     $sp, 6, $sp
.count load_float
	load    [f.27182], $20
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	fadd    $42, $20, $20
	store   $2, [$sp + 2]
	load    [$4 + 2], $21
	load    [min_caml_startp + 2], $19
	li      0, $2
	fmul    $21, $20, $21
	fadd    $21, $19, $6
	store   $6, [$sp + 3]
	load    [$4 + 1], $21
	load    [min_caml_startp + 1], $19
	fmul    $21, $20, $21
	fadd    $21, $19, $5
	store   $5, [$sp + 4]
	load    [$4 + 0], $21
	load    [min_caml_startp + 0], $19
	fmul    $21, $20, $21
	fadd    $21, $19, $4
	store   $4, [$sp + 5]
	call    check_all_inside.2856
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
	bne     be_else.31457
be_then.31457:
	load    [$sp - 4], $1
	load    [$sp - 5], $3
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element.2871
be_else.31457:
	load    [$sp - 1], $1
.count move_float
	mov     $20, $49
	store   $1, [min_caml_intersection_point + 0]
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
	load    [$sp - 3], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $17, [min_caml_intersected_object_id + 0]
	store   $18, [min_caml_intsec_rectside + 0]
	load    [$sp - 4], $1
	load    [$sp - 5], $3
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element.2871
.end solve_each_element

######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
	load    [$3 + $2], $34
	cmp     $34, -1
	bne     be_else.31458
be_then.31458:
	ret
be_else.31458:
.count stack_move
	sub     $sp, 3, $sp
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $34], $3
	li      0, $2
	call    solve_each_element.2871
	load    [$sp + 2], $34
	load    [$sp + 1], $35
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31459
be_then.31459:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31459:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31460
be_then.31460:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31460:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31461
be_then.31461:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31461:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31462
be_then.31462:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31462:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31463
be_then.31463:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31463:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31464
be_then.31464:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31464:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	add     $34, 1, $34
	load    [$35 + $34], $1
	cmp     $1, -1
	bne     be_else.31465
be_then.31465:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31465:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
.count stack_move
	add     $sp, 3, $sp
	add     $34, 1, $2
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
	bne     be_else.31466
be_then.31466:
	ret
be_else.31466:
.count stack_move
	sub     $sp, 4, $sp
	cmp     $35, 99
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	bne     be_else.31467
be_then.31467:
	load    [$34 + 1], $35
	cmp     $35, -1
	be      bne_cont.31468
bne_then.31468:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	call    solve_each_element.2871
	load    [$34 + 2], $35
	cmp     $35, -1
	be      bne_cont.31469
bne_then.31469:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 3], $35
	cmp     $35, -1
	be      bne_cont.31470
bne_then.31470:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 4], $35
	cmp     $35, -1
	be      bne_cont.31471
bne_then.31471:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 5], $35
	cmp     $35, -1
	be      bne_cont.31472
bne_then.31472:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$34 + 6], $35
	cmp     $35, -1
	be      bne_cont.31473
bne_then.31473:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      7, $2
	load    [$sp + 0], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
bne_cont.31473:
bne_cont.31472:
bne_cont.31471:
bne_cont.31470:
bne_cont.31469:
bne_cont.31468:
	load    [$sp + 2], $34
	load    [$sp + 1], $3
	add     $34, 1, $34
	load    [$3 + $34], $35
	load    [$35 + 0], $2
	cmp     $2, -1
	bne     be_else.31474
be_then.31474:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31474:
	cmp     $2, 99
	bne     be_else.31475
be_then.31475:
	load    [$35 + 1], $1
	cmp     $1, -1
	bne     be_else.31476
be_then.31476:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31476:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 2], $1
	cmp     $1, -1
	bne     be_else.31477
be_then.31477:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31477:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 3], $1
	cmp     $1, -1
	bne     be_else.31478
be_then.31478:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31478:
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	load    [$35 + 4], $1
	cmp     $1, -1
	bne     be_else.31479
be_then.31479:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31479:
	store   $34, [$sp + 3]
	load    [min_caml_and_net + $1], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element.2871
	li      5, $2
	load    [$sp + 0], $4
.count move_args
	mov     $35, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.31475:
	load    [$sp + 0], $3
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31480
be_then.31480:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
be_else.31480:
	fcmp    $49, $42
	bg      ble_else.31481
ble_then.31481:
.count stack_move
	add     $sp, 4, $sp
	add     $34, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix.2879
ble_else.31481:
	store   $34, [$sp + 3]
	li      1, $2
	load    [$sp + 0], $4
.count move_args
	mov     $35, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.31467:
.count move_args
	mov     $4, $3
.count move_args
	mov     $35, $2
	call    solver.2773
	cmp     $1, 0
	bne     be_else.31482
be_then.31482:
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
be_else.31482:
	fcmp    $49, $42
	bg      ble_else.31483
ble_then.31483:
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
ble_else.31483:
	li      1, $2
	load    [$sp + 0], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
	load    [$3 + $2], $17
	cmp     $17, -1
	bne     be_else.31484
be_then.31484:
	ret
be_else.31484:
	load    [min_caml_objects + $17], $18
	load    [$4 + 1], $21
	load    [$18 + 10], $19
	load    [$18 + 1], $20
	load    [$21 + $17], $21
	load    [$19 + 2], $22
	load    [$19 + 1], $23
	load    [$19 + 0], $24
	cmp     $20, 1
	bne     be_else.31485
be_then.31485:
	load    [$21 + 0], $25
	load    [$21 + 1], $20
	load    [$4 + 0], $19
	fsub    $25, $24, $25
	load    [$18 + 4], $26
	load    [$26 + 1], $26
	fmul    $25, $20, $20
	load    [$19 + 1], $25
	fmul    $20, $25, $25
	fadd    $25, $23, $25
	fabs    $25, $25
	fcmp    $26, $25
	bg      ble_else.31486
ble_then.31486:
	li      0, $25
	b       ble_cont.31486
ble_else.31486:
	load    [$19 + 2], $26
	load    [$18 + 4], $25
	fmul    $20, $26, $26
	load    [$25 + 2], $25
	fadd    $26, $22, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31487
ble_then.31487:
	li      0, $25
	b       ble_cont.31487
ble_else.31487:
	load    [$21 + 1], $25
	fcmp    $25, $zero
	bne     be_else.31488
be_then.31488:
	li      0, $25
	b       be_cont.31488
be_else.31488:
	li      1, $25
be_cont.31488:
ble_cont.31487:
ble_cont.31486:
	cmp     $25, 0
	bne     be_else.31489
be_then.31489:
	load    [$21 + 2], $25
	load    [$21 + 3], $20
	load    [$18 + 4], $26
	fsub    $25, $23, $25
	load    [$26 + 0], $26
	fmul    $25, $20, $20
	load    [$19 + 0], $25
	fmul    $20, $25, $25
	fadd    $25, $24, $25
	fabs    $25, $25
	fcmp    $26, $25
	bg      ble_else.31490
ble_then.31490:
	li      0, $25
	b       ble_cont.31490
ble_else.31490:
	load    [$19 + 2], $26
	load    [$18 + 4], $25
	fmul    $20, $26, $26
	load    [$25 + 2], $25
	fadd    $26, $22, $26
	fabs    $26, $26
	fcmp    $25, $26
	bg      ble_else.31491
ble_then.31491:
	li      0, $25
	b       ble_cont.31491
ble_else.31491:
	load    [$21 + 3], $25
	fcmp    $25, $zero
	bne     be_else.31492
be_then.31492:
	li      0, $25
	b       be_cont.31492
be_else.31492:
	li      1, $25
be_cont.31492:
ble_cont.31491:
ble_cont.31490:
	cmp     $25, 0
	bne     be_else.31493
be_then.31493:
	load    [$21 + 4], $25
	load    [$21 + 5], $20
	fsub    $25, $22, $22
	fmul    $22, $20, $20
	load    [$19 + 0], $22
	fmul    $20, $22, $22
	fadd    $22, $24, $22
	load    [$18 + 4], $24
	load    [$24 + 0], $24
	fabs    $22, $22
	fcmp    $24, $22
	bg      ble_else.31494
ble_then.31494:
	li      0, $18
	b       be_cont.31485
ble_else.31494:
	load    [$19 + 1], $19
	load    [$18 + 4], $18
	fmul    $20, $19, $19
	load    [$18 + 1], $18
	fadd    $19, $23, $19
	fabs    $19, $19
	fcmp    $18, $19
	bg      ble_else.31495
ble_then.31495:
	li      0, $18
	b       be_cont.31485
ble_else.31495:
	load    [$21 + 5], $18
	fcmp    $18, $zero
	bne     be_else.31496
be_then.31496:
	li      0, $18
	b       be_cont.31485
be_else.31496:
.count move_float
	mov     $20, $42
	li      3, $18
	b       be_cont.31485
be_else.31493:
.count move_float
	mov     $20, $42
	li      2, $18
	b       be_cont.31485
be_else.31489:
.count move_float
	mov     $20, $42
	li      1, $18
	b       be_cont.31485
be_else.31485:
	cmp     $20, 2
	bne     be_else.31497
be_then.31497:
	load    [$21 + 0], $18
	fcmp    $zero, $18
	bg      ble_else.31498
ble_then.31498:
	li      0, $18
	b       be_cont.31497
ble_else.31498:
	load    [$19 + 3], $19
	fmul    $18, $19, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31497
be_else.31497:
	load    [$21 + 0], $20
	fcmp    $20, $zero
	bne     be_else.31499
be_then.31499:
	li      0, $18
	b       be_cont.31499
be_else.31499:
	load    [$19 + 3], $19
	fmul    $20, $19, $19
	load    [$21 + 3], $20
	fmul    $20, $22, $20
	load    [$21 + 2], $22
	fmul    $22, $23, $22
	load    [$21 + 1], $23
	fmul    $23, $24, $23
	fadd    $23, $22, $22
	fadd    $22, $20, $20
	fmul    $20, $20, $22
	fsub    $22, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31500
ble_then.31500:
	li      0, $18
	b       ble_cont.31500
ble_else.31500:
	load    [$18 + 6], $18
	fsqrt   $19, $19
	cmp     $18, 0
	load    [$21 + 4], $18
	bne     be_else.31501
be_then.31501:
	fsub    $20, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
	b       be_cont.31501
be_else.31501:
	fadd    $20, $19, $19
	fmul    $19, $18, $18
.count move_float
	mov     $18, $42
	li      1, $18
be_cont.31501:
ble_cont.31500:
be_cont.31499:
be_cont.31497:
be_cont.31485:
	cmp     $18, 0
	bne     be_else.31502
be_then.31502:
	load    [min_caml_objects + $17], $1
	load    [$1 + 6], $1
	cmp     $1, 0
	bne     be_else.31503
be_then.31503:
	ret
be_else.31503:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
be_else.31502:
	fcmp    $42, $zero
	bg      ble_else.31504
ble_then.31504:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31504:
	load    [$4 + 0], $19
	fcmp    $49, $42
	bg      ble_else.31505
ble_then.31505:
	add     $2, 1, $2
	b       solve_each_element_fast.2885
ble_else.31505:
.count stack_move
	sub     $sp, 6, $sp
.count load_float
	load    [f.27182], $20
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	fadd    $42, $20, $20
	store   $2, [$sp + 2]
	load    [$19 + 2], $21
	li      0, $2
	fmul    $21, $20, $21
	fadd    $21, $52, $6
	store   $6, [$sp + 3]
	load    [$19 + 1], $21
	fmul    $21, $20, $21
	fadd    $21, $51, $5
	store   $5, [$sp + 4]
	load    [$19 + 0], $19
	fmul    $19, $20, $19
	fadd    $19, $50, $4
	store   $4, [$sp + 5]
	call    check_all_inside.2856
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
	bne     be_else.31506
be_then.31506:
	load    [$sp - 4], $1
	load    [$sp - 5], $3
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element_fast.2885
be_else.31506:
	load    [$sp - 1], $1
.count move_float
	mov     $20, $49
	store   $1, [min_caml_intersection_point + 0]
	load    [$sp - 2], $1
	store   $1, [min_caml_intersection_point + 1]
	load    [$sp - 3], $1
	store   $1, [min_caml_intersection_point + 2]
	store   $17, [min_caml_intersected_object_id + 0]
	store   $18, [min_caml_intsec_rectside + 0]
	load    [$sp - 4], $1
	load    [$sp - 5], $3
	load    [$sp - 6], $4
	add     $1, 1, $2
	b       solve_each_element_fast.2885
.end solve_each_element_fast

######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
	load    [$3 + $2], $27
	cmp     $27, -1
	bne     be_else.31507
be_then.31507:
	ret
be_else.31507:
.count stack_move
	sub     $sp, 3, $sp
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	load    [min_caml_and_net + $27], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$sp + 2], $27
	load    [$sp + 1], $28
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31508
be_then.31508:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31508:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31509
be_then.31509:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31509:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31510
be_then.31510:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31510:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31511
be_then.31511:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31511:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31512
be_then.31512:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31512:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31513
be_then.31513:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31513:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	add     $27, 1, $27
	load    [$28 + $27], $29
	cmp     $29, -1
	bne     be_else.31514
be_then.31514:
.count stack_move
	add     $sp, 3, $sp
	ret
be_else.31514:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
.count stack_move
	add     $sp, 3, $sp
	add     $27, 1, $2
	load    [$sp - 3], $4
.count move_args
	mov     $28, $3
	b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
	load    [$3 + $2], $27
	load    [$27 + 0], $28
	cmp     $28, -1
	bne     be_else.31515
be_then.31515:
	ret
be_else.31515:
.count stack_move
	sub     $sp, 4, $sp
	cmp     $28, 99
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	bne     be_else.31516
be_then.31516:
	load    [$27 + 1], $28
	cmp     $28, -1
	be      bne_cont.31517
bne_then.31517:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$27 + 2], $28
	cmp     $28, -1
	be      bne_cont.31518
bne_then.31518:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$27 + 3], $28
	cmp     $28, -1
	be      bne_cont.31519
bne_then.31519:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$27 + 4], $28
	cmp     $28, -1
	be      bne_cont.31520
bne_then.31520:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$27 + 5], $28
	cmp     $28, -1
	be      bne_cont.31521
bne_then.31521:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$27 + 6], $28
	cmp     $28, -1
	be      bne_cont.31522
bne_then.31522:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      7, $2
	load    [$sp + 0], $4
.count move_args
	mov     $27, $3
	call    solve_one_or_network_fast.2889
bne_cont.31522:
bne_cont.31521:
bne_cont.31520:
bne_cont.31519:
bne_cont.31518:
bne_cont.31517:
	load    [$sp + 2], $27
	load    [$sp + 1], $3
	add     $27, 1, $27
	load    [$3 + $27], $28
	load    [$28 + 0], $29
	cmp     $29, -1
	bne     be_else.31523
be_then.31523:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31523:
	cmp     $29, 99
	bne     be_else.31524
be_then.31524:
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31525
be_then.31525:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31525:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31526
be_then.31526:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31526:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 3], $29
	cmp     $29, -1
	bne     be_else.31527
be_then.31527:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31527:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	load    [$28 + 4], $29
	cmp     $29, -1
	bne     be_else.31528
be_then.31528:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31528:
	store   $27, [$sp + 3]
	load    [min_caml_and_net + $29], $3
	li      0, $2
	load    [$sp + 0], $4
	call    solve_each_element_fast.2885
	li      5, $2
	load    [$sp + 0], $4
.count move_args
	mov     $28, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31524:
	load    [$sp + 0], $3
.count move_args
	mov     $29, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31529
be_then.31529:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
be_else.31529:
	fcmp    $49, $42
	bg      ble_else.31530
ble_then.31530:
.count stack_move
	add     $sp, 4, $sp
	add     $27, 1, $2
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	b       trace_or_matrix_fast.2893
ble_else.31530:
	store   $27, [$sp + 3]
	li      1, $2
	load    [$sp + 0], $4
.count move_args
	mov     $28, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31516:
.count move_args
	mov     $4, $3
.count move_args
	mov     $28, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $30
	cmp     $30, 0
	bne     be_else.31531
be_then.31531:
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
be_else.31531:
	fcmp    $49, $42
	bg      ble_else.31532
ble_then.31532:
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
ble_else.31532:
	li      1, $2
	load    [$sp + 0], $4
.count move_args
	mov     $27, $3
	call    solve_one_or_network_fast.2889
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 2], $1
	load    [$sp - 3], $3
	load    [$sp - 4], $4
	add     $1, 1, $2
	b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
.begin utexture
utexture.2908:
	load    [$2 + 8], $10
	load    [$10 + 0], $10
.count move_float
	mov     $10, $60
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
	bne     be_else.31533
be_then.31533:
	load    [$2 + 5], $10
	load    [min_caml_intersection_point + 0], $12
.count load_float
	load    [f.27195], $13
	load    [$10 + 0], $10
	load    [$2 + 5], $11
.count stack_move
	sub     $sp, 3, $sp
	fsub    $12, $10, $10
.count load_float
	load    [f.27194], $12
	fmul    $10, $13, $2
	call    min_caml_floor
.count move_ret
	mov     $1, $14
	fmul    $14, $12, $14
	fsub    $10, $14, $10
.count load_float
	load    [f.27196], $14
	fcmp    $14, $10
	bg      ble_else.31534
ble_then.31534:
	li      0, $10
	b       ble_cont.31534
ble_else.31534:
	li      1, $10
ble_cont.31534:
	load    [min_caml_intersection_point + 2], $15
	load    [$11 + 2], $11
	fsub    $15, $11, $11
	fmul    $11, $13, $2
	call    min_caml_floor
	fmul    $1, $12, $1
.count stack_move
	add     $sp, 3, $sp
	fsub    $11, $1, $1
	fcmp    $14, $1
	bg      ble_else.31535
ble_then.31535:
	cmp     $10, 0
	bne     be_else.31536
be_then.31536:
.count load_float
	load    [f.27191], $1
.count move_float
	mov     $1, $54
	ret
be_else.31536:
.count move_float
	mov     $zero, $54
	ret
ble_else.31535:
	cmp     $10, 0
	bne     be_else.31537
be_then.31537:
.count move_float
	mov     $zero, $54
	ret
be_else.31537:
.count load_float
	load    [f.27191], $1
.count move_float
	mov     $1, $54
	ret
be_else.31533:
	cmp     $10, 2
	bne     be_else.31538
be_then.31538:
.count load_float
	load    [f.27193], $11
	load    [min_caml_intersection_point + 1], $12
.count stack_move
	sub     $sp, 3, $sp
	fmul    $12, $11, $2
	call    min_caml_sin
	fmul    $1, $1, $1
.count load_float
	load    [f.27191], $2
.count stack_move
	add     $sp, 3, $sp
	fmul    $2, $1, $3
	fsub    $36, $1, $1
.count move_float
	mov     $3, $60
	fmul    $2, $1, $1
.count move_float
	mov     $1, $54
	ret
be_else.31538:
	cmp     $10, 3
	bne     be_else.31539
be_then.31539:
	load    [$2 + 5], $10
	load    [min_caml_intersection_point + 2], $14
	load    [$2 + 5], $11
	load    [$10 + 2], $10
.count load_float
	load    [f.27192], $13
	load    [$11 + 0], $11
	fsub    $14, $10, $10
.count stack_move
	sub     $sp, 3, $sp
	load    [min_caml_intersection_point + 0], $14
.count load_float
	load    [f.27187], $12
	fsub    $14, $11, $11
	fmul    $10, $10, $10
	fmul    $11, $11, $11
	fadd    $11, $10, $10
	fsqrt   $10, $10
	fmul    $10, $13, $2
	store   $2, [$sp + 0]
	call    min_caml_floor
	load    [$sp + 0], $13
.count move_ret
	mov     $1, $11
	fsub    $13, $11, $11
	fmul    $11, $12, $2
	call    min_caml_cos
	fmul    $1, $1, $1
.count load_float
	load    [f.27191], $2
.count stack_move
	add     $sp, 3, $sp
	fmul    $1, $2, $3
	fsub    $36, $1, $1
.count move_float
	mov     $3, $54
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
be_else.31539:
	cmp     $10, 4
	bne     be_else.31540
be_then.31540:
.count stack_move
	sub     $sp, 3, $sp
	store   $2, [$sp + 1]
	load    [$2 + 5], $12
	load    [$2 + 4], $11
	load    [min_caml_intersection_point + 2], $15
	load    [$12 + 2], $12
	load    [$11 + 2], $11
	load    [$2 + 4], $13
	fsub    $15, $12, $12
	fsqrt   $11, $11
	load    [$2 + 5], $14
	fmul    $12, $11, $11
	load    [$13 + 0], $12
	load    [$14 + 0], $13
	fsqrt   $12, $12
	load    [min_caml_intersection_point + 0], $14
	fsub    $14, $13, $13
.count load_float
	load    [f.27184], $14
	fmul    $13, $12, $12
	fabs    $12, $13
	fcmp    $14, $13
	bg      ble_else.31541
ble_then.31541:
	finv    $12, $13
	fmul    $11, $13, $13
	fabs    $13, $2
	call    min_caml_atan
.count load_float
	load    [f.27186], $15
.count move_ret
	mov     $1, $13
	fmul    $13, $15, $13
.count load_float
	load    [f.27187], $15
.count load_float
	load    [f.27188], $15
	fmul    $13, $15, $13
	b       ble_cont.31541
ble_else.31541:
.count load_float
	load    [f.27185], $13
ble_cont.31541:
	fmul    $11, $11, $11
	fmul    $12, $12, $12
	load    [$sp + 1], $15
	load    [$15 + 4], $16
	fadd    $12, $11, $11
	load    [$15 + 5], $15
	load    [$16 + 1], $12
	load    [$15 + 1], $15
	load    [min_caml_intersection_point + 1], $16
	fsqrt   $12, $12
	fsub    $16, $15, $15
	fmul    $15, $12, $12
	fabs    $11, $15
	fcmp    $14, $15
	bg      ble_else.31542
ble_then.31542:
	finv    $11, $11
	fmul    $12, $11, $11
	fabs    $11, $2
	call    min_caml_atan
.count load_float
	load    [f.27186], $11
.count move_ret
	mov     $1, $10
	fmul    $10, $11, $10
.count load_float
	load    [f.27187], $11
.count load_float
	load    [f.27188], $11
	fmul    $10, $11, $2
	b       ble_cont.31542
ble_else.31542:
.count load_float
	load    [f.27185], $2
ble_cont.31542:
	store   $2, [$sp + 2]
	call    min_caml_floor
	load    [$sp + 2], $11
.count move_ret
	mov     $1, $10
.count move_args
	mov     $13, $2
	fsub    $11, $10, $10
	fsub    $39, $10, $10
	fmul    $10, $10, $10
	call    min_caml_floor
	fsub    $13, $1, $1
.count load_float
	load    [f.27189], $2
.count stack_move
	add     $sp, 3, $sp
	fsub    $39, $1, $1
	fmul    $1, $1, $1
	fsub    $2, $1, $1
	fsub    $1, $10, $1
	fcmp    $zero, $1
	bg      ble_else.31543
ble_then.31543:
.count load_float
	load    [f.27191], $3
.count load_float
	load    [f.27190], $2
	fmul    $3, $1, $1
	fmul    $1, $2, $1
.count move_float
	mov     $1, $58
	ret
ble_else.31543:
.count move_float
	mov     $zero, $58
	ret
be_else.31540:
	ret
.end utexture

######################################################################
.begin trace_reflections
trace_reflections.2915:
	cmp     $2, 0
	bl      bge_else.31544
bge_then.31544:
.count stack_move
	sub     $sp, 6, $sp
.count load_float
	load    [f.27197], $32
	store   $5, [$sp + 0]
	store   $4, [$sp + 1]
.count move_float
	mov     $32, $49
	store   $3, [$sp + 2]
	store   $2, [$sp + 3]
	load    [min_caml_reflections + $2], $31
	load    [$31 + 1], $4
	store   $4, [$sp + 4]
	load    [$59 + 0], $32
	load    [$32 + 0], $33
	cmp     $33, -1
	be      bne_cont.31545
bne_then.31545:
	cmp     $33, 99
	bne     be_else.31546
be_then.31546:
	load    [$32 + 1], $33
	cmp     $33, -1
	bne     be_else.31547
be_then.31547:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31546
be_else.31547:
	load    [min_caml_and_net + $33], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$32 + 2], $33
	load    [$sp + 4], $4
	cmp     $33, -1
	bne     be_else.31548
be_then.31548:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31546
be_else.31548:
	load    [min_caml_and_net + $33], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$32 + 3], $33
	load    [$sp + 4], $4
	cmp     $33, -1
	bne     be_else.31549
be_then.31549:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31546
be_else.31549:
	load    [min_caml_and_net + $33], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$32 + 4], $33
	load    [$sp + 4], $4
	cmp     $33, -1
	bne     be_else.31550
be_then.31550:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31546
be_else.31550:
	load    [min_caml_and_net + $33], $3
	li      0, $2
	call    solve_each_element_fast.2885
	li      5, $2
	load    [$sp + 4], $4
.count move_args
	mov     $32, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31546
be_else.31546:
.count move_args
	mov     $4, $3
.count move_args
	mov     $33, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $33
	cmp     $33, 0
	load    [$sp + 4], $4
	li      1, $2
	bne     be_else.31551
be_then.31551:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31551
be_else.31551:
	fcmp    $49, $42
	bg      ble_else.31552
ble_then.31552:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       ble_cont.31552
ble_else.31552:
.count move_args
	mov     $32, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
	load    [$sp + 4], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31552:
be_cont.31551:
be_cont.31546:
bne_cont.31545:
.count load_float
	load    [f.27183], $1
	fcmp    $49, $1
	bg      ble_else.31553
ble_then.31553:
	li      0, $1
	b       ble_cont.31553
ble_else.31553:
.count load_float
	load    [f.27198], $1
	fcmp    $1, $49
	bg      ble_else.31554
ble_then.31554:
	li      0, $1
	b       ble_cont.31554
ble_else.31554:
	li      1, $1
ble_cont.31554:
ble_cont.31553:
	cmp     $1, 0
	bne     be_else.31555
be_then.31555:
.count stack_move
	add     $sp, 6, $sp
	load    [$sp - 3], $1
	load    [$sp - 4], $3
	load    [$sp - 5], $4
	sub     $1, 1, $2
	load    [$sp - 6], $5
	b       trace_reflections.2915
be_else.31555:
	load    [min_caml_intersected_object_id + 0], $3
	load    [min_caml_intsec_rectside + 0], $2
	load    [$31 + 0], $1
	sll     $3, 2, $3
	add     $3, $2, $2
	cmp     $2, $1
	bne     be_else.31556
be_then.31556:
	store   $31, [$sp + 5]
	li      0, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count stack_move
	add     $sp, 6, $sp
	cmp     $1, 0
	bne     be_else.31557
be_then.31557:
	load    [$sp - 2], $2
	load    [min_caml_nvector + 1], $6
	load    [min_caml_nvector + 0], $7
	load    [$2 + 0], $2
	load    [min_caml_nvector + 2], $4
	load    [$sp - 1], $1
	load    [$2 + 1], $5
	load    [$2 + 2], $3
	load    [$1 + 2], $1
	load    [$2 + 0], $2
	fmul    $6, $5, $6
	fmul    $4, $3, $4
	fmul    $7, $2, $7
	fadd    $7, $6, $6
	fadd    $6, $4, $4
	load    [$sp - 4], $6
	fmul    $1, $6, $7
	fmul    $7, $4, $4
	fcmp    $4, $zero
	ble     bg_cont.31558
bg_then.31558:
	fmul    $4, $60, $7
	fadd    $46, $7, $7
.count move_float
	mov     $7, $46
	fmul    $4, $54, $7
	fmul    $4, $58, $4
	fadd    $47, $7, $7
	fadd    $48, $4, $4
.count move_float
	mov     $7, $47
.count move_float
	mov     $4, $48
bg_cont.31558:
	load    [$sp - 6], $4
	load    [$4 + 2], $7
	fmul    $7, $3, $3
	load    [$4 + 1], $7
	fmul    $7, $5, $5
	load    [$4 + 0], $7
	fmul    $7, $2, $2
	fadd    $2, $5, $2
.count move_args
	mov     $4, $5
	fadd    $2, $3, $2
	fmul    $1, $2, $1
	fcmp    $1, $zero
	bg      ble_else.31559
ble_then.31559:
	load    [$sp - 3], $1
.count move_args
	mov     $6, $3
	sub     $1, 1, $2
	load    [$sp - 5], $1
.count move_args
	mov     $1, $4
	b       trace_reflections.2915
ble_else.31559:
	fmul    $1, $1, $1
	load    [$sp - 5], $2
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
.count move_float
	mov     $1, $48
.count move_args
	mov     $6, $3
	load    [$sp - 3], $1
	sub     $1, 1, $1
.count move_args
	mov     $1, $2
	b       trace_reflections.2915
be_else.31557:
	load    [$sp - 3], $1
	load    [$sp - 4], $3
	load    [$sp - 5], $4
	sub     $1, 1, $2
	load    [$sp - 6], $5
	b       trace_reflections.2915
be_else.31556:
.count stack_move
	add     $sp, 6, $sp
	load    [$sp - 3], $1
	load    [$sp - 4], $3
	load    [$sp - 5], $4
	sub     $1, 1, $2
	load    [$sp - 6], $5
	b       trace_reflections.2915
bge_else.31544:
	ret
.end trace_reflections

######################################################################
.begin trace_ray
trace_ray.2920:
	cmp     $2, 4
	bg      ble_else.31560
ble_then.31560:
.count stack_move
	sub     $sp, 9, $sp
.count load_float
	load    [f.27197], $34
	store   $6, [$sp + 0]
	store   $3, [$sp + 1]
.count move_float
	mov     $34, $49
	store   $4, [$sp + 2]
	store   $2, [$sp + 3]
	store   $5, [$sp + 4]
	load    [$59 + 0], $34
	load    [$34 + 0], $35
	cmp     $35, -1
	be      bne_cont.31561
bne_then.31561:
	cmp     $35, 99
	bne     be_else.31562
be_then.31562:
	load    [$34 + 1], $35
	cmp     $35, -1
	bne     be_else.31563
be_then.31563:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31562
be_else.31563:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	call    solve_each_element.2871
	load    [$34 + 2], $35
	load    [$sp + 2], $4
	cmp     $35, -1
	bne     be_else.31564
be_then.31564:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31562
be_else.31564:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	call    solve_each_element.2871
	load    [$34 + 3], $35
	load    [$sp + 2], $4
	cmp     $35, -1
	bne     be_else.31565
be_then.31565:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31562
be_else.31565:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	call    solve_each_element.2871
	load    [$34 + 4], $35
	load    [$sp + 2], $4
	cmp     $35, -1
	bne     be_else.31566
be_then.31566:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31562
be_else.31566:
	load    [min_caml_and_net + $35], $3
	li      0, $2
	call    solve_each_element.2871
	li      5, $2
	load    [$sp + 2], $4
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
	li      1, $2
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31562
be_else.31562:
.count move_args
	mov     $4, $3
.count move_args
	mov     $35, $2
	call    solver.2773
.count move_ret
	mov     $1, $17
	cmp     $17, 0
	load    [$sp + 2], $4
	li      1, $2
	bne     be_else.31567
be_then.31567:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       be_cont.31567
be_else.31567:
	fcmp    $49, $42
	bg      ble_else.31568
ble_then.31568:
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
	b       ble_cont.31568
ble_else.31568:
.count move_args
	mov     $34, $3
	call    solve_one_or_network.2875
	li      1, $2
	load    [$sp + 2], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix.2879
ble_cont.31568:
be_cont.31567:
be_cont.31562:
bne_cont.31561:
	load    [$sp + 4], $17
.count load_float
	load    [f.27183], $19
	load    [$17 + 2], $18
	fcmp    $49, $19
	bg      ble_else.31569
ble_then.31569:
	li      0, $20
	b       ble_cont.31569
ble_else.31569:
.count load_float
	load    [f.27198], $20
	fcmp    $20, $49
	bg      ble_else.31570
ble_then.31570:
	li      0, $20
	b       ble_cont.31570
ble_else.31570:
	li      1, $20
ble_cont.31570:
ble_cont.31569:
	cmp     $20, 0
	bne     be_else.31571
be_then.31571:
.count stack_move
	add     $sp, 9, $sp
	add     $zero, -1, $1
	load    [$sp - 6], $2
.count storer
	add     $18, $2, $tmp
	cmp     $2, 0
	store   $1, [$tmp + 0]
	bne     be_else.31572
be_then.31572:
	ret
be_else.31572:
	load    [$sp - 7], $1
	load    [$1 + 2], $2
	load    [$1 + 1], $3
	load    [$1 + 0], $1
	fmul    $3, $56, $3
	fmul    $2, $57, $2
	fmul    $1, $55, $1
	fadd    $1, $3, $1
	fadd    $1, $2, $1
	fneg    $1, $1
	fcmp    $1, $zero
	bg      ble_else.31573
ble_then.31573:
	ret
ble_else.31573:
	fmul    $1, $1, $3
	load    [min_caml_beam + 0], $2
	fmul    $3, $1, $1
	load    [$sp - 8], $3
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
be_else.31571:
	store   $18, [$sp + 5]
	load    [min_caml_intersected_object_id + 0], $20
	load    [min_caml_objects + $20], $2
	store   $2, [$sp + 6]
	load    [$2 + 1], $21
	cmp     $21, 1
	bne     be_else.31574
be_then.31574:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $21
	load    [$sp + 2], $22
	sub     $21, 1, $21
	load    [$22 + $21], $22
	fcmp    $22, $zero
	bne     be_else.31575
be_then.31575:
	store   $zero, [min_caml_nvector + $21]
	b       be_cont.31574
be_else.31575:
	fcmp    $22, $zero
	bg      ble_else.31576
ble_then.31576:
	store   $36, [min_caml_nvector + $21]
	b       be_cont.31574
ble_else.31576:
	store   $40, [min_caml_nvector + $21]
	b       be_cont.31574
be_else.31574:
	cmp     $21, 2
	bne     be_else.31577
be_then.31577:
	load    [$2 + 4], $21
	load    [$21 + 0], $21
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
	b       be_cont.31577
be_else.31577:
	load    [$2 + 5], $21
	load    [min_caml_intersection_point + 2], $22
	load    [min_caml_intersection_point + 1], $23
	load    [$21 + 2], $21
	load    [min_caml_intersection_point + 0], $24
	load    [$2 + 4], $25
	fsub    $22, $21, $21
	load    [$2 + 4], $26
	load    [$2 + 5], $22
	load    [$2 + 3], $27
	load    [$25 + 1], $25
	load    [$22 + 1], $22
	load    [$26 + 0], $26
	cmp     $27, 0
	fsub    $23, $22, $22
	load    [$2 + 5], $23
	load    [$23 + 0], $23
	fmul    $22, $25, $25
	fsub    $24, $23, $23
	load    [$2 + 4], $24
	load    [$24 + 2], $24
	fmul    $23, $26, $26
	fmul    $21, $24, $24
	bne     be_else.31578
be_then.31578:
	store   $26, [min_caml_nvector + 0]
	store   $25, [min_caml_nvector + 1]
	store   $24, [min_caml_nvector + 2]
	b       be_cont.31578
be_else.31578:
	load    [$2 + 9], $28
	load    [$2 + 9], $27
	load    [$28 + 1], $28
	load    [$27 + 2], $27
	fmul    $21, $28, $28
	fmul    $22, $27, $27
	fadd    $27, $28, $27
	fmul    $27, $39, $27
	fadd    $26, $27, $26
	store   $26, [min_caml_nvector + 0]
	load    [$2 + 9], $27
	load    [$2 + 9], $26
	load    [$27 + 0], $27
	load    [$26 + 2], $26
	fmul    $21, $27, $21
	fmul    $23, $26, $26
	fadd    $26, $21, $21
	fmul    $21, $39, $21
	fadd    $25, $21, $21
	store   $21, [min_caml_nvector + 1]
	load    [$2 + 9], $21
	load    [$21 + 1], $21
	fmul    $23, $21, $21
	load    [$2 + 9], $23
	load    [$23 + 0], $23
	fmul    $22, $23, $22
	fadd    $21, $22, $21
	fmul    $21, $39, $21
	fadd    $24, $21, $21
	store   $21, [min_caml_nvector + 2]
be_cont.31578:
	load    [min_caml_nvector + 0], $23
	load    [min_caml_nvector + 1], $22
	load    [min_caml_nvector + 2], $21
	fmul    $23, $23, $23
	fmul    $22, $22, $22
	fmul    $21, $21, $21
	fadd    $23, $22, $22
	fadd    $22, $21, $21
	load    [$2 + 6], $22
	fsqrt   $21, $21
	fcmp    $21, $zero
	bne     be_else.31579
be_then.31579:
	mov     $36, $21
	b       be_cont.31579
be_else.31579:
	cmp     $22, 0
	finv    $21, $21
	be      bne_cont.31580
bne_then.31580:
	fneg    $21, $21
bne_cont.31580:
be_cont.31579:
	load    [min_caml_nvector + 0], $22
	fmul    $22, $21, $22
	store   $22, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $22
	fmul    $22, $21, $22
	store   $22, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $22
	fmul    $22, $21, $21
	store   $21, [min_caml_nvector + 2]
be_cont.31577:
be_cont.31574:
	load    [min_caml_intersection_point + 0], $21
	store   $21, [min_caml_startp + 0]
	load    [min_caml_intersection_point + 1], $21
	store   $21, [min_caml_startp + 1]
	load    [min_caml_intersection_point + 2], $21
	store   $21, [min_caml_startp + 2]
	call    utexture.2908
	load    [min_caml_intsec_rectside + 0], $13
	sll     $20, 2, $14
	add     $14, $13, $13
	load    [$sp + 3], $14
.count storer
	add     $18, $14, $tmp
	store   $13, [$tmp + 0]
	load    [min_caml_intersection_point + 0], $15
	load    [$17 + 1], $13
	load    [$13 + $14], $13
	store   $15, [$13 + 0]
	load    [min_caml_intersection_point + 1], $15
	store   $15, [$13 + 1]
	load    [min_caml_intersection_point + 2], $15
	store   $15, [$13 + 2]
	load    [$sp + 1], $16
	load    [$sp + 6], $13
	load    [$17 + 3], $15
	load    [$13 + 7], $13
.count storer
	add     $15, $14, $tmp
	load    [$13 + 0], $13
	fmul    $13, $16, $16
	fcmp    $39, $13
	store   $16, [$sp + 7]
	bg      ble_else.31581
ble_then.31581:
	li      1, $13
	store   $13, [$tmp + 0]
	load    [$17 + 4], $13
	load    [$13 + $14], $15
	store   $60, [$15 + 0]
	store   $54, [$15 + 1]
	store   $58, [$15 + 2]
	load    [$13 + $14], $13
.count load_float
	load    [f.27199], $15
.count load_float
	load    [f.27200], $15
	fmul    $15, $16, $15
	load    [$13 + 0], $16
	fmul    $16, $15, $16
	store   $16, [$13 + 0]
	load    [$13 + 1], $16
	fmul    $16, $15, $16
	store   $16, [$13 + 1]
	load    [$13 + 2], $16
	fmul    $16, $15, $15
	store   $15, [$13 + 2]
	load    [$17 + 7], $13
	load    [$13 + $14], $13
	load    [min_caml_nvector + 0], $14
	store   $14, [$13 + 0]
	load    [min_caml_nvector + 1], $14
	store   $14, [$13 + 1]
	load    [min_caml_nvector + 2], $14
	store   $14, [$13 + 2]
	b       ble_cont.31581
ble_else.31581:
	li      0, $13
	store   $13, [$tmp + 0]
ble_cont.31581:
	load    [$sp + 2], $13
	load    [min_caml_nvector + 2], $15
	load    [$13 + 2], $16
	load    [$13 + 1], $17
	load    [$13 + 0], $14
	fmul    $16, $15, $15
	load    [min_caml_nvector + 1], $16
	fmul    $17, $16, $16
	load    [min_caml_nvector + 0], $17
	fmul    $14, $17, $18
	fadd    $18, $16, $16
	fadd    $16, $15, $15
.count load_float
	load    [f.27201], $16
	fmul    $16, $15, $15
	fmul    $15, $17, $16
	fadd    $14, $16, $14
	store   $14, [$13 + 0]
	load    [$13 + 1], $16
	load    [min_caml_nvector + 1], $14
	fmul    $15, $14, $14
	fadd    $16, $14, $14
	store   $14, [$13 + 1]
	load    [min_caml_nvector + 2], $14
	fmul    $15, $14, $14
	load    [$13 + 2], $15
	fadd    $15, $14, $14
	store   $14, [$13 + 2]
	load    [$59 + 0], $13
	load    [$13 + 0], $2
	cmp     $2, -1
	bne     be_else.31582
be_then.31582:
	li      0, $14
	b       be_cont.31582
be_else.31582:
	store   $13, [$sp + 8]
	cmp     $2, 99
	bne     be_else.31583
be_then.31583:
	li      1, $28
	b       be_cont.31583
be_else.31583:
	call    solver_fast.2796
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31584
be_then.31584:
	li      0, $28
	b       be_cont.31584
be_else.31584:
	fcmp    $19, $42
	bg      ble_else.31585
ble_then.31585:
	li      0, $28
	b       ble_cont.31585
ble_else.31585:
	load    [$13 + 1], $28
	cmp     $28, -1
	bne     be_else.31586
be_then.31586:
	li      0, $28
	b       be_cont.31586
be_else.31586:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31587
be_then.31587:
	load    [$sp + 8], $28
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31588
be_then.31588:
	li      0, $28
	b       be_cont.31587
be_else.31588:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31589
be_then.31589:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31590
be_then.31590:
	li      0, $28
	b       be_cont.31587
be_else.31590:
	li      1, $28
	b       be_cont.31587
be_else.31589:
	li      1, $28
	b       be_cont.31587
be_else.31587:
	li      1, $28
be_cont.31587:
be_cont.31586:
ble_cont.31585:
be_cont.31584:
be_cont.31583:
	cmp     $28, 0
	bne     be_else.31591
be_then.31591:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31591
be_else.31591:
	load    [$sp + 8], $28
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31592
be_then.31592:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31592
be_else.31592:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31593
be_then.31593:
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31594
be_then.31594:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31593
be_else.31594:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31595
be_then.31595:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $14
	cmp     $14, 0
	bne     be_else.31596
be_then.31596:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
.count move_ret
	mov     $1, $14
	b       be_cont.31593
be_else.31596:
	li      1, $14
	b       be_cont.31593
be_else.31595:
	li      1, $14
	b       be_cont.31593
be_else.31593:
	li      1, $14
be_cont.31593:
be_cont.31592:
be_cont.31591:
be_cont.31582:
	load    [$sp + 6], $15
	load    [$sp + 1], $16
	cmp     $14, 0
	load    [$15 + 7], $15
	load    [$15 + 1], $15
	fmul    $16, $15, $15
	bne     be_cont.31597
be_then.31597:
	load    [min_caml_nvector + 1], $16
	load    [min_caml_nvector + 0], $14
	fmul    $16, $56, $16
	fmul    $14, $55, $14
	fadd    $14, $16, $14
	load    [min_caml_nvector + 2], $16
	fmul    $16, $57, $16
	fadd    $14, $16, $14
	load    [$sp + 7], $16
	fneg    $14, $14
	fmul    $14, $16, $14
	load    [$sp + 2], $16
	load    [$16 + 1], $18
	load    [$16 + 0], $17
	fcmp    $14, $zero
	fmul    $18, $56, $18
	fmul    $17, $55, $17
	load    [$16 + 2], $16
	fmul    $16, $57, $16
	fadd    $17, $18, $17
	fadd    $17, $16, $16
	fneg    $16, $16
	ble     bg_cont.31598
bg_then.31598:
	fmul    $14, $60, $17
	fadd    $46, $17, $17
.count move_float
	mov     $17, $46
	fmul    $14, $54, $17
	fmul    $14, $58, $14
	fadd    $47, $17, $17
	fadd    $48, $14, $14
.count move_float
	mov     $17, $47
.count move_float
	mov     $14, $48
bg_cont.31598:
	fcmp    $16, $zero
	ble     bg_cont.31599
bg_then.31599:
	fmul    $16, $16, $14
	fmul    $14, $14, $14
	fmul    $14, $15, $14
	fadd    $46, $14, $16
.count move_float
	mov     $16, $46
	fadd    $47, $14, $16
	fadd    $48, $14, $14
.count move_float
	mov     $16, $47
.count move_float
	mov     $14, $48
bg_cont.31599:
be_cont.31597:
	load    [min_caml_intersection_point + 0], $14
	li      min_caml_intersection_point, $2
	sub     $41, 1, $3
.count move_float
	mov     $14, $50
	load    [min_caml_intersection_point + 1], $14
.count move_float
	mov     $14, $51
	load    [min_caml_intersection_point + 2], $14
.count move_float
	mov     $14, $52
	call    setup_startp_constants.2831
	load    [min_caml_n_reflections + 0], $1
	load    [$sp + 7], $3
	load    [$sp + 2], $5
	sub     $1, 1, $2
.count move_args
	mov     $15, $4
	call    trace_reflections.2915
.count stack_move
	add     $sp, 9, $sp
.count load_float
	load    [f.27192], $1
	load    [$sp - 8], $2
	fcmp    $2, $1
	bg      ble_else.31600
ble_then.31600:
	ret
ble_else.31600:
	load    [$sp - 6], $1
	cmp     $1, 4
	bge     bl_cont.31601
bl_then.31601:
	load    [$sp - 4], $4
	add     $1, 1, $1
	add     $zero, -1, $3
.count storer
	add     $4, $1, $tmp
	store   $3, [$tmp + 0]
bl_cont.31601:
	load    [$sp - 3], $1
	load    [$1 + 2], $3
	cmp     $3, 2
	bne     be_else.31602
be_then.31602:
	load    [$1 + 7], $1
	load    [$sp - 7], $4
	load    [$sp - 5], $5
	load    [$1 + 0], $1
	fsub    $36, $1, $1
	fmul    $2, $1, $3
	load    [$sp - 6], $1
	add     $1, 1, $2
	load    [$sp - 9], $1
	fadd    $1, $49, $6
	b       trace_ray.2920
be_else.31602:
	ret
ble_else.31560:
	ret
.end trace_ray

######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
.count stack_move
	sub     $sp, 4, $sp
.count load_float
	load    [f.27197], $31
	store   $3, [$sp + 0]
.count move_float
	mov     $31, $49
	store   $2, [$sp + 1]
	load    [$59 + 0], $31
	load    [$31 + 0], $32
	cmp     $32, -1
	be      bne_cont.31603
bne_then.31603:
	cmp     $32, 99
	bne     be_else.31604
be_then.31604:
	load    [$31 + 1], $32
.count move_args
	mov     $2, $4
	cmp     $32, -1
	bne     be_else.31605
be_then.31605:
	li      1, $31
.count move_args
	mov     $59, $3
.count move_args
	mov     $31, $2
	call    trace_or_matrix_fast.2893
	b       be_cont.31604
be_else.31605:
	li      0, $27
	load    [min_caml_and_net + $32], $3
.count move_args
	mov     $27, $2
	call    solve_each_element_fast.2885
	load    [$31 + 2], $32
	load    [$sp + 1], $4
	cmp     $32, -1
	bne     be_else.31606
be_then.31606:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31604
be_else.31606:
	load    [min_caml_and_net + $32], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$31 + 3], $32
	load    [$sp + 1], $4
	cmp     $32, -1
	bne     be_else.31607
be_then.31607:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31604
be_else.31607:
	load    [min_caml_and_net + $32], $3
	li      0, $2
	call    solve_each_element_fast.2885
	load    [$31 + 4], $32
	load    [$sp + 1], $4
	cmp     $32, -1
	bne     be_else.31608
be_then.31608:
	li      1, $2
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31604
be_else.31608:
	load    [min_caml_and_net + $32], $3
	li      0, $2
	call    solve_each_element_fast.2885
	li      5, $2
	load    [$sp + 1], $4
.count move_args
	mov     $31, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31604
be_else.31604:
.count move_args
	mov     $2, $3
.count move_args
	mov     $32, $2
	call    solver_fast2.2814
.count move_ret
	mov     $1, $32
	cmp     $32, 0
	load    [$sp + 1], $4
	li      1, $2
	bne     be_else.31609
be_then.31609:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       be_cont.31609
be_else.31609:
	fcmp    $49, $42
	bg      ble_else.31610
ble_then.31610:
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
	b       ble_cont.31610
ble_else.31610:
.count move_args
	mov     $31, $3
	call    solve_one_or_network_fast.2889
	li      1, $2
	load    [$sp + 1], $4
.count move_args
	mov     $59, $3
	call    trace_or_matrix_fast.2893
ble_cont.31610:
be_cont.31609:
be_cont.31604:
bne_cont.31603:
.count load_float
	load    [f.27183], $17
	fcmp    $49, $17
	bg      ble_else.31611
ble_then.31611:
	li      0, $18
	b       ble_cont.31611
ble_else.31611:
.count load_float
	load    [f.27198], $18
	fcmp    $18, $49
	bg      ble_else.31612
ble_then.31612:
	li      0, $18
	b       ble_cont.31612
ble_else.31612:
	li      1, $18
ble_cont.31612:
ble_cont.31611:
	cmp     $18, 0
	bne     be_else.31613
be_then.31613:
.count stack_move
	add     $sp, 4, $sp
	ret
be_else.31613:
	load    [min_caml_intersected_object_id + 0], $19
	load    [$sp + 1], $18
	load    [min_caml_objects + $19], $2
	load    [$18 + 0], $18
	store   $2, [$sp + 2]
	load    [$2 + 1], $19
	cmp     $19, 1
	bne     be_else.31614
be_then.31614:
	store   $zero, [min_caml_nvector + 0]
	store   $zero, [min_caml_nvector + 1]
	store   $zero, [min_caml_nvector + 2]
	load    [min_caml_intsec_rectside + 0], $19
	sub     $19, 1, $19
	load    [$18 + $19], $18
	fcmp    $18, $zero
	bne     be_else.31615
be_then.31615:
	store   $zero, [min_caml_nvector + $19]
	b       be_cont.31614
be_else.31615:
	fcmp    $18, $zero
	bg      ble_else.31616
ble_then.31616:
	store   $36, [min_caml_nvector + $19]
	b       be_cont.31614
ble_else.31616:
	store   $40, [min_caml_nvector + $19]
	b       be_cont.31614
be_else.31614:
	cmp     $19, 2
	bne     be_else.31617
be_then.31617:
	load    [$2 + 4], $18
	load    [$18 + 0], $18
	fneg    $18, $18
	store   $18, [min_caml_nvector + 0]
	load    [$2 + 4], $18
	load    [$18 + 1], $18
	fneg    $18, $18
	store   $18, [min_caml_nvector + 1]
	load    [$2 + 4], $18
	load    [$18 + 2], $18
	fneg    $18, $18
	store   $18, [min_caml_nvector + 2]
	b       be_cont.31617
be_else.31617:
	load    [$2 + 5], $18
	load    [min_caml_intersection_point + 2], $19
	load    [min_caml_intersection_point + 1], $20
	load    [$18 + 2], $18
	load    [min_caml_intersection_point + 0], $21
	load    [$2 + 4], $22
	fsub    $19, $18, $18
	load    [$2 + 4], $23
	load    [$2 + 5], $19
	load    [$2 + 3], $24
	load    [$22 + 1], $22
	load    [$19 + 1], $19
	load    [$23 + 0], $23
	cmp     $24, 0
	fsub    $20, $19, $19
	load    [$2 + 5], $20
	load    [$20 + 0], $20
	fmul    $19, $22, $22
	fsub    $21, $20, $20
	load    [$2 + 4], $21
	load    [$21 + 2], $21
	fmul    $20, $23, $23
	fmul    $18, $21, $21
	bne     be_else.31618
be_then.31618:
	store   $23, [min_caml_nvector + 0]
	store   $22, [min_caml_nvector + 1]
	store   $21, [min_caml_nvector + 2]
	b       be_cont.31618
be_else.31618:
	load    [$2 + 9], $25
	load    [$2 + 9], $24
	load    [$25 + 1], $25
	load    [$24 + 2], $24
	fmul    $18, $25, $25
	fmul    $19, $24, $24
	fadd    $24, $25, $24
	fmul    $24, $39, $24
	fadd    $23, $24, $23
	store   $23, [min_caml_nvector + 0]
	load    [$2 + 9], $24
	load    [$2 + 9], $23
	load    [$24 + 0], $24
	load    [$23 + 2], $23
	fmul    $18, $24, $18
	fmul    $20, $23, $23
	fadd    $23, $18, $18
	fmul    $18, $39, $18
	fadd    $22, $18, $18
	store   $18, [min_caml_nvector + 1]
	load    [$2 + 9], $18
	load    [$18 + 1], $18
	fmul    $20, $18, $18
	load    [$2 + 9], $20
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	fadd    $18, $19, $18
	fmul    $18, $39, $18
	fadd    $21, $18, $18
	store   $18, [min_caml_nvector + 2]
be_cont.31618:
	load    [min_caml_nvector + 0], $20
	load    [min_caml_nvector + 1], $19
	load    [min_caml_nvector + 2], $18
	fmul    $20, $20, $20
	fmul    $19, $19, $19
	fmul    $18, $18, $18
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	load    [$2 + 6], $19
	fsqrt   $18, $18
	fcmp    $18, $zero
	bne     be_else.31619
be_then.31619:
	mov     $36, $18
	b       be_cont.31619
be_else.31619:
	cmp     $19, 0
	finv    $18, $18
	be      bne_cont.31620
bne_then.31620:
	fneg    $18, $18
bne_cont.31620:
be_cont.31619:
	load    [min_caml_nvector + 0], $19
	fmul    $19, $18, $19
	store   $19, [min_caml_nvector + 0]
	load    [min_caml_nvector + 1], $19
	fmul    $19, $18, $19
	store   $19, [min_caml_nvector + 1]
	load    [min_caml_nvector + 2], $19
	fmul    $19, $18, $18
	store   $18, [min_caml_nvector + 2]
be_cont.31617:
be_cont.31614:
	call    utexture.2908
	load    [$59 + 0], $13
	load    [$13 + 0], $2
	cmp     $2, -1
	bne     be_else.31621
be_then.31621:
	li      0, $1
	b       be_cont.31621
be_else.31621:
	store   $13, [$sp + 3]
	cmp     $2, 99
	bne     be_else.31622
be_then.31622:
	li      1, $28
	b       be_cont.31622
be_else.31622:
	call    solver_fast.2796
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31623
be_then.31623:
	li      0, $28
	b       be_cont.31623
be_else.31623:
	fcmp    $17, $42
	bg      ble_else.31624
ble_then.31624:
	li      0, $28
	b       ble_cont.31624
ble_else.31624:
	load    [$13 + 1], $28
	cmp     $28, -1
	bne     be_else.31625
be_then.31625:
	li      0, $28
	b       be_cont.31625
be_else.31625:
	load    [min_caml_and_net + $28], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31626
be_then.31626:
	load    [$sp + 3], $28
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31627
be_then.31627:
	li      0, $28
	b       be_cont.31626
be_else.31627:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31628
be_then.31628:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
.count move_ret
	mov     $1, $28
	cmp     $28, 0
	bne     be_else.31629
be_then.31629:
	li      0, $28
	b       be_cont.31626
be_else.31629:
	li      1, $28
	b       be_cont.31626
be_else.31628:
	li      1, $28
	b       be_cont.31626
be_else.31626:
	li      1, $28
be_cont.31626:
be_cont.31625:
ble_cont.31624:
be_cont.31623:
be_cont.31622:
	cmp     $28, 0
	bne     be_else.31630
be_then.31630:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31630
be_else.31630:
	load    [$sp + 3], $28
	load    [$28 + 1], $29
	cmp     $29, -1
	bne     be_else.31631
be_then.31631:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31631
be_else.31631:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $29
	cmp     $29, 0
	bne     be_else.31632
be_then.31632:
	load    [$28 + 2], $29
	cmp     $29, -1
	bne     be_else.31633
be_then.31633:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31632
be_else.31633:
	load    [min_caml_and_net + $29], $3
	li      0, $2
	call    shadow_check_and_group.2862
.count move_ret
	mov     $1, $31
	cmp     $31, 0
	bne     be_else.31634
be_then.31634:
	li      3, $2
.count move_args
	mov     $28, $3
	call    shadow_check_one_or_group.2865
	cmp     $1, 0
	bne     be_else.31635
be_then.31635:
	li      1, $2
.count move_args
	mov     $59, $3
	call    shadow_check_one_or_matrix.2868
	b       be_cont.31632
be_else.31635:
	li      1, $1
	b       be_cont.31632
be_else.31634:
	li      1, $1
	b       be_cont.31632
be_else.31632:
	li      1, $1
be_cont.31632:
be_cont.31631:
be_cont.31630:
be_cont.31621:
.count stack_move
	add     $sp, 4, $sp
	cmp     $1, 0
	bne     be_else.31636
be_then.31636:
	load    [min_caml_nvector + 0], $4
	load    [min_caml_nvector + 1], $3
	load    [min_caml_nvector + 2], $2
	fmul    $4, $55, $4
	fmul    $3, $56, $3
	fmul    $2, $57, $2
	load    [$sp - 2], $1
	fadd    $4, $3, $3
	load    [$1 + 7], $1
	load    [$1 + 0], $1
	fadd    $3, $2, $2
	fneg    $2, $2
	fcmp    $2, $zero
	bg      ble_cont.31637
ble_then.31637:
	mov     $zero, $2
ble_cont.31637:
	load    [$sp - 4], $3
	fmul    $3, $2, $2
	fmul    $2, $1, $1
	fmul    $1, $60, $2
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
be_else.31636:
	ret
.end trace_diffuse_ray

######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
	cmp     $4, 0
	bl      bge_else.31638
bge_then.31638:
	load    [$2 + $4], $1
	load    [$3 + 2], $5
.count stack_move
	sub     $sp, 4, $sp
	load    [$1 + 0], $1
	load    [$1 + 2], $6
	load    [$1 + 1], $7
	fmul    $6, $5, $5
	load    [$1 + 0], $1
	load    [$3 + 1], $6
	fmul    $7, $6, $6
	load    [$3 + 0], $7
	store   $3, [$sp + 0]
	fmul    $1, $7, $1
	store   $2, [$sp + 1]
	store   $4, [$sp + 2]
	fadd    $1, $6, $1
	fadd    $1, $5, $1
	fcmp    $zero, $1
	bg      ble_else.31639
ble_then.31639:
	load    [$2 + $4], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31640
bge_then.31640:
	load    [$sp + 1], $2
	load    [$sp + 0], $4
	load    [$2 + $1], $3
	load    [$4 + 2], $5
	load    [$3 + 0], $3
	load    [$3 + 2], $6
	load    [$3 + 1], $7
	fmul    $6, $5, $5
	load    [$3 + 0], $3
	load    [$4 + 1], $6
	fmul    $7, $6, $6
	load    [$4 + 0], $7
	store   $1, [$sp + 3]
	fmul    $3, $7, $3
	fadd    $3, $6, $3
	fadd    $3, $5, $3
	fcmp    $zero, $3
	bg      ble_else.31641
ble_then.31641:
	load    [$2 + $1], $2
	fmul    $3, $37, $3
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $2
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.31641:
	add     $1, 1, $1
	fmul    $3, $38, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $2
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.31640:
.count stack_move
	add     $sp, 4, $sp
	ret
ble_else.31639:
	add     $4, 1, $3
	load    [$2 + $3], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	load    [$sp + 2], $1
	sub     $1, 2, $1
	cmp     $1, 0
	bl      bge_else.31642
bge_then.31642:
	load    [$sp + 1], $2
	load    [$sp + 0], $4
	load    [$2 + $1], $3
	load    [$4 + 2], $5
	load    [$3 + 0], $3
	load    [$3 + 2], $6
	load    [$3 + 1], $7
	fmul    $6, $5, $5
	load    [$3 + 0], $3
	load    [$4 + 1], $6
	fmul    $7, $6, $6
	load    [$4 + 0], $7
	store   $1, [$sp + 3]
	fmul    $3, $7, $3
	fadd    $3, $6, $3
	fadd    $3, $5, $3
	fcmp    $zero, $3
	bg      ble_else.31643
ble_then.31643:
	load    [$2 + $1], $2
	fmul    $3, $37, $3
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $2
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
ble_else.31643:
	add     $1, 1, $1
	fmul    $3, $38, $3
	load    [$2 + $1], $2
	call    trace_diffuse_ray.2926
.count stack_move
	add     $sp, 4, $sp
	load    [$sp - 1], $1
	load    [$sp - 3], $2
	load    [$sp - 4], $3
	sub     $1, 2, $4
	b       iter_trace_diffuse_rays.2929
bge_else.31642:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31638:
	ret
.end iter_trace_diffuse_rays

######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
.count stack_move
	sub     $sp, 10, $sp
	store   $3, [$sp + 0]
	store   $2, [$sp + 1]
	load    [$2 + 5], $14
	load    [$2 + 7], $16
	load    [$14 + $3], $14
	load    [$14 + 0], $15
.count move_float
	mov     $15, $43
	load    [$14 + 1], $15
	load    [$14 + 2], $14
.count move_float
	mov     $15, $44
.count move_float
	mov     $14, $45
	load    [$2 + 1], $15
	load    [$2 + 6], $14
	load    [$14 + 0], $14
	store   $14, [$sp + 2]
	load    [$15 + $3], $2
	cmp     $14, 0
	store   $2, [$sp + 3]
	load    [$16 + $3], $15
	store   $15, [$sp + 4]
	be      bne_cont.31644
bne_then.31644:
	load    [$2 + 0], $16
	load    [min_caml_dirvecs + 0], $14
	sub     $41, 1, $3
.count move_float
	mov     $16, $50
	load    [$2 + 1], $16
.count move_float
	mov     $16, $51
	load    [$2 + 2], $16
.count move_float
	mov     $16, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $16
	load    [$15 + 2], $17
	load    [$16 + 0], $16
	load    [$16 + 2], $18
	load    [$16 + 1], $19
	fmul    $18, $17, $17
	load    [$16 + 0], $16
	load    [$15 + 1], $18
	fmul    $19, $18, $18
	load    [$15 + 0], $19
	store   $14, [$sp + 5]
	fmul    $16, $19, $16
	fadd    $16, $18, $16
	fadd    $16, $17, $16
	fcmp    $zero, $16
	bg      ble_else.31645
ble_then.31645:
	load    [$14 + 118], $2
	fmul    $16, $37, $3
.count load_float
	load    [f.27205], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 5], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31645
ble_else.31645:
	load    [$14 + 119], $2
	fmul    $16, $38, $3
.count load_float
	load    [f.27204], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 5], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31645:
bne_cont.31644:
	load    [$sp + 2], $14
	cmp     $14, 1
	be      bne_cont.31646
bne_then.31646:
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 1], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 4], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 6]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31647
ble_then.31647:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
.count load_float
	load    [f.27205], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 6], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31647
ble_else.31647:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
.count load_float
	load    [f.27204], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 6], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31647:
bne_cont.31646:
	load    [$sp + 2], $14
	cmp     $14, 2
	be      bne_cont.31648
bne_then.31648:
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 2], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 4], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 7]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31649
ble_then.31649:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
.count load_float
	load    [f.27205], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 7], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31649
ble_else.31649:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
.count load_float
	load    [f.27204], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 7], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31649:
bne_cont.31648:
	load    [$sp + 2], $14
	cmp     $14, 3
	be      bne_cont.31650
bne_then.31650:
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 3], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 4], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 8]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31651
ble_then.31651:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
.count load_float
	load    [f.27205], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31651
ble_else.31651:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
.count load_float
	load    [f.27204], $14
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31651:
bne_cont.31650:
	load    [$sp + 2], $14
	cmp     $14, 4
	be      bne_cont.31652
bne_then.31652:
	load    [$sp + 3], $2
	load    [min_caml_dirvecs + 4], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$sp + 4], $3
	load    [$1 + 0], $1
	load    [$3 + 2], $2
	load    [$1 + 2], $4
	load    [$1 + 1], $5
	fmul    $4, $2, $2
	load    [$1 + 0], $1
	load    [$3 + 1], $4
	fmul    $5, $4, $4
	load    [$3 + 0], $5
	store   $14, [$sp + 9]
	fmul    $1, $5, $1
	fadd    $1, $4, $1
	fadd    $1, $2, $1
	fcmp    $zero, $1
	bg      ble_else.31653
ble_then.31653:
.count load_float
	load    [f.27205], $3
	load    [$14 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 9], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31653
ble_else.31653:
.count load_float
	load    [f.27204], $3
	load    [$14 + 119], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 9], $2
	load    [$sp + 4], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31653:
bne_cont.31652:
.count stack_move
	add     $sp, 10, $sp
	load    [$sp - 9], $1
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
	bg      ble_else.31654
ble_then.31654:
	load    [$2 + 2], $14
	load    [$14 + $3], $15
	cmp     $15, 0
	bl      bge_else.31655
bge_then.31655:
	load    [$2 + 3], $15
	load    [$15 + $3], $16
	cmp     $16, 0
	bne     be_else.31656
be_then.31656:
	add     $3, 1, $3
	cmp     $3, 4
	bg      ble_else.31657
ble_then.31657:
	load    [$14 + $3], $1
	cmp     $1, 0
	bl      bge_else.31658
bge_then.31658:
	load    [$15 + $3], $1
	cmp     $1, 0
	bne     be_else.31659
be_then.31659:
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31659:
.count stack_move
	sub     $sp, 13, $sp
	store   $2, [$sp + 0]
	store   $3, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 13, $sp
	load    [$sp - 12], $1
	load    [$sp - 13], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.31658:
	ret
ble_else.31657:
	ret
be_else.31656:
.count stack_move
	sub     $sp, 13, $sp
	store   $15, [$sp + 2]
	store   $14, [$sp + 3]
	store   $3, [$sp + 4]
	store   $2, [$sp + 0]
	load    [$2 + 5], $14
	load    [$2 + 7], $16
	load    [$14 + $3], $14
	load    [$14 + 0], $15
.count move_float
	mov     $15, $43
	load    [$14 + 1], $15
	load    [$14 + 2], $14
.count move_float
	mov     $15, $44
.count move_float
	mov     $14, $45
	load    [$2 + 1], $15
	load    [$2 + 6], $14
	load    [$14 + 0], $14
	store   $14, [$sp + 5]
	load    [$15 + $3], $2
	cmp     $14, 0
	store   $2, [$sp + 6]
	load    [$16 + $3], $15
	store   $15, [$sp + 7]
	be      bne_cont.31660
bne_then.31660:
	load    [$2 + 0], $16
	load    [min_caml_dirvecs + 0], $14
	sub     $41, 1, $3
.count move_float
	mov     $16, $50
	load    [$2 + 1], $16
.count move_float
	mov     $16, $51
	load    [$2 + 2], $16
.count move_float
	mov     $16, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $16
	load    [$15 + 2], $17
	load    [$16 + 0], $16
	load    [$16 + 2], $18
	load    [$16 + 1], $19
	fmul    $18, $17, $17
	load    [$16 + 0], $16
	load    [$15 + 1], $18
	fmul    $19, $18, $18
	load    [$15 + 0], $19
	store   $14, [$sp + 8]
	fmul    $16, $19, $16
	fadd    $16, $18, $16
	fadd    $16, $17, $16
	fcmp    $zero, $16
	bg      ble_else.31661
ble_then.31661:
	load    [$14 + 118], $2
	fmul    $16, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31661
ble_else.31661:
	load    [$14 + 119], $2
	fmul    $16, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31661:
bne_cont.31660:
	load    [$sp + 5], $14
	cmp     $14, 1
	be      bne_cont.31662
bne_then.31662:
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 1], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 7], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 9]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31663
ble_then.31663:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 9], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31663
ble_else.31663:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 9], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31663:
bne_cont.31662:
	load    [$sp + 5], $14
	cmp     $14, 2
	be      bne_cont.31664
bne_then.31664:
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 2], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 7], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 10]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31665
ble_then.31665:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 10], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31665
ble_else.31665:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 10], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31665:
bne_cont.31664:
	load    [$sp + 5], $14
	cmp     $14, 3
	be      bne_cont.31666
bne_then.31666:
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 3], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $15
	load    [$sp + 7], $3
	load    [$15 + 0], $15
	load    [$3 + 2], $16
	load    [$15 + 2], $17
	load    [$15 + 1], $18
	fmul    $17, $16, $16
	load    [$15 + 0], $15
	load    [$3 + 1], $17
	fmul    $18, $17, $17
	load    [$3 + 0], $18
	store   $14, [$sp + 11]
	fmul    $15, $18, $15
	fadd    $15, $17, $15
	fadd    $15, $16, $15
	fcmp    $zero, $15
	bg      ble_else.31667
ble_then.31667:
	load    [$14 + 118], $2
	fmul    $15, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 11], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31667
ble_else.31667:
	load    [$14 + 119], $2
	fmul    $15, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 11], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31667:
bne_cont.31666:
	load    [$sp + 5], $14
	cmp     $14, 4
	be      bne_cont.31668
bne_then.31668:
	load    [$sp + 6], $2
	load    [min_caml_dirvecs + 4], $14
	sub     $41, 1, $3
	load    [$2 + 0], $15
.count move_float
	mov     $15, $50
	load    [$2 + 1], $15
.count move_float
	mov     $15, $51
	load    [$2 + 2], $15
.count move_float
	mov     $15, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$sp + 7], $3
	load    [$1 + 0], $1
	load    [$3 + 2], $2
	load    [$1 + 2], $4
	load    [$1 + 1], $5
	fmul    $4, $2, $2
	load    [$1 + 0], $1
	load    [$3 + 1], $4
	fmul    $5, $4, $4
	load    [$3 + 0], $5
	store   $14, [$sp + 12]
	fmul    $1, $5, $1
	fadd    $1, $4, $1
	fadd    $1, $2, $1
	fcmp    $zero, $1
	bg      ble_else.31669
ble_then.31669:
	load    [$14 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 12], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31669
ble_else.31669:
	load    [$14 + 119], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 12], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31669:
bne_cont.31668:
	load    [$sp + 0], $2
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
	bg      ble_else.31670
ble_then.31670:
	load    [$sp + 3], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bl      bge_else.31671
bge_then.31671:
	load    [$sp + 2], $1
	load    [$1 + $3], $1
	cmp     $1, 0
	bne     be_else.31672
be_then.31672:
.count stack_move
	add     $sp, 13, $sp
	add     $3, 1, $3
	b       do_without_neighbors.2951
be_else.31672:
	store   $3, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 13, $sp
	load    [$sp - 12], $1
	load    [$sp - 13], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.31671:
.count stack_move
	add     $sp, 13, $sp
	ret
ble_else.31670:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31655:
	ret
ble_else.31654:
	ret
.end do_without_neighbors

######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
	cmp     $6, 4
	bg      ble_else.31673
ble_then.31673:
	load    [$4 + $2], $1
	load    [$1 + 2], $7
	load    [$7 + $6], $7
	cmp     $7, 0
	bl      bge_else.31674
bge_then.31674:
	load    [$3 + $2], $8
	load    [$8 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31675
be_then.31675:
	load    [$5 + $2], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31676
be_then.31676:
	sub     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31677
be_then.31677:
	add     $2, 1, $9
	load    [$4 + $9], $9
	load    [$9 + 2], $9
	load    [$9 + $6], $9
	cmp     $9, $7
	bne     be_else.31678
be_then.31678:
	li      1, $7
	b       be_cont.31675
be_else.31678:
	li      0, $7
	b       be_cont.31675
be_else.31677:
	li      0, $7
	b       be_cont.31675
be_else.31676:
	li      0, $7
	b       be_cont.31675
be_else.31675:
	li      0, $7
be_cont.31675:
	cmp     $7, 0
	bne     be_else.31679
be_then.31679:
	cmp     $6, 4
	bg      ble_else.31680
ble_then.31680:
	load    [$4 + $2], $2
	load    [$2 + 2], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bl      bge_else.31681
bge_then.31681:
	load    [$2 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31682
be_then.31682:
	add     $6, 1, $3
	b       do_without_neighbors.2951
be_else.31682:
.count stack_move
	sub     $sp, 2, $sp
.count move_args
	mov     $6, $3
	store   $2, [$sp + 0]
	store   $6, [$sp + 1]
	call    calc_diffuse_using_1point.2942
.count stack_move
	add     $sp, 2, $sp
	load    [$sp - 1], $1
	load    [$sp - 2], $2
	add     $1, 1, $3
	b       do_without_neighbors.2951
bge_else.31681:
	ret
ble_else.31680:
	ret
be_else.31679:
	load    [$1 + 3], $1
	load    [$1 + $6], $1
	cmp     $1, 0
	bne     be_else.31683
be_then.31683:
	add     $6, 1, $6
	b       try_exploit_neighbors.2967
be_else.31683:
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
bge_else.31674:
	ret
ble_else.31673:
	ret
.end try_exploit_neighbors

######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
	cmp     $3, 4
	bg      ble_else.31684
ble_then.31684:
	load    [$2 + 2], $14
	load    [$14 + $3], $15
	cmp     $15, 0
	bl      bge_else.31685
bge_then.31685:
	load    [$2 + 3], $15
	load    [$15 + $3], $16
	cmp     $16, 0
	bne     be_else.31686
be_then.31686:
	add     $3, 1, $16
	cmp     $16, 4
	bg      ble_else.31687
ble_then.31687:
	load    [$14 + $16], $14
	cmp     $14, 0
	bl      bge_else.31688
bge_then.31688:
	load    [$15 + $16], $14
	cmp     $14, 0
	bne     be_else.31689
be_then.31689:
	add     $16, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31689:
.count stack_move
	sub     $sp, 14, $sp
.count move_float
	mov     $zero, $43
	store   $16, [$sp + 0]
.count move_float
	mov     $zero, $44
	store   $2, [$sp + 1]
	load    [$2 + 1], $14
	load    [$2 + 6], $17
	load    [$2 + 7], $15
.count move_float
	mov     $zero, $45
	load    [$14 + $16], $2
	sub     $41, 1, $3
	load    [$2 + 0], $14
.count move_float
	mov     $14, $50
	load    [$2 + 1], $14
.count move_float
	mov     $14, $51
	load    [$2 + 2], $14
.count move_float
	mov     $14, $52
	call    setup_startp_constants.2831
	load    [$17 + 0], $1
	load    [$15 + $16], $3
	load    [min_caml_dirvecs + $1], $2
	load    [$3 + 2], $4
	load    [$2 + 118], $1
	load    [$1 + 0], $1
	load    [$1 + 2], $5
	load    [$1 + 1], $6
	fmul    $5, $4, $4
	load    [$1 + 0], $1
	load    [$3 + 1], $5
	fmul    $6, $5, $5
	load    [$3 + 0], $6
	store   $3, [$sp + 2]
	fmul    $1, $6, $1
	store   $2, [$sp + 3]
	fadd    $1, $5, $1
	fadd    $1, $4, $1
	fcmp    $zero, $1
	bg      ble_else.31690
ble_then.31690:
	load    [$2 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 3], $2
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31690
ble_else.31690:
	load    [$2 + 119], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 3], $2
	load    [$sp + 2], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31690:
.count stack_move
	add     $sp, 14, $sp
	load    [$sp - 13], $2
	load    [$sp - 14], $3
	load    [$2 + 5], $1
	load    [$1 + $3], $1
	add     $3, 1, $3
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	b       pretrace_diffuse_rays.2980
bge_else.31688:
	ret
ble_else.31687:
	ret
be_else.31686:
.count stack_move
	sub     $sp, 14, $sp
.count move_float
	mov     $zero, $43
	store   $15, [$sp + 4]
.count move_float
	mov     $zero, $44
	store   $14, [$sp + 5]
.count move_float
	mov     $zero, $45
	store   $2, [$sp + 1]
	store   $3, [$sp + 6]
	load    [$2 + 1], $14
	store   $14, [$sp + 7]
	load    [$2 + 7], $15
	store   $15, [$sp + 8]
	load    [$2 + 6], $16
	load    [$14 + $3], $2
	sub     $41, 1, $3
	load    [$2 + 0], $14
.count move_float
	mov     $14, $50
	load    [$2 + 1], $14
.count move_float
	mov     $14, $51
	load    [$2 + 2], $14
.count move_float
	mov     $14, $52
	call    setup_startp_constants.2831
	load    [$16 + 0], $14
	load    [min_caml_dirvecs + $14], $2
	store   $2, [$sp + 9]
	load    [$sp + 6], $16
	load    [$2 + 118], $14
	load    [$15 + $16], $3
	load    [$14 + 0], $14
	store   $3, [$sp + 10]
	load    [$14 + 2], $16
	load    [$3 + 2], $15
	load    [$14 + 1], $17
	fmul    $16, $15, $15
	load    [$14 + 0], $14
	load    [$3 + 1], $16
	fmul    $17, $16, $16
	load    [$3 + 0], $17
	fmul    $14, $17, $14
	fadd    $14, $16, $14
	fadd    $14, $15, $14
	fcmp    $zero, $14
	bg      ble_else.31691
ble_then.31691:
	load    [$2 + 118], $2
.count load_float
	load    [f.27205], $15
	fmul    $14, $37, $3
	call    trace_diffuse_ray.2926
	b       ble_cont.31691
ble_else.31691:
	load    [$2 + 119], $2
.count load_float
	load    [f.27204], $15
	fmul    $14, $38, $3
	call    trace_diffuse_ray.2926
ble_cont.31691:
	li      116, $4
	load    [$sp + 9], $2
	load    [$sp + 10], $3
	call    iter_trace_diffuse_rays.2929
	load    [$sp + 1], $2
	load    [$sp + 6], $15
	load    [$2 + 5], $14
	load    [$14 + $15], $16
	add     $15, 1, $15
	store   $43, [$16 + 0]
	cmp     $15, 4
	store   $44, [$16 + 1]
	store   $45, [$16 + 2]
	bg      ble_else.31692
ble_then.31692:
	load    [$sp + 5], $16
	load    [$16 + $15], $16
	cmp     $16, 0
	bl      bge_else.31693
bge_then.31693:
	load    [$sp + 4], $16
	load    [$16 + $15], $16
	cmp     $16, 0
	bne     be_else.31694
be_then.31694:
.count stack_move
	add     $sp, 14, $sp
	add     $15, 1, $3
	b       pretrace_diffuse_rays.2980
be_else.31694:
	store   $15, [$sp + 0]
.count move_float
	mov     $zero, $43
	store   $14, [$sp + 11]
	load    [$sp + 7], $16
	load    [$2 + 6], $14
.count move_float
	mov     $zero, $44
	load    [$16 + $15], $2
.count move_float
	mov     $zero, $45
	sub     $41, 1, $3
	load    [$2 + 0], $16
.count move_float
	mov     $16, $50
	load    [$2 + 1], $16
.count move_float
	mov     $16, $51
	load    [$2 + 2], $16
.count move_float
	mov     $16, $52
	call    setup_startp_constants.2831
	load    [$14 + 0], $1
	load    [$sp + 8], $3
	load    [min_caml_dirvecs + $1], $2
	load    [$3 + $15], $3
	load    [$2 + 118], $1
	load    [$3 + 2], $4
	load    [$1 + 0], $1
	load    [$1 + 2], $5
	load    [$1 + 1], $6
	fmul    $5, $4, $4
	load    [$1 + 0], $1
	load    [$3 + 1], $5
	fmul    $6, $5, $5
	load    [$3 + 0], $6
	store   $3, [$sp + 12]
	fmul    $1, $6, $1
	store   $2, [$sp + 13]
	fadd    $1, $5, $1
	fadd    $1, $4, $1
	fcmp    $zero, $1
	bg      ble_else.31695
ble_then.31695:
	load    [$2 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 13], $2
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31695
ble_else.31695:
	load    [$2 + 119], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 13], $2
	load    [$sp + 12], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31695:
.count stack_move
	add     $sp, 14, $sp
	load    [$sp - 14], $1
	load    [$sp - 3], $2
	add     $1, 1, $3
	load    [$2 + $1], $2
	store   $43, [$2 + 0]
	store   $44, [$2 + 1]
	store   $45, [$2 + 2]
	load    [$sp - 13], $2
	b       pretrace_diffuse_rays.2980
bge_else.31693:
.count stack_move
	add     $sp, 14, $sp
	ret
ble_else.31692:
.count stack_move
	add     $sp, 14, $sp
	ret
bge_else.31685:
	ret
ble_else.31684:
	ret
.end pretrace_diffuse_rays

######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
	cmp     $3, 0
	bl      bge_else.31696
bge_then.31696:
.count stack_move
	sub     $sp, 9, $sp
	store   $4, [$sp + 0]
	store   $3, [$sp + 1]
	store   $2, [$sp + 2]
	store   $7, [$sp + 3]
	store   $6, [$sp + 4]
	store   $5, [$sp + 5]
	load    [min_caml_image_center + 0], $10
	sub     $3, $10, $2
	call    min_caml_float_of_int
	load    [min_caml_scan_pitch + 0], $15
.count move_ret
	mov     $1, $14
	load    [$sp + 5], $16
	fmul    $15, $14, $14
	load    [min_caml_screenx_dir + 0], $15
	fmul    $14, $15, $15
	fadd    $15, $16, $15
	store   $15, [min_caml_ptrace_dirvec + 0]
	load    [$sp + 4], $16
	load    [min_caml_screenx_dir + 1], $15
	fmul    $14, $15, $15
	fadd    $15, $16, $15
	store   $15, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_screenx_dir + 2], $15
	fmul    $14, $15, $14
	load    [$sp + 3], $15
	fadd    $14, $15, $14
	store   $14, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_ptrace_dirvec + 0], $16
	load    [min_caml_ptrace_dirvec + 1], $15
	load    [min_caml_ptrace_dirvec + 2], $14
	fmul    $16, $16, $16
	fmul    $15, $15, $15
	fmul    $14, $14, $14
	fadd    $16, $15, $15
	fadd    $15, $14, $14
	fsqrt   $14, $14
	fcmp    $14, $zero
	bne     be_else.31697
be_then.31697:
	mov     $36, $14
	b       be_cont.31697
be_else.31697:
	finv    $14, $14
be_cont.31697:
	load    [min_caml_ptrace_dirvec + 0], $15
.count move_float
	mov     $zero, $46
.count move_float
	mov     $zero, $47
	fmul    $15, $14, $15
.count move_float
	mov     $zero, $48
	li      0, $2
	li      min_caml_ptrace_dirvec, $4
.count move_args
	mov     $zero, $6
	store   $15, [min_caml_ptrace_dirvec + 0]
.count move_args
	mov     $36, $3
	load    [min_caml_ptrace_dirvec + 1], $15
	fmul    $15, $14, $15
	store   $15, [min_caml_ptrace_dirvec + 1]
	load    [min_caml_ptrace_dirvec + 2], $15
	fmul    $15, $14, $14
	store   $14, [min_caml_ptrace_dirvec + 2]
	load    [min_caml_viewpoint + 0], $14
	store   $14, [min_caml_startp + 0]
	load    [min_caml_viewpoint + 1], $14
	store   $14, [min_caml_startp + 1]
	load    [min_caml_viewpoint + 2], $14
	store   $14, [min_caml_startp + 2]
	load    [$sp + 2], $15
	load    [$sp + 1], $14
	load    [$15 + $14], $5
	call    trace_ray.2920
	load    [$sp + 1], $14
	load    [$sp + 2], $15
	load    [$15 + $14], $16
	load    [$16 + 0], $16
	store   $46, [$16 + 0]
	store   $47, [$16 + 1]
	store   $48, [$16 + 2]
	load    [$sp + 0], $17
	load    [$15 + $14], $16
	load    [$16 + 6], $16
	store   $17, [$16 + 0]
	load    [$15 + $14], $2
	load    [$2 + 2], $14
	load    [$14 + 0], $14
	cmp     $14, 0
	bl      bge_cont.31698
bge_then.31698:
	load    [$2 + 3], $14
	load    [$14 + 0], $14
	cmp     $14, 0
	bne     be_else.31699
be_then.31699:
	li      1, $3
	call    pretrace_diffuse_rays.2980
	b       be_cont.31699
be_else.31699:
	store   $2, [$sp + 6]
	load    [$2 + 1], $16
	load    [$2 + 6], $14
	load    [$2 + 7], $15
.count move_float
	mov     $zero, $43
	load    [$16 + 0], $2
	load    [$14 + 0], $14
.count move_float
	mov     $zero, $44
	load    [$2 + 0], $16
.count move_float
	mov     $zero, $45
	load    [min_caml_dirvecs + $14], $14
.count move_float
	mov     $16, $50
	load    [$15 + 0], $15
	load    [$2 + 1], $16
	sub     $41, 1, $3
.count move_float
	mov     $16, $51
	load    [$2 + 2], $16
.count move_float
	mov     $16, $52
	call    setup_startp_constants.2831
	load    [$14 + 118], $1
	load    [$15 + 2], $2
	load    [$1 + 0], $1
	load    [$1 + 2], $3
	load    [$1 + 1], $4
	fmul    $3, $2, $2
	load    [$1 + 0], $1
	load    [$15 + 1], $3
	fmul    $4, $3, $3
	load    [$15 + 0], $4
	store   $15, [$sp + 7]
	fmul    $1, $4, $1
	store   $14, [$sp + 8]
	fadd    $1, $3, $1
	fadd    $1, $2, $1
	fcmp    $zero, $1
	bg      ble_else.31700
ble_then.31700:
	load    [$14 + 118], $2
	fmul    $1, $37, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
	b       ble_cont.31700
ble_else.31700:
	load    [$14 + 119], $2
	fmul    $1, $38, $3
	call    trace_diffuse_ray.2926
	li      116, $4
	load    [$sp + 8], $2
	load    [$sp + 7], $3
	call    iter_trace_diffuse_rays.2929
ble_cont.31700:
	load    [$sp + 6], $2
	li      1, $3
	load    [$2 + 5], $1
	load    [$1 + 0], $1
	store   $43, [$1 + 0]
	store   $44, [$1 + 1]
	store   $45, [$1 + 2]
	call    pretrace_diffuse_rays.2980
be_cont.31699:
bge_cont.31698:
.count stack_move
	add     $sp, 9, $sp
	load    [$sp - 9], $1
	load    [$sp - 6], $7
	load    [$sp - 5], $6
	add     $1, 1, $4
	load    [$sp - 4], $5
	load    [$sp - 8], $1
	cmp     $4, 5
	load    [$sp - 7], $2
	sub     $1, 1, $3
	bl      pretrace_pixels.2983
	sub     $4, 5, $4
	b       pretrace_pixels.2983
bge_else.31696:
	ret
.end pretrace_pixels

######################################################################
.begin scan_pixel
scan_pixel.2994:
	cmp     $53, $2
	bg      ble_else.31702
ble_then.31702:
	ret
ble_else.31702:
.count stack_move
	sub     $sp, 10, $sp
	store   $6, [$sp + 0]
	store   $4, [$sp + 1]
	store   $3, [$sp + 2]
	store   $5, [$sp + 3]
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
	store   $10, [$sp + 5]
	load    [min_caml_image_size + 1], $11
	cmp     $11, $10
	bg      ble_else.31703
ble_then.31703:
	li      0, $10
	b       ble_cont.31703
ble_else.31703:
	cmp     $3, 0
	bg      ble_else.31704
ble_then.31704:
	li      0, $10
	b       ble_cont.31704
ble_else.31704:
	add     $2, 1, $10
	cmp     $53, $10
	bg      ble_else.31705
ble_then.31705:
	li      0, $10
	b       ble_cont.31705
ble_else.31705:
	cmp     $2, 0
	bg      ble_else.31706
ble_then.31706:
	li      0, $10
	b       ble_cont.31706
ble_else.31706:
	li      1, $10
ble_cont.31706:
ble_cont.31705:
ble_cont.31704:
ble_cont.31703:
	cmp     $10, 0
	li      0, $3
	bne     be_else.31707
be_then.31707:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31707
bge_then.31708:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31709
be_then.31709:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31707
be_else.31709:
	store   $2, [$sp + 6]
	call    calc_diffuse_using_1point.2942
	li      1, $3
	load    [$sp + 6], $2
	call    do_without_neighbors.2951
	b       be_cont.31707
be_else.31707:
	load    [$5 + $2], $10
	load    [$10 + 2], $11
	load    [$11 + 0], $11
	cmp     $11, 0
	bl      bge_cont.31710
bge_then.31710:
	load    [$4 + $2], $12
	load    [$12 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31711
be_then.31711:
	load    [$6 + $2], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31712
be_then.31712:
	sub     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31713
be_then.31713:
	add     $2, 1, $13
	load    [$5 + $13], $13
	load    [$13 + 2], $13
	load    [$13 + 0], $13
	cmp     $13, $11
	bne     be_else.31714
be_then.31714:
	li      1, $11
	b       be_cont.31711
be_else.31714:
	li      0, $11
	b       be_cont.31711
be_else.31713:
	li      0, $11
	b       be_cont.31711
be_else.31712:
	li      0, $11
	b       be_cont.31711
be_else.31711:
	li      0, $11
be_cont.31711:
	cmp     $11, 0
	bne     be_else.31715
be_then.31715:
	load    [$5 + $2], $2
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31715
bge_then.31716:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31717
be_then.31717:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31715
be_else.31717:
	store   $2, [$sp + 7]
	call    calc_diffuse_using_1point.2942
	li      1, $3
	load    [$sp + 7], $2
	call    do_without_neighbors.2951
	b       be_cont.31715
be_else.31715:
	load    [$10 + 3], $10
.count move_args
	mov     $4, $3
	load    [$10 + 0], $10
.count move_args
	mov     $5, $4
	cmp     $10, 0
	bne     be_else.31718
be_then.31718:
	li      1, $10
.count move_args
	mov     $6, $5
.count move_args
	mov     $10, $6
	call    try_exploit_neighbors.2967
	b       be_cont.31718
be_else.31718:
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
be_cont.31718:
be_cont.31715:
bge_cont.31710:
be_cont.31707:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31719
ble_then.31719:
	cmp     $2, 0
	bl      bge_else.31720
bge_then.31720:
	call    min_caml_write
	b       ble_cont.31719
bge_else.31720:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31719
ble_else.31719:
	li      255, $2
	call    min_caml_write
ble_cont.31719:
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31721
ble_then.31721:
	cmp     $2, 0
	bl      bge_else.31722
bge_then.31722:
	call    min_caml_write
	b       ble_cont.31721
bge_else.31722:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31721
ble_else.31721:
	li      255, $2
	call    min_caml_write
ble_cont.31721:
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	mov     $1, $2
	cmp     $2, 255
	bg      ble_else.31723
ble_then.31723:
	cmp     $2, 0
	bl      bge_else.31724
bge_then.31724:
	call    min_caml_write
	b       ble_cont.31723
bge_else.31724:
	li      0, $2
	call    min_caml_write
	b       ble_cont.31723
ble_else.31723:
	li      255, $2
	call    min_caml_write
ble_cont.31723:
	load    [$sp + 4], $10
	add     $10, 1, $2
	cmp     $53, $2
	bg      ble_else.31725
ble_then.31725:
.count stack_move
	add     $sp, 10, $sp
	ret
ble_else.31725:
	store   $2, [$sp + 8]
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
	load    [$sp + 5], $11
	load    [min_caml_image_size + 1], $10
	cmp     $10, $11
	bg      ble_else.31726
ble_then.31726:
	li      0, $10
	b       ble_cont.31726
ble_else.31726:
	load    [$sp + 2], $10
	cmp     $10, 0
	bg      ble_else.31727
ble_then.31727:
	li      0, $10
	b       ble_cont.31727
ble_else.31727:
	add     $2, 1, $10
	cmp     $53, $10
	bg      ble_else.31728
ble_then.31728:
	li      0, $10
	b       ble_cont.31728
ble_else.31728:
	cmp     $2, 0
	bg      ble_else.31729
ble_then.31729:
	li      0, $10
	b       ble_cont.31729
ble_else.31729:
	li      1, $10
ble_cont.31729:
ble_cont.31728:
ble_cont.31727:
ble_cont.31726:
	cmp     $10, 0
	bne     be_else.31730
be_then.31730:
	load    [$4 + $2], $2
	li      0, $3
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31730
bge_then.31731:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31732
be_then.31732:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31730
be_else.31732:
	store   $2, [$sp + 9]
	call    calc_diffuse_using_1point.2942
	li      1, $3
	load    [$sp + 9], $2
	call    do_without_neighbors.2951
	b       be_cont.31730
be_else.31730:
	li      0, $6
	load    [$sp + 1], $3
	load    [$sp + 0], $5
	call    try_exploit_neighbors.2967
be_cont.31730:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31733
ble_then.31733:
	cmp     $1, 0
	bge     ble_cont.31733
bl_then.31734:
	li      0, $1
	b       ble_cont.31733
ble_else.31733:
	li      255, $1
ble_cont.31733:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31735
ble_then.31735:
	cmp     $1, 0
	bge     ble_cont.31735
bl_then.31736:
	li      0, $1
	b       ble_cont.31735
ble_else.31735:
	li      255, $1
ble_cont.31735:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31737
ble_then.31737:
	cmp     $1, 0
	bge     ble_cont.31737
bl_then.31738:
	li      0, $1
	b       ble_cont.31737
ble_else.31737:
	li      255, $1
ble_cont.31737:
	mov     $1, $2
	call    min_caml_write
.count stack_move
	add     $sp, 10, $sp
	load    [$sp - 2], $1
	load    [$sp - 8], $3
	load    [$sp - 9], $4
	add     $1, 1, $2
	load    [$sp - 7], $5
	load    [$sp - 10], $6
	b       scan_pixel.2994
.end scan_pixel

######################################################################
.begin scan_line
scan_line.3000:
	load    [min_caml_image_size + 1], $10
	cmp     $10, $2
	bg      ble_else.31739
ble_then.31739:
	ret
ble_else.31739:
.count stack_move
	sub     $sp, 8, $sp
	sub     $10, 1, $10
	store   $6, [$sp + 0]
	cmp     $10, $2
	store   $5, [$sp + 1]
	store   $3, [$sp + 2]
	store   $2, [$sp + 3]
	store   $4, [$sp + 4]
	ble     bg_cont.31740
bg_then.31740:
	load    [min_caml_image_center + 1], $12
	add     $2, 1, $10
	load    [min_caml_scan_pitch + 0], $11
	sub     $10, $12, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $10
	load    [min_caml_screenz_dir + 0], $12
	fmul    $11, $10, $10
	sub     $53, 1, $3
	load    [min_caml_screeny_dir + 0], $11
	load    [$sp + 1], $2
	load    [$sp + 0], $4
	fmul    $10, $11, $11
	fadd    $11, $12, $5
	load    [min_caml_screeny_dir + 1], $11
	load    [min_caml_screenz_dir + 1], $12
	fmul    $10, $11, $11
	fadd    $11, $12, $6
	load    [min_caml_screeny_dir + 2], $11
	fmul    $10, $11, $10
	load    [min_caml_screenz_dir + 2], $11
	fadd    $10, $11, $7
	call    pretrace_pixels.2983
bg_cont.31740:
	li      0, $2
	cmp     $53, 0
	ble     bg_cont.31741
bg_then.31741:
	load    [$sp + 4], $4
	load    [min_caml_image_size + 1], $12
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
	load    [$sp + 3], $10
	add     $10, 1, $11
	cmp     $12, $11
	bg      ble_else.31742
ble_then.31742:
	li      0, $10
	b       ble_cont.31742
ble_else.31742:
	cmp     $10, 0
	li      0, $10
	ble     bg_cont.31743
bg_then.31743:
	cmp     $53, 1
bg_cont.31743:
ble_cont.31742:
	cmp     $10, 0
	bne     be_else.31744
be_then.31744:
	load    [$4 + 0], $2
	li      0, $3
	load    [$2 + 2], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bl      be_cont.31744
bge_then.31745:
	load    [$2 + 3], $10
	load    [$10 + 0], $10
	cmp     $10, 0
	bne     be_else.31746
be_then.31746:
	li      1, $3
	call    do_without_neighbors.2951
	b       be_cont.31744
be_else.31746:
	store   $2, [$sp + 5]
	call    calc_diffuse_using_1point.2942
	li      1, $3
	load    [$sp + 5], $2
	call    do_without_neighbors.2951
	b       be_cont.31744
be_else.31744:
	li      0, $6
	load    [$sp + 2], $3
	load    [$sp + 1], $5
	call    try_exploit_neighbors.2967
be_cont.31744:
.count move_args
	mov     $46, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31747
ble_then.31747:
	cmp     $1, 0
	bge     ble_cont.31747
bl_then.31748:
	li      0, $1
	b       ble_cont.31747
ble_else.31747:
	li      255, $1
ble_cont.31747:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $47, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31749
ble_then.31749:
	cmp     $1, 0
	bge     ble_cont.31749
bl_then.31750:
	li      0, $1
	b       ble_cont.31749
ble_else.31749:
	li      255, $1
ble_cont.31749:
	mov     $1, $2
	call    min_caml_write
.count move_args
	mov     $48, $2
	call    min_caml_int_of_float
	cmp     $1, 255
	bg      ble_else.31751
ble_then.31751:
	cmp     $1, 0
	bge     ble_cont.31751
bl_then.31752:
	li      0, $1
	b       ble_cont.31751
ble_else.31751:
	li      255, $1
ble_cont.31751:
	mov     $1, $2
	call    min_caml_write
	li      1, $2
	load    [$sp + 3], $3
	load    [$sp + 2], $4
	load    [$sp + 4], $5
	load    [$sp + 1], $6
	call    scan_pixel.2994
bg_cont.31741:
	load    [$sp + 3], $10
	load    [min_caml_image_size + 1], $11
	add     $10, 1, $10
	cmp     $11, $10
	bg      ble_else.31753
ble_then.31753:
.count stack_move
	add     $sp, 8, $sp
	ret
ble_else.31753:
	store   $10, [$sp + 6]
	load    [$sp + 0], $12
	add     $12, 2, $12
	cmp     $12, 5
	bl      bge_cont.31754
bge_then.31754:
	sub     $12, 5, $12
bge_cont.31754:
	sub     $11, 1, $11
	store   $12, [$sp + 7]
	cmp     $11, $10
	ble     bg_cont.31755
bg_then.31755:
	load    [min_caml_image_center + 1], $13
	add     $10, 1, $10
	load    [min_caml_screenz_dir + 2], $11
	sub     $10, $13, $2
	call    min_caml_float_of_int
	load    [min_caml_scan_pitch + 0], $2
	load    [min_caml_screeny_dir + 1], $3
.count move_args
	mov     $12, $4
	fmul    $2, $1, $1
	load    [min_caml_screeny_dir + 2], $2
	fmul    $1, $2, $2
	fmul    $1, $3, $3
	fadd    $2, $11, $7
	load    [min_caml_screenz_dir + 1], $2
	fadd    $3, $2, $6
	load    [min_caml_screeny_dir + 0], $3
	load    [min_caml_screenz_dir + 0], $2
	fmul    $1, $3, $1
	sub     $53, 1, $3
	fadd    $1, $2, $5
	load    [$sp + 2], $2
	call    pretrace_pixels.2983
bg_cont.31755:
	li      0, $2
	load    [$sp + 6], $3
	load    [$sp + 4], $4
	load    [$sp + 1], $5
	load    [$sp + 2], $6
	call    scan_pixel.2994
.count stack_move
	add     $sp, 8, $sp
	load    [$sp - 1], $1
	load    [$sp - 4], $5
	load    [$sp - 6], $4
	add     $1, 2, $6
	load    [$sp - 7], $3
	load    [$sp - 2], $1
	cmp     $6, 5
	add     $1, 1, $2
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	bl      bge_else.31757
bge_then.31757:
.count stack_move
	sub     $sp, 2, $sp
	store   $3, [$sp + 0]
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	load    [$sp + 1], $21
	load    [$sp + 0], $20
.count storer
	add     $21, $20, $tmp
	store   $19, [$tmp + 0]
	sub     $20, 1, $19
	cmp     $19, 0
	bl      bge_else.31758
bge_then.31758:
	call    create_pixel.3008
.count storer
	add     $21, $19, $tmp
.count move_ret
	mov     $1, $10
	store   $10, [$tmp + 0]
	sub     $19, 1, $10
	cmp     $10, 0
	bl      bge_else.31759
bge_then.31759:
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $13
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	bl      bge_else.31760
bge_then.31760:
	call    create_pixel.3008
.count storer
	add     $21, $19, $tmp
.count stack_move
	add     $sp, 2, $sp
	sub     $19, 1, $3
	store   $1, [$tmp + 0]
.count move_args
	mov     $21, $2
	b       init_line_elements.3010
bge_else.31760:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31759:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31758:
.count stack_move
	add     $sp, 2, $sp
	mov     $21, $1
	ret
bge_else.31757:
	mov     $2, $1
	ret
.end init_line_elements

######################################################################
.begin calc_dirvec
calc_dirvec.3020:
	cmp     $2, 5
	bl      bge_else.31761
bge_then.31761:
	fmul    $4, $4, $5
	fmul    $3, $3, $6
	load    [min_caml_dirvecs + $7], $1
	load    [$1 + $8], $2
	fadd    $6, $5, $5
	load    [$2 + 0], $2
	fadd    $5, $36, $5
	fsqrt   $5, $5
	finv    $5, $5
	fmul    $3, $5, $3
	fmul    $4, $5, $4
	store   $3, [$2 + 0]
	fneg    $4, $6
	store   $4, [$2 + 1]
	fneg    $3, $7
	store   $5, [$2 + 2]
	add     $8, 40, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $3, [$2 + 0]
	store   $5, [$2 + 1]
	store   $6, [$2 + 2]
	add     $8, 80, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $5, [$2 + 0]
	store   $7, [$2 + 1]
	fneg    $5, $5
	store   $6, [$2 + 2]
	add     $8, 1, $2
	load    [$1 + $2], $2
	load    [$2 + 0], $2
	store   $7, [$2 + 0]
	store   $6, [$2 + 1]
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
bge_else.31761:
	fmul    $4, $4, $12
.count load_float
	load    [f.27192], $11
.count stack_move
	sub     $sp, 7, $sp
	store   $8, [$sp + 0]
	fadd    $12, $11, $12
	store   $7, [$sp + 1]
	store   $2, [$sp + 2]
	fsqrt   $12, $12
	store   $6, [$sp + 3]
	store   $5, [$sp + 4]
	finv    $12, $2
	call    min_caml_atan
	load    [$sp + 4], $14
.count move_ret
	mov     $1, $13
	fmul    $13, $14, $2
	store   $2, [$sp + 5]
	call    min_caml_sin
.count move_ret
	mov     $1, $13
	load    [$sp + 5], $2
	call    min_caml_cos
.count move_ret
	mov     $1, $15
	finv    $15, $15
	fmul    $13, $15, $13
	fmul    $13, $12, $12
	fmul    $12, $12, $13
	fadd    $13, $11, $11
	fsqrt   $11, $11
	finv    $11, $2
	call    min_caml_atan
	load    [$sp + 3], $15
.count move_ret
	mov     $1, $13
	fmul    $13, $15, $2
	store   $2, [$sp + 6]
	call    min_caml_sin
.count move_ret
	mov     $1, $13
	load    [$sp + 6], $2
	call    min_caml_cos
	finv    $1, $1
.count stack_move
	add     $sp, 7, $sp
.count move_args
	mov     $15, $6
	load    [$sp - 5], $2
	load    [$sp - 6], $7
	fmul    $13, $1, $1
	load    [$sp - 7], $8
	add     $2, 1, $2
.count move_args
	mov     $14, $5
.count move_args
	mov     $12, $3
	fmul    $1, $11, $4
	b       calc_dirvec.3020
.end calc_dirvec

######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
	cmp     $2, 0
	bl      bge_else.31762
bge_then.31762:
.count stack_move
	sub     $sp, 13, $sp
.count load_float
	load    [f.27233], $10
	store   $2, [$sp + 0]
.count load_float
	load    [f.27234], $11
	store   $5, [$sp + 1]
	store   $4, [$sp + 2]
	store   $3, [$sp + 3]
	store   $10, [$sp + 4]
	store   $11, [$sp + 5]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	li      0, $2
	fmul    $16, $11, $16
	load    [$sp + 3], $6
	load    [$sp + 2], $7
	load    [$sp + 1], $8
.count move_args
	mov     $zero, $4
	fsub    $16, $10, $5
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count load_float
	load    [f.27192], $17
	li      0, $2
.count move_args
	mov     $zero, $4
	fadd    $16, $17, $5
.count move_args
	mov     $zero, $3
	load    [$sp + 1], $16
	add     $16, 2, $8
	store   $8, [$sp + 6]
	load    [$sp + 3], $6
	load    [$sp + 2], $7
	call    calc_dirvec.3020
	load    [$sp + 0], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31763
bge_then.31763:
	store   $2, [$sp + 7]
	call    min_caml_float_of_int
	load    [$sp + 5], $19
.count move_ret
	mov     $1, $18
	load    [$sp + 2], $21
	fmul    $18, $19, $18
	load    [$sp + 4], $20
	add     $21, 1, $21
	cmp     $21, 5
	fsub    $18, $20, $5
	bl      bge_cont.31764
bge_then.31764:
	sub     $21, 5, $21
bge_cont.31764:
	mov     $21, $7
	store   $7, [$sp + 8]
	li      0, $2
	load    [$sp + 3], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
	load    [$sp + 3], $6
	load    [$sp + 8], $7
	load    [$sp + 6], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	load    [$sp + 7], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31765
bge_then.31765:
	store   $2, [$sp + 9]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
	load    [$sp + 8], $21
	fmul    $18, $19, $18
	add     $21, 1, $21
	cmp     $21, 5
	fsub    $18, $20, $5
	bl      bge_cont.31766
bge_then.31766:
	sub     $21, 5, $21
bge_cont.31766:
	mov     $21, $7
	store   $7, [$sp + 10]
	li      0, $2
	load    [$sp + 3], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
	load    [$sp + 3], $6
	load    [$sp + 10], $7
	load    [$sp + 6], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	load    [$sp + 9], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31767
bge_then.31767:
	store   $2, [$sp + 11]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
	fmul    $18, $19, $18
	load    [$sp + 10], $19
	add     $19, 1, $19
	fsub    $18, $20, $5
	cmp     $19, 5
	bl      bge_cont.31768
bge_then.31768:
	sub     $19, 5, $19
bge_cont.31768:
	mov     $19, $7
	store   $7, [$sp + 12]
	li      0, $2
	load    [$sp + 3], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
	load    [$sp + 3], $6
	load    [$sp + 12], $7
	load    [$sp + 6], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
.count stack_move
	add     $sp, 13, $sp
.count move_args
	mov     $16, $5
	load    [$sp - 1], $1
	load    [$sp - 10], $3
	add     $1, 1, $4
	load    [$sp - 2], $1
	cmp     $4, 5
	sub     $1, 1, $2
	bl      calc_dirvecs.3028
	sub     $4, 5, $4
	b       calc_dirvecs.3028
bge_else.31767:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31765:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31763:
.count stack_move
	add     $sp, 13, $sp
	ret
bge_else.31762:
	ret
.end calc_dirvecs

######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
	cmp     $2, 0
	bl      bge_else.31770
bge_then.31770:
.count stack_move
	sub     $sp, 19, $sp
.count load_float
	load    [f.27233], $10
	store   $2, [$sp + 0]
.count load_float
	load    [f.27234], $11
	store   $4, [$sp + 1]
	store   $3, [$sp + 2]
	store   $10, [$sp + 3]
	store   $11, [$sp + 4]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $12
	li      4, $2
	fmul    $12, $11, $12
	fsub    $12, $10, $12
	store   $12, [$sp + 5]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $16
	li      0, $2
	fmul    $16, $11, $16
.count move_args
	mov     $12, $6
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	fsub    $16, $10, $5
	store   $5, [$sp + 6]
	load    [$sp + 2], $7
	load    [$sp + 1], $8
	call    calc_dirvec.3020
.count load_float
	load    [f.27192], $17
	li      0, $2
.count move_args
	mov     $zero, $4
	fadd    $16, $17, $5
.count move_args
	mov     $zero, $3
	store   $5, [$sp + 7]
	load    [$sp + 1], $16
	add     $16, 2, $8
	store   $8, [$sp + 8]
	load    [$sp + 5], $6
	load    [$sp + 2], $7
	call    calc_dirvec.3020
	li      3, $2
	call    min_caml_float_of_int
	load    [$sp + 4], $19
.count move_ret
	mov     $1, $18
	load    [$sp + 3], $20
	fmul    $18, $19, $18
	fsub    $18, $20, $5
	store   $5, [$sp + 9]
	load    [$sp + 2], $21
	add     $21, 1, $21
	cmp     $21, 5
	bl      bge_cont.31771
bge_then.31771:
	sub     $21, 5, $21
bge_cont.31771:
	mov     $21, $7
	store   $7, [$sp + 10]
	li      0, $2
	load    [$sp + 5], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	store   $5, [$sp + 11]
	load    [$sp + 5], $6
	load    [$sp + 10], $7
	load    [$sp + 8], $8
	call    calc_dirvec.3020
	li      2, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $18
	fmul    $18, $19, $18
	load    [$sp + 10], $19
	add     $19, 1, $19
	fsub    $18, $20, $5
	cmp     $19, 5
	bl      bge_cont.31772
bge_then.31772:
	sub     $19, 5, $19
bge_cont.31772:
	mov     $19, $7
	store   $7, [$sp + 12]
	li      0, $2
	load    [$sp + 5], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	fadd    $18, $17, $5
	li      0, $2
	load    [$sp + 5], $6
	load    [$sp + 12], $7
	load    [$sp + 8], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	load    [$sp + 12], $22
	add     $22, 1, $22
	cmp     $22, 5
	bl      bge_cont.31773
bge_then.31773:
	sub     $22, 5, $22
bge_cont.31773:
	mov     $22, $4
	li      1, $2
	load    [$sp + 5], $3
.count move_args
	mov     $16, $5
	call    calc_dirvecs.3028
	load    [$sp + 0], $10
	sub     $10, 1, $2
	cmp     $2, 0
	bl      bge_else.31774
bge_then.31774:
	store   $2, [$sp + 13]
	call    min_caml_float_of_int
	load    [$sp + 4], $17
.count move_ret
	mov     $1, $16
	li      0, $2
	fmul    $16, $17, $16
	load    [$sp + 3], $17
	fsub    $16, $17, $6
	store   $6, [$sp + 14]
	load    [$sp + 1], $16
	add     $16, 4, $8
	store   $8, [$sp + 15]
	load    [$sp + 2], $16
	add     $16, 2, $16
	cmp     $16, 5
	bl      bge_cont.31775
bge_then.31775:
	sub     $16, 5, $16
bge_cont.31775:
	mov     $16, $7
	store   $7, [$sp + 16]
	load    [$sp + 6], $5
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	load    [$sp + 15], $16
	li      0, $2
.count move_args
	mov     $zero, $4
	add     $16, 2, $8
.count move_args
	mov     $zero, $3
	store   $8, [$sp + 17]
	load    [$sp + 7], $5
	load    [$sp + 14], $6
	load    [$sp + 16], $7
	call    calc_dirvec.3020
	load    [$sp + 16], $17
	add     $17, 1, $17
	cmp     $17, 5
	bl      bge_cont.31776
bge_then.31776:
	sub     $17, 5, $17
bge_cont.31776:
	mov     $17, $7
	store   $7, [$sp + 18]
	li      0, $2
	load    [$sp + 9], $5
	load    [$sp + 14], $6
.count move_args
	mov     $16, $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	li      0, $2
	load    [$sp + 11], $5
	load    [$sp + 14], $6
	load    [$sp + 18], $7
	load    [$sp + 17], $8
.count move_args
	mov     $zero, $4
.count move_args
	mov     $zero, $3
	call    calc_dirvec.3020
	load    [$sp + 18], $22
	add     $22, 1, $22
	cmp     $22, 5
	bl      bge_cont.31777
bge_then.31777:
	sub     $22, 5, $22
bge_cont.31777:
	mov     $22, $4
	li      2, $2
	load    [$sp + 14], $3
.count move_args
	mov     $16, $5
	call    calc_dirvecs.3028
.count stack_move
	add     $sp, 19, $sp
	load    [$sp - 3], $1
	add     $1, 2, $3
	load    [$sp - 4], $1
	cmp     $3, 5
	add     $1, 4, $4
	load    [$sp - 6], $1
	sub     $1, 1, $2
	bl      calc_dirvec_rows.3033
	sub     $3, 5, $3
	b       calc_dirvec_rows.3033
bge_else.31774:
.count stack_move
	add     $sp, 19, $sp
	ret
bge_else.31770:
	ret
.end calc_dirvec_rows

######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
	cmp     $3, 0
	bl      bge_else.31779
bge_then.31779:
.count stack_move
	sub     $sp, 6, $sp
	store   $3, [$sp + 0]
	store   $2, [$sp + 1]
.count move_args
	mov     $zero, $3
	li      3, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	add     $hp, 2, $hp
	load    [$sp + 2], $10
	store   $10, [$11 + 0]
	load    [$sp + 1], $12
	mov     $11, $10
	load    [$sp + 0], $11
.count storer
	add     $12, $11, $tmp
	store   $10, [$tmp + 0]
	sub     $11, 1, $10
	cmp     $10, 0
	bl      bge_else.31780
bge_then.31780:
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
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
	load    [$sp + 3], $11
	sub     $10, 1, $10
	add     $hp, 2, $hp
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	bl      bge_else.31781
bge_then.31781:
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
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
	load    [$sp + 4], $11
	sub     $10, 1, $10
	add     $hp, 2, $hp
	store   $11, [$13 + 0]
	cmp     $10, 0
	mov     $13, $11
	store   $11, [$tmp + 0]
	bl      bge_else.31782
bge_then.31782:
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
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
	load    [$sp - 1], $1
	add     $hp, 2, $hp
	sub     $10, 1, $3
	store   $1, [$2 + 0]
	mov     $2, $1
	store   $1, [$tmp + 0]
.count move_args
	mov     $12, $2
	b       create_dirvec_elements.3039
bge_else.31782:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31781:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31780:
.count stack_move
	add     $sp, 6, $sp
	ret
bge_else.31779:
	ret
.end create_dirvec_elements

######################################################################
.begin create_dirvecs
create_dirvecs.3042:
	cmp     $2, 0
	bl      bge_else.31783
bge_then.31783:
.count stack_move
	sub     $sp, 9, $sp
.count move_args
	mov     $zero, $3
	store   $2, [$sp + 0]
	li      3, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
	store   $3, [$sp + 1]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	add     $hp, 2, $hp
	load    [$sp + 1], $10
	mov     $11, $3
	li      120, $2
	store   $10, [$11 + 0]
	call    min_caml_create_array
	load    [$sp + 0], $11
.count move_ret
	mov     $1, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $10, [min_caml_dirvecs + $11]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $12
.count move_ret
	mov     $1, $10
	store   $10, [$12 + 1]
	add     $hp, 2, $hp
	load    [$sp + 2], $10
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $10, [$12 + 0]
	load    [min_caml_dirvecs + $11], $11
	mov     $12, $10
	store   $10, [$11 + 118]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 3]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $12
.count move_ret
	mov     $1, $10
	store   $10, [$12 + 1]
	add     $hp, 2, $hp
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
	store   $3, [$sp + 4]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $15
.count move_ret
	mov     $1, $14
	store   $14, [$15 + 1]
	add     $hp, 2, $hp
	load    [$sp + 4], $14
	li      115, $3
.count move_args
	mov     $11, $2
	store   $14, [$15 + 0]
	mov     $15, $14
	store   $14, [$11 + 116]
	call    create_dirvec_elements.3039
	load    [$sp + 0], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31784
bge_then.31784:
	store   $10, [$sp + 5]
	li      3, $2
.count move_args
	mov     $zero, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 6]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $12
.count move_ret
	mov     $1, $11
	store   $11, [$12 + 1]
	add     $hp, 2, $hp
	load    [$sp + 6], $11
	mov     $12, $3
	li      120, $2
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
	store   $3, [$sp + 7]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $12
.count move_ret
	mov     $1, $11
	store   $11, [$12 + 1]
	add     $hp, 2, $hp
	load    [$sp + 7], $11
	li      3, $2
.count move_args
	mov     $zero, $3
	store   $11, [$12 + 0]
	load    [min_caml_dirvecs + $10], $10
	mov     $12, $11
	store   $11, [$10 + 118]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 8]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $15
.count move_ret
	mov     $1, $14
	store   $14, [$15 + 1]
	add     $hp, 2, $hp
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
	load    [$sp - 4], $1
	sub     $1, 1, $2
	b       create_dirvecs.3042
bge_else.31784:
.count stack_move
	add     $sp, 9, $sp
	ret
bge_else.31783:
	ret
.end create_dirvecs

######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
	cmp     $3, 0
	bl      bge_else.31785
bge_then.31785:
.count stack_move
	sub     $sp, 4, $sp
	sub     $41, 1, $11
	store   $2, [$sp + 0]
	cmp     $11, 0
	store   $3, [$sp + 1]
	load    [$2 + $3], $10
	bl      bge_cont.31786
bge_then.31786:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31787
be_then.31787:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31788
be_then.31788:
	store   $zero, [$16 + 1]
	b       be_cont.31788
be_else.31788:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31789
ble_then.31789:
	li      0, $17
	b       ble_cont.31789
ble_else.31789:
	li      1, $17
ble_cont.31789:
	cmp     $18, 0
	be      bne_cont.31790
bne_then.31790:
	cmp     $17, 0
	bne     be_else.31791
be_then.31791:
	li      1, $17
	b       be_cont.31791
be_else.31791:
	li      0, $17
be_cont.31791:
bne_cont.31790:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31792
be_then.31792:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31792
be_else.31792:
	store   $18, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31792:
be_cont.31788:
	load    [$12 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31793
be_then.31793:
	store   $zero, [$16 + 3]
	b       be_cont.31793
be_else.31793:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31794
ble_then.31794:
	li      0, $17
	b       ble_cont.31794
ble_else.31794:
	li      1, $17
ble_cont.31794:
	cmp     $18, 0
	be      bne_cont.31795
bne_then.31795:
	cmp     $17, 0
	bne     be_else.31796
be_then.31796:
	li      1, $17
	b       be_cont.31796
be_else.31796:
	li      0, $17
be_cont.31796:
bne_cont.31795:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31797
be_then.31797:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31797
be_else.31797:
	store   $18, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31797:
be_cont.31793:
	load    [$12 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31798
be_then.31798:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31787
be_else.31798:
	load    [$13 + 4], $18
	fcmp    $zero, $17
	load    [$18 + 2], $18
	bg      ble_else.31799
ble_then.31799:
	li      0, $17
	b       ble_cont.31799
ble_else.31799:
	li      1, $17
ble_cont.31799:
	load    [$13 + 6], $19
	cmp     $19, 0
	be      bne_cont.31800
bne_then.31800:
	cmp     $17, 0
	bne     be_else.31801
be_then.31801:
	li      1, $17
	b       be_cont.31801
be_else.31801:
	li      0, $17
be_cont.31801:
bne_cont.31800:
	cmp     $17, 0
	bne     be_else.31802
be_then.31802:
	fneg    $18, $17
	b       be_cont.31802
be_else.31802:
	mov     $18, $17
be_cont.31802:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31787
be_else.31787:
	cmp     $14, 2
	bne     be_else.31803
be_then.31803:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$12 + 2], $20
	load    [$13 + 4], $18
	load    [$17 + 2], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$12 + 0], $20
.count storer
	add     $15, $11, $tmp
	fmul    $20, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31804
ble_then.31804:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31803
ble_else.31804:
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
	b       be_cont.31803
be_else.31803:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $21
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	fmul    $21, $21, $22
	load    [$17 + 2], $17
	load    [$18 + 1], $18
	load    [$13 + 4], $19
	load    [$13 + 3], $20
	fmul    $22, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $22
.count move_ret
	mov     $1, $16
	cmp     $20, 0
	fmul    $22, $22, $23
	fmul    $23, $18, $18
	load    [$12 + 0], $23
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	be      bne_cont.31805
bne_then.31805:
	load    [$13 + 9], $19
	fmul    $22, $21, $18
	load    [$19 + 0], $19
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 1], $19
	fmul    $21, $23, $18
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 2], $19
	fmul    $23, $22, $18
	fmul    $18, $19, $18
	fadd    $17, $18, $17
bne_cont.31805:
	store   $17, [$16 + 0]
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $21
	load    [$12 + 2], $22
	load    [$18 + 2], $18
	load    [$12 + 1], $23
	load    [$19 + 1], $19
	load    [$12 + 0], $24
	load    [$21 + 0], $21
	fmul    $22, $18, $18
	fmul    $23, $19, $19
	fmul    $24, $21, $21
	cmp     $20, 0
.count storer
	add     $15, $11, $tmp
	fneg    $18, $18
	fneg    $19, $19
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $21, $21
	bne     be_else.31806
be_then.31806:
	store   $21, [$16 + 1]
	fcmp    $17, $zero
	store   $19, [$16 + 2]
	store   $18, [$16 + 3]
	bne     be_else.31807
be_then.31807:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31806
be_else.31807:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31806
be_else.31806:
	load    [$13 + 9], $24
	load    [$13 + 9], $20
	fcmp    $17, $zero
	load    [$24 + 1], $24
	load    [$20 + 2], $20
	fmul    $22, $24, $22
	fmul    $23, $20, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$16 + 1]
	load    [$12 + 0], $22
	load    [$13 + 9], $21
	fmul    $22, $20, $20
	load    [$21 + 0], $21
	load    [$12 + 2], $22
	fmul    $22, $21, $22
	fadd    $22, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$16 + 2]
	load    [$12 + 1], $20
	load    [$12 + 0], $19
	fmul    $20, $21, $20
	fmul    $19, $24, $19
	fadd    $20, $19, $19
	fmul    $19, $39, $19
	fsub    $18, $19, $18
	store   $18, [$16 + 3]
	bne     be_else.31808
be_then.31808:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31808
be_else.31808:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31808:
be_cont.31806:
be_cont.31803:
be_cont.31787:
bge_cont.31786:
	load    [$sp + 1], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31809
bge_then.31809:
	store   $10, [$sp + 2]
	load    [$sp + 0], $11
	load    [$11 + $10], $10
	sub     $41, 1, $11
	cmp     $11, 0
	bl      bge_cont.31810
bge_then.31810:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31811
be_then.31811:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31812
be_then.31812:
	store   $zero, [$16 + 1]
	b       be_cont.31812
be_else.31812:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31813
ble_then.31813:
	li      0, $17
	b       ble_cont.31813
ble_else.31813:
	li      1, $17
ble_cont.31813:
	cmp     $18, 0
	be      bne_cont.31814
bne_then.31814:
	cmp     $17, 0
	bne     be_else.31815
be_then.31815:
	li      1, $17
	b       be_cont.31815
be_else.31815:
	li      0, $17
be_cont.31815:
bne_cont.31814:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31816
be_then.31816:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31816
be_else.31816:
	store   $18, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31816:
be_cont.31812:
	load    [$12 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31817
be_then.31817:
	store   $zero, [$16 + 3]
	b       be_cont.31817
be_else.31817:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31818
ble_then.31818:
	li      0, $17
	b       ble_cont.31818
ble_else.31818:
	li      1, $17
ble_cont.31818:
	cmp     $18, 0
	be      bne_cont.31819
bne_then.31819:
	cmp     $17, 0
	bne     be_else.31820
be_then.31820:
	li      1, $17
	b       be_cont.31820
be_else.31820:
	li      0, $17
be_cont.31820:
bne_cont.31819:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31821
be_then.31821:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31821
be_else.31821:
	store   $18, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31821:
be_cont.31817:
	load    [$12 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31822
be_then.31822:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31811
be_else.31822:
	load    [$13 + 4], $18
	load    [$13 + 6], $19
	fcmp    $zero, $17
	bg      ble_else.31823
ble_then.31823:
	li      0, $17
	b       ble_cont.31823
ble_else.31823:
	li      1, $17
ble_cont.31823:
	load    [$18 + 2], $18
	cmp     $19, 0
	bne     be_else.31824
be_then.31824:
	cmp     $17, 0
	bne     be_else.31825
be_then.31825:
	fneg    $18, $17
	b       be_cont.31825
be_else.31825:
	mov     $18, $17
be_cont.31825:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31811
be_else.31824:
	cmp     $17, 0
	bne     be_else.31826
be_then.31826:
	li      1, $17
	b       be_cont.31826
be_else.31826:
	li      0, $17
be_cont.31826:
	cmp     $17, 0
	bne     be_else.31827
be_then.31827:
	fneg    $18, $17
	b       be_cont.31827
be_else.31827:
	mov     $18, $17
be_cont.31827:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31811
be_else.31811:
	cmp     $14, 2
	bne     be_else.31828
be_then.31828:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$12 + 2], $20
	load    [$13 + 4], $18
	load    [$17 + 2], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$12 + 0], $20
.count storer
	add     $15, $11, $tmp
	fmul    $20, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31829
ble_then.31829:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31828
ble_else.31829:
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
	b       be_cont.31828
be_else.31828:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $21
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	fmul    $21, $21, $22
	load    [$17 + 2], $17
	load    [$18 + 1], $18
	load    [$13 + 4], $19
	load    [$13 + 3], $20
	fmul    $22, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $22
.count move_ret
	mov     $1, $16
	cmp     $20, 0
	fmul    $22, $22, $23
	fmul    $23, $18, $18
	load    [$12 + 0], $23
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	be      bne_cont.31830
bne_then.31830:
	load    [$13 + 9], $19
	fmul    $22, $21, $18
	load    [$19 + 0], $19
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 1], $19
	fmul    $21, $23, $18
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 2], $19
	fmul    $23, $22, $18
	fmul    $18, $19, $18
	fadd    $17, $18, $17
bne_cont.31830:
	store   $17, [$16 + 0]
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $21
	load    [$12 + 2], $22
	load    [$18 + 2], $18
	load    [$12 + 1], $23
	load    [$19 + 1], $19
	load    [$12 + 0], $24
	load    [$21 + 0], $21
	fmul    $22, $18, $18
	fmul    $23, $19, $19
	fmul    $24, $21, $21
	cmp     $20, 0
.count storer
	add     $15, $11, $tmp
	fneg    $18, $18
	fneg    $19, $19
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $21, $21
	bne     be_else.31831
be_then.31831:
	store   $21, [$16 + 1]
	fcmp    $17, $zero
	store   $19, [$16 + 2]
	store   $18, [$16 + 3]
	bne     be_else.31832
be_then.31832:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31831
be_else.31832:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31831
be_else.31831:
	load    [$13 + 9], $24
	load    [$13 + 9], $20
	fcmp    $17, $zero
	load    [$24 + 1], $24
	load    [$20 + 2], $20
	fmul    $22, $24, $22
	fmul    $23, $20, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$16 + 1]
	load    [$12 + 0], $22
	load    [$13 + 9], $21
	fmul    $22, $20, $20
	load    [$21 + 0], $21
	load    [$12 + 2], $22
	fmul    $22, $21, $22
	fadd    $22, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$16 + 2]
	load    [$12 + 1], $20
	load    [$12 + 0], $19
	fmul    $20, $21, $20
	fmul    $19, $24, $19
	fadd    $20, $19, $19
	fmul    $19, $39, $19
	fsub    $18, $19, $18
	store   $18, [$16 + 3]
	bne     be_else.31833
be_then.31833:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31833
be_else.31833:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31833:
be_cont.31831:
be_cont.31828:
be_cont.31811:
bge_cont.31810:
	load    [$sp + 2], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31834
bge_then.31834:
	load    [$sp + 0], $17
	sub     $41, 1, $3
	load    [$17 + $16], $2
	call    iter_setup_dirvec_constants.2826
	sub     $16, 1, $10
	cmp     $10, 0
	bl      bge_else.31835
bge_then.31835:
	sub     $41, 1, $11
	cmp     $11, 0
	bl      bge_else.31836
bge_then.31836:
	load    [min_caml_objects + $11], $14
	load    [$17 + $10], $12
.count move_args
	mov     $zero, $3
	load    [$14 + 1], $15
	load    [$12 + 1], $16
	load    [$12 + 0], $13
	cmp     $15, 1
	store   $10, [$sp + 3]
	bne     be_else.31837
be_then.31837:
	li      6, $2
	call    min_caml_create_array
	load    [$13 + 0], $19
.count move_ret
	mov     $1, $18
	fcmp    $19, $zero
	bne     be_else.31838
be_then.31838:
	store   $zero, [$18 + 1]
	b       be_cont.31838
be_else.31838:
	load    [$14 + 6], $20
	fcmp    $zero, $19
	bg      ble_else.31839
ble_then.31839:
	li      0, $19
	b       ble_cont.31839
ble_else.31839:
	li      1, $19
ble_cont.31839:
	cmp     $20, 0
	be      bne_cont.31840
bne_then.31840:
	cmp     $19, 0
	bne     be_else.31841
be_then.31841:
	li      1, $19
	b       be_cont.31841
be_else.31841:
	li      0, $19
be_cont.31841:
bne_cont.31840:
	load    [$14 + 4], $20
	cmp     $19, 0
	load    [$20 + 0], $20
	bne     be_else.31842
be_then.31842:
	fneg    $20, $19
	store   $19, [$18 + 0]
	load    [$13 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
	b       be_cont.31842
be_else.31842:
	store   $20, [$18 + 0]
	load    [$13 + 0], $19
	finv    $19, $19
	store   $19, [$18 + 1]
be_cont.31842:
be_cont.31838:
	load    [$13 + 1], $19
	fcmp    $19, $zero
	bne     be_else.31843
be_then.31843:
	store   $zero, [$18 + 3]
	b       be_cont.31843
be_else.31843:
	load    [$14 + 6], $20
	fcmp    $zero, $19
	bg      ble_else.31844
ble_then.31844:
	li      0, $19
	b       ble_cont.31844
ble_else.31844:
	li      1, $19
ble_cont.31844:
	cmp     $20, 0
	be      bne_cont.31845
bne_then.31845:
	cmp     $19, 0
	bne     be_else.31846
be_then.31846:
	li      1, $19
	b       be_cont.31846
be_else.31846:
	li      0, $19
be_cont.31846:
bne_cont.31845:
	load    [$14 + 4], $20
	cmp     $19, 0
	load    [$20 + 1], $20
	bne     be_else.31847
be_then.31847:
	fneg    $20, $19
	store   $19, [$18 + 2]
	load    [$13 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
	b       be_cont.31847
be_else.31847:
	store   $20, [$18 + 2]
	load    [$13 + 1], $19
	finv    $19, $19
	store   $19, [$18 + 3]
be_cont.31847:
be_cont.31843:
	load    [$13 + 2], $19
	fcmp    $19, $zero
	bne     be_else.31848
be_then.31848:
	store   $zero, [$18 + 5]
	b       be_cont.31848
be_else.31848:
	load    [$14 + 4], $20
	load    [$14 + 6], $21
	fcmp    $zero, $19
	bg      ble_else.31849
ble_then.31849:
	li      0, $19
	b       ble_cont.31849
ble_else.31849:
	li      1, $19
ble_cont.31849:
	load    [$20 + 2], $20
	cmp     $21, 0
	bne     be_else.31850
be_then.31850:
	cmp     $19, 0
	bne     be_else.31851
be_then.31851:
	fneg    $20, $19
	store   $19, [$18 + 4]
	load    [$13 + 2], $19
	finv    $19, $19
	store   $19, [$18 + 5]
	b       be_cont.31850
be_else.31851:
	store   $20, [$18 + 4]
	load    [$13 + 2], $19
	finv    $19, $19
	store   $19, [$18 + 5]
	b       be_cont.31850
be_else.31850:
	cmp     $19, 0
	bne     be_else.31852
be_then.31852:
	store   $20, [$18 + 4]
	load    [$13 + 2], $19
	finv    $19, $19
	store   $19, [$18 + 5]
	b       be_cont.31852
be_else.31852:
	fneg    $20, $19
	store   $19, [$18 + 4]
	load    [$13 + 2], $19
	finv    $19, $19
	store   $19, [$18 + 5]
be_cont.31852:
be_cont.31850:
be_cont.31848:
.count storer
	add     $16, $11, $tmp
	sub     $11, 1, $3
	store   $18, [$tmp + 0]
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $17, $2
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
be_else.31837:
	cmp     $15, 2
	bne     be_else.31853
be_then.31853:
	li      4, $2
	call    min_caml_create_array
	load    [$14 + 4], $19
	load    [$13 + 2], $22
	load    [$14 + 4], $20
	load    [$19 + 2], $19
	load    [$14 + 4], $21
	load    [$20 + 1], $20
	fmul    $22, $19, $19
	load    [$21 + 0], $21
	load    [$13 + 1], $22
.count move_ret
	mov     $1, $18
.count storer
	add     $16, $11, $tmp
	fmul    $22, $20, $20
	load    [$13 + 0], $22
	fmul    $22, $21, $21
	fadd    $21, $20, $20
	fadd    $20, $19, $19
	fcmp    $19, $zero
	bg      ble_else.31854
ble_then.31854:
	store   $zero, [$18 + 0]
	store   $18, [$tmp + 0]
	b       be_cont.31853
ble_else.31854:
	finv    $19, $19
	fneg    $19, $20
	store   $20, [$18 + 0]
	load    [$14 + 4], $20
	load    [$20 + 0], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 1]
	load    [$14 + 4], $20
	load    [$20 + 1], $20
	fmul    $20, $19, $20
	fneg    $20, $20
	store   $20, [$18 + 2]
	load    [$14 + 4], $20
	load    [$20 + 2], $20
	fmul    $20, $19, $19
	fneg    $19, $19
	store   $19, [$18 + 3]
	store   $18, [$tmp + 0]
	b       be_cont.31853
be_else.31853:
	li      5, $2
	call    min_caml_create_array
	load    [$13 + 2], $23
	load    [$14 + 4], $19
	load    [$14 + 4], $20
	fmul    $23, $23, $24
	load    [$19 + 2], $19
	load    [$20 + 1], $20
	load    [$14 + 4], $21
	load    [$14 + 3], $22
	fmul    $24, $19, $19
	load    [$21 + 0], $21
	load    [$13 + 1], $24
.count move_ret
	mov     $1, $18
	cmp     $22, 0
	fmul    $24, $24, $25
	fmul    $25, $20, $20
	load    [$13 + 0], $25
	fmul    $25, $25, $26
	fmul    $26, $21, $21
	fadd    $21, $20, $20
	fadd    $20, $19, $19
	be      bne_cont.31855
bne_then.31855:
	load    [$14 + 9], $21
	fmul    $24, $23, $20
	load    [$21 + 0], $21
	fmul    $20, $21, $20
	load    [$14 + 9], $21
	fadd    $19, $20, $19
	load    [$21 + 1], $21
	fmul    $23, $25, $20
	fmul    $20, $21, $20
	load    [$14 + 9], $21
	fadd    $19, $20, $19
	load    [$21 + 2], $21
	fmul    $25, $24, $20
	fmul    $20, $21, $20
	fadd    $19, $20, $19
bne_cont.31855:
	store   $19, [$18 + 0]
	load    [$14 + 4], $20
	load    [$14 + 4], $21
	load    [$14 + 4], $23
	load    [$13 + 2], $24
	load    [$20 + 2], $20
	load    [$13 + 1], $25
	load    [$21 + 1], $21
	load    [$13 + 0], $26
	load    [$23 + 0], $23
	fmul    $24, $20, $20
	fmul    $25, $21, $21
	fmul    $26, $23, $23
	cmp     $22, 0
.count storer
	add     $16, $11, $tmp
	fneg    $20, $20
	fneg    $21, $21
	fneg    $23, $23
	bne     be_else.31856
be_then.31856:
	store   $23, [$18 + 1]
	fcmp    $19, $zero
	store   $21, [$18 + 2]
	store   $20, [$18 + 3]
	bne     be_else.31857
be_then.31857:
	store   $18, [$tmp + 0]
	b       be_cont.31856
be_else.31857:
	finv    $19, $19
	store   $19, [$18 + 4]
	store   $18, [$tmp + 0]
	b       be_cont.31856
be_else.31856:
	load    [$14 + 9], $26
	load    [$14 + 9], $22
	fcmp    $19, $zero
	load    [$26 + 1], $26
	load    [$22 + 2], $22
	fmul    $24, $26, $24
	fmul    $25, $22, $25
	fadd    $24, $25, $24
	fmul    $24, $39, $24
	fsub    $23, $24, $23
	store   $23, [$18 + 1]
	load    [$13 + 0], $24
	load    [$14 + 9], $23
	fmul    $24, $22, $22
	load    [$23 + 0], $23
	load    [$13 + 2], $24
	fmul    $24, $23, $24
	fadd    $24, $22, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$18 + 2]
	load    [$13 + 1], $22
	load    [$13 + 0], $21
	fmul    $22, $23, $22
	fmul    $21, $26, $21
	fadd    $22, $21, $21
	fmul    $21, $39, $21
	fsub    $20, $21, $20
	store   $20, [$18 + 3]
	bne     be_else.31858
be_then.31858:
	store   $18, [$tmp + 0]
	b       be_cont.31858
be_else.31858:
	finv    $19, $19
	store   $19, [$18 + 4]
	store   $18, [$tmp + 0]
be_cont.31858:
be_cont.31856:
be_cont.31853:
	sub     $11, 1, $3
.count move_args
	mov     $12, $2
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 4, $sp
.count move_args
	mov     $17, $2
	load    [$sp - 1], $1
	sub     $1, 1, $3
	b       init_dirvec_constants.3044
bge_else.31836:
.count stack_move
	add     $sp, 4, $sp
	sub     $10, 1, $3
.count move_args
	mov     $17, $2
	b       init_dirvec_constants.3044
bge_else.31835:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31834:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31809:
.count stack_move
	add     $sp, 4, $sp
	ret
bge_else.31785:
	ret
.end init_dirvec_constants

######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
	cmp     $2, 0
	bl      bge_else.31859
bge_then.31859:
.count stack_move
	sub     $sp, 5, $sp
	sub     $41, 1, $11
	store   $2, [$sp + 0]
	load    [min_caml_dirvecs + $2], $10
	cmp     $11, 0
	store   $10, [$sp + 1]
	load    [$10 + 119], $10
	bl      bge_cont.31860
bge_then.31860:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31861
be_then.31861:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31862
be_then.31862:
	store   $zero, [$16 + 1]
	b       be_cont.31862
be_else.31862:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31863
ble_then.31863:
	li      0, $17
	b       ble_cont.31863
ble_else.31863:
	li      1, $17
ble_cont.31863:
	cmp     $18, 0
	be      bne_cont.31864
bne_then.31864:
	cmp     $17, 0
	bne     be_else.31865
be_then.31865:
	li      1, $17
	b       be_cont.31865
be_else.31865:
	li      0, $17
be_cont.31865:
bne_cont.31864:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31866
be_then.31866:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31866
be_else.31866:
	store   $18, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31866:
be_cont.31862:
	load    [$12 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31867
be_then.31867:
	store   $zero, [$16 + 3]
	b       be_cont.31867
be_else.31867:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31868
ble_then.31868:
	li      0, $17
	b       ble_cont.31868
ble_else.31868:
	li      1, $17
ble_cont.31868:
	cmp     $18, 0
	be      bne_cont.31869
bne_then.31869:
	cmp     $17, 0
	bne     be_else.31870
be_then.31870:
	li      1, $17
	b       be_cont.31870
be_else.31870:
	li      0, $17
be_cont.31870:
bne_cont.31869:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31871
be_then.31871:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31871
be_else.31871:
	store   $18, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31871:
be_cont.31867:
	load    [$12 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31872
be_then.31872:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31861
be_else.31872:
	load    [$13 + 4], $18
	load    [$13 + 6], $19
	fcmp    $zero, $17
	bg      ble_else.31873
ble_then.31873:
	li      0, $17
	b       ble_cont.31873
ble_else.31873:
	li      1, $17
ble_cont.31873:
	load    [$18 + 2], $18
	cmp     $19, 0
	bne     be_else.31874
be_then.31874:
	cmp     $17, 0
	bne     be_else.31875
be_then.31875:
	fneg    $18, $17
	b       be_cont.31875
be_else.31875:
	mov     $18, $17
be_cont.31875:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31861
be_else.31874:
	cmp     $17, 0
	bne     be_else.31876
be_then.31876:
	li      1, $17
	b       be_cont.31876
be_else.31876:
	li      0, $17
be_cont.31876:
	cmp     $17, 0
	bne     be_else.31877
be_then.31877:
	fneg    $18, $17
	b       be_cont.31877
be_else.31877:
	mov     $18, $17
be_cont.31877:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31861
be_else.31861:
	cmp     $14, 2
	bne     be_else.31878
be_then.31878:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$12 + 2], $20
	load    [$13 + 4], $18
	load    [$17 + 2], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$12 + 0], $20
.count storer
	add     $15, $11, $tmp
	fmul    $20, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31879
ble_then.31879:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31878
ble_else.31879:
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
	b       be_cont.31878
be_else.31878:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $21
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	fmul    $21, $21, $22
	load    [$17 + 2], $17
	load    [$18 + 1], $18
	load    [$13 + 4], $19
	load    [$13 + 3], $20
	fmul    $22, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $22
.count move_ret
	mov     $1, $16
	cmp     $20, 0
	fmul    $22, $22, $23
	fmul    $23, $18, $18
	load    [$12 + 0], $23
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	be      bne_cont.31880
bne_then.31880:
	load    [$13 + 9], $19
	fmul    $22, $21, $18
	load    [$19 + 0], $19
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 1], $19
	fmul    $21, $23, $18
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 2], $19
	fmul    $23, $22, $18
	fmul    $18, $19, $18
	fadd    $17, $18, $17
bne_cont.31880:
	store   $17, [$16 + 0]
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $21
	load    [$12 + 2], $22
	load    [$18 + 2], $18
	load    [$12 + 1], $23
	load    [$19 + 1], $19
	load    [$12 + 0], $24
	load    [$21 + 0], $21
	fmul    $22, $18, $18
	fmul    $23, $19, $19
	fmul    $24, $21, $21
	cmp     $20, 0
.count storer
	add     $15, $11, $tmp
	fneg    $18, $18
	fneg    $19, $19
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $21, $21
	bne     be_else.31881
be_then.31881:
	store   $21, [$16 + 1]
	fcmp    $17, $zero
	store   $19, [$16 + 2]
	store   $18, [$16 + 3]
	bne     be_else.31882
be_then.31882:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31881
be_else.31882:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31881
be_else.31881:
	load    [$13 + 9], $24
	load    [$13 + 9], $20
	fcmp    $17, $zero
	load    [$24 + 1], $24
	load    [$20 + 2], $20
	fmul    $22, $24, $22
	fmul    $23, $20, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$16 + 1]
	load    [$12 + 0], $22
	load    [$13 + 9], $21
	fmul    $22, $20, $20
	load    [$21 + 0], $21
	load    [$12 + 2], $22
	fmul    $22, $21, $22
	fadd    $22, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$16 + 2]
	load    [$12 + 1], $20
	load    [$12 + 0], $19
	fmul    $20, $21, $20
	fmul    $19, $24, $19
	fadd    $20, $19, $19
	fmul    $19, $39, $19
	fsub    $18, $19, $18
	store   $18, [$16 + 3]
	bne     be_else.31883
be_then.31883:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31883
be_else.31883:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31883:
be_cont.31881:
be_cont.31878:
be_cont.31861:
bge_cont.31860:
	load    [$sp + 1], $16
	sub     $41, 1, $3
	load    [$16 + 118], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $11
	load    [$16 + 117], $10
	cmp     $11, 0
	bl      bge_cont.31884
bge_then.31884:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31885
be_then.31885:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $18
.count move_ret
	mov     $1, $17
	fcmp    $18, $zero
	bne     be_else.31886
be_then.31886:
	store   $zero, [$17 + 1]
	b       be_cont.31886
be_else.31886:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31887
ble_then.31887:
	li      0, $18
	b       ble_cont.31887
ble_else.31887:
	li      1, $18
ble_cont.31887:
	cmp     $19, 0
	be      bne_cont.31888
bne_then.31888:
	cmp     $18, 0
	bne     be_else.31889
be_then.31889:
	li      1, $18
	b       be_cont.31889
be_else.31889:
	li      0, $18
be_cont.31889:
bne_cont.31888:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 0], $19
	bne     be_else.31890
be_then.31890:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$12 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
	b       be_cont.31890
be_else.31890:
	store   $19, [$17 + 0]
	load    [$12 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31890:
be_cont.31886:
	load    [$12 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31891
be_then.31891:
	store   $zero, [$17 + 3]
	b       be_cont.31891
be_else.31891:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31892
ble_then.31892:
	li      0, $18
	b       ble_cont.31892
ble_else.31892:
	li      1, $18
ble_cont.31892:
	cmp     $19, 0
	be      bne_cont.31893
bne_then.31893:
	cmp     $18, 0
	bne     be_else.31894
be_then.31894:
	li      1, $18
	b       be_cont.31894
be_else.31894:
	li      0, $18
be_cont.31894:
bne_cont.31893:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 1], $19
	bne     be_else.31895
be_then.31895:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$12 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
	b       be_cont.31895
be_else.31895:
	store   $19, [$17 + 2]
	load    [$12 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31895:
be_cont.31891:
	load    [$12 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31896
be_then.31896:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$17 + 5]
	sub     $11, 1, $3
	store   $17, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31885
be_else.31896:
	load    [$13 + 4], $19
	load    [$13 + 6], $20
	fcmp    $zero, $18
	bg      ble_else.31897
ble_then.31897:
	li      0, $18
	b       ble_cont.31897
ble_else.31897:
	li      1, $18
ble_cont.31897:
	load    [$19 + 2], $19
	cmp     $20, 0
	bne     be_else.31898
be_then.31898:
	cmp     $18, 0
	bne     be_else.31899
be_then.31899:
	fneg    $19, $18
	b       be_cont.31899
be_else.31899:
	mov     $19, $18
be_cont.31899:
	store   $18, [$17 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $18
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31885
be_else.31898:
	cmp     $18, 0
	bne     be_else.31900
be_then.31900:
	li      1, $18
	b       be_cont.31900
be_else.31900:
	li      0, $18
be_cont.31900:
	cmp     $18, 0
	bne     be_else.31901
be_then.31901:
	fneg    $19, $18
	b       be_cont.31901
be_else.31901:
	mov     $19, $18
be_cont.31901:
	store   $18, [$17 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $18
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31885
be_else.31885:
	cmp     $14, 2
	bne     be_else.31902
be_then.31902:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $18
	load    [$12 + 2], $21
	load    [$13 + 4], $19
	load    [$18 + 2], $18
	load    [$13 + 4], $20
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$20 + 0], $20
	load    [$12 + 1], $21
.count move_ret
	mov     $1, $17
.count move_args
	mov     $10, $2
	fmul    $21, $19, $19
	sub     $11, 1, $3
	load    [$12 + 0], $21
.count storer
	add     $15, $11, $tmp
	fmul    $21, $20, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	fcmp    $18, $zero
	bg      ble_else.31903
ble_then.31903:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31902
ble_else.31903:
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
	b       be_cont.31902
be_else.31902:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $22
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	fmul    $22, $22, $23
	load    [$18 + 2], $18
	load    [$19 + 1], $19
	load    [$13 + 4], $20
	load    [$13 + 3], $21
	fmul    $23, $18, $18
	load    [$20 + 0], $20
	load    [$12 + 1], $23
.count move_ret
	mov     $1, $17
	cmp     $21, 0
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	load    [$12 + 0], $24
	fmul    $24, $24, $25
	fmul    $25, $20, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	be      bne_cont.31904
bne_then.31904:
	load    [$13 + 9], $20
	fmul    $23, $22, $19
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	load    [$13 + 9], $20
	fadd    $18, $19, $18
	load    [$20 + 1], $20
	fmul    $22, $24, $19
	fmul    $19, $20, $19
	load    [$13 + 9], $20
	fadd    $18, $19, $18
	load    [$20 + 2], $20
	fmul    $24, $23, $19
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31904:
	store   $18, [$17 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $22
	load    [$12 + 2], $23
	load    [$19 + 2], $19
	load    [$12 + 1], $24
	load    [$20 + 1], $20
	load    [$12 + 0], $25
	load    [$22 + 0], $22
	fmul    $23, $19, $19
	fmul    $24, $20, $20
	fmul    $25, $22, $22
	cmp     $21, 0
.count storer
	add     $15, $11, $tmp
	fneg    $19, $19
	fneg    $20, $20
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $22, $22
	bne     be_else.31905
be_then.31905:
	store   $22, [$17 + 1]
	fcmp    $18, $zero
	store   $20, [$17 + 2]
	store   $19, [$17 + 3]
	bne     be_else.31906
be_then.31906:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31905
be_else.31906:
	finv    $18, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31905
be_else.31905:
	load    [$13 + 9], $25
	load    [$13 + 9], $21
	fcmp    $18, $zero
	load    [$25 + 1], $25
	load    [$21 + 2], $21
	fmul    $23, $25, $23
	fmul    $24, $21, $24
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $22, $23, $22
	store   $22, [$17 + 1]
	load    [$12 + 0], $23
	load    [$13 + 9], $22
	fmul    $23, $21, $21
	load    [$22 + 0], $22
	load    [$12 + 2], $23
	fmul    $23, $22, $23
	fadd    $23, $21, $21
	fmul    $21, $39, $21
	fsub    $20, $21, $20
	store   $20, [$17 + 2]
	load    [$12 + 1], $21
	load    [$12 + 0], $20
	fmul    $21, $22, $21
	fmul    $20, $25, $20
	fadd    $21, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$17 + 3]
	bne     be_else.31907
be_then.31907:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31907
be_else.31907:
	finv    $18, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31907:
be_cont.31905:
be_cont.31902:
be_cont.31885:
bge_cont.31884:
	li      116, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
	load    [$sp + 0], $16
	sub     $16, 1, $16
	cmp     $16, 0
	bl      bge_else.31908
bge_then.31908:
	store   $16, [$sp + 2]
	sub     $41, 1, $3
	load    [min_caml_dirvecs + $16], $16
	load    [$16 + 119], $2
	call    iter_setup_dirvec_constants.2826
	sub     $41, 1, $11
	load    [$16 + 118], $10
	cmp     $11, 0
	bl      bge_cont.31909
bge_then.31909:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31910
be_then.31910:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $18
.count move_ret
	mov     $1, $17
	fcmp    $18, $zero
	bne     be_else.31911
be_then.31911:
	store   $zero, [$17 + 1]
	b       be_cont.31911
be_else.31911:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31912
ble_then.31912:
	li      0, $18
	b       ble_cont.31912
ble_else.31912:
	li      1, $18
ble_cont.31912:
	cmp     $19, 0
	be      bne_cont.31913
bne_then.31913:
	cmp     $18, 0
	bne     be_else.31914
be_then.31914:
	li      1, $18
	b       be_cont.31914
be_else.31914:
	li      0, $18
be_cont.31914:
bne_cont.31913:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 0], $19
	bne     be_else.31915
be_then.31915:
	fneg    $19, $18
	store   $18, [$17 + 0]
	load    [$12 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
	b       be_cont.31915
be_else.31915:
	store   $19, [$17 + 0]
	load    [$12 + 0], $18
	finv    $18, $18
	store   $18, [$17 + 1]
be_cont.31915:
be_cont.31911:
	load    [$12 + 1], $18
	fcmp    $18, $zero
	bne     be_else.31916
be_then.31916:
	store   $zero, [$17 + 3]
	b       be_cont.31916
be_else.31916:
	load    [$13 + 6], $19
	fcmp    $zero, $18
	bg      ble_else.31917
ble_then.31917:
	li      0, $18
	b       ble_cont.31917
ble_else.31917:
	li      1, $18
ble_cont.31917:
	cmp     $19, 0
	be      bne_cont.31918
bne_then.31918:
	cmp     $18, 0
	bne     be_else.31919
be_then.31919:
	li      1, $18
	b       be_cont.31919
be_else.31919:
	li      0, $18
be_cont.31919:
bne_cont.31918:
	load    [$13 + 4], $19
	cmp     $18, 0
	load    [$19 + 1], $19
	bne     be_else.31920
be_then.31920:
	fneg    $19, $18
	store   $18, [$17 + 2]
	load    [$12 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
	b       be_cont.31920
be_else.31920:
	store   $19, [$17 + 2]
	load    [$12 + 1], $18
	finv    $18, $18
	store   $18, [$17 + 3]
be_cont.31920:
be_cont.31916:
	load    [$12 + 2], $18
	fcmp    $18, $zero
	bne     be_else.31921
be_then.31921:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$17 + 5]
	sub     $11, 1, $3
	store   $17, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31910
be_else.31921:
	load    [$13 + 4], $19
	load    [$13 + 6], $20
	fcmp    $zero, $18
	bg      ble_else.31922
ble_then.31922:
	li      0, $18
	b       ble_cont.31922
ble_else.31922:
	li      1, $18
ble_cont.31922:
	load    [$19 + 2], $19
	cmp     $20, 0
	bne     be_else.31923
be_then.31923:
	cmp     $18, 0
	bne     be_else.31924
be_then.31924:
	fneg    $19, $18
	b       be_cont.31924
be_else.31924:
	mov     $19, $18
be_cont.31924:
	store   $18, [$17 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $18
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31910
be_else.31923:
	cmp     $18, 0
	bne     be_else.31925
be_then.31925:
	li      1, $18
	b       be_cont.31925
be_else.31925:
	li      0, $18
be_cont.31925:
	cmp     $18, 0
	bne     be_else.31926
be_then.31926:
	fneg    $19, $18
	b       be_cont.31926
be_else.31926:
	mov     $19, $18
be_cont.31926:
	store   $18, [$17 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $18
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $18, $18
	store   $18, [$17 + 5]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31910
be_else.31910:
	cmp     $14, 2
	bne     be_else.31927
be_then.31927:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $18
	load    [$12 + 2], $21
	load    [$13 + 4], $19
	load    [$18 + 2], $18
	load    [$13 + 4], $20
	load    [$19 + 1], $19
	fmul    $21, $18, $18
	load    [$20 + 0], $20
	load    [$12 + 1], $21
.count move_ret
	mov     $1, $17
.count move_args
	mov     $10, $2
	fmul    $21, $19, $19
	sub     $11, 1, $3
	load    [$12 + 0], $21
.count storer
	add     $15, $11, $tmp
	fmul    $21, $20, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	fcmp    $18, $zero
	bg      ble_else.31928
ble_then.31928:
	store   $zero, [$17 + 0]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31927
ble_else.31928:
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
	b       be_cont.31927
be_else.31927:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $22
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	fmul    $22, $22, $23
	load    [$18 + 2], $18
	load    [$19 + 1], $19
	load    [$13 + 4], $20
	load    [$13 + 3], $21
	fmul    $23, $18, $18
	load    [$20 + 0], $20
	load    [$12 + 1], $23
.count move_ret
	mov     $1, $17
	cmp     $21, 0
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	load    [$12 + 0], $24
	fmul    $24, $24, $25
	fmul    $25, $20, $20
	fadd    $20, $19, $19
	fadd    $19, $18, $18
	be      bne_cont.31929
bne_then.31929:
	load    [$13 + 9], $20
	fmul    $23, $22, $19
	load    [$20 + 0], $20
	fmul    $19, $20, $19
	load    [$13 + 9], $20
	fadd    $18, $19, $18
	load    [$20 + 1], $20
	fmul    $22, $24, $19
	fmul    $19, $20, $19
	load    [$13 + 9], $20
	fadd    $18, $19, $18
	load    [$20 + 2], $20
	fmul    $24, $23, $19
	fmul    $19, $20, $19
	fadd    $18, $19, $18
bne_cont.31929:
	store   $18, [$17 + 0]
	load    [$13 + 4], $19
	load    [$13 + 4], $20
	load    [$13 + 4], $22
	load    [$12 + 2], $23
	load    [$19 + 2], $19
	load    [$12 + 1], $24
	load    [$20 + 1], $20
	load    [$12 + 0], $25
	load    [$22 + 0], $22
	fmul    $23, $19, $19
	fmul    $24, $20, $20
	fmul    $25, $22, $22
	cmp     $21, 0
.count storer
	add     $15, $11, $tmp
	fneg    $19, $19
	fneg    $20, $20
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $22, $22
	bne     be_else.31930
be_then.31930:
	store   $22, [$17 + 1]
	fcmp    $18, $zero
	store   $20, [$17 + 2]
	store   $19, [$17 + 3]
	bne     be_else.31931
be_then.31931:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31930
be_else.31931:
	finv    $18, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31930
be_else.31930:
	load    [$13 + 9], $25
	load    [$13 + 9], $21
	fcmp    $18, $zero
	load    [$25 + 1], $25
	load    [$21 + 2], $21
	fmul    $23, $25, $23
	fmul    $24, $21, $24
	fadd    $23, $24, $23
	fmul    $23, $39, $23
	fsub    $22, $23, $22
	store   $22, [$17 + 1]
	load    [$12 + 0], $23
	load    [$13 + 9], $22
	fmul    $23, $21, $21
	load    [$22 + 0], $22
	load    [$12 + 2], $23
	fmul    $23, $22, $23
	fadd    $23, $21, $21
	fmul    $21, $39, $21
	fsub    $20, $21, $20
	store   $20, [$17 + 2]
	load    [$12 + 1], $21
	load    [$12 + 0], $20
	fmul    $21, $22, $21
	fmul    $20, $25, $20
	fadd    $21, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$17 + 3]
	bne     be_else.31932
be_then.31932:
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31932
be_else.31932:
	finv    $18, $18
	store   $18, [$17 + 4]
	store   $17, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31932:
be_cont.31930:
be_cont.31927:
be_cont.31910:
bge_cont.31909:
	li      117, $3
.count move_args
	mov     $16, $2
	call    init_dirvec_constants.3044
	load    [$sp + 2], $10
	sub     $10, 1, $10
	cmp     $10, 0
	bl      bge_else.31933
bge_then.31933:
	store   $10, [$sp + 3]
	sub     $41, 1, $11
	load    [min_caml_dirvecs + $10], $10
	cmp     $11, 0
	store   $10, [$sp + 4]
	load    [$10 + 119], $10
	bl      bge_cont.31934
bge_then.31934:
	load    [min_caml_objects + $11], $13
	load    [$10 + 0], $12
	load    [$10 + 1], $15
	load    [$13 + 1], $14
.count move_args
	mov     $zero, $3
	cmp     $14, 1
	bne     be_else.31935
be_then.31935:
	li      6, $2
	call    min_caml_create_array
	load    [$12 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31936
be_then.31936:
	store   $zero, [$16 + 1]
	b       be_cont.31936
be_else.31936:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31937
ble_then.31937:
	li      0, $17
	b       ble_cont.31937
ble_else.31937:
	li      1, $17
ble_cont.31937:
	cmp     $18, 0
	be      bne_cont.31938
bne_then.31938:
	cmp     $17, 0
	bne     be_else.31939
be_then.31939:
	li      1, $17
	b       be_cont.31939
be_else.31939:
	li      0, $17
be_cont.31939:
bne_cont.31938:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31940
be_then.31940:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31940
be_else.31940:
	store   $18, [$16 + 0]
	load    [$12 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31940:
be_cont.31936:
	load    [$12 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31941
be_then.31941:
	store   $zero, [$16 + 3]
	b       be_cont.31941
be_else.31941:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31942
ble_then.31942:
	li      0, $17
	b       ble_cont.31942
ble_else.31942:
	li      1, $17
ble_cont.31942:
	cmp     $18, 0
	be      bne_cont.31943
bne_then.31943:
	cmp     $17, 0
	bne     be_else.31944
be_then.31944:
	li      1, $17
	b       be_cont.31944
be_else.31944:
	li      0, $17
be_cont.31944:
bne_cont.31943:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31945
be_then.31945:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31945
be_else.31945:
	store   $18, [$16 + 2]
	load    [$12 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31945:
be_cont.31941:
	load    [$12 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31946
be_then.31946:
.count storer
	add     $15, $11, $tmp
	store   $zero, [$16 + 5]
	sub     $11, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31935
be_else.31946:
	load    [$13 + 4], $18
	load    [$13 + 6], $19
	fcmp    $zero, $17
	bg      ble_else.31947
ble_then.31947:
	li      0, $17
	b       ble_cont.31947
ble_else.31947:
	li      1, $17
ble_cont.31947:
	load    [$18 + 2], $18
	cmp     $19, 0
	bne     be_else.31948
be_then.31948:
	cmp     $17, 0
	bne     be_else.31949
be_then.31949:
	fneg    $18, $17
	b       be_cont.31949
be_else.31949:
	mov     $18, $17
be_cont.31949:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31935
be_else.31948:
	cmp     $17, 0
	bne     be_else.31950
be_then.31950:
	li      1, $17
	b       be_cont.31950
be_else.31950:
	li      0, $17
be_cont.31950:
	cmp     $17, 0
	bne     be_else.31951
be_then.31951:
	fneg    $18, $17
	b       be_cont.31951
be_else.31951:
	mov     $18, $17
be_cont.31951:
	store   $17, [$16 + 4]
.count storer
	add     $15, $11, $tmp
	load    [$12 + 2], $17
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31935
be_else.31935:
	cmp     $14, 2
	bne     be_else.31952
be_then.31952:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$12 + 2], $20
	load    [$13 + 4], $18
	load    [$17 + 2], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $11, 1, $3
	load    [$12 + 0], $20
.count storer
	add     $15, $11, $tmp
	fmul    $20, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31953
ble_then.31953:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31952
ble_else.31953:
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
	b       be_cont.31952
be_else.31952:
	li      5, $2
	call    min_caml_create_array
	load    [$12 + 2], $21
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	fmul    $21, $21, $22
	load    [$17 + 2], $17
	load    [$18 + 1], $18
	load    [$13 + 4], $19
	load    [$13 + 3], $20
	fmul    $22, $17, $17
	load    [$19 + 0], $19
	load    [$12 + 1], $22
.count move_ret
	mov     $1, $16
	cmp     $20, 0
	fmul    $22, $22, $23
	fmul    $23, $18, $18
	load    [$12 + 0], $23
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	be      bne_cont.31954
bne_then.31954:
	load    [$13 + 9], $19
	fmul    $22, $21, $18
	load    [$19 + 0], $19
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 1], $19
	fmul    $21, $23, $18
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 2], $19
	fmul    $23, $22, $18
	fmul    $18, $19, $18
	fadd    $17, $18, $17
bne_cont.31954:
	store   $17, [$16 + 0]
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $21
	load    [$12 + 2], $22
	load    [$18 + 2], $18
	load    [$12 + 1], $23
	load    [$19 + 1], $19
	load    [$12 + 0], $24
	load    [$21 + 0], $21
	fmul    $22, $18, $18
	fmul    $23, $19, $19
	fmul    $24, $21, $21
	cmp     $20, 0
.count storer
	add     $15, $11, $tmp
	fneg    $18, $18
	fneg    $19, $19
	sub     $11, 1, $3
.count move_args
	mov     $10, $2
	fneg    $21, $21
	bne     be_else.31955
be_then.31955:
	store   $21, [$16 + 1]
	fcmp    $17, $zero
	store   $19, [$16 + 2]
	store   $18, [$16 + 3]
	bne     be_else.31956
be_then.31956:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31955
be_else.31956:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31955
be_else.31955:
	load    [$13 + 9], $24
	load    [$13 + 9], $20
	fcmp    $17, $zero
	load    [$24 + 1], $24
	load    [$20 + 2], $20
	fmul    $22, $24, $22
	fmul    $23, $20, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$16 + 1]
	load    [$12 + 0], $22
	load    [$13 + 9], $21
	fmul    $22, $20, $20
	load    [$21 + 0], $21
	load    [$12 + 2], $22
	fmul    $22, $21, $22
	fadd    $22, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$16 + 2]
	load    [$12 + 1], $20
	load    [$12 + 0], $19
	fmul    $20, $21, $20
	fmul    $19, $24, $19
	fadd    $20, $19, $19
	fmul    $19, $39, $19
	fsub    $18, $19, $18
	store   $18, [$16 + 3]
	bne     be_else.31957
be_then.31957:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31957
be_else.31957:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.31957:
be_cont.31955:
be_cont.31952:
be_cont.31935:
bge_cont.31934:
	li      118, $3
	load    [$sp + 4], $2
	call    init_dirvec_constants.3044
	load    [$sp + 3], $27
	sub     $27, 1, $27
	cmp     $27, 0
	bl      bge_else.31958
bge_then.31958:
	li      119, $3
	load    [min_caml_dirvecs + $27], $2
	call    init_dirvec_constants.3044
.count stack_move
	add     $sp, 5, $sp
	sub     $27, 1, $2
	b       init_vecset_constants.3047
bge_else.31958:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31933:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31908:
.count stack_move
	add     $sp, 5, $sp
	ret
bge_else.31859:
	ret
.end init_vecset_constants

######################################################################
.begin setup_reflections
setup_reflections.3064:
	cmp     $2, 0
	bl      bge_else.31959
bge_then.31959:
	load    [min_caml_objects + $2], $10
	load    [$10 + 2], $11
	cmp     $11, 2
	bne     be_else.31960
be_then.31960:
	load    [$10 + 7], $11
	load    [$11 + 0], $11
	fcmp    $36, $11
	bg      ble_else.31961
ble_then.31961:
	ret
ble_else.31961:
	load    [$10 + 1], $12
	cmp     $12, 1
	bne     be_else.31962
be_then.31962:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
	store   $2, [$sp + 0]
	load    [$10 + 7], $10
	li      3, $2
	store   $10, [$sp + 1]
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	mov     $10, $3
	store   $3, [$sp + 2]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
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
	store   $2, [$sp + 3]
	call    iter_setup_dirvec_constants.2826
	load    [min_caml_n_reflections + 0], $10
	mov     $hp, $13
	li      3, $2
	store   $10, [$sp + 4]
	load    [$sp + 1], $11
	add     $hp, 3, $hp
.count move_args
	mov     $zero, $3
	load    [$11 + 0], $11
	fsub    $36, $11, $11
	store   $11, [$sp + 5]
	load    [$sp + 0], $12
	sll     $12, 2, $12
	store   $12, [$sp + 6]
	store   $11, [$13 + 2]
	add     $12, 1, $12
	load    [$sp + 3], $11
	store   $11, [$13 + 1]
	store   $12, [$13 + 0]
	mov     $13, $11
	store   $11, [min_caml_reflections + $10]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 7]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
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
	store   $2, [$sp + 8]
	call    iter_setup_dirvec_constants.2826
	load    [$sp + 5], $12
	load    [$sp + 6], $10
	mov     $hp, $11
	store   $12, [$11 + 2]
	add     $10, 2, $10
	load    [$sp + 8], $12
	add     $hp, 3, $hp
	li      3, $2
	store   $12, [$11 + 1]
.count move_args
	mov     $zero, $3
	store   $10, [$11 + 0]
	mov     $11, $10
	load    [$sp + 4], $11
	add     $11, 1, $11
	store   $10, [min_caml_reflections + $11]
	call    min_caml_create_array
.count move_ret
	mov     $1, $3
	store   $3, [$sp + 9]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
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
	store   $2, [$sp + 10]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
	mov     $hp, $2
	load    [$sp - 9], $3
	load    [$sp - 8], $1
	add     $hp, 3, $hp
	store   $3, [$2 + 2]
	add     $1, 3, $1
	load    [$sp - 4], $3
	store   $3, [$2 + 1]
	store   $1, [$2 + 0]
	mov     $2, $1
	load    [$sp - 10], $2
	add     $2, 2, $3
	store   $1, [min_caml_reflections + $3]
	add     $2, 3, $1
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.31962:
	cmp     $12, 2
	bne     be_else.31963
be_then.31963:
.count stack_move
	sub     $sp, 14, $sp
.count move_args
	mov     $zero, $3
	store   $11, [$sp + 11]
	store   $2, [$sp + 0]
	load    [$10 + 4], $10
	li      3, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	mov     $11, $3
	store   $3, [$sp + 12]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	load    [$10 + 1], $19
	load    [$10 + 0], $21
	load    [$10 + 2], $17
	fmul    $56, $19, $20
	fmul    $55, $21, $22
	fmul    $57, $17, $18
.count move_ret
	mov     $1, $16
	sub     $41, 1, $3
	fadd    $22, $20, $20
	load    [$sp + 12], $22
	fadd    $20, $18, $18
.count load_float
	load    [f.27177], $20
	fmul    $20, $21, $21
	fmul    $20, $19, $19
	fmul    $20, $17, $17
	fmul    $21, $18, $21
	fmul    $19, $18, $19
	fmul    $17, $18, $17
	fsub    $21, $55, $21
	fsub    $19, $56, $19
	fsub    $17, $57, $17
	store   $21, [$22 + 0]
	store   $19, [$22 + 1]
	store   $17, [$22 + 2]
	mov     $hp, $17
	store   $16, [$17 + 1]
	mov     $17, $2
	store   $22, [$17 + 0]
	add     $hp, 2, $hp
	store   $2, [$sp + 13]
	call    iter_setup_dirvec_constants.2826
.count stack_move
	add     $sp, 14, $sp
	load    [min_caml_n_reflections + 0], $1
	load    [$sp - 3], $3
	load    [$sp - 14], $2
	mov     $hp, $4
	fsub    $36, $3, $3
	sll     $2, 2, $2
	add     $hp, 3, $hp
	add     $2, 1, $2
	store   $3, [$4 + 2]
	load    [$sp - 1], $3
	store   $3, [$4 + 1]
	store   $2, [$4 + 0]
	mov     $4, $2
	store   $2, [min_caml_reflections + $1]
	add     $1, 1, $1
	store   $1, [min_caml_n_reflections + 0]
	ret
be_else.31963:
	ret
be_else.31960:
	ret
bge_else.31959:
	ret
.end setup_reflections

######################################################################
.begin main
min_caml_main:
	load    [min_caml_image_size + 0], $53
	li      128, $10
	load    [f.27178 + 0], $40
	load    [f.27180 + 0], $39
	load    [f.27202 + 0], $38
	load    [f.27203 + 0], $37
	load    [f.27179 + 0], $36
	load    [min_caml_texture_color + 0], $60
	load    [min_caml_or_net + 0], $59
	load    [min_caml_texture_color + 2], $58
	load    [min_caml_light + 2], $57
	load    [min_caml_light + 1], $56
	load    [min_caml_light + 0], $55
	load    [min_caml_texture_color + 1], $54
	load    [min_caml_startp_fast + 2], $52
	load    [min_caml_startp_fast + 1], $51
	load    [min_caml_startp_fast + 0], $50
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
	store   $10, [min_caml_image_size + 1]
.count stack_move
	sub     $sp, 18, $sp
	li      64, $10
.count move_float
	mov     $2, $53
	store   $10, [min_caml_image_center + 0]
	li      64, $10
	store   $10, [min_caml_image_center + 1]
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $10
.count load_float
	load    [f.27296], $11
	finv    $10, $10
	li      3, $2
.count move_args
	mov     $zero, $3
	fmul    $11, $10, $10
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	mov     $53, $2
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
	sub     $53, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31964
bge_then.31964:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	sub     $20, 1, $3
	store   $22, [$tmp + 0]
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31964
bge_else.31964:
	mov     $19, $10
bge_cont.31964:
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	mov     $53, $2
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
	sub     $53, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31965
bge_then.31965:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	sub     $20, 1, $3
	store   $22, [$tmp + 0]
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31965
bge_else.31965:
	mov     $19, $10
bge_cont.31965:
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
	li      0, $3
	li      5, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $12
	li      0, $3
	li      5, $2
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
	li      0, $3
	li      1, $2
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
	mov     $53, $2
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
	sub     $53, 2, $20
.count move_ret
	mov     $1, $19
	cmp     $20, 0
	bl      bge_else.31966
bge_then.31966:
	call    create_pixel.3008
.count storer
	add     $19, $20, $tmp
.count move_ret
	mov     $1, $22
	sub     $20, 1, $3
	store   $22, [$tmp + 0]
.count move_args
	mov     $19, $2
	call    init_line_elements.3010
.count move_ret
	mov     $1, $10
	b       bge_cont.31966
bge_else.31966:
	mov     $19, $10
bge_cont.31966:
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
	load    [f.27164], $12
.count move_ret
	mov     $1, $11
	fmul    $11, $12, $2
	store   $2, [$sp + 3]
	call    min_caml_cos
.count move_ret
	mov     $1, $11
	load    [$sp + 3], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $10
	store   $10, [$sp + 4]
	call    min_caml_read_float
.count move_ret
	mov     $1, $13
	fmul    $13, $12, $2
	store   $2, [$sp + 5]
	call    min_caml_cos
.count move_ret
	mov     $1, $13
	load    [$sp + 5], $2
	call    min_caml_sin
.count move_ret
	mov     $1, $10
	fmul    $11, $10, $15
.count load_float
	load    [f.27324], $14
	fmul    $15, $14, $15
	store   $15, [min_caml_screenz_dir + 0]
	load    [$sp + 4], $16
.count load_float
	load    [f.27325], $15
	fmul    $16, $15, $15
	store   $15, [min_caml_screenz_dir + 1]
	fmul    $11, $13, $15
	fmul    $15, $14, $14
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
	load    [min_caml_screen + 0], $11
	load    [min_caml_screenz_dir + 0], $10
	fsub    $11, $10, $10
	store   $10, [min_caml_viewpoint + 0]
	load    [min_caml_screen + 1], $11
	load    [min_caml_screenz_dir + 1], $10
	fsub    $11, $10, $10
	store   $10, [min_caml_viewpoint + 1]
	load    [min_caml_screen + 2], $11
	load    [min_caml_screenz_dir + 2], $10
	fsub    $11, $10, $10
	store   $10, [min_caml_viewpoint + 2]
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	call    min_caml_read_float
.count move_ret
	mov     $1, $11
	fmul    $11, $12, $2
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
	load    [$sp + 6], $2
	call    min_caml_cos
	fmul    $11, $12, $2
.count move_ret
	mov     $1, $13
	store   $2, [$sp + 7]
	call    min_caml_sin
.count move_ret
	mov     $1, $11
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
	store   $2, [$sp + 8]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31967
be_then.31967:
	load    [$sp + 8], $10
.count move_float
	mov     $10, $41
	b       be_cont.31967
be_else.31967:
	li      1, $2
	store   $2, [$sp + 9]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31968
be_then.31968:
	load    [$sp + 9], $10
.count move_float
	mov     $10, $41
	b       be_cont.31968
be_else.31968:
	li      2, $2
	store   $2, [$sp + 10]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $23
	cmp     $23, 0
	bne     be_else.31969
be_then.31969:
	load    [$sp + 10], $10
.count move_float
	mov     $10, $41
	b       be_cont.31969
be_else.31969:
	li      3, $2
	store   $2, [$sp + 11]
	call    read_nth_object.2719
.count move_ret
	mov     $1, $24
	cmp     $24, 0
	bne     be_else.31970
be_then.31970:
	load    [$sp + 11], $10
.count move_float
	mov     $10, $41
	b       be_cont.31970
be_else.31970:
	li      4, $2
	call    read_object.2721
be_cont.31970:
be_cont.31969:
be_cont.31968:
be_cont.31967:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31971
be_then.31971:
	add     $zero, -1, $3
	li      1, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	b       be_cont.31971
be_else.31971:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31972
be_then.31972:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $18
	store   $10, [$18 + 0]
	b       be_cont.31972
be_else.31972:
	store   $10, [$sp + 12]
	store   $11, [$sp + 13]
	call    read_net_item.2725
	load    [$sp + 13], $19
.count move_ret
	mov     $1, $18
	store   $19, [$18 + 1]
	load    [$sp + 12], $19
	store   $19, [$18 + 0]
be_cont.31972:
be_cont.31971:
	load    [$18 + 0], $19
	cmp     $19, -1
	be      bne_cont.31973
bne_then.31973:
	store   $18, [min_caml_and_net + 0]
	li      1, $2
	call    read_and_network.2729
bne_cont.31973:
	call    min_caml_read_int
.count move_ret
	mov     $1, $10
	cmp     $10, -1
	bne     be_else.31974
be_then.31974:
	add     $zero, -1, $3
	li      1, $2
	call    min_caml_create_array
.count move_ret
	mov     $1, $10
	b       be_cont.31974
be_else.31974:
	call    min_caml_read_int
.count move_ret
	mov     $1, $11
	cmp     $11, -1
	li      2, $2
	bne     be_else.31975
be_then.31975:
	add     $zero, -1, $3
	call    min_caml_create_array
.count move_ret
	mov     $1, $11
	store   $10, [$11 + 0]
	mov     $11, $10
	b       be_cont.31975
be_else.31975:
	store   $10, [$sp + 14]
	store   $11, [$sp + 15]
	call    read_net_item.2725
	load    [$sp + 15], $11
.count move_ret
	mov     $1, $10
	store   $11, [$10 + 1]
	load    [$sp + 14], $11
	store   $11, [$10 + 0]
be_cont.31975:
be_cont.31974:
	mov     $10, $3
	li      1, $2
	load    [$3 + 0], $10
	cmp     $10, -1
	bne     be_else.31976
be_then.31976:
	call    min_caml_create_array
	b       be_cont.31976
be_else.31976:
	store   $3, [$sp + 16]
	call    read_or_network.2727
	load    [$sp + 16], $10
	store   $10, [$1 + 0]
be_cont.31976:
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
	store   $3, [$sp + 17]
.count move_args
	mov     $41, $2
	call    min_caml_create_array
	mov     $hp, $11
.count move_ret
	mov     $1, $10
	store   $10, [$11 + 1]
	add     $hp, 2, $hp
	load    [$sp + 17], $10
	mov     $11, $3
	li      120, $2
	store   $10, [$11 + 0]
	call    min_caml_create_array
.count move_ret
	mov     $1, $14
	store   $14, [min_caml_dirvecs + 4]
	li      118, $3
	load    [min_caml_dirvecs + 4], $2
	call    create_dirvec_elements.3039
	li      3, $2
	call    create_dirvecs.3042
.count load_float
	load    [f.27233], $10
.count load_float
	load    [f.27234], $11
	li      9, $2
	call    min_caml_float_of_int
.count move_ret
	mov     $1, $22
	li      4, $2
	fmul    $22, $11, $22
	li      0, $5
	li      0, $4
	fsub    $22, $10, $3
	call    calc_dirvecs.3028
	li      4, $4
	li      2, $3
	li      8, $2
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
	bl      bge_cont.31977
bge_then.31977:
	load    [min_caml_objects + $12], $13
	load    [min_caml_light_dirvec + 1], $15
.count move_args
	mov     $zero, $3
	load    [$13 + 1], $14
	cmp     $14, 1
	bne     be_else.31978
be_then.31978:
	li      6, $2
	call    min_caml_create_array
	load    [$11 + 0], $17
.count move_ret
	mov     $1, $16
	fcmp    $17, $zero
	bne     be_else.31979
be_then.31979:
	store   $zero, [$16 + 1]
	b       be_cont.31979
be_else.31979:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31980
ble_then.31980:
	li      0, $17
	b       ble_cont.31980
ble_else.31980:
	li      1, $17
ble_cont.31980:
	cmp     $18, 0
	be      bne_cont.31981
bne_then.31981:
	cmp     $17, 0
	bne     be_else.31982
be_then.31982:
	li      1, $17
	b       be_cont.31982
be_else.31982:
	li      0, $17
be_cont.31982:
bne_cont.31981:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 0], $18
	bne     be_else.31983
be_then.31983:
	fneg    $18, $17
	store   $17, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
	b       be_cont.31983
be_else.31983:
	store   $18, [$16 + 0]
	load    [$11 + 0], $17
	finv    $17, $17
	store   $17, [$16 + 1]
be_cont.31983:
be_cont.31979:
	load    [$11 + 1], $17
	fcmp    $17, $zero
	bne     be_else.31984
be_then.31984:
	store   $zero, [$16 + 3]
	b       be_cont.31984
be_else.31984:
	load    [$13 + 6], $18
	fcmp    $zero, $17
	bg      ble_else.31985
ble_then.31985:
	li      0, $17
	b       ble_cont.31985
ble_else.31985:
	li      1, $17
ble_cont.31985:
	cmp     $18, 0
	be      bne_cont.31986
bne_then.31986:
	cmp     $17, 0
	bne     be_else.31987
be_then.31987:
	li      1, $17
	b       be_cont.31987
be_else.31987:
	li      0, $17
be_cont.31987:
bne_cont.31986:
	load    [$13 + 4], $18
	cmp     $17, 0
	load    [$18 + 1], $18
	bne     be_else.31988
be_then.31988:
	fneg    $18, $17
	store   $17, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
	b       be_cont.31988
be_else.31988:
	store   $18, [$16 + 2]
	load    [$11 + 1], $17
	finv    $17, $17
	store   $17, [$16 + 3]
be_cont.31988:
be_cont.31984:
	load    [$11 + 2], $17
	fcmp    $17, $zero
	bne     be_else.31989
be_then.31989:
.count storer
	add     $15, $12, $tmp
	store   $zero, [$16 + 5]
	sub     $12, 1, $3
	store   $16, [$tmp + 0]
.count move_args
	mov     $10, $2
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31978
be_else.31989:
	load    [$13 + 4], $18
	load    [$13 + 6], $19
	fcmp    $zero, $17
	bg      ble_else.31990
ble_then.31990:
	li      0, $17
	b       ble_cont.31990
ble_else.31990:
	li      1, $17
ble_cont.31990:
	load    [$18 + 2], $18
	cmp     $19, 0
	bne     be_else.31991
be_then.31991:
	cmp     $17, 0
	bne     be_else.31992
be_then.31992:
	fneg    $18, $17
	b       be_cont.31992
be_else.31992:
	mov     $18, $17
be_cont.31992:
	store   $17, [$16 + 4]
.count storer
	add     $15, $12, $tmp
	load    [$11 + 2], $17
	sub     $12, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31978
be_else.31991:
	cmp     $17, 0
	bne     be_else.31993
be_then.31993:
	li      1, $17
	b       be_cont.31993
be_else.31993:
	li      0, $17
be_cont.31993:
	cmp     $17, 0
	bne     be_else.31994
be_then.31994:
	fneg    $18, $17
	b       be_cont.31994
be_else.31994:
	mov     $18, $17
be_cont.31994:
	store   $17, [$16 + 4]
.count storer
	add     $15, $12, $tmp
	load    [$11 + 2], $17
	sub     $12, 1, $3
.count move_args
	mov     $10, $2
	finv    $17, $17
	store   $17, [$16 + 5]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31978
be_else.31978:
	cmp     $14, 2
	bne     be_else.31995
be_then.31995:
	li      4, $2
	call    min_caml_create_array
	load    [$13 + 4], $17
	load    [$11 + 2], $20
	load    [$13 + 4], $18
	load    [$17 + 2], $17
	load    [$13 + 4], $19
	load    [$18 + 1], $18
	fmul    $20, $17, $17
	load    [$19 + 0], $19
	load    [$11 + 1], $20
.count move_ret
	mov     $1, $16
.count move_args
	mov     $10, $2
	fmul    $20, $18, $18
	sub     $12, 1, $3
	load    [$11 + 0], $20
.count storer
	add     $15, $12, $tmp
	fmul    $20, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	fcmp    $17, $zero
	bg      ble_else.31996
ble_then.31996:
	store   $zero, [$16 + 0]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31995
ble_else.31996:
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
	b       be_cont.31995
be_else.31995:
	li      5, $2
	call    min_caml_create_array
	load    [$11 + 2], $21
	load    [$13 + 4], $17
	load    [$13 + 4], $18
	fmul    $21, $21, $22
	load    [$17 + 2], $17
	load    [$18 + 1], $18
	load    [$13 + 4], $19
	load    [$13 + 3], $20
	fmul    $22, $17, $17
	load    [$19 + 0], $19
	load    [$11 + 1], $22
.count move_ret
	mov     $1, $16
	cmp     $20, 0
	fmul    $22, $22, $23
	fmul    $23, $18, $18
	load    [$11 + 0], $23
	fmul    $23, $23, $24
	fmul    $24, $19, $19
	fadd    $19, $18, $18
	fadd    $18, $17, $17
	be      bne_cont.31997
bne_then.31997:
	load    [$13 + 9], $19
	fmul    $22, $21, $18
	load    [$19 + 0], $19
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 1], $19
	fmul    $21, $23, $18
	fmul    $18, $19, $18
	load    [$13 + 9], $19
	fadd    $17, $18, $17
	load    [$19 + 2], $19
	fmul    $23, $22, $18
	fmul    $18, $19, $18
	fadd    $17, $18, $17
bne_cont.31997:
	store   $17, [$16 + 0]
	load    [$13 + 4], $18
	load    [$13 + 4], $19
	load    [$13 + 4], $21
	load    [$11 + 2], $22
	load    [$18 + 2], $18
	load    [$11 + 1], $23
	load    [$19 + 1], $19
	load    [$11 + 0], $24
	load    [$21 + 0], $21
	fmul    $22, $18, $18
	fmul    $23, $19, $19
	fmul    $24, $21, $21
	cmp     $20, 0
.count storer
	add     $15, $12, $tmp
	fneg    $18, $18
	fneg    $19, $19
	sub     $12, 1, $3
.count move_args
	mov     $10, $2
	fneg    $21, $21
	bne     be_else.31998
be_then.31998:
	store   $21, [$16 + 1]
	fcmp    $17, $zero
	store   $19, [$16 + 2]
	store   $18, [$16 + 3]
	bne     be_else.31999
be_then.31999:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31998
be_else.31999:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.31998
be_else.31998:
	load    [$13 + 9], $24
	load    [$13 + 9], $20
	fcmp    $17, $zero
	load    [$24 + 1], $24
	load    [$20 + 2], $20
	fmul    $22, $24, $22
	fmul    $23, $20, $23
	fadd    $22, $23, $22
	fmul    $22, $39, $22
	fsub    $21, $22, $21
	store   $21, [$16 + 1]
	load    [$11 + 0], $22
	load    [$13 + 9], $21
	fmul    $22, $20, $20
	load    [$21 + 0], $21
	load    [$11 + 2], $22
	fmul    $22, $21, $22
	fadd    $22, $20, $20
	fmul    $20, $39, $20
	fsub    $19, $20, $19
	store   $19, [$16 + 2]
	load    [$11 + 1], $20
	load    [$11 + 0], $19
	fmul    $20, $21, $20
	fmul    $19, $24, $19
	fadd    $20, $19, $19
	fmul    $19, $39, $19
	fsub    $18, $19, $18
	store   $18, [$16 + 3]
	bne     be_else.32000
be_then.32000:
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
	b       be_cont.32000
be_else.32000:
	finv    $17, $17
	store   $17, [$16 + 4]
	store   $16, [$tmp + 0]
	call    iter_setup_dirvec_constants.2826
be_cont.32000:
be_cont.31998:
be_cont.31995:
be_cont.31978:
bge_cont.31977:
	sub     $41, 1, $2
	call    setup_reflections.3064
	load    [min_caml_image_center + 1], $11
	load    [min_caml_screenz_dir + 2], $10
	neg     $11, $2
	call    min_caml_float_of_int
	load    [min_caml_scan_pitch + 0], $2
	load    [min_caml_screeny_dir + 1], $3
	li      0, $4
	fmul    $2, $1, $1
	load    [min_caml_screeny_dir + 2], $2
	fmul    $1, $2, $2
	fmul    $1, $3, $3
	fadd    $2, $10, $7
	load    [min_caml_screenz_dir + 1], $2
	fadd    $3, $2, $6
	load    [min_caml_screeny_dir + 0], $3
	load    [min_caml_screenz_dir + 0], $2
	fmul    $1, $3, $1
	sub     $53, 1, $3
	fadd    $1, $2, $5
	load    [$sp + 1], $2
	call    pretrace_pixels.2983
	li      2, $6
	li      0, $2
	load    [$sp + 0], $3
	load    [$sp + 1], $4
	load    [$sp + 2], $5
	call    scan_line.3000
.count stack_move
	add     $sp, 18, $sp
	li      0, $1
	ret
.end main
