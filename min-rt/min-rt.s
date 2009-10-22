######################################################################
#
# 		↓　ここから macro.s
#
######################################################################

#レジスタ名置き換え
.define $zero $0
.define $ra $31
.define $sp $30
.define $hp $29
.define $0 orz
.define $31 orz
.define $30 orz
.define $29 orz

#jmp
.define { jmp %Reg %Imm %Imm } { _jmp %1 %2 %{ %3 - %pc } }

#疑似命令
.define { mov %Reg %Reg } { addi %1 %2 0 }
.define { neg %Reg %Reg } { sub $zero %1 %2 }
.define { fneg %Reg %Reg } { fsub $zero %1 %2 }
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

#スタックとヒープの初期化
	li      0x1000, $hp
	sll		$hp, 4, $hp
	sll     $hp, 3, $sp

######################################################################
#
# 		↑　ここまで macro.s
#
######################################################################
	li      128, $1
	li      128, $2
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     rt.3351
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      0, $28
	halt
cordic_rec.6797:
	li      25, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17410
	mov     $4, $1
	ret
be_else.17410:
	fcmp    $1, $5, $28
	bg      $28, ble_else.17411
	add     $2, 1, $7
	fmul    $6, $4, $8
	fadd    $3, $8, $8
	fmul    $6, $3, $3
	fsub    $4, $3, $4
	li      min_caml_atan_table, $3
	add     $3, $2, $28
	load    0($28), $2
	fsub    $5, $2, $5
	load    l.13293, $2
	fmul    $6, $2, $6
	mov     $8, $3
	mov     $7, $2
	b       cordic_rec.6797
ble_else.17411:
	add     $2, 1, $7
	fmul    $6, $4, $8
	fsub    $3, $8, $8
	fmul    $6, $3, $3
	fadd    $4, $3, $4
	li      min_caml_atan_table, $3
	add     $3, $2, $28
	load    0($28), $2
	fadd    $5, $2, $5
	load    l.13293, $2
	fmul    $6, $2, $6
	mov     $8, $3
	mov     $7, $2
	b       cordic_rec.6797
cordic_sin.2851:
	li      0, $2
	load    l.13294, $3
	load    l.13295, $4
	load    l.13295, $5
	load    l.13296, $6
	b       cordic_rec.6797
cordic_rec.6762:
	li      25, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17412
	mov     $3, $1
	ret
be_else.17412:
	fcmp    $1, $5, $28
	bg      $28, ble_else.17413
	add     $2, 1, $7
	fmul    $6, $4, $8
	fadd    $3, $8, $8
	fmul    $6, $3, $3
	fsub    $4, $3, $4
	li      min_caml_atan_table, $3
	add     $3, $2, $28
	load    0($28), $2
	fsub    $5, $2, $5
	load    l.13293, $2
	fmul    $6, $2, $6
	mov     $8, $3
	mov     $7, $2
	b       cordic_rec.6762
ble_else.17413:
	add     $2, 1, $7
	fmul    $6, $4, $8
	fsub    $3, $8, $8
	fmul    $6, $3, $3
	fadd    $4, $3, $4
	li      min_caml_atan_table, $3
	add     $3, $2, $28
	load    0($28), $2
	fadd    $5, $2, $5
	load    l.13293, $2
	fmul    $6, $2, $6
	mov     $8, $3
	mov     $7, $2
	b       cordic_rec.6762
cordic_cos.2853:
	li      0, $2
	load    l.13294, $3
	load    l.13295, $4
	load    l.13295, $5
	load    l.13296, $6
	b       cordic_rec.6762
cordic_rec.6728:
	li      25, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17414
	mov     $4, $1
	ret
be_else.17414:
	load    l.13295, $6
	fcmp    $3, $6, $28
	bg      $28, ble_else.17415
	add     $1, 1, $6
	fmul    $5, $3, $7
	fsub    $2, $7, $7
	fmul    $5, $2, $2
	fadd    $3, $2, $3
	li      min_caml_atan_table, $2
	add     $2, $1, $28
	load    0($28), $1
	fsub    $4, $1, $4
	load    l.13293, $1
	fmul    $5, $1, $5
	mov     $7, $2
	mov     $6, $1
	b       cordic_rec.6728
ble_else.17415:
	add     $1, 1, $6
	fmul    $5, $3, $7
	fadd    $2, $7, $7
	fmul    $5, $2, $2
	fsub    $3, $2, $3
	li      min_caml_atan_table, $2
	add     $2, $1, $28
	load    0($28), $1
	fadd    $4, $1, $4
	load    l.13293, $1
	fmul    $5, $1, $5
	mov     $7, $2
	mov     $6, $1
	b       cordic_rec.6728
cordic_atan.2855:
	li      0, $2
	load    l.13296, $3
	load    l.13295, $4
	load    l.13296, $5
	mov     $3, $26
	mov     $1, $3
	mov     $2, $1
	mov     $26, $2
	b       cordic_rec.6728
sin.2857:
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17416
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17417
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17418
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17419
	load    l.13299, $2
	fsub    $1, $2, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17420
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17421
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17422
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17423
	load    l.13299, $2
	fsub    $1, $2, $1
	b       sin.2857
ble_else.17423:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17422:
	load    l.13298, $2
	fsub    $2, $1, $1
	b       cordic_sin.2851
ble_else.17421:
	b       cordic_sin.2851
ble_else.17420:
	fneg    $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17419:
	load    l.13299, $2
	fsub    $2, $1, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17424
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17426
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17428
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17430
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17431
ble_else.17430:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
ble_cont.17431:
	b       ble_cont.17429
ble_else.17428:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17429:
	b       ble_cont.17427
ble_else.17426:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17427:
	b       ble_cont.17425
ble_else.17424:
	fneg    $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
ble_cont.17425:
	fneg    $1, $1
	ret
ble_else.17418:
	load    l.13298, $2
	fsub    $2, $1, $1
	b       cordic_sin.2851
ble_else.17417:
	b       cordic_sin.2851
ble_else.17416:
	fneg    $1, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17432
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17434
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17436
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17438
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17439
ble_else.17438:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
ble_cont.17439:
	b       ble_cont.17437
ble_else.17436:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17437:
	b       ble_cont.17435
ble_else.17434:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17435:
	b       ble_cont.17433
ble_else.17432:
	fneg    $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
ble_cont.17433:
	fneg    $1, $1
	ret
cos.2859:
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17440
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17441
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17442
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17443
	load    l.13299, $2
	fsub    $1, $2, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17444
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17445
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17446
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17447
	load    l.13299, $2
	fsub    $1, $2, $1
	b       cos.2859
ble_else.17447:
	load    l.13299, $2
	fsub    $2, $1, $1
	b       cos.2859
ble_else.17446:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17445:
	b       cordic_cos.2853
ble_else.17444:
	fneg    $1, $1
	b       cos.2859
ble_else.17443:
	load    l.13299, $2
	fsub    $2, $1, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17448
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17449
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17450
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17451
	load    l.13299, $2
	fsub    $1, $2, $1
	b       cos.2859
ble_else.17451:
	load    l.13299, $2
	fsub    $2, $1, $1
	b       cos.2859
ble_else.17450:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17449:
	b       cordic_cos.2853
ble_else.17448:
	fneg    $1, $1
	b       cos.2859
ble_else.17442:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17441:
	b       cordic_cos.2853
ble_else.17440:
	fneg    $1, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17452
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17453
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17454
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17455
	load    l.13299, $2
	fsub    $1, $2, $1
	b       cos.2859
ble_else.17455:
	load    l.13299, $2
	fsub    $2, $1, $1
	b       cos.2859
ble_else.17454:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $1, $1
	ret
ble_else.17453:
	b       cordic_cos.2853
ble_else.17452:
	fneg    $1, $1
	b       cos.2859
get_sqrt_init_rec.6691.10569:
	li      49, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17456
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
be_else.17456:
	load    l.13300, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17457
	load    l.13293, $3
	fmul    $1, $3, $1
	add     $2, 1, $2
	li      49, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17458
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
be_else.17458:
	load    l.13300, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17459
	load    l.13293, $3
	fmul    $1, $3, $1
	add     $2, 1, $2
	li      49, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17460
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
be_else.17460:
	load    l.13300, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17461
	load    l.13293, $3
	fmul    $1, $3, $1
	add     $2, 1, $2
	li      49, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17462
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
be_else.17462:
	load    l.13300, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17463
	load    l.13293, $3
	fmul    $1, $3, $1
	add     $2, 1, $2
	b       get_sqrt_init_rec.6691.10569
ble_else.17463:
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
ble_else.17461:
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
ble_else.17459:
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
ble_else.17457:
	li      min_caml_rsqrt_table, $1
	add     $1, $2, $28
	load    0($28), $1
	ret
sqrt.2865:
	load    l.13296, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17464
	store   $1, 0($sp)
	load    l.13300, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17465
	load    l.13293, $2
	fmul    $1, $2, $1
	load    l.13300, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17467
	load    l.13293, $2
	fmul    $1, $2, $1
	load    l.13300, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17469
	load    l.13293, $2
	fmul    $1, $2, $1
	li      3, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     get_sqrt_init_rec.6691.10569
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.17470
ble_else.17469:
	li      min_caml_rsqrt_table, $1
	load    2($1), $1
ble_cont.17470:
	b       ble_cont.17468
ble_else.17467:
	li      min_caml_rsqrt_table, $1
	load    1($1), $1
ble_cont.17468:
	b       ble_cont.17466
ble_else.17465:
	li      min_caml_rsqrt_table, $1
	load    0($1), $1
ble_cont.17466:
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	load    0($sp), $4
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	load    l.13293, $2
	fmul    $2, $1, $2
	load    l.13301, $3
	fmul    $4, $1, $5
	fmul    $5, $1, $1
	fsub    $3, $1, $1
	fmul    $2, $1, $1
	fmul    $1, $4, $1
	ret
ble_else.17464:
	load    l.13293, $2
	finv    $1, $28
	fmul    $1, $28, $3
	fadd    $1, $3, $3
	fmul    $2, $3, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $4
	fadd    $2, $4, $2
	fmul    $3, $2, $2
	load    l.13293, $3
	finv    $2, $28
	fmul    $1, $28, $1
	fadd    $2, $1, $1
	fmul    $3, $1, $1
	ret
vecunit_sgn.2896:
	store   $1, 0($sp)
	store   $2, 1($sp)
	load    0($1), $2
	fmul    $2, $2, $2
	load    1($1), $3
	fmul    $3, $3, $3
	fadd    $2, $3, $2
	load    2($1), $1
	fmul    $1, $1, $1
	fadd    $2, $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     sqrt.2865
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    l.13295, $2
	fcmp    $1, $2, $28
	bne     $28, be_else.17471
	li      1, $2
	b       be_cont.17472
be_else.17471:
	li      0, $2
be_cont.17472:
	cmp     $2, $zero, $28
	bne     $28, be_else.17473
	load    1($sp), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.17475
	load    l.13296, $2
	finv    $1, $28
	fmul    $2, $28, $1
	b       be_cont.17476
be_else.17475:
	load    l.13302, $2
	finv    $1, $28
	fmul    $2, $28, $1
be_cont.17476:
	b       be_cont.17474
be_else.17473:
	load    l.13296, $1
be_cont.17474:
	load    0($sp), $2
	load    0($2), $3
	fmul    $3, $1, $3
	store   $3, 0($2)
	load    1($2), $3
	fmul    $3, $1, $3
	store   $3, 1($2)
	load    2($2), $3
	fmul    $3, $1, $1
	store   $1, 2($2)
	ret
vecaccumv.2920:
	load    0($1), $4
	load    0($2), $5
	load    0($3), $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	store   $4, 0($1)
	load    1($1), $4
	load    1($2), $5
	load    1($3), $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	store   $4, 1($1)
	load    2($1), $4
	load    2($2), $2
	load    2($3), $3
	fmul    $2, $3, $2
	fadd    $4, $2, $2
	store   $2, 2($1)
	ret
read_screen_settings.2997:
	li      min_caml_screen, $1
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_float
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	store   $1, 0($2)
	li      min_caml_screen, $1
	store   $1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_float
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $2
	store   $1, 1($2)
	li      min_caml_screen, $1
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_float
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $2
	store   $1, 2($2)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_float
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	store   $1, 3($sp)
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17479
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17481
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17483
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17485
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.17486
ble_else.17485:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17486:
	b       ble_cont.17484
ble_else.17483:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $1, $1
ble_cont.17484:
	b       ble_cont.17482
ble_else.17481:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17482:
	b       ble_cont.17480
ble_else.17479:
	fneg    $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17480:
	store   $1, 4($sp)
	load    l.13295, $1
	load    3($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.17487
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17489
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17491
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17493
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.17494
ble_else.17493:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.17494:
	b       ble_cont.17492
ble_else.17491:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17492:
	b       ble_cont.17490
ble_else.17489:
	mov     $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17490:
	b       ble_cont.17488
ble_else.17487:
	fneg    $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.17488:
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	store   $1, 6($sp)
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17495
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17497
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17499
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17501
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.17502
ble_else.17501:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17502:
	b       ble_cont.17500
ble_else.17499:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $1, $1
ble_cont.17500:
	b       ble_cont.17498
ble_else.17497:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17498:
	b       ble_cont.17496
ble_else.17495:
	fneg    $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17496:
	store   $1, 7($sp)
	load    l.13295, $1
	load    6($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.17503
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17505
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17507
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17509
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       ble_cont.17510
ble_else.17509:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $1, $1
ble_cont.17510:
	b       ble_cont.17508
ble_else.17507:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.17508:
	b       ble_cont.17506
ble_else.17505:
	mov     $2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.17506:
	b       ble_cont.17504
ble_else.17503:
	fneg    $2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $1, $1
ble_cont.17504:
	li      min_caml_screenz_dir, $2
	load    4($sp), $3
	fmul    $3, $1, $4
	load    l.13304, $5
	fmul    $4, $5, $4
	store   $4, 0($2)
	li      min_caml_screenz_dir, $2
	load    l.13305, $4
	load    5($sp), $5
	fmul    $5, $4, $4
	store   $4, 1($2)
	li      min_caml_screenz_dir, $2
	load    7($sp), $4
	fmul    $3, $4, $6
	load    l.13304, $7
	fmul    $6, $7, $6
	store   $6, 2($2)
	li      min_caml_screenx_dir, $2
	store   $4, 0($2)
	li      min_caml_screenx_dir, $2
	load    l.13295, $6
	store   $6, 1($2)
	li      min_caml_screenx_dir, $2
	fneg    $1, $6
	store   $6, 2($2)
	li      min_caml_screeny_dir, $2
	fneg    $5, $6
	fmul    $6, $1, $1
	store   $1, 0($2)
	li      min_caml_screeny_dir, $1
	fneg    $3, $2
	store   $2, 1($1)
	li      min_caml_screeny_dir, $1
	fneg    $5, $2
	fmul    $2, $4, $2
	store   $2, 2($1)
	li      min_caml_viewpoint, $1
	li      min_caml_screen, $2
	load    0($2), $2
	li      min_caml_screenz_dir, $3
	load    0($3), $3
	fsub    $2, $3, $2
	store   $2, 0($1)
	li      min_caml_viewpoint, $1
	li      min_caml_screen, $2
	load    1($2), $2
	li      min_caml_screenz_dir, $3
	load    1($3), $3
	fsub    $2, $3, $2
	store   $2, 1($1)
	li      min_caml_viewpoint, $1
	li      min_caml_screen, $2
	load    2($2), $2
	li      min_caml_screenz_dir, $3
	load    2($3), $3
	fsub    $2, $3, $2
	store   $2, 2($1)
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
	load    l.13303, $2
	fmul    $1, $2, $1
	store   $1, 0($sp)
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17512
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17514
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17516
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17518
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.17519
ble_else.17518:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $1, $1
ble_cont.17519:
	b       ble_cont.17517
ble_else.17516:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.17517:
	b       ble_cont.17515
ble_else.17514:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.17515:
	b       ble_cont.17513
ble_else.17512:
	fneg    $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $1, $1
ble_cont.17513:
	li      min_caml_light, $2
	fneg    $1, $1
	store   $1, 1($2)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_float
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	store   $1, 1($sp)
	load    l.13295, $1
	load    0($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.17520
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17522
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17524
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17526
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.17527
ble_else.17526:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17527:
	b       ble_cont.17525
ble_else.17524:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $1, $1
ble_cont.17525:
	b       ble_cont.17523
ble_else.17522:
	mov     $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17523:
	b       ble_cont.17521
ble_else.17520:
	fneg    $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17521:
	store   $1, 2($sp)
	load    l.13295, $1
	load    1($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.17528
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17530
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17532
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17534
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17535
ble_else.17534:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $1, $1
ble_cont.17535:
	b       ble_cont.17533
ble_else.17532:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17533:
	b       ble_cont.17531
ble_else.17530:
	mov     $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17531:
	b       ble_cont.17529
ble_else.17528:
	fneg    $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $1, $1
ble_cont.17529:
	li      min_caml_light, $2
	load    2($sp), $3
	fmul    $3, $1, $1
	store   $1, 0($2)
	load    l.13295, $1
	load    1($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.17536
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17538
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17540
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17542
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17543
ble_else.17542:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17543:
	b       ble_cont.17541
ble_else.17540:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $1, $1
ble_cont.17541:
	b       ble_cont.17539
ble_else.17538:
	mov     $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17539:
	b       ble_cont.17537
ble_else.17536:
	fneg    $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17537:
	li      min_caml_light, $2
	load    2($sp), $3
	fmul    $3, $1, $1
	store   $1, 2($2)
	li      min_caml_beam, $1
	store   $1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_read_float
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $2
	store   $1, 0($2)
	ret
rotate_quadratic_matrix.3001:
	store   $1, 0($sp)
	store   $2, 1($sp)
	load    0($2), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17545
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17547
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17549
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17551
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.17552
ble_else.17551:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17552:
	b       ble_cont.17550
ble_else.17549:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $1, $1
ble_cont.17550:
	b       ble_cont.17548
ble_else.17547:
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17548:
	b       ble_cont.17546
ble_else.17545:
	fneg    $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.17546:
	store   $1, 2($sp)
	load    1($sp), $1
	load    0($1), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17553
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17555
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17557
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17559
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.17560
ble_else.17559:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $1, $1
ble_cont.17560:
	b       ble_cont.17558
ble_else.17557:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17558:
	b       ble_cont.17556
ble_else.17555:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.17556:
	b       ble_cont.17554
ble_else.17553:
	fneg    $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $1, $1
ble_cont.17554:
	store   $1, 3($sp)
	load    1($sp), $1
	load    1($1), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17561
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17563
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17565
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17567
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.17568
ble_else.17567:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17568:
	b       ble_cont.17566
ble_else.17565:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $1, $1
ble_cont.17566:
	b       ble_cont.17564
ble_else.17563:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17564:
	b       ble_cont.17562
ble_else.17561:
	fneg    $1, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17562:
	store   $1, 4($sp)
	load    1($sp), $1
	load    1($1), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17569
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17571
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17573
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17575
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.17576
ble_else.17575:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.17576:
	b       ble_cont.17574
ble_else.17573:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17574:
	b       ble_cont.17572
ble_else.17571:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17572:
	b       ble_cont.17570
ble_else.17569:
	fneg    $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.17570:
	store   $1, 5($sp)
	load    1($sp), $1
	load    2($1), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17577
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17579
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17581
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17583
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.17584
ble_else.17583:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17584:
	b       ble_cont.17582
ble_else.17581:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $1, $1
ble_cont.17582:
	b       ble_cont.17580
ble_else.17579:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17580:
	b       ble_cont.17578
ble_else.17577:
	fneg    $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.17578:
	store   $1, 6($sp)
	load    1($sp), $1
	load    2($1), $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17585
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17587
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17589
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17591
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.17592
ble_else.17591:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $1, $1
ble_cont.17592:
	b       ble_cont.17590
ble_else.17589:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17590:
	b       ble_cont.17588
ble_else.17587:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17588:
	b       ble_cont.17586
ble_else.17585:
	fneg    $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $1, $1
ble_cont.17586:
	load    6($sp), $2
	load    4($sp), $3
	fmul    $3, $2, $4
	load    5($sp), $5
	load    3($sp), $6
	fmul    $6, $5, $7
	fmul    $7, $2, $7
	load    2($sp), $8
	fmul    $8, $1, $9
	fsub    $7, $9, $7
	fmul    $8, $5, $9
	fmul    $9, $2, $9
	fmul    $6, $1, $10
	fadd    $9, $10, $9
	fmul    $3, $1, $10
	fmul    $6, $5, $11
	fmul    $11, $1, $11
	fmul    $8, $2, $12
	fadd    $11, $12, $11
	fmul    $8, $5, $12
	fmul    $12, $1, $1
	fmul    $6, $2, $2
	fsub    $1, $2, $1
	fneg    $5, $2
	fmul    $6, $3, $5
	fmul    $8, $3, $3
	load    0($sp), $6
	load    0($6), $8
	load    1($6), $12
	load    2($6), $13
	fmul    $4, $4, $14
	fmul    $8, $14, $14
	fmul    $10, $10, $15
	fmul    $12, $15, $15
	fadd    $14, $15, $14
	fmul    $2, $2, $15
	fmul    $13, $15, $15
	fadd    $14, $15, $14
	store   $14, 0($6)
	fmul    $7, $7, $14
	fmul    $8, $14, $14
	fmul    $11, $11, $15
	fmul    $12, $15, $15
	fadd    $14, $15, $14
	fmul    $5, $5, $15
	fmul    $13, $15, $15
	fadd    $14, $15, $14
	store   $14, 1($6)
	fmul    $9, $9, $14
	fmul    $8, $14, $14
	fmul    $1, $1, $15
	fmul    $12, $15, $15
	fadd    $14, $15, $14
	fmul    $3, $3, $15
	fmul    $13, $15, $15
	fadd    $14, $15, $14
	store   $14, 2($6)
	load    l.13300, $6
	fmul    $8, $7, $14
	fmul    $14, $9, $14
	fmul    $12, $11, $15
	fmul    $15, $1, $15
	fadd    $14, $15, $14
	fmul    $13, $5, $15
	fmul    $15, $3, $15
	fadd    $14, $15, $14
	fmul    $6, $14, $6
	load    1($sp), $14
	store   $6, 0($14)
	load    l.13300, $6
	fmul    $8, $4, $15
	fmul    $15, $9, $9
	fmul    $12, $10, $15
	fmul    $15, $1, $1
	fadd    $9, $1, $1
	fmul    $13, $2, $9
	fmul    $9, $3, $3
	fadd    $1, $3, $1
	fmul    $6, $1, $1
	store   $1, 1($14)
	load    l.13300, $1
	fmul    $8, $4, $3
	fmul    $3, $7, $3
	fmul    $12, $10, $4
	fmul    $4, $11, $4
	fadd    $3, $4, $3
	fmul    $13, $2, $2
	fmul    $2, $5, $2
	fadd    $3, $2, $2
	fmul    $1, $2, $1
	store   $1, 2($14)
	ret
read_nth_object.3004:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17594
	li      0, $1
	ret
be_else.17594:
	store   $1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_read_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $1, 4($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_float_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $2
	store   $1, 0($2)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $2
	store   $1, 1($2)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $2
	store   $1, 2($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	store   $1, 0($2)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	store   $1, 1($2)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	store   $1, 2($2)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17595
	li      0, $1
	b       ble_cont.17596
ble_else.17595:
	li      1, $1
ble_cont.17596:
	store   $1, 7($sp)
	li      2, $1
	load    l.13295, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $1, 8($sp)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_read_float
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $2
	store   $1, 0($2)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_read_float
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $2
	store   $1, 1($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_float_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	store   $1, 9($sp)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $2
	store   $1, 0($2)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $2
	store   $1, 1($2)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_read_float
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $2
	store   $1, 2($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_float_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $1, 10($sp)
	load    4($sp), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.17597
	b       be_cont.17598
be_else.17597:
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	load    10($sp), $2
	store   $1, 0($2)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	load    10($sp), $2
	store   $1, 1($2)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13303, $2
	fmul    $1, $2, $1
	load    10($sp), $2
	store   $1, 2($2)
be_cont.17598:
	load    2($sp), $1
	li      2, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17599
	li      1, $1
	b       be_cont.17600
be_else.17599:
	load    7($sp), $1
be_cont.17600:
	store   $1, 11($sp)
	li      4, $1
	load    l.13295, $2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_float_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	mov     $hp, $2
	add     $hp, 11, $hp
	store   $1, 10($2)
	load    10($sp), $1
	store   $1, 9($2)
	load    9($sp), $1
	store   $1, 8($2)
	load    8($sp), $1
	store   $1, 7($2)
	load    11($sp), $1
	store   $1, 6($2)
	load    6($sp), $1
	store   $1, 5($2)
	load    5($sp), $1
	store   $1, 4($2)
	load    4($sp), $3
	store   $3, 3($2)
	load    3($sp), $3
	store   $3, 2($2)
	load    2($sp), $3
	store   $3, 1($2)
	load    1($sp), $4
	store   $4, 0($2)
	li      min_caml_objects, $4
	load    0($sp), $5
	add     $4, $5, $28
	store   $2, 0($28)
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17601
	load    0($1), $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17603
	li      1, $3
	b       be_cont.17604
be_else.17603:
	li      0, $3
be_cont.17604:
	cmp     $3, $zero, $28
	bne     $28, be_else.17605
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17607
	li      1, $3
	b       be_cont.17608
be_else.17607:
	li      0, $3
be_cont.17608:
	cmp     $3, $zero, $28
	bne     $28, be_else.17609
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.17611
	li      0, $3
	b       ble_cont.17612
ble_else.17611:
	li      1, $3
ble_cont.17612:
	cmp     $3, $zero, $28
	bne     $28, be_else.17613
	load    l.13302, $3
	b       be_cont.17614
be_else.17613:
	load    l.13296, $3
be_cont.17614:
	b       be_cont.17610
be_else.17609:
	load    l.13295, $3
be_cont.17610:
	fmul    $2, $2, $2
	finv    $2, $28
	fmul    $3, $28, $2
	b       be_cont.17606
be_else.17605:
	load    l.13295, $2
be_cont.17606:
	store   $2, 0($1)
	load    1($1), $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17615
	li      1, $3
	b       be_cont.17616
be_else.17615:
	li      0, $3
be_cont.17616:
	cmp     $3, $zero, $28
	bne     $28, be_else.17617
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17619
	li      1, $3
	b       be_cont.17620
be_else.17619:
	li      0, $3
be_cont.17620:
	cmp     $3, $zero, $28
	bne     $28, be_else.17621
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.17623
	li      0, $3
	b       ble_cont.17624
ble_else.17623:
	li      1, $3
ble_cont.17624:
	cmp     $3, $zero, $28
	bne     $28, be_else.17625
	load    l.13302, $3
	b       be_cont.17626
be_else.17625:
	load    l.13296, $3
be_cont.17626:
	b       be_cont.17622
be_else.17621:
	load    l.13295, $3
be_cont.17622:
	fmul    $2, $2, $2
	finv    $2, $28
	fmul    $3, $28, $2
	b       be_cont.17618
be_else.17617:
	load    l.13295, $2
be_cont.17618:
	store   $2, 1($1)
	load    2($1), $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17627
	li      1, $3
	b       be_cont.17628
be_else.17627:
	li      0, $3
be_cont.17628:
	cmp     $3, $zero, $28
	bne     $28, be_else.17629
	load    l.13295, $3
	fcmp    $2, $3, $28
	bne     $28, be_else.17631
	li      1, $3
	b       be_cont.17632
be_else.17631:
	li      0, $3
be_cont.17632:
	cmp     $3, $zero, $28
	bne     $28, be_else.17633
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.17635
	li      0, $3
	b       ble_cont.17636
ble_else.17635:
	li      1, $3
ble_cont.17636:
	cmp     $3, $zero, $28
	bne     $28, be_else.17637
	load    l.13302, $3
	b       be_cont.17638
be_else.17637:
	load    l.13296, $3
be_cont.17638:
	b       be_cont.17634
be_else.17633:
	load    l.13295, $3
be_cont.17634:
	fmul    $2, $2, $2
	finv    $2, $28
	fmul    $3, $28, $2
	b       be_cont.17630
be_else.17629:
	load    l.13295, $2
be_cont.17630:
	store   $2, 2($1)
	b       be_cont.17602
be_else.17601:
	li      2, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17639
	load    7($sp), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.17641
	li      1, $2
	b       be_cont.17642
be_else.17641:
	li      0, $2
be_cont.17642:
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     vecunit_sgn.2896
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       be_cont.17640
be_else.17639:
be_cont.17640:
be_cont.17602:
	load    4($sp), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.17643
	b       be_cont.17644
be_else.17643:
	load    5($sp), $1
	load    10($sp), $2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     rotate_quadratic_matrix.3001
	sub     $sp, 13, $sp
	load    12($sp), $ra
be_cont.17644:
	li      1, $1
	ret
read_object.3006:
	li      60, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.17645
	ret
bge_else.17645:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     read_nth_object.3004
	sub     $sp, 2, $sp
	load    1($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17647
	li      min_caml_n_objects, $1
	load    0($sp), $2
	store   $2, 0($1)
	ret
be_else.17647:
	load    0($sp), $1
	add     $1, 1, $1
	li      60, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.17649
	ret
bge_else.17649:
	store   $1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     read_nth_object.3004
	sub     $sp, 3, $sp
	load    2($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17651
	li      min_caml_n_objects, $1
	load    1($sp), $2
	store   $2, 0($1)
	ret
be_else.17651:
	load    1($sp), $1
	add     $1, 1, $1
	li      60, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.17653
	ret
bge_else.17653:
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     read_nth_object.3004
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17655
	li      min_caml_n_objects, $1
	load    2($sp), $2
	store   $2, 0($1)
	ret
be_else.17655:
	load    2($sp), $1
	add     $1, 1, $1
	li      60, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.17657
	ret
bge_else.17657:
	store   $1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_nth_object.3004
	sub     $sp, 5, $sp
	load    4($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17659
	li      min_caml_n_objects, $1
	load    3($sp), $2
	store   $2, 0($1)
	ret
be_else.17659:
	load    3($sp), $1
	add     $1, 1, $1
	b       read_object.3006
read_net_item.3010:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17661
	load    0($sp), $1
	add     $1, 1, $1
	li      -1, $2
	b       min_caml_create_array
be_else.17661:
	store   $1, 1($sp)
	load    0($sp), $1
	add     $1, 1, $1
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17662
	load    2($sp), $1
	add     $1, 1, $1
	li      -1, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17663
be_else.17662:
	store   $1, 3($sp)
	load    2($sp), $1
	add     $1, 1, $1
	store   $1, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_read_int
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17664
	load    4($sp), $1
	add     $1, 1, $1
	li      -1, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17665
be_else.17664:
	store   $1, 5($sp)
	load    4($sp), $1
	add     $1, 1, $1
	store   $1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17666
	load    6($sp), $1
	add     $1, 1, $1
	li      -1, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.17667
be_else.17666:
	store   $1, 7($sp)
	load    6($sp), $1
	add     $1, 1, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     read_net_item.3010
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $2
	load    7($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
be_cont.17667:
	load    4($sp), $2
	load    5($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
be_cont.17665:
	load    2($sp), $2
	load    3($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
be_cont.17663:
	load    0($sp), $2
	load    1($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
	ret
read_or_network.3012:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17668
	li      1, $1
	li      -1, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.17669
be_else.17668:
	store   $1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17670
	li      2, $1
	li      -1, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.17671
be_else.17670:
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17672
	li      3, $1
	li      -1, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17673
be_else.17672:
	store   $1, 3($sp)
	li      3, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $2
	store   $2, 2($1)
be_cont.17673:
	load    2($sp), $2
	store   $2, 1($1)
be_cont.17671:
	load    1($sp), $2
	store   $2, 0($1)
be_cont.17669:
	mov     $1, $2
	load    0($2), $1
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17674
	load    0($sp), $1
	add     $1, 1, $1
	b       min_caml_create_array
be_else.17674:
	store   $2, 4($sp)
	load    0($sp), $1
	add     $1, 1, $1
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17675
	li      1, $1
	li      -1, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17676
be_else.17675:
	store   $1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17677
	li      2, $1
	li      -1, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.17678
be_else.17677:
	store   $1, 7($sp)
	li      2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     read_net_item.3010
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $2
	store   $2, 1($1)
be_cont.17678:
	load    6($sp), $2
	store   $2, 0($1)
be_cont.17676:
	mov     $1, $2
	load    0($2), $1
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17679
	load    5($sp), $1
	add     $1, 1, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.17680
be_else.17679:
	store   $2, 8($sp)
	load    5($sp), $1
	add     $1, 1, $1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     read_or_network.3012
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    5($sp), $2
	load    8($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
be_cont.17680:
	load    0($sp), $2
	load    4($sp), $3
	add     $1, $2, $28
	store   $3, 0($28)
	ret
read_and_network.3014:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_int
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17681
	li      1, $1
	li      -1, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.17682
be_else.17681:
	store   $1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17683
	li      2, $1
	li      -1, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.17684
be_else.17683:
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17685
	li      3, $1
	li      -1, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17686
be_else.17685:
	store   $1, 3($sp)
	li      3, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $2
	store   $2, 2($1)
be_cont.17686:
	load    2($sp), $2
	store   $2, 1($1)
be_cont.17684:
	load    1($sp), $2
	store   $2, 0($1)
be_cont.17682:
	load    0($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17687
	ret
be_else.17687:
	li      min_caml_and_net, $2
	load    0($sp), $3
	add     $2, $3, $28
	store   $1, 0($28)
	add     $3, 1, $1
	store   $1, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_read_int
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17689
	li      1, $1
	li      -1, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17690
be_else.17689:
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.17691
	li      2, $1
	li      -1, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17692
be_else.17691:
	store   $1, 6($sp)
	li      2, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     read_net_item.3010
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	store   $2, 1($1)
be_cont.17692:
	load    5($sp), $2
	store   $2, 0($1)
be_cont.17690:
	load    0($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17693
	ret
be_else.17693:
	li      min_caml_and_net, $2
	load    4($sp), $3
	add     $2, $3, $28
	store   $1, 0($28)
	add     $3, 1, $1
	b       read_and_network.3014
solver_rect_surface.3018:
	add     $2, $6, $28
	load    0($28), $9
	load    l.13295, $10
	fcmp    $9, $10, $28
	bne     $28, be_else.17695
	li      1, $9
	b       be_cont.17696
be_else.17695:
	li      0, $9
be_cont.17696:
	cmp     $9, $zero, $28
	bne     $28, be_else.17697
	load    4($1), $9
	load    6($1), $1
	add     $2, $6, $28
	load    0($28), $10
	load    l.13295, $11
	fcmp    $11, $10, $28
	bg      $28, ble_else.17698
	li      0, $10
	b       ble_cont.17699
ble_else.17698:
	li      1, $10
ble_cont.17699:
	cmp     $1, $zero, $28
	bne     $28, be_else.17700
	mov     $10, $1
	b       be_cont.17701
be_else.17700:
	cmp     $10, $zero, $28
	bne     $28, be_else.17702
	li      1, $1
	b       be_cont.17703
be_else.17702:
	li      0, $1
be_cont.17703:
be_cont.17701:
	add     $9, $6, $28
	load    0($28), $10
	cmp     $1, $zero, $28
	bne     $28, be_else.17704
	fneg    $10, $1
	b       be_cont.17705
be_else.17704:
	mov     $10, $1
be_cont.17705:
	fsub    $1, $3, $1
	add     $2, $6, $28
	load    0($28), $3
	finv    $3, $28
	fmul    $1, $28, $1
	add     $2, $7, $28
	load    0($28), $3
	fmul    $1, $3, $3
	fadd    $3, $4, $3
	load    l.13295, $4
	fcmp    $4, $3, $28
	bg      $28, ble_else.17706
	b       ble_cont.17707
ble_else.17706:
	fneg    $3, $3
ble_cont.17707:
	add     $9, $7, $28
	load    0($28), $4
	fcmp    $4, $3, $28
	bg      $28, ble_else.17708
	li      0, $3
	b       ble_cont.17709
ble_else.17708:
	li      1, $3
ble_cont.17709:
	cmp     $3, $zero, $28
	bne     $28, be_else.17710
	li      0, $1
	ret
be_else.17710:
	add     $2, $8, $28
	load    0($28), $2
	fmul    $1, $2, $2
	fadd    $2, $5, $2
	load    l.13295, $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17711
	b       ble_cont.17712
ble_else.17711:
	fneg    $2, $2
ble_cont.17712:
	add     $9, $8, $28
	load    0($28), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17713
	li      0, $2
	b       ble_cont.17714
ble_else.17713:
	li      1, $2
ble_cont.17714:
	cmp     $2, $zero, $28
	bne     $28, be_else.17715
	li      0, $1
	ret
be_else.17715:
	li      min_caml_solver_dist, $2
	store   $1, 0($2)
	li      1, $1
	ret
be_else.17697:
	li      0, $1
	ret
solver_surface.3033:
	load    4($1), $1
	load    0($2), $6
	load    0($1), $7
	fmul    $6, $7, $6
	load    1($2), $7
	load    1($1), $8
	fmul    $7, $8, $7
	fadd    $6, $7, $6
	load    2($2), $2
	load    2($1), $7
	fmul    $2, $7, $2
	fadd    $6, $2, $2
	load    l.13295, $6
	fcmp    $2, $6, $28
	bg      $28, ble_else.17716
	li      0, $6
	b       ble_cont.17717
ble_else.17716:
	li      1, $6
ble_cont.17717:
	cmp     $6, $zero, $28
	bne     $28, be_else.17718
	li      0, $1
	ret
be_else.17718:
	li      min_caml_solver_dist, $6
	load    0($1), $7
	fmul    $7, $3, $3
	load    1($1), $7
	fmul    $7, $4, $4
	fadd    $3, $4, $3
	load    2($1), $1
	fmul    $1, $5, $1
	fadd    $3, $1, $1
	fneg    $1, $1
	finv    $2, $28
	fmul    $1, $28, $1
	store   $1, 0($6)
	li      1, $1
	ret
quadratic.3039:
	fmul    $2, $2, $5
	load    4($1), $6
	load    0($6), $6
	fmul    $5, $6, $5
	fmul    $3, $3, $6
	load    4($1), $7
	load    1($7), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	fmul    $4, $4, $6
	load    4($1), $7
	load    2($7), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	load    3($1), $6
	cmp     $6, $zero, $28
	bne     $28, be_else.17719
	mov     $5, $1
	ret
be_else.17719:
	fmul    $3, $4, $6
	load    9($1), $7
	load    0($7), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	fmul    $4, $2, $4
	load    9($1), $6
	load    1($6), $6
	fmul    $4, $6, $4
	fadd    $5, $4, $4
	fmul    $2, $3, $2
	load    9($1), $1
	load    2($1), $1
	fmul    $2, $1, $1
	fadd    $4, $1, $1
	ret
bilinear.3044:
	fmul    $2, $5, $8
	load    4($1), $9
	load    0($9), $9
	fmul    $8, $9, $8
	fmul    $3, $6, $9
	load    4($1), $10
	load    1($10), $10
	fmul    $9, $10, $9
	fadd    $8, $9, $8
	fmul    $4, $7, $9
	load    4($1), $10
	load    2($10), $10
	fmul    $9, $10, $9
	fadd    $8, $9, $8
	load    3($1), $9
	cmp     $9, $zero, $28
	bne     $28, be_else.17720
	mov     $8, $1
	ret
be_else.17720:
	fmul    $4, $6, $9
	fmul    $3, $7, $10
	fadd    $9, $10, $9
	load    9($1), $10
	load    0($10), $10
	fmul    $9, $10, $9
	fmul    $2, $7, $7
	fmul    $4, $5, $4
	fadd    $7, $4, $4
	load    9($1), $7
	load    1($7), $7
	fmul    $4, $7, $4
	fadd    $9, $4, $4
	fmul    $2, $6, $2
	fmul    $3, $5, $3
	fadd    $2, $3, $2
	load    9($1), $1
	load    2($1), $1
	fmul    $2, $1, $1
	fadd    $4, $1, $1
	load    l.13293, $2
	fmul    $1, $2, $1
	fadd    $8, $1, $1
	ret
solver_second.3052:
	store   $5, 0($sp)
	store   $4, 1($sp)
	store   $3, 2($sp)
	store   $1, 3($sp)
	store   $2, 4($sp)
	load    0($2), $3
	load    1($2), $4
	load    2($2), $2
	mov     $4, $26
	mov     $2, $4
	mov     $3, $2
	mov     $26, $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     quadratic.3039
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13295, $2
	fcmp    $1, $2, $28
	bne     $28, be_else.17721
	li      1, $2
	b       be_cont.17722
be_else.17721:
	li      0, $2
be_cont.17722:
	cmp     $2, $zero, $28
	bne     $28, be_else.17723
	store   $1, 5($sp)
	load    4($sp), $1
	load    0($1), $2
	load    1($1), $3
	load    2($1), $4
	load    3($sp), $1
	load    2($sp), $5
	load    1($sp), $6
	load    0($sp), $7
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     bilinear.3044
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $1, 6($sp)
	load    3($sp), $1
	load    2($sp), $2
	load    1($sp), $3
	load    0($sp), $4
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     quadratic.3039
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    3($sp), $2
	load    1($2), $3
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17724
	load    l.13296, $3
	fsub    $1, $3, $1
	b       be_cont.17725
be_else.17724:
be_cont.17725:
	load    6($sp), $3
	fmul    $3, $3, $4
	load    5($sp), $5
	fmul    $5, $1, $1
	fsub    $4, $1, $1
	load    l.13295, $4
	fcmp    $1, $4, $28
	bg      $28, ble_else.17726
	li      0, $4
	b       ble_cont.17727
ble_else.17726:
	li      1, $4
ble_cont.17727:
	cmp     $4, $zero, $28
	bne     $28, be_else.17728
	li      0, $1
	ret
be_else.17728:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    3($sp), $2
	load    6($2), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.17729
	fneg    $1, $1
	b       be_cont.17730
be_else.17729:
be_cont.17730:
	li      min_caml_solver_dist, $2
	load    6($sp), $3
	fsub    $1, $3, $1
	load    5($sp), $3
	finv    $3, $28
	fmul    $1, $28, $1
	store   $1, 0($2)
	li      1, $1
	ret
be_else.17723:
	li      0, $1
	ret
solver_rect_fast.3062:
	load    0($3), $7
	fsub    $7, $4, $7
	load    1($3), $8
	fmul    $7, $8, $7
	load    1($2), $8
	fmul    $7, $8, $8
	fadd    $8, $5, $8
	load    l.13295, $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17731
	b       ble_cont.17732
ble_else.17731:
	fneg    $8, $8
ble_cont.17732:
	load    4($1), $9
	load    1($9), $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17733
	li      0, $8
	b       ble_cont.17734
ble_else.17733:
	li      1, $8
ble_cont.17734:
	cmp     $8, $zero, $28
	bne     $28, be_else.17735
	li      0, $8
	b       be_cont.17736
be_else.17735:
	load    2($2), $8
	fmul    $7, $8, $8
	fadd    $8, $6, $8
	load    l.13295, $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17737
	b       ble_cont.17738
ble_else.17737:
	fneg    $8, $8
ble_cont.17738:
	load    4($1), $9
	load    2($9), $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17739
	li      0, $8
	b       ble_cont.17740
ble_else.17739:
	li      1, $8
ble_cont.17740:
	cmp     $8, $zero, $28
	bne     $28, be_else.17741
	li      0, $8
	b       be_cont.17742
be_else.17741:
	load    1($3), $8
	load    l.13295, $9
	fcmp    $8, $9, $28
	bne     $28, be_else.17743
	li      1, $8
	b       be_cont.17744
be_else.17743:
	li      0, $8
be_cont.17744:
	cmp     $8, $zero, $28
	bne     $28, be_else.17745
	li      1, $8
	b       be_cont.17746
be_else.17745:
	li      0, $8
be_cont.17746:
be_cont.17742:
be_cont.17736:
	cmp     $8, $zero, $28
	bne     $28, be_else.17747
	load    2($3), $7
	fsub    $7, $5, $7
	load    3($3), $8
	fmul    $7, $8, $7
	load    0($2), $8
	fmul    $7, $8, $8
	fadd    $8, $4, $8
	load    l.13295, $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17748
	b       ble_cont.17749
ble_else.17748:
	fneg    $8, $8
ble_cont.17749:
	load    4($1), $9
	load    0($9), $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17750
	li      0, $8
	b       ble_cont.17751
ble_else.17750:
	li      1, $8
ble_cont.17751:
	cmp     $8, $zero, $28
	bne     $28, be_else.17752
	li      0, $8
	b       be_cont.17753
be_else.17752:
	load    2($2), $8
	fmul    $7, $8, $8
	fadd    $8, $6, $8
	load    l.13295, $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17754
	b       ble_cont.17755
ble_else.17754:
	fneg    $8, $8
ble_cont.17755:
	load    4($1), $9
	load    2($9), $9
	fcmp    $9, $8, $28
	bg      $28, ble_else.17756
	li      0, $8
	b       ble_cont.17757
ble_else.17756:
	li      1, $8
ble_cont.17757:
	cmp     $8, $zero, $28
	bne     $28, be_else.17758
	li      0, $8
	b       be_cont.17759
be_else.17758:
	load    3($3), $8
	load    l.13295, $9
	fcmp    $8, $9, $28
	bne     $28, be_else.17760
	li      1, $8
	b       be_cont.17761
be_else.17760:
	li      0, $8
be_cont.17761:
	cmp     $8, $zero, $28
	bne     $28, be_else.17762
	li      1, $8
	b       be_cont.17763
be_else.17762:
	li      0, $8
be_cont.17763:
be_cont.17759:
be_cont.17753:
	cmp     $8, $zero, $28
	bne     $28, be_else.17764
	load    4($3), $7
	fsub    $7, $6, $6
	load    5($3), $7
	fmul    $6, $7, $6
	load    0($2), $7
	fmul    $6, $7, $7
	fadd    $7, $4, $4
	load    l.13295, $7
	fcmp    $7, $4, $28
	bg      $28, ble_else.17765
	b       ble_cont.17766
ble_else.17765:
	fneg    $4, $4
ble_cont.17766:
	load    4($1), $7
	load    0($7), $7
	fcmp    $7, $4, $28
	bg      $28, ble_else.17767
	li      0, $4
	b       ble_cont.17768
ble_else.17767:
	li      1, $4
ble_cont.17768:
	cmp     $4, $zero, $28
	bne     $28, be_else.17769
	li      0, $1
	b       be_cont.17770
be_else.17769:
	load    1($2), $2
	fmul    $6, $2, $2
	fadd    $2, $5, $2
	load    l.13295, $4
	fcmp    $4, $2, $28
	bg      $28, ble_else.17771
	b       ble_cont.17772
ble_else.17771:
	fneg    $2, $2
ble_cont.17772:
	load    4($1), $1
	load    1($1), $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17773
	li      0, $1
	b       ble_cont.17774
ble_else.17773:
	li      1, $1
ble_cont.17774:
	cmp     $1, $zero, $28
	bne     $28, be_else.17775
	li      0, $1
	b       be_cont.17776
be_else.17775:
	load    5($3), $1
	load    l.13295, $2
	fcmp    $1, $2, $28
	bne     $28, be_else.17777
	li      1, $1
	b       be_cont.17778
be_else.17777:
	li      0, $1
be_cont.17778:
	cmp     $1, $zero, $28
	bne     $28, be_else.17779
	li      1, $1
	b       be_cont.17780
be_else.17779:
	li      0, $1
be_cont.17780:
be_cont.17776:
be_cont.17770:
	cmp     $1, $zero, $28
	bne     $28, be_else.17781
	li      0, $1
	ret
be_else.17781:
	li      min_caml_solver_dist, $1
	store   $6, 0($1)
	li      3, $1
	ret
be_else.17764:
	li      min_caml_solver_dist, $1
	store   $7, 0($1)
	li      2, $1
	ret
be_else.17747:
	li      min_caml_solver_dist, $1
	store   $7, 0($1)
	li      1, $1
	ret
solver_second_fast.3075:
	load    0($2), $6
	load    l.13295, $7
	fcmp    $6, $7, $28
	bne     $28, be_else.17782
	li      1, $7
	b       be_cont.17783
be_else.17782:
	li      0, $7
be_cont.17783:
	cmp     $7, $zero, $28
	bne     $28, be_else.17784
	store   $2, 0($sp)
	store   $6, 1($sp)
	store   $1, 2($sp)
	load    1($2), $6
	fmul    $6, $3, $6
	load    2($2), $7
	fmul    $7, $4, $7
	fadd    $6, $7, $6
	load    3($2), $2
	fmul    $2, $5, $2
	fadd    $6, $2, $2
	store   $2, 3($sp)
	mov     $3, $2
	mov     $4, $3
	mov     $5, $4
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     quadratic.3039
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    2($sp), $2
	load    1($2), $3
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17785
	load    l.13296, $3
	fsub    $1, $3, $1
	b       be_cont.17786
be_else.17785:
be_cont.17786:
	load    3($sp), $3
	fmul    $3, $3, $4
	load    1($sp), $5
	fmul    $5, $1, $1
	fsub    $4, $1, $1
	load    l.13295, $4
	fcmp    $1, $4, $28
	bg      $28, ble_else.17787
	li      0, $4
	b       ble_cont.17788
ble_else.17787:
	li      1, $4
ble_cont.17788:
	cmp     $4, $zero, $28
	bne     $28, be_else.17789
	li      0, $1
	ret
be_else.17789:
	load    6($2), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.17790
	li      min_caml_solver_dist, $2
	store   $2, 4($sp)
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sqrt.2865
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	fsub    $2, $1, $1
	load    0($sp), $2
	load    4($2), $2
	fmul    $1, $2, $1
	load    4($sp), $2
	store   $1, 0($2)
	b       be_cont.17791
be_else.17790:
	li      min_caml_solver_dist, $2
	store   $2, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     sqrt.2865
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    3($sp), $2
	fadd    $2, $1, $1
	load    0($sp), $2
	load    4($2), $2
	fmul    $1, $2, $1
	load    5($sp), $2
	store   $1, 0($2)
be_cont.17791:
	li      1, $1
	ret
be_else.17784:
	li      0, $1
	ret
solver_second_fast2.3092:
	load    0($2), $7
	load    l.13295, $8
	fcmp    $7, $8, $28
	bne     $28, be_else.17792
	li      1, $8
	b       be_cont.17793
be_else.17792:
	li      0, $8
be_cont.17793:
	cmp     $8, $zero, $28
	bne     $28, be_else.17794
	load    1($2), $8
	fmul    $8, $4, $4
	load    2($2), $8
	fmul    $8, $5, $5
	fadd    $4, $5, $4
	load    3($2), $5
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    3($3), $3
	fmul    $4, $4, $5
	fmul    $7, $3, $3
	fsub    $5, $3, $3
	load    l.13295, $5
	fcmp    $3, $5, $28
	bg      $28, ble_else.17795
	li      0, $5
	b       ble_cont.17796
ble_else.17795:
	li      1, $5
ble_cont.17796:
	cmp     $5, $zero, $28
	bne     $28, be_else.17797
	li      0, $1
	ret
be_else.17797:
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.17798
	store   $2, 0($sp)
	store   $4, 1($sp)
	li      min_caml_solver_dist, $1
	store   $1, 2($sp)
	mov     $3, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sqrt.2865
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $2
	fsub    $2, $1, $1
	load    0($sp), $2
	load    4($2), $2
	fmul    $1, $2, $1
	load    2($sp), $2
	store   $1, 0($2)
	b       be_cont.17799
be_else.17798:
	store   $2, 0($sp)
	store   $4, 1($sp)
	li      min_caml_solver_dist, $1
	store   $1, 3($sp)
	mov     $3, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     sqrt.2865
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    1($sp), $2
	fadd    $2, $1, $1
	load    0($sp), $2
	load    4($2), $2
	fmul    $1, $2, $1
	load    3($sp), $2
	store   $1, 0($2)
be_cont.17799:
	li      1, $1
	ret
be_else.17794:
	li      0, $1
	ret
setup_rect_table.3102:
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      6, $1
	load    l.13295, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $2
	load    0($2), $3
	load    l.13295, $4
	fcmp    $3, $4, $28
	bne     $28, be_else.17800
	li      1, $3
	b       be_cont.17801
be_else.17800:
	li      0, $3
be_cont.17801:
	cmp     $3, $zero, $28
	bne     $28, be_else.17802
	load    0($sp), $3
	load    6($3), $4
	load    0($2), $5
	load    l.13295, $6
	fcmp    $6, $5, $28
	bg      $28, ble_else.17804
	li      0, $5
	b       ble_cont.17805
ble_else.17804:
	li      1, $5
ble_cont.17805:
	cmp     $4, $zero, $28
	bne     $28, be_else.17806
	mov     $5, $4
	b       be_cont.17807
be_else.17806:
	cmp     $5, $zero, $28
	bne     $28, be_else.17808
	li      1, $4
	b       be_cont.17809
be_else.17808:
	li      0, $4
be_cont.17809:
be_cont.17807:
	load    4($3), $3
	load    0($3), $3
	cmp     $4, $zero, $28
	bne     $28, be_else.17810
	fneg    $3, $3
	b       be_cont.17811
be_else.17810:
be_cont.17811:
	store   $3, 0($1)
	load    l.13296, $3
	load    0($2), $4
	finv    $4, $28
	fmul    $3, $28, $3
	store   $3, 1($1)
	b       be_cont.17803
be_else.17802:
	load    l.13295, $3
	store   $3, 1($1)
be_cont.17803:
	load    1($2), $3
	load    l.13295, $4
	fcmp    $3, $4, $28
	bne     $28, be_else.17812
	li      1, $3
	b       be_cont.17813
be_else.17812:
	li      0, $3
be_cont.17813:
	cmp     $3, $zero, $28
	bne     $28, be_else.17814
	load    0($sp), $3
	load    6($3), $4
	load    1($2), $5
	load    l.13295, $6
	fcmp    $6, $5, $28
	bg      $28, ble_else.17816
	li      0, $5
	b       ble_cont.17817
ble_else.17816:
	li      1, $5
ble_cont.17817:
	cmp     $4, $zero, $28
	bne     $28, be_else.17818
	mov     $5, $4
	b       be_cont.17819
be_else.17818:
	cmp     $5, $zero, $28
	bne     $28, be_else.17820
	li      1, $4
	b       be_cont.17821
be_else.17820:
	li      0, $4
be_cont.17821:
be_cont.17819:
	load    4($3), $3
	load    1($3), $3
	cmp     $4, $zero, $28
	bne     $28, be_else.17822
	fneg    $3, $3
	b       be_cont.17823
be_else.17822:
be_cont.17823:
	store   $3, 2($1)
	load    l.13296, $3
	load    1($2), $4
	finv    $4, $28
	fmul    $3, $28, $3
	store   $3, 3($1)
	b       be_cont.17815
be_else.17814:
	load    l.13295, $3
	store   $3, 3($1)
be_cont.17815:
	load    2($2), $3
	load    l.13295, $4
	fcmp    $3, $4, $28
	bne     $28, be_else.17824
	li      1, $3
	b       be_cont.17825
be_else.17824:
	li      0, $3
be_cont.17825:
	cmp     $3, $zero, $28
	bne     $28, be_else.17826
	load    0($sp), $3
	load    6($3), $4
	load    2($2), $5
	load    l.13295, $6
	fcmp    $6, $5, $28
	bg      $28, ble_else.17828
	li      0, $5
	b       ble_cont.17829
ble_else.17828:
	li      1, $5
ble_cont.17829:
	cmp     $4, $zero, $28
	bne     $28, be_else.17830
	mov     $5, $4
	b       be_cont.17831
be_else.17830:
	cmp     $5, $zero, $28
	bne     $28, be_else.17832
	li      1, $4
	b       be_cont.17833
be_else.17832:
	li      0, $4
be_cont.17833:
be_cont.17831:
	load    4($3), $3
	load    2($3), $3
	cmp     $4, $zero, $28
	bne     $28, be_else.17834
	fneg    $3, $3
	b       be_cont.17835
be_else.17834:
be_cont.17835:
	store   $3, 4($1)
	load    l.13296, $3
	load    2($2), $2
	finv    $2, $28
	fmul    $3, $28, $2
	store   $2, 5($1)
	b       be_cont.17827
be_else.17826:
	load    l.13295, $2
	store   $2, 5($1)
be_cont.17827:
	ret
setup_surface_table.3105:
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      4, $1
	load    l.13295, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $2
	load    0($2), $3
	load    0($sp), $4
	load    4($4), $5
	load    0($5), $5
	fmul    $3, $5, $3
	load    1($2), $5
	load    4($4), $6
	load    1($6), $6
	fmul    $5, $6, $5
	fadd    $3, $5, $3
	load    2($2), $2
	load    4($4), $5
	load    2($5), $5
	fmul    $2, $5, $2
	fadd    $3, $2, $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.17836
	li      0, $3
	b       ble_cont.17837
ble_else.17836:
	li      1, $3
ble_cont.17837:
	cmp     $3, $zero, $28
	bne     $28, be_else.17838
	load    l.13295, $2
	store   $2, 0($1)
	b       be_cont.17839
be_else.17838:
	load    l.13302, $3
	finv    $2, $28
	fmul    $3, $28, $3
	store   $3, 0($1)
	load    4($4), $3
	load    0($3), $3
	finv    $2, $28
	fmul    $3, $28, $3
	fneg    $3, $3
	store   $3, 1($1)
	load    4($4), $3
	load    1($3), $3
	finv    $2, $28
	fmul    $3, $28, $3
	fneg    $3, $3
	store   $3, 2($1)
	load    4($4), $3
	load    2($3), $3
	finv    $2, $28
	fmul    $3, $28, $2
	fneg    $2, $2
	store   $2, 3($1)
be_cont.17839:
	ret
setup_second_table.3108:
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      5, $1
	load    l.13295, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $1, 2($sp)
	load    1($sp), $1
	load    0($1), $2
	load    1($1), $3
	load    2($1), $4
	load    0($sp), $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     quadratic.3039
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $2
	load    0($2), $3
	load    0($sp), $4
	load    4($4), $5
	load    0($5), $5
	fmul    $3, $5, $3
	fneg    $3, $3
	load    1($2), $5
	load    4($4), $6
	load    1($6), $6
	fmul    $5, $6, $5
	fneg    $5, $5
	load    2($2), $6
	load    4($4), $7
	load    2($7), $7
	fmul    $6, $7, $6
	fneg    $6, $6
	load    2($sp), $7
	store   $1, 0($7)
	load    3($4), $8
	cmp     $8, $zero, $28
	bne     $28, be_else.17840
	store   $3, 1($7)
	store   $5, 2($7)
	store   $6, 3($7)
	b       be_cont.17841
be_else.17840:
	load    2($2), $8
	load    9($4), $9
	load    1($9), $9
	fmul    $8, $9, $8
	load    1($2), $9
	load    9($4), $10
	load    2($10), $10
	fmul    $9, $10, $9
	fadd    $8, $9, $8
	load    l.13293, $9
	fmul    $8, $9, $8
	fsub    $3, $8, $3
	store   $3, 1($7)
	load    2($2), $3
	load    9($4), $8
	load    0($8), $8
	fmul    $3, $8, $3
	load    0($2), $8
	load    9($4), $9
	load    2($9), $9
	fmul    $8, $9, $8
	fadd    $3, $8, $3
	load    l.13293, $8
	fmul    $3, $8, $3
	fsub    $5, $3, $3
	store   $3, 2($7)
	load    1($2), $3
	load    9($4), $5
	load    0($5), $5
	fmul    $3, $5, $3
	load    0($2), $2
	load    9($4), $4
	load    1($4), $4
	fmul    $2, $4, $2
	fadd    $3, $2, $2
	load    l.13293, $3
	fmul    $2, $3, $2
	fsub    $6, $2, $2
	store   $2, 3($7)
be_cont.17841:
	load    l.13295, $2
	fcmp    $1, $2, $28
	bne     $28, be_else.17842
	li      1, $2
	b       be_cont.17843
be_else.17842:
	li      0, $2
be_cont.17843:
	cmp     $2, $zero, $28
	bne     $28, be_else.17844
	load    l.13296, $2
	finv    $1, $28
	fmul    $2, $28, $1
	store   $1, 4($7)
	b       be_cont.17845
be_else.17844:
be_cont.17845:
	mov     $7, $1
	ret
iter_setup_dirvec_constants.3111:
	cmp     $2, $zero, $28
	bl      $28, bge_else.17846
	store   $1, 0($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17847
	store   $2, 1($sp)
	store   $4, 2($sp)
	mov     $3, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_rect_table.3102
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $2
	load    2($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.17848
be_else.17847:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17849
	store   $2, 1($sp)
	store   $4, 2($sp)
	mov     $3, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_surface_table.3105
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $2
	load    2($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.17850
be_else.17849:
	store   $2, 1($sp)
	store   $4, 2($sp)
	mov     $3, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     setup_second_table.3108
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    1($sp), $2
	load    2($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.17850:
be_cont.17848:
	sub     $2, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.17851
	li      min_caml_objects, $2
	add     $2, $1, $28
	load    0($28), $2
	load    0($sp), $3
	load    1($3), $4
	load    0($3), $3
	load    1($2), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17852
	store   $1, 3($sp)
	store   $4, 4($sp)
	mov     $3, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_rect_table.3102
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.17853
be_else.17852:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17854
	store   $1, 3($sp)
	store   $4, 4($sp)
	mov     $3, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_surface_table.3105
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.17855
be_else.17854:
	store   $1, 3($sp)
	store   $4, 4($sp)
	mov     $3, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_second_table.3108
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.17855:
be_cont.17853:
	sub     $2, 1, $2
	load    0($sp), $1
	b       iter_setup_dirvec_constants.3111
bge_else.17851:
	ret
bge_else.17846:
	ret
setup_startp_constants.3116:
	cmp     $2, $zero, $28
	bl      $28, bge_else.17858
	store   $1, 0($sp)
	store   $2, 1($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $2
	load    10($2), $3
	load    1($2), $4
	load    0($1), $5
	load    5($2), $6
	load    0($6), $6
	fsub    $5, $6, $5
	store   $5, 0($3)
	load    1($1), $5
	load    5($2), $6
	load    1($6), $6
	fsub    $5, $6, $5
	store   $5, 1($3)
	load    2($1), $1
	load    5($2), $5
	load    2($5), $5
	fsub    $1, $5, $1
	store   $1, 2($3)
	li      2, $28
	cmp     $4, $28, $28
	bne     $28, be_else.17859
	load    4($2), $1
	load    0($3), $2
	load    1($3), $4
	load    2($3), $5
	load    0($1), $6
	fmul    $6, $2, $2
	load    1($1), $6
	fmul    $6, $4, $4
	fadd    $2, $4, $2
	load    2($1), $1
	fmul    $1, $5, $1
	fadd    $2, $1, $1
	store   $1, 3($3)
	b       be_cont.17860
be_else.17859:
	li      2, $28
	cmp     $4, $28, $28
	bg      $28, ble_else.17861
	b       ble_cont.17862
ble_else.17861:
	store   $3, 2($sp)
	store   $4, 3($sp)
	load    0($3), $1
	load    1($3), $4
	load    2($3), $3
	mov     $4, $26
	mov     $3, $4
	mov     $26, $3
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     quadratic.3039
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $2
	li      3, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17863
	load    l.13296, $2
	fsub    $1, $2, $1
	b       be_cont.17864
be_else.17863:
be_cont.17864:
	load    2($sp), $2
	store   $1, 3($2)
ble_cont.17862:
be_cont.17860:
	load    1($sp), $1
	sub     $1, 1, $2
	load    0($sp), $1
	b       setup_startp_constants.3116
bge_else.17858:
	ret
is_rect_outside.3121:
	load    l.13295, $5
	fcmp    $5, $2, $28
	bg      $28, ble_else.17866
	b       ble_cont.17867
ble_else.17866:
	fneg    $2, $2
ble_cont.17867:
	load    4($1), $5
	load    0($5), $5
	fcmp    $5, $2, $28
	bg      $28, ble_else.17868
	li      0, $2
	b       ble_cont.17869
ble_else.17868:
	li      1, $2
ble_cont.17869:
	cmp     $2, $zero, $28
	bne     $28, be_else.17870
	li      0, $2
	b       be_cont.17871
be_else.17870:
	load    l.13295, $2
	fcmp    $2, $3, $28
	bg      $28, ble_else.17872
	mov     $3, $2
	b       ble_cont.17873
ble_else.17872:
	fneg    $3, $2
ble_cont.17873:
	load    4($1), $3
	load    1($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17874
	li      0, $2
	b       ble_cont.17875
ble_else.17874:
	li      1, $2
ble_cont.17875:
	cmp     $2, $zero, $28
	bne     $28, be_else.17876
	li      0, $2
	b       be_cont.17877
be_else.17876:
	load    l.13295, $2
	fcmp    $2, $4, $28
	bg      $28, ble_else.17878
	mov     $4, $2
	b       ble_cont.17879
ble_else.17878:
	fneg    $4, $2
ble_cont.17879:
	load    4($1), $3
	load    2($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17880
	li      0, $2
	b       ble_cont.17881
ble_else.17880:
	li      1, $2
ble_cont.17881:
be_cont.17877:
be_cont.17871:
	cmp     $2, $zero, $28
	bne     $28, be_else.17882
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.17883
	li      1, $1
	ret
be_else.17883:
	li      0, $1
	ret
be_else.17882:
	load    6($1), $1
	ret
is_outside.3136:
	load    5($1), $5
	load    0($5), $5
	fsub    $2, $5, $2
	load    5($1), $5
	load    1($5), $5
	fsub    $3, $5, $3
	load    5($1), $5
	load    2($5), $5
	fsub    $4, $5, $4
	load    1($1), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17884
	load    l.13295, $5
	fcmp    $5, $2, $28
	bg      $28, ble_else.17885
	b       ble_cont.17886
ble_else.17885:
	fneg    $2, $2
ble_cont.17886:
	load    4($1), $5
	load    0($5), $5
	fcmp    $5, $2, $28
	bg      $28, ble_else.17887
	li      0, $2
	b       ble_cont.17888
ble_else.17887:
	li      1, $2
ble_cont.17888:
	cmp     $2, $zero, $28
	bne     $28, be_else.17889
	li      0, $2
	b       be_cont.17890
be_else.17889:
	load    l.13295, $2
	fcmp    $2, $3, $28
	bg      $28, ble_else.17891
	mov     $3, $2
	b       ble_cont.17892
ble_else.17891:
	fneg    $3, $2
ble_cont.17892:
	load    4($1), $3
	load    1($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17893
	li      0, $2
	b       ble_cont.17894
ble_else.17893:
	li      1, $2
ble_cont.17894:
	cmp     $2, $zero, $28
	bne     $28, be_else.17895
	li      0, $2
	b       be_cont.17896
be_else.17895:
	load    l.13295, $2
	fcmp    $2, $4, $28
	bg      $28, ble_else.17897
	mov     $4, $2
	b       ble_cont.17898
ble_else.17897:
	fneg    $4, $2
ble_cont.17898:
	load    4($1), $3
	load    2($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17899
	li      0, $2
	b       ble_cont.17900
ble_else.17899:
	li      1, $2
ble_cont.17900:
be_cont.17896:
be_cont.17890:
	cmp     $2, $zero, $28
	bne     $28, be_else.17901
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.17902
	li      1, $1
	ret
be_else.17902:
	li      0, $1
	ret
be_else.17901:
	load    6($1), $1
	ret
be_else.17884:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17903
	load    4($1), $5
	load    0($5), $6
	fmul    $6, $2, $2
	load    1($5), $6
	fmul    $6, $3, $3
	fadd    $2, $3, $2
	load    2($5), $3
	fmul    $3, $4, $3
	fadd    $2, $3, $2
	load    6($1), $1
	load    l.13295, $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17904
	li      0, $2
	b       ble_cont.17905
ble_else.17904:
	li      1, $2
ble_cont.17905:
	cmp     $1, $zero, $28
	bne     $28, be_else.17906
	mov     $2, $1
	b       be_cont.17907
be_else.17906:
	cmp     $2, $zero, $28
	bne     $28, be_else.17908
	li      1, $1
	b       be_cont.17909
be_else.17908:
	li      0, $1
be_cont.17909:
be_cont.17907:
	cmp     $1, $zero, $28
	bne     $28, be_else.17910
	li      1, $1
	ret
be_else.17910:
	li      0, $1
	ret
be_else.17903:
	store   $1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     quadratic.3039
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	load    1($2), $3
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17911
	load    l.13296, $3
	fsub    $1, $3, $1
	b       be_cont.17912
be_else.17911:
be_cont.17912:
	load    6($2), $2
	load    l.13295, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17913
	li      0, $1
	b       ble_cont.17914
ble_else.17913:
	li      1, $1
ble_cont.17914:
	cmp     $2, $zero, $28
	bne     $28, be_else.17915
	b       be_cont.17916
be_else.17915:
	cmp     $1, $zero, $28
	bne     $28, be_else.17917
	li      1, $1
	b       be_cont.17918
be_else.17917:
	li      0, $1
be_cont.17918:
be_cont.17916:
	cmp     $1, $zero, $28
	bne     $28, be_else.17919
	li      1, $1
	ret
be_else.17919:
	li      0, $1
	ret
check_all_inside.3141:
	add     $2, $1, $28
	load    0($28), $6
	li      -1, $28
	cmp     $6, $28, $28
	bne     $28, be_else.17920
	li      1, $1
	ret
be_else.17920:
	store   $5, 0($sp)
	store   $4, 1($sp)
	store   $3, 2($sp)
	store   $2, 3($sp)
	store   $1, 4($sp)
	li      min_caml_objects, $1
	add     $1, $6, $28
	load    0($28), $1
	load    5($1), $2
	load    0($2), $2
	fsub    $3, $2, $2
	load    5($1), $3
	load    1($3), $3
	fsub    $4, $3, $3
	load    5($1), $4
	load    2($4), $4
	fsub    $5, $4, $4
	load    1($1), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17921
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     is_rect_outside.3121
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.17922
be_else.17921:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17923
	load    4($1), $5
	load    0($5), $6
	fmul    $6, $2, $2
	load    1($5), $6
	fmul    $6, $3, $3
	fadd    $2, $3, $2
	load    2($5), $3
	fmul    $3, $4, $3
	fadd    $2, $3, $2
	load    6($1), $1
	load    l.13295, $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.17925
	li      0, $2
	b       ble_cont.17926
ble_else.17925:
	li      1, $2
ble_cont.17926:
	cmp     $1, $zero, $28
	bne     $28, be_else.17927
	mov     $2, $1
	b       be_cont.17928
be_else.17927:
	cmp     $2, $zero, $28
	bne     $28, be_else.17929
	li      1, $1
	b       be_cont.17930
be_else.17929:
	li      0, $1
be_cont.17930:
be_cont.17928:
	cmp     $1, $zero, $28
	bne     $28, be_else.17931
	li      1, $1
	b       be_cont.17932
be_else.17931:
	li      0, $1
be_cont.17932:
	b       be_cont.17924
be_else.17923:
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     quadratic.3039
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $2
	load    1($2), $3
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17933
	load    l.13296, $3
	fsub    $1, $3, $1
	b       be_cont.17934
be_else.17933:
be_cont.17934:
	load    6($2), $2
	load    l.13295, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17935
	li      0, $1
	b       ble_cont.17936
ble_else.17935:
	li      1, $1
ble_cont.17936:
	cmp     $2, $zero, $28
	bne     $28, be_else.17937
	b       be_cont.17938
be_else.17937:
	cmp     $1, $zero, $28
	bne     $28, be_else.17939
	li      1, $1
	b       be_cont.17940
be_else.17939:
	li      0, $1
be_cont.17940:
be_cont.17938:
	cmp     $1, $zero, $28
	bne     $28, be_else.17941
	li      1, $1
	b       be_cont.17942
be_else.17941:
	li      0, $1
be_cont.17942:
be_cont.17924:
be_cont.17922:
	cmp     $1, $zero, $28
	bne     $28, be_else.17943
	load    4($sp), $1
	add     $1, 1, $1
	load    3($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17944
	li      1, $1
	ret
be_else.17944:
	store   $1, 6($sp)
	li      min_caml_objects, $1
	add     $1, $3, $28
	load    0($28), $1
	load    2($sp), $2
	load    1($sp), $3
	load    0($sp), $4
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     is_outside.3136
	sub     $sp, 8, $sp
	load    7($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17945
	load    6($sp), $1
	add     $1, 1, $1
	load    3($sp), $2
	load    2($sp), $3
	load    1($sp), $4
	load    0($sp), $5
	b       check_all_inside.3141
be_else.17945:
	li      0, $1
	ret
be_else.17943:
	li      0, $1
	ret
shadow_check_and_group.3147:
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17946
	li      0, $1
	ret
be_else.17946:
	store   $2, 0($sp)
	store   $1, 1($sp)
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 2($sp)
	li      min_caml_light_dirvec, $2
	li      min_caml_intersection_point, $3
	li      min_caml_objects, $4
	add     $4, $1, $28
	load    0($28), $4
	load    0($3), $5
	load    5($4), $6
	load    0($6), $6
	fsub    $5, $6, $5
	load    1($3), $6
	load    5($4), $7
	load    1($7), $7
	fsub    $6, $7, $6
	load    2($3), $3
	load    5($4), $7
	load    2($7), $7
	fsub    $3, $7, $3
	load    1($2), $7
	add     $7, $1, $28
	load    0($28), $1
	load    1($4), $7
	li      1, $28
	cmp     $7, $28, $28
	bne     $28, be_else.17947
	load    0($2), $2
	mov     $6, $26
	mov     $3, $6
	mov     $1, $3
	mov     $4, $1
	mov     $5, $4
	mov     $26, $5
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17948
be_else.17947:
	li      2, $28
	cmp     $7, $28, $28
	bne     $28, be_else.17949
	load    0($1), $2
	load    l.13295, $4
	fcmp    $4, $2, $28
	bg      $28, ble_else.17951
	li      0, $2
	b       ble_cont.17952
ble_else.17951:
	li      1, $2
ble_cont.17952:
	cmp     $2, $zero, $28
	bne     $28, be_else.17953
	li      0, $1
	b       be_cont.17954
be_else.17953:
	li      min_caml_solver_dist, $2
	load    1($1), $4
	fmul    $4, $5, $4
	load    2($1), $5
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    3($1), $1
	fmul    $1, $3, $1
	fadd    $4, $1, $1
	store   $1, 0($2)
	li      1, $1
be_cont.17954:
	b       be_cont.17950
be_else.17949:
	mov     $1, $2
	mov     $4, $1
	mov     $6, $4
	mov     $5, $26
	mov     $3, $5
	mov     $26, $3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.17950:
be_cont.17948:
	li      min_caml_solver_dist, $2
	load    0($2), $2
	cmp     $1, $zero, $28
	bne     $28, be_else.17955
	li      0, $1
	b       be_cont.17956
be_else.17955:
	load    l.13318, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.17957
	li      0, $1
	b       ble_cont.17958
ble_else.17957:
	li      1, $1
ble_cont.17958:
be_cont.17956:
	cmp     $1, $zero, $28
	bne     $28, be_else.17959
	li      min_caml_objects, $1
	load    2($sp), $2
	add     $1, $2, $28
	load    0($28), $1
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.17960
	li      0, $1
	ret
be_else.17960:
	load    1($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	b       shadow_check_and_group.3147
be_else.17959:
	load    l.13319, $1
	fadd    $2, $1, $1
	li      min_caml_light, $2
	load    0($2), $2
	fmul    $2, $1, $2
	li      min_caml_intersection_point, $3
	load    0($3), $3
	fadd    $2, $3, $2
	li      min_caml_light, $3
	load    1($3), $3
	fmul    $3, $1, $3
	li      min_caml_intersection_point, $4
	load    1($4), $4
	fadd    $3, $4, $3
	li      min_caml_light, $4
	load    2($4), $4
	fmul    $4, $1, $1
	li      min_caml_intersection_point, $4
	load    2($4), $4
	fadd    $1, $4, $4
	load    0($sp), $1
	load    0($1), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.17961
	li      1, $1
	b       be_cont.17962
be_else.17961:
	store   $4, 3($sp)
	store   $3, 4($sp)
	store   $2, 5($sp)
	li      min_caml_objects, $1
	add     $1, $5, $28
	load    0($28), $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     is_outside.3136
	sub     $sp, 7, $sp
	load    6($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17963
	li      1, $1
	load    0($sp), $2
	load    5($sp), $3
	load    4($sp), $4
	load    3($sp), $5
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     check_all_inside.3141
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.17964
be_else.17963:
	li      0, $1
be_cont.17964:
be_cont.17962:
	cmp     $1, $zero, $28
	bne     $28, be_else.17965
	load    1($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	b       shadow_check_and_group.3147
be_else.17965:
	li      1, $1
	ret
shadow_check_one_or_group.3150:
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17966
	li      0, $1
	ret
be_else.17966:
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 3, $sp
	load    2($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17967
	load    1($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17968
	li      0, $1
	ret
be_else.17968:
	store   $1, 2($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17969
	load    2($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17970
	li      0, $1
	ret
be_else.17970:
	store   $1, 3($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 5, $sp
	load    4($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17971
	load    3($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.17972
	li      0, $1
	ret
be_else.17972:
	store   $1, 4($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 6, $sp
	load    5($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17973
	load    4($sp), $1
	add     $1, 1, $1
	load    0($sp), $2
	b       shadow_check_one_or_group.3150
be_else.17973:
	li      1, $1
	ret
be_else.17971:
	li      1, $1
	ret
be_else.17969:
	li      1, $1
	ret
be_else.17967:
	li      1, $1
	ret
shadow_check_one_or_matrix.3153:
	add     $2, $1, $28
	load    0($28), $3
	load    0($3), $4
	li      -1, $28
	cmp     $4, $28, $28
	bne     $28, be_else.17974
	li      0, $1
	ret
be_else.17974:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	li      99, $28
	cmp     $4, $28, $28
	bne     $28, be_else.17975
	li      1, $1
	b       be_cont.17976
be_else.17975:
	li      min_caml_light_dirvec, $1
	li      min_caml_intersection_point, $2
	li      min_caml_objects, $3
	add     $3, $4, $28
	load    0($28), $3
	load    0($2), $5
	load    5($3), $6
	load    0($6), $6
	fsub    $5, $6, $5
	load    1($2), $6
	load    5($3), $7
	load    1($7), $7
	fsub    $6, $7, $6
	load    2($2), $2
	load    5($3), $7
	load    2($7), $7
	fsub    $2, $7, $2
	load    1($1), $7
	add     $7, $4, $28
	load    0($28), $4
	load    1($3), $7
	li      1, $28
	cmp     $7, $28, $28
	bne     $28, be_else.17977
	load    0($1), $1
	mov     $6, $26
	mov     $2, $6
	mov     $1, $2
	mov     $3, $1
	mov     $4, $3
	mov     $5, $4
	mov     $26, $5
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.17978
be_else.17977:
	li      2, $28
	cmp     $7, $28, $28
	bne     $28, be_else.17979
	load    0($4), $1
	load    l.13295, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.17981
	li      0, $1
	b       ble_cont.17982
ble_else.17981:
	li      1, $1
ble_cont.17982:
	cmp     $1, $zero, $28
	bne     $28, be_else.17983
	li      0, $1
	b       be_cont.17984
be_else.17983:
	li      min_caml_solver_dist, $1
	load    1($4), $3
	fmul    $3, $5, $3
	load    2($4), $5
	fmul    $5, $6, $5
	fadd    $3, $5, $3
	load    3($4), $4
	fmul    $4, $2, $2
	fadd    $3, $2, $2
	store   $2, 0($1)
	li      1, $1
be_cont.17984:
	b       be_cont.17980
be_else.17979:
	mov     $3, $1
	mov     $5, $3
	mov     $2, $5
	mov     $4, $2
	mov     $6, $4
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.17980:
be_cont.17978:
	cmp     $1, $zero, $28
	bne     $28, be_else.17985
	li      0, $1
	b       be_cont.17986
be_else.17985:
	li      min_caml_solver_dist, $1
	load    0($1), $1
	load    l.13320, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.17987
	li      0, $1
	b       ble_cont.17988
ble_else.17987:
	li      1, $1
ble_cont.17988:
	cmp     $1, $zero, $28
	bne     $28, be_else.17989
	li      0, $1
	b       be_cont.17990
be_else.17989:
	load    0($sp), $1
	load    1($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17991
	li      0, $1
	b       be_cont.17992
be_else.17991:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17993
	load    0($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17995
	li      0, $1
	b       be_cont.17996
be_else.17995:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.17997
	load    0($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.17999
	li      0, $1
	b       be_cont.18000
be_else.17999:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18001
	li      4, $1
	load    0($sp), $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18002
be_else.18001:
	li      1, $1
be_cont.18002:
be_cont.18000:
	b       be_cont.17998
be_else.17997:
	li      1, $1
be_cont.17998:
be_cont.17996:
	b       be_cont.17994
be_else.17993:
	li      1, $1
be_cont.17994:
be_cont.17992:
	cmp     $1, $zero, $28
	bne     $28, be_else.18003
	li      0, $1
	b       be_cont.18004
be_else.18003:
	li      1, $1
be_cont.18004:
be_cont.17990:
be_cont.17986:
be_cont.17976:
	cmp     $1, $zero, $28
	bne     $28, be_else.18005
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	b       shadow_check_one_or_matrix.3153
be_else.18005:
	load    0($sp), $1
	load    1($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18006
	li      0, $1
	b       be_cont.18007
be_else.18006:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18008
	load    0($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18010
	li      0, $1
	b       be_cont.18011
be_else.18010:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18012
	load    0($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18014
	li      0, $1
	b       be_cont.18015
be_else.18014:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18016
	li      4, $1
	load    0($sp), $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18017
be_else.18016:
	li      1, $1
be_cont.18017:
be_cont.18015:
	b       be_cont.18013
be_else.18012:
	li      1, $1
be_cont.18013:
be_cont.18011:
	b       be_cont.18009
be_else.18008:
	li      1, $1
be_cont.18009:
be_cont.18007:
	cmp     $1, $zero, $28
	bne     $28, be_else.18018
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	b       shadow_check_one_or_matrix.3153
be_else.18018:
	li      1, $1
	ret
solve_each_element.3156:
	add     $2, $1, $28
	load    0($28), $4
	li      -1, $28
	cmp     $4, $28, $28
	bne     $28, be_else.18019
	ret
be_else.18019:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	store   $4, 3($sp)
	li      min_caml_startp, $1
	li      min_caml_objects, $2
	add     $2, $4, $28
	load    0($28), $2
	load    0($1), $4
	load    5($2), $5
	load    0($5), $5
	fsub    $4, $5, $4
	load    1($1), $5
	load    5($2), $6
	load    1($6), $6
	fsub    $5, $6, $5
	load    2($1), $1
	load    5($2), $6
	load    2($6), $6
	fsub    $1, $6, $1
	load    1($2), $6
	li      1, $28
	cmp     $6, $28, $28
	bne     $28, be_else.18021
	store   $4, 4($sp)
	store   $1, 5($sp)
	store   $5, 6($sp)
	store   $2, 7($sp)
	li      0, $6
	li      1, $7
	li      2, $8
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18023
	li      1, $6
	li      2, $7
	li      0, $8
	load    7($sp), $1
	load    0($sp), $2
	load    6($sp), $3
	load    5($sp), $4
	load    4($sp), $5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18025
	li      2, $6
	li      0, $7
	li      1, $8
	load    7($sp), $1
	load    0($sp), $2
	load    5($sp), $3
	load    4($sp), $4
	load    6($sp), $5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18027
	li      0, $1
	b       be_cont.18028
be_else.18027:
	li      3, $1
be_cont.18028:
	b       be_cont.18026
be_else.18025:
	li      2, $1
be_cont.18026:
	b       be_cont.18024
be_else.18023:
	li      1, $1
be_cont.18024:
	b       be_cont.18022
be_else.18021:
	li      2, $28
	cmp     $6, $28, $28
	bne     $28, be_else.18029
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18030
be_else.18029:
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18030:
be_cont.18022:
	cmp     $1, $zero, $28
	bne     $28, be_else.18031
	li      min_caml_objects, $1
	load    3($sp), $2
	add     $1, $2, $28
	load    0($28), $1
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.18032
	ret
be_else.18032:
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       solve_each_element.3156
be_else.18031:
	li      min_caml_solver_dist, $2
	load    0($2), $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.18034
	li      0, $3
	b       ble_cont.18035
ble_else.18034:
	li      1, $3
ble_cont.18035:
	cmp     $3, $zero, $28
	bne     $28, be_else.18036
	b       be_cont.18037
be_else.18036:
	li      min_caml_tmin, $3
	load    0($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.18038
	li      0, $3
	b       ble_cont.18039
ble_else.18038:
	li      1, $3
ble_cont.18039:
	cmp     $3, $zero, $28
	bne     $28, be_else.18040
	b       be_cont.18041
be_else.18040:
	store   $1, 8($sp)
	load    l.13319, $1
	fadd    $2, $1, $1
	store   $1, 9($sp)
	load    0($sp), $3
	load    0($3), $2
	fmul    $2, $1, $2
	li      min_caml_startp, $4
	load    0($4), $4
	fadd    $2, $4, $2
	store   $2, 10($sp)
	load    1($3), $4
	fmul    $4, $1, $4
	li      min_caml_startp, $5
	load    1($5), $5
	fadd    $4, $5, $4
	store   $4, 11($sp)
	load    2($3), $3
	fmul    $3, $1, $1
	li      min_caml_startp, $3
	load    2($3), $3
	fadd    $1, $3, $1
	store   $1, 12($sp)
	load    1($sp), $3
	load    0($3), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18042
	li      1, $1
	b       be_cont.18043
be_else.18042:
	li      min_caml_objects, $3
	add     $3, $5, $28
	load    0($28), $3
	mov     $4, $26
	mov     $1, $4
	mov     $3, $1
	mov     $26, $3
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     is_outside.3136
	sub     $sp, 14, $sp
	load    13($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18044
	li      1, $1
	load    1($sp), $2
	load    10($sp), $3
	load    11($sp), $4
	load    12($sp), $5
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     check_all_inside.3141
	sub     $sp, 14, $sp
	load    13($sp), $ra
	b       be_cont.18045
be_else.18044:
	li      0, $1
be_cont.18045:
be_cont.18043:
	cmp     $1, $zero, $28
	bne     $28, be_else.18046
	b       be_cont.18047
be_else.18046:
	li      min_caml_tmin, $1
	load    9($sp), $2
	store   $2, 0($1)
	li      min_caml_intersection_point, $1
	load    10($sp), $2
	store   $2, 0($1)
	load    11($sp), $2
	store   $2, 1($1)
	load    12($sp), $2
	store   $2, 2($1)
	li      min_caml_intersected_object_id, $1
	load    3($sp), $2
	store   $2, 0($1)
	li      min_caml_intsec_rectside, $1
	load    8($sp), $2
	store   $2, 0($1)
be_cont.18047:
be_cont.18041:
be_cont.18037:
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       solve_each_element.3156
solve_one_or_network.3160:
	add     $2, $1, $28
	load    0($28), $4
	li      -1, $28
	cmp     $4, $28, $28
	bne     $28, be_else.18048
	ret
be_else.18048:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	li      min_caml_and_net, $1
	add     $1, $4, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solve_each_element.3156
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18050
	ret
be_else.18050:
	store   $1, 3($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18052
	ret
be_else.18052:
	store   $1, 4($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solve_each_element.3156
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    4($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18054
	ret
be_else.18054:
	store   $1, 5($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     solve_each_element.3156
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       solve_one_or_network.3160
trace_or_matrix.3164:
	add     $2, $1, $28
	load    0($28), $4
	load    0($4), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18056
	ret
be_else.18056:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	li      99, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18058
	load    1($4), $1
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18060
	b       be_cont.18061
be_else.18060:
	store   $4, 3($sp)
	li      min_caml_and_net, $2
	add     $2, $1, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18062
	b       be_cont.18063
be_else.18062:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18064
	b       be_cont.18065
be_else.18064:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element.3156
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $1
	load    3($sp), $2
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network.3160
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18065:
be_cont.18063:
be_cont.18061:
	b       be_cont.18059
be_else.18058:
	store   $4, 3($sp)
	li      min_caml_startp, $1
	li      min_caml_objects, $2
	add     $2, $5, $28
	load    0($28), $2
	load    0($1), $4
	load    5($2), $5
	load    0($5), $5
	fsub    $4, $5, $4
	load    1($1), $5
	load    5($2), $6
	load    1($6), $6
	fsub    $5, $6, $5
	load    2($1), $1
	load    5($2), $6
	load    2($6), $6
	fsub    $1, $6, $1
	load    1($2), $6
	li      1, $28
	cmp     $6, $28, $28
	bne     $28, be_else.18066
	store   $4, 4($sp)
	store   $1, 5($sp)
	store   $5, 6($sp)
	store   $2, 7($sp)
	li      0, $6
	li      1, $7
	li      2, $8
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18068
	li      1, $6
	li      2, $7
	li      0, $8
	load    7($sp), $1
	load    0($sp), $2
	load    6($sp), $3
	load    5($sp), $4
	load    4($sp), $5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18070
	li      2, $6
	li      0, $7
	li      1, $8
	load    7($sp), $1
	load    0($sp), $2
	load    5($sp), $3
	load    4($sp), $4
	load    6($sp), $5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_rect_surface.3018
	sub     $sp, 9, $sp
	load    8($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18072
	li      0, $1
	b       be_cont.18073
be_else.18072:
	li      3, $1
be_cont.18073:
	b       be_cont.18071
be_else.18070:
	li      2, $1
be_cont.18071:
	b       be_cont.18069
be_else.18068:
	li      1, $1
be_cont.18069:
	b       be_cont.18067
be_else.18066:
	li      2, $28
	cmp     $6, $28, $28
	bne     $28, be_else.18074
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18075
be_else.18074:
	mov     $5, $26
	mov     $1, $5
	mov     $2, $1
	mov     $3, $2
	mov     $4, $3
	mov     $26, $4
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18075:
be_cont.18067:
	cmp     $1, $zero, $28
	bne     $28, be_else.18076
	b       be_cont.18077
be_else.18076:
	li      min_caml_solver_dist, $1
	load    0($1), $1
	li      min_caml_tmin, $2
	load    0($2), $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18078
	li      0, $1
	b       ble_cont.18079
ble_else.18078:
	li      1, $1
ble_cont.18079:
	cmp     $1, $zero, $28
	bne     $28, be_else.18080
	b       be_cont.18081
be_else.18080:
	load    3($sp), $1
	load    1($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18082
	b       be_cont.18083
be_else.18082:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    3($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18084
	b       be_cont.18085
be_else.18084:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    3($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18086
	b       be_cont.18087
be_else.18086:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_each_element.3156
	sub     $sp, 9, $sp
	load    8($sp), $ra
	li      4, $1
	load    3($sp), $2
	load    0($sp), $3
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solve_one_or_network.3160
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18087:
be_cont.18085:
be_cont.18083:
be_cont.18081:
be_cont.18077:
be_cont.18059:
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       trace_or_matrix.3164
solve_each_element_fast.3170:
	load    0($3), $4
	add     $2, $1, $28
	load    0($28), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18088
	ret
be_else.18088:
	store   $4, 0($sp)
	store   $3, 1($sp)
	store   $2, 2($sp)
	store   $1, 3($sp)
	store   $5, 4($sp)
	li      min_caml_objects, $1
	add     $1, $5, $28
	load    0($28), $1
	load    10($1), $2
	load    0($2), $4
	load    1($2), $6
	load    2($2), $7
	load    1($3), $8
	add     $8, $5, $28
	load    0($28), $5
	load    1($1), $8
	li      1, $28
	cmp     $8, $28, $28
	bne     $28, be_else.18090
	load    0($3), $2
	mov     $5, $3
	mov     $6, $5
	mov     $7, $6
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18091
be_else.18090:
	li      2, $28
	cmp     $8, $28, $28
	bne     $28, be_else.18092
	load    0($5), $1
	load    l.13295, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.18094
	li      0, $1
	b       ble_cont.18095
ble_else.18094:
	li      1, $1
ble_cont.18095:
	cmp     $1, $zero, $28
	bne     $28, be_else.18096
	li      0, $1
	b       be_cont.18097
be_else.18096:
	li      min_caml_solver_dist, $1
	load    0($5), $3
	load    3($2), $2
	fmul    $3, $2, $2
	store   $2, 0($1)
	li      1, $1
be_cont.18097:
	b       be_cont.18093
be_else.18092:
	mov     $2, $3
	mov     $5, $2
	mov     $6, $5
	mov     $7, $6
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18093:
be_cont.18091:
	cmp     $1, $zero, $28
	bne     $28, be_else.18098
	li      min_caml_objects, $1
	load    4($sp), $2
	add     $1, $2, $28
	load    0($28), $1
	load    6($1), $1
	cmp     $1, $zero, $28
	bne     $28, be_else.18099
	ret
be_else.18099:
	load    3($sp), $1
	add     $1, 1, $1
	load    2($sp), $2
	load    1($sp), $3
	b       solve_each_element_fast.3170
be_else.18098:
	li      min_caml_solver_dist, $2
	load    0($2), $2
	load    l.13295, $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.18101
	li      0, $3
	b       ble_cont.18102
ble_else.18101:
	li      1, $3
ble_cont.18102:
	cmp     $3, $zero, $28
	bne     $28, be_else.18103
	b       be_cont.18104
be_else.18103:
	li      min_caml_tmin, $3
	load    0($3), $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.18105
	li      0, $3
	b       ble_cont.18106
ble_else.18105:
	li      1, $3
ble_cont.18106:
	cmp     $3, $zero, $28
	bne     $28, be_else.18107
	b       be_cont.18108
be_else.18107:
	store   $1, 5($sp)
	load    l.13319, $1
	fadd    $2, $1, $1
	store   $1, 6($sp)
	load    0($sp), $2
	load    0($2), $3
	fmul    $3, $1, $3
	li      min_caml_startp_fast, $4
	load    0($4), $4
	fadd    $3, $4, $3
	store   $3, 7($sp)
	load    1($2), $4
	fmul    $4, $1, $4
	li      min_caml_startp_fast, $5
	load    1($5), $5
	fadd    $4, $5, $4
	store   $4, 8($sp)
	load    2($2), $2
	fmul    $2, $1, $1
	li      min_caml_startp_fast, $2
	load    2($2), $2
	fadd    $1, $2, $1
	store   $1, 9($sp)
	load    2($sp), $2
	load    0($2), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18109
	li      1, $1
	b       be_cont.18110
be_else.18109:
	li      min_caml_objects, $2
	add     $2, $5, $28
	load    0($28), $2
	mov     $4, $26
	mov     $1, $4
	mov     $2, $1
	mov     $3, $2
	mov     $26, $3
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     is_outside.3136
	sub     $sp, 11, $sp
	load    10($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18111
	li      1, $1
	load    2($sp), $2
	load    7($sp), $3
	load    8($sp), $4
	load    9($sp), $5
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     check_all_inside.3141
	sub     $sp, 11, $sp
	load    10($sp), $ra
	b       be_cont.18112
be_else.18111:
	li      0, $1
be_cont.18112:
be_cont.18110:
	cmp     $1, $zero, $28
	bne     $28, be_else.18113
	b       be_cont.18114
be_else.18113:
	li      min_caml_tmin, $1
	load    6($sp), $2
	store   $2, 0($1)
	li      min_caml_intersection_point, $1
	load    7($sp), $2
	store   $2, 0($1)
	load    8($sp), $2
	store   $2, 1($1)
	load    9($sp), $2
	store   $2, 2($1)
	li      min_caml_intersected_object_id, $1
	load    4($sp), $2
	store   $2, 0($1)
	li      min_caml_intsec_rectside, $1
	load    5($sp), $2
	store   $2, 0($1)
be_cont.18114:
be_cont.18108:
be_cont.18104:
	load    3($sp), $1
	add     $1, 1, $1
	load    2($sp), $2
	load    1($sp), $3
	b       solve_each_element_fast.3170
solve_one_or_network_fast.3174:
	add     $2, $1, $28
	load    0($28), $4
	li      -1, $28
	cmp     $4, $28, $28
	bne     $28, be_else.18115
	ret
be_else.18115:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	li      min_caml_and_net, $1
	add     $1, $4, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18117
	ret
be_else.18117:
	store   $1, 3($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18119
	ret
be_else.18119:
	store   $1, 4($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    4($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	li      -1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18121
	ret
be_else.18121:
	store   $1, 5($sp)
	li      min_caml_and_net, $1
	add     $1, $3, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       solve_one_or_network_fast.3174
trace_or_matrix_fast.3178:
	add     $2, $1, $28
	load    0($28), $4
	load    0($4), $5
	li      -1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18123
	ret
be_else.18123:
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	li      99, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18125
	load    1($4), $1
	li      -1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18127
	b       be_cont.18128
be_else.18127:
	store   $4, 3($sp)
	li      min_caml_and_net, $2
	add     $2, $1, $28
	load    0($28), $2
	li      0, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18129
	b       be_cont.18130
be_else.18129:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18131
	b       be_cont.18132
be_else.18131:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $1
	load    3($sp), $2
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network_fast.3174
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18132:
be_cont.18130:
be_cont.18128:
	b       be_cont.18126
be_else.18125:
	store   $4, 3($sp)
	li      min_caml_objects, $1
	add     $1, $5, $28
	load    0($28), $1
	load    10($1), $2
	load    0($2), $4
	load    1($2), $6
	load    2($2), $7
	load    1($3), $8
	add     $8, $5, $28
	load    0($28), $5
	load    1($1), $8
	li      1, $28
	cmp     $8, $28, $28
	bne     $28, be_else.18133
	load    0($3), $2
	mov     $5, $3
	mov     $6, $5
	mov     $7, $6
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18134
be_else.18133:
	li      2, $28
	cmp     $8, $28, $28
	bne     $28, be_else.18135
	load    0($5), $1
	load    l.13295, $3
	fcmp    $3, $1, $28
	bg      $28, ble_else.18137
	li      0, $1
	b       ble_cont.18138
ble_else.18137:
	li      1, $1
ble_cont.18138:
	cmp     $1, $zero, $28
	bne     $28, be_else.18139
	li      0, $1
	b       be_cont.18140
be_else.18139:
	li      min_caml_solver_dist, $1
	load    0($5), $3
	load    3($2), $2
	fmul    $3, $2, $2
	store   $2, 0($1)
	li      1, $1
be_cont.18140:
	b       be_cont.18136
be_else.18135:
	mov     $2, $3
	mov     $5, $2
	mov     $6, $5
	mov     $7, $6
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18136:
be_cont.18134:
	cmp     $1, $zero, $28
	bne     $28, be_else.18141
	b       be_cont.18142
be_else.18141:
	li      min_caml_solver_dist, $1
	load    0($1), $1
	li      min_caml_tmin, $2
	load    0($2), $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18143
	li      0, $1
	b       ble_cont.18144
ble_else.18143:
	li      1, $1
ble_cont.18144:
	cmp     $1, $zero, $28
	bne     $28, be_else.18145
	b       be_cont.18146
be_else.18145:
	load    3($sp), $1
	load    1($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18147
	b       be_cont.18148
be_else.18147:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    2($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18149
	b       be_cont.18150
be_else.18149:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $1
	load    3($1), $2
	li      -1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18151
	b       be_cont.18152
be_else.18151:
	li      min_caml_and_net, $1
	add     $1, $2, $28
	load    0($28), $2
	li      0, $1
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_each_element_fast.3170
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      4, $1
	load    3($sp), $2
	load    0($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solve_one_or_network_fast.3174
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18152:
be_cont.18150:
be_cont.18148:
be_cont.18146:
be_cont.18142:
be_cont.18126:
	load    2($sp), $1
	add     $1, 1, $1
	load    1($sp), $2
	load    0($sp), $3
	b       trace_or_matrix_fast.3178
get_nvector_second.3188:
	li      min_caml_intersection_point, $2
	load    0($2), $2
	load    5($1), $3
	load    0($3), $3
	fsub    $2, $3, $2
	li      min_caml_intersection_point, $3
	load    1($3), $3
	load    5($1), $4
	load    1($4), $4
	fsub    $3, $4, $3
	li      min_caml_intersection_point, $4
	load    2($4), $4
	load    5($1), $5
	load    2($5), $5
	fsub    $4, $5, $4
	load    4($1), $5
	load    0($5), $5
	fmul    $2, $5, $5
	load    4($1), $6
	load    1($6), $6
	fmul    $3, $6, $6
	load    4($1), $7
	load    2($7), $7
	fmul    $4, $7, $7
	load    3($1), $8
	cmp     $8, $zero, $28
	bne     $28, be_else.18153
	li      min_caml_nvector, $2
	store   $5, 0($2)
	li      min_caml_nvector, $2
	store   $6, 1($2)
	li      min_caml_nvector, $2
	store   $7, 2($2)
	b       be_cont.18154
be_else.18153:
	li      min_caml_nvector, $8
	load    9($1), $9
	load    2($9), $9
	fmul    $3, $9, $9
	load    9($1), $10
	load    1($10), $10
	fmul    $4, $10, $10
	fadd    $9, $10, $9
	load    l.13293, $10
	fmul    $9, $10, $9
	fadd    $5, $9, $5
	store   $5, 0($8)
	li      min_caml_nvector, $5
	load    9($1), $8
	load    2($8), $8
	fmul    $2, $8, $8
	load    9($1), $9
	load    0($9), $9
	fmul    $4, $9, $4
	fadd    $8, $4, $4
	load    l.13293, $8
	fmul    $4, $8, $4
	fadd    $6, $4, $4
	store   $4, 1($5)
	li      min_caml_nvector, $4
	load    9($1), $5
	load    1($5), $5
	fmul    $2, $5, $2
	load    9($1), $5
	load    0($5), $5
	fmul    $3, $5, $3
	fadd    $2, $3, $2
	load    l.13293, $3
	fmul    $2, $3, $2
	fadd    $7, $2, $2
	store   $2, 2($4)
be_cont.18154:
	li      min_caml_nvector, $2
	load    6($1), $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	b       vecunit_sgn.2896
utexture.3193:
	load    0($1), $3
	li      min_caml_texture_color, $4
	load    8($1), $5
	load    0($5), $5
	store   $5, 0($4)
	li      min_caml_texture_color, $4
	load    8($1), $5
	load    1($5), $5
	store   $5, 1($4)
	li      min_caml_texture_color, $4
	load    8($1), $5
	load    2($5), $5
	store   $5, 2($4)
	li      1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18155
	store   $1, 0($sp)
	store   $2, 1($sp)
	load    0($2), $2
	load    5($1), $1
	load    0($1), $1
	fsub    $2, $1, $1
	store   $1, 2($sp)
	load    l.13330, $2
	fmul    $1, $2, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_floor
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13331, $2
	fmul    $1, $2, $1
	load    2($sp), $2
	fsub    $2, $1, $1
	load    l.13328, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18156
	li      0, $1
	b       ble_cont.18157
ble_else.18156:
	li      1, $1
ble_cont.18157:
	store   $1, 3($sp)
	load    1($sp), $1
	load    2($1), $1
	load    0($sp), $2
	load    5($2), $2
	load    2($2), $2
	fsub    $1, $2, $1
	store   $1, 4($sp)
	load    l.13330, $2
	fmul    $1, $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_floor
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13331, $2
	fmul    $1, $2, $1
	load    4($sp), $2
	fsub    $2, $1, $1
	load    l.13328, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18158
	li      0, $1
	b       ble_cont.18159
ble_else.18158:
	li      1, $1
ble_cont.18159:
	li      min_caml_texture_color, $2
	load    3($sp), $3
	cmp     $3, $zero, $28
	bne     $28, be_else.18160
	cmp     $1, $zero, $28
	bne     $28, be_else.18162
	load    l.13326, $1
	b       be_cont.18163
be_else.18162:
	load    l.13295, $1
be_cont.18163:
	b       be_cont.18161
be_else.18160:
	cmp     $1, $zero, $28
	bne     $28, be_else.18164
	load    l.13295, $1
	b       be_cont.18165
be_else.18164:
	load    l.13326, $1
be_cont.18165:
be_cont.18161:
	store   $1, 1($2)
	ret
be_else.18155:
	li      2, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18167
	load    1($2), $1
	load    l.13329, $2
	fmul    $1, $2, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18168
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18170
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18172
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18174
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.18175
ble_else.18174:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.18175:
	b       ble_cont.18173
ble_else.18172:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18173:
	b       ble_cont.18171
ble_else.18170:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18171:
	b       ble_cont.18169
ble_else.18168:
	fneg    $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $1, $1
ble_cont.18169:
	fmul    $1, $1, $1
	li      min_caml_texture_color, $2
	load    l.13326, $3
	fmul    $3, $1, $3
	store   $3, 0($2)
	li      min_caml_texture_color, $2
	load    l.13326, $3
	load    l.13296, $4
	fsub    $4, $1, $1
	fmul    $3, $1, $1
	store   $1, 1($2)
	ret
be_else.18167:
	li      3, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18177
	load    0($2), $3
	load    5($1), $4
	load    0($4), $4
	fsub    $3, $4, $3
	load    2($2), $2
	load    5($1), $1
	load    2($1), $1
	fsub    $2, $1, $1
	fmul    $3, $3, $2
	fmul    $1, $1, $1
	fadd    $2, $1, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sqrt.2865
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    l.13328, $2
	finv    $2, $28
	fmul    $1, $28, $1
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_floor
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    5($sp), $2
	fsub    $2, $1, $1
	load    l.13324, $2
	fmul    $1, $2, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18178
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18180
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18182
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18184
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.18185
ble_else.18184:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18185:
	b       ble_cont.18183
ble_else.18182:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $1, $1
ble_cont.18183:
	b       ble_cont.18181
ble_else.18180:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18181:
	b       ble_cont.18179
ble_else.18178:
	fneg    $1, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18179:
	fmul    $1, $1, $1
	li      min_caml_texture_color, $2
	load    l.13326, $3
	fmul    $1, $3, $3
	store   $3, 1($2)
	li      min_caml_texture_color, $2
	load    l.13296, $3
	fsub    $3, $1, $1
	load    l.13326, $3
	fmul    $1, $3, $1
	store   $1, 2($2)
	ret
be_else.18177:
	li      4, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18187
	store   $1, 0($sp)
	store   $2, 1($sp)
	load    0($2), $2
	load    5($1), $3
	load    0($3), $3
	fsub    $2, $3, $2
	store   $2, 6($sp)
	load    4($1), $1
	load    0($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	fmul    $2, $1, $1
	store   $1, 7($sp)
	load    1($sp), $1
	load    2($1), $1
	load    0($sp), $2
	load    5($2), $3
	load    2($3), $3
	fsub    $1, $3, $1
	store   $1, 8($sp)
	load    4($2), $1
	load    2($1), $1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     sqrt.2865
	sub     $sp, 10, $sp
	load    9($sp), $ra
	load    8($sp), $2
	fmul    $2, $1, $1
	load    7($sp), $2
	fmul    $2, $2, $3
	fmul    $1, $1, $4
	fadd    $3, $4, $3
	store   $3, 9($sp)
	load    l.13295, $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.18188
	mov     $2, $3
	b       ble_cont.18189
ble_else.18188:
	fneg    $2, $3
ble_cont.18189:
	load    l.13321, $4
	fcmp    $4, $3, $28
	bg      $28, ble_else.18190
	li      0, $3
	b       ble_cont.18191
ble_else.18190:
	li      1, $3
ble_cont.18191:
	cmp     $3, $zero, $28
	bne     $28, be_else.18192
	finv    $2, $28
	fmul    $1, $28, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18194
	b       ble_cont.18195
ble_else.18194:
	fneg    $1, $1
ble_cont.18195:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     cordic_atan.2855
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    l.13323, $2
	fmul    $1, $2, $1
	load    l.13324, $2
	finv    $2, $28
	fmul    $1, $28, $1
	b       be_cont.18193
be_else.18192:
	load    l.13322, $1
be_cont.18193:
	store   $1, 10($sp)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_floor
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    10($sp), $2
	fsub    $2, $1, $1
	store   $1, 11($sp)
	load    1($sp), $1
	load    1($1), $1
	load    0($sp), $2
	load    5($2), $3
	load    1($3), $3
	fsub    $1, $3, $1
	store   $1, 12($sp)
	load    4($2), $1
	load    1($1), $1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     sqrt.2865
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    12($sp), $2
	fmul    $2, $1, $1
	load    l.13295, $2
	load    9($sp), $3
	fcmp    $2, $3, $28
	bg      $28, ble_else.18196
	mov     $3, $2
	b       ble_cont.18197
ble_else.18196:
	fneg    $3, $2
ble_cont.18197:
	load    l.13321, $4
	fcmp    $4, $2, $28
	bg      $28, ble_else.18198
	li      0, $2
	b       ble_cont.18199
ble_else.18198:
	li      1, $2
ble_cont.18199:
	cmp     $2, $zero, $28
	bne     $28, be_else.18200
	finv    $3, $28
	fmul    $1, $28, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18202
	b       ble_cont.18203
ble_else.18202:
	fneg    $1, $1
ble_cont.18203:
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     cordic_atan.2855
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    l.13323, $2
	fmul    $1, $2, $1
	load    l.13324, $2
	finv    $2, $28
	fmul    $1, $28, $1
	b       be_cont.18201
be_else.18200:
	load    l.13322, $1
be_cont.18201:
	store   $1, 13($sp)
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_floor
	sub     $sp, 15, $sp
	load    14($sp), $ra
	load    13($sp), $2
	fsub    $2, $1, $1
	load    l.13325, $2
	load    l.13293, $3
	load    11($sp), $4
	fsub    $3, $4, $3
	fmul    $3, $3, $3
	fsub    $2, $3, $2
	load    l.13293, $3
	fsub    $3, $1, $1
	fmul    $1, $1, $1
	fsub    $2, $1, $1
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18204
	li      0, $2
	b       ble_cont.18205
ble_else.18204:
	li      1, $2
ble_cont.18205:
	cmp     $2, $zero, $28
	bne     $28, be_else.18206
	b       be_cont.18207
be_else.18206:
	load    l.13295, $1
be_cont.18207:
	li      min_caml_texture_color, $2
	load    l.13326, $3
	fmul    $3, $1, $1
	load    l.13327, $3
	finv    $3, $28
	fmul    $1, $28, $1
	store   $1, 2($2)
	ret
be_else.18187:
	ret
add_light.3196:
	load    l.13295, $4
	fcmp    $1, $4, $28
	bg      $28, ble_else.18210
	li      0, $4
	b       ble_cont.18211
ble_else.18210:
	li      1, $4
ble_cont.18211:
	cmp     $4, $zero, $28
	bne     $28, be_else.18212
	b       be_cont.18213
be_else.18212:
	li      min_caml_rgb, $4
	li      min_caml_texture_color, $5
	load    0($4), $6
	load    0($5), $7
	fmul    $1, $7, $7
	fadd    $6, $7, $6
	store   $6, 0($4)
	load    1($4), $6
	load    1($5), $7
	fmul    $1, $7, $7
	fadd    $6, $7, $6
	store   $6, 1($4)
	load    2($4), $6
	load    2($5), $5
	fmul    $1, $5, $1
	fadd    $6, $1, $1
	store   $1, 2($4)
be_cont.18213:
	load    l.13295, $1
	fcmp    $2, $1, $28
	bg      $28, ble_else.18214
	li      0, $1
	b       ble_cont.18215
ble_else.18214:
	li      1, $1
ble_cont.18215:
	cmp     $1, $zero, $28
	bne     $28, be_else.18216
	ret
be_else.18216:
	fmul    $2, $2, $1
	fmul    $1, $1, $1
	fmul    $1, $3, $1
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    0($3), $3
	fadd    $3, $1, $3
	store   $3, 0($2)
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    1($3), $3
	fadd    $3, $1, $3
	store   $3, 1($2)
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    2($3), $3
	fadd    $3, $1, $1
	store   $1, 2($2)
	ret
trace_reflections.3200:
	cmp     $1, $zero, $28
	bl      $28, bge_else.18219
	store   $4, 0($sp)
	store   $3, 1($sp)
	store   $2, 2($sp)
	store   $1, 3($sp)
	li      min_caml_reflections, $2
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 4($sp)
	load    1($1), $3
	store   $3, 5($sp)
	li      min_caml_tmin, $1
	load    l.13332, $2
	store   $2, 0($1)
	li      0, $1
	li      min_caml_or_net, $2
	load    0($2), $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     trace_or_matrix_fast.3178
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      min_caml_tmin, $1
	load    0($1), $1
	load    l.13320, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18220
	li      0, $2
	b       ble_cont.18221
ble_else.18220:
	li      1, $2
ble_cont.18221:
	cmp     $2, $zero, $28
	bne     $28, be_else.18222
	li      0, $1
	b       be_cont.18223
be_else.18222:
	load    l.13333, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18224
	li      0, $1
	b       ble_cont.18225
ble_else.18224:
	li      1, $1
ble_cont.18225:
be_cont.18223:
	cmp     $1, $zero, $28
	bne     $28, be_else.18226
	b       be_cont.18227
be_else.18226:
	li      min_caml_intersected_object_id, $1
	load    0($1), $1
	sll     $1, 2, $1
	li      min_caml_intsec_rectside, $2
	load    0($2), $2
	add     $1, $2, $1
	load    4($sp), $2
	load    0($2), $3
	cmp     $1, $3, $28
	bne     $28, be_else.18228
	li      0, $1
	li      min_caml_or_net, $2
	load    0($2), $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 7, $sp
	load    6($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18230
	li      min_caml_nvector, $1
	load    5($sp), $2
	load    0($2), $3
	load    0($1), $4
	load    0($3), $5
	fmul    $4, $5, $4
	load    1($1), $5
	load    1($3), $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    2($1), $1
	load    2($3), $3
	fmul    $1, $3, $1
	fadd    $4, $1, $1
	load    4($sp), $3
	load    2($3), $3
	load    2($sp), $4
	fmul    $3, $4, $4
	fmul    $4, $1, $1
	load    0($2), $2
	load    0($sp), $4
	load    0($4), $5
	load    0($2), $6
	fmul    $5, $6, $5
	load    1($4), $6
	load    1($2), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	load    2($4), $4
	load    2($2), $2
	fmul    $4, $2, $2
	fadd    $5, $2, $2
	fmul    $3, $2, $2
	load    1($sp), $3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     add_light.3196
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.18231
be_else.18230:
be_cont.18231:
	b       be_cont.18229
be_else.18228:
be_cont.18229:
be_cont.18227:
	load    3($sp), $1
	sub     $1, 1, $1
	load    2($sp), $2
	load    1($sp), $3
	load    0($sp), $4
	b       trace_reflections.3200
bge_else.18219:
	ret
trace_ray.3205:
	li      4, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18233
	store   $5, 0($sp)
	store   $4, 1($sp)
	store   $2, 2($sp)
	store   $3, 3($sp)
	store   $1, 4($sp)
	load    2($4), $1
	store   $1, 5($sp)
	li      min_caml_tmin, $1
	load    l.13332, $2
	store   $2, 0($1)
	li      0, $1
	li      min_caml_or_net, $2
	load    0($2), $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     trace_or_matrix.3164
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      min_caml_tmin, $1
	load    0($1), $1
	load    l.13320, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18234
	li      0, $2
	b       ble_cont.18235
ble_else.18234:
	li      1, $2
ble_cont.18235:
	cmp     $2, $zero, $28
	bne     $28, be_else.18236
	li      0, $1
	b       be_cont.18237
be_else.18236:
	load    l.13333, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18238
	li      0, $1
	b       ble_cont.18239
ble_else.18238:
	li      1, $1
ble_cont.18239:
be_cont.18237:
	cmp     $1, $zero, $28
	bne     $28, be_else.18240
	li      -1, $1
	load    4($sp), $2
	load    5($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	cmp     $2, $zero, $28
	bne     $28, be_else.18241
	ret
be_else.18241:
	li      min_caml_light, $1
	load    3($sp), $2
	load    0($2), $3
	load    0($1), $4
	fmul    $3, $4, $3
	load    1($2), $4
	load    1($1), $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	load    2($2), $2
	load    2($1), $1
	fmul    $2, $1, $1
	fadd    $3, $1, $1
	fneg    $1, $1
	load    l.13295, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18243
	li      0, $2
	b       ble_cont.18244
ble_else.18243:
	li      1, $2
ble_cont.18244:
	cmp     $2, $zero, $28
	bne     $28, be_else.18245
	ret
be_else.18245:
	fmul    $1, $1, $2
	fmul    $2, $1, $1
	load    2($sp), $2
	fmul    $1, $2, $1
	li      min_caml_beam, $2
	load    0($2), $2
	fmul    $1, $2, $1
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    0($3), $3
	fadd    $3, $1, $3
	store   $3, 0($2)
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    1($3), $3
	fadd    $3, $1, $3
	store   $3, 1($2)
	li      min_caml_rgb, $2
	li      min_caml_rgb, $3
	load    2($3), $3
	fadd    $3, $1, $1
	store   $1, 2($2)
	ret
be_else.18240:
	li      min_caml_intersected_object_id, $1
	load    0($1), $1
	store   $1, 6($sp)
	li      min_caml_objects, $2
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 7($sp)
	load    2($1), $2
	store   $2, 8($sp)
	load    7($1), $2
	load    0($2), $2
	load    2($sp), $3
	fmul    $2, $3, $2
	store   $2, 9($sp)
	load    1($1), $2
	li      1, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18248
	li      min_caml_intsec_rectside, $1
	load    0($1), $1
	li      min_caml_nvector, $2
	load    l.13295, $3
	store   $3, 0($2)
	store   $3, 1($2)
	store   $3, 2($2)
	li      min_caml_nvector, $2
	sub     $1, 1, $3
	sub     $1, 1, $1
	load    3($sp), $4
	add     $4, $1, $28
	load    0($28), $1
	load    l.13295, $4
	fcmp    $1, $4, $28
	bne     $28, be_else.18250
	li      1, $4
	b       be_cont.18251
be_else.18250:
	li      0, $4
be_cont.18251:
	cmp     $4, $zero, $28
	bne     $28, be_else.18252
	load    l.13295, $4
	fcmp    $1, $4, $28
	bg      $28, ble_else.18254
	li      0, $1
	b       ble_cont.18255
ble_else.18254:
	li      1, $1
ble_cont.18255:
	cmp     $1, $zero, $28
	bne     $28, be_else.18256
	load    l.13302, $1
	b       be_cont.18257
be_else.18256:
	load    l.13296, $1
be_cont.18257:
	b       be_cont.18253
be_else.18252:
	load    l.13295, $1
be_cont.18253:
	fneg    $1, $1
	add     $2, $3, $28
	store   $1, 0($28)
	b       be_cont.18249
be_else.18248:
	li      2, $28
	cmp     $2, $28, $28
	bne     $28, be_else.18258
	li      min_caml_nvector, $2
	load    4($1), $3
	load    0($3), $3
	fneg    $3, $3
	store   $3, 0($2)
	li      min_caml_nvector, $2
	load    4($1), $3
	load    1($3), $3
	fneg    $3, $3
	store   $3, 1($2)
	li      min_caml_nvector, $2
	load    4($1), $1
	load    2($1), $1
	fneg    $1, $1
	store   $1, 2($2)
	b       be_cont.18259
be_else.18258:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     get_nvector_second.3188
	sub     $sp, 11, $sp
	load    10($sp), $ra
be_cont.18259:
be_cont.18249:
	li      min_caml_startp, $1
	li      min_caml_intersection_point, $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $2
	store   $2, 2($1)
	li      min_caml_intersection_point, $2
	load    7($sp), $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     utexture.3193
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    6($sp), $1
	sll     $1, 2, $1
	li      min_caml_intsec_rectside, $2
	load    0($2), $2
	add     $1, $2, $1
	load    4($sp), $2
	load    5($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	load    1($sp), $1
	load    1($1), $3
	add     $3, $2, $28
	load    0($28), $3
	li      min_caml_intersection_point, $4
	load    0($4), $5
	store   $5, 0($3)
	load    1($4), $5
	store   $5, 1($3)
	load    2($4), $4
	store   $4, 2($3)
	load    3($1), $3
	load    7($sp), $4
	load    7($4), $5
	load    0($5), $5
	load    l.13293, $6
	fcmp    $6, $5, $28
	bg      $28, ble_else.18260
	li      0, $5
	b       ble_cont.18261
ble_else.18260:
	li      1, $5
ble_cont.18261:
	cmp     $5, $zero, $28
	bne     $28, be_else.18262
	li      1, $5
	add     $3, $2, $28
	store   $5, 0($28)
	load    4($1), $3
	add     $3, $2, $28
	load    0($28), $5
	li      min_caml_texture_color, $6
	load    0($6), $7
	store   $7, 0($5)
	load    1($6), $7
	store   $7, 1($5)
	load    2($6), $6
	store   $6, 2($5)
	add     $3, $2, $28
	load    0($28), $3
	load    l.13334, $5
	load    9($sp), $6
	fmul    $5, $6, $5
	load    0($3), $6
	fmul    $6, $5, $6
	store   $6, 0($3)
	load    1($3), $6
	fmul    $6, $5, $6
	store   $6, 1($3)
	load    2($3), $6
	fmul    $6, $5, $5
	store   $5, 2($3)
	load    7($1), $1
	add     $1, $2, $28
	load    0($28), $1
	li      min_caml_nvector, $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $2
	store   $2, 2($1)
	b       be_cont.18263
be_else.18262:
	li      0, $1
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18263:
	load    l.13335, $1
	li      min_caml_nvector, $2
	load    3($sp), $3
	load    0($3), $5
	load    0($2), $6
	fmul    $5, $6, $5
	load    1($3), $6
	load    1($2), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	load    2($3), $6
	load    2($2), $2
	fmul    $6, $2, $2
	fadd    $5, $2, $2
	fmul    $1, $2, $1
	li      min_caml_nvector, $2
	load    0($3), $5
	load    0($2), $6
	fmul    $1, $6, $6
	fadd    $5, $6, $5
	store   $5, 0($3)
	load    1($3), $5
	load    1($2), $6
	fmul    $1, $6, $6
	fadd    $5, $6, $5
	store   $5, 1($3)
	load    2($3), $5
	load    2($2), $2
	fmul    $1, $2, $1
	fadd    $5, $1, $1
	store   $1, 2($3)
	load    7($4), $1
	load    1($1), $1
	load    2($sp), $2
	fmul    $2, $1, $1
	store   $1, 10($sp)
	li      0, $1
	li      min_caml_or_net, $2
	load    0($2), $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 12, $sp
	load    11($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18264
	li      min_caml_nvector, $1
	li      min_caml_light, $2
	load    0($1), $3
	load    0($2), $4
	fmul    $3, $4, $3
	load    1($1), $4
	load    1($2), $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	load    2($1), $1
	load    2($2), $2
	fmul    $1, $2, $1
	fadd    $3, $1, $1
	fneg    $1, $1
	load    9($sp), $2
	fmul    $1, $2, $1
	li      min_caml_light, $2
	load    3($sp), $3
	load    0($3), $4
	load    0($2), $5
	fmul    $4, $5, $4
	load    1($3), $5
	load    1($2), $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    2($3), $3
	load    2($2), $2
	fmul    $3, $2, $2
	fadd    $4, $2, $2
	fneg    $2, $2
	load    10($sp), $3
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     add_light.3196
	sub     $sp, 12, $sp
	load    11($sp), $ra
	b       be_cont.18265
be_else.18264:
be_cont.18265:
	li      min_caml_intersection_point, $1
	li      min_caml_startp_fast, $2
	load    0($1), $3
	store   $3, 0($2)
	load    1($1), $3
	store   $3, 1($2)
	load    2($1), $3
	store   $3, 2($2)
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 12, $sp
	load    11($sp), $ra
	li      min_caml_n_reflections, $1
	load    0($1), $1
	sub     $1, 1, $1
	load    9($sp), $2
	load    10($sp), $3
	load    3($sp), $4
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     trace_reflections.3200
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    l.13336, $1
	load    2($sp), $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18266
	li      0, $1
	b       ble_cont.18267
ble_else.18266:
	li      1, $1
ble_cont.18267:
	cmp     $1, $zero, $28
	bne     $28, be_else.18268
	ret
be_else.18268:
	load    4($sp), $1
	li      4, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.18270
	b       bge_cont.18271
bge_else.18270:
	add     $1, 1, $1
	li      -1, $2
	load    5($sp), $3
	add     $3, $1, $28
	store   $2, 0($28)
bge_cont.18271:
	load    8($sp), $1
	li      2, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18272
	load    l.13296, $1
	load    7($sp), $2
	load    7($2), $2
	load    0($2), $2
	fsub    $1, $2, $1
	load    2($sp), $2
	fmul    $2, $1, $2
	load    4($sp), $1
	add     $1, 1, $1
	li      min_caml_tmin, $3
	load    0($3), $3
	load    0($sp), $4
	fadd    $4, $3, $5
	load    3($sp), $3
	load    1($sp), $4
	b       trace_ray.3205
be_else.18272:
	ret
ble_else.18233:
	ret
trace_diffuse_ray.3211:
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      min_caml_tmin, $2
	load    l.13332, $3
	store   $3, 0($2)
	li      0, $2
	li      min_caml_or_net, $3
	load    0($3), $3
	mov     $3, $26
	mov     $1, $3
	mov     $2, $1
	mov     $26, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     trace_or_matrix_fast.3178
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      min_caml_tmin, $1
	load    0($1), $1
	load    l.13320, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18275
	li      0, $2
	b       ble_cont.18276
ble_else.18275:
	li      1, $2
ble_cont.18276:
	cmp     $2, $zero, $28
	bne     $28, be_else.18277
	li      0, $1
	b       be_cont.18278
be_else.18277:
	load    l.13333, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18279
	li      0, $1
	b       ble_cont.18280
ble_else.18279:
	li      1, $1
ble_cont.18280:
be_cont.18278:
	cmp     $1, $zero, $28
	bne     $28, be_else.18281
	ret
be_else.18281:
	li      min_caml_objects, $1
	li      min_caml_intersected_object_id, $2
	load    0($2), $2
	add     $1, $2, $28
	load    0($28), $1
	store   $1, 2($sp)
	load    1($sp), $2
	load    0($2), $2
	load    1($1), $3
	li      1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18283
	li      min_caml_intsec_rectside, $1
	load    0($1), $1
	li      min_caml_nvector, $3
	load    l.13295, $4
	store   $4, 0($3)
	store   $4, 1($3)
	store   $4, 2($3)
	li      min_caml_nvector, $3
	sub     $1, 1, $4
	sub     $1, 1, $1
	add     $2, $1, $28
	load    0($28), $1
	load    l.13295, $2
	fcmp    $1, $2, $28
	bne     $28, be_else.18285
	li      1, $2
	b       be_cont.18286
be_else.18285:
	li      0, $2
be_cont.18286:
	cmp     $2, $zero, $28
	bne     $28, be_else.18287
	load    l.13295, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18289
	li      0, $1
	b       ble_cont.18290
ble_else.18289:
	li      1, $1
ble_cont.18290:
	cmp     $1, $zero, $28
	bne     $28, be_else.18291
	load    l.13302, $1
	b       be_cont.18292
be_else.18291:
	load    l.13296, $1
be_cont.18292:
	b       be_cont.18288
be_else.18287:
	load    l.13295, $1
be_cont.18288:
	fneg    $1, $1
	add     $3, $4, $28
	store   $1, 0($28)
	b       be_cont.18284
be_else.18283:
	li      2, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18293
	li      min_caml_nvector, $2
	load    4($1), $3
	load    0($3), $3
	fneg    $3, $3
	store   $3, 0($2)
	li      min_caml_nvector, $2
	load    4($1), $3
	load    1($3), $3
	fneg    $3, $3
	store   $3, 1($2)
	li      min_caml_nvector, $2
	load    4($1), $1
	load    2($1), $1
	fneg    $1, $1
	store   $1, 2($2)
	b       be_cont.18294
be_else.18293:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     get_nvector_second.3188
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18294:
be_cont.18284:
	li      min_caml_intersection_point, $2
	load    2($sp), $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     utexture.3193
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $1
	li      min_caml_or_net, $2
	load    0($2), $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 4, $sp
	load    3($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18295
	li      min_caml_nvector, $1
	li      min_caml_light, $2
	load    0($1), $3
	load    0($2), $4
	fmul    $3, $4, $3
	load    1($1), $4
	load    1($2), $5
	fmul    $4, $5, $4
	fadd    $3, $4, $3
	load    2($1), $1
	load    2($2), $2
	fmul    $1, $2, $1
	fadd    $3, $1, $1
	fneg    $1, $1
	load    l.13295, $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18296
	li      0, $2
	b       ble_cont.18297
ble_else.18296:
	li      1, $2
ble_cont.18297:
	cmp     $2, $zero, $28
	bne     $28, be_else.18298
	load    l.13295, $1
	b       be_cont.18299
be_else.18298:
be_cont.18299:
	li      min_caml_diffuse_ray, $2
	load    0($sp), $3
	fmul    $3, $1, $1
	load    2($sp), $3
	load    7($3), $3
	load    0($3), $3
	fmul    $1, $3, $1
	li      min_caml_texture_color, $3
	load    0($2), $4
	load    0($3), $5
	fmul    $1, $5, $5
	fadd    $4, $5, $4
	store   $4, 0($2)
	load    1($2), $4
	load    1($3), $5
	fmul    $1, $5, $5
	fadd    $4, $5, $4
	store   $4, 1($2)
	load    2($2), $4
	load    2($3), $3
	fmul    $1, $3, $1
	fadd    $4, $1, $1
	store   $1, 2($2)
	ret
be_else.18295:
	ret
iter_trace_diffuse_rays.3214:
	cmp     $4, $zero, $28
	bl      $28, bge_else.18302
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	store   $4, 3($sp)
	add     $1, $4, $28
	load    0($28), $3
	load    0($3), $3
	load    0($3), $5
	load    0($2), $6
	fmul    $5, $6, $5
	load    1($3), $6
	load    1($2), $7
	fmul    $6, $7, $6
	fadd    $5, $6, $5
	load    2($3), $3
	load    2($2), $2
	fmul    $3, $2, $2
	fadd    $5, $2, $2
	load    l.13295, $3
	fcmp    $3, $2, $28
	bg      $28, ble_else.18303
	li      0, $3
	b       ble_cont.18304
ble_else.18303:
	li      1, $3
ble_cont.18304:
	cmp     $3, $zero, $28
	bne     $28, be_else.18305
	add     $1, $4, $28
	load    0($28), $1
	load    l.13338, $3
	finv    $3, $28
	fmul    $2, $28, $2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18306
be_else.18305:
	add     $4, 1, $3
	add     $1, $3, $28
	load    0($28), $1
	load    l.13337, $3
	finv    $3, $28
	fmul    $2, $28, $2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18306:
	load    3($sp), $1
	sub     $1, 2, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18307
	store   $1, 4($sp)
	load    2($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	load    0($3), $3
	load    0($3), $4
	load    1($sp), $5
	load    0($5), $6
	fmul    $4, $6, $4
	load    1($3), $6
	load    1($5), $7
	fmul    $6, $7, $6
	fadd    $4, $6, $4
	load    2($3), $3
	load    2($5), $5
	fmul    $3, $5, $3
	fadd    $4, $3, $3
	load    l.13295, $4
	fcmp    $4, $3, $28
	bg      $28, ble_else.18308
	li      0, $4
	b       ble_cont.18309
ble_else.18308:
	li      1, $4
ble_cont.18309:
	cmp     $4, $zero, $28
	bne     $28, be_else.18310
	add     $2, $1, $28
	load    0($28), $1
	load    l.13338, $2
	finv    $2, $28
	fmul    $3, $28, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18311
be_else.18310:
	add     $1, 1, $1
	add     $2, $1, $28
	load    0($28), $1
	load    l.13337, $2
	finv    $2, $28
	fmul    $3, $28, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18311:
	load    4($sp), $1
	sub     $1, 2, $4
	load    2($sp), $1
	load    1($sp), $2
	load    0($sp), $3
	b       iter_trace_diffuse_rays.3214
bge_else.18307:
	ret
bge_else.18302:
	ret
trace_diffuse_ray_80percent.3223:
	store   $2, 0($sp)
	store   $3, 1($sp)
	store   $1, 2($sp)
	cmp     $1, $zero, $28
	bne     $28, be_else.18314
	b       be_cont.18315
be_else.18314:
	li      min_caml_dirvecs, $1
	load    0($1), $1
	store   $1, 3($sp)
	li      min_caml_startp_fast, $1
	load    0($3), $2
	store   $2, 0($1)
	load    1($3), $2
	store   $2, 1($1)
	load    2($3), $2
	store   $2, 2($1)
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $2
	mov     $3, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      118, $4
	load    3($sp), $1
	load    0($sp), $2
	load    1($sp), $3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18315:
	load    2($sp), $1
	li      1, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18316
	b       be_cont.18317
be_else.18316:
	li      min_caml_dirvecs, $1
	load    1($1), $1
	store   $1, 4($sp)
	li      min_caml_startp_fast, $1
	load    1($sp), $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $3
	store   $3, 2($1)
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      118, $4
	load    4($sp), $1
	load    0($sp), $2
	load    1($sp), $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18317:
	load    2($sp), $1
	li      2, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18318
	b       be_cont.18319
be_else.18318:
	li      min_caml_dirvecs, $1
	load    2($1), $1
	store   $1, 5($sp)
	li      min_caml_startp_fast, $1
	load    1($sp), $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $3
	store   $3, 2($1)
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      118, $4
	load    5($sp), $1
	load    0($sp), $2
	load    1($sp), $3
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 7, $sp
	load    6($sp), $ra
be_cont.18319:
	load    2($sp), $1
	li      3, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18320
	b       be_cont.18321
be_else.18320:
	li      min_caml_dirvecs, $1
	load    3($1), $1
	store   $1, 6($sp)
	li      min_caml_startp_fast, $1
	load    1($sp), $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $3
	store   $3, 2($1)
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      118, $4
	load    6($sp), $1
	load    0($sp), $2
	load    1($sp), $3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18321:
	load    2($sp), $1
	li      4, $28
	cmp     $1, $28, $28
	bne     $28, be_else.18322
	ret
be_else.18322:
	li      min_caml_dirvecs, $1
	load    4($1), $1
	store   $1, 7($sp)
	li      min_caml_startp_fast, $1
	load    1($sp), $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $3
	store   $3, 2($1)
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 9, $sp
	load    8($sp), $ra
	li      118, $4
	load    7($sp), $1
	load    0($sp), $2
	load    1($sp), $3
	b       iter_trace_diffuse_rays.3214
calc_diffuse_using_5points.3230:
	add     $2, $1, $28
	load    0($28), $2
	load    5($2), $2
	sub     $1, 1, $6
	add     $3, $6, $28
	load    0($28), $6
	load    5($6), $6
	add     $3, $1, $28
	load    0($28), $7
	load    5($7), $7
	add     $1, 1, $8
	add     $3, $8, $28
	load    0($28), $8
	load    5($8), $8
	add     $4, $1, $28
	load    0($28), $4
	load    5($4), $4
	li      min_caml_diffuse_ray, $9
	add     $2, $5, $28
	load    0($28), $2
	load    0($2), $10
	store   $10, 0($9)
	load    1($2), $10
	store   $10, 1($9)
	load    2($2), $2
	store   $2, 2($9)
	li      min_caml_diffuse_ray, $2
	add     $6, $5, $28
	load    0($28), $6
	load    0($2), $9
	load    0($6), $10
	fadd    $9, $10, $9
	store   $9, 0($2)
	load    1($2), $9
	load    1($6), $10
	fadd    $9, $10, $9
	store   $9, 1($2)
	load    2($2), $9
	load    2($6), $6
	fadd    $9, $6, $6
	store   $6, 2($2)
	li      min_caml_diffuse_ray, $2
	add     $7, $5, $28
	load    0($28), $6
	load    0($2), $7
	load    0($6), $9
	fadd    $7, $9, $7
	store   $7, 0($2)
	load    1($2), $7
	load    1($6), $9
	fadd    $7, $9, $7
	store   $7, 1($2)
	load    2($2), $7
	load    2($6), $6
	fadd    $7, $6, $6
	store   $6, 2($2)
	li      min_caml_diffuse_ray, $2
	add     $8, $5, $28
	load    0($28), $6
	load    0($2), $7
	load    0($6), $8
	fadd    $7, $8, $7
	store   $7, 0($2)
	load    1($2), $7
	load    1($6), $8
	fadd    $7, $8, $7
	store   $7, 1($2)
	load    2($2), $7
	load    2($6), $6
	fadd    $7, $6, $6
	store   $6, 2($2)
	li      min_caml_diffuse_ray, $2
	add     $4, $5, $28
	load    0($28), $4
	load    0($2), $6
	load    0($4), $7
	fadd    $6, $7, $6
	store   $6, 0($2)
	load    1($2), $6
	load    1($4), $7
	fadd    $6, $7, $6
	store   $6, 1($2)
	load    2($2), $6
	load    2($4), $4
	fadd    $6, $4, $4
	store   $4, 2($2)
	add     $3, $1, $28
	load    0($28), $1
	load    4($1), $1
	li      min_caml_rgb, $2
	add     $1, $5, $28
	load    0($28), $1
	li      min_caml_diffuse_ray, $3
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	b       vecaccumv.2920
do_without_neighbors.3236:
	li      4, $28
	cmp     $2, $28, $28
	bg      $28, ble_else.18324
	load    2($1), $3
	add     $3, $2, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bl      $28, bge_else.18325
	store   $1, 0($sp)
	store   $2, 1($sp)
	load    3($1), $3
	add     $3, $2, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bne     $28, be_else.18326
	b       be_cont.18327
be_else.18326:
	load    5($1), $3
	load    7($1), $4
	load    1($1), $5
	load    4($1), $6
	store   $6, 2($sp)
	li      min_caml_diffuse_ray, $6
	add     $3, $2, $28
	load    0($28), $3
	load    0($3), $7
	store   $7, 0($6)
	load    1($3), $7
	store   $7, 1($6)
	load    2($3), $3
	store   $3, 2($6)
	load    6($1), $1
	load    0($1), $1
	add     $4, $2, $28
	load    0($28), $3
	add     $5, $2, $28
	load    0($28), $2
	mov     $3, $26
	mov     $2, $3
	mov     $26, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      min_caml_rgb, $1
	load    1($sp), $2
	load    2($sp), $3
	add     $3, $2, $28
	load    0($28), $2
	li      min_caml_diffuse_ray, $3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     vecaccumv.2920
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18327:
	load    1($sp), $1
	add     $1, 1, $1
	li      4, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18328
	load    0($sp), $2
	load    2($2), $3
	add     $3, $1, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bl      $28, bge_else.18329
	store   $1, 3($sp)
	load    3($2), $3
	add     $3, $1, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bne     $28, be_else.18330
	b       be_cont.18331
be_else.18330:
	load    5($2), $3
	load    7($2), $4
	load    1($2), $5
	load    4($2), $6
	store   $6, 4($sp)
	li      min_caml_diffuse_ray, $6
	add     $3, $1, $28
	load    0($28), $3
	load    0($3), $7
	store   $7, 0($6)
	load    1($3), $7
	store   $7, 1($6)
	load    2($3), $3
	store   $3, 2($6)
	load    6($2), $2
	load    0($2), $2
	add     $4, $1, $28
	load    0($28), $3
	add     $5, $1, $28
	load    0($28), $1
	mov     $3, $26
	mov     $1, $3
	mov     $2, $1
	mov     $26, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      min_caml_rgb, $1
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	load    0($28), $2
	li      min_caml_diffuse_ray, $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     vecaccumv.2920
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18331:
	load    3($sp), $1
	add     $1, 1, $2
	load    0($sp), $1
	b       do_without_neighbors.3236
bge_else.18329:
	ret
ble_else.18328:
	ret
bge_else.18325:
	ret
ble_else.18324:
	ret
try_exploit_neighbors.3252:
	add     $4, $1, $28
	load    0($28), $7
	li      4, $28
	cmp     $6, $28, $28
	bg      $28, ble_else.18336
	load    2($7), $8
	add     $8, $6, $28
	load    0($28), $8
	cmp     $8, $zero, $28
	bl      $28, bge_else.18337
	add     $4, $1, $28
	load    0($28), $8
	load    2($8), $8
	add     $8, $6, $28
	load    0($28), $8
	add     $3, $1, $28
	load    0($28), $9
	load    2($9), $9
	add     $9, $6, $28
	load    0($28), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18338
	add     $5, $1, $28
	load    0($28), $9
	load    2($9), $9
	add     $9, $6, $28
	load    0($28), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18340
	sub     $1, 1, $9
	add     $4, $9, $28
	load    0($28), $9
	load    2($9), $9
	add     $9, $6, $28
	load    0($28), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18342
	add     $1, 1, $9
	add     $4, $9, $28
	load    0($28), $9
	load    2($9), $9
	add     $9, $6, $28
	load    0($28), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18344
	li      1, $8
	b       be_cont.18345
be_else.18344:
	li      0, $8
be_cont.18345:
	b       be_cont.18343
be_else.18342:
	li      0, $8
be_cont.18343:
	b       be_cont.18341
be_else.18340:
	li      0, $8
be_cont.18341:
	b       be_cont.18339
be_else.18338:
	li      0, $8
be_cont.18339:
	cmp     $8, $zero, $28
	bne     $28, be_else.18346
	add     $4, $1, $28
	load    0($28), $1
	li      4, $28
	cmp     $6, $28, $28
	bg      $28, ble_else.18347
	load    2($1), $2
	add     $2, $6, $28
	load    0($28), $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18348
	store   $1, 0($sp)
	store   $6, 1($sp)
	load    3($1), $2
	add     $2, $6, $28
	load    0($28), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.18349
	b       be_cont.18350
be_else.18349:
	load    5($1), $2
	load    7($1), $3
	load    1($1), $4
	load    4($1), $5
	store   $5, 2($sp)
	li      min_caml_diffuse_ray, $5
	add     $2, $6, $28
	load    0($28), $2
	load    0($2), $7
	store   $7, 0($5)
	load    1($2), $7
	store   $7, 1($5)
	load    2($2), $2
	store   $2, 2($5)
	load    6($1), $1
	load    0($1), $1
	add     $3, $6, $28
	load    0($28), $2
	add     $4, $6, $28
	load    0($28), $3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      min_caml_rgb, $1
	load    1($sp), $2
	load    2($sp), $3
	add     $3, $2, $28
	load    0($28), $2
	li      min_caml_diffuse_ray, $3
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     vecaccumv.2920
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18350:
	load    1($sp), $1
	add     $1, 1, $2
	load    0($sp), $1
	b       do_without_neighbors.3236
bge_else.18348:
	ret
ble_else.18347:
	ret
be_else.18346:
	store   $2, 3($sp)
	store   $5, 4($sp)
	store   $3, 5($sp)
	store   $1, 6($sp)
	store   $4, 7($sp)
	store   $6, 1($sp)
	load    3($7), $2
	add     $2, $6, $28
	load    0($28), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.18353
	b       be_cont.18354
be_else.18353:
	mov     $3, $2
	mov     $4, $3
	mov     $5, $4
	mov     $6, $5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18354:
	load    1($sp), $1
	add     $1, 1, $2
	load    6($sp), $1
	load    7($sp), $3
	add     $3, $1, $28
	load    0($28), $4
	li      4, $28
	cmp     $2, $28, $28
	bg      $28, ble_else.18355
	load    2($4), $5
	add     $5, $2, $28
	load    0($28), $5
	cmp     $5, $zero, $28
	bl      $28, bge_else.18356
	add     $3, $1, $28
	load    0($28), $5
	load    2($5), $5
	add     $5, $2, $28
	load    0($28), $5
	load    5($sp), $6
	add     $6, $1, $28
	load    0($28), $7
	load    2($7), $7
	add     $7, $2, $28
	load    0($28), $7
	cmp     $7, $5, $28
	bne     $28, be_else.18357
	load    4($sp), $7
	add     $7, $1, $28
	load    0($28), $7
	load    2($7), $7
	add     $7, $2, $28
	load    0($28), $7
	cmp     $7, $5, $28
	bne     $28, be_else.18359
	sub     $1, 1, $7
	add     $3, $7, $28
	load    0($28), $7
	load    2($7), $7
	add     $7, $2, $28
	load    0($28), $7
	cmp     $7, $5, $28
	bne     $28, be_else.18361
	add     $1, 1, $7
	add     $3, $7, $28
	load    0($28), $7
	load    2($7), $7
	add     $7, $2, $28
	load    0($28), $7
	cmp     $7, $5, $28
	bne     $28, be_else.18363
	li      1, $5
	b       be_cont.18364
be_else.18363:
	li      0, $5
be_cont.18364:
	b       be_cont.18362
be_else.18361:
	li      0, $5
be_cont.18362:
	b       be_cont.18360
be_else.18359:
	li      0, $5
be_cont.18360:
	b       be_cont.18358
be_else.18357:
	li      0, $5
be_cont.18358:
	cmp     $5, $zero, $28
	bne     $28, be_else.18365
	add     $3, $1, $28
	load    0($28), $1
	b       do_without_neighbors.3236
be_else.18365:
	store   $2, 8($sp)
	load    3($4), $4
	add     $4, $2, $28
	load    0($28), $4
	cmp     $4, $zero, $28
	bne     $28, be_else.18366
	b       be_cont.18367
be_else.18366:
	load    4($sp), $4
	mov     $2, $5
	mov     $6, $2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 10, $sp
	load    9($sp), $ra
be_cont.18367:
	load    8($sp), $1
	add     $1, 1, $6
	load    6($sp), $1
	load    3($sp), $2
	load    5($sp), $3
	load    7($sp), $4
	load    4($sp), $5
	b       try_exploit_neighbors.3252
bge_else.18356:
	ret
ble_else.18355:
	ret
bge_else.18337:
	ret
ble_else.18336:
	ret
write_ppm_header.3259:
	li      80, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      54, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      10, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      49, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      56, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      32, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      49, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      56, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      32, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      50, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      53, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      53, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      10, $1
	b       min_caml_write
write_rgb.3263:
	li      min_caml_rgb, $1
	load    0($1), $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18372
	cmp     $1, $zero, $28
	bl      $28, bge_else.18374
	b       bge_cont.18375
bge_else.18374:
	li      0, $1
bge_cont.18375:
	b       ble_cont.18373
ble_else.18372:
	li      255, $1
ble_cont.18373:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      min_caml_rgb, $1
	load    1($1), $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18376
	cmp     $1, $zero, $28
	bl      $28, bge_else.18378
	b       bge_cont.18379
bge_else.18378:
	li      0, $1
bge_cont.18379:
	b       ble_cont.18377
ble_else.18376:
	li      255, $1
ble_cont.18377:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_write
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      min_caml_rgb, $1
	load    2($1), $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_int_of_float
	sub     $sp, 1, $sp
	load    0($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18380
	cmp     $1, $zero, $28
	bl      $28, bge_else.18382
	b       bge_cont.18383
bge_else.18382:
	li      0, $1
bge_cont.18383:
	b       ble_cont.18381
ble_else.18380:
	li      255, $1
ble_cont.18381:
	b       min_caml_write
pretrace_diffuse_rays.3265:
	li      4, $28
	cmp     $2, $28, $28
	bg      $28, ble_else.18384
	load    2($1), $3
	add     $3, $2, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bl      $28, bge_else.18385
	store   $2, 0($sp)
	load    3($1), $3
	add     $3, $2, $28
	load    0($28), $3
	cmp     $3, $zero, $28
	bne     $28, be_else.18386
	b       be_cont.18387
be_else.18386:
	store   $1, 1($sp)
	load    6($1), $3
	load    0($3), $3
	li      min_caml_diffuse_ray, $4
	load    l.13295, $5
	store   $5, 0($4)
	store   $5, 1($4)
	store   $5, 2($4)
	load    7($1), $4
	load    1($1), $1
	li      min_caml_dirvecs, $5
	add     $5, $3, $28
	load    0($28), $3
	store   $3, 2($sp)
	add     $4, $2, $28
	load    0($28), $3
	store   $3, 3($sp)
	add     $1, $2, $28
	load    0($28), $1
	store   $1, 4($sp)
	li      min_caml_startp_fast, $2
	load    0($1), $3
	store   $3, 0($2)
	load    1($1), $3
	store   $3, 1($2)
	load    2($1), $3
	store   $3, 2($2)
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_startp_constants.3116
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      118, $4
	load    2($sp), $1
	load    3($sp), $2
	load    4($sp), $3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_trace_diffuse_rays.3214
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    1($sp), $1
	load    5($1), $2
	load    0($sp), $3
	add     $2, $3, $28
	load    0($28), $2
	li      min_caml_diffuse_ray, $3
	load    0($3), $4
	store   $4, 0($2)
	load    1($3), $4
	store   $4, 1($2)
	load    2($3), $3
	store   $3, 2($2)
be_cont.18387:
	load    0($sp), $2
	add     $2, 1, $2
	b       pretrace_diffuse_rays.3265
bge_else.18385:
	ret
ble_else.18384:
	ret
pretrace_pixels.3268:
	cmp     $2, $zero, $28
	bl      $28, bge_else.18390
	store   $3, 0($sp)
	store   $2, 1($sp)
	store   $1, 2($sp)
	store   $6, 3($sp)
	store   $5, 4($sp)
	store   $4, 5($sp)
	li      min_caml_scan_pitch, $1
	load    0($1), $1
	store   $1, 6($sp)
	li      min_caml_image_center, $1
	load    0($1), $1
	sub     $2, $1, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_float_of_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $2
	fmul    $2, $1, $1
	li      min_caml_ptrace_dirvec, $2
	li      min_caml_screenx_dir, $3
	load    0($3), $3
	fmul    $1, $3, $3
	load    5($sp), $4
	fadd    $3, $4, $3
	store   $3, 0($2)
	li      min_caml_ptrace_dirvec, $2
	li      min_caml_screenx_dir, $3
	load    1($3), $3
	fmul    $1, $3, $3
	load    4($sp), $4
	fadd    $3, $4, $3
	store   $3, 1($2)
	li      min_caml_ptrace_dirvec, $2
	li      min_caml_screenx_dir, $3
	load    2($3), $3
	fmul    $1, $3, $1
	load    3($sp), $3
	fadd    $1, $3, $1
	store   $1, 2($2)
	li      min_caml_ptrace_dirvec, $1
	li      0, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     vecunit_sgn.2896
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $1
	load    l.13295, $2
	store   $2, 0($1)
	store   $2, 1($1)
	store   $2, 2($1)
	li      min_caml_startp, $1
	li      min_caml_viewpoint, $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $2
	store   $2, 2($1)
	li      0, $1
	load    l.13296, $2
	li      min_caml_ptrace_dirvec, $3
	load    1($sp), $4
	load    2($sp), $5
	add     $5, $4, $28
	load    0($28), $4
	load    l.13295, $5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     trace_ray.3205
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    1($sp), $1
	load    2($sp), $2
	add     $2, $1, $28
	load    0($28), $3
	load    0($3), $3
	li      min_caml_rgb, $4
	load    0($4), $5
	store   $5, 0($3)
	load    1($4), $5
	store   $5, 1($3)
	load    2($4), $4
	store   $4, 2($3)
	add     $2, $1, $28
	load    0($28), $3
	load    6($3), $3
	load    0($sp), $4
	store   $4, 0($3)
	add     $2, $1, $28
	load    0($28), $1
	li      0, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     pretrace_diffuse_rays.3265
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    1($sp), $1
	sub     $1, 1, $2
	load    0($sp), $1
	add     $1, 1, $1
	li      5, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.18391
	sub     $1, 5, $1
	b       bge_cont.18392
bge_else.18391:
bge_cont.18392:
	mov     $1, $3
	load    2($sp), $1
	load    5($sp), $4
	load    4($sp), $5
	load    3($sp), $6
	b       pretrace_pixels.3268
bge_else.18390:
	ret
pretrace_line.3275:
	store   $3, 0($sp)
	store   $1, 1($sp)
	li      min_caml_scan_pitch, $1
	load    0($1), $1
	store   $1, 2($sp)
	li      min_caml_image_center, $1
	load    1($1), $1
	sub     $2, $1, $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_float_of_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    2($sp), $2
	fmul    $2, $1, $1
	li      min_caml_screeny_dir, $2
	load    0($2), $2
	fmul    $1, $2, $2
	li      min_caml_screenz_dir, $3
	load    0($3), $3
	fadd    $2, $3, $4
	li      min_caml_screeny_dir, $2
	load    1($2), $2
	fmul    $1, $2, $2
	li      min_caml_screenz_dir, $3
	load    1($3), $3
	fadd    $2, $3, $5
	li      min_caml_screeny_dir, $2
	load    2($2), $2
	fmul    $1, $2, $1
	li      min_caml_screenz_dir, $2
	load    2($2), $2
	fadd    $1, $2, $6
	li      min_caml_image_size, $1
	load    0($1), $1
	sub     $1, 1, $2
	load    1($sp), $1
	load    0($sp), $3
	b       pretrace_pixels.3268
scan_pixel.3279:
	li      min_caml_image_size, $6
	load    0($6), $6
	cmp     $6, $1, $28
	bg      $28, ble_else.18394
	ret
ble_else.18394:
	store   $5, 0($sp)
	store   $3, 1($sp)
	store   $2, 2($sp)
	store   $4, 3($sp)
	store   $1, 4($sp)
	li      min_caml_rgb, $6
	add     $4, $1, $28
	load    0($28), $7
	load    0($7), $7
	load    0($7), $8
	store   $8, 0($6)
	load    1($7), $8
	store   $8, 1($6)
	load    2($7), $7
	store   $7, 2($6)
	li      min_caml_image_size, $6
	load    1($6), $6
	add     $2, 1, $7
	cmp     $6, $7, $28
	bg      $28, ble_else.18396
	li      0, $6
	b       ble_cont.18397
ble_else.18396:
	cmp     $2, $zero, $28
	bg      $28, ble_else.18398
	li      0, $6
	b       ble_cont.18399
ble_else.18398:
	li      min_caml_image_size, $6
	load    0($6), $6
	add     $1, 1, $7
	cmp     $6, $7, $28
	bg      $28, ble_else.18400
	li      0, $6
	b       ble_cont.18401
ble_else.18400:
	cmp     $1, $zero, $28
	bg      $28, ble_else.18402
	li      0, $6
	b       ble_cont.18403
ble_else.18402:
	li      1, $6
ble_cont.18403:
ble_cont.18401:
ble_cont.18399:
ble_cont.18397:
	cmp     $6, $zero, $28
	bne     $28, be_else.18404
	add     $4, $1, $28
	load    0($28), $1
	load    2($1), $2
	load    0($2), $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18406
	store   $1, 5($sp)
	load    3($1), $2
	load    0($2), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.18408
	b       be_cont.18409
be_else.18408:
	load    5($1), $2
	load    7($1), $3
	load    1($1), $4
	load    4($1), $5
	store   $5, 6($sp)
	li      min_caml_diffuse_ray, $5
	load    0($2), $2
	load    0($2), $6
	store   $6, 0($5)
	load    1($2), $6
	store   $6, 1($5)
	load    2($2), $2
	store   $2, 2($5)
	load    6($1), $1
	load    0($1), $1
	load    0($3), $2
	load    0($4), $3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     trace_diffuse_ray_80percent.3223
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $1
	load    6($sp), $2
	load    0($2), $2
	li      min_caml_diffuse_ray, $3
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     vecaccumv.2920
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18409:
	li      1, $2
	load    5($sp), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       bge_cont.18407
bge_else.18406:
bge_cont.18407:
	b       be_cont.18405
be_else.18404:
	li      0, $6
	add     $4, $1, $28
	load    0($28), $7
	load    2($7), $8
	load    0($8), $8
	cmp     $8, $zero, $28
	bl      $28, bge_else.18410
	add     $4, $1, $28
	load    0($28), $8
	load    2($8), $8
	load    0($8), $8
	add     $3, $1, $28
	load    0($28), $9
	load    2($9), $9
	load    0($9), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18412
	add     $5, $1, $28
	load    0($28), $9
	load    2($9), $9
	load    0($9), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18414
	sub     $1, 1, $9
	add     $4, $9, $28
	load    0($28), $9
	load    2($9), $9
	load    0($9), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18416
	add     $1, 1, $9
	add     $4, $9, $28
	load    0($28), $9
	load    2($9), $9
	load    0($9), $9
	cmp     $9, $8, $28
	bne     $28, be_else.18418
	li      1, $8
	b       be_cont.18419
be_else.18418:
	li      0, $8
be_cont.18419:
	b       be_cont.18417
be_else.18416:
	li      0, $8
be_cont.18417:
	b       be_cont.18415
be_else.18414:
	li      0, $8
be_cont.18415:
	b       be_cont.18413
be_else.18412:
	li      0, $8
be_cont.18413:
	cmp     $8, $zero, $28
	bne     $28, be_else.18420
	add     $4, $1, $28
	load    0($28), $1
	mov     $6, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.18421
be_else.18420:
	load    3($7), $2
	load    0($2), $2
	cmp     $2, $zero, $28
	bne     $28, be_else.18422
	b       be_cont.18423
be_else.18422:
	mov     $3, $2
	mov     $4, $3
	mov     $5, $4
	mov     $6, $5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18423:
	li      1, $6
	load    4($sp), $1
	load    2($sp), $2
	load    1($sp), $3
	load    3($sp), $4
	load    0($sp), $5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18421:
	b       bge_cont.18411
bge_else.18410:
bge_cont.18411:
be_cont.18405:
	li      min_caml_rgb, $1
	load    0($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18424
	cmp     $1, $zero, $28
	bl      $28, bge_else.18426
	b       bge_cont.18427
bge_else.18426:
	li      0, $1
bge_cont.18427:
	b       ble_cont.18425
ble_else.18424:
	li      255, $1
ble_cont.18425:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $1
	load    1($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18428
	cmp     $1, $zero, $28
	bl      $28, bge_else.18430
	b       bge_cont.18431
bge_else.18430:
	li      0, $1
bge_cont.18431:
	b       ble_cont.18429
ble_else.18428:
	li      255, $1
ble_cont.18429:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      min_caml_rgb, $1
	load    2($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $28
	cmp     $1, $28, $28
	bg      $28, ble_else.18432
	cmp     $1, $zero, $28
	bl      $28, bge_else.18434
	b       bge_cont.18435
bge_else.18434:
	li      0, $1
bge_cont.18435:
	b       ble_cont.18433
ble_else.18432:
	li      255, $1
ble_cont.18433:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_write
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    4($sp), $1
	add     $1, 1, $1
	li      min_caml_image_size, $2
	load    0($2), $2
	cmp     $2, $1, $28
	bg      $28, ble_else.18436
	ret
ble_else.18436:
	store   $1, 7($sp)
	li      min_caml_rgb, $2
	load    3($sp), $4
	add     $4, $1, $28
	load    0($28), $3
	load    0($3), $3
	load    0($3), $5
	store   $5, 0($2)
	load    1($3), $5
	store   $5, 1($2)
	load    2($3), $3
	store   $3, 2($2)
	li      min_caml_image_size, $2
	load    1($2), $2
	load    2($sp), $3
	add     $3, 1, $5
	cmp     $2, $5, $28
	bg      $28, ble_else.18438
	li      0, $2
	b       ble_cont.18439
ble_else.18438:
	cmp     $3, $zero, $28
	bg      $28, ble_else.18440
	li      0, $2
	b       ble_cont.18441
ble_else.18440:
	li      min_caml_image_size, $2
	load    0($2), $2
	add     $1, 1, $5
	cmp     $2, $5, $28
	bg      $28, ble_else.18442
	li      0, $2
	b       ble_cont.18443
ble_else.18442:
	cmp     $1, $zero, $28
	bg      $28, ble_else.18444
	li      0, $2
	b       ble_cont.18445
ble_else.18444:
	li      1, $2
ble_cont.18445:
ble_cont.18443:
ble_cont.18441:
ble_cont.18439:
	cmp     $2, $zero, $28
	bne     $28, be_else.18446
	add     $4, $1, $28
	load    0($28), $1
	li      0, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18447
be_else.18446:
	li      0, $6
	load    1($sp), $2
	load    0($sp), $5
	mov     $3, $26
	mov     $2, $3
	mov     $26, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18447:
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     write_rgb.3263
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $1
	add     $1, 1, $1
	load    2($sp), $2
	load    1($sp), $3
	load    3($sp), $4
	load    0($sp), $5
	b       scan_pixel.3279
scan_line.3285:
	li      min_caml_image_size, $6
	load    1($6), $6
	cmp     $6, $1, $28
	bg      $28, ble_else.18448
	ret
ble_else.18448:
	store   $2, 0($sp)
	store   $4, 1($sp)
	store   $3, 2($sp)
	store   $5, 3($sp)
	store   $1, 4($sp)
	li      min_caml_image_size, $2
	load    1($2), $2
	sub     $2, 1, $2
	cmp     $2, $1, $28
	bg      $28, ble_else.18450
	b       ble_cont.18451
ble_else.18450:
	add     $1, 1, $2
	mov     $5, $3
	mov     $4, $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     pretrace_line.3275
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18451:
	li      0, $1
	li      min_caml_image_size, $2
	load    0($2), $2
	cmp     $2, $zero, $28
	bg      $28, ble_else.18452
	b       ble_cont.18453
ble_else.18452:
	li      min_caml_rgb, $2
	load    2($sp), $4
	load    0($4), $3
	load    0($3), $3
	load    0($3), $5
	store   $5, 0($2)
	load    1($3), $5
	store   $5, 1($2)
	load    2($3), $3
	store   $3, 2($2)
	li      min_caml_image_size, $2
	load    1($2), $2
	load    4($sp), $3
	add     $3, 1, $5
	cmp     $2, $5, $28
	bg      $28, ble_else.18454
	li      0, $2
	b       ble_cont.18455
ble_else.18454:
	cmp     $3, $zero, $28
	bg      $28, ble_else.18456
	li      0, $2
	b       ble_cont.18457
ble_else.18456:
	li      min_caml_image_size, $2
	load    0($2), $2
	li      1, $28
	cmp     $2, $28, $28
	bg      $28, ble_else.18458
	li      0, $2
	b       ble_cont.18459
ble_else.18458:
	li      0, $2
ble_cont.18459:
ble_cont.18457:
ble_cont.18455:
	cmp     $2, $zero, $28
	bne     $28, be_else.18460
	load    0($4), $1
	li      0, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18461
be_else.18460:
	li      0, $6
	load    0($sp), $2
	load    1($sp), $5
	mov     $3, $26
	mov     $2, $3
	mov     $26, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     try_exploit_neighbors.3252
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18461:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     write_rgb.3263
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      1, $1
	load    4($sp), $2
	load    0($sp), $3
	load    2($sp), $4
	load    1($sp), $5
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     scan_pixel.3279
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18453:
	load    4($sp), $1
	add     $1, 1, $2
	load    3($sp), $1
	add     $1, 2, $1
	li      5, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.18462
	sub     $1, 5, $1
	b       bge_cont.18463
bge_else.18462:
bge_cont.18463:
	mov     $1, $3
	li      min_caml_image_size, $1
	load    1($1), $1
	cmp     $1, $2, $28
	bg      $28, ble_else.18464
	ret
ble_else.18464:
	store   $3, 5($sp)
	store   $2, 6($sp)
	li      min_caml_image_size, $1
	load    1($1), $1
	sub     $1, 1, $1
	cmp     $1, $2, $28
	bg      $28, ble_else.18466
	b       ble_cont.18467
ble_else.18466:
	add     $2, 1, $2
	load    0($sp), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     pretrace_line.3275
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18467:
	li      0, $1
	load    6($sp), $2
	load    2($sp), $3
	load    1($sp), $4
	load    0($sp), $5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     scan_pixel.3279
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $1
	add     $1, 1, $1
	load    5($sp), $2
	add     $2, 2, $2
	li      5, $28
	cmp     $2, $28, $28
	bl      $28, bge_else.18468
	sub     $2, 5, $2
	b       bge_cont.18469
bge_else.18468:
bge_cont.18469:
	mov     $2, $5
	load    1($sp), $2
	load    0($sp), $3
	load    2($sp), $4
	b       scan_line.3285
create_float5x3array.3291:
	li      3, $1
	load    l.13295, $2
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_create_float_array
	sub     $sp, 1, $sp
	load    0($sp), $ra
	mov     $1, $2
	li      5, $1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     min_caml_create_array
	sub     $sp, 1, $sp
	load    0($sp), $ra
	store   $1, 0($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	store   $1, 1($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	store   $1, 2($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	store   $1, 3($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $2
	store   $1, 4($2)
	mov     $2, $1
	ret
init_line_elements.3295:
	cmp     $2, $zero, $28
	bl      $28, bge_else.18470
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	store   $1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     create_float5x3array.3291
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $1, 3($sp)
	li      5, $1
	li      0, $2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $1, 4($sp)
	li      5, $1
	li      0, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     create_float5x3array.3291
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     create_float5x3array.3291
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $1, 7($sp)
	li      1, $1
	li      0, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $1, 8($sp)
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     create_float5x3array.3291
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $2
	add     $hp, 8, $hp
	store   $1, 7($2)
	load    8($sp), $1
	store   $1, 6($2)
	load    7($sp), $1
	store   $1, 5($2)
	load    6($sp), $1
	store   $1, 4($2)
	load    5($sp), $1
	store   $1, 3($2)
	load    4($sp), $1
	store   $1, 2($2)
	load    3($sp), $1
	store   $1, 1($2)
	load    2($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    0($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18471
	store   $1, 9($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_float_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $1, 10($sp)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     create_float5x3array.3291
	sub     $sp, 12, $sp
	load    11($sp), $ra
	store   $1, 11($sp)
	li      5, $1
	li      0, $2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	store   $1, 12($sp)
	li      5, $1
	li      0, $2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     min_caml_create_array
	sub     $sp, 14, $sp
	load    13($sp), $ra
	store   $1, 13($sp)
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     create_float5x3array.3291
	sub     $sp, 15, $sp
	load    14($sp), $ra
	store   $1, 14($sp)
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     create_float5x3array.3291
	sub     $sp, 16, $sp
	load    15($sp), $ra
	store   $1, 15($sp)
	li      1, $1
	li      0, $2
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     min_caml_create_array
	sub     $sp, 17, $sp
	load    16($sp), $ra
	store   $1, 16($sp)
	store   $ra, 17($sp)
	add     $sp, 18, $sp
	jal     create_float5x3array.3291
	sub     $sp, 18, $sp
	load    17($sp), $ra
	mov     $hp, $2
	add     $hp, 8, $hp
	store   $1, 7($2)
	load    16($sp), $1
	store   $1, 6($2)
	load    15($sp), $1
	store   $1, 5($2)
	load    14($sp), $1
	store   $1, 4($2)
	load    13($sp), $1
	store   $1, 3($2)
	load    12($sp), $1
	store   $1, 2($2)
	load    11($sp), $1
	store   $1, 1($2)
	load    10($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    9($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $2
	mov     $3, $1
	b       init_line_elements.3295
bge_else.18471:
	mov     $3, $1
	ret
bge_else.18470:
	ret
tan.3300:
	store   $1, 0($sp)
	load    l.13295, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18472
	load    l.13297, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18474
	load    l.13298, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18476
	load    l.13299, $2
	fcmp    $2, $1, $28
	bg      $28, ble_else.18478
	load    l.13299, $2
	fsub    $1, $2, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.18479
ble_else.18478:
	load    l.13299, $2
	fsub    $2, $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $1, $1
ble_cont.18479:
	b       ble_cont.18477
ble_else.18476:
	load    l.13298, $2
	fsub    $2, $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18477:
	b       ble_cont.18475
ble_else.18474:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18475:
	b       ble_cont.18473
ble_else.18472:
	fneg    $1, $1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $1, $1
ble_cont.18473:
	store   $1, 1($sp)
	load    l.13295, $1
	load    0($sp), $2
	fcmp    $1, $2, $28
	bg      $28, ble_else.18480
	load    l.13297, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.18482
	load    l.13298, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.18484
	load    l.13299, $1
	fcmp    $1, $2, $28
	bg      $28, ble_else.18486
	load    l.13299, $1
	fsub    $2, $1, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.18487
ble_else.18486:
	load    l.13299, $1
	fsub    $1, $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18487:
	b       ble_cont.18485
ble_else.18484:
	load    l.13298, $1
	fsub    $1, $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $1, $1
ble_cont.18485:
	b       ble_cont.18483
ble_else.18482:
	mov     $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18483:
	b       ble_cont.18481
ble_else.18480:
	fneg    $2, $1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18481:
	load    1($sp), $2
	finv    $1, $28
	fmul    $2, $28, $1
	ret
calc_dirvec.3305:
	li      5, $28
	cmp     $1, $28, $28
	bl      $28, bge_else.18488
	store   $7, 0($sp)
	store   $6, 1($sp)
	store   $3, 2($sp)
	store   $2, 3($sp)
	fmul    $2, $2, $1
	fmul    $3, $3, $2
	fadd    $1, $2, $1
	load    l.13296, $2
	fadd    $1, $2, $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     sqrt.2865
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $2
	finv    $1, $28
	fmul    $2, $28, $2
	load    2($sp), $3
	finv    $1, $28
	fmul    $3, $28, $3
	load    l.13296, $4
	finv    $1, $28
	fmul    $4, $28, $1
	li      min_caml_dirvecs, $4
	load    1($sp), $5
	add     $4, $5, $28
	load    0($28), $4
	load    0($sp), $5
	add     $4, $5, $28
	load    0($28), $6
	load    0($6), $6
	store   $2, 0($6)
	store   $3, 1($6)
	store   $1, 2($6)
	add     $5, 40, $6
	add     $4, $6, $28
	load    0($28), $6
	load    0($6), $6
	fneg    $3, $7
	store   $2, 0($6)
	store   $1, 1($6)
	store   $7, 2($6)
	add     $5, 80, $6
	add     $4, $6, $28
	load    0($28), $6
	load    0($6), $6
	fneg    $2, $7
	fneg    $3, $8
	store   $1, 0($6)
	store   $7, 1($6)
	store   $8, 2($6)
	add     $5, 1, $6
	add     $4, $6, $28
	load    0($28), $6
	load    0($6), $6
	fneg    $2, $7
	fneg    $3, $8
	fneg    $1, $9
	store   $7, 0($6)
	store   $8, 1($6)
	store   $9, 2($6)
	add     $5, 41, $6
	add     $4, $6, $28
	load    0($28), $6
	load    0($6), $6
	fneg    $2, $7
	fneg    $1, $8
	store   $7, 0($6)
	store   $8, 1($6)
	store   $3, 2($6)
	add     $5, 81, $5
	add     $4, $5, $28
	load    0($28), $4
	load    0($4), $4
	fneg    $1, $1
	store   $1, 0($4)
	store   $2, 1($4)
	store   $3, 2($4)
	ret
bge_else.18488:
	store   $7, 0($sp)
	store   $6, 1($sp)
	store   $5, 4($sp)
	store   $1, 5($sp)
	store   $4, 6($sp)
	fmul    $3, $3, $1
	load    l.13336, $2
	fadd    $1, $2, $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $1, 7($sp)
	load    l.13296, $2
	finv    $1, $28
	fmul    $2, $28, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_atan.2855
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $2
	fmul    $1, $2, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     tan.3300
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $2
	fmul    $1, $2, $1
	store   $1, 8($sp)
	load    5($sp), $2
	add     $2, 1, $2
	store   $2, 9($sp)
	fmul    $1, $1, $1
	load    l.13336, $2
	fadd    $1, $2, $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     sqrt.2865
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $1, 10($sp)
	load    l.13296, $2
	finv    $1, $28
	fmul    $2, $28, $1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     cordic_atan.2855
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    4($sp), $2
	fmul    $1, $2, $1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     tan.3300
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    10($sp), $2
	fmul    $1, $2, $3
	load    9($sp), $1
	load    8($sp), $2
	load    6($sp), $4
	load    4($sp), $5
	load    1($sp), $6
	load    0($sp), $7
	b       calc_dirvec.3305
calc_dirvecs.3313:
	cmp     $1, $zero, $28
	bl      $28, bge_else.18490
	store   $1, 0($sp)
	store   $4, 1($sp)
	store   $3, 2($sp)
	store   $2, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_float_of_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    l.13357, $2
	fmul    $1, $2, $1
	load    l.13358, $2
	fsub    $1, $2, $4
	li      0, $1
	load    l.13295, $2
	load    l.13295, $3
	load    3($sp), $5
	load    2($sp), $6
	load    1($sp), $7
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     calc_dirvec.3305
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_float_of_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    l.13357, $2
	fmul    $1, $2, $1
	load    l.13336, $2
	fadd    $1, $2, $4
	li      0, $1
	load    l.13295, $2
	load    l.13295, $3
	load    1($sp), $5
	add     $5, 2, $7
	load    3($sp), $5
	load    2($sp), $6
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     calc_dirvec.3305
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $1
	sub     $1, 1, $1
	load    2($sp), $2
	add     $2, 1, $2
	li      5, $28
	cmp     $2, $28, $28
	bl      $28, bge_else.18491
	sub     $2, 5, $2
	b       bge_cont.18492
bge_else.18491:
bge_cont.18492:
	mov     $2, $3
	load    3($sp), $2
	load    1($sp), $4
	b       calc_dirvecs.3313
bge_else.18490:
	ret
calc_dirvec_rows.3318:
	cmp     $1, $zero, $28
	bl      $28, bge_else.18494
	store   $1, 0($sp)
	store   $3, 1($sp)
	store   $2, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_float_of_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    l.13357, $2
	fmul    $1, $2, $1
	load    l.13358, $2
	fsub    $1, $2, $2
	li      4, $1
	load    2($sp), $3
	load    1($sp), $4
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     calc_dirvecs.3313
	sub     $sp, 4, $sp
	load    3($sp), $ra
	load    0($sp), $1
	sub     $1, 1, $1
	load    2($sp), $2
	add     $2, 2, $2
	li      5, $28
	cmp     $2, $28, $28
	bl      $28, bge_else.18495
	sub     $2, 5, $2
	b       bge_cont.18496
bge_else.18495:
bge_cont.18496:
	load    1($sp), $3
	add     $3, 4, $3
	cmp     $1, $zero, $28
	bl      $28, bge_else.18497
	store   $1, 3($sp)
	store   $3, 4($sp)
	store   $2, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_float_of_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    l.13357, $2
	fmul    $1, $2, $1
	load    l.13358, $2
	fsub    $1, $2, $2
	li      4, $1
	load    5($sp), $3
	load    4($sp), $4
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     calc_dirvecs.3313
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    3($sp), $1
	sub     $1, 1, $1
	load    5($sp), $2
	add     $2, 2, $2
	li      5, $28
	cmp     $2, $28, $28
	bl      $28, bge_else.18498
	sub     $2, 5, $2
	b       bge_cont.18499
bge_else.18498:
bge_cont.18499:
	load    4($sp), $3
	add     $3, 4, $3
	b       calc_dirvec_rows.3318
bge_else.18497:
	ret
bge_else.18494:
	ret
create_dirvec_elements.3324:
	cmp     $2, $zero, $28
	bl      $28, bge_else.18502
	store   $2, 0($sp)
	store   $1, 1($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	mov     $1, $2
	store   $2, 2($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    2($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    0($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18503
	store   $1, 3($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_float_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	mov     $1, $2
	store   $2, 4($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    4($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    3($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18504
	store   $1, 5($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $1, $2
	store   $2, 6($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    6($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    5($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18505
	store   $1, 7($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $1, $2
	store   $2, 8($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    8($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    7($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	sub     $2, 1, $2
	mov     $3, $1
	b       create_dirvec_elements.3324
bge_else.18505:
	ret
bge_else.18504:
	ret
bge_else.18503:
	ret
bge_else.18502:
	ret
create_dirvecs.3327:
	cmp     $1, $zero, $28
	bl      $28, bge_else.18510
	store   $1, 0($sp)
	li      min_caml_dirvecs, $1
	store   $1, 1($sp)
	li      120, $1
	store   $1, 2($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_float_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	mov     $1, $2
	store   $2, 3($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    3($sp), $1
	store   $1, 0($2)
	load    2($sp), $1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_create_array
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    0($sp), $2
	load    1($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	li      min_caml_dirvecs, $1
	add     $1, $2, $28
	load    0($28), $1
	store   $1, 4($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_float_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	mov     $1, $2
	store   $2, 5($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    5($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    4($sp), $2
	store   $1, 118($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $1, $2
	store   $2, 6($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    6($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    4($sp), $2
	store   $1, 117($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_float_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $1, $2
	store   $2, 7($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    7($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    4($sp), $2
	store   $1, 116($2)
	li      115, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     create_dirvec_elements.3324
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    0($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18511
	store   $1, 8($sp)
	li      min_caml_dirvecs, $1
	store   $1, 9($sp)
	li      120, $1
	store   $1, 10($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_create_float_array
	sub     $sp, 12, $sp
	load    11($sp), $ra
	mov     $1, $2
	store   $2, 11($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    11($sp), $1
	store   $1, 0($2)
	load    10($sp), $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    8($sp), $2
	load    9($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	li      min_caml_dirvecs, $1
	add     $1, $2, $28
	load    0($28), $1
	store   $1, 12($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     min_caml_create_float_array
	sub     $sp, 14, $sp
	load    13($sp), $ra
	mov     $1, $2
	store   $2, 13($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    13($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    12($sp), $2
	store   $1, 118($2)
	li      3, $1
	load    l.13295, $2
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_float_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	mov     $1, $2
	store   $2, 14($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    14($sp), $1
	store   $1, 0($2)
	mov     $2, $1
	load    12($sp), $2
	store   $1, 117($2)
	li      116, $1
	mov     $2, $26
	mov     $1, $2
	mov     $26, $1
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     create_dirvec_elements.3324
	sub     $sp, 16, $sp
	load    15($sp), $ra
	load    8($sp), $1
	sub     $1, 1, $1
	b       create_dirvecs.3327
bge_else.18511:
	ret
bge_else.18510:
	ret
init_dirvec_constants.3329:
	cmp     $2, $zero, $28
	bl      $28, bge_else.18514
	store   $1, 0($sp)
	store   $2, 1($sp)
	add     $1, $2, $28
	load    0($28), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18515
	store   $1, 2($sp)
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18516
	store   $1, 3($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18518
	store   $2, 4($sp)
	store   $4, 5($sp)
	mov     $3, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_rect_table.3102
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $2
	load    5($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18519
be_else.18518:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18520
	store   $2, 4($sp)
	store   $4, 5($sp)
	mov     $3, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_surface_table.3105
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $2
	load    5($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18521
be_else.18520:
	store   $2, 4($sp)
	store   $4, 5($sp)
	mov     $3, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     setup_second_table.3108
	sub     $sp, 7, $sp
	load    6($sp), $ra
	load    4($sp), $2
	load    5($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18521:
be_cont.18519:
	sub     $2, 1, $2
	load    3($sp), $1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       bge_cont.18517
bge_else.18516:
bge_cont.18517:
	load    2($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18522
	store   $1, 6($sp)
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18523
	store   $1, 7($sp)
	load    0($sp), $2
	add     $2, $1, $28
	load    0($28), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18524
	store   $1, 8($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18526
	store   $2, 9($sp)
	store   $4, 10($sp)
	mov     $3, $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_rect_table.3102
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $2
	load    10($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18527
be_else.18526:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18528
	store   $2, 9($sp)
	store   $4, 10($sp)
	mov     $3, $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_surface_table.3105
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $2
	load    10($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18529
be_else.18528:
	store   $2, 9($sp)
	store   $4, 10($sp)
	mov     $3, $2
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     setup_second_table.3108
	sub     $sp, 12, $sp
	load    11($sp), $ra
	load    9($sp), $2
	load    10($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18529:
be_cont.18527:
	sub     $2, 1, $2
	load    8($sp), $1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 12, $sp
	load    11($sp), $ra
	b       bge_cont.18525
bge_else.18524:
bge_cont.18525:
	load    7($sp), $1
	sub     $1, 1, $2
	load    0($sp), $1
	b       init_dirvec_constants.3329
bge_else.18523:
	ret
bge_else.18522:
	ret
bge_else.18515:
	ret
bge_else.18514:
	ret
init_vecset_constants.3332:
	cmp     $1, $zero, $28
	bl      $28, bge_else.18534
	store   $1, 0($sp)
	li      min_caml_dirvecs, $2
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 1($sp)
	load    119($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18535
	store   $1, 2($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18537
	store   $2, 3($sp)
	store   $4, 4($sp)
	mov     $3, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_rect_table.3102
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18538
be_else.18537:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18539
	store   $2, 3($sp)
	store   $4, 4($sp)
	mov     $3, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_surface_table.3105
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18540
be_else.18539:
	store   $2, 3($sp)
	store   $4, 4($sp)
	mov     $3, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     setup_second_table.3108
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    3($sp), $2
	load    4($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18540:
be_cont.18538:
	sub     $2, 1, $2
	load    2($sp), $1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       bge_cont.18536
bge_else.18535:
bge_cont.18536:
	load    1($sp), $1
	load    118($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 6, $sp
	load    5($sp), $ra
	load    1($sp), $1
	load    117($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18541
	store   $1, 5($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18543
	store   $2, 6($sp)
	store   $4, 7($sp)
	mov     $3, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_rect_table.3102
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $2
	load    7($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18544
be_else.18543:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18545
	store   $2, 6($sp)
	store   $4, 7($sp)
	mov     $3, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_surface_table.3105
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $2
	load    7($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18546
be_else.18545:
	store   $2, 6($sp)
	store   $4, 7($sp)
	mov     $3, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     setup_second_table.3108
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    6($sp), $2
	load    7($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18546:
be_cont.18544:
	sub     $2, 1, $2
	load    5($sp), $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       bge_cont.18542
bge_else.18541:
bge_cont.18542:
	li      116, $2
	load    1($sp), $1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    0($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18547
	store   $1, 8($sp)
	li      min_caml_dirvecs, $2
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 9($sp)
	load    119($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    9($sp), $1
	load    118($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18548
	store   $1, 10($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18550
	store   $2, 11($sp)
	store   $4, 12($sp)
	mov     $3, $2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_rect_table.3102
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $2
	load    12($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18551
be_else.18550:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18552
	store   $2, 11($sp)
	store   $4, 12($sp)
	mov     $3, $2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_surface_table.3105
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $2
	load    12($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18553
be_else.18552:
	store   $2, 11($sp)
	store   $4, 12($sp)
	mov     $3, $2
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     setup_second_table.3108
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    11($sp), $2
	load    12($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18553:
be_cont.18551:
	sub     $2, 1, $2
	load    10($sp), $1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 14, $sp
	load    13($sp), $ra
	b       bge_cont.18549
bge_else.18548:
bge_cont.18549:
	li      117, $2
	load    9($sp), $1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    8($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18554
	store   $1, 13($sp)
	li      min_caml_dirvecs, $2
	add     $2, $1, $28
	load    0($28), $1
	store   $1, 14($sp)
	load    119($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18555
	store   $1, 15($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18557
	store   $2, 16($sp)
	store   $4, 17($sp)
	mov     $3, $2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_rect_table.3102
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $2
	load    17($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18558
be_else.18557:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18559
	store   $2, 16($sp)
	store   $4, 17($sp)
	mov     $3, $2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_surface_table.3105
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $2
	load    17($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18560
be_else.18559:
	store   $2, 16($sp)
	store   $4, 17($sp)
	mov     $3, $2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     setup_second_table.3108
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    16($sp), $2
	load    17($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18560:
be_cont.18558:
	sub     $2, 1, $2
	load    15($sp), $1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 19, $sp
	load    18($sp), $ra
	b       bge_cont.18556
bge_else.18555:
bge_cont.18556:
	li      118, $2
	load    14($sp), $1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    13($sp), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18561
	store   $1, 18($sp)
	li      min_caml_dirvecs, $2
	add     $2, $1, $28
	load    0($28), $1
	li      119, $2
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    18($sp), $1
	sub     $1, 1, $1
	b       init_vecset_constants.3332
bge_else.18561:
	ret
bge_else.18554:
	ret
bge_else.18547:
	ret
bge_else.18534:
	ret
setup_rect_reflection.3343:
	sll     $1, 2, $1
	store   $1, 0($sp)
	li      min_caml_n_reflections, $3
	load    0($3), $3
	store   $3, 1($sp)
	load    l.13296, $3
	load    7($2), $2
	load    0($2), $2
	fsub    $3, $2, $2
	store   $2, 2($sp)
	li      min_caml_light, $2
	load    0($2), $2
	fneg    $2, $2
	store   $2, 3($sp)
	li      min_caml_light, $2
	load    1($2), $2
	fneg    $2, $2
	store   $2, 4($sp)
	li      min_caml_light, $2
	load    2($2), $2
	fneg    $2, $2
	store   $2, 5($sp)
	add     $1, 1, $1
	store   $1, 6($sp)
	li      min_caml_light, $1
	load    0($1), $1
	store   $1, 7($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_float_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	mov     $1, $2
	store   $2, 8($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    8($sp), $3
	store   $3, 0($2)
	store   $2, 9($sp)
	load    7($sp), $4
	store   $4, 0($3)
	load    4($sp), $4
	store   $4, 1($3)
	load    5($sp), $4
	store   $4, 2($3)
	li      min_caml_n_objects, $4
	load    0($4), $4
	sub     $4, 1, $4
	cmp     $4, $zero, $28
	bl      $28, bge_else.18566
	li      min_caml_objects, $2
	add     $2, $4, $28
	load    0($28), $2
	load    1($2), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18568
	store   $4, 10($sp)
	store   $1, 11($sp)
	mov     $3, $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_rect_table.3102
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $2
	load    11($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18569
be_else.18568:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18570
	store   $4, 10($sp)
	store   $1, 11($sp)
	mov     $3, $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_surface_table.3105
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $2
	load    11($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18571
be_else.18570:
	store   $4, 10($sp)
	store   $1, 11($sp)
	mov     $3, $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     setup_second_table.3108
	sub     $sp, 13, $sp
	load    12($sp), $ra
	load    10($sp), $2
	load    11($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18571:
be_cont.18569:
	sub     $2, 1, $2
	load    9($sp), $1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       bge_cont.18567
bge_else.18566:
bge_cont.18567:
	li      min_caml_reflections, $1
	mov     $hp, $2
	add     $hp, 3, $hp
	load    2($sp), $3
	store   $3, 2($2)
	load    9($sp), $3
	store   $3, 1($2)
	load    6($sp), $3
	store   $3, 0($2)
	load    1($sp), $3
	add     $1, $3, $28
	store   $2, 0($28)
	add     $3, 1, $1
	store   $1, 12($sp)
	load    0($sp), $1
	add     $1, 2, $1
	store   $1, 13($sp)
	li      min_caml_light, $1
	load    1($1), $1
	store   $1, 14($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_float_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	mov     $1, $2
	store   $2, 15($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     min_caml_create_array
	sub     $sp, 17, $sp
	load    16($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    15($sp), $3
	store   $3, 0($2)
	store   $2, 16($sp)
	load    3($sp), $4
	store   $4, 0($3)
	load    14($sp), $4
	store   $4, 1($3)
	load    5($sp), $4
	store   $4, 2($3)
	li      min_caml_n_objects, $4
	load    0($4), $4
	sub     $4, 1, $4
	cmp     $4, $zero, $28
	bl      $28, bge_else.18572
	li      min_caml_objects, $2
	add     $2, $4, $28
	load    0($28), $2
	load    1($2), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18574
	store   $4, 17($sp)
	store   $1, 18($sp)
	mov     $3, $1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_rect_table.3102
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $2
	load    18($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18575
be_else.18574:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18576
	store   $4, 17($sp)
	store   $1, 18($sp)
	mov     $3, $1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_surface_table.3105
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $2
	load    18($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18577
be_else.18576:
	store   $4, 17($sp)
	store   $1, 18($sp)
	mov     $3, $1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     setup_second_table.3108
	sub     $sp, 20, $sp
	load    19($sp), $ra
	load    17($sp), $2
	load    18($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18577:
be_cont.18575:
	sub     $2, 1, $2
	load    16($sp), $1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 20, $sp
	load    19($sp), $ra
	b       bge_cont.18573
bge_else.18572:
bge_cont.18573:
	li      min_caml_reflections, $1
	mov     $hp, $2
	add     $hp, 3, $hp
	load    2($sp), $3
	store   $3, 2($2)
	load    16($sp), $3
	store   $3, 1($2)
	load    13($sp), $3
	store   $3, 0($2)
	load    12($sp), $3
	add     $1, $3, $28
	store   $2, 0($28)
	load    1($sp), $1
	add     $1, 2, $1
	store   $1, 19($sp)
	load    0($sp), $1
	add     $1, 3, $1
	store   $1, 20($sp)
	li      min_caml_light, $1
	load    2($1), $1
	store   $1, 21($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 22($sp)
	add     $sp, 23, $sp
	jal     min_caml_create_float_array
	sub     $sp, 23, $sp
	load    22($sp), $ra
	mov     $1, $2
	store   $2, 22($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 23($sp)
	add     $sp, 24, $sp
	jal     min_caml_create_array
	sub     $sp, 24, $sp
	load    23($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    22($sp), $3
	store   $3, 0($2)
	store   $2, 23($sp)
	load    3($sp), $4
	store   $4, 0($3)
	load    4($sp), $4
	store   $4, 1($3)
	load    21($sp), $4
	store   $4, 2($3)
	li      min_caml_n_objects, $4
	load    0($4), $4
	sub     $4, 1, $4
	cmp     $4, $zero, $28
	bl      $28, bge_else.18578
	li      min_caml_objects, $2
	add     $2, $4, $28
	load    0($28), $2
	load    1($2), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18580
	store   $4, 24($sp)
	store   $1, 25($sp)
	mov     $3, $1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_rect_table.3102
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $2
	load    25($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18581
be_else.18580:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18582
	store   $4, 24($sp)
	store   $1, 25($sp)
	mov     $3, $1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_surface_table.3105
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $2
	load    25($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18583
be_else.18582:
	store   $4, 24($sp)
	store   $1, 25($sp)
	mov     $3, $1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     setup_second_table.3108
	sub     $sp, 27, $sp
	load    26($sp), $ra
	load    24($sp), $2
	load    25($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18583:
be_cont.18581:
	sub     $2, 1, $2
	load    23($sp), $1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 27, $sp
	load    26($sp), $ra
	b       bge_cont.18579
bge_else.18578:
bge_cont.18579:
	li      min_caml_reflections, $1
	mov     $hp, $2
	add     $hp, 3, $hp
	load    2($sp), $3
	store   $3, 2($2)
	load    23($sp), $3
	store   $3, 1($2)
	load    20($sp), $3
	store   $3, 0($2)
	load    19($sp), $3
	add     $1, $3, $28
	store   $2, 0($28)
	li      min_caml_n_reflections, $1
	load    1($sp), $2
	add     $2, 3, $2
	store   $2, 0($1)
	ret
setup_surface_reflection.3346:
	sll     $1, 2, $1
	add     $1, 1, $1
	store   $1, 0($sp)
	li      min_caml_n_reflections, $1
	load    0($1), $1
	store   $1, 1($sp)
	load    l.13296, $1
	load    7($2), $3
	load    0($3), $3
	fsub    $1, $3, $1
	store   $1, 2($sp)
	li      min_caml_light, $1
	load    4($2), $3
	load    0($1), $4
	load    0($3), $5
	fmul    $4, $5, $4
	load    1($1), $5
	load    1($3), $6
	fmul    $5, $6, $5
	fadd    $4, $5, $4
	load    2($1), $1
	load    2($3), $3
	fmul    $1, $3, $1
	fadd    $4, $1, $1
	load    l.13300, $3
	load    4($2), $4
	load    0($4), $4
	fmul    $3, $4, $3
	fmul    $3, $1, $3
	li      min_caml_light, $4
	load    0($4), $4
	fsub    $3, $4, $3
	store   $3, 3($sp)
	load    l.13300, $3
	load    4($2), $4
	load    1($4), $4
	fmul    $3, $4, $3
	fmul    $3, $1, $3
	li      min_caml_light, $4
	load    1($4), $4
	fsub    $3, $4, $3
	store   $3, 4($sp)
	load    l.13300, $3
	load    4($2), $2
	load    2($2), $2
	fmul    $3, $2, $2
	fmul    $2, $1, $1
	li      min_caml_light, $2
	load    2($2), $2
	fsub    $1, $2, $1
	store   $1, 5($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_float_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	mov     $1, $2
	store   $2, 6($sp)
	li      min_caml_n_objects, $1
	load    0($1), $1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	mov     $hp, $2
	add     $hp, 2, $hp
	store   $1, 1($2)
	load    6($sp), $3
	store   $3, 0($2)
	store   $2, 7($sp)
	load    3($sp), $4
	store   $4, 0($3)
	load    4($sp), $4
	store   $4, 1($3)
	load    5($sp), $4
	store   $4, 2($3)
	li      min_caml_n_objects, $4
	load    0($4), $4
	sub     $4, 1, $4
	cmp     $4, $zero, $28
	bl      $28, bge_else.18585
	li      min_caml_objects, $2
	add     $2, $4, $28
	load    0($28), $2
	load    1($2), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18587
	store   $4, 8($sp)
	store   $1, 9($sp)
	mov     $3, $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_rect_table.3102
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $2
	load    9($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18588
be_else.18587:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18589
	store   $4, 8($sp)
	store   $1, 9($sp)
	mov     $3, $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_surface_table.3105
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $2
	load    9($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18590
be_else.18589:
	store   $4, 8($sp)
	store   $1, 9($sp)
	mov     $3, $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     setup_second_table.3108
	sub     $sp, 11, $sp
	load    10($sp), $ra
	load    8($sp), $2
	load    9($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18590:
be_cont.18588:
	sub     $2, 1, $2
	load    7($sp), $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 11, $sp
	load    10($sp), $ra
	b       bge_cont.18586
bge_else.18585:
bge_cont.18586:
	li      min_caml_reflections, $1
	mov     $hp, $2
	add     $hp, 3, $hp
	load    2($sp), $3
	store   $3, 2($2)
	load    7($sp), $3
	store   $3, 1($2)
	load    0($sp), $3
	store   $3, 0($2)
	load    1($sp), $3
	add     $1, $3, $28
	store   $2, 0($28)
	li      min_caml_n_reflections, $1
	add     $3, 1, $2
	store   $2, 0($1)
	ret
rt.3351:
	li      min_caml_image_size, $3
	store   $1, 0($3)
	li      min_caml_image_size, $3
	store   $2, 1($3)
	li      min_caml_image_center, $3
	srl     $1, 1, $4
	store   $4, 0($3)
	li      min_caml_image_center, $3
	srl     $2, 1, $2
	store   $2, 1($3)
	li      min_caml_scan_pitch, $2
	store   $2, 0($sp)
	load    l.13420, $2
	store   $2, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_float_of_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $2
	finv    $1, $28
	fmul    $2, $28, $1
	load    0($sp), $2
	store   $1, 0($2)
	li      min_caml_image_size, $1
	load    0($1), $1
	store   $1, 2($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_float_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	store   $1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     create_float5x3array.3291
	sub     $sp, 5, $sp
	load    4($sp), $ra
	store   $1, 4($sp)
	li      5, $1
	li      0, $2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	store   $1, 5($sp)
	li      5, $1
	li      0, $2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	store   $1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     create_float5x3array.3291
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $1, 7($sp)
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     create_float5x3array.3291
	sub     $sp, 9, $sp
	load    8($sp), $ra
	store   $1, 8($sp)
	li      1, $1
	li      0, $2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     min_caml_create_array
	sub     $sp, 10, $sp
	load    9($sp), $ra
	store   $1, 9($sp)
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     create_float5x3array.3291
	sub     $sp, 11, $sp
	load    10($sp), $ra
	mov     $hp, $2
	add     $hp, 8, $hp
	store   $1, 7($2)
	load    9($sp), $1
	store   $1, 6($2)
	load    8($sp), $1
	store   $1, 5($2)
	load    7($sp), $1
	store   $1, 4($2)
	load    6($sp), $1
	store   $1, 3($2)
	load    5($sp), $1
	store   $1, 2($2)
	load    4($sp), $1
	store   $1, 1($2)
	load    3($sp), $1
	store   $1, 0($2)
	load    2($sp), $1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	li      min_caml_image_size, $2
	load    0($2), $2
	sub     $2, 2, $2
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     init_line_elements.3295
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $1, 10($sp)
	li      min_caml_image_size, $1
	load    0($1), $1
	store   $1, 11($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     min_caml_create_float_array
	sub     $sp, 13, $sp
	load    12($sp), $ra
	store   $1, 12($sp)
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     create_float5x3array.3291
	sub     $sp, 14, $sp
	load    13($sp), $ra
	store   $1, 13($sp)
	li      5, $1
	li      0, $2
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_create_array
	sub     $sp, 15, $sp
	load    14($sp), $ra
	store   $1, 14($sp)
	li      5, $1
	li      0, $2
	store   $ra, 15($sp)
	add     $sp, 16, $sp
	jal     min_caml_create_array
	sub     $sp, 16, $sp
	load    15($sp), $ra
	store   $1, 15($sp)
	store   $ra, 16($sp)
	add     $sp, 17, $sp
	jal     create_float5x3array.3291
	sub     $sp, 17, $sp
	load    16($sp), $ra
	store   $1, 16($sp)
	store   $ra, 17($sp)
	add     $sp, 18, $sp
	jal     create_float5x3array.3291
	sub     $sp, 18, $sp
	load    17($sp), $ra
	store   $1, 17($sp)
	li      1, $1
	li      0, $2
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     min_caml_create_array
	sub     $sp, 19, $sp
	load    18($sp), $ra
	store   $1, 18($sp)
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     create_float5x3array.3291
	sub     $sp, 20, $sp
	load    19($sp), $ra
	mov     $hp, $2
	add     $hp, 8, $hp
	store   $1, 7($2)
	load    18($sp), $1
	store   $1, 6($2)
	load    17($sp), $1
	store   $1, 5($2)
	load    16($sp), $1
	store   $1, 4($2)
	load    15($sp), $1
	store   $1, 3($2)
	load    14($sp), $1
	store   $1, 2($2)
	load    13($sp), $1
	store   $1, 1($2)
	load    12($sp), $1
	store   $1, 0($2)
	load    11($sp), $1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     min_caml_create_array
	sub     $sp, 20, $sp
	load    19($sp), $ra
	li      min_caml_image_size, $2
	load    0($2), $2
	sub     $2, 2, $2
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     init_line_elements.3295
	sub     $sp, 20, $sp
	load    19($sp), $ra
	store   $1, 19($sp)
	li      min_caml_image_size, $1
	load    0($1), $1
	store   $1, 20($sp)
	li      3, $1
	load    l.13295, $2
	store   $ra, 21($sp)
	add     $sp, 22, $sp
	jal     min_caml_create_float_array
	sub     $sp, 22, $sp
	load    21($sp), $ra
	store   $1, 21($sp)
	store   $ra, 22($sp)
	add     $sp, 23, $sp
	jal     create_float5x3array.3291
	sub     $sp, 23, $sp
	load    22($sp), $ra
	store   $1, 22($sp)
	li      5, $1
	li      0, $2
	store   $ra, 23($sp)
	add     $sp, 24, $sp
	jal     min_caml_create_array
	sub     $sp, 24, $sp
	load    23($sp), $ra
	store   $1, 23($sp)
	li      5, $1
	li      0, $2
	store   $ra, 24($sp)
	add     $sp, 25, $sp
	jal     min_caml_create_array
	sub     $sp, 25, $sp
	load    24($sp), $ra
	store   $1, 24($sp)
	store   $ra, 25($sp)
	add     $sp, 26, $sp
	jal     create_float5x3array.3291
	sub     $sp, 26, $sp
	load    25($sp), $ra
	store   $1, 25($sp)
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     create_float5x3array.3291
	sub     $sp, 27, $sp
	load    26($sp), $ra
	store   $1, 26($sp)
	li      1, $1
	li      0, $2
	store   $ra, 27($sp)
	add     $sp, 28, $sp
	jal     min_caml_create_array
	sub     $sp, 28, $sp
	load    27($sp), $ra
	store   $1, 27($sp)
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     create_float5x3array.3291
	sub     $sp, 29, $sp
	load    28($sp), $ra
	mov     $hp, $2
	add     $hp, 8, $hp
	store   $1, 7($2)
	load    27($sp), $1
	store   $1, 6($2)
	load    26($sp), $1
	store   $1, 5($2)
	load    25($sp), $1
	store   $1, 4($2)
	load    24($sp), $1
	store   $1, 3($2)
	load    23($sp), $1
	store   $1, 2($2)
	load    22($sp), $1
	store   $1, 1($2)
	load    21($sp), $1
	store   $1, 0($2)
	load    20($sp), $1
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     min_caml_create_array
	sub     $sp, 29, $sp
	load    28($sp), $ra
	li      min_caml_image_size, $2
	load    0($2), $2
	sub     $2, 2, $2
	store   $ra, 28($sp)
	add     $sp, 29, $sp
	jal     init_line_elements.3295
	sub     $sp, 29, $sp
	load    28($sp), $ra
	store   $1, 28($sp)
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
	li      0, $1
	store   $1, 29($sp)
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_nth_object.3004
	sub     $sp, 31, $sp
	load    30($sp), $ra
	cmp     $1, $zero, $28
	bne     $28, be_else.18592
	li      min_caml_n_objects, $1
	load    29($sp), $2
	store   $2, 0($1)
	b       be_cont.18593
be_else.18592:
	li      1, $1
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_object.3006
	sub     $sp, 31, $sp
	load    30($sp), $ra
be_cont.18593:
	li      0, $1
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_and_network.3014
	sub     $sp, 31, $sp
	load    30($sp), $ra
	li      min_caml_or_net, $1
	store   $1, 30($sp)
	li      0, $1
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     read_or_network.3012
	sub     $sp, 32, $sp
	load    31($sp), $ra
	load    30($sp), $2
	store   $1, 0($2)
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     write_ppm_header.3259
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      4, $1
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     create_dirvecs.3327
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      9, $1
	li      0, $2
	li      0, $3
	store   $ra, 31($sp)
	add     $sp, 32, $sp
	jal     calc_dirvec_rows.3318
	sub     $sp, 32, $sp
	load    31($sp), $ra
	li      min_caml_dirvecs, $1
	load    4($1), $1
	store   $1, 31($sp)
	load    119($1), $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	cmp     $2, $zero, $28
	bl      $28, bge_else.18594
	store   $1, 32($sp)
	li      min_caml_objects, $3
	add     $3, $2, $28
	load    0($28), $3
	load    1($1), $4
	load    0($1), $1
	load    1($3), $5
	li      1, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18596
	store   $2, 33($sp)
	store   $4, 34($sp)
	mov     $3, $2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_rect_table.3102
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $2
	load    34($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18597
be_else.18596:
	li      2, $28
	cmp     $5, $28, $28
	bne     $28, be_else.18598
	store   $2, 33($sp)
	store   $4, 34($sp)
	mov     $3, $2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_surface_table.3105
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $2
	load    34($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
	b       be_cont.18599
be_else.18598:
	store   $2, 33($sp)
	store   $4, 34($sp)
	mov     $3, $2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_second_table.3108
	sub     $sp, 36, $sp
	load    35($sp), $ra
	load    33($sp), $2
	load    34($sp), $3
	add     $3, $2, $28
	store   $1, 0($28)
be_cont.18599:
be_cont.18597:
	sub     $2, 1, $2
	load    32($sp), $1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       bge_cont.18595
bge_else.18594:
bge_cont.18595:
	li      118, $2
	load    31($sp), $1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_dirvecs, $1
	load    3($1), $1
	li      119, $2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      2, $1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     init_vecset_constants.3332
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_light_dirvec, $1
	load    0($1), $1
	li      min_caml_light, $2
	load    0($2), $3
	store   $3, 0($1)
	load    1($2), $3
	store   $3, 1($1)
	load    2($2), $2
	store   $2, 2($1)
	li      min_caml_light_dirvec, $1
	li      min_caml_n_objects, $2
	load    0($2), $2
	sub     $2, 1, $2
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      min_caml_n_objects, $1
	load    0($1), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bl      $28, bge_else.18600
	li      min_caml_objects, $2
	add     $2, $1, $28
	load    0($28), $2
	load    2($2), $3
	li      2, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18602
	load    7($2), $3
	load    0($3), $3
	load    l.13296, $4
	fcmp    $4, $3, $28
	bg      $28, ble_else.18604
	li      0, $3
	b       ble_cont.18605
ble_else.18604:
	li      1, $3
ble_cont.18605:
	cmp     $3, $zero, $28
	bne     $28, be_else.18606
	b       be_cont.18607
be_else.18606:
	load    1($2), $3
	li      1, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18608
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_rect_reflection.3343
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.18609
be_else.18608:
	li      2, $28
	cmp     $3, $28, $28
	bne     $28, be_else.18610
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_surface_reflection.3346
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.18611
be_else.18610:
be_cont.18611:
be_cont.18609:
be_cont.18607:
	b       be_cont.18603
be_else.18602:
be_cont.18603:
	b       bge_cont.18601
bge_else.18600:
bge_cont.18601:
	li      0, $2
	li      0, $3
	load    19($sp), $1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     pretrace_line.3275
	sub     $sp, 36, $sp
	load    35($sp), $ra
	li      0, $2
	li      2, $3
	li      min_caml_image_size, $1
	load    1($1), $1
	cmp     $1, $zero, $28
	bg      $28, ble_else.18612
	ret
ble_else.18612:
	store   $2, 35($sp)
	li      min_caml_image_size, $1
	load    1($1), $1
	sub     $1, 1, $1
	cmp     $1, $zero, $28
	bg      $28, ble_else.18614
	b       ble_cont.18615
ble_else.18614:
	li      1, $2
	load    28($sp), $1
	store   $ra, 36($sp)
	add     $sp, 37, $sp
	jal     pretrace_line.3275
	sub     $sp, 37, $sp
	load    36($sp), $ra
ble_cont.18615:
	li      0, $1
	load    35($sp), $2
	load    10($sp), $3
	load    19($sp), $4
	load    28($sp), $5
	store   $ra, 36($sp)
	add     $sp, 37, $sp
	jal     scan_pixel.3279
	sub     $sp, 37, $sp
	load    36($sp), $ra
	li      1, $1
	li      4, $5
	load    19($sp), $2
	load    28($sp), $3
	load    10($sp), $4
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

.define $mi $3
.define $mfhx $4
.define $mf $5
.define $cond $6

.define $q $7
.define $r $8

.define $rf $9

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
	fcmp $1, $zero, $cond
	bge $cond, FLOOR_POSITIVE	# if ($f1 >= 0) FLOOR_POSITIVE
	store $ra, 0($sp)
	add $sp, 1, $sp
	fneg $1, $1
	jal min_caml_floor		# $f1 = FLOOR_POSITIVE(-$f1)
	load FLOOR_MONE, $2
	fsub $2, $1, $1		# $f1 = (-1) - $f1
	add $sp, -1, $sp
	load 0($sp), $ra
	ret
FLOOR_POSITIVE:
	load FLOAT_MAGICF, $mf
	fcmp $1, $mf, $cond
	ble $cond, FLOOR_POSITIVE_MAIN
	ret
FLOOR_POSITIVE_MAIN:
	mov $1, $2
	fadd $1, $mf, $1		# $f1 += 0x4b000000
	fsub $1, $mf, $1		# $f1 -= 0x4b000000
	fcmp $1, $2, $cond
	ble $cond, FLOOR_RET
	load FLOOR_ONE, $2
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
	cmp $1, $zero, $cond
	bge $cond, ITOF_MAIN		# if ($i1 >= 0) goto ITOF_MAIN
	neg $1, $1		# 正の値にしてitofした後に、マイナスにしてかえす
	store $ra, 0($sp)
	add $sp, 1, $sp
	jal min_caml_float_of_int	# $f1 = float_of_int(-$i1)
	add $sp, -1, $sp
	load 0($sp), $ra
	fneg $1, $1
	ret
ITOF_MAIN:
	load FLOAT_MAGICI, $mi	# $mi = 8388608
	load FLOAT_MAGICF, $mf 	# $mf = 8388608.0
	load FLOAT_MAGICFHX, $mfhx 	# $mfhx = 0x4b000000
	cmp $1, $mi, $cond		# $cond = cmp($i1, 8388608)
	bge $cond, ITOF_BIG		# if ($i1 >= 8388608) goto ITOF_BIG
	add $1, $mfhx, $1		# $i1 = $i1 + $mfhx (i.e. $i1 + 0x4b000000)
	fsub $1, $mf, $1		# $f1 = $f1 - $mf (i.e. $f1 - 8388608.0)
	ret				# return
ITOF_BIG:
	li 0, $q				# $i1 = $q * 8388608 + $r なる$q, $rを求める
	mov $1, $r
ITOF_LOOP:
	add $q, 1, $q			# $q += 1
	sub $r, $mi, $r			# $r -= 8388608
	cmp $r, $mi, $cond
	bge $cond, ITOF_LOOP		# if ($r >= 8388608) continue
	li 0, $1
ITOF_LOOP2:
	fadd $1, $mf, $1		# $f1 = $q * $mf
	add $q, -1, $q
	cmp $q, $zero, $cond
	bg $cond, ITOF_LOOP2
	add $r, $mfhx, $r			# $r < 8388608 だからそのままitof
	fsub $r, $mf, $r		# $tempf = itof($r)
	fadd $1, $r, $1		# $f1 = $f1 + $tempf (i.e. $f1 = itof($q * $mf) + itof($r) )
	ret


######################################################################
# * int_of_float
######################################################################
min_caml_int_of_float:
	fcmp $1, $zero, $cond
	bge $cond, FTOI_MAIN		# if ($f1 >= 0) goto FTOI_MAIN
	fneg $1, $1		# 正の値にしてftoiした後に、マイナスにしてかえす
	store $ra, 0($sp)
	add $sp, 1, $sp
	jal min_caml_int_of_float	# $i1 = float_of_int(-$f1)
	add $sp, -1, $sp
	load 0($sp), $ra
	neg $1, $1
	ret				# return
FTOI_MAIN:
	load FLOAT_MAGICI, $mi	# $mi = 8388608
	load FLOAT_MAGICF, $mf 	# $mf = 8388608.0
	load FLOAT_MAGICFHX, $mfhx	# $mfhx = 0x4b000000
	fcmp $1, $mf, $cond
	bge $cond, FTOI_BIG		# if ($f1 >= 8688608.0) goto FTOI_BIG
	fadd $1, $mf, $1
	sub $1, $mfhx, $1
	ret
FTOI_BIG:
	li 0, $q				# $f1 = $q * 8388608 + $rf なる$q, $rfを求める
	mov $1, $rf
FTOI_LOOP:
	add $q, 1, $q			# $q += 1
	fsub $rf, $mf, $rf		# $rf -= 8388608.0
	fcmp $rf, $mf, $cond
	bge $cond, FTOI_LOOP		# if ($rf >= 8388608.0) continue
	li 0, $1
FTOI_LOOP2:
	add $1, $mi, $1			# $i1 = $q * $mi
	add $q, -1, $q
	cmp $q, $zero, $cond
	bg $cond, FTOI_LOOP2
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
min_caml_read_int:
min_caml_read_float:
read_1:
	read $1
	li 255, $2
	cmp $1, $2, $2
	bg $2, read_1
	sll $1, 24, $1
read_2:
	read $2
	li 255, $3
	cmp $2, $3, $3
	bg $3, read_2
	sll $2, 16, $2
	add $1, $2, $1
read_3:
	read $2
	li 255, $3
	cmp $2, $3, $3
	bg $3, read_3
	sll $2, 8, $2
	add $1, $2, $1
read_4:
	read $2
	li 255, $3
	cmp $2, $3, $3
	bg $3, read_4
	add $1, $2, $1
	ret

######################################################################
# * write
# * バイト出力
# * 失敗してたらループ
######################################################################
min_caml_write:
	write $1, $2
	cmp $2, $zero, $3
	bg $3, min_caml_write
	ret

######################################################################
# * create_array
# * create_float_array
######################################################################
min_caml_create_array:
min_caml_create_float_array:
	add $1, $hp, $3
	mov $hp, $1
CREATE_ARRAY_LOOP:
	cmp $hp, $3, $4
	bge $4, CREATE_ARRAY_END
	store $2, 0($hp)
	add $hp, 1, $hp
	b CREATE_ARRAY_LOOP
CREATE_ARRAY_END:
	ret

######################################################################
# * ledout_int
# * ledout_float
# * バイトLED出力
######################################################################
min_caml_ledout_int:
min_caml_ledout_float:
	ledout $1
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
