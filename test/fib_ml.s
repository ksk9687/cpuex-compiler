######################################################################
#
# 		↓　ここから macro.s
#
######################################################################

#レジスタ名置き換え
.define $zero $i0
.define $ra $i15
.define $sp $i14
.define $hp $i13
.define $fzero $f0
.define $i0 orz
.define $i15 orz
.define $i14 orz
.define $i13 orz
.define $f0 orz

#jmp
.define { jmp %Reg %Imm %Imm } { _jmp %1 %2 %{ %3 - %pc } }

#疑似命令
.define { mov %Reg %Reg } { addi %1 %2 0 }
.define { neg %Reg %Reg } { sub $zero %1 %2 }
.define { fneg %Reg %Reg } { fsub $fzero %1 %2 }
.define { b %Imm } { jmp $zero 0 %1 }
.define { be %Reg %Imm } { jmp %1 5 %2 }
.define { bne %Reg %Imm } { jmp %1 2 %2 }
.define { bl %Reg %Imm } { jmp %1 6 %2 }
.define { ble %Reg %Imm } { jmp %1 4 %2 }
.define { bg %Reg %Imm } { jmp %1 3 %2 }
.define { bge %Reg %Imm } { jmp %1 1 %2 }
.define { ret } { jr $ra }

# 入力,出力の順にコンマで区切る形式
.define { add %Reg, %Reg, %Reg } { add %1 %2 %3 }
.define { add %Reg, %Imm, %Reg } { addi %1 %3 %2 }
.define { sub %Reg, %Reg, %Reg } { sub %1 %2 %3 }
.define { sub %Reg, %Imm, %Reg } { addi %1 %3 -%2 }
.define { srl %Reg, %Imm, %Reg } { srl %1 %3 %2 }
.define { sll %Reg, %Imm, %Reg } { sll %1 %3 %2 }
.define { fadd %Reg, %Reg, %Reg } { fadd %1 %2 %3 }
.define { fsub %Reg, %Reg, %Reg } { fsub %1 %2 %3 }
.define { fmul %Reg, %Reg, %Reg } { fmul %1 %2 %3 }
.define { finv %Reg, %Reg } { finv %1 %2 }
.define { load %Imm(%Reg), %Reg } { load %2 %3 %1 }
.define { load %Reg, %Reg } { load 0(%1), %2 }
.define { load %Imm, %Reg } { load %1($zero), %2 }
.define { li %Imm, %Reg } { li %2 %1 }
.define { store %Reg, %Imm(%Reg) } { store %3 %1 %2 }
.define { store %Reg, %Reg } { store %1, 0(%2) }
.define { store %Reg, %Imm } { store %1, %2($zero) }
.define { cmp %Reg, %Reg, %Reg } { cmp %1 %2 %3 }
.define { fcmp %Reg, %Reg, %Reg } { fcmp %1 %2 %3 }
.define { write %Reg, %Reg } { write %1 %2 }
.define { jmp %Reg, %Imm, %Imm } { jmp %1 %2 %3 }
.define { mov %Reg, %Reg } { mov %1 %2 }
.define { neg %Reg, %Reg } { neg %1 %2 }
.define { fneg %Reg, %Reg } { fneg %1 %2 }
.define { be %Reg, %Imm } { be %1 %2 }
.define { bne %Reg, %Imm } { bne %1 %2 }
.define { bl %Reg, %Imm } { bl %1 %2 }
.define { ble %Reg, %Imm } { ble %1 %2 }
.define { bg %Reg, %Imm } { bg %1 %2 }
.define { bge %Reg, %Imm } { bge %1 %2 }

#メモリ参照に[]を使う形式
.define { load [%Reg + %Imm], %Reg } { load %2(%1), %3 }
.define { load [%Reg - %Imm], %Reg } { load -%2(%2), %3 }
.define { load [%Reg], %Reg } { load %1, %2 }
.define { load [%Imm], %Reg } { load %1, %2 }
.define { store %Reg, [%Reg + %Imm] } { store %1, %3(%2) }
.define { store %Reg, [%Reg - %Imm] } { store %1, -%3(%2) }
.define { store %Reg, [%Reg] } { store %1, %2 }
.define { store %Reg, [%Imm] } { store %1, %2 }

#代入に=使う形式
.define { %Reg = %Reg + %Reg } { add %2, %3, %1 }
.define { %Reg = %Reg + %Imm } { add %2, %3, %1 }
.define { %Reg = %Reg - %Reg } { sub %2, %3, %1 }
.define { %Reg = %Reg - %Imm } { sub %2, %3, %1 }
.define { %Reg = %Reg >> %Imm } { srl %2, %3, %1 }
.define { %Reg = %Reg << %Imm } { sll %2, %3, %1 }
.define { %Reg = %Reg + %Reg } { fadd %2, %3, %1 }
.define { %Reg = %Reg - %Reg } { fsub %2, %3, %1 }
.define { %Reg = %Reg * %Reg } { fmul %2, %3, %1 }
.define { %Reg = finv %Reg } { finv %2, %1 }
.define { %Reg = [%Reg + %Imm] } { load [%2 + %3], %1 }
.define { %Reg = [%Reg - %Imm] } { load [%2 - %3], %1 }
.define { %Reg = [%Reg] } { load [%2], %1 }
.define { %Reg = [%Imm] } { load [%2], %1 }
.define { %Reg = %Imm } { li %2, %1 }
.define { [%Reg + %Imm] = %Reg } { store %3, [%1 + %2] }
.define { [%Reg - %Imm] = %Reg } { store %3, [%1 - %2] }
.define { [%Reg] = %Reg } { store %2, [%1] }
.define { [%Imm] = %Reg } { store %2, [%1] }
.define { %Reg = cmp %Reg %Reg } { cmp %2, %3, %1 }
.define { %Reg = fcmp %Reg %Reg } { fcmp %2, %3, %1 }
.define { %Reg = read } { read %1 }
.define { %Reg = write %Reg } { write %2 %1 }
.define { %Reg = %Reg } { mov %2, %1 }
.define { %Reg = -%Reg } { neg %2, %1 }
.define { %Reg = -%Reg } { fneg %2, %1 }
.define { %Reg += %Reg } { %1 = %1 + %2 }
.define { %Reg += %Imm } { %1 = %1 + %2 }
.define { %Reg -= %Reg } { %1 = %1 - %2 }
.define { %Reg -= %Imm } { %1 = %1 - %2 }
.define { %Reg++ } { %1 += 1 }
.define { %Reg-- } { %1 -= 1 }
.define { %Reg *= %Reg } { %1 = %1 * %2 }

#スタックとヒープの初期化
	li      0x7fff, $hp
	sll     $hp, 4, $sp

######################################################################
#
# 		↑　ここまで macro.s
#
######################################################################








	li      10, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     fib.10
	sub     $sp, 1, $sp
	load    0($sp), $ra
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	halt
fib.10:
	li      1, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.26
	ret
ble_else.26:
	store   $i1, 0($sp)
	sub     $i1, 1, $i1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     fib.10
	sub     $sp, 2, $sp
	load    1($sp), $ra
	store   $i1, 1($sp)
	load    0($sp), $i1
	sub     $i1, 2, $i1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     fib.10
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i2
	add     $i2, $i1, $i1
	ret








######################################################################
#
# 		↓　ここから lib_asm.s
#
######################################################################

.define $mi $i2
.define $mfhx $i3
.define $mf $f2
.define $cond $i4

.define $q $i5
.define $r $i6
.define $temp $i7

.define $rf $f6
.define $tempf $f7

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
# * fless
# fless($f1, $f2) := ($f1 < $f2) ? 1 : 0
######################################################################
min_caml_fless:
	fcmp $f1, $f2, $cond
	bge $cond, FLESS_RET
	li 1, $i1
	ret
FLESS_RET:
	li 0, $i1
	ret


######################################################################
# * fispos
# fispos($f1) := ($f1 > 0) ? 1 : 0
######################################################################
min_caml_fispos:
	fcmp $f1, $fzero, $cond
	bg $cond, FISPOS_RET
	li 0, $i1
	ret
FISPOS_RET:
	li 1, $i1
	ret


######################################################################
# * fisneg
# fisneg($f1) := ($f1 < 0) ? 1 : 0
######################################################################
min_caml_fisneg:
	fcmp $f1, $fzero, $cond
	bl $cond, FISNEG_RET
	li 0, $i1
	ret
FISNEG_RET:
	li 1, $i1
	ret


######################################################################
# * fiszero
# fiszero($f1) := ($f1 == 0) ? 1 : 0
######################################################################
min_caml_fiszero:
	fcmp $f1, $fzero, $cond
	be $cond, FISZERO_RET
	li 0, $i1
	ret
FISZERO_RET:
	li 1, $i1
	ret


######################################################################
# * fhalf
# fhalf($f1) := $f1 / 2.0
######################################################################
min_caml_fhalf:
	load FHALF_DAT($zero), $f2
	fmul $f1, $f2, $f1
	ret
FHALF_DAT:
	.float 0.5


######################################################################
# * fsqr
# fsqr($f1) := $f1 * $f1
######################################################################
min_caml_fsqr:
	fmul $f1, $f1, $f1
	ret


######################################################################
# * fabs
######################################################################
min_caml_fabs:
	fcmp $f1, $fzero, $cond
	ble $cond, FABS_NEG
	ret
FABS_NEG:
	fneg $f1, $f1
	ret


######################################################################
# * fneg
######################################################################
min_caml_fneg:
	fneg $f1, $f1
	ret


######################################################################
# * floor
######################################################################
# floor(f) = itof(ftoi(f)) という適当仕様
# これじゃおそらく明らかに誤差るので、まだ要実装
min_caml_floor:
	store $sp $ra 0
	addi $sp $sp 1
	jal min_caml_int_of_float
	jal min_caml_float_of_int
	addi $sp $sp -1
	load $sp $ra 0
	jr $ra


######################################################################
# * float_of_int
######################################################################
min_caml_float_of_int:
	cmp $i1 $zero $cond
	bge $cond ITOF_MAIN		# if ($i1 >= 0) goto ITOF_MAIN
	sub $zero $i1 $i1		# 正の値にしてitofした後に、マイナスにしてかえす
	store $sp $ra 0
	addi $sp $sp 1
	jal min_caml_float_of_int	# $f1 = float_of_int(-$i1)
	addi $sp $sp -1
	load $sp $ra 0
	store $sp $f1 0
	load $sp $i1 0			# $i1 = floatToIntBits($f1)
	li $temp 1
	sll $temp $temp 31
	add $i1 $temp $i1		# ビット演算が無いので、これで $i1 = -$i1
	store $sp $i1 0
	load $sp $f1 0			# $f1 = intBitsToFloat($i1)
	jr $ra
ITOF_MAIN:
	load $zero $mi FLOAT_MAGICI	# $mi = 8388608
	load $zero $mf FLOAT_MAGICF	# $mf = 8388608.0
	load $zero $mfhx FLOAT_MAGICFHX	# $mfhx = 0x4b000000
	cmp $i1 $mi $cond		# $cond = cmp($i1, 8388608)
	bge $cond ITOF_BIG		# if ($i1 >= 8388608) goto ITOF_BIG
	add $i1 $mfhx $i1		# $i1 = $i1 + $mfhx (i.e. $i1 + 0x4b000000)
	store $sp $i1 0			# [$sp + 1] = $i1
	load $sp $f1 0			# $f1 = [$sp + 1]
	fsub $f1 $mf $f1		# $f1 = $f1 - $mf (i.e. $f1 - 8388608.0)
	jr $ra				# return
ITOF_BIG:
	li $q 0				# $i1 = $q * 8388608 + $r なる$q, $rを求める
	li $r 0				# divが無いから自前で頑張る
	add $r $i1 $r			# $r = $i1
ITOF_LOOP:
	addi $q $q 1			# $q += 1
	sub $r $mi $r			# $r -= 8388608
	cmp $r $mi $cond
	bge $cond ITOF_LOOP		# if ($r >= 8388608) continue
	li $f1 0
ITOF_LOOP2:
	fadd $f1 $mf $f1		# $f1 = $q * $mf
	addi $q $q -1
	cmp $q $zero $cond
	bg $cond ITOF_LOOP2
	add $r $mfhx $r			# $r < 8388608 だからそのままitof
	store $sp $r 2
	load $sp $tempf 2
	fsub $tempf $mf $tempf		# $tempf = itof($r)
	fadd $f1 $tempf $f1		# $f1 = $f1 + $tempf (i.e. $f1 = itof($q * $mf) + itof($r) )
	jr $ra


######################################################################
# * int_of_float
######################################################################
min_caml_int_of_float:
	fcmp $f1 $fzero $cond
	bge $cond FTOI_MAIN		# if ($f1 >= 0) goto FTOI_MAIN
	fsub $fzero $f1 $f1		# 正の値にしてftoiした後に、マイナスにしてかえす
	store $sp $ra 0
	addi $sp $sp 1
	jal min_caml_int_of_float	# $i1 = float_of_int(-$f1)
	addi $sp $sp -1
	load $sp $ra 0
	sub $zero $i1 $i1
	jr $ra				# return
FTOI_MAIN:
	load $zero $mi FLOAT_MAGICI	# $mi = 8388608
	load $zero $mf FLOAT_MAGICF	# $mf = 8388608.0
	load $zero $mfhx FLOAT_MAGICFHX	# $mfhx = 0x4b000000
	fcmp $f1 $mf $cond
	bge $cond FTOI_BIG		# if ($f1 >= 8688608.0) goto FTOI_BIG
	fadd $f1 $mf $f1
	store $sp $f1 1
	load $sp $i1 1
	sub $i1 $mfhx $i1
	jr $ra
FTOI_BIG:
	li $q 0				# $f1 = $q * 8388608 + $rf なる$q, $rfを求める
	li $rf 0
	fadd $rf $f1 $rf		# $rf = $i1
FTOI_LOOP:
	addi $q $q 1			# $q += 1
	fsub $rf $mf $rf		# $rf -= 8388608.0
	fcmp $rf $mf $cond
	bge $cond FTOI_LOOP		# if ($rf >= 8388608.0) continue
	li $i1 0
FTOI_LOOP2:
	add $i1 $mi $i1			# $i1 = $q * $mi
	addi $q $q -1
	cmp $q $zero $cond
	bg $cond FTOI_LOOP2
	fadd $rf $mf $rf		# $rf < 8388608.0 だからそのままftoi
	store $sp $rf 1
	load $sp $temp 1
	sub $temp $mfhx $temp		# $temp = ftoi($rf)
	add $i1 $temp $i1		# $i1 = $i1 + $temp (i.e. $i1 = ftoi($q * $mi) + ftoi($rf) )
	jr $ra

FLOAT_MAGICI:
	.int 8388608
FLOAT_MAGICF:
	.float 8388608.0
FLOAT_MAGICFHX:
	.int 1258291200			# 0x4b000000

######################################################################
# * read
# * 失敗してたらループ
######################################################################
min_caml_read:
	read $i1
	li 255, $i2
	cmp $i1, $i2, $i3
	bg $i3, min_caml_read
	ret

######################################################################
# * write
# * 失敗してたらループ
######################################################################
min_caml_write:
	write $i1, $i2
	cmp $i2, $zero, $i3
	bg $i3, min_caml_write
	ret

######################################################################
# * create_array
######################################################################
min_caml_create_array:
	add $i1, $hp, $i3
	mov $hp, $i1
CREATE_ARRAY_LOOP:
	cmp $hp, $i3, $i4
	bge $i4, CREATE_ARRAY_END
	store $i2, 0($hp)
	add $hp, 1, $hp
	b CREATE_ARRAY_LOOP
CREATE_ARRAY_END:
	ret

######################################################################
# * create_float_array
######################################################################
min_caml_create_float_array:
	add $i1, $hp, $i3
	mov $hp, $i1
CREATE_FLOAT_ARRAY_LOOP:
	cmp $hp, $i3, $i4
	bge $i4, CREATE_FLOAT_ARRAY_END
	store $f1, 0($hp)
	add $hp, 1, $hp
	b CREATE_FLOAT_ARRAY_LOOP
CREATE_FLOAT_ARRAY_END:
	ret


######################################################################
#
# 		↑　ここまで lib_asm.s
#
######################################################################
