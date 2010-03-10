#レジスタ名置き換え
.define $hp $i63
.define $sp $i62
.define $tmp $i61
.define $ra $i60
.define $i63 orz
.define $i62 orz
.define $i61 orz
.define $i60 orz

#標準命令
.define { li %Imm, %iReg } { li %1 %2 }
.define { add %iReg, %Imm, %iReg } { addi %1 %2 %3 }
.define { sub %iReg, %Imm, %iReg } { subi %1 %2 %3 }
.define { mov %iReg, %iReg } { mov %1 %2 }
.define { add %iReg, %iReg, %iReg } { add %1 %2 %3 }
.define { sub %iReg, %iReg, %iReg } { sub %1 %2 %3 }
.define { cmpjmp %Imm, %iReg, %iReg, %Imm } { cmpjmp %1 %2 %3 %4 }
.define { cmpjmp %Imm, %iReg, %Imm, %Imm } { cmpijmp %1 %2 %3 %4 }
.define { cmpjmp %Imm, %fReg, %fReg, %Imm } { fcmpjmp %1 %2 %3 %4 }
.define { jal %Imm, %iReg } { jal %1 %2 }
.define { fadd %fReg, %fReg, %fReg } { fadd 0 %1 %2 %3 }
.define { fsub %fReg, %fReg, %fReg } { fsub 0 %1 %2 %3 }
.define { fmul %fReg, %fReg, %fReg } { fmul 0 %1 %2 %3 }
.define { finv %fReg, %fReg } { finv 0 %1 %2 }
.define { fsqrt %fReg, %fReg } { fsqrt 0 %1 %2 }
.define { mov %fReg, %fReg } { fmov 0 %1 %2 }
.define { fadd_a %fReg, %fReg, %fReg } { fadd 2 %1 %2 %3 }
.define { fsub_a %fReg, %fReg, %fReg } { fsub 2 %1 %2 %3 }
.define { fmul_a %fReg, %fReg, %fReg } { fmul 2 %1 %2 %3 }
.define { finv_a %fReg, %fReg } { finv 2 %1 %2 }
.define { fsqrt_a %fReg, %fReg } { fsqrt 2 %1 %2 }
.define { fabs %fReg, %fReg } { fmov 2 %1 %2 }
.define { fadd_n %fReg, %fReg, %fReg } { fadd 1 %1 %2 %3 }
.define { fsub_n %fReg, %fReg, %fReg } { fsub 1 %1 %2 %3 }
.define { fmul_n %fReg, %fReg, %fReg } { fmul 1 %1 %2 %3 }
.define { finv_n %fReg, %fReg } { finv 1 %1 %2 }
.define { fsqrt_n %fReg, %fReg } { fsqrt 1 %1 %2 }
.define { fneg %fReg, %fReg } { fmov 1 %1 %2 }
.define { load [%iReg + %Imm], %iReg } { load %1 %2 %3 }
.define { load [%iReg + %iReg], %iReg } { loadr %1 %2 %3 }
.define { store %iReg, [%iReg + %Imm] } { store %2 %3 %1 }
.define { store_inst %iReg, %iReg } { store_inst %2 %1 }
.define { load [%iReg + %Imm], %fReg } { fload %1 %2 %3 }
.define { load [%iReg + %iReg], %fReg } { floadr %1 %2 %3 }
.define { store %fReg, [%iReg + %Imm] } { fstore %2 %3 %1 }
.define { mov %iReg, %fReg } { imovf %1 %2 }
.define { mov %fReg, %iReg } { fmovi %1 %2 }
.define { write %iReg, %iReg } { write %1 %2 }
.define { ledout %iReg, %iReg } { ledout %1 %2 }
.define { ledout %Imm, %iReg } { ledouti %1 %2 }

#疑似命令
.define { add %iReg, -%Imm, %iReg } { sub %1, %2, %3 }
.define { sub %iReg, -%Imm, %iReg } { add %1, %2, %3 }
.define { sll %iReg, %iReg } { add %1, %1, %2 }
.define { neg %iReg, %iReg } { sub $i0, %1, %2 }
.define { b %Imm } { cmpjmp 0, $i0, 0, %1 }
.define { be %s, %s, %Imm } { cmpjmp 5, %1, %2, %3 }
.define { bne %s, %s, %Imm } { cmpjmp 2, %1, %2, %3 }
.define { bl %s, %s, %Imm } { cmpjmp 6, %1, %2, %3 }
.define { ble %s, %s, %Imm } { cmpjmp 4, %1, %2, %3 }
.define { bg %s, %s, %Imm } { cmpjmp 3, %1, %2, %3 }
.define { bge %s, %s, %Imm } { cmpjmp 1, %1, %2, %3 }
.define { be %s, %Imm, %Imm } { cmpjmp 5, %1, %2, %3 }
.define { bne %s, %Imm, %Imm } { cmpjmp 2, %1, %2, %3 }
.define { bl %s, %Imm, %Imm } { cmpjmp 6, %1, %2, %3 }
.define { ble %s, %Imm, %Imm } { cmpjmp 4, %1, %2, %3 }
.define { bg %s, %Imm, %Imm } { cmpjmp 3, %1, %2, %3 }
.define { bge %s, %Imm, %Imm } { cmpjmp 1, %1, %2, %3 }
.define { load [%iReg - %Imm], %s } { load [%1 + -%2], %3}
.define { load [%iReg], %s } { load [%1 + 0], %2 }
.define { load [%Imm], %s } { load [$i0 + %1], %2 }
.define { load [%Imm + %iReg], %s } { load [%2 + %1], %3 }
.define { load [%Imm + %Imm], %s } { load [%{ %1 + %2 }], %3 }
.define { load [%Imm - %Imm], %s } { load [%{ %1 - %2 }], %3 }
.define { store %s, [%iReg - %Imm] } { store %1, [%2 + -%3] }
.define { store %s, [%iReg] } { store %1, [%2 + 0] }
.define { store %s, [%Imm] } { store %1, [$i0 + %2] }
.define { store %s, [%Imm + %iReg] } { store %1, [%3 + %2] }
.define { store %s, [%Imm + %Imm] } { store %1, [%{ %2 + %3 }] }
.define { store %s, [%Imm - %Imm] } { store %1, [%{ %2 - %3 }] }
.define { halt } { b %pc }
.define { call %Imm } { jal %1, $ra }
.define { ret } { jr $ra }

    li 0x100, $i1
    li 0x1, $i2
    li 128, $i5
INST:
    call READWORD
    mov $i3, $i4
READINST:
    ble $i4, 0, DATA
    call READWORD
    store_inst $i3, $i5
    call READWORD
    store_inst $i3, $i5
    call READWORD
    store_inst $i3, $i5
    add $i5, 1, $i5
    sub $i4, 3, $i4
    b READINST
DATA:
    call READWORD
    mov $i3, $i4
    li 0, $i5
READDATA:
    ble $i4, 0, ZEROXAA
    call READWORD
    store $i3, [$i5 + 0]
    add $i5, 1, $i5
    sub $i4, 1, $i4
    b READDATA
ZEROXAA:
    li 0xaa, $i1
    write $i1, $i3
    bge $i3, $i2, ZEROXAA
    b 256
    halt
READWORD:
R1:
    read $i10
    bge $i10,$i1,R1
R2:
    read $i11
    bge $i11,$i1,R2
R3:
    read $i12
    bge $i12, $i1, R3
R4:
    read $i13
    bge $i13, $i1, R4
MAKEWORD:
    li 0, $i3
    mov $i10, $i20
    jal SLL8, $i21
    jal SLL8, $i21
    jal SLL8, $i21
    add $i3, $i20, $i3
    mov $i11, $i20
    jal SLL8, $i21
    jal SLL8, $i21
    add $i3, $i20, $i3
    mov $i12, $i20
    jal SLL8, $i21
    add $i3, $i20, $i3
    add $i3, $i13, $i3
    ret
SLL8:
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    sll $i20, $i20
    jr $i21
