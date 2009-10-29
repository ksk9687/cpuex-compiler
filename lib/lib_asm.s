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
# * 算術関数用定数テーブル
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
min_caml_rsqrt_table:
	.float 1.0
	.float 0.707106781186547462
	.float 0.5
	.float 0.353553390593273731
	.float 0.25
	.float 0.176776695296636865
	.float 0.125
	.float 0.0883883476483184327
	.float 0.0625
	.float 0.0441941738241592164
	.float 0.03125
	.float 0.0220970869120796082
	.float 0.015625
	.float 0.0110485434560398041
	.float 0.0078125
	.float 0.00552427172801990204
	.float 0.00390625
	.float 0.00276213586400995102
	.float 0.001953125
	.float 0.00138106793200497551
	.float 0.0009765625
	.float 0.000690533966002487756
	.float 0.00048828125
	.float 0.000345266983001243878
	.float 0.000244140625
	.float 0.000172633491500621939
	.float 0.0001220703125
	.float 8.63167457503109694e-05
	.float 6.103515625e-05
	.float 4.31583728751554847e-05
	.float 3.0517578125e-05
	.float 2.15791864375777424e-05
	.float 1.52587890625e-05
	.float 1.07895932187888712e-05
	.float 7.62939453125e-06
	.float 5.39479660939443559e-06
	.float 3.814697265625e-06
	.float 2.6973983046972178e-06
	.float 1.9073486328125e-06
	.float 1.3486991523486089e-06
	.float 9.5367431640625e-07
	.float 6.74349576174304449e-07
	.float 4.76837158203125e-07
	.float 3.37174788087152224e-07
	.float 2.384185791015625e-07
	.float 1.68587394043576112e-07
	.float 1.1920928955078125e-07
	.float 8.42936970217880561e-08
	.float 5.9604644775390625e-08
	.float 4.21468485108940281e-08

######################################################################
# * floor
######################################################################
min_caml_floor:
	fcmp $1, $zero
	bge FLOOR_POSITIVE	# if ($f1 >= 0) FLOOR_POSITIVE
	store $ra, [$sp]
	add $sp, 1, $sp
	fneg $1, $1
	jal min_caml_floor		# $f1 = FLOOR_POSITIVE(-$f1)
	li FLOOR_MONE, $tmp
	load [$tmp], $2
	fsub $2, $1, $1		# $f1 = (-1) - $f1
	add $sp, -1, $sp
	load [$sp], $ra
	ret
FLOOR_POSITIVE:
	li FLOAT_MAGICF, $tmp
	load [$tmp], $mf
	fcmp $1, $mf
	ble FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	mov $1, $2
	fadd $1, $mf, $1		# $f1 += 0x4b000000
	fsub $1, $mf, $1		# $f1 -= 0x4b000000
	fcmp $1, $2
	ble FLOOR_RET
	li FLOOR_ONE, $tmp
	load [$tmp], $2
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
	cmp $1, $zero
	bge ITOF_MAIN		# if ($i1 >= 0) goto ITOF_MAIN
	neg $1, $1		# 正の値にしてitofした後に、マイナスにしてかえす
	store $ra, [$sp]
	add $sp, 1, $sp
	jal min_caml_float_of_int	# $f1 = float_of_int(-$i1)
	add $sp, -1, $sp
	load [$sp], $ra
	fneg $1, $1
	ret
ITOF_MAIN:
	li FLOAT_MAGICI, $tmp
	load [$tmp], $mi		# $mi = 8388608
	li FLOAT_MAGICF, $tmp
	load [$tmp], $mf 		# $mf = 8388608.0
	li FLOAT_MAGICFHX, $tmp
	load [$tmp], $mfhx 		# $mfhx = 0x4b000000
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
	cmp $q, $zero
	bg ITOF_LOOP2
	add $r, $mfhx, $r			# $r < 8388608 だからそのままitof
	fsub $r, $mf, $r		# $tempf = itof($r)
	fadd $1, $r, $1		# $f1 = $f1 + $tempf (i.e. $f1 = itof($q * $mf) + itof($r) )
	ret


######################################################################
# * int_of_float
######################################################################
min_caml_int_of_float:
	fcmp $1, $zero
	bge FTOI_MAIN		# if ($f1 >= 0) goto FTOI_MAIN
	fneg $1, $1		# 正の値にしてftoiした後に、マイナスにしてかえす
	store $ra, [$sp]
	add $sp, 1, $sp
	jal min_caml_int_of_float	# $i1 = float_of_int(-$f1)
	add $sp, -1, $sp
	load [$sp], $ra
	neg $1, $1
	ret				# return
FTOI_MAIN:
	li FLOAT_MAGICI, $tmp
	load [$tmp], $mi		# $mi = 8388608
	li FLOAT_MAGICF, $tmp
	load [$tmp], $mf 		# $mf = 8388608.0
	li FLOAT_MAGICFHX, $tmp
	load [$tmp], $mfhx		# $mfhx = 0x4b000000
	fcmp $1, $mf
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
	fcmp $rf, $mf
	bge FTOI_LOOP		# if ($rf >= 8388608.0) continue
	li 0, $1
FTOI_LOOP2:
	add $1, $mi, $1			# $i1 = $q * $mi
	add $q, -1, $q
	cmp $q, $zero
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
	li 255, $2
	cmp $1, $2
	bg read_1
	sll $1, 24, $1
read_2:
	read $2
	li 255, $3
	cmp $2, $3
	bg read_2
	sll $2, 16, $2
	add $1, $2, $1
read_3:
	read $2
	li 255, $3
	cmp $2, $3
	bg read_3
	sll $2, 8, $2
	add $1, $2, $1
read_4:
	read $2
	li 255, $3
	cmp $2, $3
	bg read_4
	add $1, $2, $1
	ret

######################################################################
# * write
# * バイト出力
# * 失敗してたらループ
######################################################################
min_caml_write:
	write $1
	bg min_caml_write		# TODO
	ret

######################################################################
# * create_array
# * create_float_array
######################################################################
min_caml_create_array:
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
	ledout $1
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
	li DIV2_F, $tmp
	load [$tmp], $2
	fmul $1, $2, $1
	jal min_caml_int_of_float
	add $sp, -1, $sp
	load [$sp], $ra
	ret
DIV2_F:
	.float 0.5
######################################################################
#
# 		↑　ここまで lib_asm.s
#
######################################################################
