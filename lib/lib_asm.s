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
