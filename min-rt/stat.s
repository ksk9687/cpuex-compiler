######################################################################
#
#       ↓　ここから macro.s
#
######################################################################

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

#スタックとヒープの初期化($hp=0x2000,$sp=0x20000)
    li      0, $i0                      # |          1 |          1 |          0 |          0 |
    mov     $i0, $f0                    # |          1 |          1 |          0 |          0 |
    li      0x2000, $hp                 # |          1 |          1 |          0 |          0 |
    sll     $hp, $sp                    # |          1 |          1 |          0 |          0 |
    sll     $sp, $sp                    # |          1 |          1 |          0 |          0 |
    sll     $sp, $sp                    # |          1 |          1 |          0 |          0 |
    sll     $sp, $sp                    # |          1 |          1 |          0 |          0 |
    call    ext_main                    # |          1 |          1 |          0 |          0 |
    halt

######################################################################
#
#       ↑　ここまで macro.s
#
######################################################################
######################################################################
#
#       ↓　ここから lib_asm.s
#
######################################################################

FLOOR_ONE:
    .float 1.0
FLOOR_MONE:
    .float -1.0
FLOAT_MAGICI:
    .int 8388608
FLOAT_MAGICF:
    .float 8388608.0
FLOAT_MAGICFHX:
    .int 1258291200         # 0x4b000000
FLOAT_HALF:
    .float 0.5

######################################################################
# $f1 = floor($f2)
# $ra = $ra
# []
# [$f1 - $f3]
######################################################################
.begin floor
ext_floor:
    mov $f2, $f1                        # |    193,618 |    193,618 |          0 |          0 |
    bge $f1, $f0, FLOOR_POSITIVE        # |    193,618 |    193,618 |          0 |     14,656 |
FLOOR_NEGATIVE:
    fneg $f1, $f1                       # |    166,273 |    166,273 |          0 |          0 |
    load [FLOAT_MAGICF], $f3            # |    166,273 |    166,273 |      3,360 |          0 |
    ble $f1, $f3, FLOOR_NEGATIVE_MAIN   # |    166,273 |    166,273 |          0 |      9,885 |
    fneg $f1, $f1
    ret
FLOOR_NEGATIVE_MAIN:
    fadd $f1, $f3, $f1                  # |    166,273 |    166,273 |          0 |          0 |
    fsub $f1, $f3, $f1                  # |    166,273 |    166,273 |          0 |          0 |
    fneg $f2, $f2                       # |    166,273 |    166,273 |          0 |          0 |
    ble $f2, $f1, FLOOR_RET2            # |    166,273 |    166,273 |          0 |          4 |
    fadd $f1, $f3, $f1                  # |    166,273 |    166,273 |          0 |          0 |
    load [FLOOR_ONE], $f2               # |    166,273 |    166,273 |          0 |          0 |
    fadd $f1, $f2, $f1                  # |    166,273 |    166,273 |          0 |          0 |
    fsub $f1, $f3, $f1                  # |    166,273 |    166,273 |          0 |          0 |
    fneg $f1, $f1                       # |    166,273 |    166,273 |          0 |          0 |
    ret                                 # |    166,273 |    166,273 |          0 |          0 |
FLOOR_POSITIVE:
    load [FLOAT_MAGICF], $f3            # |     27,345 |     27,345 |      1,390 |          0 |
    ble $f1, $f3, FLOOR_POSITIVE_MAIN   # |     27,345 |     27,345 |          0 |        414 |
    ret
FLOOR_POSITIVE_MAIN:
    mov $f1, $f2                        # |     27,345 |     27,345 |          0 |          0 |
    fadd $f1, $f3, $f1                  # |     27,345 |     27,345 |          0 |          0 |
    fsub $f1, $f3, $f1                  # |     27,345 |     27,345 |          0 |          0 |
    ble $f1, $f2, FLOOR_RET             # |     27,345 |     27,345 |          0 |        357 |
    load [FLOOR_ONE], $f2
    fsub $f1, $f2, $f1
FLOOR_RET:
    ret                                 # |     27,345 |     27,345 |          0 |          0 |
FLOOR_RET2:
    fneg $f1, $f1
    ret
.end floor

######################################################################
# $f1 = float_of_int($i2)
# $ra = $ra
# [$i2 - $i4]
# [$f1 - $f3]
######################################################################
.begin float_of_int
ext_float_of_int:
    bge $i2, 0, ITOF_MAIN               # |     16,541 |     16,541 |          0 |      1,434 |
    neg $i2, $i2                        # |      8,255 |      8,255 |          0 |          0 |
    mov $ra, $tmp                       # |      8,255 |      8,255 |          0 |          0 |
    call ITOF_MAIN                      # |      8,255 |      8,255 |          0 |          0 |
    fneg $f1, $f1                       # |      8,255 |      8,255 |          0 |          0 |
    jr $tmp                             # |      8,255 |      8,255 |          0 |          0 |
ITOF_MAIN:
    load [FLOAT_MAGICF], $f2            # |     16,541 |     16,541 |      6,384 |          0 |
    load [FLOAT_MAGICFHX], $i3          # |     16,541 |     16,541 |      8,899 |          0 |
    load [FLOAT_MAGICI], $i4            # |     16,541 |     16,541 |          0 |          0 |
    bge $i2, $i4, ITOF_BIG              # |     16,541 |     16,541 |          0 |         83 |
    add $i2, $i3, $i2                   # |     16,541 |     16,541 |          0 |          0 |
    mov $i2, $f1                        # |     16,541 |     16,541 |          0 |          0 |
    fsub $f1, $f2, $f1                  # |     16,541 |     16,541 |          0 |          0 |
    ret                                 # |     16,541 |     16,541 |          0 |          0 |
ITOF_BIG:
    mov $f0, $f3
ITOF_LOOP:
    sub $i2, $i4, $i2
    fadd $f3, $f2, $f3
    bge $i2, $i4, ITOF_LOOP
    add $i2, $i3, $i2
    mov $i2, $f1
    fsub $f1, $f2, $f1
    fadd $f1, $f3, $f1
    ret
.end float_of_int

######################################################################
# $i1 = int_of_float($f2)
# $ra = $ra
# [$i1 - $i3]
# [$f2 - $f3]
######################################################################
.begin int_of_float
ext_int_of_float:
    bge $f2, $f0, FTOI_MAIN             # |     49,152 |     49,152 |          0 |      1,336 |
    fneg $f2, $f2
    mov $ra, $tmp
    call FTOI_MAIN
    neg $i1, $i1
    jr $tmp
FTOI_MAIN:
    load [FLOAT_HALF], $f3              # |     49,152 |     49,152 |      1,746 |          0 |
    fadd $f2, $f3, $f2                  # |     49,152 |     49,152 |          0 |          0 |
    load [FLOAT_MAGICF], $f3            # |     49,152 |     49,152 |      1,061 |          0 |
    load [FLOAT_MAGICFHX], $i2          # |     49,152 |     49,152 |          0 |          0 |
    bge $f2, $f3, FTOI_BIG              # |     49,152 |     49,152 |          0 |      2,850 |
    fadd $f2, $f3, $f2                  # |     49,152 |     49,152 |          0 |          0 |
    mov $f2, $i1                        # |     49,152 |     49,152 |          0 |          0 |
    sub $i1, $i2, $i1                   # |     49,152 |     49,152 |          0 |          0 |
    ret                                 # |     49,152 |     49,152 |          0 |          0 |
FTOI_BIG:
    load [FLOAT_MAGICI], $i3
    li 0, $i1
FTOI_LOOP:
    fsub $f2, $f3, $f2
    add $i1, $i3, $i1
    bge $f2, $f3, FTOI_LOOP
    fadd $f2, $f3, $f2
    mov $f2, $i3
    sub $i3, $i2, $i3
    add $i3, $i1, $i1
    ret
.end int_of_float

######################################################################
# $i1 = read_int()
# $ra = $ra
# [$i1 - $i5]
# []
######################################################################
.begin read
ext_read_int:
    li 0, $i1                           # |        325 |        325 |          0 |          0 |
    li 0, $i3                           # |        325 |        325 |          0 |          0 |
    li 255, $i5                         # |        325 |        325 |          0 |          0 |
read_int_loop:
    read $i2                            # |      1,300 |      1,300 |          0 |          0 |
    bg $i2, $i5, read_int_loop          # |      1,300 |      1,300 |          0 |          2 |
    li 0, $i4                           # |      1,300 |      1,300 |          0 |          0 |
sll_loop:
    add $i4, 1, $i4                     # |     10,400 |     10,400 |          0 |          0 |
    sll $i1, $i1                        # |     10,400 |     10,400 |          0 |          0 |
    bl $i4, 8, sll_loop                 # |     10,400 |     10,400 |          0 |        116 |
    add $i3, 1, $i3                     # |      1,300 |      1,300 |          0 |          0 |
    add $i1, $i2, $i1                   # |      1,300 |      1,300 |          0 |          0 |
    bl $i3, 4, read_int_loop            # |      1,300 |      1,300 |          0 |        651 |
    ret                                 # |        325 |        325 |          0 |          0 |

######################################################################
# $f1 = read_float()
# $ra = $ra
# [$i1 - $i5]
# [$f1]
######################################################################
ext_read_float:
    mov $ra, $tmp                       # |        212 |        212 |          0 |          0 |
    call ext_read_int                   # |        212 |        212 |          0 |          0 |
    mov $i1, $f1                        # |        212 |        212 |          0 |          0 |
    jr $tmp                             # |        212 |        212 |          0 |          0 |
.end read

######################################################################
# write($i2)
# $ra = $ra
# []
# []
######################################################################
.begin write
ext_write:
    write $i2, $tmp                     # |     49,167 |     49,167 |          0 |          0 |
    bg $tmp, 0, ext_write               # |     49,167 |     49,167 |          0 |          0 |
    ret                                 # |     49,167 |     49,167 |          0 |          0 |
.end write

######################################################################
# $i1 = create_array_int($i2, $i3)
# $ra = $ra
# [$i1 - $i2]
# []
######################################################################
.begin create_array
ext_create_array_int:
    mov $i2, $i1                        # |     22,313 |     22,313 |          0 |          0 |
    add $i2, $hp, $i2                   # |     22,313 |     22,313 |          0 |          0 |
    mov $hp, $i1                        # |     22,313 |     22,313 |          0 |          0 |
create_array_loop:
    store $i3, [$hp]                    # |    103,030 |    103,030 |          0 |          0 |
    add $hp, 1, $hp                     # |    103,030 |    103,030 |          0 |          0 |
    bl $hp, $i2, create_array_loop      # |    103,030 |    103,030 |          0 |      6,105 |
    ret                                 # |     22,313 |     22,313 |          0 |          0 |

######################################################################
# $i1 = create_array_float($i2, $f2)
# $ra = $ra
# [$i1 - $i3]
# []
######################################################################
ext_create_array_float:
    mov $f2, $i3                        # |     19,001 |     19,001 |          0 |          0 |
    jal ext_create_array_int $tmp       # |     19,001 |     19,001 |          0 |          0 |
.end create_array

######################################################################
#
#       ↑　ここまで lib_asm.s
#
######################################################################
######################################################################
#
#       ↓　ここから math.s
#
######################################################################

f._177: .float  1.5707963268E+00
f._176: .float  6.2831853072E+00
f._175: .float  1.5915494309E-01
f._174: .float  3.1415926536E+00
f._173: .float  9.0000000000E+00
f._172: .float  2.5000000000E+00
f._171: .float  -1.5707963268E+00
f._170: .float  1.5707963268E+00
f._169: .float  -1.0000000000E+00
f._167: .float  1.1000000000E+01
f._166: .float  2.0000000000E+00
f._165: .float  1.0000000000E+00
f._164: .float  5.0000000000E-01

######################################################################
# $f1 = atan_sub($f2, $f3, $f4)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f6]
# []
# []
# []
######################################################################
.align 2
.begin atan_sub
ext_atan_sub:
.count load_float
    load    [f._164], $f5               # |     12,000 |     12,000 |          0 |          0 |
    ble     $f5, $f2, ble._182          # |     12,000 |     12,000 |          0 |      2,060 |
bg._182:
    mov     $f4, $f1                    # |      1,000 |      1,000 |          0 |          0 |
    ret                                 # |      1,000 |      1,000 |          0 |          0 |
ble._182:
.count load_float
    load    [f._166], $f1               # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f2, $f2, $f6               # |     11,000 |     11,000 |          0 |          0 |
.count load_float
    load    [f._165], $f5               # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     11,000 |     11,000 |          0 |          0 |
    fsub    $f2, $f5, $f2               # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f6, $f3, $f6               # |     11,000 |     11,000 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |     11,000 |     11,000 |          0 |          0 |
    fadd    $f1, $f4, $f1               # |     11,000 |     11,000 |          0 |          0 |
    finv    $f1, $f1                    # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f6, $f1, $f4               # |     11,000 |     11,000 |          0 |          0 |
    b       ext_atan_sub                # |     11,000 |     11,000 |          0 |         43 |
.end atan_sub

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin atan
ext_atan:
.count stack_store_ra
    store   $ra, [$sp - 2]              # |      1,000 |      1,000 |          0 |          0 |
.count stack_move
    add     $sp, -2, $sp                # |      1,000 |      1,000 |          0 |          0 |
    fabs    $f2, $f3                    # |      1,000 |      1,000 |          0 |          0 |
.count stack_store
    store   $f2, [$sp + 1]              # |      1,000 |      1,000 |          0 |          0 |
.count load_float
    load    [f._165], $f7               # |      1,000 |      1,000 |          1 |          0 |
.count move_args
    mov     $f0, $f4                    # |      1,000 |      1,000 |          0 |          0 |
.count load_float
    load    [f._167], $f1               # |      1,000 |      1,000 |          1 |          0 |
    ble     $f3, $f7, ble._184          # |      1,000 |      1,000 |          0 |         14 |
bg._184:
    finv    $f2, $f2                    # |      1,000 |      1,000 |          0 |          0 |
    mov     $f2, $f8                    # |      1,000 |      1,000 |          0 |          0 |
    fmul    $f8, $f8, $f3               # |      1,000 |      1,000 |          0 |          0 |
.count move_args
    mov     $f1, $f2                    # |      1,000 |      1,000 |          0 |          0 |
    call    ext_atan_sub                # |      1,000 |      1,000 |          0 |          0 |
    fadd    $f7, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      1,000 |      1,000 |          0 |          0 |
.count stack_move
    add     $sp, 2, $sp                 # |      1,000 |      1,000 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |      1,000 |      1,000 |          0 |          0 |
    finv    $f1, $f1                    # |      1,000 |      1,000 |          0 |          0 |
    fmul    $f8, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
    ble     $f2, $f7, ble._186          # |      1,000 |      1,000 |          0 |          0 |
.count dual_jmp
    b       bg._186                     # |      1,000 |      1,000 |          0 |          2 |
ble._184:
    mov     $f2, $f8
    fmul    $f8, $f8, $f3
.count move_args
    mov     $f1, $f2
    call    ext_atan_sub
    fadd    $f7, $f1, $f1
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 2, $sp
.count stack_load
    load    [$sp - 1], $f2
    finv    $f1, $f1
    fmul    $f8, $f1, $f1
    bg      $f2, $f7, bg._186
ble._186:
.count load_float
    load    [f._169], $f3
    ble     $f3, $f2, bge._189
bg._187:
    add     $i0, -1, $i1
    bg      $i1, 0, bg._186
ble._188:
    bge     $i1, 0, bge._189
bl._189:
.count load_float
    load    [f._171], $f2
    fsub    $f2, $f1, $f1
    ret     
bge._189:
    ret     
bg._186:
.count load_float
    load    [f._170], $f2               # |      1,000 |      1,000 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
    ret                                 # |      1,000 |      1,000 |          0 |          0 |
.end atan

######################################################################
# $f1 = tan_sub($f2, $f3, $f4)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f5]
# []
# []
# []
######################################################################
.align 2
.begin tan_sub
ext_tan_sub:
.count load_float
    load    [f._172], $f5               # |     24,470 |     24,470 |          0 |          0 |
    ble     $f5, $f2, ble._190          # |     24,470 |     24,470 |          0 |      3,142 |
bg._190:
    mov     $f4, $f1                    # |      4,894 |      4,894 |          0 |          0 |
    ret                                 # |      4,894 |      4,894 |          0 |          0 |
ble._190:
    fsub    $f2, $f4, $f1               # |     19,576 |     19,576 |          0 |          0 |
.count load_float
    load    [f._166], $f4               # |     19,576 |     19,576 |          0 |          0 |
    fsub    $f2, $f4, $f2               # |     19,576 |     19,576 |          0 |          0 |
    finv    $f1, $f1                    # |     19,576 |     19,576 |          0 |          0 |
    fmul    $f3, $f1, $f4               # |     19,576 |     19,576 |          0 |          0 |
    b       ext_tan_sub                 # |     19,576 |     19,576 |          0 |         28 |
.end tan_sub

######################################################################
# $f1 = tan($f2)
# $ra = $ra
# []
# [$f1 - $f6]
# []
# []
# [$ra]
######################################################################
.align 2
.begin tan
ext_tan:
.count stack_store_ra
    store   $ra, [$sp - 2]              # |      4,894 |      4,894 |          0 |          0 |
.count stack_move
    add     $sp, -2, $sp                # |      4,894 |      4,894 |          0 |          0 |
    fmul    $f2, $f2, $f3               # |      4,894 |      4,894 |          0 |          0 |
.count stack_store
    store   $f2, [$sp + 1]              # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._173], $f1               # |      4,894 |      4,894 |          0 |          0 |
.count move_args
    mov     $f0, $f4                    # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._165], $f6               # |      4,894 |      4,894 |          0 |          0 |
.count move_args
    mov     $f1, $f2                    # |      4,894 |      4,894 |          0 |          0 |
    call    ext_tan_sub                 # |      4,894 |      4,894 |          0 |          0 |
    fsub    $f6, $f1, $f1               # |      4,894 |      4,894 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      4,894 |      4,894 |      1,752 |          0 |
.count stack_move
    add     $sp, 2, $sp                 # |      4,894 |      4,894 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |      4,894 |      4,894 |          0 |          0 |
    finv    $f1, $f1                    # |      4,894 |      4,894 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      4,894 |      4,894 |          0 |          0 |
    ret                                 # |      4,894 |      4,894 |          0 |          0 |
.end tan

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin sin
ext_sin:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |      4,894 |      4,894 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._174], $f4               # |      4,894 |      4,894 |      2,189 |          0 |
    fabs    $f2, $f5                    # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._175], $f1               # |      4,894 |      4,894 |          0 |          0 |
    ble     $f2, $f0, ble._194          # |      4,894 |      4,894 |          0 |        103 |
bg._194:
    li      1, $i1                      # |      4,394 |      4,394 |          0 |          0 |
    fmul    $f5, $f1, $f2               # |      4,394 |      4,394 |          0 |          0 |
    call    ext_floor                   # |      4,394 |      4,394 |          0 |          0 |
.count load_float
    load    [f._176], $f2               # |      4,394 |      4,394 |        908 |          0 |
    fmul    $f2, $f1, $f1               # |      4,394 |      4,394 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |      4,394 |      4,394 |          0 |          0 |
    ble     $f1, $f4, ble._195          # |      4,394 |      4,394 |          0 |      1,061 |
.count dual_jmp
    b       bg._195                     # |      1,343 |      1,343 |          0 |          2 |
ble._194:
    li      0, $i1                      # |        500 |        500 |          0 |          0 |
    fmul    $f5, $f1, $f2               # |        500 |        500 |          0 |          0 |
    call    ext_floor                   # |        500 |        500 |          0 |          0 |
.count load_float
    load    [f._176], $f2               # |        500 |        500 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |        500 |        500 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |        500 |        500 |          0 |          0 |
    ble     $f1, $f4, ble._195          # |        500 |        500 |          0 |          0 |
bg._195:
.count load_float
    load    [f._170], $f5               # |      1,343 |      1,343 |        994 |          0 |
    be      $i1, 0, be._196             # |      1,343 |      1,343 |          0 |        214 |
.count dual_jmp
    b       bne._196                    # |      1,343 |      1,343 |          0 |          0 |
ble._195:
.count load_float
    load    [f._170], $f5               # |      3,551 |      3,551 |      1,220 |          0 |
    be      $i1, 0, bne._196            # |      3,551 |      3,551 |          0 |          2 |
be._196:
.count load_float
    load    [f._165], $f7               # |      3,051 |      3,051 |      1,123 |          0 |
.count load_float
    load    [f._166], $f8               # |      3,051 |      3,051 |          0 |          0 |
.count load_float
    load    [f._164], $f3               # |      3,051 |      3,051 |          0 |          0 |
    ble     $f1, $f4, ble._198          # |      3,051 |      3,051 |          0 |         10 |
.count dual_jmp
    b       bg._198
bne._196:
.count load_float
    load    [f._169], $f7               # |      1,843 |      1,843 |          0 |          0 |
.count load_float
    load    [f._166], $f8               # |      1,843 |      1,843 |        902 |          0 |
.count load_float
    load    [f._164], $f3               # |      1,843 |      1,843 |          0 |          0 |
    ble     $f1, $f4, ble._198          # |      1,843 |      1,843 |          0 |          2 |
bg._198:
    fsub    $f2, $f1, $f1               # |      1,343 |      1,343 |          0 |          0 |
    ble     $f1, $f5, ble._199          # |      1,343 |      1,343 |          0 |        379 |
.count dual_jmp
    b       bg._199                     # |        394 |        394 |          0 |          2 |
ble._198:
    ble     $f1, $f5, ble._199          # |      3,551 |      3,551 |          0 |      1,120 |
bg._199:
    fsub    $f4, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f3, $f2               # |      1,545 |      1,545 |          0 |          0 |
    call    ext_tan                     # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f1, $f2               # |      1,545 |      1,545 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      1,545 |      1,545 |          0 |          0 |
.count load_float
    load    [f._165], $f3               # |      1,545 |      1,545 |          0 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f8, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |      1,545 |      1,545 |          0 |          0 |
    finv    $f2, $f2                    # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    ret                                 # |      1,545 |      1,545 |          0 |          0 |
ble._199:
    fmul    $f1, $f3, $f2               # |      3,349 |      3,349 |          0 |          0 |
    call    ext_tan                     # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f1, $f1, $f2               # |      3,349 |      3,349 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      3,349 |      3,349 |          0 |          0 |
.count load_float
    load    [f._165], $f3               # |      3,349 |      3,349 |          0 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f8, $f1, $f1               # |      3,349 |      3,349 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |      3,349 |      3,349 |          0 |          0 |
    finv    $f2, $f2                    # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |      3,349 |      3,349 |          0 |          0 |
    ret                                 # |      3,349 |      3,349 |          0 |          0 |
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin cos
ext_cos:
.count load_float
    load    [f._177], $f1               # |      1,004 |      1,004 |          1 |          0 |
    fsub    $f1, $f2, $f2               # |      1,004 |      1,004 |          0 |          0 |
    b       ext_sin                     # |      1,004 |      1,004 |          0 |          4 |
.end cos

######################################################################
#
#       ↑　ここまで math.s
#
######################################################################
ext_n_objects:
    .skip   1
ext_objects:
    .skip   60
ext_screen:
    .skip   3
ext_viewpoint:
    .skip   3
ext_light:
    .skip   3
ext_beam:
    .skip   1
ext_and_net:
    .skip   50
ext_or_net:
    .skip   1
ext_solver_dist:
    .skip   1
ext_intsec_rectside:
    .skip   1
ext_tmin:
    .skip   1
ext_intersection_point:
    .skip   3
ext_intersected_object_id:
    .skip   1
ext_nvector:
    .skip   3
ext_texture_color:
    .skip   3
ext_diffuse_ray:
    .skip   3
ext_rgb:
    .skip   3
ext_image_size:
    .skip   2
ext_image_center:
    .skip   2
ext_scan_pitch:
    .skip   1
ext_startp:
    .skip   3
ext_startp_fast:
    .skip   3
ext_screenx_dir:
    .skip   3
ext_screeny_dir:
    .skip   3
ext_screenz_dir:
    .skip   3
ext_ptrace_dirvec:
    .skip   3
ext_dirvecs:
    .skip   5
ext_light_dirvec:
    .skip   3
    .int    light_dirvec_consts
light_dirvec_consts:
    .skip   60
ext_reflections:
    .skip   180
ext_n_reflections:
    .skip   1
.define $ig0 $i33
.define $i33 orz
.define $ig1 $i34
.define $i34 orz
.define $ig2 $i35
.define $i35 orz
.define $ig3 $i36
.define $i36 orz
.define $ig4 $i37
.define $i37 orz
.define $fig0 $i38
.define $i38 orz
.define $fig1 $i39
.define $i39 orz
.define $fig2 $i40
.define $i40 orz
.define $fig3 $i41
.define $i41 orz
.define $fig4 $i42
.define $i42 orz
.define $fig5 $i43
.define $i43 orz
.define $fig6 $i44
.define $i44 orz
.define $fig7 $i45
.define $i45 orz
.define $fig8 $i46
.define $i46 orz
.define $fig9 $i47
.define $i47 orz
.define $fig10 $i48
.define $i48 orz
.define $fig11 $i49
.define $i49 orz
.define $fig12 $i50
.define $i50 orz
.define $fig13 $i51
.define $i51 orz
.define $fig14 $i52
.define $i52 orz
.define $fg0 $f27
.define $f27 orz
.define $fg1 $f28
.define $f28 orz
.define $fg2 $f29
.define $f29 orz
.define $fg3 $f30
.define $f30 orz
.define $fg4 $f31
.define $f31 orz
.define $fg5 $f32
.define $f32 orz
.define $fg6 $f33
.define $f33 orz
.define $fg7 $f34
.define $f34 orz
.define $fg8 $f35
.define $f35 orz
.define $fg9 $f36
.define $f36 orz
.define $fg10 $f37
.define $f37 orz
.define $fg11 $f38
.define $f38 orz
.define $fg12 $f39
.define $f39 orz
.define $fg13 $f40
.define $f40 orz
.define $fg14 $f41
.define $f41 orz
.define $fg15 $f42
.define $f42 orz
.define $fg16 $f43
.define $f43 orz
.define $fg17 $f44
.define $f44 orz
.define $fg18 $f45
.define $f45 orz
.define $fg19 $f46
.define $f46 orz
.define $fc0 $f47
.define $f47 orz
.define $fc1 $f48
.define $f48 orz
.define $fc2 $f49
.define $f49 orz
.define $fc3 $f50
.define $f50 orz
.define $fc4 $f51
.define $f51 orz
.define $fc5 $f52
.define $f52 orz
.define $fc6 $f53
.define $f53 orz
.define $fc7 $f54
.define $f54 orz
.define $fc8 $f55
.define $f55 orz
.define $fc9 $f56
.define $f56 orz
.define $fc10 $f57
.define $f57 orz
.define $fc11 $f58
.define $f58 orz
.define $fc12 $f59
.define $f59 orz
.define $fc13 $f60
.define $f60 orz
.define $fc14 $f61
.define $f61 orz
.define $fc15 $f62
.define $f62 orz
.define $fc16 $f63
.define $f63 orz
.define $ra1 $i53
.define $i53 orz
.define $ra2 $i54
.define $i54 orz
.define $ra3 $i55
.define $i55 orz
.define $ra4 $i56
.define $i56 orz
.define $ra5 $i57
.define $i57 orz
.define $ra6 $i58
.define $i58 orz
.define $ra7 $i59
.define $i59 orz
f.28102:    .float  -6.4000000000E+01
f.28101:    .float  -2.0000000000E+02
f.28100:    .float  2.0000000000E+02
f.28080:    .float  -5.0000000000E-01
f.28079:    .float  7.0000000000E-01
f.28078:    .float  -3.0000000000E-01
f.28077:    .float  -1.0000000000E-01
f.28076:    .float  9.0000000000E-01
f.28075:    .float  2.0000000000E-01
f.28005:    .float  6.6666666667E-03
f.28004:    .float  1.5000000000E+02
f.28003:    .float  -6.6666666667E-03
f.28002:    .float  -1.5000000000E+02
f.28001:    .float  -2.0000000000E+00
f.28000:    .float  3.9062500000E-03
f.27999:    .float  2.5600000000E+02
f.27998:    .float  2.0000000000E+01
f.27997:    .float  5.0000000000E-02
f.27996:    .float  2.5000000000E-01
f.27995:    .float  1.0000000000E-01
f.27994:    .float  1.0000000000E+01
f.27993:    .float  8.5000000000E+02
f.27992:    .float  3.3333333333E+00
f.27991:    .float  3.0000000000E-01
f.27990:    .float  2.5500000000E+02
f.27989:    .float  1.5000000000E-01
f.27988:    .float  9.5492964444E+00
f.27987:    .float  3.1830988148E-01
f.27986:    .float  3.1415927000E+00
f.27985:    .float  3.0000000000E+01
f.27984:    .float  1.5000000000E+01
f.27983:    .float  1.0000000000E-04
f.27982:    .float  1.0000000000E+08
f.27981:    .float  1.0000000000E+09
f.27980:    .float  -1.0000000000E-01
f.27979:    .float  1.0000000000E-02
f.27978:    .float  -2.0000000000E-01
f.27977:    .float  5.0000000000E-01
f.27976:    .float  2.0000000000E+00
f.27975:    .float  1.0000000000E+00
f.27974:    .float  -1.0000000000E+00
f.27931:    .float  1.7453293000E-02

######################################################################
# read_object($i6)
# $ra = $ra1
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_object
read_object.2721:
    bge     $i6, 60, bge.28113          # |         18 |         18 |          0 |          0 |
bl.28113:
    call    ext_read_int                # |         18 |         18 |          0 |          0 |
.count move_ret
    mov     $i1, $i7                    # |         18 |         18 |          0 |          0 |
    be      $i7, -1, be.28114           # |         18 |         18 |          0 |          1 |
bne.28114:
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i8                    # |         17 |         17 |          0 |          0 |
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i9                    # |         17 |         17 |          0 |          0 |
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i10                   # |         17 |         17 |          0 |          0 |
    li      3, $i2                      # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i11                   # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i11 + 1]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i11 + 2]             # |         17 |         17 |          0 |          0 |
    li      3, $i2                      # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i12                   # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i12 + 0]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i12 + 1]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i12 + 2]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    li      2, $i2                      # |         17 |         17 |          0 |          0 |
    ble     $f0, $f1, ble.28115         # |         17 |         17 |          0 |          6 |
bg.28115:
    li      1, $i13                     # |          2 |          2 |          0 |          0 |
    call    ext_create_array_float      # |          2 |          2 |          0 |          0 |
.count move_ret
    mov     $i1, $i14                   # |          2 |          2 |          0 |          0 |
    call    ext_read_float              # |          2 |          2 |          0 |          0 |
    store   $f1, [$i14 + 0]             # |          2 |          2 |          0 |          0 |
    call    ext_read_float              # |          2 |          2 |          0 |          0 |
    store   $f1, [$i14 + 1]             # |          2 |          2 |          0 |          0 |
    li      3, $i2                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
    call    ext_create_array_float      # |          2 |          2 |          0 |          0 |
.count move_ret
    mov     $i1, $i15                   # |          2 |          2 |          0 |          0 |
    call    ext_read_float              # |          2 |          2 |          0 |          0 |
    store   $f1, [$i15 + 0]             # |          2 |          2 |          0 |          0 |
    call    ext_read_float              # |          2 |          2 |          0 |          0 |
    store   $f1, [$i15 + 1]             # |          2 |          2 |          0 |          0 |
    call    ext_read_float              # |          2 |          2 |          0 |          0 |
    store   $f1, [$i15 + 2]             # |          2 |          2 |          0 |          0 |
    li      3, $i2                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
    call    ext_create_array_float      # |          2 |          2 |          0 |          0 |
.count move_ret
    mov     $i1, $i16                   # |          2 |          2 |          0 |          0 |
    be      $i10, 0, be.28116           # |          2 |          2 |          0 |          2 |
.count dual_jmp
    b       bne.28116
ble.28115:
    li      0, $i13                     # |         15 |         15 |          0 |          0 |
    call    ext_create_array_float      # |         15 |         15 |          0 |          0 |
.count move_ret
    mov     $i1, $i14                   # |         15 |         15 |          0 |          0 |
    call    ext_read_float              # |         15 |         15 |          0 |          0 |
    store   $f1, [$i14 + 0]             # |         15 |         15 |          0 |          0 |
    call    ext_read_float              # |         15 |         15 |          0 |          0 |
    store   $f1, [$i14 + 1]             # |         15 |         15 |          0 |          0 |
    li      3, $i2                      # |         15 |         15 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         15 |         15 |          0 |          0 |
    call    ext_create_array_float      # |         15 |         15 |          0 |          0 |
.count move_ret
    mov     $i1, $i15                   # |         15 |         15 |          0 |          0 |
    call    ext_read_float              # |         15 |         15 |          0 |          0 |
    store   $f1, [$i15 + 0]             # |         15 |         15 |          0 |          0 |
    call    ext_read_float              # |         15 |         15 |          0 |          0 |
    store   $f1, [$i15 + 1]             # |         15 |         15 |          0 |          0 |
    call    ext_read_float              # |         15 |         15 |          0 |          0 |
    store   $f1, [$i15 + 2]             # |         15 |         15 |          0 |          0 |
    li      3, $i2                      # |         15 |         15 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         15 |         15 |          0 |          0 |
    call    ext_create_array_float      # |         15 |         15 |          0 |          0 |
.count move_ret
    mov     $i1, $i16                   # |         15 |         15 |          0 |          0 |
    be      $i10, 0, be.28116           # |         15 |         15 |          0 |          2 |
bne.28116:
    call    ext_read_float
.count load_float
    load    [f.27931], $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i16 + 0]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i16 + 1]
    call    ext_read_float
    fmul    $f1, $f2, $f1
    store   $f1, [$i16 + 2]
    be      $i8, 2, be.28117
.count dual_jmp
    b       bne.28117
be.28116:
    be      $i8, 2, be.28117            # |         17 |         17 |          0 |          3 |
bne.28117:
    mov     $i13, $i4                   # |         15 |         15 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         15 |         15 |          0 |          0 |
    li      4, $i2                      # |         15 |         15 |          0 |          0 |
    call    ext_create_array_float      # |         15 |         15 |          0 |          0 |
    mov     $hp, $i2                    # |         15 |         15 |          0 |          0 |
    store   $i7, [$i2 + 0]              # |         15 |         15 |          0 |          0 |
    add     $hp, 23, $hp                # |         15 |         15 |          0 |          0 |
    store   $i8, [$i2 + 1]              # |         15 |         15 |          0 |          0 |
    store   $i9, [$i2 + 2]              # |         15 |         15 |          0 |          0 |
    store   $i10, [$i2 + 3]             # |         15 |         15 |          0 |          0 |
    load    [$i11 + 0], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i2 + 4]              # |         15 |         15 |          0 |          0 |
    load    [$i11 + 1], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 5]              # |         15 |         15 |          0 |          0 |
    load    [$i11 + 2], $i3             # |         15 |         15 |          4 |          0 |
    add     $i2, 4, $i11                # |         15 |         15 |          0 |          0 |
    store   $i3, [$i2 + 6]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 0], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 7]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 1], $i3             # |         15 |         15 |          3 |          0 |
    store   $i3, [$i2 + 8]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 2], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 9]              # |         15 |         15 |          0 |          0 |
    store   $i4, [$i2 + 10]             # |         15 |         15 |          0 |          0 |
    load    [$i14 + 0], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 11]             # |         15 |         15 |          0 |          0 |
    load    [$i14 + 1], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 12]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 0], $i3             # |         15 |         15 |          3 |          0 |
    store   $i3, [$i2 + 13]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 1], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 14]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 2], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 15]             # |         15 |         15 |          0 |          0 |
    load    [$i16 + 0], $i3             # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 16]             # |         15 |         15 |          0 |          0 |
    load    [$i16 + 1], $i3             # |         15 |         15 |          3 |          0 |
    store   $i3, [$i2 + 17]             # |         15 |         15 |          0 |          0 |
    load    [$i16 + 2], $i3             # |         15 |         15 |          4 |          0 |
    add     $i2, 16, $i16               # |         15 |         15 |          0 |          0 |
    store   $i3, [$i2 + 18]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 0], $i3              # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 19]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 1], $i3              # |         15 |         15 |          4 |          0 |
    store   $i3, [$i2 + 20]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 2], $i3              # |         15 |         15 |          3 |          0 |
    add     $i2, 19, $i1                # |         15 |         15 |          0 |          0 |
    store   $i3, [$i2 + 21]             # |         15 |         15 |          0 |          0 |
    store   $i1, [$i2 + 22]             # |         15 |         15 |          0 |          0 |
    store   $i2, [ext_objects + $i6]    # |         15 |         15 |          0 |          0 |
    be      $i8, 3, be.28118            # |         15 |         15 |          0 |         10 |
.count dual_jmp
    b       bne.28118                   # |          6 |          6 |          0 |          2 |
be.28117:
    li      1, $i4                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
    li      4, $i2                      # |          2 |          2 |          0 |          0 |
    call    ext_create_array_float      # |          2 |          2 |          0 |          0 |
    mov     $hp, $i2                    # |          2 |          2 |          0 |          0 |
    store   $i7, [$i2 + 0]              # |          2 |          2 |          0 |          0 |
    add     $hp, 23, $hp                # |          2 |          2 |          0 |          0 |
    store   $i8, [$i2 + 1]              # |          2 |          2 |          0 |          0 |
    store   $i9, [$i2 + 2]              # |          2 |          2 |          0 |          0 |
    store   $i10, [$i2 + 3]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 0], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i2 + 4]              # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 5]              # |          2 |          2 |          0 |          0 |
    load    [$i11 + 2], $i3             # |          2 |          2 |          0 |          0 |
    add     $i2, 4, $i11                # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 6]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 0], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 7]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 1], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i2 + 8]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 2], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 9]              # |          2 |          2 |          0 |          0 |
    store   $i4, [$i2 + 10]             # |          2 |          2 |          0 |          0 |
    load    [$i14 + 0], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 11]             # |          2 |          2 |          0 |          0 |
    load    [$i14 + 1], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 12]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 0], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i2 + 13]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 1], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 14]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 2], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 15]             # |          2 |          2 |          0 |          0 |
    load    [$i16 + 0], $i3             # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 16]             # |          2 |          2 |          0 |          0 |
    load    [$i16 + 1], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i2 + 17]             # |          2 |          2 |          0 |          0 |
    load    [$i16 + 2], $i3             # |          2 |          2 |          0 |          0 |
    add     $i2, 16, $i16               # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 18]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 0], $i3              # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 19]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 1], $i3              # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 20]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 2], $i3              # |          2 |          2 |          2 |          0 |
    add     $i2, 19, $i1                # |          2 |          2 |          0 |          0 |
    store   $i3, [$i2 + 21]             # |          2 |          2 |          0 |          0 |
    store   $i1, [$i2 + 22]             # |          2 |          2 |          0 |          0 |
    store   $i2, [ext_objects + $i6]    # |          2 |          2 |          0 |          0 |
    be      $i8, 3, be.28118            # |          2 |          2 |          0 |          0 |
bne.28118:
    be      $i8, 2, be.28128            # |          8 |          8 |          0 |          2 |
bne.28128:
    be      $i10, 0, be.28132           # |          6 |          6 |          0 |          2 |
.count dual_jmp
    b       bne.28132
be.28128:
    load    [$i11 + 2], $f3             # |          2 |          2 |          2 |          0 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $f2             # |          2 |          2 |          2 |          0 |
    fmul    $f2, $f2, $f2               # |          2 |          2 |          0 |          0 |
    load    [$i11 + 0], $f1             # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f1, $f4               # |          2 |          2 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |          2 |          2 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |          0 |          0 |
    fsqrt   $f2, $f2                    # |          2 |          2 |          0 |          0 |
    be      $i13, 0, be.28129           # |          2 |          2 |          0 |          2 |
bne.28129:
    be      $f2, $f0, be.28130
bne.28721:
    finv    $f2, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.28132
.count dual_jmp
    b       bne.28132
be.28129:
    be      $f2, $f0, be.28130          # |          2 |          2 |          0 |          0 |
bne.28722:
    finv_n  $f2, $f2                    # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 2], $f1             # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |          0 |          0 |
    be      $i10, 0, be.28132           # |          2 |          2 |          0 |          2 |
.count dual_jmp
    b       bne.28132
be.28130:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.28132
.count dual_jmp
    b       bne.28132
be.28118:
    load    [$i11 + 0], $f1             # |          9 |          9 |          9 |          0 |
    bne     $f1, $f0, bne.28119         # |          9 |          9 |          0 |          2 |
be.28119:
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          2 |          2 |          0 |          0 |
    be      $f1, $f0, be.28122          # |          2 |          2 |          0 |          0 |
.count dual_jmp
    b       bne.28122                   # |          2 |          2 |          0 |          2 |
bne.28119:
    bne     $f1, $f0, bne.28120         # |          7 |          7 |          0 |          2 |
be.28120:
    fmul    $f1, $f1, $f1
    mov     $f0, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    be      $f1, $f0, be.28122
.count dual_jmp
    b       bne.28122
bne.28120:
    ble     $f1, $f0, ble.28121         # |          7 |          7 |          0 |          0 |
bg.28121:
    fmul    $f1, $f1, $f1               # |          7 |          7 |          0 |          0 |
    mov     $fc0, $f2                   # |          7 |          7 |          0 |          0 |
    finv    $f1, $f1                    # |          7 |          7 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |          7 |          7 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          7 |          7 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          7 |          7 |          2 |          0 |
    be      $f1, $f0, be.28122          # |          7 |          7 |          0 |          0 |
.count dual_jmp
    b       bne.28122                   # |          7 |          7 |          0 |          2 |
ble.28121:
    fmul    $f1, $f1, $f1
    mov     $fc6, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    bne     $f1, $f0, bne.28122
be.28122:
    mov     $f0, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.28125
.count dual_jmp
    b       bne.28125
bne.28122:
    bne     $f1, $f0, bne.28123         # |          9 |          9 |          0 |          4 |
be.28123:
    fmul    $f1, $f1, $f1
    mov     $f0, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.28125
.count dual_jmp
    b       bne.28125
bne.28123:
    ble     $f1, $f0, ble.28124         # |          9 |          9 |          0 |          1 |
bg.28124:
    fmul    $f1, $f1, $f1               # |          9 |          9 |          0 |          0 |
    mov     $fc0, $f2                   # |          9 |          9 |          0 |          0 |
    finv    $f1, $f1                    # |          9 |          9 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |          9 |          9 |          0 |          0 |
    store   $f1, [$i11 + 1]             # |          9 |          9 |          0 |          0 |
    load    [$i11 + 2], $f1             # |          9 |          9 |          1 |          0 |
    be      $f1, $f0, be.28125          # |          9 |          9 |          0 |          0 |
.count dual_jmp
    b       bne.28125                   # |          9 |          9 |          0 |          4 |
ble.28124:
    fmul    $f1, $f1, $f1
    mov     $fc6, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    bne     $f1, $f0, bne.28125
be.28125:
    mov     $f0, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.28132
.count dual_jmp
    b       bne.28132
bne.28125:
    bne     $f1, $f0, bne.28126         # |          9 |          9 |          0 |          4 |
be.28126:
    fmul    $f1, $f1, $f1
    mov     $f0, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.28132
.count dual_jmp
    b       bne.28132
bne.28126:
    ble     $f1, $f0, ble.28127         # |          9 |          9 |          0 |          0 |
bg.28127:
    fmul    $f1, $f1, $f1               # |          9 |          9 |          0 |          0 |
    mov     $fc0, $f2                   # |          9 |          9 |          0 |          0 |
    finv    $f1, $f1                    # |          9 |          9 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |          9 |          9 |          0 |          0 |
    store   $f1, [$i11 + 2]             # |          9 |          9 |          0 |          0 |
    be      $i10, 0, be.28132           # |          9 |          9 |          0 |          2 |
.count dual_jmp
    b       bne.28132
ble.28127:
    fmul    $f1, $f1, $f1
    mov     $fc6, $f2
    finv    $f1, $f1
    fmul    $f2, $f1, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.28132
bne.28132:
    load    [$i16 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f9
    load    [$i16 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f10
    load    [$i16 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f11
    load    [$i16 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f12
    load    [$i16 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f13
    load    [$i16 + 2], $f2
    call    ext_sin
    fmul    $f10, $f12, $f2
    add     $i6, 1, $i6
    fmul    $f11, $f13, $f3
    fmul    $f9, $f1, $f4
    fmul    $f2, $f13, $f5
    fmul    $f9, $f12, $f6
    fmul    $f10, $f1, $f7
    fsub    $f5, $f4, $f4
    fmul    $f6, $f13, $f5
    fmul    $f11, $f1, $f8
    fmul    $f2, $f1, $f2
    fmul    $f9, $f13, $f14
    fadd    $f5, $f7, $f5
    fmul    $f6, $f1, $f1
    fadd    $f2, $f14, $f2
    fmul    $f10, $f13, $f6
    fneg    $f12, $f7
    load    [$i11 + 2], $f12
    fmul    $f10, $f11, $f10
    fsub    $f1, $f6, $f1
    fmul    $f9, $f11, $f6
    load    [$i11 + 0], $f9
    load    [$i11 + 1], $f11
    fmul    $f3, $f3, $f13
    fmul    $f8, $f8, $f14
    fmul    $f7, $f7, $f15
    fmul    $f9, $f13, $f13
    fmul    $f11, $f14, $f14
    fmul    $f12, $f15, $f15
    fmul    $f4, $f4, $f16
    fadd    $f13, $f14, $f13
    fmul    $f2, $f2, $f14
    fmul    $f9, $f16, $f16
    fadd    $f13, $f15, $f13
    fmul    $f11, $f14, $f14
    store   $f13, [$i11 + 0]
    fmul    $f10, $f10, $f15
    fadd    $f16, $f14, $f13
    fmul    $f12, $f15, $f14
    fmul    $f5, $f5, $f15
    fmul    $f1, $f1, $f16
    fadd    $f13, $f14, $f13
    fmul    $f9, $f15, $f14
    store   $f13, [$i11 + 1]
    fmul    $f11, $f16, $f15
    fmul    $f6, $f6, $f13
    fadd    $f14, $f15, $f14
.count load_float
    load    [f.27976], $f15
    fmul    $f12, $f13, $f13
    fmul    $f9, $f4, $f16
    fmul    $f11, $f2, $f17
    fadd    $f14, $f13, $f13
    fmul    $f16, $f5, $f14
    store   $f13, [$i11 + 2]
    fmul    $f17, $f1, $f16
    fmul    $f12, $f10, $f13
    fadd    $f14, $f16, $f14
    fmul    $f9, $f3, $f3
    fmul    $f11, $f8, $f8
    fmul    $f13, $f6, $f9
    fmul    $f3, $f5, $f5
    fmul    $f8, $f1, $f1
    fadd    $f14, $f9, $f9
    fmul    $f12, $f7, $f7
    fadd    $f5, $f1, $f1
    fmul    $f15, $f9, $f5
    fmul    $f7, $f6, $f6
    store   $f5, [$i16 + 0]
    fmul    $f3, $f4, $f3
    fmul    $f8, $f2, $f2
    fadd    $f1, $f6, $f1
    fadd    $f3, $f2, $f2
    fmul    $f7, $f10, $f3
    fmul    $f15, $f1, $f1
    fadd    $f2, $f3, $f2
    store   $f1, [$i16 + 1]
    fmul    $f15, $f2, $f1
    store   $f1, [$i16 + 2]
    b       read_object.2721
be.28132:
    add     $i6, 1, $i6                 # |         17 |         17 |          0 |          0 |
    b       read_object.2721            # |         17 |         17 |          0 |          6 |
be.28114:
    mov     $i6, $ig0                   # |          1 |          1 |          0 |          0 |
    jr      $ra1                        # |          1 |          1 |          0 |          0 |
bge.28113:
    jr      $ra1
.end read_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |         43 |         43 |          0 |          0 |
.count stack_move
    add     $sp, -3, $sp                # |         43 |         43 |          0 |          0 |
.count stack_store
    store   $i1, [$sp + 1]              # |         43 |         43 |          0 |          0 |
    call    ext_read_int                # |         43 |         43 |          0 |          0 |
    be      $i1, -1, be.28135           # |         43 |         43 |          0 |         14 |
bne.28135:
.count stack_store
    store   $i1, [$sp + 2]              # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp + 1], $i1              # |         29 |         29 |          4 |          0 |
    add     $i1, 1, $i1                 # |         29 |         29 |          0 |          0 |
    call    read_net_item.2725          # |         29 |         29 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |         29 |         29 |          0 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i2              # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $i3              # |         29 |         29 |          0 |          0 |
.count storer
    add     $i1, $i2, $tmp              # |         29 |         29 |          0 |          0 |
    store   $i3, [$tmp + 0]             # |         29 |         29 |          0 |          0 |
    ret                                 # |         29 |         29 |          0 |          0 |
be.28135:
.count stack_load_ra
    load    [$sp + 0], $ra              # |         14 |         14 |          2 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |         14 |         14 |          0 |          0 |
    add     $i0, -1, $i3                # |         14 |         14 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i1              # |         14 |         14 |          0 |          0 |
    add     $i1, 1, $i2                 # |         14 |         14 |          0 |          0 |
    b       ext_create_array_int        # |         14 |         14 |          0 |          2 |
.end read_net_item

######################################################################
# $i1 = read_or_network($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_or_network
read_or_network.2727:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |          3 |          3 |          0 |          0 |
.count stack_move
    add     $sp, -3, $sp                # |          3 |          3 |          0 |          0 |
.count stack_store
    store   $i1, [$sp + 1]              # |          3 |          3 |          0 |          0 |
    li      0, $i1                      # |          3 |          3 |          0 |          0 |
    call    read_net_item.2725          # |          3 |          3 |          0 |          0 |
    load    [$i1 + 0], $i2              # |          3 |          3 |          2 |          0 |
    be      $i2, -1, be.28139           # |          3 |          3 |          0 |          1 |
bne.28139:
.count stack_store
    store   $i1, [$sp + 2]              # |          2 |          2 |          0 |          0 |
.count stack_load
    load    [$sp + 1], $i1              # |          2 |          2 |          0 |          0 |
    add     $i1, 1, $i1                 # |          2 |          2 |          0 |          0 |
    call    read_or_network.2727        # |          2 |          2 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          2 |          2 |          0 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |          2 |          2 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i2              # |          2 |          2 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $i3              # |          2 |          2 |          0 |          0 |
.count storer
    add     $i1, $i2, $tmp              # |          2 |          2 |          0 |          0 |
    store   $i3, [$tmp + 0]             # |          2 |          2 |          0 |          0 |
    ret                                 # |          2 |          2 |          0 |          0 |
be.28139:
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |          0 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i2              # |          1 |          1 |          0 |          0 |
    add     $i2, 1, $i2                 # |          1 |          1 |          0 |          0 |
    b       ext_create_array_int        # |          1 |          1 |          0 |          1 |
.end read_or_network

######################################################################
# read_and_network($i6)
# $ra = $ra1
# [$i1 - $i6]
# []
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_and_network
read_and_network.2729:
    li      0, $i1                      # |         11 |         11 |          0 |          0 |
    call    read_net_item.2725          # |         11 |         11 |          0 |          0 |
    load    [$i1 + 0], $i2              # |         11 |         11 |          8 |          0 |
    be      $i2, -1, be.28142           # |         11 |         11 |          0 |          2 |
bne.28142:
    add     $i6, 1, $i2                 # |         10 |         10 |          0 |          0 |
    store   $i1, [ext_and_net + $i6]    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |         10 |         10 |          0 |          0 |
    b       read_and_network.2729       # |         10 |         10 |          0 |          5 |
be.28142:
    jr      $ra1                        # |          1 |          1 |          0 |          0 |
.end read_and_network

######################################################################
# iter_setup_dirvec_constants($f1, $f3, $f4, $i4, $i5)
# $ra = $ra1
# [$i1 - $i3, $i5 - $i6]
# [$f2, $f5 - $f11]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i5, 0, bl.28143            # |     10,836 |     10,836 |          0 |      1,199 |
bge.28143:
    load    [ext_objects + $i5], $i6    # |     10,234 |     10,234 |          7 |          0 |
.count move_args
    mov     $f0, $f2                    # |     10,234 |     10,234 |          0 |          0 |
    load    [$i6 + 1], $i1              # |     10,234 |     10,234 |         19 |          0 |
    be      $i1, 1, be.28144            # |     10,234 |     10,234 |          0 |      4,994 |
bne.28144:
    be      $i1, 2, be.28160            # |      6,622 |      6,622 |          0 |      1,209 |
bne.28160:
    li      5, $i2                      # |      5,418 |      5,418 |          0 |          0 |
    call    ext_create_array_float      # |      5,418 |      5,418 |          0 |          0 |
    fmul    $f1, $f1, $f2               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i6 + 4], $f5              # |      5,418 |      5,418 |          5 |          0 |
    fmul    $f3, $f3, $f6               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i6 + 5], $f7              # |      5,418 |      5,418 |          1 |          0 |
    fmul    $f2, $f5, $f2               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i6 + 6], $f9              # |      5,418 |      5,418 |          1 |          0 |
    fmul    $f4, $f4, $f8               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i6 + 3], $i2              # |      5,418 |      5,418 |          0 |          0 |
    fmul    $f6, $f7, $f6               # |      5,418 |      5,418 |          0 |          0 |
    fadd    $f2, $f6, $f2               # |      5,418 |      5,418 |          0 |          0 |
    fmul    $f8, $f9, $f6               # |      5,418 |      5,418 |          0 |          0 |
    fmul_n  $f1, $f5, $f5               # |      5,418 |      5,418 |          0 |          0 |
    fadd    $f2, $f6, $f2               # |      5,418 |      5,418 |          0 |          0 |
    be      $i2, 0, be.28162            # |      5,418 |      5,418 |          0 |          2 |
bne.28162:
    fmul    $f3, $f4, $f6
    load    [$i6 + 16], $f8
    fmul    $f4, $f1, $f10
    load    [$i6 + 17], $f11
    fmul    $f6, $f8, $f6
    fmul    $f1, $f3, $f8
    fmul    $f10, $f11, $f10
    fadd    $f2, $f6, $f2
    load    [$i6 + 18], $f6
    fadd    $f2, $f10, $f2
    fmul    $f8, $f6, $f6
    fadd    $f2, $f6, $f2
    fmul_n  $f3, $f7, $f6
    store   $f2, [$i1 + 0]
    fmul_n  $f4, $f9, $f7
    be      $i2, 0, be.28163
.count dual_jmp
    b       bne.28163
be.28162:
    fmul_n  $f3, $f7, $f6               # |      5,418 |      5,418 |          0 |          0 |
    fmul_n  $f4, $f9, $f7               # |      5,418 |      5,418 |          0 |          0 |
    store   $f2, [$i1 + 0]              # |      5,418 |      5,418 |          0 |          0 |
    be      $i2, 0, be.28163            # |      5,418 |      5,418 |          0 |          2 |
bne.28163:
    load    [$i6 + 17], $f8
    load    [$i6 + 18], $f9
    fmul    $f4, $f8, $f8
    fmul    $f3, $f9, $f9
    fadd    $f8, $f9, $f8
    fmul    $f8, $fc2, $f8
    fsub    $f5, $f8, $f5
    store   $f5, [$i1 + 1]
    load    [$i6 + 16], $f5
    load    [$i6 + 18], $f8
    fmul    $f4, $f5, $f5
    fmul    $f1, $f8, $f8
    fadd    $f5, $f8, $f5
    fmul    $f5, $fc2, $f5
    fsub    $f6, $f5, $f5
    store   $f5, [$i1 + 2]
    load    [$i6 + 16], $f5
    load    [$i6 + 17], $f6
    fmul    $f3, $f5, $f5
    fmul    $f1, $f6, $f6
    fadd    $f5, $f6, $f5
    fmul    $f5, $fc2, $f5
    fsub    $f7, $f5, $f5
    store   $f5, [$i1 + 3]
    be      $f2, $f0, be.28164
.count dual_jmp
    b       bne.28164
be.28163:
    store   $f5, [$i1 + 1]              # |      5,418 |      5,418 |          0 |          0 |
    store   $f6, [$i1 + 2]              # |      5,418 |      5,418 |          0 |          0 |
    store   $f7, [$i1 + 3]              # |      5,418 |      5,418 |          0 |          0 |
    be      $f2, $f0, be.28164          # |      5,418 |      5,418 |          0 |          0 |
bne.28164:
    finv    $f2, $f2                    # |      5,418 |      5,418 |          0 |          0 |
.count storer
    add     $i4, $i5, $tmp              # |      5,418 |      5,418 |          0 |          0 |
    store   $f2, [$i1 + 4]              # |      5,418 |      5,418 |          0 |          0 |
    add     $i5, -1, $i5                # |      5,418 |      5,418 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      5,418 |      5,418 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      5,418 |      5,418 |          0 |          2 |
be.28164:
.count storer
    add     $i4, $i5, $tmp
    add     $i5, -1, $i5
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
be.28160:
    li      4, $i2                      # |      1,204 |      1,204 |          0 |          0 |
    call    ext_create_array_float      # |      1,204 |      1,204 |          0 |          0 |
    load    [$i6 + 4], $f2              # |      1,204 |      1,204 |          1 |          0 |
    load    [$i6 + 5], $f5              # |      1,204 |      1,204 |          0 |          0 |
    fmul    $f1, $f2, $f2               # |      1,204 |      1,204 |          0 |          0 |
    load    [$i6 + 6], $f6              # |      1,204 |      1,204 |          1 |          0 |
    fmul    $f3, $f5, $f5               # |      1,204 |      1,204 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |      1,204 |      1,204 |          0 |          0 |
.count storer
    add     $i4, $i5, $tmp              # |      1,204 |      1,204 |          0 |          0 |
    fadd    $f2, $f5, $f2               # |      1,204 |      1,204 |          0 |          0 |
    add     $i5, -1, $i5                # |      1,204 |      1,204 |          0 |          0 |
    fadd    $f2, $f6, $f2               # |      1,204 |      1,204 |          0 |          0 |
    ble     $f2, $f0, ble.28161         # |      1,204 |      1,204 |          0 |      1,097 |
bg.28161:
    finv    $f2, $f2                    # |        603 |        603 |          0 |          0 |
    fneg    $f2, $f5                    # |        603 |        603 |          0 |          0 |
    store   $f5, [$i1 + 0]              # |        603 |        603 |          0 |          0 |
    load    [$i6 + 4], $f5              # |        603 |        603 |          0 |          0 |
    fmul_n  $f5, $f2, $f5               # |        603 |        603 |          0 |          0 |
    store   $f5, [$i1 + 1]              # |        603 |        603 |          0 |          0 |
    load    [$i6 + 5], $f5              # |        603 |        603 |          0 |          0 |
    fmul_n  $f5, $f2, $f5               # |        603 |        603 |          0 |          0 |
    store   $f5, [$i1 + 2]              # |        603 |        603 |          0 |          0 |
    load    [$i6 + 6], $f5              # |        603 |        603 |          0 |          0 |
    fmul_n  $f5, $f2, $f2               # |        603 |        603 |          0 |          0 |
    store   $f2, [$i1 + 3]              # |        603 |        603 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        603 |        603 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |        603 |        603 |          0 |          2 |
ble.28161:
    store   $f0, [$i1 + 0]              # |        601 |        601 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        601 |        601 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |        601 |        601 |          0 |          2 |
be.28144:
    li      6, $i2                      # |      3,612 |      3,612 |          0 |          0 |
    call    ext_create_array_float      # |      3,612 |      3,612 |          0 |          0 |
    bne     $f1, $f0, bne.28145         # |      3,612 |      3,612 |          0 |          2 |
be.28145:
    store   $f0, [$i1 + 1]
    be      $f3, $f0, be.28150
.count dual_jmp
    b       bne.28150
bne.28145:
    load    [$i6 + 10], $i2             # |      3,612 |      3,612 |          7 |          0 |
    load    [$i6 + 4], $f2              # |      3,612 |      3,612 |          5 |          0 |
    finv    $f1, $f5                    # |      3,612 |      3,612 |          0 |          0 |
    ble     $f0, $f1, ble.28146         # |      3,612 |      3,612 |          0 |        804 |
bg.28146:
    be      $i2, 0, be.28147            # |      1,806 |      1,806 |          0 |          2 |
.count dual_jmp
    b       bne.28723
ble.28146:
    be      $i2, 0, bne.28723           # |      1,806 |      1,806 |          0 |          2 |
be.28147:
    store   $f2, [$i1 + 0]              # |      1,806 |      1,806 |          0 |          0 |
    store   $f5, [$i1 + 1]              # |      1,806 |      1,806 |          0 |          0 |
    be      $f3, $f0, be.28150          # |      1,806 |      1,806 |          0 |          0 |
.count dual_jmp
    b       bne.28150                   # |      1,806 |      1,806 |          0 |          2 |
bne.28723:
    fneg    $f2, $f2                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f2, [$i1 + 0]              # |      1,806 |      1,806 |          0 |          0 |
    store   $f5, [$i1 + 1]              # |      1,806 |      1,806 |          0 |          0 |
    bne     $f3, $f0, bne.28150         # |      1,806 |      1,806 |          0 |          2 |
be.28150:
    store   $f0, [$i1 + 3]
    be      $f4, $f0, be.28155
.count dual_jmp
    b       bne.28155
bne.28150:
    load    [$i6 + 10], $i2             # |      3,612 |      3,612 |          0 |          0 |
    load    [$i6 + 5], $f2              # |      3,612 |      3,612 |          4 |          0 |
    finv    $f3, $f5                    # |      3,612 |      3,612 |          0 |          0 |
    ble     $f0, $f3, ble.28151         # |      3,612 |      3,612 |          0 |      1,122 |
bg.28151:
    be      $i2, 0, be.28152            # |      1,806 |      1,806 |          0 |          4 |
.count dual_jmp
    b       bne.28726
ble.28151:
    be      $i2, 0, bne.28726           # |      1,806 |      1,806 |          0 |          2 |
be.28152:
    store   $f2, [$i1 + 2]              # |      1,806 |      1,806 |          0 |          0 |
    store   $f5, [$i1 + 3]              # |      1,806 |      1,806 |          0 |          0 |
    be      $f4, $f0, be.28155          # |      1,806 |      1,806 |          0 |          0 |
.count dual_jmp
    b       bne.28155                   # |      1,806 |      1,806 |          0 |          4 |
bne.28726:
    fneg    $f2, $f2                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f2, [$i1 + 2]              # |      1,806 |      1,806 |          0 |          0 |
    store   $f5, [$i1 + 3]              # |      1,806 |      1,806 |          0 |          0 |
    be      $f4, $f0, be.28155          # |      1,806 |      1,806 |          0 |          0 |
bne.28155:
    load    [$i6 + 10], $i2             # |      3,612 |      3,612 |          0 |          0 |
    finv    $f4, $f5                    # |      3,612 |      3,612 |          0 |          0 |
    load    [$i6 + 6], $f2              # |      3,612 |      3,612 |          3 |          0 |
.count storer
    add     $i4, $i5, $tmp              # |      3,612 |      3,612 |          0 |          0 |
    ble     $f0, $f4, ble.28156         # |      3,612 |      3,612 |          0 |        162 |
bg.28156:
    be      $i2, 0, be.28157            # |      1,800 |      1,800 |          0 |          6 |
.count dual_jmp
    b       bne.28729
ble.28156:
    be      $i2, 0, bne.28729           # |      1,812 |      1,812 |          0 |          6 |
be.28157:
    store   $f2, [$i1 + 4]              # |      1,800 |      1,800 |          0 |          0 |
    add     $i5, -1, $i5                # |      1,800 |      1,800 |          0 |          0 |
    store   $f5, [$i1 + 5]              # |      1,800 |      1,800 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      1,800 |      1,800 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      1,800 |      1,800 |          0 |          8 |
bne.28729:
    fneg    $f2, $f2                    # |      1,812 |      1,812 |          0 |          0 |
    store   $f2, [$i1 + 4]              # |      1,812 |      1,812 |          0 |          0 |
    add     $i5, -1, $i5                # |      1,812 |      1,812 |          0 |          0 |
    store   $f5, [$i1 + 5]              # |      1,812 |      1,812 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      1,812 |      1,812 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      1,812 |      1,812 |          0 |          8 |
be.28155:
.count storer
    add     $i4, $i5, $tmp
    store   $f0, [$i1 + 5]
    add     $i5, -1, $i5
    store   $i1, [$tmp + 0]
    b       iter_setup_dirvec_constants.2826
bl.28143:
    jr      $ra1                        # |        602 |        602 |          0 |          0 |
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($f1, $f3, $f4, $i4)
# $ra = $ra1
# [$i1 - $i3, $i5 - $i6]
# [$f2, $f5 - $f11]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
    add     $ig0, -1, $i5               # |        602 |        602 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |          0 |         12 |
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($f2, $f3, $f4, $i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1, $f5 - $f10]
# []
# []
# []
# []
######################################################################
.align 2
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i1, 0, bl.28165            # |    333,846 |    333,846 |          0 |        157 |
bge.28165:
    load    [ext_objects + $i1], $i2    # |    296,752 |    296,752 |      1,185 |          0 |
    load    [$i2 + 7], $f1              # |    296,752 |    296,752 |      8,071 |          0 |
    fsub    $f2, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 8], $f1              # |    296,752 |    296,752 |          0 |          0 |
    fsub    $f3, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 9], $f1              # |    296,752 |    296,752 |      2,581 |          0 |
    fsub    $f4, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 1], $i3              # |    296,752 |    296,752 |     20,892 |          0 |
    bne     $i3, 2, bne.28166           # |    296,752 |    296,752 |          0 |      2,803 |
be.28166:
    load    [$i2 + 19], $f1
    load    [$i2 + 20], $f5
    add     $i1, -1, $i1
    load    [$i2 + 21], $f6
    load    [$i2 + 4], $f7
    load    [$i2 + 5], $f8
    fmul    $f7, $f1, $f1
    load    [$i2 + 6], $f9
    fmul    $f8, $f5, $f5
    fmul    $f9, $f6, $f6
    fadd    $f1, $f5, $f1
    fadd    $f1, $f6, $f1
    store   $f1, [$i2 + 22]
    bge     $i1, 0, bge.28170
.count dual_jmp
    b       bl.28165
bne.28166:
    bg      $i3, 2, bg.28167            # |    296,752 |    296,752 |          0 |     99,870 |
ble.28167:
    add     $i1, -1, $i1                # |    148,376 |    148,376 |          0 |          0 |
    bge     $i1, 0, bge.28170           # |    148,376 |    148,376 |          0 |      2,933 |
.count dual_jmp
    b       bl.28165
bg.28167:
    load    [$i2 + 19], $f1             # |    148,376 |    148,376 |      4,164 |          0 |
    fmul    $f1, $f1, $f7               # |    148,376 |    148,376 |          0 |          0 |
    load    [$i2 + 20], $f5             # |    148,376 |    148,376 |          0 |          0 |
    fmul    $f5, $f5, $f9               # |    148,376 |    148,376 |          0 |          0 |
    load    [$i2 + 21], $f6             # |    148,376 |    148,376 |      1,067 |          0 |
    load    [$i2 + 4], $f8              # |    148,376 |    148,376 |      2,929 |          0 |
    load    [$i2 + 5], $f10             # |    148,376 |    148,376 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |    148,376 |    148,376 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |    148,376 |    148,376 |          0 |          0 |
    load    [$i2 + 3], $i4              # |    148,376 |    148,376 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |    148,376 |    148,376 |          0 |          0 |
    load    [$i2 + 6], $f10             # |    148,376 |    148,376 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    148,376 |    148,376 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |    148,376 |    148,376 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    148,376 |    148,376 |          0 |          0 |
    be      $i4, 0, be.28168            # |    148,376 |    148,376 |          0 |         18 |
bne.28168:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i2 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i3, 3, be.28169
.count dual_jmp
    b       bne.28169
be.28168:
    mov     $f7, $f1                    # |    148,376 |    148,376 |          0 |          0 |
    be      $i3, 3, be.28169            # |    148,376 |    148,376 |          0 |         17 |
bne.28169:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    bge     $i1, 0, bge.28170
.count dual_jmp
    b       bl.28165
be.28169:
    fsub    $f1, $fc0, $f1              # |    148,376 |    148,376 |          0 |          0 |
    add     $i1, -1, $i1                # |    148,376 |    148,376 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |    148,376 |    148,376 |          0 |          0 |
    bl      $i1, 0, bl.28165            # |    148,376 |    148,376 |          0 |        496 |
bge.28170:
    load    [ext_objects + $i1], $i2    # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 7], $f1              # |    296,752 |    296,752 |     26,998 |          0 |
    fsub    $f2, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 8], $f1              # |    296,752 |    296,752 |      6,001 |          0 |
    fsub    $f3, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 9], $f1              # |    296,752 |    296,752 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |    296,752 |    296,752 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |    296,752 |    296,752 |          0 |          0 |
    load    [$i2 + 1], $i3              # |    296,752 |    296,752 |     11,885 |          0 |
    be      $i3, 2, be.28171            # |    296,752 |    296,752 |          0 |      1,490 |
bne.28171:
    ble     $i3, 2, ble.28172           # |    259,658 |    259,658 |          0 |     79,006 |
bg.28172:
    load    [$i2 + 19], $f1             # |    185,470 |    185,470 |      6,174 |          0 |
    load    [$i2 + 20], $f5             # |    185,470 |    185,470 |      4,018 |          0 |
    fmul    $f1, $f1, $f7               # |    185,470 |    185,470 |          0 |          0 |
    load    [$i2 + 21], $f6             # |    185,470 |    185,470 |          0 |          0 |
    fmul    $f5, $f5, $f9               # |    185,470 |    185,470 |          0 |          0 |
    load    [$i2 + 4], $f8              # |    185,470 |    185,470 |      4,921 |          0 |
    fmul    $f7, $f8, $f7               # |    185,470 |    185,470 |          0 |          0 |
    load    [$i2 + 5], $f10             # |    185,470 |    185,470 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |    185,470 |    185,470 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |    185,470 |    185,470 |          0 |          0 |
    load    [$i2 + 6], $f10             # |    185,470 |    185,470 |          0 |          0 |
    load    [$i2 + 3], $i4              # |    185,470 |    185,470 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    185,470 |    185,470 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |    185,470 |    185,470 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    185,470 |    185,470 |          0 |          0 |
    be      $i4, 0, be.28173            # |    185,470 |    185,470 |          0 |      7,698 |
bne.28173:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i2 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i3, 3, be.28174
.count dual_jmp
    b       bne.28174
be.28173:
    mov     $f7, $f1                    # |    185,470 |    185,470 |          0 |          0 |
    be      $i3, 3, be.28174            # |    185,470 |    185,470 |          0 |          4 |
bne.28174:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    b       setup_startp_constants.2831
be.28174:
    fsub    $f1, $fc0, $f1              # |    185,470 |    185,470 |          0 |          0 |
    add     $i1, -1, $i1                # |    185,470 |    185,470 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |    185,470 |    185,470 |          0 |          0 |
    b       setup_startp_constants.2831 # |    185,470 |    185,470 |          0 |         25 |
ble.28172:
    add     $i1, -1, $i1                # |     74,188 |     74,188 |          0 |          0 |
    b       setup_startp_constants.2831 # |     74,188 |     74,188 |          0 |          2 |
be.28171:
    load    [$i2 + 19], $f1             # |     37,094 |     37,094 |      1,989 |          0 |
    add     $i1, -1, $i1                # |     37,094 |     37,094 |          0 |          0 |
    load    [$i2 + 20], $f5             # |     37,094 |     37,094 |          0 |          0 |
    load    [$i2 + 21], $f6             # |     37,094 |     37,094 |          0 |          0 |
    load    [$i2 + 4], $f7              # |     37,094 |     37,094 |      3,547 |          0 |
    fmul    $f7, $f1, $f1               # |     37,094 |     37,094 |          0 |          0 |
    load    [$i2 + 5], $f8              # |     37,094 |     37,094 |          0 |          0 |
    fmul    $f8, $f5, $f5               # |     37,094 |     37,094 |          0 |          0 |
    load    [$i2 + 6], $f9              # |     37,094 |     37,094 |          0 |          0 |
    fmul    $f9, $f6, $f6               # |     37,094 |     37,094 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |     37,094 |     37,094 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |     37,094 |     37,094 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |     37,094 |     37,094 |          0 |          0 |
    b       setup_startp_constants.2831 # |     37,094 |     37,094 |          0 |         65 |
bl.28165:
    ret                                 # |     37,094 |     37,094 |          0 |          0 |
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i5]
# [$f1, $f5 - $f10]
# []
# []
# []
# []
######################################################################
.align 2
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i1], $i2            # |  1,836,119 |  1,836,119 |      6,445 |          0 |
    be      $i2, -1, be.28194           # |  1,836,119 |  1,836,119 |          0 |     44,955 |
bne.28175:
    load    [ext_objects + $i2], $i2    # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 1], $i4              # |    828,503 |    828,503 |     71,791 |          0 |
    load    [$i2 + 7], $f1              # |    828,503 |    828,503 |     15,852 |          0 |
    fsub    $f2, $f1, $f1               # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 8], $f5              # |    828,503 |    828,503 |      1,824 |          0 |
    fsub    $f3, $f5, $f5               # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 9], $f6              # |    828,503 |    828,503 |      6,029 |          0 |
    fsub    $f4, $f6, $f6               # |    828,503 |    828,503 |          0 |          0 |
    bne     $i4, 1, bne.28176           # |    828,503 |    828,503 |          0 |          4 |
be.28176:
    load    [$i2 + 4], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.28178
bg.28177:
    load    [$i2 + 5], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, bg.28178
ble.28178:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.28735
.count dual_jmp
    b       be.28190
bg.28178:
    load    [$i2 + 6], $f1
    fabs    $f6, $f5
    load    [$i2 + 10], $i2
    ble     $f1, $f5, ble.28189
.count dual_jmp
    b       bg.28189
bne.28176:
    bne     $i4, 2, bne.28182           # |    828,503 |    828,503 |          0 |         96 |
be.28182:
    load    [$i2 + 4], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 5], $f8
    fmul    $f8, $f5, $f5
    load    [$i2 + 6], $f9
    fmul    $f9, $f6, $f6
    load    [$i2 + 10], $i2
    fadd    $f1, $f5, $f1
    fadd    $f1, $f6, $f1
    ble     $f0, $f1, ble.28189
.count dual_jmp
    b       bg.28189
bne.28182:
    fmul    $f1, $f1, $f7               # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 4], $f8              # |    828,503 |    828,503 |          0 |          0 |
    fmul    $f5, $f5, $f9               # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 5], $f10             # |    828,503 |    828,503 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |    828,503 |    828,503 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 3], $i5              # |    828,503 |    828,503 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 6], $f10             # |    828,503 |    828,503 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    828,503 |    828,503 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |    828,503 |    828,503 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    828,503 |    828,503 |          0 |          0 |
    be      $i5, 0, be.28187            # |    828,503 |    828,503 |          0 |          2 |
bne.28187:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i2 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i4, 3, be.28188
.count dual_jmp
    b       bne.28188
be.28187:
    mov     $f7, $f1                    # |    828,503 |    828,503 |          0 |          0 |
    be      $i4, 3, be.28188            # |    828,503 |    828,503 |          0 |      3,326 |
bne.28188:
    load    [$i2 + 10], $i2
    ble     $f0, $f1, ble.28189
.count dual_jmp
    b       bg.28189
be.28188:
    fsub    $f1, $fc0, $f1              # |    828,503 |    828,503 |          0 |          0 |
    load    [$i2 + 10], $i2             # |    828,503 |    828,503 |          0 |          0 |
    ble     $f0, $f1, ble.28189         # |    828,503 |    828,503 |          0 |    247,177 |
bg.28189:
    be      $i2, 0, be.28190            # |    535,761 |    535,761 |          0 |          2 |
.count dual_jmp
    b       bne.28735
ble.28189:
    be      $i2, 0, bne.28735           # |    292,742 |    292,742 |          0 |        779 |
be.28190:
    add     $i1, 1, $i2                 # |    535,761 |    535,761 |          0 |          0 |
    load    [$i3 + $i2], $i2            # |    535,761 |    535,761 |          0 |          0 |
    be      $i2, -1, be.28194           # |    535,761 |    535,761 |          0 |      5,520 |
bne.28194:
    load    [ext_objects + $i2], $i2    # |    525,920 |    525,920 |        932 |          0 |
    load    [$i2 + 1], $i4              # |    525,920 |    525,920 |      7,524 |          0 |
    load    [$i2 + 7], $f1              # |    525,920 |    525,920 |      8,955 |          0 |
    fsub    $f2, $f1, $f1               # |    525,920 |    525,920 |          0 |          0 |
    load    [$i2 + 8], $f5              # |    525,920 |    525,920 |      3,324 |          0 |
    fsub    $f3, $f5, $f5               # |    525,920 |    525,920 |          0 |          0 |
    load    [$i2 + 9], $f6              # |    525,920 |    525,920 |          0 |          0 |
    fsub    $f4, $f6, $f6               # |    525,920 |    525,920 |          0 |          0 |
    bne     $i4, 1, bne.28195           # |    525,920 |    525,920 |          0 |          2 |
be.28195:
    load    [$i2 + 4], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.28197
bg.28196:
    load    [$i2 + 5], $f1
    fabs    $f5, $f5
    ble     $f1, $f5, ble.28197
bg.28197:
    load    [$i2 + 6], $f1
    fabs    $f6, $f5
    load    [$i2 + 10], $i2
    ble     $f1, $f5, ble.28208
.count dual_jmp
    b       bg.28208
ble.28197:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.28735
.count dual_jmp
    b       be.28209
bne.28195:
    bne     $i4, 2, bne.28201           # |    525,920 |    525,920 |          0 |     77,244 |
be.28201:
    load    [$i2 + 4], $f7              # |     78,136 |     78,136 |      1,851 |          0 |
    fmul    $f7, $f1, $f1               # |     78,136 |     78,136 |          0 |          0 |
    load    [$i2 + 5], $f8              # |     78,136 |     78,136 |          0 |          0 |
    fmul    $f8, $f5, $f5               # |     78,136 |     78,136 |          0 |          0 |
    load    [$i2 + 6], $f9              # |     78,136 |     78,136 |          0 |          0 |
    fmul    $f9, $f6, $f6               # |     78,136 |     78,136 |          0 |          0 |
    load    [$i2 + 10], $i2             # |     78,136 |     78,136 |      2,849 |          0 |
    fadd    $f1, $f5, $f1               # |     78,136 |     78,136 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |     78,136 |     78,136 |          0 |          0 |
    ble     $f0, $f1, ble.28208         # |     78,136 |     78,136 |          0 |     28,309 |
.count dual_jmp
    b       bg.28208                    # |     31,671 |     31,671 |          0 |          2 |
bne.28201:
    fmul    $f1, $f1, $f7               # |    447,784 |    447,784 |          0 |          0 |
    load    [$i2 + 4], $f8              # |    447,784 |    447,784 |      2,727 |          0 |
    fmul    $f5, $f5, $f9               # |    447,784 |    447,784 |          0 |          0 |
    load    [$i2 + 5], $f10             # |    447,784 |    447,784 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |    447,784 |    447,784 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |    447,784 |    447,784 |          0 |          0 |
    load    [$i2 + 3], $i5              # |    447,784 |    447,784 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |    447,784 |    447,784 |          0 |          0 |
    load    [$i2 + 6], $f10             # |    447,784 |    447,784 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    447,784 |    447,784 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |    447,784 |    447,784 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    447,784 |    447,784 |          0 |          0 |
    be      $i5, 0, be.28206            # |    447,784 |    447,784 |          0 |          2 |
bne.28206:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i2 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i4, 3, be.28207
.count dual_jmp
    b       bne.28207
be.28206:
    mov     $f7, $f1                    # |    447,784 |    447,784 |          0 |          0 |
    be      $i4, 3, be.28207            # |    447,784 |    447,784 |          0 |          2 |
bne.28207:
    load    [$i2 + 10], $i2
    ble     $f0, $f1, ble.28208
.count dual_jmp
    b       bg.28208
be.28207:
    fsub    $f1, $fc0, $f1              # |    447,784 |    447,784 |          0 |          0 |
    load    [$i2 + 10], $i2             # |    447,784 |    447,784 |          0 |          0 |
    ble     $f0, $f1, ble.28208         # |    447,784 |    447,784 |          0 |     99,687 |
bg.28208:
    be      $i2, 0, be.28209            # |    134,844 |    134,844 |          0 |          0 |
.count dual_jmp
    b       bne.28735                   # |    134,844 |    134,844 |          0 |     10,938 |
ble.28208:
    be      $i2, 0, bne.28735           # |    391,076 |    391,076 |          0 |      1,868 |
be.28209:
    add     $i1, 2, $i1                 # |    391,076 |    391,076 |          0 |          0 |
    b       check_all_inside.2856       # |    391,076 |    391,076 |          0 |         13 |
bne.28735:
    li      0, $i1                      # |    427,586 |    427,586 |          0 |          0 |
    ret                                 # |    427,586 |    427,586 |          0 |          0 |
be.28194:
    li      1, $i1                      # |  1,017,457 |  1,017,457 |          0 |          0 |
    ret                                 # |  1,017,457 |  1,017,457 |          0 |          0 |
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i6, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra]
######################################################################
.align 2
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i3 + $i6], $i1            # |  4,220,859 |  4,220,859 |      8,601 |          0 |
    be      $i1, -1, be.28237           # |  4,220,859 |  4,220,859 |          0 |      6,813 |
bne.28213:
    load    [ext_objects + $i1], $i2    # |  3,593,254 |  3,593,254 |      4,354 |          0 |
    load    [ext_light_dirvec + 3], $i4 # |  3,593,254 |  3,593,254 |          0 |          0 |
    load    [$i2 + 1], $i5              # |  3,593,254 |  3,593,254 |      7,254 |          0 |
    load    [$i2 + 7], $f1              # |  3,593,254 |  3,593,254 |     26,861 |          0 |
    load    [$i2 + 8], $f2              # |  3,593,254 |  3,593,254 |        454 |          0 |
    fsub    $fg1, $f1, $f1              # |  3,593,254 |  3,593,254 |          0 |          0 |
    load    [$i2 + 9], $f3              # |  3,593,254 |  3,593,254 |      2,196 |          0 |
    fsub    $fg3, $f2, $f2              # |  3,593,254 |  3,593,254 |          0 |          0 |
    load    [$i4 + $i1], $i4            # |  3,593,254 |  3,593,254 |     39,418 |          0 |
    fsub    $fg2, $f3, $f3              # |  3,593,254 |  3,593,254 |          0 |          0 |
    load    [$i4 + 0], $f4              # |  3,593,254 |  3,593,254 |    118,277 |          0 |
    bne     $i5, 1, bne.28214           # |  3,593,254 |  3,593,254 |          0 |    419,264 |
be.28214:
    load    [$i4 + 1], $f5              # |  1,408,852 |  1,408,852 |     13,210 |          0 |
    fsub    $f4, $f1, $f4               # |  1,408,852 |  1,408,852 |          0 |          0 |
    load    [$i2 + 5], $f6              # |  1,408,852 |  1,408,852 |      4,485 |          0 |
    fmul    $f4, $f5, $f4               # |  1,408,852 |  1,408,852 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f7# |  1,408,852 |  1,408,852 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |  1,408,852 |  1,408,852 |          0 |          0 |
    fadd_a  $f7, $f2, $f7               # |  1,408,852 |  1,408,852 |          0 |          0 |
    ble     $f6, $f7, be.28217          # |  1,408,852 |  1,408,852 |          0 |    315,729 |
bg.28215:
    load    [%{ext_light_dirvec + 0} + 2], $f6# |    411,001 |    411,001 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |    411,001 |    411,001 |          0 |          0 |
    load    [$i2 + 6], $f7              # |    411,001 |    411,001 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    411,001 |    411,001 |          0 |          0 |
    ble     $f7, $f6, be.28217          # |    411,001 |    411,001 |          0 |     60,347 |
bg.28216:
    bne     $f5, $f0, bne.28217         # |    274,765 |    274,765 |          0 |        778 |
be.28217:
    load    [$i4 + 2], $f4              # |  1,134,087 |  1,134,087 |     34,901 |          0 |
    fsub    $f4, $f2, $f4               # |  1,134,087 |  1,134,087 |          0 |          0 |
    load    [$i4 + 3], $f5              # |  1,134,087 |  1,134,087 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |  1,134,087 |  1,134,087 |          0 |          0 |
    load    [$i2 + 4], $f6              # |  1,134,087 |  1,134,087 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f7# |  1,134,087 |  1,134,087 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |  1,134,087 |  1,134,087 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |  1,134,087 |  1,134,087 |          0 |          0 |
    ble     $f6, $f7, be.28221          # |  1,134,087 |  1,134,087 |          0 |    360,584 |
bg.28219:
    load    [%{ext_light_dirvec + 0} + 2], $f6# |    501,972 |    501,972 |          0 |          0 |
    load    [$i2 + 6], $f7              # |    501,972 |    501,972 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |    501,972 |    501,972 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    501,972 |    501,972 |          0 |          0 |
    ble     $f7, $f6, be.28221          # |    501,972 |    501,972 |          0 |     81,412 |
bg.28220:
    be      $f5, $f0, be.28221          # |    363,084 |    363,084 |          0 |          0 |
bne.28217:
    mov     $f4, $fg0                   # |    637,849 |    637,849 |          0 |          0 |
.count load_float
    load    [f.27978], $f1              # |    637,849 |    637,849 |        839 |          0 |
    ble     $f1, $fg0, ble.28235        # |    637,849 |    637,849 |          0 |     56,418 |
.count dual_jmp
    b       bg.28235                    # |    285,421 |    285,421 |          0 |      2,547 |
be.28221:
    load    [$i4 + 4], $f4              # |    771,003 |    771,003 |      5,221 |          0 |
    load    [$i4 + 5], $f5              # |    771,003 |    771,003 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |    771,003 |    771,003 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    771,003 |    771,003 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |    771,003 |    771,003 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f4# |    771,003 |    771,003 |          0 |          0 |
    fmul    $f3, $f4, $f4               # |    771,003 |    771,003 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |    771,003 |    771,003 |          0 |          0 |
    ble     $f6, $f1, ble.28235         # |    771,003 |    771,003 |          0 |    107,748 |
bg.28223:
    load    [%{ext_light_dirvec + 0} + 1], $f1# |    129,260 |    129,260 |          0 |          0 |
    fmul    $f3, $f1, $f1               # |    129,260 |    129,260 |          0 |          0 |
    load    [$i2 + 5], $f4              # |    129,260 |    129,260 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |    129,260 |    129,260 |          0 |          0 |
    ble     $f4, $f1, ble.28235         # |    129,260 |    129,260 |          0 |     11,181 |
bg.28224:
    be      $f5, $f0, ble.28235         # |     50,831 |     50,831 |          0 |          0 |
bne.28225:
    mov     $f3, $fg0                   # |     50,831 |     50,831 |          0 |          0 |
.count load_float
    load    [f.27978], $f1              # |     50,831 |     50,831 |        149 |          0 |
    ble     $f1, $fg0, ble.28235        # |     50,831 |     50,831 |          0 |      5,217 |
.count dual_jmp
    b       bg.28235                    # |     46,334 |     46,334 |          0 |      4,571 |
bne.28214:
    be      $i5, 2, be.28227            # |  2,184,402 |  2,184,402 |          0 |     10,022 |
bne.28227:
    be      $f4, $f0, ble.28235         # |  1,618,265 |  1,618,265 |          0 |        858 |
bne.28229:
    load    [$i4 + 2], $f6              # |  1,618,265 |  1,618,265 |     19,823 |          0 |
    fmul    $f6, $f2, $f6               # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i4 + 1], $f5              # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f5, $f1, $f5               # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i4 + 3], $f7              # |  1,618,265 |  1,618,265 |     12,549 |          0 |
    fmul    $f7, $f3, $f7               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f1, $f1, $f8               # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i2 + 5], $f10             # |  1,618,265 |  1,618,265 |     15,342 |          0 |
    fadd    $f5, $f6, $f5               # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i2 + 4], $f6              # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f2, $f2, $f9               # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i2 + 3], $i7              # |  1,618,265 |  1,618,265 |          0 |          0 |
    fadd    $f5, $f7, $f5               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f8, $f6, $f6               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f9, $f10, $f7              # |  1,618,265 |  1,618,265 |          0 |          0 |
    load    [$i2 + 6], $f9              # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f3, $f3, $f8               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fadd    $f6, $f7, $f6               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f8, $f9, $f7               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fadd    $f6, $f7, $f6               # |  1,618,265 |  1,618,265 |          0 |          0 |
    be      $i7, 0, be.28230            # |  1,618,265 |  1,618,265 |          0 |          7 |
bne.28230:
    fmul    $f2, $f3, $f7
    load    [$i2 + 16], $f8
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f9
    fmul    $f7, $f8, $f7
    fmul    $f1, $f2, $f1
    fmul    $f3, $f9, $f2
    fadd    $f6, $f7, $f3
    load    [$i2 + 18], $f6
    fadd    $f3, $f2, $f2
    fmul    $f1, $f6, $f1
    fadd    $f2, $f1, $f1
    be      $i5, 3, be.28231
.count dual_jmp
    b       bne.28231
be.28230:
    mov     $f6, $f1                    # |  1,618,265 |  1,618,265 |          0 |          0 |
    be      $i5, 3, be.28231            # |  1,618,265 |  1,618,265 |          0 |          4 |
bne.28231:
    fmul    $f5, $f5, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, ble.28235
.count dual_jmp
    b       bg.28232
be.28231:
    fsub    $f1, $fc0, $f1              # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f5, $f5, $f2               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |  1,618,265 |  1,618,265 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |  1,618,265 |  1,618,265 |          0 |          0 |
    ble     $f1, $f0, ble.28235         # |  1,618,265 |  1,618,265 |          0 |     72,017 |
bg.28232:
    load    [$i2 + 10], $i2             # |    348,478 |    348,478 |         47 |          0 |
    load    [$i4 + 4], $f2              # |    348,478 |    348,478 |          5 |          0 |
    fsqrt   $f1, $f1                    # |    348,478 |    348,478 |          0 |          0 |
    be      $i2, 0, be.28233            # |    348,478 |    348,478 |          0 |     55,564 |
bne.28233:
    fadd    $f5, $f1, $f1               # |     70,036 |     70,036 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |     70,036 |     70,036 |          0 |          0 |
.count load_float
    load    [f.27978], $f1              # |     70,036 |     70,036 |          0 |          0 |
    ble     $f1, $fg0, ble.28235        # |     70,036 |     70,036 |          0 |      8,434 |
.count dual_jmp
    b       bg.28235                    # |     12,667 |     12,667 |          0 |          2 |
be.28233:
    fsub    $f5, $f1, $f1               # |    278,442 |    278,442 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |    278,442 |    278,442 |          0 |          0 |
.count load_float
    load    [f.27978], $f1              # |    278,442 |    278,442 |          0 |          0 |
    ble     $f1, $fg0, ble.28235        # |    278,442 |    278,442 |          0 |     34,066 |
.count dual_jmp
    b       bg.28235                    # |    218,551 |    218,551 |          0 |          2 |
be.28227:
    ble     $f0, $f4, ble.28235         # |    566,137 |    566,137 |          0 |          6 |
bg.28228:
    load    [$i4 + 1], $f4              # |    554,722 |    554,722 |     13,373 |          0 |
    fmul    $f4, $f1, $f1               # |    554,722 |    554,722 |          0 |          0 |
    load    [$i4 + 2], $f5              # |    554,722 |    554,722 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |    554,722 |    554,722 |          0 |          0 |
    load    [$i4 + 3], $f6              # |    554,722 |    554,722 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |    554,722 |    554,722 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |    554,722 |    554,722 |          0 |          0 |
    fadd    $f1, $f3, $fg0              # |    554,722 |    554,722 |          0 |          0 |
.count load_float
    load    [f.27978], $f1              # |    554,722 |    554,722 |        171 |          0 |
    bg      $f1, $fg0, bg.28235         # |    554,722 |    554,722 |          0 |          0 |
ble.28235:
    load    [ext_objects + $i1], $i1    # |  3,030,281 |  3,030,281 |          0 |          0 |
    load    [$i1 + 10], $i1             # |  3,030,281 |  3,030,281 |     12,871 |          0 |
    bne     $i1, 0, bne.28747           # |  3,030,281 |  3,030,281 |          0 |     11,448 |
be.28237:
    li      0, $i1                      # |  3,032,330 |  3,032,330 |          0 |          0 |
    jr      $ra1                        # |  3,032,330 |  3,032,330 |          0 |          0 |
bg.28235:
    load    [$i3 + 0], $i1              # |    562,973 |    562,973 |          0 |          0 |
    be      $i1, -1, bne.28257          # |    562,973 |    562,973 |          0 |         72 |
bne.28238:
.count load_float
    load    [f.27979], $f1              # |    562,973 |    562,973 |          0 |          0 |
    load    [ext_objects + $i1], $i1    # |    562,973 |    562,973 |          0 |          0 |
    fadd    $fg0, $f1, $f1              # |    562,973 |    562,973 |          0 |          0 |
    load    [$i1 + 8], $f5              # |    562,973 |    562,973 |          0 |          0 |
    fmul    $fg16, $f1, $f2             # |    562,973 |    562,973 |          0 |          0 |
    load    [$i1 + 9], $f6              # |    562,973 |    562,973 |          0 |          0 |
    fmul    $fg14, $f1, $f3             # |    562,973 |    562,973 |          0 |          0 |
    fmul    $fg15, $f1, $f1             # |    562,973 |    562,973 |          0 |          0 |
    load    [$i1 + 1], $i2              # |    562,973 |    562,973 |          0 |          0 |
    fadd    $f2, $fg1, $f2              # |    562,973 |    562,973 |          0 |          0 |
    fadd    $f3, $fg3, $f3              # |    562,973 |    562,973 |          0 |          0 |
    fadd    $f1, $fg2, $f4              # |    562,973 |    562,973 |          0 |          0 |
    load    [$i1 + 7], $f1              # |    562,973 |    562,973 |          0 |          0 |
    fsub    $f3, $f5, $f5               # |    562,973 |    562,973 |          0 |          0 |
    fsub    $f4, $f6, $f6               # |    562,973 |    562,973 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |    562,973 |    562,973 |          0 |          0 |
    bne     $i2, 1, bne.28239           # |    562,973 |    562,973 |          0 |     19,645 |
be.28239:
    load    [$i1 + 4], $f7              # |    541,299 |    541,299 |          0 |          0 |
    fabs    $f1, $f1                    # |    541,299 |    541,299 |          0 |          0 |
    ble     $f7, $f1, ble.28241         # |    541,299 |    541,299 |          0 |     33,608 |
bg.28240:
    load    [$i1 + 5], $f1              # |    484,974 |    484,974 |          0 |          0 |
    fabs    $f5, $f5                    # |    484,974 |    484,974 |          0 |          0 |
    ble     $f1, $f5, ble.28241         # |    484,974 |    484,974 |          0 |      5,529 |
bg.28241:
    load    [$i1 + 6], $f1              # |    479,395 |    479,395 |          0 |          0 |
    fabs    $f6, $f5                    # |    479,395 |    479,395 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    479,395 |    479,395 |      1,416 |          0 |
    ble     $f1, $f5, ble.28252         # |    479,395 |    479,395 |          0 |     28,705 |
.count dual_jmp
    b       bg.28252                    # |    477,190 |    477,190 |          0 |          4 |
ble.28241:
    load    [$i1 + 10], $i1             # |     61,904 |     61,904 |          0 |          0 |
    be      $i1, 0, bne.28747           # |     61,904 |     61,904 |          0 |         10 |
.count dual_jmp
    b       be.28253
bne.28239:
    bne     $i2, 2, bne.28245           # |     21,674 |     21,674 |          0 |          2 |
be.28245:
    load    [$i1 + 4], $f7
    load    [$i1 + 5], $f8
    fmul    $f7, $f1, $f1
    load    [$i1 + 6], $f9
    fmul    $f8, $f5, $f5
    fmul    $f9, $f6, $f6
    load    [$i1 + 10], $i1
    fadd    $f1, $f5, $f1
    fadd    $f1, $f6, $f1
    ble     $f0, $f1, ble.28252
.count dual_jmp
    b       bg.28252
bne.28245:
    fmul    $f1, $f1, $f7               # |     21,674 |     21,674 |          0 |          0 |
    load    [$i1 + 4], $f8              # |     21,674 |     21,674 |          0 |          0 |
    fmul    $f5, $f5, $f9               # |     21,674 |     21,674 |          0 |          0 |
    load    [$i1 + 5], $f10             # |     21,674 |     21,674 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |     21,674 |     21,674 |          0 |          0 |
    load    [$i1 + 3], $i4              # |     21,674 |     21,674 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |     21,674 |     21,674 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |     21,674 |     21,674 |          0 |          0 |
    load    [$i1 + 6], $f10             # |     21,674 |     21,674 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |     21,674 |     21,674 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |     21,674 |     21,674 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |     21,674 |     21,674 |          0 |          0 |
    be      $i4, 0, be.28250            # |     21,674 |     21,674 |          0 |          0 |
bne.28250:
    fmul    $f5, $f6, $f8
    load    [$i1 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i1 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i1 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i2, 3, be.28251
.count dual_jmp
    b       bne.28251
be.28250:
    mov     $f7, $f1                    # |     21,674 |     21,674 |          0 |          0 |
    be      $i2, 3, be.28251            # |     21,674 |     21,674 |          0 |          2 |
bne.28251:
    load    [$i1 + 10], $i1
    ble     $f0, $f1, ble.28252
.count dual_jmp
    b       bg.28252
be.28251:
    fsub    $f1, $fc0, $f1              # |     21,674 |     21,674 |          0 |          0 |
    load    [$i1 + 10], $i1             # |     21,674 |     21,674 |          0 |          0 |
    ble     $f0, $f1, ble.28252         # |     21,674 |     21,674 |          0 |         81 |
bg.28252:
    be      $i1, 0, be.28253            # |    498,864 |    498,864 |          0 |          6 |
.count dual_jmp
    b       bne.28747
ble.28252:
    be      $i1, 0, bne.28747           # |      2,205 |      2,205 |          0 |          2 |
be.28253:
    li      1, $i1                      # |    498,864 |    498,864 |          0 |          0 |
    call    check_all_inside.2856       # |    498,864 |    498,864 |          0 |          0 |
    be      $i1, 0, bne.28747           # |    498,864 |    498,864 |          0 |     10,043 |
bne.28257:
    li      1, $i1                      # |    236,134 |    236,134 |          0 |          0 |
    jr      $ra1                        # |    236,134 |    236,134 |          0 |          0 |
bne.28747:
    add     $i6, 1, $i6                 # |    952,395 |    952,395 |          0 |          0 |
    b       shadow_check_and_group.2862 # |    952,395 |    952,395 |          0 |     14,731 |
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i8, $i9)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i9 + $i8], $i1
    be      $i1, -1, be.28272
bne.28258:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28259:
    add     $i8, 1, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28260:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28261:
    add     $i8, 2, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28262:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28263:
    add     $i8, 3, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28264:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28265:
    add     $i8, 4, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28266:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28267:
    add     $i8, 5, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28268:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28269:
    add     $i8, 6, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28270:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28259
be.28271:
    add     $i8, 7, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.28272
bne.28272:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    be      $i1, 0, be.28273
bne.28259:
    li      1, $i1
    jr      $ra2
be.28273:
    add     $i8, 8, $i8
    b       shadow_check_one_or_group.2865
be.28272:
    li      0, $i1
    jr      $ra2
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i10, $i11)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f10]
# []
# [$fg0]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i11 + $i10], $i9          # |  1,776,311 |  1,776,311 |          0 |          0 |
    load    [$i9 + 0], $i1              # |  1,776,311 |  1,776,311 |      7,039 |          0 |
    be      $i1, -1, be.28274           # |  1,776,311 |  1,776,311 |          0 |     71,884 |
bne.28274:
    be      $i1, 99, bne.28299          # |  1,225,537 |  1,225,537 |          0 |     10,139 |
bne.28275:
    load    [ext_objects + $i1], $i2    # |    670,815 |    670,815 |      3,887 |          0 |
    load    [ext_light_dirvec + 3], $i3 # |    670,815 |    670,815 |     12,889 |          0 |
    load    [$i2 + 7], $f1              # |    670,815 |    670,815 |      7,929 |          0 |
    fsub    $fg1, $f1, $f1              # |    670,815 |    670,815 |          0 |          0 |
    load    [$i2 + 8], $f2              # |    670,815 |    670,815 |          0 |          0 |
    fsub    $fg3, $f2, $f2              # |    670,815 |    670,815 |          0 |          0 |
    load    [$i2 + 9], $f3              # |    670,815 |    670,815 |          0 |          0 |
    fsub    $fg2, $f3, $f3              # |    670,815 |    670,815 |          0 |          0 |
    load    [$i3 + $i1], $i1            # |    670,815 |    670,815 |     12,026 |          0 |
    load    [$i2 + 1], $i3              # |    670,815 |    670,815 |      4,556 |          0 |
    load    [$i1 + 0], $f4              # |    670,815 |    670,815 |     17,230 |          0 |
    bne     $i3, 1, bne.28276           # |    670,815 |    670,815 |          0 |     15,032 |
be.28276:
    load    [$i1 + 1], $f5              # |    670,815 |    670,815 |          0 |          0 |
    fsub    $f4, $f1, $f4               # |    670,815 |    670,815 |          0 |          0 |
    load    [$i2 + 5], $f6              # |    670,815 |    670,815 |      4,064 |          0 |
    fmul    $f4, $f5, $f4               # |    670,815 |    670,815 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f7# |    670,815 |    670,815 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |    670,815 |    670,815 |          0 |          0 |
    fadd_a  $f7, $f2, $f7               # |    670,815 |    670,815 |          0 |          0 |
    ble     $f6, $f7, be.28279          # |    670,815 |    670,815 |          0 |    134,059 |
bg.28277:
    load    [%{ext_light_dirvec + 0} + 2], $f6# |    226,795 |    226,795 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |    226,795 |    226,795 |          0 |          0 |
    load    [$i2 + 6], $f7              # |    226,795 |    226,795 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    226,795 |    226,795 |          0 |          0 |
    ble     $f7, $f6, be.28279          # |    226,795 |    226,795 |          0 |     49,404 |
bg.28278:
    bne     $f5, $f0, bne.28279         # |    146,676 |    146,676 |          0 |     24,130 |
be.28279:
    load    [$i1 + 2], $f4              # |    524,139 |    524,139 |          0 |          0 |
    fsub    $f4, $f2, $f4               # |    524,139 |    524,139 |          0 |          0 |
    load    [$i1 + 3], $f5              # |    524,139 |    524,139 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |    524,139 |    524,139 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    524,139 |    524,139 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f7# |    524,139 |    524,139 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |    524,139 |    524,139 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |    524,139 |    524,139 |          0 |          0 |
    ble     $f6, $f7, be.28283          # |    524,139 |    524,139 |          0 |     74,194 |
bg.28281:
    load    [%{ext_light_dirvec + 0} + 2], $f6# |     76,275 |     76,275 |          0 |          0 |
    load    [$i2 + 6], $f7              # |     76,275 |     76,275 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |     76,275 |     76,275 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |     76,275 |     76,275 |          0 |          0 |
    ble     $f7, $f6, be.28283          # |     76,275 |     76,275 |          0 |     14,499 |
bg.28282:
    be      $f5, $f0, be.28283          # |     34,833 |     34,833 |          0 |         15 |
bne.28279:
    mov     $f4, $fg0                   # |    181,509 |    181,509 |          0 |          0 |
    ble     $fc7, $fg0, be.28328        # |    181,509 |    181,509 |          0 |     44,165 |
.count dual_jmp
    b       bg.28297                    # |    175,414 |    175,414 |          0 |          6 |
be.28283:
    load    [$i1 + 4], $f4              # |    489,306 |    489,306 |     20,306 |          0 |
    fsub    $f4, $f3, $f3               # |    489,306 |    489,306 |          0 |          0 |
    load    [$i1 + 5], $f5              # |    489,306 |    489,306 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |    489,306 |    489,306 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    489,306 |    489,306 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f4# |    489,306 |    489,306 |          0 |          0 |
    fmul    $f3, $f4, $f4               # |    489,306 |    489,306 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |    489,306 |    489,306 |          0 |          0 |
    ble     $f6, $f1, be.28328          # |    489,306 |    489,306 |          0 |     20,020 |
bg.28285:
    load    [%{ext_light_dirvec + 0} + 1], $f1# |     31,989 |     31,989 |          0 |          0 |
    load    [$i2 + 5], $f4              # |     31,989 |     31,989 |          0 |          0 |
    fmul    $f3, $f1, $f1               # |     31,989 |     31,989 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |     31,989 |     31,989 |          0 |          0 |
    ble     $f4, $f1, be.28328          # |     31,989 |     31,989 |          0 |      6,405 |
bg.28286:
    be      $f5, $f0, be.28328          # |     24,337 |     24,337 |          0 |         23 |
bne.28287:
    mov     $f3, $fg0                   # |     24,337 |     24,337 |          0 |          0 |
    ble     $fc7, $fg0, be.28328        # |     24,337 |     24,337 |          0 |      1,650 |
.count dual_jmp
    b       bg.28297                    # |     23,292 |     23,292 |          0 |          4 |
bne.28276:
    be      $i3, 2, be.28289
bne.28289:
    be      $f4, $f0, be.28328
bne.28291:
    load    [$i1 + 2], $f6
    fmul    $f6, $f2, $f6
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f5
    load    [$i1 + 3], $f7
    fmul    $f7, $f3, $f7
    fmul    $f1, $f1, $f8
    load    [$i2 + 5], $f10
    fadd    $f5, $f6, $f5
    load    [$i2 + 4], $f6
    fmul    $f2, $f2, $f9
    load    [$i2 + 3], $i4
    fadd    $f5, $f7, $f5
    fmul    $f8, $f6, $f6
    fmul    $f9, $f10, $f7
    load    [$i2 + 6], $f9
    fmul    $f3, $f3, $f8
    fadd    $f6, $f7, $f6
    fmul    $f8, $f9, $f7
    fadd    $f6, $f7, $f6
    be      $i4, 0, be.28292
bne.28292:
    fmul    $f2, $f3, $f7
    load    [$i2 + 16], $f8
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f9
    fmul    $f7, $f8, $f7
    fmul    $f1, $f2, $f1
    fmul    $f3, $f9, $f2
    fadd    $f6, $f7, $f3
    load    [$i2 + 18], $f6
    fadd    $f3, $f2, $f2
    fmul    $f1, $f6, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28293
.count dual_jmp
    b       bne.28293
be.28292:
    mov     $f6, $f1
    be      $i3, 3, be.28293
bne.28293:
    fmul    $f5, $f5, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, be.28328
.count dual_jmp
    b       bg.28294
be.28293:
    fsub    $f1, $fc0, $f1
    fmul    $f5, $f5, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, be.28328
bg.28294:
    load    [$i2 + 10], $i2
    load    [$i1 + 4], $f2
    fsqrt   $f1, $f1
    be      $i2, 0, be.28295
bne.28295:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc7, $fg0, be.28328
.count dual_jmp
    b       bg.28297
be.28295:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc7, $fg0, be.28328
.count dual_jmp
    b       bg.28297
be.28289:
    ble     $f0, $f4, be.28328
bg.28290:
    load    [$i1 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 2], $f5
    fmul    $f5, $f2, $f2
    load    [$i1 + 3], $f6
    fmul    $f6, $f3, $f3
    fadd    $f1, $f2, $f1
    fadd    $f1, $f3, $fg0
    ble     $fc7, $fg0, be.28328
bg.28297:
    load    [$i9 + 1], $i1              # |    198,706 |    198,706 |          0 |          0 |
    be      $i1, -1, be.28328           # |    198,706 |    198,706 |          0 |        575 |
bne.28298:
    load    [ext_and_net + $i1], $i3    # |    198,706 |    198,706 |      2,301 |          0 |
    li      0, $i6                      # |    198,706 |    198,706 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    198,706 |    198,706 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |    198,706 |    198,706 |          0 |        622 |
be.28299:
    load    [$i9 + 2], $i1              # |    158,057 |    158,057 |          0 |          0 |
    be      $i1, -1, be.28328           # |    158,057 |    158,057 |          0 |      5,560 |
bne.28300:
    li      0, $i6                      # |    158,057 |    158,057 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    158,057 |    158,057 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    158,057 |    158,057 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |    158,057 |    158,057 |          0 |     10,549 |
be.28301:
    load    [$i9 + 3], $i1              # |    147,850 |    147,850 |         57 |          0 |
    be      $i1, -1, be.28328           # |    147,850 |    147,850 |          0 |        565 |
bne.28302:
    li      0, $i6                      # |    147,850 |    147,850 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    147,850 |    147,850 |        176 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    147,850 |    147,850 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |    147,850 |    147,850 |          0 |      2,238 |
be.28303:
    load    [$i9 + 4], $i1              # |     92,769 |     92,769 |          0 |          0 |
    be      $i1, -1, be.28328           # |     92,769 |     92,769 |          0 |     17,497 |
bne.28304:
    li      0, $i6                      # |     92,769 |     92,769 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     92,769 |     92,769 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     92,769 |     92,769 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |     92,769 |     92,769 |          0 |     22,573 |
be.28305:
    load    [$i9 + 5], $i1              # |     89,445 |     89,445 |          0 |          0 |
    be      $i1, -1, be.28328           # |     89,445 |     89,445 |          0 |          0 |
bne.28306:
    li      0, $i6                      # |     89,445 |     89,445 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     89,445 |     89,445 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     89,445 |     89,445 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |     89,445 |     89,445 |          0 |        111 |
be.28307:
    load    [$i9 + 6], $i1              # |     88,359 |     88,359 |          0 |          0 |
    be      $i1, -1, be.28328           # |     88,359 |     88,359 |          0 |      1,933 |
bne.28308:
    li      0, $i6                      # |     88,359 |     88,359 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     88,359 |     88,359 |        806 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     88,359 |     88,359 |          0 |          0 |
    bne     $i1, 0, bne.28299           # |     88,359 |     88,359 |          0 |        405 |
be.28309:
    load    [$i9 + 7], $i1              # |     82,613 |     82,613 |         26 |          0 |
    be      $i1, -1, be.28328           # |     82,613 |     82,613 |          0 |          1 |
bne.28310:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28299
be.28311:
    li      8, $i8
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.28328
bne.28299:
    load    [$i9 + 1], $i1              # |    670,815 |    670,815 |          0 |          0 |
    be      $i1, -1, be.28328           # |    670,815 |    670,815 |          0 |     26,693 |
bne.28314:
    load    [ext_and_net + $i1], $i3    # |    670,815 |    670,815 |      1,578 |          0 |
    li      0, $i6                      # |    670,815 |    670,815 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    670,815 |    670,815 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |    670,815 |    670,815 |          0 |         21 |
be.28315:
    load    [$i9 + 2], $i1              # |    630,166 |    630,166 |          0 |          0 |
    be      $i1, -1, be.28328           # |    630,166 |    630,166 |          0 |     56,136 |
bne.28316:
    li      0, $i6                      # |    630,166 |    630,166 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    630,166 |    630,166 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    630,166 |    630,166 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |    630,166 |    630,166 |          0 |        573 |
be.28317:
    load    [$i9 + 3], $i1              # |    618,375 |    618,375 |        273 |          0 |
    be      $i1, -1, be.28328           # |    618,375 |    618,375 |          0 |         28 |
bne.28318:
    li      0, $i6                      # |    618,375 |    618,375 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    618,375 |    618,375 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    618,375 |    618,375 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |    618,375 |    618,375 |          0 |        441 |
be.28319:
    load    [$i9 + 4], $i1              # |    561,344 |    561,344 |          0 |          0 |
    be      $i1, -1, be.28328           # |    561,344 |    561,344 |          0 |      6,926 |
bne.28320:
    li      0, $i6                      # |    561,344 |    561,344 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    561,344 |    561,344 |        852 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    561,344 |    561,344 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |    561,344 |    561,344 |          0 |      1,232 |
be.28321:
    load    [$i9 + 5], $i1              # |    557,606 |    557,606 |          0 |          0 |
    be      $i1, -1, be.28328           # |    557,606 |    557,606 |          0 |     85,499 |
bne.28322:
    li      0, $i6                      # |      6,832 |      6,832 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,832 |      6,832 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |      6,832 |      6,832 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |      6,832 |      6,832 |          0 |         46 |
be.28323:
    load    [$i9 + 6], $i1              # |      5,746 |      5,746 |          0 |          0 |
    be      $i1, -1, be.28328           # |      5,746 |      5,746 |          0 |          0 |
bne.28324:
    li      0, $i6                      # |      5,746 |      5,746 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      5,746 |      5,746 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |      5,746 |      5,746 |          0 |          0 |
    bne     $i1, 0, bne.28315           # |      5,746 |      5,746 |          0 |          2 |
be.28325:
    load    [$i9 + 7], $i1
    be      $i1, -1, be.28328
bne.28326:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.28315
be.28327:
    li      8, $i8
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.28328
bne.28315:
    li      1, $i1                      # |    120,041 |    120,041 |          0 |          0 |
    jr      $ra3                        # |    120,041 |    120,041 |          0 |          0 |
be.28328:
    add     $i10, 1, $i10               # |  1,105,496 |  1,105,496 |          0 |          0 |
    b       shadow_check_one_or_matrix.2868# |  1,105,496 |  1,105,496 |          0 |    130,853 |
be.28274:
    li      0, $i1                      # |    550,774 |    550,774 |          0 |          0 |
    jr      $ra3                        # |    550,774 |    550,774 |          0 |          0 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i6, $i3, $f11, $f12, $f13)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i8]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra]
######################################################################
.align 2
.begin solve_each_element
solve_each_element.2871:
    load    [$i3 + $i6], $i7            # |    193,311 |    193,311 |        269 |          0 |
    be      $i7, -1, be.28365           # |    193,311 |    193,311 |          0 |      1,956 |
bne.28329:
    load    [ext_objects + $i7], $i1    # |    149,820 |    149,820 |         71 |          0 |
    mov     $fig0, $f1                  # |    149,820 |    149,820 |          0 |          0 |
    mov     $fig1, $f2                  # |    149,820 |    149,820 |          0 |          0 |
    load    [$i1 + 1], $i2              # |    149,820 |    149,820 |        365 |          0 |
    load    [$i1 + 7], $f3              # |    149,820 |    149,820 |      4,017 |          0 |
    fsub    $f1, $f3, $f1               # |    149,820 |    149,820 |          0 |          0 |
    load    [$i1 + 8], $f4              # |    149,820 |    149,820 |          1 |          0 |
    fsub    $f2, $f4, $f2               # |    149,820 |    149,820 |          0 |          0 |
    load    [$i1 + 9], $f5              # |    149,820 |    149,820 |        917 |          0 |
    mov     $fig2, $f3                  # |    149,820 |    149,820 |          0 |          0 |
    fsub    $f3, $f5, $f3               # |    149,820 |    149,820 |          0 |          0 |
    bne     $i2, 1, bne.28330           # |    149,820 |    149,820 |          0 |     22,804 |
be.28330:
    be      $f11, $f0, ble.28337        # |     50,858 |     50,858 |          0 |         97 |
bne.28331:
    load    [$i1 + 10], $i2             # |     50,858 |     50,858 |        505 |          0 |
    load    [$i1 + 4], $f4              # |     50,858 |     50,858 |        119 |          0 |
    ble     $f0, $f11, ble.28332        # |     50,858 |     50,858 |          0 |      1,995 |
bg.28332:
    be      $i2, 0, be.28333            # |        698 |        698 |          0 |         18 |
.count dual_jmp
    b       bne.28750
ble.28332:
    be      $i2, 0, bne.28750           # |     50,160 |     50,160 |          0 |         16 |
be.28333:
    finv    $f11, $f5                   # |        698 |        698 |          0 |          0 |
    fsub    $f4, $f1, $f4               # |        698 |        698 |          0 |          0 |
    load    [$i1 + 5], $f6              # |        698 |        698 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |        698 |        698 |          0 |          0 |
    fmul    $f4, $f12, $f5              # |        698 |        698 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |        698 |        698 |          0 |          0 |
    ble     $f6, $f5, ble.28337         # |        698 |        698 |          0 |        209 |
.count dual_jmp
    b       bg.28336                    # |        171 |        171 |          0 |          8 |
bne.28750:
    fneg    $f4, $f4                    # |     50,160 |     50,160 |          0 |          0 |
    finv    $f11, $f5                   # |     50,160 |     50,160 |          0 |          0 |
    load    [$i1 + 5], $f6              # |     50,160 |     50,160 |          0 |          0 |
    fsub    $f4, $f1, $f4               # |     50,160 |     50,160 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     50,160 |     50,160 |          0 |          0 |
    fmul    $f4, $f12, $f5              # |     50,160 |     50,160 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |     50,160 |     50,160 |          0 |          0 |
    ble     $f6, $f5, ble.28337         # |     50,160 |     50,160 |          0 |      6,334 |
bg.28336:
    fmul    $f4, $f13, $f5              # |      9,810 |      9,810 |          0 |          0 |
    load    [$i1 + 6], $f6              # |      9,810 |      9,810 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      9,810 |      9,810 |          0 |          0 |
    ble     $f6, $f5, ble.28337         # |      9,810 |      9,810 |          0 |      1,597 |
bg.28337:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |          0 |          0 |
    li      1, $i8                      # |      4,111 |      4,111 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |      4,111 |      4,111 |          0 |         12 |
.count dual_jmp
    b       bg.28366                    # |      4,020 |      4,020 |          0 |          0 |
ble.28337:
    be      $f12, $f0, ble.28345        # |     46,747 |     46,747 |          0 |      1,566 |
bne.28339:
    load    [$i1 + 10], $i2             # |     46,747 |     46,747 |          0 |          0 |
    load    [$i1 + 5], $f4              # |     46,747 |     46,747 |          0 |          0 |
    ble     $f0, $f12, ble.28340        # |     46,747 |     46,747 |          0 |      2,106 |
bg.28340:
    be      $i2, 0, be.28341            # |     46,530 |     46,530 |          0 |          9 |
.count dual_jmp
    b       bne.28753
ble.28340:
    be      $i2, 0, bne.28753           # |        217 |        217 |          0 |          2 |
be.28341:
    finv    $f12, $f5                   # |     46,530 |     46,530 |          0 |          0 |
    load    [$i1 + 6], $f6              # |     46,530 |     46,530 |          0 |          0 |
    fsub    $f4, $f2, $f4               # |     46,530 |     46,530 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     46,530 |     46,530 |          0 |          0 |
    fmul    $f4, $f13, $f5              # |     46,530 |     46,530 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |     46,530 |     46,530 |          0 |          0 |
    ble     $f6, $f5, ble.28345         # |     46,530 |     46,530 |          0 |     15,754 |
.count dual_jmp
    b       bg.28344                    # |     18,436 |     18,436 |          0 |          6 |
bne.28753:
    fneg    $f4, $f4                    # |        217 |        217 |          0 |          0 |
    load    [$i1 + 6], $f6              # |        217 |        217 |          0 |          0 |
    finv    $f12, $f5                   # |        217 |        217 |          0 |          0 |
    fsub    $f4, $f2, $f4               # |        217 |        217 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |        217 |        217 |          0 |          0 |
    fmul    $f4, $f13, $f5              # |        217 |        217 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |        217 |        217 |          0 |          0 |
    ble     $f6, $f5, ble.28345         # |        217 |        217 |          0 |         70 |
bg.28344:
    fmul    $f4, $f11, $f5              # |     18,536 |     18,536 |          0 |          0 |
    load    [$i1 + 4], $f6              # |     18,536 |     18,536 |          0 |          0 |
    fadd_a  $f5, $f1, $f5               # |     18,536 |     18,536 |          0 |          0 |
    ble     $f6, $f5, ble.28345         # |     18,536 |     18,536 |          0 |      2,003 |
bg.28345:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |          0 |          0 |
    li      2, $i8                      # |     12,080 |     12,080 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |     12,080 |     12,080 |          0 |         91 |
.count dual_jmp
    b       bg.28366                    # |     11,912 |     11,912 |          0 |          2 |
ble.28345:
    be      $f13, $f0, ble.28362        # |     34,667 |     34,667 |          0 |         33 |
bne.28347:
    load    [$i1 + 10], $i2             # |     34,667 |     34,667 |          0 |          0 |
    load    [$i1 + 6], $f4              # |     34,667 |     34,667 |          0 |          0 |
    ble     $f0, $f13, ble.28348        # |     34,667 |     34,667 |          0 |      5,491 |
bg.28348:
    be      $i2, 0, be.28349            # |      9,984 |      9,984 |          0 |        227 |
.count dual_jmp
    b       bne.28759
ble.28348:
    be      $i2, 0, bne.28759           # |     24,683 |     24,683 |          0 |         23 |
be.28349:
    finv    $f13, $f5                   # |      9,984 |      9,984 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |      9,984 |      9,984 |          0 |          0 |
    load    [$i1 + 4], $f4              # |      9,984 |      9,984 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |      9,984 |      9,984 |          0 |          0 |
    fmul    $f3, $f11, $f5              # |      9,984 |      9,984 |          0 |          0 |
    fadd_a  $f5, $f1, $f1               # |      9,984 |      9,984 |          0 |          0 |
    ble     $f4, $f1, ble.28362         # |      9,984 |      9,984 |          0 |      1,422 |
.count dual_jmp
    b       bg.28352                    # |      6,406 |      6,406 |          0 |          7 |
bne.28759:
    fneg    $f4, $f4                    # |     24,683 |     24,683 |          0 |          0 |
    finv    $f13, $f5                   # |     24,683 |     24,683 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |     24,683 |     24,683 |          0 |          0 |
    load    [$i1 + 4], $f4              # |     24,683 |     24,683 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |     24,683 |     24,683 |          0 |          0 |
    fmul    $f3, $f11, $f5              # |     24,683 |     24,683 |          0 |          0 |
    fadd_a  $f5, $f1, $f1               # |     24,683 |     24,683 |          0 |          0 |
    ble     $f4, $f1, ble.28362         # |     24,683 |     24,683 |          0 |      3,510 |
bg.28352:
    fmul    $f3, $f12, $f1              # |     15,869 |     15,869 |          0 |          0 |
    load    [$i1 + 5], $f4              # |     15,869 |     15,869 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |     15,869 |     15,869 |          0 |          0 |
    ble     $f4, $f1, ble.28362         # |     15,869 |     15,869 |          0 |      1,543 |
bg.28353:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |          0 |          0 |
    li      3, $i8                      # |      3,025 |      3,025 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |      3,025 |      3,025 |          0 |         31 |
.count dual_jmp
    b       bg.28366                    # |      2,987 |      2,987 |          0 |          2 |
bne.28330:
    bne     $i2, 2, bne.28355           # |     98,962 |     98,962 |          0 |        591 |
be.28355:
    load    [$i1 + 4], $f4              # |     24,693 |     24,693 |        437 |          0 |
    fmul    $f11, $f4, $f7              # |     24,693 |     24,693 |          0 |          0 |
    load    [$i1 + 5], $f5              # |     24,693 |     24,693 |          0 |          0 |
    fmul    $f12, $f5, $f8              # |     24,693 |     24,693 |          0 |          0 |
    load    [$i1 + 6], $f6              # |     24,693 |     24,693 |          0 |          0 |
    fmul    $f13, $f6, $f9              # |     24,693 |     24,693 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |     24,693 |     24,693 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |     24,693 |     24,693 |          0 |          0 |
    ble     $f7, $f0, ble.28362         # |     24,693 |     24,693 |          0 |        832 |
bg.28356:
    fmul    $f4, $f1, $f1               # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |     17,158 |     17,158 |          0 |          0 |
    li      1, $i8                      # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |     17,158 |     17,158 |          0 |          0 |
    finv    $f7, $f4                    # |     17,158 |     17,158 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f1, $f4, $fg0              # |     17,158 |     17,158 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |     17,158 |     17,158 |          0 |         18 |
.count dual_jmp
    b       bg.28366                    # |     17,133 |     17,133 |          0 |          6 |
bne.28355:
    fmul    $f11, $f11, $f4             # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 4], $f5              # |     74,269 |     74,269 |      2,398 |          0 |
    fmul    $f12, $f12, $f6             # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 5], $f7              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f13, $f13, $f8             # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 6], $f9              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f7, $f6               # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 3], $i4              # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f4, $f6, $f4               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f8, $f9, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f4, $f6, $f4               # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.28357            # |     74,269 |     74,269 |          0 |         76 |
bne.28357:
    fmul    $f12, $f13, $f6
    load    [$i1 + 16], $f8
    fmul    $f13, $f11, $f10
    load    [$i1 + 17], $f14
    fmul    $f6, $f8, $f6
    fmul    $f11, $f12, $f8
    fmul    $f10, $f14, $f10
    fadd    $f4, $f6, $f4
    load    [$i1 + 18], $f6
    fadd    $f4, $f10, $f4
    fmul    $f8, $f6, $f6
    fadd    $f4, $f6, $f4
    be      $f4, $f0, ble.28362
.count dual_jmp
    b       bne.28358
be.28357:
    be      $f4, $f0, ble.28362         # |     74,269 |     74,269 |          0 |      3,986 |
bne.28358:
    fmul    $f11, $f1, $f6              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f12, $f2, $f8              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f13, $f3, $f10             # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f5, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f8, $f7, $f8               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f10, $f9, $f10             # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f6, $f10, $f6              # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.28359            # |     74,269 |     74,269 |          0 |      2,170 |
bne.28359:
    fmul    $f13, $f2, $f8
    load    [$i1 + 16], $f14
    fmul    $f12, $f3, $f10
    fmul    $f11, $f3, $f15
    fmul    $f13, $f1, $f16
    fadd    $f8, $f10, $f8
    load    [$i1 + 17], $f10
    fadd    $f15, $f16, $f15
    fmul    $f8, $f14, $f8
    fmul    $f11, $f2, $f14
    fmul    $f12, $f1, $f16
    fmul    $f15, $f10, $f10
    load    [$i1 + 18], $f15
    fadd    $f14, $f16, $f14
    fadd    $f8, $f10, $f8
    fmul    $f14, $f15, $f10
    fmul    $f3, $f3, $f14
    fadd    $f8, $f10, $f8
    fmul    $f2, $f2, $f10
    fmul    $f8, $fc2, $f8
    fmul    $f10, $f7, $f7
    fadd    $f6, $f8, $f6
    fmul    $f1, $f1, $f8
    fmul    $f8, $f5, $f5
    fmul    $f14, $f9, $f8
    fadd    $f5, $f7, $f5
    fadd    $f5, $f8, $f5
    be      $i4, 0, be.28360
.count dual_jmp
    b       bne.28360
be.28359:
    fmul    $f1, $f1, $f8               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f2, $f2, $f10              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f3, $f3, $f14              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f8, $f5, $f5               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f10, $f7, $f7              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f14, $f9, $f8              # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f5, $f7, $f5               # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f5, $f8, $f5               # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.28360            # |     74,269 |     74,269 |          0 |         56 |
bne.28360:
    fmul    $f2, $f3, $f7
    load    [$i1 + 16], $f8
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f9
    fmul    $f7, $f8, $f7
    fmul    $f1, $f2, $f1
    fmul    $f3, $f9, $f2
    fadd    $f5, $f7, $f3
    load    [$i1 + 18], $f5
    fadd    $f3, $f2, $f2
    fmul    $f1, $f5, $f1
    fadd    $f2, $f1, $f1
    be      $i2, 3, be.28361
.count dual_jmp
    b       bne.28361
be.28360:
    mov     $f5, $f1                    # |     74,269 |     74,269 |          0 |          0 |
    be      $i2, 3, be.28361            # |     74,269 |     74,269 |          0 |          8 |
bne.28361:
    fmul    $f6, $f6, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, ble.28362
.count dual_jmp
    b       bg.28362
be.28361:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f6, $f2               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |     74,269 |     74,269 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |     74,269 |     74,269 |          0 |          0 |
    bg      $f1, $f0, bg.28362          # |     74,269 |     74,269 |          0 |     17,344 |
ble.28362:
    load    [ext_objects + $i7], $i1    # |    101,553 |    101,553 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    101,553 |    101,553 |        227 |          0 |
    bne     $i1, 0, bne.28762           # |    101,553 |    101,553 |          0 |      5,605 |
be.28365:
    jr      $ra1                        # |    135,672 |    135,672 |          0 |          0 |
bg.28362:
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |          0 |          0 |
    load    [$i1 + 10], $i1             # |     11,893 |     11,893 |          0 |          0 |
    li      1, $i8                      # |     11,893 |     11,893 |          0 |          0 |
    finv    $f4, $f2                    # |     11,893 |     11,893 |          0 |          0 |
    be      $i1, 0, be.28363            # |     11,893 |     11,893 |          0 |      2,656 |
bne.28363:
    fsub    $f1, $f6, $f1               # |      2,755 |      2,755 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |      2,755 |      2,755 |          0 |         79 |
.count dual_jmp
    b       bg.28366                    # |      2,723 |      2,723 |          0 |          2 |
be.28363:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |          0 |          0 |
    fsub    $f1, $f6, $f1               # |      9,138 |      9,138 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |          0 |          0 |
    ble     $fg0, $f0, bne.28762        # |      9,138 |      9,138 |          0 |        576 |
bg.28366:
    ble     $fg11, $fg0, bne.28762      # |     47,420 |     47,420 |          0 |      4,245 |
bg.28367:
.count load_float
    load    [f.27979], $f1              # |     35,741 |     35,741 |        319 |          0 |
    fadd    $fg0, $f1, $f14             # |     35,741 |     35,741 |          0 |          0 |
    mov     $fig0, $f2                  # |     35,741 |     35,741 |          0 |          0 |
    fmul    $f11, $f14, $f4             # |     35,741 |     35,741 |          0 |          0 |
    mov     $fig1, $f3                  # |     35,741 |     35,741 |          0 |          0 |
    fmul    $f12, $f14, $f5             # |     35,741 |     35,741 |          0 |          0 |
    mov     $fig2, $f1                  # |     35,741 |     35,741 |          0 |          0 |
    fmul    $f13, $f14, $f6             # |     35,741 |     35,741 |          0 |          0 |
    load    [$i3 + 0], $i1              # |     35,741 |     35,741 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |     35,741 |     35,741 |          0 |          0 |
    fadd    $f5, $f3, $f3               # |     35,741 |     35,741 |          0 |          0 |
    fadd    $f6, $f1, $f4               # |     35,741 |     35,741 |          0 |          0 |
    be      $i1, -1, bne.28387          # |     35,741 |     35,741 |          0 |        428 |
bne.28368:
    load    [ext_objects + $i1], $i1    # |     35,741 |     35,741 |          0 |          0 |
    load    [$i1 + 7], $f1              # |     35,741 |     35,741 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |     35,741 |     35,741 |          0 |          0 |
    load    [$i1 + 8], $f5              # |     35,741 |     35,741 |          0 |          0 |
    fsub    $f3, $f5, $f5               # |     35,741 |     35,741 |          0 |          0 |
    load    [$i1 + 9], $f6              # |     35,741 |     35,741 |          0 |          0 |
    fsub    $f4, $f6, $f6               # |     35,741 |     35,741 |          0 |          0 |
    load    [$i1 + 1], $i2              # |     35,741 |     35,741 |          0 |          0 |
    bne     $i2, 1, bne.28369           # |     35,741 |     35,741 |          0 |      1,016 |
be.28369:
    load    [$i1 + 4], $f7              # |     21,524 |     21,524 |          0 |          0 |
    fabs    $f1, $f1                    # |     21,524 |     21,524 |          0 |          0 |
    ble     $f7, $f1, ble.28371         # |     21,524 |     21,524 |          0 |        821 |
bg.28370:
    load    [$i1 + 5], $f1              # |     18,017 |     18,017 |          0 |          0 |
    fabs    $f5, $f5                    # |     18,017 |     18,017 |          0 |          0 |
    ble     $f1, $f5, ble.28371         # |     18,017 |     18,017 |          0 |        807 |
bg.28371:
    load    [$i1 + 6], $f1              # |     17,587 |     17,587 |          0 |          0 |
    fabs    $f6, $f5                    # |     17,587 |     17,587 |          0 |          0 |
    load    [$i1 + 10], $i1             # |     17,587 |     17,587 |          0 |          0 |
    ble     $f1, $f5, ble.28382         # |     17,587 |     17,587 |          0 |         89 |
.count dual_jmp
    b       bg.28382                    # |     17,342 |     17,342 |          0 |          4 |
ble.28371:
    load    [$i1 + 10], $i1             # |      3,937 |      3,937 |          0 |          0 |
    be      $i1, 0, bne.28762           # |      3,937 |      3,937 |          0 |         10 |
.count dual_jmp
    b       be.28383
bne.28369:
    bne     $i2, 2, bne.28375           # |     14,217 |     14,217 |          0 |        860 |
be.28375:
    load    [$i1 + 4], $f7              # |     13,327 |     13,327 |          0 |          0 |
    load    [$i1 + 5], $f8              # |     13,327 |     13,327 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |     13,327 |     13,327 |          0 |          0 |
    load    [$i1 + 6], $f9              # |     13,327 |     13,327 |          0 |          0 |
    fmul    $f8, $f5, $f5               # |     13,327 |     13,327 |          0 |          0 |
    fmul    $f9, $f6, $f6               # |     13,327 |     13,327 |          0 |          0 |
    load    [$i1 + 10], $i1             # |     13,327 |     13,327 |         55 |          0 |
    fadd    $f1, $f5, $f1               # |     13,327 |     13,327 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |     13,327 |     13,327 |          0 |          0 |
    ble     $f0, $f1, ble.28382         # |     13,327 |     13,327 |          0 |          0 |
.count dual_jmp
    b       bg.28382
bne.28375:
    fmul    $f1, $f1, $f7               # |        890 |        890 |          0 |          0 |
    load    [$i1 + 4], $f8              # |        890 |        890 |          0 |          0 |
    fmul    $f5, $f5, $f9               # |        890 |        890 |          0 |          0 |
    load    [$i1 + 5], $f10             # |        890 |        890 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |        890 |        890 |          0 |          0 |
    load    [$i1 + 3], $i4              # |        890 |        890 |          0 |          0 |
    fmul    $f6, $f6, $f8               # |        890 |        890 |          0 |          0 |
    fmul    $f9, $f10, $f9              # |        890 |        890 |          0 |          0 |
    load    [$i1 + 6], $f10             # |        890 |        890 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |        890 |        890 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |        890 |        890 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |        890 |        890 |          0 |          0 |
    be      $i4, 0, be.28380            # |        890 |        890 |          0 |          2 |
bne.28380:
    fmul    $f5, $f6, $f8
    load    [$i1 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i1 + 17], $f10
    fmul    $f8, $f9, $f8
    fmul    $f1, $f5, $f1
    fmul    $f6, $f10, $f5
    fadd    $f7, $f8, $f6
    load    [$i1 + 18], $f7
    fadd    $f6, $f5, $f5
    fmul    $f1, $f7, $f1
    fadd    $f5, $f1, $f1
    be      $i2, 3, be.28381
.count dual_jmp
    b       bne.28381
be.28380:
    mov     $f7, $f1                    # |        890 |        890 |          0 |          0 |
    be      $i2, 3, be.28381            # |        890 |        890 |          0 |          2 |
bne.28381:
    load    [$i1 + 10], $i1
    ble     $f0, $f1, ble.28382
.count dual_jmp
    b       bg.28382
be.28381:
    fsub    $f1, $fc0, $f1              # |        890 |        890 |          0 |          0 |
    load    [$i1 + 10], $i1             # |        890 |        890 |          0 |          0 |
    ble     $f0, $f1, ble.28382         # |        890 |        890 |          0 |          0 |
bg.28382:
    be      $i1, 0, be.28383            # |     18,232 |     18,232 |          0 |          6 |
.count dual_jmp
    b       bne.28762
ble.28382:
    be      $i1, 0, bne.28762           # |     13,572 |     13,572 |          0 |          4 |
be.28383:
    li      1, $i1                      # |     31,559 |     31,559 |          0 |          0 |
    call    check_all_inside.2856       # |     31,559 |     31,559 |          0 |          0 |
    be      $i1, 0, bne.28762           # |     31,559 |     31,559 |          0 |          4 |
bne.28387:
    mov     $f14, $fg11                 # |     25,165 |     25,165 |          0 |          0 |
    mov     $f2, $fg1                   # |     25,165 |     25,165 |          0 |          0 |
    mov     $i7, $ig3                   # |     25,165 |     25,165 |          0 |          0 |
    mov     $f3, $fg3                   # |     25,165 |     25,165 |          0 |          0 |
    mov     $i8, $ig2                   # |     25,165 |     25,165 |          0 |          0 |
    mov     $f4, $fg2                   # |     25,165 |     25,165 |          0 |          0 |
    add     $i6, 1, $i6                 # |     25,165 |     25,165 |          0 |          0 |
    b       solve_each_element.2871     # |     25,165 |     25,165 |          0 |        949 |
bne.28762:
    add     $i6, 1, $i6                 # |     32,474 |     32,474 |          0 |          0 |
    b       solve_each_element.2871     # |     32,474 |     32,474 |          0 |      1,372 |
.end solve_each_element

######################################################################
# solve_one_or_network($i9, $i10, $f11, $f12, $f13)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i10 + $i9], $i1
    be      $i1, -1, be.28395
bne.28388:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 1, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28389:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 2, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28390:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 3, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28391:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 4, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28392:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 5, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28393:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 6, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28394:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 7, $i1
    load    [$i10 + $i1], $i1
    be      $i1, -1, be.28395
bne.28395:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i9, 8, $i9
    b       solve_one_or_network.2875
be.28395:
    jr      $ra2
.end solve_one_or_network

######################################################################
# trace_or_matrix($i11, $i12, $f11, $f12, $f13)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i12 + $i11], $i10         # |     71,262 |     71,262 |        299 |          0 |
    load    [$i10 + 0], $i1             # |     71,262 |     71,262 |         40 |          0 |
    be      $i1, -1, be.28396           # |     71,262 |     71,262 |          0 |      2,180 |
bne.28396:
    be      $i1, 99, bg.28440           # |     47,508 |     47,508 |          0 |        115 |
bne.28397:
    load    [ext_objects + $i1], $i1    # |     23,754 |     23,754 |          0 |          0 |
    mov     $fig0, $f1                  # |     23,754 |     23,754 |          0 |          0 |
    mov     $fig1, $f2                  # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 7], $f3              # |     23,754 |     23,754 |        599 |          0 |
    load    [$i1 + 8], $f4              # |     23,754 |     23,754 |          0 |          0 |
    fsub    $f1, $f3, $f1               # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 9], $f5              # |     23,754 |     23,754 |          0 |          0 |
    fsub    $f2, $f4, $f2               # |     23,754 |     23,754 |          0 |          0 |
    mov     $fig2, $f3                  # |     23,754 |     23,754 |          0 |          0 |
    fsub    $f3, $f5, $f3               # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 1], $i2              # |     23,754 |     23,754 |          0 |          0 |
    bne     $i2, 1, bne.28405           # |     23,754 |     23,754 |          0 |        375 |
be.28405:
    be      $f11, $f0, ble.28412        # |     23,754 |     23,754 |          0 |        308 |
bne.28406:
    load    [$i1 + 10], $i2             # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 4], $f4              # |     23,754 |     23,754 |          0 |          0 |
    ble     $f0, $f11, ble.28407        # |     23,754 |     23,754 |          0 |         96 |
bg.28407:
    be      $i2, 0, be.28408            # |        174 |        174 |          0 |         10 |
.count dual_jmp
    b       bne.28765
ble.28407:
    be      $i2, 0, bne.28765           # |     23,580 |     23,580 |          0 |          8 |
be.28408:
    finv    $f11, $f5                   # |        174 |        174 |          0 |          0 |
    fsub    $f4, $f1, $f4               # |        174 |        174 |          0 |          0 |
    load    [$i1 + 5], $f6              # |        174 |        174 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |        174 |        174 |          0 |          0 |
    fmul    $f4, $f12, $f5              # |        174 |        174 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |        174 |        174 |          0 |          0 |
    ble     $f6, $f5, ble.28412         # |        174 |        174 |          0 |         59 |
.count dual_jmp
    b       bg.28411                    # |        127 |        127 |          0 |          2 |
bne.28765:
    fneg    $f4, $f4                    # |     23,580 |     23,580 |          0 |          0 |
    finv    $f11, $f5                   # |     23,580 |     23,580 |          0 |          0 |
    load    [$i1 + 5], $f6              # |     23,580 |     23,580 |          0 |          0 |
    fsub    $f4, $f1, $f4               # |     23,580 |     23,580 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     23,580 |     23,580 |          0 |          0 |
    fmul    $f4, $f12, $f5              # |     23,580 |     23,580 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |     23,580 |     23,580 |          0 |          0 |
    ble     $f6, $f5, ble.28412         # |     23,580 |     23,580 |          0 |        696 |
bg.28411:
    fmul    $f4, $f13, $f5              # |      8,790 |      8,790 |          0 |          0 |
    load    [$i1 + 6], $f6              # |      8,790 |      8,790 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      8,790 |      8,790 |          0 |          0 |
    bg      $f6, $f5, bg.28412          # |      8,790 |      8,790 |          0 |        567 |
ble.28412:
    be      $f12, $f0, ble.28420        # |     20,087 |     20,087 |          0 |          0 |
bne.28414:
    load    [$i1 + 10], $i2             # |     20,087 |     20,087 |          0 |          0 |
    load    [$i1 + 5], $f4              # |     20,087 |     20,087 |          0 |          0 |
    ble     $f0, $f12, ble.28415        # |     20,087 |     20,087 |          0 |         29 |
bg.28415:
    be      $i2, 0, be.28416            # |     20,049 |     20,049 |          0 |        138 |
.count dual_jmp
    b       bne.28768
ble.28415:
    be      $i2, 0, bne.28768           # |         38 |         38 |          0 |         10 |
be.28416:
    finv    $f12, $f5                   # |     20,049 |     20,049 |          0 |          0 |
    load    [$i1 + 6], $f6              # |     20,049 |     20,049 |          0 |          0 |
    fsub    $f4, $f2, $f4               # |     20,049 |     20,049 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     20,049 |     20,049 |          0 |          0 |
    fmul    $f4, $f13, $f5              # |     20,049 |     20,049 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |     20,049 |     20,049 |          0 |          0 |
    ble     $f6, $f5, ble.28420         # |     20,049 |     20,049 |          0 |        300 |
.count dual_jmp
    b       bg.28419                    # |      3,574 |      3,574 |          0 |        311 |
bne.28768:
    fneg    $f4, $f4                    # |         38 |         38 |          0 |          0 |
    load    [$i1 + 6], $f6              # |         38 |         38 |          0 |          0 |
    finv    $f12, $f5                   # |         38 |         38 |          0 |          0 |
    fsub    $f4, $f2, $f4               # |         38 |         38 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |         38 |         38 |          0 |          0 |
    fmul    $f4, $f13, $f5              # |         38 |         38 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |         38 |         38 |          0 |          0 |
    ble     $f6, $f5, ble.28420         # |         38 |         38 |          0 |          9 |
bg.28419:
    fmul    $f4, $f11, $f5              # |      3,575 |      3,575 |          0 |          0 |
    load    [$i1 + 4], $f6              # |      3,575 |      3,575 |          0 |          0 |
    fadd_a  $f5, $f1, $f5               # |      3,575 |      3,575 |          0 |          0 |
    ble     $f6, $f5, ble.28420         # |      3,575 |      3,575 |          0 |        283 |
bg.28412:
    mov     $f4, $fg0                   # |      4,611 |      4,611 |          0 |          0 |
    ble     $fg11, $fg0, be.28447       # |      4,611 |      4,611 |          0 |         81 |
.count dual_jmp
    b       bg.28440                    # |      4,611 |      4,611 |          0 |          6 |
ble.28420:
    be      $f13, $f0, be.28447         # |     19,143 |     19,143 |          0 |      1,121 |
bne.28422:
    load    [$i1 + 10], $i2             # |     19,143 |     19,143 |          0 |          0 |
    load    [$i1 + 6], $f4              # |     19,143 |     19,143 |          0 |          0 |
    ble     $f0, $f13, ble.28423        # |     19,143 |     19,143 |          0 |        312 |
bg.28423:
    be      $i2, 0, be.28424            # |      6,714 |      6,714 |          0 |         28 |
.count dual_jmp
    b       bne.28771
ble.28423:
    be      $i2, 0, bne.28771           # |     12,429 |     12,429 |          0 |         11 |
be.28424:
    finv    $f13, $f5                   # |      6,714 |      6,714 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |      6,714 |      6,714 |          0 |          0 |
    load    [$i1 + 4], $f4              # |      6,714 |      6,714 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |      6,714 |      6,714 |          0 |          0 |
    fmul    $f3, $f11, $f5              # |      6,714 |      6,714 |          0 |          0 |
    fadd_a  $f5, $f1, $f1               # |      6,714 |      6,714 |          0 |          0 |
    ble     $f4, $f1, be.28447          # |      6,714 |      6,714 |          0 |        475 |
.count dual_jmp
    b       bg.28427                    # |      1,198 |      1,198 |          0 |          6 |
bne.28771:
    fneg    $f4, $f4                    # |     12,429 |     12,429 |          0 |          0 |
    finv    $f13, $f5                   # |     12,429 |     12,429 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |     12,429 |     12,429 |          0 |          0 |
    load    [$i1 + 4], $f4              # |     12,429 |     12,429 |          0 |          0 |
    fmul    $f3, $f5, $f3               # |     12,429 |     12,429 |          0 |          0 |
    fmul    $f3, $f11, $f5              # |     12,429 |     12,429 |          0 |          0 |
    fadd_a  $f5, $f1, $f1               # |     12,429 |     12,429 |          0 |          0 |
    ble     $f4, $f1, be.28447          # |     12,429 |     12,429 |          0 |        386 |
bg.28427:
    fmul    $f3, $f12, $f1              # |      3,882 |      3,882 |          0 |          0 |
    load    [$i1 + 5], $f4              # |      3,882 |      3,882 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |      3,882 |      3,882 |          0 |          0 |
    ble     $f4, $f1, be.28447          # |      3,882 |      3,882 |          0 |         62 |
bg.28428:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |          0 |          0 |
    ble     $fg11, $fg0, be.28447       # |      2,165 |      2,165 |          0 |          4 |
.count dual_jmp
    b       bg.28440                    # |      2,165 |      2,165 |          0 |      1,040 |
bne.28405:
    bne     $i2, 2, bne.28430
be.28430:
    load    [$i1 + 4], $f4
    fmul    $f11, $f4, $f7
    load    [$i1 + 5], $f5
    fmul    $f12, $f5, $f8
    load    [$i1 + 6], $f6
    fmul    $f13, $f6, $f9
    fadd    $f7, $f8, $f7
    fadd    $f7, $f9, $f7
    ble     $f7, $f0, be.28447
bg.28431:
    fmul    $f4, $f1, $f1
    fmul    $f5, $f2, $f2
    fmul    $f6, $f3, $f3
    finv    $f7, $f4
    fadd    $f1, $f2, $f1
    fadd_n  $f1, $f3, $f1
    fmul    $f1, $f4, $fg0
    ble     $fg11, $fg0, be.28447
.count dual_jmp
    b       bg.28440
bne.28430:
    fmul    $f11, $f11, $f4
    load    [$i1 + 4], $f5
    fmul    $f12, $f12, $f6
    load    [$i1 + 5], $f7
    fmul    $f4, $f5, $f4
    load    [$i1 + 6], $f9
    fmul    $f13, $f13, $f8
    load    [$i1 + 3], $i3
    fmul    $f6, $f7, $f6
    fadd    $f4, $f6, $f4
    fmul    $f8, $f9, $f6
    fadd    $f4, $f6, $f4
    be      $i3, 0, be.28432
bne.28432:
    fmul    $f12, $f13, $f6
    load    [$i1 + 16], $f8
    fmul    $f13, $f11, $f10
    load    [$i1 + 17], $f14
    fmul    $f6, $f8, $f6
    fmul    $f11, $f12, $f8
    fmul    $f10, $f14, $f10
    fadd    $f4, $f6, $f4
    load    [$i1 + 18], $f6
    fadd    $f4, $f10, $f4
    fmul    $f8, $f6, $f6
    fadd    $f4, $f6, $f4
    be      $f4, $f0, be.28447
.count dual_jmp
    b       bne.28433
be.28432:
    be      $f4, $f0, be.28447
bne.28433:
    fmul    $f11, $f1, $f6
    fmul    $f12, $f2, $f8
    fmul    $f13, $f3, $f10
    fmul    $f6, $f5, $f6
    fmul    $f8, $f7, $f8
    fmul    $f10, $f9, $f10
    fadd    $f6, $f8, $f6
    fadd    $f6, $f10, $f6
    be      $i3, 0, be.28434
bne.28434:
    fmul    $f13, $f2, $f8
    fmul    $f12, $f3, $f10
    load    [$i1 + 16], $f14
    fmul    $f11, $f3, $f15
    fmul    $f13, $f1, $f16
    fadd    $f8, $f10, $f8
    load    [$i1 + 17], $f10
    fadd    $f15, $f16, $f15
    fmul    $f8, $f14, $f8
    fmul    $f11, $f2, $f14
    fmul    $f12, $f1, $f16
    fmul    $f15, $f10, $f10
    load    [$i1 + 18], $f15
    fadd    $f14, $f16, $f14
    fadd    $f8, $f10, $f8
    fmul    $f14, $f15, $f10
    fmul    $f3, $f3, $f14
    fadd    $f8, $f10, $f8
    fmul    $f2, $f2, $f10
    fmul    $f8, $fc2, $f8
    fmul    $f10, $f7, $f7
    fadd    $f6, $f8, $f6
    fmul    $f1, $f1, $f8
    fmul    $f8, $f5, $f5
    fmul    $f14, $f9, $f8
    fadd    $f5, $f7, $f5
    fadd    $f5, $f8, $f5
    be      $i3, 0, be.28435
.count dual_jmp
    b       bne.28435
be.28434:
    fmul    $f1, $f1, $f8
    fmul    $f2, $f2, $f10
    fmul    $f3, $f3, $f14
    fmul    $f8, $f5, $f5
    fmul    $f10, $f7, $f7
    fmul    $f14, $f9, $f8
    fadd    $f5, $f7, $f5
    fadd    $f5, $f8, $f5
    be      $i3, 0, be.28435
bne.28435:
    fmul    $f2, $f3, $f7
    load    [$i1 + 16], $f8
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f9
    fmul    $f7, $f8, $f7
    fmul    $f1, $f2, $f1
    fmul    $f3, $f9, $f2
    fadd    $f5, $f7, $f3
    load    [$i1 + 18], $f5
    fadd    $f3, $f2, $f2
    fmul    $f1, $f5, $f1
    fadd    $f2, $f1, $f1
    be      $i2, 3, be.28436
.count dual_jmp
    b       bne.28436
be.28435:
    mov     $f5, $f1
    be      $i2, 3, be.28436
bne.28436:
    fmul    $f6, $f6, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, be.28447
.count dual_jmp
    b       bg.28437
be.28436:
    fsub    $f1, $fc0, $f1
    fmul    $f6, $f6, $f2
    fmul    $f4, $f1, $f1
    fsub    $f2, $f1, $f1
    ble     $f1, $f0, be.28447
bg.28437:
    fsqrt   $f1, $f1
    load    [$i1 + 10], $i1
    finv    $f4, $f2
    be      $i1, 0, be.28438
bne.28438:
    fsub    $f1, $f6, $f1
    fmul    $f1, $f2, $fg0
    ble     $fg11, $fg0, be.28447
.count dual_jmp
    b       bg.28440
be.28438:
    fneg    $f1, $f1
    fsub    $f1, $f6, $f1
    fmul    $f1, $f2, $fg0
    ble     $fg11, $fg0, be.28447
bg.28440:
    load    [$i10 + 1], $i1             # |     30,530 |     30,530 |          0 |          0 |
    be      $i1, -1, be.28447           # |     30,530 |     30,530 |          0 |        701 |
bne.28441:
    load    [ext_and_net + $i1], $i3    # |     30,530 |     30,530 |         22 |          0 |
    li      0, $i6                      # |     30,530 |     30,530 |          0 |          0 |
    jal     solve_each_element.2871, $ra1# |     30,530 |     30,530 |          0 |          0 |
    load    [$i10 + 2], $i1             # |     30,530 |     30,530 |          0 |          0 |
    be      $i1, -1, be.28447           # |     30,530 |     30,530 |          0 |        527 |
bne.28442:
    li      0, $i6                      # |     30,530 |     30,530 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     30,530 |     30,530 |          0 |          0 |
    jal     solve_each_element.2871, $ra1# |     30,530 |     30,530 |          0 |          0 |
    load    [$i10 + 3], $i1             # |     30,530 |     30,530 |         66 |          0 |
    be      $i1, -1, be.28447           # |     30,530 |     30,530 |          0 |         89 |
bne.28443:
    li      0, $i6                      # |     30,530 |     30,530 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     30,530 |     30,530 |         10 |          0 |
    jal     solve_each_element.2871, $ra1# |     30,530 |     30,530 |          0 |          0 |
    load    [$i10 + 4], $i1             # |     30,530 |     30,530 |          0 |          0 |
    be      $i1, -1, be.28447           # |     30,530 |     30,530 |          0 |      1,031 |
bne.28444:
    li      0, $i6                      # |     30,530 |     30,530 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     30,530 |     30,530 |         22 |          0 |
    jal     solve_each_element.2871, $ra1# |     30,530 |     30,530 |          0 |          0 |
    load    [$i10 + 5], $i1             # |     30,530 |     30,530 |          0 |          0 |
    be      $i1, -1, be.28447           # |     30,530 |     30,530 |          0 |        374 |
bne.28445:
    li      0, $i6                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          0 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    load    [$i10 + 6], $i1             # |      6,776 |      6,776 |          0 |          0 |
    be      $i1, -1, be.28447           # |      6,776 |      6,776 |          0 |         56 |
bne.28446:
    li      0, $i6                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |         10 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    load    [$i10 + 7], $i1             # |      6,776 |      6,776 |         23 |          0 |
    be      $i1, -1, be.28447           # |      6,776 |      6,776 |          0 |          6 |
bne.28447:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      8, $i9
    jal     solve_one_or_network.2875, $ra2
    add     $i11, 1, $i11
    b       trace_or_matrix.2879
be.28447:
    add     $i11, 1, $i11               # |     47,508 |     47,508 |          0 |          0 |
    b       trace_or_matrix.2879        # |     47,508 |     47,508 |          0 |      1,588 |
be.28396:
    jr      $ra3                        # |     23,754 |     23,754 |          0 |          0 |
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i6, $i3, $f11, $f12, $f13, $i7)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i6, $i8 - $i9]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra]
######################################################################
.align 2
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i3 + $i6], $i8            # | 13,848,645 | 13,848,645 |    106,703 |          0 |
    be      $i8, -1, be.28468           # | 13,848,645 | 13,848,645 |          0 |    689,627 |
bne.28448:
    load    [ext_objects + $i8], $i1    # | 10,541,106 | 10,541,106 |     55,533 |          0 |
    load    [$i7 + $i8], $i2            # | 10,541,106 | 10,541,106 |  2,001,496 |          0 |
    load    [$i1 + 1], $i4              # | 10,541,106 | 10,541,106 |    347,381 |          0 |
    load    [$i1 + 19], $f1             # | 10,541,106 | 10,541,106 |    166,682 |          0 |
    load    [$i1 + 20], $f2             # | 10,541,106 | 10,541,106 |     31,370 |          0 |
    load    [$i1 + 21], $f3             # | 10,541,106 | 10,541,106 |     47,304 |          0 |
    bne     $i4, 1, bne.28449           # | 10,541,106 | 10,541,106 |          0 |  2,346,646 |
be.28449:
    load    [$i2 + 0], $f4              # |  3,872,708 |  3,872,708 |  3,405,998 |          0 |
    load    [$i2 + 1], $f5              # |  3,872,708 |  3,872,708 |    860,534 |          0 |
    fsub    $f4, $f1, $f4               # |  3,872,708 |  3,872,708 |          0 |          0 |
    load    [$i1 + 5], $f6              # |  3,872,708 |  3,872,708 |     47,787 |          0 |
    fmul    $f4, $f5, $f4               # |  3,872,708 |  3,872,708 |          0 |          0 |
    fmul    $f4, $f12, $f7              # |  3,872,708 |  3,872,708 |          0 |          0 |
    fadd_a  $f7, $f2, $f7               # |  3,872,708 |  3,872,708 |          0 |          0 |
    ble     $f6, $f7, be.28452          # |  3,872,708 |  3,872,708 |          0 |    936,559 |
bg.28450:
    fmul    $f4, $f13, $f6              # |    827,737 |    827,737 |          0 |          0 |
    load    [$i1 + 6], $f7              # |    827,737 |    827,737 |      2,360 |          0 |
    fadd_a  $f6, $f3, $f6               # |    827,737 |    827,737 |          0 |          0 |
    ble     $f7, $f6, be.28452          # |    827,737 |    827,737 |          0 |    207,525 |
bg.28451:
    be      $f5, $f0, be.28452          # |    503,236 |    503,236 |          0 |        460 |
bne.28452:
    mov     $f4, $fg0                   # |    503,236 |    503,236 |          0 |          0 |
    li      1, $i9                      # |    503,236 |    503,236 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |    503,236 |    503,236 |          0 |     39,299 |
.count dual_jmp
    b       bg.28469                    # |     77,907 |     77,907 |          0 |          4 |
be.28452:
    load    [$i2 + 2], $f4              # |  3,369,472 |  3,369,472 |    983,376 |          0 |
    fsub    $f4, $f2, $f4               # |  3,369,472 |  3,369,472 |          0 |          0 |
    load    [$i2 + 3], $f5              # |  3,369,472 |  3,369,472 |    369,975 |          0 |
    fmul    $f4, $f5, $f4               # |  3,369,472 |  3,369,472 |          0 |          0 |
    load    [$i1 + 4], $f6              # |  3,369,472 |  3,369,472 |        307 |          0 |
    fmul    $f4, $f11, $f7              # |  3,369,472 |  3,369,472 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |  3,369,472 |  3,369,472 |          0 |          0 |
    ble     $f6, $f7, be.28456          # |  3,369,472 |  3,369,472 |          0 |    868,721 |
bg.28454:
    fmul    $f4, $f13, $f6              # |  1,792,877 |  1,792,877 |          0 |          0 |
    load    [$i1 + 6], $f7              # |  1,792,877 |  1,792,877 |     15,240 |          0 |
    fadd_a  $f6, $f3, $f6               # |  1,792,877 |  1,792,877 |          0 |          0 |
    ble     $f7, $f6, be.28456          # |  1,792,877 |  1,792,877 |          0 |    387,482 |
bg.28455:
    be      $f5, $f0, be.28456          # |  1,222,409 |  1,222,409 |          0 |          0 |
bne.28456:
    mov     $f4, $fg0                   # |  1,222,409 |  1,222,409 |          0 |          0 |
    li      2, $i9                      # |  1,222,409 |  1,222,409 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |  1,222,409 |  1,222,409 |          0 |    173,982 |
.count dual_jmp
    b       bg.28469                    # |    207,182 |    207,182 |          0 |          2 |
be.28456:
    load    [$i2 + 4], $f4              # |  2,147,063 |  2,147,063 |    209,415 |          0 |
    load    [$i2 + 5], $f5              # |  2,147,063 |  2,147,063 |    167,839 |          0 |
    fsub    $f4, $f3, $f3               # |  2,147,063 |  2,147,063 |          0 |          0 |
    load    [$i1 + 4], $f6              # |  2,147,063 |  2,147,063 |         36 |          0 |
    fmul    $f3, $f5, $f3               # |  2,147,063 |  2,147,063 |          0 |          0 |
    fmul    $f3, $f11, $f4              # |  2,147,063 |  2,147,063 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |  2,147,063 |  2,147,063 |          0 |          0 |
    ble     $f6, $f1, ble.28465         # |  2,147,063 |  2,147,063 |          0 |    567,415 |
bg.28458:
    fmul    $f3, $f12, $f1              # |    606,348 |    606,348 |          0 |          0 |
    load    [$i1 + 5], $f4              # |    606,348 |    606,348 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |    606,348 |    606,348 |          0 |          0 |
    ble     $f4, $f1, ble.28465         # |    606,348 |    606,348 |          0 |    125,037 |
bg.28459:
    be      $f5, $f0, ble.28465         # |    274,499 |    274,499 |          0 |     51,805 |
bne.28460:
    mov     $f3, $fg0                   # |    274,499 |    274,499 |          0 |          0 |
    li      3, $i9                      # |    274,499 |    274,499 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |    274,499 |    274,499 |          0 |     34,412 |
.count dual_jmp
    b       bg.28469                    # |     45,674 |     45,674 |          0 |          4 |
bne.28449:
    be      $i4, 2, be.28462            # |  6,668,398 |  6,668,398 |          0 |     98,353 |
bne.28462:
    load    [$i2 + 0], $f4              # |  5,426,313 |  5,426,313 |  4,627,770 |          0 |
    be      $f4, $f0, ble.28465         # |  5,426,313 |  5,426,313 |          0 |    205,483 |
bne.28464:
    load    [$i2 + 1], $f5              # |  5,426,313 |  5,426,313 |  1,373,028 |          0 |
    load    [$i2 + 2], $f6              # |  5,426,313 |  5,426,313 |    587,309 |          0 |
    fmul    $f5, $f1, $f1               # |  5,426,313 |  5,426,313 |          0 |          0 |
    load    [$i2 + 3], $f7              # |  5,426,313 |  5,426,313 |    605,109 |          0 |
    fmul    $f6, $f2, $f2               # |  5,426,313 |  5,426,313 |          0 |          0 |
    fmul    $f7, $f3, $f3               # |  5,426,313 |  5,426,313 |          0 |          0 |
    load    [$i1 + 22], $f5             # |  5,426,313 |  5,426,313 |     13,717 |          0 |
    fadd    $f1, $f2, $f1               # |  5,426,313 |  5,426,313 |          0 |          0 |
    fmul    $f4, $f5, $f2               # |  5,426,313 |  5,426,313 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |  5,426,313 |  5,426,313 |          0 |          0 |
    fmul    $f1, $f1, $f3               # |  5,426,313 |  5,426,313 |          0 |          0 |
    fsub    $f3, $f2, $f2               # |  5,426,313 |  5,426,313 |          0 |          0 |
    ble     $f2, $f0, ble.28465         # |  5,426,313 |  5,426,313 |          0 |    642,245 |
bg.28465:
    load    [$i1 + 10], $i1             # |  1,680,653 |  1,680,653 |     32,858 |          0 |
    li      1, $i9                      # |  1,680,653 |  1,680,653 |          0 |          0 |
    load    [$i2 + 4], $f3              # |  1,680,653 |  1,680,653 |     59,246 |          0 |
    fsqrt   $f2, $f2                    # |  1,680,653 |  1,680,653 |          0 |          0 |
    be      $i1, 0, be.28466            # |  1,680,653 |  1,680,653 |          0 |    101,170 |
bne.28466:
    fadd    $f1, $f2, $f1               # |    420,668 |    420,668 |          0 |          0 |
    fmul    $f1, $f3, $fg0              # |    420,668 |    420,668 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |    420,668 |    420,668 |          0 |     84,613 |
.count dual_jmp
    b       bg.28469                    # |    268,081 |    268,081 |          0 |          4 |
be.28466:
    fsub    $f1, $f2, $f1               # |  1,259,985 |  1,259,985 |          0 |          0 |
    fmul    $f1, $f3, $fg0              # |  1,259,985 |  1,259,985 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |  1,259,985 |  1,259,985 |          0 |     53,342 |
.count dual_jmp
    b       bg.28469                    # |    245,988 |    245,988 |          0 |        642 |
be.28462:
    load    [$i2 + 0], $f1              # |  1,242,085 |  1,242,085 |  1,074,427 |          0 |
    ble     $f0, $f1, ble.28465         # |  1,242,085 |  1,242,085 |          0 |    218,691 |
bg.28463:
    load    [$i1 + 22], $f2             # |    595,113 |    595,113 |     12,016 |          0 |
    li      1, $i9                      # |    595,113 |    595,113 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |    595,113 |    595,113 |          0 |          0 |
    ble     $fg0, $f0, bne.28777        # |    595,113 |    595,113 |          0 |      3,058 |
bg.28469:
    ble     $fg11, $fg0, bne.28777      # |  1,396,462 |  1,396,462 |          0 |    203,423 |
bg.28470:
.count load_float
    load    [f.27979], $f1              # |  1,181,103 |  1,181,103 |     10,320 |          0 |
    fadd    $fg0, $f1, $f14             # |  1,181,103 |  1,181,103 |          0 |          0 |
    load    [$i3 + 0], $i1              # |  1,181,103 |  1,181,103 |         20 |          0 |
    fmul    $f11, $f14, $f1             # |  1,181,103 |  1,181,103 |          0 |          0 |
    fmul    $f12, $f14, $f2             # |  1,181,103 |  1,181,103 |          0 |          0 |
    fmul    $f13, $f14, $f3             # |  1,181,103 |  1,181,103 |          0 |          0 |
    fadd    $f1, $fg17, $f15            # |  1,181,103 |  1,181,103 |          0 |          0 |
    fadd    $f2, $fg18, $f16            # |  1,181,103 |  1,181,103 |          0 |          0 |
    fadd    $f3, $fg19, $f4             # |  1,181,103 |  1,181,103 |          0 |          0 |
    be      $i1, -1, bne.28490          # |  1,181,103 |  1,181,103 |          0 |      2,033 |
bne.28471:
    load    [ext_objects + $i1], $i1    # |  1,181,103 |  1,181,103 |        672 |          0 |
    load    [$i1 + 7], $f1              # |  1,181,103 |  1,181,103 |     10,168 |          0 |
    load    [$i1 + 8], $f2              # |  1,181,103 |  1,181,103 |          0 |          0 |
    fsub    $f15, $f1, $f1              # |  1,181,103 |  1,181,103 |          0 |          0 |
    load    [$i1 + 9], $f3              # |  1,181,103 |  1,181,103 |      2,799 |          0 |
    fsub    $f16, $f2, $f2              # |  1,181,103 |  1,181,103 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |  1,181,103 |  1,181,103 |          0 |          0 |
    load    [$i1 + 1], $i2              # |  1,181,103 |  1,181,103 |      3,658 |          0 |
    bne     $i2, 1, bne.28472           # |  1,181,103 |  1,181,103 |          0 |     37,410 |
be.28472:
    load    [$i1 + 4], $f5              # |    695,240 |    695,240 |        278 |          0 |
    fabs    $f1, $f1                    # |    695,240 |    695,240 |          0 |          0 |
    ble     $f5, $f1, ble.28474         # |    695,240 |    695,240 |          0 |    112,830 |
bg.28473:
    load    [$i1 + 5], $f1              # |    500,459 |    500,459 |          0 |          0 |
    fabs    $f2, $f2                    # |    500,459 |    500,459 |          0 |          0 |
    ble     $f1, $f2, ble.28474         # |    500,459 |    500,459 |          0 |     54,013 |
bg.28474:
    load    [$i1 + 6], $f1              # |    445,596 |    445,596 |          0 |          0 |
    fabs    $f3, $f2                    # |    445,596 |    445,596 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    445,596 |    445,596 |      2,527 |          0 |
    ble     $f1, $f2, ble.28485         # |    445,596 |    445,596 |          0 |     14,586 |
.count dual_jmp
    b       bg.28485                    # |    428,757 |    428,757 |          0 |          4 |
ble.28474:
    load    [$i1 + 10], $i1             # |    249,644 |    249,644 |      2,135 |          0 |
    be      $i1, 0, bne.28777           # |    249,644 |    249,644 |          0 |         72 |
.count dual_jmp
    b       be.28486
bne.28472:
    bne     $i2, 2, bne.28478           # |    485,863 |    485,863 |          0 |      3,107 |
be.28478:
    load    [$i1 + 4], $f5              # |    447,277 |    447,277 |      6,901 |          0 |
    fmul    $f5, $f1, $f1               # |    447,277 |    447,277 |          0 |          0 |
    load    [$i1 + 5], $f6              # |    447,277 |    447,277 |          0 |          0 |
    fmul    $f6, $f2, $f2               # |    447,277 |    447,277 |          0 |          0 |
    load    [$i1 + 6], $f7              # |    447,277 |    447,277 |          0 |          0 |
    fmul    $f7, $f3, $f3               # |    447,277 |    447,277 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    447,277 |    447,277 |      3,538 |          0 |
    fadd    $f1, $f2, $f1               # |    447,277 |    447,277 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |    447,277 |    447,277 |          0 |          0 |
    ble     $f0, $f1, ble.28485         # |    447,277 |    447,277 |          0 |          2 |
.count dual_jmp
    b       bg.28485
bne.28478:
    fmul    $f1, $f1, $f5               # |     38,586 |     38,586 |          0 |          0 |
    load    [$i1 + 4], $f6              # |     38,586 |     38,586 |      1,743 |          0 |
    fmul    $f2, $f2, $f7               # |     38,586 |     38,586 |          0 |          0 |
    load    [$i1 + 5], $f8              # |     38,586 |     38,586 |          0 |          0 |
    fmul    $f5, $f6, $f5               # |     38,586 |     38,586 |          0 |          0 |
    fmul    $f3, $f3, $f6               # |     38,586 |     38,586 |          0 |          0 |
    load    [$i1 + 3], $i4              # |     38,586 |     38,586 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |     38,586 |     38,586 |          0 |          0 |
    load    [$i1 + 6], $f8              # |     38,586 |     38,586 |          0 |          0 |
    fadd    $f5, $f7, $f5               # |     38,586 |     38,586 |          0 |          0 |
    fmul    $f6, $f8, $f6               # |     38,586 |     38,586 |          0 |          0 |
    fadd    $f5, $f6, $f5               # |     38,586 |     38,586 |          0 |          0 |
    be      $i4, 0, be.28483            # |     38,586 |     38,586 |          0 |          2 |
bne.28483:
    fmul    $f2, $f3, $f6
    load    [$i1 + 16], $f7
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f8
    fmul    $f6, $f7, $f6
    fmul    $f1, $f2, $f1
    fmul    $f3, $f8, $f2
    fadd    $f5, $f6, $f3
    load    [$i1 + 18], $f5
    fadd    $f3, $f2, $f2
    fmul    $f1, $f5, $f1
    fadd    $f2, $f1, $f1
    be      $i2, 3, be.28484
.count dual_jmp
    b       bne.28484
be.28483:
    mov     $f5, $f1                    # |     38,586 |     38,586 |          0 |          0 |
    be      $i2, 3, be.28484            # |     38,586 |     38,586 |          0 |          2 |
bne.28484:
    load    [$i1 + 10], $i1
    ble     $f0, $f1, ble.28485
.count dual_jmp
    b       bg.28485
be.28484:
    fsub    $f1, $fc0, $f1              # |     38,586 |     38,586 |          0 |          0 |
    load    [$i1 + 10], $i1             # |     38,586 |     38,586 |          0 |          0 |
    ble     $f0, $f1, ble.28485         # |     38,586 |     38,586 |          0 |          0 |
bg.28485:
    be      $i1, 0, be.28486            # |    467,343 |    467,343 |          0 |         20 |
.count dual_jmp
    b       bne.28777
ble.28485:
    be      $i1, 0, bne.28777           # |    464,116 |    464,116 |          0 |          2 |
be.28486:
    li      1, $i1                      # |    914,620 |    914,620 |          0 |          0 |
.count move_args
    mov     $f15, $f2                   # |    914,620 |    914,620 |          0 |          0 |
.count move_args
    mov     $f16, $f3                   # |    914,620 |    914,620 |          0 |          0 |
    call    check_all_inside.2856       # |    914,620 |    914,620 |          0 |          0 |
    be      $i1, 0, bne.28777           # |    914,620 |    914,620 |          0 |         18 |
bne.28490:
    mov     $f14, $fg11                 # |    756,158 |    756,158 |          0 |          0 |
    mov     $i8, $ig3                   # |    756,158 |    756,158 |          0 |          0 |
    mov     $f15, $fg1                  # |    756,158 |    756,158 |          0 |          0 |
    mov     $i9, $ig2                   # |    756,158 |    756,158 |          0 |          0 |
    mov     $f16, $fg3                  # |    756,158 |    756,158 |          0 |          0 |
    add     $i6, 1, $i6                 # |    756,158 |    756,158 |          0 |          0 |
    mov     $f4, $fg2                   # |    756,158 |    756,158 |          0 |          0 |
    b       solve_each_element_fast.2885# |    756,158 |    756,158 |          0 |     19,939 |
ble.28465:
    load    [ext_objects + $i8], $i1    # |  6,265,196 |  6,265,196 |      8,140 |          0 |
    load    [$i1 + 10], $i1             # |  6,265,196 |  6,265,196 |     75,505 |          0 |
    be      $i1, 0, be.28468            # |  6,265,196 |  6,265,196 |          0 |     68,447 |
bne.28777:
    add     $i6, 1, $i6                 # |  4,447,485 |  4,447,485 |          0 |          0 |
    b       solve_each_element_fast.2885# |  4,447,485 |  4,447,485 |          0 |     28,630 |
be.28468:
    jr      $ra1                        # |  8,645,002 |  8,645,002 |          0 |          0 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i10, $i11, $f11, $f12, $f13, $i7)
# $ra = $ra2
# [$i1 - $i6, $i8 - $i10]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i11 + $i10], $i1
    be      $i1, -1, be.28498
bne.28491:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 1, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28492:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 2, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28493:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 3, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28494:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 4, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28495:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 5, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28496:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 6, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28497:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 7, $i1
    load    [$i11 + $i1], $i1
    be      $i1, -1, be.28498
bne.28498:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i10, 8, $i10
    b       solve_one_or_network_fast.2889
be.28498:
    jr      $ra2
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i12, $i13, $f11, $f12, $f13, $i7)
# $ra = $ra3
# [$i1 - $i6, $i8 - $i12]
# [$f1 - $f10, $f14 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg11]
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i13 + $i12], $i11         # |  3,403,128 |  3,403,128 |     10,085 |          0 |
    load    [$i11 + 0], $i1             # |  3,403,128 |  3,403,128 |      3,340 |          0 |
    be      $i1, -1, be.28499           # |  3,403,128 |  3,403,128 |          0 |    168,023 |
bne.28499:
    be      $i1, 99, bg.28527           # |  2,268,752 |  2,268,752 |          0 |     56,590 |
bne.28500:
    load    [ext_objects + $i1], $i2    # |  1,134,376 |  1,134,376 |      3,067 |          0 |
    load    [$i7 + $i1], $i1            # |  1,134,376 |  1,134,376 |    993,907 |          0 |
    load    [$i2 + 19], $f1             # |  1,134,376 |  1,134,376 |     15,108 |          0 |
    load    [$i2 + 20], $f2             # |  1,134,376 |  1,134,376 |          0 |          0 |
    load    [$i2 + 21], $f3             # |  1,134,376 |  1,134,376 |          0 |          0 |
    load    [$i2 + 1], $i3              # |  1,134,376 |  1,134,376 |      4,889 |          0 |
    bne     $i3, 1, bne.28508           # |  1,134,376 |  1,134,376 |          0 |    121,563 |
be.28508:
    load    [$i1 + 0], $f4              # |  1,134,376 |  1,134,376 |  1,090,373 |          0 |
    load    [$i1 + 1], $f5              # |  1,134,376 |  1,134,376 |    376,657 |          0 |
    fsub    $f4, $f1, $f4               # |  1,134,376 |  1,134,376 |          0 |          0 |
    load    [$i2 + 5], $f6              # |  1,134,376 |  1,134,376 |      5,778 |          0 |
    fmul    $f4, $f5, $f4               # |  1,134,376 |  1,134,376 |          0 |          0 |
    fmul    $f4, $f12, $f7              # |  1,134,376 |  1,134,376 |          0 |          0 |
    fadd_a  $f7, $f2, $f7               # |  1,134,376 |  1,134,376 |          0 |          0 |
    ble     $f6, $f7, be.28511          # |  1,134,376 |  1,134,376 |          0 |    338,886 |
bg.28509:
    fmul    $f4, $f13, $f6              # |    494,230 |    494,230 |          0 |          0 |
    load    [$i2 + 6], $f7              # |    494,230 |    494,230 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    494,230 |    494,230 |          0 |          0 |
    ble     $f7, $f6, be.28511          # |    494,230 |    494,230 |          0 |    117,405 |
bg.28510:
    bne     $f5, $f0, bne.28511         # |    329,840 |    329,840 |          0 |         69 |
be.28511:
    load    [$i1 + 2], $f4              # |    804,536 |    804,536 |     78,905 |          0 |
    fsub    $f4, $f2, $f4               # |    804,536 |    804,536 |          0 |          0 |
    load    [$i1 + 3], $f5              # |    804,536 |    804,536 |    150,349 |          0 |
    fmul    $f4, $f5, $f4               # |    804,536 |    804,536 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    804,536 |    804,536 |          0 |          0 |
    fmul    $f4, $f11, $f7              # |    804,536 |    804,536 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |    804,536 |    804,536 |          0 |          0 |
    ble     $f6, $f7, be.28515          # |    804,536 |    804,536 |          0 |     44,979 |
bg.28513:
    fmul    $f4, $f13, $f6              # |    350,945 |    350,945 |          0 |          0 |
    load    [$i2 + 6], $f7              # |    350,945 |    350,945 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    350,945 |    350,945 |          0 |          0 |
    ble     $f7, $f6, be.28515          # |    350,945 |    350,945 |          0 |     81,995 |
bg.28514:
    be      $f5, $f0, be.28515          # |    227,323 |    227,323 |          0 |          0 |
bne.28511:
    mov     $f4, $fg0                   # |    557,163 |    557,163 |          0 |          0 |
    ble     $fg11, $fg0, be.28534       # |    557,163 |    557,163 |          0 |          0 |
.count dual_jmp
    b       bg.28527                    # |    557,163 |    557,163 |          0 |          8 |
be.28515:
    load    [$i1 + 4], $f4              # |    577,213 |    577,213 |    156,317 |          0 |
    fsub    $f4, $f3, $f3               # |    577,213 |    577,213 |          0 |          0 |
    load    [$i1 + 5], $f5              # |    577,213 |    577,213 |    205,207 |          0 |
    fmul    $f3, $f5, $f3               # |    577,213 |    577,213 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    577,213 |    577,213 |          0 |          0 |
    fmul    $f3, $f11, $f4              # |    577,213 |    577,213 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |    577,213 |    577,213 |          0 |          0 |
    ble     $f6, $f1, be.28534          # |    577,213 |    577,213 |          0 |    120,716 |
bg.28517:
    fmul    $f3, $f12, $f1              # |    164,898 |    164,898 |          0 |          0 |
    load    [$i2 + 5], $f4              # |    164,898 |    164,898 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |    164,898 |    164,898 |          0 |          0 |
    ble     $f4, $f1, be.28534          # |    164,898 |    164,898 |          0 |      8,475 |
bg.28518:
    be      $f5, $f0, be.28534          # |    127,420 |    127,420 |          0 |      1,848 |
bne.28519:
    mov     $f3, $fg0                   # |    127,420 |    127,420 |          0 |          0 |
    ble     $fg11, $fg0, be.28534       # |    127,420 |    127,420 |          0 |          0 |
.count dual_jmp
    b       bg.28527                    # |    127,420 |    127,420 |          0 |      6,052 |
bne.28508:
    be      $i3, 2, be.28521
bne.28521:
    load    [$i1 + 0], $f4
    be      $f4, $f0, be.28534
bne.28523:
    load    [$i1 + 1], $f5
    load    [$i1 + 2], $f6
    fmul    $f5, $f1, $f1
    load    [$i1 + 3], $f7
    fmul    $f6, $f2, $f2
    fmul    $f7, $f3, $f3
    load    [$i2 + 22], $f5
    fadd    $f1, $f2, $f1
    fmul    $f4, $f5, $f2
    fadd    $f1, $f3, $f1
    fmul    $f1, $f1, $f3
    fsub    $f3, $f2, $f2
    ble     $f2, $f0, be.28534
bg.28524:
    load    [$i2 + 10], $i2
    fsqrt   $f2, $f2
    load    [$i1 + 4], $f3
    be      $i2, 0, be.28525
bne.28525:
    fadd    $f1, $f2, $f1
    fmul    $f1, $f3, $fg0
    ble     $fg11, $fg0, be.28534
.count dual_jmp
    b       bg.28527
be.28525:
    fsub    $f1, $f2, $f1
    fmul    $f1, $f3, $fg0
    ble     $fg11, $fg0, be.28534
.count dual_jmp
    b       bg.28527
be.28521:
    load    [$i1 + 0], $f1
    ble     $f0, $f1, be.28534
bg.28522:
    load    [$i2 + 22], $f2
    fmul    $f1, $f2, $fg0
    ble     $fg11, $fg0, be.28534
bg.28527:
    load    [$i11 + 1], $i1             # |  1,818,959 |  1,818,959 |        222 |          0 |
    be      $i1, -1, be.28534           # |  1,818,959 |  1,818,959 |          0 |          0 |
bne.28528:
    load    [ext_and_net + $i1], $i3    # |  1,818,959 |  1,818,959 |     11,327 |          0 |
    li      0, $i6                      # |  1,818,959 |  1,818,959 |          0 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [$i11 + 2], $i1             # |  1,818,959 |  1,818,959 |          0 |          0 |
    be      $i1, -1, be.28534           # |  1,818,959 |  1,818,959 |          0 |          0 |
bne.28529:
    li      0, $i6                      # |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,818,959 |  1,818,959 |      7,754 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [$i11 + 3], $i1             # |  1,818,959 |  1,818,959 |     13,863 |          0 |
    be      $i1, -1, be.28534           # |  1,818,959 |  1,818,959 |          0 |      7,802 |
bne.28530:
    li      0, $i6                      # |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,818,959 |  1,818,959 |      8,191 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [$i11 + 4], $i1             # |  1,818,959 |  1,818,959 |      4,223 |          0 |
    be      $i1, -1, be.28534           # |  1,818,959 |  1,818,959 |          0 |     35,437 |
bne.28531:
    li      0, $i6                      # |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,818,959 |  1,818,959 |     12,961 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,818,959 |  1,818,959 |          0 |          0 |
    load    [$i11 + 5], $i1             # |  1,818,959 |  1,818,959 |      1,993 |          0 |
    be      $i1, -1, be.28534           # |  1,818,959 |  1,818,959 |          0 |      2,277 |
bne.28532:
    li      0, $i6                      # |    684,583 |    684,583 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,583 |    684,583 |          0 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,583 |    684,583 |          0 |          0 |
    load    [$i11 + 6], $i1             # |    684,583 |    684,583 |      2,726 |          0 |
    be      $i1, -1, be.28534           # |    684,583 |    684,583 |          0 |      3,065 |
bne.28533:
    li      0, $i6                      # |    684,583 |    684,583 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,583 |    684,583 |      4,426 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,583 |    684,583 |          0 |          0 |
    load    [$i11 + 7], $i1             # |    684,583 |    684,583 |     10,969 |          0 |
    be      $i1, -1, be.28534           # |    684,583 |    684,583 |          0 |     10,755 |
bne.28534:
    li      0, $i6
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      8, $i10
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i12, 1, $i12
    b       trace_or_matrix_fast.2893
be.28534:
    add     $i12, 1, $i12               # |  2,268,752 |  2,268,752 |          0 |          0 |
    b       trace_or_matrix_fast.2893   # |  2,268,752 |  2,268,752 |          0 |      2,729 |
be.28499:
    jr      $ra3                        # |  1,134,376 |  1,134,376 |          0 |          0 |
.end trace_or_matrix_fast

######################################################################
# trace_reflections($i14, $f17, $f18, $f19, $f20, $f21)
# $ra = $ra4
# [$i1 - $i15]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg9, $fg11]
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_reflections
trace_reflections.2915:
    bl      $i14, 0, bl.28535           # |     36,992 |     36,992 |          0 |      1,116 |
bge.28535:
    load    [ext_reflections + $i14], $i15# |     18,496 |     18,496 |      4,783 |          0 |
    mov     $fc9, $fg11                 # |     18,496 |     18,496 |          0 |          0 |
    li      0, $i12                     # |     18,496 |     18,496 |          0 |          0 |
    load    [$i15 + 4], $i7             # |     18,496 |     18,496 |      4,537 |          0 |
.count move_args
    mov     $ig1, $i13                  # |     18,496 |     18,496 |          0 |          0 |
    load    [$i15 + 1], $f11            # |     18,496 |     18,496 |      5,834 |          0 |
    load    [$i15 + 2], $f12            # |     18,496 |     18,496 |          0 |          0 |
    load    [$i15 + 3], $f13            # |     18,496 |     18,496 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |     18,496 |     18,496 |          0 |          0 |
    ble     $fg11, $fc7, bne.28539      # |     18,496 |     18,496 |          0 |          0 |
bg.28536:
    ble     $fc8, $fg11, bne.28539      # |     18,496 |     18,496 |          0 |        477 |
bg.28537:
    add     $ig3, $ig3, $i1             # |     11,284 |     11,284 |          0 |          0 |
    load    [$i15 + 0], $i2             # |     11,284 |     11,284 |          0 |          0 |
    add     $i1, $i1, $i1               # |     11,284 |     11,284 |          0 |          0 |
    add     $i1, $ig2, $i1              # |     11,284 |     11,284 |          0 |          0 |
    bne     $i1, $i2, bne.28539         # |     11,284 |     11,284 |          0 |        438 |
be.28539:
    li      0, $i10                     # |     10,330 |     10,330 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     10,330 |     10,330 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,330 |     10,330 |          0 |          0 |
    bne     $i1, 0, bne.28539           # |     10,330 |     10,330 |          0 |          1 |
be.28540:
    load    [ext_nvector + 0], $f1      # |     10,330 |     10,330 |          0 |          0 |
    load    [$i15 + 1], $f2             # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     10,330 |     10,330 |          0 |          0 |
    load    [ext_nvector + 1], $f3      # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f19, $f2, $f2              # |     10,330 |     10,330 |          0 |          0 |
    load    [$i15 + 2], $f4             # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f3, $f4, $f3               # |     10,330 |     10,330 |          0 |          0 |
    load    [ext_nvector + 2], $f5      # |     10,330 |     10,330 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |     10,330 |     10,330 |          0 |          0 |
    load    [$i15 + 3], $f6             # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f5, $f6, $f3               # |     10,330 |     10,330 |          0 |          0 |
    load    [$i15 + 5], $f7             # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f7, $f17, $f5              # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f20, $f4, $f4              # |     10,330 |     10,330 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f21, $f6, $f3              # |     10,330 |     10,330 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f5, $f1, $f1               # |     10,330 |     10,330 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |     10,330 |     10,330 |          0 |          0 |
    fmul    $f7, $f2, $f2               # |     10,330 |     10,330 |          0 |          0 |
    ble     $f1, $f0, ble.28541         # |     10,330 |     10,330 |          0 |        456 |
bg.28541:
    fmul    $f1, $fg13, $f3             # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f1, $fg10, $f4             # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f1, $fg12, $f1             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg7, $f3, $fg7             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg8, $f4, $fg8             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg9, $f1, $fg9             # |      9,373 |      9,373 |          0 |          0 |
    ble     $f2, $f0, bne.28539         # |      9,373 |      9,373 |          0 |        568 |
.count dual_jmp
    b       bg.28542                    # |      7,720 |      7,720 |          0 |          2 |
ble.28541:
    ble     $f2, $f0, bne.28539         # |        957 |        957 |          0 |         33 |
bg.28542:
    fmul    $f2, $f2, $f1               # |      7,720 |      7,720 |          0 |          0 |
    add     $i14, -1, $i14              # |      7,720 |      7,720 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |          0 |          0 |
    fmul    $f1, $f18, $f1              # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg8, $f1, $fg8             # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg9, $f1, $fg9             # |      7,720 |      7,720 |          0 |          0 |
    b       trace_reflections.2915      # |      7,720 |      7,720 |          0 |          2 |
bne.28539:
    add     $i14, -1, $i14              # |     10,776 |     10,776 |          0 |          0 |
    b       trace_reflections.2915      # |     10,776 |     10,776 |          0 |         51 |
bl.28535:
    jr      $ra4                        # |     18,496 |     18,496 |          0 |          0 |
.end trace_reflections

######################################################################
# trace_ray($i16, $f22, $i17, $i18, $i19, $i20, $i21, $i22, $f23)
# $ra = $ra5
# [$i1 - $i16, $i23]
# [$f1 - $f23]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra4]
######################################################################
.align 2
.begin trace_ray
trace_ray.2920:
    bg      $i16, 4, bg.28543           # |     23,754 |     23,754 |          0 |          8 |
ble.28543:
    mov     $fc9, $fg11                 # |     23,754 |     23,754 |          0 |          0 |
    li      0, $i11                     # |     23,754 |     23,754 |          0 |          0 |
    load    [$i17 + 0], $f11            # |     23,754 |     23,754 |        168 |          0 |
    load    [$i17 + 1], $f12            # |     23,754 |     23,754 |          0 |          0 |
.count move_args
    mov     $ig1, $i12                  # |     23,754 |     23,754 |          0 |          0 |
    load    [$i17 + 2], $f13            # |     23,754 |     23,754 |          0 |          0 |
    jal     trace_or_matrix.2879, $ra3  # |     23,754 |     23,754 |          0 |          0 |
    ble     $fg11, $fc7, ble.28545      # |     23,754 |     23,754 |          0 |        666 |
bg.28544:
    bg      $fc8, $fg11, bg.28545       # |     23,754 |     23,754 |          0 |        263 |
ble.28545:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |          0 |          0 |
.count storer
    add     $i19, $i16, $tmp            # |      5,258 |      5,258 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |          0 |          0 |
    be      $i16, 0, bg.28543           # |      5,258 |      5,258 |          0 |          0 |
bne.28547:
    load    [$i17 + 0], $f1             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f1, $fg16, $f1             # |      5,258 |      5,258 |          0 |          0 |
    load    [$i17 + 1], $f2             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f2, $fg14, $f2             # |      5,258 |      5,258 |          0 |          0 |
    load    [$i17 + 2], $f3             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f3, $fg15, $f3             # |      5,258 |      5,258 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |      5,258 |      5,258 |          0 |          0 |
    ble     $f1, $f0, bg.28543          # |      5,258 |      5,258 |          0 |        215 |
bg.28548:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |          0 |          0 |
    mov     $fig9, $f3                  # |      1,984 |      1,984 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |          0 |          0 |
    fmul    $f1, $f22, $f1              # |      1,984 |      1,984 |          0 |          0 |
    fmul    $f1, $f3, $f1               # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg8, $f1, $fg8             # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg9, $f1, $fg9             # |      1,984 |      1,984 |          0 |          0 |
    jr      $ra5                        # |      1,984 |      1,984 |          0 |          0 |
bg.28545:
    load    [ext_objects + $ig3], $i23  # |     18,496 |     18,496 |          0 |          0 |
    load    [$i23 + 1], $i1             # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 1, be.28549            # |     18,496 |     18,496 |          0 |        634 |
bne.28549:
    bne     $i1, 2, bne.28552           # |     10,585 |     10,585 |          0 |        500 |
be.28552:
    load    [$i23 + 4], $f1             # |      7,226 |      7,226 |          0 |          0 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    mov     $fg1, $fig0                 # |      7,226 |      7,226 |          0 |          0 |
    mov     $fg3, $fig1                 # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |      7,226 |      7,226 |          0 |          0 |
    load    [$i23 + 5], $f1             # |      7,226 |      7,226 |          0 |          0 |
    mov     $fg2, $fig2                 # |      7,226 |      7,226 |          0 |          0 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |      7,226 |      7,226 |          0 |          0 |
    load    [$i23 + 6], $f1             # |      7,226 |      7,226 |          0 |          0 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |      7,226 |      7,226 |          0 |          0 |
    load    [$i23 + 0], $i1             # |      7,226 |      7,226 |          0 |          0 |
    load    [$i23 + 13], $fg13          # |      7,226 |      7,226 |          0 |          0 |
    load    [$i23 + 14], $fg10          # |      7,226 |      7,226 |         18 |          0 |
    load    [$i23 + 15], $fg12          # |      7,226 |      7,226 |          0 |          0 |
    be      $i1, 1, be.28556            # |      7,226 |      7,226 |          0 |          0 |
.count dual_jmp
    b       bne.28556                   # |      7,226 |      7,226 |          0 |          2 |
bne.28552:
    load    [$i23 + 7], $f1             # |      3,359 |      3,359 |          0 |          0 |
    fsub    $fg1, $f1, $f1              # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 8], $f2             # |      3,359 |      3,359 |          0 |          0 |
    fsub    $fg3, $f2, $f2              # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 9], $f3             # |      3,359 |      3,359 |          0 |          0 |
    fsub    $fg2, $f3, $f3              # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 4], $f4             # |      3,359 |      3,359 |          0 |          0 |
    fmul    $f1, $f4, $f4               # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 5], $f5             # |      3,359 |      3,359 |          0 |          0 |
    fmul    $f2, $f5, $f5               # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 6], $f6             # |      3,359 |      3,359 |          0 |          0 |
    fmul    $f3, $f6, $f6               # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 3], $i1             # |      3,359 |      3,359 |          0 |          0 |
    be      $i1, 0, be.28553            # |      3,359 |      3,359 |          0 |          2 |
bne.28553:
    load    [$i23 + 18], $f7
    fmul    $f2, $f7, $f7
    load    [$i23 + 17], $f8
    fmul    $f3, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc2, $f7
    fadd    $f4, $f7, $f4
    store   $f4, [ext_nvector + 0]
    load    [$i23 + 18], $f4
    fmul    $f1, $f4, $f4
    load    [$i23 + 16], $f7
    fmul    $f3, $f7, $f3
    fadd    $f4, $f3, $f3
    fmul    $f3, $fc2, $f3
    fadd    $f5, $f3, $f3
    store   $f3, [ext_nvector + 1]
    load    [$i23 + 17], $f3
    fmul    $f1, $f3, $f1
    load    [$i23 + 16], $f4
    fmul    $f2, $f4, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc2, $f1
    fadd    $f6, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [$i23 + 10], $i1
    load    [ext_nvector + 0], $f1
    load    [ext_nvector + 1], $f2
    fmul    $f1, $f1, $f4
    load    [ext_nvector + 2], $f3
    fmul    $f2, $f2, $f2
    fmul    $f3, $f3, $f3
    fadd    $f4, $f2, $f2
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    be      $f2, $f0, be.28554
.count dual_jmp
    b       bne.28554
be.28553:
    store   $f4, [ext_nvector + 0]      # |      3,359 |      3,359 |          0 |          0 |
    store   $f5, [ext_nvector + 1]      # |      3,359 |      3,359 |          0 |          0 |
    store   $f6, [ext_nvector + 2]      # |      3,359 |      3,359 |          0 |          0 |
    load    [$i23 + 10], $i1            # |      3,359 |      3,359 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |      3,359 |      3,359 |        257 |          0 |
    fmul    $f1, $f1, $f4               # |      3,359 |      3,359 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |      3,359 |      3,359 |          0 |          0 |
    fmul    $f2, $f2, $f2               # |      3,359 |      3,359 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |      3,359 |      3,359 |          0 |          0 |
    fmul    $f3, $f3, $f3               # |      3,359 |      3,359 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |      3,359 |      3,359 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |      3,359 |      3,359 |          0 |          0 |
    fsqrt   $f2, $f2                    # |      3,359 |      3,359 |          0 |          0 |
    bne     $f2, $f0, bne.28554         # |      3,359 |      3,359 |          0 |        216 |
be.28554:
    mov     $fc0, $f2
    mov     $fg1, $fig0
    fmul    $f1, $f2, $f1
    mov     $fg3, $fig1
    store   $f1, [ext_nvector + 0]
    load    [ext_nvector + 1], $f1
    mov     $fg2, $fig2
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 1]
    load    [ext_nvector + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 2]
    load    [$i23 + 0], $i1
    load    [$i23 + 13], $fg13
    load    [$i23 + 14], $fg10
    load    [$i23 + 15], $fg12
    be      $i1, 1, be.28556
.count dual_jmp
    b       bne.28556
bne.28554:
    mov     $fg2, $fig2                 # |      3,359 |      3,359 |          0 |          0 |
    mov     $fg3, $fig1                 # |      3,359 |      3,359 |          0 |          0 |
    mov     $fg1, $fig0                 # |      3,359 |      3,359 |          0 |          0 |
    be      $i1, 0, be.28555            # |      3,359 |      3,359 |          0 |        172 |
bne.28555:
    finv_n  $f2, $f2                    # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |        232 |        232 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |        232 |        232 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |        232 |        232 |          0 |          0 |
    load    [$i23 + 0], $i1             # |        232 |        232 |          0 |          0 |
    load    [$i23 + 13], $fg13          # |        232 |        232 |         53 |          0 |
    load    [$i23 + 14], $fg10          # |        232 |        232 |          0 |          0 |
    load    [$i23 + 15], $fg12          # |        232 |        232 |         24 |          0 |
    be      $i1, 1, be.28556            # |        232 |        232 |          0 |          0 |
.count dual_jmp
    b       bne.28556                   # |        232 |        232 |          0 |          2 |
be.28555:
    finv    $f2, $f2                    # |      3,127 |      3,127 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |      3,127 |      3,127 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |      3,127 |      3,127 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |      3,127 |      3,127 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |      3,127 |      3,127 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |      3,127 |      3,127 |          0 |          0 |
    load    [$i23 + 0], $i1             # |      3,127 |      3,127 |      1,111 |          0 |
    load    [$i23 + 13], $fg13          # |      3,127 |      3,127 |      1,468 |          0 |
    load    [$i23 + 14], $fg10          # |      3,127 |      3,127 |         28 |          0 |
    load    [$i23 + 15], $fg12          # |      3,127 |      3,127 |        100 |          0 |
    be      $i1, 1, be.28556            # |      3,127 |      3,127 |          0 |          0 |
.count dual_jmp
    b       bne.28556                   # |      3,127 |      3,127 |          0 |        470 |
be.28549:
    add     $ig2, -1, $i1               # |      7,911 |      7,911 |          0 |          0 |
    store   $f0, [ext_nvector + 0]      # |      7,911 |      7,911 |          0 |          0 |
    store   $f0, [ext_nvector + 1]      # |      7,911 |      7,911 |          0 |          0 |
    store   $f0, [ext_nvector + 2]      # |      7,911 |      7,911 |          0 |          0 |
    load    [$i17 + $i1], $f1           # |      7,911 |      7,911 |          0 |          0 |
    mov     $fg2, $fig2                 # |      7,911 |      7,911 |          0 |          0 |
    mov     $fg3, $fig1                 # |      7,911 |      7,911 |          0 |          0 |
    mov     $fg1, $fig0                 # |      7,911 |      7,911 |          0 |          0 |
    bne     $f1, $f0, bne.28550         # |      7,911 |      7,911 |          0 |          8 |
be.28550:
    mov     $f0, $f1
    fneg    $f1, $f1
    store   $f1, [ext_nvector + $i1]
    load    [$i23 + 0], $i1
    load    [$i23 + 13], $fg13
    load    [$i23 + 14], $fg10
    load    [$i23 + 15], $fg12
    be      $i1, 1, be.28556
.count dual_jmp
    b       bne.28556
bne.28550:
    ble     $f1, $f0, ble.28551         # |      7,911 |      7,911 |          0 |        641 |
bg.28551:
    mov     $fc0, $f1                   # |      1,243 |      1,243 |          0 |          0 |
    fneg    $f1, $f1                    # |      1,243 |      1,243 |          0 |          0 |
    store   $f1, [ext_nvector + $i1]    # |      1,243 |      1,243 |          0 |          0 |
    load    [$i23 + 0], $i1             # |      1,243 |      1,243 |        289 |          0 |
    load    [$i23 + 13], $fg13          # |      1,243 |      1,243 |        324 |          0 |
    load    [$i23 + 14], $fg10          # |      1,243 |      1,243 |        392 |          0 |
    load    [$i23 + 15], $fg12          # |      1,243 |      1,243 |          6 |          0 |
    be      $i1, 1, be.28556            # |      1,243 |      1,243 |          0 |        104 |
.count dual_jmp
    b       bne.28556                   # |        878 |        878 |          0 |          2 |
ble.28551:
    mov     $fc6, $f1                   # |      6,668 |      6,668 |          0 |          0 |
    fneg    $f1, $f1                    # |      6,668 |      6,668 |          0 |          0 |
    store   $f1, [ext_nvector + $i1]    # |      6,668 |      6,668 |          0 |          0 |
    load    [$i23 + 0], $i1             # |      6,668 |      6,668 |          4 |          0 |
    load    [$i23 + 13], $fg13          # |      6,668 |      6,668 |          6 |          0 |
    load    [$i23 + 14], $fg10          # |      6,668 |      6,668 |      5,210 |          0 |
    load    [$i23 + 15], $fg12          # |      6,668 |      6,668 |          0 |          0 |
    be      $i1, 1, be.28556            # |      6,668 |      6,668 |          0 |         86 |
bne.28556:
    bne     $i1, 2, bne.28562           # |     11,472 |     11,472 |          0 |         97 |
be.28562:
    fmul    $fg3, $fc12, $f2            # |        524 |        524 |          0 |          0 |
    call    ext_sin                     # |        524 |        524 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |        524 |        524 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |        524 |        524 |          0 |          0 |
    fsub    $fc0, $f1, $f2              # |        524 |        524 |          0 |          0 |
    add     $i1, $i1, $i1               # |        524 |        524 |          0 |          0 |
    fmul    $fc1, $f1, $fg13            # |        524 |        524 |          0 |          0 |
.count storer
    add     $i19, $i16, $tmp            # |        524 |        524 |          0 |          0 |
    fmul    $fc1, $f2, $fg10            # |        524 |        524 |          0 |          0 |
    add     $i1, $ig2, $i1              # |        524 |        524 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        524 |        524 |          0 |          0 |
    load    [$i18 + $i16], $i1          # |        524 |        524 |        404 |          0 |
    store   $fg1, [$i1 + 0]             # |        524 |        524 |          0 |          0 |
    store   $fg3, [$i1 + 1]             # |        524 |        524 |          0 |          0 |
    store   $fg2, [$i1 + 2]             # |        524 |        524 |          0 |          0 |
    load    [$i23 + 11], $f1            # |        524 |        524 |          0 |          0 |
    fmul    $f1, $f22, $f17             # |        524 |        524 |          0 |          0 |
    ble     $fc2, $f1, ble.28568        # |        524 |        524 |          0 |          2 |
.count dual_jmp
    b       bg.28568
bne.28562:
    bne     $i1, 3, bne.28563           # |     10,948 |     10,948 |          0 |      2,110 |
be.28563:
    load    [$i23 + 7], $f1
    load    [$i23 + 9], $f2
    fsub    $fg1, $f1, $f1
    fsub    $fg2, $f2, $f2
    fmul    $f1, $f1, $f1
    fmul    $f2, $f2, $f2
    fadd    $f1, $f2, $f1
    fsqrt   $f1, $f1
    fmul    $f1, $fc3, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fmul    $f1, $fc16, $f2
    call    ext_cos
    fmul    $f1, $f1, $f1
    add     $ig3, $ig3, $i1
    fsub    $fc0, $f1, $f2
    add     $i1, $i1, $i1
    fmul    $f1, $fc1, $fg10
.count storer
    add     $i19, $i16, $tmp
    fmul    $f2, $fc1, $fg12
    add     $i1, $ig2, $i1
    store   $i1, [$tmp + 0]
    load    [$i18 + $i16], $i1
    store   $fg1, [$i1 + 0]
    store   $fg3, [$i1 + 1]
    store   $fg2, [$i1 + 2]
    load    [$i23 + 11], $f1
    fmul    $f1, $f22, $f17
    ble     $fc2, $f1, ble.28568
.count dual_jmp
    b       bg.28568
bne.28563:
    be      $i1, 4, be.28564            # |     10,948 |     10,948 |          0 |        277 |
bne.28564:
    add     $ig3, $ig3, $i1             # |     10,948 |     10,948 |          0 |          0 |
.count storer
    add     $i19, $i16, $tmp            # |     10,948 |     10,948 |          0 |          0 |
    add     $i1, $i1, $i1               # |     10,948 |     10,948 |          0 |          0 |
    add     $i1, $ig2, $i1              # |     10,948 |     10,948 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |     10,948 |     10,948 |          0 |          0 |
    load    [$i18 + $i16], $i1          # |     10,948 |     10,948 |     10,344 |          0 |
    store   $fg1, [$i1 + 0]             # |     10,948 |     10,948 |          0 |          0 |
    store   $fg3, [$i1 + 1]             # |     10,948 |     10,948 |          0 |          0 |
    store   $fg2, [$i1 + 2]             # |     10,948 |     10,948 |          0 |          0 |
    load    [$i23 + 11], $f1            # |     10,948 |     10,948 |          0 |          0 |
    fmul    $f1, $f22, $f17             # |     10,948 |     10,948 |          0 |          0 |
    ble     $fc2, $f1, ble.28568        # |     10,948 |     10,948 |          0 |        120 |
.count dual_jmp
    b       bg.28568                    # |      7,370 |      7,370 |          0 |          4 |
be.28564:
    load    [$i23 + 7], $f1
    fsub    $fg1, $f1, $f1
    load    [$i23 + 4], $f2
    fsqrt   $f2, $f2
    load    [$i23 + 6], $f3
    fsqrt   $f3, $f3
    load    [$i23 + 9], $f4
    fsub    $fg2, $f4, $f4
.count load_float
    load    [f.27983], $f9
    fmul    $f1, $f2, $f1
    fmul    $f4, $f3, $f2
    fmul    $f1, $f1, $f3
    fmul    $f2, $f2, $f4
    fabs    $f1, $f5
    fadd    $f3, $f4, $f10
    ble     $f9, $f5, ble.28565
bg.28565:
    mov     $fc5, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    load    [$i23 + 5], $f2
    load    [$i23 + 8], $f3
    fsub    $f4, $f1, $f11
    fsqrt   $f2, $f1
    fsub    $fg3, $f3, $f2
    fabs    $f10, $f3
    fmul    $f2, $f1, $f1
    ble     $f9, $f3, ble.28566
.count dual_jmp
    b       bg.28566
ble.28565:
    finv    $f1, $f1
    fmul_a  $f2, $f1, $f2
    call    ext_atan
    fmul    $fc4, $f1, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    load    [$i23 + 5], $f2
    fsub    $f4, $f1, $f11
    load    [$i23 + 8], $f3
    fsqrt   $f2, $f1
    fsub    $fg3, $f3, $f2
    fabs    $f10, $f3
    fmul    $f2, $f1, $f1
    ble     $f9, $f3, ble.28566
bg.28566:
    mov     $fc5, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc2, $f11, $f2
    fsub    $fc2, $f1, $f1
    fmul    $f2, $f2, $f2
    fmul    $f1, $f1, $f1
    fsub    $fc15, $f2, $f2
    fsub    $f2, $f1, $f1
    ble     $f0, $f1, ble.28567
.count dual_jmp
    b       bg.28567
ble.28566:
    finv    $f10, $f2
    fmul_a  $f1, $f2, $f2
    call    ext_atan
    fmul    $fc4, $f1, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc2, $f11, $f2
    fsub    $fc2, $f1, $f1
    fmul    $f2, $f2, $f2
    fmul    $f1, $f1, $f1
    fsub    $fc15, $f2, $f2
    fsub    $f2, $f1, $f1
    ble     $f0, $f1, ble.28567
bg.28567:
    add     $ig3, $ig3, $i1
    mov     $f0, $f1
    add     $i1, $i1, $i1
    fmul    $fc14, $f1, $fg12
    add     $i1, $ig2, $i1
.count storer
    add     $i19, $i16, $tmp
    store   $i1, [$tmp + 0]
    load    [$i18 + $i16], $i1
    store   $fg1, [$i1 + 0]
    store   $fg3, [$i1 + 1]
    store   $fg2, [$i1 + 2]
    load    [$i23 + 11], $f1
    fmul    $f1, $f22, $f17
    ble     $fc2, $f1, ble.28568
.count dual_jmp
    b       bg.28568
ble.28567:
    add     $ig3, $ig3, $i1
    fmul    $fc14, $f1, $fg12
    add     $i1, $i1, $i1
.count storer
    add     $i19, $i16, $tmp
    add     $i1, $ig2, $i1
    store   $i1, [$tmp + 0]
    load    [$i18 + $i16], $i1
    store   $fg1, [$i1 + 0]
    store   $fg3, [$i1 + 1]
    store   $fg2, [$i1 + 2]
    load    [$i23 + 11], $f1
    fmul    $f1, $f22, $f17
    ble     $fc2, $f1, ble.28568
.count dual_jmp
    b       bg.28568
be.28556:
    load    [$i23 + 7], $f1             # |      7,024 |      7,024 |          0 |          0 |
    fsub    $fg1, $f1, $f4              # |      7,024 |      7,024 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |      7,024 |      7,024 |          0 |          0 |
    call    ext_floor                   # |      7,024 |      7,024 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |      7,024 |      7,024 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |      7,024 |      7,024 |          0 |          0 |
    ble     $fc13, $f1, ble.28557       # |      7,024 |      7,024 |          0 |      1,906 |
bg.28557:
    load    [$i23 + 9], $f1             # |      3,703 |      3,703 |          0 |          0 |
    li      1, $i1                      # |      3,703 |      3,703 |          0 |          0 |
    fsub    $fg2, $f1, $f4              # |      3,703 |      3,703 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |      3,703 |      3,703 |          0 |          0 |
    call    ext_floor                   # |      3,703 |      3,703 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |      3,703 |      3,703 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |      3,703 |      3,703 |          0 |          0 |
    ble     $fc13, $f1, ble.28558       # |      3,703 |      3,703 |          0 |      1,196 |
.count dual_jmp
    b       bg.28558                    # |      1,924 |      1,924 |          0 |        314 |
ble.28557:
    load    [$i23 + 9], $f1             # |      3,321 |      3,321 |          0 |          0 |
    li      0, $i1                      # |      3,321 |      3,321 |          0 |          0 |
    fsub    $fg2, $f1, $f4              # |      3,321 |      3,321 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |      3,321 |      3,321 |          0 |          0 |
    call    ext_floor                   # |      3,321 |      3,321 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |      3,321 |      3,321 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |      3,321 |      3,321 |          0 |          0 |
    ble     $fc13, $f1, ble.28558       # |      3,321 |      3,321 |          0 |      1,055 |
bg.28558:
    be      $i1, 0, be.28781            # |      3,682 |      3,682 |          0 |        364 |
.count dual_jmp
    b       bne.28780                   # |      1,924 |      1,924 |          0 |         27 |
ble.28558:
    be      $i1, 0, bne.28780           # |      3,342 |      3,342 |          0 |          8 |
be.28781:
    add     $ig3, $ig3, $i1             # |      3,537 |      3,537 |          0 |          0 |
    mov     $f0, $fg10                  # |      3,537 |      3,537 |          0 |          0 |
    add     $i1, $i1, $i1               # |      3,537 |      3,537 |          0 |          0 |
.count storer
    add     $i19, $i16, $tmp            # |      3,537 |      3,537 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      3,537 |      3,537 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      3,537 |      3,537 |          0 |          0 |
    load    [$i18 + $i16], $i1          # |      3,537 |      3,537 |      2,924 |          0 |
    store   $fg1, [$i1 + 0]             # |      3,537 |      3,537 |          0 |          0 |
    store   $fg3, [$i1 + 1]             # |      3,537 |      3,537 |          0 |          0 |
    store   $fg2, [$i1 + 2]             # |      3,537 |      3,537 |          0 |          0 |
    load    [$i23 + 11], $f1            # |      3,537 |      3,537 |          0 |          0 |
    fmul    $f1, $f22, $f17             # |      3,537 |      3,537 |          0 |          0 |
    ble     $fc2, $f1, ble.28568        # |      3,537 |      3,537 |          0 |        248 |
.count dual_jmp
    b       bg.28568
bne.28780:
    add     $ig3, $ig3, $i1             # |      3,487 |      3,487 |          0 |          0 |
    mov     $fc1, $fg10                 # |      3,487 |      3,487 |          0 |          0 |
    add     $i1, $i1, $i1               # |      3,487 |      3,487 |          0 |          0 |
.count storer
    add     $i19, $i16, $tmp            # |      3,487 |      3,487 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      3,487 |      3,487 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      3,487 |      3,487 |          0 |          0 |
    load    [$i18 + $i16], $i1          # |      3,487 |      3,487 |      2,897 |          0 |
    store   $fg1, [$i1 + 0]             # |      3,487 |      3,487 |          0 |          0 |
    store   $fg3, [$i1 + 1]             # |      3,487 |      3,487 |          0 |          0 |
    store   $fg2, [$i1 + 2]             # |      3,487 |      3,487 |          0 |          0 |
    load    [$i23 + 11], $f1            # |      3,487 |      3,487 |          0 |          0 |
    fmul    $f1, $f22, $f17             # |      3,487 |      3,487 |          0 |          0 |
    ble     $fc2, $f1, ble.28568        # |      3,487 |      3,487 |          0 |        838 |
bg.28568:
    li      0, $i1                      # |      7,370 |      7,370 |          0 |          0 |
.count storer
    add     $i20, $i16, $tmp            # |      7,370 |      7,370 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      7,370 |      7,370 |          0 |          0 |
    li      0, $i10                     # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |      7,370 |      7,370 |        133 |          0 |
.count load_float
    load    [f.28001], $f2              # |      7,370 |      7,370 |      6,568 |          0 |
.count move_args
    mov     $ig1, $i11                  # |      7,370 |      7,370 |          0 |          0 |
    load    [$i17 + 0], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f3, $f1, $f6               # |      7,370 |      7,370 |          0 |          0 |
    load    [$i17 + 1], $f4             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 1], $f5      # |      7,370 |      7,370 |          0 |          0 |
    load    [$i17 + 2], $f7             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 2], $f5      # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f6, $f4, $f4               # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f7, $f5, $f5               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f4, $f2               # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i17 + 0]             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    load    [$i17 + 1], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i17 + 1]             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |      7,370 |      7,370 |          0 |          0 |
    load    [$i17 + 2], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i17 + 2]             # |      7,370 |      7,370 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |      7,370 |      7,370 |          0 |          0 |
    load    [$i23 + 12], $f1            # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f22, $f1, $f18             # |      7,370 |      7,370 |          0 |          0 |
    be      $i1, 0, be.28569            # |      7,370 |      7,370 |          0 |          4 |
.count dual_jmp
    b       bne.28569                   # |         44 |         44 |          0 |          6 |
ble.28568:
    li      1, $i1                      # |     11,126 |     11,126 |          0 |          0 |
.count storer
    add     $i20, $i16, $tmp            # |     11,126 |     11,126 |          0 |          0 |
.count load_float
    load    [f.28000], $f1              # |     11,126 |     11,126 |      8,678 |          0 |
    store   $i1, [$tmp + 0]             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f1, $f17, $f1              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i21 + $i16], $i1          # |     11,126 |     11,126 |     11,126 |          0 |
    li      0, $i10                     # |     11,126 |     11,126 |          0 |          0 |
    store   $fg13, [$i1 + 0]            # |     11,126 |     11,126 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     11,126 |     11,126 |          0 |          0 |
    store   $fg10, [$i1 + 1]            # |     11,126 |     11,126 |          0 |          0 |
    store   $fg12, [$i1 + 2]            # |     11,126 |     11,126 |          0 |          0 |
    load    [$i21 + $i16], $i1          # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 0], $f2              # |     11,126 |     11,126 |     11,126 |          0 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |          0 |          0 |
    store   $f2, [$i1 + 0]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 1], $f2              # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |          0 |          0 |
    store   $f2, [$i1 + 1]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 2], $f2              # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i22 + $i16], $i1          # |     11,126 |     11,126 |     11,126 |          0 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |        122 |          0 |
    store   $f1, [$i1 + 0]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |          0 |          0 |
.count load_float
    load    [f.28001], $f2              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i17 + 0], $f3             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i17 + 1], $f4             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f3, $f1, $f6               # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f5      # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i17 + 2], $f7             # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f6, $f4, $f4               # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f5      # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f7, $f5, $f5               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f4, $f2               # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i17 + 0]             # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |          0 |          0 |
    load    [$i17 + 1], $f3             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i17 + 1]             # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i17 + 2], $f3             # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i17 + 2]             # |     11,126 |     11,126 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     11,126 |     11,126 |          0 |          0 |
    load    [$i23 + 12], $f1            # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f22, $f1, $f18             # |     11,126 |     11,126 |          0 |          0 |
    bne     $i1, 0, bne.28569           # |     11,126 |     11,126 |          0 |         43 |
be.28569:
    load    [ext_nvector + 0], $f1      # |     17,539 |     17,539 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f1, $fg16, $f1             # |     17,539 |     17,539 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f2, $fg14, $f2             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f3, $fg15, $f3             # |     17,539 |     17,539 |          0 |          0 |
    load    [$i17 + 0], $f4             # |     17,539 |     17,539 |          0 |          0 |
    load    [$i17 + 1], $f5             # |     17,539 |     17,539 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f4, $fg16, $f2             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f5, $fg14, $f4             # |     17,539 |     17,539 |          0 |          0 |
    load    [$i17 + 2], $f5             # |     17,539 |     17,539 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |     17,539 |     17,539 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f5, $fg15, $f3             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f1, $f17, $f1              # |     17,539 |     17,539 |          0 |          0 |
    fadd_n  $f2, $f3, $f2               # |     17,539 |     17,539 |          0 |          0 |
    ble     $f1, $f0, ble.28570         # |     17,539 |     17,539 |          0 |         58 |
bg.28570:
    fmul    $f1, $fg13, $f3             # |     17,537 |     17,537 |          0 |          0 |
    fmul    $f1, $fg10, $f4             # |     17,537 |     17,537 |          0 |          0 |
    fmul    $f1, $fg12, $f1             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg7, $f3, $fg7             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg8, $f4, $fg8             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg9, $f1, $fg9             # |     17,537 |     17,537 |          0 |          0 |
    ble     $f2, $f0, bne.28569         # |     17,537 |     17,537 |          0 |      1,474 |
.count dual_jmp
    b       bg.28571                    # |      6,452 |      6,452 |          0 |          6 |
ble.28570:
    ble     $f2, $f0, bne.28569         # |          2 |          2 |          0 |          2 |
bg.28571:
    fmul    $f2, $f2, $f1               # |      6,452 |      6,452 |          0 |          0 |
    add     $ig0, -1, $i1               # |      6,452 |      6,452 |          0 |          0 |
    mov     $fg1, $fg17                 # |      6,452 |      6,452 |          0 |          0 |
    mov     $fg3, $fg18                 # |      6,452 |      6,452 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      6,452 |      6,452 |          0 |          0 |
    mov     $fg2, $fg19                 # |      6,452 |      6,452 |          0 |          0 |
    fmul    $f1, $f18, $f1              # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg8, $f1, $fg8             # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg9, $f1, $fg9             # |      6,452 |      6,452 |          0 |          0 |
    bge     $i1, 0, bge.28572           # |      6,452 |      6,452 |          0 |          4 |
.count dual_jmp
    b       bl.28572
bne.28569:
    mov     $fg1, $fg17                 # |     12,044 |     12,044 |          0 |          0 |
    add     $ig0, -1, $i1               # |     12,044 |     12,044 |          0 |          0 |
    mov     $fg3, $fg18                 # |     12,044 |     12,044 |          0 |          0 |
    mov     $fg2, $fg19                 # |     12,044 |     12,044 |          0 |          0 |
    bge     $i1, 0, bge.28572           # |     12,044 |     12,044 |          0 |         15 |
bl.28572:
    add     $ig4, -1, $i14
    load    [$i17 + 0], $f19
    load    [$i17 + 1], $f20
    load    [$i17 + 2], $f21
    jal     trace_reflections.2915, $ra4
    ble     $f22, $fc3, bg.28543
.count dual_jmp
    b       bg.28577
bge.28572:
    load    [ext_objects + $i1], $i2    # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 7], $f1              # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 1], $i3              # |     18,496 |     18,496 |          6 |          0 |
    fsub    $fg1, $f1, $f1              # |     18,496 |     18,496 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 8], $f1              # |     18,496 |     18,496 |          0 |          0 |
    fsub    $fg3, $f1, $f1              # |     18,496 |     18,496 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 9], $f1              # |     18,496 |     18,496 |          0 |          0 |
    fsub    $fg2, $f1, $f1              # |     18,496 |     18,496 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |     18,496 |     18,496 |          0 |          0 |
    bne     $i3, 2, bne.28573           # |     18,496 |     18,496 |          0 |        352 |
be.28573:
    load    [$i2 + 19], $f1             # |     18,496 |     18,496 |          1 |          0 |
    add     $i1, -1, $i1                # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 20], $f2             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 21], $f3             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 4], $f4              # |     18,496 |     18,496 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 5], $f5              # |     18,496 |     18,496 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |     18,496 |     18,496 |          0 |          0 |
    load    [$i2 + 6], $f6              # |     18,496 |     18,496 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |     18,496 |     18,496 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     18,496 |     18,496 |          0 |          0 |
.count move_args
    mov     $fg1, $f2                   # |     18,496 |     18,496 |          0 |          0 |
.count move_args
    mov     $fg2, $f4                   # |     18,496 |     18,496 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |     18,496 |     18,496 |          0 |          0 |
.count move_args
    mov     $fg3, $f3                   # |     18,496 |     18,496 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |     18,496 |     18,496 |          0 |          0 |
    call    setup_startp_constants.2831 # |     18,496 |     18,496 |          0 |          0 |
    load    [$i17 + 0], $f19            # |     18,496 |     18,496 |          0 |          0 |
    add     $ig4, -1, $i14              # |     18,496 |     18,496 |          0 |          0 |
    load    [$i17 + 1], $f20            # |     18,496 |     18,496 |          0 |          0 |
    load    [$i17 + 2], $f21            # |     18,496 |     18,496 |          0 |          0 |
    jal     trace_reflections.2915, $ra4# |     18,496 |     18,496 |          0 |          0 |
    ble     $f22, $fc3, bg.28543        # |     18,496 |     18,496 |          0 |        336 |
.count dual_jmp
    b       bg.28577                    # |     18,496 |     18,496 |          0 |          8 |
bne.28573:
    bg      $i3, 2, bg.28574
ble.28574:
    add     $i1, -1, $i1
.count move_args
    mov     $fg1, $f2
.count move_args
    mov     $fg3, $f3
.count move_args
    mov     $fg2, $f4
    call    setup_startp_constants.2831
    add     $ig4, -1, $i14
    load    [$i17 + 0], $f19
    load    [$i17 + 1], $f20
    load    [$i17 + 2], $f21
    jal     trace_reflections.2915, $ra4
    ble     $f22, $fc3, bg.28543
.count dual_jmp
    b       bg.28577
bg.28574:
    load    [$i2 + 19], $f1
    load    [$i2 + 20], $f2
    fmul    $f1, $f1, $f4
    load    [$i2 + 21], $f3
    fmul    $f2, $f2, $f6
    load    [$i2 + 4], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 5], $f7
    fmul    $f3, $f3, $f5
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    load    [$i2 + 3], $i4
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28575
bne.28575:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28576
.count dual_jmp
    b       bne.28576
be.28575:
    mov     $f4, $f1
    be      $i3, 3, be.28576
bne.28576:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
.count move_args
    mov     $fg1, $f2
.count move_args
    mov     $fg3, $f3
.count move_args
    mov     $fg2, $f4
    call    setup_startp_constants.2831
    load    [$i17 + 0], $f19
    add     $ig4, -1, $i14
    load    [$i17 + 1], $f20
    load    [$i17 + 2], $f21
    jal     trace_reflections.2915, $ra4
    ble     $f22, $fc3, bg.28543
.count dual_jmp
    b       bg.28577
be.28576:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
.count move_args
    mov     $fg1, $f2
    store   $f1, [$i2 + 22]
.count move_args
    mov     $fg3, $f3
.count move_args
    mov     $fg2, $f4
    call    setup_startp_constants.2831
    load    [$i17 + 0], $f19
    add     $ig4, -1, $i14
    load    [$i17 + 1], $f20
    load    [$i17 + 2], $f21
    jal     trace_reflections.2915, $ra4
    ble     $f22, $fc3, bg.28543
bg.28577:
    bge     $i16, 4, bge.28578          # |     18,496 |     18,496 |          0 |        113 |
bl.28578:
    add     $i16, 1, $i1                # |     18,496 |     18,496 |          0 |          0 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |          0 |          0 |
.count storer
    add     $i19, $i1, $tmp             # |     18,496 |     18,496 |          0 |          0 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i23 + 2], $i1             # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 2, be.28579            # |     18,496 |     18,496 |          0 |        123 |
.count dual_jmp
    b       bg.28543                    # |     11,126 |     11,126 |          0 |          4 |
bge.28578:
    load    [$i23 + 2], $i1
    be      $i1, 2, be.28579
bg.28543:
    jr      $ra5                        # |     14,400 |     14,400 |          0 |          0 |
be.28579:
    load    [$i23 + 11], $f1            # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f23, $fg11, $f23           # |      7,370 |      7,370 |          0 |          0 |
    add     $i16, 1, $i16               # |      7,370 |      7,370 |          0 |          0 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f22, $f1, $f22             # |      7,370 |      7,370 |          0 |          0 |
    b       trace_ray.2920              # |      7,370 |      7,370 |          0 |          6 |
.end trace_ray

######################################################################
# iter_trace_diffuse_rays($i14, $f17, $f18, $f19, $i15)
# $ra = $ra4
# [$i1 - $i13, $i15 - $i16]
# [$f1 - $f16, $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg6, $fg10 - $fg13]
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i15, 0, bl.28580           # |  1,134,478 |  1,134,478 |          0 |     39,262 |
bge.28580:
    load    [$i14 + $i15], $i1          # |  1,115,880 |  1,115,880 |    515,600 |          0 |
.count move_args
    mov     $ig1, $i13                  # |  1,115,880 |  1,115,880 |          0 |          0 |
    load    [$i1 + 0], $f1              # |  1,115,880 |  1,115,880 |    939,976 |          0 |
    li      0, $i12                     # |  1,115,880 |  1,115,880 |          0 |          0 |
    load    [$i1 + 1], $f2              # |  1,115,880 |  1,115,880 |    977,120 |          0 |
    load    [$i1 + 2], $f3              # |  1,115,880 |  1,115,880 |          0 |          0 |
    fmul    $f1, $f17, $f1              # |  1,115,880 |  1,115,880 |          0 |          0 |
    fmul    $f2, $f18, $f2              # |  1,115,880 |  1,115,880 |          0 |          0 |
    fmul    $f3, $f19, $f3              # |  1,115,880 |  1,115,880 |          0 |          0 |
    mov     $fc9, $fg11                 # |  1,115,880 |  1,115,880 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |  1,115,880 |  1,115,880 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |  1,115,880 |  1,115,880 |          0 |          0 |
    ble     $f0, $f1, ble.28581         # |  1,115,880 |  1,115,880 |          0 |    279,346 |
bg.28581:
    add     $i15, 1, $i1                # |    522,571 |    522,571 |          0 |          0 |
.count load_float
    load    [f.28003], $f2              # |    522,571 |    522,571 |    293,907 |          0 |
    load    [$i14 + $i1], $i16          # |    522,571 |    522,571 |      1,824 |          0 |
    fmul    $f1, $f2, $f20              # |    522,571 |    522,571 |          0 |          0 |
    load    [$i16 + 3], $i7             # |    522,571 |    522,571 |    454,081 |          0 |
    load    [$i16 + 0], $f11            # |    522,571 |    522,571 |    446,003 |          0 |
    load    [$i16 + 1], $f12            # |    522,571 |    522,571 |          0 |          0 |
    load    [$i16 + 2], $f13            # |    522,571 |    522,571 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |    522,571 |    522,571 |          0 |          0 |
    ble     $fg11, $fc7, bne.28628      # |    522,571 |    522,571 |          0 |          0 |
.count dual_jmp
    b       bg.28606                    # |    522,571 |    522,571 |          0 |        291 |
ble.28581:
    load    [$i14 + $i15], $i16         # |    593,309 |    593,309 |          0 |          0 |
.count load_float
    load    [f.28005], $f2              # |    593,309 |    593,309 |     35,742 |          0 |
    fmul    $f1, $f2, $f20              # |    593,309 |    593,309 |          0 |          0 |
    load    [$i16 + 3], $i7             # |    593,309 |    593,309 |          0 |          0 |
    load    [$i16 + 0], $f11            # |    593,309 |    593,309 |      2,607 |          0 |
    load    [$i16 + 1], $f12            # |    593,309 |    593,309 |          0 |          0 |
    load    [$i16 + 2], $f13            # |    593,309 |    593,309 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |    593,309 |    593,309 |          0 |          0 |
    ble     $fg11, $fc7, bne.28628      # |    593,309 |    593,309 |          0 |        233 |
bg.28606:
    ble     $fc8, $fg11, bne.28628      # |  1,115,880 |  1,115,880 |          0 |    237,392 |
bg.28607:
    load    [ext_objects + $ig3], $i12  # |    641,989 |    641,989 |      1,749 |          0 |
    load    [$i12 + 1], $i1             # |    641,989 |    641,989 |      1,595 |          0 |
    be      $i1, 1, be.28609            # |    641,989 |    641,989 |          0 |     61,914 |
bne.28609:
    bne     $i1, 2, bne.28612           # |    527,221 |    527,221 |          0 |     86,470 |
be.28612:
    load    [$i12 + 4], $f1             # |    391,488 |    391,488 |      3,406 |          0 |
    fneg    $f1, $f1                    # |    391,488 |    391,488 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |    391,488 |    391,488 |          0 |          0 |
    load    [$i12 + 5], $f1             # |    391,488 |    391,488 |          0 |          0 |
    fneg    $f1, $f1                    # |    391,488 |    391,488 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |    391,488 |    391,488 |          0 |          0 |
    load    [$i12 + 6], $f1             # |    391,488 |    391,488 |      3,396 |          0 |
    fneg    $f1, $f1                    # |    391,488 |    391,488 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |    391,488 |    391,488 |          0 |          0 |
    load    [$i12 + 0], $i1             # |    391,488 |    391,488 |          0 |          0 |
    load    [$i12 + 13], $fg13          # |    391,488 |    391,488 |      5,866 |          0 |
    load    [$i12 + 14], $fg10          # |    391,488 |    391,488 |     18,401 |          0 |
    load    [$i12 + 15], $fg12          # |    391,488 |    391,488 |          0 |          0 |
    be      $i1, 1, be.28616            # |    391,488 |    391,488 |          0 |          2 |
.count dual_jmp
    b       bne.28616                   # |    391,488 |    391,488 |          0 |     11,660 |
bne.28612:
    load    [$i12 + 7], $f1             # |    135,733 |    135,733 |        983 |          0 |
    fsub    $fg1, $f1, $f1              # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 8], $f2             # |    135,733 |    135,733 |        401 |          0 |
    fsub    $fg3, $f2, $f2              # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 9], $f3             # |    135,733 |    135,733 |        376 |          0 |
    fsub    $fg2, $f3, $f3              # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 4], $f4             # |    135,733 |    135,733 |        200 |          0 |
    fmul    $f1, $f4, $f4               # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 5], $f5             # |    135,733 |    135,733 |          0 |          0 |
    fmul    $f2, $f5, $f5               # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 6], $f6             # |    135,733 |    135,733 |          0 |          0 |
    fmul    $f3, $f6, $f6               # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 3], $i1             # |    135,733 |    135,733 |          0 |          0 |
    be      $i1, 0, be.28613            # |    135,733 |    135,733 |          0 |          4 |
bne.28613:
    load    [$i12 + 18], $f7
    fmul    $f2, $f7, $f7
    load    [$i12 + 17], $f8
    fmul    $f3, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc2, $f7
    fadd    $f4, $f7, $f4
    store   $f4, [ext_nvector + 0]
    load    [$i12 + 18], $f4
    fmul    $f1, $f4, $f4
    load    [$i12 + 16], $f7
    fmul    $f3, $f7, $f3
    fadd    $f4, $f3, $f3
    fmul    $f3, $fc2, $f3
    fadd    $f5, $f3, $f3
    store   $f3, [ext_nvector + 1]
    load    [$i12 + 17], $f3
    fmul    $f1, $f3, $f1
    load    [$i12 + 16], $f4
    fmul    $f2, $f4, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc2, $f1
    fadd    $f6, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [$i12 + 10], $i1
    load    [ext_nvector + 0], $f1
    load    [ext_nvector + 1], $f2
    fmul    $f1, $f1, $f4
    load    [ext_nvector + 2], $f3
    fmul    $f2, $f2, $f2
    fmul    $f3, $f3, $f3
    fadd    $f4, $f2, $f2
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    be      $f2, $f0, be.28614
.count dual_jmp
    b       bne.28614
be.28613:
    store   $f4, [ext_nvector + 0]      # |    135,733 |    135,733 |          0 |          0 |
    store   $f5, [ext_nvector + 1]      # |    135,733 |    135,733 |          0 |          0 |
    store   $f6, [ext_nvector + 2]      # |    135,733 |    135,733 |          0 |          0 |
    load    [$i12 + 10], $i1            # |    135,733 |    135,733 |        303 |          0 |
    load    [ext_nvector + 0], $f1      # |    135,733 |    135,733 |      3,154 |          0 |
    fmul    $f1, $f1, $f4               # |    135,733 |    135,733 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |    135,733 |    135,733 |          0 |          0 |
    fmul    $f2, $f2, $f2               # |    135,733 |    135,733 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |    135,733 |    135,733 |          0 |          0 |
    fmul    $f3, $f3, $f3               # |    135,733 |    135,733 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |    135,733 |    135,733 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |    135,733 |    135,733 |          0 |          0 |
    fsqrt   $f2, $f2                    # |    135,733 |    135,733 |          0 |          0 |
    bne     $f2, $f0, bne.28614         # |    135,733 |    135,733 |          0 |        150 |
be.28614:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 0]
    load    [ext_nvector + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 1]
    load    [ext_nvector + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 2]
    load    [$i12 + 0], $i1
    load    [$i12 + 13], $fg13
    load    [$i12 + 14], $fg10
    load    [$i12 + 15], $fg12
    be      $i1, 1, be.28616
.count dual_jmp
    b       bne.28616
bne.28614:
    be      $i1, 0, be.28615            # |    135,733 |    135,733 |          0 |     13,489 |
bne.28615:
    finv_n  $f2, $f2                    # |     31,876 |     31,876 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,876 |     31,876 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |     31,876 |     31,876 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     31,876 |     31,876 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,876 |     31,876 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |     31,876 |     31,876 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     31,876 |     31,876 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,876 |     31,876 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |     31,876 |     31,876 |          0 |          0 |
    load    [$i12 + 0], $i1             # |     31,876 |     31,876 |          0 |          0 |
    load    [$i12 + 13], $fg13          # |     31,876 |     31,876 |      2,554 |          0 |
    load    [$i12 + 14], $fg10          # |     31,876 |     31,876 |          0 |          0 |
    load    [$i12 + 15], $fg12          # |     31,876 |     31,876 |      1,771 |          0 |
    be      $i1, 1, be.28616            # |     31,876 |     31,876 |          0 |          0 |
.count dual_jmp
    b       bne.28616                   # |     31,876 |     31,876 |          0 |          2 |
be.28615:
    finv    $f2, $f2                    # |    103,857 |    103,857 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,857 |    103,857 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |    103,857 |    103,857 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |    103,857 |    103,857 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,857 |    103,857 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |    103,857 |    103,857 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |    103,857 |    103,857 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,857 |    103,857 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |    103,857 |    103,857 |          0 |          0 |
    load    [$i12 + 0], $i1             # |    103,857 |    103,857 |     17,331 |          0 |
    load    [$i12 + 13], $fg13          # |    103,857 |    103,857 |      9,956 |          0 |
    load    [$i12 + 14], $fg10          # |    103,857 |    103,857 |      3,791 |          0 |
    load    [$i12 + 15], $fg12          # |    103,857 |    103,857 |        906 |          0 |
    be      $i1, 1, be.28616            # |    103,857 |    103,857 |          0 |          0 |
.count dual_jmp
    b       bne.28616                   # |    103,857 |    103,857 |          0 |          4 |
be.28609:
    add     $ig2, -1, $i1               # |    114,768 |    114,768 |          0 |          0 |
    store   $f0, [ext_nvector + 0]      # |    114,768 |    114,768 |          0 |          0 |
    store   $f0, [ext_nvector + 1]      # |    114,768 |    114,768 |          0 |          0 |
    store   $f0, [ext_nvector + 2]      # |    114,768 |    114,768 |          0 |          0 |
    load    [$i16 + $i1], $f1           # |    114,768 |    114,768 |      5,695 |          0 |
    bne     $f1, $f0, bne.28610         # |    114,768 |    114,768 |          0 |          5 |
be.28610:
    mov     $f0, $f1
    fneg    $f1, $f1
    store   $f1, [ext_nvector + $i1]
    load    [$i12 + 0], $i1
    load    [$i12 + 13], $fg13
    load    [$i12 + 14], $fg10
    load    [$i12 + 15], $fg12
    be      $i1, 1, be.28616
.count dual_jmp
    b       bne.28616
bne.28610:
    ble     $f1, $f0, ble.28611         # |    114,768 |    114,768 |          0 |      4,203 |
bg.28611:
    mov     $fc0, $f1                   # |     24,786 |     24,786 |          0 |          0 |
    fneg    $f1, $f1                    # |     24,786 |     24,786 |          0 |          0 |
    store   $f1, [ext_nvector + $i1]    # |     24,786 |     24,786 |          0 |          0 |
    load    [$i12 + 0], $i1             # |     24,786 |     24,786 |      2,218 |          0 |
    load    [$i12 + 13], $fg13          # |     24,786 |     24,786 |      4,085 |          0 |
    load    [$i12 + 14], $fg10          # |     24,786 |     24,786 |      1,731 |          0 |
    load    [$i12 + 15], $fg12          # |     24,786 |     24,786 |      1,071 |          0 |
    be      $i1, 1, be.28616            # |     24,786 |     24,786 |          0 |          0 |
.count dual_jmp
    b       bne.28616                   # |     24,786 |     24,786 |          0 |          4 |
ble.28611:
    mov     $fc6, $f1                   # |     89,982 |     89,982 |          0 |          0 |
    fneg    $f1, $f1                    # |     89,982 |     89,982 |          0 |          0 |
    store   $f1, [ext_nvector + $i1]    # |     89,982 |     89,982 |          0 |          0 |
    load    [$i12 + 0], $i1             # |     89,982 |     89,982 |        326 |          0 |
    load    [$i12 + 13], $fg13          # |     89,982 |     89,982 |        594 |          0 |
    load    [$i12 + 14], $fg10          # |     89,982 |     89,982 |      2,972 |          0 |
    load    [$i12 + 15], $fg12          # |     89,982 |     89,982 |         55 |          0 |
    be      $i1, 1, be.28616            # |     89,982 |     89,982 |          0 |     11,430 |
bne.28616:
    bne     $i1, 2, bne.28622           # |    554,651 |    554,651 |          0 |      1,816 |
be.28622:
    fmul    $fg3, $fc12, $f2            # |      2,362 |      2,362 |          0 |          0 |
    call    ext_sin                     # |      2,362 |      2,362 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      2,362 |      2,362 |          0 |          0 |
    li      0, $i10                     # |      2,362 |      2,362 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |      2,362 |      2,362 |          0 |          0 |
    fsub    $fc0, $f1, $f2              # |      2,362 |      2,362 |          0 |          0 |
    fmul    $fc1, $f1, $fg13            # |      2,362 |      2,362 |          0 |          0 |
    fmul    $fc1, $f2, $fg10            # |      2,362 |      2,362 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |      2,362 |      2,362 |          0 |          0 |
    be      $i1, 0, be.28628            # |      2,362 |      2,362 |          0 |        826 |
.count dual_jmp
    b       bne.28628                   # |      1,372 |      1,372 |          0 |          2 |
bne.28622:
    bne     $i1, 3, bne.28623           # |    552,289 |    552,289 |          0 |      7,874 |
be.28623:
    load    [$i12 + 7], $f1
    fsub    $fg1, $f1, $f1
    load    [$i12 + 9], $f2
    fsub    $fg2, $f2, $f2
    fmul    $f1, $f1, $f1
    fmul    $f2, $f2, $f2
    fadd    $f1, $f2, $f1
    fsqrt   $f1, $f1
    fmul    $f1, $fc3, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fmul    $f1, $fc16, $f2
    call    ext_cos
    fmul    $f1, $f1, $f1
    li      0, $i10
.count move_args
    mov     $ig1, $i11
    fsub    $fc0, $f1, $f2
    fmul    $f1, $fc1, $fg10
    fmul    $f2, $fc1, $fg12
    jal     shadow_check_one_or_matrix.2868, $ra3
    be      $i1, 0, be.28628
.count dual_jmp
    b       bne.28628
bne.28623:
    be      $i1, 4, be.28624            # |    552,289 |    552,289 |          0 |     15,877 |
bne.28624:
    li      0, $i10                     # |    552,289 |    552,289 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |    552,289 |    552,289 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    552,289 |    552,289 |          0 |          0 |
    be      $i1, 0, be.28628            # |    552,289 |    552,289 |          0 |     62,255 |
.count dual_jmp
    b       bne.28628                   # |    110,363 |    110,363 |          0 |          6 |
be.28624:
    load    [$i12 + 7], $f1
    load    [$i12 + 4], $f2
    fsub    $fg1, $f1, $f1
    load    [$i12 + 6], $f3
    fsqrt   $f2, $f2
    load    [$i12 + 9], $f4
    fsqrt   $f3, $f3
    fsub    $fg2, $f4, $f4
.count load_float
    load    [f.27983], $f9
    fmul    $f1, $f2, $f1
    fmul    $f4, $f3, $f2
    fmul    $f1, $f1, $f3
    fmul    $f2, $f2, $f4
    fabs    $f1, $f5
    fadd    $f3, $f4, $f10
    ble     $f9, $f5, ble.28625
bg.28625:
    mov     $fc5, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    load    [$i12 + 5], $f2
    fsub    $f4, $f1, $f11
    load    [$i12 + 8], $f3
    fsqrt   $f2, $f1
    fsub    $fg3, $f3, $f2
    fabs    $f10, $f3
    fmul    $f2, $f1, $f1
    ble     $f9, $f3, ble.28626
.count dual_jmp
    b       bg.28626
ble.28625:
    finv    $f1, $f1
    fmul_a  $f2, $f1, $f2
    call    ext_atan
    fmul    $fc4, $f1, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    load    [$i12 + 5], $f2
    load    [$i12 + 8], $f3
    fsub    $f4, $f1, $f11
    fsqrt   $f2, $f1
    fsub    $fg3, $f3, $f2
    fabs    $f10, $f3
    fmul    $f2, $f1, $f1
    ble     $f9, $f3, ble.28626
bg.28626:
    mov     $fc5, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc2, $f11, $f2
    fsub    $fc2, $f1, $f1
    fmul    $f2, $f2, $f2
    fmul    $f1, $f1, $f1
    fsub    $fc15, $f2, $f2
    fsub    $f2, $f1, $f1
    ble     $f0, $f1, ble.28627
.count dual_jmp
    b       bg.28627
ble.28626:
    finv    $f10, $f2
    fmul_a  $f1, $f2, $f2
    call    ext_atan
    fmul    $fc4, $f1, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc2, $f11, $f2
    fsub    $fc2, $f1, $f1
    fmul    $f2, $f2, $f2
    fmul    $f1, $f1, $f1
    fsub    $fc15, $f2, $f2
    fsub    $f2, $f1, $f1
    ble     $f0, $f1, ble.28627
bg.28627:
    mov     $f0, $f1
    fmul    $fc14, $f1, $fg12
    li      0, $i10
.count move_args
    mov     $ig1, $i11
    jal     shadow_check_one_or_matrix.2868, $ra3
    be      $i1, 0, be.28628
.count dual_jmp
    b       bne.28628
ble.28627:
    fmul    $fc14, $f1, $fg12
    li      0, $i10
.count move_args
    mov     $ig1, $i11
    jal     shadow_check_one_or_matrix.2868, $ra3
    be      $i1, 0, be.28628
.count dual_jmp
    b       bne.28628
be.28616:
    load    [$i12 + 7], $f1             # |     87,338 |     87,338 |        685 |          0 |
    fsub    $fg1, $f1, $f4              # |     87,338 |     87,338 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |     87,338 |     87,338 |          0 |          0 |
    call    ext_floor                   # |     87,338 |     87,338 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |     87,338 |     87,338 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |     87,338 |     87,338 |          0 |          0 |
    ble     $fc13, $f1, ble.28617       # |     87,338 |     87,338 |          0 |     40,437 |
bg.28617:
    load    [$i12 + 9], $f1             # |     40,441 |     40,441 |          0 |          0 |
    li      1, $i1                      # |     40,441 |     40,441 |          0 |          0 |
    fsub    $fg2, $f1, $f4              # |     40,441 |     40,441 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |     40,441 |     40,441 |          0 |          0 |
    call    ext_floor                   # |     40,441 |     40,441 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |     40,441 |     40,441 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |     40,441 |     40,441 |          0 |          0 |
    ble     $fc13, $f1, ble.28618       # |     40,441 |     40,441 |          0 |     19,400 |
.count dual_jmp
    b       bg.28618                    # |     20,680 |     20,680 |          0 |      3,608 |
ble.28617:
    load    [$i12 + 9], $f1             # |     46,897 |     46,897 |          0 |          0 |
    li      0, $i1                      # |     46,897 |     46,897 |          0 |          0 |
    fsub    $fg2, $f1, $f4              # |     46,897 |     46,897 |          0 |          0 |
    fmul    $f4, $fc11, $f2             # |     46,897 |     46,897 |          0 |          0 |
    call    ext_floor                   # |     46,897 |     46,897 |          0 |          0 |
    fmul    $f1, $fc10, $f1             # |     46,897 |     46,897 |          0 |          0 |
    fsub    $f4, $f1, $f1               # |     46,897 |     46,897 |          0 |          0 |
    ble     $fc13, $f1, ble.28618       # |     46,897 |     46,897 |          0 |     22,393 |
bg.28618:
    be      $i1, 0, be.28785            # |     45,063 |     45,063 |          0 |         18 |
.count dual_jmp
    b       bne.28784                   # |     20,680 |     20,680 |          0 |         79 |
ble.28618:
    be      $i1, 0, bne.28784           # |     42,275 |     42,275 |          0 |        488 |
be.28785:
    mov     $f0, $fg10                  # |     44,144 |     44,144 |          0 |          0 |
    li      0, $i10                     # |     44,144 |     44,144 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     44,144 |     44,144 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     44,144 |     44,144 |          0 |          0 |
    be      $i1, 0, be.28628            # |     44,144 |     44,144 |          0 |          2 |
.count dual_jmp
    b       bne.28628                   # |      3,633 |      3,633 |          0 |         19 |
bne.28784:
    mov     $fc1, $fg10                 # |     43,194 |     43,194 |          0 |          0 |
    li      0, $i10                     # |     43,194 |     43,194 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     43,194 |     43,194 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     43,194 |     43,194 |          0 |          0 |
    bne     $i1, 0, bne.28628           # |     43,194 |     43,194 |          0 |     11,913 |
be.28628:
    load    [ext_nvector + 0], $f1      # |    522,905 |    522,905 |      7,354 |          0 |
    fmul    $f1, $fg16, $f1             # |    522,905 |    522,905 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |    522,905 |    522,905 |          0 |          0 |
    fmul    $f2, $fg14, $f2             # |    522,905 |    522,905 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |    522,905 |    522,905 |          0 |          0 |
    fmul    $f3, $fg15, $f3             # |    522,905 |    522,905 |          0 |          0 |
    add     $i15, -2, $i15              # |    522,905 |    522,905 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |    522,905 |    522,905 |          0 |          0 |
    load    [$i12 + 11], $f2            # |    522,905 |    522,905 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |    522,905 |    522,905 |          0 |          0 |
    ble     $f1, $f0, ble.28629         # |    522,905 |    522,905 |          0 |      1,125 |
bg.28629:
    fmul    $f20, $f1, $f1              # |    522,195 |    522,195 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    522,195 |    522,195 |          0 |          0 |
    fmul    $f1, $fg13, $f2             # |    522,195 |    522,195 |          0 |          0 |
    fmul    $f1, $fg10, $f3             # |    522,195 |    522,195 |          0 |          0 |
    fmul    $f1, $fg12, $f1             # |    522,195 |    522,195 |          0 |          0 |
    fadd    $fg4, $f2, $fg4             # |    522,195 |    522,195 |          0 |          0 |
    fadd    $fg5, $f3, $fg5             # |    522,195 |    522,195 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |    522,195 |    522,195 |          0 |          0 |
    b       iter_trace_diffuse_rays.2929# |    522,195 |    522,195 |          0 |     15,922 |
ble.28629:
    mov     $f0, $f1                    # |        710 |        710 |          0 |          0 |
    fmul    $f20, $f1, $f1              # |        710 |        710 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg13, $f2             # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg10, $f3             # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg12, $f1             # |        710 |        710 |          0 |          0 |
    fadd    $fg4, $f2, $fg4             # |        710 |        710 |          0 |          0 |
    fadd    $fg5, $f3, $fg5             # |        710 |        710 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |        710 |        710 |          0 |          0 |
    b       iter_trace_diffuse_rays.2929# |        710 |        710 |          0 |          2 |
bne.28628:
    add     $i15, -2, $i15              # |    592,975 |    592,975 |          0 |          0 |
    b       iter_trace_diffuse_rays.2929# |    592,975 |    592,975 |          0 |      1,380 |
bl.28580:
    jr      $ra4                        # |     18,598 |     18,598 |          0 |          0 |
.end iter_trace_diffuse_rays

######################################################################
# do_without_neighbors($i17, $i18, $i19, $i20, $i21, $i22, $i23, $i24)
# $ra = $ra5
# [$i1 - $i16, $i24 - $i26]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i24, 4, bg.28630           # |      5,000 |      5,000 |          0 |        163 |
ble.28630:
    load    [$i18 + $i24], $i1          # |      5,000 |      5,000 |      2,088 |          0 |
    bl      $i1, 0, bg.28630            # |      5,000 |      5,000 |          0 |        339 |
bge.28631:
    load    [$i19 + $i24], $i1          # |      2,572 |      2,572 |      2,561 |          0 |
    be      $i1, 0, be.28632            # |      2,572 |      2,572 |          0 |        556 |
bne.28632:
    load    [$i21 + $i24], $i1          # |      1,868 |      1,868 |      1,371 |          0 |
    load    [$i23 + $i24], $i25         # |      1,868 |      1,868 |        479 |          0 |
    load    [$i17 + $i24], $i26         # |      1,868 |      1,868 |          0 |          0 |
    load    [$i1 + 0], $fg4             # |      1,868 |      1,868 |      1,373 |          0 |
    load    [$i1 + 1], $fg5             # |      1,868 |      1,868 |          0 |          0 |
    load    [$i1 + 2], $fg6             # |      1,868 |      1,868 |          0 |          0 |
    bne     $i22, 0, bne.28633          # |      1,868 |      1,868 |          0 |        681 |
be.28633:
    be      $i22, 1, be.28639           # |        373 |        373 |          0 |        180 |
.count dual_jmp
    b       bne.28639                   # |        373 |        373 |          0 |        237 |
bne.28633:
    load    [ext_dirvecs + 0], $i14     # |      1,495 |      1,495 |      1,275 |          0 |
    add     $ig0, -1, $i1               # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 0], $fg17           # |      1,495 |      1,495 |      1,495 |          0 |
    load    [$i26 + 1], $fg18           # |      1,495 |      1,495 |      1,488 |          0 |
    load    [$i26 + 2], $fg19           # |      1,495 |      1,495 |          7 |          0 |
    bge     $i1, 0, bge.28634           # |      1,495 |      1,495 |          0 |        239 |
bl.28634:
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 1, be.28639
.count dual_jmp
    b       bne.28639
bge.28634:
    load    [ext_objects + $i1], $i2    # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 0], $f1             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 7], $f2              # |      1,495 |      1,495 |         55 |          0 |
    load    [$i2 + 1], $i3              # |      1,495 |      1,495 |         94 |          0 |
    fsub    $f1, $f2, $f1               # |      1,495 |      1,495 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 1], $f1             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 8], $f2              # |      1,495 |      1,495 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,495 |      1,495 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 2], $f1             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 9], $f2              # |      1,495 |      1,495 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,495 |      1,495 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |      1,495 |      1,495 |          0 |          0 |
    bne     $i3, 2, bne.28635           # |      1,495 |      1,495 |          0 |          4 |
be.28635:
    load    [$i2 + 19], $f1             # |      1,495 |      1,495 |        102 |          0 |
    add     $i1, -1, $i1                # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 20], $f2             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 21], $f3             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 4], $f4              # |      1,495 |      1,495 |         84 |          0 |
    fmul    $f4, $f1, $f1               # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 5], $f5              # |      1,495 |      1,495 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |      1,495 |      1,495 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,495 |      1,495 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |      1,495 |      1,495 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,495 |      1,495 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,495 |      1,495 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 0], $f2             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 1], $f3             # |      1,495 |      1,495 |          0 |          0 |
    load    [$i26 + 2], $f4             # |      1,495 |      1,495 |          0 |          0 |
    call    setup_startp_constants.2831 # |      1,495 |      1,495 |          0 |          0 |
    load    [$i25 + 0], $f17            # |      1,495 |      1,495 |      1,494 |          0 |
    li      118, $i15                   # |      1,495 |      1,495 |          0 |          0 |
    load    [$i25 + 1], $f18            # |      1,495 |      1,495 |          0 |          0 |
    load    [$i25 + 2], $f19            # |      1,495 |      1,495 |      1,488 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |      1,495 |      1,495 |          0 |          0 |
    be      $i22, 1, be.28639           # |      1,495 |      1,495 |          0 |        516 |
.count dual_jmp
    b       bne.28639                   # |      1,119 |      1,119 |          0 |         26 |
bne.28635:
    bg      $i3, 2, bg.28636
ble.28636:
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 1, be.28639
.count dual_jmp
    b       bne.28639
bg.28636:
    load    [$i2 + 19], $f1
    load    [$i2 + 20], $f2
    fmul    $f1, $f1, $f4
    load    [$i2 + 21], $f3
    fmul    $f2, $f2, $f6
    load    [$i2 + 4], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 5], $f7
    fmul    $f3, $f3, $f5
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    load    [$i2 + 3], $i4
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28637
bne.28637:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28638
.count dual_jmp
    b       bne.28638
be.28637:
    mov     $f4, $f1
    be      $i3, 3, be.28638
bne.28638:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 1, be.28639
.count dual_jmp
    b       bne.28639
be.28638:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
    store   $f1, [$i2 + 22]
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    bne     $i22, 1, bne.28639
be.28639:
    be      $i22, 2, be.28645           # |        376 |        376 |          0 |          8 |
.count dual_jmp
    b       bne.28645                   # |        376 |        376 |          0 |          8 |
bne.28639:
    load    [ext_dirvecs + 1], $i14     # |      1,492 |      1,492 |      1,087 |          0 |
    load    [$i26 + 0], $fg17           # |      1,492 |      1,492 |        994 |          0 |
    add     $ig0, -1, $i1               # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 1], $fg18           # |      1,492 |      1,492 |      1,015 |          0 |
    load    [$i26 + 2], $fg19           # |      1,492 |      1,492 |          4 |          0 |
    bge     $i1, 0, bge.28640           # |      1,492 |      1,492 |          0 |         14 |
bl.28640:
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 2, be.28645
.count dual_jmp
    b       bne.28645
bge.28640:
    load    [ext_objects + $i1], $i2    # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 0], $f1             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 7], $f2              # |      1,492 |      1,492 |         17 |          0 |
    fsub    $f1, $f2, $f1               # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 1], $i3              # |      1,492 |      1,492 |         25 |          0 |
    store   $f1, [$i2 + 19]             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 1], $f1             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 8], $f2              # |      1,492 |      1,492 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,492 |      1,492 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 2], $f1             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 9], $f2              # |      1,492 |      1,492 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,492 |      1,492 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |      1,492 |      1,492 |          0 |          0 |
    bne     $i3, 2, bne.28641           # |      1,492 |      1,492 |          0 |          0 |
be.28641:
    load    [$i2 + 19], $f1             # |      1,492 |      1,492 |         27 |          0 |
    load    [$i2 + 20], $f2             # |      1,492 |      1,492 |          0 |          0 |
    add     $i1, -1, $i1                # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 21], $f3             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 4], $f4              # |      1,492 |      1,492 |         52 |          0 |
    load    [$i2 + 5], $f5              # |      1,492 |      1,492 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |      1,492 |      1,492 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,492 |      1,492 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |      1,492 |      1,492 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |      1,492 |      1,492 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,492 |      1,492 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,492 |      1,492 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 0], $f2             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 1], $f3             # |      1,492 |      1,492 |          0 |          0 |
    load    [$i26 + 2], $f4             # |      1,492 |      1,492 |          0 |          0 |
    call    setup_startp_constants.2831 # |      1,492 |      1,492 |          0 |          0 |
    li      118, $i15                   # |      1,492 |      1,492 |          0 |          0 |
    load    [$i25 + 0], $f17            # |      1,492 |      1,492 |      1,037 |          0 |
    load    [$i25 + 1], $f18            # |      1,492 |      1,492 |          0 |          0 |
    load    [$i25 + 2], $f19            # |      1,492 |      1,492 |      1,066 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |      1,492 |      1,492 |          0 |          0 |
    be      $i22, 2, be.28645           # |      1,492 |      1,492 |          0 |        822 |
.count dual_jmp
    b       bne.28645                   # |      1,131 |      1,131 |          0 |         33 |
bne.28641:
    bg      $i3, 2, bg.28642
ble.28642:
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 2, be.28645
.count dual_jmp
    b       bne.28645
bg.28642:
    load    [$i2 + 19], $f1
    fmul    $f1, $f1, $f4
    load    [$i2 + 20], $f2
    fmul    $f2, $f2, $f6
    load    [$i2 + 21], $f3
    load    [$i2 + 4], $f5
    load    [$i2 + 5], $f7
    fmul    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i2 + 3], $i4
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28643
bne.28643:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28644
.count dual_jmp
    b       bne.28644
be.28643:
    mov     $f4, $f1
    be      $i3, 3, be.28644
bne.28644:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 2, be.28645
.count dual_jmp
    b       bne.28645
be.28644:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
    store   $f1, [$i2 + 22]
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    bne     $i22, 2, bne.28645
be.28645:
    be      $i22, 3, be.28651           # |        361 |        361 |          0 |          0 |
.count dual_jmp
    b       bne.28651                   # |        361 |        361 |          0 |          8 |
bne.28645:
    load    [ext_dirvecs + 2], $i14     # |      1,507 |      1,507 |        834 |          0 |
    add     $ig0, -1, $i1               # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 0], $fg17           # |      1,507 |      1,507 |        823 |          0 |
    load    [$i26 + 1], $fg18           # |      1,507 |      1,507 |        812 |          0 |
    load    [$i26 + 2], $fg19           # |      1,507 |      1,507 |          2 |          0 |
    bge     $i1, 0, bge.28646           # |      1,507 |      1,507 |          0 |         12 |
bl.28646:
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 3, be.28651
.count dual_jmp
    b       bne.28651
bge.28646:
    load    [ext_objects + $i1], $i2    # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 0], $f1             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 7], $f2              # |      1,507 |      1,507 |         78 |          0 |
    load    [$i2 + 1], $i3              # |      1,507 |      1,507 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,507 |      1,507 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 1], $f1             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 8], $f2              # |      1,507 |      1,507 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,507 |      1,507 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 2], $f1             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 9], $f2              # |      1,507 |      1,507 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,507 |      1,507 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |      1,507 |      1,507 |          0 |          0 |
    bne     $i3, 2, bne.28647           # |      1,507 |      1,507 |          0 |         25 |
be.28647:
    load    [$i2 + 19], $f1             # |      1,507 |      1,507 |          0 |          0 |
    add     $i1, -1, $i1                # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 20], $f2             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 21], $f3             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 4], $f4              # |      1,507 |      1,507 |        131 |          0 |
    fmul    $f4, $f1, $f1               # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 5], $f5              # |      1,507 |      1,507 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |      1,507 |      1,507 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,507 |      1,507 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |      1,507 |      1,507 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,507 |      1,507 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,507 |      1,507 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 0], $f2             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 1], $f3             # |      1,507 |      1,507 |          0 |          0 |
    load    [$i26 + 2], $f4             # |      1,507 |      1,507 |          0 |          0 |
    call    setup_startp_constants.2831 # |      1,507 |      1,507 |          0 |          0 |
    load    [$i25 + 0], $f17            # |      1,507 |      1,507 |        862 |          0 |
    li      118, $i15                   # |      1,507 |      1,507 |          0 |          0 |
    load    [$i25 + 1], $f18            # |      1,507 |      1,507 |          0 |          0 |
    load    [$i25 + 2], $f19            # |      1,507 |      1,507 |        866 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |      1,507 |      1,507 |          0 |          0 |
    be      $i22, 3, be.28651           # |      1,507 |      1,507 |          0 |        600 |
.count dual_jmp
    b       bne.28651                   # |      1,126 |      1,126 |          0 |        120 |
bne.28647:
    bg      $i3, 2, bg.28648
ble.28648:
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 3, be.28651
.count dual_jmp
    b       bne.28651
bg.28648:
    load    [$i2 + 19], $f1
    load    [$i2 + 20], $f2
    fmul    $f1, $f1, $f4
    load    [$i2 + 21], $f3
    fmul    $f2, $f2, $f6
    load    [$i2 + 4], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 5], $f7
    fmul    $f3, $f3, $f5
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    load    [$i2 + 3], $i4
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28649
bne.28649:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28650
.count dual_jmp
    b       bne.28650
be.28649:
    mov     $f4, $f1
    be      $i3, 3, be.28650
bne.28650:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 3, be.28651
.count dual_jmp
    b       bne.28651
be.28650:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
    store   $f1, [$i2 + 22]
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    bne     $i22, 3, bne.28651
be.28651:
    be      $i22, 4, be.28657           # |        381 |        381 |          0 |          8 |
.count dual_jmp
    b       bne.28657                   # |        381 |        381 |          0 |         10 |
bne.28651:
    load    [ext_dirvecs + 3], $i14     # |      1,487 |      1,487 |      1,012 |          0 |
    load    [$i26 + 0], $fg17           # |      1,487 |      1,487 |        819 |          0 |
    add     $ig0, -1, $i1               # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 1], $fg18           # |      1,487 |      1,487 |        861 |          0 |
    load    [$i26 + 2], $fg19           # |      1,487 |      1,487 |          5 |          0 |
    bge     $i1, 0, bge.28652           # |      1,487 |      1,487 |          0 |         19 |
bl.28652:
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 4, be.28657
.count dual_jmp
    b       bne.28657
bge.28652:
    load    [ext_objects + $i1], $i2    # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 0], $f1             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 7], $f2              # |      1,487 |      1,487 |        128 |          0 |
    fsub    $f1, $f2, $f1               # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 1], $i3              # |      1,487 |      1,487 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 1], $f1             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 8], $f2              # |      1,487 |      1,487 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,487 |      1,487 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 2], $f1             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 9], $f2              # |      1,487 |      1,487 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,487 |      1,487 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |      1,487 |      1,487 |          0 |          0 |
    bne     $i3, 2, bne.28653           # |      1,487 |      1,487 |          0 |          0 |
be.28653:
    load    [$i2 + 19], $f1             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 20], $f2             # |      1,487 |      1,487 |          0 |          0 |
    add     $i1, -1, $i1                # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 21], $f3             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 4], $f4              # |      1,487 |      1,487 |         95 |          0 |
    load    [$i2 + 5], $f5              # |      1,487 |      1,487 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |      1,487 |      1,487 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,487 |      1,487 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |      1,487 |      1,487 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |      1,487 |      1,487 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,487 |      1,487 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,487 |      1,487 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 0], $f2             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 1], $f3             # |      1,487 |      1,487 |          0 |          0 |
    load    [$i26 + 2], $f4             # |      1,487 |      1,487 |          0 |          0 |
    call    setup_startp_constants.2831 # |      1,487 |      1,487 |          0 |          0 |
    li      118, $i15                   # |      1,487 |      1,487 |          0 |          0 |
    load    [$i25 + 0], $f17            # |      1,487 |      1,487 |        817 |          0 |
    load    [$i25 + 1], $f18            # |      1,487 |      1,487 |          0 |          0 |
    load    [$i25 + 2], $f19            # |      1,487 |      1,487 |        841 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |      1,487 |      1,487 |          0 |          0 |
    be      $i22, 4, be.28657           # |      1,487 |      1,487 |          0 |        611 |
.count dual_jmp
    b       bne.28657                   # |      1,110 |      1,110 |          0 |         11 |
bne.28653:
    bg      $i3, 2, bg.28654
ble.28654:
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    load    [$i25 + 0], $f17
    li      118, $i15
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 4, be.28657
.count dual_jmp
    b       bne.28657
bg.28654:
    load    [$i2 + 19], $f1
    fmul    $f1, $f1, $f4
    load    [$i2 + 20], $f2
    fmul    $f2, $f2, $f6
    load    [$i2 + 21], $f3
    load    [$i2 + 4], $f5
    load    [$i2 + 5], $f7
    fmul    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i2 + 3], $i4
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28655
bne.28655:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28656
.count dual_jmp
    b       bne.28656
be.28655:
    mov     $f4, $f1
    be      $i3, 3, be.28656
bne.28656:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 4, be.28657
.count dual_jmp
    b       bne.28657
be.28656:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
    store   $f1, [$i2 + 22]
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    be      $i22, 4, be.28657
bne.28657:
    load    [ext_dirvecs + 4], $i14     # |      1,491 |      1,491 |        961 |          0 |
    add     $ig0, -1, $i1               # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 0], $fg17           # |      1,491 |      1,491 |        883 |          0 |
    load    [$i26 + 1], $fg18           # |      1,491 |      1,491 |        927 |          0 |
    load    [$i26 + 2], $fg19           # |      1,491 |      1,491 |          7 |          0 |
    bl      $i1, 0, bl.28658            # |      1,491 |      1,491 |          0 |          0 |
bge.28658:
    load    [ext_objects + $i1], $i2    # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 0], $f1             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 7], $f2              # |      1,491 |      1,491 |         49 |          0 |
    fsub    $f1, $f2, $f1               # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 1], $i3              # |      1,491 |      1,491 |          0 |          0 |
    store   $f1, [$i2 + 19]             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 1], $f1             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 8], $f2              # |      1,491 |      1,491 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,491 |      1,491 |          0 |          0 |
    store   $f1, [$i2 + 20]             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 2], $f1             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 9], $f2              # |      1,491 |      1,491 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |      1,491 |      1,491 |          0 |          0 |
    store   $f1, [$i2 + 21]             # |      1,491 |      1,491 |          0 |          0 |
    be      $i3, 2, be.28659            # |      1,491 |      1,491 |          0 |         93 |
bne.28659:
    ble     $i3, 2, ble.28660
bg.28660:
    load    [$i2 + 19], $f1
    fmul    $f1, $f1, $f4
    load    [$i2 + 20], $f2
    fmul    $f2, $f2, $f6
    load    [$i2 + 21], $f3
    load    [$i2 + 4], $f5
    load    [$i2 + 5], $f7
    fmul    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i2 + 3], $i4
    fmul    $f6, $f7, $f6
    load    [$i2 + 6], $f7
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i4, 0, be.28661
bne.28661:
    fmul    $f2, $f3, $f5
    load    [$i2 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i2 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i3, 3, be.28662
.count dual_jmp
    b       bne.28662
be.28661:
    mov     $f4, $f1
    be      $i3, 3, be.28662
bne.28662:
    store   $f1, [$i2 + 22]
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i24], $i1
    add     $i24, 1, $i24
    load    [$i1 + 0], $f1
    load    [$i1 + 1], $f2
    fmul    $f1, $fg4, $f1
    load    [$i1 + 2], $f3
    fmul    $f2, $fg5, $f2
    fmul    $f3, $fg6, $f3
    fadd    $fg7, $f1, $fg7
    fadd    $fg8, $f2, $fg8
    fadd    $fg9, $f3, $fg9
    b       do_without_neighbors.2951
be.28662:
    fsub    $f1, $fc0, $f1
    add     $i1, -1, $i1
    store   $f1, [$i2 + 22]
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i24], $i1
    add     $i24, 1, $i24
    load    [$i1 + 0], $f1
    load    [$i1 + 1], $f2
    fmul    $f1, $fg4, $f1
    load    [$i1 + 2], $f3
    fmul    $f2, $fg5, $f2
    fmul    $f3, $fg6, $f3
    fadd    $fg7, $f1, $fg7
    fadd    $fg8, $f2, $fg8
    fadd    $fg9, $f3, $fg9
    b       do_without_neighbors.2951
ble.28660:
    add     $i1, -1, $i1
    load    [$i26 + 0], $f2
    load    [$i26 + 1], $f3
    load    [$i26 + 2], $f4
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i24], $i1
    add     $i24, 1, $i24
    load    [$i1 + 0], $f1
    load    [$i1 + 1], $f2
    fmul    $f1, $fg4, $f1
    load    [$i1 + 2], $f3
    fmul    $f2, $fg5, $f2
    fmul    $f3, $fg6, $f3
    fadd    $fg7, $f1, $fg7
    fadd    $fg8, $f2, $fg8
    fadd    $fg9, $f3, $fg9
    b       do_without_neighbors.2951
be.28659:
    load    [$i2 + 19], $f1             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 20], $f2             # |      1,491 |      1,491 |          0 |          0 |
    add     $i1, -1, $i1                # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 21], $f3             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 4], $f4              # |      1,491 |      1,491 |         37 |          0 |
    load    [$i2 + 5], $f5              # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |      1,491 |      1,491 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |      1,491 |      1,491 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,491 |      1,491 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,491 |      1,491 |          0 |          0 |
    store   $f1, [$i2 + 22]             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 0], $f2             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 1], $f3             # |      1,491 |      1,491 |          0 |          0 |
    load    [$i26 + 2], $f4             # |      1,491 |      1,491 |          0 |          0 |
    call    setup_startp_constants.2831 # |      1,491 |      1,491 |          0 |          0 |
    li      118, $i15                   # |      1,491 |      1,491 |          0 |          0 |
    load    [$i25 + 0], $f17            # |      1,491 |      1,491 |        875 |          0 |
    load    [$i25 + 1], $f18            # |      1,491 |      1,491 |          0 |          0 |
    load    [$i25 + 2], $f19            # |      1,491 |      1,491 |        913 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |      1,491 |      1,491 |          0 |          0 |
    load    [$i20 + $i24], $i1          # |      1,491 |      1,491 |      1,491 |          0 |
    add     $i24, 1, $i24               # |      1,491 |      1,491 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      1,491 |      1,491 |      1,491 |          0 |
    load    [$i1 + 1], $f2              # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f1, $fg4, $f1              # |      1,491 |      1,491 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f2, $fg5, $f2              # |      1,491 |      1,491 |          0 |          0 |
    fmul    $f3, $fg6, $f3              # |      1,491 |      1,491 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |      1,491 |      1,491 |          0 |          0 |
    fadd    $fg8, $f2, $fg8             # |      1,491 |      1,491 |          0 |          0 |
    fadd    $fg9, $f3, $fg9             # |      1,491 |      1,491 |          0 |          0 |
    b       do_without_neighbors.2951   # |      1,491 |      1,491 |          0 |          5 |
bl.28658:
    li      118, $i15
    load    [$i25 + 0], $f17
    load    [$i25 + 1], $f18
    load    [$i25 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i24], $i1
    add     $i24, 1, $i24
    load    [$i1 + 0], $f1
    fmul    $f1, $fg4, $f1
    load    [$i1 + 1], $f2
    fmul    $f2, $fg5, $f2
    load    [$i1 + 2], $f3
    fmul    $f3, $fg6, $f3
    fadd    $fg7, $f1, $fg7
    fadd    $fg8, $f2, $fg8
    fadd    $fg9, $f3, $fg9
    b       do_without_neighbors.2951
be.28657:
    load    [$i20 + $i24], $i1          # |        377 |        377 |        377 |          0 |
    add     $i24, 1, $i24               # |        377 |        377 |          0 |          0 |
    load    [$i1 + 0], $f1              # |        377 |        377 |        377 |          0 |
    fmul    $f1, $fg4, $f1              # |        377 |        377 |          0 |          0 |
    load    [$i1 + 1], $f2              # |        377 |        377 |          0 |          0 |
    fmul    $f2, $fg5, $f2              # |        377 |        377 |          0 |          0 |
    load    [$i1 + 2], $f3              # |        377 |        377 |          0 |          0 |
    fmul    $f3, $fg6, $f3              # |        377 |        377 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |        377 |        377 |          0 |          0 |
    fadd    $fg8, $f2, $fg8             # |        377 |        377 |          0 |          0 |
    fadd    $fg9, $f3, $fg9             # |        377 |        377 |          0 |          0 |
    b       do_without_neighbors.2951   # |        377 |        377 |          0 |          8 |
be.28632:
    add     $i24, 1, $i24               # |        704 |        704 |          0 |          0 |
    b       do_without_neighbors.2951   # |        704 |        704 |          0 |        125 |
bg.28630:
    jr      $ra5                        # |      2,428 |      2,428 |          0 |          0 |
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i24)
# $ra = $ra5
# [$i1 - $i26]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i24, 4, bg.28663           # |     31,800 |     31,800 |          0 |         31 |
ble.28663:
    load    [$i4 + $i2], $i1            # |     31,800 |     31,800 |         20 |          0 |
    add     $i1, 8, $i6                 # |     31,800 |     31,800 |          0 |          0 |
    load    [$i6 + $i24], $i6           # |     31,800 |     31,800 |      1,963 |          0 |
    bl      $i6, 0, bg.28663            # |     31,800 |     31,800 |          0 |        288 |
bge.28664:
    load    [$i3 + $i2], $i7            # |     17,844 |     17,844 |      4,999 |          0 |
    add     $i7, 8, $i8                 # |     17,844 |     17,844 |          0 |          0 |
    load    [$i8 + $i24], $i8           # |     17,844 |     17,844 |     17,191 |          0 |
    bne     $i8, $i6, bne.28665         # |     17,844 |     17,844 |          0 |      1,122 |
be.28665:
    load    [$i5 + $i2], $i8            # |     17,050 |     17,050 |      4,171 |          0 |
    add     $i8, 8, $i8                 # |     17,050 |     17,050 |          0 |          0 |
    load    [$i8 + $i24], $i8           # |     17,050 |     17,050 |     15,753 |          0 |
    bne     $i8, $i6, bne.28665         # |     17,050 |     17,050 |          0 |        976 |
be.28666:
    add     $i2, -1, $i8                # |     16,359 |     16,359 |          0 |          0 |
    load    [$i4 + $i8], $i8            # |     16,359 |     16,359 |        210 |          0 |
    add     $i8, 8, $i8                 # |     16,359 |     16,359 |          0 |          0 |
    load    [$i8 + $i24], $i8           # |     16,359 |     16,359 |     11,038 |          0 |
    bne     $i8, $i6, bne.28665         # |     16,359 |     16,359 |          0 |        424 |
be.28667:
    add     $i2, 1, $i8                 # |     16,132 |     16,132 |          0 |          0 |
    load    [$i4 + $i8], $i8            # |     16,132 |     16,132 |      3,377 |          0 |
    add     $i8, 8, $i8                 # |     16,132 |     16,132 |          0 |          0 |
    load    [$i8 + $i24], $i8           # |     16,132 |     16,132 |     15,579 |          0 |
    bne     $i8, $i6, bne.28665         # |     16,132 |     16,132 |          0 |        391 |
be.28668:
    add     $i1, 13, $i6                # |     15,924 |     15,924 |          0 |          0 |
    load    [$i6 + $i24], $i6           # |     15,924 |     15,924 |     15,924 |          0 |
    be      $i6, 0, be.28670            # |     15,924 |     15,924 |          0 |        477 |
bne.28670:
    add     $i2, -1, $i6                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i4 + $i6], $i6            # |      9,258 |      9,258 |          0 |          0 |
    add     $i7, 23, $i7                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i5 + $i2], $i9            # |      9,258 |      9,258 |          0 |          0 |
    add     $i1, 23, $i1                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i7 + $i24], $i7           # |      9,258 |      9,258 |      9,258 |          0 |
    add     $i2, 1, $i8                 # |      9,258 |      9,258 |          0 |          0 |
    load    [$i4 + $i8], $i8            # |      9,258 |      9,258 |          0 |          0 |
    add     $i6, 23, $i6                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i6 + $i24], $i6           # |      9,258 |      9,258 |        471 |          0 |
    add     $i8, 23, $i8                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i7 + 0], $fg4             # |      9,258 |      9,258 |      9,257 |          0 |
    add     $i9, 23, $i9                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i7 + 1], $fg5             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i7 + 2], $fg6             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i6 + 0], $f1              # |      9,258 |      9,258 |        518 |          0 |
    load    [$i6 + 1], $f2              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i6 + 2], $f3              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + $i24], $i1           # |      9,258 |      9,258 |        512 |          0 |
    fadd    $fg6, $f3, $fg6             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      9,258 |      9,258 |        544 |          0 |
    fadd    $fg4, $f1, $fg4             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i8 + $i24], $i1           # |      9,258 |      9,258 |      9,258 |          0 |
    load    [$i4 + $i2], $i6            # |      9,258 |      9,258 |         26 |          0 |
    load    [$i1 + 0], $f1              # |      9,258 |      9,258 |      9,258 |          0 |
    add     $i6, 18, $i6                # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i9 + $i24], $i1           # |      9,258 |      9,258 |      9,190 |          0 |
    fadd    $fg6, $f3, $fg6             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      9,258 |      9,258 |      9,258 |          0 |
    fadd    $fg4, $f1, $fg4             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |      9,258 |      9,258 |          0 |          0 |
    load    [$i6 + $i24], $i1           # |      9,258 |      9,258 |      9,258 |          0 |
    add     $i24, 1, $i24               # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      9,258 |      9,258 |      9,258 |          0 |
    fmul    $f1, $fg4, $f1              # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      9,258 |      9,258 |          0 |          0 |
    fmul    $f2, $fg5, $f2              # |      9,258 |      9,258 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      9,258 |      9,258 |          0 |          0 |
    fmul    $f3, $fg6, $f3              # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg7, $f1, $fg7             # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg8, $f2, $fg8             # |      9,258 |      9,258 |          0 |          0 |
    fadd    $fg9, $f3, $fg9             # |      9,258 |      9,258 |          0 |          0 |
    b       try_exploit_neighbors.2967  # |      9,258 |      9,258 |          0 |          4 |
be.28670:
    add     $i24, 1, $i24               # |      6,666 |      6,666 |          0 |          0 |
    b       try_exploit_neighbors.2967  # |      6,666 |      6,666 |          0 |        358 |
bne.28665:
    load    [$i4 + $i2], $i1            # |      1,920 |      1,920 |          0 |          0 |
    add     $i1, 3, $i17                # |      1,920 |      1,920 |          0 |          0 |
    load    [$i1 + 28], $i22            # |      1,920 |      1,920 |      1,920 |          0 |
    add     $i1, 8, $i18                # |      1,920 |      1,920 |          0 |          0 |
    add     $i1, 13, $i19               # |      1,920 |      1,920 |          0 |          0 |
    add     $i1, 18, $i20               # |      1,920 |      1,920 |          0 |          0 |
    add     $i1, 23, $i21               # |      1,920 |      1,920 |          0 |          0 |
    add     $i1, 29, $i23               # |      1,920 |      1,920 |          0 |          0 |
    b       do_without_neighbors.2951   # |      1,920 |      1,920 |          0 |         12 |
bg.28663:
    jr      $ra5                        # |     13,956 |     13,956 |          0 |          0 |
.end try_exploit_neighbors

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin write_rgb_element
write_rgb_element.2976:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |     49,152 |     49,152 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |     49,152 |     49,152 |          0 |          0 |
    li      255, $i4                    # |     49,152 |     49,152 |          0 |          0 |
    call    ext_int_of_float            # |     49,152 |     49,152 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     49,152 |     49,152 |      1,724 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |     49,152 |     49,152 |          0 |          0 |
    bg      $i1, $i4, bg.28673          # |     49,152 |     49,152 |          0 |      4,750 |
ble.28673:
    bge     $i1, 0, bge.28674           # |     33,316 |     33,316 |          0 |         14 |
bl.28674:
    li      0, $i2
    b       ext_write
bge.28674:
    mov     $i1, $i2                    # |     33,316 |     33,316 |          0 |          0 |
    b       ext_write                   # |     33,316 |     33,316 |          0 |        170 |
bg.28673:
    li      255, $i2                    # |     15,836 |     15,836 |          0 |          0 |
    b       ext_write                   # |     15,836 |     15,836 |          0 |        745 |
.end write_rgb_element

######################################################################
# pretrace_diffuse_rays($i17, $i18, $i19, $i20, $i21, $i22, $i23)
# $ra = $ra5
# [$i1 - $i16, $i23]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg6, $fg10 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra4]
######################################################################
.align 2
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i23, 4, bg.28675           # |     34,880 |     34,880 |          0 |          7 |
ble.28675:
    load    [$i18 + $i23], $i1          # |     34,880 |     34,880 |     21,577 |          0 |
    bl      $i1, 0, bg.28675            # |     34,880 |     34,880 |          0 |        577 |
bge.28676:
    load    [$i19 + $i23], $i1          # |     18,496 |     18,496 |     18,485 |          0 |
    be      $i1, 0, be.28677            # |     18,496 |     18,496 |          0 |      4,685 |
bne.28677:
    load    [$i17 + $i23], $i1          # |     11,126 |     11,126 |        979 |          0 |
    mov     $f0, $fg6                   # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_dirvecs + $i21], $i14  # |     11,126 |     11,126 |      7,380 |          0 |
    mov     $fg6, $fg4                  # |     11,126 |     11,126 |          0 |          0 |
    load    [$i22 + $i23], $i5          # |     11,126 |     11,126 |        112 |          0 |
    mov     $fg6, $fg5                  # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 0], $fg17            # |     11,126 |     11,126 |     11,126 |          0 |
    load    [$i1 + 1], $fg18            # |     11,126 |     11,126 |     11,117 |          0 |
    add     $ig0, -1, $i2               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 2], $fg19            # |     11,126 |     11,126 |          9 |          0 |
    bl      $i2, 0, bl.28678            # |     11,126 |     11,126 |          0 |          2 |
bge.28678:
    load    [ext_objects + $i2], $i3    # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 0], $f1              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 7], $f2              # |     11,126 |     11,126 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 1], $i4              # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i3 + 19]             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 1], $f1              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 8], $f2              # |     11,126 |     11,126 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i3 + 20]             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 2], $f1              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 9], $f2              # |     11,126 |     11,126 |          0 |          0 |
    fsub    $f1, $f2, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i3 + 21]             # |     11,126 |     11,126 |          0 |          0 |
    be      $i4, 2, be.28679            # |     11,126 |     11,126 |          0 |        127 |
bne.28679:
    ble     $i4, 2, ble.28680
bg.28680:
    load    [$i3 + 19], $f1
    fmul    $f1, $f1, $f4
    load    [$i3 + 20], $f2
    fmul    $f2, $f2, $f6
    load    [$i3 + 21], $f3
    load    [$i3 + 4], $f5
    load    [$i3 + 5], $f7
    fmul    $f4, $f5, $f4
    fmul    $f3, $f3, $f5
    load    [$i3 + 3], $i6
    fmul    $f6, $f7, $f6
    load    [$i3 + 6], $f7
    fadd    $f4, $f6, $f4
    fmul    $f5, $f7, $f5
    fadd    $f4, $f5, $f4
    be      $i6, 0, be.28681
bne.28681:
    fmul    $f2, $f3, $f5
    load    [$i3 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i3 + 17], $f7
    fmul    $f5, $f6, $f5
    fmul    $f1, $f2, $f1
    fmul    $f3, $f7, $f2
    fadd    $f4, $f5, $f3
    load    [$i3 + 18], $f4
    fadd    $f3, $f2, $f2
    fmul    $f1, $f4, $f1
    fadd    $f2, $f1, $f1
    be      $i4, 3, be.28682
.count dual_jmp
    b       bne.28682
be.28681:
    mov     $f4, $f1
    be      $i4, 3, be.28682
bne.28682:
    add     $i2, -1, $i2
    store   $f1, [$i3 + 22]
    load    [$i1 + 0], $f2
    load    [$i1 + 1], $f3
    load    [$i1 + 2], $f4
.count move_args
    mov     $i2, $i1
    call    setup_startp_constants.2831
    load    [$i5 + 0], $f17
    li      118, $i15
    load    [$i5 + 1], $f18
    load    [$i5 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i23], $i1
    add     $i23, 1, $i23
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
be.28682:
    fsub    $f1, $fc0, $f1
    add     $i2, -1, $i2
    store   $f1, [$i3 + 22]
    load    [$i1 + 0], $f2
    load    [$i1 + 1], $f3
    load    [$i1 + 2], $f4
.count move_args
    mov     $i2, $i1
    call    setup_startp_constants.2831
    li      118, $i15
    load    [$i5 + 0], $f17
    load    [$i5 + 1], $f18
    load    [$i5 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i23], $i1
    add     $i23, 1, $i23
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
ble.28680:
    add     $i2, -1, $i2
    load    [$i1 + 0], $f2
    load    [$i1 + 1], $f3
    load    [$i1 + 2], $f4
.count move_args
    mov     $i2, $i1
    call    setup_startp_constants.2831
    load    [$i5 + 0], $f17
    li      118, $i15
    load    [$i5 + 1], $f18
    load    [$i5 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i23], $i1
    add     $i23, 1, $i23
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
be.28679:
    load    [$i3 + 19], $f1             # |     11,126 |     11,126 |          0 |          0 |
    add     $i2, -1, $i2                # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 20], $f2             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 21], $f3             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 4], $f4              # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 5], $f5              # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f5, $f2, $f2               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + 6], $f6              # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i3 + 22]             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 0], $f2              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 1], $f3              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 2], $f4              # |     11,126 |     11,126 |          0 |          0 |
.count move_args
    mov     $i2, $i1                    # |     11,126 |     11,126 |          0 |          0 |
    call    setup_startp_constants.2831 # |     11,126 |     11,126 |          0 |          0 |
    li      118, $i15                   # |     11,126 |     11,126 |          0 |          0 |
    load    [$i5 + 0], $f17             # |     11,126 |     11,126 |     11,126 |          0 |
    load    [$i5 + 1], $f18             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i5 + 2], $f19             # |     11,126 |     11,126 |     11,117 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra4# |     11,126 |     11,126 |          0 |          0 |
    load    [$i20 + $i23], $i1          # |     11,126 |     11,126 |     11,110 |          0 |
    add     $i23, 1, $i23               # |     11,126 |     11,126 |          0 |          0 |
    store   $fg4, [$i1 + 0]             # |     11,126 |     11,126 |          0 |          0 |
    store   $fg5, [$i1 + 1]             # |     11,126 |     11,126 |          0 |          0 |
    store   $fg6, [$i1 + 2]             # |     11,126 |     11,126 |          0 |          0 |
    b       pretrace_diffuse_rays.2980  # |     11,126 |     11,126 |          0 |        192 |
bl.28678:
    li      118, $i15
    load    [$i5 + 0], $f17
    load    [$i5 + 1], $f18
    load    [$i5 + 2], $f19
    jal     iter_trace_diffuse_rays.2929, $ra4
    load    [$i20 + $i23], $i1
    add     $i23, 1, $i23
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
be.28677:
    add     $i23, 1, $i23               # |      7,370 |      7,370 |          0 |          0 |
    b       pretrace_diffuse_rays.2980  # |      7,370 |      7,370 |          0 |         12 |
bg.28675:
    jr      $ra5                        # |     16,384 |     16,384 |          0 |          0 |
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i24, $i25, $i26, $f24, $f25, $f26)
# $ra = $ra6
# [$i1 - $i23, $i25 - $i26]
# [$f1 - $f23]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra5]
######################################################################
.align 2
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i25, 0, bl.28683           # |     16,512 |     16,512 |          0 |      1,830 |
bge.28683:
    mov     $fig13, $f4                 # |     16,384 |     16,384 |          0 |          0 |
    add     $i25, -64, $i2              # |     16,384 |     16,384 |          0 |          0 |
    call    ext_float_of_int            # |     16,384 |     16,384 |          0 |          0 |
    mov     $fig14, $f2                 # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f4, $f3               # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    li      0, $i16                     # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $f0, $f23                   # |     16,384 |     16,384 |          0 |          0 |
    li      ext_ptrace_dirvec, $i17     # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f3, $f24, $f2              # |     16,384 |     16,384 |          0 |          0 |
    store   $f2, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |          0 |          0 |
    fadd    $f1, $f26, $f1              # |     16,384 |     16,384 |          0 |          0 |
    store   $f25, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $fc0, $f22                  # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 0], $f1# |     16,384 |     16,384 |      8,718 |          0 |
    fmul    $f1, $f1, $f4               # |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 1], $f2# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f2, $f2, $f2               # |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 2], $f3# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f3, $f3, $f3               # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg9                   # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg8                   # |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg7                   # |     16,384 |     16,384 |          0 |          0 |
    fsqrt   $f2, $f2                    # |     16,384 |     16,384 |          0 |          0 |
    be      $f2, $f0, be.28684          # |     16,384 |     16,384 |          0 |        261 |
bne.28684:
    finv    $f2, $f2                    # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 1], $f1# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 2], $f1# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_viewpoint + 0], $f1    # |     16,384 |     16,384 |      5,531 |          0 |
    load    [ext_viewpoint + 1], $f2    # |     16,384 |     16,384 |      5,183 |          0 |
    load    [ext_viewpoint + 2], $f3    # |     16,384 |     16,384 |          0 |          0 |
    load    [$i24 + $i25], $i1          # |     16,384 |     16,384 |      8,650 |          0 |
    mov     $f1, $fig0                  # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 3, $i18                # |     16,384 |     16,384 |          0 |          0 |
    mov     $f2, $fig1                  # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 8, $i19                # |     16,384 |     16,384 |          0 |          0 |
    mov     $f3, $fig2                  # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 13, $i20               # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 18, $i21               # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 29, $i22               # |     16,384 |     16,384 |          0 |          0 |
    jal     trace_ray.2920, $ra5        # |     16,384 |     16,384 |          0 |          0 |
    load    [$i24 + $i25], $i1          # |     16,384 |     16,384 |      3,656 |          0 |
    li      0, $i23                     # |     16,384 |     16,384 |          0 |          0 |
    store   $fg7, [$i1 + 0]             # |     16,384 |     16,384 |          0 |          0 |
    store   $fg8, [$i1 + 1]             # |     16,384 |     16,384 |          0 |          0 |
    store   $fg9, [$i1 + 2]             # |     16,384 |     16,384 |          0 |          0 |
    load    [$i24 + $i25], $i1          # |     16,384 |     16,384 |          0 |          0 |
    store   $i26, [$i1 + 28]            # |     16,384 |     16,384 |          0 |          0 |
    load    [$i24 + $i25], $i1          # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 3, $i17                # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 8, $i18                # |     16,384 |     16,384 |          0 |          0 |
    load    [$i1 + 28], $i21            # |     16,384 |     16,384 |      7,612 |          0 |
    add     $i1, 13, $i19               # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 23, $i20               # |     16,384 |     16,384 |          0 |          0 |
    add     $i1, 29, $i22               # |     16,384 |     16,384 |          0 |          0 |
    jal     pretrace_diffuse_rays.2980, $ra5# |     16,384 |     16,384 |          0 |          0 |
    add     $i25, -1, $i25              # |     16,384 |     16,384 |          0 |          0 |
    add     $i26, 1, $i1                # |     16,384 |     16,384 |          0 |          0 |
    bge     $i1, 5, bge.28685           # |     16,384 |     16,384 |          0 |      7,548 |
.count dual_jmp
    b       bl.28685                    # |     13,107 |     13,107 |          0 |         59 |
be.28684:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 0]
    load    [ext_ptrace_dirvec + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 1]
    load    [ext_ptrace_dirvec + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 2]
    load    [ext_viewpoint + 0], $f1
    load    [ext_viewpoint + 1], $f2
    load    [ext_viewpoint + 2], $f3
    load    [$i24 + $i25], $i1
    add     $i1, 3, $i18
    mov     $f1, $fig0
    add     $i1, 8, $i19
    mov     $f2, $fig1
    add     $i1, 13, $i20
    mov     $f3, $fig2
    add     $i1, 18, $i21
    add     $i1, 29, $i22
    jal     trace_ray.2920, $ra5
    load    [$i24 + $i25], $i1
    li      0, $i23
    store   $fg7, [$i1 + 0]
    store   $fg8, [$i1 + 1]
    store   $fg9, [$i1 + 2]
    load    [$i24 + $i25], $i1
    store   $i26, [$i1 + 28]
    load    [$i24 + $i25], $i1
    add     $i1, 3, $i17
    load    [$i1 + 28], $i21
    add     $i1, 8, $i18
    add     $i1, 13, $i19
    add     $i1, 23, $i20
    add     $i1, 29, $i22
    jal     pretrace_diffuse_rays.2980, $ra5
    add     $i25, -1, $i25
    add     $i26, 1, $i1
    bge     $i1, 5, bge.28685
bl.28685:
    mov     $i1, $i26                   # |     13,107 |     13,107 |          0 |          0 |
    b       pretrace_pixels.2983        # |     13,107 |     13,107 |          0 |      6,720 |
bge.28685:
    add     $i26, -4, $i26              # |      3,277 |      3,277 |          0 |          0 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |          0 |         97 |
bl.28683:
    jr      $ra6                        # |        128 |        128 |          0 |          0 |
.end pretrace_pixels

######################################################################
# scan_pixel($i27, $i28, $i29, $i30, $i31)
# $ra = $ra6
# [$i1 - $i27]
# [$f1 - $f20]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# []
# [$ra - $ra5]
######################################################################
.align 2
.begin scan_pixel
scan_pixel.2994:
    li      128, $i1                    # |     16,512 |     16,512 |          0 |          0 |
    ble     $i1, $i27, ble.28686        # |     16,512 |     16,512 |          0 |        299 |
bg.28686:
    load    [$i30 + $i27], $i1          # |     16,384 |     16,384 |      1,832 |          0 |
    li      128, $i2                    # |     16,384 |     16,384 |          0 |          0 |
    add     $i28, 1, $i3                # |     16,384 |     16,384 |          0 |          0 |
    load    [$i1 + 0], $fg7             # |     16,384 |     16,384 |     16,384 |          0 |
    load    [$i1 + 1], $fg8             # |     16,384 |     16,384 |          0 |          0 |
    load    [$i1 + 2], $fg9             # |     16,384 |     16,384 |     16,384 |          0 |
    ble     $i2, $i3, ble.28689         # |     16,384 |     16,384 |          0 |         43 |
bg.28687:
    ble     $i28, 0, ble.28689          # |     16,256 |     16,256 |          0 |        273 |
bg.28688:
    li      128, $i1                    # |     16,128 |     16,128 |          0 |          0 |
    add     $i27, 1, $i2                # |     16,128 |     16,128 |          0 |          0 |
    ble     $i1, $i2, ble.28689         # |     16,128 |     16,128 |          0 |        253 |
bg.28689:
    li      0, $i24                     # |     16,002 |     16,002 |          0 |          0 |
    ble     $i27, 0, ble.28690          # |     16,002 |     16,002 |          0 |         74 |
bg.28690:
.count move_args
    mov     $i27, $i2                   # |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $i29, $i3                   # |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $i30, $i4                   # |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $i31, $i5                   # |     15,876 |     15,876 |          0 |          0 |
    jal     try_exploit_neighbors.2967, $ra5# |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $fg7, $f2                   # |     15,876 |     15,876 |          0 |          0 |
    call    write_rgb_element.2976      # |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $fg8, $f2                   # |     15,876 |     15,876 |          0 |          0 |
    call    write_rgb_element.2976      # |     15,876 |     15,876 |          0 |          0 |
.count move_args
    mov     $fg9, $f2                   # |     15,876 |     15,876 |          0 |          0 |
    call    write_rgb_element.2976      # |     15,876 |     15,876 |          0 |          0 |
    add     $i27, 1, $i27               # |     15,876 |     15,876 |          0 |          0 |
    b       scan_pixel.2994             # |     15,876 |     15,876 |          0 |        329 |
ble.28690:
    load    [$i30 + $i27], $i1          # |        126 |        126 |          0 |          0 |
    add     $i1, 3, $i17                # |        126 |        126 |          0 |          0 |
    load    [$i1 + 28], $i22            # |        126 |        126 |        126 |          0 |
    add     $i1, 8, $i18                # |        126 |        126 |          0 |          0 |
    add     $i1, 13, $i19               # |        126 |        126 |          0 |          0 |
    add     $i1, 18, $i20               # |        126 |        126 |          0 |          0 |
    add     $i1, 23, $i21               # |        126 |        126 |          0 |          0 |
    add     $i1, 29, $i23               # |        126 |        126 |          0 |          0 |
    jal     do_without_neighbors.2951, $ra5# |        126 |        126 |          0 |          0 |
.count move_args
    mov     $fg7, $f2                   # |        126 |        126 |          0 |          0 |
    call    write_rgb_element.2976      # |        126 |        126 |          0 |          0 |
.count move_args
    mov     $fg8, $f2                   # |        126 |        126 |          0 |          0 |
    call    write_rgb_element.2976      # |        126 |        126 |          0 |          0 |
.count move_args
    mov     $fg9, $f2                   # |        126 |        126 |          0 |          0 |
    call    write_rgb_element.2976      # |        126 |        126 |          0 |          0 |
    add     $i27, 1, $i27               # |        126 |        126 |          0 |          0 |
    b       scan_pixel.2994             # |        126 |        126 |          0 |        102 |
ble.28689:
    load    [$i30 + $i27], $i1          # |        382 |        382 |          0 |          0 |
    li      0, $i24                     # |        382 |        382 |          0 |          0 |
    load    [$i1 + 28], $i22            # |        382 |        382 |        382 |          0 |
    add     $i1, 3, $i17                # |        382 |        382 |          0 |          0 |
    add     $i1, 8, $i18                # |        382 |        382 |          0 |          0 |
    add     $i1, 13, $i19               # |        382 |        382 |          0 |          0 |
    add     $i1, 18, $i20               # |        382 |        382 |          0 |          0 |
    add     $i1, 23, $i21               # |        382 |        382 |          0 |          0 |
    add     $i1, 29, $i23               # |        382 |        382 |          0 |          0 |
    jal     do_without_neighbors.2951, $ra5# |        382 |        382 |          0 |          0 |
.count move_args
    mov     $fg7, $f2                   # |        382 |        382 |          0 |          0 |
    call    write_rgb_element.2976      # |        382 |        382 |          0 |          0 |
.count move_args
    mov     $fg8, $f2                   # |        382 |        382 |          0 |          0 |
    call    write_rgb_element.2976      # |        382 |        382 |          0 |          0 |
.count move_args
    mov     $fg9, $f2                   # |        382 |        382 |          0 |          0 |
    call    write_rgb_element.2976      # |        382 |        382 |          0 |          0 |
    add     $i27, 1, $i27               # |        382 |        382 |          0 |          0 |
    b       scan_pixel.2994             # |        382 |        382 |          0 |          4 |
ble.28686:
    jr      $ra6                        # |        128 |        128 |          0 |          0 |
.end scan_pixel

######################################################################
# scan_line($i28, $i29, $i30, $i31, $i32)
# $ra = $ra7
# [$i1 - $i32]
# [$f1 - $f26]
# [$ig2 - $ig3]
# [$fg0 - $fg13, $fg17 - $fg19]
# [$fig0 - $fig2]
# [$ra - $ra6]
######################################################################
.align 2
.begin scan_line
scan_line.3000:
    li      128, $i1                    # |        129 |        129 |          0 |          0 |
    ble     $i1, $i28, ble.28692        # |        129 |        129 |          0 |         38 |
bg.28692:
    bge     $i28, 127, bge.28693        # |        128 |        128 |          0 |         71 |
bl.28693:
    add     $i28, -63, $i2              # |        127 |        127 |          0 |          0 |
    call    ext_float_of_int            # |        127 |        127 |          0 |          0 |
    mov     $fig6, $f2                  # |        127 |        127 |          0 |          0 |
    fmul    $f1, $f2, $f2               # |        127 |        127 |          0 |          0 |
    mov     $fig3, $f3                  # |        127 |        127 |          0 |          0 |
    mov     $fig7, $f4                  # |        127 |        127 |          0 |          0 |
    fadd    $f2, $f3, $f24              # |        127 |        127 |          0 |          0 |
    mov     $fig8, $f5                  # |        127 |        127 |          0 |          0 |
    fmul    $f1, $f4, $f2               # |        127 |        127 |          0 |          0 |
    fmul    $f1, $f5, $f1               # |        127 |        127 |          0 |          0 |
    mov     $fig4, $f3                  # |        127 |        127 |          0 |          0 |
    mov     $fig5, $f4                  # |        127 |        127 |          0 |          0 |
    fadd    $f2, $f3, $f25              # |        127 |        127 |          0 |          0 |
    fadd    $f1, $f4, $f26              # |        127 |        127 |          0 |          0 |
    li      127, $i25                   # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i31, $i24                  # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i32, $i26                  # |        127 |        127 |          0 |          0 |
    jal     pretrace_pixels.2983, $ra6  # |        127 |        127 |          0 |          0 |
    li      0, $i27                     # |        127 |        127 |          0 |          0 |
    jal     scan_pixel.2994, $ra6       # |        127 |        127 |          0 |          0 |
    add     $i28, 1, $i28               # |        127 |        127 |          0 |          0 |
    add     $i32, 2, $i1                # |        127 |        127 |          0 |          0 |
    bge     $i1, 5, bge.28694           # |        127 |        127 |          0 |         52 |
.count dual_jmp
    b       bl.28694                    # |         76 |         76 |          0 |          7 |
bge.28693:
    li      0, $i27                     # |          1 |          1 |          0 |          0 |
    jal     scan_pixel.2994, $ra6       # |          1 |          1 |          0 |          0 |
    add     $i28, 1, $i28               # |          1 |          1 |          0 |          0 |
    add     $i32, 2, $i1                # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.28694           # |          1 |          1 |          0 |          1 |
bl.28694:
.count move_args
    mov     $i29, $tmp                  # |         77 |         77 |          0 |          0 |
    mov     $i1, $i32                   # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $i30, $i29                  # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $i31, $i30                  # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $tmp, $i31                  # |         77 |         77 |          0 |          0 |
    b       scan_line.3000              # |         77 |         77 |          0 |          5 |
bge.28694:
.count move_args
    mov     $i29, $tmp                  # |         51 |         51 |          0 |          0 |
    add     $i32, -3, $i32              # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $i30, $i29                  # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $i31, $i30                  # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $tmp, $i31                  # |         51 |         51 |          0 |          0 |
    b       scan_line.3000              # |         51 |         51 |          0 |          5 |
ble.28692:
    jr      $ra7                        # |          1 |          1 |          0 |          0 |
.end scan_line

######################################################################
# $i1 = create_float5x3array()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin create_float5x3array
create_float5x3array.3006:
    li      3, $i2                      # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_float      # |      1,536 |      1,536 |          0 |          0 |
    li      5, $i2                      # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $i1, $i3                    # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_int        # |      1,536 |      1,536 |          0 |          0 |
.count move_ret
    mov     $i1, $i4                    # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |          0 |          0 |
    li      3, $i2                      # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_float      # |      1,536 |      1,536 |          0 |          0 |
    store   $i1, [$i4 + 1]              # |      1,536 |      1,536 |          0 |          0 |
    li      3, $i2                      # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_float      # |      1,536 |      1,536 |          0 |          0 |
    store   $i1, [$i4 + 2]              # |      1,536 |      1,536 |          0 |          0 |
    li      3, $i2                      # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_float      # |      1,536 |      1,536 |          0 |          0 |
    store   $i1, [$i4 + 3]              # |      1,536 |      1,536 |          0 |          0 |
    li      3, $i2                      # |      1,536 |      1,536 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |          0 |          0 |
    call    ext_create_array_float      # |      1,536 |      1,536 |          0 |          0 |
    store   $i1, [$i4 + 4]              # |      1,536 |      1,536 |          0 |          0 |
    mov     $i4, $i1                    # |      1,536 |      1,536 |          0 |          0 |
    jr      $ra1                        # |      1,536 |      1,536 |          0 |          0 |
.end create_float5x3array

######################################################################
# $i1 = create_pixel()
# $ra = $ra2
# [$i1 - $i11]
# [$f2]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin create_pixel
create_pixel.3008:
    li      3, $i2                      # |        384 |        384 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |        384 |        384 |          0 |          0 |
    call    ext_create_array_float      # |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i5                    # |        384 |        384 |          0 |          0 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i6                    # |        384 |        384 |          0 |          0 |
    li      5, $i2                      # |        384 |        384 |          0 |          0 |
    li      0, $i3                      # |        384 |        384 |          0 |          0 |
    call    ext_create_array_int        # |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i7                    # |        384 |        384 |          0 |          0 |
    li      5, $i2                      # |        384 |        384 |          0 |          0 |
    li      0, $i3                      # |        384 |        384 |          0 |          0 |
    call    ext_create_array_int        # |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i8                    # |        384 |        384 |          0 |          0 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i9                    # |        384 |        384 |          0 |          0 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i10                   # |        384 |        384 |          0 |          0 |
    li      1, $i2                      # |        384 |        384 |          0 |          0 |
    li      0, $i3                      # |        384 |        384 |          0 |          0 |
    call    ext_create_array_int        # |        384 |        384 |          0 |          0 |
.count move_ret
    mov     $i1, $i11                   # |        384 |        384 |          0 |          0 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |          0 |          0 |
    load    [$i5 + 0], $i2              # |        384 |        384 |        384 |          0 |
    mov     $hp, $i3                    # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 0]              # |        384 |        384 |          0 |          0 |
    add     $hp, 34, $hp                # |        384 |        384 |          0 |          0 |
    load    [$i5 + 1], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 1]              # |        384 |        384 |          0 |          0 |
    load    [$i5 + 2], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 2]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 3]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 1], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 4]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 5]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 3], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 6]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 4], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 7]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 8]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 9]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 2], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 10]             # |        384 |        384 |          0 |          0 |
    load    [$i7 + 3], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 11]             # |        384 |        384 |          0 |          0 |
    load    [$i7 + 4], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 12]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 13]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 1], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 14]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 2], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 15]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 3], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 16]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 17]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 18]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 1], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 19]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 2], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 20]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 3], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 21]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 22]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 0], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 23]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 1], $i2             # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 24]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 2], $i2             # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 25]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 3], $i2             # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 26]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 4], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 27]             # |        384 |        384 |          0 |          0 |
    load    [$i11 + 0], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 28]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 29]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 1], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 30]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 2], $i2              # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 31]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 3], $i2              # |        384 |        384 |        384 |          0 |
    add     $i3, 29, $i1                # |        384 |        384 |          0 |          0 |
    store   $i2, [$i3 + 32]             # |        384 |        384 |          0 |          0 |
    store   $i1, [$i3 + 33]             # |        384 |        384 |          0 |          0 |
    mov     $i3, $i1                    # |        384 |        384 |          0 |          0 |
    jr      $ra2                        # |        384 |        384 |          0 |          0 |
.end create_pixel

######################################################################
# $i1 = init_line_elements($i12, $i13)
# $ra = $ra3
# [$i1 - $i11, $i13]
# [$f2]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_line_elements
init_line_elements.3010:
    bge     $i13, 0, bge.28695          # |        384 |        384 |          0 |          9 |
bl.28695:
    mov     $i12, $i1                   # |          3 |          3 |          0 |          0 |
    jr      $ra3                        # |          3 |          3 |          0 |          0 |
bge.28695:
    jal     create_pixel.3008, $ra2     # |        381 |        381 |          0 |          0 |
    add     $i13, -1, $i2               # |        381 |        381 |          0 |          0 |
.count storer
    add     $i12, $i13, $tmp            # |        381 |        381 |          0 |          0 |
.count move_args
    mov     $i2, $i13                   # |        381 |        381 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        381 |        381 |          0 |          0 |
    b       init_line_elements.3010     # |        381 |        381 |          0 |          2 |
.end init_line_elements

######################################################################
# $i1 = create_pixelline()
# $ra = $ra3
# [$i1 - $i13]
# [$f2]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin create_pixelline
create_pixelline.3013:
    jal     create_pixel.3008, $ra2     # |          3 |          3 |          0 |          0 |
    li      128, $i2                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i1, $i3                    # |          3 |          3 |          0 |          0 |
    call    ext_create_array_int        # |          3 |          3 |          0 |          0 |
    li      126, $i13                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i1, $i12                   # |          3 |          3 |          0 |          0 |
    b       init_line_elements.3010     # |          3 |          3 |          0 |          2 |
.end create_pixelline

######################################################################
# calc_dirvec($i2, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra1
# [$i1 - $i7]
# [$f1 - $f8, $f11 - $f14]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin calc_dirvec
calc_dirvec.3020:
    bge     $i2, 5, bge.28696           # |        600 |        600 |          0 |        199 |
bl.28696:
    fmul    $f2, $f2, $f1               # |        500 |        500 |          0 |          0 |
    fadd    $f1, $fc3, $f1              # |        500 |        500 |          0 |          0 |
    fsqrt   $f1, $f11                   # |        500 |        500 |          0 |          0 |
    finv    $f11, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_atan                    # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f9, $f12              # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f12, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_sin                     # |        500 |        500 |          0 |          0 |
.count move_ret
    mov     $f1, $f13                   # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f12, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_cos                     # |        500 |        500 |          0 |          0 |
    finv    $f1, $f1                    # |        500 |        500 |          0 |          0 |
    fmul    $f13, $f1, $f1              # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f11, $f11             # |        500 |        500 |          0 |          0 |
    fmul    $f11, $f11, $f1             # |        500 |        500 |          0 |          0 |
    fadd    $f1, $fc3, $f1              # |        500 |        500 |          0 |          0 |
    fsqrt   $f1, $f12                   # |        500 |        500 |          0 |          0 |
    finv    $f12, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_atan                    # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f10, $f13             # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f13, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_sin                     # |        500 |        500 |          0 |          0 |
.count move_ret
    mov     $f1, $f14                   # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f13, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_cos                     # |        500 |        500 |          0 |          0 |
    finv    $f1, $f1                    # |        500 |        500 |          0 |          0 |
    add     $i2, 1, $i2                 # |        500 |        500 |          0 |          0 |
    fmul    $f14, $f1, $f1              # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f12, $f2              # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f11, $f1                   # |        500 |        500 |          0 |          0 |
    b       calc_dirvec.3020            # |        500 |        500 |          0 |          2 |
bge.28696:
    load    [ext_dirvecs + $i3], $i1    # |        100 |        100 |          0 |          0 |
    fmul    $f1, $f1, $f3               # |        100 |        100 |          0 |          0 |
    fmul    $f2, $f2, $f4               # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i4], $i2            # |        100 |        100 |          5 |          0 |
    add     $i4, 40, $i3                # |        100 |        100 |          0 |          0 |
    fadd    $f3, $f4, $f3               # |        100 |        100 |          0 |          0 |
    add     $i4, 80, $i5                # |        100 |        100 |          0 |          0 |
    fadd    $f3, $fc0, $f3              # |        100 |        100 |          0 |          0 |
    add     $i4, 1, $i6                 # |        100 |        100 |          0 |          0 |
    fsqrt   $f3, $f3                    # |        100 |        100 |          0 |          0 |
    add     $i4, 41, $i7                # |        100 |        100 |          0 |          0 |
    finv    $f3, $f3                    # |        100 |        100 |          0 |          0 |
    add     $i4, 81, $i4                # |        100 |        100 |          0 |          0 |
    fmul    $f1, $f3, $f1               # |        100 |        100 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |        100 |        100 |          0 |          0 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    fneg    $f3, $f4                    # |        100 |        100 |          0 |          0 |
    store   $f2, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f3, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    fneg    $f2, $f5                    # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i3], $i2            # |        100 |        100 |          5 |          0 |
    fneg    $f1, $f6                    # |        100 |        100 |          0 |          0 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i5], $i2            # |        100 |        100 |          5 |          0 |
    store   $f3, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f6, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i6], $i2            # |        100 |        100 |         45 |          0 |
    store   $f6, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i7], $i2            # |        100 |        100 |         45 |          0 |
    store   $f6, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f4, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f2, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i4], $i1            # |        100 |        100 |         45 |          0 |
    store   $f4, [$i1 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f2, [$i1 + 2]              # |        100 |        100 |          0 |          0 |
    jr      $ra1                        # |        100 |        100 |          0 |          0 |
.end calc_dirvec

######################################################################
# calc_dirvecs($i8, $f10, $i9, $i10)
# $ra = $ra2
# [$i1 - $i9, $i11]
# [$f1 - $f9, $f11 - $f17]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i8, 0, bl.28697            # |         10 |         10 |          0 |          0 |
bge.28697:
    li      0, $i1                      # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |         10 |         10 |          0 |          0 |
    call    ext_float_of_int            # |         10 |         10 |          0 |          0 |
.count load_float
    load    [f.28075], $f15             # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |         10 |         10 |          0 |          0 |
.count load_float
    load    [f.28076], $f16             # |         10 |         10 |          0 |          0 |
    fmul    $f1, $f15, $f17             # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |         10 |         10 |          0 |          0 |
    fsub    $f17, $f16, $f9             # |         10 |         10 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |          0 |          0 |
    add     $i10, 2, $i11               # |         10 |         10 |          0 |          0 |
    fadd    $f17, $fc3, $f9             # |         10 |         10 |          0 |          0 |
    li      0, $i2                      # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |         10 |         10 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |          0 |          0 |
    add     $i8, -1, $i8                # |         10 |         10 |          0 |          0 |
    bl      $i8, 0, bl.28697            # |         10 |         10 |          0 |          0 |
bge.28698:
    li      0, $i1                      # |         10 |         10 |          0 |          0 |
    add     $i9, 1, $i2                 # |         10 |         10 |          0 |          0 |
    bge     $i2, 5, bge.28699           # |         10 |         10 |          0 |          3 |
bl.28699:
    mov     $i2, $i9                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |          8 |          8 |          0 |          0 |
    call    ext_float_of_int            # |          8 |          8 |          0 |          0 |
    fmul    $f1, $f15, $f17             # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
    fsub    $f17, $f16, $f9             # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    li      0, $i2                      # |          8 |          8 |          0 |          0 |
    fadd    $f17, $fc3, $f9             # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    add     $i8, -1, $i8                # |          8 |          8 |          0 |          0 |
    bge     $i8, 0, bge.28700           # |          8 |          8 |          0 |          0 |
.count dual_jmp
    b       bl.28697                    # |          8 |          8 |          0 |          2 |
bge.28699:
    add     $i9, -4, $i9                # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |          2 |          2 |          0 |          0 |
    call    ext_float_of_int            # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f15, $f17             # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
    fsub    $f17, $f16, $f9             # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    fadd    $f17, $fc3, $f9             # |          2 |          2 |          0 |          0 |
    li      0, $i2                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    add     $i8, -1, $i8                # |          2 |          2 |          0 |          0 |
    bl      $i8, 0, bl.28697            # |          2 |          2 |          0 |          2 |
bge.28700:
    add     $i9, 1, $i1
.count move_args
    mov     $i8, $i2
    bge     $i1, 5, bge.28701
bl.28701:
    mov     $i1, $i9
    li      0, $i1
    call    ext_float_of_int
    fmul    $f1, $f15, $f17
.count move_args
    mov     $i1, $i2
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
    fsub    $f17, $f16, $f9
.count move_args
    mov     $i10, $i4
.count move_args
    mov     $f0, $f2
    jal     calc_dirvec.3020, $ra1
    li      0, $i2
    fadd    $f17, $fc3, $f9
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i11, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i8, -1, $i8
    bge     $i8, 0, bge.28702
.count dual_jmp
    b       bl.28697
bge.28701:
    add     $i9, -4, $i9
    li      0, $i1
    call    ext_float_of_int
    fmul    $f1, $f15, $f17
.count move_args
    mov     $i1, $i2
.count move_args
    mov     $f0, $f1
    fsub    $f17, $f16, $f9
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i10, $i4
    jal     calc_dirvec.3020, $ra1
    fadd    $f17, $fc3, $f9
    li      0, $i2
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $i11, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i8, -1, $i8
    bl      $i8, 0, bl.28697
bge.28702:
    li      0, $i1
    add     $i9, 1, $i2
    bge     $i2, 5, bge.28703
bl.28703:
    mov     $i2, $i9
.count move_args
    mov     $i8, $i2
    call    ext_float_of_int
    fmul    $f1, $f15, $f15
.count move_args
    mov     $i1, $i2
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
    fsub    $f15, $f16, $f9
.count move_args
    mov     $i10, $i4
.count move_args
    mov     $f0, $f2
    jal     calc_dirvec.3020, $ra1
    li      0, $i2
    fadd    $f15, $fc3, $f9
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i11, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i8, -1, $i8
    add     $i9, 1, $i1
    bge     $i1, 5, bge.28704
.count dual_jmp
    b       bl.28704
bge.28703:
    add     $i9, -4, $i9
.count move_args
    mov     $i8, $i2
    call    ext_float_of_int
    fmul    $f1, $f15, $f15
.count move_args
    mov     $i1, $i2
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
    fsub    $f15, $f16, $f9
.count move_args
    mov     $i10, $i4
.count move_args
    mov     $f0, $f2
    jal     calc_dirvec.3020, $ra1
    li      0, $i2
    fadd    $f15, $fc3, $f9
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i11, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i8, -1, $i8
    add     $i9, 1, $i1
    bge     $i1, 5, bge.28704
bl.28704:
    mov     $i1, $i9
    b       calc_dirvecs.3028
bge.28704:
    add     $i9, -4, $i9
    b       calc_dirvecs.3028
bl.28697:
    jr      $ra2                        # |         10 |         10 |          0 |          0 |
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i12, $i13, $i10)
# $ra = $ra3
# [$i1 - $i13]
# [$f1 - $f17]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i12, 0, bl.28705           # |         11 |         11 |          0 |          1 |
bge.28705:
    li      0, $i1                      # |         10 |         10 |          0 |          0 |
.count load_float
    load    [f.28077], $f9              # |         10 |         10 |          1 |          0 |
.count move_args
    mov     $i12, $i2                   # |         10 |         10 |          0 |          0 |
    call    ext_float_of_int            # |         10 |         10 |          0 |          0 |
.count load_float
    load    [f.28075], $f2              # |         10 |         10 |          1 |          0 |
.count load_float
    load    [f.28076], $f15             # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |         10 |         10 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |         10 |         10 |          0 |          0 |
    fsub    $f1, $f15, $f10             # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |          0 |          0 |
    add     $i10, 2, $i8                # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |          0 |          0 |
    li      0, $i2                      # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f15, $f9                   # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |         10 |         10 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |          0 |          0 |
    add     $i13, 1, $i1                # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |         10 |         10 |          0 |          0 |
.count load_float
    load    [f.28078], $f9              # |         10 |         10 |          0 |          0 |
    li      0, $i2                      # |         10 |         10 |          0 |          0 |
    bge     $i1, 5, bge.28706           # |         10 |         10 |          0 |          4 |
bl.28706:
    mov     $i1, $i9                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
.count load_float
    load    [f.28079], $f9              # |          8 |          8 |          0 |          0 |
    li      0, $i2                      # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    li      0, $i2                      # |          8 |          8 |          0 |          0 |
    add     $i9, 1, $i1                 # |          8 |          8 |          0 |          0 |
    bge     $i1, 5, bge.28707           # |          8 |          8 |          0 |          3 |
.count dual_jmp
    b       bl.28707                    # |          6 |          6 |          0 |          2 |
bge.28706:
    add     $i13, -4, $i9               # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
.count load_float
    load    [f.28079], $f9              # |          2 |          2 |          0 |          0 |
    li      0, $i2                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    li      0, $i2                      # |          2 |          2 |          0 |          0 |
    add     $i9, 1, $i1                 # |          2 |          2 |          0 |          0 |
    bge     $i1, 5, bge.28707           # |          2 |          2 |          0 |          0 |
bl.28707:
    mov     $i1, $i9                    # |          8 |          8 |          0 |          0 |
.count load_float
    load    [f.28080], $f9              # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    li      0, $i2                      # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $fc2, $f9                   # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    li      1, $i8                      # |          8 |          8 |          0 |          0 |
    add     $i9, 1, $i1                 # |          8 |          8 |          0 |          0 |
    bge     $i1, 5, bge.28708           # |          8 |          8 |          0 |          4 |
.count dual_jmp
    b       bl.28708                    # |          6 |          6 |          0 |          2 |
bge.28707:
    add     $i9, -4, $i9                # |          2 |          2 |          0 |          0 |
.count load_float
    load    [f.28080], $f9              # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    li      0, $i2                      # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $fc2, $f9                   # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    li      1, $i8                      # |          2 |          2 |          0 |          0 |
    add     $i9, 1, $i1                 # |          2 |          2 |          0 |          0 |
    bge     $i1, 5, bge.28708           # |          2 |          2 |          0 |          0 |
bl.28708:
    mov     $i1, $i9                    # |          8 |          8 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          8 |          8 |          0 |          0 |
    add     $i12, -1, $i12              # |          8 |          8 |          0 |          0 |
    add     $i13, 2, $i1                # |          8 |          8 |          0 |          0 |
    bge     $i1, 5, bge.28709           # |          8 |          8 |          0 |          4 |
.count dual_jmp
    b       bl.28709                    # |          4 |          4 |          0 |          4 |
bge.28708:
    add     $i9, -4, $i9                # |          2 |          2 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          2 |          2 |          0 |          0 |
    add     $i12, -1, $i12              # |          2 |          2 |          0 |          0 |
    add     $i13, 2, $i1                # |          2 |          2 |          0 |          0 |
    bge     $i1, 5, bge.28709           # |          2 |          2 |          0 |          0 |
bl.28709:
    mov     $i1, $i13                   # |          6 |          6 |          0 |          0 |
    add     $i10, 4, $i10               # |          6 |          6 |          0 |          0 |
    b       calc_dirvec_rows.3033       # |          6 |          6 |          0 |          6 |
bge.28709:
    add     $i13, -3, $i13              # |          4 |          4 |          0 |          0 |
    add     $i10, 4, $i10               # |          4 |          4 |          0 |          0 |
    b       calc_dirvec_rows.3033       # |          4 |          4 |          0 |          2 |
bl.28705:
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
# []
# []
# []
# [$ra]
######################################################################
.align 2
.begin create_dirvec
create_dirvec.3037:
    li      3, $i2                      # |        601 |        601 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |        601 |        601 |          0 |          0 |
    call    ext_create_array_float      # |        601 |        601 |          0 |          0 |
.count move_ret
    mov     $i1, $i3                    # |        601 |        601 |          0 |          0 |
.count move_args
    mov     $ig0, $i2                   # |        601 |        601 |          0 |          0 |
    call    ext_create_array_int        # |        601 |        601 |          0 |          0 |
    load    [$i3 + 0], $i2              # |        601 |        601 |        601 |          0 |
    mov     $hp, $i4                    # |        601 |        601 |          0 |          0 |
    add     $hp, 4, $hp                 # |        601 |        601 |          0 |          0 |
    store   $i2, [$i4 + 0]              # |        601 |        601 |          0 |          0 |
    load    [$i3 + 1], $i2              # |        601 |        601 |        600 |          0 |
    store   $i2, [$i4 + 1]              # |        601 |        601 |          0 |          0 |
    load    [$i3 + 2], $i2              # |        601 |        601 |          0 |          0 |
    store   $i2, [$i4 + 2]              # |        601 |        601 |          0 |          0 |
    store   $i1, [$i4 + 3]              # |        601 |        601 |          0 |          0 |
    mov     $i4, $i1                    # |        601 |        601 |          0 |          0 |
    jr      $ra1                        # |        601 |        601 |          0 |          0 |
.end create_dirvec

######################################################################
# create_dirvec_elements($i5, $i6)
# $ra = $ra2
# [$i1 - $i4, $i6]
# [$f2]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bge     $i6, 0, bge.28710           # |        600 |        600 |          0 |         13 |
bl.28710:
    jr      $ra2                        # |          5 |          5 |          0 |          0 |
bge.28710:
    jal     create_dirvec.3037, $ra1    # |        595 |        595 |          0 |          0 |
    add     $i6, -1, $i2                # |        595 |        595 |          0 |          0 |
.count storer
    add     $i5, $i6, $tmp              # |        595 |        595 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        595 |        595 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |        595 |        595 |          0 |          0 |
    b       create_dirvec_elements.3039 # |        595 |        595 |          0 |          2 |
.end create_dirvec_elements

######################################################################
# create_dirvecs($i7)
# $ra = $ra3
# [$i1 - $i7]
# [$f2]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin create_dirvecs
create_dirvecs.3042:
    bge     $i7, 0, bge.28711           # |          6 |          6 |          0 |          4 |
bl.28711:
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
bge.28711:
    jal     create_dirvec.3037, $ra1    # |          5 |          5 |          0 |          0 |
    li      120, $i2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i1, $i3                    # |          5 |          5 |          0 |          0 |
    call    ext_create_array_int        # |          5 |          5 |          0 |          0 |
    store   $i1, [ext_dirvecs + $i7]    # |          5 |          5 |          0 |          0 |
    li      118, $i6                    # |          5 |          5 |          0 |          0 |
    load    [ext_dirvecs + $i7], $i5    # |          5 |          5 |          3 |          0 |
    jal     create_dirvec_elements.3039, $ra2# |          5 |          5 |          0 |          0 |
    add     $i7, -1, $i7                # |          5 |          5 |          0 |          0 |
    b       create_dirvecs.3042         # |          5 |          5 |          0 |          2 |
.end create_dirvecs

######################################################################
# init_dirvec_constants($i7, $i8)
# $ra = $ra2
# [$i1 - $i6, $i8]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bge     $i8, 0, bge.28712           # |        605 |        605 |          0 |         20 |
bl.28712:
    jr      $ra2                        # |          5 |          5 |          0 |          0 |
bge.28712:
    load    [$i7 + $i8], $i1            # |        600 |        600 |         20 |          0 |
    load    [$i1 + 3], $i4              # |        600 |        600 |         37 |          0 |
    load    [$i1 + 0], $f1              # |        600 |        600 |        600 |          0 |
    load    [$i1 + 1], $f3              # |        600 |        600 |          0 |          0 |
    load    [$i1 + 2], $f4              # |        600 |        600 |          0 |          0 |
    jal     setup_dirvec_constants.2829, $ra1# |        600 |        600 |          0 |          0 |
    add     $i8, -1, $i8                # |        600 |        600 |          0 |          0 |
    b       init_dirvec_constants.3044  # |        600 |        600 |          0 |         12 |
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i9)
# $ra = $ra3
# [$i1 - $i9]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_vecset_constants
init_vecset_constants.3047:
    bge     $i9, 0, bge.28713           # |          6 |          6 |          0 |          4 |
bl.28713:
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
bge.28713:
    load    [ext_dirvecs + $i9], $i7    # |          5 |          5 |          1 |          0 |
    li      119, $i8                    # |          5 |          5 |          0 |          0 |
    jal     init_dirvec_constants.3044, $ra2# |          5 |          5 |          0 |          0 |
    add     $i9, -1, $i9                # |          5 |          5 |          0 |          0 |
    b       init_vecset_constants.3047  # |          5 |          5 |          0 |          2 |
.end init_vecset_constants

######################################################################
# add_reflection($i7, $i8, $f12, $f1, $f3, $f4)
# $ra = $ra2
# [$i1 - $i6, $i9]
# [$f1 - $f11]
# []
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin add_reflection
add_reflection.3051:
    jal     create_dirvec.3037, $ra1    # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i9                    # |          1 |          1 |          0 |          0 |
    store   $f1, [$i9 + 0]              # |          1 |          1 |          0 |          0 |
    store   $f3, [$i9 + 1]              # |          1 |          1 |          0 |          0 |
    store   $f4, [$i9 + 2]              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 3], $i4              # |          1 |          1 |          1 |          0 |
    load    [$i9 + 0], $f1              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 1], $f3              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 2], $f4              # |          1 |          1 |          0 |          0 |
    jal     setup_dirvec_constants.2829, $ra1# |          1 |          1 |          0 |          0 |
    mov     $hp, $i1                    # |          1 |          1 |          0 |          0 |
    store   $i8, [$i1 + 0]              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 0], $i2              # |          1 |          1 |          0 |          0 |
    add     $hp, 6, $hp                 # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 1]              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 1], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 2]              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 2], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 3]              # |          1 |          1 |          0 |          0 |
    load    [$i9 + 3], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 4]              # |          1 |          1 |          0 |          0 |
    store   $f12, [$i1 + 5]             # |          1 |          1 |          0 |          0 |
    store   $i1, [ext_reflections + $i7]# |          1 |          1 |          0 |          0 |
    jr      $ra2                        # |          1 |          1 |          0 |          0 |
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i32]
# [$f1 - $f26]
# [$ig0 - $ig4]
# [$fg0 - $fg19]
# [$fig0 - $fig14]
# [$ra - $ra7]
######################################################################
.align 2
.begin main
ext_main:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |          1 |          1 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |          1 |          1 |          0 |          0 |
    load    [ext_solver_dist + 0], $fg0 # |          1 |          1 |          1 |          0 |
    load    [ext_intersection_point + 0], $fg1# |          1 |          1 |          1 |          0 |
    load    [ext_intersection_point + 2], $fg2# |          1 |          1 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg3# |          1 |          1 |          0 |          0 |
    load    [ext_diffuse_ray + 0], $fg4 # |          1 |          1 |          1 |          0 |
    load    [ext_diffuse_ray + 1], $fg5 # |          1 |          1 |          0 |          0 |
    load    [ext_diffuse_ray + 2], $fg6 # |          1 |          1 |          1 |          0 |
    load    [ext_rgb + 0], $fg7         # |          1 |          1 |          0 |          0 |
    load    [ext_rgb + 1], $fg8         # |          1 |          1 |          0 |          0 |
    load    [ext_rgb + 2], $fg9         # |          1 |          1 |          0 |          0 |
    load    [ext_texture_color + 1], $fg10# |          1 |          1 |          0 |          0 |
    load    [ext_tmin + 0], $fg11       # |          1 |          1 |          0 |          0 |
    load    [ext_texture_color + 2], $fg12# |          1 |          1 |          0 |          0 |
    load    [ext_n_objects + 0], $ig0   # |          1 |          1 |          1 |          0 |
    load    [ext_texture_color + 0], $fg13# |          1 |          1 |          1 |          0 |
    load    [ext_light + 1], $fg14      # |          1 |          1 |          1 |          0 |
    load    [ext_light + 2], $fg15      # |          1 |          1 |          1 |          0 |
    load    [ext_light + 0], $fg16      # |          1 |          1 |          0 |          0 |
    load    [ext_or_net + 0], $ig1      # |          1 |          1 |          0 |          0 |
    load    [ext_startp_fast + 0], $fg17# |          1 |          1 |          1 |          0 |
    load    [ext_startp_fast + 1], $fg18# |          1 |          1 |          0 |          0 |
    load    [ext_startp_fast + 2], $fg19# |          1 |          1 |          0 |          0 |
    load    [ext_intsec_rectside + 0], $ig2# |          1 |          1 |          0 |          0 |
    load    [ext_intersected_object_id + 0], $ig3# |          1 |          1 |          0 |          0 |
    load    [ext_n_reflections + 0], $ig4# |          1 |          1 |          1 |          0 |
    load    [ext_startp + 0], $fig0     # |          1 |          1 |          1 |          0 |
    load    [ext_startp + 1], $fig1     # |          1 |          1 |          0 |          0 |
    load    [ext_startp + 2], $fig2     # |          1 |          1 |          0 |          0 |
    load    [ext_screenz_dir + 0], $fig3# |          1 |          1 |          1 |          0 |
    load    [ext_screenz_dir + 1], $fig4# |          1 |          1 |          0 |          0 |
    load    [ext_screenz_dir + 2], $fig5# |          1 |          1 |          0 |          0 |
    load    [ext_screeny_dir + 0], $fig6# |          1 |          1 |          1 |          0 |
    load    [ext_screeny_dir + 1], $fig7# |          1 |          1 |          0 |          0 |
    load    [ext_screeny_dir + 2], $fig8# |          1 |          1 |          0 |          0 |
    load    [ext_beam + 0], $fig9       # |          1 |          1 |          0 |          0 |
    load    [ext_screen + 0], $fig10    # |          1 |          1 |          1 |          0 |
    load    [ext_screen + 1], $fig11    # |          1 |          1 |          0 |          0 |
    load    [ext_screen + 2], $fig12    # |          1 |          1 |          0 |          0 |
    load    [ext_screenx_dir + 0], $fig13# |          1 |          1 |          0 |          0 |
    load    [ext_screenx_dir + 2], $fig14# |          1 |          1 |          0 |          0 |
    load    [f.27975 + 0], $fc0         # |          1 |          1 |          1 |          0 |
    load    [f.27990 + 0], $fc1         # |          1 |          1 |          1 |          0 |
    load    [f.27977 + 0], $fc2         # |          1 |          1 |          1 |          0 |
    load    [f.27995 + 0], $fc3         # |          1 |          1 |          1 |          0 |
    load    [f.27988 + 0], $fc4         # |          1 |          1 |          0 |          0 |
    load    [f.27984 + 0], $fc5         # |          1 |          1 |          1 |          0 |
    load    [f.27974 + 0], $fc6         # |          1 |          1 |          0 |          0 |
    load    [f.27980 + 0], $fc7         # |          1 |          1 |          1 |          0 |
    load    [f.27982 + 0], $fc8         # |          1 |          1 |          0 |          0 |
    load    [f.27981 + 0], $fc9         # |          1 |          1 |          0 |          0 |
    load    [f.27998 + 0], $fc10        # |          1 |          1 |          1 |          0 |
    load    [f.27997 + 0], $fc11        # |          1 |          1 |          0 |          0 |
    load    [f.27996 + 0], $fc12        # |          1 |          1 |          0 |          0 |
    load    [f.27994 + 0], $fc13        # |          1 |          1 |          0 |          0 |
    load    [f.27993 + 0], $fc14        # |          1 |          1 |          0 |          0 |
    load    [f.27989 + 0], $fc15        # |          1 |          1 |          0 |          0 |
    load    [f.27986 + 0], $fc16        # |          1 |          1 |          0 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i29                   # |          1 |          1 |          0 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i24                   # |          1 |          1 |          0 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i31                   # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig10                 # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig11                 # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig12                 # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.27931], $f9              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f9, $f10              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f9, $f12              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f12, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f13                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f12, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fmul    $f11, $f1, $f2              # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.28100], $f3              # |          1 |          1 |          0 |          0 |
    fmul    $f11, $f13, $f5             # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.28101], $f4              # |          1 |          1 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |          0 |          0 |
    fmul    $f10, $f4, $f4              # |          1 |          1 |          0 |          0 |
    mov     $f2, $fig3                  # |          1 |          1 |          0 |          0 |
    fmul    $f5, $f3, $f3               # |          1 |          1 |          0 |          0 |
    mov     $f4, $fig4                  # |          1 |          1 |          0 |          0 |
    mov     $f3, $fig5                  # |          1 |          1 |          0 |          0 |
    fneg    $f10, $f2                   # |          1 |          1 |          0 |          0 |
    mov     $f13, $fig13                # |          1 |          1 |          0 |          0 |
    fneg    $f1, $f3                    # |          1 |          1 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |          1 |          1 |          0 |          0 |
    mov     $f3, $fig14                 # |          1 |          1 |          0 |          0 |
    fneg    $f11, $f3                   # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig6                  # |          1 |          1 |          0 |          0 |
    mov     $f3, $fig7                  # |          1 |          1 |          0 |          0 |
    fmul    $f2, $f13, $f1              # |          1 |          1 |          0 |          0 |
    mov     $fig10, $f2                 # |          1 |          1 |          0 |          0 |
    mov     $fig3, $f3                  # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig8                  # |          1 |          1 |          0 |          0 |
    fsub    $f2, $f3, $f1               # |          1 |          1 |          0 |          0 |
    mov     $fig11, $f2                 # |          1 |          1 |          0 |          0 |
    mov     $fig4, $f3                  # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_viewpoint + 0]    # |          1 |          1 |          0 |          0 |
    fsub    $f2, $f3, $f1               # |          1 |          1 |          0 |          0 |
    mov     $fig12, $f2                 # |          1 |          1 |          0 |          0 |
    mov     $fig5, $f3                  # |          1 |          1 |          0 |          0 |
    fsub    $f2, $f3, $f2               # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_viewpoint + 1]    # |          1 |          1 |          0 |          0 |
    store   $f2, [ext_viewpoint + 2]    # |          1 |          1 |          0 |          0 |
    call    ext_read_int                # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f9, $f10              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fneg    $f1, $fg14                  # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
    fmul    $f11, $f9, $f9              # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fmul    $f10, $f1, $fg16            # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
    fmul    $f10, $f1, $fg15            # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    mov     $f1, $fig9                  # |          1 |          1 |          0 |          0 |
    li      0, $i6                      # |          1 |          1 |          0 |          0 |
    jal     read_object.2721, $ra1      # |          1 |          1 |          0 |          0 |
    li      0, $i6                      # |          1 |          1 |          0 |          0 |
    jal     read_and_network.2729, $ra1 # |          1 |          1 |          0 |          0 |
    li      0, $i1                      # |          1 |          1 |          0 |          0 |
    call    read_or_network.2727        # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $ig1                   # |          1 |          1 |          0 |          0 |
    li      80, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      54, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      10, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      49, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      50, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      56, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      32, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      49, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      50, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      56, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      32, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      50, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      53, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      53, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      10, $i2                     # |          1 |          1 |          0 |          0 |
    call    ext_write                   # |          1 |          1 |          0 |          0 |
    li      4, $i7                      # |          1 |          1 |          0 |          0 |
    jal     create_dirvecs.3042, $ra3   # |          1 |          1 |          0 |          0 |
    li      9, $i12                     # |          1 |          1 |          0 |          0 |
    li      0, $i13                     # |          1 |          1 |          0 |          0 |
    li      0, $i10                     # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec_rows.3033, $ra3 # |          1 |          1 |          0 |          0 |
    li      4, $i9                      # |          1 |          1 |          0 |          0 |
    jal     init_vecset_constants.3047, $ra3# |          1 |          1 |          0 |          0 |
    store   $fg16, [%{ext_light_dirvec + 0} + 0]# |          1 |          1 |          0 |          0 |
    store   $fg14, [%{ext_light_dirvec + 0} + 1]# |          1 |          1 |          0 |          0 |
    store   $fg15, [%{ext_light_dirvec + 0} + 2]# |          1 |          1 |          0 |          0 |
    load    [ext_light_dirvec + 3], $i4 # |          1 |          1 |          1 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f1# |          1 |          1 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f3# |          1 |          1 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 2], $f4# |          1 |          1 |          0 |          0 |
    jal     setup_dirvec_constants.2829, $ra1# |          1 |          1 |          0 |          0 |
    add     $ig0, -1, $i1               # |          1 |          1 |          0 |          0 |
    bl      $i1, 0, bl.28715            # |          1 |          1 |          0 |          0 |
bge.28715:
    load    [ext_objects + $i1], $i2    # |          1 |          1 |          0 |          0 |
    load    [$i2 + 2], $i3              # |          1 |          1 |          0 |          0 |
    bne     $i3, 2, bl.28715            # |          1 |          1 |          0 |          0 |
be.28716:
    load    [$i2 + 11], $f1             # |          1 |          1 |          1 |          0 |
    ble     $fc0, $f1, bl.28715         # |          1 |          1 |          0 |          0 |
bg.28717:
    load    [$i2 + 1], $i3              # |          1 |          1 |          0 |          0 |
    be      $i3, 1, be.28718            # |          1 |          1 |          0 |          0 |
bne.28718:
    be      $i3, 2, be.28719            # |          1 |          1 |          0 |          1 |
bl.28715:
.count load_float
    load    [f.28102], $f1
    li      0, $i26
    li      127, $i25
    mov     $fig6, $f2
    fmul    $f1, $f2, $f2
    mov     $fig3, $f3
    mov     $fig7, $f4
    fadd    $f2, $f3, $f24
    mov     $fig8, $f5
    fmul    $f1, $f4, $f2
    fmul    $f1, $f5, $f1
    mov     $fig4, $f3
    mov     $fig5, $f4
    fadd    $f2, $f3, $f25
    fadd    $f1, $f4, $f26
    jal     pretrace_pixels.2983, $ra6
    li      0, $i28
    li      2, $i32
.count move_args
    mov     $i24, $i30
    jal     scan_line.3000, $ra7
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
be.28719:
    add     $i1, $i1, $i1               # |          1 |          1 |          0 |          0 |
    fsub    $fc0, $f1, $f12             # |          1 |          1 |          0 |          0 |
    add     $i1, $i1, $i1               # |          1 |          1 |          0 |          0 |
    load    [$i2 + 4], $f1              # |          1 |          1 |          0 |          0 |
    load    [$i2 + 5], $f2              # |          1 |          1 |          0 |          0 |
    add     $i1, 1, $i8                 # |          1 |          1 |          0 |          0 |
    fmul    $fg16, $f1, $f3             # |          1 |          1 |          0 |          0 |
    load    [$i2 + 6], $f5              # |          1 |          1 |          0 |          0 |
    fmul    $fg14, $f2, $f4             # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.27976], $f6              # |          1 |          1 |          1 |          0 |
    fadd    $f3, $f4, $f3               # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $ig4, $i7                   # |          1 |          1 |          0 |          0 |
    fmul    $fg15, $f5, $f4             # |          1 |          1 |          0 |          0 |
    fmul    $f6, $f1, $f1               # |          1 |          1 |          0 |          0 |
    fmul    $f6, $f2, $f2               # |          1 |          1 |          0 |          0 |
    fadd    $f3, $f4, $f3               # |          1 |          1 |          0 |          0 |
    fmul    $f6, $f5, $f4               # |          1 |          1 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f3, $f1               # |          1 |          1 |          0 |          0 |
    fmul    $f4, $f3, $f3               # |          1 |          1 |          0 |          0 |
    fsub    $f2, $fg14, $f2             # |          1 |          1 |          0 |          0 |
    fsub    $f1, $fg16, $f1             # |          1 |          1 |          0 |          0 |
    fsub    $f3, $fg15, $f4             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f2, $f3                    # |          1 |          1 |          0 |          0 |
    jal     add_reflection.3051, $ra2   # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.28102], $f1              # |          1 |          1 |          1 |          0 |
    add     $ig4, 1, $ig4               # |          1 |          1 |          0 |          0 |
    mov     $fig6, $f2                  # |          1 |          1 |          0 |          0 |
    li      0, $i26                     # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f2, $f2               # |          1 |          1 |          0 |          0 |
    li      127, $i25                   # |          1 |          1 |          0 |          0 |
    mov     $fig3, $f3                  # |          1 |          1 |          0 |          0 |
    mov     $fig7, $f4                  # |          1 |          1 |          0 |          0 |
    fadd    $f2, $f3, $f24              # |          1 |          1 |          0 |          0 |
    mov     $fig8, $f5                  # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f4, $f2               # |          1 |          1 |          0 |          0 |
    fmul    $f1, $f5, $f1               # |          1 |          1 |          0 |          0 |
    mov     $fig4, $f3                  # |          1 |          1 |          0 |          0 |
    mov     $fig5, $f4                  # |          1 |          1 |          0 |          0 |
    fadd    $f2, $f3, $f25              # |          1 |          1 |          0 |          0 |
    fadd    $f1, $f4, $f26              # |          1 |          1 |          0 |          0 |
    jal     pretrace_pixels.2983, $ra6  # |          1 |          1 |          0 |          0 |
    li      0, $i28                     # |          1 |          1 |          0 |          0 |
    li      2, $i32                     # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i24, $i30                  # |          1 |          1 |          0 |          0 |
    jal     scan_line.3000, $ra7        # |          1 |          1 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |          0 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |          0 |          0 |
    li      0, $i1                      # |          1 |          1 |          0 |          0 |
    ret                                 # |          1 |          1 |          0 |          0 |
be.28718:
    add     $i1, $i1, $i1
    load    [$i2 + 11], $f1
    add     $i1, $i1, $i10
    fneg    $fg16, $f13
    fsub    $fc0, $f1, $f12
    add     $i10, 1, $i8
    fneg    $fg14, $f14
.count move_args
    mov     $ig4, $i7
    fneg    $fg15, $f15
.count move_args
    mov     $fg16, $f1
.count move_args
    mov     $f14, $f3
.count move_args
    mov     $f15, $f4
    jal     add_reflection.3051, $ra2
.count move_args
    mov     $f13, $f1
    add     $ig4, 1, $i7
.count move_args
    mov     $fg14, $f3
    add     $i10, 2, $i8
.count move_args
    mov     $f15, $f4
    jal     add_reflection.3051, $ra2
.count move_args
    mov     $f13, $f1
    add     $ig4, 2, $i7
.count move_args
    mov     $f14, $f3
    add     $i10, 3, $i8
.count move_args
    mov     $fg15, $f4
    jal     add_reflection.3051, $ra2
.count load_float
    load    [f.28102], $f1
    add     $ig4, 3, $ig4
    mov     $fig6, $f2
    li      0, $i26
    fmul    $f1, $f2, $f2
    li      127, $i25
    mov     $fig3, $f3
    mov     $fig7, $f4
    fadd    $f2, $f3, $f24
    mov     $fig8, $f5
    fmul    $f1, $f4, $f2
    fmul    $f1, $f5, $f1
    mov     $fig4, $f3
    mov     $fig5, $f4
    fadd    $f2, $f3, $f25
    fadd    $f1, $f4, $f26
    jal     pretrace_pixels.2983, $ra6
    li      0, $i28
    li      2, $i32
.count move_args
    mov     $i24, $i30
    jal     scan_line.3000, $ra7
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
.end main
                                        # | Instructions | Clocks     | DCacheMiss | BranchMiss |
