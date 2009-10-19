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
	bne     $i12, be_else.17912
	mov     $f3, $f1
	ret
be_else.17912:
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.17913
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fadd    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fsub    $f4, $f2, $f4
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6797
ble_else.17913:
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fsub    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fadd    $f4, $f2, $f4
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6797
cordic_sin.2851:
	li      0, $i1
	li      l.13296, $i2
	load    0($i2), $f2
	li      l.13298, $i2
	load    0($i2), $f3
	li      l.13298, $i2
	load    0($i2), $f4
	li      l.13301, $i2
	load    0($i2), $f5
	b       cordic_rec.6797
cordic_rec.6762:
	li      25, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17914
	mov     $f2, $f1
	ret
be_else.17914:
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.17915
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fadd    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fsub    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fsub    $f4, $f2, $f4
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6762
ble_else.17915:
	add     $i1, 1, $i2
	fmul    $f5, $f3, $f6
	fsub    $f2, $f6, $f6
	fmul    $f5, $f2, $f2
	fadd    $f3, $f2, $f3
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f2
	fadd    $f4, $f2, $f4
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f5, $f2, $f5
	mov     $i2, $i1
	mov     $f6, $f2
	b       cordic_rec.6762
cordic_cos.2853:
	li      0, $i1
	li      l.13296, $i2
	load    0($i2), $f2
	li      l.13298, $i2
	load    0($i2), $f3
	li      l.13298, $i2
	load    0($i2), $f4
	li      l.13301, $i2
	load    0($i2), $f5
	b       cordic_rec.6762
cordic_rec.6728:
	li      25, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17916
	mov     $f3, $f1
	ret
be_else.17916:
	li      l.13298, $i2
	load    0($i2), $f5
	fcmp    $f2, $f5, $i12
	bg      $i12, ble_else.17917
	add     $i1, 1, $i2
	fmul    $f4, $f2, $f5
	fsub    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fadd    $f2, $f1, $f2
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f1
	fsub    $f3, $f1, $f3
	li      l.13293, $i1
	load    0($i1), $f1
	fmul    $f4, $f1, $f4
	mov     $i2, $i1
	mov     $f5, $f1
	b       cordic_rec.6728
ble_else.17917:
	add     $i1, 1, $i2
	fmul    $f4, $f2, $f5
	fadd    $f1, $f5, $f5
	fmul    $f4, $f1, $f1
	fsub    $f2, $f1, $f2
	li      min_caml_atan_table, $i3
	add     $i3, $i1, $i12
	load    0($i12), $f1
	fadd    $f3, $f1, $f3
	li      l.13293, $i1
	load    0($i1), $f1
	fmul    $f4, $f1, $f4
	mov     $i2, $i1
	mov     $f5, $f1
	b       cordic_rec.6728
cordic_atan.2855:
	li      0, $i1
	li      l.13301, $i2
	load    0($i2), $f2
	li      l.13298, $i2
	load    0($i2), $f3
	li      l.13301, $i2
	load    0($i2), $f4
	mov     $f2, $f14
	mov     $f1, $f2
	mov     $f14, $f1
	b       cordic_rec.6728
sin.2857:
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17918
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17919
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17920
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17921
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17922
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17923
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17924
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17925
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	b       sin.2857
ble_else.17925:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17924:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	b       cordic_sin.2851
ble_else.17923:
	b       cordic_sin.2851
ble_else.17922:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17921:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17926
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17928
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17930
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17932
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17933
ble_else.17932:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17933:
	b       ble_cont.17931
ble_else.17930:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17931:
	b       ble_cont.17929
ble_else.17928:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17929:
	b       ble_cont.17927
ble_else.17926:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17927:
	fneg    $f1, $f1
	ret
ble_else.17920:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	b       cordic_sin.2851
ble_else.17919:
	b       cordic_sin.2851
ble_else.17918:
	fneg    $f1, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17934
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17936
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17938
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17940
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	b       ble_cont.17941
ble_else.17940:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17941:
	b       ble_cont.17939
ble_else.17938:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17939:
	b       ble_cont.17937
ble_else.17936:
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_sin.2851
	sub     $sp, 1, $sp
	load    0($sp), $ra
ble_cont.17937:
	b       ble_cont.17935
ble_else.17934:
	fneg    $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     sin.2857
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
ble_cont.17935:
	fneg    $f1, $f1
	ret
cos.2859:
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17942
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17943
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17944
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17945
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17946
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17947
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17948
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17949
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17949:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17948:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17947:
	b       cordic_cos.2853
ble_else.17946:
	fneg    $f1, $f1
	b       cos.2859
ble_else.17945:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17950
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17951
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17952
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17953
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17953:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17952:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17951:
	b       cordic_cos.2853
ble_else.17950:
	fneg    $f1, $f1
	b       cos.2859
ble_else.17944:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17943:
	b       cordic_cos.2853
ble_else.17942:
	fneg    $f1, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17954
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17955
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17956
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17957
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	b       cos.2859
ble_else.17957:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	b       cos.2859
ble_else.17956:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 0($sp)
	add     $sp, 1, $sp
	jal     cordic_cos.2853
	sub     $sp, 1, $sp
	load    0($sp), $ra
	fneg    $f1, $f1
	ret
ble_else.17955:
	b       cordic_cos.2853
ble_else.17954:
	fneg    $f1, $f1
	b       cos.2859
get_sqrt_init_rec.6691.10569:
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17958
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17958:
	li      l.13374, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17959
	li      l.13374, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17960
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17960:
	li      l.13374, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17961
	li      l.13374, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17962
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17962:
	li      l.13374, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17963
	li      l.13374, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	add     $i1, 1, $i1
	li      49, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17964
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
be_else.17964:
	li      l.13374, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17965
	li      l.13374, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	add     $i1, 1, $i1
	b       get_sqrt_init_rec.6691.10569
ble_else.17965:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17963:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17961:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
ble_else.17959:
	li      min_caml_rsqrt_table, $i2
	add     $i2, $i1, $i12
	load    0($i12), $f1
	ret
sqrt.2865:
	li      l.13301, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17966
	store   $f1, 0($sp)
	li      l.13374, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17967
	li      l.13374, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	li      l.13374, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17969
	li      l.13374, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	li      l.13374, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17971
	li      l.13374, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	li      3, $i1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     get_sqrt_init_rec.6691.10569
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.17972
ble_else.17971:
	li      min_caml_rsqrt_table, $i1
	load    2($i1), $f1
ble_cont.17972:
	b       ble_cont.17970
ble_else.17969:
	li      min_caml_rsqrt_table, $i1
	load    1($i1), $f1
ble_cont.17970:
	b       ble_cont.17968
ble_else.17967:
	li      min_caml_rsqrt_table, $i1
	load    0($i1), $f1
ble_cont.17968:
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	load    0($sp), $f4
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	li      l.13293, $i1
	load    0($i1), $f2
	fmul    $f2, $f1, $f2
	li      l.13401, $i1
	load    0($i1), $f3
	fmul    $f4, $f1, $f5
	fmul    $f5, $f1, $f1
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	fmul    $f1, $f4, $f1
	ret
ble_else.17966:
	li      l.13293, $i1
	load    0($i1), $f2
	finv    $f1, $f15
	fmul    $f1, $f15, $f3
	fadd    $f1, $f3, $f3
	fmul    $f2, $f3, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	finv    $f2, $f15
	fmul    $f1, $f15, $f4
	fadd    $f2, $f4, $f2
	fmul    $f3, $f2, $f2
	li      l.13293, $i1
	load    0($i1), $f3
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.17973
	li      1, $i1
	b       be_cont.17974
be_else.17973:
	li      0, $i1
be_cont.17974:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17975
	load    1($sp), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.17977
	li      l.13301, $i1
	load    0($i1), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.17978
be_else.17977:
	li      l.13423, $i1
	load    0($i1), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
be_cont.17978:
	b       be_cont.17976
be_else.17975:
	li      l.13301, $i1
	load    0($i1), $f1
be_cont.17976:
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
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 3($sp)
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17981
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17983
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17985
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17987
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.17988
ble_else.17987:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17988:
	b       ble_cont.17986
ble_else.17985:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $f1, $f1
ble_cont.17986:
	b       ble_cont.17984
ble_else.17983:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17984:
	b       ble_cont.17982
ble_else.17981:
	fneg    $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.17982:
	store   $f1, 4($sp)
	li      l.13298, $i1
	load    0($i1), $f1
	load    3($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17989
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17991
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17993
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.17995
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.17996
ble_else.17995:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17996:
	b       ble_cont.17994
ble_else.17993:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17994:
	b       ble_cont.17992
ble_else.17991:
	mov     $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.17992:
	b       ble_cont.17990
ble_else.17989:
	fneg    $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.17990:
	store   $f1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_float
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 6($sp)
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17997
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.17999
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18001
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18003
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.18004
ble_else.18003:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18004:
	b       ble_cont.18002
ble_else.18001:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.18002:
	b       ble_cont.18000
ble_else.17999:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_cos.2853
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18000:
	b       ble_cont.17998
ble_else.17997:
	fneg    $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cos.2859
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.17998:
	store   $f1, 7($sp)
	li      l.13298, $i1
	load    0($i1), $f1
	load    6($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18005
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18007
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18009
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18011
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       ble_cont.18012
ble_else.18011:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $f1, $f1
ble_cont.18012:
	b       ble_cont.18010
ble_else.18009:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.18010:
	b       ble_cont.18008
ble_else.18007:
	mov     $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     cordic_sin.2851
	sub     $sp, 9, $sp
	load    8($sp), $ra
ble_cont.18008:
	b       ble_cont.18006
ble_else.18005:
	fneg    $f2, $f1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     sin.2857
	sub     $sp, 9, $sp
	load    8($sp), $ra
	fneg    $f1, $f1
ble_cont.18006:
	li      min_caml_screenz_dir, $i1
	load    4($sp), $f2
	fmul    $f2, $f1, $f3
	li      l.13457, $i2
	load    0($i2), $f4
	fmul    $f3, $f4, $f3
	store   $f3, 0($i1)
	li      min_caml_screenz_dir, $i1
	li      l.13459, $i2
	load    0($i2), $f3
	load    5($sp), $f4
	fmul    $f4, $f3, $f3
	store   $f3, 1($i1)
	li      min_caml_screenz_dir, $i1
	load    7($sp), $f3
	fmul    $f2, $f3, $f5
	li      l.13457, $i2
	load    0($i2), $f6
	fmul    $f5, $f6, $f5
	store   $f5, 2($i1)
	li      min_caml_screenx_dir, $i1
	store   $f3, 0($i1)
	li      min_caml_screenx_dir, $i1
	li      l.13298, $i2
	load    0($i2), $f5
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
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($sp)
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18014
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18016
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18018
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18020
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.18021
ble_else.18020:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18021:
	b       ble_cont.18019
ble_else.18018:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18019:
	b       ble_cont.18017
ble_else.18016:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18017:
	b       ble_cont.18015
ble_else.18014:
	fneg    $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18015:
	li      min_caml_light, $i1
	fneg    $f1, $f1
	store   $f1, 1($i1)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_read_float
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 1($sp)
	li      l.13298, $i1
	load    0($i1), $f1
	load    0($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18022
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18024
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18026
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18028
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.18029
ble_else.18028:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18029:
	b       ble_cont.18027
ble_else.18026:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.18027:
	b       ble_cont.18025
ble_else.18024:
	mov     $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18025:
	b       ble_cont.18023
ble_else.18022:
	fneg    $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18023:
	store   $f1, 2($sp)
	li      l.13298, $i1
	load    0($i1), $f1
	load    1($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18030
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18032
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18034
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18036
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.18037
ble_else.18036:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.18037:
	b       ble_cont.18035
ble_else.18034:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18035:
	b       ble_cont.18033
ble_else.18032:
	mov     $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18033:
	b       ble_cont.18031
ble_else.18030:
	fneg    $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.18031:
	li      min_caml_light, $i1
	load    2($sp), $f2
	fmul    $f2, $f1, $f1
	store   $f1, 0($i1)
	li      l.13298, $i1
	load    0($i1), $f1
	load    1($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18038
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18040
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18042
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18044
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.18045
ble_else.18044:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18045:
	b       ble_cont.18043
ble_else.18042:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.18043:
	b       ble_cont.18041
ble_else.18040:
	mov     $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_cos.2853
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18041:
	b       ble_cont.18039
ble_else.18038:
	fneg    $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cos.2859
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18039:
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18047
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18049
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18051
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18053
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.18054
ble_else.18053:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18054:
	b       ble_cont.18052
ble_else.18051:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.18052:
	b       ble_cont.18050
ble_else.18049:
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18050:
	b       ble_cont.18048
ble_else.18047:
	fneg    $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18048:
	store   $f1, 2($sp)
	load    1($sp), $i1
	load    0($i1), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18055
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18057
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18059
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18061
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       ble_cont.18062
ble_else.18061:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.18062:
	b       ble_cont.18060
ble_else.18059:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18060:
	b       ble_cont.18058
ble_else.18057:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     cordic_sin.2851
	sub     $sp, 4, $sp
	load    3($sp), $ra
ble_cont.18058:
	b       ble_cont.18056
ble_else.18055:
	fneg    $f1, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     sin.2857
	sub     $sp, 4, $sp
	load    3($sp), $ra
	fneg    $f1, $f1
ble_cont.18056:
	store   $f1, 3($sp)
	load    1($sp), $i1
	load    1($i1), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18063
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18065
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18067
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18069
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       ble_cont.18070
ble_else.18069:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.18070:
	b       ble_cont.18068
ble_else.18067:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
	fneg    $f1, $f1
ble_cont.18068:
	b       ble_cont.18066
ble_else.18065:
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cordic_cos.2853
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.18066:
	b       ble_cont.18064
ble_else.18063:
	fneg    $f1, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     cos.2859
	sub     $sp, 5, $sp
	load    4($sp), $ra
ble_cont.18064:
	store   $f1, 4($sp)
	load    1($sp), $i1
	load    1($i1), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18071
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18073
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18075
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18077
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.18078
ble_else.18077:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18078:
	b       ble_cont.18076
ble_else.18075:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18076:
	b       ble_cont.18074
ble_else.18073:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18074:
	b       ble_cont.18072
ble_else.18071:
	fneg    $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18072:
	store   $f1, 5($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18079
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18081
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18083
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18085
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.18086
ble_else.18085:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18086:
	b       ble_cont.18084
ble_else.18083:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $f1, $f1
ble_cont.18084:
	b       ble_cont.18082
ble_else.18081:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18082:
	b       ble_cont.18080
ble_else.18079:
	fneg    $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18080:
	store   $f1, 6($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18087
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18089
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18091
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18093
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       ble_cont.18094
ble_else.18093:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.18094:
	b       ble_cont.18092
ble_else.18091:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18092:
	b       ble_cont.18090
ble_else.18089:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     cordic_sin.2851
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18090:
	b       ble_cont.18088
ble_else.18087:
	fneg    $f1, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sin.2857
	sub     $sp, 8, $sp
	load    7($sp), $ra
	fneg    $f1, $f1
ble_cont.18088:
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
	li      l.13374, $i1
	load    0($i1), $f13
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
	li      l.13374, $i2
	load    0($i2), $f11
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
	li      l.13374, $i2
	load    0($i2), $f1
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
	bne     $i12, be_else.18096
	li      0, $i1
	ret
be_else.18096:
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18097
	li      0, $i1
	b       ble_cont.18098
ble_else.18097:
	li      1, $i1
ble_cont.18098:
	store   $i1, 7($sp)
	li      2, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     min_caml_create_float_array
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $i1, 10($sp)
	load    4($sp), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18099
	b       be_cont.18100
be_else.18099:
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 0($i1)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 1($i1)
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     min_caml_read_float
	sub     $sp, 12, $sp
	load    11($sp), $ra
	li      l.13426, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    10($sp), $i1
	store   $f1, 2($i1)
be_cont.18100:
	load    2($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18101
	li      1, $i1
	b       be_cont.18102
be_else.18101:
	load    7($sp), $i1
be_cont.18102:
	store   $i1, 11($sp)
	li      4, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	bne     $i12, be_else.18103
	load    0($i1), $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18105
	li      1, $i2
	b       be_cont.18106
be_else.18105:
	li      0, $i2
be_cont.18106:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18107
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18109
	li      1, $i2
	b       be_cont.18110
be_else.18109:
	li      0, $i2
be_cont.18110:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18111
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18113
	li      0, $i2
	b       ble_cont.18114
ble_else.18113:
	li      1, $i2
ble_cont.18114:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18115
	li      l.13423, $i2
	load    0($i2), $f2
	b       be_cont.18116
be_else.18115:
	li      l.13301, $i2
	load    0($i2), $f2
be_cont.18116:
	b       be_cont.18112
be_else.18111:
	li      l.13298, $i2
	load    0($i2), $f2
be_cont.18112:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.18108
be_else.18107:
	li      l.13298, $i2
	load    0($i2), $f1
be_cont.18108:
	store   $f1, 0($i1)
	load    1($i1), $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18117
	li      1, $i2
	b       be_cont.18118
be_else.18117:
	li      0, $i2
be_cont.18118:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18119
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18121
	li      1, $i2
	b       be_cont.18122
be_else.18121:
	li      0, $i2
be_cont.18122:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18123
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18125
	li      0, $i2
	b       ble_cont.18126
ble_else.18125:
	li      1, $i2
ble_cont.18126:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18127
	li      l.13423, $i2
	load    0($i2), $f2
	b       be_cont.18128
be_else.18127:
	li      l.13301, $i2
	load    0($i2), $f2
be_cont.18128:
	b       be_cont.18124
be_else.18123:
	li      l.13298, $i2
	load    0($i2), $f2
be_cont.18124:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.18120
be_else.18119:
	li      l.13298, $i2
	load    0($i2), $f1
be_cont.18120:
	store   $f1, 1($i1)
	load    2($i1), $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18129
	li      1, $i2
	b       be_cont.18130
be_else.18129:
	li      0, $i2
be_cont.18130:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18131
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18133
	li      1, $i2
	b       be_cont.18134
be_else.18133:
	li      0, $i2
be_cont.18134:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18135
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18137
	li      0, $i2
	b       ble_cont.18138
ble_else.18137:
	li      1, $i2
ble_cont.18138:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18139
	li      l.13423, $i2
	load    0($i2), $f2
	b       be_cont.18140
be_else.18139:
	li      l.13301, $i2
	load    0($i2), $f2
be_cont.18140:
	b       be_cont.18136
be_else.18135:
	li      l.13298, $i2
	load    0($i2), $f2
be_cont.18136:
	fmul    $f1, $f1, $f1
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	b       be_cont.18132
be_else.18131:
	li      l.13298, $i2
	load    0($i2), $f1
be_cont.18132:
	store   $f1, 2($i1)
	b       be_cont.18104
be_else.18103:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18141
	load    7($sp), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18143
	li      1, $i2
	b       be_cont.18144
be_else.18143:
	li      0, $i2
be_cont.18144:
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     vecunit_sgn.2896
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       be_cont.18142
be_else.18141:
be_cont.18142:
be_cont.18104:
	load    4($sp), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18145
	b       be_cont.18146
be_else.18145:
	load    5($sp), $i1
	load    10($sp), $i2
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     rotate_quadratic_matrix.3001
	sub     $sp, 13, $sp
	load    12($sp), $ra
be_cont.18146:
	li      1, $i1
	ret
read_object.3006:
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18147
	ret
bge_else.18147:
	store   $i1, 0($sp)
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     read_nth_object.3004
	sub     $sp, 2, $sp
	load    1($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18149
	li      min_caml_n_objects, $i1
	load    0($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.18149:
	load    0($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18151
	ret
bge_else.18151:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     read_nth_object.3004
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18153
	li      min_caml_n_objects, $i1
	load    1($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.18153:
	load    1($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18155
	ret
bge_else.18155:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     read_nth_object.3004
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18157
	li      min_caml_n_objects, $i1
	load    2($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.18157:
	load    2($sp), $i1
	add     $i1, 1, $i1
	li      60, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18159
	ret
bge_else.18159:
	store   $i1, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_nth_object.3004
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18161
	li      min_caml_n_objects, $i1
	load    3($sp), $i2
	store   $i2, 0($i1)
	ret
be_else.18161:
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
	bne     $i12, be_else.18163
	load    0($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	b       min_caml_create_array
be_else.18163:
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
	bne     $i12, be_else.18164
	load    2($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18165
be_else.18164:
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
	bne     $i12, be_else.18166
	load    4($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18167
be_else.18166:
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
	bne     $i12, be_else.18168
	load    6($sp), $i1
	add     $i1, 1, $i1
	li      -1, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.18169
be_else.18168:
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
be_cont.18169:
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.18167:
	load    2($sp), $i2
	load    3($sp), $i3
	add     $i1, $i2, $i12
	store   $i3, 0($i12)
be_cont.18165:
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
	bne     $i12, be_else.18170
	li      1, $i1
	li      -1, $i2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.18171
be_else.18170:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18172
	li      2, $i1
	li      -1, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.18173
be_else.18172:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18174
	li      3, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18175
be_else.18174:
	store   $i1, 3($sp)
	li      3, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i2
	store   $i2, 2($i1)
be_cont.18175:
	load    2($sp), $i2
	store   $i2, 1($i1)
be_cont.18173:
	load    1($sp), $i2
	store   $i2, 0($i1)
be_cont.18171:
	mov     $i1, $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18176
	load    0($sp), $i1
	add     $i1, 1, $i1
	b       min_caml_create_array
be_else.18176:
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
	bne     $i12, be_else.18177
	li      1, $i1
	li      -1, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.18178
be_else.18177:
	store   $i1, 6($sp)
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_read_int
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18179
	li      2, $i1
	li      -1, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_create_array
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.18180
be_else.18179:
	store   $i1, 7($sp)
	li      2, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     read_net_item.3010
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    7($sp), $i2
	store   $i2, 1($i1)
be_cont.18180:
	load    6($sp), $i2
	store   $i2, 0($i1)
be_cont.18178:
	mov     $i1, $i2
	load    0($i2), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18181
	load    5($sp), $i1
	add     $i1, 1, $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     min_caml_create_array
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18182
be_else.18181:
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
be_cont.18182:
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
	bne     $i12, be_else.18183
	li      1, $i1
	li      -1, $i2
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       be_cont.18184
be_else.18183:
	store   $i1, 1($sp)
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_read_int
	sub     $sp, 3, $sp
	load    2($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18185
	li      2, $i1
	li      -1, $i2
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       be_cont.18186
be_else.18185:
	store   $i1, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_read_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18187
	li      3, $i1
	li      -1, $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_create_array
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18188
be_else.18187:
	store   $i1, 3($sp)
	li      3, $i1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     read_net_item.3010
	sub     $sp, 5, $sp
	load    4($sp), $ra
	load    3($sp), $i2
	store   $i2, 2($i1)
be_cont.18188:
	load    2($sp), $i2
	store   $i2, 1($i1)
be_cont.18186:
	load    1($sp), $i2
	store   $i2, 0($i1)
be_cont.18184:
	load    0($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18189
	ret
be_else.18189:
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
	bne     $i12, be_else.18191
	li      1, $i1
	li      -1, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_create_array
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18192
be_else.18191:
	store   $i1, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_read_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18193
	li      2, $i1
	li      -1, $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_create_array
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       be_cont.18194
be_else.18193:
	store   $i1, 6($sp)
	li      2, $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     read_net_item.3010
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    6($sp), $i2
	store   $i2, 1($i1)
be_cont.18194:
	load    5($sp), $i2
	store   $i2, 0($i1)
be_cont.18192:
	load    0($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18195
	ret
be_else.18195:
	li      min_caml_and_net, $i2
	load    4($sp), $i3
	add     $i2, $i3, $i12
	store   $i1, 0($i12)
	add     $i3, 1, $i1
	b       read_and_network.3014
solver_rect_surface.3018:
	add     $i2, $i3, $i12
	load    0($i12), $f4
	li      l.13298, $i6
	load    0($i6), $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.18197
	li      1, $i6
	b       be_cont.18198
be_else.18197:
	li      0, $i6
be_cont.18198:
	li      0, $i12
	cmp     $i6, $i12, $i12
	bne     $i12, be_else.18199
	load    4($i1), $i6
	load    6($i1), $i1
	add     $i2, $i3, $i12
	load    0($i12), $f4
	li      l.13298, $i7
	load    0($i7), $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.18200
	li      0, $i7
	b       ble_cont.18201
ble_else.18200:
	li      1, $i7
ble_cont.18201:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18202
	mov     $i7, $i1
	b       be_cont.18203
be_else.18202:
	li      0, $i12
	cmp     $i7, $i12, $i12
	bne     $i12, be_else.18204
	li      1, $i1
	b       be_cont.18205
be_else.18204:
	li      0, $i1
be_cont.18205:
be_cont.18203:
	add     $i6, $i3, $i12
	load    0($i12), $f4
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18206
	fneg    $f4, $f4
	b       be_cont.18207
be_else.18206:
be_cont.18207:
	fsub    $f4, $f1, $f1
	add     $i2, $i3, $i12
	load    0($i12), $f4
	finv    $f4, $f15
	fmul    $f1, $f15, $f1
	add     $i2, $i4, $i12
	load    0($i12), $f4
	fmul    $f1, $f4, $f4
	fadd    $f4, $f2, $f2
	li      l.13298, $i1
	load    0($i1), $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.18208
	b       ble_cont.18209
ble_else.18208:
	fneg    $f2, $f2
ble_cont.18209:
	add     $i6, $i4, $i12
	load    0($i12), $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.18210
	li      0, $i1
	b       ble_cont.18211
ble_else.18210:
	li      1, $i1
ble_cont.18211:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18212
	li      0, $i1
	ret
be_else.18212:
	add     $i2, $i5, $i12
	load    0($i12), $f2
	fmul    $f1, $f2, $f2
	fadd    $f2, $f3, $f2
	li      l.13298, $i1
	load    0($i1), $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.18213
	b       ble_cont.18214
ble_else.18213:
	fneg    $f2, $f2
ble_cont.18214:
	add     $i6, $i5, $i12
	load    0($i12), $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.18215
	li      0, $i1
	b       ble_cont.18216
ble_else.18215:
	li      1, $i1
ble_cont.18216:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18217
	li      0, $i1
	ret
be_else.18217:
	li      min_caml_solver_dist, $i1
	store   $f1, 0($i1)
	li      1, $i1
	ret
be_else.18199:
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
	li      l.13298, $i2
	load    0($i2), $f5
	fcmp    $f4, $f5, $i12
	bg      $i12, ble_else.18218
	li      0, $i2
	b       ble_cont.18219
ble_else.18218:
	li      1, $i2
ble_cont.18219:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18220
	li      0, $i1
	ret
be_else.18220:
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18221
	mov     $f4, $f1
	ret
be_else.18221:
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18222
	mov     $f7, $f1
	ret
be_else.18222:
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
	li      l.13374, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18223
	li      1, $i1
	b       be_cont.18224
be_else.18223:
	li      0, $i1
be_cont.18224:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18225
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
	bne     $i12, be_else.18226
	li      l.13301, $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	b       be_cont.18227
be_else.18226:
be_cont.18227:
	load    6($sp), $f2
	fmul    $f2, $f2, $f3
	load    5($sp), $f4
	fmul    $f4, $f1, $f1
	fsub    $f3, $f1, $f1
	li      l.13298, $i2
	load    0($i2), $f3
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.18228
	li      0, $i2
	b       ble_cont.18229
ble_else.18228:
	li      1, $i2
ble_cont.18229:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18230
	li      0, $i1
	ret
be_else.18230:
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	load    3($sp), $i1
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18231
	fneg    $f1, $f1
	b       be_cont.18232
be_else.18231:
be_cont.18232:
	li      min_caml_solver_dist, $i1
	load    6($sp), $f2
	fsub    $f1, $f2, $f1
	load    5($sp), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 0($i1)
	li      1, $i1
	ret
be_else.18225:
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
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18233
	b       ble_cont.18234
ble_else.18233:
	fneg    $f5, $f5
ble_cont.18234:
	load    4($i1), $i4
	load    1($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18235
	li      0, $i4
	b       ble_cont.18236
ble_else.18235:
	li      1, $i4
ble_cont.18236:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18237
	li      0, $i4
	b       be_cont.18238
be_else.18237:
	load    2($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f3, $f5
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18239
	b       ble_cont.18240
ble_else.18239:
	fneg    $f5, $f5
ble_cont.18240:
	load    4($i1), $i4
	load    2($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18241
	li      0, $i4
	b       ble_cont.18242
ble_else.18241:
	li      1, $i4
ble_cont.18242:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18243
	li      0, $i4
	b       be_cont.18244
be_else.18243:
	load    1($i3), $f5
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f5, $f6, $i12
	bne     $i12, be_else.18245
	li      1, $i4
	b       be_cont.18246
be_else.18245:
	li      0, $i4
be_cont.18246:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18247
	li      1, $i4
	b       be_cont.18248
be_else.18247:
	li      0, $i4
be_cont.18248:
be_cont.18244:
be_cont.18238:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18249
	load    2($i3), $f4
	fsub    $f4, $f2, $f4
	load    3($i3), $f5
	fmul    $f4, $f5, $f4
	load    0($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f1, $f5
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18250
	b       ble_cont.18251
ble_else.18250:
	fneg    $f5, $f5
ble_cont.18251:
	load    4($i1), $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18252
	li      0, $i4
	b       ble_cont.18253
ble_else.18252:
	li      1, $i4
ble_cont.18253:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18254
	li      0, $i4
	b       be_cont.18255
be_else.18254:
	load    2($i2), $f5
	fmul    $f4, $f5, $f5
	fadd    $f5, $f3, $f5
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18256
	b       ble_cont.18257
ble_else.18256:
	fneg    $f5, $f5
ble_cont.18257:
	load    4($i1), $i4
	load    2($i4), $f6
	fcmp    $f6, $f5, $i12
	bg      $i12, ble_else.18258
	li      0, $i4
	b       ble_cont.18259
ble_else.18258:
	li      1, $i4
ble_cont.18259:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18260
	li      0, $i4
	b       be_cont.18261
be_else.18260:
	load    3($i3), $f5
	li      l.13298, $i4
	load    0($i4), $f6
	fcmp    $f5, $f6, $i12
	bne     $i12, be_else.18262
	li      1, $i4
	b       be_cont.18263
be_else.18262:
	li      0, $i4
be_cont.18263:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18264
	li      1, $i4
	b       be_cont.18265
be_else.18264:
	li      0, $i4
be_cont.18265:
be_cont.18261:
be_cont.18255:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18266
	load    4($i3), $f4
	fsub    $f4, $f3, $f3
	load    5($i3), $f4
	fmul    $f3, $f4, $f3
	load    0($i2), $f4
	fmul    $f3, $f4, $f4
	fadd    $f4, $f1, $f1
	li      l.13298, $i4
	load    0($i4), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18267
	b       ble_cont.18268
ble_else.18267:
	fneg    $f1, $f1
ble_cont.18268:
	load    4($i1), $i4
	load    0($i4), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18269
	li      0, $i4
	b       ble_cont.18270
ble_else.18269:
	li      1, $i4
ble_cont.18270:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18271
	li      0, $i1
	b       be_cont.18272
be_else.18271:
	load    1($i2), $f1
	fmul    $f3, $f1, $f1
	fadd    $f1, $f2, $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18273
	b       ble_cont.18274
ble_else.18273:
	fneg    $f1, $f1
ble_cont.18274:
	load    4($i1), $i1
	load    1($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18275
	li      0, $i1
	b       ble_cont.18276
ble_else.18275:
	li      1, $i1
ble_cont.18276:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18277
	li      0, $i1
	b       be_cont.18278
be_else.18277:
	load    5($i3), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18279
	li      1, $i1
	b       be_cont.18280
be_else.18279:
	li      0, $i1
be_cont.18280:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18281
	li      1, $i1
	b       be_cont.18282
be_else.18281:
	li      0, $i1
be_cont.18282:
be_cont.18278:
be_cont.18272:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18283
	li      0, $i1
	ret
be_else.18283:
	li      min_caml_solver_dist, $i1
	store   $f3, 0($i1)
	li      3, $i1
	ret
be_else.18266:
	li      min_caml_solver_dist, $i1
	store   $f4, 0($i1)
	li      2, $i1
	ret
be_else.18249:
	li      min_caml_solver_dist, $i1
	store   $f4, 0($i1)
	li      1, $i1
	ret
solver_second_fast.3075:
	load    0($i2), $f4
	li      l.13298, $i3
	load    0($i3), $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.18284
	li      1, $i3
	b       be_cont.18285
be_else.18284:
	li      0, $i3
be_cont.18285:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18286
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
	bne     $i12, be_else.18287
	li      l.13301, $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	b       be_cont.18288
be_else.18287:
be_cont.18288:
	load    3($sp), $f2
	fmul    $f2, $f2, $f3
	load    1($sp), $f4
	fmul    $f4, $f1, $f1
	fsub    $f3, $f1, $f1
	li      l.13298, $i2
	load    0($i2), $f3
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.18289
	li      0, $i2
	b       ble_cont.18290
ble_else.18289:
	li      1, $i2
ble_cont.18290:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18291
	li      0, $i1
	ret
be_else.18291:
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18292
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
	b       be_cont.18293
be_else.18292:
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
be_cont.18293:
	li      1, $i1
	ret
be_else.18286:
	li      0, $i1
	ret
solver_second_fast2.3092:
	load    0($i2), $f4
	li      l.13298, $i4
	load    0($i4), $f5
	fcmp    $f4, $f5, $i12
	bne     $i12, be_else.18294
	li      1, $i4
	b       be_cont.18295
be_else.18294:
	li      0, $i4
be_cont.18295:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18296
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
	li      l.13298, $i3
	load    0($i3), $f3
	fcmp    $f2, $f3, $i12
	bg      $i12, ble_else.18297
	li      0, $i3
	b       ble_cont.18298
ble_else.18297:
	li      1, $i3
ble_cont.18298:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18299
	li      0, $i1
	ret
be_else.18299:
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18300
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
	b       be_cont.18301
be_else.18300:
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
be_cont.18301:
	li      1, $i1
	ret
be_else.18296:
	li      0, $i1
	ret
setup_rect_table.3102:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      6, $i1
	li      l.13298, $i2
	load    0($i2), $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     min_caml_create_float_array
	sub     $sp, 3, $sp
	load    2($sp), $ra
	load    1($sp), $i2
	load    0($i2), $f1
	li      l.13298, $i3
	load    0($i3), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18302
	li      1, $i3
	b       be_cont.18303
be_else.18302:
	li      0, $i3
be_cont.18303:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18304
	load    0($sp), $i3
	load    6($i3), $i4
	load    0($i2), $f1
	li      l.13298, $i5
	load    0($i5), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18306
	li      0, $i5
	b       ble_cont.18307
ble_else.18306:
	li      1, $i5
ble_cont.18307:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18308
	mov     $i5, $i4
	b       be_cont.18309
be_else.18308:
	li      0, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18310
	li      1, $i4
	b       be_cont.18311
be_else.18310:
	li      0, $i4
be_cont.18311:
be_cont.18309:
	load    4($i3), $i3
	load    0($i3), $f1
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18312
	fneg    $f1, $f1
	b       be_cont.18313
be_else.18312:
be_cont.18313:
	store   $f1, 0($i1)
	li      l.13301, $i3
	load    0($i3), $f1
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 1($i1)
	b       be_cont.18305
be_else.18304:
	li      l.13298, $i3
	load    0($i3), $f1
	store   $f1, 1($i1)
be_cont.18305:
	load    1($i2), $f1
	li      l.13298, $i3
	load    0($i3), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18314
	li      1, $i3
	b       be_cont.18315
be_else.18314:
	li      0, $i3
be_cont.18315:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18316
	load    0($sp), $i3
	load    6($i3), $i4
	load    1($i2), $f1
	li      l.13298, $i5
	load    0($i5), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18318
	li      0, $i5
	b       ble_cont.18319
ble_else.18318:
	li      1, $i5
ble_cont.18319:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18320
	mov     $i5, $i4
	b       be_cont.18321
be_else.18320:
	li      0, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18322
	li      1, $i4
	b       be_cont.18323
be_else.18322:
	li      0, $i4
be_cont.18323:
be_cont.18321:
	load    4($i3), $i3
	load    1($i3), $f1
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18324
	fneg    $f1, $f1
	b       be_cont.18325
be_else.18324:
be_cont.18325:
	store   $f1, 2($i1)
	li      l.13301, $i3
	load    0($i3), $f1
	load    1($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 3($i1)
	b       be_cont.18317
be_else.18316:
	li      l.13298, $i3
	load    0($i3), $f1
	store   $f1, 3($i1)
be_cont.18317:
	load    2($i2), $f1
	li      l.13298, $i3
	load    0($i3), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18326
	li      1, $i3
	b       be_cont.18327
be_else.18326:
	li      0, $i3
be_cont.18327:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18328
	load    0($sp), $i3
	load    6($i3), $i4
	load    2($i2), $f1
	li      l.13298, $i5
	load    0($i5), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18330
	li      0, $i5
	b       ble_cont.18331
ble_else.18330:
	li      1, $i5
ble_cont.18331:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18332
	mov     $i5, $i4
	b       be_cont.18333
be_else.18332:
	li      0, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18334
	li      1, $i4
	b       be_cont.18335
be_else.18334:
	li      0, $i4
be_cont.18335:
be_cont.18333:
	load    4($i3), $i3
	load    2($i3), $f1
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18336
	fneg    $f1, $f1
	b       be_cont.18337
be_else.18336:
be_cont.18337:
	store   $f1, 4($i1)
	li      l.13301, $i3
	load    0($i3), $f1
	load    2($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 5($i1)
	b       be_cont.18329
be_else.18328:
	li      l.13298, $i2
	load    0($i2), $f1
	store   $f1, 5($i1)
be_cont.18329:
	ret
setup_surface_table.3105:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      4, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18338
	li      0, $i2
	b       ble_cont.18339
ble_else.18338:
	li      1, $i2
ble_cont.18339:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18340
	li      l.13298, $i2
	load    0($i2), $f1
	store   $f1, 0($i1)
	b       be_cont.18341
be_else.18340:
	li      l.13423, $i2
	load    0($i2), $f2
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
be_cont.18341:
	ret
setup_second_table.3108:
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      5, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18342
	store   $f2, 1($i3)
	store   $f3, 2($i3)
	store   $f4, 3($i3)
	b       be_cont.18343
be_else.18342:
	load    2($i1), $f5
	load    9($i2), $i4
	load    1($i4), $f6
	fmul    $f5, $f6, $f5
	load    1($i1), $f6
	load    9($i2), $i4
	load    2($i4), $f7
	fmul    $f6, $f7, $f6
	fadd    $f5, $f6, $f5
	li      l.13374, $i4
	load    0($i4), $f6
	finv    $f6, $f15
	fmul    $f5, $f15, $f5
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
	li      l.13374, $i4
	load    0($i4), $f5
	finv    $f5, $f15
	fmul    $f2, $f15, $f2
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
	li      l.13374, $i1
	load    0($i1), $f3
	finv    $f3, $f15
	fmul    $f2, $f15, $f2
	fsub    $f4, $f2, $f2
	store   $f2, 3($i3)
be_cont.18343:
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18344
	li      1, $i1
	b       be_cont.18345
be_else.18344:
	li      0, $i1
be_cont.18345:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18346
	li      l.13301, $i1
	load    0($i1), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	store   $f1, 4($i3)
	b       be_cont.18347
be_else.18346:
be_cont.18347:
	mov     $i3, $i1
	ret
iter_setup_dirvec_constants.3111:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18348
	store   $i1, 0($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18349
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
	b       be_cont.18350
be_else.18349:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18351
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
	b       be_cont.18352
be_else.18351:
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
be_cont.18352:
be_cont.18350:
	sub     $i2, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18353
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	load    0($sp), $i3
	load    1($i3), $i4
	load    0($i3), $i3
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18354
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
	b       be_cont.18355
be_else.18354:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18356
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
	b       be_cont.18357
be_else.18356:
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
be_cont.18357:
be_cont.18355:
	sub     $i2, 1, $i2
	load    0($sp), $i1
	b       iter_setup_dirvec_constants.3111
bge_else.18353:
	ret
bge_else.18348:
	ret
setup_startp_constants.3116:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18360
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
	bne     $i12, be_else.18361
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
	b       be_cont.18362
be_else.18361:
	li      2, $i12
	cmp     $i4, $i12, $i12
	bg      $i12, ble_else.18363
	b       ble_cont.18364
ble_else.18363:
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
	bne     $i12, be_else.18365
	li      l.13301, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	b       be_cont.18366
be_else.18365:
be_cont.18366:
	load    2($sp), $i1
	store   $f1, 3($i1)
ble_cont.18364:
be_cont.18362:
	load    1($sp), $i1
	sub     $i1, 1, $i2
	load    0($sp), $i1
	b       setup_startp_constants.3116
bge_else.18360:
	ret
is_rect_outside.3121:
	li      l.13298, $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18368
	b       ble_cont.18369
ble_else.18368:
	fneg    $f1, $f1
ble_cont.18369:
	load    4($i1), $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18370
	li      0, $i2
	b       ble_cont.18371
ble_else.18370:
	li      1, $i2
ble_cont.18371:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18372
	li      0, $i2
	b       be_cont.18373
be_else.18372:
	li      l.13298, $i2
	load    0($i2), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18374
	mov     $f2, $f1
	b       ble_cont.18375
ble_else.18374:
	fneg    $f2, $f1
ble_cont.18375:
	load    4($i1), $i2
	load    1($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18376
	li      0, $i2
	b       ble_cont.18377
ble_else.18376:
	li      1, $i2
ble_cont.18377:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18378
	li      0, $i2
	b       be_cont.18379
be_else.18378:
	li      l.13298, $i2
	load    0($i2), $f1
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.18380
	mov     $f3, $f1
	b       ble_cont.18381
ble_else.18380:
	fneg    $f3, $f1
ble_cont.18381:
	load    4($i1), $i2
	load    2($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18382
	li      0, $i2
	b       ble_cont.18383
ble_else.18382:
	li      1, $i2
ble_cont.18383:
be_cont.18379:
be_cont.18373:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18384
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18385
	li      1, $i1
	ret
be_else.18385:
	li      0, $i1
	ret
be_else.18384:
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
	bne     $i12, be_else.18386
	li      l.13298, $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18387
	b       ble_cont.18388
ble_else.18387:
	fneg    $f1, $f1
ble_cont.18388:
	load    4($i1), $i2
	load    0($i2), $f4
	fcmp    $f4, $f1, $i12
	bg      $i12, ble_else.18389
	li      0, $i2
	b       ble_cont.18390
ble_else.18389:
	li      1, $i2
ble_cont.18390:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18391
	li      0, $i2
	b       be_cont.18392
be_else.18391:
	li      l.13298, $i2
	load    0($i2), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18393
	mov     $f2, $f1
	b       ble_cont.18394
ble_else.18393:
	fneg    $f2, $f1
ble_cont.18394:
	load    4($i1), $i2
	load    1($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18395
	li      0, $i2
	b       ble_cont.18396
ble_else.18395:
	li      1, $i2
ble_cont.18396:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18397
	li      0, $i2
	b       be_cont.18398
be_else.18397:
	li      l.13298, $i2
	load    0($i2), $f1
	fcmp    $f1, $f3, $i12
	bg      $i12, ble_else.18399
	mov     $f3, $f1
	b       ble_cont.18400
ble_else.18399:
	fneg    $f3, $f1
ble_cont.18400:
	load    4($i1), $i2
	load    2($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18401
	li      0, $i2
	b       ble_cont.18402
ble_else.18401:
	li      1, $i2
ble_cont.18402:
be_cont.18398:
be_cont.18392:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18403
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18404
	li      1, $i1
	ret
be_else.18404:
	li      0, $i1
	ret
be_else.18403:
	load    6($i1), $i1
	ret
be_else.18386:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18405
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
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18406
	li      0, $i2
	b       ble_cont.18407
ble_else.18406:
	li      1, $i2
ble_cont.18407:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18408
	mov     $i2, $i1
	b       be_cont.18409
be_else.18408:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18410
	li      1, $i1
	b       be_cont.18411
be_else.18410:
	li      0, $i1
be_cont.18411:
be_cont.18409:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18412
	li      1, $i1
	ret
be_else.18412:
	li      0, $i1
	ret
be_else.18405:
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
	bne     $i12, be_else.18413
	li      l.13301, $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	b       be_cont.18414
be_else.18413:
be_cont.18414:
	load    6($i1), $i1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18415
	li      0, $i2
	b       ble_cont.18416
ble_else.18415:
	li      1, $i2
ble_cont.18416:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18417
	mov     $i2, $i1
	b       be_cont.18418
be_else.18417:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18419
	li      1, $i1
	b       be_cont.18420
be_else.18419:
	li      0, $i1
be_cont.18420:
be_cont.18418:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18421
	li      1, $i1
	ret
be_else.18421:
	li      0, $i1
	ret
check_all_inside.3141:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18422
	li      1, $i1
	ret
be_else.18422:
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
	bne     $i12, be_else.18423
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     is_rect_outside.3121
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18424
be_else.18423:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18425
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
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18427
	li      0, $i2
	b       ble_cont.18428
ble_else.18427:
	li      1, $i2
ble_cont.18428:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18429
	mov     $i2, $i1
	b       be_cont.18430
be_else.18429:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18431
	li      1, $i1
	b       be_cont.18432
be_else.18431:
	li      0, $i1
be_cont.18432:
be_cont.18430:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18433
	li      1, $i1
	b       be_cont.18434
be_else.18433:
	li      0, $i1
be_cont.18434:
	b       be_cont.18426
be_else.18425:
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
	bne     $i12, be_else.18435
	li      l.13301, $i2
	load    0($i2), $f2
	fsub    $f1, $f2, $f1
	b       be_cont.18436
be_else.18435:
be_cont.18436:
	load    6($i1), $i1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18437
	li      0, $i2
	b       ble_cont.18438
ble_else.18437:
	li      1, $i2
ble_cont.18438:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18439
	mov     $i2, $i1
	b       be_cont.18440
be_else.18439:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18441
	li      1, $i1
	b       be_cont.18442
be_else.18441:
	li      0, $i1
be_cont.18442:
be_cont.18440:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18443
	li      1, $i1
	b       be_cont.18444
be_else.18443:
	li      0, $i1
be_cont.18444:
be_cont.18426:
be_cont.18424:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18445
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    3($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18446
	li      1, $i1
	ret
be_else.18446:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18447
	load    6($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $f1
	load    1($sp), $f2
	load    0($sp), $f3
	load    3($sp), $i2
	b       check_all_inside.3141
be_else.18447:
	li      0, $i1
	ret
be_else.18445:
	li      0, $i1
	ret
shadow_check_and_group.3147:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18448
	li      0, $i1
	ret
be_else.18448:
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
	bne     $i12, be_else.18449
	load    0($i2), $i2
	mov     $i4, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18450
be_else.18449:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18451
	load    0($i3), $f4
	li      l.13298, $i1
	load    0($i1), $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.18453
	li      0, $i1
	b       ble_cont.18454
ble_else.18453:
	li      1, $i1
ble_cont.18454:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18455
	li      0, $i1
	b       be_cont.18456
be_else.18455:
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
be_cont.18456:
	b       be_cont.18452
be_else.18451:
	mov     $i3, $i2
	mov     $i4, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18452:
be_cont.18450:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18457
	li      0, $i1
	b       be_cont.18458
be_else.18457:
	li      l.13641, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18459
	li      0, $i1
	b       ble_cont.18460
ble_else.18459:
	li      1, $i1
ble_cont.18460:
be_cont.18458:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18461
	li      min_caml_objects, $i1
	load    2($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18462
	li      0, $i1
	ret
be_else.18462:
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_and_group.3147
be_else.18461:
	li      l.13643, $i1
	load    0($i1), $f2
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
	bne     $i12, be_else.18463
	li      1, $i1
	b       be_cont.18464
be_else.18463:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18465
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
	b       be_cont.18466
be_else.18465:
	li      0, $i1
be_cont.18466:
be_cont.18464:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18467
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_and_group.3147
be_else.18467:
	li      1, $i1
	ret
shadow_check_one_or_group.3150:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18468
	li      0, $i1
	ret
be_else.18468:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18469
	load    1($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18470
	li      0, $i1
	ret
be_else.18470:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18471
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18472
	li      0, $i1
	ret
be_else.18472:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18473
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i3
	li      -1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18474
	li      0, $i1
	ret
be_else.18474:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18475
	load    4($sp), $i1
	add     $i1, 1, $i1
	load    0($sp), $i2
	b       shadow_check_one_or_group.3150
be_else.18475:
	li      1, $i1
	ret
be_else.18473:
	li      1, $i1
	ret
be_else.18471:
	li      1, $i1
	ret
be_else.18469:
	li      1, $i1
	ret
shadow_check_one_or_matrix.3153:
	add     $i2, $i1, $i12
	load    0($i12), $i3
	load    0($i3), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18476
	li      0, $i1
	ret
be_else.18476:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18477
	li      1, $i1
	b       be_cont.18478
be_else.18477:
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
	bne     $i12, be_else.18479
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
	b       be_cont.18480
be_else.18479:
	li      2, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18481
	load    0($i2), $f4
	li      l.13298, $i1
	load    0($i1), $f5
	fcmp    $f5, $f4, $i12
	bg      $i12, ble_else.18483
	li      0, $i1
	b       ble_cont.18484
ble_else.18483:
	li      1, $i1
ble_cont.18484:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18485
	li      0, $i1
	b       be_cont.18486
be_else.18485:
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
be_cont.18486:
	b       be_cont.18482
be_else.18481:
	mov     $i3, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     solver_second_fast.3075
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18482:
be_cont.18480:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18487
	li      0, $i1
	b       be_cont.18488
be_else.18487:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	li      l.13646, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18489
	li      0, $i1
	b       ble_cont.18490
ble_else.18489:
	li      1, $i1
ble_cont.18490:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18491
	li      0, $i1
	b       be_cont.18492
be_else.18491:
	load    0($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18493
	li      0, $i1
	b       be_cont.18494
be_else.18493:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18495
	load    0($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18497
	li      0, $i1
	b       be_cont.18498
be_else.18497:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18499
	load    0($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18501
	li      0, $i1
	b       be_cont.18502
be_else.18501:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18503
	li      4, $i1
	load    0($sp), $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18504
be_else.18503:
	li      1, $i1
be_cont.18504:
be_cont.18502:
	b       be_cont.18500
be_else.18499:
	li      1, $i1
be_cont.18500:
be_cont.18498:
	b       be_cont.18496
be_else.18495:
	li      1, $i1
be_cont.18496:
be_cont.18494:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18505
	li      0, $i1
	b       be_cont.18506
be_else.18505:
	li      1, $i1
be_cont.18506:
be_cont.18492:
be_cont.18488:
be_cont.18478:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18507
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	b       shadow_check_one_or_matrix.3153
be_else.18507:
	load    0($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18508
	li      0, $i1
	b       be_cont.18509
be_else.18508:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18510
	load    0($sp), $i1
	load    2($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18512
	li      0, $i1
	b       be_cont.18513
be_else.18512:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18514
	load    0($sp), $i1
	load    3($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18516
	li      0, $i1
	b       be_cont.18517
be_else.18516:
	li      min_caml_and_net, $i1
	add     $i1, $i2, $i12
	load    0($i12), $i2
	li      0, $i1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_and_group.3147
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18518
	li      4, $i1
	load    0($sp), $i2
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     shadow_check_one_or_group.3150
	sub     $sp, 4, $sp
	load    3($sp), $ra
	b       be_cont.18519
be_else.18518:
	li      1, $i1
be_cont.18519:
be_cont.18517:
	b       be_cont.18515
be_else.18514:
	li      1, $i1
be_cont.18515:
be_cont.18513:
	b       be_cont.18511
be_else.18510:
	li      1, $i1
be_cont.18511:
be_cont.18509:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18520
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	b       shadow_check_one_or_matrix.3153
be_else.18520:
	li      1, $i1
	ret
solve_each_element.3156:
	add     $i2, $i1, $i12
	load    0($i12), $i4
	li      -1, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18521
	ret
be_else.18521:
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
	bne     $i12, be_else.18523
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18525
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18527
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18529
	li      0, $i1
	b       be_cont.18530
be_else.18529:
	li      3, $i1
be_cont.18530:
	b       be_cont.18528
be_else.18527:
	li      2, $i1
be_cont.18528:
	b       be_cont.18526
be_else.18525:
	li      1, $i1
be_cont.18526:
	b       be_cont.18524
be_else.18523:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18531
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18532
be_else.18531:
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18532:
be_cont.18524:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18533
	li      min_caml_objects, $i1
	load    3($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18534
	ret
be_else.18534:
	load    2($sp), $i1
	add     $i1, 1, $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       solve_each_element.3156
be_else.18533:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18536
	li      0, $i2
	b       ble_cont.18537
ble_else.18536:
	li      1, $i2
ble_cont.18537:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18538
	b       be_cont.18539
be_else.18538:
	li      min_caml_tmin, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18540
	li      0, $i2
	b       ble_cont.18541
ble_else.18540:
	li      1, $i2
ble_cont.18541:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18542
	b       be_cont.18543
be_else.18542:
	store   $i1, 8($sp)
	li      l.13643, $i1
	load    0($i1), $f2
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
	bne     $i12, be_else.18544
	li      1, $i1
	b       be_cont.18545
be_else.18544:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18546
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
	b       be_cont.18547
be_else.18546:
	li      0, $i1
be_cont.18547:
be_cont.18545:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18548
	b       be_cont.18549
be_else.18548:
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
be_cont.18549:
be_cont.18543:
be_cont.18539:
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
	bne     $i12, be_else.18550
	ret
be_else.18550:
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
	bne     $i12, be_else.18552
	ret
be_else.18552:
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
	bne     $i12, be_else.18554
	ret
be_else.18554:
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
	bne     $i12, be_else.18556
	ret
be_else.18556:
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
	bne     $i12, be_else.18558
	ret
be_else.18558:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18560
	load    1($i4), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18562
	b       be_cont.18563
be_else.18562:
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
	bne     $i12, be_else.18564
	b       be_cont.18565
be_else.18564:
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
	bne     $i12, be_else.18566
	b       be_cont.18567
be_else.18566:
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
be_cont.18567:
be_cont.18565:
be_cont.18563:
	b       be_cont.18561
be_else.18560:
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
	bne     $i12, be_else.18568
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18570
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18572
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18574
	li      0, $i1
	b       be_cont.18575
be_else.18574:
	li      3, $i1
be_cont.18575:
	b       be_cont.18573
be_else.18572:
	li      2, $i1
be_cont.18573:
	b       be_cont.18571
be_else.18570:
	li      1, $i1
be_cont.18571:
	b       be_cont.18569
be_else.18568:
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18576
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_surface.3033
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18577
be_else.18576:
	mov     $i2, $i1
	mov     $i3, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     solver_second.3052
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18577:
be_cont.18569:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18578
	b       be_cont.18579
be_else.18578:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	li      min_caml_tmin, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18580
	li      0, $i1
	b       ble_cont.18581
ble_else.18580:
	li      1, $i1
ble_cont.18581:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18582
	b       be_cont.18583
be_else.18582:
	load    3($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18584
	b       be_cont.18585
be_else.18584:
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
	bne     $i12, be_else.18586
	b       be_cont.18587
be_else.18586:
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
	bne     $i12, be_else.18588
	b       be_cont.18589
be_else.18588:
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
be_cont.18589:
be_cont.18587:
be_cont.18585:
be_cont.18583:
be_cont.18579:
be_cont.18561:
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
	bne     $i12, be_else.18590
	ret
be_else.18590:
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
	bne     $i12, be_else.18592
	load    0($i3), $i2
	mov     $i4, $i3
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18593
be_else.18592:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18594
	load    0($i4), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18596
	li      0, $i1
	b       ble_cont.18597
ble_else.18596:
	li      1, $i1
ble_cont.18597:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18598
	li      0, $i1
	b       be_cont.18599
be_else.18598:
	li      min_caml_solver_dist, $i1
	load    0($i4), $f1
	load    3($i2), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.18599:
	b       be_cont.18595
be_else.18594:
	mov     $i2, $i3
	mov     $i4, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18595:
be_cont.18593:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18600
	li      min_caml_objects, $i1
	load    4($sp), $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	load    6($i1), $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18601
	ret
be_else.18601:
	load    3($sp), $i1
	add     $i1, 1, $i1
	load    2($sp), $i2
	load    1($sp), $i3
	b       solve_each_element_fast.3170
be_else.18600:
	li      min_caml_solver_dist, $i2
	load    0($i2), $f1
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18603
	li      0, $i2
	b       ble_cont.18604
ble_else.18603:
	li      1, $i2
ble_cont.18604:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18605
	b       be_cont.18606
be_else.18605:
	li      min_caml_tmin, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18607
	li      0, $i2
	b       ble_cont.18608
ble_else.18607:
	li      1, $i2
ble_cont.18608:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18609
	b       be_cont.18610
be_else.18609:
	store   $i1, 5($sp)
	li      l.13643, $i1
	load    0($i1), $f2
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
	bne     $i12, be_else.18611
	li      1, $i1
	b       be_cont.18612
be_else.18611:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18613
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
	b       be_cont.18614
be_else.18613:
	li      0, $i1
be_cont.18614:
be_cont.18612:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18615
	b       be_cont.18616
be_else.18615:
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
be_cont.18616:
be_cont.18610:
be_cont.18606:
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
	bne     $i12, be_else.18617
	ret
be_else.18617:
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
	bne     $i12, be_else.18619
	ret
be_else.18619:
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
	bne     $i12, be_else.18621
	ret
be_else.18621:
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
	bne     $i12, be_else.18623
	ret
be_else.18623:
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
	bne     $i12, be_else.18625
	ret
be_else.18625:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $i1, 2($sp)
	li      99, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18627
	load    1($i4), $i1
	li      -1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18629
	b       be_cont.18630
be_else.18629:
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
	bne     $i12, be_else.18631
	b       be_cont.18632
be_else.18631:
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
	bne     $i12, be_else.18633
	b       be_cont.18634
be_else.18633:
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
be_cont.18634:
be_cont.18632:
be_cont.18630:
	b       be_cont.18628
be_else.18627:
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
	bne     $i12, be_else.18635
	load    0($i3), $i2
	mov     $i4, $i3
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_rect_fast.3062
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18636
be_else.18635:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18637
	load    0($i4), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18639
	li      0, $i1
	b       ble_cont.18640
ble_else.18639:
	li      1, $i1
ble_cont.18640:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18641
	li      0, $i1
	b       be_cont.18642
be_else.18641:
	li      min_caml_solver_dist, $i1
	load    0($i4), $f1
	load    3($i2), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 0($i1)
	li      1, $i1
be_cont.18642:
	b       be_cont.18638
be_else.18637:
	mov     $i2, $i3
	mov     $i4, $i2
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     solver_second_fast2.3092
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18638:
be_cont.18636:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18643
	b       be_cont.18644
be_else.18643:
	li      min_caml_solver_dist, $i1
	load    0($i1), $f1
	li      min_caml_tmin, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18645
	li      0, $i1
	b       ble_cont.18646
ble_else.18645:
	li      1, $i1
ble_cont.18646:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18647
	b       be_cont.18648
be_else.18647:
	load    3($sp), $i1
	load    1($i1), $i2
	li      -1, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18649
	b       be_cont.18650
be_else.18649:
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
	bne     $i12, be_else.18651
	b       be_cont.18652
be_else.18651:
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
	bne     $i12, be_else.18653
	b       be_cont.18654
be_else.18653:
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
be_cont.18654:
be_cont.18652:
be_cont.18650:
be_cont.18648:
be_cont.18644:
be_cont.18628:
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18655
	li      min_caml_nvector, $i2
	store   $f4, 0($i2)
	li      min_caml_nvector, $i2
	store   $f5, 1($i2)
	li      min_caml_nvector, $i2
	store   $f6, 2($i2)
	b       be_cont.18656
be_else.18655:
	li      min_caml_nvector, $i2
	load    9($i1), $i3
	load    2($i3), $f7
	fmul    $f2, $f7, $f7
	load    9($i1), $i3
	load    1($i3), $f8
	fmul    $f3, $f8, $f8
	fadd    $f7, $f8, $f7
	li      l.13374, $i3
	load    0($i3), $f8
	finv    $f8, $f15
	fmul    $f7, $f15, $f7
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
	li      l.13374, $i3
	load    0($i3), $f4
	finv    $f4, $f15
	fmul    $f3, $f15, $f3
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
	li      l.13374, $i3
	load    0($i3), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	fadd    $f6, $f1, $f1
	store   $f1, 2($i2)
be_cont.18656:
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
	bne     $i12, be_else.18657
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    0($i2), $f1
	load    5($i1), $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 2($sp)
	li      l.13708, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_floor
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      l.13710, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    2($sp), $f2
	fsub    $f2, $f1, $f1
	li      l.13683, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18658
	li      0, $i1
	b       ble_cont.18659
ble_else.18658:
	li      1, $i1
ble_cont.18659:
	store   $i1, 3($sp)
	load    1($sp), $i1
	load    2($i1), $f1
	load    0($sp), $i1
	load    5($i1), $i1
	load    2($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 4($sp)
	li      l.13708, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     min_caml_floor
	sub     $sp, 6, $sp
	load    5($sp), $ra
	li      l.13710, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	load    4($sp), $f2
	fsub    $f2, $f1, $f1
	li      l.13683, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18660
	li      0, $i1
	b       ble_cont.18661
ble_else.18660:
	li      1, $i1
ble_cont.18661:
	li      min_caml_texture_color, $i2
	load    3($sp), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18662
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18664
	li      l.13679, $i1
	load    0($i1), $f1
	b       be_cont.18665
be_else.18664:
	li      l.13298, $i1
	load    0($i1), $f1
be_cont.18665:
	b       be_cont.18663
be_else.18662:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18666
	li      l.13298, $i1
	load    0($i1), $f1
	b       be_cont.18667
be_else.18666:
	li      l.13679, $i1
	load    0($i1), $f1
be_cont.18667:
be_cont.18663:
	store   $f1, 1($i2)
	ret
be_else.18657:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18669
	load    1($i2), $f1
	li      l.13696, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18670
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18672
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18674
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18676
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       ble_cont.18677
ble_else.18676:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18677:
	b       ble_cont.18675
ble_else.18674:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18675:
	b       ble_cont.18673
ble_else.18672:
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     cordic_sin.2851
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18673:
	b       ble_cont.18671
ble_else.18670:
	fneg    $f1, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     sin.2857
	sub     $sp, 6, $sp
	load    5($sp), $ra
	fneg    $f1, $f1
ble_cont.18671:
	fmul    $f1, $f1, $f1
	li      min_caml_texture_color, $i1
	li      l.13679, $i2
	load    0($i2), $f2
	fmul    $f2, $f1, $f2
	store   $f2, 0($i1)
	li      min_caml_texture_color, $i1
	li      l.13679, $i2
	load    0($i2), $f2
	li      l.13301, $i2
	load    0($i2), $f3
	fsub    $f3, $f1, $f1
	fmul    $f2, $f1, $f1
	store   $f1, 1($i1)
	ret
be_else.18669:
	li      3, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18679
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
	li      l.13683, $i1
	load    0($i1), $f2
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
	li      l.13665, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18680
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18682
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18684
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18686
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       ble_cont.18687
ble_else.18686:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18687:
	b       ble_cont.18685
ble_else.18684:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
	fneg    $f1, $f1
ble_cont.18685:
	b       ble_cont.18683
ble_else.18682:
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cordic_cos.2853
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18683:
	b       ble_cont.18681
ble_else.18680:
	fneg    $f1, $f1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     cos.2859
	sub     $sp, 7, $sp
	load    6($sp), $ra
ble_cont.18681:
	fmul    $f1, $f1, $f1
	li      min_caml_texture_color, $i1
	li      l.13679, $i2
	load    0($i2), $f2
	fmul    $f1, $f2, $f2
	store   $f2, 1($i1)
	li      min_caml_texture_color, $i1
	li      l.13301, $i2
	load    0($i2), $f2
	fsub    $f2, $f1, $f1
	li      l.13679, $i2
	load    0($i2), $f2
	fmul    $f1, $f2, $f1
	store   $f1, 2($i1)
	ret
be_else.18679:
	li      4, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18689
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
	li      l.13298, $i1
	load    0($i1), $f3
	fcmp    $f3, $f2, $i12
	bg      $i12, ble_else.18690
	mov     $f2, $f3
	b       ble_cont.18691
ble_else.18690:
	fneg    $f2, $f3
ble_cont.18691:
	li      l.13658, $i1
	load    0($i1), $f4
	fcmp    $f4, $f3, $i12
	bg      $i12, ble_else.18692
	li      0, $i1
	b       ble_cont.18693
ble_else.18692:
	li      1, $i1
ble_cont.18693:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18694
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18696
	b       ble_cont.18697
ble_else.18696:
	fneg    $f1, $f1
ble_cont.18697:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     cordic_atan.2855
	sub     $sp, 11, $sp
	load    10($sp), $ra
	li      l.13663, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13665, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	b       be_cont.18695
be_else.18694:
	li      l.13660, $i1
	load    0($i1), $f1
be_cont.18695:
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
	li      l.13298, $i1
	load    0($i1), $f2
	load    9($sp), $f3
	fcmp    $f2, $f3, $i12
	bg      $i12, ble_else.18698
	mov     $f3, $f2
	b       ble_cont.18699
ble_else.18698:
	fneg    $f3, $f2
ble_cont.18699:
	li      l.13658, $i1
	load    0($i1), $f4
	fcmp    $f4, $f2, $i12
	bg      $i12, ble_else.18700
	li      0, $i1
	b       ble_cont.18701
ble_else.18700:
	li      1, $i1
ble_cont.18701:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18702
	finv    $f3, $f15
	fmul    $f1, $f15, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18704
	b       ble_cont.18705
ble_else.18704:
	fneg    $f1, $f1
ble_cont.18705:
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     cordic_atan.2855
	sub     $sp, 14, $sp
	load    13($sp), $ra
	li      l.13663, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13665, $i1
	load    0($i1), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	b       be_cont.18703
be_else.18702:
	li      l.13660, $i1
	load    0($i1), $f1
be_cont.18703:
	store   $f1, 13($sp)
	store   $ra, 14($sp)
	add     $sp, 15, $sp
	jal     min_caml_floor
	sub     $sp, 15, $sp
	load    14($sp), $ra
	load    13($sp), $f2
	fsub    $f2, $f1, $f1
	li      l.13673, $i1
	load    0($i1), $f2
	li      l.13293, $i1
	load    0($i1), $f3
	load    11($sp), $f4
	fsub    $f3, $f4, $f3
	fmul    $f3, $f3, $f3
	fsub    $f2, $f3, $f2
	li      l.13293, $i1
	load    0($i1), $f3
	fsub    $f3, $f1, $f1
	fmul    $f1, $f1, $f1
	fsub    $f2, $f1, $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18706
	li      0, $i1
	b       ble_cont.18707
ble_else.18706:
	li      1, $i1
ble_cont.18707:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18708
	b       be_cont.18709
be_else.18708:
	li      l.13298, $i1
	load    0($i1), $f1
be_cont.18709:
	li      min_caml_texture_color, $i1
	li      l.13679, $i2
	load    0($i2), $f2
	fmul    $f2, $f1, $f1
	li      l.13681, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $f1, 2($i1)
	ret
be_else.18689:
	ret
add_light.3196:
	li      l.13298, $i1
	load    0($i1), $f4
	fcmp    $f1, $f4, $i12
	bg      $i12, ble_else.18712
	li      0, $i1
	b       ble_cont.18713
ble_else.18712:
	li      1, $i1
ble_cont.18713:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18714
	b       be_cont.18715
be_else.18714:
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
be_cont.18715:
	li      l.13298, $i1
	load    0($i1), $f1
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18716
	li      0, $i1
	b       ble_cont.18717
ble_else.18716:
	li      1, $i1
ble_cont.18717:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18718
	ret
be_else.18718:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18721
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
	li      l.13722, $i2
	load    0($i2), $f1
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
	li      l.13646, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18722
	li      0, $i1
	b       ble_cont.18723
ble_else.18722:
	li      1, $i1
ble_cont.18723:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18724
	li      0, $i1
	b       be_cont.18725
be_else.18724:
	li      l.13725, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18726
	li      0, $i1
	b       ble_cont.18727
ble_else.18726:
	li      1, $i1
ble_cont.18727:
be_cont.18725:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18728
	b       be_cont.18729
be_else.18728:
	li      min_caml_intersected_object_id, $i1
	load    0($i1), $i1
	sll     $i1, 2, $i1
	li      min_caml_intsec_rectside, $i2
	load    0($i2), $i2
	add     $i1, $i2, $i1
	load    4($sp), $i2
	load    0($i2), $i3
	cmp     $i1, $i3, $i12
	bne     $i12, be_else.18730
	li      0, $i1
	li      min_caml_or_net, $i2
	load    0($i2), $i2
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     shadow_check_one_or_matrix.3153
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18732
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
	b       be_cont.18733
be_else.18732:
be_cont.18733:
	b       be_cont.18731
be_else.18730:
be_cont.18731:
be_cont.18729:
	load    3($sp), $i1
	sub     $i1, 1, $i1
	load    1($sp), $f1
	load    0($sp), $f2
	load    2($sp), $i2
	b       trace_reflections.3200
bge_else.18721:
	ret
trace_ray.3205:
	li      4, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18735
	store   $f2, 0($sp)
	store   $i3, 1($sp)
	store   $f1, 2($sp)
	store   $i2, 3($sp)
	store   $i1, 4($sp)
	load    2($i3), $i1
	store   $i1, 5($sp)
	li      min_caml_tmin, $i1
	li      l.13722, $i3
	load    0($i3), $f1
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
	li      l.13646, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18736
	li      0, $i1
	b       ble_cont.18737
ble_else.18736:
	li      1, $i1
ble_cont.18737:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18738
	li      0, $i1
	b       be_cont.18739
be_else.18738:
	li      l.13725, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18740
	li      0, $i1
	b       ble_cont.18741
ble_else.18740:
	li      1, $i1
ble_cont.18741:
be_cont.18739:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18742
	li      -1, $i1
	load    4($sp), $i2
	load    5($sp), $i3
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18743
	ret
be_else.18743:
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18745
	li      0, $i1
	b       ble_cont.18746
ble_else.18745:
	li      1, $i1
ble_cont.18746:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18747
	ret
be_else.18747:
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
be_else.18742:
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
	bne     $i12, be_else.18750
	li      min_caml_intsec_rectside, $i1
	load    0($i1), $i1
	li      min_caml_nvector, $i2
	li      l.13298, $i3
	load    0($i3), $f1
	store   $f1, 0($i2)
	store   $f1, 1($i2)
	store   $f1, 2($i2)
	li      min_caml_nvector, $i2
	sub     $i1, 1, $i3
	sub     $i1, 1, $i1
	load    3($sp), $i4
	add     $i4, $i1, $i12
	load    0($i12), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18752
	li      1, $i1
	b       be_cont.18753
be_else.18752:
	li      0, $i1
be_cont.18753:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18754
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18756
	li      0, $i1
	b       ble_cont.18757
ble_else.18756:
	li      1, $i1
ble_cont.18757:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18758
	li      l.13423, $i1
	load    0($i1), $f1
	b       be_cont.18759
be_else.18758:
	li      l.13301, $i1
	load    0($i1), $f1
be_cont.18759:
	b       be_cont.18755
be_else.18754:
	li      l.13298, $i1
	load    0($i1), $f1
be_cont.18755:
	fneg    $f1, $f1
	add     $i2, $i3, $i12
	store   $f1, 0($i12)
	b       be_cont.18751
be_else.18750:
	li      2, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18760
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
	b       be_cont.18761
be_else.18760:
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     get_nvector_second.3188
	sub     $sp, 11, $sp
	load    10($sp), $ra
be_cont.18761:
be_cont.18751:
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
	li      l.13293, $i5
	load    0($i5), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18762
	li      0, $i5
	b       ble_cont.18763
ble_else.18762:
	li      1, $i5
ble_cont.18763:
	li      0, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18764
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
	li      l.13737, $i5
	load    0($i5), $f1
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
	b       be_cont.18765
be_else.18764:
	li      0, $i1
	add     $i3, $i2, $i12
	store   $i1, 0($i12)
be_cont.18765:
	li      l.13739, $i1
	load    0($i1), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18766
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
	b       be_cont.18767
be_else.18766:
be_cont.18767:
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
	li      l.13741, $i1
	load    0($i1), $f1
	load    2($sp), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18768
	li      0, $i1
	b       ble_cont.18769
ble_else.18768:
	li      1, $i1
ble_cont.18769:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18770
	ret
be_else.18770:
	load    4($sp), $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18772
	b       bge_cont.18773
bge_else.18772:
	add     $i1, 1, $i1
	li      -1, $i2
	load    5($sp), $i3
	add     $i3, $i1, $i12
	store   $i2, 0($i12)
bge_cont.18773:
	load    8($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18774
	li      l.13301, $i1
	load    0($i1), $f1
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
be_else.18774:
	ret
ble_else.18735:
	ret
trace_diffuse_ray.3211:
	store   $f1, 0($sp)
	store   $i1, 1($sp)
	li      min_caml_tmin, $i2
	li      l.13722, $i3
	load    0($i3), $f1
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
	li      l.13646, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18777
	li      0, $i1
	b       ble_cont.18778
ble_else.18777:
	li      1, $i1
ble_cont.18778:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18779
	li      0, $i1
	b       be_cont.18780
be_else.18779:
	li      l.13725, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18781
	li      0, $i1
	b       ble_cont.18782
ble_else.18781:
	li      1, $i1
ble_cont.18782:
be_cont.18780:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18783
	ret
be_else.18783:
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
	bne     $i12, be_else.18785
	li      min_caml_intsec_rectside, $i1
	load    0($i1), $i1
	li      min_caml_nvector, $i3
	li      l.13298, $i4
	load    0($i4), $f1
	store   $f1, 0($i3)
	store   $f1, 1($i3)
	store   $f1, 2($i3)
	li      min_caml_nvector, $i3
	sub     $i1, 1, $i4
	sub     $i1, 1, $i1
	add     $i2, $i1, $i12
	load    0($i12), $f1
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bne     $i12, be_else.18787
	li      1, $i1
	b       be_cont.18788
be_else.18787:
	li      0, $i1
be_cont.18788:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18789
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18791
	li      0, $i1
	b       ble_cont.18792
ble_else.18791:
	li      1, $i1
ble_cont.18792:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18793
	li      l.13423, $i1
	load    0($i1), $f1
	b       be_cont.18794
be_else.18793:
	li      l.13301, $i1
	load    0($i1), $f1
be_cont.18794:
	b       be_cont.18790
be_else.18789:
	li      l.13298, $i1
	load    0($i1), $f1
be_cont.18790:
	fneg    $f1, $f1
	add     $i3, $i4, $i12
	store   $f1, 0($i12)
	b       be_cont.18786
be_else.18785:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18795
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
	b       be_cont.18796
be_else.18795:
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     get_nvector_second.3188
	sub     $sp, 4, $sp
	load    3($sp), $ra
be_cont.18796:
be_cont.18786:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18797
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
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18798
	li      0, $i1
	b       ble_cont.18799
ble_else.18798:
	li      1, $i1
ble_cont.18799:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18800
	li      l.13298, $i1
	load    0($i1), $f1
	b       be_cont.18801
be_else.18800:
be_cont.18801:
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
be_else.18797:
	ret
iter_trace_diffuse_rays.3214:
	li      0, $i12
	cmp     $i4, $i12, $i12
	bl      $i12, bge_else.18804
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
	li      l.13298, $i2
	load    0($i2), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18805
	li      0, $i2
	b       ble_cont.18806
ble_else.18805:
	li      1, $i2
ble_cont.18806:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18807
	add     $i1, $i4, $i12
	load    0($i12), $i1
	li      l.13759, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
	b       be_cont.18808
be_else.18807:
	add     $i4, 1, $i2
	add     $i1, $i2, $i12
	load    0($i12), $i1
	li      l.13757, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 5, $sp
	load    4($sp), $ra
be_cont.18808:
	load    3($sp), $i1
	sub     $i1, 2, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18809
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
	li      l.13298, $i3
	load    0($i3), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18810
	li      0, $i3
	b       ble_cont.18811
ble_else.18810:
	li      1, $i3
ble_cont.18811:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18812
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      l.13759, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18813
be_else.18812:
	add     $i1, 1, $i1
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      l.13757, $i2
	load    0($i2), $f2
	finv    $f2, $f15
	fmul    $f1, $f15, $f1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     trace_diffuse_ray.3211
	sub     $sp, 6, $sp
	load    5($sp), $ra
be_cont.18813:
	load    4($sp), $i1
	sub     $i1, 2, $i4
	load    2($sp), $i1
	load    1($sp), $i2
	load    0($sp), $i3
	b       iter_trace_diffuse_rays.3214
bge_else.18809:
	ret
bge_else.18804:
	ret
trace_diffuse_ray_80percent.3223:
	store   $i2, 0($sp)
	store   $i3, 1($sp)
	store   $i1, 2($sp)
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18816
	b       be_cont.18817
be_else.18816:
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
be_cont.18817:
	load    2($sp), $i1
	li      1, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18818
	b       be_cont.18819
be_else.18818:
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
be_cont.18819:
	load    2($sp), $i1
	li      2, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18820
	b       be_cont.18821
be_else.18820:
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
be_cont.18821:
	load    2($sp), $i1
	li      3, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18822
	b       be_cont.18823
be_else.18822:
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
be_cont.18823:
	load    2($sp), $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.18824
	ret
be_else.18824:
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
	bg      $i12, ble_else.18826
	load    2($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bl      $i12, bge_else.18827
	store   $i1, 0($sp)
	store   $i2, 1($sp)
	load    3($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18828
	b       be_cont.18829
be_else.18828:
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
be_cont.18829:
	load    1($sp), $i1
	add     $i1, 1, $i1
	li      4, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18830
	load    0($sp), $i2
	load    2($i2), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bl      $i12, bge_else.18831
	store   $i1, 3($sp)
	load    3($i2), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18832
	b       be_cont.18833
be_else.18832:
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
be_cont.18833:
	load    3($sp), $i1
	add     $i1, 1, $i2
	load    0($sp), $i1
	b       do_without_neighbors.3236
bge_else.18831:
	ret
ble_else.18830:
	ret
bge_else.18827:
	ret
ble_else.18826:
	ret
try_exploit_neighbors.3252:
	add     $i4, $i1, $i12
	load    0($i12), $i7
	li      4, $i12
	cmp     $i6, $i12, $i12
	bg      $i12, ble_else.18838
	load    2($i7), $i8
	add     $i8, $i6, $i12
	load    0($i12), $i8
	li      0, $i12
	cmp     $i8, $i12, $i12
	bl      $i12, bge_else.18839
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
	bne     $i12, be_else.18840
	add     $i5, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18842
	sub     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18844
	add     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	add     $i9, $i6, $i12
	load    0($i12), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18846
	li      1, $i8
	b       be_cont.18847
be_else.18846:
	li      0, $i8
be_cont.18847:
	b       be_cont.18845
be_else.18844:
	li      0, $i8
be_cont.18845:
	b       be_cont.18843
be_else.18842:
	li      0, $i8
be_cont.18843:
	b       be_cont.18841
be_else.18840:
	li      0, $i8
be_cont.18841:
	li      0, $i12
	cmp     $i8, $i12, $i12
	bne     $i12, be_else.18848
	add     $i4, $i1, $i12
	load    0($i12), $i1
	li      4, $i12
	cmp     $i6, $i12, $i12
	bg      $i12, ble_else.18849
	load    2($i1), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18850
	store   $i1, 0($sp)
	store   $i6, 1($sp)
	load    3($i1), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18851
	b       be_cont.18852
be_else.18851:
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
be_cont.18852:
	load    1($sp), $i1
	add     $i1, 1, $i2
	load    0($sp), $i1
	b       do_without_neighbors.3236
bge_else.18850:
	ret
ble_else.18849:
	ret
be_else.18848:
	store   $i2, 3($sp)
	store   $i5, 4($sp)
	store   $i3, 5($sp)
	store   $i1, 6($sp)
	store   $i4, 7($sp)
	store   $i6, 1($sp)
	load    3($i7), $i2
	add     $i2, $i6, $i12
	load    0($i12), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18855
	b       be_cont.18856
be_else.18855:
	mov     $i3, $i2
	mov     $i4, $i3
	mov     $i5, $i4
	mov     $i6, $i5
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 9, $sp
	load    8($sp), $ra
be_cont.18856:
	load    1($sp), $i1
	add     $i1, 1, $i2
	load    6($sp), $i1
	load    7($sp), $i3
	add     $i3, $i1, $i12
	load    0($i12), $i4
	li      4, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18857
	load    2($i4), $i5
	add     $i5, $i2, $i12
	load    0($i12), $i5
	li      0, $i12
	cmp     $i5, $i12, $i12
	bl      $i12, bge_else.18858
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
	bne     $i12, be_else.18859
	load    4($sp), $i7
	add     $i7, $i1, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18861
	sub     $i1, 1, $i7
	add     $i3, $i7, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18863
	add     $i1, 1, $i7
	add     $i3, $i7, $i12
	load    0($i12), $i7
	load    2($i7), $i7
	add     $i7, $i2, $i12
	load    0($i12), $i7
	cmp     $i7, $i5, $i12
	bne     $i12, be_else.18865
	li      1, $i5
	b       be_cont.18866
be_else.18865:
	li      0, $i5
be_cont.18866:
	b       be_cont.18864
be_else.18863:
	li      0, $i5
be_cont.18864:
	b       be_cont.18862
be_else.18861:
	li      0, $i5
be_cont.18862:
	b       be_cont.18860
be_else.18859:
	li      0, $i5
be_cont.18860:
	li      0, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.18867
	add     $i3, $i1, $i12
	load    0($i12), $i1
	b       do_without_neighbors.3236
be_else.18867:
	store   $i2, 8($sp)
	load    3($i4), $i4
	add     $i4, $i2, $i12
	load    0($i12), $i4
	li      0, $i12
	cmp     $i4, $i12, $i12
	bne     $i12, be_else.18868
	b       be_cont.18869
be_else.18868:
	load    4($sp), $i4
	mov     $i2, $i5
	mov     $i6, $i2
	store   $ra, 9($sp)
	add     $sp, 10, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 10, $sp
	load    9($sp), $ra
be_cont.18869:
	load    8($sp), $i1
	add     $i1, 1, $i6
	load    6($sp), $i1
	load    3($sp), $i2
	load    5($sp), $i3
	load    7($sp), $i4
	load    4($sp), $i5
	b       try_exploit_neighbors.3252
bge_else.18858:
	ret
ble_else.18857:
	ret
bge_else.18839:
	ret
ble_else.18838:
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
	bg      $i12, ble_else.18874
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18876
	b       bge_cont.18877
bge_else.18876:
	li      0, $i1
bge_cont.18877:
	b       ble_cont.18875
ble_else.18874:
	li      255, $i1
ble_cont.18875:
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
	bg      $i12, ble_else.18878
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18880
	b       bge_cont.18881
bge_else.18880:
	li      0, $i1
bge_cont.18881:
	b       ble_cont.18879
ble_else.18878:
	li      255, $i1
ble_cont.18879:
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
	bg      $i12, ble_else.18882
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18884
	b       bge_cont.18885
bge_else.18884:
	li      0, $i1
bge_cont.18885:
	b       ble_cont.18883
ble_else.18882:
	li      255, $i1
ble_cont.18883:
	b       min_caml_write
pretrace_diffuse_rays.3265:
	li      4, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18886
	load    2($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bl      $i12, bge_else.18887
	store   $i2, 0($sp)
	load    3($i1), $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.18888
	b       be_cont.18889
be_else.18888:
	store   $i1, 1($sp)
	load    6($i1), $i3
	load    0($i3), $i3
	li      min_caml_diffuse_ray, $i4
	li      l.13298, $i5
	load    0($i5), $f1
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
be_cont.18889:
	load    0($sp), $i2
	add     $i2, 1, $i2
	b       pretrace_diffuse_rays.3265
bge_else.18887:
	ret
ble_else.18886:
	ret
pretrace_pixels.3268:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18892
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13301, $i2
	load    0($i2), $f1
	li      min_caml_ptrace_dirvec, $i2
	load    1($sp), $i3
	load    2($sp), $i4
	add     $i4, $i3, $i12
	load    0($i12), $i3
	li      l.13298, $i4
	load    0($i4), $f2
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
	bl      $i12, bge_else.18893
	sub     $i1, 5, $i1
	b       bge_cont.18894
bge_else.18893:
bge_cont.18894:
	mov     $i1, $i3
	load    5($sp), $f1
	load    4($sp), $f2
	load    3($sp), $f3
	load    2($sp), $i1
	b       pretrace_pixels.3268
bge_else.18892:
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
	bg      $i12, ble_else.18896
	ret
ble_else.18896:
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
	bg      $i12, ble_else.18898
	li      0, $i6
	b       ble_cont.18899
ble_else.18898:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18900
	li      0, $i6
	b       ble_cont.18901
ble_else.18900:
	li      min_caml_image_size, $i6
	load    0($i6), $i6
	add     $i1, 1, $i7
	cmp     $i6, $i7, $i12
	bg      $i12, ble_else.18902
	li      0, $i6
	b       ble_cont.18903
ble_else.18902:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18904
	li      0, $i6
	b       ble_cont.18905
ble_else.18904:
	li      1, $i6
ble_cont.18905:
ble_cont.18903:
ble_cont.18901:
ble_cont.18899:
	li      0, $i12
	cmp     $i6, $i12, $i12
	bne     $i12, be_else.18906
	add     $i4, $i1, $i12
	load    0($i12), $i1
	load    2($i1), $i2
	load    0($i2), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18908
	store   $i1, 5($sp)
	load    3($i1), $i2
	load    0($i2), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18910
	b       be_cont.18911
be_else.18910:
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
be_cont.18911:
	li      1, $i2
	load    5($sp), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       bge_cont.18909
bge_else.18908:
bge_cont.18909:
	b       be_cont.18907
be_else.18906:
	li      0, $i6
	add     $i4, $i1, $i12
	load    0($i12), $i7
	load    2($i7), $i8
	load    0($i8), $i8
	li      0, $i12
	cmp     $i8, $i12, $i12
	bl      $i12, bge_else.18912
	add     $i4, $i1, $i12
	load    0($i12), $i8
	load    2($i8), $i8
	load    0($i8), $i8
	add     $i3, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18914
	add     $i5, $i1, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18916
	sub     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18918
	add     $i1, 1, $i9
	add     $i4, $i9, $i12
	load    0($i12), $i9
	load    2($i9), $i9
	load    0($i9), $i9
	cmp     $i9, $i8, $i12
	bne     $i12, be_else.18920
	li      1, $i8
	b       be_cont.18921
be_else.18920:
	li      0, $i8
be_cont.18921:
	b       be_cont.18919
be_else.18918:
	li      0, $i8
be_cont.18919:
	b       be_cont.18917
be_else.18916:
	li      0, $i8
be_cont.18917:
	b       be_cont.18915
be_else.18914:
	li      0, $i8
be_cont.18915:
	li      0, $i12
	cmp     $i8, $i12, $i12
	bne     $i12, be_else.18922
	add     $i4, $i1, $i12
	load    0($i12), $i1
	mov     $i6, $i2
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 8, $sp
	load    7($sp), $ra
	b       be_cont.18923
be_else.18922:
	load    3($i7), $i2
	load    0($i2), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18924
	b       be_cont.18925
be_else.18924:
	mov     $i3, $i2
	mov     $i4, $i3
	mov     $i5, $i4
	mov     $i6, $i5
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     calc_diffuse_using_5points.3230
	sub     $sp, 8, $sp
	load    7($sp), $ra
be_cont.18925:
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
be_cont.18923:
	b       bge_cont.18913
bge_else.18912:
bge_cont.18913:
be_cont.18907:
	li      min_caml_rgb, $i1
	load    0($i1), $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     min_caml_int_of_float
	sub     $sp, 8, $sp
	load    7($sp), $ra
	li      255, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18926
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18928
	b       bge_cont.18929
bge_else.18928:
	li      0, $i1
bge_cont.18929:
	b       ble_cont.18927
ble_else.18926:
	li      255, $i1
ble_cont.18927:
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
	bg      $i12, ble_else.18930
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18932
	b       bge_cont.18933
bge_else.18932:
	li      0, $i1
bge_cont.18933:
	b       ble_cont.18931
ble_else.18930:
	li      255, $i1
ble_cont.18931:
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
	bg      $i12, ble_else.18934
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18936
	b       bge_cont.18937
bge_else.18936:
	li      0, $i1
bge_cont.18937:
	b       ble_cont.18935
ble_else.18934:
	li      255, $i1
ble_cont.18935:
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
	bg      $i12, ble_else.18938
	ret
ble_else.18938:
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
	bg      $i12, ble_else.18940
	li      0, $i2
	b       ble_cont.18941
ble_else.18940:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bg      $i12, ble_else.18942
	li      0, $i2
	b       ble_cont.18943
ble_else.18942:
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	add     $i1, 1, $i5
	cmp     $i2, $i5, $i12
	bg      $i12, ble_else.18944
	li      0, $i2
	b       ble_cont.18945
ble_else.18944:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.18946
	li      0, $i2
	b       ble_cont.18947
ble_else.18946:
	li      1, $i2
ble_cont.18947:
ble_cont.18945:
ble_cont.18943:
ble_cont.18941:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18948
	add     $i4, $i1, $i12
	load    0($i12), $i1
	li      0, $i2
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       be_cont.18949
be_else.18948:
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
be_cont.18949:
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
	bg      $i12, ble_else.18950
	ret
ble_else.18950:
	store   $i2, 0($sp)
	store   $i4, 1($sp)
	store   $i3, 2($sp)
	store   $i5, 3($sp)
	store   $i1, 4($sp)
	li      min_caml_image_size, $i2
	load    1($i2), $i2
	sub     $i2, 1, $i2
	cmp     $i2, $i1, $i12
	bg      $i12, ble_else.18952
	b       ble_cont.18953
ble_else.18952:
	add     $i1, 1, $i2
	mov     $i5, $i3
	mov     $i4, $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     pretrace_line.3275
	sub     $sp, 6, $sp
	load    5($sp), $ra
ble_cont.18953:
	li      0, $i1
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18954
	b       ble_cont.18955
ble_else.18954:
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
	bg      $i12, ble_else.18956
	li      0, $i2
	b       ble_cont.18957
ble_else.18956:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bg      $i12, ble_else.18958
	li      0, $i2
	b       ble_cont.18959
ble_else.18958:
	li      min_caml_image_size, $i2
	load    0($i2), $i2
	li      1, $i12
	cmp     $i2, $i12, $i12
	bg      $i12, ble_else.18960
	li      0, $i2
	b       ble_cont.18961
ble_else.18960:
	li      0, $i2
ble_cont.18961:
ble_cont.18959:
ble_cont.18957:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bne     $i12, be_else.18962
	load    0($i4), $i1
	li      0, $i2
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     do_without_neighbors.3236
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       be_cont.18963
be_else.18962:
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
be_cont.18963:
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
ble_cont.18955:
	load    4($sp), $i1
	add     $i1, 1, $i2
	load    3($sp), $i1
	add     $i1, 2, $i1
	li      5, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18964
	sub     $i1, 5, $i1
	b       bge_cont.18965
bge_else.18964:
bge_cont.18965:
	mov     $i1, $i3
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	cmp     $i1, $i2, $i12
	bg      $i12, ble_else.18966
	ret
ble_else.18966:
	store   $i3, 5($sp)
	store   $i2, 6($sp)
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	sub     $i1, 1, $i1
	cmp     $i1, $i2, $i12
	bg      $i12, ble_else.18968
	b       ble_cont.18969
ble_else.18968:
	add     $i2, 1, $i2
	load    0($sp), $i1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     pretrace_line.3275
	sub     $sp, 8, $sp
	load    7($sp), $ra
ble_cont.18969:
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
	bl      $i12, bge_else.18970
	sub     $i2, 5, $i2
	b       bge_cont.18971
bge_else.18970:
bge_cont.18971:
	mov     $i2, $i5
	load    1($sp), $i2
	load    0($sp), $i3
	load    2($sp), $i4
	b       scan_line.3285
create_float5x3array.3291:
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 1($i2)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 2($i2)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     min_caml_create_float_array
	sub     $sp, 2, $sp
	load    1($sp), $ra
	load    0($sp), $i2
	store   $i1, 3($i2)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.18972
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18973
	store   $i1, 9($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
bge_else.18973:
	mov     $i3, $i1
	ret
bge_else.18972:
	ret
tan.3300:
	store   $f1, 0($sp)
	li      l.13298, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18974
	li      l.13317, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18976
	li      l.13319, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18978
	li      l.13322, $i1
	load    0($i1), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.18980
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	b       ble_cont.18981
ble_else.18980:
	li      l.13322, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18981:
	b       ble_cont.18979
ble_else.18978:
	li      l.13319, $i1
	load    0($i1), $f2
	fsub    $f2, $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18979:
	b       ble_cont.18977
ble_else.18976:
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     cordic_sin.2851
	sub     $sp, 2, $sp
	load    1($sp), $ra
ble_cont.18977:
	b       ble_cont.18975
ble_else.18974:
	fneg    $f1, $f1
	store   $ra, 1($sp)
	add     $sp, 2, $sp
	jal     sin.2857
	sub     $sp, 2, $sp
	load    1($sp), $ra
	fneg    $f1, $f1
ble_cont.18975:
	store   $f1, 1($sp)
	li      l.13298, $i1
	load    0($i1), $f1
	load    0($sp), $f2
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18982
	li      l.13317, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18984
	li      l.13319, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18986
	li      l.13322, $i1
	load    0($i1), $f1
	fcmp    $f1, $f2, $i12
	bg      $i12, ble_else.18988
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f2, $f1, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
	b       ble_cont.18989
ble_else.18988:
	li      l.13322, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18989:
	b       ble_cont.18987
ble_else.18986:
	li      l.13319, $i1
	load    0($i1), $f1
	fsub    $f1, $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
	fneg    $f1, $f1
ble_cont.18987:
	b       ble_cont.18985
ble_else.18984:
	mov     $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cordic_cos.2853
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18985:
	b       ble_cont.18983
ble_else.18982:
	fneg    $f2, $f1
	store   $ra, 2($sp)
	add     $sp, 3, $sp
	jal     cos.2859
	sub     $sp, 3, $sp
	load    2($sp), $ra
ble_cont.18983:
	load    1($sp), $f2
	finv    $f1, $f15
	fmul    $f2, $f15, $f1
	ret
calc_dirvec.3305:
	li      5, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18990
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $f2, 2($sp)
	store   $f1, 3($sp)
	fmul    $f1, $f1, $f1
	fmul    $f2, $f2, $f2
	fadd    $f1, $f2, $f1
	li      l.13301, $i1
	load    0($i1), $f2
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
	li      l.13301, $i1
	load    0($i1), $f4
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
bge_else.18990:
	store   $i3, 0($sp)
	store   $i2, 1($sp)
	store   $f4, 4($sp)
	store   $i1, 5($sp)
	store   $f3, 6($sp)
	fmul    $f2, $f2, $f1
	li      l.13741, $i1
	load    0($i1), $f2
	fadd    $f1, $f2, $f1
	store   $ra, 7($sp)
	add     $sp, 8, $sp
	jal     sqrt.2865
	sub     $sp, 8, $sp
	load    7($sp), $ra
	store   $f1, 7($sp)
	li      l.13301, $i1
	load    0($i1), $f2
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
	li      l.13741, $i1
	load    0($i1), $f2
	fadd    $f1, $f2, $f1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     sqrt.2865
	sub     $sp, 11, $sp
	load    10($sp), $ra
	store   $f1, 10($sp)
	li      l.13301, $i1
	load    0($i1), $f2
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18992
	store   $i1, 0($sp)
	store   $f1, 1($sp)
	store   $i3, 2($sp)
	store   $i2, 3($sp)
	store   $ra, 4($sp)
	add     $sp, 5, $sp
	jal     min_caml_float_of_int
	sub     $sp, 5, $sp
	load    4($sp), $ra
	li      l.13813, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13815, $i1
	load    0($i1), $f2
	fsub    $f1, $f2, $f3
	li      0, $i1
	li      l.13298, $i2
	load    0($i2), $f1
	li      l.13298, $i2
	load    0($i2), $f2
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
	li      l.13813, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13741, $i1
	load    0($i1), $f2
	fadd    $f1, $f2, $f3
	li      0, $i1
	li      l.13298, $i2
	load    0($i2), $f1
	li      l.13298, $i2
	load    0($i2), $f2
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
	bl      $i12, bge_else.18993
	sub     $i2, 5, $i2
	b       bge_cont.18994
bge_else.18993:
bge_cont.18994:
	load    1($sp), $f1
	load    2($sp), $i3
	b       calc_dirvecs.3313
bge_else.18992:
	ret
calc_dirvec_rows.3318:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18996
	store   $i1, 0($sp)
	store   $i3, 1($sp)
	store   $i2, 2($sp)
	store   $ra, 3($sp)
	add     $sp, 4, $sp
	jal     min_caml_float_of_int
	sub     $sp, 4, $sp
	load    3($sp), $ra
	li      l.13813, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13815, $i1
	load    0($i1), $f2
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
	bl      $i12, bge_else.18997
	sub     $i2, 5, $i2
	b       bge_cont.18998
bge_else.18997:
bge_cont.18998:
	load    1($sp), $i3
	add     $i3, 4, $i3
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.18999
	store   $i1, 3($sp)
	store   $i3, 4($sp)
	store   $i2, 5($sp)
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     min_caml_float_of_int
	sub     $sp, 7, $sp
	load    6($sp), $ra
	li      l.13813, $i1
	load    0($i1), $f2
	fmul    $f1, $f2, $f1
	li      l.13815, $i1
	load    0($i1), $f2
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
	bl      $i12, bge_else.19000
	sub     $i2, 5, $i2
	b       bge_cont.19001
bge_else.19000:
bge_cont.19001:
	load    4($sp), $i3
	add     $i3, 4, $i3
	b       calc_dirvec_rows.3318
bge_else.18999:
	ret
bge_else.18996:
	ret
create_dirvec_elements.3324:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19004
	store   $i2, 0($sp)
	store   $i1, 1($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19005
	store   $i1, 3($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19006
	store   $i1, 5($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19007
	store   $i1, 7($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
bge_else.19007:
	ret
bge_else.19006:
	ret
bge_else.19005:
	ret
bge_else.19004:
	ret
create_dirvecs.3327:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19012
	store   $i1, 0($sp)
	li      min_caml_dirvecs, $i1
	store   $i1, 1($sp)
	li      120, $i1
	store   $i1, 2($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19013
	store   $i1, 8($sp)
	li      min_caml_dirvecs, $i1
	store   $i1, 9($sp)
	li      120, $i1
	store   $i1, 10($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
bge_else.19013:
	ret
bge_else.19012:
	ret
init_dirvec_constants.3329:
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19016
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19017
	store   $i1, 2($sp)
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19018
	store   $i1, 3($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19020
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
	b       be_cont.19021
be_else.19020:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19022
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
	b       be_cont.19023
be_else.19022:
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
be_cont.19023:
be_cont.19021:
	sub     $i2, 1, $i2
	load    3($sp), $i1
	store   $ra, 6($sp)
	add     $sp, 7, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 7, $sp
	load    6($sp), $ra
	b       bge_cont.19019
bge_else.19018:
bge_cont.19019:
	load    2($sp), $i1
	sub     $i1, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19024
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19025
	store   $i1, 7($sp)
	load    0($sp), $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19026
	store   $i1, 8($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19028
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
	b       be_cont.19029
be_else.19028:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19030
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
	b       be_cont.19031
be_else.19030:
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
be_cont.19031:
be_cont.19029:
	sub     $i2, 1, $i2
	load    8($sp), $i1
	store   $ra, 11($sp)
	add     $sp, 12, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 12, $sp
	load    11($sp), $ra
	b       bge_cont.19027
bge_else.19026:
bge_cont.19027:
	load    7($sp), $i1
	sub     $i1, 1, $i2
	load    0($sp), $i1
	b       init_dirvec_constants.3329
bge_else.19025:
	ret
bge_else.19024:
	ret
bge_else.19017:
	ret
bge_else.19016:
	ret
init_vecset_constants.3332:
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19036
	store   $i1, 0($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 1($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19037
	store   $i1, 2($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19039
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
	b       be_cont.19040
be_else.19039:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19041
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
	b       be_cont.19042
be_else.19041:
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
be_cont.19042:
be_cont.19040:
	sub     $i2, 1, $i2
	load    2($sp), $i1
	store   $ra, 5($sp)
	add     $sp, 6, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 6, $sp
	load    5($sp), $ra
	b       bge_cont.19038
bge_else.19037:
bge_cont.19038:
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19043
	store   $i1, 5($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19045
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
	b       be_cont.19046
be_else.19045:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19047
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
	b       be_cont.19048
be_else.19047:
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
be_cont.19048:
be_cont.19046:
	sub     $i2, 1, $i2
	load    5($sp), $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 9, $sp
	load    8($sp), $ra
	b       bge_cont.19044
bge_else.19043:
bge_cont.19044:
	li      116, $i2
	load    1($sp), $i1
	store   $ra, 8($sp)
	add     $sp, 9, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 9, $sp
	load    8($sp), $ra
	load    0($sp), $i1
	sub     $i1, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19049
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19050
	store   $i1, 10($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19052
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
	b       be_cont.19053
be_else.19052:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19054
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
	b       be_cont.19055
be_else.19054:
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
be_cont.19055:
be_cont.19053:
	sub     $i2, 1, $i2
	load    10($sp), $i1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 14, $sp
	load    13($sp), $ra
	b       bge_cont.19051
bge_else.19050:
bge_cont.19051:
	li      117, $i2
	load    9($sp), $i1
	store   $ra, 13($sp)
	add     $sp, 14, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 14, $sp
	load    13($sp), $ra
	load    8($sp), $i1
	sub     $i1, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19056
	store   $i1, 13($sp)
	li      min_caml_dirvecs, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i1
	store   $i1, 14($sp)
	load    119($i1), $i1
	li      min_caml_n_objects, $i2
	load    0($i2), $i2
	sub     $i2, 1, $i2
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19057
	store   $i1, 15($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19059
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
	b       be_cont.19060
be_else.19059:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19061
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
	b       be_cont.19062
be_else.19061:
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
be_cont.19062:
be_cont.19060:
	sub     $i2, 1, $i2
	load    15($sp), $i1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 19, $sp
	load    18($sp), $ra
	b       bge_cont.19058
bge_else.19057:
bge_cont.19058:
	li      118, $i2
	load    14($sp), $i1
	store   $ra, 18($sp)
	add     $sp, 19, $sp
	jal     init_dirvec_constants.3329
	sub     $sp, 19, $sp
	load    18($sp), $ra
	load    13($sp), $i1
	sub     $i1, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19063
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
bge_else.19063:
	ret
bge_else.19056:
	ret
bge_else.19049:
	ret
bge_else.19036:
	ret
setup_rect_reflection.3343:
	sll     $i1, 2, $i1
	store   $i1, 0($sp)
	li      min_caml_n_reflections, $i3
	load    0($i3), $i3
	store   $i3, 1($sp)
	li      l.13301, $i3
	load    0($i3), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i4, $i12, $i12
	bl      $i12, bge_else.19068
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19070
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
	b       be_cont.19071
be_else.19070:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19072
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
	b       be_cont.19073
be_else.19072:
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
be_cont.19073:
be_cont.19071:
	sub     $i2, 1, $i2
	load    9($sp), $i1
	store   $ra, 12($sp)
	add     $sp, 13, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 13, $sp
	load    12($sp), $ra
	b       bge_cont.19069
bge_else.19068:
bge_cont.19069:
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i4, $i12, $i12
	bl      $i12, bge_else.19074
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19076
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
	b       be_cont.19077
be_else.19076:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19078
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
	b       be_cont.19079
be_else.19078:
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
be_cont.19079:
be_cont.19077:
	sub     $i2, 1, $i2
	load    16($sp), $i1
	store   $ra, 19($sp)
	add     $sp, 20, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 20, $sp
	load    19($sp), $ra
	b       bge_cont.19075
bge_else.19074:
bge_cont.19075:
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i4, $i12, $i12
	bl      $i12, bge_else.19080
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19082
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
	b       be_cont.19083
be_else.19082:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19084
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
	b       be_cont.19085
be_else.19084:
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
be_cont.19085:
be_cont.19083:
	sub     $i2, 1, $i2
	load    23($sp), $i1
	store   $ra, 26($sp)
	add     $sp, 27, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 27, $sp
	load    26($sp), $ra
	b       bge_cont.19081
bge_else.19080:
bge_cont.19081:
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
	li      l.13301, $i1
	load    0($i1), $f1
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
	li      l.13374, $i1
	load    0($i1), $f2
	load    4($i2), $i1
	load    0($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f2
	li      min_caml_light, $i1
	load    0($i1), $f3
	fsub    $f2, $f3, $f2
	store   $f2, 3($sp)
	li      l.13374, $i1
	load    0($i1), $f2
	load    4($i2), $i1
	load    1($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f2
	li      min_caml_light, $i1
	load    1($i1), $f3
	fsub    $f2, $f3, $f2
	store   $f2, 4($sp)
	li      l.13374, $i1
	load    0($i1), $f2
	load    4($i2), $i1
	load    2($i1), $f3
	fmul    $f2, $f3, $f2
	fmul    $f2, $f1, $f1
	li      min_caml_light, $i1
	load    2($i1), $f2
	fsub    $f1, $f2, $f1
	store   $f1, 5($sp)
	li      3, $i1
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i4, $i12, $i12
	bl      $i12, bge_else.19087
	li      min_caml_objects, $i2
	add     $i2, $i4, $i12
	load    0($i12), $i2
	load    1($i2), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19089
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
	b       be_cont.19090
be_else.19089:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19091
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
	b       be_cont.19092
be_else.19091:
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
be_cont.19092:
be_cont.19090:
	sub     $i2, 1, $i2
	load    7($sp), $i1
	store   $ra, 10($sp)
	add     $sp, 11, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 11, $sp
	load    10($sp), $ra
	b       bge_cont.19088
bge_else.19087:
bge_cont.19088:
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
	li      l.13908, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      l.13298, $i2
	load    0($i2), $f1
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bne     $i12, be_else.19094
	li      min_caml_n_objects, $i1
	load    29($sp), $i2
	store   $i2, 0($i1)
	b       be_cont.19095
be_else.19094:
	li      1, $i1
	store   $ra, 30($sp)
	add     $sp, 31, $sp
	jal     read_object.3006
	sub     $sp, 31, $sp
	load    30($sp), $ra
be_cont.19095:
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
	li      0, $i12
	cmp     $i2, $i12, $i12
	bl      $i12, bge_else.19096
	store   $i1, 32($sp)
	li      min_caml_objects, $i3
	add     $i3, $i2, $i12
	load    0($i12), $i3
	load    1($i1), $i4
	load    0($i1), $i1
	load    1($i3), $i5
	li      1, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19098
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
	b       be_cont.19099
be_else.19098:
	li      2, $i12
	cmp     $i5, $i12, $i12
	bne     $i12, be_else.19100
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
	b       be_cont.19101
be_else.19100:
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
be_cont.19101:
be_cont.19099:
	sub     $i2, 1, $i2
	load    32($sp), $i1
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     iter_setup_dirvec_constants.3111
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       bge_cont.19097
bge_else.19096:
bge_cont.19097:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bl      $i12, bge_else.19102
	li      min_caml_objects, $i2
	add     $i2, $i1, $i12
	load    0($i12), $i2
	load    2($i2), $i3
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.19104
	load    7($i2), $i3
	load    0($i3), $f1
	li      l.13301, $i3
	load    0($i3), $f2
	fcmp    $f2, $f1, $i12
	bg      $i12, ble_else.19106
	li      0, $i3
	b       ble_cont.19107
ble_else.19106:
	li      1, $i3
ble_cont.19107:
	li      0, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.19108
	b       be_cont.19109
be_else.19108:
	load    1($i2), $i3
	li      1, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.19110
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_rect_reflection.3343
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.19111
be_else.19110:
	li      2, $i12
	cmp     $i3, $i12, $i12
	bne     $i12, be_else.19112
	store   $ra, 35($sp)
	add     $sp, 36, $sp
	jal     setup_surface_reflection.3346
	sub     $sp, 36, $sp
	load    35($sp), $ra
	b       be_cont.19113
be_else.19112:
be_cont.19113:
be_cont.19111:
be_cont.19109:
	b       be_cont.19105
be_else.19104:
be_cont.19105:
	b       bge_cont.19103
bge_else.19102:
bge_cont.19103:
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
	li      0, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.19114
	ret
ble_else.19114:
	store   $i2, 35($sp)
	li      min_caml_image_size, $i1
	load    1($i1), $i1
	sub     $i1, 1, $i1
	li      0, $i12
	cmp     $i1, $i12, $i12
	bg      $i12, ble_else.19116
	b       ble_cont.19117
ble_else.19116:
	li      1, $i2
	load    28($sp), $i1
	store   $ra, 36($sp)
	add     $sp, 37, $sp
	jal     pretrace_line.3275
	sub     $sp, 37, $sp
	load    36($sp), $ra
ble_cont.19117:
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
l.13908:	.float  1.2800000000E+02
l.13815:	.float  9.0000000000E-01
l.13813:	.float  2.0000000000E-01
l.13759:	.float  1.5000000000E+02
l.13757:	.float  -1.5000000000E+02
l.13741:	.float  1.0000000000E-01
l.13739:	.float  -2.0000000000E+00
l.13737:	.float  3.9062500000E-03
l.13725:	.float  1.0000000000E+08
l.13722:	.float  1.0000000000E+09
l.13710:	.float  2.0000000000E+01
l.13708:	.float  5.0000000000E-02
l.13696:	.float  2.5000000000E-01
l.13683:	.float  1.0000000000E+01
l.13681:	.float  3.0000000000E-01
l.13679:	.float  2.5500000000E+02
l.13673:	.float  1.5000000000E-01
l.13665:	.float  3.1415927000E+00
l.13663:	.float  3.0000000000E+01
l.13660:	.float  1.5000000000E+01
l.13658:	.float  1.0000000000E-04
l.13646:	.float  -1.0000000000E-01
l.13643:	.float  1.0000000000E-02
l.13641:	.float  -2.0000000000E-01
l.13459:	.float  -2.0000000000E+02
l.13457:	.float  2.0000000000E+02
l.13426:	.float  1.7453293000E-02
l.13423:	.float  -1.0000000000E+00
l.13401:	.float  3.0000000000E+00
l.13374:	.float  2.0000000000E+00
l.13322:	.float  6.2831853072E+00
l.13319:	.float  3.1415926536E+00
l.13317:	.float  1.5707963268E+00
l.13301:	.float  1.0000000000E+00
l.13298:	.float  0.0000000000E+00
l.13296:	.float  6.0725293501E-01
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
