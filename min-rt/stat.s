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
    bne     $i7, -1, bne.21593          # |         18 |         18 |
be.21593:
    li      0, $i1                      # |          1 |          1 |
    jr      $ra1                        # |          1 |          1 |
bne.21593:
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
    bne     $i10, 0, bne.21594          # |         17 |         17 |
be.21594:
    li      4, $i2                      # |         17 |         17 |
.count move_args
    mov     $f0, $f2                    # |         17 |         17 |
    call    ext_create_array_float      # |         17 |         17 |
    ble     $f0, $f3, ble.21595         # |         17 |         17 |
.count dual_jmp
    b       bg.21595                    # |          2 |          2 |
bne.21594:
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 0]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 1]
    call    ext_read_float
    fmul    $f1, $fc16, $f1
    store   $f1, [$i15 + 2]
    li      4, $i2
.count move_args
    mov     $f0, $f2
    call    ext_create_array_float
    bg      $f0, $f3, bg.21595
ble.21595:
    li      0, $i2                      # |         15 |         15 |
    be      $i8, 2, be.21596            # |         15 |         15 |
.count dual_jmp
    b       bne.21596                   # |         13 |         13 |
bg.21595:
    li      1, $i2                      # |          2 |          2 |
    bne     $i8, 2, bne.21596           # |          2 |          2 |
be.21596:
    li      1, $i3                      # |          2 |          2 |
    mov     $hp, $i4                    # |          2 |          2 |
    add     $hp, 11, $hp                # |          2 |          2 |
    store   $i1, [$i4 + 10]             # |          2 |          2 |
    store   $i15, [$i4 + 9]             # |          2 |          2 |
    store   $i14, [$i4 + 8]             # |          2 |          2 |
    store   $i13, [$i4 + 7]             # |          2 |          2 |
    store   $i3, [$i4 + 6]              # |          2 |          2 |
    store   $i12, [$i4 + 5]             # |          2 |          2 |
    store   $i11, [$i4 + 4]             # |          2 |          2 |
    store   $i10, [$i4 + 3]             # |          2 |          2 |
    store   $i9, [$i4 + 2]              # |          2 |          2 |
    store   $i8, [$i4 + 1]              # |          2 |          2 |
    store   $i7, [$i4 + 0]              # |          2 |          2 |
    store   $i4, [ext_objects + $i6]    # |          2 |          2 |
    be      $i8, 3, be.21597            # |          2 |          2 |
.count dual_jmp
    b       bne.21597                   # |          2 |          2 |
bne.21596:
    mov     $i2, $i3                    # |         15 |         15 |
    mov     $hp, $i4                    # |         15 |         15 |
    add     $hp, 11, $hp                # |         15 |         15 |
    store   $i1, [$i4 + 10]             # |         15 |         15 |
    store   $i15, [$i4 + 9]             # |         15 |         15 |
    store   $i14, [$i4 + 8]             # |         15 |         15 |
    store   $i13, [$i4 + 7]             # |         15 |         15 |
    store   $i3, [$i4 + 6]              # |         15 |         15 |
    store   $i12, [$i4 + 5]             # |         15 |         15 |
    store   $i11, [$i4 + 4]             # |         15 |         15 |
    store   $i10, [$i4 + 3]             # |         15 |         15 |
    store   $i9, [$i4 + 2]              # |         15 |         15 |
    store   $i8, [$i4 + 1]              # |         15 |         15 |
    store   $i7, [$i4 + 0]              # |         15 |         15 |
    store   $i4, [ext_objects + $i6]    # |         15 |         15 |
    bne     $i8, 3, bne.21597           # |         15 |         15 |
be.21597:
    load    [$i11 + 0], $f1             # |          9 |          9 |
    be      $f1, $f0, be.21599          # |          9 |          9 |
bne.21598:
    bne     $f1, $f0, bne.21599         # |          7 |          7 |
be.21599:
    mov     $f0, $f1                    # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    be      $f1, $f0, be.21602          # |          2 |          2 |
.count dual_jmp
    b       bne.21601                   # |          2 |          2 |
bne.21599:
    bg      $f1, $f0, bg.21600          # |          7 |          7 |
ble.21600:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    be      $f1, $f0, be.21602
.count dual_jmp
    b       bne.21601
bg.21600:
    fmul    $f1, $f1, $f1               # |          7 |          7 |
    finv    $f1, $f1                    # |          7 |          7 |
    store   $f1, [$i11 + 0]             # |          7 |          7 |
    load    [$i11 + 1], $f1             # |          7 |          7 |
    be      $f1, $f0, be.21602          # |          7 |          7 |
bne.21601:
    bne     $f1, $f0, bne.21602         # |          9 |          9 |
be.21602:
    mov     $f0, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.21605
.count dual_jmp
    b       bne.21604
bne.21602:
    bg      $f1, $f0, bg.21603          # |          9 |          9 |
ble.21603:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    be      $f1, $f0, be.21605
.count dual_jmp
    b       bne.21604
bg.21603:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
    store   $f1, [$i11 + 1]             # |          9 |          9 |
    load    [$i11 + 2], $f1             # |          9 |          9 |
    be      $f1, $f0, be.21605          # |          9 |          9 |
bne.21604:
    bne     $f1, $f0, bne.21605         # |          9 |          9 |
be.21605:
    mov     $f0, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.21613
.count dual_jmp
    b       bne.21613
bne.21605:
    bg      $f1, $f0, bg.21606          # |          9 |          9 |
ble.21606:
    fmul    $f1, $f1, $f1
    finv_n  $f1, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.21613
.count dual_jmp
    b       bne.21613
bg.21606:
    fmul    $f1, $f1, $f1               # |          9 |          9 |
    finv    $f1, $f1                    # |          9 |          9 |
    store   $f1, [$i11 + 2]             # |          9 |          9 |
    be      $i10, 0, be.21613           # |          9 |          9 |
.count dual_jmp
    b       bne.21613
bne.21597:
    bne     $i8, 2, bne.21608           # |          8 |          8 |
be.21608:
    load    [$i11 + 0], $f1             # |          2 |          2 |
    load    [$i11 + 1], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fmul    $f1, $f1, $f2               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    load    [$i11 + 2], $f3             # |          2 |          2 |
    fmul    $f3, $f3, $f3               # |          2 |          2 |
    fadd    $f2, $f3, $f2               # |          2 |          2 |
    fsqrt   $f2, $f2                    # |          2 |          2 |
    bne     $i2, 0, bne.21609           # |          2 |          2 |
be.21609:
    li      1, $i1                      # |          2 |          2 |
    be      $f2, $f0, be.21610          # |          2 |          2 |
.count dual_jmp
    b       bne.21610                   # |          2 |          2 |
bne.21609:
    li      0, $i1
    bne     $f2, $f0, bne.21610
be.21610:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.21613
.count dual_jmp
    b       bne.21613
bne.21610:
    bne     $i1, 0, bne.21611           # |          2 |          2 |
be.21611:
    finv    $f2, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 0]
    load    [$i11 + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 1]
    load    [$i11 + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [$i11 + 2]
    be      $i10, 0, be.21613
.count dual_jmp
    b       bne.21613
bne.21611:
    finv_n  $f2, $f2                    # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 0]             # |          2 |          2 |
    load    [$i11 + 1], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 1]             # |          2 |          2 |
    load    [$i11 + 2], $f1             # |          2 |          2 |
    fmul    $f1, $f2, $f1               # |          2 |          2 |
    store   $f1, [$i11 + 2]             # |          2 |          2 |
    be      $i10, 0, be.21613           # |          2 |          2 |
.count dual_jmp
    b       bne.21613
bne.21608:
    bne     $i10, 0, bne.21613          # |          6 |          6 |
be.21613:
    li      1, $i1                      # |         17 |         17 |
    jr      $ra1                        # |         17 |         17 |
bne.21613:
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
    bl      $i16, 60, bl.21614          # |         18 |         18 |
bge.21614:
    jr      $ra2
bl.21614:
.count move_args
    mov     $i16, $i6                   # |         18 |         18 |
    jal     read_nth_object.2719, $ra1  # |         18 |         18 |
    bne     $i1, 0, bne.21615           # |         18 |         18 |
be.21615:
    mov     $i16, $ig0                  # |          1 |          1 |
    jr      $ra2                        # |          1 |          1 |
bne.21615:
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
    add     $sp, -3, $sp                # |         43 |         43 |
.count stack_store
    store   $i1, [$sp + 1]              # |         43 |         43 |
    call    ext_read_int                # |         43 |         43 |
    bne     $i1, -1, bne.21617          # |         43 |         43 |
be.21617:
.count stack_load_ra
    load    [$sp + 0], $ra              # |         14 |         14 |
.count stack_move
    add     $sp, 3, $sp                 # |         14 |         14 |
.count stack_load
    load    [$sp - 2], $i1              # |         14 |         14 |
    add     $i1, 1, $i2                 # |         14 |         14 |
    add     $i0, -1, $i3                # |         14 |         14 |
    b       ext_create_array_int        # |         14 |         14 |
bne.21617:
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
    add     $sp, -3, $sp                # |          3 |          3 |
.count stack_store
    store   $i1, [$sp + 1]              # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    call    read_net_item.2725          # |          3 |          3 |
    load    [$i1 + 0], $i2              # |          3 |          3 |
    bne     $i2, -1, bne.21621          # |          3 |          3 |
be.21621:
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
bne.21621:
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
    bne     $i2, -1, bne.21624          # |         11 |         11 |
be.21624:
    jr      $ra1                        # |          1 |          1 |
bne.21624:
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
    bne     $i4, 1, bne.21625           # |     23,754 |     23,754 |
be.21625:
    be      $f4, $f0, ble.21632         # |     23,754 |     23,754 |
bne.21626:
    load    [$i1 + 4], $i3              # |     23,754 |     23,754 |
    load    [$i3 + 1], $f5              # |     23,754 |     23,754 |
    load    [$i2 + 1], $f6              # |     23,754 |     23,754 |
    load    [$i1 + 6], $i4              # |     23,754 |     23,754 |
    bg      $f0, $f4, bg.21627          # |     23,754 |     23,754 |
ble.21627:
    li      0, $i5                      # |     23,580 |     23,580 |
    be      $i4, 0, be.21628            # |     23,580 |     23,580 |
.count dual_jmp
    b       bne.21628
bg.21627:
    li      1, $i5                      # |        174 |        174 |
    bne     $i4, 0, bne.21628           # |        174 |        174 |
be.21628:
    mov     $i5, $i4                    # |     23,754 |     23,754 |
    load    [$i3 + 0], $f7              # |     23,754 |     23,754 |
    finv    $f4, $f4                    # |     23,754 |     23,754 |
    bne     $i4, 0, bne.21630           # |     23,754 |     23,754 |
be.21630:
    fneg    $f7, $f7                    # |     23,580 |     23,580 |
    fsub    $f7, $f1, $f7               # |     23,580 |     23,580 |
    fmul    $f7, $f4, $f4               # |     23,580 |     23,580 |
    fmul    $f4, $f6, $f6               # |     23,580 |     23,580 |
    fadd_a  $f6, $f2, $f6               # |     23,580 |     23,580 |
    ble     $f5, $f6, ble.21632         # |     23,580 |     23,580 |
.count dual_jmp
    b       bg.21631                    # |      8,663 |      8,663 |
bne.21630:
    fsub    $f7, $f1, $f7               # |        174 |        174 |
    fmul    $f7, $f4, $f4               # |        174 |        174 |
    fmul    $f4, $f6, $f6               # |        174 |        174 |
    fadd_a  $f6, $f2, $f6               # |        174 |        174 |
    ble     $f5, $f6, ble.21632         # |        174 |        174 |
.count dual_jmp
    b       bg.21631                    # |        127 |        127 |
bne.21628:
    load    [$i3 + 0], $f7
    finv    $f4, $f4
    bne     $i5, 0, bne.21629
be.21629:
    li      1, $i4
    fsub    $f7, $f1, $f7
    fmul    $f7, $f4, $f4
    fmul    $f4, $f6, $f6
    fadd_a  $f6, $f2, $f6
    ble     $f5, $f6, ble.21632
.count dual_jmp
    b       bg.21631
bne.21629:
    li      0, $i4
    fneg    $f7, $f7
    fsub    $f7, $f1, $f7
    fmul    $f7, $f4, $f4
    fmul    $f4, $f6, $f6
    fadd_a  $f6, $f2, $f6
    ble     $f5, $f6, ble.21632
bg.21631:
    load    [$i3 + 2], $f5              # |      8,790 |      8,790 |
    load    [$i2 + 2], $f6              # |      8,790 |      8,790 |
    fmul    $f4, $f6, $f6               # |      8,790 |      8,790 |
    fadd_a  $f6, $f3, $f6               # |      8,790 |      8,790 |
    bg      $f5, $f6, bg.21632          # |      8,790 |      8,790 |
ble.21632:
    li      0, $i3                      # |     20,087 |     20,087 |
    load    [$i2 + 1], $f4              # |     20,087 |     20,087 |
    be      $f4, $f0, ble.21640         # |     20,087 |     20,087 |
bne.21634:
    load    [$i1 + 4], $i3              # |     20,087 |     20,087 |
    load    [$i3 + 2], $f5              # |     20,087 |     20,087 |
    load    [$i2 + 2], $f6              # |     20,087 |     20,087 |
    load    [$i1 + 6], $i4              # |     20,087 |     20,087 |
    bg      $f0, $f4, bg.21635          # |     20,087 |     20,087 |
ble.21635:
    li      0, $i5                      # |         38 |         38 |
    be      $i4, 0, be.21636            # |         38 |         38 |
.count dual_jmp
    b       bne.21636
bg.21635:
    li      1, $i5                      # |     20,049 |     20,049 |
    bne     $i4, 0, bne.21636           # |     20,049 |     20,049 |
be.21636:
    mov     $i5, $i4                    # |     20,087 |     20,087 |
    load    [$i3 + 1], $f7              # |     20,087 |     20,087 |
    finv    $f4, $f4                    # |     20,087 |     20,087 |
    be      $i4, 0, bne.21637           # |     20,087 |     20,087 |
.count dual_jmp
    b       be.21637                    # |     20,049 |     20,049 |
bne.21636:
    load    [$i3 + 1], $f7
    finv    $f4, $f4
    bne     $i5, 0, bne.21637
be.21637:
    fsub    $f7, $f2, $f7               # |     20,049 |     20,049 |
    fmul    $f7, $f4, $f4               # |     20,049 |     20,049 |
    fmul    $f4, $f6, $f6               # |     20,049 |     20,049 |
    fadd_a  $f6, $f3, $f6               # |     20,049 |     20,049 |
    ble     $f5, $f6, ble.21640         # |     20,049 |     20,049 |
.count dual_jmp
    b       bg.21639                    # |      3,574 |      3,574 |
bne.21637:
    fneg    $f7, $f7                    # |         38 |         38 |
    fsub    $f7, $f2, $f7               # |         38 |         38 |
    fmul    $f7, $f4, $f4               # |         38 |         38 |
    fmul    $f4, $f6, $f6               # |         38 |         38 |
    fadd_a  $f6, $f3, $f6               # |         38 |         38 |
    ble     $f5, $f6, ble.21640         # |         38 |         38 |
bg.21639:
    load    [$i3 + 0], $f5              # |      3,575 |      3,575 |
    load    [$i2 + 0], $f6              # |      3,575 |      3,575 |
    fmul    $f4, $f6, $f6               # |      3,575 |      3,575 |
    fadd_a  $f6, $f1, $f6               # |      3,575 |      3,575 |
    bg      $f5, $f6, bg.21640          # |      3,575 |      3,575 |
ble.21640:
    li      0, $i3                      # |     19,143 |     19,143 |
    load    [$i2 + 2], $f4              # |     19,143 |     19,143 |
    be      $f4, $f0, ble.21656         # |     19,143 |     19,143 |
bne.21642:
    load    [$i1 + 4], $i3              # |     19,143 |     19,143 |
    load    [$i1 + 6], $i1              # |     19,143 |     19,143 |
    load    [$i3 + 0], $f5              # |     19,143 |     19,143 |
    load    [$i2 + 0], $f6              # |     19,143 |     19,143 |
    bg      $f0, $f4, bg.21643          # |     19,143 |     19,143 |
ble.21643:
    li      0, $i4                      # |     12,429 |     12,429 |
    be      $i1, 0, be.21644            # |     12,429 |     12,429 |
.count dual_jmp
    b       bne.21644
bg.21643:
    li      1, $i4                      # |      6,714 |      6,714 |
    bne     $i1, 0, bne.21644           # |      6,714 |      6,714 |
be.21644:
    mov     $i4, $i1                    # |     19,143 |     19,143 |
    load    [$i3 + 2], $f7              # |     19,143 |     19,143 |
    finv    $f4, $f4                    # |     19,143 |     19,143 |
    be      $i1, 0, bne.21645           # |     19,143 |     19,143 |
.count dual_jmp
    b       be.21645                    # |      6,714 |      6,714 |
bne.21644:
    load    [$i3 + 2], $f7
    finv    $f4, $f4
    bne     $i4, 0, bne.21645
be.21645:
    fsub    $f7, $f3, $f3               # |      6,714 |      6,714 |
    fmul    $f3, $f4, $f3               # |      6,714 |      6,714 |
    fmul    $f3, $f6, $f4               # |      6,714 |      6,714 |
    fadd_a  $f4, $f1, $f1               # |      6,714 |      6,714 |
    ble     $f5, $f1, ble.21656         # |      6,714 |      6,714 |
.count dual_jmp
    b       bg.21647                    # |      1,198 |      1,198 |
bne.21645:
    fneg    $f7, $f7                    # |     12,429 |     12,429 |
    fsub    $f7, $f3, $f3               # |     12,429 |     12,429 |
    fmul    $f3, $f4, $f3               # |     12,429 |     12,429 |
    fmul    $f3, $f6, $f4               # |     12,429 |     12,429 |
    fadd_a  $f4, $f1, $f1               # |     12,429 |     12,429 |
    ble     $f5, $f1, ble.21656         # |     12,429 |     12,429 |
bg.21647:
    load    [$i3 + 1], $f1              # |      3,882 |      3,882 |
    load    [$i2 + 1], $f4              # |      3,882 |      3,882 |
    fmul    $f3, $f4, $f4               # |      3,882 |      3,882 |
    fadd_a  $f4, $f2, $f2               # |      3,882 |      3,882 |
    ble     $f1, $f2, ble.21656         # |      3,882 |      3,882 |
bg.21648:
    mov     $f3, $fg0                   # |      2,165 |      2,165 |
    li      3, $i1                      # |      2,165 |      2,165 |
    ret                                 # |      2,165 |      2,165 |
bg.21640:
    mov     $f4, $fg0                   # |        944 |        944 |
    li      2, $i1                      # |        944 |        944 |
    ret                                 # |        944 |        944 |
bg.21632:
    mov     $f4, $fg0                   # |      3,667 |      3,667 |
    li      1, $i1                      # |      3,667 |      3,667 |
    ret                                 # |      3,667 |      3,667 |
bne.21625:
    bne     $i4, 2, bne.21649
be.21649:
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
    ble     $f4, $f0, ble.21656
bg.21650:
    fmul    $f5, $f1, $f1
    fmul    $f7, $f2, $f2
    fadd    $f1, $f2, $f1
    fmul    $f8, $f3, $f2
    fadd_n  $f1, $f2, $f1
    finv    $f4, $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.21649:
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
    bne     $i5, 0, bne.21651
be.21651:
    be      $f7, $f0, ble.21656
.count dual_jmp
    b       bne.21652
bne.21651:
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
    be      $f7, $f0, ble.21656
bne.21652:
    fmul    $f4, $f1, $f9
    fmul    $f9, $f8, $f9
    fmul    $f5, $f2, $f12
    fmul    $f12, $f10, $f12
    fadd    $f9, $f12, $f9
    fmul    $f6, $f3, $f12
    fmul    $f12, $f11, $f12
    fadd    $f9, $f12, $f9
    bne     $i5, 0, bne.21653
be.21653:
    mov     $f9, $f4
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    be      $i5, 0, be.21654
.count dual_jmp
    b       bne.21654
bne.21653:
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
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    bne     $i5, 0, bne.21654
be.21654:
    mov     $f6, $f1
    be      $i4, 3, be.21655
.count dual_jmp
    b       bne.21655
bne.21654:
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
    bne     $i4, 3, bne.21655
be.21655:
    fsub    $f1, $fc0, $f1
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, ble.21656
.count dual_jmp
    b       bg.21656
bne.21655:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    bg      $f1, $f0, bg.21656
ble.21656:
    li      0, $i1                      # |     16,978 |     16,978 |
    ret                                 # |     16,978 |     16,978 |
bg.21656:
    load    [$i1 + 6], $i1
    fsqrt   $f1, $f1
    finv    $f7, $f2
    bne     $i1, 0, bne.21657
be.21657:
    fneg    $f1, $f1
    fsub    $f1, $f4, $f1
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.21657:
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
    bne     $i5, 1, bne.21658           # |    660,729 |    660,729 |
be.21658:
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
    ble     $f4, $f5, be.21661          # |    660,729 |    660,729 |
bg.21659:
    load    [$i2 + 2], $f5              # |    223,135 |    223,135 |
    load    [$i3 + 2], $f7              # |    223,135 |    223,135 |
    fmul    $f6, $f7, $f7               # |    223,135 |    223,135 |
    fadd_a  $f7, $f3, $f7               # |    223,135 |    223,135 |
    ble     $f5, $f7, be.21661          # |    223,135 |    223,135 |
bg.21660:
    load    [$i1 + 1], $f5              # |    146,877 |    146,877 |
    bne     $f5, $f0, bne.21661         # |    146,877 |    146,877 |
be.21661:
    load    [$i2 + 0], $f5              # |    513,852 |    513,852 |
    load    [$i3 + 0], $f6              # |    513,852 |    513,852 |
    load    [$i1 + 2], $f7              # |    513,852 |    513,852 |
    fsub    $f7, $f2, $f7               # |    513,852 |    513,852 |
    load    [$i1 + 3], $f8              # |    513,852 |    513,852 |
    fmul    $f7, $f8, $f7               # |    513,852 |    513,852 |
    fmul    $f7, $f6, $f6               # |    513,852 |    513,852 |
    fadd_a  $f6, $f1, $f6               # |    513,852 |    513,852 |
    ble     $f5, $f6, be.21665          # |    513,852 |    513,852 |
bg.21663:
    load    [$i2 + 2], $f6              # |     75,031 |     75,031 |
    load    [$i3 + 2], $f8              # |     75,031 |     75,031 |
    fmul    $f7, $f8, $f8               # |     75,031 |     75,031 |
    fadd_a  $f8, $f3, $f8               # |     75,031 |     75,031 |
    ble     $f6, $f8, be.21665          # |     75,031 |     75,031 |
bg.21664:
    load    [$i1 + 3], $f6              # |     34,836 |     34,836 |
    bne     $f6, $f0, bne.21665         # |     34,836 |     34,836 |
be.21665:
    load    [$i3 + 0], $f6              # |    479,016 |    479,016 |
    load    [$i1 + 4], $f7              # |    479,016 |    479,016 |
    fsub    $f7, $f3, $f3               # |    479,016 |    479,016 |
    load    [$i1 + 5], $f7              # |    479,016 |    479,016 |
    fmul    $f3, $f7, $f3               # |    479,016 |    479,016 |
    fmul    $f3, $f6, $f6               # |    479,016 |    479,016 |
    fadd_a  $f6, $f1, $f1               # |    479,016 |    479,016 |
    ble     $f5, $f1, ble.21675         # |    479,016 |    479,016 |
bg.21667:
    load    [$i3 + 1], $f1              # |     32,006 |     32,006 |
    fmul    $f3, $f1, $f1               # |     32,006 |     32,006 |
    fadd_a  $f1, $f2, $f1               # |     32,006 |     32,006 |
    ble     $f4, $f1, ble.21675         # |     32,006 |     32,006 |
bg.21668:
    load    [$i1 + 5], $f1              # |     24,354 |     24,354 |
    be      $f1, $f0, ble.21675         # |     24,354 |     24,354 |
bne.21669:
    mov     $f3, $fg0                   # |     24,354 |     24,354 |
    li      3, $i1                      # |     24,354 |     24,354 |
    ret                                 # |     24,354 |     24,354 |
bne.21665:
    mov     $f7, $fg0                   # |     34,836 |     34,836 |
    li      2, $i1                      # |     34,836 |     34,836 |
    ret                                 # |     34,836 |     34,836 |
bne.21661:
    mov     $f6, $fg0                   # |    146,877 |    146,877 |
    li      1, $i1                      # |    146,877 |    146,877 |
    ret                                 # |    146,877 |    146,877 |
bne.21658:
    load    [$i1 + 0], $f4
    bne     $i5, 2, bne.21670
be.21670:
    ble     $f0, $f4, ble.21675
bg.21671:
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
bne.21670:
    be      $f4, $f0, ble.21675
bne.21672:
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
    bne     $i4, 0, bne.21673
be.21673:
    mov     $f7, $f1
    be      $i5, 3, be.21674
.count dual_jmp
    b       bne.21674
bne.21673:
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
    bne     $i5, 3, bne.21674
be.21674:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, ble.21675
.count dual_jmp
    b       bg.21675
bne.21674:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    bg      $f1, $f0, bg.21675
ble.21675:
    li      0, $i1                      # |    454,662 |    454,662 |
    ret                                 # |    454,662 |    454,662 |
bg.21675:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, bne.21676
be.21676:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    ret     
bne.21676:
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
    bne     $i6, 1, bne.21677           # |  1,134,616 |  1,134,616 |
be.21677:
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
    ble     $f4, $f5, be.21680          # |  1,134,616 |  1,134,616 |
bg.21678:
    load    [$i3 + 2], $f5              # |    494,435 |    494,435 |
    load    [$i2 + 2], $f7              # |    494,435 |    494,435 |
    fmul    $f6, $f7, $f7               # |    494,435 |    494,435 |
    fadd_a  $f7, $f3, $f7               # |    494,435 |    494,435 |
    ble     $f5, $f7, be.21680          # |    494,435 |    494,435 |
bg.21679:
    load    [$i1 + 1], $f5              # |    329,995 |    329,995 |
    bne     $f5, $f0, bne.21680         # |    329,995 |    329,995 |
be.21680:
    load    [$i3 + 0], $f5              # |    804,621 |    804,621 |
    load    [$i2 + 0], $f6              # |    804,621 |    804,621 |
    load    [$i1 + 2], $f7              # |    804,621 |    804,621 |
    fsub    $f7, $f2, $f7               # |    804,621 |    804,621 |
    load    [$i1 + 3], $f8              # |    804,621 |    804,621 |
    fmul    $f7, $f8, $f7               # |    804,621 |    804,621 |
    fmul    $f7, $f6, $f6               # |    804,621 |    804,621 |
    fadd_a  $f6, $f1, $f6               # |    804,621 |    804,621 |
    ble     $f5, $f6, be.21684          # |    804,621 |    804,621 |
bg.21682:
    load    [$i3 + 2], $f6              # |    350,982 |    350,982 |
    load    [$i2 + 2], $f8              # |    350,982 |    350,982 |
    fmul    $f7, $f8, $f8               # |    350,982 |    350,982 |
    fadd_a  $f8, $f3, $f8               # |    350,982 |    350,982 |
    ble     $f6, $f8, be.21684          # |    350,982 |    350,982 |
bg.21683:
    load    [$i1 + 3], $f6              # |    227,327 |    227,327 |
    bne     $f6, $f0, bne.21684         # |    227,327 |    227,327 |
be.21684:
    load    [$i2 + 0], $f6              # |    577,294 |    577,294 |
    load    [$i1 + 4], $f7              # |    577,294 |    577,294 |
    fsub    $f7, $f3, $f3               # |    577,294 |    577,294 |
    load    [$i1 + 5], $f7              # |    577,294 |    577,294 |
    fmul    $f3, $f7, $f3               # |    577,294 |    577,294 |
    fmul    $f3, $f6, $f6               # |    577,294 |    577,294 |
    fadd_a  $f6, $f1, $f1               # |    577,294 |    577,294 |
    ble     $f5, $f1, ble.21692         # |    577,294 |    577,294 |
bg.21686:
    load    [$i2 + 1], $f1              # |    164,980 |    164,980 |
    fmul    $f3, $f1, $f1               # |    164,980 |    164,980 |
    fadd_a  $f1, $f2, $f1               # |    164,980 |    164,980 |
    ble     $f4, $f1, ble.21692         # |    164,980 |    164,980 |
bg.21687:
    load    [$i1 + 5], $f1              # |    127,502 |    127,502 |
    be      $f1, $f0, ble.21692         # |    127,502 |    127,502 |
bne.21688:
    mov     $f3, $fg0                   # |    127,502 |    127,502 |
    li      3, $i1                      # |    127,502 |    127,502 |
    ret                                 # |    127,502 |    127,502 |
bne.21684:
    mov     $f7, $fg0                   # |    227,327 |    227,327 |
    li      2, $i1                      # |    227,327 |    227,327 |
    ret                                 # |    227,327 |    227,327 |
bne.21680:
    mov     $f6, $fg0                   # |    329,995 |    329,995 |
    li      1, $i1                      # |    329,995 |    329,995 |
    ret                                 # |    329,995 |    329,995 |
bne.21677:
    bne     $i6, 2, bne.21689
be.21689:
    load    [$i1 + 0], $f1
    ble     $f0, $f1, ble.21692
bg.21690:
    load    [$i4 + 3], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.21689:
    load    [$i1 + 0], $f4
    be      $f4, $f0, ble.21692
bne.21691:
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
    bg      $f2, $f0, bg.21692
ble.21692:
    li      0, $i1                      # |    449,792 |    449,792 |
    ret                                 # |    449,792 |    449,792 |
bg.21692:
    load    [$i3 + 6], $i2
    fsqrt   $f2, $f2
    bne     $i2, 0, bne.21693
be.21693:
    fsub    $f1, $f2, $f1
    load    [$i1 + 4], $f2
    fmul    $f1, $f2, $fg0
    li      1, $i1
    ret     
bne.21693:
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
    bne     $f1, $f0, bne.21694         # |      3,612 |      3,612 |
be.21694:
    store   $f0, [$i1 + 1]
    load    [$i4 + 1], $f1
    be      $f1, $f0, be.21699
.count dual_jmp
    b       bne.21699
bne.21694:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.21695          # |      3,612 |      3,612 |
ble.21695:
    li      0, $i3                      # |      1,806 |      1,806 |
    be      $i2, 0, be.21696            # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21696
bg.21695:
    li      1, $i3                      # |      1,806 |      1,806 |
    bne     $i2, 0, bne.21696           # |      1,806 |      1,806 |
be.21696:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    load    [$i3 + 0], $f1              # |      3,612 |      3,612 |
    bne     $i2, 0, bne.21698           # |      3,612 |      3,612 |
be.21698:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.21699          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21699                   # |      1,806 |      1,806 |
bne.21698:
    store   $f1, [$i1 + 0]              # |      1,806 |      1,806 |
    load    [$i4 + 0], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 1]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.21699          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21699                   # |      1,806 |      1,806 |
bne.21696:
    bne     $i3, 0, bne.21697
be.21697:
    li      1, $i2
    load    [$i5 + 4], $i3
    load    [$i3 + 0], $f1
    store   $f1, [$i1 + 0]
    load    [$i4 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
    load    [$i4 + 1], $f1
    be      $f1, $f0, be.21699
.count dual_jmp
    b       bne.21699
bne.21697:
    li      0, $i2
    load    [$i5 + 4], $i3
    load    [$i3 + 0], $f1
    fneg    $f1, $f1
    store   $f1, [$i1 + 0]
    load    [$i4 + 0], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 1]
    load    [$i4 + 1], $f1
    bne     $f1, $f0, bne.21699
be.21699:
    store   $f0, [$i1 + 3]
    load    [$i4 + 2], $f1
    be      $f1, $f0, be.21704
.count dual_jmp
    b       bne.21704
bne.21699:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.21700          # |      3,612 |      3,612 |
ble.21700:
    li      0, $i3                      # |      1,806 |      1,806 |
    be      $i2, 0, be.21701            # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21701
bg.21700:
    li      1, $i3                      # |      1,806 |      1,806 |
    bne     $i2, 0, bne.21701           # |      1,806 |      1,806 |
be.21701:
    mov     $i3, $i2                    # |      3,612 |      3,612 |
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    load    [$i3 + 1], $f1              # |      3,612 |      3,612 |
    bne     $i2, 0, bne.21703           # |      3,612 |      3,612 |
be.21703:
    fneg    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.21704          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21704                   # |      1,806 |      1,806 |
bne.21703:
    store   $f1, [$i1 + 2]              # |      1,806 |      1,806 |
    load    [$i4 + 1], $f1              # |      1,806 |      1,806 |
    finv    $f1, $f1                    # |      1,806 |      1,806 |
    store   $f1, [$i1 + 3]              # |      1,806 |      1,806 |
    load    [$i4 + 2], $f1              # |      1,806 |      1,806 |
    be      $f1, $f0, be.21704          # |      1,806 |      1,806 |
.count dual_jmp
    b       bne.21704                   # |      1,806 |      1,806 |
bne.21701:
    bne     $i3, 0, bne.21702
be.21702:
    li      1, $i2
    load    [$i5 + 4], $i3
    load    [$i3 + 1], $f1
    store   $f1, [$i1 + 2]
    load    [$i4 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
    load    [$i4 + 2], $f1
    be      $f1, $f0, be.21704
.count dual_jmp
    b       bne.21704
bne.21702:
    li      0, $i2
    load    [$i5 + 4], $i3
    load    [$i3 + 1], $f1
    fneg    $f1, $f1
    store   $f1, [$i1 + 2]
    load    [$i4 + 1], $f1
    finv    $f1, $f1
    store   $f1, [$i1 + 3]
    load    [$i4 + 2], $f1
    bne     $f1, $f0, bne.21704
be.21704:
    store   $f0, [$i1 + 5]
    jr      $ra1
bne.21704:
    load    [$i5 + 6], $i2              # |      3,612 |      3,612 |
    load    [$i5 + 4], $i3              # |      3,612 |      3,612 |
    bg      $f0, $f1, bg.21705          # |      3,612 |      3,612 |
ble.21705:
    li      0, $i5                      # |      1,812 |      1,812 |
    be      $i2, 0, be.21706            # |      1,812 |      1,812 |
.count dual_jmp
    b       bne.21706
bg.21705:
    li      1, $i5                      # |      1,800 |      1,800 |
    bne     $i2, 0, bne.21706           # |      1,800 |      1,800 |
be.21706:
    mov     $i5, $i2                    # |      3,612 |      3,612 |
    load    [$i3 + 2], $f1              # |      3,612 |      3,612 |
    be      $i2, 0, bne.21707           # |      3,612 |      3,612 |
.count dual_jmp
    b       be.21707                    # |      1,800 |      1,800 |
bne.21706:
    load    [$i3 + 2], $f1
    bne     $i5, 0, bne.21707
be.21707:
    store   $f1, [$i1 + 4]              # |      1,800 |      1,800 |
    load    [$i4 + 2], $f1              # |      1,800 |      1,800 |
    finv    $f1, $f1                    # |      1,800 |      1,800 |
    store   $f1, [$i1 + 5]              # |      1,800 |      1,800 |
    jr      $ra1                        # |      1,800 |      1,800 |
bne.21707:
    fneg    $f1, $f1                    # |      1,812 |      1,812 |
    store   $f1, [$i1 + 4]              # |      1,812 |      1,812 |
    load    [$i4 + 2], $f1              # |      1,812 |      1,812 |
    finv    $f1, $f1                    # |      1,812 |      1,812 |
    store   $f1, [$i1 + 5]              # |      1,812 |      1,812 |
    jr      $ra1                        # |      1,812 |      1,812 |
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
    bg      $f1, $f0, bg.21709          # |      1,204 |      1,204 |
ble.21709:
    store   $f0, [$i1 + 0]              # |        601 |        601 |
    jr      $ra1                        # |        601 |        601 |
bg.21709:
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
    bne     $i2, 0, bne.21710           # |      5,418 |      5,418 |
be.21710:
    mov     $f4, $f1                    # |      5,418 |      5,418 |
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
    be      $i2, 0, be.21711            # |      5,418 |      5,418 |
.count dual_jmp
    b       bne.21711
bne.21710:
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
    store   $f1, [$i1 + 0]
    load    [$i4 + 0], $f2
    load    [$i3 + 0], $f3
    fmul    $f2, $f3, $f2
    load    [$i4 + 1], $f3
    load    [$i3 + 1], $f4
    fmul    $f3, $f4, $f4
    load    [$i4 + 2], $f5
    load    [$i3 + 2], $f6
    fmul    $f5, $f6, $f6
    fneg    $f2, $f2
    fneg    $f4, $f4
    fneg    $f6, $f6
    bne     $i2, 0, bne.21711
be.21711:
    store   $f2, [$i1 + 1]              # |      5,418 |      5,418 |
    store   $f4, [$i1 + 2]              # |      5,418 |      5,418 |
    store   $f6, [$i1 + 3]              # |      5,418 |      5,418 |
    be      $f1, $f0, be.21713          # |      5,418 |      5,418 |
.count dual_jmp
    b       bne.21713                   # |      5,418 |      5,418 |
bne.21711:
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
    bne     $f1, $f0, bne.21713
be.21713:
    jr      $ra1
bne.21713:
    finv    $f1, $f1                    # |      5,418 |      5,418 |
    store   $f1, [$i1 + 4]              # |      5,418 |      5,418 |
    jr      $ra1                        # |      5,418 |      5,418 |
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
    bl      $i8, 0, bl.21714            # |     10,836 |     10,836 |
bge.21714:
    load    [$i7 + 1], $i9              # |     10,234 |     10,234 |
    load    [ext_objects + $i8], $i5    # |     10,234 |     10,234 |
    load    [$i5 + 1], $i1              # |     10,234 |     10,234 |
    load    [$i7 + 0], $i4              # |     10,234 |     10,234 |
    bne     $i1, 1, bne.21715           # |     10,234 |     10,234 |
be.21715:
    jal     setup_rect_table.2817, $ra1 # |      3,612 |      3,612 |
.count storer
    add     $i9, $i8, $tmp              # |      3,612 |      3,612 |
    store   $i1, [$tmp + 0]             # |      3,612 |      3,612 |
    add     $i8, -1, $i8                # |      3,612 |      3,612 |
    b       iter_setup_dirvec_constants.2826# |      3,612 |      3,612 |
bne.21715:
    bne     $i1, 2, bne.21716           # |      6,622 |      6,622 |
be.21716:
    jal     setup_surface_table.2820, $ra1# |      1,204 |      1,204 |
.count storer
    add     $i9, $i8, $tmp              # |      1,204 |      1,204 |
    store   $i1, [$tmp + 0]             # |      1,204 |      1,204 |
    add     $i8, -1, $i8                # |      1,204 |      1,204 |
    b       iter_setup_dirvec_constants.2826# |      1,204 |      1,204 |
bne.21716:
    jal     setup_second_table.2823, $ra1# |      5,418 |      5,418 |
.count storer
    add     $i9, $i8, $tmp              # |      5,418 |      5,418 |
    store   $i1, [$tmp + 0]             # |      5,418 |      5,418 |
    add     $i8, -1, $i8                # |      5,418 |      5,418 |
    b       iter_setup_dirvec_constants.2826# |      5,418 |      5,418 |
bl.21714:
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
    add     $ig0, -1, $i8               # |        602 |        602 |
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
    bl      $i1, 0, bl.21717            # |    667,764 |    667,764 |
bge.21717:
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
    bne     $i4, 2, bne.21718           # |    630,666 |    630,666 |
be.21718:
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
    add     $i1, -1, $i1                # |     74,196 |     74,196 |
    b       setup_startp_constants.2831 # |     74,196 |     74,196 |
bne.21718:
    bg      $i4, 2, bg.21719            # |    556,470 |    556,470 |
ble.21719:
    add     $i1, -1, $i1                # |    222,588 |    222,588 |
    b       setup_startp_constants.2831 # |    222,588 |    222,588 |
bg.21719:
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
    bne     $i7, 0, bne.21720           # |    333,882 |    333,882 |
be.21720:
    mov     $f4, $f1                    # |    333,882 |    333,882 |
    be      $i4, 3, be.21721            # |    333,882 |    333,882 |
.count dual_jmp
    b       bne.21721
bne.21720:
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
    bne     $i4, 3, bne.21721
be.21721:
    fsub    $f1, $fc0, $f1              # |    333,882 |    333,882 |
    store   $f1, [$i5 + 3]              # |    333,882 |    333,882 |
    add     $i1, -1, $i1                # |    333,882 |    333,882 |
    b       setup_startp_constants.2831 # |    333,882 |    333,882 |
bne.21721:
    store   $f1, [$i5 + 3]
    add     $i1, -1, $i1
    b       setup_startp_constants.2831
bl.21717:
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
    be      $i2, -1, be.21776           # |  1,716,699 |  1,716,699 |
bne.21722:
    load    [ext_objects + $i2], $i2    # |  1,694,570 |  1,694,570 |
    load    [$i2 + 1], $i4              # |  1,694,570 |  1,694,570 |
    load    [$i2 + 5], $i5              # |  1,694,570 |  1,694,570 |
    load    [$i5 + 0], $f1              # |  1,694,570 |  1,694,570 |
    fsub    $f2, $f1, $f1               # |  1,694,570 |  1,694,570 |
    load    [$i5 + 1], $f5              # |  1,694,570 |  1,694,570 |
    fsub    $f3, $f5, $f5               # |  1,694,570 |  1,694,570 |
    load    [$i5 + 2], $f6              # |  1,694,570 |  1,694,570 |
    fsub    $f4, $f6, $f6               # |  1,694,570 |  1,694,570 |
    bne     $i4, 1, bne.21723           # |  1,694,570 |  1,694,570 |
be.21723:
    load    [$i2 + 4], $i4              # |    716,988 |    716,988 |
    load    [$i4 + 0], $f7              # |    716,988 |    716,988 |
    fabs    $f1, $f1                    # |    716,988 |    716,988 |
    load    [$i2 + 6], $i2              # |    716,988 |    716,988 |
    ble     $f7, $f1, ble.21728         # |    716,988 |    716,988 |
bg.21724:
    load    [$i4 + 1], $f1              # |    518,776 |    518,776 |
    fabs    $f5, $f5                    # |    518,776 |    518,776 |
    ble     $f1, $f5, ble.21728         # |    518,776 |    518,776 |
bg.21726:
    load    [$i4 + 2], $f1              # |    463,456 |    463,456 |
    fabs    $f6, $f5                    # |    463,456 |    463,456 |
    bg      $f1, $f5, bg.21728          # |    463,456 |    463,456 |
ble.21728:
    be      $i2, 0, bne.21738           # |    270,627 |    270,627 |
.count dual_jmp
    b       be.21738
bg.21728:
    bne     $i2, 0, bne.21738           # |    446,361 |    446,361 |
be.21739:
    add     $i1, 1, $i1                 # |    446,361 |    446,361 |
    load    [$i3 + $i1], $i2            # |    446,361 |    446,361 |
    be      $i2, -1, be.21776           # |    446,361 |    446,361 |
.count dual_jmp
    b       bne.21740                   # |    351,842 |    351,842 |
bne.21723:
    bne     $i4, 2, bne.21730           # |    977,582 |    977,582 |
be.21730:
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
    bg      $f0, $f1, bg.21731          # |    460,717 |    460,717 |
ble.21731:
    be      $i4, 0, bne.21738           # |    460,717 |    460,717 |
.count dual_jmp
    b       be.21738                    # |    460,717 |    460,717 |
bg.21731:
    be      $i4, 0, be.21738
.count dual_jmp
    b       bne.21738
bne.21730:
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
    bne     $i6, 0, bne.21734           # |    516,865 |    516,865 |
be.21734:
    mov     $f7, $f1                    # |    516,865 |    516,865 |
    be      $i4, 3, be.21735            # |    516,865 |    516,865 |
.count dual_jmp
    b       bne.21735
bne.21734:
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
    bne     $i4, 3, bne.21735
be.21735:
    fsub    $f1, $fc0, $f1              # |    516,865 |    516,865 |
    ble     $f0, $f1, ble.21736         # |    516,865 |    516,865 |
.count dual_jmp
    b       bg.21736                    # |    332,169 |    332,169 |
bne.21735:
    bg      $f0, $f1, bg.21736
ble.21736:
    be      $i5, 0, bne.21738           # |    184,696 |    184,696 |
.count dual_jmp
    b       be.21738
bg.21736:
    bne     $i5, 0, bne.21738           # |    332,169 |    332,169 |
be.21738:
    li      0, $i2                      # |    792,886 |    792,886 |
    add     $i1, 1, $i1                 # |    792,886 |    792,886 |
    load    [$i3 + $i1], $i2            # |    792,886 |    792,886 |
    be      $i2, -1, be.21776           # |    792,886 |    792,886 |
bne.21740:
    load    [ext_objects + $i2], $i2    # |    642,309 |    642,309 |
    load    [$i2 + 5], $i4              # |    642,309 |    642,309 |
    load    [$i2 + 1], $i5              # |    642,309 |    642,309 |
    load    [$i4 + 0], $f1              # |    642,309 |    642,309 |
    fsub    $f2, $f1, $f1               # |    642,309 |    642,309 |
    load    [$i4 + 1], $f5              # |    642,309 |    642,309 |
    fsub    $f3, $f5, $f5               # |    642,309 |    642,309 |
    load    [$i4 + 2], $f6              # |    642,309 |    642,309 |
    fsub    $f4, $f6, $f6               # |    642,309 |    642,309 |
    bne     $i5, 1, bne.21741           # |    642,309 |    642,309 |
be.21741:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    load    [$i2 + 6], $i2
    ble     $f7, $f1, ble.21746
bg.21742:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    ble     $f1, $f5, ble.21746
bg.21744:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, bg.21746
ble.21746:
    be      $i2, 0, bne.21738
.count dual_jmp
    b       be.21756
bg.21746:
    bne     $i2, 0, bne.21738
be.21757:
    add     $i1, 1, $i1
    load    [$i3 + $i1], $i2
    be      $i2, -1, be.21776
.count dual_jmp
    b       bne.21758
bne.21741:
    load    [$i2 + 6], $i4              # |    642,309 |    642,309 |
    bne     $i5, 2, bne.21748           # |    642,309 |    642,309 |
be.21748:
    load    [$i2 + 4], $i2              # |     31,832 |     31,832 |
    load    [$i2 + 0], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f1, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 1], $f7              # |     31,832 |     31,832 |
    fmul    $f7, $f5, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    load    [$i2 + 2], $f5              # |     31,832 |     31,832 |
    fmul    $f5, $f6, $f5               # |     31,832 |     31,832 |
    fadd    $f1, $f5, $f1               # |     31,832 |     31,832 |
    ble     $f0, $f1, ble.21754         # |     31,832 |     31,832 |
.count dual_jmp
    b       bg.21754                    # |     11,408 |     11,408 |
bne.21748:
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
    bne     $i7, 0, bne.21752           # |    610,477 |    610,477 |
be.21752:
    mov     $f7, $f1                    # |    610,477 |    610,477 |
    be      $i5, 3, be.21753            # |    610,477 |    610,477 |
.count dual_jmp
    b       bne.21753
bne.21752:
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
    bne     $i5, 3, bne.21753
be.21753:
    fsub    $f1, $fc0, $f1              # |    610,477 |    610,477 |
    ble     $f0, $f1, ble.21754         # |    610,477 |    610,477 |
.count dual_jmp
    b       bg.21754                    # |    310,524 |    310,524 |
bne.21753:
    bg      $f0, $f1, bg.21754
ble.21754:
    be      $i4, 0, bne.21738           # |    320,377 |    320,377 |
.count dual_jmp
    b       be.21756                    # |    211,996 |    211,996 |
bg.21754:
    bne     $i4, 0, bne.21738           # |    321,932 |    321,932 |
be.21756:
    li      0, $i2                      # |    455,457 |    455,457 |
    add     $i1, 1, $i1                 # |    455,457 |    455,457 |
    load    [$i3 + $i1], $i2            # |    455,457 |    455,457 |
    be      $i2, -1, be.21776           # |    455,457 |    455,457 |
bne.21758:
    load    [ext_objects + $i2], $i2    # |    235,790 |    235,790 |
    load    [$i2 + 1], $i4              # |    235,790 |    235,790 |
    load    [$i2 + 5], $i5              # |    235,790 |    235,790 |
    load    [$i5 + 0], $f1              # |    235,790 |    235,790 |
    fsub    $f2, $f1, $f1               # |    235,790 |    235,790 |
    load    [$i5 + 1], $f5              # |    235,790 |    235,790 |
    fsub    $f3, $f5, $f5               # |    235,790 |    235,790 |
    load    [$i5 + 2], $f6              # |    235,790 |    235,790 |
    fsub    $f4, $f6, $f6               # |    235,790 |    235,790 |
    bne     $i4, 1, bne.21759           # |    235,790 |    235,790 |
be.21759:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    load    [$i2 + 6], $i2
    ble     $f7, $f1, ble.21764
bg.21760:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    ble     $f1, $f5, ble.21764
bg.21762:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, bg.21764
ble.21764:
    be      $i2, 0, bne.21738
.count dual_jmp
    b       be.21774
bg.21764:
    bne     $i2, 0, bne.21738
be.21775:
    add     $i1, 1, $i1
    load    [$i3 + $i1], $i2
    be      $i2, -1, be.21776
.count dual_jmp
    b       bne.21776
bne.21759:
    bne     $i4, 2, bne.21766           # |    235,790 |    235,790 |
be.21766:
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
    bg      $f0, $f1, bg.21767          # |     46,329 |     46,329 |
ble.21767:
    be      $i4, 0, bne.21738           # |     26,054 |     26,054 |
.count dual_jmp
    b       be.21774                    # |     26,054 |     26,054 |
bg.21767:
    be      $i4, 0, be.21774            # |     20,275 |     20,275 |
.count dual_jmp
    b       bne.21738                   # |     20,275 |     20,275 |
bne.21766:
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
    bne     $i6, 0, bne.21770           # |    189,461 |    189,461 |
be.21770:
    mov     $f7, $f1                    # |    189,461 |    189,461 |
    be      $i4, 3, be.21771            # |    189,461 |    189,461 |
.count dual_jmp
    b       bne.21771
bne.21770:
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
    bne     $i4, 3, bne.21771
be.21771:
    fsub    $f1, $fc0, $f1              # |    189,461 |    189,461 |
    ble     $f0, $f1, ble.21772         # |    189,461 |    189,461 |
.count dual_jmp
    b       bg.21772                    # |     36,240 |     36,240 |
bne.21771:
    bg      $f0, $f1, bg.21772
ble.21772:
    be      $i5, 0, bne.21738           # |    153,221 |    153,221 |
.count dual_jmp
    b       be.21774                    # |    153,221 |    153,221 |
bg.21772:
    bne     $i5, 0, bne.21738           # |     36,240 |     36,240 |
be.21774:
    li      0, $i2                      # |    179,275 |    179,275 |
    add     $i1, 1, $i1                 # |    179,275 |    179,275 |
    load    [$i3 + $i1], $i2            # |    179,275 |    179,275 |
    bne     $i2, -1, bne.21776          # |    179,275 |    179,275 |
be.21776:
    li      1, $i1                      # |  1,018,009 |  1,018,009 |
    ret                                 # |  1,018,009 |  1,018,009 |
bne.21776:
    load    [ext_objects + $i2], $i2
    load    [$i2 + 5], $i4
    load    [$i2 + 1], $i5
    load    [$i4 + 0], $f1
    load    [$i4 + 1], $f5
    load    [$i4 + 2], $f6
    fsub    $f2, $f1, $f1
    fsub    $f3, $f5, $f5
    fsub    $f4, $f6, $f6
    bne     $i5, 1, bne.21777
be.21777:
    load    [$i2 + 4], $i4
    load    [$i4 + 0], $f7
    fabs    $f1, $f1
    ble     $f7, $f1, ble.21780
bg.21778:
    load    [$i4 + 1], $f1
    fabs    $f5, $f5
    ble     $f1, $f5, ble.21780
bg.21779:
    load    [$i4 + 2], $f1
    fabs    $f6, $f5
    bg      $f1, $f5, bg.21780
ble.21780:
    load    [$i2 + 6], $i2
    be      $i2, 0, bne.21738
.count dual_jmp
    b       be.21792
bg.21780:
    load    [$i2 + 6], $i2
    be      $i2, 0, be.21792
.count dual_jmp
    b       bne.21738
bne.21777:
    load    [$i2 + 6], $i4
    bne     $i5, 2, bne.21784
be.21784:
    load    [$i2 + 4], $i2
    load    [$i2 + 0], $f7
    fmul    $f7, $f1, $f1
    load    [$i2 + 1], $f7
    fmul    $f7, $f5, $f5
    fadd    $f1, $f5, $f1
    load    [$i2 + 2], $f5
    fmul    $f5, $f6, $f5
    fadd    $f1, $f5, $f1
    ble     $f0, $f1, ble.21790
.count dual_jmp
    b       bg.21790
bne.21784:
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
    bne     $i7, 0, bne.21788
be.21788:
    mov     $f7, $f1
    be      $i5, 3, be.21789
.count dual_jmp
    b       bne.21789
bne.21788:
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
    bne     $i5, 3, bne.21789
be.21789:
    fsub    $f1, $fc0, $f1
    ble     $f0, $f1, ble.21790
.count dual_jmp
    b       bg.21790
bne.21789:
    bg      $f0, $f1, bg.21790
ble.21790:
    be      $i4, 0, bne.21738
.count dual_jmp
    b       be.21792
bg.21790:
    bne     $i4, 0, bne.21738
be.21792:
    add     $i1, 1, $i1
    b       check_all_inside.2856
bne.21738:
    li      0, $i1                      # |    698,690 |    698,690 |
    ret                                 # |    698,690 |    698,690 |
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
    be      $i1, -1, be.21816           # |  4,223,804 |  4,223,804 |
bne.21793:
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
    bne     $i5, 1, bne.21794           # |  3,595,854 |  3,595,854 |
be.21794:
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
    ble     $f4, $f5, be.21797          # |  1,410,052 |  1,410,052 |
bg.21795:
    load    [$i2 + 2], $f4              # |    411,504 |    411,504 |
    load    [$i4 + 2], $f5              # |    411,504 |    411,504 |
    fmul    $f6, $f5, $f5               # |    411,504 |    411,504 |
    fadd_a  $f5, $f3, $f5               # |    411,504 |    411,504 |
    ble     $f4, $f5, be.21797          # |    411,504 |    411,504 |
bg.21796:
    load    [$i3 + 1], $f4              # |    275,106 |    275,106 |
    bne     $f4, $f0, bne.21797         # |    275,106 |    275,106 |
be.21797:
    load    [$i2 + 0], $f4              # |  1,134,946 |  1,134,946 |
    load    [$i4 + 0], $f5              # |  1,134,946 |  1,134,946 |
    load    [$i3 + 2], $f6              # |  1,134,946 |  1,134,946 |
    fsub    $f6, $f2, $f6               # |  1,134,946 |  1,134,946 |
    load    [$i3 + 3], $f7              # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f7, $f6               # |  1,134,946 |  1,134,946 |
    fmul    $f6, $f5, $f5               # |  1,134,946 |  1,134,946 |
    fadd_a  $f5, $f1, $f5               # |  1,134,946 |  1,134,946 |
    ble     $f4, $f5, be.21801          # |  1,134,946 |  1,134,946 |
bg.21799:
    load    [$i2 + 2], $f4              # |    502,266 |    502,266 |
    load    [$i4 + 2], $f5              # |    502,266 |    502,266 |
    fmul    $f6, $f5, $f5               # |    502,266 |    502,266 |
    fadd_a  $f5, $f3, $f5               # |    502,266 |    502,266 |
    ble     $f4, $f5, be.21801          # |    502,266 |    502,266 |
bg.21800:
    load    [$i3 + 3], $f4              # |    363,230 |    363,230 |
    bne     $f4, $f0, bne.21797         # |    363,230 |    363,230 |
be.21801:
    load    [$i2 + 0], $f4              # |    771,716 |    771,716 |
    load    [$i4 + 0], $f5              # |    771,716 |    771,716 |
    load    [$i3 + 4], $f6              # |    771,716 |    771,716 |
    fsub    $f6, $f3, $f3               # |    771,716 |    771,716 |
    load    [$i3 + 5], $f6              # |    771,716 |    771,716 |
    fmul    $f3, $f6, $f3               # |    771,716 |    771,716 |
    fmul    $f3, $f5, $f5               # |    771,716 |    771,716 |
    fadd_a  $f5, $f1, $f1               # |    771,716 |    771,716 |
    ble     $f4, $f1, ble.21814         # |    771,716 |    771,716 |
bg.21803:
    load    [$i2 + 1], $f1              # |    129,341 |    129,341 |
    load    [$i4 + 1], $f4              # |    129,341 |    129,341 |
    fmul    $f3, $f4, $f4               # |    129,341 |    129,341 |
    fadd_a  $f4, $f2, $f2               # |    129,341 |    129,341 |
    ble     $f1, $f2, ble.21814         # |    129,341 |    129,341 |
bg.21804:
    load    [$i3 + 5], $f1              # |     50,883 |     50,883 |
    be      $f1, $f0, ble.21814         # |     50,883 |     50,883 |
bne.21805:
    mov     $f3, $fg0                   # |     50,883 |     50,883 |
.count load_float
    load    [f.21525], $f1              # |     50,883 |     50,883 |
    ble     $f1, $fg0, ble.21814        # |     50,883 |     50,883 |
.count dual_jmp
    b       bg.21814                    # |     46,385 |     46,385 |
bne.21797:
    mov     $f6, $fg0                   # |    638,336 |    638,336 |
.count load_float
    load    [f.21525], $f1              # |    638,336 |    638,336 |
    ble     $f1, $fg0, ble.21814        # |    638,336 |    638,336 |
.count dual_jmp
    b       bg.21814                    # |    285,773 |    285,773 |
bne.21794:
    load    [$i3 + 0], $f4              # |  2,185,802 |  2,185,802 |
    bne     $i5, 2, bne.21806           # |  2,185,802 |  2,185,802 |
be.21806:
    ble     $f0, $f4, ble.21814         # |    566,304 |    566,304 |
bg.21807:
    load    [$i3 + 1], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f1, $f1               # |    554,887 |    554,887 |
    load    [$i3 + 2], $f4              # |    554,887 |    554,887 |
    fmul    $f4, $f2, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $f1               # |    554,887 |    554,887 |
    load    [$i3 + 3], $f2              # |    554,887 |    554,887 |
    fmul    $f2, $f3, $f2               # |    554,887 |    554,887 |
    fadd    $f1, $f2, $fg0              # |    554,887 |    554,887 |
.count load_float
    load    [f.21525], $f1              # |    554,887 |    554,887 |
    ble     $f1, $fg0, ble.21814        # |    554,887 |    554,887 |
.count dual_jmp
    b       bg.21814
bne.21806:
    be      $f4, $f0, ble.21814         # |  1,619,498 |  1,619,498 |
bne.21808:
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
    bne     $i4, 0, bne.21809           # |  1,619,498 |  1,619,498 |
be.21809:
    mov     $f7, $f1                    # |  1,619,498 |  1,619,498 |
    be      $i5, 3, be.21810            # |  1,619,498 |  1,619,498 |
.count dual_jmp
    b       bne.21810
bne.21809:
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
    bne     $i5, 3, bne.21810
be.21810:
    fsub    $f1, $fc0, $f1              # |  1,619,498 |  1,619,498 |
    fmul    $f4, $f1, $f1               # |  1,619,498 |  1,619,498 |
    fsub    $f6, $f1, $f1               # |  1,619,498 |  1,619,498 |
    ble     $f1, $f0, ble.21814         # |  1,619,498 |  1,619,498 |
.count dual_jmp
    b       bg.21811                    # |    348,984 |    348,984 |
bne.21810:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, ble.21814
bg.21811:
    load    [$i2 + 6], $i2              # |    348,984 |    348,984 |
    load    [$i3 + 4], $f2              # |    348,984 |    348,984 |
    fsqrt   $f1, $f1                    # |    348,984 |    348,984 |
    bne     $i2, 0, bne.21812           # |    348,984 |    348,984 |
be.21812:
    fsub    $f5, $f1, $f1               # |    278,797 |    278,797 |
    fmul    $f1, $f2, $fg0              # |    278,797 |    278,797 |
.count load_float
    load    [f.21525], $f1              # |    278,797 |    278,797 |
    ble     $f1, $fg0, ble.21814        # |    278,797 |    278,797 |
.count dual_jmp
    b       bg.21814                    # |    218,864 |    218,864 |
bne.21812:
    fadd    $f5, $f1, $f1               # |     70,187 |     70,187 |
    fmul    $f1, $f2, $fg0              # |     70,187 |     70,187 |
.count load_float
    load    [f.21525], $f1              # |     70,187 |     70,187 |
    bg      $f1, $fg0, bg.21814         # |     70,187 |     70,187 |
ble.21814:
    load    [ext_objects + $i1], $i1    # |  3,032,162 |  3,032,162 |
    load    [$i1 + 6], $i1              # |  3,032,162 |  3,032,162 |
    bne     $i1, 0, bne.21833           # |  3,032,162 |  3,032,162 |
be.21816:
    li      0, $i1                      # |  3,034,214 |  3,034,214 |
    jr      $ra1                        # |  3,034,214 |  3,034,214 |
bg.21814:
    li      1, $i2                      # |    563,692 |    563,692 |
    load    [$i9 + 0], $i1              # |    563,692 |    563,692 |
    be      $i1, -1, bne.21835          # |    563,692 |    563,692 |
bne.21817:
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
    bne     $i3, 1, bne.21818           # |    563,692 |    563,692 |
be.21818:
    load    [$i1 + 4], $i2              # |    541,977 |    541,977 |
    load    [$i2 + 0], $f4              # |    541,977 |    541,977 |
    fabs    $f1, $f1                    # |    541,977 |    541,977 |
    load    [$i1 + 6], $i1              # |    541,977 |    541,977 |
    ble     $f4, $f1, ble.21823         # |    541,977 |    541,977 |
bg.21819:
    load    [$i2 + 1], $f1              # |    485,570 |    485,570 |
    fabs    $f3, $f3                    # |    485,570 |    485,570 |
    ble     $f1, $f3, ble.21823         # |    485,570 |    485,570 |
bg.21821:
    load    [$i2 + 2], $f1              # |    479,961 |    479,961 |
    fabs    $f2, $f2                    # |    479,961 |    479,961 |
    bg      $f1, $f2, bg.21823          # |    479,961 |    479,961 |
ble.21823:
    be      $i1, 0, bne.21833           # |     64,229 |     64,229 |
.count dual_jmp
    b       be.21833
bg.21823:
    be      $i1, 0, be.21833            # |    477,748 |    477,748 |
.count dual_jmp
    b       bne.21833
bne.21818:
    load    [$i1 + 6], $i2              # |     21,715 |     21,715 |
    bne     $i3, 2, bne.21825           # |     21,715 |     21,715 |
be.21825:
    load    [$i1 + 4], $i1
    load    [$i1 + 0], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 1], $f4
    fmul    $f4, $f3, $f3
    fadd    $f1, $f3, $f1
    load    [$i1 + 2], $f3
    fmul    $f3, $f2, $f2
    fadd    $f1, $f2, $f1
    ble     $f0, $f1, ble.21831
.count dual_jmp
    b       bg.21831
bne.21825:
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
    bne     $i4, 0, bne.21829           # |     21,715 |     21,715 |
be.21829:
    mov     $f4, $f1                    # |     21,715 |     21,715 |
    be      $i3, 3, be.21830            # |     21,715 |     21,715 |
.count dual_jmp
    b       bne.21830
bne.21829:
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
    bne     $i3, 3, bne.21830
be.21830:
    fsub    $f1, $fc0, $f1              # |     21,715 |     21,715 |
    ble     $f0, $f1, ble.21831         # |     21,715 |     21,715 |
.count dual_jmp
    b       bg.21831                    # |     21,715 |     21,715 |
bne.21830:
    bg      $f0, $f1, bg.21831
ble.21831:
    be      $i2, 0, bne.21833
.count dual_jmp
    b       be.21833
bg.21831:
    bne     $i2, 0, bne.21833           # |     21,715 |     21,715 |
be.21833:
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
    bne     $i1, 0, bne.21835           # |    499,463 |    499,463 |
bne.21833:
    add     $i8, 1, $i8                 # |    953,293 |    953,293 |
    b       shadow_check_and_group.2862 # |    953,293 |    953,293 |
bne.21835:
    li      1, $i1                      # |    236,297 |    236,297 |
    jr      $ra1                        # |    236,297 |    236,297 |
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
    be      $i1, -1, be.21850           # |    223,695 |    223,695 |
bne.21836:
    li      0, $i8                      # |    223,695 |    223,695 |
    load    [ext_and_net + $i1], $i9    # |    223,695 |    223,695 |
    jal     shadow_check_and_group.2862, $ra1# |    223,695 |    223,695 |
    bne     $i1, 0, bne.21837           # |    223,695 |    223,695 |
be.21837:
    add     $i10, 1, $i10               # |    113,433 |    113,433 |
    load    [$i11 + $i10], $i1          # |    113,433 |    113,433 |
    be      $i1, -1, be.21850           # |    113,433 |    113,433 |
bne.21838:
    li      0, $i8                      # |    113,433 |    113,433 |
    load    [ext_and_net + $i1], $i9    # |    113,433 |    113,433 |
    jal     shadow_check_and_group.2862, $ra1# |    113,433 |    113,433 |
    bne     $i1, 0, bne.21837           # |    113,433 |    113,433 |
be.21839:
    add     $i10, 1, $i10               # |    106,783 |    106,783 |
    load    [$i11 + $i10], $i1          # |    106,783 |    106,783 |
    be      $i1, -1, be.21850           # |    106,783 |    106,783 |
bne.21840:
    li      0, $i8                      # |     96,452 |     96,452 |
    load    [ext_and_net + $i1], $i9    # |     96,452 |     96,452 |
    jal     shadow_check_and_group.2862, $ra1# |     96,452 |     96,452 |
    bne     $i1, 0, bne.21837           # |     96,452 |     96,452 |
be.21841:
    add     $i10, 1, $i10               # |     94,280 |     94,280 |
    load    [$i11 + $i10], $i1          # |     94,280 |     94,280 |
    be      $i1, -1, be.21850           # |     94,280 |     94,280 |
bne.21842:
    li      0, $i8                      # |     94,280 |     94,280 |
    load    [ext_and_net + $i1], $i9    # |     94,280 |     94,280 |
    jal     shadow_check_and_group.2862, $ra1# |     94,280 |     94,280 |
    bne     $i1, 0, bne.21837           # |     94,280 |     94,280 |
be.21843:
    add     $i10, 1, $i10               # |     82,752 |     82,752 |
    load    [$i11 + $i10], $i1          # |     82,752 |     82,752 |
    be      $i1, -1, be.21850           # |     82,752 |     82,752 |
bne.21844:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21837
be.21845:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    be      $i1, -1, be.21850
bne.21846:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21837
be.21847:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    be      $i1, -1, be.21850
bne.21848:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21837
be.21849:
    add     $i10, 1, $i10
    load    [$i11 + $i10], $i1
    bne     $i1, -1, bne.21850
be.21850:
    li      0, $i1                      # |     93,083 |     93,083 |
    jr      $ra2                        # |     93,083 |     93,083 |
bne.21850:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21837
be.21851:
    add     $i10, 1, $i10
    b       shadow_check_one_or_group.2865
bne.21837:
    li      1, $i1                      # |    130,612 |    130,612 |
    jr      $ra2                        # |    130,612 |    130,612 |
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
    be      $i1, -1, be.21909           # |    565,218 |    565,218 |
bne.21852:
    be      $i1, 99, bne.21876          # |    554,887 |    554,887 |
bne.21853:
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
    bne     $i3, 1, bne.21854           # |     10,331 |     10,331 |
be.21854:
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
    ble     $f4, $f5, be.21857          # |     10,331 |     10,331 |
bg.21855:
    load    [$i2 + 2], $f4              # |      3,872 |      3,872 |
    load    [$i3 + 2], $f5              # |      3,872 |      3,872 |
    fmul    $f6, $f5, $f5               # |      3,872 |      3,872 |
    fadd_a  $f5, $f3, $f5               # |      3,872 |      3,872 |
    ble     $f4, $f5, be.21857          # |      3,872 |      3,872 |
bg.21856:
    load    [$i1 + 1], $f4
    bne     $f4, $f0, bne.21857
be.21857:
    load    [$i2 + 0], $f4              # |     10,331 |     10,331 |
    load    [$i3 + 0], $f5              # |     10,331 |     10,331 |
    load    [$i1 + 2], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f2, $f6               # |     10,331 |     10,331 |
    load    [$i1 + 3], $f7              # |     10,331 |     10,331 |
    fmul    $f6, $f7, $f6               # |     10,331 |     10,331 |
    fmul    $f6, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f5               # |     10,331 |     10,331 |
    ble     $f4, $f5, be.21861          # |     10,331 |     10,331 |
bg.21859:
    load    [$i2 + 2], $f4              # |      1,255 |      1,255 |
    load    [$i3 + 2], $f5              # |      1,255 |      1,255 |
    fmul    $f6, $f5, $f5               # |      1,255 |      1,255 |
    fadd_a  $f5, $f3, $f5               # |      1,255 |      1,255 |
    ble     $f4, $f5, be.21861          # |      1,255 |      1,255 |
bg.21860:
    load    [$i1 + 3], $f4
    bne     $f4, $f0, bne.21861
be.21861:
    load    [$i2 + 0], $f4              # |     10,331 |     10,331 |
    load    [$i3 + 0], $f5              # |     10,331 |     10,331 |
    load    [$i1 + 4], $f6              # |     10,331 |     10,331 |
    fsub    $f6, $f3, $f3               # |     10,331 |     10,331 |
    load    [$i1 + 5], $f6              # |     10,331 |     10,331 |
    fmul    $f3, $f6, $f3               # |     10,331 |     10,331 |
    fmul    $f3, $f5, $f5               # |     10,331 |     10,331 |
    fadd_a  $f5, $f1, $f1               # |     10,331 |     10,331 |
    ble     $f4, $f1, be.21906          # |     10,331 |     10,331 |
bg.21863:
    load    [$i2 + 1], $f1
    load    [$i3 + 1], $f4
    fmul    $f3, $f4, $f4
    fadd_a  $f4, $f2, $f2
    ble     $f1, $f2, be.21906
bg.21864:
    load    [$i1 + 5], $f1
    be      $f1, $f0, be.21906
bne.21865:
    mov     $f3, $fg0
    li      3, $i1
    ble     $fc7, $fg0, be.21906
.count dual_jmp
    b       bg.21874
bne.21861:
    mov     $f6, $fg0
    li      2, $i1
    ble     $fc7, $fg0, be.21906
.count dual_jmp
    b       bg.21874
bne.21857:
    mov     $f6, $fg0
    li      1, $i1
    ble     $fc7, $fg0, be.21906
.count dual_jmp
    b       bg.21874
bne.21854:
    load    [$i1 + 0], $f4
    bne     $i3, 2, bne.21866
be.21866:
    ble     $f0, $f4, be.21906
bg.21867:
    load    [$i1 + 1], $f4
    fmul    $f4, $f1, $f1
    load    [$i1 + 2], $f4
    fmul    $f4, $f2, $f2
    fadd    $f1, $f2, $f1
    load    [$i1 + 3], $f2
    fmul    $f2, $f3, $f2
    fadd    $f1, $f2, $fg0
    li      1, $i1
    ble     $fc7, $fg0, be.21906
.count dual_jmp
    b       bg.21874
bne.21866:
    be      $f4, $f0, be.21906
bne.21868:
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
    bne     $i4, 0, bne.21869
be.21869:
    mov     $f7, $f1
    be      $i3, 3, be.21870
.count dual_jmp
    b       bne.21870
bne.21869:
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
    bne     $i3, 3, bne.21870
be.21870:
    fsub    $f1, $fc0, $f1
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, be.21906
.count dual_jmp
    b       bg.21871
bne.21870:
    fmul    $f4, $f1, $f1
    fsub    $f6, $f1, $f1
    ble     $f1, $f0, be.21906
bg.21871:
    load    [$i2 + 6], $i2
    load    [$i1 + 4], $f2
    li      1, $i1
    fsqrt   $f1, $f1
    bne     $i2, 0, bne.21872
be.21872:
    fsub    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    be      $i1, 0, be.21906
.count dual_jmp
    b       bne.21873
bne.21872:
    fadd    $f5, $f1, $f1
    fmul    $f1, $f2, $fg0
    be      $i1, 0, be.21906
bne.21873:
    ble     $fc7, $fg0, be.21906
bg.21874:
    load    [$i14 + 1], $i1
    be      $i1, -1, be.21906
bne.21875:
    load    [ext_and_net + $i1], $i9
    li      0, $i8
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21876
be.21876:
    li      2, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.21906
bne.21876:
    li      1, $i1                      # |    544,556 |    544,556 |
    load    [$i14 + 1], $i1             # |    544,556 |    544,556 |
    be      $i1, -1, be.21906           # |    544,556 |    544,556 |
bne.21894:
    load    [ext_and_net + $i1], $i9    # |    544,556 |    544,556 |
    li      0, $i8                      # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, bne.21895           # |    544,556 |    544,556 |
be.21895:
    load    [$i14 + 2], $i1             # |    544,556 |    544,556 |
    be      $i1, -1, be.21906           # |    544,556 |    544,556 |
bne.21896:
    li      0, $i8                      # |    544,556 |    544,556 |
    load    [ext_and_net + $i1], $i9    # |    544,556 |    544,556 |
    jal     shadow_check_and_group.2862, $ra1# |    544,556 |    544,556 |
    bne     $i1, 0, bne.21895           # |    544,556 |    544,556 |
be.21897:
    load    [$i14 + 3], $i1             # |    542,972 |    542,972 |
    be      $i1, -1, be.21906           # |    542,972 |    542,972 |
bne.21898:
    li      0, $i8                      # |    542,972 |    542,972 |
    load    [ext_and_net + $i1], $i9    # |    542,972 |    542,972 |
    jal     shadow_check_and_group.2862, $ra1# |    542,972 |    542,972 |
    bne     $i1, 0, bne.21895           # |    542,972 |    542,972 |
be.21899:
    load    [$i14 + 4], $i1             # |    541,019 |    541,019 |
    be      $i1, -1, be.21906           # |    541,019 |    541,019 |
bne.21900:
    li      0, $i8                      # |    541,019 |    541,019 |
    load    [ext_and_net + $i1], $i9    # |    541,019 |    541,019 |
    jal     shadow_check_and_group.2862, $ra1# |    541,019 |    541,019 |
    bne     $i1, 0, bne.21895           # |    541,019 |    541,019 |
be.21901:
    load    [$i14 + 5], $i1             # |    540,605 |    540,605 |
    be      $i1, -1, be.21906           # |    540,605 |    540,605 |
bne.21902:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21895
be.21903:
    load    [$i14 + 6], $i1
    be      $i1, -1, be.21906
bne.21904:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21895
be.21905:
    load    [$i14 + 7], $i1
    bne     $i1, -1, bne.21906
be.21906:
    li      0, $i1                      # |    550,936 |    550,936 |
    add     $i12, 1, $i12               # |    550,936 |    550,936 |
    load    [$i13 + $i12], $i14         # |    550,936 |    550,936 |
    load    [$i14 + 0], $i1             # |    550,936 |    550,936 |
    be      $i1, -1, be.21909           # |    550,936 |    550,936 |
.count dual_jmp
    b       bne.21909                   # |     10,331 |     10,331 |
bne.21906:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21895
be.21907:
    li      8, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    bne     $i1, 0, bne.21895
be.21908:
    add     $i12, 1, $i12
    load    [$i13 + $i12], $i14
    load    [$i14 + 0], $i1
    bne     $i1, -1, bne.21909
be.21909:
    li      0, $i1                      # |    550,936 |    550,936 |
    jr      $ra3                        # |    550,936 |    550,936 |
bne.21909:
    be      $i1, 99, bne.21914          # |     10,331 |     10,331 |
bne.21910:
    call    solver_fast.2796
    be      $i1, 0, be.21913
bne.21911:
    ble     $fc7, $fg0, be.21913
bg.21912:
    load    [$i14 + 1], $i1
    be      $i1, -1, be.21913
bne.21913:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21914
be.21914:
    load    [$i14 + 2], $i1
    be      $i1, -1, be.21913
bne.21915:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
    jal     shadow_check_and_group.2862, $ra1
    bne     $i1, 0, bne.21914
be.21916:
    li      3, $i10
.count move_args
    mov     $i14, $i11
    jal     shadow_check_one_or_group.2865, $ra2
    be      $i1, 0, be.21913
bne.21914:
    li      1, $i1                      # |     10,331 |     10,331 |
    load    [$i14 + 1], $i1             # |     10,331 |     10,331 |
    be      $i1, -1, be.21913           # |     10,331 |     10,331 |
bne.21919:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i9    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, bne.21895           # |     10,331 |     10,331 |
be.21920:
    load    [$i14 + 2], $i1             # |     10,331 |     10,331 |
    be      $i1, -1, be.21913           # |     10,331 |     10,331 |
bne.21921:
    li      0, $i8                      # |     10,331 |     10,331 |
    load    [ext_and_net + $i1], $i9    # |     10,331 |     10,331 |
    jal     shadow_check_and_group.2862, $ra1# |     10,331 |     10,331 |
    bne     $i1, 0, bne.21895           # |     10,331 |     10,331 |
be.21922:
    li      3, $i10                     # |     10,331 |     10,331 |
.count move_args
    mov     $i14, $i11                  # |     10,331 |     10,331 |
    jal     shadow_check_one_or_group.2865, $ra2# |     10,331 |     10,331 |
    bne     $i1, 0, bne.21895           # |     10,331 |     10,331 |
be.21913:
    add     $i12, 1, $i12               # |     10,331 |     10,331 |
    b       shadow_check_one_or_matrix.2868# |     10,331 |     10,331 |
bne.21895:
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
    be      $i11, -1, be.21959          # |    193,311 |    193,311 |
bne.21924:
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
    bne     $i3, 1, bne.21925           # |    149,820 |    149,820 |
be.21925:
    be      $f4, $f0, ble.21932         # |     50,858 |     50,858 |
bne.21926:
    load    [$i1 + 4], $i2              # |     50,858 |     50,858 |
    load    [$i1 + 6], $i3              # |     50,858 |     50,858 |
    bg      $f0, $f4, bg.21927          # |     50,858 |     50,858 |
ble.21927:
    li      0, $i4                      # |     50,160 |     50,160 |
    be      $i3, 0, be.21928            # |     50,160 |     50,160 |
.count dual_jmp
    b       bne.21928
bg.21927:
    li      1, $i4                      # |        698 |        698 |
    bne     $i3, 0, bne.21928           # |        698 |        698 |
be.21928:
    mov     $i4, $i3                    # |     50,858 |     50,858 |
    load    [$i2 + 0], $f5              # |     50,858 |     50,858 |
    load    [$i10 + 1], $f6             # |     50,858 |     50,858 |
    finv    $f4, $f4                    # |     50,858 |     50,858 |
    bne     $i3, 0, bne.21930           # |     50,858 |     50,858 |
be.21930:
    fneg    $f5, $f5                    # |     50,160 |     50,160 |
    fsub    $f5, $f1, $f5               # |     50,160 |     50,160 |
    fmul    $f5, $f4, $f4               # |     50,160 |     50,160 |
    load    [$i2 + 1], $f5              # |     50,160 |     50,160 |
    fmul    $f4, $f6, $f6               # |     50,160 |     50,160 |
    fadd_a  $f6, $f2, $f6               # |     50,160 |     50,160 |
    ble     $f5, $f6, ble.21932         # |     50,160 |     50,160 |
.count dual_jmp
    b       bg.21931                    # |      9,639 |      9,639 |
bne.21930:
    fsub    $f5, $f1, $f5               # |        698 |        698 |
    fmul    $f5, $f4, $f4               # |        698 |        698 |
    load    [$i2 + 1], $f5              # |        698 |        698 |
    fmul    $f4, $f6, $f6               # |        698 |        698 |
    fadd_a  $f6, $f2, $f6               # |        698 |        698 |
    ble     $f5, $f6, ble.21932         # |        698 |        698 |
.count dual_jmp
    b       bg.21931                    # |        171 |        171 |
bne.21928:
    load    [$i2 + 0], $f5
    load    [$i10 + 1], $f6
    finv    $f4, $f4
    bne     $i4, 0, bne.21929
be.21929:
    li      1, $i3
    fsub    $f5, $f1, $f5
    fmul    $f5, $f4, $f4
    load    [$i2 + 1], $f5
    fmul    $f4, $f6, $f6
    fadd_a  $f6, $f2, $f6
    ble     $f5, $f6, ble.21932
.count dual_jmp
    b       bg.21931
bne.21929:
    li      0, $i3
    fneg    $f5, $f5
    fsub    $f5, $f1, $f5
    fmul    $f5, $f4, $f4
    load    [$i2 + 1], $f5
    fmul    $f4, $f6, $f6
    fadd_a  $f6, $f2, $f6
    ble     $f5, $f6, ble.21932
bg.21931:
    load    [$i2 + 2], $f5              # |      9,810 |      9,810 |
    load    [$i10 + 2], $f6             # |      9,810 |      9,810 |
    fmul    $f4, $f6, $f6               # |      9,810 |      9,810 |
    fadd_a  $f6, $f3, $f6               # |      9,810 |      9,810 |
    bg      $f5, $f6, bg.21932          # |      9,810 |      9,810 |
ble.21932:
    li      0, $i2                      # |     46,747 |     46,747 |
    load    [$i10 + 1], $f4             # |     46,747 |     46,747 |
    be      $f4, $f0, ble.21940         # |     46,747 |     46,747 |
bne.21934:
    load    [$i1 + 4], $i2              # |     46,747 |     46,747 |
    load    [$i1 + 6], $i3              # |     46,747 |     46,747 |
    bg      $f0, $f4, bg.21935          # |     46,747 |     46,747 |
ble.21935:
    li      0, $i4                      # |        217 |        217 |
    be      $i3, 0, be.21936            # |        217 |        217 |
.count dual_jmp
    b       bne.21936
bg.21935:
    li      1, $i4                      # |     46,530 |     46,530 |
    bne     $i3, 0, bne.21936           # |     46,530 |     46,530 |
be.21936:
    mov     $i4, $i3                    # |     46,747 |     46,747 |
    load    [$i2 + 1], $f5              # |     46,747 |     46,747 |
    load    [$i10 + 2], $f6             # |     46,747 |     46,747 |
    finv    $f4, $f4                    # |     46,747 |     46,747 |
    be      $i3, 0, bne.21937           # |     46,747 |     46,747 |
.count dual_jmp
    b       be.21937                    # |     46,530 |     46,530 |
bne.21936:
    load    [$i2 + 1], $f5
    load    [$i10 + 2], $f6
    finv    $f4, $f4
    bne     $i4, 0, bne.21937
be.21937:
    fsub    $f5, $f2, $f5               # |     46,530 |     46,530 |
    fmul    $f5, $f4, $f4               # |     46,530 |     46,530 |
    load    [$i2 + 2], $f5              # |     46,530 |     46,530 |
    fmul    $f4, $f6, $f6               # |     46,530 |     46,530 |
    fadd_a  $f6, $f3, $f6               # |     46,530 |     46,530 |
    ble     $f5, $f6, ble.21940         # |     46,530 |     46,530 |
.count dual_jmp
    b       bg.21939                    # |     18,436 |     18,436 |
bne.21937:
    fneg    $f5, $f5                    # |        217 |        217 |
    fsub    $f5, $f2, $f5               # |        217 |        217 |
    fmul    $f5, $f4, $f4               # |        217 |        217 |
    load    [$i2 + 2], $f5              # |        217 |        217 |
    fmul    $f4, $f6, $f6               # |        217 |        217 |
    fadd_a  $f6, $f3, $f6               # |        217 |        217 |
    ble     $f5, $f6, ble.21940         # |        217 |        217 |
bg.21939:
    load    [$i2 + 0], $f5              # |     18,536 |     18,536 |
    load    [$i10 + 0], $f6             # |     18,536 |     18,536 |
    fmul    $f4, $f6, $f6               # |     18,536 |     18,536 |
    fadd_a  $f6, $f1, $f6               # |     18,536 |     18,536 |
    bg      $f5, $f6, bg.21940          # |     18,536 |     18,536 |
ble.21940:
    li      0, $i2                      # |     34,667 |     34,667 |
    load    [$i10 + 2], $f4             # |     34,667 |     34,667 |
    be      $f4, $f0, be.21958          # |     34,667 |     34,667 |
bne.21942:
    load    [$i1 + 4], $i2              # |     34,667 |     34,667 |
    load    [$i2 + 0], $f5              # |     34,667 |     34,667 |
    load    [$i10 + 0], $f6             # |     34,667 |     34,667 |
    load    [$i1 + 6], $i1              # |     34,667 |     34,667 |
    bg      $f0, $f4, bg.21943          # |     34,667 |     34,667 |
ble.21943:
    li      0, $i3                      # |     24,683 |     24,683 |
    be      $i1, 0, be.21944            # |     24,683 |     24,683 |
.count dual_jmp
    b       bne.21944
bg.21943:
    li      1, $i3                      # |      9,984 |      9,984 |
    bne     $i1, 0, bne.21944           # |      9,984 |      9,984 |
be.21944:
    mov     $i3, $i1                    # |     34,667 |     34,667 |
    load    [$i2 + 2], $f7              # |     34,667 |     34,667 |
    finv    $f4, $f4                    # |     34,667 |     34,667 |
    bne     $i1, 0, bne.21946           # |     34,667 |     34,667 |
be.21946:
    fneg    $f7, $f7                    # |     24,683 |     24,683 |
    fsub    $f7, $f3, $f3               # |     24,683 |     24,683 |
    fmul    $f3, $f4, $f3               # |     24,683 |     24,683 |
    fmul    $f3, $f6, $f4               # |     24,683 |     24,683 |
    fadd_a  $f4, $f1, $f1               # |     24,683 |     24,683 |
    ble     $f5, $f1, be.21958          # |     24,683 |     24,683 |
.count dual_jmp
    b       bg.21947                    # |      9,463 |      9,463 |
bne.21946:
    fsub    $f7, $f3, $f3               # |      9,984 |      9,984 |
    fmul    $f3, $f4, $f3               # |      9,984 |      9,984 |
    fmul    $f3, $f6, $f4               # |      9,984 |      9,984 |
    fadd_a  $f4, $f1, $f1               # |      9,984 |      9,984 |
    ble     $f5, $f1, be.21958          # |      9,984 |      9,984 |
.count dual_jmp
    b       bg.21947                    # |      6,406 |      6,406 |
bne.21944:
    load    [$i2 + 2], $f7
    finv    $f4, $f4
    bne     $i3, 0, bne.21945
be.21945:
    li      1, $i1
    fsub    $f7, $f3, $f3
    fmul    $f3, $f4, $f3
    fmul    $f3, $f6, $f4
    fadd_a  $f4, $f1, $f1
    ble     $f5, $f1, be.21958
.count dual_jmp
    b       bg.21947
bne.21945:
    li      0, $i1
    fneg    $f7, $f7
    fsub    $f7, $f3, $f3
    fmul    $f3, $f4, $f3
    fmul    $f3, $f6, $f4
    fadd_a  $f4, $f1, $f1
    ble     $f5, $f1, be.21958
bg.21947:
    load    [$i2 + 1], $f1              # |     15,869 |     15,869 |
    load    [$i10 + 1], $f4             # |     15,869 |     15,869 |
    fmul    $f3, $f4, $f4               # |     15,869 |     15,869 |
    fadd_a  $f4, $f2, $f2               # |     15,869 |     15,869 |
    ble     $f1, $f2, be.21958          # |     15,869 |     15,869 |
bg.21948:
    mov     $f3, $fg0                   # |      3,025 |      3,025 |
    li      3, $i12                     # |      3,025 |      3,025 |
    ble     $fg0, $f0, bne.21959        # |      3,025 |      3,025 |
.count dual_jmp
    b       bg.21960                    # |      2,987 |      2,987 |
bg.21940:
    mov     $f4, $fg0                   # |     12,080 |     12,080 |
    li      2, $i12                     # |     12,080 |     12,080 |
    ble     $fg0, $f0, bne.21959        # |     12,080 |     12,080 |
.count dual_jmp
    b       bg.21960                    # |     11,912 |     11,912 |
bg.21932:
    mov     $f4, $fg0                   # |      4,111 |      4,111 |
    li      1, $i12                     # |      4,111 |      4,111 |
    ble     $fg0, $f0, bne.21959        # |      4,111 |      4,111 |
.count dual_jmp
    b       bg.21960                    # |      4,020 |      4,020 |
bne.21925:
    bne     $i3, 2, bne.21949           # |     98,962 |     98,962 |
be.21949:
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
    ble     $f4, $f0, be.21958          # |     24,693 |     24,693 |
bg.21950:
    fmul    $f5, $f1, $f1               # |     17,158 |     17,158 |
    fmul    $f7, $f2, $f2               # |     17,158 |     17,158 |
    fadd    $f1, $f2, $f1               # |     17,158 |     17,158 |
    fmul    $f8, $f3, $f2               # |     17,158 |     17,158 |
    fadd_n  $f1, $f2, $f1               # |     17,158 |     17,158 |
    finv    $f4, $f2                    # |     17,158 |     17,158 |
    fmul    $f1, $f2, $fg0              # |     17,158 |     17,158 |
    li      1, $i12                     # |     17,158 |     17,158 |
    ble     $fg0, $f0, bne.21959        # |     17,158 |     17,158 |
.count dual_jmp
    b       bg.21960                    # |     17,133 |     17,133 |
bne.21949:
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
    bne     $i2, 0, bne.21951           # |     74,269 |     74,269 |
be.21951:
    be      $f7, $f0, be.21958          # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.21952                   # |     74,269 |     74,269 |
bne.21951:
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
    be      $f7, $f0, be.21958
bne.21952:
    fmul    $f4, $f1, $f9               # |     74,269 |     74,269 |
    fmul    $f9, $f8, $f9               # |     74,269 |     74,269 |
    fmul    $f5, $f2, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f10, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    fmul    $f6, $f3, $f12              # |     74,269 |     74,269 |
    fmul    $f12, $f11, $f12            # |     74,269 |     74,269 |
    fadd    $f9, $f12, $f9              # |     74,269 |     74,269 |
    bne     $i2, 0, bne.21953           # |     74,269 |     74,269 |
be.21953:
    mov     $f9, $f4                    # |     74,269 |     74,269 |
    fmul    $f4, $f4, $f5               # |     74,269 |     74,269 |
    fmul    $f1, $f1, $f6               # |     74,269 |     74,269 |
    fmul    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f2, $f2, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f10, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    fmul    $f3, $f3, $f8               # |     74,269 |     74,269 |
    fmul    $f8, $f11, $f8              # |     74,269 |     74,269 |
    fadd    $f6, $f8, $f6               # |     74,269 |     74,269 |
    be      $i2, 0, be.21954            # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.21954
bne.21953:
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
    fmul    $f4, $f4, $f5
    fmul    $f1, $f1, $f6
    fmul    $f6, $f8, $f6
    fmul    $f2, $f2, $f8
    fmul    $f8, $f10, $f8
    fadd    $f6, $f8, $f6
    fmul    $f3, $f3, $f8
    fmul    $f8, $f11, $f8
    fadd    $f6, $f8, $f6
    bne     $i2, 0, bne.21954
be.21954:
    mov     $f6, $f1                    # |     74,269 |     74,269 |
    be      $i3, 3, be.21955            # |     74,269 |     74,269 |
.count dual_jmp
    b       bne.21955
bne.21954:
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
    bne     $i3, 3, bne.21955
be.21955:
    fsub    $f1, $fc0, $f1              # |     74,269 |     74,269 |
    fmul    $f7, $f1, $f1               # |     74,269 |     74,269 |
    fsub    $f5, $f1, $f1               # |     74,269 |     74,269 |
    ble     $f1, $f0, be.21958          # |     74,269 |     74,269 |
.count dual_jmp
    b       bg.21956                    # |     11,893 |     11,893 |
bne.21955:
    fmul    $f7, $f1, $f1
    fsub    $f5, $f1, $f1
    ble     $f1, $f0, be.21958
bg.21956:
    load    [$i1 + 6], $i1              # |     11,893 |     11,893 |
    fsqrt   $f1, $f1                    # |     11,893 |     11,893 |
    li      1, $i12                     # |     11,893 |     11,893 |
    finv    $f7, $f2                    # |     11,893 |     11,893 |
    bne     $i1, 0, bne.21957           # |     11,893 |     11,893 |
be.21957:
    fneg    $f1, $f1                    # |      9,138 |      9,138 |
    fsub    $f1, $f4, $f1               # |      9,138 |      9,138 |
    fmul    $f1, $f2, $fg0              # |      9,138 |      9,138 |
    be      $i12, 0, be.21958           # |      9,138 |      9,138 |
.count dual_jmp
    b       bne.21958                   # |      9,138 |      9,138 |
bne.21957:
    fsub    $f1, $f4, $f1               # |      2,755 |      2,755 |
    fmul    $f1, $f2, $fg0              # |      2,755 |      2,755 |
    bne     $i12, 0, bne.21958          # |      2,755 |      2,755 |
be.21958:
    load    [ext_objects + $i11], $i1   # |    101,553 |    101,553 |
    load    [$i1 + 6], $i1              # |    101,553 |    101,553 |
    bne     $i1, 0, bne.21959           # |    101,553 |    101,553 |
be.21959:
    jr      $ra1                        # |    135,672 |    135,672 |
bne.21958:
    ble     $fg0, $f0, bne.21959        # |     11,893 |     11,893 |
bg.21960:
    bg      $fg7, $fg0, bg.21961        # |     47,420 |     47,420 |
bne.21959:
    add     $i8, 1, $i8                 # |     21,900 |     21,900 |
    b       solve_each_element.2871     # |     21,900 |     21,900 |
bg.21961:
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
bne.21962:
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
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21963:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21964:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21965:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21966:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21967:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21968:
    li      0, $i8                      # |      6,776 |      6,776 |
    load    [ext_and_net + $i1], $i9    # |      6,776 |      6,776 |
.count move_args
    mov     $i15, $i10                  # |      6,776 |      6,776 |
    jal     solve_each_element.2871, $ra1# |      6,776 |      6,776 |
    add     $i13, 1, $i13               # |      6,776 |      6,776 |
    load    [$i14 + $i13], $i1          # |      6,776 |      6,776 |
    be      $i1, -1, be.21970           # |      6,776 |      6,776 |
bne.21969:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element.2871, $ra1
    add     $i13, 1, $i13
    load    [$i14 + $i13], $i1
    bne     $i1, -1, bne.21970
be.21970:
    jr      $ra2                        # |      6,776 |      6,776 |
bne.21970:
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
    be      $i1, -1, be.21979           # |     23,754 |     23,754 |
bne.21971:
    bne     $i1, 99, bne.21972          # |     23,754 |     23,754 |
be.21972:
    load    [$i14 + 1], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21978           # |     23,754 |     23,754 |
bne.21973:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 2], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21978           # |     23,754 |     23,754 |
bne.21974:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 3], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21978           # |     23,754 |     23,754 |
bne.21975:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 4], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21978           # |     23,754 |     23,754 |
bne.21976:
    li      0, $i8                      # |     23,754 |     23,754 |
    load    [ext_and_net + $i1], $i9    # |     23,754 |     23,754 |
.count move_args
    mov     $i18, $i10                  # |     23,754 |     23,754 |
    jal     solve_each_element.2871, $ra1# |     23,754 |     23,754 |
    load    [$i14 + 5], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21978           # |     23,754 |     23,754 |
bne.21977:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 6], $i1
    bne     $i1, -1, bne.21978
be.21978:
    add     $i16, 1, $i16               # |     23,754 |     23,754 |
    load    [$i17 + $i16], $i14         # |     23,754 |     23,754 |
    load    [$i14 + 0], $i1             # |     23,754 |     23,754 |
    be      $i1, -1, be.21979           # |     23,754 |     23,754 |
.count dual_jmp
    b       bne.21979
bne.21978:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    li      7, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network.2875, $ra2
    add     $i16, 1, $i16
    load    [$i17 + $i16], $i14
    load    [$i14 + 0], $i1
    bne     $i1, -1, bne.21979
be.21979:
    jr      $ra3                        # |     23,754 |     23,754 |
bne.21979:
    bne     $i1, 99, bne.21972
be.21980:
    load    [$i14 + 1], $i1
    be      $i1, -1, ble.21988
bne.21981:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 2], $i1
    be      $i1, -1, ble.21988
bne.21982:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 3], $i1
    be      $i1, -1, ble.21988
bne.21983:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 4], $i1
    be      $i1, -1, ble.21988
bne.21984:
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
bne.21972:
.count move_args
    mov     $i18, $i2
    call    solver.2773
    be      $i1, 0, ble.21988
bne.21987:
    bg      $fg7, $fg0, bg.21988
ble.21988:
    add     $i16, 1, $i16
    b       trace_or_matrix.2879
bg.21988:
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
    be      $i11, -1, be.22008          # | 13,852,171 | 13,852,171 |
bne.21989:
    load    [ext_objects + $i11], $i1   # | 10,544,094 | 10,544,094 |
    load    [$i1 + 10], $i2             # | 10,544,094 | 10,544,094 |
    load    [$i10 + 1], $i3             # | 10,544,094 | 10,544,094 |
    load    [$i1 + 1], $i4              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 0], $f1              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 1], $f2              # | 10,544,094 | 10,544,094 |
    load    [$i2 + 2], $f3              # | 10,544,094 | 10,544,094 |
    load    [$i3 + $i11], $i3           # | 10,544,094 | 10,544,094 |
    bne     $i4, 1, bne.21990           # | 10,544,094 | 10,544,094 |
be.21990:
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
    ble     $f4, $f5, be.21993          # |  3,873,912 |  3,873,912 |
bg.21991:
    load    [$i1 + 2], $f4              # |    828,138 |    828,138 |
    load    [$i2 + 2], $f5              # |    828,138 |    828,138 |
    fmul    $f6, $f5, $f5               # |    828,138 |    828,138 |
    fadd_a  $f5, $f3, $f5               # |    828,138 |    828,138 |
    ble     $f4, $f5, be.21993          # |    828,138 |    828,138 |
bg.21992:
    load    [$i3 + 1], $f4              # |    503,446 |    503,446 |
    bne     $f4, $f0, bne.21993         # |    503,446 |    503,446 |
be.21993:
    load    [$i1 + 0], $f4              # |  3,370,466 |  3,370,466 |
    load    [$i2 + 0], $f5              # |  3,370,466 |  3,370,466 |
    load    [$i3 + 2], $f6              # |  3,370,466 |  3,370,466 |
    fsub    $f6, $f2, $f6               # |  3,370,466 |  3,370,466 |
    load    [$i3 + 3], $f7              # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f7, $f6               # |  3,370,466 |  3,370,466 |
    fmul    $f6, $f5, $f5               # |  3,370,466 |  3,370,466 |
    fadd_a  $f5, $f1, $f5               # |  3,370,466 |  3,370,466 |
    ble     $f4, $f5, be.21997          # |  3,370,466 |  3,370,466 |
bg.21995:
    load    [$i1 + 2], $f4              # |  1,793,231 |  1,793,231 |
    load    [$i2 + 2], $f5              # |  1,793,231 |  1,793,231 |
    fmul    $f6, $f5, $f5               # |  1,793,231 |  1,793,231 |
    fadd_a  $f5, $f3, $f5               # |  1,793,231 |  1,793,231 |
    ble     $f4, $f5, be.21997          # |  1,793,231 |  1,793,231 |
bg.21996:
    load    [$i3 + 3], $f4              # |  1,222,656 |  1,222,656 |
    bne     $f4, $f0, bne.21997         # |  1,222,656 |  1,222,656 |
be.21997:
    load    [$i1 + 0], $f4              # |  2,147,810 |  2,147,810 |
    load    [$i2 + 0], $f5              # |  2,147,810 |  2,147,810 |
    load    [$i3 + 4], $f6              # |  2,147,810 |  2,147,810 |
    fsub    $f6, $f3, $f3               # |  2,147,810 |  2,147,810 |
    load    [$i3 + 5], $f6              # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f6, $f3               # |  2,147,810 |  2,147,810 |
    fmul    $f3, $f5, $f5               # |  2,147,810 |  2,147,810 |
    fadd_a  $f5, $f1, $f1               # |  2,147,810 |  2,147,810 |
    ble     $f4, $f1, be.22007          # |  2,147,810 |  2,147,810 |
bg.21999:
    load    [$i1 + 1], $f1              # |    606,567 |    606,567 |
    load    [$i2 + 1], $f4              # |    606,567 |    606,567 |
    fmul    $f3, $f4, $f4               # |    606,567 |    606,567 |
    fadd_a  $f4, $f2, $f2               # |    606,567 |    606,567 |
    ble     $f1, $f2, be.22007          # |    606,567 |    606,567 |
bg.22000:
    load    [$i3 + 5], $f1              # |    274,576 |    274,576 |
    be      $f1, $f0, be.22007          # |    274,576 |    274,576 |
bne.22001:
    mov     $f3, $fg0                   # |    274,576 |    274,576 |
    li      3, $i12                     # |    274,576 |    274,576 |
    ble     $fg0, $f0, ble.22010        # |    274,576 |    274,576 |
.count dual_jmp
    b       bg.22009                    # |     45,684 |     45,684 |
bne.21997:
    mov     $f6, $fg0                   # |  1,222,656 |  1,222,656 |
    li      2, $i12                     # |  1,222,656 |  1,222,656 |
    ble     $fg0, $f0, ble.22010        # |  1,222,656 |  1,222,656 |
.count dual_jmp
    b       bg.22009                    # |    207,391 |    207,391 |
bne.21993:
    mov     $f6, $fg0                   # |    503,446 |    503,446 |
    li      1, $i12                     # |    503,446 |    503,446 |
    ble     $fg0, $f0, ble.22010        # |    503,446 |    503,446 |
.count dual_jmp
    b       bg.22009                    # |     77,882 |     77,882 |
bne.21990:
    bne     $i4, 2, bne.22002           # |  6,670,182 |  6,670,182 |
be.22002:
    load    [$i3 + 0], $f1              # |  1,242,326 |  1,242,326 |
    ble     $f0, $f1, be.22007          # |  1,242,326 |  1,242,326 |
bg.22003:
    load    [$i2 + 3], $f2              # |    595,309 |    595,309 |
    fmul    $f1, $f2, $fg0              # |    595,309 |    595,309 |
    li      1, $i12                     # |    595,309 |    595,309 |
    ble     $fg0, $f0, ble.22010        # |    595,309 |    595,309 |
.count dual_jmp
    b       bg.22009                    # |    551,827 |    551,827 |
bne.22002:
    load    [$i3 + 0], $f4              # |  5,427,856 |  5,427,856 |
    be      $f4, $f0, be.22007          # |  5,427,856 |  5,427,856 |
bne.22004:
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
    ble     $f2, $f0, be.22007          # |  5,427,856 |  5,427,856 |
bg.22005:
    load    [$i1 + 6], $i1              # |  1,680,868 |  1,680,868 |
    li      1, $i12                     # |  1,680,868 |  1,680,868 |
    fsqrt   $f2, $f2                    # |  1,680,868 |  1,680,868 |
    bne     $i1, 0, bne.22006           # |  1,680,868 |  1,680,868 |
be.22006:
    fsub    $f1, $f2, $f1               # |  1,260,056 |  1,260,056 |
    load    [$i3 + 4], $f2              # |  1,260,056 |  1,260,056 |
    fmul    $f1, $f2, $fg0              # |  1,260,056 |  1,260,056 |
    be      $i12, 0, be.22007           # |  1,260,056 |  1,260,056 |
.count dual_jmp
    b       bne.22007                   # |  1,260,056 |  1,260,056 |
bne.22006:
    fadd    $f1, $f2, $f1               # |    420,812 |    420,812 |
    load    [$i3 + 4], $f2              # |    420,812 |    420,812 |
    fmul    $f1, $f2, $fg0              # |    420,812 |    420,812 |
    bne     $i12, 0, bne.22007          # |    420,812 |    420,812 |
be.22007:
    load    [ext_objects + $i11], $i1   # |  6,267,239 |  6,267,239 |
    load    [$i1 + 6], $i1              # |  6,267,239 |  6,267,239 |
    bne     $i1, 0, ble.22010           # |  6,267,239 |  6,267,239 |
be.22008:
    jr      $ra1                        # |  8,647,408 |  8,647,408 |
bne.22007:
    ble     $fg0, $f0, ble.22010        # |  1,680,868 |  1,680,868 |
bg.22009:
    load    [$i10 + 0], $i1             # |  1,396,931 |  1,396,931 |
    bg      $fg7, $fg0, bg.22010        # |  1,396,931 |  1,396,931 |
ble.22010:
    add     $i8, 1, $i8                 # |  4,023,266 |  4,023,266 |
    b       solve_each_element_fast.2885# |  4,023,266 |  4,023,266 |
bg.22010:
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
bne.22011:
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
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22012:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22013:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22014:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22015:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22016:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22017:
    li      0, $i8                      # |    684,824 |    684,824 |
    load    [ext_and_net + $i1], $i9    # |    684,824 |    684,824 |
.count move_args
    mov     $i15, $i10                  # |    684,824 |    684,824 |
    jal     solve_each_element_fast.2885, $ra1# |    684,824 |    684,824 |
    add     $i13, 1, $i13               # |    684,824 |    684,824 |
    load    [$i14 + $i13], $i1          # |    684,824 |    684,824 |
    be      $i1, -1, be.22019           # |    684,824 |    684,824 |
bne.22018:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i15, $i10
    jal     solve_each_element_fast.2885, $ra1
    add     $i13, 1, $i13
    load    [$i14 + $i13], $i1
    bne     $i1, -1, bne.22019
be.22019:
    jr      $ra2                        # |    684,824 |    684,824 |
bne.22019:
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
    be      $i1, -1, be.22028           # |  1,134,616 |  1,134,616 |
bne.22020:
    bne     $i1, 99, bne.22021          # |  1,134,616 |  1,134,616 |
be.22021:
    load    [$i14 + 1], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22027           # |  1,134,616 |  1,134,616 |
bne.22022:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 2], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22027           # |  1,134,616 |  1,134,616 |
bne.22023:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 3], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22027           # |  1,134,616 |  1,134,616 |
bne.22024:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 4], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22027           # |  1,134,616 |  1,134,616 |
bne.22025:
    li      0, $i8                      # |  1,134,616 |  1,134,616 |
    load    [ext_and_net + $i1], $i9    # |  1,134,616 |  1,134,616 |
.count move_args
    mov     $i18, $i10                  # |  1,134,616 |  1,134,616 |
    jal     solve_each_element_fast.2885, $ra1# |  1,134,616 |  1,134,616 |
    load    [$i14 + 5], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22027           # |  1,134,616 |  1,134,616 |
bne.22026:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 6], $i1
    bne     $i1, -1, bne.22027
be.22027:
    add     $i16, 1, $i16               # |  1,134,616 |  1,134,616 |
    load    [$i17 + $i16], $i14         # |  1,134,616 |  1,134,616 |
    load    [$i14 + 0], $i1             # |  1,134,616 |  1,134,616 |
    be      $i1, -1, be.22028           # |  1,134,616 |  1,134,616 |
.count dual_jmp
    b       bne.22028
bne.22027:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    li      7, $i13
.count move_args
    mov     $i18, $i15
    jal     solve_one_or_network_fast.2889, $ra2
    add     $i16, 1, $i16
    load    [$i17 + $i16], $i14
    load    [$i14 + 0], $i1
    bne     $i1, -1, bne.22028
be.22028:
    jr      $ra3                        # |  1,134,616 |  1,134,616 |
bne.22028:
    bne     $i1, 99, bne.22021
be.22029:
    load    [$i14 + 1], $i1
    be      $i1, -1, ble.22037
bne.22030:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    be      $i1, -1, ble.22037
bne.22031:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    be      $i1, -1, ble.22037
bne.22032:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i18, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    be      $i1, -1, ble.22037
bne.22033:
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
bne.22021:
.count move_args
    mov     $i18, $i2
    call    solver_fast2.2814
    be      $i1, 0, ble.22037
bne.22036:
    bg      $fg7, $fg0, bg.22037
ble.22037:
    add     $i16, 1, $i16
    b       trace_or_matrix_fast.2893
bg.22037:
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
    bne     $i2, 1, bne.22038           # |    660,729 |    660,729 |
be.22038:
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
    bg      $f7, $f5, bg.22039          # |     94,509 |     94,509 |
ble.22039:
    li      0, $i1                      # |     50,304 |     50,304 |
    ble     $f7, $f1, ble.22040         # |     50,304 |     50,304 |
.count dual_jmp
    b       bg.22040                    # |     26,193 |     26,193 |
bg.22039:
    li      1, $i1                      # |     44,205 |     44,205 |
    bg      $f7, $f1, bg.22040          # |     44,205 |     44,205 |
ble.22040:
    be      $i1, 0, bne.22042           # |     45,686 |     45,686 |
.count dual_jmp
    b       be.22042                    # |     21,575 |     21,575 |
bg.22040:
    bne     $i1, 0, bne.22042           # |     48,823 |     48,823 |
be.22042:
    mov     $f0, $fg11                  # |     47,768 |     47,768 |
    jr      $ra1                        # |     47,768 |     47,768 |
bne.22042:
    mov     $fc8, $fg11                 # |     46,741 |     46,741 |
    jr      $ra1                        # |     46,741 |     46,741 |
bne.22038:
    bne     $i2, 2, bne.22043           # |    566,220 |    566,220 |
be.22043:
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
bne.22043:
    bne     $i2, 3, bne.22044           # |    563,334 |    563,334 |
be.22044:
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
bne.22044:
    bne     $i2, 4, bne.22045           # |    563,334 |    563,334 |
be.22045:
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
    bg      $f6, $f1, bg.22046
ble.22046:
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
    ble     $f6, $f2, ble.22047
.count dual_jmp
    b       bg.22047
bg.22046:
.count load_float
    load    [f.21529], $f9
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
    bg      $f6, $f2, bg.22047
ble.22047:
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
    ble     $f0, $f1, ble.22048
.count dual_jmp
    b       bg.22048
bg.22047:
.count load_float
    load    [f.21529], $f4
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
    bg      $f0, $f1, bg.22048
ble.22048:
.count load_float
    load    [f.21535], $f2
    fmul    $f2, $f1, $fg15
    jr      $ra1
bg.22048:
    mov     $f0, $fg15
    jr      $ra1
bne.22045:
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
    bl      $i19, 0, bl.22049           # |     36,992 |     36,992 |
bge.22049:
    load    [ext_reflections + $i19], $i21# |     18,496 |     18,496 |
    load    [$i21 + 1], $i22            # |     18,496 |     18,496 |
    mov     $fc13, $fg7                 # |     18,496 |     18,496 |
    load    [$ig1 + 0], $i14            # |     18,496 |     18,496 |
    load    [$i14 + 0], $i1             # |     18,496 |     18,496 |
    bne     $i1, -1, bne.22050          # |     18,496 |     18,496 |
be.22050:
    ble     $fg7, $fc7, bne.22061
.count dual_jmp
    b       bg.22058
bne.22050:
    bne     $i1, 99, bne.22051          # |     18,496 |     18,496 |
be.22051:
    load    [$i14 + 1], $i1
    be      $i1, -1, ble.22057
bne.22052:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    be      $i1, -1, ble.22057
bne.22053:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    be      $i1, -1, ble.22057
bne.22054:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i22, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    be      $i1, -1, ble.22057
bne.22055:
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
    ble     $fg7, $fc7, bne.22061
.count dual_jmp
    b       bg.22058
bne.22051:
.count move_args
    mov     $i22, $i2                   # |     18,496 |     18,496 |
    call    solver_fast2.2814           # |     18,496 |     18,496 |
    be      $i1, 0, ble.22057           # |     18,496 |     18,496 |
bne.22056:
    bg      $fg7, $fg0, bg.22057        # |      5,026 |      5,026 |
ble.22057:
    li      1, $i16                     # |     13,470 |     13,470 |
.count move_args
    mov     $ig1, $i17                  # |     13,470 |     13,470 |
.count move_args
    mov     $i22, $i18                  # |     13,470 |     13,470 |
    jal     trace_or_matrix_fast.2893, $ra3# |     13,470 |     13,470 |
    ble     $fg7, $fc7, bne.22061       # |     13,470 |     13,470 |
.count dual_jmp
    b       bg.22058                    # |     13,470 |     13,470 |
bg.22057:
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
    ble     $fg7, $fc7, bne.22061       # |      5,026 |      5,026 |
bg.22058:
    ble     $fc12, $fg7, bne.22061      # |     18,496 |     18,496 |
bg.22059:
    li      1, $i1                      # |     11,284 |     11,284 |
    load    [$i21 + 0], $i1             # |     11,284 |     11,284 |
    add     $ig3, $ig3, $i2             # |     11,284 |     11,284 |
    add     $i2, $i2, $i2               # |     11,284 |     11,284 |
    add     $i2, $ig2, $i2              # |     11,284 |     11,284 |
    bne     $i2, $i1, bne.22061         # |     11,284 |     11,284 |
be.22061:
    li      0, $i12                     # |     10,331 |     10,331 |
.count move_args
    mov     $ig1, $i13                  # |     10,331 |     10,331 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     10,331 |     10,331 |
    bne     $i1, 0, bne.22061           # |     10,331 |     10,331 |
be.22062:
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
    bg      $f2, $f0, bg.22063          # |     10,331 |     10,331 |
ble.22063:
    load    [$i20 + 0], $f2             # |        958 |        958 |
    fmul    $f2, $f4, $f2               # |        958 |        958 |
    load    [$i20 + 1], $f3             # |        958 |        958 |
    fmul    $f3, $f6, $f3               # |        958 |        958 |
    fadd    $f2, $f3, $f2               # |        958 |        958 |
    load    [$i20 + 2], $f3             # |        958 |        958 |
    fmul    $f3, $f7, $f3               # |        958 |        958 |
    fadd    $f2, $f3, $f2               # |        958 |        958 |
    fmul    $f1, $f2, $f1               # |        958 |        958 |
    ble     $f1, $f0, bne.22061         # |        958 |        958 |
.count dual_jmp
    b       bg.22064
bg.22063:
    fmul    $f2, $fg16, $f3             # |      9,373 |      9,373 |
    fadd    $fg4, $f3, $fg4             # |      9,373 |      9,373 |
    fmul    $f2, $fg11, $f3             # |      9,373 |      9,373 |
    fadd    $fg5, $f3, $fg5             # |      9,373 |      9,373 |
    fmul    $f2, $fg15, $f2             # |      9,373 |      9,373 |
    fadd    $fg6, $f2, $fg6             # |      9,373 |      9,373 |
    load    [$i20 + 0], $f2             # |      9,373 |      9,373 |
    fmul    $f2, $f4, $f2               # |      9,373 |      9,373 |
    load    [$i20 + 1], $f3             # |      9,373 |      9,373 |
    fmul    $f3, $f6, $f3               # |      9,373 |      9,373 |
    fadd    $f2, $f3, $f2               # |      9,373 |      9,373 |
    load    [$i20 + 2], $f3             # |      9,373 |      9,373 |
    fmul    $f3, $f7, $f3               # |      9,373 |      9,373 |
    fadd    $f2, $f3, $f2               # |      9,373 |      9,373 |
    fmul    $f1, $f2, $f1               # |      9,373 |      9,373 |
    bg      $f1, $f0, bg.22064          # |      9,373 |      9,373 |
bne.22061:
    add     $i19, -1, $i19              # |     10,775 |     10,775 |
    b       trace_reflections.2915      # |     10,775 |     10,775 |
bg.22064:
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f1, $f1               # |      7,721 |      7,721 |
    fmul    $f1, $f15, $f1              # |      7,721 |      7,721 |
    fadd    $fg4, $f1, $fg4             # |      7,721 |      7,721 |
    fadd    $fg5, $f1, $fg5             # |      7,721 |      7,721 |
    fadd    $fg6, $f1, $fg6             # |      7,721 |      7,721 |
    add     $i19, -1, $i19              # |      7,721 |      7,721 |
    b       trace_reflections.2915      # |      7,721 |      7,721 |
bl.22049:
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
    bg      $i23, 4, bg.22065           # |     23,754 |     23,754 |
ble.22065:
    mov     $fc13, $fg7                 # |     23,754 |     23,754 |
    load    [$ig1 + 0], $i14            # |     23,754 |     23,754 |
    load    [$i14 + 0], $i1             # |     23,754 |     23,754 |
    bne     $i1, -1, bne.22066          # |     23,754 |     23,754 |
be.22066:
    load    [$i25 + 2], $i26
    ble     $fg7, $fc7, ble.22075
.count dual_jmp
    b       bg.22074
bne.22066:
    bne     $i1, 99, bne.22067          # |     23,754 |     23,754 |
be.22067:
    load    [$i14 + 1], $i1
    be      $i1, -1, ble.22073
bne.22068:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 2], $i1
    be      $i1, -1, ble.22073
bne.22069:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 3], $i1
    be      $i1, -1, ble.22073
bne.22070:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i24, $i10
    jal     solve_each_element.2871, $ra1
    load    [$i14 + 4], $i1
    be      $i1, -1, ble.22073
bne.22071:
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
    load    [$i25 + 2], $i26
    ble     $fg7, $fc7, ble.22075
.count dual_jmp
    b       bg.22074
bne.22067:
.count move_args
    mov     $i24, $i2                   # |     23,754 |     23,754 |
    call    solver.2773                 # |     23,754 |     23,754 |
    be      $i1, 0, ble.22073           # |     23,754 |     23,754 |
bne.22072:
    bg      $fg7, $fg0, bg.22073        # |      6,776 |      6,776 |
ble.22073:
    li      1, $i16                     # |     16,978 |     16,978 |
.count move_args
    mov     $ig1, $i17                  # |     16,978 |     16,978 |
.count move_args
    mov     $i24, $i18                  # |     16,978 |     16,978 |
    jal     trace_or_matrix.2879, $ra3  # |     16,978 |     16,978 |
    load    [$i25 + 2], $i26            # |     16,978 |     16,978 |
    ble     $fg7, $fc7, ble.22075       # |     16,978 |     16,978 |
.count dual_jmp
    b       bg.22074                    # |     16,978 |     16,978 |
bg.22073:
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
    load    [$i25 + 2], $i26            # |      6,776 |      6,776 |
    ble     $fg7, $fc7, ble.22075       # |      6,776 |      6,776 |
bg.22074:
    bg      $fc12, $fg7, bg.22075       # |     23,754 |     23,754 |
ble.22075:
    add     $i0, -1, $i1                # |      5,258 |      5,258 |
.count storer
    add     $i26, $i23, $tmp            # |      5,258 |      5,258 |
    store   $i1, [$tmp + 0]             # |      5,258 |      5,258 |
    be      $i23, 0, bg.22065           # |      5,258 |      5,258 |
bne.22077:
    load    [$i24 + 0], $f1             # |      5,258 |      5,258 |
    fmul    $f1, $fg14, $f1             # |      5,258 |      5,258 |
    load    [$i24 + 1], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg12, $f2             # |      5,258 |      5,258 |
    fadd    $f1, $f2, $f1               # |      5,258 |      5,258 |
    load    [$i24 + 2], $f2             # |      5,258 |      5,258 |
    fmul    $f2, $fg13, $f2             # |      5,258 |      5,258 |
    fadd_n  $f1, $f2, $f1               # |      5,258 |      5,258 |
    ble     $f1, $f0, bg.22065          # |      5,258 |      5,258 |
bg.22078:
    fmul    $f1, $f1, $f2               # |      1,984 |      1,984 |
    fmul    $f2, $f1, $f1               # |      1,984 |      1,984 |
    fmul    $f1, $f16, $f1              # |      1,984 |      1,984 |
    load    [ext_beam + 0], $f2         # |      1,984 |      1,984 |
    fmul    $f1, $f2, $f1               # |      1,984 |      1,984 |
    fadd    $fg4, $f1, $fg4             # |      1,984 |      1,984 |
    fadd    $fg5, $f1, $fg5             # |      1,984 |      1,984 |
    fadd    $fg6, $f1, $fg6             # |      1,984 |      1,984 |
    jr      $ra5                        # |      1,984 |      1,984 |
bg.22075:
    li      1, $i1                      # |     18,496 |     18,496 |
    load    [ext_objects + $ig3], $i27  # |     18,496 |     18,496 |
    load    [$i27 + 1], $i1             # |     18,496 |     18,496 |
    bne     $i1, 1, bne.22079           # |     18,496 |     18,496 |
be.22079:
    store   $f0, [ext_nvector + 0]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 1]      # |      7,910 |      7,910 |
    store   $f0, [ext_nvector + 2]      # |      7,910 |      7,910 |
    add     $ig2, -1, $i1               # |      7,910 |      7,910 |
    load    [$i24 + $i1], $f1           # |      7,910 |      7,910 |
    bne     $f1, $f0, bne.22080         # |      7,910 |      7,910 |
be.22080:
    store   $f0, [ext_nvector + $i1]
    load    [ext_intersection_point + 0], $fg17
    load    [ext_intersection_point + 1], $fg18
    load    [ext_intersection_point + 2], $fg19
.count move_args
    mov     $i27, $i1
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i1, $i1, $i1
    add     $i1, $ig2, $i1
.count storer
    add     $i26, $i23, $tmp
    store   $i1, [$tmp + 0]
    load    [$i25 + 1], $i1
    load    [$i1 + $i23], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    load    [$i27 + 7], $i28
    load    [$i25 + 3], $i1
    load    [$i28 + 0], $f1
    fmul    $f1, $f16, $f14
    ble     $fc4, $f1, ble.22086
.count dual_jmp
    b       bg.22086
bne.22080:
    bg      $f1, $f0, bg.22081          # |      7,910 |      7,910 |
ble.22081:
    store   $fc0, [ext_nvector + $i1]   # |      6,667 |      6,667 |
    load    [ext_intersection_point + 0], $fg17# |      6,667 |      6,667 |
    load    [ext_intersection_point + 1], $fg18# |      6,667 |      6,667 |
    load    [ext_intersection_point + 2], $fg19# |      6,667 |      6,667 |
.count move_args
    mov     $i27, $i1                   # |      6,667 |      6,667 |
    jal     utexture.2908, $ra1         # |      6,667 |      6,667 |
    add     $ig3, $ig3, $i1             # |      6,667 |      6,667 |
    add     $i1, $i1, $i1               # |      6,667 |      6,667 |
    add     $i1, $ig2, $i1              # |      6,667 |      6,667 |
.count storer
    add     $i26, $i23, $tmp            # |      6,667 |      6,667 |
    store   $i1, [$tmp + 0]             # |      6,667 |      6,667 |
    load    [$i25 + 1], $i1             # |      6,667 |      6,667 |
    load    [$i1 + $i23], $i1           # |      6,667 |      6,667 |
    load    [ext_intersection_point + 0], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 0]              # |      6,667 |      6,667 |
    load    [ext_intersection_point + 1], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 1]              # |      6,667 |      6,667 |
    load    [ext_intersection_point + 2], $f1# |      6,667 |      6,667 |
    store   $f1, [$i1 + 2]              # |      6,667 |      6,667 |
    load    [$i27 + 7], $i28            # |      6,667 |      6,667 |
    load    [$i25 + 3], $i1             # |      6,667 |      6,667 |
    load    [$i28 + 0], $f1             # |      6,667 |      6,667 |
    fmul    $f1, $f16, $f14             # |      6,667 |      6,667 |
    ble     $fc4, $f1, ble.22086        # |      6,667 |      6,667 |
.count dual_jmp
    b       bg.22086
bg.22081:
    store   $fc3, [ext_nvector + $i1]   # |      1,243 |      1,243 |
    load    [ext_intersection_point + 0], $fg17# |      1,243 |      1,243 |
    load    [ext_intersection_point + 1], $fg18# |      1,243 |      1,243 |
    load    [ext_intersection_point + 2], $fg19# |      1,243 |      1,243 |
.count move_args
    mov     $i27, $i1                   # |      1,243 |      1,243 |
    jal     utexture.2908, $ra1         # |      1,243 |      1,243 |
    add     $ig3, $ig3, $i1             # |      1,243 |      1,243 |
    add     $i1, $i1, $i1               # |      1,243 |      1,243 |
    add     $i1, $ig2, $i1              # |      1,243 |      1,243 |
.count storer
    add     $i26, $i23, $tmp            # |      1,243 |      1,243 |
    store   $i1, [$tmp + 0]             # |      1,243 |      1,243 |
    load    [$i25 + 1], $i1             # |      1,243 |      1,243 |
    load    [$i1 + $i23], $i1           # |      1,243 |      1,243 |
    load    [ext_intersection_point + 0], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 0]              # |      1,243 |      1,243 |
    load    [ext_intersection_point + 1], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 1]              # |      1,243 |      1,243 |
    load    [ext_intersection_point + 2], $f1# |      1,243 |      1,243 |
    store   $f1, [$i1 + 2]              # |      1,243 |      1,243 |
    load    [$i27 + 7], $i28            # |      1,243 |      1,243 |
    load    [$i25 + 3], $i1             # |      1,243 |      1,243 |
    load    [$i28 + 0], $f1             # |      1,243 |      1,243 |
    fmul    $f1, $f16, $f14             # |      1,243 |      1,243 |
    ble     $fc4, $f1, ble.22086        # |      1,243 |      1,243 |
.count dual_jmp
    b       bg.22086
bne.22079:
    bne     $i1, 2, bne.22082           # |     10,586 |     10,586 |
be.22082:
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
    load    [ext_intersection_point + 0], $fg17# |      7,226 |      7,226 |
    load    [ext_intersection_point + 1], $fg18# |      7,226 |      7,226 |
    load    [ext_intersection_point + 2], $fg19# |      7,226 |      7,226 |
.count move_args
    mov     $i27, $i1                   # |      7,226 |      7,226 |
    jal     utexture.2908, $ra1         # |      7,226 |      7,226 |
    add     $ig3, $ig3, $i1             # |      7,226 |      7,226 |
    add     $i1, $i1, $i1               # |      7,226 |      7,226 |
    add     $i1, $ig2, $i1              # |      7,226 |      7,226 |
.count storer
    add     $i26, $i23, $tmp            # |      7,226 |      7,226 |
    store   $i1, [$tmp + 0]             # |      7,226 |      7,226 |
    load    [$i25 + 1], $i1             # |      7,226 |      7,226 |
    load    [$i1 + $i23], $i1           # |      7,226 |      7,226 |
    load    [ext_intersection_point + 0], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 0]              # |      7,226 |      7,226 |
    load    [ext_intersection_point + 1], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 1]              # |      7,226 |      7,226 |
    load    [ext_intersection_point + 2], $f1# |      7,226 |      7,226 |
    store   $f1, [$i1 + 2]              # |      7,226 |      7,226 |
    load    [$i27 + 7], $i28            # |      7,226 |      7,226 |
    load    [$i25 + 3], $i1             # |      7,226 |      7,226 |
    load    [$i28 + 0], $f1             # |      7,226 |      7,226 |
    fmul    $f1, $f16, $f14             # |      7,226 |      7,226 |
    ble     $fc4, $f1, ble.22086        # |      7,226 |      7,226 |
.count dual_jmp
    b       bg.22086                    # |      7,222 |      7,222 |
bne.22082:
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
    bne     $i1, 0, bne.22083           # |      3,360 |      3,360 |
be.22083:
    store   $f1, [ext_nvector + 0]      # |      3,360 |      3,360 |
    store   $f3, [ext_nvector + 1]      # |      3,360 |      3,360 |
    store   $f5, [ext_nvector + 2]      # |      3,360 |      3,360 |
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
    be      $f2, $f0, be.22084          # |      3,360 |      3,360 |
.count dual_jmp
    b       bne.22084                   # |      3,360 |      3,360 |
bne.22083:
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
    load    [ext_nvector + 0], $f1
    load    [$i27 + 6], $i1
    fmul    $f1, $f1, $f2
    load    [ext_nvector + 1], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    load    [ext_nvector + 2], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    bne     $f2, $f0, bne.22084
be.22084:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
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
.count move_args
    mov     $i27, $i1
    jal     utexture.2908, $ra1
    add     $ig3, $ig3, $i1
    add     $i1, $i1, $i1
    add     $i1, $ig2, $i1
.count storer
    add     $i26, $i23, $tmp
    store   $i1, [$tmp + 0]
    load    [$i25 + 1], $i1
    load    [$i1 + $i23], $i1
    load    [ext_intersection_point + 0], $f1
    store   $f1, [$i1 + 0]
    load    [ext_intersection_point + 1], $f1
    store   $f1, [$i1 + 1]
    load    [ext_intersection_point + 2], $f1
    store   $f1, [$i1 + 2]
    load    [$i27 + 7], $i28
    load    [$i25 + 3], $i1
    load    [$i28 + 0], $f1
    fmul    $f1, $f16, $f14
    ble     $fc4, $f1, ble.22086
.count dual_jmp
    b       bg.22086
bne.22084:
    bne     $i1, 0, bne.22085           # |      3,360 |      3,360 |
be.22085:
    finv    $f2, $f2                    # |      3,127 |      3,127 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |
    store   $f1, [ext_nvector + 0]      # |      3,127 |      3,127 |
    load    [ext_nvector + 1], $f1      # |      3,127 |      3,127 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |
    store   $f1, [ext_nvector + 1]      # |      3,127 |      3,127 |
    load    [ext_nvector + 2], $f1      # |      3,127 |      3,127 |
    fmul    $f1, $f2, $f1               # |      3,127 |      3,127 |
    store   $f1, [ext_nvector + 2]      # |      3,127 |      3,127 |
    load    [ext_intersection_point + 0], $fg17# |      3,127 |      3,127 |
    load    [ext_intersection_point + 1], $fg18# |      3,127 |      3,127 |
    load    [ext_intersection_point + 2], $fg19# |      3,127 |      3,127 |
.count move_args
    mov     $i27, $i1                   # |      3,127 |      3,127 |
    jal     utexture.2908, $ra1         # |      3,127 |      3,127 |
    add     $ig3, $ig3, $i1             # |      3,127 |      3,127 |
    add     $i1, $i1, $i1               # |      3,127 |      3,127 |
    add     $i1, $ig2, $i1              # |      3,127 |      3,127 |
.count storer
    add     $i26, $i23, $tmp            # |      3,127 |      3,127 |
    store   $i1, [$tmp + 0]             # |      3,127 |      3,127 |
    load    [$i25 + 1], $i1             # |      3,127 |      3,127 |
    load    [$i1 + $i23], $i1           # |      3,127 |      3,127 |
    load    [ext_intersection_point + 0], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 0]              # |      3,127 |      3,127 |
    load    [ext_intersection_point + 1], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 1]              # |      3,127 |      3,127 |
    load    [ext_intersection_point + 2], $f1# |      3,127 |      3,127 |
    store   $f1, [$i1 + 2]              # |      3,127 |      3,127 |
    load    [$i27 + 7], $i28            # |      3,127 |      3,127 |
    load    [$i25 + 3], $i1             # |      3,127 |      3,127 |
    load    [$i28 + 0], $f1             # |      3,127 |      3,127 |
    fmul    $f1, $f16, $f14             # |      3,127 |      3,127 |
    ble     $fc4, $f1, ble.22086        # |      3,127 |      3,127 |
.count dual_jmp
    b       bg.22086                    # |        148 |        148 |
bne.22085:
    finv_n  $f2, $f2                    # |        233 |        233 |
    fmul    $f1, $f2, $f1               # |        233 |        233 |
    store   $f1, [ext_nvector + 0]      # |        233 |        233 |
    load    [ext_nvector + 1], $f1      # |        233 |        233 |
    fmul    $f1, $f2, $f1               # |        233 |        233 |
    store   $f1, [ext_nvector + 1]      # |        233 |        233 |
    load    [ext_nvector + 2], $f1      # |        233 |        233 |
    fmul    $f1, $f2, $f1               # |        233 |        233 |
    store   $f1, [ext_nvector + 2]      # |        233 |        233 |
    load    [ext_intersection_point + 0], $fg17# |        233 |        233 |
    load    [ext_intersection_point + 1], $fg18# |        233 |        233 |
    load    [ext_intersection_point + 2], $fg19# |        233 |        233 |
.count move_args
    mov     $i27, $i1                   # |        233 |        233 |
    jal     utexture.2908, $ra1         # |        233 |        233 |
    add     $ig3, $ig3, $i1             # |        233 |        233 |
    add     $i1, $i1, $i1               # |        233 |        233 |
    add     $i1, $ig2, $i1              # |        233 |        233 |
.count storer
    add     $i26, $i23, $tmp            # |        233 |        233 |
    store   $i1, [$tmp + 0]             # |        233 |        233 |
    load    [$i25 + 1], $i1             # |        233 |        233 |
    load    [$i1 + $i23], $i1           # |        233 |        233 |
    load    [ext_intersection_point + 0], $f1# |        233 |        233 |
    store   $f1, [$i1 + 0]              # |        233 |        233 |
    load    [ext_intersection_point + 1], $f1# |        233 |        233 |
    store   $f1, [$i1 + 1]              # |        233 |        233 |
    load    [ext_intersection_point + 2], $f1# |        233 |        233 |
    store   $f1, [$i1 + 2]              # |        233 |        233 |
    load    [$i27 + 7], $i28            # |        233 |        233 |
    load    [$i25 + 3], $i1             # |        233 |        233 |
    load    [$i28 + 0], $f1             # |        233 |        233 |
    fmul    $f1, $f16, $f14             # |        233 |        233 |
    bg      $fc4, $f1, bg.22086         # |        233 |        233 |
ble.22086:
    li      1, $i2                      # |     11,126 |     11,126 |
.count storer
    add     $i1, $i23, $tmp             # |     11,126 |     11,126 |
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
    load    [ext_nvector + 0], $f1      # |     11,126 |     11,126 |
.count load_float
    load    [f.21546], $f2              # |     11,126 |     11,126 |
    load    [$i24 + 0], $f3             # |     11,126 |     11,126 |
    fmul    $f3, $f1, $f4               # |     11,126 |     11,126 |
    load    [$i24 + 1], $f5             # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f6      # |     11,126 |     11,126 |
    fmul    $f5, $f6, $f5               # |     11,126 |     11,126 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |
    load    [$i24 + 2], $f5             # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f6      # |     11,126 |     11,126 |
    fmul    $f5, $f6, $f5               # |     11,126 |     11,126 |
    fadd    $f4, $f5, $f4               # |     11,126 |     11,126 |
    fmul    $f2, $f4, $f2               # |     11,126 |     11,126 |
    fmul    $f2, $f1, $f1               # |     11,126 |     11,126 |
    fadd    $f3, $f1, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i24 + 0]             # |     11,126 |     11,126 |
    load    [$i24 + 1], $f1             # |     11,126 |     11,126 |
    load    [ext_nvector + 1], $f3      # |     11,126 |     11,126 |
    fmul    $f2, $f3, $f3               # |     11,126 |     11,126 |
    fadd    $f1, $f3, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i24 + 1]             # |     11,126 |     11,126 |
    load    [$i24 + 2], $f1             # |     11,126 |     11,126 |
    load    [ext_nvector + 2], $f3      # |     11,126 |     11,126 |
    fmul    $f2, $f3, $f2               # |     11,126 |     11,126 |
    fadd    $f1, $f2, $f1               # |     11,126 |     11,126 |
    store   $f1, [$i24 + 2]             # |     11,126 |     11,126 |
    load    [$ig1 + 0], $i12            # |     11,126 |     11,126 |
    load    [$i12 + 0], $i1             # |     11,126 |     11,126 |
    be      $i1, -1, be.22087           # |     11,126 |     11,126 |
.count dual_jmp
    b       bne.22087                   # |     11,126 |     11,126 |
bg.22086:
    li      0, $i2                      # |      7,370 |      7,370 |
.count storer
    add     $i1, $i23, $tmp             # |      7,370 |      7,370 |
    store   $i2, [$tmp + 0]             # |      7,370 |      7,370 |
    load    [ext_nvector + 0], $f1      # |      7,370 |      7,370 |
.count load_float
    load    [f.21546], $f2              # |      7,370 |      7,370 |
    load    [$i24 + 0], $f3             # |      7,370 |      7,370 |
    fmul    $f3, $f1, $f4               # |      7,370 |      7,370 |
    load    [$i24 + 1], $f5             # |      7,370 |      7,370 |
    load    [ext_nvector + 1], $f6      # |      7,370 |      7,370 |
    fmul    $f5, $f6, $f5               # |      7,370 |      7,370 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |
    load    [$i24 + 2], $f5             # |      7,370 |      7,370 |
    load    [ext_nvector + 2], $f6      # |      7,370 |      7,370 |
    fmul    $f5, $f6, $f5               # |      7,370 |      7,370 |
    fadd    $f4, $f5, $f4               # |      7,370 |      7,370 |
    fmul    $f2, $f4, $f2               # |      7,370 |      7,370 |
    fmul    $f2, $f1, $f1               # |      7,370 |      7,370 |
    fadd    $f3, $f1, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i24 + 0]             # |      7,370 |      7,370 |
    load    [$i24 + 1], $f1             # |      7,370 |      7,370 |
    load    [ext_nvector + 1], $f3      # |      7,370 |      7,370 |
    fmul    $f2, $f3, $f3               # |      7,370 |      7,370 |
    fadd    $f1, $f3, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i24 + 1]             # |      7,370 |      7,370 |
    load    [$i24 + 2], $f1             # |      7,370 |      7,370 |
    load    [ext_nvector + 2], $f3      # |      7,370 |      7,370 |
    fmul    $f2, $f3, $f2               # |      7,370 |      7,370 |
    fadd    $f1, $f2, $f1               # |      7,370 |      7,370 |
    store   $f1, [$i24 + 2]             # |      7,370 |      7,370 |
    load    [$ig1 + 0], $i12            # |      7,370 |      7,370 |
    load    [$i12 + 0], $i1             # |      7,370 |      7,370 |
    bne     $i1, -1, bne.22087          # |      7,370 |      7,370 |
be.22087:
    load    [$i28 + 1], $f1
    fmul    $f16, $f1, $f15
    load    [ext_nvector + 0], $f1
    fmul    $f1, $fg14, $f1
    load    [ext_nvector + 1], $f2
    fmul    $f2, $fg12, $f2
    fadd    $f1, $f2, $f1
    load    [ext_nvector + 2], $f2
    fmul    $f2, $fg13, $f2
    fadd_n  $f1, $f2, $f1
    fmul    $f1, $f14, $f1
    load    [$i24 + 0], $f2
    fmul    $f2, $fg14, $f2
    load    [$i24 + 1], $f3
    fmul    $f3, $fg12, $f3
    fadd    $f2, $f3, $f2
    load    [$i24 + 2], $f3
    fmul    $f3, $fg13, $f3
    fadd_n  $f2, $f3, $f2
    ble     $f1, $f0, ble.22103
.count dual_jmp
    b       bg.22103
bne.22087:
    be      $i1, 99, bne.22092          # |     18,496 |     18,496 |
bne.22088:
    call    solver_fast.2796            # |     18,496 |     18,496 |
    be      $i1, 0, be.22101            # |     18,496 |     18,496 |
bne.22089:
    ble     $fc7, $fg0, be.22101        # |      5,091 |      5,091 |
bg.22090:
    load    [$i12 + 1], $i1             # |      4,884 |      4,884 |
    be      $i1, -1, be.22101           # |      4,884 |      4,884 |
bne.22091:
    li      0, $i8                      # |      4,884 |      4,884 |
    load    [ext_and_net + $i1], $i9    # |      4,884 |      4,884 |
    jal     shadow_check_and_group.2862, $ra1# |      4,884 |      4,884 |
    bne     $i1, 0, bne.22092           # |      4,884 |      4,884 |
be.22092:
    load    [$i12 + 2], $i1             # |      4,517 |      4,517 |
    be      $i1, -1, be.22101           # |      4,517 |      4,517 |
bne.22093:
    li      0, $i8                      # |      4,517 |      4,517 |
    load    [ext_and_net + $i1], $i9    # |      4,517 |      4,517 |
    jal     shadow_check_and_group.2862, $ra1# |      4,517 |      4,517 |
    bne     $i1, 0, bne.22092           # |      4,517 |      4,517 |
be.22094:
    li      3, $i10                     # |      4,439 |      4,439 |
.count move_args
    mov     $i12, $i11                  # |      4,439 |      4,439 |
    jal     shadow_check_one_or_group.2865, $ra2# |      4,439 |      4,439 |
    be      $i1, 0, be.22101            # |      4,439 |      4,439 |
bne.22092:
    li      1, $i1                      # |        785 |        785 |
    load    [$i12 + 1], $i1             # |        785 |        785 |
    be      $i1, -1, be.22101           # |        785 |        785 |
bne.22097:
    li      0, $i8                      # |        785 |        785 |
    load    [ext_and_net + $i1], $i9    # |        785 |        785 |
    jal     shadow_check_and_group.2862, $ra1# |        785 |        785 |
    bne     $i1, 0, bne.22098           # |        785 |        785 |
be.22098:
    load    [$i12 + 2], $i1             # |        418 |        418 |
    be      $i1, -1, be.22101           # |        418 |        418 |
bne.22099:
    li      0, $i8                      # |        418 |        418 |
    load    [ext_and_net + $i1], $i9    # |        418 |        418 |
    jal     shadow_check_and_group.2862, $ra1# |        418 |        418 |
    bne     $i1, 0, bne.22098           # |        418 |        418 |
be.22100:
    li      3, $i10                     # |        340 |        340 |
.count move_args
    mov     $i12, $i11                  # |        340 |        340 |
    jal     shadow_check_one_or_group.2865, $ra2# |        340 |        340 |
    bne     $i1, 0, bne.22098           # |        340 |        340 |
be.22101:
    li      1, $i12                     # |     17,711 |     17,711 |
.count move_args
    mov     $ig1, $i13                  # |     17,711 |     17,711 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |     17,711 |     17,711 |
    load    [$i28 + 1], $f1             # |     17,711 |     17,711 |
    fmul    $f16, $f1, $f15             # |     17,711 |     17,711 |
    bne     $i1, 0, bne.22102           # |     17,711 |     17,711 |
be.22102:
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
    bg      $f1, $f0, bg.22103          # |     17,538 |     17,538 |
ble.22103:
    ble     $f2, $f0, bne.22102         # |          2 |          2 |
.count dual_jmp
    b       bg.22104
bg.22103:
    fmul    $f1, $fg16, $f3             # |     17,536 |     17,536 |
    fadd    $fg4, $f3, $fg4             # |     17,536 |     17,536 |
    fmul    $f1, $fg11, $f3             # |     17,536 |     17,536 |
    fadd    $fg5, $f3, $fg5             # |     17,536 |     17,536 |
    fmul    $f1, $fg15, $f1             # |     17,536 |     17,536 |
    fadd    $fg6, $f1, $fg6             # |     17,536 |     17,536 |
    bg      $f2, $f0, bg.22104          # |     17,536 |     17,536 |
bne.22102:
    li      ext_intersection_point, $i2 # |     11,260 |     11,260 |
    load    [ext_intersection_point + 0], $fg8# |     11,260 |     11,260 |
    load    [ext_intersection_point + 1], $fg9# |     11,260 |     11,260 |
    load    [ext_intersection_point + 2], $fg10# |     11,260 |     11,260 |
    add     $ig0, -1, $i1               # |     11,260 |     11,260 |
    call    setup_startp_constants.2831 # |     11,260 |     11,260 |
    add     $ig4, -1, $i19              # |     11,260 |     11,260 |
.count move_args
    mov     $i24, $i20                  # |     11,260 |     11,260 |
    jal     trace_reflections.2915, $ra4# |     11,260 |     11,260 |
    ble     $f16, $fc9, bg.22065        # |     11,260 |     11,260 |
.count dual_jmp
    b       bg.22105                    # |     11,260 |     11,260 |
bg.22104:
    fmul    $f2, $f2, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f1, $f1               # |      6,451 |      6,451 |
    fmul    $f1, $f15, $f1              # |      6,451 |      6,451 |
    fadd    $fg4, $f1, $fg4             # |      6,451 |      6,451 |
    fadd    $fg5, $f1, $fg5             # |      6,451 |      6,451 |
    fadd    $fg6, $f1, $fg6             # |      6,451 |      6,451 |
    li      ext_intersection_point, $i2 # |      6,451 |      6,451 |
    load    [ext_intersection_point + 0], $fg8# |      6,451 |      6,451 |
    load    [ext_intersection_point + 1], $fg9# |      6,451 |      6,451 |
    load    [ext_intersection_point + 2], $fg10# |      6,451 |      6,451 |
    add     $ig0, -1, $i1               # |      6,451 |      6,451 |
    call    setup_startp_constants.2831 # |      6,451 |      6,451 |
    add     $ig4, -1, $i19              # |      6,451 |      6,451 |
.count move_args
    mov     $i24, $i20                  # |      6,451 |      6,451 |
    jal     trace_reflections.2915, $ra4# |      6,451 |      6,451 |
    ble     $f16, $fc9, bg.22065        # |      6,451 |      6,451 |
.count dual_jmp
    b       bg.22105                    # |      6,451 |      6,451 |
bne.22098:
    load    [$i28 + 1], $f1             # |        785 |        785 |
    fmul    $f16, $f1, $f15             # |        785 |        785 |
    li      ext_intersection_point, $i2 # |        785 |        785 |
    load    [ext_intersection_point + 0], $fg8# |        785 |        785 |
    load    [ext_intersection_point + 1], $fg9# |        785 |        785 |
    load    [ext_intersection_point + 2], $fg10# |        785 |        785 |
    add     $ig0, -1, $i1               # |        785 |        785 |
    call    setup_startp_constants.2831 # |        785 |        785 |
    add     $ig4, -1, $i19              # |        785 |        785 |
.count move_args
    mov     $i24, $i20                  # |        785 |        785 |
    jal     trace_reflections.2915, $ra4# |        785 |        785 |
    ble     $f16, $fc9, bg.22065        # |        785 |        785 |
bg.22105:
    bl      $i23, 4, bl.22106           # |     18,496 |     18,496 |
bge.22106:
    load    [$i27 + 2], $i1
    be      $i1, 2, be.22107
.count dual_jmp
    b       bg.22065
bl.22106:
    add     $i23, 1, $i1                # |     18,496 |     18,496 |
    add     $i0, -1, $i2                # |     18,496 |     18,496 |
.count storer
    add     $i26, $i1, $tmp             # |     18,496 |     18,496 |
    store   $i2, [$tmp + 0]             # |     18,496 |     18,496 |
    load    [$i27 + 2], $i1             # |     18,496 |     18,496 |
    bne     $i1, 2, bg.22065            # |     18,496 |     18,496 |
be.22107:
    fadd    $f17, $fg7, $f17            # |      7,370 |      7,370 |
    add     $i23, 1, $i23               # |      7,370 |      7,370 |
    load    [$i28 + 0], $f1             # |      7,370 |      7,370 |
    fsub    $fc0, $f1, $f1              # |      7,370 |      7,370 |
    fmul    $f16, $f1, $f16             # |      7,370 |      7,370 |
    b       trace_ray.2920              # |      7,370 |      7,370 |
bg.22065:
    jr      $ra5                        # |     14,400 |     14,400 |
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
    bne     $i1, -1, bne.22108          # |  1,116,120 |  1,116,120 |
be.22108:
    ble     $fg7, $fc7, bne.22137
.count dual_jmp
    b       bg.22116
bne.22108:
    bne     $i1, 99, bne.22109          # |  1,116,120 |  1,116,120 |
be.22109:
    load    [$i14 + 1], $i1
    be      $i1, -1, ble.22115
bne.22110:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 2], $i1
    be      $i1, -1, ble.22115
bne.22111:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 3], $i1
    be      $i1, -1, ble.22115
bne.22112:
    li      0, $i8
    load    [ext_and_net + $i1], $i9
.count move_args
    mov     $i19, $i10
    jal     solve_each_element_fast.2885, $ra1
    load    [$i14 + 4], $i1
    be      $i1, -1, ble.22115
bne.22113:
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
    ble     $fg7, $fc7, bne.22137
.count dual_jmp
    b       bg.22116
bne.22109:
.count move_args
    mov     $i19, $i2                   # |  1,116,120 |  1,116,120 |
    call    solver_fast2.2814           # |  1,116,120 |  1,116,120 |
    be      $i1, 0, ble.22115           # |  1,116,120 |  1,116,120 |
bne.22114:
    bg      $fg7, $fg0, bg.22115        # |    679,798 |    679,798 |
ble.22115:
    li      1, $i16                     # |    436,322 |    436,322 |
.count move_args
    mov     $ig1, $i17                  # |    436,322 |    436,322 |
.count move_args
    mov     $i19, $i18                  # |    436,322 |    436,322 |
    jal     trace_or_matrix_fast.2893, $ra3# |    436,322 |    436,322 |
    ble     $fg7, $fc7, bne.22137       # |    436,322 |    436,322 |
.count dual_jmp
    b       bg.22116                    # |    436,322 |    436,322 |
bg.22115:
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
    ble     $fg7, $fc7, bne.22137       # |    679,798 |    679,798 |
bg.22116:
    ble     $fc12, $fg7, bne.22137      # |  1,116,120 |  1,116,120 |
bg.22117:
    li      1, $i1                      # |    642,233 |    642,233 |
    load    [$i19 + 0], $i1             # |    642,233 |    642,233 |
    load    [ext_objects + $ig3], $i15  # |    642,233 |    642,233 |
    load    [$i15 + 1], $i2             # |    642,233 |    642,233 |
    bne     $i2, 1, bne.22119           # |    642,233 |    642,233 |
be.22119:
    store   $f0, [ext_nvector + 0]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 1]      # |    114,909 |    114,909 |
    store   $f0, [ext_nvector + 2]      # |    114,909 |    114,909 |
    add     $ig2, -1, $i2               # |    114,909 |    114,909 |
    load    [$i1 + $i2], $f1            # |    114,909 |    114,909 |
.count move_args
    mov     $i15, $i1                   # |    114,909 |    114,909 |
    bne     $f1, $f0, bne.22120         # |    114,909 |    114,909 |
be.22120:
    store   $f0, [ext_nvector + $i2]
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i12
    load    [$i12 + 0], $i1
    be      $i1, -1, be.22126
.count dual_jmp
    b       bne.22126
bne.22120:
    bg      $f1, $f0, bg.22121          # |    114,909 |    114,909 |
ble.22121:
    store   $fc0, [ext_nvector + $i2]   # |     90,131 |     90,131 |
    jal     utexture.2908, $ra1         # |     90,131 |     90,131 |
    load    [$ig1 + 0], $i12            # |     90,131 |     90,131 |
    load    [$i12 + 0], $i1             # |     90,131 |     90,131 |
    be      $i1, -1, be.22126           # |     90,131 |     90,131 |
.count dual_jmp
    b       bne.22126                   # |     90,131 |     90,131 |
bg.22121:
    store   $fc3, [ext_nvector + $i2]   # |     24,778 |     24,778 |
    jal     utexture.2908, $ra1         # |     24,778 |     24,778 |
    load    [$ig1 + 0], $i12            # |     24,778 |     24,778 |
    load    [$i12 + 0], $i1             # |     24,778 |     24,778 |
    be      $i1, -1, be.22126           # |     24,778 |     24,778 |
.count dual_jmp
    b       bne.22126                   # |     24,778 |     24,778 |
bne.22119:
    bne     $i2, 2, bne.22122           # |    527,324 |    527,324 |
be.22122:
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
.count move_args
    mov     $i15, $i1                   # |    391,531 |    391,531 |
    jal     utexture.2908, $ra1         # |    391,531 |    391,531 |
    load    [$ig1 + 0], $i12            # |    391,531 |    391,531 |
    load    [$i12 + 0], $i1             # |    391,531 |    391,531 |
    be      $i1, -1, be.22126           # |    391,531 |    391,531 |
.count dual_jmp
    b       bne.22126                   # |    391,531 |    391,531 |
bne.22122:
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
    bne     $i1, 0, bne.22123           # |    135,793 |    135,793 |
be.22123:
    store   $f1, [ext_nvector + 0]      # |    135,793 |    135,793 |
    store   $f3, [ext_nvector + 1]      # |    135,793 |    135,793 |
    store   $f5, [ext_nvector + 2]      # |    135,793 |    135,793 |
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
    be      $f2, $f0, be.22124          # |    135,793 |    135,793 |
.count dual_jmp
    b       bne.22124                   # |    135,793 |    135,793 |
bne.22123:
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
    load    [ext_nvector + 0], $f1
    load    [$i15 + 6], $i1
    fmul    $f1, $f1, $f2
    load    [ext_nvector + 1], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    load    [ext_nvector + 2], $f3
    fmul    $f3, $f3, $f3
    fadd    $f2, $f3, $f2
    fsqrt   $f2, $f2
    bne     $f2, $f0, bne.22124
be.22124:
    mov     $fc0, $f2
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 0]
    load    [ext_nvector + 1], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 1]
    load    [ext_nvector + 2], $f1
    fmul    $f1, $f2, $f1
    store   $f1, [ext_nvector + 2]
.count move_args
    mov     $i15, $i1
    jal     utexture.2908, $ra1
    load    [$ig1 + 0], $i12
    load    [$i12 + 0], $i1
    be      $i1, -1, be.22126
.count dual_jmp
    b       bne.22126
bne.22124:
    bne     $i1, 0, bne.22125           # |    135,793 |    135,793 |
be.22125:
    finv    $f2, $f2                    # |    103,847 |    103,847 |
    fmul    $f1, $f2, $f1               # |    103,847 |    103,847 |
    store   $f1, [ext_nvector + 0]      # |    103,847 |    103,847 |
    load    [ext_nvector + 1], $f1      # |    103,847 |    103,847 |
    fmul    $f1, $f2, $f1               # |    103,847 |    103,847 |
    store   $f1, [ext_nvector + 1]      # |    103,847 |    103,847 |
    load    [ext_nvector + 2], $f1      # |    103,847 |    103,847 |
    fmul    $f1, $f2, $f1               # |    103,847 |    103,847 |
    store   $f1, [ext_nvector + 2]      # |    103,847 |    103,847 |
.count move_args
    mov     $i15, $i1                   # |    103,847 |    103,847 |
    jal     utexture.2908, $ra1         # |    103,847 |    103,847 |
    load    [$ig1 + 0], $i12            # |    103,847 |    103,847 |
    load    [$i12 + 0], $i1             # |    103,847 |    103,847 |
    be      $i1, -1, be.22126           # |    103,847 |    103,847 |
.count dual_jmp
    b       bne.22126                   # |    103,847 |    103,847 |
bne.22125:
    finv_n  $f2, $f2                    # |     31,946 |     31,946 |
    fmul    $f1, $f2, $f1               # |     31,946 |     31,946 |
    store   $f1, [ext_nvector + 0]      # |     31,946 |     31,946 |
    load    [ext_nvector + 1], $f1      # |     31,946 |     31,946 |
    fmul    $f1, $f2, $f1               # |     31,946 |     31,946 |
    store   $f1, [ext_nvector + 1]      # |     31,946 |     31,946 |
    load    [ext_nvector + 2], $f1      # |     31,946 |     31,946 |
    fmul    $f1, $f2, $f1               # |     31,946 |     31,946 |
    store   $f1, [ext_nvector + 2]      # |     31,946 |     31,946 |
.count move_args
    mov     $i15, $i1                   # |     31,946 |     31,946 |
    jal     utexture.2908, $ra1         # |     31,946 |     31,946 |
    load    [$ig1 + 0], $i12            # |     31,946 |     31,946 |
    load    [$i12 + 0], $i1             # |     31,946 |     31,946 |
    bne     $i1, -1, bne.22126          # |     31,946 |     31,946 |
be.22126:
    li      0, $i1
    load    [$i15 + 7], $i1
    load    [ext_nvector + 0], $f1
    fmul    $f1, $fg14, $f1
    load    [ext_nvector + 1], $f2
    fmul    $f2, $fg12, $f2
    fadd    $f1, $f2, $f1
    load    [ext_nvector + 2], $f2
    fmul    $f2, $fg13, $f2
    fadd_n  $f1, $f2, $f1
    ble     $f1, $f0, ble.22142
.count dual_jmp
    b       bg.22142
bne.22126:
    be      $i1, 99, bne.22131          # |    642,233 |    642,233 |
bne.22127:
    call    solver_fast.2796            # |    642,233 |    642,233 |
    be      $i1, 0, be.22140            # |    642,233 |    642,233 |
bne.22128:
    ble     $fc7, $fg0, be.22140        # |    200,976 |    200,976 |
bg.22129:
    load    [$i12 + 1], $i1             # |    194,041 |    194,041 |
    be      $i1, -1, be.22140           # |    194,041 |    194,041 |
bne.22130:
    li      0, $i8                      # |    194,041 |    194,041 |
    load    [ext_and_net + $i1], $i9    # |    194,041 |    194,041 |
    jal     shadow_check_and_group.2862, $ra1# |    194,041 |    194,041 |
    bne     $i1, 0, bne.22131           # |    194,041 |    194,041 |
be.22131:
    load    [$i12 + 2], $i1             # |    153,753 |    153,753 |
    be      $i1, -1, be.22140           # |    153,753 |    153,753 |
bne.22132:
    li      0, $i8                      # |    153,753 |    153,753 |
    load    [ext_and_net + $i1], $i9    # |    153,753 |    153,753 |
    jal     shadow_check_and_group.2862, $ra1# |    153,753 |    153,753 |
    bne     $i1, 0, bne.22131           # |    153,753 |    153,753 |
be.22133:
    li      3, $i10                     # |    143,619 |    143,619 |
.count move_args
    mov     $i12, $i11                  # |    143,619 |    143,619 |
    jal     shadow_check_one_or_group.2865, $ra2# |    143,619 |    143,619 |
    be      $i1, 0, be.22140            # |    143,619 |    143,619 |
bne.22131:
    li      1, $i1                      # |    115,388 |    115,388 |
    load    [$i12 + 1], $i1             # |    115,388 |    115,388 |
    be      $i1, -1, be.22140           # |    115,388 |    115,388 |
bne.22136:
    li      0, $i8                      # |    115,388 |    115,388 |
    load    [ext_and_net + $i1], $i9    # |    115,388 |    115,388 |
    jal     shadow_check_and_group.2862, $ra1# |    115,388 |    115,388 |
    bne     $i1, 0, bne.22137           # |    115,388 |    115,388 |
be.22137:
    load    [$i12 + 2], $i1             # |     75,100 |     75,100 |
    be      $i1, -1, be.22140           # |     75,100 |     75,100 |
bne.22138:
    li      0, $i8                      # |     75,100 |     75,100 |
    load    [ext_and_net + $i1], $i9    # |     75,100 |     75,100 |
    jal     shadow_check_and_group.2862, $ra1# |     75,100 |     75,100 |
    bne     $i1, 0, bne.22137           # |     75,100 |     75,100 |
be.22139:
    li      3, $i10                     # |     64,966 |     64,966 |
.count move_args
    mov     $i12, $i11                  # |     64,966 |     64,966 |
    jal     shadow_check_one_or_group.2865, $ra2# |     64,966 |     64,966 |
    bne     $i1, 0, bne.22137           # |     64,966 |     64,966 |
be.22140:
    li      1, $i12                     # |    526,845 |    526,845 |
.count move_args
    mov     $ig1, $i13                  # |    526,845 |    526,845 |
    jal     shadow_check_one_or_matrix.2868, $ra3# |    526,845 |    526,845 |
    bne     $i1, 0, bne.22137           # |    526,845 |    526,845 |
be.22141:
    load    [$i15 + 7], $i1             # |    523,067 |    523,067 |
    load    [ext_nvector + 0], $f1      # |    523,067 |    523,067 |
    fmul    $f1, $fg14, $f1             # |    523,067 |    523,067 |
    load    [ext_nvector + 1], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg12, $f2             # |    523,067 |    523,067 |
    fadd    $f1, $f2, $f1               # |    523,067 |    523,067 |
    load    [ext_nvector + 2], $f2      # |    523,067 |    523,067 |
    fmul    $f2, $fg13, $f2             # |    523,067 |    523,067 |
    fadd_n  $f1, $f2, $f1               # |    523,067 |    523,067 |
    bg      $f1, $f0, bg.22142          # |    523,067 |    523,067 |
ble.22142:
    mov     $f0, $f1                    # |        709 |        709 |
    fmul    $f14, $f1, $f1              # |        709 |        709 |
    load    [$i1 + 0], $f2              # |        709 |        709 |
    fmul    $f1, $f2, $f1               # |        709 |        709 |
    fmul    $f1, $fg16, $f2             # |        709 |        709 |
    fadd    $fg1, $f2, $fg1             # |        709 |        709 |
    fmul    $f1, $fg11, $f2             # |        709 |        709 |
    fadd    $fg2, $f2, $fg2             # |        709 |        709 |
    fmul    $f1, $fg15, $f1             # |        709 |        709 |
    fadd    $fg3, $f1, $fg3             # |        709 |        709 |
    jr      $ra4                        # |        709 |        709 |
bg.22142:
    fmul    $f14, $f1, $f1              # |    522,358 |    522,358 |
    load    [$i1 + 0], $f2              # |    522,358 |    522,358 |
    fmul    $f1, $f2, $f1               # |    522,358 |    522,358 |
    fmul    $f1, $fg16, $f2             # |    522,358 |    522,358 |
    fadd    $fg1, $f2, $fg1             # |    522,358 |    522,358 |
    fmul    $f1, $fg11, $f2             # |    522,358 |    522,358 |
    fadd    $fg2, $f2, $fg2             # |    522,358 |    522,358 |
    fmul    $f1, $fg15, $f1             # |    522,358 |    522,358 |
    fadd    $fg3, $f1, $fg3             # |    522,358 |    522,358 |
    jr      $ra4                        # |    522,358 |    522,358 |
bne.22137:
    jr      $ra4                        # |    593,053 |    593,053 |
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
    bl      $i22, 0, bl.22143           # |    558,060 |    558,060 |
bge.22143:
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
    bg      $f0, $f1, bg.22144          # |    558,060 |    558,060 |
ble.22144:
    fmul    $f1, $fc1, $f14             # |    381,373 |    381,373 |
    load    [$i20 + $i22], $i19         # |    381,373 |    381,373 |
    jal     trace_diffuse_ray.2926, $ra4# |    381,373 |    381,373 |
    add     $i22, -2, $i22              # |    381,373 |    381,373 |
    bge     $i22, 0, bge.22147          # |    381,373 |    381,373 |
.count dual_jmp
    b       bl.22143                    # |     15,574 |     15,574 |
bg.22144:
    fmul    $f1, $fc2, $f14             # |    176,687 |    176,687 |
    add     $i22, 1, $i1                # |    176,687 |    176,687 |
    load    [$i20 + $i1], $i19          # |    176,687 |    176,687 |
    jal     trace_diffuse_ray.2926, $ra4# |    176,687 |    176,687 |
    add     $i22, -2, $i22              # |    176,687 |    176,687 |
    bl      $i22, 0, bl.22143           # |    176,687 |    176,687 |
bge.22147:
    load    [$i20 + $i22], $i1          # |    539,458 |    539,458 |
    load    [$i1 + 0], $i1              # |    539,458 |    539,458 |
    load    [$i1 + 0], $f1              # |    539,458 |    539,458 |
    load    [$i21 + 0], $f2             # |    539,458 |    539,458 |
    fmul    $f1, $f2, $f1               # |    539,458 |    539,458 |
    load    [$i1 + 1], $f2              # |    539,458 |    539,458 |
    load    [$i21 + 1], $f3             # |    539,458 |    539,458 |
    fmul    $f2, $f3, $f2               # |    539,458 |    539,458 |
    fadd    $f1, $f2, $f1               # |    539,458 |    539,458 |
    load    [$i1 + 2], $f2              # |    539,458 |    539,458 |
    load    [$i21 + 2], $f3             # |    539,458 |    539,458 |
    fmul    $f2, $f3, $f2               # |    539,458 |    539,458 |
    fadd    $f1, $f2, $f1               # |    539,458 |    539,458 |
    bg      $f0, $f1, bg.22148          # |    539,458 |    539,458 |
ble.22148:
    fmul    $f1, $fc1, $f14             # |    211,266 |    211,266 |
    load    [$i20 + $i22], $i19         # |    211,266 |    211,266 |
    jal     trace_diffuse_ray.2926, $ra4# |    211,266 |    211,266 |
    add     $i22, -2, $i22              # |    211,266 |    211,266 |
    b       iter_trace_diffuse_rays.2929# |    211,266 |    211,266 |
bg.22148:
    fmul    $f1, $fc2, $f14             # |    328,192 |    328,192 |
    add     $i22, 1, $i1                # |    328,192 |    328,192 |
    load    [$i20 + $i1], $i19          # |    328,192 |    328,192 |
    jal     trace_diffuse_ray.2926, $ra4# |    328,192 |    328,192 |
    add     $i22, -2, $i22              # |    328,192 |    328,192 |
    b       iter_trace_diffuse_rays.2929# |    328,192 |    328,192 |
bl.22143:
    jr      $ra5                        # |     18,602 |     18,602 |
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
    bne     $i27, 0, bne.22149          # |      1,737 |      1,737 |
be.22149:
    be      $i27, 1, be.22151           # |        348 |        348 |
.count dual_jmp
    b       bne.22151                   # |        348 |        348 |
bne.22149:
    load    [ext_dirvecs + 0], $i20     # |      1,389 |      1,389 |
    load    [$i26 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i26 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i26 + 2], $fg10           # |      1,389 |      1,389 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |
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
    bg      $f0, $f1, bg.22150          # |      1,389 |      1,389 |
ble.22150:
    load    [$i20 + 118], $i19          # |         90 |         90 |
    fmul    $f1, $fc1, $f14             # |         90 |         90 |
    jal     trace_diffuse_ray.2926, $ra4# |         90 |         90 |
    li      116, $i22                   # |         90 |         90 |
.count move_args
    mov     $i25, $i21                  # |         90 |         90 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         90 |         90 |
    be      $i27, 1, be.22151           # |         90 |         90 |
.count dual_jmp
    b       bne.22151                   # |         64 |         64 |
bg.22150:
    load    [$i20 + 119], $i19          # |      1,299 |      1,299 |
    fmul    $f1, $fc2, $f14             # |      1,299 |      1,299 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,299 |      1,299 |
    li      116, $i22                   # |      1,299 |      1,299 |
.count move_args
    mov     $i25, $i21                  # |      1,299 |      1,299 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,299 |      1,299 |
    bne     $i27, 1, bne.22151          # |      1,299 |      1,299 |
be.22151:
    be      $i27, 2, be.22153           # |        348 |        348 |
.count dual_jmp
    b       bne.22153                   # |        348 |        348 |
bne.22151:
    load    [ext_dirvecs + 1], $i20     # |      1,389 |      1,389 |
    load    [$i26 + 0], $fg8            # |      1,389 |      1,389 |
    load    [$i26 + 1], $fg9            # |      1,389 |      1,389 |
    load    [$i26 + 2], $fg10           # |      1,389 |      1,389 |
    add     $ig0, -1, $i1               # |      1,389 |      1,389 |
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
    bg      $f0, $f1, bg.22152          # |      1,389 |      1,389 |
ble.22152:
    load    [$i20 + 118], $i19          # |         96 |         96 |
    fmul    $f1, $fc1, $f14             # |         96 |         96 |
    jal     trace_diffuse_ray.2926, $ra4# |         96 |         96 |
    li      116, $i22                   # |         96 |         96 |
.count move_args
    mov     $i25, $i21                  # |         96 |         96 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         96 |         96 |
    be      $i27, 2, be.22153           # |         96 |         96 |
.count dual_jmp
    b       bne.22153                   # |         75 |         75 |
bg.22152:
    load    [$i20 + 119], $i19          # |      1,293 |      1,293 |
    fmul    $f1, $fc2, $f14             # |      1,293 |      1,293 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,293 |      1,293 |
    li      116, $i22                   # |      1,293 |      1,293 |
.count move_args
    mov     $i25, $i21                  # |      1,293 |      1,293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,293 |      1,293 |
    bne     $i27, 2, bne.22153          # |      1,293 |      1,293 |
be.22153:
    be      $i27, 3, be.22155           # |        337 |        337 |
.count dual_jmp
    b       bne.22155                   # |        337 |        337 |
bne.22153:
    load    [ext_dirvecs + 2], $i20     # |      1,400 |      1,400 |
    load    [$i26 + 0], $fg8            # |      1,400 |      1,400 |
    load    [$i26 + 1], $fg9            # |      1,400 |      1,400 |
    load    [$i26 + 2], $fg10           # |      1,400 |      1,400 |
    add     $ig0, -1, $i1               # |      1,400 |      1,400 |
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
    bg      $f0, $f1, bg.22154          # |      1,400 |      1,400 |
ble.22154:
    load    [$i20 + 118], $i19          # |        126 |        126 |
    fmul    $f1, $fc1, $f14             # |        126 |        126 |
    jal     trace_diffuse_ray.2926, $ra4# |        126 |        126 |
    li      116, $i22                   # |        126 |        126 |
.count move_args
    mov     $i25, $i21                  # |        126 |        126 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        126 |        126 |
    be      $i27, 3, be.22155           # |        126 |        126 |
.count dual_jmp
    b       bne.22155                   # |        100 |        100 |
bg.22154:
    load    [$i20 + 119], $i19          # |      1,274 |      1,274 |
    fmul    $f1, $fc2, $f14             # |      1,274 |      1,274 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,274 |      1,274 |
    li      116, $i22                   # |      1,274 |      1,274 |
.count move_args
    mov     $i25, $i21                  # |      1,274 |      1,274 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,274 |      1,274 |
    bne     $i27, 3, bne.22155          # |      1,274 |      1,274 |
be.22155:
    be      $i27, 4, be.22157           # |        352 |        352 |
.count dual_jmp
    b       bne.22157                   # |        352 |        352 |
bne.22155:
    load    [ext_dirvecs + 3], $i20     # |      1,385 |      1,385 |
    load    [$i26 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i26 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i26 + 2], $fg10           # |      1,385 |      1,385 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |
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
    bg      $f0, $f1, bg.22156          # |      1,385 |      1,385 |
ble.22156:
    load    [$i20 + 118], $i19          # |        115 |        115 |
    fmul    $f1, $fc1, $f14             # |        115 |        115 |
    jal     trace_diffuse_ray.2926, $ra4# |        115 |        115 |
    li      116, $i22                   # |        115 |        115 |
.count move_args
    mov     $i25, $i21                  # |        115 |        115 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        115 |        115 |
    be      $i27, 4, be.22157           # |        115 |        115 |
.count dual_jmp
    b       bne.22157                   # |         90 |         90 |
bg.22156:
    load    [$i20 + 119], $i19          # |      1,270 |      1,270 |
    fmul    $f1, $fc2, $f14             # |      1,270 |      1,270 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,270 |      1,270 |
    li      116, $i22                   # |      1,270 |      1,270 |
.count move_args
    mov     $i25, $i21                  # |      1,270 |      1,270 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,270 |      1,270 |
    bne     $i27, 4, bne.22157          # |      1,270 |      1,270 |
be.22157:
    load    [$i23 + 4], $i1             # |        352 |        352 |
    load    [$i1 + $i24], $i1           # |        352 |        352 |
    load    [$i1 + 0], $f1              # |        352 |        352 |
    fmul    $f1, $fg1, $f1              # |        352 |        352 |
    fadd    $fg4, $f1, $fg4             # |        352 |        352 |
    load    [$i1 + 1], $f1              # |        352 |        352 |
    fmul    $f1, $fg2, $f1              # |        352 |        352 |
    fadd    $fg5, $f1, $fg5             # |        352 |        352 |
    load    [$i1 + 2], $f1              # |        352 |        352 |
    fmul    $f1, $fg3, $f1              # |        352 |        352 |
    fadd    $fg6, $f1, $fg6             # |        352 |        352 |
    jr      $ra6                        # |        352 |        352 |
bne.22157:
    load    [ext_dirvecs + 4], $i20     # |      1,385 |      1,385 |
    load    [$i26 + 0], $fg8            # |      1,385 |      1,385 |
    load    [$i26 + 1], $fg9            # |      1,385 |      1,385 |
    load    [$i26 + 2], $fg10           # |      1,385 |      1,385 |
    add     $ig0, -1, $i1               # |      1,385 |      1,385 |
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
    bg      $f0, $f1, bg.22158          # |      1,385 |      1,385 |
ble.22158:
    load    [$i20 + 118], $i19          # |         98 |         98 |
    fmul    $f1, $fc1, $f14             # |         98 |         98 |
    jal     trace_diffuse_ray.2926, $ra4# |         98 |         98 |
    li      116, $i22                   # |         98 |         98 |
.count move_args
    mov     $i25, $i21                  # |         98 |         98 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         98 |         98 |
    load    [$i23 + 4], $i1             # |         98 |         98 |
    load    [$i1 + $i24], $i1           # |         98 |         98 |
    load    [$i1 + 0], $f1              # |         98 |         98 |
    fmul    $f1, $fg1, $f1              # |         98 |         98 |
    fadd    $fg4, $f1, $fg4             # |         98 |         98 |
    load    [$i1 + 1], $f1              # |         98 |         98 |
    fmul    $f1, $fg2, $f1              # |         98 |         98 |
    fadd    $fg5, $f1, $fg5             # |         98 |         98 |
    load    [$i1 + 2], $f1              # |         98 |         98 |
    fmul    $f1, $fg3, $f1              # |         98 |         98 |
    fadd    $fg6, $f1, $fg6             # |         98 |         98 |
    jr      $ra6                        # |         98 |         98 |
bg.22158:
    load    [$i20 + 119], $i19          # |      1,287 |      1,287 |
    fmul    $f1, $fc2, $f14             # |      1,287 |      1,287 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,287 |      1,287 |
    li      116, $i22                   # |      1,287 |      1,287 |
.count move_args
    mov     $i25, $i21                  # |      1,287 |      1,287 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,287 |      1,287 |
    load    [$i23 + 4], $i1             # |      1,287 |      1,287 |
    load    [$i1 + $i24], $i1           # |      1,287 |      1,287 |
    load    [$i1 + 0], $f1              # |      1,287 |      1,287 |
    fmul    $f1, $fg1, $f1              # |      1,287 |      1,287 |
    fadd    $fg4, $f1, $fg4             # |      1,287 |      1,287 |
    load    [$i1 + 1], $f1              # |      1,287 |      1,287 |
    fmul    $f1, $fg2, $f1              # |      1,287 |      1,287 |
    fadd    $fg5, $f1, $fg5             # |      1,287 |      1,287 |
    load    [$i1 + 2], $f1              # |      1,287 |      1,287 |
    fmul    $f1, $fg3, $f1              # |      1,287 |      1,287 |
    fadd    $fg6, $f1, $fg6             # |      1,287 |      1,287 |
    jr      $ra6                        # |      1,287 |      1,287 |
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
    bg      $i23, 4, bg.22159           # |      2,430 |      2,430 |
ble.22159:
    load    [$i28 + 2], $i24            # |      2,430 |      2,430 |
    load    [$i24 + $i23], $i1          # |      2,430 |      2,430 |
    bl      $i1, 0, bg.22159            # |      2,430 |      2,430 |
bge.22160:
    load    [$i28 + 3], $i25            # |        143 |        143 |
    load    [$i25 + $i23], $i1          # |        143 |        143 |
    bne     $i1, 0, bne.22161           # |        143 |        143 |
be.22161:
    add     $i23, 1, $i29               # |         11 |         11 |
    ble     $i29, 4, ble.22175          # |         11 |         11 |
.count dual_jmp
    b       bg.22159
bne.22161:
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
    bne     $i29, 0, bne.22165          # |        132 |        132 |
be.22165:
    be      $i29, 1, be.22167           # |         25 |         25 |
.count dual_jmp
    b       bne.22167                   # |         25 |         25 |
bne.22165:
    load    [ext_dirvecs + 0], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
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
    bg      $f0, $f1, bg.22166          # |        107 |        107 |
ble.22166:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i29, 1, be.22167
.count dual_jmp
    b       bne.22167
bg.22166:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    bne     $i29, 1, bne.22167          # |        107 |        107 |
be.22167:
    be      $i29, 2, be.22169           # |         28 |         28 |
.count dual_jmp
    b       bne.22169                   # |         28 |         28 |
bne.22167:
    load    [ext_dirvecs + 1], $i20     # |        104 |        104 |
    load    [$i27 + 0], $fg8            # |        104 |        104 |
    load    [$i27 + 1], $fg9            # |        104 |        104 |
    load    [$i27 + 2], $fg10           # |        104 |        104 |
    add     $ig0, -1, $i1               # |        104 |        104 |
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
    bg      $f0, $f1, bg.22168          # |        104 |        104 |
ble.22168:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i29, 2, be.22169
.count dual_jmp
    b       bne.22169
bg.22168:
    fmul    $f1, $fc2, $f14             # |        104 |        104 |
    load    [$i20 + 119], $i19          # |        104 |        104 |
    jal     trace_diffuse_ray.2926, $ra4# |        104 |        104 |
    li      116, $i22                   # |        104 |        104 |
.count move_args
    mov     $i26, $i21                  # |        104 |        104 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        104 |        104 |
    bne     $i29, 2, bne.22169          # |        104 |        104 |
be.22169:
    be      $i29, 3, be.22171           # |         25 |         25 |
.count dual_jmp
    b       bne.22171                   # |         25 |         25 |
bne.22169:
    load    [ext_dirvecs + 2], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
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
    bg      $f0, $f1, bg.22170          # |        107 |        107 |
ble.22170:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i29, 3, be.22171
.count dual_jmp
    b       bne.22171
bg.22170:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    bne     $i29, 3, bne.22171          # |        107 |        107 |
be.22171:
    be      $i29, 4, be.22173           # |         29 |         29 |
.count dual_jmp
    b       bne.22173                   # |         29 |         29 |
bne.22171:
    load    [ext_dirvecs + 3], $i20     # |        103 |        103 |
    load    [$i27 + 0], $fg8            # |        103 |        103 |
    load    [$i27 + 1], $fg9            # |        103 |        103 |
    load    [$i27 + 2], $fg10           # |        103 |        103 |
    add     $ig0, -1, $i1               # |        103 |        103 |
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
    bg      $f0, $f1, bg.22172          # |        103 |        103 |
ble.22172:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
    be      $i29, 4, be.22173
.count dual_jmp
    b       bne.22173
bg.22172:
    fmul    $f1, $fc2, $f14             # |        103 |        103 |
    load    [$i20 + 119], $i19          # |        103 |        103 |
    jal     trace_diffuse_ray.2926, $ra4# |        103 |        103 |
    li      116, $i22                   # |        103 |        103 |
.count move_args
    mov     $i26, $i21                  # |        103 |        103 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        103 |        103 |
    bne     $i29, 4, bne.22173          # |        103 |        103 |
be.22173:
    load    [$i28 + 4], $i1             # |         25 |         25 |
    load    [$i1 + $i23], $i1           # |         25 |         25 |
    load    [$i1 + 0], $f1              # |         25 |         25 |
    fmul    $f1, $fg1, $f1              # |         25 |         25 |
    fadd    $fg4, $f1, $fg4             # |         25 |         25 |
    load    [$i1 + 1], $f1              # |         25 |         25 |
    fmul    $f1, $fg2, $f1              # |         25 |         25 |
    fadd    $fg5, $f1, $fg5             # |         25 |         25 |
    load    [$i1 + 2], $f1              # |         25 |         25 |
    fmul    $f1, $fg3, $f1              # |         25 |         25 |
    fadd    $fg6, $f1, $fg6             # |         25 |         25 |
    add     $i23, 1, $i29               # |         25 |         25 |
    ble     $i29, 4, ble.22175          # |         25 |         25 |
.count dual_jmp
    b       bg.22159
bne.22173:
    load    [ext_dirvecs + 4], $i20     # |        107 |        107 |
    load    [$i27 + 0], $fg8            # |        107 |        107 |
    load    [$i27 + 1], $fg9            # |        107 |        107 |
    load    [$i27 + 2], $fg10           # |        107 |        107 |
    add     $ig0, -1, $i1               # |        107 |        107 |
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
    bg      $f0, $f1, bg.22174          # |        107 |        107 |
ble.22174:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
.count move_args
    mov     $i26, $i21
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i28 + 4], $i1
    load    [$i1 + $i23], $i1
    load    [$i1 + 0], $f1
    fmul    $f1, $fg1, $f1
    fadd    $fg4, $f1, $fg4
    load    [$i1 + 1], $f1
    fmul    $f1, $fg2, $f1
    fadd    $fg5, $f1, $fg5
    load    [$i1 + 2], $f1
    fmul    $f1, $fg3, $f1
    fadd    $fg6, $f1, $fg6
    add     $i23, 1, $i29
    ble     $i29, 4, ble.22175
.count dual_jmp
    b       bg.22159
bg.22174:
    fmul    $f1, $fc2, $f14             # |        107 |        107 |
    load    [$i20 + 119], $i19          # |        107 |        107 |
    jal     trace_diffuse_ray.2926, $ra4# |        107 |        107 |
    li      116, $i22                   # |        107 |        107 |
.count move_args
    mov     $i26, $i21                  # |        107 |        107 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        107 |        107 |
    load    [$i28 + 4], $i1             # |        107 |        107 |
    load    [$i1 + $i23], $i1           # |        107 |        107 |
    load    [$i1 + 0], $f1              # |        107 |        107 |
    fmul    $f1, $fg1, $f1              # |        107 |        107 |
    fadd    $fg4, $f1, $fg4             # |        107 |        107 |
    load    [$i1 + 1], $f1              # |        107 |        107 |
    fmul    $f1, $fg2, $f1              # |        107 |        107 |
    fadd    $fg5, $f1, $fg5             # |        107 |        107 |
    load    [$i1 + 2], $f1              # |        107 |        107 |
    fmul    $f1, $fg3, $f1              # |        107 |        107 |
    fadd    $fg6, $f1, $fg6             # |        107 |        107 |
    add     $i23, 1, $i29               # |        107 |        107 |
    bg      $i29, 4, bg.22159           # |        107 |        107 |
ble.22175:
    load    [$i24 + $i29], $i1          # |        143 |        143 |
    bl      $i1, 0, bg.22159            # |        143 |        143 |
bge.22176:
    load    [$i25 + $i29], $i1          # |          1 |          1 |
    bne     $i1, 0, bne.22177           # |          1 |          1 |
be.22177:
    add     $i29, 1, $i23
    b       do_without_neighbors.2951
bne.22177:
.count move_args
    mov     $i28, $i23                  # |          1 |          1 |
.count move_args
    mov     $i29, $i24                  # |          1 |          1 |
    jal     calc_diffuse_using_1point.2942, $ra6# |          1 |          1 |
    add     $i29, 1, $i23               # |          1 |          1 |
    b       do_without_neighbors.2951   # |          1 |          1 |
bg.22159:
    jr      $ra7                        # |      2,429 |      2,429 |
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
    bg      $i28, 4, bg.22178           # |     15,923 |     15,923 |
ble.22178:
    load    [$i4 + $i2], $i1            # |     15,923 |     15,923 |
    load    [$i1 + 2], $i6              # |     15,923 |     15,923 |
    load    [$i6 + $i28], $i6           # |     15,923 |     15,923 |
    bl      $i6, 0, bg.22178            # |     15,923 |     15,923 |
bge.22179:
    load    [$i3 + $i2], $i7            # |      1,968 |      1,968 |
    load    [$i7 + 2], $i8              # |      1,968 |      1,968 |
    load    [$i8 + $i28], $i8           # |      1,968 |      1,968 |
    bne     $i8, $i6, bne.22180         # |      1,968 |      1,968 |
be.22180:
    load    [$i5 + $i2], $i8            # |      1,796 |      1,796 |
    load    [$i8 + 2], $i8              # |      1,796 |      1,796 |
    load    [$i8 + $i28], $i8           # |      1,796 |      1,796 |
    bne     $i8, $i6, bne.22180         # |      1,796 |      1,796 |
be.22181:
    add     $i2, -1, $i8                # |      1,700 |      1,700 |
    load    [$i4 + $i8], $i8            # |      1,700 |      1,700 |
    load    [$i8 + 2], $i8              # |      1,700 |      1,700 |
    load    [$i8 + $i28], $i8           # |      1,700 |      1,700 |
    bne     $i8, $i6, bne.22180         # |      1,700 |      1,700 |
be.22182:
    add     $i2, 1, $i8                 # |      1,634 |      1,634 |
    load    [$i4 + $i8], $i8            # |      1,634 |      1,634 |
    load    [$i8 + 2], $i8              # |      1,634 |      1,634 |
    load    [$i8 + $i28], $i8           # |      1,634 |      1,634 |
    bne     $i8, $i6, bne.22180         # |      1,634 |      1,634 |
be.22183:
    load    [$i1 + 3], $i1              # |      1,590 |      1,590 |
    load    [$i1 + $i28], $i1           # |      1,590 |      1,590 |
    bne     $i1, 0, bne.22188           # |      1,590 |      1,590 |
be.22188:
    add     $i28, 1, $i28               # |         26 |         26 |
    b       try_exploit_neighbors.2967  # |         26 |         26 |
bne.22188:
    load    [$i7 + 5], $i1              # |      1,564 |      1,564 |
    load    [$i1 + $i28], $i1           # |      1,564 |      1,564 |
    load    [$i1 + 0], $fg1             # |      1,564 |      1,564 |
    load    [$i1 + 1], $fg2             # |      1,564 |      1,564 |
    load    [$i1 + 2], $fg3             # |      1,564 |      1,564 |
    add     $i2, -1, $i1                # |      1,564 |      1,564 |
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
bne.22180:
    bg      $i28, 4, bg.22178           # |        378 |        378 |
ble.22185:
    load    [$i4 + $i2], $i29           # |        378 |        378 |
    load    [$i29 + 2], $i1             # |        378 |        378 |
    load    [$i1 + $i28], $i1           # |        378 |        378 |
    bl      $i1, 0, bg.22178            # |        378 |        378 |
bge.22186:
    load    [$i29 + 3], $i1             # |        378 |        378 |
    load    [$i1 + $i28], $i1           # |        378 |        378 |
    bne     $i1, 0, bne.22187           # |        378 |        378 |
be.22187:
    add     $i28, 1, $i23               # |         32 |         32 |
.count move_args
    mov     $i29, $i28                  # |         32 |         32 |
    b       do_without_neighbors.2951   # |         32 |         32 |
bne.22187:
.count move_args
    mov     $i29, $i23                  # |        346 |        346 |
.count move_args
    mov     $i28, $i24                  # |        346 |        346 |
    jal     calc_diffuse_using_1point.2942, $ra6# |        346 |        346 |
    add     $i28, 1, $i23               # |        346 |        346 |
.count move_args
    mov     $i29, $i28                  # |        346 |        346 |
    b       do_without_neighbors.2951   # |        346 |        346 |
bg.22178:
    jr      $ra7                        # |     13,955 |     13,955 |
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
    add     $sp, -1, $sp                # |          1 |          1 |
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
    add     $sp, -1, $sp                # |     49,152 |     49,152 |
    li      255, $i4                    # |     49,152 |     49,152 |
    call    ext_int_of_float            # |     49,152 |     49,152 |
.count stack_load_ra
    load    [$sp + 0], $ra              # |     49,152 |     49,152 |
.count stack_move
    add     $sp, 1, $sp                 # |     49,152 |     49,152 |
    bg      $i1, $i4, bg.22193          # |     49,152 |     49,152 |
ble.22193:
    bl      $i1, 0, bl.22194            # |     33,363 |     33,363 |
bge.22194:
.count move_args
    mov     $i1, $i2                    # |     33,363 |     33,363 |
    b       ext_write                   # |     33,363 |     33,363 |
bl.22194:
    li      0, $i2
    b       ext_write
bg.22193:
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
    add     $sp, -1, $sp                # |     16,384 |     16,384 |
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
    bg      $i24, 4, bg.22197           # |     16,395 |     16,395 |
ble.22197:
    load    [$i23 + 2], $i25            # |     16,395 |     16,395 |
    load    [$i25 + $i24], $i1          # |     16,395 |     16,395 |
    bl      $i1, 0, bg.22197            # |     16,395 |     16,395 |
bge.22198:
    load    [$i23 + 3], $i26            # |      2,101 |      2,101 |
    load    [$i26 + $i24], $i1          # |      2,101 |      2,101 |
    bne     $i1, 0, bne.22199           # |      2,101 |      2,101 |
be.22199:
    add     $i24, 1, $i24               # |         67 |         67 |
    bg      $i24, 4, bg.22197           # |         67 |         67 |
ble.22200:
    load    [$i25 + $i24], $i1          # |         67 |         67 |
    bl      $i1, 0, bg.22197            # |         67 |         67 |
bge.22201:
    load    [$i26 + $i24], $i1          # |         11 |         11 |
    be      $i1, 0, be.22207            # |         11 |         11 |
bne.22202:
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
    add     $ig0, -1, $i1               # |          9 |          9 |
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
    bg      $f0, $f1, bg.22203          # |          9 |          9 |
ble.22203:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i23 + 5], $i1
    load    [$i1 + $i24], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i24, 1, $i24
    b       pretrace_diffuse_rays.2980
bg.22203:
    fmul    $f1, $fc2, $f14             # |          9 |          9 |
    load    [$i20 + 119], $i19          # |          9 |          9 |
    jal     trace_diffuse_ray.2926, $ra4# |          9 |          9 |
    li      116, $i22                   # |          9 |          9 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |          9 |          9 |
    load    [$i23 + 5], $i1             # |          9 |          9 |
    load    [$i1 + $i24], $i1           # |          9 |          9 |
    store   $fg1, [$i1 + 0]             # |          9 |          9 |
    store   $fg2, [$i1 + 1]             # |          9 |          9 |
    store   $fg3, [$i1 + 2]             # |          9 |          9 |
    add     $i24, 1, $i24               # |          9 |          9 |
    b       pretrace_diffuse_rays.2980  # |          9 |          9 |
bne.22199:
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
    add     $ig0, -1, $i1               # |      2,034 |      2,034 |
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
    bg      $f0, $f1, bg.22204          # |      2,034 |      2,034 |
ble.22204:
    load    [$i20 + 118], $i19          # |        293 |        293 |
    fmul    $f1, $fc1, $f14             # |        293 |        293 |
    jal     trace_diffuse_ray.2926, $ra4# |        293 |        293 |
    li      116, $i22                   # |        293 |        293 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |        293 |        293 |
    load    [$i23 + 5], $i30            # |        293 |        293 |
    load    [$i30 + $i24], $i1          # |        293 |        293 |
    store   $fg1, [$i1 + 0]             # |        293 |        293 |
    store   $fg2, [$i1 + 1]             # |        293 |        293 |
    store   $fg3, [$i1 + 2]             # |        293 |        293 |
    add     $i24, 1, $i24               # |        293 |        293 |
    ble     $i24, 4, ble.22205          # |        293 |        293 |
.count dual_jmp
    b       bg.22197
bg.22204:
    load    [$i20 + 119], $i19          # |      1,741 |      1,741 |
    fmul    $f1, $fc2, $f14             # |      1,741 |      1,741 |
    jal     trace_diffuse_ray.2926, $ra4# |      1,741 |      1,741 |
    li      116, $i22                   # |      1,741 |      1,741 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      1,741 |      1,741 |
    load    [$i23 + 5], $i30            # |      1,741 |      1,741 |
    load    [$i30 + $i24], $i1          # |      1,741 |      1,741 |
    store   $fg1, [$i1 + 0]             # |      1,741 |      1,741 |
    store   $fg2, [$i1 + 1]             # |      1,741 |      1,741 |
    store   $fg3, [$i1 + 2]             # |      1,741 |      1,741 |
    add     $i24, 1, $i24               # |      1,741 |      1,741 |
    bg      $i24, 4, bg.22197           # |      1,741 |      1,741 |
ble.22205:
    load    [$i25 + $i24], $i1          # |      2,034 |      2,034 |
    bl      $i1, 0, bg.22197            # |      2,034 |      2,034 |
bge.22206:
    load    [$i26 + $i24], $i1
    bne     $i1, 0, bne.22207
be.22207:
    add     $i24, 1, $i24               # |          2 |          2 |
    b       pretrace_diffuse_rays.2980  # |          2 |          2 |
bne.22207:
    mov     $f0, $fg1
    mov     $f0, $fg2
    mov     $f0, $fg3
    load    [$i29 + $i24], $i2
    load    [$i2 + 0], $fg8
    load    [$i2 + 1], $fg9
    load    [$i2 + 2], $fg10
    add     $ig0, -1, $i1
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
    bg      $f0, $f1, bg.22208
ble.22208:
    fmul    $f1, $fc1, $f14
    load    [$i20 + 118], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i30 + $i24], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i24, 1, $i24
    b       pretrace_diffuse_rays.2980
bg.22208:
    fmul    $f1, $fc2, $f14
    load    [$i20 + 119], $i19
    jal     trace_diffuse_ray.2926, $ra4
    li      116, $i22
    jal     iter_trace_diffuse_rays.2929, $ra5
    load    [$i30 + $i24], $i1
    store   $fg1, [$i1 + 0]
    store   $fg2, [$i1 + 1]
    store   $fg3, [$i1 + 2]
    add     $i24, 1, $i24
    b       pretrace_diffuse_rays.2980
bg.22197:
    jr      $ra6                        # |     16,384 |     16,384 |
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
    bl      $i32, 0, bl.22209           # |     16,512 |     16,512 |
bge.22209:
.count stack_move
    add     $sp, -2, $sp                # |     16,384 |     16,384 |
.count stack_store
    store   $f2, [$sp + 0]              # |     16,384 |     16,384 |
.count stack_store
    store   $f1, [$sp + 1]              # |     16,384 |     16,384 |
    add     $i32, -64, $i2              # |     16,384 |     16,384 |
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
.count move_args
    mov     $f0, $f17                   # |     16,384 |     16,384 |
.count move_args
    mov     $fc0, $f16                  # |     16,384 |     16,384 |
    li      0, $i23                     # |     16,384 |     16,384 |
    li      ext_ptrace_dirvec, $i24     # |     16,384 |     16,384 |
    mov     $f0, $fg6                   # |     16,384 |     16,384 |
    mov     $f0, $fg5                   # |     16,384 |     16,384 |
    mov     $f0, $fg4                   # |     16,384 |     16,384 |
    bne     $f2, $f0, bne.22211         # |     16,384 |     16,384 |
be.22211:
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
    load    [$i31 + $i32], $i25
    jal     trace_ray.2920, $ra5
    load    [$i31 + $i32], $i1
    load    [$i1 + 0], $i1
    store   $fg4, [$i1 + 0]
    store   $fg5, [$i1 + 1]
    store   $fg6, [$i1 + 2]
    load    [$i31 + $i32], $i1
    load    [$i1 + 6], $i1
    store   $i33, [$i1 + 0]
    load    [$i31 + $i32], $i23
    load    [$i23 + 2], $i1
    load    [$i1 + 0], $i1
    bge     $i1, 0, bge.22212
.count dual_jmp
    b       bl.22212
bne.22211:
    finv    $f2, $f2                    # |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 0]# |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 1], $f1# |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 1]# |     16,384 |     16,384 |
    load    [ext_ptrace_dirvec + 2], $f1# |     16,384 |     16,384 |
    fmul    $f1, $f2, $f1               # |     16,384 |     16,384 |
    store   $f1, [ext_ptrace_dirvec + 2]# |     16,384 |     16,384 |
    load    [ext_viewpoint + 0], $fg17  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 1], $fg18  # |     16,384 |     16,384 |
    load    [ext_viewpoint + 2], $fg19  # |     16,384 |     16,384 |
    load    [$i31 + $i32], $i25         # |     16,384 |     16,384 |
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
    bl      $i1, 0, bl.22212            # |     16,384 |     16,384 |
bge.22212:
    load    [$i23 + 3], $i1             # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    bne     $i1, 0, bne.22213           # |     16,384 |     16,384 |
be.22213:
    li      1, $i24                     # |      7,301 |      7,301 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      7,301 |      7,301 |
.count stack_move
    add     $sp, 2, $sp                 # |      7,301 |      7,301 |
    add     $i32, -1, $i32              # |      7,301 |      7,301 |
    add     $i33, 1, $i33               # |      7,301 |      7,301 |
    bge     $i33, 5, bge.22216          # |      7,301 |      7,301 |
.count dual_jmp
    b       bl.22216                    # |      5,841 |      5,841 |
bne.22213:
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
    add     $ig0, -1, $i1               # |      9,083 |      9,083 |
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
    bg      $f0, $f1, bg.22214          # |      9,083 |      9,083 |
ble.22214:
    fmul    $f1, $fc1, $f14             # |         14 |         14 |
    load    [$i20 + 118], $i19          # |         14 |         14 |
    jal     trace_diffuse_ray.2926, $ra4# |         14 |         14 |
    li      116, $i22                   # |         14 |         14 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |         14 |         14 |
    load    [$i23 + 5], $i1             # |         14 |         14 |
    load    [$i1 + 0], $i1              # |         14 |         14 |
    store   $fg1, [$i1 + 0]             # |         14 |         14 |
    store   $fg2, [$i1 + 1]             # |         14 |         14 |
    store   $fg3, [$i1 + 2]             # |         14 |         14 |
    li      1, $i24                     # |         14 |         14 |
    jal     pretrace_diffuse_rays.2980, $ra6# |         14 |         14 |
.count stack_move
    add     $sp, 2, $sp                 # |         14 |         14 |
    add     $i32, -1, $i32              # |         14 |         14 |
    add     $i33, 1, $i33               # |         14 |         14 |
    bge     $i33, 5, bge.22216          # |         14 |         14 |
.count dual_jmp
    b       bl.22216                    # |         13 |         13 |
bg.22214:
    fmul    $f1, $fc2, $f14             # |      9,069 |      9,069 |
    load    [$i20 + 119], $i19          # |      9,069 |      9,069 |
    jal     trace_diffuse_ray.2926, $ra4# |      9,069 |      9,069 |
    li      116, $i22                   # |      9,069 |      9,069 |
    jal     iter_trace_diffuse_rays.2929, $ra5# |      9,069 |      9,069 |
    load    [$i23 + 5], $i1             # |      9,069 |      9,069 |
    load    [$i1 + 0], $i1              # |      9,069 |      9,069 |
    store   $fg1, [$i1 + 0]             # |      9,069 |      9,069 |
    store   $fg2, [$i1 + 1]             # |      9,069 |      9,069 |
    store   $fg3, [$i1 + 2]             # |      9,069 |      9,069 |
    li      1, $i24                     # |      9,069 |      9,069 |
    jal     pretrace_diffuse_rays.2980, $ra6# |      9,069 |      9,069 |
.count stack_move
    add     $sp, 2, $sp                 # |      9,069 |      9,069 |
    add     $i32, -1, $i32              # |      9,069 |      9,069 |
    add     $i33, 1, $i33               # |      9,069 |      9,069 |
    bge     $i33, 5, bge.22216          # |      9,069 |      9,069 |
.count dual_jmp
    b       bl.22216                    # |      7,253 |      7,253 |
bl.22212:
.count stack_move
    add     $sp, 2, $sp
    add     $i32, -1, $i32
    add     $i33, 1, $i33
    bl      $i33, 5, bl.22216
bge.22216:
    add     $i33, -5, $i33              # |      3,277 |      3,277 |
.count stack_load
    load    [$sp - 2], $f2              # |      3,277 |      3,277 |
.count move_args
    mov     $i34, $f1                   # |      3,277 |      3,277 |
    b       pretrace_pixels.2983        # |      3,277 |      3,277 |
bl.22216:
.count stack_load
    load    [$sp - 2], $f2              # |     13,107 |     13,107 |
.count move_args
    mov     $i34, $f1                   # |     13,107 |     13,107 |
    b       pretrace_pixels.2983        # |     13,107 |     13,107 |
bl.22209:
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
    bg      $i1, $i30, bg.22217         # |     16,512 |     16,512 |
ble.22217:
    jr      $ra8                        # |        128 |        128 |
bg.22217:
    load    [$i33 + $i30], $i1          # |     16,384 |     16,384 |
    load    [$i1 + 0], $i1              # |     16,384 |     16,384 |
    load    [$i1 + 0], $fg4             # |     16,384 |     16,384 |
    load    [$i1 + 1], $fg5             # |     16,384 |     16,384 |
    load    [$i1 + 2], $fg6             # |     16,384 |     16,384 |
    li      128, $i1                    # |     16,384 |     16,384 |
    add     $i31, 1, $i2                # |     16,384 |     16,384 |
    ble     $i1, $i2, ble.22221         # |     16,384 |     16,384 |
bg.22218:
    ble     $i31, 0, ble.22221          # |     16,256 |     16,256 |
bg.22219:
    li      128, $i1                    # |     16,128 |     16,128 |
    add     $i30, 1, $i2                # |     16,128 |     16,128 |
    ble     $i1, $i2, ble.22221         # |     16,128 |     16,128 |
bg.22220:
    bg      $i30, 0, bg.22221           # |     16,002 |     16,002 |
ble.22221:
    li      0, $i1                      # |        508 |        508 |
    load    [$i33 + $i30], $i28         # |        508 |        508 |
    li      0, $i24                     # |        508 |        508 |
    load    [$i28 + 2], $i1             # |        508 |        508 |
    load    [$i1 + 0], $i1              # |        508 |        508 |
    bge     $i1, 0, bge.22231           # |        508 |        508 |
.count dual_jmp
    b       bl.22225
bg.22221:
    li      1, $i1                      # |     15,876 |     15,876 |
    li      0, $i24                     # |     15,876 |     15,876 |
    load    [$i33 + $i30], $i1          # |     15,876 |     15,876 |
    load    [$i1 + 2], $i2              # |     15,876 |     15,876 |
    load    [$i2 + 0], $i2              # |     15,876 |     15,876 |
    bl      $i2, 0, bl.22225            # |     15,876 |     15,876 |
bge.22225:
    load    [$i32 + $i30], $i3          # |     15,876 |     15,876 |
    load    [$i3 + 2], $i4              # |     15,876 |     15,876 |
    load    [$i4 + 0], $i4              # |     15,876 |     15,876 |
    bne     $i4, $i2, bne.22226         # |     15,876 |     15,876 |
be.22226:
    load    [$i34 + $i30], $i4          # |     15,253 |     15,253 |
    load    [$i4 + 2], $i4              # |     15,253 |     15,253 |
    load    [$i4 + 0], $i4              # |     15,253 |     15,253 |
    bne     $i4, $i2, bne.22226         # |     15,253 |     15,253 |
be.22227:
    add     $i30, -1, $i4               # |     14,657 |     14,657 |
    load    [$i33 + $i4], $i4           # |     14,657 |     14,657 |
    load    [$i4 + 2], $i4              # |     14,657 |     14,657 |
    load    [$i4 + 0], $i4              # |     14,657 |     14,657 |
    bne     $i4, $i2, bne.22226         # |     14,657 |     14,657 |
be.22228:
    add     $i30, 1, $i4                # |     14,497 |     14,497 |
    load    [$i33 + $i4], $i4           # |     14,497 |     14,497 |
    load    [$i4 + 2], $i4              # |     14,497 |     14,497 |
    load    [$i4 + 0], $i4              # |     14,497 |     14,497 |
    bne     $i4, $i2, bne.22226         # |     14,497 |     14,497 |
be.22229:
    load    [$i1 + 3], $i1              # |     14,333 |     14,333 |
    load    [$i1 + 0], $i1              # |     14,333 |     14,333 |
.count move_args
    mov     $i34, $i5                   # |     14,333 |     14,333 |
.count move_args
    mov     $i33, $i4                   # |     14,333 |     14,333 |
.count move_args
    mov     $i30, $i2                   # |     14,333 |     14,333 |
    li      1, $i28                     # |     14,333 |     14,333 |
    bne     $i1, 0, bne.22233           # |     14,333 |     14,333 |
be.22233:
.count move_args
    mov     $i32, $i3                   # |      6,640 |      6,640 |
    jal     try_exploit_neighbors.2967, $ra7# |      6,640 |      6,640 |
    call    write_rgb.2978              # |      6,640 |      6,640 |
    add     $i30, 1, $i30               # |      6,640 |      6,640 |
    b       scan_pixel.2994             # |      6,640 |      6,640 |
bne.22233:
    load    [$i3 + 5], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $i1              # |      7,693 |      7,693 |
    load    [$i1 + 0], $fg1             # |      7,693 |      7,693 |
    load    [$i1 + 1], $fg2             # |      7,693 |      7,693 |
    load    [$i1 + 2], $fg3             # |      7,693 |      7,693 |
    add     $i30, -1, $i1               # |      7,693 |      7,693 |
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
    call    write_rgb.2978              # |      7,693 |      7,693 |
    add     $i30, 1, $i30               # |      7,693 |      7,693 |
    b       scan_pixel.2994             # |      7,693 |      7,693 |
bne.22226:
    load    [$i33 + $i30], $i28         # |      1,543 |      1,543 |
    load    [$i28 + 2], $i1             # |      1,543 |      1,543 |
    load    [$i1 + 0], $i1              # |      1,543 |      1,543 |
    bl      $i1, 0, bl.22225            # |      1,543 |      1,543 |
bge.22231:
    load    [$i28 + 3], $i1             # |      2,051 |      2,051 |
    load    [$i1 + 0], $i1              # |      2,051 |      2,051 |
    bne     $i1, 0, bne.22232           # |      2,051 |      2,051 |
be.22232:
    li      1, $i23                     # |        661 |        661 |
    jal     do_without_neighbors.2951, $ra7# |        661 |        661 |
    call    write_rgb.2978              # |        661 |        661 |
    add     $i30, 1, $i30               # |        661 |        661 |
    b       scan_pixel.2994             # |        661 |        661 |
bne.22232:
.count move_args
    mov     $i28, $i23                  # |      1,390 |      1,390 |
    jal     calc_diffuse_using_1point.2942, $ra6# |      1,390 |      1,390 |
    li      1, $i23                     # |      1,390 |      1,390 |
    jal     do_without_neighbors.2951, $ra7# |      1,390 |      1,390 |
    call    write_rgb.2978              # |      1,390 |      1,390 |
    add     $i30, 1, $i30               # |      1,390 |      1,390 |
    b       scan_pixel.2994             # |      1,390 |      1,390 |
bl.22225:
    call    write_rgb.2978
    add     $i30, 1, $i30
    b       scan_pixel.2994
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
    bg      $i1, $i35, bg.22234         # |        129 |        129 |
ble.22234:
    jr      $ra9                        # |          1 |          1 |
bg.22234:
    bl      $i35, 127, bl.22235         # |        128 |        128 |
bge.22235:
    li      0, $i30                     # |          1 |          1 |
.count move_args
    mov     $i35, $i31                  # |          1 |          1 |
.count move_args
    mov     $i36, $i32                  # |          1 |          1 |
.count move_args
    mov     $i37, $i33                  # |          1 |          1 |
.count move_args
    mov     $i38, $i34                  # |          1 |          1 |
    jal     scan_pixel.2994, $ra8       # |          1 |          1 |
    add     $i35, 1, $i35               # |          1 |          1 |
    add     $i39, 2, $i39               # |          1 |          1 |
    bge     $i39, 5, bge.22236          # |          1 |          1 |
.count dual_jmp
    b       bl.22236                    # |          1 |          1 |
bl.22235:
    add     $i35, 1, $i1                # |        127 |        127 |
    add     $i1, -64, $i2               # |        127 |        127 |
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
    li      0, $i30                     # |        127 |        127 |
.count move_args
    mov     $i35, $i31                  # |        127 |        127 |
.count move_args
    mov     $i36, $i32                  # |        127 |        127 |
.count move_args
    mov     $i37, $i33                  # |        127 |        127 |
.count move_args
    mov     $i38, $i34                  # |        127 |        127 |
    jal     scan_pixel.2994, $ra8       # |        127 |        127 |
    add     $i35, 1, $i35               # |        127 |        127 |
    add     $i39, 2, $i39               # |        127 |        127 |
    bl      $i39, 5, bl.22236           # |        127 |        127 |
bge.22236:
    add     $i39, -5, $i39              # |         51 |         51 |
.count move_args
    mov     $i36, $tmp                  # |         51 |         51 |
.count move_args
    mov     $i37, $i36                  # |         51 |         51 |
.count move_args
    mov     $i38, $i37                  # |         51 |         51 |
.count move_args
    mov     $tmp, $i38                  # |         51 |         51 |
    b       scan_line.3000              # |         51 |         51 |
bl.22236:
.count move_args
    mov     $i36, $tmp                  # |         77 |         77 |
.count move_args
    mov     $i37, $i36                  # |         77 |         77 |
.count move_args
    mov     $i38, $i37                  # |         77 |         77 |
.count move_args
    mov     $tmp, $i38                  # |         77 |         77 |
    b       scan_line.3000              # |         77 |         77 |
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
    bl      $i13, 0, bl.22237           # |        384 |        384 |
bge.22237:
    jal     create_pixel.3008, $ra2     # |        381 |        381 |
.count storer
    add     $i12, $i13, $tmp            # |        381 |        381 |
    store   $i1, [$tmp + 0]             # |        381 |        381 |
    add     $i13, -1, $i13              # |        381 |        381 |
    b       init_line_elements.3010     # |        381 |        381 |
bl.22237:
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
    bl      $i1, 5, bl.22238            # |        600 |        600 |
bge.22238:
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
bl.22238:
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
    bl      $i5, 0, bl.22239            # |         10 |         10 |
bge.22239:
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
    add     $i5, -1, $i5                # |         10 |         10 |
    bl      $i5, 0, bl.22239            # |         10 |         10 |
bge.22240:
    li      0, $i1                      # |         10 |         10 |
    add     $i6, 1, $i2                 # |         10 |         10 |
    bl      $i2, 5, bl.22241            # |         10 |         10 |
bge.22241:
    add     $i2, -5, $i6                # |          2 |          2 |
.count move_args
    mov     $i5, $i2                    # |          2 |          2 |
    call    ext_float_of_int            # |          2 |          2 |
    fmul    $f1, $f15, $f16             # |          2 |          2 |
    fsub    $f16, $fc11, $f9            # |          2 |          2 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
.count move_args
    mov     $f14, $f10                  # |          2 |          2 |
.count move_args
    mov     $i6, $i3                    # |          2 |          2 |
.count move_args
    mov     $i7, $i4                    # |          2 |          2 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |
    li      0, $i1                      # |          2 |          2 |
    fadd    $f16, $fc9, $f9             # |          2 |          2 |
.count move_args
    mov     $f0, $f1                    # |          2 |          2 |
.count move_args
    mov     $f0, $f2                    # |          2 |          2 |
.count move_args
    mov     $f14, $f10                  # |          2 |          2 |
.count move_args
    mov     $i6, $i3                    # |          2 |          2 |
.count move_args
    mov     $i8, $i4                    # |          2 |          2 |
    jal     calc_dirvec.3020, $ra1      # |          2 |          2 |
    add     $i5, -1, $i5                # |          2 |          2 |
    bge     $i5, 0, bge.22242           # |          2 |          2 |
.count dual_jmp
    b       bl.22239                    # |          1 |          1 |
bl.22241:
    mov     $i2, $i6                    # |          8 |          8 |
.count move_args
    mov     $i5, $i2                    # |          8 |          8 |
    call    ext_float_of_int            # |          8 |          8 |
    fmul    $f1, $f15, $f16             # |          8 |          8 |
    fsub    $f16, $fc11, $f9            # |          8 |          8 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |
.count move_args
    mov     $f14, $f10                  # |          8 |          8 |
.count move_args
    mov     $i6, $i3                    # |          8 |          8 |
.count move_args
    mov     $i7, $i4                    # |          8 |          8 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |
    li      0, $i1                      # |          8 |          8 |
    fadd    $f16, $fc9, $f9             # |          8 |          8 |
.count move_args
    mov     $f0, $f1                    # |          8 |          8 |
.count move_args
    mov     $f0, $f2                    # |          8 |          8 |
.count move_args
    mov     $f14, $f10                  # |          8 |          8 |
.count move_args
    mov     $i6, $i3                    # |          8 |          8 |
.count move_args
    mov     $i8, $i4                    # |          8 |          8 |
    jal     calc_dirvec.3020, $ra1      # |          8 |          8 |
    add     $i5, -1, $i5                # |          8 |          8 |
    bl      $i5, 0, bl.22239            # |          8 |          8 |
bge.22242:
    li      0, $i1                      # |          5 |          5 |
    add     $i6, 1, $i2                 # |          5 |          5 |
    bl      $i2, 5, bl.22243            # |          5 |          5 |
bge.22243:
    add     $i2, -5, $i6                # |          1 |          1 |
.count move_args
    mov     $i5, $i2                    # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $f15, $f16             # |          1 |          1 |
    fsub    $f16, $fc11, $f9            # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i7, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    fadd    $f16, $fc9, $f9             # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i8, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    add     $i5, -1, $i5                # |          1 |          1 |
    bge     $i5, 0, bge.22244           # |          1 |          1 |
.count dual_jmp
    b       bl.22239                    # |          1 |          1 |
bl.22243:
    mov     $i2, $i6                    # |          4 |          4 |
.count move_args
    mov     $i5, $i2                    # |          4 |          4 |
    call    ext_float_of_int            # |          4 |          4 |
    fmul    $f1, $f15, $f16             # |          4 |          4 |
    fsub    $f16, $fc11, $f9            # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i7, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      0, $i1                      # |          4 |          4 |
    fadd    $f16, $fc9, $f9             # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i8, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    add     $i5, -1, $i5                # |          4 |          4 |
    bl      $i5, 0, bl.22239            # |          4 |          4 |
bge.22244:
    li      0, $i1
    add     $i6, 1, $i2
    bl      $i2, 5, bl.22245
bge.22245:
    add     $i2, -5, $i6
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
    add     $i5, -1, $i5
    add     $i6, 1, $i6
    bl      $i6, 5, calc_dirvecs.3028
.count dual_jmp
    b       bge.22246
bl.22245:
    mov     $i2, $i6
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
    add     $i5, -1, $i5
    add     $i6, 1, $i6
    bl      $i6, 5, calc_dirvecs.3028
bge.22246:
    add     $i6, -5, $i6
    b       calc_dirvecs.3028
bl.22239:
    jr      $ra2                        # |         10 |         10 |
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
    bl      $i9, 0, bl.22247            # |          5 |          5 |
bge.22247:
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
.count move_args
    mov     $i11, $i4                   # |          5 |          5 |
.count move_args
    mov     $f14, $f10                  # |          5 |          5 |
.count move_args
    mov     $fc18, $f9                  # |          5 |          5 |
.count move_args
    mov     $f0, $f2                    # |          5 |          5 |
.count move_args
    mov     $f0, $f1                    # |          5 |          5 |
    bl      $i2, 5, bl.22248            # |          5 |          5 |
bge.22248:
    add     $i2, -5, $i6                # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc17, $f9                  # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i6, 1, $i2                 # |          1 |          1 |
    bge     $i2, 5, bge.22249           # |          1 |          1 |
.count dual_jmp
    b       bl.22249                    # |          1 |          1 |
bl.22248:
    mov     $i2, $i6                    # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
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
    li      0, $i1                      # |          4 |          4 |
    add     $i6, 1, $i2                 # |          4 |          4 |
    bl      $i2, 5, bl.22249            # |          4 |          4 |
bge.22249:
    add     $i2, -5, $i6                # |          1 |          1 |
.count load_float
    load    [f.21565], $f9              # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc4, $f9                   # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      1, $i5                      # |          1 |          1 |
    add     $i6, 1, $i1                 # |          1 |          1 |
    bge     $i1, 5, bge.22250           # |          1 |          1 |
.count dual_jmp
    b       bl.22250                    # |          1 |          1 |
bl.22249:
    mov     $i2, $i6                    # |          4 |          4 |
.count load_float
    load    [f.21565], $f9              # |          4 |          4 |
.count move_args
    mov     $f0, $f1                    # |          4 |          4 |
.count move_args
    mov     $f0, $f2                    # |          4 |          4 |
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
    mov     $fc4, $f9                   # |          4 |          4 |
.count move_args
    mov     $f14, $f10                  # |          4 |          4 |
.count move_args
    mov     $i6, $i3                    # |          4 |          4 |
.count move_args
    mov     $i5, $i4                    # |          4 |          4 |
    jal     calc_dirvec.3020, $ra1      # |          4 |          4 |
    li      1, $i5                      # |          4 |          4 |
    add     $i6, 1, $i1                 # |          4 |          4 |
    bl      $i1, 5, bl.22250            # |          4 |          4 |
bge.22250:
    add     $i1, -5, $i6                # |          1 |          1 |
.count move_args
    mov     $i11, $i7                   # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    add     $i9, -1, $i9                # |          1 |          1 |
    bge     $i9, 0, bge.22251           # |          1 |          1 |
.count dual_jmp
    b       bl.22247
bl.22250:
    mov     $i1, $i6                    # |          4 |          4 |
.count move_args
    mov     $i11, $i7                   # |          4 |          4 |
    jal     calc_dirvecs.3028, $ra2     # |          4 |          4 |
    add     $i9, -1, $i9                # |          4 |          4 |
    bl      $i9, 0, bl.22247            # |          4 |          4 |
bge.22251:
    add     $i10, 2, $i1                # |          4 |          4 |
.count move_args
    mov     $i9, $i2                    # |          4 |          4 |
    add     $i11, 4, $i11               # |          4 |          4 |
    bl      $i1, 5, bl.22252            # |          4 |          4 |
bge.22252:
    add     $i1, -5, $i10               # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    call    ext_float_of_int            # |          1 |          1 |
    fmul    $f1, $f17, $f1              # |          1 |          1 |
    fsub    $f1, $fc11, $f14            # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc19, $f9                  # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i10, $i3                   # |          1 |          1 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i11, 2, $i5                # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc11, $f9                  # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i10, $i3                   # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
    add     $i10, 1, $i2                # |          1 |          1 |
    bge     $i2, 5, bge.22253           # |          1 |          1 |
.count dual_jmp
    b       bl.22253                    # |          1 |          1 |
bl.22252:
    mov     $i1, $i10                   # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    call    ext_float_of_int            # |          3 |          3 |
    fmul    $f1, $f17, $f1              # |          3 |          3 |
    fsub    $f1, $fc11, $f14            # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $fc19, $f9                  # |          3 |          3 |
.count move_args
    mov     $f14, $f10                  # |          3 |          3 |
.count move_args
    mov     $i10, $i3                   # |          3 |          3 |
.count move_args
    mov     $i11, $i4                   # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    add     $i11, 2, $i5                # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $fc11, $f9                  # |          3 |          3 |
.count move_args
    mov     $f14, $f10                  # |          3 |          3 |
.count move_args
    mov     $i10, $i3                   # |          3 |          3 |
.count move_args
    mov     $i5, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
    add     $i10, 1, $i2                # |          3 |          3 |
    bl      $i2, 5, bl.22253            # |          3 |          3 |
bge.22253:
    add     $i2, -5, $i6                # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc18, $f9                  # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i11, $i4                   # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      0, $i1                      # |          1 |          1 |
.count move_args
    mov     $f0, $f1                    # |          1 |          1 |
.count move_args
    mov     $f0, $f2                    # |          1 |          1 |
.count move_args
    mov     $fc17, $f9                  # |          1 |          1 |
.count move_args
    mov     $f14, $f10                  # |          1 |          1 |
.count move_args
    mov     $i6, $i3                    # |          1 |          1 |
.count move_args
    mov     $i5, $i4                    # |          1 |          1 |
    jal     calc_dirvec.3020, $ra1      # |          1 |          1 |
    li      2, $i5                      # |          1 |          1 |
    add     $i6, 1, $i1                 # |          1 |          1 |
    bge     $i1, 5, bge.22254           # |          1 |          1 |
.count dual_jmp
    b       bl.22254                    # |          1 |          1 |
bl.22253:
    mov     $i2, $i6                    # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $fc18, $f9                  # |          3 |          3 |
.count move_args
    mov     $f14, $f10                  # |          3 |          3 |
.count move_args
    mov     $i6, $i3                    # |          3 |          3 |
.count move_args
    mov     $i11, $i4                   # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      0, $i1                      # |          3 |          3 |
.count move_args
    mov     $f0, $f1                    # |          3 |          3 |
.count move_args
    mov     $f0, $f2                    # |          3 |          3 |
.count move_args
    mov     $fc17, $f9                  # |          3 |          3 |
.count move_args
    mov     $f14, $f10                  # |          3 |          3 |
.count move_args
    mov     $i6, $i3                    # |          3 |          3 |
.count move_args
    mov     $i5, $i4                    # |          3 |          3 |
    jal     calc_dirvec.3020, $ra1      # |          3 |          3 |
    li      2, $i5                      # |          3 |          3 |
    add     $i6, 1, $i1                 # |          3 |          3 |
    bl      $i1, 5, bl.22254            # |          3 |          3 |
bge.22254:
    add     $i1, -5, $i6                # |          1 |          1 |
.count move_args
    mov     $i11, $i7                   # |          1 |          1 |
    jal     calc_dirvecs.3028, $ra2     # |          1 |          1 |
    add     $i9, -1, $i9                # |          1 |          1 |
    add     $i10, 2, $i10               # |          1 |          1 |
    bge     $i10, 5, bge.22255          # |          1 |          1 |
.count dual_jmp
    b       bl.22255
bl.22254:
    mov     $i1, $i6                    # |          3 |          3 |
.count move_args
    mov     $i11, $i7                   # |          3 |          3 |
    jal     calc_dirvecs.3028, $ra2     # |          3 |          3 |
    add     $i9, -1, $i9                # |          3 |          3 |
    add     $i10, 2, $i10               # |          3 |          3 |
    bl      $i10, 5, bl.22255           # |          3 |          3 |
bge.22255:
    add     $i10, -5, $i10              # |          2 |          2 |
    add     $i11, 4, $i11               # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bl.22255:
    add     $i11, 4, $i11               # |          2 |          2 |
    b       calc_dirvec_rows.3033       # |          2 |          2 |
bl.22247:
    jr      $ra3                        # |          1 |          1 |
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
    bl      $i6, 0, bl.22256            # |        600 |        600 |
bge.22256:
    jal     create_dirvec.3037, $ra1    # |        595 |        595 |
.count storer
    add     $i5, $i6, $tmp              # |        595 |        595 |
    store   $i1, [$tmp + 0]             # |        595 |        595 |
    add     $i6, -1, $i6                # |        595 |        595 |
    b       create_dirvec_elements.3039 # |        595 |        595 |
bl.22256:
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
    bl      $i7, 0, bl.22257            # |          6 |          6 |
bge.22257:
    jal     create_dirvec.3037, $ra1    # |          5 |          5 |
    li      120, $i2                    # |          5 |          5 |
.count move_args
    mov     $i1, $i3                    # |          5 |          5 |
    call    ext_create_array_int        # |          5 |          5 |
    store   $i1, [ext_dirvecs + $i7]    # |          5 |          5 |
    load    [ext_dirvecs + $i7], $i5    # |          5 |          5 |
    li      118, $i6                    # |          5 |          5 |
    jal     create_dirvec_elements.3039, $ra2# |          5 |          5 |
    add     $i7, -1, $i7                # |          5 |          5 |
    b       create_dirvecs.3042         # |          5 |          5 |
bl.22257:
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
    bl      $i11, 0, bl.22258           # |        605 |        605 |
bge.22258:
    load    [$i10 + $i11], $i7          # |        600 |        600 |
    jal     setup_dirvec_constants.2829, $ra2# |        600 |        600 |
    add     $i11, -1, $i11              # |        600 |        600 |
    b       init_dirvec_constants.3044  # |        600 |        600 |
bl.22258:
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
    bl      $i12, 0, bl.22259           # |          6 |          6 |
bge.22259:
    load    [ext_dirvecs + $i12], $i10  # |          5 |          5 |
    li      119, $i11                   # |          5 |          5 |
    jal     init_dirvec_constants.3044, $ra3# |          5 |          5 |
    add     $i12, -1, $i12              # |          5 |          5 |
    b       init_vecset_constants.3047  # |          5 |          5 |
bl.22259:
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
    bl      $i1, 0, bl.22260            # |          1 |          1 |
bge.22260:
    load    [ext_objects + $i1], $i2    # |          1 |          1 |
    load    [$i2 + 2], $i3              # |          1 |          1 |
    bne     $i3, 2, bl.22260            # |          1 |          1 |
be.22261:
    load    [$i2 + 7], $i3              # |          1 |          1 |
    load    [$i3 + 0], $f1              # |          1 |          1 |
    ble     $fc0, $f1, bl.22260         # |          1 |          1 |
bg.22262:
    load    [$i2 + 1], $i3              # |          1 |          1 |
    be      $i3, 1, setup_rect_reflection.3058# |          1 |          1 |
bne.22263:
    be      $i3, 2, setup_surface_reflection.3061# |          1 |          1 |
bl.22260:
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
    add     $ig0, -1, $i1               # |          1 |          1 |
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
    add     $sp, -1, $sp                # |          1 |          1 |
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
