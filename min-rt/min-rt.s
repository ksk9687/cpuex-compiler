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
	li      0x1000, $hp
	sll		$hp, 4, $hp
	sll     $hp, 3, $sp

######################################################################
#
# 		↑　ここまで macro.s
#
######################################################################
	li      128, $i1
	li      128, $i2
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     rt.3351
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      0, $i12
	halt
cordic_rec.6797:
	li      25, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17419
	mov     $f3, $f1
	ret
be_else.17419:
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.17420
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fadd    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fsub    $f4, $f2, $f4
	load    l.13293, $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6797
ble_else.17420:
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fsub    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fadd    $f4, $f2, $f4
	load    l.13293, $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6797
cordic_sin.2851:
	li      0, $i1
	load    l.13294, $f2
	load    l.13295, $f3
	load    l.13295, $f4
	load    l.13296, $f5
	b       cordic_rec.6797
cordic_rec.6762:
	li      25, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17421
	mov     $f2, $f1
	ret
be_else.17421:
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.17422
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fadd    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fsub    $f4, $f2, $f4
	load    l.13293, $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6762
ble_else.17422:
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fsub    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fadd    $f4, $f2, $f4
	load    l.13293, $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6762
cordic_cos.2853:
	li      0, $i1
	load    l.13294, $f2
	load    l.13295, $f3
	load    l.13295, $f4
	load    l.13296, $f5
	b       cordic_rec.6762
cordic_rec.6728:
	li      25, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17423
	mov     $f3, $f1
	ret
be_else.17423:
	load    l.13295, $f5
	fcmp    $f2, $f5, $i12
	bg      $i12, ble_else.17424
	add     $i1, 1, $i2
	fmul    $f4, $f2, $f5
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f2
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f1
	fsub    $f3, $f1, $f3
	load    l.13293, $f1
	fmul    $f4, $f1, $f4
	mov     $i2, $i1
	mov     $f5, $f1
	b       cordic_rec.6728
ble_else.17424:
	add     $i1, 1, $i2
	fmul    $f4, $f2, $f5
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f2
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f1
	fadd    $f3, $f1, $f3
	load    l.13293, $f1
	fmul    $f4, $f1, $f4
	mov     $i2, $i1
	mov     $f5, $f1
	b       cordic_rec.6728
cordic_atan.2855:
	li      0, $i1
	load    l.13296, $f2
	load    l.13295, $f3
	load    l.13296, $f4
	mov     $f2, $f14
	mov     $f1, $f2
	mov     $f14, $f1
	b       cordic_rec.6728
sin.2857:
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17425
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17426
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17427
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17428
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17429
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17430
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17431
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17432
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	b       sin.2857
ble_else.17432:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17431:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	b       cordic_sin.2851
ble_else.17430:
	b       cordic_sin.2851
ble_else.17429:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17428:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17433
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17435
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17437
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17439
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17440
ble_else.17439:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17440:
	b       ble_cont.17438
ble_else.17437:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17438:
	b       ble_cont.17436
ble_else.17435:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17436:
	b       ble_cont.17434
ble_else.17433:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17434:
	fneg    $f1, $f1
	ret
ble_else.17427:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	b       cordic_sin.2851
ble_else.17426:
	b       cordic_sin.2851
ble_else.17425:
	fneg    $f1, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17441
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17443
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17445
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17447
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17448
ble_else.17447:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17448:
	b       ble_cont.17446
ble_else.17445:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17446:
	b       ble_cont.17444
ble_else.17443:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17444:
	b       ble_cont.17442
ble_else.17441:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17442:
	fneg    $f1, $f1
	ret
cos.2859:
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17449
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17450
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17451
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17452
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17453
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17454
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17455
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17456
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17456:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17455:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17454:
	b       cordic_cos.2853
ble_else.17453:
	fneg    $f1, $f1
	b       cos.2859
ble_else.17452:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17457
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17458
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17459
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17460
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17460:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17459:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17458:
	b       cordic_cos.2853
ble_else.17457:
	fneg    $f1, $f1
	b       cos.2859
ble_else.17451:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17450:
	b       cordic_cos.2853
ble_else.17449:
	fneg    $f1, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17461
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17462
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17463
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17464
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17464:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17463:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17462:
	b       cordic_cos.2853
ble_else.17461:
	fneg    $f1, $f1
	b       cos.2859
get_sqrt_init_rec.6691.10569:
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17465
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17465:
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17466
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17467
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17467:
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17468
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17469
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17469:
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17470
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17471
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17471:
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17472
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	add     $i1, 1, $i1
	b       get_sqrt_init_rec.6691.10569
ble_else.17472:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17470:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17468:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17466:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
sqrt.2865:
	load    l.13296, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17473
	store   $f1, 0($sp)
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17474
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17476
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	load    l.13300, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17478
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	li      3, $i1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     get_sqrt_init_rec.6691.10569
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.17479
ble_else.17478:
	li      min_caml_rsqrt_table, $i1
	load    2($i1), $f1
ble_cont.17479:
	b       ble_cont.17477
ble_else.17476:
	li      min_caml_rsqrt_table, $i1
	load    1($i1), $f1
ble_cont.17477:
	b       ble_cont.17475
ble_else.17474:
	li      min_caml_rsqrt_table, $i1
	load    0($i1), $f1
ble_cont.17475:
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	load    0($sp), $f4
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	load    l.13293, $f2
	fmul    $f2, $f1, $f2
	load    l.13301, $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	fmul    $f1, $f4, $f1
	ret
ble_else.17473:
	load    l.13293, $f2
	finv    $f1, $f15
	fmul    $f1, $f15, $f3
	fadd    $f1, $f3, $f3
	fmul    $f2, $f3, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	load    l.13293, $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	fadd    $f2, $f1, $f1
	fmul    $f3, $f1, $f1
	ret
vecunit_sgn.2896:
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    0($i1), $f1
	fmul    $f1, $f1, $f1
	load    1($i1), $f2
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     sqrt.2865
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17480
	li      1, $i1
	b       be_cont.17481
be_else.17480:
	li      0, $i1
be_cont.17481:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17482
	load    1($sp), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17484
	load    l.13296, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.17485
be_else.17484:
	load    l.13302, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
be_cont.17485:
	b       be_cont.17483
be_else.17482:
	load    l.13296, $f1
be_cont.17483:
	load    0($sp), $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	store   $f2, 0($i1)
	load    1($i1), $f2
	fmul    $f2, $f1, $f2
	store   $f2, 1($i1)
	load    2($i1), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 2($i1)
	ret
vecaccumv.2920:
	load    0($i1), $f1
	load    0($i2), $f2
	load    0($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i1)
	load    1($i1), $f1
	load    1($i2), $f2
	load    1($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 1($i1)
	load    2($i1), $f1
	load    2($i2), $f2
	load    2($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i1)
	ret
read_screen_settings.2997:
	li      min_caml_screen, $i1
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_float
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i1
	store   $f1, 0($i1)
	li      min_caml_screen, $i1
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_float
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i1
	store   $f1, 1($i1)
	li      min_caml_screen, $i1
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_float
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $i1
	store   $f1, 2($i1)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_float
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 3($sp)
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17488
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17490
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17492
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17494
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.17495
ble_else.17494:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17495:
	b       ble_cont.17493
ble_else.17492:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $f1, $f1
ble_cont.17493:
	b       ble_cont.17491
ble_else.17490:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17491:
	b       ble_cont.17489
ble_else.17488:
	fneg    $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17489:
	store   $f1, 4($sp)
	load    l.13295, $f1
	load    3($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17496
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17498
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17500
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17502
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.17503
ble_else.17502:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17503:
	b       ble_cont.17501
ble_else.17500:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17501:
	b       ble_cont.17499
ble_else.17498:
	mov     $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17499:
	b       ble_cont.17497
ble_else.17496:
	fneg    $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17497:
	store   $f1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 6($sp)
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17504
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17506
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17508
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17510
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.17511
ble_else.17510:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17511:
	b       ble_cont.17509
ble_else.17508:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.17509:
	b       ble_cont.17507
ble_else.17506:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17507:
	b       ble_cont.17505
ble_else.17504:
	fneg    $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17505:
	store   $f1, 7($sp)
	load    l.13295, $f1
	load    6($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17512
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17514
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17516
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17518
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       ble_cont.17519
ble_else.17518:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $f1, $f1
ble_cont.17519:
	b       ble_cont.17517
ble_else.17516:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.17517:
	b       ble_cont.17515
ble_else.17514:
	mov     $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.17515:
	b       ble_cont.17513
ble_else.17512:
	fneg    $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $f1, $f1
ble_cont.17513:
	li      min_caml_screenz_dir, $i1
	load    4($sp), $f2
	fmul    $f2, $f1, $f3
	load    l.13304, $f4
	fmul    $f3, $f4, $f3
	store   $f3, 0($i1)
	li      min_caml_screenz_dir, $i1
	load    l.13305, $f3
	load    5($sp), $f4
	fmul    $f4, $f3, $f3
	store   $f3, 1($i1)
	li      min_caml_screenz_dir, $i1
	load    7($sp), $f3
	fmul    $f2, $f3, $f5
	load    l.13304, $f6
	fmul    $f5, $f6, $f5
	store   $f5, 2($i1)
	li      min_caml_screenx_dir, $i1
	store   $f3, 0($i1)
	li      min_caml_screenx_dir, $i1
	load    l.13295, $f5
	store   $f5, 1($i1)
	li      min_caml_screenx_dir, $i1
	fneg    $f1, $f5
	store   $f5, 2($i1)
	li      min_caml_screeny_dir, $i1
	fneg    $f4, $f5
	fmul    $f5, $f1, $f1
	store   $f1, 0($i1)
	li      min_caml_screeny_dir, $i1
	fneg    $f2, $f1
	store   $f1, 1($i1)
	li      min_caml_screeny_dir, $i1
	fneg    $f4, $f1
	fmul    $f1, $f3, $f1
	store   $f1, 2($i1)
	li      min_caml_viewpoint, $i1
	li      min_caml_screen, $i2
	load    0($i2), $f1
	li      min_caml_screenz_dir, $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      min_caml_viewpoint, $i1
	li      min_caml_screen, $i2
	load    1($i2), $f1
	li      min_caml_screenz_dir, $i2
	load    1($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 1($i1)
	li      min_caml_viewpoint, $i1
	li      min_caml_screen, $i2
	load    2($i2), $f1
	li      min_caml_screenz_dir, $i2
	load    2($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($i1)
	ret
read_light.2999:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_read_int
	sub     $sp, 1, $sp
	load    0($sp), $ra
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_read_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($sp)
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17521
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17523
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17525
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17527
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.17528
ble_else.17527:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.17528:
	b       ble_cont.17526
ble_else.17525:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.17526:
	b       ble_cont.17524
ble_else.17523:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.17524:
	b       ble_cont.17522
ble_else.17521:
	fneg    $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.17522:
	li      min_caml_light, $i1
	fneg    $f1, $f1
	store   $f1, 1($i1)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_float
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 1($sp)
	load    l.13295, $f1
	load    0($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17529
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17531
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17533
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17535
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.17536
ble_else.17535:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17536:
	b       ble_cont.17534
ble_else.17533:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.17534:
	b       ble_cont.17532
ble_else.17531:
	mov     $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17532:
	b       ble_cont.17530
ble_else.17529:
	fneg    $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17530:
	store   $f1, 2($sp)
	load    l.13295, $f1
	load    1($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17537
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17539
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17541
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17543
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17544
ble_else.17543:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.17544:
	b       ble_cont.17542
ble_else.17541:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17542:
	b       ble_cont.17540
ble_else.17539:
	mov     $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17540:
	b       ble_cont.17538
ble_else.17537:
	fneg    $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.17538:
	li      min_caml_light, $i1
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 0($i1)
	load    l.13295, $f1
	load    1($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17545
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17547
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17549
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17551
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17552
ble_else.17551:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17552:
	b       ble_cont.17550
ble_else.17549:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.17550:
	b       ble_cont.17548
ble_else.17547:
	mov     $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17548:
	b       ble_cont.17546
ble_else.17545:
	fneg    $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17546:
	li      min_caml_light, $i1
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 2($i1)
	li      min_caml_beam, $i1
	store   $i1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_read_float
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	store   $f1, 0($i1)
	ret
rotate_quadratic_matrix.3001:
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    0($i2), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17554
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17556
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17558
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17560
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.17561
ble_else.17560:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17561:
	b       ble_cont.17559
ble_else.17558:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.17559:
	b       ble_cont.17557
ble_else.17556:
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17557:
	b       ble_cont.17555
ble_else.17554:
	fneg    $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17555:
	store   $f1, 2($sp)
	load    1($sp), $i1
	load    0($i1), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17562
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17564
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17566
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17568
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17569
ble_else.17568:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.17569:
	b       ble_cont.17567
ble_else.17566:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17567:
	b       ble_cont.17565
ble_else.17564:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17565:
	b       ble_cont.17563
ble_else.17562:
	fneg    $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.17563:
	store   $f1, 3($sp)
	load    1($sp), $i1
	load    1($i1), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17570
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17572
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17574
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17576
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.17577
ble_else.17576:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17577:
	b       ble_cont.17575
ble_else.17574:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $f1, $f1
ble_cont.17575:
	b       ble_cont.17573
ble_else.17572:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17573:
	b       ble_cont.17571
ble_else.17570:
	fneg    $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17571:
	store   $f1, 4($sp)
	load    1($sp), $i1
	load    1($i1), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17578
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17580
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17582
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17584
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.17585
ble_else.17584:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17585:
	b       ble_cont.17583
ble_else.17582:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17583:
	b       ble_cont.17581
ble_else.17580:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17581:
	b       ble_cont.17579
ble_else.17578:
	fneg    $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17579:
	store   $f1, 5($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17586
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17588
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17590
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17592
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.17593
ble_else.17592:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17593:
	b       ble_cont.17591
ble_else.17590:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $f1, $f1
ble_cont.17591:
	b       ble_cont.17589
ble_else.17588:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17589:
	b       ble_cont.17587
ble_else.17586:
	fneg    $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17587:
	store   $f1, 6($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17594
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17596
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17598
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17600
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.17601
ble_else.17600:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.17601:
	b       ble_cont.17599
ble_else.17598:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17599:
	b       ble_cont.17597
ble_else.17596:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17597:
	b       ble_cont.17595
ble_else.17594:
	fneg    $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.17595:
	load    6($sp), $f2
	load    4($sp), $f3
	fmul    $f3, $f2, $f4
	load    5($sp), $f5
	load    3($sp), $f6
	fmul    $f6, $f5, $f7
	fmul    $f7, $f2, $f7
	load    2($sp), $f8
	fmul    $f8, $f1, $f9
	fsub    $f7, $f9, $f7
	fmul    $f8, $f5, $f9
	fmul    $f9, $f2, $f9
	fmul    $f6, $f1, $f10
	fadd    $f9, $f10, $f9
	fmul    $f3, $f1, $f10
	fmul    $f6, $f5, $f11
	fmul    $f11, $f1, $f11
	fmul    $f8, $f2, $f12
	fadd    $f11, $f12, $f11
	store   $f11, 7($sp)
	fmul    $f8, $f5, $f12
	fmul    $f12, $f1, $f1
	fmul    $f6, $f2, $f2
	fsub    $f1, $f2, $f1
	fneg    $f5, $f2
	fmul    $f6, $f3, $f5
	fmul    $f8, $f3, $f3
	load    0($sp), $i1
	load    0($i1), $f6
	load    1($i1), $f8
	load    2($i1), $f12
	fmul    $f4, $f4, $f13
	fmul    $f6, $f13, $f13
	fmul    $f10, $f10, $f14
	fmul    $f8, $f14, $f14
	fadd    $f13, $f14, $f13
	fmul    $f2, $f2, $f14
	fmul    $f12, $f14, $f14
	fadd    $f13, $f14, $f13
	store   $f13, 0($i1)
	fmul    $f7, $f7, $f13
	fmul    $f6, $f13, $f13
	fmul    $f11, $f11, $f14
	fmul    $f8, $f14, $f14
	fadd    $f13, $f14, $f13
	fmul    $f5, $f5, $f14
	fmul    $f12, $f14, $f14
	fadd    $f13, $f14, $f13
	store   $f13, 1($i1)
	fmul    $f9, $f9, $f13
	fmul    $f6, $f13, $f13
	fmul    $f1, $f1, $f14
	fmul    $f8, $f14, $f14
	fadd    $f13, $f14, $f13
	fmul    $f3, $f3, $f14
	fmul    $f12, $f14, $f14
	fadd    $f13, $f14, $f13
	store   $f13, 2($i1)
	load    l.13300, $f13
	fmul    $f6, $f7, $f14
	fmul    $f14, $f9, $f14
	fmul    $f8, $f11, $f11
	fmul    $f11, $f1, $f11
	fadd    $f14, $f11, $f11
	fmul    $f12, $f5, $f14
	fmul    $f14, $f3, $f14
	fadd    $f11, $f14, $f11
	fmul    $f13, $f11, $f11
	load    1($sp), $i1
	store   $f11, 0($i1)
	load    l.13300, $f11
	fmul    $f6, $f4, $f13
	fmul    $f13, $f9, $f9
	fmul    $f8, $f10, $f13
	fmul    $f13, $f1, $f1
	fadd    $f9, $f1, $f1
	fmul    $f12, $f2, $f9
	fmul    $f9, $f3, $f3
	fadd    $f1, $f3, $f1
	fmul    $f11, $f1, $f1
	store   $f1, 1($i1)
	load    l.13300, $f1
	fmul    $f6, $f4, $f3
	fmul    $f3, $f7, $f3
	fmul    $f8, $f10, $f4
	load    7($sp), $f6
	fmul    $f4, $f6, $f4
	fadd    $f3, $f4, $f3
	fmul    $f12, $f2, $f2
	fmul    $f2, $f5, $f2
	fadd    $f3, $f2, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 2($i1)
	ret
read_nth_object.3004:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17603
	li      0, $i1
	ret
be_else.17603:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $i1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_read_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $i1, 4($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_float_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	store   $f1, 1($i1)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	store   $f1, 2($i1)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i1
	store   $f1, 1($i1)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i1
	store   $f1, 2($i1)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17604
	li      0, $i1
	b       ble_cont.17605
ble_else.17604:
	li      1, $i1
ble_cont.17605:
	store   $i1, 7($sp)
	li      2, $i1
	load    l.13295, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $i1, 8($sp)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_read_float
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_read_float
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $i1
	store   $f1, 1($i1)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_float_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	store   $i1, 9($sp)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $i1
	store   $f1, 1($i1)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $i1
	store   $f1, 2($i1)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_float_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $i1, 10($sp)
	load    4($sp), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17606
	b       be_cont.17607
be_else.17606:
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 1($i1)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 2($i1)
be_cont.17607:
	load    2($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17608
	li      1, $i1
	b       be_cont.17609
be_else.17608:
	load    7($sp), $i1
be_cont.17609:
	store   $i1, 11($sp)
	li      4, $i1
	load    l.13295, $f1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_float_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	mov     $hp, $i2
	add     $hp, 11, $hp
	store   $i1, 10($i2)
	load    10($sp), $i1
	store   $i1, 9($i2)
	load    9($sp), $i1
	store   $i1, 8($i2)
	load    8($sp), $i1
	store   $i1, 7($i2)
	load    11($sp), $i1
	store   $i1, 6($i2)
	load    6($sp), $i1
	store   $i1, 5($i2)
	load    5($sp), $i1
	store   $i1, 4($i2)
	load    4($sp), $i3
	store   $i3, 3($i2)
	load    3($sp), $i3
	store   $i3, 2($i2)
	load    2($sp), $i3
	store   $i3, 1($i2)
	load    1($sp), $i4
	store   $i4, 0($i2)
	li      min_caml_objects, $i4
	load    0($sp), $i5
	add     $i4, $i5, $i12
	store   $i2, 0($i12)
	li      3, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17610
	load    0($i1), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17612
	li      1, $i2
	b       be_cont.17613
be_else.17612:
	li      0, $i2
be_cont.17613:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17614
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17616
	li      1, $i2
	b       be_cont.17617
be_else.17616:
	li      0, $i2
be_cont.17617:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17618
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17620
	li      0, $i2
	b       ble_cont.17621
ble_else.17620:
	li      1, $i2
ble_cont.17621:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17622
	load    l.13302, $f2
	b       be_cont.17623
be_else.17622:
	load    l.13296, $f2
be_cont.17623:
	b       be_cont.17619
be_else.17618:
	load    l.13295, $f2
be_cont.17619:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.17615
be_else.17614:
	load    l.13295, $f1
be_cont.17615:
	store   $f1, 0($i1)
	load    1($i1), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17624
	li      1, $i2
	b       be_cont.17625
be_else.17624:
	li      0, $i2
be_cont.17625:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17626
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17628
	li      1, $i2
	b       be_cont.17629
be_else.17628:
	li      0, $i2
be_cont.17629:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17630
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17632
	li      0, $i2
	b       ble_cont.17633
ble_else.17632:
	li      1, $i2
ble_cont.17633:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17634
	load    l.13302, $f2
	b       be_cont.17635
be_else.17634:
	load    l.13296, $f2
be_cont.17635:
	b       be_cont.17631
be_else.17630:
	load    l.13295, $f2
be_cont.17631:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.17627
be_else.17626:
	load    l.13295, $f1
be_cont.17627:
	store   $f1, 1($i1)
	load    2($i1), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17636
	li      1, $i2
	b       be_cont.17637
be_else.17636:
	li      0, $i2
be_cont.17637:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17638
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17640
	li      1, $i2
	b       be_cont.17641
be_else.17640:
	li      0, $i2
be_cont.17641:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17642
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17644
	li      0, $i2
	b       ble_cont.17645
ble_else.17644:
	li      1, $i2
ble_cont.17645:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17646
	load    l.13302, $f2
	b       be_cont.17647
be_else.17646:
	load    l.13296, $f2
be_cont.17647:
	b       be_cont.17643
be_else.17642:
	load    l.13295, $f2
be_cont.17643:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.17639
be_else.17638:
	load    l.13295, $f1
be_cont.17639:
	store   $f1, 2($i1)
	b       be_cont.17611
be_else.17610:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17648
	load    7($sp), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17650
	li      1, $i2
	b       be_cont.17651
be_else.17650:
	li      0, $i2
be_cont.17651:
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     vecunit_sgn.2896
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       be_cont.17649
be_else.17648:
be_cont.17649:
be_cont.17611:
	load    4($sp), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17652
	b       be_cont.17653
be_else.17652:
	load    5($sp), $i1
	load    10($sp), $i2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     rotate_quadratic_matrix.3001
	sub     $sp, 13, $sp
	load    12($sp), $ra
be_cont.17653:
	li      1, $i1
	ret
read_object.3006:
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.17654
	ret
bge_else.17654:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     read_nth_object.3004
	sub     $sp, 2, $sp
	load    1($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17656
	li      min_caml_n_objects, $i1
	load    0($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.17656:
	load    0($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.17658
	ret
bge_else.17658:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     read_nth_object.3004
	sub     $sp, 3, $sp
	load    2($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17660
	li      min_caml_n_objects, $i1
	load    1($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.17660:
	load    1($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.17662
	ret
bge_else.17662:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     read_nth_object.3004
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17664
	li      min_caml_n_objects, $i1
	load    2($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.17664:
	load    2($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.17666
	ret
bge_else.17666:
	store   $i1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_nth_object.3004
	sub     $sp, 5, $sp
	load    4($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17668
	li      min_caml_n_objects, $i1
	load    3($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.17668:
	load    3($sp), $i1
	add     $i1, 1, $i1
	b       read_object.3006
read_net_item.3010:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17670
	load    0($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	b       min_caml_create_array
be_else.17670:
	store   $i1, 1($sp)
	load    0($sp), $i1
	add     $i1, 1, $i1
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17671
	load    2($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17672
be_else.17671:
	store   $i1, 3($sp)
	load    2($sp), $i1
	add     $i1, 1, $i1
	store   $i1, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_read_int
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17673
	load    4($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17674
be_else.17673:
	store   $i1, 5($sp)
	load    4($sp), $i1
	add     $i1, 1, $i1
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17675
	load    6($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.17676
be_else.17675:
	store   $i1, 7($sp)
	load    6($sp), $i1
	add     $i1, 1, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     read_net_item.3010
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $i2
	load    7($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.17676:
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.17674:
	load    2($sp), $i2
	load    3($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.17672:
	load    0($sp), $i2
	load    1($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
	ret
read_or_network.3012:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17677
	li      1, $i1
	li      -1, $i2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.17678
be_else.17677:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17679
	li      2, $i1
	li      -1, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.17680
be_else.17679:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17681
	li      3, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17682
be_else.17681:
	store   $i1, 3($sp)
	li      3, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i2
	store   $i2, 2($i1)
be_cont.17682:
	load    2($sp), $i2
	store   $i2, 1($i1)
be_cont.17680:
	load    1($sp), $i2
	store   $i2, 0($i1)
be_cont.17678:
	mov     $i1, $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17683
	load    0($sp), $i1
	add     $i1, 1, $i1
	b       min_caml_create_array
be_else.17683:
	store   $i2, 4($sp)
	load    0($sp), $i1
	add     $i1, 1, $i1
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17684
	li      1, $i1
	li      -1, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17685
be_else.17684:
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17686
	li      2, $i1
	li      -1, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.17687
be_else.17686:
	store   $i1, 7($sp)
	li      2, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     read_net_item.3010
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $i2
	store   $i2, 1($i1)
be_cont.17687:
	load    6($sp), $i2
	store   $i2, 0($i1)
be_cont.17685:
	mov     $i1, $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17688
	load    5($sp), $i1
	add     $i1, 1, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.17689
be_else.17688:
	store   $i2, 8($sp)
	load    5($sp), $i1
	add     $i1, 1, $i1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     read_or_network.3012
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    5($sp), $i2
	load    8($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.17689:
	load    0($sp), $i2
	load    4($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
	ret
read_and_network.3014:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17690
	li      1, $i1
	li      -1, $i2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.17691
be_else.17690:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17692
	li      2, $i1
	li      -1, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.17693
be_else.17692:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17694
	li      3, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17695
be_else.17694:
	store   $i1, 3($sp)
	li      3, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i2
	store   $i2, 2($i1)
be_cont.17695:
	load    2($sp), $i2
	store   $i2, 1($i1)
be_cont.17693:
	load    1($sp), $i2
	store   $i2, 0($i1)
be_cont.17691:
	load    0($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17696
	ret
be_else.17696:
	li      min_caml_and_net, $i2
	load    0($sp), $i3
	add     $i2, $i3, $i12
	store   $i1, 0($i12)
	add     $i3, 1, $i1
	store   $i1, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_read_int
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17698
	li      1, $i1
	li      -1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17699
be_else.17698:
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17700
	li      2, $i1
	li      -1, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17701
be_else.17700:
	store   $i1, 6($sp)
	li      2, $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     read_net_item.3010
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i2
	store   $i2, 1($i1)
be_cont.17701:
	load    5($sp), $i2
	store   $i2, 0($i1)
be_cont.17699:
	load    0($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17702
	ret
be_else.17702:
	li      min_caml_and_net, $i2
	load    4($sp), $i3
	add     $i2, $i3, $i12
	store   $i1, 0($i12)
	add     $i3, 1, $i1
	b       read_and_network.3014
solver_rect_surface.3018:
	add     $i2, $i3, $i12
	load    0($i12), $f4
	load    l.13295, $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.17704
	li      1, $i6
	b       be_cont.17705
be_else.17704:
	li      0, $i6
be_cont.17705:
	cmp     $i6, $zero, $i12
	bne     $i12, be_else.17706
	load    4($i1), $i6
	load    6($i1), $i1
	add     $i2, $i3, $i12
	load    0($i12), $f4
	load    l.13295, $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.17707
	li      0, $i7
	b       ble_cont.17708
ble_else.17707:
	li      1, $i7
ble_cont.17708:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17709
	mov     $i7, $i1
	b       be_cont.17710
be_else.17709:
	cmp     $i7, $zero, $i12
	bne     $i12, be_else.17711
	li      1, $i1
	b       be_cont.17712
be_else.17711:
	li      0, $i1
be_cont.17712:
be_cont.17710:
	add     $i6, $i3, $i12
	load    0($i12), $f4
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17713
	fneg    $f4, $f4
	b       be_cont.17714
be_else.17713:
be_cont.17714:
	fsub    $f4, $f1, $f1
	add     $i2, $i3, $i12
	load    0($i12), $f4
	finv    $f4, $f15
	fmul    $f1, $f15, $f1
	add     $i2, $i4, $i12
	load    0($i12), $f4
	fmul    $f1, $f4, $f4
	fadd    $f4, $f2, $f2
	load    l.13295, $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.17715
	b       ble_cont.17716
ble_else.17715:
	fneg    $f2, $f2
ble_cont.17716:
	add     $i6, $i4, $i12
	load    0($i12), $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.17717
	li      0, $i1
	b       ble_cont.17718
ble_else.17717:
	li      1, $i1
ble_cont.17718:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17719
	li      0, $i1
	ret
be_else.17719:
	add     $i2, $i5, $i12
	load    0($i12), $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $f3, $f2
	load    l.13295, $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.17720
	b       ble_cont.17721
ble_else.17720:
	fneg    $f2, $f2
ble_cont.17721:
	add     $i6, $i5, $i12
	load    0($i12), $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.17722
	li      0, $i1
	b       ble_cont.17723
ble_else.17722:
	li      1, $i1
ble_cont.17723:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17724
	li      0, $i1
	ret
be_else.17724:
	li      min_caml_solver_dist, $i1
	store   $f1, 0($i1)
	li      1, $i1
	ret
be_else.17706:
	li      0, $i1
	ret
solver_surface.3033:
	load    4($i1), $i1
	load    0($i2), $f4
	load    0($i1), $f5
	fmul    $f4, $f5, $f4
	load    1($i2), $f5
	load    1($i1), $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    2($i2), $f5
	load    2($i1), $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    l.13295, $f5
	fcmp    $f4, $f5, $i12
	bg      $i12, ble_else.17725
	li      0, $i2
	b       ble_cont.17726
ble_else.17725:
	li      1, $i2
ble_cont.17726:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17727
	li      0, $i1
	ret
be_else.17727:
	li      min_caml_solver_dist, $i2
	load    0($i1), $f5
	fmul    $f5, $f1, $f1
	load    1($i1), $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	finv    $f4, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 0($i2)
	li      1, $i1
	ret
quadratic.3039:
	fmul    $f1, $f1, $f4
	load    4($i1), $i2
	load    0($i2), $f5
	fmul    $f4, $f5, $f4
	fmul    $f2, $f2, $f5
	load    4($i1), $i2
	load    1($i2), $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f3, $f5
	load    4($i1), $i2
	load    2($i2), $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	load    3($i1), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17728
	mov     $f4, $f1
	ret
be_else.17728:
	fmul    $f2, $f3, $f5
	load    9($i1), $i2
	load    0($i2), $f6
	fmul    $f5, $f6, $f5
	fadd    $f4, $f5, $f4
	fmul    $f3, $f1, $f3
	load    9($i1), $i2
	load    1($i2), $f5
	fmul    $f3, $f5, $f3
	fadd    $f4, $f3, $f3
	fmul    $f1, $f2, $f1
	load    9($i1), $i1
	load    2($i1), $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	ret
bilinear.3044:
	fmul    $f1, $f4, $f7
	load    4($i1), $i2
	load    0($i2), $f8
	fmul    $f7, $f8, $f7
	fmul    $f2, $f5, $f8
	load    4($i1), $i2
	load    1($i2), $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	fmul    $f3, $f6, $f8
	load    4($i1), $i2
	load    2($i2), $f9
	fmul    $f8, $f9, $f8
	fadd    $f7, $f8, $f7
	load    3($i1), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17729
	mov     $f7, $f1
	ret
be_else.17729:
	fmul    $f3, $f5, $f8
	fmul    $f2, $f6, $f9
	fadd    $f8, $f9, $f8
	load    9($i1), $i2
	load    0($i2), $f9
	fmul    $f8, $f9, $f8
	fmul    $f1, $f6, $f6
	fmul    $f3, $f4, $f3
	fadd    $f6, $f3, $f3
	load    9($i1), $i2
	load    1($i2), $f6
	fmul    $f3, $f6, $f3
	fadd    $f8, $f3, $f3
	fmul    $f1, $f5, $f1
	fmul    $f2, $f4, $f2
	fadd    $f1, $f2, $f1
	load    9($i1), $i1
	load    2($i1), $f2
	fmul    $f1, $f2, $f1
	fadd    $f3, $f1, $f1
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	fadd    $f7, $f1, $f1
	ret
solver_second.3052:
	store   $f3, 0($sp)
	store   $f2, 1($sp)
	store   $f1, 2($sp)
	store   $i1, 3($sp)
	store   $i2, 4($sp)
	load    0($i2), $f1
	load    1($i2), $f2
	load    2($i2), $f3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     quadratic.3039
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17730
	li      1, $i1
	b       be_cont.17731
be_else.17730:
	li      0, $i1
be_cont.17731:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17732
	store   $f1, 5($sp)
	load    4($sp), $i1
	load    0($i1), $f1
	load    1($i1), $f2
	load    2($i1), $f3
	load    2($sp), $f4
	load    1($sp), $f5
	load    0($sp), $f6
	load    3($sp), $i1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     bilinear.3044
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $f1, 6($sp)
	load    2($sp), $f1
	load    1($sp), $f2
	load    0($sp), $f3
	load    3($sp), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     quadratic.3039
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    3($sp), $i1
	load    1($i1), $i2
	li      3, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17733
	load    l.13296, $f2
	fsub    $f1, $f2, $f1
	b       be_cont.17734
be_else.17733:
be_cont.17734:
	load    6($sp), $f2
	fmul    $f2, $f2, $f3
	load    5($sp), $f4
	fmul    $f4, $f1, $f1
	fsub    $f3, $f1, $f1
	load    l.13295, $f3
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.17735
	li      0, $i2
	b       ble_cont.17736
ble_else.17735:
	li      1, $i2
ble_cont.17736:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17737
	li      0, $i1
	ret
be_else.17737:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    3($sp), $i1
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17738
	fneg    $f1, $f1
	b       be_cont.17739
be_else.17738:
be_cont.17739:
	li      min_caml_solver_dist, $i1
	load    6($sp), $f2
	fsub    $f1, $f2, $f1
	load    5($sp), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 0($i1)
	li      1, $i1
	ret
be_else.17732:
	li      0, $i1
	ret
solver_rect_fast.3062:
	load    0($i3), $f4
	fsub    $f4, $f1, $f4
	load    1($i3), $f5
	fmul    $f4, $f5, $f4
	load    1($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f2, $f5
	load    l.13295, $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17740
	b       ble_cont.17741
ble_else.17740:
	fneg    $f5, $f5
ble_cont.17741:
	load    4($i1), $i4
	load    1($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17742
	li      0, $i4
	b       ble_cont.17743
ble_else.17742:
	li      1, $i4
ble_cont.17743:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17744
	li      0, $i4
	b       be_cont.17745
be_else.17744:
	load    2($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f3, $f5
	load    l.13295, $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17746
	b       ble_cont.17747
ble_else.17746:
	fneg    $f5, $f5
ble_cont.17747:
	load    4($i1), $i4
	load    2($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17748
	li      0, $i4
	b       ble_cont.17749
ble_else.17748:
	li      1, $i4
ble_cont.17749:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17750
	li      0, $i4
	b       be_cont.17751
be_else.17750:
	load    1($i3), $f5
	load    l.13295, $f6
	fcmp    $f5, $f6, $i12
	bne     $i12, be_else.17752
	li      1, $i4
	b       be_cont.17753
be_else.17752:
	li      0, $i4
be_cont.17753:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17754
	li      1, $i4
	b       be_cont.17755
be_else.17754:
	li      0, $i4
be_cont.17755:
be_cont.17751:
be_cont.17745:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17756
	load    2($i3), $f4
	fsub    $f4, $f2, $f4
	load    3($i3), $f5
	fmul    $f4, $f5, $f4
	load    0($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f1, $f5
	load    l.13295, $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17757
	b       ble_cont.17758
ble_else.17757:
	fneg    $f5, $f5
ble_cont.17758:
	load    4($i1), $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17759
	li      0, $i4
	b       ble_cont.17760
ble_else.17759:
	li      1, $i4
ble_cont.17760:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17761
	li      0, $i4
	b       be_cont.17762
be_else.17761:
	load    2($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f3, $f5
	load    l.13295, $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17763
	b       ble_cont.17764
ble_else.17763:
	fneg    $f5, $f5
ble_cont.17764:
	load    4($i1), $i4
	load    2($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.17765
	li      0, $i4
	b       ble_cont.17766
ble_else.17765:
	li      1, $i4
ble_cont.17766:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17767
	li      0, $i4
	b       be_cont.17768
be_else.17767:
	load    3($i3), $f5
	load    l.13295, $f6
	fcmp    $f5, $f6, $i12
	bne     $i12, be_else.17769
	li      1, $i4
	b       be_cont.17770
be_else.17769:
	li      0, $i4
be_cont.17770:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17771
	li      1, $i4
	b       be_cont.17772
be_else.17771:
	li      0, $i4
be_cont.17772:
be_cont.17768:
be_cont.17762:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17773
	load    4($i3), $f4
	fsub    $f4, $f3, $f3
	load    5($i3), $f4
	fmul    $f3, $f4, $f3
	load    0($i2), $f4
	fmul    $f3, $f4, $f4
	fadd    $f4, $f1, $f1
	load    l.13295, $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17774
	b       ble_cont.17775
ble_else.17774:
	fneg    $f1, $f1
ble_cont.17775:
	load    4($i1), $i4
	load    0($i4), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17776
	li      0, $i4
	b       ble_cont.17777
ble_else.17776:
	li      1, $i4
ble_cont.17777:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17778
	li      0, $i1
	b       be_cont.17779
be_else.17778:
	load    1($i2), $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17780
	b       ble_cont.17781
ble_else.17780:
	fneg    $f1, $f1
ble_cont.17781:
	load    4($i1), $i1
	load    1($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17782
	li      0, $i1
	b       ble_cont.17783
ble_else.17782:
	li      1, $i1
ble_cont.17783:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17784
	li      0, $i1
	b       be_cont.17785
be_else.17784:
	load    5($i3), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17786
	li      1, $i1
	b       be_cont.17787
be_else.17786:
	li      0, $i1
be_cont.17787:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17788
	li      1, $i1
	b       be_cont.17789
be_else.17788:
	li      0, $i1
be_cont.17789:
be_cont.17785:
be_cont.17779:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17790
	li      0, $i1
	ret
be_else.17790:
	li      min_caml_solver_dist, $i1
	store   $f3, 0($i1)
	li      3, $i1
	ret
be_else.17773:
	li      min_caml_solver_dist, $i1
	store   $f4, 0($i1)
	li      2, $i1
	ret
be_else.17756:
	li      min_caml_solver_dist, $i1
	store   $f4, 0($i1)
	li      1, $i1
	ret
solver_second_fast.3075:
	load    0($i2), $f4
	load    l.13295, $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.17791
	li      1, $i3
	b       be_cont.17792
be_else.17791:
	li      0, $i3
be_cont.17792:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.17793
	store   $i2, 0($sp)
	store   $f4, 1($sp)
	store   $i1, 2($sp)
	load    1($i2), $f4
	fmul    $f4, $f1, $f4
	load    2($i2), $f5
	fmul    $f5, $f2, $f5
	fadd    $f4, $f5, $f4
	load    3($i2), $f5
	fmul    $f5, $f3, $f5
	fadd    $f4, $f5, $f4
	store   $f4, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     quadratic.3039
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    2($sp), $i1
	load    1($i1), $i2
	li      3, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17794
	load    l.13296, $f2
	fsub    $f1, $f2, $f1
	b       be_cont.17795
be_else.17794:
be_cont.17795:
	load    3($sp), $f2
	fmul    $f2, $f2, $f3
	load    1($sp), $f4
	fmul    $f4, $f1, $f1
	fsub    $f3, $f1, $f1
	load    l.13295, $f3
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.17796
	li      0, $i2
	b       ble_cont.17797
ble_else.17796:
	li      1, $i2
ble_cont.17797:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17798
	li      0, $i1
	ret
be_else.17798:
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17799
	li      min_caml_solver_dist, $i1
	store   $i1, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sqrt.2865
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $f2
	fsub    $f2, $f1, $f1
	load    0($sp), $i1
	load    4($i1), $f2
	fmul    $f1, $f2, $f1
	load    4($sp), $i1
	store   $f1, 0($i1)
	b       be_cont.17800
be_else.17799:
	li      min_caml_solver_dist, $i1
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     sqrt.2865
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    3($sp), $f2
	fadd    $f2, $f1, $f1
	load    0($sp), $i1
	load    4($i1), $f2
	fmul    $f1, $f2, $f1
	load    5($sp), $i1
	store   $f1, 0($i1)
be_cont.17800:
	li      1, $i1
	ret
be_else.17793:
	li      0, $i1
	ret
solver_second_fast2.3092:
	load    0($i2), $f4
	load    l.13295, $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.17801
	li      1, $i4
	b       be_cont.17802
be_else.17801:
	li      0, $i4
be_cont.17802:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17803
	load    1($i2), $f5
	fmul    $f5, $f1, $f1
	load    2($i2), $f5
	fmul    $f5, $f2, $f2
	fadd    $f1, $f2, $f1
	load    3($i2), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    3($i3), $f2
	fmul    $f1, $f1, $f3
	fmul    $f4, $f2, $f2
	fsub    $f3, $f2, $f2
	load    l.13295, $f3
	fcmp    $f2, $f3, $i12
	bg      $i12, ble_else.17804
	li      0, $i3
	b       ble_cont.17805
ble_else.17804:
	li      1, $i3
ble_cont.17805:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.17806
	li      0, $i1
	ret
be_else.17806:
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17807
	store   $i2, 0($sp)
	store   $f1, 1($sp)
	li      min_caml_solver_dist, $i1
	store   $i1, 2($sp)
	mov     $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sqrt.2865
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $f2
	fsub    $f2, $f1, $f1
	load    0($sp), $i1
	load    4($i1), $f2
	fmul    $f1, $f2, $f1
	load    2($sp), $i1
	store   $f1, 0($i1)
	b       be_cont.17808
be_else.17807:
	store   $i2, 0($sp)
	store   $f1, 1($sp)
	li      min_caml_solver_dist, $i1
	store   $i1, 3($sp)
	mov     $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     sqrt.2865
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    1($sp), $f2
	fadd    $f2, $f1, $f1
	load    0($sp), $i1
	load    4($i1), $f2
	fmul    $f1, $f2, $f1
	load    3($sp), $i1
	store   $f1, 0($i1)
be_cont.17808:
	li      1, $i1
	ret
be_else.17803:
	li      0, $i1
	ret
setup_rect_table.3102:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      6, $i1
	load    l.13295, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i2
	load    0($i2), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17809
	li      1, $i3
	b       be_cont.17810
be_else.17809:
	li      0, $i3
be_cont.17810:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.17811
	load    0($sp), $i3
	load    6($i3), $i4
	load    0($i2), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17813
	li      0, $i5
	b       ble_cont.17814
ble_else.17813:
	li      1, $i5
ble_cont.17814:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17815
	mov     $i5, $i4
	b       be_cont.17816
be_else.17815:
	cmp     $i5, $zero, $i12
	bne     $i12, be_else.17817
	li      1, $i4
	b       be_cont.17818
be_else.17817:
	li      0, $i4
be_cont.17818:
be_cont.17816:
	load    4($i3), $i3
	load    0($i3), $f1
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17819
	fneg    $f1, $f1
	b       be_cont.17820
be_else.17819:
be_cont.17820:
	store   $f1, 0($i1)
	load    l.13296, $f1
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 1($i1)
	b       be_cont.17812
be_else.17811:
	load    l.13295, $f1
	store   $f1, 1($i1)
be_cont.17812:
	load    1($i2), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17821
	li      1, $i3
	b       be_cont.17822
be_else.17821:
	li      0, $i3
be_cont.17822:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.17823
	load    0($sp), $i3
	load    6($i3), $i4
	load    1($i2), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17825
	li      0, $i5
	b       ble_cont.17826
ble_else.17825:
	li      1, $i5
ble_cont.17826:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17827
	mov     $i5, $i4
	b       be_cont.17828
be_else.17827:
	cmp     $i5, $zero, $i12
	bne     $i12, be_else.17829
	li      1, $i4
	b       be_cont.17830
be_else.17829:
	li      0, $i4
be_cont.17830:
be_cont.17828:
	load    4($i3), $i3
	load    1($i3), $f1
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17831
	fneg    $f1, $f1
	b       be_cont.17832
be_else.17831:
be_cont.17832:
	store   $f1, 2($i1)
	load    l.13296, $f1
	load    1($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 3($i1)
	b       be_cont.17824
be_else.17823:
	load    l.13295, $f1
	store   $f1, 3($i1)
be_cont.17824:
	load    2($i2), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17833
	li      1, $i3
	b       be_cont.17834
be_else.17833:
	li      0, $i3
be_cont.17834:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.17835
	load    0($sp), $i3
	load    6($i3), $i4
	load    2($i2), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17837
	li      0, $i5
	b       ble_cont.17838
ble_else.17837:
	li      1, $i5
ble_cont.17838:
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17839
	mov     $i5, $i4
	b       be_cont.17840
be_else.17839:
	cmp     $i5, $zero, $i12
	bne     $i12, be_else.17841
	li      1, $i4
	b       be_cont.17842
be_else.17841:
	li      0, $i4
be_cont.17842:
be_cont.17840:
	load    4($i3), $i3
	load    2($i3), $f1
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17843
	fneg    $f1, $f1
	b       be_cont.17844
be_else.17843:
be_cont.17844:
	store   $f1, 4($i1)
	load    l.13296, $f1
	load    2($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 5($i1)
	b       be_cont.17836
be_else.17835:
	load    l.13295, $f1
	store   $f1, 5($i1)
be_cont.17836:
	ret
setup_surface_table.3105:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      4, $i1
	load    l.13295, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i2
	load    0($i2), $f1
	load    0($sp), $i3
	load    4($i3), $i4
	load    0($i4), $f2
	fmul    $f1, $f2, $f1
	load    1($i2), $f2
	load    4($i3), $i4
	load    1($i4), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i2), $f2
	load    4($i3), $i2
	load    2($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17845
	li      0, $i2
	b       ble_cont.17846
ble_else.17845:
	li      1, $i2
ble_cont.17846:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17847
	load    l.13295, $f1
	store   $f1, 0($i1)
	b       be_cont.17848
be_else.17847:
	load    l.13302, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f2
	store   $f2, 0($i1)
	load    4($i3), $i2
	load    0($i2), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f2
	fneg    $f2, $f2
	store   $f2, 1($i1)
	load    4($i3), $i2
	load    1($i2), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f2
	fneg    $f2, $f2
	store   $f2, 2($i1)
	load    4($i3), $i2
	load    2($i2), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	fneg    $f1, $f1
	store   $f1, 3($i1)
be_cont.17848:
	ret
setup_second_table.3108:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      5, $i1
	load    l.13295, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $i1, 2($sp)
	load    1($sp), $i1
	load    0($i1), $f1
	load    1($i1), $f2
	load    2($i1), $f3
	load    0($sp), $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     quadratic.3039
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $i1
	load    0($i1), $f2
	load    0($sp), $i2
	load    4($i2), $i3
	load    0($i3), $f3
	fmul    $f2, $f3, $f2
	fneg    $f2, $f2
	load    1($i1), $f3
	load    4($i2), $i3
	load    1($i3), $f4
	fmul    $f3, $f4, $f3
	fneg    $f3, $f3
	load    2($i1), $f4
	load    4($i2), $i3
	load    2($i3), $f5
	fmul    $f4, $f5, $f4
	fneg    $f4, $f4
	load    2($sp), $i3
	store   $f1, 0($i3)
	load    3($i2), $i4
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.17849
	store   $f2, 1($i3)
	store   $f3, 2($i3)
	store   $f4, 3($i3)
	b       be_cont.17850
be_else.17849:
	load    2($i1), $f5
	load    9($i2), $i4
	load    1($i4), $f6
	fmul    $f5, $f6, $f5
	load    1($i1), $f6
	load    9($i2), $i4
	load    2($i4), $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	load    l.13293, $f6
	fmul    $f5, $f6, $f5
	fsub    $f2, $f5, $f2
	store   $f2, 1($i3)
	load    2($i1), $f2
	load    9($i2), $i4
	load    0($i4), $f5
	fmul    $f2, $f5, $f2
	load    0($i1), $f5
	load    9($i2), $i4
	load    2($i4), $f6
	fmul    $f5, $f6, $f5
	fadd    $f2, $f5, $f2
	load    l.13293, $f5
	fmul    $f2, $f5, $f2
	fsub    $f3, $f2, $f2
	store   $f2, 2($i3)
	load    1($i1), $f2
	load    9($i2), $i4
	load    0($i4), $f3
	fmul    $f2, $f3, $f2
	load    0($i1), $f3
	load    9($i2), $i1
	load    1($i1), $f5
	fmul    $f3, $f5, $f3
	fadd    $f2, $f3, $f2
	load    l.13293, $f3
	fmul    $f2, $f3, $f2
	fsub    $f4, $f2, $f2
	store   $f2, 3($i3)
be_cont.17850:
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17851
	li      1, $i1
	b       be_cont.17852
be_else.17851:
	li      0, $i1
be_cont.17852:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17853
	load    l.13296, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	store   $f1, 4($i3)
	b       be_cont.17854
be_else.17853:
be_cont.17854:
	mov     $i3, $i1
	ret
iter_setup_dirvec_constants.3111:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.17855
	store   $i1, 0($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.17856
	store   $i2, 1($sp)
	store   $i4, 2($sp)
	mov     $i3, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_rect_table.3102
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $i2
	load    2($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.17857
be_else.17856:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.17858
	store   $i2, 1($sp)
	store   $i4, 2($sp)
	mov     $i3, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_surface_table.3105
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $i2
	load    2($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.17859
be_else.17858:
	store   $i2, 1($sp)
	store   $i4, 2($sp)
	mov     $i3, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_second_table.3108
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $i2
	load    2($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.17859:
be_cont.17857:
	sub     $i2, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.17860
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	load    0($sp), $i3
	load    1($i3), $i4
	load    0($i3), $i3
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.17861
	store   $i1, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_rect_table.3102
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.17862
be_else.17861:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.17863
	store   $i1, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_surface_table.3105
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.17864
be_else.17863:
	store   $i1, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_second_table.3108
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.17864:
be_cont.17862:
	sub     $i2, 1, $i2
	load    0($sp), $i1
	b       iter_setup_dirvec_constants.3111
bge_else.17860:
	ret
bge_else.17855:
	ret
setup_startp_constants.3116:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.17867
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i2
	load    10($i2), $i3
	load    1($i2), $i4
	load    0($i1), $f1
	load    5($i2), $i5
	load    0($i5), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 0($i3)
	load    1($i1), $f1
	load    5($i2), $i5
	load    1($i5), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 1($i3)
	load    2($i1), $f1
	load    5($i2), $i1
	load    2($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($i3)
	li      2, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.17868
	load    4($i2), $i1
	load    0($i3), $f1
	load    1($i3), $f2
	load    2($i3), $f3
	load    0($i1), $f4
	fmul    $f4, $f1, $f1
	load    1($i1), $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 3($i3)
	b       be_cont.17869
be_else.17868:
	li      2, $i12
	cmp     $i4, $i12, $i12
	bg      $i12, ble_else.17870
	b       ble_cont.17871
ble_else.17870:
	store   $i3, 2($sp)
	store   $i4, 3($sp)
	load    0($i3), $f1
	load    1($i3), $f2
	load    2($i3), $f3
	mov     $i2, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     quadratic.3039
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	li      3, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17872
	load    l.13296, $f2
	fsub    $f1, $f2, $f1
	b       be_cont.17873
be_else.17872:
be_cont.17873:
	load    2($sp), $i1
	store   $f1, 3($i1)
ble_cont.17871:
be_cont.17869:
	load    1($sp), $i1
	sub     $i1, 1, $i2
	load    0($sp), $i1
	b       setup_startp_constants.3116
bge_else.17867:
	ret
is_rect_outside.3121:
	load    l.13295, $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17875
	b       ble_cont.17876
ble_else.17875:
	fneg    $f1, $f1
ble_cont.17876:
	load    4($i1), $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17877
	li      0, $i2
	b       ble_cont.17878
ble_else.17877:
	li      1, $i2
ble_cont.17878:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17879
	li      0, $i2
	b       be_cont.17880
be_else.17879:
	load    l.13295, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17881
	mov     $f2, $f1
	b       ble_cont.17882
ble_else.17881:
	fneg    $f2, $f1
ble_cont.17882:
	load    4($i1), $i2
	load    1($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17883
	li      0, $i2
	b       ble_cont.17884
ble_else.17883:
	li      1, $i2
ble_cont.17884:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17885
	li      0, $i2
	b       be_cont.17886
be_else.17885:
	load    l.13295, $f1
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.17887
	mov     $f3, $f1
	b       ble_cont.17888
ble_else.17887:
	fneg    $f3, $f1
ble_cont.17888:
	load    4($i1), $i2
	load    2($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17889
	li      0, $i2
	b       ble_cont.17890
ble_else.17889:
	li      1, $i2
ble_cont.17890:
be_cont.17886:
be_cont.17880:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17891
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17892
	li      1, $i1
	ret
be_else.17892:
	li      0, $i1
	ret
be_else.17891:
	load    6($i1), $i1
	ret
is_outside.3136:
	load    5($i1), $i2
	load    0($i2), $f4
	fsub    $f1, $f4, $f1
	load    5($i1), $i2
	load    1($i2), $f4
	fsub    $f2, $f4, $f2
	load    5($i1), $i2
	load    2($i2), $f4
	fsub    $f3, $f4, $f3
	load    1($i1), $i2
	li      1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17893
	load    l.13295, $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17894
	b       ble_cont.17895
ble_else.17894:
	fneg    $f1, $f1
ble_cont.17895:
	load    4($i1), $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.17896
	li      0, $i2
	b       ble_cont.17897
ble_else.17896:
	li      1, $i2
ble_cont.17897:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17898
	li      0, $i2
	b       be_cont.17899
be_else.17898:
	load    l.13295, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17900
	mov     $f2, $f1
	b       ble_cont.17901
ble_else.17900:
	fneg    $f2, $f1
ble_cont.17901:
	load    4($i1), $i2
	load    1($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17902
	li      0, $i2
	b       ble_cont.17903
ble_else.17902:
	li      1, $i2
ble_cont.17903:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17904
	li      0, $i2
	b       be_cont.17905
be_else.17904:
	load    l.13295, $f1
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.17906
	mov     $f3, $f1
	b       ble_cont.17907
ble_else.17906:
	fneg    $f3, $f1
ble_cont.17907:
	load    4($i1), $i2
	load    2($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17908
	li      0, $i2
	b       ble_cont.17909
ble_else.17908:
	li      1, $i2
ble_cont.17909:
be_cont.17905:
be_cont.17899:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17910
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17911
	li      1, $i1
	ret
be_else.17911:
	li      0, $i1
	ret
be_else.17910:
	load    6($i1), $i1
	ret
be_else.17893:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17912
	load    4($i1), $i2
	load    0($i2), $f4
	fmul    $f4, $f1, $f1
	load    1($i2), $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    2($i2), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    6($i1), $i1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17913
	li      0, $i2
	b       ble_cont.17914
ble_else.17913:
	li      1, $i2
ble_cont.17914:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17915
	mov     $i2, $i1
	b       be_cont.17916
be_else.17915:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17917
	li      1, $i1
	b       be_cont.17918
be_else.17917:
	li      0, $i1
be_cont.17918:
be_cont.17916:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17919
	li      1, $i1
	ret
be_else.17919:
	li      0, $i1
	ret
be_else.17912:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     quadratic.3039
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i1
	load    1($i1), $i2
	li      3, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17920
	load    l.13296, $f2
	fsub    $f1, $f2, $f1
	b       be_cont.17921
be_else.17920:
be_cont.17921:
	load    6($i1), $i1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17922
	li      0, $i2
	b       ble_cont.17923
ble_else.17922:
	li      1, $i2
ble_cont.17923:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17924
	mov     $i2, $i1
	b       be_cont.17925
be_else.17924:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17926
	li      1, $i1
	b       be_cont.17927
be_else.17926:
	li      0, $i1
be_cont.17927:
be_cont.17925:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17928
	li      1, $i1
	ret
be_else.17928:
	li      0, $i1
	ret
check_all_inside.3141:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17929
	li      1, $i1
	ret
be_else.17929:
	store   $f3, 0($sp)
	store   $f2, 1($sp)
	store   $f1, 2($sp)
	store   $i2, 3($sp)
	store   $i1, 4($sp)
	li      min_caml_objects, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i1
	load    5($i1), $i2
	load    0($i2), $f4
	fsub    $f1, $f4, $f1
	load    5($i1), $i2
	load    1($i2), $f4
	fsub    $f2, $f4, $f2
	load    5($i1), $i2
	load    2($i2), $f4
	fsub    $f3, $f4, $f3
	load    1($i1), $i2
	li      1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17930
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     is_rect_outside.3121
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17931
be_else.17930:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17932
	load    4($i1), $i2
	load    0($i2), $f4
	fmul    $f4, $f1, $f1
	load    1($i2), $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    2($i2), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    6($i1), $i1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17934
	li      0, $i2
	b       ble_cont.17935
ble_else.17934:
	li      1, $i2
ble_cont.17935:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17936
	mov     $i2, $i1
	b       be_cont.17937
be_else.17936:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17938
	li      1, $i1
	b       be_cont.17939
be_else.17938:
	li      0, $i1
be_cont.17939:
be_cont.17937:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17940
	li      1, $i1
	b       be_cont.17941
be_else.17940:
	li      0, $i1
be_cont.17941:
	b       be_cont.17933
be_else.17932:
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     quadratic.3039
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	load    1($i1), $i2
	li      3, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.17942
	load    l.13296, $f2
	fsub    $f1, $f2, $f1
	b       be_cont.17943
be_else.17942:
be_cont.17943:
	load    6($i1), $i1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17944
	li      0, $i2
	b       ble_cont.17945
ble_else.17944:
	li      1, $i2
ble_cont.17945:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17946
	mov     $i2, $i1
	b       be_cont.17947
be_else.17946:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.17948
	li      1, $i1
	b       be_cont.17949
be_else.17948:
	li      0, $i1
be_cont.17949:
be_cont.17947:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17950
	li      1, $i1
	b       be_cont.17951
be_else.17950:
	li      0, $i1
be_cont.17951:
be_cont.17933:
be_cont.17931:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17952
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    3($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17953
	li      1, $i1
	ret
be_else.17953:
	store   $i1, 6($sp)
	li      min_caml_objects, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i1
	load    2($sp), $f1
	load    1($sp), $f2
	load    0($sp), $f3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     is_outside.3136
	sub     $sp, 8, $sp
	load    7($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17954
	load    6($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $f1
	load    1($sp), $f2
	load    0($sp), $f3
	load    3($sp), $i2
	b       check_all_inside.3141
be_else.17954:
	li      0, $i1
	ret
be_else.17952:
	li      0, $i1
	ret
shadow_check_and_group.3147:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17955
	li      0, $i1
	ret
be_else.17955:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 2($sp)
	li      min_caml_light_dirvec, $i2
	li      min_caml_intersection_point, $i3
	li      min_caml_objects, $i4
	add     $i4, $i1, $i12
	load    0($i12), $i4
	load    0($i3), $f1
	load    5($i4), $i5
	load    0($i5), $f2
	fsub    $f1, $f2, $f1
	load    1($i3), $f2
	load    5($i4), $i5
	load    1($i5), $f3
	fsub    $f2, $f3, $f2
	load    2($i3), $f3
	load    5($i4), $i3
	load    2($i3), $f4
	fsub    $f3, $f4, $f3
	load    1($i2), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i3
	load    1($i4), $i1
	li      1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17956
	load    0($i2), $i2
	mov     $i4, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17957
be_else.17956:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17958
	load    0($i3), $f4
	load    l.13295, $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.17960
	li      0, $i1
	b       ble_cont.17961
ble_else.17960:
	li      1, $i1
ble_cont.17961:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17962
	li      0, $i1
	b       be_cont.17963
be_else.17962:
	li      min_caml_solver_dist, $i1
	load    1($i3), $f4
	fmul    $f4, $f1, $f1
	load    2($i3), $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    3($i3), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.17963:
	b       be_cont.17959
be_else.17958:
	mov     $i3, $i2
	mov     $i4, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.17959:
be_cont.17957:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17964
	li      0, $i1
	b       be_cont.17965
be_else.17964:
	load    l.13318, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17966
	li      0, $i1
	b       ble_cont.17967
ble_else.17966:
	li      1, $i1
ble_cont.17967:
be_cont.17965:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17968
	li      min_caml_objects, $i1
	load    2($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17969
	li      0, $i1
	ret
be_else.17969:
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_and_group.3147
be_else.17968:
	load    l.13319, $f2
	fadd    $f1, $f2, $f1
	li      min_caml_light, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      min_caml_intersection_point, $i1
	load    0($i1), $f3
	fadd    $f2, $f3, $f2
	li      min_caml_light, $i1
	load    1($i1), $f3
	fmul    $f3, $f1, $f3
	li      min_caml_intersection_point, $i1
	load    1($i1), $f4
	fadd    $f3, $f4, $f3
	li      min_caml_light, $i1
	load    2($i1), $f4
	fmul    $f4, $f1, $f1
	li      min_caml_intersection_point, $i1
	load    2($i1), $f4
	fadd    $f1, $f4, $f1
	load    0($sp), $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17970
	li      1, $i1
	b       be_cont.17971
be_else.17970:
	store   $f1, 3($sp)
	store   $f3, 4($sp)
	store   $f2, 5($sp)
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	mov     $f3, $f14
	mov     $f1, $f3
	mov     $f2, $f1
	mov     $f14, $f2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     is_outside.3136
	sub     $sp, 7, $sp
	load    6($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17972
	li      1, $i1
	load    5($sp), $f1
	load    4($sp), $f2
	load    3($sp), $f3
	load    0($sp), $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     check_all_inside.3141
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17973
be_else.17972:
	li      0, $i1
be_cont.17973:
be_cont.17971:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17974
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_and_group.3147
be_else.17974:
	li      1, $i1
	ret
shadow_check_one_or_group.3150:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17975
	li      0, $i1
	ret
be_else.17975:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 3, $sp
	load    2($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17976
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17977
	li      0, $i1
	ret
be_else.17977:
	store   $i1, 2($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17978
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17979
	li      0, $i1
	ret
be_else.17979:
	store   $i1, 3($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 5, $sp
	load    4($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17980
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.17981
	li      0, $i1
	ret
be_else.17981:
	store   $i1, 4($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 6, $sp
	load    5($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17982
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_one_or_group.3150
be_else.17982:
	li      1, $i1
	ret
be_else.17980:
	li      1, $i1
	ret
be_else.17978:
	li      1, $i1
	ret
be_else.17976:
	li      1, $i1
	ret
shadow_check_one_or_matrix.3153:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.17983
	li      0, $i1
	ret
be_else.17983:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.17984
	li      1, $i1
	b       be_cont.17985
be_else.17984:
	li      min_caml_light_dirvec, $i1
	li      min_caml_intersection_point, $i2
	li      min_caml_objects, $i3
	add     $i3, $i4, $i12
	load    0($i12), $i3
	load    0($i2), $f1
	load    5($i3), $i5
	load    0($i5), $f2
	fsub    $f1, $f2, $f1
	load    1($i2), $f2
	load    5($i3), $i5
	load    1($i5), $f3
	fsub    $f2, $f3, $f2
	load    2($i2), $f3
	load    5($i3), $i2
	load    2($i2), $f4
	fsub    $f3, $f4, $f3
	load    1($i1), $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i3), $i4
	li      1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.17986
	load    0($i1), $i1
	mov     $i3, $i10
	mov     $i2, $i3
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17987
be_else.17986:
	li      2, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.17988
	load    0($i2), $f4
	load    l.13295, $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.17990
	li      0, $i1
	b       ble_cont.17991
ble_else.17990:
	li      1, $i1
ble_cont.17991:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17992
	li      0, $i1
	b       be_cont.17993
be_else.17992:
	li      min_caml_solver_dist, $i1
	load    1($i2), $f4
	fmul    $f4, $f1, $f1
	load    2($i2), $f4
	fmul    $f4, $f2, $f2
	fadd    $f1, $f2, $f1
	load    3($i2), $f2
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.17993:
	b       be_cont.17989
be_else.17988:
	mov     $i3, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.17989:
be_cont.17987:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17994
	li      0, $i1
	b       be_cont.17995
be_else.17994:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	load    l.13320, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17996
	li      0, $i1
	b       ble_cont.17997
ble_else.17996:
	li      1, $i1
ble_cont.17997:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.17998
	li      0, $i1
	b       be_cont.17999
be_else.17998:
	load    0($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18000
	li      0, $i1
	b       be_cont.18001
be_else.18000:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18002
	load    0($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18004
	li      0, $i1
	b       be_cont.18005
be_else.18004:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18006
	load    0($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18008
	li      0, $i1
	b       be_cont.18009
be_else.18008:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18010
	li      4, $i1
	load    0($sp), $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18011
be_else.18010:
	li      1, $i1
be_cont.18011:
be_cont.18009:
	b       be_cont.18007
be_else.18006:
	li      1, $i1
be_cont.18007:
be_cont.18005:
	b       be_cont.18003
be_else.18002:
	li      1, $i1
be_cont.18003:
be_cont.18001:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18012
	li      0, $i1
	b       be_cont.18013
be_else.18012:
	li      1, $i1
be_cont.18013:
be_cont.17999:
be_cont.17995:
be_cont.17985:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18014
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	b       shadow_check_one_or_matrix.3153
be_else.18014:
	load    0($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18015
	li      0, $i1
	b       be_cont.18016
be_else.18015:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18017
	load    0($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18019
	li      0, $i1
	b       be_cont.18020
be_else.18019:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18021
	load    0($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18023
	li      0, $i1
	b       be_cont.18024
be_else.18023:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18025
	li      4, $i1
	load    0($sp), $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18026
be_else.18025:
	li      1, $i1
be_cont.18026:
be_cont.18024:
	b       be_cont.18022
be_else.18021:
	li      1, $i1
be_cont.18022:
be_cont.18020:
	b       be_cont.18018
be_else.18017:
	li      1, $i1
be_cont.18018:
be_cont.18016:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18027
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	b       shadow_check_one_or_matrix.3153
be_else.18027:
	li      1, $i1
	ret
solve_each_element.3156:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18028
	ret
be_else.18028:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	store   $i4, 3($sp)
	li      min_caml_startp, $i1
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    0($i1), $f1
	load    5($i2), $i4
	load    0($i4), $f2
	fsub    $f1, $f2, $f1
	load    1($i1), $f2
	load    5($i2), $i4
	load    1($i4), $f3
	fsub    $f2, $f3, $f2
	load    2($i1), $f3
	load    5($i2), $i1
	load    2($i1), $f4
	fsub    $f3, $f4, $f3
	load    1($i2), $i1
	li      1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18030
	store   $f1, 4($sp)
	store   $f3, 5($sp)
	store   $f2, 6($sp)
	store   $i2, 7($sp)
	li      0, $i1
	li      1, $i4
	li      2, $i5
	mov     $i3, $i10
	mov     $i1, $i3
	mov     $i2, $i1
	mov     $i10, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18032
	li      1, $i3
	li      2, $i4
	li      0, $i5
	load    6($sp), $f1
	load    5($sp), $f2
	load    4($sp), $f3
	load    7($sp), $i1
	load    0($sp), $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18034
	li      2, $i3
	li      0, $i4
	li      1, $i5
	load    5($sp), $f1
	load    4($sp), $f2
	load    6($sp), $f3
	load    7($sp), $i1
	load    0($sp), $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18036
	li      0, $i1
	b       be_cont.18037
be_else.18036:
	li      3, $i1
be_cont.18037:
	b       be_cont.18035
be_else.18034:
	li      2, $i1
be_cont.18035:
	b       be_cont.18033
be_else.18032:
	li      1, $i1
be_cont.18033:
	b       be_cont.18031
be_else.18030:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18038
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18039
be_else.18038:
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18039:
be_cont.18031:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18040
	li      min_caml_objects, $i1
	load    3($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18041
	ret
be_else.18041:
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       solve_each_element.3156
be_else.18040:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18043
	li      0, $i2
	b       ble_cont.18044
ble_else.18043:
	li      1, $i2
ble_cont.18044:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18045
	b       be_cont.18046
be_else.18045:
	li      min_caml_tmin, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18047
	li      0, $i2
	b       ble_cont.18048
ble_else.18047:
	li      1, $i2
ble_cont.18048:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18049
	b       be_cont.18050
be_else.18049:
	store   $i1, 8($sp)
	load    l.13319, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 9($sp)
	load    0($sp), $i3
	load    0($i3), $f2
	fmul    $f2, $f1, $f2
	li      min_caml_startp, $i1
	load    0($i1), $f3
	fadd    $f2, $f3, $f2
	store   $f2, 10($sp)
	load    1($i3), $f3
	fmul    $f3, $f1, $f3
	li      min_caml_startp, $i1
	load    1($i1), $f4
	fadd    $f3, $f4, $f3
	store   $f3, 11($sp)
	load    2($i3), $f4
	fmul    $f4, $f1, $f1
	li      min_caml_startp, $i1
	load    2($i1), $f4
	fadd    $f1, $f4, $f1
	store   $f1, 12($sp)
	load    1($sp), $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18051
	li      1, $i1
	b       be_cont.18052
be_else.18051:
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	mov     $f3, $f14
	mov     $f1, $f3
	mov     $f2, $f1
	mov     $f14, $f2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     is_outside.3136
	sub     $sp, 14, $sp
	load    13($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18053
	li      1, $i1
	load    10($sp), $f1
	load    11($sp), $f2
	load    12($sp), $f3
	load    1($sp), $i2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     check_all_inside.3141
	sub     $sp, 14, $sp
	load    13($sp), $ra
	b       be_cont.18054
be_else.18053:
	li      0, $i1
be_cont.18054:
be_cont.18052:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18055
	b       be_cont.18056
be_else.18055:
	li      min_caml_tmin, $i1
	load    9($sp), $f1
	store   $f1, 0($i1)
	li      min_caml_intersection_point, $i1
	load    10($sp), $f1
	store   $f1, 0($i1)
	load    11($sp), $f1
	store   $f1, 1($i1)
	load    12($sp), $f1
	store   $f1, 2($i1)
	li      min_caml_intersected_object_id, $i1
	load    3($sp), $i2
	store   $i2, 0($i1)
	li      min_caml_intsec_rectside, $i1
	load    8($sp), $i2
	store   $i2, 0($i1)
be_cont.18056:
be_cont.18050:
be_cont.18046:
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       solve_each_element.3156
solve_one_or_network.3160:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18057
	ret
be_else.18057:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i4, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solve_each_element.3156
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18059
	ret
be_else.18059:
	store   $i1, 3($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18061
	ret
be_else.18061:
	store   $i1, 4($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solve_each_element.3156
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18063
	ret
be_else.18063:
	store   $i1, 5($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     solve_each_element.3156
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       solve_one_or_network.3160
trace_or_matrix.3164:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	load    0($i4), $i5
	li      -1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18065
	ret
be_else.18065:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18067
	load    1($i4), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18069
	b       be_cont.18070
be_else.18069:
	store   $i4, 3($sp)
	li      min_caml_and_net, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18071
	b       be_cont.18072
be_else.18071:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18073
	b       be_cont.18074
be_else.18073:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $i1
	load    3($sp), $i2
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network.3160
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18074:
be_cont.18072:
be_cont.18070:
	b       be_cont.18068
be_else.18067:
	store   $i4, 3($sp)
	li      min_caml_startp, $i1
	li      min_caml_objects, $i2
	add     $i2, $i5, $i12
	load    0($i12), $i2
	load    0($i1), $f1
	load    5($i2), $i4
	load    0($i4), $f2
	fsub    $f1, $f2, $f1
	load    1($i1), $f2
	load    5($i2), $i4
	load    1($i4), $f3
	fsub    $f2, $f3, $f2
	load    2($i1), $f3
	load    5($i2), $i1
	load    2($i1), $f4
	fsub    $f3, $f4, $f3
	load    1($i2), $i1
	li      1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18075
	store   $f1, 4($sp)
	store   $f3, 5($sp)
	store   $f2, 6($sp)
	store   $i2, 7($sp)
	li      0, $i1
	li      1, $i4
	li      2, $i5
	mov     $i3, $i10
	mov     $i1, $i3
	mov     $i2, $i1
	mov     $i10, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18077
	li      1, $i3
	li      2, $i4
	li      0, $i5
	load    6($sp), $f1
	load    5($sp), $f2
	load    4($sp), $f3
	load    7($sp), $i1
	load    0($sp), $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18079
	li      2, $i3
	li      0, $i4
	li      1, $i5
	load    5($sp), $f1
	load    4($sp), $f2
	load    6($sp), $f3
	load    7($sp), $i1
	load    0($sp), $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18081
	li      0, $i1
	b       be_cont.18082
be_else.18081:
	li      3, $i1
be_cont.18082:
	b       be_cont.18080
be_else.18079:
	li      2, $i1
be_cont.18080:
	b       be_cont.18078
be_else.18077:
	li      1, $i1
be_cont.18078:
	b       be_cont.18076
be_else.18075:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18083
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18084
be_else.18083:
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18084:
be_cont.18076:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18085
	b       be_cont.18086
be_else.18085:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	li      min_caml_tmin, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18087
	li      0, $i1
	b       ble_cont.18088
ble_else.18087:
	li      1, $i1
ble_cont.18088:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18089
	b       be_cont.18090
be_else.18089:
	load    3($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18091
	b       be_cont.18092
be_else.18091:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    3($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18093
	b       be_cont.18094
be_else.18093:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    3($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18095
	b       be_cont.18096
be_else.18095:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	li      4, $i1
	load    3($sp), $i2
	load    0($sp), $i3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_one_or_network.3160
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18096:
be_cont.18094:
be_cont.18092:
be_cont.18090:
be_cont.18086:
be_cont.18068:
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       trace_or_matrix.3164
solve_each_element_fast.3170:
	load    0($i3), $i4
	add     $i2, $i1, $i12
	load    0($i12), $i5
	li      -1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18097
	ret
be_else.18097:
	store   $i4, 0($sp)
	store   $i3, 1($sp)
	store   $i2, 2($sp)
	store   $i1, 3($sp)
	store   $i5, 4($sp)
	li      min_caml_objects, $i1
	add     $i1, $i5, $i12
	load    0($i12), $i1
	load    10($i1), $i2
	load    0($i2), $f1
	load    1($i2), $f2
	load    2($i2), $f3
	load    1($i3), $i4
	add     $i4, $i5, $i12
	load    0($i12), $i4
	load    1($i1), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18099
	load    0($i3), $i2
	mov     $i4, $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18100
be_else.18099:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18101
	load    0($i4), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18103
	li      0, $i1
	b       ble_cont.18104
ble_else.18103:
	li      1, $i1
ble_cont.18104:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18105
	li      0, $i1
	b       be_cont.18106
be_else.18105:
	li      min_caml_solver_dist, $i1
	load    0($i4), $f1
	load    3($i2), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.18106:
	b       be_cont.18102
be_else.18101:
	mov     $i2, $i3
	mov     $i4, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18102:
be_cont.18100:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18107
	li      min_caml_objects, $i1
	load    4($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18108
	ret
be_else.18108:
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $i2
	load    1($sp), $i3
	b       solve_each_element_fast.3170
be_else.18107:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18110
	li      0, $i2
	b       ble_cont.18111
ble_else.18110:
	li      1, $i2
ble_cont.18111:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18112
	b       be_cont.18113
be_else.18112:
	li      min_caml_tmin, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18114
	li      0, $i2
	b       ble_cont.18115
ble_else.18114:
	li      1, $i2
ble_cont.18115:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18116
	b       be_cont.18117
be_else.18116:
	store   $i1, 5($sp)
	load    l.13319, $f2
	fadd    $f1, $f2, $f1
	store   $f1, 6($sp)
	load    0($sp), $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      min_caml_startp_fast, $i2
	load    0($i2), $f3
	fadd    $f2, $f3, $f2
	store   $f2, 7($sp)
	load    1($i1), $f3
	fmul    $f3, $f1, $f3
	li      min_caml_startp_fast, $i2
	load    1($i2), $f4
	fadd    $f3, $f4, $f3
	store   $f3, 8($sp)
	load    2($i1), $f4
	fmul    $f4, $f1, $f1
	li      min_caml_startp_fast, $i1
	load    2($i1), $f4
	fadd    $f1, $f4, $f1
	store   $f1, 9($sp)
	load    2($sp), $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18118
	li      1, $i1
	b       be_cont.18119
be_else.18118:
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	mov     $f3, $f14
	mov     $f1, $f3
	mov     $f2, $f1
	mov     $f14, $f2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     is_outside.3136
	sub     $sp, 11, $sp
	load    10($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18120
	li      1, $i1
	load    7($sp), $f1
	load    8($sp), $f2
	load    9($sp), $f3
	load    2($sp), $i2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     check_all_inside.3141
	sub     $sp, 11, $sp
	load    10($sp), $ra
	b       be_cont.18121
be_else.18120:
	li      0, $i1
be_cont.18121:
be_cont.18119:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18122
	b       be_cont.18123
be_else.18122:
	li      min_caml_tmin, $i1
	load    6($sp), $f1
	store   $f1, 0($i1)
	li      min_caml_intersection_point, $i1
	load    7($sp), $f1
	store   $f1, 0($i1)
	load    8($sp), $f1
	store   $f1, 1($i1)
	load    9($sp), $f1
	store   $f1, 2($i1)
	li      min_caml_intersected_object_id, $i1
	load    4($sp), $i2
	store   $i2, 0($i1)
	li      min_caml_intsec_rectside, $i1
	load    5($sp), $i2
	store   $i2, 0($i1)
be_cont.18123:
be_cont.18117:
be_cont.18113:
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $i2
	load    1($sp), $i3
	b       solve_each_element_fast.3170
solve_one_or_network_fast.3174:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18124
	ret
be_else.18124:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i4, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18126
	ret
be_else.18126:
	store   $i1, 3($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18128
	ret
be_else.18128:
	store   $i1, 4($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18130
	ret
be_else.18130:
	store   $i1, 5($sp)
	li      min_caml_and_net, $i1
	add     $i1, $i3, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       solve_one_or_network_fast.3174
trace_or_matrix_fast.3178:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	load    0($i4), $i5
	li      -1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18132
	ret
be_else.18132:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18134
	load    1($i4), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18136
	b       be_cont.18137
be_else.18136:
	store   $i4, 3($sp)
	li      min_caml_and_net, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18138
	b       be_cont.18139
be_else.18138:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18140
	b       be_cont.18141
be_else.18140:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $i1
	load    3($sp), $i2
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network_fast.3174
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18141:
be_cont.18139:
be_cont.18137:
	b       be_cont.18135
be_else.18134:
	store   $i4, 3($sp)
	li      min_caml_objects, $i1
	add     $i1, $i5, $i12
	load    0($i12), $i1
	load    10($i1), $i2
	load    0($i2), $f1
	load    1($i2), $f2
	load    2($i2), $f3
	load    1($i3), $i4
	add     $i4, $i5, $i12
	load    0($i12), $i4
	load    1($i1), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18142
	load    0($i3), $i2
	mov     $i4, $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18143
be_else.18142:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18144
	load    0($i4), $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18146
	li      0, $i1
	b       ble_cont.18147
ble_else.18146:
	li      1, $i1
ble_cont.18147:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18148
	li      0, $i1
	b       be_cont.18149
be_else.18148:
	li      min_caml_solver_dist, $i1
	load    0($i4), $f1
	load    3($i2), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.18149:
	b       be_cont.18145
be_else.18144:
	mov     $i2, $i3
	mov     $i4, $i2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18145:
be_cont.18143:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18150
	b       be_cont.18151
be_else.18150:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	li      min_caml_tmin, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18152
	li      0, $i1
	b       ble_cont.18153
ble_else.18152:
	li      1, $i1
ble_cont.18153:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18154
	b       be_cont.18155
be_else.18154:
	load    3($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18156
	b       be_cont.18157
be_else.18156:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18158
	b       be_cont.18159
be_else.18158:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18160
	b       be_cont.18161
be_else.18160:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $i1
	load    3($sp), $i2
	load    0($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network_fast.3174
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18161:
be_cont.18159:
be_cont.18157:
be_cont.18155:
be_cont.18151:
be_cont.18135:
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       trace_or_matrix_fast.3178
get_nvector_second.3188:
	li      min_caml_intersection_point, $i2
	load    0($i2), $f1
	load    5($i1), $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	li      min_caml_intersection_point, $i2
	load    1($i2), $f2
	load    5($i1), $i2
	load    1($i2), $f3
	fsub    $f2, $f3, $f2
	li      min_caml_intersection_point, $i2
	load    2($i2), $f3
	load    5($i1), $i2
	load    2($i2), $f4
	fsub    $f3, $f4, $f3
	load    4($i1), $i2
	load    0($i2), $f4
	fmul    $f1, $f4, $f4
	load    4($i1), $i2
	load    1($i2), $f5
	fmul    $f2, $f5, $f5
	load    4($i1), $i2
	load    2($i2), $f6
	fmul    $f3, $f6, $f6
	load    3($i1), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18162
	li      min_caml_nvector, $i2
	store   $f4, 0($i2)
	li      min_caml_nvector, $i2
	store   $f5, 1($i2)
	li      min_caml_nvector, $i2
	store   $f6, 2($i2)
	b       be_cont.18163
be_else.18162:
	li      min_caml_nvector, $i2
	load    9($i1), $i3
	load    2($i3), $f7
	fmul    $f2, $f7, $f7
	load    9($i1), $i3
	load    1($i3), $f8
	fmul    $f3, $f8, $f8
	fadd    $f7, $f8, $f7
	load    l.13293, $f8
	fmul    $f7, $f8, $f7
	fadd    $f4, $f7, $f4
	store   $f4, 0($i2)
	li      min_caml_nvector, $i2
	load    9($i1), $i3
	load    2($i3), $f4
	fmul    $f1, $f4, $f4
	load    9($i1), $i3
	load    0($i3), $f7
	fmul    $f3, $f7, $f3
	fadd    $f4, $f3, $f3
	load    l.13293, $f4
	fmul    $f3, $f4, $f3
	fadd    $f5, $f3, $f3
	store   $f3, 1($i2)
	li      min_caml_nvector, $i2
	load    9($i1), $i3
	load    1($i3), $f3
	fmul    $f1, $f3, $f1
	load    9($i1), $i3
	load    0($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    l.13293, $f2
	fmul    $f1, $f2, $f1
	fadd    $f6, $f1, $f1
	store   $f1, 2($i2)
be_cont.18163:
	li      min_caml_nvector, $i2
	load    6($i1), $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	b       vecunit_sgn.2896
utexture.3193:
	load    0($i1), $i3
	li      min_caml_texture_color, $i4
	load    8($i1), $i5
	load    0($i5), $f1
	store   $f1, 0($i4)
	li      min_caml_texture_color, $i4
	load    8($i1), $i5
	load    1($i5), $f1
	store   $f1, 1($i4)
	li      min_caml_texture_color, $i4
	load    8($i1), $i5
	load    2($i5), $f1
	store   $f1, 2($i4)
	li      1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18164
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    0($i2), $f1
	load    5($i1), $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($sp)
	load    l.13330, $f2
	fmul    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_floor
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13331, $f2
	fmul    $f1, $f2, $f1
	load    2($sp), $f2
	fsub    $f2, $f1, $f1
	load    l.13328, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18165
	li      0, $i1
	b       ble_cont.18166
ble_else.18165:
	li      1, $i1
ble_cont.18166:
	store   $i1, 3($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	load    0($sp), $i1
	load    5($i1), $i1
	load    2($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 4($sp)
	load    l.13330, $f2
	fmul    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_floor
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13331, $f2
	fmul    $f1, $f2, $f1
	load    4($sp), $f2
	fsub    $f2, $f1, $f1
	load    l.13328, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18167
	li      0, $i1
	b       ble_cont.18168
ble_else.18167:
	li      1, $i1
ble_cont.18168:
	li      min_caml_texture_color, $i2
	load    3($sp), $i3
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18169
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18171
	load    l.13326, $f1
	b       be_cont.18172
be_else.18171:
	load    l.13295, $f1
be_cont.18172:
	b       be_cont.18170
be_else.18169:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18173
	load    l.13295, $f1
	b       be_cont.18174
be_else.18173:
	load    l.13326, $f1
be_cont.18174:
be_cont.18170:
	store   $f1, 1($i2)
	ret
be_else.18164:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18176
	load    1($i2), $f1
	load    l.13329, $f2
	fmul    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18177
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18179
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18181
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18183
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.18184
ble_else.18183:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18184:
	b       ble_cont.18182
ble_else.18181:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18182:
	b       ble_cont.18180
ble_else.18179:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18180:
	b       ble_cont.18178
ble_else.18177:
	fneg    $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18178:
	fmul    $f1, $f1, $f1
	li      min_caml_texture_color, $i1
	load    l.13326, $f2
	fmul    $f2, $f1, $f2
	store   $f2, 0($i1)
	li      min_caml_texture_color, $i1
	load    l.13326, $f2
	load    l.13296, $f3
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, 1($i1)
	ret
be_else.18176:
	li      3, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18186
	load    0($i2), $f1
	load    5($i1), $i3
	load    0($i3), $f2
	fsub    $f1, $f2, $f1
	load    2($i2), $f2
	load    5($i1), $i1
	load    2($i1), $f3
	fsub    $f2, $f3, $f2
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sqrt.2865
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13328, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_floor
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $f2
	fsub    $f2, $f1, $f1
	load    l.13324, $f2
	fmul    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18187
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18189
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18191
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18193
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.18194
ble_else.18193:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18194:
	b       ble_cont.18192
ble_else.18191:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $f1, $f1
ble_cont.18192:
	b       ble_cont.18190
ble_else.18189:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18190:
	b       ble_cont.18188
ble_else.18187:
	fneg    $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18188:
	fmul    $f1, $f1, $f1
	li      min_caml_texture_color, $i1
	load    l.13326, $f2
	fmul    $f1, $f2, $f2
	store   $f2, 1($i1)
	li      min_caml_texture_color, $i1
	load    l.13296, $f2
	fsub    $f2, $f1, $f1
	load    l.13326, $f2
	fmul    $f1, $f2, $f1
	store   $f1, 2($i1)
	ret
be_else.18186:
	li      4, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18196
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    0($i2), $f1
	load    5($i1), $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 6($sp)
	load    4($i1), $i1
	load    0($i1), $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 7($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	load    0($sp), $i1
	load    5($i1), $i2
	load    2($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 8($sp)
	load    4($i1), $i1
	load    2($i1), $f1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     sqrt.2865
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $f2
	fmul    $f2, $f1, $f1
	load    7($sp), $f2
	fmul    $f2, $f2, $f3
	fmul    $f1, $f1, $f4
	fadd    $f3, $f4, $f3
	store   $f3, 9($sp)
	load    l.13295, $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.18197
	mov     $f2, $f3
	b       ble_cont.18198
ble_else.18197:
	fneg    $f2, $f3
ble_cont.18198:
	load    l.13321, $f4
	fcmp    $f4, $f3, $i12
	bg      $i12, ble_else.18199
	li      0, $i1
	b       ble_cont.18200
ble_else.18199:
	li      1, $i1
ble_cont.18200:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18201
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18203
	b       ble_cont.18204
ble_else.18203:
	fneg    $f1, $f1
ble_cont.18204:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     cordic_atan.2855
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    l.13323, $f2
	fmul    $f1, $f2, $f1
	load    l.13324, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	b       be_cont.18202
be_else.18201:
	load    l.13322, $f1
be_cont.18202:
	store   $f1, 10($sp)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_floor
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    10($sp), $f2
	fsub    $f2, $f1, $f1
	store   $f1, 11($sp)
	load    1($sp), $i1
	load    1($i1), $f1
	load    0($sp), $i1
	load    5($i1), $i2
	load    1($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 12($sp)
	load    4($i1), $i1
	load    1($i1), $f1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     sqrt.2865
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    12($sp), $f2
	fmul    $f2, $f1, $f1
	load    l.13295, $f2
	load    9($sp), $f3
	fcmp    $f2, $f3, $i12
	bg      $i12, ble_else.18205
	mov     $f3, $f2
	b       ble_cont.18206
ble_else.18205:
	fneg    $f3, $f2
ble_cont.18206:
	load    l.13321, $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.18207
	li      0, $i1
	b       ble_cont.18208
ble_else.18207:
	li      1, $i1
ble_cont.18208:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18209
	finv    $f3, $f15
	fmul    $f1, $f15, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18211
	b       ble_cont.18212
ble_else.18211:
	fneg    $f1, $f1
ble_cont.18212:
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     cordic_atan.2855
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    l.13323, $f2
	fmul    $f1, $f2, $f1
	load    l.13324, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	b       be_cont.18210
be_else.18209:
	load    l.13322, $f1
be_cont.18210:
	store   $f1, 13($sp)
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_floor
	sub     $sp, 15, $sp
	load    14($sp), $ra
	load    13($sp), $f2
	fsub    $f2, $f1, $f1
	load    l.13325, $f2
	load    l.13293, $f3
	load    11($sp), $f4
	fsub    $f3, $f4, $f3
	fmul    $f3, $f3, $f3
	fsub    $f2, $f3, $f2
	load    l.13293, $f3
	fsub    $f3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f2, $f1, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18213
	li      0, $i1
	b       ble_cont.18214
ble_else.18213:
	li      1, $i1
ble_cont.18214:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18215
	b       be_cont.18216
be_else.18215:
	load    l.13295, $f1
be_cont.18216:
	li      min_caml_texture_color, $i1
	load    l.13326, $f2
	fmul    $f2, $f1, $f1
	load    l.13327, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 2($i1)
	ret
be_else.18196:
	ret
add_light.3196:
	load    l.13295, $f4
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.18219
	li      0, $i1
	b       ble_cont.18220
ble_else.18219:
	li      1, $i1
ble_cont.18220:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18221
	b       be_cont.18222
be_else.18221:
	li      min_caml_rgb, $i1
	li      min_caml_texture_color, $i2
	load    0($i1), $f4
	load    0($i2), $f5
	fmul    $f1, $f5, $f5
	fadd    $f4, $f5, $f4
	store   $f4, 0($i1)
	load    1($i1), $f4
	load    1($i2), $f5
	fmul    $f1, $f5, $f5
	fadd    $f4, $f5, $f4
	store   $f4, 1($i1)
	load    2($i1), $f4
	load    2($i2), $f5
	fmul    $f1, $f5, $f1
	fadd    $f4, $f1, $f1
	store   $f1, 2($i1)
be_cont.18222:
	load    l.13295, $f1
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18223
	li      0, $i1
	b       ble_cont.18224
ble_else.18223:
	li      1, $i1
ble_cont.18224:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18225
	ret
be_else.18225:
	fmul    $f2, $f2, $f1
	fmul    $f1, $f1, $f1
	fmul    $f1, $f3, $f1
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    0($i2), $f2
	fadd    $f2, $f1, $f2
	store   $f2, 0($i1)
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    1($i2), $f2
	fadd    $f2, $f1, $f2
	store   $f2, 1($i1)
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    2($i2), $f2
	fadd    $f2, $f1, $f1
	store   $f1, 2($i1)
	ret
trace_reflections.3200:
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18228
	store   $f2, 0($sp)
	store   $f1, 1($sp)
	store   $i2, 2($sp)
	store   $i1, 3($sp)
	li      min_caml_reflections, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 4($sp)
	load    1($i1), $i3
	store   $i3, 5($sp)
	li      min_caml_tmin, $i1
	load    l.13332, $f1
	store   $f1, 0($i1)
	li      0, $i1
	li      min_caml_or_net, $i2
	load    0($i2), $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     trace_or_matrix_fast.3178
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      min_caml_tmin, $i1
	load    0($i1), $f1
	load    l.13320, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18229
	li      0, $i1
	b       ble_cont.18230
ble_else.18229:
	li      1, $i1
ble_cont.18230:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18231
	li      0, $i1
	b       be_cont.18232
be_else.18231:
	load    l.13333, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18233
	li      0, $i1
	b       ble_cont.18234
ble_else.18233:
	li      1, $i1
ble_cont.18234:
be_cont.18232:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18235
	b       be_cont.18236
be_else.18235:
	li      min_caml_intersected_object_id, $i1
	load    0($i1), $i1
	sll     $i1, 2, $i1
	li      min_caml_intsec_rectside, $i2
	load    0($i2), $i2
	add     $i1, $i2, $i1
	load    4($sp), $i2
	load    0($i2), $i3
	cmp     $i1, $i3, $i12
	bne     $i12, be_else.18237
	li      0, $i1
	li      min_caml_or_net, $i2
	load    0($i2), $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 7, $sp
	load    6($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18239
	li      min_caml_nvector, $i1
	load    5($sp), $i2
	load    0($i2), $i3
	load    0($i1), $f1
	load    0($i3), $f2
	fmul    $f1, $f2, $f1
	load    1($i1), $f2
	load    1($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	load    2($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    4($sp), $i1
	load    2($i1), $f2
	load    1($sp), $f3
	fmul    $f2, $f3, $f3
	fmul    $f3, $f1, $f1
	load    0($i2), $i1
	load    2($sp), $i2
	load    0($i2), $f3
	load    0($i1), $f4
	fmul    $f3, $f4, $f3
	load    1($i2), $f4
	load    1($i1), $f5
	fmul    $f4, $f5, $f4
	fadd    $f3, $f4, $f3
	load    2($i2), $f4
	load    2($i1), $f5
	fmul    $f4, $f5, $f4
	fadd    $f3, $f4, $f3
	fmul    $f2, $f3, $f2
	load    0($sp), $f3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     add_light.3196
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.18240
be_else.18239:
be_cont.18240:
	b       be_cont.18238
be_else.18237:
be_cont.18238:
be_cont.18236:
	load    3($sp), $i1
	sub     $i1, 1, $i1
	load    1($sp), $f1
	load    0($sp), $f2
	load    2($sp), $i2
	b       trace_reflections.3200
bge_else.18228:
	ret
trace_ray.3205:
	li      4, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18242
	store   $f2, 0($sp)
	store   $i3, 1($sp)
	store   $f1, 2($sp)
	store   $i2, 3($sp)
	store   $i1, 4($sp)
	load    2($i3), $i1
	store   $i1, 5($sp)
	li      min_caml_tmin, $i1
	load    l.13332, $f1
	store   $f1, 0($i1)
	li      0, $i1
	li      min_caml_or_net, $i3
	load    0($i3), $i3
	mov     $i3, $i10
	mov     $i2, $i3
	mov     $i10, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     trace_or_matrix.3164
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      min_caml_tmin, $i1
	load    0($i1), $f1
	load    l.13320, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18243
	li      0, $i1
	b       ble_cont.18244
ble_else.18243:
	li      1, $i1
ble_cont.18244:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18245
	li      0, $i1
	b       be_cont.18246
be_else.18245:
	load    l.13333, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18247
	li      0, $i1
	b       ble_cont.18248
ble_else.18247:
	li      1, $i1
ble_cont.18248:
be_cont.18246:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18249
	li      -1, $i1
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18250
	ret
be_else.18250:
	li      min_caml_light, $i1
	load    3($sp), $i2
	load    0($i2), $f1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    1($i2), $f2
	load    1($i1), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i2), $f2
	load    2($i1), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18252
	li      0, $i1
	b       ble_cont.18253
ble_else.18252:
	li      1, $i1
ble_cont.18253:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18254
	ret
be_else.18254:
	fmul    $f1, $f1, $f2
	fmul    $f2, $f1, $f1
	load    2($sp), $f2
	fmul    $f1, $f2, $f1
	li      min_caml_beam, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    0($i2), $f2
	fadd    $f2, $f1, $f2
	store   $f2, 0($i1)
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    1($i2), $f2
	fadd    $f2, $f1, $f2
	store   $f2, 1($i1)
	li      min_caml_rgb, $i1
	li      min_caml_rgb, $i2
	load    2($i2), $f2
	fadd    $f2, $f1, $f1
	store   $f1, 2($i1)
	ret
be_else.18249:
	li      min_caml_intersected_object_id, $i1
	load    0($i1), $i1
	store   $i1, 6($sp)
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 7($sp)
	load    2($i1), $i2
	store   $i2, 8($sp)
	load    7($i1), $i2
	load    0($i2), $f1
	load    2($sp), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 9($sp)
	load    1($i1), $i2
	li      1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18257
	li      min_caml_intsec_rectside, $i1
	load    0($i1), $i1
	li      min_caml_nvector, $i2
	load    l.13295, $f1
	store   $f1, 0($i2)
	store   $f1, 1($i2)
	store   $f1, 2($i2)
	li      min_caml_nvector, $i2
	sub     $i1, 1, $i3
	sub     $i1, 1, $i1
	load    3($sp), $i4
	add     $i4, $i1, $i12
	load    0($i12), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18259
	li      1, $i1
	b       be_cont.18260
be_else.18259:
	li      0, $i1
be_cont.18260:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18261
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18263
	li      0, $i1
	b       ble_cont.18264
ble_else.18263:
	li      1, $i1
ble_cont.18264:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18265
	load    l.13302, $f1
	b       be_cont.18266
be_else.18265:
	load    l.13296, $f1
be_cont.18266:
	b       be_cont.18262
be_else.18261:
	load    l.13295, $f1
be_cont.18262:
	fneg    $f1, $f1
	add     $i2, $i3, $i12
	store   $f1, 0($i12)
	b       be_cont.18258
be_else.18257:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18267
	li      min_caml_nvector, $i2
	load    4($i1), $i3
	load    0($i3), $f1
	fneg    $f1, $f1
	store   $f1, 0($i2)
	li      min_caml_nvector, $i2
	load    4($i1), $i3
	load    1($i3), $f1
	fneg    $f1, $f1
	store   $f1, 1($i2)
	li      min_caml_nvector, $i2
	load    4($i1), $i1
	load    2($i1), $f1
	fneg    $f1, $f1
	store   $f1, 2($i2)
	b       be_cont.18268
be_else.18267:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     get_nvector_second.3188
	sub     $sp, 11, $sp
	load    10($sp), $ra
be_cont.18268:
be_cont.18258:
	li      min_caml_startp, $i1
	li      min_caml_intersection_point, $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_intersection_point, $i2
	load    7($sp), $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     utexture.3193
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    6($sp), $i1
	sll     $i1, 2, $i1
	li      min_caml_intsec_rectside, $i2
	load    0($i2), $i2
	add     $i1, $i2, $i1
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	load    1($sp), $i1
	load    1($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	li      min_caml_intersection_point, $i4
	load    0($i4), $f1
	store   $f1, 0($i3)
	load    1($i4), $f1
	store   $f1, 1($i3)
	load    2($i4), $f1
	store   $f1, 2($i3)
	load    3($i1), $i3
	load    7($sp), $i4
	load    7($i4), $i5
	load    0($i5), $f1
	load    l.13293, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18269
	li      0, $i5
	b       ble_cont.18270
ble_else.18269:
	li      1, $i5
ble_cont.18270:
	cmp     $i5, $zero, $i12
	bne     $i12, be_else.18271
	li      1, $i5
	add     $i3, $i2, $i12
	store   $i5, 0($i12)
	load    4($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i5
	li      min_caml_texture_color, $i6
	load    0($i6), $f1
	store   $f1, 0($i5)
	load    1($i6), $f1
	store   $f1, 1($i5)
	load    2($i6), $f1
	store   $f1, 2($i5)
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    l.13334, $f1
	load    9($sp), $f2
	fmul    $f1, $f2, $f1
	load    0($i3), $f2
	fmul    $f2, $f1, $f2
	store   $f2, 0($i3)
	load    1($i3), $f2
	fmul    $f2, $f1, $f2
	store   $f2, 1($i3)
	load    2($i3), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 2($i3)
	load    7($i1), $i1
	add     $i1, $i2, $i12
	load    0($i12), $i1
	li      min_caml_nvector, $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	b       be_cont.18272
be_else.18271:
	li      0, $i1
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18272:
	load    l.13335, $f1
	li      min_caml_nvector, $i1
	load    3($sp), $i2
	load    0($i2), $f2
	load    0($i1), $f3
	fmul    $f2, $f3, $f2
	load    1($i2), $f3
	load    1($i1), $f4
	fmul    $f3, $f4, $f3
	fadd    $f2, $f3, $f2
	load    2($i2), $f3
	load    2($i1), $f4
	fmul    $f3, $f4, $f3
	fadd    $f2, $f3, $f2
	fmul    $f1, $f2, $f1
	li      min_caml_nvector, $i1
	load    0($i2), $f2
	load    0($i1), $f3
	fmul    $f1, $f3, $f3
	fadd    $f2, $f3, $f2
	store   $f2, 0($i2)
	load    1($i2), $f2
	load    1($i1), $f3
	fmul    $f1, $f3, $f3
	fadd    $f2, $f3, $f2
	store   $f2, 1($i2)
	load    2($i2), $f2
	load    2($i1), $f3
	fmul    $f1, $f3, $f1
	fadd    $f2, $f1, $f1
	store   $f1, 2($i2)
	load    7($i4), $i1
	load    1($i1), $f1
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 10($sp)
	li      0, $i1
	li      min_caml_or_net, $i2
	load    0($i2), $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 12, $sp
	load    11($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18273
	li      min_caml_nvector, $i1
	li      min_caml_light, $i2
	load    0($i1), $f1
	load    0($i2), $f2
	fmul    $f1, $f2, $f1
	load    1($i1), $f2
	load    1($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	load    2($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	load    9($sp), $f2
	fmul    $f1, $f2, $f1
	li      min_caml_light, $i1
	load    3($sp), $i2
	load    0($i2), $f2
	load    0($i1), $f3
	fmul    $f2, $f3, $f2
	load    1($i2), $f3
	load    1($i1), $f4
	fmul    $f3, $f4, $f3
	fadd    $f2, $f3, $f2
	load    2($i2), $f3
	load    2($i1), $f4
	fmul    $f3, $f4, $f3
	fadd    $f2, $f3, $f2
	fneg    $f2, $f2
	load    10($sp), $f3
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     add_light.3196
	sub     $sp, 12, $sp
	load    11($sp), $ra
	b       be_cont.18274
be_else.18273:
be_cont.18274:
	li      min_caml_intersection_point, $i1
	li      min_caml_startp_fast, $i2
	load    0($i1), $f1
	store   $f1, 0($i2)
	load    1($i1), $f1
	store   $f1, 1($i2)
	load    2($i1), $f1
	store   $f1, 2($i2)
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 12, $sp
	load    11($sp), $ra
	li      min_caml_n_reflections, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	load    9($sp), $f1
	load    10($sp), $f2
	load    3($sp), $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     trace_reflections.3200
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13336, $f1
	load    2($sp), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18275
	li      0, $i1
	b       ble_cont.18276
ble_else.18275:
	li      1, $i1
ble_cont.18276:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18277
	ret
be_else.18277:
	load    4($sp), $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18279
	b       bge_cont.18280
bge_else.18279:
	add     $i1, 1, $i1
	li      -1, $i2
	load    5($sp), $i3
	add     $i3, $i1, $i12
	store   $i2, 0($i12)
bge_cont.18280:
	load    8($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18281
	load    l.13296, $f1
	load    7($sp), $i1
	load    7($i1), $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	load    4($sp), $i1
	add     $i1, 1, $i1
	li      min_caml_tmin, $i2
	load    0($i2), $f2
	load    0($sp), $f3
	fadd    $f3, $f2, $f2
	load    3($sp), $i2
	load    1($sp), $i3
	b       trace_ray.3205
be_else.18281:
	ret
ble_else.18242:
	ret
trace_diffuse_ray.3211:
	store   $f1, 0($sp)
	store   $i1, 1($sp)
	li      min_caml_tmin, $i2
	load    l.13332, $f1
	store   $f1, 0($i2)
	li      0, $i2
	li      min_caml_or_net, $i3
	load    0($i3), $i3
	mov     $i3, $i10
	mov     $i1, $i3
	mov     $i2, $i1
	mov     $i10, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     trace_or_matrix_fast.3178
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      min_caml_tmin, $i1
	load    0($i1), $f1
	load    l.13320, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18284
	li      0, $i1
	b       ble_cont.18285
ble_else.18284:
	li      1, $i1
ble_cont.18285:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18286
	li      0, $i1
	b       be_cont.18287
be_else.18286:
	load    l.13333, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18288
	li      0, $i1
	b       ble_cont.18289
ble_else.18288:
	li      1, $i1
ble_cont.18289:
be_cont.18287:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18290
	ret
be_else.18290:
	li      min_caml_objects, $i1
	li      min_caml_intersected_object_id, $i2
	load    0($i2), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	store   $i1, 2($sp)
	load    1($sp), $i2
	load    0($i2), $i2
	load    1($i1), $i3
	li      1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18292
	li      min_caml_intsec_rectside, $i1
	load    0($i1), $i1
	li      min_caml_nvector, $i3
	load    l.13295, $f1
	store   $f1, 0($i3)
	store   $f1, 1($i3)
	store   $f1, 2($i3)
	li      min_caml_nvector, $i3
	sub     $i1, 1, $i4
	sub     $i1, 1, $i1
	add     $i2, $i1, $i12
	load    0($i12), $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18294
	li      1, $i1
	b       be_cont.18295
be_else.18294:
	li      0, $i1
be_cont.18295:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18296
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18298
	li      0, $i1
	b       ble_cont.18299
ble_else.18298:
	li      1, $i1
ble_cont.18299:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18300
	load    l.13302, $f1
	b       be_cont.18301
be_else.18300:
	load    l.13296, $f1
be_cont.18301:
	b       be_cont.18297
be_else.18296:
	load    l.13295, $f1
be_cont.18297:
	fneg    $f1, $f1
	add     $i3, $i4, $i12
	store   $f1, 0($i12)
	b       be_cont.18293
be_else.18292:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18302
	li      min_caml_nvector, $i2
	load    4($i1), $i3
	load    0($i3), $f1
	fneg    $f1, $f1
	store   $f1, 0($i2)
	li      min_caml_nvector, $i2
	load    4($i1), $i3
	load    1($i3), $f1
	fneg    $f1, $f1
	store   $f1, 1($i2)
	li      min_caml_nvector, $i2
	load    4($i1), $i1
	load    2($i1), $f1
	fneg    $f1, $f1
	store   $f1, 2($i2)
	b       be_cont.18303
be_else.18302:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     get_nvector_second.3188
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18303:
be_cont.18293:
	li      min_caml_intersection_point, $i2
	load    2($sp), $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     utexture.3193
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i1
	li      min_caml_or_net, $i2
	load    0($i2), $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18304
	li      min_caml_nvector, $i1
	li      min_caml_light, $i2
	load    0($i1), $f1
	load    0($i2), $f2
	fmul    $f1, $f2, $f1
	load    1($i1), $f2
	load    1($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	load    2($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	fneg    $f1, $f1
	load    l.13295, $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18305
	li      0, $i1
	b       ble_cont.18306
ble_else.18305:
	li      1, $i1
ble_cont.18306:
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18307
	load    l.13295, $f1
	b       be_cont.18308
be_else.18307:
be_cont.18308:
	li      min_caml_diffuse_ray, $i1
	load    0($sp), $f2
	fmul    $f2, $f1, $f1
	load    2($sp), $i2
	load    7($i2), $i2
	load    0($i2), $f2
	fmul    $f1, $f2, $f1
	li      min_caml_texture_color, $i2
	load    0($i1), $f2
	load    0($i2), $f3
	fmul    $f1, $f3, $f3
	fadd    $f2, $f3, $f2
	store   $f2, 0($i1)
	load    1($i1), $f2
	load    1($i2), $f3
	fmul    $f1, $f3, $f3
	fadd    $f2, $f3, $f2
	store   $f2, 1($i1)
	load    2($i1), $f2
	load    2($i2), $f3
	fmul    $f1, $f3, $f1
	fadd    $f2, $f1, $f1
	store   $f1, 2($i1)
	ret
be_else.18304:
	ret
iter_trace_diffuse_rays.3214:
	cmp     $i4, $zero, $i12
	bl      $i12, bge_else.18311
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	store   $i4, 3($sp)
	add     $i1, $i4, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	load    0($i3), $f1
	load    0($i2), $f2
	fmul    $f1, $f2, $f1
	load    1($i3), $f2
	load    1($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i3), $f2
	load    2($i2), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18312
	li      0, $i2
	b       ble_cont.18313
ble_else.18312:
	li      1, $i2
ble_cont.18313:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18314
	add     $i1, $i4, $i12
	load    0($i12), $i1
	load    l.13338, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18315
be_else.18314:
	add     $i4, 1, $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    l.13337, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18315:
	load    3($sp), $i1
	sub     $i1, 2, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18316
	store   $i1, 4($sp)
	load    2($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	load    0($i3), $f1
	load    1($sp), $i4
	load    0($i4), $f2
	fmul    $f1, $f2, $f1
	load    1($i3), $f2
	load    1($i4), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i3), $f2
	load    2($i4), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18317
	li      0, $i3
	b       ble_cont.18318
ble_else.18317:
	li      1, $i3
ble_cont.18318:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18319
	add     $i2, $i1, $i12
	load    0($i12), $i1
	load    l.13338, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18320
be_else.18319:
	add     $i1, 1, $i1
	add     $i2, $i1, $i12
	load    0($i12), $i1
	load    l.13337, $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18320:
	load    4($sp), $i1
	sub     $i1, 2, $i4
	load    2($sp), $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       iter_trace_diffuse_rays.3214
bge_else.18316:
	ret
bge_else.18311:
	ret
trace_diffuse_ray_80percent.3223:
	store   $i2, 0($sp)
	store   $i3, 1($sp)
	store   $i1, 2($sp)
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18323
	b       be_cont.18324
be_else.18323:
	li      min_caml_dirvecs, $i1
	load    0($i1), $i1
	store   $i1, 3($sp)
	li      min_caml_startp_fast, $i1
	load    0($i3), $f1
	store   $f1, 0($i1)
	load    1($i3), $f1
	store   $f1, 1($i1)
	load    2($i3), $f1
	store   $f1, 2($i1)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i2
	mov     $i3, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      118, $i4
	load    3($sp), $i1
	load    0($sp), $i2
	load    1($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18324:
	load    2($sp), $i1
	li      1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18325
	b       be_cont.18326
be_else.18325:
	li      min_caml_dirvecs, $i1
	load    1($i1), $i1
	store   $i1, 4($sp)
	li      min_caml_startp_fast, $i1
	load    1($sp), $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      118, $i4
	load    4($sp), $i1
	load    0($sp), $i2
	load    1($sp), $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18326:
	load    2($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18327
	b       be_cont.18328
be_else.18327:
	li      min_caml_dirvecs, $i1
	load    2($i1), $i1
	store   $i1, 5($sp)
	li      min_caml_startp_fast, $i1
	load    1($sp), $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      118, $i4
	load    5($sp), $i1
	load    0($sp), $i2
	load    1($sp), $i3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 7, $sp
	load    6($sp), $ra
be_cont.18328:
	load    2($sp), $i1
	li      3, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18329
	b       be_cont.18330
be_else.18329:
	li      min_caml_dirvecs, $i1
	load    3($i1), $i1
	store   $i1, 6($sp)
	li      min_caml_startp_fast, $i1
	load    1($sp), $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      118, $i4
	load    6($sp), $i1
	load    0($sp), $i2
	load    1($sp), $i3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18330:
	load    2($sp), $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18331
	ret
be_else.18331:
	li      min_caml_dirvecs, $i1
	load    4($i1), $i1
	store   $i1, 7($sp)
	li      min_caml_startp_fast, $i1
	load    1($sp), $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 9, $sp
	load    8($sp), $ra
	li      118, $i4
	load    7($sp), $i1
	load    0($sp), $i2
	load    1($sp), $i3
	b       iter_trace_diffuse_rays.3214
calc_diffuse_using_5points.3230:
	add     $i2, $i1, $i12
	load    0($i12), $i2
	load    5($i2), $i2
	sub     $i1, 1, $i6
	add     $i3, $i6, $i12
	load    0($i12), $i6
	load    5($i6), $i6
	add     $i3, $i1, $i12
	load    0($i12), $i7
	load    5($i7), $i7
	add     $i1, 1, $i8
	add     $i3, $i8, $i12
	load    0($i12), $i8
	load    5($i8), $i8
	add     $i4, $i1, $i12
	load    0($i12), $i4
	load    5($i4), $i4
	li      min_caml_diffuse_ray, $i9
	add     $i2, $i5, $i12
	load    0($i12), $i2
	load    0($i2), $f1
	store   $f1, 0($i9)
	load    1($i2), $f1
	store   $f1, 1($i9)
	load    2($i2), $f1
	store   $f1, 2($i9)
	li      min_caml_diffuse_ray, $i2
	add     $i6, $i5, $i12
	load    0($i12), $i6
	load    0($i2), $f1
	load    0($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i2)
	load    1($i2), $f1
	load    1($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 1($i2)
	load    2($i2), $f1
	load    2($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i2)
	li      min_caml_diffuse_ray, $i2
	add     $i7, $i5, $i12
	load    0($i12), $i6
	load    0($i2), $f1
	load    0($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i2)
	load    1($i2), $f1
	load    1($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 1($i2)
	load    2($i2), $f1
	load    2($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i2)
	li      min_caml_diffuse_ray, $i2
	add     $i8, $i5, $i12
	load    0($i12), $i6
	load    0($i2), $f1
	load    0($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i2)
	load    1($i2), $f1
	load    1($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 1($i2)
	load    2($i2), $f1
	load    2($i6), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i2)
	li      min_caml_diffuse_ray, $i2
	add     $i4, $i5, $i12
	load    0($i12), $i4
	load    0($i2), $f1
	load    0($i4), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 0($i2)
	load    1($i2), $f1
	load    1($i4), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 1($i2)
	load    2($i2), $f1
	load    2($i4), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i2)
	add     $i3, $i1, $i12
	load    0($i12), $i1
	load    4($i1), $i1
	li      min_caml_rgb, $i2
	add     $i1, $i5, $i12
	load    0($i12), $i1
	li      min_caml_diffuse_ray, $i3
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	b       vecaccumv.2920
do_without_neighbors.3236:
	li      4, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18333
	load    2($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bl      $i12, bge_else.18334
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    3($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18335
	b       be_cont.18336
be_else.18335:
	load    5($i1), $i3
	load    7($i1), $i4
	load    1($i1), $i5
	load    4($i1), $i6
	store   $i6, 2($sp)
	li      min_caml_diffuse_ray, $i6
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    0($i3), $f1
	store   $f1, 0($i6)
	load    1($i3), $f1
	store   $f1, 1($i6)
	load    2($i3), $f1
	store   $f1, 2($i6)
	load    6($i1), $i1
	load    0($i1), $i1
	add     $i4, $i2, $i12
	load    0($i12), $i3
	add     $i5, $i2, $i12
	load    0($i12), $i2
	mov     $i3, $i10
	mov     $i2, $i3
	mov     $i10, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      min_caml_rgb, $i1
	load    1($sp), $i2
	load    2($sp), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i2
	li      min_caml_diffuse_ray, $i3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     vecaccumv.2920
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18336:
	load    1($sp), $i1
	add     $i1, 1, $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18337
	load    0($sp), $i2
	load    2($i2), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bl      $i12, bge_else.18338
	store   $i1, 3($sp)
	load    3($i2), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18339
	b       be_cont.18340
be_else.18339:
	load    5($i2), $i3
	load    7($i2), $i4
	load    1($i2), $i5
	load    4($i2), $i6
	store   $i6, 4($sp)
	li      min_caml_diffuse_ray, $i6
	add     $i3, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $f1
	store   $f1, 0($i6)
	load    1($i3), $f1
	store   $f1, 1($i6)
	load    2($i3), $f1
	store   $f1, 2($i6)
	load    6($i2), $i2
	load    0($i2), $i2
	add     $i4, $i1, $i12
	load    0($i12), $i3
	add     $i5, $i1, $i12
	load    0($i12), $i1
	mov     $i3, $i10
	mov     $i1, $i3
	mov     $i2, $i1
	mov     $i10, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      min_caml_rgb, $i1
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i2
	li      min_caml_diffuse_ray, $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     vecaccumv.2920
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18340:
	load    3($sp), $i1
	add     $i1, 1, $i2
	load    0($sp), $i1
	b       do_without_neighbors.3236
bge_else.18338:
	ret
ble_else.18337:
	ret
bge_else.18334:
	ret
ble_else.18333:
	ret
try_exploit_neighbors.3252:
	add     $i4, $i1, $i12
	load    0($i12), $i7
	li      4, $i12
	cmp     $i6, $i12, $i12
	bg      $i12, ble_else.18345
	load    2($i7), $i8
	add     $i8, $i6, $i12
	load    0($i12), $i8
	cmp     $i8, $zero, $i12
	bl      $i12, bge_else.18346
	add     $i4, $i1, $i12
	load    0($i12), $i8
	load    2($i8), $i8
	add     $i8, $i6, $i12
	load    0($i12), $i8
	add     $i3, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18347
	add     $i5, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18349
	sub     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18351
	add     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18353
	li      1, $i8
	b       be_cont.18354
be_else.18353:
	li      0, $i8
be_cont.18354:
	b       be_cont.18352
be_else.18351:
	li      0, $i8
be_cont.18352:
	b       be_cont.18350
be_else.18349:
	li      0, $i8
be_cont.18350:
	b       be_cont.18348
be_else.18347:
	li      0, $i8
be_cont.18348:
	cmp     $i8, $zero, $i12
	bne     $i12, be_else.18355
	add     $i4, $i1, $i12
	load    0($i12), $i1
	li      4, $i12
	cmp     $i6, $i12, $i12
	bg      $i12, ble_else.18356
	load    2($i1), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18357
	store   $i1, 0($sp)
	store   $i6, 1($sp)
	load    3($i1), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18358
	b       be_cont.18359
be_else.18358:
	load    5($i1), $i2
	load    7($i1), $i3
	load    1($i1), $i4
	load    4($i1), $i5
	store   $i5, 2($sp)
	li      min_caml_diffuse_ray, $i5
	add     $i2, $i6, $i12
	load    0($i12), $i2
	load    0($i2), $f1
	store   $f1, 0($i5)
	load    1($i2), $f1
	store   $f1, 1($i5)
	load    2($i2), $f1
	store   $f1, 2($i5)
	load    6($i1), $i1
	load    0($i1), $i1
	add     $i3, $i6, $i12
	load    0($i12), $i2
	add     $i4, $i6, $i12
	load    0($i12), $i3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      min_caml_rgb, $i1
	load    1($sp), $i2
	load    2($sp), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i2
	li      min_caml_diffuse_ray, $i3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     vecaccumv.2920
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18359:
	load    1($sp), $i1
	add     $i1, 1, $i2
	load    0($sp), $i1
	b       do_without_neighbors.3236
bge_else.18357:
	ret
ble_else.18356:
	ret
be_else.18355:
	store   $i2, 3($sp)
	store   $i5, 4($sp)
	store   $i3, 5($sp)
	store   $i1, 6($sp)
	store   $i4, 7($sp)
	store   $i6, 1($sp)
	load    3($i7), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18362
	b       be_cont.18363
be_else.18362:
	mov     $i3, $i2
	mov     $i4, $i3
	mov     $i5, $i4
	mov     $i6, $i5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18363:
	load    1($sp), $i1
	add     $i1, 1, $i2
	load    6($sp), $i1
	load    7($sp), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i4
	li      4, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18364
	load    2($i4), $i5
	add     $i5, $i2, $i12
	load    0($i12), $i5
	cmp     $i5, $zero, $i12
	bl      $i12, bge_else.18365
	add     $i3, $i1, $i12
	load    0($i12), $i5
	load    2($i5), $i5
	add     $i5, $i2, $i12
	load    0($i12), $i5
	load    5($sp), $i6
	add     $i6, $i1, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18366
	load    4($sp), $i7
	add     $i7, $i1, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18368
	sub     $i1, 1, $i7
	add     $i3, $i7, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18370
	add     $i1, 1, $i7
	add     $i3, $i7, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18372
	li      1, $i5
	b       be_cont.18373
be_else.18372:
	li      0, $i5
be_cont.18373:
	b       be_cont.18371
be_else.18370:
	li      0, $i5
be_cont.18371:
	b       be_cont.18369
be_else.18368:
	li      0, $i5
be_cont.18369:
	b       be_cont.18367
be_else.18366:
	li      0, $i5
be_cont.18367:
	cmp     $i5, $zero, $i12
	bne     $i12, be_else.18374
	add     $i3, $i1, $i12
	load    0($i12), $i1
	b       do_without_neighbors.3236
be_else.18374:
	store   $i2, 8($sp)
	load    3($i4), $i4
	add     $i4, $i2, $i12
	load    0($i12), $i4
	cmp     $i4, $zero, $i12
	bne     $i12, be_else.18375
	b       be_cont.18376
be_else.18375:
	load    4($sp), $i4
	mov     $i2, $i5
	mov     $i6, $i2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 10, $sp
	load    9($sp), $ra
be_cont.18376:
	load    8($sp), $i1
	add     $i1, 1, $i6
	load    6($sp), $i1
	load    3($sp), $i2
	load    5($sp), $i3
	load    7($sp), $i4
	load    4($sp), $i5
	b       try_exploit_neighbors.3252
bge_else.18365:
	ret
ble_else.18364:
	ret
bge_else.18346:
	ret
ble_else.18345:
	ret
write_ppm_header.3259:
	li      80, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      54, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      10, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      49, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      56, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      32, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      49, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      56, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      32, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      53, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      53, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      10, $i1
	b       min_caml_write
write_rgb.3263:
	li      min_caml_rgb, $i1
	load    0($i1), $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18381
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18383
	b       bge_cont.18384
bge_else.18383:
	li      0, $i1
bge_cont.18384:
	b       ble_cont.18382
ble_else.18381:
	li      255, $i1
ble_cont.18382:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      min_caml_rgb, $i1
	load    1($i1), $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18385
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18387
	b       bge_cont.18388
bge_else.18387:
	li      0, $i1
bge_cont.18388:
	b       ble_cont.18386
ble_else.18385:
	li      255, $i1
ble_cont.18386:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      min_caml_rgb, $i1
	load    2($i1), $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18389
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18391
	b       bge_cont.18392
bge_else.18391:
	li      0, $i1
bge_cont.18392:
	b       ble_cont.18390
ble_else.18389:
	li      255, $i1
ble_cont.18390:
	b       min_caml_write
pretrace_diffuse_rays.3265:
	li      4, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18393
	load    2($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bl      $i12, bge_else.18394
	store   $i2, 0($sp)
	load    3($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18395
	b       be_cont.18396
be_else.18395:
	store   $i1, 1($sp)
	load    6($i1), $i3
	load    0($i3), $i3
	li      min_caml_diffuse_ray, $i4
	load    l.13295, $f1
	store   $f1, 0($i4)
	store   $f1, 1($i4)
	store   $f1, 2($i4)
	load    7($i1), $i4
	load    1($i1), $i1
	li      min_caml_dirvecs, $i5
	add     $i5, $i3, $i12
	load    0($i12), $i3
	store   $i3, 2($sp)
	add     $i4, $i2, $i12
	load    0($i12), $i3
	store   $i3, 3($sp)
	add     $i1, $i2, $i12
	load    0($i12), $i1
	store   $i1, 4($sp)
	li      min_caml_startp_fast, $i2
	load    0($i1), $f1
	store   $f1, 0($i2)
	load    1($i1), $f1
	store   $f1, 1($i2)
	load    2($i1), $f1
	store   $f1, 2($i2)
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      118, $i4
	load    2($sp), $i1
	load    3($sp), $i2
	load    4($sp), $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    1($sp), $i1
	load    5($i1), $i2
	load    0($sp), $i3
	add     $i2, $i3, $i12
	load    0($i12), $i2
	li      min_caml_diffuse_ray, $i3
	load    0($i3), $f1
	store   $f1, 0($i2)
	load    1($i3), $f1
	store   $f1, 1($i2)
	load    2($i3), $f1
	store   $f1, 2($i2)
be_cont.18396:
	load    0($sp), $i2
	add     $i2, 1, $i2
	b       pretrace_diffuse_rays.3265
bge_else.18394:
	ret
ble_else.18393:
	ret
pretrace_pixels.3268:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18399
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	store   $f3, 3($sp)
	store   $f2, 4($sp)
	store   $f1, 5($sp)
	li      min_caml_scan_pitch, $i1
	load    0($i1), $f1
	store   $f1, 6($sp)
	li      min_caml_image_center, $i1
	load    0($i1), $i1
	sub     $i2, $i1, $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_float_of_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $f2
	fmul    $f2, $f1, $f1
	li      min_caml_ptrace_dirvec, $i1
	li      min_caml_screenx_dir, $i2
	load    0($i2), $f2
	fmul    $f1, $f2, $f2
	load    5($sp), $f3
	fadd    $f2, $f3, $f2
	store   $f2, 0($i1)
	li      min_caml_ptrace_dirvec, $i1
	li      min_caml_screenx_dir, $i2
	load    1($i2), $f2
	fmul    $f1, $f2, $f2
	load    4($sp), $f3
	fadd    $f2, $f3, $f2
	store   $f2, 1($i1)
	li      min_caml_ptrace_dirvec, $i1
	li      min_caml_screenx_dir, $i2
	load    2($i2), $f2
	fmul    $f1, $f2, $f1
	load    3($sp), $f2
	fadd    $f1, $f2, $f1
	store   $f1, 2($i1)
	li      min_caml_ptrace_dirvec, $i1
	li      0, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     vecunit_sgn.2896
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $i1
	load    l.13295, $f1
	store   $f1, 0($i1)
	store   $f1, 1($i1)
	store   $f1, 2($i1)
	li      min_caml_startp, $i1
	li      min_caml_viewpoint, $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      0, $i1
	load    l.13296, $f1
	li      min_caml_ptrace_dirvec, $i2
	load    1($sp), $i3
	load    2($sp), $i4
	add     $i4, $i3, $i12
	load    0($i12), $i3
	load    l.13295, $f2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     trace_ray.3205
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    1($sp), $i1
	load    2($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	li      min_caml_rgb, $i4
	load    0($i4), $f1
	store   $f1, 0($i3)
	load    1($i4), $f1
	store   $f1, 1($i3)
	load    2($i4), $f1
	store   $f1, 2($i3)
	add     $i2, $i1, $i12
	load    0($i12), $i3
	load    6($i3), $i3
	load    0($sp), $i4
	store   $i4, 0($i3)
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      0, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     pretrace_diffuse_rays.3265
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    1($sp), $i1
	sub     $i1, 1, $i2
	load    0($sp), $i1
	add     $i1, 1, $i1
	li      5, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18400
	sub     $i1, 5, $i1
	b       bge_cont.18401
bge_else.18400:
bge_cont.18401:
	mov     $i1, $i3
	load    5($sp), $f1
	load    4($sp), $f2
	load    3($sp), $f3
	load    2($sp), $i1
	b       pretrace_pixels.3268
bge_else.18399:
	ret
pretrace_line.3275:
	store   $i3, 0($sp)
	store   $i1, 1($sp)
	li      min_caml_scan_pitch, $i1
	load    0($i1), $f1
	store   $f1, 2($sp)
	li      min_caml_image_center, $i1
	load    1($i1), $i1
	sub     $i2, $i1, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_float_of_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	li      min_caml_screeny_dir, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f2
	li      min_caml_screenz_dir, $i1
	load    0($i1), $f3
	fadd    $f2, $f3, $f2
	li      min_caml_screeny_dir, $i1
	load    1($i1), $f3
	fmul    $f1, $f3, $f3
	li      min_caml_screenz_dir, $i1
	load    1($i1), $f4
	fadd    $f3, $f4, $f3
	li      min_caml_screeny_dir, $i1
	load    2($i1), $f4
	fmul    $f1, $f4, $f1
	li      min_caml_screenz_dir, $i1
	load    2($i1), $f4
	fadd    $f1, $f4, $f1
	li      min_caml_image_size, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i2
	load    1($sp), $i1
	load    0($sp), $i3
	mov     $f3, $f14
	mov     $f1, $f3
	mov     $f2, $f1
	mov     $f14, $f2
	b       pretrace_pixels.3268
scan_pixel.3279:
	li      min_caml_image_size, $i6
	load    0($i6), $i6
	cmp     $i6, $i1, $i12
	bg      $i12, ble_else.18403
	ret
ble_else.18403:
	store   $i5, 0($sp)
	store   $i3, 1($sp)
	store   $i2, 2($sp)
	store   $i4, 3($sp)
	store   $i1, 4($sp)
	li      min_caml_rgb, $i6
	add     $i4, $i1, $i12
	load    0($i12), $i7
	load    0($i7), $i7
	load    0($i7), $f1
	store   $f1, 0($i6)
	load    1($i7), $f1
	store   $f1, 1($i6)
	load    2($i7), $f1
	store   $f1, 2($i6)
	li      min_caml_image_size, $i6
	load    1($i6), $i6
	add     $i2, 1, $i7
	cmp     $i6, $i7, $i12
	bg      $i12, ble_else.18405
	li      0, $i6
	b       ble_cont.18406
ble_else.18405:
	cmp     $i2, $zero, $i12
	bg      $i12, ble_else.18407
	li      0, $i6
	b       ble_cont.18408
ble_else.18407:
	li      min_caml_image_size, $i6
	load    0($i6), $i6
	add     $i1, 1, $i7
	cmp     $i6, $i7, $i12
	bg      $i12, ble_else.18409
	li      0, $i6
	b       ble_cont.18410
ble_else.18409:
	cmp     $i1, $zero, $i12
	bg      $i12, ble_else.18411
	li      0, $i6
	b       ble_cont.18412
ble_else.18411:
	li      1, $i6
ble_cont.18412:
ble_cont.18410:
ble_cont.18408:
ble_cont.18406:
	cmp     $i6, $zero, $i12
	bne     $i12, be_else.18413
	add     $i4, $i1, $i12
	load    0($i12), $i1
	load    2($i1), $i2
	load    0($i2), $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18415
	store   $i1, 5($sp)
	load    3($i1), $i2
	load    0($i2), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18417
	b       be_cont.18418
be_else.18417:
	load    5($i1), $i2
	load    7($i1), $i3
	load    1($i1), $i4
	load    4($i1), $i5
	store   $i5, 6($sp)
	li      min_caml_diffuse_ray, $i5
	load    0($i2), $i2
	load    0($i2), $f1
	store   $f1, 0($i5)
	load    1($i2), $f1
	store   $f1, 1($i5)
	load    2($i2), $f1
	store   $f1, 2($i5)
	load    6($i1), $i1
	load    0($i1), $i1
	load    0($i3), $i2
	load    0($i4), $i3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $i1
	load    6($sp), $i2
	load    0($i2), $i2
	li      min_caml_diffuse_ray, $i3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     vecaccumv.2920
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18418:
	li      1, $i2
	load    5($sp), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       bge_cont.18416
bge_else.18415:
bge_cont.18416:
	b       be_cont.18414
be_else.18413:
	li      0, $i6
	add     $i4, $i1, $i12
	load    0($i12), $i7
	load    2($i7), $i8
	load    0($i8), $i8
	cmp     $i8, $zero, $i12
	bl      $i12, bge_else.18419
	add     $i4, $i1, $i12
	load    0($i12), $i8
	load    2($i8), $i8
	load    0($i8), $i8
	add     $i3, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18421
	add     $i5, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18423
	sub     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18425
	add     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18427
	li      1, $i8
	b       be_cont.18428
be_else.18427:
	li      0, $i8
be_cont.18428:
	b       be_cont.18426
be_else.18425:
	li      0, $i8
be_cont.18426:
	b       be_cont.18424
be_else.18423:
	li      0, $i8
be_cont.18424:
	b       be_cont.18422
be_else.18421:
	li      0, $i8
be_cont.18422:
	cmp     $i8, $zero, $i12
	bne     $i12, be_else.18429
	add     $i4, $i1, $i12
	load    0($i12), $i1
	mov     $i6, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.18430
be_else.18429:
	load    3($i7), $i2
	load    0($i2), $i2
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18431
	b       be_cont.18432
be_else.18431:
	mov     $i3, $i2
	mov     $i4, $i3
	mov     $i5, $i4
	mov     $i6, $i5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18432:
	li      1, $i6
	load    4($sp), $i1
	load    2($sp), $i2
	load    1($sp), $i3
	load    3($sp), $i4
	load    0($sp), $i5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18430:
	b       bge_cont.18420
bge_else.18419:
bge_cont.18420:
be_cont.18414:
	li      min_caml_rgb, $i1
	load    0($i1), $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18433
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18435
	b       bge_cont.18436
bge_else.18435:
	li      0, $i1
bge_cont.18436:
	b       ble_cont.18434
ble_else.18433:
	li      255, $i1
ble_cont.18434:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $i1
	load    1($i1), $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18437
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18439
	b       bge_cont.18440
bge_else.18439:
	li      0, $i1
bge_cont.18440:
	b       ble_cont.18438
ble_else.18437:
	li      255, $i1
ble_cont.18438:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $i1
	load    2($i1), $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18441
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18443
	b       bge_cont.18444
bge_else.18443:
	li      0, $i1
bge_cont.18444:
	b       ble_cont.18442
ble_else.18441:
	li      255, $i1
ble_cont.18442:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    4($sp), $i1
	add     $i1, 1, $i1
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	cmp     $i2, $i1, $i12
	bg      $i12, ble_else.18445
	ret
ble_else.18445:
	store   $i1, 7($sp)
	li      min_caml_rgb, $i2
	load    3($sp), $i4
	add     $i4, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	load    0($i3), $f1
	store   $f1, 0($i2)
	load    1($i3), $f1
	store   $f1, 1($i2)
	load    2($i3), $f1
	store   $f1, 2($i2)
	li      min_caml_image_size, $i2
	load    1($i2), $i2
	load    2($sp), $i3
	add     $i3, 1, $i5
	cmp     $i2, $i5, $i12
	bg      $i12, ble_else.18447
	li      0, $i2
	b       ble_cont.18448
ble_else.18447:
	cmp     $i3, $zero, $i12
	bg      $i12, ble_else.18449
	li      0, $i2
	b       ble_cont.18450
ble_else.18449:
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	add     $i1, 1, $i5
	cmp     $i2, $i5, $i12
	bg      $i12, ble_else.18451
	li      0, $i2
	b       ble_cont.18452
ble_else.18451:
	cmp     $i1, $zero, $i12
	bg      $i12, ble_else.18453
	li      0, $i2
	b       ble_cont.18454
ble_else.18453:
	li      1, $i2
ble_cont.18454:
ble_cont.18452:
ble_cont.18450:
ble_cont.18448:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18455
	add     $i4, $i1, $i12
	load    0($i12), $i1
	li      0, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18456
be_else.18455:
	li      0, $i6
	load    1($sp), $i2
	load    0($sp), $i5
	mov     $i3, $i10
	mov     $i2, $i3
	mov     $i10, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18456:
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     write_rgb.3263
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $i2
	load    1($sp), $i3
	load    3($sp), $i4
	load    0($sp), $i5
	b       scan_pixel.3279
scan_line.3285:
	li      min_caml_image_size, $i6
	load    1($i6), $i6
	cmp     $i6, $i1, $i12
	bg      $i12, ble_else.18457
	ret
ble_else.18457:
	store   $i2, 0($sp)
	store   $i4, 1($sp)
	store   $i3, 2($sp)
	store   $i5, 3($sp)
	store   $i1, 4($sp)
	li      min_caml_image_size, $i2
	load    1($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $i1, $i12
	bg      $i12, ble_else.18459
	b       ble_cont.18460
ble_else.18459:
	add     $i1, 1, $i2
	mov     $i5, $i3
	mov     $i4, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     pretrace_line.3275
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18460:
	li      0, $i1
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	cmp     $i2, $zero, $i12
	bg      $i12, ble_else.18461
	b       ble_cont.18462
ble_else.18461:
	li      min_caml_rgb, $i2
	load    2($sp), $i4
	load    0($i4), $i3
	load    0($i3), $i3
	load    0($i3), $f1
	store   $f1, 0($i2)
	load    1($i3), $f1
	store   $f1, 1($i2)
	load    2($i3), $f1
	store   $f1, 2($i2)
	li      min_caml_image_size, $i2
	load    1($i2), $i2
	load    4($sp), $i3
	add     $i3, 1, $i5
	cmp     $i2, $i5, $i12
	bg      $i12, ble_else.18463
	li      0, $i2
	b       ble_cont.18464
ble_else.18463:
	cmp     $i3, $zero, $i12
	bg      $i12, ble_else.18465
	li      0, $i2
	b       ble_cont.18466
ble_else.18465:
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	li      1, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18467
	li      0, $i2
	b       ble_cont.18468
ble_else.18467:
	li      0, $i2
ble_cont.18468:
ble_cont.18466:
ble_cont.18464:
	cmp     $i2, $zero, $i12
	bne     $i12, be_else.18469
	load    0($i4), $i1
	li      0, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18470
be_else.18469:
	li      0, $i6
	load    0($sp), $i2
	load    1($sp), $i5
	mov     $i3, $i10
	mov     $i2, $i3
	mov     $i10, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18470:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     write_rgb.3263
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      1, $i1
	load    4($sp), $i2
	load    0($sp), $i3
	load    2($sp), $i4
	load    1($sp), $i5
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     scan_pixel.3279
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18462:
	load    4($sp), $i1
	add     $i1, 1, $i2
	load    3($sp), $i1
	add     $i1, 2, $i1
	li      5, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18471
	sub     $i1, 5, $i1
	b       bge_cont.18472
bge_else.18471:
bge_cont.18472:
	mov     $i1, $i3
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	cmp     $i1, $i2, $i12
	bg      $i12, ble_else.18473
	ret
ble_else.18473:
	store   $i3, 5($sp)
	store   $i2, 6($sp)
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $i2, $i12
	bg      $i12, ble_else.18475
	b       ble_cont.18476
ble_else.18475:
	add     $i2, 1, $i2
	load    0($sp), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     pretrace_line.3275
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18476:
	li      0, $i1
	load    6($sp), $i2
	load    2($sp), $i3
	load    1($sp), $i4
	load    0($sp), $i5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     scan_pixel.3279
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i1
	add     $i1, 1, $i1
	load    5($sp), $i2
	add     $i2, 2, $i2
	li      5, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18477
	sub     $i2, 5, $i2
	b       bge_cont.18478
bge_else.18477:
bge_cont.18478:
	mov     $i2, $i5
	load    1($sp), $i2
	load    0($sp), $i3
	load    2($sp), $i4
	b       scan_line.3285
create_float5x3array.3291:
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_create_float_array
	sub     $sp, 1, $sp
	load    0($sp), $ra
	mov     $i1, $i2
	li      5, $i1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_create_array
	sub     $sp, 1, $sp
	load    0($sp), $ra
	store   $i1, 0($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 1($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 2($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 3($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 4($i2)
	mov     $i2, $i1
	ret
init_line_elements.3295:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18479
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     create_float5x3array.3291
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $i1, 3($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $i1, 4($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     create_float5x3array.3291
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     create_float5x3array.3291
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $i1, 7($sp)
	li      1, $i1
	li      0, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $i1, 8($sp)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     create_float5x3array.3291
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $i2
	add     $hp, 8, $hp
	store   $i1, 7($i2)
	load    8($sp), $i1
	store   $i1, 6($i2)
	load    7($sp), $i1
	store   $i1, 5($i2)
	load    6($sp), $i1
	store   $i1, 4($i2)
	load    5($sp), $i1
	store   $i1, 3($i2)
	load    4($sp), $i1
	store   $i1, 2($i2)
	load    3($sp), $i1
	store   $i1, 1($i2)
	load    2($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    0($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18480
	store   $i1, 9($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_float_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $i1, 10($sp)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     create_float5x3array.3291
	sub     $sp, 12, $sp
	load    11($sp), $ra
	store   $i1, 11($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	store   $i1, 12($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     min_caml_create_array
	sub     $sp, 14, $sp
	load    13($sp), $ra
	store   $i1, 13($sp)
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     create_float5x3array.3291
	sub     $sp, 15, $sp
	load    14($sp), $ra
	store   $i1, 14($sp)
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     create_float5x3array.3291
	sub     $sp, 16, $sp
	load    15($sp), $ra
	store   $i1, 15($sp)
	li      1, $i1
	li      0, $i2
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     min_caml_create_array
	sub     $sp, 17, $sp
	load    16($sp), $ra
	store   $i1, 16($sp)
	store   $ra, 17($sp)
	add     $sp, 18, $sp
	jal     create_float5x3array.3291
	sub     $sp, 18, $sp
	load    17($sp), $ra
	mov     $hp, $i2
	add     $hp, 8, $hp
	store   $i1, 7($i2)
	load    16($sp), $i1
	store   $i1, 6($i2)
	load    15($sp), $i1
	store   $i1, 5($i2)
	load    14($sp), $i1
	store   $i1, 4($i2)
	load    13($sp), $i1
	store   $i1, 3($i2)
	load    12($sp), $i1
	store   $i1, 2($i2)
	load    11($sp), $i1
	store   $i1, 1($i2)
	load    10($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    9($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i2
	mov     $i3, $i1
	b       init_line_elements.3295
bge_else.18480:
	mov     $i3, $i1
	ret
bge_else.18479:
	ret
tan.3300:
	store   $f1, 0($sp)
	load    l.13295, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18481
	load    l.13297, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18483
	load    l.13298, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18485
	load    l.13299, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18487
	load    l.13299, $f2
	fsub    $f1, $f2, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.18488
ble_else.18487:
	load    l.13299, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18488:
	b       ble_cont.18486
ble_else.18485:
	load    l.13298, $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18486:
	b       ble_cont.18484
ble_else.18483:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18484:
	b       ble_cont.18482
ble_else.18481:
	fneg    $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18482:
	store   $f1, 1($sp)
	load    l.13295, $f1
	load    0($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18489
	load    l.13297, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18491
	load    l.13298, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18493
	load    l.13299, $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18495
	load    l.13299, $f1
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.18496
ble_else.18495:
	load    l.13299, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18496:
	b       ble_cont.18494
ble_else.18493:
	load    l.13298, $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.18494:
	b       ble_cont.18492
ble_else.18491:
	mov     $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18492:
	b       ble_cont.18490
ble_else.18489:
	fneg    $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18490:
	load    1($sp), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	ret
calc_dirvec.3305:
	li      5, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18497
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $f2, 2($sp)
	store   $f1, 3($sp)
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	load    l.13296, $f2
	fadd    $f1, $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     sqrt.2865
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f2
	load    2($sp), $f3
	finv    $f1, $f15
	fmul    $f3, $f15, $f3
	load    l.13296, $f4
	finv    $f1, $f15
	fmul    $f4, $f15, $f1
	li      min_caml_dirvecs, $i1
	load    1($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    0($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	store   $f2, 0($i3)
	store   $f3, 1($i3)
	store   $f1, 2($i3)
	add     $i2, 40, $i3
	add     $i1, $i3, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	fneg    $f3, $f4
	store   $f2, 0($i3)
	store   $f1, 1($i3)
	store   $f4, 2($i3)
	add     $i2, 80, $i3
	add     $i1, $i3, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	fneg    $f2, $f4
	fneg    $f3, $f5
	store   $f1, 0($i3)
	store   $f4, 1($i3)
	store   $f5, 2($i3)
	add     $i2, 1, $i3
	add     $i1, $i3, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	fneg    $f2, $f4
	fneg    $f3, $f5
	fneg    $f1, $f6
	store   $f4, 0($i3)
	store   $f5, 1($i3)
	store   $f6, 2($i3)
	add     $i2, 41, $i3
	add     $i1, $i3, $i12
	load    0($i12), $i3
	load    0($i3), $i3
	fneg    $f2, $f4
	fneg    $f1, $f5
	store   $f4, 0($i3)
	store   $f5, 1($i3)
	store   $f3, 2($i3)
	add     $i2, 81, $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    0($i1), $i1
	fneg    $f1, $f1
	store   $f1, 0($i1)
	store   $f2, 1($i1)
	store   $f3, 2($i1)
	ret
bge_else.18497:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $f4, 4($sp)
	store   $i1, 5($sp)
	store   $f3, 6($sp)
	fmul    $f2, $f2, $f1
	load    l.13336, $f2
	fadd    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $f1, 7($sp)
	load    l.13296, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_atan.2855
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $f2
	fmul    $f1, $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     tan.3300
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 8($sp)
	load    5($sp), $i1
	add     $i1, 1, $i1
	store   $i1, 9($sp)
	fmul    $f1, $f1, $f1
	load    l.13336, $f2
	fadd    $f1, $f2, $f1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     sqrt.2865
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $f1, 10($sp)
	load    l.13296, $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     cordic_atan.2855
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    4($sp), $f2
	fmul    $f1, $f2, $f1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     tan.3300
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    10($sp), $f2
	fmul    $f1, $f2, $f2
	load    8($sp), $f1
	load    6($sp), $f3
	load    4($sp), $f4
	load    9($sp), $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       calc_dirvec.3305
calc_dirvecs.3313:
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18499
	store   $i1, 0($sp)
	store   $f1, 1($sp)
	store   $i3, 2($sp)
	store   $i2, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_float_of_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    l.13357, $f2
	fmul    $f1, $f2, $f1
	load    l.13358, $f2
	fsub    $f1, $f2, $f3
	li      0, $i1
	load    l.13295, $f1
	load    l.13295, $f2
	load    1($sp), $f4
	load    3($sp), $i2
	load    2($sp), $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     calc_dirvec.3305
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_float_of_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    l.13357, $f2
	fmul    $f1, $f2, $f1
	load    l.13336, $f2
	fadd    $f1, $f2, $f3
	li      0, $i1
	load    l.13295, $f1
	load    l.13295, $f2
	load    2($sp), $i2
	add     $i2, 2, $i3
	load    1($sp), $f4
	load    3($sp), $i2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     calc_dirvec.3305
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $i1
	sub     $i1, 1, $i1
	load    3($sp), $i2
	add     $i2, 1, $i2
	li      5, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18500
	sub     $i2, 5, $i2
	b       bge_cont.18501
bge_else.18500:
bge_cont.18501:
	load    1($sp), $f1
	load    2($sp), $i3
	b       calc_dirvecs.3313
bge_else.18499:
	ret
calc_dirvec_rows.3318:
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18503
	store   $i1, 0($sp)
	store   $i3, 1($sp)
	store   $i2, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_float_of_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13357, $f2
	fmul    $f1, $f2, $f1
	load    l.13358, $f2
	fsub    $f1, $f2, $f1
	li      4, $i1
	load    2($sp), $i2
	load    1($sp), $i3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     calc_dirvecs.3313
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    0($sp), $i1
	sub     $i1, 1, $i1
	load    2($sp), $i2
	add     $i2, 2, $i2
	li      5, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18504
	sub     $i2, 5, $i2
	b       bge_cont.18505
bge_else.18504:
bge_cont.18505:
	load    1($sp), $i3
	add     $i3, 4, $i3
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18506
	store   $i1, 3($sp)
	store   $i3, 4($sp)
	store   $i2, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_float_of_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    l.13357, $f2
	fmul    $f1, $f2, $f1
	load    l.13358, $f2
	fsub    $f1, $f2, $f1
	li      4, $i1
	load    5($sp), $i2
	load    4($sp), $i3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     calc_dirvecs.3313
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    3($sp), $i1
	sub     $i1, 1, $i1
	load    5($sp), $i2
	add     $i2, 2, $i2
	li      5, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18507
	sub     $i2, 5, $i2
	b       bge_cont.18508
bge_else.18507:
bge_cont.18508:
	load    4($sp), $i3
	add     $i3, 4, $i3
	b       calc_dirvec_rows.3318
bge_else.18506:
	ret
bge_else.18503:
	ret
create_dirvec_elements.3324:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18511
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	mov     $i1, $i2
	store   $i2, 2($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    2($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    0($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18512
	store   $i1, 3($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_float_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	mov     $i1, $i2
	store   $i2, 4($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    4($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    3($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18513
	store   $i1, 5($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $i1, $i2
	store   $i2, 6($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    6($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    5($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18514
	store   $i1, 7($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $i1, $i2
	store   $i2, 8($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    8($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    7($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	sub     $i2, 1, $i2
	mov     $i3, $i1
	b       create_dirvec_elements.3324
bge_else.18514:
	ret
bge_else.18513:
	ret
bge_else.18512:
	ret
bge_else.18511:
	ret
create_dirvecs.3327:
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18519
	store   $i1, 0($sp)
	li      min_caml_dirvecs, $i1
	store   $i1, 1($sp)
	li      120, $i1
	store   $i1, 2($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_float_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	mov     $i1, $i2
	store   $i2, 3($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    3($sp), $i1
	store   $i1, 0($i2)
	load    2($sp), $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $i2
	load    1($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	li      min_caml_dirvecs, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i1
	store   $i1, 4($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_float_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	mov     $i1, $i2
	store   $i2, 5($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    5($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    4($sp), $i2
	store   $i1, 118($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $i1, $i2
	store   $i2, 6($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    6($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    4($sp), $i2
	store   $i1, 117($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_float_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $i1, $i2
	store   $i2, 7($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    7($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    4($sp), $i2
	store   $i1, 116($i2)
	li      115, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     create_dirvec_elements.3324
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    0($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18520
	store   $i1, 8($sp)
	li      min_caml_dirvecs, $i1
	store   $i1, 9($sp)
	li      120, $i1
	store   $i1, 10($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_create_float_array
	sub     $sp, 12, $sp
	load    11($sp), $ra
	mov     $i1, $i2
	store   $i2, 11($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    11($sp), $i1
	store   $i1, 0($i2)
	load    10($sp), $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    8($sp), $i2
	load    9($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	li      min_caml_dirvecs, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i1
	store   $i1, 12($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     min_caml_create_float_array
	sub     $sp, 14, $sp
	load    13($sp), $ra
	mov     $i1, $i2
	store   $i2, 13($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    13($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    12($sp), $i2
	store   $i1, 118($i2)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_float_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	mov     $i1, $i2
	store   $i2, 14($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    14($sp), $i1
	store   $i1, 0($i2)
	mov     $i2, $i1
	load    12($sp), $i2
	store   $i1, 117($i2)
	li      116, $i1
	mov     $i2, $i10
	mov     $i1, $i2
	mov     $i10, $i1
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     create_dirvec_elements.3324
	sub     $sp, 16, $sp
	load    15($sp), $ra
	load    8($sp), $i1
	sub     $i1, 1, $i1
	b       create_dirvecs.3327
bge_else.18520:
	ret
bge_else.18519:
	ret
init_dirvec_constants.3329:
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18523
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	add     $i1, $i2, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18524
	store   $i1, 2($sp)
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18525
	store   $i1, 3($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18527
	store   $i2, 4($sp)
	store   $i4, 5($sp)
	mov     $i3, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_rect_table.3102
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18528
be_else.18527:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18529
	store   $i2, 4($sp)
	store   $i4, 5($sp)
	mov     $i3, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_surface_table.3105
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18530
be_else.18529:
	store   $i2, 4($sp)
	store   $i4, 5($sp)
	mov     $i3, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_second_table.3108
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18530:
be_cont.18528:
	sub     $i2, 1, $i2
	load    3($sp), $i1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       bge_cont.18526
bge_else.18525:
bge_cont.18526:
	load    2($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18531
	store   $i1, 6($sp)
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18532
	store   $i1, 7($sp)
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18533
	store   $i1, 8($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18535
	store   $i2, 9($sp)
	store   $i4, 10($sp)
	mov     $i3, $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_rect_table.3102
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $i2
	load    10($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18536
be_else.18535:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18537
	store   $i2, 9($sp)
	store   $i4, 10($sp)
	mov     $i3, $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_surface_table.3105
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $i2
	load    10($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18538
be_else.18537:
	store   $i2, 9($sp)
	store   $i4, 10($sp)
	mov     $i3, $i2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_second_table.3108
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $i2
	load    10($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18538:
be_cont.18536:
	sub     $i2, 1, $i2
	load    8($sp), $i1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 12, $sp
	load    11($sp), $ra
	b       bge_cont.18534
bge_else.18533:
bge_cont.18534:
	load    7($sp), $i1
	sub     $i1, 1, $i2
	load    0($sp), $i1
	b       init_dirvec_constants.3329
bge_else.18532:
	ret
bge_else.18531:
	ret
bge_else.18524:
	ret
bge_else.18523:
	ret
init_vecset_constants.3332:
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18543
	store   $i1, 0($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 1($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18544
	store   $i1, 2($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18546
	store   $i2, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_rect_table.3102
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18547
be_else.18546:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18548
	store   $i2, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_surface_table.3105
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18549
be_else.18548:
	store   $i2, 3($sp)
	store   $i4, 4($sp)
	mov     $i3, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_second_table.3108
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $i2
	load    4($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18549:
be_cont.18547:
	sub     $i2, 1, $i2
	load    2($sp), $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       bge_cont.18545
bge_else.18544:
bge_cont.18545:
	load    1($sp), $i1
	load    118($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    1($sp), $i1
	load    117($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18550
	store   $i1, 5($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18552
	store   $i2, 6($sp)
	store   $i4, 7($sp)
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_rect_table.3102
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $i2
	load    7($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18553
be_else.18552:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18554
	store   $i2, 6($sp)
	store   $i4, 7($sp)
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_surface_table.3105
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $i2
	load    7($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18555
be_else.18554:
	store   $i2, 6($sp)
	store   $i4, 7($sp)
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_second_table.3108
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $i2
	load    7($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18555:
be_cont.18553:
	sub     $i2, 1, $i2
	load    5($sp), $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       bge_cont.18551
bge_else.18550:
bge_cont.18551:
	li      116, $i2
	load    1($sp), $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    0($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18556
	store   $i1, 8($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 9($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $i1
	load    118($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18557
	store   $i1, 10($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18559
	store   $i2, 11($sp)
	store   $i4, 12($sp)
	mov     $i3, $i2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_rect_table.3102
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $i2
	load    12($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18560
be_else.18559:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18561
	store   $i2, 11($sp)
	store   $i4, 12($sp)
	mov     $i3, $i2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_surface_table.3105
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $i2
	load    12($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18562
be_else.18561:
	store   $i2, 11($sp)
	store   $i4, 12($sp)
	mov     $i3, $i2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_second_table.3108
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $i2
	load    12($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18562:
be_cont.18560:
	sub     $i2, 1, $i2
	load    10($sp), $i1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 14, $sp
	load    13($sp), $ra
	b       bge_cont.18558
bge_else.18557:
bge_cont.18558:
	li      117, $i2
	load    9($sp), $i1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    8($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18563
	store   $i1, 13($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 14($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18564
	store   $i1, 15($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18566
	store   $i2, 16($sp)
	store   $i4, 17($sp)
	mov     $i3, $i2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_rect_table.3102
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $i2
	load    17($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18567
be_else.18566:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18568
	store   $i2, 16($sp)
	store   $i4, 17($sp)
	mov     $i3, $i2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_surface_table.3105
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $i2
	load    17($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18569
be_else.18568:
	store   $i2, 16($sp)
	store   $i4, 17($sp)
	mov     $i3, $i2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_second_table.3108
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $i2
	load    17($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18569:
be_cont.18567:
	sub     $i2, 1, $i2
	load    15($sp), $i1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 19, $sp
	load    18($sp), $ra
	b       bge_cont.18565
bge_else.18564:
bge_cont.18565:
	li      118, $i2
	load    14($sp), $i1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    13($sp), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18570
	store   $i1, 18($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      119, $i2
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    18($sp), $i1
	sub     $i1, 1, $i1
	b       init_vecset_constants.3332
bge_else.18570:
	ret
bge_else.18563:
	ret
bge_else.18556:
	ret
bge_else.18543:
	ret
setup_rect_reflection.3343:
	sll     $i1, 2, $i1
	store   $i1, 0($sp)
	li      min_caml_n_reflections, $i3
	load    0($i3), $i3
	store   $i3, 1($sp)
	load    l.13296, $f1
	load    7($i2), $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($sp)
	li      min_caml_light, $i2
	load    0($i2), $f1
	fneg    $f1, $f1
	store   $f1, 3($sp)
	li      min_caml_light, $i2
	load    1($i2), $f1
	fneg    $f1, $f1
	store   $f1, 4($sp)
	li      min_caml_light, $i2
	load    2($i2), $f1
	fneg    $f1, $f1
	store   $f1, 5($sp)
	add     $i1, 1, $i1
	store   $i1, 6($sp)
	li      min_caml_light, $i1
	load    0($i1), $f1
	store   $f1, 7($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $i1, $i2
	store   $i2, 8($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    8($sp), $i3
	store   $i3, 0($i2)
	store   $i2, 9($sp)
	load    7($sp), $f1
	store   $f1, 0($i3)
	load    4($sp), $f1
	store   $f1, 1($i3)
	load    5($sp), $f1
	store   $f1, 2($i3)
	li      min_caml_n_objects, $i4
	load    0($i4), $i4
	sub     $i4, 1, $i4
	cmp     $i4, $zero, $i12
	bl      $i12, bge_else.18575
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18577
	store   $i4, 10($sp)
	store   $i1, 11($sp)
	mov     $i3, $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_rect_table.3102
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $i2
	load    11($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18578
be_else.18577:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18579
	store   $i4, 10($sp)
	store   $i1, 11($sp)
	mov     $i3, $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_surface_table.3105
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $i2
	load    11($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18580
be_else.18579:
	store   $i4, 10($sp)
	store   $i1, 11($sp)
	mov     $i3, $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_second_table.3108
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $i2
	load    11($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18580:
be_cont.18578:
	sub     $i2, 1, $i2
	load    9($sp), $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       bge_cont.18576
bge_else.18575:
bge_cont.18576:
	li      min_caml_reflections, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	load    2($sp), $f1
	store   $f1, 2($i2)
	load    9($sp), $i3
	store   $i3, 1($i2)
	load    6($sp), $i3
	store   $i3, 0($i2)
	load    1($sp), $i3
	add     $i1, $i3, $i12
	store   $i2, 0($i12)
	add     $i3, 1, $i1
	store   $i1, 12($sp)
	load    0($sp), $i1
	add     $i1, 2, $i1
	store   $i1, 13($sp)
	li      min_caml_light, $i1
	load    1($i1), $f1
	store   $f1, 14($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_float_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	mov     $i1, $i2
	store   $i2, 15($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     min_caml_create_array
	sub     $sp, 17, $sp
	load    16($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    15($sp), $i3
	store   $i3, 0($i2)
	store   $i2, 16($sp)
	load    3($sp), $f1
	store   $f1, 0($i3)
	load    14($sp), $f1
	store   $f1, 1($i3)
	load    5($sp), $f1
	store   $f1, 2($i3)
	li      min_caml_n_objects, $i4
	load    0($i4), $i4
	sub     $i4, 1, $i4
	cmp     $i4, $zero, $i12
	bl      $i12, bge_else.18581
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18583
	store   $i4, 17($sp)
	store   $i1, 18($sp)
	mov     $i3, $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_rect_table.3102
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $i2
	load    18($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18584
be_else.18583:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18585
	store   $i4, 17($sp)
	store   $i1, 18($sp)
	mov     $i3, $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_surface_table.3105
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $i2
	load    18($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18586
be_else.18585:
	store   $i4, 17($sp)
	store   $i1, 18($sp)
	mov     $i3, $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_second_table.3108
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $i2
	load    18($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18586:
be_cont.18584:
	sub     $i2, 1, $i2
	load    16($sp), $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 20, $sp
	load    19($sp), $ra
	b       bge_cont.18582
bge_else.18581:
bge_cont.18582:
	li      min_caml_reflections, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	load    2($sp), $f1
	store   $f1, 2($i2)
	load    16($sp), $i3
	store   $i3, 1($i2)
	load    13($sp), $i3
	store   $i3, 0($i2)
	load    12($sp), $i3
	add     $i1, $i3, $i12
	store   $i2, 0($i12)
	load    1($sp), $i1
	add     $i1, 2, $i1
	store   $i1, 19($sp)
	load    0($sp), $i1
	add     $i1, 3, $i1
	store   $i1, 20($sp)
	li      min_caml_light, $i1
	load    2($i1), $f1
	store   $f1, 21($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 22($sp)
	add     $sp, 23, $sp
	jal     min_caml_create_float_array
	sub     $sp, 23, $sp
	load    22($sp), $ra
	mov     $i1, $i2
	store   $i2, 22($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 23($sp)
	add     $sp, 24, $sp
	jal     min_caml_create_array
	sub     $sp, 24, $sp
	load    23($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    22($sp), $i3
	store   $i3, 0($i2)
	store   $i2, 23($sp)
	load    3($sp), $f1
	store   $f1, 0($i3)
	load    4($sp), $f1
	store   $f1, 1($i3)
	load    21($sp), $f1
	store   $f1, 2($i3)
	li      min_caml_n_objects, $i4
	load    0($i4), $i4
	sub     $i4, 1, $i4
	cmp     $i4, $zero, $i12
	bl      $i12, bge_else.18587
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18589
	store   $i4, 24($sp)
	store   $i1, 25($sp)
	mov     $i3, $i1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_rect_table.3102
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $i2
	load    25($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18590
be_else.18589:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18591
	store   $i4, 24($sp)
	store   $i1, 25($sp)
	mov     $i3, $i1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_surface_table.3105
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $i2
	load    25($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18592
be_else.18591:
	store   $i4, 24($sp)
	store   $i1, 25($sp)
	mov     $i3, $i1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_second_table.3108
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $i2
	load    25($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18592:
be_cont.18590:
	sub     $i2, 1, $i2
	load    23($sp), $i1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 27, $sp
	load    26($sp), $ra
	b       bge_cont.18588
bge_else.18587:
bge_cont.18588:
	li      min_caml_reflections, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	load    2($sp), $f1
	store   $f1, 2($i2)
	load    23($sp), $i3
	store   $i3, 1($i2)
	load    20($sp), $i3
	store   $i3, 0($i2)
	load    19($sp), $i3
	add     $i1, $i3, $i12
	store   $i2, 0($i12)
	li      min_caml_n_reflections, $i1
	load    1($sp), $i2
	add     $i2, 3, $i2
	store   $i2, 0($i1)
	ret
setup_surface_reflection.3346:
	sll     $i1, 2, $i1
	add     $i1, 1, $i1
	store   $i1, 0($sp)
	li      min_caml_n_reflections, $i1
	load    0($i1), $i1
	store   $i1, 1($sp)
	load    l.13296, $f1
	load    7($i2), $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($sp)
	li      min_caml_light, $i1
	load    4($i2), $i3
	load    0($i1), $f1
	load    0($i3), $f2
	fmul    $f1, $f2, $f1
	load    1($i1), $f2
	load    1($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    2($i1), $f2
	load    2($i3), $f3
	fmul    $f2, $f3, $f2
	fadd    $f1, $f2, $f1
	load    l.13300, $f2
	load    4($i2), $i1
	load    0($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f2
	li      min_caml_light, $i1
	load    0($i1), $f3
	fsub    $f2, $f3, $f2
	store   $f2, 3($sp)
	load    l.13300, $f2
	load    4($i2), $i1
	load    1($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f2
	li      min_caml_light, $i1
	load    1($i1), $f3
	fsub    $f2, $f3, $f2
	store   $f2, 4($sp)
	load    l.13300, $f2
	load    4($i2), $i1
	load    2($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	li      min_caml_light, $i1
	load    2($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 5($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $i1, $i2
	store   $i2, 6($sp)
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $i2
	add     $hp, 2, $hp
	store   $i1, 1($i2)
	load    6($sp), $i3
	store   $i3, 0($i2)
	store   $i2, 7($sp)
	load    3($sp), $f1
	store   $f1, 0($i3)
	load    4($sp), $f1
	store   $f1, 1($i3)
	load    5($sp), $f1
	store   $f1, 2($i3)
	li      min_caml_n_objects, $i4
	load    0($i4), $i4
	sub     $i4, 1, $i4
	cmp     $i4, $zero, $i12
	bl      $i12, bge_else.18594
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18596
	store   $i4, 8($sp)
	store   $i1, 9($sp)
	mov     $i3, $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_rect_table.3102
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $i2
	load    9($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18597
be_else.18596:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18598
	store   $i4, 8($sp)
	store   $i1, 9($sp)
	mov     $i3, $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_surface_table.3105
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $i2
	load    9($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18599
be_else.18598:
	store   $i4, 8($sp)
	store   $i1, 9($sp)
	mov     $i3, $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_second_table.3108
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $i2
	load    9($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18599:
be_cont.18597:
	sub     $i2, 1, $i2
	load    7($sp), $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 11, $sp
	load    10($sp), $ra
	b       bge_cont.18595
bge_else.18594:
bge_cont.18595:
	li      min_caml_reflections, $i1
	mov     $hp, $i2
	add     $hp, 3, $hp
	load    2($sp), $f1
	store   $f1, 2($i2)
	load    7($sp), $i3
	store   $i3, 1($i2)
	load    0($sp), $i3
	store   $i3, 0($i2)
	load    1($sp), $i3
	add     $i1, $i3, $i12
	store   $i2, 0($i12)
	li      min_caml_n_reflections, $i1
	add     $i3, 1, $i2
	store   $i2, 0($i1)
	ret
rt.3351:
	li      min_caml_image_size, $i3
	store   $i1, 0($i3)
	li      min_caml_image_size, $i3
	store   $i2, 1($i3)
	li      min_caml_image_center, $i3
	srl     $i1, 1, $i4
	store   $i4, 0($i3)
	li      min_caml_image_center, $i3
	srl     $i2, 1, $i2
	store   $i2, 1($i3)
	li      min_caml_scan_pitch, $i2
	store   $i2, 0($sp)
	load    l.13420, $f1
	store   $f1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_float_of_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	load    0($sp), $i1
	store   $f1, 0($i1)
	li      min_caml_image_size, $i1
	load    0($i1), $i1
	store   $i1, 2($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_float_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $i1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     create_float5x3array.3291
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $i1, 4($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $i1, 5($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     create_float5x3array.3291
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $i1, 7($sp)
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     create_float5x3array.3291
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $i1, 8($sp)
	li      1, $i1
	li      0, $i2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	store   $i1, 9($sp)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     create_float5x3array.3291
	sub     $sp, 11, $sp
	load    10($sp), $ra
	mov     $hp, $i2
	add     $hp, 8, $hp
	store   $i1, 7($i2)
	load    9($sp), $i1
	store   $i1, 6($i2)
	load    8($sp), $i1
	store   $i1, 5($i2)
	load    7($sp), $i1
	store   $i1, 4($i2)
	load    6($sp), $i1
	store   $i1, 3($i2)
	load    5($sp), $i1
	store   $i1, 2($i2)
	load    4($sp), $i1
	store   $i1, 1($i2)
	load    3($sp), $i1
	store   $i1, 0($i2)
	load    2($sp), $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	sub     $i2, 2, $i2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     init_line_elements.3295
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $i1, 10($sp)
	li      min_caml_image_size, $i1
	load    0($i1), $i1
	store   $i1, 11($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_float_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	store   $i1, 12($sp)
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     create_float5x3array.3291
	sub     $sp, 14, $sp
	load    13($sp), $ra
	store   $i1, 13($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	store   $i1, 14($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	store   $i1, 15($sp)
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     create_float5x3array.3291
	sub     $sp, 17, $sp
	load    16($sp), $ra
	store   $i1, 16($sp)
	store   $ra, 17($sp)
	add     $sp, 18, $sp
	jal     create_float5x3array.3291
	sub     $sp, 18, $sp
	load    17($sp), $ra
	store   $i1, 17($sp)
	li      1, $i1
	li      0, $i2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     min_caml_create_array
	sub     $sp, 19, $sp
	load    18($sp), $ra
	store   $i1, 18($sp)
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     create_float5x3array.3291
	sub     $sp, 20, $sp
	load    19($sp), $ra
	mov     $hp, $i2
	add     $hp, 8, $hp
	store   $i1, 7($i2)
	load    18($sp), $i1
	store   $i1, 6($i2)
	load    17($sp), $i1
	store   $i1, 5($i2)
	load    16($sp), $i1
	store   $i1, 4($i2)
	load    15($sp), $i1
	store   $i1, 3($i2)
	load    14($sp), $i1
	store   $i1, 2($i2)
	load    13($sp), $i1
	store   $i1, 1($i2)
	load    12($sp), $i1
	store   $i1, 0($i2)
	load    11($sp), $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     min_caml_create_array
	sub     $sp, 20, $sp
	load    19($sp), $ra
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	sub     $i2, 2, $i2
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     init_line_elements.3295
	sub     $sp, 20, $sp
	load    19($sp), $ra
	store   $i1, 19($sp)
	li      min_caml_image_size, $i1
	load    0($i1), $i1
	store   $i1, 20($sp)
	li      3, $i1
	load    l.13295, $f1
	store   $ra, 21($sp)
	add     $sp, 22, $sp
	jal     min_caml_create_float_array
	sub     $sp, 22, $sp
	load    21($sp), $ra
	store   $i1, 21($sp)
	store   $ra, 22($sp)
	add     $sp, 23, $sp
	jal     create_float5x3array.3291
	sub     $sp, 23, $sp
	load    22($sp), $ra
	store   $i1, 22($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 23($sp)
	add     $sp, 24, $sp
	jal     min_caml_create_array
	sub     $sp, 24, $sp
	load    23($sp), $ra
	store   $i1, 23($sp)
	li      5, $i1
	li      0, $i2
	store   $ra, 24($sp)
	add     $sp, 25, $sp
	jal     min_caml_create_array
	sub     $sp, 25, $sp
	load    24($sp), $ra
	store   $i1, 24($sp)
	store   $ra, 25($sp)
	add     $sp, 26, $sp
	jal     create_float5x3array.3291
	sub     $sp, 26, $sp
	load    25($sp), $ra
	store   $i1, 25($sp)
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     create_float5x3array.3291
	sub     $sp, 27, $sp
	load    26($sp), $ra
	store   $i1, 26($sp)
	li      1, $i1
	li      0, $i2
	store   $ra, 27($sp)
	add     $sp, 28, $sp
	jal     min_caml_create_array
	sub     $sp, 28, $sp
	load    27($sp), $ra
	store   $i1, 27($sp)
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     create_float5x3array.3291
	sub     $sp, 29, $sp
	load    28($sp), $ra
	mov     $hp, $i2
	add     $hp, 8, $hp
	store   $i1, 7($i2)
	load    27($sp), $i1
	store   $i1, 6($i2)
	load    26($sp), $i1
	store   $i1, 5($i2)
	load    25($sp), $i1
	store   $i1, 4($i2)
	load    24($sp), $i1
	store   $i1, 3($i2)
	load    23($sp), $i1
	store   $i1, 2($i2)
	load    22($sp), $i1
	store   $i1, 1($i2)
	load    21($sp), $i1
	store   $i1, 0($i2)
	load    20($sp), $i1
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     min_caml_create_array
	sub     $sp, 29, $sp
	load    28($sp), $ra
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	sub     $i2, 2, $i2
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     init_line_elements.3295
	sub     $sp, 29, $sp
	load    28($sp), $ra
	store   $i1, 28($sp)
	store   $ra, 29($sp)
	add     $sp, 30, $sp
	jal     read_screen_settings.2997
	sub     $sp, 30, $sp
	load    29($sp), $ra
	store   $ra, 29($sp)
	add     $sp, 30, $sp
	jal     read_light.2999
	sub     $sp, 30, $sp
	load    29($sp), $ra
	li      0, $i1
	store   $i1, 29($sp)
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_nth_object.3004
	sub     $sp, 31, $sp
	load    30($sp), $ra
	cmp     $i1, $zero, $i12
	bne     $i12, be_else.18601
	li      min_caml_n_objects, $i1
	load    29($sp), $i2
	store   $i2, 0($i1)
	b       be_cont.18602
be_else.18601:
	li      1, $i1
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_object.3006
	sub     $sp, 31, $sp
	load    30($sp), $ra
be_cont.18602:
	li      0, $i1
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_and_network.3014
	sub     $sp, 31, $sp
	load    30($sp), $ra
	li      min_caml_or_net, $i1
	store   $i1, 30($sp)
	li      0, $i1
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     read_or_network.3012
	sub     $sp, 32, $sp
	load    31($sp), $ra
	load    30($sp), $i2
	store   $i1, 0($i2)
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     write_ppm_header.3259
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      4, $i1
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     create_dirvecs.3327
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      9, $i1
	li      0, $i2
	li      0, $i3
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     calc_dirvec_rows.3318
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      min_caml_dirvecs, $i1
	load    4($i1), $i1
	store   $i1, 31($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $zero, $i12
	bl      $i12, bge_else.18603
	store   $i1, 32($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18605
	store   $i2, 33($sp)
	store   $i4, 34($sp)
	mov     $i3, $i2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_rect_table.3102
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $i2
	load    34($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18606
be_else.18605:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18607
	store   $i2, 33($sp)
	store   $i4, 34($sp)
	mov     $i3, $i2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_surface_table.3105
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $i2
	load    34($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	b       be_cont.18608
be_else.18607:
	store   $i2, 33($sp)
	store   $i4, 34($sp)
	mov     $i3, $i2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_second_table.3108
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $i2
	load    34($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18608:
be_cont.18606:
	sub     $i2, 1, $i2
	load    32($sp), $i1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       bge_cont.18604
bge_else.18603:
bge_cont.18604:
	li      118, $i2
	load    31($sp), $i1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_dirvecs, $i1
	load    3($i1), $i1
	li      119, $i2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      2, $i1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_vecset_constants.3332
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_light_dirvec, $i1
	load    0($i1), $i1
	li      min_caml_light, $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	load    1($i2), $f1
	store   $f1, 1($i1)
	load    2($i2), $f1
	store   $f1, 2($i1)
	li      min_caml_light_dirvec, $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_n_objects, $i1
	load    0($i1), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bl      $i12, bge_else.18609
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	load    2($i2), $i3
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18611
	load    7($i2), $i3
	load    0($i3), $f1
	load    l.13296, $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18613
	li      0, $i3
	b       ble_cont.18614
ble_else.18613:
	li      1, $i3
ble_cont.18614:
	cmp     $i3, $zero, $i12
	bne     $i12, be_else.18615
	b       be_cont.18616
be_else.18615:
	load    1($i2), $i3
	li      1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18617
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_rect_reflection.3343
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.18618
be_else.18617:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18619
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_surface_reflection.3346
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.18620
be_else.18619:
be_cont.18620:
be_cont.18618:
be_cont.18616:
	b       be_cont.18612
be_else.18611:
be_cont.18612:
	b       bge_cont.18610
bge_else.18609:
bge_cont.18610:
	li      0, $i2
	li      0, $i3
	load    19($sp), $i1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     pretrace_line.3275
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      0, $i2
	li      2, $i3
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	cmp     $i1, $zero, $i12
	bg      $i12, ble_else.18621
	ret
ble_else.18621:
	store   $i2, 35($sp)
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $zero, $i12
	bg      $i12, ble_else.18623
	b       ble_cont.18624
ble_else.18623:
	li      1, $i2
	load    28($sp), $i1
	store   $ra, 36($sp)
	add     $sp, 37, $sp
	jal     pretrace_line.3275
	sub     $sp, 37, $sp
	load    36($sp), $ra
ble_cont.18624:
	li      0, $i1
	load    35($sp), $i2
	load    10($sp), $i3
	load    19($sp), $i4
	load    28($sp), $i5
	store   $ra, 36($sp)
	add     $sp, 37, $sp
	jal     scan_pixel.3279
	sub     $sp, 37, $sp
	load    36($sp), $ra
	li      1, $i1
	li      4, $i5
	load    19($sp), $i2
	load    28($sp), $i3
	load    10($sp), $i4
	b       scan_line.3285
l.13420:	.float  1.2800000000E+02
l.13358:	.float  9.0000000000E-01
l.13357:	.float  2.0000000000E-01
l.13338:	.float  1.5000000000E+02
l.13337:	.float  -1.5000000000E+02
l.13336:	.float  1.0000000000E-01
l.13335:	.float  -2.0000000000E+00
l.13334:	.float  3.9062500000E-03
l.13333:	.float  1.0000000000E+08
l.13332:	.float  1.0000000000E+09
l.13331:	.float  2.0000000000E+01
l.13330:	.float  5.0000000000E-02
l.13329:	.float  2.5000000000E-01
l.13328:	.float  1.0000000000E+01
l.13327:	.float  3.0000000000E-01
l.13326:	.float  2.5500000000E+02
l.13325:	.float  1.5000000000E-01
l.13324:	.float  3.1415927000E+00
l.13323:	.float  3.0000000000E+01
l.13322:	.float  1.5000000000E+01
l.13321:	.float  1.0000000000E-04
l.13320:	.float  -1.0000000000E-01
l.13319:	.float  1.0000000000E-02
l.13318:	.float  -2.0000000000E-01
l.13305:	.float  -2.0000000000E+02
l.13304:	.float  2.0000000000E+02
l.13303:	.float  1.7453293000E-02
l.13302:	.float  -1.0000000000E+00
l.13301:	.float  3.0000000000E+00
l.13300:	.float  2.0000000000E+00
l.13299:	.float  6.2831853072E+00
l.13298:	.float  3.1415926536E+00
l.13297:	.float  1.5707963268E+00
l.13296:	.float  1.0000000000E+00
l.13295:	.float  0.0000000000E+00
l.13294:	.float  6.0725293501E-01
l.13293:	.float  5.0000000000E-01
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
# * floor
######################################################################
min_caml_floor:
	fcmp $f1 $fzero $cond
	bge $cond FLOOR_POSITIVE	# if ($f1 >= 0) FLOOR_POSITIVE
	store $sp $ra 0
	addi $sp $sp 1
	fsub $fzero $f1 $f1
	jal min_caml_floor		# $f1 = FLOOR_POSITIVE(-$f1)
	load $zero $f2 FLOOR_MONE
	fsub $f2 $f1 $f1		# $f1 = (-1) - $f1
	addi $sp $sp -1
	load $sp $ra 0
	ret
FLOOR_POSITIVE:
	load $zero $mf FLOAT_MAGICF
	fcmp $f1 $mf $cond
	ble $cond FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	store $sp $f1 0
	fadd $f1 $mf $f1		# $f1 += 0x4b000000
	fsub $f1 $mf $f1		# $f1 -= 0x4b000000
	load $sp $f2 0
	fcmp $f1 $f2 $cond
	ble $cond FLOOR_RET
	load $zero $f2 FLOOR_ONE
	fsub $f1 $f2 $f1		# 返り値が元の値より大きければ1.0引く
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
# * read_int
# * intバイナリ読み込み
######################################################################
min_caml_read_int:
read_int_1:
	read $i1
	li 255, $i2
	cmp $i1, $i2, $i2
	bg $i2, read_int_1
	sll $i1, 24, $i1
read_int_2:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_int_2
	sll $i2, 16, $i2
	add $i1, $i2, $i1
read_int_3:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_int_3
	sll $i2, 8, $i2
	add $i1, $i2, $i1
read_int_4:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_int_4
	add $i1, $i2, $i1
	ret

######################################################################
# * read_float
# * floatバイナリ読み込み
######################################################################
min_caml_read_float:
read_float_1:
	read $i1
	li 255, $i2
	cmp $i1, $i2, $i2
	bg $i2, read_float_1
	sll $i1, 24, $i1
read_float_2:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_float_2
	sll $i2, 16, $i2
	add $i1, $i2, $i1
read_float_3:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_float_3
	sll $i2, 8, $i2
	add $i1, $i2, $i1
read_float_4:
	read $i2
	li 255, $i3
	cmp $i2, $i3, $i3
	bg $i3, read_float_4
	add $i1, $i2, $i1
	mov $i1, $f1 #intレジスタからfloatレジスタへ移動
	ret

######################################################################
# * read
# * バイト読み込み
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
# * バイト出力
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
# * ledout_int
# * バイトLED出力
######################################################################
min_caml_ledout_int:
	ledout $i1
	ret

######################################################################
# * ledout_float
# * バイトLED出力
######################################################################
min_caml_ledout_float:
	ledout $f1
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
