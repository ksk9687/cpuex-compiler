######################################################################
#
# 		↓　ここから lib_asm.s
#
######################################################################

.define $mi $3
.define $mfhx $4
.define $mf $5

.define $q $6
.define $r $7

.define $rf $8

######################################################################
# * floor
######################################################################
min_caml_floor:
	mov $2, $1
	cmp $1, 0
	bge FLOOR_POSITIVE	# if ($f1 >= 0) FLOOR_POSITIVE
	fneg $1, $1
	mov $ra, $9
	jal FLOOR_POSITIVE		# $f1 = FLOOR_POSITIVE(-$f1)
	load [FLOOR_MONE], $2
	fsub $2, $1, $1		# $f1 = (-1) - $f1
	jr $9
FLOOR_POSITIVE:
	load [FLOAT_MAGICF], $mf
	cmp $1, $mf
	ble FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	mov $1, $2
	fadd $1, $mf, $1		# $f1 += 0x4b000000
	fsub $1, $mf, $1		# $f1 -= 0x4b000000
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

######################################################################
# * float_of_int
######################################################################
min_caml_float_of_int:
	mov $2, $1
	cmp $1, 0
	bge ITOF_MAIN		# if ($i1 >= 0) goto ITOF_MAIN
	neg $1, $1		# 正の値にしてitofした後に、マイナスにしてかえす
	mov $ra, $9
	jal ITOF_MAIN	# $f1 = float_of_int(-$i1)
	fneg $1, $1
	jr $9
ITOF_MAIN:
	load [FLOAT_MAGICI], $mi		# $mi = 8388608
	load [FLOAT_MAGICF], $mf 		# $mf = 8388608.0
	load [FLOAT_MAGICFHX], $mfhx 		# $mfhx = 0x4b000000
	cmp $1, $mi 			# $cond = cmp($i1, 8388608)
	bge ITOF_BIG			# if ($i1 >= 8388608) goto ITOF_BIG
	add $1, $mfhx, $1		# $i1 = $i1 + $mfhx (i.e. $i1 + 0x4b000000)
	fsub $1, $mf, $1		# $f1 = $f1 - $mf (i.e. $f1 - 8388608.0)
	ret				# return
ITOF_BIG:
	li 0, $q				# $i1 = $q * 8388608 + $r なる$q, $rを求める
	mov $1, $r
ITOF_LOOP:
	add $q, 1, $q			# $q += 1
	sub $r, $mi, $r			# $r -= 8388608
	cmp $r, $mi
	bge ITOF_LOOP		# if ($r >= 8388608) continue
	li 0, $1
ITOF_LOOP2:
	fadd $1, $mf, $1		# $f1 = $q * $mf
	add $q, -1, $q
	cmp $q, 0
	bg ITOF_LOOP2
	add $r, $mfhx, $r			# $r < 8388608 だからそのままitof
	fsub $r, $mf, $r		# $tempf = itof($r)
	fadd $1, $r, $1		# $f1 = $f1 + $tempf (i.e. $f1 = itof($q * $mf) + itof($r) )
	ret


######################################################################
# * int_of_float
######################################################################
min_caml_int_of_float:
	mov $2, $1
	cmp $1, 0
	bge FTOI_MAIN		# if ($f1 >= 0) goto FTOI_MAIN
	fneg $1, $1		# 正の値にしてftoiした後に、マイナスにしてかえす
	mov $ra, $9
	jal FTOI_MAIN	# $i1 = float_of_int(-$f1)
	neg $1, $1
	jr $9				# return
FTOI_MAIN:
	load [FLOAT_MAGICI], $mi		# $mi = 8388608
	load [FLOAT_MAGICF], $mf 		# $mf = 8388608.0
	load [FLOAT_MAGICFHX], $mfhx		# $mfhx = 0x4b000000
	cmp $1, $mf
	bge FTOI_BIG		# if ($f1 >= 8688608.0) goto FTOI_BIG
	fadd $1, $mf, $1
	sub $1, $mfhx, $1
	ret
FTOI_BIG:
	li 0, $q				# $f1 = $q * 8388608 + $rf なる$q, $rfを求める
	mov $1, $rf
FTOI_LOOP:
	add $q, 1, $q			# $q += 1
	fsub $rf, $mf, $rf		# $rf -= 8388608.0
	cmp $rf, $mf
	bge FTOI_LOOP		# if ($rf >= 8388608.0) continue
	li 0, $1
FTOI_LOOP2:
	add $1, $mi, $1			# $i1 = $q * $mi
	add $q, -1, $q
	cmp $q, 0
	bg FTOI_LOOP2
	fadd $rf, $mf, $rf		# $rf < 8388608.0 だからそのままftoi
	sub $rf, $mfhx, $rf		# $temp = ftoi($rf)
	add $1, $rf, $1		# $i1 = $i1 + $temp (i.e. $i1 = ftoi($q * $mi) + ftoi($rf) )
	ret

FLOAT_MAGICI:
	.int 8388608
FLOAT_MAGICF:
	.float 8388608.0
FLOAT_MAGICFHX:
	.int 1258291200			# 0x4b000000


######################################################################
# * read_int=read_float
# * wordバイナリ読み込み
######################################################################
	# TODO
min_caml_read_int:
min_caml_read_float:
read_1:
	read $1
#	cmp $1, 255
#	bg read_1
	sll $1, 24, $1
read_2:
	read $2
#	cmp $2, 255
#	bg read_2
	sll $2, 16, $2
	add $1, $2, $1
read_3:
	read $2
#	cmp $2, 255
#	bg read_3
	sll $2, 8, $2
	add $1, $2, $1
read_4:
	read $2
#	cmp $2, 255
#	bg read_4
	add $1, $2, $1
	ret

######################################################################
# * write
# * バイト出力
# * 失敗してたらループ
######################################################################
min_caml_write:
	write $2
#	bg min_caml_write		# TODO
	ret

######################################################################
# * create_array
######################################################################
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

######################################################################
# * ledout_in
# * ledout_float
# * バイトLED出力
######################################################################
min_caml_ledout_int:
min_caml_ledout_float:
	ledout $2
	ret


######################################################################
# * div2
# とりあえず今は itof, *0.5, ftoi になっている
######################################################################
	# TODO
min_caml_div2:
	store $ra, [$sp]
	add $sp, 1, $sp
	jal min_caml_float_of_int
	load [DIV2_F], $2
	fmul $1, $2, $2
	jal min_caml_floor
	mov $1, $2
	jal min_caml_int_of_float
	add $sp, -1, $sp
	load [$sp], $ra
	ret
DIV2_F:
	.float 0.5

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
f._196:	.float  6.2831853072E+00
f._195:	.float  3.1415926536E+00
f._194:	.float  1.5707963268E+00
f._193:	.float  1.0000000000E+00
f._192:	.float  0.0000000000E+00
f._191:	.float  6.0725293501E-01
f._190:	.float  5.0000000000E-01
cordic_rec.155:
	cmp     $3, 25
	bne     be_else._202
	mov     $5, $1
	ret
be_else._202:
	fcmp    $2, $6
	bg      ble_else._203
	add     $3, 1, $10
	fmul    $7, $5, $9
	fadd    $4, $9, $9
	fmul    $7, $4, $8
	fsub    $5, $8, $5
	load    [min_caml_atan_table + $3], $8
	fsub    $6, $8, $6
	load    [f._190], $8
	fmul    $7, $8, $7
	mov     $9, $4
	mov     $10, $3
	b       cordic_rec.155
ble_else._203:
	add     $3, 1, $10
	fmul    $7, $5, $9
	fsub    $4, $9, $9
	fmul    $7, $4, $8
	fadd    $5, $8, $5
	load    [min_caml_atan_table + $3], $8
	fadd    $6, $8, $6
	load    [f._190], $8
	fmul    $7, $8, $7
	mov     $9, $4
	mov     $10, $3
	b       cordic_rec.155
cordic_sin.85:
	li      0, $3
	load    [f._191], $4
	load    [f._192], $5
	load    [f._193], $7
	mov     $5, $6
	b       cordic_rec.155
cordic_rec.121:
	cmp     $2, 25
	bne     be_else._204
	mov     $5, $1
	ret
be_else._204:
	load    [f._192], $10
	fcmp    $4, $10
	bg      ble_else._205
	add     $2, 1, $10
	fmul    $6, $4, $9
	fsub    $3, $9, $9
	fmul    $6, $3, $8
	fadd    $4, $8, $4
	load    [min_caml_atan_table + $2], $8
	fsub    $5, $8, $5
	load    [f._190], $8
	fmul    $6, $8, $6
	mov     $9, $3
	mov     $10, $2
	b       cordic_rec.121
ble_else._205:
	add     $2, 1, $10
	fmul    $6, $4, $9
	fadd    $3, $9, $9
	fmul    $6, $3, $8
	fsub    $4, $8, $4
	load    [min_caml_atan_table + $2], $8
	fadd    $5, $8, $5
	load    [f._190], $8
	fmul    $6, $8, $6
	mov     $9, $3
	mov     $10, $2
	b       cordic_rec.121
min_caml_atan:
	li      0, $10
	load    [f._193], $3
	load    [f._192], $5
	mov     $3, $6
	mov     $2, $4
	mov     $10, $2
	b       cordic_rec.121
min_caml_sin:
	load    [f._192], $10
	fcmp    $10, $2
	bg      ble_else._206
	load    [f._194], $10
	fcmp    $10, $2
	bg      ble_else._207
	load    [f._195], $10
	fcmp    $10, $2
	bg      ble_else._208
	load    [f._196], $10
	fcmp    $10, $2
	bg      ble_else._209
	fsub    $2, $10, $2
	b       min_caml_sin
ble_else._209:
	fsub    $10, $2, $2
	store   $ra, [$sp + 0]
	add     $sp, 1, $sp
	jal     min_caml_sin
	sub     $sp, 1, $sp
	load    [$sp + 0], $ra
	mov     $1, $10
	fneg    $10, $1
	ret
ble_else._208:
	fsub    $10, $2, $2
	b       cordic_sin.85
ble_else._207:
	b       cordic_sin.85
ble_else._206:
	fneg    $2, $2
	store   $ra, [$sp + 0]
	add     $sp, 1, $sp
	jal     min_caml_sin
	sub     $sp, 1, $sp
	load    [$sp + 0], $ra
	mov     $1, $10
	fneg    $10, $1
	ret
min_caml_cos:
	load    [f._194], $10
	fsub    $10, $2, $2
	b       min_caml_sin

######################################################################
#
# 		↑　ここまで lib_asm.s
#
######################################################################
