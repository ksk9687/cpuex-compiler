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
#######################################################################
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

######################################################################
# $f1 = floor($f2)
# $ra = $ra
# []
# [$f1 - $f3]
######################################################################
.begin floor
ext_floor:
    mov $f2, $f1                        # |    194,060 |    194,060 |          0 |          0 |
    bge $f1, $f0, FLOOR_POSITIVE        # |    194,060 |    194,060 |          0 |     16,746 |
    fneg $f1, $f1                       # |    166,715 |    166,715 |          0 |          0 |
    mov $ra, $tmp                       # |    166,715 |    166,715 |          0 |          0 |
    call FLOOR_POSITIVE                 # |    166,715 |    166,715 |          0 |          0 |
    load [FLOOR_MONE], $f2              # |    166,715 |    166,715 |      6,571 |          0 |
    fsub $f2, $f1, $f1                  # |    166,715 |    166,715 |          0 |          0 |
    jr $tmp                             # |    166,715 |    166,715 |          0 |          0 |
FLOOR_POSITIVE:
    load [FLOAT_MAGICF], $f3            # |    194,060 |    194,060 |      3,190 |          0 |
    ble $f1, $f3, FLOOR_POSITIVE_MAIN   # |    194,060 |    194,060 |          0 |      1,245 |
    ret
FLOOR_POSITIVE_MAIN:
    mov $f1, $f2                        # |    194,060 |    194,060 |          0 |          0 |
    fadd $f1, $f3, $f1                  # |    194,060 |    194,060 |          0 |          0 |
    fsub $f1, $f3, $f1                  # |    194,060 |    194,060 |          0 |          0 |
    ble $f1, $f2, FLOOR_RET             # |    194,060 |    194,060 |          0 |        179 |
    load [FLOOR_ONE], $f2
    fsub $f1, $f2, $f1
FLOOR_RET:
    ret                                 # |    194,060 |    194,060 |          0 |          0 |
.end floor

######################################################################
# $f1 = float_of_int($i2)
# $ra = $ra
# [$i2 - $i4]
# [$f1 - $f3]
######################################################################
.begin float_of_int
ext_float_of_int:
    bge $i2, 0, ITOF_MAIN               # |     16,547 |     16,547 |          0 |      1,786 |
    neg $i2, $i2                        # |      8,255 |      8,255 |          0 |          0 |
    mov $ra, $tmp                       # |      8,255 |      8,255 |          0 |          0 |
    call ITOF_MAIN                      # |      8,255 |      8,255 |          0 |          0 |
    fneg $f1, $f1                       # |      8,255 |      8,255 |          0 |          0 |
    jr $tmp                             # |      8,255 |      8,255 |          0 |          0 |
ITOF_MAIN:
    load [FLOAT_MAGICF], $f2            # |     16,547 |     16,547 |      4,111 |          0 |
    load [FLOAT_MAGICFHX], $i3          # |     16,547 |     16,547 |      5,033 |          0 |
    load [FLOAT_MAGICI], $i4            # |     16,547 |     16,547 |      7,963 |          0 |
    bge $i2, $i4, ITOF_BIG              # |     16,547 |     16,547 |          0 |        173 |
    add $i2, $i3, $i2                   # |     16,547 |     16,547 |          0 |          0 |
    mov $i2, $f1                        # |     16,547 |     16,547 |          0 |          0 |
    fsub $f1, $f2, $f1                  # |     16,547 |     16,547 |          0 |          0 |
    ret                                 # |     16,547 |     16,547 |          0 |          0 |
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
    bge $f2, $f0, FTOI_MAIN             # |     49,152 |     49,152 |          0 |        842 |
    fneg $f2, $f2
    mov $ra, $tmp
    call FTOI_MAIN
    neg $i1, $i1
    jr $tmp
FTOI_MAIN:
    load [FLOAT_MAGICF], $f3            # |     49,152 |     49,152 |        800 |          0 |
    load [FLOAT_MAGICFHX], $i2          # |     49,152 |     49,152 |      1,773 |          0 |
    bge $f2, $f3, FTOI_BIG              # |     49,152 |     49,152 |          0 |         17 |
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
    bg $i2, $i5, read_int_loop          # |      1,300 |      1,300 |          0 |          0 |
    li 0, $i4                           # |      1,300 |      1,300 |          0 |          0 |
sll_loop:
    add $i4, 1, $i4                     # |     10,400 |     10,400 |          0 |          0 |
    sll $i1, $i1                        # |     10,400 |     10,400 |          0 |          0 |
    bl $i4, 8, sll_loop                 # |     10,400 |     10,400 |          0 |        124 |
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
    bg $tmp, 0, ext_write               # |     49,167 |     49,167 |          0 |          5 |
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
    bl $hp, $i2, create_array_loop      # |    103,030 |    103,030 |          0 |      6,155 |
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
#######################################################################
#
#       ↓　ここから math.s
#
######################################################################

.align 2
f._171: .float  1.5707963268E+00
f._170: .float  5.0000000000E-01
f._169: .float  6.2831853072E+00
f._168: .float  1.5915494309E-01
f._167: .float  3.1415926536E+00
f._166: .float  3.0000000000E+00
f._165: .float  1.0500000000E+01
f._164: .float  -1.5707963268E+00
f._163: .float  1.5707963268E+00
f._162: .float  -1.0000000000E+00
f._160: .float  1.0000000000E+00
f._159: .float  2.0000000000E+00
f._158: .float  1.1500000000E+01

.begin atan
######################################################################
# $f1 = atan_sub($f2, $f3)
# $ra = $ra
# []
# [$f1 - $f2, $f4 - $f5]
# []
# []
# [$ra]
######################################################################
ext_atan_sub:
.count load_float
    load    [f._158], $f1               # |     12,000 |     12,000 |          1 |          0 |
    ble     $f1, $f2, ble._182          # |     12,000 |     12,000 |          0 |      2,051 |
bg._182:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |     11,000 |     11,000 |          0 |          0 |
.count stack_move
    add     $sp, -3, $sp                # |     11,000 |     11,000 |          0 |          0 |
.count load_float
    load    [f._159], $f1               # |     11,000 |     11,000 |          1 |          0 |
    fmul    $f2, $f2, $f4               # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     11,000 |     11,000 |          0 |          0 |
.count load_float
    load    [f._160], $f5               # |     11,000 |     11,000 |          0 |          0 |
    fadd    $f2, $f5, $f2               # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f4, $f3, $f4               # |     11,000 |     11,000 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |     11,000 |     11,000 |          0 |          0 |
.count stack_store
    store   $f4, [$sp + 1]              # |     11,000 |     11,000 |          0 |          0 |
.count stack_store
    store   $f1, [$sp + 2]              # |     11,000 |     11,000 |          0 |          0 |
    call    ext_atan_sub                # |     11,000 |     11,000 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     11,000 |     11,000 |          4 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |     11,000 |     11,000 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |     11,000 |     11,000 |          3 |          0 |
    fadd    $f2, $f1, $f1               # |     11,000 |     11,000 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $f2              # |     11,000 |     11,000 |          5 |          0 |
    finv    $f1, $f1                    # |     11,000 |     11,000 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,000 |     11,000 |          0 |          0 |
    ret                                 # |     11,000 |     11,000 |          0 |          0 |
ble._182:
    mov     $f0, $f1                    # |      1,000 |      1,000 |          0 |          0 |
    ret                                 # |      1,000 |      1,000 |          0 |          0 |

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
ext_atan:
.count stack_store_ra
    store   $ra, [$sp - 2]              # |      1,000 |      1,000 |          0 |          0 |
.count stack_move
    add     $sp, -2, $sp                # |      1,000 |      1,000 |          0 |          0 |
    fabs    $f2, $f1                    # |      1,000 |      1,000 |          0 |          0 |
.count stack_store
    store   $f2, [$sp + 1]              # |      1,000 |      1,000 |          0 |          0 |
.count load_float
    load    [f._160], $f6               # |      1,000 |      1,000 |          1 |          0 |
    ble     $f1, $f6, ble._186          # |      1,000 |      1,000 |          0 |          2 |
bg._186:
    finv    $f2, $f1                    # |      1,000 |      1,000 |          0 |          0 |
.count move_args
    mov     $f6, $f2                    # |      1,000 |      1,000 |          0 |          0 |
    mov     $f1, $f7                    # |      1,000 |      1,000 |          0 |          0 |
    fmul    $f7, $f7, $f3               # |      1,000 |      1,000 |          0 |          0 |
    call    ext_atan_sub                # |      1,000 |      1,000 |          0 |          0 |
    fadd    $f6, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      1,000 |      1,000 |          0 |          0 |
.count stack_move
    add     $sp, 2, $sp                 # |      1,000 |      1,000 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |      1,000 |      1,000 |          0 |          0 |
    finv    $f1, $f1                    # |      1,000 |      1,000 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
    ble     $f2, $f6, ble._188          # |      1,000 |      1,000 |          0 |          0 |
.count dual_jmp
    b       bg._188                     # |      1,000 |      1,000 |          0 |          2 |
ble._186:
    mov     $f2, $f7
    fmul    $f7, $f7, $f3
.count move_args
    mov     $f6, $f2
    call    ext_atan_sub
    fadd    $f6, $f1, $f1
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 2, $sp
.count stack_load
    load    [$sp - 1], $f2
    finv    $f1, $f1
    fmul    $f7, $f1, $f1
    bg      $f2, $f6, bg._188
ble._188:
.count load_float
    load    [f._162], $f3
    ble     $f3, $f2, bge._191
bg._189:
    add     $i0, -1, $i1
    bg      $i1, 0, bg._188
ble._190:
    bge     $i1, 0, bge._191
bl._191:
.count load_float
    load    [f._164], $f2
    fsub    $f2, $f1, $f1
    ret     
bge._191:
    ret     
bg._188:
.count load_float
    load    [f._163], $f2               # |      1,000 |      1,000 |          0 |          0 |
    fsub    $f2, $f1, $f1               # |      1,000 |      1,000 |          0 |          0 |
    ret                                 # |      1,000 |      1,000 |          0 |          0 |
.end atan

.begin sin
######################################################################
# $f1 = tan_sub($f2, $f3)
# $ra = $ra
# []
# [$f1 - $f2, $f4]
# []
# []
# [$ra]
######################################################################
ext_tan_sub:
.count load_float
    load    [f._165], $f4               # |     24,470 |     24,470 |      2,115 |          0 |
    ble     $f2, $f4, ble._192          # |     24,470 |     24,470 |          0 |      2,202 |
bg._192:
    mov     $f0, $f1                    # |      4,894 |      4,894 |          0 |          0 |
    ret                                 # |      4,894 |      4,894 |          0 |          0 |
ble._192:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |     19,576 |     19,576 |          0 |          0 |
.count stack_move
    add     $sp, -3, $sp                # |     19,576 |     19,576 |          0 |          0 |
.count stack_store
    store   $f3, [$sp + 1]              # |     19,576 |     19,576 |          0 |          0 |
.count stack_store
    store   $f2, [$sp + 2]              # |     19,576 |     19,576 |          0 |          0 |
.count load_float
    load    [f._159], $f1               # |     19,576 |     19,576 |          0 |          0 |
    fadd    $f2, $f1, $f2               # |     19,576 |     19,576 |          0 |          0 |
    call    ext_tan_sub                 # |     19,576 |     19,576 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     19,576 |     19,576 |      4,210 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |     19,576 |     19,576 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |     19,576 |     19,576 |      4,858 |          0 |
    fsub    $f2, $f1, $f1               # |     19,576 |     19,576 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $f2              # |     19,576 |     19,576 |      4,256 |          0 |
    finv    $f1, $f1                    # |     19,576 |     19,576 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     19,576 |     19,576 |          0 |          0 |
    ret                                 # |     19,576 |     19,576 |          0 |          0 |

######################################################################
# $f1 = tan($f2)
# $ra = $ra
# []
# [$f1 - $f5]
# []
# []
# [$ra]
######################################################################
ext_tan:
.count stack_store_ra
    store   $ra, [$sp - 2]              # |      4,894 |      4,894 |          0 |          0 |
.count stack_move
    add     $sp, -2, $sp                # |      4,894 |      4,894 |          0 |          0 |
    fmul    $f2, $f2, $f3               # |      4,894 |      4,894 |          0 |          0 |
.count stack_store
    store   $f2, [$sp + 1]              # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._166], $f1               # |      4,894 |      4,894 |      1,865 |          0 |
.count load_float
    load    [f._160], $f5               # |      4,894 |      4,894 |        856 |          0 |
.count move_args
    mov     $f1, $f2                    # |      4,894 |      4,894 |          0 |          0 |
    call    ext_tan_sub                 # |      4,894 |      4,894 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |      4,894 |      4,894 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      4,894 |      4,894 |      1,628 |          0 |
.count stack_move
    add     $sp, 2, $sp                 # |      4,894 |      4,894 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $f2              # |      4,894 |      4,894 |      1,568 |          0 |
    finv    $f1, $f1                    # |      4,894 |      4,894 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      4,894 |      4,894 |          0 |          0 |
    ret                                 # |      4,894 |      4,894 |          0 |          0 |

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
ext_sin:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |      4,894 |      4,894 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._167], $f4               # |      4,894 |      4,894 |      1,763 |          0 |
    fabs    $f2, $f5                    # |      4,894 |      4,894 |          0 |          0 |
.count load_float
    load    [f._168], $f1               # |      4,894 |      4,894 |      1,827 |          0 |
    ble     $f2, $f0, ble._198          # |      4,894 |      4,894 |          0 |        676 |
bg._198:
    li      1, $i1                      # |      4,394 |      4,394 |          0 |          0 |
    fmul    $f5, $f1, $f2               # |      4,394 |      4,394 |          0 |          0 |
    call    ext_floor                   # |      4,394 |      4,394 |          0 |          0 |
.count load_float
    load    [f._169], $f2               # |      4,394 |      4,394 |      1,837 |          0 |
    fmul    $f2, $f1, $f1               # |      4,394 |      4,394 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |      4,394 |      4,394 |          0 |          0 |
    ble     $f1, $f4, ble._199          # |      4,394 |      4,394 |          0 |      1,080 |
.count dual_jmp
    b       bg._199                     # |      1,343 |      1,343 |          0 |          1 |
ble._198:
    li      0, $i1                      # |        500 |        500 |          0 |          0 |
    fmul    $f5, $f1, $f2               # |        500 |        500 |          0 |          0 |
    call    ext_floor                   # |        500 |        500 |          0 |          0 |
.count load_float
    load    [f._169], $f2               # |        500 |        500 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |        500 |        500 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |        500 |        500 |          0 |          0 |
    ble     $f1, $f4, ble._199          # |        500 |        500 |          0 |          2 |
bg._199:
.count load_float
    load    [f._163], $f5               # |      1,343 |      1,343 |        935 |          0 |
    be      $i1, 0, be._200             # |      1,343 |      1,343 |          0 |          0 |
.count dual_jmp
    b       bne._200                    # |      1,343 |      1,343 |          0 |          2 |
ble._199:
.count load_float
    load    [f._163], $f5               # |      3,551 |      3,551 |      1,175 |          0 |
    be      $i1, 0, bne._200            # |      3,551 |      3,551 |          0 |      1,476 |
be._200:
.count load_float
    load    [f._160], $f6               # |      3,051 |      3,051 |      1,065 |          0 |
.count load_float
    load    [f._159], $f7               # |      3,051 |      3,051 |      1,040 |          0 |
.count load_float
    load    [f._170], $f3               # |      3,051 |      3,051 |      1,118 |          0 |
    ble     $f1, $f4, ble._202          # |      3,051 |      3,051 |          0 |        103 |
.count dual_jmp
    b       bg._202
bne._200:
.count load_float
    load    [f._162], $f6               # |      1,843 |      1,843 |      1,023 |          0 |
.count load_float
    load    [f._159], $f7               # |      1,843 |      1,843 |        842 |          0 |
.count load_float
    load    [f._170], $f3               # |      1,843 |      1,843 |        890 |          0 |
    ble     $f1, $f4, ble._202          # |      1,843 |      1,843 |          0 |          0 |
bg._202:
    fsub    $f2, $f1, $f1               # |      1,343 |      1,343 |          0 |          0 |
    ble     $f1, $f5, ble._203          # |      1,343 |      1,343 |          0 |        371 |
.count dual_jmp
    b       bg._203                     # |        394 |        394 |          0 |          2 |
ble._202:
    ble     $f1, $f5, ble._203          # |      3,551 |      3,551 |          0 |      1,401 |
bg._203:
    fsub    $f4, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f3, $f2               # |      1,545 |      1,545 |          0 |          0 |
    call    ext_tan                     # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f1, $f2               # |      1,545 |      1,545 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      1,545 |      1,545 |        648 |          0 |
.count load_float
    load    [f._160], $f3               # |      1,545 |      1,545 |          0 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |      1,545 |      1,545 |          0 |          0 |
    finv    $f2, $f2                    # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      1,545 |      1,545 |          0 |          0 |
    fmul    $f6, $f1, $f1               # |      1,545 |      1,545 |          0 |          0 |
    ret                                 # |      1,545 |      1,545 |          0 |          0 |
ble._203:
    fmul    $f1, $f3, $f2               # |      3,349 |      3,349 |          0 |          0 |
    call    ext_tan                     # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f1, $f1, $f2               # |      3,349 |      3,349 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |      3,349 |      3,349 |      1,014 |          0 |
.count load_float
    load    [f._160], $f3               # |      3,349 |      3,349 |          0 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |      3,349 |      3,349 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |      3,349 |      3,349 |          0 |          0 |
    finv    $f2, $f2                    # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,349 |      3,349 |          0 |          0 |
    fmul    $f6, $f1, $f1               # |      3,349 |      3,349 |          0 |          0 |
    ret                                 # |      3,349 |      3,349 |          0 |          0 |
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i1]
# [$f1 - $f7]
# []
# []
# [$ra]
######################################################################
.begin cos
ext_cos:
.count load_float
    load    [f._171], $f1               # |      1,004 |      1,004 |          1 |          0 |
    fsub    $f1, $f2, $f2               # |      1,004 |      1,004 |          0 |          0 |
    b       ext_sin                     # |      1,004 |      1,004 |          0 |          6 |
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
.define $ig0 $i46
.define $i46 orz
.define $ig1 $i47
.define $i47 orz
.define $ig2 $i48
.define $i48 orz
.define $ig3 $i49
.define $i49 orz
.define $ig4 $i50
.define $i50 orz
.define $fg0 $f22
.define $f22 orz
.define $fg1 $f23
.define $f23 orz
.define $fg2 $f24
.define $f24 orz
.define $fg3 $f25
.define $f25 orz
.define $fg4 $f26
.define $f26 orz
.define $fg5 $f27
.define $f27 orz
.define $fg6 $f28
.define $f28 orz
.define $fg7 $f29
.define $f29 orz
.define $fg8 $f30
.define $f30 orz
.define $fg9 $f31
.define $f31 orz
.define $fg10 $f32
.define $f32 orz
.define $fg11 $f33
.define $f33 orz
.define $fg12 $f34
.define $f34 orz
.define $fg13 $f35
.define $f35 orz
.define $fg14 $f36
.define $f36 orz
.define $fg15 $f37
.define $f37 orz
.define $fg16 $f38
.define $f38 orz
.define $fg17 $f39
.define $f39 orz
.define $fg18 $f40
.define $f40 orz
.define $fg19 $f41
.define $f41 orz
.define $fg20 $f42
.define $f42 orz
.define $fg21 $f43
.define $f43 orz
.define $fc0 $f44
.define $f44 orz
.define $fc1 $f45
.define $f45 orz
.define $fc2 $f46
.define $f46 orz
.define $fc3 $f47
.define $f47 orz
.define $fc4 $f48
.define $f48 orz
.define $fc5 $f49
.define $f49 orz
.define $fc6 $f50
.define $f50 orz
.define $fc7 $f51
.define $f51 orz
.define $fc8 $f52
.define $f52 orz
.define $fc9 $f53
.define $f53 orz
.define $fc10 $f54
.define $f54 orz
.define $fc11 $f55
.define $f55 orz
.define $fc12 $f56
.define $f56 orz
.define $fc13 $f57
.define $f57 orz
.define $fc14 $f58
.define $f58 orz
.define $fc15 $f59
.define $f59 orz
.define $fc16 $f60
.define $f60 orz
.define $fc17 $f61
.define $f61 orz
.define $fc18 $f62
.define $f62 orz
.define $fc19 $f63
.define $f63 orz
.define $ra1 $i51
.define $i51 orz
.define $ra2 $i52
.define $i52 orz
.define $ra3 $i53
.define $i53 orz
.define $ra4 $i54
.define $i54 orz
.define $ra5 $i55
.define $i55 orz
.define $ra6 $i56
.define $i56 orz
.define $ra7 $i57
.define $i57 orz
.define $ra8 $i58
.define $i58 orz
.define $ra9 $i59
.define $i59 orz
f.22102:    .float  -6.4000000000E+01
f.22101:    .float  -2.0000000000E+02
f.22100:    .float  2.0000000000E+02
f.22080:    .float  -5.0000000000E-01
f.22079:    .float  7.0000000000E-01
f.22078:    .float  -3.0000000000E-01
f.22077:    .float  -1.0000000000E-01
f.22076:    .float  9.0000000000E-01
f.22075:    .float  2.0000000000E-01
f.22005:    .float  1.5000000000E+02
f.22004:    .float  -1.5000000000E+02
f.22003:    .float  6.6666666667E-03
f.22002:    .float  -6.6666666667E-03
f.22001:    .float  -2.0000000000E+00
f.22000:    .float  3.9062500000E-03
f.21999:    .float  2.5600000000E+02
f.21998:    .float  1.0000000000E+08
f.21997:    .float  1.0000000000E+09
f.21996:    .float  1.0000000000E+01
f.21995:    .float  2.0000000000E+01
f.21994:    .float  5.0000000000E-02
f.21993:    .float  2.5000000000E-01
f.21992:    .float  2.5500000000E+02
f.21991:    .float  1.0000000000E-01
f.21990:    .float  8.5000000000E+02
f.21989:    .float  1.5000000000E-01
f.21988:    .float  9.5492964444E+00
f.21987:    .float  3.1830988148E-01
f.21986:    .float  3.1415927000E+00
f.21985:    .float  3.0000000000E+01
f.21984:    .float  1.5000000000E+01
f.21983:    .float  1.0000000000E-04
f.21982:    .float  -1.0000000000E-01
f.21981:    .float  1.0000000000E-02
f.21980:    .float  -2.0000000000E-01
f.21979:    .float  5.0000000000E-01
f.21978:    .float  1.0000000000E+00
f.21977:    .float  -1.0000000000E+00
f.21976:    .float  2.0000000000E+00
f.21933:    .float  1.7453293000E-02

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i5, $i7 - $i15]
# [$f1 - $f21]
# []
# []
# [$ra]
######################################################################
.align 2
.begin read_nth_object
read_nth_object.2719:
    call    ext_read_int                # |         18 |         18 |          0 |          0 |
.count move_ret
    mov     $i1, $i7                    # |         18 |         18 |          0 |          0 |
    be      $i7, -1, be.22113           # |         18 |         18 |          0 |          1 |
bne.22113:
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i8                    # |         17 |         17 |          0 |          0 |
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i9                    # |         17 |         17 |          0 |          0 |
    call    ext_read_int                # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i10                   # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
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
.count move_ret
    mov     $f1, $f3                    # |         17 |         17 |          0 |          0 |
    li      2, $i2                      # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i13                   # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i13 + 0]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i13 + 1]             # |         17 |         17 |          0 |          0 |
    li      3, $i2                      # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i14                   # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i14 + 0]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i14 + 1]             # |         17 |         17 |          0 |          0 |
    call    ext_read_float              # |         17 |         17 |          0 |          0 |
    store   $f1, [$i14 + 2]             # |         17 |         17 |          0 |          0 |
    li      3, $i2                      # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
.count move_ret
    mov     $i1, $i15                   # |         17 |         17 |          0 |          0 |
    be      $i10, 0, be.22114           # |         17 |         17 |          0 |          2 |
bne.22114:
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 0]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 1]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    li      4, $i2
.count move_args
    mov     $f0, $f2
    store   $f1, [$i15 + 2]
    call    ext_create_array_float
    ble     $f0, $f3, ble.22115
.count dual_jmp
    b       bg.22115
be.22114:
    li      4, $i2                      # |         17 |         17 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |          0 |          0 |
    call    ext_create_array_float      # |         17 |         17 |          0 |          0 |
    ble     $f0, $f3, ble.22115         # |         17 |         17 |          0 |          6 |
bg.22115:
    li      1, $i2                      # |          2 |          2 |          0 |          0 |
    be      $i8, 2, be.22116            # |          2 |          2 |          0 |          0 |
.count dual_jmp
    b       bne.22116                   # |          2 |          2 |          0 |          2 |
ble.22115:
    li      0, $i2                      # |         15 |         15 |          0 |          0 |
    be      $i8, 2, be.22116            # |         15 |         15 |          0 |          3 |
bne.22116:
    mov     $hp, $i4                    # |         15 |         15 |          0 |          0 |
    mov     $i2, $i3                    # |         15 |         15 |          0 |          0 |
    store   $i7, [$i4 + 0]              # |         15 |         15 |          0 |          0 |
    add     $hp, 23, $hp                # |         15 |         15 |          0 |          0 |
    store   $i8, [$i4 + 1]              # |         15 |         15 |          0 |          0 |
    store   $i9, [$i4 + 2]              # |         15 |         15 |          0 |          0 |
    store   $i10, [$i4 + 3]             # |         15 |         15 |          0 |          0 |
    load    [$i11 + 0], $i5             # |         15 |         15 |         15 |          0 |
    store   $i5, [$i4 + 4]              # |         15 |         15 |          0 |          0 |
    load    [$i11 + 1], $i5             # |         15 |         15 |         15 |          0 |
    store   $i5, [$i4 + 5]              # |         15 |         15 |          0 |          0 |
    load    [$i11 + 2], $i5             # |         15 |         15 |         15 |          0 |
    add     $i4, 4, $i11                # |         15 |         15 |          0 |          0 |
    store   $i5, [$i4 + 6]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 0], $i5             # |         15 |         15 |         15 |          0 |
    store   $i5, [$i4 + 7]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 1], $i5             # |         15 |         15 |         15 |          0 |
    store   $i5, [$i4 + 8]              # |         15 |         15 |          0 |          0 |
    load    [$i12 + 2], $i5             # |         15 |         15 |         15 |          0 |
    store   $i5, [$i4 + 9]              # |         15 |         15 |          0 |          0 |
    store   $i3, [$i4 + 10]             # |         15 |         15 |          0 |          0 |
    load    [$i13 + 0], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 11]             # |         15 |         15 |          0 |          0 |
    load    [$i13 + 1], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 12]             # |         15 |         15 |          0 |          0 |
    load    [$i14 + 0], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 13]             # |         15 |         15 |          0 |          0 |
    load    [$i14 + 1], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 14]             # |         15 |         15 |          0 |          0 |
    load    [$i14 + 2], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 15]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 0], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 16]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 1], $i3             # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 17]             # |         15 |         15 |          0 |          0 |
    load    [$i15 + 2], $i3             # |         15 |         15 |         15 |          0 |
    add     $i4, 16, $i15               # |         15 |         15 |          0 |          0 |
    store   $i3, [$i4 + 18]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 0], $i3              # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 19]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 1], $i3              # |         15 |         15 |         15 |          0 |
    store   $i3, [$i4 + 20]             # |         15 |         15 |          0 |          0 |
    load    [$i1 + 2], $i3              # |         15 |         15 |         15 |          0 |
    add     $i4, 19, $i1                # |         15 |         15 |          0 |          0 |
    store   $i3, [$i4 + 21]             # |         15 |         15 |          0 |          0 |
    store   $i1, [$i4 + 22]             # |         15 |         15 |          0 |          0 |
    store   $i4, [ext_objects + $i6]    # |         15 |         15 |          0 |          0 |
    be      $i8, 3, be.22117            # |         15 |         15 |          0 |         10 |
.count dual_jmp
    b       bne.22117                   # |          6 |          6 |          0 |          2 |
be.22116:
    mov     $hp, $i4                    # |          2 |          2 |          0 |          0 |
    store   $i7, [$i4 + 0]              # |          2 |          2 |          0 |          0 |
    li      1, $i3                      # |          2 |          2 |          0 |          0 |
    store   $i8, [$i4 + 1]              # |          2 |          2 |          0 |          0 |
    add     $hp, 23, $hp                # |          2 |          2 |          0 |          0 |
    store   $i9, [$i4 + 2]              # |          2 |          2 |          0 |          0 |
    store   $i10, [$i4 + 3]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 0], $i5             # |          2 |          2 |          2 |          0 |
    store   $i5, [$i4 + 4]              # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $i5             # |          2 |          2 |          2 |          0 |
    store   $i5, [$i4 + 5]              # |          2 |          2 |          0 |          0 |
    load    [$i11 + 2], $i5             # |          2 |          2 |          2 |          0 |
    add     $i4, 4, $i11                # |          2 |          2 |          0 |          0 |
    store   $i5, [$i4 + 6]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 0], $i5             # |          2 |          2 |          2 |          0 |
    store   $i5, [$i4 + 7]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 1], $i5             # |          2 |          2 |          2 |          0 |
    store   $i5, [$i4 + 8]              # |          2 |          2 |          0 |          0 |
    load    [$i12 + 2], $i5             # |          2 |          2 |          2 |          0 |
    store   $i5, [$i4 + 9]              # |          2 |          2 |          0 |          0 |
    store   $i3, [$i4 + 10]             # |          2 |          2 |          0 |          0 |
    load    [$i13 + 0], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 11]             # |          2 |          2 |          0 |          0 |
    load    [$i13 + 1], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 12]             # |          2 |          2 |          0 |          0 |
    load    [$i14 + 0], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 13]             # |          2 |          2 |          0 |          0 |
    load    [$i14 + 1], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 14]             # |          2 |          2 |          0 |          0 |
    load    [$i14 + 2], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 15]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 0], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 16]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 1], $i3             # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 17]             # |          2 |          2 |          0 |          0 |
    load    [$i15 + 2], $i3             # |          2 |          2 |          2 |          0 |
    add     $i4, 16, $i15               # |          2 |          2 |          0 |          0 |
    store   $i3, [$i4 + 18]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 0], $i3              # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 19]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 1], $i3              # |          2 |          2 |          2 |          0 |
    store   $i3, [$i4 + 20]             # |          2 |          2 |          0 |          0 |
    load    [$i1 + 2], $i3              # |          2 |          2 |          2 |          0 |
    add     $i4, 19, $i1                # |          2 |          2 |          0 |          0 |
    store   $i3, [$i4 + 21]             # |          2 |          2 |          0 |          0 |
    store   $i1, [$i4 + 22]             # |          2 |          2 |          0 |          0 |
    store   $i4, [ext_objects + $i6]    # |          2 |          2 |          0 |          0 |
    bne     $i8, 3, bne.22117           # |          2 |          2 |          0 |          2 |
be.22117:
    load    [$i11 + 0], $f1             # |          9 |          9 |          9 |          0 |
    be      $f1, $f0, be.22119          # |          9 |          9 |          0 |          2 |
bne.22118:
    bne     $f1, $f0, bne.22119         # |          7 |          7 |          0 |          2 |
be.22119:
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          2 |          2 |          2 |          0 |
    be      $f1, $f0, be.22122          # |          2 |          2 |          0 |          0 |
.count dual_jmp
    b       bne.22121                   # |          2 |          2 |          0 |          2 |
bne.22119:
    ble     $f1, $f0, ble.22120         # |          7 |          7 |          0 |          0 |
bg.22120:
    fmul    $f1, $f1, $f1               # |          7 |          7 |          0 |          0 |
    finv    $f1, $f1                    # |          7 |          7 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          7 |          7 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          7 |          7 |          7 |          0 |
    be      $f1, $f0, be.22122          # |          7 |          7 |          0 |          0 |
.count dual_jmp
    b       bne.22121                   # |          7 |          7 |          0 |          2 |
ble.22120:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    be      $f1, $f0, be.22122
bne.22121:
    bne     $f1, $f0, bne.22122         # |          9 |          9 |          0 |          4 |
be.22122:
    mov     $f0, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.22125
.count dual_jmp
    b       bne.22124
bne.22122:
    ble     $f1, $f0, ble.22123         # |          9 |          9 |          0 |          0 |
bg.22123:
    fmul    $f1, $f1, $f1               # |          9 |          9 |          0 |          0 |
    finv    $f1, $f1                    # |          9 |          9 |          0 |          0 |
    store   $f1, [$i11 + 1]             # |          9 |          9 |          0 |          0 |
    load    [$i11 + 2], $f1             # |          9 |          9 |          9 |          0 |
    be      $f1, $f0, be.22125          # |          9 |          9 |          0 |          0 |
.count dual_jmp
    b       bne.22124                   # |          9 |          9 |          0 |          4 |
ble.22123:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.22125
bne.22124:
    bne     $f1, $f0, bne.22125         # |          9 |          9 |          0 |          4 |
be.22125:
    mov     $f0, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
.count dual_jmp
    b       bne.22133
bne.22125:
    ble     $f1, $f0, ble.22126         # |          9 |          9 |          0 |          0 |
bg.22126:
    fmul    $f1, $f1, $f1               # |          9 |          9 |          0 |          0 |
    finv    $f1, $f1                    # |          9 |          9 |          0 |          0 |
    store   $f1, [$i11 + 2]             # |          9 |          9 |          0 |          0 |
    be      $i10, 0, be.22133           # |          9 |          9 |          0 |          4 |
.count dual_jmp
    b       bne.22133
ble.22126:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
.count dual_jmp
    b       bne.22133
bne.22117:
    be      $i8, 2, be.22128            # |          8 |          8 |          0 |          2 |
bne.22128:
    be      $i10, 0, be.22133           # |          6 |          6 |          0 |          2 |
.count dual_jmp
    b       bne.22133
be.22128:
    load    [$i11 + 0], $f1             # |          2 |          2 |          2 |          0 |
    load    [$i11 + 1], $f2             # |          2 |          2 |          2 |          0 |
    fmul    $f1, $f1, $f3               # |          2 |          2 |          0 |          0 |
    load    [$i11 + 2], $f4             # |          2 |          2 |          2 |          0 |
    fmul    $f2, $f2, $f2               # |          2 |          2 |          0 |          0 |
    fmul    $f4, $f4, $f4               # |          2 |          2 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |          2 |          2 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |          2 |          2 |          0 |          0 |
    fsqrt   $f2, $f2                    # |          2 |          2 |          0 |          0 |
    be      $i2, 0, be.22129            # |          2 |          2 |          0 |          2 |
bne.22129:
    be      $f2, $f0, be.22130
bne.22783:
    finv    $f2, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
.count dual_jmp
    b       bne.22133
be.22129:
    be      $f2, $f0, be.22130          # |          2 |          2 |          0 |          0 |
bne.22784:
    finv_n  $f2, $f2                    # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 1], $f1             # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |          0 |          0 |
    load    [$i11 + 2], $f1             # |          2 |          2 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |          0 |          0 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |          0 |          0 |
    be      $i10, 0, be.22133           # |          2 |          2 |          0 |          2 |
.count dual_jmp
    b       bne.22133
be.22130:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.22133
bne.22133:
    load    [$i15 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f8
    load    [$i15 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f9
    load    [$i15 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f10
    load    [$i15 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f11
    load    [$i15 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f12
    load    [$i15 + 2], $f2
    call    ext_sin
    fmul    $f9, $f11, $f2
    load    [$i11 + 0], $f4
    fmul    $f10, $f12, $f3
    load    [$i11 + 1], $f6
    fmul    $f10, $f1, $f5
    load    [$i11 + 2], $f16
    fneg    $f11, $f7
    li      1, $i1
    fmul    $f3, $f3, $f13
    fmul    $f7, $f7, $f14
    fmul    $f5, $f5, $f15
    fmul    $f2, $f12, $f17
    fmul    $f4, $f13, $f13
    fmul    $f16, $f14, $f14
    fmul    $f6, $f15, $f15
    fmul    $f8, $f1, $f18
    fmul    $f2, $f1, $f2
    fmul    $f8, $f12, $f19
    fmul    $f8, $f11, $f11
    fadd    $f13, $f15, $f13
    fsub    $f17, $f18, $f15
    fmul    $f9, $f10, $f17
    fadd    $f2, $f19, $f2
    fmul    $f11, $f12, $f18
    fadd    $f13, $f14, $f13
    store   $f13, [$i11 + 0]
    fmul    $f15, $f15, $f14
    fmul    $f17, $f17, $f19
    fmul    $f2, $f2, $f20
    fmul    $f9, $f1, $f21
    fmul    $f4, $f14, $f13
    fmul    $f16, $f19, $f14
    fmul    $f6, $f20, $f19
    fadd    $f18, $f21, $f18
    fmul    $f11, $f1, $f1
    fmul    $f9, $f12, $f9
    fmul    $f8, $f10, $f8
    fadd    $f13, $f19, $f10
    fmul    $f18, $f18, $f11
    fmul    $f4, $f15, $f12
    fsub    $f1, $f9, $f1
    fmul    $f8, $f8, $f9
    fadd    $f10, $f14, $f10
    store   $f10, [$i11 + 1]
    fmul    $f4, $f11, $f11
    fmul    $f12, $f18, $f12
    fmul    $f1, $f1, $f13
    fmul    $f16, $f9, $f9
    fmul    $f6, $f2, $f10
    fmul    $f16, $f17, $f14
    fmul    $f6, $f13, $f13
    fmul    $f4, $f3, $f3
    fmul    $f6, $f5, $f4
    fmul    $f10, $f1, $f5
    fmul    $f14, $f8, $f6
    fadd    $f11, $f13, $f10
    fmul    $f3, $f18, $f11
    fmul    $f4, $f1, $f1
    fadd    $f12, $f5, $f5
    fmul    $f16, $f7, $f7
    fadd    $f10, $f9, $f9
    store   $f9, [$i11 + 2]
    fmul    $f3, $f15, $f3
    fmul    $f4, $f2, $f2
    fadd    $f5, $f6, $f4
    fadd    $f11, $f1, $f1
    fmul    $f7, $f8, $f5
    fadd    $f3, $f2, $f2
    fmul    $f7, $f17, $f3
    fmul    $fc7, $f4, $f4
    fadd    $f1, $f5, $f1
    store   $f4, [$i15 + 0]
    fadd    $f2, $f3, $f2
    fmul    $fc7, $f1, $f1
    fmul    $fc7, $f2, $f2
    store   $f1, [$i15 + 1]
    store   $f2, [$i15 + 2]
    jr      $ra1
be.22133:
    li      1, $i1                      # |         17 |         17 |          0 |          0 |
    jr      $ra1                        # |         17 |         17 |          0 |          0 |
be.22113:
    li      0, $i1                      # |          1 |          1 |          0 |          0 |
    jr      $ra1                        # |          1 |          1 |          0 |          0 |
.end read_nth_object

######################################################################
# read_object($i6)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f21]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin read_object
read_object.2721:
    bge     $i6, 60, bge.22134          # |         18 |         18 |          0 |          0 |
bl.22134:
    jal     read_nth_object.2719, $ra1  # |         18 |         18 |          0 |          0 |
    be      $i1, 0, be.22135            # |         18 |         18 |          0 |          1 |
bne.22135:
    add     $i6, 1, $i6                 # |         17 |         17 |          0 |          0 |
    b       read_object.2721            # |         17 |         17 |          0 |          6 |
be.22135:
    mov     $i6, $ig0                   # |          1 |          1 |          0 |          0 |
    jr      $ra2                        # |          1 |          1 |          0 |          0 |
bge.22134:
    jr      $ra2
.end read_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
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
    be      $i1, -1, be.22137           # |         43 |         43 |          0 |         14 |
bne.22137:
.count stack_store
    store   $i1, [$sp + 2]              # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp + 1], $i1              # |         29 |         29 |          3 |          0 |
    add     $i1, 1, $i1                 # |         29 |         29 |          0 |          0 |
    call    read_net_item.2725          # |         29 |         29 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |         29 |         29 |          3 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i2              # |         29 |         29 |          0 |          0 |
.count stack_load
    load    [$sp - 1], $i3              # |         29 |         29 |          3 |          0 |
.count storer
    add     $i1, $i2, $tmp              # |         29 |         29 |          0 |          0 |
    store   $i3, [$tmp + 0]             # |         29 |         29 |          0 |          0 |
    ret                                 # |         29 |         29 |          0 |          0 |
be.22137:
.count stack_load_ra
    load    [$sp + 0], $ra              # |         14 |         14 |          1 |          0 |
.count stack_move
    add     $sp, 3, $sp                 # |         14 |         14 |          0 |          0 |
    add     $i0, -1, $i3                # |         14 |         14 |          0 |          0 |
.count stack_load
    load    [$sp - 2], $i1              # |         14 |         14 |          1 |          0 |
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
    load    [$i1 + 0], $i2              # |          3 |          3 |          3 |          0 |
    be      $i2, -1, be.22141           # |          3 |          3 |          0 |          1 |
bne.22141:
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
be.22141:
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
# [$ra]
######################################################################
.align 2
.begin read_and_network
read_and_network.2729:
    li      0, $i1                      # |         11 |         11 |          0 |          0 |
    call    read_net_item.2725          # |         11 |         11 |          0 |          0 |
    load    [$i1 + 0], $i2              # |         11 |         11 |         11 |          0 |
    be      $i2, -1, be.22144           # |         11 |         11 |          0 |          1 |
bne.22144:
    add     $i6, 1, $i2                 # |         10 |         10 |          0 |          0 |
    store   $i1, [ext_and_net + $i6]    # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |         10 |         10 |          0 |          0 |
    b       read_and_network.2729       # |         10 |         10 |          0 |          5 |
be.22144:
    jr      $ra1                        # |          1 |          1 |          0 |          0 |
.end read_and_network

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1, $i3 - $i4]
# [$f1 - $f16]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver
solver.2773:
    load    [ext_objects + $i1], $i1    # |     23,754 |     23,754 |          0 |          0 |
    load    [$i2 + 0], $f4              # |     23,754 |     23,754 |         42 |          0 |
    load    [$i1 + 1], $i3              # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 9], $f1              # |     23,754 |     23,754 |        458 |          0 |
    load    [$i1 + 8], $f2              # |     23,754 |     23,754 |        535 |          0 |
    fsub    $fg19, $f1, $f1             # |     23,754 |     23,754 |          0 |          0 |
    load    [$i1 + 7], $f3              # |     23,754 |     23,754 |        443 |          0 |
    fsub    $fg18, $f2, $f2             # |     23,754 |     23,754 |          0 |          0 |
    fsub    $fg17, $f3, $f3             # |     23,754 |     23,754 |          0 |          0 |
    bne     $i3, 1, bne.22145           # |     23,754 |     23,754 |          0 |          0 |
be.22145:
    be      $f4, $f0, ble.22152         # |     23,754 |     23,754 |          0 |          0 |
bne.22146:
    load    [$i1 + 5], $f5              # |     23,754 |     23,754 |          0 |          0 |
    load    [$i2 + 1], $f6              # |     23,754 |     23,754 |         42 |          0 |
    load    [$i1 + 10], $i3             # |     23,754 |     23,754 |      3,695 |          0 |
    load    [$i1 + 4], $f7              # |     23,754 |     23,754 |          0 |          0 |
    ble     $f0, $f4, ble.22147         # |     23,754 |     23,754 |          0 |        106 |
bg.22147:
    be      $i3, 0, be.22148            # |        174 |        174 |          0 |          2 |
.count dual_jmp
    b       bne.22785
ble.22147:
    be      $i3, 0, bne.22785           # |     23,580 |     23,580 |          0 |        602 |
be.22148:
    fsub    $f7, $f3, $f7               # |        174 |        174 |          0 |          0 |
    finv    $f4, $f4                    # |        174 |        174 |          0 |          0 |
    fmul    $f7, $f4, $f4               # |        174 |        174 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |        174 |        174 |          0 |          0 |
    fadd_a  $f6, $f2, $f6               # |        174 |        174 |          0 |          0 |
    ble     $f5, $f6, ble.22152         # |        174 |        174 |          0 |         14 |
.count dual_jmp
    b       bg.22151                    # |        127 |        127 |          0 |         40 |
bne.22785:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |          0 |          0 |
    fsub    $f7, $f3, $f7               # |     23,580 |     23,580 |          0 |          0 |
    finv    $f4, $f4                    # |     23,580 |     23,580 |          0 |          0 |
    fmul    $f7, $f4, $f4               # |     23,580 |     23,580 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |     23,580 |     23,580 |          0 |          0 |
    fadd_a  $f6, $f2, $f6               # |     23,580 |     23,580 |          0 |          0 |
    ble     $f5, $f6, ble.22152         # |     23,580 |     23,580 |          0 |        706 |
bg.22151:
    load    [$i2 + 2], $f5              # |      8,790 |      8,790 |         16 |          0 |
    load    [$i1 + 6], $f6              # |      8,790 |      8,790 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |      8,790 |      8,790 |          0 |          0 |
    fadd_a  $f5, $f1, $f5               # |      8,790 |      8,790 |          0 |          0 |
    bg      $f6, $f5, bg.22152          # |      8,790 |      8,790 |          0 |      2,723 |
ble.22152:
    load    [$i2 + 1], $f4              # |     20,087 |     20,087 |          0 |          0 |
    be      $f4, $f0, ble.22160         # |     20,087 |     20,087 |          0 |        800 |
bne.22154:
    load    [$i1 + 6], $f5              # |     20,087 |     20,087 |          0 |          0 |
    load    [$i2 + 2], $f6              # |     20,087 |     20,087 |         26 |          0 |
    load    [$i1 + 10], $i3             # |     20,087 |     20,087 |          0 |          0 |
    load    [$i1 + 5], $f7              # |     20,087 |     20,087 |          0 |          0 |
    ble     $f0, $f4, ble.22155         # |     20,087 |     20,087 |          0 |         28 |
bg.22155:
    be      $i3, 0, be.22156            # |     20,049 |     20,049 |          0 |         25 |
.count dual_jmp
    b       bne.22788
ble.22155:
    be      $i3, 0, bne.22788           # |         38 |         38 |          0 |          4 |
be.22156:
    fsub    $f7, $f2, $f7               # |     20,049 |     20,049 |          0 |          0 |
    finv    $f4, $f4                    # |     20,049 |     20,049 |          0 |          0 |
    fmul    $f7, $f4, $f4               # |     20,049 |     20,049 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |     20,049 |     20,049 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |     20,049 |     20,049 |          0 |          0 |
    ble     $f5, $f6, ble.22160         # |     20,049 |     20,049 |          0 |        300 |
.count dual_jmp
    b       bg.22159                    # |      3,574 |      3,574 |          0 |          6 |
bne.22788:
    fneg    $f7, $f7                    # |         38 |         38 |          0 |          0 |
    fsub    $f7, $f2, $f7               # |         38 |         38 |          0 |          0 |
    finv    $f4, $f4                    # |         38 |         38 |          0 |          0 |
    fmul    $f7, $f4, $f4               # |         38 |         38 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |         38 |         38 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |         38 |         38 |          0 |          0 |
    ble     $f5, $f6, ble.22160         # |         38 |         38 |          0 |          5 |
bg.22159:
    load    [$i2 + 0], $f5              # |      3,575 |      3,575 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |      3,575 |      3,575 |          0 |          0 |
    load    [$i1 + 4], $f6              # |      3,575 |      3,575 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      3,575 |      3,575 |          0 |          0 |
    bg      $f6, $f5, bg.22160          # |      3,575 |      3,575 |          0 |        124 |
ble.22160:
    load    [$i2 + 2], $f4              # |     19,143 |     19,143 |          0 |          0 |
    be      $f4, $f0, ble.22176         # |     19,143 |     19,143 |          0 |        101 |
bne.22162:
    load    [$i1 + 10], $i3             # |     19,143 |     19,143 |          0 |          0 |
    load    [$i1 + 4], $f5              # |     19,143 |     19,143 |          0 |          0 |
    load    [$i2 + 0], $f6              # |     19,143 |     19,143 |          0 |          0 |
    load    [$i1 + 6], $f7              # |     19,143 |     19,143 |          0 |          0 |
    ble     $f0, $f4, ble.22163         # |     19,143 |     19,143 |          0 |        313 |
bg.22163:
    finv    $f4, $f4                    # |      6,714 |      6,714 |          0 |          0 |
    be      $i3, 0, be.22164            # |      6,714 |      6,714 |          0 |         13 |
.count dual_jmp
    b       bne.22791
ble.22163:
    finv    $f4, $f4                    # |     12,429 |     12,429 |          0 |          0 |
    be      $i3, 0, bne.22791           # |     12,429 |     12,429 |          0 |        129 |
be.22164:
    fsub    $f7, $f1, $f1               # |      6,714 |      6,714 |          0 |          0 |
    fmul    $f1, $f4, $f1               # |      6,714 |      6,714 |          0 |          0 |
    fmul    $f1, $f6, $f4               # |      6,714 |      6,714 |          0 |          0 |
    fadd_a  $f4, $f3, $f3               # |      6,714 |      6,714 |          0 |          0 |
    ble     $f5, $f3, ble.22176         # |      6,714 |      6,714 |          0 |        375 |
.count dual_jmp
    b       bg.22167                    # |      1,198 |      1,198 |          0 |         14 |
bne.22791:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |          0 |          0 |
    fsub    $f7, $f1, $f1               # |     12,429 |     12,429 |          0 |          0 |
    fmul    $f1, $f4, $f1               # |     12,429 |     12,429 |          0 |          0 |
    fmul    $f1, $f6, $f4               # |     12,429 |     12,429 |          0 |          0 |
    fadd_a  $f4, $f3, $f3               # |     12,429 |     12,429 |          0 |          0 |
    ble     $f5, $f3, ble.22176         # |     12,429 |     12,429 |          0 |        288 |
bg.22167:
    load    [$i2 + 1], $f3              # |      3,882 |      3,882 |          0 |          0 |
    load    [$i1 + 5], $f4              # |      3,882 |      3,882 |          0 |          0 |
    fmul    $f1, $f3, $f3               # |      3,882 |      3,882 |          0 |          0 |
    fadd_a  $f3, $f2, $f2               # |      3,882 |      3,882 |          0 |          0 |
    ble     $f4, $f2, ble.22176         # |      3,882 |      3,882 |          0 |         94 |
bg.22168:
    mov     $f1, $fg0                   # |      2,165 |      2,165 |          0 |          0 |
    li      3, $i1                      # |      2,165 |      2,165 |          0 |          0 |
    ret                                 # |      2,165 |      2,165 |          0 |          0 |
bg.22160:
    mov     $f4, $fg0                   # |        944 |        944 |          0 |          0 |
    li      2, $i1                      # |        944 |        944 |          0 |          0 |
    ret                                 # |        944 |        944 |          0 |          0 |
bg.22152:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |          0 |          0 |
    li      1, $i1                      # |      3,667 |      3,667 |          0 |          0 |
    ret                                 # |      3,667 |      3,667 |          0 |          0 |
bne.22145:
    bne     $i3, 2, bne.22169
be.22169:
    load    [$i1 + 4], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 1], $f6
    load    [$i1 + 5], $f7
    load    [$i2 + 2], $f8
    fmul    $f6, $f7, $f6
    load    [$i1 + 6], $f9
    fmul    $f8, $f9, $f8
    fadd    $f4, $f6, $f4
    fadd    $f4, $f8, $f4
    ble     $f4, $f0, ble.22176
bg.22170:
    fmul    $f5, $f3, $f3
    fmul    $f7, $f2, $f2
    li      1, $i1
    fmul    $f9, $f1, $f1
    finv    $f4, $f4
    fadd    $f3, $f2, $f2
    fadd_n  $f2, $f1, $f1
    fmul    $f1, $f4, $fg0
    ret     
bne.22169:
    load    [$i2 + 1], $f5
    fmul    $f4, $f4, $f7
    load    [$i1 + 3], $i4
    fmul    $f5, $f5, $f8
    load    [$i2 + 2], $f6
    fmul    $f6, $f6, $f11
    load    [$i1 + 4], $f9
    fmul    $f7, $f9, $f7
    load    [$i1 + 5], $f10
    fmul    $f8, $f10, $f8
    load    [$i1 + 6], $f12
    fmul    $f11, $f12, $f11
    fadd    $f7, $f8, $f7
    fadd    $f7, $f11, $f7
    be      $i4, 0, be.22171
bne.22171:
    fmul    $f5, $f6, $f8
    load    [$i1 + 16], $f11
    fmul    $f6, $f4, $f13
    load    [$i1 + 17], $f14
    fmul    $f4, $f5, $f15
    fmul    $f8, $f11, $f8
    load    [$i1 + 18], $f11
    fmul    $f13, $f14, $f13
    fmul    $f15, $f11, $f11
    fadd    $f7, $f8, $f7
    fadd    $f7, $f13, $f7
    fadd    $f7, $f11, $f7
    be      $f7, $f0, ble.22176
.count dual_jmp
    b       bne.22172
be.22171:
    be      $f7, $f0, ble.22176
bne.22172:
    fmul    $f4, $f3, $f8
    fmul    $f5, $f2, $f11
    fmul    $f6, $f1, $f13
    fmul    $f8, $f9, $f8
    fmul    $f11, $f10, $f11
    fmul    $f13, $f12, $f13
    fadd    $f8, $f11, $f8
    fadd    $f8, $f13, $f8
    be      $i4, 0, be.22173
bne.22173:
    fmul    $f6, $f2, $f11
    fmul    $f5, $f1, $f13
    load    [$i1 + 16], $f14
    fmul    $f4, $f1, $f15
    load    [$i1 + 17], $f16
    fmul    $f6, $f3, $f6
    fadd    $f11, $f13, $f11
    fmul    $f4, $f2, $f4
    load    [$i1 + 18], $f13
    fmul    $f5, $f3, $f5
    fadd    $f15, $f6, $f6
    fmul    $f11, $f14, $f11
    fadd    $f4, $f5, $f4
    fmul    $f6, $f16, $f5
    fmul    $f3, $f3, $f6
    fmul    $f4, $f13, $f4
    fadd    $f11, $f5, $f5
    fmul    $f1, $f1, $f11
    fmul    $f6, $f9, $f6
    fadd    $f5, $f4, $f4
    fmul    $f11, $f12, $f9
    fmul    $f4, $fc3, $f4
    fadd    $f8, $f4, $f4
    fmul    $f2, $f2, $f8
    fmul    $f4, $f4, $f5
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fadd    $f6, $f9, $f6
    be      $i4, 0, be.22174
.count dual_jmp
    b       bne.22174
be.22173:
    mov     $f8, $f4
    fmul    $f4, $f4, $f5
    fmul    $f3, $f3, $f6
    fmul    $f2, $f2, $f8
    fmul    $f1, $f1, $f11
    fmul    $f6, $f9, $f6
    fmul    $f8, $f10, $f8
    fmul    $f11, $f12, $f9
    fadd    $f6, $f8, $f6
    fadd    $f6, $f9, $f6
    be      $i4, 0, be.22174
bne.22174:
    fmul    $f2, $f1, $f8
    load    [$i1 + 16], $f9
    fmul    $f1, $f3, $f1
    load    [$i1 + 17], $f10
    fmul    $f3, $f2, $f2
    fmul    $f8, $f9, $f3
    load    [$i1 + 18], $f8
    fmul    $f1, $f10, $f1
    fmul    $f2, $f8, $f2
    fadd    $f6, $f3, $f3
    fadd    $f3, $f1, $f1
    fadd    $f1, $f2, $f1
    be      $i3, 3, be.22175
.count dual_jmp
    b       bne.22175
be.22174:
    mov     $f6, $f1
    be      $i3, 3, be.22175
bne.22175:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, ble.22176
.count dual_jmp
    b       bg.22176
be.22175:
    fsub    $f1, $fc0, $f1
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, ble.22176
bg.22176:
    load    [$i1 + 10], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    be      $i1, 0, be.22177
bne.22177:
    fsub    $f1, $f4, $f1
    li      1, $i1
    fmul    $f1, $f2, $fg0
    ret     
be.22177:
    fneg    $f1, $f1
    li      1, $i1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    ret     
ble.22176:
    li      0, $i1                      # |     16,978 |     16,978 |          0 |          0 |
    ret                                 # |     16,978 |     16,978 |          0 |          0 |
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i4]
# [$f1 - $f11]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver_fast
solver_fast.2796:
    load    [ext_objects + $i1], $i2    # |    660,661 |    660,661 |      7,020 |          0 |
    load    [ext_light_dirvec + 3], $i3 # |    660,661 |    660,661 |      9,036 |          0 |
    load    [ext_intersection_point + 2], $f1# |    660,661 |    660,661 |      1,336 |          0 |
    load    [$i2 + 1], $i4              # |    660,661 |    660,661 |      3,345 |          0 |
    load    [$i2 + 9], $f2              # |    660,661 |    660,661 |      6,139 |          0 |
    fsub    $f1, $f2, $f1               # |    660,661 |    660,661 |          0 |          0 |
    load    [ext_intersection_point + 1], $f3# |    660,661 |    660,661 |      5,213 |          0 |
    load    [$i2 + 8], $f4              # |    660,661 |    660,661 |      5,666 |          0 |
    load    [ext_intersection_point + 0], $f5# |    660,661 |    660,661 |      2,731 |          0 |
    fsub    $f3, $f4, $f3               # |    660,661 |    660,661 |          0 |          0 |
    load    [$i2 + 7], $f6              # |    660,661 |    660,661 |      5,160 |          0 |
    fsub    $f5, $f6, $f2               # |    660,661 |    660,661 |          0 |          0 |
    load    [$i3 + $i1], $i1            # |    660,661 |    660,661 |     17,103 |          0 |
    load    [$i1 + 0], $f4              # |    660,661 |    660,661 |     10,401 |          0 |
    bne     $i4, 1, bne.22178           # |    660,661 |    660,661 |          0 |     15,431 |
be.22178:
    fsub    $f4, $f2, $f4               # |    660,661 |    660,661 |          0 |          0 |
    load    [$i2 + 5], $f5              # |    660,661 |    660,661 |      2,691 |          0 |
    load    [$i1 + 1], $f7              # |    660,661 |    660,661 |     11,028 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f6# |    660,661 |    660,661 |      6,768 |          0 |
    fmul    $f4, $f7, $f4               # |    660,661 |    660,661 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |    660,661 |    660,661 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    660,661 |    660,661 |          0 |          0 |
    ble     $f5, $f6, be.22181          # |    660,661 |    660,661 |          0 |    128,080 |
bg.22179:
    load    [%{ext_light_dirvec + 0} + 2], $f6# |    223,039 |    223,039 |      5,537 |          0 |
    load    [$i2 + 6], $f7              # |    223,039 |    223,039 |      2,009 |          0 |
    fmul    $f4, $f6, $f6               # |    223,039 |    223,039 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |    223,039 |    223,039 |          0 |          0 |
    ble     $f7, $f6, be.22181          # |    223,039 |    223,039 |          0 |     45,463 |
bg.22180:
    load    [$i1 + 1], $f6              # |    146,787 |    146,787 |          0 |          0 |
    bne     $f6, $f0, bne.22181         # |    146,787 |    146,787 |          0 |         55 |
be.22181:
    load    [$i1 + 2], $f4              # |    513,874 |    513,874 |     10,137 |          0 |
    fsub    $f4, $f3, $f4               # |    513,874 |    513,874 |          0 |          0 |
    load    [$i2 + 4], $f6              # |    513,874 |    513,874 |      2,045 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f7# |    513,874 |    513,874 |      7,827 |          0 |
    load    [$i1 + 3], $f8              # |    513,874 |    513,874 |     11,536 |          0 |
    fmul    $f4, $f8, $f4               # |    513,874 |    513,874 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |    513,874 |    513,874 |          0 |          0 |
    fadd_a  $f7, $f2, $f7               # |    513,874 |    513,874 |          0 |          0 |
    ble     $f6, $f7, be.22185          # |    513,874 |    513,874 |          0 |     72,982 |
bg.22183:
    load    [%{ext_light_dirvec + 0} + 2], $f7# |     75,025 |     75,025 |      2,474 |          0 |
    load    [$i2 + 6], $f8              # |     75,025 |     75,025 |        387 |          0 |
    fmul    $f4, $f7, $f7               # |     75,025 |     75,025 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |     75,025 |     75,025 |          0 |          0 |
    ble     $f8, $f7, be.22185          # |     75,025 |     75,025 |          0 |     15,189 |
bg.22184:
    load    [$i1 + 3], $f7              # |     34,834 |     34,834 |          0 |          0 |
    bne     $f7, $f0, bne.22185         # |     34,834 |     34,834 |          0 |        186 |
be.22185:
    load    [$i1 + 4], $f4              # |    479,040 |    479,040 |     14,724 |          0 |
    fsub    $f4, $f1, $f1               # |    479,040 |    479,040 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f7# |    479,040 |    479,040 |          0 |          0 |
    load    [$i1 + 5], $f8              # |    479,040 |    479,040 |     16,936 |          0 |
    fmul    $f1, $f8, $f1               # |    479,040 |    479,040 |          0 |          0 |
    fmul    $f1, $f7, $f4               # |    479,040 |    479,040 |          0 |          0 |
    fadd_a  $f4, $f2, $f2               # |    479,040 |    479,040 |          0 |          0 |
    ble     $f6, $f2, ble.22195         # |    479,040 |    479,040 |          0 |     16,466 |
bg.22187:
    load    [%{ext_light_dirvec + 0} + 1], $f2# |     31,999 |     31,999 |          0 |          0 |
    fmul    $f1, $f2, $f2               # |     31,999 |     31,999 |          0 |          0 |
    fadd_a  $f2, $f3, $f2               # |     31,999 |     31,999 |          0 |          0 |
    ble     $f5, $f2, ble.22195         # |     31,999 |     31,999 |          0 |      5,603 |
bg.22188:
    load    [$i1 + 5], $f2              # |     24,347 |     24,347 |          0 |          0 |
    be      $f2, $f0, ble.22195         # |     24,347 |     24,347 |          0 |      1,976 |
bne.22189:
    mov     $f1, $fg0                   # |     24,347 |     24,347 |          0 |          0 |
    li      3, $i1                      # |     24,347 |     24,347 |          0 |          0 |
    ret                                 # |     24,347 |     24,347 |          0 |          0 |
bne.22185:
    mov     $f4, $fg0                   # |     34,834 |     34,834 |          0 |          0 |
    li      2, $i1                      # |     34,834 |     34,834 |          0 |          0 |
    ret                                 # |     34,834 |     34,834 |          0 |          0 |
bne.22181:
    mov     $f4, $fg0                   # |    146,787 |    146,787 |          0 |          0 |
    li      1, $i1                      # |    146,787 |    146,787 |          0 |          0 |
    ret                                 # |    146,787 |    146,787 |          0 |          0 |
bne.22178:
    be      $i4, 2, be.22190
bne.22190:
    be      $f4, $f0, ble.22195
bne.22192:
    load    [$i2 + 3], $i3
    load    [$i1 + 1], $f5
    fmul    $f5, $f2, $f5
    load    [$i1 + 2], $f6
    fmul    $f6, $f3, $f6
    load    [$i1 + 3], $f7
    fmul    $f7, $f1, $f7
    fmul    $f2, $f2, $f8
    load    [$i2 + 4], $f10
    fmul    $f3, $f3, $f9
    load    [$i2 + 5], $f11
    fadd    $f5, $f6, $f5
    fmul    $f8, $f10, $f6
    fmul    $f9, $f11, $f8
    load    [$i2 + 6], $f10
    fmul    $f1, $f1, $f9
    fadd    $f5, $f7, $f5
    fadd    $f6, $f8, $f6
    fmul    $f9, $f10, $f7
    fmul    $f5, $f5, $f8
    fadd    $f6, $f7, $f6
    be      $i3, 0, be.22193
bne.22193:
    fmul    $f3, $f1, $f7
    load    [$i2 + 16], $f9
    fmul    $f1, $f2, $f1
    load    [$i2 + 17], $f10
    fmul    $f2, $f3, $f2
    fmul    $f7, $f9, $f3
    load    [$i2 + 18], $f7
    fmul    $f1, $f10, $f1
    fmul    $f2, $f7, $f2
    fadd    $f6, $f3, $f3
    fadd    $f3, $f1, $f1
    fadd    $f1, $f2, $f1
    be      $i4, 3, be.22194
.count dual_jmp
    b       bne.22194
be.22193:
    mov     $f6, $f1
    be      $i4, 3, be.22194
bne.22194:
    fmul    $f4, $f1, $f1
    fsub    $f8, $f1, $f1
    ble     $f1, $f0, ble.22195
.count dual_jmp
    b       bg.22195
be.22194:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f8, $f1, $f1
    ble     $f1, $f0, ble.22195
bg.22195:
    load    [$i2 + 10], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    be      $i2, 0, be.22196
bne.22196:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret     
be.22196:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret     
be.22190:
    ble     $f0, $f4, ble.22195
bg.22191:
    load    [$i1 + 1], $f4
    load    [$i1 + 2], $f5
    fmul    $f4, $f2, $f2
    load    [$i1 + 3], $f6
    fmul    $f5, $f3, $f3
    fmul    $f6, $f1, $f1
    li      1, $i1
    fadd    $f2, $f3, $f2
    fadd    $f2, $f1, $fg0
    ret     
ble.22195:
    li      0, $i1                      # |    454,693 |    454,693 |          0 |          0 |
    ret                                 # |    454,693 |    454,693 |          0 |          0 |
.end solver_fast

######################################################################
# $i1 = solver_fast2($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f8]
# []
# [$fg0]
# []
######################################################################
.align 2
.begin solver_fast2
solver_fast2.2814:
    load    [ext_objects + $i1], $i3    # |  1,134,616 |  1,134,616 |      4,904 |          0 |
    load    [$i2 + 3], $i4              # |  1,134,616 |  1,134,616 |    887,039 |          0 |
    load    [$i3 + 1], $i5              # |  1,134,616 |  1,134,616 |      4,117 |          0 |
    load    [$i3 + 19], $f1             # |  1,134,616 |  1,134,616 |      9,216 |          0 |
    load    [$i3 + 20], $f2             # |  1,134,616 |  1,134,616 |      9,439 |          0 |
    load    [$i3 + 21], $f3             # |  1,134,616 |  1,134,616 |      8,975 |          0 |
    load    [$i4 + $i1], $i1            # |  1,134,616 |  1,134,616 |    950,413 |          0 |
    bne     $i5, 1, bne.22197           # |  1,134,616 |  1,134,616 |          0 |      1,990 |
be.22197:
    load    [$i1 + 0], $f4              # |  1,134,616 |  1,134,616 |  1,043,539 |          0 |
    fsub    $f4, $f1, $f4               # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i3 + 5], $f5              # |  1,134,616 |  1,134,616 |      3,923 |          0 |
    load    [$i2 + 1], $f6              # |  1,134,616 |  1,134,616 |    411,804 |          0 |
    load    [$i1 + 1], $f7              # |  1,134,616 |  1,134,616 |  1,041,978 |          0 |
    fmul    $f4, $f7, $f4               # |  1,134,616 |  1,134,616 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |  1,134,616 |  1,134,616 |          0 |          0 |
    fadd_a  $f6, $f2, $f6               # |  1,134,616 |  1,134,616 |          0 |          0 |
    ble     $f5, $f6, be.22200          # |  1,134,616 |  1,134,616 |          0 |    356,226 |
bg.22198:
    load    [$i2 + 2], $f6              # |    494,425 |    494,425 |    225,304 |          0 |
    load    [$i3 + 6], $f7              # |    494,425 |    494,425 |      2,831 |          0 |
    fmul    $f4, $f6, $f6               # |    494,425 |    494,425 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |    494,425 |    494,425 |          0 |          0 |
    ble     $f7, $f6, be.22200          # |    494,425 |    494,425 |          0 |    101,982 |
bg.22199:
    load    [$i1 + 1], $f6              # |    330,005 |    330,005 |          0 |          0 |
    bne     $f6, $f0, bne.22200         # |    330,005 |    330,005 |          0 |     62,551 |
be.22200:
    load    [$i1 + 2], $f4              # |    804,611 |    804,611 |    696,565 |          0 |
    fsub    $f4, $f2, $f4               # |    804,611 |    804,611 |          0 |          0 |
    load    [$i3 + 4], $f6              # |    804,611 |    804,611 |      3,176 |          0 |
    load    [$i2 + 0], $f7              # |    804,611 |    804,611 |    253,730 |          0 |
    load    [$i1 + 3], $f8              # |    804,611 |    804,611 |    698,137 |          0 |
    fmul    $f4, $f8, $f4               # |    804,611 |    804,611 |          0 |          0 |
    fmul    $f4, $f7, $f7               # |    804,611 |    804,611 |          0 |          0 |
    fadd_a  $f7, $f1, $f7               # |    804,611 |    804,611 |          0 |          0 |
    ble     $f6, $f7, be.22204          # |    804,611 |    804,611 |          0 |     56,031 |
bg.22202:
    load    [$i2 + 2], $f7              # |    350,992 |    350,992 |    136,746 |          0 |
    load    [$i3 + 6], $f8              # |    350,992 |    350,992 |      1,096 |          0 |
    fmul    $f4, $f7, $f7               # |    350,992 |    350,992 |          0 |          0 |
    fadd_a  $f7, $f3, $f7               # |    350,992 |    350,992 |          0 |          0 |
    ble     $f8, $f7, be.22204          # |    350,992 |    350,992 |          0 |     79,633 |
bg.22203:
    load    [$i1 + 3], $f7              # |    227,351 |    227,351 |          0 |          0 |
    bne     $f7, $f0, bne.22204         # |    227,351 |    227,351 |          0 |         16 |
be.22204:
    load    [$i1 + 4], $f4              # |    577,260 |    577,260 |    498,013 |          0 |
    fsub    $f4, $f3, $f3               # |    577,260 |    577,260 |          0 |          0 |
    load    [$i2 + 0], $f7              # |    577,260 |    577,260 |        880 |          0 |
    load    [$i1 + 5], $f8              # |    577,260 |    577,260 |    492,266 |          0 |
    fmul    $f3, $f8, $f3               # |    577,260 |    577,260 |          0 |          0 |
    fmul    $f3, $f7, $f4               # |    577,260 |    577,260 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |    577,260 |    577,260 |          0 |          0 |
    ble     $f6, $f1, ble.22212         # |    577,260 |    577,260 |          0 |     89,737 |
bg.22206:
    load    [$i2 + 1], $f1              # |    164,946 |    164,946 |         16 |          0 |
    fmul    $f3, $f1, $f1               # |    164,946 |    164,946 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |    164,946 |    164,946 |          0 |          0 |
    ble     $f5, $f1, ble.22212         # |    164,946 |    164,946 |          0 |      8,553 |
bg.22207:
    load    [$i1 + 5], $f1              # |    127,468 |    127,468 |         15 |          0 |
    be      $f1, $f0, ble.22212         # |    127,468 |    127,468 |          0 |      8,856 |
bne.22208:
    mov     $f3, $fg0                   # |    127,468 |    127,468 |          0 |          0 |
    li      3, $i1                      # |    127,468 |    127,468 |          0 |          0 |
    ret                                 # |    127,468 |    127,468 |          0 |          0 |
bne.22204:
    mov     $f4, $fg0                   # |    227,351 |    227,351 |          0 |          0 |
    li      2, $i1                      # |    227,351 |    227,351 |          0 |          0 |
    ret                                 # |    227,351 |    227,351 |          0 |          0 |
bne.22200:
    mov     $f4, $fg0                   # |    330,005 |    330,005 |          0 |          0 |
    li      1, $i1                      # |    330,005 |    330,005 |          0 |          0 |
    ret                                 # |    330,005 |    330,005 |          0 |          0 |
bne.22197:
    be      $i5, 2, be.22209
bne.22209:
    load    [$i1 + 0], $f4
    be      $f4, $f0, ble.22212
bne.22211:
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f1
    load    [$i1 + 2], $f6
    fmul    $f6, $f2, $f2
    load    [$i1 + 3], $f7
    fmul    $f7, $f3, $f3
    load    [$i3 + 22], $f5
    fadd    $f1, $f2, $f1
    fmul    $f4, $f5, $f2
    fadd    $f1, $f3, $f1
    fmul    $f1, $f1, $f3
    fsub    $f3, $f2, $f2
    ble     $f2, $f0, ble.22212
bg.22212:
    load    [$i3 + 10], $i2
    load    [$i1 + 4], $f3
    li      1, $i1
    fsqrt   $f2, $f2
    be      $i2, 0, be.22213
bne.22213:
    fadd    $f1, $f2, $f1
    fmul    $f1, $f3, $fg0
    ret     
be.22213:
    fsub    $f1, $f2, $f1
    fmul    $f1, $f3, $fg0
    ret     
be.22209:
    load    [$i1 + 0], $f1
    ble     $f0, $f1, ble.22212
bg.22210:
    load    [$i3 + 22], $f2
    li      1, $i1
    fmul    $f1, $f2, $fg0
    ret     
ble.22212:
    li      0, $i1                      # |    449,792 |    449,792 |          0 |          0 |
    ret                                 # |    449,792 |    449,792 |          0 |          0 |
.end solver_fast2

######################################################################
# $i1 = setup_rect_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f2]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_rect_table
setup_rect_table.2817:
    li      6, $i2                      # |      3,612 |      3,612 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      3,612 |      3,612 |          0 |          0 |
    call    ext_create_array_float      # |      3,612 |      3,612 |          0 |          0 |
    load    [$i4 + 0], $f1              # |      3,612 |      3,612 |          1 |          0 |
    bne     $f1, $f0, bne.22214         # |      3,612 |      3,612 |          0 |          2 |
be.22214:
    store   $f0, [$i1 + 1]
    load    [$i4 + 1], $f1
    be      $f1, $f0, be.22219
.count dual_jmp
    b       bne.22219
bne.22214:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |          8 |          0 |
    ble     $f0, $f1, ble.22215         # |      3,612 |      3,612 |          0 |        804 |
bg.22215:
    load    [$i5 + 4], $f1              # |      1,806 |      1,806 |          7 |          0 |
    be      $i2, 0, be.22216            # |      1,806 |      1,806 |          0 |          2 |
.count dual_jmp
    b       bne.22794
ble.22215:
    load    [$i5 + 4], $f1              # |      1,806 |      1,806 |          1 |          0 |
    be      $i2, 0, bne.22794           # |      1,806 |      1,806 |          0 |          2 |
be.22216:
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |          1 |          0 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |          1 |          0 |
    be      $f1, $f0, be.22219          # |      1,806 |      1,806 |          0 |          0 |
.count dual_jmp
    b       bne.22219                   # |      1,806 |      1,806 |          0 |          2 |
bne.22794:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |          0 |          0 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |          0 |          0 |
    bne     $f1, $f0, bne.22219         # |      1,806 |      1,806 |          0 |        125 |
be.22219:
    store   $f0, [$i1 + 3]
    load    [$i4 + 2], $f1
    be      $f1, $f0, be.22224
.count dual_jmp
    b       bne.22224
bne.22219:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |          0 |          0 |
    ble     $f0, $f1, ble.22220         # |      3,612 |      3,612 |          0 |      1,122 |
bg.22220:
    load    [$i5 + 5], $f1              # |      1,806 |      1,806 |          2 |          0 |
    be      $i2, 0, be.22221            # |      1,806 |      1,806 |          0 |          4 |
.count dual_jmp
    b       bne.22797
ble.22220:
    load    [$i5 + 5], $f1              # |      1,806 |      1,806 |          8 |          0 |
    be      $i2, 0, bne.22797           # |      1,806 |      1,806 |          0 |          4 |
be.22221:
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |          1 |          0 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |          0 |          0 |
    be      $f1, $f0, be.22224          # |      1,806 |      1,806 |          0 |          0 |
.count dual_jmp
    b       bne.22224                   # |      1,806 |      1,806 |          0 |          4 |
bne.22797:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |          0 |          0 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |          0 |          0 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |          0 |          0 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |          1 |          0 |
    be      $f1, $f0, be.22224          # |      1,806 |      1,806 |          0 |          0 |
bne.22224:
    load    [$i5 + 10], $i2             # |      3,612 |      3,612 |          1 |          0 |
    ble     $f0, $f1, ble.22225         # |      3,612 |      3,612 |          0 |        175 |
bg.22225:
    load    [$i5 + 6], $f1              # |      1,800 |      1,800 |          8 |          0 |
    be      $i2, 0, be.22226            # |      1,800 |      1,800 |          0 |          8 |
.count dual_jmp
    b       bne.22800
ble.22225:
    load    [$i5 + 6], $f1              # |      1,812 |      1,812 |          2 |          0 |
    be      $i2, 0, bne.22800           # |      1,812 |      1,812 |          0 |          8 |
be.22226:
    store   $f1, [$i1 + 4]              # |      1,800 |      1,800 |          0 |          0 |
    load    [$i4 + 2], $f1              # |      1,800 |      1,800 |          1 |          0 |
    finv    $f1, $f1                    # |      1,800 |      1,800 |          0 |          0 |
    store   $f1, [$i1 + 5]              # |      1,800 |      1,800 |          0 |          0 |
    jr      $ra1                        # |      1,800 |      1,800 |          0 |          0 |
bne.22800:
    fneg    $f1, $f1                    # |      1,812 |      1,812 |          0 |          0 |
    store   $f1, [$i1 + 4]              # |      1,812 |      1,812 |          0 |          0 |
    load    [$i4 + 2], $f1              # |      1,812 |      1,812 |          1 |          0 |
    finv    $f1, $f1                    # |      1,812 |      1,812 |          0 |          0 |
    store   $f1, [$i1 + 5]              # |      1,812 |      1,812 |          0 |          0 |
    jr      $ra1                        # |      1,812 |      1,812 |          0 |          0 |
be.22224:
    store   $f0, [$i1 + 5]
    jr      $ra1
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f4]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_surface_table
setup_surface_table.2820:
    li      4, $i2                      # |      1,204 |      1,204 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      1,204 |      1,204 |          0 |          0 |
    call    ext_create_array_float      # |      1,204 |      1,204 |          0 |          0 |
    load    [$i4 + 0], $f1              # |      1,204 |      1,204 |        602 |          0 |
    load    [$i5 + 4], $f2              # |      1,204 |      1,204 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      1,204 |      1,204 |          0 |          0 |
    load    [$i4 + 1], $f3              # |      1,204 |      1,204 |        602 |          0 |
    load    [$i5 + 5], $f4              # |      1,204 |      1,204 |          0 |          0 |
    load    [$i4 + 2], $f2              # |      1,204 |      1,204 |        602 |          0 |
    fmul    $f3, $f4, $f3               # |      1,204 |      1,204 |          0 |          0 |
    load    [$i5 + 6], $f4              # |      1,204 |      1,204 |          0 |          0 |
    fmul    $f2, $f4, $f2               # |      1,204 |      1,204 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,204 |      1,204 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,204 |      1,204 |          0 |          0 |
    ble     $f1, $f0, ble.22229         # |      1,204 |      1,204 |          0 |      1,097 |
bg.22229:
    finv    $f1, $f1                    # |        603 |        603 |          0 |          0 |
    fneg    $f1, $f2                    # |        603 |        603 |          0 |          0 |
    store   $f2, [$i1 + 0]              # |        603 |        603 |          0 |          0 |
    load    [$i5 + 4], $f2              # |        603 |        603 |          0 |          0 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |          0 |          0 |
    store   $f2, [$i1 + 1]              # |        603 |        603 |          0 |          0 |
    load    [$i5 + 5], $f2              # |        603 |        603 |          0 |          0 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |          0 |          0 |
    store   $f2, [$i1 + 2]              # |        603 |        603 |          0 |          0 |
    load    [$i5 + 6], $f2              # |        603 |        603 |          0 |          0 |
    fmul_n  $f2, $f1, $f1               # |        603 |        603 |          0 |          0 |
    store   $f1, [$i1 + 3]              # |        603 |        603 |          0 |          0 |
    jr      $ra1                        # |        603 |        603 |          0 |          0 |
ble.22229:
    store   $f0, [$i1 + 0]              # |        601 |        601 |          0 |          0 |
    jr      $ra1                        # |        601 |        601 |          0 |          0 |
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.align 2
.begin setup_second_table
setup_second_table.2823:
    li      5, $i2                      # |      5,418 |      5,418 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |      5,418 |      5,418 |          0 |          0 |
    call    ext_create_array_float      # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 3], $i2              # |      5,418 |      5,418 |         15 |          0 |
    load    [$i4 + 0], $f1              # |      5,418 |      5,418 |          1 |          0 |
    fmul    $f1, $f1, $f4               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i4 + 1], $f2              # |      5,418 |      5,418 |          2 |          0 |
    fmul    $f2, $f2, $f5               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i4 + 2], $f3              # |      5,418 |      5,418 |          2 |          0 |
    fmul    $f3, $f3, $f8               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 4], $f6              # |      5,418 |      5,418 |          5 |          0 |
    fmul    $f4, $f6, $f4               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 5], $f7              # |      5,418 |      5,418 |          4 |          0 |
    fmul    $f5, $f7, $f5               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 6], $f6              # |      5,418 |      5,418 |          3 |          0 |
    fmul    $f8, $f6, $f6               # |      5,418 |      5,418 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |      5,418 |      5,418 |          0 |          0 |
    fadd    $f4, $f6, $f4               # |      5,418 |      5,418 |          0 |          0 |
    be      $i2, 0, be.22230            # |      5,418 |      5,418 |          0 |          2 |
bne.22230:
    fmul    $f2, $f3, $f5
    load    [$i5 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i5 + 17], $f7
    fmul    $f1, $f2, $f1
    fmul    $f5, $f6, $f2
    load    [$i5 + 18], $f5
    fmul    $f3, $f7, $f3
    fmul    $f1, $f5, $f1
    fadd    $f4, $f2, $f2
    fadd    $f2, $f3, $f2
    fadd    $f2, $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i4 + 2], $f2
    load    [$i5 + 6], $f3
    load    [$i4 + 1], $f4
    fmul    $f2, $f3, $f3
    load    [$i5 + 5], $f5
    fmul    $f4, $f5, $f5
    load    [$i4 + 0], $f6
    fneg    $f3, $f3
    load    [$i5 + 4], $f7
    fmul_n  $f6, $f7, $f6
    fneg    $f5, $f5
    be      $i2, 0, be.22231
.count dual_jmp
    b       bne.22231
be.22230:
    mov     $f4, $f1                    # |      5,418 |      5,418 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      5,418 |      5,418 |          0 |          0 |
    load    [$i4 + 2], $f2              # |      5,418 |      5,418 |          1 |          0 |
    load    [$i5 + 6], $f3              # |      5,418 |      5,418 |          0 |          0 |
    fmul    $f2, $f3, $f3               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i4 + 1], $f4              # |      5,418 |      5,418 |          0 |          0 |
    fneg    $f3, $f3                    # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 5], $f5              # |      5,418 |      5,418 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |      5,418 |      5,418 |          0 |          0 |
    load    [$i4 + 0], $f6              # |      5,418 |      5,418 |          0 |          0 |
    fneg    $f5, $f5                    # |      5,418 |      5,418 |          0 |          0 |
    load    [$i5 + 4], $f7              # |      5,418 |      5,418 |          1 |          0 |
    fmul_n  $f6, $f7, $f6               # |      5,418 |      5,418 |          0 |          0 |
    be      $i2, 0, be.22231            # |      5,418 |      5,418 |          0 |          2 |
bne.22231:
    load    [$i5 + 17], $f7
    load    [$i5 + 18], $f8
    fmul    $f2, $f7, $f2
    fmul    $f4, $f8, $f4
    fadd    $f2, $f4, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 1]
    load    [$i4 + 2], $f2
    load    [$i5 + 16], $f4
    fmul    $f2, $f4, $f2
    load    [$i4 + 0], $f6
    fmul    $f6, $f8, $f6
    fadd    $f2, $f6, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f5, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i4 + 1], $f2
    fmul    $f2, $f4, $f2
    load    [$i4 + 0], $f5
    fmul    $f5, $f7, $f4
    fadd    $f2, $f4, $f2
    fmul    $f2, $fc3, $f2
    fsub    $f3, $f2, $f2
    store   $f2, [$i1 + 3]
    be      $f1, $f0, be.22233
.count dual_jmp
    b       bne.22233
be.22231:
    store   $f6, [$i1 + 1]              # |      5,418 |      5,418 |          0 |          0 |
    store   $f5, [$i1 + 2]              # |      5,418 |      5,418 |          0 |          0 |
    store   $f3, [$i1 + 3]              # |      5,418 |      5,418 |          0 |          0 |
    be      $f1, $f0, be.22233          # |      5,418 |      5,418 |          0 |          0 |
bne.22233:
    finv    $f1, $f1                    # |      5,418 |      5,418 |          0 |          0 |
    store   $f1, [$i1 + 4]              # |      5,418 |      5,418 |          0 |          0 |
    jr      $ra1                        # |      5,418 |      5,418 |          0 |          0 |
be.22233:
    jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i4, $i6)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i6, 0, bl.22234            # |     10,836 |     10,836 |          0 |      1,204 |
bge.22234:
    load    [ext_objects + $i6], $i5    # |     10,234 |     10,234 |         18 |          0 |
    load    [$i4 + 3], $i7              # |     10,234 |     10,234 |        606 |          0 |
    load    [$i5 + 1], $i1              # |     10,234 |     10,234 |         23 |          0 |
    be      $i1, 1, be.22235            # |     10,234 |     10,234 |          0 |      4,993 |
bne.22235:
    be      $i1, 2, be.22236            # |      6,622 |      6,622 |          0 |      1,334 |
bne.22236:
    jal     setup_second_table.2823, $ra1# |      5,418 |      5,418 |          0 |          0 |
    add     $i6, -1, $i2                # |      5,418 |      5,418 |          0 |          0 |
.count storer
    add     $i7, $i6, $tmp              # |      5,418 |      5,418 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      5,418 |      5,418 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |      5,418 |      5,418 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      5,418 |      5,418 |          0 |          2 |
be.22236:
    jal     setup_surface_table.2820, $ra1# |      1,204 |      1,204 |          0 |          0 |
    add     $i6, -1, $i2                # |      1,204 |      1,204 |          0 |          0 |
.count storer
    add     $i7, $i6, $tmp              # |      1,204 |      1,204 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |      1,204 |      1,204 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |          0 |          4 |
be.22235:
    jal     setup_rect_table.2817, $ra1 # |      3,612 |      3,612 |          0 |          0 |
    add     $i6, -1, $i2                # |      3,612 |      3,612 |          0 |          0 |
.count storer
    add     $i7, $i6, $tmp              # |      3,612 |      3,612 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      3,612 |      3,612 |          0 |          0 |
.count move_args
    mov     $i2, $i6                    # |      3,612 |      3,612 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |      3,612 |      3,612 |          0 |         16 |
bl.22234:
    jr      $ra2                        # |        602 |        602 |          0 |          0 |
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i4)
# $ra = $ra2
# [$i1 - $i3, $i5 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
    add     $ig0, -1, $i6               # |        602 |        602 |          0 |          0 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |          0 |         13 |
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1, $i3 - $i5]
# [$f1 - $f8]
# []
# []
# []
######################################################################
.align 2
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i1, 0, bl.22237            # |    667,764 |    667,764 |          0 |     74,590 |
bge.22237:
    load    [ext_objects + $i1], $i3    # |    630,666 |    630,666 |     10,954 |          0 |
    load    [$i2 + 0], $f1              # |    630,666 |    630,666 |        144 |          0 |
    load    [$i3 + 7], $f2              # |    630,666 |    630,666 |     37,597 |          0 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |          0 |          0 |
    store   $f1, [$i3 + 19]             # |    630,666 |    630,666 |          0 |          0 |
    load    [$i2 + 1], $f1              # |    630,666 |    630,666 |        395 |          0 |
    load    [$i3 + 8], $f2              # |    630,666 |    630,666 |     39,651 |          0 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |          0 |          0 |
    store   $f1, [$i3 + 20]             # |    630,666 |    630,666 |          0 |          0 |
    load    [$i2 + 2], $f1              # |    630,666 |    630,666 |        324 |          0 |
    load    [$i3 + 9], $f2              # |    630,666 |    630,666 |     42,843 |          0 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |          0 |          0 |
    store   $f1, [$i3 + 21]             # |    630,666 |    630,666 |          0 |          0 |
    load    [$i3 + 1], $i4              # |    630,666 |    630,666 |      9,162 |          0 |
    be      $i4, 2, be.22238            # |    630,666 |    630,666 |          0 |    109,994 |
bne.22238:
    ble     $i4, 2, ble.22239           # |    556,470 |    556,470 |          0 |    243,113 |
bg.22239:
    load    [$i3 + 3], $i5              # |    333,882 |    333,882 |     34,989 |          0 |
    load    [$i3 + 19], $f1             # |    333,882 |    333,882 |      5,713 |          0 |
    fmul    $f1, $f1, $f4               # |    333,882 |    333,882 |          0 |          0 |
    load    [$i3 + 20], $f2             # |    333,882 |    333,882 |      5,760 |          0 |
    fmul    $f2, $f2, $f5               # |    333,882 |    333,882 |          0 |          0 |
    load    [$i3 + 21], $f3             # |    333,882 |    333,882 |      3,966 |          0 |
    fmul    $f3, $f3, $f8               # |    333,882 |    333,882 |          0 |          0 |
    load    [$i3 + 4], $f6              # |    333,882 |    333,882 |     26,309 |          0 |
    fmul    $f4, $f6, $f4               # |    333,882 |    333,882 |          0 |          0 |
    load    [$i3 + 5], $f7              # |    333,882 |    333,882 |     24,851 |          0 |
    fmul    $f5, $f7, $f5               # |    333,882 |    333,882 |          0 |          0 |
    load    [$i3 + 6], $f6              # |    333,882 |    333,882 |     22,186 |          0 |
    fmul    $f8, $f6, $f6               # |    333,882 |    333,882 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |          0 |          0 |
    fadd    $f4, $f6, $f4               # |    333,882 |    333,882 |          0 |          0 |
    be      $i5, 0, be.22240            # |    333,882 |    333,882 |          0 |      4,092 |
bne.22240:
    fmul    $f2, $f3, $f5
    load    [$i3 + 16], $f6
    fmul    $f3, $f1, $f3
    load    [$i3 + 17], $f7
    fmul    $f1, $f2, $f1
    fmul    $f5, $f6, $f2
    load    [$i3 + 18], $f5
    fmul    $f3, $f7, $f3
    fmul    $f1, $f5, $f1
    fadd    $f4, $f2, $f2
    fadd    $f2, $f3, $f2
    fadd    $f2, $f1, $f1
    be      $i4, 3, be.22241
.count dual_jmp
    b       bne.22241
be.22240:
    mov     $f4, $f1                    # |    333,882 |    333,882 |          0 |          0 |
    be      $i4, 3, be.22241            # |    333,882 |    333,882 |          0 |        344 |
bne.22241:
    add     $i1, -1, $i1
    store   $f1, [$i3 + 22]
    b       setup_startp_constants.2831
be.22241:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |          0 |          0 |
    add     $i1, -1, $i1                # |    333,882 |    333,882 |          0 |          0 |
    store   $f1, [$i3 + 22]             # |    333,882 |    333,882 |          0 |          0 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |          0 |          6 |
ble.22239:
    add     $i1, -1, $i1                # |    222,588 |    222,588 |          0 |          0 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |          0 |     34,506 |
be.22238:
    load    [$i3 + 4], $f1              # |     74,196 |     74,196 |      3,228 |          0 |
    add     $i1, -1, $i1                # |     74,196 |     74,196 |          0 |          0 |
    load    [$i3 + 19], $f2             # |     74,196 |     74,196 |      1,962 |          0 |
    fmul    $f1, $f2, $f1               # |     74,196 |     74,196 |          0 |          0 |
    load    [$i3 + 5], $f3              # |     74,196 |     74,196 |      2,155 |          0 |
    load    [$i3 + 20], $f4             # |     74,196 |     74,196 |      1,732 |          0 |
    load    [$i3 + 6], $f2              # |     74,196 |     74,196 |      2,677 |          0 |
    fmul    $f3, $f4, $f3               # |     74,196 |     74,196 |          0 |          0 |
    load    [$i3 + 21], $f4             # |     74,196 |     74,196 |      1,540 |          0 |
    fmul    $f2, $f4, $f2               # |     74,196 |     74,196 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |     74,196 |     74,196 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |          0 |          0 |
    store   $f1, [$i3 + 22]             # |     74,196 |     74,196 |          0 |          0 |
    b       setup_startp_constants.2831 # |     74,196 |     74,196 |          0 |        304 |
bl.22237:
    ret                                 # |     37,098 |     37,098 |          0 |          0 |
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i2, $i4 - $i6]
# [$f1, $f5 - $f11]
# []
# []
# []
######################################################################
.align 2
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i1], $i2            # |  1,715,961 |  1,715,961 |      2,845 |          0 |
    be      $i2, -1, be.22296           # |  1,715,961 |  1,715,961 |          0 |      2,078 |
bne.22242:
    load    [ext_objects + $i2], $i2    # |  1,693,879 |  1,693,879 |      2,024 |          0 |
    load    [$i2 + 1], $i4              # |  1,693,879 |  1,693,879 |      2,369 |          0 |
    load    [$i2 + 7], $f1              # |  1,693,879 |  1,693,879 |     23,800 |          0 |
    fsub    $f2, $f1, $f1               # |  1,693,879 |  1,693,879 |          0 |          0 |
    load    [$i2 + 8], $f5              # |  1,693,879 |  1,693,879 |     30,089 |          0 |
    fsub    $f3, $f5, $f5               # |  1,693,879 |  1,693,879 |          0 |          0 |
    load    [$i2 + 9], $f6              # |  1,693,879 |  1,693,879 |     28,369 |          0 |
    fsub    $f4, $f6, $f6               # |  1,693,879 |  1,693,879 |          0 |          0 |
    bne     $i4, 1, bne.22243           # |  1,693,879 |  1,693,879 |          0 |     38,817 |
be.22243:
    load    [$i2 + 4], $f7              # |    716,908 |    716,908 |      1,433 |          0 |
    fabs    $f1, $f1                    # |    716,908 |    716,908 |          0 |          0 |
    ble     $f7, $f1, ble.22246         # |    716,908 |    716,908 |          0 |    122,323 |
bg.22244:
    load    [$i2 + 5], $f1              # |    518,560 |    518,560 |        713 |          0 |
    fabs    $f5, $f5                    # |    518,560 |    518,560 |          0 |          0 |
    bg      $f1, $f5, bg.22246          # |    518,560 |    518,560 |          0 |     55,107 |
ble.22246:
    load    [$i2 + 10], $i2             # |    253,614 |    253,614 |      2,084 |          0 |
    be      $i2, 0, bne.22258           # |    253,614 |    253,614 |          0 |         34 |
.count dual_jmp
    b       be.22258
bg.22246:
    load    [$i2 + 6], $f1              # |    463,294 |    463,294 |        713 |          0 |
    fabs    $f6, $f5                    # |    463,294 |    463,294 |          0 |          0 |
    load    [$i2 + 10], $i2             # |    463,294 |    463,294 |      3,146 |          0 |
    ble     $f1, $f5, ble.22248         # |    463,294 |    463,294 |          0 |     21,545 |
bg.22248:
    be      $i2, 0, be.22258            # |    446,211 |    446,211 |          0 |        272 |
.count dual_jmp
    b       bne.22258
ble.22248:
    be      $i2, 0, bne.22258           # |     17,083 |     17,083 |          0 |         89 |
.count dual_jmp
    b       be.22258
bne.22243:
    be      $i4, 2, be.22250            # |    976,971 |    976,971 |          0 |         13 |
bne.22250:
    load    [$i2 + 10], $i5             # |    516,247 |    516,247 |      1,428 |          0 |
    fmul    $f1, $f1, $f7               # |    516,247 |    516,247 |          0 |          0 |
    load    [$i2 + 4], $f9              # |    516,247 |    516,247 |      3,820 |          0 |
    fmul    $f5, $f5, $f8               # |    516,247 |    516,247 |          0 |          0 |
    load    [$i2 + 5], $f10             # |    516,247 |    516,247 |      3,687 |          0 |
    fmul    $f6, $f6, $f11              # |    516,247 |    516,247 |          0 |          0 |
    load    [$i2 + 3], $i6              # |    516,247 |    516,247 |      6,340 |          0 |
    fmul    $f7, $f9, $f7               # |    516,247 |    516,247 |          0 |          0 |
    load    [$i2 + 6], $f9              # |    516,247 |    516,247 |      3,344 |          0 |
    fmul    $f8, $f10, $f8              # |    516,247 |    516,247 |          0 |          0 |
    fmul    $f11, $f9, $f9              # |    516,247 |    516,247 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    516,247 |    516,247 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    516,247 |    516,247 |          0 |          0 |
    be      $i6, 0, be.22254            # |    516,247 |    516,247 |          0 |         25 |
bne.22254:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f1, $f5, $f1
    fmul    $f8, $f9, $f5
    load    [$i2 + 18], $f8
    fmul    $f6, $f10, $f6
    fmul    $f1, $f8, $f1
    fadd    $f7, $f5, $f5
    fadd    $f5, $f6, $f5
    fadd    $f5, $f1, $f1
    be      $i4, 3, be.22255
.count dual_jmp
    b       bne.22255
be.22254:
    mov     $f7, $f1                    # |    516,247 |    516,247 |          0 |          0 |
    be      $i4, 3, be.22255            # |    516,247 |    516,247 |          0 |         13 |
bne.22255:
    ble     $f0, $f1, ble.22256
.count dual_jmp
    b       bg.22256
be.22255:
    fsub    $f1, $fc0, $f1              # |    516,247 |    516,247 |          0 |          0 |
    ble     $f0, $f1, ble.22256         # |    516,247 |    516,247 |          0 |     80,961 |
bg.22256:
    be      $i5, 0, be.22258            # |    331,762 |    331,762 |          0 |          6 |
.count dual_jmp
    b       bne.22258
ble.22256:
    be      $i5, 0, bne.22258           # |    184,485 |    184,485 |          0 |          2 |
.count dual_jmp
    b       be.22258
be.22250:
    load    [$i2 + 10], $i4             # |    460,724 |    460,724 |      3,538 |          0 |
    load    [$i2 + 4], $f7              # |    460,724 |    460,724 |      4,253 |          0 |
    fmul    $f7, $f1, $f1               # |    460,724 |    460,724 |          0 |          0 |
    load    [$i2 + 5], $f8              # |    460,724 |    460,724 |      2,923 |          0 |
    fmul    $f8, $f5, $f5               # |    460,724 |    460,724 |          0 |          0 |
    load    [$i2 + 6], $f9              # |    460,724 |    460,724 |      2,852 |          0 |
    fmul    $f9, $f6, $f6               # |    460,724 |    460,724 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |    460,724 |    460,724 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |    460,724 |    460,724 |          0 |          0 |
    ble     $f0, $f1, ble.22251         # |    460,724 |    460,724 |          0 |          4 |
bg.22251:
    be      $i4, 0, be.22258
.count dual_jmp
    b       bne.22258
ble.22251:
    be      $i4, 0, bne.22258           # |    460,724 |    460,724 |          0 |     34,439 |
be.22258:
    add     $i1, 1, $i2                 # |  1,238,697 |  1,238,697 |          0 |          0 |
    load    [$i3 + $i2], $i2            # |  1,238,697 |  1,238,697 |     29,808 |          0 |
    be      $i2, -1, be.22296           # |  1,238,697 |  1,238,697 |          0 |     61,749 |
bne.22260:
    load    [ext_objects + $i2], $i2    # |    641,735 |    641,735 |      8,905 |          0 |
    load    [$i2 + 1], $i4              # |    641,735 |    641,735 |      7,096 |          0 |
    load    [$i2 + 7], $f1              # |    641,735 |    641,735 |     17,001 |          0 |
    load    [$i2 + 8], $f5              # |    641,735 |    641,735 |     17,386 |          0 |
    fsub    $f2, $f1, $f1               # |    641,735 |    641,735 |          0 |          0 |
    load    [$i2 + 9], $f6              # |    641,735 |    641,735 |     15,282 |          0 |
    fsub    $f3, $f5, $f5               # |    641,735 |    641,735 |          0 |          0 |
    fsub    $f4, $f6, $f6               # |    641,735 |    641,735 |          0 |          0 |
    bne     $i4, 1, bne.22261           # |    641,735 |    641,735 |          0 |      1,919 |
be.22261:
    load    [$i2 + 4], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.22264
bg.22262:
    load    [$i2 + 5], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, bg.22264
ble.22264:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22276
bg.22264:
    load    [$i2 + 6], $f1
    fabs    $f6, $f5
    load    [$i2 + 10], $i2
    ble     $f1, $f5, ble.22266
bg.22266:
    be      $i2, 0, be.22276
.count dual_jmp
    b       bne.22258
ble.22266:
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22276
bne.22261:
    be      $i4, 2, be.22268            # |    641,735 |    641,735 |          0 |     26,306 |
bne.22268:
    load    [$i2 + 10], $i5             # |    609,910 |    609,910 |      6,830 |          0 |
    fmul    $f1, $f1, $f7               # |    609,910 |    609,910 |          0 |          0 |
    load    [$i2 + 3], $i6              # |    609,910 |    609,910 |     12,255 |          0 |
    fmul    $f5, $f5, $f8               # |    609,910 |    609,910 |          0 |          0 |
    load    [$i2 + 4], $f9              # |    609,910 |    609,910 |      7,865 |          0 |
    fmul    $f6, $f6, $f11              # |    609,910 |    609,910 |          0 |          0 |
    load    [$i2 + 5], $f10             # |    609,910 |    609,910 |      9,750 |          0 |
    fmul    $f7, $f9, $f7               # |    609,910 |    609,910 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |    609,910 |    609,910 |          0 |          0 |
    load    [$i2 + 6], $f9              # |    609,910 |    609,910 |      9,683 |          0 |
    fmul    $f11, $f9, $f9              # |    609,910 |    609,910 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    609,910 |    609,910 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    609,910 |    609,910 |          0 |          0 |
    be      $i6, 0, be.22272            # |    609,910 |    609,910 |          0 |          4 |
bne.22272:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f1, $f5, $f1
    fmul    $f8, $f9, $f5
    load    [$i2 + 18], $f8
    fmul    $f6, $f10, $f6
    fmul    $f1, $f8, $f1
    fadd    $f7, $f5, $f5
    fadd    $f5, $f6, $f5
    fadd    $f5, $f1, $f1
    be      $i4, 3, be.22273
.count dual_jmp
    b       bne.22273
be.22272:
    mov     $f7, $f1                    # |    609,910 |    609,910 |          0 |          0 |
    be      $i4, 3, be.22273            # |    609,910 |    609,910 |          0 |          4 |
bne.22273:
    ble     $f0, $f1, ble.22274
.count dual_jmp
    b       bg.22274
be.22273:
    fsub    $f1, $fc0, $f1              # |    609,910 |    609,910 |          0 |          0 |
    ble     $f0, $f1, ble.22274         # |    609,910 |    609,910 |          0 |    131,069 |
bg.22274:
    be      $i5, 0, be.22276            # |    310,196 |    310,196 |          0 |     92,276 |
.count dual_jmp
    b       bne.22258                   # |     66,926 |     66,926 |          0 |          0 |
ble.22274:
    be      $i5, 0, bne.22258           # |    299,714 |    299,714 |          0 |    113,202 |
.count dual_jmp
    b       be.22276                    # |    191,366 |    191,366 |          0 |      1,249 |
be.22268:
    load    [$i2 + 10], $i4             # |     31,825 |     31,825 |        363 |          0 |
    load    [$i2 + 4], $f7              # |     31,825 |     31,825 |        244 |          0 |
    load    [$i2 + 5], $f8              # |     31,825 |     31,825 |        126 |          0 |
    fmul    $f7, $f1, $f1               # |     31,825 |     31,825 |          0 |          0 |
    load    [$i2 + 6], $f9              # |     31,825 |     31,825 |        222 |          0 |
    fmul    $f8, $f5, $f5               # |     31,825 |     31,825 |          0 |          0 |
    fmul    $f9, $f6, $f6               # |     31,825 |     31,825 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |     31,825 |     31,825 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |     31,825 |     31,825 |          0 |          0 |
    ble     $f0, $f1, ble.22269         # |     31,825 |     31,825 |          0 |      8,025 |
bg.22269:
    be      $i4, 0, be.22276            # |     11,407 |     11,407 |          0 |          0 |
.count dual_jmp
    b       bne.22258                   # |     11,407 |     11,407 |          0 |          0 |
ble.22269:
    be      $i4, 0, bne.22258           # |     20,418 |     20,418 |          0 |      4,617 |
be.22276:
    add     $i1, 2, $i2                 # |    455,054 |    455,054 |          0 |          0 |
    load    [$i3 + $i2], $i2            # |    455,054 |    455,054 |     17,879 |          0 |
    be      $i2, -1, be.22296           # |    455,054 |    455,054 |          0 |      3,378 |
bne.22278:
    load    [ext_objects + $i2], $i2    # |    235,603 |    235,603 |      8,619 |          0 |
    load    [$i2 + 1], $i4              # |    235,603 |    235,603 |      4,392 |          0 |
    load    [$i2 + 7], $f1              # |    235,603 |    235,603 |      8,309 |          0 |
    fsub    $f2, $f1, $f1               # |    235,603 |    235,603 |          0 |          0 |
    load    [$i2 + 8], $f5              # |    235,603 |    235,603 |      8,219 |          0 |
    fsub    $f3, $f5, $f5               # |    235,603 |    235,603 |          0 |          0 |
    load    [$i2 + 9], $f6              # |    235,603 |    235,603 |      7,619 |          0 |
    fsub    $f4, $f6, $f6               # |    235,603 |    235,603 |          0 |          0 |
    bne     $i4, 1, bne.22279           # |    235,603 |    235,603 |          0 |          2 |
be.22279:
    load    [$i2 + 4], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.22282
bg.22280:
    load    [$i2 + 5], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, bg.22282
ble.22282:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22294
bg.22282:
    load    [$i2 + 6], $f1
    fabs    $f6, $f5
    load    [$i2 + 10], $i2
    ble     $f1, $f5, ble.22284
bg.22284:
    be      $i2, 0, be.22294
.count dual_jmp
    b       bne.22258
ble.22284:
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22294
bne.22279:
    be      $i4, 2, be.22286            # |    235,603 |    235,603 |          0 |     48,160 |
bne.22286:
    load    [$i2 + 10], $i5             # |    189,295 |    189,295 |      2,944 |          0 |
    load    [$i2 + 3], $i6              # |    189,295 |    189,295 |      4,921 |          0 |
    fmul    $f1, $f1, $f7               # |    189,295 |    189,295 |          0 |          0 |
    fmul    $f5, $f5, $f8               # |    189,295 |    189,295 |          0 |          0 |
    load    [$i2 + 4], $f9              # |    189,295 |    189,295 |      6,601 |          0 |
    load    [$i2 + 5], $f10             # |    189,295 |    189,295 |      5,925 |          0 |
    fmul    $f6, $f6, $f11              # |    189,295 |    189,295 |          0 |          0 |
    fmul    $f7, $f9, $f7               # |    189,295 |    189,295 |          0 |          0 |
    load    [$i2 + 6], $f9              # |    189,295 |    189,295 |      6,239 |          0 |
    fmul    $f8, $f10, $f8              # |    189,295 |    189,295 |          0 |          0 |
    fmul    $f11, $f9, $f9              # |    189,295 |    189,295 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |    189,295 |    189,295 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |    189,295 |    189,295 |          0 |          0 |
    be      $i6, 0, be.22290            # |    189,295 |    189,295 |          0 |          2 |
bne.22290:
    fmul    $f5, $f6, $f8
    load    [$i2 + 16], $f9
    fmul    $f6, $f1, $f6
    load    [$i2 + 17], $f10
    fmul    $f1, $f5, $f1
    fmul    $f8, $f9, $f5
    load    [$i2 + 18], $f8
    fmul    $f6, $f10, $f6
    fmul    $f1, $f8, $f1
    fadd    $f7, $f5, $f5
    fadd    $f5, $f6, $f5
    fadd    $f5, $f1, $f1
    be      $i4, 3, be.22291
.count dual_jmp
    b       bne.22291
be.22290:
    mov     $f7, $f1                    # |    189,295 |    189,295 |          0 |          0 |
    be      $i4, 3, be.22291            # |    189,295 |    189,295 |          0 |          2 |
bne.22291:
    ble     $f0, $f1, ble.22292
.count dual_jmp
    b       bg.22292
be.22291:
    fsub    $f1, $fc0, $f1              # |    189,295 |    189,295 |          0 |          0 |
    ble     $f0, $f1, ble.22292         # |    189,295 |    189,295 |          0 |     48,968 |
bg.22292:
    be      $i5, 0, be.22294            # |     36,217 |     36,217 |          0 |          0 |
.count dual_jmp
    b       bne.22258                   # |     36,217 |     36,217 |          0 |         39 |
ble.22292:
    be      $i5, 0, bne.22258           # |    153,078 |    153,078 |          0 |          0 |
.count dual_jmp
    b       be.22294                    # |    153,078 |    153,078 |          0 |          2 |
be.22286:
    load    [$i2 + 10], $i4             # |     46,308 |     46,308 |      2,212 |          0 |
    load    [$i2 + 4], $f7              # |     46,308 |     46,308 |      1,308 |          0 |
    fmul    $f7, $f1, $f1               # |     46,308 |     46,308 |          0 |          0 |
    load    [$i2 + 5], $f8              # |     46,308 |     46,308 |        973 |          0 |
    fmul    $f8, $f5, $f5               # |     46,308 |     46,308 |          0 |          0 |
    load    [$i2 + 6], $f9              # |     46,308 |     46,308 |      1,187 |          0 |
    fmul    $f9, $f6, $f6               # |     46,308 |     46,308 |          0 |          0 |
    fadd    $f1, $f5, $f1               # |     46,308 |     46,308 |          0 |          0 |
    fadd    $f1, $f6, $f1               # |     46,308 |     46,308 |          0 |          0 |
    ble     $f0, $f1, ble.22287         # |     46,308 |     46,308 |          0 |     11,555 |
bg.22287:
    be      $i4, 0, be.22294            # |     20,261 |     20,261 |          0 |        361 |
.count dual_jmp
    b       bne.22258                   # |     20,261 |     20,261 |          0 |        674 |
ble.22287:
    be      $i4, 0, bne.22258           # |     26,047 |     26,047 |          0 |         23 |
be.22294:
    add     $i1, 3, $i2                 # |    179,125 |    179,125 |          0 |          0 |
    load    [$i3 + $i2], $i2            # |    179,125 |    179,125 |     14,667 |          0 |
    be      $i2, -1, be.22296           # |    179,125 |    179,125 |          0 |      9,784 |
bne.22296:
    load    [ext_objects + $i2], $i2
    load    [$i2 + 1], $i4
    load    [$i2 + 9], $f1
    load    [$i2 + 8], $f5
    fsub    $f4, $f1, $f1
    load    [$i2 + 7], $f6
    fsub    $f3, $f5, $f5
    fsub    $f2, $f6, $f6
    bne     $i4, 1, bne.22297
be.22297:
    load    [$i2 + 4], $f7
    fabs    $f6, $f6
    ble     $f7, $f6, ble.22299
bg.22298:
    load    [$i2 + 5], $f6
    fabs    $f5, $f5
    bg      $f6, $f5, bg.22299
ble.22299:
    load    [$i2 + 10], $i2
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22312
bg.22299:
    load    [$i2 + 6], $f5
    fabs    $f1, $f1
    load    [$i2 + 10], $i2
    ble     $f5, $f1, ble.22300
bg.22300:
    be      $i2, 0, be.22312
.count dual_jmp
    b       bne.22258
ble.22300:
    be      $i2, 0, bne.22258
.count dual_jmp
    b       be.22312
bne.22297:
    be      $i4, 2, be.22304
bne.22304:
    load    [$i2 + 10], $i5
    fmul    $f6, $f6, $f7
    load    [$i2 + 3], $i6
    fmul    $f5, $f5, $f8
    load    [$i2 + 4], $f9
    fmul    $f1, $f1, $f11
    load    [$i2 + 5], $f10
    fmul    $f7, $f9, $f7
    fmul    $f8, $f10, $f8
    load    [$i2 + 6], $f9
    fmul    $f11, $f9, $f9
    fadd    $f7, $f8, $f7
    fadd    $f7, $f9, $f7
    be      $i6, 0, be.22308
bne.22308:
    fmul    $f5, $f1, $f8
    load    [$i2 + 16], $f9
    fmul    $f1, $f6, $f1
    load    [$i2 + 17], $f10
    fmul    $f6, $f5, $f5
    fmul    $f8, $f9, $f6
    load    [$i2 + 18], $f8
    fmul    $f1, $f10, $f1
    fmul    $f5, $f8, $f5
    fadd    $f7, $f6, $f6
    fadd    $f6, $f1, $f1
    fadd    $f1, $f5, $f1
    be      $i4, 3, be.22309
.count dual_jmp
    b       bne.22309
be.22308:
    mov     $f7, $f1
    be      $i4, 3, be.22309
bne.22309:
    ble     $f0, $f1, ble.22310
.count dual_jmp
    b       bg.22310
be.22309:
    fsub    $f1, $fc0, $f1
    ble     $f0, $f1, ble.22310
bg.22310:
    be      $i5, 0, be.22312
.count dual_jmp
    b       bne.22258
ble.22310:
    be      $i5, 0, bne.22258
.count dual_jmp
    b       be.22312
be.22304:
    load    [$i2 + 10], $i4
    load    [$i2 + 4], $f7
    load    [$i2 + 5], $f8
    fmul    $f7, $f6, $f6
    load    [$i2 + 6], $f9
    fmul    $f8, $f5, $f5
    fmul    $f9, $f1, $f1
    fadd    $f6, $f5, $f5
    fadd    $f5, $f1, $f1
    ble     $f0, $f1, ble.22305
bg.22305:
    be      $i4, 0, be.22312
.count dual_jmp
    b       bne.22258
ble.22305:
    be      $i4, 0, bne.22258
be.22312:
    add     $i1, 4, $i1
    b       check_all_inside.2856
bne.22258:
    li      0, $i1                      # |    698,341 |    698,341 |          0 |          0 |
    ret                                 # |    698,341 |    698,341 |          0 |          0 |
be.22296:
    li      1, $i1                      # |  1,017,620 |  1,017,620 |          0 |          0 |
    ret                                 # |  1,017,620 |  1,017,620 |          0 |          0 |
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i7, $i3)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra]
######################################################################
.align 2
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i3 + $i7], $i1            # |  4,222,682 |  4,222,682 |      9,809 |          0 |
    be      $i1, -1, be.22336           # |  4,222,682 |  4,222,682 |          0 |    216,752 |
bne.22313:
    load    [ext_objects + $i1], $i2    # |  3,594,836 |  3,594,836 |      8,706 |          0 |
    load    [ext_light_dirvec + 3], $i4 # |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [ext_intersection_point + 0], $f1# |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [$i2 + 1], $i5              # |  3,594,836 |  3,594,836 |      5,252 |          0 |
    load    [$i2 + 7], $f2              # |  3,594,836 |  3,594,836 |     39,521 |          0 |
    fsub    $f1, $f2, $f1               # |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [ext_intersection_point + 1], $f3# |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [$i2 + 8], $f4              # |  3,594,836 |  3,594,836 |     40,129 |          0 |
    load    [ext_intersection_point + 2], $f2# |  3,594,836 |  3,594,836 |          0 |          0 |
    fsub    $f3, $f4, $f3               # |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [$i2 + 9], $f5              # |  3,594,836 |  3,594,836 |     43,843 |          0 |
    fsub    $f2, $f5, $f2               # |  3,594,836 |  3,594,836 |          0 |          0 |
    load    [$i4 + $i1], $i4            # |  3,594,836 |  3,594,836 |     97,050 |          0 |
    load    [$i4 + 0], $f4              # |  3,594,836 |  3,594,836 |    100,570 |          0 |
    bne     $i5, 1, bne.22314           # |  3,594,836 |  3,594,836 |          0 |    379,242 |
be.22314:
    fsub    $f4, $f1, $f4               # |  1,409,362 |  1,409,362 |          0 |          0 |
    load    [$i2 + 5], $f5              # |  1,409,362 |  1,409,362 |      4,741 |          0 |
    load    [$i4 + 1], $f7              # |  1,409,362 |  1,409,362 |     40,598 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f6# |  1,409,362 |  1,409,362 |          0 |          0 |
    fmul    $f4, $f7, $f4               # |  1,409,362 |  1,409,362 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |  1,409,362 |  1,409,362 |          0 |          0 |
    fadd_a  $f6, $f3, $f6               # |  1,409,362 |  1,409,362 |          0 |          0 |
    ble     $f5, $f6, be.22317          # |  1,409,362 |  1,409,362 |          0 |    310,266 |
bg.22315:
    load    [%{ext_light_dirvec + 0} + 2], $f5# |    411,033 |    411,033 |         21 |          0 |
    load    [$i2 + 6], $f6              # |    411,033 |    411,033 |      2,946 |          0 |
    fmul    $f4, $f5, $f5               # |    411,033 |    411,033 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |    411,033 |    411,033 |          0 |          0 |
    ble     $f6, $f5, be.22317          # |    411,033 |    411,033 |          0 |     56,015 |
bg.22316:
    load    [$i4 + 1], $f5              # |    274,783 |    274,783 |          0 |          0 |
    bne     $f5, $f0, bne.22317         # |    274,783 |    274,783 |          0 |         10 |
be.22317:
    load    [$i4 + 2], $f4              # |  1,134,579 |  1,134,579 |     36,249 |          0 |
    fsub    $f4, $f3, $f4               # |  1,134,579 |  1,134,579 |          0 |          0 |
    load    [$i2 + 4], $f5              # |  1,134,579 |  1,134,579 |      3,141 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f6# |  1,134,579 |  1,134,579 |      2,387 |          0 |
    load    [$i4 + 3], $f7              # |  1,134,579 |  1,134,579 |     36,720 |          0 |
    fmul    $f4, $f7, $f4               # |  1,134,579 |  1,134,579 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |  1,134,579 |  1,134,579 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |  1,134,579 |  1,134,579 |          0 |          0 |
    ble     $f5, $f6, be.22321          # |  1,134,579 |  1,134,579 |          0 |    272,542 |
bg.22319:
    load    [%{ext_light_dirvec + 0} + 2], $f5# |    502,169 |    502,169 |      1,515 |          0 |
    load    [$i2 + 6], $f6              # |    502,169 |    502,169 |      2,684 |          0 |
    fmul    $f4, $f5, $f5               # |    502,169 |    502,169 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |    502,169 |    502,169 |          0 |          0 |
    ble     $f6, $f5, be.22321          # |    502,169 |    502,169 |          0 |     84,097 |
bg.22320:
    load    [$i4 + 3], $f5              # |    363,291 |    363,291 |          0 |          0 |
    be      $f5, $f0, be.22321          # |    363,291 |    363,291 |          0 |          2 |
bne.22317:
    mov     $f4, $fg0                   # |    638,074 |    638,074 |          0 |          0 |
.count load_float
    load    [f.21980], $f1              # |    638,074 |    638,074 |      2,450 |          0 |
    ble     $f1, $fg0, ble.22334        # |    638,074 |    638,074 |          0 |     90,373 |
.count dual_jmp
    b       bg.22334                    # |    285,416 |    285,416 |          0 |         10 |
be.22321:
    load    [$i4 + 4], $f4              # |    771,288 |    771,288 |     35,773 |          0 |
    fsub    $f4, $f2, $f2               # |    771,288 |    771,288 |          0 |          0 |
    load    [$i2 + 4], $f5              # |    771,288 |    771,288 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f6# |    771,288 |    771,288 |          0 |          0 |
    load    [$i4 + 5], $f4              # |    771,288 |    771,288 |     37,924 |          0 |
    fmul    $f2, $f4, $f2               # |    771,288 |    771,288 |          0 |          0 |
    fmul    $f2, $f6, $f4               # |    771,288 |    771,288 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |    771,288 |    771,288 |          0 |          0 |
    ble     $f5, $f1, ble.22334         # |    771,288 |    771,288 |          0 |    100,700 |
bg.22323:
    load    [%{ext_light_dirvec + 0} + 1], $f1# |    129,293 |    129,293 |          0 |          0 |
    load    [$i2 + 5], $f4              # |    129,293 |    129,293 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |    129,293 |    129,293 |          0 |          0 |
    fadd_a  $f1, $f3, $f1               # |    129,293 |    129,293 |          0 |          0 |
    ble     $f4, $f1, ble.22334         # |    129,293 |    129,293 |          0 |     34,512 |
bg.22324:
    load    [$i4 + 5], $f1              # |     50,839 |     50,839 |          0 |          0 |
    be      $f1, $f0, ble.22334         # |     50,839 |     50,839 |          0 |        550 |
bne.22325:
    mov     $f2, $fg0                   # |     50,839 |     50,839 |          0 |          0 |
.count load_float
    load    [f.21980], $f1              # |     50,839 |     50,839 |        498 |          0 |
    ble     $f1, $fg0, ble.22334        # |     50,839 |     50,839 |          0 |      4,203 |
.count dual_jmp
    b       bg.22334                    # |     46,342 |     46,342 |          0 |          8 |
bne.22314:
    be      $i5, 2, be.22326            # |  2,185,474 |  2,185,474 |          0 |     49,755 |
bne.22326:
    be      $f4, $f0, ble.22334         # |  1,619,112 |  1,619,112 |          0 |      1,798 |
bne.22328:
    load    [$i4 + 1], $f5              # |  1,619,112 |  1,619,112 |     46,245 |          0 |
    fmul    $f5, $f1, $f5               # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i4 + 2], $f6              # |  1,619,112 |  1,619,112 |     45,862 |          0 |
    fmul    $f6, $f3, $f6               # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i4 + 3], $f7              # |  1,619,112 |  1,619,112 |     46,985 |          0 |
    fmul    $f7, $f2, $f7               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fmul    $f1, $f1, $f8               # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i2 + 4], $f10             # |  1,619,112 |  1,619,112 |     19,576 |          0 |
    fmul    $f3, $f3, $f9               # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i2 + 5], $f11             # |  1,619,112 |  1,619,112 |     14,828 |          0 |
    fadd    $f5, $f6, $f5               # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i2 + 3], $i6              # |  1,619,112 |  1,619,112 |     20,057 |          0 |
    fmul    $f8, $f10, $f6              # |  1,619,112 |  1,619,112 |          0 |          0 |
    load    [$i2 + 6], $f10             # |  1,619,112 |  1,619,112 |     14,709 |          0 |
    fmul    $f9, $f11, $f8              # |  1,619,112 |  1,619,112 |          0 |          0 |
    fmul    $f2, $f2, $f9               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fadd    $f5, $f7, $f5               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fadd    $f6, $f8, $f6               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fmul    $f9, $f10, $f7              # |  1,619,112 |  1,619,112 |          0 |          0 |
    fmul    $f5, $f5, $f8               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fadd    $f6, $f7, $f6               # |  1,619,112 |  1,619,112 |          0 |          0 |
    be      $i6, 0, be.22329            # |  1,619,112 |  1,619,112 |          0 |         11 |
bne.22329:
    fmul    $f3, $f2, $f7
    load    [$i2 + 16], $f9
    fmul    $f2, $f1, $f2
    load    [$i2 + 17], $f10
    fmul    $f1, $f3, $f1
    fmul    $f7, $f9, $f3
    load    [$i2 + 18], $f7
    fmul    $f2, $f10, $f2
    fmul    $f1, $f7, $f1
    fadd    $f6, $f3, $f3
    fadd    $f3, $f2, $f2
    fadd    $f2, $f1, $f1
    be      $i5, 3, be.22330
.count dual_jmp
    b       bne.22330
be.22329:
    mov     $f6, $f1                    # |  1,619,112 |  1,619,112 |          0 |          0 |
    be      $i5, 3, be.22330            # |  1,619,112 |  1,619,112 |          0 |         84 |
bne.22330:
    fmul    $f4, $f1, $f1
    fsub    $f8, $f1, $f1
    ble     $f1, $f0, ble.22334
.count dual_jmp
    b       bg.22331
be.22330:
    fsub    $f1, $fc0, $f1              # |  1,619,112 |  1,619,112 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |  1,619,112 |  1,619,112 |          0 |          0 |
    fsub    $f8, $f1, $f1               # |  1,619,112 |  1,619,112 |          0 |          0 |
    ble     $f1, $f0, ble.22334         # |  1,619,112 |  1,619,112 |          0 |     67,697 |
bg.22331:
    load    [$i2 + 10], $i2             # |    348,474 |    348,474 |        105 |          0 |
    fsqrt   $f1, $f1                    # |    348,474 |    348,474 |          0 |          0 |
    load    [$i4 + 4], $f2              # |    348,474 |    348,474 |     24,674 |          0 |
    be      $i2, 0, be.22332            # |    348,474 |    348,474 |          0 |     55,550 |
bne.22332:
    fadd    $f5, $f1, $f1               # |     70,027 |     70,027 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |     70,027 |     70,027 |          0 |          0 |
.count load_float
    load    [f.21980], $f1              # |     70,027 |     70,027 |          0 |          0 |
    ble     $f1, $fg0, ble.22334        # |     70,027 |     70,027 |          0 |      7,626 |
.count dual_jmp
    b       bg.22334                    # |     12,670 |     12,670 |          0 |        127 |
be.22332:
    fsub    $f5, $f1, $f1               # |    278,447 |    278,447 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |    278,447 |    278,447 |          0 |          0 |
.count load_float
    load    [f.21980], $f1              # |    278,447 |    278,447 |          0 |          0 |
    ble     $f1, $fg0, ble.22334        # |    278,447 |    278,447 |          0 |     34,040 |
.count dual_jmp
    b       bg.22334                    # |    218,560 |    218,560 |          0 |     39,637 |
be.22326:
    ble     $f0, $f4, ble.22334         # |    566,362 |    566,362 |          0 |        435 |
bg.22327:
    load    [$i4 + 1], $f4              # |    554,946 |    554,946 |      8,492 |          0 |
    load    [$i4 + 2], $f5              # |    554,946 |    554,946 |      9,950 |          0 |
    fmul    $f4, $f1, $f1               # |    554,946 |    554,946 |          0 |          0 |
    load    [$i4 + 3], $f6              # |    554,946 |    554,946 |     10,064 |          0 |
    fmul    $f5, $f3, $f3               # |    554,946 |    554,946 |          0 |          0 |
    fmul    $f6, $f2, $f2               # |    554,946 |    554,946 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |    554,946 |    554,946 |          0 |          0 |
    fadd    $f1, $f2, $fg0              # |    554,946 |    554,946 |          0 |          0 |
.count load_float
    load    [f.21980], $f1              # |    554,946 |    554,946 |      7,566 |          0 |
    bg      $f1, $fg0, bg.22334         # |    554,946 |    554,946 |          0 |          2 |
ble.22334:
    load    [ext_objects + $i1], $i1    # |  3,031,848 |  3,031,848 |          0 |          0 |
    load    [$i1 + 10], $i1             # |  3,031,848 |  3,031,848 |     11,270 |          0 |
    bne     $i1, 0, bne.22353           # |  3,031,848 |  3,031,848 |          0 |      2,558 |
be.22336:
    li      0, $i1                      # |  3,033,900 |  3,033,900 |          0 |          0 |
    jr      $ra1                        # |  3,033,900 |  3,033,900 |          0 |          0 |
bg.22334:
    load    [$i3 + 0], $i1              # |    562,988 |    562,988 |          0 |          0 |
    be      $i1, -1, bne.22355          # |    562,988 |    562,988 |          0 |        338 |
bne.22337:
    fadd    $fg0, $fc11, $f1            # |    562,988 |    562,988 |          0 |          0 |
    load    [ext_objects + $i1], $i1    # |    562,988 |    562,988 |          0 |          0 |
    load    [ext_intersection_point + 0], $f2# |    562,988 |    562,988 |          0 |          0 |
    fmul    $fg14, $f1, $f5             # |    562,988 |    562,988 |          0 |          0 |
    load    [ext_intersection_point + 1], $f3# |    562,988 |    562,988 |          0 |          0 |
    fmul    $fg12, $f1, $f7             # |    562,988 |    562,988 |          0 |          0 |
    load    [$i1 + 1], $i2              # |    562,988 |    562,988 |          0 |          0 |
    fmul    $fg13, $f1, $f1             # |    562,988 |    562,988 |          0 |          0 |
    load    [$i1 + 7], $f4              # |    562,988 |    562,988 |          0 |          0 |
    fadd    $f5, $f2, $f2               # |    562,988 |    562,988 |          0 |          0 |
    load    [$i1 + 8], $f6              # |    562,988 |    562,988 |          0 |          0 |
    fadd    $f7, $f3, $f3               # |    562,988 |    562,988 |          0 |          0 |
    load    [$i1 + 9], $f8              # |    562,988 |    562,988 |          0 |          0 |
    fsub    $f2, $f4, $f4               # |    562,988 |    562,988 |          0 |          0 |
    load    [ext_intersection_point + 2], $f9# |    562,988 |    562,988 |          0 |          0 |
    fadd    $f1, $f9, $f1               # |    562,988 |    562,988 |          0 |          0 |
    fsub    $f3, $f6, $f5               # |    562,988 |    562,988 |          0 |          0 |
    fsub    $f1, $f8, $f6               # |    562,988 |    562,988 |          0 |          0 |
    bne     $i2, 1, bne.22338           # |    562,988 |    562,988 |          0 |     18,224 |
be.22338:
    load    [$i1 + 4], $f7              # |    541,320 |    541,320 |        761 |          0 |
    fabs    $f4, $f4                    # |    541,320 |    541,320 |          0 |          0 |
    ble     $f7, $f4, ble.22341         # |    541,320 |    541,320 |          0 |     77,303 |
bg.22339:
    load    [$i1 + 5], $f4              # |    484,973 |    484,973 |          0 |          0 |
    fabs    $f5, $f5                    # |    484,973 |    484,973 |          0 |          0 |
    bg      $f4, $f5, bg.22341          # |    484,973 |    484,973 |          0 |      5,597 |
ble.22341:
    load    [$i1 + 10], $i1             # |     61,929 |     61,929 |          0 |          0 |
    be      $i1, 0, bne.22353           # |     61,929 |     61,929 |          0 |        237 |
.count dual_jmp
    b       be.22353
bg.22341:
    load    [$i1 + 6], $f4              # |    479,391 |    479,391 |          0 |          0 |
    fabs    $f6, $f5                    # |    479,391 |    479,391 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    479,391 |    479,391 |      1,701 |          0 |
    ble     $f4, $f5, ble.22343         # |    479,391 |    479,391 |          0 |      1,683 |
bg.22343:
    be      $i1, 0, be.22353            # |    477,186 |    477,186 |          0 |          4 |
.count dual_jmp
    b       bne.22353
ble.22343:
    be      $i1, 0, bne.22353           # |      2,205 |      2,205 |          0 |          4 |
.count dual_jmp
    b       be.22353
bne.22338:
    be      $i2, 2, be.22345            # |     21,668 |     21,668 |          0 |          0 |
bne.22345:
    load    [$i1 + 10], $i4             # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f4, $f4, $f7               # |     21,668 |     21,668 |          0 |          0 |
    load    [$i1 + 4], $f9              # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f5, $f5, $f8               # |     21,668 |     21,668 |          0 |          0 |
    load    [$i1 + 5], $f10             # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f6, $f6, $f11              # |     21,668 |     21,668 |          0 |          0 |
    load    [$i1 + 3], $i5              # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f7, $f9, $f7               # |     21,668 |     21,668 |          0 |          0 |
    load    [$i1 + 6], $f9              # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |     21,668 |     21,668 |          0 |          0 |
    fmul    $f11, $f9, $f9              # |     21,668 |     21,668 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |     21,668 |     21,668 |          0 |          0 |
    fadd    $f7, $f9, $f7               # |     21,668 |     21,668 |          0 |          0 |
    be      $i5, 0, be.22349            # |     21,668 |     21,668 |          0 |        369 |
bne.22349:
    fmul    $f5, $f6, $f8
    load    [$i1 + 16], $f9
    fmul    $f6, $f4, $f6
    load    [$i1 + 17], $f10
    fmul    $f4, $f5, $f4
    fmul    $f8, $f9, $f5
    load    [$i1 + 18], $f8
    fmul    $f6, $f10, $f6
    fmul    $f4, $f8, $f4
    fadd    $f7, $f5, $f5
    fadd    $f5, $f6, $f5
    fadd    $f5, $f4, $f4
    be      $i2, 3, be.22350
.count dual_jmp
    b       bne.22350
be.22349:
    mov     $f7, $f4                    # |     21,668 |     21,668 |          0 |          0 |
    be      $i2, 3, be.22350            # |     21,668 |     21,668 |          0 |          2 |
bne.22350:
    ble     $f0, $f4, ble.22351
.count dual_jmp
    b       bg.22351
be.22350:
    fsub    $f4, $fc0, $f4              # |     21,668 |     21,668 |          0 |          0 |
    ble     $f0, $f4, ble.22351         # |     21,668 |     21,668 |          0 |          0 |
bg.22351:
    be      $i4, 0, be.22353            # |     21,668 |     21,668 |          0 |      1,780 |
.count dual_jmp
    b       bne.22353
ble.22351:
    be      $i4, 0, bne.22353
.count dual_jmp
    b       be.22353
be.22345:
    load    [$i1 + 10], $i2
    load    [$i1 + 4], $f7
    fmul    $f7, $f4, $f4
    load    [$i1 + 5], $f8
    fmul    $f8, $f5, $f5
    load    [$i1 + 6], $f9
    fmul    $f9, $f6, $f6
    fadd    $f4, $f5, $f4
    fadd    $f4, $f6, $f4
    ble     $f0, $f4, ble.22346
bg.22346:
    be      $i2, 0, be.22353
.count dual_jmp
    b       bne.22353
ble.22346:
    be      $i2, 0, bne.22353
be.22353:
    li      1, $i1                      # |    498,854 |    498,854 |          0 |          0 |
.count move_args
    mov     $f1, $f4                    # |    498,854 |    498,854 |          0 |          0 |
    call    check_all_inside.2856       # |    498,854 |    498,854 |          0 |          0 |
    be      $i1, 0, bne.22353           # |    498,854 |    498,854 |          0 |      4,527 |
bne.22355:
    li      1, $i1                      # |    236,036 |    236,036 |          0 |          0 |
    jr      $ra1                        # |    236,036 |    236,036 |          0 |          0 |
bne.22353:
    add     $i7, 1, $i7                 # |    952,746 |    952,746 |          0 |          0 |
    b       shadow_check_and_group.2862 # |    952,746 |    952,746 |          0 |      3,023 |
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i8, $i9)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.align 2
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i9 + $i8], $i1            # |    223,458 |    223,458 |        973 |          0 |
    be      $i1, -1, be.22370           # |    223,458 |    223,458 |          0 |         39 |
bne.22356:
    li      0, $i7                      # |    223,458 |    223,458 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    223,458 |    223,458 |      1,716 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    223,458 |    223,458 |          0 |          0 |
    bne     $i1, 0, bne.22357           # |    223,458 |    223,458 |          0 |        161 |
be.22357:
    add     $i8, 1, $i1                 # |    113,398 |    113,398 |          0 |          0 |
    load    [$i9 + $i1], $i1            # |    113,398 |    113,398 |        105 |          0 |
    be      $i1, -1, be.22370           # |    113,398 |    113,398 |          0 |        240 |
bne.22358:
    li      0, $i7                      # |    113,398 |    113,398 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    113,398 |    113,398 |        793 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    113,398 |    113,398 |          0 |          0 |
    bne     $i1, 0, bne.22357           # |    113,398 |    113,398 |          0 |          7 |
be.22359:
    add     $i8, 2, $i1                 # |    106,750 |    106,750 |          0 |          0 |
    load    [$i9 + $i1], $i1            # |    106,750 |    106,750 |        367 |          0 |
    be      $i1, -1, be.22370           # |    106,750 |    106,750 |          0 |        351 |
bne.22360:
    li      0, $i7                      # |     96,421 |     96,421 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     96,421 |     96,421 |        719 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     96,421 |     96,421 |          0 |          0 |
    bne     $i1, 0, bne.22357           # |     96,421 |     96,421 |          0 |        358 |
be.22361:
    add     $i8, 3, $i1                 # |     94,251 |     94,251 |          0 |          0 |
    load    [$i9 + $i1], $i1            # |     94,251 |     94,251 |         41 |          0 |
    be      $i1, -1, be.22370           # |     94,251 |     94,251 |          0 |        736 |
bne.22362:
    li      0, $i7                      # |     94,251 |     94,251 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     94,251 |     94,251 |      1,217 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     94,251 |     94,251 |          0 |          0 |
    bne     $i1, 0, bne.22357           # |     94,251 |     94,251 |          0 |         29 |
be.22363:
    add     $i8, 4, $i1                 # |     82,765 |     82,765 |          0 |          0 |
    load    [$i9 + $i1], $i1            # |     82,765 |     82,765 |         41 |          0 |
    be      $i1, -1, be.22370           # |     82,765 |     82,765 |          0 |          4 |
bne.22364:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22365:
    add     $i8, 5, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.22370
bne.22366:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22367:
    add     $i8, 6, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.22370
bne.22368:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22357
be.22369:
    add     $i8, 7, $i1
    load    [$i9 + $i1], $i1
    be      $i1, -1, be.22370
bne.22370:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    be      $i1, 0, be.22371
bne.22357:
    li      1, $i1                      # |    130,364 |    130,364 |          0 |          0 |
    jr      $ra2                        # |    130,364 |    130,364 |          0 |          0 |
be.22371:
    add     $i8, 8, $i8
    b       shadow_check_one_or_group.2865
be.22370:
    li      0, $i1                      # |     93,094 |     93,094 |          0 |          0 |
    jr      $ra2                        # |     93,094 |     93,094 |          0 |          0 |
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i10, $i11)
# $ra = $ra3
# [$i1 - $i10]
# [$f1 - $f11]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.align 2
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i11 + $i10], $i9          # |    565,275 |    565,275 |          0 |          0 |
    load    [$i9 + 0], $i1              # |    565,275 |    565,275 |        140 |          0 |
    be      $i1, -1, be.22429           # |    565,275 |    565,275 |          0 |      6,293 |
bne.22372:
    be      $i1, 99, bne.22396          # |    554,946 |    554,946 |          0 |      5,309 |
bne.22373:
    load    [ext_objects + $i1], $i2    # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_light_dirvec + 3], $i3 # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_intersection_point + 0], $f1# |     10,329 |     10,329 |          0 |          0 |
    load    [ext_intersection_point + 1], $f2# |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 7], $f3              # |     10,329 |     10,329 |          0 |          0 |
    fsub    $f1, $f3, $f1               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 8], $f4              # |     10,329 |     10,329 |          0 |          0 |
    fsub    $f2, $f4, $f2               # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_intersection_point + 2], $f5# |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 9], $f3              # |     10,329 |     10,329 |          0 |          0 |
    load    [$i3 + $i1], $i1            # |     10,329 |     10,329 |          0 |          0 |
    fsub    $f5, $f3, $f3               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 1], $i4              # |     10,329 |     10,329 |          0 |          0 |
    load    [$i1 + 0], $f4              # |     10,329 |     10,329 |          0 |          0 |
    bne     $i4, 1, bne.22374           # |     10,329 |     10,329 |          0 |         52 |
be.22374:
    fsub    $f4, $f1, $f4               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 5], $f5              # |     10,329 |     10,329 |          0 |          0 |
    load    [$i1 + 1], $f7              # |     10,329 |     10,329 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 1], $f6# |     10,329 |     10,329 |          0 |          0 |
    fmul    $f4, $f7, $f4               # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |     10,329 |     10,329 |          0 |          0 |
    fadd_a  $f6, $f2, $f6               # |     10,329 |     10,329 |          0 |          0 |
    ble     $f5, $f6, be.22377          # |     10,329 |     10,329 |          0 |      2,443 |
bg.22375:
    load    [%{ext_light_dirvec + 0} + 2], $f5# |      3,872 |      3,872 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      3,872 |      3,872 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |      3,872 |      3,872 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      3,872 |      3,872 |          0 |          0 |
    ble     $f6, $f5, be.22377          # |      3,872 |      3,872 |          0 |          4 |
bg.22376:
    load    [$i1 + 1], $f5
    bne     $f5, $f0, bne.22377
be.22377:
    load    [$i1 + 2], $f4              # |     10,329 |     10,329 |         83 |          0 |
    fsub    $f4, $f2, $f4               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i2 + 4], $f5              # |     10,329 |     10,329 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f6# |     10,329 |     10,329 |          0 |          0 |
    load    [$i1 + 3], $f7              # |     10,329 |     10,329 |        111 |          0 |
    fmul    $f4, $f7, $f4               # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |     10,329 |     10,329 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |     10,329 |     10,329 |          0 |          0 |
    ble     $f5, $f6, be.22381          # |     10,329 |     10,329 |          0 |         76 |
bg.22379:
    load    [%{ext_light_dirvec + 0} + 2], $f5# |      1,255 |      1,255 |          0 |          0 |
    load    [$i2 + 6], $f6              # |      1,255 |      1,255 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |      1,255 |      1,255 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      1,255 |      1,255 |          0 |          0 |
    ble     $f6, $f5, be.22381          # |      1,255 |      1,255 |          0 |         77 |
bg.22380:
    load    [$i1 + 3], $f5
    be      $f5, $f0, be.22381
bne.22377:
    mov     $f4, $fg0
    ble     $fc4, $fg0, be.22428
.count dual_jmp
    b       bg.22394
be.22381:
    load    [$i1 + 4], $f4              # |     10,329 |     10,329 |        111 |          0 |
    load    [$i2 + 4], $f5              # |     10,329 |     10,329 |          0 |          0 |
    fsub    $f4, $f3, $f3               # |     10,329 |     10,329 |          0 |          0 |
    load    [%{ext_light_dirvec + 0} + 0], $f6# |     10,329 |     10,329 |          0 |          0 |
    load    [$i1 + 5], $f4              # |     10,329 |     10,329 |        136 |          0 |
    fmul    $f3, $f4, $f3               # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f3, $f6, $f4               # |     10,329 |     10,329 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |     10,329 |     10,329 |          0 |          0 |
    ble     $f5, $f1, be.22428          # |     10,329 |     10,329 |          0 |      2,634 |
bg.22383:
    load    [%{ext_light_dirvec + 0} + 1], $f1
    fmul    $f3, $f1, $f1
    load    [$i2 + 5], $f4
    fadd_a  $f1, $f2, $f1
    ble     $f4, $f1, be.22428
bg.22384:
    load    [$i1 + 5], $f1
    be      $f1, $f0, be.22428
bne.22385:
    mov     $f3, $fg0
    ble     $fc4, $fg0, be.22428
.count dual_jmp
    b       bg.22394
bne.22374:
    be      $i4, 2, be.22386
bne.22386:
    be      $f4, $f0, be.22428
bne.22388:
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f5
    load    [$i1 + 2], $f6
    fmul    $f6, $f2, $f6
    load    [$i1 + 3], $f7
    fmul    $f7, $f3, $f7
    fmul    $f1, $f1, $f8
    load    [$i2 + 4], $f10
    fmul    $f2, $f2, $f9
    load    [$i2 + 5], $f11
    fadd    $f5, $f6, $f5
    load    [$i2 + 3], $i3
    fmul    $f8, $f10, $f6
    load    [$i2 + 6], $f10
    fmul    $f9, $f11, $f8
    fmul    $f3, $f3, $f9
    fadd    $f5, $f7, $f5
    fadd    $f6, $f8, $f6
    fmul    $f9, $f10, $f7
    fmul    $f5, $f5, $f8
    fadd    $f6, $f7, $f6
    be      $i3, 0, be.22389
bne.22389:
    fmul    $f2, $f3, $f7
    load    [$i2 + 16], $f9
    fmul    $f3, $f1, $f3
    load    [$i2 + 17], $f10
    fmul    $f1, $f2, $f1
    fmul    $f7, $f9, $f2
    load    [$i2 + 18], $f7
    fmul    $f3, $f10, $f3
    fmul    $f1, $f7, $f1
    fadd    $f6, $f2, $f2
    fadd    $f2, $f3, $f2
    fadd    $f2, $f1, $f1
    be      $i4, 3, be.22390
.count dual_jmp
    b       bne.22390
be.22389:
    mov     $f6, $f1
    be      $i4, 3, be.22390
bne.22390:
    fmul    $f4, $f1, $f1
    fsub    $f8, $f1, $f1
    ble     $f1, $f0, be.22428
.count dual_jmp
    b       bg.22391
be.22390:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f8, $f1, $f1
    ble     $f1, $f0, be.22428
bg.22391:
    load    [$i2 + 10], $i2
    fsqrt   $f1, $f1
    load    [$i1 + 4], $f2
    be      $i2, 0, be.22392
bne.22392:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc4, $fg0, be.22428
.count dual_jmp
    b       bg.22394
be.22392:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ble     $fc4, $fg0, be.22428
.count dual_jmp
    b       bg.22394
be.22386:
    ble     $f0, $f4, be.22428
bg.22387:
    load    [$i1 + 1], $f4
    load    [$i1 + 2], $f5
    fmul    $f4, $f1, $f1
    load    [$i1 + 3], $f6
    fmul    $f5, $f2, $f2
    fmul    $f6, $f3, $f3
    fadd    $f1, $f2, $f1
    fadd    $f1, $f3, $fg0
    ble     $fc4, $fg0, be.22428
bg.22394:
    load    [$i9 + 1], $i1
    be      $i1, -1, be.22428
bne.22395:
    load    [ext_and_net + $i1], $i3
    li      0, $i7
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22396
be.22396:
    li      2, $i8
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.22428
bne.22396:
    load    [$i9 + 1], $i1              # |    544,617 |    544,617 |        140 |          0 |
    be      $i1, -1, be.22428           # |    544,617 |    544,617 |          0 |      1,094 |
bne.22414:
    load    [ext_and_net + $i1], $i3    # |    544,617 |    544,617 |      1,958 |          0 |
    li      0, $i7                      # |    544,617 |    544,617 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    544,617 |    544,617 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |    544,617 |    544,617 |          0 |     30,574 |
be.22415:
    load    [$i9 + 2], $i1              # |    544,617 |    544,617 |          0 |          0 |
    be      $i1, -1, be.22428           # |    544,617 |    544,617 |          0 |          0 |
bne.22416:
    li      0, $i7                      # |    544,617 |    544,617 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    544,617 |    544,617 |      3,030 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    544,617 |    544,617 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |    544,617 |    544,617 |          0 |          2 |
be.22417:
    load    [$i9 + 3], $i1              # |    543,033 |    543,033 |          0 |          0 |
    be      $i1, -1, be.22428           # |    543,033 |    543,033 |          0 |          0 |
bne.22418:
    li      0, $i7                      # |    543,033 |    543,033 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    543,033 |    543,033 |      1,838 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    543,033 |    543,033 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |    543,033 |    543,033 |          0 |      1,216 |
be.22419:
    load    [$i9 + 4], $i1              # |    541,083 |    541,083 |        250 |          0 |
    be      $i1, -1, be.22428           # |    541,083 |    541,083 |          0 |         12 |
bne.22420:
    li      0, $i7                      # |    541,083 |    541,083 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    541,083 |    541,083 |      1,017 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    541,083 |    541,083 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |    541,083 |    541,083 |          0 |        310 |
be.22421:
    load    [$i9 + 5], $i1              # |    540,669 |    540,669 |         23 |          0 |
    be      $i1, -1, be.22428           # |    540,669 |    540,669 |          0 |         14 |
bne.22422:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22423:
    load    [$i9 + 6], $i1
    be      $i1, -1, be.22428
bne.22424:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22425:
    load    [$i9 + 7], $i1
    be      $i1, -1, be.22428
bne.22426:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22410
be.22427:
    li      8, $i8
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, bne.22410
be.22428:
    add     $i10, 1, $i1                # |    550,998 |    550,998 |          0 |          0 |
    load    [$i11 + $i1], $i9           # |    550,998 |    550,998 |          0 |          0 |
    load    [$i9 + 0], $i1              # |    550,998 |    550,998 |          0 |          0 |
    be      $i1, -1, be.22429           # |    550,998 |    550,998 |          0 |     43,696 |
bne.22429:
    be      $i1, 99, bne.22434          # |     10,329 |     10,329 |          0 |          9 |
bne.22430:
    call    solver_fast.2796
    be      $i1, 0, be.22413
bne.22431:
    ble     $fc4, $fg0, be.22413
bg.22432:
    load    [$i9 + 1], $i1
    be      $i1, -1, be.22413
bne.22433:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22434
be.22434:
    load    [$i9 + 2], $i1
    be      $i1, -1, be.22413
bne.22435:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.22434
be.22436:
    li      3, $i8
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.22413
bne.22434:
    load    [$i9 + 1], $i1              # |     10,329 |     10,329 |          0 |          0 |
    be      $i1, -1, be.22413           # |     10,329 |     10,329 |          0 |          0 |
bne.22439:
    li      0, $i7                      # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     10,329 |     10,329 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     10,329 |     10,329 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |     10,329 |     10,329 |          0 |          0 |
be.22410:
    load    [$i9 + 2], $i1              # |     10,329 |     10,329 |          0 |          0 |
    be      $i1, -1, be.22413           # |     10,329 |     10,329 |          0 |          0 |
bne.22411:
    li      0, $i7                      # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     10,329 |     10,329 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     10,329 |     10,329 |          0 |          0 |
    bne     $i1, 0, bne.22410           # |     10,329 |     10,329 |          0 |          0 |
be.22412:
    li      3, $i8                      # |     10,329 |     10,329 |          0 |          0 |
    jal     shadow_check_one_or_group.2865, $ra2# |     10,329 |     10,329 |          0 |          0 |
    be      $i1, 0, be.22413            # |     10,329 |     10,329 |          0 |          8 |
bne.22410:
    li      1, $i1                      # |      3,948 |      3,948 |          0 |          0 |
    jr      $ra3                        # |      3,948 |      3,948 |          0 |          0 |
be.22413:
    add     $i10, 2, $i10               # |     10,329 |     10,329 |          0 |          0 |
    b       shadow_check_one_or_matrix.2868# |     10,329 |     10,329 |          0 |          6 |
be.22429:
    li      0, $i1                      # |    550,998 |    550,998 |          0 |          0 |
    jr      $ra3                        # |    550,998 |    550,998 |          0 |          0 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element
solve_each_element.2871:
    load    [$i3 + $i7], $i9            # |    193,311 |    193,311 |      1,168 |          0 |
    be      $i9, -1, be.22479           # |    193,311 |    193,311 |          0 |      4,837 |
bne.22444:
    load    [ext_objects + $i9], $i1    # |    149,820 |    149,820 |        178 |          0 |
    load    [$i8 + 0], $f4              # |    149,820 |    149,820 |          0 |          0 |
    load    [$i1 + 1], $i2              # |    149,820 |    149,820 |        126 |          0 |
    load    [$i1 + 7], $f1              # |    149,820 |    149,820 |      5,095 |          0 |
    load    [$i1 + 8], $f2              # |    149,820 |    149,820 |      5,434 |          0 |
    fsub    $fg17, $f1, $f1             # |    149,820 |    149,820 |          0 |          0 |
    load    [$i1 + 9], $f3              # |    149,820 |    149,820 |      6,388 |          0 |
    fsub    $fg18, $f2, $f2             # |    149,820 |    149,820 |          0 |          0 |
    fsub    $fg19, $f3, $f3             # |    149,820 |    149,820 |          0 |          0 |
    bne     $i2, 1, bne.22445           # |    149,820 |    149,820 |          0 |     29,832 |
be.22445:
    be      $f4, $f0, ble.22452         # |     50,858 |     50,858 |          0 |        106 |
bne.22446:
    load    [$i1 + 10], $i2             # |     50,858 |     50,858 |        822 |          0 |
    load    [$i1 + 4], $f5              # |     50,858 |     50,858 |         81 |          0 |
    ble     $f0, $f4, ble.22447         # |     50,858 |     50,858 |          0 |        478 |
bg.22447:
    be      $i2, 0, be.22448            # |        698 |        698 |          0 |         17 |
.count dual_jmp
    b       bne.22803
ble.22447:
    be      $i2, 0, bne.22803           # |     50,160 |     50,160 |          0 |      4,177 |
be.22448:
    fsub    $f5, $f1, $f5               # |        698 |        698 |          0 |          0 |
    finv    $f4, $f4                    # |        698 |        698 |          0 |          0 |
    load    [$i1 + 5], $f6              # |        698 |        698 |          0 |          0 |
    load    [$i8 + 1], $f7              # |        698 |        698 |          0 |          0 |
    fmul    $f5, $f4, $f4               # |        698 |        698 |          0 |          0 |
    fmul    $f4, $f7, $f5               # |        698 |        698 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |        698 |        698 |          0 |          0 |
    ble     $f6, $f5, ble.22452         # |        698 |        698 |          0 |        170 |
.count dual_jmp
    b       bg.22451                    # |        171 |        171 |          0 |          2 |
bne.22803:
    fneg    $f5, $f5                    # |     50,160 |     50,160 |          0 |          0 |
    load    [$i1 + 5], $f6              # |     50,160 |     50,160 |         83 |          0 |
    fsub    $f5, $f1, $f5               # |     50,160 |     50,160 |          0 |          0 |
    load    [$i8 + 1], $f7              # |     50,160 |     50,160 |          0 |          0 |
    finv    $f4, $f4                    # |     50,160 |     50,160 |          0 |          0 |
    fmul    $f5, $f4, $f4               # |     50,160 |     50,160 |          0 |          0 |
    fmul    $f4, $f7, $f5               # |     50,160 |     50,160 |          0 |          0 |
    fadd_a  $f5, $f2, $f5               # |     50,160 |     50,160 |          0 |          0 |
    ble     $f6, $f5, ble.22452         # |     50,160 |     50,160 |          0 |      7,072 |
bg.22451:
    load    [$i8 + 2], $f5              # |      9,810 |      9,810 |          0 |          0 |
    load    [$i1 + 6], $f6              # |      9,810 |      9,810 |         28 |          0 |
    fmul    $f4, $f5, $f5               # |      9,810 |      9,810 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |      9,810 |      9,810 |          0 |          0 |
    ble     $f6, $f5, ble.22452         # |      9,810 |      9,810 |          0 |        923 |
bg.22452:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |          0 |          0 |
    li      1, $i10                     # |      4,111 |      4,111 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |      4,111 |      4,111 |          0 |         22 |
.count dual_jmp
    b       bg.22480                    # |      4,020 |      4,020 |          0 |          2 |
ble.22452:
    load    [$i8 + 1], $f4              # |     46,747 |     46,747 |          0 |          0 |
    be      $f4, $f0, ble.22460         # |     46,747 |     46,747 |          0 |     24,858 |
bne.22454:
    load    [$i1 + 10], $i2             # |     46,747 |     46,747 |          0 |          0 |
    load    [$i1 + 5], $f5              # |     46,747 |     46,747 |          0 |          0 |
    ble     $f0, $f4, ble.22455         # |     46,747 |     46,747 |          0 |         80 |
bg.22455:
    be      $i2, 0, be.22456            # |     46,530 |     46,530 |          0 |         89 |
.count dual_jmp
    b       bne.22806
ble.22455:
    be      $i2, 0, bne.22806           # |        217 |        217 |          0 |          3 |
be.22456:
    fsub    $f5, $f2, $f5               # |     46,530 |     46,530 |          0 |          0 |
    load    [$i1 + 6], $f6              # |     46,530 |     46,530 |        408 |          0 |
    finv    $f4, $f4                    # |     46,530 |     46,530 |          0 |          0 |
    load    [$i8 + 2], $f7              # |     46,530 |     46,530 |          0 |          0 |
    fmul    $f5, $f4, $f4               # |     46,530 |     46,530 |          0 |          0 |
    fmul    $f4, $f7, $f5               # |     46,530 |     46,530 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |     46,530 |     46,530 |          0 |          0 |
    ble     $f6, $f5, ble.22460         # |     46,530 |     46,530 |          0 |     16,949 |
.count dual_jmp
    b       bg.22459                    # |     18,436 |     18,436 |          0 |      6,213 |
bne.22806:
    fneg    $f5, $f5                    # |        217 |        217 |          0 |          0 |
    fsub    $f5, $f2, $f5               # |        217 |        217 |          0 |          0 |
    load    [$i1 + 6], $f6              # |        217 |        217 |          0 |          0 |
    finv    $f4, $f4                    # |        217 |        217 |          0 |          0 |
    load    [$i8 + 2], $f7              # |        217 |        217 |          0 |          0 |
    fmul    $f5, $f4, $f4               # |        217 |        217 |          0 |          0 |
    fmul    $f4, $f7, $f5               # |        217 |        217 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |        217 |        217 |          0 |          0 |
    ble     $f6, $f5, ble.22460         # |        217 |        217 |          0 |         59 |
bg.22459:
    load    [$i8 + 0], $f5              # |     18,536 |     18,536 |          0 |          0 |
    fmul    $f4, $f5, $f5               # |     18,536 |     18,536 |          0 |          0 |
    load    [$i1 + 4], $f6              # |     18,536 |     18,536 |          0 |          0 |
    fadd_a  $f5, $f1, $f5               # |     18,536 |     18,536 |          0 |          0 |
    ble     $f6, $f5, ble.22460         # |     18,536 |     18,536 |          0 |      2,014 |
bg.22460:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |          0 |          0 |
    li      2, $i10                     # |     12,080 |     12,080 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |     12,080 |     12,080 |          0 |         91 |
.count dual_jmp
    b       bg.22480                    # |     11,912 |     11,912 |          0 |          2 |
ble.22460:
    load    [$i8 + 2], $f4              # |     34,667 |     34,667 |          0 |          0 |
    be      $f4, $f0, ble.22476         # |     34,667 |     34,667 |          0 |        246 |
bne.22462:
    load    [$i1 + 4], $f5              # |     34,667 |     34,667 |          0 |          0 |
    load    [$i8 + 0], $f6              # |     34,667 |     34,667 |          0 |          0 |
    load    [$i1 + 10], $i2             # |     34,667 |     34,667 |          0 |          0 |
    load    [$i1 + 6], $f7              # |     34,667 |     34,667 |          0 |          0 |
    ble     $f0, $f4, ble.22463         # |     34,667 |     34,667 |          0 |      9,969 |
bg.22463:
    be      $i2, 0, be.22464            # |      9,984 |      9,984 |          0 |        294 |
.count dual_jmp
    b       bne.22809
ble.22463:
    be      $i2, 0, bne.22809           # |     24,683 |     24,683 |          0 |         22 |
be.22464:
    fsub    $f7, $f3, $f3               # |      9,984 |      9,984 |          0 |          0 |
    finv    $f4, $f4                    # |      9,984 |      9,984 |          0 |          0 |
    fmul    $f3, $f4, $f3               # |      9,984 |      9,984 |          0 |          0 |
    fmul    $f3, $f6, $f4               # |      9,984 |      9,984 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |      9,984 |      9,984 |          0 |          0 |
    ble     $f5, $f1, ble.22476         # |      9,984 |      9,984 |          0 |      1,481 |
.count dual_jmp
    b       bg.22467                    # |      6,406 |      6,406 |          0 |        277 |
bne.22809:
    fneg    $f7, $f7                    # |     24,683 |     24,683 |          0 |          0 |
    fsub    $f7, $f3, $f3               # |     24,683 |     24,683 |          0 |          0 |
    finv    $f4, $f4                    # |     24,683 |     24,683 |          0 |          0 |
    fmul    $f3, $f4, $f3               # |     24,683 |     24,683 |          0 |          0 |
    fmul    $f3, $f6, $f4               # |     24,683 |     24,683 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |     24,683 |     24,683 |          0 |          0 |
    ble     $f5, $f1, ble.22476         # |     24,683 |     24,683 |          0 |      3,628 |
bg.22467:
    load    [$i8 + 1], $f1              # |     15,869 |     15,869 |          0 |          0 |
    load    [$i1 + 5], $f4              # |     15,869 |     15,869 |          0 |          0 |
    fmul    $f3, $f1, $f1               # |     15,869 |     15,869 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |     15,869 |     15,869 |          0 |          0 |
    ble     $f4, $f1, ble.22476         # |     15,869 |     15,869 |          0 |      1,646 |
bg.22468:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |          0 |          0 |
    li      3, $i10                     # |      3,025 |      3,025 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |      3,025 |      3,025 |          0 |        389 |
.count dual_jmp
    b       bg.22480                    # |      2,987 |      2,987 |          0 |         64 |
bne.22445:
    bne     $i2, 2, bne.22469           # |     98,962 |     98,962 |          0 |     18,850 |
be.22469:
    load    [$i1 + 4], $f5              # |     24,693 |     24,693 |        366 |          0 |
    load    [$i8 + 1], $f6              # |     24,693 |     24,693 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     24,693 |     24,693 |          0 |          0 |
    load    [$i1 + 5], $f7              # |     24,693 |     24,693 |        349 |          0 |
    fmul    $f6, $f7, $f6               # |     24,693 |     24,693 |          0 |          0 |
    load    [$i8 + 2], $f8              # |     24,693 |     24,693 |          0 |          0 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |          0 |          0 |
    load    [$i1 + 6], $f9              # |     24,693 |     24,693 |        365 |          0 |
    fmul    $f8, $f9, $f8               # |     24,693 |     24,693 |          0 |          0 |
    fadd    $f4, $f8, $f4               # |     24,693 |     24,693 |          0 |          0 |
    ble     $f4, $f0, ble.22476         # |     24,693 |     24,693 |          0 |      1,646 |
bg.22470:
    fmul    $f5, $f1, $f1               # |     17,158 |     17,158 |          0 |          0 |
    li      1, $i10                     # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f7, $f2, $f2               # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f9, $f3, $f3               # |     17,158 |     17,158 |          0 |          0 |
    finv    $f4, $f4                    # |     17,158 |     17,158 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |     17,158 |     17,158 |          0 |          0 |
    fmul    $f1, $f4, $fg0              # |     17,158 |     17,158 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |     17,158 |     17,158 |          0 |          5 |
.count dual_jmp
    b       bg.22480                    # |     17,133 |     17,133 |          0 |      1,491 |
bne.22469:
    load    [$i8 + 1], $f5              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f4, $f4, $f7               # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 3], $i4              # |     74,269 |     74,269 |      3,212 |          0 |
    fmul    $f5, $f5, $f8               # |     74,269 |     74,269 |          0 |          0 |
    load    [$i8 + 2], $f6              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f6, $f11              # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 4], $f9              # |     74,269 |     74,269 |      3,573 |          0 |
    fmul    $f7, $f9, $f7               # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 5], $f10             # |     74,269 |     74,269 |      3,316 |          0 |
    fmul    $f8, $f10, $f8              # |     74,269 |     74,269 |          0 |          0 |
    load    [$i1 + 6], $f12             # |     74,269 |     74,269 |      2,726 |          0 |
    fmul    $f11, $f12, $f11            # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f7, $f8, $f7               # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f7, $f11, $f7              # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.22471            # |     74,269 |     74,269 |          0 |        140 |
bne.22471:
    fmul    $f5, $f6, $f8
    load    [$i1 + 16], $f11
    fmul    $f6, $f4, $f13
    load    [$i1 + 17], $f14
    fmul    $f4, $f5, $f15
    fmul    $f8, $f11, $f8
    load    [$i1 + 18], $f11
    fmul    $f13, $f14, $f13
    fmul    $f15, $f11, $f11
    fadd    $f7, $f8, $f7
    fadd    $f7, $f13, $f7
    fadd    $f7, $f11, $f7
    be      $f7, $f0, ble.22476
.count dual_jmp
    b       bne.22472
be.22471:
    be      $f7, $f0, ble.22476         # |     74,269 |     74,269 |          0 |         24 |
bne.22472:
    fmul    $f4, $f1, $f8               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f5, $f2, $f11              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f3, $f13              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f8, $f9, $f8               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f11, $f10, $f11            # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f13, $f12, $f13            # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f8, $f11, $f8              # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f8, $f13, $f8              # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.22473            # |     74,269 |     74,269 |          0 |      2,136 |
bne.22473:
    fmul    $f6, $f2, $f11
    fmul    $f5, $f3, $f13
    load    [$i1 + 16], $f14
    fmul    $f4, $f3, $f15
    load    [$i1 + 17], $f16
    fmul    $f6, $f1, $f6
    fadd    $f11, $f13, $f11
    fmul    $f4, $f2, $f4
    load    [$i1 + 18], $f13
    fmul    $f5, $f1, $f5
    fadd    $f15, $f6, $f6
    fmul    $f11, $f14, $f11
    fadd    $f4, $f5, $f4
    fmul    $f6, $f16, $f5
    fmul    $f1, $f1, $f6
    fmul    $f4, $f13, $f4
    fadd    $f11, $f5, $f5
    fmul    $f3, $f3, $f11
    fmul    $f6, $f9, $f6
    fadd    $f5, $f4, $f4
    fmul    $f11, $f12, $f9
    fmul    $f4, $fc3, $f4
    fadd    $f8, $f4, $f4
    fmul    $f2, $f2, $f8
    fmul    $f4, $f4, $f5
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fadd    $f6, $f9, $f6
    be      $i4, 0, be.22474
.count dual_jmp
    b       bne.22474
be.22473:
    mov     $f8, $f4                    # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f4, $f4, $f5               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f1, $f1, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f2, $f2, $f8               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f3, $f3, $f11              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f6, $f9, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f8, $f10, $f8              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f11, $f12, $f9             # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |          0 |          0 |
    fadd    $f6, $f9, $f6               # |     74,269 |     74,269 |          0 |          0 |
    be      $i4, 0, be.22474            # |     74,269 |     74,269 |          0 |         11 |
bne.22474:
    fmul    $f2, $f3, $f8
    load    [$i1 + 16], $f9
    fmul    $f3, $f1, $f3
    load    [$i1 + 17], $f10
    fmul    $f1, $f2, $f1
    fmul    $f8, $f9, $f2
    load    [$i1 + 18], $f8
    fmul    $f3, $f10, $f3
    fmul    $f1, $f8, $f1
    fadd    $f6, $f2, $f2
    fadd    $f2, $f3, $f2
    fadd    $f2, $f1, $f1
    be      $i2, 3, be.22475
.count dual_jmp
    b       bne.22475
be.22474:
    mov     $f6, $f1                    # |     74,269 |     74,269 |          0 |          0 |
    be      $i2, 3, be.22475            # |     74,269 |     74,269 |          0 |          8 |
bne.22475:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, ble.22476
.count dual_jmp
    b       bg.22476
be.22475:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |          0 |          0 |
    fmul    $f7, $f1, $f1               # |     74,269 |     74,269 |          0 |          0 |
    fsub    $f5, $f1, $f1               # |     74,269 |     74,269 |          0 |          0 |
    bg      $f1, $f0, bg.22476          # |     74,269 |     74,269 |          0 |     17,818 |
ble.22476:
    load    [ext_objects + $i9], $i1    # |    101,553 |    101,553 |          0 |          0 |
    load    [$i1 + 10], $i1             # |    101,553 |    101,553 |         91 |          0 |
    bne     $i1, 0, bne.22479           # |    101,553 |    101,553 |          0 |      4,800 |
be.22479:
    jr      $ra1                        # |    135,672 |    135,672 |          0 |          0 |
bg.22476:
    load    [$i1 + 10], $i1             # |     11,893 |     11,893 |          5 |          0 |
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |          0 |          0 |
    li      1, $i10                     # |     11,893 |     11,893 |          0 |          0 |
    finv    $f7, $f2                    # |     11,893 |     11,893 |          0 |          0 |
    be      $i1, 0, be.22477            # |     11,893 |     11,893 |          0 |      2,656 |
bne.22477:
    fsub    $f1, $f4, $f1               # |      2,755 |      2,755 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |      2,755 |      2,755 |          0 |         96 |
.count dual_jmp
    b       bg.22480                    # |      2,723 |      2,723 |          0 |         32 |
be.22477:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |          0 |          0 |
    fsub    $f1, $f4, $f1               # |      9,138 |      9,138 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |          0 |          0 |
    ble     $fg0, $f0, bne.22479        # |      9,138 |      9,138 |          0 |        576 |
bg.22480:
    ble     $fg7, $fg0, bne.22479       # |     47,420 |     47,420 |          0 |      4,046 |
bg.22481:
    fadd    $fg0, $fc11, $f12           # |     35,739 |     35,739 |          0 |          0 |
    li      0, $i1                      # |     35,739 |     35,739 |          0 |          0 |
    load    [$i8 + 0], $f1              # |     35,739 |     35,739 |          0 |          0 |
    fmul    $f1, $f12, $f1              # |     35,739 |     35,739 |          0 |          0 |
    load    [$i8 + 1], $f2              # |     35,739 |     35,739 |          0 |          0 |
    fmul    $f2, $f12, $f2              # |     35,739 |     35,739 |          0 |          0 |
    load    [$i8 + 2], $f3              # |     35,739 |     35,739 |          0 |          0 |
    fmul    $f3, $f12, $f3              # |     35,739 |     35,739 |          0 |          0 |
    fadd    $f1, $fg17, $f13            # |     35,739 |     35,739 |          0 |          0 |
    fadd    $f2, $fg18, $f14            # |     35,739 |     35,739 |          0 |          0 |
    fadd    $f3, $fg19, $f4             # |     35,739 |     35,739 |          0 |          0 |
.count move_args
    mov     $f13, $f2                   # |     35,739 |     35,739 |          0 |          0 |
.count move_args
    mov     $f14, $f3                   # |     35,739 |     35,739 |          0 |          0 |
    call    check_all_inside.2856       # |     35,739 |     35,739 |          0 |          0 |
    add     $i7, 1, $i7                 # |     35,739 |     35,739 |          0 |          0 |
    be      $i1, 0, solve_each_element.2871# |     35,739 |     35,739 |          0 |        134 |
bne.22482:
    mov     $f12, $fg7                  # |     25,164 |     25,164 |          0 |          0 |
    store   $f13, [ext_intersection_point + 0]# |     25,164 |     25,164 |          0 |          0 |
    store   $f14, [ext_intersection_point + 1]# |     25,164 |     25,164 |          0 |          0 |
    mov     $i9, $ig3                   # |     25,164 |     25,164 |          0 |          0 |
    store   $f4, [ext_intersection_point + 2]# |     25,164 |     25,164 |          0 |          0 |
    mov     $i10, $ig2                  # |     25,164 |     25,164 |          0 |          0 |
    b       solve_each_element.2871     # |     25,164 |     25,164 |          0 |        264 |
bne.22479:
    add     $i7, 1, $i7                 # |     21,900 |     21,900 |          0 |          0 |
    b       solve_each_element.2871     # |     21,900 |     21,900 |          0 |         59 |
.end solve_each_element

######################################################################
# solve_one_or_network($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i12 + $i11], $i1          # |      6,776 |      6,776 |          4 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |         78 |
bne.22483:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          0 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 1, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          5 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |      1,337 |
bne.22484:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          5 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 2, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          5 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |        350 |
bne.22485:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          5 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 3, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          4 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |         68 |
bne.22486:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          0 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 4, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          4 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |          1 |
bne.22487:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |          5 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 5, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          3 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |      1,650 |
bne.22488:
    li      0, $i7                      # |      6,776 |      6,776 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      6,776 |      6,776 |         36 |          0 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |          0 |          0 |
    add     $i11, 6, $i1                # |      6,776 |      6,776 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |      6,776 |      6,776 |          3 |          0 |
    be      $i1, -1, be.22490           # |      6,776 |      6,776 |          0 |        376 |
bne.22489:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i11, 7, $i1
    load    [$i12 + $i1], $i1
    be      $i1, -1, be.22490
bne.22490:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    add     $i11, 8, $i11
    b       solve_one_or_network.2875
be.22490:
    jr      $ra2                        # |      6,776 |      6,776 |          0 |          0 |
.end solve_one_or_network

######################################################################
# trace_or_matrix($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f16]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i14 + $i13], $i12         # |     23,754 |     23,754 |          1 |          0 |
    load    [$i12 + 0], $i1             # |     23,754 |     23,754 |          1 |          0 |
    be      $i1, -1, be.22499           # |     23,754 |     23,754 |          0 |         96 |
bne.22491:
    bne     $i1, 99, bne.22492          # |     23,754 |     23,754 |          0 |        774 |
be.22492:
    load    [$i12 + 1], $i1             # |     23,754 |     23,754 |         63 |          0 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |          0 |        117 |
bne.22493:
    li      0, $i7                      # |     23,754 |     23,754 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |          1 |          0 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |          0 |          0 |
    load    [$i12 + 2], $i1             # |     23,754 |     23,754 |         63 |          0 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |          0 |        157 |
bne.22494:
    li      0, $i7                      # |     23,754 |     23,754 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |          1 |          0 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |          0 |          0 |
    load    [$i12 + 3], $i1             # |     23,754 |     23,754 |         63 |          0 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |          0 |          0 |
bne.22495:
    li      0, $i7                      # |     23,754 |     23,754 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |         32 |          0 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |          0 |          0 |
    load    [$i12 + 4], $i1             # |     23,754 |     23,754 |          1 |          0 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |          0 |         85 |
bne.22496:
    li      0, $i7                      # |     23,754 |     23,754 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     23,754 |     23,754 |         32 |          0 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |          0 |          0 |
    load    [$i12 + 5], $i1             # |     23,754 |     23,754 |          1 |          0 |
    be      $i1, -1, be.22498           # |     23,754 |     23,754 |          0 |      5,448 |
bne.22497:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 6], $i1
    be      $i1, -1, be.22498
bne.22498:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      7, $i11
    jal     solve_one_or_network.2875, $ra2
    add     $i13, 1, $i1
    load    [$i14 + $i1], $i12
    load    [$i12 + 0], $i1
    be      $i1, -1, be.22499
.count dual_jmp
    b       bne.22499
be.22498:
    add     $i13, 1, $i1                # |     23,754 |     23,754 |          0 |          0 |
    load    [$i14 + $i1], $i12          # |     23,754 |     23,754 |        160 |          0 |
    load    [$i12 + 0], $i1             # |     23,754 |     23,754 |          0 |          0 |
    be      $i1, -1, be.22499           # |     23,754 |     23,754 |          0 |         12 |
bne.22499:
    be      $i1, 99, be.22500
bne.22500:
.count move_args
    mov     $i8, $i2
    call    solver.2773
    be      $i1, 0, ble.22506
bne.22505:
    ble     $fg7, $fg0, ble.22506
bg.22506:
    li      1, $i11
    jal     solve_one_or_network.2875, $ra2
    add     $i13, 2, $i13
    b       trace_or_matrix.2879
be.22500:
    load    [$i12 + 1], $i1
    be      $i1, -1, ble.22506
bne.22501:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 2], $i1
    be      $i1, -1, ble.22506
bne.22502:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 3], $i1
    be      $i1, -1, ble.22506
bne.22503:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 4], $i1
    be      $i1, -1, ble.22506
bne.22504:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      5, $i11
    jal     solve_one_or_network.2875, $ra2
    add     $i13, 2, $i13
    b       trace_or_matrix.2879
ble.22506:
    add     $i13, 2, $i13
    b       trace_or_matrix.2879
be.22499:
    jr      $ra3                        # |     23,754 |     23,754 |          0 |          0 |
bne.22492:
.count move_args
    mov     $i8, $i2
    call    solver.2773
    be      $i1, 0, ble.22508
bne.22507:
    ble     $fg7, $fg0, ble.22508
bg.22508:
    li      1, $i11
    jal     solve_one_or_network.2875, $ra2
    add     $i13, 1, $i13
    b       trace_or_matrix.2879
ble.22508:
    add     $i13, 1, $i13
    b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i7, $i3, $i8)
# $ra = $ra1
# [$i1 - $i2, $i4 - $i7, $i9 - $i10]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.align 2
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i3 + $i7], $i9            # | 13,852,379 | 13,852,379 |    248,549 |          0 |
    be      $i9, -1, be.22528           # | 13,852,379 | 13,852,379 |          0 |    711,733 |
bne.22509:
    load    [ext_objects + $i9], $i1    # | 10,544,068 | 10,544,068 |    111,512 |          0 |
    load    [$i8 + 3], $i2              # | 10,544,068 | 10,544,068 |     14,002 |          0 |
    load    [$i1 + 1], $i4              # | 10,544,068 | 10,544,068 |     87,543 |          0 |
    load    [$i1 + 19], $f1             # | 10,544,068 | 10,544,068 |    115,109 |          0 |
    load    [$i1 + 20], $f2             # | 10,544,068 | 10,544,068 |    115,017 |          0 |
    load    [$i1 + 21], $f3             # | 10,544,068 | 10,544,068 |    119,528 |          0 |
    load    [$i2 + $i9], $i2            # | 10,544,068 | 10,544,068 |  8,782,427 |          0 |
    bne     $i4, 1, bne.22510           # | 10,544,068 | 10,544,068 |          0 |  2,322,429 |
be.22510:
    load    [$i2 + 0], $f4              # |  3,873,912 |  3,873,912 |  3,569,576 |          0 |
    fsub    $f4, $f1, $f4               # |  3,873,912 |  3,873,912 |          0 |          0 |
    load    [$i1 + 5], $f5              # |  3,873,912 |  3,873,912 |     35,423 |          0 |
    load    [$i8 + 1], $f6              # |  3,873,912 |  3,873,912 |     14,512 |          0 |
    load    [$i2 + 1], $f7              # |  3,873,912 |  3,873,912 |  3,599,243 |          0 |
    fmul    $f4, $f7, $f4               # |  3,873,912 |  3,873,912 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |  3,873,912 |  3,873,912 |          0 |          0 |
    fadd_a  $f6, $f2, $f6               # |  3,873,912 |  3,873,912 |          0 |          0 |
    ble     $f5, $f6, be.22513          # |  3,873,912 |  3,873,912 |          0 |    942,488 |
bg.22511:
    load    [$i8 + 2], $f5              # |    828,022 |    828,022 |      2,220 |          0 |
    load    [$i1 + 6], $f6              # |    828,022 |    828,022 |     12,080 |          0 |
    fmul    $f4, $f5, $f5               # |    828,022 |    828,022 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |    828,022 |    828,022 |          0 |          0 |
    ble     $f6, $f5, be.22513          # |    828,022 |    828,022 |          0 |    203,721 |
bg.22512:
    load    [$i2 + 1], $f5              # |    503,423 |    503,423 |         60 |          0 |
    be      $f5, $f0, be.22513          # |    503,423 |    503,423 |          0 |        218 |
bne.22513:
    mov     $f4, $fg0                   # |    503,423 |    503,423 |          0 |          0 |
    li      1, $i10                     # |    503,423 |    503,423 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |    503,423 |    503,423 |          0 |     47,533 |
.count dual_jmp
    b       bg.22529                    # |     77,908 |     77,908 |          0 |          4 |
be.22513:
    load    [$i2 + 2], $f4              # |  3,370,489 |  3,370,489 |  3,143,016 |          0 |
    fsub    $f4, $f2, $f4               # |  3,370,489 |  3,370,489 |          0 |          0 |
    load    [$i1 + 4], $f5              # |  3,370,489 |  3,370,489 |     29,091 |          0 |
    load    [$i8 + 0], $f6              # |  3,370,489 |  3,370,489 |    139,861 |          0 |
    load    [$i2 + 3], $f7              # |  3,370,489 |  3,370,489 |  3,105,100 |          0 |
    fmul    $f4, $f7, $f4               # |  3,370,489 |  3,370,489 |          0 |          0 |
    fmul    $f4, $f6, $f6               # |  3,370,489 |  3,370,489 |          0 |          0 |
    fadd_a  $f6, $f1, $f6               # |  3,370,489 |  3,370,489 |          0 |          0 |
    ble     $f5, $f6, be.22517          # |  3,370,489 |  3,370,489 |          0 |    863,541 |
bg.22515:
    load    [$i8 + 2], $f5              # |  1,793,252 |  1,793,252 |     56,588 |          0 |
    load    [$i1 + 6], $f6              # |  1,793,252 |  1,793,252 |     22,764 |          0 |
    fmul    $f4, $f5, $f5               # |  1,793,252 |  1,793,252 |          0 |          0 |
    fadd_a  $f5, $f3, $f5               # |  1,793,252 |  1,793,252 |          0 |          0 |
    ble     $f6, $f5, be.22517          # |  1,793,252 |  1,793,252 |          0 |    385,434 |
bg.22516:
    load    [$i2 + 3], $f5              # |  1,222,666 |  1,222,666 |          0 |          0 |
    be      $f5, $f0, be.22517          # |  1,222,666 |  1,222,666 |          0 |     58,518 |
bne.22517:
    mov     $f4, $fg0                   # |  1,222,666 |  1,222,666 |          0 |          0 |
    li      2, $i10                     # |  1,222,666 |  1,222,666 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |  1,222,666 |  1,222,666 |          0 |    174,733 |
.count dual_jmp
    b       bg.22529                    # |    207,385 |    207,385 |          0 |      1,338 |
be.22517:
    load    [$i2 + 4], $f4              # |  2,147,823 |  2,147,823 |  1,992,057 |          0 |
    fsub    $f4, $f3, $f3               # |  2,147,823 |  2,147,823 |          0 |          0 |
    load    [$i1 + 4], $f5              # |  2,147,823 |  2,147,823 |        421 |          0 |
    load    [$i8 + 0], $f6              # |  2,147,823 |  2,147,823 |        934 |          0 |
    load    [$i2 + 5], $f4              # |  2,147,823 |  2,147,823 |  1,996,842 |          0 |
    fmul    $f3, $f4, $f3               # |  2,147,823 |  2,147,823 |          0 |          0 |
    fmul    $f3, $f6, $f4               # |  2,147,823 |  2,147,823 |          0 |          0 |
    fadd_a  $f4, $f1, $f1               # |  2,147,823 |  2,147,823 |          0 |          0 |
    ble     $f5, $f1, ble.22525         # |  2,147,823 |  2,147,823 |          0 |    495,035 |
bg.22519:
    load    [$i8 + 1], $f1              # |    606,519 |    606,519 |        216 |          0 |
    load    [$i1 + 5], $f4              # |    606,519 |    606,519 |         82 |          0 |
    fmul    $f3, $f1, $f1               # |    606,519 |    606,519 |          0 |          0 |
    fadd_a  $f1, $f2, $f1               # |    606,519 |    606,519 |          0 |          0 |
    ble     $f4, $f1, ble.22525         # |    606,519 |    606,519 |          0 |    128,834 |
bg.22520:
    load    [$i2 + 5], $f1              # |    274,583 |    274,583 |          0 |          0 |
    be      $f1, $f0, ble.22525         # |    274,583 |    274,583 |          0 |          0 |
bne.22521:
    mov     $f3, $fg0                   # |    274,583 |    274,583 |          0 |          0 |
    li      3, $i10                     # |    274,583 |    274,583 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |    274,583 |    274,583 |          0 |     65,800 |
.count dual_jmp
    b       bg.22529                    # |     45,673 |     45,673 |          0 |          2 |
bne.22510:
    be      $i4, 2, be.22522            # |  6,670,156 |  6,670,156 |          0 |    154,504 |
bne.22522:
    load    [$i2 + 0], $f4              # |  5,427,826 |  5,427,826 |  4,970,670 |          0 |
    be      $f4, $f0, ble.22525         # |  5,427,826 |  5,427,826 |          0 |         14 |
bne.22524:
    load    [$i2 + 1], $f5              # |  5,427,826 |  5,427,826 |  4,936,211 |          0 |
    load    [$i2 + 2], $f6              # |  5,427,826 |  5,427,826 |  4,962,111 |          0 |
    fmul    $f5, $f1, $f1               # |  5,427,826 |  5,427,826 |          0 |          0 |
    load    [$i2 + 3], $f7              # |  5,427,826 |  5,427,826 |  4,951,553 |          0 |
    fmul    $f6, $f2, $f2               # |  5,427,826 |  5,427,826 |          0 |          0 |
    fmul    $f7, $f3, $f3               # |  5,427,826 |  5,427,826 |          0 |          0 |
    load    [$i1 + 22], $f5             # |  5,427,826 |  5,427,826 |     63,889 |          0 |
    fadd    $f1, $f2, $f1               # |  5,427,826 |  5,427,826 |          0 |          0 |
    fmul    $f4, $f5, $f2               # |  5,427,826 |  5,427,826 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |  5,427,826 |  5,427,826 |          0 |          0 |
    fmul    $f1, $f1, $f3               # |  5,427,826 |  5,427,826 |          0 |          0 |
    fsub    $f3, $f2, $f2               # |  5,427,826 |  5,427,826 |          0 |          0 |
    ble     $f2, $f0, ble.22525         # |  5,427,826 |  5,427,826 |          0 |    662,883 |
bg.22525:
    load    [$i1 + 10], $i1             # |  1,681,089 |  1,681,089 |     25,469 |          0 |
    li      1, $i10                     # |  1,681,089 |  1,681,089 |          0 |          0 |
    load    [$i2 + 4], $f3              # |  1,681,089 |  1,681,089 |  1,535,779 |          0 |
    fsqrt   $f2, $f2                    # |  1,681,089 |  1,681,089 |          0 |          0 |
    be      $i1, 0, be.22526            # |  1,681,089 |  1,681,089 |          0 |     78,321 |
bne.22526:
    fadd    $f1, $f2, $f1               # |    420,803 |    420,803 |          0 |          0 |
    fmul    $f1, $f3, $fg0              # |    420,803 |    420,803 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |    420,803 |    420,803 |          0 |     84,219 |
.count dual_jmp
    b       bg.22529                    # |    268,093 |    268,093 |          0 |          4 |
be.22526:
    fsub    $f1, $f2, $f1               # |  1,260,286 |  1,260,286 |          0 |          0 |
    fmul    $f1, $f3, $fg0              # |  1,260,286 |  1,260,286 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |  1,260,286 |  1,260,286 |          0 |     58,558 |
.count dual_jmp
    b       bg.22529                    # |    245,876 |    245,876 |          0 |      1,187 |
be.22522:
    load    [$i2 + 0], $f1              # |  1,242,330 |  1,242,330 |  1,091,018 |          0 |
    ble     $f0, $f1, ble.22525         # |  1,242,330 |  1,242,330 |          0 |    214,382 |
bg.22523:
    load    [$i1 + 22], $f2             # |    595,189 |    595,189 |     18,583 |          0 |
    li      1, $i10                     # |    595,189 |    595,189 |          0 |          0 |
    fmul    $f1, $f2, $fg0              # |    595,189 |    595,189 |          0 |          0 |
    ble     $fg0, $f0, bne.22528        # |    595,189 |    595,189 |          0 |      5,354 |
bg.22529:
    ble     $fg7, $fg0, bne.22528       # |  1,396,641 |  1,396,641 |          0 |    177,813 |
bg.22530:
    fadd    $fg0, $fc11, $f12           # |  1,181,368 |  1,181,368 |          0 |          0 |
    li      0, $i1                      # |  1,181,368 |  1,181,368 |          0 |          0 |
    load    [$i8 + 0], $f1              # |  1,181,368 |  1,181,368 |     39,769 |          0 |
    fmul    $f1, $f12, $f1              # |  1,181,368 |  1,181,368 |          0 |          0 |
    load    [$i8 + 1], $f2              # |  1,181,368 |  1,181,368 |      1,934 |          0 |
    fmul    $f2, $f12, $f2              # |  1,181,368 |  1,181,368 |          0 |          0 |
    load    [$i8 + 2], $f3              # |  1,181,368 |  1,181,368 |     20,354 |          0 |
    fmul    $f3, $f12, $f3              # |  1,181,368 |  1,181,368 |          0 |          0 |
    fadd    $f1, $fg8, $f13             # |  1,181,368 |  1,181,368 |          0 |          0 |
    fadd    $f2, $fg9, $f14             # |  1,181,368 |  1,181,368 |          0 |          0 |
    fadd    $f3, $fg10, $f4             # |  1,181,368 |  1,181,368 |          0 |          0 |
.count move_args
    mov     $f13, $f2                   # |  1,181,368 |  1,181,368 |          0 |          0 |
.count move_args
    mov     $f14, $f3                   # |  1,181,368 |  1,181,368 |          0 |          0 |
    call    check_all_inside.2856       # |  1,181,368 |  1,181,368 |          0 |          0 |
    add     $i7, 1, $i7                 # |  1,181,368 |  1,181,368 |          0 |          0 |
    be      $i1, 0, solve_each_element_fast.2885# |  1,181,368 |  1,181,368 |          0 |      2,431 |
bne.22531:
    mov     $f12, $fg7                  # |    756,420 |    756,420 |          0 |          0 |
    store   $f13, [ext_intersection_point + 0]# |    756,420 |    756,420 |          0 |          0 |
    store   $f14, [ext_intersection_point + 1]# |    756,420 |    756,420 |          0 |          0 |
    mov     $i9, $ig3                   # |    756,420 |    756,420 |          0 |          0 |
    store   $f4, [ext_intersection_point + 2]# |    756,420 |    756,420 |          0 |          0 |
    mov     $i10, $ig2                  # |    756,420 |    756,420 |          0 |          0 |
    b       solve_each_element_fast.2885# |    756,420 |    756,420 |          0 |          5 |
ble.22525:
    load    [ext_objects + $i9], $i1    # |  6,267,118 |  6,267,118 |      1,736 |          0 |
    load    [$i1 + 10], $i1             # |  6,267,118 |  6,267,118 |     52,479 |          0 |
    be      $i1, 0, be.22528            # |  6,267,118 |  6,267,118 |          0 |    238,660 |
bne.22528:
    add     $i7, 1, $i7                 # |  4,023,603 |  4,023,603 |          0 |          0 |
    b       solve_each_element_fast.2885# |  4,023,603 |  4,023,603 |          0 |      5,167 |
be.22528:
    jr      $ra1                        # |  8,647,408 |  8,647,408 |          0 |          0 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i11, $i12, $i8)
# $ra = $ra2
# [$i1 - $i7, $i9 - $i11]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.align 2
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i12 + $i11], $i1          # |    684,824 |    684,824 |      5,421 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |         34 |
bne.22532:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |      6,963 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 1, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |      6,236 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |          0 |
bne.22533:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |      8,998 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 2, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |      5,203 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |         64 |
bne.22534:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |      5,495 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 3, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |      6,514 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |        240 |
bne.22535:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |      7,078 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 4, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |      7,733 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |         58 |
bne.22536:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |      9,010 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 5, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |     12,294 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |      1,482 |
bne.22537:
    li      0, $i7                      # |    684,824 |    684,824 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    684,824 |    684,824 |     12,218 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |          0 |          0 |
    add     $i11, 6, $i1                # |    684,824 |    684,824 |          0 |          0 |
    load    [$i12 + $i1], $i1           # |    684,824 |    684,824 |     10,902 |          0 |
    be      $i1, -1, be.22539           # |    684,824 |    684,824 |          0 |        902 |
bne.22538:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i11, 7, $i1
    load    [$i12 + $i1], $i1
    be      $i1, -1, be.22539
bne.22539:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    add     $i11, 8, $i11
    b       solve_one_or_network_fast.2889
be.22539:
    jr      $ra2                        # |    684,824 |    684,824 |          0 |          0 |
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i13, $i14, $i8)
# $ra = $ra3
# [$i1 - $i7, $i9 - $i13]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.align 2
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i14 + $i13], $i12         # |  1,134,616 |  1,134,616 |      7,449 |          0 |
    load    [$i12 + 0], $i1             # |  1,134,616 |  1,134,616 |     10,112 |          0 |
    be      $i1, -1, be.22548           # |  1,134,616 |  1,134,616 |          0 |     14,616 |
bne.22540:
    bne     $i1, 99, bne.22541          # |  1,134,616 |  1,134,616 |          0 |      1,642 |
be.22541:
    load    [$i12 + 1], $i1             # |  1,134,616 |  1,134,616 |      7,017 |          0 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |          0 |        758 |
bne.22542:
    li      0, $i7                      # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |      7,289 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i12 + 2], $i1             # |  1,134,616 |  1,134,616 |      7,373 |          0 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |          0 |         16 |
bne.22543:
    li      0, $i7                      # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |      5,477 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i12 + 3], $i1             # |  1,134,616 |  1,134,616 |      6,100 |          0 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |          0 |        106 |
bne.22544:
    li      0, $i7                      # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |      5,543 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i12 + 4], $i1             # |  1,134,616 |  1,134,616 |      5,716 |          0 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |          0 |      1,223 |
bne.22545:
    li      0, $i7                      # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |  1,134,616 |  1,134,616 |      8,705 |          0 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i12 + 5], $i1             # |  1,134,616 |  1,134,616 |      7,370 |          0 |
    be      $i1, -1, be.22547           # |  1,134,616 |  1,134,616 |          0 |      3,002 |
bne.22546:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 6], $i1
    be      $i1, -1, be.22547
bne.22547:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      7, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i13, 1, $i1
    load    [$i14 + $i1], $i12
    load    [$i12 + 0], $i1
    be      $i1, -1, be.22548
.count dual_jmp
    b       bne.22548
be.22547:
    add     $i13, 1, $i1                # |  1,134,616 |  1,134,616 |          0 |          0 |
    load    [$i14 + $i1], $i12          # |  1,134,616 |  1,134,616 |      6,817 |          0 |
    load    [$i12 + 0], $i1             # |  1,134,616 |  1,134,616 |      7,348 |          0 |
    be      $i1, -1, be.22548           # |  1,134,616 |  1,134,616 |          0 |     56,770 |
bne.22548:
    be      $i1, 99, be.22549
bne.22549:
.count move_args
    mov     $i8, $i2
    call    solver_fast2.2814
    be      $i1, 0, ble.22555
bne.22554:
    ble     $fg7, $fg0, ble.22555
bg.22555:
    li      1, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i13, 2, $i13
    b       trace_or_matrix_fast.2893
be.22549:
    load    [$i12 + 1], $i1
    be      $i1, -1, ble.22555
bne.22550:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 2], $i1
    be      $i1, -1, ble.22555
bne.22551:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 3], $i1
    be      $i1, -1, ble.22555
bne.22552:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 4], $i1
    be      $i1, -1, ble.22555
bne.22553:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i13, 2, $i13
    b       trace_or_matrix_fast.2893
ble.22555:
    add     $i13, 2, $i13
    b       trace_or_matrix_fast.2893
be.22548:
    jr      $ra3                        # |  1,134,616 |  1,134,616 |          0 |          0 |
bne.22541:
.count move_args
    mov     $i8, $i2
    call    solver_fast2.2814
    be      $i1, 0, ble.22557
bne.22556:
    ble     $fg7, $fg0, ble.22557
bg.22557:
    li      1, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i13, 1, $i13
    b       trace_or_matrix_fast.2893
ble.22557:
    add     $i13, 1, $i13
    b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i2)
# $ra = $ra1
# [$i1]
# [$f1 - $f11]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.align 2
.begin utexture
utexture.2908:
    load    [$i2 + 0], $i1              # |    660,661 |    660,661 |     34,742 |          0 |
    load    [$i2 + 13], $fg16           # |    660,661 |    660,661 |     33,946 |          0 |
    load    [$i2 + 14], $fg11           # |    660,661 |    660,661 |     34,762 |          0 |
    load    [$i2 + 15], $fg15           # |    660,661 |    660,661 |     33,499 |          0 |
    be      $i1, 1, be.22558            # |    660,661 |    660,661 |          0 |     12,911 |
bne.22558:
    be      $i1, 2, be.22563            # |    566,078 |    566,078 |          0 |      1,079 |
bne.22563:
    be      $i1, 3, be.22564            # |    563,192 |    563,192 |          0 |      1,280 |
bne.22564:
    bne     $i1, 4, bne.22565           # |    563,192 |    563,192 |          0 |         20 |
be.22565:
.count load_float
    load    [f.21983], $f8
    load    [ext_intersection_point + 0], $f1
    load    [$i2 + 7], $f2
    fsub    $f1, $f2, $f1
    load    [$i2 + 4], $f3
    fsqrt   $f3, $f2
    load    [ext_intersection_point + 2], $f4
    fmul    $f1, $f2, $f9
    load    [$i2 + 9], $f3
    fsub    $f4, $f3, $f3
    load    [$i2 + 6], $f5
    fsqrt   $f5, $f1
    fabs    $f9, $f2
    fmul    $f3, $f1, $f10
    ble     $f8, $f2, ble.22566
bg.22566:
    mov     $fc14, $f11
    fmul    $f9, $f9, $f1
    load    [ext_intersection_point + 1], $f3
    fmul    $f10, $f10, $f2
    load    [$i2 + 8], $f4
    load    [$i2 + 5], $f5
    fadd    $f1, $f2, $f1
    fsub    $f3, $f4, $f2
    fsqrt   $f5, $f3
    fabs    $f1, $f4
    fmul    $f2, $f3, $f2
    ble     $f8, $f4, ble.22567
.count dual_jmp
    b       bg.22567
ble.22566:
    finv    $f9, $f1
    fmul_a  $f10, $f1, $f2
    call    ext_atan
    fmul    $fc13, $f1, $f11
    fmul    $f9, $f9, $f1
    load    [ext_intersection_point + 1], $f3
    fmul    $f10, $f10, $f2
    load    [$i2 + 8], $f4
    load    [$i2 + 5], $f5
    fadd    $f1, $f2, $f1
    fsub    $f3, $f4, $f2
    fsqrt   $f5, $f3
    fabs    $f1, $f4
    fmul    $f2, $f3, $f2
    ble     $f8, $f4, ble.22567
bg.22567:
    mov     $fc14, $f4
.count load_float
    load    [f.21989], $f5
.count move_args
    mov     $f11, $f2
    call    ext_floor
    fsub    $f11, $f1, $f1
.count move_args
    mov     $f4, $f2
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f5
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f0, $f1, ble.22568
.count dual_jmp
    b       bg.22568
ble.22567:
    finv    $f1, $f1
    fmul_a  $f2, $f1, $f2
    call    ext_atan
    fmul    $fc13, $f1, $f4
.count load_float
    load    [f.21989], $f5
.count move_args
    mov     $f11, $f2
    call    ext_floor
    fsub    $f11, $f1, $f1
.count move_args
    mov     $f4, $f2
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f5
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc3, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f0, $f1, ble.22568
bg.22568:
    mov     $f0, $fg15
    jr      $ra1
ble.22568:
.count load_float
    load    [f.21990], $f2
    fmul    $f2, $f1, $fg15
    jr      $ra1
bne.22565:
    jr      $ra1                        # |    563,192 |    563,192 |          0 |          0 |
be.22564:
    load    [ext_intersection_point + 0], $f1
    load    [$i2 + 7], $f2
    fsub    $f1, $f2, $f1
    load    [ext_intersection_point + 2], $f3
    fmul    $f1, $f1, $f1
    load    [$i2 + 9], $f4
    fsub    $f3, $f4, $f2
    fmul    $f2, $f2, $f2
    fadd    $f1, $f2, $f1
    fsqrt   $f1, $f1
    fmul    $f1, $fc6, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
.count load_float
    load    [f.21986], $f2
    fmul    $f1, $f2, $f2
    call    ext_cos
    fmul    $f1, $f1, $f1
    fsub    $fc0, $f1, $f2
    fmul    $f1, $fc5, $fg11
    fmul    $f2, $fc5, $fg15
    jr      $ra1
be.22563:
    load    [ext_intersection_point + 1], $f1# |      2,886 |      2,886 |          0 |          0 |
.count load_float
    load    [f.21993], $f2              # |      2,886 |      2,886 |      2,604 |          0 |
    fmul    $f1, $f2, $f2               # |      2,886 |      2,886 |          0 |          0 |
    call    ext_sin                     # |      2,886 |      2,886 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      2,886 |      2,886 |          0 |          0 |
    fsub    $fc0, $f1, $f2              # |      2,886 |      2,886 |          0 |          0 |
    fmul    $fc5, $f1, $fg16            # |      2,886 |      2,886 |          0 |          0 |
    fmul    $fc5, $f2, $fg11            # |      2,886 |      2,886 |          0 |          0 |
    jr      $ra1                        # |      2,886 |      2,886 |          0 |          0 |
be.22558:
.count load_float
    load    [f.21994], $f4              # |     94,583 |     94,583 |     31,703 |          0 |
    load    [ext_intersection_point + 2], $f1# |     94,583 |     94,583 |      2,383 |          0 |
    load    [$i2 + 9], $f2              # |     94,583 |     94,583 |          0 |          0 |
    fsub    $f1, $f2, $f5               # |     94,583 |     94,583 |          0 |          0 |
    fmul    $f5, $f4, $f2               # |     94,583 |     94,583 |          0 |          0 |
    call    ext_floor                   # |     94,583 |     94,583 |          0 |          0 |
.count load_float
    load    [f.21995], $f6              # |     94,583 |     94,583 |     32,052 |          0 |
    fmul    $f1, $f6, $f1               # |     94,583 |     94,583 |          0 |          0 |
.count load_float
    load    [f.21996], $f7              # |     94,583 |     94,583 |     32,067 |          0 |
    fsub    $f5, $f1, $f5               # |     94,583 |     94,583 |          0 |          0 |
    load    [ext_intersection_point + 0], $f2# |     94,583 |     94,583 |      2,889 |          0 |
    load    [$i2 + 7], $f3              # |     94,583 |     94,583 |          0 |          0 |
    fsub    $f2, $f3, $f8               # |     94,583 |     94,583 |          0 |          0 |
    fmul    $f8, $f4, $f2               # |     94,583 |     94,583 |          0 |          0 |
    call    ext_floor                   # |     94,583 |     94,583 |          0 |          0 |
    fmul    $f1, $f6, $f1               # |     94,583 |     94,583 |          0 |          0 |
    fsub    $f8, $f1, $f1               # |     94,583 |     94,583 |          0 |          0 |
    ble     $f7, $f1, ble.22559         # |     94,583 |     94,583 |          0 |     42,437 |
bg.22559:
    ble     $f7, $f5, ble.22813         # |     44,240 |     44,240 |          0 |     20,603 |
.count dual_jmp
    b       bg.22812                    # |     22,649 |     22,649 |          0 |          6 |
ble.22559:
    ble     $f7, $f5, bg.22812          # |     50,343 |     50,343 |          0 |     23,479 |
ble.22813:
    mov     $f0, $fg11                  # |     47,803 |     47,803 |          0 |          0 |
    jr      $ra1                        # |     47,803 |     47,803 |          0 |          0 |
bg.22812:
    mov     $fc5, $fg11                 # |     46,780 |     46,780 |          0 |          0 |
    jr      $ra1                        # |     46,780 |     46,780 |          0 |          0 |
.end utexture

######################################################################
# trace_reflections($i15, $f15, $f16, $i16)
# $ra = $ra4
# [$i1 - $i15, $i17]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_reflections
trace_reflections.2915:
    bl      $i15, 0, bl.22569           # |     36,992 |     36,992 |          0 |         23 |
bge.22569:
    load    [$ig1 + 0], $i12            # |     18,496 |     18,496 |          0 |          0 |
    load    [ext_reflections + $i15], $i17# |     18,496 |     18,496 |      4,486 |          0 |
    mov     $fc10, $fg7                 # |     18,496 |     18,496 |          0 |          0 |
    load    [$i12 + 0], $i1             # |     18,496 |     18,496 |          0 |          0 |
    bne     $i1, -1, bne.22570          # |     18,496 |     18,496 |          0 |          2 |
be.22570:
    ble     $fg7, $fc4, bne.22581
.count dual_jmp
    b       bg.22578
bne.22570:
    add     $i17, 1, $i8                # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 99, be.22571           # |     18,496 |     18,496 |          0 |          0 |
bne.22571:
.count move_args
    mov     $i8, $i2                    # |     18,496 |     18,496 |          0 |          0 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 0, ble.22577           # |     18,496 |     18,496 |          0 |         32 |
bne.22576:
    ble     $fg7, $fg0, ble.22577       # |      5,026 |      5,026 |          0 |        270 |
bg.22577:
    li      1, $i11                     # |      5,026 |      5,026 |          0 |          0 |
    jal     solve_one_or_network_fast.2889, $ra2# |      5,026 |      5,026 |          0 |          0 |
    li      1, $i13                     # |      5,026 |      5,026 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |      5,026 |      5,026 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |      5,026 |      5,026 |          0 |          0 |
    ble     $fg7, $fc4, bne.22581       # |      5,026 |      5,026 |          0 |      1,268 |
.count dual_jmp
    b       bg.22578                    # |      5,026 |      5,026 |          0 |          2 |
be.22571:
    load    [$i12 + 1], $i1
    be      $i1, -1, ble.22577
bne.22572:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 2], $i1
    be      $i1, -1, ble.22577
bne.22573:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 3], $i1
    be      $i1, -1, ble.22577
bne.22574:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 4], $i1
    be      $i1, -1, ble.22577
bne.22575:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i13
.count move_args
    mov     $ig1, $i14
    jal     trace_or_matrix_fast.2893, $ra3
    ble     $fg7, $fc4, bne.22581
.count dual_jmp
    b       bg.22578
ble.22577:
    li      1, $i13                     # |     13,470 |     13,470 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |     13,470 |     13,470 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |     13,470 |     13,470 |          0 |          0 |
    ble     $fg7, $fc4, bne.22581       # |     13,470 |     13,470 |          0 |      1,007 |
bg.22578:
    ble     $fc9, $fg7, bne.22581       # |     18,496 |     18,496 |          0 |      1,611 |
bg.22579:
    add     $ig3, $ig3, $i1             # |     11,284 |     11,284 |          0 |          0 |
    load    [$i17 + 0], $i2             # |     11,284 |     11,284 |      5,345 |          0 |
    add     $i1, $i1, $i1               # |     11,284 |     11,284 |          0 |          0 |
    add     $i1, $ig2, $i1              # |     11,284 |     11,284 |          0 |          0 |
    bne     $i1, $i2, bne.22581         # |     11,284 |     11,284 |          0 |        438 |
be.22581:
    li      0, $i10                     # |     10,329 |     10,329 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     10,329 |     10,329 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,329 |     10,329 |          0 |          0 |
    bne     $i1, 0, bne.22581           # |     10,329 |     10,329 |          0 |          0 |
be.22582:
    load    [$i17 + 5], $f1             # |     10,329 |     10,329 |      2,652 |          0 |
    fmul    $f1, $f15, $f4              # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_nvector + 0], $f2      # |     10,329 |     10,329 |          0 |          0 |
    load    [$i17 + 1], $f3             # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_nvector + 1], $f5      # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i17 + 2], $f6             # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f5, $f6, $f5               # |     10,329 |     10,329 |          0 |          0 |
    load    [ext_nvector + 2], $f7      # |     10,329 |     10,329 |          0 |          0 |
    fadd    $f2, $f5, $f2               # |     10,329 |     10,329 |          0 |          0 |
    load    [$i17 + 3], $f8             # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f7, $f8, $f7               # |     10,329 |     10,329 |          0 |          0 |
    fadd    $f2, $f7, $f2               # |     10,329 |     10,329 |          0 |          0 |
    fmul    $f4, $f2, $f2               # |     10,329 |     10,329 |          0 |          0 |
    ble     $f2, $f0, ble.22583         # |     10,329 |     10,329 |          0 |        895 |
bg.22583:
    fmul    $f2, $fg16, $f4             # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f2, $fg11, $f5             # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f2, $fg15, $f2             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg4, $f4, $fg4             # |      9,373 |      9,373 |          0 |          0 |
    load    [$i16 + 1], $f4             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg5, $f5, $fg5             # |      9,373 |      9,373 |          0 |          0 |
    load    [$i16 + 2], $f5             # |      9,373 |      9,373 |          0 |          0 |
    fadd    $fg6, $f2, $fg6             # |      9,373 |      9,373 |          0 |          0 |
    load    [$i16 + 0], $f2             # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f4, $f6, $f3               # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f5, $f8, $f4               # |      9,373 |      9,373 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |      9,373 |      9,373 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |      9,373 |      9,373 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      9,373 |      9,373 |          0 |          0 |
    ble     $f1, $f0, bne.22581         # |      9,373 |      9,373 |          0 |      5,062 |
.count dual_jmp
    b       bg.22584                    # |      7,720 |      7,720 |          0 |      2,762 |
ble.22583:
    load    [$i16 + 0], $f2             # |        956 |        956 |          0 |          0 |
    fmul    $f2, $f3, $f2               # |        956 |        956 |          0 |          0 |
    load    [$i16 + 1], $f4             # |        956 |        956 |          0 |          0 |
    fmul    $f4, $f6, $f3               # |        956 |        956 |          0 |          0 |
    load    [$i16 + 2], $f5             # |        956 |        956 |          0 |          0 |
    fmul    $f5, $f8, $f4               # |        956 |        956 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |        956 |        956 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |        956 |        956 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        956 |        956 |          0 |          0 |
    ble     $f1, $f0, bne.22581         # |        956 |        956 |          0 |          2 |
bg.22584:
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |          0 |          0 |
    add     $i15, -1, $i15              # |      7,720 |      7,720 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      7,720 |      7,720 |          0 |          0 |
    fmul    $f1, $f16, $f1              # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg5, $f1, $fg5             # |      7,720 |      7,720 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |      7,720 |      7,720 |          0 |          0 |
    b       trace_reflections.2915      # |      7,720 |      7,720 |          0 |      2,792 |
bne.22581:
    add     $i15, -1, $i15              # |     10,776 |     10,776 |          0 |          0 |
    b       trace_reflections.2915      # |     10,776 |     10,776 |          0 |        879 |
bl.22569:
    jr      $ra4                        # |     18,496 |     18,496 |          0 |          0 |
.end trace_reflections

######################################################################
# trace_ray($i18, $f17, $i16, $i19, $f18)
# $ra = $ra5
# [$i1 - $i15, $i17 - $i18, $i20 - $i21]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.align 2
.begin trace_ray
trace_ray.2920:
    bg      $i18, 4, bg.22585           # |     23,754 |     23,754 |          0 |        172 |
ble.22585:
    load    [$ig1 + 0], $i12            # |     23,754 |     23,754 |          1 |          0 |
    mov     $fc10, $fg7                 # |     23,754 |     23,754 |          0 |          0 |
    load    [$i12 + 0], $i1             # |     23,754 |     23,754 |          0 |          0 |
    bne     $i1, -1, bne.22586          # |     23,754 |     23,754 |          0 |         24 |
be.22586:
    add     $i19, 8, $i20
    ble     $fg7, $fc4, ble.22595
.count dual_jmp
    b       bg.22594
bne.22586:
    be      $i1, 99, be.22587           # |     23,754 |     23,754 |          0 |      6,386 |
bne.22587:
.count move_args
    mov     $i16, $i2                   # |     23,754 |     23,754 |          0 |          0 |
    call    solver.2773                 # |     23,754 |     23,754 |          0 |          0 |
.count move_args
    mov     $i16, $i8                   # |     23,754 |     23,754 |          0 |          0 |
    be      $i1, 0, ble.22593           # |     23,754 |     23,754 |          0 |        490 |
bne.22592:
    ble     $fg7, $fg0, ble.22593       # |      6,776 |      6,776 |          0 |         67 |
bg.22593:
    li      1, $i11                     # |      6,776 |      6,776 |          0 |          0 |
    jal     solve_one_or_network.2875, $ra2# |      6,776 |      6,776 |          0 |          0 |
    li      1, $i13                     # |      6,776 |      6,776 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |      6,776 |      6,776 |          0 |          0 |
.count move_args
    mov     $i16, $i8                   # |      6,776 |      6,776 |          0 |          0 |
    jal     trace_or_matrix.2879, $ra3  # |      6,776 |      6,776 |          0 |          0 |
    add     $i19, 8, $i20               # |      6,776 |      6,776 |          0 |          0 |
    ble     $fg7, $fc4, ble.22595       # |      6,776 |      6,776 |          0 |        461 |
.count dual_jmp
    b       bg.22594                    # |      6,776 |      6,776 |          0 |         53 |
be.22587:
    load    [$i12 + 1], $i1
.count move_args
    mov     $i16, $i8
    be      $i1, -1, ble.22593
bne.22588:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 2], $i1
.count move_args
    mov     $i16, $i8
    be      $i1, -1, ble.22593
bne.22589:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 3], $i1
.count move_args
    mov     $i16, $i8
    be      $i1, -1, ble.22593
bne.22590:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    load    [$i12 + 4], $i1
.count move_args
    mov     $i16, $i8
    be      $i1, -1, ble.22593
bne.22591:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element.2871, $ra1
    li      5, $i11
.count move_args
    mov     $i16, $i8
    jal     solve_one_or_network.2875, $ra2
    li      1, $i13
.count move_args
    mov     $ig1, $i14
.count move_args
    mov     $i16, $i8
    jal     trace_or_matrix.2879, $ra3
    add     $i19, 8, $i20
    ble     $fg7, $fc4, ble.22595
.count dual_jmp
    b       bg.22594
ble.22593:
    li      1, $i13                     # |     16,978 |     16,978 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |     16,978 |     16,978 |          0 |          0 |
    jal     trace_or_matrix.2879, $ra3  # |     16,978 |     16,978 |          0 |          0 |
    add     $i19, 8, $i20               # |     16,978 |     16,978 |          0 |          0 |
    ble     $fg7, $fc4, ble.22595       # |     16,978 |     16,978 |          0 |          6 |
bg.22594:
    bg      $fc9, $fg7, bg.22595        # |     23,754 |     23,754 |          0 |      4,340 |
ble.22595:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |      5,258 |      5,258 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |          0 |          0 |
    be      $i18, 0, bg.22585           # |      5,258 |      5,258 |          0 |          2 |
bne.22597:
    load    [$i16 + 0], $f1             # |      5,258 |      5,258 |          0 |          0 |
    load    [$i16 + 1], $f2             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f1, $fg14, $f1             # |      5,258 |      5,258 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f2, $fg12, $f2             # |      5,258 |      5,258 |          0 |          0 |
    fmul    $f3, $fg13, $f3             # |      5,258 |      5,258 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |      5,258 |      5,258 |          0 |          0 |
    ble     $f1, $f0, bg.22585          # |      5,258 |      5,258 |          0 |        192 |
bg.22598:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |          0 |          0 |
    load    [ext_beam + 0], $f3         # |      1,984 |      1,984 |         71 |          0 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |          0 |          0 |
    fmul    $f1, $f17, $f1              # |      1,984 |      1,984 |          0 |          0 |
    fmul    $f1, $f3, $f1               # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |          0 |          0 |
    jr      $ra5                        # |      1,984 |      1,984 |          0 |          0 |
bg.22595:
    load    [ext_objects + $ig3], $i21  # |     18,496 |     18,496 |          0 |          0 |
    load    [$i21 + 1], $i1             # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 1, be.22599            # |     18,496 |     18,496 |          0 |        579 |
bne.22599:
    load    [$i21 + 4], $f1             # |     10,586 |     10,586 |          0 |          0 |
    bne     $i1, 2, bne.22602           # |     10,586 |     10,586 |          0 |        569 |
be.22602:
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |      7,226 |      7,226 |          0 |          0 |
    load    [$i21 + 5], $f1             # |      7,226 |      7,226 |          0 |          0 |
.count move_args
    mov     $i21, $i2                   # |      7,226 |      7,226 |          0 |          0 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |      7,226 |      7,226 |          0 |          0 |
    load    [$i21 + 6], $f1             # |      7,226 |      7,226 |          0 |          0 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |      7,226 |      7,226 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg17# |      7,226 |      7,226 |         59 |          0 |
    load    [ext_intersection_point + 1], $fg18# |      7,226 |      7,226 |         58 |          0 |
    load    [ext_intersection_point + 2], $fg19# |      7,226 |      7,226 |         58 |          0 |
    jal     utexture.2908, $ra1         # |      7,226 |      7,226 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |      7,226 |      7,226 |          0 |          0 |
    add     $i19, 3, $i2                # |      7,226 |      7,226 |          0 |          0 |
    add     $i1, $i1, $i1               # |      7,226 |      7,226 |          0 |          0 |
    add     $i19, 13, $i3               # |      7,226 |      7,226 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      7,226 |      7,226 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |      7,226 |      7,226 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      7,226 |      7,226 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |      7,226 |      7,226 |      7,226 |          0 |
    load    [ext_intersection_point + 0], $f1# |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      7,226 |      7,226 |          0 |          0 |
    load    [ext_intersection_point + 1], $f1# |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      7,226 |      7,226 |          0 |          0 |
    load    [ext_intersection_point + 2], $f1# |      7,226 |      7,226 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |      7,226 |      7,226 |          0 |          0 |
    load    [$i21 + 11], $f1            # |      7,226 |      7,226 |         17 |          0 |
    fmul    $f1, $f17, $f15             # |      7,226 |      7,226 |          0 |          0 |
    ble     $fc3, $f1, ble.22606        # |      7,226 |      7,226 |          0 |        154 |
.count dual_jmp
    b       bg.22606                    # |      7,222 |      7,222 |          0 |          4 |
bne.22602:
    load    [$i21 + 3], $i1             # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_intersection_point + 0], $f2# |      3,360 |      3,360 |        120 |          0 |
    load    [$i21 + 7], $f3             # |      3,360 |      3,360 |          0 |          0 |
    load    [$i21 + 5], $f4             # |      3,360 |      3,360 |          0 |          0 |
    fsub    $f2, $f3, $f2               # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_intersection_point + 1], $f5# |      3,360 |      3,360 |        120 |          0 |
    fmul    $f2, $f1, $f1               # |      3,360 |      3,360 |          0 |          0 |
    load    [$i21 + 8], $f3             # |      3,360 |      3,360 |          0 |          0 |
    fsub    $f5, $f3, $f3               # |      3,360 |      3,360 |          0 |          0 |
    load    [$i21 + 6], $f6             # |      3,360 |      3,360 |          0 |          0 |
    fmul    $f3, $f4, $f4               # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_intersection_point + 2], $f7# |      3,360 |      3,360 |        120 |          0 |
    load    [$i21 + 9], $f8             # |      3,360 |      3,360 |          0 |          0 |
    fsub    $f7, $f8, $f5               # |      3,360 |      3,360 |          0 |          0 |
    fmul    $f5, $f6, $f6               # |      3,360 |      3,360 |          0 |          0 |
    be      $i1, 0, be.22603            # |      3,360 |      3,360 |          0 |          7 |
bne.22603:
    load    [$i21 + 18], $f7
    load    [$i21 + 17], $f8
    fmul    $f3, $f7, $f7
    fmul    $f5, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc3, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i21 + 18], $f1
    load    [$i21 + 16], $f7
    fmul    $f2, $f1, $f1
    fmul    $f5, $f7, $f5
    fadd    $f1, $f5, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f4, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i21 + 17], $f1
    load    [$i21 + 16], $f4
    fmul    $f2, $f1, $f1
    fmul    $f3, $f4, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f6, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [ext_nvector + 0], $f1
    load    [ext_nvector + 1], $f2
    fmul    $f1, $f1, $f3
    load    [$i21 + 10], $i1
    fmul    $f2, $f2, $f2
    load    [ext_nvector + 2], $f4
    fmul    $f4, $f4, $f4
    fadd    $f3, $f2, $f2
    fadd    $f2, $f4, $f2
    fsqrt   $f2, $f2
    be      $f2, $f0, be.22604
.count dual_jmp
    b       bne.22604
be.22603:
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |          0 |          0 |
    store   $f4, [ext_nvector + 1]      # |      3,360 |      3,360 |          0 |          0 |
    store   $f6, [ext_nvector + 2]      # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |      3,360 |      3,360 |        257 |          0 |
    fmul    $f1, $f1, $f3               # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |      3,360 |      3,360 |        257 |          0 |
    fmul    $f2, $f2, $f2               # |      3,360 |      3,360 |          0 |          0 |
    load    [$i21 + 10], $i1            # |      3,360 |      3,360 |          0 |          0 |
    fadd    $f3, $f2, $f2               # |      3,360 |      3,360 |          0 |          0 |
    load    [ext_nvector + 2], $f4      # |      3,360 |      3,360 |        257 |          0 |
    fmul    $f4, $f4, $f4               # |      3,360 |      3,360 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |      3,360 |      3,360 |          0 |          0 |
    fsqrt   $f2, $f2                    # |      3,360 |      3,360 |          0 |          0 |
    bne     $f2, $f0, bne.22604         # |      3,360 |      3,360 |          0 |          6 |
be.22604:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
.count move_args
    mov     $i21, $i2
    store   $f1, [ext_nvector + 0]
    load    [ext_nvector + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 1]
    load    [ext_nvector + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 2]
    load    [ext_intersection_point + 0], $fg17
    load    [ext_intersection_point + 1], $fg18
    load    [ext_intersection_point + 2], $fg19
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i19, 3, $i2
    add     $i1, $i1, $i1
    add     $i19, 13, $i3
    add     $i1, $ig2, $i1
.count storer
    add     $i20, $i18, $tmp
    store   $i1, [$tmp + 0]
    load    [$i2 + $i18], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    load    [$i21 + 11], $f1
    fmul    $f1, $f17, $f15
    ble     $fc3, $f1, ble.22606
.count dual_jmp
    b       bg.22606
bne.22604:
.count move_args
    mov     $i21, $i2                   # |      3,360 |      3,360 |          0 |          0 |
    be      $i1, 0, be.22605            # |      3,360 |      3,360 |          0 |        174 |
bne.22605:
    finv_n  $f2, $f2                    # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |        232 |        232 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |        232 |        232 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |        232 |        232 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        232 |        232 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |        232 |        232 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg17# |        232 |        232 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg18# |        232 |        232 |          0 |          0 |
    load    [ext_intersection_point + 2], $fg19# |        232 |        232 |          0 |          0 |
    jal     utexture.2908, $ra1         # |        232 |        232 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |        232 |        232 |          0 |          0 |
    add     $i19, 3, $i2                # |        232 |        232 |          0 |          0 |
    add     $i1, $i1, $i1               # |        232 |        232 |          0 |          0 |
    add     $i19, 13, $i3               # |        232 |        232 |          0 |          0 |
    add     $i1, $ig2, $i1              # |        232 |        232 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |        232 |        232 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |        232 |        232 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |        232 |        232 |        232 |          0 |
    load    [ext_intersection_point + 0], $f1# |        232 |        232 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |        232 |        232 |          0 |          0 |
    load    [ext_intersection_point + 1], $f1# |        232 |        232 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |        232 |        232 |          0 |          0 |
    load    [ext_intersection_point + 2], $f1# |        232 |        232 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |        232 |        232 |          0 |          0 |
    load    [$i21 + 11], $f1            # |        232 |        232 |         63 |          0 |
    fmul    $f1, $f17, $f15             # |        232 |        232 |          0 |          0 |
    ble     $fc3, $f1, ble.22606        # |        232 |        232 |          0 |          2 |
.count dual_jmp
    b       bg.22606
be.22605:
    finv    $f2, $f2                    # |      3,128 |      3,128 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |      3,128 |      3,128 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |      3,128 |      3,128 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |      3,128 |      3,128 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |      3,128 |      3,128 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |      3,128 |      3,128 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg17# |      3,128 |      3,128 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg18# |      3,128 |      3,128 |          0 |          0 |
    load    [ext_intersection_point + 2], $fg19# |      3,128 |      3,128 |          0 |          0 |
    jal     utexture.2908, $ra1         # |      3,128 |      3,128 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |      3,128 |      3,128 |          0 |          0 |
    add     $i19, 3, $i2                # |      3,128 |      3,128 |          0 |          0 |
    add     $i1, $i1, $i1               # |      3,128 |      3,128 |          0 |          0 |
    add     $i19, 13, $i3               # |      3,128 |      3,128 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      3,128 |      3,128 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |      3,128 |      3,128 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      3,128 |      3,128 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |      3,128 |      3,128 |      3,128 |          0 |
    load    [ext_intersection_point + 0], $f1# |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      3,128 |      3,128 |          0 |          0 |
    load    [ext_intersection_point + 1], $f1# |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      3,128 |      3,128 |          0 |          0 |
    load    [ext_intersection_point + 2], $f1# |      3,128 |      3,128 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |      3,128 |      3,128 |          0 |          0 |
    load    [$i21 + 11], $f1            # |      3,128 |      3,128 |      1,287 |          0 |
    fmul    $f1, $f17, $f15             # |      3,128 |      3,128 |          0 |          0 |
    ble     $fc3, $f1, ble.22606        # |      3,128 |      3,128 |          0 |        293 |
.count dual_jmp
    b       bg.22606                    # |        148 |        148 |          0 |          2 |
be.22599:
    add     $ig2, -1, $i1               # |      7,910 |      7,910 |          0 |          0 |
    store   $f0, [ext_nvector + 0]      # |      7,910 |      7,910 |          0 |          0 |
.count move_args
    mov     $i21, $i2                   # |      7,910 |      7,910 |          0 |          0 |
    store   $f0, [ext_nvector + 1]      # |      7,910 |      7,910 |          0 |          0 |
    store   $f0, [ext_nvector + 2]      # |      7,910 |      7,910 |          0 |          0 |
    load    [$i16 + $i1], $f1           # |      7,910 |      7,910 |          0 |          0 |
    bne     $f1, $f0, bne.22600         # |      7,910 |      7,910 |          0 |          6 |
be.22600:
    store   $f0, [ext_nvector + $i1]
    load    [ext_intersection_point + 0], $fg17
    load    [ext_intersection_point + 1], $fg18
    load    [ext_intersection_point + 2], $fg19
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i19, 3, $i2
    add     $i1, $i1, $i1
    add     $i19, 13, $i3
    add     $i1, $ig2, $i1
.count storer
    add     $i20, $i18, $tmp
    store   $i1, [$tmp + 0]
    load    [$i2 + $i18], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    load    [$i21 + 11], $f1
    fmul    $f1, $f17, $f15
    ble     $fc3, $f1, ble.22606
.count dual_jmp
    b       bg.22606
bne.22600:
    ble     $f1, $f0, ble.22601         # |      7,910 |      7,910 |          0 |        383 |
bg.22601:
    store   $fc15, [ext_nvector + $i1]  # |      1,243 |      1,243 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg17# |      1,243 |      1,243 |         29 |          0 |
    load    [ext_intersection_point + 1], $fg18# |      1,243 |      1,243 |         36 |          0 |
    load    [ext_intersection_point + 2], $fg19# |      1,243 |      1,243 |         36 |          0 |
    jal     utexture.2908, $ra1         # |      1,243 |      1,243 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |      1,243 |      1,243 |          0 |          0 |
    add     $i19, 3, $i2                # |      1,243 |      1,243 |          0 |          0 |
    add     $i1, $i1, $i1               # |      1,243 |      1,243 |          0 |          0 |
    add     $i19, 13, $i3               # |      1,243 |      1,243 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      1,243 |      1,243 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |      1,243 |      1,243 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      1,243 |      1,243 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |      1,243 |      1,243 |      1,243 |          0 |
    load    [ext_intersection_point + 0], $f1# |      1,243 |      1,243 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      1,243 |      1,243 |          0 |          0 |
    load    [ext_intersection_point + 1], $f1# |      1,243 |      1,243 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      1,243 |      1,243 |          0 |          0 |
    load    [ext_intersection_point + 2], $f1# |      1,243 |      1,243 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |      1,243 |      1,243 |          0 |          0 |
    load    [$i21 + 11], $f1            # |      1,243 |      1,243 |        448 |          0 |
    fmul    $f1, $f17, $f15             # |      1,243 |      1,243 |          0 |          0 |
    ble     $fc3, $f1, ble.22606        # |      1,243 |      1,243 |          0 |        387 |
.count dual_jmp
    b       bg.22606
ble.22601:
    store   $fc0, [ext_nvector + $i1]   # |      6,667 |      6,667 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg17# |      6,667 |      6,667 |         14 |          0 |
    load    [ext_intersection_point + 1], $fg18# |      6,667 |      6,667 |         16 |          0 |
    load    [ext_intersection_point + 2], $fg19# |      6,667 |      6,667 |         16 |          0 |
    jal     utexture.2908, $ra1         # |      6,667 |      6,667 |          0 |          0 |
    add     $ig3, $ig3, $i1             # |      6,667 |      6,667 |          0 |          0 |
    add     $i19, 3, $i2                # |      6,667 |      6,667 |          0 |          0 |
    add     $i1, $i1, $i1               # |      6,667 |      6,667 |          0 |          0 |
    add     $i19, 13, $i3               # |      6,667 |      6,667 |          0 |          0 |
    add     $i1, $ig2, $i1              # |      6,667 |      6,667 |          0 |          0 |
.count storer
    add     $i20, $i18, $tmp            # |      6,667 |      6,667 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      6,667 |      6,667 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |      6,667 |      6,667 |      6,667 |          0 |
    load    [ext_intersection_point + 0], $f1# |      6,667 |      6,667 |          0 |          0 |
    store   $f1, [$i1 + 0]              # |      6,667 |      6,667 |          0 |          0 |
    load    [ext_intersection_point + 1], $f1# |      6,667 |      6,667 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |      6,667 |      6,667 |          0 |          0 |
    load    [ext_intersection_point + 2], $f1# |      6,667 |      6,667 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |      6,667 |      6,667 |          0 |          0 |
    load    [$i21 + 11], $f1            # |      6,667 |      6,667 |      3,023 |          0 |
    fmul    $f1, $f17, $f15             # |      6,667 |      6,667 |          0 |          0 |
    ble     $fc3, $f1, ble.22606        # |      6,667 |      6,667 |          0 |        135 |
bg.22606:
    li      0, $i1                      # |      7,370 |      7,370 |          0 |          0 |
.count storer
    add     $i3, $i18, $tmp             # |      7,370 |      7,370 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |      7,370 |      7,370 |         56 |          0 |
.count load_float
    load    [f.22001], $f2              # |      7,370 |      7,370 |      1,452 |          0 |
    load    [$i16 + 0], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f3, $f1, $f6               # |      7,370 |      7,370 |          0 |          0 |
    load    [$i16 + 1], $f4             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 1], $f5      # |      7,370 |      7,370 |         56 |          0 |
    load    [$i16 + 2], $f7             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 2], $f5      # |      7,370 |      7,370 |         54 |          0 |
    fmul    $f7, $f5, $f5               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f6, $f4, $f4               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f4, $f2               # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i16 + 0]             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    load    [$i16 + 1], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i16 + 1]             # |      7,370 |      7,370 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |      7,370 |      7,370 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |          0 |          0 |
    store   $f1, [$i16 + 2]             # |      7,370 |      7,370 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |      7,370 |      7,370 |          0 |          0 |
    load    [$i9 + 0], $i1              # |      7,370 |      7,370 |          0 |          0 |
    be      $i1, -1, be.22607           # |      7,370 |      7,370 |          0 |          0 |
.count dual_jmp
    b       bne.22607                   # |      7,370 |      7,370 |          0 |         66 |
ble.22606:
    li      1, $i1                      # |     11,126 |     11,126 |          0 |          0 |
.count storer
    add     $i3, $i18, $tmp             # |     11,126 |     11,126 |          0 |          0 |
    add     $i19, 18, $i2               # |     11,126 |     11,126 |          0 |          0 |
    store   $i1, [$tmp + 0]             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |     11,126 |     11,126 |     11,126 |          0 |
    add     $i19, 29, $i3               # |     11,126 |     11,126 |          0 |          0 |
.count load_float
    load    [f.22000], $f1              # |     11,126 |     11,126 |     11,126 |          0 |
    fmul    $f1, $f15, $f1              # |     11,126 |     11,126 |          0 |          0 |
    store   $fg16, [$i1 + 0]            # |     11,126 |     11,126 |          0 |          0 |
    store   $fg11, [$i1 + 1]            # |     11,126 |     11,126 |          0 |          0 |
    store   $fg15, [$i1 + 2]            # |     11,126 |     11,126 |          0 |          0 |
    load    [$i2 + $i18], $i1           # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 0], $f2              # |     11,126 |     11,126 |     11,126 |          0 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |          0 |          0 |
    store   $f2, [$i1 + 0]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 1], $f2              # |     11,126 |     11,126 |     11,126 |          0 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |          0 |          0 |
    store   $f2, [$i1 + 1]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i1 + 2], $f2              # |     11,126 |     11,126 |     11,126 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |          0 |          0 |
    load    [$i3 + $i18], $i1           # |     11,126 |     11,126 |     11,126 |          0 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |         95 |          0 |
    store   $f1, [$i1 + 0]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |         73 |          0 |
    store   $f1, [$i1 + 1]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |         74 |          0 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |          0 |          0 |
.count load_float
    load    [f.22001], $f2              # |     11,126 |     11,126 |      5,965 |          0 |
    load    [$i16 + 0], $f3             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f3, $f1, $f6               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i16 + 1], $f4             # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f5      # |     11,126 |     11,126 |          0 |          0 |
    load    [$i16 + 2], $f7             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f4, $f5, $f4               # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f5      # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f7, $f5, $f5               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f6, $f4, $f4               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f4, $f2               # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i16 + 0]             # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    load    [$i16 + 1], $f3             # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i16 + 1]             # |     11,126 |     11,126 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |          0 |          0 |
    load    [$i16 + 2], $f3             # |     11,126 |     11,126 |          0 |          0 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |          0 |          0 |
    store   $f1, [$i16 + 2]             # |     11,126 |     11,126 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |     11,126 |     11,126 |          0 |          0 |
    load    [$i9 + 0], $i1              # |     11,126 |     11,126 |          0 |          0 |
    be      $i1, -1, be.22607           # |     11,126 |     11,126 |          0 |         65 |
bne.22607:
    be      $i1, 99, bne.22612          # |     18,496 |     18,496 |          0 |         30 |
bne.22608:
    call    solver_fast.2796            # |     18,496 |     18,496 |          0 |          0 |
    be      $i1, 0, be.22621            # |     18,496 |     18,496 |          0 |      4,666 |
bne.22609:
    ble     $fc4, $fg0, be.22621        # |      5,091 |      5,091 |          0 |        235 |
bg.22610:
    load    [$i9 + 1], $i1              # |      4,884 |      4,884 |          0 |          0 |
    be      $i1, -1, be.22621           # |      4,884 |      4,884 |          0 |         28 |
bne.22611:
    li      0, $i7                      # |      4,884 |      4,884 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      4,884 |      4,884 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |      4,884 |      4,884 |          0 |          0 |
    bne     $i1, 0, bne.22612           # |      4,884 |      4,884 |          0 |        369 |
be.22612:
    load    [$i9 + 2], $i1              # |      4,517 |      4,517 |          0 |          0 |
    be      $i1, -1, be.22621           # |      4,517 |      4,517 |          0 |         13 |
bne.22613:
    li      0, $i7                      # |      4,517 |      4,517 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |      4,517 |      4,517 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |      4,517 |      4,517 |          0 |          0 |
    bne     $i1, 0, bne.22612           # |      4,517 |      4,517 |          0 |        195 |
be.22614:
    li      3, $i8                      # |      4,439 |      4,439 |          0 |          0 |
    jal     shadow_check_one_or_group.2865, $ra2# |      4,439 |      4,439 |          0 |          0 |
    be      $i1, 0, be.22621            # |      4,439 |      4,439 |          0 |         90 |
bne.22612:
    load    [$i9 + 1], $i1              # |        784 |        784 |          0 |          0 |
    be      $i1, -1, be.22621           # |        784 |        784 |          0 |         56 |
bne.22617:
    li      0, $i7                      # |        784 |        784 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |        784 |        784 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |        784 |        784 |          0 |          0 |
    bne     $i1, 0, bne.22618           # |        784 |        784 |          0 |        200 |
be.22618:
    load    [$i9 + 2], $i1              # |        417 |        417 |          0 |          0 |
    be      $i1, -1, be.22621           # |        417 |        417 |          0 |         13 |
bne.22619:
    li      0, $i7                      # |        417 |        417 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |        417 |        417 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |        417 |        417 |          0 |          0 |
    bne     $i1, 0, bne.22618           # |        417 |        417 |          0 |         11 |
be.22620:
    li      3, $i8                      # |        339 |        339 |          0 |          0 |
    jal     shadow_check_one_or_group.2865, $ra2# |        339 |        339 |          0 |          0 |
    be      $i1, 0, be.22621            # |        339 |        339 |          0 |        146 |
bne.22618:
    load    [$i21 + 12], $f1            # |        784 |        784 |        459 |          0 |
    li      ext_intersection_point, $i2 # |        784 |        784 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg8# |        784 |        784 |          0 |          0 |
    fmul    $f17, $f1, $f16             # |        784 |        784 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg9# |        784 |        784 |          0 |          0 |
    load    [ext_intersection_point + 2], $fg10# |        784 |        784 |          0 |          0 |
    add     $ig0, -1, $i1               # |        784 |        784 |          0 |          0 |
    call    setup_startp_constants.2831 # |        784 |        784 |          0 |          0 |
    add     $ig4, -1, $i15              # |        784 |        784 |          0 |          0 |
    jal     trace_reflections.2915, $ra4# |        784 |        784 |          0 |          0 |
    ble     $f17, $fc6, bg.22585        # |        784 |        784 |          0 |          8 |
.count dual_jmp
    b       bg.22625                    # |        784 |        784 |          0 |        159 |
be.22621:
    li      1, $i10                     # |     17,712 |     17,712 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |     17,712 |     17,712 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     17,712 |     17,712 |          0 |          0 |
    load    [$i21 + 12], $f1            # |     17,712 |     17,712 |      6,417 |          0 |
    fmul    $f17, $f1, $f16             # |     17,712 |     17,712 |          0 |          0 |
    bne     $i1, 0, bne.22622           # |     17,712 |     17,712 |          0 |          4 |
be.22622:
    load    [ext_nvector + 0], $f1      # |     17,539 |     17,539 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f1, $fg14, $f1             # |     17,539 |     17,539 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f2, $fg12, $f2             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f3, $fg13, $f3             # |     17,539 |     17,539 |          0 |          0 |
    load    [$i16 + 0], $f4             # |     17,539 |     17,539 |          0 |          0 |
    load    [$i16 + 1], $f5             # |     17,539 |     17,539 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |     17,539 |     17,539 |          0 |          0 |
    load    [$i16 + 2], $f6             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f4, $fg14, $f2             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f5, $fg12, $f4             # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f6, $fg13, $f5             # |     17,539 |     17,539 |          0 |          0 |
    fadd_n  $f1, $f3, $f1               # |     17,539 |     17,539 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |     17,539 |     17,539 |          0 |          0 |
    fmul    $f1, $f15, $f1              # |     17,539 |     17,539 |          0 |          0 |
    fadd_n  $f2, $f5, $f2               # |     17,539 |     17,539 |          0 |          0 |
    ble     $f1, $f0, ble.22623         # |     17,539 |     17,539 |          0 |          4 |
.count dual_jmp
    b       bg.22623                    # |     17,537 |     17,537 |          0 |          6 |
be.22607:
    load    [$i21 + 12], $f1
    fmul    $f17, $f1, $f16
    load    [ext_nvector + 1], $f2
    fmul    $f2, $fg12, $f2
    load    [ext_nvector + 2], $f3
    fmul    $f3, $fg13, $f3
    load    [ext_nvector + 0], $f1
    fmul    $f1, $fg14, $f1
    load    [$i16 + 0], $f4
    fadd    $f1, $f2, $f1
    load    [$i16 + 1], $f5
    fmul    $f4, $fg14, $f2
    load    [$i16 + 2], $f6
    fmul    $f5, $fg12, $f4
    fmul    $f6, $fg13, $f5
    fadd_n  $f1, $f3, $f1
    fadd    $f2, $f4, $f2
    fmul    $f1, $f15, $f1
    fadd_n  $f2, $f5, $f2
    ble     $f1, $f0, ble.22623
bg.22623:
    fmul    $f1, $fg16, $f3             # |     17,537 |     17,537 |          0 |          0 |
    fmul    $f1, $fg11, $f4             # |     17,537 |     17,537 |          0 |          0 |
    fmul    $f1, $fg15, $f1             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg4, $f3, $fg4             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg5, $f4, $fg5             # |     17,537 |     17,537 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |     17,537 |     17,537 |          0 |          0 |
    ble     $f2, $f0, bne.22622         # |     17,537 |     17,537 |          0 |        842 |
.count dual_jmp
    b       bg.22624                    # |      6,452 |      6,452 |          0 |          2 |
ble.22623:
    ble     $f2, $f0, bne.22622         # |          2 |          2 |          0 |          1 |
bg.22624:
    fmul    $f2, $f2, $f1               # |      6,452 |      6,452 |          0 |          0 |
    li      ext_intersection_point, $i2 # |      6,452 |      6,452 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg8# |      6,452 |      6,452 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg9# |      6,452 |      6,452 |          0 |          0 |
    fmul    $f1, $f1, $f1               # |      6,452 |      6,452 |          0 |          0 |
    load    [ext_intersection_point + 2], $fg10# |      6,452 |      6,452 |          0 |          0 |
    add     $ig0, -1, $i1               # |      6,452 |      6,452 |          0 |          0 |
    fmul    $f1, $f16, $f1              # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg5, $f1, $fg5             # |      6,452 |      6,452 |          0 |          0 |
    fadd    $fg6, $f1, $fg6             # |      6,452 |      6,452 |          0 |          0 |
    call    setup_startp_constants.2831 # |      6,452 |      6,452 |          0 |          0 |
    add     $ig4, -1, $i15              # |      6,452 |      6,452 |          0 |          0 |
    jal     trace_reflections.2915, $ra4# |      6,452 |      6,452 |          0 |          0 |
    ble     $f17, $fc6, bg.22585        # |      6,452 |      6,452 |          0 |      1,352 |
.count dual_jmp
    b       bg.22625                    # |      6,452 |      6,452 |          0 |         51 |
bne.22622:
    li      ext_intersection_point, $i2 # |     11,260 |     11,260 |          0 |          0 |
    load    [ext_intersection_point + 0], $fg8# |     11,260 |     11,260 |          0 |          0 |
    add     $ig0, -1, $i1               # |     11,260 |     11,260 |          0 |          0 |
    load    [ext_intersection_point + 1], $fg9# |     11,260 |     11,260 |          0 |          0 |
    load    [ext_intersection_point + 2], $fg10# |     11,260 |     11,260 |          0 |          0 |
    call    setup_startp_constants.2831 # |     11,260 |     11,260 |          0 |          0 |
    add     $ig4, -1, $i15              # |     11,260 |     11,260 |          0 |          0 |
    jal     trace_reflections.2915, $ra4# |     11,260 |     11,260 |          0 |          0 |
    ble     $f17, $fc6, bg.22585        # |     11,260 |     11,260 |          0 |        962 |
bg.22625:
    bge     $i18, 4, bge.22626          # |     18,496 |     18,496 |          0 |        313 |
bl.22626:
    add     $i18, 1, $i1                # |     18,496 |     18,496 |          0 |          0 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |          0 |          0 |
.count storer
    add     $i20, $i1, $tmp             # |     18,496 |     18,496 |          0 |          0 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |          0 |          0 |
    load    [$i21 + 2], $i1             # |     18,496 |     18,496 |      6,449 |          0 |
    be      $i1, 2, be.22627            # |     18,496 |     18,496 |          0 |        312 |
.count dual_jmp
    b       bg.22585                    # |     11,126 |     11,126 |          0 |        139 |
bge.22626:
    load    [$i21 + 2], $i1
    be      $i1, 2, be.22627
bg.22585:
    jr      $ra5                        # |     14,400 |     14,400 |          0 |          0 |
be.22627:
    load    [$i21 + 11], $f1            # |      7,370 |      7,370 |          0 |          0 |
    fadd    $f18, $fg7, $f18            # |      7,370 |      7,370 |          0 |          0 |
    add     $i18, 1, $i18               # |      7,370 |      7,370 |          0 |          0 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |          0 |          0 |
    fmul    $f17, $f1, $f17             # |      7,370 |      7,370 |          0 |          0 |
    b       trace_ray.2920              # |      7,370 |      7,370 |          0 |         57 |
.end trace_ray

######################################################################
# trace_diffuse_ray($i8, $f15)
# $ra = $ra4
# [$i1 - $i14]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.align 2
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
    load    [$ig1 + 0], $i12            # |  1,116,120 |  1,116,120 |      1,657 |          0 |
    mov     $fc10, $fg7                 # |  1,116,120 |  1,116,120 |          0 |          0 |
    load    [$i12 + 0], $i1             # |  1,116,120 |  1,116,120 |      1,589 |          0 |
    bne     $i1, -1, bne.22628          # |  1,116,120 |  1,116,120 |          0 |     37,790 |
be.22628:
    ble     $fg7, $fc4, bne.22657
.count dual_jmp
    b       bg.22636
bne.22628:
    be      $i1, 99, be.22629           # |  1,116,120 |  1,116,120 |          0 |     64,860 |
bne.22629:
.count move_args
    mov     $i8, $i2                    # |  1,116,120 |  1,116,120 |          0 |          0 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |          0 |          0 |
    be      $i1, 0, ble.22635           # |  1,116,120 |  1,116,120 |          0 |      7,003 |
bne.22634:
    ble     $fg7, $fg0, ble.22635       # |    679,798 |    679,798 |          0 |      5,309 |
bg.22635:
    li      1, $i11                     # |    679,798 |    679,798 |          0 |          0 |
    jal     solve_one_or_network_fast.2889, $ra2# |    679,798 |    679,798 |          0 |          0 |
    li      1, $i13                     # |    679,798 |    679,798 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |    679,798 |    679,798 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |    679,798 |    679,798 |          0 |          0 |
    ble     $fg7, $fc4, bne.22657       # |    679,798 |    679,798 |          0 |          0 |
.count dual_jmp
    b       bg.22636                    # |    679,798 |    679,798 |          0 |        297 |
be.22629:
    load    [$i12 + 1], $i1
    be      $i1, -1, ble.22635
bne.22630:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 2], $i1
    be      $i1, -1, ble.22635
bne.22631:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 3], $i1
    be      $i1, -1, ble.22635
bne.22632:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    load    [$i12 + 4], $i1
    be      $i1, -1, ble.22635
bne.22633:
    li      0, $i7
    load    [ext_and_net + $i1], $i3
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i11
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i13
.count move_args
    mov     $ig1, $i14
    jal     trace_or_matrix_fast.2893, $ra3
    ble     $fg7, $fc4, bne.22657
.count dual_jmp
    b       bg.22636
ble.22635:
    li      1, $i13                     # |    436,322 |    436,322 |          0 |          0 |
.count move_args
    mov     $ig1, $i14                  # |    436,322 |    436,322 |          0 |          0 |
    jal     trace_or_matrix_fast.2893, $ra3# |    436,322 |    436,322 |          0 |          0 |
    ble     $fg7, $fc4, bne.22657       # |    436,322 |    436,322 |          0 |      1,487 |
bg.22636:
    ble     $fc9, $fg7, bne.22657       # |  1,116,120 |  1,116,120 |          0 |    238,859 |
bg.22637:
    load    [ext_objects + $ig3], $i12  # |    642,165 |    642,165 |      1,439 |          0 |
    load    [$i12 + 1], $i1             # |    642,165 |    642,165 |      1,209 |          0 |
    be      $i1, 1, be.22639            # |    642,165 |    642,165 |          0 |     60,974 |
bne.22639:
    load    [$i12 + 4], $f1             # |    527,176 |    527,176 |      4,104 |          0 |
    bne     $i1, 2, bne.22642           # |    527,176 |    527,176 |          0 |     72,481 |
be.22642:
    fneg    $f1, $f1                    # |    391,513 |    391,513 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |    391,513 |    391,513 |          0 |          0 |
.count move_args
    mov     $i12, $i2                   # |    391,513 |    391,513 |          0 |          0 |
    load    [$i12 + 5], $f1             # |    391,513 |    391,513 |      3,189 |          0 |
    fneg    $f1, $f1                    # |    391,513 |    391,513 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |    391,513 |    391,513 |          0 |          0 |
    load    [$i12 + 6], $f1             # |    391,513 |    391,513 |      3,382 |          0 |
    fneg    $f1, $f1                    # |    391,513 |    391,513 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |    391,513 |    391,513 |          0 |          0 |
    jal     utexture.2908, $ra1         # |    391,513 |    391,513 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |    391,513 |    391,513 |      2,033 |          0 |
    load    [$i9 + 0], $i1              # |    391,513 |    391,513 |      2,138 |          0 |
    be      $i1, -1, be.22661           # |    391,513 |    391,513 |          0 |          0 |
.count dual_jmp
    b       bne.22646                   # |    391,513 |    391,513 |          0 |      2,428 |
bne.22642:
    load    [$i12 + 3], $i1             # |    135,663 |    135,663 |        700 |          0 |
    load    [ext_intersection_point + 0], $f2# |    135,663 |    135,663 |      2,740 |          0 |
    load    [$i12 + 7], $f3             # |    135,663 |    135,663 |        581 |          0 |
    load    [$i12 + 5], $f4             # |    135,663 |    135,663 |        606 |          0 |
    fsub    $f2, $f3, $f2               # |    135,663 |    135,663 |          0 |          0 |
    load    [ext_intersection_point + 1], $f5# |    135,663 |    135,663 |      2,545 |          0 |
    fmul    $f2, $f1, $f1               # |    135,663 |    135,663 |          0 |          0 |
    load    [$i12 + 8], $f3             # |    135,663 |    135,663 |        748 |          0 |
    fsub    $f5, $f3, $f3               # |    135,663 |    135,663 |          0 |          0 |
    load    [$i12 + 6], $f6             # |    135,663 |    135,663 |        662 |          0 |
    fmul    $f3, $f4, $f4               # |    135,663 |    135,663 |          0 |          0 |
    load    [ext_intersection_point + 2], $f7# |    135,663 |    135,663 |      1,887 |          0 |
    load    [$i12 + 9], $f8             # |    135,663 |    135,663 |        941 |          0 |
    fsub    $f7, $f8, $f5               # |    135,663 |    135,663 |          0 |          0 |
    fmul    $f5, $f6, $f6               # |    135,663 |    135,663 |          0 |          0 |
    be      $i1, 0, be.22643            # |    135,663 |    135,663 |          0 |          4 |
bne.22643:
    load    [$i12 + 18], $f7
    load    [$i12 + 17], $f8
    fmul    $f3, $f7, $f7
    fmul    $f5, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc3, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i12 + 18], $f1
    load    [$i12 + 16], $f7
    fmul    $f2, $f1, $f1
    fmul    $f5, $f7, $f5
    fadd    $f1, $f5, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f4, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i12 + 17], $f1
    load    [$i12 + 16], $f4
    fmul    $f2, $f1, $f1
    fmul    $f3, $f4, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc3, $f1
    fadd    $f6, $f1, $f1
    store   $f1, [ext_nvector + 2]
    load    [ext_nvector + 0], $f1
    load    [ext_nvector + 1], $f2
    fmul    $f1, $f1, $f3
    load    [$i12 + 10], $i1
    fmul    $f2, $f2, $f2
    load    [ext_nvector + 2], $f4
    fmul    $f4, $f4, $f4
    fadd    $f3, $f2, $f2
    fadd    $f2, $f4, $f2
    fsqrt   $f2, $f2
    be      $f2, $f0, be.22644
.count dual_jmp
    b       bne.22644
be.22643:
    store   $f1, [ext_nvector + 0]      # |    135,663 |    135,663 |          0 |          0 |
    store   $f4, [ext_nvector + 1]      # |    135,663 |    135,663 |          0 |          0 |
    store   $f6, [ext_nvector + 2]      # |    135,663 |    135,663 |          0 |          0 |
    load    [ext_nvector + 0], $f1      # |    135,663 |    135,663 |      2,225 |          0 |
    fmul    $f1, $f1, $f3               # |    135,663 |    135,663 |          0 |          0 |
    load    [ext_nvector + 1], $f2      # |    135,663 |    135,663 |      1,885 |          0 |
    fmul    $f2, $f2, $f2               # |    135,663 |    135,663 |          0 |          0 |
    load    [$i12 + 10], $i1            # |    135,663 |    135,663 |        769 |          0 |
    fadd    $f3, $f2, $f2               # |    135,663 |    135,663 |          0 |          0 |
    load    [ext_nvector + 2], $f4      # |    135,663 |    135,663 |      2,191 |          0 |
    fmul    $f4, $f4, $f4               # |    135,663 |    135,663 |          0 |          0 |
    fadd    $f2, $f4, $f2               # |    135,663 |    135,663 |          0 |          0 |
    fsqrt   $f2, $f2                    # |    135,663 |    135,663 |          0 |          0 |
    bne     $f2, $f0, bne.22644         # |    135,663 |    135,663 |          0 |     27,937 |
be.22644:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
.count move_args
    mov     $i12, $i2
    store   $f1, [ext_nvector + 0]
    load    [ext_nvector + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 1]
    load    [ext_nvector + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 2]
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i9
    load    [$i9 + 0], $i1
    be      $i1, -1, be.22661
.count dual_jmp
    b       bne.22646
bne.22644:
.count move_args
    mov     $i12, $i2                   # |    135,663 |    135,663 |          0 |          0 |
    be      $i1, 0, be.22645            # |    135,663 |    135,663 |          0 |     12,333 |
bne.22645:
    finv_n  $f2, $f2                    # |     31,878 |     31,878 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,878 |     31,878 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |     31,878 |     31,878 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |     31,878 |     31,878 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,878 |     31,878 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |     31,878 |     31,878 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |     31,878 |     31,878 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     31,878 |     31,878 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |     31,878 |     31,878 |          0 |          0 |
    jal     utexture.2908, $ra1         # |     31,878 |     31,878 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |     31,878 |     31,878 |        227 |          0 |
    load    [$i9 + 0], $i1              # |     31,878 |     31,878 |        277 |          0 |
    be      $i1, -1, be.22661           # |     31,878 |     31,878 |          0 |          0 |
.count dual_jmp
    b       bne.22646                   # |     31,878 |     31,878 |          0 |          2 |
be.22645:
    finv    $f2, $f2                    # |    103,785 |    103,785 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,785 |    103,785 |          0 |          0 |
    store   $f1, [ext_nvector + 0]      # |    103,785 |    103,785 |          0 |          0 |
    load    [ext_nvector + 1], $f1      # |    103,785 |    103,785 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,785 |    103,785 |          0 |          0 |
    store   $f1, [ext_nvector + 1]      # |    103,785 |    103,785 |          0 |          0 |
    load    [ext_nvector + 2], $f1      # |    103,785 |    103,785 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    103,785 |    103,785 |          0 |          0 |
    store   $f1, [ext_nvector + 2]      # |    103,785 |    103,785 |          0 |          0 |
    jal     utexture.2908, $ra1         # |    103,785 |    103,785 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |    103,785 |    103,785 |      1,210 |          0 |
    load    [$i9 + 0], $i1              # |    103,785 |    103,785 |        691 |          0 |
    be      $i1, -1, be.22661           # |    103,785 |    103,785 |          0 |        285 |
.count dual_jmp
    b       bne.22646                   # |    103,785 |    103,785 |          0 |        822 |
be.22639:
    add     $ig2, -1, $i1               # |    114,989 |    114,989 |          0 |          0 |
    store   $f0, [ext_nvector + 0]      # |    114,989 |    114,989 |          0 |          0 |
    store   $f0, [ext_nvector + 1]      # |    114,989 |    114,989 |          0 |          0 |
.count move_args
    mov     $i12, $i2                   # |    114,989 |    114,989 |          0 |          0 |
    store   $f0, [ext_nvector + 2]      # |    114,989 |    114,989 |          0 |          0 |
    load    [$i8 + $i1], $f1            # |    114,989 |    114,989 |        738 |          0 |
    bne     $f1, $f0, bne.22640         # |    114,989 |    114,989 |          0 |          6 |
be.22640:
    store   $f0, [ext_nvector + $i1]
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i9
    load    [$i9 + 0], $i1
    be      $i1, -1, be.22661
.count dual_jmp
    b       bne.22646
bne.22640:
    ble     $f1, $f0, ble.22641         # |    114,989 |    114,989 |          0 |      3,358 |
bg.22641:
    store   $fc15, [ext_nvector + $i1]  # |     24,785 |     24,785 |          0 |          0 |
    jal     utexture.2908, $ra1         # |     24,785 |     24,785 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |     24,785 |     24,785 |        205 |          0 |
    load    [$i9 + 0], $i1              # |     24,785 |     24,785 |        213 |          0 |
    be      $i1, -1, be.22661           # |     24,785 |     24,785 |          0 |          0 |
.count dual_jmp
    b       bne.22646                   # |     24,785 |     24,785 |          0 |          2 |
ble.22641:
    store   $fc0, [ext_nvector + $i1]   # |     90,204 |     90,204 |          0 |          0 |
    jal     utexture.2908, $ra1         # |     90,204 |     90,204 |          0 |          0 |
    load    [$ig1 + 0], $i9             # |     90,204 |     90,204 |        738 |          0 |
    load    [$i9 + 0], $i1              # |     90,204 |     90,204 |        548 |          0 |
    be      $i1, -1, be.22661           # |     90,204 |     90,204 |          0 |        276 |
bne.22646:
    be      $i1, 99, bne.22651          # |    642,165 |    642,165 |          0 |        239 |
bne.22647:
    call    solver_fast.2796            # |    642,165 |    642,165 |          0 |          0 |
    be      $i1, 0, be.22660            # |    642,165 |    642,165 |          0 |        341 |
bne.22648:
    ble     $fc4, $fg0, be.22660        # |    200,877 |    200,877 |          0 |      8,627 |
bg.22649:
    load    [$i9 + 1], $i1              # |    193,925 |    193,925 |      1,518 |          0 |
    be      $i1, -1, be.22660           # |    193,925 |    193,925 |          0 |      1,322 |
bne.22650:
    li      0, $i7                      # |    193,925 |    193,925 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    193,925 |    193,925 |        976 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    193,925 |    193,925 |          0 |          0 |
    bne     $i1, 0, bne.22651           # |    193,925 |    193,925 |          0 |        650 |
be.22651:
    load    [$i9 + 2], $i1              # |    153,639 |    153,639 |      1,189 |          0 |
    be      $i1, -1, be.22660           # |    153,639 |    153,639 |          0 |     12,766 |
bne.22652:
    li      0, $i7                      # |    153,639 |    153,639 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    153,639 |    153,639 |        543 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    153,639 |    153,639 |          0 |          0 |
    bne     $i1, 0, bne.22651           # |    153,639 |    153,639 |          0 |      5,113 |
be.22653:
    li      3, $i8                      # |    143,508 |    143,508 |          0 |          0 |
    jal     shadow_check_one_or_group.2865, $ra2# |    143,508 |    143,508 |          0 |          0 |
    be      $i1, 0, be.22660            # |    143,508 |    143,508 |          0 |          2 |
bne.22651:
    load    [$i9 + 1], $i1              # |    115,260 |    115,260 |          0 |          0 |
    be      $i1, -1, be.22660           # |    115,260 |    115,260 |          0 |          1 |
bne.22656:
    li      0, $i7                      # |    115,260 |    115,260 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |    115,260 |    115,260 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |    115,260 |    115,260 |          0 |          0 |
    bne     $i1, 0, bne.22657           # |    115,260 |    115,260 |          0 |     14,243 |
be.22657:
    load    [$i9 + 2], $i1              # |     74,974 |     74,974 |          0 |          0 |
    be      $i1, -1, be.22660           # |     74,974 |     74,974 |          0 |      9,641 |
bne.22658:
    li      0, $i7                      # |     74,974 |     74,974 |          0 |          0 |
    load    [ext_and_net + $i1], $i3    # |     74,974 |     74,974 |          0 |          0 |
    jal     shadow_check_and_group.2862, $ra1# |     74,974 |     74,974 |          0 |          0 |
    bne     $i1, 0, bne.22657           # |     74,974 |     74,974 |          0 |         87 |
be.22659:
    li      3, $i8                      # |     64,843 |     64,843 |          0 |          0 |
    jal     shadow_check_one_or_group.2865, $ra2# |     64,843 |     64,843 |          0 |          0 |
    bne     $i1, 0, bne.22657           # |     64,843 |     64,843 |          0 |        165 |
be.22660:
    li      1, $i10                     # |    526,905 |    526,905 |          0 |          0 |
.count move_args
    mov     $ig1, $i11                  # |    526,905 |    526,905 |          0 |          0 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    526,905 |    526,905 |          0 |          0 |
    bne     $i1, 0, bne.22657           # |    526,905 |    526,905 |          0 |        362 |
be.22661:
    load    [ext_nvector + 0], $f1      # |    523,130 |    523,130 |      4,494 |          0 |
    load    [ext_nvector + 1], $f2      # |    523,130 |    523,130 |      3,663 |          0 |
    fmul    $f1, $fg14, $f1             # |    523,130 |    523,130 |          0 |          0 |
    load    [ext_nvector + 2], $f3      # |    523,130 |    523,130 |      5,292 |          0 |
    fmul    $f2, $fg12, $f2             # |    523,130 |    523,130 |          0 |          0 |
    fmul    $f3, $fg13, $f3             # |    523,130 |    523,130 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |    523,130 |    523,130 |          0 |          0 |
    load    [$i12 + 11], $f2            # |    523,130 |    523,130 |     22,199 |          0 |
    fadd_n  $f1, $f3, $f1               # |    523,130 |    523,130 |          0 |          0 |
    ble     $f1, $f0, ble.22662         # |    523,130 |    523,130 |          0 |      1,086 |
bg.22662:
    fmul    $f15, $f1, $f1              # |    522,420 |    522,420 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |    522,420 |    522,420 |          0 |          0 |
    fmul    $f1, $fg16, $f2             # |    522,420 |    522,420 |          0 |          0 |
    fmul    $f1, $fg11, $f3             # |    522,420 |    522,420 |          0 |          0 |
    fmul    $f1, $fg15, $f1             # |    522,420 |    522,420 |          0 |          0 |
    fadd    $fg1, $f2, $fg1             # |    522,420 |    522,420 |          0 |          0 |
    fadd    $fg2, $f3, $fg2             # |    522,420 |    522,420 |          0 |          0 |
    fadd    $fg3, $f1, $fg3             # |    522,420 |    522,420 |          0 |          0 |
    jr      $ra4                        # |    522,420 |    522,420 |          0 |          0 |
ble.22662:
    mov     $f0, $f1                    # |        710 |        710 |          0 |          0 |
    fmul    $f15, $f1, $f1              # |        710 |        710 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg16, $f2             # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg11, $f3             # |        710 |        710 |          0 |          0 |
    fmul    $f1, $fg15, $f1             # |        710 |        710 |          0 |          0 |
    fadd    $fg1, $f2, $fg1             # |        710 |        710 |          0 |          0 |
    fadd    $fg2, $f3, $fg2             # |        710 |        710 |          0 |          0 |
    fadd    $fg3, $f1, $fg3             # |        710 |        710 |          0 |          0 |
    jr      $ra4                        # |        710 |        710 |          0 |          0 |
bne.22657:
    jr      $ra4                        # |    592,990 |    592,990 |          0 |          0 |
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i15, $i16, $i17)
# $ra = $ra5
# [$i1 - $i14, $i17]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.align 2
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i17, 0, bl.22663           # |    558,060 |    558,060 |          0 |      1,251 |
bge.22663:
    load    [$i15 + $i17], $i1          # |    558,060 |    558,060 |    438,680 |          0 |
    load    [$i16 + 0], $f1             # |    558,060 |    558,060 |     16,855 |          0 |
    load    [$i16 + 1], $f2             # |    558,060 |    558,060 |     16,324 |          0 |
    load    [$i1 + 0], $f3              # |    558,060 |    558,060 |    433,148 |          0 |
    fmul    $f3, $f1, $f1               # |    558,060 |    558,060 |          0 |          0 |
    load    [$i1 + 1], $f4              # |    558,060 |    558,060 |    412,460 |          0 |
    fmul    $f4, $f2, $f2               # |    558,060 |    558,060 |          0 |          0 |
    load    [$i1 + 2], $f5              # |    558,060 |    558,060 |    461,152 |          0 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |          0 |          0 |
    load    [$i16 + 2], $f3             # |    558,060 |    558,060 |      9,285 |          0 |
    fmul    $f5, $f3, $f3               # |    558,060 |    558,060 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |    558,060 |    558,060 |          0 |          0 |
    ble     $f0, $f1, ble.22664         # |    558,060 |    558,060 |          0 |    116,776 |
bg.22664:
    add     $i17, 1, $i1                # |    176,754 |    176,754 |          0 |          0 |
    fmul    $f1, $fc2, $f15             # |    176,754 |    176,754 |          0 |          0 |
    load    [$i15 + $i1], $i8           # |    176,754 |    176,754 |    152,009 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |    176,754 |    176,754 |          0 |          0 |
    add     $i17, -2, $i17              # |    176,754 |    176,754 |          0 |          0 |
    bge     $i17, 0, bge.22667          # |    176,754 |    176,754 |          0 |      6,399 |
.count dual_jmp
    b       bl.22663                    # |      3,031 |      3,031 |          0 |        324 |
ble.22664:
    fmul    $f1, $fc1, $f15             # |    381,306 |    381,306 |          0 |          0 |
    load    [$i15 + $i17], $i8          # |    381,306 |    381,306 |        118 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |    381,306 |    381,306 |          0 |          0 |
    add     $i17, -2, $i17              # |    381,306 |    381,306 |          0 |          0 |
    bl      $i17, 0, bl.22663           # |    381,306 |    381,306 |          0 |     47,121 |
bge.22667:
    load    [$i15 + $i17], $i1          # |    539,458 |    539,458 |    442,625 |          0 |
    load    [$i16 + 0], $f1             # |    539,458 |    539,458 |     16,696 |          0 |
    load    [$i16 + 1], $f2             # |    539,458 |    539,458 |     15,454 |          0 |
    load    [$i1 + 0], $f3              # |    539,458 |    539,458 |    412,283 |          0 |
    load    [$i1 + 1], $f4              # |    539,458 |    539,458 |    395,581 |          0 |
    fmul    $f3, $f1, $f1               # |    539,458 |    539,458 |          0 |          0 |
    load    [$i1 + 2], $f5              # |    539,458 |    539,458 |    443,893 |          0 |
    fmul    $f4, $f2, $f2               # |    539,458 |    539,458 |          0 |          0 |
    load    [$i16 + 2], $f3             # |    539,458 |    539,458 |      9,503 |          0 |
    fmul    $f5, $f3, $f3               # |    539,458 |    539,458 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |    539,458 |    539,458 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |    539,458 |    539,458 |          0 |          0 |
    ble     $f0, $f1, ble.22668         # |    539,458 |    539,458 |          0 |    158,972 |
bg.22668:
    add     $i17, 1, $i1                # |    328,288 |    328,288 |          0 |          0 |
    fmul    $f1, $fc2, $f15             # |    328,288 |    328,288 |          0 |          0 |
    load    [$i15 + $i1], $i8           # |    328,288 |    328,288 |    275,564 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |    328,288 |    328,288 |          0 |          0 |
    add     $i17, -2, $i17              # |    328,288 |    328,288 |          0 |          0 |
    b       iter_trace_diffuse_rays.2929# |    328,288 |    328,288 |          0 |        528 |
ble.22668:
    fmul    $f1, $fc1, $f15             # |    211,170 |    211,170 |          0 |          0 |
    load    [$i15 + $i17], $i8          # |    211,170 |    211,170 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |    211,170 |    211,170 |          0 |          0 |
    add     $i17, -2, $i17              # |    211,170 |    211,170 |          0 |          0 |
    b       iter_trace_diffuse_rays.2929# |    211,170 |    211,170 |          0 |      3,430 |
bl.22663:
    jr      $ra5                        # |     18,602 |     18,602 |          0 |          0 |
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i18, $i19)
# $ra = $ra6
# [$i1 - $i17, $i20 - $i21]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
    add     $i18, 23, $i1               # |      1,737 |      1,737 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,737 |      1,737 |      1,266 |          0 |
    add     $i18, 29, $i2               # |      1,737 |      1,737 |          0 |          0 |
    load    [$i2 + $i19], $i16          # |      1,737 |      1,737 |      1,737 |          0 |
    add     $i18, 3, $i3                # |      1,737 |      1,737 |          0 |          0 |
    load    [$i1 + 0], $fg1             # |      1,737 |      1,737 |      1,266 |          0 |
    load    [$i1 + 1], $fg2             # |      1,737 |      1,737 |      1,267 |          0 |
    load    [$i1 + 2], $fg3             # |      1,737 |      1,737 |      1,261 |          0 |
    load    [$i3 + $i19], $i20          # |      1,737 |      1,737 |      1,737 |          0 |
    load    [$i18 + 28], $i21           # |      1,737 |      1,737 |      1,737 |          0 |
    bne     $i21, 0, bne.22669          # |      1,737 |      1,737 |          0 |        613 |
be.22669:
    be      $i21, 1, be.22671           # |        348 |        348 |          0 |          0 |
.count dual_jmp
    b       bne.22671                   # |        348 |        348 |          0 |        143 |
bne.22669:
    load    [ext_dirvecs + 0], $i15     # |      1,389 |      1,389 |      1,160 |          0 |
    load    [$i20 + 0], $fg8            # |      1,389 |      1,389 |      1,387 |          0 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i20 + 1], $fg9            # |      1,389 |      1,389 |      1,387 |          0 |
.count move_args
    mov     $i20, $i2                   # |      1,389 |      1,389 |          0 |          0 |
    load    [$i20 + 2], $fg10           # |      1,389 |      1,389 |      1,388 |          0 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      1,389 |      1,389 |      1,299 |          0 |
    load    [$i16 + 0], $f1             # |      1,389 |      1,389 |      1,388 |          0 |
    load    [$i16 + 1], $f2             # |      1,389 |      1,389 |      1,388 |          0 |
    load    [$i1 + 0], $f3              # |      1,389 |      1,389 |      1,345 |          0 |
    load    [$i1 + 1], $f4              # |      1,389 |      1,389 |      1,332 |          0 |
    fmul    $f3, $f1, $f1               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      1,389 |      1,389 |      1,347 |          0 |
    fmul    $f4, $f2, $f2               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      1,389 |      1,389 |      1,387 |          0 |
    fmul    $f5, $f3, $f3               # |      1,389 |      1,389 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,389 |      1,389 |          0 |          0 |
    ble     $f0, $f1, ble.22670         # |      1,389 |      1,389 |          0 |        104 |
bg.22670:
    load    [$i15 + 119], $i8           # |      1,300 |      1,300 |      1,219 |          0 |
    fmul    $f1, $fc2, $f15             # |      1,300 |      1,300 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,300 |      1,300 |          0 |          0 |
    li      116, $i17                   # |      1,300 |      1,300 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,300 |      1,300 |          0 |          0 |
    be      $i21, 1, be.22671           # |      1,300 |      1,300 |          0 |        509 |
.count dual_jmp
    b       bne.22671                   # |        977 |        977 |          0 |         64 |
ble.22670:
    load    [$i15 + 118], $i8           # |         89 |         89 |          0 |          0 |
    fmul    $f1, $fc1, $f15             # |         89 |         89 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |         89 |         89 |          0 |          0 |
    li      116, $i17                   # |         89 |         89 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         89 |         89 |          0 |          0 |
    bne     $i21, 1, bne.22671          # |         89 |         89 |          0 |         39 |
be.22671:
    be      $i21, 2, be.22673           # |        348 |        348 |          0 |         11 |
.count dual_jmp
    b       bne.22673                   # |        348 |        348 |          0 |         34 |
bne.22671:
    load    [ext_dirvecs + 1], $i15     # |      1,389 |      1,389 |      1,220 |          0 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i20 + 0], $fg8            # |      1,389 |      1,389 |        850 |          0 |
.count move_args
    mov     $i20, $i2                   # |      1,389 |      1,389 |          0 |          0 |
    load    [$i20 + 1], $fg9            # |      1,389 |      1,389 |        807 |          0 |
    load    [$i20 + 2], $fg10           # |      1,389 |      1,389 |        873 |          0 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      1,389 |      1,389 |      1,243 |          0 |
    load    [$i16 + 0], $f1             # |      1,389 |      1,389 |        406 |          0 |
    load    [$i16 + 1], $f2             # |      1,389 |      1,389 |        384 |          0 |
    load    [$i1 + 0], $f3              # |      1,389 |      1,389 |      1,080 |          0 |
    fmul    $f3, $f1, $f1               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i1 + 1], $f4              # |      1,389 |      1,389 |      1,061 |          0 |
    fmul    $f4, $f2, $f2               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      1,389 |      1,389 |      1,248 |          0 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      1,389 |      1,389 |        374 |          0 |
    fmul    $f5, $f3, $f3               # |      1,389 |      1,389 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,389 |      1,389 |          0 |          0 |
    ble     $f0, $f1, ble.22672         # |      1,389 |      1,389 |          0 |        128 |
bg.22672:
    load    [$i15 + 119], $i8           # |      1,293 |      1,293 |      1,179 |          0 |
    fmul    $f1, $fc2, $f15             # |      1,293 |      1,293 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,293 |      1,293 |          0 |          0 |
    li      116, $i17                   # |      1,293 |      1,293 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,293 |      1,293 |          0 |          0 |
    be      $i21, 2, be.22673           # |      1,293 |      1,293 |          0 |        568 |
.count dual_jmp
    b       bne.22673                   # |        977 |        977 |          0 |         70 |
ble.22672:
    load    [$i15 + 118], $i8           # |         96 |         96 |          0 |          0 |
    fmul    $f1, $fc1, $f15             # |         96 |         96 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |         96 |         96 |          0 |          0 |
    li      116, $i17                   # |         96 |         96 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         96 |         96 |          0 |          0 |
    bne     $i21, 2, bne.22673          # |         96 |         96 |          0 |         41 |
be.22673:
    be      $i21, 3, be.22675           # |        337 |        337 |          0 |         70 |
.count dual_jmp
    b       bne.22675                   # |        337 |        337 |          0 |        136 |
bne.22673:
    load    [ext_dirvecs + 2], $i15     # |      1,400 |      1,400 |      1,124 |          0 |
    load    [$i20 + 0], $fg8            # |      1,400 |      1,400 |        657 |          0 |
    add     $ig0, -1, $i1               # |      1,400 |      1,400 |          0 |          0 |
    load    [$i20 + 1], $fg9            # |      1,400 |      1,400 |        563 |          0 |
.count move_args
    mov     $i20, $i2                   # |      1,400 |      1,400 |          0 |          0 |
    load    [$i20 + 2], $fg10           # |      1,400 |      1,400 |        659 |          0 |
    call    setup_startp_constants.2831 # |      1,400 |      1,400 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      1,400 |      1,400 |      1,077 |          0 |
    load    [$i16 + 0], $f1             # |      1,400 |      1,400 |         59 |          0 |
    load    [$i16 + 1], $f2             # |      1,400 |      1,400 |         51 |          0 |
    load    [$i1 + 0], $f3              # |      1,400 |      1,400 |      1,059 |          0 |
    load    [$i1 + 1], $f4              # |      1,400 |      1,400 |      1,232 |          0 |
    fmul    $f3, $f1, $f1               # |      1,400 |      1,400 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      1,400 |      1,400 |      1,221 |          0 |
    fmul    $f4, $f2, $f2               # |      1,400 |      1,400 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      1,400 |      1,400 |         27 |          0 |
    fmul    $f5, $f3, $f3               # |      1,400 |      1,400 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,400 |      1,400 |          0 |          0 |
    ble     $f0, $f1, ble.22674         # |      1,400 |      1,400 |          0 |        623 |
bg.22674:
    load    [$i15 + 119], $i8           # |      1,275 |      1,275 |      1,000 |          0 |
    fmul    $f1, $fc2, $f15             # |      1,275 |      1,275 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,275 |      1,275 |          0 |          0 |
    li      116, $i17                   # |      1,275 |      1,275 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,275 |      1,275 |          0 |          0 |
    be      $i21, 3, be.22675           # |      1,275 |      1,275 |          0 |        489 |
.count dual_jmp
    b       bne.22675                   # |        949 |        949 |          0 |        102 |
ble.22674:
    load    [$i15 + 118], $i8           # |        125 |        125 |          0 |          0 |
    fmul    $f1, $fc1, $f15             # |        125 |        125 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        125 |        125 |          0 |          0 |
    li      116, $i17                   # |        125 |        125 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        125 |        125 |          0 |          0 |
    bne     $i21, 3, bne.22675          # |        125 |        125 |          0 |         54 |
be.22675:
    be      $i21, 4, be.22677           # |        352 |        352 |          0 |         20 |
.count dual_jmp
    b       bne.22677                   # |        352 |        352 |          0 |         19 |
bne.22675:
    load    [ext_dirvecs + 3], $i15     # |      1,385 |      1,385 |      1,151 |          0 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i20 + 0], $fg8            # |      1,385 |      1,385 |        622 |          0 |
.count move_args
    mov     $i20, $i2                   # |      1,385 |      1,385 |          0 |          0 |
    load    [$i20 + 1], $fg9            # |      1,385 |      1,385 |        592 |          0 |
    load    [$i20 + 2], $fg10           # |      1,385 |      1,385 |        691 |          0 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      1,385 |      1,385 |      1,132 |          0 |
    load    [$i16 + 0], $f1             # |      1,385 |      1,385 |         62 |          0 |
    load    [$i16 + 1], $f2             # |      1,385 |      1,385 |         55 |          0 |
    load    [$i1 + 0], $f3              # |      1,385 |      1,385 |      1,278 |          0 |
    fmul    $f3, $f1, $f1               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i1 + 1], $f4              # |      1,385 |      1,385 |      1,310 |          0 |
    fmul    $f4, $f2, $f2               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      1,385 |      1,385 |      1,274 |          0 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      1,385 |      1,385 |         27 |          0 |
    fmul    $f5, $f3, $f3               # |      1,385 |      1,385 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,385 |      1,385 |          0 |          0 |
    ble     $f0, $f1, ble.22676         # |      1,385 |      1,385 |          0 |        510 |
bg.22676:
    load    [$i15 + 119], $i8           # |      1,271 |      1,271 |      1,137 |          0 |
    fmul    $f1, $fc2, $f15             # |      1,271 |      1,271 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,271 |      1,271 |          0 |          0 |
    li      116, $i17                   # |      1,271 |      1,271 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,271 |      1,271 |          0 |          0 |
    be      $i21, 4, be.22677           # |      1,271 |      1,271 |          0 |        544 |
.count dual_jmp
    b       bne.22677                   # |        944 |        944 |          0 |         48 |
ble.22676:
    load    [$i15 + 118], $i8           # |        114 |        114 |          0 |          0 |
    fmul    $f1, $fc1, $f15             # |        114 |        114 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        114 |        114 |          0 |          0 |
    li      116, $i17                   # |        114 |        114 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        114 |        114 |          0 |          0 |
    be      $i21, 4, be.22677           # |        114 |        114 |          0 |         44 |
bne.22677:
    load    [ext_dirvecs + 4], $i15     # |      1,385 |      1,385 |      1,221 |          0 |
    load    [$i20 + 0], $fg8            # |      1,385 |      1,385 |        689 |          0 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i20 + 1], $fg9            # |      1,385 |      1,385 |        614 |          0 |
.count move_args
    mov     $i20, $i2                   # |      1,385 |      1,385 |          0 |          0 |
    load    [$i20 + 2], $fg10           # |      1,385 |      1,385 |        735 |          0 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      1,385 |      1,385 |      1,158 |          0 |
    load    [$i16 + 0], $f1             # |      1,385 |      1,385 |         77 |          0 |
    load    [$i16 + 1], $f2             # |      1,385 |      1,385 |         73 |          0 |
    load    [$i1 + 0], $f3              # |      1,385 |      1,385 |        644 |          0 |
    load    [$i1 + 1], $f4              # |      1,385 |      1,385 |        683 |          0 |
    fmul    $f3, $f1, $f1               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      1,385 |      1,385 |        748 |          0 |
    fmul    $f4, $f2, $f2               # |      1,385 |      1,385 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      1,385 |      1,385 |         42 |          0 |
    fmul    $f5, $f3, $f3               # |      1,385 |      1,385 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      1,385 |      1,385 |          0 |          0 |
    ble     $f0, $f1, ble.22678         # |      1,385 |      1,385 |          0 |        114 |
bg.22678:
    load    [$i15 + 119], $i8           # |      1,288 |      1,288 |        751 |          0 |
    fmul    $f1, $fc2, $f15             # |      1,288 |      1,288 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,288 |      1,288 |          0 |          0 |
    li      116, $i17                   # |      1,288 |      1,288 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,288 |      1,288 |          0 |          0 |
    add     $i18, 18, $i1               # |      1,288 |      1,288 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,288 |      1,288 |      1,288 |          0 |
    load    [$i1 + 0], $f1              # |      1,288 |      1,288 |      1,288 |          0 |
    fmul    $f1, $fg1, $f1              # |      1,288 |      1,288 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      1,288 |      1,288 |      1,288 |          0 |
    fmul    $f2, $fg2, $f2              # |      1,288 |      1,288 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,288 |      1,288 |      1,288 |          0 |
    fmul    $f3, $fg3, $f3              # |      1,288 |      1,288 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      1,288 |      1,288 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      1,288 |      1,288 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |      1,288 |      1,288 |          0 |          0 |
    jr      $ra6                        # |      1,288 |      1,288 |          0 |          0 |
ble.22678:
    load    [$i15 + 118], $i8           # |         97 |         97 |          0 |          0 |
    fmul    $f1, $fc1, $f15             # |         97 |         97 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |         97 |         97 |          0 |          0 |
    li      116, $i17                   # |         97 |         97 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         97 |         97 |          0 |          0 |
    add     $i18, 18, $i1               # |         97 |         97 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |         97 |         97 |         97 |          0 |
    load    [$i1 + 0], $f1              # |         97 |         97 |         97 |          0 |
    load    [$i1 + 1], $f2              # |         97 |         97 |         97 |          0 |
    fmul    $f1, $fg1, $f1              # |         97 |         97 |          0 |          0 |
    load    [$i1 + 2], $f3              # |         97 |         97 |         97 |          0 |
    fmul    $f2, $fg2, $f2              # |         97 |         97 |          0 |          0 |
    fmul    $f3, $fg3, $f3              # |         97 |         97 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |         97 |         97 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |         97 |         97 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |         97 |         97 |          0 |          0 |
    jr      $ra6                        # |         97 |         97 |          0 |          0 |
be.22677:
    add     $i18, 18, $i1               # |        352 |        352 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |        352 |        352 |        352 |          0 |
    load    [$i1 + 0], $f1              # |        352 |        352 |        352 |          0 |
    load    [$i1 + 1], $f2              # |        352 |        352 |        352 |          0 |
    fmul    $f1, $fg1, $f1              # |        352 |        352 |          0 |          0 |
    load    [$i1 + 2], $f3              # |        352 |        352 |        352 |          0 |
    fmul    $f2, $fg2, $f2              # |        352 |        352 |          0 |          0 |
    fmul    $f3, $fg3, $f3              # |        352 |        352 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |        352 |        352 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |        352 |        352 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |        352 |        352 |          0 |          0 |
    jr      $ra6                        # |        352 |        352 |          0 |          0 |
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i18, $i22)
# $ra = $ra7
# [$i1 - $i17, $i19 - $i23]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i22, 4, bg.22679           # |      2,430 |      2,430 |          0 |        253 |
ble.22679:
    add     $i18, 8, $i19               # |      2,430 |      2,430 |          0 |          0 |
    load    [$i19 + $i22], $i1          # |      2,430 |      2,430 |      2,400 |          0 |
    bl      $i1, 0, bg.22679            # |      2,430 |      2,430 |          0 |        215 |
bge.22680:
    add     $i18, 13, $i20              # |        143 |        143 |          0 |          0 |
    load    [$i20 + $i22], $i1          # |        143 |        143 |        143 |          0 |
    bne     $i1, 0, bne.22681           # |        143 |        143 |          0 |         22 |
be.22681:
    add     $i22, 1, $i1                # |         11 |         11 |          0 |          0 |
    bg      $i1, 4, bg.22679            # |         11 |         11 |          0 |          0 |
ble.22682:
    load    [$i19 + $i1], $i2           # |         11 |         11 |         11 |          0 |
    bl      $i2, 0, bg.22679            # |         11 |         11 |          0 |          6 |
bge.22683:
    load    [$i20 + $i1], $i2           # |          1 |          1 |          1 |          0 |
    be      $i2, 0, be.22697            # |          1 |          1 |          0 |          0 |
bne.22684:
.count move_args
    mov     $i1, $i19                   # |          1 |          1 |          0 |          0 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          1 |          1 |          0 |          0 |
    add     $i22, 2, $i22               # |          1 |          1 |          0 |          0 |
    b       do_without_neighbors.2951   # |          1 |          1 |          0 |          1 |
bne.22681:
    add     $i18, 23, $i1               # |        132 |        132 |          0 |          0 |
    add     $i18, 29, $i2               # |        132 |        132 |          0 |          0 |
    load    [$i1 + $i22], $i1           # |        132 |        132 |        106 |          0 |
    add     $i18, 3, $i3                # |        132 |        132 |          0 |          0 |
    load    [$i2 + $i22], $i16          # |        132 |        132 |        132 |          0 |
    load    [$i1 + 0], $fg1             # |        132 |        132 |        106 |          0 |
    load    [$i1 + 1], $fg2             # |        132 |        132 |        107 |          0 |
    load    [$i1 + 2], $fg3             # |        132 |        132 |        106 |          0 |
    load    [$i3 + $i22], $i21          # |        132 |        132 |        132 |          0 |
    load    [$i18 + 28], $i23           # |        132 |        132 |        132 |          0 |
    bne     $i23, 0, bne.22685          # |        132 |        132 |          0 |         49 |
be.22685:
    be      $i23, 1, be.22687           # |         25 |         25 |          0 |          0 |
.count dual_jmp
    b       bne.22687                   # |         25 |         25 |          0 |          4 |
bne.22685:
    load    [ext_dirvecs + 0], $i15     # |        107 |        107 |         87 |          0 |
    add     $ig0, -1, $i1               # |        107 |        107 |          0 |          0 |
    load    [$i21 + 0], $fg8            # |        107 |        107 |        107 |          0 |
.count move_args
    mov     $i21, $i2                   # |        107 |        107 |          0 |          0 |
    load    [$i21 + 1], $fg9            # |        107 |        107 |        107 |          0 |
    load    [$i21 + 2], $fg10           # |        107 |        107 |        107 |          0 |
    call    setup_startp_constants.2831 # |        107 |        107 |          0 |          0 |
    load    [$i15 + 118], $i1           # |        107 |        107 |         83 |          0 |
    load    [$i16 + 0], $f1             # |        107 |        107 |        107 |          0 |
    load    [$i16 + 1], $f2             # |        107 |        107 |        107 |          0 |
    load    [$i1 + 0], $f3              # |        107 |        107 |         96 |          0 |
    fmul    $f3, $f1, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 1], $f4              # |        107 |        107 |         96 |          0 |
    fmul    $f4, $f2, $f2               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 2], $f5              # |        107 |        107 |         96 |          0 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i16 + 2], $f3             # |        107 |        107 |        107 |          0 |
    fmul    $f5, $f3, $f3               # |        107 |        107 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |        107 |        107 |          0 |          0 |
    ble     $f0, $f1, ble.22686         # |        107 |        107 |          0 |          0 |
bg.22686:
    fmul    $f1, $fc2, $f15             # |        107 |        107 |          0 |          0 |
    load    [$i15 + 119], $i8           # |        107 |        107 |         83 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |          0 |          0 |
    li      116, $i17                   # |        107 |        107 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |          0 |          0 |
    be      $i23, 1, be.22687           # |        107 |        107 |          0 |         38 |
.count dual_jmp
    b       bne.22687                   # |         79 |         79 |          0 |          4 |
ble.22686:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    bne     $i23, 1, bne.22687
be.22687:
    be      $i23, 2, be.22689           # |         28 |         28 |          0 |          0 |
.count dual_jmp
    b       bne.22689                   # |         28 |         28 |          0 |          3 |
bne.22687:
    load    [ext_dirvecs + 1], $i15     # |        104 |        104 |        104 |          0 |
    load    [$i21 + 0], $fg8            # |        104 |        104 |         51 |          0 |
    add     $ig0, -1, $i1               # |        104 |        104 |          0 |          0 |
    load    [$i21 + 1], $fg9            # |        104 |        104 |         51 |          0 |
.count move_args
    mov     $i21, $i2                   # |        104 |        104 |          0 |          0 |
    load    [$i21 + 2], $fg10           # |        104 |        104 |         59 |          0 |
    call    setup_startp_constants.2831 # |        104 |        104 |          0 |          0 |
    load    [$i15 + 118], $i1           # |        104 |        104 |         62 |          0 |
    load    [$i16 + 0], $f1             # |        104 |        104 |         26 |          0 |
    load    [$i16 + 1], $f2             # |        104 |        104 |         26 |          0 |
    load    [$i1 + 0], $f3              # |        104 |        104 |         40 |          0 |
    load    [$i1 + 1], $f4              # |        104 |        104 |         49 |          0 |
    fmul    $f3, $f1, $f1               # |        104 |        104 |          0 |          0 |
    load    [$i1 + 2], $f5              # |        104 |        104 |         86 |          0 |
    fmul    $f4, $f2, $f2               # |        104 |        104 |          0 |          0 |
    load    [$i16 + 2], $f3             # |        104 |        104 |         25 |          0 |
    fmul    $f5, $f3, $f3               # |        104 |        104 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |        104 |        104 |          0 |          0 |
    ble     $f0, $f1, ble.22688         # |        104 |        104 |          0 |          0 |
bg.22688:
    fmul    $f1, $fc2, $f15             # |        104 |        104 |          0 |          0 |
    load    [$i15 + 119], $i8           # |        104 |        104 |         62 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        104 |        104 |          0 |          0 |
    li      116, $i17                   # |        104 |        104 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        104 |        104 |          0 |          0 |
    be      $i23, 2, be.22689           # |        104 |        104 |          0 |         46 |
.count dual_jmp
    b       bne.22689                   # |         79 |         79 |          0 |         10 |
ble.22688:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    bne     $i23, 2, bne.22689
be.22689:
    be      $i23, 3, be.22691           # |         25 |         25 |          0 |          6 |
.count dual_jmp
    b       bne.22691                   # |         25 |         25 |          0 |          2 |
bne.22689:
    load    [ext_dirvecs + 2], $i15     # |        107 |        107 |        104 |          0 |
    add     $ig0, -1, $i1               # |        107 |        107 |          0 |          0 |
    load    [$i21 + 0], $fg8            # |        107 |        107 |         33 |          0 |
.count move_args
    mov     $i21, $i2                   # |        107 |        107 |          0 |          0 |
    load    [$i21 + 1], $fg9            # |        107 |        107 |         31 |          0 |
    load    [$i21 + 2], $fg10           # |        107 |        107 |         36 |          0 |
    call    setup_startp_constants.2831 # |        107 |        107 |          0 |          0 |
    load    [$i15 + 118], $i1           # |        107 |        107 |         60 |          0 |
    load    [$i16 + 0], $f1             # |        107 |        107 |          2 |          0 |
    load    [$i16 + 1], $f2             # |        107 |        107 |          6 |          0 |
    load    [$i1 + 0], $f3              # |        107 |        107 |         54 |          0 |
    fmul    $f3, $f1, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 1], $f4              # |        107 |        107 |         94 |          0 |
    fmul    $f4, $f2, $f2               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 2], $f5              # |        107 |        107 |         94 |          0 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i16 + 2], $f3             # |        107 |        107 |          5 |          0 |
    fmul    $f5, $f3, $f3               # |        107 |        107 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |        107 |        107 |          0 |          0 |
    ble     $f0, $f1, ble.22690         # |        107 |        107 |          0 |          0 |
bg.22690:
    fmul    $f1, $fc2, $f15             # |        107 |        107 |          0 |          0 |
    load    [$i15 + 119], $i8           # |        107 |        107 |         71 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |          0 |          0 |
    li      116, $i17                   # |        107 |        107 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |          0 |          0 |
    be      $i23, 3, be.22691           # |        107 |        107 |          0 |         52 |
.count dual_jmp
    b       bne.22691                   # |         78 |         78 |          0 |          3 |
ble.22690:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    bne     $i23, 3, bne.22691
be.22691:
    be      $i23, 4, be.22693           # |         29 |         29 |          0 |          0 |
.count dual_jmp
    b       bne.22693                   # |         29 |         29 |          0 |          2 |
bne.22691:
    load    [ext_dirvecs + 3], $i15     # |        103 |        103 |        103 |          0 |
    load    [$i21 + 0], $fg8            # |        103 |        103 |         44 |          0 |
    add     $ig0, -1, $i1               # |        103 |        103 |          0 |          0 |
    load    [$i21 + 1], $fg9            # |        103 |        103 |         45 |          0 |
.count move_args
    mov     $i21, $i2                   # |        103 |        103 |          0 |          0 |
    load    [$i21 + 2], $fg10           # |        103 |        103 |         49 |          0 |
    call    setup_startp_constants.2831 # |        103 |        103 |          0 |          0 |
    load    [$i15 + 118], $i1           # |        103 |        103 |         95 |          0 |
    load    [$i16 + 0], $f1             # |        103 |        103 |          0 |          0 |
    load    [$i16 + 1], $f2             # |        103 |        103 |          4 |          0 |
    load    [$i1 + 0], $f3              # |        103 |        103 |        100 |          0 |
    load    [$i1 + 1], $f4              # |        103 |        103 |        101 |          0 |
    fmul    $f3, $f1, $f1               # |        103 |        103 |          0 |          0 |
    load    [$i1 + 2], $f5              # |        103 |        103 |        103 |          0 |
    fmul    $f4, $f2, $f2               # |        103 |        103 |          0 |          0 |
    load    [$i16 + 2], $f3             # |        103 |        103 |          4 |          0 |
    fmul    $f5, $f3, $f3               # |        103 |        103 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |        103 |        103 |          0 |          0 |
    ble     $f0, $f1, ble.22692         # |        103 |        103 |          0 |         61 |
bg.22692:
    fmul    $f1, $fc2, $f15             # |        103 |        103 |          0 |          0 |
    load    [$i15 + 119], $i8           # |        103 |        103 |         80 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        103 |        103 |          0 |          0 |
    li      116, $i17                   # |        103 |        103 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        103 |        103 |          0 |          0 |
    be      $i23, 4, be.22693           # |        103 |        103 |          0 |         42 |
.count dual_jmp
    b       bne.22693                   # |         78 |         78 |          0 |          2 |
ble.22692:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    bne     $i23, 4, bne.22693
be.22693:
    add     $i18, 18, $i1               # |         25 |         25 |          0 |          0 |
    load    [$i1 + $i22], $i1           # |         25 |         25 |         25 |          0 |
    add     $i22, 1, $i2                # |         25 |         25 |          0 |          0 |
    load    [$i1 + 0], $f1              # |         25 |         25 |         25 |          0 |
    load    [$i1 + 1], $f2              # |         25 |         25 |         25 |          0 |
    fmul    $f1, $fg1, $f1              # |         25 |         25 |          0 |          0 |
    load    [$i1 + 2], $f3              # |         25 |         25 |         25 |          0 |
    fmul    $f2, $fg2, $f2              # |         25 |         25 |          0 |          0 |
    fmul    $f3, $fg3, $f3              # |         25 |         25 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |         25 |         25 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |         25 |         25 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |         25 |         25 |          0 |          0 |
    ble     $i2, 4, ble.22695           # |         25 |         25 |          0 |          1 |
.count dual_jmp
    b       bg.22679
bne.22693:
    load    [ext_dirvecs + 4], $i15     # |        107 |        107 |        107 |          0 |
    add     $ig0, -1, $i1               # |        107 |        107 |          0 |          0 |
    load    [$i21 + 0], $fg8            # |        107 |        107 |         30 |          0 |
.count move_args
    mov     $i21, $i2                   # |        107 |        107 |          0 |          0 |
    load    [$i21 + 1], $fg9            # |        107 |        107 |         35 |          0 |
    load    [$i21 + 2], $fg10           # |        107 |        107 |         39 |          0 |
    call    setup_startp_constants.2831 # |        107 |        107 |          0 |          0 |
    load    [$i15 + 118], $i1           # |        107 |        107 |         89 |          0 |
    load    [$i16 + 0], $f1             # |        107 |        107 |          2 |          0 |
    load    [$i16 + 1], $f2             # |        107 |        107 |          6 |          0 |
    load    [$i1 + 0], $f3              # |        107 |        107 |         28 |          0 |
    fmul    $f3, $f1, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 1], $f4              # |        107 |        107 |         29 |          0 |
    fmul    $f4, $f2, $f2               # |        107 |        107 |          0 |          0 |
    load    [$i1 + 2], $f5              # |        107 |        107 |         35 |          0 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |          0 |          0 |
    load    [$i16 + 2], $f3             # |        107 |        107 |          5 |          0 |
    fmul    $f5, $f3, $f3               # |        107 |        107 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |        107 |        107 |          0 |          0 |
    ble     $f0, $f1, ble.22694         # |        107 |        107 |          0 |          0 |
bg.22694:
    fmul    $f1, $fc2, $f15             # |        107 |        107 |          0 |          0 |
    load    [$i15 + 119], $i8           # |        107 |        107 |         83 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |          0 |          0 |
    li      116, $i17                   # |        107 |        107 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |          0 |          0 |
    add     $i18, 18, $i1               # |        107 |        107 |          0 |          0 |
    add     $i22, 1, $i2                # |        107 |        107 |          0 |          0 |
    load    [$i1 + $i22], $i1           # |        107 |        107 |        107 |          0 |
    load    [$i1 + 0], $f1              # |        107 |        107 |        107 |          0 |
    fmul    $f1, $fg1, $f1              # |        107 |        107 |          0 |          0 |
    load    [$i1 + 1], $f2              # |        107 |        107 |        107 |          0 |
    fmul    $f2, $fg2, $f2              # |        107 |        107 |          0 |          0 |
    load    [$i1 + 2], $f3              # |        107 |        107 |        107 |          0 |
    fmul    $f3, $fg3, $f3              # |        107 |        107 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |        107 |        107 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |        107 |        107 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |        107 |        107 |          0 |          0 |
    ble     $i2, 4, ble.22695           # |        107 |        107 |          0 |          2 |
.count dual_jmp
    b       bg.22679
ble.22694:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    add     $i18, 18, $i1
    load    [$i1 + $i22], $i1
    add     $i22, 1, $i2
    load    [$i1 + 0], $f1
    load    [$i1 + 1], $f2
    fmul    $f1, $fg1, $f1
    load    [$i1 + 2], $f3
    fmul    $f2, $fg2, $f2
    fmul    $f3, $fg3, $f3
    fadd    $fg4, $f1, $fg4
    fadd    $fg5, $f2, $fg5
    fadd    $fg6, $f3, $fg6
    bg      $i2, 4, bg.22679
ble.22695:
    load    [$i19 + $i2], $i1           # |        132 |        132 |        132 |          0 |
    bl      $i1, 0, bg.22679            # |        132 |        132 |          0 |          4 |
bge.22696:
    load    [$i20 + $i2], $i1
    be      $i1, 0, be.22697
bne.22697:
.count move_args
    mov     $i2, $i19
    jal     calc_diffuse_using_1point.2942, $ra6
    add     $i22, 2, $i22
    b       do_without_neighbors.2951
be.22697:
    add     $i22, 2, $i22
    b       do_without_neighbors.2951
bg.22679:
    jr      $ra7                        # |      2,429 |      2,429 |          0 |          0 |
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i19)
# $ra = $ra7
# [$i1 - $i23]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.align 2
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i19, 4, bg.22698           # |     15,923 |     15,923 |          0 |          1 |
ble.22698:
    load    [$i4 + $i2], $i1            # |     15,923 |     15,923 |          4 |          0 |
    add     $i1, 8, $i6                 # |     15,923 |     15,923 |          0 |          0 |
    load    [$i6 + $i19], $i6           # |     15,923 |     15,923 |     14,351 |          0 |
    bl      $i6, 0, bg.22698            # |     15,923 |     15,923 |          0 |        296 |
bge.22699:
    load    [$i3 + $i2], $i7            # |      1,968 |      1,968 |          0 |          0 |
    add     $i7, 8, $i8                 # |      1,968 |      1,968 |          0 |          0 |
    load    [$i8 + $i19], $i8           # |      1,968 |      1,968 |      1,968 |          0 |
    bne     $i8, $i6, bne.22700         # |      1,968 |      1,968 |          0 |        213 |
be.22700:
    load    [$i5 + $i2], $i8            # |      1,796 |      1,796 |          0 |          0 |
    add     $i8, 8, $i8                 # |      1,796 |      1,796 |          0 |          0 |
    load    [$i8 + $i19], $i8           # |      1,796 |      1,796 |      1,708 |          0 |
    bne     $i8, $i6, bne.22700         # |      1,796 |      1,796 |          0 |        122 |
be.22701:
    add     $i2, -1, $i8                # |      1,701 |      1,701 |          0 |          0 |
    load    [$i4 + $i8], $i8            # |      1,701 |      1,701 |          0 |          0 |
    add     $i8, 8, $i8                 # |      1,701 |      1,701 |          0 |          0 |
    load    [$i8 + $i19], $i8           # |      1,701 |      1,701 |      1,183 |          0 |
    bne     $i8, $i6, bne.22700         # |      1,701 |      1,701 |          0 |        104 |
be.22702:
    add     $i2, 1, $i8                 # |      1,634 |      1,634 |          0 |          0 |
    load    [$i4 + $i8], $i8            # |      1,634 |      1,634 |          0 |          0 |
    add     $i8, 8, $i8                 # |      1,634 |      1,634 |          0 |          0 |
    load    [$i8 + $i19], $i8           # |      1,634 |      1,634 |      1,634 |          0 |
    be      $i8, $i6, be.22703          # |      1,634 |      1,634 |          0 |        194 |
bne.22700:
    bg      $i19, 4, bg.22698           # |        378 |        378 |          0 |          2 |
ble.22705:
    load    [$i4 + $i2], $i18           # |        378 |        378 |          0 |          0 |
    add     $i18, 8, $i1                # |        378 |        378 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |        378 |        378 |          0 |          0 |
    bl      $i1, 0, bg.22698            # |        378 |        378 |          0 |          0 |
bge.22706:
    add     $i18, 13, $i1               # |        378 |        378 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |        378 |        378 |        378 |          0 |
    be      $i1, 0, be.22707            # |        378 |        378 |          0 |         37 |
bne.22707:
    jal     calc_diffuse_using_1point.2942, $ra6# |        346 |        346 |          0 |          0 |
    add     $i19, 1, $i22               # |        346 |        346 |          0 |          0 |
    b       do_without_neighbors.2951   # |        346 |        346 |          0 |        248 |
be.22707:
    add     $i19, 1, $i22               # |         32 |         32 |          0 |          0 |
    b       do_without_neighbors.2951   # |         32 |         32 |          0 |         21 |
bg.22698:
    jr      $ra7                        # |     13,955 |     13,955 |          0 |          0 |
be.22703:
    add     $i1, 13, $i1                # |      1,590 |      1,590 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,590 |      1,590 |      1,590 |          0 |
    be      $i1, 0, be.22708            # |      1,590 |      1,590 |          0 |         36 |
bne.22708:
    add     $i2, -1, $i1                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i4 + $i1], $i1            # |      1,564 |      1,564 |          0 |          0 |
    add     $i7, 23, $i6                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i6 + $i19], $i6           # |      1,564 |      1,564 |      1,564 |          0 |
    load    [$i4 + $i2], $i7            # |      1,564 |      1,564 |          0 |          0 |
    add     $i1, 23, $i1                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i6 + 0], $fg1             # |      1,564 |      1,564 |      1,563 |          0 |
    load    [$i1 + $i19], $i1           # |      1,564 |      1,564 |         87 |          0 |
    load    [$i6 + 1], $fg2             # |      1,564 |      1,564 |      1,563 |          0 |
    load    [$i6 + 2], $fg3             # |      1,564 |      1,564 |      1,563 |          0 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |         87 |          0 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      1,564 |      1,564 |         98 |          0 |
    fadd    $fg2, $f2, $fg2             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,564 |      1,564 |        104 |          0 |
    fadd    $fg3, $f3, $fg3             # |      1,564 |      1,564 |          0 |          0 |
    add     $i7, 23, $i1                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,564 |      1,564 |        101 |          0 |
    add     $i2, 1, $i6                 # |      1,564 |      1,564 |          0 |          0 |
    load    [$i4 + $i6], $i6            # |      1,564 |      1,564 |         10 |          0 |
    load    [$i5 + $i2], $i7            # |      1,564 |      1,564 |         16 |          0 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |        107 |          0 |
    load    [$i1 + 1], $f2              # |      1,564 |      1,564 |        127 |          0 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,564 |      1,564 |        116 |          0 |
    add     $i6, 23, $i1                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,564 |      1,564 |      1,564 |          0 |
    fadd    $fg2, $f2, $fg2             # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg3, $f3, $fg3             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |      1,564 |          0 |
    load    [$i1 + 1], $f2              # |      1,564 |      1,564 |      1,564 |          0 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,564 |      1,564 |      1,564 |          0 |
    add     $i7, 23, $i1                # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg2, $f2, $fg2             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,564 |      1,564 |      1,518 |          0 |
    fadd    $fg3, $f3, $fg3             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i4 + $i2], $i6            # |      1,564 |      1,564 |         32 |          0 |
    add     $i19, 1, $i7                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |      1,564 |          0 |
    load    [$i1 + 1], $f2              # |      1,564 |      1,564 |      1,564 |          0 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,564 |      1,564 |      1,564 |          0 |
    add     $i6, 18, $i1                # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + $i19], $i1           # |      1,564 |      1,564 |      1,564 |          0 |
    fadd    $fg2, $f2, $fg2             # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg3, $f3, $fg3             # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |      1,564 |          0 |
    load    [$i1 + 1], $f2              # |      1,564 |      1,564 |      1,564 |          0 |
    fmul    $f1, $fg1, $f1              # |      1,564 |      1,564 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      1,564 |      1,564 |      1,564 |          0 |
    fmul    $f2, $fg2, $f2              # |      1,564 |      1,564 |          0 |          0 |
    fmul    $f3, $fg3, $f3              # |      1,564 |      1,564 |          0 |          0 |
.count move_args
    mov     $i7, $i19                   # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      1,564 |      1,564 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |      1,564 |      1,564 |          0 |          0 |
    b       try_exploit_neighbors.2967  # |      1,564 |      1,564 |          0 |          6 |
be.22708:
    add     $i19, 1, $i19               # |         26 |         26 |          0 |          0 |
    b       try_exploit_neighbors.2967  # |         26 |         26 |          0 |          2 |
.end try_exploit_neighbors

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
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
    load    [$sp + 0], $ra              # |     49,152 |     49,152 |      1,709 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |     49,152 |     49,152 |          0 |          0 |
    bg      $i1, $i4, bg.22711          # |     49,152 |     49,152 |          0 |      6,127 |
ble.22711:
    bge     $i1, 0, bge.22712           # |     33,364 |     33,364 |          0 |        607 |
bl.22712:
    li      0, $i2
    b       ext_write
bge.22712:
.count move_args
    mov     $i1, $i2                    # |     33,364 |     33,364 |          0 |          0 |
    b       ext_write                   # |     33,364 |     33,364 |          0 |      2,571 |
bg.22711:
    li      255, $i2                    # |     15,788 |     15,788 |          0 |          0 |
    b       ext_write                   # |     15,788 |     15,788 |          0 |        274 |
.end write_rgb_element

######################################################################
# write_rgb()
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
# [$ra]
######################################################################
.align 2
.begin write_rgb
write_rgb.2978:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |     16,384 |     16,384 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $fg4, $f2                   # |     16,384 |     16,384 |          0 |          0 |
    call    write_rgb_element.2976      # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $fg5, $f2                   # |     16,384 |     16,384 |          0 |          0 |
    call    write_rgb_element.2976      # |     16,384 |     16,384 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     16,384 |     16,384 |      1,613 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $fg6, $f2                   # |     16,384 |     16,384 |          0 |          0 |
    b       write_rgb_element.2976      # |     16,384 |     16,384 |          0 |          4 |
.end write_rgb

######################################################################
# pretrace_diffuse_rays($i18, $i19)
# $ra = $ra6
# [$i1 - $i17, $i19 - $i25]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.align 2
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i19, 4, bg.22715           # |     16,395 |     16,395 |          0 |        101 |
ble.22715:
    add     $i18, 8, $i20               # |     16,395 |     16,395 |          0 |          0 |
    load    [$i20 + $i19], $i1          # |     16,395 |     16,395 |     16,393 |          0 |
    bl      $i1, 0, bg.22715            # |     16,395 |     16,395 |          0 |        192 |
bge.22716:
    add     $i18, 13, $i21              # |      2,101 |      2,101 |          0 |          0 |
    load    [$i21 + $i19], $i1          # |      2,101 |      2,101 |      2,101 |          0 |
    bne     $i1, 0, bne.22717           # |      2,101 |      2,101 |          0 |         24 |
be.22717:
    add     $i19, 1, $i22               # |         67 |         67 |          0 |          0 |
    bg      $i22, 4, bg.22715           # |         67 |         67 |          0 |          0 |
ble.22718:
    load    [$i20 + $i22], $i1          # |         67 |         67 |         67 |          0 |
    bl      $i1, 0, bg.22715            # |         67 |         67 |          0 |         10 |
bge.22719:
    load    [$i21 + $i22], $i1          # |         11 |         11 |         11 |          0 |
    be      $i1, 0, be.22725            # |         11 |         11 |          0 |          2 |
bne.22720:
    add     $i18, 3, $i1                # |          9 |          9 |          0 |          0 |
    mov     $f0, $fg1                   # |          9 |          9 |          0 |          0 |
    load    [$i1 + $i22], $i2           # |          9 |          9 |          1 |          0 |
    mov     $f0, $fg2                   # |          9 |          9 |          0 |          0 |
    add     $i18, 29, $i6               # |          9 |          9 |          0 |          0 |
    mov     $f0, $fg3                   # |          9 |          9 |          0 |          0 |
    load    [$i2 + 0], $fg8             # |          9 |          9 |          9 |          0 |
    load    [$i2 + 1], $fg9             # |          9 |          9 |          9 |          0 |
    add     $ig0, -1, $i1               # |          9 |          9 |          0 |          0 |
    load    [$i2 + 2], $fg10            # |          9 |          9 |          9 |          0 |
    call    setup_startp_constants.2831 # |          9 |          9 |          0 |          0 |
    load    [$i18 + 28], $i1            # |          9 |          9 |          9 |          0 |
    load    [$i6 + $i22], $i16          # |          9 |          9 |          0 |          0 |
    load    [ext_dirvecs + $i1], $i15   # |          9 |          9 |          8 |          0 |
    load    [$i16 + 0], $f1             # |          9 |          9 |          9 |          0 |
    load    [$i16 + 1], $f2             # |          9 |          9 |          9 |          0 |
    load    [$i15 + 118], $i1           # |          9 |          9 |          9 |          0 |
    load    [$i16 + 2], $f3             # |          9 |          9 |          9 |          0 |
    load    [$i1 + 0], $f4              # |          9 |          9 |          8 |          0 |
    load    [$i1 + 1], $f5              # |          9 |          9 |          8 |          0 |
    fmul    $f4, $f1, $f1               # |          9 |          9 |          0 |          0 |
    load    [$i1 + 2], $f6              # |          9 |          9 |          8 |          0 |
    fmul    $f5, $f2, $f2               # |          9 |          9 |          0 |          0 |
    fmul    $f6, $f3, $f3               # |          9 |          9 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |          9 |          9 |          0 |          0 |
    ble     $f0, $f1, ble.22721         # |          9 |          9 |          0 |          0 |
bg.22721:
    fmul    $f1, $fc2, $f15             # |          9 |          9 |          0 |          0 |
    load    [$i15 + 119], $i8           # |          9 |          9 |          9 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |          9 |          9 |          0 |          0 |
    li      116, $i17                   # |          9 |          9 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |          9 |          9 |          0 |          0 |
    add     $i18, 23, $i1               # |          9 |          9 |          0 |          0 |
    add     $i19, 2, $i19               # |          9 |          9 |          0 |          0 |
    load    [$i1 + $i22], $i1           # |          9 |          9 |          9 |          0 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |          0 |          0 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |          0 |          0 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |          0 |          0 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |          0 |          6 |
ble.22721:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    add     $i18, 23, $i1
    add     $i19, 2, $i19
    load    [$i1 + $i22], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
bne.22717:
    add     $i18, 3, $i22               # |      2,034 |      2,034 |          0 |          0 |
    mov     $f0, $fg1                   # |      2,034 |      2,034 |          0 |          0 |
    load    [$i22 + $i19], $i2          # |      2,034 |      2,034 |        122 |          0 |
    mov     $f0, $fg2                   # |      2,034 |      2,034 |          0 |          0 |
    mov     $f0, $fg3                   # |      2,034 |      2,034 |          0 |          0 |
    add     $i18, 29, $i23              # |      2,034 |      2,034 |          0 |          0 |
    load    [$i2 + 0], $fg8             # |      2,034 |      2,034 |      2,034 |          0 |
    add     $ig0, -1, $i1               # |      2,034 |      2,034 |          0 |          0 |
    load    [$i2 + 1], $fg9             # |      2,034 |      2,034 |      2,034 |          0 |
    load    [$i2 + 2], $fg10            # |      2,034 |      2,034 |      2,034 |          0 |
    call    setup_startp_constants.2831 # |      2,034 |      2,034 |          0 |          0 |
    load    [$i18 + 28], $i1            # |      2,034 |      2,034 |      2,034 |          0 |
    load    [$i23 + $i19], $i16         # |      2,034 |      2,034 |         36 |          0 |
    load    [ext_dirvecs + $i1], $i15   # |      2,034 |      2,034 |      1,995 |          0 |
    load    [$i16 + 0], $f1             # |      2,034 |      2,034 |      2,034 |          0 |
    load    [$i16 + 1], $f2             # |      2,034 |      2,034 |      2,034 |          0 |
    load    [$i15 + 118], $i1           # |      2,034 |      2,034 |      1,797 |          0 |
    load    [$i16 + 2], $f3             # |      2,034 |      2,034 |      2,034 |          0 |
    load    [$i1 + 0], $f4              # |      2,034 |      2,034 |      1,492 |          0 |
    fmul    $f4, $f1, $f1               # |      2,034 |      2,034 |          0 |          0 |
    load    [$i1 + 1], $f5              # |      2,034 |      2,034 |      1,602 |          0 |
    fmul    $f5, $f2, $f2               # |      2,034 |      2,034 |          0 |          0 |
    load    [$i1 + 2], $f6              # |      2,034 |      2,034 |      1,742 |          0 |
    fmul    $f6, $f3, $f3               # |      2,034 |      2,034 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      2,034 |      2,034 |          0 |          0 |
    ble     $f0, $f1, ble.22722         # |      2,034 |      2,034 |          0 |        292 |
bg.22722:
    fmul    $f1, $fc2, $f15             # |      1,742 |      1,742 |          0 |          0 |
    load    [$i15 + 119], $i8           # |      1,742 |      1,742 |      1,602 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,742 |      1,742 |          0 |          0 |
    li      116, $i17                   # |      1,742 |      1,742 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,742 |      1,742 |          0 |          0 |
    add     $i18, 23, $i24              # |      1,742 |      1,742 |          0 |          0 |
    load    [$i24 + $i19], $i1          # |      1,742 |      1,742 |      1,742 |          0 |
    add     $i19, 1, $i25               # |      1,742 |      1,742 |          0 |          0 |
    store   $fg1, [$i1 + 0]             # |      1,742 |      1,742 |          0 |          0 |
    store   $fg2, [$i1 + 1]             # |      1,742 |      1,742 |          0 |          0 |
    store   $fg3, [$i1 + 2]             # |      1,742 |      1,742 |          0 |          0 |
    ble     $i25, 4, ble.22723          # |      1,742 |      1,742 |          0 |         12 |
.count dual_jmp
    b       bg.22715
ble.22722:
    fmul    $f1, $fc1, $f15             # |        292 |        292 |          0 |          0 |
    load    [$i15 + 118], $i8           # |        292 |        292 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |        292 |        292 |          0 |          0 |
    li      116, $i17                   # |        292 |        292 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        292 |        292 |          0 |          0 |
    add     $i18, 23, $i24              # |        292 |        292 |          0 |          0 |
    add     $i19, 1, $i25               # |        292 |        292 |          0 |          0 |
    load    [$i24 + $i19], $i1          # |        292 |        292 |        291 |          0 |
    store   $fg1, [$i1 + 0]             # |        292 |        292 |          0 |          0 |
    store   $fg2, [$i1 + 1]             # |        292 |        292 |          0 |          0 |
    store   $fg3, [$i1 + 2]             # |        292 |        292 |          0 |          0 |
    bg      $i25, 4, bg.22715           # |        292 |        292 |          0 |          2 |
ble.22723:
    load    [$i20 + $i25], $i1          # |      2,034 |      2,034 |      2,034 |          0 |
    bl      $i1, 0, bg.22715            # |      2,034 |      2,034 |          0 |         32 |
bge.22724:
    load    [$i21 + $i25], $i1
    be      $i1, 0, be.22725
bne.22725:
    load    [$i22 + $i25], $i2
    mov     $f0, $fg1
    mov     $f0, $fg2
    load    [$i2 + 0], $fg8
    mov     $f0, $fg3
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    add     $ig0, -1, $i1
    call    setup_startp_constants.2831
    load    [$i18 + 28], $i1
    load    [$i23 + $i25], $i16
    load    [ext_dirvecs + $i1], $i15
    load    [$i16 + 0], $f1
    load    [$i16 + 1], $f2
    load    [$i15 + 118], $i1
    load    [$i16 + 2], $f3
    load    [$i1 + 0], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 1], $f5
    fmul    $f5, $f2, $f2
    load    [$i1 + 2], $f6
    fmul    $f6, $f3, $f3
    fadd    $f1, $f2, $f1
    fadd    $f1, $f3, $f1
    ble     $f0, $f1, ble.22726
bg.22726:
    fmul    $f1, $fc2, $f15
    load    [$i15 + 119], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i24 + $i25], $i1
    add     $i19, 2, $i19
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
ble.22726:
    fmul    $f1, $fc1, $f15
    load    [$i15 + 118], $i8
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i17
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i24 + $i25], $i1
    add     $i19, 2, $i19
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    b       pretrace_diffuse_rays.2980
be.22725:
    add     $i19, 2, $i19               # |          2 |          2 |          0 |          0 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |          0 |          2 |
bg.22715:
    jr      $ra6                        # |     16,384 |     16,384 |          0 |          0 |
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i26, $i27, $i28, $f19, $f20, $f21)
# $ra = $ra7
# [$i1 - $i25, $i27 - $i28]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.align 2
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i27, 0, bl.22727           # |     16,512 |     16,512 |          0 |        470 |
bge.22727:
    load    [ext_screenx_dir + 0], $f4  # |     16,384 |     16,384 |      4,934 |          0 |
    add     $i27, -64, $i2              # |     16,384 |     16,384 |          0 |          0 |
    call    ext_float_of_int            # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f4, $f2               # |     16,384 |     16,384 |          0 |          0 |
    li      0, $i18                     # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $f0, $f18                   # |     16,384 |     16,384 |          0 |          0 |
    li      ext_ptrace_dirvec, $i16     # |     16,384 |     16,384 |          0 |          0 |
.count move_args
    mov     $fc0, $f17                  # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f2, $f19, $f2              # |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg6                   # |     16,384 |     16,384 |          0 |          0 |
    store   $f2, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg5                   # |     16,384 |     16,384 |          0 |          0 |
    store   $f20, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |          0 |          0 |
    mov     $f0, $fg4                   # |     16,384 |     16,384 |          0 |          0 |
    load    [ext_screenx_dir + 2], $f2  # |     16,384 |     16,384 |      2,733 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f1, $f21, $f1              # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 0], $f1# |     16,384 |     16,384 |      4,147 |          0 |
    load    [ext_ptrace_dirvec + 1], $f2# |     16,384 |     16,384 |      7,583 |          0 |
    fmul    $f1, $f1, $f4               # |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 2], $f3# |     16,384 |     16,384 |      4,534 |          0 |
    fmul    $f2, $f2, $f2               # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f3, $f3, $f3               # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f4, $f2, $f2               # |     16,384 |     16,384 |          0 |          0 |
    fadd    $f2, $f3, $f2               # |     16,384 |     16,384 |          0 |          0 |
    fsqrt   $f2, $f2                    # |     16,384 |     16,384 |          0 |          0 |
    be      $f2, $f0, be.22728          # |     16,384 |     16,384 |          0 |          4 |
bne.22728:
    finv    $f2, $f2                    # |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 1], $f1# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_ptrace_dirvec + 2], $f1# |     16,384 |     16,384 |          0 |          0 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |          0 |          0 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |          0 |          0 |
    load    [ext_viewpoint + 0], $fg17  # |     16,384 |     16,384 |      4,069 |          0 |
    load    [ext_viewpoint + 1], $fg18  # |     16,384 |     16,384 |      4,123 |          0 |
    load    [ext_viewpoint + 2], $fg19  # |     16,384 |     16,384 |      3,211 |          0 |
    load    [$i26 + $i27], $i19         # |     16,384 |     16,384 |     14,240 |          0 |
    jal     trace_ray.2920, $ra5        # |     16,384 |     16,384 |          0 |          0 |
    load    [$i26 + $i27], $i1          # |     16,384 |     16,384 |      2,224 |          0 |
    store   $fg4, [$i1 + 0]             # |     16,384 |     16,384 |          0 |          0 |
    store   $fg5, [$i1 + 1]             # |     16,384 |     16,384 |          0 |          0 |
    store   $fg6, [$i1 + 2]             # |     16,384 |     16,384 |          0 |          0 |
    load    [$i26 + $i27], $i1          # |     16,384 |     16,384 |          0 |          0 |
    store   $i28, [$i1 + 28]            # |     16,384 |     16,384 |          0 |          0 |
    load    [$i26 + $i27], $i18         # |     16,384 |     16,384 |          0 |          0 |
    load    [$i18 + 8], $i1             # |     16,384 |     16,384 |     15,809 |          0 |
    bge     $i1, 0, bge.22729           # |     16,384 |     16,384 |          0 |        920 |
.count dual_jmp
    b       bl.22729
be.22728:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 0]
    load    [ext_ptrace_dirvec + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 1]
    load    [ext_ptrace_dirvec + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_ptrace_dirvec + 2]
    load    [ext_viewpoint + 0], $fg17
    load    [ext_viewpoint + 1], $fg18
    load    [ext_viewpoint + 2], $fg19
    load    [$i26 + $i27], $i19
    jal     trace_ray.2920, $ra5
    load    [$i26 + $i27], $i1
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    load    [$i26 + $i27], $i1
    store   $i28, [$i1 + 28]
    load    [$i26 + $i27], $i18
    load    [$i18 + 8], $i1
    bge     $i1, 0, bge.22729
bl.22729:
    add     $i28, 1, $i1
    add     $i27, -1, $i27
    bge     $i1, 5, bge.22732
.count dual_jmp
    b       bl.22732
bge.22729:
    load    [$i18 + 13], $i1            # |     16,384 |     16,384 |     16,384 |          0 |
    bne     $i1, 0, bne.22730           # |     16,384 |     16,384 |          0 |        254 |
be.22730:
    li      1, $i19                     # |      7,301 |      7,301 |          0 |          0 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      7,301 |      7,301 |          0 |          0 |
    add     $i28, 1, $i1                # |      7,301 |      7,301 |          0 |          0 |
    add     $i27, -1, $i27              # |      7,301 |      7,301 |          0 |          0 |
    bge     $i1, 5, bge.22732           # |      7,301 |      7,301 |          0 |      2,823 |
.count dual_jmp
    b       bl.22732                    # |      5,841 |      5,841 |          0 |         27 |
bne.22730:
    load    [$i18 + 28], $i1            # |      9,083 |      9,083 |      9,083 |          0 |
    mov     $f0, $fg1                   # |      9,083 |      9,083 |          0 |          0 |
    load    [$i18 + 3], $i2             # |      9,083 |      9,083 |        550 |          0 |
    mov     $f0, $fg2                   # |      9,083 |      9,083 |          0 |          0 |
    mov     $f0, $fg3                   # |      9,083 |      9,083 |          0 |          0 |
    load    [ext_dirvecs + $i1], $i15   # |      9,083 |      9,083 |      8,847 |          0 |
    load    [$i18 + 29], $i16           # |      9,083 |      9,083 |        168 |          0 |
    add     $ig0, -1, $i1               # |      9,083 |      9,083 |          0 |          0 |
    load    [$i2 + 0], $fg8             # |      9,083 |      9,083 |      9,083 |          0 |
    load    [$i2 + 1], $fg9             # |      9,083 |      9,083 |      9,083 |          0 |
    load    [$i2 + 2], $fg10            # |      9,083 |      9,083 |      9,083 |          0 |
    call    setup_startp_constants.2831 # |      9,083 |      9,083 |          0 |          0 |
    load    [$i15 + 118], $i1           # |      9,083 |      9,083 |      8,021 |          0 |
    load    [$i16 + 0], $f1             # |      9,083 |      9,083 |      9,083 |          0 |
    load    [$i16 + 1], $f2             # |      9,083 |      9,083 |      9,083 |          0 |
    load    [$i1 + 0], $f3              # |      9,083 |      9,083 |      7,199 |          0 |
    load    [$i1 + 1], $f4              # |      9,083 |      9,083 |      7,637 |          0 |
    fmul    $f3, $f1, $f1               # |      9,083 |      9,083 |          0 |          0 |
    load    [$i1 + 2], $f5              # |      9,083 |      9,083 |      8,258 |          0 |
    fmul    $f4, $f2, $f2               # |      9,083 |      9,083 |          0 |          0 |
    load    [$i16 + 2], $f3             # |      9,083 |      9,083 |      9,083 |          0 |
    fmul    $f5, $f3, $f3               # |      9,083 |      9,083 |          0 |          0 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |          0 |          0 |
    fadd    $f1, $f3, $f1               # |      9,083 |      9,083 |          0 |          0 |
    ble     $f0, $f1, ble.22731         # |      9,083 |      9,083 |          0 |         30 |
bg.22731:
    fmul    $f1, $fc2, $f15             # |      9,069 |      9,069 |          0 |          0 |
    load    [$i15 + 119], $i8           # |      9,069 |      9,069 |      7,746 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |      9,069 |      9,069 |          0 |          0 |
    li      116, $i17                   # |      9,069 |      9,069 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      9,069 |      9,069 |          0 |          0 |
    load    [$i18 + 23], $i1            # |      9,069 |      9,069 |      9,041 |          0 |
    li      1, $i19                     # |      9,069 |      9,069 |          0 |          0 |
    store   $fg1, [$i1 + 0]             # |      9,069 |      9,069 |          0 |          0 |
    store   $fg2, [$i1 + 1]             # |      9,069 |      9,069 |          0 |          0 |
    store   $fg3, [$i1 + 2]             # |      9,069 |      9,069 |          0 |          0 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      9,069 |      9,069 |          0 |          0 |
    add     $i28, 1, $i1                # |      9,069 |      9,069 |          0 |          0 |
    add     $i27, -1, $i27              # |      9,069 |      9,069 |          0 |          0 |
    bge     $i1, 5, bge.22732           # |      9,069 |      9,069 |          0 |      3,531 |
.count dual_jmp
    b       bl.22732                    # |      7,253 |      7,253 |          0 |        314 |
ble.22731:
    fmul    $f1, $fc1, $f15             # |         14 |         14 |          0 |          0 |
    load    [$i15 + 118], $i8           # |         14 |         14 |          0 |          0 |
    jal     trace_diffuse_ray.2926, $ra4# |         14 |         14 |          0 |          0 |
    li      116, $i17                   # |         14 |         14 |          0 |          0 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         14 |         14 |          0 |          0 |
    load    [$i18 + 23], $i1            # |         14 |         14 |         14 |          0 |
    li      1, $i19                     # |         14 |         14 |          0 |          0 |
    store   $fg1, [$i1 + 0]             # |         14 |         14 |          0 |          0 |
    store   $fg2, [$i1 + 1]             # |         14 |         14 |          0 |          0 |
    store   $fg3, [$i1 + 2]             # |         14 |         14 |          0 |          0 |
    jal     pretrace_diffuse_rays.2980, $ra6# |         14 |         14 |          0 |          0 |
    add     $i28, 1, $i1                # |         14 |         14 |          0 |          0 |
    add     $i27, -1, $i27              # |         14 |         14 |          0 |          0 |
    bge     $i1, 5, bge.22732           # |         14 |         14 |          0 |          3 |
bl.22732:
.count move_args
    mov     $i1, $i28                   # |     13,107 |     13,107 |          0 |          0 |
    b       pretrace_pixels.2983        # |     13,107 |     13,107 |          0 |      1,212 |
bge.22732:
    add     $i28, -4, $i28              # |      3,277 |      3,277 |          0 |          0 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |          0 |        101 |
bl.22727:
    jr      $ra7                        # |        128 |        128 |          0 |          0 |
.end pretrace_pixels

######################################################################
# scan_pixel($i24, $i25, $i26, $i27, $i28)
# $ra = $ra8
# [$i1 - $i24]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.align 2
.begin scan_pixel
scan_pixel.2994:
    li      128, $i1                    # |     16,512 |     16,512 |          0 |          0 |
    ble     $i1, $i24, ble.22733        # |     16,512 |     16,512 |          0 |        778 |
bg.22733:
    load    [$i27 + $i24], $i1          # |     16,384 |     16,384 |      2,169 |          0 |
    li      128, $i2                    # |     16,384 |     16,384 |          0 |          0 |
    add     $i25, 1, $i3                # |     16,384 |     16,384 |          0 |          0 |
    load    [$i1 + 0], $fg4             # |     16,384 |     16,384 |     16,384 |          0 |
    load    [$i1 + 1], $fg5             # |     16,384 |     16,384 |     16,384 |          0 |
    load    [$i1 + 2], $fg6             # |     16,384 |     16,384 |     16,384 |          0 |
    ble     $i2, $i3, ble.22736         # |     16,384 |     16,384 |          0 |          5 |
bg.22734:
    ble     $i25, 0, ble.22736          # |     16,256 |     16,256 |          0 |          6 |
bg.22735:
    li      128, $i1                    # |     16,128 |     16,128 |          0 |          0 |
    add     $i24, 1, $i2                # |     16,128 |     16,128 |          0 |          0 |
    ble     $i1, $i2, ble.22736         # |     16,128 |     16,128 |          0 |        256 |
bg.22736:
    li      0, $i19                     # |     16,002 |     16,002 |          0 |          0 |
    ble     $i24, 0, bne.22742          # |     16,002 |     16,002 |          0 |          6 |
bg.22737:
    load    [$i27 + $i24], $i1          # |     15,876 |     15,876 |          0 |          0 |
    load    [$i1 + 8], $i2              # |     15,876 |     15,876 |      1,905 |          0 |
    bl      $i2, 0, bl.22741            # |     15,876 |     15,876 |          0 |          0 |
bge.22741:
    load    [$i26 + $i24], $i3          # |     15,876 |     15,876 |     14,950 |          0 |
    load    [$i3 + 8], $i4              # |     15,876 |     15,876 |     15,876 |          0 |
    bne     $i4, $i2, bne.22742         # |     15,876 |     15,876 |          0 |        908 |
be.22742:
    load    [$i28 + $i24], $i4          # |     15,253 |     15,253 |     12,389 |          0 |
    load    [$i4 + 8], $i4              # |     15,253 |     15,253 |     14,469 |          0 |
    bne     $i4, $i2, bne.22742         # |     15,253 |     15,253 |          0 |        646 |
be.22743:
    add     $i24, -1, $i4               # |     14,657 |     14,657 |          0 |          0 |
    load    [$i27 + $i4], $i4           # |     14,657 |     14,657 |        771 |          0 |
    load    [$i4 + 8], $i4              # |     14,657 |     14,657 |     10,037 |          0 |
    bne     $i4, $i2, bne.22742         # |     14,657 |     14,657 |          0 |        275 |
be.22744:
    add     $i24, 1, $i4                # |     14,497 |     14,497 |          0 |          0 |
    load    [$i27 + $i4], $i4           # |     14,497 |     14,497 |     13,544 |          0 |
    load    [$i4 + 8], $i4              # |     14,497 |     14,497 |     14,497 |          0 |
    be      $i4, $i2, be.22745          # |     14,497 |     14,497 |          0 |        332 |
bne.22742:
    load    [$i27 + $i24], $i18         # |      1,669 |      1,669 |          0 |          0 |
    load    [$i18 + 8], $i1             # |      1,669 |      1,669 |        126 |          0 |
    bge     $i1, 0, bge.22747           # |      1,669 |      1,669 |          0 |         32 |
.count dual_jmp
    b       bl.22741
be.22745:
    load    [$i1 + 13], $i1             # |     14,333 |     14,333 |     14,333 |          0 |
.count move_args
    mov     $i28, $i5                   # |     14,333 |     14,333 |          0 |          0 |
.count move_args
    mov     $i27, $i4                   # |     14,333 |     14,333 |          0 |          0 |
    li      1, $i19                     # |     14,333 |     14,333 |          0 |          0 |
    be      $i1, 0, be.22749            # |     14,333 |     14,333 |          0 |        442 |
bne.22749:
    add     $i24, -1, $i1               # |      7,693 |      7,693 |          0 |          0 |
    load    [$i3 + 23], $i2             # |      7,693 |      7,693 |      7,693 |          0 |
    load    [$i27 + $i1], $i1           # |      7,693 |      7,693 |          0 |          0 |
    load    [$i27 + $i24], $i3          # |      7,693 |      7,693 |          0 |          0 |
    load    [$i2 + 0], $fg1             # |      7,693 |      7,693 |      7,693 |          0 |
    load    [$i1 + 23], $i1             # |      7,693 |      7,693 |        375 |          0 |
    load    [$i2 + 1], $fg2             # |      7,693 |      7,693 |      7,693 |          0 |
    load    [$i2 + 2], $fg3             # |      7,693 |      7,693 |      7,693 |          0 |
    add     $i24, 1, $i2                # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |        374 |          0 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      7,693 |      7,693 |        356 |          0 |
    fadd    $fg2, $f2, $fg2             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      7,693 |      7,693 |        325 |          0 |
    fadd    $fg3, $f3, $fg3             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i3 + 23], $i1             # |      7,693 |      7,693 |        411 |          0 |
    load    [$i28 + $i24], $i3          # |      7,693 |      7,693 |          0 |          0 |
    load    [$i27 + $i2], $i2           # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |        411 |          0 |
    load    [$i1 + 1], $f2              # |      7,693 |      7,693 |        411 |          0 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      7,693 |      7,693 |        411 |          0 |
    fadd    $fg2, $f2, $fg2             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i2 + 23], $i1             # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg3, $f3, $fg3             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg2, $f2, $fg2             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg3, $f3, $fg3             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i3 + 23], $i1             # |      7,693 |      7,693 |      7,624 |          0 |
.count move_args
    mov     $i26, $i3                   # |      7,693 |      7,693 |          0 |          0 |
    load    [$i27 + $i24], $i2          # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |      7,693 |          0 |
    load    [$i1 + 1], $f2              # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg2, $f2, $fg2             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i2 + 18], $i1             # |      7,693 |      7,693 |      7,693 |          0 |
    fadd    $fg3, $f3, $fg3             # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |      7,693 |          0 |
    fmul    $f1, $fg1, $f1              # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 1], $f2              # |      7,693 |      7,693 |      7,693 |          0 |
    fmul    $f2, $fg2, $f2              # |      7,693 |      7,693 |          0 |          0 |
    load    [$i1 + 2], $f3              # |      7,693 |      7,693 |      7,693 |          0 |
    fmul    $f3, $fg3, $f3              # |      7,693 |      7,693 |          0 |          0 |
.count move_args
    mov     $i24, $i2                   # |      7,693 |      7,693 |          0 |          0 |
    fadd    $fg4, $f1, $fg4             # |      7,693 |      7,693 |          0 |          0 |
    fadd    $fg5, $f2, $fg5             # |      7,693 |      7,693 |          0 |          0 |
    fadd    $fg6, $f3, $fg6             # |      7,693 |      7,693 |          0 |          0 |
    jal     try_exploit_neighbors.2967, $ra7# |      7,693 |      7,693 |          0 |          0 |
    call    write_rgb.2978              # |      7,693 |      7,693 |          0 |          0 |
    add     $i24, 1, $i24               # |      7,693 |      7,693 |          0 |          0 |
    b       scan_pixel.2994             # |      7,693 |      7,693 |          0 |          4 |
be.22749:
.count move_args
    mov     $i24, $i2                   # |      6,640 |      6,640 |          0 |          0 |
.count move_args
    mov     $i26, $i3                   # |      6,640 |      6,640 |          0 |          0 |
    jal     try_exploit_neighbors.2967, $ra7# |      6,640 |      6,640 |          0 |          0 |
    call    write_rgb.2978              # |      6,640 |      6,640 |          0 |          0 |
    add     $i24, 1, $i24               # |      6,640 |      6,640 |          0 |          0 |
    b       scan_pixel.2994             # |      6,640 |      6,640 |          0 |        254 |
ble.22736:
    load    [$i27 + $i24], $i18         # |        382 |        382 |          0 |          0 |
    li      0, $i19                     # |        382 |        382 |          0 |          0 |
    load    [$i18 + 8], $i1             # |        382 |        382 |        268 |          0 |
    bl      $i1, 0, bl.22741            # |        382 |        382 |          0 |          0 |
bge.22747:
    load    [$i18 + 13], $i1            # |      2,051 |      2,051 |      2,051 |          0 |
    be      $i1, 0, be.22748            # |      2,051 |      2,051 |          0 |        799 |
bne.22748:
    jal     calc_diffuse_using_1point.2942, $ra6# |      1,390 |      1,390 |          0 |          0 |
    li      1, $i22                     # |      1,390 |      1,390 |          0 |          0 |
    jal     do_without_neighbors.2951, $ra7# |      1,390 |      1,390 |          0 |          0 |
    call    write_rgb.2978              # |      1,390 |      1,390 |          0 |          0 |
    add     $i24, 1, $i24               # |      1,390 |      1,390 |          0 |          0 |
    b       scan_pixel.2994             # |      1,390 |      1,390 |          0 |          4 |
be.22748:
    li      1, $i22                     # |        661 |        661 |          0 |          0 |
    jal     do_without_neighbors.2951, $ra7# |        661 |        661 |          0 |          0 |
    call    write_rgb.2978              # |        661 |        661 |          0 |          0 |
    add     $i24, 1, $i24               # |        661 |        661 |          0 |          0 |
    b       scan_pixel.2994             # |        661 |        661 |          0 |          0 |
bl.22741:
    call    write_rgb.2978
    add     $i24, 1, $i24
    b       scan_pixel.2994
ble.22733:
    jr      $ra8                        # |        128 |        128 |          0 |          0 |
.end scan_pixel

######################################################################
# scan_line($i29, $i30, $i31, $i32, $i33)
# $ra = $ra9
# [$i1 - $i33]
# [$f1 - $f21]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.align 2
.begin scan_line
scan_line.3000:
    li      128, $i1                    # |        129 |        129 |          0 |          0 |
    ble     $i1, $i29, ble.22750        # |        129 |        129 |          0 |         77 |
bg.22750:
    bge     $i29, 127, bge.22751        # |        128 |        128 |          0 |         47 |
bl.22751:
    add     $i29, -63, $i2              # |        127 |        127 |          0 |          0 |
    call    ext_float_of_int            # |        127 |        127 |          0 |          0 |
    load    [ext_screeny_dir + 0], $f2  # |        127 |        127 |        125 |          0 |
    load    [ext_screeny_dir + 1], $f3  # |        127 |        127 |        125 |          0 |
    fmul    $f1, $f2, $f2               # |        127 |        127 |          0 |          0 |
    load    [ext_screeny_dir + 2], $f4  # |        127 |        127 |        125 |          0 |
    fmul    $f1, $f3, $f3               # |        127 |        127 |          0 |          0 |
    fmul    $f1, $f4, $f1               # |        127 |        127 |          0 |          0 |
    load    [ext_screenz_dir + 2], $f4  # |        127 |        127 |        125 |          0 |
    li      127, $i27                   # |        127 |        127 |          0 |          0 |
    fadd    $f2, $fg20, $f19            # |        127 |        127 |          0 |          0 |
    fadd    $f3, $fg21, $f20            # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i32, $i26                  # |        127 |        127 |          0 |          0 |
    fadd    $f1, $f4, $f21              # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i33, $i28                  # |        127 |        127 |          0 |          0 |
    jal     pretrace_pixels.2983, $ra7  # |        127 |        127 |          0 |          0 |
    li      0, $i24                     # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i29, $i25                  # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i30, $i26                  # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i31, $i27                  # |        127 |        127 |          0 |          0 |
.count move_args
    mov     $i32, $i28                  # |        127 |        127 |          0 |          0 |
    jal     scan_pixel.2994, $ra8       # |        127 |        127 |          0 |          0 |
    add     $i33, 2, $i1                # |        127 |        127 |          0 |          0 |
    add     $i29, 1, $i29               # |        127 |        127 |          0 |          0 |
    bge     $i1, 5, bge.22752           # |        127 |        127 |          0 |         63 |
.count dual_jmp
    b       bl.22752                    # |         76 |         76 |          0 |          4 |
bge.22751:
    li      0, $i24                     # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i29, $i25                  # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i30, $i26                  # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i31, $i27                  # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i32, $i28                  # |          1 |          1 |          0 |          0 |
    jal     scan_pixel.2994, $ra8       # |          1 |          1 |          0 |          0 |
    add     $i33, 2, $i1                # |          1 |          1 |          0 |          0 |
    add     $i29, 1, $i29               # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22752           # |          1 |          1 |          0 |          0 |
bl.22752:
.count move_args
    mov     $i30, $tmp                  # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $i1, $i33                   # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $i31, $i30                  # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $i32, $i31                  # |         77 |         77 |          0 |          0 |
.count move_args
    mov     $tmp, $i32                  # |         77 |         77 |          0 |          0 |
    b       scan_line.3000              # |         77 |         77 |          0 |          6 |
bge.22752:
.count move_args
    mov     $i30, $tmp                  # |         51 |         51 |          0 |          0 |
    add     $i33, -3, $i33              # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $i31, $i30                  # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $i32, $i31                  # |         51 |         51 |          0 |          0 |
.count move_args
    mov     $tmp, $i32                  # |         51 |         51 |          0 |          0 |
    b       scan_line.3000              # |         51 |         51 |          0 |          2 |
ble.22750:
    jr      $ra9                        # |          1 |          1 |          0 |          0 |
.end scan_line

######################################################################
# $i1 = create_float5x3array()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
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
    load    [$i5 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 1]              # |        384 |        384 |          0 |          0 |
    load    [$i5 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 2]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 3]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 4]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 5]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 3], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 6]              # |        384 |        384 |          0 |          0 |
    load    [$i6 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 7]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 8]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 9]              # |        384 |        384 |          0 |          0 |
    load    [$i7 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 10]             # |        384 |        384 |          0 |          0 |
    load    [$i7 + 3], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 11]             # |        384 |        384 |          0 |          0 |
    load    [$i7 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 12]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 13]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 14]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 15]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 3], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 16]             # |        384 |        384 |          0 |          0 |
    load    [$i8 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 17]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 18]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 19]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 2], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 20]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 3], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 21]             # |        384 |        384 |          0 |          0 |
    load    [$i9 + 4], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 22]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 0], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 23]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 1], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 24]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 2], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 25]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 3], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 26]             # |        384 |        384 |          0 |          0 |
    load    [$i10 + 4], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 27]             # |        384 |        384 |          0 |          0 |
    load    [$i11 + 0], $i2             # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 28]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 0], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 29]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 1], $i2              # |        384 |        384 |        384 |          0 |
    store   $i2, [$i3 + 30]             # |        384 |        384 |          0 |          0 |
    load    [$i1 + 2], $i2              # |        384 |        384 |        384 |          0 |
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
# [$ra - $ra2]
######################################################################
.align 2
.begin init_line_elements
init_line_elements.3010:
    bge     $i13, 0, bge.22753          # |        384 |        384 |          0 |          8 |
bl.22753:
    mov     $i12, $i1                   # |          3 |          3 |          0 |          0 |
    jr      $ra3                        # |          3 |          3 |          0 |          0 |
bge.22753:
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
    b       init_line_elements.3010     # |          3 |          3 |          0 |          1 |
.end create_pixelline

######################################################################
# calc_dirvec($i2, $f1, $f2, $f8, $f9, $i3, $i4)
# $ra = $ra1
# [$i1 - $i7]
# [$f1 - $f7, $f10 - $f13]
# []
# []
# [$ra]
######################################################################
.align 2
.begin calc_dirvec
calc_dirvec.3020:
    bge     $i2, 5, bge.22754           # |        600 |        600 |          0 |        198 |
bl.22754:
    fmul    $f2, $f2, $f1               # |        500 |        500 |          0 |          0 |
    fadd    $f1, $fc6, $f1              # |        500 |        500 |          0 |          0 |
    fsqrt   $f1, $f10                   # |        500 |        500 |          0 |          0 |
    finv    $f10, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_atan                    # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f8, $f11              # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f11, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_sin                     # |        500 |        500 |          0 |          0 |
.count move_ret
    mov     $f1, $f12                   # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f11, $f2                   # |        500 |        500 |          0 |          0 |
    call    ext_cos                     # |        500 |        500 |          0 |          0 |
    finv    $f1, $f1                    # |        500 |        500 |          0 |          0 |
    fmul    $f12, $f1, $f1              # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f10, $f10             # |        500 |        500 |          0 |          0 |
    fmul    $f10, $f10, $f1             # |        500 |        500 |          0 |          0 |
    fadd    $f1, $fc6, $f1              # |        500 |        500 |          0 |          0 |
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
    add     $i2, 1, $i2                 # |        500 |        500 |          0 |          0 |
    fmul    $f13, $f1, $f1              # |        500 |        500 |          0 |          0 |
    fmul    $f1, $f11, $f2              # |        500 |        500 |          0 |          0 |
.count move_args
    mov     $f10, $f1                   # |        500 |        500 |          0 |          0 |
    b       calc_dirvec.3020            # |        500 |        500 |          0 |          4 |
bge.22754:
    load    [ext_dirvecs + $i3], $i1    # |        100 |        100 |          2 |          0 |
    fmul    $f1, $f1, $f3               # |        100 |        100 |          0 |          0 |
    fmul    $f2, $f2, $f4               # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i4], $i2            # |        100 |        100 |        100 |          0 |
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
    load    [$i1 + $i3], $i2            # |        100 |        100 |        100 |          0 |
    fneg    $f1, $f6                    # |        100 |        100 |          0 |          0 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i5], $i2            # |        100 |        100 |        100 |          0 |
    store   $f3, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f6, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i6], $i2            # |        100 |        100 |        100 |          0 |
    store   $f6, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f5, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i7], $i2            # |        100 |        100 |        100 |          0 |
    store   $f6, [$i2 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f4, [$i2 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f2, [$i2 + 2]              # |        100 |        100 |          0 |          0 |
    load    [$i1 + $i4], $i1            # |        100 |        100 |        100 |          0 |
    store   $f4, [$i1 + 0]              # |        100 |        100 |          0 |          0 |
    store   $f1, [$i1 + 1]              # |        100 |        100 |          0 |          0 |
    store   $f2, [$i1 + 2]              # |        100 |        100 |          0 |          0 |
    jr      $ra1                        # |        100 |        100 |          0 |          0 |
.end calc_dirvec

######################################################################
# calc_dirvecs($i8, $f9, $i9, $i10)
# $ra = $ra2
# [$i1 - $i9, $i11]
# [$f1 - $f8, $f10 - $f14]
# []
# []
# [$ra - $ra1]
######################################################################
.align 2
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i8, 0, bl.22755            # |         11 |         11 |          0 |          0 |
bge.22755:
    li      0, $i1                      # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |         11 |         11 |          0 |          0 |
    call    ext_float_of_int            # |         11 |         11 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |         11 |         11 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |         11 |         11 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |          0 |          0 |
    add     $i10, 2, $i11               # |         11 |         11 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |         11 |         11 |          0 |          0 |
    li      0, $i2                      # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |         11 |         11 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |         11 |         11 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |         11 |         11 |          0 |          0 |
    add     $i8, -1, $i8                # |         11 |         11 |          0 |          0 |
    bl      $i8, 0, bl.22755            # |         11 |         11 |          0 |          2 |
bge.22756:
    add     $i9, 1, $i1                 # |         10 |         10 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |         10 |         10 |          0 |          0 |
    bge     $i1, 5, bge.22757           # |         10 |         10 |          0 |          3 |
bl.22757:
    mov     $i1, $i9                    # |          8 |          8 |          0 |          0 |
    li      0, $i1                      # |          8 |          8 |          0 |          0 |
    call    ext_float_of_int            # |          8 |          8 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          8 |          8 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |          8 |          8 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |          0 |          0 |
    li      0, $i2                      # |          8 |          8 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |          8 |          8 |          0 |          0 |
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
    bge     $i8, 0, bge.22758           # |          8 |          8 |          0 |          3 |
.count dual_jmp
    b       bl.22755                    # |          4 |          4 |          0 |          3 |
bge.22757:
    add     $i9, -4, $i9                # |          2 |          2 |          0 |          0 |
    li      0, $i1                      # |          2 |          2 |          0 |          0 |
    call    ext_float_of_int            # |          2 |          2 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          2 |          2 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          2 |          2 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |          2 |          2 |          0 |          0 |
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
    bl      $i8, 0, bl.22755            # |          2 |          2 |          0 |          1 |
bge.22758:
    li      0, $i1                      # |          5 |          5 |          0 |          0 |
    add     $i9, 1, $i2                 # |          5 |          5 |          0 |          0 |
    bge     $i2, 5, bge.22759           # |          5 |          5 |          0 |          3 |
bl.22759:
    mov     $i2, $i9                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |          4 |          4 |          0 |          0 |
    call    ext_float_of_int            # |          4 |          4 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          4 |          4 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
    li      0, $i2                      # |          4 |          4 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
    add     $i8, -1, $i8                # |          4 |          4 |          0 |          0 |
    bge     $i8, 0, bge.22760           # |          4 |          4 |          0 |          2 |
.count dual_jmp
    b       bl.22755                    # |          3 |          3 |          0 |          3 |
bge.22759:
    add     $i9, -4, $i9                # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |          1 |          1 |          0 |          0 |
    call    ext_float_of_int            # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    add     $i8, -1, $i8                # |          1 |          1 |          0 |          0 |
    bl      $i8, 0, bl.22755            # |          1 |          1 |          0 |          1 |
bge.22760:
    add     $i9, 1, $i1                 # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i2                    # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22761           # |          1 |          1 |          0 |          0 |
bl.22761:
    mov     $i1, $i9                    # |          1 |          1 |          0 |          0 |
    li      0, $i1                      # |          1 |          1 |          0 |          0 |
    call    ext_float_of_int            # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc12, $f14            # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |          0 |          0 |
    fsub    $f14, $fc8, $f8             # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
    fadd    $f14, $fc6, $f8             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    add     $i9, 1, $i1                 # |          1 |          1 |          0 |          0 |
    add     $i8, -1, $i8                # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22762           # |          1 |          1 |          0 |          0 |
.count dual_jmp
    b       bl.22762                    # |          1 |          1 |          0 |          1 |
bge.22761:
    add     $i9, -4, $i9
    li      0, $i1
    call    ext_float_of_int
    fmul    $f1, $fc12, $f14
.count move_args
    mov     $i1, $i2
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i10, $i4
    fsub    $f14, $fc8, $f8
    jal     calc_dirvec.3020, $ra1
    li      0, $i2
    fadd    $f14, $fc6, $f8
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $i9, $i3
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $i11, $i4
    jal     calc_dirvec.3020, $ra1
    add     $i9, 1, $i1
    add     $i8, -1, $i8
    bge     $i1, 5, bge.22762
bl.22762:
.count move_args
    mov     $i1, $i9                    # |          1 |          1 |          0 |          0 |
    b       calc_dirvecs.3028           # |          1 |          1 |          0 |          1 |
bge.22762:
    add     $i9, -4, $i9
    b       calc_dirvecs.3028
bl.22755:
    jr      $ra2                        # |         10 |         10 |          0 |          0 |
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i12, $i13, $i14)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f17]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i12, 0, bl.22763           # |          5 |          5 |          0 |          0 |
bge.22763:
    li      0, $i1                      # |          5 |          5 |          0 |          0 |
.count load_float
    load    [f.22077], $f15             # |          5 |          5 |          1 |          0 |
.count move_args
    mov     $i12, $i2                   # |          5 |          5 |          0 |          0 |
    call    ext_float_of_int            # |          5 |          5 |          0 |          0 |
    fmul    $f1, $fc12, $f1             # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f15, $f8                   # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          5 |          5 |          0 |          0 |
    fsub    $f1, $fc8, $f9              # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i14, $i4                   # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |          0 |          0 |
    add     $i14, 2, $i8                # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |          0 |          0 |
    li      0, $i2                      # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $fc8, $f8                   # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          5 |          5 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |          0 |          0 |
.count load_float
    load    [f.22078], $f16             # |          5 |          5 |          1 |          0 |
    li      0, $i2                      # |          5 |          5 |          0 |          0 |
    add     $i13, 1, $i1                # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i14, $i4                   # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $f16, $f8                   # |          5 |          5 |          0 |          0 |
    bge     $i1, 5, bge.22764           # |          5 |          5 |          0 |          1 |
bl.22764:
    mov     $i1, $i9                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
.count load_float
    load    [f.22079], $f17             # |          4 |          4 |          1 |          0 |
    li      0, $i2                      # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f17, $f8                   # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
    add     $i9, 1, $i1                 # |          4 |          4 |          0 |          0 |
    bge     $i1, 5, bge.22765           # |          4 |          4 |          0 |          1 |
.count dual_jmp
    b       bl.22765                    # |          3 |          3 |          0 |          3 |
bge.22764:
    add     $i13, -4, $i9               # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.22079], $f17             # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f17, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    add     $i9, 1, $i1                 # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22765           # |          1 |          1 |          0 |          0 |
bl.22765:
    mov     $i1, $i9                    # |          4 |          4 |          0 |          0 |
    li      0, $i2                      # |          4 |          4 |          0 |          0 |
.count load_float
    load    [f.22080], $f8              # |          4 |          4 |          1 |          0 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i14, $i4                   # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |          0 |          0 |
    li      0, $i2                      # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $fc3, $f8                   # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          4 |          4 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |          0 |          0 |
    li      1, $i8                      # |          4 |          4 |          0 |          0 |
    add     $i9, 1, $i1                 # |          4 |          4 |          0 |          0 |
    bge     $i1, 5, bge.22766           # |          4 |          4 |          0 |          1 |
.count dual_jmp
    b       bl.22766                    # |          3 |          3 |          0 |          3 |
bge.22765:
    add     $i9, -4, $i9                # |          1 |          1 |          0 |          0 |
.count load_float
    load    [f.22080], $f8              # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i14, $i4                   # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $fc3, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    li      1, $i8                      # |          1 |          1 |          0 |          0 |
    add     $i9, 1, $i1                 # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22766           # |          1 |          1 |          0 |          0 |
bl.22766:
    mov     $i1, $i9                    # |          4 |          4 |          0 |          0 |
.count move_args
    mov     $i14, $i10                  # |          4 |          4 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          4 |          4 |          0 |          0 |
    add     $i12, -1, $i12              # |          4 |          4 |          0 |          0 |
    bge     $i12, 0, bge.22767          # |          4 |          4 |          0 |          4 |
.count dual_jmp
    b       bl.22763                    # |          1 |          1 |          0 |          1 |
bge.22766:
    add     $i9, -4, $i9                # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i14, $i10                  # |          1 |          1 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |          0 |          0 |
    add     $i12, -1, $i12              # |          1 |          1 |          0 |          0 |
    bl      $i12, 0, bl.22763           # |          1 |          1 |          0 |          0 |
bge.22767:
    li      0, $i1                      # |          4 |          4 |          0 |          0 |
    add     $i13, 2, $i2                # |          4 |          4 |          0 |          0 |
    add     $i14, 4, $i10               # |          4 |          4 |          0 |          0 |
    bge     $i2, 5, bge.22768           # |          4 |          4 |          0 |          1 |
bl.22768:
    mov     $i2, $i13                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i12, $i2                   # |          3 |          3 |          0 |          0 |
    call    ext_float_of_int            # |          3 |          3 |          0 |          0 |
    fmul    $f1, $fc12, $f1             # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f15, $f8                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          3 |          3 |          0 |          0 |
    fsub    $f1, $fc8, $f9              # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |          0 |          0 |
    add     $i14, 6, $i8                # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |          0 |          0 |
    li      0, $i2                      # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $fc8, $f8                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          3 |          3 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |          0 |          0 |
    add     $i13, 1, $i1                # |          3 |          3 |          0 |          0 |
    bge     $i1, 5, bge.22769           # |          3 |          3 |          0 |          1 |
.count dual_jmp
    b       bl.22769                    # |          2 |          2 |          0 |          2 |
bge.22768:
    add     $i13, -3, $i13              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i12, $i2                   # |          1 |          1 |          0 |          0 |
    call    ext_float_of_int            # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc12, $f1             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i1, $i2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f15, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          1 |          1 |          0 |          0 |
    fsub    $f1, $fc8, $f9              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    add     $i14, 6, $i8                # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $fc8, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i13, $i3                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    add     $i13, 1, $i1                # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22769           # |          1 |          1 |          0 |          0 |
bl.22769:
    mov     $i1, $i9                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |          0 |          0 |
    li      0, $i2                      # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f16, $f8                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          3 |          3 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |          0 |          0 |
    li      0, $i2                      # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $f17, $f8                   # |          3 |          3 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          3 |          3 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |          0 |          0 |
    li      2, $i8                      # |          3 |          3 |          0 |          0 |
    add     $i9, 1, $i1                 # |          3 |          3 |          0 |          0 |
    bge     $i1, 5, bge.22770           # |          3 |          3 |          0 |          1 |
.count dual_jmp
    b       bl.22770                    # |          2 |          2 |          0 |          2 |
bge.22769:
    add     $i13, -4, $i9               # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f16, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i10, $i4                   # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |          0 |          0 |
    li      0, $i2                      # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f17, $f8                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i9, $i3                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |          0 |          0 |
    li      2, $i8                      # |          1 |          1 |          0 |          0 |
    add     $i9, 1, $i1                 # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22770           # |          1 |          1 |          0 |          0 |
bl.22770:
    mov     $i1, $i9                    # |          3 |          3 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          3 |          3 |          0 |          0 |
    add     $i13, 2, $i1                # |          3 |          3 |          0 |          0 |
    add     $i12, -1, $i12              # |          3 |          3 |          0 |          0 |
    bge     $i1, 5, bge.22771           # |          3 |          3 |          0 |          1 |
.count dual_jmp
    b       bl.22771                    # |          2 |          2 |          0 |          2 |
bge.22770:
    add     $i9, -4, $i9                # |          1 |          1 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |          0 |          0 |
    add     $i13, 2, $i1                # |          1 |          1 |          0 |          0 |
    add     $i12, -1, $i12              # |          1 |          1 |          0 |          0 |
    bge     $i1, 5, bge.22771           # |          1 |          1 |          0 |          1 |
bl.22771:
    add     $i14, 8, $i14               # |          2 |          2 |          0 |          0 |
.count move_args
    mov     $i1, $i13                   # |          2 |          2 |          0 |          0 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |          0 |          2 |
bge.22771:
    add     $i13, -3, $i13              # |          2 |          2 |          0 |          0 |
    add     $i14, 8, $i14               # |          2 |          2 |          0 |          0 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |          0 |          2 |
bl.22763:
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
.end calc_dirvec_rows

######################################################################
# $i1 = create_dirvec()
# $ra = $ra1
# [$i1 - $i4]
# [$f2]
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
    load    [$i3 + 1], $i2              # |        601 |        601 |        601 |          0 |
    store   $i2, [$i4 + 1]              # |        601 |        601 |          0 |          0 |
    load    [$i3 + 2], $i2              # |        601 |        601 |        601 |          0 |
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
# [$ra - $ra1]
######################################################################
.align 2
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bge     $i6, 0, bge.22772           # |        600 |        600 |          0 |         13 |
bl.22772:
    jr      $ra2                        # |          5 |          5 |          0 |          0 |
bge.22772:
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
# [$ra - $ra2]
######################################################################
.align 2
.begin create_dirvecs
create_dirvecs.3042:
    bge     $i7, 0, bge.22773           # |          6 |          6 |          0 |          4 |
bl.22773:
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
bge.22773:
    jal     create_dirvec.3037, $ra1    # |          5 |          5 |          0 |          0 |
    li      120, $i2                    # |          5 |          5 |          0 |          0 |
.count move_args
    mov     $i1, $i3                    # |          5 |          5 |          0 |          0 |
    call    ext_create_array_int        # |          5 |          5 |          0 |          0 |
    store   $i1, [ext_dirvecs + $i7]    # |          5 |          5 |          0 |          0 |
    li      118, $i6                    # |          5 |          5 |          0 |          0 |
    load    [ext_dirvecs + $i7], $i5    # |          5 |          5 |          5 |          0 |
    jal     create_dirvec_elements.3039, $ra2# |          5 |          5 |          0 |          0 |
    add     $i7, -1, $i7                # |          5 |          5 |          0 |          0 |
    b       create_dirvecs.3042         # |          5 |          5 |          0 |          2 |
.end create_dirvecs

######################################################################
# init_dirvec_constants($i8, $i9)
# $ra = $ra3
# [$i1 - $i7, $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bge     $i9, 0, bge.22774           # |        605 |        605 |          0 |         20 |
bl.22774:
    jr      $ra3                        # |          5 |          5 |          0 |          0 |
bge.22774:
    load    [$i8 + $i9], $i4            # |        600 |        600 |         40 |          0 |
    jal     setup_dirvec_constants.2829, $ra2# |        600 |        600 |          0 |          0 |
    add     $i9, -1, $i9                # |        600 |        600 |          0 |          0 |
    b       init_dirvec_constants.3044  # |        600 |        600 |          0 |         12 |
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i10)
# $ra = $ra4
# [$i1 - $i10]
# [$f1 - $f8]
# []
# []
# [$ra - $ra3]
######################################################################
.align 2
.begin init_vecset_constants
init_vecset_constants.3047:
    bge     $i10, 0, bge.22775          # |          6 |          6 |          0 |          4 |
bl.22775:
    jr      $ra4                        # |          1 |          1 |          0 |          0 |
bge.22775:
    load    [ext_dirvecs + $i10], $i8   # |          5 |          5 |          1 |          0 |
    li      119, $i9                    # |          5 |          5 |          0 |          0 |
    jal     init_dirvec_constants.3044, $ra3# |          5 |          5 |          0 |          0 |
    add     $i10, -1, $i10              # |          5 |          5 |          0 |          0 |
    b       init_vecset_constants.3047  # |          5 |          5 |          0 |          2 |
.end init_vecset_constants

######################################################################
# add_reflection($i8, $i9, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i7]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.align 2
.begin add_reflection
add_reflection.3051:
    jal     create_dirvec.3037, $ra1    # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i4                    # |          1 |          1 |          0 |          0 |
    store   $f1, [$i4 + 0]              # |          1 |          1 |          0 |          0 |
    store   $f3, [$i4 + 1]              # |          1 |          1 |          0 |          0 |
    store   $f4, [$i4 + 2]              # |          1 |          1 |          0 |          0 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |          0 |          0 |
    mov     $hp, $i1                    # |          1 |          1 |          0 |          0 |
    store   $i9, [$i1 + 0]              # |          1 |          1 |          0 |          0 |
    load    [$i4 + 0], $i2              # |          1 |          1 |          0 |          0 |
    add     $hp, 6, $hp                 # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 1]              # |          1 |          1 |          0 |          0 |
    load    [$i4 + 1], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 2]              # |          1 |          1 |          0 |          0 |
    load    [$i4 + 2], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 3]              # |          1 |          1 |          0 |          0 |
    load    [$i4 + 3], $i2              # |          1 |          1 |          0 |          0 |
    store   $i2, [$i1 + 4]              # |          1 |          1 |          0 |          0 |
    store   $f9, [$i1 + 5]              # |          1 |          1 |          0 |          0 |
    store   $i1, [ext_reflections + $i8]# |          1 |          1 |          0 |          0 |
    jr      $ra3                        # |          1 |          1 |          0 |          0 |
.end add_reflection

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i33]
# [$f1 - $f21]
# [$ig0 - $ig4]
# [$fg0 - $fg21]
# [$ra - $ra9]
######################################################################
.align 2
.begin main
ext_main:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |          1 |          1 |          0 |          0 |
.count stack_move
    add     $sp, -1, $sp                # |          1 |          1 |          0 |          0 |
    load    [ext_solver_dist + 0], $fg0 # |          1 |          1 |          1 |          0 |
    load    [ext_diffuse_ray + 0], $fg1 # |          1 |          1 |          1 |          0 |
    load    [ext_diffuse_ray + 1], $fg2 # |          1 |          1 |          1 |          0 |
    load    [ext_diffuse_ray + 2], $fg3 # |          1 |          1 |          1 |          0 |
    load    [ext_rgb + 0], $fg4         # |          1 |          1 |          1 |          0 |
    load    [ext_rgb + 1], $fg5         # |          1 |          1 |          1 |          0 |
    load    [ext_rgb + 2], $fg6         # |          1 |          1 |          1 |          0 |
    load    [ext_n_objects + 0], $ig0   # |          1 |          1 |          1 |          0 |
    load    [ext_tmin + 0], $fg7        # |          1 |          1 |          1 |          0 |
    load    [ext_startp_fast + 0], $fg8 # |          1 |          1 |          1 |          0 |
    load    [ext_startp_fast + 1], $fg9 # |          1 |          1 |          1 |          0 |
    load    [ext_startp_fast + 2], $fg10# |          1 |          1 |          1 |          0 |
    load    [ext_texture_color + 1], $fg11# |          1 |          1 |          1 |          0 |
    load    [ext_light + 1], $fg12      # |          1 |          1 |          1 |          0 |
    load    [ext_light + 2], $fg13      # |          1 |          1 |          1 |          0 |
    load    [ext_light + 0], $fg14      # |          1 |          1 |          1 |          0 |
    load    [ext_texture_color + 2], $fg15# |          1 |          1 |          1 |          0 |
    load    [ext_or_net + 0], $ig1      # |          1 |          1 |          1 |          0 |
    load    [ext_intsec_rectside + 0], $ig2# |          1 |          1 |          1 |          0 |
    load    [ext_texture_color + 0], $fg16# |          1 |          1 |          1 |          0 |
    load    [ext_intersected_object_id + 0], $ig3# |          1 |          1 |          1 |          0 |
    load    [ext_n_reflections + 0], $ig4# |          1 |          1 |          1 |          0 |
    load    [ext_startp + 0], $fg17     # |          1 |          1 |          1 |          0 |
    load    [ext_startp + 1], $fg18     # |          1 |          1 |          1 |          0 |
    load    [ext_startp + 2], $fg19     # |          1 |          1 |          1 |          0 |
    load    [ext_screenz_dir + 0], $fg20# |          1 |          1 |          1 |          0 |
    load    [ext_screenz_dir + 1], $fg21# |          1 |          1 |          1 |          0 |
    load    [f.21978 + 0], $fc0         # |          1 |          1 |          1 |          0 |
    load    [f.22003 + 0], $fc1         # |          1 |          1 |          1 |          0 |
    load    [f.22002 + 0], $fc2         # |          1 |          1 |          1 |          0 |
    load    [f.21979 + 0], $fc3         # |          1 |          1 |          1 |          0 |
    load    [f.21982 + 0], $fc4         # |          1 |          1 |          1 |          0 |
    load    [f.21992 + 0], $fc5         # |          1 |          1 |          1 |          0 |
    load    [f.21991 + 0], $fc6         # |          1 |          1 |          1 |          0 |
    load    [f.21976 + 0], $fc7         # |          1 |          1 |          1 |          0 |
    load    [f.22076 + 0], $fc8         # |          1 |          1 |          1 |          0 |
    load    [f.21998 + 0], $fc9         # |          1 |          1 |          1 |          0 |
    load    [f.21997 + 0], $fc10        # |          1 |          1 |          1 |          0 |
    load    [f.21981 + 0], $fc11        # |          1 |          1 |          1 |          0 |
    load    [f.22075 + 0], $fc12        # |          1 |          1 |          1 |          0 |
    load    [f.21988 + 0], $fc13        # |          1 |          1 |          1 |          0 |
    load    [f.21984 + 0], $fc14        # |          1 |          1 |          1 |          0 |
    load    [f.21977 + 0], $fc15        # |          1 |          1 |          1 |          0 |
    load    [f.21933 + 0], $fc16        # |          1 |          1 |          1 |          0 |
    load    [f.22102 + 0], $fc17        # |          1 |          1 |          1 |          0 |
    load    [f.22101 + 0], $fc18        # |          1 |          1 |          1 |          0 |
    load    [f.22100 + 0], $fc19        # |          1 |          1 |          1 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i30                   # |          1 |          1 |          0 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i26                   # |          1 |          1 |          0 |          0 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $i1, $i32                   # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_screen + 0]       # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_screen + 1]       # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_screen + 2]       # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc16, $f8             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f9                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f8                    # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc16, $f10            # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f11                   # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f10, $f2                   # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fmul    $f9, $f11, $f2              # |          1 |          1 |          0 |          0 |
    fmul    $f9, $f1, $f3               # |          1 |          1 |          0 |          0 |
    fmul    $f8, $fc18, $fg21           # |          1 |          1 |          0 |          0 |
    fneg    $f8, $f4                    # |          1 |          1 |          0 |          0 |
    fneg    $f1, $f5                    # |          1 |          1 |          0 |          0 |
    fmul    $f2, $fc19, $f2             # |          1 |          1 |          0 |          0 |
    fmul    $f3, $fc19, $fg20           # |          1 |          1 |          0 |          0 |
    store   $f2, [ext_screenz_dir + 2]  # |          1 |          1 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |          1 |          1 |          0 |          0 |
    store   $f11, [ext_screenx_dir + 0] # |          1 |          1 |          0 |          0 |
    fmul    $f4, $f11, $f3              # |          1 |          1 |          0 |          0 |
    store   $f5, [ext_screenx_dir + 2]  # |          1 |          1 |          0 |          0 |
    fneg    $f9, $f4                    # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_screeny_dir + 0]  # |          1 |          1 |          0 |          0 |
    store   $f4, [ext_screeny_dir + 1]  # |          1 |          1 |          0 |          0 |
    store   $f3, [ext_screeny_dir + 2]  # |          1 |          1 |          0 |          0 |
    load    [ext_screen + 0], $f1       # |          1 |          1 |          1 |          0 |
    fsub    $f1, $fg20, $f1             # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_viewpoint + 0]    # |          1 |          1 |          0 |          0 |
    load    [ext_screen + 1], $f1       # |          1 |          1 |          1 |          0 |
    fsub    $f1, $fg21, $f1             # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_viewpoint + 1]    # |          1 |          1 |          0 |          0 |
    load    [ext_screen + 2], $f1       # |          1 |          1 |          1 |          0 |
    load    [ext_screenz_dir + 2], $f2  # |          1 |          1 |          1 |          0 |
    fsub    $f1, $f2, $f1               # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_viewpoint + 2]    # |          1 |          1 |          0 |          0 |
    call    ext_read_int                # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    fmul    $f1, $fc16, $f8             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fneg    $f1, $fg12                  # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f9                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
    fmul    $f9, $fc16, $f9             # |          1 |          1 |          0 |          0 |
.count move_ret
    mov     $f1, $f8                    # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_sin                     # |          1 |          1 |          0 |          0 |
    fmul    $f8, $f1, $fg14             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |          0 |          0 |
    call    ext_cos                     # |          1 |          1 |          0 |          0 |
    fmul    $f8, $f1, $fg13             # |          1 |          1 |          0 |          0 |
    call    ext_read_float              # |          1 |          1 |          0 |          0 |
    store   $f1, [ext_beam + 0]         # |          1 |          1 |          0 |          0 |
    li      0, $i6                      # |          1 |          1 |          0 |          0 |
    jal     read_object.2721, $ra2      # |          1 |          1 |          0 |          0 |
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
.count move_args
    mov     $fc8, $f9                   # |          1 |          1 |          0 |          0 |
    li      0, $i9                      # |          1 |          1 |          0 |          0 |
    li      0, $i10                     # |          1 |          1 |          0 |          0 |
    li      4, $i8                      # |          1 |          1 |          0 |          0 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |          0 |          0 |
    li      8, $i12                     # |          1 |          1 |          0 |          0 |
    li      2, $i13                     # |          1 |          1 |          0 |          0 |
    li      4, $i14                     # |          1 |          1 |          0 |          0 |
    jal     calc_dirvec_rows.3033, $ra3 # |          1 |          1 |          0 |          0 |
    li      4, $i10                     # |          1 |          1 |          0 |          0 |
    jal     init_vecset_constants.3047, $ra4# |          1 |          1 |          0 |          0 |
    li      ext_light_dirvec, $i4       # |          1 |          1 |          0 |          0 |
    store   $fg14, [%{ext_light_dirvec + 0} + 0]# |          1 |          1 |          0 |          0 |
    store   $fg12, [%{ext_light_dirvec + 0} + 1]# |          1 |          1 |          0 |          0 |
    store   $fg13, [%{ext_light_dirvec + 0} + 2]# |          1 |          1 |          0 |          0 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |          0 |          0 |
    add     $ig0, -1, $i1               # |          1 |          1 |          0 |          0 |
    bl      $i1, 0, bl.22777            # |          1 |          1 |          0 |          0 |
bge.22777:
    load    [ext_objects + $i1], $i2    # |          1 |          1 |          0 |          0 |
    load    [$i2 + 2], $i3              # |          1 |          1 |          1 |          0 |
    bne     $i3, 2, bl.22777            # |          1 |          1 |          0 |          0 |
be.22778:
    load    [$i2 + 11], $f1             # |          1 |          1 |          1 |          0 |
    ble     $fc0, $f1, bl.22777         # |          1 |          1 |          0 |          0 |
bg.22779:
    load    [$i2 + 1], $i3              # |          1 |          1 |          0 |          0 |
    be      $i3, 1, be.22780            # |          1 |          1 |          0 |          0 |
bne.22780:
    be      $i3, 2, be.22781            # |          1 |          1 |          0 |          1 |
bl.22777:
    li      127, $i27
    li      0, $i28
    load    [ext_screeny_dir + 0], $f1
    load    [ext_screeny_dir + 1], $f2
    fmul    $fc17, $f1, $f1
    load    [ext_screeny_dir + 2], $f3
    fmul    $fc17, $f2, $f2
    fmul    $fc17, $f3, $f3
    load    [ext_screenz_dir + 2], $f4
    fadd    $f1, $fg20, $f19
    fadd    $f2, $fg21, $f20
    fadd    $f3, $f4, $f21
    jal     pretrace_pixels.2983, $ra7
    li      0, $i29
    li      2, $i33
.count move_args
    mov     $i26, $i31
    jal     scan_line.3000, $ra9
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
be.22781:
    load    [$i2 + 4], $f2              # |          1 |          1 |          0 |          0 |
    fmul    $fc7, $f2, $f5              # |          1 |          1 |          0 |          0 |
    load    [$i2 + 5], $f3              # |          1 |          1 |          0 |          0 |
    fmul    $fg14, $f2, $f2             # |          1 |          1 |          0 |          0 |
    load    [$i2 + 6], $f4              # |          1 |          1 |          0 |          0 |
    fmul    $fg12, $f3, $f6             # |          1 |          1 |          0 |          0 |
    fmul    $fg13, $f4, $f7             # |          1 |          1 |          0 |          0 |
    add     $i1, $i1, $i1               # |          1 |          1 |          0 |          0 |
    fmul    $fc7, $f3, $f3              # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $ig4, $i8                   # |          1 |          1 |          0 |          0 |
    fmul    $fc7, $f4, $f4              # |          1 |          1 |          0 |          0 |
    add     $i1, $i1, $i1               # |          1 |          1 |          0 |          0 |
    fsub    $fc0, $f1, $f9              # |          1 |          1 |          0 |          0 |
    add     $i1, 1, $i9                 # |          1 |          1 |          0 |          0 |
    fadd    $f2, $f6, $f1               # |          1 |          1 |          0 |          0 |
    fadd    $f1, $f7, $f1               # |          1 |          1 |          0 |          0 |
    fmul    $f5, $f1, $f2               # |          1 |          1 |          0 |          0 |
    fmul    $f3, $f1, $f3               # |          1 |          1 |          0 |          0 |
    fmul    $f4, $f1, $f1               # |          1 |          1 |          0 |          0 |
    fsub    $f2, $fg14, $f2             # |          1 |          1 |          0 |          0 |
    fsub    $f3, $fg12, $f3             # |          1 |          1 |          0 |          0 |
    fsub    $f1, $fg13, $f4             # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $f2, $f1                    # |          1 |          1 |          0 |          0 |
    jal     add_reflection.3051, $ra3   # |          1 |          1 |          0 |          0 |
    add     $ig4, 1, $ig4               # |          1 |          1 |          0 |          0 |
    load    [ext_screeny_dir + 0], $f1  # |          1 |          1 |          1 |          0 |
    li      127, $i27                   # |          1 |          1 |          0 |          0 |
    load    [ext_screeny_dir + 1], $f2  # |          1 |          1 |          1 |          0 |
    li      0, $i28                     # |          1 |          1 |          0 |          0 |
    load    [ext_screeny_dir + 2], $f3  # |          1 |          1 |          1 |          0 |
    fmul    $fc17, $f1, $f1             # |          1 |          1 |          0 |          0 |
    load    [ext_screenz_dir + 2], $f4  # |          1 |          1 |          0 |          0 |
    fmul    $fc17, $f2, $f2             # |          1 |          1 |          0 |          0 |
    fmul    $fc17, $f3, $f3             # |          1 |          1 |          0 |          0 |
    fadd    $f1, $fg20, $f19            # |          1 |          1 |          0 |          0 |
    fadd    $f2, $fg21, $f20            # |          1 |          1 |          0 |          0 |
    fadd    $f3, $f4, $f21              # |          1 |          1 |          0 |          0 |
    jal     pretrace_pixels.2983, $ra7  # |          1 |          1 |          0 |          0 |
    li      0, $i29                     # |          1 |          1 |          0 |          0 |
    li      2, $i33                     # |          1 |          1 |          0 |          0 |
.count move_args
    mov     $i26, $i31                  # |          1 |          1 |          0 |          0 |
    jal     scan_line.3000, $ra9        # |          1 |          1 |          0 |          0 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |          1 |          0 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |          0 |          0 |
    li      0, $i1                      # |          1 |          1 |          0 |          0 |
    ret                                 # |          1 |          1 |          0 |          0 |
be.22780:
    add     $i1, $i1, $i1
    load    [$i2 + 11], $f1
    add     $i1, $i1, $i10
    fneg    $fg12, $f10
    fneg    $fg13, $f11
    add     $i10, 1, $i9
    fsub    $fc0, $f1, $f9
.count move_args
    mov     $ig4, $i8
.count move_args
    mov     $fg14, $f1
.count move_args
    mov     $f10, $f3
.count move_args
    mov     $f11, $f4
    jal     add_reflection.3051, $ra3
    fneg    $fg14, $f12
    add     $ig4, 1, $i8
    add     $i10, 2, $i9
.count move_args
    mov     $f12, $f1
.count move_args
    mov     $fg12, $f3
.count move_args
    mov     $f11, $f4
    jal     add_reflection.3051, $ra3
.count move_args
    mov     $f12, $f1
    add     $ig4, 2, $i8
.count move_args
    mov     $f10, $f3
    add     $i10, 3, $i9
.count move_args
    mov     $fg13, $f4
    jal     add_reflection.3051, $ra3
    load    [ext_screeny_dir + 0], $f1
    add     $ig4, 3, $ig4
    load    [ext_screeny_dir + 1], $f2
    li      127, $i27
    load    [ext_screeny_dir + 2], $f3
    li      0, $i28
    fmul    $fc17, $f1, $f1
    fmul    $fc17, $f2, $f2
    load    [ext_screenz_dir + 2], $f4
    fmul    $fc17, $f3, $f3
    fadd    $f1, $fg20, $f19
    fadd    $f2, $fg21, $f20
    fadd    $f3, $f4, $f21
    jal     pretrace_pixels.2983, $ra7
    li      0, $i29
    li      2, $i33
.count move_args
    mov     $i26, $i31
    jal     scan_line.3000, $ra9
.count stack_load_ra
    load    [$sp + 0], $ra
.count stack_move
    add     $sp, 1, $sp
    li      0, $i1
    ret     
.end main
                                        # | Instructions | Clocks     | DCacheMiss | BranchMiss |
