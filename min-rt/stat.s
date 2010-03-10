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

#スタックとヒープの初期化($hp=0x4000,$sp=0x20000)
    li      0, $i0                      # |          1 |          1 |
    mov     $i0, $f0                    # |          1 |          1 |
    li      0x2000, $hp                 # |          1 |          1 |
    sll     $hp, $hp                    # |          1 |          1 |
    sll     $hp, $sp                    # |          1 |          1 |
    sll     $sp, $sp                    # |          1 |          1 |
    sll     $sp, $sp                    # |          1 |          1 |
    call    ext_main                    # |          1 |          1 |
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
    mov $f2, $f1                        # |    189,018 |    189,018 |
    bge $f1, $f0, FLOOR_POSITIVE        # |    189,018 |    189,018 |
    fneg $f1, $f1                       # |    166,569 |    166,569 |
    mov $ra, $tmp                       # |    166,569 |    166,569 |
    call FLOOR_POSITIVE                 # |    166,569 |    166,569 |
    load [FLOOR_MONE], $f2              # |    166,569 |    166,569 |
    fsub $f2, $f1, $f1                  # |    166,569 |    166,569 |
    jr $tmp                             # |    166,569 |    166,569 |
FLOOR_POSITIVE:
    load [FLOAT_MAGICF], $f3            # |    189,018 |    189,018 |
    ble $f1, $f3, FLOOR_POSITIVE_MAIN   # |    189,018 |    189,018 |
    ret
FLOOR_POSITIVE_MAIN:
    mov $f1, $f2                        # |    189,018 |    189,018 |
    fadd $f1, $f3, $f1                  # |    189,018 |    189,018 |
    fsub $f1, $f3, $f1                  # |    189,018 |    189,018 |
    ble $f1, $f2, FLOOR_RET             # |    189,018 |    189,018 |
    load [FLOOR_ONE], $f2
    fsub $f1, $f2, $f1
FLOOR_RET:
    ret                                 # |    189,018 |    189,018 |
.end floor

######################################################################
# $f1 = float_of_int($i2)
# $ra = $ra
# [$i2 - $i4]
# [$f1 - $f3]
######################################################################
.begin float_of_int
ext_float_of_int:
    bge $i2, 0, ITOF_MAIN               # |     16,545 |     16,545 |
    neg $i2, $i2                        # |      8,255 |      8,255 |
    mov $ra, $tmp                       # |      8,255 |      8,255 |
    call ITOF_MAIN                      # |      8,255 |      8,255 |
    fneg $f1, $f1                       # |      8,255 |      8,255 |
    jr $tmp                             # |      8,255 |      8,255 |
ITOF_MAIN:
    load [FLOAT_MAGICF], $f2            # |     16,545 |     16,545 |
    load [FLOAT_MAGICFHX], $i3          # |     16,545 |     16,545 |
    load [FLOAT_MAGICI], $i4            # |     16,545 |     16,545 |
    bge $i2, $i4, ITOF_BIG              # |     16,545 |     16,545 |
    add $i2, $i3, $i2                   # |     16,545 |     16,545 |
    mov $i2, $f1                        # |     16,545 |     16,545 |
    fsub $f1, $f2, $f1                  # |     16,545 |     16,545 |
    ret                                 # |     16,545 |     16,545 |
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
    bge $f2, $f0, FTOI_MAIN             # |     49,152 |     49,152 |
    fneg $f2, $f2
    mov $ra, $tmp
    call FTOI_MAIN
    neg $i1, $i1
    jr $tmp
FTOI_MAIN:
    load [FLOAT_MAGICF], $f3            # |     49,152 |     49,152 |
    load [FLOAT_MAGICFHX], $i2          # |     49,152 |     49,152 |
    bge $f2, $f3, FTOI_BIG              # |     49,152 |     49,152 |
    fadd $f2, $f3, $f2                  # |     49,152 |     49,152 |
    mov $f2, $i1                        # |     49,152 |     49,152 |
    sub $i1, $i2, $i1                   # |     49,152 |     49,152 |
    ret                                 # |     49,152 |     49,152 |
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
    li 0, $i1                           # |        325 |        325 |
    li 0, $i3                           # |        325 |        325 |
    li 255, $i5                         # |        325 |        325 |
read_int_loop:
    read $i2                            # |      1,300 |      1,300 |
    bg $i2, $i5, read_int_loop          # |      1,300 |      1,300 |
    li 0, $i4                           # |      1,300 |      1,300 |
sll_loop:
    add $i4, 1, $i4                     # |     10,400 |     10,400 |
    sll $i1, $i1                        # |     10,400 |     10,400 |
    bl $i4, 8, sll_loop                 # |     10,400 |     10,400 |
    add $i3, 1, $i3                     # |      1,300 |      1,300 |
    add $i1, $i2, $i1                   # |      1,300 |      1,300 |
    bl $i3, 4, read_int_loop            # |      1,300 |      1,300 |
    ret                                 # |        325 |        325 |

######################################################################
# $f1 = read_float()
# $ra = $ra
# [$i1 - $i5]
# [$f1]
######################################################################
ext_read_float:
    mov $ra, $tmp                       # |        212 |        212 |
    call ext_read_int                   # |        212 |        212 |
    mov $i1, $f1                        # |        212 |        212 |
    jr $tmp                             # |        212 |        212 |
.end read

######################################################################
# write($i2)
# $ra = $ra
# [$i2]
# []
######################################################################
.begin write
ext_write:
    write $i2, $tmp                     # |     49,167 |     49,167 |
    bg $tmp, 0, ext_write               # |     49,167 |     49,167 |
    ret                                 # |     49,167 |     49,167 |
.end write

######################################################################
# $i1 = create_array_int($i2, $i3)
# $ra = $ra
# [$i1 - $i3]
# []
######################################################################
.begin create_array
ext_create_array_int:
    mov $i2, $i1                        # |     22,313 |     22,313 |
    add $i2, $hp, $i2                   # |     22,313 |     22,313 |
    mov $hp, $i1                        # |     22,313 |     22,313 |
create_array_loop:
    store $i3, [$hp]                    # |    103,030 |    103,030 |
    add $hp, 1, $hp                     # |    103,030 |    103,030 |
    bl $hp, $i2, create_array_loop      # |    103,030 |    103,030 |
    ret                                 # |     22,313 |     22,313 |

######################################################################
# $i1 = create_array_float($i2, $f2)
# $ra = $ra
# [$i1 - $i3]
# [$f2]
######################################################################
ext_create_array_float:
    mov $f2, $i3                        # |     19,001 |     19,001 |
    jal ext_create_array_int $tmp       # |     19,001 |     19,001 |
.end create_array

######################################################################
# 三角関数
######################################################################
ext_atan_table:
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

f._186: .float  6.2831853072E+00
f._185: .float  3.1415926536E+00
f._184: .float  1.5707963268E+00
f._183: .float  6.0725293501E-01
f._182: .float  1.0000000000E+00
f._181: .float  5.0000000000E-01

######################################################################
# $f1 = atan($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f5]
######################################################################
.begin atan
ext_atan:
.count load_float
    load    [f._182], $f5               # |      1,000 |      1,000 |
    li      0, $i2                      # |      1,000 |      1,000 |
.count move_args
    mov     $f2, $f3                    # |      1,000 |      1,000 |
.count move_args
    mov     $f0, $f4                    # |      1,000 |      1,000 |
.count move_args
    mov     $f5, $f2                    # |      1,000 |      1,000 |
    b       cordic_rec._146             # |      1,000 |      1,000 |

cordic_rec._146:
    bne     $i2, 25, be_else._188       # |     26,000 |     26,000 |
be_then._188:
    mov     $f4, $f1                    # |      1,000 |      1,000 |
    ret                                 # |      1,000 |      1,000 |
be_else._188:
    fmul    $f5, $f3, $f1               # |     25,000 |     25,000 |
    bg      $f3, $f0, ble_else._189     # |     25,000 |     25,000 |
ble_then._189:
    fsub    $f2, $f1, $f1               # |     12,268 |     12,268 |
    fmul    $f5, $f2, $f2               # |     12,268 |     12,268 |
    fadd    $f3, $f2, $f3               # |     12,268 |     12,268 |
    load    [ext_atan_table + $i2], $f2 # |     12,268 |     12,268 |
    fsub    $f4, $f2, $f4               # |     12,268 |     12,268 |
.count load_float
    load    [f._181], $f2               # |     12,268 |     12,268 |
    fmul    $f5, $f2, $f5               # |     12,268 |     12,268 |
    add     $i2, 1, $i2                 # |     12,268 |     12,268 |
.count move_args
    mov     $f1, $f2                    # |     12,268 |     12,268 |
    b       cordic_rec._146             # |     12,268 |     12,268 |
ble_else._189:
    fadd    $f2, $f1, $f1               # |     12,732 |     12,732 |
    fmul    $f5, $f2, $f2               # |     12,732 |     12,732 |
    fsub    $f3, $f2, $f3               # |     12,732 |     12,732 |
    load    [ext_atan_table + $i2], $f2 # |     12,732 |     12,732 |
    fadd    $f4, $f2, $f4               # |     12,732 |     12,732 |
.count load_float
    load    [f._181], $f2               # |     12,732 |     12,732 |
    fmul    $f5, $f2, $f5               # |     12,732 |     12,732 |
    add     $i2, 1, $i2                 # |     12,732 |     12,732 |
.count move_args
    mov     $f1, $f2                    # |     12,732 |     12,732 |
    b       cordic_rec._146             # |     12,732 |     12,732 |
.end atan

######################################################################
# $f1 = sin($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f7]
######################################################################
.begin sin
ext_sin:
    bg      $f0, $f2, ble_else._192     # |      9,153 |      9,153 |
ble_then._192:
.count load_float
    load    [f._184], $f7               # |      8,653 |      8,653 |
    bg      $f7, $f2, cordic_sin._82    # |      8,653 |      8,653 |
.count load_float
    load    [f._185], $f7               # |      5,304 |      5,304 |
    bg      $f7, $f2, ble_else._194     # |      5,304 |      5,304 |
ble_then._194:
.count load_float
    load    [f._186], $f1               # |      3,759 |      3,759 |
    bg      $f1, $f2, ble_else._195     # |      3,759 |      3,759 |
ble_then._195:
    fsub    $f2, $f1, $f2               # |      2,416 |      2,416 |
    b       ext_sin                     # |      2,416 |      2,416 |
ble_else._195:
.count stack_move
    sub     $sp, 1, $sp                 # |      1,343 |      1,343 |
.count stack_store
    store   $ra, [$sp + 0]              # |      1,343 |      1,343 |
    fsub    $f1, $f2, $f2               # |      1,343 |      1,343 |
    call    ext_sin                     # |      1,343 |      1,343 |
.count stack_load
    load    [$sp + 0], $ra              # |      1,343 |      1,343 |
.count stack_move
    add     $sp, 1, $sp                 # |      1,343 |      1,343 |
    fneg    $f1, $f1                    # |      1,343 |      1,343 |
    ret                                 # |      1,343 |      1,343 |
ble_else._194:
    fsub    $f7, $f2, $f2               # |      1,545 |      1,545 |
    b       cordic_sin._82              # |      1,545 |      1,545 |
ble_else._192:
.count stack_move
    sub     $sp, 1, $sp                 # |        500 |        500 |
.count stack_store
    store   $ra, [$sp + 0]              # |        500 |        500 |
    fneg    $f2, $f2                    # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count stack_load
    load    [$sp + 0], $ra              # |        500 |        500 |
.count stack_move
    add     $sp, 1, $sp                 # |        500 |        500 |
    fneg    $f1, $f1                    # |        500 |        500 |
    ret                                 # |        500 |        500 |

cordic_rec._111:
    bne     $i2, 25, be_else._190       # |    127,244 |    127,244 |
be_then._190:
    mov     $f4, $f1                    # |      4,894 |      4,894 |
    ret                                 # |      4,894 |      4,894 |
be_else._190:
    fmul    $f6, $f4, $f1               # |    122,350 |    122,350 |
    bg      $f2, $f5, ble_else._191     # |    122,350 |    122,350 |
ble_then._191:
    fadd    $f3, $f1, $f1               # |     59,253 |     59,253 |
    fmul    $f6, $f3, $f3               # |     59,253 |     59,253 |
    fsub    $f4, $f3, $f4               # |     59,253 |     59,253 |
    load    [ext_atan_table + $i2], $f3 # |     59,253 |     59,253 |
    fsub    $f5, $f3, $f5               # |     59,253 |     59,253 |
.count load_float
    load    [f._181], $f3               # |     59,253 |     59,253 |
    fmul    $f6, $f3, $f6               # |     59,253 |     59,253 |
    add     $i2, 1, $i2                 # |     59,253 |     59,253 |
.count move_args
    mov     $f1, $f3                    # |     59,253 |     59,253 |
    b       cordic_rec._111             # |     59,253 |     59,253 |
ble_else._191:
    fsub    $f3, $f1, $f1               # |     63,097 |     63,097 |
    fmul    $f6, $f3, $f3               # |     63,097 |     63,097 |
    fadd    $f4, $f3, $f4               # |     63,097 |     63,097 |
    load    [ext_atan_table + $i2], $f3 # |     63,097 |     63,097 |
    fadd    $f5, $f3, $f5               # |     63,097 |     63,097 |
.count load_float
    load    [f._181], $f3               # |     63,097 |     63,097 |
    fmul    $f6, $f3, $f6               # |     63,097 |     63,097 |
    add     $i2, 1, $i2                 # |     63,097 |     63,097 |
.count move_args
    mov     $f1, $f3                    # |     63,097 |     63,097 |
    b       cordic_rec._111             # |     63,097 |     63,097 |

cordic_sin._82:
.count load_float
    load    [f._183], $f3               # |      4,894 |      4,894 |
.count load_float
    load    [f._182], $f6               # |      4,894 |      4,894 |
    li      0, $i2                      # |      4,894 |      4,894 |
.count move_args
    mov     $f0, $f4                    # |      4,894 |      4,894 |
.count move_args
    mov     $f0, $f5                    # |      4,894 |      4,894 |
    b       cordic_rec._111             # |      4,894 |      4,894 |
.end sin

######################################################################
# $f1 = cos($f2)
# $ra = $ra
# [$i2]
# [$f1 - $f8]
######################################################################
.begin cos
ext_cos:
.count load_float
    load    [f._184], $f8               # |      1,004 |      1,004 |
    fsub    $f8, $f2, $f2               # |      1,004 |      1,004 |
    b       ext_sin                     # |      1,004 |      1,004 |
.end cos

######################################################################
#
#       ↑　ここまで lib_asm.s
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
    .int    light_dirvec_v3
    .int    light_dirvec_consts
light_dirvec_v3:
    .skip   3
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
.define $fg0 $f19
.define $f19 orz
.define $fg1 $f20
.define $f20 orz
.define $fg2 $f21
.define $f21 orz
.define $fg3 $f22
.define $f22 orz
.define $fg4 $f23
.define $f23 orz
.define $fg5 $f24
.define $f24 orz
.define $fg6 $f25
.define $f25 orz
.define $fg7 $f26
.define $f26 orz
.define $fg8 $f27
.define $f27 orz
.define $fg9 $f28
.define $f28 orz
.define $fg10 $f29
.define $f29 orz
.define $fg11 $f30
.define $f30 orz
.define $fg12 $f31
.define $f31 orz
.define $fg13 $f32
.define $f32 orz
.define $fg14 $f33
.define $f33 orz
.define $fg15 $f34
.define $f34 orz
.define $fg16 $f35
.define $f35 orz
.define $fg17 $f36
.define $f36 orz
.define $fg18 $f37
.define $f37 orz
.define $fg19 $f38
.define $f38 orz
.define $fg20 $f39
.define $f39 orz
.define $fg21 $f40
.define $f40 orz
.define $fg22 $f41
.define $f41 orz
.define $fg23 $f42
.define $f42 orz
.define $fg24 $f43
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
f.21573:    .float  -6.4000000000E+01
f.21565:    .float  -5.0000000000E-01
f.21564:    .float  7.0000000000E-01
f.21563:    .float  -3.0000000000E-01
f.21562:    .float  -1.0000000000E-01
f.21561:    .float  9.0000000000E-01
f.21560:    .float  2.0000000000E-01
f.21550:    .float  1.5000000000E+02
f.21549:    .float  -1.5000000000E+02
f.21548:    .float  6.6666666667E-03
f.21547:    .float  -6.6666666667E-03
f.21546:    .float  -2.0000000000E+00
f.21545:    .float  3.9062500000E-03
f.21544:    .float  2.5600000000E+02
f.21543:    .float  1.0000000000E+08
f.21542:    .float  1.0000000000E+09
f.21541:    .float  1.0000000000E+01
f.21540:    .float  2.0000000000E+01
f.21539:    .float  5.0000000000E-02
f.21538:    .float  2.5000000000E-01
f.21537:    .float  2.5500000000E+02
f.21536:    .float  1.0000000000E-01
f.21535:    .float  8.5000000000E+02
f.21534:    .float  1.5000000000E-01
f.21533:    .float  9.5492964444E+00
f.21532:    .float  3.1830988148E-01
f.21531:    .float  3.1415927000E+00
f.21530:    .float  3.0000000000E+01
f.21529:    .float  1.5000000000E+01
f.21528:    .float  1.0000000000E-04
f.21527:    .float  -1.0000000000E-01
f.21526:    .float  1.0000000000E-02
f.21525:    .float  -2.0000000000E-01
f.21524:    .float  5.0000000000E-01
f.21523:    .float  1.0000000000E+00
f.21522:    .float  -1.0000000000E+00
f.21521:    .float  2.0000000000E+00
f.21507:    .float  -2.0000000000E+02
f.21506:    .float  2.0000000000E+02
f.21505:    .float  1.7453293000E-02

######################################################################
# read_screen_settings()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f11]
# []
# [$fg20 - $fg24]
# [$ra]
######################################################################
.begin read_screen_settings
read_screen_settings.2712:
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 0]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 1]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_screen + 2]       # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $fc16, $f9             # |          1 |          1 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
.count move_args
    mov     $f9, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f9                    # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $fc16, $f11            # |          1 |          1 |
.count move_args
    mov     $f11, $f2                   # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f8                    # |          1 |          1 |
.count move_args
    mov     $f11, $f2                   # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f10, $f1, $f2              # |          1 |          1 |
.count load_float
    load    [f.21506], $f3              # |          1 |          1 |
    fmul    $f2, $f3, $fg20             # |          1 |          1 |
.count load_float
    load    [f.21507], $f2              # |          1 |          1 |
    fmul    $f9, $f2, $fg21             # |          1 |          1 |
    fmul    $f10, $f8, $f2              # |          1 |          1 |
    fmul    $f2, $f3, $fg22             # |          1 |          1 |
    store   $f8, [ext_screenx_dir + 0]  # |          1 |          1 |
    fneg    $f1, $f2                    # |          1 |          1 |
    store   $f2, [ext_screenx_dir + 2]  # |          1 |          1 |
    fneg    $f9, $f2                    # |          1 |          1 |
    fmul    $f2, $f1, $fg23             # |          1 |          1 |
    fneg    $f10, $fg24                 # |          1 |          1 |
    fmul    $f2, $f8, $f1               # |          1 |          1 |
    store   $f1, [ext_screeny_dir + 2]  # |          1 |          1 |
    load    [ext_screen + 0], $f1       # |          1 |          1 |
    fsub    $f1, $fg20, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 0]    # |          1 |          1 |
    load    [ext_screen + 1], $f1       # |          1 |          1 |
    fsub    $f1, $fg21, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 1]    # |          1 |          1 |
    load    [ext_screen + 2], $f1       # |          1 |          1 |
    fsub    $f1, $fg22, $f1             # |          1 |          1 |
    store   $f1, [ext_viewpoint + 2]    # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
.end read_screen_settings

######################################################################
# read_light()
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f10]
# []
# [$fg12 - $fg14]
# [$ra]
######################################################################
.begin read_light
read_light.2714:
    call    ext_read_int                # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    fmul    $f1, $fc16, $f8             # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fneg    $f1, $fg12                  # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
.count move_ret
    mov     $f1, $f9                    # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
.count move_ret
    mov     $f1, $f10                   # |          1 |          1 |
    fmul    $f9, $fc16, $f8             # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_sin                     # |          1 |          1 |
    fmul    $f10, $f1, $fg14            # |          1 |          1 |
.count move_args
    mov     $f8, $f2                    # |          1 |          1 |
    call    ext_cos                     # |          1 |          1 |
    fmul    $f10, $f1, $fg13            # |          1 |          1 |
    call    ext_read_float              # |          1 |          1 |
    store   $f1, [ext_beam + 0]         # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
.end read_light

######################################################################
# $i1 = read_nth_object($i6)
# $ra = $ra1
# [$i1 - $i15]
# [$f1 - $f17]
# []
# []
# [$ra]
######################################################################
.begin read_nth_object
read_nth_object.2719:
    call    ext_read_int                # |         18 |         18 |
.count move_ret
    mov     $i1, $i7                    # |         18 |         18 |
    bne     $i7, -1, be_else.21685      # |         18 |         18 |
be_then.21685:
    li      0, $i1                      # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
be_else.21685:
    call    ext_read_int                # |         17 |         17 |
.count move_ret
    mov     $i1, $i8                    # |         17 |         17 |
    call    ext_read_int                # |         17 |         17 |
.count move_ret
    mov     $i1, $i9                    # |         17 |         17 |
    call    ext_read_int                # |         17 |         17 |
.count move_ret
    mov     $i1, $i10                   # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
.count move_ret
    mov     $i1, $i11                   # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i11 + 0]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i11 + 1]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i11 + 2]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
.count move_ret
    mov     $i1, $i12                   # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i12 + 0]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i12 + 1]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i12 + 2]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
.count move_ret
    mov     $f1, $f3                    # |         17 |         17 |
    li      2, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
.count move_ret
    mov     $i1, $i13                   # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i13 + 0]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i13 + 1]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
.count move_ret
    mov     $i1, $i14                   # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i14 + 0]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i14 + 1]             # |         17 |         17 |
    call    ext_read_float              # |         17 |         17 |
    store   $f1, [$i14 + 2]             # |         17 |         17 |
    li      3, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
.count move_ret
    mov     $i1, $i15                   # |         17 |         17 |
    be      $i10, 0, bne_cont.21686     # |         17 |         17 |
bne_then.21686:
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 0]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 1]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 2]
bne_cont.21686:
    li      4, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
    bg      $f0, $f3, ble_else.21687    # |         17 |         17 |
ble_then.21687:
    li      0, $i2                      # |         15 |         15 |
.count b_cont
    b       ble_cont.21687              # |         15 |         15 |
ble_else.21687:
    li      1, $i2                      # |          2 |          2 |
ble_cont.21687:
    bne     $i8, 2, be_else.21688       # |         17 |         17 |
be_then.21688:
    li      1, $i3                      # |          2 |          2 |
.count b_cont
    b       be_cont.21688               # |          2 |          2 |
be_else.21688:
    mov     $i2, $i3                    # |         15 |         15 |
be_cont.21688:
    mov     $hp, $i4                    # |         17 |         17 |
    add     $hp, 11, $hp                # |         17 |         17 |
    store   $i1, [$i4 + 10]             # |         17 |         17 |
    store   $i15, [$i4 + 9]             # |         17 |         17 |
    store   $i14, [$i4 + 8]             # |         17 |         17 |
    store   $i13, [$i4 + 7]             # |         17 |         17 |
    store   $i3, [$i4 + 6]              # |         17 |         17 |
    store   $i12, [$i4 + 5]             # |         17 |         17 |
    store   $i11, [$i4 + 4]             # |         17 |         17 |
    store   $i10, [$i4 + 3]             # |         17 |         17 |
    store   $i9, [$i4 + 2]              # |         17 |         17 |
    store   $i8, [$i4 + 1]              # |         17 |         17 |
    store   $i7, [$i4 + 0]              # |         17 |         17 |
    store   $i4, [ext_objects + $i6]    # |         17 |         17 |
    bne     $i8, 3, be_else.21689       # |         17 |         17 |
be_then.21689:
    load    [$i11 + 0], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.21690     # |          9 |          9 |
be_then.21690:
    mov     $f0, $f1                    # |          2 |          2 |
.count b_cont
    b       be_cont.21690               # |          2 |          2 |
be_else.21690:
    bne     $f1, $f0, be_else.21691     # |          7 |          7 |
be_then.21691:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.21691
be_else.21691:
    bg      $f1, $f0, ble_else.21692    # |          7 |          7 |
ble_then.21692:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.21692
ble_else.21692:
    fmul    $f1, $f1, $f1               # |          7 |          7 |
    finv    $f1, $f1                    # |          7 |          7 |
ble_cont.21692:
be_cont.21691:
be_cont.21690:
    store   $f1, [$i11 + 0]             # |          9 |          9 |
    load    [$i11 + 1], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.21693     # |          9 |          9 |
be_then.21693:
    mov     $f0, $f1
.count b_cont
    b       be_cont.21693
be_else.21693:
    bne     $f1, $f0, be_else.21694     # |          9 |          9 |
be_then.21694:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.21694
be_else.21694:
    bg      $f1, $f0, ble_else.21695    # |          9 |          9 |
ble_then.21695:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.21695
ble_else.21695:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
ble_cont.21695:
be_cont.21694:
be_cont.21693:
    store   $f1, [$i11 + 1]             # |          9 |          9 |
    load    [$i11 + 2], $f1             # |          9 |          9 |
    bne     $f1, $f0, be_else.21696     # |          9 |          9 |
be_then.21696:
    mov     $f0, $f1
.count b_cont
    b       be_cont.21696
be_else.21696:
    bne     $f1, $f0, be_else.21697     # |          9 |          9 |
be_then.21697:
    fmul    $f1, $f1, $f1
    finv    $f1, $f1
    mov     $f0, $f1
.count b_cont
    b       be_cont.21697
be_else.21697:
    bg      $f1, $f0, ble_else.21698    # |          9 |          9 |
ble_then.21698:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
.count b_cont
    b       ble_cont.21698
ble_else.21698:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
ble_cont.21698:
be_cont.21697:
be_cont.21696:
    store   $f1, [$i11 + 2]             # |          9 |          9 |
    bne     $i10, 0, be_else.21699      # |          9 |          9 |
be_then.21699:
    li      1, $i1                      # |          9 |          9 |
    jr      $ra1                        # |          9 |          9 |
be_else.21699:
    load    [$i15 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f9
    load    [$i15 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f10
    load    [$i15 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f11
    load    [$i15 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f12
    load    [$i15 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f8
    load    [$i15 + 2], $f2
    call    ext_sin
    fmul    $f11, $f8, $f2
    fmul    $f2, $f2, $f3
    load    [$i11 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f11, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i11 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f12, $f6
    fmul    $f6, $f6, $f13
    load    [$i11 + 2], $f14
    fmul    $f14, $f13, $f13
    fadd    $f3, $f13, $f3
    store   $f3, [$i11 + 0]
    fmul    $f10, $f12, $f3
    fmul    $f3, $f8, $f13
    fmul    $f9, $f1, $f15
    fsub    $f13, $f15, $f13
    fmul    $f13, $f13, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f9, $f8, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f10, $f11, $f16
    fmul    $f16, $f16, $f17
    fmul    $f14, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i11 + 1]
    fmul    $f9, $f12, $f12
    fmul    $f12, $f8, $f15
    fmul    $f10, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f12, $f1, $f1
    fmul    $f10, $f8, $f8
    fsub    $f1, $f8, $f1
    fmul    $f1, $f1, $f8
    fmul    $f7, $f8, $f8
    fadd    $f17, $f8, $f8
    fmul    $f9, $f11, $f9
    fmul    $f9, $f9, $f10
    fmul    $f14, $f10, $f10
    fadd    $f8, $f10, $f8
    store   $f8, [$i11 + 2]
    fmul    $f4, $f13, $f8
    fmul    $f8, $f15, $f8
    fmul    $f7, $f3, $f10
    fmul    $f10, $f1, $f10
    fadd    $f8, $f10, $f8
    fmul    $f14, $f16, $f10
    fmul    $f10, $f9, $f10
    fadd    $f8, $f10, $f8
    fmul    $fc10, $f8, $f8
    store   $f8, [$i15 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f14, $f6, $f4
    fmul    $f4, $f9, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 1]
    fmul    $f2, $f13, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 2]
    li      1, $i1
    jr      $ra1
be_else.21689:
    bne     $i8, 2, be_else.21700       # |          8 |          8 |
be_then.21700:
    load    [$i11 + 0], $f1             # |          2 |          2 |
    bne     $i2, 0, be_else.21701       # |          2 |          2 |
be_then.21701:
    li      1, $i1                      # |          2 |          2 |
.count b_cont
    b       be_cont.21701               # |          2 |          2 |
be_else.21701:
    li      0, $i1
be_cont.21701:
    fmul    $f1, $f1, $f2               # |          2 |          2 |
    load    [$i11 + 1], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    load    [$i11 + 2], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    fsqrt   $f2, $f2                    # |          2 |          2 |
    bne     $f2, $f0, be_else.21702     # |          2 |          2 |
be_then.21702:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.21702
be_else.21702:
    bne     $i1, 0, be_else.21703       # |          2 |          2 |
be_then.21703:
    finv    $f2, $f2
.count b_cont
    b       be_cont.21703
be_else.21703:
    finv_n  $f2, $f2                    # |          2 |          2 |
be_cont.21703:
be_cont.21702:
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |
    load    [$i11 + 2], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |
    bne     $i10, 0, be_else.21704      # |          2 |          2 |
be_then.21704:
    li      1, $i1                      # |          2 |          2 |
    jr      $ra1                        # |          2 |          2 |
be_else.21704:
    load    [$i15 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f9
    load    [$i15 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f10
    load    [$i15 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f11
    load    [$i15 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f12
    load    [$i15 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f8
    load    [$i15 + 2], $f2
    call    ext_sin
    fmul    $f11, $f8, $f2
    fmul    $f2, $f2, $f3
    load    [$i11 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f11, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i11 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f12, $f6
    fmul    $f6, $f6, $f13
    load    [$i11 + 2], $f14
    fmul    $f14, $f13, $f13
    fadd    $f3, $f13, $f3
    store   $f3, [$i11 + 0]
    fmul    $f10, $f12, $f3
    fmul    $f3, $f8, $f13
    fmul    $f9, $f1, $f15
    fsub    $f13, $f15, $f13
    fmul    $f13, $f13, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f9, $f8, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f10, $f11, $f16
    fmul    $f16, $f16, $f17
    fmul    $f14, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i11 + 1]
    fmul    $f9, $f12, $f12
    fmul    $f12, $f8, $f15
    fmul    $f10, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f12, $f1, $f1
    fmul    $f10, $f8, $f8
    fsub    $f1, $f8, $f1
    fmul    $f1, $f1, $f8
    fmul    $f7, $f8, $f8
    fadd    $f17, $f8, $f8
    fmul    $f9, $f11, $f9
    fmul    $f9, $f9, $f10
    fmul    $f14, $f10, $f10
    fadd    $f8, $f10, $f8
    store   $f8, [$i11 + 2]
    fmul    $f4, $f13, $f8
    fmul    $f8, $f15, $f8
    fmul    $f7, $f3, $f10
    fmul    $f10, $f1, $f10
    fadd    $f8, $f10, $f8
    fmul    $f14, $f16, $f10
    fmul    $f10, $f9, $f10
    fadd    $f8, $f10, $f8
    fmul    $fc10, $f8, $f8
    store   $f8, [$i15 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f14, $f6, $f4
    fmul    $f4, $f9, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 1]
    fmul    $f2, $f13, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 2]
    li      1, $i1
    jr      $ra1
be_else.21700:
    bne     $i10, 0, be_else.21705      # |          6 |          6 |
be_then.21705:
    li      1, $i1                      # |          6 |          6 |
    jr      $ra1                        # |          6 |          6 |
be_else.21705:
    load    [$i15 + 0], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f9
    load    [$i15 + 0], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f10
    load    [$i15 + 1], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f11
    load    [$i15 + 1], $f2
    call    ext_sin
.count move_ret
    mov     $f1, $f12
    load    [$i15 + 2], $f2
    call    ext_cos
.count move_ret
    mov     $f1, $f8
    load    [$i15 + 2], $f2
    call    ext_sin
    fmul    $f11, $f8, $f2
    fmul    $f2, $f2, $f3
    load    [$i11 + 0], $f4
    fmul    $f4, $f3, $f3
    fmul    $f11, $f1, $f5
    fmul    $f5, $f5, $f6
    load    [$i11 + 1], $f7
    fmul    $f7, $f6, $f6
    fadd    $f3, $f6, $f3
    fneg    $f12, $f6
    fmul    $f6, $f6, $f13
    load    [$i11 + 2], $f14
    fmul    $f14, $f13, $f13
    fadd    $f3, $f13, $f3
    store   $f3, [$i11 + 0]
    fmul    $f10, $f12, $f3
    fmul    $f3, $f8, $f13
    fmul    $f9, $f1, $f15
    fsub    $f13, $f15, $f13
    fmul    $f13, $f13, $f15
    fmul    $f4, $f15, $f15
    fmul    $f3, $f1, $f3
    fmul    $f9, $f8, $f16
    fadd    $f3, $f16, $f3
    fmul    $f3, $f3, $f16
    fmul    $f7, $f16, $f16
    fadd    $f15, $f16, $f15
    fmul    $f10, $f11, $f16
    fmul    $f16, $f16, $f17
    fmul    $f14, $f17, $f17
    fadd    $f15, $f17, $f15
    store   $f15, [$i11 + 1]
    fmul    $f9, $f12, $f12
    fmul    $f12, $f8, $f15
    fmul    $f10, $f1, $f17
    fadd    $f15, $f17, $f15
    fmul    $f15, $f15, $f17
    fmul    $f4, $f17, $f17
    fmul    $f12, $f1, $f1
    fmul    $f10, $f8, $f8
    fsub    $f1, $f8, $f1
    fmul    $f1, $f1, $f8
    fmul    $f7, $f8, $f8
    fadd    $f17, $f8, $f8
    fmul    $f9, $f11, $f9
    fmul    $f9, $f9, $f10
    fmul    $f14, $f10, $f10
    fadd    $f8, $f10, $f8
    store   $f8, [$i11 + 2]
    fmul    $f4, $f13, $f8
    fmul    $f8, $f15, $f8
    fmul    $f7, $f3, $f10
    fmul    $f10, $f1, $f10
    fadd    $f8, $f10, $f8
    fmul    $f14, $f16, $f10
    fmul    $f10, $f9, $f10
    fadd    $f8, $f10, $f8
    fmul    $fc10, $f8, $f8
    store   $f8, [$i15 + 0]
    fmul    $f4, $f2, $f2
    fmul    $f2, $f15, $f4
    fmul    $f7, $f5, $f5
    fmul    $f5, $f1, $f1
    fadd    $f4, $f1, $f1
    fmul    $f14, $f6, $f4
    fmul    $f4, $f9, $f6
    fadd    $f1, $f6, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 1]
    fmul    $f2, $f13, $f1
    fmul    $f5, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f4, $f16, $f2
    fadd    $f1, $f2, $f1
    fmul    $fc10, $f1, $f1
    store   $f1, [$i15 + 2]
    li      1, $i1
    jr      $ra1
.end read_nth_object

######################################################################
# read_object($i16)
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_object
read_object.2721:
    bl      $i16, 60, bge_else.21706    # |         18 |         18 |
bge_then.21706:
    jr      $ra2
bge_else.21706:
.count move_args
    mov     $i16, $i6                   # |         18 |         18 |
    jal     read_nth_object.2719, $ra1  # |         18 |         18 |
    bne     $i1, 0, be_else.21707       # |         18 |         18 |
be_then.21707:
    mov     $i16, $ig0                  # |          1 |          1 |
    jr      $ra2                        # |          1 |          1 |
be_else.21707:
    add     $i16, 1, $i16               # |         17 |         17 |
    b       read_object.2721            # |         17 |         17 |
.end read_object

######################################################################
# read_all_object()
# $ra = $ra2
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0]
# []
# [$ra - $ra1]
######################################################################
.begin read_all_object
read_all_object.2723:
    li      0, $i16                     # |          1 |          1 |
    b       read_object.2721            # |          1 |          1 |
.end read_all_object

######################################################################
# $i1 = read_net_item($i1)
# $ra = $ra
# [$i1 - $i5]
# []
# []
# []
# [$ra]
######################################################################
.begin read_net_item
read_net_item.2725:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |         43 |         43 |
.count stack_move
    sub     $sp, 3, $sp                 # |         43 |         43 |
.count stack_store
    store   $i1, [$sp + 1]              # |         43 |         43 |
    call    ext_read_int                # |         43 |         43 |
    bne     $i1, -1, be_else.21708      # |         43 |         43 |
be_then.21708:
.count stack_load_ra
    load    [$sp + 0], $ra              # |         14 |         14 |
.count stack_move
    add     $sp, 3, $sp                 # |         14 |         14 |
.count stack_load
    load    [$sp - 2], $i1              # |         14 |         14 |
    add     $i1, 1, $i2                 # |         14 |         14 |
    add     $i0, -1, $i3                # |         14 |         14 |
    b       ext_create_array_int        # |         14 |         14 |
be_else.21708:
.count stack_store
    store   $i1, [$sp + 2]              # |         29 |         29 |
.count stack_load
    load    [$sp + 1], $i1              # |         29 |         29 |
    add     $i1, 1, $i1                 # |         29 |         29 |
    call    read_net_item.2725          # |         29 |         29 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |         29 |         29 |
.count stack_move
    add     $sp, 3, $sp                 # |         29 |         29 |
.count stack_load
    load    [$sp - 2], $i2              # |         29 |         29 |
.count stack_load
    load    [$sp - 1], $i3              # |         29 |         29 |
.count storer
    add     $i1, $i2, $tmp              # |         29 |         29 |
    store   $i3, [$tmp + 0]             # |         29 |         29 |
    ret                                 # |         29 |         29 |
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
.begin read_or_network
read_or_network.2727:
.count stack_store_ra
    store   $ra, [$sp - 3]              # |          3 |          3 |
.count stack_move
    sub     $sp, 3, $sp                 # |          3 |          3 |
.count stack_store
    store   $i1, [$sp + 1]              # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    call    read_net_item.2725          # |          3 |          3 |
    load    [$i1 + 0], $i2              # |          3 |          3 |
    bne     $i2, -1, be_else.21709      # |          3 |          3 |
be_then.21709:
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 3, $sp                 # |          1 |          1 |
.count stack_load
    load    [$sp - 2], $i2              # |          1 |          1 |
    add     $i2, 1, $i2                 # |          1 |          1 |
.count move_args
    mov     $i1, $i3                    # |          1 |          1 |
    b       ext_create_array_int        # |          1 |          1 |
be_else.21709:
.count stack_store
    store   $i1, [$sp + 2]              # |          2 |          2 |
.count stack_load
    load    [$sp + 1], $i1              # |          2 |          2 |
    add     $i1, 1, $i1                 # |          2 |          2 |
    call    read_or_network.2727        # |          2 |          2 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          2 |          2 |
.count stack_move
    add     $sp, 3, $sp                 # |          2 |          2 |
.count stack_load
    load    [$sp - 2], $i2              # |          2 |          2 |
.count stack_load
    load    [$sp - 1], $i3              # |          2 |          2 |
.count storer
    add     $i1, $i2, $tmp              # |          2 |          2 |
    store   $i3, [$tmp + 0]             # |          2 |          2 |
    ret                                 # |          2 |          2 |
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
.begin read_and_network
read_and_network.2729:
    li      0, $i1                      # |         11 |         11 |
    call    read_net_item.2725          # |         11 |         11 |
    load    [$i1 + 0], $i2              # |         11 |         11 |
    bne     $i2, -1, be_else.21710      # |         11 |         11 |
be_then.21710:
    jr      $ra1                        # |          1 |          1 |
be_else.21710:
    store   $i1, [ext_and_net + $i6]    # |         10 |         10 |
    add     $i6, 1, $i6                 # |         10 |         10 |
    b       read_and_network.2729       # |         10 |         10 |
.end read_and_network

######################################################################
# read_parameter()
# $ra = $ra3
# [$i1 - $i16]
# [$f1 - $f17]
# [$ig0 - $ig1]
# [$fg12 - $fg14, $fg20 - $fg24]
# [$ra - $ra2]
######################################################################
.begin read_parameter
read_parameter.2731:
    jal     read_screen_settings.2712, $ra1# |          1 |          1 |
    jal     read_light.2714, $ra1       # |          1 |          1 |
    jal     read_all_object.2723, $ra2  # |          1 |          1 |
    li      0, $i6                      # |          1 |          1 |
    jal     read_and_network.2729, $ra1 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    call    read_or_network.2727        # |          1 |          1 |
.count move_ret
    mov     $i1, $ig1                   # |          1 |          1 |
    jr      $ra3                        # |          1 |          1 |
.end read_parameter

######################################################################
# $i1 = solver($i1, $i2)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f13]
# []
# [$fg0]
# []
######################################################################
.begin solver
solver.2773:
    load    [ext_objects + $i1], $i1    # |     23,754 |     23,754 |
    load    [$i1 + 5], $i3              # |     23,754 |     23,754 |
    load    [$i1 + 1], $i4              # |     23,754 |     23,754 |
    load    [$i3 + 0], $f1              # |     23,754 |     23,754 |
    load    [$i3 + 1], $f2              # |     23,754 |     23,754 |
    load    [$i3 + 2], $f3              # |     23,754 |     23,754 |
    fsub    $fg17, $f1, $f1             # |     23,754 |     23,754 |
    fsub    $fg18, $f2, $f2             # |     23,754 |     23,754 |
    fsub    $fg19, $f3, $f3             # |     23,754 |     23,754 |
    load    [$i2 + 0], $f4              # |     23,754 |     23,754 |
    bne     $i4, 1, be_else.21711       # |     23,754 |     23,754 |
be_then.21711:
    bne     $f4, $f0, be_else.21712     # |     23,754 |     23,754 |
be_then.21712:
    li      0, $i3
.count b_cont
    b       be_cont.21712
be_else.21712:
    load    [$i1 + 4], $i3              # |     23,754 |     23,754 |
    load    [$i3 + 1], $f5              # |     23,754 |     23,754 |
    load    [$i2 + 1], $f6              # |     23,754 |     23,754 |
    load    [$i1 + 6], $i4              # |     23,754 |     23,754 |
    bg      $f0, $f4, ble_else.21713    # |     23,754 |     23,754 |
ble_then.21713:
    li      0, $i5                      # |     23,580 |     23,580 |
.count b_cont
    b       ble_cont.21713              # |     23,580 |     23,580 |
ble_else.21713:
    li      1, $i5                      # |        174 |        174 |
ble_cont.21713:
    bne     $i4, 0, be_else.21714       # |     23,754 |     23,754 |
be_then.21714:
    mov     $i5, $i4                    # |     23,754 |     23,754 |
.count b_cont
    b       be_cont.21714               # |     23,754 |     23,754 |
be_else.21714:
    bne     $i5, 0, be_else.21715
be_then.21715:
    li      1, $i4
.count b_cont
    b       be_cont.21715
be_else.21715:
    li      0, $i4
be_cont.21715:
be_cont.21714:
    load    [$i3 + 0], $f7              # |     23,754 |     23,754 |
    bne     $i4, 0, be_cont.21716       # |     23,754 |     23,754 |
be_then.21716:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |
be_cont.21716:
    fsub    $f7, $f1, $f7               # |     23,754 |     23,754 |
    finv    $f4, $f4                    # |     23,754 |     23,754 |
    fmul    $f7, $f4, $f4               # |     23,754 |     23,754 |
    fmul    $f4, $f6, $f6               # |     23,754 |     23,754 |
    fadd_a  $f6, $f2, $f6               # |     23,754 |     23,754 |
    bg      $f5, $f6, ble_else.21717    # |     23,754 |     23,754 |
ble_then.21717:
    li      0, $i3                      # |     14,964 |     14,964 |
.count b_cont
    b       ble_cont.21717              # |     14,964 |     14,964 |
ble_else.21717:
    load    [$i3 + 2], $f5              # |      8,790 |      8,790 |
    load    [$i2 + 2], $f6              # |      8,790 |      8,790 |
    fmul    $f4, $f6, $f6               # |      8,790 |      8,790 |
    fadd_a  $f6, $f3, $f6               # |      8,790 |      8,790 |
    bg      $f5, $f6, ble_else.21718    # |      8,790 |      8,790 |
ble_then.21718:
    li      0, $i3                      # |      5,123 |      5,123 |
.count b_cont
    b       ble_cont.21718              # |      5,123 |      5,123 |
ble_else.21718:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |
    li      1, $i3                      # |      3,667 |      3,667 |
ble_cont.21718:
ble_cont.21717:
be_cont.21712:
    bne     $i3, 0, be_else.21719       # |     23,754 |     23,754 |
be_then.21719:
    load    [$i2 + 1], $f4              # |     20,087 |     20,087 |
    bne     $f4, $f0, be_else.21720     # |     20,087 |     20,087 |
be_then.21720:
    li      0, $i3
.count b_cont
    b       be_cont.21720
be_else.21720:
    load    [$i1 + 4], $i3              # |     20,087 |     20,087 |
    load    [$i3 + 2], $f5              # |     20,087 |     20,087 |
    load    [$i2 + 2], $f6              # |     20,087 |     20,087 |
    load    [$i1 + 6], $i4              # |     20,087 |     20,087 |
    bg      $f0, $f4, ble_else.21721    # |     20,087 |     20,087 |
ble_then.21721:
    li      0, $i5                      # |         38 |         38 |
.count b_cont
    b       ble_cont.21721              # |         38 |         38 |
ble_else.21721:
    li      1, $i5                      # |     20,049 |     20,049 |
ble_cont.21721:
    bne     $i4, 0, be_else.21722       # |     20,087 |     20,087 |
be_then.21722:
    mov     $i5, $i4                    # |     20,087 |     20,087 |
.count b_cont
    b       be_cont.21722               # |     20,087 |     20,087 |
be_else.21722:
    bne     $i5, 0, be_else.21723
be_then.21723:
    li      1, $i4
.count b_cont
    b       be_cont.21723
be_else.21723:
    li      0, $i4
be_cont.21723:
be_cont.21722:
    load    [$i3 + 1], $f7              # |     20,087 |     20,087 |
    bne     $i4, 0, be_cont.21724       # |     20,087 |     20,087 |
be_then.21724:
    fneg    $f7, $f7                    # |         38 |         38 |
be_cont.21724:
    fsub    $f7, $f2, $f7               # |     20,087 |     20,087 |
    finv    $f4, $f4                    # |     20,087 |     20,087 |
    fmul    $f7, $f4, $f4               # |     20,087 |     20,087 |
    fmul    $f4, $f6, $f6               # |     20,087 |     20,087 |
    fadd_a  $f6, $f3, $f6               # |     20,087 |     20,087 |
    bg      $f5, $f6, ble_else.21725    # |     20,087 |     20,087 |
ble_then.21725:
    li      0, $i3                      # |     16,512 |     16,512 |
.count b_cont
    b       ble_cont.21725              # |     16,512 |     16,512 |
ble_else.21725:
    load    [$i3 + 0], $f5              # |      3,575 |      3,575 |
    load    [$i2 + 0], $f6              # |      3,575 |      3,575 |
    fmul    $f4, $f6, $f6               # |      3,575 |      3,575 |
    fadd_a  $f6, $f1, $f6               # |      3,575 |      3,575 |
    bg      $f5, $f6, ble_else.21726    # |      3,575 |      3,575 |
ble_then.21726:
    li      0, $i3                      # |      2,631 |      2,631 |
.count b_cont
    b       ble_cont.21726              # |      2,631 |      2,631 |
ble_else.21726:
    mov     $f4, $fg0                   # |        944 |        944 |
    li      1, $i3                      # |        944 |        944 |
ble_cont.21726:
ble_cont.21725:
be_cont.21720:
    bne     $i3, 0, be_else.21727       # |     20,087 |     20,087 |
be_then.21727:
    load    [$i2 + 2], $f4              # |     19,143 |     19,143 |
    bne     $f4, $f0, be_else.21728     # |     19,143 |     19,143 |
be_then.21728:
    li      0, $i1
    ret
be_else.21728:
    load    [$i1 + 4], $i3              # |     19,143 |     19,143 |
    load    [$i1 + 6], $i1              # |     19,143 |     19,143 |
    load    [$i3 + 0], $f5              # |     19,143 |     19,143 |
    load    [$i2 + 0], $f6              # |     19,143 |     19,143 |
    bg      $f0, $f4, ble_else.21729    # |     19,143 |     19,143 |
ble_then.21729:
    li      0, $i4                      # |     12,429 |     12,429 |
.count b_cont
    b       ble_cont.21729              # |     12,429 |     12,429 |
ble_else.21729:
    li      1, $i4                      # |      6,714 |      6,714 |
ble_cont.21729:
    bne     $i1, 0, be_else.21730       # |     19,143 |     19,143 |
be_then.21730:
    mov     $i4, $i1                    # |     19,143 |     19,143 |
.count b_cont
    b       be_cont.21730               # |     19,143 |     19,143 |
be_else.21730:
    bne     $i4, 0, be_else.21731
be_then.21731:
    li      1, $i1
.count b_cont
    b       be_cont.21731
be_else.21731:
    li      0, $i1
be_cont.21731:
be_cont.21730:
    load    [$i3 + 2], $f7              # |     19,143 |     19,143 |
    bne     $i1, 0, be_cont.21732       # |     19,143 |     19,143 |
be_then.21732:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |
be_cont.21732:
    fsub    $f7, $f3, $f3               # |     19,143 |     19,143 |
    finv    $f4, $f4                    # |     19,143 |     19,143 |
    fmul    $f3, $f4, $f3               # |     19,143 |     19,143 |
    fmul    $f3, $f6, $f4               # |     19,143 |     19,143 |
    fadd_a  $f4, $f1, $f1               # |     19,143 |     19,143 |
    bg      $f5, $f1, ble_else.21733    # |     19,143 |     19,143 |
ble_then.21733:
    li      0, $i1                      # |     15,261 |     15,261 |
    ret                                 # |     15,261 |     15,261 |
ble_else.21733:
    load    [$i3 + 1], $f1              # |      3,882 |      3,882 |
    load    [$i2 + 1], $f4              # |      3,882 |      3,882 |
    fmul    $f3, $f4, $f4               # |      3,882 |      3,882 |
    fadd_a  $f4, $f2, $f2               # |      3,882 |      3,882 |
    bg      $f1, $f2, ble_else.21734    # |      3,882 |      3,882 |
ble_then.21734:
    li      0, $i1                      # |      1,717 |      1,717 |
    ret                                 # |      1,717 |      1,717 |
ble_else.21734:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |
    li      3, $i1                      # |      2,165 |      2,165 |
    ret                                 # |      2,165 |      2,165 |
be_else.21727:
    li      2, $i1                      # |        944 |        944 |
    ret                                 # |        944 |        944 |
be_else.21719:
    li      1, $i1                      # |      3,667 |      3,667 |
    ret                                 # |      3,667 |      3,667 |
be_else.21711:
    bne     $i4, 2, be_else.21735
be_then.21735:
    load    [$i1 + 4], $i1
    load    [$i1 + 0], $f5
    fmul    $f4, $f5, $f4
    load    [$i2 + 1], $f6
    load    [$i1 + 1], $f7
    fmul    $f6, $f7, $f6
    fadd    $f4, $f6, $f4
    load    [$i2 + 2], $f6
    load    [$i1 + 2], $f8
    fmul    $f6, $f8, $f6
    fadd    $f4, $f6, $f4
    bg      $f4, $f0, ble_else.21736
ble_then.21736:
    li      0, $i1
    ret
ble_else.21736:
    fmul    $f5, $f1, $f1
    fmul    $f7, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f8, $f3, $f2
    fadd_n  $f1, $f2, $f1
    finv    $f4, $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.21735:
    load    [$i1 + 4], $i3
    load    [$i1 + 3], $i5
    load    [$i2 + 1], $f5
    load    [$i2 + 2], $f6
    fmul    $f4, $f4, $f7
    load    [$i3 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f9
    load    [$i3 + 1], $f10
    fmul    $f9, $f10, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f6, $f9
    load    [$i3 + 2], $f11
    fmul    $f9, $f11, $f9
    fadd    $f7, $f9, $f7
    be      $i5, 0, bne_cont.21737
bne_then.21737:
    fmul    $f5, $f6, $f9
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i2 + 1], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i2 + 2], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
bne_cont.21737:
    bne     $f7, $f0, be_else.21738
be_then.21738:
    li      0, $i1
    ret
be_else.21738:
    fmul    $f4, $f1, $f9
    fmul    $f9, $f8, $f9
    fmul    $f5, $f2, $f12
    fmul    $f12, $f10, $f12
    fadd    $f9, $f12, $f9
    fmul    $f6, $f3, $f12
    fmul    $f12, $f11, $f12
    fadd    $f9, $f12, $f9
    bne     $i5, 0, be_else.21739
be_then.21739:
    mov     $f9, $f4
.count b_cont
    b       be_cont.21739
be_else.21739:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i2 + 1], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i2 + 2], $f5
    fmul    $f4, $f5, $f4
    fadd    $f6, $f4, $f4
    fmul    $f4, $fc4, $f4
    fadd    $f9, $f4, $f4
be_cont.21739:
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    bne     $i5, 0, be_else.21740
be_then.21740:
    mov     $f6, $f1
.count b_cont
    b       be_cont.21740
be_else.21740:
    fmul    $f2, $f3, $f8
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21740:
    bne     $i4, 3, be_cont.21741
be_then.21741:
    fsub    $f1, $fc0, $f1
be_cont.21741:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, ble_else.21742
ble_then.21742:
    li      0, $i1
    ret
ble_else.21742:
    load    [$i1 + 6], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    bne     $i1, 0, be_else.21743
be_then.21743:
    fneg    $f1, $f1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.21743:
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver

######################################################################
# $i1 = solver_fast($i1)
# $ra = $ra
# [$i1 - $i5]
# [$f1 - $f9]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast
solver_fast.2796:
    load    [ext_objects + $i1], $i2    # |    660,729 |    660,729 |
    load    [$i2 + 5], $i3              # |    660,729 |    660,729 |
    load    [ext_light_dirvec + 1], $i4 # |    660,729 |    660,729 |
    load    [$i2 + 1], $i5              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 0], $f1# |    660,729 |    660,729 |
    load    [$i3 + 0], $f2              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 1], $f3# |    660,729 |    660,729 |
    load    [$i3 + 1], $f4              # |    660,729 |    660,729 |
    load    [ext_intersection_point + 2], $f5# |    660,729 |    660,729 |
    load    [$i3 + 2], $f6              # |    660,729 |    660,729 |
    fsub    $f1, $f2, $f1               # |    660,729 |    660,729 |
    fsub    $f3, $f4, $f2               # |    660,729 |    660,729 |
    fsub    $f5, $f6, $f3               # |    660,729 |    660,729 |
    load    [$i4 + $i1], $i1            # |    660,729 |    660,729 |
    bne     $i5, 1, be_else.21744       # |    660,729 |    660,729 |
be_then.21744:
    load    [ext_light_dirvec + 0], $i3 # |    660,729 |    660,729 |
    load    [$i2 + 4], $i2              # |    660,729 |    660,729 |
    load    [$i2 + 1], $f4              # |    660,729 |    660,729 |
    load    [$i3 + 1], $f5              # |    660,729 |    660,729 |
    load    [$i1 + 0], $f6              # |    660,729 |    660,729 |
    fsub    $f6, $f1, $f6               # |    660,729 |    660,729 |
    load    [$i1 + 1], $f7              # |    660,729 |    660,729 |
    fmul    $f6, $f7, $f6               # |    660,729 |    660,729 |
    fmul    $f6, $f5, $f5               # |    660,729 |    660,729 |
    fadd_a  $f5, $f2, $f5               # |    660,729 |    660,729 |
    bg      $f4, $f5, ble_else.21745    # |    660,729 |    660,729 |
ble_then.21745:
    li      0, $i4                      # |    437,594 |    437,594 |
.count b_cont
    b       ble_cont.21745              # |    437,594 |    437,594 |
ble_else.21745:
    load    [$i2 + 2], $f5              # |    223,135 |    223,135 |
    load    [$i3 + 2], $f7              # |    223,135 |    223,135 |
    fmul    $f6, $f7, $f7               # |    223,135 |    223,135 |
    fadd_a  $f7, $f3, $f7               # |    223,135 |    223,135 |
    bg      $f5, $f7, ble_else.21746    # |    223,135 |    223,135 |
ble_then.21746:
    li      0, $i4                      # |     76,258 |     76,258 |
.count b_cont
    b       ble_cont.21746              # |     76,258 |     76,258 |
ble_else.21746:
    load    [$i1 + 1], $f5              # |    146,877 |    146,877 |
    bne     $f5, $f0, be_else.21747     # |    146,877 |    146,877 |
be_then.21747:
    li      0, $i4
.count b_cont
    b       be_cont.21747
be_else.21747:
    li      1, $i4                      # |    146,877 |    146,877 |
be_cont.21747:
ble_cont.21746:
ble_cont.21745:
    bne     $i4, 0, be_else.21748       # |    660,729 |    660,729 |
be_then.21748:
    load    [$i2 + 0], $f5              # |    513,852 |    513,852 |
    load    [$i3 + 0], $f6              # |    513,852 |    513,852 |
    load    [$i1 + 2], $f7              # |    513,852 |    513,852 |
    fsub    $f7, $f2, $f7               # |    513,852 |    513,852 |
    load    [$i1 + 3], $f8              # |    513,852 |    513,852 |
    fmul    $f7, $f8, $f7               # |    513,852 |    513,852 |
    fmul    $f7, $f6, $f6               # |    513,852 |    513,852 |
    fadd_a  $f6, $f1, $f6               # |    513,852 |    513,852 |
    bg      $f5, $f6, ble_else.21749    # |    513,852 |    513,852 |
ble_then.21749:
    li      0, $i2                      # |    438,821 |    438,821 |
.count b_cont
    b       ble_cont.21749              # |    438,821 |    438,821 |
ble_else.21749:
    load    [$i2 + 2], $f6              # |     75,031 |     75,031 |
    load    [$i3 + 2], $f8              # |     75,031 |     75,031 |
    fmul    $f7, $f8, $f8               # |     75,031 |     75,031 |
    fadd_a  $f8, $f3, $f8               # |     75,031 |     75,031 |
    bg      $f6, $f8, ble_else.21750    # |     75,031 |     75,031 |
ble_then.21750:
    li      0, $i2                      # |     40,195 |     40,195 |
.count b_cont
    b       ble_cont.21750              # |     40,195 |     40,195 |
ble_else.21750:
    load    [$i1 + 3], $f6              # |     34,836 |     34,836 |
    bne     $f6, $f0, be_else.21751     # |     34,836 |     34,836 |
be_then.21751:
    li      0, $i2
.count b_cont
    b       be_cont.21751
be_else.21751:
    li      1, $i2                      # |     34,836 |     34,836 |
be_cont.21751:
ble_cont.21750:
ble_cont.21749:
    bne     $i2, 0, be_else.21752       # |    513,852 |    513,852 |
be_then.21752:
    load    [$i3 + 0], $f6              # |    479,016 |    479,016 |
    load    [$i1 + 4], $f7              # |    479,016 |    479,016 |
    fsub    $f7, $f3, $f3               # |    479,016 |    479,016 |
    load    [$i1 + 5], $f7              # |    479,016 |    479,016 |
    fmul    $f3, $f7, $f3               # |    479,016 |    479,016 |
    fmul    $f3, $f6, $f6               # |    479,016 |    479,016 |
    fadd_a  $f6, $f1, $f1               # |    479,016 |    479,016 |
    bg      $f5, $f1, ble_else.21753    # |    479,016 |    479,016 |
ble_then.21753:
    li      0, $i1                      # |    447,010 |    447,010 |
    ret                                 # |    447,010 |    447,010 |
ble_else.21753:
    load    [$i3 + 1], $f1              # |     32,006 |     32,006 |
    fmul    $f3, $f1, $f1               # |     32,006 |     32,006 |
    fadd_a  $f1, $f2, $f1               # |     32,006 |     32,006 |
    bg      $f4, $f1, ble_else.21754    # |     32,006 |     32,006 |
ble_then.21754:
    li      0, $i1                      # |      7,652 |      7,652 |
    ret                                 # |      7,652 |      7,652 |
ble_else.21754:
    load    [$i1 + 5], $f1              # |     24,354 |     24,354 |
    bne     $f1, $f0, be_else.21755     # |     24,354 |     24,354 |
be_then.21755:
    li      0, $i1
    ret
be_else.21755:
    mov     $f3, $fg0                   # |     24,354 |     24,354 |
    li      3, $i1                      # |     24,354 |     24,354 |
    ret                                 # |     24,354 |     24,354 |
be_else.21752:
    mov     $f7, $fg0                   # |     34,836 |     34,836 |
    li      2, $i1                      # |     34,836 |     34,836 |
    ret                                 # |     34,836 |     34,836 |
be_else.21748:
    mov     $f6, $fg0                   # |    146,877 |    146,877 |
    li      1, $i1                      # |    146,877 |    146,877 |
    ret                                 # |    146,877 |    146,877 |
be_else.21744:
    load    [$i1 + 0], $f4
    bne     $i5, 2, be_else.21756
be_then.21756:
    bg      $f0, $f4, ble_else.21757
ble_then.21757:
    li      0, $i1
    ret
ble_else.21757:
    load    [$i1 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 2], $f4
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.21756:
    bne     $f4, $f0, be_else.21758
be_then.21758:
    li      0, $i1
    ret
be_else.21758:
    load    [$i2 + 4], $i3
    load    [$i2 + 3], $i4
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f5
    load    [$i1 + 2], $f6
    fmul    $f6, $f2, $f6
    fadd    $f5, $f6, $f5
    load    [$i1 + 3], $f6
    fmul    $f6, $f3, $f6
    fadd    $f5, $f6, $f5
    fmul    $f5, $f5, $f6
    fmul    $f1, $f1, $f7
    load    [$i3 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f2, $f2, $f8
    load    [$i3 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i3 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i4, 0, be_else.21759
be_then.21759:
    mov     $f7, $f1
.count b_cont
    b       be_cont.21759
be_else.21759:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i3
    load    [$i3 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i3 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21759:
    bne     $i5, 3, be_cont.21760
be_then.21760:
    fsub    $f1, $fc0, $f1
be_cont.21760:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, ble_else.21761
ble_then.21761:
    li      0, $i1
    ret
ble_else.21761:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, be_else.21762
be_then.21762:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret
be_else.21762:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret
.end solver_fast

######################################################################
# $i1 = solver_fast2($i1, $i2)
# $ra = $ra
# [$i1 - $i6]
# [$f1 - $f8]
# []
# [$fg0]
# []
######################################################################
.begin solver_fast2
solver_fast2.2814:
    load    [ext_objects + $i1], $i3    # |  1,134,616 |  1,134,616 |
    load    [$i3 + 10], $i4             # |  1,134,616 |  1,134,616 |
    load    [$i2 + 1], $i5              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 1], $i6              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 0], $f1              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 1], $f2              # |  1,134,616 |  1,134,616 |
    load    [$i4 + 2], $f3              # |  1,134,616 |  1,134,616 |
    load    [$i5 + $i1], $i1            # |  1,134,616 |  1,134,616 |
    bne     $i6, 1, be_else.21763       # |  1,134,616 |  1,134,616 |
be_then.21763:
    load    [$i2 + 0], $i2              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 4], $i3              # |  1,134,616 |  1,134,616 |
    load    [$i3 + 1], $f4              # |  1,134,616 |  1,134,616 |
    load    [$i2 + 1], $f5              # |  1,134,616 |  1,134,616 |
    load    [$i1 + 0], $f6              # |  1,134,616 |  1,134,616 |
    fsub    $f6, $f1, $f6               # |  1,134,616 |  1,134,616 |
    load    [$i1 + 1], $f7              # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f7, $f6               # |  1,134,616 |  1,134,616 |
    fmul    $f6, $f5, $f5               # |  1,134,616 |  1,134,616 |
    fadd_a  $f5, $f2, $f5               # |  1,134,616 |  1,134,616 |
    bg      $f4, $f5, ble_else.21764    # |  1,134,616 |  1,134,616 |
ble_then.21764:
    li      0, $i4                      # |    640,181 |    640,181 |
.count b_cont
    b       ble_cont.21764              # |    640,181 |    640,181 |
ble_else.21764:
    load    [$i3 + 2], $f5              # |    494,435 |    494,435 |
    load    [$i2 + 2], $f7              # |    494,435 |    494,435 |
    fmul    $f6, $f7, $f7               # |    494,435 |    494,435 |
    fadd_a  $f7, $f3, $f7               # |    494,435 |    494,435 |
    bg      $f5, $f7, ble_else.21765    # |    494,435 |    494,435 |
ble_then.21765:
    li      0, $i4                      # |    164,440 |    164,440 |
.count b_cont
    b       ble_cont.21765              # |    164,440 |    164,440 |
ble_else.21765:
    load    [$i1 + 1], $f5              # |    329,995 |    329,995 |
    bne     $f5, $f0, be_else.21766     # |    329,995 |    329,995 |
be_then.21766:
    li      0, $i4
.count b_cont
    b       be_cont.21766
be_else.21766:
    li      1, $i4                      # |    329,995 |    329,995 |
be_cont.21766:
ble_cont.21765:
ble_cont.21764:
    bne     $i4, 0, be_else.21767       # |  1,134,616 |  1,134,616 |
be_then.21767:
    load    [$i3 + 0], $f5              # |    804,621 |    804,621 |
    load    [$i2 + 0], $f6              # |    804,621 |    804,621 |
    load    [$i1 + 2], $f7              # |    804,621 |    804,621 |
    fsub    $f7, $f2, $f7               # |    804,621 |    804,621 |
    load    [$i1 + 3], $f8              # |    804,621 |    804,621 |
    fmul    $f7, $f8, $f7               # |    804,621 |    804,621 |
    fmul    $f7, $f6, $f6               # |    804,621 |    804,621 |
    fadd_a  $f6, $f1, $f6               # |    804,621 |    804,621 |
    bg      $f5, $f6, ble_else.21768    # |    804,621 |    804,621 |
ble_then.21768:
    li      0, $i3                      # |    453,639 |    453,639 |
.count b_cont
    b       ble_cont.21768              # |    453,639 |    453,639 |
ble_else.21768:
    load    [$i3 + 2], $f6              # |    350,982 |    350,982 |
    load    [$i2 + 2], $f8              # |    350,982 |    350,982 |
    fmul    $f7, $f8, $f8               # |    350,982 |    350,982 |
    fadd_a  $f8, $f3, $f8               # |    350,982 |    350,982 |
    bg      $f6, $f8, ble_else.21769    # |    350,982 |    350,982 |
ble_then.21769:
    li      0, $i3                      # |    123,655 |    123,655 |
.count b_cont
    b       ble_cont.21769              # |    123,655 |    123,655 |
ble_else.21769:
    load    [$i1 + 3], $f6              # |    227,327 |    227,327 |
    bne     $f6, $f0, be_else.21770     # |    227,327 |    227,327 |
be_then.21770:
    li      0, $i3
.count b_cont
    b       be_cont.21770
be_else.21770:
    li      1, $i3                      # |    227,327 |    227,327 |
be_cont.21770:
ble_cont.21769:
ble_cont.21768:
    bne     $i3, 0, be_else.21771       # |    804,621 |    804,621 |
be_then.21771:
    load    [$i2 + 0], $f6              # |    577,294 |    577,294 |
    load    [$i1 + 4], $f7              # |    577,294 |    577,294 |
    fsub    $f7, $f3, $f3               # |    577,294 |    577,294 |
    load    [$i1 + 5], $f7              # |    577,294 |    577,294 |
    fmul    $f3, $f7, $f3               # |    577,294 |    577,294 |
    fmul    $f3, $f6, $f6               # |    577,294 |    577,294 |
    fadd_a  $f6, $f1, $f1               # |    577,294 |    577,294 |
    bg      $f5, $f1, ble_else.21772    # |    577,294 |    577,294 |
ble_then.21772:
    li      0, $i1                      # |    412,314 |    412,314 |
    ret                                 # |    412,314 |    412,314 |
ble_else.21772:
    load    [$i2 + 1], $f1              # |    164,980 |    164,980 |
    fmul    $f3, $f1, $f1               # |    164,980 |    164,980 |
    fadd_a  $f1, $f2, $f1               # |    164,980 |    164,980 |
    bg      $f4, $f1, ble_else.21773    # |    164,980 |    164,980 |
ble_then.21773:
    li      0, $i1                      # |     37,478 |     37,478 |
    ret                                 # |     37,478 |     37,478 |
ble_else.21773:
    load    [$i1 + 5], $f1              # |    127,502 |    127,502 |
    bne     $f1, $f0, be_else.21774     # |    127,502 |    127,502 |
be_then.21774:
    li      0, $i1
    ret
be_else.21774:
    mov     $f3, $fg0                   # |    127,502 |    127,502 |
    li      3, $i1                      # |    127,502 |    127,502 |
    ret                                 # |    127,502 |    127,502 |
be_else.21771:
    mov     $f7, $fg0                   # |    227,327 |    227,327 |
    li      2, $i1                      # |    227,327 |    227,327 |
    ret                                 # |    227,327 |    227,327 |
be_else.21767:
    mov     $f6, $fg0                   # |    329,995 |    329,995 |
    li      1, $i1                      # |    329,995 |    329,995 |
    ret                                 # |    329,995 |    329,995 |
be_else.21763:
    bne     $i6, 2, be_else.21775
be_then.21775:
    load    [$i1 + 0], $f1
    bg      $f0, $f1, ble_else.21776
ble_then.21776:
    li      0, $i1
    ret
ble_else.21776:
    load    [$i4 + 3], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.21775:
    load    [$i1 + 0], $f4
    bne     $f4, $f0, be_else.21777
be_then.21777:
    li      0, $i1
    ret
be_else.21777:
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f1
    load    [$i1 + 2], $f5
    fmul    $f5, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $f1, $f2
    load    [$i4 + 3], $f3
    fmul    $f4, $f3, $f3
    fsub    $f2, $f3, $f2
    bg      $f2, $f0, ble_else.21778
ble_then.21778:
    li      0, $i1
    ret
ble_else.21778:
    load    [$i3 + 6], $i2
    fsqrt   $f2, $f2
    bne     $i2, 0, be_else.21779
be_then.21779:
    fsub    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
be_else.21779:
    fadd    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret
.end solver_fast2

######################################################################
# $i1 = setup_rect_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f2]
# []
# []
# [$ra]
######################################################################
.begin setup_rect_table
setup_rect_table.2817:
    li      6, $i2                      # |      3,612 |      3,612 |
.count move_args
    mov     $f0, $f2                    # |      3,612 |      3,612 |
    call    ext_create_array_float      # |      3,612 |      3,612 |
    load    [$i4 + 0], $f1              # |      3,612 |      3,612 |
    bne     $f1, $f0, be_else.21780     # |      3,612 |      3,612 |
be_then.21780:
    store   $f0, [$i1 + 1]
.count b_cont
    b       be_cont.21780
be_else.21780:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    bg      $f0, $f1, ble_else.21781    # |      3,612 |      3,612 |
ble_then.21781:
    li      0, $i3                      # |      1,806 |      1,806 |
.count b_cont
    b       ble_cont.21781              # |      1,806 |      1,806 |
ble_else.21781:
    li      1, $i3                      # |      1,806 |      1,806 |
ble_cont.21781:
    bne     $i2, 0, be_else.21782       # |      3,612 |      3,612 |
be_then.21782:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
.count b_cont
    b       be_cont.21782               # |      3,612 |      3,612 |
be_else.21782:
    bne     $i3, 0, be_else.21783
be_then.21783:
    li      1, $i2
.count b_cont
    b       be_cont.21783
be_else.21783:
    li      0, $i2
be_cont.21783:
be_cont.21782:
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    load    [$i3 + 0], $f1              # |      3,612 |      3,612 |
    bne     $i2, 0, be_else.21784       # |      3,612 |      3,612 |
be_then.21784:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
.count b_cont
    b       be_cont.21784               # |      1,806 |      1,806 |
be_else.21784:
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
be_cont.21784:
be_cont.21780:
    load    [$i4 + 1], $f1              # |      3,612 |      3,612 |
    bne     $f1, $f0, be_else.21785     # |      3,612 |      3,612 |
be_then.21785:
    store   $f0, [$i1 + 3]
.count b_cont
    b       be_cont.21785
be_else.21785:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    bg      $f0, $f1, ble_else.21786    # |      3,612 |      3,612 |
ble_then.21786:
    li      0, $i3                      # |      1,806 |      1,806 |
.count b_cont
    b       ble_cont.21786              # |      1,806 |      1,806 |
ble_else.21786:
    li      1, $i3                      # |      1,806 |      1,806 |
ble_cont.21786:
    bne     $i2, 0, be_else.21787       # |      3,612 |      3,612 |
be_then.21787:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
.count b_cont
    b       be_cont.21787               # |      3,612 |      3,612 |
be_else.21787:
    bne     $i3, 0, be_else.21788
be_then.21788:
    li      1, $i2
.count b_cont
    b       be_cont.21788
be_else.21788:
    li      0, $i2
be_cont.21788:
be_cont.21787:
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    load    [$i3 + 1], $f1              # |      3,612 |      3,612 |
    bne     $i2, 0, be_else.21789       # |      3,612 |      3,612 |
be_then.21789:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
.count b_cont
    b       be_cont.21789               # |      1,806 |      1,806 |
be_else.21789:
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
be_cont.21789:
be_cont.21785:
    load    [$i4 + 2], $f1              # |      3,612 |      3,612 |
    bne     $f1, $f0, be_else.21790     # |      3,612 |      3,612 |
be_then.21790:
    store   $f0, [$i1 + 5]
    jr      $ra1
be_else.21790:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    bg      $f0, $f1, ble_else.21791    # |      3,612 |      3,612 |
ble_then.21791:
    li      0, $i5                      # |      1,812 |      1,812 |
.count b_cont
    b       ble_cont.21791              # |      1,812 |      1,812 |
ble_else.21791:
    li      1, $i5                      # |      1,800 |      1,800 |
ble_cont.21791:
    bne     $i2, 0, be_else.21792       # |      3,612 |      3,612 |
be_then.21792:
    mov     $i5, $i2                    # |      3,612 |      3,612 |
.count b_cont
    b       be_cont.21792               # |      3,612 |      3,612 |
be_else.21792:
    bne     $i5, 0, be_else.21793
be_then.21793:
    li      1, $i2
.count b_cont
    b       be_cont.21793
be_else.21793:
    li      0, $i2
be_cont.21793:
be_cont.21792:
    load    [$i3 + 2], $f1              # |      3,612 |      3,612 |
    bne     $i2, 0, be_else.21794       # |      3,612 |      3,612 |
be_then.21794:
    fneg    $f1, $f1                    # |      1,812 |      1,812 |
    store   $f1, [$i1 + 4]              # |      1,812 |      1,812 |
    load    [$i4 + 2], $f1              # |      1,812 |      1,812 |
    finv    $f1, $f1                    # |      1,812 |      1,812 |
    store   $f1, [$i1 + 5]              # |      1,812 |      1,812 |
    jr      $ra1                        # |      1,812 |      1,812 |
be_else.21794:
    store   $f1, [$i1 + 4]              # |      1,800 |      1,800 |
    load    [$i4 + 2], $f1              # |      1,800 |      1,800 |
    finv    $f1, $f1                    # |      1,800 |      1,800 |
    store   $f1, [$i1 + 5]              # |      1,800 |      1,800 |
    jr      $ra1                        # |      1,800 |      1,800 |
.end setup_rect_table

######################################################################
# $i1 = setup_surface_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i5]
# [$f1 - $f3]
# []
# []
# [$ra]
######################################################################
.begin setup_surface_table
setup_surface_table.2820:
    li      4, $i2                      # |      1,204 |      1,204 |
.count move_args
    mov     $f0, $f2                    # |      1,204 |      1,204 |
    call    ext_create_array_float      # |      1,204 |      1,204 |
    load    [$i5 + 4], $i2              # |      1,204 |      1,204 |
    load    [$i4 + 0], $f1              # |      1,204 |      1,204 |
    load    [$i2 + 0], $f2              # |      1,204 |      1,204 |
    fmul    $f1, $f2, $f1               # |      1,204 |      1,204 |
    load    [$i4 + 1], $f2              # |      1,204 |      1,204 |
    load    [$i2 + 1], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    fadd    $f1, $f2, $f1               # |      1,204 |      1,204 |
    load    [$i4 + 2], $f2              # |      1,204 |      1,204 |
    load    [$i2 + 2], $f3              # |      1,204 |      1,204 |
    fmul    $f2, $f3, $f2               # |      1,204 |      1,204 |
    fadd    $f1, $f2, $f1               # |      1,204 |      1,204 |
    bg      $f1, $f0, ble_else.21795    # |      1,204 |      1,204 |
ble_then.21795:
    store   $f0, [$i1 + 0]              # |        601 |        601 |
    jr      $ra1                        # |        601 |        601 |
ble_else.21795:
    finv    $f1, $f1                    # |        603 |        603 |
    fneg    $f1, $f2                    # |        603 |        603 |
    store   $f2, [$i1 + 0]              # |        603 |        603 |
    load    [$i2 + 0], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |
    store   $f2, [$i1 + 1]              # |        603 |        603 |
    load    [$i2 + 1], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f2               # |        603 |        603 |
    store   $f2, [$i1 + 2]              # |        603 |        603 |
    load    [$i2 + 2], $f2              # |        603 |        603 |
    fmul_n  $f2, $f1, $f1               # |        603 |        603 |
    store   $f1, [$i1 + 3]              # |        603 |        603 |
    jr      $ra1                        # |        603 |        603 |
.end setup_surface_table

######################################################################
# $i1 = setup_second_table($i4, $i5)
# $ra = $ra1
# [$i1 - $i6]
# [$f1 - $f8]
# []
# []
# [$ra]
######################################################################
.begin setup_second_table
setup_second_table.2823:
    li      5, $i2                      # |      5,418 |      5,418 |
.count move_args
    mov     $f0, $f2                    # |      5,418 |      5,418 |
    call    ext_create_array_float      # |      5,418 |      5,418 |
    load    [$i5 + 3], $i2              # |      5,418 |      5,418 |
    load    [$i5 + 4], $i3              # |      5,418 |      5,418 |
    load    [$i4 + 0], $f1              # |      5,418 |      5,418 |
    load    [$i4 + 1], $f2              # |      5,418 |      5,418 |
    load    [$i4 + 2], $f3              # |      5,418 |      5,418 |
    fmul    $f1, $f1, $f4               # |      5,418 |      5,418 |
    load    [$i3 + 0], $f5              # |      5,418 |      5,418 |
    fmul    $f4, $f5, $f4               # |      5,418 |      5,418 |
    fmul    $f2, $f2, $f5               # |      5,418 |      5,418 |
    load    [$i3 + 1], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f5               # |      5,418 |      5,418 |
    fadd    $f4, $f5, $f4               # |      5,418 |      5,418 |
    fmul    $f3, $f3, $f5               # |      5,418 |      5,418 |
    load    [$i3 + 2], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f5               # |      5,418 |      5,418 |
    fadd    $f4, $f5, $f4               # |      5,418 |      5,418 |
    bne     $i2, 0, be_else.21796       # |      5,418 |      5,418 |
be_then.21796:
    mov     $f4, $f1                    # |      5,418 |      5,418 |
.count b_cont
    b       be_cont.21796               # |      5,418 |      5,418 |
be_else.21796:
    fmul    $f2, $f3, $f5
    load    [$i5 + 9], $i6
    load    [$i6 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i6 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i6 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21796:
    store   $f1, [$i1 + 0]              # |      5,418 |      5,418 |
    load    [$i4 + 0], $f2              # |      5,418 |      5,418 |
    load    [$i3 + 0], $f3              # |      5,418 |      5,418 |
    fmul    $f2, $f3, $f2               # |      5,418 |      5,418 |
    load    [$i4 + 1], $f3              # |      5,418 |      5,418 |
    load    [$i3 + 1], $f4              # |      5,418 |      5,418 |
    fmul    $f3, $f4, $f4               # |      5,418 |      5,418 |
    load    [$i4 + 2], $f5              # |      5,418 |      5,418 |
    load    [$i3 + 2], $f6              # |      5,418 |      5,418 |
    fmul    $f5, $f6, $f6               # |      5,418 |      5,418 |
    fneg    $f2, $f2                    # |      5,418 |      5,418 |
    fneg    $f4, $f4                    # |      5,418 |      5,418 |
    fneg    $f6, $f6                    # |      5,418 |      5,418 |
    bne     $i2, 0, be_else.21797       # |      5,418 |      5,418 |
be_then.21797:
    store   $f2, [$i1 + 1]              # |      5,418 |      5,418 |
    store   $f4, [$i1 + 2]              # |      5,418 |      5,418 |
    store   $f6, [$i1 + 3]              # |      5,418 |      5,418 |
    bne     $f1, $f0, be_else.21798     # |      5,418 |      5,418 |
be_then.21798:
    jr      $ra1
be_else.21798:
    finv    $f1, $f1                    # |      5,418 |      5,418 |
    store   $f1, [$i1 + 4]              # |      5,418 |      5,418 |
    jr      $ra1                        # |      5,418 |      5,418 |
be_else.21797:
    load    [$i5 + 9], $i2
    load    [$i2 + 1], $f7
    fmul    $f5, $f7, $f5
    load    [$i2 + 2], $f8
    fmul    $f3, $f8, $f3
    fadd    $f5, $f3, $f3
    fmul    $f3, $fc4, $f3
    fsub    $f2, $f3, $f2
    store   $f2, [$i1 + 1]
    load    [$i4 + 2], $f2
    load    [$i2 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i4 + 0], $f5
    fmul    $f5, $f8, $f5
    fadd    $f2, $f5, $f2
    fmul    $f2, $fc4, $f2
    fsub    $f4, $f2, $f2
    store   $f2, [$i1 + 2]
    load    [$i4 + 1], $f2
    fmul    $f2, $f3, $f2
    load    [$i4 + 0], $f3
    fmul    $f3, $f7, $f3
    fadd    $f2, $f3, $f2
    fmul    $f2, $fc4, $f2
    fsub    $f6, $f2, $f2
    store   $f2, [$i1 + 3]
    bne     $f1, $f0, be_else.21799
be_then.21799:
    jr      $ra1
be_else.21799:
    finv    $f1, $f1
    store   $f1, [$i1 + 4]
    jr      $ra1
.end setup_second_table

######################################################################
# iter_setup_dirvec_constants($i7, $i8)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin iter_setup_dirvec_constants
iter_setup_dirvec_constants.2826:
    bl      $i8, 0, bge_else.21800      # |     10,836 |     10,836 |
bge_then.21800:
    load    [$i7 + 1], $i9              # |     10,234 |     10,234 |
    load    [ext_objects + $i8], $i5    # |     10,234 |     10,234 |
    load    [$i5 + 1], $i1              # |     10,234 |     10,234 |
    load    [$i7 + 0], $i4              # |     10,234 |     10,234 |
    bne     $i1, 1, be_else.21801       # |     10,234 |     10,234 |
be_then.21801:
    jal     setup_rect_table.2817, $ra1 # |      3,612 |      3,612 |
.count storer
    add     $i9, $i8, $tmp              # |      3,612 |      3,612 |
    store   $i1, [$tmp + 0]             # |      3,612 |      3,612 |
    sub     $i8, 1, $i8                 # |      3,612 |      3,612 |
    b       iter_setup_dirvec_constants.2826# |      3,612 |      3,612 |
be_else.21801:
    bne     $i1, 2, be_else.21802       # |      6,622 |      6,622 |
be_then.21802:
    jal     setup_surface_table.2820, $ra1# |      1,204 |      1,204 |
.count storer
    add     $i9, $i8, $tmp              # |      1,204 |      1,204 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |
    sub     $i8, 1, $i8                 # |      1,204 |      1,204 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |
be_else.21802:
    jal     setup_second_table.2823, $ra1# |      5,418 |      5,418 |
.count storer
    add     $i9, $i8, $tmp              # |      5,418 |      5,418 |
    store   $i1, [$tmp + 0]             # |      5,418 |      5,418 |
    sub     $i8, 1, $i8                 # |      5,418 |      5,418 |
    b       iter_setup_dirvec_constants.2826# |      5,418 |      5,418 |
bge_else.21800:
    jr      $ra2                        # |        602 |        602 |
.end iter_setup_dirvec_constants

######################################################################
# setup_dirvec_constants($i7)
# $ra = $ra2
# [$i1 - $i9]
# [$f1 - $f8]
# []
# []
# [$ra - $ra1]
######################################################################
.begin setup_dirvec_constants
setup_dirvec_constants.2829:
    sub     $ig0, 1, $i8                # |        602 |        602 |
    b       iter_setup_dirvec_constants.2826# |        602 |        602 |
.end setup_dirvec_constants

######################################################################
# setup_startp_constants($i2, $i1)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f6]
# []
# []
# []
######################################################################
.begin setup_startp_constants
setup_startp_constants.2831:
    bl      $i1, 0, bge_else.21803      # |    667,764 |    667,764 |
bge_then.21803:
    load    [ext_objects + $i1], $i3    # |    630,666 |    630,666 |
    load    [$i3 + 5], $i4              # |    630,666 |    630,666 |
    load    [$i3 + 10], $i5             # |    630,666 |    630,666 |
    load    [$i2 + 0], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 0], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 0]              # |    630,666 |    630,666 |
    load    [$i2 + 1], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 1], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 1]              # |    630,666 |    630,666 |
    load    [$i2 + 2], $f1              # |    630,666 |    630,666 |
    load    [$i4 + 2], $f2              # |    630,666 |    630,666 |
    fsub    $f1, $f2, $f1               # |    630,666 |    630,666 |
    store   $f1, [$i5 + 2]              # |    630,666 |    630,666 |
    load    [$i3 + 1], $i4              # |    630,666 |    630,666 |
    bne     $i4, 2, be_else.21804       # |    630,666 |    630,666 |
be_then.21804:
    load    [$i3 + 4], $i3              # |     74,196 |     74,196 |
    load    [$i5 + 0], $f1              # |     74,196 |     74,196 |
    load    [$i3 + 0], $f2              # |     74,196 |     74,196 |
    fmul    $f2, $f1, $f1               # |     74,196 |     74,196 |
    load    [$i5 + 1], $f2              # |     74,196 |     74,196 |
    load    [$i3 + 1], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    load    [$i5 + 2], $f2              # |     74,196 |     74,196 |
    load    [$i3 + 2], $f3              # |     74,196 |     74,196 |
    fmul    $f3, $f2, $f2               # |     74,196 |     74,196 |
    fadd    $f1, $f2, $f1               # |     74,196 |     74,196 |
    store   $f1, [$i5 + 3]              # |     74,196 |     74,196 |
    sub     $i1, 1, $i1                 # |     74,196 |     74,196 |
    b       setup_startp_constants.2831 # |     74,196 |     74,196 |
be_else.21804:
    bg      $i4, 2, ble_else.21805      # |    556,470 |    556,470 |
ble_then.21805:
    sub     $i1, 1, $i1                 # |    222,588 |    222,588 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |
ble_else.21805:
    load    [$i3 + 4], $i6              # |    333,882 |    333,882 |
    load    [$i3 + 3], $i7              # |    333,882 |    333,882 |
    load    [$i5 + 0], $f1              # |    333,882 |    333,882 |
    load    [$i5 + 1], $f2              # |    333,882 |    333,882 |
    load    [$i5 + 2], $f3              # |    333,882 |    333,882 |
    fmul    $f1, $f1, $f4               # |    333,882 |    333,882 |
    load    [$i6 + 0], $f5              # |    333,882 |    333,882 |
    fmul    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f2, $f2, $f5               # |    333,882 |    333,882 |
    load    [$i6 + 1], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    fmul    $f3, $f3, $f5               # |    333,882 |    333,882 |
    load    [$i6 + 2], $f6              # |    333,882 |    333,882 |
    fmul    $f5, $f6, $f5               # |    333,882 |    333,882 |
    fadd    $f4, $f5, $f4               # |    333,882 |    333,882 |
    bne     $i7, 0, be_else.21806       # |    333,882 |    333,882 |
be_then.21806:
    mov     $f4, $f1                    # |    333,882 |    333,882 |
.count b_cont
    b       be_cont.21806               # |    333,882 |    333,882 |
be_else.21806:
    load    [$i3 + 9], $i3
    fmul    $f2, $f3, $f5
    load    [$i3 + 0], $f6
    fmul    $f5, $f6, $f5
    fadd    $f4, $f5, $f4
    fmul    $f3, $f1, $f3
    load    [$i3 + 1], $f5
    fmul    $f3, $f5, $f3
    fadd    $f4, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i3 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21806:
    sub     $i1, 1, $i1                 # |    333,882 |    333,882 |
    bne     $i4, 3, be_else.21807       # |    333,882 |    333,882 |
be_then.21807:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |
    store   $f1, [$i5 + 3]              # |    333,882 |    333,882 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |
be_else.21807:
    store   $f1, [$i5 + 3]
    b       setup_startp_constants.2831
bge_else.21803:
    ret                                 # |     37,098 |     37,098 |
.end setup_startp_constants

######################################################################
# $i1 = check_all_inside($i1, $i3, $f2, $f3, $f4)
# $ra = $ra
# [$i1 - $i7]
# [$f1 - $f9]
# []
# []
# []
######################################################################
.begin check_all_inside
check_all_inside.2856:
    load    [$i3 + $i1], $i2            # |  1,716,699 |  1,716,699 |
    bne     $i2, -1, be_else.21808      # |  1,716,699 |  1,716,699 |
be_then.21808:
    li      1, $i1                      # |     22,129 |     22,129 |
    ret                                 # |     22,129 |     22,129 |
be_else.21808:
    load    [ext_objects + $i2], $i2    # |  1,694,570 |  1,694,570 |
    load    [$i2 + 1], $i4              # |  1,694,570 |  1,694,570 |
    load    [$i2 + 5], $i5              # |  1,694,570 |  1,694,570 |
    load    [$i5 + 0], $f1              # |  1,694,570 |  1,694,570 |
    fsub    $f2, $f1, $f1               # |  1,694,570 |  1,694,570 |
    load    [$i5 + 1], $f5              # |  1,694,570 |  1,694,570 |
    fsub    $f3, $f5, $f5               # |  1,694,570 |  1,694,570 |
    load    [$i5 + 2], $f6              # |  1,694,570 |  1,694,570 |
    fsub    $f4, $f6, $f6               # |  1,694,570 |  1,694,570 |
    bne     $i4, 1, be_else.21809       # |  1,694,570 |  1,694,570 |
be_then.21809:
    load    [$i2 + 4], $i4              # |    716,988 |    716,988 |
    load    [$i4 + 0], $f7              # |    716,988 |    716,988 |
    fabs    $f1, $f1                    # |    716,988 |    716,988 |
    load    [$i2 + 6], $i2              # |    716,988 |    716,988 |
    bg      $f7, $f1, ble_else.21810    # |    716,988 |    716,988 |
ble_then.21810:
    bne     $i2, 0, be_else.21811       # |    198,212 |    198,212 |
be_then.21811:
    li      1, $i2                      # |    198,212 |    198,212 |
.count b_cont
    b       be_cont.21809               # |    198,212 |    198,212 |
be_else.21811:
    li      0, $i2
.count b_cont
    b       be_cont.21809
ble_else.21810:
    load    [$i4 + 1], $f1              # |    518,776 |    518,776 |
    fabs    $f5, $f5                    # |    518,776 |    518,776 |
    bg      $f1, $f5, ble_else.21812    # |    518,776 |    518,776 |
ble_then.21812:
    bne     $i2, 0, be_else.21813       # |     55,320 |     55,320 |
be_then.21813:
    li      1, $i2                      # |     55,320 |     55,320 |
.count b_cont
    b       be_cont.21809               # |     55,320 |     55,320 |
be_else.21813:
    li      0, $i2
.count b_cont
    b       be_cont.21809
ble_else.21812:
    load    [$i4 + 2], $f1              # |    463,456 |    463,456 |
    fabs    $f6, $f5                    # |    463,456 |    463,456 |
    bg      $f1, $f5, be_cont.21809     # |    463,456 |    463,456 |
ble_then.21814:
    bne     $i2, 0, be_else.21815       # |     17,095 |     17,095 |
be_then.21815:
    li      1, $i2                      # |     17,095 |     17,095 |
.count b_cont
    b       be_cont.21809               # |     17,095 |     17,095 |
be_else.21815:
    li      0, $i2
.count b_cont
    b       be_cont.21809
be_else.21809:
    bne     $i4, 2, be_else.21816       # |    977,582 |    977,582 |
be_then.21816:
    load    [$i2 + 6], $i4              # |    460,717 |    460,717 |
    load    [$i2 + 4], $i2              # |    460,717 |    460,717 |
    load    [$i2 + 0], $f7              # |    460,717 |    460,717 |
    fmul    $f7, $f1, $f1               # |    460,717 |    460,717 |
    load    [$i2 + 1], $f7              # |    460,717 |    460,717 |
    fmul    $f7, $f5, $f5               # |    460,717 |    460,717 |
    fadd    $f1, $f5, $f1               # |    460,717 |    460,717 |
    load    [$i2 + 2], $f5              # |    460,717 |    460,717 |
    fmul    $f5, $f6, $f5               # |    460,717 |    460,717 |
    fadd    $f1, $f5, $f1               # |    460,717 |    460,717 |
    bg      $f0, $f1, ble_else.21817    # |    460,717 |    460,717 |
ble_then.21817:
    bne     $i4, 0, be_else.21818       # |    460,717 |    460,717 |
be_then.21818:
    li      1, $i2
.count b_cont
    b       be_cont.21816
be_else.21818:
    li      0, $i2                      # |    460,717 |    460,717 |
.count b_cont
    b       be_cont.21816               # |    460,717 |    460,717 |
ble_else.21817:
    bne     $i4, 0, be_else.21819
be_then.21819:
    li      0, $i2
.count b_cont
    b       be_cont.21816
be_else.21819:
    li      1, $i2
.count b_cont
    b       be_cont.21816
be_else.21816:
    load    [$i2 + 6], $i5              # |    516,865 |    516,865 |
    fmul    $f1, $f1, $f7               # |    516,865 |    516,865 |
    load    [$i2 + 4], $i6              # |    516,865 |    516,865 |
    load    [$i6 + 0], $f8              # |    516,865 |    516,865 |
    fmul    $f7, $f8, $f7               # |    516,865 |    516,865 |
    fmul    $f5, $f5, $f8               # |    516,865 |    516,865 |
    load    [$i6 + 1], $f9              # |    516,865 |    516,865 |
    fmul    $f8, $f9, $f8               # |    516,865 |    516,865 |
    fadd    $f7, $f8, $f7               # |    516,865 |    516,865 |
    fmul    $f6, $f6, $f8               # |    516,865 |    516,865 |
    load    [$i6 + 2], $f9              # |    516,865 |    516,865 |
    fmul    $f8, $f9, $f8               # |    516,865 |    516,865 |
    fadd    $f7, $f8, $f7               # |    516,865 |    516,865 |
    load    [$i2 + 3], $i6              # |    516,865 |    516,865 |
    bne     $i6, 0, be_else.21820       # |    516,865 |    516,865 |
be_then.21820:
    mov     $f7, $f1                    # |    516,865 |    516,865 |
.count b_cont
    b       be_cont.21820               # |    516,865 |    516,865 |
be_else.21820:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.21820:
    bne     $i4, 3, be_cont.21821       # |    516,865 |    516,865 |
be_then.21821:
    fsub    $f1, $fc0, $f1              # |    516,865 |    516,865 |
be_cont.21821:
    bg      $f0, $f1, ble_else.21822    # |    516,865 |    516,865 |
ble_then.21822:
    bne     $i5, 0, be_else.21823       # |    184,696 |    184,696 |
be_then.21823:
    li      1, $i2                      # |    184,696 |    184,696 |
.count b_cont
    b       ble_cont.21822              # |    184,696 |    184,696 |
be_else.21823:
    li      0, $i2
.count b_cont
    b       ble_cont.21822
ble_else.21822:
    bne     $i5, 0, be_else.21824       # |    332,169 |    332,169 |
be_then.21824:
    li      0, $i2                      # |    332,169 |    332,169 |
.count b_cont
    b       be_cont.21824               # |    332,169 |    332,169 |
be_else.21824:
    li      1, $i2
be_cont.21824:
ble_cont.21822:
be_cont.21816:
be_cont.21809:
    bne     $i2, 0, be_else.21825       # |  1,694,570 |  1,694,570 |
be_then.21825:
    add     $i1, 1, $i1                 # |  1,239,247 |  1,239,247 |
    load    [$i3 + $i1], $i2            # |  1,239,247 |  1,239,247 |
    bne     $i2, -1, be_else.21826      # |  1,239,247 |  1,239,247 |
be_then.21826:
    li      1, $i1                      # |    596,938 |    596,938 |
    ret                                 # |    596,938 |    596,938 |
be_else.21826:
    load    [ext_objects + $i2], $i2    # |    642,309 |    642,309 |
    load    [$i2 + 5], $i4              # |    642,309 |    642,309 |
    load    [$i2 + 1], $i5              # |    642,309 |    642,309 |
    load    [$i4 + 0], $f1              # |    642,309 |    642,309 |
    fsub    $f2, $f1, $f1               # |    642,309 |    642,309 |
    load    [$i4 + 1], $f5              # |    642,309 |    642,309 |
    fsub    $f3, $f5, $f5               # |    642,309 |    642,309 |
    load    [$i4 + 2], $f6              # |    642,309 |    642,309 |
    fsub    $f4, $f6, $f6               # |    642,309 |    642,309 |
    bne     $i5, 1, be_else.21827       # |    642,309 |    642,309 |
be_then.21827:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    load    [$i2 + 6], $i2
    bg      $f7, $f1, ble_else.21828
ble_then.21828:
    bne     $i2, 0, be_else.21829
be_then.21829:
    li      1, $i2
.count b_cont
    b       be_cont.21827
be_else.21829:
    li      0, $i2
.count b_cont
    b       be_cont.21827
ble_else.21828:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.21830
ble_then.21830:
    bne     $i2, 0, be_else.21831
be_then.21831:
    li      1, $i2
.count b_cont
    b       be_cont.21827
be_else.21831:
    li      0, $i2
.count b_cont
    b       be_cont.21827
ble_else.21830:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, be_cont.21827
ble_then.21832:
    bne     $i2, 0, be_else.21833
be_then.21833:
    li      1, $i2
.count b_cont
    b       be_cont.21827
be_else.21833:
    li      0, $i2
.count b_cont
    b       be_cont.21827
be_else.21827:
    load    [$i2 + 6], $i4              # |    642,309 |    642,309 |
    bne     $i5, 2, be_else.21834       # |    642,309 |    642,309 |
be_then.21834:
    load    [$i2 + 4], $i2              # |     31,832 |     31,832 |
    load    [$i2 + 0], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f1, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 1], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f5, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 2], $f5              # |     31,832 |     31,832 |
    fmul    $f5, $f6, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    bg      $f0, $f1, ble_else.21835    # |     31,832 |     31,832 |
ble_then.21835:
    bne     $i4, 0, be_else.21836       # |     20,424 |     20,424 |
be_then.21836:
    li      1, $i2
.count b_cont
    b       be_cont.21834
be_else.21836:
    li      0, $i2                      # |     20,424 |     20,424 |
.count b_cont
    b       be_cont.21834               # |     20,424 |     20,424 |
ble_else.21835:
    bne     $i4, 0, be_else.21837       # |     11,408 |     11,408 |
be_then.21837:
    li      0, $i2
.count b_cont
    b       be_cont.21834
be_else.21837:
    li      1, $i2                      # |     11,408 |     11,408 |
.count b_cont
    b       be_cont.21834               # |     11,408 |     11,408 |
be_else.21834:
    load    [$i2 + 4], $i6              # |    610,477 |    610,477 |
    load    [$i2 + 3], $i7              # |    610,477 |    610,477 |
    fmul    $f1, $f1, $f7               # |    610,477 |    610,477 |
    load    [$i6 + 0], $f8              # |    610,477 |    610,477 |
    fmul    $f7, $f8, $f7               # |    610,477 |    610,477 |
    fmul    $f5, $f5, $f8               # |    610,477 |    610,477 |
    load    [$i6 + 1], $f9              # |    610,477 |    610,477 |
    fmul    $f8, $f9, $f8               # |    610,477 |    610,477 |
    fadd    $f7, $f8, $f7               # |    610,477 |    610,477 |
    fmul    $f6, $f6, $f8               # |    610,477 |    610,477 |
    load    [$i6 + 2], $f9              # |    610,477 |    610,477 |
    fmul    $f8, $f9, $f8               # |    610,477 |    610,477 |
    fadd    $f7, $f8, $f7               # |    610,477 |    610,477 |
    bne     $i7, 0, be_else.21838       # |    610,477 |    610,477 |
be_then.21838:
    mov     $f7, $f1                    # |    610,477 |    610,477 |
.count b_cont
    b       be_cont.21838               # |    610,477 |    610,477 |
be_else.21838:
    load    [$i2 + 9], $i2
    fmul    $f5, $f6, $f8
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.21838:
    bne     $i5, 3, be_cont.21839       # |    610,477 |    610,477 |
be_then.21839:
    fsub    $f1, $fc0, $f1              # |    610,477 |    610,477 |
be_cont.21839:
    bg      $f0, $f1, ble_else.21840    # |    610,477 |    610,477 |
ble_then.21840:
    bne     $i4, 0, be_else.21841       # |    299,953 |    299,953 |
be_then.21841:
    li      1, $i2                      # |    108,381 |    108,381 |
.count b_cont
    b       ble_cont.21840              # |    108,381 |    108,381 |
be_else.21841:
    li      0, $i2                      # |    191,572 |    191,572 |
.count b_cont
    b       ble_cont.21840              # |    191,572 |    191,572 |
ble_else.21840:
    bne     $i4, 0, be_else.21842       # |    310,524 |    310,524 |
be_then.21842:
    li      0, $i2                      # |    243,461 |    243,461 |
.count b_cont
    b       be_cont.21842               # |    243,461 |    243,461 |
be_else.21842:
    li      1, $i2                      # |     67,063 |     67,063 |
be_cont.21842:
ble_cont.21840:
be_cont.21834:
be_cont.21827:
    bne     $i2, 0, be_else.21843       # |    642,309 |    642,309 |
be_then.21843:
    add     $i1, 1, $i1                 # |    455,457 |    455,457 |
    load    [$i3 + $i1], $i2            # |    455,457 |    455,457 |
    bne     $i2, -1, be_else.21844      # |    455,457 |    455,457 |
be_then.21844:
    li      1, $i1                      # |    219,667 |    219,667 |
    ret                                 # |    219,667 |    219,667 |
be_else.21844:
    load    [ext_objects + $i2], $i2    # |    235,790 |    235,790 |
    load    [$i2 + 1], $i4              # |    235,790 |    235,790 |
    load    [$i2 + 5], $i5              # |    235,790 |    235,790 |
    load    [$i5 + 0], $f1              # |    235,790 |    235,790 |
    fsub    $f2, $f1, $f1               # |    235,790 |    235,790 |
    load    [$i5 + 1], $f5              # |    235,790 |    235,790 |
    fsub    $f3, $f5, $f5               # |    235,790 |    235,790 |
    load    [$i5 + 2], $f6              # |    235,790 |    235,790 |
    fsub    $f4, $f6, $f6               # |    235,790 |    235,790 |
    bne     $i4, 1, be_else.21845       # |    235,790 |    235,790 |
be_then.21845:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    load    [$i2 + 6], $i2
    bg      $f7, $f1, ble_else.21846
ble_then.21846:
    bne     $i2, 0, be_else.21847
be_then.21847:
    li      1, $i2
.count b_cont
    b       be_cont.21845
be_else.21847:
    li      0, $i2
.count b_cont
    b       be_cont.21845
ble_else.21846:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.21848
ble_then.21848:
    bne     $i2, 0, be_else.21849
be_then.21849:
    li      1, $i2
.count b_cont
    b       be_cont.21845
be_else.21849:
    li      0, $i2
.count b_cont
    b       be_cont.21845
ble_else.21848:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, be_cont.21845
ble_then.21850:
    bne     $i2, 0, be_else.21851
be_then.21851:
    li      1, $i2
.count b_cont
    b       be_cont.21845
be_else.21851:
    li      0, $i2
.count b_cont
    b       be_cont.21845
be_else.21845:
    bne     $i4, 2, be_else.21852       # |    235,790 |    235,790 |
be_then.21852:
    load    [$i2 + 6], $i4              # |     46,329 |     46,329 |
    load    [$i2 + 4], $i2              # |     46,329 |     46,329 |
    load    [$i2 + 0], $f7              # |     46,329 |     46,329 |
    fmul    $f7, $f1, $f1               # |     46,329 |     46,329 |
    load    [$i2 + 1], $f7              # |     46,329 |     46,329 |
    fmul    $f7, $f5, $f5               # |     46,329 |     46,329 |
    fadd    $f1, $f5, $f1               # |     46,329 |     46,329 |
    load    [$i2 + 2], $f5              # |     46,329 |     46,329 |
    fmul    $f5, $f6, $f5               # |     46,329 |     46,329 |
    fadd    $f1, $f5, $f1               # |     46,329 |     46,329 |
    bg      $f0, $f1, ble_else.21853    # |     46,329 |     46,329 |
ble_then.21853:
    bne     $i4, 0, be_else.21854       # |     26,054 |     26,054 |
be_then.21854:
    li      1, $i2
.count b_cont
    b       be_cont.21852
be_else.21854:
    li      0, $i2                      # |     26,054 |     26,054 |
.count b_cont
    b       be_cont.21852               # |     26,054 |     26,054 |
ble_else.21853:
    bne     $i4, 0, be_else.21855       # |     20,275 |     20,275 |
be_then.21855:
    li      0, $i2
.count b_cont
    b       be_cont.21852
be_else.21855:
    li      1, $i2                      # |     20,275 |     20,275 |
.count b_cont
    b       be_cont.21852               # |     20,275 |     20,275 |
be_else.21852:
    load    [$i2 + 6], $i5              # |    189,461 |    189,461 |
    load    [$i2 + 3], $i6              # |    189,461 |    189,461 |
    fmul    $f1, $f1, $f7               # |    189,461 |    189,461 |
    load    [$i2 + 4], $i7              # |    189,461 |    189,461 |
    load    [$i7 + 0], $f8              # |    189,461 |    189,461 |
    fmul    $f7, $f8, $f7               # |    189,461 |    189,461 |
    fmul    $f5, $f5, $f8               # |    189,461 |    189,461 |
    load    [$i7 + 1], $f9              # |    189,461 |    189,461 |
    fmul    $f8, $f9, $f8               # |    189,461 |    189,461 |
    fadd    $f7, $f8, $f7               # |    189,461 |    189,461 |
    fmul    $f6, $f6, $f8               # |    189,461 |    189,461 |
    load    [$i7 + 2], $f9              # |    189,461 |    189,461 |
    fmul    $f8, $f9, $f8               # |    189,461 |    189,461 |
    fadd    $f7, $f8, $f7               # |    189,461 |    189,461 |
    bne     $i6, 0, be_else.21856       # |    189,461 |    189,461 |
be_then.21856:
    mov     $f7, $f1                    # |    189,461 |    189,461 |
.count b_cont
    b       be_cont.21856               # |    189,461 |    189,461 |
be_else.21856:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.21856:
    bne     $i4, 3, be_cont.21857       # |    189,461 |    189,461 |
be_then.21857:
    fsub    $f1, $fc0, $f1              # |    189,461 |    189,461 |
be_cont.21857:
    bg      $f0, $f1, ble_else.21858    # |    189,461 |    189,461 |
ble_then.21858:
    bne     $i5, 0, be_else.21859       # |    153,221 |    153,221 |
be_then.21859:
    li      1, $i2
.count b_cont
    b       ble_cont.21858
be_else.21859:
    li      0, $i2                      # |    153,221 |    153,221 |
.count b_cont
    b       ble_cont.21858              # |    153,221 |    153,221 |
ble_else.21858:
    bne     $i5, 0, be_else.21860       # |     36,240 |     36,240 |
be_then.21860:
    li      0, $i2
.count b_cont
    b       be_cont.21860
be_else.21860:
    li      1, $i2                      # |     36,240 |     36,240 |
be_cont.21860:
ble_cont.21858:
be_cont.21852:
be_cont.21845:
    bne     $i2, 0, be_else.21861       # |    235,790 |    235,790 |
be_then.21861:
    add     $i1, 1, $i1                 # |    179,275 |    179,275 |
    load    [$i3 + $i1], $i2            # |    179,275 |    179,275 |
    bne     $i2, -1, be_else.21862      # |    179,275 |    179,275 |
be_then.21862:
    li      1, $i1                      # |    179,275 |    179,275 |
    ret                                 # |    179,275 |    179,275 |
be_else.21862:
    load    [ext_objects + $i2], $i2
    load    [$i2 + 5], $i4
    load    [$i2 + 1], $i5
    load    [$i4 + 0], $f1
    load    [$i4 + 1], $f5
    load    [$i4 + 2], $f6
    fsub    $f2, $f1, $f1
    fsub    $f3, $f5, $f5
    fsub    $f4, $f6, $f6
    bne     $i5, 1, be_else.21863
be_then.21863:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    bg      $f7, $f1, ble_else.21864
ble_then.21864:
    li      0, $i4
.count b_cont
    b       ble_cont.21864
ble_else.21864:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    bg      $f1, $f5, ble_else.21865
ble_then.21865:
    li      0, $i4
.count b_cont
    b       ble_cont.21865
ble_else.21865:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, ble_else.21866
ble_then.21866:
    li      0, $i4
.count b_cont
    b       ble_cont.21866
ble_else.21866:
    li      1, $i4
ble_cont.21866:
ble_cont.21865:
ble_cont.21864:
    load    [$i2 + 6], $i2
    bne     $i4, 0, be_else.21867
be_then.21867:
    bne     $i2, 0, be_else.21868
be_then.21868:
    li      0, $i1
    ret
be_else.21868:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.21867:
    bne     $i2, 0, be_else.21869
be_then.21869:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.21869:
    li      0, $i1
    ret
be_else.21863:
    load    [$i2 + 6], $i4
    bne     $i5, 2, be_else.21870
be_then.21870:
    load    [$i2 + 4], $i2
    load    [$i2 + 0], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 1], $f7
    fmul    $f7, $f5, $f5
    fadd    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f5, $f6, $f5
    fadd    $f1, $f5, $f1
    bg      $f0, $f1, ble_else.21871
ble_then.21871:
    bne     $i4, 0, be_else.21872
be_then.21872:
    li      0, $i1
    ret
be_else.21872:
    add     $i1, 1, $i1
    b       check_all_inside.2856
ble_else.21871:
    bne     $i4, 0, be_else.21873
be_then.21873:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.21873:
    li      0, $i1
    ret
be_else.21870:
    load    [$i2 + 4], $i6
    load    [$i2 + 3], $i7
    fmul    $f1, $f1, $f7
    load    [$i6 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f5, $f5, $f8
    load    [$i6 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f6, $f8
    load    [$i6 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    bne     $i7, 0, be_else.21874
be_then.21874:
    mov     $f7, $f1
.count b_cont
    b       be_cont.21874
be_else.21874:
    fmul    $f5, $f6, $f8
    load    [$i2 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f6, $f1, $f6
    load    [$i2 + 1], $f8
    fmul    $f6, $f8, $f6
    fadd    $f7, $f6, $f6
    fmul    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f1, $f5, $f1
    fadd    $f6, $f1, $f1
be_cont.21874:
    bne     $i5, 3, be_cont.21875
be_then.21875:
    fsub    $f1, $fc0, $f1
be_cont.21875:
    bg      $f0, $f1, ble_else.21876
ble_then.21876:
    bne     $i4, 0, be_else.21877
be_then.21877:
    li      0, $i1
    ret
be_else.21877:
    add     $i1, 1, $i1
    b       check_all_inside.2856
ble_else.21876:
    bne     $i4, 0, be_else.21878
be_then.21878:
    add     $i1, 1, $i1
    b       check_all_inside.2856
be_else.21878:
    li      0, $i1
    ret
be_else.21861:
    li      0, $i1                      # |     56,515 |     56,515 |
    ret                                 # |     56,515 |     56,515 |
be_else.21843:
    li      0, $i1                      # |    186,852 |    186,852 |
    ret                                 # |    186,852 |    186,852 |
be_else.21825:
    li      0, $i1                      # |    455,323 |    455,323 |
    ret                                 # |    455,323 |    455,323 |
.end check_all_inside

######################################################################
# $i1 = shadow_check_and_group($i8, $i9)
# $ra = $ra1
# [$i1 - $i9]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra]
######################################################################
.begin shadow_check_and_group
shadow_check_and_group.2862:
    load    [$i9 + $i8], $i1            # |  4,223,804 |  4,223,804 |
    bne     $i1, -1, be_else.21879      # |  4,223,804 |  4,223,804 |
be_then.21879:
    li      0, $i1                      # |    627,950 |    627,950 |
    jr      $ra1                        # |    627,950 |    627,950 |
be_else.21879:
    load    [ext_objects + $i1], $i2    # |  3,595,854 |  3,595,854 |
    load    [$i2 + 5], $i3              # |  3,595,854 |  3,595,854 |
    load    [ext_light_dirvec + 1], $i4 # |  3,595,854 |  3,595,854 |
    load    [$i2 + 1], $i5              # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 0], $f1# |  3,595,854 |  3,595,854 |
    load    [$i3 + 0], $f2              # |  3,595,854 |  3,595,854 |
    fsub    $f1, $f2, $f1               # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 1], $f2# |  3,595,854 |  3,595,854 |
    load    [$i3 + 1], $f3              # |  3,595,854 |  3,595,854 |
    fsub    $f2, $f3, $f2               # |  3,595,854 |  3,595,854 |
    load    [ext_intersection_point + 2], $f3# |  3,595,854 |  3,595,854 |
    load    [$i3 + 2], $f4              # |  3,595,854 |  3,595,854 |
    fsub    $f3, $f4, $f3               # |  3,595,854 |  3,595,854 |
    load    [$i4 + $i1], $i3            # |  3,595,854 |  3,595,854 |
    bne     $i5, 1, be_else.21880       # |  3,595,854 |  3,595,854 |
be_then.21880:
    load    [ext_light_dirvec + 0], $i4 # |  1,410,052 |  1,410,052 |
    load    [$i2 + 4], $i2              # |  1,410,052 |  1,410,052 |
    load    [$i2 + 1], $f4              # |  1,410,052 |  1,410,052 |
    load    [$i4 + 1], $f5              # |  1,410,052 |  1,410,052 |
    load    [$i3 + 0], $f6              # |  1,410,052 |  1,410,052 |
    fsub    $f6, $f1, $f6               # |  1,410,052 |  1,410,052 |
    load    [$i3 + 1], $f7              # |  1,410,052 |  1,410,052 |
    fmul    $f6, $f7, $f6               # |  1,410,052 |  1,410,052 |
    fmul    $f6, $f5, $f5               # |  1,410,052 |  1,410,052 |
    fadd_a  $f5, $f2, $f5               # |  1,410,052 |  1,410,052 |
    bg      $f4, $f5, ble_else.21881    # |  1,410,052 |  1,410,052 |
ble_then.21881:
    li      0, $i5                      # |    998,548 |    998,548 |
.count b_cont
    b       ble_cont.21881              # |    998,548 |    998,548 |
ble_else.21881:
    load    [$i2 + 2], $f4              # |    411,504 |    411,504 |
    load    [$i4 + 2], $f5              # |    411,504 |    411,504 |
    fmul    $f6, $f5, $f5               # |    411,504 |    411,504 |
    fadd_a  $f5, $f3, $f5               # |    411,504 |    411,504 |
    bg      $f4, $f5, ble_else.21882    # |    411,504 |    411,504 |
ble_then.21882:
    li      0, $i5                      # |    136,398 |    136,398 |
.count b_cont
    b       ble_cont.21882              # |    136,398 |    136,398 |
ble_else.21882:
    load    [$i3 + 1], $f4              # |    275,106 |    275,106 |
    bne     $f4, $f0, be_else.21883     # |    275,106 |    275,106 |
be_then.21883:
    li      0, $i5
.count b_cont
    b       be_cont.21883
be_else.21883:
    li      1, $i5                      # |    275,106 |    275,106 |
be_cont.21883:
ble_cont.21882:
ble_cont.21881:
    bne     $i5, 0, be_else.21884       # |  1,410,052 |  1,410,052 |
be_then.21884:
    load    [$i2 + 0], $f4              # |  1,134,946 |  1,134,946 |
    load    [$i4 + 0], $f5              # |  1,134,946 |  1,134,946 |
    load    [$i3 + 2], $f6              # |  1,134,946 |  1,134,946 |
    fsub    $f6, $f2, $f6               # |  1,134,946 |  1,134,946 |
    load    [$i3 + 3], $f7              # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f7, $f6               # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f5, $f5               # |  1,134,946 |  1,134,946 |
    fadd_a  $f5, $f1, $f5               # |  1,134,946 |  1,134,946 |
    bg      $f4, $f5, ble_else.21885    # |  1,134,946 |  1,134,946 |
ble_then.21885:
    li      0, $i5                      # |    632,680 |    632,680 |
.count b_cont
    b       ble_cont.21885              # |    632,680 |    632,680 |
ble_else.21885:
    load    [$i2 + 2], $f4              # |    502,266 |    502,266 |
    load    [$i4 + 2], $f5              # |    502,266 |    502,266 |
    fmul    $f6, $f5, $f5               # |    502,266 |    502,266 |
    fadd_a  $f5, $f3, $f5               # |    502,266 |    502,266 |
    bg      $f4, $f5, ble_else.21886    # |    502,266 |    502,266 |
ble_then.21886:
    li      0, $i5                      # |    139,036 |    139,036 |
.count b_cont
    b       ble_cont.21886              # |    139,036 |    139,036 |
ble_else.21886:
    load    [$i3 + 3], $f4              # |    363,230 |    363,230 |
    bne     $f4, $f0, be_else.21887     # |    363,230 |    363,230 |
be_then.21887:
    li      0, $i5
.count b_cont
    b       be_cont.21887
be_else.21887:
    li      1, $i5                      # |    363,230 |    363,230 |
be_cont.21887:
ble_cont.21886:
ble_cont.21885:
    bne     $i5, 0, be_else.21888       # |  1,134,946 |  1,134,946 |
be_then.21888:
    load    [$i2 + 0], $f4              # |    771,716 |    771,716 |
    load    [$i4 + 0], $f5              # |    771,716 |    771,716 |
    load    [$i3 + 4], $f6              # |    771,716 |    771,716 |
    fsub    $f6, $f3, $f3               # |    771,716 |    771,716 |
    load    [$i3 + 5], $f6              # |    771,716 |    771,716 |
    fmul    $f3, $f6, $f3               # |    771,716 |    771,716 |
    fmul    $f3, $f5, $f5               # |    771,716 |    771,716 |
    fadd_a  $f5, $f1, $f1               # |    771,716 |    771,716 |
    bg      $f4, $f1, ble_else.21889    # |    771,716 |    771,716 |
ble_then.21889:
    li      0, $i2                      # |    642,375 |    642,375 |
.count b_cont
    b       be_cont.21880               # |    642,375 |    642,375 |
ble_else.21889:
    load    [$i2 + 1], $f1              # |    129,341 |    129,341 |
    load    [$i4 + 1], $f4              # |    129,341 |    129,341 |
    fmul    $f3, $f4, $f4               # |    129,341 |    129,341 |
    fadd_a  $f4, $f2, $f2               # |    129,341 |    129,341 |
    bg      $f1, $f2, ble_else.21890    # |    129,341 |    129,341 |
ble_then.21890:
    li      0, $i2                      # |     78,458 |     78,458 |
.count b_cont
    b       be_cont.21880               # |     78,458 |     78,458 |
ble_else.21890:
    load    [$i3 + 5], $f1              # |     50,883 |     50,883 |
    bne     $f1, $f0, be_else.21891     # |     50,883 |     50,883 |
be_then.21891:
    li      0, $i2
.count b_cont
    b       be_cont.21880
be_else.21891:
    mov     $f3, $fg0                   # |     50,883 |     50,883 |
    li      3, $i2                      # |     50,883 |     50,883 |
.count b_cont
    b       be_cont.21880               # |     50,883 |     50,883 |
be_else.21888:
    mov     $f6, $fg0                   # |    363,230 |    363,230 |
    li      2, $i2                      # |    363,230 |    363,230 |
.count b_cont
    b       be_cont.21880               # |    363,230 |    363,230 |
be_else.21884:
    mov     $f6, $fg0                   # |    275,106 |    275,106 |
    li      1, $i2                      # |    275,106 |    275,106 |
.count b_cont
    b       be_cont.21880               # |    275,106 |    275,106 |
be_else.21880:
    load    [$i3 + 0], $f4              # |  2,185,802 |  2,185,802 |
    bne     $i5, 2, be_else.21892       # |  2,185,802 |  2,185,802 |
be_then.21892:
    bg      $f0, $f4, ble_else.21893    # |    566,304 |    566,304 |
ble_then.21893:
    li      0, $i2                      # |     11,417 |     11,417 |
.count b_cont
    b       be_cont.21892               # |     11,417 |     11,417 |
ble_else.21893:
    load    [$i3 + 1], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f1, $f1               # |    554,887 |    554,887 |
    load    [$i3 + 2], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f2, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $f1               # |    554,887 |    554,887 |
    load    [$i3 + 3], $f2              # |    554,887 |    554,887 |
    fmul    $f2, $f3, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $fg0              # |    554,887 |    554,887 |
    li      1, $i2                      # |    554,887 |    554,887 |
.count b_cont
    b       be_cont.21892               # |    554,887 |    554,887 |
be_else.21892:
    bne     $f4, $f0, be_else.21894     # |  1,619,498 |  1,619,498 |
be_then.21894:
    li      0, $i2
.count b_cont
    b       be_cont.21894
be_else.21894:
    load    [$i3 + 1], $f5              # |  1,619,498 |  1,619,498 |
    fmul    $f5, $f1, $f5               # |  1,619,498 |  1,619,498 |
    load    [$i3 + 2], $f6              # |  1,619,498 |  1,619,498 |
    fmul    $f6, $f2, $f6               # |  1,619,498 |  1,619,498 |
    fadd    $f5, $f6, $f5               # |  1,619,498 |  1,619,498 |
    load    [$i3 + 3], $f6              # |  1,619,498 |  1,619,498 |
    fmul    $f6, $f3, $f6               # |  1,619,498 |  1,619,498 |
    fadd    $f5, $f6, $f5               # |  1,619,498 |  1,619,498 |
    fmul    $f5, $f5, $f6               # |  1,619,498 |  1,619,498 |
    fmul    $f1, $f1, $f7               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 4], $i4              # |  1,619,498 |  1,619,498 |
    load    [$i4 + 0], $f8              # |  1,619,498 |  1,619,498 |
    fmul    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    fmul    $f2, $f2, $f8               # |  1,619,498 |  1,619,498 |
    load    [$i4 + 1], $f9              # |  1,619,498 |  1,619,498 |
    fmul    $f8, $f9, $f8               # |  1,619,498 |  1,619,498 |
    fadd    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    fmul    $f3, $f3, $f8               # |  1,619,498 |  1,619,498 |
    load    [$i4 + 2], $f9              # |  1,619,498 |  1,619,498 |
    fmul    $f8, $f9, $f8               # |  1,619,498 |  1,619,498 |
    fadd    $f7, $f8, $f7               # |  1,619,498 |  1,619,498 |
    load    [$i2 + 3], $i4              # |  1,619,498 |  1,619,498 |
    bne     $i4, 0, be_else.21895       # |  1,619,498 |  1,619,498 |
be_then.21895:
    mov     $f7, $f1                    # |  1,619,498 |  1,619,498 |
.count b_cont
    b       be_cont.21895               # |  1,619,498 |  1,619,498 |
be_else.21895:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i4
    load    [$i4 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i4 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i4 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21895:
    bne     $i5, 3, be_cont.21896       # |  1,619,498 |  1,619,498 |
be_then.21896:
    fsub    $f1, $fc0, $f1              # |  1,619,498 |  1,619,498 |
be_cont.21896:
    fmul    $f4, $f1, $f1               # |  1,619,498 |  1,619,498 |
    fsub    $f6, $f1, $f1               # |  1,619,498 |  1,619,498 |
    bg      $f1, $f0, ble_else.21897    # |  1,619,498 |  1,619,498 |
ble_then.21897:
    li      0, $i2                      # |  1,270,514 |  1,270,514 |
.count b_cont
    b       ble_cont.21897              # |  1,270,514 |  1,270,514 |
ble_else.21897:
    load    [$i2 + 6], $i2              # |    348,984 |    348,984 |
    load    [$i3 + 4], $f2              # |    348,984 |    348,984 |
    fsqrt   $f1, $f1                    # |    348,984 |    348,984 |
    bne     $i2, 0, be_else.21898       # |    348,984 |    348,984 |
be_then.21898:
    fsub    $f5, $f1, $f1               # |    278,797 |    278,797 |
    fmul    $f1, $f2, $fg0              # |    278,797 |    278,797 |
    li      1, $i2                      # |    278,797 |    278,797 |
.count b_cont
    b       be_cont.21898               # |    278,797 |    278,797 |
be_else.21898:
    fadd    $f5, $f1, $f1               # |     70,187 |     70,187 |
    fmul    $f1, $f2, $fg0              # |     70,187 |     70,187 |
    li      1, $i2                      # |     70,187 |     70,187 |
be_cont.21898:
ble_cont.21897:
be_cont.21894:
be_cont.21892:
be_cont.21880:
    bne     $i2, 0, be_else.21899       # |  3,595,854 |  3,595,854 |
be_then.21899:
    li      0, $i2                      # |  2,002,764 |  2,002,764 |
.count b_cont
    b       be_cont.21899               # |  2,002,764 |  2,002,764 |
be_else.21899:
.count load_float
    load    [f.21525], $f1              # |  1,593,090 |  1,593,090 |
    bg      $f1, $fg0, ble_else.21900   # |  1,593,090 |  1,593,090 |
ble_then.21900:
    li      0, $i2                      # |  1,029,398 |  1,029,398 |
.count b_cont
    b       ble_cont.21900              # |  1,029,398 |  1,029,398 |
ble_else.21900:
    li      1, $i2                      # |    563,692 |    563,692 |
ble_cont.21900:
be_cont.21899:
    bne     $i2, 0, be_else.21901       # |  3,595,854 |  3,595,854 |
be_then.21901:
    load    [ext_objects + $i1], $i1    # |  3,032,162 |  3,032,162 |
    load    [$i1 + 6], $i1              # |  3,032,162 |  3,032,162 |
    bne     $i1, 0, be_else.21902       # |  3,032,162 |  3,032,162 |
be_then.21902:
    li      0, $i1                      # |  2,406,264 |  2,406,264 |
    jr      $ra1                        # |  2,406,264 |  2,406,264 |
be_else.21902:
    add     $i8, 1, $i8                 # |    625,898 |    625,898 |
    b       shadow_check_and_group.2862 # |    625,898 |    625,898 |
be_else.21901:
    load    [$i9 + 0], $i1              # |    563,692 |    563,692 |
    bne     $i1, -1, be_else.21903      # |    563,692 |    563,692 |
be_then.21903:
    li      1, $i1
    jr      $ra1
be_else.21903:
    load    [ext_objects + $i1], $i1    # |    563,692 |    563,692 |
    load    [$i1 + 5], $i2              # |    563,692 |    563,692 |
    load    [$i1 + 1], $i3              # |    563,692 |    563,692 |
    load    [$i2 + 0], $f1              # |    563,692 |    563,692 |
    fadd    $fg0, $fc15, $f2            # |    563,692 |    563,692 |
    fmul    $fg14, $f2, $f3             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 0], $f4# |    563,692 |    563,692 |
    fadd    $f3, $f4, $f5               # |    563,692 |    563,692 |
    fsub    $f5, $f1, $f1               # |    563,692 |    563,692 |
    load    [$i2 + 1], $f3              # |    563,692 |    563,692 |
    fmul    $fg12, $f2, $f4             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 1], $f6# |    563,692 |    563,692 |
    fadd    $f4, $f6, $f6               # |    563,692 |    563,692 |
    fsub    $f6, $f3, $f3               # |    563,692 |    563,692 |
    load    [$i2 + 2], $f4              # |    563,692 |    563,692 |
    fmul    $fg13, $f2, $f2             # |    563,692 |    563,692 |
    load    [ext_intersection_point + 2], $f7# |    563,692 |    563,692 |
    fadd    $f2, $f7, $f7               # |    563,692 |    563,692 |
    fsub    $f7, $f4, $f2               # |    563,692 |    563,692 |
    bne     $i3, 1, be_else.21904       # |    563,692 |    563,692 |
be_then.21904:
    load    [$i1 + 4], $i2              # |    541,977 |    541,977 |
    load    [$i2 + 0], $f4              # |    541,977 |    541,977 |
    fabs    $f1, $f1                    # |    541,977 |    541,977 |
    load    [$i1 + 6], $i1              # |    541,977 |    541,977 |
    bg      $f4, $f1, ble_else.21905    # |    541,977 |    541,977 |
ble_then.21905:
    bne     $i1, 0, be_else.21906       # |     56,407 |     56,407 |
be_then.21906:
    li      1, $i1                      # |     56,407 |     56,407 |
.count b_cont
    b       be_cont.21904               # |     56,407 |     56,407 |
be_else.21906:
    li      0, $i1
.count b_cont
    b       be_cont.21904
ble_else.21905:
    load    [$i2 + 1], $f1              # |    485,570 |    485,570 |
    fabs    $f3, $f3                    # |    485,570 |    485,570 |
    bg      $f1, $f3, ble_else.21907    # |    485,570 |    485,570 |
ble_then.21907:
    bne     $i1, 0, be_else.21908       # |      5,609 |      5,609 |
be_then.21908:
    li      1, $i1                      # |      5,609 |      5,609 |
.count b_cont
    b       be_cont.21904               # |      5,609 |      5,609 |
be_else.21908:
    li      0, $i1
.count b_cont
    b       be_cont.21904
ble_else.21907:
    load    [$i2 + 2], $f1              # |    479,961 |    479,961 |
    fabs    $f2, $f2                    # |    479,961 |    479,961 |
    bg      $f1, $f2, be_cont.21904     # |    479,961 |    479,961 |
ble_then.21909:
    bne     $i1, 0, be_else.21910       # |      2,213 |      2,213 |
be_then.21910:
    li      1, $i1                      # |      2,213 |      2,213 |
.count b_cont
    b       be_cont.21904               # |      2,213 |      2,213 |
be_else.21910:
    li      0, $i1
.count b_cont
    b       be_cont.21904
be_else.21904:
    load    [$i1 + 6], $i2              # |     21,715 |     21,715 |
    bne     $i3, 2, be_else.21911       # |     21,715 |     21,715 |
be_then.21911:
    load    [$i1 + 4], $i1
    load    [$i1 + 0], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 1], $f4
    fmul    $f4, $f3, $f3
    fadd    $f1, $f3, $f1
    load    [$i1 + 2], $f3
    fmul    $f3, $f2, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, ble_else.21912
ble_then.21912:
    bne     $i2, 0, be_else.21913
be_then.21913:
    li      1, $i1
.count b_cont
    b       be_cont.21911
be_else.21913:
    li      0, $i1
.count b_cont
    b       be_cont.21911
ble_else.21912:
    bne     $i2, 0, be_else.21914
be_then.21914:
    li      0, $i1
.count b_cont
    b       be_cont.21911
be_else.21914:
    li      1, $i1
.count b_cont
    b       be_cont.21911
be_else.21911:
    fmul    $f1, $f1, $f4               # |     21,715 |     21,715 |
    load    [$i1 + 4], $i4              # |     21,715 |     21,715 |
    load    [$i4 + 0], $f8              # |     21,715 |     21,715 |
    fmul    $f4, $f8, $f4               # |     21,715 |     21,715 |
    fmul    $f3, $f3, $f8               # |     21,715 |     21,715 |
    load    [$i4 + 1], $f9              # |     21,715 |     21,715 |
    fmul    $f8, $f9, $f8               # |     21,715 |     21,715 |
    fadd    $f4, $f8, $f4               # |     21,715 |     21,715 |
    fmul    $f2, $f2, $f8               # |     21,715 |     21,715 |
    load    [$i4 + 2], $f9              # |     21,715 |     21,715 |
    fmul    $f8, $f9, $f8               # |     21,715 |     21,715 |
    load    [$i1 + 3], $i4              # |     21,715 |     21,715 |
    fadd    $f4, $f8, $f4               # |     21,715 |     21,715 |
    bne     $i4, 0, be_else.21915       # |     21,715 |     21,715 |
be_then.21915:
    mov     $f4, $f1                    # |     21,715 |     21,715 |
.count b_cont
    b       be_cont.21915               # |     21,715 |     21,715 |
be_else.21915:
    fmul    $f3, $f2, $f8
    load    [$i1 + 9], $i1
    load    [$i1 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f4, $f8, $f4
    fmul    $f2, $f1, $f2
    load    [$i1 + 1], $f8
    fmul    $f2, $f8, $f2
    fadd    $f4, $f2, $f2
    fmul    $f1, $f3, $f1
    load    [$i1 + 2], $f3
    fmul    $f1, $f3, $f1
    fadd    $f2, $f1, $f1
be_cont.21915:
    bne     $i3, 3, be_cont.21916       # |     21,715 |     21,715 |
be_then.21916:
    fsub    $f1, $fc0, $f1              # |     21,715 |     21,715 |
be_cont.21916:
    bg      $f0, $f1, ble_else.21917    # |     21,715 |     21,715 |
ble_then.21917:
    bne     $i2, 0, be_else.21918
be_then.21918:
    li      1, $i1
.count b_cont
    b       ble_cont.21917
be_else.21918:
    li      0, $i1
.count b_cont
    b       ble_cont.21917
ble_else.21917:
    bne     $i2, 0, be_else.21919       # |     21,715 |     21,715 |
be_then.21919:
    li      0, $i1                      # |     21,715 |     21,715 |
.count b_cont
    b       be_cont.21919               # |     21,715 |     21,715 |
be_else.21919:
    li      1, $i1
be_cont.21919:
ble_cont.21917:
be_cont.21911:
be_cont.21904:
    bne     $i1, 0, be_else.21920       # |    563,692 |    563,692 |
be_then.21920:
    li      1, $i1                      # |    499,463 |    499,463 |
.count move_args
    mov     $i9, $i3                    # |    499,463 |    499,463 |
.count move_args
    mov     $f5, $f2                    # |    499,463 |    499,463 |
.count move_args
    mov     $f6, $f3                    # |    499,463 |    499,463 |
.count move_args
    mov     $f7, $f4                    # |    499,463 |    499,463 |
    call    check_all_inside.2856       # |    499,463 |    499,463 |
    bne     $i1, 0, be_else.21921       # |    499,463 |    499,463 |
be_then.21921:
    add     $i8, 1, $i8                 # |    263,166 |    263,166 |
    b       shadow_check_and_group.2862 # |    263,166 |    263,166 |
be_else.21921:
    li      1, $i1                      # |    236,297 |    236,297 |
    jr      $ra1                        # |    236,297 |    236,297 |
be_else.21920:
    add     $i8, 1, $i8                 # |     64,229 |     64,229 |
    b       shadow_check_and_group.2862 # |     64,229 |     64,229 |
.end shadow_check_and_group

######################################################################
# $i1 = shadow_check_one_or_group($i10, $i11)
# $ra = $ra2
# [$i1 - $i11]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra1]
######################################################################
.begin shadow_check_one_or_group
shadow_check_one_or_group.2865:
    load    [$i11 + $i10], $i1          # |    223,695 |    223,695 |
    bne     $i1, -1, be_else.21922      # |    223,695 |    223,695 |
be_then.21922:
    li      0, $i1
    jr      $ra2
be_else.21922:
    li      0, $i8                      # |    223,695 |    223,695 |
    load    [ext_and_net + $i1], $i9    # |    223,695 |    223,695 |
    jal     shadow_check_and_group.2862, $ra1# |    223,695 |    223,695 |
    bne     $i1, 0, be_else.21923       # |    223,695 |    223,695 |
be_then.21923:
    add     $i10, 1, $i10               # |    113,433 |    113,433 |
    load    [$i11 + $i10], $i1          # |    113,433 |    113,433 |
    bne     $i1, -1, be_else.21924      # |    113,433 |    113,433 |
be_then.21924:
    li      0, $i1
    jr      $ra2
be_else.21924:
    li      0, $i8                      # |    113,433 |    113,433 |
    load    [ext_and_net + $i1], $i9    # |    113,433 |    113,433 |
    jal     shadow_check_and_group.2862, $ra1# |    113,433 |    113,433 |
    bne     $i1, 0, be_else.21925       # |    113,433 |    113,433 |
be_then.21925:
    add     $i10, 1, $i10               # |    106,783 |    106,783 |
    load    [$i11 + $i10], $i1          # |    106,783 |    106,783 |
    bne     $i1, -1, be_else.21926      # |    106,783 |    106,783 |
be_then.21926:
    li      0, $i1                      # |     10,331 |     10,331 |
    jr      $ra2                        # |     10,331 |     10,331 |
be_else.21926:
    li      0, $i8                      # |     96,452 |     96,452 |
    load    [ext_and_net + $i1], $i9    # |     96,452 |     96,452 |
    jal     shadow_check_and_group.2862, $ra1# |     96,452 |     96,452 |
    bne     $i1, 0, be_else.21927       # |     96,452 |     96,452 |
be_then.21927:
    add     $i10, 1, $i10               # |     94,280 |     94,280 |
    load    [$i11 + $i10], $i1          # |     94,280 |     94,280 |
    bne     $i1, -1, be_else.21928      # |     94,280 |     94,280 |
be_then.21928:
    li      0, $i1
    jr      $ra2
be_else.21928:
    li      0, $i8                      # |     94,280 |     94,280 |
    load    [ext_and_net + $i1], $i9    # |     94,280 |     94,280 |
    jal     shadow_check_and_group.2862, $ra1# |     94,280 |     94,280 |
    bne     $i1, 0, be_else.21929       # |     94,280 |     94,280 |
be_then.21929:
    add     $i10, 1, $i10               # |     82,752 |     82,752 |
    load    [$i11 + $i10], $i1          # |     82,752 |     82,752 |
    bne     $i1, -1, be_else.21930      # |     82,752 |     82,752 |
be_then.21930:
    li      0, $i1                      # |     82,752 |     82,752 |
    jr      $ra2                        # |     82,752 |     82,752 |
be_else.21930:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21931
be_then.21931:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    bne     $i1, -1, be_else.21932
be_then.21932:
    li      0, $i1
    jr      $ra2
be_else.21932:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21933
be_then.21933:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    bne     $i1, -1, be_else.21934
be_then.21934:
    li      0, $i1
    jr      $ra2
be_else.21934:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21935
be_then.21935:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    bne     $i1, -1, be_else.21936
be_then.21936:
    li      0, $i1
    jr      $ra2
be_else.21936:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21937
be_then.21937:
    add     $i10, 1, $i10
    b       shadow_check_one_or_group.2865
be_else.21937:
    li      1, $i1
    jr      $ra2
be_else.21935:
    li      1, $i1
    jr      $ra2
be_else.21933:
    li      1, $i1
    jr      $ra2
be_else.21931:
    li      1, $i1
    jr      $ra2
be_else.21929:
    li      1, $i1                      # |     11,528 |     11,528 |
    jr      $ra2                        # |     11,528 |     11,528 |
be_else.21927:
    li      1, $i1                      # |      2,172 |      2,172 |
    jr      $ra2                        # |      2,172 |      2,172 |
be_else.21925:
    li      1, $i1                      # |      6,650 |      6,650 |
    jr      $ra2                        # |      6,650 |      6,650 |
be_else.21923:
    li      1, $i1                      # |    110,262 |    110,262 |
    jr      $ra2                        # |    110,262 |    110,262 |
.end shadow_check_one_or_group

######################################################################
# $i1 = shadow_check_one_or_matrix($i12, $i13)
# $ra = $ra3
# [$i1 - $i14]
# [$f1 - $f9]
# []
# [$fg0]
# [$ra - $ra2]
######################################################################
.begin shadow_check_one_or_matrix
shadow_check_one_or_matrix.2868:
    load    [$i13 + $i12], $i14         # |    565,218 |    565,218 |
    load    [$i14 + 0], $i1             # |    565,218 |    565,218 |
    bne     $i1, -1, be_else.21938      # |    565,218 |    565,218 |
be_then.21938:
    li      0, $i1                      # |     10,331 |     10,331 |
    jr      $ra3                        # |     10,331 |     10,331 |
be_else.21938:
    bne     $i1, 99, be_else.21939      # |    554,887 |    554,887 |
be_then.21939:
    li      1, $i1                      # |    544,556 |    544,556 |
.count b_cont
    b       be_cont.21939               # |    544,556 |    544,556 |
be_else.21939:
    load    [ext_objects + $i1], $i2    # |     10,331 |     10,331 |
    load    [ext_intersection_point + 0], $f1# |     10,331 |     10,331 |
    load    [$i2 + 5], $i3              # |     10,331 |     10,331 |
    load    [$i3 + 0], $f2              # |     10,331 |     10,331 |
    fsub    $f1, $f2, $f1               # |     10,331 |     10,331 |
    load    [ext_intersection_point + 1], $f2# |     10,331 |     10,331 |
    load    [$i3 + 1], $f3              # |     10,331 |     10,331 |
    fsub    $f2, $f3, $f2               # |     10,331 |     10,331 |
    load    [ext_intersection_point + 2], $f3# |     10,331 |     10,331 |
    load    [$i3 + 2], $f4              # |     10,331 |     10,331 |
    fsub    $f3, $f4, $f3               # |     10,331 |     10,331 |
    load    [ext_light_dirvec + 1], $i3 # |     10,331 |     10,331 |
    load    [$i3 + $i1], $i1            # |     10,331 |     10,331 |
    load    [$i2 + 1], $i3              # |     10,331 |     10,331 |
    bne     $i3, 1, be_else.21940       # |     10,331 |     10,331 |
be_then.21940:
    load    [ext_light_dirvec + 0], $i3 # |     10,331 |     10,331 |
    load    [$i2 + 4], $i2              # |     10,331 |     10,331 |
    load    [$i2 + 1], $f4              # |     10,331 |     10,331 |
    load    [$i3 + 1], $f5              # |     10,331 |     10,331 |
    load    [$i1 + 0], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f1, $f6               # |     10,331 |     10,331 |
    load    [$i1 + 1], $f7              # |     10,331 |     10,331 |
    fmul    $f6, $f7, $f6               # |     10,331 |     10,331 |
    fmul    $f6, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f2, $f5               # |     10,331 |     10,331 |
    bg      $f4, $f5, ble_else.21941    # |     10,331 |     10,331 |
ble_then.21941:
    li      0, $i4                      # |      6,459 |      6,459 |
.count b_cont
    b       ble_cont.21941              # |      6,459 |      6,459 |
ble_else.21941:
    load    [$i2 + 2], $f4              # |      3,872 |      3,872 |
    load    [$i3 + 2], $f5              # |      3,872 |      3,872 |
    fmul    $f6, $f5, $f5               # |      3,872 |      3,872 |
    fadd_a  $f5, $f3, $f5               # |      3,872 |      3,872 |
    bg      $f4, $f5, ble_else.21942    # |      3,872 |      3,872 |
ble_then.21942:
    li      0, $i4                      # |      3,872 |      3,872 |
.count b_cont
    b       ble_cont.21942              # |      3,872 |      3,872 |
ble_else.21942:
    load    [$i1 + 1], $f4
    bne     $f4, $f0, be_else.21943
be_then.21943:
    li      0, $i4
.count b_cont
    b       be_cont.21943
be_else.21943:
    li      1, $i4
be_cont.21943:
ble_cont.21942:
ble_cont.21941:
    bne     $i4, 0, be_else.21944       # |     10,331 |     10,331 |
be_then.21944:
    load    [$i2 + 0], $f4              # |     10,331 |     10,331 |
    load    [$i3 + 0], $f5              # |     10,331 |     10,331 |
    load    [$i1 + 2], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f2, $f6               # |     10,331 |     10,331 |
    load    [$i1 + 3], $f7              # |     10,331 |     10,331 |
    fmul    $f6, $f7, $f6               # |     10,331 |     10,331 |
    fmul    $f6, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f5               # |     10,331 |     10,331 |
    bg      $f4, $f5, ble_else.21945    # |     10,331 |     10,331 |
ble_then.21945:
    li      0, $i4                      # |      9,076 |      9,076 |
.count b_cont
    b       ble_cont.21945              # |      9,076 |      9,076 |
ble_else.21945:
    load    [$i2 + 2], $f4              # |      1,255 |      1,255 |
    load    [$i3 + 2], $f5              # |      1,255 |      1,255 |
    fmul    $f6, $f5, $f5               # |      1,255 |      1,255 |
    fadd_a  $f5, $f3, $f5               # |      1,255 |      1,255 |
    bg      $f4, $f5, ble_else.21946    # |      1,255 |      1,255 |
ble_then.21946:
    li      0, $i4                      # |      1,255 |      1,255 |
.count b_cont
    b       ble_cont.21946              # |      1,255 |      1,255 |
ble_else.21946:
    load    [$i1 + 3], $f4
    bne     $f4, $f0, be_else.21947
be_then.21947:
    li      0, $i4
.count b_cont
    b       be_cont.21947
be_else.21947:
    li      1, $i4
be_cont.21947:
ble_cont.21946:
ble_cont.21945:
    bne     $i4, 0, be_else.21948       # |     10,331 |     10,331 |
be_then.21948:
    load    [$i2 + 0], $f4              # |     10,331 |     10,331 |
    load    [$i3 + 0], $f5              # |     10,331 |     10,331 |
    load    [$i1 + 4], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f3, $f3               # |     10,331 |     10,331 |
    load    [$i1 + 5], $f6              # |     10,331 |     10,331 |
    fmul    $f3, $f6, $f3               # |     10,331 |     10,331 |
    fmul    $f3, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f1               # |     10,331 |     10,331 |
    bg      $f4, $f1, ble_else.21949    # |     10,331 |     10,331 |
ble_then.21949:
    li      0, $i1                      # |     10,331 |     10,331 |
.count b_cont
    b       be_cont.21940               # |     10,331 |     10,331 |
ble_else.21949:
    load    [$i2 + 1], $f1
    load    [$i3 + 1], $f4
    fmul    $f3, $f4, $f4
    fadd_a  $f4, $f2, $f2
    bg      $f1, $f2, ble_else.21950
ble_then.21950:
    li      0, $i1
.count b_cont
    b       be_cont.21940
ble_else.21950:
    load    [$i1 + 5], $f1
    bne     $f1, $f0, be_else.21951
be_then.21951:
    li      0, $i1
.count b_cont
    b       be_cont.21940
be_else.21951:
    mov     $f3, $fg0
    li      3, $i1
.count b_cont
    b       be_cont.21940
be_else.21948:
    mov     $f6, $fg0
    li      2, $i1
.count b_cont
    b       be_cont.21940
be_else.21944:
    mov     $f6, $fg0
    li      1, $i1
.count b_cont
    b       be_cont.21940
be_else.21940:
    load    [$i1 + 0], $f4
    bne     $i3, 2, be_else.21952
be_then.21952:
    bg      $f0, $f4, ble_else.21953
ble_then.21953:
    li      0, $i1
.count b_cont
    b       be_cont.21952
ble_else.21953:
    load    [$i1 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 2], $f4
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $fg0
    li      1, $i1
.count b_cont
    b       be_cont.21952
be_else.21952:
    bne     $f4, $f0, be_else.21954
be_then.21954:
    li      0, $i1
.count b_cont
    b       be_cont.21954
be_else.21954:
    load    [$i1 + 1], $f5
    fmul    $f5, $f1, $f5
    load    [$i1 + 2], $f6
    fmul    $f6, $f2, $f6
    fadd    $f5, $f6, $f5
    load    [$i1 + 3], $f6
    fmul    $f6, $f3, $f6
    fadd    $f5, $f6, $f5
    fmul    $f5, $f5, $f6
    fmul    $f1, $f1, $f7
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f8
    fmul    $f7, $f8, $f7
    fmul    $f2, $f2, $f8
    load    [$i4 + 1], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f3, $f8
    load    [$i4 + 2], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    load    [$i2 + 3], $i4
    bne     $i4, 0, be_else.21955
be_then.21955:
    mov     $f7, $f1
.count b_cont
    b       be_cont.21955
be_else.21955:
    fmul    $f2, $f3, $f8
    load    [$i2 + 9], $i4
    load    [$i4 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f7, $f8, $f7
    fmul    $f3, $f1, $f3
    load    [$i4 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f7, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i4 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.21955:
    bne     $i3, 3, be_cont.21956
be_then.21956:
    fsub    $f1, $fc0, $f1
be_cont.21956:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, ble_else.21957
ble_then.21957:
    li      0, $i1
.count b_cont
    b       ble_cont.21957
ble_else.21957:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, be_else.21958
be_then.21958:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
.count b_cont
    b       be_cont.21958
be_else.21958:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
be_cont.21958:
ble_cont.21957:
be_cont.21954:
be_cont.21952:
be_cont.21940:
    bne     $i1, 0, be_else.21959       # |     10,331 |     10,331 |
be_then.21959:
    li      0, $i1                      # |     10,331 |     10,331 |
.count b_cont
    b       be_cont.21959               # |     10,331 |     10,331 |
be_else.21959:
    bg      $fc7, $fg0, ble_else.21960
ble_then.21960:
    li      0, $i1
.count b_cont
    b       ble_cont.21960
ble_else.21960:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.21961
be_then.21961:
    li      0, $i1
.count b_cont
    b       be_cont.21961
be_else.21961:
    load    [ext_and_net + $i1], $i9
    li      0, $i8
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21962
be_then.21962:
    li      2, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.21963
be_then.21963:
    li      0, $i1
.count b_cont
    b       be_cont.21962
be_else.21963:
    li      1, $i1
.count b_cont
    b       be_cont.21962
be_else.21962:
    li      1, $i1
be_cont.21962:
be_cont.21961:
ble_cont.21960:
be_cont.21959:
be_cont.21939:
    bne     $i1, 0, be_else.21964       # |    554,887 |    554,887 |
be_then.21964:
    add     $i12, 1, $i12               # |     10,331 |     10,331 |
    load    [$i13 + $i12], $i14         # |     10,331 |     10,331 |
    load    [$i14 + 0], $i1             # |     10,331 |     10,331 |
    bne     $i1, -1, be_else.21965      # |     10,331 |     10,331 |
be_then.21965:
    li      0, $i1
    jr      $ra3
be_else.21965:
    bne     $i1, 99, be_else.21966      # |     10,331 |     10,331 |
be_then.21966:
    li      1, $i1                      # |     10,331 |     10,331 |
.count b_cont
    b       be_cont.21966               # |     10,331 |     10,331 |
be_else.21966:
    call    solver_fast.2796
    bne     $i1, 0, be_else.21967
be_then.21967:
    li      0, $i1
.count b_cont
    b       be_cont.21967
be_else.21967:
    bg      $fc7, $fg0, ble_else.21968
ble_then.21968:
    li      0, $i1
.count b_cont
    b       ble_cont.21968
ble_else.21968:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.21969
be_then.21969:
    li      0, $i1
.count b_cont
    b       be_cont.21969
be_else.21969:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21970
be_then.21970:
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.21971
be_then.21971:
    li      0, $i1
.count b_cont
    b       be_cont.21970
be_else.21971:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21972
be_then.21972:
    li      3, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.21973
be_then.21973:
    li      0, $i1
.count b_cont
    b       be_cont.21970
be_else.21973:
    li      1, $i1
.count b_cont
    b       be_cont.21970
be_else.21972:
    li      1, $i1
.count b_cont
    b       be_cont.21970
be_else.21970:
    li      1, $i1
be_cont.21970:
be_cont.21969:
ble_cont.21968:
be_cont.21967:
be_cont.21966:
    bne     $i1, 0, be_else.21974       # |     10,331 |     10,331 |
be_then.21974:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.21974:
    load    [$i14 + 1], $i1             # |     10,331 |     10,331 |
    bne     $i1, -1, be_else.21975      # |     10,331 |     10,331 |
be_then.21975:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.21975:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i9    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, be_else.21976       # |     10,331 |     10,331 |
be_then.21976:
    load    [$i14 + 2], $i1             # |     10,331 |     10,331 |
    bne     $i1, -1, be_else.21977      # |     10,331 |     10,331 |
be_then.21977:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.21977:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i9    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, be_else.21978       # |     10,331 |     10,331 |
be_then.21978:
    li      3, $i10                     # |     10,331 |     10,331 |
.count move_args
    mov     $i14, $i11                  # |     10,331 |     10,331 |
    jal     shadow_check_one_or_group.2865, $ra2# |     10,331 |     10,331 |
    bne     $i1, 0, be_else.21979       # |     10,331 |     10,331 |
be_then.21979:
    add     $i12, 1, $i12               # |     10,331 |     10,331 |
    b       shadow_check_one_or_matrix.2868# |     10,331 |     10,331 |
be_else.21979:
    li      1, $i1
    jr      $ra3
be_else.21978:
    li      1, $i1
    jr      $ra3
be_else.21976:
    li      1, $i1
    jr      $ra3
be_else.21964:
    load    [$i14 + 1], $i1             # |    544,556 |    544,556 |
    bne     $i1, -1, be_else.21980      # |    544,556 |    544,556 |
be_then.21980:
    li      0, $i1
.count b_cont
    b       be_cont.21980
be_else.21980:
    load    [ext_and_net + $i1], $i9    # |    544,556 |    544,556 |
    li      0, $i8                      # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, be_else.21981       # |    544,556 |    544,556 |
be_then.21981:
    load    [$i14 + 2], $i1             # |    544,556 |    544,556 |
    bne     $i1, -1, be_else.21982      # |    544,556 |    544,556 |
be_then.21982:
    li      0, $i1
.count b_cont
    b       be_cont.21981
be_else.21982:
    li      0, $i8                      # |    544,556 |    544,556 |
    load    [ext_and_net + $i1], $i9    # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, be_else.21983       # |    544,556 |    544,556 |
be_then.21983:
    load    [$i14 + 3], $i1             # |    542,972 |    542,972 |
    bne     $i1, -1, be_else.21984      # |    542,972 |    542,972 |
be_then.21984:
    li      0, $i1
.count b_cont
    b       be_cont.21981
be_else.21984:
    li      0, $i8                      # |    542,972 |    542,972 |
    load    [ext_and_net + $i1], $i9    # |    542,972 |    542,972 |
    jal     shadow_check_and_group.2862, $ra1# |    542,972 |    542,972 |
    bne     $i1, 0, be_else.21985       # |    542,972 |    542,972 |
be_then.21985:
    load    [$i14 + 4], $i1             # |    541,019 |    541,019 |
    bne     $i1, -1, be_else.21986      # |    541,019 |    541,019 |
be_then.21986:
    li      0, $i1
.count b_cont
    b       be_cont.21981
be_else.21986:
    li      0, $i8                      # |    541,019 |    541,019 |
    load    [ext_and_net + $i1], $i9    # |    541,019 |    541,019 |
    jal     shadow_check_and_group.2862, $ra1# |    541,019 |    541,019 |
    bne     $i1, 0, be_else.21987       # |    541,019 |    541,019 |
be_then.21987:
    load    [$i14 + 5], $i1             # |    540,605 |    540,605 |
    bne     $i1, -1, be_else.21988      # |    540,605 |    540,605 |
be_then.21988:
    li      0, $i1                      # |    540,605 |    540,605 |
.count b_cont
    b       be_cont.21981               # |    540,605 |    540,605 |
be_else.21988:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21989
be_then.21989:
    load    [$i14 + 6], $i1
    bne     $i1, -1, be_else.21990
be_then.21990:
    li      0, $i1
.count b_cont
    b       be_cont.21981
be_else.21990:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21991
be_then.21991:
    load    [$i14 + 7], $i1
    bne     $i1, -1, be_else.21992
be_then.21992:
    li      0, $i1
.count b_cont
    b       be_cont.21981
be_else.21992:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.21993
be_then.21993:
    li      8, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
.count b_cont
    b       be_cont.21981
be_else.21993:
    li      1, $i1
.count b_cont
    b       be_cont.21981
be_else.21991:
    li      1, $i1
.count b_cont
    b       be_cont.21981
be_else.21989:
    li      1, $i1
.count b_cont
    b       be_cont.21981
be_else.21987:
    li      1, $i1                      # |        414 |        414 |
.count b_cont
    b       be_cont.21981               # |        414 |        414 |
be_else.21985:
    li      1, $i1                      # |      1,953 |      1,953 |
.count b_cont
    b       be_cont.21981               # |      1,953 |      1,953 |
be_else.21983:
    li      1, $i1                      # |      1,584 |      1,584 |
.count b_cont
    b       be_cont.21981               # |      1,584 |      1,584 |
be_else.21981:
    li      1, $i1
be_cont.21981:
be_cont.21980:
    bne     $i1, 0, be_else.21994       # |    544,556 |    544,556 |
be_then.21994:
    add     $i12, 1, $i12               # |    540,605 |    540,605 |
    load    [$i13 + $i12], $i14         # |    540,605 |    540,605 |
    load    [$i14 + 0], $i1             # |    540,605 |    540,605 |
    bne     $i1, -1, be_else.21995      # |    540,605 |    540,605 |
be_then.21995:
    li      0, $i1                      # |    540,605 |    540,605 |
    jr      $ra3                        # |    540,605 |    540,605 |
be_else.21995:
    bne     $i1, 99, be_else.21996
be_then.21996:
    li      1, $i1
.count b_cont
    b       be_cont.21996
be_else.21996:
    call    solver_fast.2796
    bne     $i1, 0, be_else.21997
be_then.21997:
    li      0, $i1
.count b_cont
    b       be_cont.21997
be_else.21997:
    bg      $fc7, $fg0, ble_else.21998
ble_then.21998:
    li      0, $i1
.count b_cont
    b       ble_cont.21998
ble_else.21998:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.21999
be_then.21999:
    li      0, $i1
.count b_cont
    b       be_cont.21999
be_else.21999:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.22000
be_then.22000:
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22001
be_then.22001:
    li      0, $i1
.count b_cont
    b       be_cont.22000
be_else.22001:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.22002
be_then.22002:
    li      3, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.22003
be_then.22003:
    li      0, $i1
.count b_cont
    b       be_cont.22000
be_else.22003:
    li      1, $i1
.count b_cont
    b       be_cont.22000
be_else.22002:
    li      1, $i1
.count b_cont
    b       be_cont.22000
be_else.22000:
    li      1, $i1
be_cont.22000:
be_cont.21999:
ble_cont.21998:
be_cont.21997:
be_cont.21996:
    bne     $i1, 0, be_else.22004
be_then.22004:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.22004:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22005
be_then.22005:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.22005:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.22006
be_then.22006:
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22007
be_then.22007:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.22007:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, be_else.22008
be_then.22008:
    li      3, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, be_else.22009
be_then.22009:
    add     $i12, 1, $i12
    b       shadow_check_one_or_matrix.2868
be_else.22009:
    li      1, $i1
    jr      $ra3
be_else.22008:
    li      1, $i1
    jr      $ra3
be_else.22006:
    li      1, $i1
    jr      $ra3
be_else.21994:
    li      1, $i1                      # |      3,951 |      3,951 |
    jr      $ra3                        # |      3,951 |      3,951 |
.end shadow_check_one_or_matrix

######################################################################
# solve_each_element($i8, $i9, $i10)
# $ra = $ra1
# [$i1 - $i12]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element
solve_each_element.2871:
    load    [$i9 + $i8], $i11           # |    193,311 |    193,311 |
    bne     $i11, -1, be_else.22010     # |    193,311 |    193,311 |
be_then.22010:
    jr      $ra1                        # |     43,491 |     43,491 |
be_else.22010:
    load    [ext_objects + $i11], $i1   # |    149,820 |    149,820 |
    load    [$i1 + 5], $i2              # |    149,820 |    149,820 |
    load    [$i1 + 1], $i3              # |    149,820 |    149,820 |
    load    [$i2 + 0], $f1              # |    149,820 |    149,820 |
    fsub    $fg17, $f1, $f1             # |    149,820 |    149,820 |
    load    [$i2 + 1], $f2              # |    149,820 |    149,820 |
    fsub    $fg18, $f2, $f2             # |    149,820 |    149,820 |
    load    [$i2 + 2], $f3              # |    149,820 |    149,820 |
    fsub    $fg19, $f3, $f3             # |    149,820 |    149,820 |
    load    [$i10 + 0], $f4             # |    149,820 |    149,820 |
    bne     $i3, 1, be_else.22011       # |    149,820 |    149,820 |
be_then.22011:
    bne     $f4, $f0, be_else.22012     # |     50,858 |     50,858 |
be_then.22012:
    li      0, $i2
.count b_cont
    b       be_cont.22012
be_else.22012:
    load    [$i1 + 4], $i2              # |     50,858 |     50,858 |
    load    [$i1 + 6], $i3              # |     50,858 |     50,858 |
    bg      $f0, $f4, ble_else.22013    # |     50,858 |     50,858 |
ble_then.22013:
    li      0, $i4                      # |     50,160 |     50,160 |
.count b_cont
    b       ble_cont.22013              # |     50,160 |     50,160 |
ble_else.22013:
    li      1, $i4                      # |        698 |        698 |
ble_cont.22013:
    bne     $i3, 0, be_else.22014       # |     50,858 |     50,858 |
be_then.22014:
    mov     $i4, $i3                    # |     50,858 |     50,858 |
.count b_cont
    b       be_cont.22014               # |     50,858 |     50,858 |
be_else.22014:
    bne     $i4, 0, be_else.22015
be_then.22015:
    li      1, $i3
.count b_cont
    b       be_cont.22015
be_else.22015:
    li      0, $i3
be_cont.22015:
be_cont.22014:
    load    [$i2 + 0], $f5              # |     50,858 |     50,858 |
    bne     $i3, 0, be_cont.22016       # |     50,858 |     50,858 |
be_then.22016:
    fneg    $f5, $f5                    # |     50,160 |     50,160 |
be_cont.22016:
    fsub    $f5, $f1, $f5               # |     50,858 |     50,858 |
    finv    $f4, $f4                    # |     50,858 |     50,858 |
    fmul    $f5, $f4, $f4               # |     50,858 |     50,858 |
    load    [$i2 + 1], $f5              # |     50,858 |     50,858 |
    load    [$i10 + 1], $f6             # |     50,858 |     50,858 |
    fmul    $f4, $f6, $f6               # |     50,858 |     50,858 |
    fadd_a  $f6, $f2, $f6               # |     50,858 |     50,858 |
    bg      $f5, $f6, ble_else.22017    # |     50,858 |     50,858 |
ble_then.22017:
    li      0, $i2                      # |     41,048 |     41,048 |
.count b_cont
    b       ble_cont.22017              # |     41,048 |     41,048 |
ble_else.22017:
    load    [$i2 + 2], $f5              # |      9,810 |      9,810 |
    load    [$i10 + 2], $f6             # |      9,810 |      9,810 |
    fmul    $f4, $f6, $f6               # |      9,810 |      9,810 |
    fadd_a  $f6, $f3, $f6               # |      9,810 |      9,810 |
    bg      $f5, $f6, ble_else.22018    # |      9,810 |      9,810 |
ble_then.22018:
    li      0, $i2                      # |      5,699 |      5,699 |
.count b_cont
    b       ble_cont.22018              # |      5,699 |      5,699 |
ble_else.22018:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |
    li      1, $i2                      # |      4,111 |      4,111 |
ble_cont.22018:
ble_cont.22017:
be_cont.22012:
    bne     $i2, 0, be_else.22019       # |     50,858 |     50,858 |
be_then.22019:
    load    [$i10 + 1], $f4             # |     46,747 |     46,747 |
    bne     $f4, $f0, be_else.22020     # |     46,747 |     46,747 |
be_then.22020:
    li      0, $i2
.count b_cont
    b       be_cont.22020
be_else.22020:
    load    [$i1 + 4], $i2              # |     46,747 |     46,747 |
    load    [$i1 + 6], $i3              # |     46,747 |     46,747 |
    bg      $f0, $f4, ble_else.22021    # |     46,747 |     46,747 |
ble_then.22021:
    li      0, $i4                      # |        217 |        217 |
.count b_cont
    b       ble_cont.22021              # |        217 |        217 |
ble_else.22021:
    li      1, $i4                      # |     46,530 |     46,530 |
ble_cont.22021:
    bne     $i3, 0, be_else.22022       # |     46,747 |     46,747 |
be_then.22022:
    mov     $i4, $i3                    # |     46,747 |     46,747 |
.count b_cont
    b       be_cont.22022               # |     46,747 |     46,747 |
be_else.22022:
    bne     $i4, 0, be_else.22023
be_then.22023:
    li      1, $i3
.count b_cont
    b       be_cont.22023
be_else.22023:
    li      0, $i3
be_cont.22023:
be_cont.22022:
    load    [$i2 + 1], $f5              # |     46,747 |     46,747 |
    bne     $i3, 0, be_cont.22024       # |     46,747 |     46,747 |
be_then.22024:
    fneg    $f5, $f5                    # |        217 |        217 |
be_cont.22024:
    fsub    $f5, $f2, $f5               # |     46,747 |     46,747 |
    finv    $f4, $f4                    # |     46,747 |     46,747 |
    fmul    $f5, $f4, $f4               # |     46,747 |     46,747 |
    load    [$i2 + 2], $f5              # |     46,747 |     46,747 |
    load    [$i10 + 2], $f6             # |     46,747 |     46,747 |
    fmul    $f4, $f6, $f6               # |     46,747 |     46,747 |
    fadd_a  $f6, $f3, $f6               # |     46,747 |     46,747 |
    bg      $f5, $f6, ble_else.22025    # |     46,747 |     46,747 |
ble_then.22025:
    li      0, $i2                      # |     28,211 |     28,211 |
.count b_cont
    b       ble_cont.22025              # |     28,211 |     28,211 |
ble_else.22025:
    load    [$i2 + 0], $f5              # |     18,536 |     18,536 |
    load    [$i10 + 0], $f6             # |     18,536 |     18,536 |
    fmul    $f4, $f6, $f6               # |     18,536 |     18,536 |
    fadd_a  $f6, $f1, $f6               # |     18,536 |     18,536 |
    bg      $f5, $f6, ble_else.22026    # |     18,536 |     18,536 |
ble_then.22026:
    li      0, $i2                      # |      6,456 |      6,456 |
.count b_cont
    b       ble_cont.22026              # |      6,456 |      6,456 |
ble_else.22026:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |
    li      1, $i2                      # |     12,080 |     12,080 |
ble_cont.22026:
ble_cont.22025:
be_cont.22020:
    bne     $i2, 0, be_else.22027       # |     46,747 |     46,747 |
be_then.22027:
    load    [$i10 + 2], $f4             # |     34,667 |     34,667 |
    bne     $f4, $f0, be_else.22028     # |     34,667 |     34,667 |
be_then.22028:
    li      0, $i12
.count b_cont
    b       be_cont.22011
be_else.22028:
    load    [$i1 + 4], $i2              # |     34,667 |     34,667 |
    load    [$i2 + 0], $f5              # |     34,667 |     34,667 |
    load    [$i10 + 0], $f6             # |     34,667 |     34,667 |
    load    [$i1 + 6], $i1              # |     34,667 |     34,667 |
    bg      $f0, $f4, ble_else.22029    # |     34,667 |     34,667 |
ble_then.22029:
    li      0, $i3                      # |     24,683 |     24,683 |
.count b_cont
    b       ble_cont.22029              # |     24,683 |     24,683 |
ble_else.22029:
    li      1, $i3                      # |      9,984 |      9,984 |
ble_cont.22029:
    bne     $i1, 0, be_else.22030       # |     34,667 |     34,667 |
be_then.22030:
    mov     $i3, $i1                    # |     34,667 |     34,667 |
.count b_cont
    b       be_cont.22030               # |     34,667 |     34,667 |
be_else.22030:
    bne     $i3, 0, be_else.22031
be_then.22031:
    li      1, $i1
.count b_cont
    b       be_cont.22031
be_else.22031:
    li      0, $i1
be_cont.22031:
be_cont.22030:
    load    [$i2 + 2], $f7              # |     34,667 |     34,667 |
    bne     $i1, 0, be_cont.22032       # |     34,667 |     34,667 |
be_then.22032:
    fneg    $f7, $f7                    # |     24,683 |     24,683 |
be_cont.22032:
    fsub    $f7, $f3, $f3               # |     34,667 |     34,667 |
    finv    $f4, $f4                    # |     34,667 |     34,667 |
    fmul    $f3, $f4, $f3               # |     34,667 |     34,667 |
    fmul    $f3, $f6, $f4               # |     34,667 |     34,667 |
    fadd_a  $f4, $f1, $f1               # |     34,667 |     34,667 |
    bg      $f5, $f1, ble_else.22033    # |     34,667 |     34,667 |
ble_then.22033:
    li      0, $i12                     # |     18,798 |     18,798 |
.count b_cont
    b       be_cont.22011               # |     18,798 |     18,798 |
ble_else.22033:
    load    [$i2 + 1], $f1              # |     15,869 |     15,869 |
    load    [$i10 + 1], $f4             # |     15,869 |     15,869 |
    fmul    $f3, $f4, $f4               # |     15,869 |     15,869 |
    fadd_a  $f4, $f2, $f2               # |     15,869 |     15,869 |
    bg      $f1, $f2, ble_else.22034    # |     15,869 |     15,869 |
ble_then.22034:
    li      0, $i12                     # |     12,844 |     12,844 |
.count b_cont
    b       be_cont.22011               # |     12,844 |     12,844 |
ble_else.22034:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |
    li      3, $i12                     # |      3,025 |      3,025 |
.count b_cont
    b       be_cont.22011               # |      3,025 |      3,025 |
be_else.22027:
    li      2, $i12                     # |     12,080 |     12,080 |
.count b_cont
    b       be_cont.22011               # |     12,080 |     12,080 |
be_else.22019:
    li      1, $i12                     # |      4,111 |      4,111 |
.count b_cont
    b       be_cont.22011               # |      4,111 |      4,111 |
be_else.22011:
    bne     $i3, 2, be_else.22035       # |     98,962 |     98,962 |
be_then.22035:
    load    [$i1 + 4], $i1              # |     24,693 |     24,693 |
    load    [$i1 + 0], $f5              # |     24,693 |     24,693 |
    fmul    $f4, $f5, $f4               # |     24,693 |     24,693 |
    load    [$i10 + 1], $f6             # |     24,693 |     24,693 |
    load    [$i1 + 1], $f7              # |     24,693 |     24,693 |
    fmul    $f6, $f7, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    load    [$i10 + 2], $f6             # |     24,693 |     24,693 |
    load    [$i1 + 2], $f8              # |     24,693 |     24,693 |
    fmul    $f6, $f8, $f6               # |     24,693 |     24,693 |
    fadd    $f4, $f6, $f4               # |     24,693 |     24,693 |
    bg      $f4, $f0, ble_else.22036    # |     24,693 |     24,693 |
ble_then.22036:
    li      0, $i12                     # |      7,535 |      7,535 |
.count b_cont
    b       be_cont.22035               # |      7,535 |      7,535 |
ble_else.22036:
    fmul    $f5, $f1, $f1               # |     17,158 |     17,158 |
    fmul    $f7, $f2, $f2               # |     17,158 |     17,158 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |
    fmul    $f8, $f3, $f2               # |     17,158 |     17,158 |
    fadd_n  $f1, $f2, $f1               # |     17,158 |     17,158 |
    finv    $f4, $f2                    # |     17,158 |     17,158 |
    fmul    $f1, $f2, $fg0              # |     17,158 |     17,158 |
    li      1, $i12                     # |     17,158 |     17,158 |
.count b_cont
    b       be_cont.22035               # |     17,158 |     17,158 |
be_else.22035:
    load    [$i1 + 3], $i2              # |     74,269 |     74,269 |
    load    [$i1 + 4], $i4              # |     74,269 |     74,269 |
    load    [$i10 + 1], $f5             # |     74,269 |     74,269 |
    load    [$i10 + 2], $f6             # |     74,269 |     74,269 |
    fmul    $f4, $f4, $f7               # |     74,269 |     74,269 |
    load    [$i4 + 0], $f8              # |     74,269 |     74,269 |
    fmul    $f7, $f8, $f7               # |     74,269 |     74,269 |
    fmul    $f5, $f5, $f9               # |     74,269 |     74,269 |
    load    [$i4 + 1], $f10             # |     74,269 |     74,269 |
    fmul    $f9, $f10, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    fmul    $f6, $f6, $f9               # |     74,269 |     74,269 |
    load    [$i4 + 2], $f11             # |     74,269 |     74,269 |
    fmul    $f9, $f11, $f9              # |     74,269 |     74,269 |
    fadd    $f7, $f9, $f7               # |     74,269 |     74,269 |
    be      $i2, 0, bne_cont.22037      # |     74,269 |     74,269 |
bne_then.22037:
    fmul    $f5, $f6, $f9
    load    [$i1 + 9], $i4
    load    [$i4 + 0], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f6, $f4, $f9
    load    [$i4 + 1], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
    fmul    $f4, $f5, $f9
    load    [$i4 + 2], $f12
    fmul    $f9, $f12, $f9
    fadd    $f7, $f9, $f7
bne_cont.22037:
    bne     $f7, $f0, be_else.22038     # |     74,269 |     74,269 |
be_then.22038:
    li      0, $i12
.count b_cont
    b       be_cont.22038
be_else.22038:
    fmul    $f4, $f1, $f9               # |     74,269 |     74,269 |
    fmul    $f9, $f8, $f9               # |     74,269 |     74,269 |
    fmul    $f5, $f2, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f10, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    fmul    $f6, $f3, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f11, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    bne     $i2, 0, be_else.22039       # |     74,269 |     74,269 |
be_then.22039:
    mov     $f9, $f4                    # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.22039               # |     74,269 |     74,269 |
be_else.22039:
    fmul    $f6, $f2, $f12
    fmul    $f5, $f3, $f13
    fadd    $f12, $f13, $f12
    load    [$i1 + 9], $i4
    load    [$i4 + 0], $f13
    fmul    $f12, $f13, $f12
    fmul    $f4, $f3, $f13
    fmul    $f6, $f1, $f6
    fadd    $f13, $f6, $f6
    load    [$i4 + 1], $f13
    fmul    $f6, $f13, $f6
    fadd    $f12, $f6, $f6
    fmul    $f4, $f2, $f4
    fmul    $f5, $f1, $f5
    fadd    $f4, $f5, $f4
    load    [$i4 + 2], $f5
    fmul    $f4, $f5, $f4
    fadd    $f6, $f4, $f4
    fmul    $f4, $fc4, $f4
    fadd    $f9, $f4, $f4
be_cont.22039:
    fmul    $f4, $f4, $f5               # |     74,269 |     74,269 |
    fmul    $f1, $f1, $f6               # |     74,269 |     74,269 |
    fmul    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f2, $f2, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f10, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f3, $f3, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f11, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    bne     $i2, 0, be_else.22040       # |     74,269 |     74,269 |
be_then.22040:
    mov     $f6, $f1                    # |     74,269 |     74,269 |
.count b_cont
    b       be_cont.22040               # |     74,269 |     74,269 |
be_else.22040:
    fmul    $f2, $f3, $f8
    load    [$i1 + 9], $i2
    load    [$i2 + 0], $f9
    fmul    $f8, $f9, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f1, $f3
    load    [$i2 + 1], $f8
    fmul    $f3, $f8, $f3
    fadd    $f6, $f3, $f3
    fmul    $f1, $f2, $f1
    load    [$i2 + 2], $f2
    fmul    $f1, $f2, $f1
    fadd    $f3, $f1, $f1
be_cont.22040:
    bne     $i3, 3, be_cont.22041       # |     74,269 |     74,269 |
be_then.22041:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |
be_cont.22041:
    fmul    $f7, $f1, $f1               # |     74,269 |     74,269 |
    fsub    $f5, $f1, $f1               # |     74,269 |     74,269 |
    bg      $f1, $f0, ble_else.22042    # |     74,269 |     74,269 |
ble_then.22042:
    li      0, $i12                     # |     62,376 |     62,376 |
.count b_cont
    b       ble_cont.22042              # |     62,376 |     62,376 |
ble_else.22042:
    load    [$i1 + 6], $i1              # |     11,893 |     11,893 |
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |
    li      1, $i12                     # |     11,893 |     11,893 |
    finv    $f7, $f2                    # |     11,893 |     11,893 |
    bne     $i1, 0, be_else.22043       # |     11,893 |     11,893 |
be_then.22043:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |
    fsub    $f1, $f4, $f1               # |      9,138 |      9,138 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |
.count b_cont
    b       be_cont.22043               # |      9,138 |      9,138 |
be_else.22043:
    fsub    $f1, $f4, $f1               # |      2,755 |      2,755 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |
be_cont.22043:
ble_cont.22042:
be_cont.22038:
be_cont.22035:
be_cont.22011:
    bne     $i12, 0, be_else.22044      # |    149,820 |    149,820 |
be_then.22044:
    load    [ext_objects + $i11], $i1   # |    101,553 |    101,553 |
    load    [$i1 + 6], $i1              # |    101,553 |    101,553 |
    bne     $i1, 0, be_else.22045       # |    101,553 |    101,553 |
be_then.22045:
    jr      $ra1                        # |     92,181 |     92,181 |
be_else.22045:
    add     $i8, 1, $i8                 # |      9,372 |      9,372 |
    b       solve_each_element.2871     # |      9,372 |      9,372 |
be_else.22044:
    bg      $fg0, $f0, ble_else.22046   # |     48,267 |     48,267 |
ble_then.22046:
    add     $i8, 1, $i8                 # |        847 |        847 |
    b       solve_each_element.2871     # |        847 |        847 |
ble_else.22046:
    bg      $fg7, $fg0, ble_else.22047  # |     47,420 |     47,420 |
ble_then.22047:
    add     $i8, 1, $i8                 # |     11,681 |     11,681 |
    b       solve_each_element.2871     # |     11,681 |     11,681 |
ble_else.22047:
    li      0, $i1                      # |     35,739 |     35,739 |
    load    [$i10 + 0], $f1             # |     35,739 |     35,739 |
    fadd    $fg0, $fc15, $f10           # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg17, $f11            # |     35,739 |     35,739 |
    load    [$i10 + 1], $f1             # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg18, $f12            # |     35,739 |     35,739 |
    load    [$i10 + 2], $f1             # |     35,739 |     35,739 |
    fmul    $f1, $f10, $f1              # |     35,739 |     35,739 |
    fadd    $f1, $fg19, $f13            # |     35,739 |     35,739 |
.count move_args
    mov     $i9, $i3                    # |     35,739 |     35,739 |
.count move_args
    mov     $f11, $f2                   # |     35,739 |     35,739 |
.count move_args
    mov     $f12, $f3                   # |     35,739 |     35,739 |
.count move_args
    mov     $f13, $f4                   # |     35,739 |     35,739 |
    call    check_all_inside.2856       # |     35,739 |     35,739 |
    add     $i8, 1, $i8                 # |     35,739 |     35,739 |
    be      $i1, 0, solve_each_element.2871# |     35,739 |     35,739 |
    mov     $f10, $fg7                  # |     25,163 |     25,163 |
    store   $f11, [ext_intersection_point + 0]# |     25,163 |     25,163 |
    store   $f12, [ext_intersection_point + 1]# |     25,163 |     25,163 |
    store   $f13, [ext_intersection_point + 2]# |     25,163 |     25,163 |
    mov     $i11, $ig3                  # |     25,163 |     25,163 |
    mov     $i12, $ig2                  # |     25,163 |     25,163 |
    b       solve_each_element.2871     # |     25,163 |     25,163 |
.end solve_each_element

######################################################################
# solve_one_or_network($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network
solve_one_or_network.2875:
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22049      # |      6,776 |      6,776 |
be_then.22049:
    jr      $ra2
be_else.22049:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22050      # |      6,776 |      6,776 |
be_then.22050:
    jr      $ra2
be_else.22050:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22051      # |      6,776 |      6,776 |
be_then.22051:
    jr      $ra2
be_else.22051:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22052      # |      6,776 |      6,776 |
be_then.22052:
    jr      $ra2
be_else.22052:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22053      # |      6,776 |      6,776 |
be_then.22053:
    jr      $ra2
be_else.22053:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22054      # |      6,776 |      6,776 |
be_then.22054:
    jr      $ra2
be_else.22054:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    bne     $i1, -1, be_else.22055      # |      6,776 |      6,776 |
be_then.22055:
    jr      $ra2                        # |      6,776 |      6,776 |
be_else.22055:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element.2871, $ra1
    add     $i13, 1, $i13
    load    [$i14 + $i13], $i1
    bne     $i1, -1, be_else.22056
be_then.22056:
    jr      $ra2
be_else.22056:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element.2871, $ra1
    add     $i13, 1, $i13
    b       solve_one_or_network.2875
.end solve_one_or_network

######################################################################
# trace_or_matrix($i16, $i17, $i18)
# $ra = $ra3
# [$i1 - $i18]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix
trace_or_matrix.2879:
    load    [$i17 + $i16], $i14         # |     23,754 |     23,754 |
    load    [$i14 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, be_else.22057      # |     23,754 |     23,754 |
be_then.22057:
    jr      $ra3
be_else.22057:
    bne     $i1, 99, be_else.22058      # |     23,754 |     23,754 |
be_then.22058:
    load    [$i14 + 1], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22059     # |     23,754 |     23,754 |
bne_then.22059:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 2], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22060     # |     23,754 |     23,754 |
bne_then.22060:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 3], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22061     # |     23,754 |     23,754 |
bne_then.22061:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 4], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22062     # |     23,754 |     23,754 |
bne_then.22062:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 5], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22063     # |     23,754 |     23,754 |
bne_then.22063:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 6], $i1
    be      $i1, -1, bne_cont.22064
bne_then.22064:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    li      7, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network.2875, $ra2
bne_cont.22064:
bne_cont.22063:
bne_cont.22062:
bne_cont.22061:
bne_cont.22060:
bne_cont.22059:
    add     $i16, 1, $i16               # |     23,754 |     23,754 |
    load    [$i17 + $i16], $i14         # |     23,754 |     23,754 |
    load    [$i14 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, be_else.22065      # |     23,754 |     23,754 |
be_then.22065:
    jr      $ra3                        # |     23,754 |     23,754 |
be_else.22065:
    bne     $i1, 99, be_else.22066
be_then.22066:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22067
be_then.22067:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22067:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22068
be_then.22068:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22068:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 3], $i1
    bne     $i1, -1, be_else.22069
be_then.22069:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22069:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 4], $i1
    bne     $i1, -1, be_else.22070
be_then.22070:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22070:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    li      5, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network.2875, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22066:
.count move_args
    mov     $i18, $i2
    call    solver.2773
    bne     $i1, 0, be_else.22071
be_then.22071:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22071:
    bg      $fg7, $fg0, ble_else.22072
ble_then.22072:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
ble_else.22072:
    li      1, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network.2875, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22058:
.count move_args
    mov     $i18, $i2
    call    solver.2773
    bne     $i1, 0, be_else.22073
be_then.22073:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
be_else.22073:
    bg      $fg7, $fg0, ble_else.22074
ble_then.22074:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
ble_else.22074:
    li      1, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network.2875, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
.end trace_or_matrix

######################################################################
# solve_each_element_fast($i8, $i9, $i10)
# $ra = $ra1
# [$i1 - $i12]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra]
######################################################################
.begin solve_each_element_fast
solve_each_element_fast.2885:
    load    [$i9 + $i8], $i11           # | 13,852,171 | 13,852,171 |
    bne     $i11, -1, be_else.22075     # | 13,852,171 | 13,852,171 |
be_then.22075:
    jr      $ra1                        # |  3,308,077 |  3,308,077 |
be_else.22075:
    load    [ext_objects + $i11], $i1   # | 10,544,094 | 10,544,094 |
    load    [$i1 + 10], $i2             # | 10,544,094 | 10,544,094 |
    load    [$i10 + 1], $i3             # | 10,544,094 | 10,544,094 |
    load    [$i1 + 1], $i4              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 0], $f1              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 1], $f2              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 2], $f3              # | 10,544,094 | 10,544,094 |
    load    [$i3 + $i11], $i3           # | 10,544,094 | 10,544,094 |
    bne     $i4, 1, be_else.22076       # | 10,544,094 | 10,544,094 |
be_then.22076:
    load    [$i10 + 0], $i2             # |  3,873,912 |  3,873,912 |
    load    [$i1 + 4], $i1              # |  3,873,912 |  3,873,912 |
    load    [$i1 + 1], $f4              # |  3,873,912 |  3,873,912 |
    load    [$i2 + 1], $f5              # |  3,873,912 |  3,873,912 |
    load    [$i3 + 0], $f6              # |  3,873,912 |  3,873,912 |
    fsub    $f6, $f1, $f6               # |  3,873,912 |  3,873,912 |
    load    [$i3 + 1], $f7              # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f7, $f6               # |  3,873,912 |  3,873,912 |
    fmul    $f6, $f5, $f5               # |  3,873,912 |  3,873,912 |
    fadd_a  $f5, $f2, $f5               # |  3,873,912 |  3,873,912 |
    bg      $f4, $f5, ble_else.22077    # |  3,873,912 |  3,873,912 |
ble_then.22077:
    li      0, $i4                      # |  3,045,774 |  3,045,774 |
.count b_cont
    b       ble_cont.22077              # |  3,045,774 |  3,045,774 |
ble_else.22077:
    load    [$i1 + 2], $f4              # |    828,138 |    828,138 |
    load    [$i2 + 2], $f5              # |    828,138 |    828,138 |
    fmul    $f6, $f5, $f5               # |    828,138 |    828,138 |
    fadd_a  $f5, $f3, $f5               # |    828,138 |    828,138 |
    bg      $f4, $f5, ble_else.22078    # |    828,138 |    828,138 |
ble_then.22078:
    li      0, $i4                      # |    324,692 |    324,692 |
.count b_cont
    b       ble_cont.22078              # |    324,692 |    324,692 |
ble_else.22078:
    load    [$i3 + 1], $f4              # |    503,446 |    503,446 |
    bne     $f4, $f0, be_else.22079     # |    503,446 |    503,446 |
be_then.22079:
    li      0, $i4
.count b_cont
    b       be_cont.22079
be_else.22079:
    li      1, $i4                      # |    503,446 |    503,446 |
be_cont.22079:
ble_cont.22078:
ble_cont.22077:
    bne     $i4, 0, be_else.22080       # |  3,873,912 |  3,873,912 |
be_then.22080:
    load    [$i1 + 0], $f4              # |  3,370,466 |  3,370,466 |
    load    [$i2 + 0], $f5              # |  3,370,466 |  3,370,466 |
    load    [$i3 + 2], $f6              # |  3,370,466 |  3,370,466 |
    fsub    $f6, $f2, $f6               # |  3,370,466 |  3,370,466 |
    load    [$i3 + 3], $f7              # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f7, $f6               # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f5, $f5               # |  3,370,466 |  3,370,466 |
    fadd_a  $f5, $f1, $f5               # |  3,370,466 |  3,370,466 |
    bg      $f4, $f5, ble_else.22081    # |  3,370,466 |  3,370,466 |
ble_then.22081:
    li      0, $i4                      # |  1,577,235 |  1,577,235 |
.count b_cont
    b       ble_cont.22081              # |  1,577,235 |  1,577,235 |
ble_else.22081:
    load    [$i1 + 2], $f4              # |  1,793,231 |  1,793,231 |
    load    [$i2 + 2], $f5              # |  1,793,231 |  1,793,231 |
    fmul    $f6, $f5, $f5               # |  1,793,231 |  1,793,231 |
    fadd_a  $f5, $f3, $f5               # |  1,793,231 |  1,793,231 |
    bg      $f4, $f5, ble_else.22082    # |  1,793,231 |  1,793,231 |
ble_then.22082:
    li      0, $i4                      # |    570,575 |    570,575 |
.count b_cont
    b       ble_cont.22082              # |    570,575 |    570,575 |
ble_else.22082:
    load    [$i3 + 3], $f4              # |  1,222,656 |  1,222,656 |
    bne     $f4, $f0, be_else.22083     # |  1,222,656 |  1,222,656 |
be_then.22083:
    li      0, $i4
.count b_cont
    b       be_cont.22083
be_else.22083:
    li      1, $i4                      # |  1,222,656 |  1,222,656 |
be_cont.22083:
ble_cont.22082:
ble_cont.22081:
    bne     $i4, 0, be_else.22084       # |  3,370,466 |  3,370,466 |
be_then.22084:
    load    [$i1 + 0], $f4              # |  2,147,810 |  2,147,810 |
    load    [$i2 + 0], $f5              # |  2,147,810 |  2,147,810 |
    load    [$i3 + 4], $f6              # |  2,147,810 |  2,147,810 |
    fsub    $f6, $f3, $f3               # |  2,147,810 |  2,147,810 |
    load    [$i3 + 5], $f6              # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f6, $f3               # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f5, $f5               # |  2,147,810 |  2,147,810 |
    fadd_a  $f5, $f1, $f1               # |  2,147,810 |  2,147,810 |
    bg      $f4, $f1, ble_else.22085    # |  2,147,810 |  2,147,810 |
ble_then.22085:
    li      0, $i12                     # |  1,541,243 |  1,541,243 |
.count b_cont
    b       be_cont.22076               # |  1,541,243 |  1,541,243 |
ble_else.22085:
    load    [$i1 + 1], $f1              # |    606,567 |    606,567 |
    load    [$i2 + 1], $f4              # |    606,567 |    606,567 |
    fmul    $f3, $f4, $f4               # |    606,567 |    606,567 |
    fadd_a  $f4, $f2, $f2               # |    606,567 |    606,567 |
    bg      $f1, $f2, ble_else.22086    # |    606,567 |    606,567 |
ble_then.22086:
    li      0, $i12                     # |    331,991 |    331,991 |
.count b_cont
    b       be_cont.22076               # |    331,991 |    331,991 |
ble_else.22086:
    load    [$i3 + 5], $f1              # |    274,576 |    274,576 |
    bne     $f1, $f0, be_else.22087     # |    274,576 |    274,576 |
be_then.22087:
    li      0, $i12
.count b_cont
    b       be_cont.22076
be_else.22087:
    mov     $f3, $fg0                   # |    274,576 |    274,576 |
    li      3, $i12                     # |    274,576 |    274,576 |
.count b_cont
    b       be_cont.22076               # |    274,576 |    274,576 |
be_else.22084:
    mov     $f6, $fg0                   # |  1,222,656 |  1,222,656 |
    li      2, $i12                     # |  1,222,656 |  1,222,656 |
.count b_cont
    b       be_cont.22076               # |  1,222,656 |  1,222,656 |
be_else.22080:
    mov     $f6, $fg0                   # |    503,446 |    503,446 |
    li      1, $i12                     # |    503,446 |    503,446 |
.count b_cont
    b       be_cont.22076               # |    503,446 |    503,446 |
be_else.22076:
    bne     $i4, 2, be_else.22088       # |  6,670,182 |  6,670,182 |
be_then.22088:
    load    [$i3 + 0], $f1              # |  1,242,326 |  1,242,326 |
    bg      $f0, $f1, ble_else.22089    # |  1,242,326 |  1,242,326 |
ble_then.22089:
    li      0, $i12                     # |    647,017 |    647,017 |
.count b_cont
    b       be_cont.22088               # |    647,017 |    647,017 |
ble_else.22089:
    load    [$i2 + 3], $f2              # |    595,309 |    595,309 |
    fmul    $f1, $f2, $fg0              # |    595,309 |    595,309 |
    li      1, $i12                     # |    595,309 |    595,309 |
.count b_cont
    b       be_cont.22088               # |    595,309 |    595,309 |
be_else.22088:
    load    [$i3 + 0], $f4              # |  5,427,856 |  5,427,856 |
    bne     $f4, $f0, be_else.22090     # |  5,427,856 |  5,427,856 |
be_then.22090:
    li      0, $i12
.count b_cont
    b       be_cont.22090
be_else.22090:
    load    [$i3 + 1], $f5              # |  5,427,856 |  5,427,856 |
    fmul    $f5, $f1, $f1               # |  5,427,856 |  5,427,856 |
    load    [$i3 + 2], $f5              # |  5,427,856 |  5,427,856 |
    fmul    $f5, $f2, $f2               # |  5,427,856 |  5,427,856 |
    fadd    $f1, $f2, $f1               # |  5,427,856 |  5,427,856 |
    load    [$i3 + 3], $f2              # |  5,427,856 |  5,427,856 |
    fmul    $f2, $f3, $f2               # |  5,427,856 |  5,427,856 |
    fadd    $f1, $f2, $f1               # |  5,427,856 |  5,427,856 |
    fmul    $f1, $f1, $f2               # |  5,427,856 |  5,427,856 |
    load    [$i2 + 3], $f3              # |  5,427,856 |  5,427,856 |
    fmul    $f4, $f3, $f3               # |  5,427,856 |  5,427,856 |
    fsub    $f2, $f3, $f2               # |  5,427,856 |  5,427,856 |
    bg      $f2, $f0, ble_else.22091    # |  5,427,856 |  5,427,856 |
ble_then.22091:
    li      0, $i12                     # |  3,746,988 |  3,746,988 |
.count b_cont
    b       ble_cont.22091              # |  3,746,988 |  3,746,988 |
ble_else.22091:
    load    [$i1 + 6], $i1              # |  1,680,868 |  1,680,868 |
    li      1, $i12                     # |  1,680,868 |  1,680,868 |
    fsqrt   $f2, $f2                    # |  1,680,868 |  1,680,868 |
    bne     $i1, 0, be_else.22092       # |  1,680,868 |  1,680,868 |
be_then.22092:
    fsub    $f1, $f2, $f1               # |  1,260,056 |  1,260,056 |
    load    [$i3 + 4], $f2              # |  1,260,056 |  1,260,056 |
    fmul    $f1, $f2, $fg0              # |  1,260,056 |  1,260,056 |
.count b_cont
    b       be_cont.22092               # |  1,260,056 |  1,260,056 |
be_else.22092:
    fadd    $f1, $f2, $f1               # |    420,812 |    420,812 |
    load    [$i3 + 4], $f2              # |    420,812 |    420,812 |
    fmul    $f1, $f2, $fg0              # |    420,812 |    420,812 |
be_cont.22092:
ble_cont.22091:
be_cont.22090:
be_cont.22088:
be_cont.22076:
    bne     $i12, 0, be_else.22093      # | 10,544,094 | 10,544,094 |
be_then.22093:
    load    [ext_objects + $i11], $i1   # |  6,267,239 |  6,267,239 |
    load    [$i1 + 6], $i1              # |  6,267,239 |  6,267,239 |
    bne     $i1, 0, be_else.22094       # |  6,267,239 |  6,267,239 |
be_then.22094:
    jr      $ra1                        # |  5,339,331 |  5,339,331 |
be_else.22094:
    add     $i8, 1, $i8                 # |    927,908 |    927,908 |
    b       solve_each_element_fast.2885# |    927,908 |    927,908 |
be_else.22093:
    bg      $fg0, $f0, ble_else.22095   # |  4,276,855 |  4,276,855 |
ble_then.22095:
    add     $i8, 1, $i8                 # |  2,879,924 |  2,879,924 |
    b       solve_each_element_fast.2885# |  2,879,924 |  2,879,924 |
ble_else.22095:
    load    [$i10 + 0], $i1             # |  1,396,931 |  1,396,931 |
    bg      $fg7, $fg0, ble_else.22096  # |  1,396,931 |  1,396,931 |
ble_then.22096:
    add     $i8, 1, $i8                 # |    215,434 |    215,434 |
    b       solve_each_element_fast.2885# |    215,434 |    215,434 |
ble_else.22096:
    li      0, $i2                      # |  1,181,497 |  1,181,497 |
    load    [$i1 + 0], $f1              # |  1,181,497 |  1,181,497 |
    fadd    $fg0, $fc15, $f10           # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg8, $f11             # |  1,181,497 |  1,181,497 |
    load    [$i1 + 1], $f1              # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg9, $f12             # |  1,181,497 |  1,181,497 |
    load    [$i1 + 2], $f1              # |  1,181,497 |  1,181,497 |
    fmul    $f1, $f10, $f1              # |  1,181,497 |  1,181,497 |
    fadd    $f1, $fg10, $f13            # |  1,181,497 |  1,181,497 |
.count move_args
    mov     $i2, $i1                    # |  1,181,497 |  1,181,497 |
.count move_args
    mov     $i9, $i3                    # |  1,181,497 |  1,181,497 |
.count move_args
    mov     $f11, $f2                   # |  1,181,497 |  1,181,497 |
.count move_args
    mov     $f12, $f3                   # |  1,181,497 |  1,181,497 |
.count move_args
    mov     $f13, $f4                   # |  1,181,497 |  1,181,497 |
    call    check_all_inside.2856       # |  1,181,497 |  1,181,497 |
    add     $i8, 1, $i8                 # |  1,181,497 |  1,181,497 |
    be      $i1, 0, solve_each_element_fast.2885# |  1,181,497 |  1,181,497 |
    mov     $f10, $fg7                  # |    756,549 |    756,549 |
    store   $f11, [ext_intersection_point + 0]# |    756,549 |    756,549 |
    store   $f12, [ext_intersection_point + 1]# |    756,549 |    756,549 |
    store   $f13, [ext_intersection_point + 2]# |    756,549 |    756,549 |
    mov     $i11, $ig3                  # |    756,549 |    756,549 |
    mov     $i12, $ig2                  # |    756,549 |    756,549 |
    b       solve_each_element_fast.2885# |    756,549 |    756,549 |
.end solve_each_element_fast

######################################################################
# solve_one_or_network_fast($i13, $i14, $i15)
# $ra = $ra2
# [$i1 - $i15]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra1]
######################################################################
.begin solve_one_or_network_fast
solve_one_or_network_fast.2889:
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22098      # |    684,824 |    684,824 |
be_then.22098:
    jr      $ra2
be_else.22098:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22099      # |    684,824 |    684,824 |
be_then.22099:
    jr      $ra2
be_else.22099:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22100      # |    684,824 |    684,824 |
be_then.22100:
    jr      $ra2
be_else.22100:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22101      # |    684,824 |    684,824 |
be_then.22101:
    jr      $ra2
be_else.22101:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22102      # |    684,824 |    684,824 |
be_then.22102:
    jr      $ra2
be_else.22102:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22103      # |    684,824 |    684,824 |
be_then.22103:
    jr      $ra2
be_else.22103:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    bne     $i1, -1, be_else.22104      # |    684,824 |    684,824 |
be_then.22104:
    jr      $ra2                        # |    684,824 |    684,824 |
be_else.22104:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element_fast.2885, $ra1
    add     $i13, 1, $i13
    load    [$i14 + $i13], $i1
    bne     $i1, -1, be_else.22105
be_then.22105:
    jr      $ra2
be_else.22105:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element_fast.2885, $ra1
    add     $i13, 1, $i13
    b       solve_one_or_network_fast.2889
.end solve_one_or_network_fast

######################################################################
# trace_or_matrix_fast($i16, $i17, $i18)
# $ra = $ra3
# [$i1 - $i18]
# [$f1 - $f13]
# [$ig2 - $ig3]
# [$fg0, $fg7]
# [$ra - $ra2]
######################################################################
.begin trace_or_matrix_fast
trace_or_matrix_fast.2893:
    load    [$i17 + $i16], $i14         # |  1,134,616 |  1,134,616 |
    load    [$i14 + 0], $i1             # |  1,134,616 |  1,134,616 |
    bne     $i1, -1, be_else.22106      # |  1,134,616 |  1,134,616 |
be_then.22106:
    jr      $ra3
be_else.22106:
    bne     $i1, 99, be_else.22107      # |  1,134,616 |  1,134,616 |
be_then.22107:
    load    [$i14 + 1], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.22108     # |  1,134,616 |  1,134,616 |
bne_then.22108:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 2], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.22109     # |  1,134,616 |  1,134,616 |
bne_then.22109:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 3], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.22110     # |  1,134,616 |  1,134,616 |
bne_then.22110:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 4], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.22111     # |  1,134,616 |  1,134,616 |
bne_then.22111:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 5], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, bne_cont.22112     # |  1,134,616 |  1,134,616 |
bne_then.22112:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 6], $i1
    be      $i1, -1, bne_cont.22113
bne_then.22113:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    li      7, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network_fast.2889, $ra2
bne_cont.22113:
bne_cont.22112:
bne_cont.22111:
bne_cont.22110:
bne_cont.22109:
bne_cont.22108:
    add     $i16, 1, $i16               # |  1,134,616 |  1,134,616 |
    load    [$i17 + $i16], $i14         # |  1,134,616 |  1,134,616 |
    load    [$i14 + 0], $i1             # |  1,134,616 |  1,134,616 |
    bne     $i1, -1, be_else.22114      # |  1,134,616 |  1,134,616 |
be_then.22114:
    jr      $ra3                        # |  1,134,616 |  1,134,616 |
be_else.22114:
    bne     $i1, 99, be_else.22115
be_then.22115:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22116
be_then.22116:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22116:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22117
be_then.22117:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22117:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    bne     $i1, -1, be_else.22118
be_then.22118:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22118:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    bne     $i1, -1, be_else.22119
be_then.22119:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22119:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22115:
.count move_args
    mov     $i18, $i2
    call    solver_fast2.2814
    bne     $i1, 0, be_else.22120
be_then.22120:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22120:
    bg      $fg7, $fg0, ble_else.22121
ble_then.22121:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
ble_else.22121:
    li      1, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22107:
.count move_args
    mov     $i18, $i2
    call    solver_fast2.2814
    bne     $i1, 0, be_else.22122
be_then.22122:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
be_else.22122:
    bg      $fg7, $fg0, ble_else.22123
ble_then.22123:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
ble_else.22123:
    li      1, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
.end trace_or_matrix_fast

######################################################################
# utexture($i1)
# $ra = $ra1
# [$i1 - $i3]
# [$f1 - $f9]
# []
# [$fg11, $fg15 - $fg16]
# [$ra]
######################################################################
.begin utexture
utexture.2908:
    load    [$i1 + 8], $i2              # |    660,729 |    660,729 |
    load    [$i2 + 0], $fg16            # |    660,729 |    660,729 |
    load    [$i2 + 1], $fg11            # |    660,729 |    660,729 |
    load    [$i2 + 2], $fg15            # |    660,729 |    660,729 |
    load    [$i1 + 0], $i2              # |    660,729 |    660,729 |
    bne     $i2, 1, be_else.22124       # |    660,729 |    660,729 |
be_then.22124:
    load    [$i1 + 5], $i1              # |     94,509 |     94,509 |
    load    [ext_intersection_point + 0], $f1# |     94,509 |     94,509 |
    load    [$i1 + 0], $f2              # |     94,509 |     94,509 |
.count load_float
    load    [f.21539], $f4              # |     94,509 |     94,509 |
    fsub    $f1, $f2, $f5               # |     94,509 |     94,509 |
    fmul    $f5, $f4, $f2               # |     94,509 |     94,509 |
    call    ext_floor                   # |     94,509 |     94,509 |
.count load_float
    load    [f.21540], $f6              # |     94,509 |     94,509 |
.count load_float
    load    [f.21541], $f7              # |     94,509 |     94,509 |
    fmul    $f1, $f6, $f1               # |     94,509 |     94,509 |
    fsub    $f5, $f1, $f5               # |     94,509 |     94,509 |
    load    [ext_intersection_point + 2], $f1# |     94,509 |     94,509 |
    load    [$i1 + 2], $f2              # |     94,509 |     94,509 |
    fsub    $f1, $f2, $f8               # |     94,509 |     94,509 |
    fmul    $f8, $f4, $f2               # |     94,509 |     94,509 |
    call    ext_floor                   # |     94,509 |     94,509 |
    fmul    $f1, $f6, $f1               # |     94,509 |     94,509 |
    fsub    $f8, $f1, $f1               # |     94,509 |     94,509 |
    bg      $f7, $f5, ble_else.22125    # |     94,509 |     94,509 |
ble_then.22125:
    li      0, $i1                      # |     50,304 |     50,304 |
.count b_cont
    b       ble_cont.22125              # |     50,304 |     50,304 |
ble_else.22125:
    li      1, $i1                      # |     44,205 |     44,205 |
ble_cont.22125:
    bg      $f7, $f1, ble_else.22126    # |     94,509 |     94,509 |
ble_then.22126:
    bne     $i1, 0, be_else.22127       # |     45,686 |     45,686 |
be_then.22127:
    mov     $fc8, $fg11                 # |     24,111 |     24,111 |
    jr      $ra1                        # |     24,111 |     24,111 |
be_else.22127:
    mov     $f0, $fg11                  # |     21,575 |     21,575 |
    jr      $ra1                        # |     21,575 |     21,575 |
ble_else.22126:
    bne     $i1, 0, be_else.22128       # |     48,823 |     48,823 |
be_then.22128:
    mov     $f0, $fg11                  # |     26,193 |     26,193 |
    jr      $ra1                        # |     26,193 |     26,193 |
be_else.22128:
    mov     $fc8, $fg11                 # |     22,630 |     22,630 |
    jr      $ra1                        # |     22,630 |     22,630 |
be_else.22124:
    bne     $i2, 2, be_else.22129       # |    566,220 |    566,220 |
be_then.22129:
    load    [ext_intersection_point + 1], $f1# |      2,886 |      2,886 |
.count load_float
    load    [f.21538], $f2              # |      2,886 |      2,886 |
    fmul    $f1, $f2, $f2               # |      2,886 |      2,886 |
    call    ext_sin                     # |      2,886 |      2,886 |
    fmul    $f1, $f1, $f1               # |      2,886 |      2,886 |
    fmul    $fc8, $f1, $fg16            # |      2,886 |      2,886 |
    fsub    $fc0, $f1, $f1              # |      2,886 |      2,886 |
    fmul    $fc8, $f1, $fg11            # |      2,886 |      2,886 |
    jr      $ra1                        # |      2,886 |      2,886 |
be_else.22129:
    bne     $i2, 3, be_else.22130       # |    563,334 |    563,334 |
be_then.22130:
    load    [$i1 + 5], $i1
    load    [ext_intersection_point + 0], $f1
    load    [$i1 + 0], $f2
    fsub    $f1, $f2, $f1
    fmul    $f1, $f1, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i1 + 2], $f3
    fsub    $f2, $f3, $f2
    fmul    $f2, $f2, $f2
    fadd    $f1, $f2, $f1
    fsqrt   $f1, $f1
    fmul    $f1, $fc9, $f4
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fmul    $f1, $fc14, $f2
    call    ext_cos
    fmul    $f1, $f1, $f1
    fmul    $f1, $fc8, $fg11
    fsub    $fc0, $f1, $f1
    fmul    $f1, $fc8, $fg15
    jr      $ra1
be_else.22130:
    bne     $i2, 4, be_else.22131       # |    563,334 |    563,334 |
be_then.22131:
    load    [$i1 + 5], $i3
    load    [$i1 + 4], $i1
.count load_float
    load    [f.21528], $f6
    load    [ext_intersection_point + 0], $f1
    load    [$i3 + 0], $f2
    fsub    $f1, $f2, $f1
    load    [$i1 + 0], $f2
    fsqrt   $f2, $f2
    fmul    $f1, $f2, $f7
    fabs    $f7, $f1
    load    [ext_intersection_point + 2], $f2
    load    [$i3 + 2], $f3
    fsub    $f2, $f3, $f2
    load    [$i1 + 2], $f3
    fsqrt   $f3, $f3
    fmul    $f2, $f3, $f8
    bg      $f6, $f1, ble_else.22132
ble_then.22132:
    finv    $f7, $f1
    fmul_a  $f8, $f1, $f2
    call    ext_atan
.count load_float
    load    [f.21530], $f2
    fmul    $f1, $f2, $f2
.count load_float
    load    [f.21532], $f2
.count load_float
    load    [f.21533], $f2
    fmul    $f2, $f1, $f9
.count b_cont
    b       ble_cont.22132
ble_else.22132:
.count load_float
    load    [f.21529], $f9
ble_cont.22132:
    fmul    $f7, $f7, $f1
    fmul    $f8, $f8, $f2
    fadd    $f1, $f2, $f1
    fabs    $f1, $f2
    load    [ext_intersection_point + 1], $f3
    load    [$i3 + 1], $f4
    fsub    $f3, $f4, $f3
    load    [$i1 + 1], $f4
    fsqrt   $f4, $f4
    fmul    $f3, $f4, $f3
    bg      $f6, $f2, ble_else.22133
ble_then.22133:
    finv    $f1, $f1
    fmul_a  $f3, $f1, $f2
    call    ext_atan
.count load_float
    load    [f.21530], $f2
    fmul    $f1, $f2, $f2
.count load_float
    load    [f.21532], $f2
.count load_float
    load    [f.21533], $f2
    fmul    $f2, $f1, $f4
.count b_cont
    b       ble_cont.22133
ble_else.22133:
.count load_float
    load    [f.21529], $f4
ble_cont.22133:
.count load_float
    load    [f.21534], $f5
.count move_args
    mov     $f9, $f2
    call    ext_floor
    fsub    $f9, $f1, $f1
    fsub    $fc4, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f5
.count move_args
    mov     $f4, $f2
    call    ext_floor
    fsub    $f4, $f1, $f1
    fsub    $fc4, $f1, $f1
    fmul    $f1, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f0, $f1, ble_else.22134
ble_then.22134:
.count load_float
    load    [f.21535], $f2
    fmul    $f2, $f1, $fg15
    jr      $ra1
ble_else.22134:
    mov     $f0, $fg15
    jr      $ra1
be_else.22131:
    jr      $ra1                        # |    563,334 |    563,334 |
.end utexture

######################################################################
# trace_reflections($i19, $f14, $f15, $i20)
# $ra = $ra4
# [$i1 - $i22]
# [$f1 - $f15]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg7]
# [$ra - $ra3]
######################################################################
.begin trace_reflections
trace_reflections.2915:
    bl      $i19, 0, bge_else.22135     # |     36,992 |     36,992 |
bge_then.22135:
    load    [ext_reflections + $i19], $i21# |     18,496 |     18,496 |
    load    [$i21 + 1], $i22            # |     18,496 |     18,496 |
    mov     $fc13, $fg7                 # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i14            # |     18,496 |     18,496 |
    load    [$i14 + 0], $i1             # |     18,496 |     18,496 |
    be      $i1, -1, bne_cont.22136     # |     18,496 |     18,496 |
bne_then.22136:
    bne     $i1, 99, be_else.22137      # |     18,496 |     18,496 |
be_then.22137:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22138
be_then.22138:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22137
be_else.22138:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22139
be_then.22139:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22137
be_else.22139:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    bne     $i1, -1, be_else.22140
be_then.22140:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22137
be_else.22140:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    bne     $i1, -1, be_else.22141
be_then.22141:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22137
be_else.22141:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i13
.count move_args
    mov     $i22, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22137
be_else.22137:
.count move_args
    mov     $i22, $i2                   # |     18,496 |     18,496 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |
    bne     $i1, 0, be_else.22142       # |     18,496 |     18,496 |
be_then.22142:
    li      1, $i16                     # |     13,470 |     13,470 |
.count move_args
    mov     $ig1, $i17                  # |     13,470 |     13,470 |
.count move_args
    mov     $i22, $i18                  # |     13,470 |     13,470 |
    jal     trace_or_matrix_fast.2893, $ra3# |     13,470 |     13,470 |
.count b_cont
    b       be_cont.22142               # |     13,470 |     13,470 |
be_else.22142:
    bg      $fg7, $fg0, ble_else.22143  # |      5,026 |      5,026 |
ble_then.22143:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i22, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       ble_cont.22143
ble_else.22143:
    li      1, $i13                     # |      5,026 |      5,026 |
.count move_args
    mov     $i22, $i15                  # |      5,026 |      5,026 |
    jal     solve_one_or_network_fast.2889, $ra2# |      5,026 |      5,026 |
    li      1, $i16                     # |      5,026 |      5,026 |
.count move_args
    mov     $ig1, $i17                  # |      5,026 |      5,026 |
.count move_args
    mov     $i22, $i18                  # |      5,026 |      5,026 |
    jal     trace_or_matrix_fast.2893, $ra3# |      5,026 |      5,026 |
ble_cont.22143:
be_cont.22142:
be_cont.22137:
bne_cont.22136:
    bg      $fg7, $fc7, ble_else.22144  # |     18,496 |     18,496 |
ble_then.22144:
    li      0, $i1
.count b_cont
    b       ble_cont.22144
ble_else.22144:
    bg      $fc12, $fg7, ble_else.22145 # |     18,496 |     18,496 |
ble_then.22145:
    li      0, $i1                      # |      7,212 |      7,212 |
.count b_cont
    b       ble_cont.22145              # |      7,212 |      7,212 |
ble_else.22145:
    li      1, $i1                      # |     11,284 |     11,284 |
ble_cont.22145:
ble_cont.22144:
    bne     $i1, 0, be_else.22146       # |     18,496 |     18,496 |
be_then.22146:
    sub     $i19, 1, $i19               # |      7,212 |      7,212 |
    b       trace_reflections.2915      # |      7,212 |      7,212 |
be_else.22146:
    load    [$i21 + 0], $i1             # |     11,284 |     11,284 |
    add     $ig3, $ig3, $i2             # |     11,284 |     11,284 |
    add     $i2, $i2, $i2               # |     11,284 |     11,284 |
    add     $i2, $ig2, $i2              # |     11,284 |     11,284 |
    bne     $i2, $i1, be_else.22147     # |     11,284 |     11,284 |
be_then.22147:
    li      0, $i12                     # |     10,331 |     10,331 |
.count move_args
    mov     $ig1, $i13                  # |     10,331 |     10,331 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,331 |     10,331 |
    bne     $i1, 0, be_else.22148       # |     10,331 |     10,331 |
be_then.22148:
    load    [$i21 + 2], $f1             # |     10,331 |     10,331 |
    load    [$i22 + 0], $i1             # |     10,331 |     10,331 |
    fmul    $f1, $f14, $f2              # |     10,331 |     10,331 |
    load    [ext_nvector + 0], $f3      # |     10,331 |     10,331 |
    load    [$i1 + 0], $f4              # |     10,331 |     10,331 |
    fmul    $f3, $f4, $f3               # |     10,331 |     10,331 |
    load    [ext_nvector + 1], $f5      # |     10,331 |     10,331 |
    load    [$i1 + 1], $f6              # |     10,331 |     10,331 |
    fmul    $f5, $f6, $f5               # |     10,331 |     10,331 |
    fadd    $f3, $f5, $f3               # |     10,331 |     10,331 |
    load    [ext_nvector + 2], $f5      # |     10,331 |     10,331 |
    load    [$i1 + 2], $f7              # |     10,331 |     10,331 |
    fmul    $f5, $f7, $f5               # |     10,331 |     10,331 |
    fadd    $f3, $f5, $f3               # |     10,331 |     10,331 |
    fmul    $f2, $f3, $f2               # |     10,331 |     10,331 |
    ble     $f2, $f0, bg_cont.22149     # |     10,331 |     10,331 |
bg_then.22149:
    fmul    $f2, $fg16, $f3             # |      9,373 |      9,373 |
    fadd    $fg4, $f3, $fg4             # |      9,373 |      9,373 |
    fmul    $f2, $fg11, $f3             # |      9,373 |      9,373 |
    fadd    $fg5, $f3, $fg5             # |      9,373 |      9,373 |
    fmul    $f2, $fg15, $f2             # |      9,373 |      9,373 |
    fadd    $fg6, $f2, $fg6             # |      9,373 |      9,373 |
bg_cont.22149:
    load    [$i20 + 0], $f2             # |     10,331 |     10,331 |
    fmul    $f2, $f4, $f2               # |     10,331 |     10,331 |
    load    [$i20 + 1], $f3             # |     10,331 |     10,331 |
    fmul    $f3, $f6, $f3               # |     10,331 |     10,331 |
    fadd    $f2, $f3, $f2               # |     10,331 |     10,331 |
    load    [$i20 + 2], $f3             # |     10,331 |     10,331 |
    fmul    $f3, $f7, $f3               # |     10,331 |     10,331 |
    fadd    $f2, $f3, $f2               # |     10,331 |     10,331 |
    fmul    $f1, $f2, $f1               # |     10,331 |     10,331 |
    sub     $i19, 1, $i19               # |     10,331 |     10,331 |
    ble     $f1, $f0, trace_reflections.2915# |     10,331 |     10,331 |
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f15, $f1              # |      7,721 |      7,721 |
    fadd    $fg4, $f1, $fg4             # |      7,721 |      7,721 |
    fadd    $fg5, $f1, $fg5             # |      7,721 |      7,721 |
    fadd    $fg6, $f1, $fg6             # |      7,721 |      7,721 |
    b       trace_reflections.2915      # |      7,721 |      7,721 |
be_else.22148:
    sub     $i19, 1, $i19
    b       trace_reflections.2915
be_else.22147:
    sub     $i19, 1, $i19               # |        953 |        953 |
    b       trace_reflections.2915      # |        953 |        953 |
bge_else.22135:
    jr      $ra4                        # |     18,496 |     18,496 |
.end trace_reflections

######################################################################
# trace_ray($i23, $f16, $i24, $i25, $f17)
# $ra = $ra5
# [$i1 - $i28]
# [$f1 - $f17]
# [$ig2 - $ig3]
# [$fg0, $fg4 - $fg11, $fg15 - $fg19]
# [$ra - $ra4]
######################################################################
.begin trace_ray
trace_ray.2920:
    bg      $i23, 4, ble_else.22151     # |     23,754 |     23,754 |
ble_then.22151:
    mov     $fc13, $fg7                 # |     23,754 |     23,754 |
    load    [$ig1 + 0], $i14            # |     23,754 |     23,754 |
    load    [$i14 + 0], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, bne_cont.22152     # |     23,754 |     23,754 |
bne_then.22152:
    bne     $i1, 99, be_else.22153      # |     23,754 |     23,754 |
be_then.22153:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22154
be_then.22154:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.22153
be_else.22154:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22155
be_then.22155:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.22153
be_else.22155:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 3], $i1
    bne     $i1, -1, be_else.22156
be_then.22156:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.22153
be_else.22156:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 4], $i1
    bne     $i1, -1, be_else.22157
be_then.22157:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.22153
be_else.22157:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    li      5, $i13
.count move_args
    mov     $i24, $i15
    jal     solve_one_or_network.2875, $ra2
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       be_cont.22153
be_else.22153:
.count move_args
    mov     $i24, $i2                   # |     23,754 |     23,754 |
    call    solver.2773                 # |     23,754 |     23,754 |
    bne     $i1, 0, be_else.22158       # |     23,754 |     23,754 |
be_then.22158:
    li      1, $i16                     # |     16,978 |     16,978 |
.count move_args
    mov     $ig1, $i17                  # |     16,978 |     16,978 |
.count move_args
    mov     $i24, $i18                  # |     16,978 |     16,978 |
    jal     trace_or_matrix.2879, $ra3  # |     16,978 |     16,978 |
.count b_cont
    b       be_cont.22158               # |     16,978 |     16,978 |
be_else.22158:
    bg      $fg7, $fg0, ble_else.22159  # |      6,776 |      6,776 |
ble_then.22159:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i24, $i18
    jal     trace_or_matrix.2879, $ra3
.count b_cont
    b       ble_cont.22159
ble_else.22159:
    li      1, $i13                     # |      6,776 |      6,776 |
.count move_args
    mov     $i24, $i15                  # |      6,776 |      6,776 |
    jal     solve_one_or_network.2875, $ra2# |      6,776 |      6,776 |
    li      1, $i16                     # |      6,776 |      6,776 |
.count move_args
    mov     $ig1, $i17                  # |      6,776 |      6,776 |
.count move_args
    mov     $i24, $i18                  # |      6,776 |      6,776 |
    jal     trace_or_matrix.2879, $ra3  # |      6,776 |      6,776 |
ble_cont.22159:
be_cont.22158:
be_cont.22153:
bne_cont.22152:
    load    [$i25 + 2], $i26            # |     23,754 |     23,754 |
    bg      $fg7, $fc7, ble_else.22160  # |     23,754 |     23,754 |
ble_then.22160:
    li      0, $i1
.count b_cont
    b       ble_cont.22160
ble_else.22160:
    bg      $fc12, $fg7, ble_else.22161 # |     23,754 |     23,754 |
ble_then.22161:
    li      0, $i1                      # |      5,258 |      5,258 |
.count b_cont
    b       ble_cont.22161              # |      5,258 |      5,258 |
ble_else.22161:
    li      1, $i1                      # |     18,496 |     18,496 |
ble_cont.22161:
ble_cont.22160:
    bne     $i1, 0, be_else.22162       # |     23,754 |     23,754 |
be_then.22162:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |
.count storer
    add     $i26, $i23, $tmp            # |      5,258 |      5,258 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |
    bne     $i23, 0, be_else.22163      # |      5,258 |      5,258 |
be_then.22163:
    jr      $ra5
be_else.22163:
    load    [$i24 + 0], $f1             # |      5,258 |      5,258 |
    fmul    $f1, $fg14, $f1             # |      5,258 |      5,258 |
    load    [$i24 + 1], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg12, $f2             # |      5,258 |      5,258 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |
    load    [$i24 + 2], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg13, $f2             # |      5,258 |      5,258 |
    fadd_n  $f1, $f2, $f1               # |      5,258 |      5,258 |
    bg      $f1, $f0, ble_else.22164    # |      5,258 |      5,258 |
ble_then.22164:
    jr      $ra5                        # |      3,274 |      3,274 |
ble_else.22164:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |
    fmul    $f1, $f16, $f1              # |      1,984 |      1,984 |
    load    [ext_beam + 0], $f2         # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |
    jr      $ra5                        # |      1,984 |      1,984 |
be_else.22162:
    load    [ext_objects + $ig3], $i27  # |     18,496 |     18,496 |
    load    [$i27 + 1], $i1             # |     18,496 |     18,496 |
    bne     $i1, 1, be_else.22165       # |     18,496 |     18,496 |
be_then.22165:
    store   $f0, [ext_nvector + 0]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 1]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 2]      # |      7,910 |      7,910 |
    sub     $ig2, 1, $i1                # |      7,910 |      7,910 |
    load    [$i24 + $i1], $f1           # |      7,910 |      7,910 |
    bne     $f1, $f0, be_else.22166     # |      7,910 |      7,910 |
be_then.22166:
    store   $f0, [ext_nvector + $i1]
.count b_cont
    b       be_cont.22165
be_else.22166:
    bg      $f1, $f0, ble_else.22167    # |      7,910 |      7,910 |
ble_then.22167:
    store   $fc0, [ext_nvector + $i1]   # |      6,667 |      6,667 |
.count b_cont
    b       be_cont.22165               # |      6,667 |      6,667 |
ble_else.22167:
    store   $fc3, [ext_nvector + $i1]   # |      1,243 |      1,243 |
.count b_cont
    b       be_cont.22165               # |      1,243 |      1,243 |
be_else.22165:
    bne     $i1, 2, be_else.22168       # |     10,586 |     10,586 |
be_then.22168:
    load    [$i27 + 4], $i1             # |      7,226 |      7,226 |
    load    [$i1 + 0], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 0]      # |      7,226 |      7,226 |
    load    [$i1 + 1], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 1]      # |      7,226 |      7,226 |
    load    [$i1 + 2], $f1              # |      7,226 |      7,226 |
    fneg    $f1, $f1                    # |      7,226 |      7,226 |
    store   $f1, [ext_nvector + 2]      # |      7,226 |      7,226 |
.count b_cont
    b       be_cont.22168               # |      7,226 |      7,226 |
be_else.22168:
    load    [$i27 + 3], $i1             # |      3,360 |      3,360 |
    load    [$i27 + 4], $i2             # |      3,360 |      3,360 |
    load    [$i2 + 0], $f1              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 0], $f2# |      3,360 |      3,360 |
    load    [$i27 + 5], $i3             # |      3,360 |      3,360 |
    load    [$i3 + 0], $f3              # |      3,360 |      3,360 |
    fsub    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fmul    $f2, $f1, $f1               # |      3,360 |      3,360 |
    load    [$i2 + 1], $f3              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 1], $f4# |      3,360 |      3,360 |
    load    [$i3 + 1], $f5              # |      3,360 |      3,360 |
    fsub    $f4, $f5, $f4               # |      3,360 |      3,360 |
    fmul    $f4, $f3, $f3               # |      3,360 |      3,360 |
    load    [$i2 + 2], $f5              # |      3,360 |      3,360 |
    load    [ext_intersection_point + 2], $f6# |      3,360 |      3,360 |
    load    [$i3 + 2], $f7              # |      3,360 |      3,360 |
    fsub    $f6, $f7, $f6               # |      3,360 |      3,360 |
    fmul    $f6, $f5, $f5               # |      3,360 |      3,360 |
    bne     $i1, 0, be_else.22169       # |      3,360 |      3,360 |
be_then.22169:
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    store   $f3, [ext_nvector + 1]      # |      3,360 |      3,360 |
    store   $f5, [ext_nvector + 2]      # |      3,360 |      3,360 |
.count b_cont
    b       be_cont.22169               # |      3,360 |      3,360 |
be_else.22169:
    load    [$i27 + 9], $i1
    load    [$i1 + 2], $f7
    fmul    $f4, $f7, $f7
    load    [$i1 + 1], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc4, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i1 + 2], $f1
    fmul    $f2, $f1, $f1
    load    [$i1 + 0], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i1 + 1], $f1
    fmul    $f2, $f1, $f1
    load    [$i1 + 0], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
be_cont.22169:
    load    [ext_nvector + 0], $f1      # |      3,360 |      3,360 |
    load    [$i27 + 6], $i1             # |      3,360 |      3,360 |
    fmul    $f1, $f1, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 1], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    load    [ext_nvector + 2], $f3      # |      3,360 |      3,360 |
    fmul    $f3, $f3, $f3               # |      3,360 |      3,360 |
    fadd    $f2, $f3, $f2               # |      3,360 |      3,360 |
    fsqrt   $f2, $f2                    # |      3,360 |      3,360 |
    bne     $f2, $f0, be_else.22170     # |      3,360 |      3,360 |
be_then.22170:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.22170
be_else.22170:
    bne     $i1, 0, be_else.22171       # |      3,360 |      3,360 |
be_then.22171:
    finv    $f2, $f2                    # |      3,127 |      3,127 |
.count b_cont
    b       be_cont.22171               # |      3,127 |      3,127 |
be_else.22171:
    finv_n  $f2, $f2                    # |        233 |        233 |
be_cont.22171:
be_cont.22170:
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    load    [ext_nvector + 1], $f1      # |      3,360 |      3,360 |
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 1]      # |      3,360 |      3,360 |
    load    [ext_nvector + 2], $f1      # |      3,360 |      3,360 |
    fmul    $f1, $f2, $f1               # |      3,360 |      3,360 |
    store   $f1, [ext_nvector + 2]      # |      3,360 |      3,360 |
be_cont.22168:
be_cont.22165:
    load    [ext_intersection_point + 0], $fg17# |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $fg18# |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $fg19# |     18,496 |     18,496 |
.count move_args
    mov     $i27, $i1                   # |     18,496 |     18,496 |
    jal     utexture.2908, $ra1         # |     18,496 |     18,496 |
    add     $ig3, $ig3, $i1             # |     18,496 |     18,496 |
    add     $i1, $i1, $i1               # |     18,496 |     18,496 |
    add     $i1, $ig2, $i1              # |     18,496 |     18,496 |
.count storer
    add     $i26, $i23, $tmp            # |     18,496 |     18,496 |
    store   $i1, [$tmp + 0]             # |     18,496 |     18,496 |
    load    [$i25 + 1], $i1             # |     18,496 |     18,496 |
    load    [$i1 + $i23], $i1           # |     18,496 |     18,496 |
    load    [ext_intersection_point + 0], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 0]              # |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 1]              # |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $f1# |     18,496 |     18,496 |
    store   $f1, [$i1 + 2]              # |     18,496 |     18,496 |
    load    [$i27 + 7], $i28            # |     18,496 |     18,496 |
    load    [$i25 + 3], $i1             # |     18,496 |     18,496 |
    load    [$i28 + 0], $f1             # |     18,496 |     18,496 |
    fmul    $f1, $f16, $f14             # |     18,496 |     18,496 |
.count storer
    add     $i1, $i23, $tmp             # |     18,496 |     18,496 |
    bg      $fc4, $f1, ble_else.22172   # |     18,496 |     18,496 |
ble_then.22172:
    li      1, $i2                      # |     11,126 |     11,126 |
    store   $i2, [$tmp + 0]             # |     11,126 |     11,126 |
    load    [$i25 + 4], $i1             # |     11,126 |     11,126 |
    load    [$i1 + $i23], $i2           # |     11,126 |     11,126 |
    store   $fg16, [$i2 + 0]            # |     11,126 |     11,126 |
    store   $fg11, [$i2 + 1]            # |     11,126 |     11,126 |
    store   $fg15, [$i2 + 2]            # |     11,126 |     11,126 |
    load    [$i1 + $i23], $i1           # |     11,126 |     11,126 |
.count load_float
    load    [f.21544], $f1              # |     11,126 |     11,126 |
.count load_float
    load    [f.21545], $f1              # |     11,126 |     11,126 |
    fmul    $f1, $f14, $f1              # |     11,126 |     11,126 |
    load    [$i1 + 0], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |
    store   $f2, [$i1 + 0]              # |     11,126 |     11,126 |
    load    [$i1 + 1], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f2               # |     11,126 |     11,126 |
    store   $f2, [$i1 + 1]              # |     11,126 |     11,126 |
    load    [$i1 + 2], $f2              # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |
    load    [$i25 + 7], $i1             # |     11,126 |     11,126 |
    load    [$i1 + $i23], $i1           # |     11,126 |     11,126 |
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 0]              # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 1]              # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f1      # |     11,126 |     11,126 |
    store   $f1, [$i1 + 2]              # |     11,126 |     11,126 |
.count b_cont
    b       ble_cont.22172              # |     11,126 |     11,126 |
ble_else.22172:
    li      0, $i2                      # |      7,370 |      7,370 |
    store   $i2, [$tmp + 0]             # |      7,370 |      7,370 |
ble_cont.22172:
    load    [ext_nvector + 0], $f1      # |     18,496 |     18,496 |
.count load_float
    load    [f.21546], $f2              # |     18,496 |     18,496 |
    load    [$i24 + 0], $f3             # |     18,496 |     18,496 |
    fmul    $f3, $f1, $f4               # |     18,496 |     18,496 |
    load    [$i24 + 1], $f5             # |     18,496 |     18,496 |
    load    [ext_nvector + 1], $f6      # |     18,496 |     18,496 |
    fmul    $f5, $f6, $f5               # |     18,496 |     18,496 |
    fadd    $f4, $f5, $f4               # |     18,496 |     18,496 |
    load    [$i24 + 2], $f5             # |     18,496 |     18,496 |
    load    [ext_nvector + 2], $f6      # |     18,496 |     18,496 |
    fmul    $f5, $f6, $f5               # |     18,496 |     18,496 |
    fadd    $f4, $f5, $f4               # |     18,496 |     18,496 |
    fmul    $f2, $f4, $f2               # |     18,496 |     18,496 |
    fmul    $f2, $f1, $f1               # |     18,496 |     18,496 |
    fadd    $f3, $f1, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i24 + 0]             # |     18,496 |     18,496 |
    load    [$i24 + 1], $f1             # |     18,496 |     18,496 |
    load    [ext_nvector + 1], $f3      # |     18,496 |     18,496 |
    fmul    $f2, $f3, $f3               # |     18,496 |     18,496 |
    fadd    $f1, $f3, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i24 + 1]             # |     18,496 |     18,496 |
    load    [$i24 + 2], $f1             # |     18,496 |     18,496 |
    load    [ext_nvector + 2], $f3      # |     18,496 |     18,496 |
    fmul    $f2, $f3, $f2               # |     18,496 |     18,496 |
    fadd    $f1, $f2, $f1               # |     18,496 |     18,496 |
    store   $f1, [$i24 + 2]             # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i12            # |     18,496 |     18,496 |
    load    [$i12 + 0], $i1             # |     18,496 |     18,496 |
    bne     $i1, -1, be_else.22173      # |     18,496 |     18,496 |
be_then.22173:
    li      0, $i1
.count b_cont
    b       be_cont.22173
be_else.22173:
    bne     $i1, 99, be_else.22174      # |     18,496 |     18,496 |
be_then.22174:
    li      1, $i1
.count b_cont
    b       be_cont.22174
be_else.22174:
    call    solver_fast.2796            # |     18,496 |     18,496 |
    bne     $i1, 0, be_else.22175       # |     18,496 |     18,496 |
be_then.22175:
    li      0, $i1                      # |     13,405 |     13,405 |
.count b_cont
    b       be_cont.22175               # |     13,405 |     13,405 |
be_else.22175:
    bg      $fc7, $fg0, ble_else.22176  # |      5,091 |      5,091 |
ble_then.22176:
    li      0, $i1                      # |        207 |        207 |
.count b_cont
    b       ble_cont.22176              # |        207 |        207 |
ble_else.22176:
    load    [$i12 + 1], $i1             # |      4,884 |      4,884 |
    bne     $i1, -1, be_else.22177      # |      4,884 |      4,884 |
be_then.22177:
    li      0, $i1
.count b_cont
    b       be_cont.22177
be_else.22177:
    li      0, $i8                      # |      4,884 |      4,884 |
    load    [ext_and_net + $i1], $i9    # |      4,884 |      4,884 |
    jal     shadow_check_and_group.2862, $ra1# |      4,884 |      4,884 |
    bne     $i1, 0, be_else.22178       # |      4,884 |      4,884 |
be_then.22178:
    load    [$i12 + 2], $i1             # |      4,517 |      4,517 |
    bne     $i1, -1, be_else.22179      # |      4,517 |      4,517 |
be_then.22179:
    li      0, $i1
.count b_cont
    b       be_cont.22178
be_else.22179:
    li      0, $i8                      # |      4,517 |      4,517 |
    load    [ext_and_net + $i1], $i9    # |      4,517 |      4,517 |
    jal     shadow_check_and_group.2862, $ra1# |      4,517 |      4,517 |
    bne     $i1, 0, be_else.22180       # |      4,517 |      4,517 |
be_then.22180:
    li      3, $i10                     # |      4,439 |      4,439 |
.count move_args
    mov     $i12, $i11                  # |      4,439 |      4,439 |
    jal     shadow_check_one_or_group.2865, $ra2# |      4,439 |      4,439 |
    bne     $i1, 0, be_else.22181       # |      4,439 |      4,439 |
be_then.22181:
    li      0, $i1                      # |      4,099 |      4,099 |
.count b_cont
    b       be_cont.22178               # |      4,099 |      4,099 |
be_else.22181:
    li      1, $i1                      # |        340 |        340 |
.count b_cont
    b       be_cont.22178               # |        340 |        340 |
be_else.22180:
    li      1, $i1                      # |         78 |         78 |
.count b_cont
    b       be_cont.22178               # |         78 |         78 |
be_else.22178:
    li      1, $i1                      # |        367 |        367 |
be_cont.22178:
be_cont.22177:
ble_cont.22176:
be_cont.22175:
be_cont.22174:
    bne     $i1, 0, be_else.22182       # |     18,496 |     18,496 |
be_then.22182:
    li      1, $i12                     # |     17,711 |     17,711 |
.count move_args
    mov     $ig1, $i13                  # |     17,711 |     17,711 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     17,711 |     17,711 |
.count b_cont
    b       be_cont.22182               # |     17,711 |     17,711 |
be_else.22182:
    load    [$i12 + 1], $i1             # |        785 |        785 |
    bne     $i1, -1, be_else.22183      # |        785 |        785 |
be_then.22183:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22183
be_else.22183:
    li      0, $i8                      # |        785 |        785 |
    load    [ext_and_net + $i1], $i9    # |        785 |        785 |
    jal     shadow_check_and_group.2862, $ra1# |        785 |        785 |
    bne     $i1, 0, be_else.22184       # |        785 |        785 |
be_then.22184:
    load    [$i12 + 2], $i1             # |        418 |        418 |
    bne     $i1, -1, be_else.22185      # |        418 |        418 |
be_then.22185:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22184
be_else.22185:
    li      0, $i8                      # |        418 |        418 |
    load    [ext_and_net + $i1], $i9    # |        418 |        418 |
    jal     shadow_check_and_group.2862, $ra1# |        418 |        418 |
    bne     $i1, 0, be_else.22186       # |        418 |        418 |
be_then.22186:
    li      3, $i10                     # |        340 |        340 |
.count move_args
    mov     $i12, $i11                  # |        340 |        340 |
    jal     shadow_check_one_or_group.2865, $ra2# |        340 |        340 |
    bne     $i1, 0, be_else.22187       # |        340 |        340 |
be_then.22187:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22184
be_else.22187:
    li      1, $i1                      # |        340 |        340 |
.count b_cont
    b       be_cont.22184               # |        340 |        340 |
be_else.22186:
    li      1, $i1                      # |         78 |         78 |
.count b_cont
    b       be_cont.22184               # |         78 |         78 |
be_else.22184:
    li      1, $i1                      # |        367 |        367 |
be_cont.22184:
be_cont.22183:
be_cont.22182:
be_cont.22173:
    load    [$i28 + 1], $f1             # |     18,496 |     18,496 |
    fmul    $f16, $f1, $f15             # |     18,496 |     18,496 |
    bne     $i1, 0, be_cont.22188       # |     18,496 |     18,496 |
be_then.22188:
    load    [ext_nvector + 0], $f1      # |     17,538 |     17,538 |
    fmul    $f1, $fg14, $f1             # |     17,538 |     17,538 |
    load    [ext_nvector + 1], $f2      # |     17,538 |     17,538 |
    fmul    $f2, $fg12, $f2             # |     17,538 |     17,538 |
    fadd    $f1, $f2, $f1               # |     17,538 |     17,538 |
    load    [ext_nvector + 2], $f2      # |     17,538 |     17,538 |
    fmul    $f2, $fg13, $f2             # |     17,538 |     17,538 |
    fadd_n  $f1, $f2, $f1               # |     17,538 |     17,538 |
    fmul    $f1, $f14, $f1              # |     17,538 |     17,538 |
    load    [$i24 + 0], $f2             # |     17,538 |     17,538 |
    fmul    $f2, $fg14, $f2             # |     17,538 |     17,538 |
    load    [$i24 + 1], $f3             # |     17,538 |     17,538 |
    fmul    $f3, $fg12, $f3             # |     17,538 |     17,538 |
    fadd    $f2, $f3, $f2               # |     17,538 |     17,538 |
    load    [$i24 + 2], $f3             # |     17,538 |     17,538 |
    fmul    $f3, $fg13, $f3             # |     17,538 |     17,538 |
    fadd_n  $f2, $f3, $f2               # |     17,538 |     17,538 |
    ble     $f1, $f0, bg_cont.22189     # |     17,538 |     17,538 |
bg_then.22189:
    fmul    $f1, $fg16, $f3             # |     17,536 |     17,536 |
    fadd    $fg4, $f3, $fg4             # |     17,536 |     17,536 |
    fmul    $f1, $fg11, $f3             # |     17,536 |     17,536 |
    fadd    $fg5, $f3, $fg5             # |     17,536 |     17,536 |
    fmul    $f1, $fg15, $f1             # |     17,536 |     17,536 |
    fadd    $fg6, $f1, $fg6             # |     17,536 |     17,536 |
bg_cont.22189:
    ble     $f2, $f0, bg_cont.22190     # |     17,538 |     17,538 |
bg_then.22190:
    fmul    $f2, $f2, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f1, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f15, $f1              # |      6,451 |      6,451 |
    fadd    $fg4, $f1, $fg4             # |      6,451 |      6,451 |
    fadd    $fg5, $f1, $fg5             # |      6,451 |      6,451 |
    fadd    $fg6, $f1, $fg6             # |      6,451 |      6,451 |
bg_cont.22190:
be_cont.22188:
    li      ext_intersection_point, $i2 # |     18,496 |     18,496 |
    load    [ext_intersection_point + 0], $fg8# |     18,496 |     18,496 |
    load    [ext_intersection_point + 1], $fg9# |     18,496 |     18,496 |
    load    [ext_intersection_point + 2], $fg10# |     18,496 |     18,496 |
    sub     $ig0, 1, $i1                # |     18,496 |     18,496 |
    call    setup_startp_constants.2831 # |     18,496 |     18,496 |
    sub     $ig4, 1, $i19               # |     18,496 |     18,496 |
.count move_args
    mov     $i24, $i20                  # |     18,496 |     18,496 |
    jal     trace_reflections.2915, $ra4# |     18,496 |     18,496 |
    bg      $f16, $fc9, ble_else.22191  # |     18,496 |     18,496 |
ble_then.22191:
    jr      $ra5
ble_else.22191:
    bge     $i23, 4, bl_cont.22192      # |     18,496 |     18,496 |
bl_then.22192:
    add     $i23, 1, $i1                # |     18,496 |     18,496 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |
.count storer
    add     $i26, $i1, $tmp             # |     18,496 |     18,496 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |
bl_cont.22192:
    load    [$i27 + 2], $i1             # |     18,496 |     18,496 |
    bne     $i1, 2, be_else.22193       # |     18,496 |     18,496 |
be_then.22193:
    fadd    $f17, $fg7, $f17            # |      7,370 |      7,370 |
    add     $i23, 1, $i23               # |      7,370 |      7,370 |
    load    [$i28 + 0], $f1             # |      7,370 |      7,370 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |
    fmul    $f16, $f1, $f16             # |      7,370 |      7,370 |
    b       trace_ray.2920              # |      7,370 |      7,370 |
be_else.22193:
    jr      $ra5                        # |     11,126 |     11,126 |
ble_else.22151:
    jr      $ra5
.end trace_ray

######################################################################
# trace_diffuse_ray($i19, $f14)
# $ra = $ra4
# [$i1 - $i19]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra3]
######################################################################
.begin trace_diffuse_ray
trace_diffuse_ray.2926:
    mov     $fc13, $fg7                 # |  1,116,120 |  1,116,120 |
    load    [$ig1 + 0], $i14            # |  1,116,120 |  1,116,120 |
    load    [$i14 + 0], $i1             # |  1,116,120 |  1,116,120 |
    be      $i1, -1, bne_cont.22194     # |  1,116,120 |  1,116,120 |
bne_then.22194:
    bne     $i1, 99, be_else.22195      # |  1,116,120 |  1,116,120 |
be_then.22195:
    load    [$i14 + 1], $i1
    bne     $i1, -1, be_else.22196
be_then.22196:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22195
be_else.22196:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    bne     $i1, -1, be_else.22197
be_then.22197:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22195
be_else.22197:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    bne     $i1, -1, be_else.22198
be_then.22198:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22195
be_else.22198:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    bne     $i1, -1, be_else.22199
be_then.22199:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22195
be_else.22199:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    li      5, $i13
.count move_args
    mov     $i19, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       be_cont.22195
be_else.22195:
.count move_args
    mov     $i19, $i2                   # |  1,116,120 |  1,116,120 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |
    bne     $i1, 0, be_else.22200       # |  1,116,120 |  1,116,120 |
be_then.22200:
    li      1, $i16                     # |    436,322 |    436,322 |
.count move_args
    mov     $ig1, $i17                  # |    436,322 |    436,322 |
.count move_args
    mov     $i19, $i18                  # |    436,322 |    436,322 |
    jal     trace_or_matrix_fast.2893, $ra3# |    436,322 |    436,322 |
.count b_cont
    b       be_cont.22200               # |    436,322 |    436,322 |
be_else.22200:
    bg      $fg7, $fg0, ble_else.22201  # |    679,798 |    679,798 |
ble_then.22201:
    li      1, $i16
.count move_args
    mov     $ig1, $i17
.count move_args
    mov     $i19, $i18
    jal     trace_or_matrix_fast.2893, $ra3
.count b_cont
    b       ble_cont.22201
ble_else.22201:
    li      1, $i13                     # |    679,798 |    679,798 |
.count move_args
    mov     $i19, $i15                  # |    679,798 |    679,798 |
    jal     solve_one_or_network_fast.2889, $ra2# |    679,798 |    679,798 |
    li      1, $i16                     # |    679,798 |    679,798 |
.count move_args
    mov     $ig1, $i17                  # |    679,798 |    679,798 |
.count move_args
    mov     $i19, $i18                  # |    679,798 |    679,798 |
    jal     trace_or_matrix_fast.2893, $ra3# |    679,798 |    679,798 |
ble_cont.22201:
be_cont.22200:
be_cont.22195:
bne_cont.22194:
    bg      $fg7, $fc7, ble_else.22202  # |  1,116,120 |  1,116,120 |
ble_then.22202:
    li      0, $i1
.count b_cont
    b       ble_cont.22202
ble_else.22202:
    bg      $fc12, $fg7, ble_else.22203 # |  1,116,120 |  1,116,120 |
ble_then.22203:
    li      0, $i1                      # |    473,887 |    473,887 |
.count b_cont
    b       ble_cont.22203              # |    473,887 |    473,887 |
ble_else.22203:
    li      1, $i1                      # |    642,233 |    642,233 |
ble_cont.22203:
ble_cont.22202:
    bne     $i1, 0, be_else.22204       # |  1,116,120 |  1,116,120 |
be_then.22204:
    jr      $ra4                        # |    473,887 |    473,887 |
be_else.22204:
    load    [$i19 + 0], $i1             # |    642,233 |    642,233 |
    load    [ext_objects + $ig3], $i15  # |    642,233 |    642,233 |
    load    [$i15 + 1], $i2             # |    642,233 |    642,233 |
    bne     $i2, 1, be_else.22205       # |    642,233 |    642,233 |
be_then.22205:
    store   $f0, [ext_nvector + 0]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 1]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 2]      # |    114,909 |    114,909 |
    sub     $ig2, 1, $i2                # |    114,909 |    114,909 |
    load    [$i1 + $i2], $f1            # |    114,909 |    114,909 |
    bne     $f1, $f0, be_else.22206     # |    114,909 |    114,909 |
be_then.22206:
    store   $f0, [ext_nvector + $i2]
.count b_cont
    b       be_cont.22205
be_else.22206:
    bg      $f1, $f0, ble_else.22207    # |    114,909 |    114,909 |
ble_then.22207:
    store   $fc0, [ext_nvector + $i2]   # |     90,131 |     90,131 |
.count b_cont
    b       be_cont.22205               # |     90,131 |     90,131 |
ble_else.22207:
    store   $fc3, [ext_nvector + $i2]   # |     24,778 |     24,778 |
.count b_cont
    b       be_cont.22205               # |     24,778 |     24,778 |
be_else.22205:
    bne     $i2, 2, be_else.22208       # |    527,324 |    527,324 |
be_then.22208:
    load    [$i15 + 4], $i1             # |    391,531 |    391,531 |
    load    [$i1 + 0], $f1              # |    391,531 |    391,531 |
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 0]      # |    391,531 |    391,531 |
    load    [$i1 + 1], $f1              # |    391,531 |    391,531 |
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 1]      # |    391,531 |    391,531 |
    load    [$i1 + 2], $f1              # |    391,531 |    391,531 |
    fneg    $f1, $f1                    # |    391,531 |    391,531 |
    store   $f1, [ext_nvector + 2]      # |    391,531 |    391,531 |
.count b_cont
    b       be_cont.22208               # |    391,531 |    391,531 |
be_else.22208:
    load    [$i15 + 3], $i1             # |    135,793 |    135,793 |
    load    [$i15 + 4], $i2             # |    135,793 |    135,793 |
    load    [$i2 + 0], $f1              # |    135,793 |    135,793 |
    load    [ext_intersection_point + 0], $f2# |    135,793 |    135,793 |
    load    [$i15 + 5], $i3             # |    135,793 |    135,793 |
    load    [$i3 + 0], $f3              # |    135,793 |    135,793 |
    fsub    $f2, $f3, $f2               # |    135,793 |    135,793 |
    fmul    $f2, $f1, $f1               # |    135,793 |    135,793 |
    load    [$i2 + 1], $f3              # |    135,793 |    135,793 |
    load    [ext_intersection_point + 1], $f4# |    135,793 |    135,793 |
    load    [$i3 + 1], $f5              # |    135,793 |    135,793 |
    fsub    $f4, $f5, $f4               # |    135,793 |    135,793 |
    fmul    $f4, $f3, $f3               # |    135,793 |    135,793 |
    load    [$i2 + 2], $f5              # |    135,793 |    135,793 |
    load    [ext_intersection_point + 2], $f6# |    135,793 |    135,793 |
    load    [$i3 + 2], $f7              # |    135,793 |    135,793 |
    fsub    $f6, $f7, $f6               # |    135,793 |    135,793 |
    fmul    $f6, $f5, $f5               # |    135,793 |    135,793 |
    bne     $i1, 0, be_else.22209       # |    135,793 |    135,793 |
be_then.22209:
    store   $f1, [ext_nvector + 0]      # |    135,793 |    135,793 |
    store   $f3, [ext_nvector + 1]      # |    135,793 |    135,793 |
    store   $f5, [ext_nvector + 2]      # |    135,793 |    135,793 |
.count b_cont
    b       be_cont.22209               # |    135,793 |    135,793 |
be_else.22209:
    load    [$i15 + 9], $i1
    load    [$i1 + 2], $f7
    fmul    $f4, $f7, $f7
    load    [$i1 + 1], $f8
    fmul    $f6, $f8, $f8
    fadd    $f7, $f8, $f7
    fmul    $f7, $fc4, $f7
    fadd    $f1, $f7, $f1
    store   $f1, [ext_nvector + 0]
    load    [$i1 + 2], $f1
    fmul    $f2, $f1, $f1
    load    [$i1 + 0], $f7
    fmul    $f6, $f7, $f6
    fadd    $f1, $f6, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f3, $f1, $f1
    store   $f1, [ext_nvector + 1]
    load    [$i1 + 1], $f1
    fmul    $f2, $f1, $f1
    load    [$i1 + 0], $f2
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f1, $fc4, $f1
    fadd    $f5, $f1, $f1
    store   $f1, [ext_nvector + 2]
be_cont.22209:
    load    [ext_nvector + 0], $f1      # |    135,793 |    135,793 |
    load    [$i15 + 6], $i1             # |    135,793 |    135,793 |
    fmul    $f1, $f1, $f2               # |    135,793 |    135,793 |
    load    [ext_nvector + 1], $f3      # |    135,793 |    135,793 |
    fmul    $f3, $f3, $f3               # |    135,793 |    135,793 |
    fadd    $f2, $f3, $f2               # |    135,793 |    135,793 |
    load    [ext_nvector + 2], $f3      # |    135,793 |    135,793 |
    fmul    $f3, $f3, $f3               # |    135,793 |    135,793 |
    fadd    $f2, $f3, $f2               # |    135,793 |    135,793 |
    fsqrt   $f2, $f2                    # |    135,793 |    135,793 |
    bne     $f2, $f0, be_else.22210     # |    135,793 |    135,793 |
be_then.22210:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.22210
be_else.22210:
    bne     $i1, 0, be_else.22211       # |    135,793 |    135,793 |
be_then.22211:
    finv    $f2, $f2                    # |    103,847 |    103,847 |
.count b_cont
    b       be_cont.22211               # |    103,847 |    103,847 |
be_else.22211:
    finv_n  $f2, $f2                    # |     31,946 |     31,946 |
be_cont.22211:
be_cont.22210:
    fmul    $f1, $f2, $f1               # |    135,793 |    135,793 |
    store   $f1, [ext_nvector + 0]      # |    135,793 |    135,793 |
    load    [ext_nvector + 1], $f1      # |    135,793 |    135,793 |
    fmul    $f1, $f2, $f1               # |    135,793 |    135,793 |
    store   $f1, [ext_nvector + 1]      # |    135,793 |    135,793 |
    load    [ext_nvector + 2], $f1      # |    135,793 |    135,793 |
    fmul    $f1, $f2, $f1               # |    135,793 |    135,793 |
    store   $f1, [ext_nvector + 2]      # |    135,793 |    135,793 |
be_cont.22208:
be_cont.22205:
.count move_args
    mov     $i15, $i1                   # |    642,233 |    642,233 |
    jal     utexture.2908, $ra1         # |    642,233 |    642,233 |
    load    [$ig1 + 0], $i12            # |    642,233 |    642,233 |
    load    [$i12 + 0], $i1             # |    642,233 |    642,233 |
    bne     $i1, -1, be_else.22212      # |    642,233 |    642,233 |
be_then.22212:
    li      0, $i1
.count b_cont
    b       be_cont.22212
be_else.22212:
    bne     $i1, 99, be_else.22213      # |    642,233 |    642,233 |
be_then.22213:
    li      1, $i1
.count b_cont
    b       be_cont.22213
be_else.22213:
    call    solver_fast.2796            # |    642,233 |    642,233 |
    bne     $i1, 0, be_else.22214       # |    642,233 |    642,233 |
be_then.22214:
    li      0, $i1                      # |    441,257 |    441,257 |
.count b_cont
    b       be_cont.22214               # |    441,257 |    441,257 |
be_else.22214:
    bg      $fc7, $fg0, ble_else.22215  # |    200,976 |    200,976 |
ble_then.22215:
    li      0, $i1                      # |      6,935 |      6,935 |
.count b_cont
    b       ble_cont.22215              # |      6,935 |      6,935 |
ble_else.22215:
    load    [$i12 + 1], $i1             # |    194,041 |    194,041 |
    bne     $i1, -1, be_else.22216      # |    194,041 |    194,041 |
be_then.22216:
    li      0, $i1
.count b_cont
    b       be_cont.22216
be_else.22216:
    li      0, $i8                      # |    194,041 |    194,041 |
    load    [ext_and_net + $i1], $i9    # |    194,041 |    194,041 |
    jal     shadow_check_and_group.2862, $ra1# |    194,041 |    194,041 |
    bne     $i1, 0, be_else.22217       # |    194,041 |    194,041 |
be_then.22217:
    load    [$i12 + 2], $i1             # |    153,753 |    153,753 |
    bne     $i1, -1, be_else.22218      # |    153,753 |    153,753 |
be_then.22218:
    li      0, $i1
.count b_cont
    b       be_cont.22217
be_else.22218:
    li      0, $i8                      # |    153,753 |    153,753 |
    load    [ext_and_net + $i1], $i9    # |    153,753 |    153,753 |
    jal     shadow_check_and_group.2862, $ra1# |    153,753 |    153,753 |
    bne     $i1, 0, be_else.22219       # |    153,753 |    153,753 |
be_then.22219:
    li      3, $i10                     # |    143,619 |    143,619 |
.count move_args
    mov     $i12, $i11                  # |    143,619 |    143,619 |
    jal     shadow_check_one_or_group.2865, $ra2# |    143,619 |    143,619 |
    bne     $i1, 0, be_else.22220       # |    143,619 |    143,619 |
be_then.22220:
    li      0, $i1                      # |     78,653 |     78,653 |
.count b_cont
    b       be_cont.22217               # |     78,653 |     78,653 |
be_else.22220:
    li      1, $i1                      # |     64,966 |     64,966 |
.count b_cont
    b       be_cont.22217               # |     64,966 |     64,966 |
be_else.22219:
    li      1, $i1                      # |     10,134 |     10,134 |
.count b_cont
    b       be_cont.22217               # |     10,134 |     10,134 |
be_else.22217:
    li      1, $i1                      # |     40,288 |     40,288 |
be_cont.22217:
be_cont.22216:
ble_cont.22215:
be_cont.22214:
be_cont.22213:
    bne     $i1, 0, be_else.22221       # |    642,233 |    642,233 |
be_then.22221:
    li      1, $i12                     # |    526,845 |    526,845 |
.count move_args
    mov     $ig1, $i13                  # |    526,845 |    526,845 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    526,845 |    526,845 |
.count b_cont
    b       be_cont.22221               # |    526,845 |    526,845 |
be_else.22221:
    load    [$i12 + 1], $i1             # |    115,388 |    115,388 |
    bne     $i1, -1, be_else.22222      # |    115,388 |    115,388 |
be_then.22222:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22222
be_else.22222:
    li      0, $i8                      # |    115,388 |    115,388 |
    load    [ext_and_net + $i1], $i9    # |    115,388 |    115,388 |
    jal     shadow_check_and_group.2862, $ra1# |    115,388 |    115,388 |
    bne     $i1, 0, be_else.22223       # |    115,388 |    115,388 |
be_then.22223:
    load    [$i12 + 2], $i1             # |     75,100 |     75,100 |
    bne     $i1, -1, be_else.22224      # |     75,100 |     75,100 |
be_then.22224:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22223
be_else.22224:
    li      0, $i8                      # |     75,100 |     75,100 |
    load    [ext_and_net + $i1], $i9    # |     75,100 |     75,100 |
    jal     shadow_check_and_group.2862, $ra1# |     75,100 |     75,100 |
    bne     $i1, 0, be_else.22225       # |     75,100 |     75,100 |
be_then.22225:
    li      3, $i10                     # |     64,966 |     64,966 |
.count move_args
    mov     $i12, $i11                  # |     64,966 |     64,966 |
    jal     shadow_check_one_or_group.2865, $ra2# |     64,966 |     64,966 |
    bne     $i1, 0, be_else.22226       # |     64,966 |     64,966 |
be_then.22226:
    li      1, $i12
.count move_args
    mov     $ig1, $i13
    jal     shadow_check_one_or_matrix.2868, $ra3
.count b_cont
    b       be_cont.22223
be_else.22226:
    li      1, $i1                      # |     64,966 |     64,966 |
.count b_cont
    b       be_cont.22223               # |     64,966 |     64,966 |
be_else.22225:
    li      1, $i1                      # |     10,134 |     10,134 |
.count b_cont
    b       be_cont.22223               # |     10,134 |     10,134 |
be_else.22223:
    li      1, $i1                      # |     40,288 |     40,288 |
be_cont.22223:
be_cont.22222:
be_cont.22221:
be_cont.22212:
    bne     $i1, 0, be_else.22227       # |    642,233 |    642,233 |
be_then.22227:
    load    [$i15 + 7], $i1             # |    523,067 |    523,067 |
    load    [ext_nvector + 0], $f1      # |    523,067 |    523,067 |
    fmul    $f1, $fg14, $f1             # |    523,067 |    523,067 |
    load    [ext_nvector + 1], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg12, $f2             # |    523,067 |    523,067 |
    fadd    $f1, $f2, $f1               # |    523,067 |    523,067 |
    load    [ext_nvector + 2], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg13, $f2             # |    523,067 |    523,067 |
    fadd_n  $f1, $f2, $f1               # |    523,067 |    523,067 |
    bg      $f1, $f0, ble_cont.22228    # |    523,067 |    523,067 |
ble_then.22228:
    mov     $f0, $f1                    # |        709 |        709 |
ble_cont.22228:
    fmul    $f14, $f1, $f1              # |    523,067 |    523,067 |
    load    [$i1 + 0], $f2              # |    523,067 |    523,067 |
    fmul    $f1, $f2, $f1               # |    523,067 |    523,067 |
    fmul    $f1, $fg16, $f2             # |    523,067 |    523,067 |
    fadd    $fg1, $f2, $fg1             # |    523,067 |    523,067 |
    fmul    $f1, $fg11, $f2             # |    523,067 |    523,067 |
    fadd    $fg2, $f2, $fg2             # |    523,067 |    523,067 |
    fmul    $f1, $fg15, $f1             # |    523,067 |    523,067 |
    fadd    $fg3, $f1, $fg3             # |    523,067 |    523,067 |
    jr      $ra4                        # |    523,067 |    523,067 |
be_else.22227:
    jr      $ra4                        # |    119,166 |    119,166 |
.end trace_diffuse_ray

######################################################################
# iter_trace_diffuse_rays($i20, $i21, $i22)
# $ra = $ra5
# [$i1 - $i22]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7, $fg11, $fg15 - $fg16]
# [$ra - $ra4]
######################################################################
.begin iter_trace_diffuse_rays
iter_trace_diffuse_rays.2929:
    bl      $i22, 0, bge_else.22229     # |    558,060 |    558,060 |
bge_then.22229:
    load    [$i20 + $i22], $i1          # |    558,060 |    558,060 |
    load    [$i1 + 0], $i1              # |    558,060 |    558,060 |
    load    [$i1 + 0], $f1              # |    558,060 |    558,060 |
    load    [$i21 + 0], $f2             # |    558,060 |    558,060 |
    fmul    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 1], $f2              # |    558,060 |    558,060 |
    load    [$i21 + 1], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    load    [$i1 + 2], $f2              # |    558,060 |    558,060 |
    load    [$i21 + 2], $f3             # |    558,060 |    558,060 |
    fmul    $f2, $f3, $f2               # |    558,060 |    558,060 |
    fadd    $f1, $f2, $f1               # |    558,060 |    558,060 |
    bg      $f0, $f1, ble_else.22230    # |    558,060 |    558,060 |
ble_then.22230:
    fmul    $f1, $fc1, $f14             # |    381,373 |    381,373 |
    load    [$i20 + $i22], $i19         # |    381,373 |    381,373 |
    jal     trace_diffuse_ray.2926, $ra4# |    381,373 |    381,373 |
    sub     $i22, 2, $i22               # |    381,373 |    381,373 |
    bl      $i22, 0, bge_else.22231     # |    381,373 |    381,373 |
bge_then.22231:
    load    [$i20 + $i22], $i1          # |    365,799 |    365,799 |
    load    [$i1 + 0], $i1              # |    365,799 |    365,799 |
    load    [$i1 + 0], $f1              # |    365,799 |    365,799 |
    load    [$i21 + 0], $f2             # |    365,799 |    365,799 |
    fmul    $f1, $f2, $f1               # |    365,799 |    365,799 |
    load    [$i1 + 1], $f2              # |    365,799 |    365,799 |
    load    [$i21 + 1], $f3             # |    365,799 |    365,799 |
    fmul    $f2, $f3, $f2               # |    365,799 |    365,799 |
    fadd    $f1, $f2, $f1               # |    365,799 |    365,799 |
    load    [$i1 + 2], $f2              # |    365,799 |    365,799 |
    load    [$i21 + 2], $f3             # |    365,799 |    365,799 |
    fmul    $f2, $f3, $f2               # |    365,799 |    365,799 |
    fadd    $f1, $f2, $f1               # |    365,799 |    365,799 |
    bg      $f0, $f1, ble_else.22232    # |    365,799 |    365,799 |
ble_then.22232:
    fmul    $f1, $fc1, $f14             # |    191,106 |    191,106 |
    load    [$i20 + $i22], $i19         # |    191,106 |    191,106 |
    jal     trace_diffuse_ray.2926, $ra4# |    191,106 |    191,106 |
    sub     $i22, 2, $i22               # |    191,106 |    191,106 |
    b       iter_trace_diffuse_rays.2929# |    191,106 |    191,106 |
ble_else.22232:
    fmul    $f1, $fc2, $f14             # |    174,693 |    174,693 |
    add     $i22, 1, $i1                # |    174,693 |    174,693 |
    load    [$i20 + $i1], $i19          # |    174,693 |    174,693 |
    jal     trace_diffuse_ray.2926, $ra4# |    174,693 |    174,693 |
    sub     $i22, 2, $i22               # |    174,693 |    174,693 |
    b       iter_trace_diffuse_rays.2929# |    174,693 |    174,693 |
bge_else.22231:
    jr      $ra5                        # |     15,574 |     15,574 |
ble_else.22230:
    fmul    $f1, $fc2, $f14             # |    176,687 |    176,687 |
    add     $i22, 1, $i1                # |    176,687 |    176,687 |
    load    [$i20 + $i1], $i19          # |    176,687 |    176,687 |
    jal     trace_diffuse_ray.2926, $ra4# |    176,687 |    176,687 |
    sub     $i22, 2, $i22               # |    176,687 |    176,687 |
    bl      $i22, 0, bge_else.22233     # |    176,687 |    176,687 |
bge_then.22233:
    load    [$i20 + $i22], $i1          # |    173,659 |    173,659 |
    load    [$i1 + 0], $i1              # |    173,659 |    173,659 |
    load    [$i1 + 0], $f1              # |    173,659 |    173,659 |
    load    [$i21 + 0], $f2             # |    173,659 |    173,659 |
    fmul    $f1, $f2, $f1               # |    173,659 |    173,659 |
    load    [$i1 + 1], $f2              # |    173,659 |    173,659 |
    load    [$i21 + 1], $f3             # |    173,659 |    173,659 |
    fmul    $f2, $f3, $f2               # |    173,659 |    173,659 |
    fadd    $f1, $f2, $f1               # |    173,659 |    173,659 |
    load    [$i1 + 2], $f2              # |    173,659 |    173,659 |
    load    [$i21 + 2], $f3             # |    173,659 |    173,659 |
    fmul    $f2, $f3, $f2               # |    173,659 |    173,659 |
    fadd    $f1, $f2, $f1               # |    173,659 |    173,659 |
    bg      $f0, $f1, ble_else.22234    # |    173,659 |    173,659 |
ble_then.22234:
    fmul    $f1, $fc1, $f14             # |     20,160 |     20,160 |
    load    [$i20 + $i22], $i19         # |     20,160 |     20,160 |
    jal     trace_diffuse_ray.2926, $ra4# |     20,160 |     20,160 |
    sub     $i22, 2, $i22               # |     20,160 |     20,160 |
    b       iter_trace_diffuse_rays.2929# |     20,160 |     20,160 |
ble_else.22234:
    fmul    $f1, $fc2, $f14             # |    153,499 |    153,499 |
    add     $i22, 1, $i1                # |    153,499 |    153,499 |
    load    [$i20 + $i1], $i19          # |    153,499 |    153,499 |
    jal     trace_diffuse_ray.2926, $ra4# |    153,499 |    153,499 |
    sub     $i22, 2, $i22               # |    153,499 |    153,499 |
    b       iter_trace_diffuse_rays.2929# |    153,499 |    153,499 |
bge_else.22233:
    jr      $ra5                        # |      3,028 |      3,028 |
bge_else.22229:
    jr      $ra5
.end iter_trace_diffuse_rays

######################################################################
# calc_diffuse_using_1point($i23, $i24)
# $ra = $ra6
# [$i1 - $i27]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin calc_diffuse_using_1point
calc_diffuse_using_1point.2942:
    load    [$i23 + 5], $i1             # |      1,737 |      1,737 |
    load    [$i1 + $i24], $i1           # |      1,737 |      1,737 |
    load    [$i1 + 0], $fg1             # |      1,737 |      1,737 |
    load    [$i1 + 1], $fg2             # |      1,737 |      1,737 |
    load    [$i1 + 2], $fg3             # |      1,737 |      1,737 |
    load    [$i23 + 7], $i1             # |      1,737 |      1,737 |
    load    [$i23 + 1], $i2             # |      1,737 |      1,737 |
    load    [$i23 + 6], $i3             # |      1,737 |      1,737 |
    load    [$i1 + $i24], $i25          # |      1,737 |      1,737 |
    load    [$i2 + $i24], $i26          # |      1,737 |      1,737 |
    load    [$i3 + 0], $i27             # |      1,737 |      1,737 |
    be      $i27, 0, bne_cont.22235     # |      1,737 |      1,737 |
bne_then.22235:
    load    [ext_dirvecs + 0], $i20     # |      1,389 |      1,389 |
    load    [$i26 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i26 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i26 + 2], $fg10           # |      1,389 |      1,389 |
    sub     $ig0, 1, $i1                # |      1,389 |      1,389 |
.count move_args
    mov     $i26, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i20 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $i1              # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i25 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i25 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i25 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, ble_else.22236    # |      1,389 |      1,389 |
ble_then.22236:
    load    [$i20 + 118], $i19          # |         90 |         90 |
    fmul    $f1, $fc1, $f14             # |         90 |         90 |
    jal     trace_diffuse_ray.2926, $ra4# |         90 |         90 |
    li      116, $i22                   # |         90 |         90 |
.count move_args
    mov     $i25, $i21                  # |         90 |         90 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         90 |         90 |
.count b_cont
    b       ble_cont.22236              # |         90 |         90 |
ble_else.22236:
    load    [$i20 + 119], $i19          # |      1,299 |      1,299 |
    fmul    $f1, $fc2, $f14             # |      1,299 |      1,299 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,299 |      1,299 |
    li      116, $i22                   # |      1,299 |      1,299 |
.count move_args
    mov     $i25, $i21                  # |      1,299 |      1,299 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,299 |      1,299 |
ble_cont.22236:
bne_cont.22235:
    be      $i27, 1, bne_cont.22237     # |      1,737 |      1,737 |
bne_then.22237:
    load    [ext_dirvecs + 1], $i20     # |      1,389 |      1,389 |
    load    [$i26 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i26 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i26 + 2], $fg10           # |      1,389 |      1,389 |
    sub     $ig0, 1, $i1                # |      1,389 |      1,389 |
.count move_args
    mov     $i26, $i2                   # |      1,389 |      1,389 |
    call    setup_startp_constants.2831 # |      1,389 |      1,389 |
    load    [$i20 + 118], $i1           # |      1,389 |      1,389 |
    load    [$i1 + 0], $i1              # |      1,389 |      1,389 |
    load    [$i1 + 0], $f1              # |      1,389 |      1,389 |
    load    [$i25 + 0], $f2             # |      1,389 |      1,389 |
    fmul    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 1], $f2              # |      1,389 |      1,389 |
    load    [$i25 + 1], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    load    [$i1 + 2], $f2              # |      1,389 |      1,389 |
    load    [$i25 + 2], $f3             # |      1,389 |      1,389 |
    fmul    $f2, $f3, $f2               # |      1,389 |      1,389 |
    fadd    $f1, $f2, $f1               # |      1,389 |      1,389 |
    bg      $f0, $f1, ble_else.22238    # |      1,389 |      1,389 |
ble_then.22238:
    load    [$i20 + 118], $i19          # |         96 |         96 |
    fmul    $f1, $fc1, $f14             # |         96 |         96 |
    jal     trace_diffuse_ray.2926, $ra4# |         96 |         96 |
    li      116, $i22                   # |         96 |         96 |
.count move_args
    mov     $i25, $i21                  # |         96 |         96 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         96 |         96 |
.count b_cont
    b       ble_cont.22238              # |         96 |         96 |
ble_else.22238:
    load    [$i20 + 119], $i19          # |      1,293 |      1,293 |
    fmul    $f1, $fc2, $f14             # |      1,293 |      1,293 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,293 |      1,293 |
    li      116, $i22                   # |      1,293 |      1,293 |
.count move_args
    mov     $i25, $i21                  # |      1,293 |      1,293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,293 |      1,293 |
ble_cont.22238:
bne_cont.22237:
    be      $i27, 2, bne_cont.22239     # |      1,737 |      1,737 |
bne_then.22239:
    load    [ext_dirvecs + 2], $i20     # |      1,400 |      1,400 |
    load    [$i26 + 0], $fg8            # |      1,400 |      1,400 |
    load    [$i26 + 1], $fg9            # |      1,400 |      1,400 |
    load    [$i26 + 2], $fg10           # |      1,400 |      1,400 |
    sub     $ig0, 1, $i1                # |      1,400 |      1,400 |
.count move_args
    mov     $i26, $i2                   # |      1,400 |      1,400 |
    call    setup_startp_constants.2831 # |      1,400 |      1,400 |
    load    [$i20 + 118], $i1           # |      1,400 |      1,400 |
    load    [$i1 + 0], $i1              # |      1,400 |      1,400 |
    load    [$i1 + 0], $f1              # |      1,400 |      1,400 |
    load    [$i25 + 0], $f2             # |      1,400 |      1,400 |
    fmul    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 1], $f2              # |      1,400 |      1,400 |
    load    [$i25 + 1], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    load    [$i1 + 2], $f2              # |      1,400 |      1,400 |
    load    [$i25 + 2], $f3             # |      1,400 |      1,400 |
    fmul    $f2, $f3, $f2               # |      1,400 |      1,400 |
    fadd    $f1, $f2, $f1               # |      1,400 |      1,400 |
    bg      $f0, $f1, ble_else.22240    # |      1,400 |      1,400 |
ble_then.22240:
    load    [$i20 + 118], $i19          # |        126 |        126 |
    fmul    $f1, $fc1, $f14             # |        126 |        126 |
    jal     trace_diffuse_ray.2926, $ra4# |        126 |        126 |
    li      116, $i22                   # |        126 |        126 |
.count move_args
    mov     $i25, $i21                  # |        126 |        126 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        126 |        126 |
.count b_cont
    b       ble_cont.22240              # |        126 |        126 |
ble_else.22240:
    load    [$i20 + 119], $i19          # |      1,274 |      1,274 |
    fmul    $f1, $fc2, $f14             # |      1,274 |      1,274 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,274 |      1,274 |
    li      116, $i22                   # |      1,274 |      1,274 |
.count move_args
    mov     $i25, $i21                  # |      1,274 |      1,274 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,274 |      1,274 |
ble_cont.22240:
bne_cont.22239:
    be      $i27, 3, bne_cont.22241     # |      1,737 |      1,737 |
bne_then.22241:
    load    [ext_dirvecs + 3], $i20     # |      1,385 |      1,385 |
    load    [$i26 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i26 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i26 + 2], $fg10           # |      1,385 |      1,385 |
    sub     $ig0, 1, $i1                # |      1,385 |      1,385 |
.count move_args
    mov     $i26, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i20 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $i1              # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i25 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i25 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i25 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, ble_else.22242    # |      1,385 |      1,385 |
ble_then.22242:
    load    [$i20 + 118], $i19          # |        115 |        115 |
    fmul    $f1, $fc1, $f14             # |        115 |        115 |
    jal     trace_diffuse_ray.2926, $ra4# |        115 |        115 |
    li      116, $i22                   # |        115 |        115 |
.count move_args
    mov     $i25, $i21                  # |        115 |        115 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        115 |        115 |
.count b_cont
    b       ble_cont.22242              # |        115 |        115 |
ble_else.22242:
    load    [$i20 + 119], $i19          # |      1,270 |      1,270 |
    fmul    $f1, $fc2, $f14             # |      1,270 |      1,270 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,270 |      1,270 |
    li      116, $i22                   # |      1,270 |      1,270 |
.count move_args
    mov     $i25, $i21                  # |      1,270 |      1,270 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,270 |      1,270 |
ble_cont.22242:
bne_cont.22241:
    be      $i27, 4, bne_cont.22243     # |      1,737 |      1,737 |
bne_then.22243:
    load    [ext_dirvecs + 4], $i20     # |      1,385 |      1,385 |
    load    [$i26 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i26 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i26 + 2], $fg10           # |      1,385 |      1,385 |
    sub     $ig0, 1, $i1                # |      1,385 |      1,385 |
.count move_args
    mov     $i26, $i2                   # |      1,385 |      1,385 |
    call    setup_startp_constants.2831 # |      1,385 |      1,385 |
    load    [$i20 + 118], $i1           # |      1,385 |      1,385 |
    load    [$i1 + 0], $i1              # |      1,385 |      1,385 |
    load    [$i1 + 0], $f1              # |      1,385 |      1,385 |
    load    [$i25 + 0], $f2             # |      1,385 |      1,385 |
    fmul    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 1], $f2              # |      1,385 |      1,385 |
    load    [$i25 + 1], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    load    [$i1 + 2], $f2              # |      1,385 |      1,385 |
    load    [$i25 + 2], $f3             # |      1,385 |      1,385 |
    fmul    $f2, $f3, $f2               # |      1,385 |      1,385 |
    fadd    $f1, $f2, $f1               # |      1,385 |      1,385 |
    bg      $f0, $f1, ble_else.22244    # |      1,385 |      1,385 |
ble_then.22244:
    load    [$i20 + 118], $i19          # |         98 |         98 |
    fmul    $f1, $fc1, $f14             # |         98 |         98 |
    jal     trace_diffuse_ray.2926, $ra4# |         98 |         98 |
    li      116, $i22                   # |         98 |         98 |
.count move_args
    mov     $i25, $i21                  # |         98 |         98 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         98 |         98 |
.count b_cont
    b       ble_cont.22244              # |         98 |         98 |
ble_else.22244:
    load    [$i20 + 119], $i19          # |      1,287 |      1,287 |
    fmul    $f1, $fc2, $f14             # |      1,287 |      1,287 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,287 |      1,287 |
    li      116, $i22                   # |      1,287 |      1,287 |
.count move_args
    mov     $i25, $i21                  # |      1,287 |      1,287 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,287 |      1,287 |
ble_cont.22244:
bne_cont.22243:
    load    [$i23 + 4], $i1             # |      1,737 |      1,737 |
    load    [$i1 + $i24], $i1           # |      1,737 |      1,737 |
    load    [$i1 + 0], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg1, $f1              # |      1,737 |      1,737 |
    fadd    $fg4, $f1, $fg4             # |      1,737 |      1,737 |
    load    [$i1 + 1], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg2, $f1              # |      1,737 |      1,737 |
    fadd    $fg5, $f1, $fg5             # |      1,737 |      1,737 |
    load    [$i1 + 2], $f1              # |      1,737 |      1,737 |
    fmul    $f1, $fg3, $f1              # |      1,737 |      1,737 |
    fadd    $fg6, $f1, $fg6             # |      1,737 |      1,737 |
    jr      $ra6                        # |      1,737 |      1,737 |
.end calc_diffuse_using_1point

######################################################################
# do_without_neighbors($i28, $i23)
# $ra = $ra7
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin do_without_neighbors
do_without_neighbors.2951:
    bg      $i23, 4, ble_else.22245     # |      2,430 |      2,430 |
ble_then.22245:
    load    [$i28 + 2], $i24            # |      2,430 |      2,430 |
    load    [$i24 + $i23], $i1          # |      2,430 |      2,430 |
    bl      $i1, 0, bge_else.22246      # |      2,430 |      2,430 |
bge_then.22246:
    load    [$i28 + 3], $i25            # |        143 |        143 |
    load    [$i25 + $i23], $i1          # |        143 |        143 |
    bne     $i1, 0, be_else.22247       # |        143 |        143 |
be_then.22247:
    add     $i23, 1, $i29               # |         11 |         11 |
    bg      $i29, 4, ble_else.22248     # |         11 |         11 |
ble_then.22248:
    load    [$i24 + $i29], $i1          # |         11 |         11 |
    bl      $i1, 0, bge_else.22249      # |         11 |         11 |
bge_then.22249:
    load    [$i25 + $i29], $i1          # |          1 |          1 |
    bne     $i1, 0, be_else.22250       # |          1 |          1 |
be_then.22250:
    add     $i29, 1, $i23
    b       do_without_neighbors.2951
be_else.22250:
.count move_args
    mov     $i28, $i23                  # |          1 |          1 |
.count move_args
    mov     $i29, $i24                  # |          1 |          1 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          1 |          1 |
    add     $i29, 1, $i23               # |          1 |          1 |
    b       do_without_neighbors.2951   # |          1 |          1 |
bge_else.22249:
    jr      $ra7                        # |         10 |         10 |
ble_else.22248:
    jr      $ra7
be_else.22247:
    load    [$i28 + 5], $i1             # |        132 |        132 |
    load    [$i1 + $i23], $i1           # |        132 |        132 |
    load    [$i1 + 0], $fg1             # |        132 |        132 |
    load    [$i1 + 1], $fg2             # |        132 |        132 |
    load    [$i1 + 2], $fg3             # |        132 |        132 |
    load    [$i28 + 7], $i1             # |        132 |        132 |
    load    [$i28 + 1], $i2             # |        132 |        132 |
    load    [$i28 + 6], $i3             # |        132 |        132 |
    load    [$i1 + $i23], $i26          # |        132 |        132 |
    load    [$i2 + $i23], $i27          # |        132 |        132 |
    load    [$i3 + 0], $i29             # |        132 |        132 |
    be      $i29, 0, bne_cont.22251     # |        132 |        132 |
bne_then.22251:
    load    [ext_dirvecs + 0], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i27, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i20 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i26 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i26 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i26 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.22252    # |        107 |        107 |
ble_then.22252:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22252
ble_else.22252:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.22252:
bne_cont.22251:
    be      $i29, 1, bne_cont.22253     # |        132 |        132 |
bne_then.22253:
    load    [ext_dirvecs + 1], $i20     # |        104 |        104 |
    load    [$i27 + 0], $fg8            # |        104 |        104 |
    load    [$i27 + 1], $fg9            # |        104 |        104 |
    load    [$i27 + 2], $fg10           # |        104 |        104 |
    sub     $ig0, 1, $i1                # |        104 |        104 |
.count move_args
    mov     $i27, $i2                   # |        104 |        104 |
    call    setup_startp_constants.2831 # |        104 |        104 |
    load    [$i20 + 118], $i1           # |        104 |        104 |
    load    [$i1 + 0], $i1              # |        104 |        104 |
    load    [$i1 + 0], $f1              # |        104 |        104 |
    load    [$i26 + 0], $f2             # |        104 |        104 |
    fmul    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 1], $f2              # |        104 |        104 |
    load    [$i26 + 1], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    load    [$i1 + 2], $f2              # |        104 |        104 |
    load    [$i26 + 2], $f3             # |        104 |        104 |
    fmul    $f2, $f3, $f2               # |        104 |        104 |
    fadd    $f1, $f2, $f1               # |        104 |        104 |
    bg      $f0, $f1, ble_else.22254    # |        104 |        104 |
ble_then.22254:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22254
ble_else.22254:
    fmul    $f1, $fc2, $f14             # |        104 |        104 |
    load    [$i20 + 119], $i19          # |        104 |        104 |
    jal     trace_diffuse_ray.2926, $ra4# |        104 |        104 |
    li      116, $i22                   # |        104 |        104 |
.count move_args
    mov     $i26, $i21                  # |        104 |        104 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        104 |        104 |
ble_cont.22254:
bne_cont.22253:
    be      $i29, 2, bne_cont.22255     # |        132 |        132 |
bne_then.22255:
    load    [ext_dirvecs + 2], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i27, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i20 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i26 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i26 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i26 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.22256    # |        107 |        107 |
ble_then.22256:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22256
ble_else.22256:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.22256:
bne_cont.22255:
    be      $i29, 3, bne_cont.22257     # |        132 |        132 |
bne_then.22257:
    load    [ext_dirvecs + 3], $i20     # |        103 |        103 |
    load    [$i27 + 0], $fg8            # |        103 |        103 |
    load    [$i27 + 1], $fg9            # |        103 |        103 |
    load    [$i27 + 2], $fg10           # |        103 |        103 |
    sub     $ig0, 1, $i1                # |        103 |        103 |
.count move_args
    mov     $i27, $i2                   # |        103 |        103 |
    call    setup_startp_constants.2831 # |        103 |        103 |
    load    [$i20 + 118], $i1           # |        103 |        103 |
    load    [$i1 + 0], $i1              # |        103 |        103 |
    load    [$i1 + 0], $f1              # |        103 |        103 |
    load    [$i26 + 0], $f2             # |        103 |        103 |
    fmul    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 1], $f2              # |        103 |        103 |
    load    [$i26 + 1], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    load    [$i1 + 2], $f2              # |        103 |        103 |
    load    [$i26 + 2], $f3             # |        103 |        103 |
    fmul    $f2, $f3, $f2               # |        103 |        103 |
    fadd    $f1, $f2, $f1               # |        103 |        103 |
    bg      $f0, $f1, ble_else.22258    # |        103 |        103 |
ble_then.22258:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22258
ble_else.22258:
    fmul    $f1, $fc2, $f14             # |        103 |        103 |
    load    [$i20 + 119], $i19          # |        103 |        103 |
    jal     trace_diffuse_ray.2926, $ra4# |        103 |        103 |
    li      116, $i22                   # |        103 |        103 |
.count move_args
    mov     $i26, $i21                  # |        103 |        103 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        103 |        103 |
ble_cont.22258:
bne_cont.22257:
    be      $i29, 4, bne_cont.22259     # |        132 |        132 |
bne_then.22259:
    load    [ext_dirvecs + 4], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    sub     $ig0, 1, $i1                # |        107 |        107 |
.count move_args
    mov     $i27, $i2                   # |        107 |        107 |
    call    setup_startp_constants.2831 # |        107 |        107 |
    load    [$i20 + 118], $i1           # |        107 |        107 |
    load    [$i1 + 0], $i1              # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    load    [$i26 + 0], $f2             # |        107 |        107 |
    fmul    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 1], $f2              # |        107 |        107 |
    load    [$i26 + 1], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    load    [$i1 + 2], $f2              # |        107 |        107 |
    load    [$i26 + 2], $f3             # |        107 |        107 |
    fmul    $f2, $f3, $f2               # |        107 |        107 |
    fadd    $f1, $f2, $f1               # |        107 |        107 |
    bg      $f0, $f1, ble_else.22260    # |        107 |        107 |
ble_then.22260:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22260
ble_else.22260:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
ble_cont.22260:
bne_cont.22259:
    load    [$i28 + 4], $i1             # |        132 |        132 |
    load    [$i1 + $i23], $i1           # |        132 |        132 |
    load    [$i1 + 0], $f1              # |        132 |        132 |
    fmul    $f1, $fg1, $f1              # |        132 |        132 |
    fadd    $fg4, $f1, $fg4             # |        132 |        132 |
    load    [$i1 + 1], $f1              # |        132 |        132 |
    fmul    $f1, $fg2, $f1              # |        132 |        132 |
    fadd    $fg5, $f1, $fg5             # |        132 |        132 |
    load    [$i1 + 2], $f1              # |        132 |        132 |
    fmul    $f1, $fg3, $f1              # |        132 |        132 |
    fadd    $fg6, $f1, $fg6             # |        132 |        132 |
    add     $i23, 1, $i29               # |        132 |        132 |
    bg      $i29, 4, ble_else.22261     # |        132 |        132 |
ble_then.22261:
    load    [$i24 + $i29], $i1          # |        132 |        132 |
    bl      $i1, 0, bge_else.22262      # |        132 |        132 |
bge_then.22262:
    load    [$i25 + $i29], $i1
    bne     $i1, 0, be_else.22263
be_then.22263:
    add     $i29, 1, $i23
    b       do_without_neighbors.2951
be_else.22263:
.count move_args
    mov     $i28, $i23
.count move_args
    mov     $i29, $i24
    jal     calc_diffuse_using_1point.2942, $ra6
    add     $i29, 1, $i23
    b       do_without_neighbors.2951
bge_else.22262:
    jr      $ra7                        # |        132 |        132 |
ble_else.22261:
    jr      $ra7
bge_else.22246:
    jr      $ra7                        # |      2,287 |      2,287 |
ble_else.22245:
    jr      $ra7
.end do_without_neighbors

######################################################################
# try_exploit_neighbors($i2, $i3, $i4, $i5, $i28)
# $ra = $ra7
# [$i1 - $i29]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra6]
######################################################################
.begin try_exploit_neighbors
try_exploit_neighbors.2967:
    bg      $i28, 4, ble_else.22264     # |     15,923 |     15,923 |
ble_then.22264:
    load    [$i4 + $i2], $i1            # |     15,923 |     15,923 |
    load    [$i1 + 2], $i6              # |     15,923 |     15,923 |
    load    [$i6 + $i28], $i6           # |     15,923 |     15,923 |
    bl      $i6, 0, bge_else.22265      # |     15,923 |     15,923 |
bge_then.22265:
    load    [$i3 + $i2], $i7            # |      1,968 |      1,968 |
    load    [$i7 + 2], $i8              # |      1,968 |      1,968 |
    load    [$i8 + $i28], $i8           # |      1,968 |      1,968 |
    bne     $i8, $i6, be_else.22266     # |      1,968 |      1,968 |
be_then.22266:
    load    [$i5 + $i2], $i8            # |      1,796 |      1,796 |
    load    [$i8 + 2], $i8              # |      1,796 |      1,796 |
    load    [$i8 + $i28], $i8           # |      1,796 |      1,796 |
    bne     $i8, $i6, be_else.22267     # |      1,796 |      1,796 |
be_then.22267:
    sub     $i2, 1, $i8                 # |      1,700 |      1,700 |
    load    [$i4 + $i8], $i8            # |      1,700 |      1,700 |
    load    [$i8 + 2], $i8              # |      1,700 |      1,700 |
    load    [$i8 + $i28], $i8           # |      1,700 |      1,700 |
    bne     $i8, $i6, be_else.22268     # |      1,700 |      1,700 |
be_then.22268:
    add     $i2, 1, $i8                 # |      1,634 |      1,634 |
    load    [$i4 + $i8], $i8            # |      1,634 |      1,634 |
    load    [$i8 + 2], $i8              # |      1,634 |      1,634 |
    load    [$i8 + $i28], $i8           # |      1,634 |      1,634 |
    bne     $i8, $i6, be_else.22269     # |      1,634 |      1,634 |
be_then.22269:
    li      1, $i6                      # |      1,590 |      1,590 |
.count b_cont
    b       be_cont.22266               # |      1,590 |      1,590 |
be_else.22269:
    li      0, $i6                      # |         44 |         44 |
.count b_cont
    b       be_cont.22266               # |         44 |         44 |
be_else.22268:
    li      0, $i6                      # |         66 |         66 |
.count b_cont
    b       be_cont.22266               # |         66 |         66 |
be_else.22267:
    li      0, $i6                      # |         96 |         96 |
.count b_cont
    b       be_cont.22266               # |         96 |         96 |
be_else.22266:
    li      0, $i6                      # |        172 |        172 |
be_cont.22266:
    bne     $i6, 0, be_else.22270       # |      1,968 |      1,968 |
be_then.22270:
    bg      $i28, 4, ble_else.22271     # |        378 |        378 |
ble_then.22271:
    load    [$i4 + $i2], $i29           # |        378 |        378 |
    load    [$i29 + 2], $i1             # |        378 |        378 |
    load    [$i1 + $i28], $i1           # |        378 |        378 |
    bl      $i1, 0, bge_else.22272      # |        378 |        378 |
bge_then.22272:
    load    [$i29 + 3], $i1             # |        378 |        378 |
    load    [$i1 + $i28], $i1           # |        378 |        378 |
    bne     $i1, 0, be_else.22273       # |        378 |        378 |
be_then.22273:
    add     $i28, 1, $i23               # |         32 |         32 |
.count move_args
    mov     $i29, $i28                  # |         32 |         32 |
    b       do_without_neighbors.2951   # |         32 |         32 |
be_else.22273:
.count move_args
    mov     $i29, $i23                  # |        346 |        346 |
.count move_args
    mov     $i28, $i24                  # |        346 |        346 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        346 |        346 |
    add     $i28, 1, $i23               # |        346 |        346 |
.count move_args
    mov     $i29, $i28                  # |        346 |        346 |
    b       do_without_neighbors.2951   # |        346 |        346 |
bge_else.22272:
    jr      $ra7
ble_else.22271:
    jr      $ra7
be_else.22270:
    load    [$i1 + 3], $i1              # |      1,590 |      1,590 |
    load    [$i1 + $i28], $i1           # |      1,590 |      1,590 |
    bne     $i1, 0, be_else.22274       # |      1,590 |      1,590 |
be_then.22274:
    add     $i28, 1, $i28               # |         26 |         26 |
    b       try_exploit_neighbors.2967  # |         26 |         26 |
be_else.22274:
    load    [$i7 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $fg3             # |      1,564 |      1,564 |
    sub     $i2, 1, $i1                 # |      1,564 |      1,564 |
    load    [$i4 + $i1], $i1            # |      1,564 |      1,564 |
    load    [$i1 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i4 + $i2], $i1            # |      1,564 |      1,564 |
    load    [$i1 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    add     $i2, 1, $i1                 # |      1,564 |      1,564 |
    load    [$i4 + $i1], $i1            # |      1,564 |      1,564 |
    load    [$i1 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i5 + $i2], $i1            # |      1,564 |      1,564 |
    load    [$i1 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fadd    $fg1, $f1, $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fadd    $fg2, $f1, $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fadd    $fg3, $f1, $fg3             # |      1,564 |      1,564 |
    load    [$i4 + $i2], $i1            # |      1,564 |      1,564 |
    load    [$i1 + 4], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg1, $f1              # |      1,564 |      1,564 |
    fadd    $fg4, $f1, $fg4             # |      1,564 |      1,564 |
    load    [$i1 + 1], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg2, $f1              # |      1,564 |      1,564 |
    fadd    $fg5, $f1, $fg5             # |      1,564 |      1,564 |
    load    [$i1 + 2], $f1              # |      1,564 |      1,564 |
    fmul    $f1, $fg3, $f1              # |      1,564 |      1,564 |
    fadd    $fg6, $f1, $fg6             # |      1,564 |      1,564 |
    add     $i28, 1, $i28               # |      1,564 |      1,564 |
    b       try_exploit_neighbors.2967  # |      1,564 |      1,564 |
bge_else.22265:
    jr      $ra7                        # |     13,955 |     13,955 |
ble_else.22264:
    jr      $ra7
.end try_exploit_neighbors

######################################################################
# write_ppm_header()
# $ra = $ra
# [$i2]
# []
# []
# []
# [$ra]
######################################################################
.begin write_ppm_header
write_ppm_header.2974:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |          1 |          1 |
.count stack_move
    sub     $sp, 1, $sp                 # |          1 |          1 |
    li      80, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      54, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      10, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      49, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      56, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      32, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      49, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      56, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      32, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      50, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      53, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
    li      53, $i2                     # |          1 |          1 |
    call    ext_write                   # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |
    li      10, $i2                     # |          1 |          1 |
    b       ext_write                   # |          1 |          1 |
.end write_ppm_header

######################################################################
# write_rgb_element($f2)
# $ra = $ra
# [$i1 - $i4]
# [$f2 - $f3]
# []
# []
# [$ra]
######################################################################
.begin write_rgb_element
write_rgb_element.2976:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |     49,152 |     49,152 |
.count stack_move
    sub     $sp, 1, $sp                 # |     49,152 |     49,152 |
    li      255, $i4                    # |     49,152 |     49,152 |
    call    ext_int_of_float            # |     49,152 |     49,152 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     49,152 |     49,152 |
.count stack_move
    add     $sp, 1, $sp                 # |     49,152 |     49,152 |
    bg      $i1, $i4, ble_else.22275    # |     49,152 |     49,152 |
ble_then.22275:
    bl      $i1, 0, bge_else.22276      # |     33,363 |     33,363 |
bge_then.22276:
.count move_args
    mov     $i1, $i2                    # |     33,363 |     33,363 |
    b       ext_write                   # |     33,363 |     33,363 |
bge_else.22276:
    li      0, $i2
    b       ext_write
ble_else.22275:
    li      255, $i2                    # |     15,789 |     15,789 |
    b       ext_write                   # |     15,789 |     15,789 |
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
.begin write_rgb
write_rgb.2978:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |     16,384 |     16,384 |
.count stack_move
    sub     $sp, 1, $sp                 # |     16,384 |     16,384 |
.count move_args
    mov     $fg4, $f2                   # |     16,384 |     16,384 |
    call    write_rgb_element.2976      # |     16,384 |     16,384 |
.count move_args
    mov     $fg5, $f2                   # |     16,384 |     16,384 |
    call    write_rgb_element.2976      # |     16,384 |     16,384 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     16,384 |     16,384 |
.count stack_move
    add     $sp, 1, $sp                 # |     16,384 |     16,384 |
.count move_args
    mov     $fg6, $f2                   # |     16,384 |     16,384 |
    b       write_rgb_element.2976      # |     16,384 |     16,384 |
.end write_rgb

######################################################################
# pretrace_diffuse_rays($i23, $i24)
# $ra = $ra6
# [$i1 - $i30]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg3, $fg7 - $fg11, $fg15 - $fg16]
# [$ra - $ra5]
######################################################################
.begin pretrace_diffuse_rays
pretrace_diffuse_rays.2980:
    bg      $i24, 4, ble_else.22277     # |     16,395 |     16,395 |
ble_then.22277:
    load    [$i23 + 2], $i25            # |     16,395 |     16,395 |
    load    [$i25 + $i24], $i1          # |     16,395 |     16,395 |
    bl      $i1, 0, bge_else.22278      # |     16,395 |     16,395 |
bge_then.22278:
    load    [$i23 + 3], $i26            # |      2,101 |      2,101 |
    load    [$i26 + $i24], $i1          # |      2,101 |      2,101 |
    bne     $i1, 0, be_else.22279       # |      2,101 |      2,101 |
be_then.22279:
    add     $i24, 1, $i24               # |         67 |         67 |
    bg      $i24, 4, ble_else.22280     # |         67 |         67 |
ble_then.22280:
    load    [$i25 + $i24], $i1          # |         67 |         67 |
    bl      $i1, 0, bge_else.22281      # |         67 |         67 |
bge_then.22281:
    load    [$i26 + $i24], $i1          # |         11 |         11 |
    bne     $i1, 0, be_else.22282       # |         11 |         11 |
be_then.22282:
    add     $i24, 1, $i24               # |          2 |          2 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |
be_else.22282:
    mov     $f0, $fg1                   # |          9 |          9 |
    mov     $f0, $fg2                   # |          9 |          9 |
    mov     $f0, $fg3                   # |          9 |          9 |
    load    [$i23 + 6], $i8             # |          9 |          9 |
    load    [$i23 + 7], $i9             # |          9 |          9 |
    load    [$i23 + 1], $i1             # |          9 |          9 |
    load    [$i1 + $i24], $i2           # |          9 |          9 |
    load    [$i2 + 0], $fg8             # |          9 |          9 |
    load    [$i2 + 1], $fg9             # |          9 |          9 |
    load    [$i2 + 2], $fg10            # |          9 |          9 |
    sub     $ig0, 1, $i1                # |          9 |          9 |
    call    setup_startp_constants.2831 # |          9 |          9 |
    load    [$i8 + 0], $i1              # |          9 |          9 |
    load    [ext_dirvecs + $i1], $i20   # |          9 |          9 |
    load    [$i20 + 118], $i1           # |          9 |          9 |
    load    [$i1 + 0], $i1              # |          9 |          9 |
    load    [$i9 + $i24], $i21          # |          9 |          9 |
    load    [$i1 + 0], $f1              # |          9 |          9 |
    load    [$i21 + 0], $f2             # |          9 |          9 |
    fmul    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 1], $f2              # |          9 |          9 |
    load    [$i21 + 1], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    load    [$i1 + 2], $f2              # |          9 |          9 |
    load    [$i21 + 2], $f3             # |          9 |          9 |
    fmul    $f2, $f3, $f2               # |          9 |          9 |
    fadd    $f1, $f2, $f1               # |          9 |          9 |
    bg      $f0, $f1, ble_else.22283    # |          9 |          9 |
ble_then.22283:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22283
ble_else.22283:
    fmul    $f1, $fc2, $f14             # |          9 |          9 |
    load    [$i20 + 119], $i19          # |          9 |          9 |
    jal     trace_diffuse_ray.2926, $ra4# |          9 |          9 |
    li      116, $i22                   # |          9 |          9 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |          9 |          9 |
ble_cont.22283:
    load    [$i23 + 5], $i1             # |          9 |          9 |
    load    [$i1 + $i24], $i1           # |          9 |          9 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |
    add     $i24, 1, $i24               # |          9 |          9 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |
bge_else.22281:
    jr      $ra6                        # |         56 |         56 |
ble_else.22280:
    jr      $ra6
be_else.22279:
    mov     $f0, $fg1                   # |      2,034 |      2,034 |
    mov     $f0, $fg2                   # |      2,034 |      2,034 |
    mov     $f0, $fg3                   # |      2,034 |      2,034 |
    load    [$i23 + 6], $i27            # |      2,034 |      2,034 |
    load    [$i23 + 7], $i28            # |      2,034 |      2,034 |
    load    [$i23 + 1], $i29            # |      2,034 |      2,034 |
    load    [$i29 + $i24], $i2          # |      2,034 |      2,034 |
    load    [$i2 + 0], $fg8             # |      2,034 |      2,034 |
    load    [$i2 + 1], $fg9             # |      2,034 |      2,034 |
    load    [$i2 + 2], $fg10            # |      2,034 |      2,034 |
    sub     $ig0, 1, $i1                # |      2,034 |      2,034 |
    call    setup_startp_constants.2831 # |      2,034 |      2,034 |
    load    [$i27 + 0], $i1             # |      2,034 |      2,034 |
    load    [ext_dirvecs + $i1], $i20   # |      2,034 |      2,034 |
    load    [$i20 + 118], $i1           # |      2,034 |      2,034 |
    load    [$i1 + 0], $i1              # |      2,034 |      2,034 |
    load    [$i1 + 0], $f1              # |      2,034 |      2,034 |
    load    [$i28 + $i24], $i21         # |      2,034 |      2,034 |
    load    [$i21 + 0], $f2             # |      2,034 |      2,034 |
    fmul    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 1], $f2              # |      2,034 |      2,034 |
    load    [$i21 + 1], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    load    [$i1 + 2], $f2              # |      2,034 |      2,034 |
    load    [$i21 + 2], $f3             # |      2,034 |      2,034 |
    fmul    $f2, $f3, $f2               # |      2,034 |      2,034 |
    fadd    $f1, $f2, $f1               # |      2,034 |      2,034 |
    bg      $f0, $f1, ble_else.22284    # |      2,034 |      2,034 |
ble_then.22284:
    load    [$i20 + 118], $i19          # |        293 |        293 |
    fmul    $f1, $fc1, $f14             # |        293 |        293 |
    jal     trace_diffuse_ray.2926, $ra4# |        293 |        293 |
.count b_cont
    b       ble_cont.22284              # |        293 |        293 |
ble_else.22284:
    load    [$i20 + 119], $i19          # |      1,741 |      1,741 |
    fmul    $f1, $fc2, $f14             # |      1,741 |      1,741 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,741 |      1,741 |
ble_cont.22284:
    li      116, $i22                   # |      2,034 |      2,034 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      2,034 |      2,034 |
    load    [$i23 + 5], $i30            # |      2,034 |      2,034 |
    load    [$i30 + $i24], $i1          # |      2,034 |      2,034 |
    store   $fg1, [$i1 + 0]             # |      2,034 |      2,034 |
    store   $fg2, [$i1 + 1]             # |      2,034 |      2,034 |
    store   $fg3, [$i1 + 2]             # |      2,034 |      2,034 |
    add     $i24, 1, $i24               # |      2,034 |      2,034 |
    bg      $i24, 4, ble_else.22285     # |      2,034 |      2,034 |
ble_then.22285:
    load    [$i25 + $i24], $i1          # |      2,034 |      2,034 |
    bl      $i1, 0, bge_else.22286      # |      2,034 |      2,034 |
bge_then.22286:
    load    [$i26 + $i24], $i1
    bne     $i1, 0, be_else.22287
be_then.22287:
    add     $i24, 1, $i24
    b       pretrace_diffuse_rays.2980
be_else.22287:
    mov     $f0, $fg1
    mov     $f0, $fg2
    mov     $f0, $fg3
    load    [$i29 + $i24], $i2
    load    [$i2 + 0], $fg8
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    sub     $ig0, 1, $i1
    call    setup_startp_constants.2831
    load    [$i27 + 0], $i1
    load    [ext_dirvecs + $i1], $i20
    load    [$i20 + 118], $i1
    load    [$i1 + 0], $i1
    load    [$i28 + $i24], $i21
    load    [$i1 + 0], $f1
    load    [$i21 + 0], $f2
    fmul    $f1, $f2, $f1
    load    [$i1 + 1], $f2
    load    [$i21 + 1], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 2], $f2
    load    [$i21 + 2], $f3
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $f1
    bg      $f0, $f1, ble_else.22288
ble_then.22288:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
.count b_cont
    b       ble_cont.22288
ble_else.22288:
    fmul    $f1, $fc2, $f14
    load    [$i20 + 119], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
ble_cont.22288:
    load    [$i30 + $i24], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i24, 1, $i24
    b       pretrace_diffuse_rays.2980
bge_else.22286:
    jr      $ra6                        # |      2,034 |      2,034 |
ble_else.22285:
    jr      $ra6
bge_else.22278:
    jr      $ra6                        # |     14,294 |     14,294 |
ble_else.22277:
    jr      $ra6
.end pretrace_diffuse_rays

######################################################################
# pretrace_pixels($i31, $i32, $i33, $f18, $f1, $f2)
# $ra = $ra7
# [$i1 - $i34]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra6]
######################################################################
.begin pretrace_pixels
pretrace_pixels.2983:
    bl      $i32, 0, bge_else.22289     # |     16,512 |     16,512 |
bge_then.22289:
.count stack_move
    sub     $sp, 2, $sp                 # |     16,384 |     16,384 |
.count stack_store
    store   $f2, [$sp + 0]              # |     16,384 |     16,384 |
.count stack_store
    store   $f1, [$sp + 1]              # |     16,384 |     16,384 |
    sub     $i32, 64, $i2               # |     16,384 |     16,384 |
    call    ext_float_of_int            # |     16,384 |     16,384 |
    load    [ext_screenx_dir + 0], $f2  # |     16,384 |     16,384 |
    fmul    $f1, $f2, $f2               # |     16,384 |     16,384 |
    fadd    $f2, $f18, $f2              # |     16,384 |     16,384 |
    store   $f2, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 1], $i34             # |     16,384 |     16,384 |
    store   $i34, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [ext_screenx_dir + 2], $f2  # |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
.count stack_load
    load    [$sp + 0], $f2              # |     16,384 |     16,384 |
    fadd    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 0], $f1# |     16,384 |     16,384 |
    fmul    $f1, $f1, $f2               # |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 1], $f3# |     16,384 |     16,384 |
    fmul    $f3, $f3, $f3               # |     16,384 |     16,384 |
    fadd    $f2, $f3, $f2               # |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 2], $f3# |     16,384 |     16,384 |
    fmul    $f3, $f3, $f3               # |     16,384 |     16,384 |
    fadd    $f2, $f3, $f2               # |     16,384 |     16,384 |
    fsqrt   $f2, $f2                    # |     16,384 |     16,384 |
    bne     $f2, $f0, be_else.22290     # |     16,384 |     16,384 |
be_then.22290:
    mov     $fc0, $f2
.count b_cont
    b       be_cont.22290
be_else.22290:
    finv    $f2, $f2                    # |     16,384 |     16,384 |
be_cont.22290:
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 1], $f1# |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 2], $f1# |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |
    mov     $f0, $fg4                   # |     16,384 |     16,384 |
    mov     $f0, $fg5                   # |     16,384 |     16,384 |
    mov     $f0, $fg6                   # |     16,384 |     16,384 |
    load    [ext_viewpoint + 0], $fg17  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 1], $fg18  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 2], $fg19  # |     16,384 |     16,384 |
    li      ext_ptrace_dirvec, $i24     # |     16,384 |     16,384 |
    li      0, $i23                     # |     16,384 |     16,384 |
    load    [$i31 + $i32], $i25         # |     16,384 |     16,384 |
.count move_args
    mov     $fc0, $f16                  # |     16,384 |     16,384 |
.count move_args
    mov     $f0, $f17                   # |     16,384 |     16,384 |
    jal     trace_ray.2920, $ra5        # |     16,384 |     16,384 |
    load    [$i31 + $i32], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    store   $fg4, [$i1 + 0]             # |     16,384 |     16,384 |
    store   $fg5, [$i1 + 1]             # |     16,384 |     16,384 |
    store   $fg6, [$i1 + 2]             # |     16,384 |     16,384 |
    load    [$i31 + $i32], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 6], $i1              # |     16,384 |     16,384 |
    store   $i33, [$i1 + 0]             # |     16,384 |     16,384 |
    load    [$i31 + $i32], $i23         # |     16,384 |     16,384 |
    load    [$i23 + 2], $i1             # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    bl      $i1, 0, bge_cont.22291      # |     16,384 |     16,384 |
bge_then.22291:
    load    [$i23 + 3], $i1             # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    bne     $i1, 0, be_else.22292       # |     16,384 |     16,384 |
be_then.22292:
    li      1, $i24                     # |      7,301 |      7,301 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      7,301 |      7,301 |
.count b_cont
    b       be_cont.22292               # |      7,301 |      7,301 |
be_else.22292:
    load    [$i23 + 6], $i1             # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    mov     $f0, $fg1                   # |      9,083 |      9,083 |
    mov     $f0, $fg2                   # |      9,083 |      9,083 |
    mov     $f0, $fg3                   # |      9,083 |      9,083 |
    load    [$i23 + 7], $i2             # |      9,083 |      9,083 |
    load    [$i23 + 1], $i3             # |      9,083 |      9,083 |
    load    [ext_dirvecs + $i1], $i20   # |      9,083 |      9,083 |
    load    [$i2 + 0], $i21             # |      9,083 |      9,083 |
    load    [$i3 + 0], $i2              # |      9,083 |      9,083 |
    load    [$i2 + 0], $fg8             # |      9,083 |      9,083 |
    load    [$i2 + 1], $fg9             # |      9,083 |      9,083 |
    load    [$i2 + 2], $fg10            # |      9,083 |      9,083 |
    sub     $ig0, 1, $i1                # |      9,083 |      9,083 |
    call    setup_startp_constants.2831 # |      9,083 |      9,083 |
    load    [$i20 + 118], $i1           # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    load    [$i1 + 0], $f1              # |      9,083 |      9,083 |
    load    [$i21 + 0], $f2             # |      9,083 |      9,083 |
    fmul    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 1], $f2              # |      9,083 |      9,083 |
    load    [$i21 + 1], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    load    [$i1 + 2], $f2              # |      9,083 |      9,083 |
    load    [$i21 + 2], $f3             # |      9,083 |      9,083 |
    fmul    $f2, $f3, $f2               # |      9,083 |      9,083 |
    fadd    $f1, $f2, $f1               # |      9,083 |      9,083 |
    bg      $f0, $f1, ble_else.22293    # |      9,083 |      9,083 |
ble_then.22293:
    fmul    $f1, $fc1, $f14             # |         14 |         14 |
    load    [$i20 + 118], $i19          # |         14 |         14 |
    jal     trace_diffuse_ray.2926, $ra4# |         14 |         14 |
    li      116, $i22                   # |         14 |         14 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         14 |         14 |
.count b_cont
    b       ble_cont.22293              # |         14 |         14 |
ble_else.22293:
    fmul    $f1, $fc2, $f14             # |      9,069 |      9,069 |
    load    [$i20 + 119], $i19          # |      9,069 |      9,069 |
    jal     trace_diffuse_ray.2926, $ra4# |      9,069 |      9,069 |
    li      116, $i22                   # |      9,069 |      9,069 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      9,069 |      9,069 |
ble_cont.22293:
    load    [$i23 + 5], $i1             # |      9,083 |      9,083 |
    load    [$i1 + 0], $i1              # |      9,083 |      9,083 |
    store   $fg1, [$i1 + 0]             # |      9,083 |      9,083 |
    store   $fg2, [$i1 + 1]             # |      9,083 |      9,083 |
    store   $fg3, [$i1 + 2]             # |      9,083 |      9,083 |
    li      1, $i24                     # |      9,083 |      9,083 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      9,083 |      9,083 |
be_cont.22292:
bge_cont.22291:
.count stack_move
    add     $sp, 2, $sp                 # |     16,384 |     16,384 |
    sub     $i32, 1, $i32               # |     16,384 |     16,384 |
    add     $i33, 1, $i33               # |     16,384 |     16,384 |
.count move_args
    mov     $i34, $f1                   # |     16,384 |     16,384 |
.count stack_load
    load    [$sp - 2], $f2              # |     16,384 |     16,384 |
    bl      $i33, 5, pretrace_pixels.2983# |     16,384 |     16,384 |
    sub     $i33, 5, $i33               # |      3,277 |      3,277 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |
bge_else.22289:
    jr      $ra7                        # |        128 |        128 |
.end pretrace_pixels

######################################################################
# scan_pixel($i30, $i31, $i32, $i33, $i34)
# $ra = $ra8
# [$i1 - $i34]
# [$f1 - $f14]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg16]
# [$ra - $ra7]
######################################################################
.begin scan_pixel
scan_pixel.2994:
    li      128, $i1                    # |     16,512 |     16,512 |
    bg      $i1, $i30, ble_else.22295   # |     16,512 |     16,512 |
ble_then.22295:
    jr      $ra8                        # |        128 |        128 |
ble_else.22295:
    load    [$i33 + $i30], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    load    [$i1 + 0], $fg4             # |     16,384 |     16,384 |
    load    [$i1 + 1], $fg5             # |     16,384 |     16,384 |
    load    [$i1 + 2], $fg6             # |     16,384 |     16,384 |
    li      128, $i1                    # |     16,384 |     16,384 |
    add     $i31, 1, $i2                # |     16,384 |     16,384 |
    bg      $i1, $i2, ble_else.22296    # |     16,384 |     16,384 |
ble_then.22296:
    li      0, $i1                      # |        128 |        128 |
.count b_cont
    b       ble_cont.22296              # |        128 |        128 |
ble_else.22296:
    bg      $i31, 0, ble_else.22297     # |     16,256 |     16,256 |
ble_then.22297:
    li      0, $i1                      # |        128 |        128 |
.count b_cont
    b       ble_cont.22297              # |        128 |        128 |
ble_else.22297:
    li      128, $i1                    # |     16,128 |     16,128 |
    add     $i30, 1, $i2                # |     16,128 |     16,128 |
    bg      $i1, $i2, ble_else.22298    # |     16,128 |     16,128 |
ble_then.22298:
    li      0, $i1                      # |        126 |        126 |
.count b_cont
    b       ble_cont.22298              # |        126 |        126 |
ble_else.22298:
    bg      $i30, 0, ble_else.22299     # |     16,002 |     16,002 |
ble_then.22299:
    li      0, $i1                      # |        126 |        126 |
.count b_cont
    b       ble_cont.22299              # |        126 |        126 |
ble_else.22299:
    li      1, $i1                      # |     15,876 |     15,876 |
ble_cont.22299:
ble_cont.22298:
ble_cont.22297:
ble_cont.22296:
    li      0, $i24                     # |     16,384 |     16,384 |
    bne     $i1, 0, be_else.22300       # |     16,384 |     16,384 |
be_then.22300:
    load    [$i33 + $i30], $i28         # |        508 |        508 |
    load    [$i28 + 2], $i1             # |        508 |        508 |
    load    [$i1 + 0], $i1              # |        508 |        508 |
    bl      $i1, 0, be_cont.22300       # |        508 |        508 |
bge_then.22301:
    load    [$i28 + 3], $i1             # |        508 |        508 |
    load    [$i1 + 0], $i1              # |        508 |        508 |
    bne     $i1, 0, be_else.22302       # |        508 |        508 |
be_then.22302:
    li      1, $i23                     # |        360 |        360 |
    jal     do_without_neighbors.2951, $ra7# |        360 |        360 |
.count b_cont
    b       be_cont.22300               # |        360 |        360 |
be_else.22302:
.count move_args
    mov     $i28, $i23                  # |        148 |        148 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        148 |        148 |
    li      1, $i23                     # |        148 |        148 |
    jal     do_without_neighbors.2951, $ra7# |        148 |        148 |
.count b_cont
    b       be_cont.22300               # |        148 |        148 |
be_else.22300:
    load    [$i33 + $i30], $i1          # |     15,876 |     15,876 |
    load    [$i1 + 2], $i2              # |     15,876 |     15,876 |
    load    [$i2 + 0], $i2              # |     15,876 |     15,876 |
    bl      $i2, 0, bge_cont.22303      # |     15,876 |     15,876 |
bge_then.22303:
    load    [$i32 + $i30], $i3          # |     15,876 |     15,876 |
    load    [$i3 + 2], $i4              # |     15,876 |     15,876 |
    load    [$i4 + 0], $i4              # |     15,876 |     15,876 |
    bne     $i4, $i2, be_else.22304     # |     15,876 |     15,876 |
be_then.22304:
    load    [$i34 + $i30], $i4          # |     15,253 |     15,253 |
    load    [$i4 + 2], $i4              # |     15,253 |     15,253 |
    load    [$i4 + 0], $i4              # |     15,253 |     15,253 |
    bne     $i4, $i2, be_else.22305     # |     15,253 |     15,253 |
be_then.22305:
    sub     $i30, 1, $i4                # |     14,657 |     14,657 |
    load    [$i33 + $i4], $i4           # |     14,657 |     14,657 |
    load    [$i4 + 2], $i4              # |     14,657 |     14,657 |
    load    [$i4 + 0], $i4              # |     14,657 |     14,657 |
    bne     $i4, $i2, be_else.22306     # |     14,657 |     14,657 |
be_then.22306:
    add     $i30, 1, $i4                # |     14,497 |     14,497 |
    load    [$i33 + $i4], $i4           # |     14,497 |     14,497 |
    load    [$i4 + 2], $i4              # |     14,497 |     14,497 |
    load    [$i4 + 0], $i4              # |     14,497 |     14,497 |
    bne     $i4, $i2, be_else.22307     # |     14,497 |     14,497 |
be_then.22307:
    li      1, $i2                      # |     14,333 |     14,333 |
.count b_cont
    b       be_cont.22304               # |     14,333 |     14,333 |
be_else.22307:
    li      0, $i2                      # |        164 |        164 |
.count b_cont
    b       be_cont.22304               # |        164 |        164 |
be_else.22306:
    li      0, $i2                      # |        160 |        160 |
.count b_cont
    b       be_cont.22304               # |        160 |        160 |
be_else.22305:
    li      0, $i2                      # |        596 |        596 |
.count b_cont
    b       be_cont.22304               # |        596 |        596 |
be_else.22304:
    li      0, $i2                      # |        623 |        623 |
be_cont.22304:
    bne     $i2, 0, be_else.22308       # |     15,876 |     15,876 |
be_then.22308:
    load    [$i33 + $i30], $i28         # |      1,543 |      1,543 |
    load    [$i28 + 2], $i1             # |      1,543 |      1,543 |
    load    [$i1 + 0], $i1              # |      1,543 |      1,543 |
    bl      $i1, 0, be_cont.22308       # |      1,543 |      1,543 |
bge_then.22309:
    load    [$i28 + 3], $i1             # |      1,543 |      1,543 |
    load    [$i1 + 0], $i1              # |      1,543 |      1,543 |
    bne     $i1, 0, be_else.22310       # |      1,543 |      1,543 |
be_then.22310:
    li      1, $i23                     # |        301 |        301 |
    jal     do_without_neighbors.2951, $ra7# |        301 |        301 |
.count b_cont
    b       be_cont.22308               # |        301 |        301 |
be_else.22310:
.count move_args
    mov     $i28, $i23                  # |      1,242 |      1,242 |
    jal     calc_diffuse_using_1point.2942, $ra6# |      1,242 |      1,242 |
    li      1, $i23                     # |      1,242 |      1,242 |
    jal     do_without_neighbors.2951, $ra7# |      1,242 |      1,242 |
.count b_cont
    b       be_cont.22308               # |      1,242 |      1,242 |
be_else.22308:
    load    [$i1 + 3], $i1              # |     14,333 |     14,333 |
    load    [$i1 + 0], $i1              # |     14,333 |     14,333 |
.count move_args
    mov     $i34, $i5                   # |     14,333 |     14,333 |
.count move_args
    mov     $i33, $i4                   # |     14,333 |     14,333 |
.count move_args
    mov     $i30, $i2                   # |     14,333 |     14,333 |
    li      1, $i28                     # |     14,333 |     14,333 |
    bne     $i1, 0, be_else.22311       # |     14,333 |     14,333 |
be_then.22311:
.count move_args
    mov     $i32, $i3                   # |      6,640 |      6,640 |
    jal     try_exploit_neighbors.2967, $ra7# |      6,640 |      6,640 |
.count b_cont
    b       be_cont.22311               # |      6,640 |      6,640 |
be_else.22311:
    load    [$i3 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $fg3             # |      7,693 |      7,693 |
    sub     $i30, 1, $i1                # |      7,693 |      7,693 |
    load    [$i33 + $i1], $i1           # |      7,693 |      7,693 |
    load    [$i1 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i33 + $i30], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    add     $i30, 1, $i1                # |      7,693 |      7,693 |
    load    [$i33 + $i1], $i1           # |      7,693 |      7,693 |
    load    [$i1 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i34 + $i30], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fadd    $fg1, $f1, $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fadd    $fg2, $f1, $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fadd    $fg3, $f1, $fg3             # |      7,693 |      7,693 |
    load    [$i33 + $i30], $i1          # |      7,693 |      7,693 |
    load    [$i1 + 4], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $f1              # |      7,693 |      7,693 |
    fmul    $f1, $fg1, $f1              # |      7,693 |      7,693 |
    fadd    $fg4, $f1, $fg4             # |      7,693 |      7,693 |
    load    [$i1 + 1], $f1              # |      7,693 |      7,693 |
    fmul    $f1, $fg2, $f1              # |      7,693 |      7,693 |
    fadd    $fg5, $f1, $fg5             # |      7,693 |      7,693 |
    load    [$i1 + 2], $f1              # |      7,693 |      7,693 |
    fmul    $f1, $fg3, $f1              # |      7,693 |      7,693 |
    fadd    $fg6, $f1, $fg6             # |      7,693 |      7,693 |
.count move_args
    mov     $i32, $i3                   # |      7,693 |      7,693 |
    jal     try_exploit_neighbors.2967, $ra7# |      7,693 |      7,693 |
be_cont.22311:
be_cont.22308:
bge_cont.22303:
be_cont.22300:
    call    write_rgb.2978              # |     16,384 |     16,384 |
    add     $i30, 1, $i30               # |     16,384 |     16,384 |
    b       scan_pixel.2994             # |     16,384 |     16,384 |
.end scan_pixel

######################################################################
# scan_line($i35, $i36, $i37, $i38, $i39)
# $ra = $ra9
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig2 - $ig3]
# [$fg0 - $fg11, $fg15 - $fg19]
# [$ra - $ra8]
######################################################################
.begin scan_line
scan_line.3000:
    li      128, $i1                    # |        129 |        129 |
    bg      $i1, $i35, ble_else.22312   # |        129 |        129 |
ble_then.22312:
    jr      $ra9                        # |          1 |          1 |
ble_else.22312:
    bge     $i35, 127, bl_cont.22313    # |        128 |        128 |
bl_then.22313:
    add     $i35, 1, $i1                # |        127 |        127 |
    sub     $i1, 64, $i2                # |        127 |        127 |
    call    ext_float_of_int            # |        127 |        127 |
    fmul    $f1, $fg23, $f2             # |        127 |        127 |
    fadd    $f2, $fg20, $f18            # |        127 |        127 |
    fmul    $f1, $fg24, $f2             # |        127 |        127 |
    fadd    $f2, $fg21, $f3             # |        127 |        127 |
    load    [ext_screeny_dir + 2], $f2  # |        127 |        127 |
    fmul    $f1, $f2, $f1               # |        127 |        127 |
    fadd    $f1, $fg22, $f2             # |        127 |        127 |
    li      127, $i32                   # |        127 |        127 |
.count move_args
    mov     $i38, $i31                  # |        127 |        127 |
.count move_args
    mov     $i39, $i33                  # |        127 |        127 |
.count move_args
    mov     $f3, $f1                    # |        127 |        127 |
    jal     pretrace_pixels.2983, $ra7  # |        127 |        127 |
bl_cont.22313:
    li      0, $i30                     # |        128 |        128 |
.count move_args
    mov     $i35, $i31                  # |        128 |        128 |
.count move_args
    mov     $i36, $i32                  # |        128 |        128 |
.count move_args
    mov     $i37, $i33                  # |        128 |        128 |
.count move_args
    mov     $i38, $i34                  # |        128 |        128 |
    jal     scan_pixel.2994, $ra8       # |        128 |        128 |
    add     $i35, 1, $i35               # |        128 |        128 |
    add     $i39, 2, $i39               # |        128 |        128 |
.count move_args
    mov     $i36, $tmp                  # |        128 |        128 |
.count move_args
    mov     $i37, $i36                  # |        128 |        128 |
.count move_args
    mov     $i38, $i37                  # |        128 |        128 |
.count move_args
    mov     $tmp, $i38                  # |        128 |        128 |
    bl      $i39, 5, scan_line.3000     # |        128 |        128 |
    sub     $i39, 5, $i39               # |         51 |         51 |
    b       scan_line.3000              # |         51 |         51 |
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
.begin create_float5x3array
create_float5x3array.3006:
    li      3, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |
    call    ext_create_array_float      # |      1,536 |      1,536 |
    li      5, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $i1, $i3                    # |      1,536 |      1,536 |
    call    ext_create_array_int        # |      1,536 |      1,536 |
.count move_ret
    mov     $i1, $i4                    # |      1,536 |      1,536 |
    li      3, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |
    call    ext_create_array_float      # |      1,536 |      1,536 |
    store   $i1, [$i4 + 1]              # |      1,536 |      1,536 |
    li      3, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |
    call    ext_create_array_float      # |      1,536 |      1,536 |
    store   $i1, [$i4 + 2]              # |      1,536 |      1,536 |
    li      3, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |
    call    ext_create_array_float      # |      1,536 |      1,536 |
    store   $i1, [$i4 + 3]              # |      1,536 |      1,536 |
    li      3, $i2                      # |      1,536 |      1,536 |
.count move_args
    mov     $f0, $f2                    # |      1,536 |      1,536 |
    call    ext_create_array_float      # |      1,536 |      1,536 |
    store   $i1, [$i4 + 4]              # |      1,536 |      1,536 |
    mov     $i4, $i1                    # |      1,536 |      1,536 |
    jr      $ra1                        # |      1,536 |      1,536 |
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
.begin create_pixel
create_pixel.3008:
    li      3, $i2                      # |        384 |        384 |
.count move_args
    mov     $f0, $f2                    # |        384 |        384 |
    call    ext_create_array_float      # |        384 |        384 |
.count move_ret
    mov     $i1, $i5                    # |        384 |        384 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |
.count move_ret
    mov     $i1, $i6                    # |        384 |        384 |
    li      5, $i2                      # |        384 |        384 |
    li      0, $i3                      # |        384 |        384 |
    call    ext_create_array_int        # |        384 |        384 |
.count move_ret
    mov     $i1, $i7                    # |        384 |        384 |
    li      5, $i2                      # |        384 |        384 |
    li      0, $i3                      # |        384 |        384 |
    call    ext_create_array_int        # |        384 |        384 |
.count move_ret
    mov     $i1, $i8                    # |        384 |        384 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |
.count move_ret
    mov     $i1, $i9                    # |        384 |        384 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |
.count move_ret
    mov     $i1, $i10                   # |        384 |        384 |
    li      1, $i2                      # |        384 |        384 |
    li      0, $i3                      # |        384 |        384 |
    call    ext_create_array_int        # |        384 |        384 |
.count move_ret
    mov     $i1, $i11                   # |        384 |        384 |
    jal     create_float5x3array.3006, $ra1# |        384 |        384 |
    mov     $hp, $i2                    # |        384 |        384 |
    add     $hp, 8, $hp                 # |        384 |        384 |
    store   $i1, [$i2 + 7]              # |        384 |        384 |
    store   $i11, [$i2 + 6]             # |        384 |        384 |
    store   $i10, [$i2 + 5]             # |        384 |        384 |
    store   $i9, [$i2 + 4]              # |        384 |        384 |
    store   $i8, [$i2 + 3]              # |        384 |        384 |
    store   $i7, [$i2 + 2]              # |        384 |        384 |
    store   $i6, [$i2 + 1]              # |        384 |        384 |
    store   $i5, [$i2 + 0]              # |        384 |        384 |
    mov     $i2, $i1                    # |        384 |        384 |
    jr      $ra2                        # |        384 |        384 |
.end create_pixel

######################################################################
# $i1 = init_line_elements($i12, $i13)
# $ra = $ra3
# [$i1 - $i13]
# [$f2]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_line_elements
init_line_elements.3010:
    bl      $i13, 0, bge_else.22315     # |        384 |        384 |
bge_then.22315:
    jal     create_pixel.3008, $ra2     # |        381 |        381 |
.count storer
    add     $i12, $i13, $tmp            # |        381 |        381 |
    store   $i1, [$tmp + 0]             # |        381 |        381 |
    sub     $i13, 1, $i13               # |        381 |        381 |
    b       init_line_elements.3010     # |        381 |        381 |
bge_else.22315:
    mov     $i12, $i1                   # |          3 |          3 |
    jr      $ra3                        # |          3 |          3 |
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
.begin create_pixelline
create_pixelline.3013:
    jal     create_pixel.3008, $ra2     # |          3 |          3 |
    li      128, $i2                    # |          3 |          3 |
.count move_args
    mov     $i1, $i3                    # |          3 |          3 |
    call    ext_create_array_int        # |          3 |          3 |
    li      126, $i13                   # |          3 |          3 |
.count move_args
    mov     $i1, $i12                   # |          3 |          3 |
    b       init_line_elements.3010     # |          3 |          3 |
.end create_pixelline

######################################################################
# calc_dirvec($i1, $f1, $f2, $f9, $f10, $i3, $i4)
# $ra = $ra1
# [$i1 - $i4]
# [$f1 - $f13]
# []
# []
# [$ra]
######################################################################
.begin calc_dirvec
calc_dirvec.3020:
    bl      $i1, 5, bge_else.22316      # |        600 |        600 |
bge_then.22316:
    load    [ext_dirvecs + $i3], $i1    # |        100 |        100 |
    load    [$i1 + $i4], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    fmul    $f1, $f1, $f3               # |        100 |        100 |
    fmul    $f2, $f2, $f4               # |        100 |        100 |
    fadd    $f3, $f4, $f3               # |        100 |        100 |
    fadd    $f3, $fc0, $f3              # |        100 |        100 |
    fsqrt   $f3, $f3                    # |        100 |        100 |
    finv    $f3, $f3                    # |        100 |        100 |
    fmul    $f1, $f3, $f1               # |        100 |        100 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |
    fmul    $f2, $f3, $f2               # |        100 |        100 |
    store   $f2, [$i2 + 1]              # |        100 |        100 |
    store   $f3, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 40, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f1, [$i2 + 0]              # |        100 |        100 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |
    fneg    $f2, $f4                    # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 80, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f3, [$i2 + 0]              # |        100 |        100 |
    fneg    $f1, $f5                    # |        100 |        100 |
    store   $f5, [$i2 + 1]              # |        100 |        100 |
    store   $f4, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 1, $i2                 # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f4, [$i2 + 1]              # |        100 |        100 |
    fneg    $f3, $f3                    # |        100 |        100 |
    store   $f3, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 41, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i2            # |        100 |        100 |
    load    [$i2 + 0], $i2              # |        100 |        100 |
    store   $f5, [$i2 + 0]              # |        100 |        100 |
    store   $f3, [$i2 + 1]              # |        100 |        100 |
    store   $f2, [$i2 + 2]              # |        100 |        100 |
    add     $i4, 81, $i2                # |        100 |        100 |
    load    [$i1 + $i2], $i1            # |        100 |        100 |
    load    [$i1 + 0], $i1              # |        100 |        100 |
    store   $f3, [$i1 + 0]              # |        100 |        100 |
    store   $f1, [$i1 + 1]              # |        100 |        100 |
    store   $f2, [$i1 + 2]              # |        100 |        100 |
    jr      $ra1                        # |        100 |        100 |
bge_else.22316:
    fmul    $f2, $f2, $f1               # |        500 |        500 |
    fadd    $f1, $fc9, $f1              # |        500 |        500 |
    fsqrt   $f1, $f11                   # |        500 |        500 |
    finv    $f11, $f2                   # |        500 |        500 |
    call    ext_atan                    # |        500 |        500 |
    fmul    $f1, $f9, $f8               # |        500 |        500 |
.count move_args
    mov     $f8, $f2                    # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count move_ret
    mov     $f1, $f12                   # |        500 |        500 |
.count move_args
    mov     $f8, $f2                    # |        500 |        500 |
    call    ext_cos                     # |        500 |        500 |
    finv    $f1, $f1                    # |        500 |        500 |
    fmul    $f12, $f1, $f1              # |        500 |        500 |
    fmul    $f1, $f11, $f11             # |        500 |        500 |
    fmul    $f11, $f11, $f1             # |        500 |        500 |
    fadd    $f1, $fc9, $f1              # |        500 |        500 |
    fsqrt   $f1, $f12                   # |        500 |        500 |
    finv    $f12, $f2                   # |        500 |        500 |
    call    ext_atan                    # |        500 |        500 |
    fmul    $f1, $f10, $f8              # |        500 |        500 |
.count move_args
    mov     $f8, $f2                    # |        500 |        500 |
    call    ext_sin                     # |        500 |        500 |
.count move_ret
    mov     $f1, $f13                   # |        500 |        500 |
.count move_args
    mov     $f8, $f2                    # |        500 |        500 |
    call    ext_cos                     # |        500 |        500 |
    finv    $f1, $f1                    # |        500 |        500 |
    fmul    $f13, $f1, $f1              # |        500 |        500 |
    fmul    $f1, $f12, $f2              # |        500 |        500 |
    add     $i1, 1, $i1                 # |        500 |        500 |
.count move_args
    mov     $f11, $f1                   # |        500 |        500 |
    b       calc_dirvec.3020            # |        500 |        500 |
.end calc_dirvec

######################################################################
# calc_dirvecs($i5, $f14, $i6, $i7)
# $ra = $ra2
# [$i1 - $i8]
# [$f1 - $f16]
# []
# []
# [$ra - $ra1]
######################################################################
.begin calc_dirvecs
calc_dirvecs.3028:
    bl      $i5, 0, bge_else.22317      # |         10 |         10 |
bge_then.22317:
    li      0, $i1                      # |         10 |         10 |
.count move_args
    mov     $i5, $i2                    # |         10 |         10 |
    call    ext_float_of_int            # |         10 |         10 |
.count load_float
    load    [f.21560], $f15             # |         10 |         10 |
    fmul    $f1, $f15, $f16             # |         10 |         10 |
    fsub    $f16, $fc11, $f9            # |         10 |         10 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f14, $f10                  # |         10 |         10 |
.count move_args
    mov     $i6, $i3                    # |         10 |         10 |
.count move_args
    mov     $i7, $i4                    # |         10 |         10 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |
    li      0, $i1                      # |         10 |         10 |
    add     $i7, 2, $i8                 # |         10 |         10 |
    fadd    $f16, $fc9, $f9             # |         10 |         10 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f14, $f10                  # |         10 |         10 |
.count move_args
    mov     $i6, $i3                    # |         10 |         10 |
.count move_args
    mov     $i8, $i4                    # |         10 |         10 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |
    sub     $i5, 1, $i5                 # |         10 |         10 |
    bl      $i5, 0, bge_else.22318      # |         10 |         10 |
bge_then.22318:
    li      0, $i1                      # |         10 |         10 |
    add     $i6, 1, $i2                 # |         10 |         10 |
    bl      $i2, 5, bge_else.22319      # |         10 |         10 |
bge_then.22319:
    sub     $i2, 5, $i6                 # |          2 |          2 |
.count b_cont
    b       bge_cont.22319              # |          2 |          2 |
bge_else.22319:
    mov     $i2, $i6                    # |          8 |          8 |
bge_cont.22319:
.count move_args
    mov     $i5, $i2                    # |         10 |         10 |
    call    ext_float_of_int            # |         10 |         10 |
    fmul    $f1, $f15, $f16             # |         10 |         10 |
    fsub    $f16, $fc11, $f9            # |         10 |         10 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f14, $f10                  # |         10 |         10 |
.count move_args
    mov     $i6, $i3                    # |         10 |         10 |
.count move_args
    mov     $i7, $i4                    # |         10 |         10 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |
    li      0, $i1                      # |         10 |         10 |
    fadd    $f16, $fc9, $f9             # |         10 |         10 |
.count move_args
    mov     $f0, $f1                    # |         10 |         10 |
.count move_args
    mov     $f0, $f2                    # |         10 |         10 |
.count move_args
    mov     $f14, $f10                  # |         10 |         10 |
.count move_args
    mov     $i6, $i3                    # |         10 |         10 |
.count move_args
    mov     $i8, $i4                    # |         10 |         10 |
    jal     calc_dirvec.3020, $ra1      # |         10 |         10 |
    sub     $i5, 1, $i5                 # |         10 |         10 |
    bl      $i5, 0, bge_else.22320      # |         10 |         10 |
bge_then.22320:
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bge_else.22321      # |          5 |          5 |
bge_then.22321:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22321              # |          1 |          1 |
bge_else.22321:
    mov     $i2, $i6                    # |          4 |          4 |
bge_cont.22321:
.count move_args
    mov     $i5, $i2                    # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
    fmul    $f1, $f15, $f16             # |          5 |          5 |
    fsub    $f16, $fc11, $f9            # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i7, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    fadd    $f16, $fc9, $f9             # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i8, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    sub     $i5, 1, $i5                 # |          5 |          5 |
    bl      $i5, 0, bge_else.22322      # |          5 |          5 |
bge_then.22322:
    li      0, $i1
    add     $i6, 1, $i2
    bl      $i2, 5, bge_else.22323
bge_then.22323:
    sub     $i2, 5, $i6
.count b_cont
    b       bge_cont.22323
bge_else.22323:
    mov     $i2, $i6
bge_cont.22323:
.count move_args
    mov     $i5, $i2
    call    ext_float_of_int
    fmul    $f1, $f15, $f15
    fsub    $f15, $fc11, $f9
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $f14, $f10
.count move_args
    mov     $i6, $i3
.count move_args
    mov     $i7, $i4
    jal     calc_dirvec.3020, $ra1
    li      0, $i1
    fadd    $f15, $fc9, $f9
.count move_args
    mov     $f0, $f1
.count move_args
    mov     $f0, $f2
.count move_args
    mov     $f14, $f10
.count move_args
    mov     $i6, $i3
.count move_args
    mov     $i8, $i4
    jal     calc_dirvec.3020, $ra1
    sub     $i5, 1, $i5
    add     $i6, 1, $i6
    bl      $i6, 5, calc_dirvecs.3028
    sub     $i6, 5, $i6
    b       calc_dirvecs.3028
bge_else.22322:
    jr      $ra2                        # |          5 |          5 |
bge_else.22320:
    jr      $ra2                        # |          5 |          5 |
bge_else.22318:
    jr      $ra2
bge_else.22317:
    jr      $ra2
.end calc_dirvecs

######################################################################
# calc_dirvec_rows($i9, $i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f17]
# []
# []
# [$ra - $ra2]
######################################################################
.begin calc_dirvec_rows
calc_dirvec_rows.3033:
    bl      $i9, 0, bge_else.22325      # |          5 |          5 |
bge_then.22325:
    li      0, $i1                      # |          5 |          5 |
.count move_args
    mov     $i9, $i2                    # |          5 |          5 |
    call    ext_float_of_int            # |          5 |          5 |
.count load_float
    load    [f.21560], $f17             # |          5 |          5 |
    fmul    $f1, $f17, $f1              # |          5 |          5 |
    fsub    $f1, $fc11, $f14            # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $fc19, $f9                  # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i10, $i3                   # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i11, 2, $i5                # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $fc11, $f9                  # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i10, $i3                   # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i10, 1, $i2                # |          5 |          5 |
    bl      $i2, 5, bge_else.22326      # |          5 |          5 |
bge_then.22326:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22326              # |          1 |          1 |
bge_else.22326:
    mov     $i2, $i6                    # |          4 |          4 |
bge_cont.22326:
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $fc18, $f9                  # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $fc17, $f9                  # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bge_else.22327      # |          5 |          5 |
bge_then.22327:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22327              # |          1 |          1 |
bge_else.22327:
    mov     $i2, $i6                    # |          4 |          4 |
bge_cont.22327:
.count load_float
    load    [f.21565], $f9              # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      0, $i1                      # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $fc4, $f9                   # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $i6, $i3                    # |          5 |          5 |
.count move_args
    mov     $i5, $i4                    # |          5 |          5 |
    jal     calc_dirvec.3020, $ra1      # |          5 |          5 |
    li      1, $i5                      # |          5 |          5 |
    add     $i6, 1, $i1                 # |          5 |          5 |
    bl      $i1, 5, bge_else.22328      # |          5 |          5 |
bge_then.22328:
    sub     $i1, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22328              # |          1 |          1 |
bge_else.22328:
    mov     $i1, $i6                    # |          4 |          4 |
bge_cont.22328:
.count move_args
    mov     $i11, $i7                   # |          5 |          5 |
    jal     calc_dirvecs.3028, $ra2     # |          5 |          5 |
    sub     $i9, 1, $i9                 # |          5 |          5 |
    bl      $i9, 0, bge_else.22329      # |          5 |          5 |
bge_then.22329:
    add     $i10, 2, $i1                # |          4 |          4 |
    bl      $i1, 5, bge_else.22330      # |          4 |          4 |
bge_then.22330:
    sub     $i1, 5, $i10                # |          1 |          1 |
.count b_cont
    b       bge_cont.22330              # |          1 |          1 |
bge_else.22330:
    mov     $i1, $i10                   # |          3 |          3 |
bge_cont.22330:
    add     $i11, 4, $i11               # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count move_args
    mov     $i9, $i2                    # |          4 |          4 |
    call    ext_float_of_int            # |          4 |          4 |
    fmul    $f1, $f17, $f1              # |          4 |          4 |
    fsub    $f1, $fc11, $f14            # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $fc19, $f9                  # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i10, $i3                   # |          4 |          4 |
.count move_args
    mov     $i11, $i4                   # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    add     $i11, 2, $i5                # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $fc11, $f9                  # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i10, $i3                   # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    add     $i10, 1, $i2                # |          4 |          4 |
    bl      $i2, 5, bge_else.22331      # |          4 |          4 |
bge_then.22331:
    sub     $i2, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22331              # |          1 |          1 |
bge_else.22331:
    mov     $i2, $i6                    # |          3 |          3 |
bge_cont.22331:
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $fc18, $f9                  # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i11, $i4                   # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $fc17, $f9                  # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      2, $i5                      # |          4 |          4 |
    add     $i6, 1, $i1                 # |          4 |          4 |
    bl      $i1, 5, bge_else.22332      # |          4 |          4 |
bge_then.22332:
    sub     $i1, 5, $i6                 # |          1 |          1 |
.count b_cont
    b       bge_cont.22332              # |          1 |          1 |
bge_else.22332:
    mov     $i1, $i6                    # |          3 |          3 |
bge_cont.22332:
.count move_args
    mov     $i11, $i7                   # |          4 |          4 |
    jal     calc_dirvecs.3028, $ra2     # |          4 |          4 |
    sub     $i9, 1, $i9                 # |          4 |          4 |
    add     $i10, 2, $i10               # |          4 |          4 |
    add     $i11, 4, $i11               # |          4 |          4 |
    bl      $i10, 5, calc_dirvec_rows.3033# |          4 |          4 |
    sub     $i10, 5, $i10               # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bge_else.22329:
    jr      $ra3                        # |          1 |          1 |
bge_else.22325:
    jr      $ra3
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
.begin create_dirvec
create_dirvec.3037:
    li      3, $i2                      # |        601 |        601 |
.count move_args
    mov     $f0, $f2                    # |        601 |        601 |
    call    ext_create_array_float      # |        601 |        601 |
.count move_ret
    mov     $i1, $i4                    # |        601 |        601 |
.count move_args
    mov     $ig0, $i2                   # |        601 |        601 |
.count move_args
    mov     $i4, $i3                    # |        601 |        601 |
    call    ext_create_array_int        # |        601 |        601 |
    mov     $hp, $i2                    # |        601 |        601 |
    add     $hp, 2, $hp                 # |        601 |        601 |
    store   $i1, [$i2 + 1]              # |        601 |        601 |
    store   $i4, [$i2 + 0]              # |        601 |        601 |
    mov     $i2, $i1                    # |        601 |        601 |
    jr      $ra1                        # |        601 |        601 |
.end create_dirvec

######################################################################
# create_dirvec_elements($i5, $i6)
# $ra = $ra2
# [$i1 - $i6]
# [$f2]
# []
# []
# [$ra - $ra1]
######################################################################
.begin create_dirvec_elements
create_dirvec_elements.3039:
    bl      $i6, 0, bge_else.22334      # |        600 |        600 |
bge_then.22334:
    jal     create_dirvec.3037, $ra1    # |        595 |        595 |
.count storer
    add     $i5, $i6, $tmp              # |        595 |        595 |
    store   $i1, [$tmp + 0]             # |        595 |        595 |
    sub     $i6, 1, $i6                 # |        595 |        595 |
    b       create_dirvec_elements.3039 # |        595 |        595 |
bge_else.22334:
    jr      $ra2                        # |          5 |          5 |
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
.begin create_dirvecs
create_dirvecs.3042:
    bl      $i7, 0, bge_else.22335      # |          6 |          6 |
bge_then.22335:
    jal     create_dirvec.3037, $ra1    # |          5 |          5 |
    li      120, $i2                    # |          5 |          5 |
.count move_args
    mov     $i1, $i3                    # |          5 |          5 |
    call    ext_create_array_int        # |          5 |          5 |
    store   $i1, [ext_dirvecs + $i7]    # |          5 |          5 |
    load    [ext_dirvecs + $i7], $i5    # |          5 |          5 |
    li      118, $i6                    # |          5 |          5 |
    jal     create_dirvec_elements.3039, $ra2# |          5 |          5 |
    sub     $i7, 1, $i7                 # |          5 |          5 |
    b       create_dirvecs.3042         # |          5 |          5 |
bge_else.22335:
    jr      $ra3                        # |          1 |          1 |
.end create_dirvecs

######################################################################
# init_dirvec_constants($i10, $i11)
# $ra = $ra3
# [$i1 - $i11]
# [$f1 - $f8]
# []
# []
# [$ra - $ra2]
######################################################################
.begin init_dirvec_constants
init_dirvec_constants.3044:
    bl      $i11, 0, bge_else.22336     # |        605 |        605 |
bge_then.22336:
    load    [$i10 + $i11], $i7          # |        600 |        600 |
    jal     setup_dirvec_constants.2829, $ra2# |        600 |        600 |
    sub     $i11, 1, $i11               # |        600 |        600 |
    b       init_dirvec_constants.3044  # |        600 |        600 |
bge_else.22336:
    jr      $ra3                        # |          5 |          5 |
.end init_dirvec_constants

######################################################################
# init_vecset_constants($i12)
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f8]
# []
# []
# [$ra - $ra3]
######################################################################
.begin init_vecset_constants
init_vecset_constants.3047:
    bl      $i12, 0, bge_else.22337     # |          6 |          6 |
bge_then.22337:
    load    [ext_dirvecs + $i12], $i10  # |          5 |          5 |
    li      119, $i11                   # |          5 |          5 |
    jal     init_dirvec_constants.3044, $ra3# |          5 |          5 |
    sub     $i12, 1, $i12               # |          5 |          5 |
    b       init_vecset_constants.3047  # |          5 |          5 |
bge_else.22337:
    jr      $ra4                        # |          1 |          1 |
.end init_vecset_constants

######################################################################
# init_dirvecs()
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f17]
# []
# []
# [$ra - $ra3]
######################################################################
.begin init_dirvecs
init_dirvecs.3049:
    li      4, $i7                      # |          1 |          1 |
    jal     create_dirvecs.3042, $ra3   # |          1 |          1 |
    li      0, $i5                      # |          1 |          1 |
    li      0, $i7                      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc19, $f9                  # |          1 |          1 |
.count move_args
    mov     $fc11, $f10                 # |          1 |          1 |
.count move_args
    mov     $i5, $i3                    # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    li      2, $i6                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc11, $f9                  # |          1 |          1 |
.count move_args
    mov     $fc11, $f10                 # |          1 |          1 |
.count move_args
    mov     $i5, $i3                    # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    li      1, $i5                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc18, $f9                  # |          1 |          1 |
.count move_args
    mov     $fc11, $f10                 # |          1 |          1 |
.count move_args
    mov     $i5, $i3                    # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc17, $f9                  # |          1 |          1 |
.count move_args
    mov     $fc11, $f10                 # |          1 |          1 |
.count move_args
    mov     $i5, $i3                    # |          1 |          1 |
.count move_args
    mov     $i6, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      2, $i5                      # |          1 |          1 |
    li      2, $i6                      # |          1 |          1 |
.count move_args
    mov     $fc11, $f14                 # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    li      8, $i9                      # |          1 |          1 |
    li      2, $i10                     # |          1 |          1 |
    li      4, $i11                     # |          1 |          1 |
    jal     calc_dirvec_rows.3033, $ra3 # |          1 |          1 |
    li      4, $i12                     # |          1 |          1 |
    b       init_vecset_constants.3047  # |          1 |          1 |
.end init_dirvecs

######################################################################
# add_reflection($i10, $i11, $f9, $f1, $f3, $f4)
# $ra = $ra3
# [$i1 - $i12]
# [$f1 - $f9]
# []
# []
# [$ra - $ra2]
######################################################################
.begin add_reflection
add_reflection.3051:
    jal     create_dirvec.3037, $ra1    # |          1 |          1 |
.count move_ret
    mov     $i1, $i12                   # |          1 |          1 |
    load    [$i12 + 0], $i1             # |          1 |          1 |
    store   $f1, [$i1 + 0]              # |          1 |          1 |
    store   $f3, [$i1 + 1]              # |          1 |          1 |
    store   $f4, [$i1 + 2]              # |          1 |          1 |
.count move_args
    mov     $i12, $i7                   # |          1 |          1 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |
    mov     $hp, $i1                    # |          1 |          1 |
    add     $hp, 3, $hp                 # |          1 |          1 |
    store   $f9, [$i1 + 2]              # |          1 |          1 |
    store   $i12, [$i1 + 1]             # |          1 |          1 |
    store   $i11, [$i1 + 0]             # |          1 |          1 |
    store   $i1, [ext_reflections + $i10]# |          1 |          1 |
    jr      $ra3                        # |          1 |          1 |
.end add_reflection

######################################################################
# setup_rect_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_rect_reflection
setup_rect_reflection.3058:
    load    [$i2 + 7], $i2
    add     $i1, $i1, $i1
    add     $i1, $i1, $i13
    add     $i13, 1, $i11
    load    [$i2 + 0], $f1
    fsub    $fc0, $f1, $f10
    fneg    $fg12, $f11
    fneg    $fg13, $f12
.count move_args
    mov     $ig4, $i10
.count move_args
    mov     $f10, $f9
.count move_args
    mov     $fg14, $f1
.count move_args
    mov     $f11, $f3
.count move_args
    mov     $f12, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 1, $i10
    add     $i13, 2, $i11
    fneg    $fg14, $f13
.count move_args
    mov     $f10, $f9
.count move_args
    mov     $f13, $f1
.count move_args
    mov     $fg12, $f3
.count move_args
    mov     $f12, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 2, $i10
    add     $i13, 3, $i11
.count move_args
    mov     $f10, $f9
.count move_args
    mov     $f13, $f1
.count move_args
    mov     $f11, $f3
.count move_args
    mov     $fg13, $f4
    jal     add_reflection.3051, $ra3
    add     $ig4, 3, $ig4
    jr      $ra4
.end setup_rect_reflection

######################################################################
# setup_surface_reflection($i1, $i2)
# $ra = $ra4
# [$i1 - $i12]
# [$f1 - $f9]
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_surface_reflection
setup_surface_reflection.3061:
    load    [$i2 + 4], $i3              # |          1 |          1 |
    load    [$i2 + 7], $i2              # |          1 |          1 |
    load    [$i3 + 0], $f1              # |          1 |          1 |
    fmul    $fc10, $f1, $f2             # |          1 |          1 |
    fmul    $fg14, $f1, $f1             # |          1 |          1 |
    load    [$i3 + 1], $f3              # |          1 |          1 |
    fmul    $fg12, $f3, $f4             # |          1 |          1 |
    fadd    $f1, $f4, $f1               # |          1 |          1 |
    load    [$i3 + 2], $f4              # |          1 |          1 |
    fmul    $fg13, $f4, $f5             # |          1 |          1 |
    fadd    $f1, $f5, $f1               # |          1 |          1 |
    fmul    $f2, $f1, $f2               # |          1 |          1 |
    fsub    $f2, $fg14, $f2             # |          1 |          1 |
    fmul    $fc10, $f3, $f3             # |          1 |          1 |
    fmul    $f3, $f1, $f3               # |          1 |          1 |
    fsub    $f3, $fg12, $f3             # |          1 |          1 |
    fmul    $fc10, $f4, $f4             # |          1 |          1 |
    fmul    $f4, $f1, $f1               # |          1 |          1 |
    fsub    $f1, $fg13, $f4             # |          1 |          1 |
    load    [$i2 + 0], $f1              # |          1 |          1 |
    fsub    $fc0, $f1, $f9              # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, $i1, $i1               # |          1 |          1 |
    add     $i1, 1, $i11                # |          1 |          1 |
.count move_args
    mov     $ig4, $i10                  # |          1 |          1 |
.count move_args
    mov     $f2, $f1                    # |          1 |          1 |
    jal     add_reflection.3051, $ra3   # |          1 |          1 |
    add     $ig4, 1, $ig4               # |          1 |          1 |
    jr      $ra4                        # |          1 |          1 |
.end setup_surface_reflection

######################################################################
# setup_reflections($i1)
# $ra = $ra4
# [$i1 - $i13]
# [$f1 - $f13]
# [$ig4]
# []
# [$ra - $ra3]
######################################################################
.begin setup_reflections
setup_reflections.3064:
    bl      $i1, 0, bge_else.22338      # |          1 |          1 |
bge_then.22338:
    load    [ext_objects + $i1], $i2    # |          1 |          1 |
    load    [$i2 + 2], $i3              # |          1 |          1 |
    bne     $i3, 2, be_else.22339       # |          1 |          1 |
be_then.22339:
    load    [$i2 + 7], $i3              # |          1 |          1 |
    load    [$i3 + 0], $f1              # |          1 |          1 |
    bg      $fc0, $f1, ble_else.22340   # |          1 |          1 |
ble_then.22340:
    jr      $ra4
ble_else.22340:
    load    [$i2 + 1], $i3              # |          1 |          1 |
    be      $i3, 1, setup_rect_reflection.3058# |          1 |          1 |
    be      $i3, 2, setup_surface_reflection.3061# |          1 |          1 |
    jr      $ra4
be_else.22339:
    jr      $ra4
bge_else.22338:
    jr      $ra4
.end setup_reflections

######################################################################
# rt()
# $ra = $ra9
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra8]
######################################################################
.begin rt
rt.3066:
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i36                   # |          1 |          1 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i37                   # |          1 |          1 |
    jal     create_pixelline.3013, $ra3 # |          1 |          1 |
.count move_ret
    mov     $i1, $i38                   # |          1 |          1 |
    jal     read_parameter.2731, $ra3   # |          1 |          1 |
    call    write_ppm_header.2974       # |          1 |          1 |
    jal     init_dirvecs.3049, $ra4     # |          1 |          1 |
    li      ext_light_dirvec, $i7       # |          1 |          1 |
    load    [ext_light_dirvec + 0], $i1 # |          1 |          1 |
    store   $fg14, [$i1 + 0]            # |          1 |          1 |
    store   $fg12, [$i1 + 1]            # |          1 |          1 |
    store   $fg13, [$i1 + 2]            # |          1 |          1 |
    jal     setup_dirvec_constants.2829, $ra2# |          1 |          1 |
    sub     $ig0, 1, $i1                # |          1 |          1 |
    jal     setup_reflections.3064, $ra4# |          1 |          1 |
    li      0, $i33                     # |          1 |          1 |
    li      127, $i32                   # |          1 |          1 |
.count load_float
    load    [f.21573], $f1              # |          1 |          1 |
    fmul    $f1, $fg23, $f2             # |          1 |          1 |
    fadd    $f2, $fg20, $f18            # |          1 |          1 |
    fmul    $f1, $fg24, $f2             # |          1 |          1 |
    fadd    $f2, $fg21, $f3             # |          1 |          1 |
    load    [ext_screeny_dir + 2], $f2  # |          1 |          1 |
    fmul    $f1, $f2, $f1               # |          1 |          1 |
    fadd    $f1, $fg22, $f2             # |          1 |          1 |
.count move_args
    mov     $i37, $i31                  # |          1 |          1 |
.count move_args
    mov     $f3, $f1                    # |          1 |          1 |
    jal     pretrace_pixels.2983, $ra7  # |          1 |          1 |
    li      0, $i35                     # |          1 |          1 |
    li      2, $i39                     # |          1 |          1 |
    b       scan_line.3000              # |          1 |          1 |
.end rt

######################################################################
# $i1 = main()
# $ra = $ra
# [$i1 - $i39]
# [$f1 - $f18]
# [$ig0 - $ig4]
# [$fg0 - $fg24]
# [$ra - $ra9]
######################################################################
.begin main
ext_main:
.count stack_store_ra
    store   $ra, [$sp - 1]              # |          1 |          1 |
.count stack_move
    sub     $sp, 1, $sp                 # |          1 |          1 |
    load    [ext_solver_dist + 0], $fg0 # |          1 |          1 |
    load    [ext_diffuse_ray + 0], $fg1 # |          1 |          1 |
    load    [ext_diffuse_ray + 1], $fg2 # |          1 |          1 |
    load    [ext_diffuse_ray + 2], $fg3 # |          1 |          1 |
    load    [ext_rgb + 0], $fg4         # |          1 |          1 |
    load    [ext_rgb + 1], $fg5         # |          1 |          1 |
    load    [ext_rgb + 2], $fg6         # |          1 |          1 |
    load    [ext_n_objects + 0], $ig0   # |          1 |          1 |
    load    [ext_tmin + 0], $fg7        # |          1 |          1 |
    load    [ext_startp_fast + 0], $fg8 # |          1 |          1 |
    load    [ext_startp_fast + 1], $fg9 # |          1 |          1 |
    load    [ext_startp_fast + 2], $fg10# |          1 |          1 |
    load    [ext_texture_color + 1], $fg11# |          1 |          1 |
    load    [ext_light + 1], $fg12      # |          1 |          1 |
    load    [ext_light + 2], $fg13      # |          1 |          1 |
    load    [ext_light + 0], $fg14      # |          1 |          1 |
    load    [ext_texture_color + 2], $fg15# |          1 |          1 |
    load    [ext_or_net + 0], $ig1      # |          1 |          1 |
    load    [ext_intsec_rectside + 0], $ig2# |          1 |          1 |
    load    [ext_texture_color + 0], $fg16# |          1 |          1 |
    load    [ext_intersected_object_id + 0], $ig3# |          1 |          1 |
    load    [ext_n_reflections + 0], $ig4# |          1 |          1 |
    load    [ext_startp + 0], $fg17     # |          1 |          1 |
    load    [ext_startp + 1], $fg18     # |          1 |          1 |
    load    [ext_startp + 2], $fg19     # |          1 |          1 |
    load    [ext_screenz_dir + 0], $fg20# |          1 |          1 |
    load    [ext_screenz_dir + 1], $fg21# |          1 |          1 |
    load    [ext_screenz_dir + 2], $fg22# |          1 |          1 |
    load    [ext_screeny_dir + 0], $fg23# |          1 |          1 |
    load    [ext_screeny_dir + 1], $fg24# |          1 |          1 |
    load    [f.21523 + 0], $fc0         # |          1 |          1 |
    load    [f.21548 + 0], $fc1         # |          1 |          1 |
    load    [f.21547 + 0], $fc2         # |          1 |          1 |
    load    [f.21522 + 0], $fc3         # |          1 |          1 |
    load    [f.21524 + 0], $fc4         # |          1 |          1 |
    load    [f.21550 + 0], $fc5         # |          1 |          1 |
    load    [f.21549 + 0], $fc6         # |          1 |          1 |
    load    [f.21527 + 0], $fc7         # |          1 |          1 |
    load    [f.21537 + 0], $fc8         # |          1 |          1 |
    load    [f.21536 + 0], $fc9         # |          1 |          1 |
    load    [f.21521 + 0], $fc10        # |          1 |          1 |
    load    [f.21561 + 0], $fc11        # |          1 |          1 |
    load    [f.21543 + 0], $fc12        # |          1 |          1 |
    load    [f.21542 + 0], $fc13        # |          1 |          1 |
    load    [f.21531 + 0], $fc14        # |          1 |          1 |
    load    [f.21526 + 0], $fc15        # |          1 |          1 |
    load    [f.21505 + 0], $fc16        # |          1 |          1 |
    load    [f.21564 + 0], $fc17        # |          1 |          1 |
    load    [f.21563 + 0], $fc18        # |          1 |          1 |
    load    [f.21562 + 0], $fc19        # |          1 |          1 |
    jal     rt.3066, $ra9               # |          1 |          1 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |          1 |          1 |
.count stack_move
    add     $sp, 1, $sp                 # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    ret                                 # |          1 |          1 |
.end main
                                        # | Instructions | Clocks     |
